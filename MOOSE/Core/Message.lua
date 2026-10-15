---@meta

---The MESSAGE class
---@class MESSAGE : BASE
MESSAGE = {
  ClassName = "MESSAGE",
  MessageCategory = 0,
  MessageID = 0,
}

---Message Types
---@class MESSAGE.Type
MESSAGE.Type = {
  Update = "Update",
  Information = "Information",
  Briefing = "Briefing Report",
  Overview = "Overview Report",
  Detailed = "Detailed Report",
}

---Creates a new MESSAGE object. Note that these MESSAGE objects are not yet displayed on the display panel. You must use the functions {#MESSAGE.ToClient} or {#MESSAGE.ToCoalition} or {#MESSAGE.ToAll} to send these Messages to the respective recipients.
---@param Text? string is the text of the Message.
---@param Duration? number Duration in seconds how long the message text is shown.
---@param Category? any (Optional) String expressing the "category" of the Message. The category will be shown as the first text in the message followed by a ": ".
---@param ClearScreen? boolean (optional) Clear all previous messages if true.
---@return MESSAGE # self
function MESSAGE:New(Text, Duration, Category, ClearScreen) end

---Creates a new MESSAGE object of a certain type.
---Note that these MESSAGE objects are not yet displayed on the display panel.
---You must use the functions {Core.Message#ToClient} or {Core.Message#ToCoalition} or {Core.Message#ToAll} to send these Messages to the respective recipients.
---The message display times are automatically defined based on the timing settings in the {Core.Settings} menu.
---@param MessageText? string is the text of the Message.
---@param MessageType? MESSAGE.Type|number|string The type of the message.
---@param ClearScreen? boolean (optional) Clear all previous messages.
---@return MESSAGE
function MESSAGE:NewType(MessageText, MessageType, ClearScreen) end

---Clears all previous messages from the screen before the new message is displayed. Not that this must come before all functions starting with ToX(), e.g. ToAll(), ToGroup() etc.
---@return MESSAGE
function MESSAGE:Clear() end

---Sends a MESSAGE to a Client Group. Note that the Group needs to be defined within the ME with the skillset "Client" or "Player".
---@param Client? CLIENT is the Group of the Client.
---@param Settings? SETTINGS used to display the message.
---@return MESSAGE
function MESSAGE:ToClient(Client, Settings) end

---Sends a MESSAGE to a SET_GROUP, SET_UNIT, or SET_CLIENT.
---@param Set? SET_GROUP The set to send to.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return self
function MESSAGE:ToSet(Set, Settings) end

---Sends a MESSAGE to a SET_GROUP, SET_UNIT, or SET_CLIENT if a condition is true.
---@param Set? SET_GROUP The set to send to.
---@param Condition? boolean The condition which needs to be true.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return self
function MESSAGE:ToSetIf(Set, Condition, Settings) end

---Sends a MESSAGE to a Group.
---@param Group? GROUP to which the message is displayed.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return MESSAGE # Message object.
function MESSAGE:ToGroup(Group, Settings) end

---Sends a MESSAGE to a Unit.
---@param Unit? UNIT to which the message is displayed.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return MESSAGE # Message object.
function MESSAGE:ToUnit(Unit, Settings) end

---Sends a MESSAGE to a Country.
---@param Country? number to which the message is displayed, e.g. country.id.GERMANY. For all country numbers see here: [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_country)
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return MESSAGE # Message object.
function MESSAGE:ToCountry(Country, Settings) end

---Sends a MESSAGE to a Country.
---@param Country? number to which the message is displayed, , e.g. country.id.GERMANY. For all country numbers see here: [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_country)
---@param Condition? boolean Sends the message only if the condition is true.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return MESSAGE # Message object.
function MESSAGE:ToCountryIf(Country, Condition, Settings) end

---Sends a MESSAGE to the Blue coalition.
---@return MESSAGE
function MESSAGE:ToBlue() end

---Sends a MESSAGE to the Red Coalition.
---@return MESSAGE
function MESSAGE:ToRed() end

---Sends a MESSAGE to a Coalition.
---@param CoalitionSide? coalition.side|number|string @{#DCS.coalition.side} to which the message is displayed.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@return MESSAGE # Message object.
function MESSAGE:ToCoalition(CoalitionSide, Settings) end

---Sends a MESSAGE to a Coalition if the given Condition is true.
---@param CoalitionSide? any
---@param Condition? boolean Sends the message only if the condition is true.
---@return MESSAGE # self
function MESSAGE:ToCoalitionIf(CoalitionSide, Condition) end

---Sends a MESSAGE to all players.
---@param Settings? SETTINGS (Optional) Settings for message display.
---@param Delay? number (Optional) Delay in seconds before the message is send. Default instantly (`nil`).
---@return MESSAGE # self
function MESSAGE:ToAll(Settings, Delay) end

---Sends a MESSAGE to all players if the given Condition is true.
---@param Condition? boolean
---@return MESSAGE
function MESSAGE:ToAllIf(Condition) end

---Sends a MESSAGE to DCS log file.
---@return MESSAGE # self
function MESSAGE:ToLog() end

---Sends a MESSAGE to DCS log file if the given Condition is true.
---@param Condition? any
---@return MESSAGE # self
function MESSAGE:ToLogIf(Condition) end

---Set up MESSAGE generally to allow Text-To-Speech via SRS and TTS functions. `SetMSRS()` will try to use as many attributes configured with {Sound.SRS#MSRS.LoadConfigFile}() as possible.
---@param PathToSRS? string (optional) Path to SRS TTS Folder, defaults to "C:\\\\Program Files\\\\DCS-SimpleRadio-Standalone\\ExternalAudio" or your configuration file setting.
---@param Port? number Port (optional) number of SRS, defaults to 5002 or your configuration file setting.
---@param PathToCredentials? string (optional) Path to credentials file for Google.
---@param Frequency? number Frequency in MHz. Can also be given as a #table of frequencies.
---@param Modulation? number Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations.
---@param Gender? string (optional) Gender, i.e. "male" or "female", defaults to "female" or your configuration file setting.
---@param Culture? string (optional) Culture, e.g. "en-US", defaults to "en-GB" or your configuration file setting.
---@param Voice? string (optional) Voice. Will override gender and culture settings, e.g. MSRS.Voices.Microsoft.Hazel or MSRS.Voices.Google.Standard.de_DE_Standard_D. Hint on Microsoft voices - working voices are limited to Hedda, Hazel, David, Zira and Hortense. **Must** be installed on your Desktop or Server!
---@param Coalition? number (optional) Coalition, can be coalition.side.RED, coalition.side.BLUE or coalition.side.NEUTRAL. Defaults to coalition.side.NEUTRAL.
---@param Volume? number (optional) Volume, can be between 0.0 and 1.0 (loudest).
---@param Label? string (optional) Label, defaults to "MESSAGE" or the Message Category set.
---@param Coordinate? COORDINATE (optional) Coordinate this messages originates from.
---@param Backend? string (optional) Backend to be used, can be MSRS.Backend.SRSEXE or MSRS.Backend.GRPC or MSRS.Backend.HOUND etc
---@param Provider? string (optional) Provider to be used, can be MSRS.Provider.WINDOWS or MSRS.Provider.GOOGLE or MSRS.Provider.PIPER etc
---@param Speaker? string (optional) Speaker to be used. Only for select provider PIPER TTS Voices, requires HOUND backend.
function MESSAGE.SetMSRS(PathToSRS, Port, PathToCredentials, Frequency, Modulation, Gender, Culture, Voice, Coalition, Volume, Label, Coordinate, Backend, Provider, Speaker) end

---Sends a message via SRS. `ToSRS()` will try to use as many attributes configured with {Core.Message#MESSAGE.SetMSRS}() and {Sound.SRS#MSRS.LoadConfigFile}() as possible.
---@param frequency? number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation? number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender? string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture? string (optional) Culture, e.g. "en-US". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice? string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coalition? number (optional) Coalition, can be coalition.side.RED, coalition.side.BLUE or coalition.side.NEUTRAL. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume? number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate? COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE # self
function MESSAGE:ToSRS(frequency, modulation, gender, culture, voice, coalition, volume, coordinate) end

---Sends a message via SRS on the blue coalition side.
---@param frequency? number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation? number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender? string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture? string (optional) Culture, e.g. "en-US. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice? string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume? number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate? COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE # self
function MESSAGE:ToSRSBlue(frequency, modulation, gender, culture, voice, volume, coordinate) end

---Sends a message via SRS on the red coalition side.
---@param frequency? number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation? number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender? string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture? string (optional) Culture, e.g. "en-US. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice? string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume? number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate? COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE # self
function MESSAGE:ToSRSRed(frequency, modulation, gender, culture, voice, volume, coordinate) end

---Sends a message via SRS to all - via the neutral coalition side.
---@param frequency? number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation? number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender? string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture? string (optional) Culture, e.g. "en-US. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice? string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume? number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate? COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE # self
function MESSAGE:ToSRSAll(frequency, modulation, gender, culture, voice, volume, coordinate) end
