---@meta

---@class SETTINGS : BASE
SETTINGS = {
  ClassName = "SETTINGS",
  ShowPlayerMenu = true,
  MenuShort = false,
  MenuStatic = false,
}

SETTINGS.__Enum = {}

---@class SETTINGS.__Enum.Era
---@field WWII number
---@field Korea number
---@field Cold number
---@field Modern number
SETTINGS.__Enum.Era = {
  WWII = 1,
  Korea = 2,
  Cold = 3,
  Modern = 4,
}

---SETTINGS constructor.
---@param PlayerName? string (Optional) Set settings for this player.
---@return SETTINGS
function SETTINGS:Set(PlayerName) end

---Set short text for menus on (*true*) or off (*false*).
---Short text are better suited for, e.g., VR.
---@param onoff? boolean If *true* use short menu texts. If *false* long ones (default).
function SETTINGS:SetMenutextShort(onoff) end

---Set menu to be static.
---@param onoff? boolean If *true* menu is static. If *false* menu will be updated after changes (default).
function SETTINGS:SetMenuStatic(onoff) end

---Sets the SETTINGS metric.
function SETTINGS:SetMetric() end

---Sets the SETTINGS default text locale.
---@param Locale? string
function SETTINGS:SetLocale(Locale) end

---Gets the SETTINGS text locale.
---@return string
function SETTINGS:GetLocale() end

---Gets if the SETTINGS is metric.
---@return boolean # true if metric.
function SETTINGS:IsMetric() end

---Sets the SETTINGS imperial.
function SETTINGS:SetImperial() end

---Gets if the SETTINGS is imperial.
---@return boolean # true if imperial.
function SETTINGS:IsImperial() end

---Sets the SETTINGS LL accuracy.
---@param LL_Accuracy? number
---@return SETTINGS
function SETTINGS:SetLL_Accuracy(LL_Accuracy) end

---Gets the SETTINGS LL accuracy.
---@return number
function SETTINGS:GetLL_DDM_Accuracy() end

---Sets the SETTINGS MGRS accuracy.
---@param MGRS_Accuracy? number 0 to 5
---@return SETTINGS
function SETTINGS:SetMGRS_Accuracy(MGRS_Accuracy) end

---Gets the SETTINGS MGRS accuracy.
---@return number
function SETTINGS:GetMGRS_Accuracy() end

---Sets the SETTINGS Message Display Timing of a MessageType
---@param MessageType? MESSAGE The type of the message.
---@param MessageTime? number The display time duration in seconds of the MessageType.
function SETTINGS:SetMessageTime(MessageType, MessageTime) end

---Gets the SETTINGS Message Display Timing of a MessageType
---@param MessageType? MESSAGE The type of the message.
---@return number
function SETTINGS:GetMessageTime(MessageType) end

---Sets A2G LL DMS
---@return SETTINGS
function SETTINGS:SetA2G_LL_DMS() end

---Sets A2G LL DDM
---@return SETTINGS
function SETTINGS:SetA2G_LL_DDM() end

---Is LL DMS
---@return boolean # true if LL DMS
function SETTINGS:IsA2G_LL_DMS() end

---Is LL DDM
---@return boolean # true if LL DDM
function SETTINGS:IsA2G_LL_DDM() end

---Sets A2G MGRS
---@return SETTINGS
function SETTINGS:SetA2G_MGRS() end

---Is MGRS
---@return boolean # true if MGRS
function SETTINGS:IsA2G_MGRS() end

---Sets A2G BRA
---@return SETTINGS
function SETTINGS:SetA2G_BR() end

---Is BRA
---@return boolean # true if BRA
function SETTINGS:IsA2G_BR() end

---Sets A2A BRA
---@return SETTINGS
function SETTINGS:SetA2A_BRAA() end

---Is BRA
---@return boolean # true if BRA
function SETTINGS:IsA2A_BRAA() end

---Sets A2A BULLS
---@return SETTINGS
function SETTINGS:SetA2A_BULLS() end

---Is BULLS
---@return boolean # true if BULLS
function SETTINGS:IsA2A_BULLS() end

---Sets A2A LL DMS
---@return SETTINGS
function SETTINGS:SetA2A_LL_DMS() end

---Sets A2A LL DDM
---@return SETTINGS
function SETTINGS:SetA2A_LL_DDM() end

---Is LL DMS
---@return boolean # true if LL DMS
function SETTINGS:IsA2A_LL_DMS() end

---Is LL DDM
---@return boolean # true if LL DDM
function SETTINGS:IsA2A_LL_DDM() end

