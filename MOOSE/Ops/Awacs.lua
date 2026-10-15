---@meta

---@class RadioEntry
---@field TextTTS string
---@field TextScreen string
---@field IsNew boolean
---@field IsGroup boolean
---@field GroupID boolean
---@field Duration number
---@field ToScreen boolean
---@field FromAI boolean
RadioEntry = {}

---@class AWACS.AnchorData
---@field AnchorBaseAngels number
---@field StationZone ZONE_RADIUS
---@field StationZoneCoordinate COORDINATE
---@field StationZoneCoordinateText string
---@field StationName string
---@field AnchorAssignedID FIFO FiFo of #AWACS.AnchorAssignedEntry
---@field Anchors FIFO FiFo of available stacks
---@field AnchorMarker MARKER Tag for this station

---@class AWACS.AnchorAssignedEntry
---@field ID number
---@field Angels number

---@class AWACS.ManagedTask
---@field TID number
---@field AssignedGroupID number
---@field IsPlayerTask boolean
---@field IsUnassigned boolean
---@field Target TARGET
---@field Auftrag AUFTRAG
---@field Status AWACS.TaskStatus
---@field ToDo AWACS.TaskDescription
---@field ScreenText string Long descrition
---@field Contact INTEL.Contact
---@field Cluster INTEL.Cluster
---@field CurrentAuftrag number
---@field RequestedTimestamp number

---@class AWACS.ManagedContact
---@field CID number
---@field Contact INTEL.Contact
---@field Cluster INTEL.Cluster
---@field IFF string -- ID'ed or not (yet)
---@field Target TARGET
---@field LinkedTask number --> TID
---@field LinkedGroup number --> GID
---@field Status string - #AWACS.TaskStatus
---@field TargetGroupNaming string -- Alpha, Charlie
---@field ReportingName string -- NATO platform name
---@field EngagementTag string
---@field TACCallDone boolean
---@field MeldCallDone boolean
---@field MergeCallDone boolean

---@class AWACS.ManagedGroup
---@field Group GROUP
---@field GroupName string
---@field FlightGroup FLIGHTGROUP for AI
---@field IsPlayer boolean
---@field IsAI boolean
---@field CallSign string
---@field CurrentAuftrag number -- Auftragsnummer for AI
---@field CurrentTask number -- ManagedTask ID
---@field HasAssignedTask boolean
---@field GID number
---@field AnchorStackNo number
---@field AnchorStackAngels number
---@field ContactCID number
---@field LastKnownPosition COORDINATE
---@field LastTasking number TimeStamp

---@class AWACS.MenuStructure
---@field menuset boolean
---@field groupname string
---@field basemenu MENU_GROUP
---@field checkin MENU_GROUP_COMMAND
---@field checkout MENU_GROUP_COMMAND
---@field picture MENU_GROUP_COMMAND
---@field bogeydope MENU_GROUP_COMMAND
---@field declare MENU_GROUP_COMMAND
---@field tasking MENU_GROUP
---@field showtask MENU_GROUP_COMMAND
---@field judy MENU_GROUP_COMMAND
---@field unable MENU_GROUP_COMMAND
---@field abort MENU_GROUP_COMMAND
---@field commit MENU_GROUP_COMMAND
---@field vid MENU_GROUP
---@field neutral MENU_GROUP_COMMAND
---@field hostile MENU_GROUP_COMMAND
---@field friendly MENU_GROUP_COMMAND

---@class AWACS.MonitoringData
---@field AwacsStateMission string
---@field AwacsStateFG string
---@field AwacsShiftChange boolean
---@field EscortsStateMission table
---@field EscortsStateFG table
---@field EscortsShiftChange boolean
---@field AICAPMax number
---@field AICAPCurrent number
---@field Airwings number
---@field Players number
---@field PlayersCheckedin number

