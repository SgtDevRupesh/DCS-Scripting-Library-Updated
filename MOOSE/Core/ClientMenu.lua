---@meta

---@class CLIENTMENU : BASE
---@field ClassName string Class Name
---@field lid string Lid for log entries
---@field version string Version string
---@field name string Name
---@field groupname string Group name
---@field path table
---@field parentpath table
---@field Parent CLIENTMENU
---@field client CLIENT
---@field GroupID number Group ID
---@field ID number Entry ID
---@field group GROUP
---@field UUID string Unique ID based on path+name
---@field Function string
---@field Functionargs table
---@field Children table
---@field Once boolean
---@field Generic boolean
---@field debug boolean
---@field Controller CLIENTMENUMANAGER
---@field boolean active
CLIENTMENU = {
  ClassName = "CLIENTMENU",
  lid = "",
  version = "0.1.3",
  name = nil,
  path = nil,
  group = nil,
  client = nil,
  GroupID = nil,
  Children = {},
  Once = false,
  Generic = false,
  debug = false,
  Controller = nil,
  groupname = nil,
  active = false,
}

---Create an new CLIENTMENU object.
---@param Client? CLIENT The client for whom this entry is. Leave as nil for a generic entry.
---@param Text? string Text of the F10 menu entry.
---@param Parent? CLIENTMENU The parent menu entry.
---@param Function? string (optional) Function to call when the entry is used.
---@param ... any
---@return CLIENTMENU # self
function CLIENTMENU:NewEntry(Client, Text, Parent, Function, ...) end

---Create a UUID
---@param Parent? CLIENTMENU The parent object if any
---@param Text? string The menu entry text
---@return string # UUID
function CLIENTMENU:CreateUUID(Parent, Text) end

---Set the CLIENTMENUMANAGER for this entry.
---@param Controller? CLIENTMENUMANAGER The controlling object.
---@return CLIENTMENU # self
function CLIENTMENU:SetController(Controller) end

---The entry will be deleted after being used used - for menu entries with functions only.
---@return CLIENTMENU # self
function CLIENTMENU:SetOnce() end

---Remove the entry from the F10 menu.
---@return CLIENTMENU # self
function CLIENTMENU:RemoveF10() end

---Get the menu path table.
---@return table # Path
function CLIENTMENU:GetPath() end

---Get the UUID.
---@return string # UUID
function CLIENTMENU:GetUUID() end

---Link a child entry.
---@param Child? CLIENTMENU The entry to link as a child.
---@return CLIENTMENU # self
function CLIENTMENU:AddChild(Child) end

---Remove a child entry.
---@param Child? CLIENTMENU The entry to remove from the children.
---@return CLIENTMENU # self
function CLIENTMENU:RemoveChild(Child) end

---Remove all subentries (children) from this entry.
---@return CLIENTMENU # self
function CLIENTMENU:RemoveSubEntries() end

---Remove this entry and all subentries (children) from this entry.
---@return CLIENTMENU # self
function CLIENTMENU:Clear() end

---Class CLIENTMENUMANAGER
---@class CLIENTMENUMANAGER : BASE
---@field ClassName string Class Name
---@field lid string Lid for log entries
---@field version string Version string
---@field name string Name
---@field clientset SET_CLIENT The set of clients this menu manager is for
---@field flattree table
---@field rootentries table
---@field menutree table
---@field entrycount number
---@field debug boolean
---@field PlayerMenu table
---@field Coalition number
CLIENTMENUMANAGER = {
  ClassName = "CLIENTMENUMANAGER",
  lid = "",
  version = "0.1.7",
  name = nil,
  clientset = nil,
  menutree = {},
  flattree = {},
  playertree = {},
  entrycount = 0,
  rootentries = {},
  debug = true,
  PlayerMenu = {},
  Coalition = nil,
}

---Create a new ClientManager instance.
---@param ClientSet? SET_CLIENT The set of clients to manage.
---@param Alias? string The name of this manager.
---@param Coalition? number (Optional) Coalition of this Manager, defaults to coalition.side.BLUE
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:New(ClientSet, Alias, Coalition) end

---[Internal] Event handling
---@param EventData? EVENTDATA
---@param Retry? any
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:_EventHandler(EventData, Retry) end

---Set this Client Manager to auto-propagate menus **once** to newly joined players. Useful if you have **one** menu structure only. Does not automatically push follow-up changes to the client(s).
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:InitAutoPropagation() end

