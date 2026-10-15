---@meta

---@class AUFTRAG.GroupData
---@field opsgroup OPSGROUP The OPS group.
---@field waypointcoordinate COORDINATE Ingress waypoint coordinate.
---@field waypointindex number Mission (ingress) Waypoint UID.
---@field waypointEgressUID number Egress Waypoint UID.
---@field wpegresscoordinate COORDINATE Egress waypoint coordinate.
---@field waypointtask OPSGROUP.Task Waypoint task.
---@field status string Group mission status.
---@field asset WAREHOUSE.Assetitem The warehouse asset.

---@class AUFTRAG.Condition
---@field func function Callback function to check for a condition. Should return a #boolean.
---@field arg table Optional arguments passed to the condition callback function.

---@class AUFTRAG.Success
---@field SURVIVED string Group did survive.
---@field ENGAGED string Target was engaged.
---@field DAMAGED string Target was damaged.
---@field DESTROYED string Target was destroyed.

---@class AUFTRAG.Capability
---@field MissionType string Type of mission.
---@field Performance number Number describing the performance level. The higher the better.

---@class AUFTRAG.TargetData
---@field Target POSITIONABLE Target Object.
---@field Type string Target type: "Group", "Unit", "Static", "Coordinate", "Airbase", "SetGroup", "SetUnit".
---@field Name string Target name.
---@field Ninital number Number of initial targets.
---@field Lifepoints number Total life points.
---@field Lifepoints0 number Inital life points.

---AUFTRAG class.
---@class AUFTRAG : FSM
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field auftragsnummer number Auftragsnummer.
---@field type string Mission type.
---@field categories table Mission categories.
---@field status string Mission status.
---@field legions table Assigned legions.
---@field statusLegion table Mission status of all assigned LEGIONs.
---@field statusCommander string Mission status of the COMMANDER.
---@field statusChief string Mission status of the CHIEF.
---@field groupdata table Group specific data.
---@field name string Mission name.
---@field prio number Mission priority.
---@field urgent boolean Mission is urgent. Running missions with lower prio might be cancelled.
---@field importance number Importance.
---@field Tstart number Mission start time in abs. seconds.
---@field Tstop number Mission stop time in abs. seconds.
---@field duration number Mission duration in seconds.
---@field durationExe number Mission execution time in seconds.
---@field Texecuting number Time stamp (abs) when mission is executing. Is `#nil` on start.
---@field Tpush number Mission push/execute time in abs. seconds.
---@field Tstarted number Time stamp (abs) when mission is started.
---@field marker MARKER F10 map marker.
---@field markerOn boolean If true, display marker on F10 map with the AUFTRAG status.
---@field markerCoaliton number Coalition to which the marker is dispayed.
---@field DCStask table DCS task structure.
---@field Ncasualties number Number of own casualties during mission.
---@field Nkills number Number of (enemy) units killed by assets of this mission.
---@field Ndead number Number of assigned groups that are dead.
---@field Nassigned number Number of assigned groups.
---@field Nelements number Number of elements (units) assigned to mission.
---@field dTevaluate number Time interval in seconds before the mission result is evaluated after mission is over.
---@field Tover number Mission abs. time stamp, when mission was over.
---@field updateDCSTask boolean If `true`, DCS task is updated at every status update of the assigned groups.
---@field conditionStart table Condition(s) that have to be true, before the mission will be started.
---@field conditionSuccess table If all conditions are true, the mission is cancelled.
---@field conditionFailure table If all conditions are true, the mission is cancelled.
---@field conditionPush table If all conditions are true, the mission is executed. Before, the group(s) wait at the mission execution waypoint.
---@field conditionSuccessSet boolean
---@field conditionFailureSet boolean
---@field orbitSpeed number Orbit speed in m/s.
---@field orbitAltitude number Orbit altitude in meters.
---@field orbitHeading number Orbit heading in degrees.
---@field orbitLeg number Length of orbit leg in meters.
---@field orbitOffsetVec2 Vec2 2D offset vector.
---@field orbitVec2 Vec2 2D orbit vector.
---@field orbitDeltaR number Distance threshold in meters for moving orbit targets.
---@field engageTarget TARGET Target data to engage.
---@field targetHeading number Heading of target in degrees.
---@field operation OPERATION Operation this mission is part of.
---@field teleport boolean Groups are teleported to the mission ingress waypoint.
---@field engageZone ZONE_RADIUS *Circular* engagement zone.
---@field engageTargetTypes table Table of target types that are engaged in the engagement zone.
---@field engageAltitude number Engagement altitude in meters.
---@field engageDirection number Engagement direction in degrees.
---@field engageQuantity number Number of times a target is engaged.
---@field engageWeaponType number Weapon type used.
---@field engageWeaponExpend number How many weapons are used.
---@field engageAsGroup boolean Group attack.
---@field engageLength number Length of engage (carpet or strafing) in meters.
---@field engageMaxDistance number Max engage distance.
---@field refuelSystem number Refuel type (boom or probe) for TANKER missions.
---@field escortGroup GROUP The group to be escorted.
---@field escortGroupName string Name of the escorted group.
---@field escortVec3 Vec3 The 3D offset vector from the escorted group to the escort group.
---@field facDesignation number FAC designation type.
---@field facDatalink boolean FAC datalink enabled.
---@field facFreq number FAC radio frequency in MHz.
---@field facModu number FAC radio modulation 0=AM 1=FM.
---@field transportGroupSet SET_GROUP Groups to be transported.
---@field transportPickup COORDINATE Coordinate where to pickup the cargo.
---@field transportDropoff COORDINATE Coordinate where to drop off the cargo.
---@field transportPickupRadius number Radius in meters for pickup zone. Default 500 m.
---@field opstransport OPSTRANSPORT OPS transport assignment.
---@field NcarriersMin number Min number of required carrier assets.
---@field NcarriersMax number Max number of required carrier assets.
---@field transportDeployZone ZONE Deploy zone of an OPSTRANSPORT.
---@field transportDisembarkZone ZONE Disembark zone of an OPSTRANSPORT.
---@field carrierAttributes table Generalized attribute(s) of transport assets.
---@field carrierProperties table DCS attribute(s) of transport assets.
---@field artyRadius number Radius in meters.
---@field artyShots number Number of shots fired.
---@field artyAltitude number Altitude in meters. Can be used for a Barrage.
---@field artyHeading number Heading in degrees (for Barrage).
---@field artyAngle number Shooting angle in degrees (for Barrage).
---@field alert5MissionType string Alert 5 mission type. This is the mission type, the alerted assets will be able to carry out.
---@field attributes table Generalized attribute(s) of assets.
---@field properties table DCS attribute(s) of assets.
---@field chief CHIEF The CHIEF managing this mission.
---@field commander COMMANDER The COMMANDER managing this mission.
---@field assets table Warehouse assets assigned for this mission.
---@field NassetsMin number Min. number of required warehouse assets.
---@field NassetsMax number Max. number of required warehouse assets.
---@field NescortMin number Min. number of required escort assets for each group the mission is assigned to.
---@field NescortMax number Max. number of required escort assets for each group the mission is assigned to.
---@field escortMissionType string Escort mission type.
---@field escortTargetTypes table Target types that will be engaged.
---@field escortEngageRange number Engage range in nautical miles (NM).
---@field Nassets number Number of requested warehouse assets.
---@field NassetsLegMin table Number of required warehouse assets for each assigned legion.
---@field NassetsLegMax table Number of required warehouse assets for each assigned legion.
---@field requestID table The ID of the queued warehouse request. Necessary to cancel the request if the mission was cancelled before the request is processed.
---@field payloads table User specified airwing payloads for this mission. Only these will be considered for the job!
---@field patroldata AIRWING.PatrolData Patrol data.
---@field specialLegions table User specified legions assigned for this mission. Only these will be considered for the job!
---@field specialCohorts table User specified cohorts assigned for this mission. Only these will be considered for the job!
---@field transportLegions table Legions explicitly requested for providing transport carrier assets.
---@field transportCohorts table Cohorts explicitly requested for providing transport carrier assets.
---@field escortLegions table Legions explicitly requested for providing escorting assets.
---@field escortCohorts table Cohorts explicitly requested for providing escorting assets.
---@field missionTask string Mission task. See `ENUMS.MissionTask`.
---@field missionAltitude number Mission altitude in meters.
---@field missionSpeed number Mission speed in km/h.
---@field missionFraction number Mission coordiante fraction. Default is 0.5.
---@field missionRange number Mission range in meters. Used by LEGION classes (AIRWING, BRIGADE, ...).
---@field missionWaypointCoord COORDINATE Mission waypoint coordinate.
---@field missionEgressCoord COORDINATE Mission egress waypoint coordinate.
---@field missionIngressCoord COORDINATE Mission Ingress waypoint coordinate.
---@field missionWaypointRadius number Random radius in meters.
---@field legionReturn boolean If `true`, assets return to their legion (default). If `false`, they will stay alive.
---@field enrouteTasks table Mission enroute tasks.
---@field repeated number Number of times mission was repeated.
---@field repeatedSuccess number Number of times mission was repeated after a success.
---@field repeatedFailure number Number of times mission was repeated after a failure.
---@field Nrepeat number Number of times the mission is repeated.
---@field NrepeatFailure number Number of times mission is repeated if failed.
---@field NrepeatSuccess number Number of times mission is repeated if successful.
---@field radio OPSGROUP.Radio Radio freq and modulation.
---@field tacan OPSGROUP.Beacon TACAN setting.
---@field icls OPSGROUP.Beacon ICLS setting.
---@field optionROE number ROE.
---@field optionROT number ROT.
---@field optionAlarm number Alarm state.
---@field optionFormation number Formation.
---@field optionEPLRS boolean EPLRS datalink.
---@field optionCM number Counter measures.
---@field optionRTBammo number RTB on out-of-ammo.
---@field optionRTBfuel number RTB on out-of-fuel.
---@field optionECM number ECM.
---@field optionEmission boolean Emission is on or off.
---@field optionInvisible boolean Invisible is on/off.
---@field optionImmortal boolean Immortal is on/off.
AUFTRAG = {
  ClassName          = "AUFTRAG",
  verbose            =     0,
  lid                =   nil,
  auftragsnummer     =   nil,
  groupdata          =    {},
  legions            =    {},
  statusLegion       =    {},
  requestID          =    {},
  assets             =    {},
  NassetsLegMin      =    {},
  NassetsLegMax      =    {},
  missionFraction    =   0.5,
  enrouteTasks       =    {},
  marker             =   nil,
  markerOn           =   nil,
  markerCoalition    =   nil,
  conditionStart     =    {},
  conditionSuccess   =    {},
  conditionFailure   =    {},
  conditionPush      =    {},
  conditionSuccessSet = false,
  conditionFailureSet = false,
  repeatDelay = 1,
}

