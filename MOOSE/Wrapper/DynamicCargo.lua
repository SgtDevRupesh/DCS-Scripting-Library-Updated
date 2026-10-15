---@meta

---DYNAMICCARGO class.
---@class DYNAMICCARGO : POSITIONABLE
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field warehouse STORAGE The STORAGE object.
---@field version string .
---@field CargoState string .
---@field DCS table #Vec3 LastPosition.
---@field Interval number Check interval. 5 secs default.
---@field testing boolean
---@field timer TIMER Compatibility field; updates are handled by one class-wide scheduler.
---@field Owner string The playername who has created, loaded or unloaded this cargo. Depends on state.
DYNAMICCARGO = {
  ClassName          = "DYNAMICCARGO",
  verbose            = 0,
  testing            = false,
  Interval           = 5,
  C130AttachDistance = 10,
  C130DetachDistance = 14,
  C130AirborneAGL = 8,
  C130LandedAGL = 0.5,
  C130StabilityEpsilon = 0.05,
  C130RequireAirborne = true,
  C130OwnerResolveMove2D = 10,
  C130OwnerResolveNear2D = 4,
  C130OwnerResolveMax3D = 250,
  
}

---Liquid types.
---@class DYNAMICCARGO.Liquid
---@field JETFUEL number Jet fuel (0).
---@field GASOLINE number Aviation gasoline (1).
---@field MW50 number MW50 (2).
---@field DIESEL number Diesel (3).
DYNAMICCARGO.Liquid = {
  JETFUEL = 0,
  GASOLINE = 1,
  MW50 = 2,
  DIESEL = 3,
}

---Liquid Names for the static cargo resource table.
---@class DYNAMICCARGO.LiquidName
---@field JETFUEL number "jet_fuel".
---@field GASOLINE number "gasoline".
---@field MW50 number "methanol_mixture".
---@field DIESEL number "diesel".
DYNAMICCARGO.LiquidName = {
   GASOLINE = "gasoline",
   DIESEL =    "diesel",
   MW50 =  "methanol_mixture",
   JETFUEL = "jet_fuel",  
}

---Storage types.
---@class DYNAMICCARGO.Type
---@field WEAPONS number weapons.
---@field LIQUIDS number liquids. Also see #list<#DYNAMICCARGO.Liquid> for types of liquids.
---@field AIRCRAFT number aircraft.
DYNAMICCARGO.Type = {
  WEAPONS = "weapons",
  LIQUIDS = "liquids",
  AIRCRAFT = "aircrafts",
}

---State types
---@class DYNAMICCARGO.State
---@field NEW string
---@field LOADED string
---@field UNLOADED string
---@field REMOVED string
DYNAMICCARGO.State = {
  NEW = "NEW",
  LOADED = "LOADED",
  UNLOADED = "UNLOADED",
  REMOVED = "REMOVED",
}

---Helo types possible.
---@class DYNAMICCARGO.AircraftTypes
DYNAMICCARGO.AircraftTypes = {
  ["CH-47Fbl1"] = "CH-47Fbl1",
  ["Mi-8MTV2"] = "Mi-8MTV2",
  ["Mi-8MT"] = "Mi-8MT",
  ["UH-1H"] = "UH-1H",
  ["Mi-24P"] = "Mi-24P",
  ["UH-60L"] = "UH-60L",
  ["UH-60L_DAP"] = "UH-60L_DAP",
  ["C-130J-30"] = "C-130J-30",
}

---Helo types possible.
---@class DYNAMICCARGO.AircraftDimensions
DYNAMICCARGO.AircraftDimensions = {
  ["CH-47Fbl1"] = {
    ["width"] = 4,
    ["height"] = 6,
    ["length"] = 11,
    ["ropelength"] = 30,
  },
  ["Mi-8MTV2"] = {
    ["width"] = 6,
    ["height"] = 6,
    ["length"] = 15,
    ["ropelength"] = 30,
  },
  ["Mi-8MT"] = {
    ["width"] = 6,
    ["height"] = 6,
    ["length"] = 15,
    ["ropelength"] = 30,
  },
  ["UH-1H"] = {
    ["width"] = 4,
    ["height"] = 4,
    ["length"] = 9,
    ["ropelength"] = 25,
  },
  ["Mi-24P"] = {
    ["width"] = 4,
    ["height"] = 5,
    ["length"] = 11,
    ["ropelength"] = 25,
  },
  ["UH-60L"] = {
    ["width"] = 4,
    ["height"] = 5,
    ["length"] = 10,
    ["ropelength"] = 25,
  },
  ["UH-60L_DAP"] = {
    ["width"] = 4,
    ["height"] = 5,
    ["length"] = 10,
    ["ropelength"] = 25,
  },
  ["C-130J-30"] = {
    ["width"] = 4,
    ["height"] = 12,
    ["length"] = 35,
    ["ropelength"] = 0,
    ["attach"] = 10,
    ["detach"] = 14,
  },
}

