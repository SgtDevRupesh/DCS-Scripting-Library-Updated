---@meta

---@class ZONE_GOAL : ZONE_RADIUS
---@field ClassName string Name of the class.
---@field Goal GOAL The goal object.
---@field SmokeTime number Time stamp in seconds when the last smoke of the zone was triggered.
---@field SmokeScheduler SCHEDULER Scheduler responsible for smoking the zone.
---@field SmokeColor number Color of the smoke.
---@field SmokeZone boolean If true, smoke zone.
ZONE_GOAL = {
  ClassName      = "ZONE_GOAL",
  Goal           = nil,
  SmokeTime      = nil,
  SmokeScheduler = nil,
  SmokeColor     = nil,
  SmokeZone      = nil,
}

---ZONE_GOAL Constructor.
---@param Zone? ZONE_RADIUS A @{Core.Zone} object with the goal to be achieved. Alternatively, can be handed as the name of late activated group describing a ZONE_POLYGON with its waypoints.
---@return ZONE_GOAL
function ZONE_GOAL:New(Zone) end

---Get the Zone.
---@return ZONE_GOAL
function ZONE_GOAL:GetZone() end

---Get the name of the Zone.
---@return string
function ZONE_GOAL:GetZoneName() end

---Activate smoking of zone with the color or the current owner.
---@param switch? boolean If *true* or *nil* activate smoke. If *false* or *nil*, no smoke.
---@return ZONE_GOAL
function ZONE_GOAL:SetSmokeZone(switch) end

---Set the smoke color.
---@param SmokeColor? SMOKECOLOR.Color|number|string
function ZONE_GOAL:Smoke(SmokeColor) end

---Flare the zone boundary.
---@param FlareColor? SMOKECOLOR.Color|number|string
function ZONE_GOAL:Flare(FlareColor) end

---When started, check the Smoke and the Zone status.
function ZONE_GOAL:onafterGuard() end

---Check status Smoke.
function ZONE_GOAL:StatusSmoke() end

---@param EventData? EVENTDATA Event data table.
function ZONE_GOAL:__Destroyed(EventData) end

---Activate the event UnitDestroyed to be fired when a unit is destroyed in the zone.
function ZONE_GOAL:MonitorDestroyedUnits() end

---DestroyedUnit event.
function ZONE_GOAL:DestroyedUnit() end

---DestroyedUnit delayed event
---@param delay? number Delay in seconds.
function ZONE_GOAL:__DestroyedUnit(delay) end

---DestroyedUnit Handler OnAfter for ZONE_GOAL
---@param From? string
---@param Event? string
---@param To? string
---@param DestroyedUnit? UNIT The destroyed unit.
---@param PlayerName? string The name of the player.
function ZONE_GOAL:OnAfterDestroyedUnit(From, Event, To, DestroyedUnit, PlayerName) end
