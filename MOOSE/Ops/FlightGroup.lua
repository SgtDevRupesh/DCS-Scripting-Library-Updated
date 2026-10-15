---@meta

---@class FLIGHTGROUP.PlayerData
---@field name string Player name.
---@field subtitles boolean Display subtitles.
---@field skill string Skill level.

---@class FLIGHTGROUP.RadioText
---@field normal string
---@field enhanced string

---FLIGHTGROUP class.
---@class FLIGHTGROUP : OPSGROUP
---@field actype string Type name of the aircraft.
---@field rangemax number Max range in meters.
---@field ceiling number Max altitude the aircraft can fly at in meters.
---@field tankertype number The refueling system type (0=boom, 1=probe), if the group is a tanker.
---@field refueltype number The refueling system type (0=boom, 1=probe), if the group can refuel from a tanker.
---@field ammo OPSGROUP.Ammo Ammunition data. Number of Guns, Rockets, Bombs, Missiles.
---@field ai boolean If true, flight is purely AI. If false, flight contains at least one human player.
---@field fuellow boolean Fuel low switch.
---@field fuellowthresh number Low fuel threshold in percent.
---@field fuellowrtb boolean RTB on low fuel switch.
---@field fuelcritical boolean Fuel critical switch.
---@field fuelcriticalthresh number Critical fuel threshold in percent.
---@field fuelcriticalrtb boolean RTB on critical fuel switch.
---@field flightcontrol FLIGHTCONTROL The flightcontrol handling this group.
---@field airboss AIRBOSS The airboss handling this group.
---@field flaghold USERFLAG Flag for holding.
---@field Tholding number Abs. mission time stamp when the group reached the holding point.
---@field Tparking number Abs. mission time stamp when the group was spawned uncontrolled and is parking.
---@field menu table F10 radio menu.
---@field controlstatus string Flight control status.
---@field despawnAfterLanding boolean If `true`, group is despawned after landed at an airbase.
---@field despawnAfterHolding boolean If `true`, group is despawned after reaching the holding point.
---@field RTBRecallCount number Number that counts RTB calls.
---@field stack FLIGHTCONTROL.HoldingStack Holding stack.
---@field isReadyTO boolean Flight is ready for takeoff. This is for FLIGHTCONTROL.
---@field prohibitAB boolean Disallow (true) or allow (false) AI to use the afterburner.
---@field jettisonEmptyTanks boolean Allow (true) or disallow (false) AI to jettison empty fuel tanks.
---@field jettisonWeapons boolean Allow (true) or disallow (false) AI to jettison weapons if in danger.
---@field holdtime number Time [s] flight is holding before going on final. Set to nil for indefinitely.
FLIGHTGROUP = {
  ClassName          = "FLIGHTGROUP",
  homebase           =   nil,
  destbase           =   nil,
  homezone           =   nil,
  destzone           =   nil,
  actype             =   nil,
  speedMax           =   nil,
  rangemax           =   nil,
  ceiling            =   nil,
  fuellow            = false,
  fuellowthresh      =   nil,
  fuellowrtb         =   nil,
  fuelcritical       =   nil,
  fuelcriticalthresh =   nil,
  fuelcriticalrtb    = false,
  outofAAMrtb        = false,
  outofAGMrtb        = false,
  flightcontrol      =   nil,
  flaghold           =   nil,
  Tholding           =   nil,
  Tparking           =   nil,
  Twaiting           =   nil,
  menu               =   nil,
  isHelo             =   nil,
  RTBRecallCount     =     0,
  playerSettings     =    {},
  playerWarnings     =    {},
  prohibitAB         =   false,
  jettisonEmptyTanks =   true,
  jettisonWeapons    =   true, -- that's actually a negative option like prohibitAB  
}

---Generalized attribute. See [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes) on hoggit.
---@class FLIGHTGROUP.Attribute
---@field TRANSPORTPLANE string Airplane with transport capability. This can be used to transport other assets.
---@field AWACS string Airborne Early Warning and Control System.
---@field FIGHTER string Fighter, interceptor, ... airplane.
---@field BOMBER string Aircraft which can be used for strategic bombing.
---@field TANKER string Airplane which can refuel other aircraft.
---@field TRANSPORTHELO string Helicopter with transport capability. This can be used to transport other assets.
---@field ATTACKHELO string Attack helicopter.
---@field UAV string Unpiloted Aerial Vehicle, e.g. drones.
---@field OTHER string Other aircraft type.
FLIGHTGROUP.Attribute = {
  TRANSPORTPLANE="TransportPlane",
  AWACS="AWACS",
  FIGHTER="Fighter",
  BOMBER="Bomber",
  TANKER="Tanker",
  TRANSPORTHELO="TransportHelo",
  ATTACKHELO="AttackHelo",
  UAV="UAV",
  OTHER="Other",
}

---Radio messages.
---@class FLIGHTGROUP.RadioMessage
---@field AIRBORNE FLIGHTGROUP.RadioText
---@field TAXIING FLIGHTGROUP.RadioText
FLIGHTGROUP.RadioMessage = {
  AIRBORNE={normal="Airborn", enhanced="Airborn"},
  TAXIING={normal="Taxiing", enhanced="Taxiing"},
}

