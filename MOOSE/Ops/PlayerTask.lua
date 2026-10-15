---@meta

---@class SeadAttributes
---@field SAM number GROUP.Attribute.GROUND_SAM
---@field AAA number GROUP.Attribute.GROUND_AAA
---@field EWR number GROUP.Attribute.GROUND_EWR
SeadAttributes = {}

---@class PersistenceData
---@field ID number
---@field Name string
---@field Type string
---@field InitialTargets number
---@field Targetsleft number
---@field updated boolean
PersistenceData = {}

---@class TasksPersistable
TasksPersistable = {}

---@class Scores
Scores = {}

---@class Type
---@field A2A string Air-to-Air Controller
---@field A2G string Air-to-Ground Controller
---@field A2S string Air-to-Ship Controller
---@field A2GS string Air-to-Ground-and-Ship Controller
Type = {}

---@class PLAYERTASK.Condition
---@field func function Callback function to check for a condition. Should return a #boolean.
---@field arg table Optional arguments passed to the condition callback function.

---PLAYERTASK class.
---@class PLAYERTASK : FSM
---@field ClassName string Name of the class.
---@field verbose boolean Switch verbosity.
---@field lid string Class id string for output to DCS log file.
---@field PlayerTaskNr number (Globally unique) Number of the task.
---@field Type AUFTRAG.Type The type of the task
---@field Target TARGET The target for this Task
---@field Clients FIFO FiFo of Wrapper.Client#CLIENT planes executing this task
---@field Repeat boolean
---@field repeats number
---@field RepeatNo number
---@field TargetMarker MARKER
---@field SmokeColor number
---@field FlareColor number
---@field conditionSuccess table
---@field conditionFailure table
---@field TaskController PLAYERTASKCONTROLLER
---@field timestamp number
---@field lastsmoketime number
---@field coalition number
---@field Freetext string
---@field FreetextTTS string
---@field TaskSubType string
---@field NextTaskSuccess table
---@field NextTaskFailure table
---@field FinalState string
---@field TypeName string
---@field PreviousCount number
---@field CanSmoke boolean
---@field ShowThreatDetails boolean
---@field PersistMe boolean
PLAYERTASK = {
  ClassName          = "PLAYERTASK",
  verbose            =   false,
  lid                =   nil,
  PlayerTaskNr       =   nil,
  Type               =   nil,
  TTSType            =   nil,
  Target             =   nil,
  Clients            =   nil,
  Repeat             =   false,
  repeats            =   0,
  RepeatNo           =   1,
  TargetMarker       =   nil,
  SmokeColor         =   nil,
  FlareColor         =   nil,
  conditionSuccess   =   {},
  conditionFailure   =   {},
  TaskController     =   nil,
  timestamp          =   0,
  lastsmoketime      =   0,
  Freetext           =   nil,
  FreetextTTS        =   nil,
  TaskSubType        =   nil,
  NextTaskSuccess    =   {},
  NextTaskFailure    =   {},
  FinalState         =   "none",
  PreviousCount      =   0,
  CanSmoke           =   true,
  ShowThreatDetails  =   true,
  PersistMe          =   false,
  }

---PLAYERTASK class version.
PLAYERTASK.version = "0.1.31"

---Constructor
---@param Type? AUFTRAG.Type|number|string Type of this task
---@param Target? TARGET Target for this task
---@param Repeat? boolean (Optional) Repeat this task if true (default = false)
---@param Times? number (Optional) Repeat on failure this many times if Repeat is true (default = 1)
---@param TTSType? string (Optional) TTS friendly task type name. Defaultsto "close air support".
---@return PLAYERTASK # self
function PLAYERTASK:New(Type, Target, Repeat, Times, TTSType) end

---Constructor that automatically determines the task type based on the target.
---@param Target? TARGET Target for this task
---@param Repeat? boolean (Optional) Repeat this task if true (default = false)
---@param Times? number (Optional) Repeat on failure this many times if Repeat is true (default = 1)
---@param TTSType? string TTS friendly task type name
---@return PLAYERTASK # self
function PLAYERTASK:NewFromTarget(Target, Repeat, Times, TTSType) end

---[Internal] Determines AUFTRAG type based on the target characteristics.
---@param Target? TARGET Target for this task
---@return string # AUFTRAG.Type
function PLAYERTASK:_GetTaskTypeForTarget(Target) end

---[Internal] Check OpsZone capture success condition.
---@param OpsZone? OPSZONE The OpsZone target object.
---@param CaptureSquadGroupNamePrefix? string The prefix of the group name that needs to capture the zone.
---@param Coalition? number The coalition that needs to capture the zone.
---@param CheckClientInZone? boolean Check if any of the clients are in zone.
---@return PLAYERTASK # self
function PLAYERTASK:_CheckCaptureOpsZoneSuccess(OpsZone, CaptureSquadGroupNamePrefix, Coalition, CheckClientInZone) end

---[User] Override this function in order to implement custom logic if a player can join a task or not.
---@param Group? GROUP
---@param Client? CLIENT
---@return boolean # Outcome True if player can join the task, false if not
function PLAYERTASK:CanJoinTask(Group, Client) end

---[User] Set this task for persistance, if persistance is enabled on the PLAYERTASKCONTROLLER instance.
---@return PLAYERTASK # self
function PLAYERTASK:EnablePersistance() end

---[Internal] Add a PLAYERTASKCONTROLLER for this task
---@param Controller? PLAYERTASKCONTROLLER
---@return PLAYERTASK # self
function PLAYERTASK:_SetController(Controller) end

---[User] Set a coalition side for this task
---@param Coalition? number Coaltion side to add, e.g. coalition.side.BLUE
---@return PLAYERTASK # self
function PLAYERTASK:SetCoalition(Coalition) end

---[User] Get the coalition side for this task
---@return number # Coalition Coaltion side, e.g. coalition.side.BLUE, or nil if not set
function PLAYERTASK:GetCoalition() end

---[User] Get the Ops.Target#TARGET object for this task
---@return TARGET # Target
function PLAYERTASK:GetTarget() end

---[USER] Add a free text description to this task.
---@param Text? string
---@return PLAYERTASK # self
function PLAYERTASK:AddFreetext(Text) end

---[USER] Query if a task has free text description.
---@return PLAYERTASK # self
function PLAYERTASK:HasFreetext() end

---[USER] Query if a task has free text TTS description.
---@return PLAYERTASK # self
function PLAYERTASK:HasFreetextTTS() end

---[USER] Set a task sub type description to this task.
---@param Type? string
---@return PLAYERTASK # self
function PLAYERTASK:SetSubType(Type) end

---[USER] Set if a task can have a smoke marker.
---@param OnOff? boolean (Optional) If true (default) it can be smoke, false if not.
---@return PLAYERTASK # self
function PLAYERTASK:SetCanSmoke(OnOff) end

---[USER] Set if a task can show threat details.
---@param OnOff? boolean (Optional) If true (default) it can be shown, false if not.
---@return PLAYERTASK # self
function PLAYERTASK:SetShowThreatDetails(OnOff) end

