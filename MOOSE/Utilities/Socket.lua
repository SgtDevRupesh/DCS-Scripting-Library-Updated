---@meta

---SOCKET class.
---@class SOCKET : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field socket table The socket.
---@field port number The port.
---@field host string The host.
---@field json table JSON.
SOCKET = {
  ClassName      = "SOCKET",
  verbose        =     0,
  lid            =   nil,
}

---Data type. This is the keyword the socket listener uses.
---@class SOCKET.DataType
---@field TEXT string Plain text.
---@field BOMBRESULT string Range bombing.
---@field STRAFERESULT string Range strafeing result.
---@field LSOGRADE string Airboss LSO grade.
---@field TTS string Text-To-Speech.
SOCKET.DataType={
  TEXT="moose_text",
  BOMBRESULT="moose_bomb_result",
  STRAFERESULT="moose_strafe_result",
  LSOGRADE="moose_lso_grade",
  TTS="moose_text2speech"
}

---SOCKET class version.
SOCKET.version = "0.3.0"

---Create a new SOCKET object.
---@param Port? number (Optional) UDP port. Default `10042`.
---@param Host? string (Optional) Host. Default `"127.0.0.1"`.
---@return SOCKET # self
function SOCKET:New(Port, Host) end

---Set port.
---@param Port? number (Optional) Port. Default 10042.
---@return SOCKET # self
function SOCKET:SetPort(Port) end

---Set host.
---@param Host? string (Optional) Host. Default `"127.0.0.1"`.
---@return SOCKET # self
function SOCKET:SetHost(Host) end

---Send a table.
---@param Table? table Table to send.
---@return SOCKET # self
function SOCKET:SendTable(Table) end

---Send a text message.
---@param Text? string Text message.
---@return SOCKET # self
function SOCKET:SendText(Text) end

---Send a text-to-speech message.
---@param Text? string The text message to speek.
---@param Provider? number (Optional) The TTS provider: 0=Microsoft (default), 1=Google.
---@param Voice? string The specific voice to use, e.g. `"Microsoft David Desktop"` or "`en-US-Standard-A`". If not set, the service will choose a voice based on the other parameters such as culture and gender.
---@param Culture? string The Culture or language code, *e.g.* `"en-US"`.
---@param Gender? string (Optional) The Gender, *i.e.* "male", "female". Default "female".
---@param Volume? number (Optional) The volume. Microsoft: [0,100] default 50, Google: [-96, 10] default 0.
---@return SOCKET # self
function SOCKET:SendTextToSpeech(Text, Provider, Voice, Culture, Gender, Volume) end
