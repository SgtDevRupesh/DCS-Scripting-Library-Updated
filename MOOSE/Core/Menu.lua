---@meta

MENU_INDEX.MenuMission = {}

MENU_INDEX.MenuMission.Menus = {}

MENU_INDEX.Coalition = {}

MENU_INDEX.Group = {}

---@param ParentMenu? any
---@param MenuText? any
function MENU_INDEX:ParentPath(ParentMenu, MenuText) end

function MENU_INDEX:PrepareMission() end

---@param CoalitionSide? any
function MENU_INDEX:PrepareCoalition(CoalitionSide) end

---@param Group? GROUP
function MENU_INDEX:PrepareGroup(Group) end

---@param Path? any
function MENU_INDEX:HasMissionMenu(Path) end

---@param Path? any
---@param Menu? any
function MENU_INDEX:SetMissionMenu(Path, Menu) end

---@param Path? any
function MENU_INDEX:ClearMissionMenu(Path) end

---@param Coalition? any
---@param Path? any
function MENU_INDEX:HasCoalitionMenu(Coalition, Path) end

---@param Coalition? any
---@param Path? any
---@param Menu? any
function MENU_INDEX:SetCoalitionMenu(Coalition, Path, Menu) end

---@param Coalition? any
---@param Path? any
function MENU_INDEX:ClearCoalitionMenu(Coalition, Path) end

---@param Group? any
---@param Path? any
function MENU_INDEX:HasGroupMenu(Group, Path) end

---@param Group? any
---@param Path? any
---@param Menu? any
function MENU_INDEX:SetGroupMenu(Group, Path, Menu) end

---@param Group? any
---@param Path? any
function MENU_INDEX:ClearGroupMenu(Group, Path) end

---@param Group? any
function MENU_INDEX:Refresh(Group) end

---@class MENU_BASE : BASE
MENU_BASE = {
  ClassName = "MENU_BASE",
  MenuPath = nil,
  MenuText = "",
  MenuParentPath = nil,
}

---Constructor
---@param MenuText? any
---@param ParentMenu? any
---@return MENU_BASE
function MENU_BASE:New(MenuText, ParentMenu) end

---@param MenuText? any
---@param Menu? any
function MENU_BASE:SetParentMenu(MenuText, Menu) end

---@param MenuText? any
function MENU_BASE:ClearParentMenu(MenuText) end

---Sets a {Menu} to remove automatically the parent menu when the menu removed is the last child menu of that parent {Menu}.
---@param RemoveParent? boolean If true, the parent menu is automatically removed when this menu is the last child menu of that parent @{Menu}.
---@return MENU_BASE
function MENU_BASE:SetRemoveParent(RemoveParent) end

---Gets a {Menu} from a parent {Menu}
---@param MenuText? string The text of the child menu.
---@return MENU_BASE
function MENU_BASE:GetMenu(MenuText) end

---Sets a menu stamp for later prevention of menu removal.
---@param MenuStamp? any
---@return MENU_BASE
function MENU_BASE:SetStamp(MenuStamp) end

---Gets a menu stamp for later prevention of menu removal.
---@return MenuStamp
function MENU_BASE:GetStamp() end

---Sets a time stamp for later prevention of menu removal.
---@param MenuStamp? any
---@return MENU_BASE
function MENU_BASE:SetTime(MenuStamp) end

---Sets a tag for later selection of menu refresh.
---@param MenuTag? string A Tag or Key that will filter only menu items set with this key.
---@return MENU_BASE
function MENU_BASE:SetTag(MenuTag) end

---MENU_COMMAND_BASE
---@class MENU_COMMAND_BASE : MENU_BASE
---@field MenuCallHandler function
MENU_COMMAND_BASE = {
  ClassName = "MENU_COMMAND_BASE",
  CommandMenuFunction = nil,
  CommandMenuArgument = nil,
  MenuCallHandler = nil,
}

---Constructor
---@param MenuText? any
---@param ParentMenu? any
---@param CommandMenuFunction? any
---@param CommandMenuArguments? any
---@return MENU_COMMAND_BASE
function MENU_COMMAND_BASE:New(MenuText, ParentMenu, CommandMenuFunction, CommandMenuArguments) end

---This sets the new command function of a menu,
---so that if a menu is regenerated, or if command function changes,
---that the function set for the menu is loosely coupled with the menu itself!!!
---If the function changes, no new menu needs to be generated if the menu text is the same!!!
---@param CommandMenuFunction? any
---@return MENU_COMMAND_BASE
function MENU_COMMAND_BASE:SetCommandMenuFunction(CommandMenuFunction) end

