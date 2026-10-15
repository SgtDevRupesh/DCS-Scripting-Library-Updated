---@meta

---@class DETECTION_BASE.DetectedItem
---@field IsDetected boolean Indicates if the DetectedItem has been detected or not.
---@field Set SET_UNIT The Set of Units in the detected area.
---@field Zone ZONE_UNIT The Zone of the detected area.
---@field Changed boolean Documents if the detected area has changed.
---@field Changes table A list of the changes reported on the detected area. (It is up to the user of the detected area to consume those changes).
---@field ID number The identifier of the detected area.
---@field FriendliesNearBy boolean Indicates if there are friendlies within the detected area.
---@field NearestFAC UNIT The nearest FAC near the Area.
---@field Coordinate COORDINATE The last known coordinate of the DetectedItem.
---@field InterceptCoord COORDINATE Intercept coordinate.
---@field DistanceRecce number Distance in meters of the Recce.
---@field Index number Detected item key. Could also be a string.
---@field ItemID string ItemPrefix .. "." .. self.DetectedItemMax.
---@field Locked boolean Lock detected item.
---@field PlayersNearBy table Table of nearby players.
---@field FriendliesDistance table Table of distances to friendly units.
---@field TypeName string Type name of the detected unit.
---@field CategoryName string Category name of the detected unit.
---@field Name string Name of the detected object.
---@field IsVisible boolean If true, detected object is visible.
---@field LastTime number Last time the detected item was seen.
---@field LastPos Vec3 Last known position of the detected item.
---@field LastVelocity Vec3 Last recorded 3D velocity vector of the detected item.
---@field KnowType boolean Type of detected item is known.
---@field KnowDistance boolean Distance to the detected item is known.
---@field Distance number Distance to the detected item.

---@class DETECTION_BASE.DetectedItems

---@class DETECTION_BASE.DetectedObject
---@field Name string
---@field IsVisible boolean
---@field KnowType boolean
---@field KnowDistance boolean
---@field Type string
---@field Distance number
---@field Identified boolean
---@field LastTime number
---@field LastPos boolean
---@field LastVelocity number

---@class DETECTION_BASE.DetectedObjects

---@class DETECTION_BASE : FSM
---@field DetectionSetGroup SET_GROUP The @{Core.Set} of GROUPs in the Forward Air Controller role.
---@field DetectionRange number The range till which targets are accepted to be detected.
---@field DetectedObjects DETECTION_BASE.DetectedObjects The list of detected objects.
---@field DetectedObjectsIdentified table Map of the DetectedObjects identified.
---@field DetectionRun number
DETECTION_BASE = {
  ClassName = "DETECTION_BASE",
  DetectionSetGroup = nil,
  DetectionRange = nil,
  DetectedObjects = {},
  DetectionRun = 0,
  DetectedObjectsIdentified = {},
  DetectedItems = {},
  DetectedItemsByIndex = {},
}

---DETECTION constructor.
---@param DetectionSet? SET_GROUP The @{Core.Set} of @{Wrapper.Group}s that is used to detect the units.
---@return DETECTION_BASE # self
function DETECTION_BASE:New(DetectionSet) end

---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:onafterStart(From, Event, To) end

---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:onafterDetect(From, Event, To) end

function DETECTION_BASE:CountAliveRecce() end

---@param IteratorFunction? any
---@param ... any
function DETECTION_BASE:ForEachAliveRecce(IteratorFunction, ...) end

---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@param Detection? GROUP The Group detecting.
---@param DetectionTimeStamp? number Time stamp of detection event.
function DETECTION_BASE:onafterDetection(From, Event, To, Detection, DetectionTimeStamp) end

---Clean the DetectedItem table.
---@param DetectedItem? any
---@param DetectedItemID? any
---@return DETECTION_BASE
function DETECTION_BASE:CleanDetectionItem(DetectedItem, DetectedItemID) end

---Forget a Unit from a DetectionItem
---@param UnitName? string The UnitName that needs to be forgotten from the DetectionItem Sets.
---@return DETECTION_BASE
function DETECTION_BASE:ForgetDetectedUnit(UnitName) end

---Make a DetectionSet table. This function will be overridden in the derived clsses.
---@return DETECTION_BASE
function DETECTION_BASE:CreateDetectionItems() end

