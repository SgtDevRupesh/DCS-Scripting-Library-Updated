---@meta

---@class CSAR.DownedPilot
---@field index number Pilot index.
---@field name string Name of the spawned group.
---@field side number Coalition.
---@field originalUnit string Name of the original unit.
---@field desc string Description.
---@field typename string Typename of Unit.
---@field frequency number Frequency of the NDB.
---@field player string Player name if applicable.
---@field group GROUP Spawned group object.
---@field timestamp number Timestamp for approach process.
---@field alive boolean Group is alive or dead/rescued.
---@field wetfeet boolean Group is spawned over (deep) water.
---@field BeaconName string Name of radio beacon - if any.

---**CSAR** class, extends Core.Base#BASE, Core.Fsm#FSM
---@class CSAR : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field coalition number Coalition side number, e.g. `coalition.side.RED`.
---@field allheligroupset SET_GROUP Set of CSAR heli groups.
---@field UserSetGroup SET_GROUP Set of CSAR heli groups as designed by the mission designer (if any set).
CSAR = {
  ClassName       = "CSAR",
  verbose         =     0,
  lid             =   "",
  coalition       = 1,
  coalitiontxt    = "blue",
  FreeVHFFrequencies = {},
  UsedVHFFrequencies = {},
  takenOff = {},
  csarUnits = {},  -- table of unit names
  downedPilots = {},
  landedStatus = {},
  addedTo = {},
  woundedGroups = {}, -- contains the new group of units
  inTransitGroups = {}, -- contain a table for each SAR with all units he has with the original names
  smokeMarkers = {}, -- tracks smoke markers for groups
  heliVisibleMessage = {}, -- tracks if the first message has been sent of the heli being visible
  heliCloseMessage = {}, -- tracks heli close message  ie heli < 500m distance
  max_units = 6, -- number of pilots that can be carried
  hoverStatus = {}, -- tracks status of a helis hover above a downed pilot
  pilotDisabled = {}, -- tracks what aircraft a pilot is disabled for
  pilotLives = {}, -- tracks how many lives a pilot has
  useprefix    = true,  -- Use the Prefixed defined below, Requires Unit have the Prefix defined below
  csarPrefix = {},
  template = nil,
  mash = {},
  smokecolor = 4,
  rescues = 0,
  rescuedpilots = 0,
  limitmaxdownedpilots = true,
  maxdownedpilots = 10,
  useFIFOLimitReplacement = false, -- If true, it will remove the oldest downed pilot when a new one is added, if the limit is reached.
  allheligroupset = nil,
  topmenuname = "CSAR",
  ADFRadioPwr = 1000,
  PilotWeight = 80,
  CreateRadioBeacons = true,
  UserSetGroup = nil,
  AllowIRStrobe = false,
  IRStrobeRuntime = 300,
  FARPRescueDistance = 500,
  EnableMenuSmokeMASH = true,
  locale = "en",
}

