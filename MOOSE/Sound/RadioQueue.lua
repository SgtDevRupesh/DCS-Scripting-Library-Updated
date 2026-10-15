---@meta

---@class RADIOQUEUE.Transmission
---@field filename string Name of the file to be transmitted.
---@field path string Path in miz file where the file is located.
---@field duration number Duration in seconds.
---@field subtitle string Subtitle of the transmission.
---@field subduration number Duration of the subtitle being displayed.
---@field Tstarted number Mission time (abs) in seconds when the transmission started.
---@field isplaying boolean If true, transmission is currently playing.
---@field Tplay number Mission time (abs) in seconds when the transmission should be played.
---@field interval number Interval in seconds before next transmission.
---@field soundfile SOUNDFILE Sound file object to play via SRS.
---@field soundtext SOUNDTEXT Sound TTS object to play via SRS.

---Manages radio transmissions.
---
---The main goal of the RADIOQUEUE class is to string together multiple sound files to play a complete sentence.
---The underlying problem is that radio transmissions in DCS are not queued but played "on top" of each other.
---Therefore, to achive the goal, it is vital to know the precise duration how long it takes to play the sound file.
---@class RADIOQUEUE : BASE
---@field ClassName string Name of the class "RADIOQUEUE".
---@field Debugmode boolean Debug mode. More info.
---@field lid string ID for dcs.log.
---@field frequency number The radio frequency in Hz.
---@field modulation number The radio modulation. Either radio.modulation.AM or radio.modulation.FM.
---@field scheduler SCHEDULER The scheduler.
---@field RQid string The radio queue scheduler ID.
---@field queue table The queue of transmissions.
---@field alias string Name of the radio.
---@field dt number Time interval in seconds for checking the radio queue.
---@field delay number Time delay before starting the radio queue.
---@field Tlast number Time (abs) when the last transmission finished.
---@field sendercoord COORDINATE Coordinate from where transmissions are broadcasted.
---@field sendername number Name of the sending unit or static.
---@field senderinit boolean Set frequency was initialized.
---@field power number Power of radio station in Watts. Default 100 W.
---@field numbers table Table of number transmission parameters.
---@field checking boolean Scheduler is checking the radio queue.
---@field schedonce boolean Call ScheduleOnce instead of normal scheduler.
---@field msrs MSRS Moose SRS class.
RADIOQUEUE = {
  ClassName   = "RADIOQUEUE",
  Debugmode   = nil,
  lid         = nil,
  frequency   = nil,
  modulation  = nil,
  scheduler   = nil,
  RQid        = nil,
  queue       =  {},
  alias       = nil,
  dt          = nil,
  delay       = nil,
  Tlast       = nil,
  sendercoord = nil,
  sendername  = nil,
  senderinit  = nil,
  power       = nil,
  numbers     =  {},
  checking    = nil,
  schedonce   = false,
}

---Create a new RADIOQUEUE object for a given radio frequency/modulation.
---@param frequency? number The radio frequency in MHz.
---@param modulation? number (Optional) The radio modulation. Default `radio.modulation.AM` (=0).
---@param alias? string (Optional) Name of the radio queue.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:New(frequency, modulation, alias) end

---Start the radio queue.
---@param delay? number (Optional) Delay in seconds, before the radio queue is started. Default 1 sec.
---@param dt? number (Optional) Time step in seconds for checking the queue. Default 0.01 sec.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:Start(delay, dt) end

---Stop the radio queue. Stop scheduler and delete queue.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:Stop() end

---Set coordinate from where the transmission is broadcasted.
---@param coordinate? COORDINATE Coordinate of the sender.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:SetSenderCoordinate(coordinate) end

---Set name of unit or static from which transmissions are made.
---@param name? string Name of the unit or static used for transmissions.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:SetSenderUnitName(name) end

---Set radio power. Note that this only applies if no relay unit is used.
---@param power? number (Optional) Radio power in Watts. Default 100 W.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:SetRadioPower(power) end