---Detect Visual.
---@param DetectVisual? boolean
---@return DETECTION_BASE # self
function DETECTION_BASE:InitDetectVisual(DetectVisual) end

---Detect Optical.
---@param DetectOptical? boolean
---@return DETECTION_BASE # self
function DETECTION_BASE:InitDetectOptical(DetectOptical) end

---Detect Radar.
---@param DetectRadar? boolean
---@return DETECTION_BASE # self
function DETECTION_BASE:InitDetectRadar(DetectRadar) end

---Detect IRST.
---@param DetectIRST? boolean
---@return DETECTION_BASE # self
function DETECTION_BASE:InitDetectIRST(DetectIRST) end

---Detect RWR.
---@param DetectRWR? boolean
---@return DETECTION_BASE # self
function DETECTION_BASE:InitDetectRWR(DetectRWR) end

---Detect DLINK.
---@param DetectDLINK? boolean
---@return DETECTION_BASE # self
function DETECTION_BASE:InitDetectDLINK(DetectDLINK) end

---Filter the detected units based on Unit.Category
---The different values of Unit.Category can be:
---
---  * Unit.Category.AIRPLANE
---  * Unit.Category.GROUND_UNIT
---  * Unit.Category.HELICOPTER
---  * Unit.Category.SHIP
---  * Unit.Category.STRUCTURE
---
---Multiple Unit.Category entries can be given as a table and then these will be evaluated as an OR expression.
---
---Example to filter a single category (Unit.Category.AIRPLANE).
---
---    DetectionObject:FilterCategories( Unit.Category.AIRPLANE )
---
---Example to filter multiple categories (Unit.Category.AIRPLANE, Unit.Category.HELICOPTER). Note the {}.
---
---    DetectionObject:FilterCategories( { Unit.Category.AIRPLANE, Unit.Category.HELICOPTER } )
---@param FilterCategories? any The Categories entries
---@return DETECTION_BASE # self
function DETECTION_BASE:FilterCategories(FilterCategories) end

---Method to make the radar detection less accurate, e.g. for WWII scenarios.
---@param minheight? number Minimum flight height to be detected, in meters AGL (above ground)
---@param thresheight? number (Optional) Threshold to escape the radar if flying below minheight, defaults to 90 (90% escape chance)
---@param thresblur? number (Optional) Threshold to be detected by the radar overall, defaults to 85 (85% chance to be found)
---@param closing? number (Optional) Closing-in in km - the limit of km from which on it becomes increasingly difficult to escape radar detection if flying towards the radar position. Should be about 1/3 of the radar detection radius in kilometers, defaults to 20.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetRadarBlur(minheight, thresheight, thresblur, closing) end

---Set the detection interval time in seconds.
---@param RefreshTimeInterval? number Interval in seconds.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetRefreshTimeInterval(RefreshTimeInterval) end

---Set the radius in meters to validate if friendlies are nearby.
---@param FriendliesRange? number Radius to use when checking if Friendlies are nearby.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetFriendliesRange(FriendliesRange) end

---Set the parameters to calculate to optimal intercept point.
---@param Intercept? boolean (Optional) Intercept is true if an intercept point is calculated. Intercept is false if it is disabled. The default Intercept is false.
---@param InterceptDelay? number If Intercept is true, then InterceptDelay is the average time it takes to get airplanes airborne.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetIntercept(Intercept, InterceptDelay) end

---Accept detections if within a range in meters.
---@param AcceptRange? number Accept a detection if the unit is within the AcceptRange in meters.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetAcceptRange(AcceptRange) end

---Accept detections if within the specified zone(s).
---@param AcceptZones? ZONE_BASE Can be a list or ZONE_BASE objects, or a single ZONE_BASE object.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetAcceptZones(AcceptZones) end

---Reject detections if within the specified zone(s).
---@param RejectZones? ZONE_BASE Can be a list or ZONE_BASE objects, or a single ZONE_BASE object.
---@return DETECTION_BASE # self
function DETECTION_BASE:SetRejectZones(RejectZones) end

