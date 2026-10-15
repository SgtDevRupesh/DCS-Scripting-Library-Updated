---@meta

---OVAL class.
---@class OVAL
---@field ClassName string Name of the class.
---@field MajorAxis number The major axis (radius) of the oval
---@field MinorAxis number The minor axis (radius) of the oval
---@field Angle number The angle the oval is rotated on
OVAL = {
    ClassName = "OVAL",
    MajorAxis = nil,
    MinorAxis = nil,
    Angle = 0,
    DrawPoly=nil
}

---Finds an oval on the map by its name. The oval must be drawn on the map.
---@param shape_name? string Name of the oval to find
---@return OVAL # The found oval, or nil if not found
function OVAL:FindOnMap(shape_name) end

---Finds an oval by its name in the database.
---@param shape_name? string Name of the oval to find
---@return OVAL # The found oval, or nil if not found
function OVAL:Find(shape_name) end

---Creates a new oval from a center point, major axis, minor axis, and angle.
---@param vec2? table The center point of the oval
---@param major_axis? number The major axis of the oval
---@param minor_axis? number The minor axis of the oval
---@param angle? number The angle of the oval
---@return OVAL # The new oval
function OVAL:New(vec2, major_axis, minor_axis, angle) end

---Gets the major axis of the oval.
---@return number # The major axis of the oval
function OVAL:GetMajorAxis() end

---Gets the minor axis of the oval.
---@return number # The minor axis of the oval
function OVAL:GetMinorAxis() end

---Gets the angle of the oval.
---@return number # The angle of the oval
function OVAL:GetAngle() end

---Sets the major axis of the oval.
---@param value? number The new major axis
function OVAL:SetMajorAxis(value) end

---Sets the minor axis of the oval.
---@param value? number The new minor axis
function OVAL:SetMinorAxis(value) end

---Sets the angle of the oval.
---@param value? number The new angle
function OVAL:SetAngle(value) end

---Checks if a point is contained within the oval.
---@param point? table The point to check
---@return boolean # True if the point is contained, false otherwise
function OVAL:ContainsPoint(point) end

---Returns a random Vec2 within the oval.
---@return table # The random Vec2
function OVAL:GetRandomVec2() end

---Calculates the bounding box of the oval. The bounding box is the smallest rectangle that contains the oval.
---@return table # The bounding box of the oval
function OVAL:GetBoundingBox() end

---Draws the oval on the map, for debugging
function OVAL:Draw() end

---Removes the drawing of the oval from the map
function OVAL:RemoveDraw() end

---@param num_points? any
function OVAL:PointsOnEdge(num_points) end
