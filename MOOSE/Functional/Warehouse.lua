---@meta

---@class WAREHOUSE.Pendingitem : WAREHOUSE.Queueitem
---@field timestamp number Absolute mission time in seconds when the request was processed.
---@field assetproblem table Table with assets that might have problems (damage or stuck).
---@field cargogroupset SET_GROUP Set of cargo groups do be delivered.
---@field ndelivered number Number of groups delivered to destination.
---@field transportgroupset SET_GROUP Set of cargo transport carrier groups.
---@field transportcargoset SET_CARGO Set of cargo objects.
---@field carriercargo table Table holding the cargo groups of each carrier unit.
---@field ntransporthome number Number of transports back home.
---@field lowfuel boolean If true, at least one asset group is low on fuel.

---@class WAREHOUSE.Queueitem
---@field uid number Unique id of the queue item.
---@field warehouse WAREHOUSE Requesting warehouse.
---@field assetdesc WAREHOUSE.Descriptor Descriptor of the requested asset. Enumerator of type @{#WAREHOUSE.Descriptor}.
---@field Value assetdescval of the asset descriptor. Type depends on "assetdesc" descriptor.
---@field nasset number Number of asset groups requested.
---@field transporttype WAREHOUSE.TransportType Transport unit type.
---@field ntransport number Max. number of transport units requested.
---@field assignment string A keyword or text that later be used to identify this request and postprocess the assets.
---@field prio number Priority of the request. Number between 1 (high) and 100 (low).
---@field airbase AIRBASE The airbase beloning to requesting warehouse if any.
---@field category Airbase.Category Category of the requesting airbase, i.e. airdrome, helipad/farp or ship.
---@field toself boolean Self request, i.e. warehouse requests assets from itself.
---@field assets table Table of self propelled (or cargo) and transport assets. Each element of the table is a @{#WAREHOUSE.Assetitem} and can be accessed by their asset ID.
---@field cargoassets table Table of cargo (or self propelled) assets. Each element of the table is a @{#WAREHOUSE.Assetitem}.
---@field cargoattribute number Attribute of cargo assets of type @{#WAREHOUSE.Attribute}.
---@field cargocategory number Category of cargo assets of type @{#WAREHOUSE.Category}.
---@field transportassets table Table of transport carrier assets. Each element of the table is a @{#WAREHOUSE.Assetitem}.
---@field transportattribute number Attribute of transport assets of type @{#WAREHOUSE.Attribute}.
---@field transportcategory number Category of transport assets of type @{#WAREHOUSE.Category}.
---@field lateActivation boolean Assets are spawned in late activated state.

---@class WAREHOUSE.Assetitem
---@field uid number Unique id of the asset.
---@field wid number ID of the warehouse this asset belongs to.
---@field rid number Request ID of this asset (if any).
---@field templatename string Name of the template group.
---@field template table The spawn template of the group.
---@field category Group.Category Category of the group.
---@field unittype string Type of the first unit of the group as obtained by the Object.getTypeName() DCS API function.
---@field nunits number Number of units in the group.
---@field range number Range of the unit in meters.
---@field speedmax number Maximum speed in km/h the group can do.
---@field size number Maximum size in length and with of the asset in meters.
---@field weight number The weight of the whole asset group in kilograms.
---@field DCSdesc Object.Desc All DCS descriptors.
---@field attribute WAREHOUSE.Attribute Generalized attribute of the group.
---@field cargobay table Array of cargo bays of all units in an asset group.
---@field cargobaytot number Total weight in kg that fits in the cargo bay of all asset group units.
---@field cargobaymax number Largest cargo bay of all units in the group.
---@field loadradius number Distance when cargo is loaded into the carrier.
---@field skill AI.Skill Skill of AI unit.
---@field livery string Livery of the asset.
---@field assignment string Assignment of the asset. This could, e.g., be used in the @{#WAREHOUSE.OnAfterNewAsset) function.
---@field spawned boolean If true, asset was spawned into the cruel world. If false, it is still in stock.
---@field spawngroupname string Name of the spawned group.
---@field iscargo boolean If true, asset is cargo. If false asset is transport. Nil if in stock.
---@field arrived boolean If true, asset arrived at its destination.
---@field damage number Damage of asset group in percent.
---@field payload AIRWING.Payload The payload of the asset.
---@field flightgroup OPSGROUP The flightgroup object.
---@field cohort COHORT The cohort this asset belongs to.
---@field legion LEGION The legion this asset belonts to.
---@field squadname string Name of the squadron this asset belongs to.
---@field Treturned number Time stamp when asset returned to its legion (airwing, brigade).
---@field requested boolean If `true`, asset was requested and cannot be selected by another request.
---@field isReserved boolean If `true`, asset was reserved and cannot be selected by another request.

---WAREHOUSE class.
---@class WAREHOUSE : FSM
---@field ClassName string Name of the class.
---@field Debug boolean If true, send debug messages to all.
---@field verbosity number Verbosity level.
---@field wid string Identifier of the warehouse printed before other output to DCS.log file.
---@field Report boolean If true, send status messages to coalition.
---@field warehouse STATIC The phyical warehouse structure.
---@field alias string Alias of the warehouse. Name its called when sending messages.
---@field zone ZONE Zone around the warehouse. If this zone is captured, the warehouse and all its assets goes to the capturing coalition.
---@field airbase AIRBASE Airbase the warehouse belongs to.
---@field airbasename string Name of the airbase associated to the warehouse.
---@field road COORDINATE Closest point to warehouse on road.
---@field rail COORDINATE Closest point to warehouse on rail.
---@field spawnzone ZONE Zone in which assets are spawned.
---@field uid number Unique ID of the warehouse.
---@field markerOn boolean If true, markers are displayed on the F10 map.
---@field markerWarehouse MARKER Marker warehouse.
---@field markerRoad MARKER Road connection.
---@field markerRail MARKER Rail road connection.
---@field markerid number ID of the warehouse marker at the airbase.
---@field dTstatus number Time interval in seconds of updating the warehouse status and processing new events. Default 30 seconds.
---@field queueid number Unit id of each request in the queue. Essentially a running number starting at one and incremented when a new request is added.
---@field stock table Table holding all assets in stock. Table entries are of type @{#WAREHOUSE.Assetitem}.
---@field queue table Table holding all queued requests. Table entries are of type @{#WAREHOUSE.Queueitem}.
---@field pending table Table holding all pending requests, i.e. those that are currently in progress. Table elements are of type @{#WAREHOUSE.Pendingitem}.
---@field transporting table Table holding assets currently transporting cargo assets.
---@field delivered table Table holding all delivered requests. Table elements are #boolean. If true, all cargo has been delivered.
---@field defending table Table holding all defending requests, i.e. self requests that were if the warehouse is under attack. Table elements are of type @{#WAREHOUSE.Pendingitem}.
---@field portzone ZONE Zone defining the port of a warehouse. This is where naval assets are spawned.
---@field shippinglanes table Table holding the user defined shipping between warehouses.
---@field offroadpaths table Table holding user defined paths from one warehouse to another.
---@field autodefence boolean When the warehouse is under attack, automatically spawn assets to defend the warehouse.
---@field spawnzonemaxdist number Max distance between warehouse and spawn zone. Default 5000 meters.
---@field autosave boolean Automatically save assets to file when mission ends.
---@field autosavepath string Path where the asset file is saved on auto save.
---@field autosavefile string File name of the auto asset save file. Default is auto generated from warehouse id and name.
---@field safeparking boolean If true, parking spots for aircraft are considered as occupied if e.g. a client aircraft is parked there. Default false.
---@field isUnit boolean If `true`, warehouse is represented by a unit instead of a static.
---@field isShip boolean If `true`, warehouse is represented by a ship unit.
---@field lowfuelthresh number Low fuel threshold. Triggers the event AssetLowFuel if for any unit fuel goes below this number.
---@field respawnafterdestroyed boolean If true, warehouse is respawned after it was destroyed. Assets are kept.
---@field respawndelay number Delay before respawn in seconds.
---@field runwaydestroyed number Time stamp timer.getAbsTime() when the runway was destroyed.
---@field runwayrepairtime number Time in seconds until runway will be repaired after it was destroyed. Default is 3600 sec (one hour).
---@field flightcontrol FLIGHTCONTROL Flight control of this warehouse.
WAREHOUSE = {
  ClassName     = "WAREHOUSE",
  Debug         = false,
  verbosity     =     0,
  lid           =   nil,
  Report        =  true,
  warehouse     =   nil,
  alias         =   nil,
  zone          =   nil,
  airbase       =   nil,
  airbasename   =   nil,
  road          =   nil,
  rail          =   nil,
  spawnzone     =   nil,
  uid           =   nil,
  dTstatus      =    30,
  queueid       =     0,
  stock         =    {},
  queue         =    {},
  pending       =    {},
  transporting  =    {},
  delivered     =    {},
  defending     =    {},
  portzone      =   nil,
  harborzone    =   nil,
  shippinglanes =    {},
  offroadpaths  =    {},
  autodefence   = false,
  spawnzonemaxdist = 5000,
  autosave      = false,
  autosavepath  =   nil,
  autosavefile  =   nil,
  saveparking   = false,
  isUnit        = false,
  isShip        = false,
  lowfuelthresh =  0.15,
  respawnafterdestroyed=false,
  respawndelay  =   nil,
}

---Descriptors enumerator describing the type of the asset.
---@class WAREHOUSE.Descriptor
---@field GROUPNAME string Name of the asset template.
---@field UNITTYPE string Typename of the DCS unit, e.g. "A-10C".
---@field ATTRIBUTE string Generalized attribute @{#WAREHOUSE.Attribute}.
---@field CATEGORY string Asset category of type DCS#Group.Category, i.e. GROUND, AIRPLANE, HELICOPTER, SHIP, TRAIN.
---@field ASSIGNMENT string Assignment of asset when it was added.
---@field ASSETLIST string List of specific assets gives as a table of assets. Mind the curly brackets {}.
WAREHOUSE.Descriptor = {
  GROUPNAME="templatename",
  UNITTYPE="unittype",
  ATTRIBUTE="attribute",
  CATEGORY="category",
  ASSIGNMENT="assignment",
  ASSETLIST="assetlist,"
}

---Generalized asset attributes. Can be used to request assets with certain general characteristics. See [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes) on hoggit.
---@class WAREHOUSE.Attribute
---@field AIR_TRANSPORTPLANE string Airplane with transport capability. This can be used to transport other assets.
---@field AIR_AWACS string Airborne Early Warning and Control System.
---@field AIR_FIGHTER string Fighter, interceptor, ... airplane.
---@field AIR_BOMBER string Aircraft which can be used for strategic bombing.
---@field AIR_TANKER string Airplane which can refuel other aircraft.
---@field AIR_TRANSPORTHELO string Helicopter with transport capability. This can be used to transport other assets.
---@field AIR_ATTACKHELO string Attack helicopter.
---@field AIR_UAV string Unpiloted Aerial Vehicle, e.g. drones.
---@field AIR_OTHER string Any airborne unit that does not fall into any other airborne category.
---@field GROUND_APC string Infantry carriers, in particular Amoured Personell Carrier. This can be used to transport other assets.
---@field GROUND_TRUCK string Unarmed ground vehicles, which has the DCS "Truck" attribute.
---@field GROUND_INFANTRY string Ground infantry assets.
---@field GROUND_IFV string Ground infantry fighting vehicle.
---@field GROUND_ARTILLERY string Artillery assets.
---@field GROUND_TANK string Tanks (modern or old).
---@field GROUND_TRAIN string Trains. Not that trains are **not** yet properly implemented in DCS and cannot be used currently.
---@field GROUND_EWR string Early Warning Radar.
---@field GROUND_AAA string Anti-Aircraft Artillery.
---@field GROUND_SAM string Surface-to-Air Missile system or components.
---@field GROUND_OTHER string Any ground unit that does not fall into any other ground category.
---@field NAVAL_AIRCRAFTCARRIER string Aircraft carrier.
---@field NAVAL_WARSHIP string War ship, i.e. cruisers, destroyers, firgates and corvettes.
---@field NAVAL_ARMEDSHIP string Any armed ship that is not an aircraft carrier, a cruiser, destroyer, firgatte or corvette.
---@field NAVAL_UNARMEDSHIP string Any unarmed naval vessel.
---@field NAVAL_OTHER string Any naval unit that does not fall into any other naval category.
---@field OTHER_UNKNOWN string Anything that does not fall into any other category.
WAREHOUSE.Attribute = {
  AIR_TRANSPORTPLANE="Air_TransportPlane",
  AIR_AWACS="Air_AWACS",
  AIR_FIGHTER="Air_Fighter",
  AIR_BOMBER="Air_Bomber",
  AIR_TANKER="Air_Tanker",
  AIR_TRANSPORTHELO="Air_TransportHelo",
  AIR_ATTACKHELO="Air_AttackHelo",
  AIR_UAV="Air_UAV",
  AIR_OTHER="Air_OtherAir",
  GROUND_APC="Ground_APC",
  GROUND_TRUCK="Ground_Truck",
  GROUND_INFANTRY="Ground_Infantry",
  GROUND_IFV="Ground_IFV",
  GROUND_ARTILLERY="Ground_Artillery",
  GROUND_TANK="Ground_Tank",
  GROUND_TRAIN="Ground_Train",
  GROUND_EWR="Ground_EWR",
  GROUND_AAA="Ground_AAA",
  GROUND_SAM="Ground_SAM",
  GROUND_OTHER="Ground_OtherGround",
  NAVAL_AIRCRAFTCARRIER="Naval_AircraftCarrier",
  NAVAL_WARSHIP="Naval_WarShip",
  NAVAL_ARMEDSHIP="Naval_ArmedShip",
  NAVAL_UNARMEDSHIP="Naval_UnarmedShip",
  NAVAL_OTHER="Naval_OtherNaval",
  OTHER_UNKNOWN="Other_Unknown",
}

---Cargo transport type. Defines how assets are transported to their destination.
---@class WAREHOUSE.TransportType
---@field AIRPLANE string Transports are carried out by airplanes.
---@field HELICOPTER string Transports are carried out by helicopters.
---@field APC string Transports are conducted by APCs.
---@field SHIP string Transports are conducted by ships. Not implemented yet.
---@field TRAIN string Transports are conducted by trains. Not implemented yet. Also trains are buggy in DCS.
---@field SELFPROPELLED string Assets go to their destination by themselves. No transport carrier needed.
WAREHOUSE.TransportType = {
  AIRPLANE         = "Air_TransportPlane",
  HELICOPTER       = "Air_TransportHelo",
  APC              = "Ground_APC",
  TRAIN            = "Ground_Train",
  SHIP             = "Naval_UnarmedShip",
  AIRCRAFTCARRIER  = "Naval_AircraftCarrier",
  WARSHIP          = "Naval_WarShip",
  ARMEDSHIP        = "Naval_ArmedShip",
  SELFPROPELLED    = "Selfpropelled",
}

---Warehouse quantity enumerator for selecting number of assets, e.g. all, half etc. of what is in stock rather than an absolute number.
---@class WAREHOUSE.Quantity
---@field ALL string All "all" assets currently in stock.
---@field THREEQUARTERS string Three quarters "3/4" of assets in stock.
---@field HALF string Half "1/2" of assets in stock.
---@field THIRD string One third "1/3" of assets in stock.
---@field QUARTER string One quarter "1/4" of assets in stock.
WAREHOUSE.Quantity = {
  ALL           = "all",
  THREEQUARTERS = "3/4",
  HALF          = "1/2",
  THIRD         = "1/3",
  QUARTER       = "1/4",
}

---Warehouse database. Note that this is a global array to have easier exchange between warehouses.
---@class _WAREHOUSEDB
---@field AssetID number Unique ID of each asset. This is a running number, which is increased each time a new asset is added.
---@field Assets table Table holding registered assets, which are of type @{Functional.Warehouse#WAREHOUSE.Assetitem}.#
---@field WarehouseID number Unique ID of the warehouse. Running number.
---@field Warehouses table Table holding all defined @{#WAREHOUSE} objects by their unique ids.
_WAREHOUSEDB  = {
  AssetID     = 0,
  Assets      = {},
  WarehouseID = 0,
  Warehouses  = {}
}

---Warehouse class version.
WAREHOUSE.version = "2.0.0"

---The WAREHOUSE constructor. Creates a new WAREHOUSE object from a static object. Parameters like the coalition and country are taken from the static object structure.
---@param warehouse? STATIC The physical structure representing the warehouse. Can also be a @{Wrapper.Unit#UNIT}.
---@param alias? string (Optional) Alias of the warehouse, i.e. the name it will be called when sending messages etc. Default is the name of the static/unit representing the warehouse.
---@return WAREHOUSE # self
function WAREHOUSE:New(warehouse, alias) end

---Set debug mode on. Error messages will be displayed on screen, units will be smoked at some events.
---@return WAREHOUSE # self
function WAREHOUSE:SetDebugOn() end

---Set debug mode off. This is the default
---@return WAREHOUSE # self
function WAREHOUSE:SetDebugOff() end

---Set report on. Messages at events will be displayed on screen to the coalition owning the warehouse.
---@return WAREHOUSE # self
function WAREHOUSE:SetReportOn() end

---Set report off. Warehouse does not report about its status and at certain events.
---@return WAREHOUSE # self
function WAREHOUSE:SetReportOff() end

---Enable safe parking option, i.e. parking spots at an airbase will be considered as occupied when a client aircraft is parked there (even if the client slot is not taken by a player yet).
---Note that also incoming aircraft can reserve/occupie parking spaces.
---@return WAREHOUSE # self
function WAREHOUSE:SetSafeParkingOn() end

---Disable safe parking option. Note that is the default setting.
---@return WAREHOUSE # self
function WAREHOUSE:SetSafeParkingOff() end

---Set wether client parking spots can be used for spawning.
---@return WAREHOUSE # self
function WAREHOUSE:SetAllowSpawnOnClientParking() end

---Set low fuel threshold. If one unit of an asset has less fuel than this number, the event AssetLowFuel will be fired.
---@param threshold? number (Optional) Relative low fuel threshold, i.e. a number in [0,1]. Default 0.15 (15%).
---@return WAREHOUSE # self
function WAREHOUSE:SetLowFuelThreshold(threshold) end

---Set interval of status updates. Note that normally only one request can be processed per time interval.
---@param timeinterval? number Time interval in seconds.
---@return WAREHOUSE # self
function WAREHOUSE:SetStatusUpdate(timeinterval) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return WAREHOUSE # self
function WAREHOUSE:SetVerbosityLevel(VerbosityLevel) end

---Set a zone where the (ground) assets of the warehouse are spawned once requested.
---@param zone? ZONE The spawn zone.
---@param maxdist? number (Optional) Maximum distance in meters between spawn zone and warehouse. Units are not spawned if distance is larger. Default is 5000 m.
---@return WAREHOUSE # self
function WAREHOUSE:SetSpawnZone(zone, maxdist) end

---Get the spawn zone.
---@return ZONE # The spawn zone.
function WAREHOUSE:GetSpawnZone() end

---Set a warehouse zone. If this zone is captured, the warehouse and all its assets fall into the hands of the enemy.
---@param zone? ZONE The warehouse zone. Note that this **cannot** be a polygon zone!
---@return WAREHOUSE # self
function WAREHOUSE:SetWarehouseZone(zone) end

---Get the warehouse zone.
---@return ZONE # The warehouse zone.
function WAREHOUSE:GetWarehouseZone() end

---Set auto defence on. When the warehouse is under attack, all ground assets are spawned automatically and will defend the warehouse zone.
---@return WAREHOUSE # self
function WAREHOUSE:SetAutoDefenceOn() end

---Set auto defence off. This is the default.
---@return WAREHOUSE # self
function WAREHOUSE:SetAutoDefenceOff() end

---Set valid parking spot IDs.
---@param ParkingIDs? table Table of numbers.
---@return WAREHOUSE # self
function WAREHOUSE:SetParkingIDs(ParkingIDs) end

---Check parking ID.
---@param spot? AIRBASE.ParkingSpot|number|string Parking spot.
---@return boolean # If true, parking is valid.
function WAREHOUSE:_CheckParkingValid(spot) end

---Check parking ID for an asset.
---@param spot? AIRBASE.ParkingSpot|number|string Parking spot.
---@param asset? any
---@return boolean # If true, parking is valid.
function WAREHOUSE:_CheckParkingAsset(spot, asset) end

---Enable auto save of warehouse assets at mission end event.
---@param path? string Path where to save the asset data file.
---@param filename? string (Optional) File name. Default is generated automatically from warehouse id.
---@return WAREHOUSE # self
function WAREHOUSE:SetSaveOnMissionEnd(path, filename) end

---Show or don't show markers on the F10 map displaying the Warehouse stock and road/rail connections.
---@param switch? boolean If true (or nil), markers are on. If false, markers are not displayed.
---@return WAREHOUSE # self
function WAREHOUSE:SetMarker(switch) end

---Set respawn after destroy.
---@param delay? any
---@return WAREHOUSE # self
function WAREHOUSE:SetRespawnAfterDestroyed(delay) end

---Set the airbase belonging to this warehouse.
---Note that it has to be of the same coalition as the warehouse.
---Also, be reasonable and do not put it too far from the phyiscal warehouse structure because you troops might have a long way to get to their transports.
---@param airbase? AIRBASE The airbase object associated to this warehouse.
---@return WAREHOUSE # self
function WAREHOUSE:SetAirbase(airbase) end

---Set the connection of the warehouse to the road.
---Ground assets spawned in the warehouse spawn zone will first go to this point and from there travel on road to the requesting warehouse.
---Note that by default the road connection is set to the closest point on road from the center of the spawn zone if it is withing 3000 meters.
---Also note, that if the parameter "coordinate" is passed as nil, any road connection is disabled and ground assets cannot travel of be transportet on the ground.
---@param coordinate? COORDINATE The road connection. Technically, the closest point on road from this coordinate is determined by DCS API function. So this point must not be exactly on the road.
---@return WAREHOUSE # self
function WAREHOUSE:SetRoadConnection(coordinate) end

---Set the connection of the warehouse to the railroad.
---This is the place where train assets or transports will be spawned.
---@param coordinate? COORDINATE The railroad connection. Technically, the closest point on rails from this coordinate is determined by DCS API function. So this point must not be exactly on the a railroad connection.
---@return WAREHOUSE # self
function WAREHOUSE:SetRailConnection(coordinate) end

---Set the port zone for this warehouse.
---The port zone is the zone, where all naval assets of the warehouse are spawned.
---@param zone? ZONE The zone defining the naval port of the warehouse.
---@return WAREHOUSE # self
function WAREHOUSE:SetPortZone(zone) end

---Add a Harbor Zone for this warehouse where naval cargo units will spawn and be received.
---Both warehouses must have the harbor zone defined for units to properly spawn on both the
---sending and receiving side. The harbor zone should be within 3km of the port zone used for
---warehouse in order to facilitate the boarding process.
---@param zone? ZONE The zone defining the naval embarcation/debarcation point for cargo units
---@return WAREHOUSE # self
function WAREHOUSE:SetHarborZone(zone) end

---Add a shipping lane from this warehouse to another remote warehouse.
---Note that both warehouses must have a port zone defined before a shipping lane can be added!
---Shipping lane is taken from the waypoints of a (late activated) template group. So set up a group, e.g. a ship or a helicopter, and place its
---waypoints along the shipping lane you want to add.
---@param remotewarehouse? WAREHOUSE The remote warehouse to where the shipping lane is added
---@param group? GROUP Waypoints of this group will define the shipping lane between to warehouses.
---@param oneway? boolean (Optional) If true, the lane can only be used from this warehouse to the other but not other way around. Default false.
---@return WAREHOUSE # self
function WAREHOUSE:AddShippingLane(remotewarehouse, group, oneway) end

---Add an off-road path from this warehouse to another and back.
---The start and end points are automatically set to one random point in the respective spawn zones of the two warehouses.
---By default, the reverse path is also added as path from the remote warehouse to this warehouse.
---@param remotewarehouse? WAREHOUSE The remote warehouse to which the path leads.
---@param group? GROUP Waypoints of this group will define the path between to warehouses.
---@param oneway? boolean (Optional) If true, the path can only be used from this warehouse to the other but not other way around. Default false.
---@return WAREHOUSE # self
function WAREHOUSE:AddOffRoadPath(remotewarehouse, group, oneway) end

---Create a new path from a template group.
---@param group? GROUP Group used for extracting the waypoints.
---@param startcoord? COORDINATE First coordinate.
---@param finalcoord? COORDINATE Final coordinate.
---@return table # Table with route points.
function WAREHOUSE:_NewLane(group, startcoord, finalcoord) end

---Check if the warehouse has not been started yet, i.e. is in the state "NotReadyYet".
---@return boolean # If true, the warehouse object has been created but the warehouse has not been started yet.
function WAREHOUSE:IsNotReadyYet() end

---Check if the warehouse has been loaded from disk via the "Load" event.
---@return boolean # If true, the warehouse was loaded from disk.
function WAREHOUSE:IsLoaded() end

---Check if the warehouse is running.
---@return boolean # If true, the warehouse is running and requests are processed.
function WAREHOUSE:IsRunning() end

---Check if the warehouse is paused. In this state, requests are not processed.
---@return boolean # If true, the warehouse is paused.
function WAREHOUSE:IsPaused() end

---Check if the warehouse is under attack by another coalition.
---@return boolean # If true, the warehouse is attacked.
function WAREHOUSE:IsAttacked() end

---Check if the warehouse has been destroyed.
---@return boolean # If true, the warehouse had been destroyed.
function WAREHOUSE:IsDestroyed() end

---Check if the warehouse is stopped.
---@return boolean # If true, the warehouse is stopped.
function WAREHOUSE:IsStopped() end

---Check if the warehouse has a road connection to another warehouse. Both warehouses need to be started!
---@param warehouse? WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath? boolean If true, place markers of path segments on the F10 map.
---@param smokepath? boolean If true, put green smoke on path segments.
---@return boolean # If true, the two warehouses are connected by road.
---@return number # Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionRoad(warehouse, markpath, smokepath) end

---Check if the warehouse has a railroad connection to another warehouse. Both warehouses need to be started!
---@param warehouse? WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath? boolean If true, place markers of path segments on the F10 map.
---@param smokepath? boolean If true, put green smoke on path segments.
---@return boolean # If true, the two warehouses are connected by road.
---@return number # Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionRail(warehouse, markpath, smokepath) end

---Check if the warehouse has a shipping lane defined to another warehouse.
---@param warehouse? WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath? boolean If true, place markers of path segments on the F10 map.
---@param smokepath? boolean If true, put green smoke on path segments.
---@return boolean # If true, the two warehouses are connected by road.
---@return number # Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionNaval(warehouse, markpath, smokepath) end

---Check if the warehouse has an off road path defined to another warehouse.
---@param warehouse? WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath? boolean If true, place markers of path segments on the F10 map.
---@param smokepath? boolean If true, put green smoke on path segments.
---@return boolean # If true, the two warehouses are connected by road.
---@return number # Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionOffRoad(warehouse, markpath, smokepath) end

---Get number of assets in warehouse stock. Optionally, only specific assets can be counted.
---@param Descriptor? string (Optional) Descriptor return the number of a specifc asset type. See @{#WAREHOUSE.Descriptor} for possible values.
---@param DescriptorValue? any
---@param OnlyMobile? boolean (Optional) If true only mobile units are considered.
---@return number # Number of assets in stock.
function WAREHOUSE:GetNumberOfAssets(Descriptor, DescriptorValue, OnlyMobile) end

---Get coordinate of warehouse static.
---@return COORDINATE # The coordinate of the warehouse.
function WAREHOUSE:GetCoordinate() end

---Get 3D vector of warehouse static.
---@return Vec3 # The 3D vector of the warehouse.
function WAREHOUSE:GetVec3() end

---Get 2D vector of warehouse static.
---@return Vec2 # The 2D vector of the warehouse.
function WAREHOUSE:GetVec2() end

---Get coalition side of warehouse static.
---@return number # Coalition side, i.e. number of @{DCS#coalition.side}.
function WAREHOUSE:GetCoalition() end

---Get coalition name of warehouse static.
---@return number # Coalition side, i.e. number of @{DCS#coalition.side}.
function WAREHOUSE:GetCoalitionName() end

---Get country id of warehouse static.
---@return number # Country id, i.e. number of @{DCS#country.id}.
function WAREHOUSE:GetCountry() end

---Get country name of warehouse static.
---@return number # Country id, i.e. number of @{DCS#coalition.side}.
function WAREHOUSE:GetCountryName() end

---Get airbase associated to the warehouse.
---@return AIRBASE # Airbase object or nil if warehouse has no airbase connection.
function WAREHOUSE:GetAirbase() end

---Get name airbase associated to the warehouse.
---@return string # name of the airbase assosicated to the warehouse or "none" if the airbase has not airbase connection currently.
function WAREHOUSE:GetAirbaseName() end

---Get category of airbase associated to the warehouse.
---@return number # Category of airbase or -1 if warehouse has (currently) no airbase.
function WAREHOUSE:GetAirbaseCategory() end

---Get assignment of a request.
---@param request? WAREHOUSE.Pendingitem|number|string The request from which the assignment is extracted.
---@return string # The assignment text.
function WAREHOUSE:GetAssignment(request) end

---Find a warehouse in the global warehouse data base.
---@param uid? number The unique ID of the warehouse.
---@return WAREHOUSE # The warehouse object or nil if no warehouse exists.
function WAREHOUSE:FindWarehouseInDB(uid) end

---Find nearest warehouse in service, i.e. warehouses which are not started, stopped or destroyed are not considered.
---Optionally, only warehouses with (specific) assets can be included in the search or warehouses of a certain coalition.
---@param MinAssets? any
---@param Descriptor? string (Optional) Descriptor describing the selected assets which should be in stock. See @{#WAREHOUSE.Descriptor} for possible values.
---@param DescriptorValue? any
---@param Coalition? Coalition.side|number|string (Optional) Coalition side of the warehouse. Default is the same coalition as the present warehouse. Set to false for any coalition.
---@param RefCoordinate? COORDINATE (Optional) Coordinate to which the closest warehouse is searched. Default is the warehouse calling this function.
---@return WAREHOUSE # The the nearest warehouse object. Or nil if no warehouse is found.
---@return number # The distance to the nearest warehouse in meters. Or nil if no warehouse is found.
function WAREHOUSE:FindNearestWarehouse(MinAssets, Descriptor, DescriptorValue, Coalition, RefCoordinate) end

---Find an asset in the the global warehouse data base. Parameter is the MOOSE group object.
---Note that the group name must contain they "AID" keyword.
---@param group? GROUP The group from which it is assumed that it has a registered asset.
---@return WAREHOUSE.Assetitem # The asset from the data base or nil if it could not be found.
function WAREHOUSE:FindAssetInDB(group) end

---Check if runway is operational.
---@return boolean # If `true`, runway is operational.
function WAREHOUSE:IsRunwayOperational() end

---Set the time until the runway(s) of an airdrome are repaired after it has been destroyed.
---Note that this is the time, the DCS engine uses not something we can control on a user level or we could get via scripting.
---You need to input the value. On the DCS forum it was stated that this is currently one hour. Hence this is the default value.
---@param RepairTime? number (Optional) Time in seconds until the runway is repaired. Default 3600 sec (one hour).
---@return WAREHOUSE # self
function WAREHOUSE:SetRunwayRepairtime(RepairTime) end

---Check if runway is operational.
---@return number # Time in seconds until the runway is repaired. Will return 0 if runway is repaired.
function WAREHOUSE:GetRunwayRepairtime() end

---Check if warehouse physical representation is a unit (not a static) object.
---@return boolean # If `true`, warehouse object is a unit.
function WAREHOUSE:IsUnit() end

---Check if warehouse physical representation is a static (not a unit) object.
---@return boolean # If `true`, warehouse object is a static.
function WAREHOUSE:IsStatic() end

---Check if warehouse physical representation is a ship.
---@return boolean # If `true`, warehouse object is a ship.
function WAREHOUSE:IsShip() end

---On after Start event. Starts the warehouse. Adds event handlers and schedules status updates of reqests and queue.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterStart(From, Event, To) end

---On after "Restart" event. Restarts the warehouse when it was in stopped state by reactivating the event handlers *only*.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterRestart(From, Event, To) end

---On after "Stop" event. Stops the warehouse, unhandles all events.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterStop(From, Event, To) end

---On after "Pause" event. Pauses the warehouse, i.e. no requests are processed. However, new requests and new assets can be added in this state.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterPause(From, Event, To) end

---On after "Unpause" event. Unpauses the warehouse, i.e. requests in queue are processed again.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterUnpause(From, Event, To) end

---On after Status event. Checks the queue and handles requests.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterStatus(From, Event, To) end

---Function that checks if a pending job is done and can be removed from queue.
function WAREHOUSE:_JobDone() end

---Function that checks if an asset group is still okay.
function WAREHOUSE:_CheckAssetStatus() end

---On after "AddAsset" event. Add a group to the warehouse stock. If the group is alive, it is destroyed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP Group or template group to be added to the warehouse stock.
---@param ngroups? number (Optional) Number of groups to add to the warehouse stock. Default is 1.
---@param forceattribute? WAREHOUSE.Attribute|number|string (Optional) Explicitly force a generalized attribute for the asset. This has to be an @{#WAREHOUSE.Attribute}.
---@param forcecargobay? number (Optional) Explicitly force cargobay weight limit in kg for cargo carriers. This is for each *unit* of the group.
---@param forceweight? number (Optional) Explicitly force weight in kg of each unit in the group.
---@param loadradius? number (Optional) Radius in meters when the cargo is loaded into the carrier.
---@param skill? AI.Skill|number|string Skill of the asset.
---@param liveries? table Table of livery names. When the asset is spawned one livery is chosen randomly.
---@param assignment? string A free to choose string specifying an assignment for the asset. This can be used with the @{#WAREHOUSE.OnAfterNewAsset} function.
---@param other? table (Optional) Table of other useful data. Can be collected via WAREHOUSE.OnAfterNewAsset() function for example
function WAREHOUSE:onafterAddAsset(From, Event, To, group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries, assignment, other) end

---Register new asset in globase warehouse data base.
---@param group? GROUP The group that will be added to the warehouse stock.
---@param ngroups? number Number of groups to be added.
---@param forceattribute? string Forced generalized attribute.
---@param forcecargobay? number Cargo bay weight limit in kg.
---@param forceweight? number Weight of units in kg.
---@param loadradius? number Radius in meters when cargo is loaded into the carrier.
---@param liveries? table Table of liveries.
---@param skill? AI.Skill|number|string Skill of AI.
---@param assignment? string Assignment attached to the asset item.
---@return table # A table containing all registered assets.
function WAREHOUSE:_RegisterAsset(group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, liveries, skill, assignment) end

---Asset item characteristics.
---@param asset? WAREHOUSE.Assetitem|number|string The asset for which info in printed in trace mode.
function WAREHOUSE:_AssetItemInfo(asset) end

---This function uses Disposition and other fallback logic to find better ground positions for ground units.
---NOTE: This is not a spawn randomizer.
---It will try to find clear ground locations avoiding trees, water, roads, runways, map scenery, statics and other units in the area and modifies the provided positions table.
---Maintains the original layout and unit positions as close as possible by searching for the next closest valid position to each unit.
---Uses UTILS.ValidateAndRepositionGroundUnits.
---@param Enabled? boolean Enable/disable the feature.
function WAREHOUSE:SetValidateAndRepositionGroundUnits(Enabled) end

---On after "NewAsset" event. A new asset has been added to the warehouse stock.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that has just been added.
---@param assignment? string The (optional) assignment for the asset.
function WAREHOUSE:onafterNewAsset(From, Event, To, asset, assignment) end

---On before "AddRequest" event. Checks some basic properties of the given parameters.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param warehouse? WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor? WAREHOUSE.Descriptor|number|string Descriptor describing the asset that is requested.
---@param AssetDescriptorValue? any
---@param nAsset? number Number of groups requested that match the asset specification.
---@param TransportType? WAREHOUSE.TransportType|number|string Type of transport.
---@param nTransport? number Number of transport units requested.
---@param Assignment? string A keyword or text that later be used to identify this request and postprocess the assets.
---@param Prio? number Priority of the request. Number ranging from 1=high to 100=low.
---@return boolean # If true, request is okay at first glance.
function WAREHOUSE:onbeforeAddRequest(From, Event, To, warehouse, AssetDescriptor, AssetDescriptorValue, nAsset, TransportType, nTransport, Assignment, Prio) end

---On after "AddRequest" event. Add a request to the warehouse queue, which is processed when possible.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param warehouse? WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor? WAREHOUSE.Descriptor|number|string Descriptor describing the asset that is requested.
---@param AssetDescriptorValue? any
---@param nAsset? number Number of groups requested that match the asset specification.
---@param TransportType? WAREHOUSE.TransportType|number|string Type of transport.
---@param nTransport? number Number of transport units requested.
---@param Prio? number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment? string A keyword or text that can later be used to identify this request and postprocess the assets.
function WAREHOUSE:onafterAddRequest(From, Event, To, warehouse, AssetDescriptor, AssetDescriptorValue, nAsset, TransportType, nTransport, Prio, Assignment) end

---On before "Request" event. Checks if the request can be fulfilled.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
---@return boolean # If true, request is granted.
function WAREHOUSE:onbeforeRequest(From, Event, To, Request) end

---On after "Request" event. Spawns the necessary cargo and transport assets.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
function WAREHOUSE:onafterRequest(From, Event, To, Request) end

---On after "RequestSpawned" event. Initiates the transport of the assets to the requesting warehouse.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Request? WAREHOUSE.Pendingitem|number|string Information table of the request.
---@param CargoGroupSet? SET_GROUP Set of cargo groups.
---@param TransportGroupSet? SET_GROUP Set of transport groups if any.
function WAREHOUSE:onafterRequestSpawned(From, Event, To, Request, CargoGroupSet, TransportGroupSet) end

---Function called when a carrier unit has loaded a cargo group.
---@param From? any
---@param Event? any
---@param To? any
---@param OpsGroupCargo? any
---@param OpsGroupCarrier? any
---@param CarrierElement? any
function CargoTransport:OnAfterLoaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier, CarrierElement) end

---Function called when cargo has arrived and was unloaded.
---@param From? any
---@param Event? any
---@param To? any
---@param OpsGroupCargo? any
---@param OpsGroupCarrier? any
function CargoTransport:OnAfterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier) end

---On after "Unloaded" event. Triggered when a group was unloaded from the carrier.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP The group that was delivered.
function WAREHOUSE:onafterUnloaded(From, Event, To, group) end

---On before "Arrived" event. Triggered when a group has arrived at its destination warehouse.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP The group that was delivered.
function WAREHOUSE:onbeforeArrived(From, Event, To, group) end

---On after "Arrived" event. Triggered when a group has arrived at its destination warehouse.
---The routine should be called by the warehouse sending this asset and not by the receiving warehouse.
---It is checked if this asset is cargo (or self propelled) or transport. If it is cargo it is put into the stock of receiving warehouse.
---If it is a transporter it is put back into the sending warehouse since transports are supposed to return their home warehouse.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP The group that was delivered.
function WAREHOUSE:onafterArrived(From, Event, To, group) end

---On after "Delivered" event. Triggered when all asset groups have reached their destination. Corresponding request is deleted from the pending queue.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param request? WAREHOUSE.Pendingitem|number|string The pending request that is finished and deleted from the pending queue.
function WAREHOUSE:onafterDelivered(From, Event, To, request) end

---On after "SelfRequest" event. Request was initiated to the warehouse itself. Groups are just spawned at the warehouse or the associated airbase.
---If the warehouse is currently under attack when the self request is made, the self request is added to the defending table. One the attack is defeated,
---this request is used to put the groups back into the warehouse stock.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param groupset? SET_GROUP The set of asset groups that was delivered to the warehouse itself.
---@param request? WAREHOUSE.Pendingitem|number|string Pending self request.
function WAREHOUSE:onafterSelfRequest(From, Event, To, groupset, request) end

---On after "Attacked" event. Warehouse is under attack by an another coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string which is attacking the warehouse.
---@param Country? country.id|number|string which is attacking the warehouse.
function WAREHOUSE:onafterAttacked(From, Event, To, Coalition, Country) end

---On after "Defeated" event. Warehouse defeated an attack by another coalition. Defender assets are added back to warehouse stock.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterDefeated(From, Event, To) end

---Respawn warehouse.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterRespawn(From, Event, To) end

---On before "ChangeCountry" event. Checks whether a change of country is necessary by comparing the actual country to the the requested one.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Country? country.id|number|string which has captured the warehouse.
function WAREHOUSE:onbeforeChangeCountry(From, Event, To, Country) end

---On after "ChangeCountry" event. Warehouse is respawned with the specified country. All queued requests are deleted and the owned airbase is reset if the coalition is changed by changing the
---country.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Country? country.id|number|string Country which has captured the warehouse.
function WAREHOUSE:onafterChangeCountry(From, Event, To, Country) end

---On before "Captured" event. Warehouse has been captured by another coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function WAREHOUSE:onbeforeCaptured(From, Event, To, Coalition, Country) end

---On after "Captured" event. Warehouse has been captured by another coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string which captured the warehouse.
---@param Country? country.id|number|string which has captured the warehouse.
function WAREHOUSE:onafterCaptured(From, Event, To, Coalition, Country) end

---On after "AirbaseCaptured" event. Airbase of warehouse has been captured by another coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string which captured the warehouse.
function WAREHOUSE:onafterAirbaseCaptured(From, Event, To, Coalition) end

---On after "AirbaseRecaptured" event. Airbase of warehouse has been re-captured from other coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string Coalition side which originally captured the warehouse.
function WAREHOUSE:onafterAirbaseRecaptured(From, Event, To, Coalition) end

---On after "RunwayDestroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterRunwayDestroyed(From, Event, To) end

---On after "RunwayRepaired" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterRunwayRepaired(From, Event, To) end

---On after "AssetSpawned" event triggered when an asset group is spawned into the cruel world.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP The group spawned.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is dead.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the dead asset.
function WAREHOUSE:onafterAssetSpawned(From, Event, To, group, asset, request) end

---On after "AssetDead" event triggered when an asset group died.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is dead.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the dead asset.
function WAREHOUSE:onafterAssetDead(From, Event, To, asset, request) end

---On after "Destroyed" event. Warehouse was destroyed. All services are stopped. Warehouse is going to "Stopped" state in one minute.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:onafterDestroyed(From, Event, To) end

---On after "Save" event. Warehouse assets are saved to file on disk.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is saved. If nil, file is saved in the DCS root installtion directory.
---@param filename? string (Optional) Name of the file containing the asset data.
function WAREHOUSE:onafterSave(From, Event, To, path, filename) end

---On before "Load" event. Checks if the file the warehouse data should be loaded from exists.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is loaded from.
---@param filename? string (Optional) Name of the file containing the asset data.
function WAREHOUSE:onbeforeLoad(From, Event, To, path, filename) end

---On after "Load" event. Warehouse assets are loaded from file on disk.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is loaded from.
---@param filename? string (Optional) Name of the file containing the asset data.
function WAREHOUSE:onafterLoad(From, Event, To, path, filename) end

---Spawns requested assets at warehouse or associated airbase.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
function WAREHOUSE:_SpawnAssetRequest(Request) end

---Spawn a ground or naval asset in the corresponding spawn zone of the warehouse.
---@param alias? string Alias name of the asset group.
---@param asset? WAREHOUSE.Assetitem|number|string Ground asset that will be spawned.
---@param request? WAREHOUSE.Queueitem|number|string Request belonging to this asset. Needed for the name/alias.
---@param spawnzone? ZONE Zone where the assets should be spawned.
---@param lateactivated? boolean If true, groups are spawned late activated.
---@return GROUP # The spawned group or nil if the group could not be spawned.
function WAREHOUSE:_SpawnAssetGroundNaval(alias, asset, request, spawnzone, lateactivated) end

---Spawn an aircraft asset (plane or helo) at the airbase associated with the warehouse.
---@param alias? string Alias name of the asset group.
---@param asset? WAREHOUSE.Assetitem|number|string Ground asset that will be spawned.
---@param request? WAREHOUSE.Queueitem|number|string Request belonging to this asset. Needed for the name/alias.
---@param parking? table Parking data for this asset.
---@param uncontrolled? boolean Spawn aircraft in uncontrolled state.
---@param lateactivated? boolean If true, groups are spawned late activated.
---@return GROUP # The spawned group or nil if the group could not be spawned.
function WAREHOUSE:_SpawnAssetAircraft(alias, asset, request, parking, uncontrolled, lateactivated) end

---Prepare a spawn template for the asset. Deep copy of asset template, adjusting template and unit names, nillifying group and unit ids.
---@param asset? WAREHOUSE.Assetitem|number|string Ground asset that will be spawned.
---@param alias? string Alias name of the group.
---@return table # Prepared new spawn template.
function WAREHOUSE:_SpawnAssetPrepareTemplate(asset, alias) end

---Route ground units to destination. ROE is set to return fire and alarm state to green.
---@param group? GROUP The ground group to be routed
---@param request? WAREHOUSE.Queueitem|number|string The request for this group.
function WAREHOUSE:_RouteGround(group, request) end

---Route naval units along user defined shipping lanes to destination warehouse. ROE is set to return fire.
---@param group? GROUP The naval group to be routed
---@param request? WAREHOUSE.Queueitem|number|string The request for this group.
function WAREHOUSE:_RouteNaval(group, request) end

---Route the airplane from one airbase another. Activates uncontrolled aircraft and sets ROE/ROT for ferry flights.
---ROE is set to return fire and ROT to passive defence.
---@param aircraft? GROUP Airplane group to be routed.
function WAREHOUSE:_RouteAir(aircraft) end

---Route trains to their destination - or at least to the closest point on rail of the desired final destination.
---@param Group? GROUP The train group.
---@param Coordinate? COORDINATE of the destination. Tail will be routed to the closest point
---@param Speed? number (Optional) Speed in km/h to drive to the destination coordinate. Default is 60% of max possible speed the unit can go.
function WAREHOUSE:_RouteTrain(Group, Coordinate, Speed) end

---Task function for last waypoint. Triggering the "Arrived" event.
---@param group? GROUP The group that arrived.
function WAREHOUSE:_Arrived(group) end

---Task function for when passing a waypoint.
---@param group? GROUP The group that arrived.
---@param n? number Waypoint passed.
---@param N? number Final waypoint.
function WAREHOUSE:_PassingWaypoint(group, n, N) end

---Get a warehouse asset from its unique id.
---@param id? number Asset ID.
---@return WAREHOUSE.Assetitem # The warehouse asset.
function WAREHOUSE:GetAssetByID(id) end

---Get a warehouse asset from its name.
---@param GroupName? string Spawn group name.
---@return WAREHOUSE.Assetitem # The warehouse asset.
function WAREHOUSE:GetAssetByName(GroupName) end

---Get a warehouse request from its unique id.
---@param id? number Request ID.
---@return WAREHOUSE.Pendingitem # The warehouse requested - either queued or pending.
---@return boolean # If *true*, request is queued, if *false*, request is pending, if *nil*, request could not be found.
function WAREHOUSE:GetRequestByID(id) end

---Warehouse event function, handling the birth of a unit.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventBirth(EventData) end

---Function handling the event when a (warehouse) unit starts its engines.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventEngineStartup(EventData) end

---Function handling the event when a (warehouse) unit takes off.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventTakeOff(EventData) end

---Function handling the event when a (warehouse) unit lands.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventLanding(EventData) end

---Function handling the event when a (warehouse) unit shuts down its engines.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventEngineShutdown(EventData) end

---Arrived event if an air unit/group arrived at its destination. This can be an engine shutdown or a landing event.
---@param EventData? EVENTDATA Event data table.
function WAREHOUSE:_OnEventArrived(EventData) end

---Warehouse event handling function.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventCrashOrDead(EventData) end

---A unit of a group just died. Update group sets in request.
---This is important in order to determine if a job is done and can be removed from the (pending) queue.
---@param deadunit? UNIT Unit that died.
---@param deadgroup? GROUP Group of unit that died.
---@param request? WAREHOUSE.Pendingitem|number|string Request that needs to be updated.
function WAREHOUSE:_UnitDead(deadunit, deadgroup, request) end

---Warehouse event handling function.
---Handles the case when the airbase associated with the warehous is captured.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventBaseCaptured(EventData) end

---Warehouse event handling function.
---Handles the case when the mission is ended.
---@param EventData? EVENTDATA Event data.
function WAREHOUSE:_OnEventMissionEnd(EventData) end

---Checks if the warehouse zone was conquered by antoher coalition.
function WAREHOUSE:_CheckConquered() end

---Checks if the associated airbase still belongs to the warehouse.
function WAREHOUSE:_CheckAirbaseOwner() end

---Checks if the request can be fulfilled in general. If not, it is removed from the queue.
---Check if departure and destination bases are of the right type.
---@param queue? table The queue which is holding the requests to check.
---@return boolean # If true, request can be executed. If false, something is not right.
function WAREHOUSE:_CheckRequestConsistancy(queue) end

---Check if a request is valid in general. If not, it will be removed from the queue.
---This routine needs to have at least one asset in stock that matches the request descriptor in order to determine whether the request category of troops.
---If no asset is in stock, the request will remain in the queue but cannot be executed.
---@param request? WAREHOUSE.Queueitem|number|string The request to be checked.
---@return boolean # If true, request can be executed. If false, something is not right.
function WAREHOUSE:_CheckRequestValid(request) end

---Checks if the request can be fulfilled right now.
---Check for current parking situation, number of assets and transports currently in stock.
---@param request? WAREHOUSE.Queueitem|number|string The request to be checked.
---@return boolean # If true, request can be executed. If false, something is not right.
function WAREHOUSE:_CheckRequestNow(request) end

---Get (optimized) transport carriers for the given assets to be transported.
---@param request? any
function WAREHOUSE:_GetTransportsForAssets(request) end

---Relative to absolute quantity.
---@param relative? string Relative number in terms of @{#WAREHOUSE.Quantity}.
---@param ntot? number Total number.
---@return number # Absolute number.
function WAREHOUSE:_QuantityRel2Abs(relative, ntot) end

---Sorts the queue and checks if the request can be fulfilled.
---@return WAREHOUSE.Queueitem # Chosen request.
function WAREHOUSE:_CheckQueue() end

---Simple task function. Can be used to call a function which has the warehouse and the executing group as parameters.
---@param Function? string The name of the function to call passed as string.
---@param group? GROUP The group which is meant.
function WAREHOUSE:_SimpleTaskFunction(Function, group) end

---Simple task function. Can be used to call a function which has the warehouse and the executing group as parameters.
---@param Function? string The name of the function to call passed as string.
---@param group? GROUP The group which is meant.
---@param n? number Waypoint passed.
---@param N? number Final waypoint number.
function WAREHOUSE:_SimpleTaskFunctionWP(Function, group, n, N) end

---Get the proper terminal type based on generalized attribute of the group.
---@param _attribute? WAREHOUSE.Attribute|number|string Generlized attibute of unit.
---@param _category? number Airbase category.
---@return AIRBASE.TerminalType # Terminal type for this group.
function WAREHOUSE:_GetTerminal(_attribute, _category) end

---Seach unoccupied parking spots at the airbase for a list of assets. For each asset group a list of parking spots is returned.
---During the search also the not yet spawned asset aircraft are considered.
---If not enough spots for all asset units could be found, the routine returns nil!
---@param airbase? AIRBASE The airbase where we search for parking spots.
---@param assets? table A table of assets for which the parking spots are needed.
---@return table # Table of coordinates and terminal IDs of free parking spots. Each table entry has the elements .Coordinate and .TerminalID.
function WAREHOUSE:_FindParkingForAssets(airbase, assets) end

---Get the request belonging to a group.
---@param group? GROUP The group from which the info is gathered.
---@param queue? table Queue holding all requests.
---@return WAREHOUSE.Pendingitem # The request belonging to this group.
function WAREHOUSE:_GetRequestOfGroup(group, queue) end

---Is the group a used as transporter for a given request?
---@param group? GROUP The group from which the info is gathered.
---@param request? WAREHOUSE.Pendingitem|number|string Request.
---@return boolean # True if group is transport, false if group is cargo and nil otherwise.
function WAREHOUSE:_GroupIsTransport(group, request) end

---Get group name without any spawn or cargo suffix #CARGO etc.
---@param group? GROUP The group from which the info is gathered.
---@return string # Name of the object without trailing #...
function WAREHOUSE:_GetNameWithOut(group) end

---Get warehouse id, asset id and request id from group name (alias).
---@param group? GROUP The group from which the info is gathered.
---@return number # Warehouse ID.
---@return number # Asset ID.
---@return number # Request ID.
function WAREHOUSE:_GetIDsFromGroup(group) end

---Get warehouse id, asset id and request id from group name (alias).
---@param groupname? string Name of the group from which the info is gathered.
---@return number # Warehouse ID.
---@return number # Asset ID.
---@return number # Request ID.
function WAREHOUSE:_GetIDsFromGroupName(groupname) end

---Filter stock assets by descriptor and attribute.
---@param descriptor? string Descriptor describing the filtered assets.
---@param attribute? any
---@param nmax? number (Optional) Maximum number of items that will be returned. Default nmax=nil is all matching items are returned.
---@param mobile? boolean (Optional) If true, filter only mobile assets.
---@return table # Filtered assets in stock with the specified descriptor value.
---@return number # Total number of (requested) assets available.
---@return boolean # If true, enough assets are available.
function WAREHOUSE:FilterStock(descriptor, attribute, nmax, mobile) end

---Filter stock assets by table entry.
---@param stock? table Table holding all assets in stock of the warehouse. Each entry is of type @{#WAREHOUSE.Assetitem}.
---@param descriptor? string Descriptor describing the filtered assets.
---@param attribute? any
---@param nmax? number (Optional) Maximum number of items that will be returned. Default nmax=nil is all matching items are returned.
---@param mobile? boolean (Optional) If true, filter only mobile assets.
---@return table # Filtered stock items table.
---@return number # Total number of (requested) assets available.
---@return boolean # If true, enough assets are available.
function WAREHOUSE:_FilterStock(stock, descriptor, attribute, nmax, mobile) end

---Check if a group has a generalized attribute.
---@param group? GROUP MOOSE group object.
---@param attribute? WAREHOUSE.Attribute|number|string Attribute to check.
---@return boolean # True if group has the specified attribute.
function WAREHOUSE:_HasAttribute(group, attribute) end

---Get the generalized attribute of a group.
---Note that for a heterogenious group, the attribute is determined from the attribute of the first unit!
---@param group? GROUP MOOSE group object.
---@return WAREHOUSE.Attribute # Generalized attribute of the group.
function WAREHOUSE:_GetAttribute(group) end

---Size of the bounding box of a DCS object derived from the DCS descriptor table. If boundinb box is nil, a size of zero is returned.
---@param DCSobject? Object The DCS object for which the size is needed.
---@return number # Max size of object in meters (length (x) or width (z) components not including height (y)).
---@return number # Length (x component) of size.
---@return number # Height (y component) of size.
---@return number # Width (z component) of size.
function WAREHOUSE:_GetObjectSize(DCSobject) end

---Returns the number of assets for each generalized attribute.
---@param stock? table The stock of the warehouse.
---@return table # Data table holding the numbers, i.e. data[attibute]=n.
function WAREHOUSE:GetStockInfo(stock) end

---Delete an asset item from stock.
---@param stockitem? WAREHOUSE.Assetitem|number|string Asset item to delete from stock table.
function WAREHOUSE:_DeleteStockItem(stockitem) end

---Delete item from queue.
---@param qitem? WAREHOUSE.Queueitem|number|string Item of queue to be removed.
---@param queue? table The queue from which the item should be deleted.
function WAREHOUSE:_DeleteQueueItem(qitem, queue) end

---Delete item from queue.
---@param qitemID? number ID of queue item to be removed.
---@param queue? table The queue from which the item should be deleted.
function WAREHOUSE:_DeleteQueueItemByID(qitemID, queue) end

---Sort requests queue wrt prio and request uid.
function WAREHOUSE:_SortQueue() end

---Checks fuel on all pening assets.
function WAREHOUSE:_CheckFuel() end

---Prints the queue to DCS.log file.
---@param queue? table Queue to print.
---@param name? string Name of the queue for info reasons.
function WAREHOUSE:_PrintQueue(queue, name) end

---Display status of warehouse.
function WAREHOUSE:_DisplayStatus() end

---Get text about warehouse stock.
---@param messagetoall? boolean If true, send message to all.
---@return string # Text about warehouse stock
function WAREHOUSE:_GetStockAssetsText(messagetoall) end

---Create or update mark text at warehouse, which is displayed in F10 map showing how many assets of each type are in stock.
---Only the coalition of the warehouse owner is able to see it.
---@return string # Text about warehouse stock
function WAREHOUSE:_UpdateWarehouseMarkText() end

---Display stock items of warehouse.
---@param stock? table Table holding all assets in stock of the warehouse. Each entry is of type @{#WAREHOUSE.Assetitem}.
function WAREHOUSE:_DisplayStockItems(stock) end

---Fireworks!
---@param coord? COORDINATE
function WAREHOUSE:_Fireworks(coord) end

---Info Message. Message send to coalition if reports or debug mode activated (and duration > 0). Text self:I(text) added to DCS.log file.
---@param text? string The text of the error message.
---@param duration? number (Optional) Message display duration in seconds. Default 20 sec. If duration is zero, no message is displayed.
function WAREHOUSE:_InfoMessage(text, duration) end

---Debug message. Message send to all if debug mode is activated (and duration > 0). Text self:T(text) added to DCS.log file.
---@param text? string The text of the error message.
---@param duration? number (Optional) Message display duration in seconds. Default 20 sec. If duration is zero, no message is displayed.
function WAREHOUSE:_DebugMessage(text, duration) end

---Error message. Message send to all (if duration > 0). Text self:E(text) added to DCS.log file.
---@param text? string The text of the error message.
---@param duration? number (Optional) Message display duration in seconds. Default 20 sec. If duration is zero, no message is displayed.
function WAREHOUSE:_ErrorMessage(text, duration) end

---Calculate the maximum height an aircraft can reach for the given parameters.
---@param D? number Total distance in meters from Departure to holding point at destination.
---@param alphaC? number Climb angle in rad.
---@param alphaD? number Descent angle in rad.
---@param Hdep? number AGL altitude of departure point.
---@param Hdest? number AGL altitude of destination point.
---@param Deltahhold? number Relative altitude of holding point above destination.
---@return number # Maximum height the aircraft can reach.
function WAREHOUSE:_GetMaxHeight(D, alphaC, alphaD, Hdep, Hdest, Deltahhold) end

---Make a flight plan from a departure to a destination airport.
---@param asset? WAREHOUSE.Assetitem|number|string
---@param departure? AIRBASE Departure airbase.
---@param destination? AIRBASE Destination airbase.
---@return table # Table of flightplan waypoints.
---@return table # Table of flightplan coordinates.
function WAREHOUSE:_GetFlightplan(asset, departure, destination) end

---Triggers the FSM event "Start". Starts the warehouse. Initializes parameters and starts event handlers.
function WAREHOUSE:Start() end

---Triggers the FSM event "Start" after a delay. Starts the warehouse. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Start(delay) end

---Triggers the FSM event "Stop". Stops the warehouse and all its event handlers. All waiting and pending queue items are deleted as well and all assets are removed from stock.
function WAREHOUSE:Stop() end

---Triggers the FSM event "Stop" after a delay. Stops the warehouse and all its event handlers. All waiting and pending queue items are deleted as well and all assets are removed from stock.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Stop(delay) end

---Triggers the FSM event "Restart". Restarts the warehouse from stopped state by reactivating the event handlers *only*.
function WAREHOUSE:Restart() end

---Triggers the FSM event "Restart" after a delay. Restarts the warehouse from stopped state by reactivating the event handlers *only*.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Restart(delay) end

---Triggers the FSM event "Respawn".
function WAREHOUSE:Respawn() end

---Triggers the FSM event "Respawn" after a delay.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Respawn(delay) end

---On after "Respawn" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:OnAfterRespawn(From, Event, To) end

---Triggers the FSM event "Pause". Pauses the warehouse. Assets can still be added and requests be made. However, requests are not processed.
function WAREHOUSE:Pause() end

---Triggers the FSM event "Pause" after a delay. Pauses the warehouse. Assets can still be added and requests be made. However, requests are not processed.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Pause(delay) end

---Triggers the FSM event "Unpause". Unpauses the warehouse. Processing of queued requests is resumed.
function WAREHOUSE:UnPause() end

---Triggers the FSM event "Unpause" after a delay. Unpauses the warehouse. Processing of queued requests is resumed.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Unpause(delay) end

---Triggers the FSM event "Status". Queue is updated and requests are executed.
function WAREHOUSE:Status() end

---Triggers the FSM event "Status" after a delay. Queue is updated and requests are executed.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Status(delay) end

---Trigger the FSM event "AddAsset". Add a group to the warehouse stock.
---@param group? GROUP Group to be added as new asset.
---@param ngroups? number (Optional) Number of groups to add to the warehouse stock. Default is 1.
---@param forceattribute? WAREHOUSE.Attribute|number|string (Optional) Explicitly force a generalized attribute for the asset. This has to be an @{#WAREHOUSE.Attribute}.
---@param forcecargobay? number (Optional) Explicitly force cargobay weight limit in kg for cargo carriers. This is for each *unit* of the group.
---@param forceweight? number (Optional) Explicitly force weight in kg of each unit in the group.
---@param loadradius? number (Optional) The distance in meters when the cargo is loaded into the carrier. Default is the bounding box size of the carrier.
---@param skill? AI.Skill|number|string Skill of the asset.
---@param liveries? table Table of livery names. When the asset is spawned one livery is chosen randomly.
---@param assignment? string A free to choose string specifying an assignment for the asset. This can be used with the @{#WAREHOUSE.OnAfterNewAsset} function.
function WAREHOUSE:AddAsset(group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries, assignment) end

---Trigger the FSM event "AddAsset" with a delay. Add a group to the warehouse stock.
---@param delay? number Delay in seconds.
---@param group? GROUP Group to be added as new asset.
---@param ngroups? number (Optional) Number of groups to add to the warehouse stock. Default is 1.
---@param forceattribute? WAREHOUSE.Attribute|number|string (Optional) Explicitly force a generalized attribute for the asset. This has to be an @{#WAREHOUSE.Attribute}.
---@param forcecargobay? number (Optional) Explicitly force cargobay weight limit in kg for cargo carriers. This is for each *unit* of the group.
---@param forceweight? number (Optional) Explicitly force weight in kg of each unit in the group.
---@param loadradius? number (Optional) The distance in meters when the cargo is loaded into the carrier. Default is the bounding box size of the carrier.
---@param skill? AI.Skill|number|string Skill of the asset.
---@param liveries? table Table of livery names. When the asset is spawned one livery is chosen randomly.
---@param assignment? string A free to choose string specifying an assignment for the asset. This can be used with the @{#WAREHOUSE.OnAfterNewAsset} function.
function WAREHOUSE:__AddAsset(delay, group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries, assignment) end

---Triggers the FSM delayed event "NewAsset" when a new asset has been added to the warehouse stock.
---@param asset? WAREHOUSE.Assetitem|number|string The new asset.
---@param assignment? string (Optional) Assignment text for the asset.
function WAREHOUSE:NewAsset(asset, assignment) end

---Triggers the FSM delayed event "NewAsset" when a new asset has been added to the warehouse stock.
---@param delay? number Delay in seconds.
---@param asset? WAREHOUSE.Assetitem|number|string The new asset.
---@param assignment? string (Optional) Assignment text for the asset.
function WAREHOUSE:__NewAsset(delay, asset, assignment) end

---On after "NewAsset" event user function. A new asset has been added to the warehouse stock.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that has just been added.
---@param assignment? string (Optional) Assignment text for the asset.
function WAREHOUSE:OnAfterNewAsset(From, Event, To, asset, assignment) end

---Triggers the FSM event "AddRequest". Add a request to the warehouse queue, which is processed when possible.
---@param warehouse? WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor? WAREHOUSE.Descriptor|number|string Descriptor describing the asset that is requested.
---@param Value? AssetDescriptorValue of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset? number Number of groups requested that match the asset specification.
---@param TransportType? WAREHOUSE.TransportType|number|string Type of transport.
---@param nTransport? number Number of transport units requested.
---@param Prio? number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment? string A keyword or text that later be used to identify this request and postprocess the assets.
function WAREHOUSE:AddRequest(warehouse, AssetDescriptor, Value, nAsset, TransportType, nTransport, Prio, Assignment) end

---Triggers the FSM event "AddRequest" with a delay. Add a request to the warehouse queue, which is processed when possible.
---@param delay? number Delay in seconds.
---@param warehouse? WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor? WAREHOUSE.Descriptor|number|string Descriptor describing the asset that is requested.
---@param Value? AssetDescriptorValue of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset? number Number of groups requested that match the asset specification.
---@param TransportType? WAREHOUSE.TransportType|number|string Type of transport.
---@param nTransport? number Number of transport units requested.
---@param Prio? number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment? string A keyword or text that later be used to identify this request and postprocess the assets.
function WAREHOUSE:__AddRequest(delay, warehouse, AssetDescriptor, Value, nAsset, TransportType, nTransport, Prio, Assignment) end

---Triggers the FSM event "Request". Executes a request from the queue if possible.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
function WAREHOUSE:Request(Request) end

---Triggers the FSM event "Request" after a delay. Executes a request from the queue if possible.
---@param Delay? number Delay in seconds.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
function WAREHOUSE:__Request(Delay, Request) end

---On before "Request" user function. The necessary cargo and transport assets will be spawned. Time to set some additional asset parameters.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
function WAREHOUSE:OnBeforeRequest(From, Event, To, Request) end

---On after "Request" user function. The necessary cargo and transport assets were spawned.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Request? WAREHOUSE.Queueitem|number|string Information table of the request.
function WAREHOUSE:OnAfterRequest(From, Event, To, Request) end

---Triggers the FSM event "Arrived" when a group has arrived at the destination warehouse.
---This function should always be called from the sending and not the receiving warehouse.
---If the group is a cargo asset, it is added to the receiving warehouse. If the group is a transporter it
---is added to the sending warehouse since carriers are supposed to return to their home warehouse once
---all cargo was delivered.
---@param group? GROUP Group that has arrived.
function WAREHOUSE:Arrived(group) end

---Triggers the FSM event "Arrived" after a delay when a group has arrived at the destination.
---This function should always be called from the sending and not the receiving warehouse.
---If the group is a cargo asset, it is added to the receiving warehouse. If the group is a transporter it
---is added to the sending warehouse since carriers are supposed to return to their home warehouse once
---@param delay? number Delay in seconds.
---@param group? GROUP Group that has arrived.
function WAREHOUSE:__Arrived(delay, group) end

---On after "Arrived" event user function. Called when a group has arrived at its destination.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP Group that has arrived.
function WAREHOUSE:OnAfterArrived(From, Event, To, group) end

---Triggers the FSM event "Delivered". All (cargo) assets of a request have been delivered to the receiving warehouse.
---@param request? WAREHOUSE.Pendingitem|number|string Pending request that was now delivered.
function WAREHOUSE:Delivered(request) end

---Triggers the FSM event "Delivered" after a delay. A group has been delivered from the warehouse to another warehouse.
---@param delay? number Delay in seconds.
---@param request? WAREHOUSE.Pendingitem|number|string Pending request that was now delivered.
function WAREHOUSE:__Delivered(delay, request) end

---On after "Delivered" event user function. Called when a group has been delivered from the warehouse to another warehouse.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param request? WAREHOUSE.Pendingitem|number|string Pending request that was now delivered.
function WAREHOUSE:OnAfterDelivered(From, Event, To, request) end

---Triggers the FSM event "SelfRequest". Request was initiated from the warehouse to itself. Groups are just spawned at the warehouse or the associated airbase.
---If the warehouse is currently under attack when the self request is made, the self request is added to the defending table. One the attack is defeated,
---this request is used to put the groups back into the warehouse stock.
---@param groupset? SET_GROUP The set of cargo groups that was delivered to the warehouse itself.
---@param request? WAREHOUSE.Pendingitem|number|string Pending self request.
function WAREHOUSE:SelfRequest(groupset, request) end

---Triggers the FSM event "SelfRequest" with a delay. Request was initiated from the warehouse to itself. Groups are just spawned at the warehouse or the associated airbase.
---If the warehouse is currently under attack when the self request is made, the self request is added to the defending table. One the attack is defeated,
---this request is used to put the groups back into the warehouse stock.
---@param delay? number Delay in seconds.
---@param groupset? SET_GROUP The set of cargo groups that was delivered to the warehouse itself.
---@param request? WAREHOUSE.Pendingitem|number|string Pending self request.
function WAREHOUSE:__SelfRequest(delay, groupset, request) end

---On after "SelfRequest" event. Request was initiated from the warehouse to itself. Groups are simply spawned at the warehouse or the associated airbase.
---All requested assets are passed as a {Core.Set#SET_GROUP} and can be used for further tasks or in other MOOSE classes.
---Note that airborne assets are spawned in uncontrolled state so they do not simply "fly away" after spawning.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param groupset? SET_GROUP The set of (cargo) groups that was delivered to the warehouse itself.
---@param request? WAREHOUSE.Pendingitem|number|string Pending self request.
function WAREHOUSE:OnAfterSelfRequest(From, Event, To, groupset, request) end

---Triggers the FSM event "Attacked" when a warehouse is under attack by an another coalition.
---@param Coalition? coalition.side|number|string Coalition side which is attacking the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country? country.id|number|string Country ID, which is attacking the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:Attacked(Coalition, Country) end

---Triggers the FSM event "Attacked" with a delay when a warehouse is under attack by an another coalition.
---@param delay? number Delay in seconds.
---@param Coalition? coalition.side|number|string Coalition side which is attacking the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country? country.id|number|string Country ID, which is attacking the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:__Attacked(delay, Coalition, Country) end

---On after "Attacked" event user function. Called when a warehouse (zone) is under attack by an enemy.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string Coalition side which is attacking the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country? country.id|number|string Country ID, which is attacking the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:OnAfterAttacked(From, Event, To, Coalition, Country) end

---Triggers the FSM event "Defeated" when an attack from an enemy was defeated.
function WAREHOUSE:Defeated() end

---Triggers the FSM event "Defeated" with a delay when an attack from an enemy was defeated.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Defeated(delay) end

---On after "Defeated" event user function. Called when an enemy attack was defeated.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:OnAfterDefeate(From, Event, To) end

---Triggers the FSM event "ChangeCountry" so the warehouse is respawned with the new country.
---@param Country? country.id|number|string New country id of the warehouse.
function WAREHOUSE:ChangeCountry(Country) end

---Triggers the FSM event "ChangeCountry" after a delay so the warehouse is respawned with the new country.
---@param delay? number Delay in seconds.
---@param Country? country.id|number|string Country id which has captured the warehouse.
function WAREHOUSE:__ChangeCountry(delay, Country) end

---On after "ChangeCountry" event user function. Called when the warehouse has changed its country.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Country? country.id|number|string New country id of the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:OnAfterChangeCountry(From, Event, To, Country) end

---Triggers the FSM event "Captured" when a warehouse has been captured by another coalition.
---@param Coalition? coalition.side|number|string Coalition side which captured the warehouse.
---@param Country? country.id|number|string Country id which has captured the warehouse.
function WAREHOUSE:Captured(Coalition, Country) end

---Triggers the FSM event "Captured" with a delay when a warehouse has been captured by another coalition.
---@param delay? number Delay in seconds.
---@param Coalition? coalition.side|number|string Coalition side which captured the warehouse.
---@param Country? country.id|number|string Country id which has captured the warehouse.
function WAREHOUSE:__Captured(delay, Coalition, Country) end

---On after "Captured" event user function. Called when the warehouse has been captured by an enemy coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string Coalition side which captured the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country? country.id|number|string Country id which has captured the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:OnAfterCaptured(From, Event, To, Coalition, Country) end

---Triggers the FSM event "AirbaseCaptured" when the airbase of the warehouse has been captured by another coalition.
---@param Coalition? coalition.side|number|string Coalition side which captured the airbase, i.e. a number of @{DCS#coalition.side} enumerator.
function WAREHOUSE:AirbaseCaptured(Coalition) end

---Triggers the FSM event "AirbaseCaptured" with a delay when the airbase of the warehouse has been captured by another coalition.
---@param delay? number Delay in seconds.
---@param Coalition? coalition.side|number|string Coalition side which captured the airbase, i.e. a number of @{DCS#coalition.side} enumerator.
function WAREHOUSE:__AirbaseCaptured(delay, Coalition) end

---On after "AirbaseCaptured" even user function. Called when the airbase of the warehouse has been captured by another coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string Coalition side which captured the airbase, i.e. a number of @{DCS#coalition.side} enumerator.
function WAREHOUSE:OnAfterAirbaseCaptured(From, Event, To, Coalition) end

---Triggers the FSM event "AirbaseRecaptured" when the airbase of the warehouse has been re-captured from the other coalition.
---@param Coalition? coalition.side|number|string Coalition which re-captured the airbase, i.e. the same as the current warehouse owner coalition.
function WAREHOUSE:AirbaseRecaptured(Coalition) end

---Triggers the FSM event "AirbaseRecaptured" with a delay when the airbase of the warehouse has been re-captured from the other coalition.
---@param delay? number Delay in seconds.
---@param Coalition? coalition.side|number|string Coalition which re-captured the airbase, i.e. the same as the current warehouse owner coalition.
function WAREHOUSE:__AirbaseRecaptured(delay, Coalition) end

---On after "AirbaseRecaptured" event user function. Called when the airbase of the warehouse has been re-captured from the other coalition.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Coalition? coalition.side|number|string Coalition which re-captured the airbase, i.e. the same as the current warehouse owner coalition.
function WAREHOUSE:OnAfterAirbaseRecaptured(From, Event, To, Coalition) end

---Triggers the FSM event "AssetDead" when an asset group has died.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is dead.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the dead asset.
function WAREHOUSE:AssetDead(asset, request) end

---Triggers the delayed FSM event "AssetDead" when an asset group has died.
---@param delay? number Delay in seconds.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is dead.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the dead asset.
function WAREHOUSE:__AssetDead(delay, asset, request) end

---On after "AssetDead" event user function. Called when an asset group died.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is dead.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the dead asset.
function WAREHOUSE:OnAfterAssetDead(From, Event, To, asset, request) end

---Triggers the FSM event "Destroyed" when the warehouse was destroyed. Services are stopped.
function WAREHOUSE:Destroyed() end

---Triggers the FSM event "Destroyed" with a delay when the warehouse was destroyed. Services are stopped.
---@param delay? number Delay in seconds.
function WAREHOUSE:__Destroyed(delay) end

---On after "Destroyed" event user function. Called when the warehouse was destroyed. Services are stopped.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function WAREHOUSE:OnAfterDestroyed(From, Event, To) end

---Triggers the FSM event "AssetSpawned" when the warehouse has spawned an asset.
---@param group? GROUP the group that was spawned.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that was spawned.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the spawned asset.
function WAREHOUSE:AssetSpawned(group, asset, request) end

---Triggers the FSM event "AssetSpawned" with a delay when the warehouse has spawned an asset.
---@param delay? number Delay in seconds.
---@param group? GROUP the group that was spawned.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that was spawned.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the spawned asset.
function WAREHOUSE:__AssetSpawned(delay, group, asset, request) end

---On after "AssetSpawned" event user function. Called when the warehouse has spawned an asset.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param group? GROUP the group that was spawned.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that was spawned.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the spawned asset.
function WAREHOUSE:OnAfterAssetSpawned(From, Event, To, group, asset, request) end

---Triggers the FSM event "AssetLowFuel" when an asset runs low on fuel
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is low on fuel.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the asset that is low on fuel.
function WAREHOUSE:AssetLowFuel(asset, request) end

---Triggers the FSM event "AssetLowFuel" with a delay when an asset  runs low on fuel.
---@param delay? number Delay in seconds.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is low on fuel.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the asset that is low on fuel.
function WAREHOUSE:__AssetLowFuel(delay, asset, request) end

---On after "AssetLowFuel" event user function. Called when the an asset is low on fuel.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param asset? WAREHOUSE.Assetitem|number|string The asset that is low on fuel.
---@param request? WAREHOUSE.Pendingitem|number|string The request of the asset that is low on fuel.
function WAREHOUSE:OnAfterAssetLowFuel(From, Event, To, asset, request) end

---Triggers the FSM event "Save" when the warehouse assets are saved to file on disk.
---@param path? string (Optional) Path where the file is saved. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:Save(path, filename) end

---Triggers the FSM event "Save" with a delay when the warehouse assets are saved to a file.
---@param delay? number Delay in seconds.
---@param path? string (Optional) Path where the file is saved. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:__Save(delay, path, filename) end

---On after "Save" event user function. Called when the warehouse assets are saved to disk.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:OnAfterSave(From, Event, To, path, filename) end

---Triggers the FSM event "Load" when the warehouse is loaded from a file on disk.
---@param path? string (Optional) Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:Load(path, filename) end

---Triggers the FSM event "Load" with a delay when the warehouse assets are loaded from disk.
---@param delay? number Delay in seconds.
---@param path? string (Optional) Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:__Load(delay, path, filename) end

---On after "Load" event user function. Called when the warehouse assets are loaded from disk.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:OnAfterLoad(From, Event, To, path, filename) end
