---@meta

---@class ATC_GROUND.AirbaseNames

---@class ATC_GROUND : BASE
---@field SetClient SET_CLIENT
ATC_GROUND = {
  ClassName = "ATC_GROUND",
  SetClient = nil,
  Airbases = nil,
  AirbaseNames = nil,
}

---[DEPRECATED, use ATC_GROUND_UNIVERSAL] Creates a new ATC\_GROUND object.
---@param Airbases? any
---@param AirbaseList? any
---@return ATC_GROUND # self
function ATC_GROUND:New(Airbases, AirbaseList) end

---Smoke the airbases runways.
---@param SmokeColor? SMOKECOLOR The color of the smoke around the runways.
---@return ATC_GROUND # self
function ATC_GROUND:SmokeRunways(SmokeColor) end

---Set the maximum speed in meters per second (Mps) until the player gets kicked.
---An airbase can be specified to set the kick speed for.
---@param KickSpeed? number The speed in Mps.
---@param Airbase? AIRBASE (optional) The airbase to set the kick speed for.
---@return ATC_GROUND # self
function ATC_GROUND:SetKickSpeed(KickSpeed, Airbase) end

---Set the maximum speed in Kmph until the player gets kicked.
---@param KickSpeed? number Set the speed in Kmph.
---@param Airbase? AIRBASE (optional) The airbase to set the kick speed for.
---@return ATC_GROUND # self Atc_Ground:SetKickSpeedKmph( 80 ) -- Kick the players at 80 kilometers per hour
function ATC_GROUND:SetKickSpeedKmph(KickSpeed, Airbase) end

---Set the maximum speed in Miph until the player gets kicked.
---@param KickSpeedMiph? number Set the speed in Mph.
---@param Airbase? AIRBASE (optional) The airbase to set the kick speed for.
---@return ATC_GROUND # self Atc_Ground:SetKickSpeedMiph( 100 ) -- Kick the players at 100 miles per hour
function ATC_GROUND:SetKickSpeedMiph(KickSpeedMiph, Airbase) end

---Set the maximum kick speed in meters per second (Mps) until the player gets kicked.
---There are no warnings given if this speed is reached, and is to prevent players to take off from the airbase!
---An airbase can be specified to set the maximum kick speed for.
---@param MaximumKickSpeed? number The speed in Mps.
---@param Airbase? AIRBASE (optional) The airbase to set the kick speed for.
---@return ATC_GROUND # self
function ATC_GROUND:SetMaximumKickSpeed(MaximumKickSpeed, Airbase) end

---Set the maximum kick speed in kilometers per hour (Kmph) until the player gets kicked.
---There are no warnings given if this speed is reached, and is to prevent players to take off from the airbase!
---An airbase can be specified to set the maximum kick speed for.
---@param MaximumKickSpeed? number Set the speed in Kmph.
---@param Airbase? AIRBASE (optional) The airbase to set the kick speed for.
---@return ATC_GROUND # self Atc_Ground:SetMaximumKickSpeedKmph( 150 ) -- Kick the players at 150 kilometers per hour
function ATC_GROUND:SetMaximumKickSpeedKmph(MaximumKickSpeed, Airbase) end

---Set the maximum kick speed in miles per hour (Miph) until the player gets kicked.
---There are no warnings given if this speed is reached, and is to prevent players to take off from the airbase!
---An airbase can be specified to set the maximum kick speed for.
---@param MaximumKickSpeedMiph? number Set the speed in Mph.
---@param Airbase? AIRBASE (optional) The airbase to set the kick speed for.
---@return ATC_GROUND # self Atc_Ground:SetMaximumKickSpeedMiph( 100 ) -- Kick the players at 100 miles per hour
function ATC_GROUND:SetMaximumKickSpeedMiph(MaximumKickSpeedMiph, Airbase) end

function ATC_GROUND:_AirbaseMonitor() end

