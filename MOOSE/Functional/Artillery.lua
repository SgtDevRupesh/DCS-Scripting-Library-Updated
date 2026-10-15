---@meta

---@class ARTY.Target
---@field name string Name of target.
---@field coord COORDINATE Target coordinates.
---@field radius number Shelling radius in meters.
---@field nshells number Number of shells (or other weapon types) fired upon target.
---@field engaged number Number of times this target was engaged.
---@field underfire boolean If true, target is currently under fire.
---@field prio number Priority of target.
---@field maxengage number Max number of times, the target will be engaged.
---@field time number Abs. mission time in seconds, when the target is scheduled to be attacked.
---@field weapontype number Type of weapon used for engagement. See #ARTY.WeaponType.
---@field Tassigned number Abs. mission time when target was assigned.
---@field attackgroup boolean If true, use task attack group rather than fire at point for engagement.

---@class ARTY.dbitem
---@field displayname string Name displayed in ME.
---@field minrange number Minimum firing range in meters.
---@field maxrange number Maximum firing range in meters.
---@field reloadtime number Reload time in seconds.

---ARTY class
---@class ARTY : FSM_CONTROLLABLE
---@field ClassName string Name of the class.
---@field lid string Log id for DCS.log file.
---@field Debug boolean Write Debug messages to DCS log file and send Debug messages to all players.
---@field targets table All targets assigned.
---@field moves table All moves assigned.
---@field currentTarget ARTY.Target Holds the current target, if there is one assigned.
---@field currentMove table Holds the current commanded move, if there is one assigned.
---@field Nammo0 number Initial amount total ammunition (shells+rockets+missiles) of the whole group.
---@field Nshells0 number Initial amount of shells of the whole group.
---@field Narty0 number Initial amount of artillery shells of the whole group.
---@field Nrockets0 number Initial amount of rockets of the whole group.
---@field Nmissiles0 number Initial amount of missiles of the whole group.
---@field Nukes0 number Initial amount of tactical nukes of the whole group. Default is 0.
---@field Nillu0 number Initial amount of illumination shells of the whole group. Default is 0.
---@field Nsmoke0 number Initial amount of smoke shells of the whole group. Default is 0.
---@field StatusInterval number Update interval in seconds between status updates. Default 10 seconds.
---@field WaitForShotTime number Max time in seconds to wait until fist shot event occurs after target is assigned. If time is passed without shot, the target is deleted. Default is 300 seconds.
---@field DCSdesc table DCS descriptors of the ARTY group.
---@field Type string Type of the ARTY group.
---@field DisplayName string Extended type name of the ARTY group.
---@field IniGroupStrength number Inital number of units in the ARTY group.
---@field IsArtillery boolean If true, ARTY group has attribute "Artillery". This is automatically derived from the DCS descriptor table.
---@field ismobile boolean If true, ARTY group can move.
---@field iscargo boolean If true, ARTY group is defined as possible cargo. If it is immobile, targets out of range are not deleted from the queue.
---@field cargogroup CARGO_GROUP Cargo group object if ARTY group is a cargo that will be transported to another place.
---@field groupname string Name of the ARTY group as defined in the mission editor.
---@field alias string Name of the ARTY group.
---@field clusters table Table of names of clusters the group belongs to. Can be used to address all groups within the cluster simultaniously.
---@field SpeedMax number Maximum speed of ARTY group in km/h. This is determined from the DCS descriptor table.
---@field Speed number Default speed in km/h the ARTY group moves at. Maximum speed possible is 80% of maximum speed the group can do.
---@field RearmingDistance number Safe distance in meters between ARTY group and rearming group or place at which rearming is possible. Default 100 m.
---@field RearmingGroup GROUP Unit designated to rearm the ARTY group.
---@field RearmingGroupSpeed number Speed in km/h the rearming unit moves at. Default is 50% of the max speed possible of the group.
---@field RearmingGroupOnRoad boolean If true, rearming group will move to ARTY group or rearming place using mainly roads. Default false.
---@field RearmingGroupCoord COORDINATE Initial coordinates of the rearming unit. After rearming complete, the unit will return to this position.
---@field RearmingPlaceCoord COORDINATE Coordinates of the rearming place. If the place is more than 100 m away from the ARTY group, the group will go there.
---@field RearmingArtyOnRoad boolean If true, ARTY group will move to rearming place using mainly roads. Default false.
---@field InitialCoord COORDINATE Initial coordinates of the ARTY group.
---@field report boolean Arty group sends messages about their current state or target to its coalition.
---@field ammoshells table Table holding names of the shell types which are included when counting the ammo. Default is {"weapons.shells"} which include most shells.
---@field ammorockets table Table holding names of the rocket types which are included when counting the ammo. Default is {"weapons.nurs"} which includes most unguided rockets.
---@field ammomissiles table Table holding names of the missile types which are included when counting the ammo. Default is {"weapons.missiles"} which includes some guided missiles.
---@field Nshots number Number of shots fired on current target.
---@field minrange number Minimum firing range in kilometers. Targets closer than this distance are not engaged. Default 0.1 km.
---@field maxrange number Maximum firing range in kilometers. Targets further away than this distance are not engaged. Default 10000 km.
---@field nukewarhead number Explosion strength of tactical nuclear warhead in kg TNT. Default 75000.
---@field Nukes number Number of nuclear shells, the group has available. Note that if normal shells are empty, firing nukes is also not possible any more.
---@field Nillu number Number of illumination shells the group has available. Note that if normal shells are empty, firing illumination shells is also not possible any more.
---@field illuPower number Power of illumination warhead in mega candela. Default 1 mcd.
---@field illuMinalt number Minimum altitude in meters the illumination warhead will detonate.
---@field illuMaxalt number Maximum altitude in meters the illumination warhead will detonate.
---@field Nsmoke number Number of smoke shells the group has available. Note that if normal shells are empty, firing smoke shells is also not possible any more.
---@field Smoke SMOKECOLOR color of smoke shells. Default SMOKECOLOR.red.
---@field nukerange number Demolition range of tactical nuclear explostions.
---@field nukefire boolean Ignite additional fires and smoke for nuclear explosions Default true.
---@field nukefires number Number of nuclear fires and subexplosions.
---@field relocateafterfire boolean Group will relocate after each firing task. Default false.
---@field relocateRmin number Minimum distance in meters the group will look for places to relocate.
---@field relocateRmax number Maximum distance in meters the group will look for places to relocate.
---@field markallow boolean If true, Players are allowed to assign targets and moves for ARTY group by placing markers on the F10 map. Default is false.
---@field markkey number Authorization key. Only player who know this key can assign targets and moves via markers on the F10 map. Default no authorization required.
---@field markreadonly boolean Marks for targets are readonly and cannot be removed by players. Default is false.
---@field autorelocate boolean ARTY group will automatically move to within the max/min firing range.
---@field autorelocatemaxdist number Max distance [m] the ARTY group will travel to get within firing range. Default 50000 m = 50 km.
---@field autorelocateonroad boolean ARTY group will use mainly road to automatically get within firing range. Default is false.
---@field coalition number The coalition of the arty group.
---@field respawnafterdeath boolean Respawn arty group after all units are dead.
---@field respawndelay number Respawn delay in seconds.
---@field dtTrack number Time interval in seconds for weapon tracking.
ARTY={
  ClassName="ARTY",
  lid=nil,
  Debug=false,
  targets={},
  moves={},
  currentTarget=nil,
  currentMove=nil,
  Nammo0=0,
  Nshells0=0,
  Nrockets0=0,
  Nmissiles0=0,
  Nukes0=0,
  Nillu0=0,
  Nsmoke0=0,
  StatusInterval=10,
  WaitForShotTime=300,
  DCSdesc=nil,
  Type=nil,
  DisplayName=nil,
  groupname=nil,
  alias=nil,
  clusters={},
  ismobile=true,
  iscargo=false,
  cargogroup=nil,
  IniGroupStrength=0,
  IsArtillery=nil,
  RearmingDistance=100,
  RearmingGroup=nil,
  RearmingGroupSpeed=nil,
  RearmingGroupOnRoad=false,
  RearmingGroupCoord=nil,
  RearmingPlaceCoord=nil,
  RearmingArtyOnRoad=false,
  InitialCoord=nil,
  report=true,
  ammoshells={},
  ammorockets={},
  ammomissiles={},
  Nshots=0,
  minrange=300,
  maxrange=1000000,
  nukewarhead=75000,
  Nukes=nil,
  nukefire=false,
  nukefires=nil,
  nukerange=nil,
  Nillu=nil,
  illuPower=1000000,
  illuMinalt=500,
  illuMaxalt=1000,
  Nsmoke=nil,
  smokeColor=SMOKECOLOR.Red,
  relocateafterfire=false,
  relocateRmin=300,
  relocateRmax=800,
  markallow=false,
  markkey=nil,
  markreadonly=false,
  autorelocate=false,
  autorelocatemaxdist=50000,
  autorelocateonroad=false,
  coalition=nil,
  respawnafterdeath=false,
  respawndelay=nil
}

