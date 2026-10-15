---@meta

---@class BRIGADE.SupplyZone
---@field zone ZONE The zone.
---@field mission AUFTRAG Mission assigned to supply ammo or fuel.
---@field markerOn boolean If `true`, marker is on.
---@field marker MARKER F10 marker.

---BRIGADE class.
---@class BRIGADE : LEGION
---@field ClassName string Name of the class.
---@field verbose number Verbosity of output.
---@field rearmingZones table Rearming zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field refuellingZones table Refuelling zones. Each element is of type `#BRIGADE.SupplyZone`.
---@field retreatZones SET_ZONE Retreat zone set.
BRIGADE = {
  ClassName       = "BRIGADE",
  verbose         =     0,
  rearmingZones   =    {},
  refuellingZones =    {}, 
}

---BRIGADE class version.
BRIGADE.version = "0.1.1"

---Create a new BRIGADE class object.
---@param WarehouseName? string Name of the warehouse STATIC or UNIT object representing the warehouse.
---@param BrigadeName? string Name of the brigade.
---@return BRIGADE # self
function BRIGADE:New(WarehouseName, BrigadeName) end

---Add a platoon to the brigade.
---@param Platoon? PLATOON The platoon object.
---@return BRIGADE # self
function BRIGADE:AddPlatoon(Platoon) end

---Add asset group(s) to platoon.
---@param Platoon? PLATOON The platoon object.
---@param Nassets? number Number of asset groups to add.
---@return BRIGADE # self
function BRIGADE:AddAssetToPlatoon(Platoon, Nassets) end

---Define a set of retreat zones.
---@param RetreatZoneSet? SET_ZONE Set of retreat zones.
---@return BRIGADE # self
function BRIGADE:SetRetreatZones(RetreatZoneSet) end

---Add a retreat zone.
---@param RetreatZone? ZONE Retreat zone.
---@return BRIGADE # self
function BRIGADE:AddRetreatZone(RetreatZone) end

---Get retreat zones.
---@return SET_ZONE # Set of retreat zones.
function BRIGADE:GetRetreatZones() end

---Add a rearming zone.
---@param RearmingZone? ZONE Rearming zone.
---@return BRIGADE.SupplyZone # The rearming zone data.
function BRIGADE:AddRearmingZone(RearmingZone) end

---Add a refuelling zone.
---@param RefuellingZone? ZONE Refuelling zone.
---@return BRIGADE.SupplyZone # The refuelling zone data.
function BRIGADE:AddRefuellingZone(RefuellingZone) end

---Get platoon by name.
---@param PlatoonName? string Name of the platoon.
---@return PLATOON # The Platoon object.
function BRIGADE:GetPlatoon(PlatoonName) end

---Get platoon of an asset.
---@param Asset? WAREHOUSE.Assetitem|number|string The platoon asset.
---@return PLATOON # The platoon object.
function BRIGADE:GetPlatoonOfAsset(Asset) end

---Remove asset from platoon.
---@param Asset? WAREHOUSE.Assetitem|number|string The platoon asset.
function BRIGADE:RemoveAssetFromPlatoon(Asset) end

---[ GROUND ] Function to load back an asset in the field that has been filed before.
---@param Templatename? string e.g."1 PzDv LogRg I\_AID-976" - that's the alias (name) of an platoon spawned as `"platoon - alias"_AID-"asset-ID"`
---@param Position? COORDINATE where to spawn the platoon
---@return BRIGADE # self
function BRIGADE:LoadBackAssetInPosition(Templatename, Position) end

---Start BRIGADE FSM.
---@param From? any
---@param Event? any
---@param To? any
function BRIGADE:onafterStart(From, Event, To) end

---Update status.
---@param From? any
---@param Event? any
---@param To? any
function BRIGADE:onafterStatus(From, Event, To) end

---On after "ArmyOnMission".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param ArmyGroup? ARMYGROUP Ops army group on mission.
---@param Mission? AUFTRAG The requested mission.
function BRIGADE:onafterArmyOnMission(From, Event, To, ArmyGroup, Mission) end

---Triggers the FSM event "Start". Starts the BRIGADE. Initializes parameters and starts event handlers.
function BRIGADE:Start() end

---Triggers the FSM event "Start" after a delay. Starts the BRIGADE. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function BRIGADE:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the BRIGADE and all its event handlers.
---@param delay? number Delay in seconds.
function BRIGADE:__Stop(delay) end

---Triggers the FSM event "ArmyOnMission".
---@param ArmyGroup? ARMYGROUP The ARMYGROUP on mission.
---@param Mission? AUFTRAG The mission.
function BRIGADE:ArmyOnMission(ArmyGroup, Mission) end

---Triggers the FSM event "ArmyOnMission" after a delay.
---@param delay? number Delay in seconds.
---@param ArmyGroup? ARMYGROUP The ARMYGROUP on mission.
---@param Mission? AUFTRAG The mission.
function BRIGADE:__ArmyOnMission(delay, ArmyGroup, Mission) end

---On after "ArmyOnMission" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param ArmyGroup? ARMYGROUP The ARMYGROUP on mission.
---@param Mission? AUFTRAG The mission.
function BRIGADE:OnAfterArmyOnMission(From, Event, To, ArmyGroup, Mission) end
