---@meta

---@class VELOCITY : BASE
VELOCITY = {
  ClassName = "VELOCITY",
}

---VELOCITY Constructor.
---@param VelocityMps? number The velocity in meters per second.
---@return VELOCITY
function VELOCITY:New(VelocityMps) end

---Set the velocity in Mps (meters per second).
---@param VelocityMps? number The velocity in meters per second.
---@return VELOCITY
function VELOCITY:Set(VelocityMps) end

---Get the velocity in Mps (meters per second).
---@return number # The velocity in meters per second.
function VELOCITY:Get() end

---Set the velocity in Kmph (kilometers per hour).
---@param VelocityKmph? number The velocity in kilometers per hour.
---@return VELOCITY
function VELOCITY:SetKmph(VelocityKmph) end

---Get the velocity in Kmph (kilometers per hour).
---@return number # The velocity in kilometers per hour.
function VELOCITY:GetKmph() end

---Set the velocity in Miph (miles per hour).
---@param VelocityMiph? number The velocity in miles per hour.
---@return VELOCITY
function VELOCITY:SetMiph(VelocityMiph) end

---Get the velocity in Miph (miles per hour).
---@return number # The velocity in miles per hour.
function VELOCITY:GetMiph() end

---Get the velocity in text, according the player {Core.Settings}.
---@param Settings? SETTINGS
---@return string # The velocity in text.
function VELOCITY:GetText(Settings) end

---Get the velocity in text, according the player or default {Core.Settings}.
---@param VelocityGroup? any
---@param Settings? SETTINGS
---@return string # The velocity in text according the player or default @{Core.Settings}
function VELOCITY:ToString(VelocityGroup, Settings) end

---@class VELOCITY_POSITIONABLE : BASE
VELOCITY_POSITIONABLE = {
  ClassName = "VELOCITY_POSITIONABLE",
}

---VELOCITY_POSITIONABLE Constructor.
---@param Positionable? POSITIONABLE The Positionable to monitor the speed.
---@return VELOCITY_POSITIONABLE
function VELOCITY_POSITIONABLE:New(Positionable) end

---Get the velocity in Mps (meters per second).
---@return number # The velocity in meters per second.
function VELOCITY_POSITIONABLE:Get() end

---Get the velocity in Kmph (kilometers per hour).
---@return number # The velocity in kilometers per hour.
function VELOCITY_POSITIONABLE:GetKmph() end

---Get the velocity in Miph (miles per hour).
---@return number # The velocity in miles per hour.
function VELOCITY_POSITIONABLE:GetMiph() end

---Get the velocity in text, according the player or default {Core.Settings}.
---@return string # The velocity in text according the player or default @{Core.Settings}
function VELOCITY_POSITIONABLE:ToString() end
