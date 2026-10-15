---@meta

---@class CTLD.Buildable
---@field Name string Name of the object.
---@field Required number Required crates.
---@field Found number Found crates.
---@field Template table Template names for this build.
---@field CanBuild boolean Is buildable or not.
---@field Type CTLD_CARGO.Enum Type enumerator (for moves).

---@class CTLD.CargoZone
---@field name string Name of Zone.
---@field color string Smoke color for zone, e.g. SMOKECOLOR.Red.
---@field active boolean Active or not.
---@field type string Type of zone, i.e. load,drop,move,ship
---@field hasbeacon boolean Create and run radio beacons if active.
---@field fmbeacon table Beacon info as #CTLD.ZoneBeacon
---@field uhfbeacon table Beacon info as #CTLD.ZoneBeacon
---@field vhfbeacon table Beacon info as #CTLD.ZoneBeacon
---@field shiplength number For ships - length of ship
---@field shipwidth number For ships - width of ship
---@field timestamp number For dropped beacons - time this was created

---@class CTLD.LoadedCargo
---@field Troopsloaded number
---@field Cratesloaded number
---@field Cargo table Table of #CTLD_CARGO objects

---@class CTLD.ZoneBeacon
---@field name string -- Name of zone for the coordinate
---@field frequency number -- in mHz
---@field modulation number -- i.e.CTLD.RadioModulation.FM or CTLD.RadioModulation.AM

---**CTLD** class, extends Core.Base#BASE, Core.Fsm#FSM
---@class CTLD : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field coalition number Coalition side number, e.g. `coalition.side.RED`.
---@field debug boolean
CTLD = {
  ClassName       = "CTLD",
  verbose         = 0,
  lid             = "",
  coalition       = 1,
  coalitiontxt    = "blue",
  PilotGroups = {}, -- #GROUP_SET of heli pilots
  CtldUnits = {},   -- Table of helicopter #GROUPs
  FreeVHFFrequencies = {}, -- Table of VHF
  FreeUHFFrequencies = {}, -- Table of UHF
  FreeFMFrequencies = {}, -- Table of FM
  CargoCounter = 0,
  Cargo_Troops = {}, -- generic troops objects
  Cargo_Crates = {}, -- generic crate objects
  Loaded_Cargo = {}, -- cargo aboard units
  Spawned_Crates = {}, -- Holds objects for crates spawned generally
  Spawned_Cargo = {}, -- Binds together spawned_crates and their CTLD_CARGO objects
  CrateDistance = 35, -- list crates in this radius
  PackDistance = 35,  -- pack crates in this radius
  debug = false,
  wpZones = {},
  dropOffZones = {},
  pickupZones  = {},
  DynamicCargo = {},
  UseC130DynamicCargoAutoBuild = false,
  C130DynamicCargoAutoBuildMergeSeconds = 0,
  ChinookTroopCircleRadius = 5,
  TroopUnloadDistGround = 5,
  TroopUnloadDistGroundHerc = 25,
  TroopUnloadDistGroundHook = 15,
  TroopUnloadDistHoverHook = 5,
  TroopUnloadDistHover = 1.5,
  UserSetGroup = nil,
  LoadedGroupsTable = {},
  keeploadtable = true,
  allowCATransport = false,
  VehicleMoveFormation = AI.Task.VehicleFormation.VEE,
  locale = "en",
  usesrs = false
}

---Radio Modulation
---@class CTLD.RadioModulation
---@field AM number
---@field FM number
CTLD.RadioModulation = {
  AM = 0,
  FM = 1,
}

---Zone Type Info.
---@class CTLD.CargoZoneType
CTLD.CargoZoneType = {
  LOAD = "load",
  DROP = "drop",
  MOVE = "move",
  SHIP = "ship",
  BEACON = "beacon",
}

---Unit capabilities.
---@class CTLD.UnitTypeCapabilities
---@field type string Unit type.
---@field crates boolean Can transport crate.
---@field troops boolean Can transport troops.
---@field cratelimit number Number of crates transportable.
---@field trooplimit number Number of troop units transportable.
---@field cargoweightlimit number Max loadable kgs of cargo.
CTLD.UnitTypeCapabilities = {
    ["SA342Mistral"] = {type="SA342Mistral", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 12, cargoweightlimit = 400},
    ["SA342L"] = {type="SA342L", crates=false, troops=true, cratelimit = 0, trooplimit = 2, length = 12, cargoweightlimit = 400},
    ["SA342M"] = {type="SA342M", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 12, cargoweightlimit = 400},
    ["SA342Minigun"] = {type="SA342Minigun", crates=false, troops=true, cratelimit = 0, trooplimit = 2, length = 12, cargoweightlimit = 400},
    ["UH-1H"] = {type="UH-1H", crates=true, troops=true, cratelimit = 1, trooplimit = 8, length = 15, cargoweightlimit = 700},
    ["Mi-8MTV2"] = {type="Mi-8MTV2", crates=true, troops=true, cratelimit = 2, trooplimit = 12, length = 15, cargoweightlimit = 3000},
    ["Mi-8MT"] = {type="Mi-8MT", crates=true, troops=true, cratelimit = 2, trooplimit = 12, length = 15, cargoweightlimit = 3000},
    ["Ka-50"] = {type="Ka-50", crates=false, troops=false, cratelimit = 0, trooplimit = 0, length = 15, cargoweightlimit = 0},
    ["Ka-50_3"] = {type="Ka-50_3", crates=false, troops=false, cratelimit = 0, trooplimit = 0, length = 15, cargoweightlimit = 0},
    ["Mi-24P"] = {type="Mi-24P", crates=true, troops=true, cratelimit = 2, trooplimit = 8, length = 18, cargoweightlimit = 700},
    ["Mi-24V"] = {type="Mi-24V", crates=true, troops=true, cratelimit = 2, trooplimit = 8, length = 18, cargoweightlimit = 700},
    ["Hercules"] = {type="Hercules", crates=true, troops=true, cratelimit = 7, trooplimit = 64, length = 25, cargoweightlimit = 19000}, -- 19t cargo, 64 paratroopers.
    ["C-130J-30"] = {type="C-130J-30", crates=true, troops=true, cratelimit = 7, trooplimit = 64, length = 35, cargoweightlimit = 21500}, -- 19t cargo, 64 paratroopers. 
    ["UH-60L"] = {type="UH-60L", crates=true, troops=true, cratelimit = 2, trooplimit = 20, length = 16, cargoweightlimit = 3500}, -- 4t cargo, 20 (unsec) seats
    ["UH-60L_DAP"] = {type="UH-60L_DAP", crates=false, troops=true, cratelimit = 2, trooplimit = 2, length = 16, cargoweightlimit = 3500}, -- UH-60L DAP is an attack helo but can do limited CSAR and CTLD
    ["MH-60R"] = {type="MH-60R", crates=true, troops=true, cratelimit = 2, trooplimit = 20, length = 16, cargoweightlimit = 3500}, -- 4t cargo, 20 (unsec) seats
    ["SH-60B"] = {type="SH-60B", crates=true, troops=true, cratelimit = 2, trooplimit = 20, length = 16, cargoweightlimit = 3500}, -- 4t cargo, 20 (unsec) seats
    ["AH-64D_BLK_II"] = {type="AH-64D_BLK_II", crates=false, troops=true, cratelimit = 0, trooplimit = 2, length = 17, cargoweightlimit = 200}, -- 2 ppl **outside** the helo
    ["Bronco-OV-10A"] = {type="Bronco-OV-10A", crates= false, troops=true, cratelimit = 0, trooplimit = 5, length = 13, cargoweightlimit = 1450},
    ["AH-6J"] = {type="AH-6J", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 7, cargoweightlimit = 550},
    ["MH-6J"] = {type="MH-6J", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 7, cargoweightlimit = 550},
    ["OH-6A"] = {type="OH-6A", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 7, cargoweightlimit = 550},
    ["OH58D"] = {type="OH58D", crates=false, troops=false, cratelimit = 0, trooplimit = 0, length = 14, cargoweightlimit = 400},
    ["CH-47Fbl1"] = {type="CH-47Fbl1", crates=true, troops=true, cratelimit = 4, trooplimit = 31, length = 20, cargoweightlimit = 10800},
    ["MosquitoFBMkVI"] = {type="MosquitoFBMkVI", crates= true, troops=false, cratelimit = 2, trooplimit = 0, length = 13, cargoweightlimit = 1800},
    ["M 818"] = {type="M 818", crates= true, troops=true, cratelimit = 4, trooplimit = 12, length = 9, cargoweightlimit = 4500},
}

---Allowed Fixed Wing Types
---@class CTLD.FixedWingTypes
CTLD.FixedWingTypes = {
  ["Hercules"] = "Hercules",
  ["Bronco"] = "Bronco",
  ["Mosquito"] = "Mosquito",
  ["C-130J-30"] = "C-130J-30",
}

---CTLD class version.
CTLD.version = "1.4.45"

---Instantiate a new CTLD.
---@param Coalition? string Coalition of this CTLD. I.e. coalition.side.BLUE or coalition.side.RED or coalition.side.NEUTRAL
---@param Prefixes? table Table of pilot prefixes.
---@param Alias? string Alias of this CTLD for logging.
---@return CTLD # self
function CTLD:New(Coalition, Prefixes, Alias) end

---[Internal] Init localization
---@return CTLD # self
function CTLD:_InitLocalization() end

---[User] Set a resolver used to select a CTLD locale for group-specific menus and messages.
---Supported locales: "en", "de", "fr", "es", "it", "pt-br", "ru", "tr", "zh-cn", "zh-tw".
---If unset, CTLD keeps using `self.locale` as before.
---@param Resolver? function Function called as `Resolver(self, Group)` and expected to return a locale string.
---@return CTLD # self
function CTLD:SetGroupLocaleResolver(Resolver) end