---Upon a **visual** detection, the further away a detected object is, the less likely it is to be detected properly.
---Also, the speed of accurate detection plays a role.
---A distance probability factor between 0 and 1 can be given, that will model a linear extrapolated probability over 10 km distance.
---For example, if a probability factor of 0.6 (60%) is given, the extrapolated probabilities over 15 kilometers would like like:
---1 km: 96%, 2 km: 92%, 3 km: 88%, 4 km: 84%, 5 km: 80%, 6 km: 76%, 7 km: 72%, 8 km: 68%, 9 km: 64%, 10 km: 60%, 11 km: 56%, 12 km: 52%, 13 km: 48%, 14 km: 44%, 15 km: 40%.
---@param DistanceProbability? any
---@return DETECTION_BASE # self
function DETECTION_BASE:SetDistanceProbability(DistanceProbability) end

---Upon a **visual** detection, the higher the unit is during the detecting process, the more likely the detected unit is to be detected properly.
---A detection at a 90% alpha angle is the most optimal, a detection at 10% is less and a detection at 0% is less likely to be correct.
---
---A probability factor between 0 and 1 can be given, that will model a progressive extrapolated probability if the target would be detected at a 0° angle.
---
---For example, if a alpha angle probability factor of 0.7 is given, the extrapolated probabilities of the different angles would look like:
---0°: 70%, 10°: 75,21%, 20°: 80,26%, 30°: 85%, 40°: 89,28%, 50°: 92,98%, 60°: 95,98%, 70°: 98,19%, 80°: 99,54%, 90°: 100%
---@param AlphaAngleProbability? any
---@return DETECTION_BASE # self
function DETECTION_BASE:SetAlphaAngleProbability(AlphaAngleProbability) end

---Upon a **visual** detection, the more a detected unit is within a cloudy zone, the less likely the detected unit is to be detected successfully.
---The Cloudy Zones work with the ZONE_BASE derived classes. The mission designer can define within the mission
---zones that reflect cloudy areas where detected units may not be so easily visually detected.
---@param ZoneArray? any
---@return DETECTION_BASE # self
function DETECTION_BASE:SetZoneProbability(ZoneArray) end

---Accepts changes from the detected item.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return DETECTION_BASE # self
function DETECTION_BASE:AcceptChanges(DetectedItem) end

---Add a change to the detected zone.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@param ChangeCode? string
---@param ItemUnitType? any
---@return DETECTION_BASE # self
function DETECTION_BASE:AddChangeItem(DetectedItem, ChangeCode, ItemUnitType) end

---Add a change to the detected zone.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@param ChangeCode? string
---@param ChangeUnitType? string
---@return DETECTION_BASE # self
function DETECTION_BASE:AddChangeUnit(DetectedItem, ChangeCode, ChangeUnitType) end

---This will allow during friendly search any recce or detection unit to be also considered as a friendly.
---By default, recce aren't considered friendly, because that would mean that a recce would be also an attacking friendly,
---and this is wrong.
---However, in a CAP situation, when the CAP is part of an EWR network, the CAP is also an attacker.
---This, this method allows to register for a detection the CAP unit name prefixes to be considered CAP.
---@param FriendlyPrefixes? string A string or a list of prefixes.
---@return DETECTION_BASE
function DETECTION_BASE:SetFriendlyPrefixes(FriendlyPrefixes) end

---Returns if there are friendlies nearby the FAC units ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@param Category? any The category of the unit.
---@return boolean # true if there are friendlies nearby
function DETECTION_BASE:IsFriendliesNearBy(DetectedItem, Category) end

---Returns friendly units nearby the FAC units ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@param Category? any The category of the unit.
---@return any # The map of Friendly UNITs.
function DETECTION_BASE:GetFriendliesNearBy(DetectedItem, Category) end

---Returns if there are friendlies nearby the intercept ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return boolean # trhe if there are friendlies near the intercept.
function DETECTION_BASE:IsFriendliesNearIntercept(DetectedItem) end

---Returns friendly units nearby the intercept point ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The detected item.
---@return any # The map of Friendly UNITs.
function DETECTION_BASE:GetFriendliesNearIntercept(DetectedItem) end

---Returns the distance used to identify friendlies near the detected item ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The detected item.
---@return table # A table of distances to friendlies.
function DETECTION_BASE:GetFriendliesDistance(DetectedItem) end

