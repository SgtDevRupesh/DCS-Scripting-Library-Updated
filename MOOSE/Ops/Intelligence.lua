---@meta

---@class INTEL.Cluster
---@field index number Cluster index.
---@field size number Number of groups in the cluster.
---@field Contacts table Table of contacts in the cluster.
---@field threatlevelMax number Max threat level of cluster.
---@field threatlevelSum number Sum of threat levels.
---@field threatlevelAve number Average of threat levels.
---@field coordinate COORDINATE Coordinate of the cluster.
---@field marker MARKER F10 marker.
---@field markerID number Marker ID.
---@field mission AUFTRAG The current Auftrag attached to this cluster.
---@field ctype string Cluster type of #INTEL.Ctype.
---@field altitude number [AIR] Average flight altitude of the cluster in meters.

---@class INTEL.Contact
---@field groupname string Name of the group.
---@field group GROUP The contact group.
---@field typename string Type name of detected item.
---@field category number Category number.
---@field categoryname string Category name.
---@field attribute string Generalized attribute.
---@field threatlevel number Threat level of this item.
---@field Tdetected number Time stamp in abs. mission time seconds when this item was last detected.
---@field position COORDINATE Last known position of the item.
---@field velocity Vec3 3D velocity vector. Components x,y and z in m/s.
---@field speed number Last known speed in m/s.
---@field isship boolean If `true`, contact is a naval group.
---@field ishelo boolean If `true`, contact is a helo group.
---@field isground boolean If `true`, contact is a ground group.
---@field isStatic boolean If `true`, contact is a STATIC object.
---@field mission AUFTRAG The current Auftrag attached to this contact.
---@field target TARGET The Target attached to this contact.
---@field recce string The name of the recce unit that detected this contact.
---@field ctype string Contact type of #INTEL.Ctype.
---@field platform string [AIR] Contact platform name, e.g. Foxbat, Flanker_E, defaults to Bogey if unknown
---@field heading number [AIR] Heading of the contact, if available.
---@field maneuvering boolean [AIR] Contact has changed direction by >10 deg.
---@field altitude number [AIR] Flight altitude of the contact in meters.

---INTEL class.
---@class INTEL : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field coalition number Coalition side number, e.g. `coalition.side.RED`.
---@field alias string Name of the agency.
---@field detectionset SET_GROUP Set of detection groups, aka agents.
---@field _detectionBatchSize number [Internal] Optional groups per batch; nil keeps synchronous detection.
---@field _detectionBatchInterval number [Internal] Seconds between batches when batching is enabled.
---@field _detectionSweep table [Internal] Pending sweep membership, detected units, recces, cursor and timer.
---@field filterCategory table Filter for unit categories.
---@field filterCategoryGroup table Filter for group categories.
---@field acceptzoneset SET_ZONE Set of accept zones. If defined, only contacts in these zones are considered.
---@field rejectzoneset SET_ZONE Set of reject zones. Contacts in these zones are not considered, even if they are in accept zones.
---@field conflictzoneset SET_ZONE Set of conflict zones. Contacts in these zones are considered, even if they are not in accept zones or if they are in reject zones.
---@field corridorzoneset SET_ZONE Set of corridor zones. Contacts in these zones are never considered. Also see corridorfloorheight and corridorfloorceiling.
---@field corridorfloor number [Air] Contacts below this height (ASL!) are considered, even if they are in a corridor zone.
---@field corridorceiling number [Air] Contacts above this height (ASL!) are considered, even if they are in a corridor zone.
---@field Contacts table Table of detected items.
---@field ContactsLost table Table of lost detected items.
---@field ContactsUnknown table Table of new detected items.
---@field Clusters table Clusters of detected groups.
---@field clusteranalysis boolean If true, create clusters of detected targets.
---@field clustermarkers boolean If true, create cluster markers on F10 map.
---@field clustercounter number Running number of clusters.
---@field dTforget number Time interval in seconds before a known contact which is not detected any more is forgotten.
---@field clusterradius number Radius in meters in which groups/units are considered to belong to a cluster.
---@field prediction number Seconds default to be used with CalcClusterFuturePosition.
---@field detectStatics boolean If `true`, detect STATIC objects. Default `false`.
---@field statusupdate number Time interval in seconds after which the status is refreshed. Default 60 sec. Should be negative.
---@field DetectAccoustic boolean If true, also detect by sound (ie proximity).
---@field DetectAccousticRadius number Radius dfor accoustic detection, defaults to 2000 meters.
---@field DetectAccousticUnitTypes table Types of units we can detect accousticly. Defaults to {Unit.Category.HELICOPTER}
INTEL = {
  ClassName       = "INTEL",
  verbose         =     0,
  lid             =   nil,
  alias           =   nil,
  filterCategory  =    {},
  detectionset    =   nil,
  Contacts        =    {},
  ContactsLost    =    {},
  ContactsUnknown =    {},
  Clusters        =    {},
  clustercounter  =     1,
  clusterradius   = 15000,
  clusteranalysis =  true,
  clustermarkers  = false,
  clusterarrows   = false,
  prediction      =   300,
  detectStatics   = false,
  DetectAccoustic = false,
  DetectAccousticRadius = 1000,
  DetectAccousticUnitTypes =  {Unit.Category.HELICOPTER},
  DopplerRadar        = false,
  DopplerMinAltAGL    = 500,
  DopplerNotchSin     = math.sin(math.rad(15)),
  DopplerMinSpeedMps  = 50,
  DopplerRCS          = true,
  DopplerRadarRangeM  = 200 * 1000,
}

---Contact or cluster type.
---@class INTEL.Ctype
---@field GROUND string Ground.
---@field NAVAL string Ship.
---@field AIRCRAFT string Airpane or helicopter.
---@field STRUCTURE string Static structure.
INTEL.Ctype={
  GROUND="Ground",
  NAVAL="Naval",
  AIRCRAFT="Aircraft",
  STRUCTURE="Structure"
}

