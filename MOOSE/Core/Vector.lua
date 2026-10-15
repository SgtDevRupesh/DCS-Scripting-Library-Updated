---@meta

---VECTOR class.
---@class VECTOR
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field x number Component pointing North if > 0 and South if < 0.
---@field y number Component pointing up if >0 and down if < 0. This describes the altitude above main sea level.
---@field z number Component pointing East if > 0 and West if < 0.
VECTOR = {
  ClassName       = "VECTOR",
  verbose         =        0,
}

---VECTOR class version.
VECTOR.version = "0.1.0"

---Create a new VECTOR class instance from given cartesian coordinates `x`, `y` and `z`, where `z` is optional.
---**Note** that whether the `z` component is passed or nil has great impact on the interpretation of the `y` component.
---If `z` is not given (`nil`), then `y` is used as `z` (the coordinate pointing East) because we always constuct a 3D vector.
---If `z` is given (not `nil`), then `y` is used as coordinate pointing up (out of plane) as for all 3D DCS vectors.
---@param x? number Component of vector along x-axis (pointing North in both 2D and 3D).
---@param y? number Component of vector along y-axis (pointing East in 2D and Up in 3D).
---@param z? number (Optional) Component of the z-axis (pointing East in 3D).
---@return VECTOR # self
function VECTOR:New(x, y, z) end

---Create a new VECTOR class instance from given 2D or 3D vector object.
---@param Vec? Vec3 Vector object with `x`, `y` and optionally `z` components. Can be a DCS#Vec2, DCS#Vec3, `COORDINATE`, `VECTOR` object.
---@return VECTOR # self
function VECTOR:NewFromVec(Vec) end

---Create a new VECTOR class instance from polar coordinates (r, phi).
---@param r? number Distance.
---@param phi? number Angle in Degrees. Note that 0° corresponds to North, 90° East etc.
---@return VECTOR # self
function VECTOR:NewFromPolar(r, phi) end

---Create a new VECTOR class instance from spherical coordinates (r, theta, phi).
---@param r? number Distance in meters with r>=0.
---@param theta? number Polar angle in Degrees measured from a fixed polar axis or zenith direction. This angle is in [0°, 180°].
---@param phi? number Azimuthal angle in Degrees. This angle is in [0°, 360°).
---@return VECTOR # self
function VECTOR:NewFromSpherical(r, theta, phi) end

---Get the directional vector that points from a given vector `a` to another given vector `b`.
---The vector is `c=-a+b=b-a`.
---@param a? VECTOR Vector a. This can also be given as any table with x, y and z components (z optional).
---@param b? VECTOR Vector b. This can also be given as any table with x, y and z components (z optional).
---@return VECTOR # Directional vector from a to b.
function VECTOR:NewDirectionalVector(a, b) end

---Creates a new VECTOR instance from given the latitude and longitude in decimal degrees (DD).
---@param Latitude? number Latitude in decimal degrees.
---@param Longitude? number Longitude in decimal degrees.
---@param Altitude? number (Optional) Altitude in meters. Default is the land height at the 2D position.
---@return VECTOR # self
function VECTOR:NewFromLLDD(Latitude, Longitude, Altitude) end

---Creates a new VECTOR instance from given latitude and longitude in degrees, minutes and seconds (DMS).
---**Note** that latitude and longitude are passed as strings and the characters `°`, `'` and `"` are important.
---@param Latitude? string Latitude in DMS as string, e.g. "`42° 24' 14.3"`".
---@param Longitude? string Longitude in DMS as string, e.g. "`42° 24' 14.3"`".
---@param Altitude? number (Optional) Altitude in meters. Default is the land height at the coordinate.
---@return VECTOR
function VECTOR:NewFromLLDMS(Latitude, Longitude, Altitude) end

---Get 2D vector as simple table.
---@return Vec2 # 2D array {x, y}.
function VECTOR:GetVec2() end

---Get 3D vector as simple table.
---@param OnSurface? boolean If `true`, the `y` component is set the land height [m] of the 2D position.
---@return Vec3 # 3D array {x=x, y=y, z=z}.
function VECTOR:GetVec3(OnSurface) end

---Get a COORDINATE object.
---@param OnSurface? boolean If `true`, the `y` component is set the land height [m] of the 2D position.
---@return COORDINATE # The COORDINATE object.
function VECTOR:GetCoordinate(OnSurface) end

---Get the distance from this vector to another vector.
---@param Vector? VECTOR Vector to which the distance is requested.
---@param Only2D? boolean If `true`, calculate only the projected 2D distance.
---@return number # Distance in meters.
function VECTOR:GetDistance(Vector, Only2D) end