CSAR.Messages = {
  EN = {
    HEARYOULONG = "%s: %s. I hear you! Finally, that is music in my ears!\nI'll pop a smoke when you are %s away.\nLand or hover by the smoke.",
    HEARYOUSHORT = "%s: %s. I hear you! Finally, that is music in my ears!\nRequest a flare or smoke if you need.",
    WEARECRAMMED = "%s, %s. We\'re already crammed with %d guys! Sorry!",
    IAMINHELO = "%s: %s I\'m in! Get to the MASH ASAP! ",
    YOUARECLOSE = "%s: %s. You\'re close now! Land or hover at the smoke.",
    YOUARECLOSELONG = "%s: %s. You\'re close now! Land in a safe place, I will go there ",
    WAITMORE = "Wait till %s gets in. \nETA %d more seconds.",
    OPENTHEDOORIN = "Open the door to let me in!",
    HOVERABOVE = "Hovering above %s. \n\nHold hover for %d seconds to winch them up. \n\nIf the countdown stops you\'re too far away!",
    TOOHIGHWINCH = "Too high to winch %s \nReduce height and hover for 10 seconds!",
    OPENTHEDOOROUT = "Open the door to let me out!",
    TAKECLINIC = "%s: The %d pilot(s) have been taken to the\nmedical clinic. Good job!",
    KILOMETERS = " kilometer",
    NAUTMILES = " nautical miles",
    FIRINGFLARE = "%s - Firing signal flare at your %s o\'clock. Distance %s",
    NOPILOTSINRANGE = "No Pilots within %s",
    IRSTROBE = "%s - IR Strobe active at your %s o\'clock. Distance %s",
    POPPINGSMOKE = "%s - Popping smoke at your %s o\'clock. Distance %s",
    POPPINGSMOKEMASH = "%s - Popping smoke at the closest rescue point: %s",
    NORESCUEPOINTWITHIN = "No rescue point within %s",
    NOPILOTSONBOARD = "No Rescued Pilots onboard",
    MENUTOP = "CSAR",
    MENUACTIVE = "List Active CSAR",
    MENUCHECK = "Check Onboard",
    MENUFLARE = "Request Signal Flare",
    MENUSMOKE = "Request Smoke",
    MENUSTROBE = "Request IR Strobe",
    MENUMASH = "Smoke Closest MASH",
    BOARDED = "Onboard - RTB to FARP/Airfield or MASH: ",
    MAYDAY = "MAYDAY MAYDAY! %s is down. ",
    CONTACT = "Troops In Contact. %s requests CASEVAC. ",
    PICKUPZONE = "Pickup Zone at %s.",
    REQUESTSAR = "%s requests SAR at %s, beacon at %.2f KHz!",
    REQUESTSARBEACON = "%s requests SAR at %s, beacon at %.2f KHz!",
    KHZ = "kilo hertz",
    FILLAT = "at",
    FILLFOR = "for",
    },
  DE = {
    HEARYOULONG = "%s: %s. Ich höre Sie! Endlich, das ist Musik in meinen Ohren!\nIch zünde eine Rauchgranate, wenn Sie %s entfernt sind.\nLanden Sie oder hovern Sie beim Rauch.",
    HEARYOUSHORT = "%s: %s. Ich höre Sie! Endlich, das ist Musik in meinen Ohren!\nFordern Sie eine Leuchtrakete oder Rauch an, falls nötig.",
    IAMINHELO = "%s: %s Ich bin drin! Jetzt sofort zum Lazarett! ",
    YOUARECLOSE = "%s: %s. Sie sind jetzt nah dran! Landen Sie oder hovern Sie beim Rauch.",
    YOUARECLOSELONG = "%s: %s. Sie sind jetzt nah dran! Landen Sie an einem sicheren Ort, ich komme dorthin.",
    WAITMORE = "Warten Sie, bis %s eingestiegen ist. \nNoch %d Sekunden.",
    OPENTHEDOORIN = "Öffnen Sie die Tür, damit ich einsteigen kann!",
    HOVERABOVE = "Hovere über %s. \n\nPositon für %d Sekunden halten, um zu winschen. \n\nWenn der Countdown stoppt, sind Sie zu weit entfernt!",
    TOOHIGHWINCH = "Zu hoch, um %s zu winschen. \nHöhe reduzieren und %d Sekunden halten!",
    OPENTHEDOOROUT = "Öffnen Sie die Tür, damit ich aussteigen kann!",
    FIRINGFLARE = "%s - Feuere Signalrakete auf Ihrer %s-Uhr-Position ab. Entfernung %s",
    NOPILOTSINRANGE = "Keine Piloten in %s Reichweite",
    IRSTROBE = "%s - IR-Blinklicht aktiv auf Ihrer %s-Uhr-Position. Entfernung %s",
    POPPINGSMOKE = "%s - Zünde Rauchgranate auf Ihrer %s-Uhr-Position. Entfernung %s",
    POPPINGSMOKEMASH = "%s - Zünde Rauchgranate am nächsten Rettungspunkt: %s",
    NORESCUEPOINTWITHIN = "Kein Rettungspunkt innerhalb von %s",
    NOPILOTSONBOARD = "Keine geretteten Piloten an Bord",
    MENUTOP = "CSAR",
    MENUACTIVE = "Aktive CSAR",
    MENUCHECK = "Ladung prüfen",
    MENUFLARE = "Signalrakete anfordern",
    MENUSMOKE = "Rauch anfordern",
    MENUSTROBE = "IR-Blinklicht anfordern",
    MENUMASH = "Nächstes MASH markieren",
    WEARECRAMMED = "%s, %s. Wir sind bereits voll mit %d Mann! Tut mir leid!",
    TAKECLINIC = "%s: Die %d Pilot(en) wurden ins\nLazarett gebracht. Gute Arbeit!",
    KILOMETERS = " Kilometer",
    NAUTMILES = " Meilen",
    BOARDED = "An Bord - RTB zu FARP/Flugplatz oder Lazarett: ",
    MAYDAY = "MAYDAY MAYDAY! %s ist abgestürzt. ",
    CONTACT = "Truppen im Kontakt. %s fordern CASEVAC an. ",
    PICKUPZONE = "Aufnahmezone bei %s.",
    REQUESTSAR = "%s fordert SAR bei %s an, ADF %.2f KHz!",
    REQUESTSARBEACON = "%s fordert SAR bei %s an, ADF %.2f KHz!",
    KHZ = "Kilohertz",
    FILLAT = "bei",
    FILLFOR = "für",
  },
  FR = {
    HEARYOULONG = "%s: %s. Je vous entends! Enfin, c'est de la musique dans mes oreilles!\nJe lancerai une fumée quand vous serez à %s.\nAtterrissez ou survolez la fumée.",
    HEARYOUSHORT = "%s: %s. Je vous entends! Enfin, c'est de la musique dans mes oreilles!\nDemandez une fusée éclairante ou de la fumée si nécessaire.",
    IAMINHELO = "%s: %s Je suis à bord! Direction le MASH immédiatement! ",
    YOUARECLOSE = "%s: %s. Vous êtes proche maintenant! Atterrissez ou survolez la fumée.",
    YOUARECLOSELONG = "%s: %s. Vous êtes proche maintenant! Atterrissez dans un endroit sûr, j'y vais.",
    WAITMORE = "Attendez que %s monte à bord. \nEncore %d secondes.",
    OPENTHEDOORIN = "Ouvrez la porte pour me laisser entrer!",
    HOVERABOVE = "En vol stationnaire au-dessus de %s. \n\nMaintenir la position pendant %d secondes pour hélitreuiller. \n\nSi le compte à rebours s'arrête, vous êtes trop loin!",
    TOOHIGHWINCH = "Trop haut pour hélitreuiller %s. \nRéduisez l'altitude et maintenez la position pendant %d secondes!",
    OPENTHEDOOROUT = "Ouvrez la porte pour me laisser sortir!",
    FIRINGFLARE = "%s - Tir d'une fusée éclairante à vos %s heures. Distance %s",
    NOPILOTSINRANGE = "Aucun pilote dans un rayon de %s",
    IRSTROBE = "%s - Stroboscope IR actif à vos %s heures. Distance %s",
    POPPINGSMOKE = "%s -  Lancement de fumigène à vos %s heures. Distance %s",
    POPPINGSMOKEMASH = "%s - Lancement de fumigène au point de sauvetage le plus proche: %s",
    NORESCUEPOINTWITHIN = "Aucun point de sauvetage dans un rayon de %s",
    NOPILOTSONBOARD = "Aucun pilote secouru à bord",
    MENUTOP = "CSAR",
    MENUACTIVE = "Lister les CSAR actifs",
    MENUCHECK = "Vérifier qui est à bord",
    MENUFLARE = "Demander une fusée éclairante",
    MENUSMOKE = "Demander un fumigène",
    MENUSTROBE = "Demander un stroboscope IR",
    MENUMASH = "Fumée au MASH le plus proche",
    WEARECRAMMED = "%s, %s. Nous sommes déjà pleins avec %d hommes! Désolé!",
    TAKECLINIC = "%s: Les %d pilote(s) ont été transportés à \n l'hôpital. Bon travail!",
    KILOMETERS = " kilomètres",
    NAUTMILES = " milles nautiques",
    BOARDED = "À bord - RTB vers FARP/Aérodrome ou MASH: ",
    MAYDAY = "MAYDAY MAYDAY ! %s est à terre. ",
    CONTACT = "Troupes au contact. %s demande un CASEVAC. ",
    PICKUPZONE = "Zone de ramassage à %s.",
    REQUESTSAR = "%s demande un SAR à %s, balise à %.2f KHz!",
    REQUESTSARBEACON = "%s demande un SAR à %s, balise à %.2f KHz!",
    KHZ = "kilohertz",
    FILLAT = "au",
    FILLFOR = "pour",
  },
}

