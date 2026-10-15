---@meta

---The SCHEDULER class
---@class SCHEDULER : BASE
---@field Schedules table Table of schedules.
---@field MasterObject table Master object.
---@field ShowTrace boolean Trace info if true.
SCHEDULER = {
  ClassName = "SCHEDULER",
  Schedules = {},
  MasterObject = nil,
  ShowTrace = nil,
}

---SCHEDULER constructor.
---@param MasterObject? table Specified for which Moose object the timer is setup. If a value of nil is provided, a scheduler will be setup without an object reference.
---@param SchedulerFunction? function The event function to be called when a timer event occurs. The event function needs to accept the parameters specified in SchedulerArguments.
---@param SchedulerArguments? table Optional arguments that can be given as part of scheduler. The arguments need to be given as a table { param1, param 2, ... }.
---@param Start? number Specifies the amount of seconds that will be waited before the scheduling is started, and the event function is called.
---@param Repeat? number Specifies the interval in seconds when the scheduler will call the event function.
---@param RandomizeFactor? number Specifies a randomization factor between 0 and 1 to randomize the Repeat.
---@param Stop? number Specifies the amount of seconds when the scheduler will be stopped.
---@return SCHEDULER # self.
---@return string # The ScheduleID of the planned schedule.
function SCHEDULER:New(MasterObject, SchedulerFunction, SchedulerArguments, Start, Repeat, RandomizeFactor, Stop) end

---Schedule a new time event. Note that the schedule will only take place if the scheduler is *started*. Even for a single schedule event, the scheduler needs to be started also.
---@param MasterObject? table Specified for which Moose object the timer is setup. If a value of nil is provided, a scheduler will be setup without an object reference.
---@param SchedulerFunction? function The event function to be called when a timer event occurs. The event function needs to accept the parameters specified in SchedulerArguments.
---@param SchedulerArguments? table Optional arguments that can be given as part of scheduler. The arguments need to be given as a table { param1, param 2, ... }.
---@param Start? number Specifies the amount of seconds that will be waited before the scheduling is started, and the event function is called.
---@param Repeat? number Specifies the time interval in seconds when the scheduler will call the event function.
---@param RandomizeFactor? number Specifies a randomization factor between 0 and 1 to randomize the Repeat.
---@param Stop? number Time interval in seconds after which the scheduler will be stopped.
---@param TraceLevel? number (Optional) Trace level [0,3]. Default 3.
---@param Fsm? FSM Finite state model.
---@return string # The Schedule ID of the planned schedule.
function SCHEDULER:Schedule(MasterObject, SchedulerFunction, SchedulerArguments, Start, Repeat, RandomizeFactor, Stop, TraceLevel, Fsm) end

---(Re-)Starts the schedules or a specific schedule if a valid ScheduleID is provided.
---@param ScheduleID? string (Optional) The Schedule ID of the planned (repeating) schedule.
function SCHEDULER:Start(ScheduleID) end

---Stops the schedules or a specific schedule if a valid ScheduleID is provided.
---@param ScheduleID? string (Optional) The ScheduleID of the planned (repeating) schedule.
function SCHEDULER:Stop(ScheduleID) end

---Removes a specific schedule if a valid ScheduleID is provided.
---@param ScheduleID? string (optional) The ScheduleID of the planned (repeating) schedule.
function SCHEDULER:Remove(ScheduleID) end

---Clears all pending schedules.
function SCHEDULER:Clear() end

---Show tracing for this scheduler.
function SCHEDULER:ShowTrace() end

---No tracing for this scheduler.
function SCHEDULER:NoTrace() end
