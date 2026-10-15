---@meta

---@class Template.Unit
---@field name string Name of the unit.
---@field x number
---@field y number
---@field alt number

---@class Template
---@field uncontrolled boolean Aircraft is uncontrolled.
---@field lateActivation boolean Group is late activated.
---@field x number 2D Position on x-axis in meters.
---@field y number 2D Position on y-axis in meters.
---@field units table Unit list.
Template = {}

---@class WaypointAir
---@field lateActivated boolean
---@field uncontrolled boolean
WaypointAir = {}

---@class TaskArray
TaskArray = {}

---@class Task.param

---@class Task
---@field id string
---@field param Task.param
Task = {}

---@class AttributeNameArray
AttributeNameArray = {}

---@class AttributeName : string
AttributeName = {}

---@class TypeName : string
TypeName = {}

---@class Box3
---@field min Vec3 Min.
---@field max Vec3 Max
Box3 = {}

---@class Position3
---@field p Vec3 3D position vector.
---@field x Vec3 Orientation component of vector pointing East.
---@field y Vec3 Orientation component of vector pointing up.
---@field z Vec3 Orientation component of vector pointing North.
Position3 = {}

---@class Vec2
---@field x number Vec2.x = Vec3.x
---@field y number Vec2.y = Vec3.z
Vec2 = {}

---@class Vec3
---@field x number is directed to the North
---@field z number is directed to the East
---@field y number is directed up
Vec3 = {}

---@class Mass : number
Mass = {}

---@class Azimuth : number
Azimuth = {}

---@class MissionTime : number
MissionTime = {}

---@class ModelTime : number
ModelTime = {}

---@class Time : number
Time = {}

---@class Angle : number
Angle = {}

---@class Distance : number
Distance = {}

---@class Desc
---@field speedMax0 number Max speed in meters/second at zero altitude.
---@field massEmpty number Empty mass in kg.
---@field tankerType number Type of refueling system: 0=boom, 1=probe.
---@field range number Range in km(?).
---@field box table Bounding box.
---@field Hmax number Max height in meters.
---@field Kmax number ?
---@field speedMax10K number Max speed in meters/second at 10k altitude.
---@field NyMin number ?
---@field NyMax number ?
---@field fuelMassMax number Max fuel mass in kg.
---@field speedMax10K number Max speed in meters/second.
---@field massMax number Max mass of unit.
---@field RCS number ?
---@field life number Life points.
---@field VyMax number Max vertical velocity in m/s.
---@field Kab number ?
---@field attributes table Table of attributes.
---@field typeName TypeName Type Name.
---@field displayName string Localized display name.
---@field category number Unit category.
Desc = {}

---@class Command.params

---@class Command
---@field id string
---@field params Command.params
Command = {}

radio.modulation.AM = 0  

radio.modulation.FM = 1

---@class Zone
---@field point Vec3
---@field radius number
Zone = {}

---[DCS Class CoalitionObject](https://wiki.hoggitworld.com/view/DCS_Class_Coalition_Object)
---@class CoalitionObject : Object
CoalitionObject = {} --#CoalitionObject

---Event structure. Note that present fields depend on type of event.
---@class Event
---@field id number Event ID.
---@field time number Mission time in seconds.
---@field initiator Unit Unit initiating the event.
---@field target Unit Target unit.
---@field place Airbase Airbase.
---@field subPlace number Subplace. Unknown and often just 0.
---@field weapon_name string Weapoin name.
---@field idx number Mark ID.
---@field coalition number Coalition ID.
---@field groupID number Group ID, *e.g.* of group that added mark point.
---@field text string Text, *e.g.* of mark point.
---@field pos Vec3 Position vector, *e.g.* of mark point.
---@field comment string Comment, *e.g.* LSO score.
Event={} --#Event

---Returns coalition of the object.
---@return coalition.side
function CoalitionObject:getCoalition() end

---Returns object country.
---@return country.id
function CoalitionObject:getCountry() end