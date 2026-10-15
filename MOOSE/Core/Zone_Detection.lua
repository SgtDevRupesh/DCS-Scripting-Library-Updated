---@meta

---@class ZONE_DETECTION : ZONE_BASE
---@field Vec2 Vec2 The current location of the zone.
---@field Radius number The radius of the zone.
ZONE_DETECTION = {
  ClassName="ZONE_DETECTION",
  }

---Constructor of {#ZONE_DETECTION}, taking the zone name, the zone location and a radius.
---@param ZoneName? string Name of the zone.
---@param Detection? DETECTION_BASE The detection object defining the locations of the central detections.
---@param Radius? number The radius around the detections defining the combined zone.
---@return ZONE_DETECTION # self
function ZONE_DETECTION:New(ZoneName, Detection, Radius) end

---Bounds the zone with tires.
---@param Points? number (optional) The amount of points in the circle. Default 360.
---@param CountryID? country.id|number|string The country id of the tire objects, e.g. country.id.USA for blue or country.id.RUSSIA for red.
---@param UnBound? boolean (Optional) If true the tyres will be destroyed.
---@return ZONE_DETECTION # self
function ZONE_DETECTION:BoundZone(Points, CountryID, UnBound) end

---Smokes the zone boundaries in a color.
---@param SmokeColor? SMOKECOLOR The smoke color.
---@param Points? number (optional) The amount of points in the circle.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@param AngleOffset? any
---@return ZONE_DETECTION # self
function ZONE_DETECTION:SmokeZone(SmokeColor, Points, AddHeight, AngleOffset) end

---Flares the zone boundaries in a color.
---@param FlareColor? FLARECOLOR The flare color.
---@param Points? number (optional) The amount of points in the circle.
---@param Azimuth? Azimuth (optional) Azimuth The azimuth of the flare.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@return ZONE_DETECTION # self
function ZONE_DETECTION:FlareZone(FlareColor, Points, Azimuth, AddHeight) end

---Returns the radius around the detected locations defining the combine zone.
---@return number # The radius.
function ZONE_DETECTION:GetRadius() end

---Sets the radius around the detected locations defining the combine zone.
---@param Radius? number The radius.
---@return ZONE_DETECTION # self
function ZONE_DETECTION:SetRadius(Radius) end

---Returns if a location is within the zone.
---@param Vec2? Vec2 The location to test.
---@return boolean # true if the location is within the zone.
function ZONE_DETECTION:IsVec2InZone(Vec2) end

---Returns if a point is within the zone.
---@param Vec3? Vec3 The point to test.
---@return boolean # true if the point is within the zone.
function ZONE_DETECTION:IsVec3InZone(Vec3) end
