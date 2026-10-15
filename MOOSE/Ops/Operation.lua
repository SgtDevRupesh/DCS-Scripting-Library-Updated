---@meta

---@class OPERATION.Edge
---@field uid number Unique ID of the edge.
---@field branchFrom OPERATION.Branch The from branch.
---@field phaseFrom OPERATION.Phase The from phase after which to switch.
---@field branchTo OPERATION.Branch The branch to switch to.
---@field phaseTo OPERATION.Phase The phase to switch to.
---@field conditionSwitch CONDITION Conditions when to switch the branch.

---@class OPERATION.Branch
---@field uid number Unique ID of the branch.
---@field name string Name of the branch.
---@field phases table Phases of this branch.
---@field edges table Edges of this branch.

---@class OPERATION.Phase
---@field uid number Unique ID of the phase.
---@field name string Name of the phase.
---@field conditionOver CONDITION Conditions when the phase is over.
---@field status string Phase status.
---@field Tstart number Abs. mission time when the phase was started.
---@field nActive number Number of times the phase was active.
---@field duration number Duration in seconds how long the phase should be active after it started.
---@field branch OPERATION.Branch The branch this phase belongs to.

---OPERATION class.
---@class OPERATION : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field uid number Unique ID of the operation.
---@field lid string Class id string for output to DCS log file.
---@field name string Name of the operation.
---@field Tstart number Start time in seconds of abs mission time.
---@field Tstop number Stop time in seconds of abs mission time.
---@field duration number Duration of the operation in seconds.
---@field conditionStart CONDITION Start condition.
---@field conditionOver CONDITION Over condition.
---@field branches table Branches.
---@field branchMaster OPERATION.Branch Master branch.
---@field branchActive OPERATION.Branch Active branch.
---@field counterPhase number Running number counting the phases.
---@field counterBranch number Running number counting the branches.
---@field phase OPERATION.Phase Currently active phase (if any).
---@field phaseLast OPERATION.Phase The phase that was active before the current one.
---@field cohorts table Dedicated cohorts.
---@field legions table Dedicated legions.
---@field targets table Targets.
---@field missions table Missions.
OPERATION = {
  ClassName          = "OPERATION",
  verbose            =     0,
  branches           =    {},
  counterPhase       =     0,
  counterBranch      =     0,
  counterEdge        =     0,
  cohorts            =    {},
  legions            =    {},  
  targets            =    {},
  missions           =    {},
}

---Operation phase.
---@class OPERATION.PhaseStatus
---@field PLANNED string Planned.
---@field ACTIVE string Active phase.
---@field OVER string Phase is over.
OPERATION.PhaseStatus={
  PLANNED="Planned",
  ACTIVE="Active",
  OVER="Over",
}

---OPERATION class version.
OPERATION.version = "0.2.0"

---Create a new generic OPERATION object.
---@param Name? string (Optional) Name of the operation. Be creative! Default "Operation-01" where the last number is a running number.
---@return OPERATION # self
function OPERATION:New(Name) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return OPERATION # self
function OPERATION:SetVerbosity(VerbosityLevel) end

---Set start and stop time of the operation.
---@param ClockStart? string (Optional) Time the mission is started, e.g. "05:00" for 5 am. If specified as a #number, it will be relative (in seconds) to the current mission time. Default is 5 seconds after mission was added.
---@param ClockStop? string (Optional) Time the mission is stopped, e.g. "13:00" for 1 pm. If mission could not be started at that time, it will be removed from the queue. If specified as a #number it will be relative (in seconds) to the current mission time.
---@return OPERATION # self
function OPERATION:SetTime(ClockStart, ClockStop) end

---Add (all) condition function when the whole operation is over. Must return a `#boolean`.
---@param Function? function Function that needs to be `true` before the operation is over.
---@param ... any
---@return CONDITION.Function # Condition function table.
function OPERATION:AddConditonOverAll(Function, ...) end

---Add (any) condition function when the whole operation is over. Must return a `#boolean`.
---@param Phase? any
---@param Function? function Function that needs to be `true` before the operation is over.
---@param ... any
---@return CONDITION.Function # Condition function table.
function OPERATION:AddConditonOverAny(Phase, Function, ...) end

---Add a new phase to the operation. This is added add the end of all previously added phases (if any).
---@param Name? string (Optional) Name of the phase. Default "Phase-01" where the last number is a running number.
---@param Branch? OPERATION.Branch|number|string (Optional) The branch to which this phase is added. Default is the master branch.
---@param Duration? number (Optional) Duration in seconds how long the phase will last. Default `nil`=forever.
---@return OPERATION.Phase # Phase table object.
function OPERATION:AddPhase(Name, Branch, Duration) end

