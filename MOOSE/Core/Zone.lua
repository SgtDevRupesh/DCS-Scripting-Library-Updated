---@meta

---@class ZONE_AIRBASE : ZONE_RADIUS
---@field isShip boolean If `true`, airbase is a ship.
---@field isHelipad boolean If `true`, airbase is a helipad.
---@field isAirdrome boolean If `true`, airbase is an airdrome.
ZONE_AIRBASE = {}

---@class ZONE_ELASTIC : ZONE_POLYGON_BASE
---@field points table Points in 2D.
---@field setGroups table Set of GROUPs.
---@field setOpsGroups table Set of OPSGROUPS.
---@field setUnits table Set of UNITs.
---@field updateID number Scheduler ID for updating.
ZONE_ELASTIC = {}

---@class ZONE_POLYGON_BASE.ListVec3

---@class ZONE_POLYGON_BASE.ListVec2

---@class ZONE_BASE.BoundingSquare
---@field x1 number The lower x coordinate (left down)
---@field y1 number The lower y coordinate (left down)
---@field x2 number The higher x coordinate (right up)
---@field y2 number The higher y coordinate (right up)

---@class ZONE_BASE : FSM
---@field ZoneName string Name of the zone.
---@field ZoneProbability number A value between 0 and 1. 0 = 0% and 1 = 100% probability.
---@field DrawID number Unique ID of the drawn zone on the F10 map.
---@field Color table Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
---@field FillColor table Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
---@field drawCoalition number Draw coalition.
---@field ZoneID number ID of zone. Only zones defined in the ME have an ID!
---@field Table table of any trigger zone properties from the ME. The key is the Name of the property, and the value is the property's Value.
---@field Surface number Type of surface. Only determined at the center of the zone!
---@field Checktime number Check every Checktime seconds, used for ZONE:Trigger()
---@field PartlyInside boolean When called, a GROUP is considered inside as soon as any of its units enters the zone even if they are far apart.
ZONE_BASE = {
  ClassName = "ZONE_BASE",
  ZoneName = "",
  ZoneProbability = 1,
  DrawID=nil,
  Color={},
  ZoneID=nil,
  Properties={},
  Surface=nil,
  Checktime = 5,
}

---ZONE_BASE constructor
---@param ZoneName? string Name of the zone.
---@return ZONE_BASE # self
function ZONE_BASE:New(ZoneName) end

---Returns the name of the zone.
---@return string # The name of the zone.
function ZONE_BASE:GetName() end

---Sets the name of the zone.
---@param ZoneName? string The name of the zone.
---@return ZONE_BASE
function ZONE_BASE:SetName(ZoneName) end

---Returns if a Vec2 is within the zone.
---@param Vec2? Vec2 The Vec2 to test.
---@return boolean # true if the Vec2 is within the zone.
function ZONE_BASE:IsVec2InZone(Vec2) end

---Returns if a Vec3 is within the zone.
---@param Vec3? Vec3 The point to test.
---@return boolean # true if the Vec3 is within the zone.
function ZONE_BASE:IsVec3InZone(Vec3) end

---Returns if a Coordinate is within the zone.
---@param Coordinate? COORDINATE The coordinate to test.
---@return boolean # true if the coordinate is within the zone.
function ZONE_BASE:IsCoordinateInZone(Coordinate) end