---Ops AWACS Class
---@class AWACS : FSM
---@field ClassName string Name of this class.
---@field version string Versioning.
---@field lid string LID for log entries.
---@field coalition number Coalition side.
---@field coalitiontxt string e.g."blue"
---@field OpsZone ZONE ,
---@field StationZone ZONE ,
---@field BorderZone ZONE ,
---@field RejectZone ZONE ,
---@field Frequency number
---@field Modulation number
---@field Airbase AIRBASE
---@field AirWing AIRWING
---@field AwacsAngels number
---@field OrbitZone ZONE
---@field CallSign number
---@field CallSignNo number
---@field debug boolean
---@field verbose number
---@field ManagedGrps table
---@field ManagedGrpID number
---@field ManagedTaskID number
---@field AnchorStacks FIFO
---@field CAPIdleAI FIFO
---@field CAPIdleHuman FIFO
---@field TaskedCAPAI FIFO
---@field TaskedCAPHuman FIFO
---@field OpenTasks FIFO
---@field ManagedTasks FIFO
---@field PictureAO FIFO
---@field PictureEWR FIFO
---@field Contacts FIFO
---@field CatchAllMissions table
---@field CatchAllFGs table
---@field Countactcounter number
---@field ContactsAO FIFO
---@field RadioQueue FIFO
---@field PrioRadioQueue FIFO
---@field CAPAirwings FIFO
---@field TacticalQueue FIFO
---@field AwacsTimeOnStation number
---@field AwacsTimeStamp number
---@field EscortsTimeOnStation number
---@field EscortsTimeStamp number
---@field AwacsROE string
---@field AwacsROT string
---@field AwacsMission AUFTRAG
---@field EscortMission AUFTRAG
---@field AwacsMissionReplacement AUFTRAG
---@field EscortMissionReplacement AUFTRAG
---@field AICAPMissions FIFO FIFO for Ops.Auftrag#AUFTRAG for AI CAP
---@field MenuStrict boolean
---@field MaxAIonCAP number
---@field AIonCAP number
---@field ShiftChangeAwacsFlag boolean
---@field ShiftChangeEscortsFlag boolean
---@field ShiftChangeAwacsRequested boolean
---@field ShiftChangeEscortsRequested boolean
---@field MonitoringData AWACS.MonitoringData
---@field MonitoringOn boolean
---@field clientset SET_CLIENT
---@field FlightGroups FIFO
---@field PictureInterval number Interval in seconds for general picture
---@field PictureTimeStamp number Interval timestamp
---@field maxassigndistance number Only assing AI/Pilots to targets max this far away
---@field PlayerGuidance boolean if true additional callouts to guide/warn players
---@field ModernEra boolean if true we get more intel on targets, and EPLR on the AIC
---@field callsignshort boolean if true use short (group) callsigns, e.g. "Ghost 1", else "Ghost 1 1"
---@field keepnumber boolean if true, use the full string after # for a player custom callsign
---@field callsignTranslations table optional translations for callsigns
---@field MeldDistance number 25nm - distance for "Meld" Call , usually shortly before the actual engagement
---@field TacDistance number 30nm - distance for "TAC" Call
---@field ThreatDistance number 15nm - distance to declare untargeted (new) threats
---@field AOName string name of the FEZ, e.g. Rock
---@field AOCoordinate COORDINATE Coordinate of bulls eye
---@field clientmenus FIFO
---@field RadarBlur number Radar blur in %
---@field ReassignmentPause number Wait this many seconds before re-assignment of a player
---@field NoGroupTags boolean Set to true if you don't want group tags.
---@field SuppressScreenOutput boolean Set to true to suppress all screen output.
---@field NoMissileCalls boolean Suppress missile callouts
---@field PlayerCapAssignment boolean Assign players to CAP tasks when they are logged on
---@field GoogleTTSPadding number
---@field WindowsTTSPadding number
---@field AllowMarkers boolean
---@field PlayerStationName string
---@field GCI boolean Act as GCI
---@field GCIGroup GROUP EWR group object for GCI ops
---@field locale string Localization
---@field IncludeHelicopters boolean
---@field TacticalMenu boolean
---@field TacticalFrequencies table
---@field TacticalSubscribers table
---@field TacticalBaseFreq number
---@field TacticalIncrFreq number
---@field TacticalModulation number
---@field TacticalInterval number
---@field DetectionSet SET_GROUP
---@field MaxMissionRange number
AWACS = {
  ClassName = "AWACS", -- #string
  version = "0.2.74", -- #string
  lid = "", -- #string
  coalition = coalition.side.BLUE, -- #number
  coalitiontxt = "blue", -- #string
  OpsZone = nil,
  StationZone = nil,
  AirWing = nil,
  Frequency = 271, -- #number
  Modulation = radio.modulation.AM, -- #number
  Airbase = nil,
  AwacsAngels = 25, -- orbit at 25'000 ft
  OrbitZone = nil,
  CallSign = CALLSIGN.AWACS.Magic, -- #number
  CallSignNo = 1, -- #number
  debug = false,
  verbose = false,
  ManagedGrps = {},
  ManagedGrpID = 0, -- #number
  ManagedTaskID = 0, -- #number
  AnchorStacks = {}, -- Utilities.FiFo#FIFO
  CAPIdleAI = {},
  CAPIdleHuman = {},
  TaskedCAPAI = {},
  TaskedCAPHuman = {},
  OpenTasks = {}, -- Utilities.FiFo#FIFO
  ManagedTasks = {}, -- Utilities.FiFo#FIFO
  PictureAO = {}, -- Utilities.FiFo#FIFO
  PictureEWR = {}, -- Utilities.FiFo#FIFO
  Contacts = {}, -- Utilities.FiFo#FIFO
  Countactcounter = 0,
  ContactsAO = {}, -- Utilities.FiFo#FIFO
  RadioQueue = {}, -- Utilities.FiFo#FIFO
  PrioRadioQueue = {}, -- Utilities.FiFo#FIFO
  TacticalQueue = {}, -- Utilities.FiFo#FIFO
  AwacsTimeOnStation = 4,
  AwacsTimeStamp = 0,
  EscortsTimeOnStation = 4,
  EscortsTimeStamp = 0,
  CAPTimeOnStation = 4,
  AwacsROE = "",
  AwacsROT = "",
  MenuStrict = true,
  MaxAIonCAP = 3,
  AIonCAP = 0,
  AICAPMissions = {}, -- Utilities.FiFo#FIFO
  ShiftChangeAwacsFlag = false,
  ShiftChangeEscortsFlag = false,
  ShiftChangeAwacsRequested = false,
  ShiftChangeEscortsRequested = false,
  CAPAirwings = {},  -- Utilities.FiFo#FIFO
  MonitoringData = {},
  MonitoringOn = false,
  FlightGroups = {},
  AwacsMission = nil,
  AwacsInZone = false, -- not yet arrived or gone again
  AwacsReady = false,
  CatchAllMissions = {},
  CatchAllFGs = {},
  PictureInterval = 300,
  ReassignTime = 120,
  PictureTimeStamp = 0,
  BorderZone = nil,
  RejectZone = nil,
  maxassigndistance = 100,
  PlayerGuidance = true,
  ModernEra = true,
  callsignshort = true,
  keepnumber = true,
  callsignTranslations = nil,
  TacDistance = 45,
  MeldDistance = 35,
  ThreatDistance = 25,
  AOName = "Rock",
  AOCoordinate = nil,
  clientmenus = nil,
  RadarBlur = 15,
  ReassignmentPause = 180,
  NoGroupTags = false,
  SuppressScreenOutput = false,
  NoMissileCalls = true,
  GoogleTTSPadding = 1,
  WindowsTTSPadding = 2.5,
  PlayerCapAssignment = true,
  AllowMarkers = false,
  PlayerStationName = nil,
  GCI = false,
  GCIGroup = nil,
  locale = "en",
  IncludeHelicopters = false,
  TacticalMenu = false,
  TacticalFrequencies = {},
  TacticalSubscribers = {},
  TacticalBaseFreq = 130,
  TacticalIncrFreq = 0.5,
  TacticalModulation = radio.modulation.AM,
  TacticalInterval = 120,
  DetectionSet = nil,
  MaxMissionRange = 125,
}

AWACS.CallSignClear = {
    [1]="Overlord",
    [2]="Magic",
    [3]="Wizard",
    [4]="Focus",
    [5]="Darkstar",
}

AWACS.AnchorNames = {
  [1] = "One",
  [2] = "Two",
  [3] = "Three",
  [4] = "Four",
  [5] = "Five",
  [6] = "Six",
  [7] = "Seven",
  [8] = "Eight",
  [9] = "Nine",
  [10] = "Ten",
}

AWACS.ROE = {
  POLICE = "Police",
  VID = "Visual ID",
  IFF = "IFF",
  BVR = "Beyond Visual Range",
}

AWACS.ROT = {
    BYPASSESCAPE = "Bypass and Escape",
    EVADE = "Evade Fire",
    PASSIVE = "Passive Defense",
    RETURNFIRE = "Return Fire",
    OPENFIRE = "Open Fire",
 }

AWACS.THREATLEVEL = {
  GREEN = 3,
  AMBER = 7,
  RED = 10,
}