---[USER] Get task sub type description from this task.
---@return string # Type or nil
function PLAYERTASK:GetSubType() end

---[USER] Get the free text description from this task.
---@return string # Text
function PLAYERTASK:GetFreetext() end

---[USER] Add a free text description for TTS to this task.
---@param TextTTS? string
---@return PLAYERTASK # self
function PLAYERTASK:AddFreetextTTS(TextTTS) end

---[USER] Get the free text TTS description from this task.
---@return string # Text
function PLAYERTASK:GetFreetextTTS() end

---[USER] Add a short free text description for the menu entry of this task.
---@param Text? string
---@return PLAYERTASK # self
function PLAYERTASK:SetMenuName(Text) end

---[USER] Adds task success condition for dead STATIC, SET_STATIC, SCENERY or SET_SCENERY target object.
---@return PLAYERTASK # self
function PLAYERTASK:AddStaticObjectSuccessCondition() end

---[USER] Adds task success condition for AUFTRAG.Type.CAPTUREZONE for OpsZone or OpsZone set target object.
---At least one of the task clients and one capture group need to be inside the zone in order for the capture to be successful.
---@param CaptureSquadGroupNamePrefix? SET_BASE The prefix of the group name that needs to capture the zone.
---@param Coalition? number The coalition that needs to capture the zone.
---@param CheckClientInZone? boolean If true, a CLIENT assigned to this task also needs to be in the zone for the task to be successful.
---@return PLAYERTASK # self
function PLAYERTASK:AddOpsZoneCaptureSuccessCondition(CaptureSquadGroupNamePrefix, Coalition, CheckClientInZone) end

---[USER] Adds task success condition for AUFTRAG.Type.RECON when a client is at a certain LOS distance from the target.
---@param MinDistance? number (Optional) Minimum distance in meters from client to target in LOS for success condition. (Default 5 NM)
---@return PLAYERTASK # self
function PLAYERTASK:AddReconSuccessCondition(MinDistance) end

---[USER] Adds a time limit for the task to be completed.
---@param TimeLimit? number (Optional) Time limit in seconds for the task to be completed. (Default 0 = no time limit)
---@return PLAYERTASK # self
function PLAYERTASK:AddTimeLimitFailureCondition(TimeLimit) end

---[USER] Add a task to be assigned to same clients when task was a success.
---@param Task? PLAYERTASK
---@return PLAYERTASK # self
function PLAYERTASK:AddNextTaskAfterSuccess(Task) end

---[USER] Add a task to be assigned to same clients when task was a failure.
---@param Task? PLAYERTASK
---@return PLAYERTASK # self
function PLAYERTASK:AddNextTaskAfterFailure(Task) end

---[User] Check if task is done
---@return boolean # done
function PLAYERTASK:IsDone() end

---[User] Check if task is NOT done
---@return boolean # done
function PLAYERTASK:IsNotDone() end

---[User] Check if PLAYERTASK has clients assigned to it.
---@return boolean # hasclients
function PLAYERTASK:HasClients() end

---[User] Get client names assigned as table of #strings
---@return table # clients
---@return number # clientcount
function PLAYERTASK:GetClients() end

---[User] Get #CLIENT objects assigned as table
---@return table # clients
---@return number # clientcount
function PLAYERTASK:GetClientObjects() end

---[User] Count clients
---@return number # clientcount
function PLAYERTASK:CountClients() end

---[User] Check if a player name is assigned to this task
---@param Name? string
---@return boolean # HasName
function PLAYERTASK:HasPlayerName(Name) end

---[User] Add a client to this task
---@param Client? CLIENT
---@return PLAYERTASK # self
function PLAYERTASK:AddClient(Client) end

---[User] Remove a client from this task
---@param Client? CLIENT
---@param Name? string Name of the client
---@return PLAYERTASK # self
function PLAYERTASK:RemoveClient(Client, Name) end

---[User] Client has aborted task this task
---@param Client? CLIENT (optional)
---@return PLAYERTASK # self
function PLAYERTASK:ClientAbort(Client) end

---[User] Create target mark on F10 map
---@param Text? string (optional) Text to show on the marker
---@param Coalition? number (optional) Coalition this marker is for. Default = All.
---@param ReadOnly? boolean (optional) Make target marker read-only. Default = false.
---@return PLAYERTASK # self
function PLAYERTASK:MarkTargetOnF10Map(Text, Coalition, ReadOnly) end

---[User] Smoke Target
---@param Color? number (Optional) Color, defaults to SMOKECOLOR.Red
---@return PLAYERTASK # self
function PLAYERTASK:SmokeTarget(Color) end

---[User] Flare Target
---@param Color? number (Optional) Color, defaults to FLARECOLOR.Red
---@return PLAYERTASK # self
function PLAYERTASK:FlareTarget(Color) end

---[User] Illuminate Target Area
---@param Power? number (Optional) Power of illumination bomb in Candela. Default 1000 cd.
---@param Height? number (Optional) Height above target used to release the bomb, default 150m.
---@return PLAYERTASK # self
function PLAYERTASK:IlluminateTarget(Power, Height) end

---[User] Add success condition.
---@param ConditionFunction? function If this function returns `true`, the mission is cancelled.
---@param ... any
---@return PLAYERTASK # self
function PLAYERTASK:AddConditionSuccess(ConditionFunction, ...) end

---[User] Add failure condition.
---@param ConditionFunction? function If this function returns `true`, the task is cancelled.
---@param ... any
---@return PLAYERTASK # self
function PLAYERTASK:AddConditionFailure(ConditionFunction, ...) end

---[Internal] Check if any of the given conditions is true.
---@param Conditions? table Table of conditions.
---@return boolean # If true, at least one condition is true.
function PLAYERTASK:_EvalConditionsAny(Conditions) end

---[Internal] On after status call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterStatus(From, Event, To) end

---[Internal] On after progress call
---@param From? string
---@param Event? string
---@param To? string
---@param TargetCount? number
---@return PLAYERTASK # self
function PLAYERTASK:onafterProgress(From, Event, To, TargetCount) end

---[Internal] On after planned call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterPlanned(From, Event, To) end

---[Internal] On after requested call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterRequested(From, Event, To) end

---[Internal] On after executing call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterExecuting(From, Event, To) end

---[Internal] On after status call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterStop(From, Event, To) end

---[Internal] On after client added call
---@param From? string
---@param Event? string
---@param To? string
---@param Client? CLIENT
---@return PLAYERTASK # self
function PLAYERTASK:onafterClientAdded(From, Event, To, Client) end

---[Internal] On after done call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterDone(From, Event, To) end

---[Internal] On after cancel call
---@param From? string
---@param Event? string
---@param To? string
---@param Silent? boolean
---@return PLAYERTASK # self
function PLAYERTASK:onafterCancel(From, Event, To, Silent) end

---[Internal] On after success call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterSuccess(From, Event, To) end

---[Internal] On after failed call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASK # self
function PLAYERTASK:onafterFailed(From, Event, To) end