---(Internal) Resolve the locale to use for a group-specific CTLD interaction.
---@param Group? GROUP Group object.
---@return string # Locale string.
function CTLD:_GetLocaleForGroup(Group) end

---(Internal) Resolve a localized text entry for a group-specific CTLD interaction.
---@param ID? string Translation entry ID.
---@param Group? GROUP Group object.
---@return string # Localized text entry.
function CTLD:_GetEntryForGroup(ID, Group) end

---@param Count? any
---@param Kind? any
---@param Group? any
function CTLD:_GetMenuPluralSuffix(Count, Kind, Group) end

---[User] Set SRS TTS details - see {Sound.SRS} for details.`SetSRS()` will try to use as many attributes configured with {Sound.SRS#MSRS.LoadConfigFile}() as possible.
---@param Frequency? number Frequency to be used. Can also be given as a table of multiple frequencies, e.g. 30 or {30,124.5}. Defaults to {30,124.5}. There needs to be exactly the same number of modulations!
---@param Modulation? number Modulation to be used. Can also be given as a table of multiple modulations, e.g. radio.modulation.AM or {radio.modulation.FM,radio.modulation.AM}. There needs to be exactly the same number of frequencies!
---@param PathToSRS? string Defaults to "C:\\Program Files\\DCS-SimpleRadio-Standalone\\ExternalAudio"
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS. Or Piper voice types with HOUND backend.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest)
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS; if you use a config file for MSRS, hand in nil here.
---@param AccessKey? string (Optional) Your Google API access key. This is necessary if DCS-gRPC is used as backend; if you use a config file for MSRS, hand in nil here.
---@param Backend? string (Optional) MSRS Backend to be used, can be MSRS.Backend.SRSEXE or MSRS.Backend.GRPC; if you use a config file for MSRS, hand in nil here.
---@param Provider? string (Optional) MSRS Provider to be used, can be MSRS.Provider.Google or MSRS.Provider.WINDOWS etc; if you use a config file for MSRS, hand in nil here.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return CTLD # self
function CTLD:SetSRS(Frequency, Modulation, PathToSRS, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, AccessKey, Backend, Provider, Speaker) end

---(Internal) Function to get capabilities of a chopper
---@param Unit? UNIT The unit
---@return table # Capabilities Table of caps
function CTLD:_GetUnitCapabilities(Unit) end

---(Internal) Resolve cargo label for menus/messages.
---@param Cargo? CTLD_CARGO Cargo object or cargo name.
---@return string # Cargo label
function CTLD:_GetCargoDisplayName(Cargo) end

---[User] Set a formatter used for CTLD cargo menu labels.
---If unset, CTLD keeps using the resolved cargo display name as before.
---@param Formatter? function Function called as `Formatter(self, BaseText, Cargo, Group)` and expected to return display text.
---@return CTLD # self
function CTLD:SetCargoDisplayFormatter(Formatter) end

---(Internal) Format cargo display text for menus.
---@param BaseText? string Resolved default cargo display text.
---@param Cargo? CTLD_CARGO Cargo object.
---@param Group? GROUP Group object.
---@return string # Cargo display text.
function CTLD:_FormatCargoDisplayText(BaseText, Cargo, Group) end

---(Internal) Resolve and format cargo label for a group-specific CTLD interaction.
---@param Cargo? CTLD_CARGO Cargo object or cargo name.
---@param Group? GROUP Group object.
---@return string # Cargo display text.
function CTLD:_GetCargoDisplayNameForGroup(Cargo, Group) end

---(User) Function to allow transport via Combined Arms Trucks.
---@param OnOff? boolean Switch on (true) or off (false).
---@param ClientSet? SET_CLIENT The CA handling client set for ground transport.
---@return CTLD # self
function CTLD:AllowCATransport(OnOff, ClientSet) end

---(Internal) Function to generate valid UHF Frequencies
function CTLD:_GenerateUHFrequencies() end

---(Internal) Function to generate valid FM Frequencies
function CTLD:_GenerateFMFrequencies() end

---(Internal) Populate table with available VHF beacon frequencies.
function CTLD:_GenerateVHFrequencies() end

---(User) Set drop zone radius for troop drops in meters. Minimum distance is 25m for security reasons.
---@param Radius? number The radius to use.
function CTLD:SetTroopDropZoneRadius(Radius) end

---(User) Add a PLAYERTASK - FSM events will check success
---@param PlayerTask? PLAYERTASK
---@return CTLD # self
function CTLD:AddPlayerTask(PlayerTask) end

---(Internal) Check whether cargo type is eligible for C-130 DynamicCargo auto-build.
---@param Cargo? CTLD_CARGO
---@return boolean # Outcome
function CTLD:_C130DcAutoIsBuildableCargo(Cargo) end

---(Internal) Ensure C-130 DynamicCargo auto-build runtime state tables exist.
---@return CTLD # self
function CTLD:_C130DcAutoEnsureState() end

---(Internal) Filter crate list to the currently active C-130 auto-build set.
---@param Crates? table
---@param SetIdOrScope? string|table
---@return table # Filtered
---@return number # Count
function CTLD:_C130DcAutoFilterCrates(Crates, SetIdOrScope) end

---(Internal) Register one spawned C-130 CTLD crate in DynamicCargo database and emit NewDynamicCargo.
---@param Positionable? POSITIONABLE
---@return DYNAMICCARGO # DynamicCargo
function CTLD:_C130DcAutoRegisterDynamicCargo(Positionable) end

---(Internal) Get best-effort unit name from dynamic cargo event.
---@param DynamicCargo? DYNAMICCARGO
---@return string # Unit name
function CTLD:_C130DcAutoGetCarrierUnitName(DynamicCargo) end

---(Internal) Get best-effort group name from dynamic cargo event.
---@param DynamicCargo? DYNAMICCARGO
---@return string # Group name
function CTLD:_C130DcAutoGetCarrierGroupName(DynamicCargo) end

---(Internal) Check whether this dynamic cargo event belongs to C-130J transport.
---@param DynamicCargo? DYNAMICCARGO
---@return boolean # Outcome
function CTLD:_C130DcAutoIsC130Event(DynamicCargo) end

---(Internal) Register a new C-130 DynamicCargo auto-build set.
---@param Group? GROUP
---@param Unit? UNIT
---@param Cargo? CTLD_CARGO
---@param PickupZone? ZONE
---@return string # Set id or nil
function CTLD:_C130DcAutoRegisterSet(Group, Unit, Cargo, PickupZone) end

---(Internal) Register one spawned crate entry inside a C-130 DynamicCargo auto-build set.
---@param SetId? string
---@param Cargo? CTLD_CARGO
---@return boolean # Outcome
function CTLD:_C130DcAutoRegisterEntry(SetId, Cargo) end

---(Internal) Get mapped C-130 DynamicCargo auto-build entry.
---@param DynamicCargoName? string
---@return table # SetData
---@return table # EntryData
function CTLD:_C130DcAutoGetMappedEntry(DynamicCargoName) end

---(Internal) Resolve closest pending/loaded set entry for a dynamic cargo event.
---@param DynamicCargo? DYNAMICCARGO
---@param PreferLoaded? boolean If true only loaded-state entries are considered.
---@return table # SetData
---@return table # EntryData
function CTLD:_C130DcAutoResolveEntry(DynamicCargo, PreferLoaded) end

---(Internal) Create CTLD cargo proxy from landed DynamicCargo for build handoff.
---@param SetData? table
---@param Entry? table
---@param DynamicCargo? DYNAMICCARGO
---@return CTLD_CARGO # ProxyCargo
function CTLD:_C130DcAutoCreateProxyCargo(SetData, Entry, DynamicCargo) end

---(Internal) Get C-130 auto-build batch owner key.
---@param SetData? table
---@return string # Owner key
function CTLD:_C130DcAutoGetOwnerKey(SetData) end

---(Internal) Spawn one helper infantry group and handoff build for multiple sets.
---@param OwnerKey? string
---@param SetIds? table
---@return boolean # Outcome
function CTLD:_C130DcAutoSpawnBuildHelperForSets(OwnerKey, SetIds) end

---(Internal) Flush queued ready sets for a specific owner key.
---@param OwnerKey? string
---@return CTLD # self
function CTLD:_C130DcAutoFlushOwnerBatch(OwnerKey) end

---(Internal) Queue a ready set for merge-window handoff.
---@param SetId? string
---@return boolean # Outcome
function CTLD:_C130DcAutoQueueReadySet(SetId) end

---(Internal) Cleanup C-130 DynamicCargo auto-build set.
---@param SetId? string
---@param Result? string
---@return CTLD # self
function CTLD:_C130DcAutoCleanupSet(SetId, Result) end

---(Internal) Try to complete a C-130 DynamicCargo auto-build set.
---@param SetId? string
---@return boolean # Outcome
function CTLD:_C130DcAutoTryCompleteSet(SetId) end

---(Internal) Handle DynamicCargoLoaded for mapped C-130 auto-build sets.
---@param EventData? EVENTDATA
---@return boolean # Handled
function CTLD:_C130DcAutoOnDynamicLoaded(EventData) end

---(Internal) Handle DynamicCargoUnloaded for mapped C-130 auto-build sets.
---@param EventData? EVENTDATA
---@return boolean # Handled
function CTLD:_C130DcAutoOnDynamicUnloaded(EventData) end

---(Internal) Handle DynamicCargoRemoved for mapped C-130 auto-build sets.
---@param EventData? EVENTDATA
---@return boolean # Handled
function CTLD:_C130DcAutoOnDynamicRemoved(EventData) end

---(Internal) C-130 DynamicCargo auto-build housekeeping tick.
---@return CTLD # self
function CTLD:_C130DcAutoTick() end

---(Internal) Event handler function
---@param EventData? EVENTDATA
function CTLD:_EventHandler(EventData) end

