---@meta

---@class SCORING : BASE
---@field Players table A collection of the current players that have joined the game.
---@field ScoringScenery SET_SCENERY
SCORING = {
  ClassName = "SCORING",
  ClassID = 0,
  Players = {},
  AutoSave = true,
  version = "1.18.5",
  ScoringScenery = nil, -- Core.Set#SET_SCENERY
  SceneryHitsInZone = false,
  LoadSave = false,
}

---Creates a new SCORING object to administer the scoring achieved by players.
---@param GameName? string The name of the game. This name is also logged in the CSV score file.
---@param SavePath? string (Optional) Path where to save the CSV files, defaults to your **<User>\\Saved Games\\DCS\\Logs** folder. See next two options.
---@param AutoSave? boolean (Optional) If passed as `false`, then swith autosave off. This stores a detailed table which will never be loaded again by SCORING (for e.g. Discord purposes).
---@param LoadSave? boolean (Optional) If passed as `true` save summary scores per player, and load at restart of the mission.
---@return SCORING # self
function SCORING:New(GameName, SavePath, AutoSave, LoadSave) end

---[Internal] Helper to load scores from disk at scoring start
---@return SCORING # self
function SCORING:_LoadPlayerSummaryScore() end

---Set a prefix string that will be displayed at each scoring message sent.
---@param DisplayMessagePrefix? string (Optional) (Default="Scoring: ") The scoring prefix string.
---@return SCORING
function SCORING:SetDisplayMessagePrefix(DisplayMessagePrefix) end

---Set the scale for scoring valid destroys (enemy destroys).
---A default calculated score is a value between 1 and 10.
---The scale magnifies the scores given to the players.
---@param Scale? number The scale of the score given.
function SCORING:SetScaleDestroyScore(Scale) end

---Set the scale for scoring penalty destroys (friendly destroys).
---A default calculated penalty is a value between 1 and 10.
---The scale magnifies the scores given to the players.
---@param Scale? number The scale of the score given.
---@return SCORING
function SCORING:SetScaleDestroyPenalty(Scale) end

---Add a {Wrapper.Unit} for additional scoring when the {Wrapper.Unit} is destroyed.
---Note that if there was already a {Wrapper.Unit} declared within the scoring with the same name,
---then the old {Wrapper.Unit}  will be replaced with the new {Wrapper.Unit}.
---@param ScoreUnit? UNIT The @{Wrapper.Unit} for which the Score needs to be given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddUnitScore(ScoreUnit, Score) end

---Removes a {Wrapper.Unit} for scoring when the {Wrapper.Unit} is destroyed.
---@param ScoreUnit? UNIT The @{Wrapper.Unit} for which the Score needs to be given.
---@return SCORING
function SCORING:RemoveUnitScore(ScoreUnit) end

---Add a {Wrapper.Static} for additional scoring when the {Wrapper.Static} is destroyed.
---Note that if there was already a {Wrapper.Static} declared within the scoring with the same name,
---then the old {Wrapper.Static}  will be replaced with the new {Wrapper.Static}.
---@param ScoreStatic? STATIC The @{Wrapper.Static} for which the Score needs to be given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddStaticScore(ScoreStatic, Score) end

---Add a {Wrapper.Static} for additional scoring when the {Wrapper.Static} is destroyed.
---Note that if there was already a {Wrapper.Static} declared within the scoring with the same name,
---then the old {Wrapper.Static}  will be replaced with the new {Wrapper.Static}.
---@param ScoreStatic? STATIC The @{Wrapper.Static} for which the Score needs to be given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddScoreStatic(ScoreStatic, Score) end

---Add a {Wrapper.Scenery} for additional scoring when the {Wrapper.Scenery} is destroyed.
---@param ScoreScenery? SCENERY The @{Wrapper.Scenery} for which the Score needs to be given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddScoreScenery(ScoreScenery, Score) end

---Removes a {Wrapper.Scenery} for scoring when the {Wrapper.Scenery} is destroyed.
---@param ScoreScenery? any
---@return SCORING
function SCORING:RemoveSceneryScore(ScoreScenery) end