---Skill level.
---@class FLIGHTGROUP.PlayerSkill
---@field STUDENT string Flight Student. Shows tips and hints in important phases of the approach.
---@field AVIATOR string Naval aviator. Moderate number of hints but not really zip lip.
---@field GRADUATE string TOPGUN graduate. For people who know what they are doing. Nearly *ziplip*.
---@field INSTRUCTOR string TOPGUN instructor. For people who know what they are doing. Nearly *ziplip*.
FLIGHTGROUP.PlayerSkill = {
  STUDENT    = "Student",
  AVIATOR    = "Aviator",
  GRADUATE   = "Graduate",
  INSTRUCTOR = "Instructor",
}

---FLIGHTGROUP players.
FLIGHTGROUP.Players={}

---FLIGHTGROUP class version.
FLIGHTGROUP.version = "1.0.4"

---Create a new FLIGHTGROUP object and start the FSM.
---@param group? GROUP The group object. Can also be given by its group name as `#string`.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:New(group) end

---Add an *enroute* task to attack targets in a certain **circular** zone.
---@param ZoneRadius? ZONE_RADIUS The circular zone, where to engage targets.
---@param TargetTypes? table (Optional) The target types, passed as a table, i.e. mind the curly brackets {}. Default {"Air"}.
---@param Priority? number (Optional) Priority. Default 0.
function FLIGHTGROUP:AddTaskEnrouteEngageTargetsInZone(ZoneRadius, TargetTypes, Priority) end

---Get airwing the flight group belongs to.
---@return AIRWING # The AIRWING object (if any).
function FLIGHTGROUP:GetAirwing() end

---Get name of airwing the flight group belongs to.
---@return string # Name of the airwing or "None" if the flightgroup does not belong to any airwing.
function FLIGHTGROUP:GetAirwingName() end

---Get squadron the flight group belongs to.
---@return SQUADRON # The SQUADRON of this flightgroup or #nil if the flightgroup does not belong to any squadron.
function FLIGHTGROUP:GetSquadron() end

---Get squadron name the flight group belongs to.
---@return string # The squadron name or "None" if the flightgroup does not belon to any squadron.
function FLIGHTGROUP:GetSquadronName() end

---Set if aircraft is VTOL capable. Unfortunately, there is no DCS way to determine this via scripting.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetVTOL() end

---Set if aircraft is **not** allowed to use afterburner.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetProhibitAfterburner() end

---Set if aircraft is allowed to use afterburner.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetAllowAfterburner() end

---Set if aircraft is allowed to drop empty fuel tanks - set to true to allow, and false to forbid it.
---@param Switch? boolean true or false
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetJettisonEmptyTanks(Switch) end

---Set if aircraft is allowed to drop weapons to escape danger - set to true to allow, and false to forbid it.
---@param Switch? boolean true or false
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetJettisonWeapons(Switch) end

---Set the aircraft to land straight in.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOptionLandingStraightIn() end

---Set the aircraft to land in pairs.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOptionLandingForcePair() end

---Set the aircraft to NOT land in pairs.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOptionLandingRestrictPair() end

---Set the aircraft to land after overhead break.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOptionLandingOverheadBreak() end

---[HELICOPTER] Set the aircraft to prefer takeoff and landing vertically.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOptionPreferVertical() end

---Set if group is ready for taxi/takeoff if controlled by a `FLIGHTCONTROL`.
---@param ReadyTO? boolean If `true`, flight is ready for takeoff.
---@param Delay? number (Optional) Delay in seconds before value is set. Default 0 sec.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetReadyForTakeoff(ReadyTO, Delay) end

---Set the FLIGHTCONTROL controlling this flight group.
---@param flightcontrol? FLIGHTCONTROL The FLIGHTCONTROL object.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetFlightControl(flightcontrol) end

---Get the FLIGHTCONTROL controlling this flight group.
---@return FLIGHTCONTROL # The FLIGHTCONTROL object.
function FLIGHTGROUP:GetFlightControl() end

---Set the homebase.
---@param HomeAirbase? AIRBASE The home airbase.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetHomebase(HomeAirbase) end

---Set the destination airbase. This is where the flight will go, when the final waypoint is reached.
---@param DestinationAirbase? AIRBASE The destination airbase.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetDestinationbase(DestinationAirbase) end

---Set the AIRBOSS controlling this flight group.
---@param airboss? AIRBOSS The AIRBOSS object.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetAirboss(airboss) end

---Set low fuel threshold. Triggers event "FuelLow" and calls event function "OnAfterFuelLow".
---@param threshold? number (Optional) Fuel threshold in percent. Default 25 %.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetFuelLowThreshold(threshold) end

---Set if low fuel threshold is reached, flight goes RTB.
---@param switch? boolean If true or nil, flight goes RTB. If false, turn this off.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetFuelLowRTB(switch) end

