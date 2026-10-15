---@meta

---@class SCHEDULEDISPATCHER.ScheduleData
---@field Function function The schedule function to be called.
---@field Arguments table Schedule function arguments.
---@field Start number Start time in seconds.
---@field Repeat number Repeat time interval in seconds.
---@field Randomize number Randomization factor [0,1].
---@field Stop number Stop time in seconds.
---@field StartTime number Time in seconds when the scheduler is created.
---@field ScheduleID number Schedule ID.
---@field CallHandler function Function to be passed to the DCS timer.scheduleFunction().
---@field ShowTrace boolean If true, show tracing info.

---SCHEDULEDISPATCHER class.
---@class SCHEDULEDISPATCHER : BASE
---@field ClassName string Name of the class.
---@field CallID number Call ID counter.
---@field PersistentSchedulers table Persistent schedulers.
---@field ObjectSchedulers table Schedulers that only exist as long as the master object exists.
---@field Schedule table Meta table setmetatable( {}, { __mode = "k" } ).
SCHEDULEDISPATCHER = {
  ClassName = "SCHEDULEDISPATCHER",
  CallID = 0,
  PersistentSchedulers = {},
  ObjectSchedulers = {},
  Schedule = nil,
}

---Create a new schedule dispatcher object.
---@return SCHEDULEDISPATCHER # self
function SCHEDULEDISPATCHER:New() end

---Add a Schedule to the ScheduleDispatcher.
---The development of this method was really tidy.
---It is constructed as such that a garbage collection is executed on the weak tables, when the Scheduler is set to nil.
---Nothing of this code should be modified without testing it thoroughly.
---@param Scheduler? SCHEDULER Scheduler object.
---@param ScheduleFunction? function Scheduler function.
---@param ScheduleArguments? table Table of arguments passed to the ScheduleFunction.
---@param Start? number Start time in seconds.
---@param Repeat? number Repeat interval in seconds.
---@param Randomize? number Randomization factor [0,1].
---@param Stop? number Stop time in seconds.
---@param TraceLevel? number Trace level [0,3].
---@param Fsm? FSM Finite state model.
---@return string # Call ID or nil.
function SCHEDULEDISPATCHER:AddSchedule(Scheduler, ScheduleFunction, ScheduleArguments, Start, Repeat, Randomize, Stop, TraceLevel, Fsm) end

---Remove schedule.
---@param Scheduler? SCHEDULER Scheduler object.
---@param CallID? table Call ID.
function SCHEDULEDISPATCHER:RemoveSchedule(Scheduler, CallID) end

---Start dispatcher.
---@param Scheduler? SCHEDULER Scheduler object.
---@param CallID? table (Optional) Call ID.
---@param Info? string (Optional) Debug info.
function SCHEDULEDISPATCHER:Start(Scheduler, CallID, Info) end

---Stop dispatcher.
---@param Scheduler? SCHEDULER Scheduler object.
---@param CallID? string (Optional) Scheduler Call ID. If nil, all pending schedules are stopped recursively.
function SCHEDULEDISPATCHER:Stop(Scheduler, CallID) end

---Clear all schedules by stopping all dispatchers.
---@param Scheduler? SCHEDULER Scheduler object.
function SCHEDULEDISPATCHER:Clear(Scheduler) end

---Show tracing info.
---@param Scheduler? SCHEDULER Scheduler object.
function SCHEDULEDISPATCHER:ShowTrace(Scheduler) end

---No tracing info.
---@param Scheduler? SCHEDULER Scheduler object.
function SCHEDULEDISPATCHER:NoTrace(Scheduler) end

---Helper for memory cleanup for self stopping schedulers
---@param Scheduler? SCHEDULER Scheduler object.
---@param CallID? string (Optional) Scheduler Call ID.
function SCHEDULEDISPATCHER:_Reclaim(Scheduler, CallID) end
