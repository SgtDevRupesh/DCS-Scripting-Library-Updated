---@meta

---@class LIFO.IDEntry
---@field pointer number
---@field data table
---@field uniqueID table

---@class FIFO.IDEntry
---@field pointer number
---@field data table
---@field uniqueID table

---FIFO class.
---@class FIFO : BASE
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field version string Version of FiFo.
---@field counter number Counter.
---@field pointer number Pointer.
---@field stackbypointer table Stack by pointer.
---@field stackbyid table Stack by ID.
FIFO = {
  ClassName = "FIFO",
  lid = "",
  version = "0.0.5",
  counter = 0,
  pointer = 0,
  stackbypointer = {},
  stackbyid = {}
}

---Instantiate a new FIFO Stack.
---@return FIFO # self
function FIFO:New() end

---Empty FIFO Stack.
---@return FIFO # self
function FIFO:Clear() end

---FIFO Push Object to Stack.
---@param Object? table
---@param UniqueID? string (optional) - will default to current pointer + 1. Note - if you intend to use `FIFO:GetIDStackSorted()` keep the UniqueID numerical!
---@return FIFO # self
function FIFO:Push(Object, UniqueID) end

---FIFO Pull Object from Stack.
---@return table # Object or nil if stack is empty
function FIFO:Pull() end

---FIFO Pull Object from Stack by Pointer
---@param Pointer? number
---@return table # Object or nil if stack is empty
function FIFO:PullByPointer(Pointer) end

---FIFO Read, not Pull, Object from Stack by Pointer
---@param Pointer? number
---@return table # Object or nil if stack is empty or pointer does not exist
function FIFO:ReadByPointer(Pointer) end

---FIFO Read, not Pull, Object from Stack by UniqueID
---@param UniqueID? number
---@return table # Object data or nil if stack is empty or ID does not exist
function FIFO:ReadByID(UniqueID) end

---FIFO Pull Object from Stack by UniqueID
---@param UniqueID? any
---@return table # Object or nil if stack is empty
function FIFO:PullByID(UniqueID) end

---FIFO Housekeeping
---@return FIFO # self
function FIFO:Flatten() end

---FIFO Check Stack is empty
---@return boolean # empty
function FIFO:IsEmpty() end

---FIFO Get stack size
---@return number # size
function FIFO:GetSize() end

---FIFO Get stack size
---@return number # size
function FIFO:Count() end

---FIFO Check Stack is NOT empty
---@return boolean # notempty
function FIFO:IsNotEmpty() end

---FIFO Get the data stack by pointer
---@return table # Table of #FIFO.IDEntry entries
function FIFO:GetPointerStack() end

---FIFO Check if a certain UniqeID exists
---@param UniqueID? any
---@return boolean # exists
function FIFO:HasUniqueID(UniqueID) end

---FIFO Get the data stack by UniqueID
---@return table # Table of #FIFO.IDEntry entries
function FIFO:GetIDStack() end

---FIFO Get table of UniqueIDs sorted smallest to largest
---@return table # Table with index [1] to [n] of UniqueID entries
function FIFO:GetIDStackSorted() end

---FIFO Get table of data entries
---@return table # Raw table indexed [1] to [n] of object entries - might be empty!
function FIFO:GetDataTable() end

---FIFO Get sorted table of data entries by UniqueIDs (must be numerical UniqueIDs only!)
---@return table # Table indexed [1] to [n] of sorted object entries - might be empty!
function FIFO:GetSortedDataTable() end

---Iterate the FIFO and call an iterator function for the given FIFO data, providing the object for each element of the stack and optional parameters.
---@param IteratorFunction? function The function that will be called.
---@param Arg? table (Optional) Further Arguments of the IteratorFunction.
---@param Function? function (Optional) A function returning a #boolean true/false. Only if true, the IteratorFunction is called.
---@param FunctionArguments? table (Optional) Function arguments.
---@return FIFO # self
function FIFO:ForEach(IteratorFunction, Arg, Function, FunctionArguments) end

---FIFO Print stacks to dcs.log
---@return FIFO # self
function FIFO:Flush() end

---LIFO class.
---@class LIFO : BASE
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field version string Version of LiFo
---@field counter number
---@field pointer number
---@field stackbypointer table
---@field stackbyid table
LIFO = {
  ClassName = "LIFO",
  lid = "",
  version = "0.0.5",
  counter = 0,
  pointer = 0,
  stackbypointer = {},
  stackbyid = {}
}

---Instantiate a new LIFO Stack
---@return LIFO # self
function LIFO:New() end

---Empty LIFO Stack
---@return LIFO # self
function LIFO:Clear() end

---LIFO Push Object to Stack
---@param Object? table
---@param UniqueID? string (optional) - will default to current pointer + 1
---@return LIFO # self
function LIFO:Push(Object, UniqueID) end

---LIFO Pull Object from Stack
---@return table # Object or nil if stack is empty
function LIFO:Pull() end

---LIFO Pull Object from Stack by Pointer
---@param Pointer? number
---@return table # Object or nil if stack is empty
function LIFO:PullByPointer(Pointer) end

---LIFO Read, not Pull, Object from Stack by Pointer
---@param Pointer? number
---@return table # Object or nil if stack is empty or pointer does not exist
function LIFO:ReadByPointer(Pointer) end

---LIFO Read, not Pull, Object from Stack by UniqueID
---@param UniqueID? number
---@return table # Object or nil if stack is empty or ID does not exist
function LIFO:ReadByID(UniqueID) end

---LIFO Pull Object from Stack by UniqueID
---@param UniqueID? any
---@return table # Object or nil if stack is empty
function LIFO:PullByID(UniqueID) end

---LIFO Housekeeping
---@return LIFO # self
function LIFO:Flatten() end

---LIFO Check Stack is empty
---@return boolean # empty
function LIFO:IsEmpty() end

---LIFO Get stack size
---@return number # size
function LIFO:GetSize() end

---LIFO Get stack size
---@return number # size
function LIFO:Count() end

---LIFO Check Stack is NOT empty
---@return boolean # notempty
function LIFO:IsNotEmpty() end

---LIFO Get the data stack by pointer
---@return table # Table of #LIFO.IDEntry entries
function LIFO:GetPointerStack() end

---LIFO Get the data stack by UniqueID
---@return table # Table of #LIFO.IDEntry entries
function LIFO:GetIDStack() end

---LIFO Get table of UniqueIDs sorted smallest to largest
---@return table # Table of #LIFO.IDEntry entries
function LIFO:GetIDStackSorted() end

---LIFO Check if a certain UniqeID exists
---@param UniqueID? any
---@return boolean # exists
function LIFO:HasUniqueID(UniqueID) end

---LIFO Print stacks to dcs.log
---@return LIFO # self
function LIFO:Flush() end

---LIFO Get table of data entries
---@return table # Raw table indexed [1] to [n] of object entries - might be empty!
function LIFO:GetDataTable() end

---LIFO Get sorted table of data entries by UniqueIDs (must be numerical UniqueIDs only!)
---@return table # Table indexed [1] to [n] of sorted object entries - might be empty!
function LIFO:GetSortedDataTable() end

---Iterate the LIFO and call an iterator function for the given LIFO data, providing the object for each element of the stack and optional parameters.
---@param IteratorFunction? function The function that will be called.
---@param Arg? table (Optional) Further Arguments of the IteratorFunction.
---@param Function? function (Optional) A function returning a #boolean true/false. Only if true, the IteratorFunction is called.
---@param FunctionArguments? table (Optional) Function arguments.
---@return LIFO # self
function LIFO:ForEach(IteratorFunction, Arg, Function, FunctionArguments) end
