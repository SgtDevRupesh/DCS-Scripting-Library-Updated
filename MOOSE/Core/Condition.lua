---@meta

---@class CONDITION.Function
---@field uid number Unique ID of the condition function.
---@field type string Type of the condition function: "gen", "any", "all".
---@field persistence boolean If `true`, this is persistent.
---@field func function Callback function to check for a condition. Must return a `#boolean`.
---@field arg table (Optional) Arguments passed to the condition callback function if any.

---CONDITON class.
---@class CONDITION : BASE
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field name string Name of the condition.
---@field isAny boolean General functions are evaluated as any condition.
---@field negateResult boolean Negate result of evaluation.
---@field noneResult boolean Boolean that is returned if no condition functions at all were specified.
---@field functionsGen table General condition functions.
---@field functionsAny table Any condition functions.
---@field functionsAll table All condition functions.
---@field functionCounter number Running number to determine the unique ID of condition functions.
---@field defaultPersist boolean Default persistence of condition functions.
CONDITION = {
  ClassName       = "CONDITION",
  lid             =   nil,
  functionsGen    =    {},
  functionsAny    =    {},
  functionsAll    =    {},
  functionCounter =     0, 
  defaultPersist  = false,
}

---CONDITION class version.
CONDITION.version = "0.3.0"

---Create a new CONDITION object.
---@param Name? string (Optional) Name used in the logs.
---@return CONDITION # self
function CONDITION:New(Name) end

---Set that general condition functions return `true` if `any` function returns `true`. Default is that *all* functions must return `true`.
---@param Any? boolean If `true`, *any* condition can be true. Else *all* conditions must result `true`.
---@return CONDITION # self
function CONDITION:SetAny(Any) end

---Negate result.
---@param Negate? boolean If `true`, result is negated else  not.
---@return CONDITION # self
function CONDITION:SetNegateResult(Negate) end

---Set whether `true` or `false` is returned, if no conditions at all were specified. By default `false` is returned.
---@param ReturnValue? boolean Returns this boolean.
---@return CONDITION # self
function CONDITION:SetNoneResult(ReturnValue) end

---Set whether condition functions are persistent, *i.e.* are removed.
---@param IsPersistent? boolean If `true`, condition functions are persistent.
---@return CONDITION # self
function CONDITION:SetDefaultPersistence(IsPersistent) end

---Add a function that is evaluated. It must return a `#boolean` value, *i.e.* either `true` or `false` (or `nil`).
---@param Function? function The function to call.
---@param ... any
---@return CONDITION.Function # Condition function table.
function CONDITION:AddFunction(Function, ...) end

---Add a function that is evaluated. It must return a `#boolean` value, *i.e.* either `true` or `false` (or `nil`).
---@param Function? function The function to call.
---@param ... any
---@return CONDITION.Function # Condition function table.
function CONDITION:AddFunctionAny(Function, ...) end

---Add a function that is evaluated. It must return a `#boolean` value, *i.e.* either `true` or `false` (or `nil`).
---@param Function? function The function to call.
---@param ... any
---@return CONDITION.Function # Condition function table.
function CONDITION:AddFunctionAll(Function, ...) end

---Remove a condition function.
---@param ConditionFunction? CONDITION.Function|number|string The condition function to be removed.
---@return CONDITION # self
function CONDITION:RemoveFunction(ConditionFunction) end

---Remove all non-persistant condition functions.
---@return CONDITION # self
function CONDITION:RemoveNonPersistant() end

---Evaluate conditon functions.
---@param AnyTrue? boolean (Optional) If `true`, evaluation return `true` if *any* condition function returns `true`. By default, *all* condition functions must return true.
---@return boolean # Result of condition functions.
function CONDITION:Evaluate(AnyTrue) end

---Check if all given condition are true.
---@param functions? table Functions to evaluate.
---@return boolean # If true, all conditions were true (or functions was empty/nil). Returns false if at least one condition returned false.
function CONDITION:_EvalConditionsAll(functions) end

---Check if any of the given conditions is true.
---@param functions? table Functions to evaluate.
---@return boolean # If true, at least one condition is true (or functions was emtpy/nil).
function CONDITION:_EvalConditionsAny(functions) end

---Create conditon function object.
---@param Ftype? number Function type: 0=Gen, 1=All, 2=Any.
---@param Function? function The function to call.
---@param ... any
---@return CONDITION.Function # Condition function.
function CONDITION:_CreateCondition(Ftype, Function, ...) end

---Condition to check if time is greater than a given threshold time.
---@param Time? number Time in seconds.
---@param Absolute? boolean (Optional) If `true`, abs. mission time from `timer.getAbsTime()` is checked. Default is relative mission time from `timer.getTime()`.
---@return boolean # Returns `true` if time is greater than give the time.
function CONDITION.IsTimeGreater(Time, Absolute) end

---Function that returns `true` (success) with a certain probability. For example, if you specify `Probability=80` there is an 80% chance that `true` is returned.
---Technically, a random number between 0 and 100 is created. If the given success probability is less then this number, `true` is returned.
---@param Probability? number (Optional) Success probability in percent. Default 50 %.
---@return boolean # Returns `true` for success and `false` otherwise.
function CONDITION.IsRandomSuccess(Probability) end

---Function that returns always `true`
---@return boolean # Returns `true` unconditionally.
function CONDITION.ReturnTrue() end

---Function that returns always `false`
---@return boolean # Returns `false` unconditionally.
function CONDITION.ReturnFalse() end