---Returns if there are friendlies nearby the FAC units ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return boolean # true if there are friendlies nearby
function DETECTION_BASE:IsPlayersNearBy(DetectedItem) end

---Returns friendly units nearby the FAC units ...
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The detected item.
---@return any # The map of Friendly UNITs.
function DETECTION_BASE:GetPlayersNearBy(DetectedItem) end

---Background worker function to determine if there are friendlies nearby ...
---@param TargetData? table
function DETECTION_BASE:ReportFriendliesNearBy(TargetData) end

---Determines if a detected object has already been identified during detection processing.
---@param DetectedObject? DETECTION_BASE.DetectedObject|number|string
---@return boolean # true if already identified.
function DETECTION_BASE:IsDetectedObjectIdentified(DetectedObject) end

---Identifies a detected object during detection processing.
---@param DetectedObject? DETECTION_BASE.DetectedObject|number|string
function DETECTION_BASE:IdentifyDetectedObject(DetectedObject) end

---UnIdentify a detected object during detection processing.
---@param DetectedObject? DETECTION_BASE.DetectedObject|number|string
function DETECTION_BASE:UnIdentifyDetectedObject(DetectedObject) end

---UnIdentify all detected objects during detection processing.
function DETECTION_BASE:UnIdentifyAllDetectedObjects() end

---Gets a detected object with a given name.
---@param ObjectName? string
---@return DETECTION_BASE.DetectedObject
function DETECTION_BASE:GetDetectedObject(ObjectName) end

---Gets a detected unit type name, taking into account the detection results.
---@param DetectedUnit? UNIT
---@return string # The type name
function DETECTION_BASE:GetDetectedUnitTypeName(DetectedUnit) end

---Adds a new DetectedItem to the DetectedItems list.
---The DetectedItem is a table and contains a SET_UNIT in the field Set.
---@param ItemPrefix? string Prefix of detected item.
---@param DetectedItemKey? number (Optional) The key of the DetectedItem. Default self.DetectedItemMax. Could also be a string in principle.
---@param Set? SET_UNIT (Optional) The Set of Units to be added.
---@return DETECTION_BASE.DetectedItem
function DETECTION_BASE:AddDetectedItem(ItemPrefix, DetectedItemKey, Set) end

---Adds a new DetectedItem to the DetectedItems list.
---The DetectedItem is a table and contains a SET_UNIT in the field Set.
---@param ItemPrefix? any
---@param DetectedItemKey? any
---@param Set? SET_UNIT (optional) The Set of Units to be added.
---@param Zone? ZONE_UNIT (optional) The Zone to be added where the Units are located.
---@return DETECTION_BASE.DetectedItem
function DETECTION_BASE:AddDetectedItemZone(ItemPrefix, DetectedItemKey, Set, Zone) end

---Removes an existing DetectedItem from the DetectedItems list.
---The DetectedItem is a table and contains a SET_UNIT in the field Set.
---@param DetectedItemKey? any
function DETECTION_BASE:RemoveDetectedItem(DetectedItemKey) end

---Get the DetectedItems by Key.
---This will return the DetectedItems collection, indexed by the Key, which can be any object that acts as the key of the detection.
---@return DETECTION_BASE.DetectedItems
function DETECTION_BASE:GetDetectedItems() end

---Get the DetectedItems by Index.
---This will return the DetectedItems collection, indexed by an internal numerical Index.
---@return DETECTION_BASE.DetectedItems
function DETECTION_BASE:GetDetectedItemsByIndex() end

---Get the amount of SETs with detected objects.
---@return number # The amount of detected items. Note that the amount of detected items can differ with the reality, because detections are not real-time but done in intervals!
function DETECTION_BASE:GetDetectedItemsCount() end

---Get a detected item using a given Key.
---@param Key? any
---@return DETECTION_BASE.DetectedItem
function DETECTION_BASE:GetDetectedItemByKey(Key) end

---Get a detected item using a given numeric index.
---@param Index? number
---@return DETECTION_BASE.DetectedItem
function DETECTION_BASE:GetDetectedItemByIndex(Index) end

