---@meta

---FORMATION class
---@class FORMATION : FSM_SET
---@field FollowUnit UNIT
---@field FollowGroupSet SET_GROUP
---@field FollowName string
---@field FollowScheduler SCHEDULER The instance of the SCHEDULER class.
---@field FollowDistance number The current follow distance.
---@field OptionROE AI.Option.Air.val.ROE Which ROE is set to the FollowGroup.
---@field OptionReactionOnThreat AI.Option.Air.val.REACTION_ON_THREAT Which REACTION_ON_THREAT is set to the FollowGroup.
---@field dtFollow number Time step between position updates.
FORMATION = {
  ClassName = "FORMATION",
  FollowName = nil, -- The Follow Name
  FollowUnit = nil,
  FollowGroupSet = nil,
  FollowScheduler = nil,
  OptionROE = AI.Option.Air.val.ROE.OPEN_FIRE,
  OptionReactionOnThreat = AI.Option.Air.val.REACTION_ON_THREAT.ALLOW_ABORT_MISSION,
  dtFollow = 0.5,
}

---@class FORMATION.Formation
---@field None number
---@field Line number
---@field Trail number
---@field Stack number
---@field LeftLine number
---@field RightLine number
---@field LeftWing number
---@field RightWing number
---@field Vic number
---@field Box number
FORMATION.Formation = {
  None = 1,
  Line = 2,
  Trail = 3,
  Stack = 4,
  LeftLine = 5,
  RightLine = 6,
  LeftWing = 7,
  RightWing = 8,
  Vic = 9,
  Box = 10,
}

---FORMATION class constructor for an AI group
---@param FollowUnit? UNIT The UNIT leading the FolllowGroupSet.
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param FollowName? string Name of the escort.
---@return FORMATION # self
function FORMATION:New(FollowUnit, FollowGroupSet, FollowName) end

---Set time interval between updates of the formation.
---@param dt? number (Optional) Time step in seconds between formation updates. Default is every 0.5 seconds.
---@return FORMATION
function FORMATION:SetFollowTimeInterval(dt) end

---This function is for test, it will put on the frequency of the FollowScheduler a red smoke at the direction vector calculated for the escort to fly to.
---This allows to visualize where the escort is flying to.
---@param SmokeDirection? boolean If true, then the direction vector will be smoked.
---@return FORMATION
function FORMATION:TestSmokeDirectionVector(SmokeDirection) end

---FormationLine Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@param Formation? any
---@return FORMATION
function FORMATION:onafterFormationLine(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, Formation) end

---FormationTrail Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@return FORMATION
function FORMATION:onafterFormationTrail(FollowGroupSet, From, Event, To, XStart, XSpace, YStart) end

---FormationStack Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@return FORMATION
function FORMATION:onafterFormationStack(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace) end

