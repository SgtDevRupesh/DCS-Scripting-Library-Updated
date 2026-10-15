---@meta

---@class MOVEMENT : BASE
MOVEMENT = {
	ClassName = "MOVEMENT",
}

---@param MovePrefixes? any
---@param MoveMaximum? any
function MOVEMENT:New(MovePrefixes, MoveMaximum) end

---Call this function to start the MOVEMENT scheduling.
function MOVEMENT:ScheduleStart() end

---Call this function to stop the MOVEMENT scheduling.
function MOVEMENT:ScheduleStop() end

---Captures the birth events when new Units were spawned.
---@param EventData? any
function MOVEMENT:OnEventBirth(EventData) end

---Captures the Dead or Crash events when Units crash or are destroyed.
---@param Event? any
function MOVEMENT:OnDeadOrCrash(Event) end

---This function is called automatically by the MOVEMENT scheduler. A new function is scheduled when MoveScheduled is true.
function MOVEMENT:_Scheduler() end