---All slot / Limit settings
---@class CSAR.AircraftType
---@field typename string Unit type name.
CSAR.AircraftType = {} -- Type and limit

---CSAR class version.
CSAR.version = "1.1.39"

---Create a new CSAR object and start the FSM.
---@param Coalition? number Coalition side. Can also be passed as a string "red", "blue" or "neutral".
---@param Template? string Name of the late activated infantry unit standing in for the downed pilot.
---@param Alias? string An *optional* alias how this object is called in the logs etc.
---@return CSAR # self
function CSAR:New(Coalition, Template, Alias) end

---[Internal] Init localization
---@return CSAR # self
function CSAR:_InitLocalization() end

---(Internal) Function to insert downed pilot tracker object.
---@param Group? GROUP The #GROUP object
---@param Groupname? string Name of the spawned group.
---@param Side? number Coalition.
---@param OriginalUnit? string Name of original Unit.
---@param Description? string Descriptive text.
---@param Typename? string Typename of unit.
---@param Frequency? number Frequency of the NDB in Hz
---@param Playername? string Name of Player (if applicable)
---@param Wetfeet? boolean Ejected over water
---@param BeaconName? any
---@return CSAR # self.
function CSAR:_CreateDownedPilotTrack(Group, Groupname, Side, OriginalUnit, Description, Typename, Frequency, Playername, Wetfeet, BeaconName) end