---Mission types.
---@class AUFTRAG.Type
---@field ANTISHIP string Anti-ship mission.
---@field AWACS string AWACS mission.
---@field BAI string Battlefield Air Interdiction.
---@field BOMBING string Bombing mission.
---@field BOMBRUNWAY string Bomb runway of an airbase.
---@field BOMBCARPET string Carpet bombing.
---@field CAP string Combat Air Patrol.
---@field CAS string Close Air Support.
---@field ESCORT string Escort mission.
---@field FAC string Forward AirController mission.
---@field FACA string Forward AirController airborne mission.
---@field FERRY string Ferry mission.
---@field GROUNDESCORT string Ground escort mission.
---@field INTERCEPT string Intercept mission.
---@field ORBIT string Orbit mission.
---@field GCICAP string Similar to CAP but no auto engage targets.
---@field RECON string Recon mission.
---@field RECOVERYTANKER string Recovery tanker mission. Not implemented yet.
---@field RESCUEHELO string Rescue helo.
---@field SEAD string Suppression/destruction of enemy air defences.
---@field STRIKE string Strike mission.
---@field TANKER string Tanker mission.
---@field TROOPTRANSPORT string Troop transport mission.
---@field ARTY string Fire at point.
---@field PATROLZONE string Patrol a zone.
---@field OPSTRANSPORT string Ops transport.
---@field AMMOSUPPLY string Ammo supply.
---@field FUELSUPPLY string Fuel supply.
---@field ALERT5 string Alert 5.
---@field ONGUARD string On guard.
---@field ARMOREDGUARD string On guard - with armored groups.
---@field BARRAGE string Barrage.
---@field ARMORATTACK string Armor attack.
---@field CASENHANCED string Enhanced CAS.
---@field HOVER string Hover.
---@field LANDATCOORDINATE string Land at coordinate.
---@field GROUNDATTACK string Ground attack.
---@field NAVALENGAGEMENT string Naval engagement (similar to GROUNDATTACK).
---@field CARGOTRANSPORT string Cargo transport.
---@field RELOCATECOHORT string Relocate a cohort from one legion to another.
---@field AIRDEFENSE string Air defense.
---@field EWR string Early Warning Radar.
---@field RECOVERYTANKER string Recovery tanker.
---@field REARMING string Rearming mission.
---@field CAPTUREZONE string Capture zone mission.
---@field NOTHING string Nothing.
---@field PATROLRACETRACK string Patrol Racetrack.
---@field STRAFING string Strafing run.
---@field FREIGHTTRANSPORT string Freight transport.
AUFTRAG.Type={
  ANTISHIP="Anti Ship",
  AWACS="AWACS",
  BAI="BAI",
  BOMBING="Bombing",
  BOMBRUNWAY="Bomb Runway",
  BOMBCARPET="Carpet Bombing",
  CAP="CAP",
  CAS="CAS",
  ESCORT="Escort",
  FAC="FAC",
  FACA="FAC-A",
  FERRY="Ferry Flight",
  GROUNDESCORT="Ground Escort",
  INTERCEPT="Intercept",
  ORBIT="Orbit",
  GCICAP="Ground Controlled CAP",
  RECON="Recon",
  RECOVERYTANKER="Recovery Tanker",
  RESCUEHELO="Rescue Helo",
  SEAD="SEAD",
  STRIKE="Strike",
  TANKER="Tanker",
  TROOPTRANSPORT="Troop Transport",
  ARTY="Fire At Point",
  PATROLZONE="Patrol Zone",
  OPSTRANSPORT="Ops Transport",
  AMMOSUPPLY="Ammo Supply",
  FUELSUPPLY="Fuel Supply",
  ALERT5="Alert5",
  ONGUARD="On Guard",
  ARMOREDGUARD="Armored Guard",
  BARRAGE="Barrage",
  ARMORATTACK="Armor Attack",
  CASENHANCED="CAS Enhanced",
  HOVER="Hover",
  LANDATCOORDINATE="Land at Coordinate",
  GROUNDATTACK="Ground Attack",
  NAVALENGAGEMENT="Naval Engagement",
  CARGOTRANSPORT="Cargo Transport",
  RELOCATECOHORT="Relocate Cohort",
  AIRDEFENSE="Air Defence",
  EWR="Early Warning Radar",
  REARMING="Rearming",
  CAPTUREZONE="Capture Zone",
  NOTHING="Nothing",
  PATROLRACETRACK="Patrol Racetrack",
  STRAFING="Strafing",
  FREIGHTTRANSPORT="FREIGHTTRANSPORT",
}

---Special task description.
---@class AUFTRAG.SpecialTask
---@field FORMATION string AI formation task.
---@field PATROLZONE string Patrol zone task.
---@field RECON string Recon task.
---@field AMMOSUPPLY string Ammo Supply.
---@field FUELSUPPLY string Fuel Supply.
---@field ALERT5 string Alert 5 task.
---@field ONGUARD string On guard.
---@field ARMOREDGUARD string On guard with armor.
---@field BARRAGE string Barrage.
---@field HOVER string Hover.
---@field GROUNDATTACK string Ground attack.
---@field NAVALENGAGEMENT string Naval engagement.
---@field FERRY string Ferry mission.
---@field RELOCATECOHORT string Relocate cohort.
---@field AIRDEFENSE string Air defense.
---@field EWR string Early Warning Radar.
---@field RECOVERYTANKER string Recovery tanker.
---@field REARMING string Rearming.
---@field CAPTUREZONE string Capture OPS zone.
---@field NOTHING string Nothing.
---@field PATROLRACETRACK string Patrol Racetrack.
AUFTRAG.SpecialTask={
  FORMATION="Formation",
  PATROLZONE="PatrolZone",
  RECON="ReconMission",
  AMMOSUPPLY="Ammo Supply",
  FUELSUPPLY="Fuel Supply",
  ALERT5="Alert5",
  ONGUARD="On Guard",
  ARMOREDGUARD="ArmoredGuard",
  BARRAGE="Barrage",
  ARMORATTACK="AmorAttack",
  HOVER="Hover",
  GROUNDATTACK="Ground Attack",
  NAVALENGAGEMENT="Naval Engagement",
  FERRY="Ferry",
  RELOCATECOHORT="Relocate Cohort",
  AIRDEFENSE="Air Defense",
  EWR="Early Warning Radar",
  RECOVERYTANKER="Recovery Tanker",
  REARMING="Rearming",
  CAPTUREZONE="Capture Zone",  
  NOTHING="Nothing",
  PATROLRACETRACK="Patrol Racetrack",
}

---Mission status.
---@class AUFTRAG.Status
---@field PLANNED string Mission is at the early planning stage and has not been added to any queue.
---@field QUEUED string Mission is queued at a LEGION.
---@field REQUESTED string Mission assets were requested from the warehouse.
---@field SCHEDULED string Mission is scheduled in an OPSGROUP queue waiting to be started.
---@field STARTED string Mission has started but is not executed yet.
---@field EXECUTING string Mission is being executed.
---@field DONE string Mission is over.
---@field CANCELLED string Mission was cancelled.
---@field SUCCESS string Mission was a success.
---@field FAILED string Mission failed.
AUFTRAG.Status={
  PLANNED="planned",
  QUEUED="queued",
  REQUESTED="requested",
  SCHEDULED="scheduled",
  STARTED="started",
  EXECUTING="executing",
  DONE="done",
  CANCELLED="cancelled",
  SUCCESS="success",
  FAILED="failed",
}

---Mission status of an assigned group.
---@class AUFTRAG.GroupStatus
---@field SCHEDULED string Mission is scheduled in a FLIGHGROUP queue waiting to be started.
---@field STARTED string Ops group started this mission but it is not executed yet.
---@field EXECUTING string Ops group is executing this mission.
---@field PAUSED string Ops group has paused this mission, e.g. for refuelling.
---@field DONE string Mission task of the Ops group is done.
---@field CANCELLED string Mission was cancelled.
AUFTRAG.GroupStatus={
  SCHEDULED="scheduled",
  STARTED="started",
  EXECUTING="executing",
  PAUSED="paused",
  DONE="done",
  CANCELLED="cancelled",
}

---Target type.
---@class AUFTRAG.TargetType
---@field GROUP string Target is a GROUP object.
---@field UNIT string Target is a UNIT object.
---@field STATIC string Target is a STATIC object.
---@field COORDINATE string Target is a COORDINATE.
---@field AIRBASE string Target is an AIRBASE.
---@field SETGROUP string Target is a SET of GROUPs.
---@field SETUNIT string Target is a SET of UNITs.
AUFTRAG.TargetType={
  GROUP="Group",
  UNIT="Unit",
  STATIC="Static",
  COORDINATE="Coordinate",
  AIRBASE="Airbase",
  SETGROUP="SetGroup",
  SETUNIT="SetUnit",
}

---Mission category.
---@class AUFTRAG.Category
---@field AIRCRAFT string Airplanes and helicopters.
---@field AIRPLANE string Airplanes.
---@field HELICOPTER string Helicopter.
---@field GROUND string Ground troops.
---@field NAVAL string Naval grous.
AUFTRAG.Category={
  ALL="All",
  AIRCRAFT="Aircraft",
  AIRPLANE="Airplane",
  HELICOPTER="Helicopter",
  GROUND="Ground",
  NAVAL="Naval",
}

---AUFTRAG class version.
AUFTRAG.version = "1.4.2"

---Create a new generic AUFTRAG object.
---@param Type? string Mission type.
---@return AUFTRAG # self
function AUFTRAG:New(Type) end

---**[AIR]** Create an ANTI-SHIP mission.
---@param Target? POSITIONABLE The target to attack. Can be passed as a @{Wrapper.Group#GROUP} or @{Wrapper.Unit#UNIT} object.
---@param Altitude? number (Optional) Engage altitude in feet. Default 2000 ft.
---@return AUFTRAG # self
function AUFTRAG:NewANTISHIP(Target, Altitude) end

---**[AIR ROTARY]** Create an HOVER mission.
---@param Coordinate? COORDINATE Where to hover.
---@param Altitude? number (Optional) Hover altitude in feet AGL. Default is 50 feet above ground.
---@param Time? number (Optional) Time in seconds to hold the hover. Default 300 seconds.
---@param Speed? number (Optional) Speed in knots to fly to the target coordinate. Default 150kn.
---@param MissionAlt? number (Optional) Altitude to fly towards the mission in feet AGL. Default 1000ft.
---@return AUFTRAG # self
function AUFTRAG:NewHOVER(Coordinate, Altitude, Time, Speed, MissionAlt) end

---**[AIR ROTARY]** Create an LANDATCOORDINATE mission.
---@param Coordinate? COORDINATE Where to land.
---@param OuterRadius? number (Optional) Vary the coordinate by this many feet, e.g. get a new random coordinate between OuterRadius and (optionally) avoiding InnerRadius of the coordinate.
---@param InnerRadius? number (Optional) Vary the coordinate by this many feet, e.g. get a new random coordinate between OuterRadius and (optionally) avoiding InnerRadius of the coordinate.
---@param Time? number (Optional) Time in seconds to stay. Default 300 seconds.
---@param Speed? number (Optional) Speed in knots to fly to the target coordinate. Default 150kn.
---@param MissionAlt? number A(Optional) ltitude to fly towards the mission in feet AGL. Default 1000ft.
---@param CombatLanding? boolean (Optional) If true, set the Combat Landing option.
---@param DirectionAfterLand? number (Optional) Heading after landing in degrees.
---@return AUFTRAG # self
function AUFTRAG:NewLANDATCOORDINATE(Coordinate, OuterRadius, InnerRadius, Time, Speed, MissionAlt, CombatLanding, DirectionAfterLand) end

---**[AIR]** Create an enhanced orbit race track mission. Planes will keep closer to the track.
---@param Coordinate? COORDINATE Where to start the race track.
---@param Altitude? number (Optional) Altitude in feet. Defaults to 20,000ft ASL.
---@param Speed? number (Optional) Speed in knots. Defaults to 300kn TAS.
---@param Heading? number (Optional) Heading in degrees, 0 to 360. Defaults to 90 degree (East).
---@param Leg? number (Optional) Leg of the race track in NM. Defaults to 10nm.
---@param Formation? number (Optional) Formation to take, e.g. ENUMS.Formation.FixedWing.Trail.Close, also see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_option_formation).
---@return AUFTRAG # self
function AUFTRAG:NewPATROL_RACETRACK(Coordinate, Altitude, Speed, Heading, Leg, Formation) end

