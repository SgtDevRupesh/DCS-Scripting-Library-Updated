---@meta

---AI CSAR class.
---@class AICSAR : FSM
---@field ClassName string Name of this class.
---@field version string Versioning.
---@field lid string LID for log entries.
---@field coalition number Colition side.
---@field template string Template for pilot.
---@field helotemplate string Template for CSAR helo.
---@field alias string Alias Name.
---@field farp AIRBASE FARP object from where to start.
---@field farpzone ZONE MASH zone to drop rescued pilots.
---@field maxdistance number Max distance to go for a rescue.
---@field pilotqueue table Queue of pilots to rescue.
---@field pilotindex number Table index to bind pilot to helo.
---@field helos table Table of Ops.FlightGroup#FLIGHTGROUP objects
---@field verbose boolean Switch more output.
---@field rescuezoneradius number Radius around downed pilot for the helo to land in.
---@field rescued table Track number of rescued pilot.
---@field autoonoff boolean Only send a helo when no human heli pilots are available.
---@field playerset SET_CLIENT Track if alive heli pilots are available.
---@field limithelos boolean limit available number of helos going on mission (defaults to true)
---@field helonumber number number of helos available (default: 3)
---@field PilotStore FIFO
---@field Altitude number Default altitude setting for the helicopter FLIGHTGROUP 1500ft.
---@field Speed number Default speed setting for the helicopter FLIGHTGROUP is 100kn.
---@field UseEventEject boolean In case Event LandingAfterEjection isn't working, use set this to true.
---@field Delay number In case of UseEventEject wait this long until we spawn a landed pilot.
---@field UseRescueZone boolean If true, use a rescue zone and not the max distance to FARP/MASH
---@field RescueZone ZONE_RADIUS Use this zone as operational area for the AICSAR instance.
AICSAR = {
  ClassName = "AICSAR",
  version = "0.1.18",
  lid = "",
  coalition = coalition.side.BLUE,
  template = "",
  helotemplate = "",
  alias = "",
  farp = nil,
  farpzone = nil,
  maxdistance = UTILS.NMToMeters(50),
  pilotqueue = {},
  pilotindex = 0,
  helos = {},
  verbose = false,
  rescuezoneradius = 200,
  rescued = {},
  autoonoff = true,
  playerset = nil,
  Messages = {},
  SRS = nil,
  SRSRadio = false,
  SRSFrequency = 243,
  SRSPath = "\\",
  SRSModulation = radio.modulation.AM,
  SRSSoundPath = nil, -- defaults to "l10n/DEFAULT/", i.e. add messages via "Sount to..." in the ME
  SRSPort = 5002,
  DCSRadio = false,
  DCSFrequency = 243,
  DCSModulation = radio.modulation.AM,
  DCSRadioGroup = nil,
  limithelos = true,
  helonumber = 3,
  gettext = nil,
  locale ="en", -- default text language
  SRSTTSRadio = false,
  SRSGoogle = false,
  SRSQ = nil,
  SRSPilot = nil,
  SRSPilotVoice = false,
  SRSOperator = nil,
  SRSOperatorVoice = false,
  PilotStore = nil,
  Speed = 100,
  Altitude = 1500,
  UseEventEject = false,
  Delay = 100,
  UseRescueZone = false,
  RescueZone = nil,
}

---TODO Messages
---Messages enum
AICSAR.Messages = {
  EN = {
  INITIALOK = "Roger, Pilot, we hear you. Stay where you are, a helo is on the way!",
  INITIALNOTOK = "Sorry, Pilot. You're behind maximum operational distance! Good Luck!",
  PILOTDOWN = "Mayday, mayday, mayday! Pilot down at ",
  PILOTKIA = "Pilot KIA!",
  HELODOWN = "CSAR Helo Down!",
  PILOTRESCUED = "Pilot rescued!",
  PILOTINHELO = "Pilot picked up!",
  },
  DE = {
  INITIALOK = "Copy, Pilot, wir hören Sie. Bleiben Sie, wo Sie sind!\nEin Hubschrauber sammelt Sie auf!",
  INITIALNOTOK = "Verstehe, Pilot. Sie sind zu weit weg von uns.\nViel Glück!",
  PILOTDOWN = "Mayday, mayday, mayday! Pilot abgestürzt: ",
  PILOTKIA = "Pilot gefallen!",
  HELODOWN = "CSAR Hubschrauber verloren!",
  PILOTRESCUED = "Pilot gerettet!",
  PILOTINHELO = "Pilot an Bord geholt!",
  },
}