---(Internal) Function to check if a unit is a C-130J
---@param Unit? any
---@param IgnoreUseC130Flag? any
function CTLD:IsC130J(Unit, IgnoreUseC130Flag) end

---(Internal) Function to message a group.
---@param Text? string The text to display.
---@param Time? number Number of seconds to display the message.
---@param Clearscreen? boolean Clear screen or not.
---@param Group? GROUP The group receiving the message.
---@param Silent? boolean If true, do not speak out messages via SRS/TTS (if SRS is set up)
function CTLD:_SendMessage(Text, Time, Clearscreen, Group, Silent) end

---(Internal) Find a troops CTLD_CARGO object in stock
---@param Name? string of the object
---@return CTLD_CARGO # Cargo object, nil if it cannot be found
function CTLD:_FindTroopsCargoObject(Name) end

---(Internal) Find a crates CTLD_CARGO object in stock
---@param Name? string of the object
---@return CTLD_CARGO # Cargo object, nil if it cannot be found
function CTLD:_FindCratesCargoObject(Name) end

---(User) Add a new fixed wing type to the list of allowed types.
---@param typename? string The typename to add. Can be handed as Wrapper.Unit#UNIT object. Do NOT forget to `myctld:SetUnitCapabilities()` for this type!
---@return CTLD # self
function CTLD:AddAllowedFixedWingType(typename) end

---(User) Pre-load troops into a helo, e.g. for airstart. Unit **must** be alive in-game, i.e. player has taken the slot!
---@param Unit? UNIT The unit to load into, can be handed as Wrapper.Client#CLIENT object
---@param Troopname? string The name of the Troops to be loaded. Must be created prior in the CTLD setup!
---@return CTLD # self
function CTLD:PreloadTroops(Unit, Troopname) end

---(Internal) Pre-load crates into a helo. Do not use standalone!
---@param Group? GROUP The group to load into, can be handed as Wrapper.Client#CLIENT object
---@param Unit? UNIT The unit to load into, can be handed as Wrapper.Client#CLIENT object
---@param Cargo? CTLD_CARGO The Cargo crate object to load
---@param NumberOfCrates? number (Optional) Number of crates to be loaded. Default - all necessary to build this object. Might overload the helo!
---@return CTLD # self
function CTLD:_PreloadCrates(Group, Unit, Cargo, NumberOfCrates) end

---(User) Pre-load crates into a helo, e.g. for airstart. Unit **must** be alive in-game, i.e. player has taken the slot!
---@param Unit? UNIT The unit to load into, can be handed as Wrapper.Client#CLIENT object
---@param Cratesname? string The name of the cargo to be loaded. Must be created prior in the CTLD setup!
---@param NumberOfCrates? number (Optional) Number of crates to be loaded. Default - all necessary to build this object. Might overload the helo!
---@return CTLD # self
function CTLD:PreloadCrates(Unit, Cratesname, NumberOfCrates) end

---(User) Hook to allow mission-specific troop restrictions.
---Override this in your mission to perform custom checks (e.g. warehouse stock, role limits) before troops are loaded.
---Return true to allow the request, or false to block it. When blocked, _LoadTroops and _LoadTroopsQuantity exit silently.
---@param Group? GROUP Requesting player group.
---@param Unit? UNIT Requesting unit.
---@param Cargo? CTLD_CARGO Troop cargo type being requested.
---@param quantity? number Number of troop sets requested.
---@param Inject? boolean If true, this call originates from an inject/preload path.
---@return boolean # Allow troop loading.
function CTLD:CanGetTroops(Group, Unit, Cargo, quantity, Inject) end

---(Internal) Function to load troops into a heli.
---@param Group? GROUP
---@param Unit? UNIT
---@param Cargotype? CTLD_CARGO
---@param Inject? boolean
function CTLD:_LoadTroops(Group, Unit, Cargotype, Inject) end

---@param Group? any
---@param Unit? any
---@param Repairtype? any
function CTLD:_FindRepairNearby(Group, Unit, Repairtype) end

---(Internal) Function to repair an object.
---@param Group? GROUP
---@param Unit? UNIT
---@param Crates? table Table of #CTLD_CARGO objects near the unit.
---@param Build? CTLD.Buildable|number|string Table build object.
---@param Number? number Number of objects in Crates (found) to limit search.
---@param Engineering? boolean If true it is an Engineering repair.
function CTLD:_RepairObjectFromCrates(Group, Unit, Crates, Build, Number, Engineering) end

---(Internal) Function to extract (load from the field) troops into a heli.
---@param Group? GROUP
---@param Unit? UNIT
function CTLD:_ExtractTroops(Group, Unit) end

---(Internal) Function to load multiple troop sets at once.
---@param Group? GROUP
---@param Unit? UNIT
---@param Cargo? CTLD_CARGO
---@param quantity? number Number of troop sets to load.
---@return CTLD # self
function CTLD:_LoadTroopsQuantity(Group, Unit, Cargo, quantity) end

---(Internal) Function to add quantity submenu entries for troops.
---@param Group? GROUP
---@param Unit? UNIT
---@param parentMenu? MENU_GROUP
---@param cargoObj? CTLD_CARGO
---@return CTLD # self
function CTLD:_AddTroopQuantityMenus(Group, Unit, parentMenu, cargoObj) end

---(Internal) Function to request N*crates for a cargo type.
---@param Group? GROUP
---@param Unit? UNIT
---@param cargoObj? CTLD_CARGO
---@param quantity? number Number of cargo sets to request.
---@return CTLD # self
function CTLD:_GetCrateQuantity(Group, Unit, cargoObj, quantity) end

---(Internal) Function to add quantity submenu entries for crates.
---@param Group? GROUP
---@param Unit? UNIT
---@param parentMenu? MENU_GROUP
---@param cargoObj? CTLD_CARGO
---@param stockSummary? table Optional pooled stock summary.
---@return CTLD # self
function CTLD:_AddCrateQuantityMenus(Group, Unit, parentMenu, cargoObj, stockSummary) end

---User overrideable function to determine if a unit can get crates.
---@param Group? GROUP
---@param Unit? UNIT
---@param Config? table Configuration entry for the unit.
---@param quantity? number Number of crate sets requested.
---@param quiet? boolean If true, do not send messages to the user.
function CTLD:CanGetUnits(Group, Unit, Config, quantity, quiet) end

---(Internal) Spawn a “Get units” entry for a C-130J-30 at load zone.
---@param Group? GROUP
---@param Unit? UNIT
---@param Name? string Name of the configured unit entry.
---@return CTLD # self
function CTLD:_C130GetUnits(Group, Unit, Name) end

---(User) Hook to allow mission-specific crate restrictions.
---Override this in your mission to perform custom checks (e.g. warehouse stock) before crates spawn.
---Return `true` to allow the request, or `false` to block it. When blocked, `_GetCrates` exits silently.
---@param Group? GROUP Requesting player group.
---@param Unit? UNIT Requesting unit.
---@param Cargo? CTLD_CARGO Cargo type being requested.
---@param number? number Number of crates requested (raw quantity, not sets).
---@param drop? boolean Drop-mode request flag.
---@param pack? boolean Pack-mode request flag.
---@param quiet? boolean Quiet flag from menu call.
---@param suppressGetEvent? boolean If true, `_GetCrates` will not emit the `GetCrates` event.
---@return boolean # Allow crate spawning.
function CTLD:CanGetCrates(Group, Unit, Cargo, number, drop, pack, quiet, suppressGetEvent) end

---(Internal) Function to spawn crates in front of the heli.
---@param Group? GROUP
---@param Unit? UNIT
---@param Cargo? CTLD_CARGO
---@param number? number Number of crates to generate (for dropping)
---@param drop? boolean If true we\'re dropping from heli rather than loading.
---@param pack? boolean If true we\'re packing crates from a template rather than loading or dropping
---@param quiet? any
---@param suppressGetEvent? any
function CTLD:_GetCrates(Group, Unit, Cargo, number, drop, pack, quiet, suppressGetEvent) end

---(Internal) Inject crates and static cargo objects.
---@param Zone? ZONE Zone to spawn in.
---@param Cargo? CTLD_CARGO The cargo type to spawn.
---@param RandomCoord? boolean Randomize coordinate.
---@param FromLoad? boolean Create only **one** crate per cargo type, as we are re-creating dropped crates that CTLD has saved prior.
---@return CTLD # self
function CTLD:InjectStatics(Zone, Cargo, RandomCoord, FromLoad) end

---(User) Inject static cargo objects.
---@param Zone? ZONE Zone to spawn in. Will be a somewhat random coordinate.
---@param Template? string Unit(!) name of the static cargo object to be used as template.
---@param Mass? number Mass of the static in kg.
---@return CTLD # self
function CTLD:InjectStaticFromTemplate(Zone, Template, Mass) end

---(Internal) Function to find and list nearby crates.
---@param _group? any
---@param _unit? any
---@return CTLD # self
function CTLD:_ListCratesNearby(_group, _unit) end

---(Internal) Function to find and remove nearby C-130 managed units.
---@param _group? any
---@param _unit? any
---@return CTLD # self
function CTLD:_C130RemoveUnitsNearby(_group, _unit) end

---(Internal) Function to find and Remove nearby crates.
---@param _group? any
---@param _unit? any
---@return CTLD # self
function CTLD:_RemoveCratesNearby(_group, _unit) end

---(Internal) Return distance in meters between two coordinates.
---@param _point1? COORDINATE Coordinate one
---@param _point2? COORDINATE Coordinate two
---@return number # Distance in meters
function CTLD:_GetDistance(_point1, _point2) end

