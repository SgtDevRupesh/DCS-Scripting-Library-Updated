---@meta

---Coordinate class
---@class COORDINATE : BASE
---@field ClassName string Name of the class
---@field x number Component of the 3D vector.
---@field y number Component of the 3D vector.
---@field z number Component of the 3D vector.
---@field Heading number Heading in degrees. Needs to be set first.
---@field Velocity number Velocity in meters per second. Needs to be set first.
COORDINATE = {
  ClassName = "COORDINATE",
}

---Waypoint altitude types.
---@class COORDINATE.WaypointAltType
---@field BARO string Barometric altitude.
---@field RADIO string Radio altitude.
COORDINATE.WaypointAltType = {
  BARO = "BARO",
  RADIO = "RADIO",
}

---Waypoint actions.
---@class COORDINATE.WaypointAction
---@field TurningPoint string Turning point.
---@field FlyoverPoint string Fly over point.
---@field FromParkingArea string From parking area.
---@field FromParkingAreaHot string From parking area hot.
---@field FromGroundAreaHot string From ground area hot.
---@field FromGroundArea string From ground area.
---@field FromRunway string From runway.
---@field Landing string Landing.
---@field LandingReFuAr string Landing and refuel and rearm.
COORDINATE.WaypointAction = {
  TurningPoint       = "Turning Point",
  FlyoverPoint       = "Fly Over Point",
  FromParkingArea    = "From Parking Area",
  FromParkingAreaHot = "From Parking Area Hot",
  FromGroundAreaHot  = "From Ground Area Hot",
  FromGroundArea     = "From Ground Area",
  FromRunway         = "From Runway",
  Landing            = "Landing",
  LandingReFuAr      = "LandingReFuAr",
}

---Waypoint types.
---@class COORDINATE.WaypointType
---@field TakeOffParking string Take of parking.
---@field TakeOffParkingHot string Take of parking hot.
---@field TakeOff string Take off parking hot.
---@field TakeOffGroundHot string Take of from ground hot.
---@field TurningPoint string Turning point.
---@field Land string Landing point.
---@field LandingReFuAr string Landing and refuel and rearm.
COORDINATE.WaypointType = {
  TakeOffParking    = "TakeOffParking",
  TakeOffParkingHot = "TakeOffParkingHot",
  TakeOff           = "TakeOffParkingHot",
  TakeOffGroundHot  = "TakeOffGroundHot",
  TakeOffGround     = "TakeOffGround",
  TurningPoint      = "Turning Point",
  Land              = "Land",
  LandingReFuAr     = "LandingReFuAr",    
}

---COORDINATE constructor.
---@param x? number The x coordinate of the Vec3 point, pointing to the North.
---@param y? number The y coordinate of the Vec3 point, pointing to up.
---@param z? number The z coordinate of the Vec3 point, pointing to the right.
---@return COORDINATE # self
function COORDINATE:New(x, y, z) end

---COORDINATE constructor.
---@param Coordinate? COORDINATE .
---@return COORDINATE # self
function COORDINATE:NewFromCoordinate(Coordinate) end

---Create a new COORDINATE object from  Vec2 coordinates.
---@param Vec2? Vec2 The Vec2 point.
---@param LandHeightAdd? number (Optional) The default height if required to be evaluated will be the land height of the x, y coordinate. You can specify an extra height to be added to the land height.
---@return COORDINATE # self
function COORDINATE:NewFromVec2(Vec2, LandHeightAdd) end

---Create a new COORDINATE object from  Vec3 coordinates.
---@param Vec3? Vec3 The Vec3 point.
---@return COORDINATE # self
function COORDINATE:NewFromVec3(Vec3) end

---Create a new COORDINATE object from a waypoint. This uses the components
---
--- * `waypoint.x`
--- * `waypoint.alt`
--- * `waypoint.y`
---@param Waypoint? Waypoint The waypoint.
---@return COORDINATE # self
function COORDINATE:NewFromWaypoint(Waypoint) end

---Return the coordinates itself. Sounds stupid but can be useful for compatibility.
---@return COORDINATE # self
function COORDINATE:GetCoordinate() end

---Return the coordinates of the COORDINATE in Vec3 format.
---@return Vec3 # The Vec3 format coordinate.
function COORDINATE:GetVec3() end

---Return the coordinates of the COORDINATE in Vec2 format.
---@return Vec2 # The Vec2 format coordinate.
function COORDINATE:GetVec2() end

---Update x,y,z coordinates from a given 3D vector.
---@param Vec3? Vec3 The 3D vector with x,y,z components.
---@return COORDINATE # The modified COORDINATE itself.
function COORDINATE:UpdateFromVec3(Vec3) end

---Update x,y,z coordinates from another given COORDINATE.
---@param Coordinate? COORDINATE The coordinate with the new x,y,z positions.
---@return COORDINATE # The modified COORDINATE itself.
function COORDINATE:UpdateFromCoordinate(Coordinate) end

---Update x and z coordinates from a given 2D vector.
---@param Vec2? Vec2 The 2D vector with x,y components. x is overwriting COORDINATE.x while y is overwriting COORDINATE.z.
---@return COORDINATE # The modified COORDINATE itself.
function COORDINATE:UpdateFromVec2(Vec2) end

---Returns the magnetic declination at the given coordinate.
---NOTE that this needs `require` to be available so you need to desanitize the `MissionScripting.lua` file in your DCS/Scrips folder.
---If `require` is not available, a constant value for the whole map.
---@param Month? number (Optional) The month at which the declination is calculated. Default is the mission month.
---@param Year? number (Optional) The year at which the declination is calculated. Default is the mission year.
---@return number # Magnetic declination in degrees.
function COORDINATE:GetMagneticDeclination(Month, Year) end

---Returns the coordinate from the latitude and longitude given in decimal degrees.
---@param latitude? number Latitude in decimal degrees.
---@param longitude? number Longitude in decimal degrees.
---@param altitude? number (Optional) Altitude in meters. Default is the land height at the coordinate.
---@return COORDINATE
function COORDINATE:NewFromLLDD(latitude, longitude, altitude) end

---Returns if the 2 coordinates are at the same 2D position.
---@param Coordinate? COORDINATE
---@param Precision? number
---@return boolean # true if at the same position.
function COORDINATE:IsAtCoordinate2D(Coordinate, Precision) end

