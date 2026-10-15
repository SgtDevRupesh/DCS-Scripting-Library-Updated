---@meta

---@class SPAWNSTATIC.TemplateData
---@field name string Name of the static.
---@field type string Type of the static.
---@field category string Category of the static.
---@field x number X-coordinate of the static.
---@field y number Y-coordinate of teh static.
---@field heading number Heading in rad.
---@field dead boolean Static is dead if true.
---@field livery_id string Livery name.
---@field unitId number Unit ID.
---@field groupId number Group ID.
---@field offsets table Offset parameters when linked to a unit.
---@field mass number Cargo mass in kg.
---@field canCargo boolean Static can be a cargo.

---@class SPAWNSTATIC : BASE
---@field SpawnTemplatePrefix string Name of the template group.
---@field CountryID number Country ID.
---@field CoalitionID number Coalition ID.
---@field CategoryID number Category ID.
---@field SpawnIndex number Running number increased with each new Spawn.
---@field InitLinkUnit UNIT The unit the static is linked to.
---@field InitOffsetX number Link offset X coordinate.
---@field InitOffsetY number Link offset Y coordinate.
---@field InitOffsetAngle number Link offset angle in degrees.
---@field InitStaticHeading number Heading of the static.
---@field InitStaticLivery string Livery for aircraft.
---@field InitStaticShape string Shape of the static.
---@field InitStaticType string Type of the static.
---@field InitStaticCategory string Categrory of the static.
---@field InitStaticName string Name of the static.
---@field InitStaticCoordinate COORDINATE Coordinate where to spawn the static.
---@field InitStaticDead boolean Set static to be dead if true.
---@field InitStaticCargo boolean If true, static can act as cargo.
---@field InitStaticCargoMass number Mass of cargo in kg.
SPAWNSTATIC = {
  ClassName  = "SPAWNSTATIC",
  SpawnIndex = 0,
}

---Creates the main object to spawn a {Wrapper.Static} defined in the mission editor (ME).
---@param SpawnTemplateName? string Name of the static object in the ME. Each new static will have the name starting with this prefix.
---@param SpawnCountryID? country.id|number|string (Optional) The ID of the country.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:NewFromStatic(SpawnTemplateName, SpawnCountryID) end

---Creates the main object to spawn a {Wrapper.Static} given a template table.
---@param SpawnTemplate? table Template used for spawning.
---@param CountryID? country.id|number|string (Optional) The ID of the country. Default `country.id.USA`.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:NewFromTemplate(SpawnTemplate, CountryID) end

---Creates the main object to spawn a {Wrapper.Static} from a given type.
---NOTE that you have to init many other parameters as spawn coordinate etc.
---@param StaticType? string Type of the static.
---@param StaticCategory? any Category of the static, e.g. "Planes".
---@param CountryID? country.id|number|string (Optional) The ID of the country. Default `country.id.USA`.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:NewFromType(StaticType, StaticCategory, CountryID) end

---(Internal/Cargo) Init the resource table for STATIC object that should be spawned containing storage objects.
---NOTE that you have to init many other parameters as the resources.
---@param CombinedWeight? number (Optional) The weight this cargo object should have (some have fixed weights!), defaults to 1kg.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:_InitResourceTable(CombinedWeight) end

---(User/Cargo) Add to resource table for STATIC object that should be spawned containing storage objects. Inits the object table if necessary and sets it to be cargo for helicopters.
---@param Type? string Type of cargo. Known types are: STORAGE.Type.WEAPONS, STORAGE.Type.LIQUIDS, STORAGE.Type.AIRCRAFT. Liquids are fuel.
---@param Name? string Name of the cargo type. Liquids can be STORAGE.LiquidName.JETFUEL, STORAGE.LiquidName.GASOLINE, STORAGE.LiquidName.MW50 and STORAGE.LiquidName.DIESEL. The currently available weapon items are available in the `ENUMS.Storage.weapons`, e.g. `ENUMS.Storage.weapons.bombs.Mk_82Y`. Aircraft go by their typename.
---@param Amount? number of tons (liquids) or number (everything else) to add.
---@param CombinedWeight? number Combined weight to be set to this static cargo object. NOTE - some static cargo objects have fixed weights!
---@return SPAWNSTATIC # self
function SPAWNSTATIC:AddCargoResource(Type, Name, Amount, CombinedWeight) end

---(User/Cargo) Resets resource table to zero for STATIC object that should be spawned containing storage objects. Inits the object table if necessary and sets it to be cargo for helicopters.
---Handy if you spawn from cargo statics which have resources already set.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:ResetCargoResources() end

---Initialize heading of the spawned static.
---@param Coordinate? COORDINATE Position where the static is spawned.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitCoordinate(Coordinate) end

---Initialize heading of the spawned static.
---@param Heading? number The heading in degrees.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitHeading(Heading) end

---Initialize livery of the spawned static.
---@param LiveryName? string Name of the livery to use.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitLivery(LiveryName) end

---Initialize type of the spawned static.
---@param StaticType? string Type of the static, e.g. "FA-18C_hornet".
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitType(StaticType) end

