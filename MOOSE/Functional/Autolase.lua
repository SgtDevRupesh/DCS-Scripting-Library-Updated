---@meta

---@class AUTOLASE.LaserSpot
---@field laserspot SPOT
---@field lasedunit UNIT
---@field lasingunit UNIT
---@field lasercode number
---@field location string
---@field timestamp number
---@field unitname string
---@field reccename string
---@field unittype string
---@field coordinate COORDINATE

---**Functional** - Autolase targets in the field.
---
---===
---
---**AUOTLASE** - Autolase targets in the field.
---
---===
---
---## Missions:
---
---None yet.
---
---===
---
---**Main Features:**
---
---   * Detect and lase contacts automatically
---   * Targets are lased by threat priority order
---   * Use FSM events to link functionality into your scripts
---   * Easy setup
---
---===
---
---Spot on!
---
---===
---
---# 1 Autolase concept
---
---* Detect and lase contacts automatically
---* Targets are lased by threat priority order
---* Use FSM events to link functionality into your scripts
---* Set laser codes and smoke colors per Recce unit
---* Easy set-up
---
---# 2 Basic usage
---
---## 2.2 Set up a group of Recce Units:
---
---           local FoxSet = SET_GROUP:New():FilterPrefixes("Recce"):FilterCoalitions("blue"):FilterStart()
---
---## 2.3 (Optional) Set up a group of pilots, this will drive who sees the F10 menu entry:
---
---           local Pilotset = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive(true):FilterStart()
---
---## 2.4 Set up and start Autolase:
---
---           local autolaser = AUTOLASE:New(FoxSet,coalition.side.BLUE,"Wolfpack",Pilotset)
---
---## 2.5 Example - Using a fixed laser code and color for a specific Recce unit:
---
---           local recce = SPAWN:New("Reaper")
---             :InitDelayOff()
---             :OnSpawnGroup(
---               function (group)
---                 local unit = group:GetUnit(1)
---                 local name = unit:GetName()
---                 autolaser:SetRecceLaserCode(name,1688)
---                 autolaser:SetRecceSmokeColor(name,SMOKECOLOR.Red)
---               end
---             )
---             :InitCleanUp(60)
---             :InitLimit(1,0)
---             :SpawnScheduled(30,0.5)
---
---## 2.6 Example - Inform pilots about events:
---
---           autolaser:SetNotifyPilots(true) -- defaults to true, also shown if debug == true
---           -- Note - message are shown to pilots in the #SET_CLIENT only if using the pilotset option, else to the coalition.
---
---
---### Author: **applevangelist**
---@class AUTOLASE : INTEL
---@field ClassName string
---@field lid string
---@field verbose number
---@field alias string
---@field debug boolean
---@field version string
---@field RecceSet SET_GROUP
---@field LaserCodes table
---@field playermenus table
---@field smokemenu boolean
---@field threatmenu boolean
---@field RoundingPrecision number
---@field smokeoffset table
---@field increasegroundawareness boolean
---@field MonitorFrequency number
AUTOLASE = {
  ClassName = "AUTOLASE",
  lid = "",
  verbose = 0,
  alias = "",
  debug = false,
  smokemenu = true,
  RoundingPrecision = 0,
  increasegroundawareness = false,
  MonitorFrequency = 30,
}

---AUTOLASE class version.
AUTOLASE.version = "0.1.31"

---Constructor for a new Autolase instance.
---@param RecceSet? SET_GROUP Set of detecting and lasing units
---@param Coalition? number Coalition side. Can also be passed as a string "red", "blue" or "neutral".
---@param Alias? string (Optional) An alias how this object is called in the logs etc.
---@param PilotSet? SET_CLIENT (Optional) Set of clients for precision bombing, steering menu creation. Leave nil for a coalition-wide F10 entry and display.
---@return AUTOLASE # self
function AUTOLASE:New(RecceSet, Coalition, Alias, PilotSet) end

---[User] When using Monitor, set the frequency here in which the report will appear
---@param Seconds? number Run the report loop every number of seconds defined here.
---@return AUTOLASE # self
function AUTOLASE:SetMonitorFrequency(Seconds) end

---[User] Set a table of possible laser codes.
---Each new RECCE can select a code from this table, default is { 1688, 1130, 4785, 6547, 1465, 4578 }.
---@param LaserCodes? number[]
---@return AUTOLASE # self
function AUTOLASE:SetLaserCodes(LaserCodes) end

---[User] Improve ground unit detection by using a zone scan and LOS check.
---@return AUTOLASE # self
function AUTOLASE:EnableImproveGroundUnitsDetection() end

---[User] Do not improve ground unit detection by using a zone scan and LOS check.
---@return AUTOLASE # self
function AUTOLASE:DisableImproveGroundUnitsDetection() end

---(Internal) Function to set pilot menu.
---@return AUTOLASE # self
function AUTOLASE:SetPilotMenu() end

---(Internal) Event function for new pilots.
---@param EventData? EVENTDATA
---@return AUTOLASE # self
function AUTOLASE:_EventHandler(EventData) end

