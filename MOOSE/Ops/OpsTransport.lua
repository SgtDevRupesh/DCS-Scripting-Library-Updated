---@meta

---@class OPSTRANSPORT.Condition
---@field func function Callback function to check for a condition. Should return a #boolean.
---@field arg table Optional arguments passed to the condition callback function.

---@class OPSTRANSPORT.Storage
---@field storageFrom STORAGE Storage from.
---@field storageTo STORAGE Storage To.
---@field cargoType string Type of cargo.
---@field cargoAmount number Amount of cargo that should be transported.
---@field cargoReserved number Amount of cargo that is reserved for a carrier group.
---@field cargoDelivered number Amount of cargo that has been delivered.
---@field cargoLost number Amount of cargo that was lost.
---@field cargoLoaded number Amount of cargo that is loading.
---@field cargoWeight number Weight of one single cargo item in kg. Default 1 kg.

---@class OPSTRANSPORT.Path
---@field waypoints table Table of waypoints.
---@field category number Category for which carriers this path is used.
---@field radius number Radomization radius for waypoints in meters. Default 0 m.
---@field reverse boolean If `true`, path is used in reversed order.

---@class OPSTRANSPORT.TransportZoneCombo
---@field uid number Unique ID of the TZ combo.
---@field Ncarriers number Number of carrier groups using this transport zone.
---@field Ncargo number Number of cargos assigned. This is a running number and *not* decreased if cargo is delivered or dead.
---@field Cargos table Cargo groups of the TZ combo. Each element is of type `Ops.OpsGroup#OPSGROUP.CargoGroup`.
---@field PickupZone ZONE Pickup zone.
---@field DeployZone ZONE Deploy zone.
---@field EmbarkZone ZONE Embark zone if different from pickup zone.
---@field DisembarkZone ZONE Zone where the troops are disembared to.
---@field PickupAirbase AIRBASE Airbase for pickup.
---@field DeployAirbase AIRBASE Airbase for deploy.
---@field PickupPaths table Paths for pickup.
---@field TransportPaths table Path for Transport. Each elment of the table is of type `#OPSTRANSPORT.Path`.
---@field RequiredCargos table Required cargos.
---@field DisembarkCarriers table Carriers where the cargo is directly disembarked to.
---@field disembarkToCarriers boolean If `true`, cargo is supposed to embark to another carrier.
---@field disembarkActivation boolean If true, troops are spawned in late activated state when disembarked from carrier.
---@field disembarkInUtero boolean If true, troops are disembarked "in utero".
---@field assets boolean Cargo assets.
---@field PickupFormation number Formation used to pickup.
---@field TransportFormation number Formation used to transport.

---OPSTRANSPORT class.
---@class OPSTRANSPORT : FSM
---@field ClassName string Name of the class.
---@field lid string Log ID.
---@field uid number Unique ID of the transport.
---@field verbose number Verbosity level.
---@field prio number Priority of this transport. Should be a number between 0 (high prio) and 100 (low prio).
---@field urgent boolean If true, transport is urgent.
---@field importance number Importance of this transport. Smaller=higher.
---@field Tstart number Start time in *abs.* seconds.
---@field Tstop number Stop time in *abs.* seconds. Default `#nil` (never stops).
---@field duration number Duration (`Tstop-Tstart`) of the transport in seconds.
---@field conditionStart table Start conditions.
---@field carriers table Carriers assigned for this transport.
---@field carrierTransportStatus table Status of each carrier.
---@field tzCombos table Table of transport zone combos. Each element of the table is of type `#OPSTRANSPORT.TransportZoneCombo`.
---@field tzcCounter number Running number of added transport zone combos.
---@field tzcDefault OPSTRANSPORT.TransportZoneCombo Default transport zone combo.
---@field Ncargo number Total number of cargo groups.
---@field Ncarrier number Total number of assigned carriers.
---@field Ndelivered number Total number of cargo groups delivered.
---@field NcarrierDead number Total number of dead carrier groups
---@field NcargoDead number Totalnumber of dead cargo groups.
---@field formationArmy string Default formation for ground vehicles.
---@field formationHelo string Default formation for helicopters.
---@field formationPlane string Default formation for airplanes.
---@field mission AUFTRAG The mission attached to this transport.
---@field assets table Warehouse assets assigned for this transport.
---@field legions table Assigned legions.
---@field statusLegion table Transport status of all assigned LEGIONs.
---@field statusCommander string Staus of the COMMANDER.
---@field commander COMMANDER Commander of the transport.
---@field chief CHIEF Chief of the transport.
---@field opszone OPSZONE OPS zone.
---@field requestID table The ID of the queued warehouse request. Necessary to cancel the request if the transport was cancelled before the request is processed.
---@field cargocounter number Running number to generate cargo UIDs.
OPSTRANSPORT = {
  ClassName       = "OPSTRANSPORT",
  verbose         =   0,
  carriers        =  {},
  carrierTransportStatus = {},
  tzCombos        =  {},
  tzcCounter      =   0,
  conditionStart  =  {},
  assets          =  {},
  legions         =  {},
  statusLegion    =  {},
  requestID       =  {},
  cargocounter    =   0,
}