---(Internal) Function to find and return nearby crates.
---@param _group? GROUP Group
---@param _unit? UNIT Unit
---@param _dist? number Distance
---@param _ignoreweight? boolean Find everything in range, ignore loadable weight
---@param ignoretype? boolean Find everything in range, ignore loadable type name
---@param ignoreHercInner? boolean Exclude crates close to the aircraft; C-130 exclusion requires UseC130LoadAndUnload.
---@return table # Crates Table of crates
---@return number # Number Number of crates found
---@return table # CratesGC Table of crates possibly loaded by GC
---@return number # NumberGC Number of crates possibly loaded by GC
function CTLD:_FindCratesNearby(_group, _unit, _dist, _ignoreweight, ignoretype, ignoreHercInner) end

---(Internal) Function to get and load nearby crates.
---@param Group? GROUP
---@param Unit? UNIT
---@param canhoverload? boolean Optional hover eligibility from the current synchronous call.
---@param capabilities? CTLD.UnitTypeCapabilities|number|string Optional resolved aircraft capabilities.
---@param unitname? string Optional resolved unit name.
---@return CTLD # self
function CTLD:_LoadCratesNearby(Group, Unit, canhoverload, capabilities, unitname) end

---(Internal) Function to clean up tracked cargo crates
---@param crateIdsToRemove? table Table of IDs
---@return self
function CTLD:_CleanupTrackedCrates(crateIdsToRemove) end

---(Internal) Function to get current loaded mass
---@param Unit? UNIT
---@return number # mass in kgs
function CTLD:_GetUnitCargoMass(Unit) end

---(Internal) Function to calculate max loadable mass left over.
---@param Unit? UNIT
---@param loadedmass? number Optional mass already measured for this call.
---@param capabilities? CTLD.UnitTypeCapabilities|number|string Optional resolved aircraft capabilities.
---@return number # maxloadable Max loadable mass in kg
function CTLD:_GetMaxLoadableMass(Unit, loadedmass, capabilities) end

---(Internal) Function to calculate and set Unit internal cargo mass
---@param Unit? UNIT
function CTLD:_UpdateUnitCargoMass(Unit) end

---(Internal) Function to list loaded cargo.
---@param Group? GROUP
---@param Unit? UNIT
---@return CTLD # self
function CTLD:_ListCargo(Group, Unit) end

---(Internal) Function to list loaded cargo.
---@param Group? GROUP
---@param Unit? UNIT
---@return CTLD # self
function CTLD:_ListInventory(Group, Unit) end

---(Internal) Function to check if a unit is an allowed fixed wing.
---@param Unit? UNIT
---@return boolean # Outcome
function CTLD:IsFixedWing(Unit) end

---(Internal) Function to check if a unit is a CH-47
---@param Unit? UNIT
---@return boolean # Outcome
function CTLD:IsHook(Unit) end

---(Internal) Function to set troops positions of a template to a nice circle
---@param Coordinate? COORDINATE Start coordinate to use
---@param Radius? number Radius to be used
---@param Heading? number Heading starting with
---@param Template? string The group template name
---@return table # Positions The positions table
function CTLD:_GetUnitPositions(Coordinate, Radius, Heading, Template) end

---Override this function to check if troops can be unloaded. This does not prevent returning troops to base.
---@param Group? any
---@param Unit? any
---@param LoadedCargo? table Table of loaded cargo, see #CTLD.LoadedCargo
---@param IsGrounded? boolean Is the unit on the ground
---@param IsHoverUnload? boolean Is the unit hovering in parameters for hover unload
---@return boolean # True if troops can be unloaded, false to prevent unloading
function CTLD:CanUnloadAllTroops(Group, Unit, LoadedCargo, IsGrounded, IsHoverUnload) end

---(Internal) Function to unload troops from heli.
---@param Group? GROUP
---@param Unit? UNIT
function CTLD:_UnloadTroops(Group, Unit) end

---(Internal) Function to unload crates from heli.
---@param Group? GROUP
---@param Unit? UNIT
function CTLD:_UnloadCrates(Group, Unit) end

---(User) Hook to allow mission-specific build restrictions.
---Override this in your mission to perform custom checks (e.g. warehouse/credits rules) before crates are built.
---Return `true` to allow the build, or `false` to block it. When blocked, `_BuildCrates` exits silently.
---@param Group? GROUP Requesting player group.
---@param Unit? UNIT Requesting unit.
---@param crates? table Table of nearby crate cargo objects returned by `_FindCratesNearby`.
---@param number? number Number of nearby crates.
---@param Engineering? boolean If true build is by an engineering team.
---@param MultiDrop? boolean If true and not engineering or FOB, vary position a bit.
---@return boolean # Allow building.
function CTLD:CanBuildCrates(Group, Unit, crates, number, Engineering, MultiDrop) end

---(Internal) Function to build nearby crates.
---@param Group? GROUP
---@param Unit? UNIT
---@param Engineering? boolean If true build is by an engineering team.
---@param MultiDrop? boolean If true and not engineering or FOB, vary position a bit.
---@param NotifyGroup? GROUP Optional group to receive engineer/autobuild messages.
function CTLD:_BuildCrates(Group, Unit, Engineering, MultiDrop, NotifyGroup) end

---(Internal) Function to find nearby packable groups.
---@param Group? GROUP
---@param Unit? UNIT
---@return table # PackableGroups
---@return number # Number
function CTLD:_FindPackableGroupsNearby(Group, Unit) end

---(Internal) Function to pack a selected nearby group into crates.
---@param Group? GROUP
---@param Unit? UNIT
---@param TargetGroup? GROUP
---@param EmitPackedEvent? boolean
---@param SkipMenuRefresh? boolean
---@return table # PackedCargo
---@return CTLD_CARGO # CargoEntry
---@return boolean # Success
function CTLD:_PackSingleGroupToCrates(Group, Unit, TargetGroup, EmitPackedEvent, SkipMenuRefresh) end

---(Internal) Function to load the exact crates created by a selected pack action.
---@param Group? GROUP
---@param Unit? UNIT
---@param crateIds? table
---@param cargoName? string
---@return CTLD # self
function CTLD:_LoadPackedCratesByIds(Group, Unit, crateIds, cargoName) end

---(Internal) Function to remove the exact crates created by a selected pack action.
---@param Group? GROUP
---@param Unit? UNIT
---@param crateIds? table
---@return CTLD # self
function CTLD:_RemovePackedCratesByIds(Group, Unit, crateIds) end

---(Internal) Function to pack a selected nearby group.
---@param Group? GROUP
---@param Unit? UNIT
---@param TargetGroupName? string
---@param Mode? string
---@return boolean # Success
function CTLD:_PackSelectedGroupAction(Group, Unit, TargetGroupName, Mode) end

---(Internal) Function to pack nearby vehicles / FOBs.
---@param Group? GROUP
---@param Unit? UNIT
---@param EmitPackedEvent? boolean If false, suppress CratesPacked callbacks.
---@return boolean # Success
function CTLD:_PackCratesNearby(Group, Unit, EmitPackedEvent) end

---(Internal) Function to repair nearby vehicles / FOBs
---@param Group? GROUP
---@param Unit? UNIT
---@param Engineering? boolean If true, this is an engineering role
function CTLD:_RepairCrates(Group, Unit, Engineering) end

---(Internal) Function to actually SPAWN buildables in the mission.
---@param Group? GROUP
---@param Unit? UNIT
---@param Build? CTLD.Buildable|number|string
---@param Repair? boolean If true this is a repair and not a new build
---@param RepairLocation? COORDINATE Location for repair (e.g. where the destroyed unit was)
---@param MultiDrop? boolean if true and not a repair, vary location a bit if not a FOB
function CTLD:_BuildObjectFromCrates(Group, Unit, Build, Repair, RepairLocation, MultiDrop) end

---(Internal) Function to get a vehicle formation for a moving group
---@return string # Formation
function CTLD:_GetVehicleFormation() end

---(Internal) Function to move group to WP zone.
---@param Group? GROUP The Group to move.
function CTLD:_MoveGroupToZone(Group) end

---(Internal) Housekeeping - Cleanup crates when build
---@param Crates? table Table of #CTLD_CARGO objects near the unit.
---@param Build? CTLD.Buildable|number|string Table build object.
---@param Number? number Number of objects in Crates (found) to limit search.
function CTLD:_CleanUpCrates(Crates, Build, Number) end

---(Internal) Helper - Drop **all** loaded crates nearby and build them.
---@param Group? GROUP The calling group
---@param Unit? UNIT The calling unit
function CTLD:_DropAndBuild(Group, Unit) end

---(Internal) Helper - Drop a **single** crate set and build it.
---@param Group? GROUP The calling group
---@param Unit? UNIT The calling unit
---@param setIndex? number Index of the crate-set to drop
function CTLD:_DropSingleAndBuild(Group, Unit, setIndex) end

---(Internal) Helper - Pack crates near the unit and load them.
---@param Group? GROUP The calling group
---@param Unit? UNIT The calling unit
function CTLD:_PackAndLoad(Group, Unit) end

---(Internal) Helper - Pack crates near the unit and then remove them.
---@param Group? GROUP The calling group
---@param Unit? UNIT The calling unit
function CTLD:_PackAndRemove(Group, Unit) end

---(Internal) Helper - get and load in one step
---@param Group? GROUP The calling group
---@param Unit? UNIT The calling unit
---@param cargoObj? CTLD_CARGO
---@param quantity? number
---@param LoadAnyWay? any
function CTLD:_GetAndLoad(Group, Unit, cargoObj, quantity, LoadAnyWay) end

---@param Group? GROUP The player’s group that triggered the action
---@param Unit? UNIT The unit performing the pack-and-load
function CTLD:_GetAllAndLoad(Group, Unit) end

---(Internal) Function to get crate stock table entry.
---@param cargoObj? CTLD_CARGO Cargo object.
---@param stockSummary? table Stock summary table.
---@return table # Stock entry or nil.
function CTLD:_GetCrateStockEntry(cargoObj, stockSummary) end

