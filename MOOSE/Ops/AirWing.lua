---@meta

---@class AIRWING.TankerZone : AIRWING.PatrolZone
---@field refuelsystem number Refueling system type: `0=Unit.RefuelingSystem.BOOM_AND_RECEPTACLE`, `1=Unit.RefuelingSystem.PROBE_AND_DROGUE`.

---@class AIRWING.AwacsZone
---@field zone ZONE Zone.
---@field altitude number Altitude in feet.
---@field heading number Heading in degrees.
---@field leg number Leg length in NM.
---@field speed number Speed in knots.
---@field mission AUFTRAG Mission assigned.
---@field marker MARKER F10 marker.

---@class AIRWING.PatrolZone
---@field zone ZONE Zone.
---@field altitude number Altitude in feet.
---@field heading number Heading in degrees.
---@field leg number Leg length in NM.
---@field speed number Speed in knots.
---@field mission AUFTRAG Mission assigned.
---@field marker MARKER F10 marker.

---@class AIRWING.PatrolData
---@field type string Type name.
---@field coord COORDINATE Patrol coordinate.
---@field altitude number Altitude in feet.
---@field heading number Heading in degrees.
---@field leg number Leg length in NM.
---@field speed number Speed in knots.
---@field refuelsystem number Refueling system type: `0=Unit.RefuelingSystem.BOOM_AND_RECEPTACLE`, `1=Unit.RefuelingSystem.PROBE_AND_DROGUE`.
---@field noccupied number Number of flights on this patrol point.
---@field marker MARKER F10 marker.
---@field IsZonePoint boolean flag for using a (moving) zone as point for patrol etc.
---@field patrolzone ZONE_BASE in case Patrol coordinate was handed as zone, store here.

---@class AIRWING.Payload
---@field uid number Unique payload ID.
---@field unitname string Name of the unit this pylon was extracted from.
---@field aircrafttype string Type of aircraft, which can use this payload.
---@field capabilities table Mission types and performances for which this payload can be used.
---@field pylons table Pylon data extracted for the unit template.
---@field navail number Number of available payloads of this type.
---@field unlimited boolean If true, this payload is unlimited and does not get consumed.

---AIRWING class.
---@class AIRWING : LEGION
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field lid string Class id string for output to DCS log file.
---@field menu table Table of menu items.
---@field squadrons table Table of squadrons.
---@field missionqueue table Mission queue table.
---@field payloads table Playloads for specific aircraft and mission types.
---@field payloadcounter number Running index of payloads.
---@field zonesetCAP SET_ZONE Set of CAP zones.
---@field zonesetTANKER SET_ZONE Set of TANKER zones.
---@field zonesetAWACS SET_ZONE Set of AWACS zones.
---@field zonesetRECON SET_ZONE Set of RECON zones.
---@field nflightsCAP number Number of CAP flights constantly in the air.
---@field nflightsAWACS number Number of AWACS flights constantly in the air.
---@field nflightsTANKERboom number Number of TANKER flights with BOOM constantly in the air.
---@field nflightsTANKERprobe number Number of TANKER flights with PROBE constantly in the air.
---@field nflightsRescueHelo number Number of Rescue helo flights constantly in the air.
---@field nflightsRecon number Number of Recon flights constantly in the air.
---@field pointsCAP table Table of CAP points.
---@field pointsTANKER table Table of Tanker points.
---@field pointsAWACS table Table of AWACS points.
---@field pointsRecon table Table of RECON points.
---@field markpoints boolean Display markers on the F10 map.
---@field airboss AIRBOSS Airboss attached to this wing.
---@field rescuehelo RESCUEHELO The rescue helo.
---@field recoverytanker RECOVERYTANKER The recoverytanker.
---@field takeoffType string Take of type.
---@field despawnAfterLanding boolean Aircraft are despawned after landing.
---@field despawnAfterHolding boolean Aircraft are despawned after holding.
---@field capOptionPatrolRaceTrack boolean Use closer patrol race track or standard orbit auftrag.
---@field capFormation number If capOptionPatrolRaceTrack is true, set the formation, also.
---@field capOptionVaryStartTime number If set, vary mission start time for CAP missions generated random between capOptionVaryStartTime and capOptionVaryEndTime
---@field capOptionVaryEndTime number If set, vary mission start time for CAP missions generated random between capOptionVaryStartTime and capOptionVaryEndTime
AIRWING = {
  ClassName      = "AIRWING",
  verbose        =     0,
  lid            =   nil,
  menu           =   nil,
  payloads       =    {},
  payloadcounter =     0,
  pointsCAP      =    {},
  pointsTANKER   =    {},
  pointsAWACS    =    {},
  pointsRecon    =    {},
  markpoints     =   false,
  capOptionPatrolRaceTrack = false,
  capFormation   =    nil,
  capOptionVaryStartTime =    nil,
  capOptionVaryEndTime =    nil,
}