---Sets A2A MGRS
---@return SETTINGS
function SETTINGS:SetA2A_MGRS() end

---Is MGRS
---@return boolean # true if MGRS
function SETTINGS:IsA2A_MGRS() end

---@param MenuGroup? GROUP Group for which to add menus.
---@param RootMenu? table Root menu table
---@return SETTINGS
function SETTINGS:SetSystemMenu(MenuGroup, RootMenu) end

---Sets the player menus on, so that the **Player setting menus** show up for the players.
---But only when a player exits and reenters the slot these settings will have effect!
---It is advised to use this method at the start of the mission.
---@return SETTINGS
function SETTINGS:SetPlayerMenuOn() end

---Sets the player menus off, so that the **Player setting menus** won't show up for the players.
---But only when a player exits and reenters the slot these settings will have effect!
---It is advised to use this method at the start of the mission.
---@return SETTINGS # self
function SETTINGS:SetPlayerMenuOff() end

---Updates the menu of the player seated in the PlayerUnit.
---@param PlayerUnit? CLIENT
---@return SETTINGS # self
function SETTINGS:SetPlayerMenu(PlayerUnit) end

---Removes the player menu from the PlayerUnit.
---@param PlayerUnit? CLIENT
---@return SETTINGS # self
function SETTINGS:RemovePlayerMenu(PlayerUnit) end

---@param MenuGroup? any
---@param RootMenu? any
---@param A2GSystem? any
function SETTINGS:A2GMenuSystem(MenuGroup, RootMenu, A2GSystem) end

---@param MenuGroup? any
---@param RootMenu? any
---@param A2ASystem? any
function SETTINGS:A2AMenuSystem(MenuGroup, RootMenu, A2ASystem) end

---@param MenuGroup? any
---@param RootMenu? any
---@param LL_Accuracy? any
function SETTINGS:MenuLL_DDM_Accuracy(MenuGroup, RootMenu, LL_Accuracy) end

---@param MenuGroup? any
---@param RootMenu? any
---@param MGRS_Accuracy? any
function SETTINGS:MenuMGRS_Accuracy(MenuGroup, RootMenu, MGRS_Accuracy) end

---@param MenuGroup? any
---@param RootMenu? any
---@param MW? any
function SETTINGS:MenuMWSystem(MenuGroup, RootMenu, MW) end

---@param MenuGroup? any
---@param RootMenu? any
---@param MessageType? any
---@param MessageTime? any
function SETTINGS:MenuMessageTimingsSystem(MenuGroup, RootMenu, MessageType, MessageTime) end

---@param PlayerUnit? any
---@param PlayerGroup? any
---@param PlayerName? any
---@param A2GSystem? any
function SETTINGS:MenuGroupA2GSystem(PlayerUnit, PlayerGroup, PlayerName, A2GSystem) end

---@param PlayerUnit? any
---@param PlayerGroup? any
---@param PlayerName? any
---@param A2ASystem? any
function SETTINGS:MenuGroupA2ASystem(PlayerUnit, PlayerGroup, PlayerName, A2ASystem) end

---@param PlayerUnit? any
---@param PlayerGroup? any
---@param PlayerName? any
---@param LL_Accuracy? any
function SETTINGS:MenuGroupLL_DDM_AccuracySystem(PlayerUnit, PlayerGroup, PlayerName, LL_Accuracy) end

---@param PlayerUnit? any
---@param PlayerGroup? any
---@param PlayerName? any
---@param MGRS_Accuracy? any
function SETTINGS:MenuGroupMGRS_AccuracySystem(PlayerUnit, PlayerGroup, PlayerName, MGRS_Accuracy) end

---@param PlayerUnit? any
---@param PlayerGroup? any
---@param PlayerName? any
---@param MW? any
function SETTINGS:MenuGroupMWSystem(PlayerUnit, PlayerGroup, PlayerName, MW) end

---@param PlayerUnit? any
---@param PlayerGroup? any
---@param PlayerName? any
---@param MessageType? any
---@param MessageTime? any
function SETTINGS:MenuGroupMessageTimingsSystem(PlayerUnit, PlayerGroup, PlayerName, MessageType, MessageTime) end

---Configures the era of the mission to be WWII.
---@return SETTINGS # self
function SETTINGS:SetEraWWII() end

---Configures the era of the mission to be Korea.
---@return SETTINGS # self
function SETTINGS:SetEraKorea() end

---Configures the era of the mission to be Cold war.
---@return SETTINGS # self
function SETTINGS:SetEraCold() end

---Configures the era of the mission to be Modern war.
---@return SETTINGS # self
function SETTINGS:SetEraModern() end
