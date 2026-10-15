---@meta

---@class TARGET.Object
---@field ID number Target unique ID.
---@field Name string Target name.
---@field Type string Target type.
---@field Object POSITIONABLE The object, which can be many things, e.g. a UNIT, GROUP, STATIC, SCENERY, AIRBASE or COORDINATE object.
---@field Life number Life points on last status update.
---@field Life0 number Life points of completely healthy target.
---@field N0 number Number of initial elements.
---@field Ndead number Number of dead elements.
---@field Ndestroyed number Number of destroyed elements.
---@field Status string Status "Alive" or "Dead".
---@field Coordinate COORDINATE of the target object.

---@class TARGET.Resource
---@field MissionType string Mission type, e.g. `AUFTRAG.Type.BAI`.
---@field Nmin number Min number of assets.
---@field Nmax number Max number of assets.
---@field Attributes table Generalized attribute, e.g. `{GROUP.Attribute.GROUND_INFANTRY}`.
---@field Properties table Properties ([DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes)), e.g. `"Attack helicopters"` or `"Mobile AAA"`.
---@field mission AUFTRAG Attached mission.

---TARGET class.
---@class TARGET : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field uid number Unique ID of the target.
---@field lid string Class id string for output to DCS log file.
---@field targets table Table of target objects.
---@field targetcounter number Running number to generate target object IDs.
---@field life number Total life points on last status update.
---@field life0 number Total life points of completely healthy targets.
---@field threatlevel0 number Initial threat level.
---@field category number Target category (Ground, Air, Sea).
---@field N0 number Number of initial target elements/units.
---@field Ntargets0 number Number of initial target objects.
---@field Ndestroyed number Number of target elements/units that were destroyed.
---@field Ndead number Number of target elements/units that are dead (destroyed or despawned).
---@field elements table Table of target elements/units.
---@field casualties table Table of dead element names.
---@field prio number Priority.
---@field importance number Importance.
---@field mission AUFTRAG Mission attached to this target.
---@field contact INTEL.Contact Contact attached to this target.
---@field isDestroyed boolean If true, target objects were destroyed.
---@field resources table Resource list.
---@field conditionStart table Start condition functions.
---@field operation OPERATION Operation this target is part of.
TARGET = {
  ClassName      = "TARGET",
  verbose        =     0,
  lid            =   nil,
  targets        =    {},
  targetcounter  =     0,
  life           =     0,
  life0          =     0,
  N0             =     0,
  Ntargets0      =     0,
  Ndestroyed     =     0,
  Ndead          =     0,
  elements       =    {},
  casualties     =    {},
  threatlevel0   =     0,
  conditionStart =    {},
  TStatus        =    30,
}

---Type.
---@class TARGET.ObjectType
---@field GROUP string Target is a GROUP object.
---@field UNIT string Target is a UNIT object.
---@field STATIC string Target is a STATIC object.
---@field SCENERY string Target is a SCENERY object.
---@field COORDINATE string Target is a COORDINATE.
---@field AIRBASE string Target is an AIRBASE.
---@field ZONE string Target is a ZONE object.
---@field OPSZONE string Target is an OPSZONE object.
TARGET.ObjectType={
  GROUP="Group",
  UNIT="Unit",
  STATIC="Static",
  SCENERY="Scenery",
  COORDINATE="Coordinate",
  AIRBASE="Airbase",
  ZONE="Zone",
  OPSZONE="OpsZone"
}

---Category.
---@class TARGET.Category
---@field AIRCRAFT string
---@field GROUND string
---@field NAVAL string
---@field AIRBASE string
---@field COORDINATE string
---@field ZONE string
TARGET.Category={
  AIRCRAFT="Aircraft",
  GROUND="Ground",
  NAVAL="Naval",
  AIRBASE="Airbase",
  COORDINATE="Coordinate",
  ZONE="Zone",
}

