#!/usr/bin/env python3
"""Generate LuaLS ---@meta stubs from MOOSE's LuaDoc-annotated source.

usage: _generate.py <MOOSE repo>/"Moose Development"/Moose  <output dir>
Re-run after a MOOSE update; output mirrors the MOOSE folder layout.
"""
import re, sys
from pathlib import Path

src, out = Path(sys.argv[1]), Path(sys.argv[2]).resolve()

BUILTIN = {"string", "number", "boolean", "table", "function", "nil", "any", "userdata", "thread"}


def conv(t):
    """LuaDoc type -> LuaLS type."""
    t = t.strip().strip("()")
    if not t:
        return "any"
    parts = re.split(r"\s*\|\s*", t)
    return "|".join(conv1(p) for p in parts)


def conv1(t):
    t = t.strip()
    m = re.match(r"^#?(?:list|table)\s*<(.*)>$", t)
    if m:
        inner = m.group(1)
        if "," in inner and not re.search(r"<", inner):
            k, v = inner.split(",", 1)
            return f"table<{conv(k)},{conv(v)}>"
        return conv(inner) + "[]"
    t = t.rsplit("#", 1)[-1]          # Core.Zone#ZONE -> ZONE, #string -> string
    if t == "DCS":
        return "any"
    t = t.replace("..", "")
    t = {"bool": "boolean", "boolen": "boolean", "func": "function", "list": "table", "nothing": "nil",
         "Duration": "number", "Speed": "number", "Distance": "number", "Time": "number"}.get(t, t)
    if not re.match(r"^[A-Za-z_][\w.]*$", t):
        return "any"
    return t if t not in ("Function", "Table") else t.lower()


def clean_desc(lines):
    return [l for l in lines]


def parse_block(block):
    """block: raw comment lines -> dict(desc, tags)."""
    desc, tags = [], []
    cur = None
    for raw in block:
        l = re.sub(r"^\s*--+\s?", "", raw.rstrip())
        m = re.match(r"^\s*@(\w+)\s*(.*)$", l)
        if m:
            cur = [m.group(1), m.group(2)]
            tags.append(cur)
        elif cur is not None and l.strip() and cur[0] in ("param", "return", "field"):
            cur[1] += " " + l.strip()
        elif cur is None:
            desc.append(l)
    return desc, tags


def doc(desc):
    d = [l.replace("@{", "{") for l in desc]
    while d and not d[0].strip():
        d.pop(0)
    while d and not d[-1].strip():
        d.pop()
    return "\n".join(f"---{l}" if l.strip() else "---" for l in d)


def esc(s):
    return s.replace("\n", " ").strip()


def class_decl(name, desc, tags, fields):
    ext = [conv(t[1].split()[0]) for t in tags if t[0] == "extends" and t[1].split()]
    head = f"---@class {name}" + (f" : {ext[0]}" if ext else "")
    lines = [head]
    for f in fields:
        lines.append(f)
    return lines


def func_stub(desc, tags, sig):
    m = re.match(r"^function\s+([\w.:]+)\s*\(([^)]*)\)", sig)
    name, args = m.group(1), [a.strip() for a in m.group(2).split(",") if a.strip()]
    params = {}
    for t, body in tags:
        if t == "param":
            pm = re.match(r"^(\S+)\s+(\.\.\.|[\w]+)\s*(.*)$", body)
            if pm:
                params[pm.group(2)] = (pm.group(1), pm.group(3))
    lines = [doc(desc)] if any(l.strip() for l in desc) else []
    for a in args:
        if a == "...":
            lines.append("---@param ... any")
            continue
        ty, d = params.get(a, ("any", ""))
        # MOOSE rarely marks optional params, and Lua accepts missing args: make all optional
        opt = "" if a == "self" else "?"
        ty = conv(re.sub(r"\(?optional\)?", "", ty, flags=re.I))
        if "Categor" in a:                  # docs say DCS#Unit etc. where a category enum is meant
            ty = "any"
        if "." in ty or ty == "EVENTS":     # enum-like "types" are really number/string values
            ty += "|number|string"
        lines.append(f"---@param {a}{opt} {ty} {esc(d)}".rstrip())
    for t, body in tags:
        if t == "return":
            rm = re.match(r"^(\S+)\s*(.*)$", body)
            if rm:
                rt, rd = conv(rm.group(1)), esc(rm.group(2))
                # Task*/EnRoute* builders are documented as returning self but return a DCS task table
                if rd == "self" and re.search(r"[.:](Task|EnRoute)\w*$", name) and rt in ("CONTROLLABLE", "GROUP", "UNIT"):
                    rt, rd = "Task", "The DCS task table."
                lines.append(f"---@return {rt} # {rd}".rstrip(" #"))
    for t, body in tags:
        if t == "deprecated":
            lines.append("---@deprecated")
            break
    lines = [l for l in lines if l]
    return "\n".join(lines + [f"function {name}({', '.join(args)}) end"])