AWACS.CapVoices = {
  [1] = "de-DE-Wavenet-A",
  [2] = "de-DE-Wavenet-B",
  [3] = "fr-FR-Wavenet-A",
  [4] = "fr-FR-Wavenet-B",
  [5] = "en-GB-Wavenet-A",
  [6] = "en-GB-Wavenet-B",
  [7] = "en-GB-Wavenet-D",
  [8] = "en-AU-Wavenet-B",
  [9] = "en-US-Wavenet-J",
  [10] = "en-US-Wavenet-H",
}

AWACS.Messages = {
  EN =
    {
    DEFEND = "%s, %s! %s! %s! Defend!",
    VECTORTO = "%s, %s. Vector%s %s",
    VECTORTOTTS = "%s, %s, Vector%s %s",
    ANGELS = ". Angels ",
    ZERO = "zero",
    VANISHED = "%s, %s Group. Vanished.",
    VANISHEDTTS = "%s, %s group vanished.",
    SHIFTCHANGE = "%s shift change for %s control.",
    GROUPCAP = "Group",
    GROUP = "group",
    MILES = "miles",
    THOUSAND = "thousand",
    BOGEY = "Bogey",
    ALLSTATIONS = "All Stations",
    PICCLEAN = "%s. %s. Picture Clean.",
    PICTURE = "Picture",
    ONE = "One",
    GROUPMULTI = "groups",
    NOTCHECKEDIN = "%s. %s. Negative. You are not checked in.",
    CLEAN = "%s. %s. Clean.",
    DOPE = "%s. %s. Bogey Dope. ",
    VIDPOS = "%s. %s. Copy, target identified as %s.",
    VIDNEG = "%s. %s. Negative, get closer to target.",
    FFNEUTRAL = "Neutral",
    FFFRIEND = "Friendly",
    FFHOSTILE = "Hostile",
    FFSPADES = "Spades",
    FFCLEAN = "Clean",
    COPY = "%s. %s. Copy.",
    TARGETEDBY = "Targeted by %s.",
    STATUS = "Status",
    ALREADYCHECKEDIN = "%s. %s. Negative. You are already checked in.",
    ALPHACHECK = "Alpha Check",
    CHECKINAI = "%s. %s. Checking in as fragged. Expected playtime %d hours. Request Alpha Check %s.",
    SAFEFLIGHT = "%s. %s. Copy. Have a safe flight home.",
    VERYLOW = "very low",
    AIONSTATION = "%s. %s. On station over anchor %d at angels  %d. Ready for tasking.",
    POPUP = "Pop-up",
    NEWGROUP = "New group",
    HIGH= " High.",
    VERYFAST = " Very fast.",
    FAST = " Fast.",
    THREAT = "Threat",
    MERGED = "Merged",
    SCREENVID = "Intercept and VID %s group.",
    SCREENINTER = "Intercept %s group.",
    ENGAGETAG = "Targeted by %s.",
    REQCOMMIT = "%s. %s group. %s. %s, request commit.",
    AICOMMIT = "%s. %s group. %s. %s, commit.",
    COMMIT = "Commit",
    SUNRISE = "%s. All stations, SUNRISE SUNRISE SUNRISE, %s.",
    AWONSTATION = "%s on station for %s control.",
    STATIONAT = "%s. %s. Station at %s at angels %d.",
    STATIONATLONG = "%s. %s. Station at %s at angels %d doing %d knots.",
    STATIONSCREEN = "%s. %s.\nStation at %s\nAngels %d\nSpeed %d knots\nCoord %s\nROE %s.",
    STATIONTASK = "Station at %s\nAngels %d\nSpeed %d knots\nCoord %s\nROE %s",
    VECTORSTATION = " to Station",
    TEXTOPTIONS1 = "Lost friendly flight",
    TEXTOPTIONS2 =  "Vanished friendly flight",
    TEXTOPTIONS3 =  "Faded friendly contact",
    TEXTOPTIONS4 =  "Lost contact with",
    },
} 

---@class AWACS.TaskDescription
AWACS.TaskDescription = {
  ANCHOR = "Anchor",
  REANCHOR = "Re-Anchor",
  VID = "VID",
  IFF = "IFF",
  INTERCEPT = "Intercept",
  SWEEP = "Sweep",
  RTB = "RTB",
}

---@class AWACS.TaskStatus
AWACS.TaskStatus = {
  IDLE = "Idle",
  UNASSIGNED = "Unassigned",
  REQUESTED = "Requested",
  ASSIGNED = "Assigned",
  EXECUTING = "Executing",
  SUCCESS = "Success",
  FAILED = "Failed",
  DEAD = "Dead",
}

---Set up a new AI AWACS.
---@param Name? string Name of this AWACS for the radio menu.
---@param AirWing? string The core Ops.Airwing#AIRWING managing the AWACS, Escort and (optionally) AI CAP planes for us.
---@param Coalition? number Coalition, e.g. coalition.side.BLUE. Can also be passed as "blue", "red" or "neutral".
---@param AirbaseName? string Name of the home airbase.
---@param AwacsOrbit? string Name of the round, mission editor created zone where this AWACS orbits.
---@param OpsZone? string Name of the round, mission editor created Fighter Engagement operations zone (FEZ) this AWACS controls. Can be passed as #ZONE_POLYGON. The name of the zone will be used in reference calls as bulls eye name, so ensure a radio friendly name that does not collide with NATOPS keywords.
---@param StationZone? string Name of the round, mission editor created anchor zone where CAP groups will be stationed. Usually a short city name.
---@param Frequency? number Radio frequency, e.g. 271.
---@param Modulation? number Radio modulation, e.g. radio.modulation.AM or radio.modulation.FM.
---@return AWACS # self
function AWACS:New(Name, AirWing, Coalition, AirbaseName, AwacsOrbit, OpsZone, StationZone, Frequency, Modulation) end

---[User] Set the tactical information option, create 10 radio channels groups can subscribe and get Bogey Dope on a specific frequency automatically. You **need** to set up SRS first before using this!
---@param BaseFreq? number (Optional) Base Frequency to use, defaults to 130.
---@param Increase? number (Optional) Increase to use, defaults to 0.5, thus channels created are 130, 130.5, 131 .. etc.
---@param Modulation? number (Optional) Modulation to use, defaults to radio.modulation.AM.
---@param Interval? number Seconds between each update call.
---@param Number? number Number of Frequencies to create, can be 1..10.
---@param Provider? string (Optional) TTS Provider to be used.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AWACS # self
function AWACS:SetTacticalRadios(BaseFreq, Increase, Modulation, Interval, Number, Provider, Speaker) end

---TODO
---[Internal] _RefreshMenuNonSubscribed
---@return AWACS # self
function AWACS:_RefreshMenuNonSubscribed() end