---Get the directional vector that points from this VECTOR to another VECTOR `a`.
---@param a? VECTOR Vector `a`. This can also be given as any table with `x`, `y` and `z` components, where `z` is optional.
---@return VECTOR # Directional vector from this vector to `a`.
function VECTOR:GetDirectionalVectorTo(a) end

---Get the directional vector that points from another VECTOR `a` to this VECTOR.
---@param a? VECTOR Vector a. This can also be given as any table with x,y and z components (z optional).
---@return VECTOR # Directional vector from self to a.
function VECTOR:GetDirectionalVectorFrom(a) end

---Get length/norm/magnitude of this vector.
---@return number # Length of vector.
function VECTOR:GetLength() end

---Get heading of vector.
---Note that a heading of
---
---* 000° = North
---* 090° = East
---* 180° = South
---* 270° = West.
---@param To360? boolean If `true` or `nil`, adjust heading to [0,360) range. If `false`, headings not in this range can occur.
---@return number # Heading in degrees.
function VECTOR:GetHeading(To360) end

---Get the heading from this vector to another given vector.
---@param Vector? VECTOR Vector to which the heading is requested.
---@return number # Heading from this vector to the other vector in degrees.
function VECTOR:GetHeadingTo(Vector) end

---Get the heading from a given vector to this vector.
---@param Vector? VECTOR Vector from which the heading is requested.
---@return number # Heading from the other vector to this vector in degrees.
function VECTOR:GetHeadingFrom(Vector) end

---Get latitude and longitude of this vector.
---@return number # Latitude in decimal degrees (DD).
---@return number # Longitude in decimal degrees (DD).
function VECTOR:GetLatitudeLongitude() end

---Get MGRS information of this vector.
---
---`MGRS = {UTMZone = string, MGRSDigraph = string, Easting = number, Northing = number}`
---@return table # MGRS table with `UTMZone`, `MGRSDiGraph`, `Easting` and `Northing` keys.
function VECTOR:GetMGRS() end

---Get the difference of the heading of this vector w.
---
---**Example 1:**
---This vector has a heading of 90° (pointing East) and the other vector has a heading of 225° (pointing South-West),
---we would optain a delta of 225°-90°=135°.
---
---**Example 2:**
---This vector has a heading of 180 (pointing South) and the other vector has a heading of 90° (pointing East),
---we would optain a delta of 90°-180°=-90°.
---@param Vector? VECTOR Vector to which the heading is requested.
---@return number # Heading from this vector to the other vector in degrees.
function VECTOR:GetHeadingDelta(Vector) end

---Return an intermediate VECTOR between this and another given vector.
---@param Vector? VECTOR The destination vector.
---@param Fraction? number (Optional) The fraction (0,1) where the new vector is created. Default 0.5, *i.e.* in the middle.
---@return VECTOR # Vector between this and the other vector.
function VECTOR:GetIntermediateVector(Vector, Fraction) end

---Set length/norm/magnitude of this vector.
---@param Length? number Desired length of vector.
function VECTOR:SetLength(Length) end

---Set x-component of vector. The x-axis points to the North.
---@param x? number (Optional) Value of x. Default 0.
---@return VECTOR # self
function VECTOR:SetX(x) end

---Set y-component of vector. The y-axis points to the upwards and describes the altitude above mean sea level.
---@param y? number (Optional) Value of y. Default land/surface height at this point.
---@return VECTOR # self
function VECTOR:SetY(y) end

---Set z-component of vector. The z-axis points to the East.
---@param z? number (Optional) Value of z. Default 0.
---@return VECTOR # self
function VECTOR:SetZ(z) end

---Add a vector to this. This function works for DCS#Vec2, DCS#Vec3, VECTOR, COORDINATE objects.
---Note that if you want to add a VECTOR, you can also simply use the `+` operator.
---@param Vec? Vec3 Vector to add. Can also be a DCS#Vec2, DCS#Vec3, COORDINATE or VECTOR object.
---@return VECTOR # self
function VECTOR:AddVec(Vec) end

---Subtract a vector from this one. This function works for DCS#Vec2, DCS#Vec3, VECTOR, COORDINATE objects.
---
---**Note** that if you want to add a VECTOR, you can also simply use the `-` operator.
---@param Vec? Vec3 Vector to substract. Can also be a DCS#Vec2, DCS#Vec3, COORDINATE or VECTOR object.
---@return VECTOR # self
function VECTOR:SubVec(Vec) end

---Calculate the dot product of this VECTOR with another vector. This function works for DCS#Vec2, DCS#Vec3, VECTOR, COORDINATE objects.
---@param Vec? Vec3 The other vector. Can also be a DCS#Vec2, DCS#Vec3, COORDINATE or VECTOR object.
---@return number # Dot product Sum_i(a[i]*b[i]). Note that this is a **scalar** and not a vector any more!
function VECTOR:Dot(Vec) end