---Get a detected ItemID using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@return string # DetectedItemID
function DETECTION_BASE:GetDetectedItemID(DetectedItem) end

---Get a detected ID using a given numeric index.
---@param Index? number
---@return string # DetectedItemID
function DETECTION_BASE:GetDetectedID(Index) end

---Get the {Core.Set#SET_UNIT} of a detection area using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return SET_UNIT # DetectedSet
function DETECTION_BASE:GetDetectedItemSet(DetectedItem) end

---Set IsDetected flag for the DetectedItem, which can have more units.
---@param DetectedItem? any
---@return DETECTION_BASE.DetectedItem # DetectedItem
---@return boolean # true if at least one UNIT is detected from the DetectedSet, false if no UNIT was detected from the DetectedSet.
function DETECTION_BASE:UpdateDetectedItemDetection(DetectedItem) end

---Checks if there is at least one UNIT detected in the Set of the the DetectedItem.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return boolean # true if at least one UNIT is detected from the DetectedSet, false if no UNIT was detected from the DetectedSet.
function DETECTION_BASE:IsDetectedItemDetected(DetectedItem) end

---Get the {Core.Zone#ZONE_UNIT} of a detection area using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@return ZONE_UNIT # DetectedZone
function DETECTION_BASE:GetDetectedItemZone(DetectedItem) end

---Lock the detected items when created and lock all existing detected items.
---@return DETECTION_BASE
function DETECTION_BASE:LockDetectedItems() end

---Unlock the detected items when created and unlock all existing detected items.
---@return DETECTION_BASE
function DETECTION_BASE:UnlockDetectedItems() end

---Validate if the detected item is locked (not in the radar sense, though!).
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@return boolean
function DETECTION_BASE:IsDetectedItemLocked(DetectedItem) end

---Lock a detected item (not in the radar sense, though!).
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@return DETECTION_BASE
function DETECTION_BASE:LockDetectedItem(DetectedItem) end

---Unlock a detected item (not in the radar sense, though!).
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@return DETECTION_BASE
function DETECTION_BASE:UnlockDetectedItem(DetectedItem) end

---Set the detected item coordinate.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem to set the coordinate at.
---@param Coordinate? COORDINATE The coordinate to set the last know detected position at.
---@param DetectedItemUnit? UNIT The unit to set the heading and altitude from.
---@return DETECTION_BASE
function DETECTION_BASE:SetDetectedItemCoordinate(DetectedItem, Coordinate, DetectedItemUnit) end

---Get the detected item coordinate.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem to set the coordinate at.
---@return COORDINATE
function DETECTION_BASE:GetDetectedItemCoordinate(DetectedItem) end

---Get a list of the detected item coordinates.
---@return table # A table of Core.Point#COORDINATE
function DETECTION_BASE:GetDetectedItemCoordinates() end

---Set the detected item threat level.
---@param DetectedItem? any
---@return DETECTION_BASE
function DETECTION_BASE:SetDetectedItemThreatLevel(DetectedItem) end

---Get the detected item coordinate.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@return number # ThreatLevel
function DETECTION_BASE:GetDetectedItemThreatLevel(DetectedItem) end

---Report summary of a detected item using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@param AttackGroup? GROUP The group to generate the report for.
---@param Settings? SETTINGS Message formatting settings to use.
---@return REPORT
function DETECTION_BASE:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---@param AttackGroup? GROUP The group to generate the report for.
---@return string
function DETECTION_BASE:DetectedReportDetailed(AttackGroup) end

---Get the Detection Set.
---@return DETECTION_BASE # self
function DETECTION_BASE:GetDetectionSet() end

---Find the nearest Recce of the DetectedItem.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return UNIT # The nearest FAC unit
function DETECTION_BASE:NearestRecce(DetectedItem) end

---Schedule the DETECTION construction.
---@param DelayTime? number The delay in seconds to wait the reporting.
---@param RepeatInterval? number The repeat interval in seconds for the reporting to happen repeatedly.
---@return DETECTION_BASE # self
function DETECTION_BASE:Schedule(DelayTime, RepeatInterval) end

---@class DETECTION_UNITS : DETECTION_BASE
---@field DetectionRange number The range till which targets are detected.
DETECTION_UNITS = {
  ClassName = "DETECTION_UNITS",
  DetectionRange = nil,
}

---DETECTION_UNITS constructor.
---@param DetectionSetGroup? SET_GROUP The @{Core.Set} of GROUPs in the Forward Air Controller role.
---@return DETECTION_UNITS # self
function DETECTION_UNITS:New(DetectionSetGroup) end

---Make text documenting the changes of the detected zone.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return string # The Changes text
function DETECTION_UNITS:GetChangeText(DetectedItem) end

---Create the DetectedItems list from the DetectedObjects table.
---For each DetectedItem, a one field array is created containing the Unit detected.
---@return DETECTION_UNITS # self
function DETECTION_UNITS:CreateDetectionItems() end

---Report summary of a DetectedItem using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@param AttackGroup? GROUP The group to generate the report for.
---@param Settings? SETTINGS Message formatting settings to use.
---@param ForceA2GCoordinate? boolean Set creation of A2G coordinate
---@return REPORT # The report of the detection items.
function DETECTION_UNITS:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings, ForceA2GCoordinate) end

---Report detailed of a detection result.
---@param AttackGroup? GROUP The group to generate the report for.
---@return string
function DETECTION_UNITS:DetectedReportDetailed(AttackGroup) end

---@class DETECTION_TYPES : DETECTION_BASE
DETECTION_TYPES = {
  ClassName = "DETECTION_TYPES",
  DetectionRange = nil,
}

---DETECTION_TYPES constructor.
---@param DetectionSetGroup? SET_GROUP The @{Core.Set} of GROUPs in the Recce role.
---@return DETECTION_TYPES # self
function DETECTION_TYPES:New(DetectionSetGroup) end

---Make text documenting the changes of the detected zone.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return string # The Changes text
function DETECTION_TYPES:GetChangeText(DetectedItem) end

---Create the DetectedItems list from the DetectedObjects table.
---For each DetectedItem, a one field array is created containing the Unit detected.
---@return DETECTION_TYPES # self
function DETECTION_TYPES:CreateDetectionItems() end

---Report summary of a DetectedItem using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@param AttackGroup? GROUP The group to generate the report for.
---@param Settings? SETTINGS Message formatting settings to use.
---@return REPORT # The report of the detection items.
function DETECTION_TYPES:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---@param AttackGroup? GROUP The group to generate the report for.
---@return string
function DETECTION_TYPES:DetectedReportDetailed(AttackGroup) end

---@class DETECTION_AREAS : DETECTION_BASE
---@field DetectionZoneRange number The range till which targets are grouped upon the first detected target.
---@field DetectedItems DETECTION_BASE.DetectedItems A list of areas containing the set of @{Wrapper.Unit}s, @{Core.Zone}s, the center @{Wrapper.Unit} within the zone, and ID of each area that was detected within a DetectionZoneRange.
DETECTION_AREAS = {
  ClassName = "DETECTION_AREAS",
  DetectionZoneRange = nil,
}

---DETECTION_AREAS constructor.
---@param DetectionSetGroup? SET_GROUP The @{Core.Set} of GROUPs in the Forward Air Controller role.
---@param DetectionZoneRange? number (Optional) The range in meters within which targets are grouped upon the first detected target. Default 5000m.
---@return DETECTION_AREAS
function DETECTION_AREAS:New(DetectionSetGroup, DetectionZoneRange) end

---Retrieve set of detected zones.
---@return SET_ZONE # The @{Core.Set} of ZONE_UNIT objects detected.
function DETECTION_AREAS:GetDetectionZones() end

---Retrieve a specific zone by its ID (number)
---@param ID? number
---@return ZONE_UNIT # The zone or nil if it does not exist
function DETECTION_AREAS:GetDetectionZoneByID(ID) end

---Retrieve number of detected zones.
---@return number # The number of zones.
function DETECTION_AREAS:GetDetectionZoneCount() end

---Report summary of a detected item using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@param AttackGroup? GROUP The group to get the settings for.
---@param Settings? SETTINGS (Optional) Message formatting settings to use.
---@return REPORT # The report of the detection items.
function DETECTION_AREAS:DetectedItemReportMenu(DetectedItem, AttackGroup, Settings) end

---Report summary of a detected item using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@param AttackGroup? GROUP The group to get the settings for.
---@param Settings? SETTINGS (Optional) Message formatting settings to use.
---@return REPORT # The report of the detection items.
function DETECTION_AREAS:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---@param AttackGroup? GROUP The group to generate the report for.
---@return string
function DETECTION_AREAS:DetectedReportDetailed(AttackGroup) end

---Calculate the optimal intercept point of the DetectedItem.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
function DETECTION_AREAS:CalculateIntercept(DetectedItem) end

---Smoke the detected units
---@return DETECTION_AREAS # self
function DETECTION_AREAS:SmokeDetectedUnits() end

---Flare the detected units
---@return DETECTION_AREAS # self
function DETECTION_AREAS:FlareDetectedUnits() end

---Smoke the detected zones
---@return DETECTION_AREAS # self
function DETECTION_AREAS:SmokeDetectedZones() end

---Flare the detected zones
---@return DETECTION_AREAS # self
function DETECTION_AREAS:FlareDetectedZones() end

---Bound the detected zones
---@return DETECTION_AREAS # self
function DETECTION_AREAS:BoundDetectedZones() end

---Make text documenting the changes of the detected zone.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return string # The Changes text
function DETECTION_AREAS:GetChangeText(DetectedItem) end

---Make a DetectionSet table. This function will be overridden in the derived classes.
---@return DETECTION_AREAS # self
function DETECTION_AREAS:CreateDetectionItems() end

---OnLeave Transition Handler for State Stopped.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnLeaveStopped(From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:OnEnterStopped(From, Event, To) end

---OnBefore Transition Handler for Event Start.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnBeforeStart(From, Event, To) end

---OnAfter Transition Handler for Event Start.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:OnAfterStart(From, Event, To) end

---Synchronous Event Trigger for Event Start.
function DETECTION_BASE:Start() end

---Asynchronous Event Trigger for Event Start.
---@param Delay? number The delay in seconds.
function DETECTION_BASE:__Start(Delay) end

---OnLeave Transition Handler for State Detecting.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnLeaveDetecting(From, Event, To) end

---OnEnter Transition Handler for State Detecting.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:OnEnterDetecting(From, Event, To) end

---OnBefore Transition Handler for Event Detect.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnBeforeDetect(From, Event, To) end

---OnAfter Transition Handler for Event Detect.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:OnAfterDetect(From, Event, To) end

---Synchronous Event Trigger for Event Detect.
function DETECTION_BASE:Detect() end

---Asynchronous Event Trigger for Event Detect.
---@param Delay? number The delay in seconds.
function DETECTION_BASE:__Detect(Delay) end

---OnBefore Transition Handler for Event Detected.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnBeforeDetected(From, Event, To) end

---OnAfter Transition Handler for Event Detected.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@param Units? table Table of detected units.
function DETECTION_BASE:OnAfterDetected(From, Event, To, Units) end

---Synchronous Event Trigger for Event Detected.
---@param Units? table Table of detected units.
function DETECTION_BASE:Detected(Units) end

---Asynchronous Event Trigger for Event Detected.
---@param Delay? number The delay in seconds.
---@param Units? table Table of detected units.
function DETECTION_BASE:__Detected(Delay, Units) end

---OnAfter Transition Handler for Event DetectedItem.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@param DetectedItem? DetectedItem The DetectedItem data structure.
function DETECTION_BASE:OnAfterDetectedItem(From, Event, To, DetectedItem) end

---OnBefore Transition Handler for Event Stop.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnBeforeStop(From, Event, To) end

---OnAfter Transition Handler for Event Stop.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:OnAfterStop(From, Event, To) end

---Synchronous Event Trigger for Event Stop.
function DETECTION_BASE:Stop() end

---Asynchronous Event Trigger for Event Stop.
---@param Delay? number The delay in seconds.
function DETECTION_BASE:__Stop(Delay) end

---OnLeave Transition Handler for State Stopped.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@return boolean # Return false to cancel Transition.
function DETECTION_BASE:OnLeaveStopped(From, Event, To) end

---OnEnter Transition Handler for State Stopped.
---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
function DETECTION_BASE:OnEnterStopped(From, Event, To) end