---[Internal] _UnsubScribeTactRadio
---@param Group? GROUP
---@return AWACS # self
function AWACS:_UnsubScribeTactRadio(Group) end

---[Internal] _SubScribeTactRadio
---@param Group? GROUP
---@param Frequency? number
---@return AWACS # self
function AWACS:_SubScribeTactRadio(Group, Frequency) end

---[Internal] _CheckSubscribers
---@return AWACS # self
function AWACS:_CheckSubscribers() end

---[Internal] Init localization
---@return AWACS # self
function AWACS:_InitLocalization() end

---[User] Set locale for localization. Defaults to "en"
---@param Locale? string The locale to use
---@return AWACS # self
function AWACS:SetLocale(Locale) end

---[User] Set own coordinate for BullsEye.
---@param Coordinate? any
---@return AWACS # self
function AWACS:SetBullsCoordinate(Coordinate) end

---[User] Set the max mission range flights can be away from their home base.
---@param NM? number Distance in nautical miles
---@return AWACS # self
function AWACS:SetMaxMissionRange(NM) end

---[User] Add additional frequency and modulation for AWACS SRS output.
---@param Frequency? number The frequency to add, e.g. 132.5
---@param Modulation? number The modulation to add for the frequency, e.g. radio.modulation.AM
---@return AWACS # self
function AWACS:AddFrequencyAndModulation(Frequency, Modulation) end

---[User] Set this instance to act as GCI TACS Theater Air Control System
---@param EWR? GROUP The **main** Early Warning Radar (EWR) GROUP object for GCI.
---@param Delay? number (option) Start after this many seconds (optional).
---@return AWACS # self
function AWACS:SetAsGCI(EWR, Delay) end

---[Internal] Create a AIC-TTS message entry
---@param TextTTS? string Text to speak
---@param TextScreen? string Text for screen
---@param GID? number Group ID #AWACS.ManagedGroup GID
---@param IsGroup? boolean Has a group
---@param ToScreen? boolean Show on screen
---@param IsNew? boolean New
---@param FromAI? boolean From AI
---@param IsPrio? boolean Priority entry
---@param Tactical? boolean Is for tactical info
---@return AWACS # self
function AWACS:_NewRadioEntry(TextTTS, TextScreen, GID, IsGroup, ToScreen, IsNew, FromAI, IsPrio, Tactical) end

---[User] Change the bulls eye alias for AWACS callout. Defaults to "Rock"
---@param Name? string
---@return AWACS # self
function AWACS:SetBullsEyeAlias(Name) end

---[User] Set TOS Time-on-Station in Hours
---@param AICHours? number (Optional) AWACS stays this number of hours on station before shift change, default is 4.
---@param CapHours? number (Optional) CAP stays this number of hours on station before shift change, default is 4.
---@return AWACS # self
function AWACS:SetTOS(AICHours, CapHours) end

---[User] Change number of seconds AWACS waits until a Player is re-assigned a different task. Defaults to 180.
---@param Seconds? number
---@return AWACS # self
function AWACS:SetReassignmentPause(Seconds) end

---[User] Do not show messages on screen
---@param Switch? boolean If true, no messages will be shown on screen.
---@return AWACS # self
function AWACS:SuppressScreenMessages(Switch) end

---[User] Do not show messages on screen, no extra calls for player guidance, use short callsigns etc.
---@return AWACS # self
function AWACS:ZipLip() end

---[User] For CAP flights: Replace ME callsigns with user-defined callsigns for use with TTS and on-screen messaging
---@param translationTable? table with DCS callsigns as keys and replacements as values
---@return AWACS # self
function AWACS:SetCustomCallsigns(translationTable) end

---[Internal] Event handler
---@param Group? GROUP Group, can also be passed as #string group name
---@return boolean # found
---@return number # GID
---@return string # CallSign
function AWACS:_GetGIDFromGroupOrName(Group) end

---[Internal] Event handler
---@param EventData? EVENTDATA
---@return AWACS # self
function AWACS:_EventHandler(EventData) end

---[Internal] Missile Warning Callout
---@param Coordinate? COORDINATE Where the shot happened
---@param Type? string Type to call out, e.i. "SAM" or "Missile"
---@param Warndist? number Distance in NM to find friendly planes
---@return AWACS # self
function AWACS:_MissileWarning(Coordinate, Type, Warndist) end

---[User] Set AWACS Radar Blur - the radar contact count per group/cluster will be distored up or down by this number percent. Defaults to 15 in Modern Era and 25 in Cold War.
---@param Percent? number
---@return AWACS # self
function AWACS:SetRadarBlur(Percent) end

---[User] Set AWACS to Cold War standards - ROE to VID, ROT to Passive (bypass and escape). Radar blur 25%.
---Sets TAC/Meld/Threat call distances to 35, 25 and 15 nm.
---@return AWACS # self
function AWACS:SetColdWar() end

---[User] Set AWACS to Modern Era standards - ROE to BVR, ROT to defensive (evade fire). Radar blur 15%.
---@return AWACS # self
function AWACS:SetModernEra() end

---[User] Set AWACS to Modern Era standards - ROE to IFF, ROT to defensive (evade fire). Radar blur 15%.
---@return AWACS # self
function AWACS:SetModernEraDefensive() end

---[User] Set AWACS to Modern Era standards - ROE to BVR, ROT to return fire. Radar blur 15%.
---@return AWACS # self
function AWACS:SetModernEraAggressive() end

---[User] Set AWACS to Policing standards - ROE to VID, ROT to Lock (bypass and escape). Radar blur 15%.
---@return AWACS # self
function AWACS:SetPolicingModern() end

---[User] Set AWACS to Policing standards - ROE to VID, ROT to Lock (bypass and escape). Radar blur 25%.
---Sets TAC/Meld/Threat call distances to 35, 25 and 15 nm.
---@return AWACS # self
function AWACS:SetPolicingColdWar() end

---[User] Set AWACS Player Guidance - influences missile callout and the "New" label in group callouts.
---@param Switch? boolean (Optional) If true (default) it is on, if false, it is off.
---@return AWACS # self
function AWACS:SetPlayerGuidance(Switch) end

---[User] Get AWACS Name
---@return string # Name of this instance
function AWACS:GetName() end

---[User] Set AWACS intercept timeline support distance.
---@param TacDistance? number (Optional) Distance for TAC call, default 45nm
---@param MeldDistance? number (Optional) Distance for Meld call, default 35nm
---@param ThreatDistance? number (Optional) Distance for Threat call, default 25nm
---@return AWACS # self
function AWACS:SetInterceptTimeline(TacDistance, MeldDistance, ThreatDistance) end