---**[AIR]** Create an ORBIT mission, which can be either a circular orbit or a race-track pattern.
---@param Coordinate? COORDINATE Where to orbit.
---@param Altitude? number (Optional) Orbit altitude in feet above sea level. Default is y component of `Coordinate`.
---@param Speed? number (Optional) Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. If not specified, a circular orbit is performed.
---@param Leg? number (Optional) Length of race-track in NM. If not specified, a circular orbit is performed.
---@return AUFTRAG # self
function AUFTRAG:NewORBIT(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIR]** Create an ORBIT mission, where the aircraft will go in a circle around the specified coordinate.
---@param Coordinate? COORDINATE Position where to orbit around.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed? number (Optional) Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@return AUFTRAG # self
function AUFTRAG:NewORBIT_CIRCLE(Coordinate, Altitude, Speed) end

---**[AIR]** Create an ORBIT mission, where the aircraft will fly a race-track pattern.
---@param Coordinate? COORDINATE Where to orbit.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed? number (Optional) Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default random in [0, 360) degrees.
---@param Leg? number (Optional) Length of race-track in NM. Default 10 NM.
---@return AUFTRAG # self
function AUFTRAG:NewORBIT_RACETRACK(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIR]** Create an ORBIT mission, where the aircraft will fly a circular or race-track pattern over a given group or unit.
---@param Group? GROUP Group where to orbit around. Can also be a UNIT object.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 6,000 ft.
---@param Speed? number (Optional) Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Leg? number (Optional) Length of race-track in NM. Default nil.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default is heading of the group.
---@param OffsetVec2? Vec2 (Optional) Offset 2D-vector {x=0, y=0} in NM with respect to the group. Default directly overhead. Can also be given in polar coordinates `{r=5, phi=45}`.
---@param Distance? number (Optional) Threshold distance in NM before orbit pattern is updated. Default 5 NM.
---@return AUFTRAG # self
function AUFTRAG:NewORBIT_GROUP(Group, Altitude, Speed, Leg, Heading, OffsetVec2, Distance) end

---**[AIR]** Create a Ground Controlled CAP (GCICAP) mission. Flights with this task are considered for A2A INTERCEPT missions by the CHIEF class. They will perform a combat air patrol but not engage by
---themselfs. They wait for the CHIEF to tell them whom to engage.
---@param Coordinate? COORDINATE Where to orbit.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed? number (Optional) Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default random in [0, 360) degrees.
---@param Leg? number (Optional) Length of race-track in NM. Default 10 NM.
---@return AUFTRAG # self
function AUFTRAG:NewGCICAP(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIR]** Create a TANKER mission.
---@param Coordinate? COORDINATE Where to orbit.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed? number (Optional) Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 10 NM. Set to 0 for a simple circular orbit.
---@param RefuelSystem? number Refueling system (0=boom, 1=probe). This info is *only* for AIRWINGs so they launch the right tanker type.
---@return AUFTRAG # self
function AUFTRAG:NewTANKER(Coordinate, Altitude, Speed, Heading, Leg, RefuelSystem) end

---**[AIR]** Create a AWACS mission.
---@param Coordinate? COORDINATE Where to orbit. Altitude is also taken from the coordinate. Can also be a UNIT object, *e.g.* a carrier.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed? number (Optional) Orbit speed in knots. Default 350 kts.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg? number (Optional) Length of race-track in NM. Default 10 NM.
---@return AUFTRAG # self
function AUFTRAG:NewAWACS(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIRPANE]** Create a RECOVERY TANKER mission.
---@param Carrier? UNIT The carrier unit.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 6,000 ft.
---@param Speed? number (Optional) Orbit speed in knots. Default 250 KIAS.
---@param Leg? number (Optional) Length of race-track in NM. Default 14 NM.
---@param RelHeading? number (Optional) Relative heading [0, 360) of race-track pattern in degrees wrt heading of the carrier. Default is heading of the carrier.
---@param OffsetDist? number (Optional) Relative distance of the first race-track point wrt to the carrier. Default 6 NM.
---@param OffsetAngle? number (Optional) Relative angle of the first race-track point wrt. to the carrier. Default 180 (behind the boat).
---@param UpdateDistance? number (Optional) Threshold distance in NM before orbit pattern is updated. Default 5 NM.
---@return AUFTRAG # self
function AUFTRAG:NewRECOVERYTANKER(Carrier, Altitude, Speed, Leg, RelHeading, OffsetDist, OffsetAngle, UpdateDistance) end

