---@meta

---@class FOX.MissileData
---@field weapon Weapon Missile weapon object.
---@field active boolean If true the missile is active.
---@field missileType string Type of missile.
---@field missileName string Name of missile.
---@field missileRange number Range of missile in meters.
---@field fuseDist number Fuse distance in meters.
---@field explosive number Explosive mass in kg TNT.
---@field shooterUnit UNIT Unit that shot the missile.
---@field shooterGroup GROUP Group that shot the missile.
---@field shooterCoalition number Coalition side of the shooter.
---@field shooterName string Name of the shooter unit.
---@field shotTime number Abs. mission time in seconds the missile was fired.
---@field shotCoord COORDINATE Coordinate where the missile was fired.
---@field targetUnit UNIT Unit that was targeted.
---@field targetName string Name of the target unit or "unknown".
---@field targetOrig string Name of the "original" target, i.e. the one right after launched.
---@field targetPlayer FOX.PlayerData Player that was targeted or nil.
---@field missileCoord COORDINATE Missile coordinate during tracking.
---@field Weapon WEAPON Weapon object.

---@class FOX.PlayerData
---@field unit UNIT Aircraft of the player.
---@field unitname string Name of the unit.
---@field client CLIENT Client object of player.
---@field callsign string Callsign of player.
---@field group GROUP Aircraft group of player.
---@field groupname string Name of the the player aircraft group.
---@field name string Player name.
---@field coalition number Coalition number of player.
---@field destroy boolean Destroy missile.
---@field launchalert boolean Alert player on detected missile launch.
---@field marklaunch boolean Mark position of launched missile on F10 map.
---@field defeated number Number of missiles defeated.
---@field dead number Number of missiles not defeated.
---@field inzone boolean Player is inside a protected zone.

---FOX class.
---@class FOX : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field Debug boolean Debug mode. Messages to all about status.
---@field lid string Class id string for output to DCS log file.
---@field menuadded table Table of groups the menu was added for.
---@field menudisabled boolean If true, F10 menu for players is disabled.
---@field destroy boolean Default player setting for destroying missiles.
---@field launchalert boolean Default player setting for launch alerts.
---@field marklaunch boolean Default player setting for mark launch coordinates.
---@field players table Table of players.
---@field missiles table Table of tracked missiles.
---@field safezones table Table of practice zones.
---@field launchzones table Table of launch zones.
---@field protectedset SET_GROUP Set of protected groups.
---@field explosionpower number Power of explostion when destroying the missile in kg TNT. Default 5 kg TNT.
---@field explosiondist number Missile player distance in meters for destroying smaller missiles. Default 200 m.
---@field explosiondist2 number Missile player distance in meters for destroying big missiles. Default 500 m.
---@field bigmissilemass number Explosion power of big missiles. Default 50 kg TNT. Big missiles will be destroyed earlier.
---@field dt50 number Time step [sec] for missile position updates if distance to target > 50 km. Default 5 sec.
---@field dt10 number Time step [sec] for missile position updates if distance to target > 10 km and < 50 km. Default 1 sec.
---@field dt05 number Time step [sec] for missile position updates if distance to target > 5 km and < 10 km. Default 0.5 sec.
---@field dt01 number Time step [sec] for missile position updates if distance to target > 1 km and < 5 km. Default 0.1 sec.
---@field dt00 number Time step [sec] for missile position updates if distance to target < 1 km. Default 0.01 sec.
FOX = {
  ClassName      = "FOX",
  verbose        =    0,
  Debug          = false,
  lid            =   nil,
  menuadded      =    {},
  menudisabled   =   nil,
  destroy        =   nil,
  launchalert    =   nil,
  marklaunch     =   nil,
  missiles       =    {},
  players        =    {},
  safezones      =    {},
  launchzones    =    {},
  protectedset   =   nil,
  explosionpower =   0.1,
  explosiondist  =   200,
  explosiondist2 =   500,
  bigmissilemass =    50,
  dt50           =     5,
  dt10           =     1,
  dt05           =   0.5,
  dt01           =   0.1,
  dt00           =  0.01,
}

---Main radio menu on group level.
FOX.MenuF10={}

---FOX class version.
FOX.version = "0.8.0"

---Create a new FOX class object.
---@return FOX # self.
function FOX:New() end

---On after Start event. Starts the missile trainer and adds event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FOX:onafterStart(From, Event, To) end

---On after Stop event. Stops the missile trainer and unhandles events.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FOX:onafterStop(From, Event, To) end

---Add a training zone. Players in the zone are safe.
---@param zone? ZONE Training zone.
---@return FOX # self
function FOX:AddSafeZone(zone) end

---Add a launch zone. Only missiles launched within these zones will be tracked.
---@param zone? ZONE Training zone.
---@return FOX # self
function FOX:AddLaunchZone(zone) end

