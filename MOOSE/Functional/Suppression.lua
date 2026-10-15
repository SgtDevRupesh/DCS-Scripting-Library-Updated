---@meta

---SUPPRESSION class
---@class SUPPRESSION : FSM_CONTROLLABLE
---@field ClassName string Name of the class.
---@field Debug boolean Write Debug messages to DCS log file and send Debug messages to all players.
---@field lid string String for DCS log file.
---@field flare boolean Flare units when they get hit or die.
---@field smoke boolean Smoke places to which the group retreats, falls back or hides.
---@field DCSdesc table Table containing all DCS descriptors of the group.
---@field Type string Type of the group.
---@field SpeedMax number Maximum speed of group in km/h.
---@field IsInfantry boolean True if group has attribute Infantry.
---@field Controllable CONTROLLABLE Controllable of the FSM. Must be a ground group.
---@field Tsuppress_ave number Average time in seconds a group gets suppressed. Actual value is sampled randomly from a Gaussian distribution.
---@field Tsuppress_min number Minimum time in seconds the group gets suppressed.
---@field Tsuppress_max number Maximum time in seconds the group gets suppressed.
---@field TsuppressionOver number Time at which the suppression will be over.
---@field IniGroupStrength number Number of units in a group at start.
---@field Nhit number Number of times the group was hit.
---@field Formation string Formation which will be used when falling back, taking cover or retreating. Default "Vee".
---@field Speed number Speed the unit will use when falling back, taking cover or retreating. Default 999.
---@field MenuON boolean If true creates a entry in the F10 menu.
---@field FallbackON boolean If true, group can fall back, i.e. move away from the attacking unit.
---@field FallbackWait number Time in seconds the unit will wait at the fall back point before it resumes its mission.
---@field FallbackDist number Distance in meters the unit will fall back.
---@field FallbackHeading number Heading in degrees to which the group should fall back. Default is directly away from the attacking unit.
---@field TakecoverON boolean If true, group can hide at a nearby scenery object.
---@field TakecoverWait number Time in seconds the group will hide before it will resume its mission.
---@field TakecoverRange number Range in which the group will search for scenery objects to hide at.
---@field hideout COORDINATE Coordinate/place where the group will try to take cover.
---@field PminFlee number Minimum probability in percent that a group will flee (fall back or take cover) at each hit event. Default is 10 %.
---@field PmaxFlee number Maximum probability in percent that a group will flee (fall back or take cover) at each hit event. Default is 90 %.
---@field RetreatZone ZONE Zone to which a group retreats.
---@field RetreatDamage number Damage in percent at which the group will be ordered to retreat.
---@field RetreatWait number Time in seconds the group will wait in the retreat zone before it resumes its mission. Default two hours.
---@field CurrentAlarmState string Alam state the group is currently in.
---@field CurrentROE string ROE the group currently has.
---@field DefaultAlarmState string Alarm state the group will go to when it is changed back from another state. Default is "Auto".
---@field DefaultROE string ROE the group will get once suppression is over. Default is "Free".
---@field eventmoose boolean If true, events are handled by MOOSE. If false, events are handled directly by DCS eventhandler. Default true.
---@field BattleZone ZONE
---@field AutoEngage boolean
---@field waypoints table Waypoints of the group as defined in the ME.
SUPPRESSION={
  ClassName         = "SUPPRESSION",
  Debug             = false,
  lid               = nil,
  flare             = false,
  smoke             = false,
  DCSdesc           = nil,
  Type              = nil,
  IsInfantry        = nil,
  SpeedMax          = nil,
  Tsuppress_ave     = 15,
  Tsuppress_min     = 5,
  Tsuppress_max     = 25,
  TsuppressOver     = nil,
  IniGroupStrength  = nil,
  Nhit              = 0,
  Formation         = "Off road",
  Speed             = 4,
  MenuON            = false,
  FallbackON        = false,
  FallbackWait      = 60,
  FallbackDist      = 100,
  FallbackHeading   = nil,
  TakecoverON       = false,
  TakecoverWait     = 120,
  TakecoverRange    = 300,
  hideout           = nil,
  PminFlee          = 10,
  PmaxFlee          = 90,
  RetreatZone       = nil,
  RetreatDamage     = nil,
  RetreatWait       = 7200,
  CurrentAlarmState = "unknown",
  CurrentROE        = "unknown",
  DefaultAlarmState = "Auto",
  DefaultROE        = "Weapon Free",
  eventmoose        = true,
  waypoints         = {},
}