---This sets the new command arguments of a menu,
---so that if a menu is regenerated, or if command arguments change,
---that the arguments set for the menu are loosely coupled with the menu itself!!!
---If the arguments change, no new menu needs to be generated if the menu text is the same!!!
---@param CommandMenuArguments? any
---@return MENU_COMMAND_BASE
function MENU_COMMAND_BASE:SetCommandMenuArguments(CommandMenuArguments) end

---MENU_MISSION
---@class MENU_MISSION : MENU_BASE
MENU_MISSION = {
  ClassName = "MENU_MISSION",
}

---MENU_MISSION constructor. Creates a new MENU_MISSION object and creates the menu for a complete mission file.
---@param MenuText? string The text for the menu.
---@param ParentMenu? table The parent menu. This parameter can be ignored if you want the menu to be located at the parent menu of DCS world (under F10 other).
---@return MENU_MISSION
function MENU_MISSION:New(MenuText, ParentMenu) end

---Refreshes a radio item for a mission
---@return MENU_MISSION
function MENU_MISSION:Refresh() end

---Removes the sub menus recursively of this MENU_MISSION. Note that the main menu is kept!
---@return MENU_MISSION
function MENU_MISSION:RemoveSubMenus() end

---Removes the main menu and the sub menus recursively of this MENU_MISSION.
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_MISSION:Remove(MenuStamp, MenuTag) end

---@class MENU_MISSION_COMMAND : MENU_COMMAND_BASE
MENU_MISSION_COMMAND = {
  ClassName = "MENU_MISSION_COMMAND",
}

---MENU_MISSION constructor. Creates a new radio command item for a complete mission file, which can invoke a function with parameters.
---@param MenuText? string The text for the menu.
---@param ParentMenu? MENU_MISSION The parent menu.
---@param CommandMenuFunction? any
---@param ... any
---@return MENU_MISSION_COMMAND # self
function MENU_MISSION_COMMAND:New(MenuText, ParentMenu, CommandMenuFunction, ...) end

---Refreshes a radio item for a mission
---@return MENU_MISSION_COMMAND
function MENU_MISSION_COMMAND:Refresh() end

---Removes a radio command item for a coalition
---@return nil
function MENU_MISSION_COMMAND:Remove() end

---MENU_COALITION
---@class MENU_COALITION : MENU_BASE
MENU_COALITION = {
  ClassName = "MENU_COALITION"
}

---MENU_COALITION constructor. Creates a new MENU_COALITION object and creates the menu for a complete coalition.
---@param Coalition? coalition.side|number|string The coalition owning the menu.
---@param MenuText? string The text for the menu.
---@param ParentMenu? table The parent menu. This parameter can be ignored if you want the menu to be located at the parent menu of DCS world (under F10 other).
---@return MENU_COALITION # self
function MENU_COALITION:New(Coalition, MenuText, ParentMenu) end

---Refreshes a radio item for a coalition
---@return MENU_COALITION
function MENU_COALITION:Refresh() end

---Removes the sub menus recursively of this MENU_COALITION. Note that the main menu is kept!
---@return MENU_COALITION
function MENU_COALITION:RemoveSubMenus() end

---Removes the main menu and the sub menus recursively of this MENU_COALITION.
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_COALITION:Remove(MenuStamp, MenuTag) end

---MENU_COALITION_COMMAND
---@class MENU_COALITION_COMMAND : MENU_COMMAND_BASE
MENU_COALITION_COMMAND = {
  ClassName = "MENU_COALITION_COMMAND"
}

---MENU_COALITION constructor. Creates a new radio command item for a coalition, which can invoke a function with parameters.
---@param Coalition? coalition.side|number|string The coalition owning the menu.
---@param MenuText? string The text for the menu.
---@param ParentMenu? MENU_COALITION The parent menu.
---@param CommandMenuFunction? any
---@param ... any
---@return MENU_COALITION_COMMAND
function MENU_COALITION_COMMAND:New(Coalition, MenuText, ParentMenu, CommandMenuFunction, ...) end

---Refreshes a radio item for a coalition
---@return MENU_COALITION_COMMAND
function MENU_COALITION_COMMAND:Refresh() end

---Removes a radio command item for a coalition
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_COALITION_COMMAND:Remove(MenuStamp, MenuTag) end