---Insert a new phase after an already defined phase of the operation.
---@param PhaseAfter? OPERATION.Phase|number|string The phase after which the new phase is inserted.
---@param Name? string (Optional) Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Phase # Phase table object.
function OPERATION:InsertPhaseAfter(PhaseAfter, Name) end

---Get a name of this operation.
---@return string # Name of this operation or "Unknown".
function OPERATION:GetName() end

---Get a phase by its name.
---@param Name? string (Optional) Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Phase # Phase table object or nil if phase could not be found.
function OPERATION:GetPhaseByName(Name) end

---Set status of a phase.
---@param Phase? OPERATION.Phase|number|string The phase.
---@param Status? string New status, *e.g.* `OPERATION.PhaseStatus.OVER`.
---@return OPERATION # self
function OPERATION:SetPhaseStatus(Phase, Status) end

---Get status of a phase.
---@param Phase? OPERATION.Phase|number|string The phase.
---@return string # Phase status, *e.g.* `OPERATION.PhaseStatus.OVER`.
function OPERATION:GetPhaseStatus(Phase) end

---Set condition when the given phase is over.
---@param Phase? OPERATION.Phase|number|string The phase.
---@param Condition? CONDITION Condition when the phase is over.
---@return OPERATION # self
function OPERATION:SetPhaseConditonOver(Phase, Condition) end

---Add condition function when the given phase is over. Must return a `#boolean`.
---@param Phase? OPERATION.Phase|number|string The phase.
---@param Function? function Function that needs to be `true` before the phase is over.
---@param ... any
---@return CONDITION.Function # Condition function table.
function OPERATION:AddPhaseConditonOverAll(Phase, Function, ...) end

---Add condition function when the given phase is over. Must return a `#boolean`.
---@param Phase? OPERATION.Phase|number|string The phase.
---@param Function? function Function that needs to be `true` before the phase is over.
---@param ... any
---@return CONDITION.Function # Condition function table.
function OPERATION:AddPhaseConditonOverAny(Phase, Function, ...) end

---Set persistence of condition function. By default, condition functions are removed after a phase is over.
---@param ConditionFunction? CONDITION.Function|number|string Condition function table.
---@param IsPersistent? boolean If `true` or `nil`, condition function is persistent.
---@return OPERATION # self
function OPERATION:SetConditionFunctionPersistence(ConditionFunction, IsPersistent) end

---Add condition function when the given phase is to be repeated. The provided function must return a `#boolean`.
---If the condition evaluation returns `true`, the phase is set to state `Planned` instead of `Over` and can be repeated.
---@param Phase? OPERATION.Phase|number|string The phase.
---@param Function? function Function that needs to be `true` before the phase is over.
---@param ... any
---@return OPERATION # self
function OPERATION:AddPhaseConditonRepeatAll(Phase, Function, ...) end

---Get condition when the given phase is over.
---@param Phase? OPERATION.Phase|number|string The phase.
---@param Condition? any
---@return CONDITION # Condition when the phase is over (if any).
function OPERATION:GetPhaseConditonOver(Phase, Condition) end

---Get how many times a phase has been active.
---@param Phase? OPERATION.Phase|number|string The phase.
---@return number # Number of times the phase has been active.
function OPERATION:GetPhaseNactive(Phase) end

---Get name of a phase.
---@param Phase? OPERATION.Phase|number|string (Optional) The phase of which the name is returned. Default is the currently active phase.
---@return string # The name of the phase or "None" if no phase is given or active.
function OPERATION:GetPhaseName(Phase) end

---Get currrently active phase.
---@return OPERATION.Phase # Current phase or `nil` if no current phase is active.
function OPERATION:GetPhaseActive() end

---Get index of phase.
---@param Phase? OPERATION.Phase|number|string The phase.
---@return number # The index.
---@return OPERATION.Branch # The branch.
function OPERATION:GetPhaseIndex(Phase) end

---Get next phase.
---@param Branch? OPERATION.Branch|number|string (Optional) The branch from which the next phase is retrieved. Default is the currently active branch.
---@param PhaseStatus? string (Optional) Only return a phase, which is in this status. For example, `OPERATION.PhaseStatus.PLANNED` to make sure, the next phase is planned.
---@return OPERATION.Phase # Next phase or `nil` if no next phase exists.
function OPERATION:GetPhaseNext(Branch, PhaseStatus) end

---Count phases.
---@param Status? string (Optional) Only count phases in a certain status, e.g. `OPERATION.PhaseStatus.PLANNED`.
---@param Branch? OPERATION.Branch|number|string (Optional) Branch.
---@return number # Number of phases
function OPERATION:CountPhases(Status, Branch) end

