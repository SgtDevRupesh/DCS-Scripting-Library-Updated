---@meta

---@class MSRSQUEUE.Transmission
---@field text string Text to be transmitted.
---@field msrs MSRS MOOSE SRS object.
---@field duration number Duration in seconds.
---@field subgroups table Groups to send subtitle to.
---@field subtitle string Subtitle of the transmission.
---@field subduration number Duration of the subtitle being displayed.
---@field frequency number Frequency.
---@field modulation number Modulation.
---@field Tstarted number Mission time (abs) in seconds when the transmission started.
---@field isplaying boolean If true, transmission is currently playing.
---@field Tplay number Mission time (abs) in seconds when the transmission should be played.
---@field interval number Interval in seconds before next transmission.
---@field TransmitOnlyWithPlayers boolean If true, only transmit if there are alive Players.
---@field PlayerSet SET_CLIENT PlayerSet created when TransmitOnlyWithPlayers == true
---@field gender string Voice gender
---@field culture string Voice culture
---@field voice string Voice if any
---@field volume number Volume
---@field label string Label to be used
---@field coordinate COORDINATE Coordinate for this transmission
---@field speed number Speed of speech 1=100%
---@field speaker string PIPER subvoice "speaker"
---@field speed number Speed to be used

---@class MSRS.GRPCOptions
---@field plaintext string
---@field srsClientName string
---@field position table
---@field coalition string
---@field gcloud MSRS.ProviderOptions
---@field win MSRS.ProviderOptions
---@field azure MSRS.ProviderOptions
---@field aws MSRS.ProviderOptions
---@field DefaultProvider string

---@class MSRS.ProviderOptions
---@field provider string Provider.
---@field credentials string Google credentials JSON file (full path).
---@field key string Access key (DCS-gRPC with Google, AWS, AZURE as provider).
---@field secret string Secret key (DCS-gRPC with AWS as provider)
---@field region string Region.
---@field defaultVoice string Default voice (not used).
---@field voice string Voice used.

---MSRS class.
---@class MSRS : BASE
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field frequencies table Frequencies used in the transmissions.
---@field modulations table Modulations used in the transmissions.
---@field coalition number Coalition of the transmission.
---@field port number Port. Default 5002.
---@field name string Name. Default "MSRS".
---@field volume number Volume between 0 (min) and 1 (max). Default 1.
---@field culture string Culture. Default "en-GB".
---@field gender string Gender. Default "female".
---@field voice string Specific voice. Only used if no explicit provider voice specified.
---@field coordinate COORDINATE Coordinate from where the transmission is send.
---@field path string Path to the SRS exe.
---@field Label string Label showing up on the SRS radio overlay. Default is "ROBOT". No spaces allowed.
---@field ConfigFileName string Name of the standard config file.
---@field ConfigFilePath string Path to the standard config file.
---@field ConfigLoaded boolean If `true` if config file was loaded.
---@field poptions table Provider options. Each element is a data structure of type `MSRS.ProvierOptions`.
---@field provider string Provider of TTS (win, gcloud, azure, amazon, ...).
---@field backend string Backend used as interface to SRS (MSRS.Backend.SRSEXE, MSRS.Backend.HOUND or MSRS.Backend.GRPC).
---@field UsePowerShell boolean Use PowerShell to execute the command and not cmd.exe
MSRS = {
  ClassName      =     "MSRS",
  lid            =        nil,
  port           =       5002,
  name           =     "MSRS",
  backend        =   "srsexe",
  frequencies    =         {},
  modulations    =         {},
  coalition      =          0,
  gender         =   "female",
  culture        =        nil,
  voice          =        nil,
  volume         =          1,
  speed          =          1,
  coordinate     =        nil,
  provider       =      "win",
  Label          =    "ROBOT",
  ConfigFileName =    "Moose_MSRS.lua",
  ConfigFilePath =    "Config\\",
  ConfigLoaded   =     false,
  poptions       =        {},
  UsePowerShell  =      false,
}

