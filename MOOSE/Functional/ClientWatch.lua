---@meta

---CLIENTWATCH class
---@class CLIENTWATCH : FSM_CONTROLLABLE
---@field ClassName string Name of the class.
---@field Debug boolean Write Debug messages to DCS log file and send Debug messages to all players.
---@field lid string String for DCS log file.
---@field FilterCoalition number If not nil, will only activate for aircraft of the given coalition value.
---@field FilterCategory number If not nil, will only activate for aircraft of the given category value.
CLIENTWATCH = {}

CLIENTWATCH.ClassName = "CLIENTWATCH"

CLIENTWATCH.Debug = false

CLIENTWATCH.DebugEventData = false

---@class CLIENTWATCHTools
---@field Unit table Wrapper.UNIT of the cient object
---@field Group table Wrapper.GROUP of the cient object
---@field Client table Wrapper.CLIENT of the cient object
---@field PlayerName string Name of the player controlling the client object
---@field UnitName string Name of the unit that is the client object
---@field GroupName string Name of the group the client object belongs to
CLIENTWATCHTools = {}

---CLIENTWATCH version
CLIENTWATCH.version = "1.0.1"

---Creates a new instance of CLIENTWATCH to add scripts to. Can be used multiple times with the same client/prefixes if you need it for multiple scripts.
---@param client? any
---@return CLIENTWATCH # self
function CLIENTWATCH:New(client) end

---Filter out all clients not belonging to the provided coalition
---@param value? any
function CLIENTWATCH:FilterByCoalition(value) end

---Filter out all clients that are not of the given category
---@param value? any
function CLIENTWATCH:FilterByCategory(value) end

---Internal function for creating a new client on birth. Do not use!!!.
---@param clientWatchDebug? any
---@param eventdata? any
---@return CLIENTWATCHTools # self
function CLIENTWATCHTools:_newClient(clientWatchDebug, eventdata) end

---User function for OnAfter "Spawn" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param clientObject? table Custom object that handles events and stores Moose object data. See top documentation for more details.
---@param eventdata? table Data from EVENTS.Birth.
function CLIENTWATCH:OnAfterSpawn(Controllable, From, Event, To, clientObject, eventdata) end