---Add a new branch to the operation.
---@param Name? string
---@return OPERATION.Branch # Branch table object.
function OPERATION:AddBranch(Name) end

---Get the master branch. This is the default branch and should always exist (if it was not explicitly deleted).
---@return OPERATION.Branch # The master branch.
function OPERATION:GetBranchMaster() end

---Get the currently active branch.
---@return OPERATION.Branch # The active branch. If no branch is active, the master branch is returned.
function OPERATION:GetBranchActive() end

---Get name of the branch.
---@param Branch? any
---@return string # Name Name or "None"
function OPERATION:GetBranchName(Branch) end

---Add an edge between two branches.
---@param PhaseFrom? OPERATION.Phase|number|string The phase of the *from* branch *after* which to switch.
---@param PhaseTo? OPERATION.Phase|number|string The phase of the *to* branch *to* which to switch.
---@param ConditionSwitch? CONDITION (Optional) Condition(s) when to switch the branches.
---@return OPERATION.Edge # Edge table object.
function OPERATION:AddEdge(PhaseFrom, PhaseTo, ConditionSwitch) end

---Add condition function to an edge when branches are switched. The function must return a `#boolean`.
---If multiple condition functions are added, all of these must return true for the branch switch to occur.
---@param Edge? OPERATION.Edge|number|string The edge connecting the two branches.
---@param Function? function Function that needs to be `true` for switching between the branches.
---@param ... any
---@return CONDITION.Function # Condition function table.
function OPERATION:AddEdgeConditonSwitchAll(Edge, Function, ...) end

---Add mission to operation.
---@param Mission? AUFTRAG The mission to add.
---@param Phase? OPERATION.Phase|number|string (Optional) The phase in which the mission should be executed. If no phase is given, it will be exectuted ASAP.
function OPERATION:AddMission(Mission, Phase) end

---Add Target to operation.
---@param Target? TARGET The target to add.
---@param Phase? OPERATION.Phase|number|string (Optional) The phase in which the target should be attacked. If no phase is given, it will be attacked ASAP.
function OPERATION:AddTarget(Target, Phase) end

---Get targets of operation.
---@param Phase? OPERATION.Phase|number|string (Optional) Only return targets set for this phase. Default is targets of all phases.
---@return table # Targets Table of #TARGET objects
function OPERATION:GetTargets(Phase) end

---Count targets alive.
---@param Phase? OPERATION.Phase|number|string (Optional) Only count targets set for this phase.
---@return number # Number of phases
function OPERATION:CountTargets(Phase) end

---Assign cohort to operation.
---@param Cohort? COHORT The cohort
---@return OPERATION # self
function OPERATION:AssignCohort(Cohort) end

---Assign legion to operation. All cohorts of this legion will be assigned and are only available.
---@param Legion? LEGION The legion to be assigned.
---@return OPERATION # self
function OPERATION:AssignLegion(Legion) end

---Check if a given legion is assigned to this operation. All cohorts of this legion will be checked.
---@param Legion? LEGION The legion to be assigned.
---@return boolean # If `true`, legion is assigned to this operation.
function OPERATION:IsAssignedLegion(Legion) end

---Check if a given cohort is assigned to this operation.
---@param Cohort? COHORT The Cohort.
---@return boolean # If `true`, cohort is assigned to this operation.
function OPERATION:IsAssignedCohort(Cohort) end

---Check if a given cohort or legion is assigned to this operation.
---@param Object? OBJECT The cohort or legion object.
---@return boolean # If `true`, cohort is assigned to this operation.
function OPERATION:IsAssignedCohortOrLegion(Object) end

---Check if operation is in FSM state "Planned".
---@return boolean # If `true`, operation is "Planned".
function OPERATION:IsPlanned() end

---Check if operation is in FSM state "Running".
---@return boolean # If `true`, operation is "Running".
function OPERATION:IsRunning() end

---Check if operation is in FSM state "Paused".
---@return boolean # If `true`, operation is "Paused".
function OPERATION:IsPaused() end

---Check if operation is in FSM state "Over".
---@return boolean # If `true`, operation is "Over".
function OPERATION:IsOver() end

---Check if operation is in FSM state "Stopped".
---@return boolean # If `true`, operation is "Stopped".
function OPERATION:IsStopped() end

---Check if operation is **not** "Over" or "Stopped".
---@return boolean # If `true`, operation is not "Over" or "Stopped".
function OPERATION:IsNotOver() end

---Check if phase is in status "Active".
---@param Phase? OPERATION.Phase|number|string The phase.
---@return boolean # If `true`, phase is active.
function OPERATION:IsPhaseActive(Phase) end