---MSRS class version.
MSRS.version = "0.3.7"

---Voices
---@class MSRS.Voices
MSRS.Voices = {}

---Backend options to communicate with SRS.
---@class MSRS.Backend
---@field SRSEXE string Use `DCS-SR-ExternalAudio.exe`.
---@field GRPC string Use DCS-gRPC.
---@field GRPC string Use Hound-TTS.
MSRS.Backend = {
  SRSEXE = "srsexe",
  GRPC   = "grpc",
  HOUND  = "hound",
}

---Text-to-speech providers. These are compatible with the DCS-gRPC conventions.
---@class MSRS.Provider
---@field WINDOWS string Microsoft windows (`win`).
---@field GOOGLE string Google (`gcloud`).
---@field AZURE string Microsoft Azure (`azure`). Only possible with DCS-gRPC backend.
---@field AMAZON string Amazon Web Service (`aws`). Only possible with DCS-gRPC backend.
---@field PIPER string Piper local voice service. Only possible with Hound-TTS backend.
---@field KITTEN string Kitten voice server. Only possible with Hound-TTS backend. Superseded by OpenAI
---@field OPENAI string OpenAI voice server. Only possible with Hound-TTS backend.
MSRS.Provider = {
  WINDOWS = "win",
  GOOGLE  = "gcloud",
  AZURE   = "azure",
  AMAZON  = "aws",
  PIPER   = "piper",
  KITTEN  = "openai",
  OPENAI  = "openai",
}

---Function for UUID.
function MSRS.uuid() end

