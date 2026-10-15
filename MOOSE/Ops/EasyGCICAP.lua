---@meta

---@class EASYGCICAP.CapPoint
---@field AirbaseName string
---@field Coordinate COORDINATE
---@field Altitude number
---@field Speed number
---@field Heading number
---@field LegLength number
---@field Zone ZONE_BASE

---@class EASYGCICAP.Wing
---@field AirbaseName string
---@field Alias string
---@field CapZoneName string

---@class EASYGCICAP.Squad
---@field TemplateName string
---@field SquadName string
---@field AirbaseName string
---@field AirFrames number
---@field Skill string
---@field Modex string
---@field Livery string
---@field Tanker boolean
---@field AWACS boolean
---@field RECON boolean
---@field Frequency number
---@field Modulation number
---@field TACAN number

---EASYGCICAP Class
---@class EASYGCICAP : FSM
---@field ClassName string
---@field overhead number
---@field engagerange number
---@field capgrouping number
---@field airbasename string
---@field airbase AIRBASE
---@field coalition number
---@field alias string
---@field wings table
---@field Intel INTEL
---@field resurrection number
---@field capspeed number
---@field capalt number
---@field capdir number
---@field capleg number
---@field maxinterceptsize number
---@field missionrange number
---@field noalert5 number
---@field ManagedAW table
---@field ManagedSQ table
---@field ManagedCP table
---@field ManagedTK table
---@field ManagedEWR table
---@field ManagedREC table
---@field MaxAliveMissions number
---@field debug boolean
---@field repeatsonfailure number
---@field GoZoneSet SET_ZONE
---@field NoGoZoneSet SET_ZONE
---@field ConflictZoneSet SET_ZONE
---@field Monitor boolean
---@field TankerInvisible boolean
---@field CapFormation number
---@field ReadyFlightGroups table
---@field DespawnAfterLanding boolean
---@field DespawnAfterHolding boolean
---@field ListOfAuftrag AUFTRAG[]
---@field defaulttakeofftype string Take off type
---@field FuelLowThreshold number
---@field FuelCriticalThreshold number
---@field showpatrolpointmarks boolean
---@field EngageTargetTypes table
---@field maintenancetime number
---@field repairtime number
EASYGCICAP = {
  ClassName = "EASYGCICAP",
  overhead = 0.75,
  capgrouping = 2,
  airbasename = nil,
  airbase = nil,
  coalition = "blue",
  alias = nil,
  wings = {},
  Intel = nil, -- Ops.Intel#INTEL
  resurrection = 900,
  capspeed = 300,
  capalt = 25000,
  capdir = 45,
  capleg = 15,
  maxinterceptsize = 2,
  missionrange = 100,
  noalert5 = 4,
  ManagedAW = {},
  ManagedSQ = {},
  ManagedCP = {},
  ManagedTK = {},
  ManagedEWR = {},
  ManagedREC = {},
  MaxAliveMissions = 8,
  debug = false,
  engagerange = 50,
  repeatsonfailure = 3,
  GoZoneSet = nil,
  NoGoZoneSet = nil,
  ConflictZoneSet = nil,
  Monitor = false,
  TankerInvisible = true,
  CapFormation = nil,
  ReadyFlightGroups = {},
  DespawnAfterLanding = false,
  DespawnAfterHolding = true,
  ListOfAuftrag = {},
  defaulttakeofftype = "hot",
  FuelLowThreshold = 25,
  FuelCriticalThreshold = 10,
  showpatrolpointmarks = false,
  EngageTargetTypes = {"Air"},
}

---EASYGCICAP class version.
EASYGCICAP.version = "0.1.39"

---Create a new GCICAP Manager
---@param Alias? string A Name for this GCICAP
---@param AirbaseName? string Name of the Home Airbase
---@param Coalition? string Coalition, e.g. "blue" or "red"
---@param EWRName? string (Partial) group name of the EWR system of the coalition, e.g. "Red EWR", can be handed in as table of names, e.g.{"EWR","Radar","SAM"}
---@return EASYGCICAP # self
function EASYGCICAP:New(Alias, AirbaseName, Coalition, EWRName) end

