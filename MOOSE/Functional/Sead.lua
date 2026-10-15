---@meta

---@class SEAD : BASE
---@field ClassName string The Class Name.
---@field TargetSkill table Table of target skills.
---@field SEADGroupPrefixes table Table of SEAD prefixes.
---@field SuppressedGroups table Table of currently suppressed groups.
---@field EngagementRange number Engagement Range.
---@field Padding number Padding in seconds.
---@field CallBack function Callback function for suppression plans.
---@field UseCallBack boolean Switch for callback function to be used.
---@field debug boolean Debug switch.
---@field WeaponTrack boolean Track switch, if true track weapon speed for 30 secs.
SEAD = {
  ClassName = "SEAD",
  TargetSkill = {
    Average   = { Evade = 30, DelayOn = { 40, 60 } } ,
    Good      = { Evade = 20, DelayOn = { 30, 50 } } ,
    High      = { Evade = 15, DelayOn = { 20, 40 } } ,
    Excellent = { Evade = 10, DelayOn = { 10, 30 } }
  },
  SEADGroupPrefixes = {},
  SuppressedGroups = {},
  EngagementRange = 75, --  default 75% engagement range Feature Request #1355
  Padding = 15,
  CallBack = nil,
  UseCallBack = false,
  debug = false,
  WeaponTrack = false,
}

---Creates the main object which is handling defensive actions for SA sites or moving SA vehicles.
---When an anti radiation missile is fired (KH-58, KH-31P, KH-31A, KH-25MPU, HARM missiles), the SA will shut down their radars and will take evasive actions...
---Chances are big that the missile will miss.
---@param SEADGroupPrefixes? table Table of #string entries or single #string, which is a table of Prefixes of the SA Groups in the DCS mission editor on which evasive actions need to be taken.
---@param Padding? number (Optional) Extra number of seconds to add to radar switch-back-on time
---@return SEAD # self
function SEAD:New(SEADGroupPrefixes, Padding) end

---Update the active SEAD Set (while running)
---@param SEADGroupPrefixes? table The prefixes to add, note: can also be a single #string
---@return SEAD # self
function SEAD:UpdateSet(SEADGroupPrefixes) end

---Sets the engagement range of the SAMs. Defaults to 75% to make it more deadly. Feature Request #1355
---@param range? number (Optional) Set the engagement range in percent, e.g. 55 (default 75)
---@return SEAD # self
function SEAD:SetEngagementRange(range) end

---Set the padding in seconds, which extends the radar off time calculated by SEAD
---@param Padding? number (Optional) Extra number of seconds to add for the switch-on (default 10 seconds)
---@return SEAD # self
function SEAD:SetPadding(Padding) end

---Set SEAD to use emissions on/off in addition to alarm state.
---@param Switch? boolean True for on, false for off.
---@return SEAD # self
function SEAD:SwitchEmissions(Switch) end

---Set an object to call back when going evasive.
---@param Object? table The object to call. Needs to have object functions as follows: `:SeadSuppressionPlanned(Group, Name, SuppressionStartTime, SuppressionEndTime)` `:SeadSuppressionStart(Group, Name)`, `:SeadSuppressionEnd(Group, Name)`,
---@return SEAD # self
function SEAD:AddCallBack(Object) end

---(Internal) Check if a known HARM was fired
---@param WeaponName? string
---@return boolean # Returns true for a match
---@return string # name Name of hit in table
function SEAD:_CheckHarms(WeaponName) end

---(Internal) Return distance in meters between two coordinates or -1 on error.
---@param _point1? COORDINATE Coordinate one
---@param _point2? COORDINATE Coordinate two
---@return number # Distance in meters
function SEAD:_GetDistance(_point1, _point2) end

---(Internal) Calculate hit zone of an AGM-88
---@param From? any
---@param Event? any
---@param To? any
---@param SEADWeapon? table DCS.Weapon object
---@param pos0? COORDINATE Position of the plane when it fired
---@param height? number Height when the missile was fired
---@param SEADGroup? GROUP Attacker group
---@param SEADWeaponName? string Weapon Name
---@return SEAD # self
function SEAD:onafterCalculateHitZone(From, Event, To, SEADWeapon, pos0, height, SEADGroup, SEADWeaponName) end

---(Internal) Handle Evasion
---@param From? any
---@param Event? any
---@param To? any
---@param _targetskill? string
---@param _targetgroup? GROUP
---@param SEADPlanePos? COORDINATE
---@param SEADWeaponName? string
---@param SEADGroup? GROUP Attacker Group
---@param timeoffset? number Offset for tti calc
---@param Weapon? WEAPON
---@return SEAD # self
function SEAD:onafterManageEvasion(From, Event, To, _targetskill, _targetgroup, SEADPlanePos, SEADWeaponName, SEADGroup, timeoffset, Weapon) end

---(Internal) Detects if an SAM site was shot with an anti radiation missile. In this case, take evasive actions based on the skill level set within the ME.
---@param EventData? EVENTDATA
---@return SEAD # self
function SEAD:HandleEventShot(EventData) end