---(Internal) Count pilots on board.
---@param _heliName? string
---@return number # count
function CSAR:_PilotsOnboard(_heliName) end

---(Internal) Function to check for dupe eject events.
---@param _unitname? string Name of unit.
---@return boolean # Outcome
function CSAR:_DoubleEjection(_unitname) end

---(User) Add a PLAYERTASK - FSM events will check success
---@param PlayerTask? PLAYERTASK
---@return CSAR # self
function CSAR:AddPlayerTask(PlayerTask) end

---(Internal) Spawn a downed pilot
---@param country? number Country for template.
---@param point? COORDINATE Coordinate to spawn at.
---@param frequency? number Frequency of the pilot's beacon
---@param wetfeet? boolean Spawn is over water
---@return GROUP # group The #GROUP object.
---@return string # alias The alias name.
function CSAR:_SpawnPilotInField(country, point, frequency, wetfeet) end

---(Internal) Add options to a downed pilot
---@param group? GROUP Group to use.
function CSAR:_AddSpecialOptions(group) end

---(Internal) Function to spawn a CSAR object into the scene.
---@param _coalition? number Coalition
---@param _country? country.id|number|string Country ID
---@param _point? COORDINATE Coordinate
---@param _typeName? string Typename
---@param _unitName? string Unitname
---@param _playerName? string Playername
---@param _freq? number Frequency
---@param noMessage? boolean
---@param _description? string Description
---@param forcedesc? boolean Use the description only for the pilot track entry
---@return GROUP # PilotInField Pilot GROUP object
---@return string # AliasName Alias display name
function CSAR:_AddCsar(_coalition, _country, _point, _typeName, _unitName, _playerName, _freq, noMessage, _description, forcedesc) end

---(Internal) Function to add a CSAR object into the scene at a zone coordinate. For mission designers wanting to add e.g. PoWs to the scene.
---@param _zone? string Name of the zone. Can also be passed as a (normal, round) ZONE object.
---@param _coalition? number Coalition.
---@param _description? string (optional) Description.
---@param _randomPoint? boolean (optional) Random yes or no.
---@param _nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param unitname? string (optional) Name of the lost unit.
---@param typename? string (optional) Type of plane.
---@param forcedesc? boolean (optional) Force to use the description passed only for the pilot track entry. Use to have fully custom names.
function CSAR:_SpawnCsarAtZone(_zone, _coalition, _description, _randomPoint, _nomessage, unitname, typename, forcedesc) end