---INTEL class version.
INTEL.version = "0.3.10"

---══════════════════════════════════════════════════════════════════
--- INTEL Doppler radar extension
---
--- Models four phenomena of a 1970/80s pulse-Doppler ground radar
--- (representative types: Soviet P-18 Spoon Rest, P-37 Bar Lock,
---  P-80 Back Net / NATO AN/TPS-43 / Hughes AN/TPS-70):
---
---  A) GROUND CLUTTER (AGL threshold)
---     Low-flying targets blend into terrain returns. Below DopplerMinAltAGL
---     detection probability drops linearly to 0 at 0 m AGL.
---
---  B) VELOCITY NOTCH (beam aspect)
---     The MTI (Moving Target Indicator) filter suppresses returns with
---     near-zero Doppler shift. Targets flying perpendicular to the radar
---     beam (radial-velocity fraction < sin(NotchHalfDeg)) are rejected.
---     Classic P-18/P-37 notch was ≈ ±12–18° around 90° aspect.
---
---  C) MINIMUM SPEED GATE
---     Very slow targets (taxiing aircraft, hovering) cannot be separated
---     from ground clutter by their Doppler shift alone.
---
---  D) RADAR CROSS SECTION (RCS)
---     Larger targets are detectable at longer ranges. The radar range
---     equation gives R_max ∝ σ^0.25, so detection range is scaled by
---     (σ / σ_ref)^0.25 relative to a reference aircraft (default: 5 m²).
---     RCS also varies with aspect: nose-on ≈ 15% of side-on value.
---     Known DCS aircraft values are stored in INTEL.RCS_Table; unknowns
---     fall back to a category default (fighter/bomber/helicopter).
---     Values are approximate averages from public IISS/Jane's data.
---══════════════════════════════════════════════════════════════════
---
---── RCS lookup table (nominal side-on RCS in m²) ─────────────────
---Frontal (nose-on / tail-on) RCS is modelled as 15% of these values
---via aspect interpolation in _GetAspectRCS().
---Sources: public declassified estimates, Jane's, IISS assessments.
INTEL.RCS_Table = {
    ["A-10C"]              =  8.0,   -- large, flat surfaces, no LO shaping
    ["A-10C_2"]            =  8.0,
    ["F-14A-135-GR"]       =  6.0,   -- variable-sweep; larger than F-16
    ["F-14B"]              =  6.0,
    ["F-15C"]              =  5.0,
    ["F-15E"]              =  5.0,   -- CFTs add modest signature
    ["F-15ESE"]            =  5.0,
    ["F-16A"]              =  1.2,
    ["F-16C bl.50"]        =  1.2,
    ["F-16C bl.52d"]       =  1.2,
    ["F/A-18C"]            =  1.5,
    ["FA-18C_hornet"]      =  1.5,
    ["F/A-18C_hornet"]     =  1.5,
    ["F/A-18F"]            =  2.0,   -- slightly larger two-seater
    ["F-117A"]             =  0.003, -- faceted LO design
    ["F-22A"]              =  0.0001,-- VLO
    ["F-35A"]              =  0.001, -- VLO, approx
    ["B-52H"]              = 100.0,  -- very large, many flat reflectors
    ["B-1B"]               =  0.75,  -- blended-wing LO shaping
    ["B-2A"]               =  0.001, -- VLO flying wing
    ["AV8BNA"]             =  2.0,
    ["Harrier"]            =  2.0,
    ["A-4E-C"]             =  3.0,
    ["Tornado_IDS"]        =  5.0,
    ["Tornado_GR4"]        =  5.0,
    ["F-111F"]             =  5.0,
    ["F-4E"]               =  6.0,   -- large, blunt nose
    ["F-5E"]               =  1.0,   -- small fighter
    ["F-5E-3"]             =  1.0,
    ["Mirage-F1CE"]        =  2.5,
    ["Mirage-F1EE"]        =  2.5,
    ["M-2000C"]            =  2.0,
    ["M-2000-5"]           =  2.0,
    ["C-17A"]              = 50.0,
    ["C-130"]              = 40.0,
    ["KC-130"]             = 40.0,
    ["KC-135"]             = 50.0,
    ["IL-76MD"]            = 45.0,
    ["E-3A"]               = 50.0,   -- plus large rotodome
    ["MiG-15bis"]          =  4.0,
    ["MiG-19P"]            =  3.5,
    ["MiG-21Bis"]          =  2.5,   -- small delta
    ["MiG-23MLD"]          =  7.0,   -- variable-sweep, large intakes
    ["MiG-25PD"]           = 14.0,   -- very large, all-metal, Mach-3 design
    ["MiG-25RBT"]          = 14.0,
    ["MiG-29A"]            =  5.0,
    ["MiG-29S"]            =  5.0,
    ["MiG-29G"]            =  5.0,
    ["MiG-29K"]            =  4.0,
    ["MiG-31"]             = 14.0,   -- similar to MiG-25
    ["Su-7B"]              =  6.0,
    ["Su-17M4"]            =  7.0,   -- variable-sweep
    ["Su-24M"]             =  6.0,
    ["Su-24MR"]            =  6.0,
    ["Su-25"]              = 10.0,
    ["Su-25T"]             = 10.0,
    ["Su-25TM"]            = 10.0,
    ["Su-27"]              = 15.0,
    ["Su-30"]              = 15.0,
    ["Su-33"]              = 15.0,   -- wing fold + canards
    ["Su-34"]              = 10.0,   -- some reduction vs Su-27
    ["Su-57"]              =  0.01,  -- PAK-FA LO shaping
    ["Tu-22M3"]            = 20.0,
    ["Tu-95MS"]            = 80.0,
    ["Tu-142"]             = 80.0,
    ["Tu-160"]             = 12.0,   -- blended wing reduces vs Tu-95
    ["An-26B"]             = 30.0,
    ["An-30M"]             = 30.0,
    ["IL-78M"]             = 45.0,
    ["A-50"]               = 50.0,   -- plus rotodome
    ["Mi-8MT"]             =  5.0,
    ["Mi-8MSB"]            =  5.0,
    ["Mi-8MSB-V"]          =  5.0,
    ["Mi-8AMTSh"]          =  5.0,
    ["Mi-24V"]             =  3.5,
    ["Mi-24P"]             =  3.5,
    ["Mi-28N"]             =  2.5,
    ["Ka-50"]              =  2.0,
    ["Ka-52"]              =  2.0,
    ["AH-64D"]             =  3.5,
    ["AH-64D_BLK_II"]      =  3.5,
    ["UH-1H"]              =  3.0,
    ["UH-60L"]             =  3.0,
    ["CH-47D"]             =  8.0,   -- large tandem-rotor
    ["OH-58D"]             =  0.8,   -- small scout
    ["SA342M"]             =  0.8,
    ["SA342L"]             =  0.8,
}

