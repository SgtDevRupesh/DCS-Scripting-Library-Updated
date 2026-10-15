---@meta

---RESCUEHELO class.
---@class RESCUEHELO : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode on/off.
---@field lid string Log debug id text.
---@field carrier UNIT The carrier the helo is attached to.
---@field carriertype string Carrier type.
---@field helogroupname string Name of the late activated helo template group.
---@field helo GROUP Helo group.
---@field takeoff number Takeoff type.
---@field airbase AIRBASE The airbase object acting as home base of the helo.
---@field followset SET_GROUP Follow group set.
---@field formation FORMATION FORMATION object.
---@field lowfuel number Low fuel threshold of helo in percent.
---@field altitude number Altitude of helo in meters.
---@field offsetX number Offset in meters to carrier in longitudinal direction.
---@field offsetZ number Offset in meters to carrier in latitudinal direction.
---@field rescuezone ZONE_RADIUS Zone around the carrier in which helo will rescue crashed or ejected units.
---@field respawn boolean If true, helo be respawned (default). If false, no respawning will happen.
---@field respawninair boolean If true, helo will always be respawned in air. This has no impact on the initial spawn setting.
---@field uncontrolledac boolean If true, use and uncontrolled helo group already present in the mission.
---@field rescueon boolean If true, helo will rescue crashed pilots. If false, no recuing will happen.
---@field rescueduration number Time the rescue helicopter hovers over the crash site in seconds.
---@field rescuespeed number Speed in m/s the rescue helicopter hovers at over the crash site.
---@field rescuestopboat boolean If true, stop carrier during rescue operations.
---@field carrierstop boolean If true, route of carrier was stopped.
---@field HeloFuel0 number Initial fuel of helo in percent. Necessary due to DCS bug that helo with full tank does not return fuel via API function.
---@field rtb boolean If true, Helo will be return to base on the next status check.
---@field hid number Unit ID of the helo group. (Global) Running number.
---@field alias string Alias of the spawn group.
---@field uid number Unique ID of this helo.
---@field modex number Tail number of the helo.
---@field dtFollow number Follow time update interval in seconds. Default 1.0 sec.
RESCUEHELO = {
  ClassName      = "RESCUEHELO",
  Debug          = false,
  lid            = nil,
  carrier        = nil,
  carriertype    = nil,
  helogroupname  = nil,
  helo           = nil,
  airbase        = nil,
  takeoff        = nil,
  followset      = nil,
  formation      = nil,
  lowfuel        = nil,
  altitude       = nil,
  offsetX        = nil,
  offsetZ        = nil,
  rescuezone     = nil,
  respawn        = nil,
  respawninair   = nil,
  uncontrolledac = nil,
  rescueon       = nil,
  rescueduration = nil,
  rescuespeed    = nil,
  rescuestopboat = nil,
  HeloFuel0      = nil,
  rtb            = nil,
  carrierstop    = nil,
  alias          = nil,
  uid            =   0,
  modex          = nil,
  dtFollow       = nil,
}

---Class version.
RESCUEHELO.version = "1.2.0"

---Create a new RESCUEHELO object.
---@param carrierunit? UNIT Carrier unit object or simply the unit name.
---@param helogroupname? string Name of the late activated rescue helo template group.
---@return RESCUEHELO # RESCUEHELO object.
function RESCUEHELO:New(carrierunit, helogroupname) end

---Set low fuel state of helo. When fuel is below this threshold, the helo will RTB or be respawned if takeoff type is in air.
---@param threshold? number (Optional) Low fuel threshold in percent. Default 5%.
---@return RESCUEHELO # self
function RESCUEHELO:SetLowFuelThreshold(threshold) end

---Set home airbase of the helo. This is the airbase where the helo is spawned (if not in air) and will go when it is out of fuel.
---@param airbase? AIRBASE The home airbase. Can be the airbase name (passed as a string) or a Moose AIRBASE object.
---@return RESCUEHELO # self
function RESCUEHELO:SetHomeBase(airbase) end

---Set rescue zone radius. Crashed or ejected units inside this radius of the carrier will be rescued if possible.
---@param radius? number (Optional) Radius of rescue zone in nautical miles. Default is 15 NM.
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueZone(radius) end

---Set rescue hover speed.
---@param speed? number (Optional) Speed in knots. Default 5 kts.
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueHoverSpeed(speed) end

---Set rescue duration. This is the time it takes to rescue a pilot at the crash site.
---@param duration? number (Optional) Duration in minutes. Default 5 min.
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueDuration(duration) end

