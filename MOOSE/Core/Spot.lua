---@meta

---@class SPOT : FSM
SPOT = {
  ClassName = "SPOT",
}

---SPOT Constructor.
---@param Recce? UNIT Unit that is lasing
---@return SPOT
function SPOT:New(Recce) end

---On after LaseOn event. Activates the laser spot.
---@param From? any
---@param Event? any
---@param To? any
---@param Target? POSITIONABLE Unit that is being lased.
---@param LaserCode? number Laser code.
---@param Duration? number Duration of lasing in seconds.
function SPOT:onafterLaseOn(From, Event, To, Target, LaserCode, Duration) end

---On after LaseOnCoordinate event. Activates the laser spot.
---@param From? any
---@param Event? any
---@param To? any
---@param Coordinate? COORDINATE The coordinate at which the laser is pointing.
---@param LaserCode? number Laser code.
---@param Duration? number Duration of lasing in seconds.
function SPOT:onafterLaseOnCoordinate(From, Event, To, Coordinate, LaserCode, Duration) end

---@param EventData? EVENTDATA
function SPOT:OnEventDead(EventData) end

---@param From? any
---@param Event? any
---@param To? any
function SPOT:onafterLasing(From, Event, To) end

---@param From? any
---@param Event? any
---@param To? any
---@return SPOT
function SPOT:onafterLaseOff(From, Event, To) end

---Check if the SPOT is lasing
---@return boolean # true if it is lasing
function SPOT:IsLasing() end

---Set laser start position relative to the lasing unit.
---@param position? table (Optional) Start position of the laser relative to the lasing unit. Default is { x = 0, y = 2, z = 0 }
---@return SPOT # self
function SPOT:SetRelativeStartPosition(position) end

---LaseOn Handler OnBefore for SPOT
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function SPOT:OnBeforeLaseOn(From, Event, To) end

---LaseOn Handler OnAfter for SPOT
---@param From? string
---@param Event? string
---@param To? string
function SPOT:OnAfterLaseOn(From, Event, To) end

---LaseOn Trigger for SPOT
---@param Target? POSITIONABLE
---@param LaserCode? number Laser code.
---@param Duration? number Duration of lasing in seconds.
function SPOT:LaseOn(Target, LaserCode, Duration) end

---LaseOn Asynchronous Trigger for SPOT
---@param Delay? number
---@param Target? POSITIONABLE
---@param LaserCode? number Laser code.
---@param Duration? number Duration of lasing in seconds.
function SPOT:__LaseOn(Delay, Target, LaserCode, Duration) end

---LaseOnCoordinate Handler OnBefore for SPOT.
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function SPOT:OnBeforeLaseOnCoordinate(From, Event, To) end

---LaseOnCoordinate Handler OnAfter for SPOT.
---@param From? string
---@param Event? string
---@param To? string
function SPOT:OnAfterLaseOnCoordinate(From, Event, To) end

---LaseOnCoordinate Trigger for SPOT.
---@param Coordinate? COORDINATE The coordinate to lase.
---@param LaserCode? number Laser code.
---@param Duration? number Duration of lasing in seconds.
function SPOT:LaseOnCoordinate(Coordinate, LaserCode, Duration) end

---LaseOn Asynchronous Trigger for SPOT
---@param Delay? number
---@param Target? POSITIONABLE
---@param LaserCode? number Laser code.
---@param Duration? number Duration of lasing in seconds.
function SPOT:__LaseOn(Delay, Target, LaserCode, Duration) end

---LaseOff Handler OnBefore for SPOT
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function SPOT:OnBeforeLaseOff(From, Event, To) end

---LaseOff Handler OnAfter for SPOT
---@param From? string
---@param Event? string
---@param To? string
function SPOT:OnAfterLaseOff(From, Event, To) end

---LaseOff Trigger for SPOT
function SPOT:LaseOff() end

---LaseOff Asynchronous Trigger for SPOT
---@param Delay? number
function SPOT:__LaseOff(Delay) end

---Destroyed Handler OnBefore for SPOT
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function SPOT:OnBeforeDestroyed(From, Event, To) end

---Destroyed Handler OnAfter for SPOT
---@param From? string
---@param Event? string
---@param To? string
function SPOT:OnAfterDestroyed(From, Event, To) end

---Destroyed Trigger for SPOT
function SPOT:Destroyed() end

---Destroyed Asynchronous Trigger for SPOT
---@param Delay? number
function SPOT:__Destroyed(Delay) end
