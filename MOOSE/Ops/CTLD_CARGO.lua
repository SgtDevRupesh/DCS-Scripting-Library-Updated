---@meta

---@class CTLD_CARGO.Enum
---@field VEHICLE string
---@field TROOPS string
---@field FOB string
---@field CRATE string
---@field REPAIR string
---@field ENGINEERS string
---@field STATIC string
---@field GCLOADABLE string

---**CTLD_CARGO** class, extends Core.Base#BASE
---@class CTLD_CARGO : BASE
---@field ClassName string Class name.
---@field ID number ID of this cargo.
---@field Name string Name for menu.
---@field DisplayName string Display name for menu/messages.
---@field Templates table Table of #POSITIONABLE objects.
---@field CargoType string Enumerator of Type.
---@field HasBeenMoved boolean Flag for moving.
---@field LoadDirectly boolean Flag for direct loading.
---@field CratesNeeded number Crates needed to build.
---@field Positionable POSITIONABLE Representation of cargo in the mission.
---@field HasBeenDropped boolean True if dropped from heli.
---@field PerCrateMass number Mass in kg.
---@field Stock number Number of builds available, -1 for unlimited.
---@field Subcategory string Sub-category name.
---@field DontShowInMenu boolean Show this item in menu or not.
---@field Location ZONE Location (if set) where to get this cargo item.
---@field ResourceMap table Resource Map information table if it has been set for static cargo items.
---@field StaticShape string Individual shape if set.
---@field StaticType string Individual type if set.
---@field StaticCategory string Individual static category if set.
---@field TypeNames string[] Table of unit types able to pick this cargo up.
---@field Stock0 number Initial stock, if any given.
CTLD_CARGO = {
  ClassName = "CTLD_CARGO",
  ID = 0,
  Name = "none",
  DisplayName = "none",
  Templates = {},
  CargoType = "none",
  HasBeenMoved = false,
  LoadDirectly = false,
  CratesNeeded = 0,
  Positionable = nil,
  HasBeenDropped = false,
  PerCrateMass = 0,
  Stock = nil,
  Stock0 = nil,
  Mark = nil,
  DontShowInMenu = false,
  Location = nil,
  }

---Function to create new CTLD_CARGO object.
---@param ID? number ID of this #CTLD_CARGO
---@param Name? string Name for menu.
---@param Templates? table Table of #POSITIONABLE objects.
---@param Sorte? CTLD_CARGO.Enum|number|string Enumerator of Type.
---@param HasBeenMoved? boolean Flag for moving.
---@param LoadDirectly? boolean Flag for direct loading.
---@param CratesNeeded? number Crates needed to build.
---@param Positionable? POSITIONABLE Representation of cargo in the mission.
---@param Dropped? boolean Cargo/Troops have been unloaded from a chopper.
---@param PerCrateMass? number Mass in kg
---@param Stock? number Number of builds available, nil for unlimited
---@param Subcategory? string Name of subcategory, handy if using > 10 types to load.
---@param DontShowInMenu? boolean (Optional) Show this item in menu or not (default: false == show it).
---@param Location? ZONE (Optional) Where the cargo is available (one location only).
---@return CTLD_CARGO # self
function CTLD_CARGO:New(ID, Name, Templates, Sorte, HasBeenMoved, LoadDirectly, CratesNeeded, Positionable, Dropped, PerCrateMass, Stock, Subcategory, DontShowInMenu, Location) end

---Add specific static type and shape to this CARGO.
---@param Category? any
---@param TypeName? string
---@param ShapeName? string
---@return CTLD_CARGO # self
function CTLD_CARGO:SetStaticTypeAndShape(Category, TypeName, ShapeName) end

---Get the specific static type and shape from this CARGO if set.
---@return string # Category
---@return string # TypeName
---@return string # ShapeName
function CTLD_CARGO:GetStaticTypeAndShape() end

---Add specific unit types to this CARGO (restrict what types can pick this up).
---@param UnitTypes? string Unit type name, can also be a #list<#string> table of unit type names.
---@return CTLD_CARGO # self
function CTLD_CARGO:AddUnitTypeName(UnitTypes) end

---Check if a specific unit can carry this CARGO (restrict what types can pick this up).
---@param Unit? UNIT
---@return boolean # Outcome
function CTLD_CARGO:UnitCanCarry(Unit) end

---Add Resource Map information table
---@param ResourceMap? table
---@return CTLD_CARGO # self
function CTLD_CARGO:SetStaticResourceMap(ResourceMap) end

---Get Resource Map information table
---@return table # ResourceMap
function CTLD_CARGO:GetStaticResourceMap() end

---Query Location.
---@return ZONE # location or `nil` if not set
function CTLD_CARGO:GetLocation() end

---Query ID.
---@return number # ID
function CTLD_CARGO:GetID() end

---Query Subcategory
---@return string # SubCategory
function CTLD_CARGO:GetSubCat() end

---Query Mass.
---@return number # Mass in kg
function CTLD_CARGO:GetMass() end

---Query Name.
---@return string # Name
function CTLD_CARGO:GetName() end