---AIRWING class version.
AIRWING.version = "0.9.8"

---Create a new AIRWING class object for a specific aircraft carrier unit.
---@param warehousename? string Name of the warehouse static or unit object representing the warehouse.
---@param airwingname? string Name of the air wing, e.g. "AIRWING-8".
---@return AIRWING # self
function AIRWING:New(warehousename, airwingname) end

---Add a squadron to the air wing.
---@param Squadron? SQUADRON The squadron object.
---@return AIRWING # self
function AIRWING:AddSquadron(Squadron) end

---Add a **new** payload to the airwing resources.
---@param Unit? UNIT The unit, the payload is extracted from. Can also be given as *#string* name of the unit.
---@param Npayloads? number (Optional) Number of payloads to add to the airwing resources. Default 99 (which should be enough for most scenarios). Set to -1 for unlimited.
---@param MissionTypes? table Mission types this payload can be used for.
---@param Performance? number (Optional) A number between 0 (worst) and 100 (best) to describe the performance of the loadout for the given mission types. Default is 50.
---@return AIRWING.Payload # The payload table or nil if the unit does not exist.
function AIRWING:NewPayload(Unit, Npayloads, MissionTypes, Performance) end

---Set the number of payload available.
---@param Payload? AIRWING.Payload|number|string The payload table created by the `:NewPayload` function.
---@param Navailable? number (Optional) Number of payloads available to the airwing resources. Default 99 (which should be enough for most scenarios). Set to -1 for unlimited.
---@return AIRWING # self
function AIRWING:SetPayloadAmount(Payload, Navailable) end

---Increase or decrease the amount of available payloads. Unlimited playloads first need to be set to a limited number with the `SetPayloadAmount` function.
---@param Payload? AIRWING.Payload|number|string The payload table created by the `:NewPayload` function.
---@param N? number (Optional) Number of payloads to be added. Use negative number to decrease amount. Default 1.
---@return AIRWING # self
function AIRWING:IncreasePayloadAmount(Payload, N) end

---Get amount of payloads available for a given playload.
---@param Payload? AIRWING.Payload|number|string The payload table created by the `:NewPayload` function.
---@return number # Number of payloads available. Unlimited payloads will return -1.
function AIRWING:GetPayloadAmount(Payload) end

---Get capabilities of a given playload.
---@param Payload? AIRWING.Payload|number|string The payload data table.
---@return table # Capabilities.
function AIRWING:GetPayloadCapabilities(Payload) end

---Add a mission capability to an existing payload.
---@param Payload? AIRWING.Payload|number|string The payload table to which the capability should be added.
---@param MissionTypes? table Mission types to be added.
---@param Performance? number (Optional) A number between 0 (worst) and 100 (best) to describe the performance of the loadout for the given mission types. Default is 50.
---@return AIRWING # self
function AIRWING:AddPayloadCapability(Payload, MissionTypes, Performance) end

---Fetch a payload from the airwing resources for a given unit and mission type.
---The payload with the highest priority is preferred.
---@param UnitType? string The type of the unit.
---@param MissionType? string The mission type.
---@param Payloads? table Specific payloads only to be considered.
---@return AIRWING.Payload # Payload table or *nil*.
function AIRWING:FetchPayloadFromStock(UnitType, MissionType, Payloads) end

---Return payload from asset back to stock.
---@param asset? WAREHOUSE.Assetitem|number|string The squadron asset.
function AIRWING:ReturnPayloadFromAsset(asset) end

