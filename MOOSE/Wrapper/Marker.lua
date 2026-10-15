---@meta

---Marker class.
---@class MARKER : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode. Messages to all about status.
---@field lid string Class id string for output to DCS log file.
---@field mid number Marker ID.
---@field coordinate COORDINATE Coordinate of the mark.
---@field text string Text displayed in the mark panel.
---@field message string Message displayed when the mark is added.
---@field readonly boolean Marker is read-only.
---@field coalition number Coalition to which the marker is displayed.
MARKER = {
  ClassName = "MARKER",
  Debug = false,
  lid = nil,
  mid = nil,
  coordinate = nil,
  text = nil,
  message = nil,
  readonly = nil,
  coalition = nil,
}

---Marker class version.
MARKER.version = "0.1.1"

---Create a new MARKER class object.
---@param Coordinate? COORDINATE Coordinate where to place the marker.
---@param Text? string Text displayed on the mark panel.
---@return MARKER # self
function MARKER:New(Coordinate, Text) end

---Marker is readonly. Text cannot be changed and marker cannot be removed. The will not update the marker in the game, Call MARKER:Refresh to update state.
---@return MARKER # self
function MARKER:ReadOnly() end

---Marker is read and write. Text cannot be changed and marker cannot be removed. The will not update the marker in the game, Call MARKER:Refresh to update state.
---@return MARKER # self
function MARKER:ReadWrite() end

---Set message that is displayed on screen if the marker is added.
---@param Text? string Message displayed when the marker is added.
---@return MARKER # self
function MARKER:Message(Text) end

---Place marker visible for everyone.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:ToAll(Delay) end

---Place marker visible for a specific coalition only.
---@param Coalition? number Coalition 1=Red, 2=Blue, 0=Neutral. See `coalition.side.RED`.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:ToCoalition(Coalition, Delay) end

---Place marker visible for the blue coalition only.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:ToBlue(Delay) end

---Place marker visible for the blue coalition only.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:ToRed(Delay) end

---Place marker visible for the neutral coalition only.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:ToNeutral(Delay) end

---Place marker visible for a specific group only.
---@param Group? GROUP The group to which the marker is displayed.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:ToGroup(Group, Delay) end

---Update the text displayed on the mark panel.
---@param Text? string Updated text.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:UpdateText(Text, Delay) end

---Update the coordinate where the marker is displayed.
---@param Coordinate? COORDINATE The new coordinate.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:UpdateCoordinate(Coordinate, Delay) end

---Refresh the marker.
---@param Delay? number (Optional) Delay in seconds, before the marker is created.
---@return MARKER # self
function MARKER:Refresh(Delay) end

---Remove a marker.
---@param Delay? number (Optional) Delay in seconds, before the marker is removed.
---@return MARKER # self
function MARKER:Remove(Delay) end

---Get position of the marker.
---@return COORDINATE # The coordinate of the marker.
function MARKER:GetCoordinate() end

---Get text that is displayed in the marker panel.
---@return string # Marker text.
function MARKER:GetText() end

---Set text that is displayed in the marker panel. Note this does not show the marker.
---@param Text? any
---@return MARKER # self
function MARKER:SetText(Text) end

---Check if marker is currently visible on the F10 map.
---@return boolean # True if the marker is currently visible.
function MARKER:IsVisible() end

---Check if marker is currently invisible on the F10 map.
function MARKER:IsInvisible() end

---Event function when a MARKER is added.
---@param EventData? EVENTDATA
function MARKER:OnEventMarkAdded(EventData) end

---Event function when a MARKER is removed.
---@param EventData? EVENTDATA
function MARKER:OnEventMarkRemoved(EventData) end

---Event function when a MARKER changed.
---@param EventData? EVENTDATA
function MARKER:OnEventMarkChange(EventData) end

---On after "Added" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param EventData? EVENTDATA Event data table.
function MARKER:onafterAdded(From, Event, To, EventData) end

---On after "Removed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param EventData? EVENTDATA Event data table.
function MARKER:onafterRemoved(From, Event, To, EventData) end

---On after "Changed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param EventData? EVENTDATA Event data table.
function MARKER:onafterChanged(From, Event, To, EventData) end

---On after "TextUpdate" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Text? string The updated text, displayed in the mark panel.
function MARKER:onafterTextUpdate(From, Event, To, Text) end

---On after "CoordUpdate" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? COORDINATE The updated coordinates.
function MARKER:onafterCoordUpdate(From, Event, To, Coordinate) end

---Triggers the FSM event "Added".
---@param EventData? EVENTDATA Event data table.
function MARKER:Added(EventData) end

---Triggers the delayed FSM event "Added".
---@param EventData? EVENTDATA Event data table.
function MARKER:__Added(EventData) end

---On after "Added" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param EventData? EVENTDATA Event data table.
function MARKER:OnAfterAdded(From, Event, To, EventData) end

---Triggers the FSM event "Removed".
---@param EventData? EVENTDATA Event data table.
function MARKER:Removed(EventData) end

---Triggers the delayed FSM event "Removed".
---@param EventData? EVENTDATA Event data table.
function MARKER:__Removed(EventData) end

---On after "Removed" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param EventData? EVENTDATA Event data table.
function MARKER:OnAfterRemoved(From, Event, To, EventData) end

---Triggers the FSM event "Changed".
---@param EventData? EVENTDATA Event data table.
function MARKER:Changed(EventData) end

---Triggers the delayed FSM event "Changed".
---@param EventData? EVENTDATA Event data table.
function MARKER:__Changed(EventData) end

---On after "Changed" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param EventData? EVENTDATA Event data table.
function MARKER:OnAfterChanged(From, Event, To, EventData) end

---Triggers the FSM event "TextUpdate".
---@param Text? string The new text.
function MARKER:TextUpdate(Text) end

---Triggers the delayed FSM event "TextUpdate".
---@param Text? string The new text.
function MARKER:__TextUpdate(Text) end

---On after "TextUpdate" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Text? string The new text.
function MARKER:OnAfterTextUpdate(From, Event, To, Text) end

---Triggers the FSM event "CoordUpdate".
---@param Coordinate? COORDINATE The new Coordinate.
function MARKER:CoordUpdate(Coordinate) end

---Triggers the delayed FSM event "CoordUpdate".
---@param Coordinate? COORDINATE The updated Coordinate.
function MARKER:__CoordUpdate(Coordinate) end

---On after "CoordUpdate" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? COORDINATE The updated Coordinate.
function MARKER:OnAfterCoordUpdate(From, Event, To, Coordinate) end
