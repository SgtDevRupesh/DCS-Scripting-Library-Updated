---@meta

---@class DETECTION_ZONES : DETECTION_BASE
---@field DetectionZoneRange number The range till which targets are grouped upon the first detected target.
---@field DetectedItems DETECTION_BASE.DetectedItems A list of areas containing the set of @{Wrapper.Unit}s, @{Core.Zone}s, the center @{Wrapper.Unit} within the zone, and ID of each area that was detected within a DetectionZoneRange.
DETECTION_ZONES = {
  ClassName = "DETECTION_ZONES",
  DetectionZoneRange = nil,
}

---DETECTION_ZONES constructor.
---@param DetectionSetZone? SET_ZONE The @{Core.Set} of ZONE_RADIUS.
---@param DetectionCoalition? Coalition.side|number|string The coalition of the detection.
---@return DETECTION_ZONES
function DETECTION_ZONES:New(DetectionSetZone, DetectionCoalition) end

function DETECTION_ZONES:CountAliveRecce() end

---@param IteratorFunction? any
---@param ... any
function DETECTION_ZONES:ForEachAliveRecce(IteratorFunction, ...) end

---Report summary of a detected item using a given numeric index.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string The DetectedItem.
---@param AttackGroup? GROUP The group to get the settings for.
---@param Settings? SETTINGS (Optional) Message formatting settings to use.
---@return REPORT # The report of the detection items.
function DETECTION_ZONES:DetectedItemReportSummary(DetectedItem, AttackGroup, Settings) end

---Report detailed of a detection result.
---@param AttackGroup? GROUP The group to generate the report for.
---@return string
function DETECTION_ZONES:DetectedReportDetailed(AttackGroup) end

---Calculate the optimal intercept point of the DetectedItem.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
function DETECTION_ZONES:CalculateIntercept(DetectedItem) end

---Smoke the detected units
---@return DETECTION_ZONES # self
function DETECTION_ZONES:SmokeDetectedUnits() end

---Flare the detected units
---@return DETECTION_ZONES # self
function DETECTION_ZONES:FlareDetectedUnits() end

---Smoke the detected zones
---@return DETECTION_ZONES # self
function DETECTION_ZONES:SmokeDetectedZones() end

---Flare the detected zones
---@return DETECTION_ZONES # self
function DETECTION_ZONES:FlareDetectedZones() end

---Bound the detected zones
---@return DETECTION_ZONES # self
function DETECTION_ZONES:BoundDetectedZones() end

---Make text documenting the changes of the detected zone.
---@param DetectedItem? DETECTION_BASE.DetectedItem|number|string
---@return string # The Changes text
function DETECTION_ZONES:GetChangeText(DetectedItem) end

---Make a DetectionSet table. This function will be overridden in the derived clsses.
---@return DETECTION_ZONES # self
function DETECTION_ZONES:CreateDetectionItems() end

---@param From? string The From State string.
---@param Event? string The Event string.
---@param To? string The To State string.
---@param Detection? any
---@param DetectionTimeStamp? number Time stamp of detection event.
function DETECTION_ZONES:onafterDetection(From, Event, To, Detection, DetectionTimeStamp) end

---Set IsDetected flag for the DetectedItem, which can have more units.
---@param DetectedItem? any
---@return DETECTION_ZONES.DetectedItem # DetectedItem
---@return boolean # true if at least one UNIT is detected from the DetectedSet, false if no UNIT was detected from the DetectedSet.
function DETECTION_ZONES:UpdateDetectedItemDetection(DetectedItem) end
