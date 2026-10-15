---@meta

---@class NET.PlayerData
---@field name string
---@field ucid string
---@field id number
---@field side number
---@field slot number
---@field timestamp numner

---The NET class
---@class NET : FSM
---@field ClassName string
---@field Version string
---@field lid string
---@field BlockTime number
---@field BlockedPilots table
---@field KnownPilots table
---@field BlockMessage string
---@field UnblockMessage string
---@field BlockedUCIDs table
---@field BlockedSlots table
---@field BlockedSides table
NET = {
  ClassName = "NET",
  Version = "0.1.4",
  BlockTime = 600,
  BlockedPilots = {},
  BlockedUCIDs = {},
  BlockedSides = {},
  BlockedSlots = {},
  KnownPilots = {},
  BlockMessage = nil,
  UnblockMessage = nil,
  lid = nil,
}

---Instantiate a new NET object.
---@return NET # self
function NET:New() end

---[Internal] Check any blockers
---@param UCID? string
---@param Name? string
---@param PlayerID? number
---@param PlayerSide? number
---@param PlayerSlot? string
---@return boolean # IsBlocked
function NET:IsAnyBlocked(UCID, Name, PlayerID, PlayerSide, PlayerSlot) end

---[Internal] Event Handler
---@param EventData? EVENTDATA
---@return NET # self
function NET:_EventHandler(EventData) end

---Block a player.
---@param Client? CLIENT CLIENT object.
---@param PlayerName? string (optional) Name of the player.
---@param Seconds? number (optional) Number of seconds the player has to wait before rejoining.
---@param Message? string (optional) Message to be sent via chat.
---@return NET # self
function NET:BlockPlayer(Client, PlayerName, Seconds, Message) end

---Block a SET_CLIENT of players
---@param PlayerSet? SET_CLIENT The SET to block.
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@param Message? string (optional) Message to be sent via chat.
---@return NET # self
function NET:BlockPlayerSet(PlayerSet, Seconds, Message) end

---Unblock a SET_CLIENT of players
---@param PlayerSet? SET_CLIENT The SET to unblock.
---@param Message? string (optional) Message to be sent via chat.
---@return NET # self
function NET:UnblockPlayerSet(PlayerSet, Message) end

---Block a specific UCID of a player, does NOT automatically kick the player with the UCID if already joined.
---@param ucid? string
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@return NET # self
function NET:BlockUCID(ucid, Seconds) end

---Unblock a specific UCID of a player
---@param ucid? string
---@return NET # self
function NET:UnblockUCID(ucid) end

---Block a specific coalition side, does NOT automatically kick all players of that side or kick out joined players
---@param Side? number The side to block - 1 : Red, 2 : Blue
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@return NET # self
function NET:BlockSide(Side, Seconds) end

---Unblock a specific coalition side. Does NOT unblock specifically blocked playernames or UCIDs.
---@param Side? any
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@return NET # self
function NET:UnblockSide(Side, Seconds) end

---Block a specific player slot, does NOT automatically kick a player in that slot or kick out joined players
---@param Slot? any
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@return NET # self
function NET:BlockSlot(Slot, Seconds) end

---Unblock a specific slot.
---@param Slot? any
---@return NET # self
function NET:UnblockSlot(Slot) end

---Unblock a player.
---@param Client? CLIENT CLIENT object
---@param PlayerName? string (optional) Name of the player.
---@param Message? string (optional) Message to be sent via chat.
---@return NET # self
function NET:UnblockPlayer(Client, PlayerName, Message) end

---Set block chat message.
---@param Text? string The message
---@return NET # self
function NET:SetBlockMessage(Text) end

---Set block time in seconds.
---@param Seconds? number (Optional) Numnber of seconds this block will last. Defaults to 600.
---@return NET # self
function NET:SetBlockTime(Seconds) end

---Set unblock chat message.
---@param Text? string The message
---@return NET # self
function NET:SetUnblockMessage(Text) end

---Send chat message.
---@param Message? string Message to send
---@param ToAll? boolean (Optional)
---@return NET # self
function NET:SendChat(Message, ToAll) end

---Find the PlayerID by name
---@param Name? string The player name whose ID to find
---@return number # PlayerID or nil
function NET:GetPlayerIDByName(Name) end

---Find the PlayerID from a CLIENT object.
---@param Client? CLIENT The client
---@return number # PlayerID or nil
function NET:GetPlayerIDFromClient(Client) end

---Send chat message to a specific player using the CLIENT object.
---@param Message? string The text message
---@param ToClient? CLIENT Client receiving the message
---@param FromClient? CLIENT (Optional) Client sending the message
---@return NET # self
function NET:SendChatToClient(Message, ToClient, FromClient) end

---Send chat message to a specific player using the player name
---@param Message? string The text message
---@param ToPlayer? string Player receiving the message
---@param FromPlayer? string (Optional) Player sending the message
---@return NET # self
function NET:SendChatToPlayer(Message, ToPlayer, FromPlayer) end