---Set if flight is out of Air-Air-Missiles, flight goes RTB.
---@param switch? boolean If true or nil, flight goes RTB. If false, turn this off.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOutOfAAMRTB(switch) end

---Set if flight is out of Air-Ground-Missiles, flight goes RTB.
---@param switch? boolean If true or nil, flight goes RTB. If false, turn this off.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetOutOfAGMRTB(switch) end

---Set if low fuel threshold is reached, flight tries to refuel at the neares tanker.
---@param switch? boolean If true or nil, flight goes for refuelling. If false, turn this off.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetFuelLowRefuel(switch) end

---Set fuel critical threshold. Triggers event "FuelCritical" and event function "OnAfterFuelCritical".
---@param threshold? number (Optional) Fuel threshold in percent. Default 10 %.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetFuelCriticalThreshold(threshold) end

---Set if critical fuel threshold is reached, flight goes RTB.
---@param switch? boolean If true or nil, flight goes RTB. If false, turn this off.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetFuelCriticalRTB(switch) end

---Enable that the group is despawned after landing. This can be useful to avoid DCS taxi issues with other AI or players or jamming taxiways.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetDespawnAfterLanding() end

---Enable that the group is despawned after holding. This can be useful to avoid DCS taxi issues with other AI or players or jamming taxiways.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:SetDespawnAfterHolding() end

---Check if flight is parking.
---@param Element? OPSGROUP.Element|number|string (Optional) Only check status for given element.
---@return boolean # If true, flight is parking after spawned.
function FLIGHTGROUP:IsParking(Element) end

---Check if is taxiing to the runway.
---@param Element? OPSGROUP.Element|number|string (Optional) Only check status for given element.
---@return boolean # If true, flight is taxiing after engine start up.
function FLIGHTGROUP:IsTaxiing(Element) end

---Check if flight is airborne or cruising.
---@param Element? OPSGROUP.Element|number|string (Optional) Only check status for given element.
---@return boolean # If true, flight is airborne.
function FLIGHTGROUP:IsAirborne(Element) end

---Check if flight is airborne or cruising.
---@return boolean # If true, flight is airborne.
function FLIGHTGROUP:IsCruising() end

---Check if flight is landing.
---@param Element? OPSGROUP.Element|number|string (Optional) Only check status for given element.
---@return boolean # If true, flight is landing, i.e. on final approach.
function FLIGHTGROUP:IsLanding(Element) end

---Check if flight has landed and is now taxiing to its parking spot.
---@param Element? OPSGROUP.Element|number|string (Optional) Only check status for given element.
---@return boolean # If true, flight has landed
function FLIGHTGROUP:IsLanded(Element) end

---Check if flight has arrived at its destination parking spot.
---@param Element? OPSGROUP.Element|number|string (Optional) Only check status for given element.
---@return boolean # If true, flight has arrived at its destination and is parking.
function FLIGHTGROUP:IsArrived(Element) end

---Check if flight is inbound and traveling to holding pattern.
---@return boolean # If true, flight is holding.
function FLIGHTGROUP:IsInbound() end

---Check if flight is holding and waiting for landing clearance.
---@return boolean # If true, flight is holding.
function FLIGHTGROUP:IsHolding() end

---Check if flight is going for fuel.
---@return boolean # If true, flight is refueling.
function FLIGHTGROUP:IsGoing4Fuel() end

---Check if helo(!) flight is ordered to land at a specific point.
---@return boolean # If true, group has task to land somewhere.
function FLIGHTGROUP:IsLandingAt() end

---Check if helo(!) flight has landed at a specific point.
---@return boolean # If true, has landed somewhere.
function FLIGHTGROUP:IsLandedAt() end

---Check if flight is low on fuel.
---@return boolean # If true, flight is low on fuel.
function FLIGHTGROUP:IsFuelLow() end

---Check if flight is critical on fuel.
---@return boolean # If true, flight is critical on fuel.
function FLIGHTGROUP:IsFuelCritical() end

---Check if flight is good on fuel (not below low or even critical state).
---@return boolean # If true, flight is good on fuel.
function FLIGHTGROUP:IsFuelGood() end

---Check if flight can do air-to-ground tasks.
---@param ExcludeGuns? boolean If true, exclude gun
---@return boolean # *true* if has air-to-ground weapons.
function FLIGHTGROUP:CanAirToGround(ExcludeGuns) end

---Check if flight can do air-to-air attacks.
---@param ExcludeGuns? boolean If true, exclude available gun shells.
---@return boolean # *true* if has air-to-ground weapons.
function FLIGHTGROUP:CanAirToAir(ExcludeGuns) end

---Start an *uncontrolled* group.
---@param delay? number (Optional) Delay in seconds before the group is started. Default is immediately.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:StartUncontrolled(delay) end

---Clear the group for landing when it is holding.
---@param Delay? number Delay in seconds before landing clearance is given.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:ClearToLand(Delay) end

---Get min fuel of group. This returns the relative fuel amount of the element lowest fuel in the group.
---@return number # Relative fuel in percent.
function FLIGHTGROUP:GetFuelMin() end

