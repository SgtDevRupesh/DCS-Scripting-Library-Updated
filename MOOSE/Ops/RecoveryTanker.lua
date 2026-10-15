---@meta

---RECOVERYTANKER class.
---@class RECOVERYTANKER : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode.
---@field lid string Log debug id text.
---@field carrier UNIT The carrier the tanker is attached to.
---@field carriertype string Carrier type.
---@field tankergroupname string Name of the late activated tanker template group.
---@field tanker GROUP Tanker group.
---@field airbase AIRBASE The home airbase object of the tanker. Normally the aircraft carrier.
---@field beacon BEACON Tanker TACAN beacon.
---@field TACANchannel number TACAN channel. Default 1.
---@field TACANmode string TACAN mode, i.e. "X" or "Y". Default "Y". Use only "Y" for AA TACAN stations!
---@field TACANmorse string TACAN morse code. Three letters identifying the TACAN station. Default "TKR".
---@field TACANon boolean If true, TACAN is automatically activated. If false, TACAN is disabled.
---@field RadioFreq number Radio frequency in MHz of the tanker. Default 251 MHz.
---@field RadioModu string Radio modulation "AM" or "FM". Default "AM".
---@field speed number Tanker speed when flying pattern.
---@field altitude number Tanker orbit pattern altitude.
---@field distStern number Race-track distance astern. distStern is <0.
---@field distBow number Race-track distance bow. distBow is >0.
---@field Dupdate number Pattern update when carrier changes its position by more than this distance (meters).
---@field Hupdate number Pattern update when carrier changes its heading by more than this number (degrees).
---@field dTupdate number Minimum time interval in seconds before the next pattern update can happen.
---@field Tupdate number Last time the pattern was updated.
---@field takeoff number Takeoff type (cold, hot, air).
---@field lowfuel number Low fuel threshold in percent.
---@field respawn boolean If true, tanker be respawned (default). If false, no respawning will happen.
---@field respawninair boolean If true, tanker will always be respawned in air. This has no impact on the initial spawn setting.
---@field uncontrolledac boolean If true, use and uncontrolled tanker group already present in the mission.
---@field orientation Vec3 Orientation of the carrier. Used to monitor changes and update the pattern if heading changes significantly.
---@field orientlast Vec3 Orientation of the carrier for checking if carrier is currently turning.
---@field position COORDINATE Position of carrier. Used to monitor if carrier significantly changed its position and then update the tanker pattern.
---@field alias string Alias of the spawn group.
---@field uid number Unique ID of this tanker.
---@field awacs boolean If true, the groups gets the enroute task AWACS instead of tanker.
---@field callsignname number Number for the callsign name.
---@field callsignnumber number Number of the callsign name.
---@field modex string Tail number of the tanker.
---@field eplrs boolean If true, enable data link, e.g. if used as AWACS.
---@field recovery boolean If true, tanker will recover using the AIRBOSS marshal pattern.
---@field terminaltype number Terminal type of used parking spots on airbases.
---@field unlimitedfuel boolean If true, the tanker will have unlimited fuel.
RECOVERYTANKER = {
  ClassName       = "RECOVERYTANKER",
  Debug           = false,
  lid             = nil,
  carrier         = nil,
  carriertype     = nil,
  tankergroupname = nil,
  tanker          = nil,
  airbase         = nil,
  beacon          = nil,
  TACANchannel    = nil,
  TACANmode       = nil,
  TACANmorse      = nil,
  TACANon         = nil,
  RadioFreq       = nil,
  RadioModu       = nil,
  altitude        = nil,
  speed           = nil,
  distStern       = nil,
  distBow         = nil,
  dTupdate        = nil,
  Dupdate         = nil,
  Hupdate         = nil,
  Tupdate         = nil,
  takeoff         = nil,
  lowfuel         = nil,
  respawn         = nil,
  respawninair    = nil,
  uncontrolledac  = nil,
  orientation     = nil,
  orientlast      = nil,
  position        = nil,
  alias           = nil,
  uid             =   0,
  awacs           = nil,
  callsignname    = nil,
  callsignnumber  = nil,
  modex           = nil,
  eplrs           = nil,
  recovery        = nil,
  terminaltype    = nil,
  unlimitedfuel   = false,
}

---Class version.
RECOVERYTANKER.version = "1.0.11"