---[[ not in 2.97 MSE any longer
---Load a specific mission.
---@param Path? string and Mission
---@return boolean # success
function NET:LoadMission(Path) end

---Load next mission. Returns false if at the end of list.
---@return boolean # success
function NET:LoadNextMission() end

---Return a table of players currently connected to the server.
---@return table # PlayerList
function NET:GetPlayerList() end

---Returns the playerID of the local player. Always returns 1 for server.
---@return number # ID
function NET:GetMyPlayerID() end

---Returns the playerID of the server. Currently always returns 1.
---@return number # ID
function NET:GetServerID() end

---Return a table of attributes for a given client. If optional attribute is present, only that value is returned.
---@param Client? CLIENT The client.
---@param Attribute? string (Optional) The attribute to obtain. List see below.
---@return table # PlayerInfo or nil if it cannot be found
function NET:GetPlayerInfo(Client, Attribute) end

---Get player UCID from player CLIENT object or player name. Provide either one.
---@param Client? CLIENT The client object to be used.
---@param Name? string Player name to be used.
---@return boolean # success
function NET:GetPlayerUCID(Client, Name) end

---Kicks a player from the server. Can display a message to the user.
---@param Client? CLIENT The client
---@param Message? string (Optional) The message to send.
---@return boolean # success
function NET:Kick(Client, Message) end

---Return a statistic for a given client.
---@param Client? CLIENT The client
---@param StatisticID? number The statistic to obtain
---@return number # Statistic or nil
function NET:GetPlayerStatistic(Client, StatisticID) end

---Return the name of a given client. Effectively the same as CLIENT:GetPlayerName().
---@param Client? CLIENT The client
---@return string # Name or nil if not obtainable
function NET:GetName(Client) end

---Returns the SideId and SlotId of a given client.
---@param Client? CLIENT The client
---@return number # SideID i.e. 0 : spectators, 1 : Red, 2 : Blue
---@return number # SlotID
function NET:GetSlot(Client) end

---Force the slot for a specific client. If this returns false, it didn't work via `net` (which is ALWAYS the case as of Nov 2024)!
---@param Client? CLIENT The client
---@param SideID? number i.e. 0 : spectators, 1 : Red, 2 : Blue
---@param SlotID? number Slot number
---@return boolean # Success
function NET:ForceSlot(Client, SideID, SlotID) end

---Force a client back to spectators. If this returns false, it didn't work via `net` (which is ALWAYS the case as of Nov 2024)!
---@param Client? CLIENT The client
---@return boolean # Succes
function NET:ReturnToSpectators(Client) end

---Converts a lua value to a JSON string.
---@param Lua? string Anything lua
---@return table # Json
function NET.Lua2Json(Lua) end

---Converts a JSON string to a lua value.
---@param Json? string Anything JSON
---@return table # Lua
function NET.Json2Lua(Json) end

---Executes a lua string in a given lua environment in the game.
---@param State? string The state in which to execute - see below.
---@param DoString? string The lua string to be executed.
---@return string # Output
function NET:DoStringIn(State, DoString) end

--- Write an "INFO" entry to the DCS log file, with the message Message.
---@param Message? string The message to be logged.
---@return NET # self
function NET:Log(Message) end

--- Get some data of pilots who have currently joined
---@param Client? CLIENT Provide either the client object whose data to find **or**
---@param Name? string The player name whose data to find
---@return table # Table of #NET.PlayerData or nil if not found
function NET:GetKnownPilotData(Client, Name) end

--- Status - housekeeping
---@param From? string
---@param Event? string
---@param To? string
---@return NET # self
function NET:onafterStatus(From, Event, To) end

--- Stop the event functions
---@param From? string
---@param Event? string
---@param To? string
---@return NET # self
function NET:onafterRun(From, Event, To) end

--- Stop the event functions
---@param From? string
---@param Event? string
---@param To? string
---@return NET # self
function NET:onafterStop(From, Event, To) end

---FSM Function OnAfterPlayerJoined.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Client? CLIENT Object.
---@param Name? string Name of joining Pilot.
---@return NET # self
function NET:OnAfterPlayerJoined(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerLeft.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Client? UNIT Unit Object, might be nil.
---@param Name? string Name of leaving Pilot.
---@return NET # self
function NET:OnAfterPlayerLeft(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerEjected.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Client? UNIT Unit Object, might be nil.
---@param Name? string Name of leaving Pilot.
---@return NET # self
function NET:OnAfterPlayerEjected(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerDied.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Client? UNIT Unit Object, might be nil.
---@param Name? string Name of dead Pilot.
---@return NET # self
function NET:OnAfterPlayerDied(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerBlocked.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Client? CLIENT Client Object, might be nil.
---@param Name? string Name of blocked Pilot.
---@param Seconds? number Blocked for this number of seconds
---@return NET # self
function NET:OnAfterPlayerBlocked(From, Event, To, Client, Name, Seconds) end

---FSM Function OnAfterPlayerUnblocked.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Client? CLIENT Client Object, might be nil.
---@param Name? string Name of unblocked Pilot.
---@return NET # self
function NET:OnAfterPlayerUnblocked(From, Event, To, Client, Name) end