---Get number of kills of this group.
---@return number # Number of units killed.
function FLIGHTGROUP:GetKills() end

---Status update.
function FLIGHTGROUP:Status() end

---Flightgroup event function handling the crash of a unit.
---@param EventData? EVENTDATA Event data.
function FLIGHTGROUP:OnEventEngineStartup(EventData) end

---Flightgroup event function handling the crash of a unit.
---@param EventData? EVENTDATA Event data.
function FLIGHTGROUP:OnEventTakeOff(EventData) end

---Flightgroup event function handling the crash of a unit.
---@param EventData? EVENTDATA Event data.
function FLIGHTGROUP:OnEventLanding(EventData) end

---Flightgroup event function handling the crash of a unit.
---@param EventData? EVENTDATA Event data.
function FLIGHTGROUP:OnEventEngineShutdown(EventData) end

---Flightgroup event function handling the crash of a unit.
---@param EventData? EVENTDATA Event data.
function FLIGHTGROUP:OnEventCrash(EventData) end

---Flightgroup event function handling the crash of a unit.
---@param EventData? EVENTDATA Event data.
function FLIGHTGROUP:OnEventUnitLost(EventData) end

---On after "ElementSpawned" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:onafterElementSpawned(From, Event, To, Element) end

---On after "ElementParking" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param Spot? AIRBASE.ParkingSpot|number|string Parking Spot.
function FLIGHTGROUP:onafterElementParking(From, Event, To, Element, Spot) end

---On after "ElementEngineOn" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:onafterElementEngineOn(From, Event, To, Element) end

---On after "ElementTaxiing" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:onafterElementTaxiing(From, Event, To, Element) end

---On after "ElementTakeoff" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param airbase? AIRBASE The airbase if applicable or nil.
function FLIGHTGROUP:onafterElementTakeoff(From, Event, To, Element, airbase) end

---On after "ElementAirborne" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:onafterElementAirborne(From, Event, To, Element) end

---On after "ElementLanded" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param airbase? AIRBASE The airbase if applicable or nil.
function FLIGHTGROUP:onafterElementLanded(From, Event, To, Element, airbase) end

---On after "ElementArrived" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param airbase? AIRBASE The airbase, where the element arrived.
---@param Parking? AIRBASE.ParkingSpot|number|string The Parking spot the element has.
function FLIGHTGROUP:onafterElementArrived(From, Event, To, Element, airbase, Parking) end

---On after "ElementDestroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:onafterElementDestroyed(From, Event, To, Element) end

---On after "ElementDead" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:onafterElementDead(From, Event, To, Element) end

---On after "Spawned" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterSpawned(From, Event, To) end

---On after "Parking" event. Add flight to flightcontrol of airbase.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterParking(From, Event, To) end

---On after "Taxiing" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterTaxiing(From, Event, To) end

---On after "Takeoff" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase the flight landed.
function FLIGHTGROUP:onafterTakeoff(From, Event, To, airbase) end

---On after "Airborne" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterAirborne(From, Event, To) end

---On after "Cruising" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterCruise(From, Event, To) end

---On after "Landing" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterLanding(From, Event, To) end

---On after "Landed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase the flight landed.
function FLIGHTGROUP:onafterLanded(From, Event, To, airbase) end

---On after "LandedAt" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterLandedAt(From, Event, To) end

---On after "Arrived" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterArrived(From, Event, To) end

---On after "Dead" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterDead(From, Event, To) end

---On before "UpdateRoute" event. Update route of group, e.g after new waypoints and/or waypoint tasks have been added.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param n? number (Optional) Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N? number (Optional)  Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
---@return boolean # Transision allowed?
function FLIGHTGROUP:onbeforeUpdateRoute(From, Event, To, n, N) end

---On after "UpdateRoute" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param n? number (Optional) Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N? number (Optional) Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
function FLIGHTGROUP:onafterUpdateRoute(From, Event, To, n, N) end

---On after "OutOfMissilesAA" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterOutOfMissilesAA(From, Event, To) end

---On after "OutOfMissilesAG" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterOutOfMissilesAG(From, Event, To) end

---Check if flight is done, i.e.
---
--- * passed the final waypoint,
--- * no current task
--- * no current mission
--- * number of remaining tasks is zero
--- * number of remaining missions is zero
---@param delay? number Delay in seconds.
---@param waittime? number Time to wait if group is done.
function FLIGHTGROUP:_CheckGroupDone(delay, waittime) end

---On before "RTB" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
---@param SpeedTo? number Speed used for travelling from current position to holding point in knots.
---@param SpeedHold? number Holding speed in knots.
function FLIGHTGROUP:onbeforeRTB(From, Event, To, airbase, SpeedTo, SpeedHold) end

