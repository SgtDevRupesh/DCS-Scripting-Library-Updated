---@meta

---POLYGON class.
---@class POLYGON : BASE
---@field ClassName string Name of the class.
---@field Points table List of 3D points defining the shape, this will be assigned automatically if you're passing in a drawing from the Mission Editor
---@field Coords table List of COORDINATE defining the path, this will be assigned automatically if you're passing in a drawing from the Mission Editor
---@field MarkIDs table List any MARKIDs this class use, this will be assigned automatically if you're passing in a drawing from the Mission Editor
---@field Triangles table List of TRIANGLEs that make up the shape of the POLYGON after being triangulated
POLYGON = {
    ClassName = "POLYGON",
    Points = {},
    Coords = {},
    Triangles = {},
    SurfaceArea = 0,
    TriangleMarkIDs = {},
    OutlineMarkIDs = {},
    Angle = nil,   -- for arrows
    Heading = nil  -- for arrows
}

---Finds a polygon on the map by its name. The polygon must be added in the mission editor.
---@param shape_name? string Name of the polygon to find
---@return POLYGON # The found polygon, or nil if not found
function POLYGON:FindOnMap(shape_name) end

---Creates a polygon from a zone. The zone must be defined in the mission.
---@param zone_name? string Name of the zone
---@return POLYGON # The polygon created from the zone, or nil if the zone is not found
function POLYGON:FromZone(zone_name) end

---Finds a polygon by its name in the database.
---@param shape_name? string Name of the polygon to find
---@return POLYGON # The found polygon, or nil if not found
function POLYGON:Find(shape_name) end

---Creates a new polygon from a list of points. Each point is a table with 'x' and 'y' fields.
---@param ... any
---@return POLYGON # The new polygon
function POLYGON:New(...) end

---Calculates the centroid of the polygon. The centroid is the average of the 'x' and 'y' coordinates of the points.
---@return table # The centroid of the polygon
function POLYGON:GetCentroid() end

---Returns the coordinates of the polygon. Each coordinate is a COORDINATE object.
---@return table # The coordinates of the polygon
function POLYGON:GetCoordinates() end

---Returns the start coordinate of the polygon. The start coordinate is the first point of the polygon.
---@return COORDINATE # The start coordinate of the polygon
function POLYGON:GetStartCoordinate() end

---Returns the end coordinate of the polygon. The end coordinate is the last point of the polygon.
---@return COORDINATE # The end coordinate of the polygon
function POLYGON:GetEndCoordinate() end

---Returns the start point of the polygon. The start point is the first point of the polygon.
---@return table # The start point of the polygon
function POLYGON:GetStartPoint() end

---Returns the end point of the polygon. The end point is the last point of the polygon.
---@return table # The end point of the polygon
function POLYGON:GetEndPoint() end

---Returns the points of the polygon. Each point is a table with 'x' and 'y' fields.
---@return table # The points of the polygon
function POLYGON:GetPoints() end

---Calculates the surface area of the polygon. The surface area is the sum of the areas of the triangles that make up the polygon.
---@return number # The surface area of the polygon
function POLYGON:GetSurfaceArea() end

---Calculates the bounding box of the polygon. The bounding box is the smallest rectangle that contains the polygon.
---@return table # The bounding box of the polygon
function POLYGON:GetBoundingBox() end

---Triangulates the polygon. The polygon is divided into triangles.
---@param points? table (optional) Points of the polygon or other points if you're just using the POLYGON class without an object of it
---@return table # The triangles of the polygon
function POLYGON:Triangulate(points) end

function POLYGON:CovarianceMatrix() end

function POLYGON:Direction() end

---Returns a random Vec2 within the polygon. The Vec2 is weighted by the areas of the triangles that make up the polygon.
---@return table # The random Vec2
function POLYGON:GetRandomVec2() end

---Returns a random non-weighted Vec2 within the polygon. The Vec2 is chosen from one of the triangles that make up the polygon.
---@return table # The random non-weighted Vec2
function POLYGON:GetRandomNonWeightedVec2() end

---Checks if a point is contained within the polygon. The point is a table with 'x' and 'y' fields.
---@param point? table The point to check
---@param polygon_points? any
---@return boolean # True if the point is contained, false otherwise
function POLYGON:ContainsPoint(point, polygon_points) end

---Draws the polygon on the map. The polygon can be drawn with or without inner triangles. This is just for debugging
---@param include_inner_triangles? boolean Whether to include inner triangles in the drawing
function POLYGON:Draw(include_inner_triangles) end

---Removes the drawing of the polygon from the map.
function POLYGON:RemoveDraw() end

---Calculates the surface area of the polygon. The surface area is the sum of the areas of the triangles that make up the polygon.
---@return number # The surface area of the polygon
function POLYGON:__CalculateSurfaceArea() end
