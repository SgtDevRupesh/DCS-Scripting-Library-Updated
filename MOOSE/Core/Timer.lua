---@meta

---TIMER class.
---@class TIMER : BASE
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field tid number Timer ID returned by the DCS API function.
---@field uid number Unique ID of the timer.
---@field func function Timer function.
---@field para table Parameters passed to the timer function.
---@field Tstart number Relative start time in seconds.
---@field Tstop number Relative stop time in seconds.
---@field dT number Time interval between function calls in seconds.
---@field ncalls number Counter of function calls.
---@field ncallsMax number Max number of function calls. If reached, timer is stopped.
---@field isrunning boolean If `true`, timer is running. Else it was not started yet or was stopped.
TIMER = {
  ClassName      = "TIMER",
  lid            =   nil,
}

---TIMER class version.
TIMER.version = "0.2.0"

---Create a new TIMER object.
---@param Function? function The function to call.
---@param ... any
---@return TIMER # self
function TIMER:New(Function, ...) end

---Start TIMER object.
---@param Tstart? number Relative start time in seconds.
---@param dT? number Interval between function calls in seconds. If not specified `nil`, the function is called only once.
---@param Duration? number Time in seconds for how long the timer is running. If not specified `nil`, the timer runs forever or until stopped manually by the `TIMER:Stop()` function.
---@return TIMER # self
function TIMER:Start(Tstart, dT, Duration) end

---Start TIMER object if a condition is met. Useful for e.g. debugging.
---@param Condition? boolean Must be true for the TIMER to start
---@param Tstart? number Relative start time in seconds.
---@param dT? number Interval between function calls in seconds. If not specified `nil`, the function is called only once.
---@param Duration? number Time in seconds for how long the timer is running. If not specified `nil`, the timer runs forever or until stopped manually by the `TIMER:Stop()` function.
---@return TIMER # self
function TIMER:StartIf(Condition, Tstart, dT, Duration) end

---Stop the timer by removing the timer function.
---@param Delay? number (Optional) Delay in seconds, before the timer is stopped.
---@return TIMER # self
function TIMER:Stop(Delay) end

---Set max number of function calls. When the function has been called this many times, the TIMER is stopped.
---@param Nmax? number Set number of max function calls.
---@return TIMER # self
function TIMER:SetMaxFunctionCalls(Nmax) end

---Set time interval. Can also be set when the timer is already running and is applied after the next function call.
---@param dT? number Time interval in seconds.
---@return TIMER # self
function TIMER:SetTimeInterval(dT) end

---Check if the timer has been started and was not stopped.
---@return boolean # If `true`, the timer is running.
function TIMER:IsRunning() end

---Call timer function.
---@param time? number DCS model time in seconds.
---@return number # Time when the function is called again or `nil` if the timer is stopped.
function TIMER:_Function(time) end