---@class ATC_GROUND_UNIVERSAL : BASE
---@field SetClient SET_CLIENT
---@field Version string
---@field ClassName string
---@field Airbases table
---@field AirbaseList table
---@field KickSpeed number
ATC_GROUND_UNIVERSAL = {
  ClassName = "ATC_GROUND_UNIVERSAL",
  Version = "0.0.2",
  SetClient = nil,
  Airbases = nil,
  AirbaseList = nil,
  KickSpeed = nil, -- The maximum speed in meters per second for all airbases until a player gets kicked. This is overridden at each derived class.
}

---Creates a new ATC\_GROUND\_UNIVERSAL object. This works on any map.
---@param AirbaseList? any
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:New(AirbaseList) end

---Add a specific Airbase Boundary if you don't want to use the round zone that is auto-created.
---@param Airbase? string The name of the Airbase
---@param Zone? ZONE The ZONE object to be used, e.g. a ZONE_POLYGON
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:SetAirbaseBoundaries(Airbase, Zone) end

---Smoke the airbases runways.
---@param SmokeColor? SMOKECOLOR The color of the smoke around the runways.
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:SmokeRunways(SmokeColor) end

---Draw the airbases runways.
---@param Color? table The color of the line around the runways, in RGB, e.g `{1,0,0}` for red.
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:DrawRunways(Color) end

---Draw the airbases boundaries.
---@param Color? table The color of the line around the runways, in RGB, e.g `{1,0,0}` for red.
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:DrawBoundaries(Color) end

---Set the maximum speed in meters per second (Mps) until the player gets kicked.
---An airbase can be specified to set the kick speed for.
---@param KickSpeed? number The speed in Mps.
---@param Airbase? string (optional) The airbase name to set the kick speed for.
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:SetKickSpeed(KickSpeed, Airbase) end

---Set the maximum speed in Kmph until the player gets kicked.
---@param KickSpeed? number Set the speed in Kmph.
---@param Airbase? string (optional) The airbase name to set the kick speed for.
---@return ATC_GROUND_UNIVERSAL # self Atc_Ground:SetKickSpeedKmph( 80 ) -- Kick the players at 80 kilometers per hour
function ATC_GROUND_UNIVERSAL:SetKickSpeedKmph(KickSpeed, Airbase) end

---Set the maximum speed in Miph until the player gets kicked.
---@param KickSpeedMiph? number Set the speed in Mph.
---@param Airbase? string (optional) The airbase name to set the kick speed for.
---@return ATC_GROUND_UNIVERSAL # self Atc_Ground:SetKickSpeedMiph( 100 ) -- Kick the players at 100 miles per hour
function ATC_GROUND_UNIVERSAL:SetKickSpeedMiph(KickSpeedMiph, Airbase) end

---Set the maximum kick speed in meters per second (Mps) until the player gets kicked.
---There are no warnings given if this speed is reached, and is to prevent players to take off from the airbase!
---An airbase can be specified to set the maximum kick speed for.
---@param MaximumKickSpeed? number The speed in Mps.
---@param Airbase? string (optional) The airbase name to set the kick speed for.
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:SetMaximumKickSpeed(MaximumKickSpeed, Airbase) end

---Set the maximum kick speed in kilometers per hour (Kmph) until the player gets kicked.
---There are no warnings given if this speed is reached, and is to prevent players to take off from the airbase!
---An airbase can be specified to set the maximum kick speed for.
---@param MaximumKickSpeed? number Set the speed in Kmph.
---@param Airbase? string (optional) The airbase name to set the kick speed for.
---@return ATC_GROUND_UNIVERSAL # self Atc_Ground:SetMaximumKickSpeedKmph( 150 ) -- Kick the players at 150 kilometers per hour
function ATC_GROUND_UNIVERSAL:SetMaximumKickSpeedKmph(MaximumKickSpeed, Airbase) end