---Returns if a PointVec2 is within the zone. (Name is misleading, actually takes a #COORDINATE)
---@param Coordinate? COORDINATE The coordinate to test.
---@return boolean # true if the PointVec2 is within the zone.
function ZONE_BASE:IsPointVec2InZone(Coordinate) end

---Returns if a PointVec3 is within the zone.
---@param PointVec3? COORDINATE The PointVec3 to test.
---@return boolean # true if the PointVec3 is within the zone.
function ZONE_BASE:IsPointVec3InZone(PointVec3) end

---Returns the {DCS#Vec2} coordinate of the zone.
---@return nil.
function ZONE_BASE:GetVec2() end

---Returns a {Core.Point#COORDINATE} of the zone.
---@return COORDINATE # The COORDINATE of the zone.
function ZONE_BASE:GetPointVec2() end

---Returns the {DCS#Vec3} of the zone.
---@param Height? number The height to add to the land height where the center of the zone is located.
---@return Vec3 # The Vec3 of the zone.
function ZONE_BASE:GetVec3(Height) end

---Returns a {Core.Point#COORDINATE} of the zone.
---@param Height? number The height to add to the land height where the center of the zone is located.
---@return COORDINATE # The PointVec3 of the zone.
function ZONE_BASE:GetPointVec3(Height) end

---Returns a {Core.Point#COORDINATE} of the zone.
---@param Height? number The height to add to the land height where the center of the zone is located.
---@return COORDINATE # The Coordinate of the zone.
function ZONE_BASE:GetCoordinate(Height) end

---Get 2D distance to a coordinate.
---@param Coordinate? COORDINATE Reference coordinate. Can also be a DCS#Vec2 or DCS#Vec3 object.
---@return number # Distance to the reference coordinate in meters.
function ZONE_BASE:Get2DDistance(Coordinate) end

---Define a random {DCS#Vec2} within the zone.
---@return Vec2 # The Vec2 coordinates.
function ZONE_BASE:GetRandomVec2() end

---Define a random {Core.Point#COORDINATE} within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec2 table.
---@return COORDINATE # The COORDINATE coordinates.
function ZONE_BASE:GetRandomPointVec2() end

---Define a random {Core.Point#COORDINATE} within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec3 table.
---@return COORDINATE # The COORDINATE coordinates.
function ZONE_BASE:GetRandomPointVec3() end

---Get the bounding square the zone.
---@return nil # The bounding square.
function ZONE_BASE:GetBoundingSquare() end

---Get surface type of the zone.
---@return SurfaceType # Type of surface.
function ZONE_BASE:GetSurfaceType() end

---Bound the zone boundaries with a tires.
function ZONE_BASE:BoundZone() end

---Set draw coalition of zone.
---@param Coalition? number (Optional) Coalition. Default -1.
---@return ZONE_BASE # self
function ZONE_BASE:SetDrawCoalition(Coalition) end

---Get draw coalition of zone.
---@return number # Draw coalition.
function ZONE_BASE:GetDrawCoalition() end

---Set color of zone.
---@param RGBcolor? table (Optional) RGB color table. Default `{1, 0, 0}`.
---@param Alpha? number (Optional) Transparency between 0 and 1. Default 0.15.
---@return ZONE_BASE # self
function ZONE_BASE:SetColor(RGBcolor, Alpha) end

---Get color table of the zone.
---@return table # Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
function ZONE_BASE:GetColor() end

---Get RGB color of zone.
---@return table # Table with three entries, e.g. {1, 0, 0}, which is the RGB color code.
function ZONE_BASE:GetColorRGB() end

---Get transparency Alpha value of zone.
---@return number # Alpha value.
function ZONE_BASE:GetColorAlpha() end

---Set fill color of zone.
---@param RGBcolor? table (Optional) RGB color table. Default `{1, 0, 0}`.
---@param Alpha? number (Optional) Transparacy between 0 and 1. Default 0.15.
---@return ZONE_BASE # self
function ZONE_BASE:SetFillColor(RGBcolor, Alpha) end

---Get fill color table of the zone.
---@return table # Table with four entries, e.g. {1, 0, 0, 0.15}. First three are RGB color code. Fourth is the transparency Alpha value.
function ZONE_BASE:GetFillColor() end

---Get RGB fill color of zone.
---@return table # Table with three entries, e.g. {1, 0, 0}, which is the RGB color code.
function ZONE_BASE:GetFillColorRGB() end

---Get transparency Alpha fill value of zone.
---@return number # Alpha value.
function ZONE_BASE:GetFillColorAlpha() end

---Remove the drawing of the zone from the F10 map.
---@param Delay? number (Optional) Delay before the drawing is removed.
---@return ZONE_BASE # self
function ZONE_BASE:UndrawZone(Delay) end

---Get ID of the zone object drawn on the F10 map.
---The ID can be used to remove the drawn object from the F10 map view via `UTILS.RemoveMark(MarkID)`.
---@return number # Unique ID of the
function ZONE_BASE:GetDrawID() end

---Smokes the zone boundaries in a color.
---@param SmokeColor? SMOKECOLOR The smoke color.
function ZONE_BASE:SmokeZone(SmokeColor) end

---Set the randomization probability of a zone to be selected.
---@param ZoneProbability? number A value between 0 and 1. 0 = 0% and 1 = 100% probability.
---@return ZONE_BASE # self
function ZONE_BASE:SetZoneProbability(ZoneProbability) end

---Get the randomization probability of a zone to be selected.
---@return number # A value between 0 and 1. 0 = 0% and 1 = 100% probability.
function ZONE_BASE:GetZoneProbability() end

---Get the coordinate on the radius of the zone nearest to Outsidecoordinate. Useto e.g. find an ingress point.
---@param Outsidecoordinate? COORDINATE The coordinate outside of the zone from where to look.
---@return COORDINATE # CoordinateOnRadius
function ZONE_BASE:FindNearestCoordinateOnRadius(Outsidecoordinate) end

---Get the zone taking into account the randomization probability of a zone to be selected.
---@return ZONE_BASE # The zone is selected taking into account the randomization probability factor.
---@return nil # The zone is not selected taking into account the randomization probability factor.
function ZONE_BASE:GetZoneMaybe() end

---Set the check time for ZONE:Trigger()
---@param seconds? number (Optional) Check every seconds for objects entering or leaving the zone. Defaults to 5 secs.
---@return ZONE_BASE # self
function ZONE_BASE:SetCheckTime(seconds) end

---Start watching if the Object or Objects move into or out of a zone.
---@param Objects? CONTROLLABLE Object or Objects to watch, can be of type UNIT, GROUP, CLIENT, or SET\_UNIT, SET\_GROUP, SET\_CLIENT
---@return ZONE_BASE # self
function ZONE_BASE:Trigger(Objects) end

---Toggle “partly-inside” handling for this zone. To be used before :Trigger().
---* Default:* flag is **false** until you call the method.
---* Call with no argument or with **true** → enable.
---* Call with **false** → disable again (handy if it was enabled before).
---@param state? any
---@return ZONE_BASE # self
function ZONE_BASE:SetPartlyInside(state) end

---(Internal) Check the assigned objects for being in/out of the zone
---@param fromstart? boolean If true, do the init of the objects
---@return ZONE_BASE # self
function ZONE_BASE:_TriggerCheck(fromstart) end

---(Internal) Check the assigned objects for being in/out of the zone
---@param From? string
---@param Event? string
---@param To? string
---@return ZONE_BASE # self
function ZONE_BASE:onafterTriggerRunCheck(From, Event, To) end

---Returns the Value of the zone with the given PropertyName, or nil if no matching property exists.
---@param PropertyName? string The name of a the TriggerZone Property to be retrieved.
---@return string # The Value of the TriggerZone Property with the given PropertyName, or nil if absent.
function ZONE_BASE:GetProperty(PropertyName) end

---Returns the zone Properties table.
---@return table # The Key:Value table of TriggerZone properties of the zone.
function ZONE_BASE:GetAllProperties() end

---The ZONE_RADIUS class, defined by a zone name, a location and a radius.
---@class ZONE_RADIUS : ZONE_BASE
---@field Vec2 Vec2 The current location of the zone.
---@field Radius number The radius of the zone.
ZONE_RADIUS = {
  ClassName="ZONE_RADIUS",
  }

---Constructor of {#ZONE_RADIUS}, taking the zone name, the zone location and a radius.
---@param ZoneName? string Name of the zone.
---@param Vec2? Vec2 The location of the zone.
---@param Radius? number The radius of the zone.
---@param DoNotRegisterZone? Boolean (Optional) Determines if the Zone should not be registered in the _Database Table. Default=false
---@return ZONE_RADIUS # self
function ZONE_RADIUS:New(ZoneName, Vec2, Radius, DoNotRegisterZone) end

---Update zone from a 2D vector.
---@param Vec2? Vec2 The location of the zone.
---@param Radius? number The radius of the zone.
---@return ZONE_RADIUS # self
function ZONE_RADIUS:UpdateFromVec2(Vec2, Radius) end

---Update zone from a 2D vector.
---@param Vec3? Vec3 The location of the zone.
---@param Radius? number The radius of the zone.
---@return ZONE_RADIUS # self
function ZONE_RADIUS:UpdateFromVec3(Vec3, Radius) end

---Mark the zone with markers on the F10 map.
---@param Points? number (Optional) The amount of points in the circle. Default 360.
---@return ZONE_RADIUS # self
function ZONE_RADIUS:MarkZone(Points) end

---Draw the zone circle on the F10 map.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return ZONE_RADIUS # self
function ZONE_RADIUS:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Bounds the zone with tires.
---@param Points? number (optional) The amount of points in the circle. Default 360.
---@param CountryID? country.id|number|string The country id of the tire objects, e.g. country.id.USA for blue or country.id.RUSSIA for red.
---@param UnBound? boolean (Optional) If true the tyres will be destroyed.
---@return ZONE_RADIUS # self
function ZONE_RADIUS:BoundZone(Points, CountryID, UnBound) end

---Smokes the zone boundaries in a color.
---@param SmokeColor? SMOKECOLOR The smoke color.
---@param Points? number (optional) The amount of points in the circle.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@param AngleOffset? any
---@return ZONE_RADIUS # self
function ZONE_RADIUS:SmokeZone(SmokeColor, Points, AddHeight, AngleOffset) end

---Flares the zone boundaries in a color.
---@param FlareColor? FLARECOLOR The flare color.
---@param Points? number (optional) The amount of points in the circle.
---@param Azimuth? Azimuth (optional) Azimuth The azimuth of the flare.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@return ZONE_RADIUS # self
function ZONE_RADIUS:FlareZone(FlareColor, Points, Azimuth, AddHeight) end

---Returns the radius of the zone.
---@return number # The radius of the zone.
function ZONE_RADIUS:GetRadius() end

---Sets the radius of the zone.
---@param Radius? number The radius of the zone.
---@return number # The radius of the zone.
function ZONE_RADIUS:SetRadius(Radius) end

---Returns the {DCS#Vec2} of the zone.
---@return Vec2 # The location of the zone.
function ZONE_RADIUS:GetVec2() end

---Sets the {DCS#Vec2} of the zone.
---@param Vec2? Vec2 The new location of the zone.
---@return Vec2 # The new location of the zone.
function ZONE_RADIUS:SetVec2(Vec2) end

---Returns the {DCS#Vec3} of the ZONE_RADIUS.
---@param Height? number The height to add to the land height where the center of the zone is located.
---@return Vec3 # The point of the zone.
function ZONE_RADIUS:GetVec3(Height) end

---Scan the zone for the presence of units of the given ObjectCategories.
---Note that **only after** a zone has been scanned, the zone can be evaluated by:
---
---  * {Core.Zone#ZONE_RADIUS.IsAllInZoneOfCoalition}(): Scan the presence of units in the zone of a coalition.
---  * {Core.Zone#ZONE_RADIUS.IsAllInZoneOfOtherCoalition}(): Scan the presence of units in the zone of an other coalition.
---  * {Core.Zone#ZONE_RADIUS.IsSomeInZoneOfCoalition}(): Scan if there is some presence of units in the zone of the given coalition.
---  * {Core.Zone#ZONE_RADIUS.IsNoneInZoneOfCoalition}(): Scan if there isn't any presence of units in the zone of an other coalition than the given one.
---  * {Core.Zone#ZONE_RADIUS.IsNoneInZone}(): Scan if the zone is empty.
---@param ObjectCategories? any
---@param UnitCategories? any
---@param UseZoneCenterSnapshot? boolean (Optional) Use one circular centre/radius snapshot for this synchronous scan. Omit for subclass geometry.
function ZONE_RADIUS:Scan(ObjectCategories, UnitCategories, UseZoneCenterSnapshot) end

---Remove junk inside the zone using the `world.removeJunk` function.
---@return number # Number of deleted objects.
function ZONE_RADIUS:RemoveJunk() end

---Get a table  of scanned units.
---@return table # Table of DCS units and DCS statics inside the zone.
function ZONE_RADIUS:GetScannedUnits() end

---Get a set of scanned units.
---@param Coalition? number (optional) Filter for this coalition only.
---@return SET_UNIT # Set of units and statics inside the zone.
function ZONE_RADIUS:GetScannedSetUnit(Coalition) end

---Get a set of scanned groups.
---@param Coalition? number (optional) Filter for this coalition only.
---@return SET_GROUP # Set of groups.
function ZONE_RADIUS:GetScannedSetGroup(Coalition) end

---Count the number of different coalitions inside the zone.
---@return number # Counted coalitions.
function ZONE_RADIUS:CountScannedCoalitions() end

---Check if a certain coalition is inside a scanned zone.
---@param Coalition? number The coalition id, e.g. coalition.side.BLUE.
---@return boolean # If true, the coalition is inside the zone.
function ZONE_RADIUS:CheckScannedCoalition(Coalition) end

---Get Coalitions of the units in the Zone, or Check if there are units of the given Coalition in the Zone.
---Returns nil if there are none to two Coalitions in the zone!
---Returns one Coalition if there are only Units of one Coalition in the Zone.
---Returns the Coalition for the given Coalition if there are units of the Coalition in the Zone.
---@param Coalition? any
---@return table
function ZONE_RADIUS:GetScannedCoalition(Coalition) end

---Get scanned scenery type
---@param SceneryType? any
---@return table # Table of DCS scenery type objects.
function ZONE_RADIUS:GetScannedSceneryType(SceneryType) end

---Get scanned scenery table
---@return table # Structured object table: [type].[name].SCENERY
function ZONE_RADIUS:GetScannedScenery() end

---Get table of scanned scenery objects
---@return table # Table of SCENERY objects.
function ZONE_RADIUS:GetScannedSceneryObjects() end

---Get set of scanned scenery objects
---@return table # Table of Wrapper.Scenery#SCENERY scenery objects.
function ZONE_RADIUS:GetScannedSetScenery() end

---Is All in Zone of Coalition?
---Check if only the specified coalition is inside the zone and no one else.
---@param Coalition? number Coalition ID of the coalition which is checked to be the only one in the zone.
---@return boolean # True, if **only** that coalition is inside the zone and no one else.
function ZONE_RADIUS:IsAllInZoneOfCoalition(Coalition) end

---Is All in Zone of Other Coalition?
---Check if only one coalition is inside the zone and the specified coalition is not the one.
---You first need to use the {#ZONE_RADIUS.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@param Coalition? number Coalition ID of the coalition which is not supposed to be in the zone.
---@return boolean # True, if and only if only one coalition is inside the zone and the specified coalition is not it.
function ZONE_RADIUS:IsAllInZoneOfOtherCoalition(Coalition) end

---Is Some in Zone of Coalition?
---Check if more than one coalition is inside the zone and the specified coalition is one of them.
---You first need to use the {#ZONE_RADIUS.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@param Coalition? number ID of the coalition which is checked to be inside the zone.
---@return boolean # True if more than one coalition is inside the zone and the specified coalition is one of them.
function ZONE_RADIUS:IsSomeInZoneOfCoalition(Coalition) end

---Is None in Zone of Coalition?
---You first need to use the {#ZONE_RADIUS.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@param Coalition? any
---@return boolean
function ZONE_RADIUS:IsNoneInZoneOfCoalition(Coalition) end

---Is None in Zone?
---You first need to use the {#ZONE_RADIUS.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@return boolean
function ZONE_RADIUS:IsNoneInZone() end

---Searches the zone
---@param EvaluateFunction? any
---@param ObjectCategories? any
function ZONE_RADIUS:SearchZone(EvaluateFunction, ObjectCategories) end

---Returns if a location is within the zone.
---@param Vec2? Vec2 The location to test.
---@return boolean # true if the location is within the zone.
function ZONE_RADIUS:IsVec2InZone(Vec2) end

---Returns if a point is within the zone.
---@param Vec3? Vec3 The point to test.
---@return boolean # true if the point is within the zone.
function ZONE_RADIUS:IsVec3InZone(Vec3) end

---Search for clear ground spawn zones within this zone. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param PosRadius? number Required clear radius around each position.
---@param NumPositions? number Number of positions to find.
---@return table # A table of DCS#Vec2 positions that are clear of map objects within the given PosRadius. nil if no clear positions are found.
function ZONE_RADIUS:GetClearZonePositions(PosRadius, NumPositions) end

---Search for a random clear ground spawn coordinate within this zone. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param PosRadius? number (Optional) Required clear radius around each position. (Default is math.min(Radius/10, 200))
---@param NumPositions? number (Optional) Number of positions to find. (Default 50)
---@return COORDINATE # A random coordinate for a clear zone. nil if no clear positions are found.
---@return number # Assigned radius for the found zones. nil if no clear positions are found.
function ZONE_RADIUS:GetRandomClearZoneCoordinate(PosRadius, NumPositions) end

---Returns a random Vec2 location within the zone.
---@param inner? number (Optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (Optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@param surfacetypes? table (Optional) Table of surface types. Can also be a single surface type. We will try max 100 times to find the right type!
---@return Vec2 # The random location within the zone.
function ZONE_RADIUS:GetRandomVec2(inner, outer, surfacetypes) end

---Returns a {Core.Point#COORDINATE} object reflecting a random 2D location within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec2 table.
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE # The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_RADIUS:GetRandomPointVec2(inner, outer) end

---Returns Returns a random Vec3 location within the zone.
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return Vec3 # The random location within the zone.
function ZONE_RADIUS:GetRandomVec3(inner, outer) end

---Returns a {Core.Point#COORDINATE} object reflecting a random 3D location within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec3 table.
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE # The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_RADIUS:GetRandomPointVec3(inner, outer) end

---Returns a {Core.Point#COORDINATE} object reflecting a random 3D location within the zone.
---@param inner? number (Optional) Minimal distance from the center of the zone in meters. Default is 0 m.
---@param outer? number (Optional) Maximal distance from the outer edge of the zone in meters. Default is the radius of the zone.
---@param surfacetypes? table (Optional) Table of surface types. Can also be a single surface type. We will try max 100 times to find the right type!
---@return COORDINATE # The random coordinate.
function ZONE_RADIUS:GetRandomCoordinate(inner, outer, surfacetypes) end

---Returns a {Core.Point#COORDINATE} object reflecting a random location within the zone where there are no **map objects** of type "Building".
---Does not find statics you might have placed there. **Note** This might be quite CPU intensive, use with care.
---@param inner? number (Optional) Minimal distance from the center of the zone in meters. Default is 0m.
---@param outer? number (Optional) Maximal distance from the outer edge of the zone in meters. Default is the radius of the zone.
---@param distance? number (Optional) Minimum distance from any building coordinate. Defaults to 100m.
---@param markbuildings? boolean (Optional) Place markers on found buildings (if any).
---@param markfinal? boolean (Optional) Place marker on the final coordinate (if any).
---@return COORDINATE # The random coordinate or `nil` if cannot be found in 1000 iterations.
function ZONE_RADIUS:GetRandomCoordinateWithoutBuildings(inner, outer, distance, markbuildings, markfinal) end

---@class ZONE : ZONE_RADIUS
ZONE = {
  ClassName="ZONE",
  }

---Constructor of ZONE taking the zone name.
---@param ZoneName? string The name of the zone as defined within the mission editor.
---@return ZONE # self
function ZONE:New(ZoneName) end

---Find a zone in the _DATABASE using the name of the zone.
---@param ZoneName? string The name of the zone.
---@return ZONE # self
function ZONE:FindByName(ZoneName) end

---@class ZONE_UNIT : ZONE_RADIUS
---@field ZoneUNIT UNIT
ZONE_UNIT = {
  ClassName="ZONE_UNIT",
  }

---Constructor to create a ZONE_UNIT instance, taking the zone name, a zone unit and a radius and optional offsets in X and Y directions.
---@param ZoneName? string Name of the zone.
---@param ZoneUNIT? UNIT The unit as the center of the zone.
---@param Radius? number The radius of the zone in meters.
---@param Offset? table A table specifying the offset. The offset table may have the following elements: dx The offset in X direction, +x is north. dy The offset in Y direction, +y is east. rho The distance of the zone from the unit theta The azimuth of the zone relative to unit relative_to_unit If true, theta is measured clockwise from unit's direction else clockwise from north. If using dx, dy setting this to true makes +x parallel to unit heading. dx, dy OR rho, theta may be used, not both.
---@return ZONE_UNIT # self
function ZONE_UNIT:New(ZoneName, ZoneUNIT, Radius, Offset) end

---Updates the current location from a {Wrapper.Group}.
---@param Unit? any
---@return self
function ZONE_UNIT:UpdateFromUnit(Unit) end

---Returns the current location of the {Wrapper.Unit#UNIT}.
---@return Vec2 # The location of the zone based on the @{Wrapper.Unit#UNIT}location and the offset, if any.
function ZONE_UNIT:GetVec2() end

---Returns a random location within the zone.
---@return Vec2 # The random location within the zone.
function ZONE_UNIT:GetRandomVec2() end

---Returns the {DCS#Vec3} of the ZONE_UNIT.
---@param Height? number The height to add to the land height where the center of the zone is located.
---@return Vec3 # The point of the zone.
function ZONE_UNIT:GetVec3(Height) end

---@class ZONE_GROUP : ZONE_RADIUS
ZONE_GROUP = {
  ClassName="ZONE_GROUP",
  }

---Constructor to create a ZONE_GROUP instance, taking the zone name, a zone {Wrapper.Group#GROUP} and a radius.
---@param ZoneName? string Name of the zone.
---@param ZoneGROUP? GROUP The @{Wrapper.Group} as the center of the zone.
---@param Radius? number The radius of the zone.
---@return ZONE_GROUP # self
function ZONE_GROUP:New(ZoneName, ZoneGROUP, Radius) end

---Returns the current location of the {Wrapper.Group}.
---@return Vec2 # The location of the zone based on the @{Wrapper.Group} location.
function ZONE_GROUP:GetVec2() end

---Updates the current location from a {Wrapper.Group}.
---@param Group? GROUP (optional) Update from this Group, if nil, update from the GROUP this zone is based on.
---@return self
function ZONE_GROUP:UpdateFromGroup(Group) end

---Returns a random location within the zone of the {Wrapper.Group}.
---@return Vec2 # The random location of the zone based on the @{Wrapper.Group} location.
function ZONE_GROUP:GetRandomVec2() end

---Returns a {Core.Point#COORDINATE} object reflecting a random 2D location within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec2 table.
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE # The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_GROUP:GetRandomPointVec2(inner, outer) end

---Ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Triangle.lua
---This triangle "zone" is not really to be used on its own, it only serves as building blocks for
---ZONE_POLYGON to accurately find a point inside a polygon; as well as getting the correct surface area of
---a polygon.
---@class _ZONE_TRIANGLE : ZONE_BASE
_ZONE_TRIANGLE = {
    ClassName="ZONE_TRIANGLE",
    Points={},
    Coords={},
    CenterVec2={x=0, y=0},
    SurfaceArea=0,
    DrawID={}
}

---@param p1? Vec
---@param p2? Vec
---@param p3? Vec
---@return _ZONE_TRIANGLE # self
function _ZONE_TRIANGLE:New(p1, p2, p3) end

---Checks if a point is contained within the triangle.
---@param pt? table The point to check
---@param points? table (optional) The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@return boolean # True if the point is contained, false otherwise
function _ZONE_TRIANGLE:ContainsPoint(pt, points) end

---Returns a random Vec2 within the triangle.
---@param points? table The points of the triangle, or 3 other points if you're just using the TRIANGLE class without an object of it
---@return table # The random Vec2
function _ZONE_TRIANGLE:GetRandomVec2(points) end

---Draw the triangle
---@param Coalition? any
---@param Color? any
---@param Alpha? any
---@param FillColor? any
---@param FillAlpha? any
---@param LineType? any
---@param ReadOnly? any
---@return table # of draw IDs
function _ZONE_TRIANGLE:Draw(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Draw the triangle
---@param Coalition? any
---@param FillColor? any
---@param FillAlpha? any
---@param ReadOnly? any
---@return table # of draw IDs
function _ZONE_TRIANGLE:Fill(Coalition, FillColor, FillAlpha, ReadOnly) end

---@class ZONE_POLYGON_BASE : ZONE_BASE
---@field Polygon ZONE_POLYGON_BASE.ListVec2 The polygon defined by an array of @{DCS#Vec2}.
---@field SurfaceArea number
---@field DrawID table
---@field FillTriangles table
---@field _Triangles table
---@field Borderlines table
ZONE_POLYGON_BASE = {
  ClassName="ZONE_POLYGON_BASE",
  _Triangles={}, -- #table of #_ZONE_TRIANGLE
  SurfaceArea=0,
  DrawID={}, -- making a table out of the MarkID so its easier to draw an n-sided polygon, see ZONE_POLYGON_BASE:Draw()
  FillTriangles = {},
  Borderlines = {},
}

---Constructor to create a ZONE_POLYGON_BASE instance, taking the zone name and an array of {DCS#Vec2}, forming a polygon.
---The {Wrapper.Group#GROUP} waypoints define the polygon corners. The first and the last point are automatically connected.
---@param ZoneName? string Name of the zone.
---@param PointsArray? ZONE_POLYGON_BASE.ListVec2|number|string An array of @{DCS#Vec2}, forming a polygon.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:New(ZoneName, PointsArray) end

---Triangulates the polygon.
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---@return table # The #_ZONE_TRIANGLE list that makes up the polygon
function ZONE_POLYGON_BASE:_Triangulate() end

---Update polygon points with an array of {DCS#Vec2}.
---@param Vec2Array? ZONE_POLYGON_BASE.ListVec2|number|string An array of @{DCS#Vec2}, forming a polygon.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:UpdateFromVec2(Vec2Array) end

---Update polygon points with an array of {DCS#Vec3}.
---@param Vec3Array? any
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:UpdateFromVec3(Vec3Array) end

---Calculates the surface area of the polygon. The surface area is the sum of the areas of the triangles that make up the polygon.
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---@return number # The surface area of the polygon
function ZONE_POLYGON_BASE:_CalculateSurfaceArea() end

---Returns the center location of the polygon.
---@return Vec2 # The location of the zone based on the @{Wrapper.Group} location.
function ZONE_POLYGON_BASE:GetVec2() end

---Get a vertex of the polygon.
---@param Index? number (Optional) Index of the vertex. Default 1.
---@return Vec2 # Vertex of the polygon.
function ZONE_POLYGON_BASE:GetVertexVec2(Index) end

---Get a vertex of the polygon.
---@param Index? number (Optional) Index of the vertex. Default 1.
---@return Vec3 # Vertex of the polygon.
function ZONE_POLYGON_BASE:GetVertexVec3(Index) end

---Get a vertex of the polygon.
---@param Index? number (Optional) Index of the vertex. Default 1.
---@return COORDINATE # Vertex of the polygon.
function ZONE_POLYGON_BASE:GetVertexCoordinate(Index) end

---Get a list of verticies of the polygon.
---@return any # List of DCS#Vec2 verticies defining the edges of the polygon.
function ZONE_POLYGON_BASE:GetVerticiesVec2() end

---Get a list of verticies of the polygon.
---@return table # List of DCS#Vec3 verticies defining the edges of the polygon.
function ZONE_POLYGON_BASE:GetVerticiesVec3() end

---Get a list of verticies of the polygon.
---@return table # List of COORDINATES verticies defining the edges of the polygon.
function ZONE_POLYGON_BASE:GetVerticiesCoordinates() end

---Flush polygon coordinates as a table in DCS.log.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:Flush() end

---Search for clear ground spawn zones within this zone. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param PosRadius? number Required clear radius around each position.
---@param NumPositions? number Number of positions to find.
---@return table # A table of DCS#Vec2 positions that are clear of map objects within the given PosRadius. nil if no clear positions are found.
function ZONE_POLYGON_BASE:GetClearZonePositions(PosRadius, NumPositions) end

---Search for a random clear ground spawn coordinate within this zone. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param PosRadius? number (Optional) Required clear radius around each position. (Default is math.min(Radius/10, 200))
---@param NumPositions? number (Optional) Number of positions to find. (Default 50)
---@return COORDINATE # A random coordinate for a clear zone. nil if no clear positions are found.
---@return number # Assigned radius for the found zones. nil if no clear positions are found.
function ZONE_POLYGON_BASE:GetRandomClearZoneCoordinate(PosRadius, NumPositions) end

---Smokes the zone boundaries in a color.
---@param UnBound? boolean If true, the tyres will be destroyed.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:BoundZone(UnBound) end

---Draw the zone on the F10 map.  Infinite number of points supported
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value. -- doesn't seem to work
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.                                                 -- doesn't seem to work
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.s
---@param IncludeTriangles? any
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly, IncludeTriangles) end

---Change/Re-fill a Polygon Zone
---@param Color? table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:ReFill(Color, Alpha) end

---Change/Re-draw the border of a Polygon Zone
---@param Color? table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@return ZONE_POLYGON_BASE
function ZONE_POLYGON_BASE:ReDrawBorderline(Color, Alpha, LineType) end

---Get the surface area of this polygon
---@return number # Surface area
function ZONE_POLYGON_BASE:GetSurfaceArea() end

---Get the smallest radius encompassing all points of the polygon zone.
---@return number # Radius of the zone in meters.
function ZONE_POLYGON_BASE:GetRadius() end

---Get the smallest circular zone encompassing all points of the polygon zone.
---@param ZoneName? string (Optional) Name of the zone. Default is the name of the polygon zone.
---@param DoNotRegisterZone? boolean (Optional) If `true`, zone is not registered.
---@return ZONE_RADIUS # The circular zone.
function ZONE_POLYGON_BASE:GetZoneRadius(ZoneName, DoNotRegisterZone) end

---Get the smallest rectangular zone encompassing all points points of the polygon zone.
---@param ZoneName? string (Optional) Name of the zone. Default is the name of the polygon zone.
---@param DoNotRegisterZone? boolean (Optional) If `true`, zone is not registered.
---@return ZONE_POLYGON # The rectangular zone.
function ZONE_POLYGON_BASE:GetZoneQuad(ZoneName, DoNotRegisterZone) end

---Remove junk inside the zone. Due to DCS limitations, this works only for rectangular zones. So we get the smallest rectangular zone encompassing all points points of the polygon zone.
---@param Height? number (Optional) Height of the box in meters. Default 1000.
---@return number # Number of removed objects.
function ZONE_POLYGON_BASE:RemoveJunk(Height) end

---Smokes the zone boundaries in a color.
---@param SmokeColor? SMOKECOLOR The smoke color.
---@param Segments? number (Optional) Number of segments within boundary line. Default 10.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:SmokeZone(SmokeColor, Segments) end

---Flare the zone boundaries in a color.
---@param FlareColor? FLARECOLOR The flare color.
---@param Segments? number (Optional) Number of segments within boundary line. Default 10.
---@param Azimuth? Azimuth (optional) Azimuth The azimuth of the flare.
---@param AddHeight? number (optional) The height to be added for the smoke.
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:FlareZone(FlareColor, Segments, Azimuth, AddHeight) end

---Returns if a location is within the zone.
---Source learned and taken from: https://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
---@param Vec2? Vec2 The location to test.
---@return boolean # true if the location is within the zone.
function ZONE_POLYGON_BASE:IsVec2InZone(Vec2) end

---Returns if a point is within the zone.
---@param Vec3? Vec3 The point to test.
---@return boolean # true if the point is within the zone.
function ZONE_POLYGON_BASE:IsVec3InZone(Vec3) end

---Define a random {DCS#Vec2} within the zone.
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Polygon.lua
---@return Vec2 # The Vec2 coordinate.
function ZONE_POLYGON_BASE:GetRandomVec2() end

---Return a {Core.Point#COORDINATE} object representing a random 2D point at landheight within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec2 table.
---@return any
function ZONE_POLYGON_BASE:GetRandomPointVec2() end

---Return a {Core.Point#COORDINATE} object representing a random 3D point at landheight within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec3 table.
---@return any
function ZONE_POLYGON_BASE:GetRandomPointVec3() end

---Return a {Core.Point#COORDINATE} object representing a random 3D point at landheight within the zone.
---@return COORDINATE
function ZONE_POLYGON_BASE:GetRandomCoordinate() end

---Get the bounding square the zone.
---@return ZONE_POLYGON_BASE.BoundingSquare # The bounding square.
function ZONE_POLYGON_BASE:GetBoundingSquare() end

---Get the bounding 2D vectors of the polygon.
---@return Vec2 # Coordinates of western-southern-lower vertex of the box.
---@return Vec2 # Coordinates of eastern-northern-upper vertex of the box.
function ZONE_POLYGON_BASE:GetBoundingVec2() end

---Draw a frontier on the F10 map with small filled circles.
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1= All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1, 0, 0} for red. Default {1, 1, 1}= White.
---@param Radius? number (Optional) Radius of the circles in meters. Default 1000.
---@param Alpha? number (Optional) Alpha transparency [0,1]. Default 1.
---@param Segments? number (Optional) Number of segments within boundary line. Default 10.
---@param Closed? boolean (Optional) Link the last point with the first one to obtain a closed boundary. Default false
---@return ZONE_POLYGON_BASE # self
function ZONE_POLYGON_BASE:Boundary(Coalition, Color, Radius, Alpha, Segments, Closed) end

---@class ZONE_POLYGON : ZONE_POLYGON_BASE
ZONE_POLYGON = {
  ClassName="ZONE_POLYGON",
  }

---Constructor to create a ZONE_POLYGON instance, taking the zone name and the {Wrapper.Group#GROUP} defined within the Mission Editor.
---The {Wrapper.Group#GROUP} waypoints define the polygon corners. The first and the last point are automatically connected by ZONE_POLYGON.
---@param ZoneName? string Name of the zone.
---@param ZoneGroup? GROUP The GROUP waypoints as defined within the Mission Editor define the polygon shape.
---@return ZONE_POLYGON # self
function ZONE_POLYGON:New(ZoneName, ZoneGroup) end

---Constructor to create a ZONE_POLYGON instance, taking the zone name and an array of DCS#Vec2, forming a polygon.
---@param ZoneName? string Name of the zone.
---@param PointsArray? ZONE_POLYGON_BASE.ListVec2|number|string An array of @{DCS#Vec2}, forming a polygon.
---@return ZONE_POLYGON # self
function ZONE_POLYGON:NewFromPointsArray(ZoneName, PointsArray) end

---Constructor to create a ZONE_POLYGON instance, taking the zone name and the **name** of the {Wrapper.Group#GROUP} defined within the Mission Editor.
---The {Wrapper.Group#GROUP} waypoints define the polygon corners. The first and the last point are automatically connected by ZONE_POLYGON.
---@param GroupName? string The group name of the GROUP defining the waypoints within the Mission Editor to define the polygon shape.
---@return ZONE_POLYGON # self
function ZONE_POLYGON:NewFromGroupName(GroupName) end

---Constructor to create a ZONE_POLYGON instance, taking the name of a drawing made with the draw tool in the Mission Editor.
---@param DrawingName? string The name of the drawing in the Mission Editor
---@return ZONE_POLYGON # self
function ZONE_POLYGON:NewFromDrawing(DrawingName) end

---Find a polygon zone in the _DATABASE using the name of the polygon zone.
---@param ZoneName? string The name of the polygon zone.
---@return ZONE_POLYGON # self
function ZONE_POLYGON:FindByName(ZoneName) end

---Scan the zone for the presence of units of the given ObjectCategories. Does **not** scan for scenery at the moment.
---Note that **only after** a zone has been scanned, the zone can be evaluated by:
---
---  * {Core.Zone#ZONE_POLYGON.IsAllInZoneOfCoalition}(): Scan the presence of units in the zone of a coalition.
---  * {Core.Zone#ZONE_POLYGON.IsAllInZoneOfOtherCoalition}(): Scan the presence of units in the zone of an other coalition.
---  * {Core.Zone#ZONE_POLYGON.IsSomeInZoneOfCoalition}(): Scan if there is some presence of units in the zone of the given coalition.
---  * {Core.Zone#ZONE_POLYGON.IsNoneInZoneOfCoalition}(): Scan if there isn't any presence of units in the zone of an other coalition than the given one.
---  * {Core.Zone#ZONE_POLYGON.IsNoneInZone}(): Scan if the zone is empty.
---@param ObjectCategories? any
---@param UnitCategories? any
function ZONE_POLYGON:Scan(ObjectCategories, UnitCategories) end

---Count the number of different coalitions inside the zone.
---@return table # Table of DCS units and DCS statics inside the zone.
function ZONE_POLYGON:GetScannedUnits() end

---Get a set of scanned units.
---@return SET_UNIT # Set of units and statics inside the zone.
function ZONE_POLYGON:GetScannedSetUnit() end

---Get a set of scanned units.
---@return SET_GROUP # Set of groups.
function ZONE_POLYGON:GetScannedSetGroup() end

---Count the number of different coalitions inside the zone.
---@return number # Counted coalitions.
function ZONE_POLYGON:CountScannedCoalitions() end

---Check if a certain coalition is inside a scanned zone.
---@param Coalition? number The coalition id, e.g. coalition.side.BLUE.
---@return boolean # If true, the coalition is inside the zone.
function ZONE_POLYGON:CheckScannedCoalition(Coalition) end

---Get Coalitions of the units in the Zone, or Check if there are units of the given Coalition in the Zone.
---Returns nil if there are none to two Coalitions in the zone!
---Returns one Coalition if there are only Units of one Coalition in the Zone.
---Returns the Coalition for the given Coalition if there are units of the Coalition in the Zone.
---@param Coalition? any
---@return table
function ZONE_POLYGON:GetScannedCoalition(Coalition) end

---Get scanned scenery types
---@param SceneryType? any
---@return table # Table of DCS scenery type objects.
function ZONE_POLYGON:GetScannedSceneryType(SceneryType) end

---Get scanned scenery table
---@return table # Table of Wrapper.Scenery#SCENERY scenery objects.
function ZONE_POLYGON:GetScannedSceneryObjects() end

---Get scanned scenery table
---@return table # Structured table of [type].[name].Wrapper.Scenery#SCENERY scenery objects.
function ZONE_POLYGON:GetScannedScenery() end

---Get scanned set of scenery objects
---@return table # Table of Wrapper.Scenery#SCENERY scenery objects.
function ZONE_POLYGON:GetScannedSetScenery() end

---Is All in Zone of Coalition?
---Check if only the specified coalition is inside the zone and noone else.
---@param Coalition? number Coalition ID of the coalition which is checked to be the only one in the zone.
---@return boolean # True, if **only** that coalition is inside the zone and no one else.
function ZONE_POLYGON:IsAllInZoneOfCoalition(Coalition) end

---Is All in Zone of Other Coalition?
---Check if only one coalition is inside the zone and the specified coalition is not the one.
---You first need to use the {#ZONE_POLYGON.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@param Coalition? number Coalition ID of the coalition which is not supposed to be in the zone.
---@return boolean # True, if and only if only one coalition is inside the zone and the specified coalition is not it.
function ZONE_POLYGON:IsAllInZoneOfOtherCoalition(Coalition) end

---Is Some in Zone of Coalition?
---Check if more than one coalition is inside the zone and the specified coalition is one of them.
---You first need to use the {#ZONE_POLYGON.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@param Coalition? number ID of the coalition which is checked to be inside the zone.
---@return boolean # True if more than one coalition is inside the zone and the specified coalition is one of them.
function ZONE_POLYGON:IsSomeInZoneOfCoalition(Coalition) end

---Is None in Zone of Coalition?
---You first need to use the {#ZONE_POLYGON.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@param Coalition? any
---@return boolean
function ZONE_POLYGON:IsNoneInZoneOfCoalition(Coalition) end

---Is None in Zone?
---You first need to use the {#ZONE_POLYGON.Scan} method to scan the zone before it can be evaluated!
---Note that once a zone has been scanned, multiple evaluations can be done on the scan result set.
---@return boolean
function ZONE_POLYGON:IsNoneInZone() end

---Constructor to create a ZONE_ELASTIC instance.
---@param ZoneName? string Name of the zone.
---@param Points? Vec2 (Optional) Fixed points.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:New(ZoneName, Points) end

---Add a vertex (point) to the polygon.
---@param Vec2? Vec2 Point in 2D (with x and y coordinates).
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:AddVertex2D(Vec2) end

---Remove a vertex (point) from the polygon.
---@param Vec2? Vec2 Point in 2D (with x and y coordinates).
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:RemoveVertex2D(Vec2) end

---Remove a vertex (point) from the polygon.
---@param Vec3? Vec3 Point in 3D (with x, y and z coordinates). Only the x and z coordinates are used.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:RemoveVertex3D(Vec3) end

---Add a vertex (point) to the polygon.
---@param Vec3? Vec3 Point in 3D (with x, y and z coordinates). Only the x and z coordinates are used.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:AddVertex3D(Vec3) end

---Add a set of groups. Positions of the group will be considered as polygon vertices when contructing the convex hull.
---@param GroupSet? SET_GROUP Set of groups.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:AddSetGroup(GroupSet) end

---Update the convex hull of the polygon.
---This uses the [Graham scan](https://en.wikipedia.org/wiki/Graham_scan).
---@param Delay? number (Optional) Delay in seconds before the zone is updated. Default 0.
---@param Draw? boolean (Optional) Draw the zone. Default `nil`.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:Update(Delay, Draw) end

---Start the updating scheduler.
---@param Tstart? number Time in seconds before the updating starts.
---@param dT? number (Optional) Time interval in seconds between updates. Default 60 sec.
---@param Tstop? number (Optional) Time in seconds after which the updating stops. Default `nil`.
---@param Draw? boolean (Optional) Draw the zone. Default `nil`.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:StartUpdate(Tstart, dT, Tstop, Draw) end

---Stop the updating scheduler.
---@param Delay? number (Optional) Delay in seconds before the scheduler will be stopped. Default 0.
---@return ZONE_ELASTIC # self
function ZONE_ELASTIC:StopUpdate(Delay) end

---Create a convex hull.
---@param pl? table Points
---@return table # Points
function ZONE_ELASTIC:_ConvexHull(pl) end

---ZONE_OVAL created from a center point, major axis, minor axis, and angle.
---Ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---@class ZONE_OVAL : ZONE_BASE
ZONE_OVAL = {
    ClassName = "OVAL",
    ZoneName="",
    MajorAxis = nil,
    MinorAxis = nil,
    Angle = 0,
    DrawPoly = nil -- let's just use a ZONE_POLYGON to draw the ZONE_OVAL on the map
}

---Creates a new ZONE_OVAL from a center point, major axis, minor axis, and angle.
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---@param name? string Name of the zone.
---@param vec2? table The center point of the oval
---@param major_axis? number The major axis of the oval
---@param minor_axis? number The minor axis of the oval
---@param angle? number The angle of the oval
---@return ZONE_OVAL # The new oval
function ZONE_OVAL:New(name, vec2, major_axis, minor_axis, angle) end

---Constructor to create a ZONE_OVAL instance, taking the name of a drawing made with the draw tool in the Mission Editor.
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---@param DrawingName? string The name of the drawing in the Mission Editor
---@return ZONE_OVAL # self
function ZONE_OVAL:NewFromDrawing(DrawingName) end

---Gets the major axis of the oval.
---@return number # The major axis of the oval
function ZONE_OVAL:GetMajorAxis() end

---Gets the minor axis of the oval.
---@return number # The minor axis of the oval
function ZONE_OVAL:GetMinorAxis() end

---Gets the angle of the oval.
---@return number # The angle of the oval
function ZONE_OVAL:GetAngle() end

---Returns a the center point of the oval
---@return table # The center Vec2
function ZONE_OVAL:GetVec2() end

---Checks if a point is contained within the oval.
---@param vec2? any
---@return boolean # True if the point is contained, false otherwise
function ZONE_OVAL:IsVec2InZone(vec2) end

---Calculates the bounding box of the oval. The bounding box is the smallest rectangle that contains the oval.
---@return table # The bounding box of the oval
function ZONE_OVAL:GetBoundingSquare() end

---Find points on the edge of the oval
---@param num_points? number How many points should be found. More = smoother shape
---@return table # Points on he edge
function ZONE_OVAL:PointsOnEdge(num_points) end

---Returns a random Vec2 within the oval.
---@return table # The random Vec2
function ZONE_OVAL:GetRandomVec2() end

---Define a random {Core.Point#COORDINATE} within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec2 table.
---@return COORDINATE # The COORDINATE coordinates.
function ZONE_OVAL:GetRandomPointVec2() end

---Define a random {Core.Point#COORDINATE} within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec3 table.
---@return COORDINATE # The COORDINATE coordinates.
function ZONE_OVAL:GetRandomPointVec3() end

---Draw the zone on the F10 map.
---ported from https://github.com/nielsvaes/CCMOOSE/blob/master/Moose%20Development/Moose/Shapes/Oval.lua
---@param Coalition? number (Optional) Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha? number (Optional) Transparency [0,1]. Default 1.
---@param FillColor? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value. -- doesn't seem to work
---@param FillAlpha? number (Optional) Transparency [0,1]. Default 0.15.                                                 -- doesn't seem to work
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@return ZONE_OVAL # self
function ZONE_OVAL:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType) end

---Remove drawing from F10 map
function ZONE_OVAL:UndrawZone() end

---Constructor to create a ZONE_AIRBASE instance, taking the zone name, a zone {Wrapper.Airbase#AIRBASE} and a radius.
---@param AirbaseName? string Name of the airbase.
---@param Radius? number (Optional)The radius of the zone in meters. Default 4000 meters.
---@return ZONE_AIRBASE # self
function ZONE_AIRBASE:New(AirbaseName, Radius) end

---Get the airbase as part of the ZONE_AIRBASE object.
---@return AIRBASE # The airbase.
function ZONE_AIRBASE:GetAirbase() end

---Returns the current location of the AIRBASE.
---@return Vec2 # The location of the zone based on the AIRBASE location.
function ZONE_AIRBASE:GetVec2() end

---Returns a {Core.Point#COORDINATE} object reflecting a random 2D location within the zone. Note that this is actually a {Core.Point#COORDINATE} type object, and not a simple Vec2 table.
---@param inner? number (optional) Minimal distance from the center of the zone. Default is 0.
---@param outer? number (optional) Maximal distance from the outer edge of the zone. Default is the radius of the zone.
---@return COORDINATE # The @{Core.Point#COORDINATE} object reflecting the random 3D location within the zone.
function ZONE_AIRBASE:GetRandomPointVec2(inner, outer) end

---Triggers the FSM event "TriggerStop". Stops the ZONE_BASE Trigger.
function ZONE_BASE:TriggerStop() end

---Triggers the FSM event "TriggerStop" after a delay.
---@param delay? number Delay in seconds.
function ZONE_BASE:__TriggerStop(delay) end

---On After "EnteredZone" event. An observed object has entered the zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Controllable? CONTROLLABLE The controllable entering the zone.
function ZONE_BASE:OnAfterEnteredZone(From, Event, To, Controllable) end

---On After "LeftZone" event. An observed object has left the zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Controllable? CONTROLLABLE The controllable leaving the zone.
function ZONE_BASE:OnAfterLeftZone(From, Event, To, Controllable) end

---On After "ObjectDead" event. An observed object has left the zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Controllable? CONTROLLABLE The controllable which died. Might be nil.
function ZONE_BASE:OnAfterObjectDead(From, Event, To, Controllable) end

---On After "ZoneEmpty" event. All observed objects have left the zone or are dead.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ZONE_BASE:OnAfterZoneEmpty(From, Event, To) end