---Object status.
---@class TARGET.ObjectStatus
---@field ALIVE string Object is alive.
---@field DEAD string Object is dead.
---@field DAMAGED string Object is damaged.
TARGET.ObjectStatus={
  ALIVE="Alive",
  DEAD="Dead",
  DAMAGED="Damaged",
}

---TARGET class version.
TARGET.version = "0.7.1"

---Create a new TARGET object and start the FSM.
---@param TargetObject? table Target object. Can be a: UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
---@return TARGET # self
function TARGET:New(TargetObject) end

---Create target data from a given object. Valid objects are:
---
---* GROUP
---* UNIT
---* STATIC
---* SCENERY
---* AIRBASE
---* COORDINATE
---* ZONE
---* SET_GROUP
---* SET_UNIT
---* SET_STATIC
---* SET_SCENERY
---* SET_OPSGROUP
---* SET_ZONE
---* SET_OPSZONE
---@param Object? POSITIONABLE The target UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
function TARGET:AddObject(Object) end

---Set priority of the target.
---@param Priority? number (Optional) Priority of the target. Default 50.
---@return TARGET # self
function TARGET:SetPriority(Priority) end

---Set importance of the target.
---@param Importance? number (Optional) Importance of the target. Default `nil`.
---@return TARGET # self
function TARGET:SetImportance(Importance) end

---Add start condition.
---@param ConditionFunction? function Function that needs to be true before the mission can be started. Must return a #boolean.
---@param ... any
---@return TARGET # self
function TARGET:AddConditionStart(ConditionFunction, ...) end

---Add stop condition.
---@param ConditionFunction? function Function that needs to be true before the mission can be started. Must return a #boolean.
---@param ... any
---@return TARGET # self
function TARGET:AddConditionStop(ConditionFunction, ...) end

---Check if all given condition are true.
---@param Conditions? table Table of conditions.
---@return boolean # If true, all conditions were true. Returns false if at least one condition returned false.
function TARGET:EvalConditionsAll(Conditions) end

---Check if any of the given conditions is true.
---@param Conditions? table Table of conditions.
---@return boolean # If true, at least one condition is true.
function TARGET:EvalConditionsAny(Conditions) end

---Add mission type and number of required assets to resource.
---@param MissionType? string Mission Type.
---@param Nmin? number (Optional) Min number of required assets. Default is 1.
---@param Nmax? number (Optional) Max number of requried assets. Default is 1.
---@param Attributes? table Generalized attribute(s).
---@param Properties? table (Optional) DCS attribute(s). Default `nil`.
---@return TARGET.Resource # The resource table.
function TARGET:AddResource(MissionType, Nmin, Nmax, Attributes, Properties) end

---Check if TARGET is alive.
---@return boolean # If true, target is alive.
function TARGET:IsAlive() end

---Check if TARGET is destroyed.
---@return boolean # If true, target is destroyed.
function TARGET:IsDestroyed() end

---Check if TARGET is dead.
---@return boolean # If true, target is dead.
function TARGET:IsDead() end

---Check if target object is dead.
---@param TargetObject? TARGET.Object|number|string The target object.
---@return boolean # If true, target is dead.
function TARGET:IsTargetDead(TargetObject) end

---Check if target object is alive.
---@param TargetObject? TARGET.Object|number|string The target object.
---@return boolean # If true, target is dead.
function TARGET:IsTargetAlive(TargetObject) end

---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:onafterStart(From, Event, To) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:onafterStatus(From, Event, To) end

---On after "ObjectDamaged" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? TARGET.Object|number|string Target object.
function TARGET:onafterObjectDamaged(From, Event, To, Target) end

---On after "ObjectDestroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? TARGET.Object|number|string Target object.
function TARGET:onafterObjectDestroyed(From, Event, To, Target) end

---On after "ObjectDead" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? TARGET.Object|number|string Target object.
function TARGET:onafterObjectDead(From, Event, To, Target) end

---On after "Damaged" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:onafterDamaged(From, Event, To) end

