---@meta

---@class STATIC : POSITIONABLE
STATIC = {
  ClassName = "STATIC",
}

---Register a static object.
---@param StaticName? string Name of the static object.
---@return STATIC # self
function STATIC:Register(StaticName) end

---Get initial life points
---@return number # lifepoints
function STATIC:GetLife0() end

---Get current life points
---@return number # lifepoints or nil
function STATIC:GetLife() end

---Get the position of the STATIC even if it is not alive.
---@return Vec2 # The 2D point vector of the POSITIONABLE.
---@return nil # The position was not cached.
function STATIC:GetVec2Cached() end

---Get the position of the STATIC even if it is not alive.
---@return Vec3 # The 3D point vector of the POSITIONABLE.
---@return nil # The position was not cached.
function STATIC:GetVec3Cached() end

---Finds a STATIC from the _DATABASE using a DCSStatic object.
---@param DCSStatic? StaticObject An existing DCS Static object reference.
---@return STATIC # self
function STATIC:Find(DCSStatic) end

---Finds a STATIC from the _DATABASE using the relevant Static Name.
---As an optional parameter, a briefing text can be given also.
---@param StaticName? string Name of the DCS **Static** as defined within the Mission Editor.
---@param RaiseError? boolean Raise an error if not found.
---@return STATIC # self or *nil*
function STATIC:FindByName(StaticName, RaiseError) end

---Destroys the STATIC.
---@param GenerateEvent? boolean (Optional) true if you want to generate a crash or dead event for the static.
---@return nil # The DCS StaticObject is not existing or alive.
function STATIC:Destroy(GenerateEvent) end

---Get DCS object of static of static.
---@return any # static object
function STATIC:GetDCSObject() end

---Returns a list of one {Wrapper.Static}.
---@return STATIC[] # A list of one @{Wrapper.Static}.
function STATIC:GetUnits() end

---Get threat level of static.
---@return number # Threat level 1.
---@return string # "Static"
function STATIC:GetThreatLevel() end

---Spawn the {Wrapper.Static} at a specific coordinate and heading.
---@param Coordinate? COORDINATE The coordinate where to spawn the new Static.
---@param Heading? number (Optional) The heading of the static respawn in degrees. Default is 0 deg.
---@param Delay? number Delay in seconds before the static is spawned.
function STATIC:SpawnAt(Coordinate, Heading, Delay) end

---Respawn the {Wrapper.Static} at the same location with the same properties.
---This is useful to respawn a cargo after it has been destroyed.
---@param CountryID? country.id|number|string (Optional) The country ID used for spawning the new static. Default is same as currently.
---@param Delay? number (Optional) Delay in seconds before static is respawned. Default now.
function STATIC:ReSpawn(CountryID, Delay) end

---Respawn the {Wrapper.Unit} at a defined Coordinate with an optional heading.
---@param Coordinate? COORDINATE The coordinate where to spawn the new Static.
---@param Heading? number (Optional) The heading of the static respawn in degrees. Default the current heading.
---@param Delay? number (Optional) Delay in seconds before static is respawned. Default now.
function STATIC:ReSpawnAt(Coordinate, Heading, Delay) end

---Find the first(!) STATIC matching using patterns. Note that this is **a lot** slower than `:FindByName()`!
---@param Pattern? string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return STATIC # The STATIC.
function STATIC:FindByMatching(Pattern) end

---Find all STATIC objects matching using patterns. Note that this is **a lot** slower than `:FindByName()`!
---@param Pattern? string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return table # Groups Table of matching #STATIC objects found
function STATIC:FindAllByMatching(Pattern) end

---Get the Wrapper.Storage#STORAGE object of an static if it is used as cargo and has been set up as storage object.
---@return STORAGE # Storage or `nil` if not fund or set up.
function STATIC:GetStaticStorage() end

---Get the Cargo Weight of a static object in kgs. Returns -1 if not found.
---@return number # Mass Weight in kgs.
function STATIC:GetCargoWeight() end