---Category-based defaults for aircraft types not in the table.
---Keyed by DCS Group.Category integer.
---@class INTEL.RCS_CategoryDefault
---@field Group number .Category.AIRPLANE RCS Airplane (fightrt) fallback == 5
---@field Group number .Category.HELICOPTER RCS Helo fallback == 2.5
INTEL.RCS_CategoryDefault = {
    [Group.Category.AIRPLANE]   = 5.0,  -- generic fighter-sized
    [Group.Category.HELICOPTER] = 2.5,  -- generic helicopter
}

---Reference RCS (m²) for range scaling.  Detection range in Set
---is the range at which this reference aircraft is reliably detected.
INTEL.RCS_Reference = 5.0

---Nose-on/tail-on RCS as a fraction of the side-on value.
---Public estimates for conventional (non-LO) aircraft: ~0.10–0.20.
INTEL.RCS_NoseOnFraction = 0.15

---Create a new INTEL object and start the FSM.
---@param DetectionSet? SET_GROUP Set of detection groups.
---@param Coalition? number Coalition side. Can also be passed as a string "red", "blue" or "neutral".
---@param Alias? string An *optional* alias how this object is called in the logs etc.
---@return INTEL # self
function INTEL:New(DetectionSet, Coalition, Alias) end

---Set accept zones. Only contacts detected in this/these zone(s) are considered.
---@param AcceptZoneSet? SET_ZONE Set of accept zones.
---@return INTEL # self
function INTEL:SetAcceptZones(AcceptZoneSet) end

---Set to accept accoustic detection.
---@param Radius? number (Optional) Radius in which we can "hear" units. Defaults to 1000 meters.
---@param UnitCategories? any (Optional)  Set what Unit Categories we can "hear". Defaults to `{Unit.Category.HELICOPTER}`
---@param PlayersOnly? boolean (Optional) Detect only players in the allowed unit categories. Defaults to false.
---@param PlayerSnapshotProvider? function (Optional) Function receiving the opposing coalition and returning `{rows={{unit=nativeUnit,category=unitCategory,point=vec3},...}}` for its players. Without a provider, use coalition.getPlayers.
---@return INTEL # self
function INTEL:SetAccousticDetectionOn(Radius, UnitCategories, PlayersOnly, PlayerSnapshotProvider) end

---Switch off accoustic detection.
---@return INTEL # self
function INTEL:SetAccousticDetectionOff() end

---Add an accept zone. Only contacts detected in this zone are considered.
---@param AcceptZone? ZONE Add a zone to the accept zone set.
---@return INTEL # self
function INTEL:AddAcceptZone(AcceptZone) end

---Remove an accept zone from the accept zone set.
---@param AcceptZone? ZONE Remove a zone from the accept zone set.
---@return INTEL # self
function INTEL:RemoveAcceptZone(AcceptZone) end

---Set reject zones. Contacts detected in this/these zone(s) are rejected and not reported by the detection.
---Note that reject zones overrule accept zones, i.e. if a unit is inside an accept zone and inside a reject zone, it is rejected.
---@param RejectZoneSet? SET_ZONE Set of reject zone(s).
---@return INTEL # self
function INTEL:SetRejectZones(RejectZoneSet) end

---Add a reject zone. Contacts detected in this zone are rejected and not reported by the detection.
---Note that reject zones overrule accept zones, i.e. if a unit is inside an accept zone and inside a reject zone, it is rejected.
---@param RejectZone? ZONE Add a zone to the reject zone set.
---@return INTEL # self
function INTEL:AddRejectZone(RejectZone) end

---Remove a reject zone from the reject zone set.
---@param RejectZone? ZONE Remove a zone from the reject zone set.
---@return INTEL # self
function INTEL:RemoveRejectZone(RejectZone) end

---Set conflict zones. Contacts detected in this/these zone(s) are reported by the detection.
---Note that conflict zones overrule all other zones, i.e. if a unit is outside of an accept zone and inside a reject zone, it is still reported if inside a conflict zone.
---@param ConflictZoneSet? SET_ZONE Set of conflict zone(s).
---@return INTEL # self
function INTEL:SetConflictZones(ConflictZoneSet) end

---Add a conflict zone. Contacts detected in this zone are conflicted and not reported by the detection.
---Note that conflict zones overrule all other zones, i.e. if a unit is outside of an accept zone and inside a reject zone, it is still reported if inside a conflict zone.
---@param ConflictZone? ZONE Add a zone to the conflict zone set.
---@return INTEL # self
function INTEL:AddConflictZone(ConflictZone) end

---Remove a conflict zone from the conflict zone set.
---Note that conflict zones overrule all other zones, i.e. if a unit is outside of an accept zone and inside a reject zone, it is still reported if inside a conflict zone.
---@param ConflictZone? ZONE Remove a zone from the conflict zone set.
---@return INTEL # self
function INTEL:RemoveConflictZone(ConflictZone) end

