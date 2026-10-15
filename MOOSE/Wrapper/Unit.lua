---@meta

---@class Unit.SensorType

---@class UNIT : CONTROLLABLE
---@field ClassName string Name of the class.
---@field UnitName string Name of the unit.
---@field GroupName string Name of the group the unit belongs to.
---@field DCSUnit table The DCS Unit object from the API.
UNIT = {
    ClassName = "UNIT",
    UnitName = nil,
    GroupName = nil,
    DCSUnit = nil,
}

---Create a new UNIT from DCSUnit.
---@param UnitName? string The name of the DCS unit.
---@return UNIT # self
function UNIT:Register(UnitName) end

---Finds a UNIT from the _DATABASE using a DCSUnit object.
---@param DCSUnit? Unit An existing DCS Unit object reference.
---@return UNIT # self
function UNIT:Find(DCSUnit) end

---Find a UNIT in the _DATABASE using the name of an existing DCS Unit.
---@param UnitName? string The Unit Name.
---@return UNIT # self
function UNIT:FindByName(UnitName) end

---Find the first(!) UNIT matching using patterns. Note that this is **a lot** slower than `:FindByName()`!
---@param Pattern? string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return UNIT # The UNIT.
function UNIT:FindByMatching(Pattern) end

---Find all UNIT objects matching using patterns. Note that this is **a lot** slower than `:FindByName()`!
---@param Pattern? string The pattern to look for. Refer to [LUA patterns](http://www.easyuo.com/openeuo/wiki/index.php/Lua_Patterns_and_Captures_\(Regular_Expressions\)) for regular expressions in LUA.
---@return table # Units Table of matching #UNIT objects found
function UNIT:FindAllByMatching(Pattern) end

---Return the name of the UNIT.
---@return string # The UNIT name.
function UNIT:Name() end

---[[
---Get the DCS unit object.
---@return Unit # The DCS unit object.
function UNIT:GetDCSObject() end

---Returns the DCS Unit.
---@return Unit # The DCS Group.
function UNIT:GetDCSObject() end

---Returns the unit altitude above sea level in meters.
---@param FromGround? boolean Measure from the ground or from sea level (ASL). Provide **true** for measuring from the ground (AGL). **false** or **nil** if you measure from sea level.
---@return number # The height of the group or nil if is not existing or alive.
function UNIT:GetAltitude(FromGround) end

---Respawn the {Wrapper.Unit} using a (tweaked) template of the parent Group.
---
---This function will:
---
--- * Get the current position and heading of the group.
--- * When the unit is alive, it will tweak the template x, y and heading coordinates of the group and the embedded units to the current units positions.
--- * Then it will respawn the re-modelled group.
---@param Coordinate? COORDINATE The position where to Spawn the new Unit at.
---@param Heading? number The heading of the unit respawn.
function UNIT:ReSpawnAt(Coordinate, Heading) end

---Returns if the unit is activated.
---@return boolean # `true` if Unit is activated. `nil` The DCS Unit is not existing or alive.
function UNIT:IsActive() end

---Returns if the unit is exists in the mission.
---If not even the DCS unit object does exist, `nil` is returned.
---If the unit object exists, the value of the DCS API function [isExist](https://wiki.hoggitworld.com/view/DCS_func_isExist) is returned.
---@return boolean # Returns `true` if unit exists in the mission.
function UNIT:IsExist() end

---Returns if the Unit is alive.
---If the Unit is not alive/existent, `nil` is returned.
---If the Unit is alive and active, `true` is returned.
---If the Unit is alive but not active, `false`` is returned.
---@return boolean # Returns `true` if Unit is alive and active, `false` if it exists but is not active and `nil` if the object does not exist or DCS `isExist` function returns false.
function UNIT:IsAlive() end

---Returns if the Unit is dead.
---@return boolean # `true` if Unit is dead, else false or nil if the unit does not exist
function UNIT:IsDead() end

---Returns the Unit's callsign - the localized string.
---@return string # The Callsign of the Unit.
function UNIT:GetCallsign() end

---Check if an (air) unit is a client or player slot. Information is retrieved from the group template.
---@return boolean # If true, unit is associated with a client or player slot.
function UNIT:IsPlayer() end

---Returns name of the player that control the unit or nil if the unit is controlled by A.I.
---@return string # Player Name
---@return nil # The DCS Unit is not existing or alive.
function UNIT:GetPlayerName() end

---Checks is the unit is a *Player* or *Client* slot.
---@return boolean # If true, unit is a player or client aircraft
function UNIT:IsClient() end

---Get the CLIENT of the unit
---@return CLIENT
function UNIT:GetClient() end

---[AIRPLANE] Get the NATO reporting name of a UNIT. Currently airplanes only!
---@return string # NatoReportingName or "Bogey" if unknown.
function UNIT:GetNatoReportingName() end

---Returns the unit's number in the group.
---The number is the same number the unit has in ME.
---It may not be changed during the mission.
---If any unit in the group is destroyed, the numbers of another units will not be changed.
---@return number # The Unit number.
---@return nil # The DCS Unit is not existing or alive.
function UNIT:GetNumber() end

---Returns the unit's max speed in km/h derived from the DCS descriptors.
---@return number # Speed in km/h.
function UNIT:GetSpeedMax() end

---Returns the unit's max range in meters derived from the DCS descriptors.
---For ground units it will return a range of 10,000 km as they have no real range.
---@return number # Range in meters.
function UNIT:GetRange() end

---Check if the unit is refuelable. Also retrieves the refuelling system (boom or probe) if applicable.
---@return boolean # If true, unit is refuelable (checks for the attribute "Refuelable").
---@return number # Refueling system (if any): 0=boom, 1=probe.
function UNIT:IsRefuelable() end

---Check if the unit is a tanker. Also retrieves the refuelling system (boom or probe) if applicable.
---@return boolean # If true, unit is a tanker (checks for the attribute "Tankers").
---@return number # Refueling system (if any): 0=boom, 1=probe.
function UNIT:IsTanker() end

---Check if the unit can supply ammo. Currently, we have
---
---* M 818
---* Ural-375
---* ZIL-135
---
---This list needs to be extended, if DCS adds other units capable of supplying ammo.
---@return boolean # If `true`, unit can supply ammo.
function UNIT:IsAmmoSupply() end

---Check if the unit can supply fuel. Currently, we have
---
---* M978 HEMTT Tanker
---* ATMZ-5
---* ATMZ-10
---* ATZ-5
---
---This list needs to be extended, if DCS adds other units capable of supplying fuel.
---@return boolean # If `true`, unit can supply fuel.
function UNIT:IsFuelSupply() end

---Returns the unit's group if it exists and nil otherwise.
---@return GROUP # The Group of the Unit or `nil` if the unit does not exist.
function UNIT:GetGroup() end

---Returns the prefix name of the DCS Unit. A prefix name is a part of the name before a '#'-sign.
---DCS Units spawned with the {Core.Spawn#SPAWN} class contain a '#'-sign to indicate the end of the (base) DCS Unit name.
---The spawn sequence number and unit number are contained within the name after the '#' sign.
---@return string # The name of the DCS Unit.
---@return nil # The DCS Unit is not existing or alive.
function UNIT:GetPrefix() end

---Returns the Unit's ammunition.
---@return Unit.Ammo # Table with ammuntion of the unit (or nil). This can be a complex table!
function UNIT:GetAmmo() end

---Sets the Unit's Internal Cargo Mass, in kg
---@param mass? number to set cargo to
---@return UNIT # self
function UNIT:SetUnitInternalCargo(mass) end

---Get the number of ammunition and in particular the number of shells, rockets, bombs and missiles a unit currently has.
---@return number # Total amount of ammo the unit has left. This is the sum of shells, rockets, bombs and missiles.
---@return number # Number of shells left. Shells include MG ammunition, AP and HE shells, and artillery shells where applicable.
---@return number # Number of rockets left.
---@return number # Number of bombs left.
---@return number # Number of missiles left.
---@return number # Number of artillery shells left (with explosive mass, included in shells; HE will also be reported as artillery shells for tanks)
---@return number # Number of tank AP shells left (for tanks, if applicable)
---@return number # Number of tank HE shells left (for tanks, if applicable)
function UNIT:GetAmmunition() end

---Checks if a tank still has AP shells.
---@return boolean # HasAPShells
function UNIT:HasAPShells() end

---Get number of AP shells from a tank.
---@return number # Number of AP shells
function UNIT:GetAPShells() end

---Get number of HE shells from a tank.
---@return number # Number of HE shells
function UNIT:GetHEShells() end

---Checks if a tank still has HE shells.
---@return boolean # HasHEShells
function UNIT:HasHEShells() end

---Checks if an artillery unit still has artillery shells.
---@return boolean # HasArtiShells
function UNIT:HasArtiShells() end

---Get number of artillery shells from an artillery unit.
---@return number # Number of artillery shells
function UNIT:GetArtiShells() end

---Returns the unit sensors.
---@return Unit.Sensors # Table of sensors.
function UNIT:GetSensors() end

---Returns if the unit has sensors of a certain type.
---@param ... any
---@return boolean # returns true if the unit has specified types of sensors. This function is more preferable than Unit.getSensors() if you don't want to get information about all the unit's sensors, and just want to check if the unit has specified types of sensors.
function UNIT:HasSensors(...) end

---Returns if the unit is SEADable.
---@return boolean # returns true if the unit is SEADable.
function UNIT:HasSEAD() end

---Returns two values:
---
--- * First value indicates if at least one of the unit's radar(s) is on.
--- * Second value is the object of the radar's interest. Not nil only if at least one radar of the unit is tracking a target.
---@return boolean # Indicates if at least one of the unit's radar(s) is on.
---@return Object # The object of the radar's interest. Not nil only if at least one radar of the unit is tracking a target.
function UNIT:GetRadar() end

---Returns relative amount of fuel (from 0.0 to 1.0) the UNIT has in its internal tanks. If there are additional fuel tanks the value may be greater than 1.0.
---@return number # The relative amount of fuel (from 0.0 to 1.0) or *nil* if the DCS Unit is not existing or alive.
function UNIT:GetFuel() end

---Returns a list of one {Wrapper.Unit}.
---@return UNIT[] # A list of one @{Wrapper.Unit}.
function UNIT:GetUnits() end

---Returns the unit's health. Dead units has health <= 1.0.
---@return number # The Unit's health value or -1 if unit does not exist any more.
function UNIT:GetLife() end

---Returns the Unit's initial health.
---@return number # The Unit's initial health value or 0 if unit does not exist any more.
function UNIT:GetLife0() end

---Returns the unit's relative health.
---@return number # The Unit's relative health value, i.e. a number in [0,1] or -1 if unit does not exist any more.
function UNIT:GetLifeRelative() end

---Returns the unit's relative damage, i.e. 1-life.
---@return number # The Unit's relative health value, i.e. a number in [0,1] or 1 if unit does not exist any more.
function UNIT:GetDamageRelative() end

---Returns the current value for an animation argument on the external model of the given object.
---Each model animation has an id tied to with different values representing different states of the model.
---Animation arguments can be figured out by opening the respective 3d model in the modelviewer.
---@param AnimationArgument? number Number corresponding to the animated part of the unit.
---@return number # Value of the animation argument [-1, 1]. If draw argument value is invalid for the unit in question a value of 0 will be returned.
function UNIT:GetDrawArgumentValue(AnimationArgument) end

---Returns the category of the #UNIT from descriptor. Returns one of
---
---* Unit.Category.AIRPLANE
---* Unit.Category.HELICOPTER
---* Unit.Category.GROUND_UNIT
---* Unit.Category.SHIP
---* Unit.Category.STRUCTURE
---@return number # Unit category from `getDesc().category`.
function UNIT:GetUnitCategory() end

---Returns the category name of the #UNIT.
---@return string # Category name = Helicopter, Airplane, Ground Unit, Ship
function UNIT:GetCategoryName() end

---Returns the Unit's A2G threat level on a scale from 1 to 10 ...
---Depending on the era and the type of unit, the following threat levels are foreseen:
---
---**Modern**:
---
---  * Threat level  0: Unit is unarmed.
---  * Threat level  1: Unit is infantry.
---  * Threat level  2: Unit is an infantry vehicle.
---  * Threat level  3: Unit is ground artillery.
---  * Threat level  4: Unit is a tank.
---  * Threat level  5: Unit is a modern tank or ifv with ATGM.
---  * Threat level  6: Unit is a AAA.
---  * Threat level  7: Unit is a SAM or manpad, IR guided.
---  * Threat level  8: Unit is a Short Range SAM, radar guided.
---  * Threat level  9: Unit is a Medium Range SAM, radar guided.
---  * Threat level 10: Unit is a Long Range SAM, radar guided.
---
---**Cold**:
---
---  * Threat level  0: Unit is unarmed.
---  * Threat level  1: Unit is infantry.
---  * Threat level  2: Unit is an infantry vehicle.
---  * Threat level  3: Unit is ground artillery.
---  * Threat level  4: Unit is a tank.
---  * Threat level  5: Unit is a modern tank or ifv with ATGM.
---  * Threat level  6: Unit is a AAA.
---  * Threat level  7: Unit is a SAM or manpad, IR guided.
---  * Threat level  8: Unit is a Short Range SAM, radar guided.
---  * Threat level  10: Unit is a Medium Range SAM, radar guided.
---
---**Korea**:
---
---  * Threat level  0: Unit is unarmed.
---  * Threat level  1: Unit is infantry.
---  * Threat level  2: Unit is an infantry vehicle.
---  * Threat level  3: Unit is ground artillery.
---  * Threat level  5: Unit is a tank.
---  * Threat level  6: Unit is a AAA.
---  * Threat level  7: Unit is a SAM or manpad, IR guided.
---  * Threat level  10: Unit is a Short Range SAM, radar guided.
---
---**WWII**:
---
---  * Threat level  0: Unit is unarmed.
---  * Threat level  1: Unit is infantry.
---  * Threat level  2: Unit is an infantry vehicle.
---  * Threat level  3: Unit is ground artillery.
---  * Threat level  5: Unit is a tank.
---  * Threat level  7: Unit is FLAK.
---  * Threat level  10: Unit is AAA.
---@return number # Number between 0 (low threat level) and 10 (high threat level).
---@return string # Some text.
function UNIT:GetThreatLevel() end

---Triggers an explosion at the coordinates of the unit.
---@param power? number (Optional) Power of the explosion in kg TNT. Default 100 kg TNT.
---@param delay? number (Optional) Delay of explosion in seconds.
---@return UNIT # self
function UNIT:Explode(power, delay) end

---Returns true if there is an **other** DCS Unit within a radius of the current 2D point of the DCS Unit.
---@param AwaitUnit? UNIT The other UNIT wrapper object.
---@param Radius? any
---@return true # If the other DCS Unit is within the radius of the 2D point of the DCS Unit.
---@return nil # The DCS Unit is not existing or alive.
function UNIT:OtherUnitInRadius(AwaitUnit, Radius) end

---Returns if the unit is a friendly unit.
---@param FriendlyCoalition? any
---@return boolean # IsFriendly evaluation result.
function UNIT:IsFriendly(FriendlyCoalition) end

---Returns if the unit is of a ship category.
---If the unit is a ship, this method will return true, otherwise false.
---@return boolean # Ship category evaluation result.
function UNIT:IsShip() end

---Returns true if the UNIT is in the air.
---@param NoHeloCheck? boolean If true, no additonal checks for helos are performed.
---@return boolean # Return true if in the air or #nil if the UNIT is not existing or alive.
function UNIT:InAir(NoHeloCheck) end

---Subscribe to a DCS Event.
---@param EventID? EVENTS|number|string Event ID.
---@param EventFunction? function (Optional) The function to be called when the event occurs for the unit.
---@return UNIT # self
function UNIT:HandleEvent(EventID, EventFunction) end

---UnSubscribe to a DCS event.
---@param EventID? EVENTS|number|string Event ID.
---@return UNIT # self
function UNIT:UnHandleEvent(EventID) end

---Reset the subscriptions.
---@return UNIT
function UNIT:ResetEvents() end

---Returns if a unit is detecting the TargetUnit.
---@param TargetUnit? UNIT
---@return boolean # true If the TargetUnit is detected by the unit, otherwise false.
function UNIT:IsDetected(TargetUnit) end

---Returns if a unit has Line of Sight (LOS) with the TargetUnit.
---@param TargetUnit? UNIT
---@return boolean # true If the TargetUnit has LOS with the unit, otherwise false.
function UNIT:IsLOS(TargetUnit) end

---Forces the unit to become aware of the specified target, without the unit manually detecting the other unit itself.
---Applies only to a Unit Controller. Cannot be used at the group level.
---@param TargetUnit? UNIT The unit to be known.
---@param TypeKnown? boolean The target type is known. If *false*, the type is not known.
---@param DistanceKnown? boolean The distance to the target is known. If *false*, distance is unknown.
function UNIT:KnowUnit(TargetUnit, TypeKnown, DistanceKnown) end

---Get the unit table from a unit's template.
---@return table # Table of the unit template (deep copy) or #nil.
function UNIT:GetTemplate() end

---Get the payload table from a unit's template.
---The payload table has elements:
---
---   * pylons
---   * fuel
---   * chaff
---   * gun
---@return table # Payload table (deep copy) or #nil.
function UNIT:GetTemplatePayload() end

---Get the pylons table from a unit's template. This can be a complex table depending on the weapons the unit is carrying.
---@return table # Table of pylons (deepcopy) or #nil.
function UNIT:GetTemplatePylons() end

---Get the fuel of the unit from its template.
---@return number # Fuel of unit in kg.
function UNIT:GetTemplateFuel() end

---GROUND - Switch on/off radar emissions of a unit.
---@param switch? boolean If true, emission is enabled. If false, emission is disabled.
---@return UNIT # self
function UNIT:EnableEmission(switch) end

---Get skill from Unit.
---@return string # Skill String of skill name.
function UNIT:GetSkill() end

---Get Link16 STN or SADL TN and other datalink info from Unit, if any.
---@return string # STN STN or TN Octal as string, or nil if not set/capable.
---@return string # VCL Voice Callsign Label or nil if not set/capable.
---@return string # VCN Voice Callsign Number or nil if not set/capable.
---@return string # Lead If true, unit is Flight Lead, else false or nil.
function UNIT:GetSTN() end

---Turns the AI On or Off for the UNIT.
---@param AIOnOff? boolean The value true turns the AI On, the value false turns the AI Off.
---@return UNIT # The UNIT.
function UNIT:SetAIOnOff(AIOnOff) end

---Turns the AI On for the UNIT.
---@return UNIT # The UNIT.
function UNIT:SetAIOn() end

---Turns the AI Off for the UNIT.
---@return UNIT # The UNIT.
function UNIT:SetAIOff() end

---[GROUND] Determine if a UNIT is a SAM unit, i.e. has radar or optical tracker and is no mobile AAA.
---@return boolean # IsSAM True if SAM, else false
function UNIT:IsSAM() end

---[GROUND] Determine if a UNIT is a EWR unit
---@return boolean # IsEWR True if EWR, else false
function UNIT:IsEWR() end

---[GROUND] Determine if a UNIT is a AAA unit, i.e. has no radar or optical tracker but the AAA = true or the "Mobile AAA" = true attribute.
---@return boolean # IsAAA True if AAA, else false
function UNIT:IsAAA() end

---Set the relative life points of a UNIT object
---@param Percent? number Percent to set, can be 0..100.
function UNIT:SetLife(Percent) end

---Set the carrier illumination mode. -2: OFF, -1: AUTO, 0: NAVIGATION, 1: AC LAUNCH, 2: AC RECOVERY
---@param Mode? number Illumination mode, can be -2: OFF, -1: AUTO, 0: NAVIGATION, 1: AC LAUNCH, 2: AC RECOVERY
function UNIT:SetCarrierIlluminationMode(Mode) end

---This function uses Disposition and other fallback logic to find better ground positions for ground units.
---NOTE: This is not a spawn randomizer.
---It will try to find clear ground locations avoiding trees, water, roads, runways, map scenery, statics and other units in the area and modifies the provided positions table.
---Maintains the original layout and unit positions as close as possible by searching for the next closest valid position to each unit.
---Uses UTILS.ValidateAndRepositionGroundUnits.
---@param Enabled? boolean Enable/disable the feature.
function UNIT:SetValidateAndRepositionGroundUnits(Enabled) end

---Get the max kgs of fuel this unit can hold in its *internal* tank(s) and overall (with external tanks) in kgs.
---@return number # InternalFuel Max internal fuel in kgs. Zero if it cannot be determined.
---@return number # Overall Fuel Overall max in case there are external tanks in kgs. Zero if it cannot be determined.
function UNIT:GetFuelMassMax() end

---Get the current kgs of fuel this unit holds in all of its tanks.
function UNIT:GetCurrentFuelKgs() end
