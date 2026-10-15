---@meta

---@class RADIOS.Frequency
---@field modu number Modulation type.
---@field freq number Frequency in Hz.

---@class RADIOS.Radio
---@field radioId string Radio ID.
---@field role table Roles of the radio (usually {"ground", "tower", "approach"}).
---@field callsign table Callsigns of the radio (usually the airbase name).
---@field frequency table Frequencies of the radios.
---@field position table Position table.
---@field sceneObjects table Scenery objects.
---@field name string Name of the airbase.
---@field airbase AIRBASE Airbase.
---@field coordinate COORDINATE The COORDINATE of the radio.
---@field vec3 Vec3 3D vector.
---@field markerID number Marker ID.

---RADIOS class.
---@class RADIOS : BASE
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field radios table Radios.
RADIOS = {
  ClassName  = "RADIOS",
  verbose    =        0,
  radios    =        {},
}

---RADIOS class version.
RADIOS.version = "0.1.0"

---Create a new RADIOS class instance from a given table.
---@param RadioTable? table Table with radios info.
---@return RADIOS # self
function RADIOS:NewFromTable(RadioTable) end

---Create a new RADIOS class instance from a given file.
---@param FileName? string Full path to the file containing the map radios.
---@return RADIOS # self
function RADIOS:NewFromFile(FileName) end

---Get 3D position vector of a specific radio.
---@param radio? RADIOS.Radio|number|string The radio data structure.
---@return Vec3 # Position vector.
function RADIOS:GetVec3(radio) end

---Get COORDINATE of a specific radio.
---@param radio? RADIOS.Radio|number|string The radio data structure.
---@return COORDINATE # The coordinate.
function RADIOS:GetCoordinate(radio) end

---Find closest radio to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate.
---@param DistMax? number (Optional) Max search distance in meters.
---@param ExcludeList? table (Optional) List of radios to exclude.
---@return RADIOS.Radio # The closest radio.
function RADIOS:GetClosestRadio(Coordinate, DistMax, ExcludeList) end

---Find closest radios to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate.
---@param Nmax? number (Optional) Max number of radios. Default 5.
---@param DistMax? number (Optional) Max search distance in meters.
---@return table # Table of #RADIOS.Radio closest radios.
function RADIOS:GetClosestRadios(Coordinate, Nmax, DistMax) end

---Add markers for all radios on the F10 map.
---@param Radio? RADIOS.Radio|number|string (Optional) Only this specifc radio.
---@return RADIOS # self
function RADIOS:MarkerShow(Radio) end

---Remove markers of all radios from the F10 map.
---@param Radio? RADIOS.Radio|number|string (Optional) Only this specifc radio.
---@return RADIOS # self
function RADIOS:MarkerRemove(Radio) end

---Get text displayed in the F10 marker.
---@param radio? RADIOS.Radio|number|string The radio data structure.
---@return string # Marker text.
function RADIOS:_GetMarkerText(radio) end

---Get converted frequency.
---@param freq? number Frequency in Hz.
---@return number # Frequency in better unit.
---@return string # Unit ("Hz", "kHz", "MHz").
function RADIOS:_GetFrequency(freq) end

---Get name of frequency band.
---@param BandNumber? number Band as number.
---@return string # Band name.
function RADIOS:_GetBandName(BandNumber) end

---Get name of frequency band.
---@param airbasenames? table Names of all airbases.
---@param name? string Name of airbase.
---@return string # Name of airbase
function RADIOS:_GetAirbaseName(airbasenames, name) end

---Get name of frequency band.
---@param airbases? table Table of airbases.
---@param aid? number Airbase ID.
---@return AIRBASE # Airbase matching the ID or nil.
function RADIOS:_GetAirbaseByID(airbases, aid) end
