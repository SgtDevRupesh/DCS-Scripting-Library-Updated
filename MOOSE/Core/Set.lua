---@meta

---@class SET_DYNAMICCARGO.Filters
---@field Coalitions string
---@field Types string
---@field Countries string
---@field StaticPrefixes string
---@field Zones string

---@class SET_BASE.Filter
---@field Coalition table Coalitions
---@field Prefix table Prefixes.

---SET_BASE class.
---@class SET_BASE : BASE
---@field Filter table Table of filters.
---@field Set table Table of objects.
---@field Index table Table of indices.
---@field List table Unused table.
---@field CallScheduler SCHEDULER
---@field Filter SET_BASE.Filters Filters
---@field filterNoRegex boolean If true, FilterPrefix ignores special characters and evaluates plain string. Defaults to false.
---@field filterReplaceDash boolean If true then if filterNoRegex is false, replace dashes with regex pattern friendly pattern. Defaults to true
SET_BASE = {
  ClassName = "SET_BASE",
  Filter = {},
  Set = {},
  List = {},
  Index = {},
  Database = nil,
  CallScheduler = nil,
  FilterCoalitionNumbers = {
    [coalition.side.RED+1] = "red",
    [coalition.side.BLUE+1] = "blue",
    [coalition.side.NEUTRAL+1] = "neutral",
  },
  FilterMeta = {
    Coalitions = {
      ["red"] = coalition.side.RED,
      ["blue"] = coalition.side.BLUE,
      ["neutral"] = coalition.side.NEUTRAL,
      },
    },
  filterNoRegex=false,
  filterReplaceDash=true,
}

---Creates a new SET_BASE object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---@param Database? any
---@return SET_BASE
function SET_BASE:New(Database) end

---[Internal] Add a functional filter
---@param ConditionFunction? function If this function returns `true`, the object is added to the SET. The function needs to take a CONTROLLABLE object as first argument.
---@param ... any
---@return boolean # If true, at least one condition is true
function SET_BASE:FilterFunction(ConditionFunction, ...) end

---[Internal] Check if the condition functions returns true.
---@param Object? CONTROLLABLE The object to filter for
---@return boolean # If true, if **all** conditions are true
function SET_BASE:_EvalFilterFunctions(Object) end

---Clear the Objects in the Set.
---@param TriggerEvent? boolean If `true`, an event remove is triggered for each group that is removed from the set.
---@return SET_BASE # self
function SET_BASE:Clear(TriggerEvent) end

---Builds a set of objects of same coalitions.
---Possible current coalitions are red, blue and neutral.
---@param Coalitions? string Can take the following values: "red", "blue", "neutral" and coalition.side.RED, coalition.side.BLUE,coalition.side.NEUTRAL
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_BASE # self
function SET_BASE:FilterCoalitions(Coalitions, Clear) end

