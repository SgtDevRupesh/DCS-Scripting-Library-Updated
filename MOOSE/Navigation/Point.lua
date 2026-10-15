---@meta

---NAVFIX class.
---@class NAVFIX : BASE
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field name string Name of the point.
---@field typePoint string Type of the point, *e.g. "Intersection", "VOR", "Airport".
---@field vector VECTOR Position vector of the fix.
---@field marker MARKER Marker on F10 map.
---@field altMin number Minimum altitude in meters.
---@field altMax number Maximum altitude in meters.
---@field speedMin number Minimum speed in knots.
---@field speedMax number Maximum speed in knots.
---@field isCompulsory boolean Is this a compulsory fix.
---@field isFlyover boolean Is this a flyover fix (`true`) or turning point otherwise.
---@field isFAF boolean Is this a final approach fix.
---@field isIAF boolean Is this an initial approach fix.
---@field isIF boolean Is this an initial fix.
---@field isMAF boolean Is this an initial fix.
NAVFIX = {
  ClassName       = "NAVFIX",
  verbose         =          0,
}

---Type of point.
---@class NAVFIX.Type
---@field POINT string Waypoint.
---@field INTERSECTION string Intersection of airway.
---@field AIRPORT string Airport.
---@field VOR string Very High Frequency Omnidirectional Range Station.
---@field DME string Distance Measuring Equipment.
---@field NDB string Non-Directional Beacon.
---@field VORDME string Combined VHF omnidirectional range (VOR) with a distance-measuring equipment (DME).
---@field LOC string Localizer.
---@field ILS string Instrument Landing System.
---@field TACAN string TACtical Air Navigation System (TACAN).
NAVFIX.Type={
  POINT="Point",
  INTERSECTION="Intersection",
  AIRPORT="Airport",
  NDB="NDB",
  VOR="VOR",
  DME="DME",
  VORDME="VOR/DME",
  LOC="Localizer",
  ILS="ILS",
  TACAN="TACAN"
}

---NAVFIX class version.
NAVFIX.version = "0.1.0"

---Create a new NAVFIX class instance from a given VECTOR.
---@param Name? string Name/ident of the point. Should be unique!
---@param Type? string (Optional) Type of the point. Default `NAVFIX.Type.POINT`.
---@param Vector? VECTOR Position vector of the navpoint.
---@return NAVFIX # self
function NAVFIX:NewFromVector(Name, Type, Vector) end

---Create a new NAVFIX class instance from a given COORDINATE.
---@param Name? string Name of the fix. Should be unique!
---@param Type? string (Optional) Type of the point. Default `NAVFIX.Type.POINT`.
---@param Coordinate? COORDINATE Coordinate of the point.
---@return NAVFIX # self
function NAVFIX:NewFromCoordinate(Name, Type, Coordinate) end

---Create a new NAVFIX instance from given latitude and longitude in degrees, minutes and seconds (DMS).
---@param Name? string Name of the fix. Should be unique!
---@param Type? string (Optional) Type of the point. Default `NAVFIX.Type.POINT`.
---@param Latitude? string Latitude in DMS as string.
---@param Longitude? string Longitude in DMS as string.
---@return NAVFIX # self
function NAVFIX:NewFromLLDMS(Name, Type, Latitude, Longitude) end

---Create a new NAVFIX instance from given latitude and longitude in decimal degrees (DD).
---@param Name? string Name of the fix. Should be unique!
---@param Type? string (Optional) Type of the point. Default `NAVFIX.Type.POINT`.
---@param Latitude? number Latitude in DD.
---@param Longitude? number Longitude in DD.
---@return NAVFIX # self
function NAVFIX:NewFromLLDD(Name, Type, Latitude, Longitude) end

---Create a new NAVFIX class instance relative to a given other NAVFIX.
---You have to specify the distance and bearing from the new point to the given point. *E.g.*, for a distance of 5 NM and a bearing of 090° (West), the
---new nav point is created 5 NM East of the given nav point. The reason is that this corresponts to convention used in most maps.
---You can, however, use the `Reciprocal` switch to create the new point in the direction you specify.
---@param Name? string Name of the fix. Should be unique!
---@param Type? string Type of navfix.
---@param NavFix? NAVFIX The given/existing navigation fix relative to which the new fix is created.
---@param Distance? number Distance from the given to the new point in nautical miles.
---@param Bearing? number Bearing [Deg] from the new point to the given one.
---@param Reciprocal? boolean If `true` the reciprocal `Bearing` is taken so it specifies the direction from the given point to the new one.
---@return NAVFIX # self
function NAVFIX:NewFromNavFix(Name, Type, NavFix, Distance, Bearing, Reciprocal) end