---Set corrdidor zones. Contacts detected in this/these zone(s) are never reported by the detection.
---Note that corrdidor zones overrule all other zones, for exceptions see corridor floor and corridor ceiling heights.
---@param CorridorZoneSet? SET_ZONE Set of corrdidor zone(s).
---@return INTEL # self
function INTEL:SetCorridorZones(CorridorZoneSet) end

---Add a corrdidor zone. Contacts detected in this zone are corrdidored and not reported by the detection.
---Note that corrdidor zones overrule all other zones, for exceptions see corridor floor and corridor ceiling heights.
---@param CorridorZone? ZONE Add a zone to the corrdidor zone set.
---@return INTEL # self
function INTEL:AddCorridorZone(CorridorZone) end

---Remove a corrdidor zone from the corrdidor zone set.
---Note that corrdidor zones overrule all other zones, for exceptions see corridor floor and corridor ceiling heights.
---@param CorridorZone? ZONE Remove a zone from the corrdidor zone set.
---@return INTEL # self
function INTEL:RemoveCorridorZone(CorridorZone) end

---[Air] Add corrdidor zone floor and height. This is generally applicable to all(!) corridor zones. Considered as ASL (above sea level or barometric) values.
---Overrides corridor exception for objects flying outside this limitations.
---To set an individual ceiling/floor on any Core.Zone#ZONE you wish to use, set these properties on the Core.Zone#ZONE object:
---`mycorridorzone:SetProperty("CorridorFloor",500)` -- meters, case sensitivity matters!
---`mycorridorzone:SetProperty("CorridorCeiling",10000)` -- meters, case sensitivity matters!
---@param Floor? number Floor altitude in meters.
---@param Ceiling? number Ceiling altitude in meters.
---@return INTEL # self
function INTEL:SetCorridorLimits(Floor, Ceiling) end

---[Air] Add corrdidor zone floor and height. This is generally applicable to all(!) corridor zones. Considered as ASL (above sea level or barometric) values.
---Overrides corridor exception for objects flying outside this limitations.
---To set an individual ceiling/floor on any Core.Zone#ZONE you wish to use, set these properties on the Core.Zone#ZONE object:
---`mycorridorzone:SetProperty("CorridorFloor",UTILS.FeetToMeters(5000))` -- feet, case sensitivity matters!
---`mycorridorzone:SetProperty("CorridorCeiling",UTILS.FeetToMeters(20000))` -- feet, case sensitivity matters!
---@param Floor? number Floor altitude in feet.
---@param Ceiling? number Ceiling altitude in feet.
---@return INTEL # self
function INTEL:SetCorridorLimitsFeet(Floor, Ceiling) end

---**OBSOLETE, not functional!**  Set forget contacts time interval.
---Previously known contacts that are not detected any more, are "lost" after this time.
---This avoids fast oscillations between a contact being detected and undetected.
---@param TimeInterval? number (Optional) Time interval in seconds. Default is 120 sec.
---@return INTEL # self
function INTEL:SetForgetTime(TimeInterval) end

---Filter unit categories. Valid categories are:
---
---* Unit.Category.AIRPLANE
---* Unit.Category.HELICOPTER
---* Unit.Category.GROUND_UNIT
---* Unit.Category.SHIP
---* Unit.Category.STRUCTURE
---@param Categories? any Filter categories, e.g. {Unit.Category.AIRPLANE, Unit.Category.HELICOPTER}.
---@return INTEL # self
function INTEL:SetFilterCategory(Categories) end

---Method to make the radar detection less accurate, e.g. for WWII scenarios.
---@param minheight? number (Optional) Minimum flight height to be detected, in meters AGL (above ground). Defaults to 250m.
---@param thresheight? number (Optional) Threshold to escape the radar if flying below minheight, defaults to 90 (90% escape chance)
---@param thresblur? number (Optional) Threshold to be detected by the radar overall, defaults to 85 (85% chance to be found)
---@param closing? number (Optional) Closing-in in km - the limit of km from which on it becomes increasingly difficult to escape radar detection if flying towards the radar position. Should be about 1/3 of the radar detection radius in kilometers, defaults to 20.
---@return INTEL # self
function INTEL:SetRadarBlur(minheight, thresheight, thresblur, closing) end

---Set the accept range in kilometers from each of the recce. Only object closer than this range will be detected.
---@param Range? number Range in kilometers
---@return INTEL # self
function INTEL:SetAcceptRange(Range) end

---Filter group categories. Valid categories are:
---
---* Group.Category.AIRPLANE
---* Group.Category.HELICOPTER
---* Group.Category.GROUND
---* Group.Category.SHIP
---* Group.Category.TRAIN
---@param GroupCategories? any Filter categories, e.g. `{Group.Category.AIRPLANE, Group.Category.HELICOPTER}`.
---@return INTEL # self
function INTEL:FilterCategoryGroup(GroupCategories) end

