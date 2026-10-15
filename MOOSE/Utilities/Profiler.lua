---@meta

---@class PROFILER.Data
---@field func string The function name.
---@field src string The source file.
---@field line number The line number
---@field count number Number of function calls.
---@field tm number Total time in seconds.

---PROFILER class.
---@class PROFILER
---@field ClassName string Name of the class.
---@field Counters table Function counters.
---@field dInfo table Info.
---@field fTime table Function time.
---@field fTimeTotal table Total function time.
---@field eventhandler table Event handler to get mission end event.
---@field TstartGame number Game start time timer.getTime().
---@field TstartOS number OS real start time os.clock.
---@field logUnknown boolean Log unknown functions. Default is off.
---@field ThreshCPS number Low calls per second threshold. Only write output if function has more calls per second than this value.
---@field ThreshTtot number Total time threshold. Only write output if total function CPU time is more than this value.
---@field fileNamePrefix string Output file name prefix, e.g. "MooseProfiler".
---@field fileNameSuffix string Output file name prefix, e.g. "txt"
PROFILER = {
  ClassName      = "PROFILER",
  Counters       = {},
  dInfo          = {},
  fTime          = {},
  fTimeTotal     = {},
  eventHandler   = {},
  logUnknown     = false,
  ThreshCPS      = 0.0,
  ThreshTtot     = 0.005,
  fileNamePrefix = "MooseProfiler",
  fileNameSuffix = "txt"
}

---Start profiler.
---@param Delay? number (Optional) Delay in seconds before profiler is stated. Default is immediately.
---@param Duration? number (Optional) Duration in (game) seconds before the profiler is stopped. Default is when mission ends.
function PROFILER.Start(Delay, Duration) end

---Stop profiler.
---@param Delay? number Delay before stop in seconds.
function PROFILER.Stop(Delay) end

---@param Delay? any
function PROFILER.Stop(Delay) end

---Event handler.
---@param event? any
function PROFILER.eventHandler:onEvent(event) end

---Debug hook.
---@param event? table Event.
function PROFILER.hook(event) end

---Get data.
---@param func? function Function.
---@return string # Function name.
---@return string # Source file name.
---@return string # Line number.
---@return number # Function time in seconds.
function PROFILER.getData(func) end

---Write text to log file.
---@param f? function The file.
---@param txt? string The text.
function PROFILER._flog(f, txt) end

---Show table.
---@param data? table Data table.
---@param f? function The file.
---@param runTimeGame? number Game run time in seconds.
function PROFILER.showTable(data, f, runTimeGame) end

---Print csv file.
---@param data? table Data table.
---@param runTimeGame? number Game run time in seconds.
function PROFILER.printCSV(data, runTimeGame) end

---Write info to output file.
---@param ext? string Extension.
---@return string # File name.
function PROFILER.getfilename(ext) end

---Write info to output file.
---@param runTimeGame? number Game time in seconds.
---@param runTimeOS? number OS time in seconds.
function PROFILER.showInfo(runTimeGame, runTimeOS) end
