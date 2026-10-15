---@meta

---@class PATHLINE.Point
---@field vec3 Vec3 3D position.
---@field vec2 Vec2 2D position.
---@field surfaceType number Surface type.
---@field landHeight number Land height in meters.
---@field depth number Water depth in meters.
---@field markerID number Marker ID.
---@field lineID number Line marker ID.

---PATHLINE class.
---@class PATHLINE : BASE
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field name string Name of the path line.
---@field points table List of 3D points defining the path.
PATHLINE = {
  ClassName      = "PATHLINE",
  lid            =   nil,
  points         =    {},
}

---PATHLINE class version.
PATHLINE.version = "0.2.0"

---Create a new PATHLINE object. Points need to be added later.
---@param Name? string Name of the path.
---@return PATHLINE # self
function PATHLINE:New(Name) end

---Create a new PATHLINE object from a given list of 2D points.
---@param Name? string Name of the pathline.
---@param Vec2Array? table List of DCS#Vec2 points.
---@return PATHLINE # self
function PATHLINE:NewFromVec2Array(Name, Vec2Array) end

---Create a new PATHLINE object from a given list of 3D points.
---@param Name? string Name of the pathline.
---@param Vec3Array? table List of DCS#Vec3 points.
---@return PATHLINE # self
function PATHLINE:NewFromVec3Array(Name, Vec3Array) end

---Find a pathline in the database.
---@param Name? string The name of the pathline.
---@return PATHLINE # self
function PATHLINE:FindByName(Name) end

---Add a point to the path from a given 2D position. The third dimension is determined from the land height.
---@param Vec2? Vec2 The 2D vector (x,y) to add.
---@return PATHLINE # self
function PATHLINE:AddPointFromVec2(Vec2) end

---Add a point to the path from a given 3D position.
---@param Vec3? Vec3 The 3D vector (x,y) to add.
---@return PATHLINE # self
function PATHLINE:AddPointFromVec3(Vec3) end

---Get name of pathline.
---@return string # Name of the pathline.
function PATHLINE:GetName() end

---Get number of points.
---@return number # Number of points.
function PATHLINE:GetNumberOfPoints() end

---Get points of pathline. Not that points are tables, that contain more information as just the 2D or 3D position but also the surface type etc.
---@return table # <#PATHLINE.Point> List of points.
function PATHLINE:GetPoints() end

---Get 3D points of pathline.
---@return any # List of DCS#Vec3 points.
function PATHLINE:GetPoints3D() end

---Get 2D points of pathline.
---@return any # List of DCS#Vec2 points.
function PATHLINE:GetPoints2D() end

---Get COORDINATES of pathline. Note that COORDINATE objects are created when calling this function. That does involve deep copy calls and can have an impact on performance if done too often.
---@return any # List of COORDINATES points.
function PATHLINE:GetCoordinates() end

---Get the n-th point of the pathline.
---@param n? number (optional) The index of the point. Default is the first point.
---@return PATHLINE.Point # Point.
function PATHLINE:GetPointFromIndex(n) end

---Get the 3D position of the n-th point.
---@param n? number The n-th point.
---@return Vec3 # Position in 3D.
function PATHLINE:GetPoint3DFromIndex(n) end

---Get the 2D position of the n-th point.
---@param n? number The n-th point.
---@return Vec2 # Position in 3D.
function PATHLINE:GetPoint2DFromIndex(n) end

---Calculate the length of the line.
---@param Project2D? boolean Calculate 2D distance between points.
---@return number # Length in meters.
function PATHLINE:GetLength(Project2D) end

---Mark points on F10 map.
---@param Switch? boolean If `true` or nil, set marks. If `false`, remove marks.
---@return PATHLINE # self
function PATHLINE:MarkPoints(Switch) end

---Draw line on F10 map.
---@param Recipient? number Recipent of the line: -1=All.
---@param Color? table (optional) Color as RGB table plus alpha value. Default {1, 0, 0, 1.0}.
---@param LineType? number (optional) Line type: 1=Solid (default).
---@return PATHLINE # self
function PATHLINE:DrawLine(Recipient, Color, LineType) end

---Remove line on F10 map.
---@param Delay? number Delay in seconds before line is removed.
---@return PATHLINE # self
function PATHLINE:UnDrawLine(Delay) end

---Get 3D points of pathline.
---@param Vec? Vec3 Position vector. Can also be a DCS#Vec2 in which case the altitude at landheight is taken.
---@return PATHLINE.Point
function PATHLINE:_CreatePoint(Vec) end
