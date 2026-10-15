---@meta

---COHORT class.
---@class COHORT : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field name string Name of the cohort.
---@field templatename string Name of the template group.
---@field aircrafttype string Type of the units the cohort is using.
---@field category number Group category of the assets: `Group.Category.AIRPLANE`, `Group.Category.HELICOPTER`, `Group.Category.GROUND`, `Group.Category.SHIP`, `Group.Category.TRAIN`.
---@field templategroup GROUP Template group.
---@field isAir boolean
---@field isGround boolean Is ground.
---@field isNaval boolean Is naval.
---@field assets table Cohort assets.
---@field missiontypes table Capabilities (mission types and performances) of the cohort.
---@field maintenancetime number Time in seconds needed for maintenance of a returned flight.
---@field repairtime number Time in seconds for each
---@field livery string Livery of the cohort.
---@field skill number Skill of cohort members.
---@field legion LEGION The LEGION object the cohort belongs to.
---@field Ngroups number Number of asset OPS groups this cohort has.
---@field Nkilled number Number of destroyed asset groups.
---@field engageRange number Mission range in meters.
---@field attribute string Generalized attribute of the cohort template group.
---@field descriptors table DCS descriptors.
---@field properties table DCS attributes.
---@field tacanChannel table List of TACAN channels available to the cohort.
---@field radioFreq number Radio frequency in MHz the cohort uses.
---@field radioModu number Radio modulation the cohort uses.
---@field tacanChannel table List of TACAN channels available to the cohort.
---@field weightAsset number Weight of one assets group in kg.
---@field cargobayLimit number Cargo bay capacity in kg.
---@field operations table Operations this cohort is part of.
COHORT = {
  ClassName      = "COHORT",
  verbose        =     0,
  lid            =   nil,
  name           =   nil,
  templatename   =   nil,
  assets         =    {},
  missiontypes   =    {},
  repairtime     =     0,
  maintenancetime=     0,
  livery         =   nil,
  skill          =   nil,
  legion         =   nil,
  Ngroups        =     0,
  engageRange    =   nil,
  tacanChannel   =    {},
  weightAsset    = 99999,
  cargobayLimit  =     0,
  descriptors    =    {},
  properties     =    {},
  operations     =    {},
}

---COHORT class version.
COHORT.version = "0.3.7"

---Create a new COHORT object and start the FSM.
---@param TemplateGroupName? string Name of the template group.
---@param Ngroups? number (Optional) Number of asset groups of this Cohort. Default 3.
---@param CohortName? string (Optional) Name of the cohort. Defaults to TemplateGroupName.
---@return COHORT # self
function COHORT:New(TemplateGroupName, Ngroups, CohortName) end

---Set livery painted on all cohort units.
---Note that the livery name in general is different from the name shown in the mission editor.
---
---Valid names are the names of the **livery directories**. Check out the folder in your DCS installation for:
---
---* Full modules: `DCS World OpenBeta\CoreMods\aircraft\<Aircraft Type>\Liveries\<Aircraft Type>\<Livery Name>`
---* AI units: `DCS World OpenBeta\Bazar\Liveries\<Aircraft Type>\<Livery Name>`
---
---The folder name `<Livery Name>` is the string you want.
---
---Or personal liveries you have installed somewhere in your saved games folder.
---@param LiveryName? string Name of the livery.
---@return COHORT # self
function COHORT:SetLivery(LiveryName) end

---Set skill level of all cohort team members.
---@param Skill? string Skill of all flights.
---@return COHORT # self
function COHORT:SetSkill(Skill) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return COHORT # self
function COHORT:SetVerbosity(VerbosityLevel) end

---Set turnover and repair time. If an asset returns from a mission, it will need some time until the asset is available for further missions.
---@param MaintenanceTime? number (Optional) Time in minutes it takes until a flight is combat ready again. Default is 0 min.
---@param RepairTime? number (Optional) Time in minutes it takes to repair a flight for each life point taken. Default is 0 min.
---@return COHORT # self
function COHORT:SetTurnoverTime(MaintenanceTime, RepairTime) end

---Set radio frequency and modulation the cohort uses.
---@param Frequency? number (Optional) Radio frequency in MHz. Default 251 MHz.
---@param Modulation? number (Optional) Radio modulation. Default 0=AM.
---@return COHORT # self
function COHORT:SetRadio(Frequency, Modulation) end

---Set number of units in groups.
---@param nunits? number (Optional) Number of units. Default 2.
---@return COHORT # self
function COHORT:SetGrouping(nunits) end

---Set mission types this cohort is able to perform.
---@param MissionTypes? table Table of mission types. Can also be passed as a #string if only one type.
---@param Performance? number (Optional) Performance describing how good this mission can be performed. Higher is better. Default 50. Max 100.
---@return COHORT # self
function COHORT:AddMissionCapability(MissionTypes, Performance) end

---Get missin capability for a given mission type.
---@param MissionType? string Mission type, e.g. `AUFTRAG.Type.BAI`.
---@return AUFTRAG.Capability # Capability table or `nil` if the capability does not exist.
function COHORT:GetMissionCapability(MissionType) end

