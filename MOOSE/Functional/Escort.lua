---@meta

---@class MENUPARAM
---@field ParamSelf ESCORT
---@field ParamDistance number
---@field ParamFunction function
---@field ParamMessage string
MENUPARAM = {}

---@class ESCORT.MODE
---@field FOLLOW number
---@field MISSION number

---@class ESCORT : BASE
---@field EscortClient CLIENT
---@field EscortGroup GROUP
---@field EscortName string
---@field EscortMode ESCORT.MODE The mode the escort is in.
---@field FollowScheduler SCHEDULER The instance of the SCHEDULER class.
---@field FollowDistance number The current follow distance.
---@field ReportTargets boolean If true, nearby targets are reported.
---@field OptionReactionOnThreat AI.Option.Air.val.REACTION_ON_THREAT Which REACTION_ON_THREAT is set to the EscortGroup.
---@field Detection FunctionalMENU_GROUPDETECTION_BASE
ESCORT = {
  ClassName = "ESCORT",
  EscortName = nil, -- The Escort Name
  EscortClient = nil,
  EscortGroup = nil,
  EscortMode = 1,
  MODE = {
    FOLLOW = 1,
    MISSION = 2,
  },
  Targets = {}, -- The identified targets
  FollowScheduler = nil,
  ReportTargets = true,
  OptionROE = AI.Option.Air.val.ROE.OPEN_FIRE,
  OptionReactionOnThreat = AI.Option.Air.val.REACTION_ON_THREAT.ALLOW_ABORT_MISSION,
  SmokeDirectionVector = false,
  TaskPoints = {}
}

---ESCORT class constructor for an AI group
---@param EscortClient? CLIENT The client escorted by the EscortGroup.
---@param EscortGroup? GROUP The group AI escorting the EscortClient.
---@param EscortName? string Name of the escort.
---@param EscortBriefing? string (Optional) A text showing the ESCORT briefing to the player. Note that if no EscortBriefing is provided, the default briefing will be shown.
---@return ESCORT # self
function ESCORT:New(EscortClient, EscortGroup, EscortName, EscortBriefing) end

---Set a Detection method for the EscortClient to be reported upon.
---Detection methods are based on the derived classes from DETECTION_BASE.
---@param Detection? DETECTION_BASE
function ESCORT:SetDetection(Detection) end

---This function is for test, it will put on the frequency of the FollowScheduler a red smoke at the direction vector calculated for the escort to fly to.
---This allows to visualize where the escort is flying to.
---@param SmokeDirection? boolean If true, then the direction vector will be smoked.
function ESCORT:TestSmokeDirectionVector(SmokeDirection) end

---Defines the default menus
---@return ESCORT
function ESCORT:Menus() end

---Defines a menu slot to let the escort Join and Follow you at a certain distance.
---This menu will appear under **Navigation**.
---@param Distance? number The distance in meters that the escort needs to follow the client.
---@return ESCORT
function ESCORT:MenuFollowAt(Distance) end

---Defines a menu slot to let the escort hold at their current position and stay low with a specified height during a specified time in seconds.
---This menu will appear under **Hold position**.
---@param Height? number (Optional) parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds? number (Optional) parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat? string (Optional) parameter that shows the menu option text. The text string is formatted, and should contain two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return ESCORT # TODO: Implement Seconds parameter. Challenge is to first develop the "continue from last activity" function.
function ESCORT:MenuHoldAtEscortPosition(Height, Seconds, MenuTextFormat) end

---Defines a menu slot to let the escort hold at the client position and stay low with a specified height during a specified time in seconds.
---This menu will appear under **Navigation**.
---@param Height? number (Optional)  parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds? number (Optional)  parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat? string (Optional)  parameter that shows the menu option text. The text string is formatted, and should contain one or two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return ESCORT # TODO: Implement Seconds parameter. Challenge is to first develop the "continue from last activity" function.
function ESCORT:MenuHoldAtLeaderPosition(Height, Seconds, MenuTextFormat) end

---Defines a menu slot to let the escort scan for targets at a certain height for a certain time in seconds.
---This menu will appear under **Scan targets**.
---@param Height? number (Optional) parameter that sets the height in meters to let the escort orbit at the current location. The default value is 30 meters.
---@param Seconds? number (Optional) parameter that lets the escort orbit at the current position for a specified time. (not implemented yet). The default value is 0 seconds, meaning, that the escort will orbit forever until a sequent command is given.
---@param MenuTextFormat? string (Optional) parameter that shows the menu option text. The text string is formatted, and should contain one or two %d tokens in the string. The first for the Height, the second for the Time (if given). If no text is given, the default text will be displayed.
---@return ESCORT
function ESCORT:MenuScanForTargets(Height, Seconds, MenuTextFormat) end