---Add a protected set of groups.
---@param groupset? SET_GROUP The set of groups.
---@return FOX # self
function FOX:SetProtectedGroupSet(groupset) end

---Add a group to the protected set. Works only with AI!
---@param group? GROUP Protected group.
---@return FOX # self
function FOX:AddProtectedGroup(group) end

---Set explosion power. This is an "artificial" explosion generated when the missile is destroyed. Just for the visual effect.
---Don't set the explosion power too big or it will harm the aircraft in the vicinity.
---@param power? number (Optional) Explosion power in kg TNT. Default 0.1 kg.
---@return FOX # self
function FOX:SetExplosionPower(power) end

---Set missile-player distance when missile is destroyed.
---@param distance? number (Optional) Distance in meters. Default 200 m.
---@return FOX # self
function FOX:SetExplosionDistance(distance) end

---Set missile-player distance when BIG missiles are destroyed.
---@param distance? number (Optional) Distance in meters. Default 500 m.
---@param explosivemass? number (Optional) Explosive mass of missile threshold in kg TNT. Default 50 kg.
---@return FOX # self
function FOX:SetExplosionDistanceBigMissiles(distance, explosivemass) end

---Disable F10 menu for all players.
---@return FOX # self
function FOX:SetDisableF10Menu() end

---Enable F10 menu for all players.
---@return FOX # self
function FOX:SetEnableF10Menu() end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return FOX # self
function FOX:SetVerbosity(VerbosityLevel) end

---Set default player setting for missile destruction.
---@param switch? boolean If true missiles are destroyed. If false/nil missiles are not destroyed.
---@return FOX # self
function FOX:SetDefaultMissileDestruction(switch) end

---Set default player setting for launch alerts.
---@param switch? boolean If true launch alerts to players are active. If false/nil no launch alerts are given.
---@return FOX # self
function FOX:SetDefaultLaunchAlerts(switch) end

---Set default player setting for marking missile launch coordinates
---@param switch? boolean If true missile launches are marked. If false/nil marks are disabled.
---@return FOX # self
function FOX:SetDefaultLaunchMarks(switch) end

---Set debug mode on/off.
---@param switch? boolean If true debug mode on. If false/nil debug mode off.
---@return FOX # self
function FOX:SetDebugOnOff(switch) end

---Set debug mode on.
---@return FOX # self
function FOX:SetDebugOn() end

---Set debug mode off.
---@return FOX # self
function FOX:SetDebugOff() end

---Check spawn queue and spawn aircraft if necessary.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FOX:onafterStatus(From, Event, To) end

---Check status of players.
function FOX:_CheckPlayers() end

---Remove missile.
---@param missile? FOX.MissileData|number|string Missile data.
function FOX:_RemoveMissile(missile) end

---Missile status.
function FOX:_CheckMissileStatus() end

---Check if missile target is protected.
---@param targetunit? UNIT Target unit.
---@return boolean # If true, unit is protected.
function FOX:_IsProtected(targetunit) end

---Function called from weapon tracking.
---@param weapon? WEAPON Weapon object.
---@param self FOX FOX object.
---@param missile? FOX.MissileData|number|string Fired missile
function FOX._FuncTrack(weapon, self, missile) end

---Callback function on impact or destroy otherwise.
---@param weapon? WEAPON Weapon object.
---@param self FOX FOX object.
---@param missile? FOX.MissileData|number|string Fired missile.
function FOX._FuncImpact(weapon, self, missile) end

---Missle launch event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param missile? FOX.MissileData|number|string Fired missile
function FOX:onafterMissileLaunch(From, Event, To, missile) end

---FOX event handler for event birth.
---@param EventData? EVENTDATA
function FOX:OnEventPlayerEnterAircraft(EventData) end

---FOX event handler for event birth.
---@param EventData? EVENTDATA
function FOX:OnEventBirth(EventData) end

---Get missile target.
---@param missile? FOX.MissileData|number|string The missile data table.
function FOX:GetMissileTarget(missile) end