---PLAYERTASKCONTROLLER class.
---@class PLAYERTASKCONTROLLER : FSM
---@field ClassName string Name of the class.
---@field verbose boolean Switch verbosity.
---@field lid string Class id string for output to DCS log file.
---@field TargetQueue FIFO
---@field TaskQueue FIFO
---@field TasksPerPlayer FIFO
---@field PrecisionTasks FIFO
---@field ClientSet SET_CLIENT
---@field ActiveClientSet SET_CLIENT
---@field ClientFilter string
---@field Name string
---@field Type string
---@field UseGroupNames boolean
---@field PlayerMenu table
---@field usecluster boolean
---@field ClusterRadius number
---@field MenuName string
---@field NoScreenOutput boolean
---@field TargetRadius number
---@field UseWhiteList boolean
---@field WhiteList table
---@field UseBlackList boolean
---@field BlackList table
---@field gettext TEXTANDSOUND
---@field locale string
---@field precisionbombing boolean
---@field LasingDrone FLIGHTGROUP
---@field MarkerOps MARKEROPS_BASE
---@field taskinfomenu boolean
---@field MarkerReadOnly boolean
---@field FlashPlayer table List of player who switched Flashing Direction Info on
---@field AllowFlash boolean Flashing directions for players allowed
---@field menuitemlimit number
---@field activehasinfomenu boolean
---@field holdmenutime number
---@field customcallsigns table
---@field ShortCallsign boolean
---@field Keepnumber boolean
---@field CallsignTranslations table
---@field PlayerFlashMenu table
---@field PlayerJoinMenu table
---@field PlayerInfoMenu table
---@field noflaresmokemenu boolean
---@field illumenu boolean
---@field TransmitOnlyWithPlayers boolean
---@field buddylasing boolean
---@field PlayerRecce PLAYERRECCE
---@field Coalition number
---@field MenuParent MENU_MISSION
---@field ShowMagnetic boolean Also show magnetic angles
---@field InfoHasCoordinate boolean
---@field InfoHasLLDDM boolean
---@field PlayerMenuTag table
---@field UseTypeNames boolean
---@field Scoring SCORING
---@field JoinTaskMenuTemplate CLIENTMENUMANAGER
---@field JoinMenu CLIENTMENU
---@field JoinTopMenu CLIENTMENU
---@field JoinInfoMenu CLIENTMENU
---@field ActiveTaskMenuTemplate CLIENTMENUMANAGER
---@field ActiveTopMenu CLIENTMENU
---@field ActiveInfoMenu CLIENTMENU
---@field MenuNoTask CLIENTMENU
---@field InformationMenu boolean Show Radio Info Menu
---@field TaskInfoDuration number How long to show the briefing info on the screen
---@field TaskPersistance table Table for persistance data
---@field TaskPersistanceSwitch boolean Switch for persisting tasks
---@field TaskPersistancePath string File path for persisting tasks
---@field TaskPersistanceFilename string File name for persisting tasks
---@field TasksPersistable table List of persistable tasks
---@field SceneryExplosivesAmount number Kgs of TNT to explode scenery on task persistance loading
PLAYERTASKCONTROLLER = {
  ClassName          = "PLAYERTASKCONTROLLER",
  verbose            =   false,
  lid                =   nil,
  TargetQueue        =   nil,
  ClientSet          =   nil,
  UseGroupNames      =   true,
  PlayerMenu         =   {},
  usecluster         =   false,
  MenuName           =   nil,
  ClusterRadius      =   0.5,
  NoScreenOutput     =   false,
  TargetRadius       =   500,
  UseWhiteList       =   false,
  WhiteList          =   {},
  gettext            =   nil,
  locale             =   "en",
  precisionbombing   =   false,
  taskinfomenu       =   false,
  activehasinfomenu  =   false,
  MarkerReadOnly     =   false,
  customcallsigns    =   {},
  ShortCallsign      =   true,
  Keepnumber         =   false,
  CallsignTranslations = nil,
  PlayerFlashMenu    =   {},
  PlayerJoinMenu     =   {},
  PlayerInfoMenu     =   {},
  PlayerMenuTag      =   {},
  noflaresmokemenu   =   false,
  illumenu           =   false,
  TransmitOnlyWithPlayers = true,
  buddylasing        = false,
  PlayerRecce        = nil,
  Coalition          = nil,
  MenuParent         = nil,
  ShowMagnetic       = true,
  InfoHasLLDDM       = false,
  InfoHasCoordinate  = false,
  UseTypeNames       = false,
  Scoring            = nil,
  MenuNoTask         = nil,
  InformationMenu    = false,
  TaskInfoDuration   = 30,
  TaskPersistance    = {},
  TaskPersistanceSwitch = false,
  TaskPersistancePath = nil,
  TaskPersistanceFilename = nil,
  TasksPersistable = {},
  SceneryExplosivesAmount = 300,
  }

PLAYERTASKCONTROLLER.Type = {
  A2A = "Air-To-Air",
  A2G = "Air-To-Ground",
  A2S = "Air-To-Sea",
  A2GS = "Air-To-Ground-Sea",
}

PLAYERTASKCONTROLLER.Scores = {
  [AUFTRAG.Type.PRECISIONBOMBING] = 100,
  [AUFTRAG.Type.CTLD] = 100,
  [AUFTRAG.Type.CSAR] = 100,
  [AUFTRAG.Type.INTERCEPT] = 100,
  [AUFTRAG.Type.ANTISHIP] = 100,
  [AUFTRAG.Type.CAS] = 100,
  [AUFTRAG.Type.BAI] = 100,
  [AUFTRAG.Type.SEAD] = 100,
  [AUFTRAG.Type.BOMBING] = 100,
  [AUFTRAG.Type.BOMBRUNWAY] = 100,
  [AUFTRAG.Type.CONQUER] = 100,
  [AUFTRAG.Type.RECON] = 100,
  [AUFTRAG.Type.ESCORT] = 100,
  [AUFTRAG.Type.CAP] = 100,
  [AUFTRAG.Type.CAPTUREZONE] = 100,
}

PLAYERTASKCONTROLLER.TasksPersistable = {
  [AUFTRAG.Type.PRECISIONBOMBING] = true,
  [AUFTRAG.Type.BOMBING] = true,
  [AUFTRAG.Type.ARTY] = true,
  [AUFTRAG.Type.SEAD] = true,
}

PLAYERTASKCONTROLLER.SeadAttributes = {
  SAM = GROUP.Attribute.GROUND_SAM,
  AAA = GROUP.Attribute.GROUND_AAA,
  EWR = GROUP.Attribute.GROUND_EWR,
}

