---@meta

---COMMANDER class.
---@class COMMANDER : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field coalition number Coalition side of the commander.
---@field alias string Alias name.
---@field legions table Table of legions which are commanded.
---@field missionqueue table Mission queue.
---@field transportqueue table Transport queue.
---@field targetqueue table Target queue.
---@field opsqueue table Operations queue.
---@field rearmingZones table Rearming zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field refuellingZones table Refuelling zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field capZones table CAP zones. Each element is of type `#AIRWING.PatrolZone`.
---@field gcicapZones table GCICAP zones. Each element is of type `#AIRWING.PatrolZone`.
---@field awacsZones table AWACS zones. Each element is of type `#AIRWING.PatrolZone`.
---@field tankerZones table Tanker zones. Each element is of type `#AIRWING.TankerZone`.
---@field chief CHIEF Chief of staff.
---@field limitMission table Table of limits for mission types.
COMMANDER = {
  ClassName       = "COMMANDER",
  verbose         =     0,
  coalition       =   nil,
  legions         =    {},
  missionqueue    =    {},
  transportqueue  =    {},
  targetqueue     =    {},
  opsqueue        =    {},
  rearmingZones   =    {},
  refuellingZones =    {},
  capZones        =    {},
  gcicapZones     =    {},
  awacsZones      =    {},
  tankerZones     =    {},
  limitMission    =    {},
  maxMissionsAssignPerCycle = 1,
}

---COMMANDER class version.
COMMANDER.version = "0.1.4"

---Create a new COMMANDER object and start the FSM.
---@param Coalition? number Coaliton of the commander.
---@param Alias? string Some name you want the commander to be called.
---@return COMMANDER # self
function COMMANDER:New(Coalition, Alias) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return COMMANDER # self
function COMMANDER:SetVerbosity(VerbosityLevel) end

---Set limit for number of total or specific missions to be executed simultaniously.
---@param Limit? number (Optional) Number of max. mission of this type. Default 10.
---@param MissionType? string (Optional) Type of mission, e.g. `AUFTRAG.Type.BAI`. Default `"Total"` for total number of missions.
---@return COMMANDER # self
function COMMANDER:SetLimitMission(Limit, MissionType) end

---Get coalition.
---@return number # Coalition.
function COMMANDER:GetCoalition() end

---Add an AIRWING to the commander.
---@param Airwing? AIRWING The airwing to add.
---@return COMMANDER # self
function COMMANDER:AddAirwing(Airwing) end

---Add a BRIGADE to the commander.
---@param Brigade? BRIGADE The brigade to add.
---@return COMMANDER # self
function COMMANDER:AddBrigade(Brigade) end

---Add a FLEET to the commander.
---@param Fleet? FLEET The fleet to add.
---@return COMMANDER # self
function COMMANDER:AddFleet(Fleet) end

---Add a LEGION to the commander.
---@param Legion? LEGION The legion to add.
---@return COMMANDER # self
function COMMANDER:AddLegion(Legion) end

---Remove a LEGION to the commander.
---@param Legion? LEGION The legion to be removed.
---@return COMMANDER # self
function COMMANDER:RemoveLegion(Legion) end

---Add mission to mission queue.
---@param Mission? AUFTRAG Mission to be added.
---@return COMMANDER # self
function COMMANDER:AddMission(Mission) end

---Add transport to queue.
---@param Transport? OPSTRANSPORT The OPS transport to be added.
---@return COMMANDER # self
function COMMANDER:AddOpsTransport(Transport) end

---Remove mission from queue.
---@param Mission? AUFTRAG Mission to be removed.
---@return COMMANDER # self
function COMMANDER:RemoveMission(Mission) end

---Remove transport from queue.
---@param Transport? OPSTRANSPORT The OPS transport to be removed.
---@return COMMANDER # self
function COMMANDER:RemoveTransport(Transport) end

---Add target.
---@param Target? TARGET Target object to be added.
---@return COMMANDER # self
function COMMANDER:AddTarget(Target) end

---Add operation.
---@param Operation? OPERATION The operation to be added.
---@return COMMANDER # self
function COMMANDER:AddOperation(Operation) end

---Check if a TARGET is already in the queue.
---@param Target? TARGET Target object to be added.
---@return boolean # If `true`, target exists in the target queue.
function COMMANDER:IsTarget(Target) end