---Box volume scanning function matching MOOSE COORDINATE:ScanObjects() structure
---For use as COORDINATE:ScanObjectsSquare(sideLength, scanunits, scanstatics, scanscenery)
---Creates a cubic search volume with the COORDINATE as the lower-left (southwest) corner.
---Perfect for grid-based map scanning: increment X and Z by sideLength for next grid cell.
---@param sideLength? any
---@param scanunits? boolean (Optional) If true scan for units. Default true.
---@param scanstatics? boolean (Optional) If true scan for static objects. Default true.
---@param scanscenery? boolean (Optional) If true scan for scenery objects. Default false.
---@return boolean # True if units were found.
---@return boolean # True if statics were found.
---@return boolean # True if scenery objects were found.
---@return table # Table of MOOSE @{Wrapper.Unit#UNIT} objects found.
---@return table # Table of DCS static objects found.
---@return table # Table of DCS scenery objects found.
function COORDINATE:ScanObjectsSquare(sideLength, scanunits, scanstatics, scanscenery) end

---Scan/find objects (units, statics, scenery) within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@param scanunits? boolean (Optional) If true scan for units. Default true.
---@param scanstatics? boolean (Optional) If true scan for static objects. Default true.
---@param scanscenery? boolean (Optional) If true scan for scenery objects. Default false.
---@return boolean # True if units were found.
---@return boolean # True if statics were found.
---@return boolean # True if scenery objects were found.
---@return table # Table of MOOSE @{Wrapper.Unit#UNIT} objects found.
---@return table # Table of DCS static objects found.
---@return table # Table of DCS scenery objects found.
function COORDINATE:ScanObjects(radius, scanunits, scanstatics, scanscenery) end

---Scan/find UNITS within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return SET_UNIT # Set of units.
function COORDINATE:ScanUnits(radius) end

---Scan/find STATICS within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return SET_UNIT # Set of units.
function COORDINATE:ScanStatics(radius) end

---Find the closest static to the COORDINATE within a certain radius.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return STATIC # The closest static or #nil if no unit is inside the given radius.
function COORDINATE:FindClosestStatic(radius) end

---Find the closest unit to the COORDINATE within a certain radius.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return UNIT # The closest unit or #nil if no unit is inside the given radius.
function COORDINATE:FindClosestUnit(radius) end

---Scan/find SCENERY objects within a certain radius around the coordinate using the world.searchObjects() DCS API function.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return table # Table of SCENERY objects.
function COORDINATE:ScanScenery(radius) end

---Find the closest scenery to the COORDINATE within a certain radius.
---@param radius? number (Optional) Scan radius in meters. Default 100 m.
---@return SCENERY # The closest scenery or #nil if no object is inside the given radius.
function COORDINATE:FindClosestScenery(radius) end