---FOX event handler for event shot (when a unit releases a rocket or bomb (but not a fast firing gun).
---@param EventData? EVENTDATA
function FOX:OnEventShot(EventData) end

---FOX event handler for event hit.
---@param EventData? EVENTDATA
function FOX:OnEventHit(EventData) end

---Add menu commands for player.
---@param _unitName? string Name of player unit.
function FOX:_AddF10Commands(_unitName) end

---Turn player's launch alert on/off.
---@param _unitname? string Name of the player unit.
function FOX:_MyStatus(_unitname) end

---Turn player's launch alert on/off.
---@param playername? string Name of the player.
---@return number # Number of missiles targeting the player.
---@return string # Missile info.
function FOX:_GetTargetMissiles(playername) end

---Turn player's launch alert on/off.
---@param _unitname? string Name of the player unit.
function FOX:_ToggleLaunchAlert(_unitname) end

---Turn player's launch marks on/off.
---@param _unitname? string Name of the player unit.
function FOX:_ToggleLaunchMark(_unitname) end

---Turn destruction of missiles on/off for player.
---@param _unitname? string Name of the player unit.
function FOX:_ToggleDestroyMissiles(_unitname) end

---Get a random text message in case you die.
---@return string # Text in case you die.
function FOX:_DeadText() end

---Check if a coordinate lies within a safe training zone.
---@param coord? COORDINATE Coordinate to check. Can also be a DCS#Vec3.
---@return boolean # True if safe.
function FOX:_CheckCoordSafe(coord) end

---Check if a coordinate lies within a launch zone.
---@param coord? COORDINATE Coordinate to check. Can also be a DCS#Vec2.
---@return boolean # True if in launch zone.
function FOX:_CheckCoordLaunch(coord) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param weapon? Weapon The weapon.
---@return number # Heading of weapon in degrees or -1.
function FOX:_GetWeapongHeading(weapon) end

---Tell player notching headings.
---@param playerData? FOX.PlayerData|number|string Player data.
---@param weapon? Weapon The weapon.
function FOX:_SayNotchingHeadings(playerData, weapon) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param weapon? Weapon The weapon.
---@return number # Notching heading right, i.e. missile heading +90°.
---@return number # Notching heading left, i.e. missile heading -90°.
function FOX:_GetNotchingHeadings(weapon) end

---Returns the player data from a unit name.
---@param unitName? string Name of the unit.
---@return FOX.PlayerData # Player data.
function FOX:_GetPlayerFromUnitname(unitName) end

---Retruns the player data from a unit.
---@param unit? UNIT
---@return FOX.PlayerData # Player data.
function FOX:_GetPlayerFromUnit(unit) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param _unitName? string Name of the player unit.
---@return UNIT # Unit of player or nil.
---@return string # Name of the player or nil.
function FOX:_GetPlayerUnitAndName(_unitName) end

---Triggers the FSM event "Start". Starts the FOX. Initializes parameters and starts event handlers.
function FOX:Start() end

---Triggers the FSM event "Start" after a delay. Starts the FOX. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function FOX:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the FOX and all its event handlers.
---@param delay? number Delay in seconds.
function FOX:__Stop(delay) end

---Triggers the FSM event "Status".
function FOX:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function FOX:__Status(delay) end

---Triggers the FSM event "MissileLaunch".
---@param missile? FOX.MissileData|number|string Data of the fired missile.
function FOX:MissileLaunch(missile) end

---Triggers the FSM delayed event "MissileLaunch".
---@param delay? number Delay in seconds before the function is called.
---@param missile? FOX.MissileData|number|string Data of the fired missile.
function FOX:__MissileLaunch(delay, missile) end

---On after "MissileLaunch" event user function. Called when a missile was launched.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param missile? FOX.MissileData|number|string Data of the fired missile.
function FOX:OnAfterMissileLaunch(From, Event, To, missile) end

---Triggers the FSM event "MissileDestroyed".
---@param missile? FOX.MissileData|number|string Data of the destroyed missile.
function FOX:MissileDestroyed(missile) end

---Triggers the FSM delayed event "MissileDestroyed".
---@param delay? number Delay in seconds before the function is called.
---@param missile? FOX.MissileData|number|string Data of the destroyed missile.
function FOX:__MissileDestroyed(delay, missile) end

---On after "MissileDestroyed" event user function. Called when a missile was destroyed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param missile? FOX.MissileData|number|string Data of the destroyed missile.
function FOX:OnAfterMissileDestroyed(From, Event, To, missile) end

---Triggers the FSM event "EnterSafeZone".
---@param player? FOX.PlayerData|number|string Player data.
function FOX:EnterSafeZone(player) end

---Triggers the FSM delayed event "EnterSafeZone".
---@param delay? number Delay in seconds before the function is called.
---@param player? FOX.PlayerData|number|string Player data.
function FOX:__EnterSafeZone(delay, player) end

---On after "EnterSafeZone" event user function. Called when a player enters a safe zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? FOX.PlayerData|number|string Player data.
function FOX:OnAfterEnterSafeZone(From, Event, To, player) end

---Triggers the FSM event "ExitSafeZone".
---@param player? FOX.PlayerData|number|string Player data.
function FOX:ExitSafeZone(player) end

---Triggers the FSM delayed event "ExitSafeZone".
---@param delay? number Delay in seconds before the function is called.
---@param player? FOX.PlayerData|number|string Player data.
function FOX:__ExitSafeZone(delay, player) end

---On after "ExitSafeZone" event user function. Called when a player exists a safe zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? FOX.PlayerData|number|string Player data.
function FOX:OnAfterExitSafeZone(From, Event, To, player) end