def balanced(lines, i):
    """Return index of line closing the brace opened on lines[i]."""
    depth = 0
    for j in range(i, len(lines)):
        s = re.sub(r'"[^"]*"|\'[^\']*\'', "", re.sub(r"--.*$", "", lines[j]))
        depth += s.count("{") - s.count("}")
        if depth <= 0:
            return j
    return i


def table_src(lines, i, name, rest):
    """Keep a class table's constant fields (e.g. EVENTS.Land); `{}` if it holds code."""
    if not rest.startswith("{"):
        return f"{name} = {{}}"
    j = balanced(lines, i)
    body = "\n".join(l for l in lines[i:j + 1] if not l.lstrip().startswith("--"))
    return f"{name} = {{}}" if re.search(r"\bfunction\b", body) or j - i > 300 else body


def convert(text):
    lines = text.split("\n")
    # some files wrap everything in a `do` block: dedent by the first @type's indent
    im = re.search(r"^( +)-- @type ", text, re.M)
    if im and not re.search(r"^-- @type ", text, re.M):
        n = len(im.group(1))
        lines = [l[n:] if l[:n].strip() == "" else l for l in lines]
    lines = [l.lstrip() if l.lstrip().startswith("--") or re.match(r"^\s+function\s+[A-Z_]\w*[.:]\w", l) else l
             for l in lines]
    # pass 1: @type blocks -> class registry
    classes = {}
    blocks = []                      # (start, end, desc, tags) of comment blocks
    i = 0
    while i < len(lines):
        if lines[i].startswith("--"):
            j = i
            while j < len(lines) and lines[j].startswith("--"):
                j += 1
            d, t = parse_block(lines[i:j])
            blocks.append((i, j, d, t))
            i = j
        else:
            i += 1
    for _, _, d, t in blocks:
        for tag, body in t:
            if tag == "type" and body.strip():
                c = classes.setdefault(body.split()[0].lstrip("#"), {"desc": [], "tags": [], "fields": []})
                c["tags"] += [x for x in t if x[0] == "extends"]
                if any(l.strip() for l in d) and not c["desc"]:
                    c["desc"] = d
        # @field lines belong to the @type in the same block
        names = [b.split()[0].lstrip("#") for tg, b in t if tg == "type" and b.strip()]
        if names:
            for tg, b in t:
                if tg == "field":
                    fm = re.match(r"^(\S+)\s+([A-Za-z_]\w*)\s*(.*)$", b)
                    if fm and not fm.group(1)[0].isdigit():
                        ty = re.sub(r"\(?optional\)?", "", fm.group(1), flags=re.I)
                        classes[names[0]]["fields"].append(
                            f"---@field {fm.group(2)} {conv(ty)} {esc(fm.group(3))}".rstrip())

    # pass 2: walk code
    outl, declared = [], set()
    by_end = {e: (d, t) for s, e, d, t in blocks}
    i = 0
    while i < len(lines):
        ln = lines[i]
        m_blk = by_end.get(i)
        if ln.startswith("function "):
            if re.match(r"^function\s+[\w.:]+\s*\(", ln):
                d, t = m_blk or ([], [])
                outl.append(func_stub(d, t, ln))
        else:
            m = re.match(r"^([A-Za-z_][\w.]*)\s*=\s*(.*)$", ln)
            if m and not ln.startswith("local"):
                name, rest = m.group(1), m.group(2)
                fm = re.match(r"^function\s*\(", rest)
                if fm and "." in name:       # `X.Y = function(...)` is a plain function too
                    d, t = m_blk or ([], [])
                    outl.append(func_stub(d, t, f"function {name}{rest[len('function'):].lstrip()}"))
                    i += 1
                    continue
                if name in classes and name not in declared:
                    c = classes[name]
                    outl.append((doc(c["desc"]) + "\n" if any(l.strip() for l in c["desc"]) else "")
                                + "\n".join(class_decl(name, c["desc"], c["tags"], c["fields"]))
                                + "\n" + table_src(lines, i, name, rest))
                    declared.add(name)
                    if rest.startswith("{") and "." not in name:
                        i = balanced(lines, i)
                elif rest.startswith("{") and "." in name:
                    j = balanced(lines, i)
                    d = doc(m_blk[0]) + "\n" if m_blk and any(l.strip() for l in m_blk[0]) else ""
                    body = "\n".join(l for l in lines[i:j + 1] if not l.lstrip().startswith("--"))
                    declared.add(name)
                    if not re.search(r"\bfunction\b", body):
                        outl.append(d + body)
                    else:
                        outl.append(d + f"{name} = {{}}")
                    i = j
                elif name.rsplit(".", 1)[0] in declared and re.match(r'^(-?[\d.]+|"[^"]*"|\'[^\']*\'|true|false)\s*(--.*)?$', rest):
                    d = doc(m_blk[0]) + "\n" if m_blk and any(l.strip() for l in m_blk[0]) else ""
                    val = re.sub(r"\s*--.*$", "", rest)
                    outl.append(d + f"{name} = {val}")
        i += 1
    # FSM-style events documented as `@function [parent=#CLASS] Name`
    for _, _, d, t in blocks:
        for tag, body in t:
            fm = tag == "function" and re.match(r"^\[parent=#?([\w.]+)\]\s*#?(\w+)", body)
            if fm:
                names = [m.group(1) for tg, b in t if tg == "param"
                         for m in [re.match(r"^\S+\s+(\w+)", b)] if m and m.group(1) != "self"]
                sig = f"function {fm.group(1)}:{fm.group(2)}({', '.join(names)})"
                outl.append(func_stub(d, [x for x in t if x[0] != "function"], sig))
    # classes with @type but no top-level table in this file
    for name, c in classes.items():
        if name not in declared and name not in BUILTIN:
            outl.insert(0, "\n".join(class_decl(name, c["desc"], c["tags"], c["fields"]))
                        + (f"\n{name} = {{}}" if "." not in name else ""))
    return "---@meta\n\n" + "\n\n".join(o for o in outl if o) + "\n"


KNOWN = set()
for f in out.parent.rglob("*.lua"):
    if out in f.parents:
        continue
    t = f.read_text(encoding="utf-8", errors="replace")
    KNOWN |= set(re.findall(r"---@class (\w+)", t)) | set(re.findall(r"^\s*(\w+) = \{", t, re.M))
KNOWN -= {"Vec3", "Vec2", "Task", "Distance", "Time", "Speed", "Duration"}


def drop_known(text):
    """Remove blocks of DCS.lua that redefine the DCS API globals declared elsewhere in the library."""
    chunks = re.split(r"\n\n+", text)
    keep = []
    for c in chunks:
        m = re.search(r"^---@class (\w+)|^function (\w+)[.:]|^(\w+) = ", c, re.M)
        root = next((g for g in m.groups() if g), None) if m else None
        if root not in KNOWN:
            keep.append(c)
    return "\n\n".join(keep)


n = 0
for f in sorted(src.rglob("*.lua")):
    rel = f.relative_to(src)
    text = f.read_text(encoding="utf-8", errors="replace")
    dst = out / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    res = convert(text)
    if rel.name == "DCS.lua":
        res = drop_known(res)
    dst.write_text(res, encoding="utf-8")
    n += 1
print(f"{n} files -> {out}")