---Set SRS.
---@param PathToSRS? string (Optional) Path to SRS.
---@param Port? number (Optional) SRS port. Default 5002.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:SetSRS(PathToSRS, Port) end

---Set parameters of a digit.
---@param digit? number The digit 0-9.
---@param filename? string The name of the sound file.
---@param duration? number The duration of the sound file in seconds.
---@param path? string (Optional) The directory within the miz file where the sound is located. Default "l10n/DEFAULT/".
---@param subtitle? string Subtitle of the transmission.
---@param subduration? number (Optional) Duration [sec] of the subtitle being displayed. Default 5 sec.
---@return RADIOQUEUE # self The RADIOQUEUE object.
function RADIOQUEUE:SetDigit(digit, filename, duration, path, subtitle, subduration) end

---Add a transmission to the radio queue.
---@param transmission? RADIOQUEUE.Transmission|number|string The transmission data table.
---@return RADIOQUEUE # self
function RADIOQUEUE:AddTransmission(transmission) end

---Create a new transmission and add it to the radio queue.
---@param filename? string Name of the sound file. Usually an ogg or wav file type.
---@param duration? number Duration in seconds the file lasts.
---@param path? number (Optional) Directory path inside the miz file where the sound file is located. Default "l10n/DEFAULT/".
---@param tstart? number (Optional) Start time (abs) seconds. Default now.
---@param interval? number (Optional) Interval in seconds after the last transmission finished. Defaults to 0.
---@param subtitle? string Subtitle of the transmission.
---@param subduration? number (Optional) Duration [sec] of the subtitle being displayed. Default 5 sec.
---@return RADIOQUEUE.Transmission # Radio transmission table.
function RADIOQUEUE:NewTransmission(filename, duration, path, tstart, interval, subtitle, subduration) end

---Add a SOUNDFILE to the radio queue.
---@param soundfile? SOUNDFILE Sound file object to be added.
---@param tstart? number (Optional) Start time (abs) seconds. Default now.
---@param interval? number (Optional) Interval in seconds after the last transmission finished. Defaults to 0.
---@return RADIOQUEUE # self
function RADIOQUEUE:AddSoundFile(soundfile, tstart, interval) end

---Add a SOUNDTEXT to the radio queue.
---@param soundtext? SOUNDTEXT Text-to-speech text.
---@param tstart? number (Optional) Start time (abs) seconds. Default now.
---@param interval? number (Optional) Interval in seconds after the last transmission finished. Defaults to 0.
---@return RADIOQUEUE # self
function RADIOQUEUE:AddSoundText(soundtext, tstart, interval) end

---Convert a number (as string) into a radio transmission.
---E.g. for board number or headings.
---@param number? string Number string, e.g. "032" or "183".
---@param delay? number Delay before transmission in seconds.
---@param interval? number Interval between the next call.
---@return number # Duration of the call in seconds.
function RADIOQUEUE:Number2Transmission(number, delay, interval) end

---Broadcast radio message.
---@param transmission? RADIOQUEUE.Transmission|number|string The transmission.
function RADIOQUEUE:Broadcast(transmission) end

---Broadcast radio message.
---@param transmission? RADIOQUEUE.Transmission|number|string The transmission.
function RADIOQUEUE:_BroadcastSRS(transmission) end

---Start checking the radio queue.
---@param delay? number Delay in seconds before checking.
function RADIOQUEUE:_CheckRadioQueueDelayed(delay) end

---Check radio queue for transmissions to be broadcasted.
function RADIOQUEUE:_CheckRadioQueue() end

---Get unit from which we want to transmit a radio message. This has to be an aircraft for subtitles to work.
---@return UNIT # Sending unit or nil if was not setup, is not an aircraft or ground unit or is not alive.
function RADIOQUEUE:_GetRadioSender() end

---Get unit from which we want to transmit a radio message. This has to be an aircraft or ground unit for subtitles to work.
---@return Vec3 # Vector 3D.
function RADIOQUEUE:_GetRadioSenderCoord() end