---DYNAMICCARGO class version.
DYNAMICCARGO.version = "0.1.0"

---Create a new DYNAMICCARGO object from the DCS static cargo object.
---@param CargoName? string Name of the Cargo.
---@return DYNAMICCARGO # self
function DYNAMICCARGO:Register(CargoName) end

---Get DCS object.
---@return any # static object
function DYNAMICCARGO:GetDCSObject() end

---Get last known owner name of this DYNAMICCARGO
---@return string # Owner
function DYNAMICCARGO:GetLastOwner() end

---Returns true if the cargo is new and has never been loaded into a Helo.
---@return boolean # Outcome
function DYNAMICCARGO:IsNew() end

---Returns true if the cargo been loaded into a Helo.
---@return boolean # Outcome
function DYNAMICCARGO:IsLoaded() end

---Returns true if the cargo has been unloaded from a Helo.
---@return boolean # Outcome
function DYNAMICCARGO:IsUnloaded() end

---Returns true if the cargo has been removed.
---@return boolean # Outcome
function DYNAMICCARGO:IsRemoved() end

---Returns true if this cargo is attached to a detected carrier.
---@return boolean # Outcome
function DYNAMICCARGO:IsAttached() end

---Returns true if this cargo was detached from a detected carrier.
---@return boolean # Outcome
function DYNAMICCARGO:IsDetached() end

---Returns true if this cargo has seen airborne transport in this cycle.
---@return boolean # Outcome
function DYNAMICCARGO:WasAirborneTransport() end

---Returns true if this cargo has reached landed stable confirmation.
---@return boolean # Outcome
function DYNAMICCARGO:IsLandedStable() end

---Returns last known carrier unit name.
---@return string # Unit name
function DYNAMICCARGO:GetCarrierUnitName() end

---Returns last known carrier type name.
---@return string # Type name
function DYNAMICCARGO:GetCarrierTypeName() end

---Returns last known carrier group name.
---@return string # Group name
function DYNAMICCARGO:GetCarrierGroupName() end

---[CTLD] Get number of crates this DYNAMICCARGO consists of. Always one.
---@return number # crate number, always one
function DYNAMICCARGO:GetCratesNeeded() end

---[CTLD] Get this DYNAMICCARGO drop state. True if DYNAMICCARGO.State.UNLOADED
---@return boolean # Dropped
function DYNAMICCARGO:WasDropped() end

---[CTLD] Get CTLD_CARGO.Enum type of this DYNAMICCARGO
---@return string # Type, only one at the moment is CTLD_CARGO.Enum.GCLOADABLE
function DYNAMICCARGO:GetType() end

---Find last known position of this DYNAMICCARGO
---@return Vec3 # Position in 3D space
function DYNAMICCARGO:GetLastPosition() end

---Find current state of this DYNAMICCARGO
---@return string # The current state
function DYNAMICCARGO:GetState() end

---Find a DYNAMICCARGO in the **_DATABASE** using the name associated with it.
---@param Name? string The dynamic cargo name
---@return DYNAMICCARGO # self
function DYNAMICCARGO:FindByName(Name) end

---Find the first(!) DYNAMICCARGO matching using patterns. Note that this is **a lot** slower than `:FindByName()`!
---@param Pattern? string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return DYNAMICCARGO # The DYNAMICCARGO.
function DYNAMICCARGO:FindByMatching(Pattern) end

---Find all DYNAMICCARGO objects matching using patterns. Note that this is **a lot** slower than `:FindByName()`!
---@param Pattern? string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return table # Groups Table of matching #DYNAMICCARGO objects found
function DYNAMICCARGO:FindAllByMatching(Pattern) end

---Get the #STORAGE object from this dynamic cargo.
---@return STORAGE # Storage The #STORAGE object
function DYNAMICCARGO:GetStorageObject() end

---Get the weight in kgs from this dynamic cargo.
---@return number # Weight in kgs.
function DYNAMICCARGO:GetCargoWeight() end