---@class MENU_GROUP : MENU_BASE
MENU_GROUP = {
  ClassName = "MENU_GROUP"
}

---MENU_GROUP constructor. Creates a new radio menu item for a group.
---@param Group? GROUP The Group owning the menu.
---@param MenuText? string The text for the menu.
---@param ParentMenu? table The parent menu.
---@return MENU_GROUP # self
function MENU_GROUP:New(Group, MenuText, ParentMenu) end

---Refreshes a new radio item for a group and submenus
---@return MENU_GROUP
function MENU_GROUP:Refresh() end

---Refreshes a new radio item for a group and submenus, ordering by (numerical) MenuTag
---@return MENU_GROUP
function MENU_GROUP:RefreshAndOrderByTag() end

---Removes the sub menus recursively of this MENU_GROUP.
---@param MenuStamp? any
---@param MenuTag? any
---@return MENU_GROUP # self
function MENU_GROUP:RemoveSubMenus(MenuStamp, MenuTag) end

---Removes the main menu and sub menus recursively of this MENU_GROUP.
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_GROUP:Remove(MenuStamp, MenuTag) end

---@class MENU_GROUP_COMMAND : MENU_COMMAND_BASE
MENU_GROUP_COMMAND = {
  ClassName = "MENU_GROUP_COMMAND"
}

---Creates a new radio command item for a group
---@param Group? GROUP The Group owning the menu.
---@param MenuText? any
---@param ParentMenu? any
---@param CommandMenuFunction? any
---@param ... any
---@return MENU_GROUP_COMMAND
function MENU_GROUP_COMMAND:New(Group, MenuText, ParentMenu, CommandMenuFunction, ...) end

---Refreshes a radio item for a group
---@return MENU_GROUP_COMMAND
function MENU_GROUP_COMMAND:Refresh() end

---Removes a menu structure for a group.
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_GROUP_COMMAND:Remove(MenuStamp, MenuTag) end

---@class MENU_GROUP_DELAYED : MENU_BASE
MENU_GROUP_DELAYED = {
  ClassName = "MENU_GROUP_DELAYED"
}

---MENU_GROUP_DELAYED constructor. Creates a new radio menu item for a group.
---@param Group? GROUP The Group owning the menu.
---@param MenuText? string The text for the menu.
---@param ParentMenu? table The parent menu.
---@return MENU_GROUP_DELAYED # self
function MENU_GROUP_DELAYED:New(Group, MenuText, ParentMenu) end

---Refreshes a new radio item for a group and submenus
---@return MENU_GROUP_DELAYED
function MENU_GROUP_DELAYED:Set() end

---Refreshes a new radio item for a group and submenus
---@return MENU_GROUP_DELAYED
function MENU_GROUP_DELAYED:Refresh() end

---Removes the sub menus recursively of this MENU_GROUP_DELAYED.
---@param MenuStamp? any
---@param MenuTag? any
---@return MENU_GROUP_DELAYED # self
function MENU_GROUP_DELAYED:RemoveSubMenus(MenuStamp, MenuTag) end

---Removes the main menu and sub menus recursively of this MENU_GROUP.
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_GROUP_DELAYED:Remove(MenuStamp, MenuTag) end

---@class MENU_GROUP_COMMAND_DELAYED : MENU_COMMAND_BASE
MENU_GROUP_COMMAND_DELAYED = {
  ClassName = "MENU_GROUP_COMMAND_DELAYED"
}

---Creates a new radio command item for a group
---@param Group? GROUP The Group owning the menu.
---@param MenuText? any
---@param ParentMenu? any
---@param CommandMenuFunction? any
---@param ... any
---@return MENU_GROUP_COMMAND_DELAYED
function MENU_GROUP_COMMAND_DELAYED:New(Group, MenuText, ParentMenu, CommandMenuFunction, ...) end

---Refreshes a radio item for a group
---@return MENU_GROUP_COMMAND_DELAYED
function MENU_GROUP_COMMAND_DELAYED:Set() end

---Refreshes a radio item for a group
---@return MENU_GROUP_COMMAND_DELAYED
function MENU_GROUP_COMMAND_DELAYED:Refresh() end

---Removes a menu structure for a group.
---@param MenuStamp? any
---@param MenuTag? any
---@return nil
function MENU_GROUP_COMMAND_DELAYED:Remove(MenuStamp, MenuTag) end