---**[AIR]** Create an INTERCEPT mission.
---@param Target? POSITIONABLE The target to intercept. Can also be passed as simple @{Wrapper.Group#GROUP} or @{Wrapper.Unit#UNIT} object.
---@return AUFTRAG # self
function AUFTRAG:NewINTERCEPT(Target) end

---**[AIR]** Create a CAP mission.
---@param ZoneCAP? ZONE_RADIUS Circular CAP zone. Detected targets in this zone will be engaged.
---@param Altitude? number (Optional) Altitude at which to orbit in feet. Default is 10,000 ft.
---@param Speed? number (Optional) Orbit speed in knots. Default 350 kts.
---@param Coordinate? COORDINATE (Optional) Where to orbit. Default is the center of the CAP zone.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. If not specified, a simple circular orbit is performed.
---@param Leg? number (Optional) Length of race-track in NM. If not specified, a simple circular orbit is performed.
---@param TargetTypes? table (Optional) Table of target types. Default {"Air"}.
---@return AUFTRAG # self
function AUFTRAG:NewCAP(ZoneCAP, Altitude, Speed, Coordinate, Heading, Leg, TargetTypes) end

---**[AIR]** Create a CAP mission over a (moving) group.
---@param Grp? GROUP The grp to perform the CAP over.
---@param Altitude? number (Optional) Orbit altitude in feet. Default is 6,000 ft.
---@param Speed? number (Optional) Orbit speed in knots. Default 250 KIAS.
---@param RelHeading? number (Optional) Relative heading [0, 360) of race-track pattern in degrees wrt heading of the carrier. Default is heading of the carrier.
---@param Leg? number (Optional) Length of race-track in NM. Default 14 NM.
---@param OffsetDist? number (Optional) Relative distance of the first race-track point wrt to the carrier. Default 6 NM.
---@param OffsetAngle? number (Optional) Relative angle of the first race-track point wrt. to the carrier. Default 180 (behind the boat).
---@param UpdateDistance? number (Optional) Threshold distance in NM before orbit pattern is updated. Default 5 NM.
---@param TargetTypes? table (Optional) Table of target types. Default `{"Air"}`.
---@param EngageRange? number (Optional) Max range in nautical miles that the escort group(s) will engage enemies. Default 32 NM (60 km).
---@return AUFTRAG # self
function AUFTRAG:NewCAPGROUP(Grp, Altitude, Speed, RelHeading, Leg, OffsetDist, OffsetAngle, UpdateDistance, TargetTypes, EngageRange) end

---**[AIR]** Create a CAS mission.
---@param ZoneCAS? ZONE_RADIUS Circular CAS zone. Detected targets in this zone will be engaged.
---@param Altitude? number (Optional) Altitude at which to orbit. Default is 10,000 ft.
---@param Speed? number (Optional) Orbit speed in knots. Default 350 KIAS.
---@param Coordinate? COORDINATE (Optional) Where to orbit. Default is the center of the CAS zone.
---@param Heading? number (Optional) Heading of race-track pattern in degrees. If not specified, a simple circular orbit is performed.
---@param Leg? number (Optional) Length of race-track in NM. If not specified, a simple circular orbit is performed.
---@param TargetTypes? table (Optional) Table of target types. Default `{"Helicopters", "Ground Units", "Light armed ships"}`.
---@return AUFTRAG # self
function AUFTRAG:NewCAS(ZoneCAS, Altitude, Speed, Coordinate, Heading, Leg, TargetTypes) end

---**[AIR]** Create a CASENHANCED mission. Group(s) will go to the zone and patrol it randomly.
---@param CasZone? ZONE The CAS zone.
---@param Altitude? number (Optional) Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Speed? number (Optional) Speed in knots.
---@param RangeMax? number (Optional) Max range in NM. Only detected targets within this radius from the group will be engaged. Default is 25 NM.
---@param NoEngageZoneSet? SET_ZONE (Optional) Set of zones in which targets are *not* engaged. Default is nowhere.
---@param TargetTypes? table (Optional) Types of target attributes that will be engaged. See [DCS enum attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). Default `{"Helicopters", "Ground Units", "Light armed ships"}`.
---@return AUFTRAG # self
function AUFTRAG:NewCASENHANCED(CasZone, Altitude, Speed, RangeMax, NoEngageZoneSet, TargetTypes) end

---**[AIR, GROUND]** Create a FAC mission. Group(s) will go to the zone and patrol it randomly and act as FAC for detected units.
---@param FacZone? ZONE The FAC zone (or name of zone) where to patrol.
---@param Speed? number (Optional) Speed in knots.
---@param Altitude? number (Optional) Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Frequency? number (Optional) Frequency in MHz. Defaults to 133Mhz.
---@param Modulation? number (Optional) Modulation. Defaults to radio.modulation.AM
function AUFTRAG:NewFAC(FacZone, Speed, Altitude, Frequency, Modulation) end

---**[AIR]** Create a FACA mission.
---@param Target? GROUP Target group. Must be a GROUP object.
---@param Designation? string (Optional) Designation of target. See `AI.Task.Designation`. Default `AI.Task.Designation.AUTO`.
---@param DataLink? boolean (Optional) Enable data link. Default `true`.
---@param Frequency? number (Optional) Radio frequency in MHz the FAC uses for communication. Default is 133 MHz.
---@param Modulation? number (Optional) Radio modulation band. Default 0=AM. Use 1 for FM. See radio.modulation.AM or radio.modulaton.FM.
---@return AUFTRAG # self
function AUFTRAG:NewFACA(Target, Designation, DataLink, Frequency, Modulation) end

---**[AIR]** Create a BAI mission.
---@param Target? POSITIONABLE The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Altitude? number (Optional) Engage altitude in feet. Default 5000 ft.
---@return AUFTRAG # self
function AUFTRAG:NewBAI(Target, Altitude) end

---**[AIR]** Create a SEAD mission.
---@param Target? POSITIONABLE The target to attack. Can be a GROUP or UNIT object.
---@param Altitude? number (Optional) Engage altitude in feet. Default 25000 ft.
---@return AUFTRAG # self
function AUFTRAG:NewSEAD(Target, Altitude) end

---**[AIR]** Create a SEAD in Zone mission.
---@param TargetZone? ZONE The target zone to attack.
---@param Altitude? number (Optional) Engage altitude in feet. Default 25000 ft.
---@param TargetTypes? table (Optional) Table of string of DCS known target types, defaults to {"Air Defence"}. See [DCS Target Attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes)
---@param Duration? number (Optional) Engage this much time when the AUFTRAG starts executing. Default is 1800.
---@return AUFTRAG # self
function AUFTRAG:NewSEADInZone(TargetZone, Altitude, TargetTypes, Duration) end

---**[AIR]** Create a STRIKE mission. Flight will attack the closest map object to the specified coordinate.
---@param Target? COORDINATE The target coordinate. Can also be given as a GROUP, UNIT, STATIC, SET_GROUP, SET_UNIT, SET_STATIC or TARGET object.
---@param Altitude? number (Optional) Engage altitude in feet. Default 2000 ft.
---@param EngageWeaponType? number (Optional) Which weapon to use. Defaults to auto, ie ENUMS.WeaponFlag.Auto. See ENUMS.WeaponFlag for options.
---@return AUFTRAG # self
function AUFTRAG:NewSTRIKE(Target, Altitude, EngageWeaponType) end

---**[AIR]** Create a BOMBING mission. Flight will drop bombs a specified coordinate.
---See [DCS task bombing](https://wiki.hoggitworld.com/view/DCS_task_bombing).
---@param Target? COORDINATE Target coordinate. Can also be specified as a GROUP, UNIT, STATIC, SET_GROUP, SET_UNIT, SET_STATIC or TARGET object.
---@param Altitude? number Engage (Optional) altitude in feet. Default 25000 ft.
---@param EngageWeaponType? number (Optional) Which weapon to use. Defaults to auto, ie ENUMS.WeaponFlag.Auto. See ENUMS.WeaponFlag for options.
---@param Divebomb? boolean (Optional) If true, use a dive bombing attack approach.
---@return AUFTRAG # self
function AUFTRAG:NewBOMBING(Target, Altitude, EngageWeaponType, Divebomb) end

---**[AIR]** Create a STRAFING mission. Assigns a point on the ground for which the AI will do a strafing run with guns or rockets.
---See [DCS task strafing](https://wiki.hoggitworld.com/view/DCS_task_strafing).
---@param Target? COORDINATE Target coordinate. Can also be specified as a GROUP, UNIT, STATIC or TARGET object.
---@param Altitude? number (Optional) Engage altitude in feet. Default 1000 ft.
---@param Length? number (Optional) The total length of the strafing target in meters. Default `nil`.
---@return AUFTRAG # self
function AUFTRAG:NewSTRAFING(Target, Altitude, Length) end

---**[AIR]** Create a BOMBRUNWAY mission.
---@param Airdrome? AIRBASE The airbase to bomb. This must be an airdrome (not a FARP or ship) as these do not have a runway.
---@param Altitude? number (Optional) Engage altitude in feet. Default 25000 ft.
---@return AUFTRAG # self
function AUFTRAG:NewBOMBRUNWAY(Airdrome, Altitude) end

---**[AIR]** Create a CARPET BOMBING mission.
---@param Target? COORDINATE Target coordinate. Can also be specified as a GROUP, UNIT or STATIC object.
---@param Altitude? number (Optional) Engage altitude in feet. Default 25000 ft.
---@param CarpetLength? number (Optional) Length of bombing carpet in meters. Default 500 m.
---@return AUFTRAG # self
function AUFTRAG:NewBOMBCARPET(Target, Altitude, CarpetLength) end

---**[AIR/HELO]** Create a GROUNDESCORT (or FOLLOW) mission. Helo will escort a **ground** group and automatically engage certain target types.
---@param EscortGroup? GROUP The ground group to escort.
---@param OrbitDistance? number (Optional)  Orbit to/from the lead unit this many NM. Defaults to 1.5 NM.
---@param TargetTypes? table (Optional) Types of targets to engage automatically. Default is {"Ground vehicles"}, i.e. all enemy ground units. Use an empty set {} for a simple "FOLLOW" mission.
---@return AUFTRAG # self
function AUFTRAG:NewGROUNDESCORT(EscortGroup, OrbitDistance, TargetTypes) end

---**[AIR]** Create an ESCORT (or FOLLOW) mission. Flight will escort another group and automatically engage certain target types.
---@param EscortGroup? GROUP The group to escort.
---@param OffsetVector? Vec3 (Optional) A table with x, y and z components specifying the offset of the flight to the escorted group. Default {x=-100, y=0, z=200} for z=200 meters to the right, same alitude (y=0), x=-100 meters behind.
---@param EngageMaxDistance? number (Optional) Max engage distance of targets in nautical miles. Default auto 32 NM.
---@param TargetTypes? table (Optional) Types of targets to engage automatically. Default is {"Air"}, i.e. all enemy airborne units. Use an empty set {} for a simple "FOLLOW" mission.
---@return AUFTRAG # self
function AUFTRAG:NewESCORT(EscortGroup, OffsetVector, EngageMaxDistance, TargetTypes) end

---**[AIR ROTARY]** Create a RESCUE HELO mission.
---@param Carrier? UNIT The carrier unit.
---@return AUFTRAG # self
function AUFTRAG:NewRESCUEHELO(Carrier) end

---**[AIR ROTARY, GROUND]** Create a TROOP TRANSPORT mission.
---@param TransportGroupSet? SET_GROUP The set group(s) to be transported.
---@param DropoffCoordinate? COORDINATE Coordinate where the helo will land drop off the the troops.
---@param PickupCoordinate? COORDINATE (Optional)  Coordinate where the helo will land to pick up the the cargo. Default is the first transport group.
---@param PickupRadius? number (Optional) Radius around the pickup coordinate in meters. Default 100 m.
---@return AUFTRAG # self
function AUFTRAG:NewTROOPTRANSPORT(TransportGroupSet, DropoffCoordinate, PickupCoordinate, PickupRadius) end

---**[AIR ROTARY]** Create a CARGO TRANSPORT mission.
---This mission is for helicopters only, which transport cargo externally via slingload.
---**Important Note:**
---The dropoff zone has to be a zone defined in the Mission Editor. This is due to a restriction in the used DCS task, which takes the zone ID as input.
---Only ME zones have an ID that can be referenced.
---@param StaticCargo? STATIC Static cargo object.
---@param DropZone? ZONE Zone where to drop off the cargo. **Has to be a zone defined in the ME!**
---@return AUFTRAG # self
function AUFTRAG:NewCARGOTRANSPORT(StaticCargo, DropZone) end

---**[AIR]** Create a FREIGHT TRANSPORT mission.
---This mission type can be used to transport cargo items internally via suitable transport aircraft (planes and helicopters), e.g. C-130 or CH-47.
---It supports transporting one or multiple cargos (weight limits are not checked).
---
---All cargo must be within a 40 meter radius around the transport aircraft for the mission to start.
---The mission is successful if any cargo item is delivered to the destination.
---
---This mission type uses the underlying DCS tasks: "Cargo Transportation (internal)", "Cargo Unload"
---@param StaticCargo? STATIC Static cargo object. Can also be passed as a `SET_STATIC` object.
---@param Destination? AIRBASE Destination airbase, where the cargo is unloaded.
---@return AUFTRAG # self
function AUFTRAG:NewFREIGHTTRANSPORT(StaticCargo, Destination) end

---**[AIR, GROUND, NAVAL]** Create a OPS TRANSPORT mission.
---@param CargoGroupSet? SET_GROUP The set group(s) to be transported.
---@param PickupZone? ZONE Pick up zone
---@param DeployZone? ZONE Deploy zone
---@return AUFTRAG # self
function AUFTRAG:NewOPSTRANSPORT(CargoGroupSet, PickupZone, DeployZone) end

---**[GROUND, NAVAL]** Create an ARTY mission ("Fire at point" task).
---
---If the group has more than one weapon type supporting the "Fire at point" task, the employed weapon type can be set via the `AUFTRAG:SetWeaponType()` function.
---
---**Note** that it is recommended to set the weapon range via the `OPSGROUP:AddWeaponRange()` function as this cannot be retrieved from the DCS API.
---@param Target? COORDINATE Center of the firing solution.
---@param Nshots? number (Optional) Number of shots to be fired. Default `#nil`. If value is in (0,1), it is interpreted as per cent of available ammo.
---@param Radius? number (Optional) Radius of the shells in meters. Default 100 meters.
---@param Altitude? number (Optional) Altitude in meters. Can be used to setup a Barrage. Default `#nil`.
---@return AUFTRAG # self
function AUFTRAG:NewARTY(Target, Nshots, Radius, Altitude) end

---**[GROUND, NAVAL]** Create an BARRAGE mission. Assigned groups will move to a random coordinate within a given zone and start firing into the air.
---@param Zone? ZONE The zone where the unit will go.
---@param Heading? number (Optional) Heading in degrees. Default random heading [0, 360).
---@param Angle? number (Optional) Shooting angle in degrees. Default random [45, 85].
---@param Radius? number (Optional) Radius of the shells in meters. Default 100 meters.
---@param Altitude? number (Optional) Altitude in meters. Default 500 m.
---@param Nshots? number (Optional) Number of shots to be fired. Default is until ammo is empty (`#nil`).
---@return AUFTRAG # self
function AUFTRAG:NewBARRAGE(Zone, Heading, Angle, Radius, Altitude, Nshots) end

---**[AIR, GROUND, NAVAL]** Create a PATROLZONE mission. Group(s) will go to the zone and patrol it randomly.
---@param Zone? ZONE The patrol zone.
---@param Speed? number Speed in knots.
---@param Altitude? number (Optional) Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Formation? string (Optional) Formation used by ground units during patrol. Default "Off Road".
---@return AUFTRAG # self
function AUFTRAG:NewPATROLZONE(Zone, Speed, Altitude, Formation) end

---**[AIR, GROUND, NAVAL]** Create a CAPTUREZONE mission. Group(s) will go to the zone and patrol it randomly.
---@param OpsZone? OPSZONE The OPS zone to capture.
---@param Coalition? number The coalition which should capture the zone for the mission to be successful.
---@param Speed? number Speed in knots.
---@param Altitude? number (Optional) Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Formation? string (Optional) Formation used by ground units during patrol. Default "Off Road".
---@param StayInZoneTime? number Stay this many seconds in the zone when done, only then drive back.
---@return AUFTRAG # self
function AUFTRAG:NewCAPTUREZONE(OpsZone, Coalition, Speed, Altitude, Formation, StayInZoneTime) end

---**[OBSOLETE]** Create a ARMORATTACK mission.
---** Note that this is actually creating a GROUNDATTACK mission!**
---@param Target? TARGET The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Speed? number Speed in knots.
---@param Formation? string The attack formation, e.g. "Wedge", "Vee" etc.
---@return AUFTRAG # self
function AUFTRAG:NewARMORATTACK(Target, Speed, Formation) end

---**[GROUND]** Create a GROUNDATTACK mission. Ground group(s) will go to a target object and attack at their own discretion.
---Unfortunately, the "Attack Group" and "Attack Unit" tasks do not work for ground and naval groups (only for aircraft).
---Therefore, we resort to this workaround, which guides the attacking group to the vicinity of the target. Then they start shooting on their own, once they detect the target.
---@param Target? POSITIONABLE The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Speed? number (Optional) Speed in knots. Default max.
---@param Formation? string (Optional) The attack formation, e.g. "Wedge", "Vee" etc. Default `ENUMS.Formation.Vehicle.Vee`. Only working for ground, not naval!
---@return AUFTRAG # self
function AUFTRAG:NewGROUNDATTACK(Target, Speed, Formation) end

---**[NAVAL]** Create a NAVALENGAGEMENT mission. Naval group(s) will go to a target object and attack at their own discretion.
---Unfortunately, the "Attack Group" and "Attack Unit" tasks do not work for ground and naval groups (only for aircraft).
---Therefore, we resort to this workaround, which guides the attacking group to the vicinity of the target. Then they start shooting on their own, once they detect the target.
---@param Target? POSITIONABLE The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Speed? number (Optional) Speed in knots. Default max.
---@param Depth? number (Optional) The attack depth in meters. Only for submarines! Defaults to 0.
---@return AUFTRAG # self
function AUFTRAG:NewNAVALENGAGEMENT(Target, Speed, Depth) end

---**[AIR, GROUND, NAVAL]** Create a RECON mission.
---@param ZoneSet? SET_ZONE The recon zones.
---@param Speed? number (Optional) Speed in knots.
---@param Altitude? number (Optional) Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Adinfinitum? boolean If `true`, the group will start over again after reaching the final zone.
---@param Randomly? boolean If `true`, the group will select a random zone.
---@param Formation? string Formation used during recon route.
---@return AUFTRAG # self
function AUFTRAG:NewRECON(ZoneSet, Speed, Altitude, Adinfinitum, Randomly, Formation) end

---**[GROUND]** Create a AMMO SUPPLY mission.
---@param Zone? ZONE The zone, where supply units go.
---@return AUFTRAG # self
function AUFTRAG:NewAMMOSUPPLY(Zone) end

---**[GROUND]** Create a FUEL SUPPLY mission.
---@param Zone? ZONE The zone, where supply units go.
---@return AUFTRAG # self
function AUFTRAG:NewFUELSUPPLY(Zone) end

---**[GROUND]** Create a REARMING mission.
---@param Zone? ZONE The zone, where units go and look for ammo supply.
---@return AUFTRAG # self
function AUFTRAG:NewREARMING(Zone) end

---**[AIR]** Create an ALERT 5 mission. Aircraft will be spawned uncontrolled and wait for an assignment. You must specify **one** mission type which is performed.
---This determines the payload and the DCS mission task which are used when the aircraft is spawned.
---@param MissionType? string Mission type `AUFTRAG.Type.XXX`. Determines payload and mission task (intercept, ground attack, etc.).
---@return AUFTRAG # self
function AUFTRAG:NewALERT5(MissionType) end

---**[GROUND, NAVAL]** Create an ON GUARD mission.
---@param Coordinate? COORDINATE Coordinate, where to stand guard.
---@return AUFTRAG # self
function AUFTRAG:NewONGUARD(Coordinate) end

---**[GROUND, NAVAL]** Create an AIRDEFENSE mission.
---@param Zone? ZONE Zone where the air defense group(s) should be stationed.
---@return AUFTRAG # self
function AUFTRAG:NewAIRDEFENSE(Zone) end

---**[GROUND]** Create an EWR mission.
---@param Zone? ZONE Zone where the Early Warning Radar group(s) should be stationed.
---@return AUFTRAG # self
function AUFTRAG:NewEWR(Zone) end

---**[PRIVATE, AIR, GROUND, NAVAL]** Create a mission to relocate all cohort assets to another LEGION.
---@param Legion? LEGION The new legion.
---@param Cohort? COHORT The cohort to be relocated.
---@return AUFTRAG # self
function AUFTRAG:_NewRELOCATECOHORT(Legion, Cohort) end

---**[GROUND, NAVAL]** Create a mission to do NOTHING.
---@param RelaxZone? ZONE Zone where the assets are supposed to do nothing.
---@return AUFTRAG # self
function AUFTRAG:NewNOTHING(RelaxZone) end

---**[GROUND]** Create an ARMORED ON GUARD mission.
---@param Coordinate? COORDINATE Coordinate, where to stand guard.
---@param Formation? string Formation to take, e.g. "On Road", "Vee" etc.
---@return AUFTRAG # self
function AUFTRAG:NewARMOREDGUARD(Coordinate, Formation) end

---Create a mission to attack a TARGET object.
---@param Target? TARGET The target.
---@param MissionType? string The mission type.
---@return AUFTRAG # self
function AUFTRAG:NewFromTarget(Target, MissionType) end

---Create a mission to attack a group. Mission type is automatically chosen from the group category.
---@param Target? POSITIONABLE Target object.
---@return string # Auftrag type, e.g. `AUFTRAG.Type.BAI` (="BAI").
function AUFTRAG:_DetermineAuftragType(Target) end

---Create a mission to attack a group. Mission type is automatically chosen from the group category.
---@param EngageGroup? GROUP Group to be engaged.
---@return AUFTRAG # self
function AUFTRAG:NewAUTO(EngageGroup) end

---Set mission start and stop time.
---@param ClockStart? string (Optional) Time the mission is started, e.g. "05:00" for 5 am. If specified as a #number, it will be relative (in seconds) to the current mission time. Default is 5 seconds after mission was added.
---@param ClockStop? string (Optional) Time the mission is stopped, e.g. "13:00" for 1 pm. If mission could not be started at that time, it will be removed from the queue. If specified as a #number it will be relative (in seconds) to the current mission time.
---@return AUFTRAG # self
function AUFTRAG:SetTime(ClockStart, ClockStop) end

---Set time how long the mission is executed. Once this time limit has passed, the mission is cancelled.
---@param Duration? number Duration in seconds.
---@return AUFTRAG # self
function AUFTRAG:SetDuration(Duration) end

---Set that mission assets are teleported to the mission execution waypoint.
---@param Switch? boolean If `true` or `nil`, teleporting is on. If `false`, teleporting is off.
---@return AUFTRAG # self
function AUFTRAG:SetTeleport(Switch) end

---**[LEGION, COMMANDER, CHIEF]** Set whether assigned assets return to their legion once the mission is over. This is only applicable to **army** and **navy** groups, *i.e.* aircraft
---will always return.
---@param Switch? boolean If `true`, assets will return. If `false`, assets will not return and stay where it finishes its last mission. If `nil`, let asset decide.
---@return AUFTRAG # self
function AUFTRAG:SetReturnToLegion(Switch) end

---Set mission push time. This is the time the mission is executed. If the push time is not passed, the group will wait at the mission execution waypoint.
---@param ClockPush? string Time the mission is executed, e.g. "05:00" for 5 am. Can also be given as a `#number`, where it is interpreted as relative push time in seconds.
---@return AUFTRAG # self
function AUFTRAG:SetPushTime(ClockPush) end

---Set mission priority and (optional) urgency. Urgent missions can cancel other running missions.
---@param Prio? number (Optional) Priority 1=high, 100=low. Default 50.
---@param Urgent? boolean If *true*, another running mission might be cancelled if it has a lower priority.
---@param Importance? number (Optional) Number 1-10. If missions with lower value are in the queue, these have to be finished first. Default is `nil`.
---@return AUFTRAG # self
function AUFTRAG:SetPriority(Prio, Urgent, Importance) end

---**[LEGION, COMMANDER, CHIEF]** Set how many times the mission is repeated. Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---@param Nrepeat? number (Optional) Number of repeats. Default 0.
---@return AUFTRAG # self
function AUFTRAG:SetRepeat(Nrepeat) end

---**[LEGION, COMMANDER, CHIEF]** Set the repeat delay in seconds after a mission is successful/failed. Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---@param RepeatDelay? number (Optional) Repeat delay in seconds. Default 1.
---@return AUFTRAG # self
function AUFTRAG:SetRepeatDelay(RepeatDelay) end

---**[LEGION, COMMANDER, CHIEF]** Set how many times the mission is repeated if it fails. Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---@param Nrepeat? number (Optional) Number of repeats. Default 0.
---@return AUFTRAG # self
function AUFTRAG:SetRepeatOnFailure(Nrepeat) end

---**[LEGION, COMMANDER, CHIEF]** Set how many times the mission is repeated if it was successful. Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---@param Nrepeat? number (Optional) Number of repeats. Default 0.
---@return AUFTRAG # self
function AUFTRAG:SetRepeatOnSuccess(Nrepeat) end

---**[LEGION, COMMANDER, CHIEF]** Set that mission assets get reinforced if their number drops below the minimum number of required assets of the mission (*c.f.* SetRequiredAssets() function).
---
---**Note** that reinforcement groups are only recruited from the legion (airwing, brigade, fleet) the mission was assigned to. If the legion does not have any more of these assets,
---no reinforcement can take place, even if the mission is submitted to a COMMANDER or CHIEF.
---@param Nreinforce? number Number of max asset groups used to reinforce.
---@return AUFTRAG # self
function AUFTRAG:SetReinforce(Nreinforce) end

---**[LEGION, COMMANDER, CHIEF]** Define how many assets are required to do the job. Only used if the mission is handled by a **LEGION** (AIRWING, BRIGADE, ...) or higher level.
---@param NassetsMin? number (Optional) Minimum number of asset groups. Default 1.
---@param NassetsMax? number (Optional) Maximum Number of asset groups. Default is same as `NassetsMin`.
---@return AUFTRAG # self
function AUFTRAG:SetRequiredAssets(NassetsMin, NassetsMax) end

---**[LEGION, COMMANDER, CHIEF]** Get number of required assets.
---@return number # Min. number of required assets.
---@return number # Max. number of required assets.
function AUFTRAG:GetRequiredAssets() end

---**[LEGION, COMMANDER, CHIEF]** Set that only alive (spawned) assets are considered.
---@param Switch? boolean If true or nil, only active assets. If false
---@return AUFTRAG # self
function AUFTRAG:SetAssetsStayAlive(Switch) end

---**[LEGION, COMMANDER, CHIEF]** Define how many assets are required that escort the mission assets.
---Only used if the mission is handled by a **LEGION** (AIRWING, BRIGADE, FLEET) or higher level.
---@param NescortMin? number (Optional) Minimum number of asset groups. Default 1.
---@param NescortMax? number (Optional) Maximum Number of asset groups. Default is same as `NassetsMin`.
---@param MissionType? string (Optional) Mission type assets will be optimized for and payload selected, *e.g.* `AUFTRAG.Type.SEAD`. Default nil.
---@param TargetTypes? table (Optional) Target Types that will be engaged by the escort group(s). Default `{"Air"}` for aircraft and `{"Ground Units"}` for helos. Set, *e.g.*, `{"Air Defence"}` for SEAD.
---@param EngageRange? number (Optional) Max range in nautical miles that the escort group(s) will engage enemies. Default 32 NM (60 km).
---@return AUFTRAG # self
function AUFTRAG:SetRequiredEscorts(NescortMin, NescortMax, MissionType, TargetTypes, EngageRange) end

---Set mission name.
---@param Name? string (Optional) Name of the mission. Default is "Auftrag Nr. X", where X is a running number, which is automatically increased.
---@return AUFTRAG # self
function AUFTRAG:SetName(Name) end

---Enable markers, which dispay the mission status on the F10 map.
---@param Coalition? number (Optional) The coaliton side to which the markers are dispayed. Default is to all.
---@return AUFTRAG # self
function AUFTRAG:SetEnableMarkers(Coalition) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return AUFTRAG # self
function AUFTRAG:SetVerbosity(VerbosityLevel) end

---Set weapon type used for the engagement.
---@param WeaponType? number (Optional) Weapon type. Default is `ENUMS.WeaponFlag.Auto`.
---@return AUFTRAG # self
function AUFTRAG:SetWeaponType(WeaponType) end

---Set number of weapons to expend.
---@param WeaponExpend? number (Optional) How much of the weapon load is expended during the attack, e.g. `AI.Task.WeaponExpend.ALL`. Default "Auto".
---@return AUFTRAG # self
function AUFTRAG:SetWeaponExpend(WeaponExpend) end

---Set whether target will be attack as group.
---@param Switch? boolean If true or nil, engage as group. If false, not.
---@return AUFTRAG # self
function AUFTRAG:SetEngageAsGroup(Switch) end

---Set engage altitude. This is the altitude passed to the DCS task. In the ME it is the tickbox ALTITUDE ABOVE.
---@param Altitude? string (Optional) Altitude in feet. Default 6000 ft.
---@return AUFTRAG # self
function AUFTRAG:SetEngageAltitude(Altitude) end

---Set engage quantity. This is the number of times the attack group/unit DCS task is carried out.
---@param Quantity? number (Optional) Number of times the group will engage the target.
---@return AUFTRAG # self
function AUFTRAG:SetEngageQuantity(Quantity) end

---Enable to automatically engage detected targets.
---@param RangeMax? number (Optional) Max range in NM. Only detected targets within this radius from the group will be engaged. Default is 25 NM.
---@param TargetTypes? table (Optional) Types of target attributes that will be engaged. See [DCS enum attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). Default "All".
---@param EngageZoneSet? SET_ZONE (Optional) Set of zones in which targets are engaged. Default is anywhere.
---@param NoEngageZoneSet? SET_ZONE (Optional) Set of zones in which targets are *not* engaged. Default is nowhere.
---@return AUFTRAG # self
function AUFTRAG:SetEngageDetected(RangeMax, TargetTypes, EngageZoneSet, NoEngageZoneSet) end

---Set mission altitude. This is the altitude of the waypoint create where the DCS task is executed.
---@param Altitude? string Altitude in feet.
---@return AUFTRAG # self
function AUFTRAG:SetMissionAltitude(Altitude) end

---Set mission speed. That is the speed the group uses to get to the mission waypoint.
---@param Speed? string Mission speed in knots.
---@return AUFTRAG # self
function AUFTRAG:SetMissionSpeed(Speed) end

---Set max mission range. Only applies if the AUFTRAG is handled by an AIRWING or CHIEF. This is the max allowed distance from the airbase to the target.
---@param Range? number (Optional) Max range in NM. Default 100 NM.
---@return AUFTRAG # self
function AUFTRAG:SetMissionRange(Range) end

---Attach OPS transport to the mission. Mission assets will be transported before the mission is started at the OPSGROUP level.
---@param OpsTransport? OPSTRANSPORT The OPS transport assignment attached to the mission.
---@return AUFTRAG # self
function AUFTRAG:SetOpsTransport(OpsTransport) end

---Get the attach OPS transport of the mission.
---@return OPSTRANSPORT # The OPS transport assignment attached to the mission.
function AUFTRAG:GetOpsTransport() end

---**[LEGION, COMMANDER, CHIEF]** Attach OPS transport to the mission. Mission assets will be transported before the mission is started at the OPSGROUP level.
---@param DeployZone? ZONE Zone where assets are deployed.
---@param NcarriersMin? number (Optional) Number of carriers *at least* required. Default 1.
---@param NcarriersMax? number (Optional) Number of carriers *at most* used for transportation. Default is same as `NcarriersMin`.
---@param DisembarkZone? ZONE Zone where assets are disembarked to.
---@param Categories? any Group categories.
---@param Attributes? table Generalizes group attributes.
---@param Properties? table DCS attributes.
---@return AUFTRAG # self
function AUFTRAG:SetRequiredTransport(DeployZone, NcarriersMin, NcarriersMax, DisembarkZone, Categories, Attributes, Properties) end

---Add carriers for a transport of mission assets.
---@param Carriers? SET_OPSGROUP Set of carriers. Can also be a single group.
---@return AUFTRAG # self
function AUFTRAG:AddTransportCarriers(Carriers) end

---**[LEGION, COMMANDER, CHIEF]** Set required attribute(s) the assets must have.
---@param Attributes? table Generalized attribute(s).
---@return AUFTRAG # self
function AUFTRAG:SetRequiredAttribute(Attributes) end

---**[LEGION, COMMANDER, CHIEF]** Set required property or properties the assets must have.
---These are [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes).
---@param Properties? table Property or table of properties.
---@return AUFTRAG # self
function AUFTRAG:SetRequiredProperty(Properties) end

---**[LEGION, COMMANDER, CHIEF]** Set number of required carrier groups if an OPSTRANSPORT assignment is required.
---@param NcarriersMin? number (Optional) Number of carriers *at least* required. Default 1.
---@param NcarriersMax? number (Optional) Number of carriers *at most* used for transportation. Default is same as `NcarriersMin`.
---@param Categories? any Group categories.
---@param Attributes? table Group attributes. See `GROUP.Attribute.`
---@param Properties? table DCS attributes.
---@return AUFTRAG # self
function AUFTRAG:SetRequiredCarriers(NcarriersMin, NcarriersMax, Categories, Attributes, Properties) end

---Set that (jet) aircraft are generally **not** allowed to use afterburner. Default is use of afterburner is allowed.
---@return AUFTRAG # self
function AUFTRAG:SetProhibitAfterburner() end

---Set that (jet) aircraft are generally allowed to use afterburner. Default is use of afterburner is allowed.
---@return AUFTRAG # self
function AUFTRAG:SetAllowAfterburner() end

---Set that (jet) aircraft are **not** allowed to use afterburner in mission execution phase. Default is use of afterburner is allowed.
---@return AUFTRAG # self
function AUFTRAG:SetProhibitAfterburnerExecutePhase() end

---Set that (jet) aircraft are allowed to use afterburner in mission execution phase. Default is use of afterburner is allowed.
---@return AUFTRAG # self
function AUFTRAG:SetAllowAfterburnerExecutePhase() end

---**[LEGION, COMMANDER, CHIEF]** Assign a legion cohort to the mission. Only these cohorts will be considered for the job.
---@param Cohort? COHORT The cohort.
---@return AUFTRAG # self
function AUFTRAG:AssignCohort(Cohort) end

---**[LEGION, COMMANDER, CHIEF]** Assign a legion to the mission. Only cohorts of this legion will be considered for the job. You can assign multiple legions.
---@param Legion? LEGION The legion.
---@return AUFTRAG # self
function AUFTRAG:AssignLegion(Legion) end

---**[LEGION, COMMANDER, CHIEF]** Assign airwing squadron(s) to the mission. Only these squads will be considered for the job.
---@param Squadrons? table A table of SQUADRON(s). **Has to be a table {}** even if a single squad is given.
---@return AUFTRAG # self
function AUFTRAG:AssignSquadrons(Squadrons) end

---**[LEGION, COMMANDER, CHIEF]** Assign a transport Legion.
---@param Legion? LEGION The legion.
function AUFTRAG:AssignTransportLegion(Legion) end

---**[LEGION, COMMANDER, CHIEF]** Assign a transport cohort.
---@param Cohort? Cohort The cohort.
function AUFTRAG:AssignTransportCohort(Cohort) end

---**[LEGION, COMMANDER, CHIEF]** Add an escort Legion.
---@param Legion? LEGION The legion.
function AUFTRAG:AssignEscortLegion(Legion) end

---**[LEGION, COMMANDER, CHIEF]** Assign an escort cohort.
---@param Cohort? Cohort The cohort.
function AUFTRAG:AssignEscortCohort(Cohort) end

---Set Rules of Engagement (ROE) for this mission.
---@param roe? number Mission ROE, e.g. `ENUMS.ROE.ReturnFire` (whiche equals 3)
---@return AUFTRAG # self
function AUFTRAG:SetROE(roe) end

---Set Reaction on Threat (ROT) for this mission.
---@param rot? number Mission ROT, e.g. `ENUMS.ROT.NoReaction` (whiche equals 0)
---@return AUFTRAG # self
function AUFTRAG:SetROT(rot) end

---Set alarm state for this mission.
---@param Alarmstate? number Alarm state 0=Auto, 1=Green, 2=Red.
---@return AUFTRAG # self
function AUFTRAG:SetAlarmstate(Alarmstate) end

---Set EPLRS datalink setting for this mission.
---@param OnOffSwitch? boolean If `true` or `nil`, EPLRS is on. If `false`, EPLRS is off.
---@return AUFTRAG # self
function AUFTRAG:SetEPLRS(OnOffSwitch) end

---Set emission setting for this mission.
---@param OnOffSwitch? boolean If `true` or `nil`, emission is on. If `false`, emission is off.
---@return AUFTRAG # self
function AUFTRAG:SetEmission(OnOffSwitch) end

---Set invisibility setting for this mission.
---@param OnOffSwitch? boolean If `true` or `nil`, invisible is on. If `false`, invisible is off.
---@return AUFTRAG # self
function AUFTRAG:SetInvisible(OnOffSwitch) end

---Set immortality setting for this mission.
---@param OnOffSwitch? boolean If `true` or `nil`, immortal is on. If `false`, immortal is off.
---@return AUFTRAG # self
function AUFTRAG:SetImmortal(OnOffSwitch) end

---Set formation for this mission.
---@param Formation? number Formation.
---@return AUFTRAG # self
function AUFTRAG:SetFormation(Formation) end

---Set radio frequency and modulation for this mission.
---@param Frequency? number Frequency in MHz.
---@param Modulation? number (Optional) Radio modulation. Default 0=AM.
---@return AUFTRAG # self
function AUFTRAG:SetRadio(Frequency, Modulation) end

---Set TACAN beacon channel and Morse code for this mission.
---@param Channel? number TACAN channel.
---@param Morse? string (Optional) Morse code. Default "XXX".
---@param UnitName? string (Optional) Name of the unit in the group for which acts as TACAN beacon. Default is the first unit in the group.
---@param Band? string (Optional) Tacan channel mode ("X" or "Y"). Default is "X" for ground/naval and "Y" for aircraft.
---@return AUFTRAG # self
function AUFTRAG:SetTACAN(Channel, Morse, UnitName, Band) end

---Set ICLS beacon channel and Morse code for this mission.
---@param Channel? number ICLS channel.
---@param Morse? string (Optional) Morse code. Default "XXX".
---@param UnitName? string (Optional) Name of the unit in the group for which acts as ICLS beacon. Default is the first unit in the group.
---@return AUFTRAG # self
function AUFTRAG:SetICLS(Channel, Morse, UnitName) end

---Set time interval between mission done and success/failure evaluation.
---@param Teval? number (Optional) Time in seconds before the mission result is evaluated. Default depends on mission type.
---@return AUFTRAG # self
function AUFTRAG:SetEvaluationTime(Teval) end

---Get mission type.
---@return string # Mission type, e.g. "BAI".
function AUFTRAG:GetType() end

---Get mission name.
---@return string # Mission name, e.g. "Auftrag Nr.1".
function AUFTRAG:GetName() end

---Get number of required assets.
---@return number # Numer of required assets.
function AUFTRAG:GetNumberOfRequiredAssets() end

---Get mission priority.
---@return number # Priority. Smaller is higher.
function AUFTRAG:GetPriority() end

---Get casualties, *i.e.* number of own units that died during this mission.
---@return number # Number of dead units.
function AUFTRAG:GetCasualties() end

---Get kills, i.e. number of units that were destroyed by assets of this mission.
---@return number # Number of units destroyed.
function AUFTRAG:GetKills() end

---Check if mission is "urgent".
---@return boolean # If `true`, mission is "urgent".
function AUFTRAG:IsUrgent() end

---Get mission importance.
---@return number # Importance. Smaller is higher.
function AUFTRAG:GetImportance() end

---Add start condition.
---@param ConditionFunction? function Function that needs to be true before the mission can be started. Must return a #boolean.
---@param ... any
---@return AUFTRAG # self
function AUFTRAG:AddConditionStart(ConditionFunction, ...) end

---Add success condition.
---@param ConditionFunction? function If this function returns `true`, the mission is cancelled.
---@param ... any
---@return AUFTRAG # self
function AUFTRAG:AddConditionSuccess(ConditionFunction, ...) end

---Add failure condition.
---@param ConditionFunction? function If this function returns `true`, the mission is cancelled.
---@param ... any
---@return AUFTRAG # self
function AUFTRAG:AddConditionFailure(ConditionFunction, ...) end

---Add push condition.
---@param ConditionFunction? function If this function returns `true`, the mission is executed.
---@param ... any
---@return AUFTRAG # self
function AUFTRAG:AddConditionPush(ConditionFunction, ...) end

---Add a required payload for this mission. Only these payloads will be used for this mission. If they are not available, the mission cannot start. Only available for use with an AIRWING.
---@param Payload? AIRWING.Payload|number|string Required payload.
---@return AUFTRAG # self
function AUFTRAG:AddRequiredPayload(Payload) end

---Add a Ops group to the mission.
---@param OpsGroup? OPSGROUP The OPSGROUP object.
---@return AUFTRAG # self
function AUFTRAG:AddOpsGroup(OpsGroup) end

---Remove an Ops group from the mission.
---@param OpsGroup? OPSGROUP The OPSGROUP object.
---@return AUFTRAG # self
function AUFTRAG:DelOpsGroup(OpsGroup) end

---Check if mission is PLANNED.
---@return boolean # If true, mission is in the planning state.
function AUFTRAG:IsPlanned() end

---Check if mission is QUEUED at a LEGION mission queue.
---@param Legion? LEGION (Optional) Check if mission is queued at this legion.
---@return boolean # If true, mission is queued.
function AUFTRAG:IsQueued(Legion) end

---Check if mission is REQUESTED. The mission request out to the WAREHOUSE.
---@param Legion? LEGION (Optional) Check if mission is requested at this legion.
---@return boolean # If true, mission is requested.
function AUFTRAG:IsRequested(Legion) end

---Check if mission is SCHEDULED. The first OPSGROUP has been assigned.
---@return boolean # If true, mission is queued.
function AUFTRAG:IsScheduled() end

---Check if mission is STARTED. The first OPSGROUP is on its way to the mission execution waypoint.
---@return boolean # If true, mission is started.
function AUFTRAG:IsStarted() end

---Check if mission is EXECUTING. The first OPSGROUP has reached the mission execution waypoint and is not executing the mission task.
---@param AllGroups? boolean (Optional) Check that all groups are currently executing the mission.
---@return boolean # If true, mission is currently executing.
function AUFTRAG:IsExecuting(AllGroups) end

---Check if mission was cancelled.
---@return boolean # If true, mission was cancelled.
function AUFTRAG:IsCancelled() end

---Check if mission is done.
---@return boolean # If true, mission is done.
function AUFTRAG:IsDone() end

---Check if mission was a success.
---@return boolean # If true, mission was successful.
function AUFTRAG:IsSuccess() end

---Check if mission is over. This could be state DONE, CANCELLED, SUCCESS, FAILED.
---@return boolean # If true, mission is over.
function AUFTRAG:IsOver() end

---Check if mission is repeatable.
---@return boolean # If true, mission is repeatable.
function AUFTRAG:IsRepeatable() end

---Check if mission is NOT repeatable.
---@return boolean # If true, mission is NOT repeatable.
function AUFTRAG:IsNotRepeatable() end

---Check if mission is NOT over.
---@return boolean # If true, mission is NOT over yet.
function AUFTRAG:IsNotOver() end

---Check if mission is for aircarft (airplanes and/or helicopters).
---@return boolean # If `true`, mission is for aircraft.
function AUFTRAG:IsAircraft() end

---Check if mission is for airplanes.
---@return boolean # If `true`, mission is for airplanes.
function AUFTRAG:IsAirplane() end

---Check if mission is for helicopters.
---@return boolean # If `true`, mission is for helicopters.
function AUFTRAG:IsHelicopters() end

---Check if mission is for ground units.
---@return boolean # If `true`, mission is for ground units.
function AUFTRAG:IsGround() end

---Check if mission is for naval units.
---@return boolean # If `true`, mission is for naval units.
function AUFTRAG:IsNaval() end

---Check if mission is ready to be started.
---* Mission start time passed.
---* Mission stop time did not pass already.
---* All start conditions are true.
---@return boolean # If true, mission can be started.
function AUFTRAG:IsReadyToGo() end

---Check if mission is ready to be cancelled.
---* Mission stop already passed.
---* Any stop condition is true.
---@return boolean # If true, mission should be cancelled.
function AUFTRAG:IsReadyToCancel() end

---Check if mission is ready to be pushed.
---* Mission push time already passed.
---* **All** push conditions are true.
---@return boolean # If true, mission groups can push.
function AUFTRAG:IsReadyToPush() end

---Check if all given condition are true.
---@param Conditions? table Table of conditions.
---@return boolean # If true, all conditions were true. Returns false if at least one condition returned false.
function AUFTRAG:EvalConditionsAll(Conditions) end

---Check if any of the given conditions is true.
---@param Conditions? table Table of conditions.
---@return boolean # If true, at least one condition is true.
function AUFTRAG:EvalConditionsAny(Conditions) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterStatus(From, Event, To) end

---Evaluate mission outcome - success or failure.
---@return AUFTRAG # self
function AUFTRAG:Evaluate() end

---Get all OPS groups.
---@return table # Table of Ops.OpsGroup#OPSGROUP or {}.
function AUFTRAG:GetOpsGroups() end

---Get asset data table.
---@param AssetName? string Name of the asset.
---@return AUFTRAG.GroupData # Group data or *nil* if OPS group does not exist.
function AUFTRAG:GetAssetDataByName(AssetName) end

---Get flight data table.
---@param opsgroup? OPSGROUP The flight group.
---@return AUFTRAG.GroupData # Flight data or nil if opsgroup does not exist.
function AUFTRAG:GetGroupData(opsgroup) end

---Set opsgroup mission status.
---@param opsgroup? OPSGROUP The flight group.
---@param status? string New status.
---@return AUFTRAG # self
function AUFTRAG:SetGroupStatus(opsgroup, status) end

---Get ops group mission status.
---@param opsgroup? OPSGROUP The OPS group.
---@return string # The group status.
function AUFTRAG:GetGroupStatus(opsgroup) end

---Add LEGION to mission.
---@param Legion? LEGION The legion.
---@return AUFTRAG # self
function AUFTRAG:AddLegion(Legion) end

---Remove LEGION from mission.
---@param Legion? LEGION The legion.
---@return AUFTRAG # self
function AUFTRAG:RemoveLegion(Legion) end

---Set LEGION mission status.
---@param Legion? LEGION The legion.
---@param Status? string New status.
---@return AUFTRAG # self
function AUFTRAG:SetLegionStatus(Legion, Status) end

---Get LEGION mission status.
---@param Legion? LEGION The legion.
---@return string # status Current status.
function AUFTRAG:GetLegionStatus(Legion) end

---Set mission (ingress) waypoint coordinate for OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@param coordinate? COORDINATE Waypoint Coordinate.
---@return AUFTRAG # self
function AUFTRAG:SetGroupWaypointCoordinate(opsgroup, coordinate) end

---[Air] Set mission (ingress) waypoint coordinate for FLIGHT group.
---@param coordinate? COORDINATE Waypoint Coordinate.
---@return AUFTRAG # self
function AUFTRAG:SetIngressCoordinate(coordinate) end

---Get mission (ingress) waypoint coordinate of OPS group
---@param opsgroup? OPSGROUP The OPS group.
---@return COORDINATE # Waypoint Coordinate.
function AUFTRAG:GetGroupWaypointCoordinate(opsgroup) end

---Set mission waypoint task for OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@param task? OPSGROUP.Task|number|string Waypoint task.
function AUFTRAG:SetGroupWaypointTask(opsgroup, task) end

---Get mission waypoint task of OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@return OPSGROUP.Task # task Waypoint task. Waypoint task.
function AUFTRAG:GetGroupWaypointTask(opsgroup) end

---Set mission (ingress) waypoint UID for OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@param waypointindex? number Waypoint UID.
---@return AUFTRAG # self
function AUFTRAG:SetGroupWaypointIndex(opsgroup, waypointindex) end

---Get mission (ingress) waypoint UID of OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@return number # Waypoint UID.
function AUFTRAG:GetGroupWaypointIndex(opsgroup) end

---Set Egress waypoint UID for OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@param waypointindex? number Waypoint UID.
---@return AUFTRAG # self
function AUFTRAG:SetGroupEgressWaypointUID(opsgroup, waypointindex) end

---Get Egress waypoint UID of OPS group.
---@param opsgroup? OPSGROUP The OPS group.
---@return number # Waypoint UID.
function AUFTRAG:GetGroupEgressWaypointUID(opsgroup) end

---Check if all groups are done with their mission (or dead).
---@return boolean # If `true`, all groups are done with the mission.
function AUFTRAG:CheckGroupsDone() end

---Unit lost event.
---@param EventData? EVENTDATA Event data.
function AUFTRAG:OnEventUnitLost(EventData) end

---On after "Planned" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterPlanned(From, Event, To) end

---On after "Queue" event. Mission is added to the mission queue of a LEGION.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Airwing? any
function AUFTRAG:onafterQueued(From, Event, To, Airwing) end

---On after "Requested" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterRequested(From, Event, To) end

---On after "Assign" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterAssign(From, Event, To) end

---On after "Schedule" event. Mission is added to the mission queue of an OPSGROUP.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterScheduled(From, Event, To) end

---On after "Start" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterStarted(From, Event, To) end

---On after "Execute" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterExecuting(From, Event, To) end

---On after "ElementDestroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP The ops group to which the element belongs.
---@param Element? OPSGROUP.Element|number|string The element that got destroyed.
function AUFTRAG:onafterElementDestroyed(From, Event, To, OpsGroup, Element) end

---On after "GroupDead" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param OpsGroup? OPSGROUP The ops group that is dead now.
function AUFTRAG:onafterGroupDead(From, Event, To, OpsGroup) end

---On after "AssetDead" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset.
function AUFTRAG:onafterAssetDead(From, Event, To, Asset) end

---On after "Cancel" event. Cancells the mission.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterCancel(From, Event, To) end

---On after "Done" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterDone(From, Event, To) end

---On after "Success" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterSuccess(From, Event, To) end

---On after "Failed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterFailed(From, Event, To) end

---On before "Repeat" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onbeforeRepeat(From, Event, To) end

---On after "Repeat" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterRepeat(From, Event, To) end

---On after "Stop" event. Remove mission from LEGION and OPSGROUP mission queues.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:onafterStop(From, Event, To) end

---Create target data from a given object.
---@param Object? POSITIONABLE The target GROUP, UNIT, STATIC.
function AUFTRAG:_TargetFromObject(Object) end

---Count alive mission targets.
---@param OnlyReallyAlive? boolean (Optional) If `true`, count only really alive targets (units, groups) but not coordinates or zones.
---@return number # Number of alive target units.
function AUFTRAG:CountMissionTargets(OnlyReallyAlive) end

---Get initial number of targets.
---@return number # Number of initial life points when mission was planned.
function AUFTRAG:GetTargetInitialNumber() end

---Get target life points.
---@return number # Number of initial life points when mission was planned.
function AUFTRAG:GetTargetInitialLife() end

---Get target damage.
---@return number # Damage in percent.
function AUFTRAG:GetTargetDamage() end

---Get target life points.
---@return number # Life points of target.
function AUFTRAG:GetTargetLife() end

---Get cargo items as set SET object.
---This returns the cargo item(s) as set `SET` object for mission types `CARGOTRANSPORT`, `TROOPTRANSPORT` and `FREIGHTTRANSPORT`.
---@return SET_BASE # The cargo set.
function AUFTRAG:GetCargoSet() end

---Get target.
---@return TARGET # The target object. Could be many things.
function AUFTRAG:GetTargetData() end

---Get mission objective object. Could be many things depending on the mission type.
---@param RefCoordinate? COORDINATE (Optional) Reference coordinate from which the closest target is determined.
---@param Coalitions? table (Optional) Only consider targets of the given coalition(s).
---@return POSITIONABLE # The target object. Could be many things.
function AUFTRAG:GetObjective(RefCoordinate, Coalitions) end

---Get type of target.
---@return string # The target type.
function AUFTRAG:GetTargetType() end

---Get 2D vector of target.
---@return VEC2 # The target 2D vector or *nil*.
function AUFTRAG:GetTargetVec2() end

---Get coordinate of target.
---@return COORDINATE # The target coordinate or *nil*.
function AUFTRAG:GetTargetCoordinate() end

---Get heading of target.
---@return number # Heading of target in degrees.
function AUFTRAG:GetTargetHeading() end

---Get name of the target.
---@return string # Name of the target or "N/A".
function AUFTRAG:GetTargetName() end

---Get distance to target.
---@param FromCoord? COORDINATE The coordinate from which the distance is measured.
---@return number # Distance in meters or 0.
function AUFTRAG:GetTargetDistance(FromCoord) end

---Add asset to mission.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset to be added to the mission.
---@return AUFTRAG # self
function AUFTRAG:AddAsset(Asset) end

---Add assets to mission.
---@param Assets? table List of assets.
---@return AUFTRAG # self
function AUFTRAG:_AddAssets(Assets) end

---Delete asset from mission.
---@param Asset? WAREHOUSE.Assetitem|number|string The asset to be removed.
---@return AUFTRAG # self
function AUFTRAG:DelAsset(Asset) end

---Get asset by its spawn group name.
---@param Name? string Asset spawn group name.
---@return WAREHOUSE.Assetitem # Asset.
function AUFTRAG:GetAssetByName(Name) end

---Count alive OPS groups assigned for this mission.
---@return number # Number of alive OPS groups.
function AUFTRAG:CountOpsGroups() end

---Count OPS groups in a certain status.
---@param Status? string Status of group, e.g. `AUFTRAG.GroupStatus.EXECUTING`.
---@return number # Number of alive OPS groups.
function AUFTRAG:CountOpsGroupsInStatus(Status) end

---Get coordinate of target. First unit/group of the set is used.
---@param MissionTypes? table A table of mission types.
---@return string # Comma separated list of mission types.
function AUFTRAG:GetMissionTypesText(MissionTypes) end

---[NON-AIR] Set the mission waypoint coordinate from where the mission is executed. Note that altitude is set via `:SetMissionAltitude`.
---@param Coordinate? COORDINATE Coordinate where the mission is executed.
---@return AUFTRAG # self
function AUFTRAG:SetMissionWaypointCoord(Coordinate) end

---Set randomization of the mission waypoint coordinate. Each assigned group will get a random ingress coordinate, where the mission is executed.
---@param Radius? number (Optional) Distance in meters. Default `#nil`.
---@return AUFTRAG # self
function AUFTRAG:SetMissionWaypointRandomization(Radius) end

---Set the mission egress coordinate. This is the coordinate where the assigned group will go once the mission is finished.
---@param Coordinate? COORDINATE Egrees coordinate.
---@param Altitude? number (Optional) Altitude in feet. Default is y component of coordinate.
---@param Speed? number (Optional) Speed in knots to reach this waypoint. Defaults to mission speed.
---@return AUFTRAG # self
function AUFTRAG:SetMissionEgressCoord(Coordinate, Altitude, Speed) end

---[Air] Set the mission ingress coordinate. This is the coordinate where the assigned group will fly before the actual mission coordinate.
---@param Coordinate? COORDINATE Ingrees coordinate.
---@param Altitude? number (Optional) Altitude in feet. Default is y component of coordinate.
---@param Speed? number (Optional) Speed in knots to reach this waypoint. Defaults to mission speed.
---@return AUFTRAG # self
function AUFTRAG:SetMissionIngressCoord(Coordinate, Altitude, Speed) end

---[Air] Set the mission holding coordinate. This is the coordinate where the assigned group will fly before the actual mission execution starts. Do not forget to add a push condition, too!
---@param Coordinate? COORDINATE Holding coordinate.
---@param Altitude? number (Optional) Altitude in feet. Default is y component of coordinate.
---@param Speed? number (Optional) Speed in knots to reach this waypoint and hold there. Defaults to mission speed.
---@param Duration? number (Optional) Duration in seconds on how long to hold, defaults to 15 minutes. Mission continues if either a push condition is met or the time is up.
---@return AUFTRAG # self
function AUFTRAG:SetMissionHoldingCoord(Coordinate, Altitude, Speed, Duration) end

---Get the mission egress coordinate if this was defined.
---@return COORDINATE # Coordinate Coordinate or nil.
function AUFTRAG:GetMissionEgressCoord() end

---Get the mission ingress coordinate if this was defined.
---@return COORDINATE # Coordinate Coordinate or nil.
function AUFTRAG:GetMissionIngressCoord() end

---Get the mission holding coordinate if this was defined.
---@return COORDINATE # Coordinate Coordinate or nil.
function AUFTRAG:GetMissionHoldingCoord() end

---Get coordinate which was set as mission waypoint coordinate.
---@return COORDINATE # Coordinate where the mission is executed or `#nil`.
function AUFTRAG:_GetMissionWaypointCoordSet() end

---Get coordinate of target. First unit/group of the set is used.
---@param group? GROUP Group.
---@param randomradius? number Random radius in meters.
---@param surfacetypes? table Surface types of random zone.
---@return COORDINATE # Coordinate where the mission is executed.
function AUFTRAG:GetMissionWaypointCoord(group, randomradius, surfacetypes) end

---Set log ID string.
---@return AUFTRAG # self
function AUFTRAG:_SetLogID() end

---Get request ID from legion this mission requested assets from
---@param Legion? LEGION The legion from which to get the request ID.
---@return number # Request ID (if any).
function AUFTRAG:_GetRequestID(Legion) end

---Get request from legion this mission requested assets from.
---@param Legion? LEGION The legion from which to get the request ID.
---@return WAREHOUSE.PendingItem # Request.
function AUFTRAG:_GetRequest(Legion) end

---Set request ID from legion this mission requested assets from
---@param Legion? LEGION The legion from which to get the request ID.
---@param RequestID? number Request ID.
---@return AUFTRAG # self
function AUFTRAG:_SetRequestID(Legion, RequestID) end

---Check if reinforcement is done.
---@return boolean # If `true`, reinforcing is over.
function AUFTRAG:_IsNotReinforcing() end

---Check if reinforcement is still ongoing.
---@return boolean # If `true`, reinforcing is ongoing.
function AUFTRAG:_IsReinforcing() end

---Update mission F10 map marker.
---@return AUFTRAG # self
function AUFTRAG:UpdateMarker() end

---Get DCS task table for the given mission.
---@param MissionGroup? GROUP (Optional) Group that is supposed to carry out the mission. This might not exist when the AUFTRAG is created but only when the AUFTRAG is passed to a certain group.
---@return Task # The DCS task table. If multiple tasks are necessary, this is returned as a combo task.
function AUFTRAG:GetDCSMissionTask(MissionGroup) end

---Get DCS task table for an attack group or unit task.
---@param Target? TARGET Target data.
---@param DCStasks? table DCS DCS tasks table to which the task is added.
---@return Task # The DCS task table.
function AUFTRAG:_GetDCSAttackTask(Target, DCStasks) end

---Get DCS task table for an attack group or unit task.
---@param MissionType? string Mission (AUFTAG) type.
---@return string # DCS mission task for the auftrag type.
function AUFTRAG:GetMissionTaskforMissionType(MissionType) end

---Checks if a mission type is contained in a table of possible types.
---@param MissionType? string The requested mission type.
---@param PossibleTypes? table A table with possible mission types.
---@return boolean # If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionType(MissionType, PossibleTypes) end

---Check if a mission type is contained in a list of possible capabilities.
---@param MissionTypes? table The requested mission type. Can also be passed as a single mission type `#string`.
---@param Capabilities? table A table with possible capabilities `Ops.Auftrag#AUFTRAG.Capability`.
---@param All? boolean If `true`, given mission type must be includedin ALL capabilities. If `false` or `nil`, it must only match one.
---@return boolean # If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionCapability(MissionTypes, Capabilities, All) end

---Check if a mission type is contained in a list of possible capabilities.
---@param MissionTypes? table The requested mission type. Can also be passed as a single mission type `#string`.
---@param Capabilities? table A table with possible capabilities `Ops.Auftrag#AUFTRAG.Capability`.
---@return boolean # If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionCapabilityAny(MissionTypes, Capabilities) end

---Check if a mission type is contained in a list of possible capabilities.
---@param MissionTypes? table The requested mission type. Can also be passed as a single mission type `#string`.
---@param Capabilities? table A table with possible capabilities `Ops.Auftrag#AUFTRAG.Capability`.
---@return boolean # If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionCapabilityAll(MissionTypes, Capabilities) end

---Triggers the FSM event "Status".
function AUFTRAG:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Status(delay) end

---Triggers the FSM event "Stop".
function AUFTRAG:Stop() end

---Triggers the FSM event "Stop" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Stop(delay) end

---Triggers the FSM event "Planned".
function AUFTRAG:Planned() end

---Triggers the FSM event "Planned" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Planned(delay) end

---On after "Planned" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterPlanned(From, Event, To) end

---Triggers the FSM event "Queued".
function AUFTRAG:Queued() end

---Triggers the FSM event "Queued" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Queued(delay) end

---On after "Queued" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterQueued(From, Event, To) end

---Triggers the FSM event "Requested".
function AUFTRAG:Requested() end

---Triggers the FSM event "Requested" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Requested(delay) end

---On after "Requested" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterRequested(From, Event, To) end

---Triggers the FSM event "Scheduled".
function AUFTRAG:Scheduled() end

---Triggers the FSM event "Scheduled" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Scheduled(delay) end

---On after "Scheduled" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterScheduled(From, Event, To) end

---Triggers the FSM event "Started".
function AUFTRAG:Started() end

---Triggers the FSM event "Started" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Started(delay) end

---On after "Started" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterStarted(From, Event, To) end

---Triggers the FSM event "Executing".
function AUFTRAG:Executing() end

---Triggers the FSM event "Executing" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Executing(delay) end

---On after "Executing" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterExecuting(From, Event, To) end

---Triggers the FSM event "Cancel".
function AUFTRAG:Cancel() end

---Triggers the FSM event "Cancel" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Cancel(delay) end

---On after "Cancel" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterCancel(From, Event, To) end

---Triggers the FSM event "Done".
function AUFTRAG:Done() end

---Triggers the FSM event "Done" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Done(delay) end

---On after "Done" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterDone(From, Event, To) end

---Triggers the FSM event "Success".
function AUFTRAG:Success() end

---Triggers the FSM event "Success" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Success(delay) end

---On after "Success" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterSuccess(From, Event, To) end

---Triggers the FSM event "Failed".
function AUFTRAG:Failed() end

---Triggers the FSM event "Failed" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Failed(delay) end

---On after "Failed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterFailed(From, Event, To) end

---Triggers the FSM event "Repeat".
function AUFTRAG:Repeat() end

---Triggers the FSM event "Repeat" after a delay.
---@param delay? number Delay in seconds.
function AUFTRAG:__Repeat(delay) end

---On after "Repeat" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AUFTRAG:OnAfterRepeat(From, Event, To) end
