---@meta

---@class BEACONS.Beacon
---@field display_name function Function that returns the localized name.
---@field type number Beacon type.
---@field beaconId string Beacon ID.
---@field callsign string Call sign.
---@field frequency number Frequency in Hz.
---@field channel number TACAN, RSBN or PRMG channel depending on type.
---@field position table Position table.
---@field direction number Direction in degrees.
---@field positionGeo table Table with latitude and longitude.
---@field sceneObjects table Table with scenery objects, e.g. `{t:393396742}`.
---@field chartOffsetX number No idea what this offset is?!
---@field vec3 Vec3 Position vector 3D.
---@field markerID number ID for the F10 marker.
---@field typeName string Name of becon type.
---@field scenery SCENERY The scenery object.

---BEACONS class.
---@class BEACONS : BASE
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field beacons table Beacons.
BEACONS = {
  ClassName  = "BEACONS",
  verbose    =         1,
  beacons    =        {},
}

---BEACONS class version.
BEACONS.version = "0.1.0"

---Create a new BEACONS class instance from a given table.
---@param BeaconTable? table Table with beacon info.
---@return BEACONS # self
function BEACONS:NewFromTable(BeaconTable) end

---Create a new BEACONS class instance from a given file.
---@param FileName? string Full path to the file containing the map beacons.
---@return BEACONS # self
function BEACONS:NewFromFile(FileName) end

---Get 3D position vector of a specific beacon.
---@param beacon? BEACONS.Beacon|number|string The beacon data structure.
---@return Vec3 # Position vector.
function BEACONS:GetVec3(beacon) end

---Get COORDINATE of a specific beacon.
---@param beacon? BEACONS.Beacon|number|string The beacon data structure.
---@return COORDINATE # The coordinate.
function BEACONS:GetCoordinate(beacon) end

---Find closest beacon to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate.
---@param TypeID? number (Optional) Only search for specific beacon types, *e.g.* `BEACON.Type.TACAN`.
---@param DistMax? number (Optional) Max search distance in meters.
---@param ExcludeList? table (Optional) List of beacons to exclude.
---@return BEACONS.Beacon # The closest beacon.
function BEACONS:GetClosestBeacon(Coordinate, TypeID, DistMax, ExcludeList) end

---Find closest beacons to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate.
---@param Nmax? number (Optional) Max number of beacons. Default 5.
---@param TypeID? number (Optional) Only search for specific beacon types, *e.g.* `BEACON.Type.TACAN`.
---@param DistMax? number (Optional) Max search distance in meters.
---@return table # Table of #BEACONS.Beacon closest beacons.
function BEACONS:GetClosestBeacons(Coordinate, Nmax, TypeID, DistMax) end

---Get table of all beacons, optionally of a given type.
---@param TypeID? number (Optional) Only return specific beacon types, *e.g.* `BEACON.Type.TACAN`. Can be handed in as tanle of beacon types.
---@return table # Table of beacons. Each element is of type #BEACON.Beacon.
function BEACONS:GetBeacons(TypeID) end

---Count beacons, optionally of a given type.
---@param TypeID? number (Optional) Only count specific beacon types, *e.g.* `BEACON.Type.TACAN`.
---@return number # Number of beacons.
function BEACONS:CountBeacons(TypeID) end

---Add markers for all beacons on the F10 map. Optionally, only a specific beacon or a certain beacon type can be marked.
---@param Beacon? BEACONS.Beacon|number|string (Optional) Only this specifc beacon.
---@param TypeID? number (Optional) Only show specific beacon types, *e.g.* `BEACON.Type.TACAN`.
---@return BEACONS # self
function BEACONS:MarkerShow(Beacon, TypeID) end

---Remove markers of all beacons from the F10 map. Optionally, remove only marker of a specific beacon or a certain beacon type.
---@param Beacon? BEACONS.Beacon|number|string (Optional) Only this specifc beacon.
---@param TypeID? number (Optional) Only show specific beacon types, *e.g.* `BEACON.Type.TACAN`.
---@return BEACONS # self
function BEACONS:MarkerRemove(Beacon, TypeID) end

---Get text displayed in the F10 marker.
---@param beacon? BEACONS.Beacon|number|string The beacon data structure.
---@return string # Marker text.
function BEACONS:_GetMarkerText(beacon) end

---Get converted frequency.
---@param freq? number Frequency in Hz.
---@return number # Frequency in better unit.
---@return string # Unit ("Hz", "kHz", "MHz").
function BEACONS:_GetFrequency(freq) end

---Get name of beacon type.
---@param typeID? number Beacon type number.
---@return string # Type name.
function BEACONS:_GetTypeName(typeID) end
