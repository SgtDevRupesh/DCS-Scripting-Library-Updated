---@meta

---@class SOUNDBASE : BASE
---@field ClassName string Name of the class.
SOUNDBASE={
  ClassName   = "SOUNDBASE",
}

---Constructor to create a new SOUNDBASE object.
---@return SOUNDBASE # self
function SOUNDBASE:New() end

---Function returns estimated speech time in seconds.
---Assumptions for time calc: 100 Words per min, avarage of 5 letters for english word so
---
---  * 5 chars * 100wpm = 500 characters per min = 8.3 chars per second
---
---So lengh of msg / 8.3 = number of seconds needed to read it. rounded down to 8 chars per sec map function:
---
---* (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
---@param length? any
---@param speed? any
---@param isGoogle? boolean If true, google text-to-speech is used.
function SOUNDBASE:GetSpeechTime(length, speed, isGoogle) end

---@class SOUNDFILE : BASE
---@field ClassName string Name of the class
---@field filename string Name of the flag.
---@field path string Directory path, where the sound file is located. This includes the final slash "/".
---@field duration string Duration of the sound file in seconds.
---@field subtitle string Subtitle of the transmission.
---@field subduration number Duration in seconds how long the subtitle is displayed.
---@field useSRS boolean If true, sound file is played via SRS. Sound file needs to be on local disk not inside the miz file!
SOUNDFILE={
  ClassName   = "SOUNDFILE",
  filename    =  nil,
  path        = "l10n/DEFAULT/",
  duration    =    3,
  subtitle    =   nil,
  subduration =   0,
  useSRS      = false,
}

---Constructor to create a new SOUNDFILE object.
---@param FileName? string The name of the sound file, e.g. "Hello World.ogg".
---@param Path? string (Optional) The path of the directory, where the sound file is located. Default is "l10n/DEFAULT/" within the miz file.
---@param Duration? number (Optional) Duration in seconds, how long it takes to play the sound file. Default is 3 seconds.
---@param UseSrs? boolean (Optional) Set if SRS should be used to play this file. Default is false.
---@return SOUNDFILE # self
function SOUNDFILE:New(FileName, Path, Duration, UseSrs) end

---Set path, where the sound file is located.
---@param Path? string (Optional) Path to the directory, where the sound file is located. In case this is nil, it defaults to the DCS mission temp directory.
---@return SOUNDFILE # self
function SOUNDFILE:SetPath(Path) end

---Get path of the directory, where the sound file is located.
---@return string # Path.
function SOUNDFILE:GetPath() end

---Set sound file name. This must be a .ogg or .mp3 file!
---@param FileName? string (Optional) Name of the file. Default is "Hello World.mp3".
---@return SOUNDFILE # self
function SOUNDFILE:SetFileName(FileName) end

---Get the sound file name.
---@return string # Name of the soud file. This does *not* include its path.
function SOUNDFILE:GetFileName() end

---Set duration how long it takes to play the sound file.
---@param Duration? string (Optional) Duration in seconds. Default 3 seconds.
---@return SOUNDFILE # self
function SOUNDFILE:SetDuration(Duration) end

---Get duration how long the sound file takes to play.
---@return number # Duration in seconds.
function SOUNDFILE:GetDuration() end

---Get the complete sound file name inlcuding its path.
---@return string # Name of the sound file.
function SOUNDFILE:GetName() end

---Set whether sound files should be played via SRS.
---@param Switch? boolean If true or nil, use SRS. If false, use DCS transmission.
---@return SOUNDFILE # self
function SOUNDFILE:SetPlayWithSRS(Switch) end

---@class SOUNDTEXT : BASE
---@field ClassName string Name of the class
---@field text string Text to speak.
---@field duration number Duration in seconds.
---@field gender string Gender: "male", "female".
---@field culture string Culture, e.g. "en-GB".
---@field voice string Specific voice to use. Overrules `gender` and `culture` settings.
---@field speed number Specific speed to be used.
---@field speaker string (PIPER/HOUND only) sub-voice speaker to be used.
SOUNDTEXT={
  ClassName   = "SOUNDTEXT",
}

---Constructor to create a new SOUNDTEXT object.
---@param Text? string The text to speak.
---@param Duration? number (Optional) Duration in seconds, how long it takes to play the text. Default is 3 seconds.
---@return SOUNDTEXT # self
function SOUNDTEXT:New(Text, Duration) end

---Set text.
---@param Text? string (Optional) Text to speak. Default "Hello World!".
---@return SOUNDTEXT # self
function SOUNDTEXT:SetText(Text) end

---Set duration, how long it takes to speak the text.
---@param Duration? number (Optional) Duration in seconds. Default 3 seconds.
---@return SOUNDTEXT # self
function SOUNDTEXT:SetDuration(Duration) end

---Set gender.
---@param Gender? string (Optional) Gender: "male" or "female" (default).
---@return SOUNDTEXT # self
function SOUNDTEXT:SetGender(Gender) end

---Set TTS culture - local for the voice.
---@param Culture? string (Optional) TTS culture. Default "en-GB".
---@return SOUNDTEXT # self
function SOUNDTEXT:SetCulture(Culture) end

---Set to use a specific voice name.
---See the list from `DCS-SR-ExternalAudio.exe --help` or if using google see [google voices](https://cloud.google.com/text-to-speech/docs/voices).
---@param VoiceName? string Voice name. Note that this will overrule `Gender` and `Culture`.
---@return SOUNDTEXT # self
function SOUNDTEXT:SetVoice(VoiceName) end

---Set to use a specific speed.
---@param Speed? number
---@return SOUNDTEXT # self
function SOUNDTEXT:SetSpeed(Speed) end

---Set to use a specific speaker (PIPER sub-voice).
---@param Speaker? string
---@return SOUNDTEXT # self
function SOUNDTEXT:SetSpeaker(Speaker) end