---Create new RECOVERYTANKER object.
---@param carrierunit? UNIT Carrier unit.
---@param tankergroupname? string Name of the late activated tanker aircraft template group.
---@return RECOVERYTANKER # RECOVERYTANKER object.
function RECOVERYTANKER:New(carrierunit, tankergroupname) end

---Set the tanker to have unlimited fuel.
---@param OnOff? boolean If true, the tanker will have unlimited fuel.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetUnlimitedFuel(OnOff) end

---Set the speed the tanker flys in its orbit pattern.
---@param speed? number (Optional) True air speed (TAS) in knots. Default 274 knots, which results in ~250 KIAS.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetSpeed(speed) end

---Set orbit pattern altitude of the tanker.
---@param altitude? number (Optional) Tanker altitude in feet. Default 6000 ft.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetAltitude(altitude) end

---Set race-track distances.
---@param distbow? number (Optional) Distance [NM] in front of the carrier. Default 10 NM.
---@param diststern? number (Optional) Distance [NM] behind the carrier. Default 4 NM.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRacetrackDistances(distbow, diststern) end

---Set minimum pattern update interval. After a pattern update this time interval has to pass before the next update is allowed.
---@param interval? number (Optional)  Min interval in minutes. Default is 10 minutes.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetPatternUpdateInterval(interval) end

---Set pattern update distance threshold. Tanker will update its pattern when the carrier changes its position by more than this distance.
---@param distancechange? number (Optional) Distance threshold in NM. Default 5 NM (=9.62 km).
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetPatternUpdateDistance(distancechange) end

---Set pattern update heading threshold. Tanker will update its pattern when the carrier changes its heading by more than this value.
---@param headingchange? number (Optional) Heading threshold in degrees. Default 5 degrees.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetPatternUpdateHeading(headingchange) end

---Set low fuel state of tanker. When fuel is below this threshold, the tanker will RTB or be respawned if takeoff type is in air.
---@param fuelthreshold? number (Optional) Low fuel threshold in percent. Default 10 % of max fuel.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetLowFuelThreshold(fuelthreshold) end

---Set home airbase of the tanker. This is the airbase where the tanker will go when it is out of fuel.
---@param airbase? AIRBASE The home airbase. Can be the airbase name or a Moose AIRBASE object.
---@param terminaltype? number (Optional) The terminal type of parking spots used for spawning at airbases. Default AIRBASE.TerminalType.OpenMedOrBig.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetHomeBase(airbase, terminaltype) end

---Activate recovery by the AIRBOSS class. Tanker will get a Marshal stack and perform a CASE I, II or III recovery when RTB.
---@param switch? boolean If true or nil, recovery is done by AIRBOSS.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRecoveryAirboss(switch) end

---Set that the group takes the role of an AWACS instead of a refueling tanker.
---@param switch? boolean If true or nil, set role AWACS.
---@param eplrs? boolean If true or nil, enable EPLRS. If false, EPLRS will be off.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetAWACS(switch, eplrs) end

---Set callsign of the tanker group.
---@param callsignname? number Number
---@param callsignnumber? number Number
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetCallsign(callsignname, callsignnumber) end

---Set modex (tail number) of the tanker.
---@param modex? number Tail number.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetModex(modex) end

---Set takeoff type.
---@param takeofftype? number Takeoff type.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetTakeoff(takeofftype) end

---Set takeoff with engines running (hot).
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetTakeoffHot() end

---Set takeoff with engines off (cold).
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetTakeoffCold() end

---Set takeoff in air at the defined pattern altitude and ~10 NM astern the carrier.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetTakeoffAir() end

---Enable respawning of tanker. Note that this is the default behaviour.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRespawnOn() end

---Disable respawning of tanker.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRespawnOff() end

---Set whether tanker shall be respawned or not.
---@param switch? boolean If true (or nil), tanker will be respawned. If false, tanker will not be respawned.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRespawnOnOff(switch) end

---Tanker will be respawned in air, even it was initially spawned on the carrier.
---So only the first spawn will be on the carrier while all subsequent spawns will happen in air.
---This allows for undisrupted operations and less problems on the carrier deck.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRespawnInAir() end