---Create a new entry in the **generic** structure.
---@param Text? string Text of the F10 menu entry.
---@param Parent? CLIENTMENU The parent menu entry.
---@param Function? string (optional) Function to call when the entry is used.
---@param ... any
---@return CLIENTMENU # Entry
function CLIENTMENUMANAGER:NewEntry(Text, Parent, Function, ...) end

---Check matching entry in the generic structure by UUID.
---@param UUID? string UUID of the menu entry.
---@return boolean # Exists
function CLIENTMENUMANAGER:EntryUUIDExists(UUID) end

---Find matching entry in the generic structure by UUID.
---@param UUID? string UUID of the menu entry.
---@return CLIENTMENU # Entry The #CLIENTMENU object found or nil.
function CLIENTMENUMANAGER:FindEntryByUUID(UUID) end

---Find matching entries by text in the generic structure by UUID.
---@param Text? string Text or partial text of the menu entry to find.
---@param Parent? CLIENTMENU (Optional) Only find entries under this parent entry.
---@return table # Table of matching UUIDs of #CLIENTMENU objects
---@return table # Table of matching #CLIENTMENU objects
---@return number # Number of matches
function CLIENTMENUMANAGER:FindUUIDsByText(Text, Parent) end

---Find matching entries in the generic structure by the menu text.
---@param Text? string Text or partial text of the F10 menu entry.
---@param Parent? CLIENTMENU (Optional) Only find entries under this parent entry.
---@return table # Table of matching #CLIENTMENU objects.
---@return number # Number of matches
function CLIENTMENUMANAGER:FindEntriesByText(Text, Parent) end

---Find matching entries under a parent in the generic structure by UUID.
---@param Parent? CLIENTMENU Find entries under this parent entry.
---@return table # Table of matching UUIDs of #CLIENTMENU objects
---@return table # Table of matching #CLIENTMENU objects
---@return number # Number of matches
function CLIENTMENUMANAGER:FindUUIDsByParent(Parent) end

---Find matching entries in the generic structure under a parent.
---@param Parent? CLIENTMENU Find entries under this parent entry.
---@return table # Table of matching #CLIENTMENU objects.
---@return number # Number of matches
function CLIENTMENUMANAGER:FindEntriesByParent(Parent) end

---Alter the text of a leaf entry in the generic structure and push to one specific client's F10 menu.
---@param Entry? CLIENTMENU The menu entry.
---@param Text? string New Text of the F10 menu entry.
---@param Client? CLIENT (optional) The client for whom to alter the entry, if nil done for all clients.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:ChangeEntryText(Entry, Text, Client) end

---Push the complete menu structure to each of the clients in the set - refresh the menu tree of the clients.
---@param Client? CLIENT (optional) If given, propagate only for this client.
---@return CLIENTMENU # Entry
function CLIENTMENUMANAGER:Propagate(Client) end

---Push a single previously created entry into the F10 menu structure of all clients.
---@param Entry? CLIENTMENU The entry to add.
---@param Client? CLIENT (optional) If given, make this change only for this client.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:AddEntry(Entry, Client) end

---Blank out the menu - remove **all root entries** and all entries below from the client's F10 menus, leaving the generic structure untouched.
---@param Client? CLIENT (optional) If given, remove only for this client.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:ResetMenu(Client) end

---Blank out the menu - remove **all root entries** and all entries below from all clients' F10 menus, and **delete** the generic structure.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:ResetMenuComplete() end

---Remove the entry and all entries below the given entry from the client's F10 menus.
---@param Entry? CLIENTMENU The entry to remove
---@param Client? CLIENT (optional) If given, make this change only for this client.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:DeleteEntry(Entry, Client) end

---Remove the entry and all entries below the given entry from the client's F10 menus.
---@param Entry? CLIENTMENU The entry to remove
---@param Client? CLIENT (optional) If given, make this change only for this client.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:DeleteF10Entry(Entry, Client) end

---Remove the entry and all entries below the given entry from the generic tree.
---@param Entry? CLIENTMENU The entry to remove
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:DeleteGenericEntry(Entry) end

---Remove all entries below the given entry from the generic tree.
---@param Entry? CLIENTMENU The entry where to start. This entry stays.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:RemoveGenericSubEntries(Entry) end

---Remove all entries below the given entry from the client's F10 menus.
---@param Entry? CLIENTMENU The entry where to start. This entry stays.
---@param Client? CLIENT (optional) If given, make this change only for this client. In this case the generic structure will not be touched.
---@return CLIENTMENUMANAGER # self
function CLIENTMENUMANAGER:RemoveF10SubEntries(Entry, Client) end