---Check if cohort assets have a given property (DCS attribute).
---@param Property? string The property.
---@return boolean # If `true`, cohort assets have the attribute.
function COHORT:HasProperty(Property) end

---Get mission types this cohort is able to perform.
---@return table # Table of mission types. Could be empty {}.
function COHORT:GetMissionTypes() end

---Get mission capabilities of this cohort.
---@return table # Table of mission capabilities.
function COHORT:GetMissionCapabilities() end

---Get mission performance for a given type of misson.
---@param MissionType? string Type of mission.
---@return number # Performance or -1.
function COHORT:GetMissionPeformance(MissionType) end

---Set max mission range. Only missions in a circle of this radius around the cohort base are executed.
---@param Range? number (Optional) Range in NM. Default 150 NM.
---@return COHORT # self
function COHORT:SetMissionRange(Range) end

---Set call sign.
---@param Callsign? number Callsign from CALLSIGN.Aircraft, e.g. "Chevy" for CALLSIGN.Aircraft.CHEVY.
---@param Index? number Callsign index, Chevy-**1**.
---@param CallsignString? string (optional) Set this for tasks like TANKER, AWACS or KIOWA and the like, which have special names. E.g. "Darkstar" or "Roughneck".
---@return COHORT # self
function COHORT:SetCallsign(Callsign, Index, CallsignString) end

---Set generalized attribute.
---@param Attribute? string Generalized attribute, e.g. `GROUP.Attribute.Ground_Infantry`.
---@return COHORT # self
function COHORT:SetAttribute(Attribute) end

---Get generalized attribute.
---@return string # Generalized attribute, e.g. `GROUP.Attribute.Ground_Infantry`.
function COHORT:GetAttribute() end

---Get group category.
---@return string # Group category
function COHORT:GetCategory() end

---Get properties, *i.e.* DCS attributes.
---@return table # Properties table.
function COHORT:GetProperties() end

---Set modex.
---@param Modex? number A number like 100.
---@param Prefix? string A prefix string, which is put before the `Modex` number.
---@param Suffix? string A suffix string, which is put after the `Modex` number.
---@return COHORT # self
function COHORT:SetModex(Modex, Prefix, Suffix) end

---Set Legion.
---@param Legion? LEGION The Legion.
---@return COHORT # self
function COHORT:SetLegion(Legion) end

---Add asset to cohort.
---@param Asset? WAREHOUSE.Assetitem|number|string The warehouse asset.
---@return COHORT # self
function COHORT:AddAsset(Asset) end

---Remove specific asset from chort.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset.
---@return COHORT # self
function COHORT:DelAsset(Asset) end

---Remove asset group from cohort.
---@param GroupName? string Name of the asset group.
---@return COHORT # self
function COHORT:DelGroup(GroupName) end

---Remove assets from pool. Not that assets must not be spawned or already reserved or requested.
---@param N? number (Optional) Number of assets to be removed. Default 1.
---@param Delay? number (Optional) Delay in seconds before assets are removed. Defaults to 0.
---@return COHORT # self
function COHORT:RemoveAssets(N, Delay) end

---Get name of the cohort.
---@return string # Name of the cohort.
function COHORT:GetName() end

---Get radio frequency and modulation.
---@return number # Radio frequency in MHz.
---@return number # Radio Modulation (0=AM, 1=FM).
function COHORT:GetRadio() end

---Create a callsign for the asset.
---@param Asset? WAREHOUSE.Assetitem|number|string The warehouse asset.
---@return COHORT # self
function COHORT:GetCallsign(Asset) end

---Create a modex for the asset.
---@param Asset? WAREHOUSE.Assetitem|number|string The warehouse asset.
---@return COHORT # self
function COHORT:GetModex(Asset) end

---Add TACAN channels to the cohort. Note that channels can only range from 1 to 126.
---@param ChannelMin? number Channel.
---@param ChannelMax? number Channel.
---@return COHORT # self
function COHORT:AddTacanChannel(ChannelMin, ChannelMax) end

---Get an unused TACAN channel.
---@return number # TACAN channel or *nil* if no channel is free.
function COHORT:FetchTacan() end

---"Return" a used TACAN channel.
---@param channel? number The channel that is available again.
function COHORT:ReturnTacan(channel) end