---TODO Radio Messages
---Radio Messages enum for ogg files
AICSAR.RadioMessages = {
  EN = {
  INITIALOK = "initialok.ogg", -- 4.1 secs
  INITIALNOTOK = "initialnotok.ogg", -- 4.6 secs
  PILOTDOWN = "pilotdown.ogg", -- 2.6 secs
  PILOTKIA = "pilotkia.ogg", -- 1.1 sec
  HELODOWN = "helodown.ogg", -- 2.1 secs
  PILOTRESCUED = "pilotrescued.ogg", -- 3.5 secs
  PILOTINHELO = "pilotinhelo.ogg", -- 2.6 secs
  },
}

---TODO Radio Messages
---Radio Messages enum for ogg files length in secs
AICSAR.RadioLength = {
  EN = {
  INITIALOK = 4.1,
  INITIALNOTOK = 4.6, 
  PILOTDOWN = 2.6,
  PILOTKIA = 1.1,
  HELODOWN = 2.1,
  PILOTRESCUED = 3.5,
  PILOTINHELO = 2.6,
  },
}

---Function to create a new AICSAR object
---@param Alias? string Name of this instance.
---@param Coalition? number Coalition as in coalition.side.BLUE, can also be passed as "blue", "red" or "neutral"
---@param Pilottemplate? string Pilot template name.
---@param Helotemplate? string Helicopter template name.
---@param FARP? AIRBASE FARP object or Airbase from where to start.
---@param MASHZone? ZONE Zone where to drop pilots after rescue.
---@param Helonumber? number (Optional) Max number of alive Ai Helos at the same time. Defaults to 3.
---@return AICSAR # self
function AICSAR:New(Alias, Coalition, Pilottemplate, Helotemplate, FARP, MASHZone, Helonumber) end

---[Internal] Create the Moose TextAndSoundEntries
---@return AICSAR # self
function AICSAR:InitLocalization() end

---[User] Use a defined zone as area of operation and not the distance to FARP.
---@param Zone? ZONE The operational zone to use. Downed pilots in this area will be rescued. Can be any known #ZONE type.
---@return AICSAR # self
function AICSAR:SetUsingRescueZone(Zone) end

---[User] Switch sound output on and use SRS output for sound files.
---@param OnOff? boolean Switch on (true) or off (false).
---@param Path? string Path to your SRS Server External Audio Component, e.g. "C:\\\\Program Files\\\\DCS-SimpleRadio-Standalone\\\\ExternalAudio"
---@param Frequency? number (Optional) Defaults to 243 (guard)
---@param Modulation? number (Optional) Radio modulation. Defaults to radio.modulation.AM
---@param SoundPath? string (Optional) Where to find the audio files. Defaults to nil, i.e. add messages via "Sound to..." in the Mission Editor.
---@param Port? number (Optional) Port of the SRS, defaults to 5002.
---@return AICSAR # self
function AICSAR:SetSRSRadio(OnOff, Path, Frequency, Modulation, SoundPath, Port) end

---[User] Switch sound output on and use SRS-TTS output. The voice will be used across all outputs, unless you define an extra voice for downed pilots and/or the operator.
---See `AICSAR:SetPilotTTSVoice()` and `AICSAR:SetOperatorTTSVoice()`
---@param OnOff? boolean Switch on (true) or off (false).
---@param Path? string Path to your SRS Server Component, e.g. "E:\\\\Program Files\\\\DCS-SimpleRadio-Standalone\\ExternalAudio"
---@param Frequency? number (Optional) Defaults to 243 (guard)
---@param Modulation? number (Optional) Radio modulation. Defaults to radio.modulation.AM
---@param Port? number (Optional) Port of the SRS, defaults to 5002.
---@param Voice? string (Optional) The voice to be used.
---@param Culture? string (Optional) The culture to be used, defaults to "en-GB"
---@param Gender? string (Optional)  The gender to be used, defaults to "male"
---@param GoogleCredentials? string (Optional) Path to google credentials
---@param Provider? string (Optional) TTS Provider to be used.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AICSAR # self
function AICSAR:SetSRSTTSRadio(OnOff, Path, Frequency, Modulation, Port, Voice, Culture, Gender, GoogleCredentials, Provider, Speaker) end