---On after "RTB" event. Order flight to hold at an airbase and wait for signal to land.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
---@param SpeedTo? number (Optional) Speed used for traveling from current position to holding point in knots. Default 75% of max speed.
---@param SpeedHold? number (Optional) Holding speed in knots. Default 250 kts.
---@param SpeedLand? number (Optional) Landing speed in knots. Default 170 kts.
function FLIGHTGROUP:onafterRTB(From, Event, To, airbase, SpeedTo, SpeedHold, SpeedLand) end

---On before "LandAtAirbase" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
function FLIGHTGROUP:onbeforeLandAtAirbase(From, Event, To, airbase) end

---On after "LandAtAirbase" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
function FLIGHTGROUP:onafterLandAtAirbase(From, Event, To, airbase) end

---Land at an airbase.
---@param airbase? AIRBASE Airbase where the group shall land.
---@param SpeedTo? any
---@param SpeedHold? any
---@param SpeedLand? any
function FLIGHTGROUP:_LandAtAirbase(airbase, SpeedTo, SpeedHold, SpeedLand) end

---On before "Wait" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Duration? number (Optional) Duration how long the group will be waiting in seconds. Default `nil` (=forever).
---@param Altitude? number (Optional) Altitude in feet. Default 10,000 ft for airplanes and 1,000 feet for helos.
---@param Speed? number (Optional) Speed in knots. Default 250 kts for airplanes and 20 kts for helos.
function FLIGHTGROUP:onbeforeWait(From, Event, To, Duration, Altitude, Speed) end

---On after "Wait" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Duration? number (Optional) Duration how long the group will be waiting in seconds. Default `nil` (=forever).
---@param Altitude? number (Optional) Altitude in feet. Default 10,000 ft for airplanes and 1,000 feet for helos.
---@param Speed? number (Optional) Speed in knots. Default 250 kts for airplanes and 20 kts for helos.
function FLIGHTGROUP:onafterWait(From, Event, To, Duration, Altitude, Speed) end

---On after "Refuel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? COORDINATE The coordinate.
function FLIGHTGROUP:onafterRefuel(From, Event, To, Coordinate) end

---On after "Refueled" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterRefueled(From, Event, To) end

---On after "Holding" event. Flight arrived at the holding point.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterHolding(From, Event, To) end

---On after "EngageTarget" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? table Target object. Can be a UNIT, STATIC, GROUP, SET_UNIT or SET_GROUP object.
function FLIGHTGROUP:onafterEngageTarget(From, Event, To, Target) end

---On after "Disengage" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterDisengage(From, Event, To) end

---On before "LandAt" event. Check we have a helo group.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? any
---@param Duration? number (Optional) The duration in seconds to remain on ground. Default 600 sec (10 min).
function FLIGHTGROUP:onbeforeLandAt(From, Event, To, Coordinate, Duration) end

---On after "LandAt" event. Order helicopter to land at a specific point.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? any
---@param Duration? number (Optional) The duration in seconds to remain on ground. Default `nil` = forever.
function FLIGHTGROUP:onafterLandAt(From, Event, To, Coordinate, Duration) end

---On after "FuelLow" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterFuelLow(From, Event, To) end

---On after "FuelCritical" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:onafterFuelCritical(From, Event, To) end

---Function called when flight has reached the holding point.
---@param group? GROUP Group object.
---@param flightgroup? FLIGHTGROUP Flight group object.
function FLIGHTGROUP._ReachedHolding(group, flightgroup) end

---Function called when flight has reached the holding point.
---@param group? GROUP Group object.
---@param flightgroup? FLIGHTGROUP Flight group object.
function FLIGHTGROUP._ClearedToLand(group, flightgroup) end

---Function called when flight is on final.
---@param group? GROUP Group object.
---@param flightgroup? FLIGHTGROUP Flight group object.
function FLIGHTGROUP._OnFinal(group, flightgroup) end

---Function called when flight finished refuelling.
---@param group? GROUP Group object.
---@param flightgroup? FLIGHTGROUP Flight group object.
function FLIGHTGROUP._FinishedRefuelling(group, flightgroup) end

---Function called when flight finished waiting.
---@param group? GROUP Group object.
---@param flightgroup? FLIGHTGROUP Flight group object.
function FLIGHTGROUP._FinishedWaiting(group, flightgroup) end

---Initialize group parameters. Also initializes waypoints if self.waypoints is nil.
---@param Template? table (Optional) Template used to init the group. Default is `self.template`.
---@param Delay? number (Optional) Delay in seconds before group is initialized. Default `nil`, *i.e.* instantaneous.
---@return FLIGHTGROUP # self
function FLIGHTGROUP:_InitGroup(Template, Delay) end

---Check if a unit is and element of the flightgroup.
---@return AIRBASE # Final destination airbase or #nil.
function FLIGHTGROUP:GetHomebaseFromWaypoints() end

---Find the nearest friendly airbase (same or neutral coalition).
---@param Radius? number (Optional) Search radius in NM. Default 50 NM.
---@return AIRBASE # Closest tanker group #nil.
function FLIGHTGROUP:FindNearestAirbase(Radius) end

---Find the nearest tanker.
---@param Radius? number (Optional) Search radius in NM. Default 50 NM.
---@return GROUP # Closest tanker group or `nil` if no tanker is in the given radius.
function FLIGHTGROUP:FindNearestTanker(Radius) end