---Initialize shape of the spawned static. Required by some but not all statics.
---@param StaticShape? string Shape of the static, e.g. "carrier_tech_USA".
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitShape(StaticShape) end

---Initialize parameters for spawning FARPs.
---@param CallsignID? number (Optional) Callsign ID. Default 1 (="London").
---@param Frequency? number (Optional) Frequency in MHz. Default 127.5 MHz.
---@param Modulation? number (Optional) Modulation 0=AM, 1=FM. Defaults to 0
---@param DynamicSpawns? boolean If true, allow Dynamic Spawns
---@param DynamicHotStarts? boolean If true, and DynamicSpawns is true, then allow Dynamic Spawns with hot starts.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitFARP(CallsignID, Frequency, Modulation, DynamicSpawns, DynamicHotStarts) end

---Initialize cargo mass.
---@param Mass? number Mass of the cargo in kg.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitCargoMass(Mass) end

---Initialize as cargo.
---@param IsCargo? boolean If true, this static can act as cargo.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitCargo(IsCargo) end

---Hide the static on the map view (visible to game master slots!).
---@param OnOff? boolean Defaults to true
---@return SPAWN # The SPAWN object
function SPAWNSTATIC:InitHiddenOnMap(OnOff) end

---Hide the static on MFDs (visible to game master slots!).
---@return SPAWN # The SPAWN object
function SPAWNSTATIC:InitHiddenOnMFD() end

---Hide the static on planner (visible to game master slots!).
---@return SPAWN # The SPAWN object
function SPAWNSTATIC:InitHiddenOnPlanner() end

---Initialize as dead.
---@param IsDead? boolean If true, this static is dead.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitDead(IsDead) end

---Initialize country of the spawned static. This determines the category.
---@param CountryID? string The country ID, e.g. country.id.USA.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitCountry(CountryID) end

---Initialize name prefix statics get. This will be appended by "#0001", "#0002" etc.
---@param NamePrefix? string Name prefix of statics spawned. Will append #0001, etc to the name.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitNamePrefix(NamePrefix) end

---Init link to a unit.
---@param Unit? UNIT The unit to which the static is linked.
---@param OffsetX? number Offset in X.
---@param OffsetY? number Offset in Y.
---@param OffsetAngle? number Offset angle in degrees.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitLinkToUnit(Unit, OffsetX, OffsetY, OffsetAngle) end

---Uses Disposition and other fallback logic to find a better and valid ground spawn position.
---NOTE: This is not a spawn randomizer.
---It will try to a find clear ground location avoiding trees, water, roads, runways, map scenery, other statics and other units in the area.
---Uses the initial position if it's a valid location.
---@param OnOff? boolean Enable/disable the feature.
---@param MaxRadius? number (Optional) Max radius to search for a valid ground location in meters. Default is 10 times the max radius of the static.
---@return SPAWNSTATIC # self
function SPAWNSTATIC:InitValidateAndRepositionStatic(OnOff, MaxRadius) end

---Allows to place a CallFunction hook when a new static spawns.
---The provided method will be called when a new group is spawned, including its given parameters.
---The first parameter of the SpawnFunction is the {Wrapper.Static#STATIC} that was spawned.
---@param SpawnCallBackFunction? function The function to be called when a group spawns.
---@param ... any
---@return SPAWNSTATIC # self
function SPAWNSTATIC:OnSpawnStatic(SpawnCallBackFunction, ...) end

---Spawn a new STATIC object.
---@param Heading? number (Optional) The heading of the static, which is a number in degrees from 0 to 360. Default is the heading of the template.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC # The static spawned.
function SPAWNSTATIC:Spawn(Heading, NewName) end

---Creates a new {Wrapper.Static} from a COORDINATE.
---@param PointVec2? COORDINATE The 2D coordinate where to spawn the static.
---@param Heading? number The heading of the static, which is a number in degrees from 0 to 360.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC # The static spawned.
function SPAWNSTATIC:SpawnFromPointVec2(PointVec2, Heading, NewName) end

---Creates a new {Wrapper.Static} from a COORDINATE.
---@param Coordinate? COORDINATE The 3D coordinate where to spawn the static.
---@param Heading? number (Optional) Heading The heading of the static in degrees. Default is 0 degrees.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC # The spawned STATIC object.
function SPAWNSTATIC:SpawnFromCoordinate(Coordinate, Heading, NewName) end

---Creates a new {Wrapper.Static} from a {Core.Zone}.
---@param Zone? ZONE_BASE The Zone where to spawn the static.
---@param Heading? number (Optional)The heading of the static in degrees. Default is the heading of the template.
---@param NewName? string (Optional) The name of the new static.
---@return STATIC # The static spawned.
function SPAWNSTATIC:SpawnFromZone(Zone, Heading, NewName) end

---Spawns a new static using a given template. Additionally, the country ID needs to be specified, which also determines the coalition of the spawned static.
---@param Template? SPAWNSTATIC.TemplateData|number|string Spawn unit template.
---@param CountryID? number The country ID.
---@return STATIC # The static spawned.
function SPAWNSTATIC:_SpawnStatic(Template, CountryID) end