---Enumerator of possible rules of engagement.
---@class SUPPRESSION.ROE
---@field Hold string Hold fire.
---@field Free string Weapon fire.
---@field Return string Return fire.
SUPPRESSION.ROE={
  Hold="Weapon Hold",
  Free="Weapon Free",
  Return="Return Fire",  
}

---Enumerator of possible alarm states.
---@class SUPPRESSION.AlarmState
---@field Auto string Automatic.
---@field Green string Green.
---@field Red string Red.
SUPPRESSION.AlarmState={
  Auto="Auto",
  Green="Green",
  Red="Red",
}

---PSEUDOATC version.
SUPPRESSION.version = "0.9.4"

---Creates a new suppression object.
---@param group? GROUP The GROUP object for which suppression should be applied.
---@return SUPPRESSION # self
function SUPPRESSION:New(group) end

---Set average, minimum and maximum time a unit is suppressed each time it gets hit.
---@param Tave? number (Optional) Average time [seconds] a group will be suppressed. Default is 15 seconds.
---@param Tmin? number (Optional) Minimum time [seconds] a group will be suppressed. Default is 5 seconds.
---@param Tmax? number (Optional) Maximum time a group will be suppressed. Default is 25 seconds.
function SUPPRESSION:SetSuppressionTime(Tave, Tmin, Tmax) end

---Set the zone to which a group retreats after being damaged too much.
---@param zone? ZONE MOOSE zone object.
function SUPPRESSION:SetRetreatZone(zone) end

---Turn Debug mode on. Enables messages and more output to DCS log file.
function SUPPRESSION:DebugOn() end

---Flare units when they are hit, die or recover from suppression.
function SUPPRESSION:FlareOn() end

---Smoke positions where units fall back to, hide or retreat.
function SUPPRESSION:SmokeOn() end

---Set the formation a group uses for fall back, hide or retreat.
---@param formation? string (Optional) Formation of the group. Default "Vee".
function SUPPRESSION:SetFormation(formation) end

---Set speed a group moves at for fall back, hide or retreat.
---@param speed? number (Optional) Speed in km/h of group. Default max speed the group can do.
function SUPPRESSION:SetSpeed(speed) end

---Enable fall back if a group is hit.
---@param switch? boolean Enable=true or disable=false fall back of group.
function SUPPRESSION:Fallback(switch) end

---Set distance a group will fall back when it gets hit.
---@param distance? number Distance in meters.
function SUPPRESSION:SetFallbackDistance(distance) end

---Set time a group waits at its fall back position before it resumes its normal mission.
---@param time? number Time in seconds.
function SUPPRESSION:SetFallbackWait(time) end

---Enable take cover option if a unit is hit.
---@param switch? boolean Enable=true or disable=false fall back of group.
function SUPPRESSION:Takecover(switch) end

---Set time a group waits at its hideout position before it resumes its normal mission.
---@param time? number Time in seconds.
function SUPPRESSION:SetTakecoverWait(time) end

---Set distance a group searches for hideout places.
---@param range? number Search range in meters.
function SUPPRESSION:SetTakecoverRange(range) end

---Set hideout place explicitly.
---@param Hideout? COORDINATE Place where the group will hide after the TakeCover event.
function SUPPRESSION:SetTakecoverPlace(Hideout) end

---Set minimum probability that a group flees (falls back or takes cover) after a hit event. Default is 10%.
---@param probability? number Probability in percent.
function SUPPRESSION:SetMinimumFleeProbability(probability) end

---Set maximum probability that a group flees (falls back or takes cover) after a hit event. Default is 90%.
---@param probability? number Probability in percent.
function SUPPRESSION:SetMaximumFleeProbability(probability) end

---Set damage threshold before a group is ordered to retreat if a retreat zone was defined.
---If the group consists of only a singe unit, this referrs to the life of the unit.
---If the group consists of more than one unit, this referrs to the group strength relative to its initial strength.
---@param damage? number (Optional) Damage in percent. If group gets damaged above this value, the group will retreat. Default 50 %.
function SUPPRESSION:SetRetreatDamage(damage) end

