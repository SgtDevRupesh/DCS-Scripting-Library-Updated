---@meta

---LINE class.
---@class CUBE
---@field ClassName string Name of the class.
---@field Points number points of the line
---@field Coords number coordinates of the line
CUBE = {
    ClassName = "CUBE",
    Points = {},
    Coords = {}
}

---Points need to be added in the following order:
---p1 -> p4 make up the front face of the cube
---p5 -> p8 make up the back face of the cube
---       p1 connects to p5
---       p2 connects to p6
---       p3 connects to p7
---       p4 connects to p8
---
---        8-----------7
---       /|          /|
---      / |         / |
---     4--+--------3  |
---     |  |        |  |
---     |  |        |  |
---     |  |        |  |
---     |  5--------+--6
---     | /         | /
---     |/          |/
---     1-----------2
---@param p1? any
---@param p2? any
---@param p3? any
---@param p4? any
---@param p5? any
---@param p6? any
---@param p7? any
---@param p8? any
function CUBE:New(p1, p2, p3, p4, p5, p6, p7, p8) end

function CUBE:GetCenter() end

---@param point? any
---@param cube_points? any
function CUBE:ContainsPoint(point, cube_points) end
