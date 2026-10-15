---@meta

---@class DCSObject
---@field The id_ ID of the controllable in DCS
DCSObject = {}

---OBJECT class.
---@class OBJECT : BASE
---@field ObjectName string The name of the Object.
OBJECT = {
  ClassName = "OBJECT",
  ObjectName = "",
}

---Create a new OBJECT from a DCSObject
---@param ObjectName? Object The Object name
---@return OBJECT # self
function OBJECT:New(ObjectName) end

---Returns the unit's unique identifier.
---@return Object.ID # ObjectID or #nil if the DCS Object is not existing or alive. Note that the ID is passed as a string and not a number.
function OBJECT:GetID() end

---Destroys the OBJECT.
---@return boolean # Returns `true` if the object is destroyed or #nil if the object is nil.
function OBJECT:Destroy() end