---Function to add a CSAR object into the scene at a zone coordinate. For mission designers wanting to add e.g. PoWs to the scene.
---@param Zone? string Name of the zone. Can also be passed as a (normal, round) ZONE object.
---@param Coalition? number Coalition.
---@param Description? string (optional) Description.
---@param RandomPoint? boolean (optional) Random yes or no.
---@param Nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param Unitname? string (optional) Name of the lost unit.
---@param Typename? string (optional) Type of plane.
---@param Forcedesc? boolean (optional) Force to use the **description passed only** for the pilot track entry. Use to have fully custom names.
function CSAR:SpawnCSARAtZone(Zone, Coalition, Description, RandomPoint, Nomessage, Unitname, Typename, Forcedesc) end

---(Internal) Function to add a CSAR object into the scene at a Point coordinate (VEC_2). For mission designers wanting to add e.g. casualties to the scene, that don't use beacons.
---@param _Point? COORDINATE
---@param _coalition? number Coalition.
---@param _description? string (optional) Description.
---@param _nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param unitname? string (optional) Name of the lost unit.
---@param typename? string (optional) Type of plane.
---@param forcedesc? boolean (optional) Force to use the description passed only for the pilot track entry. Use to have fully custom names.
function CSAR:_SpawnCASEVAC(_Point, _coalition, _description, _nomessage, unitname, typename, forcedesc) end

---Function to add a CSAR object into the scene at a zone coordinate. For mission designers wanting to add e.g. PoWs to the scene.
---@param Point? COORDINATE
---@param Coalition? number Coalition.
---@param Description? string (optional) Description.
---@param Nomessage? boolean (optional) If true, don\'t send a message to SAR.
---@param Unitname? string (optional) Name of the lost unit.
---@param Typename? string (optional) Type of plane.
---@param Forcedesc? boolean (optional) Force to use the **description passed only** for the pilot track entry. Use to have fully custom names.
function CSAR:SpawnCASEVAC(Point, Coalition, Description, Nomessage, Unitname, Typename, Forcedesc) end

---(Internal) Event handler.
---@param EventData? any
function CSAR:_EventHandler(EventData) end

---(Internal)  Initialize the action for a pilot.
---@param _downedGroup? GROUP The group to rescue.
---@param _GroupName? string Name of the Group
---@param _freq? number Beacon frequency.
---@param _nomessage? boolean Send message true or false.
---@param _playername? string Name of the downed pilot if any
function CSAR:_InitSARForPilot(_downedGroup, _GroupName, _freq, _nomessage, _playername) end

---(Internal) Check if a name is in downed pilot table
---@param name? string Name to search for.
---@return boolean # Outcome.
---@return CSAR.DownedPilot # Table if found else nil.
function CSAR:_CheckNameInDownedPilots(name) end

---(Internal) Check if a name is in downed pilot table and remove it.
---@param name? string Name to search for.
---@param force? boolean Force removal.
---@return boolean # Outcome.
function CSAR:_RemoveNameFromDownedPilots(name, force) end

---[User] Set callsign options for TTS output. See {Wrapper.Group#GROUP.GetCustomCallSign}() on how to set customized callsigns.
---@param ShortCallsign? boolean If true, only call out the major flight number
---@param Keepnumber? boolean If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers.
---@param CallsignTranslations? table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@return CSAR # self
function CSAR:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations) end

---(Internal) Check if a name is in downed pilot table and remove it.
---@param UnitName? string
---@return string # CallSign
function CSAR:_GetCustomCallSign(UnitName) end

---(Internal) Check state of wounded group.
---@param heliname? string heliname
---@param woundedgroupname? string woundedgroupname
function CSAR:_CheckWoundedGroupStatus(heliname, woundedgroupname) end

---(Internal) Function to pop a smoke at a wounded pilot\'s positions.
---@param _woundedGroupName? string Name of the group.
---@param _woundedLeader? GROUP Object of the group.
function CSAR:_PopSmokeForGroup(_woundedGroupName, _woundedLeader) end

---(Internal) Function to pickup the wounded pilot from the ground.
---@param _heliUnit? UNIT Object of the group.
---@param _pilotName? string Name of the pilot.
---@param _woundedGroup? GROUP Object of the group.
---@param _woundedGroupName? string Name of the group.
function CSAR:_PickupUnit(_heliUnit, _pilotName, _woundedGroup, _woundedGroupName) end

---(Internal) Function to calculate and set Unit internal cargo mass
---@param _heliName? string Unit name
---@return CSAR # self
function CSAR:_UpdateUnitCargoMass(_heliName) end