---Check if a unit is and element of the flightgroup.
---@return AIRBASE # Final destination airbase or #nil.
function FLIGHTGROUP:GetDestinationFromWaypoints() end

---Check if this is a hot start.
---@return boolean # Hot start?
function FLIGHTGROUP:IsTakeoffHot() end

---Check if this is a cold start.
---@return boolean # Cold start, i.e. engines off when spawned?
function FLIGHTGROUP:IsTakeoffCold() end

---Check if this is a runway start.
---@return boolean # Runway start?
function FLIGHTGROUP:IsTakeoffRunway() end

---Check if this is an air start.
---@return boolean # Air start?
function FLIGHTGROUP:IsTakeoffAir() end

---Check if the final waypoint is in the air.
---@param wp? table (Optional) Waypoint. Default final waypoint.
---@return boolean # If `true` final waypoint is a turning or flyover but not a landing type waypoint.
function FLIGHTGROUP:IsLandingAir(wp) end

---Check if the final waypoint is at an airbase.
---@param wp? table (Optional) Waypoint. Default final waypoint.
---@return boolean # If `true`, final waypoint is a landing waypoint at an airbase.
function FLIGHTGROUP:IsLandingAirbase(wp) end

---Add an AIR waypoint to the flight plan.
---@param Coordinate? COORDINATE The coordinate of the waypoint. Use COORDINATE:SetAltitude(altitude) to define the altitude.
---@param Speed? number (Optional) Speed in knots. Default is cruise speed.
---@param AfterWaypointWithID? number (Optional) Insert waypoint after waypoint given ID. Default is to insert as last waypoint.
---@param Altitude? number (Optional) Altitude in feet. Default is y-component of Coordinate. Note that these altitudes are wrt to sea level (barometric altitude).
---@param Updateroute? boolean (Optional) If true or nil, call UpdateRoute. If false, no call.
---@return OPSGROUP.Waypoint # Waypoint table.
function FLIGHTGROUP:AddWaypoint(Coordinate, Speed, AfterWaypointWithID, Altitude, Updateroute) end

---Add an LANDING waypoint to the flight plan.
---@param Airbase? AIRBASE The airbase where the group should land.
---@param Speed? number (Optional) Speed in knots. Default 350 kts.
---@param AfterWaypointWithID? number (Optional) Insert waypoint after waypoint given ID. Default is to insert as last waypoint.
---@param Altitude? number (Optional) Altitude in feet. Default is y-component of Coordinate. Note that these altitudes are wrt to sea level (barometric altitude).
---@param Updateroute? boolean (Optional) If true or nil, call UpdateRoute. If false, no call.
---@return OPSGROUP.Waypoint # Waypoint table.
function FLIGHTGROUP:AddWaypointLanding(Airbase, Speed, AfterWaypointWithID, Altitude, Updateroute) end

---Get player element.
---@return OPSGROUP.Element # The element.
function FLIGHTGROUP:GetPlayerElement() end

---Get player element.
---@return string # Player name or `nil`.
function FLIGHTGROUP:GetPlayerName() end

---Set parking spot of element.
---@param Element? OPSGROUP.Element|number|string The element.
---@param Spot? AIRBASE.ParkingSpot|number|string Parking Spot.
function FLIGHTGROUP:_SetElementParkingAt(Element, Spot) end

---Set parking spot of element to free
---@param Element? OPSGROUP.Element|number|string The element.
function FLIGHTGROUP:_SetElementParkingFree(Element) end

---Get onboard number.
---@param unitname? string Name of the unit.
---@return string # Modex.
function FLIGHTGROUP:_GetOnboardNumber(unitname) end

---Checks if a human player sits in the unit.
---@param unit? UNIT Aircraft unit.
---@return boolean # If true, human player inside the unit.
function FLIGHTGROUP:_IsHumanUnit(unit) end

---Checks if a group has a human player.
---@param group? GROUP Aircraft group.
---@return boolean # If true, human player inside group.
function FLIGHTGROUP:_IsHuman(group) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param _unitName? string Name of the player unit.
---@return UNIT # Unit of player or nil.
---@return string # Name of the player or nil.
function FLIGHTGROUP:_GetPlayerUnitAndName(_unitName) end

---Returns the parking spot of the element.
---@param element? OPSGROUP.Element|number|string Element of the flight group.
---@param maxdist? number (Optional) Distance threshold in meters. Default 5 m.
---@param airbase? AIRBASE (Optional) The airbase to check for parking. Default is closest airbase to the element.
---@return AIRBASE.ParkingSpot # Parking spot or nil if no spot is within distance threshold.
function FLIGHTGROUP:GetParkingSpot(element, maxdist, airbase) end

---Get holding time.
---@return number # Holding time in seconds or -1 if flight is not holding.
function FLIGHTGROUP:GetHoldingTime() end

---Get parking time.
---@return number # Holding time in seconds or -1 if flight is not holding.
function FLIGHTGROUP:GetParkingTime() end