---Add asset group(s) to squadron.
---@param Squadron? SQUADRON The squadron object.
---@param Nassets? number Number of asset groups to add.
---@return AIRWING # self
function AIRWING:AddAssetToSquadron(Squadron, Nassets) end

---Get squadron by name.
---@param SquadronName? string Name of the squadron, e.g. "VFA-37".
---@return SQUADRON # The squadron object.
function AIRWING:GetSquadron(SquadronName) end

---Get squadron of an asset.
---@param Asset? WAREHOUSE.Assetitem|number|string The squadron asset.
---@return SQUADRON # The squadron object.
function AIRWING:GetSquadronOfAsset(Asset) end

---Remove asset from squadron.
---@param Asset? WAREHOUSE.Assetitem|number|string The squad asset.
function AIRWING:RemoveAssetFromSquadron(Asset) end

---Set number of CAP flights constantly carried out.
---@param n? number (Optional) Number of flights. Default 1.
---@param grouping? number (optional) Number of assets per flight. Default 1.
---@return AIRWING # self
function AIRWING:SetNumberCAP(n, grouping) end

---Set CAP flight formation.
---@param Formation? number Formation to take, e.g. ENUMS.Formation.FixedWing.Trail.Close, also see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_option_formation).
---@return AIRWING # self
function AIRWING:SetCAPFormation(Formation) end

---Set CAP close race track.We'll utilize the AUFTRAG PatrolRaceTrack instead of a standard race track orbit task.
---@param OnOff? boolean (Optional) If true, switch this on, else switch off. Off by default.
---@return AIRWING # self
function AIRWING:SetCapCloseRaceTrack(OnOff) end

---Set CAP mission start to vary randomly between Start end End seconds.
---@param Start? number
---@param End? number
---@return AIRWING # self
function AIRWING:SetCapStartTimeVariation(Start, End) end

---Set number of TANKER flights with Boom constantly in the air.
---@param Nboom? number (Optional) Number of flights. Default 1.
---@return AIRWING # self
function AIRWING:SetNumberTankerBoom(Nboom) end

---Set markers on the map for Patrol Points.
---@param onoff? boolean Set to true to switch markers on.
---@return AIRWING # self
function AIRWING:ShowPatrolPointMarkers(onoff) end

---Set number of TANKER flights with Probe constantly in the air.
---@param Nprobe? number (Optional) Number of flights. Default 1.
---@return AIRWING # self
function AIRWING:SetNumberTankerProbe(Nprobe) end

---Set number of AWACS flights constantly in the air.
---@param n? number (Optional) Number of flights. Default 1.
---@return AIRWING # self
function AIRWING:SetNumberAWACS(n) end

---Set number of RECON flights constantly in the air.
---@param n? number (Optional) Number of flights. Default 1.
---@return AIRWING # self
function AIRWING:SetNumberRecon(n) end

---Set number of Rescue helo flights constantly in the air.
---@param n? number (Optional) Number of flights. Default 1.
---@return AIRWING # self
function AIRWING:SetNumberRescuehelo(n) end

---@param point? AIRWING.PatrolData|number|string Patrol point table.
---@return string # Marker text.
function AIRWING:_PatrolPointMarkerText(point) end

---Update marker of the patrol point.
---@param point? AIRWING.PatrolData|number|string Patrol point table.
function AIRWING:UpdatePatrolPointMarker(point) end

---Create a new generic patrol point.
---@param Type? string (Optional) Patrol point type, e.g. "CAP" or "AWACS". Default "Unknown".
---@param Coordinate? COORDINATE (Optional) Coordinate of the patrol point. Default 10-15 NM away from the location of the airwing. Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number (Optional) Orbit altitude in feet. Default random between Angels 10 and 20.
---@param Speed? number (Optional) Orbit speed in knots. Default 350 knots.
---@param Heading? number (Optional) Heading in degrees. Default random (0, 360] degrees.
---@param LegLength? number (Optional) Length of race-track orbit in NM. Default 15 NM.
---@param RefuelSystem? number (Optional) Refueling system: 0=Boom, 1=Probe. Default nil=any.
---@return AIRWING.PatrolData # Patrol point table.
function AIRWING:NewPatrolPoint(Type, Coordinate, Altitude, Speed, Heading, LegLength, RefuelSystem) end