---Calculate the rotation or cross product of this VECTOR with another vector. This function works for DCS#Vec2, DCS#Vec3, VECTOR, COORDINATE objects.
---@param Vec? Vec3 The other vector. Can also be a DCS#Vec2, DCS#Vec3, COORDINATE or VECTOR object.
---@return VECTOR # The cross product vector.
function VECTOR:Rot(Vec) end

---Get a clone (deep copy) of this vector.
---@return VECTOR # Copy of the vector.
function VECTOR:Copy() end

---Replace this vector with another one.
---If the given vector is 2D, we
---@param Vector? VECTOR The vector that is used to replace this vector.
---@param Project2D? boolean If `true` and the given vector is 2D, we project the updated vector to 2D (`y=0`). Otherwise, we leave `y` untouched.
---@return VECTOR # self updated
function VECTOR:Replace(Vector, Project2D) end

---Normalize this vector, so that has a length of 1.
---@return VECTOR # self
function VECTOR:Normalize() end

---Translate the vector by a given distance and angle.
---@param Distance? number (Optional) Distance in meters. Default 1000 meters.
---@param Heading? number (Optional) Heading angle in degrees. Default 0° = North.
---@param Copy? boolean Create a copy of the VECTOR so the original stays unchanged.
---@return VECTOR # The translated vector or a copy of it.
function VECTOR:Translate(Distance, Heading, Copy) end

---Rotate the VECTOR clockwise in the 2D (x,z) plane.
---@param Angle? number (Optional) Rotation angle in degrees). Default 0.
---@param Copy? boolean Create a copy of the VECTOR so the original stays unchanged.
---@return VECTOR # The translated vector or a copy of it.
function VECTOR:Rotate2D(Angle, Copy) end

