---@meta

---STORAGE class.
---@class STORAGE : BASE
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field warehouse Warehouse The DCS warehouse object.
---@field airbase Airbase The DCS airbase object.
---@field SaverTimer TIMER The TIMER for autosave.
STORAGE = {
  ClassName          = "STORAGE",
  verbose            =     0,
}

---Liquid types.
---@class STORAGE.Liquid
---@field JETFUEL number Jet fuel (0).
---@field GASOLINE number Aviation gasoline (1).
---@field MW50 number MW50 (2).
---@field DIESEL number Diesel (3).
STORAGE.Liquid = {
  JETFUEL = 0,
  GASOLINE = 1,
  MW50 = 2,
  DIESEL = 3,
}

---Liquid Names for the static cargo resource table.
---@class STORAGE.LiquidName
---@field JETFUEL number "jet_fuel".
---@field GASOLINE number "gasoline".
---@field MW50 number "methanol_mixture".
---@field DIESEL number "diesel".
STORAGE.LiquidName = {
   GASOLINE = "gasoline",
   DIESEL =    "diesel",
   MW50 =  "methanol_mixture",
   JETFUEL = "jet_fuel",  
}

---Storage types.
---@class STORAGE.Type
---@field WEAPONS number weapons.
---@field LIQUIDS number liquids. Also see #list<#STORAGE.Liquid> for types of liquids.
---@field AIRCRAFT number aircraft.
STORAGE.Type = {
  WEAPONS = "weapons",
  LIQUIDS = "liquids",
  AIRCRAFT = "aircrafts",
}

---STORAGE class version.
STORAGE.version = "0.1.5"

---Create a new STORAGE object from the DCS airbase object.
---@param AirbaseName? string Name of the airbase.
---@return STORAGE # self
function STORAGE:New(AirbaseName) end

---Create a new STORAGE object from an DCS static cargo object.
---@param StaticCargoName? string Unit name of the static.
---@return STORAGE # self
function STORAGE:NewFromStaticCargo(StaticCargoName) end

---Create a new STORAGE object from a Wrapper.DynamicCargo#DYNAMICCARGO object.
---@param DynamicCargoName? string Unit name of the dynamic cargo.
---@return STORAGE # self
function STORAGE:NewFromDynamicCargo(DynamicCargoName) end

---Airbases only - Find a STORAGE in the **_DATABASE** using the name associated airbase.
---@param AirbaseName? string The Airbase Name.
---@return STORAGE # self
function STORAGE:FindByName(AirbaseName) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return STORAGE # self
function STORAGE:SetVerbosity(VerbosityLevel) end

---Adds the passed amount of a given item to the warehouse.
---@param Name? string Name of the item to add.
---@param Amount? number Amount of items to add.
---@return STORAGE # self
function STORAGE:AddItem(Name, Amount) end

---Sets the specified amount of a given item to the warehouse.
---@param Name? string Name of the item.
---@param Amount? number Amount of items.
---@return STORAGE # self
function STORAGE:SetItem(Name, Amount) end

---Gets the amount of a given item currently present the warehouse.
---@param Name? string Name of the item.
---@return number # Amount of items.
function STORAGE:GetItemAmount(Name) end

---Removes the amount of the passed item from the warehouse.
---@param Name? string Name of the item.
---@param Amount? number Amount of items.
---@return STORAGE # self
function STORAGE:RemoveItem(Name, Amount) end

---Adds the passed amount of a given liquid to the warehouse.
---@param Type? number Type of liquid.
---@param Amount? number Amount of liquid to add.
---@return STORAGE # self
function STORAGE:AddLiquid(Type, Amount) end

---Sets the specified amount of a given liquid to the warehouse.
---@param Type? number Type of liquid.
---@param Amount? number Amount of liquid.
---@return STORAGE # self
function STORAGE:SetLiquid(Type, Amount) end

---Removes the amount of the given liquid type from the warehouse.
---@param Type? number Type of liquid.
---@param Amount? number Amount of liquid in kg to be removed.
---@return STORAGE # self
function STORAGE:RemoveLiquid(Type, Amount) end

---Gets the amount of a given liquid currently present the warehouse.
---@param Type? number Type of liquid.
---@return number # Amount of liquid in kg.
function STORAGE:GetLiquidAmount(Type) end

---Returns the name of the liquid from its numeric type.
---@param Type? number Type of liquid.
---@return string # Name of the liquid.
function STORAGE:GetLiquidName(Type) end