---Get a specific managed AirWing by name
---@param AirbaseName? string Airbase name of the home of this wing.
---@return AIRWING # Airwing or nil if not found
function EASYGCICAP:GetAirwing(AirbaseName) end

---Add an agent to the underlying INTEL detection - caution, we need to be started first for this to work!
---Normally this isn't necessary when the Group name is correctly filled (see EWRName in `New()`).
---@param Group? GROUP The group object to be added as Intel Agent.
---@return EASYGCICAP # self
function EASYGCICAP:AddAgent(Group) end

---Get a table of all managed AirWings
---@return table # Table of Ops.AirWing#AIRWING Airwings
function EASYGCICAP:GetAirwingTable() end

---Set "fuel low" threshold for CAP and INTERCEPT flights.
---@param Percent? number (Optional) RTB if fuel at this percent. Values: 1..100, defaults to 25.
---@return EASYGCICAP # self
function EASYGCICAP:SetFuelLow(Percent) end

---Set markers on the map for Patrol Points.
---@param onoff? boolean Set to true to switch markers on.
---@return EASYGCICAP # self
function EASYGCICAP:ShowPatrolPointMarkers(onoff) end

---Set "fuel critical" threshold for CAP and INTERCEPT flights.
---@param Percent? number (Optional) RTB if fuel at this percent. Values: 1..100, defaults to 10.
---@return EASYGCICAP # self
function EASYGCICAP:SetFuelCritical(Percent) end

---Set CAP formation.
---@param Formation? number (Optional) Formation to fly, defaults to ENUMS.Formation.FixedWing.FingerFour.Group
---@return EASYGCICAP # self
function EASYGCICAP:SetCAPFormation(Formation) end

---Set Tanker and AWACS to be invisible to enemy AI eyes
---@param Switch? boolean Set to true or false, by default this is set to true already
---@return EASYGCICAP # self
function EASYGCICAP:SetTankerAndAWACSInvisible(Switch) end

---(internal) Count alive missions in our internal stack.
---@return number # count
function EASYGCICAP:_CountAliveAuftrags() end

---Set Maximum of alive missions created by this instance to stop airplanes spamming the map
---@param Maxiumum? number (Optional) Maxmimum number of parallel missions allowed. Count is Intercept-Missions + Alert5-Missions, default is 8
---@return EASYGCICAP # self
function EASYGCICAP:SetMaxAliveMissions(Maxiumum) end

---Add default time to resurrect Airwing building if destroyed
---@param Seconds? number (Optional) Seconds, defaults to 900
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultResurrection(Seconds) end

---Add default repeat attempts if an Intruder intercepts fails.
---@param Retries? number (Optional) Retries, defaults to 3
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultRepeatOnFailure(Retries) end

---Add default take off type for the airwings.
---@param Takeoff? string (Optional) Can be "hot", "cold", or "air" - default is "hot".
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultTakeOffType(Takeoff) end

---Set default CAP Speed in knots
---@param Speed? number (Optional) Speed defaults to 300
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultCAPSpeed(Speed) end

---Set default CAP Altitude in feet
---@param Altitude? number (Optional) Altitude defaults to 25000
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultCAPAlt(Altitude) end

---Set default INTERCEPT Altitude in feet
---@param Altitude? number (Optional) Altitude defaults to 25000
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultINTERCEPTAlt(Altitude) end

---Set default CAP lieg initial direction in degrees
---@param Direction? number (Optional) Direction defaults to 90 (East)
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultCAPDirection(Direction) end

---Set default leg length in NM
---@param Leg? number (Optional) Leg defaults to 15
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultCAPLeg(Leg) end

---Set default grouping, i.e. how many airplanes per CAP point
---@param Grouping? number (Optional) Grouping defaults to 2
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultCAPGrouping(Grouping) end

