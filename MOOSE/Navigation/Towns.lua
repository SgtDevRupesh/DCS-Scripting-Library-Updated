---@meta

---@class TOWNS.Town
---@field display_name string Displayed name.
---@field name string Name of the town.
---@field latitude number Latitude.
---@field longitude number Longitude
---@field vec3 Vec3 Position vector 3D.
---@field coordinate COORDINATE The coordinate.
---@field coordRoad COORDINATE The coordinate of the closest road.
---@field coordRail COORDINATE The coordinate of the closest railway.
---@field markerID number ID for the F10 marker.

---TOWNS class.
---@class TOWNS : BASE
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field towns table Towns.
TOWNS = {
  ClassName  =   "TOWNS",
  verbose    =         0,
  towns      =        {},
}

---TOWNS class version.
TOWNS.version = "0.1.0"

---Create a new TOWNS class instance from a given table.
---@param TownTable? table Table with all towns data.
---@return TOWNS # self
function TOWNS:NewFromTable(TownTable) end

---Create a new TOWNS class instance from a given file.
---@param FileName? string Full path to the file containing the towns data.
---@return TOWNS # self
function TOWNS:NewFromFile(FileName) end

---Get 3D position vector of a specific town.
---@param town? TOWNS.Town|number|string The town data structure.
---@return Vec3 # Position vector.
function TOWNS:GetVec3(town) end

---Get COORDINATE of a specific town.
---@param town? TOWNS.Town|number|string The town data structure.
---@return COORDINATE # The coordinate.
function TOWNS:GetCoordinate(town) end

---Get closest road coordinate of a town.
---@param town? TOWNS.Town|number|string The town data structure.
---@return COORDINATE # The closest road coordinate.
function TOWNS:GetCoordRoad(town) end

---Get closest rail coordinate of a town.
---@param town? TOWNS.Town|number|string The town data structure.
---@return COORDINATE # The closest rail coordinate.
function TOWNS:GetCoordRail(town) end

---Get road or rail connection between two towns.
---@param townA? TOWNS.Town|number|string The town data structure.
---@param townB? TOWNS.Town|number|string The town data structure.
---@param Railroad? boolean If `true`, find rail road connection
---@return PATHLINE # Pathline connecting the two towns on road.
function TOWNS:GetConnectionRoad(townA, townB, Railroad) end

---Find closest town to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate.
---@param DistMax? number (Optional) Max search distance in meters.
---@param ExcludeList? table (Optional) List of towns excluded from the search.
---@return TOWNS.Town # The closest town.
function TOWNS:GetClosestTown(Coordinate, DistMax, ExcludeList) end

---Find closest towns to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate.
---@param Nmax? number (Optional) Max number of towns. Default 5.
---@param DistMax? number (Optional) Max search distance in meters.
---@return table # Table of #TOWNS.Town closest towns.
function TOWNS:GetClosestTowns(Coordinate, Nmax, DistMax) end

---Get table of all towns, optionally of a given type.
---@return table # Table of towns. Each element is of type #TOWN.Town.
function TOWNS:GetTowns() end

---Add markers for all towns on the F10 map.
---@param Town? TOWNS.Town|number|string (Optional) Only this specifc town.
---@return TOWNS # self
function TOWNS:MarkerShow(Town) end

---Remove markers of all towns from the F10 map.
---@param Town? TOWNS.Town|number|string (Optional) Only this specifc town.
---@return TOWNS # self
function TOWNS:MarkerRemove(Town) end

---Get text displayed in the F10 marker.
---@param town? TOWNS.Town|number|string The town data structure.
---@return string # Marker text.
function TOWNS:_GetMarkerText(town) end