---Adds the amount of a given type of aircraft, liquid, weapon currently present the warehouse.
---@param Type? number Type of liquid or name of aircraft, weapon or equipment.
---@param Amount? number Amount of given type to add. Liquids in kg.
---@return STORAGE # self
function STORAGE:AddAmount(Type, Amount) end

---Removes the amount of a given type of aircraft, liquid, weapon from the warehouse.
---@param Type? number Type of liquid or name of aircraft, weapon or equipment.
---@param Amount? number Amount of given type to remove. Liquids in kg.
---@return STORAGE # self
function STORAGE:RemoveAmount(Type, Amount) end

---Sets the amount of a given type of aircraft, liquid, weapon currently present the warehouse.
---@param Type? number Type of liquid or name of aircraft, weapon or equipment.
---@param Amount? number of given type. Liquids in kg.
---@return STORAGE # self
function STORAGE:SetAmount(Type, Amount) end

---Gets the amount of a given type of aircraft, liquid, weapon currently present the warehouse.
---@param Type? number Type of liquid or name of aircraft, weapon or equipment.
---@return number # Amount of given type. Liquids in kg.
function STORAGE:GetAmount(Type) end

---Returns whether a given type of aircraft, liquid, weapon is set to be unlimited.
---@param Type? string Name of aircraft, weapon or equipment or type of liquid (as `#number`).
---@return boolean # If `true` the given type is unlimited or `false` otherwise.
function STORAGE:IsUnlimited(Type) end

---Returns whether a given type of aircraft, liquid, weapon is set to be limited.
---@param Type? number Type of liquid or name of aircraft, weapon or equipment.
---@return boolean # If `true` the given type is limited or `false` otherwise.
function STORAGE:IsLimited(Type) end

---Returns whether aircraft are unlimited.
---@return boolean # If `true` aircraft are unlimited or `false` otherwise.
function STORAGE:IsUnlimitedAircraft() end

---Returns whether liquids are unlimited.
---@return boolean # If `true` liquids are unlimited or `false` otherwise.
function STORAGE:IsUnlimitedLiquids() end

---Returns whether weapons and equipment are unlimited.
---@return boolean # If `true` weapons and equipment are unlimited or `false` otherwise.
function STORAGE:IsUnlimitedWeapons() end

---Returns whether aircraft are limited.
---@return boolean # If `true` aircraft are limited or `false` otherwise.
function STORAGE:IsLimitedAircraft() end

---Returns whether liquids are limited.
---@return boolean # If `true` liquids are limited or `false` otherwise.
function STORAGE:IsLimitedLiquids() end

---Returns whether weapons and equipment are limited.
---@return boolean # If `true` liquids are limited or `false` otherwise.
function STORAGE:IsLimitedWeapons() end

---Returns a full itemized list of everything currently in a warehouse. If a category is set to unlimited then the table will be returned empty.
---@param Item? string Name of item as #string or type of liquid as #number.
---@return table # Table of aircraft. Table is emtpy `{}` if number of aircraft is set to be unlimited.
---@return table # Table of liquids. Table is emtpy `{}` if number of liquids is set to be unlimited.
---@return table # Table of weapons and other equipment. Table is emtpy `{}` if number of liquids is set to be unlimited.
function STORAGE:GetInventory(Item) end

---Save the contents of a STORAGE to files in CSV format. Filenames created are the Filename given amended by "_Liquids", "_Aircraft" and "_Weapons" followed by a ".csv". Requires io and lfs to be desanitized to be working.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The base name of the files. Existing files will be overwritten.
---@return STORAGE # self
function STORAGE:SaveToFile(Path, Filename) end

---Load the contents of a STORAGE from files. Filenames searched for are the Filename given amended by "_Liquids", "_Aircraft" and "_Weapons" followed by a ".csv". Requires io and lfs to be desanitized to be working.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return STORAGE # self
function STORAGE:LoadFromFile(Path, Filename) end

---Start a STORAGE autosave process.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Interval? number (Optional) The interval, start after this many seconds and repeat every interval seconds. Defaults to 300.
---@param LoadOnce? boolean If LoadOnce is true or nil, we try to load saved storage first.
---@return STORAGE # self
function STORAGE:StartAutoSave(Path, Filename, Interval, LoadOnce) end

---Stop a running STORAGE autosave process.
---@return STORAGE # self
function STORAGE:StopAutoSave() end

---Try to find the #STORAGE object of one of the many "H"-Helipads in Syria. You need to put a (small, round) zone on top of it, because the name is not unique(!).
---@param ZoneName? string The name of the zone where to find the helipad.
---@return STORAGE # self or nil if not found.
function STORAGE:FindSyriaHHelipadWarehouse(ZoneName) end
