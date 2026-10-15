---@meta

---@class CHIEF.Resource
---@field MissionType string Mission type, e.g. `AUFTRAG.Type.BAI`.
---@field Nmin number Min number of assets.
---@field Nmax number Max number of assets.
---@field Attributes table Generalized attribute, e.g. `{GROUP.Attribute.GROUND_INFANTRY}`.
---@field Properties table Properties ([DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes)), e.g. `"Attack helicopters"` or `"Mobile AAA"`.
---@field Categories table Categories Group categories.
---@field mission AUFTRAG Attached mission.
---@field carrierNmin number Min number of assets.
---@field carrierNmax number Max number of assets.
---@field carrierCategories table Group categories.
---@field carrierAttributes table Generalized attribute, e.g. `{GROUP.Attribute.GROUND_INFANTRY}`.
---@field carrierProperties table Properties ([DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes)), e.g. `"Attack helicopters"` or `"Mobile AAA"`.

---@class CHIEF.Resources
---@field List CHIEF.Resource of resources.

---@class CHIEF.StrategicZone
---@field opszone OPSZONE OPS zone.
---@field prio number Priority.
---@field importance number Importance.
---@field resourceEmpty CHIEF.Resources List of resources employed when the zone is empty.
---@field resourceOccup CHIEF.Resources List of resources employed when the zone is occupied by an enemy.
---@field missions table Mission.

---@class CHIEF.AssetNumber
---@field nAssetMin number Min number of assets.
---@field nAssetMax number Max number of assets.
---@field threatlevel number Threat level.
---@field targetCategory string Target category.
---@field missionType string Mission type.
---@field nUnits number Number of enemy units.
---@field defcon string Defense condition.
---@field strategy string Strategy.

---@class CHIEF.MissionPerformance
---@field MissionType string Mission Type.
---@field Performance number Performance: a number between 0 and 100, where 100 is best performance.

---CHIEF class.
---@class CHIEF : INTEL
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field targetqueue table Target queue.
---@field zonequeue table Strategic zone queue.
---@field borderzoneset SET_ZONE Set of zones defining the border of our territory.
---@field yellowzoneset SET_ZONE Set of zones defining the extended border. Defcon is set to YELLOW if enemy activity is detected.
---@field engagezoneset SET_ZONE Set of zones where enemies are actively engaged.
---@field threatLevelMin number Lowest threat level of targets to attack.
---@field threatLevelMax number Highest threat level of targets to attack.
---@field Defcon string Defence condition.
---@field strategy string Strategy of the CHIEF.
---@field commander COMMANDER Commander of assigned legions.
---@field Nsuccess number Number of successful missions.
---@field Nfailure number Number of failed mission.
---@field assetNumbers table Asset numbers. Each entry is a table of data type `#CHIEF.AssetNumber`.
CHIEF = {
  ClassName      = "CHIEF",
  verbose        =     0,
  lid            =   nil,
  targetqueue    =    {},
  zonequeue      =    {},
  borderzoneset  =   nil,
  yellowzoneset  =   nil,
  engagezoneset  =   nil,
  tacview        = false,
  Nsuccess       =     0,
  Nfailure       =     0,
  LegionRecruitMinRange = {}
}

---Defence condition.
---@class CHIEF.DEFCON
---@field GREEN string No enemy activities detected in our terretory or conflict zones.
---@field YELLOW string Enemy in conflict zones.
---@field RED string Enemy within our border.
CHIEF.DEFCON = {
  GREEN="Green",
  YELLOW="Yellow",
  RED="Red",
}

---Strategy.
---@class CHIEF.Strategy
---@field PASSIVE string No targets at all are engaged.
---@field DEFENSIVE string Only target in our own terretory are engaged.
---@field OFFENSIVE string Targets in own terretory and yellow zones are engaged.
---@field AGGRESSIVE string Targets in own terretory, conflict zones and attack zones are engaged.
---@field TOTALWAR string Anything is engaged anywhere.
CHIEF.Strategy = {
  PASSIVE="Passive",
  DEFENSIVE="Defensive",
  OFFENSIVE="Offensive",
  AGGRESSIVE="Aggressive",
  TOTALWAR="Total War"
}

