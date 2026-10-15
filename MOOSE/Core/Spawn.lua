---@meta

---@class SPAWN.SpawnZoneTable

---SPAWN Class
---@class SPAWN : BASE
---@field SpawnTemplatePrefix string
---@field SpawnAliasPrefix string
---@field AliveUnits number
---@field MaxAliveUnits number
---@field SpawnIndex number
---@field MaxAliveGroups number
---@field SpawnZoneTable SPAWN.SpawnZoneTable
SPAWN = {
  ClassName = "SPAWN",
  SpawnTemplatePrefix = nil,
  SpawnAliasPrefix = nil,
}

---Enumerator for spawns at airbases
---@class SPAWN.Takeoff
---@field Air number Take off happens in air.
---@field Runway number Spawn on runway. Does not work in MP!
---@field Hot number Spawn at parking with engines on.
---@field Cold number Spawn at parking with engines off.
SPAWN.Takeoff = {
  Air = 1,
  Runway = 2,
  Hot = 3,
  Cold = 4,
}

---Creates the main object to spawn a {Wrapper.Group} defined in the DCS ME.
---@param SpawnTemplatePrefix? string is the name of the Group in the ME that defines the Template.  Each new group will have the name starting with SpawnTemplatePrefix.
---@return SPAWN
function SPAWN:New(SpawnTemplatePrefix) end

---Creates a new SPAWN instance to create new groups based on the defined template and using a new alias for each new group.
---@param SpawnTemplatePrefix? string is the name of the Group in the ME that defines the Template.
---@param SpawnAliasPrefix? string is the name that will be given to the Group at runtime.
---@return SPAWN # self
function SPAWN:NewWithAlias(SpawnTemplatePrefix, SpawnAliasPrefix) end