---Set time a group waits in the retreat zone before it resumes its mission. Default is two hours.
---@param time? number (Optional) Time in seconds. Default 7200 seconds = 2 hours.
function SUPPRESSION:SetRetreatWait(time) end

---Set alarm state a group will get after it returns from a fall back or take cover.
---@param alarmstate? string (Optional) Alarm state. Possible "Auto", "Green", "Red". Default is "Auto".
function SUPPRESSION:SetDefaultAlarmState(alarmstate) end

---Set Rules of Engagement (ROE) a group will get when it recovers from suppression.
---@param roe? string (Optional) ROE after suppression. Possible "Free", "Hold" or "Return". Default "Free".
function SUPPRESSION:SetDefaultROE(roe) end

---Create an F10 menu entry for the suppressed group. The menu is mainly for Debugging purposes.
---@param switch? boolean (Optional) Enable=true or disable=false menu group. Default is true.
function SUPPRESSION:MenuOn(switch) end

---Create F10 main menu, i.e. F10/Suppression. The menu is mainly for Debugging purposes.
function SUPPRESSION:_CreateMenuGroup() end

---Order group to fall back between 100 and 150 meters in a random direction.
function SUPPRESSION:OrderFallBack() end

---Order group to take cover at a nearby scenery object.
function SUPPRESSION:OrderTakeCover() end

---Order group to retreat to a pre-defined zone.
function SUPPRESSION:OrderRetreat() end

---Status of group. Current ROE, alarm state, life.
---@param message? boolean Send message to all players.
function SUPPRESSION:StatusReport(message) end

---After "Start" event. Initialized ROE and alarm state. Starts the event handler.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterStart(Controllable, From, Event, To) end

---After "Status" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterStatus(Controllable, From, Event, To) end

---After "Hit" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Unit? UNIT Unit that was hit.
---@param AttackUnit? UNIT Unit that attacked.
function SUPPRESSION:onafterHit(Controllable, From, Event, To, Unit, AttackUnit) end

---Before "Recovered" event. Check if suppression time is over.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean
function SUPPRESSION:onbeforeRecovered(Controllable, From, Event, To) end

---After "Recovered" event. Group has recovered and its ROE is set back to the "normal" unsuppressed state. Optionally the group is flared green.
---@param Controllable? CONTROLLABLE of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterRecovered(Controllable, From, Event, To) end

---After "FightBack" event. ROE and Alarm state are set back to default.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterFightBack(Controllable, From, Event, To) end

---Before "FallBack" event. We check that group is not already falling back.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param AttackUnit? UNIT Attacking unit. We will move away from this.
---@return boolean
function SUPPRESSION:onbeforeFallBack(Controllable, From, Event, To, AttackUnit) end

---After "FallBack" event. We get the heading away from the attacker and route the group a certain distance in that direction.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param AttackUnit? UNIT Attacking unit. We will move away from this.
function SUPPRESSION:onafterFallBack(Controllable, From, Event, To, AttackUnit) end

---Before "TakeCover" event. Search an area around the group for possible scenery objects where the group can hide.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Hideout? COORDINATE Place where the group will hide.
---@return boolean
function SUPPRESSION:onbeforeTakeCover(Controllable, From, Event, To, Hideout) end

---After "TakeCover" event. Group will run to a nearby scenery object and "hide" there for a certain time.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Hideout? COORDINATE Place where the group will hide.
function SUPPRESSION:onafterTakeCover(Controllable, From, Event, To, Hideout) end

---After "OutOfAmmo" event. Triggered when group is completely out of ammo.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterOutOfAmmo(Controllable, From, Event, To) end

---Before "Retreat" event. We check that the group is not already retreating.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean # True if transition is allowed, False if transition is forbidden.
function SUPPRESSION:onbeforeRetreat(Controllable, From, Event, To) end

---After "Retreat" event. Find a random point in the retreat zone and route the group there.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterRetreat(Controllable, From, Event, To) end

---Before "Retreateded" event. Check that the group is really in the retreat zone.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onbeforeRetreated(Controllable, From, Event, To) end

---After "Retreateded" event. Group has reached the retreat zone. Set ROE to return fire and alarm state to auto.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterRetreated(Controllable, From, Event, To) end

