---@meta

---@class USERFLAG : BASE
---@field ClassName string Name of the class
---@field UserFlagName string Name of the flag.
USERFLAG = {
  ClassName    = "USERFLAG",
  UserFlagName = nil,
}

---USERFLAG Constructor.
---@param UserFlagName? string The name of the userflag, which is a free text string.
---@return USERFLAG
function USERFLAG:New(UserFlagName) end

---Get the userflag name.
---@return string # Name of the user flag.
function USERFLAG:GetName() end

---Set the userflag to a given Number.
---@param Number? number The number value to set the flag to.
---@param Delay? number Delay in seconds, before the flag is set.
---@return USERFLAG # The userflag instance.
function USERFLAG:Set(Number, Delay) end

---Get the userflag Number.
---@return number # Number The number value to be checked if it is the same as the userflag.
function USERFLAG:Get() end

---Check if the userflag has a value of Number.
---@param Number? number The number value to be checked if it is the same as the userflag.
---@return boolean # true if the Number is the value of the userflag.
function USERFLAG:Is(Number) end
