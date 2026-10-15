---@meta

---@class ZONE_CAPTURE_COALITION : ZONE_GOAL_COALITION
---@field ClassName string Name of the class.
---@field MarkBlue number ID of blue F10 mark.
---@field MarkRed number ID of red F10 mark.
---@field StartInterval number Time in seconds after the status monitor is started.
---@field RepeatInterval number Time in seconds after which the zone status is updated.
---@field HitsOn boolean If true, hit events are monitored and trigger the "Attack" event when a defending unit is hit.
---@field HitTimeLast number Time stamp in seconds when the last unit inside the zone was hit.
---@field HitTimeAttackOver number Time interval in seconds before the zone goes from "Attacked" to "Guarded" state after the last hit.
---@field MarkOn boolean If true, create marks of zone status on F10 map.
ZONE_CAPTURE_COALITION = {}

---ZONE_CAPTURE_COALITION Constructor.
---@param Zone? ZONE A @{Core.Zone} object with the goal to be achieved. Alternatively, can be handed as the name of late activated group describing a @{Core.Zone#ZONE_POLYGON} with its waypoints.
---@param Coalition? number The initial coalition owning the zone.
---@param UnitCategories? any (Optional) Table of unit categories. See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit). Default {Unit.Category.GROUND_UNIT}.
---@param ObjectCategories? any (Optional) Table of unit categories. See [DCS Class Object](https://wiki.hoggitworld.com/view/DCS_Class_Object). Default {Object.Category.UNIT, Object.Category.STATIC}, i.e. all UNITS and STATICS.
---@return ZONE_CAPTURE_COALITION
function ZONE_CAPTURE_COALITION:New(Zone, Coalition, UnitCategories, ObjectCategories) end

---Starts the zone capturing monitoring process.
---This process can be CPU intensive, ensure that you specify reasonable time intervals for the monitoring process.
---Note that the monitoring process is NOT started automatically during the `:New()` constructor.
---It is advised that the zone monitoring process is only started when the monitoring is of relevance in context of the current mission goals.
---When the zone is of no relevance, it is advised NOT to start the monitoring process, or to stop the monitoring process to save CPU resources.
---Therefore, the mission designer will need to use the `:Start()` method within his script to start the monitoring process specifically.
---@param StartInterval? number (optional) Specifies the start time interval in seconds when the zone state will be checked for the first time.
---@param RepeatInterval? number (optional) Specifies the repeat time interval in seconds when the zone state will be checked repeatedly.
---@return ZONE_CAPTURE_COALITION # self
function ZONE_CAPTURE_COALITION:Start(StartInterval, RepeatInterval) end

---Stops the zone capturing monitoring process.
---When the zone capturing monitor process is stopped, there won't be any changes anymore in the state and the owning coalition of the zone.
---This method becomes really useful when the zone is of no relevance anymore within a long lasting mission.
---In this case, it is advised to stop the monitoring process, not to consume unnecessary the CPU intensive scanning of units presence within the zone.
function ZONE_CAPTURE_COALITION:Stop() end

---Set whether hit events of defending units are monitored and trigger "Attack" events.
---@param Switch? boolean If *true*, hit events are monitored. If *false* or *nil*, hit events are not monitored.
---@param TimeAttackOver? number (Optional) Time in seconds after an attack is over after the last hit and the zone state goes to "Guarded". Default is 300 sec = 5 min.
---@return ZONE_CAPTURE_COALITION # self
function ZONE_CAPTURE_COALITION:SetMonitorHits(Switch, TimeAttackOver) end

---Set whether marks on the F10 map are shown, which display the current zone status.
---@param Switch? boolean If *true* or *nil*, marks are shown. If *false*, marks are not displayed.
---@return ZONE_CAPTURE_COALITION # self
function ZONE_CAPTURE_COALITION:SetMarkZone(Switch) end

---Monitor hit events.
---@param EventData? EVENTDATA The event data.
function ZONE_CAPTURE_COALITION:OnEventHit(EventData) end

---On after "Guard" event.
function ZONE_CAPTURE_COALITION:onafterGuard() end

---On enter "Guarded" state.
function ZONE_CAPTURE_COALITION:onenterGuarded() end

---On enter "Captured" state.
function ZONE_CAPTURE_COALITION:onenterCaptured() end

---On enter "Empty" state.
function ZONE_CAPTURE_COALITION:onenterEmpty() end

---On enter "Attacked" state.
function ZONE_CAPTURE_COALITION:onenterAttacked() end

---Check if zone is "Empty".
---@return boolean # self:IsNoneInZone()
function ZONE_CAPTURE_COALITION:IsEmpty() end

---Check if zone is "Guarded", i.e. only one (the defending) coalition is present inside the zone.
---@return boolean # self:IsAllInZoneOfCoalition( self.Coalition )
function ZONE_CAPTURE_COALITION:IsGuarded() end

---Check if zone is "Captured", i.e. another coalition took control over the zone and is the only one present.
---@return boolean # self:IsAllInZoneOfOtherCoalition( self.Coalition )
function ZONE_CAPTURE_COALITION:IsCaptured() end

---Check if zone is "Attacked", i.e. another coalition entered the zone.
---@return boolean # self:IsSomeInZoneOfCoalition( self.Coalition )
function ZONE_CAPTURE_COALITION:IsAttacked() end

---Check status Coalition ownership.
function ZONE_CAPTURE_COALITION:StatusZone() end

---Update Mark on F10 map.
function ZONE_CAPTURE_COALITION:Mark() end

---Captured State Handler OnLeave for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnLeaveCaptured(From, Event, To) end

---Captured State Handler OnEnter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnEnterCaptured(From, Event, To) end

---Attacked State Handler OnLeave for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnLeaveAttacked(From, Event, To) end

---Attacked State Handler OnEnter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnEnterAttacked(From, Event, To) end

---Guarded State Handler OnLeave for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnLeaveGuarded(From, Event, To) end

---Guarded State Handler OnEnter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnEnterGuarded(From, Event, To) end

---Empty State Handler OnLeave for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnLeaveEmpty(From, Event, To) end

---Empty State Handler OnEnter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnEnterEmpty(From, Event, To) end

---Guard Handler OnBefore for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnBeforeGuard(From, Event, To) end

---Guard Handler OnAfter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnAfterGuard(From, Event, To) end

---Guard Trigger for ZONE_CAPTURE_COALITION
function ZONE_CAPTURE_COALITION:Guard() end

---Guard Asynchronous Trigger for ZONE_CAPTURE_COALITION
---@param Delay? number
function ZONE_CAPTURE_COALITION:__Guard(Delay) end

---Empty Handler OnBefore for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnBeforeEmpty(From, Event, To) end

---Empty Handler OnAfter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnAfterEmpty(From, Event, To) end

---Empty Trigger for ZONE_CAPTURE_COALITION
function ZONE_CAPTURE_COALITION:Empty() end

---Empty Asynchronous Trigger for ZONE_CAPTURE_COALITION
---@param Delay? number
function ZONE_CAPTURE_COALITION:__Empty(Delay) end

---Attack Handler OnBefore for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnBeforeAttack(From, Event, To) end

---Attack Handler OnAfter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnAfterAttack(From, Event, To) end

---Attack Trigger for ZONE_CAPTURE_COALITION
function ZONE_CAPTURE_COALITION:Attack() end

---Attack Asynchronous Trigger for ZONE_CAPTURE_COALITION
---@param Delay? number
function ZONE_CAPTURE_COALITION:__Attack(Delay) end

---Capture Handler OnBefore for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
---@return boolean
function ZONE_CAPTURE_COALITION:OnBeforeCapture(From, Event, To) end

---Capture Handler OnAfter for ZONE_CAPTURE_COALITION
---@param From? string
---@param Event? string
---@param To? string
function ZONE_CAPTURE_COALITION:OnAfterCapture(From, Event, To) end

---Capture Trigger for ZONE_CAPTURE_COALITION
function ZONE_CAPTURE_COALITION:Capture() end

---Capture Asynchronous Trigger for ZONE_CAPTURE_COALITION
---@param Delay? number
function ZONE_CAPTURE_COALITION:__Capture(Delay) end