---Add a weapon range for ARTY missions ({Ops.Auftrag#AUFTRAG}).
---@param RangeMin? number (Optional) Minimum range in nautical miles. Default 0 NM.
---@param RangeMax? number (Optional) Maximum range in nautical miles. Default 10 NM.
---@param BitType? number (Optional) Bit mask of weapon type for which the given min/max ranges apply. Default is `ENUMS.WeaponFlag.Auto`, i.e. for all weapon types.
---@return COHORT # self
function COHORT:AddWeaponRange(RangeMin, RangeMax, BitType) end

---Get weapon range for given bit type.
---@param BitType? number Bit mask of weapon type.
---@return OPSGROUP.WeaponData # Weapon data.
function COHORT:GetWeaponData(BitType) end

---Check if cohort is "OnDuty".
---@return boolean # If true, cohort is in state "OnDuty".
function COHORT:IsOnDuty() end

---Check if cohort is "Stopped".
---@return boolean # If true, cohort is in state "Stopped".
function COHORT:IsStopped() end

---Check if cohort is "Paused".
---@return boolean # If true, cohort is in state "Paused".
function COHORT:IsPaused() end

---Check if cohort is "Relocating".
---@return boolean # If true, cohort is relocating.
function COHORT:IsRelocating() end

---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COHORT:onafterStart(From, Event, To) end

---Check asset status.
function COHORT:_CheckAssetStatus() end

---On after "Stop" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COHORT:onafterStop(From, Event, To) end

---Check if there is a cohort that can execute a given mission.
---We check the mission type, the refuelling system, mission range.
---@param Mission? AUFTRAG The mission.
---@return boolean # If true, Cohort can do that type of mission.
function COHORT:CanMission(Mission) end

---Count assets in legion warehouse stock.
---@param InStock? boolean If `true`, only assets that are in the warehouse stock/inventory are counted. If `false`, only assets that are NOT in stock (i.e. spawned) are counted. If `nil`, all assets are counted.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return number # Number of assets.
function COHORT:CountAssets(InStock, MissionTypes, Attributes) end

---Get OPSGROUPs.
---@param MissionTypes? table (Optional) Count only assest that can perform certain mission type(s). Default is all types.
---@param Attributes? table (Optional) Count only assest that have a certain attribute(s), e.g. `WAREHOUSE.Attribute.AIR_BOMBER`.
---@return SET_OPSGROUP # Ops groups set.
function COHORT:GetOpsGroups(MissionTypes, Attributes) end

---Get assets for a mission.
---@param MissionType? string Mission type.
---@param Npayloads? number Number of payloads available.
---@return table # Assets that can do the required mission.
---@return number # Number of payloads still available after recruiting the assets.
function COHORT:RecruitAssets(MissionType, Npayloads) end

---Get the time an asset needs to be repaired.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset.
---@return number # Time in seconds until asset is repaired.
function COHORT:GetRepairTime(Asset) end

---Get max mission range. We add the largest weapon range, e.g. for arty or naval if weapon data is available.
---@param WeaponTypes? table (Optional) Weapon bit type(s) to add to the total range. Default is the max weapon type available.
---@return number # Range in meters.
function COHORT:GetMissionRange(WeaponTypes) end

---Checks if a mission type is contained in a table of possible types.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset.
---@return boolean # If true, the requested mission type is part of the possible mission types.
function COHORT:IsRepaired(Asset) end

---Check if the cohort attribute matches the given attribute(s).
---@param Attributes? table The requested attributes. See `WAREHOUSE.Attribute` enum. Can also be passed as a single attribute `#string`.
---@return boolean # If true, the cohort has the requested attribute.
function COHORT:CheckAttribute(Attributes) end

---Check ammo.
---@return OPSGROUP.Ammo # Ammo.
function COHORT:_CheckAmmo() end

---Returns a name of a missile category.
---@param categorynumber? number Number of missile category from weapon missile category enumerator. See https://wiki.hoggitworld.com/view/DCS_Class_Weapon
---@return string # Missile category name.
function COHORT:_MissileCategoryName(categorynumber) end

---Add an OPERATION.
---@param Operation? OPERATION The operation this cohort is part of.
---@return COHORT # self
function COHORT:_AddOperation(Operation) end

---Triggers the FSM event "Start". Starts the COHORT.
function COHORT:Start() end

---Triggers the FSM event "Start" after a delay. Starts the COHORT.
---@param delay? number Delay in seconds.
function COHORT:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the COHORT and all its event handlers.
---@param delay? number Delay in seconds.
function COHORT:__Stop(delay) end

---Triggers the FSM event "Status".
function COHORT:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function COHORT:__Status(delay) end

---Triggers the FSM event "Pause".
function COHORT:Pause() end

---Triggers the FSM event "Pause" after a delay.
---@param delay? number Delay in seconds.
function COHORT:__Pause(delay) end

---On after "Pause" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COHORT:OnAfterPause(From, Event, To) end

---Triggers the FSM event "Unpause".
function COHORT:Unpause() end

---Triggers the FSM event "Unpause" after a delay.
---@param delay? number Delay in seconds.
function COHORT:__Unpause(delay) end

---On after "Unpause" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COHORT:OnAfterUnpause(From, Event, To) end

---Triggers the FSM event "Relocate".
function COHORT:Relocate() end

---Triggers the FSM event "Relocate" after a delay.
---@param delay? number Delay in seconds.
function COHORT:__Relocate(delay) end

---On after "Relocate" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COHORT:OnAfterRelocate(From, Event, To) end

---Triggers the FSM event "Relocated".
function COHORT:Relocated() end

---Triggers the FSM event "Relocated" after a delay.
---@param delay? number Delay in seconds.
function COHORT:__Relocated(delay) end

---On after "Relocated" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function COHORT:OnAfterRelocated(From, Event, To) end
