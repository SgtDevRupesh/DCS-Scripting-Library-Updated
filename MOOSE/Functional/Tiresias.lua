---@meta

---@class TIRESIAS.Data
---@field type string
---@field range number
---@field invisible boolean
---@field AIOff boolean
---@field exception boolean

---**TIRESIAS** class, extends Core.Base#BASE
---@class TIRESIAS : FSM
---@field ClassName string
---@field debug boolean
---@field version string
---@field Interval number
---@field GroundSet SET_GROUP
---@field Coalition number
---@field VehicleSet SET_GROUP
---@field AAASet SET_GROUP
---@field SAMSet SET_GROUP
---@field ExceptionSet SET_GROUP
---@field OpsGroupSet SET_OPSGROUP
---@field AAARange number
---@field HeloSwitchRange number
---@field PlaneSwitchRange number
---@field FlightSet SET_GROUP
---@field SwitchAAA boolean
---@field lid string
---@field _cached_zones table
---@field _cached_groupsets table
TIRESIAS = {
  ClassName         = "TIRESIAS",
  debug             = false,
  version           = " 0.0.8" ,
  Interval          = 20,
  GroundSet         = nil,
  VehicleSet        = nil,
  AAASet            = nil,
  SAMSet            = nil,
  ExceptionSet      = nil,
  AAARange          = 60, --  60%
  HeloSwitchRange   = 10, --  NM
  PlaneSwitchRange  = 25, --  NM
  SwitchAAA         = true,
  _cached_zones     = {}, --  Cache for zone objects
  _cached_groupsets = {}, --  Cache for group_set objects
  }

---[USER] Create a new Tiresias object and start it up.
---@return TIRESIAS # self
function TIRESIAS:New() end

---[USER] Set activation radius for Helos and Planes in Nautical Miles.
---@param HeloMiles? number (Optional) Radius around a Helicopter in which AI ground units will be activated. Defaults to 10NM.
---@param PlaneMiles? number (Optional) Radius around an Airplane in which AI ground units will be activated. Defaults to 25NM.
---@return TIRESIAS # self
function TIRESIAS:SetActivationRanges(HeloMiles, PlaneMiles) end

---[USER] Set AAA Ranges - AAA equals non-SAM systems which qualify as AAA in DCS world.
---@param FiringRange? number (Optional) The engagement range that AAA units will be set to. Can be 0 to 100 (percent). Defaults to 60.
---@param SwitchAAA? boolean (Optional) Decide if these system will have their AI switched off, too. Defaults to true.
---@return TIRESIAS # self
function TIRESIAS:SetAAARanges(FiringRange, SwitchAAA) end

---[USER] Add a SET_GROUP of GROUP objects as exceptions. Can be done multiple times. Does **not** work work for GROUP objects spawned into the SET after start, i.e. the groups need to exist in the game already.
---@param Set? SET_GROUP to add to the exception list.
---@return TIRESIAS # self
function TIRESIAS:AddExceptionSet(Set) end

---[INTERNAL] Filter Function - Optimized with cached calls
---@param Group? GROUP
---@return boolean # isin
function TIRESIAS._FilterNotAAA(Group) end

---[INTERNAL] Filter Function - Optimized with cached calls
---@param Group? GROUP
---@return boolean # isin
function TIRESIAS._FilterNotSAM(Group) end

---[INTERNAL] Filter Function - Optimized with cached calls
---@param Group? GROUP
---@return boolean # isin
function TIRESIAS._FilterAAA(Group) end

---[INTERNAL] Filter Function - Optimized with cached calls
---@param Group? GROUP
---@return boolean # isin
function TIRESIAS._FilterSAM(Group) end

---[INTERNAL] Init Groups - Optimized with reduced function calls
---@return TIRESIAS # self
function TIRESIAS:_InitGroups() end

---[INTERNAL] Event handler function - Optimized
---@param EventData? EVENTDATA
---@return TIRESIAS # self
function TIRESIAS:_EventHandler(EventData) end

---[INTERNAL] Switch Groups Behaviour - Optimized with zone caching
---@param group? GROUP
---@param radius? number Radius in NM
---@return TIRESIAS # self
function TIRESIAS:_SwitchOnGroups(group, radius) end

---[INTERNAL] FSM Function - Optimized initialization
---@param From? string
---@param Event? string
---@param To? string
---@return TIRESIAS # self
function TIRESIAS:onafterStart(From, Event, To) end

---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function ExceptionSet:OnAfterAdded(From, Event, To, ObjectName, Object) end

---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function OpsGroupSet:OnAfterAdded(From, Event, To, ObjectName, Object) end

--- Optimized event handlers with pre-created data objects
---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function VehicleSet:OnAfterAdded(From, Event, To, ObjectName, Object) end

---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function AAASet:OnAfterAdded(From, Event, To, ObjectName, Object) end

---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function SAMSet:OnAfterAdded(From, Event, To, ObjectName, Object) end

---[INTERNAL] FSM Function
---@param From? string
---@param Event? string
---@param To? string
---@return TIRESIAS # self
function TIRESIAS:onbeforeStatus(From, Event, To) end

---[INTERNAL] FSM Function - Optimized status processing
---@param From? string
---@param Event? string
---@param To? string
---@return TIRESIAS # self
function TIRESIAS:onafterStatus(From, Event, To) end

---[INTERNAL] FSM Function
---@param From? string
---@param Event? string
---@param To? string
---@return TIRESIAS # self
function TIRESIAS:onafterStop(From, Event, To) end

---Triggers the FSM event "Stop". Stops TIRESIAS and all its event handlers.
function TIRESIAS:Stop() end

---Triggers the FSM event "Stop" after a delay. Stops TIRESIAS and all its event handlers.
---@param delay? number Delay in seconds.
function TIRESIAS:__Stop(delay) end

---Triggers the FSM event "Start". Starts TIRESIAS and all its event handlers. Note - `:New()` already starts the instance.
function TIRESIAS:Start() end

---Triggers the FSM event "Start" after a delay. Starts TIRESIAS and all its event handlers. Note - `:New()` already starts the instance.
---@param delay? number Delay in seconds.
function TIRESIAS:__Start(delay) end
