---@meta

---SHAPE_BASE class.
---@class SHAPE_BASE : BASE
---@field ClassName string Name of the class.
---@field Name string Name of the shape
---@field CenterVec2 table Vec2 of the center of the shape, this will be assigned automatically
---@field Points table List of 3D points defining the shape, this will be assigned automatically
---@field Coords table List of COORDINATE defining the path, this will be assigned automatically
---@field MarkIDs table List any MARKIDs this class use, this will be assigned automatically
SHAPE_BASE = {
    ClassName = "SHAPE_BASE",
    Name = "",
    CenterVec2 = nil,
    Points = {},
    Coords = {},
    MarkIDs = {},
    ColorString = "",
    ColorRGBA = {}
}

---Creates a new instance of SHAPE_BASE.
---@return SHAPE_BASE # The new instance
function SHAPE_BASE:New() end

---Finds a shape on the map by its name.
---@param shape_name? string Name of the shape to find
---@return SHAPE_BASE # The found shape
function SHAPE_BASE:FindOnMap(shape_name) end

---@param filter? any
function SHAPE_BASE:GetAllShapes(filter) end

---Offsets the shape to a new position.
---@param new_vec2? table The new position
function SHAPE_BASE:Offset(new_vec2) end

---Gets the name of the shape.
---@return string # The name of the shape
function SHAPE_BASE:GetName() end

function SHAPE_BASE:GetColorString() end

function SHAPE_BASE:GetColorRGBA() end

function SHAPE_BASE:GetColorRed() end

function SHAPE_BASE:GetColorGreen() end

function SHAPE_BASE:GetColorBlue() end

function SHAPE_BASE:GetColorAlpha() end

---Gets the center position of the shape.
---@return table # The center position
function SHAPE_BASE:GetCenterVec2() end

---Gets the center coordinate of the shape.
---@return COORDINATE # The center coordinate
function SHAPE_BASE:GetCenterCoordinate() end

---Gets the coordinate of the shape.
---@return COORDINATE # The coordinate
function SHAPE_BASE:GetCoordinate() end

---Checks if a point is contained within the shape.
---@param _? table The point to check
---@return boolean # True if the point is contained, false otherwise
function SHAPE_BASE:ContainsPoint(_) end

---Checks if a unit is contained within the shape.
---@param unit_name? string The name of the unit to check
---@return boolean # True if the unit is contained, false otherwise
function SHAPE_BASE:ContainsUnit(unit_name) end

---Checks if any unit of a group is contained within the shape.
---@param group_name? string The name of the group to check
---@return boolean # True if any unit of the group is contained, false otherwise
function SHAPE_BASE:ContainsAnyOfGroup(group_name) end

---Checks if all units of a group are contained within the shape.
---@param group_name? string The name of the group to check
---@return boolean # True if all units of the group are contained, false otherwise
function SHAPE_BASE:ContainsAllOfGroup(group_name) end