---(Internal) Move group to destination.
---@param _leader? GROUP
---@param _destination? COORDINATE
function CSAR:_OrderGroupToMoveToPoint(_leader, _destination) end

---(internal) Function to check if the heli door(s) are open. Thanks to Shadowze.
---@param unit_name? string Name of unit.
---@return boolean # outcome The outcome.
function CSAR:_IsLoadingDoorOpen(unit_name) end

---(Internal) Function to check if heli is close to group.
---@param _distance? number
---@param _heliUnit? UNIT
---@param _heliName? string
---@param _woundedGroup? GROUP
---@param _woundedGroupName? string
---@return boolean # Outcome
function CSAR:_CheckCloseWoundedGroup(_distance, _heliUnit, _heliName, _woundedGroup, _woundedGroupName) end

---(Internal) Monitor in-flight returning groups.
---@param heliname? string Heli name
---@param groupname? string Group name
---@param isairport? boolean If true, EVENT.Landing took place at an airport or FARP
---@param noreschedule? boolean If true, do not try to reschedule this if distances are not ok (coming from landing event)
---@param IsHeloBase? boolean If true, landing took place at a Helo Base  (name "H ..." on current maps)
function CSAR:_ScheduledSARFlight(heliname, groupname, isairport, noreschedule, IsHeloBase) end

---(Internal) Mark pilot as rescued and remove from tables.
---@param _heliUnit? UNIT
function CSAR:_RescuePilots(_heliUnit) end

---(Internal) Check and return Wrappe.Unit#UNIT based on the name if alive.
---@param _unitName? any
---@return UNIT # The unit or nil
function CSAR:_GetSARHeli(_unitName) end

---(Internal) Display message to single Unit.
---@param _unit? UNIT Unit #UNIT to display to.
---@param _text? string Text of message.
---@param _time? number Message show duration.
---@param _clear? boolean (optional) Clear screen.
---@param _speak? boolean (optional) Speak message via SRS.
---@param _override? boolean (optional) Override message suppression
function CSAR:_DisplayMessageToSAR(_unit, _text, _time, _clear, _speak, _override) end

---(Internal) Function to get string of a group\'s position.
---@param _woundedGroup? CONTROLLABLE Group or Unit object.
---@param _Unit? UNIT Requesting helo pilot unit
---@return string # Coordinates as Text
function CSAR:_GetPositionOfWounded(_woundedGroup, _Unit) end

---(Internal) Display active SAR tasks to player.
---@param _unitName? string Unit to display to
function CSAR:_DisplayActiveSAR(_unitName) end

---(Internal) Find the closest downed pilot to a heli.
---@param _heli? UNIT Helicopter #UNIT
---@return table # Table of results
function CSAR:_GetClosestDownedPilot(_heli) end

---(Internal) Fire a flare at the point of a downed pilot.
---@param _unitName? string Name of the unit.
function CSAR:_SignalFlare(_unitName) end

---(Internal) Display info to all SAR groups.
---@param _message? string Message to display.
---@param _side? number Coalition of message.
---@param _messagetime? number How long to show.
---@param ToSRS? boolean If true or nil, send to SRS TTS
---@param ToScreen? boolean If true or nil, send to Screen
function CSAR:_DisplayToAllSAR(_message, _side, _messagetime, ToSRS, ToScreen) end

---(Internal) Request IR Strobe at closest downed pilot.
---@param _unitName? string Name of the helicopter
function CSAR:_ReqIRStrobe(_unitName) end

---(Internal) Request smoke at closest downed pilot.
---@param _unitName? string Name of the helicopter
function CSAR:_Reqsmoke(_unitName) end

---(Internal) Request smoke at closest MASH/AFB.
---@param _unitName? string Name of the helicopter
function CSAR:_ReqsmokeMash(_unitName) end

---(Internal) Determine distance to closest MASH.
---@param _heli? UNIT Helicopter #UNIT
---@return number # Distance in meters
---@return string # MASH Name as string
---@return COORDINATE # Coordinate The MASH/AFB Coordinate (for smoke)
function CSAR:_GetClosestMASH(_heli) end

---(Internal) Display onboarded rescued pilots.
---@param _unitName? string Name of the chopper
function CSAR:_CheckOnboard(_unitName) end

