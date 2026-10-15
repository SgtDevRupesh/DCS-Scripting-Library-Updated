---@meta

---FSM class
---@class FSM : BASE
---@field ClassName string Name of the class.
---@field CallScheduler SCHEDULER Call scheduler.
---@field options table Options.
---@field subs table Subs.
---@field Scores table Scores.
---@field current string Current state name.
FSM = {
  ClassName = "FSM",
}

---Creates a new FSM object.
---@return FSM
function FSM:New() end

---Sets the start state of the FSM.
---@param State? string A string defining the start state.
function FSM:SetStartState(State) end

---Returns the start state of the FSM.
---@return string # A string containing the start state.
function FSM:GetStartState() end

---Add a new transition rule to the FSM.
---A transition rule defines when and if the FSM can transition from a state towards another state upon a triggered event.
---@param From? table Can contain a string indicating the From state or a table of strings containing multiple From states.
---@param Event? string The Event name.
---@param To? string The To state.
function FSM:AddTransition(From, Event, To) end

---Returns a table of the transition rules defined within the FSM.
---@return table # Transitions.
function FSM:GetTransitions() end

---Set the default {#FSM_PROCESS} template with key ProcessName providing the ProcessClass and the process object when it is assigned to a {Wrapper.Controllable} by the task.
---@param From? table Can contain a string indicating the From state or a table of strings containing multiple From states.
---@param Event? string The Event name.
---@param Process? FSM_PROCESS An sub-process FSM.
---@param ReturnEvents? table A table indicating for which returned events of the SubFSM which Event must be triggered in the FSM.
---@return FSM_PROCESS # The SubFSM.
function FSM:AddProcess(From, Event, Process, ReturnEvents) end

---Returns a table of the SubFSM rules defined within the FSM.
---@return table # Sub processes.
function FSM:GetProcesses() end

---@param From? any
---@param Event? any
function FSM:GetProcess(From, Event) end

---@param From? any
---@param Event? any
---@param Fsm? any
function FSM:SetProcess(From, Event, Fsm) end

---Adds an End state.
---@param State? string The FSM state.
function FSM:AddEndState(State) end

---Returns the End states.
---@return table # End states.
function FSM:GetEndStates() end

---Adds a score for the FSM to be achieved.
---@param State? string is the state of the process when the score needs to be given. (See the relevant state descriptions of the process).
---@param ScoreText? string is a text describing the score that is given according the status.
---@param Score? number is a number providing the score of the status.
---@return FSM # self
function FSM:AddScore(State, ScoreText, Score) end

---Adds a score for the FSM_PROCESS to be achieved.
---@param From? string is the From State of the main process.
---@param Event? string is the Event of the main process.
---@param State? string is the state of the process when the score needs to be given. (See the relevant state descriptions of the process).
---@param ScoreText? string is a text describing the score that is given according the status.
---@param Score? number is a number providing the score of the status.
---@return FSM # self
function FSM:AddScoreProcess(From, Event, State, ScoreText, Score) end

---Returns a table with the scores defined.
---@return table # Scores.
function FSM:GetScores() end

---Returns a table with the Subs defined.
---@return table # Sub processes.
function FSM:GetSubs() end

---Load call backs.
---@param CallBackTable? table Table of call backs.
function FSM:LoadCallBacks(CallBackTable) end

---Event map.
---@param Events? table Events.
---@param EventStructure? table Event structure.
function FSM:_eventmap(Events, EventStructure) end

---Sub maps.
---@param subs? table Subs.
---@param sub? table Sub.
---@param name? string Name.
function FSM:_submap(subs, sub, name) end

---Call handler.
---@param step? string Step "onafter", "onbefore", "onenter", "onleave".
---@param trigger? string Trigger.
---@param params? table Parameters.
---@param EventName? string Event name.
---@return Value.
function FSM:_call_handler(step, trigger, params, EventName) end

---Handler.
---@param self FSM
---@param EventName? string Event name.
---@param ... any
function FSM._handler(self, EventName, ...) end

---Delayed transition.
---@param EventName? string Event name.
---@return function # Function.
function FSM:_delayed_transition(EventName) end

---Create transition.
---@param EventName? string Event name.
---@return function # Function.
function FSM:_create_transition(EventName) end

---Clear scheduled FSM event.
---@param EventName? string Event name.
function FSM:_ClearFSMEvent(EventName) end

---Go sub.
---@param ParentFrom? string Parent from state.
---@param ParentEvent? string Parent event name.
---@return table # Subs.
function FSM:_gosub(ParentFrom, ParentEvent) end

---Is end state.
---@param Current? string Current state name.
---@return table # FSM parent.
---@return string # Event name.
function FSM:_isendstate(Current) end

---Add to map.
---@param Map? table Map.
---@param Event? table Event table.
function FSM:_add_to_map(Map, Event) end

---Get current state.
---@return string # Current FSM state.
function FSM:GetState() end

---Get current state.
---@return string # Current FSM state.
function FSM:GetCurrentState() end

---Check if FSM is in state.
---@param State? string State name.
---@return boolean # If true, FSM is in this state.
function FSM:Is(State) end

---Check if FSM is in state.
---@param state? any
---@return boolean # If true, FSM is in this state.
function FSM:is(state) end

---Check if can do an event.
---@param e? string Event name.
---@return boolean # If true, FSM can do the event.
---@return string # To state.
function FSM:can(e) end

---Check if cannot do an event.
---@param e? string Event name.
---@return boolean # If true, FSM cannot do the event.
function FSM:cannot(e) end

---@class FSM_CONTROLLABLE : FSM
---@field Controllable CONTROLLABLE
FSM_CONTROLLABLE = {
  ClassName = "FSM_CONTROLLABLE",
}

---Creates a new FSM_CONTROLLABLE object.
---@param Controllable? CONTROLLABLE (optional) The CONTROLLABLE object that the FSM_CONTROLLABLE governs.
---@return FSM_CONTROLLABLE
function FSM_CONTROLLABLE:New(Controllable) end

---OnAfter Transition Handler for Event Stop.
---@param Controllable? CONTROLLABLE The Controllable Object managed by the FSM.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function FSM_CONTROLLABLE:OnAfterStop(Controllable, From, Event, To) end

---Sets the CONTROLLABLE object that the FSM_CONTROLLABLE governs.
---@param FSMControllable? CONTROLLABLE
---@return FSM_CONTROLLABLE
function FSM_CONTROLLABLE:SetControllable(FSMControllable) end

---Gets the CONTROLLABLE object that the FSM_CONTROLLABLE governs.
---@return CONTROLLABLE
function FSM_CONTROLLABLE:GetControllable() end

---@param step? any
---@param trigger? any
---@param params? any
---@param EventName? any
function FSM_CONTROLLABLE:_call_handler(step, trigger, params, EventName) end

---@class FSM_PROCESS : FSM_CONTROLLABLE
---@field Task TASK
FSM_PROCESS = { ClassName = "FSM_PROCESS" }

---Creates a new FSM_PROCESS object.
---@param Controllable? any
---@param Task? any
---@return FSM_PROCESS
function FSM_PROCESS:New(Controllable, Task) end

---@param FsmProcess? any
function FSM_PROCESS:Init(FsmProcess) end

---@param step? any
---@param trigger? any
---@param params? any
---@param EventName? any
function FSM_PROCESS:_call_handler(step, trigger, params, EventName) end

---Creates a new FSM_PROCESS object based on this FSM_PROCESS.
---@param Controllable? any
---@param Task? any
---@return FSM_PROCESS
function FSM_PROCESS:Copy(Controllable, Task) end

---Removes an FSM_PROCESS object.
---@return FSM_PROCESS
function FSM_PROCESS:Remove() end

---Sets the task of the process.
---@param Task? TASK
---@return FSM_PROCESS
function FSM_PROCESS:SetTask(Task) end

---Gets the task of the process.
---@return TASK
function FSM_PROCESS:GetTask() end

---Gets the mission of the process.
---@return MISSION
function FSM_PROCESS:GetMission() end

---Gets the mission of the process.
---@return COMMANDCENTER
function FSM_PROCESS:GetCommandCenter() end

---Send a message of the {Tasking.Task} to the Group of the Unit.
---@param Message? any
function FSM_PROCESS:Message(Message) end

---Assign the process to a {Wrapper.Unit} and activate the process.
---@param ProcessUnit? UNIT
---@param Task? TASK
---@return FSM_PROCESS # self
function FSM_PROCESS:Assign(ProcessUnit, Task) end

---@param ProcessUnit? any
---@param Task? any
---@param From? any
---@param Event? any
---@param To? any
function FSM_PROCESS:onenterFailed(ProcessUnit, Task, From, Event, To) end

---StateMachine callback function for a FSM_PROCESS
---@param ProcessUnit? CONTROLLABLE
---@param Task? any
---@param From? string
---@param Event? string
---@param To? string
function FSM_PROCESS:onstatechange(ProcessUnit, Task, From, Event, To) end

---FSM_TASK class
---@class FSM_TASK : FSM
---@field Task TASK
FSM_TASK = {
  ClassName = "FSM_TASK",
}

---Creates a new FSM_TASK object.
---@param TaskName? string The name of the task.
---@return FSM_TASK
function FSM_TASK:New(TaskName) end

---@param step? any
---@param trigger? any
---@param params? any
---@param EventName? any
function FSM_TASK:_call_handler(step, trigger, params, EventName) end

---FSM_SET class
---@class FSM_SET : FSM
---@field Set SET_BASE
FSM_SET = {
  ClassName = "FSM_SET",
}

---Creates a new FSM_SET object.
---@param FSMSet? Set_SET_BASE (optional) The Set object that the FSM_SET governs.
---@return FSM_SET
function FSM_SET:New(FSMSet) end

---Sets the SET_BASE object that the FSM_SET governs.
---@param FSMSet? SET_BASE
---@return FSM_SET
function FSM_SET:Set(FSMSet) end

---Gets the SET_BASE object that the FSM_SET governs.
---@return SET_BASE
function FSM_SET:Get() end

---@param step? any
---@param trigger? any
---@param params? any
---@param EventName? any
function FSM_SET:_call_handler(step, trigger, params, EventName) end

---OnBefore Transition Handler for Event Stop.
---@param Controllable? CONTROLLABLE The Controllable Object managed by the FSM.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function FSM_CONTROLLABLE:OnBeforeStop(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---@param Controllable? CONTROLLABLE The Controllable Object managed by the FSM.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function FSM_CONTROLLABLE:OnAfterStop(Controllable, From, Event, To) end

---Synchronous Event Trigger for Event Stop.
function FSM_CONTROLLABLE:Stop() end

---Asynchronous Event Trigger for Event Stop.
---@param Delay? number The delay in seconds.
function FSM_CONTROLLABLE:__Stop(Delay) end

---OnLeave Transition Handler for State Stopped.
---@param Controllable? CONTROLLABLE The Controllable Object managed by the FSM.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function FSM_CONTROLLABLE:OnLeaveStopped(Controllable, From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---@param Controllable? CONTROLLABLE The Controllable Object managed by the FSM.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function FSM_CONTROLLABLE:OnEnterStopped(Controllable, From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---@param Controllable? CONTROLLABLE The Controllable Object managed by the FSM.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function FSM_CONTROLLABLE:OnAfterStop(Controllable, From, Event, To) end