---Set default range planes can fly from their homebase in NM
---@param Range? number (Optional) Range defaults to 100 NM
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultMissionRange(Range) end

---Set default turnover times for squadrons in minutes
---@param MaintenanceTime? number (Optional) Time in minutes it takes until a flight is combat ready again. Default is 5 min.
---@param RepairTime? number (Optional) Time in minutes it takes to repair a flight for each life point taken. Default is 10 min.
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultTurnoverTime(MaintenanceTime, RepairTime) end

---Set default number of airframes standing by for intercept tasks (visible on the airfield)
---@param Airframes? number (Optional) defaults to 2
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultNumberAlert5Standby(Airframes) end

---Set default engage range for intruders detected by CAP flights in NM.
---@param Range? number (Optional) defaults to 50NM
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultEngageRange(Range) end

---Set default overhead for intercept calculations
---@param Overhead? number The overhead to use.
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultOverhead(Overhead) end

---Set default despawning after landing.
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultDespawnAfterLanding() end

---Set default despawning after holding (despawn in air close to AFB).
---@return EASYGCICAP # self
function EASYGCICAP:SetDefaultDespawnAfterHolding() end

---Set CAP mission start to vary randomly between Start end End seconds.
---@param Start? number
---@param End? number
---@return EASYGCICAP # self
function EASYGCICAP:SetCapStartTimeVariation(Start, End) end

---Set which target types CAP flights will prefer to engage, defaults to {"Air"}
---@param types? table (Optional) Table of comma separated #string entries, defaults to {"Air"} (everything that flies and is not a weapon). Useful other options are e.g. {"Bombers"}, {"Fighters"}, or {"Helicopters"} or combinations like {"Bombers", "Fighters", "UAVs"}. See [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes).
---@return EASYGCICAP # self
function EASYGCICAP:SetCAPEngageTargetTypes(types) end

---Add an AirWing to the manager
---@param Airbasename? string
---@param Alias? string
---@return EASYGCICAP # self
function EASYGCICAP:AddAirwing(Airbasename, Alias) end

---(Internal) Create actual AirWings from the list
---@return EASYGCICAP # self
function EASYGCICAP:_CreateAirwings() end

---(Internal) Create and add another AirWing to the manager
---@param Airbasename? string
---@param Alias? string
---@return EASYGCICAP # self
function EASYGCICAP:_AddAirwing(Airbasename, Alias) end

---@param From? any
---@param Event? any
---@param To? any
---@param Flightgroup? any
---@param Mission? any
function CAP_Wing:onbeforeFlightOnMission(From, Event, To, Flightgroup, Mission) end