---FormationLeftLine Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@return FORMATION
function FORMATION:onafterFormationLeftLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationRightLine Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@return FORMATION
function FORMATION:onafterFormationRightLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:onafterFormationLeftWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationRightWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:onafterFormationRightWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationCenterWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:onafterFormationCenterWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationVic Handle for FORMATION
---@param FollowGroupSet? any
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@return FORMATION
function FORMATION:onafterFormationVic(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationBox Handler OnAfter for FORMATION
---@param FollowGroupSet? any
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels? number The amount of levels on the Z-axis.
---@return FORMATION
function FORMATION:onafterFormationBox(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---Use the method {FORMATION#FORMATION.SetFlightRandomization}() to make the air units in your formation randomize their flight a bit while in formation.
---@param FlightRandomization? number The formation flying errors that pilots can make while in formation. Is a range set in meters.
---@return FORMATION
function FORMATION:SetFlightRandomization(FlightRandomization) end

---Stop function. Formation will not be updated any more.
---@param FollowGroupSet? SET_GROUP The following set of groups.
---@param From? string From state.
---@param Event? string Event.
---@param To? string The to state.
function FORMATION:onafterStop(FollowGroupSet, From, Event, To) end

---Follow event fuction. Check if coming from state "stopped". If so the transition is rejected.
---@param FollowGroupSet? SET_GROUP The following set of groups.
---@param From? string From state.
---@param Event? string Event.
---@param To? string The to state.
function FORMATION:onbeforeFollow(FollowGroupSet, From, Event, To) end

---Enter following state.
---@param FollowGroupSet? SET_GROUP The following set of groups.
function FORMATION:onenterFollowing(FollowGroupSet) end

---Follow me.
---@param FollowGroup? GROUP Follow group.
---@param ClientUnit? UNIT Client Unit.
---@param CT1? number Time
---@param CV1? Vec3 Vec3
---@param CT2? number Time
---@param CV2? Vec3 Vec3
function FORMATION:FollowMe(FollowGroup, ClientUnit, CT1, CV1, CT2, CV2) end

---Start Trigger for FORMATION
function FORMATION:Start() end

---Start Asynchronous Trigger for FORMATION
---@param Delay? number
function FORMATION:__Start(Delay) end

---Stop Trigger for FORMATION
function FORMATION:Stop() end

---Stop Asynchronous Trigger for FORMATION
---@param Delay? number
function FORMATION:__Stop(Delay) end

---FormationLine Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationLine(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLine Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationLine(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLine Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationLine(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationTrail Handler OnAfter for FORMATION
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
function FORMATION:OnAfterFormationTrail(From, Event, To, XStart, XSpace, YStart) end

---FormationTrail Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
function FORMATION:FormationTrail(XStart, XSpace, YStart) end

---FormationTrail Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
function FORMATION:__FormationTrail(Delay, XStart, XSpace, YStart) end

---FormationStack Handler OnAfter for FORMATION
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
function FORMATION:OnAfterFormationStack(From, Event, To, XStart, XSpace, YStart, YSpace) end

---FormationStack Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
function FORMATION:FormationStack(XStart, XSpace, YStart, YSpace) end

---FormationStack Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
function FORMATION:__FormationStack(Delay, XStart, XSpace, YStart, YSpace) end

---FormationLeftLine Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationLeftLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationLeftLine Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationLeftLine(XStart, YStart, ZStart, ZSpace) end

---FormationLeftLine Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationLeftLine(Delay, XStart, YStart, ZStart, ZSpace) end

---FormationRightLine Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationRightLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationRightLine Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationRightLine(XStart, YStart, ZStart, ZSpace) end

---FormationRightLine Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationRightLine(Delay, XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationLeftWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLeftWing Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationLeftWing(XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLeftWing Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationLeftWing(Delay, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationRightWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationRightWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationRightWing Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationRightWing(XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationRightWing Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationRightWing(Delay, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationCenterWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationCenterWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationCenterWing Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationCenterWing(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationCenterWing Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationCenterWing(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationVic Handler OnAfter for FORMATION
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationVic(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationVic Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:FormationVic(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationVic Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:__FormationVic(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationBox Handler OnAfter for FORMATION
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels? number The amount of levels on the Z-axis.
function FORMATION:OnAfterFormationBox(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationBox Trigger for FORMATION
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels? number The amount of levels on the Z-axis.
function FORMATION:FormationBox(XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationBox Asynchronous Trigger for FORMATION
---@param Delay? number
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param YSpace? number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels? number The amount of levels on the Z-axis.
function FORMATION:__FormationBox(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationRightWing Handler OnAfter for FORMATION
---@param FollowGroupSet? SET_GROUP The group AI escorting the FollowUnit.
---@param From? string
---@param Event? string
---@param To? string
---@param XStart? number The start position on the X-axis in meters for the first group.
---@param XSpace? number The space between groups on the X-axis in meters for each sequent group.
---@param YStart? number The start position on the Y-axis in meters for the first group.
---@param ZStart? number The start position on the Z-axis in meters for the first group.
---@param ZSpace? number The space between groups on the Z-axis in meters for each sequent group.
function FORMATION:OnAfterFormationRightWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end