---(User) Set minimum threat level for target selection, can be 0 (lowest) to 10 (highest).
---@param Level? number (Optional) Level used for filtering, defaults to 0. SAM systems and manpads have level 7 to 10, AAA level 6, MTBs and armoured vehicles level 3 to 5, APC, Artillery, Infantry and EWR level 1 to 2.
---@return AUTOLASE # self
function AUTOLASE:SetMinThreatLevel(Level) end

---(User) Set list of #UNIT level attributes that won't be lased. For list of attributes see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_attributes) and [GitHub](https://github.com/mrSkortch/DCS-miscScripts/tree/master/ObjectDB)
---@param Attributes? table Table of #string attributes to blacklist. Can be handed over as a single #string.
---@return AUTOLASE # self
function AUTOLASE:AddBlackListAttributes(Attributes) end

---(Internal) Function to get a laser code by recce name
---@param RecceName? string Unit(!) name of the Recce
---@return AUTOLASE # self
function AUTOLASE:GetLaserCode(RecceName) end

---(Internal) Function to get a smoke color by recce name
---@param RecceName? string Unit(!) name of the Recce
---@return AUTOLASE # self
function AUTOLASE:GetSmokeColor(RecceName) end

---(User) Function enable sending messages via SRS.
---@param OnOff? boolean Switch usage on and off
---@param Path? string Path to SRS TTS directory, e.g. C:\\Program Files\\DCS-SimpleRadio-Standalone\\ExternalAudio
---@param Frequency? number Frequency to send, e.g. 243
---@param Modulation? number Modulation i.e. radio.modulation.AM or radio.modulation.FM
---@param Label? string (Optional) Short label to be used on the SRS Client Overlay
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest).
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS.
---@param Provider? string (Optional) TTS Provider to be used.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AUTOLASE # self
function AUTOLASE:SetUsingSRS(OnOff, Path, Frequency, Modulation, Label, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, Provider, Speaker) end

---(User) Function set max lasing targets
---@param Number? number Max number of targets to lase at once
---@return AUTOLASE # self
function AUTOLASE:SetMaxLasingTargets(Number) end

---(Internal) Function set notify pilots on events
---@param OnOff? boolean Switch messaging on (true) or off (false)
---@return AUTOLASE # self
function AUTOLASE:SetNotifyPilots(OnOff) end

---(User) Function to set a specific code to a Recce.
---@param RecceName? string (Unit!) Name of the Recce
---@param Code? number The lase code
---@param Refresh? boolean If true, refresh menu entries
---@return AUTOLASE # self
function AUTOLASE:SetRecceLaserCode(RecceName, Code, Refresh) end

---(User) Function to set a specific smoke color for a Recce.
---@param RecceName? string (Unit!) Name of the Recce
---@param Color? number The color, e.g. SMOKECOLOR.Red, SMOKECOLOR.Green etc
---@return AUTOLASE # self
function AUTOLASE:SetRecceSmokeColor(RecceName, Color) end

---(User) Function to force laser cooldown and cool down time
---@param OnOff? boolean (Optional) Switch cool down on (true) or off (false) - defaults to true
---@param Seconds? number (Optional) Number of seconds for cooldown - dafaults to 60 seconds
---@return AUTOLASE # self
function AUTOLASE:SetLaserCoolDown(OnOff, Seconds) end

---(User) Function to set message show times.
---@param long? number Longer show time
---@param short? number Shorter show time
---@return AUTOLASE # self
function AUTOLASE:SetReportingTimes(long, short) end

---(User) Function to set lasing distance in meters and duration in seconds
---@param Distance? number (Optional) Max distance for lasing in meters - default 5000 meters
---@param Duration? number (Optional) Max duration for lasing in seconds - default 300 secs
---@return AUTOLASE # self
function AUTOLASE:SetLasingParameters(Distance, Duration) end

---(User) Function to set smoking of targets.
---@param OnOff? boolean Switch smoking on or off
---@param Color? number Smokecolor, e.g. SMOKECOLOR.Red
---@return AUTOLASE # self
function AUTOLASE:SetSmokeTargets(OnOff, Color) end

---(User) Function to set rounding precision for BR distance output.
---@param IDP? number (Optional) Rounding precision before/after the decimal sign. Defaults to zero. Positive values round right of the decimal sign, negative ones left of the decimal sign.
---@return AUTOLASE # self
function AUTOLASE:SetRoundingPrecsion(IDP) end

---(User) Show the "Switch smoke target..." menu entry for pilots. On by default.
---@param Offset? table (Optional) Define an offset for the smoke, i.e. not directly on the unit itself, angle is degrees and distance is meters. E.g. `autolase:EnableSmokeMenu({Angle=30,Distance=20})`
---@return AUTOLASE # self
function AUTOLASE:EnableSmokeMenu(Offset) end

---(User) Do not show the "Switch smoke target..." menu entry for pilots.
---@return AUTOLASE # self
function AUTOLASE:DisableSmokeMenu() end

---(User) Show the "Switch min threat lasing..." menu entry for pilots. On by default.
---@return AUTOLASE # self
function AUTOLASE:EnableThreatLevelMenu() end