---(Internal) Populate F10 menu for CSAR players.
function CSAR:_AddMedevacMenuItem() end

---(Internal) Return distance in meters between two coordinates.
---@param _point1? COORDINATE Coordinate one
---@param _point2? COORDINATE Coordinate two
---@return number # Distance in meters
function CSAR:_GetDistance(_point1, _point2) end

---(Internal) Populate table with available beacon frequencies.
function CSAR:_GenerateVHFrequencies() end

---(Internal) Pop frequency from prepopulated table.
---@return number # frequency
function CSAR:_GenerateADFFrequency() end

---(Internal) Function to determine clockwise direction for flares.
---@param _heli? UNIT The Helicopter
---@param _group? GROUP The downed Group
---@return number # direction
function CSAR:_GetClockDirection(_heli, _group) end

---(Internal) Function to add beacon to downed pilot.
---@param _group? GROUP Group #GROUP object.
---@param _freq? number Frequency to use
---@param BeaconName? string Beacon Name to use
---@return CSAR # self
function CSAR:_AddBeaconToGroup(_group, _freq, BeaconName) end

---(Internal) Helper function to (re-)add beacon to downed pilot.
---@return CSAR # self
function CSAR:_RefreshRadioBeacons() end

---(Internal) Helper function to count active downed pilots.
---@return number # Number of pilots in the field.
function CSAR:_CountActiveDownedPilots() end

---(Internal) Helper to decide if we're over max limit.
---@return boolean # True or false.
function CSAR:_ReachedPilotLimit() end

---User - Function to add onw SET_GROUP Set-up for pilot filtering and assignment.
---Needs to be set before starting the CSAR instance.
---@param Set? SET_GROUP The SET_GROUP object created by the mission designer/user to represent the CSAR pilot groups.
---@return CSAR # self
function CSAR:SetOwnSetPilotGroups(Set) end

---(Internal) Function called after Start() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
function CSAR:onafterStart(From, Event, To) end

---(Internal) Function called before Status() event.
function CSAR:_CheckDownedPilotTable() end

---(Internal) Function called before Status() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
function CSAR:onbeforeStatus(From, Event, To) end

---(Internal) Function called after Status() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
function CSAR:onafterStatus(From, Event, To) end

---(Internal) Function called after Stop() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
function CSAR:onafterStop(From, Event, To) end

---(Internal) Function called before Approach() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
---@param Heliname? string Name of the helicopter group.
---@param Woundedgroupname? string Name of the downed pilot\'s group.
function CSAR:onbeforeApproach(From, Event, To, Heliname, Woundedgroupname) end

---(Internal) Function called before Boarded() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
---@param Heliname? string Name of the helicopter group.
---@param Woundedgroupname? string Name of the downed pilot\'s group.
function CSAR:onbeforeBoarded(From, Event, To, Heliname, Woundedgroupname) end

---(Internal) Function called before Returning() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
---@param Heliname? string Name of the helicopter group.
---@param Woundedgroupname? string Name of the downed pilot\'s group.
---@param IsAirPort? any
function CSAR:onbeforeReturning(From, Event, To, Heliname, Woundedgroupname, IsAirPort) end

---(Internal) Function called before Rescued() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
---@param HeliUnit? UNIT Unit of the helicopter.
---@param HeliName? string Name of the helicopter group.
---@param PilotsSaved? number Number of the saved pilots on board when landing.
function CSAR:onbeforeRescued(From, Event, To, HeliUnit, HeliName, PilotsSaved) end

---(Internal) Function called before PilotDown() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
---@param Group? GROUP Group object of the downed pilot.
---@param Frequency? number Beacon frequency in kHz.
---@param Leadername? string Name of the #UNIT of the downed pilot.
---@param CoordinatesText? string String of the position of the pilot. Format determined by self.coordtype.
---@param Playername? string Player name if any given. Might be nil!
function CSAR:onbeforePilotDown(From, Event, To, Group, Frequency, Leadername, CoordinatesText, Playername) end

---(Internal) Function called before Landed() event.
---@param From? string From state.
---@param Event? string Event triggered.
---@param To? string To state.
---@param HeliName? string Name of the #UNIT which has landed.
---@param Airbase? AIRBASE Airbase where the heli landed.
function CSAR:onbeforeLanded(From, Event, To, HeliName, Airbase) end