---(Internal) Function to format crate stock suffix for menu text.
---@param cargoObj? CTLD_CARGO Cargo object.
---@param stockSummary? table Stock summary table.
---@return string # Formatted suffix like "[3]" or "[3/10]" or nil.
function CTLD:_FormatCrateStockSuffix(cargoObj, stockSummary) end

---(Internal) Function to refresh quantity submenus for crates for a single player group.
---@param Group? GROUP
---@param Unit? UNIT
---@param CargoObj? CTLD_CARGO Optional; if given and stock < maxCrateMenuQuantity, do global rebuild.
---@return CTLD # self
function CTLD:_RefreshCrateQuantityMenus(Group, Unit, CargoObj) end

---(Internal) Function to refresh quantity submenus for troops for a single player group.
---@param Group? GROUP
---@param Unit? UNIT
---@param CargoObj? CTLD_CARGO Optional; if given and stock < maxCrateMenuQuantity, do global rebuild.
---@return CTLD # self
function CTLD:_RefreshTroopQuantityMenus(Group, Unit, CargoObj) end

---(Internal) Function to refresh quantity submenus for Troops and Crates.
---@param _group? any
---@param _unit? any
---@return CTLD # self
function CTLD:_RefreshQuantityMenusForGroup(_group, _unit) end

---(Internal) Housekeeping - Function to refresh F10 menus.
---@return CTLD # self
function CTLD:_RefreshF10Menus() end

---(Internal) Function to refresh the menu for load crates. Triggered from land/getcrate/pack and more
---@param Group? GROUP The calling group.
---@param Unit? UNIT The calling unit.
---@return CTLD # self
function CTLD:_RefreshLoadCratesMenu(Group, Unit) end

---(Internal) Function to refresh the menu for pack actions. Triggered from land/build/pack and more.
---@param Group? GROUP The calling group.
---@param Unit? UNIT The calling unit.
---@return CTLD # self
function CTLD:_RefreshPackMenus(Group, Unit) end

---Loads exactly `CratesNeeded` crates for one cargoName in range.
---If "Ammo Truck" needs 2 crates, we pick up 2 if available.
---@param Group? GROUP
---@param Unit? UNIT
---@param cargoName? string The cargo name, e.g. "Ammo Truck"
---@param details? any
function CTLD:_LoadSingleCrateSet(Group, Unit, cargoName, details) end

---(Internal) Function to unload a single crate
---@param Group? GROUP The calling group.
---@param Unit? UNIT The calling unit.
---@param setIndex? string The name of the crate to unload
---@return CTLD # self
function CTLD:_UnloadSingleCrateSet(Group, Unit, setIndex) end

---(Internal) Function to refresh the menu for a single unit after crates dropped.
---@param Group? GROUP The calling group.
---@param Unit? UNIT The calling unit.
---@return CTLD # self
function CTLD:_RefreshDropCratesMenu(Group, Unit) end

---Override this function to check if we can unload a single Troop group by ID.
---@param Group? GROUP The aircraft group.
---@param Unit? UNIT The aircraft unit.
---@param ChunkID? number the Cargo ID
---@param Quantity? number the quantity to unload
---@param LoadedCargo? table the current loaded cargo table for this unit
---@param IsGrounded? boolean whether the unit is currently grounded
---@param IsHoverUnload? boolean whether the unit is currently in hover-unload state
---@return boolean # true if we can unload, false if not
function CTLD:CanUnloadSingleTroopByID(Group, Unit, ChunkID, Quantity, LoadedCargo, IsGrounded, IsHoverUnload) end

---(Internal) Function to unload a single Troop group by ID.
---@param Group? GROUP The calling group.
---@param Unit? UNIT The calling unit.
---@param chunkID? number the Cargo ID
---@param qty? any
---@return CTLD # self
function CTLD:_UnloadSingleTroopByID(Group, Unit, chunkID, qty) end

---(Internal) Function to refresh menu for troops on drop for a specific unit
---@param Group? GROUP The requesting group.
---@param Unit? UNIT The requesting unit.
---@return CTLD # self
function CTLD:_RefreshDropTroopsMenu(Group, Unit) end

---[Internal] Function to check if a template exists in the mission.
---@param temptable? table Table of string names
---@return boolean # outcome
function CTLD:_CheckTemplates(temptable) end

---User function - Add *generic* troop type loadable as cargo. This type will load directly into the heli without crates.
---@param Name? string Unique name of this type of troop. E.g. "Anti-Air Small".
---@param Templates? table Table of #string names of late activated Wrapper.Group#GROUP making up this troop.
---@param Type? CTLD_CARGO.Enum|number|string Type of cargo, here TROOPS - these will move to a nearby destination zone when dropped/build.
---@param NoTroops? number Size of the group in number of Units across combined templates (for loading).
---@param PerTroopMass? number Mass in kg of each soldier
---@param Stock? number Number of groups in stock. Nil for unlimited.
---@param SubCategory? any Name of sub-category (optional).
---@param NoMoveToZone? boolean (Optional) If true, skip automatic movement to a MOVE zone when deployed or restored.
function CTLD:AddTroopsCargo(Name, Templates, Type, NoTroops, PerTroopMass, Stock, SubCategory, NoMoveToZone) end

---User function - Add *generic* unit-type entry for the C-130J-30 Manage Units menu. This type will spawn units that can move.
---@param Name? string Unique name of this type of unit. E.g. "Humvee".
---@param Templates? table Table of #string names of late activated Wrapper.Group#GROUP used to spawn this unit.
---@param Type? CTLD_CARGO.Enum|number|string Type of unit. I.e. VEHICLE or FOB. VEHICLE will move when spawned, FOB stays put.
---@param Stock? number Number of units in stock. Nil or -1 for unlimited.
---@param SubCategory? any Name of sub-category (optional), used for sub-menus when self.usesubcats == true.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can use this entry, e.g. "C-130J-30" or {"C-130J-30"}.
---@return CTLD # self
function CTLD:AddUnits(Name, Templates, Type, Stock, SubCategory, UnitTypes) end

---User function - Add *generic* unit-type entry for the C-130J-30 Manage Units menu. This type will spawn units that stay in place.
---@param Name? string Unique name of this type of unit. E.g. "Humvee".
---@param Templates? table Table of #string names of late activated Wrapper.Group#GROUP used to spawn this unit.
---@param Type? CTLD_CARGO.Enum|number|string Type of unit. I.e. VEHICLE or FOB. VEHICLE will be treated as non-moving here, FOB stays put.
---@param Stock? number Number of units in stock. Nil or -1 for unlimited.
---@param SubCategory? any Name of sub-category (optional), used for sub-menus when self.usesubcats == true.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can use this entry, e.g. "C-130J-30" or {"C-130J-30"}.
---@return CTLD # self
function CTLD:AddUnitsNoMove(Name, Templates, Type, Stock, SubCategory, UnitTypes) end

---User function - Add *generic* crate-type loadable as cargo. This type will create crates that need to be loaded, moved, dropped and built.
---@param Name? string Unique name of this type of cargo. E.g. "Humvee".
---@param Templates? table Table of #string names of late activated Wrapper.Group#GROUP building this cargo.
---@param Type? CTLD_CARGO.Enum|number|string Type of cargo. I.e. VEHICLE or FOB. VEHICLE will move to destination zones when dropped/build, FOB stays put.
---@param NoCrates? number Number of crates needed to build this cargo.
---@param PerCrateMass? number Mass in kg of each crate
---@param Stock? number Number of buildable groups in stock. Nil for unlimited.
---@param SubCategory? any Name of sub-category (optional).
---@param DontShowInMenu? boolean (optional) If set to "true" this won't show up in the menu.
---@param Location? ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}.
---@param Category? any Static category name (optional). If set, spawn cargo crate with an alternate category type, e.g. "Cargos".
---@param TypeName? string Static type name (optional). If set, it will overwride even though TypeName is passed. this is only for the C-130J-30. Can be used with other TypeName for other modules.
---@param ShapeName? string Static shape name (optional). If set, spawn cargo crate with an alternate type sub-shape, e.g. "iso_container_cargo".
---@param C130TypeName? any
---@return CTLD # self
function CTLD:AddCratesCargo(Name, Templates, Type, NoCrates, PerCrateMass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, Category, TypeName, ShapeName, C130TypeName) end

---Identical to AddCratesCargo, but registers the cargo so the spawned/built group does not move to MOVE zones.
---User function - Add *generic* crate-type loadable as cargo. This type will create crates that need to be loaded, moved, dropped and built.
---@param Name? string Unique name of this type of cargo. E.g. "Humvee".
---@param Templates? table Table of #string names of late activated Wrapper.Group#GROUP building this cargo.
---@param Type? CTLD_CARGO.Enum|number|string Type of cargo. I.e. VEHICLE or FOB. VEHICLE will move to destination zones when dropped/build, FOB stays put.
---@param NoCrates? number Number of crates needed to build this cargo.
---@param PerCrateMass? number Mass in kg of each crate
---@param Stock? number Number of buildable groups in stock. Nil for unlimited.
---@param SubCategory? any Name of sub-category (optional).
---@param DontShowInMenu? boolean (optional) If set to "true" this won't show up in the menu.
---@param Location? ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}.
---@param Category? any Static category name (optional). If set, spawn cargo crate with an alternate category type, e.g. "Cargos".
---@param TypeName? string Static type name (optional). If set, it will overwride even though TypeName is passed. this is only for the C-130J-30. Can be used with other TypeName for other modules.
---@param ShapeName? string Static shape name (optional). If set, spawn cargo crate with an alternate type sub-shape, e.g. "iso_container_cargo".
---@param C130TypeName? any
---@return CTLD # self
function CTLD:AddCratesCargoNoMove(Name, Templates, Type, NoCrates, PerCrateMass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, Category, TypeName, ShapeName, C130TypeName) end

