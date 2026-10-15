---@meta

---@class FLEET.SupplyZone
---@field zone ZONE The zone.
---@field mission AUFTRAG Mission assigned to supply ammo or fuel.
---@field markerOn boolean If `true`, marker is on.
---@field marker MARKER F10 marker.

---FLEET class.
---@class FLEET : LEGION
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field retreatZones SET_ZONE Retreat zone set.
---@field pathfinding boolean Set pathfinding on for all spawned navy groups.
FLEET = {
  ClassName       = "FLEET",
  verbose         =       0,
  pathfinding     =   false,
}

---FLEET class version.
FLEET.version = "0.0.1"

---Create a new FLEET class object.
---@param WarehouseName? string Name of the warehouse STATIC or UNIT object representing the warehouse.
---@param FleetName? string Name of the fleet.
---@return FLEET # self
function FLEET:New(WarehouseName, FleetName) end

---Add a flotilla to the fleet.
---@param Flotilla? FLOTILLA The flotilla object.
---@return FLEET # self
function FLEET:AddFlotilla(Flotilla) end

---Add asset group(s) to flotilla.
---@param Flotilla? FLOTILLA The flotilla object.
---@param Nassets? number Number of asset groups to add.
---@return FLEET # self
function FLEET:AddAssetToFlotilla(Flotilla, Nassets) end

---Set pathfinding for all spawned naval groups.
---@param Switch? boolean If `true`, pathfinding is used.
---@return FLEET # self
function FLEET:SetPathfinding(Switch) end

---Define a set of retreat zones.
---@param RetreatZoneSet? SET_ZONE Set of retreat zones.
---@return FLEET # self
function FLEET:SetRetreatZones(RetreatZoneSet) end

---Add a retreat zone.
---@param RetreatZone? ZONE Retreat zone.
---@return FLEET # self
function FLEET:AddRetreatZone(RetreatZone) end

---Get retreat zones.
---@return SET_ZONE # Set of retreat zones.
function FLEET:GetRetreatZones() end

---Get flotilla by name.
---@param FlotillaName? string Name of the flotilla.
---@return FLOTILLA # The Flotilla object.
function FLEET:GetFlotilla(FlotillaName) end

---Get flotilla of an asset.
---@param Asset? WAREHOUSE.Assetitem|number|string The flotilla asset.
---@return FLOTILLA # The flotilla object.
function FLEET:GetFlotillaOfAsset(Asset) end

---Remove asset from flotilla.
---@param Asset? WAREHOUSE.Assetitem|number|string The flotilla asset.
function FLEET:RemoveAssetFromFlotilla(Asset) end

---Start FLEET FSM.
---@param From? any
---@param Event? any
---@param To? any
function FLEET:onafterStart(From, Event, To) end

---Update status.
---@param From? any
---@param Event? any
---@param To? any
function FLEET:onafterStatus(From, Event, To) end

---On after "NavyOnMission".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param NavyGroup? any
---@param Mission? AUFTRAG The requested mission.
function FLEET:onafterNavyOnMission(From, Event, To, NavyGroup, Mission) end

---Triggers the FSM event "Start". Starts the FLEET. Initializes parameters and starts event handlers.
function FLEET:Start() end

---Triggers the FSM event "Start" after a delay. Starts the FLEET. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function FLEET:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the FLEET and all its event handlers.
---@param delay? number Delay in seconds.
function FLEET:__Stop(delay) end

---Triggers the FSM event "NavyOnMission".
---@param ArmyGroup? NAVYGROUP The NAVYGROUP on mission.
---@param Mission? AUFTRAG The mission.
function FLEET:NavyOnMission(ArmyGroup, Mission) end

---Triggers the FSM event "NavyOnMission" after a delay.
---@param delay? number Delay in seconds.
---@param ArmyGroup? NAVYGROUP The NAVYGROUP on mission.
---@param Mission? AUFTRAG The mission.
function FLEET:__NavyOnMission(delay, ArmyGroup, Mission) end

---On after "NavyOnMission" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param NavyGroup? NAVYGROUP The NAVYGROUP on mission.
---@param Mission? AUFTRAG The mission.
function FLEET:OnAfterNavyOnMission(From, Event, To, NavyGroup, Mission) end