---Search unoccupied parking spots at the airbase for all flight elements.
---@return AIRBASE # Closest airbase
function FLIGHTGROUP:GetClosestAirbase() end

---Search unoccupied parking spots at the airbase for all flight elements.
---@param airbase? AIRBASE The airbase where we search for parking spots.
---@return table # Table of coordinates and terminal IDs of free parking spots.
function FLIGHTGROUP:GetParking(airbase) end

---Size of the bounding box of a DCS object derived from the DCS descriptor table. If boundinb box is nil, a size of zero is returned.
---@param DCSobject? Object The DCS object for which the size is needed.
---@return number # Max size of object in meters (length (x) or width (z) components not including height (y)).
---@return number # Length (x component) of size.
---@return number # Height (y component) of size.
---@return number # Width (z component) of size.
function FLIGHTGROUP:_GetObjectSize(DCSobject) end

---Get the generalized attribute of a group.
---@return string # Generalized attribute of the group.
function FLIGHTGROUP:_GetAttribute() end

---Get the proper terminal type based on generalized attribute of the group.
---@param _attribute? FLIGHTGROUP.Attribute|number|string Generlized attibute of unit.
---@param _category? number Airbase category.
---@return AIRBASE.TerminalType # Terminal type for this group.
function FLIGHTGROUP:_GetTerminal(_attribute, _category) end

---Check if group got stuck. This overwrites the OPSGROUP function.
---Here we only check if stuck whilst taxiing.
---@param Despawn? boolean If `true`, despawn group if stuck.
---@return number # Time in seconds the group got stuck or nil if not stuck.
function FLIGHTGROUP:_CheckStuck(Despawn) end

---Update menu.
---@param delay? number Delay in seconds.
function FLIGHTGROUP:_UpdateMenu(delay) end

---Create player menu.
---@param rootmenu? table ATC root menu table.
function FLIGHTGROUP:_CreateMenuAtcHelp(rootmenu) end

---Player menu not implemented.
---@param groupname? string Name of the flight group.
function FLIGHTGROUP:_MenuNotImplemented(groupname) end

---Player status.
function FLIGHTGROUP:_PlayerMyStatus() end

---Player set subtitles.
function FLIGHTGROUP:_PlayerSubtitles() end

---Player mark parking.
function FLIGHTGROUP:_MarkParking() end

---Player set skill.
---@param Skill? string Skill.
function FLIGHTGROUP:_PlayerSkill(Skill) end

---Init player data.
---@param PlayerName? string Player name.
---@return FLIGHTGROUP.PlayerData # Player data.
function FLIGHTGROUP:_InitPlayerData(PlayerName) end

---Get player data.
---@return FLIGHTGROUP.PlayerData # Player data.
function FLIGHTGROUP:_GetPlayerData() end

---Get distance to parking spot. Takes extra care of ships.
---@param Spot? AIRBASE.ParkingSpot|number|string Parking Spot.
---@param Coordinate? COORDINATE Reference coordinate.
---@return number # Distance to parking spot in meters.
function FLIGHTGROUP:_GetDistToParking(Spot, Coordinate) end

---Triggers the FSM event "Stop" after a delay. Stops the FLIGHTGROUP and all its event handlers.
---@param delay? number Delay in seconds.
function FLIGHTGROUP:__Stop(delay) end

---FSM Function OnAfterElementSpawned.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:OnAfterElementSpawned(From, Event, To, Element) end

---FSM Function OnAfterElementParking.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param Spot? AIRBASE.ParkingSpot|number|string Parking Spot.
function FLIGHTGROUP:OnAfterElementParking(From, Event, To, Element, Spot) end

---FSM Function OnAfterElementEngineOn.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:OnAfterElementEngineOn(From, Event, To, Element) end

---FSM Function OnAfterElementTaxiing.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:OnAfterElementTaxiing(From, Event, To, Element) end

---FSM Function OnAfterElementTakeoff.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param airbase? AIRBASE The airbase if applicable or nil.
function FLIGHTGROUP:OnAfterElementTakeoff(From, Event, To, Element, airbase) end

---FSM Function OnAfterElementAirborne.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:OnAfterElementAirborne(From, Event, To, Element) end

---FSM Function OnAfterElementLanded.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param airbase? AIRBASE The airbase if applicable or nil.
function FLIGHTGROUP:OnAfterElementLanded(From, Event, To, Element, airbase) end

---FSM Function OnAfterElementArrived.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
---@param airbase? AIRBASE The airbase, where the element arrived.
---@param Parking? AIRBASE.ParkingSpot|number|string The Parking spot the element has.
function FLIGHTGROUP:OnAfterElementArrived(From, Event, To, Element, airbase, Parking) end

---FSM Function OnAfterElementDestroyed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:OnAfterElementDestroyed(From, Event, To, Element) end

---FSM Function OnAfterElementDead.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Element? OPSGROUP.Element|number|string The flight group element.
function FLIGHTGROUP:OnAfterElementDead(From, Event, To, Element) end

