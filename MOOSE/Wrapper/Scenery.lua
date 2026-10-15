---@meta

---SCENERY Class
---@class SCENERY : POSITIONABLE
---@field ClassName string Name of the class.
---@field SceneryName string Name of the scenery object.
---@field SceneryObject Object DCS scenery object.
---@field Life0 number Initial life points.
---@field Properties table .
---@field ID number .
---@field SceneryZone ZONE_POLYGON .
---@field Coordinate COORDINATE .
---@field Vec2 Vec2 .
---@field Vec3 Vec3 .
---@field Vector VECTOR .
SCENERY = {
  ClassName = "SCENERY",
}

---Register scenery object as POSITIONABLE.
---@param SceneryName? string Scenery name.
---@param SceneryObject? Object DCS scenery object.
---@param SceneryZone? ZONE_POLYGON (optional) The zone object.
---@return SCENERY # Scenery object.
function SCENERY:Register(SceneryName, SceneryObject, SceneryZone) end

---[INTERNAL] Update data
---@param Scenery? SCENERY The object to update.
function SCENERY._UpdateFromDCSObject(Scenery) end

---Returns the value of the scenery with the given PropertyName, or nil if no matching property exists.
---@param PropertyName? string The name of a the QuadZone Property from the scenery assignment to be retrieved.
---@return string # The Value of the QuadZone Property from the scenery assignment with the given PropertyName, or nil if absent.
function SCENERY:GetProperty(PropertyName) end

---Checks if the value of the scenery with the given PropertyName exists.
---@param PropertyName? string The name of a the QuadZone Property from the scenery assignment to be retrieved.
---@return boolean # Outcome True if it exists, else false.
function SCENERY:HasProperty(PropertyName) end

---Returns the scenery Properties table.
---@return table # The Key:Value table of QuadZone properties of the zone from the scenery assignment .
function SCENERY:GetAllProperties() end

---Set a scenery property
---@param PropertyName? string
---@param PropertyValue? string
---@return SCENERY # self
function SCENERY:SetProperty(PropertyName, PropertyValue) end

---Obtain object name.
---@return string # Name
function SCENERY:GetName() end

---Obtain object coordinate.
---@return COORDINATE # Coordinate
function SCENERY:GetCoordinate() end

---Obtain object coordinate.
---@return Vec3 # Vec3
function SCENERY:GetVec3() end

---Obtain object coordinate.
---@return Vec2 # Vec2
function SCENERY:GetVec2() end

---Obtain object coordinate.
---@return VECTOR # Vector
function SCENERY:GetVector() end

---Obtain DCS Object from the SCENERY Object.
---@return Object # DCS scenery object.
function SCENERY:GetDCSObject() end

---Obtain object ID.
---@return string # Name
function SCENERY:GetID() end

---Get current life points from the SCENERY Object. Note - Some scenery objects always have 0 life points.
--- **CAVEAT**: Some objects change their life value or "hitpoints" **after** the first hit. Hence we will adjust the life0 value to 120%
--- of the last life value if life exceeds life0 (initial life) at any point. Thus will will get a smooth percentage decrease, if you use this e.g. as success
--- criteria for a bombing task.
---@return number # life
function SCENERY:GetLife() end

---Get initial life points of the SCENERY Object.
---@return number # life
function SCENERY:GetLife0() end

---Check if SCENERY Object is alive. Note - Some scenery objects always have 0 life points.
---@param Threshold? number (Optional) If given, SCENERY counts as alive above this relative life in percent (1..100).
---@return number # life
function SCENERY:IsAlive(Threshold) end

---Check if SCENERY Object is dead. Note - Some scenery objects always have 0 life points.
---@param Threshold? number (Optional) If given, SCENERY counts as dead below this relative life in percent (1..100).
---@return number # life
function SCENERY:IsDead(Threshold) end

---Get SCENERY relative life in percent, e.g. 75. Note - Some scenery objects always have 0 life points.
---@return number # rlife
function SCENERY:GetRelativeLife() end

---Get the threat level of a SCENERY object. Always 0 as scenery does not pose a threat to anyone.
---@return number # Threat level 0.
---@return string # "Scenery".
function SCENERY:GetThreatLevel() end

---Find a SCENERY object from its name or id. Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
---to find the correct object.
---@param Name? string The name/id of the scenery object as taken from the ME. Ex. '595785449'.
---@param Coordinate? COORDINATE Where to find the scenery object.
---@param Radius? number (optional) Search radius around coordinate, defaults to 100.
---@param Role? string (optional) The role if set on the zone object.
---@param Zone? ZONE_POLYGON (optional) The Zone where the scenery is located.
---@return SCENERY # Scenery Object or `nil` if it cannot be found.
function SCENERY:FindByName(Name, Coordinate, Radius, Role, Zone) end

---Find a SCENERY object that was previously registered(!) by it's ID.
---@param ID? number
---@return SCENERY # Scenery or nil if it could not be found
function SCENERY:FindByID(ID) end

---Find a SCENERY object that was previously registered(!) by it's name.
---@param Name? string
---@return SCENERY # Scenery or nil if it could not be found
function SCENERY:_FindByName(Name) end

---Find a SCENERY object from its name or id. Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
---to find the correct object.
---@param Name? string The name or id of the scenery object as taken from the ME. Ex. '595785449'
---@param Zone? ZONE_BASE Where to find the scenery object. Can be handed as zone name.
---@param Radius? number (optional) Search radius around coordinate, defaults to 100
---@return SCENERY # Scenery Object or `nil` if it cannot be found
function SCENERY:FindByNameInZone(Name, Zone, Radius) end

---Find a SCENERY object from its zone name. Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
---to find the correct object.
---@param ZoneName? string The name of the scenery zone as created with a right-click on the map in the mission editor and select "assigned to...". Can be handed over as ZONE object.
---@return SCENERY # First found Scenery Object or `nil` if it cannot be found
function SCENERY:FindByZoneName(ZoneName) end

---Scan and find all SCENERY objects from a zone by zone-name. Since SCENERY isn't registered in the Moose database (just too many objects per map), we need to do a scan first
---to find the correct object. Might return nil!
---@param ZoneName? string The name of the zone, can be handed as ZONE_RADIUS or ZONE_POLYGON object
---@return table # of SCENERY Objects, or `nil` if nothing found
function SCENERY:FindAllByZoneName(ZoneName) end

---SCENERY objects cannot be destroyed via the API (at the punishment of game crash).
---@return SCENERY # self
function SCENERY:Destroy() end