---Cargo transport status.
---@class OPSTRANSPORT.Status
---@field PLANNED string Planning state.
---@field QUEUED string Queued state.
---@field REQUESTED string Requested state.
---@field SCHEDULED string Transport is scheduled in the cargo queue.
---@field EXECUTING string Transport is being executed.
---@field DELIVERED string Transport was delivered.
---@field CANCELLED string Transport was cancelled.
---@field SUCCESS string Transport was a success.
---@field FAILED string Transport failed.
OPSTRANSPORT.Status={
  PLANNED="planned",
  QUEUED="queued",
  REQUESTED="requested",
  SCHEDULED="scheduled",
  EXECUTING="executing",
  DELIVERED="delivered",
  CANCELLED="cancelled",
  SUCCESS="success",
  FAILED="failed",  
}

---Storage data.
---@class OPSTRANSPORT.CargoType
---@field OPSGROUP string Cargo is an OPSGROUP.
---@field STORAGE string Cargo is storage of DCS warehouse.
OPSTRANSPORT.CargoType={
  OPSGROUP="OPSGROUP",
  STORAGE="STORAGE",
}

---Army Group version.
OPSTRANSPORT.version = "0.9.0"

---Create a new OPSTRANSPORT class object. Essential input are the troops that should be transported and the zones where the troops are picked up and deployed.
---@param CargoGroups? SET_GROUP Groups to be transported as cargo. Can also be a single @{Wrapper.Group#GROUP} or @{Ops.OpsGroup#OPSGROUP} object.
---@param PickupZone? ZONE Pickup zone. This is the zone, where the carrier is going to pickup the cargo. **Important**: only cargo is considered, if it is in this zone when the carrier starts loading!
---@param DeployZone? ZONE Deploy zone. This is the zone, where the carrier is going to drop off the cargo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:New(CargoGroups, PickupZone, DeployZone) end

---Add pickup and deploy zone combination.
---@param CargoGroups? SET_GROUP Groups to be transported as cargo. Can also be a single @{Wrapper.Group#GROUP} or @{Ops.OpsGroup#OPSGROUP} object.
---@param PickupZone? ZONE Zone where the troops are picked up.
---@param DeployZone? ZONE Zone where the troops are picked up.
---@return OPSTRANSPORT.TransportZoneCombo # Transport zone table.
function OPSTRANSPORT:AddTransportZoneCombo(CargoGroups, PickupZone, DeployZone) end

---Add cargo groups to be transported.
---@param GroupSet? SET_GROUP Set of groups to be transported. Can also be passed as a single GROUP or OPSGROUP object.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@param DisembarkActivation? boolean (Optional) If `true`, cargo group is activated when disembarked. If `false`, cargo groups are late activated when disembarked. Default `nil` (usually activated).
---@param DisembarkZone? ZONE Zone where the groups disembark to.
---@param DisembarkCarriers? SET_OPSGROUP Carrier groups where the cargo directly disembarks to.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddCargoGroups(GroupSet, TransportZoneCombo, DisembarkActivation, DisembarkZone, DisembarkCarriers) end

---Add cargo warehouse storage to be transported. This adds items such as fuel, weapons and other equipment, which is to be transported
---from one DCS warehouse to another.
---For weapons and equipment, the weight per item has to be specified explicitly as these cannot be retrieved by the DCS API. For liquids the
---default value of 1 kg per item should be used as the amount of liquid is already given in kg.
---@param StorageFrom? STORAGE Storage warehouse from which the cargo is taken.
---@param StorageTo? STORAGE Storage warehouse to which the cargo is delivered.
---@param CargoType? string Type of cargo, *e.g.* `"weapons.bombs.Mk_84"` or liquid type as #number.
---@param CargoAmount? number Amount of cargo. Liquids in kg.
---@param CargoWeight? number (Optional) Weight of a single cargo item in kg. Default 1 kg.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string (Optional) Transport zone combo if other than default.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddCargoStorage(StorageFrom, StorageTo, CargoType, CargoAmount, CargoWeight, TransportZoneCombo) end

---Set pickup zone.
---@param PickupZone? ZONE Zone where the troops are picked up.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetPickupZone(PickupZone, TransportZoneCombo) end

---Get pickup zone.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return ZONE # Zone where the troops are picked up.
function OPSTRANSPORT:GetPickupZone(TransportZoneCombo) end

---Set deploy zone.
---@param DeployZone? ZONE Zone where the troops are deployed.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetDeployZone(DeployZone, TransportZoneCombo) end

---Get deploy zone.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return ZONE # Zone where the troops are deployed.
function OPSTRANSPORT:GetDeployZone(TransportZoneCombo) end

---Set embark zone.
---@param EmbarkZone? ZONE Zone where the troops are embarked.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetEmbarkZone(EmbarkZone, TransportZoneCombo) end

---Get embark zone.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return ZONE # Zone where the troops are embarked from.
function OPSTRANSPORT:GetEmbarkZone(TransportZoneCombo) end

---Set disembark zone.
---@param DisembarkZone? ZONE Zone where the troops are disembarked.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetDisembarkZone(DisembarkZone, TransportZoneCombo) end

---Get disembark zone.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return ZONE # Zone where the troops are disembarked to.
function OPSTRANSPORT:GetDisembarkZone(TransportZoneCombo) end

---Set activation status of group when disembarked from transport carrier.
---@param Active? boolean If `true` or `nil`, group is activated when disembarked. If `false`, group is late activated and needs to be activated manually.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetDisembarkActivation(Active, TransportZoneCombo) end

---Get disembark activation.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return boolean # If `true`, groups are spawned in late activated state.
function OPSTRANSPORT:GetDisembarkActivation(TransportZoneCombo) end

---Set/add transfer carrier(s). These are carrier groups, where the cargo is directly loaded into when disembarked.
---@param Carriers? SET_GROUP Carrier set. Can also be passed as a #GROUP, #OPSGROUP or #SET_OPSGROUP object.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetDisembarkCarriers(Carriers, TransportZoneCombo) end

---Set/add transfer carrier(s). These are carrier groups, where the cargo is directly loaded into when disembarked.
---@param Carriers? SET_GROUP Carrier set. Can also be passed as a #GROUP, #OPSGROUP or #SET_OPSGROUP object.
---@param Table? table the table to add.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:_AddDisembarkCarriers(Carriers, Table) end

---Get transfer carrier(s). These are carrier groups, where the cargo is directly loaded into when disembarked.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return table # Table of carrier OPS groups.
function OPSTRANSPORT:GetDisembarkCarriers(TransportZoneCombo) end

---Set if group remains *in utero* after disembarkment from carrier. Can be used to directly load the group into another carrier. Similar to disembark in late activated state.
---@param InUtero? boolean If `true` or `nil`, group remains *in utero* after disembarkment.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetDisembarkInUtero(InUtero, TransportZoneCombo) end

---Get disembark in utero.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return boolean # If `true`, groups stay in utero after disembarkment.
function OPSTRANSPORT:GetDisembarkInUtero(TransportZoneCombo) end

---Set pickup formation.
---@param Formation? number Pickup formation.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetFormationPickup(Formation, TransportZoneCombo) end

---Get pickup formation.
---@param OpsGroup? OPSGROUP
---@return string # Formation.
function OPSTRANSPORT:_GetFormationDefault(OpsGroup) end

---Get pickup formation.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@param OpsGroup? OPSGROUP
---@return number # Formation.
function OPSTRANSPORT:_GetFormationPickup(TransportZoneCombo, OpsGroup) end

---Set transport formation.
---@param Formation? number Pickup formation.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetFormationTransport(Formation, TransportZoneCombo) end

---Get transport formation.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@param OpsGroup? OPSGROUP
---@return number # Formation.
function OPSTRANSPORT:_GetFormationTransport(TransportZoneCombo, OpsGroup) end

---Set required cargo. This is a list of cargo groups that need to be loaded before the **first** transport will start.
---@param Cargos? SET_GROUP Required cargo set. Can also be passed as a #GROUP, #OPSGROUP or #SET_OPSGROUP object.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetRequiredCargos(Cargos, TransportZoneCombo) end

---Get required cargos. This is a list of cargo groups that need to be loaded before the **first** transport will start.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return table # Table of required cargo ops groups.
function OPSTRANSPORT:GetRequiredCargos(TransportZoneCombo) end

---Set number of required carrier groups for an OPSTRANSPORT assignment. Only used if transport is assigned at **LEGION** or higher level.
---@param NcarriersMin? number (Optional) Number of carriers *at least* required. Default 1.
---@param NcarriersMax? number (Optional) Number of carriers *at most* used for transportation. Default is same as `NcarriersMin`.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetRequiredCarriers(NcarriersMin, NcarriersMax) end

---Get the number of required carrier groups for an OPSTRANSPORT assignment. Only used if transport is assigned at **LEGION** or higher level.
---@return number # Number of carriers *at least* required.
---@return number # Number of carriers *at most* used for transportation.
function OPSTRANSPORT:GetRequiredCarriers() end

---Add a carrier assigned for this transport.
---@param CarrierGroup? OPSGROUP Carrier OPSGROUP.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:_AddCarrier(CarrierGroup) end

---Remove group from the current carrier list/table.
---@param CarrierGroup? OPSGROUP Carrier OPSGROUP.
---@param Delay? number Delay in seconds before the carrier is removed.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:_DelCarrier(CarrierGroup, Delay) end

---Get a list of alive carriers.
---@return table # Names of all carriers
function OPSTRANSPORT:_GetCarrierNames() end

---Get (all) cargo {Ops.OpsGroup#OPSGROUP}s. Optionally, only delivered or undelivered groups can be returned.
---@param Delivered? boolean If `true`, only delivered groups are returned. If `false` only undelivered groups are returned. If `nil`, all groups are returned.
---@param Carrier? OPSGROUP (Optional) Only count cargo groups that fit into the given carrier group. Current cargo is not a factor.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return table # Cargo Ops groups. Can be and empty table `{}`.
function OPSTRANSPORT:GetCargoOpsGroups(Delivered, Carrier, TransportZoneCombo) end

---Get (all) cargo {Ops.OpsGroup#OPSGROUP}s. Optionally, only delivered or undelivered groups can be returned.
---@param Delivered? boolean If `true`, only delivered groups are returned. If `false` only undelivered groups are returned. If `nil`, all groups are returned.
---@param Carrier? OPSGROUP (Optional) Only count cargo groups that fit into the given carrier group. Current cargo is not a factor.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return table # Cargo Ops groups. Can be and empty table `{}`.
function OPSTRANSPORT:GetCargoStorages(Delivered, Carrier, TransportZoneCombo) end

---Get carriers.
---@return table # Carrier Ops groups.
function OPSTRANSPORT:GetCarriers() end

---Get cargos.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@param Carrier? OPSGROUP Specific carrier.
---@param Delivered? boolean Delivered status.
---@return table # Cargos.
function OPSTRANSPORT:GetCargos(TransportZoneCombo, Carrier, Delivered) end

---Get total weight.
---@param Cargo? OPSGROUP.CargoGroup|number|string Cargo data.
---@param IncludeReserved? boolean Include reserved cargo.
---@return number # Weight in kg.
function OPSTRANSPORT:GetCargoTotalWeight(Cargo, IncludeReserved) end

---Set transport start and stop time.
---@param ClockStart? string (Optional) Time the transport is started, e.g. "05:00" for 5 am. If specified as a #number, it will be relative (in seconds) to the current mission time. Default is 5 seconds after mission was added.
---@param ClockStop? string (Optional) Time the transport is stopped, e.g. "13:00" for 1 pm. If mission could not be started at that time, it will be removed from the queue. If specified as a #number it will be relative (in seconds) to the current mission time.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetTime(ClockStart, ClockStop) end

---Set mission priority and (optional) urgency. Urgent missions can cancel other running missions.
---@param Prio? number (Optional) Priority 1=high, 100=low. Default 50.
---@param Importance? number (Optional) Number 1-10. If missions with lower value are in the queue, these have to be finished first. Default is `nil`.
---@param Urgent? boolean (Optional) If *true*, another running mission might be cancelled if it has a lower priority.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetPriority(Prio, Importance, Urgent) end

---Set verbosity.
---@param Verbosity? number (Optional) Be more verbose. Default 0
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetVerbosity(Verbosity) end

---Add start condition.
---@param ConditionFunction? function Function that needs to be true before the transport can be started. Must return a #boolean.
---@param ... any
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddConditionStart(ConditionFunction, ...) end

---Add path used for transportation from the pickup to the deploy zone.
---If multiple paths are defined, a random one is chosen. The path is retrieved from the waypoints of a given group.
---**NOTE** that the category group defines for which carriers this path is valid.
---For example, if you specify a GROUND group to provide the waypoints, only assigned GROUND carriers will use the
---path.
---@param PathGroup? GROUP A (late activated) GROUP defining a transport path by their waypoints.
---@param Reversed? any
---@param Radius? number (Optional) Randomization radius in meters. Default 0 m.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string (Optional) Transport Zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddPathTransport(PathGroup, Reversed, Radius, TransportZoneCombo) end

---Get a path for transportation.
---@param Category? any Group category.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport Zone combo.
---@return OPSTRANSPORT.Path # The path object.
function OPSTRANSPORT:_GetPathTransport(Category, TransportZoneCombo) end

---Add a carrier assigned for this transport.
---@param CarrierGroup? OPSGROUP Carrier OPSGROUP.
---@param Status? string Carrier Status.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetCarrierTransportStatus(CarrierGroup, Status) end

---Get carrier transport status.
---@param CarrierGroup? OPSGROUP Carrier OPSGROUP.
---@return string # Carrier status.
function OPSTRANSPORT:GetCarrierTransportStatus(CarrierGroup) end

---Get unique ID of the transport assignment.
---@return number # UID.
function OPSTRANSPORT:GetUID() end

---Get number of delivered cargo groups.
---@return number # Total number of delivered cargo groups.
function OPSTRANSPORT:GetNcargoDelivered() end

---Get number of cargo groups.
---@return number # Total number of cargo groups.
function OPSTRANSPORT:GetNcargoTotal() end

---Get number of carrier groups assigned for this transport.
---@return number # Total number of carrier groups.
function OPSTRANSPORT:GetNcarrier() end

---Add carrier asset to transport.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset to be added.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddAsset(Asset, TransportZoneCombo) end

---Delete carrier asset from transport.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset to be removed.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:DelAsset(Asset) end

---Add cargo asset.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset to be added.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddAssetCargo(Asset, TransportZoneCombo) end

---Get transport zone combo of cargo group.
---@param GroupName? string Group name of cargo.
---@return OPSTRANSPORT.TransportZoneCombo # TransportZoneCombo Transport zone combo.
function OPSTRANSPORT:GetTZCofCargo(GroupName) end

---Add LEGION to the transport.
---@param Legion? LEGION The legion.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:AddLegion(Legion) end

---Remove LEGION from transport.
---@param Legion? LEGION The legion.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:RemoveLegion(Legion) end

---Check if an OPS group is assigned as carrier for this transport.
---@param CarrierGroup? OPSGROUP Potential carrier OPSGROUP.
---@return boolean # If true, group is an assigned carrier.
function OPSTRANSPORT:IsCarrier(CarrierGroup) end

---Check if transport is ready to be started.
---* Start time passed.
---* Stop time did not pass already.
---* All start conditions are true.
---@return boolean # If true, mission can be started.
function OPSTRANSPORT:IsReadyToGo() end

---Set LEGION transport status.
---@param Legion? LEGION The legion.
---@param Status? string New status.
---@return OPSTRANSPORT # self
function OPSTRANSPORT:SetLegionStatus(Legion, Status) end

---Get LEGION transport status.
---@param Legion? LEGION The legion.
---@return string # status Current status.
function OPSTRANSPORT:GetLegionStatus(Legion) end

---Check if state is PLANNED.
---@return boolean # If true, status is PLANNED.
function OPSTRANSPORT:IsPlanned() end

---Check if state is QUEUED.
---@param Legion? LEGION (Optional) Check if transport is queued at this legion.
---@return boolean # If true, status is QUEUED.
function OPSTRANSPORT:IsQueued(Legion) end

---Check if state is REQUESTED.
---@param Legion? LEGION (Optional) Check if transport is queued at this legion.
---@return boolean # If true, status is REQUESTED.
function OPSTRANSPORT:IsRequested(Legion) end

---Check if state is SCHEDULED.
---@return boolean # If true, status is SCHEDULED.
function OPSTRANSPORT:IsScheduled() end

---Check if state is EXECUTING.
---@return boolean # If true, status is EXECUTING.
function OPSTRANSPORT:IsExecuting() end

---Check if all cargo was delivered (or is dead).
---@param Nmin? number (Optional) Number of groups that must be actually delivered (and are not dead). Default 0.
---@return boolean # If true, all possible cargo was delivered.
function OPSTRANSPORT:IsDelivered(Nmin) end

---On after "StatusUpdate" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterStatusUpdate(From, Event, To) end

---Check if a cargo group was delivered.
---@param GroupName? string Name of the group.
---@return boolean # If `true`, cargo was delivered.
function OPSTRANSPORT:IsCargoDelivered(GroupName) end

---On after "Planned" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterPlanned(From, Event, To) end

---On after "Scheduled" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterScheduled(From, Event, To) end

---On after "Executing" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterExecuting(From, Event, To) end

---On before "Delivered" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onbeforeDelivered(From, Event, To) end

---On after "Delivered" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterDelivered(From, Event, To) end

---On after "Loaded" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroupCargo? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement? OPSGROUP.Element|number|string Carrier element.
function OPSTRANSPORT:onafterLoaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---On after "Unloaded" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroupCargo? OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier? OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:onafterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier) end

---On after "DeadCarrierGroup" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP Carrier OPSGROUP that is dead.
function OPSTRANSPORT:onafterDeadCarrierGroup(From, Event, To, OpsGroup) end

---On after "DeadCarrierAll" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterDeadCarrierAll(From, Event, To) end

---On after "Cancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:onafterCancel(From, Event, To) end

---Check if all cargo of this transport assignment was delivered.
function OPSTRANSPORT:_CheckDelivered() end

---Check if all required cargos are loaded.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@param CarrierGroup? OPSGROUP The carrier group asking.
---@return boolean # If true, all required cargos are loaded or there is no required cargo or asking carrier is full.
function OPSTRANSPORT:_CheckRequiredCargos(TransportZoneCombo, CarrierGroup) end

---Check if all given condition are true.
---@param Conditions? table Table of conditions.
---@return boolean # If true, all conditions were true. Returns false if at least one condition returned false.
function OPSTRANSPORT:EvalConditionsAll(Conditions) end

---Find transfer carrier element for cargo group.
---@param CargoGroup? OPSGROUP The cargo group that needs to be loaded into a carrier unit/element of the carrier group.
---@param Zone? ZONE (Optional) Zone where the carrier must be in.
---@param DisembarkCarriers? table Disembark carriers.
---@param DeployAirbase? AIRBASE Airbase where to deploy.
---@return OPSGROUP.Element # New carrier element for cargo or nil.
---@return OPSGROUP # New carrier group for cargo or nil.
function OPSTRANSPORT:FindTransferCarrierForCargo(CargoGroup, Zone, DisembarkCarriers, DeployAirbase) end

---Create a cargo group data structure.
---@param group? GROUP The GROUP or OPSGROUP object.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@param DisembarkActivation? boolean If `true`, cargo group is activated when disembarked.
---@param DisembarkZone? ZONE Disembark zone, where the cargo is spawned when delivered.
---@param DisembarkCarriers? SET_OPSGROUP Disembark carriers cargo is directly loaded into when delivered.
---@return OPSGROUP.CargoGroup # Cargo group data.
function OPSTRANSPORT:_CreateCargoGroupData(group, TransportZoneCombo, DisembarkActivation, DisembarkZone, DisembarkCarriers) end

---Create a cargo group data structure.
---@param StorageFrom? STORAGE Storage from.
---@param StorageTo? STORAGE Storage to.
---@param CargoType? string Type of cargo.
---@param CargoAmount? number Total amount of cargo that should be transported. Liquids in kg.
---@param CargoWeight? number (Optional) Weight of a single cargo item in kg. Default 1 kg.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return OPSGROUP.CargoGroup # Cargo group data.
function OPSTRANSPORT:_CreateCargoStorage(StorageFrom, StorageTo, CargoType, CargoAmount, CargoWeight, TransportZoneCombo) end

---Count how many cargo groups are inside a zone.
---@param Zone? ZONE The zone object.
---@param Delivered? boolean If `true`, only delivered groups are returned. If `false` only undelivered groups are returned. If `nil`, all groups are returned.
---@param Carrier? OPSGROUP (Optional) Only count cargo groups that fit into the given carrier group. Current cargo is not a factor.
---@param TransportZoneCombo? OPSTRANSPORT.TransportZoneCombo|number|string Transport zone combo.
---@return number # Number of cargo groups.
function OPSTRANSPORT:_CountCargosInZone(Zone, Delivered, Carrier, TransportZoneCombo) end

---Get a transport zone combination (TZC) for a carrier group. The pickup zone will be a zone, where the most cargo groups are located that fit into the carrier.
---@param Carrier? OPSGROUP The carrier OPS group.
---@return ZONE # Pickup zone or `#nil`.
function OPSTRANSPORT:_GetTransportZoneCombo(Carrier) end

---Get an OPSGROUP from a given OPSGROUP or GROUP object. If the object is a GROUP, an OPSGROUP is created automatically.
---@param Object? BASE The object, which can be a GROUP or OPSGROUP.
---@return OPSGROUP # Ops Group.
function OPSTRANSPORT:_GetOpsGroupFromObject(Object) end

---Triggers the FSM event "StatusUpdate".
function OPSTRANSPORT:StatusUpdate() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__StatusUpdate(delay) end

---Triggers the FSM event "Planned".
function OPSTRANSPORT:Planned() end

---Triggers the FSM event "Planned" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Planned(delay) end

---On after "Planned" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterPlanned(From, Event, To) end

---Triggers the FSM event "Queued".
function OPSTRANSPORT:Queued() end

---Triggers the FSM event "Queued" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Queued(delay) end

---On after "Queued" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterQueued(From, Event, To) end

---Triggers the FSM event "Requested".
function OPSTRANSPORT:Requested() end

---Triggers the FSM event "Requested" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Requested(delay) end

---On after "Requested" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterRequested(From, Event, To) end

---Triggers the FSM event "Scheduled".
function OPSTRANSPORT:Scheduled() end

---Triggers the FSM event "Scheduled" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Scheduled(delay) end

---On after "Scheduled" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterScheduled(From, Event, To) end

---Triggers the FSM event "Executing".
function OPSTRANSPORT:Executing() end

---Triggers the FSM event "Executing" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Executing(delay) end

---On after "Executing" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterExecuting(From, Event, To) end

---Triggers the FSM event "Delivered".
function OPSTRANSPORT:Delivered() end

---Triggers the FSM event "Delivered" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Delivered(delay) end

---On after "Delivered" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterDelivered(From, Event, To) end

---Triggers the FSM event "Cancel".
function OPSTRANSPORT:Cancel() end

---Triggers the FSM event "Cancel" after a delay.
---@param delay? number Delay in seconds.
function OPSTRANSPORT:__Cancel(delay) end

---On after "Cancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPSTRANSPORT:OnAfterCancel(From, Event, To) end

---Triggers the FSM event "Loaded".
---@param OpsGroupCargo? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement? OPSGROUP.Element|number|string Carrier element.
function OPSTRANSPORT:Loaded(OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---Triggers the FSM event "Loaded" after a delay.
---@param delay? number Delay in seconds.
---@param OpsGroupCargo? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement? OPSGROUP.Element|number|string Carrier element.
function OPSTRANSPORT:__Loaded(delay, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---On after "Loaded" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroupCargo? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param OpsGroupCarrier? OPSGROUP OPSGROUP that was loaded into a carrier.
---@param CarrierElement? OPSGROUP.Element|number|string Carrier element.
function OPSTRANSPORT:OnAfterLoaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---Triggers the FSM event "Unloaded".
---@param OpsGroupCargo? OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier? OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:Unloaded(OpsGroupCargo, OpsGroupCarrier) end

---Triggers the FSM event "Unloaded" after a delay.
---@param delay? number Delay in seconds.
---@param OpsGroupCargo? OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier? OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:__Unloaded(delay, OpsGroupCargo, OpsGroupCarrier) end

---On after "Unloaded" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroupCargo? OPSGROUP Cargo OPSGROUP that was unloaded from a carrier.
---@param OpsGroupCarrier? OPSGROUP Carrier OPSGROUP that unloaded the cargo.
function OPSTRANSPORT:OnAfterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier) end
