---@meta

---LINE class.
---@class LINE
---@field ClassName string Name of the class.
---@field Points number points of the line
---@field Coords number coordinates of the line
LINE = {
    ClassName = "LINE",
    Points = {},
    Coords = {},
}

---Finds a line on the map by its name. The line must be drawn in the Mission Editor
---@param line_name? string Name of the line to find
---@return LINE # The found line, or nil if not found
function LINE:FindOnMap(line_name) end

---Finds a line by its name in the database.
---@param shape_name? string Name of the line to find
---@return LINE # The found line, or nil if not found
function LINE:Find(shape_name) end

---Creates a new line from two points.
---@param ... any
---@return LINE # The new line
function LINE:New(...) end

---Creates a new line from a circle.
---@param center_point? table center point of the circle
---@param radius? number radius of the circle, half length of the line
---@param angle_degrees? number degrees the line will form from center point
---@return LINE # The new line
function LINE:NewFromCircle(center_point, radius, angle_degrees) end

---Gets the coordinates of the line.
---@return table # The coordinates of the line
function LINE:Coordinates() end

---Gets the start coordinate of the line. The start coordinate is the first point of the line.
---@return COORDINATE # The start coordinate of the line
function LINE:GetStartCoordinate() end

---Gets the end coordinate of the line. The end coordinate is the last point of the line.
---@return COORDINATE # The end coordinate of the line
function LINE:GetEndCoordinate() end

---Gets the start point of the line. The start point is the first point of the line.
---@return table # The start point of the line
function LINE:GetStartPoint() end

---Gets the end point of the line. The end point is the last point of the line.
---@return table # The end point of the line
function LINE:GetEndPoint() end

---Gets the length of the line.
---@return number # The length of the line
function LINE:GetLength() end

---Returns a random point on the line.
---@param points? table (optional) The points of the line or 2 other points if you're just using the LINE class without an object of it
---@return table # The random point
function LINE:GetRandomPoint(points) end

---Gets the heading of the line.
---@param points? table (optional) The points of the line or 2 other points if you're just using the LINE class without an object of it
---@return number # The heading of the line
function LINE:GetHeading(points) end

---Return each part of the line as a new line
---@return table # The points
function LINE:GetIndividualParts() end

---Gets a number of points in between the start and end points of the line.
---@param amount? number The number of points to get
---@param start_point? table (Optional) The start point of the line, defaults to the object's start point
---@param end_point? table (Optional) The end point of the line, defaults to the object's end point
---@return table # The points
function LINE:GetPointsInbetween(amount, start_point, end_point) end

---Gets a number of points in between the start and end points of the line.
---@param amount? number The number of points to get
---@param start_point? table (Optional) The start point of the line, defaults to the object's start point
---@param end_point? table (Optional) The end point of the line, defaults to the object's end point
---@return table # The points
function LINE:GetCoordinatesInBetween(amount, start_point, end_point) end

---@param start_point? any
---@param end_point? any
function LINE:GetRandomPoint(start_point, end_point) end

---@param start_point? any
---@param end_point? any
function LINE:GetRandomCoordinate(start_point, end_point) end

---Gets a number of points on a sine wave between the start and end points of the line.
---@param amount? number The number of points to get
---@param start_point? table (Optional) The start point of the line, defaults to the object's start point
---@param end_point? table (Optional) The end point of the line, defaults to the object's end point
---@param frequency? number (Optional) The frequency of the sine wave, default 1
---@param phase? number (Optional) The phase of the sine wave, default 0
---@param amplitude? number (Optional) The amplitude of the sine wave, default 100
---@return table # The points
function LINE:GetPointsBetweenAsSineWave(amount, start_point, end_point, frequency, phase, amplitude) end

---Calculates the bounding box of the line. The bounding box is the smallest rectangle that contains the line.
---@return table # The bounding box of the line
function LINE:GetBoundingBox() end

---Draws the line on the map.
function LINE:Draw() end

---Removes the drawing of the line from the map.
function LINE:RemoveDraw() end