---After "Dead" event, when a unit has died. When all units of a group are dead, FSM is stopped and eventhandler removed.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterDead(Controllable, From, Event, To) end

---After "Stop" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:onafterStop(Controllable, From, Event, To) end

---Event handler for suppressed groups.
---@param Event? any
function SUPPRESSION:onEvent(Event) end

---Event handler for Dead event of suppressed groups.
---@param EventData? EVENTDATA
function SUPPRESSION:_OnEventHit(EventData) end

---Event handler for Dead event of suppressed groups.
---@param EventData? EVENTDATA
function SUPPRESSION:_OnEventDead(EventData) end

---Suppress fire of a unit by setting its ROE to "Weapon Hold".
function SUPPRESSION:_Suppress() end

---Make group run/drive to a certain point. We put in several intermediate waypoints because sometimes the group stops before it arrived at the desired point.
---@param fin? COORDINATE Coordinate where we want to go.
---@param speed? number (Optional) Speed of group. Default is 20.
---@param formation? string (Optional) Formation of group. Default is "Vee".
---@param wait? number (Optional) Time the group will wait/hold at final waypoint. Default is 30 seconds.
function SUPPRESSION:_Run(fin, speed, formation, wait) end

---Function called when group is passing a waypoint. At the last waypoint we set the group back to CombatReady.
---@param group? GROUP Group which is passing a waypoint.
---@param Fsm? SUPPRESSION The suppression object.
---@param i? number Waypoint number that has been reached.
---@param final? boolean True if it is the final waypoint. Start Fightback.
function SUPPRESSION._Passing_Waypoint(group, Fsm, i, final) end

---Search a place to hide. This is any scenery object in the vicinity.
---@return COORDINATE # Coordinate of the hideout place.
---@return nil # If no scenery object is within search radius.
function SUPPRESSION:_SearchHideout() end

---Get (relative) life in percent of a group. Function returns the value of the units with the smallest and largest life. Also the average value of all groups is returned.
---@return number # Smallest life value of all units.
---@return number # Largest life value of all units.
---@return number # Average life value of all alife groups
---@return number # Average life value of all groups including already dead ones.
---@return number # Relative group strength.
function SUPPRESSION:_GetLife() end

---Heading from point a to point b in degrees.
---@param a? COORDINATE Coordinate.
---@param b? COORDINATE Coordinate.
---@return number # angle Angle from a to b in degrees.
function SUPPRESSION:_Heading(a, b) end

---Generate Gaussian pseudo-random numbers.
---@param x0? number Expectation value of distribution.
---@param sigma? number (Optional) Standard deviation. Default 10.
---@param xmin? number (Optional) Lower cut-off value.
---@param xmax? number (Optional) Upper cut-off value.
---@return number # Gaussian random number.
function SUPPRESSION:_Random_Gaussian(x0, sigma, xmin, xmax) end

---Sets the ROE for the group and updates the current ROE variable.
---@param roe? string (Optional) ROE the group will get. Possible "Free", "Hold", "Return". Default is self.DefaultROE.
function SUPPRESSION:_SetROE(roe) end

---Sets the alarm state of the group and updates the current alarm state variable.
---@param state? string (Optional) Alarm state the group will get. Possible "Auto", "Green", "Red". Default is self.DefaultAlarmState.
function SUPPRESSION:_SetAlarmState(state) end

---Print event-from-to string to DCS log file.
---@param BA? string Before/after info.
---@param Event? string Event.
---@param From? string From state.
---@param To? string To state.
function SUPPRESSION:_EventFromTo(BA, Event, From, To) end

---Trigger "Status" event.
function SUPPRESSION:Status() end

---Trigger "Status" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:__Status(Delay) end

---User function for OnAfter "Status" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterStatus(Controllable, From, Event, To) end

---Trigger "Hit" event.
---@param Unit? UNIT Unit that was hit.
---@param AttackUnit? UNIT Unit that attacked.
function SUPPRESSION:Hit(Unit, AttackUnit) end

---Trigger "Hit" event after a delay.
---@param Delay? number Delay in seconds.
---@param Unit? UNIT Unit that was hit.
---@param AttackUnit? UNIT Unit that attacked.
function SUPPRESSION:__Hit(Delay, Unit, AttackUnit) end