---User function - Add *generic* static-type loadable as cargo. This type will create cargo that needs to be loaded, moved and dropped.
---@param Name? string Unique name of this type of cargo as set in the mission editor (note: UNIT name!), e.g. "Ammunition-1".
---@param Mass? number Mass in kg of each static in kg, e.g. 100.
---@param Stock? number Number of groups in stock. Nil for unlimited.
---@param SubCategory? any Name of sub-category (optional).
---@param DontShowInMenu? boolean (optional) If set to "true" this won't show up in the menu.
---@param Location? ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}.
---@param DisplayName? string Display name shown in menus/messages (optional). Falls back to `Name`.
---@return CTLD_CARGO # CargoObject
function CTLD:AddStaticsCargo(Name, Mass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, DisplayName) end

---User function - Add *generic* static-type loadable as cargo from a static **type name**.
---This variant does **not** require a matching mission-editor static template.
---@param Name? string Unique cargo identifier for this type.
---@param TypeName? string Static type name to spawn, e.g. "ammo_cargo", "iso_container_small".
---@param Mass? number Mass in kg of each static in kg, e.g. 100.
---@param Stock? number Number of groups in stock. Nil for unlimited.
---@param SubCategory? any Name of sub-category (optional).
---@param DontShowInMenu? boolean (optional) If set to "true" this won't show up in the menu.
---@param Location? ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}.
---@param Category? any Static category name (optional). Default is "Cargos".
---@param ShapeName? string Static shape name (optional). If set, force a specific shape, e.g. "iso_container_small_cargo".
---@param ResourceMap? table Resource map payload (optional) for static cargo.
---@param DisplayName? string Display name shown in menus/messages (optional). Falls back to `Name`.
---@return CTLD_CARGO # CargoObject
function CTLD:AddStaticsCargoFromType(Name, TypeName, Mass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, Category, ShapeName, ResourceMap, DisplayName) end

---User function - Get a *generic* static-type loadable as #CTLD_CARGO object.
---@param Name? string Unique Unit(!) name of this type of cargo as set in the mission editor (not: GROUP name!), e.g. "Ammunition-1".
---@param Mass? number Mass in kg of each static in kg, e.g. 100.
---@param DisplayName? string Display name shown in menus/messages (optional). Falls back to `Name`.
---@return CTLD_CARGO # Cargo object
function CTLD:GetStaticsCargoFromTemplate(Name, Mass, DisplayName) end

---User function - Get a *generic* static-type loadable cargo from a static **type name**.
---@param Name? string Unique name of this type of cargo.
---@param TypeName? string Static type name, e.g. "ammo_cargo", "iso_container_small".
---@param Mass? number Mass in kg of each static in kg, e.g. 100.
---@param Category? any Static category name (optional). Default is "Cargos".
---@param ShapeName? string Static shape name (optional).
---@param ResourceMap? table Resource map payload (optional) for static cargo.
---@param DisplayName? string Display name shown in menus/messages (optional). Falls back to `Name`.
---@return CTLD_CARGO # Cargo object
function CTLD:GetStaticsCargoFromType(Name, TypeName, Mass, Category, ShapeName, ResourceMap, DisplayName) end

---User function - Add *generic* repair crates loadable as cargo. This type will create crates that need to be loaded, moved, dropped and built.
---@param Name? string Unique name of this type of cargo. E.g. "Humvee".
---@param Template? string Template of VEHICLE or FOB cargo that this can repair. MUST be the same as given in `AddCratesCargo(..)`!
---@param Type? CTLD_CARGO.Enum|number|string Type of cargo, here REPAIR.
---@param NoCrates? number Number of crates needed to build this cargo.
---@param PerCrateMass? number Mass in kg of each crate
---@param Stock? number Number of groups in stock. Nil for unlimited.
---@param SubCategory? any Name of the sub-category (optional).
---@param DontShowInMenu? boolean (optional) If set to "true" this won't show up in the menu.
---@param Location? ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes? string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}
---@param Category? any Static category name (optional). If set, spawn cargo crate with an alternate category type, e.g. "Cargos".
---@param TypeName? string Static type name (optional). If set, spawn cargo crate with an alternate type shape, e.g. "iso_container".
---@param ShapeName? string Static shape name (optional). If set, spawn cargo crate with an alternate type sub-shape, e.g. "iso_container_cargo".
---@return CTLD # self
function CTLD:AddCratesRepair(Name, Template, Type, NoCrates, PerCrateMass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, Category, TypeName, ShapeName) end

---User function - Add a #CTLD.CargoZoneType zone for this CTLD instance.
---@param Zone? CTLD.CargoZone|number|string Zone #CTLD.CargoZone describing the zone.
function CTLD:AddZone(Zone) end

---User function - Activate Name #CTLD.CargoZone.Type ZoneType for this CTLD instance.
---@param Name? string Name of the zone to change in the ME.
---@param ZoneType? CTLD.CargoZoneType|number|string Type of zone this belongs to.
---@param NewState? boolean (Optional) Set to true to activate, false to switch off.
function CTLD:ActivateZone(Name, ZoneType, NewState) end

---User function - Deactivate Name #CTLD.CargoZoneType ZoneType for this CTLD instance.
---@param Name? string Name of the zone to change in the ME.
---@param ZoneType? CTLD.CargoZoneType|number|string Type of zone this belongs to.
function CTLD:DeactivateZone(Name, ZoneType) end

---(Internal) Function to obtain a valid FM frequency.
---@param Name? string Name of zone.
---@return CTLD.ZoneBeacon # Beacon Beacon table.
function CTLD:_GetFMBeacon(Name) end

---(Internal) Function to obtain a valid UHF frequency.
---@param Name? string Name of zone.
---@return CTLD.ZoneBeacon # Beacon Beacon table.
function CTLD:_GetUHFBeacon(Name) end

---(Internal) Function to obtain a valid VHF frequency.
---@param Name? string Name of zone.
---@return CTLD.ZoneBeacon # Beacon Beacon table.
function CTLD:_GetVHFBeacon(Name) end

---User function - Creates and adds a #CTLD.CargoZone zone for this CTLD instance.
--- Zones of type LOAD: Players load crates and troops here.
--- Zones of type DROP: Players can drop crates here. Note that troops can be unloaded anywhere.
--- Zone of type MOVE: Dropped troops and vehicles will start moving to the nearest zone of this type (also see options).
---@param Name? string Name of this zone, as in Mission Editor.
---@param Type? string Type of this zone, #CTLD.CargoZoneType
---@param Color? number Smoke/Flare color e.g. #SMOKECOLOR.Red
---@param Active? string Is this zone currently active?
---@param HasBeacon? any
---@param Shiplength? any
---@param Shipwidth? any
---@param BeaconFrequencies? any
---@return CTLD # self
function CTLD:AddCTLDZone(Name, Type, Color, Active, HasBeacon, Shiplength, Shipwidth, BeaconFrequencies) end

---User function - find #CTLD.CargoZone zone by name.
---@param Name? string Name of this zone.
---@param Type? string Type of this zone, #CTLD.CargoZoneType
---@return CTLD.CargoZone # self
function CTLD:GetCTLDZone(Name, Type) end

---User function - Creates and adds a #CTLD.CargoZone zone for this CTLD instance from an Airbase or FARP name.
--- Zones of type LOAD: Players load crates and troops here.
--- Zones of type DROP: Players can drop crates here. Note that troops can be unloaded anywhere.
--- Zone of type MOVE: Dropped troops and vehicles will start moving to the nearest zone of this type (also see options).
---@param AirbaseName? string Name of the Airbase, can be e.g. AIRBASE.Caucasus.Beslan or "Beslan". For FARPs, this will be the UNIT name.
---@param Type? string Type of this zone, #CTLD.CargoZoneType
---@param Color? number Smoke/Flare color e.g. #SMOKECOLOR.Red
---@param Active? string Is this zone currently active?
---@param HasBeacon? string Does this zone have a beacon if it is active?
---@return CTLD # self
function CTLD:AddCTLDZoneFromAirbase(AirbaseName, Type, Color, Active, HasBeacon) end

---(Internal) Function to create a dropped beacon
---@param Unit? UNIT
---@return CTLD # self
function CTLD:DropBeaconNow(Unit) end

---(Internal) Housekeeping dropped beacons.
---@return CTLD # self
function CTLD:CheckDroppedBeacons() end

---(Internal) Function to show list of radio beacons
---@param Group? GROUP
---@param Unit? UNIT
function CTLD:_ListRadioBeacons(Group, Unit) end

---(Internal) Add radio beacon to zone. Runs 30 secs.
---@param Name? string Name of zone.
---@param Sound? string Name of soundfile.
---@param Mhz? number Frequency in Mhz.
---@param Modulation? number Modulation AM or FM.
---@param IsShip? boolean If true zone is a ship.
---@param IsDropped? boolean If true, this isn't a zone but a dropped beacon
function CTLD:_AddRadioBeacon(Name, Sound, Mhz, Modulation, IsShip, IsDropped) end

---Set folder path where the CTLD sound files are located **within you mission (miz) file**.
---The default path is "l10n/DEFAULT/" but sound files simply copied there will be removed by DCS the next time you save the mission.
---However, if you create a new folder inside the miz file, which contains the sounds, it will not be deleted and can be used.
---@param FolderPath? string The path to the sound files, e.g. "CTLD_Soundfiles/".
---@return CTLD # self
function CTLD:SetSoundfilesFolder(FolderPath) end

---(Internal) Function to refresh radio beacons
function CTLD:_RefreshRadioBeacons() end

---(Internal) Function to see if a unit is in a specific zone type.
---@param Unit? UNIT Unit
---@param Zonetype? CTLD.CargoZoneType|number|string Zonetype
---@return boolean # Outcome Is in zone or not
---@return string # name Closest zone name
---@return ZONE # zone Closest Core.Zone#ZONE object
---@return number # distance Distance to closest zone
---@return number # width Radius of zone or width of ship
function CTLD:IsUnitInZone(Unit, Zonetype) end