---Set the maximum kick speed in miles per hour (Miph) until the player gets kicked.
---There are no warnings given if this speed is reached, and is to prevent players to take off from the airbase!
---An airbase can be specified to set the maximum kick speed for.
---@param MaximumKickSpeedMiph? number Set the speed in Mph.
---@param Airbase? string (optional) The airbase name to set the kick speed for.
---@return ATC_GROUND_UNIVERSAL # self Atc_Ground:SetMaximumKickSpeedMiph( 100 ) -- Kick the players at 100 miles per hour
function ATC_GROUND_UNIVERSAL:SetMaximumKickSpeedMiph(MaximumKickSpeedMiph, Airbase) end

---[Internal] Monitoring function
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:_AirbaseMonitor() end

---Start SCHEDULER for ATC_GROUND_UNIVERSAL object.
---@param RepeatScanSeconds? any
---@return ATC_GROUND_UNIVERSAL # self
function ATC_GROUND_UNIVERSAL:Start(RepeatScanSeconds) end

---@class ATC_GROUND_CAUCASUS : ATC_GROUND
ATC_GROUND_CAUCASUS = {
  ClassName = "ATC_GROUND_CAUCASUS",
}

---Creates a new ATC_GROUND_CAUCASUS object.
---@param AirbaseNames? any
---@return ATC_GROUND_CAUCASUS # self
function ATC_GROUND_CAUCASUS:New(AirbaseNames) end

---Start SCHEDULER for ATC_GROUND_CAUCASUS object.
---@param RepeatScanSeconds? any
---@return nil
function ATC_GROUND_CAUCASUS:Start(RepeatScanSeconds) end

---@class ATC_GROUND_NEVADA : ATC_GROUND
ATC_GROUND_NEVADA = {
  ClassName = "ATC_GROUND_NEVADA",
}

---Creates a new ATC_GROUND_NEVADA object.
---@param AirbaseNames? any
---@return ATC_GROUND_NEVADA # self
function ATC_GROUND_NEVADA:New(AirbaseNames) end

---Start SCHEDULER for ATC_GROUND_NEVADA object.
---@param RepeatScanSeconds? any
---@return nil
function ATC_GROUND_NEVADA:Start(RepeatScanSeconds) end

---@class ATC_GROUND_NORMANDY : ATC_GROUND
ATC_GROUND_NORMANDY = {
  ClassName = "ATC_GROUND_NORMANDY", 
}

---Creates a new ATC_GROUND_NORMANDY object.
---@param AirbaseNames? any
---@return ATC_GROUND_NORMANDY # self
function ATC_GROUND_NORMANDY:New(AirbaseNames) end

---Start SCHEDULER for ATC_GROUND_NORMANDY object.
---@param RepeatScanSeconds? any
---@return nil
function ATC_GROUND_NORMANDY:Start(RepeatScanSeconds) end

---@class ATC_GROUND_PERSIANGULF : ATC_GROUND
ATC_GROUND_PERSIANGULF = {
  ClassName = "ATC_GROUND_PERSIANGULF",
}

---Creates a new ATC_GROUND_PERSIANGULF object.
---@param AirbaseNames? any
---@return ATC_GROUND_PERSIANGULF # self
function ATC_GROUND_PERSIANGULF:New(AirbaseNames) end

---Start SCHEDULER for ATC_GROUND_PERSIANGULF object.
---@param RepeatScanSeconds? any
---@return nil
function ATC_GROUND_PERSIANGULF:Start(RepeatScanSeconds) end

---@class ATC_GROUND_MARIANAISLANDS : ATC_GROUND
ATC_GROUND_MARIANAISLANDS = {
  ClassName = "ATC_GROUND_MARIANAISLANDS",
}

---Creates a new ATC_GROUND_MARIANAISLANDS object.
---@param AirbaseNames? any
---@return ATC_GROUND_MARIANAISLANDS # self
function ATC_GROUND_MARIANAISLANDS:New(AirbaseNames) end

---Start SCHEDULER for ATC_GROUND_MARIANAISLANDS object.
---@param RepeatScanSeconds? any
---@return nil
function ATC_GROUND_MARIANAISLANDS:Start(RepeatScanSeconds) end