---Creates a new SPAWN instance to create new groups based on the provided template. This will also register the template for future use.
---@param SpawnTemplate? table is the Template of the Group. This must be a valid Group Template structure - see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_func_addGroup)!
---@param SpawnTemplatePrefix? string [Mandatory] is the name of the template and the prefix of the GROUP on spawn. The name in the template **will** be overwritten!
---@param SpawnAliasPrefix? string [Optional] is the prefix that will be given to the GROUP on spawn.
---@param NoMooseNamingPostfix? boolean [Optional] If true, skip the Moose naming additions (like groupname#001-01) - **but** you need to ensure yourself no duplicate group names exist!
---@return SPAWN # self
function SPAWN:NewFromTemplate(SpawnTemplate, SpawnTemplatePrefix, SpawnAliasPrefix, NoMooseNamingPostfix) end

---Stops any more repeat spawns from happening once the UNIT count of Alive units, spawned by the same SPAWN object, exceeds the first parameter. Also can stop spawns from happening once a total GROUP still alive is met.
---Exceptionally powerful when combined with SpawnSchedule for Respawning.
---Note that this method is exceptionally important to balance the performance of the mission. Depending on the machine etc, a mission can only process a maximum amount of units.
---If the time interval must be short, but there should not be more Units or Groups alive than a maximum amount of units, then this method should be used...
---When a {#SPAWN.New} is executed and the limit of the amount of units alive is reached, then no new spawn will happen of the group, until some of these units of the spawn object will be destroyed.
---@param SpawnMaxUnitsAlive? number The maximum amount of units that can be alive at runtime.
---@param SpawnMaxGroups? number The maximum amount of groups that can be spawned. When the limit is reached, then no more actual spawns will happen of the group. This parameter is useful to define a maximum amount of airplanes, ground troops, helicopters, ships etc within a supply area. This parameter accepts the value 0, which defines that there are no maximum group limits, but there are limits on the maximum of units that can be alive at the same time.
---@return SPAWN # self
function SPAWN:InitLimit(SpawnMaxUnitsAlive, SpawnMaxGroups) end

---Keeps the unit names as defined within the mission editor,
---but note that anything after a # mark is ignored,
---and any spaces before and after the resulting name are removed.
---IMPORTANT! This method MUST be the first used after :New !!!
---@param KeepUnitNames? boolean (optional) If true, the unit names are kept, false or not provided create new unit names.
---@return SPAWN # self
function SPAWN:InitKeepUnitNames(KeepUnitNames) end

---Flags that the spawned groups must be spawned late activated.
---@param LateActivated? boolean (optional) If true, the spawned groups are late activated.
---@return SPAWN # self
function SPAWN:InitLateActivated(LateActivated) end

---Set spawns to happen at a particular airbase. Only for aircraft, of course.
---@param AirbaseName? string Name of the airbase.
---@param Takeoff? number (Optional) Takeoff type. Can be SPAWN.Takeoff.Hot (default), SPAWN.Takeoff.Cold or SPAWN.Takeoff.Runway.
---@param TerminalType? number (Optional) The terminal type.
---@return SPAWN # self
function SPAWN:InitAirbase(AirbaseName, Takeoff, TerminalType) end

---Defines the Heading for the new spawned units.
---The heading can be given as one fixed degree, or can be randomized between minimum and maximum degrees.
---@param HeadingMin? number The minimum or fixed heading in degrees.
---@param HeadingMax? number (optional) The maximum heading in degrees. This there is no maximum heading, then the heading will be fixed for all units using minimum heading.
---@return SPAWN # self
function SPAWN:InitHeading(HeadingMin, HeadingMax) end

---Defines the heading of the overall formation of the new spawned group.
---The heading can be given as one fixed degree, or can be randomized between minimum and maximum degrees.
---The Group's formation as laid out in its template will be rotated around the first unit in the group
---Group individual units facings will rotate to match.  If InitHeading is also applied to this SPAWN then that will take precedence for individual unit facings.
---Note that InitGroupHeading does *not* rotate the groups route; only its initial facing!
---@param HeadingMin? number The minimum or fixed heading in degrees.
---@param HeadingMax? number (optional) The maximum heading in degrees. This there is no maximum heading, then the heading for the group will be HeadingMin.
---@param unitVar? number (optional) Individual units within the group will have their heading randomized by +/- unitVar degrees.  Default is zero.
---@return SPAWN # self
function SPAWN:InitGroupHeading(HeadingMin, HeadingMax, unitVar) end

---Sets the coalition of the spawned group. Note that it might be necessary to also set the country explicitly!
---@param Coalition? coalition.side|number|string Coalition of the group as number of enumerator: * @{DCS#coalition.side.NEUTRAL} * @{DCS#coalition.side.RED} * @{DCS#coalition.side.BLUE}
---@return SPAWN # self
function SPAWN:InitCoalition(Coalition) end

---Sets the country of the spawn group. Note that the country determines the coalition of the group depending on which country is defined to be on which side for each specific mission!
---@param Country? number Country id as number or enumerator: * @{DCS#country.id.RUSSIA} * @{DCS#country.id.USA}
---@return SPAWN # self
function SPAWN:InitCountry(Country) end

---Sets category ID of the group.
---@param Category? any Category id.
---@return SPAWN # self
function SPAWN:InitCategory(Category) end

---Sets livery of the group.
---@param Livery? string Livery name. Note that this is not necessarily the same name as displayed in the mission editor.
---@return SPAWN # self
function SPAWN:InitLivery(Livery) end

---Sets skill of the group.
---@param Skill? string Skill, possible values "Average", "Good", "High", "Excellent" or "Random".
---@return SPAWN # self
function SPAWN:InitSkill(Skill) end

---[Airplane - F15/16/18/AWACS/B1B/Tanker only] Set the STN Link16 starting number of the Group; each unit of the spawned group will have a consecutive STN set.
---@param Octal? number The octal number (digits 0..7, max 5 digits, i.e. 1..77777, cannot be zero) to set the STN to. Every STN needs to be unique!
---@return SPAWN # self
function SPAWN:InitSTN(Octal) end

---[Airplane - A10-C II only] Set the SADL TN starting number of the Group; each unit of the spawned group will have a consecutive SADL set.
---@param Octal? number The octal number (digits 0..7, max 4 digits, i.e. 1..7777, cannot be zero) to set the SADL to. Every SADL needs to be unique!
---@return SPAWN # self
function SPAWN:InitSADL(Octal) end

---[Airplane] Set the initial speed on spawning in meters per second. Useful when spawning in-air only.
---@param MPS? number The speed in MPS to use.
---@return SPAWN # self
function SPAWN:InitSpeedMps(MPS) end

---[Airplane] Set the initial speed on spawning in knots. Useful when spawning in-air only.
---@param Knots? number The speed in knots to use.
---@return SPAWN # self
function SPAWN:InitSpeedKnots(Knots) end

---[Airplane] Set the initial speed on spawning in kilometers per hour. Useful when spawning in-air only.
---@param KPH? number The speed in KPH to use.
---@return SPAWN # self
function SPAWN:InitSpeedKph(KPH) end

---Sets the radio communication on or off. Same as checking/unchecking the COMM box in the mission editor.
---@param switch? number If true (or nil), enables the radio communication. If false, disables the radio for the spawned group.
---@return SPAWN # self
function SPAWN:InitRadioCommsOnOff(switch) end

---Sets the radio frequency of the group.
---@param frequency? number The frequency in MHz.
---@return SPAWN # self
function SPAWN:InitRadioFrequency(frequency) end

---Set radio modulation. Default is AM.
---@param modulation? string Either "FM" or "AM". If no value is given, modulation is set to AM.
---@return SPAWN # self
function SPAWN:InitRadioModulation(modulation) end

---Sets the modex of the first unit of the group. If more units are in the group, the number is increased by one with every unit.
---@param modex? number Modex of the first unit.
---@param prefix? string (optional) String to prefix to modex, e.g. for French AdA Modex, eg. -L-102 then "-L-" would be the prefix.
---@param postfix? string (optional) String to postfix to modex, example tbd.
---@return SPAWN # self
function SPAWN:InitModex(modex, prefix, postfix) end

---Randomizes the defined route of the SpawnTemplatePrefix group in the ME. This is very useful to define extra variation of the behavior of groups.
---@param SpawnStartPoint? number is the waypoint where the randomization begins. Note that the StartPoint = 0 equaling the point where the group is spawned.
---@param SpawnEndPoint? number is the waypoint where the randomization ends counting backwards. This parameter is useful to avoid randomization to end at a waypoint earlier than the last waypoint on the route.
---@param SpawnRadius? number is the radius in meters in which the randomization of the new waypoints, with the original waypoint of the original template located in the middle ...
---@param SpawnHeight? number (optional) Specifies the **additional** height in meters that can be added to the base height specified at each waypoint in the ME.
---@return SPAWN
function SPAWN:InitRandomizeRoute(SpawnStartPoint, SpawnEndPoint, SpawnRadius, SpawnHeight) end

---Randomizes the position of {Wrapper.Group}s that are spawned within a **radius band**, given an Outer and Inner radius, from the point that the spawn happens.
---@param RandomizePosition? boolean If true, SPAWN will perform the randomization of the @{Wrapper.Group}s position between a given outer and inner radius.
---@param OuterRadius? number (optional) The outer radius in meters where the new group will be spawned.
---@param InnerRadius? number (optional) The inner radius in meters where the new group will NOT be spawned.
---@return SPAWN
function SPAWN:InitRandomizePosition(RandomizePosition, OuterRadius, InnerRadius) end

---Randomizes the UNITs that are spawned within a radius band given an Outer and Inner radius.
---@param RandomizeUnits? boolean If true, SPAWN will perform the randomization of the @{Wrapper.Unit#UNIT}s position within the group between a given outer and inner radius.
---@param OuterRadius? number (optional) The outer radius in meters where the new group will be spawned.
---@param InnerRadius? number (optional) The inner radius in meters where the new group will NOT be spawned.
---@return SPAWN
function SPAWN:InitRandomizeUnits(RandomizeUnits, OuterRadius, InnerRadius) end

---Spawn the UNITs of this group with individual relative positions to unit #1 and individual headings.
---@param Positions? table Table of positions, needs to one entry per unit in the group(!). The table contains one table each for each unit, with x,y, and optionally z relative positions, and optionally an individual heading.
---@return SPAWN
function SPAWN:InitSetUnitRelativePositions(Positions) end

---Spawn the UNITs of this group with individual absolute positions and individual headings.
---@param Positions? table Table of positions, needs to one entry per unit in the group(!). The table contains one table each for each unit, with x,y, and optionally z absolute positions, and optionally an individual heading.
---@return SPAWN
function SPAWN:InitSetUnitAbsolutePositions(Positions) end

---Uses Disposition and other fallback logic to find better ground positions for ground units.
---NOTE: This is not a spawn randomizer.
---It will try to find clear ground locations avoiding trees, water, roads, runways, map scenery, statics and other units in the area.
---Maintains the original layout and unit positions as close as possible by searching for the next closest valid position to each unit.
---@param OnOff? boolean Enable/disable the feature.
---@param MaxRadius? number (Optional) Max radius to search for valid ground locations in meters. Default is double the max radius of the units.
---@param Spacing? number (Optional) Minimum spacing between units in meters. Default is 5% of the search radius or 5 meters, whichever is larger.
---@return SPAWN
function SPAWN:InitValidateAndRepositionGroundUnits(OnOff, MaxRadius, Spacing) end

---This method is rather complicated to understand. But I'll try to explain.
---This method becomes useful when you need to spawn groups with random templates of groups defined within the mission editor,
---but they will all follow the same Template route and have the same prefix name.
---In other words, this method randomizes between a defined set of groups the template to be used for each new spawn of a group.
---@param SpawnTemplatePrefixTable? string[] A table with the names of the groups defined within the mission editor, from which one will be chosen when a new group will be spawned.
---@return SPAWN
function SPAWN:InitRandomizeTemplate(SpawnTemplatePrefixTable) end

---Randomize templates to be used as the unit representatives for the Spawned group, defined using a SET_GROUP object.
---This method becomes useful when you need to spawn groups with random templates of groups defined within the mission editor,
---but they will all follow the same Template route and have the same prefix name.
---In other words, this method randomizes between a defined set of groups the template to be used for each new spawn of a group.
---@param SpawnTemplateSet? SET_GROUP A SET_GROUP object set, that contains the groups that are possible unit representatives of the group to be spawned.
---@param RandomizePositionInZone? boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN
function SPAWN:InitRandomizeTemplateSet(SpawnTemplateSet, RandomizePositionInZone) end

---Randomize templates to be used as the unit representatives for the Spawned group, defined by specifying the prefix names.
---This method becomes useful when you need to spawn groups with random templates of groups defined within the mission editor,
---but they will all follow the same Template route and have the same prefix name.
---In other words, this method randomizes between a defined set of groups the template to be used for each new spawn of a group.
---@param SpawnTemplatePrefixes? string A string or a list of string that contains the prefixes of the groups that are possible unit representatives of the group to be spawned.
---@param RandomizePositionInZone? boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN
function SPAWN:InitRandomizeTemplatePrefixes(SpawnTemplatePrefixes, RandomizePositionInZone) end

---When spawning a new group, make the grouping of the units according the InitGrouping setting.
---@param Grouping? number Indicates the maximum amount of units in the group.
---@return SPAWN
function SPAWN:InitGrouping(Grouping) end

---This method provides the functionality to randomize the spawning of the Groups at a given list of zones of different types.
---@param SpawnZoneTable? table A table with @{Core.Zone} objects. If this table is given, then each spawn will be executed within the given list of @{Core.Zone}s objects.
---@param RandomizePositionInZone? boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN # self
function SPAWN:InitRandomizeZones(SpawnZoneTable, RandomizePositionInZone) end

---[AIR/Fighter only!] This method randomizes the callsign for a new group.
---@return SPAWN # self
function SPAWN:InitRandomizeCallsign() end

---[BLUE AIR only!] This method sets a specific callsign for a spawned group. Use for a group with one unit only!
---@param ID? number ID of the callsign enumerator, e.g. CALLSIGN.Tanker.Texaco - - resulting in e.g. Texaco-2-1
---@param Name? string Name of this callsign as it cannot be determined from the ID because of the dependency on the task type of the plane, and the plane type. E.g. "Texaco"
---@param Minor? number Minor number, i.e. the unit number within the group, e.g 2 - resulting in e.g. Texaco-2-1
---@param Major? number Major number, i.e. the group number of this name, e.g. 1 - resulting in e.g. Texaco-2-1
---@return SPAWN # self
function SPAWN:InitCallSign(ID, Name, Minor, Major) end

---[RED AIR only!] This method sets a specific callsign for a spawned group.
---@param ID? number The number with which to start for the first unit, e.g. 100, further units would then be 101, 102 .. etc.
---@return SPAWN # self
function SPAWN:InitCallSignRed(ID) end

---This method sets a spawn position for the group that is different from the location of the template.
---@param Coordinate? COORDINATE The position to spawn from
---@return SPAWN # self
function SPAWN:InitPositionCoordinate(Coordinate) end

---This method sets a spawn position for the group that is different from the location of the template.
---@param Vec2? Vec2 The position to spawn from
---@return SPAWN # self
function SPAWN:InitPositionVec2(Vec2) end

---For planes and helicopters, when these groups go home and land on their home airbases and FARPs, they normally would taxi to the parking spot, shut-down their engines and wait forever until the Group is removed by the runtime environment.
---This method is used to re-spawn automatically (so no extra call is needed anymore) the same group after it has landed.
---This will enable a spawned group to be re-spawned after it lands, until it is destroyed...
---Note: When the group is respawned, it will re-spawn from the original airbase where it took off.
---So ensure that the routes for groups that respawn, always return to the original airbase, or players may get confused ...
---@return SPAWN # self
function SPAWN:InitRepeat() end

---Respawn group after landing.
---@param WaitingTime? number (Optional) Wait this many seconds before despawning the alive group after landing. Defaults to 3 .
---@return SPAWN # self
function SPAWN:InitRepeatOnLanding(WaitingTime) end

---Respawn after landing when its engines have shut down.
---@return SPAWN # self
function SPAWN:InitRepeatOnEngineShutDown() end

---Delete groups that have not moved for X seconds - AIR ONLY!!!
---DO NOT USE ON GROUPS THAT DO NOT MOVE OR YOUR SERVER WILL BURN IN HELL (Pikes - April 2020)
---When groups are still alive and have become inactive due to damage and are unable to contribute anything, then this group will be removed at defined intervals in seconds.
---@param SpawnCleanUpInterval? string The interval to check for inactive groups within seconds.
---@return SPAWN # self
function SPAWN:InitCleanUp(SpawnCleanUpInterval) end

---Makes the groups visible before start (like a battalion).
---The method will take the position of the group as the first position in the array.
---CAUTION: this directive will NOT work with OnSpawnGroup function.
---@param SpawnAngle? number The angle in degrees how the groups and each unit of the group will be positioned.
---@param SpawnWidth? number The amount of Groups that will be positioned on the X axis.
---@param SpawnDeltaX? number The space between each Group on the X-axis.
---@param SpawnDeltaY? number The space between each Group on the Y-axis.
---@return SPAWN # self
function SPAWN:InitArray(SpawnAngle, SpawnWidth, SpawnDeltaX, SpawnDeltaY) end

---Stop the SPAWN InitRepeat function (EVENT handler for takeoff, land and engine shutdown)
---@return SPAWN # self
function SPAWN:StopRepeat() end

---Turns the AI On or Off for the {Wrapper.Group} when spawning.
---@param AIOnOff? boolean A value of true sets the AI On, a value of false sets the AI Off.
---@return SPAWN # The SPAWN object
function SPAWN:InitAIOnOff(AIOnOff) end

---Turns the AI On for the {Wrapper.Group} when spawning.
---@return SPAWN # The SPAWN object
function SPAWN:InitAIOn() end

---Turns the AI Off for the {Wrapper.Group} when spawning.
---@return SPAWN # The SPAWN object
function SPAWN:InitAIOff() end

---Turns the Delay On or Off for the first {Wrapper.Group} scheduled spawning.
---The default value is that for scheduled spawning, there is an initial delay when spawning the first {Wrapper.Group}.
---@param DelayOnOff? boolean A value of true sets the Delay On, a value of false sets the Delay Off.
---@return SPAWN # The SPAWN object
function SPAWN:InitDelayOnOff(DelayOnOff) end

---Turns the Delay On for the {Wrapper.Group} when spawning with {#SpawnScheduled}(). In effect then the 1st group will only be spawned
---after the number of seconds given in SpawnScheduled as arguments, and not immediately.
---@return SPAWN # The SPAWN object
function SPAWN:InitDelayOn() end

---Turns the Delay Off for the {Wrapper.Group} when spawning.
---@return SPAWN # The SPAWN object
function SPAWN:InitDelayOff() end

---Hide the group on the map view (visible to game master slots!).
---@param OnOff? boolean Defaults to true
---@return SPAWN # The SPAWN object
function SPAWN:InitHiddenOnMap(OnOff) end

---Hide the group on MFDs (visible to game master slots!).
---@return SPAWN # The SPAWN object
function SPAWN:InitHiddenOnMFD() end

---Hide the group on planner (visible to game master slots!).
---@return SPAWN # The SPAWN object
function SPAWN:InitHiddenOnPlanner() end

---Will spawn a group based on the internal index.
---Note: This method uses the global _DATABASE object (an instance of {Core.Database#DATABASE}), which contains ALL initial and new spawned objects in MOOSE.
---@return GROUP # The group that was spawned. You can use this group for further actions.
function SPAWN:Spawn() end

---Will re-spawn a group based on a given index.
---Note: This method uses the global _DATABASE object (an instance of {Core.Database#DATABASE}), which contains ALL initial and new spawned objects in MOOSE.
---@param SpawnIndex? string The index of the group to be spawned.
---@return GROUP # The group that was spawned. You can use this group for further actions.
function SPAWN:ReSpawn(SpawnIndex) end

---Set the spawn index to a specified index number.
---This method can be used to "reset" the spawn counter to a specific index number.
---This will actually enable a respawn of groups from the specific index.
---@param SpawnIndex? string (Optional) The index of the group from where the spawning will start again. The default value would be 0, which means a complete reset of the spawnindex.
---@return SPAWN # self
function SPAWN:SetSpawnIndex(SpawnIndex) end

---Will spawn a group with a specified index number.
---Note: This method uses the global _DATABASE object (an instance of {Core.Database#DATABASE}), which contains ALL initial and new spawned objects in MOOSE.
---@param SpawnIndex? string The index of the group to be spawned.
---@param NoBirth? any
---@return GROUP # The group that was spawned. You can use this group for further actions.
function SPAWN:SpawnWithIndex(SpawnIndex, NoBirth) end

---Spawns new groups at varying time intervals.
---This is useful if you want to have continuity within your missions of certain (AI) groups to be present (alive) within your missions.
---**WARNING** - Setting a very low SpawnTime heavily impacts your mission performance and CPU time, it is NOT useful to check the alive state of an object every split second! Be reasonable and stay at 15 seconds and above!
---@param SpawnTime? number The time interval defined in seconds between each new spawn of new groups.
---@param SpawnTimeVariation? number The variation to be applied on the defined time interval between each new spawn. The variation is a number between 0 and 1, representing the % of variation to be applied on the time interval.
---@param WithDelay? boolean Do not spawn the **first** group immediately, but delay the spawn as per the calculation below. Effectively the same as @{#InitDelayOn}().
---@return SPAWN # self
function SPAWN:SpawnScheduled(SpawnTime, SpawnTimeVariation, WithDelay) end

---Will re-start the spawning scheduler.
---Note: This method is only required to be called when the schedule was stopped.
---@return SPAWN
function SPAWN:SpawnScheduleStart() end

---Will stop the scheduled spawning scheduler.
---@return SPAWN
function SPAWN:SpawnScheduleStop() end

---Allows to place a CallFunction hook just before spawning the group to tweak the template.
---The provided method will be called just before a new group is spawned, including its given parameters.
---The first parameter of the BeforeTemplateSpawnFunc is the raw Template used to spawn the group, the second is the SpawnIndex.
---@param BeforeTemplateSpawnFunc? function The function to be called before the group spawns.
---@return SPAWN
function SPAWN:OnBeforeTemplateSpawnGroup(BeforeTemplateSpawnFunc) end

---Allows to place a CallFunction hook when a new group spawns.
---The provided method will be called when a new group is spawned, including its given parameters.
---The first parameter of the SpawnFunction is the {Wrapper.Group#GROUP} that was spawned.
---@param SpawnCallBackFunction? function The function to be called when a group spawns.
---@param ... any
---@return SPAWN
function SPAWN:OnSpawnGroup(SpawnCallBackFunction, ...) end

---Will spawn a group at an {Wrapper.Airbase}.
---This method is mostly advisable to be used if you want to simulate spawning units at an airbase.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---
---The {Wrapper.Airbase#AIRBASE} object must refer to a valid airbase known in the sim.
---You can use the following enumerations to search for the pre-defined airbases on the current known maps of DCS:
---
---  * {Wrapper.Airbase#AIRBASE.Caucasus}: The airbases on the Caucasus map.
---  * {Wrapper.Airbase#AIRBASE.Nevada}: The airbases on the Nevada (NTTR) map.
---  * {Wrapper.Airbase#AIRBASE.Normandy}: The airbases on the Normandy map.
---
---Use the method {Wrapper.Airbase#AIRBASE.FindByName}() to retrieve the airbase object.
---The known AIRBASE objects are automatically imported at mission start by MOOSE.
---Therefore, there isn't any New() constructor defined for AIRBASE objects.
---
---Ships and FARPs are added within the mission, and are therefore not known.
---For these AIRBASE objects, there isn't an {Wrapper.Airbase#AIRBASE} enumeration defined.
---You need to provide the **exact name** of the airbase as the parameter to the {Wrapper.Airbase#AIRBASE.FindByName}() method!
---@param SpawnAirbase? AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param Takeoff? SPAWN.Takeoff|number|string (optional) The location and takeoff method. Default is Hot.
---@param TakeoffAltitude? number (optional) The altitude above the ground.
---@param TerminalType? AIRBASE.TerminalType|number|string (optional) The terminal type the aircraft should be spawned at. See @{Wrapper.Airbase#AIRBASE.TerminalType}.
---@param EmergencyAirSpawn? boolean (optional) If true (default), groups are spawned in air if there is no parking spot at the airbase. If false, nothing is spawned if no parking spot is available.
---@param Parkingdata? table (optional) Table holding the coordinates and terminal ids for all units of the group. Spawning will be forced to happen at exactly these spots!
---@return GROUP # The group that was spawned or nil when nothing was spawned.
function SPAWN:SpawnAtAirbase(SpawnAirbase, Takeoff, TakeoffAltitude, TerminalType, EmergencyAirSpawn, Parkingdata) end

---Spawn a group on an {Wrapper.Airbase} at a specific parking spot.
---@param Airbase? AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param Spots? table Table of parking spot IDs. Note that these in general are different from the numbering in the mission editor!
---@param Takeoff? SPAWN.Takeoff|number|string (Optional) Takeoff type, i.e. either SPAWN.Takeoff.Cold or SPAWN.Takeoff.Hot. Default is Hot.
---@return GROUP # The group that was spawned or nil when nothing was spawned.
function SPAWN:SpawnAtParkingSpot(Airbase, Spots, Takeoff) end

---Will park a group at an {Wrapper.Airbase}.
---@param SpawnAirbase? AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param TerminalType? AIRBASE.TerminalType|number|string (optional) The terminal type the aircraft should be spawned at. See @{Wrapper.Airbase#AIRBASE.TerminalType}.
---@param Parkingdata? table (optional) Table holding the coordinates and terminal ids for all units of the group. Spawning will be forced to happen at exactily these spots!
---@param SpawnIndex? any
---@return nil # Nothing is returned!
function SPAWN:ParkAircraft(SpawnAirbase, TerminalType, Parkingdata, SpawnIndex) end

---Will park a group at an {Wrapper.Airbase}.
---This method is mostly advisable to be used if you want to simulate parking units at an airbase and be visible.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---
---All groups that are in the spawn collection and that are alive, and not in the air, are parked.
---
---The {Wrapper.Airbase#AIRBASE} object must refer to a valid airbase known in the sim.
---You can use the following enumerations to search for the pre-defined airbases on the current known maps of DCS:
---
---  * {Wrapper.Airbase#AIRBASE.Caucasus}: The airbases on the Caucasus map.
---  * {Wrapper.Airbase#AIRBASE.Nevada}: The airbases on the Nevada (NTTR) map.
---  * {Wrapper.Airbase#AIRBASE.Normandy}: The airbases on the Normandy map.
---
---Use the method {Wrapper.Airbase#AIRBASE.FindByName}() to retrieve the airbase object.
---The known AIRBASE objects are automatically imported at mission start by MOOSE.
---Therefore, there isn't any New() constructor defined for AIRBASE objects.
---
---Ships and FARPs are added within the mission, and are therefore not known.
---For these AIRBASE objects, there isn't an {Wrapper.Airbase#AIRBASE} enumeration defined.
---You need to provide the **exact name** of the airbase as the parameter to the {Wrapper.Airbase#AIRBASE.FindByName}() method!
---@param SpawnAirbase? AIRBASE The @{Wrapper.Airbase} where to spawn the group.
---@param TerminalType? AIRBASE.TerminalType|number|string (optional) The terminal type the aircraft should be spawned at. See @{Wrapper.Airbase#AIRBASE.TerminalType}.
---@param Parkingdata? table (optional) Table holding the coordinates and terminal ids for all units of the group. Spawning will be forced to happen at exactily these spots!
---@return nil # Nothing is returned!
function SPAWN:ParkAtAirbase(SpawnAirbase, TerminalType, Parkingdata) end

---Will spawn a group from a Vec3 in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning units in the air, like helicopters or airplanes.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---@param Vec3? Vec3 The Vec3 coordinates where to spawn the group.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromVec3(Vec3, SpawnIndex) end

---Will spawn a group from a Coordinate in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning units in the air, like helicopters or airplanes.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---@param Coordinate? Coordinate The Coordinate coordinates where to spawn the group.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromCoordinate(Coordinate, SpawnIndex) end

---Will spawn a group from a PointVec3 in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning units in the air, like helicopters or airplanes.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---@param PointVec3? COORDINATE The COORDINATE coordinates where to spawn the group.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromPointVec3(PointVec3, SpawnIndex) end

---Will spawn a group from a Vec2 in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning groups on the ground from air units, like vehicles.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---@param Vec2? Vec2 The Vec2 coordinates where to spawn the group.
---@param MinHeight? number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight? number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromVec2(Vec2, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a COORDINATE in 3D space.
---This method is mostly advisable to be used if you want to simulate spawning groups on the ground from air units, like vehicles.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---@param PointVec2? COORDINATE The coordinates where to spawn the group.
---@param MinHeight? number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight? number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromPointVec2(PointVec2, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a hosting unit. This method is mostly advisable to be used if you want to simulate spawning from air units, like helicopters, which are dropping infantry into a defined Landing Zone.
---Note that each point in the route assigned to the spawning group is reset to the point of the spawn.
---You can use the returned group to further define the route to be followed.
---@param HostUnit? UNIT The air or ground unit dropping or unloading the group.
---@param MinHeight? number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight? number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned.
---@return nil # Nothing was spawned.
function SPAWN:SpawnFromUnit(HostUnit, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a group from a hosting static. This method is mostly advisable to be used if you want to simulate spawning from buldings and structures (static buildings).
---You can use the returned group to further define the route to be followed.
---@param HostStatic? STATIC The static dropping or unloading the group.
---@param MinHeight? number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight? number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnFromStatic(HostStatic, MinHeight, MaxHeight, SpawnIndex) end

---Will spawn a Group within a given {Core.Zone}.
---The {Core.Zone} can be of any type derived from {Core.Zone#ZONE_BASE}.
---Once the {Wrapper.Group} is spawned within the zone, the {Wrapper.Group} will continue on its route.
---The **first waypoint** (where the group is spawned) is replaced with the zone location coordinates.
---@param Zone? ZONE The zone where the group is to be spawned.
---@param RandomizeGroup? boolean (optional) Randomization of the @{Wrapper.Group} position in the zone.
---@param MinHeight? number (optional) The minimum height to spawn an airborne group into the zone.
---@param MaxHeight? number (optional) The maximum height to spawn an airborne group into the zone.
---@param SpawnIndex? number (optional) The index which group to spawn within the given zone.
---@return GROUP # that was spawned or #nil if nothing was spawned.
function SPAWN:SpawnInZone(Zone, RandomizeGroup, MinHeight, MaxHeight, SpawnIndex) end

---(**AIR**) Will spawn a plane group in UnControlled or Controlled mode...
---This will be similar to the uncontrolled flag setting in the ME.
---You can use UnControlled mode to simulate planes startup and ready for take-off but aren't moving (yet).
---ReSpawn the plane in Controlled mode, and the plane will move...
---@param UnControlled? boolean true if UnControlled, false if Controlled.
---@return SPAWN # self
function SPAWN:InitUnControlled(UnControlled) end

---Get the Coordinate of the Group that is Late Activated as the template for the SPAWN object.
---@return COORDINATE # The Coordinate
function SPAWN:GetCoordinate() end

---Will return the SpawnGroupName either with with a specific count number or without any count.
---@param SpawnIndex? number Is the number of the Group that is to be spawned.
---@return string # SpawnGroupName
function SPAWN:SpawnGroupName(SpawnIndex) end

---Will find the first alive {Wrapper.Group} it has spawned, and return the alive {Wrapper.Group} object and the first Index where the first alive {Wrapper.Group} object has been found.
---@return any # #number The @{Wrapper.Group} object found, the new Index where the group was found.
---@return any # #nil When no group is found, #nil is returned.
function SPAWN:GetFirstAliveGroup() end

---Will find the next alive {Wrapper.Group} object from a given Index, and return a reference to the alive {Wrapper.Group} object and the next Index where the alive {Wrapper.Group} has been found.
---@param SpawnIndexStart? number A Index holding the start position to search from. This method can also be used to find the first alive @{Wrapper.Group} object from the given Index.
---@return any # #number The next alive @{Wrapper.Group} object found, the next Index where the next alive @{Wrapper.Group} object was found.
---@return any # #nil When no alive @{Wrapper.Group} object is found from the start Index position, #nil is returned.
function SPAWN:GetNextAliveGroup(SpawnIndexStart) end

---Will find the last alive {Wrapper.Group} object, and will return a reference to the last live {Wrapper.Group} object and the last Index where the last alive {Wrapper.Group} object has been found.
---@return any # #number The last alive @{Wrapper.Group} object found, the last Index where the last alive @{Wrapper.Group} object was found.
---@return any # #nil When no alive @{Wrapper.Group} object is found, #nil is returned.
function SPAWN:GetLastAliveGroup() end

---Get the group from an index.
---Returns the group from the SpawnGroups list.
---If no index is given, it will return the first group in the list.
---@param SpawnIndex? number The index of the group to return.
---@return GROUP # self
function SPAWN:GetGroupFromIndex(SpawnIndex) end

---Return the prefix of a SpawnUnit.
---The method will search for a #-mark, and will return the text before the #-mark.
---It will return nil of no prefix was found.
---@param SpawnGroup? GROUP The GROUP object.
---@return string # The prefix or #nil if nothing was found.
function SPAWN:_GetPrefixFromGroup(SpawnGroup) end

---Return the prefix of a spawned group.
---The method will search for a `#`-mark, and will return the text before the `#`-mark. It will return nil of no prefix was found.
---@param SpawnGroupName? string The name of the spawned group.
---@return string # The prefix or #nil if nothing was found.
function SPAWN:_GetPrefixFromGroupName(SpawnGroupName) end

---Get the index from a given group.
---The function will search the name of the group for a #, and will return the number behind the #-mark.
---@param SpawnGroup? any
function SPAWN:GetSpawnIndexFromGroup(SpawnGroup) end

---Return the last maximum index that can be used.
function SPAWN:_GetLastIndex() end

---Initalize the SpawnGroups collection.
---@param SpawnIndex? any
function SPAWN:_InitializeSpawnGroups(SpawnIndex) end

---Gets the CategoryID of the Group with the given SpawnPrefix
---@param SpawnPrefix? any
function SPAWN:_GetGroupCategoryID(SpawnPrefix) end

---Gets the CoalitionID of the Group with the given SpawnPrefix
---@param SpawnPrefix? any
function SPAWN:_GetGroupCoalitionID(SpawnPrefix) end

---Gets the CountryID of the Group with the given SpawnPrefix
---@param SpawnPrefix? any
function SPAWN:_GetGroupCountryID(SpawnPrefix) end

---Gets the Group Template from the ME environment definition.
---Note: This method uses the global _DATABASE object (an instance of {Core.Database#DATABASE}), which contains ALL initial and new spawned objects in MOOSE.
---@param SpawnTemplatePrefix? string
---@return any # self
function SPAWN:_GetTemplate(SpawnTemplatePrefix) end

---Prepares the new Group Template.
---@param SpawnTemplatePrefix? string
---@param SpawnIndex? number
---@return SPAWN # self
function SPAWN:_Prepare(SpawnTemplatePrefix, SpawnIndex) end

---Private method randomizing the routes.
---@param SpawnIndex? number The index of the group to be spawned.
---@return SPAWN
function SPAWN:_RandomizeRoute(SpawnIndex) end

---Private method that randomizes the template of the group.
---@param SpawnIndex? number
---@return SPAWN # self
function SPAWN:_RandomizeTemplate(SpawnIndex) end

---Private method that sets the DCS#Vec2 where the Group will be spawned.
---@param SpawnIndex? number
---@return SPAWN # self
function SPAWN:_SetInitialPosition(SpawnIndex) end

---Private method that randomizes the {Core.Zone}s where the Group will be spawned.
---@param SpawnIndex? number
---@param RandomizePositionInZone? boolean If nil or true, also the position inside the selected random zone will be randomized. Set to false to use the center of the zone.
---@return SPAWN # self
function SPAWN:_RandomizeZones(SpawnIndex, RandomizePositionInZone) end

---@param SpawnIndex? any
---@param SpawnRootX? any
---@param SpawnRootY? any
---@param SpawnX? any
---@param SpawnY? any
---@param SpawnAngle? any
function SPAWN:_TranslateRotate(SpawnIndex, SpawnRootX, SpawnRootY, SpawnX, SpawnY, SpawnAngle) end

---Get the next index of the groups to be spawned. This method is complicated, as it is used at several spaces.
---@param SpawnIndex? number Spawn index.
---@return number # self.SpawnIndex
function SPAWN:_GetSpawnIndex(SpawnIndex) end

---@param EventData? EVENTDATA
function SPAWN:_OnBirth(EventData) end

---@return number # count
function SPAWN:_CountAliveUnits() end

---@param EventData? EVENTDATA
function SPAWN:_OnDeadOrCrash(EventData) end

---Will detect AIR Units taking off... When the event takes place, the spawned Group is registered as airborne...
---This is needed to ensure that Re-SPAWNing only is done for landed AIR Groups.
---@param EventData? EVENTDATA
function SPAWN:_OnTakeOff(EventData) end

---Will detect AIR Units landing... When the event takes place, the spawned Group is registered as landed.
---This is needed to ensure that Re-SPAWNing is only done for landed AIR Groups.
---@param EventData? EVENTDATA
function SPAWN:_OnLand(EventData) end

---Will detect AIR Units shutting down their engines ...
---When the event takes place, and the method {#InitRepeatOnEngineShutDown} was called, the spawned Group will Re-SPAWN.
---But only when the Unit was registered to have landed.
---@param EventData? EVENTDATA
function SPAWN:_OnEngineShutDown(EventData) end

---This function is called automatically by the Spawning scheduler.
---It is the internal worker method SPAWNing new Groups on the defined time intervals.
function SPAWN:_Scheduler() end

---Schedules the CleanUp of Groups
---@return boolean # True = Continue Scheduler
function SPAWN:_SpawnCleanUpScheduler() end