---User function - Drop a smoke or flare at current location.
---@param Unit? UNIT The Unit.
---@param Flare? boolean If true, flare instead.
---@param SmokeColor? number Color enumerator for smoke, e.g. SMOKECOLOR.Red
function CTLD:SmokePositionNow(Unit, Flare, SmokeColor) end

---User function - Start smoke/flare in a zone close to the Unit.
---@param Unit? UNIT The Unit.
---@param Flare? boolean If true, flare instead.
function CTLD:SmokeZoneNearBy(Unit, Flare) end

---User - Function to add/adjust unittype capabilities.
---@param Unittype? string The unittype to adjust. If passed as Wrapper.Unit#UNIT, it will search for the unit in the mission.
---@param Cancrates? boolean Unit can load crates. Default false.
---@param Cantroops? boolean Unit can load troops. Default false.
---@param Cratelimit? number Unit can carry number of crates. Default 0.
---@param Trooplimit? number Unit can carry number of troops. Default 0.
---@param Length? number Unit lenght (in metres) for the load radius. Default 20.
---@param Maxcargoweight? number Maxmimum weight in kgs this helo can carry. Default 500.
function CTLD:SetUnitCapabilities(Unittype, Cancrates, Cantroops, Cratelimit, Trooplimit, Length, Maxcargoweight) end

---User - Function to add onw SET_GROUP Set-up for pilot filtering and assignment.
---Needs to be set before starting the CTLD instance.
---@param Set? SET_GROUP The SET_GROUP object created by the mission designer/user to represent the CTLD pilot groups.
---@return CTLD # self
function CTLD:SetOwnSetPilotGroups(Set) end

---[Deprecated] - Function to add/adjust unittype capabilities. Has been replaced with `SetUnitCapabilities()` - pls use the new one going forward!
---@param Unittype? string The unittype to adjust. If passed as Wrapper.Unit#UNIT, it will search for the unit in the mission.
---@param Cancrates? boolean Unit can load crates. Default false.
---@param Cantroops? boolean Unit can load troops. Default false.
---@param Cratelimit? number Unit can carry number of crates. Default 0.
---@param Trooplimit? number Unit can carry number of troops. Default 0.
---@param Length? number Unit lenght (in metres) for the load radius. Default 20.
---@param Maxcargoweight? number Maxmimum weight in kgs this helo can carry. Default 500.
function CTLD:UnitCapabilities(Unittype, Cancrates, Cantroops, Cratelimit, Trooplimit, Length, Maxcargoweight) end

---(Internal) Check if a unit is hovering *in parameters*.
---@param Unit? UNIT
---@return boolean # Outcome
function CTLD:IsCorrectHover(Unit) end

---(Internal) Check if a Hercules is flying *in parameters* for air drops.
---@param Unit? UNIT
---@return boolean # Outcome
function CTLD:IsCorrectFlightParameters(Unit) end

---(Internal) List if a unit is hovering *in parameters*.
---@param Group? GROUP
---@param Unit? UNIT
function CTLD:_ShowHoverParams(Group, Unit) end

---(Internal) List if a Herc unit is flying *in parameters*.
---@param Group? GROUP
---@param Unit? UNIT
function CTLD:_ShowFlightParams(Group, Unit) end

---(Internal) Check if a unit is in a load zone and is hovering in parameters.
---@param Unit? UNIT
---@return boolean # Outcome
function CTLD:CanHoverLoad(Unit) end

---(Internal) Check if a unit is above ground.
---@param Unit? UNIT
---@return boolean # Outcome
---@return number # HeightAGL Measured height above ground in meters, or nil if no coordinate is available.
function CTLD:IsUnitInAir(Unit) end

---(Internal) Autoload if we can do crates, have capacity free and are in a load zone.
---@param Unit? UNIT
---@return CTLD # self
function CTLD:AutoHoverLoad(Unit) end

---(Internal) Run through all pilots and see if we autoload.
---@return CTLD # self
function CTLD:CheckAutoHoverload() end

---(Internal) Run through DroppedTroops and capture alive units
---@return CTLD # self
function CTLD:CleanDroppedTroops() end

---User - Count both the stock and groups in the field for available cargo types. Counts only limited cargo items and only troops and vehicle/FOB crates!
---@param Restock? boolean If true, restock the cargo and troop items.
---@param Threshold? number Percentage below which to restock, used in conjunction with Restock (must be true). Defaults to 75 (percent).
---@return table # Table A table of contents with numbers.
function CTLD:_CountStockPlusInHeloPlusAliveGroups(Restock, Threshold) end

---User - function to add stock of a certain units type
---@param Name? string Name as defined in the generic unit entry.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:AddStockUnits(Name, Number) end

---User - function to set the stock of a certain units type
---@param Name? string Name as defined in the generic unit entry.
---@param Number? number Number of units/groups to be available. Nil or -1 equals unlimited
---@return CTLD # self
function CTLD:SetStockUnits(Name, Number) end

---User - function to get a table of units in stock (C-130 "Get units")
---@return table # Table Table of Stock, indexed by unit type name
function CTLD:GetStockUnits() end

---User - function to add stock of a certain troops type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:AddStockTroops(Name, Number) end

---User - function to add stock of a certain crates type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:AddStockCrates(Name, Number) end

---User - function to add stock of a certain crates type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:AddStockStatics(Name, Number) end

---User - function to set the stock of a certain crates type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to be available. Nil equals unlimited
---@return CTLD # self
function CTLD:SetStockCrates(Name, Number) end

---User - function to set the stock of a certain troops type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to be available. Nil equals unlimited
---@return CTLD # self
function CTLD:SetStockTroops(Name, Number) end

---User - function to set the stock of a certain statics type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to be available. Nil equals unlimited
---@return CTLD # self
function CTLD:SetStockStatics(Name, Number) end

---User - function to get a table of crates in stock
---@return table # Table Table of Stock, indexed by cargo type name
function CTLD:GetStockCrates() end

---User - function to get a table of troops in stock
---@return table # Table Table of Stock, indexed by cargo type name
function CTLD:GetStockTroops() end

---User - Query the cargo loaded from a specific unit
---@param Unit? UNIT The (client) unit to query.
---@return number # Troopsloaded
---@return number # Cratesloaded
---@return table # Cargo Table of #CTLD_CARGO objects
function CTLD:GetLoadedCargo(Unit) end

---User - function to get a table of statics cargo in stock
---@return table # Table Table of Stock, indexed by cargo type name
function CTLD:GetStockStatics() end

---User - function to remove stock of a certain troops type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:RemoveStockTroops(Name, Number) end

---User - function to remove stock of a certain crates type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:RemoveStockCrates(Name, Number) end

---User - function to remove stock of a certain statics type
---@param Name? string Name as defined in the generic cargo.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:RemoveStockStatics(Name, Number) end

---User - function to remove stock of a certain Units
---@param Name? string Name as defined in the AddUnits.
---@param Number? number Number of units/groups to add.
---@return CTLD # self
function CTLD:RemoveStockUnits(Name, Number) end

---(User) Get a generic #CTLD_CARGO entry from a group name, works for Troops and Vehicles, FOB, i.e. everything that is spawned as a GROUP object.
---@param GroupName? string The name to use for the search
---@return CTLD_CARGO # The cargo object or nil if not found
function CTLD:GetGenericCargoObjectFromGroupName(GroupName) end

---(Internal) Check on engineering teams
---@return CTLD # self
function CTLD:_CheckEngineers() end

---(User) Pre-populate troops in the field.
---@param Zone? ZONE The zone where to drop the troops.
---@param Cargo? CTLD_CARGO The #CTLD_CARGO object to spawn.
---@param Surfacetypes? table (Optional) Table of surface types. Can also be a single surface type. We will try max 1000 times to find the right type!
---@param PreciseLocation? boolean (Optional) Don't try to get a random position in the zone but use the dead center. Caution not to stack up stuff on another!
---@param Structure? string (Optional) String object describing the current structure of the injected group; mainly for load/save to keep current state setup.
---@param TimeStamp? number (Optional) Timestamp used internally on re-loading from disk.
---@return CTLD # self
function CTLD:InjectTroops(Zone, Cargo, Surfacetypes, PreciseLocation, Structure, TimeStamp) end

---(User) Pre-populate vehicles in the field.
---@param Zone? ZONE The zone where to drop the troops.
---@param Cargo? CTLD_CARGO The #CTLD_CARGO object to spawn.
---@param Surfacetypes? table (Optional) Table of surface types. Can also be a single surface type. We will try max 1000 times to find the right type!
---@param PreciseLocation? boolean (Optional) Don't try to get a random position in the zone but use the dead center. Caution not to stack up stuff on another!
---@param Structure? string (Optional) String object describing the current structure of the injected group; mainly for load/save to keep current state setup.
---@param TimeStamp? number (Optional) Timestamp used internally on re-loading from disk.
---@return CTLD # self
function CTLD:InjectVehicles(Zone, Cargo, Surfacetypes, PreciseLocation, Structure, TimeStamp) end

---(Internal) FSM Function onafterStart.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@return CTLD # self
function CTLD:onafterStart(From, Event, To) end

---(Internal) FSM Function onbeforeStatus.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@return CTLD # self
function CTLD:onbeforeStatus(From, Event, To) end

---(Internal) FSM Function onafterStatus.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@return CTLD # self
function CTLD:onafterStatus(From, Event, To) end

---(Internal) FSM Function onafterStop.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@return CTLD # self
function CTLD:onafterStop(From, Event, To) end

---(Internal) FSM Function onbeforeTroopsPickedUp.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo crate.
---@return CTLD # self
function CTLD:onbeforeTroopsPickedUp(From, Event, To, Group, Unit, Cargo) end

---(Internal) FSM Function onbeforeCratesPickedUp.
---@param From? string State .
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo crate. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew loaded!
---@return CTLD # self
function CTLD:onbeforeCratesPickedUp(From, Event, To, Group, Unit, Cargo) end