---CHIEF class version.
CHIEF.version = "0.7.1"

---Create a new CHIEF object and start the FSM.
---@param Coalition? number Coalition side, e.g. `coaliton.side.BLUE`. Can also be passed as a string "red", "blue" or "neutral".
---@param AgentSet? SET_GROUP (Optional) Set of agents (groups) providing intel. Default is an empty set.
---@param Alias? string (Optional) An *optional* alias how this object is called in the logs etc.
---@return CHIEF # self
function CHIEF:New(Coalition, AgentSet, Alias) end

---Set this to be an air-to-any dispatcher, i.e. engaging air, ground and naval targets. This is the default anyway.
---@return CHIEF # self
function CHIEF:SetAirToAny() end

---Set this to be an air-to-air dispatcher.
---@return CHIEF # self
function CHIEF:SetAirToAir() end

---Set this to be an air-to-ground dispatcher, i.e. engage only ground units
---@return CHIEF # self
function CHIEF:SetAirToGround() end

---Set this to be an air-to-sea dispatcher, i.e. engage only naval units.
---@return CHIEF # self
function CHIEF:SetAirToSea() end

---Set this to be an air-to-surface dispatcher, i.e. engaging ground and naval groups.
---@return CHIEF # self
function CHIEF:SetAirToSurface() end

---Set a threat level range that will be engaged. Threat level is a number between 0 and 10, where 10 is a very dangerous threat.
---Targets with threat level 0 are usually harmless.
---@param ThreatLevelMin? number (Optional) Min threat level. Default 1.
---@param ThreatLevelMax? number (Optional) Max threat level. Default 10.
---@return CHIEF # self
function CHIEF:SetThreatLevelRange(ThreatLevelMin, ThreatLevelMax) end