---Defines a menu slot to let the escort disperse a flare in a certain color.
---This menu will appear under **Navigation**.
---The flare will be fired from the first unit in the group.
---@param MenuTextFormat? string (Optional) parameter that shows the menu option text. If no text is given, the default text will be displayed.
---@return ESCORT
function ESCORT:MenuFlare(MenuTextFormat) end

---Defines a menu slot to let the escort disperse a smoke in a certain color.
---This menu will appear under **Navigation**.
---Note that smoke menu options will only be displayed for ships and ground units. Not for air units.
---The smoke will be fired from the first unit in the group.
---@param MenuTextFormat? string (Optional) parameter that shows the menu option text. If no text is given, the default text will be displayed.
---@return ESCORT
function ESCORT:MenuSmoke(MenuTextFormat) end

---Defines a menu slot to let the escort report their current detected targets with a specified time interval in seconds.
---This menu will appear under **Report targets**.
---Note that if a report targets menu is not specified, no targets will be detected by the escort, and the attack and assisted attack menus will not be displayed.
---@param Seconds? number (Optional) parameter that lets the escort report their current detected targets after specified time interval in seconds. The default time is 30 seconds.
---@return ESCORT
function ESCORT:MenuReportTargets(Seconds) end

---Defines a menu slot to let the escort attack its detected targets using assisted attack from another escort joined also with the client.
---This menu will appear under **Request assistance from**.
---Note that this method needs to be preceded with the method MenuReportTargets.
---@return ESCORT
function ESCORT:MenuAssistedAttack() end

---Defines a menu to let the escort set its rules of engagement.
---All rules of engagement will appear under the menu **ROE**.
---@param MenuTextFormat? any
---@return ESCORT
function ESCORT:MenuROE(MenuTextFormat) end

---Defines a menu to let the escort set its evasion when under threat.
---All rules of engagement will appear under the menu **Evasion**.
---@param MenuTextFormat? any
---@return ESCORT
function ESCORT:MenuEvasion(MenuTextFormat) end

---Defines a menu to let the escort resume its mission from a waypoint on its route.
---All rules of engagement will appear under the menu **Resume mission from**.
---@return ESCORT
function ESCORT:MenuResumeMission() end

---@param OrbitGroup? any
---@param OrbitHeight? any
---@param OrbitSeconds? any
function ESCORT:_HoldPosition(OrbitGroup, OrbitHeight, OrbitSeconds) end

---@param Distance? any
function ESCORT:_JoinUpAndFollow(Distance) end

---JoinsUp and Follows a CLIENT.
---@param EscortGroup? GROUP
---@param EscortClient? CLIENT
---@param Distance? number
function ESCORT:JoinUpAndFollow(EscortGroup, EscortClient, Distance) end

---@param Color? any
---@param Message? any
function ESCORT:_Flare(Color, Message) end

---@param Color? any
---@param Message? any
function ESCORT:_Smoke(Color, Message) end

function ESCORT:_ReportNearbyTargetsNow() end

---@param ReportTargets? any
function ESCORT:_SwitchReportNearbyTargets(ReportTargets) end

---@param ScanDuration? any
function ESCORT:_ScanTargets(ScanDuration) end

---@param EscortGroup? GROUP
function _Resume(EscortGroup) end

---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
function ESCORT:_AttackTarget(DetectedItem) end

---@param EscortGroupAttack? any
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
function ESCORT:_AssistTarget(EscortGroupAttack, DetectedItem) end

---@param EscortROEFunction? any
---@param EscortROEMessage? any
function ESCORT:_ROE(EscortROEFunction, EscortROEMessage) end

---@param EscortROTFunction? any
---@param EscortROTMessage? any
function ESCORT:_ROT(EscortROTFunction, EscortROTMessage) end

---@param WayPoint? any
function ESCORT:_ResumeMission(WayPoint) end

---Registers the waypoints
---@return table
function ESCORT:RegisterRoute() end

function ESCORT:_FollowScheduler() end

---Report Targets Scheduler.
function ESCORT:_ReportTargetsScheduler() end