---Specify a special additional score for a {Core.Set#SET_SCENERY}.
---@param Set? SET_SCENERY The @{Core.Set#SET_SCENERY} for which each @{Wrapper.Scenery} in the SET a Score is given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddScoreSetScenery(Set, Score) end

---Removes a {Wrapper.Static} for scoring when the {Wrapper.Static} is destroyed.
---@param ScoreStatic? UNIT The @{Wrapper.Static} for which the Score needs to be given.
---@return SCORING
function SCORING:RemoveStaticScore(ScoreStatic) end

---Specify a special additional score for a {Wrapper.Group}.
---@param ScoreGroup? GROUP The @{Wrapper.Group} for which each @{Wrapper.Unit} a Score is given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddScoreGroup(ScoreGroup, Score) end

---Specify a special additional score for a {Core.Set#SET_GROUP}.
---@param Set? SET_GROUP The @{Core.Set#SET_GROUP} for which each @{Wrapper.Unit} in each Group a Score is given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddScoreSetGroup(Set, Score) end

---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function Set:OnAfterAdded(From, Event, To, ObjectName, Object) end

---Specify a special additional score for a {Core.Set#SET_STATIC}.
---@param Set? SET_STATIC The @{Core.Set#SET_STATIC} for which each @{Wrapper.Static} in the SET a Score is given.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddScoreSetStatic(Set, Score) end

---@param From? any
---@param Event? any
---@param To? any
---@param ObjectName? any
---@param Object? any
function Set:OnAfterAdded(From, Event, To, ObjectName, Object) end

---Add a {Core.Zone} to define additional scoring when any object is destroyed in that zone.
---Note that if a {Core.Zone} with the same name is already within the scoring added, the {Core.Zone} (type) and Score will be replaced!
---This allows for a dynamic destruction zone evolution within your mission.
---@param ScoreZone? ZONE_BASE The @{Core.Zone} which defines the destruction score perimeters. Note that a zone can be a polygon or a moving zone.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddZoneScore(ScoreZone, Score) end

---Allow Scenery hits in Zones to count (no specific(!) scenery targets). NOTE - Allowing this can spam your scoring display!
---@return SCORING # self
function SCORING:EnableSceneryHitsinZones() end

---Disallow Scenery hits in Zones to count (no specific(!) scenery targets).
---@return SCORING # self
function SCORING:DisableSceneryHitsinZones() end

---Add a {Core.Set#SET_ZONE} to define additional scoring when any object is destroyed in that zone.
---Note that if a {Core.Zone} with the same name is already within the scoring added, the {Core.Zone} (type) and Score will be replaced!
---This allows for a dynamic destruction zone evolution within your mission.
---@param ScoreZoneSet? SET_ZONE The @{Core.Set#SET_ZONE} which defines the destruction score perimeters. Note that a zone can be a polygon or a moving zone.
---@param Score? number The Score value.
---@return SCORING
function SCORING:AddZoneScoreSet(ScoreZoneSet, Score) end

---Remove a {Core.Zone} for scoring.
---The scoring will search if any {Core.Zone} is added with the given name, and will remove that zone from the scoring.
---This allows for a dynamic destruction zone evolution within your mission.
---@param ScoreZone? ZONE_BASE The @{Core.Zone} which defines the destruction score perimeters. Note that a zone can be a polygon or a moving zone.
---@return SCORING
function SCORING:RemoveZoneScore(ScoreZone) end

---Configure to send messages after a target has been hit.
---@param OnOff? boolean If true is given, the messages are sent.
---@return SCORING
function SCORING:SetMessagesHit(OnOff) end

---Configure to increment score after a target has been hit.
---@param score? number amount of point to inclement score on each hit
---@return SCORING
function SCORING:SetScoreIncrementOnHit(score) end

---If to send messages after a target has been hit.
---@return boolean
function SCORING:IfMessagesHit() end

---Configure to send messages after a target has been destroyed.
---@param OnOff? boolean If true is given, the messages are sent.
---@return SCORING
function SCORING:SetMessagesDestroy(OnOff) end

---If to send messages after a target has been destroyed.
---@return boolean
function SCORING:IfMessagesDestroy() end

---Configure to send messages after a target has been destroyed and receives additional scores.
---@param OnOff? boolean If true is given, the messages are sent.
---@return SCORING
function SCORING:SetMessagesScore(OnOff) end

---If to send messages after a target has been destroyed and receives additional scores.
---@return boolean
function SCORING:IfMessagesScore() end

---Configure to send messages after a target has been hit in a zone, and additional score is received.
---@param OnOff? boolean If true is given, the messages are sent.
---@return SCORING
function SCORING:SetMessagesZone(OnOff) end

---If to send messages after a target has been hit in a zone, and additional score is received.
---@return boolean
function SCORING:IfMessagesZone() end

---Configure to send messages to all players.
---@return SCORING
function SCORING:SetMessagesToAll() end

---If to send messages to all players.
---@return boolean
function SCORING:IfMessagesToAll() end

---Configure to send messages to only those players within the same coalition as the player.
---@return SCORING
function SCORING:SetMessagesToCoalition() end

---If to send messages to only those players within the same coalition as the player.
---@return boolean
function SCORING:IfMessagesToCoalition() end

---When a player commits too much damage to friendlies, his penalty score will reach a certain level.
---Use this method to define the level when a player gets kicked.
---By default, the fratricide level is the default penalty multiplier * 2 for the penalty score.
---@param Fratricide? number The amount of maximum penalty that may be inflicted by a friendly player before he gets kicked.
---@return SCORING
function SCORING:SetFratricide(Fratricide) end

---Decide if fratricide is leading to penalties (true) or not (false)
---@param OnOff? boolean Switch for Fratricide
---@return SCORING
function SCORING:SwitchFratricide(OnOff) end

---Decide if a change of coalition is leading to penalties (true) or not (false)
---@param OnOff? boolean Switch for Coalition Changes.
---@return SCORING
function SCORING:SwitchTreason(OnOff) end

---When a player changes the coalition, he can receive a penalty score.
---Use the method {#SCORING.SetCoalitionChangePenalty}() to define the penalty when a player changes coalition.
---By default, the penalty for changing coalition is the default penalty scale.
---@param CoalitionChangePenalty? number The amount of penalty that is given.
---@return SCORING
function SCORING:SetCoalitionChangePenalty(CoalitionChangePenalty) end

---Sets the scoring menu.
---@param ScoringGroup? any
---@return SCORING
function SCORING:SetScoringMenu(ScoringGroup) end

---Add a new player entering a Unit.
---@param UnitData? UNIT
function SCORING:_AddPlayerFromUnit(UnitData) end

---Add a goal score for a player.
---The method takes the Player name for which the Goal score needs to be set.
---The GoalTag is a string or identifier that is taken into the CSV file scoring log to identify the goal.
---A free text can be given that is shown to the players.
---The Score can be both positive and negative.
---@param PlayerName? string The name of the Player.
---@param GoalTag? string The string or identifier that is used in the CSV file to identify the goal (sort or group later in Excel).
---@param Text? string A free text that is shown to the players.
---@param Score? number The score can be both positive or negative ( Penalty ).
function SCORING:AddGoalScorePlayer(PlayerName, GoalTag, Text, Score) end

---Add a goal score for a player.
---The method takes the PlayerUnit for which the Goal score needs to be set.
---The GoalTag is a string or identifier that is taken into the CSV file scoring log to identify the goal.
---A free text can be given that is shown to the players.
---The Score can be both positive and negative.
---@param PlayerUnit? UNIT The @{Wrapper.Unit} of the Player. Other Properties for the scoring are taken from this PlayerUnit, like coalition, type etc.
---@param GoalTag? string The string or identifier that is used in the CSV file to identify the goal (sort or group later in Excel).
---@param Text? string A free text that is shown to the players.
---@param Score? number The score can be both positive or negative ( Penalty ).
function SCORING:AddGoalScore(PlayerUnit, GoalTag, Text, Score) end

---Registers Scores the players completing a Mission Task.
---@param Mission? MISSION
---@param PlayerUnit? UNIT
---@param Text? string
---@param Score? number
function SCORING:_AddMissionTaskScore(Mission, PlayerUnit, Text, Score) end

---Registers Scores the players completing a Mission Task.
---@param Mission? MISSION
---@param PlayerName? string
---@param Text? string
---@param Score? number
function SCORING:_AddMissionGoalScore(Mission, PlayerName, Text, Score) end

---Registers Mission Scores for possible multiple players that contributed in the Mission.
---@param Mission? MISSION
---@param Text? string
---@param Score? number
function SCORING:_AddMissionScore(Mission, Text, Score) end

---Handles the OnBirth event for the scoring.
---@param Event? EVENTDATA
function SCORING:OnEventBirth(Event) end

---Handles the OnPlayerLeaveUnit event for the scoring.
---@param Event? EVENTDATA
function SCORING:OnEventPlayerLeaveUnit(Event) end

---Handles the OnHit event for the scoring.
---@param Event? EVENTDATA
function SCORING:_EventOnHit(Event) end

---Track  DEAD or CRASH events for the scoring.
---@param Event? EVENTDATA
function SCORING:_EventOnDeadOrCrash(Event) end

---Produce detailed report of player hit scores.
---@param PlayerName? string The name of the player.
---@return string # The report.
function SCORING:ReportDetailedPlayerHits(PlayerName) end

---Produce detailed report of player destroy scores.
---@param PlayerName? string The name of the player.
---@return string # The report.
function SCORING:ReportDetailedPlayerDestroys(PlayerName) end

---Produce detailed report of player penalty scores because of changing the coalition.
---@param PlayerName? string The name of the player.
---@return string # The report.
function SCORING:ReportDetailedPlayerCoalitionChanges(PlayerName) end

---Produce detailed report of player goal scores.
---@param PlayerName? string The name of the player.
---@return string # The report.
function SCORING:ReportDetailedPlayerGoals(PlayerName) end

---Produce detailed report of player penalty scores because of changing the coalition.
---@param PlayerName? string The name of the player.
---@return string # The report.
function SCORING:ReportDetailedPlayerMissions(PlayerName) end

---Report Group Score Summary
---@param PlayerGroup? GROUP The player group.
function SCORING:ReportScoreGroupSummary(PlayerGroup) end

---Report Group Score Detailed
---@param PlayerGroup? GROUP The player group.
function SCORING:ReportScoreGroupDetailed(PlayerGroup) end

---Report all players score
---@param PlayerGroup? GROUP The player group.
---@param JustScore? boolean If this is true, return just a table with playernames and overall scores.
---@return table # ReportTable Table returned if JustScore is true.
function SCORING:ReportScoreAllSummary(PlayerGroup, JustScore) end

---Opens a score CSV file to log the scores.
---@param sSeconds? number
---@return string # ClockString
function SCORING:SecondsToClock(sSeconds) end

---Opens a score CSV file to log the scores.
---@param ScoringCSV? string
---@return SCORING # self
function SCORING:OpenCSV(ScoringCSV) end

---Registers a score for a player.
---@param PlayerName? string The name of the player.
---@param TargetPlayerName? string The name of the target player.
---@param ScoreType? string The type of the score.
---@param ScoreTimes? string The amount of scores achieved.
---@param ScoreAmount? string The score given.
---@param PlayerUnitName? string The unit name of the player.
---@param PlayerUnitCoalition? string The coalition of the player unit.
---@param PlayerUnitCategory? any The category of the player unit.
---@param PlayerUnitType? string The type of the player unit.
---@param TargetUnitName? string The name of the target unit.
---@param TargetUnitCoalition? string The coalition of the target unit.
---@param TargetUnitCategory? any The category of the target unit.
---@param TargetUnitType? string The type of the target unit.
---@return SCORING # self
function SCORING:ScoreCSV(PlayerName, TargetPlayerName, ScoreType, ScoreTimes, ScoreAmount, PlayerUnitName, PlayerUnitCoalition, PlayerUnitCategory, PlayerUnitType, TargetUnitName, TargetUnitCoalition, TargetUnitCategory, TargetUnitType) end

---Close CSV file
---@return SCORING # self
function SCORING:CloseCSV() end

---Registers a score for a player.
---@param OnOff? boolean Switch saving to CSV on = true or off = false
---@return SCORING # self
function SCORING:SwitchAutoSave(OnOff) end

---Handles the event when one player kill another player
---@param PlayerName? string The attacking player
---@param TargetPlayerName? string The name of the killed player
---@param IsTeamKill? boolean true if this kill was a team kill
---@param TargetThreatLevel? number Threat level of the target
---@param PlayerThreatLevel? number Threat level of the player
---@param Score? number The score based on both threat levels
function SCORING:OnKillPvP(PlayerName, TargetPlayerName, IsTeamKill, TargetThreatLevel, PlayerThreatLevel, Score) end

---Handles the event when one player kill another player
---@param PlayerName? string The attacking player
---@param TargetUnitName? string the name of the killed unit
---@param IsTeamKill? boolean true if this kill was a team kill
---@param TargetThreatLevel? number Threat level of the target
---@param PlayerThreatLevel? number Threat level of the player
---@param Score? number The score based on both threat levels
function SCORING:OnKillPvE(PlayerName, TargetUnitName, IsTeamKill, TargetThreatLevel, PlayerThreatLevel, Score) end
