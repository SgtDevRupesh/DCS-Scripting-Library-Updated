---@meta

---@class DESIGNATE : FSM_PROCESS
DESIGNATE = {
  ClassName = "DESIGNATE",
}

---DESIGNATE Constructor. This class is an abstract class and should not be instantiated.
---@param CC? GROUP Group as Commandcenter standin. Currently unused (03/2026)
---@param Detection? DETECTION_BASE
---@param AttackSet? SET_GROUP The Attack collection of GROUP objects to designate and report for.
---@return DESIGNATE
function DESIGNATE:New(CC, Detection, AttackSet) end

---Set the flashing of the status menu for all AttackGroups.
---@param FlashMenu? boolean true: the status menu will be flashed every detection run; false: no flashing of the menu.
---@return DESIGNATE
function DESIGNATE:SetFlashStatusMenu(FlashMenu) end

---Set the flashing of the new detection messages.
---@param FlashDetectionMessage? boolean true: The detection message will be flashed every time a new detection was done; false: no messages will be displayed.
---@return DESIGNATE
function DESIGNATE:SetFlashDetectionMessages(FlashDetectionMessage) end

---Set the maximum amount of designations (target groups). This will put a limit on the amount of designations in scope.
---Using the menu system, the player can "forget" a designation, so that gradually a new designation can be put in scope when detected.
---@param MaximumDesignations? number
---@return DESIGNATE
function DESIGNATE:SetMaximumDesignations(MaximumDesignations) end

---Set the maximum ground designation distance.
---@param MaximumDistanceGroundDesignation? number Maximum ground designation distance in meters.
---@return DESIGNATE
function DESIGNATE:SetMaximumDistanceGroundDesignation(MaximumDistanceGroundDesignation) end

---Set the maximum air designation distance.
---@param MaximumDistanceAirDesignation? number Maximum air designation distance in meters.
---@return DESIGNATE
function DESIGNATE:SetMaximumDistanceAirDesignation(MaximumDistanceAirDesignation) end

---Set the overall maximum distance when designations can be accepted.
---@param MaximumDistanceDesignations? number Maximum distance in meters to accept designations.
---@return DESIGNATE
function DESIGNATE:SetMaximumDistanceDesignations(MaximumDistanceDesignations) end

---Set the maximum amount of markings FACs will do, per designated target group. This will limit the number of parallelly marked units of a target group.
---@param MaximumMarkings? number Maximum markings FACs will do, per designated target group.
---@return DESIGNATE
function DESIGNATE:SetMaximumMarkings(MaximumMarkings) end

---Set an array of possible laser codes.
---Each new lase will select a code from this table.
---@param LaserCodes? number[]
---@return DESIGNATE
function DESIGNATE:SetLaserCodes(LaserCodes) end

---Add a specific lase code to the designate lase menu to lase targets with a specific laser code.
---The MenuText will appear in the lase menu.
---@param LaserCode? number The specific laser code to be added to the lase menu.
---@param MenuText? string The text to be shown to the player. If you specify a %d in the MenuText, the %d will be replaced with the LaserCode specified.
---@return DESIGNATE
function DESIGNATE:AddMenuLaserCode(LaserCode, MenuText) end

---Removes a specific lase code from the designate lase menu.
---@param LaserCode? number The specific laser code that was set to be added to the lase menu.
---@return DESIGNATE
function DESIGNATE:RemoveMenuLaserCode(LaserCode) end

---Set the name of the designation. The name will appear in the menu.
---This method can be used to control different designations for different plane types.
---@param DesignateName? string
---@return DESIGNATE
function DESIGNATE:SetDesignateName(DesignateName) end

---Set the lase duration for designations.
---@param LaseDuration? number (Optional) The time in seconds a lase will continue to hold on target. The default is 120 seconds.
---@return DESIGNATE
function DESIGNATE:SetLaseDuration(LaseDuration) end

---Generate an array of possible laser codes.
---Each new lase will select a code from this table.
---The entered value can range from 1111 - 1788,
----- but the first digit of the series must be a 1 or 2
----- and the last three digits must be between 1 and 8.
--- The range used to be bugged so its not 1 - 8 but 0 - 7.
---function below will use the range 1-7 just in case
---@return DESIGNATE
function DESIGNATE:GenerateLaserCodes() end

---Set auto lase.
---Auto lase will start lasing targets immediately when these are in range.
---@param AutoLase? boolean (optional) true sets autolase on, false off. Default is off.
---@param Message? boolean (optional) true is send message, false or nil won't send a message. Default is no message sent.
---@return DESIGNATE
function DESIGNATE:SetAutoLase(AutoLase, Message) end

