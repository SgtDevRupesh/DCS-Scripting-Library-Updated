---@meta

---@class CUBE
---@field ClassName string Name of the class.
---@field Points number points of the line
---@field Coords number coordinates of the line
CUBE = {}

---Creates a new triangle from three points. The points need to be given as Vec2s
---@param p1? table The first point of the triangle
---@param p2? table The second point of the triangle
---@param p3? table The third point of the triangle
---@return TRIANGLE # The new triangle
function TRIANGLE:New(p1, p2, p3) end

---Checks if a point is contained within the triangle.
---@param pt? table The point to check
---@param points? table (optional) The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@return boolean # True if the point is contained, false otherwise
function TRIANGLE:ContainsPoint(pt, points) end

---Returns a random Vec2 within the triangle.
---@param points? table The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@return table # The random Vec2
function TRIANGLE:GetRandomVec2(points) end

---Draws the triangle on the map, just for debugging
function TRIANGLE:Draw() end

---Removes the drawing of the triangle from the map.
function TRIANGLE:RemoveDraw() end