---Add a CAP patrol point to a Wing
---@param AirbaseName? string Name of the Wing's airbase
---@param Coordinate? COORDINATE . Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number (Optional) Defaults to 25000 feet ASL.
---@param Speed? number (Optional) Defaults to 300 knots TAS.
---@param Heading? number (Optional) Defaults to 90 degrees (East).
---@param LegLength? number (Optional)  Defaults to 15 NM.
---@return EASYGCICAP # self
function EASYGCICAP:AddPatrolPointCAP(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a RECON patrol point to a Wing
---@param AirbaseName? string Name of the Wing's airbase
---@param Coordinate? COORDINATE . Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number (Optional) Defaults to 25000 feet.
---@param Speed? number (Optional) Defaults to 300 knots.
---@param Heading? number (Optional) Defaults to 90 degrees (East).
---@param LegLength? number (Optional) Defaults to 15 NM.
---@return EASYGCICAP # self
function EASYGCICAP:AddPatrolPointRecon(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add a TANKER patrol point to a Wing
---@param AirbaseName? string Name of the Wing's airbase
---@param Coordinate? COORDINATE . Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number (Optional) Defaults to 25000 feet.
---@param Speed? number (Optional) Defaults to 300 knots.
---@param Heading? number (Optional) Defaults to 90 degrees (East).
---@param LegLength? number (Optional) Defaults to 15 NM.
---@return EASYGCICAP # self
function EASYGCICAP:AddPatrolPointTanker(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---Add an AWACS patrol point to a Wing
---@param AirbaseName? string Name of the Wing's airbase
---@param Coordinate? COORDINATE . Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number (Optional) Defaults to 25000 feet.
---@param Speed? number (Optional) Defaults to 300 knots.
---@param Heading? number (Optional) Defaults to 90 degrees (East).
---@param LegLength? number (Optional) Defaults to 15 NM.
---@return EASYGCICAP # self
function EASYGCICAP:AddPatrolPointAwacs(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

---(Internal) Set actual Tanker Points from the list
---@return EASYGCICAP # self
function EASYGCICAP:_SetTankerPatrolPoints() end

---(Internal) Set actual Awacs Points from the list
---@return EASYGCICAP # self
function EASYGCICAP:_SetAwacsPatrolPoints() end

---(Internal) Set actual PatrolPoints from the list
---@return EASYGCICAP # self
function EASYGCICAP:_SetCAPPatrolPoints() end

---(Internal) Set actual PatrolPoints from the list
---@return EASYGCICAP # self
function EASYGCICAP:_SetReconPatrolPoints() end

---(Internal) Create actual Squadrons from the list
---@return EASYGCICAP # self
function EASYGCICAP:_CreateSquads() end

---Add a Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@return EASYGCICAP # self
function EASYGCICAP:AddSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery) end

---Add a Recon Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@return EASYGCICAP # self
function EASYGCICAP:AddReconSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery) end

---Add a Tanker Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@param Frequency? number (optional) Radio Frequency to be used.
---@param Modulation? number (optional) Radio Modulation to be used, e.g. radio.modulation.AM or radio.modulation.FM
---@param TACAN? number (optional)  TACAN channel, e.g. 71, resulting in Channel 71Y
---@return EASYGCICAP # self
function EASYGCICAP:AddTankerSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation, TACAN) end

---Add an AWACS Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@param Frequency? number (optional) Radio Frequency to be used.
---@param Modulation? number (optional) Radio Modulation to be used, e.g. radio.modulation.AM or radio.modulation.FM
---@return EASYGCICAP # self
function EASYGCICAP:AddAWACSSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---(Internal) Add a Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@param Frequency? number (optional) Radio Frequency to be used.
---@param Modulation? number (optional) Radio Modulation to be used, e.g. radio.modulation.AM or radio.modulation.FM
---@return EASYGCICAP # self
function EASYGCICAP:_AddSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---(Internal) Add a Recon Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@return EASYGCICAP # self
function EASYGCICAP:_AddReconSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery) end

---(Internal) Add a Tanker Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@param Frequency? number (optional) Radio frequency of the Tanker
---@param Modulation? number (Optional) Radio modulation of the Tanker
---@param TACAN? number (Optional) TACAN Channel to be used, will always be an "Y" channel
---@return EASYGCICAP # self
function EASYGCICAP:_AddTankerSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation, TACAN) end

---(Internal) Add a AWACS Squadron to an Airwing of the manager
---@param TemplateName? string Name of the group template.
---@param SquadName? string Squadron name - must be unique!
---@param AirbaseName? string Name of the airbase the airwing resides on, e.g. AIRBASE.Caucasus.Kutaisi
---@param AirFrames? number Number of available airframes, e.g. 20.
---@param Skill? string (optional) Skill level, e.g. AI.Skill.AVERAGE
---@param Modex? string (optional) Modex to be used,e.g. 402.
---@param Livery? string (optional) Livery name to be used.
---@param Frequency? number (optional) Radio frequency of the AWACS
---@param Modulation? number (Optional) Radio modulation of the AWACS
---@return EASYGCICAP # self
function EASYGCICAP:_AddAWACSSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---Add a zone to the accepted zones set.
---@param Zone? ZONE_BASE
---@return EASYGCICAP # self
function EASYGCICAP:AddAcceptZone(Zone) end