---Add a patrol Point for CAP missions.
---@param Coordinate? COORDINATE Coordinate of the patrol point. Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number Orbit altitude in feet.
---@param Speed? number Orbit speed in knots.
---@param Heading? number Heading in degrees.
---@param LegLength? number Length of race-track orbit in NM.
---@return AIRWING # self
function AIRWING:AddPatrolPointCAP(Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a patrol Point for RECON missions.
---@param Coordinate? COORDINATE Coordinate of the patrol point. Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number Orbit altitude in feet.
---@param Speed? number Orbit speed in knots.
---@param Heading? number Heading in degrees.
---@param LegLength? number Length of race-track orbit in NM.
---@return AIRWING # self
function AIRWING:AddPatrolPointRecon(Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a patrol Point for TANKER missions.
---@param Coordinate? COORDINATE Coordinate of the patrol point. Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number Orbit altitude in feet.
---@param Speed? number Orbit speed in knots.
---@param Heading? number Heading in degrees.
---@param LegLength? number Length of race-track orbit in NM.
---@param RefuelSystem? number (Optional) Set refueling system of tanker: 0=boom, 1=probe. Default any (=nil).
---@return AIRWING # self
function AIRWING:AddPatrolPointTANKER(Coordinate, Altitude, Speed, Heading, LegLength, RefuelSystem) end

---Add a patrol Point for AWACS missions.
---@param Coordinate? COORDINATE Coordinate of the patrol point. Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number Orbit altitude in feet.
---@param Speed? number Orbit speed in knots.
---@param Heading? number Heading in degrees.
---@param LegLength? number Length of race-track orbit in NM.
---@return AIRWING # self
function AIRWING:AddPatrolPointAWACS(Coordinate, Altitude, Speed, Heading, LegLength) end

---Set airboss of this wing. He/she will take care that no missions are launched if the carrier is recovering.
---@param airboss? AIRBOSS The AIRBOSS object.
---@return AIRWING # self
function AIRWING:SetAirboss(airboss) end

---Set takeoff type. All assets of this airwing will be spawned with this takeoff type.
---Spawning on runways is not supported.
---@param TakeoffType? string (Optional) Take off type: "Cold" (default) or "Hot" with engines on or "Air" for spawning in air.
---@return AIRWING # self
function AIRWING:SetTakeoffType(TakeoffType) end

---Set takeoff type cold (default). All assets of this squadron will be spawned with engines off (cold).
---@return AIRWING # self
function AIRWING:SetTakeoffCold() end

---Set takeoff type hot. All assets of this squadron will be spawned with engines on (hot).
---@return AIRWING # self
function AIRWING:SetTakeoffHot() end

---Set takeoff type air. All assets of this squadron will be spawned in air above the airbase.
---@return AIRWING # self
function AIRWING:SetTakeoffAir() end

---Set the aircraft of the AirWing to land straight in.
---@return FLIGHTGROUP # self
function AIRWING:SetLandingStraightIn() end

---Set the aircraft of the AirWing to land in pairs for groups > 1 aircraft.
---@return AIRWING # self
function AIRWING:SetLandingForcePair() end

---Set the aircraft of the AirWing to NOT land in pairs.
---@return AIRWING # self
function AIRWING:SetLandingRestrictPair() end

---Set the aircraft of the AirWing to land after overhead break.
---@return AIRWING # self
function AIRWING:SetLandingOverheadBreak() end

---[Helicopter] Set the aircraft of the AirWing to prefer vertical takeoff and landing.
---@return AIRWING # self
function AIRWING:SetOptionPreferVerticalLanding() end

---Set despawn after landing. Aircraft will be despawned after the landing event.
---Can help to avoid DCS AI taxiing issues.
---@param Switch? boolean (Optional) If `true` (default), activate despawn after landing.
---@return AIRWING # self
function AIRWING:SetDespawnAfterLanding(Switch) end

---Set despawn after holding. Aircraft will be despawned when they arrive at their holding position at the airbase.
---Can help to avoid DCS AI taxiing issues.
---@param Switch? boolean (Optional) If `true` (default), activate despawn after landing.
---@return AIRWING # self
function AIRWING:SetDespawnAfterHolding(Switch) end

---Start AIRWING FSM.
---@param From? any
---@param Event? any
---@param To? any
function AIRWING:onafterStart(From, Event, To) end

---Update status.
---@param From? any
---@param Event? any
---@param To? any
function AIRWING:onafterStatus(From, Event, To) end

---Get patrol data.
---@param PatrolPoints? table Patrol data points.
---@param RefuelSystem? number If provided, only return points with the specific refueling system.
---@return AIRWING.PatrolData # Patrol point data table.
function AIRWING:_GetPatrolData(PatrolPoints, RefuelSystem) end

---Check how many CAP missions are assigned and add number of missing missions.
---@return AIRWING # self
function AIRWING:CheckCAP() end

---Check how many RECON missions are assigned and add number of missing missions.
---@return AIRWING # self
function AIRWING:CheckRECON() end

---Check how many TANKER missions are assigned and add number of missing missions.
---@return AIRWING # self
function AIRWING:CheckTANKER() end

---Check how many AWACS missions are assigned and add number of missing missions.
---@return AIRWING # self
function AIRWING:CheckAWACS() end

---Check how many Rescue helos are currently in the air.
---@return AIRWING # self
function AIRWING:CheckRescuhelo() end

---Check how many AWACS missions are assigned and add number of missing missions.
---@param flightgroup? FLIGHTGROUP The flightgroup.
---@return WAREHOUSE.Assetitem # The tanker asset.
function AIRWING:GetTankerForFlight(flightgroup) end

---Add the ability to call back an Ops.AWACS#AWACS object with an FSM call "FlightOnMission(FlightGroup, Mission)".
---@param ConnectecdAwacs? AWACS
---@return AIRWING # self
function AIRWING:SetUsingOpsAwacs(ConnectecdAwacs) end

---Remove the ability to call back an Ops.AWACS#AWACS object with an FSM call "FlightOnMission(FlightGroup, Mission)".
---@return AIRWING # self
function AIRWING:RemoveUsingOpsAwacs() end

---On after "FlightOnMission".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param FlightGroup? FLIGHTGROUP Ops flight group on mission.
---@param Mission? AUFTRAG The requested mission.
function AIRWING:onafterFlightOnMission(From, Event, To, FlightGroup, Mission) end

---Count payloads in stock.
---@param MissionTypes? table (Optional) Types on mission to be checked. Default *all* possible types `AUFTRAG.Type`.
---@param UnitTypes? table (Optional) Types of units.
---@param Payloads? table (Optional) Specific payloads to be counted only.
---@return number # Count of available payloads in stock.
function AIRWING:CountPayloadsInStock(MissionTypes, UnitTypes, Payloads) end

---Get payload performance for a given type of misson type.
---@param Payload? AIRWING.Payload|number|string The payload table.
---@param MissionType? string Type of mission.
---@return number # Performance or -1.
function AIRWING:GetPayloadPeformance(Payload, MissionType) end

---Get mission types a payload can perform.
---@param Payload? AIRWING.Payload|number|string The payload table.
---@return table # Mission types.
function AIRWING:GetPayloadMissionTypes(Payload) end

---Triggers the FSM event "Start". Starts the AIRWING. Initializes parameters and starts event handlers.
function AIRWING:Start() end

---Triggers the FSM event "Start" after a delay. Starts the AIRWING. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function AIRWING:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the AIRWING and all its event handlers.
---@param delay? number Delay in seconds.
function AIRWING:__Stop(delay) end

---Triggers the FSM event "FlightOnMission".
---@param FlightGroup? FLIGHTGROUP The FLIGHTGROUP on mission.
---@param Mission? AUFTRAG The mission.
function AIRWING:FlightOnMission(FlightGroup, Mission) end

---Triggers the FSM event "FlightOnMission" after a delay.
---@param delay? number Delay in seconds.
---@param FlightGroup? FLIGHTGROUP The FLIGHTGROUP on mission.
---@param Mission? AUFTRAG The mission.
function AIRWING:__FlightOnMission(delay, FlightGroup, Mission) end

---On after "FlightOnMission" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param FlightGroup? FLIGHTGROUP The FLIGHTGROUP on mission.
---@param Mission? AUFTRAG The mission.
function AIRWING:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission) end