PLAYERTASKCONTROLLER.Messages = {
  EN = {
    TASKABORT = "Task aborted!",
    NOACTIVETASK = "No active task!",
    FREQUENCIES = "frequencies ",
    FREQUENCY = "frequency %.3f",
    BROADCAST = "%s, %s, switch to %s for task assignment!",
    CASTTS = "close air support",
    SEADTTS = "suppress air defense",
    BOMBTTS = "bombing",
    PRECBOMBTTS = "precision bombing",
    BAITTS = "battle field air interdiction",
    ANTISHIPTTS = "anti-ship",
    INTERCEPTTS = "intercept",
    BOMBRUNWAYTTS = "bomb runway",
    HAVEACTIVETASK = "You already have one active task! Complete it first!",
    PILOTJOINEDTASK = "%s, %s. You have been assigned %s task %03d",
    TASKNAME = "%s Task ID %03d",
    TASKNAMETTS = "%s Task ID %03d",
    THREATHIGH = "high",
    THREATMEDIUM = "medium",
    THREATLOW = "low",
    THREATTEXT = "%s\nThreat: %s\nTargets left: %d\nCoord: %s",
    NOTHREATTEXT = "%s\nNo target information available.",
    ELEVATION = "\nTarget Elevation: %s %s",
    METER = "meter",
    FEET = "feet",
    THREATTEXTTTS = "%s, %s. Target information for %s. Threat level %s. Targets left %d. Target location %s.",
    NOTHREATTEXTTTS = "%s, %s. No target information available.",
    MARKTASK = "%s, %s, copy, task %03d location marked on map!",
    SMOKETASK = "%s, %s, copy, task %03d location smoked!",
    NOSMOKETASK = "%s, %s, negative, task %03d location cannot be smoked!",
    FLARETASK = "%s, %s, copy, task %03d location illuminated!",
    ABORTTASK = "All stations, %s, %s has aborted %s task %03d!",
    UNKNOWN = "Unknown",
    MENUTASKING = " Tasking ",
    MENUACTIVE = "Active Task",
    MENUINFO = "Info",
    MENUMARK = "Mark on map",
    MENUSMOKE = "Smoke",
    MENUFLARE = "Flare",
    MENUILLU = "Illuminate",
    MENUABORT = "Abort",
    MENUJOIN = "Join Task",
    MENUTASKINFO = "Task Info",
    MENUTASKNO = "TaskNo",
    MENUNOTASKS = "Currently no tasks available.",
    TASKCANCELLED = "Task #%03d %s is cancelled!",
    TASKCANCELLEDTTS = "%s, task %03d %s is cancelled!",
    TASKSUCCESS = "Task #%03d %s completed successfully!",
    TASKSUCCESSTTS = "%s, task %03d %s completed successfully!",
    TASKFAILED = "Task #%03d %s was a failure!",
    TASKFAILEDTTS = "%s, task %03d %s was a failure!",
    TASKFAILEDREPLAN = "Task #%03d %s available for reassignment!",
    TASKFAILEDREPLANTTS = "%s, task %03d %s vailable for reassignment!",
    TASKADDED = "%s has a new %s task available!",
    PILOTS = "\nPilot(s): ",
    PILOTSTTS = ". Pilot(s): ",
    YES = "Yes",
    NO = "No",
    NONE = "None",
    POINTEROVERTARGET = "%s, %s, pointer in reach for task %03d, lasing!",
    POINTERTARGETREPORT = "\nPointer in reach: %s\nLasing: %s",
    RECCETARGETREPORT = "\nRecce %s in reach: %s\nLasing: %s",
    POINTERTARGETLASINGTTS = ". Pointer in reach and lasing.",
    TARGET = "Target",
    FLASHON = "%s - Flashing directions is now ON!",
    FLASHOFF = "%s - Flashing directions is now OFF!",
    FLASHMENU = "Flash Directions Switch",
    BRIEFING = "Briefing",
    TARGETLOCATION ="Target location",
    COORDINATE = "Coordinate",
    INFANTRY = "Infantry",
    TECHNICAL = "Technical",
    ARTILLERY = "Artillery",
    TANKS = "Tanks",
    AIRDEFENSE = "Airdefense",
    SAM = "SAM",
    GROUP = "Group",
    UNARMEDSHIP = "Merchant",
    LIGHTARMEDSHIP = "Light Boat",
    CORVETTE = "Corvette",
    FRIGATE = "Frigate",
    CRUISER = "Cruiser",
    DESTROYER = "Destroyer",
    CARRIER = "Aircraft Carrier",
    RADIOS = "Radios",
    INTERCEPTCOURSE = "Intercept course",
  },
  DE = {
    TASKABORT = "Auftrag abgebrochen!",
    NOACTIVETASK = "Kein aktiver Auftrag!",
    FREQUENCIES = "Frequenzen ",
    FREQUENCY = "Frequenz %.3f",
    BROADCAST = "%s, %s, Radio %s für Aufgabenzuteilung!",
    CASTTS = "Nahbereichsunterstützung",
    SEADTTS = "Luftabwehr ausschalten",
    BOMBTTS = "Bombardieren",
    PRECBOMBTTS = "Präzisionsbombardieren",
    BAITTS = "Luftunterstützung",
    ANTISHIPTTS = "Anti-Schiff",
    INTERCEPTTS = "Abfangen",
    BOMBRUNWAYTTS = "Startbahn Bombardieren",
    HAVEACTIVETASK = "Du hast einen aktiven Auftrag! Beende ihn zuerst!",
    PILOTJOINEDTASK = "%s, %s hat Auftrag %s %03d angenommen",
    TASKNAME = "%s Auftrag ID %03d",
    TASKNAMETTS = "%s Auftrag ID %03d",
    THREATHIGH = "hoch",
    THREATMEDIUM = "mittel",
    THREATLOW = "niedrig",
    THREATTEXT = "%s\nGefahrstufe: %s\nZiele: %d\nKoord: %s",
    NOTHREATTEXT = "%s\nKeine Zielinformation verfügbar.",
    ELEVATION = "\nZiel Höhe: %s %s",
    METER = "Meter",
    FEET = "Fuss",
    THREATTEXTTTS = "%s, %s. Zielinformation zu %s. Gefahrstufe %s. Ziele %d. Zielposition %s.",
    NOTHREATTEXTTTS = "%s, %s. Keine Zielinformation verfügbar.",
    MARKTASK = "%s, %s, verstanden, Zielposition %03d auf der Karte markiert!",
    SMOKETASK = "%s, %s, verstanden, Zielposition %03d mit Rauch markiert!",
    NOSMOKETASK = "%s, %s, negativ, Zielposition %03d kann nicht markiert werden!",
    FLARETASK = "%s, %s, verstanden, Zielposition %03d beleuchtet!",
    ABORTTASK = "%s, an alle, %s hat Auftrag %s %03d abgebrochen!",
    UNKNOWN = "Unbekannt",
    MENUTASKING = " Aufträge ",
    MENUACTIVE = "Aktiver Auftrag",
    MENUINFO = "Information",
    MENUMARK = "Kartenmarkierung",
    MENUSMOKE = "Rauchgranate",
    MENUFLARE = "Leuchtgranate",
    MENUILLU = "Feldbeleuchtung",
    MENUABORT = "Abbrechen",
    MENUJOIN = "Auftrag annehmen",
    MENUTASKINFO = "Auftrag Briefing",
    MENUTASKNO = "AuftragsNr",
    MENUNOTASKS = "Momentan keine Aufträge verfügbar.",
    TASKCANCELLED = "Auftrag #%03d %s wurde beendet!",
    TASKCANCELLEDTTS = "%s, Auftrag %03d %s wurde beendet!",
    TASKSUCCESS = "Auftrag #%03d %s erfolgreich!",
    TASKSUCCESSTTS = "%s, Auftrag %03d %s erfolgreich!",
    TASKFAILED = "Auftrag #%03d %s gescheitert!",
    TASKFAILEDTTS = "%s, Auftrag %03d %s gescheitert!",
    TASKFAILEDREPLAN = "Auftrag #%03d %s gescheitert! Neuplanung!",
    TASKFAILEDREPLANTTS = "%s, Auftrag %03d %s gescheitert! Neuplanung!",
    TASKADDED = "%s hat einen neuen Auftrag %s erstellt!",
    PILOTS = "\nPilot(en): ",
    PILOTSTTS = ". Pilot(en): ",
    YES = "Ja",
    NO = "Nein",
    NONE = "Keine",
    POINTEROVERTARGET = "%s, %s, Marker im Zielbereich für %03d, Laser an!",
    POINTERTARGETREPORT = "\nMarker im Zielbereich: %s\nLaser an: %s",
    RECCETARGETREPORT = "\nSpäher % im Zielbereich: %s\nLasing: %s",
    POINTERTARGETLASINGTTS = ". Marker im Zielbereich, Laser is an.",
    TARGET = "Ziel",
    FLASHON = "%s - Richtungsangaben einblenden ist EIN!",
    FLASHOFF = "%s - Richtungsangaben einblenden ist AUS!",
    FLASHMENU = "Richtungsangaben Schalter",
    BRIEFING = "Briefing",
    TARGETLOCATION ="Zielposition",
    COORDINATE = "Koordinate",
    INFANTRY = "Infantrie",
    TECHNICAL = "Technische",
    ARTILLERY = "Artillerie",
    TANKS = "Panzer",
    AIRDEFENSE = "Flak",
    SAM = "Luftabwehr",
    GROUP = "Einheit",
    UNARMEDSHIP = "Handelsschiff",
    LIGHTARMEDSHIP = "Tender",
    CORVETTE = "Korvette",
    FRIGATE = "Fregatte",
    CRUISER = "Kreuzer",
    DESTROYER = "Zerstörer",
    CARRIER = "Flugzeugträger",
    RADIOS = "Frequenzen",
    INTERCEPTCOURSE = "Abfangkurs",
  },
}