---Create a new NAVFIX class instance from  BEACONS.Beacon data.
---@param Beacon? BEACONS.Beacon|number|string The beacon data.
---@return NAVFIX # self
function NAVFIX:NewFromBeacon(Beacon) end

---Set whether this is the intermediate fix (IF).
---@param IntermediateFix? any
---@return NAVFIX # self
function NAVFIX:SetIntermediateFix(IntermediateFix) end

---Set whether this is an initial approach fix (IAF).
---The IAF is the point where the initial approach segment of an instrument approach begins.
---It is usually a designated intersection, VHF omidirectional range (VOR) non-directional beacon (NDB)
---or distance measuring equipment (DME) fix.
---The IAF may be collocated with the intermediate fix (IF) of the instrument apprach an in such case they designate the
---beginning of the intermediate segment of the approach. When the IAF and the IF are combined, there is no inital approach segment.
---@param IntermediateFix? boolean If `true`, this is an intermediate fix.
---@return NAVFIX # self
function NAVFIX:SetInitialApproachFix(IntermediateFix) end

---Set whether this is the final approach fix (FAF).
---@param FinalApproachFix? boolean If `true`, this is a final approach fix.
---@return NAVFIX # self
function NAVFIX:SetFinalApproachFix(FinalApproachFix) end

---Set whether this is the final approach fix (FAF).
---@param MissedApproachFix? any
---@return NAVFIX # self
function NAVFIX:SetMissedApproachFix(MissedApproachFix) end

---Set minimum altitude.
---@param Altitude? number Min altitude in feet.
---@return NAVFIX # self
function NAVFIX:SetAltMin(Altitude) end

---Set maximum altitude.
---@param Altitude? number Max altitude in feet.
---@return NAVFIX # self
function NAVFIX:SetAltMax(Altitude) end

---Set mandatory altitude (min alt = max alt).
---@param Altitude? number Altitude in feet.
---@return NAVFIX # self
function NAVFIX:SetAltMandatory(Altitude) end

---Set minimum allowed speed at this fix.
---@param Speed? number Min speed in knots.
---@return NAVFIX # self
function NAVFIX:SetSpeedMin(Speed) end

---Set maximum allowed speed at this fix.
---@param Speed? number Max speed in knots.
---@return NAVFIX # self
function NAVFIX:SetSpeedMax(Speed) end

---Set mandatory speed (min speed = max speed) at this fix.
---@param Speed? number Mandatory speed in knots.
---@return NAVFIX # self
function NAVFIX:SetSpeedMandatory(Speed) end

---Set whether this fix is compulsory.
---@param Compulsory? boolean If `true`, this is a compulsory fix. If `false` or nil, it is non-compulsory.
---@return NAVFIX # self
function NAVFIX:SetCompulsory(Compulsory) end

---Set whether this is a fly-over fix fix.
---@param FlyOver? boolean If `true`, this is a fly over fix. If `false` or nil, it is not.
---@return NAVFIX # self
function NAVFIX:SetFlyOver(FlyOver) end

---Get the altitude in feet MSL. If min and max altitudes are set, it will return a random altitude between min and max.
---@return number # Altitude in feet MSL. Can be `nil`, if neither min nor max altitudes have beeen set.
function NAVFIX:GetAltitude() end

---Get the speed. If min and max speeds are set, it will return a random speed between min and max.
---@return number # Speed in knots. Can be `nil`, if neither min nor max speeds have beeen set.
function NAVFIX:GetSpeed() end

---Add marker the NAVFIX on the F10 map.
---@return NAVFIX # self
function NAVFIX:MarkerShow() end

---Remove marker of the NAVFIX from the F10 map.
---@return NAVFIX # self
function NAVFIX:MarkerRemove() end

---Get text displayed in the F10 marker.
---@return string # Marker text.
function NAVFIX:_GetMarkerText() end

---NAVAID class.
---@class NAVAID : NAVFIX
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
NAVAID = {
  ClassName       = "NAVAID",
  verbose         =       0,
}

---NAVAID class version.
NAVAID.version = "0.1.0"

---Create a new NAVAID class instance.
---@param Name? string Name/ident of this navaid.
---@param Type? string (Optional) Type of the point. Default `NAVFIX.Type.POINT`.
---@param ZoneName? string Name of the zone to scan the scenery.
---@param SceneryName? string Name of the scenery object.
---@return NAVAID # self
function NAVAID:NewFromScenery(Name, Type, ZoneName, SceneryName) end

---Set frequency the beacon transmits on.
---@param Frequency? number Frequency in Hz.
---@return NAVAID # self
function NAVAID:SetFrequency(Frequency) end

---Set channel of, *e.g.*, TACAN beacons.
---@param Channel? number The channel.
---@param Band? string (Optional) The band either `"X"` (default) or `"Y"`.
---@return NAVAID # self
function NAVAID:SetChannel(Channel, Band) end