---Calculate the distance from a reference {#COORDINATE}.
---@param PointVec2Reference? COORDINATE The reference @{#COORDINATE}.
---@return number # The distance from the reference @{#COORDINATE} in meters.
function COORDINATE:DistanceFromPointVec2(PointVec2Reference) end

---Add a Distance in meters from the COORDINATE orthonormal plane, with the given angle, and calculate the new COORDINATE.
---@param Distance? number The Distance to be added in meters.
---@param Angle? Angle (Optional) The Angle in degrees. Defaults to 0 if not specified (nil).
---@param Keepalt? boolean (Optional) If true, keep altitude of original coordinate. Default is that the new coordinate is created at the translated land height.
---@param Overwrite? boolean If true, overwrite the original COORDINATE with the translated one. Otherwise, create a new COORDINATE.
---@return COORDINATE # The new calculated COORDINATE.
function COORDINATE:Translate(Distance, Angle, Keepalt, Overwrite) end

---Rotate coordinate in 2D (x,z) space.
---@param Angle? Angle Angle of rotation in degrees.
---@return COORDINATE # The rotated coordinate.
function COORDINATE:Rotate2D(Angle) end

---Return a random Vec2 within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---@param OuterRadius? number
---@param InnerRadius? number
---@return Vec2 # Vec2
function COORDINATE:GetRandomVec2InRadius(OuterRadius, InnerRadius) end

---Return a random Coordinate within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---@param OuterRadius? number Outer radius in meters.
---@param InnerRadius? number Inner radius in meters.
---@return COORDINATE # self
function COORDINATE:GetRandomCoordinateInRadius(OuterRadius, InnerRadius) end

---Return a random Vec3 within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---@param OuterRadius? number
---@param InnerRadius? number
---@return Vec3 # Vec3
function COORDINATE:GetRandomVec3InRadius(OuterRadius, InnerRadius) end

---Return the height of the land at the coordinate.
---@return number # Land height (ASL) in meters.
function COORDINATE:GetLandHeight() end

---Returns a table of DCS#Vec3 points representing the terrain profile between two points.
---@param Destination? any
---@return table # DCS#Vec3 table of the profile
function COORDINATE:GetLandProfileVec3(Destination) end

---Returns a table of #COORDINATE representing the terrain profile between two points.
---@param Destination? any
---@return table # #COORDINATE table of the profile
function COORDINATE:GetLandProfileCoordinates(Destination) end

---Set the heading of the coordinate, if applicable.
---@param Heading? any
function COORDINATE:SetHeading(Heading) end

---Get the heading of the coordinate, if applicable.
---@return number # or nil
function COORDINATE:GetHeading() end

---Set the velocity of the COORDINATE.
---@param Velocity? string Velocity in meters per second.
function COORDINATE:SetVelocity(Velocity) end

---Return the velocity of the COORDINATE.
---@return number # Velocity in meters per second.
function COORDINATE:GetVelocity() end

---Return the "name" of the COORDINATE. Obviously, a coordinate does not have a name like a unit, static or group. So here we take the MGRS coordinates of the position.
---@return string # MGRS coordinates.
function COORDINATE:GetName() end

---Return velocity text of the COORDINATE.
---@param Settings? any
---@return string
function COORDINATE:GetMovingText(Settings) end

---Return a direction vector Vec3 from COORDINATE to the COORDINATE.
---@param TargetCoordinate? COORDINATE The target COORDINATE.
---@return Vec3 # DirectionVec3 The direction vector in Vec3 format.
function COORDINATE:GetDirectionVec3(TargetCoordinate) end

---Get a correction in radians of the real magnetic north of the COORDINATE.
---@return number # CorrectionRadians The correction in radians.
function COORDINATE:GetNorthCorrectionRadians() end

---Return an angle in radians from the COORDINATE using a **direction vector in Vec3 format**.
---@param DirectionVec3? Vec3 The direction vector in Vec3 format.
---@return number # DirectionRadians The angle in radians.
function COORDINATE:GetAngleRadians(DirectionVec3) end

---Return an angle in degrees from the COORDINATE using a **direction vector in Vec3 format**.
---@param DirectionVec3? Vec3 The direction vector in Vec3 format.
---@return number # DirectionRadians The angle in degrees.
function COORDINATE:GetAngleDegrees(DirectionVec3) end

---Return an intermediate COORDINATE between this an another coordinate.
---@param ToCoordinate? COORDINATE The other coordinate.
---@param Fraction? number (Optional) The fraction (0,1) where the new coordinate is created. Default 0.5, i.e. in the middle.
---@return COORDINATE # Coordinate between this and the other coordinate.
function COORDINATE:GetIntermediateCoordinate(ToCoordinate, Fraction) end

---Return the 2D distance in meters between the target COORDINATE and the COORDINATE.
---@param TargetCoordinate? COORDINATE The target COORDINATE. Can also be a DCS#Vec3.
---@return number # Distance The distance in meters.
function COORDINATE:Get2DDistance(TargetCoordinate) end

---Returns the temperature in Degrees Celsius.
---@param height? any
---@return Temperature # in Degrees Celsius.
function COORDINATE:GetTemperature(height) end

---Returns a text of the temperature according the measurement system {Core.Settings}.
---The text will reflect the temperature like this:
---
---  - For Russian and European aircraft using the metric system - Degrees Celcius (°C)
---  - For American aircraft we link to the imperial system - Degrees Fahrenheit (°F)
---
---A text containing a pressure will look like this:
---
---  - `Temperature: %n.d °C`
---  - `Temperature: %n.d °F`
---@param height? any
---@param Settings? any
---@return string # Temperature according the measurement system @{Core.Settings}.
function COORDINATE:GetTemperatureText(height, Settings) end

---Returns the pressure in hPa.
---@param height? any
---@return Pressure # in hPa.
function COORDINATE:GetPressure(height) end

---Returns a text of the pressure according the measurement system {Core.Settings}.
---The text will contain always the pressure in hPa and:
---
---  - For Russian and European aircraft using the metric system - hPa and mmHg
---  - For American and European aircraft we link to the imperial system - hPa and inHg
---
---A text containing a pressure will look like this:
---
---  - `QFE: x hPa (y mmHg)`
---  - `QFE: x hPa (y inHg)`
---@param height? any
---@param Settings? any
---@return string # Pressure in hPa and mmHg or inHg depending on the measurement system @{Core.Settings}.
function COORDINATE:GetPressureText(height, Settings) end

---Returns the heading from this to another coordinate.
---@param ToCoordinate? COORDINATE
---@return number # Heading in degrees.
function COORDINATE:HeadingTo(ToCoordinate) end

---Returns the 3D wind direction vector. Note that vector points into the direction the wind in blowing to.
---@param height? number (Optional) parameter specifying the height ASL in meters. The minimum height will be always be the land height since the wind is zero below the ground.
---@param turbulence? boolean (Optional) If `true`, include turbulence.
---@return Vec3 # Wind 3D vector. Components in m/s.
function COORDINATE:GetWindVec3(height, turbulence) end

---Returns the wind direction (from) and strength.
---@param height? number (Optional) parameter specifying the height ASL. The minimum height will be always be the land height since the wind is zero below the ground.
---@param turbulence? boolean If `true`, include turbulence. If `false` or `nil`, wind without turbulence.
---@return number # Direction the wind is blowing from in degrees.
---@return number # Wind strength in m/s.
function COORDINATE:GetWind(height, turbulence) end

---Returns the wind direction (from) and strength.
---@param height? any
---@return Direction # the wind is blowing from in degrees.
function COORDINATE:GetWindWithTurbulenceVec3(height) end

---Return the x coordinate of the COORDINATE.
---@return number # The x coordinate.
function COORDINATE:GetX() end

---Return the y coordinate of the COORDINATE.
---@return number # The y coordinate.
function COORDINATE:GetY() end

---Return the z coordinate of the COORDINATE.
---@return number # The z coordinate.
function COORDINATE:GetZ() end

---Set the x coordinate of the COORDINATE.
---@param x? number The x coordinate.
---@return COORDINATE
function COORDINATE:SetX(x) end

---Set the y coordinate of the COORDINATE.
---@param y? number The y coordinate.
---@return COORDINATE
function COORDINATE:SetY(y) end

---Set the z coordinate of the COORDINATE.
---@param z? number The z coordinate.
---@return COORDINATE
function COORDINATE:SetZ(z) end

---Add to the x coordinate of the COORDINATE.
---@param x? number The x coordinate value to add to the current x coordinate.
---@return COORDINATE
function COORDINATE:AddX(x) end

---Return Return the Lat(itude) coordinate of the COORDINATE (ie: (parent)COORDINATE.x).
---@return number # The x coordinate.
function COORDINATE:GetLat() end

---Set the Lat(itude) coordinate of the COORDINATE (ie: COORDINATE.x).
---@param x? number The x coordinate.
---@return COORDINATE
function COORDINATE:SetLat(x) end

---Return the Lon(gitude) coordinate of the COORDINATE (ie: (parent)COORDINATE.z).
---@return number # The y coordinate.
function COORDINATE:GetLon() end

---Set the Lon(gitude) coordinate of the COORDINATE (ie: COORDINATE.z).
---@param z? any
---@return COORDINATE
function COORDINATE:SetLon(z) end

---Return the altitude (height) of the land at the COORDINATE.
---@return number # The land altitude.
function COORDINATE:GetAlt() end

---Set the altitude of the COORDINATE.
---@param Altitude? number The land altitude. If nothing (nil) is given, then the current land altitude is set.
---@return COORDINATE
function COORDINATE:SetAlt(Altitude) end

---Add to the current land height an altitude.
---@param Altitude? number The Altitude to add. If nothing (nil) is given, then the current land altitude is set.
---@return COORDINATE
function COORDINATE:AddAlt(Altitude) end

---Return a random COORDINATE within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---@param OuterRadius? number
---@param InnerRadius? number
---@return COORDINATE
function COORDINATE:GetRandomPointVec2InRadius(OuterRadius, InnerRadius) end

---Add to the y coordinate of the COORDINATE.
---@param y? number The y coordinate value to add to the current y coordinate.
---@return COORDINATE
function COORDINATE:AddY(y) end

---Add to the z coordinate of the COORDINATE.
---@param z? number The z coordinate value to add to the current z coordinate.
---@return COORDINATE
function COORDINATE:AddZ(z) end

---Returns a text documenting the wind direction (from) and strength according the measurement system {Core.Settings}.
---The text will reflect the wind like this:
---
---  - For Russian and European aircraft using the metric system - Wind direction in degrees (°) and wind speed in meters per second (mps).
---  - For American aircraft we link to the imperial system - Wind direction in degrees (°) and wind speed in knots per second (kps).
---
---A text containing a pressure will look like this:
---
---  - `Wind: %n ° at n.d mps`
---  - `Wind: %n ° at n.d kps`
---@param height? any
---@param Settings? any
---@return string # Wind direction and strength according the measurement system @{Core.Settings}.
function COORDINATE:GetWindText(height, Settings) end

---Return the 3D distance in meters between the target COORDINATE and the COORDINATE.
---@param TargetCoordinate? COORDINATE The target COORDINATE. Can also be a DCS#Vec3.
---@return number # Distance The distance in meters.
function COORDINATE:Get3DDistance(TargetCoordinate) end

---Provides a bearing text in degrees.
---@param AngleRadians? number The angle in randians.
---@param Precision? number The precision.
---@param Settings? SETTINGS
---@param MagVar? boolean If true, include magentic degrees
---@return string # The bearing text in degrees.
function COORDINATE:GetBearingText(AngleRadians, Precision, Settings, MagVar) end

---Provides a distance text expressed in the units of measurement.
---@param Distance? number The distance in meters.
---@param Settings? SETTINGS
---@param Language? string (optional) "EN" or "RU"
---@param Precision? number (optional) round to this many decimal places
---@return string # The distance text expressed in the units of measurement.
function COORDINATE:GetDistanceText(Distance, Settings, Language, Precision) end

---Return the altitude text of the COORDINATE.
---@param Settings? any
---@param Language? any
---@return string # Altitude text.
function COORDINATE:GetAltitudeText(Settings, Language) end

---Return the velocity text of the COORDINATE.
---@param Settings? any
---@return string # Velocity text.
function COORDINATE:GetVelocityText(Settings) end

---Return the heading text of the COORDINATE.
---@param Settings? any
---@return string # Heading text.
function COORDINATE:GetHeadingText(Settings) end

---Provides a Bearing / Range string
---@param AngleRadians? number The angle in randians
---@param Distance? number The distance
---@param Settings? SETTINGS
---@param Language? string (Optional) Language "en" or "ru"
---@param MagVar? boolean If true, also state angle in magnetic
---@param Precision? number (Optional) Rounding precision, defaults to 0
---@return string # The BR Text
function COORDINATE:GetBRText(AngleRadians, Distance, Settings, Language, MagVar, Precision) end

---Provides a Bearing / Range / Altitude string
---@param AngleRadians? number The angle in randians
---@param Distance? number The distance
---@param Settings? SETTINGS
---@param Language? string (Optional) Language "en" or "ru"
---@param MagVar? boolean If true, also state angle in magnetic
---@return string # The BRA Text
function COORDINATE:GetBRAText(AngleRadians, Distance, Settings, Language, MagVar) end

---Set altitude.
---@param altitude? number New altitude in meters.
---@param asl? boolean (Optional) Altitude above sea level. Default is above ground level.
---@return COORDINATE # The COORDINATE with adjusted altitude.
function COORDINATE:SetAltitude(altitude, asl) end

---Set altitude to be at land height (i.e. on the ground!)
function COORDINATE:SetAtLandheight() end

---Build an air type route point.
---@param AltType? COORDINATE.WaypointAltType|number|string The altitude type.
---@param Type? COORDINATE.WaypointType|number|string The route point type.
---@param Action? COORDINATE.WaypointAction|number|string The route point action.
---@param Speed? number (Optional) Airspeed in km/h. Default is 500 km/h.
---@param SpeedLocked? boolean true means the speed is locked.
---@param airbase? AIRBASE The airbase for takeoff and landing points.
---@param DCSTasks? table A table of @{DCS#Task} items which are executed at the waypoint.
---@param description? string A text description of the waypoint, which will be shown on the F10 map.
---@param timeReFuAr? number Time in minutes the aircraft stays at the airport for ReFueling and ReArming.
---@return table # The route point.
function COORDINATE:WaypointAir(AltType, Type, Action, Speed, SpeedLocked, airbase, DCSTasks, description, timeReFuAr) end

---Build a Waypoint Air "Turning Point".
---@param AltType? COORDINATE.WaypointAltType|number|string The altitude type.
---@param Speed? number Airspeed in km/h.
---@param DCSTasks? table (Optional) A table of @{DCS#Task} items which are executed at the waypoint.
---@param description? string (Optional) A text description of the waypoint, which will be shown on the F10 map.
---@return table # The route point.
function COORDINATE:WaypointAirTurningPoint(AltType, Speed, DCSTasks, description) end

---Build a Waypoint Air "Fly Over Point".
---@param AltType? COORDINATE.WaypointAltType|number|string The altitude type.
---@param Speed? number Airspeed in km/h.
---@return table # The route point.
function COORDINATE:WaypointAirFlyOverPoint(AltType, Speed) end

---Build a Waypoint Air "Take Off Parking Hot".
---@param AltType? COORDINATE.WaypointAltType|number|string The altitude type.
---@param Speed? number Airspeed in km/h.
---@return table # The route point.
function COORDINATE:WaypointAirTakeOffParkingHot(AltType, Speed) end

---Build a Waypoint Air "Take Off Parking".
---@param AltType? COORDINATE.WaypointAltType|number|string The altitude type.
---@param Speed? number Airspeed in km/h.
---@return table # The route point.
function COORDINATE:WaypointAirTakeOffParking(AltType, Speed) end

---Build a Waypoint Air "Take Off Runway".
---@param AltType? COORDINATE.WaypointAltType|number|string The altitude type.
---@param Speed? number Airspeed in km/h.
---@return table # The route point.
function COORDINATE:WaypointAirTakeOffRunway(AltType, Speed) end

---Build a Waypoint Air "Landing".
---@param Speed? number Airspeed in km/h.
---@param airbase? AIRBASE The airbase for takeoff and landing points.
---@param DCSTasks? table A table of @{DCS#Task} items which are executed at the waypoint.
---@param description? string A text description of the waypoint, which will be shown on the F10 map.
---@return table # The route point.
function COORDINATE:WaypointAirLanding(Speed, airbase, DCSTasks, description) end

---Build a Waypoint Air "LandingReFuAr". Mimics the aircraft ReFueling and ReArming.
---@param Speed? number Airspeed in km/h.
---@param airbase? AIRBASE The airbase for takeoff and landing points.
---@param timeReFuAr? number (Optional) Time in minutes, the aircraft stays at the airbase. Default 10 min.
---@param DCSTasks? table A table of @{DCS#Task} items which are executed at the waypoint.
---@param description? string A text description of the waypoint, which will be shown on the F10 map.
---@return table # The route point.
function COORDINATE:WaypointAirLandingReFu(Speed, airbase, timeReFuAr, DCSTasks, description) end

---Build an ground type route point.
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param Formation? string (Optional) The route point Formation, which is a text string that specifies exactly the Text in the Type of the route point, like "Vee", "Echelon Right".
---@param DCSTasks? table (Optional) A table of DCS tasks that are executed at the waypoints. Mind the curly brackets {}!
---@return table # The route point.
function COORDINATE:WaypointGround(Speed, Formation, DCSTasks) end

---Build route waypoint point for Naval units.
---@param Speed? number (Optional) Speed in km/h. The default speed is 20 km/h.
---@param Depth? string (Optional) Dive depth in meters. Only for submarines. Default is COORDINATE.y component.
---@param DCSTasks? table (Optional) A table of DCS tasks that are executed at the waypoints. Mind the curly brackets {}!
---@return table # The route point.
function COORDINATE:WaypointNaval(Speed, Depth, DCSTasks) end

---Gets the nearest airbase with respect to the current coordinates.
---@param Category? any (Optional) Category of the airbase. Enumerator of @{Wrapper.Airbase#AIRBASE.Category}.
---@param Coalition? number (Optional) Coalition of the airbase.
---@return AIRBASE # Closest Airbase to the given coordinate.
---@return number # Distance to the closest airbase in meters.
function COORDINATE:GetClosestAirbase(Category, Coalition) end

---[kept for downwards compatibility only] Gets the nearest airbase with respect to the current coordinates.
---@param Category? any (Optional) Category of the airbase. Enumerator of @{Wrapper.Airbase#AIRBASE.Category}.
---@param Coalition? number (Optional) Coalition of the airbase.
---@return AIRBASE # Closest Airbase to the given coordinate.
---@return number # Distance to the closest airbase in meters.
function COORDINATE:GetClosestAirbase2(Category, Coalition) end

---Gets the nearest parking spot.
---@param airbase? AIRBASE (Optional) Search only parking spots at this airbase.
---@param terminaltype? Terminaltype (Optional) Type of the terminal. Default any execpt valid spawn points on runway.
---@param free? boolean (Optional) If true, returns the closest free spot. If false, returns the closest occupied spot. If nil, returns the closest spot regardless of free or occupied.
---@return COORDINATE # Coordinate of the nearest parking spot.
---@return number # Terminal ID.
---@return number # Distance to closest parking spot in meters.
---@return ParkingSpot # Parking spot table.
function COORDINATE:GetClosestParkingSpot(airbase, terminaltype, free) end

---Gets the nearest free parking spot.
---@param airbase? AIRBASE (Optional) Search only parking spots at that airbase.
---@param terminaltype? Terminaltype (Optional) Type of the terminal.
---@return COORDINATE # Coordinate of the nearest free parking spot.
---@return number # Terminal ID.
---@return number # Distance to closest free parking spot in meters.
function COORDINATE:GetClosestFreeParkingSpot(airbase, terminaltype) end

---Gets the nearest occupied parking spot.
---@param airbase? AIRBASE (Optional) Search only parking spots at that airbase.
---@param terminaltype? Terminaltype (Optional) Type of the terminal.
---@return COORDINATE # Coordinate of the nearest occupied parking spot.
---@return number # Terminal ID.
---@return number # Distance to closest occupied parking spot in meters.
function COORDINATE:GetClosestOccupiedParkingSpot(airbase, terminaltype) end

---Gets the nearest coordinate to a road (or railroad).
---@param Railroad? boolean (Optional) If true, closest point to railroad is returned rather than closest point to conventional road. Default false.
---@return COORDINATE # Coordinate of the nearest road.
function COORDINATE:GetClosestPointToRoad(Railroad) end

---Returns a table of coordinates to a destination using only roads or railroads.
---The first point is the closest point on road of the given coordinate.
---By default, the last point is the closest point on road of the ToCoord. Hence, the coordinate itself and the final ToCoord are not necessarily included in the path.
---@param ToCoord? COORDINATE Coordinate of destination.
---@param IncludeEndpoints? boolean (Optional) Include the coordinate itself and the ToCoordinate in the path.
---@param Railroad? boolean (Optional) If true, path on railroad is returned. Default false.
---@param MarkPath? boolean (Optional) If true, place markers on F10 map along the path.
---@param SmokePath? boolean (Optional) If true, put (green) smoke along the
---@return table # Table of coordinates on road. If no path on road can be found, nil is returned or just the endpoints.
---@return number # Tonal length of path.
---@return boolean # If true a valid path on road/rail was found. If false, only the direct way is possible.
function COORDINATE:GetPathOnRoad(ToCoord, IncludeEndpoints, Railroad, MarkPath, SmokePath) end

---Returns a table of coordinates to a destination using only roads or railroads.
---The first point is the closest point on road of the given coordinate.
---By default, the last point is the closest point on road of the ToCoord. Hence, the coordinate itself and the final ToCoord are not necessarily included in the path.
---@param ToCoord? COORDINATE Coordinate of destination.
---@param IncludeEndpoints? boolean (Optional) Include the coordinate itself and the ToCoordinate in the path.
---@param Railroad? boolean (Optional) If true, path on railroad is returned. Default false.
---@return PATHLINE # Pathline containing the points on road. If no path on road can be found, nil is returned or just the endpoints.
function COORDINATE:GetPathlineOnRoad(ToCoord, IncludeEndpoints, Railroad) end

---Gets the surface type at the coordinate.
---@return SurfaceType # Surface type.
function COORDINATE:GetSurfaceType() end

---Checks if the surface type is on land.
---@return boolean # If true, the surface type at the coordinate is land.
function COORDINATE:IsSurfaceTypeLand() end

---Checks if the surface type is land.
---@return boolean # If true, the surface type at the coordinate is land.
function COORDINATE:IsSurfaceTypeLand() end

---Checks if the surface type is road.
---@return boolean # If true, the surface type at the coordinate is a road.
function COORDINATE:IsSurfaceTypeRoad() end

---Checks if the surface type is runway.
---@return boolean # If true, the surface type at the coordinate is a runway or taxi way.
function COORDINATE:IsSurfaceTypeRunway() end

---Checks if the surface type is shallow water.
---@return boolean # If true, the surface type at the coordinate is a shallow water.
function COORDINATE:IsSurfaceTypeShallowWater() end

---Checks if the surface type is water.
---@return boolean # If true, the surface type at the coordinate is a deep water.
function COORDINATE:IsSurfaceTypeWater() end

---Creates an explosion at the point of a certain intensity.
---@param ExplosionIntensity? number (Optional) Intensity of the explosion in kg TNT. Default 100 kg.
---@param Delay? number (Optional) Delay before explosion is triggered in seconds.
---@return COORDINATE # self
function COORDINATE:Explosion(ExplosionIntensity, Delay) end

---Creates an illumination bomb at the point.
---@param Power? number (Optional) Power of illumination bomb in Candela. Default 1000 cd.
---@param Delay? number (Optional) Delay before bomb is ignited in seconds.
---@return COORDINATE # self
function COORDINATE:IlluminationBomb(Power, Delay) end

---Create colored smoke the point. The smoke we last up to 5 min (DCS limitation) but you can optionally specify a shorter duration or stop it manually.
---@param SmokeColor? number Color of smoke, e.g. `SMOKECOLOR.Green` for green smoke.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@param Name? string (Optional) Name if you want to stop the smoke early (normal duration: 5mins)
---@param Offset? boolean (Optional) If true, offset the smokle a bit.
---@param Direction? number (Optional) If Offset is true this is the direction of the offset, 1-359 (degrees). Default random.
---@param Distance? number (Optional) If Offset is true this is the distance of the offset in meters. Default random 10-20.
---@return COORDINATE # self
function COORDINATE:Smoke(SmokeColor, Duration, Delay, Name, Offset, Direction, Distance) end

---Get the offset direction when using `COORDINATE:Smoke()`.
---@return number # Direction in degrees.
function COORDINATE:GetSmokeOffsetDirection() end

---Set the offset direction when using `COORDINATE:Smoke()`.
---@param Direction? number (Optional) This is the direction of the offset, 1-359 (degrees). Default random.
---@return COORDINATE # self
function COORDINATE:SetSmokeOffsetDirection(Direction) end

---Get the offset distance when using `COORDINATE:Smoke()`.
---@return number # Distance Distance in meters.
function COORDINATE:GetSmokeOffsetDistance() end

---Set the offset distance when using `COORDINATE:Smoke()`.
---@param Distance? number (Optional) This is the distance of the offset in meters. Default random 10-20.
---@return COORDINATE # self
function COORDINATE:SetSmokeOffsetDistance(Distance) end

---Set the offset on when using `COORDINATE:Smoke()`.
---@return COORDINATE # self
function COORDINATE:SwitchSmokeOffsetOn() end

---Set the offset off when using `COORDINATE:Smoke()`.
---@return COORDINATE # self
function COORDINATE:SwitchSmokeOffsetOff() end

---Stops smoking the point in a color.
---@param name? string (Optional) Name if you want to stop the smoke early (normal duration: 5mins)
function COORDINATE:StopSmoke(name) end

---Smoke the COORDINATE Green.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE # self
function COORDINATE:SmokeGreen(Duration, Delay) end

---Smoke the COORDINATE Red.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE # self
function COORDINATE:SmokeRed(Duration, Delay) end

---Smoke the COORDINATE White.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE # self
function COORDINATE:SmokeWhite(Duration, Delay) end

---Smoke the COORDINATE Orange.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE # self
function COORDINATE:SmokeOrange(Duration, Delay) end

---Smoke the COORDINATE Blue.
---@param Duration? number (Optional) Duration of the smoke in seconds. DCS stopps the smoke automatically after 5 min.
---@param Delay? number (Optional) Delay before the smoke is started in seconds.
---@return COORDINATE # self
function COORDINATE:SmokeBlue(Duration, Delay) end

---Big smoke and fire at the coordinate.
---@param Preset? number Smoke preset (1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke).
---@param Density? number (Optional) Smoke density. Number in [0,...,1]. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE # self
function COORDINATE:BigSmokeAndFire(Preset, Density, Duration, Delay, Name) end

---Stop big smoke and fire at the coordinate.
---@param name? string (Optional) Name of the fire to stop it, if not using the same COORDINATE object.
function COORDINATE:StopBigSmokeAndFire(name) end

---Small smoke and fire at the coordinate.
---@param Density? number (Optional) Smoke density. Number between 0 and 1. Default 0.5.
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? string (Optional) Name of the fire to stop it later again if not using the same COORDINATE object. Defaults to "Fire-" plus a random 5-digit-number.
---@return COORDINATE # self
function COORDINATE:BigSmokeAndFireSmall(Density, Duration, Delay, Name) end

---Medium smoke and fire at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeAndFireMedium(Density, Duration, Delay, Name) end

---Large smoke and fire at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeAndFireLarge(Density, Duration, Delay, Name) end

---Huge smoke and fire at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeAndFireHuge(Density, Duration, Delay, Name) end

---Small smoke at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeSmall(Density, Duration, Delay, Name) end

---Medium smoke at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeMedium(Density, Duration, Delay, Name) end

---Large smoke at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeLarge(Density, Duration, Delay, Name) end

---Huge smoke at the coordinate.
---@param Density? any
---@param Duration? number (Optional) Duration of the smoke and fire in seconds.
---@param Delay? number (Optional) Delay before the smoke and fire is started in seconds.
---@param Name? any
---@return COORDINATE # self
function COORDINATE:BigSmokeHuge(Density, Duration, Delay, Name) end

---Flares the point in a color.
---@param FlareColor? FLARECOLOR
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:Flare(FlareColor, Azimuth) end

---Flare the COORDINATE White.
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareWhite(Azimuth) end

---Flare the COORDINATE Yellow.
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareYellow(Azimuth) end

---Flare the COORDINATE Green.
---@param Azimuth? Azimuth (optional) The azimuth of the flare direction. The default azimuth is 0.
function COORDINATE:FlareGreen(Azimuth) end

---Flare the COORDINATE Red.
---@param Azimuth? any
function COORDINATE:FlareRed(Azimuth) end

---Mark to All
---@param MarkText? string Free format text that shows the marking clarification.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID which is a number.
function COORDINATE:MarkToAll(MarkText, ReadOnly, Text) end

---Mark to Coalition
---@param MarkText? string Free format text that shows the marking clarification.
---@param Coalition? any
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID which is a number.
function COORDINATE:MarkToCoalition(MarkText, Coalition, ReadOnly, Text) end

---Mark to Red Coalition
---@param MarkText? string Free format text that shows the marking clarification.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID which is a number.
function COORDINATE:MarkToCoalitionRed(MarkText, ReadOnly, Text) end

---Mark to Blue Coalition
---@param MarkText? string Free format text that shows the marking clarification.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID which is a number.
function COORDINATE:MarkToCoalitionBlue(MarkText, ReadOnly, Text) end

---Mark to Group
---@param MarkText? string Free format text that shows the marking clarification.
---@param MarkGroup? GROUP The @{Wrapper.Group} that receives the mark.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID which is a number.
function COORDINATE:MarkToGroup(MarkText, MarkGroup, ReadOnly, Text) end

---Remove a mark
---@param MarkID? number The ID of the mark to be removed.
function COORDINATE:RemoveMark(MarkID) end

---Line to all.
---Creates a line on the F10 map from one point to another.
---@param Endpoint? COORDINATE COORDINATE to where the line is drawn.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:LineToAll(Endpoint, Coalition, Color, Alpha, LineType, ReadOnly, Text) end

---Circle to all.
---Creates a circle on the map with a given radius, color, fill color, and outline.
---@param Radius? number (Optional) Radius in meters. Default 1000 m.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:CircleToAll(Radius, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Rectangle to all. Creates a rectangle on the map from the COORDINATE in one corner to the end COORDINATE in the opposite corner.
---Creates a line on the F10 map from one point to another.
---@param Endpoint? COORDINATE COORDINATE in the opposite corner.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:RectToAll(Endpoint, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Creates a shape defined by 4 points on the F10 map. The first point is the current COORDINATE. The remaining three points need to be specified.
---@param Coord2? COORDINATE Second COORDINATE of the quad shape.
---@param Coord3? COORDINATE Third COORDINATE of the quad shape.
---@param Coord4? COORDINATE Fourth COORDINATE of the quad shape.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:QuadToAll(Coord2, Coord3, Coord4, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Creates a free form shape on the F10 map. The first point is the current COORDINATE. The remaining points need to be specified.
---@param Coordinates? table Table of coordinates of the remaining points of the shape.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:MarkupToAllFreeForm(Coordinates, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Text to all. Creates a text imposed on the map at the COORDINATE. Text scales with the map.
---@param Text? string Text displayed on the F10 map.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.3.
---@param FontSize? number (Optional) Font size. Default 14.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:TextToAll(Text, Coalition, Color, Alpha, FillColor, FillAlpha, FontSize, ReadOnly) end

---Arrow to all. Creates an arrow from the COORDINATE to the endpoint COORDINATE on the F10 map. There is no control over other dimensions of the arrow.
---@param Endpoint? COORDINATE COORDINATE where the tip of the arrow is pointing at.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red (default).
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@param Text? string (Optional) Text displayed when mark is added. Default none.
---@return number # The resulting Mark ID, which is a number. Can be used to remove the object again.
function COORDINATE:ArrowToAll(Endpoint, Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, Text) end

---Returns if a Coordinate has Line of Sight (LOS) with the ToCoordinate.
---@param ToCoordinate? COORDINATE
---@param Offset? number (Optional) Height offset in meters. Default 2 m.
---@return boolean # true If the ToCoordinate has LOS with the Coordinate, otherwise false.
function COORDINATE:IsLOS(ToCoordinate, Offset) end

---Returns if a Coordinate is in a certain Radius of this Coordinate in 2D plane using the X and Z axis.
---@param Coordinate? COORDINATE The coordinate that will be tested if it is in the radius of this coordinate.
---@param Radius? number The radius of the circle on the 2D plane around this coordinate.
---@return boolean # true if in the Radius.
function COORDINATE:IsInRadius(Coordinate, Radius) end

---Returns if a Coordinate is in a certain radius of this Coordinate in 3D space using the X, Y and Z axis.
---So Radius defines the radius of the a Sphere in 3D space around this coordinate.
---@param Coordinate? any
---@param Radius? number The radius of the sphere in the 3D space around this coordinate.
---@return boolean # true if in the Sphere.
function COORDINATE:IsInSphere(Coordinate, Radius) end

---Get sun rise time for a specific date at the coordinate.
---@param Day? number The day.
---@param Month? number The month.
---@param Year? number The year.
---@param InSeconds? boolean If true, return the sun rise time in seconds.
---@return string # Sunrise time, e.g. "05:41".
function COORDINATE:GetSunriseAtDate(Day, Month, Year, InSeconds) end

---Get sun rise time for a specific day of the year at the coordinate.
---@param DayOfYear? number The day of the year.
---@param InSeconds? boolean If true, return the sun rise time in seconds.
---@return string # Sunrise time, e.g. "05:41".
function COORDINATE:GetSunriseAtDayOfYear(DayOfYear, InSeconds) end

---Get todays sun rise time.
---@param InSeconds? boolean If true, return the sun rise time in seconds.
---@return string # Sunrise time, e.g. "05:41".
function COORDINATE:GetSunrise(InSeconds) end

---Get minutes until the next sun rise at this coordinate.
---@param OnlyToday? any
---@return number # Minutes to the next sunrise.
function COORDINATE:GetMinutesToSunrise(OnlyToday) end

---Check if it is day, i.e. if the sun has risen about the horizon at this coordinate.
---@param Clock? string (Optional) Time in format "HH:MM:SS+D", e.g. "05:40:00+3" to check if is day at 5:40 at third day after mission start. Default is to check right now.
---@return boolean # If true, it is day. If false, it is night time.
function COORDINATE:IsDay(Clock) end

---Check if it is night, i.e. if the sun has set below the horizon at this coordinate.
---@param Clock? string (Optional) Time in format "HH:MM:SS+D", e.g. "05:40:00+3" to check if is night at 5:40 at third day after mission start. Default is to check right now.
---@return boolean # If true, it is night. If false, it is day time.
function COORDINATE:IsNight(Clock) end

---Get sun set time for a specific date at the coordinate.
---@param Day? number The day.
---@param Month? number The month.
---@param Year? number The year.
---@param InSeconds? boolean If true, return the sun rise time in seconds.
---@return string # Sunset time, e.g. "20:41".
function COORDINATE:GetSunsetAtDate(Day, Month, Year, InSeconds) end

---Get todays sun set time.
---@param InSeconds? boolean If true, return the sun set time in seconds.
---@return string # Sunrise time, e.g. "20:41".
function COORDINATE:GetSunset(InSeconds) end

---Get minutes until the next sun set at this coordinate.
---@param OnlyToday? any
---@return number # Minutes to the next sunrise.
function COORDINATE:GetMinutesToSunset(OnlyToday) end

---Return a BR string from a COORDINATE to the COORDINATE.
---@param FromCoordinate? COORDINATE The coordinate to measure the distance and the bearing from.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true, also get angle in MagVar for BR/BRA
---@param Precision? number (Optional) Rounding precision, currently full km as default (=0)
---@return string # The BR text.
function COORDINATE:ToStringBR(FromCoordinate, Settings, MagVar, Precision) end

---Return a Bearing string from a COORDINATE to the (self) COORDINATE.
---@param FromCoordinate? COORDINATE The coordinate to measure the distance and the bearing from.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true, also get angle in MagVar for BR/BRA
---@param Precision? number (Optional) Rounding precision, currently full km as default (=0)
---@return string # The BR text.
function COORDINATE:ToStringBearing(FromCoordinate, Settings, MagVar, Precision) end

---Return a BRA string from a COORDINATE to the COORDINATE.
---@param FromCoordinate? COORDINATE The coordinate to measure the distance and the bearing from.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true, also get angle in MagVar for BR/BRA
---@return string # The BR text.
function COORDINATE:ToStringBRA(FromCoordinate, Settings, MagVar) end

---Create a BRAA NATO call string to this COORDINATE from the FromCOORDINATE. Note - BRA delivered if no aspect can be obtained and "Merged" if range < 3nm
---@param FromCoordinate? COORDINATE The coordinate to measure the distance and the bearing from.
---@param Bogey? boolean Add "Bogey" at the end if true (not yet declared hostile or friendly)
---@param Spades? boolean Add "Spades" at the end if true (no IFF/VID ID yet known)
---@param SSML? boolean Add SSML tags speaking aspect as 0 1 2 and "brah" instead of BRAA
---@param Angels? boolean If true, altitude is e.g. "Angels 25" (i.e., a friendly plane), else "25 thousand"
---@param Zeros? boolean If using SSML, be aware that Google TTS will say "oh" and not "zero" for "0"; if Zeros is set to true, "0" will be replaced with "zero"
---@return string # The BRAA text.
function COORDINATE:ToStringBRAANATO(FromCoordinate, Bogey, Spades, SSML, Angels, Zeros) end

---Return the BULLSEYE as COORDINATE Object
---@param Coalition? number Coalition of the bulls eye to return, e.g. coalition.side.BLUE
---@return COORDINATE # self
function COORDINATE.GetBullseyeCoordinate(Coalition) end

---Return a BULLS string out of the BULLS of the coalition to the COORDINATE.
---@param Coalition? coalition.side|number|string The coalition.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true, als get angle in magnetic
---@return string # The BR text.
function COORDINATE:ToStringBULLS(Coalition, Settings, MagVar) end

---Return an aspect string from a COORDINATE to the Angle of the object.
---@param TargetCoordinate? COORDINATE The target COORDINATE.
---@return string # The Aspect string, which is Hot, Cold or Flanking.
function COORDINATE:ToStringAspect(TargetCoordinate) end

---Get Latitude and Longitude in Degrees Decimal Minutes (DDM).
---@return number # Latitude in DDM.
---@return number # Lontitude in DDM.
function COORDINATE:GetLLDDM() end

---Get Latitude & Longitude text.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # LLText
function COORDINATE:ToStringLL(Settings) end

---Provides a Lat Lon string in Degree Minute Second format.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The LL DMS Text
function COORDINATE:ToStringLLDMS(Settings) end

---Provides a Lat Lon string in Degree Decimal Minute format.
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The LL DDM Text
function COORDINATE:ToStringLLDDM(Settings) end

---Provides a MGRS string
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The MGRS Text
function COORDINATE:ToStringMGRS(Settings) end

---Provides a COORDINATE from an MGRS String
---@param MGRSString? string MGRS String, e.g. "MGRS 37T DK 12345 12345"
---@return COORDINATE # self
function COORDINATE:NewFromMGRSString(MGRSString) end

---Provides a COORDINATE from an MGRS Coordinate
---@param UTMZone? string UTM Zone, e.g. "37T"
---@param MGRSDigraph? string Digraph, e.g. "DK"
---@param Easting? string Meters easting - string in order to allow for leading zeros, e.g. "01234". Should be 5 digits.
---@param Northing? string Meters northing - string in order to allow for leading zeros, e.g. "12340". Should be 5 digits.
---@return COORDINATE # self
function COORDINATE:NewFromMGRS(UTMZone, MGRSDigraph, Easting, Northing) end

---Provides a coordinate string of the point, based on a coordinate format system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---@param ReferenceCoord? COORDINATE The reference coordinate.
---@param ReferenceName? string The reference name.
---@param Controllable? CONTROLLABLE
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true also show angle in magnetic
---@return string # The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringFromRP(ReferenceCoord, ReferenceName, Controllable, Settings, MagVar) end

---Provides a coordinate string of the point, based on a coordinate format system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---@param ReferenceCoord? COORDINATE The reference coordinate.
---@param ReferenceName? string The reference name.
---@param Controllable? CONTROLLABLE
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true also get the angle as magnetic
---@return string # The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringFromRPShort(ReferenceCoord, ReferenceName, Controllable, Settings, MagVar) end

---Provides a coordinate string of the point, based on the A2G coordinate format system.
---@param Controllable? CONTROLLABLE
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true, also get angle in MagVar for BR/BRA
---@return string # The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringA2G(Controllable, Settings, MagVar) end

---Provides a coordinate string of the point, based on the A2A coordinate format system.
---@param Controllable? CONTROLLABLE
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@param MagVar? boolean If true, also get angle in MagVar for BR/BRA
---@return string # The coordinate Text in the configured coordinate system.
function COORDINATE:ToStringA2A(Controllable, Settings, MagVar) end

---Provides a coordinate string of the point, based on a coordinate format system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---@param Controllable? CONTROLLABLE (Optional) The controllable to retrieve the settings from, otherwise the default settings will be chosen.
---@param Settings? SETTINGS (Optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The coordinate Text in the configured coordinate system.
function COORDINATE:ToString(Controllable, Settings) end

---Provides a pressure string of the point, based on a measurement system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---@param Controllable? CONTROLLABLE
---@param Settings? SETTINGS (Optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The pressure text in the configured measurement system.
function COORDINATE:ToStringPressure(Controllable, Settings) end

---Provides a wind string of the point, based on a measurement system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---@param Controllable? CONTROLLABLE
---@param Settings? SETTINGS (optional) The settings. Can be nil, and in this case the default settings are used. If you want to specify your own settings, use the _SETTINGS object.
---@return string # The wind text in the configured measurement system.
function COORDINATE:ToStringWind(Controllable, Settings) end

---Provides a temperature string of the point, based on a measurement system:
---  * Uses default settings in COORDINATE.
---  * Can be overridden if for a GROUP containing x clients, a menu was selected to override the default.
---@param Controllable? CONTROLLABLE
---@param Settings? any
---@return string # The temperature text in the configured measurement system.
function COORDINATE:ToStringTemperature(Controllable, Settings) end

---Function to check if a coordinate is in a steep (>8% elevation) area of the map
---@param Radius? number (Optional) Radius to check around the coordinate, defaults to 50m (100m diameter)
---@param Minelevation? number (Optional) Elevation from which on a area is defined as steep, defaults to 8% (8m height gain across 100 meters)
---@return boolean # IsSteep If true, area is steep
---@return number # MaxElevation Elevation in meters measured over 100m
function COORDINATE:IsInSteepArea(Radius, Minelevation) end

---Function to check if a coordinate is in a flat (<8% elevation) area of the map
---@param Radius? number (Optional) Radius to check around the coordinate, defaults to 50m (100m diameter)
---@param Minelevation? number (Optional) Elevation from which on a area is defined as steep, defaults to 8% (8m height gain across 100 meters)
---@return boolean # IsFlat If true, area is flat
---@return number # MaxElevation Elevation in meters measured over 100m
function COORDINATE:IsInFlatArea(Radius, Minelevation) end

---Return a random COORDINATE within an Outer Radius and optionally NOT within an Inner Radius of the COORDINATE.
---@param OuterRadius? number
---@param InnerRadius? number
---@return COORDINATE
function COORDINATE:GetRandomPointVec3InRadius(OuterRadius, InnerRadius) end

---Search for clear zones in a given area. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param SearchRadius? number Radius of the search area.
---@param PosRadius? number Required clear radius around each position.
---@param NumPositions? number Number of positions to find.
---@return table # A table of Core.Point#COORDINATE that are clear of map objects within the given PosRadius. nil if no positions are found.
function COORDINATE:GetSimpleZones(SearchRadius, PosRadius, NumPositions) end