---On after "Destroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:onafterDestroyed(From, Event, To) end

---On after "Dead" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:onafterDead(From, Event, To) end

---Event function handling the loss of a unit.
---@param EventData? EVENTDATA Event data.
function TARGET:OnEventUnitDeadOrLost(EventData) end

---Create target data from a given object.
---@param Object? POSITIONABLE The target UNIT, GROUP, STATIC, SCENERY, AIRBASE, COORDINATE, ZONE, SET_GROUP, SET_UNIT, SET_STATIC, SET_SCENERY, SET_ZONE
function TARGET:_AddObject(Object) end

---Get target life points.
---@return number # Number of initial life points when mission was planned.
function TARGET:GetLife0() end

---Get current damage.
---@return number # Damage in percent.
function TARGET:GetDamage() end

---Get target life points.
---@param Target? TARGET.Object|number|string Target object.
---@return number # Life points of target.
function TARGET:GetTargetLife(Target) end

---Get current total life points. This is the sum of all target objects.
---@return number # Life points of target.
function TARGET:GetLife() end

---Get target threat level
---@param Target? TARGET.Object|number|string Target object.
---@return number # Threat level of target.
function TARGET:GetTargetThreatLevelMax(Target) end

---Get threat level.
---@return number # Threat level.
function TARGET:GetThreatLevelMax() end

---Get target 2D position vector.
---@param Target? TARGET.Object|number|string Target object.
---@return Vec2 # Vector with x,y components.
function TARGET:GetTargetVec2(Target) end

---Get target 3D position vector.
---@param Target? TARGET.Object|number|string Target object.
---@param Average? boolean
---@return Vec3 # Vector with x,y,z components.
function TARGET:GetTargetVec3(Target, Average) end

---Get heading of the target.
---@param Target? TARGET.Object|number|string Target object.
---@return number # Heading in degrees.
function TARGET:GetTargetHeading(Target) end

---Get target coordinate.
---@param Target? TARGET.Object|number|string Target object.
---@param Average? boolean
---@return COORDINATE # Coordinate of the target.
function TARGET:GetTargetCoordinate(Target, Average) end

---Get target name.
---@param Target? TARGET.Object|number|string Target object.
---@return string # Name of the target object.
function TARGET:GetTargetName(Target) end

---Get name.
---@return string # Name of the target usually the first object.
function TARGET:GetName() end

---Get 2D vector.
---@return Vec2 # 2D vector of the target.
function TARGET:GetVec2() end

---Get 3D vector.
---@return Vec3 # 3D vector of the target.
function TARGET:GetVec3() end

---Get coordinate.
---@return COORDINATE # Coordinate of the target.
function TARGET:GetCoordinate() end

---Get average coordinate.
---@return COORDINATE # Coordinate of the target.
function TARGET:GetAverageCoordinate() end

---Get coordinates of all targets. (e.g. for a SET_STATIC)
---@return table # Table with coordinates of all targets.
function TARGET:GetCoordinates() end

---Get heading of target.
---@return number # Heading of the target in degrees.
function TARGET:GetHeading() end

---Get category.
---@return string # Target category. See `TARGET.Category.X`, where `X=AIRCRAFT, GROUND`.
function TARGET:GetCategory() end

---Get target category.
---@param Target? TARGET.Object|number|string Target object.
---@return TARGET.Category # Target category.
function TARGET:GetTargetCategory(Target) end

---Get coalition of target object. If an object has no coalition (*e.g.* a coordinate) it is returned as neutral.
---@param Target? TARGET.Object|number|string Target object.
---@return number # Coalition number.
function TARGET:GetTargetCoalition(Target) end

---Get a target object by its name.
---@param ObjectName? string Object name.
---@return TARGET.Object # The target object table or nil.
function TARGET:GetTargetByName(ObjectName) end