---Activate rescue option. Crashed and ejected pilots will be rescued. This is the default setting.
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueOn() end

---Deactivate rescue option. Crashed and ejected pilots will not be rescued.
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueOff() end

---Stop carrier during rescue operations. NOT WORKING!
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueStopBoatOn() end

---Do not stop carrier during rescue operations. This is the default setting.
---@return RESCUEHELO # self
function RESCUEHELO:SetRescueStopBoatOff() end

---Set takeoff type.
---@param takeofftype? number (Optional) Takeoff type. Default SPAWN.Takeoff.Hot.
---@return RESCUEHELO # self
function RESCUEHELO:SetTakeoff(takeofftype) end

---Set takeoff with engines running (hot).
---@return RESCUEHELO # self
function RESCUEHELO:SetTakeoffHot() end

---Set takeoff with engines off (cold).
---@return RESCUEHELO # self
function RESCUEHELO:SetTakeoffCold() end

---Set takeoff in air near the carrier.
---@return RESCUEHELO # self
function RESCUEHELO:SetTakeoffAir() end

---Set altitude of helo.
---@param alt? number (Optional) Altitude in meters. Default 70 m.
---@return RESCUEHELO # self
function RESCUEHELO:SetAltitude(alt) end

---Set offset parallel to orientation of carrier.
---@param distance? number (Optional) Offset distance in meters. Default 200 m (~660 ft).
---@return RESCUEHELO # self
function RESCUEHELO:SetOffsetX(distance) end

---Set offset perpendicular to orientation to carrier.
---@param distance? number (Optional) Offset distance in meters. Default 240 m (~780 ft).
---@return RESCUEHELO # self
function RESCUEHELO:SetOffsetZ(distance) end

---Enable respawning of helo. Note that this is the default behaviour.
---@return RESCUEHELO # self
function RESCUEHELO:SetRespawnOn() end

---Disable respawning of helo.
---@return RESCUEHELO # self
function RESCUEHELO:SetRespawnOff() end

---Set whether helo shall be respawned or not.
---@param switch? boolean If true (or nil), helo will be respawned. If false, helo will not be respawned.
---@return RESCUEHELO # self
function RESCUEHELO:SetRespawnOnOff(switch) end

---Helo will be respawned in air, even it was initially spawned on the carrier.
---So only the first spawn will be on the carrier while all subsequent spawns will happen in air.
---This allows for undisrupted operations and less problems on the carrier deck.
---@return RESCUEHELO # self
function RESCUEHELO:SetRespawnInAir() end

---Set modex (tail number) of the helo.
---@param modex? number Tail number.
---@return RESCUEHELO # self
function RESCUEHELO:SetModex(modex) end

---Set follow time update interval.
---@param dt? number (Optional) Time interval in seconds. Default 1.0 sec.
---@return RESCUEHELO # self
function RESCUEHELO:SetFollowTimeInterval(dt) end