---Use an uncontrolled aircraft already present in the mission rather than spawning a new tanker as initial recovery thanker.
---This can be useful when interfaced with, e.g., a MOOSE {Functional.Warehouse#WAREHOUSE}.
---The group name is the one specified in the {#RECOVERYTANKER.New} function.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetUseUncontrolledAircraft() end

---Disable automatic TACAN activation.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetTACANoff() end

---Set TACAN channel of tanker. Note that mode is automatically set to "Y" for AA TACAN since only that works.
---@param channel? number (Optional) TACAN channel. Default 1.
---@param morse? string (Optional) TACAN morse code identifier. Three letters. Default "TKR".
---@param mode? string (Optional) TACAN mode, which can be either "Y" (default) or "X".
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetTACAN(channel, morse, mode) end

---Set radio frequency and optionally modulation of the tanker.
---@param frequency? number (Optional) Radio frequency in MHz. Default 251 MHz.
---@param modulation? string (Optional) Radio modulation, either "AM" or "FM". Default "AM".
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetRadio(frequency, modulation) end

---Activate debug mode. Marks of pattern on F10 map and debug messages displayed on screen.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetDebugModeON() end

---Deactivate debug mode. This is also the default setting.
---@return RECOVERYTANKER # self
function RECOVERYTANKER:SetDebugModeOFF() end

---Check if tanker is currently returning to base.
---@return boolean # If true, tanker is returning to base.
function RECOVERYTANKER:IsReturning() end

---Check if tanker has returned to base.
---@return boolean # If true, tanker has returned to base.
function RECOVERYTANKER:IsReturned() end

---Check if tanker is currently operating.
---@return boolean # If true, tanker is operating.
function RECOVERYTANKER:IsRunning() end

---Check if tanker is currently refueling another aircraft.
---@return boolean # If true, tanker is refueling.
function RECOVERYTANKER:IsRefueling() end

---Check if FMS was stopped.
---@return boolean # If true, is stopped.
function RECOVERYTANKER:IsStopped() end

---Alias of tanker spawn group.
---@return string # Alias of the tanker.
function RECOVERYTANKER:GetAlias() end

---Get unit name of the spawned tanker.
---@return string # Name of the tanker unit or nil if it does not exist.
function RECOVERYTANKER:GetUnitName() end

---On after Start event. Starts the warehouse. Addes event handlers and schedules status updates of reqests and queue.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RECOVERYTANKER:onafterStart(From, Event, To) end

---On after Status event. Checks player status.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RECOVERYTANKER:onafterStatus(From, Event, To) end

---On after "PatternUpdate" event. Updates the racetrack pattern of the tanker wrt the carrier position.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RECOVERYTANKER:onafterPatternUpdate(From, Event, To) end

---On after "RTB" event. Send tanker back to carrier.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:onafterRTB(From, Event, To, airbase) end

---On after Returned event. The tanker has landed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The base at which the tanker landed.
function RECOVERYTANKER:onafterReturned(From, Event, To, airbase) end

---On after Stop event. Unhandle events and stop status updates.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RECOVERYTANKER:onafterStop(From, Event, To) end

---Event handler for landing of recovery tanker.
---@param EventData? EVENTDATA Event data.
function RECOVERYTANKER:OnEventLand(EventData) end

---Event handler for engine shutdown of recovery tanker.
---Respawn tanker group once it landed because it was out of fuel.
---@param EventData? EVENTDATA Event data.
function RECOVERYTANKER:OnEventEngineShutdown(EventData) end

---Event handler for refueling started.
---@param EventData? EVENTDATA Event data.
function RECOVERYTANKER:_RefuelingStart(EventData) end

---Event handler for refueling stopped.
---@param EventData? EVENTDATA Event data.
function RECOVERYTANKER:_RefuelingStop(EventData) end

---Get clear name callsign for spawn from enumerator
---@param Callsign? number
---@param Enumerator? table The table of callsigns, e.g. `CALLSIGN.Tanker`
---@return string # Name Name or "" if not found
function RECOVERYTANKER:_GetCallsignName(Callsign, Enumerator) end

---A unit crashed or died.
---@param EventData? EVENTDATA Event data.
function RECOVERYTANKER:_OnEventCrashOrDead(EventData) end

---Task function to
function RECOVERYTANKER:_InitPatternTaskFunction() end

---Init waypoint after spawn. Tanker is first guided to a position astern the carrier and starts its racetrack pattern from there.
---@param dist? number (Optional) Distance [NM] of initial waypoint astern carrier. Default 8 NM.
---@param delay? number (Optional) Delay before routing in seconds. Default 1 second.
function RECOVERYTANKER:_InitRoute(dist, delay) end

---Check if heading or position have changed significantly.
---@param dt? number Time since last update in seconds.
---@return boolean # If true, heading and/or position have changed more than 5 degrees or 10 km, respectively.
function RECOVERYTANKER:_CheckPatternUpdate(dt) end

---Activate TACAN of tanker.
---@param delay? number Delay in seconds.
function RECOVERYTANKER:_ActivateTACAN(delay) end

---Self made race track pattern. Not working as desired, since tanker changes course too rapidly after each waypoint.
---@return table # Table of pattern waypoints.
function RECOVERYTANKER:_Pattern() end

---Triggers the FSM event "Start" that starts the recovery tanker. Initializes parameters and starts event handlers.
function RECOVERYTANKER:Start() end

---Triggers the FSM event "Start" that starts the recovery tanker after a delay. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function RECOVERYTANKER:__Start(delay) end

---On after "Start" event function. Called when FSM is started.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RECOVERYTANKER:OnAfterStart(From, Event, To) end

---Triggers the FSM event "RefuelStart" when the tanker starts refueling another aircraft.
---@param receiver? UNIT Unit receiving fuel from the tanker.
function RECOVERYTANKER:RefuelStart(receiver) end

---On after "RefuelStart" event user function. Called when a the the tanker started to refuel another unit.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param receiver? UNIT Unit receiving fuel from the tanker.
function RECOVERYTANKER:OnAfterRefuelStart(From, Event, To, receiver) end

---Triggers the FSM event "RefuelStop" when the tanker stops refueling another aircraft.
---@param receiver? UNIT Unit stoped receiving fuel from the tanker.
function RECOVERYTANKER:RefuelStop(receiver) end

---On after "RefuelStop" event user function. Called when a the the tanker stopped to refuel another unit.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param receiver? UNIT Unit that received fuel from the tanker.
function RECOVERYTANKER:OnAfterRefuelStop(From, Event, To, receiver) end

---Triggers the FSM event "Run". Simply puts the group into "Running" state.
function RECOVERYTANKER:Run() end

---Triggers delayed the FSM event "Run". Simply puts the group into "Running" state.
---@param delay? number Delay in seconds.
function RECOVERYTANKER:__Run(delay) end

---Triggers the FSM event "RTB" that sends the tanker home.
---@param airbase? AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:RTB(airbase) end

---Triggers the FSM event "RTB" that sends the tanker home after a delay.
---@param delay? number Delay in seconds.
---@param airbase? AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:__RTB(delay, airbase) end

---On after "RTB" event user function. Called when a the the tanker returns to its home base.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase where the tanker should return to.
function RECOVERYTANKER:OnAfterRTB(From, Event, To, airbase) end

---Triggers the FSM event "Returned" after the tanker has landed.
---@param airbase? AIRBASE The airbase the tanker has landed.
function RECOVERYTANKER:Returned(airbase) end

---Triggers the delayed FSM event "Returned" after the tanker has landed.
---@param delay? number Delay in seconds.
---@param airbase? AIRBASE The airbase the tanker has landed.
function RECOVERYTANKER:__Returned(delay, airbase) end

---On after "Returned" event user function. Called when a the the tanker has landed at an airbase.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase the tanker has landed.
function RECOVERYTANKER:OnAfterReturned(From, Event, To, airbase) end

---Triggers the FSM event "Status" that updates the tanker status.
function RECOVERYTANKER:Status() end

---Triggers the delayed FSM event "Status" that updates the tanker status.
---@param delay? number Delay in seconds.
function RECOVERYTANKER:__Status(delay) end

---Triggers the FSM event "PatternUpdate" that updates the pattern of the tanker wrt to the carrier position.
function RECOVERYTANKER:PatternUpdate() end

---Triggers the delayed FSM event "PatternUpdate" that updates the pattern of the tanker wrt to the carrier position.
---@param delay? number Delay in seconds.
function RECOVERYTANKER:__PatternUpdate(delay) end

---On after "PatternEvent" event user function. Called when a the pattern of the tanker is updated.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RECOVERYTANKER:OnAfterPatternUpdate(From, Event, To) end

---Triggers the FSM event "Stop" that stops the recovery tanker. Event handlers are stopped.
function RECOVERYTANKER:Stop() end

---Triggers the FSM event "Stop" that stops the recovery tanker after a delay. Event handlers are stopped.
---@param delay? number Delay in seconds.
function RECOVERYTANKER:__Stop(delay) end