---Get the first target objective alive.
---@param RefCoordinate? COORDINATE (Optional) Reference coordinate to determine the closest target objective.
---@param Coalitions? table (Optional) Only consider targets of the given coalition(s).
---@return TARGET.Object # The target objective.
function TARGET:GetObjective(RefCoordinate, Coalitions) end

---Get the first target object alive.
---@param RefCoordinate? COORDINATE Reference coordinate to determine the closest target objective.
---@param Coalitions? table (Optional) Only consider targets of the given coalition(s).
---@return POSITIONABLE # The target object or nil.
function TARGET:GetObject(RefCoordinate, Coalitions) end

---Get all target objects.
---@return table # List of target objects.
function TARGET:GetObjects() end

---Count alive objects.
---@param Target? TARGET.Object|number|string Target objective.
---@param Coalitions? table (Optional) Only count targets of the given coalition(s).
---@param OnlyReallyAlive? boolean (Optional) If `true`, count only really alive targets (units, groups) but not coordinates or zones.
---@return number # Number of alive target objects.
function TARGET:CountObjectives(Target, Coalitions, OnlyReallyAlive) end

---Count alive targets.
---@param Coalitions? table (Optional) Only count targets of the given coalition(s).
---@param OnlyReallyAlive? boolean (Optional) If `true`, count only really alive targets (units, groups) but not coordinates or zones.
---@return number # Number of alive target objects.
function TARGET:CountTargets(Coalitions, OnlyReallyAlive) end

---Check if something is an element of the TARGET.
---@param Name? string The name of the potential element.
---@return boolean # If `true`, this name is part of this TARGET.
function TARGET:IsElement(Name) end

---Check if something is a a casualty of this TARGET.
---@param Name? string The name of the potential element.
---@return boolean # If `true`, this name is a casualty of this TARGET.
function TARGET:IsCasualty(Name) end

---Triggers the FSM event "Start". Starts the TARGET. Initializes parameters and starts event handlers.
function TARGET:Start() end

---Triggers the FSM event "Start" after a delay. Starts the TARGET. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function TARGET:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the TARGET and all its event handlers.
---@param delay? number Delay in seconds.
function TARGET:__Stop(delay) end

---Triggers the FSM event "Status".
function TARGET:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function TARGET:__Status(delay) end

---Triggers the FSM event "ObjectDamaged".
---@param Target? TARGET.Object|number|string Target object.
function TARGET:ObjectDamaged(Target) end

---Triggers the FSM event "ObjectDestroyed".
---@param Target? TARGET.Object|number|string Target object.
function TARGET:ObjectDestroyed(Target) end

---Triggers the FSM event "ObjectDead".
---@param Target? TARGET.Object|number|string Target object.
function TARGET:ObjectDead(Target) end

---Triggers the FSM event "Damaged".
function TARGET:Damaged() end

---Triggers the FSM event "Destroyed".
function TARGET:Destroyed() end

---Triggers the FSM event "Dead".
function TARGET:Dead() end

---On After "ObjectDamaged" event. A (sub-) target object has been damaged, e.g. a UNIT of a GROUP, or an object of a SET
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? TARGET.Object|number|string Target object.
function TARGET:OnAfterObjectDamaged(From, Event, To, Target) end

---On After "ObjectDestroyed" event. A (sub-) target object has been destroyed, e.g. a UNIT of a GROUP, or an object of a SET
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? TARGET.Object|number|string Target object.
function TARGET:OnAfterObjectDestroyed(From, Event, To, Target) end

---On After "ObjectDead" event. A (sub-) target object is dead, e.g. a UNIT of a GROUP, or an object of a SET
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? TARGET.Object|number|string Target object.
function TARGET:OnAfterObjectDead(From, Event, To, Target) end

---On After "Damaged" event. Any of the target objects has been damaged.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:OnAfterDamaged(From, Event, To) end

---On After "Destroyed" event. All target objects have been destroyed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:OnAfterDestroyed(From, Event, To) end

---On After "Dead" event. All target objects are dead.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function TARGET:OnAfterDead(From, Event, To) end