---PLAYERTASK class version.
PLAYERTASKCONTROLLER.version = "0.1.73"

---Create and run a new TASKCONTROLLER instance.
---@param Name? string Name of this controller
---@param Coalition? number (Optional) Coalition of this controller. Defaults to coalition.side.BLUE
---@param Type? string (Optional) Type of the tasks controlled, defaults to PLAYERTASKCONTROLLER.Type.A2G
---@param ClientFilter? string (Optional) Additional prefix filter for the SET_CLIENT. Can be handed as @{Core.Set#SET_CLIENT} also.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:New(Name, Coalition, Type, ClientFilter) end

---[User] Enable Task persistance (for specific gound target tasks)
---@param Path? string Path where to save the task data
---@param Filename? string File name under which to save the task data
---@param KgsOfTNT? number (Optional) Explosives kgs used to remove scenery for persistence, defaults to 300
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:EnableTaskPersistance(Path, Filename, KgsOfTNT) end

---[User] Disable Task persistance (for specific gound target tasks)
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:DisableTaskPersistance() end

---[User] Set or create a SCORING object for this taskcontroller
---@param Scoring? SCORING (optional) the Scoring object
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:EnableScoring(Scoring) end

---[User] Remove the SCORING object from this taskcontroller
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:DisableScoring() end

---[Internal] Init localization
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_InitLocalization() end

---[User] Show target menu entries of type names for GROUND targets (off by default!), e.g. "Tank Group..."
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetEnableUseTypeNames() end

---[User] Do not show target menu entries of type names for GROUND targets
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetDisableUseTypeNames() end

---[User] Set flash directions option for player (player based info)
---@param OnOff? boolean (Optional) Set to `true` to switch on and `false` to switch off. Default is OFF.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetAllowFlashDirection(OnOff) end

---[User] Set to show a menu entry to retrieve the radio frequencies used.
---@param OnOff? boolean (Optional) Set to `true` to switch on and `false` to switch off. Default is OFF.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetShowRadioInfoMenu(OnOff) end

---[User] Do not show menu entries to smoke or flare targets
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetDisableSmokeFlareTask() end

---[User] For SRS - Switch to only transmit if there are players on the server.
---@param Switch? boolean If true, only send SRS if there are alive Players.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetTransmitOnlyWithPlayers(Switch) end

---[User] Show menu entries to smoke or flare targets (on by default!)
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetEnableSmokeFlareTask() end

---[User] Show menu entries to illuminate targets. Needs smoke/flare enabled.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetEnableIlluminateTask() end

---[User] Do not show menu entries to illuminate targets.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetDisableIlluminateTask() end

---[User] Show info text on screen with a coordinate info in any case (OFF by default)
---@param OnOff? boolean Switch on = true or off = false
---@param LLDDM? boolean Show LLDDM = true or LLDMS = false
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetInfoShowsCoordinate(OnOff, LLDDM) end

---[User] Set callsign options for TTS output. See {Wrapper.Group#GROUP.GetCustomCallSign}() on how to set customized callsigns.
---@param ShortCallsign? boolean If true, only call out the major flight number
---@param Keepnumber? boolean If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers.
---@param CallsignTranslations? table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@param CallsignCustomFunc? function (Optional) For player names only(!). If given, this function will return the callsign. Needs to take the groupname and the playername as first two arguments.
---@param ... any
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations, CallsignCustomFunc, ...) end

---[Internal] Get text for text-to-speech.
---Numbers are spaced out, e.g. "Heading 180" becomes "Heading 1 8 0 ".
---@param text? string Original text.
---@return string # Spoken text.
function PLAYERTASKCONTROLLER:_GetTextForSpeech(text) end

---[User] Set repetition options for tasks.
---@param OnOff? boolean (Optional) Set to `true` to switch on and `false` to switch off (defaults to true)
---@param Repeats? number (Optional) Number of repeats (defaults to 5)
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetTaskRepetition(OnOff, Repeats) end

---[User] Set how long the briefing is shown on screen.
---@param Seconds? number (Optional) Duration in seconds. Defaults to 30 seconds.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetBriefingDuration(Seconds) end

---[Internal] Send message to SET_CLIENT of players
---@param Text? string the text to be send
---@param Seconds? number (optional) Seconds to show, default 10
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_SendMessageToClients(Text, Seconds) end

---[User] Allow precision laser-guided bombing on statics and "high-value" ground units (MBT etc)
---@param FlightGroup? FLIGHTGROUP The FlightGroup (e.g. drone) to be used for lasing (one unit in one group only). Can optionally be handed as Ops.ArmyGroup#ARMYGROUP - **Note** might not find an LOS spot or get lost on the way. Cannot island-hop.
---@param LaserCode? number (Optional) The lasercode to be used. Defaults to 1688.
---@param HoldingPoint? COORDINATE (Optional) Point where the drone should initially circle. If not set, defaults to BullsEye of the coalition.
---@param Alt? number (Optional) Altitude in feet. Only applies if using a FLIGHTGROUP object! Defaults to 10000.
---@param Speed? number (Optional) Speed in knots. Only applies if using a FLIGHTGROUP object! Defaults to 120.
---@param MaxTravelDist? number (Optional) Max distance to travel to traget. Only applies if using a FLIGHTGROUP object! Defaults to 100 NM.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:EnablePrecisionBombing(FlightGroup, LaserCode, HoldingPoint, Alt, Speed, MaxTravelDist) end

---[User] Convenience function - add done or ground allowing precision laser-guided bombing on statics and "high-value" ground units (MBT etc)
---@param FlightGroup? FLIGHTGROUP The FlightGroup (e.g. drone) to be used for lasing (one unit in one group only). Can optionally be handed as Ops.ArmyGroup#ARMYGROUP - **Note** might not find an LOS spot or get lost on the way. Cannot island-hop.
---@param LaserCode? number (Optional) The lasercode to be used. Defaults to 1688.
---@param HoldingPoint? COORDINATE (Optional) Point where the drone should initially circle. If not set, defaults to BullsEye of the coalition.
---@param Alt? number (Optional) Altitude in feet. Only applies if using a FLIGHTGROUP object! Defaults to 10000.
---@param Speed? number (Optional) Speed in knots. Only applies if using a FLIGHTGROUP object! Defaults to 120.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddPrecisionBombingOpsGroup(FlightGroup, LaserCode, HoldingPoint, Alt, Speed) end

---[User] Allow precision laser-guided bombing on statics and "high-value" ground units (MBT etc) with player units lasing.
---@param Recce? PLAYERRECCE (Optional) The PLAYERRECCE object governing the lasing players.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:EnableBuddyLasing(Recce) end

---[User] Allow precision laser-guided bombing on statics and "high-value" ground units (MBT etc) with player units lasing.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:DisableBuddyLasing() end

---[User] Allow addition of targets with user F10 map markers.
---@param Tag? string (Optional) The tagname to use to identify commands, defaults to "TASK"
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:EnableMarkerOps(Tag) end

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

---[Internal] Get player name
---@param Client? CLIENT
---@return string # playername
---@return string # ttsplayername
function PLAYERTASKCONTROLLER:_GetPlayerName(Client) end

---[User] Disable precision laser-guided bombing on statics and "high-value" ground units (MBT etc)
---@param FlightGroup? any
---@param LaserCode? any
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:DisablePrecisionBombing(FlightGroup, LaserCode) end

---[User] Enable extra menu to show task detail information before joining
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:EnableTaskInfoMenu() end

---[User] Disable extra menu to show task detail information before joining
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:DisableTaskInfoMenu() end

---[User] Set menu build fine-tuning options
---@param InfoMenu? boolean If `true` this option will allow to show the Task Info-Menu also when a player has an active task. Since the menu isn't refreshed if a player holds an active task, the info in there might be stale.
---@param ItemLimit? number (Optional) Number of items per task type to show, default 5.
---@param HoldTime? number (Optional) Minimum number of seconds between menu refreshes (called every 30 secs) if a player has **no active task**.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetMenuOptions(InfoMenu, ItemLimit, HoldTime) end

---[User] Forbid F10 markers to be deleted by pilots. Note: Marker will auto-delete when the undelying task is done.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetMarkerReadOnly() end

---[User] Allow F10 markers to be deleted by pilots. Note: Marker will auto-delete when the undelying task is done.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetMarkerDeleteable() end

---[Internal] Event handling
---@param EventData? EVENTDATA
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_EventHandler(EventData) end

---[User] Set locale for localization. Defaults to "en"
---@param Locale? string The locale to use
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetLocale(Locale) end

---[User] Switch screen output.
---@param OnOff? boolean . Switch screen output off (true) or on (false)
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SuppressScreenOutput(OnOff) end

---[User] Set target radius. Determines the zone radius to distinguish CAS from BAI tasks and to find enemies if the TARGET object is a COORDINATE.
---@param Radius? number (Optional) Radius to use in meters. Defaults to 500 meters.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetTargetRadius(Radius) end

---[User] Set the cluster radius if you want to use target clusters rather than single group detection.
---Note that for a controller type A2A target clustering is on by default. Also remember that the diameter of the resulting zone is double the radius.
---@param Radius? number (Optional) Target cluster radius in kilometers. Default is 0.5km.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetClusterRadius(Radius) end

---[User] Manually cancel a specific task
---@param Task? PLAYERTASK The task to be cancelled.
---@param Silent? boolean If true suppress message output.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:CancelTask(Task, Silent) end

---[User] Switch usage of target names for menu entries on or off
---@param OnOff? boolean (Optional) If true, set to on (default), if nil or false, set to off
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SwitchUseGroupNames(OnOff) end

---[User] Switch showing additional magnetic angles
---@param OnOff? boolean (Optional) If true, set to on (default), if nil or false, set to off
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SwitchMagenticAngles(OnOff) end

---[Internal] Get task types for the menu
---@return table # TaskTypes
function PLAYERTASKCONTROLLER:_GetAvailableTaskTypes() end

---[Internal] Get task per type for the menu
---@return table # TasksPerTypes
function PLAYERTASKCONTROLLER:_GetTasksPerType() end

---[Internal] Check target queue
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_CheckTargetQueue() end

---[Internal] Check task queue
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_CheckTaskQueue() end

---[Internal] Check precision task queue
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_CheckPrecisionTasks() end

---[Internal] Check task queue for a specific player name
---@param PlayerName? any
---@return boolean # outcome
function PLAYERTASKCONTROLLER:_CheckPlayerHasTask(PlayerName) end

---[User] Add a target object to the target queue
---@param Target? POSITIONABLE The target GROUP, SET\_GROUP, UNIT, SET\_UNIT, STATIC, SET\_STATIC, AIRBASE, ZONE or COORDINATE.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddTarget(Target) end

---[Internal] Check for allowed task type, if there is a (positive) whitelist
---@param Type? string
---@return boolean # Outcome
function PLAYERTASKCONTROLLER:_CheckTaskTypeAllowed(Type) end

---[Internal] Check for allowed task type, if there is a (negative) blacklist
---@param Type? string
---@return boolean # Outcome
function PLAYERTASKCONTROLLER:_CheckTaskTypeDisallowed(Type) end

---[User] Set up a (positive) whitelist of allowed task types. Only these types will be generated.
---@param WhiteList? table Table of task types that can be generated. Use to restrict available types.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetTaskWhiteList(WhiteList) end

---[User] Set up a (negative) blacklist of forbidden task types. These types will **not** be generated.
---@param BlackList? table Table of task types that cannot be generated. Use to restrict available types.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetTaskBlackList(BlackList) end

---[User] Change the list of attributes, which are considered on GROUP or SET\_GROUP level of a target to create SEAD player tasks.
---@param Attributes? table Table of attribute types considered to lead to a SEAD type player task.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetSEADAttributes(Attributes) end

---[Internal] Function the check against SeadAttributes
---@param Attribute? string
---@return boolean # IsSead
function PLAYERTASKCONTROLLER:_IsAttributeSead(Attribute) end

---[Internal] Add a task to the task queue
---@param Target? TARGET
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_AddTask(Target) end

---[User] Add a PLAYERTASK object to the list of (open) tasks
---@param PlayerTask? PLAYERTASK
---@param Silent? boolean If true, make no "has new task" announcement
---@param TaskFilter? boolean If true, apply the white/black-list task filters here, also
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddPlayerTaskToQueue(PlayerTask, Silent, TaskFilter) end

---[User] Override this function in order to implement custom logic if a player can join a task or not.
---@param Task? PLAYERTASK
---@param Group? GROUP
---@param Client? CLIENT
---@return boolean # Outcome True if player can join the task, false if not
function PLAYERTASKCONTROLLER:CanJoinTask(Task, Group, Client) end

---[Internal] Join a player to a task
---@param Task? PLAYERTASK
---@param Force? boolean Assign task even if client already has one
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_JoinTask(Task, Force, Group, Client) end

---[Internal] Switch flashing info for a client
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_SwitchFlashing(Group, Client) end

---@param Group? any
---@param Client? any
function PLAYERTASKCONTROLLER:_ShowRadioInfo(Group, Client) end

---Calculate group future position after given seconds.
---@param group? GROUP The group to calculate for.
---@param seconds? number (Optional) Time interval in seconds. Default is `self.prediction`.
---@return COORDINATE # Calculated future position of the cluster.
function PLAYERTASKCONTROLLER:_CalcGroupFuturePosition(group, seconds) end

---[Internal] Flashing directional info for a client
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_FlashInfo() end

---[Internal] Find matching drone for precision bombing task, if any is assigned.
---@param ID? number Task ID to look for
---@return OPSGROUP # Drone
function PLAYERTASKCONTROLLER:_FindLasingDroneForTaskID(ID) end

---[Internal] Show active task info
---@param Task? PLAYERTASK
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_ActiveTaskInfo(Task, Group, Client) end

---[Internal] Mark task on F10 map
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_MarkTask(Group, Client) end

---[Internal] Smoke task location
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_SmokeTask(Group, Client) end

---[Internal] Flare task location
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_FlareTask(Group, Client) end

---[Internal] Illuminate task location
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_IlluminateTask(Group, Client) end

---[Internal] Abort Task
---@param Group? GROUP
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_AbortTask(Group, Client) end

---TODO - New Menu Manager
---[Internal] _UpdateJoinMenuTemplate
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_UpdateJoinMenuTemplate() end

---[Internal] _RemoveMenuEntriesForTask
---@param Task? PLAYERTASK
---@param Client? CLIENT
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_RemoveMenuEntriesForTask(Task, Client) end

---[Internal] _CreateJoinMenuTemplate
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_CreateJoinMenuTemplate() end

---[Internal] _CreateActiveTaskMenuTemplate
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_CreateActiveTaskMenuTemplate() end

---[Internal] _SwitchMenuForClient
---@param Client? CLIENT The client
---@param MenuType? string
---@param Delay? number
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:_SwitchMenuForClient(Client, MenuType, Delay) end

---[User] Add agent group to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param Recce? GROUP Group of agents. Can also be an @{Ops.OpsGroup#OPSGROUP} object.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddAgent(Recce) end

---[User] Add agent SET_GROUP to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param RecceSet? SET_GROUP SET_GROUP of agents.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddAgentSet(RecceSet) end

---[User] Set up detection of STATIC objects. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param OnOff? boolean Set to `true`for on and `false`for off.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SwitchDetectStatics(OnOff) end

---[User] Add an accept zone to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param AcceptZone? ZONE Add a zone to the accept zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddAcceptZone(AcceptZone) end

---[User] Add an accept SET_ZONE to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param AcceptZoneSet? SET_ZONE Add a SET_ZONE to the accept zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddAcceptZoneSet(AcceptZoneSet) end

---[User] Add a reject zone to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param RejectZone? ZONE Add a zone to the reject zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddRejectZone(RejectZone) end

---[User] Add a reject SET_ZONE to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param RejectZoneSet? SET_ZONE Add a zone to the reject zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddRejectZoneSet(RejectZoneSet) end

---[User] Add a conflict zone to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param ConflictZone? ZONE Add a zone to the conflict zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddConflictZone(ConflictZone) end

---[User] Add a conflict SET_ZONE to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param ConflictZoneSet? SET_ZONE Add a zone to the conflict zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddConflictZoneSet(ConflictZoneSet) end

---[User] Remove an accept zone from INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param AcceptZone? ZONE Remove this zone from the accept zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:RemoveAcceptZone(AcceptZone) end

---[User] Remove a reject zone from INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param RejectZone? ZONE Remove this zone from the reject zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:RemoveRejectZone(RejectZone) end

---[User] Remove a conflict zone from INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param ConflictZone? ZONE Remove this zone from the conflict zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:RemoveConflictZone(ConflictZone) end

---[User] Add an corridor zone to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param CorridorZone? ZONE Add a zone to the corridor zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddCorridorZone(CorridorZone) end

---[User] Add an corridor SET_ZONE to INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param CorridorZoneSet? SET_ZONE Add a SET_ZONE to the corridor zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:AddCorridorZoneSet(CorridorZoneSet) end

---[User] Remove an corridor zone from INTEL detection. You need to set up detection with {#PLAYERTASKCONTROLLER.SetupIntel}() **before** using this.
---@param CorridorZone? ZONE Remove this zone from the corridor zone set.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:RemoveCorridorZone(CorridorZone) end

---Function to set corridor zone floor and ceiling in FEET.
---@param Floor? number Floor altitude ASL in feet.
---@param Ceiling? number Ceiling altitude ASL in feet.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetCorridorZoneFloorAndCeiling(Floor, Ceiling) end

---Function to set corridor zone floor and ceiling in METERS.
---@param Floor? number Floor altitude ASL in meters.
---@param Ceiling? number Ceiling altitude ASL in meters.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetCorridorZoneFloorAndCeilingMeters(Floor, Ceiling) end

---[User] Set the top menu name to a custom string.
---@param Name? string The name to use as the top menu designation.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetMenuName(Name) end

---[User] Set the top menu to be a sub-menu of another MENU entry.
---@param Menu? MENU_MISSION
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetParentMenu(Menu) end

---[User] Set up INTEL detection
---@param RecceName? string This name will be used to build a detection group set. All groups with this string somewhere in their group name will be added as Recce.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetupIntel(RecceName) end

---[User] Set SRS TTS details - see {Sound.SRS} for details.`SetSRS()` will try to use as many attributes configured with {Sound.SRS#MSRS.LoadConfigFile}() as possible.
---@param Frequency? number (Optional) Frequency to be used. Can also be given as a table of multiple frequencies, e.g. 271 or {127,251}. There needs to be exactly the same number of modulations!
---@param Modulation? number (Optional) Modulation to be used. Can also be given as a table of multiple modulations, e.g. radio.modulation.AM or {radio.modulation.FM,radio.modulation.AM}. There needs to be exactly the same number of frequencies!
---@param PathToSRS? string (Optional) Defaults to "C:\\Program Files\\DCS-SimpleRadio-Standalone\\ExternalAudio"
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest)
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS; if you use a config file for MSRS, hand in nil here.
---@param AccessKey? string (Optional) Your Google API access key. This is necessary if DCS-gRPC is used as backend; if you use a config file for MSRS, you can hand in nil here.
---@param Coordinate? COORDINATE (Optional) Coordinate from which the controller radio is sending
---@param Backend? string (Optional) MSRS Backend to be used, can be MSRS.Backend.SRSEXE or MSRS.Backend.GRPC; if you use a config file for MSRS, you can hand in nil here.
---@param Provider? string (Optional) TTS Provider to be used.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetSRS(Frequency, Modulation, PathToSRS, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, AccessKey, Coordinate, Backend, Provider, Speaker) end

---[User] Set SRS Broadcast - for the announcement to joining players which SRS frequency, modulation to use. Use in case you want to set this differently to the standard SRS.
---@param Frequency? number Frequency to be used. Can also be given as a table of multiple frequencies, e.g. 271 or {127,251}.  There needs to be exactly the same number of modulations!
---@param Modulation? number Modulation to be used. Can also be given as a table of multiple modulations, e.g. radio.modulation.AM or {radio.modulation.FM,radio.modulation.AM}.  There needs to be exactly the same number of frequencies!
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:SetSRSBroadcast(Frequency, Modulation) end

---@param Task? PLASERTASK
---@param TargetsLeft? number
function PLAYERTASKCONTROLLER:_UpdateTargetsAlive(Task, TargetsLeft) end

function PLAYERTASKCONTROLLER:_LoadTasksPersisted() end

---[User] Clear persisted data on disk.
function PLAYERTASKCONTROLLER:ClearPersistedData() end

function PLAYERTASKCONTROLLER:_SaveTasksPersisted() end

---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:_AddPersistenceData(Task) end

---[Internal] On after start call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterStart(From, Event, To) end

---[Internal] On after Status call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterStatus(From, Event, To) end

---[Internal] On after task done
---@param From? string
---@param Event? string
---@param To? string
---@param Task? PLAYERTASK
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterTaskDone(From, Event, To, Task) end

---[Internal] On after task cancelled
---@param From? string
---@param Event? string
---@param To? string
---@param Task? PLAYERTASK
---@param Silent? boolean If true, suppress message output on cancel.
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterTaskCancelled(From, Event, To, Task, Silent) end

---[Internal] On after task success
---@param From? string
---@param Event? string
---@param To? string
---@param Task? PLAYERTASK
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterTaskSuccess(From, Event, To, Task) end

---[Internal] On after task failed
---@param From? string
---@param Event? string
---@param To? string
---@param Task? PLAYERTASK
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterTaskFailed(From, Event, To, Task) end

---[Internal] On after task failed, repeat planned
---@param From? string
---@param Event? string
---@param To? string
---@param Task? PLAYERTASK
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterTaskRepeatOnFailed(From, Event, To, Task) end

---[Internal] On after task added
---@param From? string
---@param Event? string
---@param To? string
---@param Task? PLAYERTASK
---@param Silent? boolean
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterTaskAdded(From, Event, To, Task, Silent) end

---[Internal] On after Stop call
---@param From? string
---@param Event? string
---@param To? string
---@return PLAYERTASKCONTROLLER # self
function PLAYERTASKCONTROLLER:onafterStop(From, Event, To) end

---On After "Planned" event. Task has been planned.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterPlanned(From, Event, To) end

---On After "Requested" event. Task has been Requested.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterRequested(From, Event, To) end

---On After "ClientAdded" event. Client has been added to the task.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Client? CLIENT
function PLAYERTASK:OnAfterClientAdded(From, Event, To, Client) end

---On After "ClientRemoved" event. Client has been removed from the task.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterClientRemoved(From, Event, To) end

---On After "Executing" event. Task is executed by the 1st client.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterExecuting(From, Event, To) end

---On After "Done" event. Task is done.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterDone(From, Event, To) end

---On After "Cancel" event. Task has been cancelled.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Silent? boolean If true, suppress message output on cancel.
function PLAYERTASK:OnAfterCancel(From, Event, To, Silent) end

---On After "Planned" event. Task has been planned.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterPilotPlanned(From, Event, To) end

---On After "Success" event. Task has been a success.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterSuccess(From, Event, To) end

---On After "ClientAborted" event. A client has aborted the task.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterClientAborted(From, Event, To) end

---On After "Failed" event. Task has been a failure.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLAYERTASK:OnAfterFailed(From, Event, To) end

---On After "TaskAdded" event. Task has been added.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskAdded(From, Event, To, Task) end

---On After "TaskDone" event. Task is done.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskDone(From, Event, To, Task) end

---On After "TaskCancelled" event. Task has been cancelled.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
---@param Silent? boolean If true suppress message output.
function PLAYERTASKCONTROLLER:OnAfterTaskCancelled(From, Event, To, Task, Silent) end

---On After "TaskFailed" event. Task has failed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskFailed(From, Event, To, Task) end

---On After "TaskSuccess" event. Task has been a success.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskSuccess(From, Event, To, Task) end

---On After "TaskProgress" event. Task target count has been reduced.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK The current Task.
---@param TargetCount? number Targets left over
function PLAYERTASKCONTROLLER:OnAfterTaskProgress(From, Event, To, Task, TargetCount) end

---On After "TaskRepeatOnFailed" event. Task has failed and will be repeated.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskRepeatOnFailed(From, Event, To, Task) end

---On After "TaskTargetSmoked" event. Task smoked.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskTargetSmoked(From, Event, To, Task) end

---On After "TaskTargetFlared" event. Task flared.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskTargetFlared(From, Event, To, Task) end

---On After "TaskTargetIlluminated" event. Task illuminated.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterTaskTargetIlluminated(From, Event, To, Task) end

---On After "PlayerJoinedTask" event. Player joined a task.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Group? GROUP The player group object
---@param Client? CLIENT The player client object
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterPlayerJoinedTask(From, Event, To, Group, Client, Task) end

---On After "PlayerAbortedTask" event. Player aborted a task.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Group? GROUP The player group object
---@param Client? CLIENT The player client object
---@param Task? PLAYERTASK
function PLAYERTASKCONTROLLER:OnAfterPlayerAbortedTask(From, Event, To, Group, Client, Task) end
