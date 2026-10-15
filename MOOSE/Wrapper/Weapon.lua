---@meta

---WEAPON class.
---@class WEAPON : POSITIONABLE
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field weapon Weapon The DCS weapon object.
---@field name string Name of the weapon object.
---@field typeName string Type name of the weapon.
---@field category number Weapon category 0=SHELL, 1=MISSILE, 2=ROCKET, 3=BOMB, 4=TORPEDO (Weapon.Category.X).
---@field categoryMissile number Missile category 0=AAM, 1=SAM, 2=BM, 3=ANTI_SHIP, 4=CRUISE, 5=OTHER (Weapon.MissileCategory.X).
---@field coalition number Coalition ID.
---@field country number Country ID.
---@field desc Desc Descriptor table.
---@field guidance Desc Missile guidance descriptor.
---@field launcher Unit Launcher DCS unit.
---@field launcherUnit UNIT Launcher Unit.
---@field launcherName string Name of launcher unit.
---@field dtTrack number Time step in seconds for tracking scheduler.
---@field impactFunc function Callback function for weapon impact.
---@field impactArg table Optional arguments for the impact callback function.
---@field trackFunc function Callback function when weapon is tracked and alive.
---@field trackArg table Optional arguments for the track callback function.
---@field vec3 Vec3 Last known 3D position vector of the tracked weapon.
---@field pos3 Position3 Last known 3D position and direction vector of the tracked weapon.
---@field coordinate COORDINATE Coordinate object of the weapon. Can be used in other classes.
---@field impactVec3 Vec3 Impact 3D vector.
---@field impactCoord COORDINATE Impact coordinate.
---@field trackScheduleID number Tracking scheduler ID. Can be used to remove/destroy the scheduler function.
---@field tracking boolean If `true`, scheduler will keep tracking. Otherwise, function will return nil and stop tracking.
---@field impactMark boolean If `true`, the impact point is marked on the F10 map. Requires tracking to be started.
---@field impactSmoke boolean If `true`, the impact point is marked by smoke. Requires tracking to be started.
---@field impactSmokeColor number Colour of impact point smoke.
---@field impactDestroy boolean If `true`, destroy weapon before impact. Requires tracking to be started and sufficiently small time step.
---@field impactDestroyDist number Distance in meters to the estimated impact point. If smaller, then weapon is destroyed.
---@field distIP number Distance in meters for the intercept point estimation.
---@field target UNIT Last known target.
WEAPON = {
  ClassName          = "WEAPON",
  verbose            =     0,
}

---WEAPON class version.
WEAPON.version = "0.1.0"

---Create a new WEAPON object from the DCS weapon object.
---@param WeaponObject? Weapon The DCS weapon object.
---@return WEAPON # self
function WEAPON:New(WeaponObject) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return WEAPON # self
function WEAPON:SetVerbosity(VerbosityLevel) end

---Set track position time step.
---@param TimeStep? number (Optional) Time step in seconds when the position is updated. Default 0.01 sec ==> 100 evaluations per second.
---@return WEAPON # self
function WEAPON:SetTimeStepTrack(TimeStep) end