---Add a zone to the rejected zones set.
---@param Zone? ZONE_BASE
---@return EASYGCICAP # self
function EASYGCICAP:AddRejectZone(Zone) end

---Add a zone to the conflict zones set.
---@param Zone? ZONE_BASE
---@return EASYGCICAP # self
function EASYGCICAP:AddConflictZone(Zone) end

---Function to set corridor zones.
---@param CorridorZones? SET_ZONE Can be handed in as SET\_ZONE or single ZONE object.
---@return EASYGCICAP # self
function EASYGCICAP:SetCorridorZones(CorridorZones) end

---Function to add one corridor zone.
---@param CorridorZone? ZONE The ZONE object to be added.
---@return EASYGCICAP # self
function EASYGCICAP:AddCorridorZone(CorridorZone) end

---Function to set corridor zone floor and ceiling in FEET.
---@param Floor? number Floor altitude ASL in feet.
---@param Ceiling? number Ceiling altitude ASL in feet.
---@return EASYGCICAP # self
function EASYGCICAP:SetCorridorZoneFloorAndCeiling(Floor, Ceiling) end

---Function to set corridor zone floor and ceiling in METERS.
---@param Floor? number Floor altitude ASL in meters.
---@param Ceiling? number Ceiling altitude ASL in meters.
---@return EASYGCICAP # self
function EASYGCICAP:SetCorridorZoneFloorAndCeilingMeters(Floor, Ceiling) end

---(Internal) Try to assign the intercept to a FlightGroup already in air and ready.
---@param ReadyFlightGroups? table ReadyFlightGroups
---@param InterceptAuftrag? AUFTRAG The Auftrag
---@param Group? GROUP The Target
---@param WingSize? number Calculated number of Flights
---@return boolean # assigned
---@return number # leftover
function EASYGCICAP:_TryAssignIntercept(ReadyFlightGroups, InterceptAuftrag, Group, WingSize) end

---Here, we'll decide if we need to launch an intercepting flight, and from where
---@param Cluster? INTEL.Cluster|number|string
---@return EASYGCICAP # self
function EASYGCICAP:_AssignIntercept(Cluster) end

---(Internal) Start detection.
---@return EASYGCICAP # self
function EASYGCICAP:_StartIntel() end

---@param From? any
---@param Event? any
---@param To? any
---@param Cluster? any
function BlueIntel:onbeforeNewCluster(From, Event, To, Cluster) end

---(Internal) FSM Function onafterStart
---@param From? string
---@param Event? string
---@param To? string
---@return EASYGCICAP # self
function EASYGCICAP:onafterStart(From, Event, To) end

---(Internal) FSM Function onbeforeStatus
---@param From? string
---@param Event? string
---@param To? string
---@return EASYGCICAP # self
function EASYGCICAP:onbeforeStatus(From, Event, To) end

---(Internal) FSM Function onafterStatus
---@param From? string
---@param Event? string
---@param To? string
---@return EASYGCICAP # self
function EASYGCICAP:onafterStatus(From, Event, To) end

---(Internal) FSM Function onafterStop
---@param From? string
---@param Event? string
---@param To? string
---@return EASYGCICAP # self
function EASYGCICAP:onafterStop(From, Event, To) end

---(Internal) FSM Function onafterRestart
---@param From? string
---@param Event? string
---@param To? string
---@return EASYGCICAP # self
function EASYGCICAP:onafterRestart(From, Event, To) end

---On Before "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYGCICAP:OnBeforeStart(From, Event, To) end

---On After "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYGCICAP:OnAfterStart(From, Event, To) end

---On Before "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYGCICAP:OnBeforeStatus(From, Event, To) end

---On After "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYGCICAP:OnAfterStatus(From, Event, To) end

---On Before "Restart" event. Use `myinstance:Restart()` in case you Stopped the instance before and want to restart it now.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYGCICAP:OnBeforeRestart(From, Event, To) end

---On After "Restart" event. Use `myinstance:Restart()` in case you Stopped the instance before and want to restart it now.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYGCICAP:OnAfterRestart(From, Event, To) end
