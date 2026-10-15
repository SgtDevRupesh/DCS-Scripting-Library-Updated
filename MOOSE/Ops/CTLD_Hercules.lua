---@meta

---@class CTLD_HERCULES.CargoObject
---@field Cargo_Drop_Direction number
---@field Cargo_Contents table
---@field Cargo_Type_name string
---@field Container_Enclosed boolean
---@field ParatrooperGroupSpawn boolean
---@field Cargo_Country number
---@field offload_cargo boolean
---@field all_cargo_survive_to_the_ground boolean
---@field all_cargo_gets_destroyed boolean
---@field destroy_cargo_dropped_without_parachute boolean
---@field scheduleFunctionID TIMER

---**CTLD_HERCULES** class, extends Core.Base#BASE
---@class CTLD_HERCULES : BASE
---@field ClassName string
---@field lid string
---@field Name string
---@field Version string
CTLD_HERCULES = {
  ClassName = "CTLD_HERCULES",
  lid = "",
  Name = "",
  Version = "0.0.3",
}

---Define cargo types.
---@class CTLD_HERCULES.Types
---@field Type table Name of cargo type, container (boolean) in container or not.
CTLD_HERCULES.Types = {
  ["ATGM M1045 HMMWV TOW Air [7183lb]"] = {['name'] = "M1045 HMMWV TOW", ['container'] = true},
  ["ATGM M1045 HMMWV TOW Skid [7073lb]"] = {['name'] = "M1045 HMMWV TOW", ['container'] = false},
  ["APC M1043 HMMWV Armament Air [7023lb]"] = {['name'] = "M1043 HMMWV Armament", ['container'] = true},
  ["APC M1043 HMMWV Armament Skid [6912lb]"] = {['name'] = "M1043 HMMWV Armament", ['container'] = false},
  ["SAM Avenger M1097 Air [7200lb]"] = {['name'] = "M1097 Avenger", ['container'] = true},
  ["SAM Avenger M1097 Skid [7090lb]"] = {['name'] = "M1097 Avenger", ['container'] = false},
  ["APC Cobra Air [10912lb]"] = {['name'] = "Cobra", ['container'] = true},
  ["APC Cobra Skid [10802lb]"] = {['name'] = "Cobra", ['container'] = false},
  ["APC M113 Air [21624lb]"] = {['name'] = "M-113", ['container'] = true},
  ["APC M113 Skid [21494lb]"] = {['name'] = "M-113", ['container'] = false},
  ["Tanker M978 HEMTT [34000lb]"] = {['name'] = "M978 HEMTT Tanker", ['container'] = false},
  ["HEMTT TFFT [34400lb]"] = {['name'] = "HEMTT TFFT", ['container'] = false},
  ["SPG M1128 Stryker MGS [33036lb]"] = {['name'] = "M1128 Stryker MGS", ['container'] = false},
  ["AAA Vulcan M163 Air [21666lb]"] = {['name'] = "Vulcan", ['container'] = true},
  ["AAA Vulcan M163 Skid [21577lb]"] = {['name'] = "Vulcan", ['container'] = false},
  ["APC M1126 Stryker ICV [29542lb]"] = {['name'] = "M1126 Stryker ICV", ['container'] = false},
  ["ATGM M1134 Stryker [30337lb]"] = {['name'] = "M1134 Stryker ATGM", ['container'] = false},
  ["APC LAV-25 Air [22520lb]"] = {['name'] = "LAV-25", ['container'] = true},
  ["APC LAV-25 Skid [22514lb]"] = {['name'] = "LAV-25", ['container'] = false},
  ["M1025 HMMWV Air [6160lb]"] = {['name'] = "Hummer", ['container'] = true},
  ["M1025 HMMWV Skid [6050lb]"] = {['name'] = "Hummer", ['container'] = false},
  ["IFV M2A2 Bradley [34720lb]"] = {['name'] = "M-2 Bradley", ['container'] = false},
  ["IFV MCV-80 [34720lb]"] = {['name'] = "MCV-80", ['container'] = false},
  ["IFV BMP-1 [23232lb]"] = {['name'] = "BMP-1", ['container'] = false},
  ["IFV BMP-2 [25168lb]"] = {['name'] = "BMP-2", ['container'] = false},
  ["IFV BMP-3 [32912lb]"] = {['name'] = "BMP-3", ['container'] = false},
  ["ARV BRDM-2 Air [12320lb]"] = {['name'] = "BRDM-2", ['container'] = true},
  ["ARV BRDM-2 Skid [12210lb]"] = {['name'] = "BRDM-2", ['container'] = false},
  ["APC BTR-80 Air [23936lb]"] = {['name'] = "BTR-80", ['container'] = true},
  ["APC BTR-80 Skid [23826lb]"] = {['name'] = "BTR-80", ['container'] = false},
  ["APC BTR-82A Air [24998lb]"] = {['name'] = "BTR-82A", ['container'] = true},
  ["APC BTR-82A Skid [24888lb]"] = {['name'] = "BTR-82A", ['container'] = false},
  ["SAM ROLAND ADS [34720lb]"] = {['name'] = "Roland Radar", ['container'] = false},
  ["SAM ROLAND LN [34720b]"] = {['name'] = "Roland ADS", ['container'] = false},
  ["SAM SA-13 STRELA [21624lb]"] = {['name'] = "Strela-10M3", ['container'] = false},
  ["AAA ZSU-23-4 Shilka [32912lb]"] = {['name'] = "ZSU-23-4 Shilka", ['container'] = false},
  ["SAM SA-19 Tunguska 2S6 [34720lb]"] = {['name'] = "2S6 Tunguska", ['container'] = false},
  ["Transport UAZ-469 Air [3747lb]"] = {['name'] = "UAZ-469", ['container'] = true},
  ["Transport UAZ-469 Skid [3630lb]"] = {['name'] = "UAZ-469", ['container'] = false},
  ["AAA GEPARD [34720lb]"] = {['name'] = "Gepard", ['container'] = false},
  ["SAM CHAPARRAL Air [21624lb]"] = {['name'] = "M48 Chaparral", ['container'] = true},
  ["SAM CHAPARRAL Skid [21516lb]"] = {['name'] = "M48 Chaparral", ['container'] = false},
  ["SAM LINEBACKER [34720lb]"] = {['name'] = "M6 Linebacker", ['container'] = false},
  ["Transport URAL-375 [14815lb]"] = {['name'] = "Ural-375", ['container'] = false},
  ["Transport M818 [16000lb]"] = {['name'] = "M 818", ['container'] = false},
  ["IFV MARDER [34720lb]"] = {['name'] = "Marder", ['container'] = false},
  ["Transport Tigr Air [15900lb]"] = {['name'] = "Tigr_233036", ['container'] = true},
  ["Transport Tigr Skid [15730lb]"] = {['name'] = "Tigr_233036", ['container'] = false},
  ["IFV TPZ FUCH [33440lb]"] = {['name'] = "TPZ", ['container'] = false},
  ["IFV BMD-1 Air [18040lb]"] = {['name'] = "BMD-1", ['container'] = true},
  ["IFV BMD-1 Skid [17930lb]"] = {['name'] = "BMD-1", ['container'] = false},
  ["IFV BTR-D Air [18040lb]"] = {['name'] = "BTR_D", ['container'] = true},
  ["IFV BTR-D Skid [17930lb]"] = {['name'] = "BTR_D", ['container'] = false},
  ["EWR SBORKA Air [21624lb]"] = {['name'] = "Dog Ear radar", ['container'] = true},
  ["EWR SBORKA Skid [21624lb]"] = {['name'] = "Dog Ear radar", ['container'] = false},
  ["ART 2S9 NONA Air [19140lb]"] = {['name'] = "SAU 2-C9", ['container'] = true},
  ["ART 2S9 NONA Skid [19030lb]"] = {['name'] = "SAU 2-C9", ['container'] = false},
  ["ART GVOZDIKA [34720lb]"] = {['name'] = "SAU Gvozdika", ['container'] = false},
  ["APC MTLB Air [26400lb]"] = {['name'] = "MTLB", ['container'] = true},
  ["APC MTLB Skid [26290lb]"] = {['name'] = "MTLB", ['container'] = false},
}