---Set defence condition.
---@param Defcon? string Defence condition. See @{#CHIEF.DEFCON}, e.g. `CHIEF.DEFCON.RED`.
---@return CHIEF # self
function CHIEF:SetDefcon(Defcon) end

---Create a new resource list of required assets.
---@param MissionType? string The mission type.
---@param Nmin? number (Optional) Min number of required assets. Default 1.
---@param Nmax? number (Optional) Max number of requried assets. Default 1.
---@param Attributes? table (Optional) Generalized attribute(s). Default `nil`.
---@param Properties? table (Optional) DCS attribute(s). Default `nil`.
---@param Categories? any Group categories.
---@return CHIEF.Resources # The newly created resource list table.
---@return CHIEF.Resource # The resource object that was added.
function CHIEF:CreateResource(MissionType, Nmin, Nmax, Attributes, Properties, Categories) end

---Add mission type and number of required assets to resource list.
---@param Resource? CHIEF.Resources|number|string List of resources.
---@param MissionType? string Mission Type.
---@param Nmin? number (Optional) Min number of required assets. Default 1.
---@param Nmax? number (Optional) Max number of requried assets. Default equal `Nmin`.
---@param Attributes? table Generalized attribute(s).
---@param Properties? table DCS attribute(s). Default `nil`.
---@param Categories? any Group categories.
---@return CHIEF.Resource # Resource table.
function CHIEF:AddToResource(Resource, MissionType, Nmin, Nmax, Attributes, Properties, Categories) end

---Define which assets will be transported and define the number and attributes/properties of the cargo carrier assets.
---@param Resource? CHIEF.Resource|number|string Resource table.
---@param Nmin? number (Optional) Min number of required assets. Default 1.
---@param Nmax? number (Optional) Max number of requried assets. Default is equal to `Nmin`.
---@param CarrierAttributes? table Generalized attribute(s) of the carrier assets.
---@param CarrierProperties? table DCS attribute(s) of the carrier assets.
---@param CarrierCategories? any Group categories of the carrier assets.
---@return CHIEF # self
function CHIEF:AddTransportToResource(Resource, Nmin, Nmax, CarrierAttributes, CarrierProperties, CarrierCategories) end

---Delete mission type from resource list. All running missions are cancelled.
---@param Resource? table Resource table.
---@param MissionType? string Mission Type.
---@return CHIEF # self
function CHIEF:DeleteFromResource(Resource, MissionType) end

---Set number of assets requested for detected targets.
---@param NassetsMin? number (Optional) Min number of assets. Should be at least 1. Default 1.
---@param NassetsMax? number (Optional) Max number of assets. Default is same as `NassetsMin`.
---@param ThreatLevel? number (Optional) Only apply this setting if the target threat level is greater or equal this number. Default 0.
---@param TargetCategory? any Only apply this setting if the target is of this category, e.g. `TARGET.Category.AIRCRAFT`.
---@param MissionType? string Only apply this setting for this mission type, e.g. `AUFTRAG.Type.INTERCEPT`.
---@param Nunits? string (Optional) Only apply this setting if the number of enemy units is greater or equal this number. Defaults to 1.
---@param Defcon? string Only apply this setting if this defense condition is in place.
---@param Strategy? string Only apply this setting if this strategy is in currently. place.
---@return CHIEF # self
function CHIEF:SetResponseOnTarget(NassetsMin, NassetsMax, ThreatLevel, TargetCategory, MissionType, Nunits, Defcon, Strategy) end

---Add mission type and number of required assets to resource.
---@param Target? TARGET The target.
---@param MissionType? string Mission type.
---@return number # Number of min assets.
---@return number # Number of max assets.
function CHIEF:_GetAssetsForTarget(Target, MissionType) end

---Get defence condition.
---@param Defcon? any
function CHIEF:GetDefcon(Defcon) end

---Set limit for number of total or specific missions to be executed simultaniously.
---@param Limit? number (Optional) Number of max. mission of this type. Default 10.
---@param MissionType? string (Optional) Type of mission, e.g. `AUFTRAG.Type.BAI`. Default `"Total"` for total number of missions.
---@return CHIEF # self
function CHIEF:SetLimitMission(Limit, MissionType) end

---Set tactical overview on.
---@return CHIEF # self
function CHIEF:SetTacticalOverviewOn() end

---Set tactical overview off.
---@return CHIEF # self
function CHIEF:SetTacticalOverviewOff() end

---Set strategy.
---@param Strategy? string (Optional) Strategy. See @{#CHIEF.strategy}, e.g. `CHIEF.Strategy.DEFENSIVE` (default).
---@return CHIEF # self
function CHIEF:SetStrategy(Strategy) end

---Get current strategy.
---@return string # Strategy.
function CHIEF:GetStrategy() end

---Get defence condition.
---@param Defcon? any
function CHIEF:GetDefcon(Defcon) end

---Get the commander.
---@return COMMANDER # The commander.
function CHIEF:GetCommander() end

---Add an AIRWING to the chief's commander.
---@param Airwing? AIRWING The airwing to add.
---@return CHIEF # self
function CHIEF:AddAirwing(Airwing) end

---Add a BRIGADE to the chief's commander.
---@param Brigade? BRIGADE The brigade to add.
---@return CHIEF # self
function CHIEF:AddBrigade(Brigade) end

---Add a FLEET to the chief's commander.
---@param Fleet? FLEET The fleet to add.
---@return CHIEF # self
function CHIEF:AddFleet(Fleet) end

---Add a LEGION to the chief's commander.
---@param Legion? LEGION The legion to add.
---@return CHIEF # self
function CHIEF:AddLegion(Legion) end

---Remove a LEGION to the chief's commander.
---@param Legion? LEGION The legion to add.
---@return CHIEF # self
function CHIEF:RemoveLegion(Legion) end

---Add mission to mission queue of the COMMANDER.
---@param Mission? AUFTRAG Mission to be added.
---@return CHIEF # self
function CHIEF:AddMission(Mission) end

---Remove mission from queue.
---@param Mission? AUFTRAG Mission to be removed.
---@return CHIEF # self
function CHIEF:RemoveMission(Mission) end

---Add transport to transport queue of the COMMANDER.
---@param Transport? OPSTRANSPORT Transport to be added.
---@return CHIEF # self
function CHIEF:AddOpsTransport(Transport) end

---Remove transport from queue.
---@param Transport? OPSTRANSPORT Transport to be removed.
---@return CHIEF # self
function CHIEF:RemoveTransport(Transport) end

---Add target.
---@param Target? TARGET Target object to be added.
---@return CHIEF # self
function CHIEF:AddTarget(Target) end

---Check if a TARGET is already in the queue.
---@param Target? TARGET Target object to be added.
---@return boolean # If `true`, target exists in the target queue.
function CHIEF:IsTarget(Target) end

---Remove target from queue.
---@param Target? TARGET The target.
---@return CHIEF # self
function CHIEF:RemoveTarget(Target) end

---Add strategically important zone.
---By default two resource lists are created. One for the case that the zone is empty and the other for the case that the zone is occupied.
---
---Occupied:
---
---* `AUFTRAG.Type.ARTY` with Nmin=1, Nmax=2
---* `AUFTRAG.Type.CASENHANCED` with Nmin=1, Nmax=2
---
---Empty:
---
---* `AUFTRAG.Type.ONGURAD` with Nmin=0 and Nmax=1 assets, Attribute=`GROUP.Attribute.GROUND_TANK`.
---* `AUFTRAG.Type.ONGURAD` with Nmin=0 and Nmax=1 assets, Attribute=`GROUP.Attribute.GROUND_IFV`.
---* `AUFTRAG.Type.ONGUARD` with Nmin=1 and Nmax=3 assets, Attribute=`GROUP.Attribute.GROUND_INFANTRY`.
---* `AUFTRAG.Type.OPSTRANSPORT` with Nmin=0 and Nmax=1 assets, Attribute=`GROUP.Attribute.AIR_TRANSPORTHELO` or `GROUP.Attribute.GROUND_APC`. This asset is used to transport the infantry groups.
---
---Resources can be created with the {#CHIEF.CreateResource} and {#CHIEF.AddToResource} functions.
---@param OpsZone? OPSZONE OPS zone object.
---@param Priority? number (Optional) Priority. Default 50.
---@param Importance? number (Optional) Importance. Default `#nil`.
---@param ResourceOccupied? CHIEF.Resources|number|string (Optional) Resources used then zone is occupied by the enemy.
---@param ResourceEmpty? CHIEF.Resources|number|string (Optional) Resources used then zone is empty.
---@return CHIEF.StrategicZone # The strategic zone.
function CHIEF:AddStrategicZone(OpsZone, Priority, Importance, ResourceOccupied, ResourceEmpty) end

---Set the resource list of missions and assets employed when the zone is empty.
---@param StrategicZone? CHIEF.StrategicZone|number|string The strategic zone.
---@param Resource? CHIEF.Resource|number|string Resource list of missions and assets.
---@param NoCopy? boolean If `true`, do **not** create a deep copy of the resource.
---@return CHIEF # self
function CHIEF:SetStrategicZoneResourceEmpty(StrategicZone, Resource, NoCopy) end

---Set the resource list of missions and assets employed when the zone is occupied by the enemy.
---@param StrategicZone? CHIEF.StrategicZone|number|string The strategic zone.
---@param Resource? CHIEF.Resource|number|string Resource list of missions and assets.
---@param NoCopy? boolean If `true`, do **not** create a deep copy of the resource.
---@return CHIEF # self
function CHIEF:SetStrategicZoneResourceOccupied(StrategicZone, Resource, NoCopy) end

---Get the resource list of missions and assets employed when the zone is empty.
---@param StrategicZone? CHIEF.StrategicZone|number|string The strategic zone.
---@return CHIEF.Resource # Resource list of missions and assets.
function CHIEF:GetStrategicZoneResourceEmpty(StrategicZone) end

---Get the resource list of missions and assets employed when the zone is occupied by the enemy.
---@param StrategicZone? CHIEF.StrategicZone|number|string The strategic zone.
---@return CHIEF.Resource # Resource list of missions and assets.
function CHIEF:GetStrategicZoneResourceOccupied(StrategicZone) end

---Remove strategically important zone. All runing missions are cancelled.
---@param OpsZone? OPSZONE OPS zone object.
---@param Delay? number (Optional) Delay in seconds before the zone is removed. Default immidiately.
---@return CHIEF # self
function CHIEF:RemoveStrategicZone(OpsZone, Delay) end

---Add a rearming zone.
---@param RearmingZone? ZONE Rearming zone.
---@return BRIGADE.SupplyZone # The rearming zone data.
function CHIEF:AddRearmingZone(RearmingZone) end

---Add a refuelling zone.
---@param RefuellingZone? ZONE Refuelling zone.
---@return BRIGADE.SupplyZone # The refuelling zone data.
function CHIEF:AddRefuellingZone(RefuellingZone) end

---Add a CAP zone. Flights will engage detected targets inside this zone.
---@param Zone? ZONE CAP Zone. Has to be a circular zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional)  Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone # The CAP zone data.
function CHIEF:AddCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a GCI CAP.
---@param Zone? ZONE Zone, where the flight orbits.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone # The CAP zone data.
function CHIEF:AddGciCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Remove a GCI CAP
---@param Zone? ZONE Zone, where the flight orbits.
function CHIEF:RemoveGciCapZone(Zone) end

---Add an AWACS zone.
---@param Zone? ZONE Zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone # The AWACS zone data.
function CHIEF:AddAwacsZone(Zone, Altitude, Speed, Heading, Leg) end

---Remove a AWACS zone.
---@param Zone? ZONE Zone, where the flight orbits.
function CHIEF:RemoveAwacsZone(Zone) end

---Add a refuelling tanker zone.
---@param Zone? ZONE Zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@param RefuelSystem? number Refuelling system.
---@return AIRWING.TankerZone # The tanker zone data.
function CHIEF:AddTankerZone(Zone, Altitude, Speed, Heading, Leg, RefuelSystem) end

---Remove a refuelling tanker zone.
---@param Zone? ZONE Zone, where the flight orbits.
function CHIEF:RemoveTankerZone(Zone) end

---Set border zone set, defining your territory.
---
---* Detected enemy troops in these zones will trigger defence condition `RED`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.DEFENSIVE`.
---@param BorderZoneSet? SET_ZONE Set of zones defining our borders.
---@return CHIEF # self
function CHIEF:SetBorderZones(BorderZoneSet) end

---Add a zone defining your territory.
---
---* Detected enemy troops in these zones will trigger defence condition `RED`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.DEFENSIVE`.
---@param Zone? ZONE The zone to be added.
---@return CHIEF # self
function CHIEF:AddBorderZone(Zone) end

---Remove a border zone defining your territory.
---@param Zone? ZONE The zone to be removed.
---@return CHIEF # self
function CHIEF:RemoveBorderZone(Zone) end

---Set conflict zone set.
---
---* Detected enemy troops in these zones will trigger defence condition `YELLOW`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.OFFENSIVE`.
---@param ZoneSet? SET_ZONE Set of zones.
---@return CHIEF # self
function CHIEF:SetConflictZones(ZoneSet) end

---Add a conflict zone.
---
---* Detected enemy troops in these zones will trigger defence condition `YELLOW`.
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.OFFENSIVE`.
---@param Zone? ZONE The zone to be added.
---@return CHIEF # self
function CHIEF:AddConflictZone(Zone) end

---Remove a conflict zone.
---@param Zone? ZONE The zone to be removed.
---@return CHIEF # self
function CHIEF:RemoveConflictZone(Zone) end

---Set attack zone set.
---
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.AGGRESSIVE`.
---@param ZoneSet? SET_ZONE Set of zones.
---@return CHIEF # self
function CHIEF:SetAttackZones(ZoneSet) end

---Add an attack zone.
---
---* Enemies in these zones will only be engaged if strategy is at least `CHIEF.STRATEGY.AGGRESSIVE`.
---@param Zone? ZONE The zone to add.
---@return CHIEF # self
function CHIEF:AddAttackZone(Zone) end

---Remove an attack zone.
---@param Zone? ZONE The zone to be removed.
---@return CHIEF # self
function CHIEF:RemoveAttackZone(Zone) end

---Allow chief to use GROUND units for transport tasks. Helicopters are still preferred, and be aware there's no check as of now
---if a destination can be reached on land.
---@return CHIEF # self
function CHIEF:AllowGroundTransport() end

---Forbid chief to use GROUND units for transport tasks. Restrict to Helicopters. This is the default
---@return CHIEF # self
function CHIEF:ForbidGroundTransport() end

---Check if current strategy is passive.
---@return boolean # If `true`, strategy is passive.
function CHIEF:IsPassive() end

---Check if current strategy is defensive.
---@return boolean # If `true`, strategy is defensive.
function CHIEF:IsDefensive() end

---Check if current strategy is offensive.
---@return boolean # If `true`, strategy is offensive.
function CHIEF:IsOffensive() end

---Check if current strategy is aggressive.
---@return boolean # If `true`, strategy is agressive.
function CHIEF:IsAgressive() end

---Check if current strategy is total war.
---@return boolean # If `true`, strategy is total war.
function CHIEF:IsTotalWar() end

---On after Start event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function CHIEF:onafterStart(From, Event, To) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function CHIEF:onafterStatus(From, Event, To) end

---On after "MissionAssignToAny" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function CHIEF:onafterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
function CHIEF:onafterMissionCancel(From, Event, To, Mission) end

---On after "TransportCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Transport? OPSTRANSPORT The transport.
function CHIEF:onafterTransportCancel(From, Event, To, Transport) end

---On after "DefconChange" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Defcon? string New defence condition.
function CHIEF:onafterDefconChange(From, Event, To, Defcon) end

---On after "StrategyChange" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Strategy? string
function CHIEF:onafterStrategyChange(From, Event, To, Strategy) end

---On after "OpsOnMission".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP Ops group on mission
---@param Mission? AUFTRAG The requested mission.
function CHIEF:onafterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---On after "ZoneCaptured".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE The zone that was captured by us.
function CHIEF:onafterZoneCaptured(From, Event, To, OpsZone) end

---On after "ZoneLost".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE The zone that was lost.
function CHIEF:onafterZoneLost(From, Event, To, OpsZone) end

---On after "ZoneEmpty".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE The zone that is empty now.
function CHIEF:onafterZoneEmpty(From, Event, To, OpsZone) end

---On after "ZoneAttacked".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE The zone that being attacked.
function CHIEF:onafterZoneAttacked(From, Event, To, OpsZone) end

---Display tactical overview.
function CHIEF:_TacticalOverview() end

---Check target queue and assign ONE valid target by adding it to the mission queue of the COMMANDER.
function CHIEF:CheckTargetQueue() end

---Check if limit of missions has been reached.
---@param MissionType? string Type of mission.
---@return boolean # If `true`, mission limit has **not** been reached. If `false`, limit has been reached.
function CHIEF:_CheckMissionLimit(MissionType) end

---Get mission limit.
---@param MissionType? string Type of mission.
---@return number # Limit. Unlimited mission types are returned as 999.
function CHIEF:GetMissionLimit(MissionType) end

---Check strategic zone queue.
function CHIEF:CheckOpsZoneQueue() end

---Check if group is inside our border.
---@param group? GROUP The group.
---@return boolean # If true, group is in any border zone.
function CHIEF:CheckGroupInBorder(group) end

---Check if group is in a conflict zone.
---@param group? GROUP The group.
---@return boolean # If true, group is in any conflict zone.
function CHIEF:CheckGroupInConflict(group) end

---Check if group is in a attack zone.
---@param group? GROUP The group.
---@return boolean # If true, group is in any attack zone.
function CHIEF:CheckGroupInAttack(group) end

---Check if group is inside a zone.
---@param group? GROUP The group.
---@param zoneset? SET_ZONE Set of zones.
---@return boolean # If true, group is in any zone.
function CHIEF:CheckGroupInZones(group, zoneset) end

---Check if group is inside a zone.
---@param target? TARGET The target.
---@param zoneset? SET_ZONE Set of zones.
---@return boolean # If true, group is in any zone.
function CHIEF:CheckTargetInZones(target, zoneset) end

---Create a mission performance table.
---@param MissionType? string Mission type.
---@param Performance? number Performance.
---@return CHIEF.MissionPerformance # Mission performance.
function CHIEF:_CreateMissionPerformance(MissionType, Performance) end

---Get mission performance for a given TARGET.
---@param Target? TARGET The target.
---@return table # Mission performances of type `#CHIEF.MissionPerformance`.
function CHIEF:_GetMissionPerformanceFromTarget(Target) end

---Get mission performances for a given Group Attribute.
---@param Attribute? string Group attibute.
---@return table # Mission performances of type `#CHIEF.MissionPerformance`.
function CHIEF:_GetMissionTypeForGroupAttribute(Attribute) end

---Recruit assets for a given OPS zone.
---@param StratZone? CHIEF.StrategicZone|number|string The strategic zone.
---@param Resource? CHIEF.Resource|number|string The required resources.
---@return boolean # If `true` enough assets could be recruited.
function CHIEF:RecruitAssetsForZone(StratZone, Resource) end

---Filter assets, which have certain categories, attributes and/or properties.
---@param Assets? table The assets to be filtered.
---@param Categories? any Group categories.
---@param Attributes? table Generalized attributes.
---@param Properties? table DCS attributes
---@return table # Table of filtered assets.
function CHIEF._FilterAssets(Assets, Categories, Attributes, Properties) end

---Check if a given asset has certain attribute(s).
---@param Asset? WAREHOUSE.Assetitem|number|string The asset item.
---@param Attributes? table The required attributes. See `WAREHOUSE.Attribute` enum. Can also be passed as a single attribute `#string`.
---@return boolean # Returns `true`, the asset has at least one requested attribute.
function CHIEF._CheckAssetAttributes(Asset, Attributes) end

---Check if a given asset has certain categories.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset item.
---@param Categories? any DCS group categories.
---@return boolean # Returns `true`, the asset has at least one requested category.
function CHIEF._CheckAssetCategories(Asset, Categories) end

---Check if a given asset has certain properties.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset item.
---@param Properties? any
---@return boolean # Returns `true`, the asset has at least one requested property.
function CHIEF._CheckAssetProperties(Asset, Properties) end

---Checks whether or not any of the legions con run a mission.
---@param Mission? AUFTRAG The mission.
---@return boolean # If `true`, one of the cohorts can run the mission.
function CHIEF:CanMission(Mission) end

---Exclude legion recruitment that are below a minimum range to target based on the target category.
---Ex. Prevent intercepts from spawning too close to the target.
---@param TargetCategory? any The target category.
---@param MinRange? number Minimum range in meters.
function CHIEF:AddLegionRecruitMinRange(TargetCategory, MinRange) end

---Triggers the FSM event "Start".
function CHIEF:Start() end

---Triggers the FSM event "Start" after a delay.
---@param delay? number Delay in seconds.
function CHIEF:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---@param delay? number Delay in seconds.
function CHIEF:__Stop(delay) end

---Triggers the FSM event "Status".
function CHIEF:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function CHIEF:__Status(delay) end

---Triggers the FSM event "DefconChange".
---@param Defcon? string New Defence Condition.
function CHIEF:DefconChange(Defcon) end

---Triggers the FSM event "DefconChange" after a delay.
---@param delay? number Delay in seconds.
---@param Defcon? string New Defence Condition.
function CHIEF:__DefconChange(delay, Defcon) end

---On after "DefconChange" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Defcon? string New Defence Condition.
function CHIEF:OnAfterDefconChange(From, Event, To, Defcon) end

---Triggers the FSM event "StrategyChange".
---@param Strategy? string New strategy.
function CHIEF:StrategyChange(Strategy) end

---Triggers the FSM event "StrategyChange" after a delay.
---@param delay? number Delay in seconds.
---@param Strategy? string New strategy.
function CHIEF:__StrategyChange(delay, Strategy) end

---On after "StrategyChange" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Strategy? string New strategy.
function CHIEF:OnAfterStrategyChange(From, Event, To, Strategy) end

---Triggers the FSM event "MissionAssign".
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function CHIEF:MissionAssign(Mission, Legions) end

---Triggers the FSM event "MissionAssign" after a delay.
---@param delay? number Delay in seconds.
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function CHIEF:__MissionAssign(delay, Mission, Legions) end

---On after "MissionAssign" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function CHIEF:OnAfterMissionAssign(From, Event, To, Mission, Legions) end

---Triggers the FSM event "MissionCancel".
---@param Mission? AUFTRAG The mission.
function CHIEF:MissionCancel(Mission) end

---Triggers the FSM event "MissionCancel" after a delay.
---@param delay? number Delay in seconds.
---@param Mission? AUFTRAG The mission.
function CHIEF:__MissionCancel(delay, Mission) end

---On after "MissionCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
function CHIEF:OnAfterMissionCancel(From, Event, To, Mission) end

---Triggers the FSM event "TransportCancel".
---@param Transport? OPSTRANSPORT The transport.
function CHIEF:TransportCancel(Transport) end

---Triggers the FSM event "TransportCancel" after a delay.
---@param delay? number Delay in seconds.
---@param Transport? OPSTRANSPORT The transport.
function CHIEF:__TransportCancel(delay, Transport) end

---On after "TransportCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Transport? OPSTRANSPORT The transport.
function CHIEF:OnAfterTransportCancel(From, Event, To, Transport) end

---Triggers the FSM event "OpsOnMission".
---@param OpsGroup? OPSGROUP The OPS group on mission.
---@param Mission? AUFTRAG The mission.
function CHIEF:OpsOnMission(OpsGroup, Mission) end

---Triggers the FSM event "OpsOnMission" after a delay.
---@param delay? number Delay in seconds.
---@param OpsGroup? OPSGROUP The OPS group on mission.
---@param Mission? AUFTRAG The mission.
function CHIEF:__OpsOnMission(delay, OpsGroup, Mission) end

---On after "OpsOnMission" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP The OPS group on mission.
---@param Mission? AUFTRAG The mission.
function CHIEF:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---Triggers the FSM event "ZoneCaptured".
---@param OpsZone? OPSZONE Zone that was captured.
function CHIEF:ZoneCaptured(OpsZone) end

---Triggers the FSM event "ZoneCaptured" after a delay.
---@param delay? number Delay in seconds.
---@param OpsZone? OPSZONE Zone that was captured.
function CHIEF:__ZoneCaptured(delay, OpsZone) end

---On after "ZoneCaptured" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE Zone that was captured.
function CHIEF:OnAfterZoneCaptured(From, Event, To, OpsZone) end

---Triggers the FSM event "ZoneLost".
---@param OpsZone? OPSZONE Zone that was lost.
function CHIEF:ZoneLost(OpsZone) end

---Triggers the FSM event "ZoneLost" after a delay.
---@param delay? number Delay in seconds.
---@param OpsZone? OPSZONE Zone that was lost.
function CHIEF:__ZoneLost(delay, OpsZone) end

---On after "ZoneLost" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE Zone that was lost.
function CHIEF:OnAfterZoneLost(From, Event, To, OpsZone) end

---Triggers the FSM event "ZoneEmpty".
---@param OpsZone? OPSZONE Zone that is empty now.
function CHIEF:ZoneEmpty(OpsZone) end

---Triggers the FSM event "ZoneEmpty" after a delay.
---@param delay? number Delay in seconds.
---@param OpsZone? OPSZONE Zone that is empty now.
function CHIEF:__ZoneEmpty(delay, OpsZone) end

---On after "ZoneEmpty" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE Zone that is empty now.
function CHIEF:OnAfterZoneEmpty(From, Event, To, OpsZone) end

---Triggers the FSM event "ZoneAttacked".
---@param OpsZone? OPSZONE Zone that is being attacked.
function CHIEF:ZoneAttacked(OpsZone) end

---Triggers the FSM event "ZoneAttacked" after a delay.
---@param delay? number Delay in seconds.
---@param OpsZone? OPSZONE Zone that is being attacked.
function CHIEF:__ZoneAttacked(delay, OpsZone) end

---On after "ZoneAttacked" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsZone? OPSZONE Zone that is being attacked.
function CHIEF:OnAfterZoneAttacked(From, Event, To, OpsZone) end

---Triggers the FSM event "LegionLost".
---@param Legion? LEGION The legion that was lost.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function CHIEF:LegionLost(Legion, Coalition, Country) end

---Triggers the FSM event "LegionLost".
---@param delay? number Delay in seconds.
---@param Legion? LEGION The legion that was lost.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function CHIEF:__LegionLost(delay, Legion, Coalition, Country) end

---On after "LegionLost" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Legion? LEGION The legion that was lost.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function CHIEF:OnAfterLegionLost(From, Event, To, Legion, Coalition, Country) end