---Use an uncontrolled aircraft already present in the mission rather than spawning a new helo as initial rescue helo.
---This can be useful when interfaced with, e.g., a warehouse.
---The group name is the one specified in the {#RESCUEHELO.New} function.
---@return RESCUEHELO # self
function RESCUEHELO:SetUseUncontrolledAircraft() end

---Activate debug mode. Display debug messages on screen.
---@return RESCUEHELO # self
function RESCUEHELO:SetDebugModeON() end

---Deactivate debug mode. This is also the default setting.
---@return RESCUEHELO # self
function RESCUEHELO:SetDebugModeOFF() end

---Check if helo is returning to base.
---@return boolean # If true, helo is returning to base.
function RESCUEHELO:IsReturning() end

---Check if helo is operating.
---@return boolean # If true, helo is operating.
function RESCUEHELO:IsRunning() end

---Check if helo is on a rescue mission.
---@return boolean # If true, helo is rescuing somebody.
function RESCUEHELO:IsRescuing() end

---Check if FMS was stopped.
---@return boolean # If true, is stopped.
function RESCUEHELO:IsStopped() end

---Alias of helo spawn group.
---@return string # Alias of the helo.
function RESCUEHELO:GetAlias() end

---Get unit name of the spawned helo.
---@return string # Name of the helo unit or nil if it does not exist.
function RESCUEHELO:GetUnitName() end

---Handle landing event of rescue helo.
---@param EventData? EVENTDATA Event data.
function RESCUEHELO:OnEventLand(EventData) end

---A unit crashed or a player ejected.
---@param EventData? EVENTDATA Event data.
function RESCUEHELO:_OnEventCrashOrEject(EventData) end

---On after Start event. Starts the warehouse. Addes event handlers and schedules status updates of reqests and queue.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RESCUEHELO:onafterStart(From, Event, To) end

---On after Status event. Checks player status.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RESCUEHELO:onafterStatus(From, Event, To) end

---On after "Run" event. FSM will go to "Running" state. If formation is stopped, it will be started again.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RESCUEHELO:onafterRun(From, Event, To) end

---Task to send the helo RTB.
---@return Task # DCS Task table.
function RESCUEHELO:_TaskRTB() end

---On after "Rescue" event. Helo will fly to the given coordinate, orbit there for 5 minutes and then return to the carrier.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param RescueCoord? COORDINATE Coordinate where the rescue should happen.
function RESCUEHELO:onafterRescue(From, Event, To, RescueCoord) end

---On after RTB event. Send helo back to carrier.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The base to return to. Default is the home base.
function RESCUEHELO:onafterRTB(From, Event, To, airbase) end

---On after Returned event. Helo has landed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The base to which the helo has returned.
function RESCUEHELO:onafterReturned(From, Event, To, airbase) end

---On after Stop event. Unhandle events and stop status updates. If helo is alive, it is despawned.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RESCUEHELO:onafterStop(From, Event, To) end

---Route helo back to its home base.
---@param RTBAirbase? AIRBASE
---@param Speed? number Speed.
function RESCUEHELO:RouteRTB(RTBAirbase, Speed) end

---Triggers the FSM event "Start" that starts the rescue helo. Initializes parameters and starts event handlers.
function RESCUEHELO:Start() end

---Triggers the FSM event "Start" that starts the rescue helo after a delay. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function RESCUEHELO:__Start(delay) end

---On after "Start" event function. Called when FSM is started.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RESCUEHELO:OnAfterStart(From, Event, To) end

---Triggers the FSM event "Rescue" that sends the helo on a rescue mission to a specifc coordinate.
---@param RescueCoord? COORDINATE Coordinate where the resue mission takes place.
function RESCUEHELO:Rescue(RescueCoord) end

---Triggers the delayed FSM event "Rescue" that sends the helo on a rescue mission to a specifc coordinate.
---@param delay? number Delay in seconds.
---@param RescueCoord? COORDINATE Coordinate where the resue mission takes place.
function RESCUEHELO:__Rescue(delay, RescueCoord) end

---On after "Rescue" event user function. Called when a the the helo goes on a rescue mission.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param RescueCoord? COORDINATE Crash site where the rescue operation takes place.
function RESCUEHELO:OnAfterRescue(From, Event, To, RescueCoord) end

---Triggers the FSM event "RTB" that sends the helo home.
---@param airbase? AIRBASE The airbase to return to. Default is the home base.
function RESCUEHELO:RTB(airbase) end

---Triggers the FSM event "RTB" that sends the helo home after a delay.
---@param delay? number Delay in seconds.
---@param airbase? AIRBASE The airbase to return to. Default is the home base.
function RESCUEHELO:__RTB(delay, airbase) end

---On after "RTB" event user function. Called when a the the helo returns to its home base.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase to return to. Default is the home base.
function RESCUEHELO:OnAfterRTB(From, Event, To, airbase) end

---Triggers the FSM event "Returned" after the helo has landed.
---@param airbase? AIRBASE The airbase the helo has landed.
function RESCUEHELO:Returned(airbase) end

---Triggers the delayed FSM event "Returned" after the helo has landed.
---@param delay? number Delay in seconds.
---@param airbase? AIRBASE The airbase the helo has landed.
function RESCUEHELO:__Returned(delay, airbase) end

---On after "Returned" event user function. Called when a the the helo has landed at an airbase.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param airbase? AIRBASE The airbase the helo has landed.
function RESCUEHELO:OnAfterReturned(From, Event, To, airbase) end

---Triggers the FSM event "Run".
function RESCUEHELO:Run() end

---Triggers the delayed FSM event "Run".
---@param delay? number Delay in seconds.
function RESCUEHELO:__Run(delay) end

---Triggers the FSM event "Status" that updates the helo status.
function RESCUEHELO:Status() end

---Triggers the delayed FSM event "Status" that updates the helo status.
---@param delay? number Delay in seconds.
function RESCUEHELO:__Status(delay) end

---Triggers the FSM event "Stop" that stops the rescue helo. Event handlers are stopped.
function RESCUEHELO:Stop() end

---Triggers the FSM event "Stop" that stops the rescue helo after a delay. Event handlers are stopped.
---@param delay? number Delay in seconds.
function RESCUEHELO:__Stop(delay) end