---Set distance of intercept point for estimated impact point.
---If the weapon cannot be tracked any more, the intercept point from its last known position and direction is used to get
---a better approximation of the impact point. Can be useful when using longer time steps in the tracking and still achieve
---a good result on the impact point.
---It uses the DCS function [getIP](https://wiki.hoggitworld.com/view/DCS_func_getIP).
---@param Distance? number (Optional) Distance in meters. Default is 50 m. Set to 0 to deactivate.
---@return WEAPON # self
function WEAPON:SetDistanceInterceptPoint(Distance) end

---Mark impact point on the F10 map. This requires that the tracking has been started.
---@param Switch? boolean If `true` or nil, impact is marked.
---@return WEAPON # self
function WEAPON:SetMarkImpact(Switch) end

---Put smoke on impact point. This requires that the tracking has been started.
---@param Switch? boolean If `true` or nil, impact is smoked.
---@param SmokeColor? number (Optional) Color of smoke. Default is `SMOKECOLOR.Red`.
---@return WEAPON # self
function WEAPON:SetSmokeImpact(Switch, SmokeColor) end

---Set callback function when weapon is tracked and still alive. The first argument will be the WEAPON object.
---Note that this can be called many times per second. So be careful for performance reasons.
---@param FuncTrack? function Function called during tracking.
---@param ... any
---@return WEAPON # self
function WEAPON:SetFuncTrack(FuncTrack, ...) end

---Set callback function when weapon impacted or was destroyed otherwise, *i.e.* cannot be tracked any more.
---@param FuncImpact? function Function called once the weapon impacted.
---@param ... any
---@return WEAPON # self
function WEAPON:SetFuncImpact(FuncImpact, ...) end

---Get the unit that launched the weapon.
---@return UNIT # Laucher unit.
function WEAPON:GetLauncher() end

---Get the target, which the weapon is guiding to.
---@return OBJECT # The target object, which can be a UNIT or STATIC object.
function WEAPON:GetTarget() end

---Get the distance to the current target the weapon is guiding to.
---@param ConversionFunction? function (Optional) Conversion function from meters to desired unit, *e.g.* `UTILS.MpsToKmph`.
---@return number # Distance from weapon to target in meters.
function WEAPON:GetTargetDistance(ConversionFunction) end

---Get name the current target the weapon is guiding to.
---@return string # Name of the target or "None" if no target.
function WEAPON:GetTargetName() end

---Get velocity vector of weapon.
---@return Vec3 # Velocity vector with x, y and z components in meters/second.
function WEAPON:GetVelocityVec3() end

---Get speed of weapon.
---@param ConversionFunction? function (Optional) Conversion function from m/s to desired unit, *e.g.* `UTILS.MpsToKmph`.
---@return number # Speed in meters per second.
function WEAPON:GetSpeed(ConversionFunction) end

---Get the current 3D position vector.
---@return Vec3 # Current position vector in 3D.
function WEAPON:GetVec3() end

---Get the current 2D position vector.
---@return Vec2 # Current position vector in 2D.
function WEAPON:GetVec2() end

---Get type name.
---@return string # The type name.
function WEAPON:GetTypeName() end

---Get coalition.
---@return number # Coalition ID.
function WEAPON:GetCoalition() end

---Get country.
---@return number # Country ID.
function WEAPON:GetCountry() end

---Get DCS object.
---@return Weapon # The weapon object.
function WEAPON:GetDCSObject() end

---Get the impact position vector. Note that this might not exist if the weapon has not impacted yet!
---@return Vec3 # Impact position vector (if any).
function WEAPON:GetImpactVec3() end

---Get the impact coordinate. Note that this might not exist if the weapon has not impacted yet!
---@return COORDINATE # Impact coordinate (if any).
function WEAPON:GetImpactCoordinate() end

---Get the heading on which the weapon was released
---@param AccountForMagneticInclination? boolean (Optional) If true will account for the magnetic declination of the current map. Default is true
---@return number # Heading
function WEAPON:GetReleaseHeading(AccountForMagneticInclination) end

---Get the altitude above sea level at which the weapon was released
---@return number # Altitude in meters
function WEAPON:GetReleaseAltitudeASL() end

---Get the altitude above ground level at which the weapon was released
---@return number # Altitude in meters
function WEAPON:GetReleaseAltitudeAGL() end

---Get the coordinate where the weapon was released
---@return COORDINATE # Impact coordinate (if any).
function WEAPON:GetReleaseCoordinate() end

---Get the pitch of the unit when the weapon was released
---@return number # Degrees
function WEAPON:GetReleasePitch() end

---Get the heading of the weapon when it impacted. Note that this might not exist if the weapon has not impacted yet!
---@param AccountForMagneticInclination? boolean (Optional) If true will account for the magnetic declination of the current map. Default is true
---@return number # Heading
function WEAPON:GetImpactHeading(AccountForMagneticInclination) end

---Check if weapon is in the air. Obviously not really useful for torpedos. Well, then again, this is DCS...
---@return boolean # If `true`, weapon is in the air and `false` if not. Returns `nil` if weapon object itself is `nil`.
function WEAPON:InAir() end

---Check if weapon object (still) exists.
---@return boolean # If `true`, the weapon object still exists and `false` otherwise. Returns `nil` if weapon object itself is `nil`.
function WEAPON:IsExist() end

---Check if weapon is a bomb.
---@return boolean # If `true`, is a bomb.
function WEAPON:IsBomb() end

---Check if weapon is a missile.
---@return boolean # If `true`, is a missile.
function WEAPON:IsMissile() end

---Check if weapon is a rocket.
---@return boolean # If `true`, is a missile.
function WEAPON:IsRocket() end

---Check if weapon is a shell.
---@return boolean # If `true`, is a shell.
function WEAPON:IsShell() end

---Check if weapon is a torpedo.
---@return boolean # If `true`, is a torpedo.
function WEAPON:IsTorpedo() end

---Check if weapon is a Fox One missile (Radar Semi-Active).
---@return boolean # If `true`, is a Fox One.
function WEAPON:IsFoxOne() end

---Check if weapon is a Fox Two missile (IR guided).
---@return boolean # If `true`, is a Fox Two.
function WEAPON:IsFoxTwo() end

---Check if weapon is a Fox Three missile (Radar Active).
---@return boolean # If `true`, is a Fox Three.
function WEAPON:IsFoxThree() end

---Destroy the weapon object.
---@param Delay? number Delay before destroy in seconds.
---@return WEAPON # self
function WEAPON:Destroy(Delay) end

---Start tracking the weapon until it impacts or is destroyed otherwise.
---The position of the weapon is monitored in small time steps. Once the position cannot be determined anymore, the monitoring is stopped and the last known position is
---the (approximate) impact point. Of course, the smaller the time step, the better the position can be determined. However, this can hit the performance as many
---calculations per second need to be carried out.
---@param Delay? number (Optional) Delay in seconds before the tracking starts. Default 0.001 sec.
---@return WEAPON # self
function WEAPON:StartTrack(Delay) end

---Stop tracking the weapon by removing the scheduler function.
---@param Delay? number (Optional) Delay in seconds before the tracking is stopped.
---@return WEAPON # self
function WEAPON:StopTrack(Delay) end

---Track weapon until impact.
---@param time? number Time in seconds.
---@return number # Time when called next or nil if not called again.
function WEAPON:_TrackWeapon(time) end

---Compute estimated intercept/impact point (IP) based on last known position and direction.
---@param Distance? number (Optional) Distance in meters. Default 50 m.
---@return Vec3 # Estimated intercept/impact point. Can also return `nil`, if no IP can be determined.
function WEAPON:_GetIP(Distance) end
