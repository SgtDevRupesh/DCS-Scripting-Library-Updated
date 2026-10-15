---@meta

---The CLIENT class
---@class CLIENT : UNIT
---@field ClassName string Name of the class.
---@field ClientName string Name of the client.
---@field ClientBriefing string Briefing.
---@field ClientCallBack function Callback function.
---@field ClientParameters table Parameters of the callback function.
---@field ClientGroupID number Group ID of the client.
---@field ClientGroupName string Group name.
---@field ClientAlive boolean Client alive.
---@field ClientAlive2 boolean Client alive 2.
---@field Players table Player table.
---@field SpawnCoord COORDINATE Spawn coordinate from the template.
CLIENT = {
  ClassName = "CLIENT",
  ClientName = nil,
  ClientAlive = false,
  ClientTransport = false,
  ClientBriefingShown = false,
  _Menus = {},
  _Tasks = {},
  Messages = {},
  Players = {},
}

---Finds a CLIENT from the _DATABASE using the relevant DCS Unit.
---@param DCSUnit? Unit The DCS unit of the client.
---@param Error? boolean Throw an error message.
---@return CLIENT # The CLIENT found in the _DATABASE.
function CLIENT:Find(DCSUnit, Error) end

---Finds a CLIENT from the _DATABASE using the relevant player name.
---@param Name? string Name of the player
---@return CLIENT # or nil if not found
function CLIENT:FindByPlayerName(Name) end

---Finds a CLIENT from the _DATABASE using the relevant Client Unit Name.
---As an optional parameter, a briefing text can be given also.
---@param ClientName? string Name of the DCS **Unit** as defined within the Mission Editor.
---@param ClientBriefing? string Text that describes the briefing of the mission when a Player logs into the Client.
---@param Error? boolean (Optional) A flag that indicates whether an error should be raised if the CLIENT cannot be found. By default an error will be raised.
---@return CLIENT
function CLIENT:FindByName(ClientName, ClientBriefing, Error) end

---Register a client.
---@param ClientName? string Name of the client unit.
---@return CLIENT # self
function CLIENT:Register(ClientName) end

---Transport defines that the Client is a Transport. Transports show cargo.
---@return CLIENT # self
function CLIENT:Transport() end

---Adds a briefing to a CLIENT when a player joins a mission.
---@param ClientBriefing? string is the text defining the Mission briefing.
---@return CLIENT # self
function CLIENT:AddBriefing(ClientBriefing) end

---Add player name.
---@param PlayerName? string Name of the player.
---@return CLIENT # self
function CLIENT:AddPlayer(PlayerName) end

---Get number of associated players.
---@return number # Count
function CLIENT:CountPlayers() end

---Get player name(s).
---@return table # List of player names or an empty table `{}`.
function CLIENT:GetPlayers() end

---Get name of player.
---@return string # Player name or `nil`.
function CLIENT:GetPlayer() end

---Remove player.
---@param PlayerName? string Name of the player.
---@return CLIENT # self
function CLIENT:RemovePlayer(PlayerName) end

---Remove all players.
---@return CLIENT # self
function CLIENT:RemovePlayers() end

---Show the briefing of a CLIENT.
---@return CLIENT # self
function CLIENT:ShowBriefing() end

---Show the mission briefing of a MISSION to the CLIENT.
---@param MissionBriefing? string
---@return CLIENT # self
function CLIENT:ShowMissionBriefing(MissionBriefing) end

---Resets a CLIENT.
---@param ClientName? string Name of the Group as defined within the Mission Editor. The Group must have a Unit with the type Client.
function CLIENT:Reset(ClientName) end

---Checks if the CLIENT is a multi-seated UNIT.
---@return boolean # true if multi-seated.
function CLIENT:IsMultiSeated() end

---Checks for a client alive event and calls a function on a continuous basis. Does **NOT** work for dynamic spawn client slots!
---@param CallBackFunction? function Create a function that will be called when a player joins the slot.
---@param ... any
---@return CLIENT
function CLIENT:Alive(CallBackFunction, ...) end

---@param SchedulerName? any
function CLIENT:_AliveCheckScheduler(SchedulerName) end

---Return the DCSGroup of a Client.
---This function is modified to deal with a couple of bugs in DCS 1.5.3
---@return Group # The group of the Client.
function CLIENT:GetDCSGroup() end

---Get the group ID of the client.
---@return number # DCS#Group ID.
function CLIENT:GetClientGroupID() end

---Get the name of the group of the client.
---@return string
function CLIENT:GetClientGroupName() end

---Returns the UNIT of the CLIENT.
---@return UNIT # The client UNIT or `nil`.
function CLIENT:GetClientGroupUnit() end

---Returns the DCSUnit of the CLIENT.
---@return Unit
function CLIENT:GetClientGroupDCSUnit() end

---The main message driver for the CLIENT.
---This function displays various messages to the Player logged into the CLIENT through the DCS World Messaging system.
---@param Message? string is the text describing the message.
---@param MessageDuration? number is the duration in seconds that the Message should be displayed.
---@param MessageCategory? any is the category of the message (the title).
---@param MessageInterval? number is the interval in seconds between the display of the @{Core.Message#MESSAGE} when the CLIENT is in the air.
---@param MessageID? string is the identifier of the message when displayed with intervals.
function CLIENT:Message(Message, MessageDuration, MessageCategory, MessageInterval, MessageID) end

---[Multi-Player Server] Get UCID from a CLIENT.
---@return string # UCID
function CLIENT:GetUCID() end

---[Multi-Player Server] Return a table of attributes from CLIENT. If optional attribute is present, only that value is returned.
---@param Attribute? string (Optional) The attribute to obtain. List see below.
---@return table # PlayerInfo or nil if it cannot be found
function CLIENT:GetPlayerInfo(Attribute) end
