---@meta

---MARKEROPS_BASE class.
---@class MARKEROPS_BASE : FSM
---@field ClassName string Name of the class.
---@field Tag string Tag to identify commands.
---@field Keywords table Table of keywords to recognize.
---@field version string Version of #MARKEROPS_BASE.
---@field Casesensitive boolean Enforce case when identifying the Tag, i.e. tag ~= Tag
MARKEROPS_BASE = {
  ClassName = "MARKEROPS",
  Tag = "mytag",
  Keywords = {},
  version = "0.1.5",
  debug = false,
  Casesensitive = true,
}

---Function to instantiate a new #MARKEROPS_BASE object.
---@param Tagname? string Name to identify us from the event text.
---@param Keywords? table Table of keywords  recognized from the event text.
---@return MARKEROPS_BASE # self
function MARKEROPS_BASE:New(Tagname, Keywords) end

---(Internal) Handle events.
---@param Event? EVENTDATA
function MARKEROPS_BASE:OnEventMark(Event) end

---(Internal) Match tag.
---@param Eventtext? string Text added to the marker.
---@return boolean
function MARKEROPS_BASE:_MatchTag(Eventtext) end

---(Internal) Match keywords table.
---@param Eventtext? string Text added to the marker.
---@return table
function MARKEROPS_BASE:_MatchKeywords(Eventtext) end

---On before "MarkAdded" event. Triggered when a Marker is added to the F10 map.
---@param From? string The From state
---@param Event? string The Event called
---@param To? string The To state
---@param Text? string The text on the marker
---@param Keywords? table Table of matching keywords found in the Event text
---@param Coord? COORDINATE Coordinate of the marker.
---@param MarkerID? number Id of this marker
---@param CoalitionNumber? number Coalition of the marker creator
function MARKEROPS_BASE:onbeforeMarkAdded(From, Event, To, Text, Keywords, Coord, MarkerID, CoalitionNumber) end

---On before "MarkChanged" event. Triggered when a Marker is changed on the F10 map.
---@param From? string The From state
---@param Event? string The Event called
---@param To? string The To state
---@param Text? string The text on the marker
---@param Keywords? table Table of matching keywords found in the Event text
---@param Coord? COORDINATE Coordinate of the marker.
---@param MarkerID? number Id of this marker
---@param CoalitionNumber? number Coalition of the marker creator
function MARKEROPS_BASE:onbeforeMarkChanged(From, Event, To, Text, Keywords, Coord, MarkerID, CoalitionNumber) end

---On before "MarkDeleted" event. Triggered when a Marker is removed from the F10 map.
---@param From? string The From state
---@param Event? string The Event called
---@param To? string The To state
function MARKEROPS_BASE:onbeforeMarkDeleted(From, Event, To) end

---On enter "Stopped" event. Unsubscribe events.
---@param From? string The From state
---@param Event? string The Event called
---@param To? string The To state
function MARKEROPS_BASE:onenterStopped(From, Event, To) end

---Switch off case sensitive matching
---@return self
function MARKEROPS_BASE:SwitchCaseSensitiveOff() end

---Switch on case sensitive matching
---@return self
function MARKEROPS_BASE:SwitchCaseSensitiveOn() end

---On after "MarkAdded" event. Triggered when a Marker is added to the F10 map.
---@param From? string The From state.
---@param Event? string The Event called.
---@param To? string The To state.
---@param Text? string The text on the marker.
---@param Keywords? table Table of matching keywords found in the Event text.
---@param Coord? COORDINATE Coordinate of the marker.
---@param MarkerID? number Id of this marker.
---@param CoalitionNumber? number Coalition of the marker creator.
---@param PlayerName? string Name of the player creating/changing the mark. nil if it cannot be obtained.
---@param EventData? EVENTDATA the event data table.
function MARKEROPS_BASE:OnAfterMarkAdded(From, Event, To, Text, Keywords, Coord, MarkerID, CoalitionNumber, PlayerName, EventData) end

---On after "MarkChanged" event. Triggered when a Marker is changed on the F10 map.
---@param From? string The From state.
---@param Event? string The Event called.
---@param To? string The To state.
---@param Text? string The text on the marker.
---@param Keywords? table Table of matching keywords found in the Event text.
---@param Coord? COORDINATE Coordinate of the marker.
---@param MarkerID? number Id of this marker.
---@param CoalitionNumber? number Coalition of the marker creator.
---@param PlayerName? string Name of the player creating/changing the mark. nil if it cannot be obtained.
---@param EventData? EVENTDATA the event data table
function MARKEROPS_BASE:OnAfterMarkChanged(From, Event, To, Text, Keywords, Coord, MarkerID, CoalitionNumber, PlayerName, EventData) end

---On after "MarkDeleted" event. Triggered when a Marker is deleted from the F10 map.
---@param From? string The From state
---@param Event? string The Event called
---@param To? string The To state
function MARKEROPS_BASE:OnAfterMarkDeleted(From, Event, To) end

---"Stop" trigger. Used to stop the function an unhandle events
function MARKEROPS_BASE:Stop() end