---(User) Do not show the "Switch min threat lasing..." menu entry for pilots.
---@return AUTOLASE # self
function AUTOLASE:DisableThreatLevelMenu() end

---(Internal) Function to calculate line of sight.
---@param Unit? UNIT
---@return number # LOS Line of sight in meters
function AUTOLASE:GetLosFromUnit(Unit) end

---(Internal) Function to check on lased targets.
---@return AUTOLASE # self
function AUTOLASE:CleanCurrentLasing() end

---(Internal) Function to show status.
---@param Group? GROUP (Optional) show to a certain group
---@param Unit? UNIT (Optional) show to a certain unit
---@return AUTOLASE # self
function AUTOLASE:ShowStatus(Group, Unit) end

---(Internal) Function to show messages.
---@param Message? string The message to be sent
---@param Duration? number Duration in seconds
---@return AUTOLASE # self
function AUTOLASE:NotifyPilots(Message, Duration) end

---(User) Send messages via SRS.
---@param Message? string The (short!) message to be sent, e.g. "Lasing target!"
---@return AUTOLASE # self
function AUTOLASE:NotifyPilotsWithSRS(Message) end

---(Internal) Function to check if a unit is already lased.
---@param unitname? string Name of the unit to check
---@return boolean # outcome True or false
function AUTOLASE:CheckIsLased(unitname) end

---(Internal) Function to check if a unit can be lased.
---@param Recce? UNIT The Recce #UNIT
---@param Unit? UNIT The lased #UNIT
---@return boolean # outcome True or false
function AUTOLASE:CanLase(Recce, Unit) end

---(Internal) Function to do a zone check per ground Recce and make found units and statics "known".
---@return AUTOLASE # self
function AUTOLASE:_Prescient() end

---(Internal) FSM Function for monitoring
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@return AUTOLASE # self
function AUTOLASE:onbeforeMonitor(From, Event, To) end

---(Internal) FSM Function for monitoring
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@return AUTOLASE # self
function AUTOLASE:onafterMonitor(From, Event, To) end

---(Internal) FSM Function onbeforeRecceKIA
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param RecceName? string The lost Recce
---@return AUTOLASE # self
function AUTOLASE:onbeforeRecceKIA(From, Event, To, RecceName) end

---(Internal) FSM Function onbeforeTargetDestroyed
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param UnitName? string The destroyed unit\'s name
---@param RecceName? string The Recce name lasing
---@return AUTOLASE # self
function AUTOLASE:onbeforeTargetDestroyed(From, Event, To, UnitName, RecceName) end

---(Internal) FSM Function onbeforeTargetLost
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param UnitName? string The lost unit\'s name
---@param RecceName? string The Recce name lasing
---@return AUTOLASE # self
function AUTOLASE:onbeforeTargetLost(From, Event, To, UnitName, RecceName) end

---(Internal) FSM Function onbeforeLaserTimeout
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param UnitName? string The lost unit\'s name
---@param RecceName? string The Recce name lasing
---@return AUTOLASE # self
function AUTOLASE:onbeforeLaserTimeout(From, Event, To, UnitName, RecceName) end

---(Internal) FSM Function onbeforeLasing
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param LaserSpot? AUTOLASE.LaserSpot|number|string The LaserSpot data table
---@return AUTOLASE # self
function AUTOLASE:onbeforeLasing(From, Event, To, LaserSpot) end

---(Internal) FSM Function onbeforeCancel
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@return AUTOLASE # self
function AUTOLASE:onbeforeCancel(From, Event, To) end

---Triggers the FSM event "Monitor".
function AUTOLASE:Status() end

---Triggers the FSM event "Monitor" after a delay.
---@param delay? number Delay in seconds.
function AUTOLASE:__Status(delay) end

---Triggers the FSM event "Cancel".
function AUTOLASE:Cancel() end

---Triggers the FSM event "Cancel" after a delay.
---@param delay? number Delay in seconds.
function AUTOLASE:__Cancel(delay) end

---On After "RecceKIA" event.
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param RecceName? string The lost Recce
function AUTOLASE:OnAfterRecceKIA(From, Event, To, RecceName) end

---On After "TargetDestroyed" event.
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param UnitName? string The destroyed unit\'s name
---@param RecceName? string The Recce name lasing
function AUTOLASE:OnAfterTargetDestroyed(From, Event, To, UnitName, RecceName) end

---On After "TargetLost" event.
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param UnitName? string The lost unit\'s name
---@param RecceName? string The Recce name lasing
function AUTOLASE:OnAfterTargetLost(From, Event, To, UnitName, RecceName) end

---On After "LaserTimeout" event.
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param UnitName? string The lost unit\'s name
---@param RecceName? string The Recce name lasing
function AUTOLASE:OnAfterLaserTimeout(From, Event, To, UnitName, RecceName) end

---On After "Lasing" event.
---@param From? string The from state
---@param Event? string The event
---@param To? string The to state
---@param LaserSpot? AUTOLASE.LaserSpot|number|string The LaserSpot data table
function AUTOLASE:OnAfterLasing(From, Event, To, LaserSpot) end