---[User] Set SRS TTS Voice of downed pilot. `AICSAR:SetSRSTTSRadio()` needs to be set first!
---@param Voice? string The voice to be used, e.g. `MSRS.Voices.Google.Standard.en_US_Standard_J` for Google or `MSRS.Voices.Microsoft.David` for Microsoft. Specific voices override culture and gender!
---@param Culture? string (Optional) The culture to be used, defaults to "en-US"
---@param Gender? string (Optional)  The gender to be used, defaults to "male"
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AICSAR # self
function AICSAR:SetPilotTTSVoice(Voice, Culture, Gender, Speaker) end

---[User] Set SRS TTS Voice of the rescue operator. `AICSAR:SetSRSTTSRadio()` needs to be set first!
---@param Voice? string The voice to be used, e.g. `MSRS.Voices.Google.Standard.en_US_Standard_J` for Google or `MSRS.Voices.Microsoft.David` for Microsoft. Specific voices override culture and gender!
---@param Culture? string (Optional) The culture to be used, defaults to "en-GB"
---@param Gender? string (Optional)  The gender to be used, defaults to "female"
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return AICSAR # self
function AICSAR:SetOperatorTTSVoice(Voice, Culture, Gender, Speaker) end

---[User] Switch sound output on and use normale (DCS) radio
---@param OnOff? boolean Switch on (true) or off (false).
---@param Frequency? number (Optional)  Defaults to 243 (guard).
---@param Modulation? number (Optional) Radio modulation. Defaults to radio.modulation.AM.
---@param Group? GROUP The group to use as sending station.
---@return AICSAR # self
function AICSAR:SetDCSRadio(OnOff, Frequency, Modulation, Group) end

---[Internal] Sound output via non-SRS Radio. Add message files (.ogg) via "Sound to..." in the ME.
---@param Soundfile? string Name of the soundfile
---@param Duration? number Duration of the sound
---@param Subtitle? string Text to display
---@return AICSAR # self
function AICSAR:DCSRadioBroadcast(Soundfile, Duration, Subtitle) end

---[Internal] Catch the ejection and save the pilot name
---@param EventData? EVENTDATA
---@return AICSAR # self
function AICSAR:_EjectEventHandler(EventData) end

---[Internal] Spawn a pilot
---@param _LandingPos? COORDINATE Landing Postion
---@param _coalition? number Coalition side
---@return AICSAR # self
function AICSAR:_DelayedSpawnPilot(_LandingPos, _coalition) end

---[Internal] Catch the landing after ejection and spawn a pilot in situ.
---@param EventData? EVENTDATA
---@param FromEject? boolean
---@return AICSAR # self
function AICSAR:_EventHandler(EventData, FromEject) end

---[Internal] Get FlightGroup
---@return FLIGHTGROUP # The FlightGroup
function AICSAR:_GetFlight() end

---[Internal] Create a new rescue mission
---@param Pilot? GROUP The pilot to be rescued.
---@param Index? number Index number of this pilot
---@return AICSAR # self
function AICSAR:_InitMission(Pilot, Index) end

---[Internal] Check if pilot arrived in rescue zone (MASH)
---@param Pilot? GROUP The pilot to be rescued.
---@return boolean # outcome
function AICSAR:_CheckInMashZone(Pilot) end

---[User] Set default helo speed. Note - AI might have other ideas. Defaults to 100kn.
---@param Knots? number Speed in knots.
---@return AICSAR # self
function AICSAR:SetDefaultSpeed(Knots) end

---[User] Set default helo altitudeAGL. Note - AI might have other ideas. Defaults to 1500ft.
---@param Feet? number AGL set in feet.
---@return AICSAR # self
function AICSAR:SetDefaultAltitude(Feet) end