---FSM Function OnAfterSpawned.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterSpawned(From, Event, To) end

---FSM Function OnAfterParking.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterParking(From, Event, To) end

---FSM Function OnAfterTaxiing.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterTaxiing(From, Event, To) end

---FSM Function OnAfterTakeoff.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterTakeoff(From, Event, To) end

---FSM Function OnAfterAirborne.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterAirborne(From, Event, To) end

---FSM Function OnAfterCruise.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterCruise(From, Event, To) end

---FSM Function OnAfterLanding.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterLanding(From, Event, To) end

---FSM Function OnAfterLanded.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase the flight landed.
function FLIGHTGROUP:OnAfterLanded(From, Event, To, airbase) end

---FSM Function OnAfterLandedAt.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterLandedAt(From, Event, To) end

---FSM Function OnAfterArrived.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterArrived(From, Event, To) end

---FSM Function OnAfterDead.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterDead(From, Event, To) end

---FSM Function OnAfterUpdateRoute.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param n? number Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N? number Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
function FLIGHTGROUP:OnAfterUpdateRoute(From, Event, To, n, N) end

---FSM Function OnAfterOutOfMissilesAA.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterOutOfMissilesAA(From, Event, To) end

---FSM Function OnAfterOutOfMissilesAG.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterOutOfMissilesAG(From, Event, To) end

---FSM Function OnAfterRTB.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
---@param SpeedTo? number Speed used for traveling from current position to holding point in knots. Default 75% of max speed.
---@param SpeedHold? number Holding speed in knots. Default 250 kts.
---@param SpeedLand? number Landing speed in knots. Default 170 kts.
function FLIGHTGROUP:OnAfterRTB(From, Event, To, airbase, SpeedTo, SpeedHold, SpeedLand) end

---FSM Function OnAfterLandAtAirbase.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
function FLIGHTGROUP:OnAfterLandAtAirbase(From, Event, To, airbase) end

---FSM Function OnAfterWait.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Duration? number Duration how long the group will be waiting in seconds. Default `nil` (=forever).
---@param Altitude? number Altitude in feet. Default 10,000 ft for airplanes and 1,000 feet for helos.
---@param Speed? number Speed in knots. Default 250 kts for airplanes and 20 kts for helos.
function FLIGHTGROUP:OnAfterWait(From, Event, To, Duration, Altitude, Speed) end

---FSM Function OnAfterRefuel.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? COORDINATE The coordinate.
function FLIGHTGROUP:OnAfterRefuel(From, Event, To, Coordinate) end

---FSM Function OnAfterRefueled.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterRefueled(From, Event, To) end

---FSM Function OnAfterDisengage.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param TargetUnitSet? SET_UNIT
function FLIGHTGROUP:OnAfterDisengage(From, Event, To, TargetUnitSet) end

---FSM Function OnAfterEngageTarget.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Target? table Target object. Can be a UNIT, STATIC, GROUP, SET_UNIT or SET_GROUP object.
function FLIGHTGROUP:OnAfterEngageTarget(From, Event, To, Target) end

---FSM Function OnAfterLandAt.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param TargetUnitSet? SET_UNIT
function FLIGHTGROUP:OnAfterLandAt(From, Event, To, TargetUnitSet) end

---FSM Function OnAfterFuelLow.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterFuelLow(From, Event, To) end

---FSM Function OnAfterFuelCritical.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTGROUP:OnAfterFuelCritical(From, Event, To) end

---FSM Function OnBeforeUpdateRoute.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param n? number Next waypoint index. Default is the one coming after that one that has been passed last.
---@param N? number Waypoint  Max waypoint index to be included in the route. Default is the final waypoint.
---@return boolean # Transision allowed?
function FLIGHTGROUP:OnBeforeUpdateRoute(From, Event, To, n, N) end

---FSM Function OnBeforeRTB.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
---@param SpeedTo? number Speed used for travelling from current position to holding point in knots.
---@param SpeedHold? number Holding speed in knots.
function FLIGHTGROUP:OnBeforeRTB(From, Event, To, airbase, SpeedTo, SpeedHold) end

---FSM Function OnBeforeLandAtAirbase.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to hold at.
function FLIGHTGROUP:OnBeforeLandAtAirbase(From, Event, To, airbase) end

---FSM Function OnBeforeWait.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Duration? number Duration how long the group will be waiting in seconds. Default `nil` (=forever).
---@param Altitude? number Altitude in feet. Default 10,000 ft for airplanes and 1,000 feet for helos.
---@param Speed? number Speed in knots. Default 250 kts for airplanes and 20 kts for helos.
function FLIGHTGROUP:OnBeforeWait(From, Event, To, Duration, Altitude, Speed) end

---FSM Function OnBeforeLandAt.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coordinate? COORDINATE The coordinate where to land. Default is current position.
---@param Duration? number The duration in seconds to remain on ground. Default 600 sec (10 min).
function FLIGHTGROUP:OnBeforeLandAt(From, Event, To, Coordinate, Duration) end