---[User] Instantiate a new object
---@param Coalition? string Coalition side, "red", "blue" or "neutral"
---@param Alias? string Name of this instance
---@param CtldObject? CTLD CTLD instance to link into
---@return CTLD_HERCULES # self
function CTLD_HERCULES:New(Coalition, Alias, CtldObject) end

---[Internal] Function to check availability of templates
---@return CTLD_HERCULES # self
function CTLD_HERCULES:CheckTemplates() end

---[Internal] Function to spawn a soldier group of 10 units
---@param Cargo_Drop_initiator? GROUP
---@param Cargo_Drop_Position? COORDINATE
---@param Cargo_Type_name? string
---@param CargoHeading? number
---@param Cargo_Country? number
---@param GroupSpacing? number
---@return CTLD_HERCULES # self
function CTLD_HERCULES:Soldier_SpawnGroup(Cargo_Drop_initiator, Cargo_Drop_Position, Cargo_Type_name, CargoHeading, Cargo_Country, GroupSpacing) end

---[Internal] Function to spawn a group
---@param Cargo_Drop_initiator? GROUP
---@param Cargo_Drop_Position? COORDINATE
---@param Cargo_Type_name? string
---@param CargoHeading? number
---@param Cargo_Country? number
---@return CTLD_HERCULES # self
function CTLD_HERCULES:Cargo_SpawnGroup(Cargo_Drop_initiator, Cargo_Drop_Position, Cargo_Type_name, CargoHeading, Cargo_Country) end