---Set priorization of Targets based on the **Threat Level of the Target** in an Air to Ground context.
---@param Prioritize? boolean
---@return DESIGNATE
function DESIGNATE:SetThreatLevelPrioritization(Prioritize) end

---[DEPRECATED DO NOT USE] Set the MISSION object for which designate will function.
---When a MISSION object is assigned, the menu for the designation will be located at the Mission Menu.
---@param Mission? MISSION The MISSION object.
---@return DESIGNATE
function DESIGNATE:SetMission(Mission) end

---@return DESIGNATE
function DESIGNATE:onafterDetect() end

---Adapt the designation scope according the detected items.
---@return DESIGNATE
function DESIGNATE:DesignationScope() end

---Coordinates the Auto Lase.
---@return DESIGNATE
function DESIGNATE:CoordinateLase() end

---Sends the status to the Attack Groups.
---@param MenuAttackGroup? any
---@return DESIGNATE
function DESIGNATE:SendStatus(MenuAttackGroup) end

---Sets the Designate Menu for one attack groups.
---@param AttackGroup? any
---@return DESIGNATE
function DESIGNATE:SetMenu(AttackGroup) end

---Sets the Designate Menu for all the attack groups.
---@return DESIGNATE
function DESIGNATE:SetDesignateMenu() end

---@param AttackGroup? any
function DESIGNATE:MenuStatus(AttackGroup) end

---@param AttackGroup? any
---@param Flash? any
function DESIGNATE:MenuFlashStatus(AttackGroup, Flash) end

---@param Index? any
function DESIGNATE:MenuForget(Index) end

---@param AutoLase? any
function DESIGNATE:MenuAutoLase(AutoLase) end

---@param Index? any
---@param Color? any
function DESIGNATE:MenuSmoke(Index, Color) end

---@param Index? any
function DESIGNATE:MenuIlluminate(Index) end

---@param Index? any
---@param Duration? any
function DESIGNATE:MenuLaseOn(Index, Duration) end

---@param Index? any
---@param Duration? any
---@param LaserCode? any
function DESIGNATE:MenuLaseCode(Index, Duration, LaserCode) end

---@param Index? any
---@param Duration? any
function DESIGNATE:MenuLaseOff(Index, Duration) end

---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@param Duration? any
---@param LaserCode? any
function DESIGNATE:onafterLaseOn(From, Event, To, Index, Duration, LaserCode) end

---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@param Duration? any
---@param LaserCodeRequested? any
---@return DESIGNATE
function DESIGNATE:onafterLasing(From, Event, To, Index, Duration, LaserCodeRequested) end

---@param From? any
---@param Event? any
---@param To? any
function Spot:OnAfterDestroyed(From, Event, To) end

---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@return DESIGNATE
function DESIGNATE:onafterLaseOff(From, Event, To, Index) end

---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@param Color? any
---@return DESIGNATE
function DESIGNATE:onafterSmoke(From, Event, To, Index, Color) end

---Illuminating
---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@return DESIGNATE
function DESIGNATE:onafterIlluminate(From, Event, To, Index) end

---DoneSmoking
---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@return DESIGNATE
function DESIGNATE:onafterDoneSmoking(From, Event, To, Index) end

---DoneIlluminating
---@param From? any
---@param Event? any
---@param To? any
---@param Index? any
---@return DESIGNATE
function DESIGNATE:onafterDoneIlluminating(From, Event, To, Index) end

---Detect Handler OnBefore for DESIGNATE
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function DESIGNATE:OnBeforeDetect(From, Event, To) end

---Detect Handler OnAfter for DESIGNATE
---@param From? string
---@param Event? string
---@param To? string
function DESIGNATE:OnAfterDetect(From, Event, To) end

---Detect Trigger for DESIGNATE
function DESIGNATE:Detect() end

---Detect Asynchronous Trigger for DESIGNATE
---@param Delay? number
function DESIGNATE:__Detect(Delay) end

---Illuminate Handler OnBefore for DESIGNATE
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function DESIGNATE:OnBeforeIlluminate(From, Event, To) end

---Illuminate Handler OnAfter for DESIGNATE
---@param From? string
---@param Event? string
---@param To? string
function DESIGNATE:OnAfterIlluminate(From, Event, To) end

---Illuminate Trigger for DESIGNATE
function DESIGNATE:Illuminate() end

---Illuminate Asynchronous Trigger for DESIGNATE
---@param Delay? number
function DESIGNATE:__Illuminate(Delay) end
