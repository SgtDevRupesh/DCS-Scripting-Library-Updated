---@meta

---@class EVENT.Events
---@field IniUnit number

---@class EVENTDATA
---@field id number The identifier of the event.
---@field initiator Unit (UNIT/STATIC/SCENERY) The initiating @{DCS#Unit} or @{DCS#StaticObject}.
---@field IniObjectCategory Object.Category (UNIT/STATIC/SCENERY) The initiator object category ( Object.Category.UNIT or Object.Category.STATIC ).
---@field IniDCSUnit Unit (UNIT/STATIC) The initiating @{DCS#Unit} or @{DCS#StaticObject}.
---@field IniDCSUnitName string (UNIT/STATIC) The initiating Unit name.
---@field IniUnit UNIT (UNIT/STATIC) The initiating MOOSE wrapper @{Wrapper.Unit#UNIT} of the initiator Unit object.
---@field IniUnitName string (UNIT/STATIC) The initiating UNIT name (same as IniDCSUnitName).
---@field IniDCSGroup Group (UNIT) The initiating {DCSGroup#Group}.
---@field IniDCSGroupName string (UNIT) The initiating Group name.
---@field IniGroup GROUP (UNIT) The initiating MOOSE wrapper @{Wrapper.Group#GROUP} of the initiator Group object.
---@field IniGroupName string UNIT) The initiating GROUP name (same as IniDCSGroupName).
---@field IniPlayerName string (UNIT) The name of the initiating player in case the Unit is a client or player slot.
---@field IniPlayerUCID string (UNIT) The UCID of the initiating player in case the Unit is a client or player slot and on a multi-player server.
---@field IniCoalition coalition.side (UNIT) The coalition of the initiator.
---@field IniCategory Unit.Category (UNIT) The category of the initiator.
---@field IniTypeName string (UNIT) The type name of the initiator.
---@field target Unit (UNIT/STATIC) The target @{DCS#Unit} or @{DCS#StaticObject}.
---@field TgtObjectCategory Object.Category (UNIT/STATIC) The target object category ( Object.Category.UNIT or Object.Category.STATIC ).
---@field TgtDCSUnit Unit (UNIT/STATIC) The target @{DCS#Unit} or @{DCS#StaticObject}.
---@field TgtDCSUnitName string (UNIT/STATIC) The target Unit name.
---@field TgtUnit UNIT (UNIT/STATIC) The target MOOSE wrapper @{Wrapper.Unit#UNIT} of the target Unit object.
---@field TgtUnitName string (UNIT/STATIC) The target UNIT name (same as TgtDCSUnitName).
---@field TgtDCSGroup Group (UNIT) The target {DCSGroup#Group}.
---@field TgtDCSGroupName string (UNIT) The target Group name.
---@field TgtGroup GROUP (UNIT) The target MOOSE wrapper @{Wrapper.Group#GROUP} of the target Group object.
---@field TgtGroupName string (UNIT) The target GROUP name (same as TgtDCSGroupName).
---@field TgtPlayerName string (UNIT) The name of the target player in case the Unit is a client or player slot.
---@field TgtPlayerUCID string (UNIT) The UCID of the target player in case the Unit is a client or player slot and on a multi-player server.
---@field TgtCoalition coalition.side (UNIT) The coalition of the target.
---@field TgtCategory Unit.Category (UNIT) The category of the target.
---@field TgtTypeName string (UNIT) The type name of the target.
---@field place Airbase The @{DCS#Airbase}
---@field Place AIRBASE The MOOSE airbase object.
---@field PlaceName string The name of the airbase.
---@field weapon Weapon The weapon used during the event.
---@field Weapon Weapon The weapon used during the event.
---@field WeaponName string Name of the weapon.
---@field WeaponTgtDCSUnit Unit Target DCS unit of the weapon.
---@field Zone ZONE The zone object.
---@field ZoneName string The name of the zone.
---@field IniDynamicCargo DYNAMICCARGO The dynamic cargo object.
---@field IniDynamicCargoName string The dynamic cargo unit name.
---@field MarkCoalition number Coalition of a marker (if any)
---@field MarkVec3 Vec3 Position of a marker
---@field MarkText string Text content of a marker, if any
---@field MarkID number ID of the marker, for deletion
---@field MarkGroupID number Group ID of the group that created the marker
---@field Coordinate COORDINATE object of the marker, only filled if EVENT.CreateMarkCoordinateOnEvent is set to true (off by default)
EVENTDATA = {}

---@class EVENT : BASE
---@field Events EVENT.Events
EVENT = {
  ClassName = "EVENT",
  ClassID = 0,
  MissionEnd = false,
  CreateMarkCoordinateOnEvent = false,
}

---The different types of events supported by MOOSE.
---Use this structure to subscribe to events using the {Core.Base#BASE.HandleEvent}() method.
---@class EVENTS
EVENTS = {
  Shot =              world.event.S_EVENT_SHOT,
  Hit =               world.event.S_EVENT_HIT,
  Takeoff =           world.event.S_EVENT_TAKEOFF,
  Land =              world.event.S_EVENT_LAND,
  Crash =             world.event.S_EVENT_CRASH,
  Ejection =          world.event.S_EVENT_EJECTION,
  Refueling =         world.event.S_EVENT_REFUELING,
  Dead =              world.event.S_EVENT_DEAD,
  PilotDead =         world.event.S_EVENT_PILOT_DEAD,
  BaseCaptured =      world.event.S_EVENT_BASE_CAPTURED,
  MissionStart =      world.event.S_EVENT_MISSION_START,
  MissionEnd =        world.event.S_EVENT_MISSION_END,
  TookControl =       world.event.S_EVENT_TOOK_CONTROL,
  RefuelingStop =     world.event.S_EVENT_REFUELING_STOP,
  Birth =             world.event.S_EVENT_BIRTH,
  HumanFailure =      world.event.S_EVENT_HUMAN_FAILURE,
  EngineStartup =     world.event.S_EVENT_ENGINE_STARTUP,
  EngineShutdown =    world.event.S_EVENT_ENGINE_SHUTDOWN,
  PlayerEnterUnit =   world.event.S_EVENT_PLAYER_ENTER_UNIT,
  PlayerLeaveUnit =   world.event.S_EVENT_PLAYER_LEAVE_UNIT,
  PlayerComment =     world.event.S_EVENT_PLAYER_COMMENT,
  ShootingStart =     world.event.S_EVENT_SHOOTING_START,
  ShootingEnd =       world.event.S_EVENT_SHOOTING_END,
  MarkAdded =         world.event.S_EVENT_MARK_ADDED,
  MarkChange =        world.event.S_EVENT_MARK_CHANGE,
  MarkRemoved =       world.event.S_EVENT_MARK_REMOVED,
  NewZone =           world.event.S_EVENT_NEW_ZONE,
  DeleteZone =        world.event.S_EVENT_DELETE_ZONE,
  NewZoneGoal =       world.event.S_EVENT_NEW_ZONE_GOAL,
  DeleteZoneGoal =    world.event.S_EVENT_DELETE_ZONE_GOAL,
  RemoveUnit =        world.event.S_EVENT_REMOVE_UNIT,
  PlayerEnterAircraft = world.event.S_EVENT_PLAYER_ENTER_AIRCRAFT,
  DetailedFailure           = world.event.S_EVENT_DETAILED_FAILURE or -1,  --We set this to -1 for backward compatibility to DCS 2.5.5 and earlier
  Kill                      = world.event.S_EVENT_KILL or -1,
  Score                     = world.event.S_EVENT_SCORE or -1,
  UnitLost                  = world.event.S_EVENT_UNIT_LOST or -1,
  LandingAfterEjection      = world.event.S_EVENT_LANDING_AFTER_EJECTION or -1,
  ParatrooperLanding        = world.event.S_EVENT_PARATROOPER_LENDING or -1,
  DiscardChairAfterEjection = world.event.S_EVENT_DISCARD_CHAIR_AFTER_EJECTION or -1,
  WeaponAdd                 = world.event.S_EVENT_WEAPON_ADD or -1,
  TriggerZone               = world.event.S_EVENT_TRIGGER_ZONE or -1,
  LandingQualityMark        = world.event.S_EVENT_LANDING_QUALITY_MARK or -1,
  BDA                       = world.event.S_EVENT_BDA or -1,
  AIAbortMission            = world.event.S_EVENT_AI_ABORT_MISSION or -1,
  DayNight                  = world.event.S_EVENT_DAYNIGHT or -1,
  FlightTime                = world.event.S_EVENT_FLIGHT_TIME or -1,
  SelfKillPilot             = world.event.S_EVENT_PLAYER_SELF_KILL_PILOT or -1,
  PlayerCaptureAirfield     = world.event.S_EVENT_PLAYER_CAPTURE_AIRFIELD or -1, 
  EmergencyLanding          = world.event.S_EVENT_EMERGENCY_LANDING or -1,
  UnitCreateTask            = world.event.S_EVENT_UNIT_CREATE_TASK or -1,
  UnitDeleteTask            = world.event.S_EVENT_UNIT_DELETE_TASK or -1,
  SimulationStart           = world.event.S_EVENT_SIMULATION_START or -1,
  WeaponRearm               = world.event.S_EVENT_WEAPON_REARM or -1,
  WeaponDrop                = world.event.S_EVENT_WEAPON_DROP or -1,
  UnitTaskComplete          = world.event.S_EVENT_UNIT_TASK_COMPLETE or -1,
  UnitTaskStage             = world.event.S_EVENT_UNIT_TASK_STAGE or -1,
  MacExtraScore             = world.event.S_EVENT_MAC_EXTRA_SCORE or -1,
  MissionRestart            = world.event.S_EVENT_MISSION_RESTART or -1,
  MissionWinner             = world.event.S_EVENT_MISSION_WINNER or -1, 
  RunwayTakeoff             = world.event.S_EVENT_RUNWAY_TAKEOFF or -1, 
  RunwayTouch               = world.event.S_EVENT_RUNWAY_TOUCH or -1,
  MacLMSRestart             = world.event.S_EVENT_MAC_LMS_RESTART or -1,
  SimulationFreeze          = world.event.S_EVENT_SIMULATION_FREEZE or -1, 
  SimulationUnfreeze        = world.event.S_EVENT_SIMULATION_UNFREEZE or -1, 
  HumanAircraftRepairStart  = world.event.S_EVENT_HUMAN_AIRCRAFT_REPAIR_START or -1, 
  HumanAircraftRepairFinish = world.event.S_EVENT_HUMAN_AIRCRAFT_REPAIR_FINISH or -1,
  NewDynamicCargo           = world.event.S_EVENT_NEW_DYNAMIC_CARGO or -1,
  DynamicCargoLoaded        = world.event.S_EVENT_DYNAMIC_CARGO_LOADED or -1,
  DynamicCargoUnloaded      = world.event.S_EVENT_DYNAMIC_CARGO_UNLOADED or -1,
  DynamicCargoRemoved       = world.event.S_EVENT_DYNAMIC_CARGO_REMOVED or -1,
}

---Create new event handler.
---@return EVENT # self
function EVENT:New() end

---Initializes the Events structure for the event.
---@param EventID? world.event|number|string Event ID.
---@param EventClass? BASE The class object for which events are handled.
---@return EVENT.Events
function EVENT:Init(EventID, EventClass) end

---Removes a subscription
---@param EventClass? BASE The self instance of the class for which the event is.
---@param EventID? world.event|number|string Event ID.
---@return EVENT # self
function EVENT:RemoveEvent(EventClass, EventID) end

---Resets subscriptions.
---@param EventObject? any
---@return EVENT.Events
function EVENT:Reset(EventObject) end

---Clears all event subscriptions for a {Core.Base#BASE} derived object.
---@param EventClass? BASE The self class object for which the events are removed.
---@return EVENT # self
function EVENT:RemoveAll(EventClass) end

---Create an OnDead event handler for a group
---@param EventTemplate? table
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? any
---@param EventID? any
---@return EVENT # self
function EVENT:OnEventForTemplate(EventTemplate, EventFunction, EventClass, EventID) end

---Set a new listener for an `S_EVENT_X` event independent from a unit or a weapon.
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? BASE The self instance of the class for which the event is captured. When the event happens, the event process will be called in this class provided.
---@param EventID? any
---@return EVENT
function EVENT:OnEventGeneric(EventFunction, EventClass, EventID) end

---Set a new listener for an `S_EVENT_X` event for a UNIT.
---@param UnitName? string The name of the UNIT.
---@param EventFunction? function The function to be called when the event occurs for the GROUP.
---@param EventClass? BASE The self instance of the class for which the event is.
---@param EventID? any
---@return EVENT # self
function EVENT:OnEventForUnit(UnitName, EventFunction, EventClass, EventID) end

---Set a new listener for an S_EVENT_X event for a GROUP.
---@param GroupName? string The name of the GROUP.
---@param EventFunction? function The function to be called when the event occurs for the GROUP.
---@param EventClass? BASE The self instance of the class for which the event is.
---@param EventID? number Event ID.
---@param ... any
---@return EVENT # self
function EVENT:OnEventForGroup(GroupName, EventFunction, EventClass, EventID, ...) end

---Create an OnBirth event handler for a group
---@param EventTemplate? any
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? any
---@return EVENT # self
function EVENT:OnBirthForTemplate(EventTemplate, EventFunction, EventClass) end

---Create an OnCrash event handler for a group
---@param EventTemplate? any
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? any
---@return EVENT
function EVENT:OnCrashForTemplate(EventTemplate, EventFunction, EventClass) end

---Create an OnDead event handler for a group
---@param EventTemplate? any
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? table The self instance of the class for which the event is.
---@return EVENT # self
function EVENT:OnDeadForTemplate(EventTemplate, EventFunction, EventClass) end

---Create an OnLand event handler for a group
---@param EventTemplate? table
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? table The self instance of the class for which the event is.
---@return EVENT # self
function EVENT:OnLandForTemplate(EventTemplate, EventFunction, EventClass) end

---Create an OnTakeOff event handler for a group
---@param EventTemplate? table Template table.
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? table The self instance of the class for which the event is.
---@return EVENT # self
function EVENT:OnTakeOffForTemplate(EventTemplate, EventFunction, EventClass) end

---Create an OnDead event handler for a group
---@param EventTemplate? table
---@param EventFunction? function The function to be called when the event occurs for the unit.
---@param EventClass? any
---@return EVENT
function EVENT:OnEngineShutDownForTemplate(EventTemplate, EventFunction, EventClass) end

---Creation of a New Zone Event.
---@param Zone? ZONE_BASE The Zone created.
function EVENT:CreateEventNewZone(Zone) end

---Creation of a Zone Deletion Event.
---@param Zone? ZONE_BASE The Zone created.
function EVENT:CreateEventDeleteZone(Zone) end

---Creation of a New ZoneGoal Event.
---@param ZoneGoal? ZONE_GOAL The ZoneGoal created.
function EVENT:CreateEventNewZoneGoal(ZoneGoal) end

---Creation of a ZoneGoal Deletion Event.
---@param ZoneGoal? ZONE_GOAL The ZoneGoal created.
function EVENT:CreateEventDeleteZoneGoal(ZoneGoal) end

---Creation of a S_EVENT_PLAYER_ENTER_UNIT Event.
---@param PlayerUnit? UNIT .
function EVENT:CreateEventPlayerEnterUnit(PlayerUnit) end

---Creation of a S_EVENT_PLAYER_ENTER_AIRCRAFT event.
---@param PlayerUnit? UNIT The aircraft unit the player entered.
function EVENT:CreateEventPlayerEnterAircraft(PlayerUnit) end

---Creation of a S_EVENT_NEW_DYNAMIC_CARGO event.
---@param DynamicCargo? DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventNewDynamicCargo(DynamicCargo) end

---Creation of a S_EVENT_DYNAMIC_CARGO_LOADED event.
---@param DynamicCargo? DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventDynamicCargoLoaded(DynamicCargo) end

---Creation of a S_EVENT_DYNAMIC_CARGO_UNLOADED event.
---@param DynamicCargo? DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventDynamicCargoUnloaded(DynamicCargo) end

---Creation of a S_EVENT_DYNAMIC_CARGO_REMOVED event.
---@param DynamicCargo? DYNAMICCARGO the dynamic cargo object
function EVENT:CreateEventDynamicCargoRemoved(DynamicCargo) end

---Main event function.
---@param Event? EVENTDATA Event data table.
function EVENT:onEvent(Event) end

---The EVENTHANDLER structure.
---@class EVENTHANDLER : BASE
EVENTHANDLER = {
  ClassName = "EVENTHANDLER",
  ClassID = 0,
}

---The EVENTHANDLER constructor.
---@return EVENTHANDLER # self
function EVENTHANDLER:New() end
