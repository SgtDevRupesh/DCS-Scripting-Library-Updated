---@meta

---CIRCLE class.
---@class CIRCLE
---@field ClassName string Name of the class.
---@field Radius number Radius of the circle
CIRCLE = {
    ClassName = "CIRCLE",
    Radius = nil,
}

---Finds a circle on the map by its name. The circle must have been added in the Mission Editor
---@param shape_name? string Name of the circle to find
---@return CIRCLE # The found circle, or nil if not found
function CIRCLE:FindOnMap(shape_name) end

---Finds a circle by its name in the database.
---@param shape_name? string Name of the circle to find
---@return CIRCLE # The found circle, or nil if not found
function CIRCLE:Find(shape_name) end

---Creates a new circle from a center point and a radius.
---@param vec2? table The center point of the circle
---@param radius? number The radius of the circle
---@return CIRCLE # The new circle
function CIRCLE:New(vec2, radius) end

---Gets the radius of the circle.
---@return number # The radius of the circle
function CIRCLE:GetRadius() end

---Checks if a point is contained within the circle.
---@param point? table The point to check
---@return boolean # True if the point is contained, false otherwise
function CIRCLE:ContainsPoint(point) end

---Checks if a point is contained within a sector of the circle. The start and end sector need to be clockwise
---@param point? table The point to check
---@param sector_start? table The start point of the sector
---@param sector_end? table The end point of the sector
---@param center? table The center point of the sector
---@param radius? number The radius of the sector
---@return boolean # True if the point is contained, false otherwise
function CIRCLE:PointInSector(point, sector_start, sector_end, center, radius) end

---Checks if a unit is contained within a sector of the circle. The start and end sector need to be clockwise
---@param unit_name? string The name of the unit to check
---@param sector_start? table The start point of the sector
---@param sector_end? table The end point of the sector
---@param center? table The center point of the sector
---@param radius? number The radius of the sector
---@return boolean # True if the unit is contained, false otherwise
function CIRCLE:UnitInSector(unit_name, sector_start, sector_end, center, radius) end

---Checks if any unit of a group is contained within a sector of the circle. The start and end sector need to be clockwise
---@param group_name? string The name of the group to check
---@param sector_start? table The start point of the sector
---@param sector_end? table The end point of the sector
---@param center? table The center point of the sector
---@param radius? number The radius of the sector
---@return boolean # True if any unit of the group is contained, false otherwise
function CIRCLE:AnyOfGroupInSector(group_name, sector_start, sector_end, center, radius) end

---Checks if all units of a group are contained within a sector of the circle. The start and end sector need to be clockwise
---@param group_name? string The name of the group to check
---@param sector_start? table The start point of the sector
---@param sector_end? table The end point of the sector
---@param center? table The center point of the sector
---@param radius? number The radius of the sector
---@return boolean # True if all units of the group are contained, false otherwise
function CIRCLE:AllOfGroupInSector(group_name, sector_start, sector_end, center, radius) end

---Checks if a unit is contained within a radius of the circle.
---@param unit_name? string The name of the unit to check
---@param center? table The center point of the radius
---@param radius? number The radius to check
---@return boolean # True if the unit is contained, false otherwise
function CIRCLE:UnitInRadius(unit_name, center, radius) end

---Checks if any unit of a group is contained within a radius of the circle.
---@param group_name? string The name of the group to check
---@param center? table The center point of the radius
---@param radius? number The radius to check
---@return boolean # True if any unit of the group is contained, false otherwise
function CIRCLE:AnyOfGroupInRadius(group_name, center, radius) end

---Checks if all units of a group are contained within a radius of the circle.
---@param group_name? string The name of the group to check
---@param center? table The center point of the radius
---@param radius? number The radius to check
---@return boolean # True if all units of the group are contained, false otherwise
function CIRCLE:AllOfGroupInRadius(group_name, center, radius) end

---Returns a random Vec2 within the circle.
---@return table # The random Vec2
function CIRCLE:GetRandomVec2() end

---Returns a random Vec2 on the border of the circle.
---@return table # The random Vec2
function CIRCLE:GetRandomVec2OnBorder() end

---Calculates the bounding box of the circle. The bounding box is the smallest rectangle that contains the circle.
---@return table # The bounding box of the circle
function CIRCLE:GetBoundingBox() end