---Add a group to the detection set.
---@param AgentGroup? GROUP Group of agents. Can also be an @{Ops.OpsGroup#OPSGROUP} object.
---@return INTEL # self
function INTEL:AddAgent(AgentGroup) end

---Enable or disable cluster analysis of detected targets.
---Targets will be grouped in coupled clusters.
---@param Switch? boolean If true, enable cluster analysis.
---@param Markers? boolean If true, place markers on F10 map.
---@param Arrows? boolean If true, draws arrows on F10 map.
---@return INTEL # self
function INTEL:SetClusterAnalysis(Switch, Markers, Arrows) end

---Set whether STATIC objects are detected.
---@param Switch? boolean If `true`, statics are detected.
---@return INTEL # self
function INTEL:SetDetectStatics(Switch) end

---Set verbosity level for debugging.
---@param Verbosity? number The higher, the noisier, e.g. 0=off, 2=debug
---@return INTEL # self
function INTEL:SetVerbosity(Verbosity) end

---Add a Mission (Auftrag) to a contact for tracking.
---@param Contact? INTEL.Contact|number|string The contact
---@param Mission? AUFTRAG The mission connected with this contact
---@return INTEL # self
function INTEL:AddMissionToContact(Contact, Mission) end

---Add a Mission (Auftrag) to a cluster for tracking.
---@param Cluster? INTEL.Cluster|number|string The cluster
---@param Mission? AUFTRAG The mission connected with this cluster
---@return INTEL # self
function INTEL:AddMissionToCluster(Cluster, Mission) end

---Change radius of the Clusters.
---@param radius? number (Optional) The radius of the clusters in kilometers. Default 15 km.
---@return INTEL # self
function INTEL:SetClusterRadius(radius) end

---Set detection types for this #INTEL - all default to true.
---@param DetectVisual? boolean Visual detection
---@param DetectOptical? boolean Optical detection
---@param DetectRadar? boolean Radar detection
---@param DetectIRST? boolean IRST detection
---@param DetectRWR? boolean RWR detection
---@param DetectDLINK? boolean Data link detection
---@return self
function INTEL:SetDetectionTypes(DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Get table of #INTEL.Contact objects
---@return table # Contacts or nil if not running
function INTEL:GetContactTable() end

---Get table of #INTEL.Cluster objects
---@return table # Clusters or nil if not running
function INTEL:GetClusterTable() end

---Get name of a contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return string # Name of the contact.
function INTEL:GetContactName(Contact) end

---Get group of a contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return GROUP # Group object.
function INTEL:GetContactGroup(Contact) end

---Get threatlevel of a contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return number # Threat level.
function INTEL:GetContactThreatlevel(Contact) end

---Get type name of a contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return string # Type name.
function INTEL:GetContactTypeName(Contact) end

---Get category name of a contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return string # Category name.
function INTEL:GetContactCategoryName(Contact) end

---Get coordinate of a contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return COORDINATE # Coordinates.
function INTEL:GetContactCoordinate(Contact) end

---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function INTEL:onafterStart(From, Event, To) end

---On after "Status" event. In batch mode, contacts are published when the sweep completes.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function INTEL:onafterStatus(From, Event, To) end

---On after "Stop" event. Cancel an unfinished detection sweep.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@return INTEL # self
function INTEL:onafterStop(From, Event, To) end

---[Internal] Report the contacts and clusters from a completed detection sweep.
---@return INTEL # self
function INTEL:_ReportIntelStatus() end

---Update detected items. Optional batches publish contacts after the complete sweep.
function INTEL:UpdateIntel() end

---(Internal) Prepare eligible player facts once for the current accoustic detection batch.
---Positions must be refreshed for each batch. Do not retain these rows across timers or respawns.
---@return table # Rows containing the MOOSE unit, unit name, native object ID and Vec3 position.
function INTEL:_GetAccousticPlayers() end

---Update an #INTEL.Contact item.
---@param Contact? INTEL.Contact|number|string Contact.
---@return INTEL.Contact # The contact.
function INTEL:_UpdateContact(Contact) end

---Create an #INTEL.Contact item from a given GROUP or STATIC object.
---@param Positionable? POSITIONABLE The GROUP or STATIC object.
---@param RecceName? string The name of the recce group that has detected this contact.
---@return INTEL.Contact # The contact.
function INTEL:_CreateContact(Positionable, RecceName) end

---Create detected items.
---@param DetectedGroups? table Table of detected Groups.
---@param DetectedStatics? table Table of detected Statics.
---@param RecceDetecting? table Table of detecting recce names.
function INTEL:CreateDetectedItems(DetectedGroups, DetectedStatics, RecceDetecting) end

---(Internal) Return the detected target groups of the controllable as a table.
---The optional parameters specify the detection methods that can be applied.
---If no detection method is given, the detection will use all the available methods by default.
---@param Unit? UNIT The unit detecting.
---@param DetectedUnits? table Table of detected units to be filled.
---@param RecceDetecting? table Table of recce per unit to be filled.
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@param DetectedObjects? table (Optional) Table of native object IDs for the current sweep.
function INTEL:GetDetectedUnits(Unit, DetectedUnits, RecceDetecting, DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK, DetectedObjects) end

---(Internal) Return the detected target groups of the controllable as a {Core.Set#SET_GROUP}.
---@param Recce? UNIT The unit detecting.
---@param DetectedUnits? table Table of detected units to be filled.
---@param RecceDetecting? table Table of recce per unit to be filled.
---@param detectionzone? ZONE_GROUP The zone where to look.
---@param DetectedObjects? table (Optional) Table of native object IDs for the current sweep.
---@param AccousticPlayers? table (Optional) Eligible player facts prepared for this batch; omitted direct calls collect fresh facts.
function INTEL:GetDetectedUnitsAccoustic(Recce, DetectedUnits, RecceDetecting, detectionzone, DetectedObjects, AccousticPlayers) end

---On after "NewContact" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Contact? INTEL.Contact|number|string Detected contact.
function INTEL:onafterNewContact(From, Event, To, Contact) end

---On after "LostContact" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Contact? INTEL.Contact|number|string Lost contact.
function INTEL:onafterLostContact(From, Event, To, Contact) end

---On after "NewCluster" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Cluster? INTEL.Cluster|number|string Detected cluster.
function INTEL:onafterNewCluster(From, Event, To, Cluster) end

---On after "LostCluster" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Cluster? INTEL.Cluster|number|string Lost cluster.
---@param Mission? AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:onafterLostCluster(From, Event, To, Cluster, Mission) end

---Make the INTEL aware of a object that was not detected (yet). This will add the object to the contacts table and trigger a `NewContact` event.
---@param Positionable? POSITIONABLE Group or static object.
---@param RecceName? string Name of the recce group that detected this object.
---@param Tdetected? number (Optional) Abs. mission time in seconds, when the object is detected. Default now.
---@return INTEL # self
function INTEL:KnowObject(Positionable, RecceName, Tdetected) end

---Get a contact by name.
---@param groupname? string Name of the contact group.
---@return INTEL.Contact # The contact.
function INTEL:GetContactByName(groupname) end

---Check if a Contact is already known. It is checked, whether the contact is in the contacts table.
---@param Contact? INTEL.Contact|number|string The contact to be added.
---@return boolean # If `true`, contact is already known.
function INTEL:_IsContactKnown(Contact) end

---Add a contact to our list.
---@param Contact? INTEL.Contact|number|string The contact to be added.
---@return INTEL # self
function INTEL:AddContact(Contact) end

---Remove a contact from our list.
---@param Contact? INTEL.Contact|number|string The contact to be removed.
function INTEL:RemoveContact(Contact) end

---Check if a contact was lost.
---@param Contact? INTEL.Contact|number|string The contact to be removed.
---@return boolean # If true, contact was not detected for at least *dTforget* seconds.
function INTEL:_CheckContactLost(Contact) end

---[Internal] Paint picture of the battle field. Does Cluster analysis and updates clusters. Sets markers if markers are enabled.
function INTEL:PaintPicture() end

---Create a new cluster.
---@return INTEL.Cluster # cluster The cluster.
function INTEL:_CreateCluster() end

---Create a new cluster from a first contact. The contact is automatically added to the cluster.
---@param Contact? INTEL.Contact|number|string The first contact.
---@return INTEL.Cluster # cluster The cluster.
function INTEL:_CreateClusterFromContact(Contact) end

---Add cluster to table.
---@param Cluster? INTEL.Cluster|number|string The cluster to add.
function INTEL:_AddCluster(Cluster) end

---Add a contact to the cluster.
---@param contact? INTEL.Contact|number|string The contact.
---@param cluster? INTEL.Cluster|number|string The cluster.
function INTEL:AddContactToCluster(contact, cluster) end

---Remove a contact from a cluster.
---@param contact? INTEL.Contact|number|string The contact.
---@param cluster? INTEL.Cluster|number|string The cluster.
function INTEL:RemoveContactFromCluster(contact, cluster) end

---Calculate cluster threat level sum.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@return number # Sum of all threat levels of all groups in the cluster.
function INTEL:CalcClusterThreatlevelSum(cluster) end

---Calculate cluster threat level average.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@return number # Average of all threat levels of all groups in the cluster.
function INTEL:CalcClusterThreatlevelAverage(cluster) end

---Calculate max cluster threat level.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@return number # Max threat levels of all groups in the cluster.
function INTEL:CalcClusterThreatlevelMax(cluster) end

---Calculate cluster heading.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@return number # Heading average of all groups in the cluster.
function INTEL:CalcClusterDirection(cluster) end

---Calculate cluster speed.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@return number # Speed average of all groups in the cluster in MPS.
function INTEL:CalcClusterSpeed(cluster) end

---Calculate cluster velocity vector.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@return Vec3 # Velocity vector in m/s.
function INTEL:CalcClusterVelocityVec3(cluster) end

---Calculate cluster future position after given seconds.
---@param cluster? INTEL.Cluster|number|string The cluster of contacts.
---@param seconds? number (Optional) Time interval in seconds. Default is `self.prediction`.
---@return COORDINATE # Calculated future position of the cluster.
function INTEL:CalcClusterFuturePosition(cluster, seconds) end

---Check if contact is in any known cluster.
---@param contact? INTEL.Contact|number|string The contact.
---@return boolean # If true, contact is in clusters
function INTEL:CheckContactInClusters(contact) end

---Check if contact is close to any other contact this cluster.
---@param contact? INTEL.Contact|number|string The contact.
---@param cluster? INTEL.Cluster|number|string The cluster the check.
---@return boolean # If `true`, contact is connected to this cluster.
---@return number # Distance to cluster in meters.
function INTEL:IsContactConnectedToCluster(contact, cluster) end

---Check if contact is close to any contact of known clusters.
---@param contact? INTEL.Contact|number|string The contact.
---@return INTEL.Cluster # The cluster this contact is part of or nil otherwise.
function INTEL:IsContactPartOfAnyClusters(contact) end

---Get distance to cluster.
---@param Contact? INTEL.Contact|number|string The contact.
---@param Cluster? INTEL.Cluster|number|string The cluster to which the distance is calculated.
---@return number # Distance in meters.
function INTEL:_GetDistContactToCluster(Contact, Cluster) end

---Get closest cluster of contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return INTEL.Cluster # The cluster this contact is part of or `#nil` otherwise.
---@return number # Distance to cluster in meters.
function INTEL:_GetClosestClusterOfContact(Contact) end

---Get the cluster this contact belongs to (if any).
---@param contact? INTEL.Contact|number|string The contact.
---@return INTEL.Cluster # The cluster this contact belongs to or nil.
function INTEL:GetClusterOfContact(contact) end

---Get the altitude of a cluster.
---@param Cluster? INTEL.Cluster|number|string The cluster.
---@param Update? boolean If `true`, update the altitude. Default is to just return the last stored altitude.
---@return number # The average altitude (ASL) of this cluster in meters.
function INTEL:GetClusterAltitude(Cluster, Update) end

---Get the coordinate of a cluster.
---@param Cluster? INTEL.Cluster|number|string The cluster.
---@param Update? boolean (Optional) If `true`, update the coordinate. Default is to just return the last stored position.
---@return COORDINATE # The coordinate of this cluster.
function INTEL:GetClusterCoordinate(Cluster, Update) end

---Check if the coordindate of the cluster changed.
---@param Cluster? INTEL.Cluster|number|string The cluster.
---@param Coordinate? COORDINATE (Optional) Reference coordinate. Default is the last known coordinate of the cluster.
---@param Threshold? any
---@return boolean # If `true`, the coordinate changed by more than the given threshold.
function INTEL:_CheckClusterCoordinateChanged(Cluster, Coordinate, Threshold) end

---Update coordinates of the known clusters.
function INTEL:_UpdateClusterPositions() end

---Count number of alive units in contact.
---@param Contact? INTEL.Contact|number|string The contact.
---@return number # unitcount
function INTEL:ContactCountUnits(Contact) end

---Count number of alive units in cluster.
---@param Cluster? INTEL.Cluster|number|string The cluster
---@return number # unitcount
function INTEL:ClusterCountUnits(Cluster) end

---Update cluster F10 marker.
---@param cluster? INTEL.Cluster|number|string The cluster.
---@return INTEL # self
function INTEL:UpdateClusterMarker(cluster) end

---Get the contact with the highest threat level from the cluster.
---@param Cluster? INTEL.Cluster|number|string The cluster.
---@return INTEL.Contact # the contact or nil if none
function INTEL:GetHighestThreatContact(Cluster) end

---Enable 70/80s era pulse-Doppler ground-clutter simulation.
---Only affects contacts detected via radar (DetectRadar=true paths).
---Has no effect on visual, optical, IRST, RWR or datalink detections.
---@param MinAltAGL? number Min AGL altitude in metres for reliable detection. Below this the detection probability drops linearly. Default 500 m (≈ clutter floor for P-18 / P-37).
---@param NotchHalfDeg? number Half-width of the velocity notch in degrees. Targets with radial-velocity fraction < sin(NotchHalf) are suppressed.  Default 15° (≈ P-18 / Bar Lock spec).
---@param MinSpeedMps? number Minimum speed in m/s that the MTI filter can track. Default 50 m/s (≈ 100 kt).
---@param RadarRangeKm? number Nominal detection range in km for the reference aircraft (RCS_Reference, default 5 m²). Used only for RCS range scaling; has no effect when DopplerRCS is false. Default 200 km (≈ P-37 instrumented range vs fighter).
---@param RCS? boolean If false, disable RCS range scaling (keep A–C only). Default true.
---@return INTEL # self
function INTEL:SetDopplerRadar(MinAltAGL, NotchHalfDeg, MinSpeedMps, RadarRangeKm, RCS) end

---Disable Doppler radar simulation.
---@return INTEL # self
function INTEL:SetDopplerRadarOff() end

---Override the per-type RCS value for a DCS unit type name.
---Useful for modded aircraft or mission-specific tweaks.
---@param TypeName? string DCS unit type name (e.g. "MiG-29A")
---@param RCS_m2? number Side-on RCS in m²
---@return INTEL # self
function INTEL:SetTypeRCS(TypeName, RCS_m2) end

---(Internal) Compute the aspect-weighted RCS for a target unit as seen
---from a given radar position.
---
---The model blends the side-on (maximum) and nose/tail-on (minimum) RCS
---using the geometry of the target's velocity relative to the radar line:
---
---  σ_eff = σ_base × ( f_nose + (1 − f_nose) × sin²(aspect_from_radial) )
---
---where aspect_from_radial is 0° when the target flies toward/away from
---the radar (nose-on) and 90° when the target crosses the beam (side-on).
---@param TargetUnit? UNIT
---@param rpos? table Radar position as Vec3 {x,y,z}
---@param spd? number Target speed in m/s (pre-computed for efficiency)
---@param tvel? Vec3 Target velocity vector (pre-computed)
---@return number # Effective RCS in m²
function INTEL:_GetAspectRCS(TargetUnit, rpos, spd, tvel) end

---(Internal) Check whether a target unit would be detected by a 70/80s
---pulse-Doppler radar located at the given radar unit position.
---@param TargetUnit? UNIT
---@param RadarUnit? UNIT
---@return boolean # true = detected
---@return string # rejection reason: "speed" | "clutter" | "notch" | "rcs"
function INTEL:_CheckDopplerDetection(TargetUnit, RadarUnit) end

---(Internal) Return the detected target groups of the controllable as a table.
---We wrap the original function so the Doppler post-filter is transparent:
---the existing RadarBlur / RadarAcceptRange logic is unchanged, and the
---Doppler check runs once after all units have been collected.
---The optional parameters specify the detection methods that can be applied.
---If no detection method is given, the detection will use all the available methods by default.
---@param Unit? UNIT The unit detecting.
---@param DetectedUnits? table Table of detected units to be filled.
---@param RecceDetecting? table Table of recce per unit to be filled.
---@param DetectVisual? boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical? boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar? boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST? boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR? boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK? boolean (Optional) If *false*, do not include targets detected by data link.
---@param DetectedObjects? table (Optional) Table of native object IDs for the current sweep.
function INTEL:GetDetectedUnitsDoppler(Unit, DetectedUnits, RecceDetecting, DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK, DetectedObjects) end

---INTEL_DLINK class.
---@class INTEL_DLINK : FSM
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field verbose number Make the logging verbose.
---@field alias string Alias name for logging.
---@field cachetime number Number of seconds to keep an object.
---@field interval number Number of seconds between collection runs.
---@field contacts table Table of Ops.Intel#INTEL.Contact contacts.
---@field clusters table Table of Ops.Intel#INTEL.Cluster clusters.
---@field contactcoords table Table of contacts' Core.Point#COORDINATE objects.
INTEL_DLINK = {
  ClassName       = "INTEL_DLINK",
  verbose         =     0,
  lid             =   nil,
  alias           =   nil,
  cachetime       =   120,
  interval        =   20,
  contacts        =   {},
  clusters        =   {},
  contactcoords   =   {},
}

---Version string
INTEL_DLINK.version = "0.0.2"

---Function to instantiate a new object
---@param Intels? table Table of Ops.Intel#INTEL objects.
---@param Alias? string (optional) Name of this instance. Default "SPECTRE"
---@param Interval? number (optional) When to query #INTEL objects for detected items (default 20 seconds).
---@param Cachetime? number (optional) How long to cache detected items (default 300 seconds).
function INTEL_DLINK:New(Intels, Alias, Interval, Cachetime) end

---Function to add an #INTEL object to the aggregator
---@param Intel? INTEL the #INTEL object to add
---@return INTEL_DLINK # self
function INTEL_DLINK:AddIntel(Intel) end

---Function to start the work.
---@param From? string The From state
---@param Event? string The Event triggering this call
---@param To? string The To state
---@return INTEL_DLINK # self
function INTEL_DLINK:onafterStart(From, Event, To) end

---Function to set how long INTEL DLINK remembers contacts.
---@param seconds? number (Optional) Remember this many seconds. Defaults to 120.
---@return INTEL_DLINK # self
function INTEL_DLINK:SetDLinkCacheTime(seconds) end

---Function to collect data from the various #INTEL
---@param From? string The From state
---@param Event? string The Event triggering this call
---@param To? string The To state
---@return INTEL_DLINK # self
function INTEL_DLINK:onbeforeCollect(From, Event, To) end

---Function called after collection is done
---@param From? string The From state
---@param Event? string The Event triggering this call
---@param To? string The To state
---@param Contacts? table The table of collected #INTEL.Contact contacts
---@param Clusters? table The table of collected #INTEL.Cluster clusters
---@return INTEL_DLINK # self
function INTEL_DLINK:onbeforeCollected(From, Event, To, Contacts, Clusters) end

---Function to stop
---@param From? string The From state
---@param Event? string The Event triggering this call
---@param To? string The To state
---@return INTEL_DLINK # self
function INTEL_DLINK:onafterStop(From, Event, To) end

---Function to query the detected contacts
---@return table # Table of #INTEL.Contact contacts
function INTEL_DLINK:GetContactTable() end

---Function to query the detected clusters
---@return table # Table of #INTEL.Cluster clusters
function INTEL_DLINK:GetClusterTable() end

---Function to query the detected contact coordinates
---@return table # Table of the contacts' Core.Point#COORDINATE objects.
function INTEL_DLINK:GetDetectedItemCoordinates() end

---Triggers the FSM event "Start". Starts the INTEL. Initializes parameters and starts event handlers.
function INTEL:Start() end

---Triggers the FSM event "Start" after a delay. Starts the INTEL. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function INTEL:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the INTEL and all its event handlers.
---@param delay? number Delay in seconds.
function INTEL:__Stop(delay) end

---Triggers the FSM event "Status".
function INTEL:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function INTEL:__Status(delay) end

---Triggers the FSM event "NewContact".
---@param Contact? INTEL.Contact|number|string Detected contact.
function INTEL:NewContact(Contact) end

---Triggers the FSM event "NewContact" after a delay.
---@param delay? number Delay in seconds.
---@param Contact? INTEL.Contact|number|string Detected contact.
function INTEL:NewContact(delay, Contact) end

---On After "NewContact" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Contact? INTEL.Contact|number|string Detected contact.
function INTEL:OnAfterNewContact(From, Event, To, Contact) end

---Triggers the FSM event "LostContact".
---@param Contact? INTEL.Contact|number|string Lost contact.
function INTEL:LostContact(Contact) end

---Triggers the FSM event "LostContact" after a delay.
---@param delay? number Delay in seconds.
---@param Contact? INTEL.Contact|number|string Lost contact.
function INTEL:LostContact(delay, Contact) end

---On After "LostContact" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Contact? INTEL.Contact|number|string Lost contact.
function INTEL:OnAfterLostContact(From, Event, To, Contact) end

---Triggers the FSM event "NewCluster".
---@param Cluster? INTEL.Cluster|number|string Detected cluster.
function INTEL:NewCluster(Cluster) end

---Triggers the FSM event "NewCluster" after a delay.
---@param delay? number Delay in seconds.
---@param Cluster? INTEL.Cluster|number|string Detected cluster.
function INTEL:NewCluster(delay, Cluster) end

---On After "NewCluster" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Cluster? INTEL.Cluster|number|string Detected cluster.
function INTEL:OnAfterNewCluster(From, Event, To, Cluster) end

---Triggers the FSM event "LostCluster".
---@param Cluster? INTEL.Cluster|number|string Lost cluster.
---@param Mission? AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:LostCluster(Cluster, Mission) end

---Triggers the FSM event "LostCluster" after a delay.
---@param delay? number Delay in seconds.
---@param Cluster? INTEL.Cluster|number|string Lost cluster.
---@param Mission? AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:LostCluster(delay, Cluster, Mission) end

---On After "LostCluster" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Cluster? INTEL.Cluster|number|string Lost cluster.
---@param Mission? AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:OnAfterLostCluster(From, Event, To, Cluster, Mission) end

---Pseudo Functions
---
---Triggers the FSM event "Start". Starts the INTEL_DLINK.
function INTEL_DLINK:Start() end

---Triggers the FSM event "Start" after a delay. Starts the INTEL_DLINK.
---@param delay? number Delay in seconds.
function INTEL_DLINK:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the INTEL_DLINK.
---@param delay? number Delay in seconds.
function INTEL_DLINK:__Stop(delay) end

---Triggers the FSM event "Collect". Used internally to collect all data.
function INTEL_DLINK:Collect() end

---Triggers the FSM event "Collect" after a delay.
---@param delay? number Delay in seconds.
function INTEL_DLINK:__Status(delay) end

---On After "Collected" event. Data tables have been refreshed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Contacts? table Table of #INTEL.Contact Contacts.
---@param Clusters? table Table of #INTEL.Cluster Clusters.
function INTEL_DLINK:OnAfterCollected(From, Event, To, Contacts, Clusters) end