---Weapong type ID. See [here](http://wiki.hoggit.us/view/DCS_enum_weapon_flag).
---@class ARTY.WeaponType
---@field Auto number Automatic selection of weapon type.
---@field Cannon number Cannons using conventional shells.
---@field Rockets number Unguided rockets.
---@field CruiseMissile number Cruise missiles.
---@field TacticalNukes number Tactical nuclear shells (simulated).
---@field IlluminationShells number Illumination shells (simulated).
---@field SmokeShells number Smoke shells (simulated).
ARTY.WeaponType={
  Auto=1073741822,
  Cannon=805306368,
  Rockets=30720,
  CruiseMissile=2097152,
  TacticalNukes=666,
  IlluminationShells=667,
  SmokeShells=668,
}

---Database of common artillery unit properties.
---Table key is the "type name" and table value is and `ARTY.dbitem`.
---@class ARTY.db
ARTY.db={
  ["LeFH_18-40-105"] = {
    displayname = "FH LeFH-18 105mm", -- name displayed in the ME
    minrange    = 500,                -- min range (green circle) in meters
    maxrange    = 10500,              -- max range (red circle) in meters
    reloadtime  = nil,                -- reload time in seconds
  },
  ["M2A1-105"] = {
    displayname = "FH M2A1 105mm",
    minrange    = 500,
    maxrange    = 11500,
    reloadtime  = nil,
  },
  ["Pak40"] = {
    displayname = "FH Pak 40 75mm",
    minrange    = 500,
    maxrange    = 3000,
    reloadtime  = nil,
  },      
  ["L118_Unit"] = {
    displayname = "L118 Light Artillery Gun",
    minrange    = 500,
    maxrange    = 17500,
    reloadtime  = nil,
  },
  ["Smerch"] = {
    displayname = "MLRS 9A52 Smerch CM 300mm",
    minrange    = 20000,
    maxrange    = 70000,
    reloadtime  = 2160,
  },
  ["Smerch_HE"] = {
    displayname = "MLRS 9A52 Smerch HE 300mm",
    minrange    = 20000,
    maxrange    = 70000,
    reloadtime  = 2160,
  },
  ["Uragan_BM-27"] = {
    displayname = "MLRS 9K57 Uragan BM-27 220mm",
    minrange   = 11500,
    maxrange   = 35800,
    reloadtime = 840,
  },
  ["Grad-URAL"] = {
    displayname = "MLRS BM-21 Grad 122mm",
    minrange   = 5000,
    maxrange   = 19000,
    reloadtime = 420,
  },
  ["HL_B8M1"] = {
    displayname = "MLRS HL with B8M1 80mm",
    minrange   = 500,
    maxrange   = 5000,
    reloadtime = nil,
  },
  ["tt_B8M1"] = {
    displayname = "MLRS LC with B8M1 80mm",
    minrange   = 500,
    maxrange   = 5000,
    reloadtime = nil,
  },
  ["MLRS"] = {
    displayname = "MLRS M270 227mm",
    minrange   = 10000,
    maxrange   = 32000,
    reloadtime = 540,
  },
  ["2B11 mortar"] = {
    displayname = "Mortar 2B11 120mm", 
    minrange    = 500,
    maxrange    = 7000,
    reloadtime  = 30,
  },
  ["PLZ05"] = {
    displayname = "PLZ-05", 
    minrange    = 500,
    maxrange    = 23500,
    reloadtime  = nil,
  },
  ["SAU Gvozdika"] = {
    displayname = "SPH 2S1 Gvozdika 122mm",
    minrange    = 300,
    maxrange    = 15000,
    reloadtime  = nil,
  },
  ["SAU Msta"] = {
    displayname = "SPH 2S19 Msta 152mm",
    minrange    = 300,
    maxrange    = 23500,
    reloadtime  = nil,
  },
  ["SAU Akatsia"] = {
    displayname = "SPH 2S3 Akatsia 152mm",
    minrange    = 300,
    maxrange    = 17000,
    reloadtime  = nil,
  },
  ["SpGH_Dana"] = {
    displayname = "SPH Dana vz77 152mm",
    minrange    = 300,
    maxrange    = 18700,
    reloadtime  = nil,
  },
  ["M-109"] = {
    displayname = "SPH M109 Paladin 155mm",
    minrange    = 300,
    maxrange    = 22000,
    reloadtime  = nil,
  }, 
  ["M12_GMC"] = {
    displayname = "SPH M12 GMC 155mm",
    minrange    = 300,
    maxrange    = 18200,
    reloadtime  = nil,
  },
  ["Wespe124"] = {
    displayname = "SPH Sd.Kfz.124 Wespe 105mm",
    minrange    = 300,
    maxrange    = 7000,
    reloadtime  = nil,
  },
  ["T155_Firtina"] = {
    displayname = "SPH T155 Firtina 155mm",
    minrange    = 300,
    maxrange    = 41000,
    reloadtime  = nil,
  },
  ["SAU 2-C9"] = {
    displayname = "SPM 2S9 Nona 120mm M",
    minrange    = 500,
    maxrange    = 7000,
    reloadtime  = nil,
  },  
}

---Arty script version.
ARTY.version = "1.3.4"

---Creates a new ARTY object from a MOOSE group object.
---@param group? GROUP The GROUP object for which artillery tasks should be assigned.
---@param alias? any
---@return ARTY # ARTY object or nil if group does not exist or is not a ground or naval group.
function ARTY:New(group, alias) end

---Assign target coordinates to the ARTY group. Only the first parameter, i.e. the coordinate of the target is mandatory. The remaining parameters are optional and can be used to fine tune the engagement.
---@param coord? COORDINATE Coordinates of the target.
---@param prio? number (Optional) Priority of target. Number between 1 (high) and 100 (low). Default 50.
---@param radius? number (Optional) Radius. Default is 100 m.
---@param nshells? number (Optional) How many shells (or rockets) are fired on target per engagement. Default 5.
---@param maxengage? number (Optional) How many times a target is engaged. Default 1.
---@param time? string (Optional) Day time at which the target should be engaged. Passed as a string in format "08:13:45". Current task will be canceled.
---@param weapontype? number (Optional) Type of weapon to be used to attack this target. Default ARTY.WeaponType.Auto, i.e. the DCS logic automatically determins the appropriate weapon.
---@param name? string (Optional) Name of the target. Default is LL DMS coordinate of the target. If the name was already given, the numbering "#01", "#02",... is appended automatically.
---@param unique? boolean (Optional) Target is unique. If the target name is already known, the target is rejected. Default false.
---@return string # Name of the target. Can be used for further reference, e.g. deleting the target from the list.
function ARTY:AssignTargetCoord(coord, prio, radius, nshells, maxengage, time, weapontype, name, unique) end

---Assign a target group to the ARTY group. Note that this will use the Attack Group Task rather than the Fire At Point Task.
---@param group? GROUP Target group.
---@param prio? number (Optional) Priority of target. Number between 1 (high) and 100 (low). Default 50.
---@param radius? number (Optional) Radius. Default is 100 m.
---@param nshells? number (Optional) How many shells (or rockets) are fired on target per engagement. Default 5.
---@param maxengage? number (Optional) How many times a target is engaged. Default 1.
---@param time? string (Optional) Day time at which the target should be engaged. Passed as a string in format "08:13:45". Current task will be canceled.
---@param weapontype? number (Optional) Type of weapon to be used to attack this target. Default ARTY.WeaponType.Auto, i.e. the DCS logic automatically determins the appropriate weapon.
---@param name? string (Optional) Name of the target. Default is LL DMS coordinate of the target. If the name was already given, the numbering "#01", "#02",... is appended automatically.
---@param unique? boolean (Optional) Target is unique. If the target name is already known, the target is rejected. Default false.
---@return string # Name of the target. Can be used for further reference, e.g. deleting the target from the list.
function ARTY:AssignAttackGroup(group, prio, radius, nshells, maxengage, time, weapontype, name, unique) end

---Assign coordinate to where the ARTY group should move.
---@param coord? COORDINATE Coordinates of the new position.
---@param time? string (Optional) Day time at which the group should start moving. Passed as a string in format "08:13:45". Default is now.
---@param speed? number (Optional) Speed in km/h the group should move at. Default 70% of max posible speed of group.
---@param onroad? boolean (Optional) If true, group will mainly use roads. Default off, i.e. go directly towards the specified coordinate.
---@param cancel? boolean (Optional) If true, cancel any running attack when move should begin. Default is false.
---@param name? string (Optional) Name of the coordinate. Default is LL DMS string of the coordinate. If the name was already given, the numbering "#01", "#02",... is appended automatically.
---@param unique? boolean (Optional) Move is unique. If the move name is already known, the move is rejected. Default false.
---@return string # Name of the move. Can be used for further reference, e.g. deleting the move from the list.
function ARTY:AssignMoveCoord(coord, time, speed, onroad, cancel, name, unique) end

---Set alias, i.e. the name the group will use when sending messages.
---@param alias? string The alias for the group.
---@return self
function ARTY:SetAlias(alias) end

---Add ARTY group to one or more clusters. Enables addressing all ARTY groups within a cluster simultaniously via marker assignments.
---@param clusters? table Table of cluster names the group should belong to.
---@return self
function ARTY:AddToCluster(clusters) end

---Set minimum firing range. Targets closer than this distance are not engaged.
---@param range? number (Optional) Min range in kilometers. Default is 0.1 km.
---@return self
function ARTY:SetMinFiringRange(range) end

---Set maximum firing range. Targets further away than this distance are not engaged.
---@param range? number (Optional) Max range in kilometers. Default is 1000 km.
---@return self
function ARTY:SetMaxFiringRange(range) end

---Set time interval between status updates. During the status check, new events are triggered.
---@param interval? number (Optional) Time interval in seconds. Default 10 seconds.
---@return self
function ARTY:SetStatusInterval(interval) end

---Set time interval for weapon tracking.
---@param interval? number (Optional) Time interval in seconds. Default 0.2 seconds.
---@return self
function ARTY:SetTrackInterval(interval) end

---Set time how it is waited a unit the first shot event happens. If no shot is fired after this time, the task to fire is aborted and the target removed.
---@param waittime? number (Optional) Time in seconds. Default 300 seconds.
---@return self
function ARTY:SetWaitForShotTime(waittime) end

---Define the safe distance between ARTY group and rearming unit or rearming place at which rearming process is possible.
---@param distance? number (Optional) Safe distance in meters. Default is 100 m.
---@return self
function ARTY:SetRearmingDistance(distance) end

---Assign a group, which is responsible for rearming the ARTY group. If the group is too far away from the ARTY group it will be guided towards the ARTY group.
---@param group? GROUP Group that is supposed to rearm the ARTY group. For the blue coalition, this is often a unarmed M939 transport whilst for red an unarmed Ural-375 transport can be used.
---@return self
function ARTY:SetRearmingGroup(group) end

---Set the speed the rearming group moves at towards the ARTY group or the rearming place.
---@param speed? number Speed in km/h.
---@return self
function ARTY:SetRearmingGroupSpeed(speed) end

---Define if rearming group uses mainly roads to drive to the ARTY group or rearming place.
---@param onroad? boolean If true, rearming group uses mainly roads. If false, it drives directly to the ARTY group or rearming place.
---@return self
function ARTY:SetRearmingGroupOnRoad(onroad) end

---Define if ARTY group uses mainly roads to drive to the rearming place.
---@param onroad? boolean If true, ARTY group uses mainly roads. If false, it drives directly to the rearming place.
---@return self
function ARTY:SetRearmingArtyOnRoad(onroad) end

---Defines the rearming place of the ARTY group. If the place is too far away from the ARTY group it will be routed to the place.
---@param coord? COORDINATE Coordinates of the rearming place.
---@return self
function ARTY:SetRearmingPlace(coord) end

---Set automatic relocation of ARTY group if a target is assigned which is out of range. The unit will drive automatically towards or away from the target to be in max/min firing range.
---@param maxdistance? number (Optional) The maximum distance in km the group will travel to get within firing range. Default is 50 km. No automatic relocation is performed if targets are assigned which are further away.
---@param onroad? boolean (Optional) If true, ARTY group uses roads whenever possible. Default false, i.e. group will move in a straight line to the assigned coordinate.
---@return self
function ARTY:SetAutoRelocateToFiringRange(maxdistance, onroad) end

---Set relocate after firing. Group will find a new location after each engagement. Default is off
---@param rmax? number (Optional) Max distance in meters, the group will move to relocate. Default is 800 m.
---@param rmin? number (Optional) Min distance in meters, the group will move to relocate. Default is 300 m.
---@return self
function ARTY:SetAutoRelocateAfterEngagement(rmax, rmin) end

---Report messages of ARTY group turned on. This is the default.
---@return self
function ARTY:SetReportON() end

---Report messages of ARTY group turned off. Default is on.
---@return self
function ARTY:SetReportOFF() end

---Respawn group once all units are dead.
---@param delay? number (Optional) Delay before respawn in seconds.
---@return self
function ARTY:SetRespawnOnDeath(delay) end

---Turn debug mode on. Information is printed to screen.
---@return self
function ARTY:SetDebugON() end

---Turn debug mode off. This is the default setting.
---@return self
function ARTY:SetDebugOFF() end

---Set default speed the group is moving at if not specified otherwise.
---@param speed? number Speed in km/h.
---@return self
function ARTY:SetSpeed(speed) end

---Delete a target from target list. If the target is currently engaged, it is cancelled.
---@param name? string Name of the target.
function ARTY:RemoveTarget(name) end

---Delete a move from move list.
---@param name? string Name of the target.
function ARTY:RemoveMove(name) end

---Delete ALL targets from current target list.
function ARTY:RemoveAllTargets() end

---Define shell types that are counted to determine the ammo amount the ARTY group has.
---@param tableofnames? table Table of shell type names.
---@return self
function ARTY:SetShellTypes(tableofnames) end

---Define rocket types that are counted to determine the ammo amount the ARTY group has.
---@param tableofnames? table Table of rocket type names.
---@return self
function ARTY:SetRocketTypes(tableofnames) end

---Define missile types that are counted to determine the ammo amount the ARTY group has.
---@param tableofnames? table Table of rocket type names.
---@return self
function ARTY:SetMissileTypes(tableofnames) end

---Set number of tactical nuclear warheads available to the group.
---Note that it can be max the number of normal shells. Also if all normal shells are empty, firing nuclear shells is also not possible any more until group gets rearmed.
---@param n? number Number of warheads for the whole group.
---@return self
function ARTY:SetTacNukeShells(n) end

---Set nuclear warhead explosion strength.
---@param strength? number (Optional) Explosion strength in kilo tons TNT. Default is 0.075 kt.
---@return self
function ARTY:SetTacNukeWarhead(strength) end

---Set number of illumination shells available to the group.
---Note that it can be max the number of normal shells. Also if all normal shells are empty, firing illumination shells is also not possible any more until group gets rearmed.
---@param n? number Number of illumination shells for the whole group.
---@param power? number (Optional) Power of illumination warhead in mega candela. Default 1.0 mcd.
---@return self
function ARTY:SetIlluminationShells(n, power) end

---Set minimum and maximum detotation altitude for illumination shells. A value between min/max is selected randomly.
---The illumination bomb will burn for 300 seconds (5 minutes). Assuming a descent rate of ~3 m/s the "optimal" altitude would be 900 m.
---@param minalt? number (Optional) Minium altitude in meters. Default 500 m.
---@param maxalt? number (Optional) Maximum altitude in meters. Default 1000 m.
---@return self
function ARTY:SetIlluminationMinMaxAlt(minalt, maxalt) end

---Set number of smoke shells available to the group.
---Note that it can be max the number of normal shells. Also if all normal shells are empty, firing smoke shells is also not possible any more until group gets rearmed.
---@param n? number Number of smoke shells for the whole group.
---@param color? SMOKECOLOR (Optional) Color of the smoke. Default SMOKECOLOR.Red.
---@return self
function ARTY:SetSmokeShells(n, color) end

---Set nuclear fires and extra demolition explosions.
---@param nfires? number (Optional) Number of big smoke and fire objects created in the demolition zone.
---@param range? any
---@return self
function ARTY:SetTacNukeFires(nfires, range) end

---Enable assigning targets and moves by placing markers on the F10 map.
---@param key? number (Optional) Authorization key. Only players knowing this key can assign targets. Default is no authorization required.
---@param readonly? boolean (Optional) Marks are readonly and cannot be removed by players. This also means that targets cannot be cancelled by removing the mark. Default false.
---@return self
function ARTY:SetMarkAssignmentsOn(key, readonly) end

---Disable assigning targets by placing markers on the F10 map.
---@return self
function ARTY:SetMarkTargetsOff() end

---After "Start" event. Initialized ROE and alarm state. Starts the event handler.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterStart(Controllable, From, Event, To) end

---Check the DB for properties of the specified artillery unit type.
---@param displayname? any
---@return table # Properties of the requested artillery type. Returns nil if no matching DB entry could be found.
function ARTY:_CheckDB(displayname) end

---After "Start" event. Initialized ROE and alarm state. Starts the event handler.
---@param display? boolean (Optional) If true, send message to coalition. Default false.
function ARTY:_StatusReport(display) end

---Function called during tracking of weapon.
---@param weapon? WEAPON Weapon object.
---@param self ARTY ARTY object.
---@param target? ARTY.Target|number|string Target of the weapon.
function ARTY._FuncTrack(weapon, self, target) end

---Function called after impact of weapon.
---@param weapon? WEAPON Weapon object.
---@param self ARTY ARTY object.
---@param target? ARTY.Target|number|string Target of the weapon.
function ARTY._FuncImpact(weapon, self, target) end

---Eventhandler for shot event.
---@param EventData? EVENTDATA
function ARTY:OnEventShot(EventData) end

---After "Start" event. Initialized ROE and alarm state. Starts the event handler.
---@param Event? table
function ARTY:onEvent(Event) end

---Function called when a F10 map mark was removed.
---@param Event? table Event data.
function ARTY:_OnEventMarkRemove(Event) end

---Function called when a F10 map mark was changed. This happens when a user enters text.
---@param Event? table Event data.
function ARTY:_OnEventMarkChange(Event) end

---Event handler for event Dead.
---@param EventData? EVENTDATA
function ARTY:OnEventDead(EventData) end

---After "Status" event. Report status of group.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterStatus(Controllable, From, Event, To) end

---Before "Loaded" event. Checks if group is currently firing and removes the target by calling CeaseFire.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean # If true, proceed to onafterLoaded.
function ARTY:onbeforeLoaded(Controllable, From, Event, To) end

---After "UnLoaded" event. Group is combat ready again.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean # If true, proceed to onafterLoaded.
function ARTY:onafterUnLoaded(Controllable, From, Event, To) end

---Enter "CombatReady" state. Route the group back if necessary.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onenterCombatReady(Controllable, From, Event, To) end

---Before "OpenFire" event. Checks if group already has a target. Checks for valid min/max range and removes the target if necessary.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? table Array holding the target info.
---@return boolean # If true, proceed to onafterOpenfire.
function ARTY:onbeforeOpenFire(Controllable, From, Event, To, target) end

---After "OpenFire" event. Sets the current target and starts the fire at point task.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? ARTY.Target|number|string Array holding the target info.
function ARTY:onafterOpenFire(Controllable, From, Event, To, target) end

---After "CeaseFire" event. Clears task of the group and removes the target if max engagement was reached.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? table Array holding the target info.
function ARTY:onafterCeaseFire(Controllable, From, Event, To, target) end

---After "Winchester" event. Group is out of ammo. Trigger "Rearm" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterWinchester(Controllable, From, Event, To) end

---Before "Rearm" event. Check if a unit to rearm the ARTY group has been defined.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean # If true, proceed to onafterRearm.
function ARTY:onbeforeRearm(Controllable, From, Event, To) end

---After "Rearm" event. Send message if reporting is on. Route rearming unit to ARTY group.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterRearm(Controllable, From, Event, To) end

---After "Rearmed" event. Send ARTY and rearming group back to their inital positions.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterRearmed(Controllable, From, Event, To) end

---Check if ARTY group is rearmed, i.e. has its full amount of ammo.
---@return boolean # True if rearming is complete, false otherwise.
function ARTY:_CheckRearmed() end

---Before "Move" event. Check if a unit to rearm the ARTY group has been defined.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param move? table Table containing the move parameters.
---@return boolean # If true, proceed to onafterMove.
function ARTY:onbeforeMove(Controllable, From, Event, To, move) end

---After "Move" event. Route group to given coordinate.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param move? table Table containing the move parameters.
function ARTY:onafterMove(Controllable, From, Event, To, move) end

---After "Arrived" event. Group has reached its destination.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterArrived(Controllable, From, Event, To) end

---After "NewTarget" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? table Array holding the target parameters.
function ARTY:onafterNewTarget(Controllable, From, Event, To, target) end

---After "NewMove" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param move? table Array holding the move parameters.
function ARTY:onafterNewMove(Controllable, From, Event, To, move) end

---After "Dead" event, when a unit has died. When all units of a group are dead trigger "Stop" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Unitname? string Name of the unit that died.
function ARTY:onafterDead(Controllable, From, Event, To, Unitname) end

---After "Dead" event, when a unit has died. When all units of a group are dead trigger "Stop" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterRespawn(Controllable, From, Event, To) end

---After "Stop" event. Unhandle events and cease fire on current target.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:onafterStop(Controllable, From, Event, To) end

---Set task for firing at a coordinate.
---@param coord? COORDINATE Coordinates to fire upon.
---@param radius? number Radius around coordinate.
---@param nshells? number Number of shells to fire.
---@param weapontype? number Type of weapon to use.
function ARTY:_FireAtCoord(coord, radius, nshells, weapontype) end

---Set task for attacking a group.
---@param target? ARTY.Target|number|string Target data.
function ARTY:_AttackGroup(target) end

---Model a nuclear blast/destruction by creating fires and destroy scenery.
---@param _coord? COORDINATE Coordinate of the impact point (center of the blast).
function ARTY:_NuclearBlast(_coord) end

---Route group to a certain point.
---@param group? GROUP Group to route.
---@param ToCoord? COORDINATE Coordinate where we want to go.
---@param Speed? number (Optional) Speed in km/h. Default is 70% of max speed the group can do.
---@param OnRoad? boolean If true, use (mainly) roads.
function ARTY:_Move(group, ToCoord, Speed, OnRoad) end

---Function called when group is passing a waypoint.
---@param group? GROUP Group for which waypoint passing should be monitored.
---@param arty? ARTY ARTY object.
---@param i? number Waypoint number that has been reached.
---@param final? boolean True if it is the final waypoint.
function ARTY._PassingWaypoint(group, arty, i, final) end

---Relocate to another position, e.g. after an engagement to avoid couter strikes.
function ARTY:_Relocate() end

---Get the number of shells a unit or group currently has. For a group the ammo count of all units is summed up.
---@param display? boolean (Optional) Display ammo table as message to all. Default false.
---@return number # Total amount of ammo the whole group has left.
---@return number # Number of shells the group has left.
---@return number # Number of rockets the group has left.
---@return number # Number of missiles the group has left.
---@return number # Number of artillery shells the group has left.
function ARTY:GetAmmo(display) end

---Returns a name of a missile category.
---@param categorynumber? number Number of missile category from weapon missile category enumerator. See https://wiki.hoggitworld.com/view/DCS_Class_Weapon
---@return string # Missile category name.
function ARTY:_MissileCategoryName(categorynumber) end

---Extract engagement assignments and parameters from mark text.
---@param text? string Marker text.
---@return boolean # If true, authentification successful.
function ARTY:_MarkerKeyAuthentification(text) end

---Extract engagement assignments and parameters from mark text.
---@param text? string Marker text to be analyzed.
---@return table # Table with assignment parameters, e.g. number of shots, radius, time etc.
function ARTY:_Markertext(text) end

---Request ammo via mark.
function ARTY:_MarkRequestAmmo() end

---Request status via mark.
function ARTY:_MarkRequestStatus() end

---Request Moves.
function ARTY:_MarkRequestMoves() end

---Request Targets.
function ARTY:_MarkRequestTargets() end

---Create a name for an engagement initiated by placing a marker.
---@param markerid? number ID of the placed marker.
---@return string # Name of target engagement.
function ARTY:_MarkTargetName(markerid) end

---Create a name for a relocation move initiated by placing a marker.
---@param markerid? number ID of the placed marker.
---@return string # Name of relocation move.
function ARTY:_MarkMoveName(markerid) end

---Get the marker ID from the assigned task name.
---@param name? string Name of the assignment.
---@return string # Name of the ARTY group or nil
---@return number # ID of the marked target or nil.
---@return number # ID of the marked relocation move or nil
function ARTY:_GetMarkIDfromName(name) end

---Sort targets with respect to priority and number of times it was already engaged.
function ARTY:_SortTargetQueuePrio() end

---Sort array with respect to time. Array elements must have a .time entry.
---@param queue? table Array to sort. Should have elemnt .time.
function ARTY:_SortQueueTime(queue) end

---Heading from point a to point b in degrees.
---@param a? COORDINATE Coordinate.
---@param b? COORDINATE Coordinate.
---@return number # angle Angle from a to b in degrees.
function ARTY:_GetHeading(a, b) end

---Check all targets whether they are in range.
function ARTY:_CheckTargetsInRange() end

---Check all normal (untimed) targets and return the target with the highest priority which has been engaged the fewest times.
---@return table # Target which is due to be attacked now or nil if no target could be found.
function ARTY:_CheckNormalTargets() end

---Check all timed targets and return the target which should be attacked next.
---@return table # Target which is due to be attacked now.
function ARTY:_CheckTimedTargets() end

---Check all moves and return the one which should be executed next.
---@return table # Move which is due.
function ARTY:_CheckMoves() end

---Check whether shooting started within a certain time (~5 min). If not, the current target is considered invalid and removed from the target list.
function ARTY:_CheckShootingStarted() end

---Get the index of a target by its name.
---@param name? string Name of target.
---@return number # Arrayindex of target.
function ARTY:_GetTargetIndexByName(name) end

---Get the index of a move by its name.
---@param name? string Name of move.
---@return number # Arrayindex of move.
function ARTY:_GetMoveIndexByName(name) end

---Check if group is (partly) out of ammo of a special weapon type.
---@param targets? table Table of targets.
---@return any # True if any target requests a weapon type that is empty.
function ARTY:_CheckOutOfAmmo(targets) end

---Check if a selected weapon type is available for this target, i.e. if the current amount of ammo of this weapon type is currently available.
---@param target? boolean Target array data structure.
---@return number # Amount of shells, rockets or missiles available of the weapon type selected for the target.
function ARTY:_CheckWeaponTypeAvailable(target) end

---Check if a selected weapon type is in principle possible for this group. The current amount of ammo might be zero but the group still can be rearmed at a later point in time.
---@param target? boolean Target array data structure.
---@return boolean # True if the group can carry this weapon type, false otherwise.
function ARTY:_CheckWeaponTypePossible(target) end

---Check if a name is unique. If not, a new unique name can be created by adding a running index #01, #02, ...
---@param givennames? table Table with entries of already given names. Must contain a .name item.
---@param name? string Name to check if it already exists in givennames table.
---@param makeunique? boolean If true, a new unique name is returned by appending the running index.
---@return string # Unique name, which is not already given for another target.
function ARTY:_CheckName(givennames, name, makeunique) end

---Check if target is in range.
---@param target? table Target table.
---@param message? boolean (Optional) If true, send a message to the coalition if the target is not in range. Default is no message is send.
---@return boolean # True if target is in range, false otherwise.
---@return boolean # True if ARTY group is too far away from the target, i.e. distance > max firing range.
---@return boolean # True if ARTY group is too close to the target, i.e. distance < min finring range.
---@return boolean # True if target should be removed since ARTY group is immobile and not cargo.
function ARTY:_TargetInRange(target, message) end

---Get the weapon type name, which should be used to attack the target.
---@param tnumber? number Number of weapon type ARTY.WeaponType.XXX
---@return number # tnumber of weapon type.
function ARTY:_WeaponTypeName(tnumber) end

---Find a random coordinate in the vicinity of another coordinate.
---@param coord? COORDINATE Center coordinate.
---@param rmin? number (Optional) Minimum distance in meters from center coordinate. Default 20 m.
---@param rmax? number (Optional) Maximum distance in meters from center coordinate. Default 80 m.
---@return COORDINATE # Random coordinate in a certain distance from center coordinate.
function ARTY:_VicinityCoord(coord, rmin, rmax) end

---Print event-from-to string to DCS log file.
---@param BA? string Before/after info.
---@param Event? string Event.
---@param From? string From state.
---@param To? string To state.
function ARTY:_EventFromTo(BA, Event, From, To) end

---Split string. C.f. http://stackoverflow.com/questions/1426954/split-string-in-lua
---@param str? string Sting to split.
---@param sep? string Speparator for split.
---@return table # Split text.
function ARTY:_split(str, sep) end

---Returns the target parameters as formatted string.
---@param target? ARTY.Target|number|string The target data.
---@return string # name, prio, radius, nshells, engaged, maxengage, time, weapontype
function ARTY:_TargetInfo(target) end

---Returns a formatted string with information about all move parameters.
---@param move? table Move table item.
---@return string # Info string.
function ARTY:_MoveInfo(move) end

---Convert Latitude and Lontigude from DMS to DD.
---@param l1? string Latitude or longitude as string in the format DD:MM:SS N/S/W/E
---@param l2? string Latitude or longitude as string in the format DD:MM:SS N/S/W/E
---@return number # Latitude in decimal degree format.
---@return number # Longitude in decimal degree format.
function ARTY:_LLDMS2DD(l1, l2) end

---Convert time in seconds to hours, minutes and seconds.
---@param seconds? number Time in seconds.
---@return string # Time in format Hours:minutes:seconds.
function ARTY:_SecondsToClock(seconds) end

---Convert clock time from hours, minutes and seconds to seconds.
---@param clock? string String of clock time. E.g., "06:12:35".
function ARTY:_ClockToSeconds(clock) end

---User function for OnAfter "NewTarget" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? table Array holding the target info.
function ARTY:OnAfterNewTarget(Controllable, From, Event, To, target) end

---User function for OnAfter "OpenFire" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? table Array holding the target info.
function ARTY:OnAfterOpenFire(Controllable, From, Event, To, target) end

---User function for OnAfter "CeaseFire" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param target? table Array holding the target info.
function ARTY:OnAfterCeaseFire(Controllable, From, Event, To, target) end

---User function for OnAfer "NewMove" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param move? table Array holding the move info.
function ARTY:OnAfterNewMove(Controllable, From, Event, To, move) end

---User function for OnAfer "Move" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param move? table Array holding the move info.
function ARTY:OnAfterMove(Controllable, From, Event, To, move) end

---User function for OnAfer "Arrived" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterArrvied(Controllable, From, Event, To) end

---User function for OnAfter "Winchester" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterWinchester(Controllable, From, Event, To) end

---User function for OnAfter "Rearm" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterRearm(Controllable, From, Event, To) end

---User function for OnAfter "Rearmed" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterRearmed(Controllable, From, Event, To) end

---User function for OnAfter "Start" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterStart(Controllable, From, Event, To) end

---User function for OnAfter "Status" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterStatus(Controllable, From, Event, To) end

---User function for OnAfter "Dead" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Unitname? string Name of the dead unit.
function ARTY:OnAfterDead(Controllable, From, Event, To, Unitname) end

---User function for OnAfter "Respawn" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnAfterRespawn(Controllable, From, Event, To) end

---User function for OnEnter "CombatReady" state.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnEnterCombatReady(Controllable, From, Event, To) end

---User function for OnEnter "Firing" state.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnEnterFiring(Controllable, From, Event, To) end

---User function for OnEnter "OutOfAmmo" state.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnEnterOutOfAmmo(Controllable, From, Event, To) end

---User function for OnEnter "Rearming" state.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnEnterRearming(Controllable, From, Event, To) end

---User function for OnEnter "Rearmed" state.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnEnterRearmed(Controllable, From, Event, To) end

---User function for OnEnter "Moving" state.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ARTY:OnEnterMoving(Controllable, From, Event, To) end

---Function to start the ARTY FSM process.
function ARTY:Start() end

---Function to start the ARTY FSM process after a delay.
---@param Delay? number before start in seconds.
function ARTY:__Start(Delay) end

---Function to update the status of the ARTY group and tigger FSM events. Triggers the FSM event "Status".
function ARTY:Status() end

---Function to update the status of the ARTY group and tigger FSM events after a delay. Triggers the FSM event "Status".
---@param Delay? number in seconds.
function ARTY:__Status(Delay) end

---Function called when a unit of the ARTY group died. Triggers the FSM event "Dead".
---@param unitname? string Name of the unit that died.
function ARTY:Dead(unitname) end

---Function called when a unit of the ARTY group died after a delay. Triggers the FSM event "Dead".
---@param Delay? number in seconds.
---@param unitname? string Name of the unit that died.
function ARTY:__Dead(Delay, unitname) end

---Add a new target for the ARTY group. Triggers the FSM event "NewTarget".
---@param target? table Array holding the target data.
function ARTY:NewTarget(target) end

---Add a new target for the ARTY group with a delay. Triggers the FSM event "NewTarget".
---@param delay? number Delay in seconds.
---@param target? table Array holding the target data.
function ARTY:__NewTarget(delay, target) end

---Add a new relocation move for the ARTY group. Triggers the FSM event "NewMove".
---@param move? table Array holding the relocation move data.
function ARTY:NewMove(move) end

---Add a new relocation for the ARTY group after a delay. Triggers the FSM event "NewMove".
---@param delay? number Delay in seconds.
---@param move? table Array holding the relocation move data.
function ARTY:__NewMove(delay, move) end

---Order ARTY group to open fire on a target. Triggers the FSM event "OpenFire".
---@param target? table Array holding the target data.
function ARTY:OpenFire(target) end

---Order ARTY group to open fire on a target with a delay. Triggers the FSM event "Move".
---@param delay? number Delay in seconds.
---@param target? table Array holding the target data.
function ARTY:__OpenFire(delay, target) end

---Order ARTY group to cease firing on a target. Triggers the FSM event "CeaseFire".
---@param target? table Array holding the target data.
function ARTY:CeaseFire(target) end

---Order ARTY group to cease firing on a target after a delay. Triggers the FSM event "CeaseFire".
---@param delay? number Delay in seconds.
---@param target? table Array holding the target data.
function ARTY:__CeaseFire(delay, target) end

---Order ARTY group to move to another location. Triggers the FSM event "Move".
---@param move? table Array holding the relocation move data.
function ARTY:Move(move) end

---Order ARTY group to move to another location after a delay. Triggers the FSM event "Move".
---@param delay? number Delay in seconds.
---@param move? table Array holding the relocation move data.
function ARTY:__Move(delay, move) end

---Tell ARTY group it has arrived at its destination. Triggers the FSM event "Arrived".
function ARTY:Arrived() end

---Tell ARTY group it has arrived at its destination after a delay. Triggers the FSM event "Arrived".
---@param delay? number Delay in seconds.
function ARTY:__Arrived(delay) end

---Tell ARTY group it is combat ready. Triggers the FSM event "CombatReady".
function ARTY:CombatReady() end

---Tell ARTY group it is combat ready after a delay. Triggers the FSM event "CombatReady".
---@param delay? number Delay in seconds.
function ARTY:__CombatReady(delay) end

---Tell ARTY group it is out of ammo. Triggers the FSM event "Winchester".
function ARTY:Winchester() end

---Tell ARTY group it is out of ammo after a delay. Triggers the FSM event "Winchester".
---@param delay? number Delay in seconds.
function ARTY:__Winchester(delay) end

---Respawn ARTY group.
function ARTY:Respawn() end

---Respawn ARTY group after a delay.
---@param delay? number Delay in seconds.
function ARTY:__Respawn(delay) end