---Remove target from queue.
---@param Target? TARGET The target.
---@return COMMANDER # self
function COMMANDER:RemoveTarget(Target) end

---Add a rearming zone.
---@param RearmingZone? ZONE Rearming zone.
---@return BRIGADE.SupplyZone # The rearming zone data.
function COMMANDER:AddRearmingZone(RearmingZone) end

---Add a refuelling zone.
---@param RefuellingZone? ZONE Refuelling zone.
---@return BRIGADE.SupplyZone # The refuelling zone data.
function COMMANDER:AddRefuellingZone(RefuellingZone) end

---Add a CAP zone.
---@param Zone? ZONE CapZone Zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone # The CAP zone data.
function COMMANDER:AddCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Add a GCICAP zone.
---@param Zone? ZONE CapZone Zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone # The CAP zone data.
function COMMANDER:AddGciCapZone(Zone, Altitude, Speed, Heading, Leg) end

---Remove a GCI CAP.
---@param Zone? ZONE Zone, where the flight orbits.
function COMMANDER:RemoveGciCapZone(Zone) end

---Add an AWACS zone.
---@param Zone? ZONE Zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@return AIRWING.PatrolZone # The AWACS zone data.
function COMMANDER:AddAwacsZone(Zone, Altitude, Speed, Heading, Leg) end

---Remove a AWACS zone.
---@param Zone? ZONE Zone, where the flight orbits.
function COMMANDER:RemoveAwacsZone(Zone) end

---Add a refuelling tanker zone.
---@param Zone? ZONE Zone.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 12,000 feet.
---@param Speed? number (Optional) Orbit speed in KIAS. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 30 NM.
---@param RefuelSystem? number Refuelling system.
---@return AIRWING.TankerZone # The tanker zone data.
function COMMANDER:AddTankerZone(Zone, Altitude, Speed, Heading, Leg, RefuelSystem) end

---Remove a refuelling tanker zone.
---@param Zone? ZONE Zone, where the flight orbits.
function COMMANDER:RemoveTankerZone(Zone) end

---Check if this mission is already in the queue.
---@param Mission? AUFTRAG The mission.
---@return boolean # If `true`, this mission is in the queue.
function COMMANDER:IsMission(Mission) end

---Relocate a cohort to another legion.
---Assets in stock are spawned and routed to the new legion.
---If assets are spawned, running missions will be cancelled.
---Cohort assets will not be available until relocation is finished.
---@param Cohort? COHORT The cohort to be relocated.
---@param Legion? LEGION The legion where the cohort is relocated to.
---@param Delay? number (Optional) Delay in seconds before relocation takes place. Default `nil`, *i.e.* ASAP.
---@param NcarriersMin? number (Optional) Min number of transport carriers in case the troops should be transported. Default `nil` for no transport.
---@param NcarriersMax? number Max number of transport carriers.
---@param TransportLegions? table (Optional) Legion(s) assigned for transportation. Default is all legions of the commander.
---@return COMMANDER # self
function COMMANDER:RelocateCohort(Cohort, Legion, Delay, NcarriersMin, NcarriersMax, TransportLegions) end

---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COMMANDER:onafterStart(From, Event, To) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COMMANDER:onafterStatus(From, Event, To) end

---On after "MissionAssign" event. Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission already.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function COMMANDER:onafterMissionAssign(From, Event, To, Mission, Legions) end

---On after "MissionCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
function COMMANDER:onafterMissionCancel(From, Event, To, Mission) end

---On after "TransportAssign" event. Transport is added to a LEGION transport queue.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Transport? OPSTRANSPORT The transport.
---@param Legions? table The legion(s) to which this transport is assigned.
function COMMANDER:onafterTransportAssign(From, Event, To, Transport, Legions) end

---On after "TransportCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Transport? OPSTRANSPORT The transport.
function COMMANDER:onafterTransportCancel(From, Event, To, Transport) end

---On after "OpsOnMission".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP Ops group on mission
---@param Mission? AUFTRAG The requested mission.
function COMMANDER:onafterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---Check OPERATIONs queue.
function COMMANDER:CheckOpsQueue() end