---Finds an {Core.Base#BASE} object based on the object Name.
---@param ObjectName? string
---@return BASE # The Object found.
function SET_BASE:_Find(ObjectName) end

---Compares string for FilterPrefix function.
---@param Name? string The Name of the object.
---@param Pattern? string The pattern that is contained in the Name.
---@param NoRegex? boolean (Optional) If `true`, special characters in the Name are interpreted as plain text and not regular expressions. Default is `self.filterNoregex`.
---@param ReplaceDash? boolean If `true`, dashes are not used as regex.
---@return boolean # Returns `true`, if the pattern is contained in the name and false otherwise.
function SET_BASE:_SearchPattern(Name, Pattern, NoRegex, ReplaceDash) end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_BASE # self
function SET_BASE:FilterSetRegex(NoRegex, ReplaceDash) end

---Gets the Set.
---@return SET_BASE # self
function SET_BASE:GetSet() end

---Gets a list of the Names of the Objects in the Set.
---@return table # Table of names.
function SET_BASE:GetSetNames() end

---Returns a table of the Objects in the Set.
---@return table # Table of objects.
function SET_BASE:GetSetObjects() end

---Removes a {Core.Base#BASE} object from the {Core.Set#SET_BASE} and derived classes, based on the Object Name.
---@param ObjectName? string
---@param NoTriggerEvent? boolean (Optional) When `true`, the :Remove() method will not trigger a **Removed** event.
function SET_BASE:Remove(ObjectName, NoTriggerEvent) end

---Adds a {Core.Base#BASE} object in the {Core.Set#SET_BASE}, using a given ObjectName as the index.
---@param ObjectName? string The name of the object.
---@param Object? BASE The object itself.
---@return BASE # The added BASE Object.
function SET_BASE:Add(ObjectName, Object) end

---Adds a {Core.Base#BASE} object in the {Core.Set#SET_BASE}, using the Object Name as the index.
---@param Object? OBJECT
---@return BASE # The added BASE Object.
function SET_BASE:AddObject(Object) end

---Sort the set by name.
---@return BASE # The added BASE Object.
function SET_BASE:SortByName() end

---Add a SET to this set.
---@param SetToAdd? SET_BASE Set to add.
---@return SET_BASE # self
function SET_BASE:AddSet(SetToAdd) end

---Get the *union* of two sets.
---@param SetB? SET_BASE Set *B*.
---@return SET_BASE # The union set, i.e. contains objects that are in set *A* **or** in set *B*.
function SET_BASE:GetSetUnion(SetB) end

---Get the *intersection* of this set, called *A*, and another set.
---@param SetB? SET_BASE Set other set, called *B*.
---@return SET_BASE # A set of objects that is included in set *A* **and** in set *B*.
function SET_BASE:GetSetIntersection(SetB) end

---Get the *complement* of two sets.
---@param SetB? SET_BASE Set other set, called *B*.
---@return SET_BASE # The set of objects that are in set *B* but **not** in this set *A*.
function SET_BASE:GetSetComplement(SetB) end

---Compare two sets.
---@param SetA? SET_BASE First set.
---@param SetB? SET_BASE Set to be merged into first set.
---@return SET_BASE # The set of objects that are included in SetA and SetB.
function SET_BASE:CompareSets(SetA, SetB) end

---Gets a {Core.Base#BASE} object from the {Core.Set#SET_BASE} and derived classes, based on the Object Name.
---@param ObjectName? string
---@return BASE
function SET_BASE:Get(ObjectName) end

---Gets the first object from the {Core.Set#SET_BASE} and derived classes.
---@return BASE
function SET_BASE:GetFirst() end

---Gets the last object from the {Core.Set#SET_BASE} and derived classes.
---@return BASE
function SET_BASE:GetLast() end

---Gets a random object from the {Core.Set#SET_BASE} and derived classes.
---@return BASE # or nil if none found or the SET is empty!
function SET_BASE:GetRandom() end

---Gets a random object from the {Core.Set#SET_BASE} and derived classes. A bit slower than {#SET_BASE.GetRandom}() but tries to ensure you get an object back if the SET is not empty.
---@return BASE # or nil if  the SET is empty!
function SET_BASE:GetRandomSurely() end

---Retrieves the amount of objects in the {Core.Set#SET_BASE} and derived classes.
---@return number # Count
function SET_BASE:Count() end

---Copies the Filter criteria from a given Set (for rebuilding a new Set based on an existing Set).
---@param BaseSet? SET_BASE
---@return SET_BASE
function SET_BASE:SetDatabase(BaseSet) end

---Define the SET iterator **"limit"**.
---@param Limit? number (Optional) Defines how many objects are evaluated of the set as part of the Some iterators. The default is 1.
---@return SET_BASE # self
function SET_BASE:SetSomeIteratorLimit(Limit) end

---Get the SET iterator **"limit"**.
---@return number # Defines how many objects are evaluated of the set as part of the Some iterators.
function SET_BASE:GetSomeIteratorLimit() end

---Get max threat level of all objects in the SET.
---@return number # Max threat level found.
function SET_BASE:GetThreatLevelMax() end

---Filters for the defined collection.
---@return SET_BASE # self
function SET_BASE:FilterOnce() end

---Clear all filters. You still need to apply :FilterOnce()
---@return SET_BASE # self
function SET_BASE:FilterClear() end

---Starts the filtering for the defined collection.
---@return SET_BASE # self
function SET_BASE:_FilterStart() end

---Starts the filtering of the Dead events for the collection.
---@return SET_BASE # self
function SET_BASE:FilterDeads() end

---Starts the filtering of the Crash events for the collection.
---@return SET_BASE # self
function SET_BASE:FilterCrashes() end

---Stops the filtering for the defined collection.
---@return SET_BASE # self
function SET_BASE:FilterStop() end

---Iterate the SET_BASE while identifying the nearest object in the set from a {Core.Point#COORDINATE}.
---@param Coordinate? COORDINATE A @{Core.Point#COORDINATE} object (but **not** a simple DCS#Vec2!) from where to evaluate the closest object in the set.
---@return BASE # The closest object.
function SET_BASE:FindNearestObjectFromPointVec2(Coordinate) end

---Handles the OnBirth event for the Set.
---@param Event? EVENTDATA
function SET_BASE:_EventOnBirth(Event) end

---Handles the OnDead or OnCrash event for alive units set.
---@param Event? EVENTDATA
function SET_BASE:_EventOnDeadOrCrash(Event) end

---Iterate the SET_BASE and derived classes and call an iterator function for the given SET_BASE, providing the Object for each element within the set and optional parameters.
---@param IteratorFunction? function The function that will be called.
---@param arg? table Arguments of the IteratorFunction.
---@param Set? SET_BASE (Optional) The set to use. Default self:GetSet().
---@param Function? function (Optional) A function returning a #boolean true/false. Only if true, the IteratorFunction is called.
---@param FunctionArguments? table (Optional) Function arguments.
---@return SET_BASE # self
function SET_BASE:ForEach(IteratorFunction, arg, Set, Function, FunctionArguments) end

---Iterate the SET_BASE and derived classes and call an iterator function for the given SET_BASE, providing the Object for each element within the set and optional parameters.
---@param IteratorFunction? function The function that will be called.
---@param arg? any
---@param Set? any
---@param Function? any
---@param FunctionArguments? any
---@return SET_BASE # self
function SET_BASE:ForSome(IteratorFunction, arg, Set, Function, FunctionArguments) end

---Decides whether to include the Object.
---@param Object? table
---@return SET_BASE # self
function SET_BASE:IsIncludeObject(Object) end

---Decides whether an object is in the SET
---@param Object? table
---@return boolean # `true` if object is in set and `false` otherwise.
function SET_BASE:IsInSet(Object) end

---Decides whether an object is **not** in the SET
---@param Object? table
---@return SET_BASE # self
function SET_BASE:IsNotInSet(Object) end

---Gets a string with all the object names.
---@return string # A string with the names of the objects.
function SET_BASE:GetObjectNames() end

---Checks whether all or optionally any objects is inside a given zone.
---@param Zone? ZONE The zone.
---@param Any? boolean If `true`, at least one object has to be inside the zone. If `false` or `nil`, all objects need to be in the zone.
---@return boolean # Retruns `true` if objects are in the zone and `false` otherwise.
function SET_BASE:IsInZone(Zone, Any) end

---Flushes the current SET_BASE contents in the log ... (for debugging reasons).
---@param MasterObject? BASE (Optional) The master object as a reference.
---@return string # A string with the names of the objects.
function SET_BASE:Flush(MasterObject) end

---Get a *new* set table that only contains alive objects.
---@return table # Set table of alive objects.
function SET_BASE:GetAliveSet() end

---@class SET_GROUP : SET_BASE
---@field ZoneTimer TIMER
---@field ZoneTimerInterval number
SET_GROUP = {
  ClassName = "SET_GROUP",
  Filter = {
    Coalitions = nil,
    Categories = nil,
    Countries = nil,
    GroupPrefixes = nil,
    Zones = nil,
    Functions = nil,
    Alive = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      plane = Group.Category.AIRPLANE,
      helicopter = Group.Category.HELICOPTER,
      ground = Group.Category.GROUND, -- R2.2
      ship = Group.Category.SHIP,
      structure = Group.Category.STRUCTURE,
    },
  },
}

---Creates a new SET_GROUP object, building a set of groups belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_GROUP
function SET_GROUP:New() end

---Get a *new* set table that only contains alive groups.
---@return table # Set of alive groups.
function SET_GROUP:GetAliveSet() end

---Returns a report of of unit types.
---@return REPORT # A report of the unit types found. The key is the UnitTypeName and the value is the amount of unit types found.
function SET_GROUP:GetUnitTypeNames() end

---Add a GROUP to SET_GROUP.
---Note that for each unit in the group that is set, a default cargo bay limit is initialized.
---@param group? GROUP The group which should be added to the set.
---@param DontSetCargoBayLimit? boolean If true, do not attempt to auto-add the cargo bay limit per unit in this group.
---@return SET_GROUP # self
function SET_GROUP:AddGroup(group, DontSetCargoBayLimit) end

---Add GROUP(s) to SET_GROUP.
---@param AddGroupNames? string A single name or an array of GROUP names.
---@return SET_GROUP # self
function SET_GROUP:AddGroupsByName(AddGroupNames) end

---Remove GROUP(s) from SET_GROUP.
---@param RemoveGroupNames? GROUP A single name or an array of GROUP names.
---@return SET_GROUP # self
function SET_GROUP:RemoveGroupsByName(RemoveGroupNames) end

---Finds a Group based on the Group Name.
---@param GroupName? string
---@return GROUP # The found Group.
function SET_GROUP:FindGroup(GroupName) end

---Iterate the SET_GROUP while identifying the nearest object from a {Core.Point#COORDINATE}.
---@param Coordinate? COORDINATE A @{Core.Point#COORDINATE} object from where to evaluate the closest object in the set.
---@return GROUP # The closest group.
function SET_GROUP:FindNearestGroupFromPointVec2(Coordinate) end

---Builds a set of groups in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_GROUP # self
function SET_GROUP:FilterZones(Zones, Clear) end

---Builds a set of groups out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---@param Categories? any Can take the following values: "plane", "helicopter", "ground", "ship".
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_GROUP # self
function SET_GROUP:FilterCategories(Categories, Clear) end

---Builds a set of groups out of ground category.
---@return SET_GROUP # self
function SET_GROUP:FilterCategoryGround() end

---Builds a set of groups out of airplane category.
---@return SET_GROUP # self
function SET_GROUP:FilterCategoryAirplane() end

---Builds a set of groups out of helicopter category.
---@return SET_GROUP # self
function SET_GROUP:FilterCategoryHelicopter() end

---Builds a set of groups out of ship category.
---@return SET_GROUP # self
function SET_GROUP:FilterCategoryShip() end

---Builds a set of groups out of structure category.
---@return SET_GROUP # self
function SET_GROUP:FilterCategoryStructure() end

---Builds a set of groups of defined countries.
---Possible current countries are those known within DCS world.
---@param Countries? string Can take those country strings known within DCS world.
---@return SET_GROUP # self
function SET_GROUP:FilterCountries(Countries) end

---Builds a set of groups that contain the given string in their group name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all groups that **contain** the string.
---@param Prefixes? string The string pattern(s) that needs to be contained in the group name. Can also be passed as a `#table` of strings.
---@return SET_GROUP # self
function SET_GROUP:FilterPrefixes(Prefixes) end

---[Internal] Private function for use of continous zone filter
---@return SET_GROUP # self
function SET_GROUP:_ContinousZoneFilter() end

---Builds a set of groups that are active, ie in the mission but not yet activated (false) or actived (true).
---Only the groups that are active will be included within the set.
---@param Active? boolean (Optional) Include only active groups to the set. Include inactive groups if you provide false.
---@return SET_GROUP # self
function SET_GROUP:FilterActive(Active) end

---Build a set of groups that are alive.
---@return SET_GROUP # self
function SET_GROUP:FilterAlive() end

---Starts the filtering.
---@return SET_GROUP # self
function SET_GROUP:FilterStart() end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---@param Seconds? number (Optional) Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Groups are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_GROUP # self
function SET_GROUP:FilterZoneTimer(Seconds) end

---Stops the filtering.
---@return SET_GROUP # self
function SET_GROUP:FilterStop() end

---Handles the OnDead or OnCrash event for alive groups set.
---Note: The GROUP object in the SET_GROUP collection will only be removed if the last unit is destroyed of the GROUP.
---@param Event? EVENTDATA
function SET_GROUP:_EventOnDeadOrCrash(Event) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the GROUP
---@return table # The GROUP
function SET_GROUP:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the GROUP
---@return table # The GROUP
function SET_GROUP:FindInDatabase(Event) end

---Iterate the SET_GROUP and call an iterator function for each GROUP object, providing the GROUP and optional parameters.
---@param IteratorFunction? function The function that will be called for all GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForEachGroup(IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for some GROUP objects, providing the GROUP and optional parameters.
---@param IteratorFunction? function The function that will be called for some GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForSomeGroup(IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP object, providing the GROUP and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForEachGroupAlive(IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for some **alive** GROUP objects, providing the GROUP and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForSomeGroupAlive(IteratorFunction, ...) end

---Activate late activated groups.
---@param Delay? number Delay in seconds.
---@return SET_GROUP # self
function SET_GROUP:Activate(Delay) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence completely in a {Core.Zone}, providing the GROUP and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForEachGroupCompletelyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence partly in a {Core.Zone}, providing the GROUP and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForEachGroupPartlyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence not in a {Core.Zone}, providing the GROUP and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForEachGroupNotInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and return true if all the {Wrapper.Group#GROUP} are completely in the {Core.Zone#ZONE}
---@param Zone? ZONE The Zone to be tested for.
---@return boolean # true if all the @{Wrapper.Group#GROUP} are completely in the @{Core.Zone#ZONE}, false otherwise
function SET_GROUP:AllCompletelyInZone(Zone) end

---Iterate the SET_GROUP and call an iterator function for each alive GROUP that has any unit in the {Core.Zone}, providing the GROUP and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... any
---@return SET_GROUP # self
function SET_GROUP:ForEachGroupAnyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and return true if at least one of the {Wrapper.Group#GROUP} is completely inside the {Core.Zone#ZONE}
---@param Zone? ZONE The Zone to be tested for.
---@return boolean # true if at least one of the @{Wrapper.Group#GROUP} is completely inside the @{Core.Zone#ZONE}, false otherwise.
function SET_GROUP:AnyCompletelyInZone(Zone) end

---Iterate the SET_GROUP and return true if at least one {#UNIT} of one {Wrapper.Group#GROUP} of the {#SET_GROUP} is in {Core.Zone}
---@param Zone? ZONE The Zone to be tested for.
---@return boolean # true if at least one of the @{Wrapper.Group#GROUP} is partly or completely inside the @{Core.Zone#ZONE}, false otherwise.
function SET_GROUP:AnyInZone(Zone) end

---Iterate the SET_GROUP and return true if at least one {Wrapper.Group#GROUP} of the {#SET_GROUP} is partly in {Core.Zone}.
---Will return false if a {Wrapper.Group#GROUP} is fully in the {Core.Zone}
---@param Zone? ZONE The Zone to be tested for.
---@return boolean # true if at least one of the @{Wrapper.Group#GROUP} is partly or completely inside the @{Core.Zone#ZONE}, false otherwise.
function SET_GROUP:AnyPartlyInZone(Zone) end

---Iterate the SET_GROUP and return true if no {Wrapper.Group#GROUP} of the {#SET_GROUP} is in {Core.Zone}
---This could also be achieved with `not SET_GROUP:AnyPartlyInZone(Zone)`, but it's easier for the
---mission designer to add a dedicated method
---@param Zone? ZONE The Zone to be tested for.
---@return boolean # true if no @{Wrapper.Group#GROUP} is inside the @{Core.Zone#ZONE} in any way, false otherwise.
function SET_GROUP:NoneInZone(Zone) end

---Iterate the SET_GROUP and count how many GROUPs are completely in the Zone
---That could easily be done with SET_GROUP:ForEachGroupCompletelyInZone(), but this function
---provides an easy to use shortcut...
---@param Zone? ZONE The Zone to be tested for.
---@return number # the number of GROUPs completely in the Zone
function SET_GROUP:CountInZone(Zone) end

---Iterate the SET_GROUP and count how many UNITs are completely in the Zone
---@param Zone? ZONE The Zone to be tested for.
---@return number # the number of GROUPs completely in the Zone
function SET_GROUP:CountUnitInZone(Zone) end

---Iterate the SET_GROUP and count how many GROUPs and UNITs are alive.
---@return number # The number of GROUPs alive.
---@return number # The number of UNITs alive.
function SET_GROUP:CountAlive() end

---@param MGroup? GROUP The group that is checked for inclusion.
---@return SET_GROUP # self
function SET_GROUP:IsIncludeObject(MGroup) end

---Get the closest group of the set with respect to a given reference coordinate. Optionally, only groups of given coalitions are considered in the search.
---@param Coordinate? COORDINATE Reference Coordinate from which the closest group is determined.
---@param Coalitions? table (Optional) Table of coalition #number entries to filter for.
---@return GROUP # The closest group (if any).
---@return number # Distance in meters to the closest group.
function SET_GROUP:GetClosestGroup(Coordinate, Coalitions) end

---Iterate the SET_GROUP and set for each unit the default cargo bay weight limit.
---Because within a group, the type of carriers can differ, each cargo bay weight limit is set on {Wrapper.Unit} level.
function SET_GROUP:SetCargoBayWeightLimit() end

---@class SET_UNIT : SET_BASE
---@field ZoneTimer TIMER
---@field ZoneTimerInterval number
SET_UNIT = {
  ClassName = "SET_UNIT",
  Units = {},
  Filter = {
    Coalitions = nil,
    Categories = nil,
    Types = nil,
    Countries = nil,
    UnitPrefixes = nil,
    Zones = nil,
    Functions = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      plane = Unit.Category.AIRPLANE,
      helicopter = Unit.Category.HELICOPTER,
      ground = Unit.Category.GROUND_UNIT,
      ship = Unit.Category.SHIP,
      structure = Unit.Category.STRUCTURE,
    },
  },
}

---Creates a new SET_UNIT object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_UNIT
function SET_UNIT:New() end

---Add UNIT(s) to SET_UNIT.
---@param Unit? UNIT A single UNIT.
---@return SET_UNIT # self
function SET_UNIT:AddUnit(Unit) end

---Add UNIT(s) to SET_UNIT.
---@param AddUnitNames? string A single name or an array of UNIT names.
---@return SET_UNIT # self
function SET_UNIT:AddUnitsByName(AddUnitNames) end

---Remove UNIT(s) from SET_UNIT.
---@param RemoveUnitNames? table A single name or an array of UNIT names.
---@return SET_UNIT # self
function SET_UNIT:RemoveUnitsByName(RemoveUnitNames) end

---Finds a Unit based on the Unit Name.
---@param UnitName? string
---@return UNIT # The found Unit.
function SET_UNIT:FindUnit(UnitName) end

---Builds a set of units out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---@param Categories? any Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_UNIT # self
function SET_UNIT:FilterCategories(Categories) end

---Builds a set of units of defined unit types.
---Possible current types are those types known within DCS world.
---@param Types? string Can take those type strings known within DCS world.
---@return SET_UNIT # self
function SET_UNIT:FilterTypes(Types) end

---Builds a set of units of defined countries.
---Possible current countries are those known within DCS world.
---@param Countries? string Can take those country strings known within DCS world.
---@return SET_UNIT # self
function SET_UNIT:FilterCountries(Countries) end

---Builds a set of UNITs that contain a given string in their unit name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all units that **contain** the string.
---@param Prefixes? string The string pattern(s) that needs to be contained in the unit name. Can also be passed as a `#table` of strings.
---@return SET_UNIT # self
function SET_UNIT:FilterPrefixes(Prefixes) end

---Builds a set of units in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_UNIT # self
function SET_UNIT:FilterZones(Zones) end

---Builds a set of units that are only active.
---Only the units that are active will be included within the set.
---@param Active? boolean (Optional) Include only active units to the set. Include inactive units if you provide false.
---@return SET_UNIT # self
function SET_UNIT:FilterActive(Active) end

---Builds a set of units which exist and are alive.
---@return SET_UNIT # self
function SET_UNIT:FilterAlive() end

---Builds a set of units which belong to groups with certain **group names**.
---@param Prefixes? string The (partial) group names to look for. Can be a single string or a table of strings.
---@return SET_UNIT # self
function SET_UNIT:FilterGroupPrefixes(Prefixes) end

---Builds a set of units having a radar of give types.
---All the units having a radar of a given type will be included within the set.
---@param RadarTypes? table The radar types.
---@return SET_UNIT # self
function SET_UNIT:FilterHasRadar(RadarTypes) end

---Builds a set of SEADable units.
---@return SET_UNIT # self
function SET_UNIT:FilterHasSEAD() end

---Iterate the SET_UNIT and count how many UNITs are alive.
---@return number # The number of UNITs alive.
function SET_UNIT:CountAlive() end

---Gets the alive set.
---@return table # Table of alive UNIT objects
---@return SET_UNIT # AliveSet
function SET_UNIT:GetAliveSet() end

---[Internal] Private function for use of continous zone filter
---@return SET_UNIT # self
function SET_UNIT:_ContinousZoneFilter() end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---@param Seconds? number (Optional) Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Groups are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_UNIT # self
function SET_UNIT:FilterZoneTimer(Seconds) end

---Stops the filtering.
---@return SET_UNIT # self
function SET_UNIT:FilterStop() end

---Starts the filtering.
---@return SET_UNIT # self
function SET_UNIT:FilterStart() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the UNIT
---@return table # The UNIT
function SET_UNIT:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the UNIT
---@return table # The UNIT
function SET_UNIT:FindInDatabase(Event) end

---Check if minimal one element of the SET_UNIT is in the Zone.
---@param ZoneTest? ZONE The Zone to be tested for.
---@return boolean
function SET_UNIT:IsPartiallyInZone(ZoneTest) end

---Check if no element of the SET_UNIT is in the Zone.
---@param Zone? ZONE The Zone to be tested for.
---@return boolean
function SET_UNIT:IsNotInZone(Zone) end

---Iterate the SET_UNIT and call an iterator function for each **alive** UNIT, providing the UNIT and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... any
---@return SET_UNIT # self
function SET_UNIT:ForEachUnit(IteratorFunction, ...) end

---Get the SET of the SET_UNIT **sorted per Threat Level**.
---@param FromThreatLevel? number The TreatLevel to start the evaluation **From** (this must be a value between 0 and 10).
---@param ToThreatLevel? number The TreatLevel to stop the evaluation **To** (this must be a value between 0 and 10).
---@return SET_UNIT # self
function SET_UNIT:GetSetPerThreatLevel(FromThreatLevel, ToThreatLevel) end

---Iterate the SET_UNIT **sorted *per Threat Level** and call an iterator function for each **alive** UNIT, providing the UNIT and optional parameters.
---@param FromThreatLevel? number The TreatLevel to start the evaluation **From** (this must be a value between 0 and 10).
---@param ToThreatLevel? number The TreatLevel to stop the evaluation **To** (this must be a value between 0 and 10).
---@param IteratorFunction? function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... any
---@return SET_UNIT # self
function SET_UNIT:ForEachUnitPerThreatLevel(FromThreatLevel, ToThreatLevel, IteratorFunction, ...) end

---Iterate the SET_UNIT and call an iterator function for each **alive** UNIT presence completely in a {Core.Zone}, providing the UNIT and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... any
---@return SET_UNIT # self
function SET_UNIT:ForEachUnitCompletelyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_UNIT and call an iterator function for each **alive** UNIT presence not in a {Core.Zone}, providing the UNIT and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... any
---@return SET_UNIT # self
function SET_UNIT:ForEachUnitNotInZone(ZoneObject, IteratorFunction, ...) end

---Returns map of unit types.
---@return any # A map of the unit types found. The key is the UnitTypeName and the value is the amount of unit types found.
function SET_UNIT:GetUnitTypes() end

---Returns a comma separated string of the unit types with a count in the  {Core.Set}.
---@return string # The unit types string
function SET_UNIT:GetUnitTypesText() end

---Returns map of unit threat levels.
---@return table.
function SET_UNIT:GetUnitThreatLevels() end

---Calculate the maximum A2G threat level of the SET_UNIT.
---@return number # The maximum threat level
function SET_UNIT:CalculateThreatLevelA2G() end

---Get the center coordinate of the SET_UNIT.
---@return COORDINATE # The center coordinate of all the units in the set, including heading in degrees and speed in mps in case of moving units.
function SET_UNIT:GetCoordinate() end

---Get the maximum velocity of the SET_UNIT.
---@return number # The speed in mps in case of moving units.
function SET_UNIT:GetVelocity() end

---Get the average heading of the SET_UNIT.
---@return number # Heading Heading in degrees and speed in mps in case of moving units.
function SET_UNIT:GetHeading() end

---Returns if the {Core.Set} has targets having a radar (of a given type).
---@param RadarType? Unit.RadarType|number|string
---@return number # The amount of radars in the Set with the given type
function SET_UNIT:HasRadar(RadarType) end

---Returns if the {Core.Set} has targets that can be SEADed.
---@return number # The amount of SEADable units in the Set
function SET_UNIT:HasSEAD() end

---Returns if the {Core.Set} has ground targets.
---@return number # The amount of ground targets in the Set.
function SET_UNIT:HasGroundUnits() end

---Returns if the {Core.Set} has air targets.
---@return number # The amount of air targets in the Set.
function SET_UNIT:HasAirUnits() end

---Returns if the {Core.Set} has friendly ground units.
---@param FriendlyCoalition? any
---@return number # The amount of ground targets in the Set.
function SET_UNIT:HasFriendlyUnits(FriendlyCoalition) end

---@param MUnit? UNIT
---@return SET_UNIT # self
function SET_UNIT:IsIncludeObject(MUnit) end

---Retrieve the type names of the {Wrapper.Unit}s in the SET, delimited by an optional delimiter.
---@param Delimiter? string (Optional) The delimiter, which is default a comma.
---@return string # The types of the @{Wrapper.Unit}s delimited.
function SET_UNIT:GetTypeNames(Delimiter) end

---Iterate the SET_UNIT and set for each unit the default cargo bay weight limit.
function SET_UNIT:SetCargoBayWeightLimit() end

---@class SET_STATIC : SET_BASE
SET_STATIC = {
  ClassName = "SET_STATIC",
  Statics = {},
  Filter = {
    Coalitions = nil,
    Categories = nil,
    Types = nil,
    Countries = nil,
    StaticPrefixes = nil,
    Zones = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      plane = Unit.Category.AIRPLANE,
      helicopter = Unit.Category.HELICOPTER,
      ground = Unit.Category.GROUND_STATIC,
      ship = Unit.Category.SHIP,
      structure = Unit.Category.STRUCTURE,
    },
  },
}

---Creates a new SET_STATIC object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_STATIC
function SET_STATIC:New() end

---Add STATIC(s) to SET_STATIC.
---@param AddStatic? STATIC A single STATIC.
---@return SET_STATIC # self
function SET_STATIC:AddStatic(AddStatic) end

---Add STATIC(s) to SET_STATIC.
---@param AddStaticNames? string A single name or an array of STATIC names.
---@return SET_STATIC # self
function SET_STATIC:AddStaticsByName(AddStaticNames) end

---Remove STATIC(s) from SET_STATIC.
---@param RemoveStaticNames? STATIC A single name or an array of STATIC names.
---@return self
function SET_STATIC:RemoveStaticsByName(RemoveStaticNames) end

---Finds a Static based on the Static Name.
---@param StaticName? string
---@return STATIC # The found Static.
function SET_STATIC:FindStatic(StaticName) end

---Builds a set of statics in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_STATIC # self
function SET_STATIC:FilterZones(Zones) end

---Builds a set of units out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---@param Categories? any Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_STATIC # self
function SET_STATIC:FilterCategories(Categories) end

---Builds a set of units of defined unit types.
---Possible current types are those types known within DCS world.
---@param Types? string Can take those type strings known within DCS world.
---@return SET_STATIC # self
function SET_STATIC:FilterTypes(Types) end

---Builds a set of units of defined countries.
---Possible current countries are those known within DCS world.
---@param Countries? string Can take those country strings known within DCS world.
---@return SET_STATIC # self
function SET_STATIC:FilterCountries(Countries) end

---Builds a set of STATICs that contain the given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all statics that **contain** the string.
---@param Prefixes? string The string pattern(s) that need to be contained in the static name. Can also be passed as a `#table` of strings.
---@return SET_STATIC # self
function SET_STATIC:FilterPrefixes(Prefixes) end

---Starts the filtering.
---@return SET_STATIC # self
function SET_STATIC:FilterStart() end

---Iterate the SET_STATIC and count how many STATICSs are alive.
---@return number # The number of UNITs alive.
function SET_STATIC:CountAlive() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the STATIC
---@return table # The STATIC
function SET_STATIC:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the STATIC
---@return table # The STATIC
function SET_STATIC:FindInDatabase(Event) end

---Check if minimal one element of the SET_STATIC is in the Zone.
---@param Zone? ZONE The Zone to be tested for.
---@return boolean
function SET_STATIC:IsPartiallyInZone(Zone) end

---Check if no element of the SET_STATIC is in the Zone.
---@param Zone? ZONE The Zone to be tested for.
---@return boolean
function SET_STATIC:IsNotInZone(Zone) end

---Check if minimal one element of the SET_STATIC is in the Zone.
---@param IteratorFunction? function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... any
---@return SET_STATIC # self
function SET_STATIC:ForEachStaticInZone(IteratorFunction, ...) end

---Iterate the SET_STATIC and call an iterator function for each **alive** STATIC, providing the STATIC and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... any
---@return SET_STATIC # self
function SET_STATIC:ForEachStatic(IteratorFunction, ...) end

---Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence completely in a {Core.Zone}, providing the STATIC and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... any
---@return SET_STATIC # self
function SET_STATIC:ForEachStaticCompletelyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence not in a {Core.Zone}, providing the STATIC and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... any
---@return SET_STATIC # self
function SET_STATIC:ForEachStaticNotInZone(ZoneObject, IteratorFunction, ...) end

---Returns map of unit types.
---@return any # A map of the unit types found. The key is the StaticTypeName and the value is the amount of unit types found.
function SET_STATIC:GetStaticTypes() end

---Returns a comma separated string of the unit types with a count in the  {Core.Set}.
---@return string # The unit types string
function SET_STATIC:GetStaticTypesText() end

---Get the center coordinate of the SET_STATIC.
---@return COORDINATE # The center coordinate of all the units in the set, including heading in degrees and speed in mps in case of moving units.
function SET_STATIC:GetCoordinate() end

---Get the maximum velocity of the SET_STATIC.
---@return number # The speed in mps in case of moving units.
function SET_STATIC:GetVelocity() end

---Get the average heading of the SET_STATIC.
---@return number # Heading Heading in degrees and speed in mps in case of moving units.
function SET_STATIC:GetHeading() end

---Calculate the maximum A2G threat level of the SET_STATIC.
---@return number # The maximum threatlevel
function SET_STATIC:CalculateThreatLevelA2G() end

---@param MStatic? STATIC
---@return SET_STATIC # self
function SET_STATIC:IsIncludeObject(MStatic) end

---Retrieve the type names of the {Wrapper.Static}s in the SET, delimited by an optional delimiter.
---@param Delimiter? string (Optional) The delimiter, which is default a comma.
---@return string # The types of the @{Wrapper.Static}s delimited.
function SET_STATIC:GetTypeNames(Delimiter) end

---Get the closest static of the set with respect to a given reference coordinate. Optionally, only statics of given coalitions are considered in the search.
---@param Coordinate? COORDINATE Reference Coordinate from which the closest static is determined.
---@param Coalitions? any
---@return STATIC # The closest static (if any).
---@return number # Distance in meters to the closest static.
function SET_STATIC:GetClosestStatic(Coordinate, Coalitions) end

---@class SET_CLIENT : SET_BASE
---@field ZoneTimer TIMER
---@field ZoneTimerInterval number
SET_CLIENT = {
  ClassName = "SET_CLIENT",
  Clients = {},
  Filter = {
    Coalitions = nil,
    Categories = nil,
    Types = nil,
    Countries = nil,
    ClientPrefixes = nil,
    Zones = nil,
    Playernames = nil,
    Callsigns = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      plane = Unit.Category.AIRPLANE,
      helicopter = Unit.Category.HELICOPTER,
      ground = Unit.Category.GROUND_UNIT,
      ship = Unit.Category.SHIP,
      structure = Unit.Category.STRUCTURE,
    },
  },
}

---Creates a new SET_CLIENT object, building a set of clients belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_CLIENT
function SET_CLIENT:New() end

---Add CLIENT(s) to SET_CLIENT.
---@param AddClientNames? string A single name or an array of CLIENT names.
---@return self
function SET_CLIENT:AddClientsByName(AddClientNames) end

---Remove CLIENT(s) from SET_CLIENT.
---@param RemoveClientNames? CLIENT A single object or an array of CLIENT objects.
---@return self
function SET_CLIENT:RemoveClientsByName(RemoveClientNames) end

---Finds a Client based on the Client Name.
---@param ClientName? string
---@return CLIENT # The found Client.
function SET_CLIENT:FindClient(ClientName) end

---Builds a set of clients of certain callsigns.
---@param Callsigns? string Can be a single string e.g. "Ford", or a table of strings e.g. {"Uzi","Enfield","Chevy"}. Refers to the callsigns as they can be set in the mission editor.
---@return SET_CLIENT # self
function SET_CLIENT:FilterCallsigns(Callsigns) end

---Builds a set of clients of certain playernames.
---@param Playernames? string Can be a single string e.g. "Apple", or a table of strings e.g. {"Walter","Hermann","Gonzo"}. Useful if you have e.g. a common squadron prefix.
---@return SET_CLIENT # self
function SET_CLIENT:FilterPlayernames(Playernames) end

---Builds a set of clients out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---@param Categories? any Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_CLIENT # self
function SET_CLIENT:FilterCategories(Categories) end

---Builds a set of clients of defined client types.
---Possible current types are those types known within DCS world.
---@param Types? string Can take those type strings known within DCS world.
---@return SET_CLIENT # self
function SET_CLIENT:FilterTypes(Types) end

---Builds a set of clients of defined countries.
---Possible current countries are those known within DCS world.
---@param Countries? string Can take those country strings known within DCS world.
---@return SET_CLIENT # self
function SET_CLIENT:FilterCountries(Countries) end

---Builds a set of CLIENTs that contain the given string in their **unit/pilot** name and **NOT** the group name!
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all clients that **contain** the string. Pattern matching applies.
---@param Prefixes? string The string pattern(s) that needs to be contained in the unit/pilot name. Can also be passed as a `#table` of strings.
---@return SET_CLIENT # self
function SET_CLIENT:FilterPrefixes(Prefixes) end

---Builds a set of clients which belong to groups with certain **group names**.
---@param Prefixes? string The (partial) group names to look for. Can be anywhere in the group name. Can be a single string or a table of strings.
---@return SET_CLIENT # self
function SET_CLIENT:FilterGroupPrefixes(Prefixes) end

---Builds a set of clients that are only active.
---Only the clients that are active will be included within the set.
---@param Active? boolean (Optional) Include only active clients to the set. Include inactive clients if you provide false.
---@return SET_CLIENT # self
function SET_CLIENT:FilterActive(Active) end

---Builds a set of units which exist and are alive.
---@return SET_CLIENT # self
function SET_CLIENT:FilterAlive() end

---Builds a set of clients in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_CLIENT # self
function SET_CLIENT:FilterZones(Zones) end

---[Internal] Private function for use of continous zone filter
---@return SET_CLIENT # self
function SET_CLIENT:_ContinousZoneFilter() end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---@param Seconds? number (Optional) Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Groups are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_CLIENT # self
function SET_CLIENT:FilterZoneTimer(Seconds) end

---Stops the filtering.
---@return SET_CLIENT # self
function SET_CLIENT:FilterStop() end

---Starts the filtering.
---@return SET_CLIENT # self
function SET_CLIENT:FilterStart() end

---Handle CA slots addition
---@param Event? EVENTDATA
---@return SET_CLIENT # self
function SET_CLIENT:_EventPlayerEnterUnit(Event) end

---Handle CA slots removal
---@param Event? EVENTDATA
---@return SET_CLIENT # self
function SET_CLIENT:_EventPlayerLeaveUnit(Event) end

---Make the SET handle CA slots **only** (GROUND units used by any player). Needs active filtering with `FilterStart()`
---@return SET_CLIENT # self
function SET_CLIENT:HandleCASlots() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the CLIENT
---@return table # The CLIENT
function SET_CLIENT:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the CLIENT
---@return table # The CLIENT
function SET_CLIENT:FindInDatabase(Event) end

---Iterate the SET_CLIENT and call an iterator function for each **alive** CLIENT, providing the CLIENT and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive CLIENT in the SET_CLIENT. The function needs to accept a CLIENT parameter.
---@param ... any
---@return SET_CLIENT # self
function SET_CLIENT:ForEachClient(IteratorFunction, ...) end

---Iterate the SET_CLIENT and call an iterator function for each **alive** CLIENT presence completely in a {Core.Zone}, providing the CLIENT and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive CLIENT in the SET_CLIENT. The function needs to accept a CLIENT parameter.
---@param ... any
---@return SET_CLIENT # self
function SET_CLIENT:ForEachClientInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_CLIENT and call an iterator function for each **alive** CLIENT presence not in a {Core.Zone}, providing the CLIENT and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive CLIENT in the SET_CLIENT. The function needs to accept a CLIENT parameter.
---@param ... any
---@return SET_CLIENT # self
function SET_CLIENT:ForEachClientNotInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_CLIENT and count alive units.
---@return number # count
function SET_CLIENT:CountAlive() end

---Gets the alive set.
---@return table # Table of SET objects
function SET_CLIENT:GetAliveSet() end

---@param MClient? CLIENT
---@return SET_CLIENT # self
function SET_CLIENT:IsIncludeObject(MClient) end

---@class SET_PLAYER : SET_BASE
SET_PLAYER = {
  ClassName = "SET_PLAYER",
  Clients = {},
  Filter = {
    Coalitions = nil,
    Categories = nil,
    Types = nil,
    Countries = nil,
    ClientPrefixes = nil,
    Zones = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      plane = Unit.Category.AIRPLANE,
      helicopter = Unit.Category.HELICOPTER,
      ground = Unit.Category.GROUND_UNIT,
      ship = Unit.Category.SHIP,
      structure = Unit.Category.STRUCTURE,
    },
  },
}

---Creates a new SET_PLAYER object, building a set of clients belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_PLAYER
function SET_PLAYER:New() end

---Add CLIENT(s) to SET_PLAYER.
---@param AddClientNames? string A single name or an array of CLIENT names.
---@return self
function SET_PLAYER:AddClientsByName(AddClientNames) end

---Remove CLIENT(s) from SET_PLAYER.
---@param RemoveClientNames? CLIENT A single name or an array of CLIENT names.
---@return self
function SET_PLAYER:RemoveClientsByName(RemoveClientNames) end

---Finds a Client based on the Player Name.
---@param PlayerName? string
---@return CLIENT # The found Client.
function SET_PLAYER:FindClient(PlayerName) end

---Builds a set of players in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_PLAYER # self
function SET_PLAYER:FilterZones(Zones) end

---Builds a set of clients out of categories joined by players.
---Possible current categories are plane, helicopter, ground, ship.
---@param Categories? any Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_PLAYER # self
function SET_PLAYER:FilterCategories(Categories) end

---Builds a set of clients of defined client types joined by players.
---Possible current types are those types known within DCS world.
---@param Types? string Can take those type strings known within DCS world.
---@return SET_PLAYER # self
function SET_PLAYER:FilterTypes(Types) end

---Builds a set of clients of defined countries.
---Possible current countries are those known within DCS world.
---@param Countries? string Can take those country strings known within DCS world.
---@return SET_PLAYER # self
function SET_PLAYER:FilterCountries(Countries) end

---Builds a set of PLAYERs that contain the given string in their unit/pilot name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all player clients that **contain** the string.
---@param Prefixes? string The string pattern(s) that needs to be contained in the unit/pilot name. Can also be passed as a `#table` of strings.
---@return SET_PLAYER # self
function SET_PLAYER:FilterPrefixes(Prefixes) end

---Starts the filtering.
---@return SET_PLAYER # self
function SET_PLAYER:FilterStart() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the CLIENT
---@return table # The CLIENT
function SET_PLAYER:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the CLIENT
---@return table # The CLIENT
function SET_PLAYER:FindInDatabase(Event) end

---Iterate the SET_PLAYER and call an iterator function for each **alive** CLIENT, providing the CLIENT and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive CLIENT in the SET_PLAYER. The function needs to accept a CLIENT parameter.
---@param ... any
---@return SET_PLAYER # self
function SET_PLAYER:ForEachPlayer(IteratorFunction, ...) end

---Iterate the SET_PLAYER and call an iterator function for each **alive** CLIENT presence completely in a {Core.Zone}, providing the CLIENT and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive CLIENT in the SET_PLAYER. The function needs to accept a CLIENT parameter.
---@param ... any
---@return SET_PLAYER # self
function SET_PLAYER:ForEachPlayerInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_PLAYER and call an iterator function for each **alive** CLIENT presence not in a {Core.Zone}, providing the CLIENT and optional parameters to the called function.
---@param ZoneObject? ZONE The Zone to be tested for.
---@param IteratorFunction? function The function that will be called when there is an alive CLIENT in the SET_PLAYER. The function needs to accept a CLIENT parameter.
---@param ... any
---@return SET_PLAYER # self
function SET_PLAYER:ForEachPlayerNotInZone(ZoneObject, IteratorFunction, ...) end

---@param MClient? CLIENT
---@return SET_PLAYER # self
function SET_PLAYER:IsIncludeObject(MClient) end

---@class SET_AIRBASE : SET_BASE
SET_AIRBASE = {
  ClassName = "SET_AIRBASE",
  Airbases = {},
  Filter = {
    Coalitions = nil,
    Zones = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      airdrome = Airbase.Category.AIRDROME,
      helipad = Airbase.Category.HELIPAD,
      ship = Airbase.Category.SHIP,
    },
  },
}

---Creates a new SET_AIRBASE object, building a set of airbases belonging to a coalitions and categories.
---@return SET_AIRBASE # self
function SET_AIRBASE:New() end

---Add an AIRBASE object to SET_AIRBASE.
---@param airbase? AIRBASE Airbase that should be added to the set.
---@return self
function SET_AIRBASE:AddAirbase(airbase) end

---Add AIRBASEs to SET_AIRBASE.
---@param AddAirbaseNames? string A single name or an array of AIRBASE names.
---@return self
function SET_AIRBASE:AddAirbasesByName(AddAirbaseNames) end

---Remove AIRBASEs from SET_AIRBASE.
---@param RemoveAirbaseNames? AIRBASE A single name or an array of AIRBASE names.
---@return self
function SET_AIRBASE:RemoveAirbasesByName(RemoveAirbaseNames) end

---Finds a Airbase based on the Airbase Name.
---@param AirbaseName? string
---@return AIRBASE # The found Airbase.
function SET_AIRBASE:FindAirbase(AirbaseName) end

---Finds an Airbase in range of a coordinate.
---@param Coordinate? COORDINATE
---@param Range? number
---@return AIRBASE # The found Airbase.
function SET_AIRBASE:FindAirbaseInRange(Coordinate, Range) end

---Finds a random Airbase in the set.
---@return AIRBASE # The found Airbase.
function SET_AIRBASE:GetRandomAirbase() end

---Builds a set of airbases out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---@param Categories? any Can take the following values: "airdrome", "helipad", "ship".
---@return SET_AIRBASE # self
function SET_AIRBASE:FilterCategories(Categories) end

---Builds a set of airbase objects in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_AIRBASE # self
function SET_AIRBASE:FilterZones(Zones) end

---Starts the filtering.
---@return SET_AIRBASE # self
function SET_AIRBASE:FilterStart() end

---Base capturing event.
---@param EventData? EVENT
function SET_AIRBASE:OnEventBaseCaptured(EventData) end

---Dead event.
---@param EventData? EVENT
function SET_AIRBASE:OnEventDead(EventData) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA Event data.
---@return string # The name of the AIRBASE.
---@return AIRBASE # The AIRBASE object.
function SET_AIRBASE:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA Event data.
---@return string # The name of the AIRBASE.
---@return AIRBASE # The AIRBASE object.
function SET_AIRBASE:FindInDatabase(Event) end

---Iterate the SET_AIRBASE and call an iterator function for each AIRBASE, providing the AIRBASE and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive AIRBASE in the SET_AIRBASE. The function needs to accept a AIRBASE parameter.
---@param ... any
---@return SET_AIRBASE # self
function SET_AIRBASE:ForEachAirbase(IteratorFunction, ...) end

---Iterate the SET_AIRBASE while identifying the nearest {Wrapper.Airbase#AIRBASE} from a {Core.Point#COORDINATE}.
---@param Coordinate? COORDINATE A @{Core.Point#COORDINATE} object from where to evaluate the closest @{Wrapper.Airbase#AIRBASE}.
---@return AIRBASE # The closest @{Wrapper.Airbase#AIRBASE}.
function SET_AIRBASE:FindNearestAirbaseFromPointVec2(Coordinate) end

---@param MAirbase? AIRBASE
---@return SET_AIRBASE # self
function SET_AIRBASE:IsIncludeObject(MAirbase) end

---@class SET_ZONE : SET_BASE
SET_ZONE = {
  ClassName = "SET_ZONE",
  Zones = {},
  Filter = {
    Prefixes = nil,
  },
    FilterMeta = {
  },
  Checktime = 5,
}

---Creates a new SET_ZONE object, building a set of zones.
---@return SET_ZONE # self
function SET_ZONE:New() end

---Add ZONEs by a search name to SET_ZONE.
---@param AddZoneNames? string A single name or an array of ZONE_BASE names.
---@return self
function SET_ZONE:AddZonesByName(AddZoneNames) end

---Add ZONEs to SET_ZONE.
---@param Zone? ZONE_BASE A ZONE_BASE object.
---@return self
function SET_ZONE:AddZone(Zone) end

---Remove ZONEs from SET_ZONE.
---@param RemoveZoneNames? ZONE_BASE A single name or an array of ZONE_BASE names.
---@return self
function SET_ZONE:RemoveZonesByName(RemoveZoneNames) end

---Finds a Zone based on the Zone Name.
---@param ZoneName? string
---@return ZONE_BASE # The found Zone.
function SET_ZONE:FindZone(ZoneName) end

---Get a random zone from the set.
---@param margin? number Number of tries to find a zone
---@return ZONE_BASE # The random Zone.
---@return nil # if no zone in the collection.
function SET_ZONE:GetRandomZone(margin) end

---Set a zone probability.
---@param ZoneName? string The name of the zone.
---@param ZoneProbability? any
function SET_ZONE:SetZoneProbability(ZoneName, ZoneProbability) end

---Builds a set of ZONEs that contain the given string in their name.
---**ATTENTION!** Bad naming convention as this **does not** filter only **prefixes** but all zones that **contain** the string.
---@param Prefixes? string The string pattern(s) that need to be contained in the zone name. Can also be passed as a `#table` of strings.
---@return SET_ZONE # self
function SET_ZONE:FilterPrefixes(Prefixes) end

---Starts the filtering.
---@return SET_ZONE # self
function SET_ZONE:FilterStart() end

---Stops the filtering for the defined collection.
---@return SET_ZONE # self
function SET_ZONE:FilterStop() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the AIRBASE
---@return table # The AIRBASE
function SET_ZONE:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the AIRBASE
---@return table # The AIRBASE
function SET_ZONE:FindInDatabase(Event) end

---Iterate the SET_ZONE and call an iterator function for each ZONE, providing the ZONE and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive ZONE in the SET_ZONE. The function needs to accept a AIRBASE parameter.
---@param ... any
---@return SET_ZONE # self
function SET_ZONE:ForEachZone(IteratorFunction, ...) end

---Draw all zones in the set on the F10 map.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return SET_ZONE # self
function SET_ZONE:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Get the average aggregated coordinate of this set of zones.
---@return COORDINATE
function SET_ZONE:GetAverageCoordinate() end

---Private function.
---@param MZone? ZONE_BASE
---@return SET_ZONE # self
function SET_ZONE:IsIncludeObject(MZone) end

---Handles the OnEventNewZone event for the Set.
---@param EventData? EVENTDATA
function SET_ZONE:OnEventNewZone(EventData) end

---Handles the OnDead or OnCrash event for alive units set.
---@param EventData? EVENTDATA
function SET_ZONE:OnEventDeleteZone(EventData) end

---Validate if a coordinate is in one of the zones in the set.
---Returns the ZONE object where the coordinate is located.
---If zones overlap, the first zone that validates the test is returned.
---@param Coordinate? COORDINATE The coordinate to be searched.
---@return ZONE_BASE # The zone (if any) that validates the coordinate location.
function SET_ZONE:IsCoordinateInZone(Coordinate) end

---Get the closest zone to a given coordinate.
---@param Coordinate? COORDINATE The reference coordinate from which the closest zone is determined.
---@return ZONE_BASE # The closest zone (if any).
---@return number # Distance to ref coordinate in meters.
function SET_ZONE:GetClosestZone(Coordinate) end

---Set the check time for SET_ZONE:Trigger()
---@param seconds? number (Optional) Check every seconds for objects entering or leaving the zone. Defaults to 5 secs.
---@return SET_ZONE # self
function SET_ZONE:SetCheckTime(seconds) end

---Start watching if the Object or Objects move into or out of our set of zones.
---@param Objects? CONTROLLABLE Object or Objects to watch, can be of type UNIT, GROUP, CLIENT, or SET\_UNIT, SET\_GROUP, SET\_CLIENT
---@return SET_ZONE # self
function SET_ZONE:Trigger(Objects) end

---Toggle “partly-inside” handling for every zone in the set when those zones are used with :Trigger().
---* Call with no argument or **true** → enable for all.
---* Call with **false** → disable again (handy if it was enabled before).
---@param state? any
---@return SET_ZONE # self
function SET_ZONE:SetPartlyInside(state) end

---(Internal) Check the assigned objects for being in/out of the zone
---@param fromstart? boolean If true, do the init of the objects
---@return SET_ZONE # self
function SET_ZONE:_TriggerCheck(fromstart) end

---(Internal) Check the assigned objects for being in/out of the zone
---@param From? string
---@param Event? string
---@param To? any
---@return SET_ZONE # self
function SET_ZONE:onafterTriggerRunCheck(From, Event, To) end

---@class SET_ZONE_GOAL : SET_BASE
SET_ZONE_GOAL = {
  ClassName = "SET_ZONE_GOAL",
  Zones = {},
  Filter = {
    Prefixes = nil,
  },
    FilterMeta = {
  },
}

---Creates a new SET_ZONE_GOAL object, building a set of zones.
---@return SET_ZONE_GOAL # self
function SET_ZONE_GOAL:New() end

---Add ZONEs to SET_ZONE_GOAL.
---@param Zone? ZONE_BASE A ZONE_BASE object.
---@return self
function SET_ZONE_GOAL:AddZone(Zone) end

---Remove ZONEs from SET_ZONE_GOAL.
---@param RemoveZoneNames? ZONE_BASE A single name or an array of ZONE_BASE names.
---@return self
function SET_ZONE_GOAL:RemoveZonesByName(RemoveZoneNames) end

---Finds a Zone based on the Zone Name.
---@param ZoneName? string
---@return ZONE_BASE # The found Zone.
function SET_ZONE_GOAL:FindZone(ZoneName) end

---Get a random zone from the set.
---@return ZONE_BASE # The random Zone.
---@return nil # if no zone in the collection.
function SET_ZONE_GOAL:GetRandomZone() end

---Set a zone probability.
---@param ZoneName? string The name of the zone.
---@param ZoneProbability? any
function SET_ZONE_GOAL:SetZoneProbability(ZoneName, ZoneProbability) end

---Builds a set of ZONE_GOALs that contain the given string in their name.
---**ATTENTION!** Bad naming convention as this **does not** filter only **prefixes** but all zones that **contain** the string.
---@param Prefixes? string The string pattern(s) that needs to be contained in the zone name. Can also be passed as a `#table` of strings.
---@return SET_ZONE_GOAL # self
function SET_ZONE_GOAL:FilterPrefixes(Prefixes) end

---Starts the filtering.
---@return SET_ZONE_GOAL # self
function SET_ZONE_GOAL:FilterStart() end

---Stops the filtering for the defined collection.
---@return SET_ZONE_GOAL # self
function SET_ZONE_GOAL:FilterStop() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the AIRBASE
---@return table # The AIRBASE
function SET_ZONE_GOAL:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the AIRBASE
---@return table # The AIRBASE
function SET_ZONE_GOAL:FindInDatabase(Event) end

---Iterate the SET_ZONE_GOAL and call an iterator function for each ZONE, providing the ZONE and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive ZONE in the SET_ZONE_GOAL. The function needs to accept a AIRBASE parameter.
---@param ... any
---@return SET_ZONE_GOAL # self
function SET_ZONE_GOAL:ForEachZone(IteratorFunction, ...) end

---@param MZone? ZONE_BASE
---@return SET_ZONE_GOAL # self
function SET_ZONE_GOAL:IsIncludeObject(MZone) end

---Handles the OnEventNewZone event for the Set.
---@param EventData? EVENTDATA
function SET_ZONE_GOAL:OnEventNewZoneGoal(EventData) end

---Handles the OnDead or OnCrash event for alive units set.
---@param EventData? EVENTDATA
function SET_ZONE_GOAL:OnEventDeleteZoneGoal(EventData) end

---Validate if a coordinate is in one of the zones in the set.
---Returns the ZONE object where the coordiante is located.
---If zones overlap, the first zone that validates the test is returned.
---@param Coordinate? COORDINATE The coordinate to be searched.
---@return ZONE_BASE # The zone that validates the coordinate location.
---@return nil # No zone has been found.
function SET_ZONE_GOAL:IsCoordinateInZone(Coordinate) end

---@class SET_OPSZONE : SET_BASE
SET_OPSZONE = {
  ClassName = "SET_OPSZONE",
  Zones = {},
  Filter = {
    Prefixes   = nil,
    Coalitions = nil,      
  },
  FilterMeta = {
    Coalitions = {
      red     = coalition.side.RED,
      blue    = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
  }, --FilterMeta
}

---Creates a new SET_OPSZONE object, building a set of zones.
---@return SET_OPSZONE # self
function SET_OPSZONE:New() end

---Add an OPSZONE to set.
---@param Zone? OPSZONE The OPSZONE object.
---@return SET_OPSZONE # self
function SET_OPSZONE:AddZone(Zone) end

---Remove ZONEs from SET_OPSZONE.
---@param RemoveZoneNames? table A single name or an array of OPSZONE names.
---@return SET_OPSZONE # self
function SET_OPSZONE:RemoveZonesByName(RemoveZoneNames) end

---Finds a Zone based on its name.
---@param ZoneName? string
---@return OPSZONE # The found Zone.
function SET_OPSZONE:FindZone(ZoneName) end

---Get a random zone from the set.
---@return OPSZONE # The random Zone.
function SET_OPSZONE:GetRandomZone() end

---Set a zone probability.
---@param ZoneName? string The name of the zone.
---@param Probability? number The probability in percent.
function SET_OPSZONE:SetZoneProbability(ZoneName, Probability) end

---Builds a set of OPSZONEs that contain the given string in their name.
---**ATTENTION!** Bad naming convention as this **does not** filter only **prefixes** but all zones that **contain** the string.
---@param Prefixes? string The string pattern(s) that needs to be contained in the zone name. Can also be passed as a `#table` of strings.
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterPrefixes(Prefixes) end

---Filters for the defined collection.
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterOnce() end

---Clear all filters. You still need to apply `FilterOnce()` to have an effect on the set.
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterClear() end

---Starts the filtering.
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterStart() end

---Stops the filtering for the defined collection.
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterStop() end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA
---@return string # The name of the AIRBASE
---@return table # The AIRBASE
function SET_OPSZONE:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the AIRBASE
---@return table # The AIRBASE
function SET_OPSZONE:FindInDatabase(Event) end

---Iterate the SET_OPSZONE and call an iterator function for each ZONE, providing the ZONE and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive ZONE in the SET_OPSZONE. The function needs to accept a AIRBASE parameter.
---@param ... any
---@return SET_OPSZONE # self
function SET_OPSZONE:ForEachZone(IteratorFunction, ...) end

---Private function that checks if an object is contained in the set or filtered.
---@param MZone? OPSZONE The OPSZONE object.
---@return SET_OPSZONE # self
function SET_OPSZONE:IsIncludeObject(MZone) end

---Handles the OnEventNewZone event for the Set.
---@param EventData? EVENTDATA
function SET_OPSZONE:OnEventNewZoneGoal(EventData) end

---Handles the OnDead or OnCrash event for alive units set.
---@param EventData? EVENTDATA
function SET_OPSZONE:OnEventDeleteZoneGoal(EventData) end

---Start all opszones of the set.
---@return SET_OPSZONE # self
function SET_OPSZONE:Start() end

---Validate if a coordinate is in one of the zones in the set.
---Returns the ZONE object where the coordiante is located.
---If zones overlap, the first zone that validates the test is returned.
---@param Coordinate? COORDINATE The coordinate to be searched.
---@return ZONE_BASE # The zone that validates the coordinate location.
---@return nil # No zone has been found.
function SET_OPSZONE:IsCoordinateInZone(Coordinate) end

---Get the closest OPSZONE from a given reference coordinate. Only started zones are considered.
---@param Coordinate? COORDINATE The reference coordinate from which the closest zone is determined.
---@param Coalitions? table Only consider the given coalition(s), *e.g.* `{coaliton.side.RED}` to find the closest red zone.
---@return OPSZONE # The closest OPSZONE (if any).
---@return number # Distance to ref coordinate in meters.
function SET_OPSZONE:GetClosestZone(Coordinate, Coalitions) end

---@class SET_OPSGROUP : SET_BASE
SET_OPSGROUP = {
  ClassName = "SET_OPSGROUP",
  Filter = {
    Coalitions    = nil,
    Categories    = nil,
    Countries     = nil,
    GroupPrefixes = nil,
  },
  FilterMeta = {
    Coalitions = {
      red     = coalition.side.RED,
      blue    = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    },
    Categories = {
      plane      = Group.Category.AIRPLANE,
      helicopter = Group.Category.HELICOPTER,
      ground     = Group.Category.GROUND,
      ship       = Group.Category.SHIP,
    },
  }, -- FilterMeta
}

---Creates a new SET_OPSGROUP object, building a set of groups belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:New() end

---Gets a **new** set that only contains alive groups.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:GetAliveSet() end

---Adds a {Core.Base#BASE} object in the {Core.Set#SET_BASE}, using a given ObjectName as the index.
---@param ObjectName? string The name of the object.
---@param Object? BASE The object itself.
---@return BASE # The added BASE Object.
function SET_OPSGROUP:Add(ObjectName, Object) end

---Adds a {Core.Base#BASE} object in the {Core.Set#SET_BASE}, using the Object Name as the index.
---@param Object? OPSGROUP Ops group
---@return BASE # The added BASE Object.
function SET_OPSGROUP:AddObject(Object) end

---Add a GROUP or OPSGROUP object to the set.
---**NOTE** that an OPSGROUP is automatically created from the GROUP if it does not exist already.
---@param group? GROUP The GROUP which should be added to the set. Can also be given as an #OPSGROUP object.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:AddGroup(group) end

---Add GROUP(s) or OPSGROUP(s) to the set.
---@param AddGroupNames? string A single name or an array of GROUP names.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:AddGroupsByName(AddGroupNames) end

---Remove GROUP(s) or OPSGROUP(s) from the set.
---@param RemoveGroupNames? GROUP A single name or an array of GROUP names.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:RemoveGroupsByName(RemoveGroupNames) end

---Iterate the SET_OPSGROUP and count how many GROUPs and UNITs are alive.
---@return number # The number of GROUPs alive.
---@return number # The number of UNITs alive.
function SET_OPSGROUP:CountAlive() end

---Finds an OPSGROUP based on the group name.
---@param GroupName? string Name of the group.
---@return OPSGROUP # The found OPSGROUP (FLIGHTGROUP, ARMYGROUP or NAVYGROUP) or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindGroup(GroupName) end

---Finds a FLIGHTGROUP based on the group name.
---@param GroupName? string Name of the group.
---@return FLIGHTGROUP # The found FLIGHTGROUP or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindFlightGroup(GroupName) end

---Finds a ARMYGROUP based on the group name.
---@param GroupName? string Name of the group.
---@return ARMYGROUP # The found ARMYGROUP or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindArmyGroup(GroupName) end

---Finds a NAVYGROUP based on the group name.
---@param GroupName? string Name of the group.
---@return NAVYGROUP # The found NAVYGROUP or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindNavyGroup(GroupName) end

---Builds a set of groups out of categories.
---
---Possible current categories are:
---
---* "plane" for fixed wing groups
---* "helicopter" for rotary wing groups
---* "ground" for ground groups
---* "ship" for naval groups
---@param Categories? any Can take the following values: "plane", "helicopter", "ground", "ship" or combinations as a table, for example `{"plane", "helicopter"}`.
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCategories(Categories, Clear) end

---Builds a set of groups out of ground category.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCategoryGround() end

---Builds a set of groups out of airplane category.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCategoryAirplane() end

---Builds a set of groups out of aicraft category (planes and helicopters).
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCategoryAircraft() end

---Builds a set of groups out of helicopter category.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCategoryHelicopter() end

---Builds a set of groups out of ship category.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCategoryShip() end

---Builds a set of groups of defined countries.
---@param Countries? string Can take those country strings known within DCS world.
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterCountries(Countries, Clear) end

---Builds a set of groups that contain the given string in their group name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all groups that **contain** the string.
---@param Prefixes? string The string pattern(s) that needs to be contained in the group name. Can also be passed as a `#table` of strings.
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterPrefixes(Prefixes, Clear) end

---Builds a set of groups that are only active.
---Only the groups that are active will be included within the set.
---@param Active? boolean (optional) Include only active groups to the set. Include inactive groups if you provide false.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterActive(Active) end

---Starts the filtering.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:FilterStart() end

---Activate late activated groups in the set.
---@param Delay? number Delay in seconds.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:Activate(Delay) end

---Handles the OnBirth event for the Set.
---@param Event? EVENTDATA Event data.
function SET_OPSGROUP:_EventOnBirth(Event) end

---Handles the OnDead or OnCrash event for alive groups set.
---Note: The GROUP object in the SET_OPSGROUP collection will only be removed if the last unit is destroyed of the GROUP.
---@param Event? EVENTDATA
function SET_OPSGROUP:_EventOnDeadOrCrash(Event) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---@param Event? EVENTDATA Event data.
---@return string # The name of the GROUP.
---@return GROUP # The GROUP object.
function SET_OPSGROUP:AddInDatabase(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---@param Event? EVENTDATA Event data table.
---@return string # The name of the GROUP.
---@return GROUP # The GROUP object.
function SET_OPSGROUP:FindInDatabase(Event) end

---Iterate the set and call an iterator function for each OPSGROUP object.
---@param IteratorFunction? function The function that will be called for all OPSGROUPs in the set. **NOTE** that the function must have the OPSGROUP as first parameter!
---@param ... any
---@return SET_OPSGROUP # self
function SET_OPSGROUP:ForEachGroup(IteratorFunction, ...) end

---Check include object.
---@param MGroup? GROUP The group that is checked for inclusion.
---@return SET_OPSGROUP # self
function SET_OPSGROUP:IsIncludeObject(MGroup) end

---@class SET_SCENERY : SET_BASE
SET_SCENERY = {
  ClassName = "SET_SCENERY",
  Scenerys = {},
  Filter = {
    SceneryPrefixes = nil,
    SceneryRoles = nil,
    Zones = nil,
  },
}

---Creates a new SET_SCENERY object. Scenery is **not** auto-registered in the Moose database, there are too many objects on each map. Hence we need to find them first. For this we are using a SET_ZONE.
---@param ZoneSet? SET_ZONE SET_ZONE of ZONE objects as created by right-clicks on the map in the mission editor, choosing "assign as...". Rename the zones for grouping purposes, e.g. all sections of a bridge as "Bridge-1" to "Bridge-3".
---@return SET_SCENERY
function SET_SCENERY:New(ZoneSet) end

---Creates a new SET_SCENERY object. Scenery is **not** auto-registered in the Moose database, there are too many objects on each map. Hence we need to find them first. For this we scan the zone.
---@param Zone? ZONE The zone to be scanned. Can be a ZONE_RADIUS (round) or a ZONE_POLYGON (e.g. Quad-Point)
---@return SET_SCENERY
function SET_SCENERY:NewFromZone(Zone) end

---Add SCENERY(s) to SET_SCENERY.
---@param AddScenery? SCENERY A single SCENERY object.
---@return SET_SCENERY # self
function SET_SCENERY:AddScenery(AddScenery) end

---Add SCENERY(s) to SET_SCENERY.
---@param AddSceneryNames? string A single name or an array of SCENERY zone names.
---@return SET_SCENERY # self
function SET_SCENERY:AddSceneryByName(AddSceneryNames) end

---Remove SCENERY(s) from SET_SCENERY.
---@param RemoveSceneryNames? SCENERY A single name or an array of SCENERY zone names.
---@return self
function SET_SCENERY:RemoveSceneryByName(RemoveSceneryNames) end

---Finds a Scenery in the SET, based on the Scenery Name.
---@param SceneryName? string
---@return SCENERY # The found Scenery.
function SET_SCENERY:FindScenery(SceneryName) end

---Builds a set of scenery objects in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_SCENERY # self
function SET_SCENERY:FilterZones(Zones) end

---Builds a set of SCENERYs that contain the given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all scenery that **contain** the string.
---@param Prefixes? string The string pattern(s) that need to be contained in the scenery name. Can also be passed as a `#table` of strings.
---@return SET_SCENERY # self
function SET_SCENERY:FilterPrefixes(Prefixes) end

---Builds a set of SCENERYs that **contain** an exact match of the "ROLE" property.
---@param Role? string The string pattern(s) that needs to exactly match the scenery "ROLE" property from the ME quad-zone properties. Can also be passed as a `#table` of strings.
---@return SET_SCENERY # self
function SET_SCENERY:FilterRoles(Role) end

---Iterate the SET_SCENERY and count how many SCENERYSs are alive.
---@return number # The number of SCENERYSs alive.
function SET_SCENERY:CountAlive() end

---Get a table of alive objects.
---@return table # Table of alive objects
---@return SET_SCENERY # SET of alive objects
function SET_SCENERY:GetAliveSet() end

---Iterate the SET_SCENERY and call an iterator function for each **alive** SCENERY, providing the SCENERY and optional parameters.
---@param IteratorFunction? function The function that will be called when there is an alive SCENERY in the SET_SCENERY. The function needs to accept a SCENERY parameter.
---@param ... any
---@return SET_SCENERY # self
function SET_SCENERY:ForEachScenery(IteratorFunction, ...) end

---Get the center coordinate of the SET_SCENERY.
---@return COORDINATE # The center coordinate of all the objects in the set.
function SET_SCENERY:GetCoordinate() end

---[Internal] Determine if an object is to be included in the SET
---@param MScenery? SCENERY
---@return SET_SCENERY # self
function SET_SCENERY:IsIncludeObject(MScenery) end

---Filters for the defined collection.
---@return SET_SCENERY # self
function SET_SCENERY:FilterOnce() end

---Count overall initial (Life0) lifepoints of the SET objects.
---@return number # LIfe0Points
function SET_SCENERY:GetLife0() end

---Count overall current lifepoints of the SET objects.
---@return number # LifePoints
function SET_SCENERY:GetLife() end

---Calculate current relative lifepoints of the SET objects, i.e. Life divided by Life0 as percentage value, eg 75 meaning 75% alive.
---**CAVEAT**: Some objects change their life value or "hitpoints" **after** the first hit. Hence we will adjust the Life0 value to 120%
---of the last life value if life exceeds life0 ata any point.
---Thus we will get a smooth percentage decrease, if you use this e.g. as success criteria for a bombing task.
---@return number # LifePoints
function SET_SCENERY:GetRelativeLife() end

---@class SET_DYNAMICCARGO : SET_BASE
---@field Filter table Table of filters.
---@field Set table Table of objects.
---@field Index table Table of indices.
---@field List table Unused table.
---@field CallScheduler SCHEDULER .
---@field Filter SET_DYNAMICCARGO.Filters Filters.
---@field ZoneTimerInterval number .
---@field ZoneTimer TIMER Timer for active filtering of zones.
SET_DYNAMICCARGO = {
  ClassName = "SET_DYNAMICCARGO",
  Set = {},
  List = {},
  Index = {},
  Database = nil,
  CallScheduler = nil,
  Filter = {
    Coalitions = nil,
    Types = nil,
    Countries = nil,
    StaticPrefixes = nil,
    Zones = nil,
  },
  FilterMeta = {
    Coalitions = {
      red = coalition.side.RED,
      blue = coalition.side.BLUE,
      neutral = coalition.side.NEUTRAL,
    }
  },
  ZoneTimerInterval = 20,
  ZoneTimer = nil,
}

---Creates a new SET_DYNAMICCARGO object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---@return SET_DYNAMICCARGO
function SET_DYNAMICCARGO:New() end

---@param DCargo? DYNAMICCARGO
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:IsIncludeObject(DCargo) end

---Builds a set of dynamic cargo of defined dynamic cargo type names.
---@param Types? string Can take those type name strings known within DCS world.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterTypes(Types) end

---Builds a set of dynamic cargo of defined countries.
---Possible current countries are those known within DCS world.
---@param Countries? string Can take those country strings known within DCS world.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterCountries(Countries) end

---Builds a set of DYNAMICCARGOs that contain the given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all names that **contain** the string. LUA Regex applies.
---@param Prefixes? string The string pattern(s) that need to be contained in the dynamic cargo name. Can also be passed as a `#table` of strings.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterPrefixes(Prefixes) end

---Builds a set of DYNAMICCARGOs that contain the given string in their name.
---**Attention!** LUA Regex applies!
---@param Patterns? string The string pattern(s) that need to be contained in the dynamic cargo name. Can also be passed as a `#table` of strings.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterNamePattern(Patterns) end

---Builds a set of DYNAMICCARGOs that are in state DYNAMICCARGO.State.LOADED (i.e. is on board of a Chinook).
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterIsLoaded() end

---Builds a set of DYNAMICCARGOs that are in state DYNAMICCARGO.State.LOADED (i.e. was on board of a Chinook previously and is now unloaded).
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterIsUnloaded() end

---Builds a set of DYNAMICCARGOs that are in state DYNAMICCARGO.State.NEW (i.e. new and never loaded into a Chinook).
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterIsNew() end

---Builds a set of DYNAMICCARGOs that are owned at the moment by this player name.
---@param PlayerName? string
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterCurrentOwner(PlayerName) end

---Builds a set of dynamic cargo in zones.
---@param Zones? table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterZones(Zones) end

---Starts the filtering.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterStart() end

---Stops the filtering.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterStop() end

---[Internal] Private function for use of continous zone filter
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:_ContinousZoneFilter() end

---Handles the events for the Set.
---@param Event? EVENTDATA
function SET_DYNAMICCARGO:_EventHandlerDCAdd(Event) end

---Handles the remove event for dynamic cargo set.
---@param Event? EVENTDATA
function SET_DYNAMICCARGO:_EventHandlerDCRemove(Event) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_DYNAMICCARGO event or vise versa!
---@param Event? EVENTDATA
---@return string # The name of the DYNAMICCARGO
---@return DYNAMICCARGO # The DYNAMICCARGO object
function SET_DYNAMICCARGO:FindInDatabase(Event) end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---@param Seconds? number (Optional) Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Objects are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterZoneTimer(Seconds) end

---This filter is N/A for SET_DYNAMICCARGO
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterDeads() end

---This filter is N/A for SET_DYNAMICCARGO
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterCrashes() end

---Returns a list of current owners (playernames) indexed by playername from the SET.
---@return string[] # Ownerlist
function SET_DYNAMICCARGO:GetOwnerNames() end

---Returns a list of {Wrapper.Storage#STORAGE} objects from the SET indexed by cargo name.
---@return STORAGE[] # Storagelist
function SET_DYNAMICCARGO:GetStorageObjects() end

---Returns a list of current owners (Wrapper.Client#CLIENT objects) indexed by playername from the SET.
---@return string[] # Ownerlist
function SET_DYNAMICCARGO:GetOwnerClientObjects() end

---Added Handler OnAfter for SET_BASE
---@param From? string
---@param Event? string
---@param To? string
---@param ObjectName? string The name of the object.
---@param The? Object object.
function SET_BASE:OnAfterAdded(From, Event, To, ObjectName, The) end

---Removed Handler OnAfter for SET_BASE
---@param From? string
---@param Event? string
---@param To? string
---@param ObjectName? string The name of the object.
---@param The? Object object.
function SET_BASE:OnAfterRemoved(From, Event, To, ObjectName, The) end

---Filter the set once
---@return SET_GROUP # self
function SET_GROUP:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_GROUP # self
function SET_GROUP:FilterSetRegex(NoRegex, ReplaceDash) end

---Builds a set of objects of same coalitions.
---Possible current coalitions are red, blue and neutral.
---@param Coalitions? string Can take the following values: "red", "blue", "neutral" and coalition.side.RED, coalition.side.BLUE,coalition.side.NEUTRAL
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_GROUP # self
function SET_GROUP:FilterCoalitions(Coalitions, Clear) end

---[User] Add a custom condition function.
---@param ConditionFunction? function If this function returns `true`, the object is added to the SET. The function needs to take a GROUP object as first argument.
---@param Condition? any function arguments if any.
---@return SET_GROUP # self
function SET_GROUP:FilterFunction(ConditionFunction, Condition) end

---Get the first unit from the set.
---@return UNIT # The UNIT object.
function SET_UNIT:GetFirst() end

---Count Alive Units
---@return SET_UNIT # self
function SET_UNIT:CountAlive() end

---Filter the set once
---@return SET_UNIT # self
function SET_UNIT:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_UNIT # self
function SET_UNIT:FilterSetRegex(NoRegex, ReplaceDash) end

---Builds a set of objects of same coalitions.
---Possible current coalitions are red, blue and neutral.
---@param Coalitions? string Can take the following values: "red", "blue", "neutral" and coalition.side.RED, coalition.side.BLUE,coalition.side.NEUTRAL
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_UNIT # self
function SET_UNIT:FilterCoalitions(Coalitions, Clear) end

---[User] Add a custom condition function.
---@param ConditionFunction? function If this function returns `true`, the object is added to the SET. The function needs to take a UNIT object as first argument.
---@param Condition? any function arguments if any.
---@return SET_UNIT # self
function SET_UNIT:FilterFunction(ConditionFunction, Condition) end

---Get the first unit from the set.
---@return STATIC # The STATIC object.
function SET_STATIC:GetFirst() end

---Filter the set once
---@return SET_STATIC # self
function SET_STATIC:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_STATIC # self
function SET_STATIC:FilterSetRegex(NoRegex, ReplaceDash) end

---Builds a set of objects of same coalitions.
---Possible current coalitions are red, blue and neutral.
---@param Coalitions? string Can take the following values: "red", "blue", "neutral" and coalition.side.RED, coalition.side.BLUE,coalition.side.NEUTRAL
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_STATIC # self
function SET_STATIC:FilterCoalitions(Coalitions, Clear) end

---[User] Add a custom condition function.
---@param ConditionFunction? function If this function returns `true`, the object is added to the SET. The function needs to take a STATIC object as first argument.
---@param Condition? any function arguments if any.
---@return SET_STATIC # self
function SET_STATIC:FilterFunction(ConditionFunction, Condition) end

---Filter the set once
---@return SET_CLIENT # self
function SET_CLIENT:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_CLIENT # self
function SET_CLIENT:FilterSetRegex(NoRegex, ReplaceDash) end

---Builds a set of objects of same coalitions.
---Possible current coalitions are red, blue and neutral.
---@param Coalitions? string Can take the following values: "red", "blue", "neutral" and coalition.side.RED, coalition.side.BLUE,coalition.side.NEUTRAL
---@param Clear? boolean If `true`, clear any previously defined filters.
---@return SET_CLIENT # self
function SET_CLIENT:FilterCoalitions(Coalitions, Clear) end

---[User] Add a custom condition function.
---@param ConditionFunction? function If this function returns `true`, the object is added to the SET. The function needs to take a CLIENT object as first argument.
---@param Condition? any function arguments if any.
---@return SET_CLIENT # self
function SET_CLIENT:FilterFunction(ConditionFunction, Condition) end

---Filter the set once
---@return SET_ZONE # self
function SET_ZONE:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_ZONE # self
function SET_ZONE:FilterSetRegex(NoRegex, ReplaceDash) end

---Triggers the FSM event "TriggerStop". Stops the SET_ZONE Trigger.
function SET_ZONE:TriggerStop() end

---Triggers the FSM event "TriggerStop" after a delay.
---@param delay? number Delay in seconds.
function SET_ZONE:__TriggerStop(delay) end

---On After "EnteredZone" event. An observed object has entered the zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Controllable? CONTROLLABLE The controllable entering the zone.
---@param Zone? ZONE_BASE The zone entered.
function SET_ZONE:OnAfterEnteredZone(From, Event, To, Controllable, Zone) end

---On After "LeftZone" event. An observed object has left the zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Controllable? CONTROLLABLE The controllable leaving the zone.
---@param Zone? ZONE_BASE The zone left.
function SET_ZONE:OnAfterLeftZone(From, Event, To, Controllable, Zone) end

---Filter the set once
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_OPSZONE # self
function SET_OPSZONE:FilterSetRegex(NoRegex, ReplaceDash) end

---Filter the set once
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterOnce() end

---Set Regex Options for FilterPrefix function.
---@param NoRegex? boolean If true, switch off Regex pattern matching for FilterPrefixes.
---@param ReplaceDash? boolean If false, switch off dash "-" replacement in strings for FilterPrefixes.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterSetRegex(NoRegex, ReplaceDash) end

---[User] Add a custom condition function.
---@param ConditionFunction? function If this function returns `true`, the object is added to the SET. The function needs to take a DYNAMICCARGO object as first argument.
---@param Condition? any function arguments if any.
---@return SET_DYNAMICCARGO # self
function SET_DYNAMICCARGO:FilterFunction(ConditionFunction, Condition) end