---Set display name.
---@param DisplayName? string Display label used in menus/messages (optional).
---@return CTLD_CARGO # self
function CTLD_CARGO:SetDisplayName(DisplayName) end

---Query display name.
---@return string # Display name, or Name if not set
function CTLD_CARGO:GetDisplayName() end

---Query Templates.
---@return table # Templates
function CTLD_CARGO:GetTemplates() end

---Query has moved.
---@return boolean # Has moved
function CTLD_CARGO:HasMoved() end

---Query was dropped.
---@param hercOnly? boolean If true, only treat Herc drops as 'dropped'.
---@return boolean # Has been dropped.
function CTLD_CARGO:WasDropped(hercOnly) end

---Query directly loadable.
---@return boolean # loadable
function CTLD_CARGO:CanLoadDirectly() end

---Query number of crates or troopsize.
---@return number # Crates or size of troops.
function CTLD_CARGO:GetCratesNeeded() end

---Query type.
---@return CTLD_CARGO.Enum # Type
function CTLD_CARGO:GetType() end

---Query type.
---@return POSITIONABLE # Positionable
function CTLD_CARGO:GetPositionable() end

---Set HasMoved.
---@param moved? boolean
function CTLD_CARGO:SetHasMoved(moved) end

---Query if cargo has been loaded.
function CTLD_CARGO:Isloaded() end

---Set WasDropped.
---@param dropped? boolean
---@param isHercDrop? boolean set when _GetCrates is used by the herc
function CTLD_CARGO:SetWasDropped(dropped, isHercDrop) end

---Get Stock.
---@return number # Stock or -1 if unlimited.
function CTLD_CARGO:GetStock() end

---Get Stock0.
---@return number # Stock0 or -1 if unlimited.
function CTLD_CARGO:GetStock0() end

---Get relative Stock.
---@return number # Stock Percentage like 75, or -1 if unlimited.
function CTLD_CARGO:GetRelativeStock() end

---Add Stock.
---@param Number? number to add, none if nil.
---@return CTLD_CARGO # self
function CTLD_CARGO:AddStock(Number) end

---Remove Stock.
---@param Number? number to reduce, none if nil.
---@return CTLD_CARGO # self
function CTLD_CARGO:RemoveStock(Number) end

---Set Stock.
---@param Number? number to set, nil means unlimited.
---@return CTLD_CARGO # self
function CTLD_CARGO:SetStock(Number) end

---Query crate type for REPAIR
function CTLD_CARGO:IsRepair() end

---Query crate type for STATIC
---@return boolean
function CTLD_CARGO:IsStatic() end

---Add mark
---@param Mark? any
---@return CTLD_CARGO # self
function CTLD_CARGO:AddMark(Mark) end

---Get mark
---@param Mark? any
---@return string # Mark
function CTLD_CARGO:GetMark(Mark) end

---Wipe mark
---@return CTLD_CARGO # self
function CTLD_CARGO:WipeMark() end

---Get overall mass of a cargo object, i.e. crates needed x mass per crate
---@return number # mass
function CTLD_CARGO:GetNetMass() end

---**CTLD_ENGINEERING** class, extends Core.Base#BASE
---@class CTLD_ENGINEERING : BASE
---@field ClassName string
---@field lid string
---@field Name string
---@field Group GROUP
---@field Unit UNIT
---@field HeliGroup GROUP
---@field HeliUnit UNIT
---@field State string
CTLD_ENGINEERING = {
  ClassName = "CTLD_ENGINEERING",
  lid = "",
  Name = "none",
  Group = nil,
  Unit = nil,
  HeliGroup = nil,
  HeliUnit = nil,
  State = "",
  }

---Create a new instance.
---@param Name? string
---@param GroupName? string Name of Engineering #GROUP object
---@param HeliGroup? GROUP HeliGroup
---@param HeliUnit? UNIT HeliUnit
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:New(Name, GroupName, HeliGroup, HeliUnit) end

---(Internal) Set the status
---@param State? string
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:SetStatus(State) end

---(Internal) Get the status
---@return string # State
function CTLD_ENGINEERING:GetStatus() end

---(Internal) Check the status
---@param State? string
---@return boolean # Outcome
function CTLD_ENGINEERING:IsStatus(State) end

---(Internal) Check the negative status
---@param State? string
---@return boolean # Outcome
function CTLD_ENGINEERING:IsNotStatus(State) end

---(Internal) Set start status.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Start() end

---(Internal) Set stop status.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Stop() end

---(Internal) Set build status.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Build() end

---(Internal) Set done status.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Done() end

---(Internal) Search for crates in reach.
---@param crates? table Table of found crate Ops.CTLD#CTLD_CARGO objects.
---@param number? number Number of crates found.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Search(crates, number) end

---(Internal) Move towards crates in reach.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Move() end

---(Internal) Arrived at crates in reach. Stop group.
---@return CTLD_ENGINEERING # self
function CTLD_ENGINEERING:Arrive() end

---(Internal) Return distance in meters between two coordinates.
---@param _point1? COORDINATE Coordinate one
---@param _point2? COORDINATE Coordinate two
---@return number # Distance in meters or -1
function CTLD_ENGINEERING:_GetDistance(_point1, _point2) end