---Check target queue and assign ONE valid target by adding it to the mission queue of the COMMANDER.
function COMMANDER:CheckTargetQueue() end

---Check mission queue and assign ONE planned mission.
function COMMANDER:CheckMissionQueue() end

---Set how many missions can be assigned in a single status iteration. (eg. This is useful for persistent missions where you need to load all AUFTRAGs on mission start and then change it back to default)
---Warning: Increasing this value will increase the number of missions started per iteration and thus may lead to performance issues if too many missions are started at once.
---@param MaxMissionsAssignPerCycle? number (Optional) Number of missions assigned per status iteration. Default is 1.
---@return COMMANDER # self.
function COMMANDER:SetMaxMissionsAssignPerCycle(MaxMissionsAssignPerCycle) end

---Get cohorts.
---@param Legions? table Special legions.
---@param Cohorts? table Special cohorts.
---@param Operation? OPERATION Operation.
---@return table # Cohorts.
function COMMANDER:_GetCohorts(Legions, Cohorts, Operation) end

---Checks whether or not any of the legions con run a mission.
---@param Mission? AUFTRAG The mission.
---@return boolean # If `true`, one of the cohorts can run the mission.
function COMMANDER:CanMission(Mission) end

---Recruit assets for a given mission.
---@param Mission? AUFTRAG The mission.
---@return boolean # If `true` enough assets could be recruited.
---@return table # Recruited assets.
---@return table # Legions that have recruited assets.
function COMMANDER:RecruitAssetsForMission(Mission) end

---Recruit assets performing an escort mission for a given asset.
---@param Mission? AUFTRAG The mission.
---@param Assets? table Table of assets to be escorted.
---@return boolean # If `true`, enough assets could be recruited or no escort was required in the first place.
function COMMANDER:RecruitAssetsForEscort(Mission, Assets) end

---Recruit assets for a given TARGET.
---@param Target? TARGET The target.
---@param MissionType? string Mission Type.
---@param NassetsMin? number Min number of required assets.
---@param NassetsMax? number Max number of required assets.
---@param RangeMin? any
---@return boolean # If `true` enough assets could be recruited.
---@return table # Assets that have been recruited from all legions.
---@return table # Legions that have recruited assets.
function COMMANDER:RecruitAssetsForTarget(Target, MissionType, NassetsMin, NassetsMax, RangeMin) end

---Check transport queue and assign ONE planned transport.
function COMMANDER:CheckTransportQueue() end

---Recruit assets for a given OPS transport.
---@param Transport? OPSTRANSPORT The OPS transport.
---@param CargoWeight? number Weight of the heaviest cargo group.
---@param TotalWeight? number Total weight of all cargo groups.
---@return boolean # If `true`, enough assets could be recruited.
---@return table # Recruited assets.
---@return table # Legions that have recruited assets.
function COMMANDER:RecruitAssetsForTransport(Transport, CargoWeight, TotalWeight) end

---Check if limit of missions has been reached.
---@param MissionType? string Type of mission.
---@return boolean # If `true`, mission limit has **not** been reached. If `false`, limit has been reached.
function COMMANDER:_CheckMissionLimit(MissionType) end

---Count assets of all assigned legions.
---@param InStock? boolean If true, only assets that are in the warehouse stock/inventory are counted.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return number # Amount of asset groups.
function COMMANDER:CountAssets(InStock, MissionTypes, Attributes) end

---Count assets of all assigned legions.
---@param MissionTypes? table (Optional) Count only missions of these types. Default is all types.
---@param OnlyRunning? boolean If `true`, only count running missions.
---@return number # Amount missions.
function COMMANDER:CountMissions(MissionTypes, OnlyRunning) end

---Count assets of all assigned legions.
---@param InStock? boolean If true, only assets that are in the warehouse stock/inventory are counted.
---@param Legions? table (Optional) Table of legions. Default is all legions.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return number # Amount of asset groups.
function COMMANDER:GetAssets(InStock, Legions, MissionTypes, Attributes) end

---Check all legions if they are able to do a specific mission type at a certain location with a given number of assets.
---@param Mission? AUFTRAG The mission.
---@return table # Table of LEGIONs that can do the mission and have at least one asset available right now.
function COMMANDER:GetLegionsForMission(Mission) end

