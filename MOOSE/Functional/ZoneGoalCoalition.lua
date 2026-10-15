---@meta

---@class ZONE_GOAL_COALITION : ZONE_GOAL
---@field ClassName string Name of the Class.
---@field Coalition number The current coalition ID of the zone owner.
---@field PreviousCoalition number The previous owner of the zone.
---@field UnitCategories table Table of unit categories that are able to capture and hold the zone. Default is only GROUND units.
---@field ObjectCategories table Table of object categories that are able to hold a zone. Default is UNITS and STATICS.
ZONE_GOAL_COALITION = {
  ClassName = "ZONE_GOAL_COALITION",
  Coalition = nil,
  PreviousCoalition = nil,
  UnitCategories = nil,
  ObjectCategories = nil,
}

ZONE_GOAL_COALITION.States = {}

---ZONE_GOAL_COALITION Constructor.
---@param Zone? ZONE A @{Core.Zone} object with the goal to be achieved.
---@param Coalition? number (Optional) The initial coalition owning the zone. Default coalition.side.NEUTRAL.
---@param UnitCategories? any (Optional) Table of unit categories. See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit). Default {Unit.Category.GROUND_UNIT}.
---@return ZONE_GOAL_COALITION
function ZONE_GOAL_COALITION:New(Zone, Coalition, UnitCategories) end

---Set the owning coalition of the zone.
---@param Coalition? number The coalition ID, e.g. *coalition.side.RED*.
---@return ZONE_GOAL_COALITION
function ZONE_GOAL_COALITION:SetCoalition(Coalition) end

---Set the owning coalition of the zone.
---@param UnitCategories? any (Optional) Table of unit categories. See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit). Default {Unit.Category.GROUND_UNIT}.
---@return ZONE_GOAL_COALITION
function ZONE_GOAL_COALITION:SetUnitCategories(UnitCategories) end

---Set the owning coalition of the zone.
---@param ObjectCategories? any (Optional) Table of unit categories. See [DCS Class Object](https://wiki.hoggitworld.com/view/DCS_Class_Object). Default {Object.Category.UNIT, Object.Category.STATIC}, i.e. all UNITS and STATICS.
---@return ZONE_GOAL_COALITION
function ZONE_GOAL_COALITION:SetObjectCategories(ObjectCategories) end

---Get the owning coalition of the zone.
---@return number # Coalition.
function ZONE_GOAL_COALITION:GetCoalition() end

---Get the previous coalition, i.e. the one owning the zone before the current one.
---@return number # Coalition.
function ZONE_GOAL_COALITION:GetPreviousCoalition() end

---Get the owning coalition name of the zone.
---@return string # Coalition name.
function ZONE_GOAL_COALITION:GetCoalitionName() end

---Check status Coalition ownership.
---@return ZONE_GOAL_COALITION
function ZONE_GOAL_COALITION:StatusZone() end