---Create a new MSRS object. Required argument is the frequency and modulation.
---Other parameters are read from the `Moose_MSRS.lua` config file. If you do not have that file set up you must set up and use the `DCS-SR-ExternalAudio.exe` (not DCS-gRPC) as backend, you need to still
---set the path to the exe file via {#MSRS.SetPath}.
---@param Path? string (Optional) Path to SRS directory. Default `C:\\Program Files\\DCS-SimpleRadio-Standalone\\ExternalAudio`.
---@param Frequency? number (Optional) Radio frequency in MHz. Default 143.00 MHz. Can also be given as a #table of multiple frequencies.
---@param Modulation? number (Optional) Radio modulation: 0=AM (default), 1=FM. See `radio.modulation.AM` and `radio.modulation.FM` enumerators. Can also be given as a #table of multiple modulations.
---@param Backend? string (Optional) Backend used: `MSRS.Backend.SRSEXE` (default) or `MSRS.Backend.GRPC`.
---@return MSRS # self
function MSRS:New(Path, Frequency, Modulation, Backend) end

---Set backend to communicate with SRS.
---There are two options:
---
---- `MSRS.Backend.SRSEXE`: This is the default and uses the `DCS-SR-ExternalAudio.exe`.
---- `MSRS.Backend.GRPC`: Via DCS-gRPC.
---@param Backend? string (Optional) Backend used. Default is `MSRS.Backend.SRSEXE`.
---@return MSRS # self
function MSRS:SetBackend(Backend) end

---Set DCS-gRPC as backend to communicate with SRS.
---@return MSRS # self
function MSRS:SetBackendGRPC() end

---Set Hound-TTS as backend to communicate with SRS.
---@return MSRS # self
function MSRS:SetBackendHound() end

---Set `DCS-SR-ExternalAudio.exe` as backend to communicate with SRS.
---@return MSRS # self
function MSRS:SetBackendSRSEXE() end

---Set the default backend.
---@param Backend? string
function MSRS.SetDefaultBackend(Backend) end

---Set DCS-gRPC to be the default backend.
function MSRS.SetDefaultBackendGRPC() end

---Set Hound-TTS to be the default backend.
function MSRS.SetDefaultBackendHound() end

---Get currently set backend.
---@return string # Backend.
function MSRS:GetBackend() end

---Set path to SRS install directory. More precisely, path to where the `DCS-SR-ExternalAudio.exe` is located.
---@param Path? string (Optional) Path to the directory, where the sound file is located. Default is `C:\\Program Files\\DCS-SimpleRadio-Standalone\\ExternalAudio`.
---@return MSRS # self
function MSRS:SetPath(Path) end

---Get path to SRS directory.
---@return string # Path to the directory. This includes the final slash "/".
function MSRS:GetPath() end

---Set SRS volume.
---@param Volume? number Volume - 1.0 is max, 0.0 is silence
---@return MSRS # self
function MSRS:SetVolume(Volume) end

---Get SRS volume.
---@return number # Volume Volume - 1.0 is max, 0.0 is silence
function MSRS:GetVolume() end

---Set label.
---@param Label? number (Optional) Label. Default "ROBOT"
---@return MSRS # self
function MSRS:SetLabel(Label) end

---Get label.
---@return number # Label.
function MSRS:GetLabel() end

---Set port.
---@param Port? number (Optional) Port. Default 5002.
---@return MSRS # self
function MSRS:SetPort(Port) end

---Get port.
---@return number # Port.
function MSRS:GetPort() end

---Set coalition.
---@param Coalition? number (Optional) Coalition. Default 0.
---@return MSRS # self
function MSRS:SetCoalition(Coalition) end

---Get coalition.
---@return number # Coalition.
function MSRS:GetCoalition() end

---Set frequencies.
---@param Frequencies? table Frequencies in MHz. Can also be given as a #number if only one frequency should be used.
---@return MSRS # self
function MSRS:SetFrequencies(Frequencies) end

---Add frequencies.
---@param Frequencies? table Frequencies in MHz. Can also be given as a #number if only one frequency should be used.
---@return MSRS # self
function MSRS:AddFrequencies(Frequencies) end

---Get frequencies.
---@return table # Frequencies in MHz.
function MSRS:GetFrequencies() end

---Set modulations.
---@param Modulations? table Modulations. Can also be given as a #number if only one modulation should be used.
---@return MSRS # self
function MSRS:SetModulations(Modulations) end

---Add modulations.
---@param Modulations? table Modulations. Can also be given as a #number if only one modulation should be used.
---@return MSRS # self
function MSRS:AddModulations(Modulations) end

---Get modulations.
---@return table # Modulations.
function MSRS:GetModulations() end

---Set gender.
---@param Gender? string (Optional) Gender: "male" or "female" (default).
---@return MSRS # self
function MSRS:SetGender(Gender) end

---Set culture.
---@param Culture? string Culture, *e.g.* "en-GB".
---@return MSRS # self
function MSRS:SetCulture(Culture) end

---Set to use a specific voice. Note that this will override any gender and culture settings as a voice already has a certain gender/culture.
---@param Voice? string Voice.
---@return MSRS # self
function MSRS:SetVoice(Voice) end

---Set to use a specific voice for a given provider. Note that this will override any gender and culture settings.
---@param Voice? string Voice.
---@param Provider? string (Optional) Provider. Default is as set by @{#MSRS.SetProvider}, which itself defaults to `MSRS.Provider.WINDOWS` if not set.
---@return MSRS # self
function MSRS:SetVoiceProvider(Voice, Provider) end

---Set to use a specific voice if Microsoft Windows' native TTS is use as provider. Note that this will override any gender and culture settings.
---@param Voice? string (Optional) Voice. Default `"Microsoft Hazel Desktop"`.
---@return MSRS # self
function MSRS:SetVoiceWindows(Voice) end

---Set to use a specific voice if Google is use as provider. Note that this will override any gender and culture settings.
---@param Voice? string (Optional) Voice. Default `MSRS.Voices.Google.Standard.en_GB_Standard_A`.
---@return MSRS # self
function MSRS:SetVoiceGoogle(Voice) end

---Set to use a specific voice if Piper is used as provider (only Hound-TTS backend). Note that this will override any gender and culture settings.
---@param Voice? string (Optional) [Piper Voices](https://rhasspy.github.io/piper-samples/). Default `"en_US-ryan-low"`.
---@return MSRS # self
function MSRS:SetVoicePiper(Voice) end

---Set to use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@param Speaker? string (Optional) [Piper Voices](https://rhasspy.github.io/piper-samples/). Some have speakers as sub-voices.
---@return MSRS # self
function MSRS:SetSpeakerPiper(Speaker) end

---Set to use a specific voice if Microsoft Azure is use as provider (only DCS-gRPC backend). Note that this will override any gender and culture settings.
---@param Voice? string (Optional) [Azure Voice](https://learn.microsoft.com/azure/cognitive-services/speech-service/language-support). Default `"en-US-AriaNeural"`.
---@return MSRS # self
function MSRS:SetVoiceAzure(Voice) end

---Set to use a specific voice if Amazon Web Service is use as provider (only DCS-gRPC backend). Note that this will override any gender and culture settings.
---@param Voice? string (Optional) [AWS Voice](https://docs.aws.amazon.com/polly/latest/dg/voicelist.html). Default `"Brian"`.
---@return MSRS # self
function MSRS:SetVoiceAmazon(Voice) end

---Get voice.
---@param Provider? string (Optional) Provider. Default is the currently set provider (`self.provider`).
---@return string # Voice.
function MSRS:GetVoice(Provider) end

---Set the coordinate from which the transmissions will be broadcasted. Note that this is only a factor if SRS has line-of-sight or distance enabled.
---@param Coordinate? COORDINATE Origin of the transmission.
---@return MSRS # self
function MSRS:SetCoordinate(Coordinate) end

---**[Deprecated]** Use google text-to-speech credentials. Also sets Google as default TTS provider.
---@param PathToCredentials? string Full path to the google credentials JSON file, e.g. "C:\Users\username\Downloads\service-account-file.json". Can also be the Google API key.
---@return MSRS # self
function MSRS:SetGoogle(PathToCredentials) end

---**[Deprecated]** Use google text-to-speech set the API key (only for DCS-gRPC).
---@param APIKey? string API Key, usually a string of length 40 with characters and numbers.
---@return MSRS # self
function MSRS:SetGoogleAPIKey(APIKey) end

---Set provider used to generate text-to-speech.
---These options are available:
---
---- `MSRS.Provider.WINDOWS`: Microsoft Windows (default)
---- `MSRS.Provider.GOOGLE`: Google Cloud
---- `MSRS.Provider.AZURE`: Microsoft Azure (only with DCS-gRPC backend)
---- `MSRS.Provider.AMAZON`: Amazon Web Service (only with DCS-gRPC backend)
---- `MSRS.Provider.PIPER`: Piper Voices (only with Hound-TTS backend)
---
---Note that all providers except Microsoft Windows and Piper need as additonal information the credentials of your account.
---@param Provider? string
---@return MSRS # self
function MSRS:SetProvider(Provider) end

---Get provider.
---@return MSRS # self
function MSRS:GetProvider() end

---Set provider options and credentials.
---@param Provider? string Provider.
---@param CredentialsFile? string Full path to your credentials file. For Google this is the path to a JSON file.
---@param AccessKey? string Your API access key.
---@param SecretKey? string Your secret key.
---@param Region? string Region to use.
---@return MSRS.ProviderOptions # Provider optionas table.
function MSRS:SetProviderOptions(Provider, CredentialsFile, AccessKey, SecretKey, Region) end

---Create MSRS.ProviderOptions.
---@param Provider? string Provider.
---@param CredentialsFile? string Full path to your credentials file. For Google this is the path to a JSON file.
---@param AccessKey? string Your API access key.
---@param SecretKey? string Your secret key.
---@param Region? string Region to use.
---@return MSRS.ProviderOptions # Provider optionas table.
function MSRS._CreateProviderOptions(Provider, CredentialsFile, AccessKey, SecretKey, Region) end

---Set provider options and credentials for Google Cloud.
---@param CredentialsFile? string Full path to your credentials file. For Google this is the path to a JSON file. This is used if `DCS-SR-ExternalAudio.exe` is used as backend.
---@param AccessKey? string Your API access key. This is necessary if DCS-gRPC is used as backend.
---@return MSRS # self
function MSRS:SetProviderOptionsGoogle(CredentialsFile, AccessKey) end

---Set provider options and credentials for Amazon Web Service (AWS). Only supported in combination with DCS-gRPC as backend.
---@param AccessKey? string Your API access key.
---@param SecretKey? string Your secret key.
---@param Region? string Your AWS [region](https://docs.aws.amazon.com/general/latest/gr/pol.html).
---@return MSRS # self
function MSRS:SetProviderOptionsAmazon(AccessKey, SecretKey, Region) end

---Set provider options and credentials for Microsoft Azure. Only supported in combination with DCS-gRPC as backend.
---@param AccessKey? string Your API access key.
---@param Region? string Your Azure [region](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/regions).
---@return MSRS # self
function MSRS:SetProviderOptionsAzure(AccessKey, Region) end

---Get provider options.
---@param Provider? string (Optional) Provider. Default is as set via @{#MSRS.SetProvider}.
---@return MSRS.ProviderOptions # Provider options.
function MSRS:GetProviderOptions(Provider) end

---Use Google to provide text-to-speech.
---@return MSRS # self
function MSRS:SetTTSProviderGoogle() end

---Use Microsoft to provide text-to-speech.
---@return MSRS # self
function MSRS:SetTTSProviderMicrosoft() end

---Use Microsoft Azure to provide text-to-speech. Only supported if used in combination with DCS-gRPC as backend.
---@return MSRS # self
function MSRS:SetTTSProviderAzure() end

---Use Amazon Web Service (AWS) to provide text-to-speech. Only supported if used in combination with DCS-gRPC as backend.
---@return MSRS # self
function MSRS:SetTTSProviderAmazon() end

---Use Piper to provide text-to-speech. Only supported if used in combination with Hound-TTS as backend.
---@return MSRS # self
function MSRS:SetTTSProviderPiper() end

---Use Kitten to provide text-to-speech. Only supported if used in combination with Hound-TTS as backend.
---@return MSRS # self
function MSRS:SetTTSProviderKitten() end

---Use OpenAI to provide text-to-speech. Only supported if used in combination with Hound-TTS as backend.
---@return MSRS # self
function MSRS:SetTTSProviderOpenAI() end

---Print SRS help to DCS log file.
---@return MSRS # self
function MSRS:Help() end

---Auto-translate messages on-the-fly with Hound Translate services. Tested with google cloud.
---@param Provider? string Provider to be used. Defaults to MSRS.Provider.GOOGLE. Options see [Hound Github](https://github.com/uriba107/HoundTTS?tab=readme-ov-file)
---@param Language? string Language to translate to, defaults to "de" (German). Takes [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language codes.
---@return MSRS # self
function MSRS:SetAutoTranslate(Provider, Language) end

---Play sound file (ogg or mp3) via SRS.
---@param Soundfile? SOUNDFILE Sound file to play.
---@param Delay? number Delay in seconds, before the sound file is played.
---@return MSRS # self
function MSRS:PlaySoundFile(Soundfile, Delay) end

---Play a SOUNDTEXT text-to-speech object.
---@param SoundText? SOUNDTEXT Sound text.
---@param Delay? number Delay in seconds, before the sound file is played.
---@return MSRS # self
function MSRS:PlaySoundText(SoundText, Delay) end

---Play text message via MSRS.
---@param Text? string Text message.
---@param Delay? number Delay in seconds, before the message is played.
---@param Coordinate? COORDINATE Coordinate.
---@param Speed? number
---@param Speaker? string Speaker (Sub-Voice) for PIPER only
---@return MSRS # self
function MSRS:PlayText(Text, Delay, Coordinate, Speed, Speaker) end

---Play text message via MSRS with explicitly specified options.
---@param Text? string Text message.
---@param Delay? number Delay in seconds, before the message is played.
---@param Frequencies? table Radio frequencies.
---@param Modulations? table Radio modulations.
---@param Gender? string Gender.
---@param Culture? string Culture.
---@param Voice? string Voice.
---@param Volume? number Volume.
---@param Label? string Label.
---@param Coordinate? COORDINATE Coordinate.
---@param Speed? number Speed.
---@param Speaker? string Speaker (Sub-Voice) for PIPER only
---@return MSRS # self
function MSRS:PlayTextExt(Text, Delay, Frequencies, Modulations, Gender, Culture, Voice, Volume, Label, Coordinate, Speed, Speaker) end

---Play text file via MSRS.
---@param TextFile? string Full path to the file.
---@param Delay? number Delay in seconds, before the message is played.
---@return MSRS # self
function MSRS:PlayTextFile(TextFile, Delay) end

---Get lat, long and alt from coordinate.
---@param Coordinate? Coordinate Coordinate. Can also be a DCS#Vec3.
---@return number # Latitude (or 0 if no input coordinate was given).
---@return number # Longitude (or 0 if no input coordinate was given).
---@return number # Altitude (or 0 if no input coordinate was given).
function MSRS:_GetLatLongAlt(Coordinate) end

---Get SRS command to play sound using the `DCS-SR-ExternalAudio.exe`.
---@param freqs? table Frequencies in MHz.
---@param modus? table Modulations.
---@param coal? number Coalition.
---@param gender? string Gender.
---@param voice? string Voice.
---@param culture? string Culture.
---@param volume? number Volume.
---@param speed? number Speed.
---@param port? number Port.
---@param label? string (Optional) Label, defaults to "ROBOT" (displayed sender name in the radio overlay of SRS) - No spaces allowed!
---@param coordinate? COORDINATE Coordinate.
---@return string # Command.
function MSRS:_GetCommand(freqs, modus, coal, gender, voice, culture, volume, speed, port, label, coordinate) end

---Execute SRS command to play sound using the `DCS-SR-ExternalAudio.exe`.
---@param command? string Command to executer
---@return number # Return value of os.execute() command.
function MSRS:_ExecCommand(command) end

---Make DCS-gRPC API call to transmit text-to-speech over SRS.
---@param Text? string Text of message to transmit (can also be SSML).
---@param Frequencies? table Radio frequencies to transmit on. Can also accept a number in MHz.
---@param Gender? string Gender.
---@param Culture? string Culture.
---@param Voice? string Voice.
---@param Volume? number Volume.
---@param Label? string Label.
---@param Coordinate? COORDINATE Coordinate.
---@return MSRS # self
function MSRS:_DCSgRPCtts(Text, Frequencies, Gender, Culture, Voice, Volume, Label, Coordinate) end

---Hound TTS Function Wrapper
---@param Message? string The text to speak.
---@param Frequencies? table The table of frequencies to use.
---@param Modulations? table The table of modulations to use.
---@param Volume? number (Optional) The volume to use, defaults to 1.0.
---@param Label? string (Optional) The label to use, defaults to "MSRS".
---@param Coalition? number (Optional) The coalition to use.
---@param Point? COORDINATE (Optional) The point from which the voice is sent.
---@param Speed? number (Optional) How fast to speak, defaults to 1.0.
---@param Gender? string (Optional) Gender to use.
---@param Culture? string (Optional) Culture to use.
---@param Voice? string (Optional) Voice to use.
---@param UseGoogle? boolean (Optional) If to use Google TTS.
---@param Speaker? string Speaker (Sub-Voice) for PIPER only.
---@param Translated? boolean (INTERNAL, do not use!) Setting for the callback post translation.
---@return SpeechTime # Speech time in seconds.
function MSRS:_HoundTextToSpeech(Message, Frequencies, Modulations, Volume, Label, Coalition, Point, Speed, Gender, Culture, Voice, UseGoogle, Speaker, Translated) end

---Hound Transmit Function Wrapper
---@param Message? string The message to speak
---@param Transmission_params? table Transmission parameter table, see below
---@param Provider_params? table Provider parameter table, see below
---@return SpeechTime # Speech time in seconds.
function MSRS:_HoundTransmit(Message, Transmission_params, Provider_params) end

---Hound Test Tone function, sends a 2-second 440 Hz sine wave tone directly over SRS, bypassing the TTS engine entirely.
---Use this to verify the SRS connection is working before debugging TTS issues.
---@param Frequencies? table The table of frequencies to use.
---@param Modulations? table The table of modulations to use.
---@param Coalition? number The coalition to use.
function MSRS:_HoundTestTone(Frequencies, Modulations, Coalition) end

---Hound speech time calculator. Use to determine how long it takes to speak something out.
---@param Message? string The message to measure. Can also be handed as string lenght.
---@param Speed? number (Optional) The speed to use, defaults to 1.0.
---@param UseGoogle? boolean (Optional) If to use google. Default: no.
function MSRS:_HoundSpeechTime(Message, Speed, UseGoogle) end

---Hound text translator. Use to translate a message into another language and hand the translation to a function.
---@param Message? string The Message to be translated.
---@param Parameters? table Parameter table. Optional. Defaults to provider google and language "de". Takes ISO 639-1 language codes.
---@param CallbackFunction? function The function we hand the translated text to.
function MSRS._HoundTranslate(Message, Parameters, CallbackFunction) end

---Create and run a radio jammer for a number of seconds on given frequencies. Requires HOUND backend v0.2.0-beta5 or better.
---@param Frequencies? table The table of frequencies to use.
---@param Modulations? table The table of modulations to use.
---@param Coalition? number (Optional) The coalition to use. Defaults to previously set coalition on this instance.
---@param Noisetype? string (Optional)  One of "white" (default) | "chirp" | "harsh" | "jam".
---@param Volume? number (Optional) Volume 0.0–1.0  (default 1.0).
---@param Seconds? number (Optional) How long in seconds this jammer runs. Defaults to 30 seconds.
---@param Label? string (Optional) The label to use, defaults to "MSRS".
---@param Vec3? Vec3 (Optional) Vec3 of the sender's position.
---@param Encrypt? boolean (Optional) If true, use the SRS encrypt option.
---@param EncKey? number (Optional) If encrypt is true, use this encrypt key.
---@return number # ID The Jammer ID to switch the jamming off again with `MSRS.RadioJammerOff()`
function MSRS:RadioJammerOn(Frequencies, Modulations, Coalition, Noisetype, Volume, Seconds, Label, Vec3, Encrypt, EncKey) end

---Switch off a running Jammer using its ID.
---@param ID? number
function MSRS:RadioJammerOff(ID) end

---Get central SRS configuration to be able to play tts over SRS radio using the `DCS-SR-ExternalAudio.exe`.
---@param Path? string (Optional) Path to config file, defaults to "C:\Users\<yourname>\Saved Games\DCS\Config"
---@param Filename? string (Optional) File to load, defaults to "Moose_MSRS.lua"
---@return boolean # success
function MSRS:LoadConfigFile(Path, Filename) end

---Function returns estimated speech time in seconds.
---Assumptions for time calc: 100 Words per min, average of 5 letters for english word so
---
---  * 5 chars * 100wpm = 500 characters per min = 8.3 chars per second
---
---So length of msg / 8.3 = number of seconds needed to read it. rounded down to 8 chars per sec map function:
---
---* (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
---@param length? number can also be passed as #string
---@param speed? number (Optional) Defaults to 1.0
---@param isGoogle? boolean We're using Google TTS
function MSRS.getSpeechTime(length, speed, isGoogle) end

---Manages radio transmissions.
---
---The purpose of the MSRSQUEUE class is to manage SRS text-to-speech (TTS) messages using the MSRS class.
---This can be used to submit multiple TTS messages and the class takes care that they are transmitted one after the other (and not overlapping).
---@class MSRSQUEUE : BASE
---@field ClassName string Name of the class "MSRSQUEUE".
---@field lid string ID for dcs.log.
---@field queue table The queue of transmissions.
---@field alias string Name of the radio queue.
---@field dt number Time interval in seconds for checking the radio queue.
---@field Tlast number Time (abs) when the last transmission finished.
---@field checking boolean If `true`, the queue update function is scheduled to be called again.
MSRSQUEUE = {
  ClassName   = "MSRSQUEUE",
  Debugmode   = nil,
  lid         = nil,
  queue       =  {},
  alias       = nil,
  dt          = nil,
  Tlast       = nil,
  checking    = nil,
}

---Create a new MSRSQUEUE object for a given radio frequency/modulation.
---@param alias? string (Optional) Name of the radio queue.
---@return MSRSQUEUE # self The MSRSQUEUE object.
function MSRSQUEUE:New(alias) end

---Clear the radio queue.
---@return MSRSQUEUE # self The MSRSQUEUE object.
function MSRSQUEUE:Clear() end

---Add a transmission to the radio queue.
---@param transmission? MSRSQUEUE.Transmission|number|string The transmission data table.
---@return MSRSQUEUE # self
function MSRSQUEUE:AddTransmission(transmission) end

---Switch to only transmit if there are players on the server.
---@param Switch? boolean If true, only send SRS if there are alive Players.
---@return MSRSQUEUE # self
function MSRSQUEUE:SetTransmitOnlyWithPlayers(Switch) end

---Create a new transmission and add it to the radio queue.
---@param text? string Text to play.
---@param duration? number (Optional) Duration in seconds the file lasts. Default is determined by number of characters of the text message.
---@param msrs? MSRS MOOSE SRS object.
---@param tstart? number (Optional) Start time (abs) seconds. Default now.
---@param interval? number (Optional) Interval in seconds after the last transmission finished.
---@param subgroups? table Groups that should receive the subtiltle.
---@param subtitle? string Subtitle displayed when the message is played.
---@param subduration? number (Optional) Duration [sec] of the subtitle being displayed. Default 5 sec.
---@param frequency? number (Optional) Radio frequency if other than MSRS default.
---@param modulation? number (Optional) Radio modulation if other then MSRS default.
---@param gender? string (Optional) Gender of the voice
---@param culture? string C(Optional) ulture of the voice
---@param voice? string (Optional) Specific voice
---@param volume? number (Optional) Volume setting
---@param label? string (Optional) Label to be used
---@param coordinate? COORDINATE (Optional) Coordinate to be used
---@param speed? number (Optional) Speed to be used
---@param speaker? string (Optional) PIPER voice can have various speakers, set this here if you use PIPER/HOUND with a fitting voice.
---@param priority? number (Optional) Priority of this transmission. Can be [1..100], default is 50. Higher is taken up earlier from the queue.
---@return MSRSQUEUE.Transmission # Radio transmission table.
function MSRSQUEUE:NewTransmission(text, duration, msrs, tstart, interval, subgroups, subtitle, subduration, frequency, modulation, gender, culture, voice, volume, label, coordinate, speed, speaker, priority) end

---Broadcast radio message.
---@param transmission? MSRSQUEUE.Transmission|number|string The transmission.
function MSRSQUEUE:Broadcast(transmission) end

---Calculate total transmission duration of all transmission in the queue.
---@return number # Total transmission duration.
function MSRSQUEUE:CalcTransmisstionDuration() end

---Check radio queue for transmissions to be broadcasted.
---@param delay? number Delay in seconds before checking.
function MSRSQUEUE:_CheckRadioQueue(delay) end