---[User] Set additional defensive zone, e.g. the zone behind the FEZ to also be defended
---@param Zone? ZONE
---@param Draw? boolean Draw lines around this zone if true
---@return AWACS # self
function AWACS:SetAdditionalZone(Zone, Draw) end

---[User] Set rejection zone, e.g. a border of a foreign country. Detected bogeys in here won't be engaged.
---@param Zone? ZONE
---@param Draw? boolean Draw lines around this zone if true
---@return AWACS # self
function AWACS:SetRejectionZone(Zone, Draw) end

---Function to set corridor zones.
---@param CorridorZones? SET_ZONE Can be handed in as SET\_ZONE or single ZONE object.
---@return AWACS # self
function AWACS:SetCorridorZones(CorridorZones) end

---Function to add one corridor zone.
---@param CorridorZone? ZONE The ZONE object to be added.
---@return AWACS # self
function AWACS:AddCorridorZone(CorridorZone) end

---Function to set corridor zone floor and ceiling in FEET.
---@param Floor? number Floor altitude ASL in feet.
---@param Ceiling? number Ceiling altitude ASL in feet.
---@return AWACS # self
function AWACS:SetCorridorZoneFloorAndCeiling(Floor, Ceiling) end

---Function to set corridor zone floor and ceiling in METERS.
---@param Floor? number Floor altitude ASL in meters.
---@param Ceiling? number Ceiling altitude ASL in meters.
---@return AWACS # self
function AWACS:SetCorridorZoneFloorAndCeilingMeters(Floor, Ceiling) end

---[User] Draw a line around the FEZ on the F10 map.
---@return AWACS # self
function AWACS:DrawFEZ() end

---[User] Set AWACS flight details
---@param CallSign? number (Optional) Defaults to CALLSIGN.AWACS.Magic
---@param CallSignNo? number (Optional) Defaults to 1
---@param Angels? number (Optional) Defaults to 25 (i.e. 25000 ft)
---@param Speed? number (Optional) Defaults to 250kn
---@param Heading? number (Optional) Defaults to 0 (North)
---@param Leg? number (Optional) Defaults to 25nm
---@return AWACS # self
function AWACS:SetAwacsDetails(CallSign, CallSignNo, Angels, Speed, Heading, Leg) end

---[User] Set AWACS custom callsigns for TTS
---@param CallsignTable? table Table of custom callsigns to use with TTS
---@return AWACS # self
function AWACS:SetCustomAWACSCallSign(CallsignTable) end

---[User] Add a radar GROUP object to the INTEL detection SET_GROUP
---@param Group? GROUP The GROUP to be added. Can be passed as SET_GROUP.
---@return AWACS # self
function AWACS:AddGroupToDetection(Group) end

---[User] Set AWACS SRS TTS details - see {Sound.SRS} for details. `SetSRS()` will try to use as many attributes configured with {Sound.SRS#MSRS.LoadConfigFile}() as possible.
---@param PathToSRS? string (Optional) Defaults to "C:\\Program Files\\DCS-SimpleRadio-Standalone\\ExternalAudio"
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest) Defaults to 1.0.
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS; if you use a config file for MSRS, hand in nil here.
---@param AccessKey? string (Optional) Your Google API access key. This is necessary if DCS-gRPC is used as backend; if you use a config file for MSRS, hand in nil here.
---@param Backend? string (Optional) Your MSRS Backend if different from your config file settings, e.g. MSRS.Backend.SRSEXE or MSRS.Backend.GRPC
---@param Provider? string (Optional) TTS Provider to be used.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AWACS # self
function AWACS:SetSRS(PathToSRS, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, AccessKey, Backend, Provider, Speaker) end

