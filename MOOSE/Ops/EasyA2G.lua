---@meta

---@class EASYA2G.CapPoint
---@field AirbaseName string
---@field Coordinate COORDINATE
---@field Altitude number
---@field Speed number
---@field Heading number
---@field LegLength number
---@field Zone ZONE_BASE

---@class EASYA2G.Wing
---@field AirbaseName string
---@field Alias string
---@field CapZoneName string

---@class EASYA2G.Squad
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

---EASYA2G Class
---@class EASYA2G : EASYGCICAP
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
EASYA2G = {
  ClassName = "EASYA2G",
  overhead = 0.2,
  capgrouping = 1,
  airbasename = nil,
  airbase = nil,
  coalition = "blue",
  alias = nil,
  wings = {},
  Intel = nil,
  resurrection = 900,
  capspeed = 300,
  capalt = 25000,
  capdir = 45,
  capleg = 5,
  maxinterceptsize = 2,
  missionrange = 100,
  noalert5 = 2,
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
  EngageTargetTypes = {"Ground"},
}

---EASYA2G class version.
EASYA2G.version = "0.1.4"

---Create a new GCIA2G Manager
---@param Alias? string A Name for this A2G Setup
---@param AirbaseName? string Name of the Home Airbase
---@param Coalition? string Coalition, e.g. "blue" or "red"
---@param ScoutName? string (Partial) group name of the detection system of the coalition, e.g. "Red SCOUT", can be handed in as table of names, e.g.{"SCOUT","DRONE","SAM"}
---@return EASYA2G # self
function EASYA2G:New(Alias, AirbaseName, Coalition, ScoutName) end

---Set Tanker and Scouts to be invisible to enemy AI eyes
---@param Switch? boolean (Optional) Set to true or false, by default this is set to true already
---@return EASYA2G # self
function EASYA2G:SetTankerAndScoutsInvisible(Switch) end

---Set default A2G Speed in knots
---@param Speed? number (Optional) Speed defaults to 300
---@return EASYA2G # self
function EASYA2G:SetDefaultA2GSpeed(Speed) end

---Set A2G Flight formation.
---@param Formation? number (Optional) Formation to fly, defaults to ENUMS.Formation.FixedWing.FingerFour.Group
---@return EASYA2G # self
function EASYA2G:SetA2GFormation(Formation) end

---Set default A2G Altitude in feet
---@param Altitude? number (Optional) Altitude defaults to 25000
---@return EASYA2G # self
function EASYA2G:SetDefaultA2GAlt(Altitude) end

---Set default A2G lieg initial direction in degrees
---@param Direction? number (Optional) Direction defaults to 90 (East)
---@return EASYA2G # self
function EASYA2G:SetDefaultA2GDirection(Direction) end

---Set default leg length in NM
---@param Leg? number (Optional) Leg defaults to 5
---@return EASYA2G # self
function EASYA2G:SetDefaultA2GLeg(Leg) end

---Set default grouping, i.e. how many airplanes per A2G point
---@param Grouping? number (Optional) Grouping defaults to 2
---@return EASYA2G # self
function EASYA2G:SetDefaultA2GGrouping(Grouping) end

---Set A2G mission start to vary randomly between Start end End seconds.
---@param Start? number
---@param End? number
---@return EASYA2G # self
function EASYA2G:SetA2GStartTimeVariation(Start, End) end

---Set which target types A2G flights will prefer to engage, defaults to {"Ground"}
---@param types? table (Optional) Table of comma separated #string entries, defaults to {"Ground"} (everything that is ground and is not a weapon). Useful other options are e.g. {"Armored vehicles"}, {"Tanks"}, or {"APC"} or combinations like {"APC", "Tanks", "Artillery"}. See [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes).
---@return EASYA2G # self
function EASYA2G:SetA2GEngageTargetTypes(types) end

---Add a A2G patrol/holding point to a Wing
---@param AirbaseName? string Name of the Wing's airbase
---@param Coordinate? COORDINATE . Can be handed as a Core.Zone#ZONE object (e.g. in case you want  the point to align with a moving zone).
---@param Altitude? number (Optional) Defaults to 25000 feet ASL.
---@param Speed? number (Optional) Defaults to 300 knots TAS.
---@param Heading? number (Optional) Defaults to 90 degrees (East).
---@param LegLength? number (Optional) Defaults to 15 NM.
---@return EASYA2G # self
function EASYA2G:AddHoldingPointA2G(AirbaseName, Coordinate, Altitude, Speed, Heading, LegLength) end

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
---@return EASYA2G # self
function EASYA2G:_AddSquadron(TemplateName, SquadName, AirbaseName, AirFrames, Skill, Modex, Livery, Frequency, Modulation) end

---(Internal) Try to assign the intercept to a FlightGroup already in air and ready.
---@param ReadyFlightGroups? table ReadyFlightGroups
---@param Auftrag? AUFTRAG The Auftrag
---@param Group? GROUP The Target
---@param WingSize? number Calculated number of Flights
---@return boolean # assigned
---@return number # leftover
function EASYA2G:_TryAssignMission(ReadyFlightGroups, Auftrag, Group, WingSize) end

---Find a holding point closest to the group to be attacked (if any set)
---@param Group? GROUP
---@return COORDINATE # Point (can be nil!)
function EASYA2G:_GetClosestHoldingPoint(Group) end

---Here, we'll decide if we need to launch an attacking flight, and from where
---@param Cluster? INTEL.Cluster|number|string
---@return EASYA2G # self
function EASYA2G:_AssignMission(Cluster) end

---(Internal) Start detection.
---@return EASYA2G # self
function EASYA2G:_StartIntel() end

---@param From? any
---@param Event? any
---@param To? any
---@param Cluster? any
function BlueIntel:onbeforeNewCluster(From, Event, To, Cluster) end

---(Internal) FSM Function onafterStart
---@param From? string
---@param Event? string
---@param To? string
---@return EASYA2G # self
function EASYA2G:onafterStart(From, Event, To) end

---(Internal) FSM Function onafterStatus
---@param From? string
---@param Event? string
---@param To? string
---@return EASYA2G # self
function EASYA2G:onafterStatus(From, Event, To) end

---On Before "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYA2G:OnBeforeStart(From, Event, To) end

---On After "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYA2G:OnAfterStart(From, Event, To) end

---On Before "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYA2G:OnBeforeStatus(From, Event, To) end

---On After "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function EASYA2G:OnAfterStatus(From, Event, To) end