---Check if a phase is the currently active one.
---@param Phase? OPERATION.Phase|number|string The phase to check.
---@return boolean # If `true`, this phase is currently active.
function OPERATION:IsPhaseActive(Phase) end

---Check if phase is in status "Planned".
---@param Phase? OPERATION.Phase|number|string The phase.
---@return boolean # If `true`, phase is Planned.
function OPERATION:IsPhasePlanned(Phase) end

---Check if phase is in status "Over".
---@param Phase? OPERATION.Phase|number|string The phase.
---@return boolean # If `true`, phase is over.
function OPERATION:IsPhaseOver(Phase) end

---On after "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:onafterStart(From, Event, To) end

---On after "StatusUpdate" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:onafterStatusUpdate(From, Event, To) end

---On after "PhaseNext" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:onafterPhaseNext(From, Event, To) end

---On after "PhaseChange" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:onafterPhaseChange(From, Event, To, Phase) end

---On after "PhaseOver" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Phase? OPERATION.Phase|number|string The phase that is over.
function OPERATION:onafterPhaseOver(From, Event, To, Phase) end

---On after "BranchSwitch" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Branch? OPERATION.Branch|number|string The new branch.
---@param Phase? OPERATION.Phase|number|string The phase.
function OPERATION:onafterBranchSwitch(From, Event, To, Branch, Phase) end

---On after "Over" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:onafterOver(From, Event, To) end

---Check phases.
function OPERATION:_CheckPhases() end

---Create a new phase object.
---@param Name? string (Optional) Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Phase # Phase table object.
function OPERATION:_CreatePhase(Name) end

---Create a new branch object.
---@param Name? string (Optional) Name of the phase. Default "Phase-01" where the last number is a running number.
---@return OPERATION.Branch # Branch table object.
function OPERATION:_CreateBranch(Name) end

---Triggers the FSM event "Start".
function OPERATION:Start() end

---Triggers the FSM event "Start" after a delay.
---@param delay? number Delay in seconds.
function OPERATION:__Start(delay) end

---On after "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:OnAfterStart(From, Event, To) end

---Triggers the FSM event "Stop".
function OPERATION:Stop() end

---Triggers the FSM event "Stop" after a delay.
---@param delay? number Delay in seconds.
function OPERATION:__Stop(delay) end

---Triggers the FSM event "StatusUpdate".
function OPERATION:StatusUpdate() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function OPERATION:__StatusUpdate(delay) end

---Triggers the FSM event "PhaseChange".
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:PhaseChange(Phase) end

---Triggers the FSM event "PhaseChange" after a delay.
---@param delay? number Delay in seconds.
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:__PhaseChange(delay, Phase) end

---On after "PhaseChange" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:OnAfterPhaseChange(From, Event, To, Phase) end

---Triggers the FSM event "PhaseNext".
function OPERATION:PhaseNext() end

---Triggers the FSM event "PhaseNext" after a delay.
---@param delay? number Delay in seconds.
function OPERATION:__PhaseNext(delay) end

---On after "PhaseNext" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:OnAfterPhaseNext(From, Event, To) end

---Triggers the FSM event "PhaseOver".
---@param Phase? OPERATION.Phase|number|string The phase that is over.
function OPERATION:PhaseOver(Phase) end

---Triggers the FSM event "PhaseOver" after a delay.
---@param delay? number Delay in seconds.
---@param Phase? OPERATION.Phase|number|string The phase that is over.
function OPERATION:__PhaseOver(delay, Phase) end

---On after "PhaseOver" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Phase? OPERATION.Phase|number|string The phase that is over.
function OPERATION:OnAfterPhaseOver(From, Event, To, Phase) end

---Triggers the FSM event "BranchSwitch".
---@param Branch? OPERATION.Branch|number|string The branch that is now active.
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:BranchSwitch(Branch, Phase) end

---Triggers the FSM event "BranchSwitch" after a delay.
---@param delay? number Delay in seconds.
---@param Branch? OPERATION.Branch|number|string The branch that is now active.
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:__BranchSwitch(delay, Branch, Phase) end

---On after "BranchSwitch" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Branch? OPERATION.Branch|number|string The branch that is now active.
---@param Phase? OPERATION.Phase|number|string The new phase.
function OPERATION:OnAfterBranchSwitch(From, Event, To, Branch, Phase) end

---Triggers the FSM event "Over".
function OPERATION:Over() end

---Triggers the FSM event "Over" after a delay.
---@param delay? number Delay in seconds.
function OPERATION:__Over(delay) end

---On after "Over" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function OPERATION:OnAfterOver(From, Event, To) end