---[User] Set AWACS Voice Details for AI CAP Planes  - SRS TTS - see {Sound.SRS} for details
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Voice? string (Optional) Use a specifc voice with the @{#MSRS.SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AWACS # self
function AWACS:SetSRSVoiceCAP(Gender, Culture, Voice, Speaker) end

---[User] Set AI CAP Plane Details
---@param Callsign? number (Optional) Callsign name of AI CAP, e.g. CALLSIGN.Aircraft.Dodge. Defaults to CALLSIGN.Aircraft.Colt. Note that not all available callsigns work for all plane types.
---@param MaxAICap? number (Optional) Maximum number of AI CAP planes on station that AWACS will set up automatically. Default to 4.
---@param TOS? number (Optional) Time on station, in  hours. AI planes might go back to base earlier if they run out of fuel or missiles. Defaults to 4.
---@param Speed? number (Optional) Airspeed to be used in knots. Will be adjusted to flight height automatically. Defaults to 270.
---@return AWACS # self
function AWACS:SetAICAPDetails(Callsign, MaxAICap, TOS, Speed) end

---[User] Set AWACS Escorts Template
---@param EscortNumber? number Number of fighther plane GROUPs to accompany this AWACS. 0 or nil means no escorts. If you want >1 plane in an escort group, you can either set the respective squadron grouping to the desired number, or use a template for escorts with >1 unit.
---@param Formation? number Formation the escort should take (if more than one plane), e.g. `ENUMS.Formation.FixedWing.FingerFour.Group`. Formation is used on GROUP level, multiple groups of one unit will NOT conform to this formation.
---@param OffsetVector? table Offset the escorts should fly behind the AWACS, given as table, distance in meters, e.g. `{x=-500,y=0,z=500}` - 500m behind (negative value) and to the right (negative for left), no vertical separation (positive over, negative under the AWACS flight). For multiple groups, the vectors will be slightly changed to avoid collisions.
---@param EscortEngageMaxDistance? number (Optional) Escorts engage air targets max this NM away, defaults to 45NM.
---@return AWACS # self
function AWACS:SetEscort(EscortNumber, Formation, OffsetVector, EscortEngageMaxDistance) end

---[Internal] Message a vector BR to a position
---@param GID? number Group GID
---@param Tag? string (optional) Text to add after Vector, e.g. " to Anchor" - NOTE the leading space
---@param Coordinate? COORDINATE The Coordinate to use
---@param Angels? number (Optional) Add Angels
---@return AWACS # self
function AWACS:_MessageVector(GID, Tag, Coordinate, Angels) end

---[Internal] Start AWACS Escorts FlightGroup
---@param Shiftchange? boolean This is a shift change call
---@return AWACS # self
function AWACS:_StartEscorts(Shiftchange) end

---[Internal] AWACS further Start Settings
---@param FlightGroup? FLIGHTGROUP
---@param Mission? AUFTRAG
---@return AWACS # self
function AWACS:_StartSettings(FlightGroup, Mission) end

---[Internal] Return Bullseye BR for Alpha Check etc, returns e.g. "Rock 021, 16" ("Rock" being the set BE name)
---@param Coordinate? COORDINATE
---@param ssml? boolean Add SSML tag
---@param TTS? boolean For non-Alpha checks, hand back in format "Rock 0 2 1, 16"
---@return string # BullseyeBR
function AWACS:_ToStringBULLS(Coordinate, ssml, TTS) end

---[Internal] Change Bullseye string to be TTS friendly,  "Bullseye 021, 16" returns e.g. "Bulls eye 0 2 1. 1 6"
---@param Text? string Input text
---@return string # BullseyeBRTTS
function AWACS:_ToStringBullsTTS(Text) end

---[Internal] Check if a group has checked in
---@param Group? GROUP Group to check
---@return number # ID
---@return boolean # CheckedIn
---@return string # CallSign
function AWACS:_GetManagedGrpID(Group) end

---[Internal] AWACS Get TTS compatible callsign
---@param Group? GROUP Group to use
---@param GID? number GID to use
---@param IsPlayer? boolean Check in player if true
---@return string # Callsign
function AWACS:_GetCallSign(Group, GID, IsPlayer) end

---[User] Set player callsign options for TTS output. See {Wrapper.Group#GROUP.GetCustomCallSign}() on how to set customized callsigns.
---@param ShortCallsign? boolean If true, only call out the major flight number
---@param Keepnumber? boolean If true, keep the **customized callsign** in the #GROUP name as-is, no amendments or numbers.
---@param CallsignTranslations? table (Optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized. callsigns from playername or group name.
---@param CallsignCustomFunc? function (Optional) For player names only(!). If given, this function will return the callsign. Needs to take the groupname and the playername as first two arguments.
---@param ... any
---@return AWACS # self
function AWACS:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations, CallsignCustomFunc, ...) end

---[Internal] Update contact from cluster data
---@param CID? number Contact ID
---@return AWACS # self
function AWACS:_UpdateContactFromCluster(CID) end

---[Internal] Check merges for Players
---@return AWACS # self
function AWACS:_CheckMerges() end

---[Internal] Clean up contacts list
---@return AWACS # self
function AWACS:_CleanUpContacts() end

---[Internal] Select pilots available for tasking, return AI and Human
---@return table # AIPilots Table of #AWACS.ManagedGroup
---@return table # HumanPilots Table of #AWACS.ManagedGroup
function AWACS:_GetIdlePilots() end

---[Internal] Select max 3 targets for picture, bogey dope etc
---@param Untargeted? boolean Return not yet targeted contacts only
---@return boolean # HaveTargets True if targets could be found, else false
---@return FIFO # Targetselection
function AWACS:_TargetSelectionProcess(Untargeted) end

---[Internal] AWACS Speak Picture AO/EWR entries
---@param AO? boolean If true this is for AO, else EWR
---@param Callsign? string Callsign to address
---@param GID? number GroupID for comms
---@param MaxEntries? number Max entries to show
---@param IsGeneral? boolean Is a general picture, address all stations
---@return AWACS # self
function AWACS:_CreatePicture(AO, Callsign, GID, MaxEntries, IsGeneral) end

---[Internal] AWACS Speak Bogey Dope entries
---@param Callsign? string Callsign to address
---@param GID? number GroupID for comms
---@param Tactical? boolean Is for tactical info
---@return AWACS # self
function AWACS:_CreateBogeyDope(Callsign, GID, Tactical) end

---[Internal] AWACS Menu for Picture
---@param Group? GROUP Group to use
---@param IsGeneral? boolean General picture if true, address no-one specific
---@return AWACS # self
function AWACS:_Picture(Group, IsGeneral) end

---[Internal] AWACS Menu for Bogey Dope
---@param Group? GROUP Group to use
---@param Tactical? boolean Check for tactical info
---@return AWACS # self
function AWACS:_BogeyDope(Group, Tactical) end

---[Internal] AWACS Menu for Show Info
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_ShowAwacsInfo(Group) end

---[Internal] AWACS Menu for VID
---@param Group? GROUP Group to use
---@param Declaration? string Text declaration the player used
---@return AWACS # self
function AWACS:_VID(Group, Declaration) end

---[Internal] AWACS Menu for Declare
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_Declare(Group) end

---[Internal] AWACS Menu for Commit
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_Commit(Group) end

---[Internal] AWACS Menu for Judy
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_Judy(Group) end

---[Internal] AWACS Menu for Unable
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_Unable(Group) end

---[Internal] AWACS Menu for Abort
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_TaskAbort(Group) end

---[Internal] AWACS Menu for Showtask
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_Showtask(Group) end

---[Internal] AWACS Menu for Check in
---@param Group? GROUP Group to use
---@return AWACS # self
function AWACS:_CheckIn(Group) end

---[Internal] AWACS Menu for CheckInAI
---@param FlightGroup? FLIGHTGROUP to use
---@param Group? GROUP Group to use
---@param AuftragsNr? number Ops.Auftrag#AUFTRAG.auftragsnummer
---@return AWACS # self
function AWACS:_CheckInAI(FlightGroup, Group, AuftragsNr) end

---[Internal] AWACS Menu for Check Out
---@param Group? GROUP Group to use
---@param GID? number GroupID
---@param dead? boolean If true, group is dead crashed or otherwise n/a
---@return AWACS # self
function AWACS:_CheckOut(Group, GID, dead) end

---[Internal] AWACS set client menus
---@return AWACS # self
function AWACS:_SetClientMenus() end

---[Internal] AWACS Delete a new Anchor Stack from a Marker - only works if no assignments are on the station
---@param Name? any
---@param Coord? any
---@return AWACS # self
function AWACS:_DeleteAnchorStackFromMarker(Name, Coord) end

---[Internal] AWACS Move a new Anchor Stack from a Marker
---@param Name? any
---@param Coord? any
---@return AWACS # self
function AWACS:_MoveAnchorStackFromMarker(Name, Coord) end

---[Internal] AWACS Create a new Anchor Stack from a Marker - this then is the preferred station for players
---@param Name? any
---@param Coord? any
---@return AWACS # self
function AWACS:_CreateAnchorStackFromMarker(Name, Coord) end

---[Internal] AWACS Create a new Anchor Stack
---@return boolean # success
---@return number # AnchorStackNo
function AWACS:_CreateAnchorStack() end

---[Internal] AWACS get free anchor stack for managed groups
---@return number # AnchorStackNo
---@return boolean # free
function AWACS:_GetFreeAnchorStack() end

---[Internal] AWACS Assign Anchor Position to a Group
---@param GID? number Managed Group ID
---@param HasOwnStation? boolean
---@param StationName? string
---@return AWACS # self
function AWACS:_AssignAnchorToID(GID, HasOwnStation, StationName) end

---[Internal] Remove GID (group) from Anchor Stack
---@param GID? any
---@param AnchorStackNo? number
---@param Angels? number
---@return AWACS # self
function AWACS:_RemoveIDFromAnchor(GID, AnchorStackNo, Angels) end

---[Internal] Start INTEL detection when we reach the AWACS Orbit Zone
---@param awacs? GROUP
---@return AWACS # self
function AWACS:_StartIntel(awacs) end

---[Internal] Get blurred size of group or cluster
---@param size? number
---@return number # adjusted size
---@return string # AWACS.Shipsize entry for size 1..4
function AWACS:_GetBlurredSize(size) end

---[Internal] Get threat level as clear test
---@param threatlevel? number
---@return string # threattext
function AWACS:_GetThreatLevelText(threatlevel) end

---[Internal] Get BR text for TTS
---@param FromCoordinate? COORDINATE
---@param ToCoordinate? COORDINATE
---@return string # BRText Desired Output (BR) "214, 35 miles"
---@return string # BRTextTTS Desired Output (BR) "2 1 4, 35 miles"
function AWACS:_ToStringBR(FromCoordinate, ToCoordinate) end

---[Internal] Get BRA text for TTS
---@param FromCoordinate? COORDINATE
---@param ToCoordinate? COORDINATE
---@param Altitude? number Altitude in meters
---@return string # BRText Desired Output (BRA) "214, 35 miles, 20 thousand"
---@return string # BRTextTTS Desired Output (BRA) "2 1 4, 35 miles, 20 thousand"
function AWACS:_ToStringBRA(FromCoordinate, ToCoordinate, Altitude) end

---[Internal] Get BR text for TTS - ie "Rock 214, 24 miles" and TTS "Rock 2 1 4, 24 miles"
---@param clustercoordinate? COORDINATE
---@return string # BRAText
---@return string # BRATextTTS
function AWACS:_GetBRAfromBullsOrAO(clustercoordinate) end

---[Internal] Register Task for Group by GID
---@param GroupID? number ManagedGroup ID
---@param Description? AWACS.TaskDescription|number|string Short Description Task Type
---@param ScreenText? string Long task description for screen output
---@param Object? table Object for Ops.Target#TARGET assignment
---@param TaskStatus? AWACS.TaskStatus|number|string Status of this task
---@param Auftrag? AUFTRAG The Auftrag for this task if any
---@param Cluster? INTEL.Cluster|number|string Intel Cluster for this task
---@param Contact? INTEL.Contact|number|string Intel Contact for this task
---@return number # TID Task ID created
function AWACS:_CreateTaskForGroup(GroupID, Description, ScreenText, Object, TaskStatus, Auftrag, Cluster, Contact) end

---[Internal] Read registered Task for Group by its ID
---@param GroupID? number ManagedGroup ID
---@return AWACS.ManagedTask # Task or nil if n/e
function AWACS:_ReadAssignedTaskFromGID(GroupID) end

---[Internal] Read assigned Group from a TaskID
---@param TaskID? number ManagedTask ID
---@return AWACS.ManagedGroup # Group structure or nil if n/e
function AWACS:_ReadAssignedGroupFromTID(TaskID) end

---[Internal] Create radio entry to tell players that CAP is on station in Anchor
---@param GID? number Group ID
---@return AWACS # self
function AWACS:_MessageAIReadyForTasking(GID) end

---[Internal] Update Contact Tag
---@param CID? number Contact ID
---@param Text? string Text to be used
---@param TAC? boolean TAC Call done
---@param MELD? boolean MELD Call done
---@param TaskStatus? string Overwrite status with #AWACS.TaskStatus  Status
---@return AWACS # self
function AWACS:_UpdateContactEngagementTag(CID, Text, TAC, MELD, TaskStatus) end

---[Internal] Check available tasks and status
---@return AWACS # self
function AWACS:_CheckTaskQueue() end

---[Internal] Write stats to log
---@return AWACS # self
function AWACS:_LogStatistics() end

---[User] Add another AirWing for AI CAP Flights under management
---@param AirWing? AIRWING The AirWing to (also) obtain CAP flights from
---@param Zone? ZONE_RADIUS (optional) This AirWing has it's own station zone, AI CAP will be send there
---@return AWACS # self
function AWACS:AddCAPAirWing(AirWing, Zone) end

---[Internal] Announce a new contact
---@param Contact? AWACS.ManagedContact|number|string
---@param IsNew? boolean Is a new contact
---@param Group? GROUP Announce to Group if not nil
---@param IsBogeyDope? boolean If true, this is a bogey dope announcement
---@param Tag? string Tag name for this contact. Alpha, Brave, Charlie ...
---@param IsPopup? boolean This is a pop-up group
---@param ReportingName? string The NATO code reporting name for the contact, e.g. "Foxbat". "Bogey" if unknown.
---@param Tactical? boolean
---@return AWACS # self
function AWACS:_AnnounceContact(Contact, IsNew, Group, IsBogeyDope, Tag, IsPopup, ReportingName, Tactical) end

---[Internal] Check for alive OpsGroup from Mission OpsGroups table
---@param OpsGroups? table
---@return OPSGROUP # or nil
function AWACS:_GetAliveOpsGroupFromTable(OpsGroups) end

---[Internal] Clean up mission stack
---@return number # CAPMissions
---@return number # Alert5Missions
---@return number # InterceptMissions
function AWACS:_CleanUpAIMissionStack() end

function AWACS:_ConsistencyCheck() end

---[Internal] Check Enough AI CAP on Station
---@return AWACS # self
function AWACS:_CheckAICAPOnStation() end

---[Internal] Set ROE for AI CAP
---@param FlightGroup? FLIGHTGROUP
---@param Group? GROUP
---@return AWACS # self
function AWACS:_SetAIROE(FlightGroup, Group) end

---[Internal] TAC Range Call to Pilot
---@param GID? number GID
---@param Contact? AWACS.ManagedContact|number|string
---@return AWACS # self
function AWACS:_TACRangeCall(GID, Contact) end

---[Internal] Meld Range Call to Pilot
---@param GID? number GID
---@param Contact? AWACS.ManagedContact|number|string
---@return AWACS # self
function AWACS:_MeldRangeCall(GID, Contact) end

---[Internal] Threat Range Call to Pilot
---@param GID? any
---@param Contact? any
---@return AWACS # self
function AWACS:_ThreatRangeCall(GID, Contact) end

---[Internal] Merged Call to Pilot
---@param GID? number
---@return AWACS # self
function AWACS:_MergedCall(GID) end

---[Internal] Assign a Pilot to a target
---@param Pilots? table Table of #AWACS.ManagedGroup Pilot
---@param Targets? FIFO FiFo of #AWACS.ManagedContact Targets
---@return AWACS # self
function AWACS:_AssignPilotToTarget(Pilots, Targets) end

---[Internal] onbeforeStart
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onbeforeStart(From, Event, To) end

---[Internal] onafterStart
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterStart(From, Event, To) end

---Event functions
---@param From? any
---@param Event? any
---@param To? any
---@param Text? any
---@param Keywords? any
---@param Coord? any
function MarkerOps:OnAfterMarkAdded(From, Event, To, Text, Keywords, Coord) end

---@param From? any
---@param Event? any
---@param To? any
---@param Text? any
---@param Keywords? any
---@param Coord? any
function MarkerOps:OnAfterMarkChanged(From, Event, To, Text, Keywords, Coord) end

---@param From? any
---@param Event? any
---@param To? any
function MarkerOps:OnAfterMarkDeleted(From, Event, To) end

function AWACS:_CheckAwacsStatus() end

---[Internal] onafterStatus
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterStatus(From, Event, To) end

---[Internal] onafterStop
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterStop(From, Event, To) end

---[Internal] onafterAssignAnchor
---@param From? string
---@param Event? string
---@param To? string
---@param GID? number Group ID
---@param HasOwnStation? string
---@param StationName? any
---@return AWACS # self
function AWACS:onafterAssignAnchor(From, Event, To, GID, HasOwnStation, StationName) end

---[Internal] onafterCheckedOut
---@param From? string
---@param Event? string
---@param To? string
---@param GID? any
---@param AnchorStackNo? number
---@param Angels? number
---@return AWACS # self
function AWACS:onafterCheckedOut(From, Event, To, GID, AnchorStackNo, Angels) end

---[Internal] onafterAssignedAnchor
---@param From? string
---@param Event? string
---@param To? string
---@param GID? number Managed Group ID
---@param Anchor? AWACS.AnchorData|number|string
---@param AnchorStackNo? number
---@param AnchorAngels? any
---@return AWACS # self
function AWACS:onafterAssignedAnchor(From, Event, To, GID, Anchor, AnchorStackNo, AnchorAngels) end

---[Internal] onafterNewCluster
---@param From? string
---@param Event? string
---@param To? string
---@param Cluster? INTEL.Cluster|number|string
---@return AWACS # self
function AWACS:onafterNewCluster(From, Event, To, Cluster) end

---[Internal] onafterNewContact
---@param From? string
---@param Event? string
---@param To? string
---@param Contact? INTEL.Contact|number|string
---@return AWACS # self
function AWACS:onafterNewContact(From, Event, To, Contact) end

---[Internal] onafterLostContact
---@param From? string
---@param Event? string
---@param To? string
---@param Contact? INTEL.Contact|number|string
---@return AWACS # self
function AWACS:onafterLostContact(From, Event, To, Contact) end

---[Internal] onafterLostCluster
---@param From? string
---@param Event? string
---@param To? string
---@param Cluster? INTEL.Cluster|number|string
---@param Mission? AUFTRAG
---@return AWACS # self
function AWACS:onafterLostCluster(From, Event, To, Cluster, Mission) end

---[Internal] onafterCheckTacticalQueue
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterCheckTacticalQueue(From, Event, To) end

---[Internal] onafterCheckRadioQueue
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterCheckRadioQueue(From, Event, To) end

---[Internal] onafterEscortShiftChange
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterEscortShiftChange(From, Event, To) end

---[Internal] onafterAwacsShiftChange
---@param From? string
---@param Event? string
---@param To? string
---@return AWACS # self
function AWACS:onafterAwacsShiftChange(From, Event, To) end

---On after "FlightOnMission".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param FlightGroup? FLIGHTGROUP on mission.
---@param Mission? AUFTRAG The requested mission.
---@return AWACS # self
function AWACS:onafterFlightOnMission(From, Event, To, FlightGroup, Mission) end

---On after "ReAnchor".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param GID? number Group ID to check and re-anchor if possible
---@return AWACS # self
function AWACS:onafterReAnchor(From, Event, To, GID) end

---Triggers the FSM event "Start". Starts the AWACS. Initializes parameters and starts event handlers.
function AWACS:Start() end

---Triggers the FSM event "Start" after a delay. Starts the AWACS. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function AWACS:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the AWACS and all its event handlers.
---@param delay? number Delay in seconds.
function AWACS:__Stop(delay) end

---On After "CheckedIn" event. AI or Player checked in.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterCheckedIn(From, Event, To) end

---On After "CheckedOut" event. AI or Player checked out.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterCheckedOut(From, Event, To) end

---On After "AssignedAnchor" event. AI or Player has been assigned a CAP station.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterAssignedAnchor(From, Event, To) end

---On After "ReAnchor" event. AI or Player has been send back to station.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterReAnchor(From, Event, To) end

---On After "NewCluster" event. AWACS detected a cluster.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterNewCluster(From, Event, To) end

---On After "NewContact" event. AWACS detected a contact.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterNewContact(From, Event, To) end

---On After "LostCluster" event. AWACS lost a radar cluster.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterLostCluster(From, Event, To) end

---On After "LostContact" event. AWACS lost a radar contact.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterLostContact(From, Event, To) end

---On After "EscortShiftChange" event. AWACS escorts shift change.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterEscortShiftChange(From, Event, To) end

---On After "AwacsShiftChange" event. AWACS shift change.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterAwacsShiftChange(From, Event, To) end

---On After "Intercept" event. CAP send on intercept.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterIntercept(From, Event, To) end

---On After "InterceptSuccess" event. Intercept successful.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterInterceptSuccess(From, Event, To) end

---On After "InterceptFailure" event. Intercept failure.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AWACS:OnAfterInterceptFailure(From, Event, To) end

---On After "VIDSuccess" event. Intercept successful.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param GID? number Managed group ID (Player)
---@param Group? GROUP (Player) Group done the VID
---@param Contact? AWACS.ManagedContact|number|string The contact that was VID'd
function AWACS:OnAfterVIDSuccess(From, Event, To, GID, Group, Contact) end

---On After "VIDFailure" event. Intercept failure.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param GID? number Managed group ID (Player)
---@param Group? GROUP (Player) Group done the VID
---@param Contact? AWACS.ManagedContact|number|string The contact that was VID'd
function AWACS:OnAfterVIDFailure(From, Event, To, GID, Group, Contact) end
