---@meta

---@class GOAL : FSM
GOAL = {
  ClassName = "GOAL",
}

GOAL.Players = {}

GOAL.TotalContributions = 0

---GOAL Constructor.
---@return GOAL
function GOAL:New() end

---Add a new contribution by a player.
---@param PlayerName? string The name of the player.
function GOAL:AddPlayerContribution(PlayerName) end

---@param PlayerName? any
function GOAL:GetPlayerContribution(PlayerName) end

---Get the players who contributed to achieve the goal.
---The result is a list of players, sorted by the name of the players.
---@return table # The list of players, indexed by the player name.
function GOAL:GetPlayerContributions() end

---Gets the total contributions that happened to achieve the goal.
---The result is a number.
---@return number # The total number of contributions. 0 is returned if there were no contributions (yet).
function GOAL:GetTotalContributions() end

---Validates if the goal is achieved.
---@return boolean # true if the goal is achieved.
function GOAL:IsAchieved() end

---Achieved State Handler OnLeave for GOAL
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function GOAL:OnLeaveAchieved(From, Event, To) end

---Achieved State Handler OnEnter for GOAL
---@param From? string
---@param Event? string
---@param To? string
function GOAL:OnEnterAchieved(From, Event, To) end

---Achieved Handler OnBefore for GOAL
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function GOAL:OnBeforeAchieved(From, Event, To) end

---Achieved Handler OnAfter for GOAL
---@param From? string
---@param Event? string
---@param To? string
function GOAL:OnAfterAchieved(From, Event, To) end

---Achieved Trigger for GOAL
function GOAL:Achieved() end

---Achieved Asynchronous Trigger for GOAL
---@param Delay? number
function GOAL:__Achieved(Delay) end
