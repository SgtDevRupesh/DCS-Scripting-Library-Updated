---@meta

---**SHORAD** class, extends Core.Base#BASE
---@class SHORAD : BASE
---@field ClassName string
---@field name string Name of this Shorad
---@field debug boolean Set the debug state
---@field Prefixes string String to be used to build the @{#Core.Set#SET_GROUP}
---@field Radius number Shorad defense radius in meters
---@field Groupset SET_GROUP The set of Shorad groups
---@field Samset SET_GROUP The set of SAM groups to defend
---@field Coalition string The coalition of this Shorad
---@field ActiveTimer number How long a Shorad stays active after wake-up in seconds
---@field ActiveGroups table Table for the timer function
---@field lid string The log ID for the dcs.log
---@field DefendHarms boolean Default true, intercept incoming HARMS
---@field DefendMavs boolean Default true, intercept incoming AG-Missiles
---@field DefenseLowProb number Default 70, minimum detection limit
---@field DefenseHighProb number Default 90, maximum detection limit
---@field UseEmOnOff boolean Decide if we are using Emission on/off (default) or AlarmState red/green
---@field shootandscoot boolean If true, shoot and scoot between zones
---@field SkateNumber number Number of zones to consider
---@field SkateZones SET_ZONE Zones in this set are considered
---@field minscootdist number Min distance of the next zone
---@field maxscootdist number Max distance of the next zone
---@field scootrandomcoord boolean If true, use a random coordinate in the zone and not the center
---@field scootformation string Formation to take for scooting, e.g. "Vee" or "Cone"
---@field SmokeDecoy boolean = false,
---@field SmokeDecoyColor number = SMOKECOLOR.White
SHORAD = {
  ClassName = "SHORAD",
  name = "MyShorad",
  debug = false,
  Prefixes = "",
  Radius = 20000,
  Groupset = nil,
  Samset = nil,
  Coalition = nil,
  ActiveTimer = 600, --stay on 10 mins
  ActiveGroups = {},
  lid = "",
  DefendHarms = true,
  DefendMavs = true,
  DefenseLowProb = 70,
  DefenseHighProb = 90,
  UseEmOnOff = true,
  shootandscoot = false,
  SkateNumber = 3,
  SkateZones = nil,
  minscootdist = 100,
  maxscootdist = 3000,
  scootrandomcoord = false, 
  SmokeDecoy = false,
  SmokeDecoyColor = SMOKECOLOR.White 
}

---Instantiates a new SHORAD object
---@param Name? string (Optional) Name of this SHORAD. Default "MyShorad"
---@param ShoradPrefix? string (Optional) Filter for the Shorad #SET_GROUP. Default "SAM SHORAD"
---@param Samset? SET_GROUP (Optional) The #SET_GROUP of SAM sites to defend. Default is based on default ShoradPrefix and default Coalition.
---@param Radius? number (Optional) Defense radius in meters, used to switch on SHORAD groups **within** this radius. Default is 20000m.
---@param ActiveTimer? number (Optional) Determines how many seconds the systems stay on red alert after wake-up call. Default 600s
---@param Coalition? string Coalition, i.e. "blue", "red", or "neutral"
---@param UseEmOnOff? boolean Use Emissions On/Off rather than Alarm State Red/Green (default: use Emissions switch)
---@param SmokeDecoy? boolean (Optional) Throw smoke decoy when getting activated. Defaults to false.
---@param SmokeDecoyColor? number (Optional) SMOLECOLOR to use. Defaults to SMOLECOLOR.White
---@return SHORAD # self
function SHORAD:New(Name, ShoradPrefix, Samset, Radius, ActiveTimer, Coalition, UseEmOnOff, SmokeDecoy, SmokeDecoyColor) end

---Initially set all groups to alarm state GREEN
---@return SHORAD # self
function SHORAD:_InitState() end

---Add a SET_ZONE of zones for Shoot&Scoot
---@param ZoneSet? SET_ZONE Set of zones to be used. Units will move around to the next (random) zone between 100m and 3000m away.
---@param Number? number (Optional) Number of closest zones to be considered, defaults to 3.
---@param Random? boolean If true, use a random coordinate inside the next zone to scoot to.
---@param Formation? string (Optional) Formation to use, defaults to "Cone". See mission editor dropdown for options.
---@return SHORAD # self
function SHORAD:AddScootZones(ZoneSet, Number, Random, Formation) end

---Switch debug state on
---@param onoff? any
---@return SHORAD # self
function SHORAD:SwitchDebug(onoff) end

---Switch debug state on
---@return SHORAD # self
function SHORAD:SwitchDebugOn() end

---Switch debug state off
---@return SHORAD # self
function SHORAD:SwitchDebugOff() end

---Switch defense for HARMs
---@param onoff? boolean
---@return SHORAD # self
function SHORAD:SwitchHARMDefense(onoff) end

---Switch defense for AGMs
---@param onoff? boolean
---@return SHORAD # self
function SHORAD:SwitchAGMDefense(onoff) end

---Set defense probability limits
---@param low? number Minimum detection limit, integer 1-100
---@param high? number Maximum detection limit integer 1-100
---@return SHORAD # self
function SHORAD:SetDefenseLimits(low, high) end

---Set the number of seconds a SHORAD site will stay active
---@param seconds? number Number of seconds systems stay active
---@return SHORAD # self
function SHORAD:SetActiveTimer(seconds) end

---Set the number of meters for the SHORAD defense zone
---@param meters? number Radius of the defense search zone in meters. #SHORADs in this range around a targeted group will go active
---@return SHORAD # self
function SHORAD:SetDefenseRadius(meters) end

---Set using Emission on/off instead of changing alarm state
---@param switch? boolean Decide if we are changing alarm state or AI state
---@return SHORAD # self
function SHORAD:SetUsingEmOnOff(switch) end

---Check if a HARM was fired
---@param WeaponName? string
---@return boolean # Returns true for a match
function SHORAD:_CheckHarms(WeaponName) end

---Check if an AGM was fired
---@param WeaponName? string
---@return boolean # Returns true for a match
function SHORAD:_CheckMavs(WeaponName) end

---Check the coalition of the attacker
---@param Coalition? string name
---@return boolean # Returns false for a match
function SHORAD:_CheckCoalition(Coalition) end

---Check if the missile is aimed at a SHORAD
---@param TargetGroupName? string Name of the target group
---@return boolean # Returns true for a match, else false
function SHORAD:_CheckShotAtShorad(TargetGroupName) end

---Check if the missile is aimed at a SAM site
---@param TargetGroupName? string Name of the target group
---@return boolean # Returns true for a match, else false
function SHORAD:_CheckShotAtSams(TargetGroupName) end

---Set an object to call back when going evasive.
---@param Object? table The object to call.
---@return SHORAD # self
function SHORAD:AddCallBack(Object) end

---Smoke a SHORAD Group
---@param Group? GROUP The Shorad Group to Smoke
---@return self
function SHORAD:_SmokeUnits(Group) end

---Calculate if the missile shot is detected
---@return boolean # Returns true for a detection, else false
function SHORAD:_ShotIsDetected() end

---Wake up #SHORADs in a zone with diameter Radius for ActiveTimer seconds
---@param From? any
---@param Event? any
---@param To? any
---@param TargetGroup? string Name of the target group used to build the #ZONE
---@param Radius? number Radius of the #ZONE
---@param ActiveTimer? number Number of seconds to stay active
---@param TargetCat? number (optional) Category, i.e. Object.Category.UNIT or Object.Category.STATIC
---@param ShotAt? boolean If true, function is called after a shot
---@param TargetedShot? boolean (Optional) If true, the detected weapon directly targeted a SHORAD group
---@return SHORAD # self
function SHORAD:onafterWakeUpShorad(From, Event, To, TargetGroup, Radius, ActiveTimer, TargetCat, ShotAt, TargetedShot) end

---(Internal) Calculate hit zone of an AGM-88
---@param From? any
---@param Event? any
---@param To? any
---@param SEADWeapon? table DCS.Weapon object
---@param pos0? COORDINATE Position of the plane when it fired
---@param height? number Height when the missile was fired
---@param SEADGroup? GROUP Attacker group
---@return SHORAD # self
function SHORAD:onafterCalculateHitZone(From, Event, To, SEADWeapon, pos0, height, SEADGroup) end

---(Internal) Shoot and Scoot
---@param From? string
---@param Event? string
---@param To? string
---@param Shorad? GROUP Shorad group
---@return SHORAD # self
function SHORAD:onafterShootAndScoot(From, Event, To, Shorad) end

---Main function - work on the EventData
---@param EventData? EVENTDATA The event details table data set
---@return SHORAD # self
function SHORAD:HandleEventShot(EventData) end
