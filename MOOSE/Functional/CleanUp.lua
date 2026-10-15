---@meta

---@class CLEANUP_AIRBASE : CLEANUP_AIRBASE.__
CLEANUP_AIRBASE = {
	ClassName = "CLEANUP_AIRBASE",
	TimeInterval = 0.2,
	CleanUpList = {},
}

---@class CLEANUP_AIRBASE.__ : BASE
---@field Airbases any Map of Airbases.
CLEANUP_AIRBASE.__ = {}

CLEANUP_AIRBASE.__.Airbases = {}

---Creates the main object which is handling the cleaning of the debris within the given Zone Names.
---@param AirbaseNames? string[] Is a table of airbase names where the debris should be cleaned. Also a single string can be passed with one airbase name.
---@return CLEANUP_AIRBASE
function CLEANUP_AIRBASE:New(AirbaseNames) end

---Adds an airbase to the airbase validation list.
---@param AirbaseName? string
---@return CLEANUP_AIRBASE
function CLEANUP_AIRBASE:AddAirbase(AirbaseName) end

---Removes an airbase from the airbase validation list.
---@param AirbaseName? string
---@return CLEANUP_AIRBASE
function CLEANUP_AIRBASE:RemoveAirbase(AirbaseName) end

---Enables or disables the cleaning of missiles within the airbase zones.
---Airbase operations stop when a missile or bomb is dropped at a runway.
---Note that when this method is used, the airbase operations won't stop if
---the missile or bomb was cleaned within the airbase zone, which is 8km from the center of the airbase.
---However, there is a trade-off to make. Attacks on airbases won't be possible anymore if this method is used.
---Note, one can also use the method {#CLEANUP_AIRBASE.RemoveAirbase}() to remove the airbase from the control process as a whole,
---when an enemy unit is near. That is also an option...
---@param CleanMissiles? boolean (Optional) (Default=true) If true, missiles fired are immediately destroyed. If false missiles are not controlled.
---@return CLEANUP_AIRBASE
function CLEANUP_AIRBASE:SetCleanMissiles(CleanMissiles) end

---@param Vec2? any
function CLEANUP_AIRBASE.__:IsInAirbase(Vec2) end

---Destroys a {Wrapper.Unit} from the simulator, but checks first if it is still existing!
---@param CleanUpUnit? UNIT The object to be destroyed.
function CLEANUP_AIRBASE.__:DestroyUnit(CleanUpUnit) end

---Destroys a missile from the simulator, but checks first if it is still existing!
---@param MissileObject? Weapon
function CLEANUP_AIRBASE.__:DestroyMissile(MissileObject) end

---@param EventData? EVENTDATA
function CLEANUP_AIRBASE.__:OnEventBirth(EventData) end

---Detects if a crash event occurs.
---Crashed units go into a CleanUpList for removal.
---@param Event? EVENTDATA
function CLEANUP_AIRBASE.__:OnEventCrash(Event) end

---Detects if a unit shoots a missile.
---If this occurs within one of the airbases, then the weapon used must be destroyed.
---@param Event? EVENTDATA
function CLEANUP_AIRBASE.__:OnEventShot(Event) end

---Detects if the Unit has an S_EVENT_HIT within the given AirbaseNames. If this is the case, destroy the unit.
---@param Event? EVENTDATA
function CLEANUP_AIRBASE.__:OnEventHit(Event) end

---Add the {DCS#Unit} to the CleanUpList for CleanUp.
---@param CleanUpUnit? UNIT
---@param CleanUpUnitName? any
function CLEANUP_AIRBASE.__:AddForCleanUp(CleanUpUnit, CleanUpUnitName) end

---Detects if the Unit has an S_EVENT_ENGINE_SHUTDOWN or an S_EVENT_HIT within the given AirbaseNames. If this is the case, add the Group to the CLEANUP_AIRBASE List.
---@param Event? EVENTDATA
function CLEANUP_AIRBASE.__:EventAddForCleanUp(Event) end

---At the defined time interval, CleanUp the Groups within the CleanUpList.
function CLEANUP_AIRBASE.__:CleanUpSchedule() end