---User function for OnBefore "Hit" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Unit? UNIT Unit that was hit.
---@param AttackUnit? UNIT Unit that attacked.
---@return boolean
function SUPPRESSION:OnBeforeHit(Controllable, From, Event, To, Unit, AttackUnit) end

---User function for OnAfter "Hit" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Unit? UNIT Unit that was hit.
---@param AttackUnit? UNIT Unit that attacked.
function SUPPRESSION:OnAfterHit(Controllable, From, Event, To, Unit, AttackUnit) end

---Trigger "Recovered" event.
function SUPPRESSION:Recovered() end

---Trigger "Recovered" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:Recovered(Delay) end

---User function for OnBefore "Recovered" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean
function SUPPRESSION:OnBeforeRecovered(Controllable, From, Event, To) end

---User function for OnAfter "Recovered" event.
---@param Controllable? CONTROLLABLE of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterRecovered(Controllable, From, Event, To) end

---Trigger "TakeCover" event.
---@param Hideout? COORDINATE Place where the group will hide.
function SUPPRESSION:TakeCover(Hideout) end

---Trigger "TakeCover" event after a delay.
---@param Delay? number Delay in seconds.
---@param Hideout? COORDINATE Place where the group will hide.
function SUPPRESSION:__TakeCover(Delay, Hideout) end

---User function for OnBefore "TakeCover" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Hideout? COORDINATE Place where the group will hide.
---@return boolean
function SUPPRESSION:OnBeforeTakeCover(Controllable, From, Event, To, Hideout) end

---User function for OnAfter "TakeCover" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Hideout? COORDINATE Place where the group will hide.
function SUPPRESSION:OnAfterTakeCover(Controllable, From, Event, To, Hideout) end

---Trigger "FallBack" event.
---@param AttackUnit? UNIT Attacking unit. We will move away from this.
function SUPPRESSION:FallBack(AttackUnit) end

---Trigger "FallBack" event after a delay.
---@param Delay? number Delay in seconds.
---@param AttackUnit? UNIT Attacking unit. We will move away from this.
function SUPPRESSION:__FallBack(Delay, AttackUnit) end

---User function for OnBefore "FallBack" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param AttackUnit? UNIT Attacking unit. We will move away from this.
---@return boolean
function SUPPRESSION:OnBeforeFallBack(Controllable, From, Event, To, AttackUnit) end

---User function for OnAfter "FallBack" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param AttackUnit? UNIT Attacking unit. We will move away from this.
function SUPPRESSION:OnAfterFallBack(Controllable, From, Event, To, AttackUnit) end

---Trigger "Retreat" event.
function SUPPRESSION:Retreat() end

---Trigger "Retreat" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:__Retreat(Delay) end

---User function for OnBefore "Retreat" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean
function SUPPRESSION:OnBeforeRetreat(Controllable, From, Event, To) end

---User function for OnAfter "Retreat" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterRetreat(Controllable, From, Event, To) end

---Trigger "Retreated" event.
function SUPPRESSION:Retreated() end

---Trigger "Retreated" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:__Retreated(Delay) end

---User function for OnBefore "Retreated" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean
function SUPPRESSION:OnBeforeRetreated(Controllable, From, Event, To) end

---User function for OnAfter "Retreated" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterRetreated(Controllable, From, Event, To) end

---Trigger "FightBack" event.
function SUPPRESSION:FightBack() end

---Trigger "FightBack" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:__FightBack(Delay) end

---User function for OnBefore "FlightBack" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return boolean
function SUPPRESSION:OnBeforeFightBack(Controllable, From, Event, To) end

---User function for OnAfter "FlightBack" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterFightBack(Controllable, From, Event, To) end

---Trigger "OutOfAmmo" event.
function SUPPRESSION:OutOfAmmo() end

---Trigger "OutOfAmmo" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:__OutOfAmmo(Delay) end

---User function for OnAfter "OutOfAmmo" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterOutOfAmmo(Controllable, From, Event, To) end

---Trigger "Dead" event.
function SUPPRESSION:Dead() end

---Trigger "Dead" event after a delay.
---@param Delay? number Delay in seconds.
function SUPPRESSION:__Dead(Delay) end

---User function for OnAfter "Dead" event.
---@param Controllable? CONTROLLABLE Controllable of the group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SUPPRESSION:OnAfterDead(Controllable, From, Event, To) end