---[Internal] Check helo queue
---@return AICSAR # self
function AICSAR:_CheckHelos() end

---[Internal] Count helos queue
---@return number # Number of helos on mission
function AICSAR:_CountHelos() end

---[Internal] Check pilot queue for next mission
---@param OpsGroup? OPSGROUP
---@return AICSAR # self
function AICSAR:_CheckQueue(OpsGroup) end

---[Internal] onafterStart
---@param From? string
---@param Event? string
---@param To? string
---@return AICSAR # self
function AICSAR:onafterStart(From, Event, To) end

---[Internal] onafterStatus
---@param From? string
---@param Event? string
---@param To? string
---@return AICSAR # self
function AICSAR:onafterStatus(From, Event, To) end

---[Internal] onafterStop
---@param From? string
---@param Event? string
---@param To? string
---@return AICSAR # self
function AICSAR:onafterStop(From, Event, To) end

---[Internal] onafterPilotDown
---@param From? string
---@param Event? string
---@param To? string
---@param Coordinate? COORDINATE Location of the pilot.
---@param InReach? boolean True if in maxdistance else false.
---@return AICSAR # self
function AICSAR:onafterPilotDown(From, Event, To, Coordinate, InReach) end

---[Internal] onafterPilotKIA
---@param From? string
---@param Event? string
---@param To? string
---@return AICSAR # self
function AICSAR:onafterPilotKIA(From, Event, To) end

---[Internal] onafterHeloDown
---@param From? string
---@param Event? string
---@param To? string
---@param Helo? FLIGHTGROUP
---@param Index? number
---@return AICSAR # self
function AICSAR:onafterHeloDown(From, Event, To, Helo, Index) end

---[Internal] onafterPilotRescued
---@param From? string
---@param Event? string
---@param To? string
---@param PilotName? string
---@return AICSAR # self
function AICSAR:onafterPilotRescued(From, Event, To, PilotName) end

---[Internal] onafterPilotUnloaded
---@param From? string
---@param Event? string
---@param To? string
---@param Helo? FLIGHTGROUP
---@param OpsGroup? OPSGROUP
---@return AICSAR # self
function AICSAR:onafterPilotUnloaded(From, Event, To, Helo, OpsGroup) end

---[Internal] onafterPilotPickedUp
---@param From? string
---@param Event? string
---@param To? string
---@param Helo? FLIGHTGROUP
---@param CargoTable? table of Ops.OpsGroup#OPSGROUP Cargo objects
---@param Index? number
---@return AICSAR # self
function AICSAR:onafterPilotPickedUp(From, Event, To, Helo, CargoTable, Index) end

---Triggers the FSM event "Status".
function AICSAR:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function AICSAR:__Status(delay) end

---Triggers the FSM event "Stop".
function AICSAR:Stop() end

---Triggers the FSM event "Stop" after a delay.
---@param delay? number Delay in seconds.
function AICSAR:__Stop(delay) end

---On after "PilotDown" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? COORDINATE Location of the pilot.
---@param InReach? boolean True if in maxdistance else false.
function AICSAR:OnAfterPilotDown(From, Event, To, Coordinate, InReach) end

---On after "PilotPickedUp" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Helo? FLIGHTGROUP
---@param CargoTable? table of Ops.OpsGroup#OPSGROUP Cargo objects
---@param Index? number
function AICSAR:OnAfterPilotPickedUp(From, Event, To, Helo, CargoTable, Index) end

---On after "PilotRescued" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param PilotName? string
function AICSAR:OnAfterPilotRescued(From, Event, To, PilotName) end

---On after "PilotUnloaded" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Helo? FLIGHTGROUP
---@param OpsGroup? OPSGROUP
function AICSAR:OnAfterPilotUnloaded(From, Event, To, Helo, OpsGroup) end

---On after "PilotKIA" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AICSAR:OnAfterPilotKIA(From, Event, To) end

---On after "HeloOnDuty" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Helo? GROUP Helo group object
function AICSAR:OnAfterHeloOnDuty(From, Event, To, Helo) end

---On after "HeloDown" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Helo? FLIGHTGROUP
---@param Index? number
function AICSAR:OnAfterHeloDown(From, Event, To, Helo, Index) end