---Provides an MGRS string.
---@param Settings? SETTINGS (Optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The MGRS text.
function VECTOR:ToStringMGRS(Settings) end

---Get the surface type at the vector.
---
---* LAND = 1
---* SHALLOW_WATER = 2
---* WATER = 3
---* ROAD = 4
---* RUNWAY = 5
---@return number # Surface type
function VECTOR:GetSurfaceType() end

---Get the name of surface type at the vector.
---
---* LAND = 1
---* SHALLOW_WATER = 2
---* WATER = 3
---* ROAD = 4
---* RUNWAY = 5
---@return string # Surface type name
function VECTOR:GetSurfaceTypeName() end

---Check if a given vector has line of sight with this vector.
---@param Vec? VECTOR The other vector.
---@return number # Surface Type
function VECTOR:IsVisible(Vec) end

---Get a vector on the closest road.
---@return VECTOR # Closest vector to a road.
function VECTOR:GetClosestRoad() end

---Get a vector on the closest railroad.
---@return VECTOR # Closest vector to a railroad.
function VECTOR:GetClosestRailroad() end

---Get the path on road from this vector to a given other vector.
---@param Vec? VECTOR The destination vector.
---@return PATHLINE # Pathline with points on road.
function VECTOR:GetPathOnRoad(Vec) end

---Get profile of the land between the two passed points.
---@param Vec3? VECTOR The 3D destination vector. If a 2D vector is passed, `y` is set to the land height.
---@return PATHLINE # Pathline with points of the profile.
function VECTOR:GetProfile(Vec3) end

---Returns an intercept point at which a ray drawn from the this vector in the passed normalized direction for a specified distance.
---@param DirectionVector? Vec3 Directional vector.
---@param Distance? number (Optional) Distance in meters. Default 1000 m.
---@return VECTOR # Intercept vector. Can be `nil` if no intercept point is found.
function VECTOR:GetInterceptPoint(DirectionVector, Distance) end

---Returns the distance from sea level at this vector.
---@return number # Distance above sea leavel in meters.
function VECTOR:GetSurfaceHeight() end

---Returns the distance from sea level at this vector.
---@return number # Heigh above sea leavel in meters.
---@return number # Depth (positive) at this point in meters.
function VECTOR:GetSurfaceHeightAndDepth() end

---Returns a velocity vector of the wind at this vector. Turbolences can be optionally be included.
---@param WithTurbulence? boolean If `true`, return wind including turbulence.
---@return VECTOR # Velocity 3D vector [m/s] the wind is blowing to.
function VECTOR:GetWindVector(WithTurbulence) end

---Returns a temperature and pressure at this vector.
---@return number # Temperatur in Kelvin.
---@return number # Pressure in Pascals.
function VECTOR:GetTemperaturAndPressure() end

---Creates a smoke at this vector.
---@param Color? number (Optional) Color of the smoke: 0=Green, 1=Red, 2=White, 3=Orange, 4=Blue. Default 0.
---@param Duration? number (Optional) Duration of the smoke in seconds. Default nil.
---@return string # Name of the smoke object. Can be used to stop it.
function VECTOR:Smoke(Color, Duration) end

---Creates a large smoke and fire effect of a specified type and density at this vector.
---
---* 1 = small smoke and fire
---* 2 = medium smoke and fire
---* 3 = large smoke and fire
---* 4 = huge smoke and fire
---* 5 = small smoke
---* 6 = medium smoke
---* 7 = large smoke
---* 8 = huge smoke
---@param Preset? number (Optional) Preset of smoke. Default `BIGSMOKEPRESET.LargeSmokeAndFire`.
---@param Density? number (Optional) Density between [0,1]. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@return string # Name of the smoke. Can be used to stop it.
function VECTOR:SmokeAndFire(Preset, Density, Duration) end

---Stop smoke or fire effect.
---@param Name? string Name of the smoke object.
---@param Delay? number Delay in seconds before the smoke is stopped.
---@return VECTOR # self
function VECTOR:StopSmoke(Name, Delay) end

---Creates an illumination bomb at the specified point.
---@param Power? number (Optional) The power in Candela (cd). Should be between 1 and 1000000. Default 1000 cd.
---@param Altitude? number (Optional) Altitude [m] at which the illumination bomb is created.
---@return VECTOR # self
function VECTOR:IlluminationBomb(Power, Altitude) end

---Creates an explosion at a given point at the specified power.
---@param Power? number (Optional) The power in kg TNT. Default 100 kg.
---@return VECTOR # self
function VECTOR:Explosion(Power) end

---Creates a signal flare at the given point in the specified color. The flare will be launched in the direction of the azimuth angle.
---@param Color? number (Optional) Color of flare. Default Green.
---@param Azimuth? number (Optional) Azimuth angle in degrees. Default 0.
---@return VECTOR # self
function VECTOR:Flare(Color, Azimuth) end

---Creates a arrow from this VECTOR to another vector on the F10 map.
---@param Vector? VECTOR The vector defining the endpoint.
---@param Coalition? number (Optional) Coalition Id: -1=All, 0=Neutral, 1=Red, 2=Blue. Default -1.
---@param Color? table (Optional) RGB color with alpha {r, g, b, alpha}. Default {1, 0, 0, 0.7}.
---@param FillColor? table (Optional) RGB color with alpha {r, g, b, alpha}. Default {1, 0, 0, 0.5}.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot Dash, 5=Long Dash, 6=Two Dash. Default 1.
---@return number # Marker ID. Can be used to remove the drawing.
function VECTOR:ArrowTo(Vector, Coalition, Color, FillColor, LineType) end

---Create mark on F10 map.
---@param MarkText? string Free format text that shows the marking clarification.
---@param Recipient? number (Optional) Recipient of the mark: -1=All (default), 0=Neutral, 1=Red, 2=Blue. Can also be a `GROUP` object.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return number # Mark ID.
function VECTOR:Mark(MarkText, Recipient, ReadOnly) end

---Check if passed object is a Vector.
---@param t? table The object to be tested.
---@return boolean # Returns `true` if `t` is a #VECTOR and `false` otherwise.
function VECTOR._IsVector(t) end

---Meta function to add vectors together.
---@param a? VECTOR Vector a.
---@param b? VECTOR Vector b.
---@return VECTOR # Returns a new VECTOR c with c[i]=a[i]+b[i] for i=x,y,z.
function VECTOR.__add(a, b) end

---Meta function to subtract vectors.
---@param a? VECTOR Vector a.
---@param b? VECTOR Vector b.
---@return VECTOR # Returns a new VECTOR c with c[i]=a[i]-b[i] for i=x,y,z.
function VECTOR.__sub(a, b) end

---Meta function to multiplicate vector by another vector or a scalar.
---@param a? VECTOR Vector a. Can also be a #number.
---@param b? VECTOR Vector b. Can also be a #number.
---@return VECTOR # Returns a new VECTOR c with c[i]=a[i]*b[i] for i=x,y,z.
function VECTOR.__mul(a, b) end

---Meta function for dividing a vector by a scalar or by another vector.
---@param a? VECTOR Vector a.
---@param b? VECTOR Vector b. Can also be a #number.
---@return VECTOR # Returns a new VECTOR c with c[i]=a[i]/b or c[i]=a[i]/b[i] for i=x,y,z.
function VECTOR.__div(a, b) end

---Meta function to make vectors negative.
---@param v? VECTOR Vector v.
function VECTOR.__unm(v) end

---Meta function to check if two vectors are equal.
---@param a? VECTOR Vector a.
---@param b? VECTOR Vector b.
---@return boolean # If `true`, both vectors are equal
function VECTOR.__eq(a, b) end

---Meta function to change how vectors appear as string.
---@return string # String representation of vector.
function VECTOR:__tostring() end