---Get assets on given mission or missions.
---@param MissionTypes? table (Optional) Types on mission to be checked. Default all.
---@return table # Assets on pending requests.
function COMMANDER:GetAssetsOnMission(MissionTypes) end

---Triggers the FSM event "Start". Starts the COMMANDER.
function COMMANDER:Start() end

---Triggers the FSM event "Start" after a delay. Starts the COMMANDER.
---@param delay? number Delay in seconds.
function COMMANDER:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the COMMANDER.
---@param delay? number Delay in seconds.
function COMMANDER:__Stop(delay) end

---Triggers the FSM event "Status".
function COMMANDER:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function COMMANDER:__Status(delay) end

---Triggers the FSM event "MissionAssign". Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission!
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function COMMANDER:MissionAssign(Mission, Legions) end

---Triggers the FSM event "MissionAssign" after a delay. Mission is added to a LEGION mission queue and already requested. Needs assets to be added to the mission!
---@param delay? number Delay in seconds.
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function COMMANDER:__MissionAssign(delay, Mission, Legions) end

---On after "MissionAssign" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
---@param Legions? table The Legion(s) to which the mission is assigned.
function COMMANDER:OnAfterMissionAssign(From, Event, To, Mission, Legions) end

---Triggers the FSM event "MissionCancel".
---@param Mission? AUFTRAG The mission.
function COMMANDER:MissionCancel(Mission) end

---Triggers the FSM event "MissionCancel" after a delay.
---@param delay? number Delay in seconds.
---@param Mission? AUFTRAG The mission.
function COMMANDER:__MissionCancel(delay, Mission) end

---On after "MissionCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Mission? AUFTRAG The mission.
function COMMANDER:OnAfterMissionCancel(From, Event, To, Mission) end

---Triggers the FSM event "TransportAssign".
---@param Transport? OPSTRANSPORT The transport.
---@param Legions? table The legion(s) to which this transport is assigned.
function COMMANDER:TransportAssign(Transport, Legions) end

---Triggers the FSM event "TransportAssign" after a delay.
---@param delay? number Delay in seconds.
---@param Transport? OPSTRANSPORT The transport.
---@param Legions? table The legion(s) to which this transport is assigned.
function COMMANDER:__TransportAssign(delay, Transport, Legions) end

---On after "TransportAssign" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Transport? OPSTRANSPORT The transport.
---@param Legions? table The legion(s) to which this transport is assigned.
function COMMANDER:OnAfterTransportAssign(From, Event, To, Transport, Legions) end

---Triggers the FSM event "TransportCancel".
---@param Transport? OPSTRANSPORT The transport.
function COMMANDER:TransportCancel(Transport) end

---Triggers the FSM event "TransportCancel" after a delay.
---@param delay? number Delay in seconds.
---@param Transport? OPSTRANSPORT The transport.
function COMMANDER:__TransportCancel(delay, Transport) end

---On after "TransportCancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Transport? OPSTRANSPORT The transport.
function COMMANDER:OnAfterTransportCancel(From, Event, To, Transport) end

---Triggers the FSM event "OpsOnMission".
---@param OpsGroup? OPSGROUP The OPS group on mission.
---@param Mission? AUFTRAG The mission.
function COMMANDER:OpsOnMission(OpsGroup, Mission) end

---Triggers the FSM event "OpsOnMission" after a delay.
---@param delay? number Delay in seconds.
---@param OpsGroup? OPSGROUP The OPS group on mission.
---@param Mission? AUFTRAG The mission.
function COMMANDER:__OpsOnMission(delay, OpsGroup, Mission) end

---On after "OpsOnMission" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP The OPS group on mission.
---@param Mission? AUFTRAG The mission.
function COMMANDER:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission) end

---Triggers the FSM event "LegionLost".
---@param Legion? LEGION The legion that was lost.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function COMMANDER:LegionLost(Legion, Coalition, Country) end

---Triggers the FSM event "LegionLost".
---@param delay? number Delay in seconds.
---@param Legion? LEGION The legion that was lost.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function COMMANDER:__LegionLost(delay, Legion, Coalition, Country) end

---On after "LegionLost" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Legion? LEGION The legion that was lost.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function COMMANDER:OnAfterLegionLost(From, Event, To, Legion, Coalition, Country) end