---On before "Save" event. Checks if io and lfs are available.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving. Default is "CSAR_<alias>_Persist.csv".
function CSAR:onbeforeSave(From, Event, To, path, filename) end

---On after "Save" event. Player data is saved to file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is saved. If nil, file is saved in the DCS root installtion directory or your "Saved Games" folder if lfs was desanitized.
---@param filename? string (Optional) File name for saving. Default is Default is "CSAR_<alias>_Persist.csv".
function CSAR:onafterSave(From, Event, To, path, filename) end

---On before "Load" event. Checks if io and lfs and the file are available.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CSAR_<alias>_Persist.csv".
function CSAR:onbeforeLoad(From, Event, To, path, filename) end

---On after "Load" event. Loads dropped units from file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CSAR_<alias>_Persist.csv".
function CSAR:onafterLoad(From, Event, To, path, filename) end

---Triggers the FSM event "Start". Starts the CSAR. Initializes parameters and starts event handlers.
function CSAR:Start() end

---Triggers the FSM event "Start" after a delay. Starts the CSAR. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function CSAR:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the CSAR and all its event handlers.
---@param delay? number Delay in seconds.
function CSAR:__Stop(delay) end

---Triggers the FSM event "Status".
function CSAR:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds. --- Triggers the FSM event "Load".
function CSAR:__Status(delay) end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds. --- Triggers the FSM event "Load".
function CSAR:Load(delay) end

---Triggers the FSM event "Load" after a delay.
---@param delay? number Delay in seconds.
function CSAR:__Load(delay) end

---Triggers the FSM event "Save".
function CSAR:Load() end

---Triggers the FSM event "Save" after a delay.
---@param delay? number Delay in seconds.
function CSAR:__Save(delay) end

---On After "PilotDown" event. Downed Pilot detected.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Group? GROUP Group object of the downed pilot.
---@param Frequency? number Beacon frequency in kHz.
---@param Leadername? string Name of the #UNIT of the downed pilot.
---@param CoordinatesText? string String of the position of the pilot. Format determined by self.coordtype.
---@param Playername? string Player name if any given. Might be nil!
function CSAR:OnAfterPilotDown(From, Event, To, Group, Frequency, Leadername, CoordinatesText, Playername) end

---On After "Aproach" event. Heli close to downed Pilot.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Heliname? string Name of the helicopter group.
---@param Woundedgroupname? string Name of the downed pilot\'s group.
function CSAR:OnAfterApproach(From, Event, To, Heliname, Woundedgroupname) end

---On After "Landed" event. Heli landed at an airbase.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param HeliName? string Name of the #UNIT which has landed.
---@param Airbase? AIRBASE Airbase where the heli landed.
function CSAR:OnAfterLanded(From, Event, To, HeliName, Airbase) end

---On After "Boarded" event. Downed pilot boarded heli.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Heliname? string Name of the helicopter group.
---@param Woundedgroupname? string Name of the downed pilot\'s group.
---@param Description? string Descriptive name of the group.
function CSAR:OnAfterBoarded(From, Event, To, Heliname, Woundedgroupname, Description) end

---On After "Returning" event. Heli can return home with downed pilot(s).
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Heliname? string Name of the helicopter group.
---@param Woundedgroupname? string Name of the downed pilot\'s group.
function CSAR:OnAfterReturning(From, Event, To, Heliname, Woundedgroupname) end

---On After "Rescued" event. Pilot(s) have been brought to the MASH/FARP/AFB.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param HeliUnit? UNIT Unit of the helicopter.
---@param HeliName? string Name of the helicopter group.
---@param PilotsSaved? number Number of the saved pilots on board when landing.
function CSAR:OnAfterRescued(From, Event, To, HeliUnit, HeliName, PilotsSaved) end

---On After "KIA" event. Pilot is dead.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Pilotname? string Name of the pilot KIA.
function CSAR:OnAfterKIA(From, Event, To, Pilotname) end

---FSM Function OnAfterLoad.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CSAR_<alias>_Persist.csv".
function CSAR:OnAfterLoad(From, Event, To, path, filename) end

---FSM Function OnAfterSave.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving. Default is "CSAR_<alias>_Persist.csv".
function CSAR:OnAfterSave(From, Event, To, path, filename) end