---[Internal] Function to spawn static cargo
---@param Cargo_Drop_initiator? GROUP
---@param Cargo_Drop_Position? COORDINATE
---@param Cargo_Type_name? string
---@param CargoHeading? number
---@param dead? boolean
---@param Cargo_Country? number
---@return CTLD_HERCULES # self
function CTLD_HERCULES:Cargo_SpawnStatic(Cargo_Drop_initiator, Cargo_Drop_Position, Cargo_Type_name, CargoHeading, dead, Cargo_Country) end

---[Internal] Function to spawn cargo by type at position
---@param _name? any
---@param _pos? any
---@return CTLD_HERCULES # self
function CTLD_HERCULES:Cargo_SpawnDroppedAsCargo(_name, _pos) end

---[Internal] Spawn cargo objects
---@param Cargo_Drop_initiator? GROUP
---@param Cargo_Drop_Direction? number
---@param Cargo_Content_position? COORDINATE
---@param Cargo_Type_name? string
---@param Cargo_over_water? boolean
---@param Container_Enclosed? boolean
---@param ParatrooperGroupSpawn? boolean
---@param offload_cargo? boolean
---@param all_cargo_survive_to_the_ground? boolean
---@param all_cargo_gets_destroyed? boolean
---@param destroy_cargo_dropped_without_parachute? boolean
---@param Cargo_Country? number
---@return CTLD_HERCULES # self
function CTLD_HERCULES:Cargo_SpawnObjects(Cargo_Drop_initiator, Cargo_Drop_Direction, Cargo_Content_position, Cargo_Type_name, Cargo_over_water, Container_Enclosed, ParatrooperGroupSpawn, offload_cargo, all_cargo_survive_to_the_ground, all_cargo_gets_destroyed, destroy_cargo_dropped_without_parachute, Cargo_Country) end

---[Internal] Function to calculate object height
---@param group? GROUP The group for which to calculate the height
---@return number # height over ground
function CTLD_HERCULES:Calculate_Object_Height_AGL(group) end

---[Internal] Function to check surface type
---@param object? any
---@return number # height over ground
function CTLD_HERCULES:Check_SurfaceType(object) end

---[Internal] Function to track cargo objects
---@param cargo? CTLD_HERCULES.CargoObject|number|string
---@param initiator? GROUP
---@return number # height over ground
function CTLD_HERCULES:Cargo_Track(cargo, initiator) end

---[Internal] Function to calc north correction
---@param point? POINT_Vec3 Position Vec3
---@return number # north correction
function CTLD_HERCULES:Calculate_Cargo_Drop_initiator_NorthCorrection(point) end

---[Internal] Function to calc initiator heading
---@param Cargo_Drop_initiator? GROUP
---@return number # north corrected heading
function CTLD_HERCULES:Calculate_Cargo_Drop_initiator_Heading(Cargo_Drop_initiator) end

---[Internal] Function to initialize dropped cargo
---@param Initiator? GROUP
---@param Cargo_Contents? table Table 'weapon' from event data
---@param Cargo_Type_name? string Name of this cargo
---@param Container_Enclosed? boolean Is container?
---@param SoldierGroup? boolean Is soldier group?
---@param ParatrooperGroupSpawnInit? boolean Is paratroopers?
---@return CTLD_HERCULES # self
function CTLD_HERCULES:Cargo_Initialize(Initiator, Cargo_Contents, Cargo_Type_name, Container_Enclosed, SoldierGroup, ParatrooperGroupSpawnInit) end

---[Internal] Function to change cargotype per group (Wrench)
---@param key? number Carrier key id
---@param cargoType? string Type of cargo
---@param cargoNum? number Number of cargo objects
---@return CTLD_HERCULES # self
function CTLD_HERCULES:SetType(key, cargoType, cargoNum) end

---[Internal] Function to capture SHOT event
---@param Cargo_Drop_Event? EVENTDATA The event data
---@return CTLD_HERCULES # self
function CTLD_HERCULES:_HandleShot(Cargo_Drop_Event) end

---[Internal] Function to capture BIRTH event
---@param event? EVENTDATA The event data
---@return CTLD_HERCULES # self
function CTLD_HERCULES:_HandleBirth(event) end