---(Internal) FSM Function onbeforeTroopsExtracted.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP Troops #GROUP Object.
---@param Groupname? string Name of the extracted #GROUP.
---@return CTLD # self
function CTLD:onbeforeTroopsExtracted(From, Event, To, Group, Unit, Troops, Groupname) end

---(Internal) FSM Function onbeforeTroopsDeployed.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP Troops #GROUP Object.
---@return CTLD # self
function CTLD:onbeforeTroopsDeployed(From, Event, To, Group, Unit, Troops) end

---(Internal) FSM Function onafterTroopsDeployed.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP Troops #GROUP Object.
---@param Type? CTLD.CargoZoneType|number|string Type of Cargo deployed
---@return CTLD # self
function CTLD:onafterTroopsDeployed(From, Event, To, Group, Unit, Troops, Type) end

---(Internal) FSM Function onbeforeCratesDropped.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects dropped. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew unloaded!
---@return CTLD # self
function CTLD:onbeforeCratesDropped(From, Event, To, Group, Unit, Cargotable) end

---(Internal) FSM Function OnAfterGetCrates.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects spawned via "Get".
---@return CTLD # self
function CTLD:OnAfterGetCrates(From, Event, To, Group, Unit, Cargotable) end

---(Internal) FSM Function OnAfterRemoveCratesNearby.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects spawned via "Get".
---@return CTLD # self
function CTLD:OnAfterRemoveCratesNearby(From, Event, To, Group, Unit, Cargotable) end

---(Internal) FSM Function onbeforeCratesBuild.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Vehicle? GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD # self
function CTLD:onbeforeCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---(Internal) FSM Function onafterCratesBuild.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Vehicle? GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD # self
function CTLD:onafterCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---(Internal) FSM Function onbeforeTroopsRTB.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param ZoneName? string Name of the Zone where the Troops have been RTB'd.
---@param ZoneObject? ZONE_Radius of the Zone where the Troops have been RTB'd.
---@return CTLD # self
function CTLD:onbeforeTroopsRTB(From, Event, To, Group, Unit, ZoneName, ZoneObject) end

---On before "Save" event. Checks if io and lfs are available.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving. Default is "CTLD_<alias>_Persist.csv".
function CTLD:onbeforeSave(From, Event, To, path, filename) end

---On after "Save" event. Player data is saved to file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is saved. If nil, file is saved in the DCS root installation directory or your "Saved Games" folder if lfs was desanitized.
---@param filename? string (Optional) File name for saving. Default is Default is "CTLD_<alias>_Persist.csv".
function CTLD:onafterSave(From, Event, To, path, filename) end

---On before "Load" event. Checks if io and lfs and the file are available.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CTLD_<alias>_Persist.csv".
function CTLD:onbeforeLoad(From, Event, To, path, filename) end

---On after "Load" event. Loads dropped units from file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CTLD_<alias>_Persist.csv".
function CTLD:onafterLoad(From, Event, To, path, filename) end

---Triggers the FSM event "Start". Starts the CTLD. Initializes parameters and starts event handlers.
function CTLD:Start() end

---Triggers the FSM event "Start" after a delay. Starts the CTLD. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function CTLD:__Start(delay) end

---Triggers the FSM event "Stop". Stops the CTLD and all its event handlers.
function CTLD:Stop() end

---Triggers the FSM event "Stop" after a delay. Stops the CTLD and all its event handlers.
---@param delay? number Delay in seconds.
function CTLD:__Stop(delay) end

---Triggers the FSM event "Status".
function CTLD:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function CTLD:__Status(delay) end

---Triggers the FSM event "Load".
function CTLD:Load() end

---Triggers the FSM event "Load" after a delay.
---@param delay? number Delay in seconds.
function CTLD:__Load(delay) end

---Triggers the FSM event "Save".
function CTLD:Load() end

---Triggers the FSM event "Save" after a delay.
---@param delay? number Delay in seconds.
function CTLD:__Save(delay) end

---FSM Function OnBeforeTroopsPickedUp.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo troops.
---@return CTLD # self
function CTLD:OnBeforeTroopsPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnBeforeTroopsExtracted.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP extracted.
---@param Troopname? string Name of the extracted group.
---@return CTLD # self
function CTLD:OnBeforeTroopsExtracted(From, Event, To, Group, Unit, Troops, Troopname) end

---FSM Function OnBeforeCratesPickedUp.
---@param From? string State .
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo crate. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew loaded!
---@return CTLD # self
function CTLD:OnBeforeCratesPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnBeforeTroopsDeployed.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP Troops #GROUP Object.
---@return CTLD # self
function CTLD:OnBeforeTroopsDeployed(From, Event, To, Group, Unit, Troops) end

---FSM Function OnBeforeCratesDropped.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects dropped. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew unloaded!
---@return CTLD # self
function CTLD:OnBeforeCratesDropped(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnBeforeCratesBuild.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Vehicle? GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD # self
function CTLD:OnBeforeCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnBeforeCratesRepaired.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Vehicle? GROUP The #GROUP object of the vehicle or FOB repaired.
---@return CTLD # self
function CTLD:OnBeforeCratesRepaired(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnBeforeCratesPacked.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo crate that was repacked.
---@param PackedGroup? GROUP Group object that is about to be packed.
---@return CTLD # self
function CTLD:OnBeforeCratesPacked(From, Event, To, Group, Unit, Cargo, PackedGroup) end

---FSM Function OnBeforeTroopsRTB.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param ZoneName? string Name of the Zone where the Troops have been RTB'd.
---@param ZoneObject? ZONE_Radius of the Zone where the Troops have been RTB'd.
function CTLD:OnBeforeTroopsRTB(From, Event, To, Group, Unit, ZoneName, ZoneObject) end

---FSM Function OnAfterTroopsPickedUp.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo troops.
---@return CTLD # self
function CTLD:OnAfterTroopsPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnAfterTroopsExtracted.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP extracted.
---@param Troopname? string Name of the extracted group.
---@return CTLD # self
function CTLD:OnAfterTroopsExtracted(From, Event, To, Group, Unit, Troops, Troopname) end

---FSM Function OnAfterCratesPickedUp.
---@param From? string State .
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO cargo crates. Can be a Wrapper.DynamicCargo#DYNAMICCARGO objects, if ground crew loaded!
---@return CTLD # self
function CTLD:OnAfterCratesPickedUp(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnAfterTroopsDeployed.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Troops? GROUP Troops #GROUP Object.
---@return CTLD # self
function CTLD:OnAfterTroopsDeployed(From, Event, To, Group, Unit, Troops) end

---FSM Function OnAfterCratesDropped.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects dropped. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew unloaded!
---@return CTLD # self
function CTLD:OnAfterCratesDropped(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnAfterGetCrates.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects spawned via "Get".
---@return CTLD # self
function CTLD:OnAfterGetCrates(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnAfterRemoveCratesNearby.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargotable? table Table of #CTLD_CARGO objects removed nearby.
---@return CTLD # self
function CTLD:OnAfterRemoveCratesNearby(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnAfterCratesBuild.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Vehicle? GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD # self
function CTLD:OnAfterCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnAfterCratesBuildStarted. Info event that a build has been started.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param The? CargoName name of the cargo being built.
---@return CTLD # self
function CTLD:OnAfterCratesBuildStarted(From, Event, To, Group, Unit, The) end

---FSM Function OnAfterCratesRepairStarted. Info event that a repair has been started.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@return CTLD # self
function CTLD:OnAfterCratesRepairStarted(From, Event, To, Group, Unit) end

---FSM Function OnBeforeCratesBuildStarted. Info event that a build has been started.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@return CTLD # self
function CTLD:OnBeforeCratesBuildStarted(From, Event, To, Group, Unit) end

---FSM Function OnBeforeCratesRepairStarted. Info event that a repair has been started.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@return CTLD # self
function CTLD:OnBeforeCratesRepairStarted(From, Event, To, Group, Unit) end

---FSM Function OnAfterCratesRepaired.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Vehicle? GROUP The #GROUP object of the vehicle or FOB repaired.
---@return CTLD # self
function CTLD:OnAfterCratesRepaired(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnAfterCratesPacked.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
---@param Cargo? CTLD_CARGO Cargo crate that was repacked. For direct C-130 packing this can also be a table of spawned packed cargo objects.
---@return CTLD # self
function CTLD:OnAfterCratesPacked(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnAfterTroopsRTB.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Group? GROUP Group Object.
---@param Unit? UNIT Unit Object.
function CTLD:OnAfterTroopsRTB(From, Event, To, Group, Unit) end

---FSM Function OnBeforeHelicopterLost.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Unitname? string The name of the unit lost.
---@param LostCargo? table Table of #CTLD_CARGO object which were aboard the helicopter/transportplane lost. Can be an empty table!
function CTLD:OnBeforeHelicopterLost(From, Event, To, Unitname, LostCargo) end

---FSM Function OnAfterHelicopterLost.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param Unitname? string The name of the unit lost.
---@param LostCargo? table Table of #CTLD_CARGO object which were aboard the helicopter/transportplane lost. Can be an empty table!
function CTLD:OnAfterHelicopterLost(From, Event, To, Unitname, LostCargo) end

---FSM Function OnAfterLoad.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for loading. Default is "CTLD_<alias>_Persist.csv".
function CTLD:OnAfterLoad(From, Event, To, path, filename) end

---FSM Function OnAfterLoaded.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param LoadedGroups? table Table of loaded groups, each entry is a table with three values: Group, TimeStamp and CargoType.
function CTLD:OnAfterLoaded(From, Event, To, LoadedGroups) end

---FSM Function OnAfterSave.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving. Default is "CTLD_<alias>_Persist.csv".
function CTLD:OnAfterSave(From, Event, To, path, filename) end