---Get the cargo display name from this dynamic cargo.
---@return string # The display name
function DYNAMICCARGO:GetCargoDisplayName() end

---[Internal] Check whether an aircraft typename is a C-130J for special handling.
---@param TypeName? string
---@return boolean # Outcome
function DYNAMICCARGO:_IsC130Type(TypeName) end

---[Internal] Safe AGL calculation helper.
---@param Coord? COORDINATE
---@return number # AGL in meters
function DYNAMICCARGO:_GetAGL(Coord) end

---[Internal] Resolve player name for a client.
---@param Client? CLIENT
---@return string # Player name
function DYNAMICCARGO:_GetPlayerNameForClient(Client) end

---[Internal] Store current carrier identity fields.
---@param Client? CLIENT
---@param PlayerName? string
---@return DYNAMICCARGO # self
function DYNAMICCARGO:_SetCarrierFromClient(Client, PlayerName) end

---[Internal] Get scheduler interval for global dynamic cargo updates.
---@return number # Interval in seconds
function DYNAMICCARGO._GetSchedulerInterval() end

---[Internal] Count currently tracked dynamic cargo objects.
---@return number # Count
function DYNAMICCARGO._CountTracked() end

---[Internal] Stop global scheduler when no tracked cargo remains.
function DYNAMICCARGO._StopGlobalSchedulerIfIdle() end

---[Internal] Ensure global scheduler is running for tracked cargo updates.
function DYNAMICCARGO._EnsureGlobalScheduler() end

---[Internal] Add one dynamic cargo object to global tracking.
---@param Cargo? DYNAMICCARGO
function DYNAMICCARGO._TrackCargo(Cargo) end

---[Internal] Remove one dynamic cargo object from global tracking.
---@param CargoName? string
function DYNAMICCARGO._UntrackCargo(CargoName) end

---[Internal] Update all tracked dynamic cargo objects in one scheduler tick.
function DYNAMICCARGO._UpdateAllTracked() end

---[Internal] Find tracked client by unit name in current dynamic cargo helo set.
---@param UnitName? string
---@return CLIENT # Client
function DYNAMICCARGO:_FindClientByUnitName(UnitName) end

---[Internal] Get best known carrier client from stored names/owner.
---@return CLIENT # Client
function DYNAMICCARGO:_GetKnownCarrierClient() end

---[Internal] Find nearest live C-130 client.
---@param Pos? COORDINATE
---@param Max3D? number Maximum 3D distance
---@return CLIENT # Client
---@return string # PlayerName
---@return number # Dist2D
---@return number # Dist3D
function DYNAMICCARGO:_FindNearestC130(Pos, Max3D) end

---[Internal] Resolve/rebind owner to nearest valid C-130 after movement from spawn.
---@param Pos? COORDINATE
---@return CLIENT # Client
function DYNAMICCARGO:_ResolveC130Owner(Pos) end

---[Internal] Determine whether to run C-130 transport-state handling for this cargo tick.
---@param Pos? COORDINATE
---@return boolean # Outcome
function DYNAMICCARGO:_ShouldUseC130State(Pos) end

---[Internal] C-130-specific transport state update.
---@param Pos? COORDINATE
---@return DYNAMICCARGO # self
function DYNAMICCARGO:_UpdatePositionC130(Pos) end

---[Internal] _Get helo hovering intel
---@param Unit? UNIT The Unit to test
---@param ropelength? number Ropelength to test
---@return boolean # Outcome
function DYNAMICCARGO:_HeloHovering(Unit, ropelength) end

---[Internal] _Get Possible Player Helo Nearby
---@param pos? COORDINATE
---@param loading? boolean If true measure distance for loading else for unloading
---@return boolean # Success
---@return CLIENT # Helo
---@return string # PlayerName
function DYNAMICCARGO:_GetPossibleHeloNearby(pos, loading) end

---[Internal] Update internal states.
---@return DYNAMICCARGO # self
function DYNAMICCARGO:_UpdatePosition() end

---[USER] Destroy a DYNAMICCARGO object.
---@param GenerateEvent? boolean Set to false to remove an item silently. Defaults to true.
---@return boolean # Return Returns nil if the object could not be found, else returns true.
function DYNAMICCARGO:Destroy(GenerateEvent) end

---[Internal] Track helos for loaded/unloaded decision making.
---@param client? CLIENT
---@return boolean # IsIn
function DYNAMICCARGO._FilterHeloTypes(client) end
