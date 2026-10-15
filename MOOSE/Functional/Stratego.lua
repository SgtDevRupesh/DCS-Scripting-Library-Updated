---@meta

---@class STRATEGO.Target
---@field name string
---@field dist number
---@field points number
---@field coalition number
---@field coalitionname string
---@field coordinate COORDINATRE

---@class STRATEGO.DistData
---@field start string
---@field target string
---@field dist number

---@class STRATEGO.Data
---@field name string
---@field baseweight number
---@field weight number
---@field coalition number
---@field port boolean
---@field zone ZONE_RADIUS ,
---@field coord COORDINATE
---@field type string
---@field opszone OPSZONE
---@field connections number

---**STRATEGO** class, extends Core.Base#BASE
---@class STRATEGO : BASE
---@field ClassName string
---@field debug boolean
---@field version string
---@field portweight number
---@field POIweight number
---@field maxrunways number
---@field coalition number
---@field colors table
---@field airbasetable table
---@field nonconnectedab table
---@field easynames table
---@field maxdist number
---@field disttable table
---@field routexists table
---@field routefactor number
---@field OpsZones table
---@field NeutralBenefit number
---@field Budget number
---@field usebudget boolean
---@field CaptureUnits number
---@field CaptureThreatlevel number
---@field CaptureObjectCategories table
---@field ExcludeShips boolean
---@field StrategoZone ZONE
STRATEGO = {
  ClassName = "STRATEGO",
  debug = false,
  drawzone = false,
  markzone = false,
  version = "0.3.1",
  portweight = 3,
  POIweight = 1,
  maxrunways = 3,
  coalition = nil,
  colors = nil,
  airbasetable = {},
  nonconnectedab = {},
  easynames = {},
  maxdist = 150, -- km
  disttable = {},
  routexists = {},
  routefactor = 5,
  OpsZones = {},
  NeutralBenefit = 100,
  Budget = 0,
  usebudget = false,
  CaptureUnits = 3,
  CaptureThreatlevel = 1,
  CaptureObjectCategories = {Object.Category.UNIT},
  ExcludeShips = true,
}

---@class STRATEGO.Type
---@field AIRBASE string
---@field PORT string
---@field POI string
---@field FARP string
---@field SHIP string
STRATEGO.Type = {
  AIRBASE = "AIRBASE",
  PORT = "PORT",
  POI = "POI",
  FARP = "FARP",
  SHIP = "SHIP",
}

---[USER] Create a new STRATEGO object and start it up.
---@param Name? string Name of the Adviser.
---@param Coalition? number Coalition, e.g. coalition.side.BLUE.
---@param MaxDist? number (Optional) Maximum distance of a single route in kilometers, defaults to 150.
---@return STRATEGO # self
function STRATEGO:New(Name, Coalition, MaxDist) end

---[INTERNAL] FSM function for initial setup and getting ready.
---@param From? any
---@param Event? any
---@param To? any
---@return STRATEGO # self
function STRATEGO:onafterStart(From, Event, To) end

---[INTERNAL] Update knot association
---@param From? any
---@param Event? any
---@param To? any
---@return STRATEGO # self
function STRATEGO:onafterUpdate(From, Event, To) end

---[USER] Set up usage of budget and set an initial budget in points.
---@param Usebudget? boolean If true, use budget for advisory calculations.
---@param StartBudget? number (Optional) Initial budget to be used, defaults to 500.
function STRATEGO:SetUsingBudget(Usebudget, StartBudget) end

---[USER] Set debugging.
---@param Debug? boolean If true, switch on debugging.
---@param DrawZones? boolean If true, draw the OpsZones on the F10 map.
---@param MarkZones? boolean if true, mark the OpsZones on the F10 map (with further information).
function STRATEGO:SetDebug(Debug, DrawZones, MarkZones) end

---[USER] Restrict Stratego to analyse this zone only.
---@param Zone? ZONE The Zone to restrict Stratego to, can be any kind of ZONE Object.
---@return STRATEGO # self
function STRATEGO:SetStrategoZone(Zone) end

---[USER] Set weights for nodes and routes to determine their importance.
---@param MaxRunways? number (Optional) Set the maximum number of runways the big (equals strategic) airbases on the map have. Defaults to 3. The weight of an airbase node hence equals the number of runways.
---@param PortWeight? number (Optional) Set what weight a port node has. Defaults to 3.
---@param POIWeight? number (Optional) Set what weight a POI node has. Defaults to 1.
---@param RouteFactor? number (Optional) Defines which weight each route between two defined nodes gets: Weight * RouteFactor. Defaults to 5.
---@return STRATEGO # self
function STRATEGO:SetWeights(MaxRunways, PortWeight, POIWeight, RouteFactor) end

---[USER] Set neutral benefit, i.e. how many points it is cheaper to decide for a neutral vs an enemy node when taking decisions.
---@param NeutralBenefit? number (Optional) Pointsm defaults to 100.
---@return STRATEGO # self
function STRATEGO:SetNeutralBenefit(NeutralBenefit) end

---[USER] Set how many units of which minimum threat level are needed to capture one node (i.e. the underlying OpsZone).
---@param CaptureUnits? number (Optional) Number of units needed, defaults to 3.
---@param CaptureThreatlevel? number (Optional) Threat level needed, can be 0..10, defaults to 1.
---@param CaptureCategories? any (Optional) Table of object categories which can capture a node, defaults to `{Object.Category.UNIT}`.
---@return STRATEGO # self
function STRATEGO:SetCaptureOptions(CaptureUnits, CaptureThreatlevel, CaptureCategories) end

---[INTERNAL] Analyse airbase setups
---@return STRATEGO # self
function STRATEGO:AnalyseBases() end

---[INTERNAL] Update node coalitions
---@return STRATEGO # self
function STRATEGO:UpdateNodeCoalitions() end

---[INTERNAL] Get an OpsZone from a Zone object.
---@param Zone? ZONE
---@param Coalition? number
---@return OPSZONE # OpsZone
function STRATEGO:GetNewOpsZone(Zone, Coalition) end

---[INTERNAL] Analyse POI setups
---@param Set? any
---@param Weight? any
---@param Key? any
---@return STRATEGO # self
function STRATEGO:AnalysePOIs(Set, Weight, Key) end

---[INTERNAL] Get nice route text
---@param StartPoint? any
---@param EndPoint? any
---@return STRATEGO # self
function STRATEGO:GetToFrom(StartPoint, EndPoint) end

---[USER] Get available connecting nodes from one start node
---@param StartPoint? string The starting name
---@return boolean # found
---@return table # Nodes
function STRATEGO:GetRoutesFromNode(StartPoint) end

---[USER] Manually add a route, for e.g. Island hopping or to connect isolated networks. Use **after** STRATEGO has been started!
---@param Startpoint? string Starting Point, e.g. AIRBASE.Syria.Hatay
---@param Endpoint? string End Point, e.g. AIRBASE.Syria.H4
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Defaults to violet.
---@param Linetype? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 5.
---@param Draw? boolean (Optional) If true, draw route on the F10 map. Defaukt false.
---@return STRATEGO # self
function STRATEGO:AddRoutesManually(Startpoint, Endpoint, Color, Linetype, Draw) end

---[INTERNAL] Analyse routes
---@param tgtrwys? any
---@param factor? any
---@param color? any
---@param linetype? any
---@return STRATEGO # self
function STRATEGO:AnalyseRoutes(tgtrwys, factor, color, linetype) end

---[INTERNAL] Analyse non-connected points.
---@param Color? table RGB color to be used.
---@return STRATEGO # self
function STRATEGO:AnalyseUnconnected(Color) end

---[[
---@param abtable? any
function STRATEGO:PruneDeadEnds(abtable) end

---[USER] Get a list of the nodes with the highest weight.
---@param Coalition? number (Optional) Find for this coalition only. E.g. coalition.side.BLUE.
---@return table # Table of nodes.
---@return number # Weight The consolidated weight associated with the nodes.
---@return number # Highest Highest weight found.
---@return string # Name of the node with the highest weight.
function STRATEGO:GetHighestWeightNodes(Coalition) end

---[USER] Get a list of the nodes a weight less than the given parameter.
---@param Weight? number Weight - nodes need to have less than this weight.
---@param Coalition? number (Optional) Find for this coalition only. E.g. coalition.side.BLUE.
---@return table # Table of nodes.
---@return number # Weight The consolidated weight associated with the nodes.
function STRATEGO:GetNextHighestWeightNodes(Weight, Coalition) end

---[USER] Set the aggregated weight of a single node found by its name manually.
---@param Name? string The name to look for.
---@param Weight? number The weight to be set.
---@return boolean # success
function STRATEGO:SetNodeWeight(Name, Weight) end

---[USER] Set the base weight of a single node found by its name manually.
---@param Name? string The name to look for.
---@param Weight? number The weight to be set.
---@return boolean # success
function STRATEGO:SetNodeBaseWeight(Name, Weight) end

---[USER] Get the aggregated weight of a node by its name.
---@param Name? string The name to look for.
---@return number # Weight The weight or 0 if not found.
function STRATEGO:GetNodeWeight(Name) end

---[USER] Get the base weight of a node by its name.
---@param Name? string The name to look for.
---@return number # Weight The base weight or 0 if not found.
function STRATEGO:GetNodeBaseWeight(Name) end

---[USER] Get the COALITION of a node by its name.
---@param Name? any
---@return number # Coalition The coalition.
function STRATEGO:GetNodeCoalition(Name) end

---[USER] Get the TYPE of a node by its name.
---@param Name? any
---@return string # Type Type of the node, e.g. STRATEGO.Type.AIRBASE or nil if not found.
function STRATEGO:GetNodeType(Name) end

---[USER] Get the ZONE of a node by its name.
---@param Name? any
---@return ZONE # Zone The Zone of the node or nil if not found.
function STRATEGO:GetNodeZone(Name) end

---[USER] Get the OPSZONE of a node by its name.
---@param Name? any
---@return OPSZONE # OpsZone The OpsZone of the node or nil if not found.
function STRATEGO:GetNodeOpsZone(Name) end

---[USER] Get the COORDINATE of a node by its name.
---@param Name? any
---@return COORDINATE # Coordinate The Coordinate of the node or nil if not found.
function STRATEGO:GetNodeCoordinate(Name) end

---[USER] Check if the TYPE of a node is AIRBASE.
---@param Name? any
---@return boolean # Outcome
function STRATEGO:IsAirbase(Name) end

---[USER] Check if the TYPE of a node is PORT.
---@param Name? any
---@return boolean # Outcome
function STRATEGO:IsPort(Name) end

---[USER] Check if the TYPE of a node is POI.
---@param Name? any
---@return boolean # Outcome
function STRATEGO:IsPOI(Name) end

---[USER] Check if the TYPE of a node is FARP.
---@param Name? any
---@return boolean # Outcome
function STRATEGO:IsFARP(Name) end

---[USER] Check if the TYPE of a node is SHIP.
---@param Name? any
---@return boolean # Outcome
function STRATEGO:IsShip(Name) end

---[USER] Get the next best consolidation target node with a lower BaseWeight.
---@param Startpoint? string Name of start point.
---@param BaseWeight? number Base weight of the node, i.e. the number of runways of an airbase or the weight of ports or POIs.
---@return number # ShortestDist Shortest distance found.
---@return string # Name Name of the target node.
---@return number # Weight Consolidated weight of the target node, zero if none found.
---@return number # Coalition Coaltion of the target.
function STRATEGO:FindClosestConsolidationTarget(Startpoint, BaseWeight) end

---[USER] Get the next best strategic target node with same or higher Consolidated Weight.
---@param Startpoint? string Name of start point.
---@param Weight? number Consolidated Weight of the node, i.e. the calculated weight of the node based on number of runways, connections and a weight factor.
---@return number # ShortestDist Shortest distance found.
---@return string # Name Name of the target node.
---@return number # Weight Consolidated weight of the target node, zero if none found.
---@return number # Coalition Coaltion of the target.
function STRATEGO:FindClosestStrategicTarget(Startpoint, Weight) end

---[USER] Get the next best strategic target nodes in the network.
---@return table # of #STRATEGO.Target data points
function STRATEGO:FindStrategicTargets() end

---[USER] Get the next best consolidation target nodes in the network.
---@return table # of #STRATEGO.Target data points
function STRATEGO:FindConsolidationTargets() end

---[USER] Get neighbor nodes of a named node.
---@param Name? string The name to search the neighbors for.
---@param Enemies? boolean (optional) If true, find only enemy neighbors.
---@param Friends? boolean (optional) If true, find only friendly or neutral neighbors.
---@return table # Neighbors Table of #STRATEGO.DistData entries indexed by neighbor node names.
---@return string # Nearest Name of the nearest node.
---@return number # Distance Distance of the nearest node.
function STRATEGO:FindNeighborNodes(Name, Enemies, Friends) end

---[INTERNAL] Route Finding - Find the next hop towards an end node from a start node
---@param Start? string The name of the start node.
---@param End? string The name of the end node.
---@param InRoute? table Table of node names making up the route so far.
---@return string # Name of the next closest node
function STRATEGO:_GetNextClosest(Start, End, InRoute) end

---[USER] Find a route between two nodes.
---@param Start? string The name of the start node.
---@param End? string The name of the end node.
---@param Hops? number Max iterations to find a route.
---@param Draw? boolean If true, draw the route on the map.
---@param Color? table (Optional) RGB color table {r, g, b}, e.g. {1,0,0} for red. Defaults to black.
---@param LineType? number (Optional) Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 6.
---@param NoOptimize? boolean If set to true, do not optimize (shorten) the resulting route if possible.
---@return table # Route Table of #string name entries of the route
---@return boolean # Complete If true, the route was found end-to-end.
---@return boolean # Reverse If true, the route was found with a reverse search, the route table will be from sorted from end point to start point.
function STRATEGO:FindRoute(Start, End, Hops, Draw, Color, LineType, NoOptimize) end

---[USER] Add budget points.
---@param Number? number of points to add.
---@return STRATEGO # self
function STRATEGO:AddBudget(Number) end

---[USER] Subtract budget points.
---@param Number? number of points to subtract.
---@return STRATEGO # self
function STRATEGO:SubtractBudget(Number) end

---[USER] Get budget points.
---@return number # budget
function STRATEGO:GetBudget() end

---[USER] Find **one** affordable strategic target.
---@return table # Target Table with #STRATEGO.Target data or nil if none found.
function STRATEGO:FindAffordableStrategicTarget() end

---[USER] Find **one** affordable consolidation target.
---@return table # Target Table with #STRATEGO.Target data or nil if none found.
function STRATEGO:FindAffordableConsolidationTarget() end

---[INTERNAL] Internal helper function to check for islands, aka Floodtest
---@param next? string Name of the start node
---@param filled? table #table of visited nodes
---@param unfilled? table #table if unvisited nodes
---@return STRATEGO # self
function STRATEGO:_FloodNext(next, filled, unfilled) end

---[INTERNAL] Internal helper function to check for islands, aka Floodtest
---@param Start? string Name of the start node
---@param ABTable? table (Optional) #table of node names to check.
---@return STRATEGO # self
function STRATEGO:_FloodFill(Start, ABTable) end

---[INTERNAL] Internal helper function to check for islands, aka Floodtest
---@param connect? boolean If true, connect the two resulting islands at the shortest distance if necessary
---@param draw? boolean If true, draw outer vertices of found node networks
---@return boolean # Connected If true, all nodes are in one network
---@return table # Network #table of node names in the network
---@return table # Unconnected #table of node names **not** in the network
function STRATEGO:_FloodTest(connect, draw) end

---Triggers the FSM event "Start". Starts the STRATEGO. Initializes parameters and starts event handlers.
function STRATEGO:Start() end

---Triggers the FSM event "Start" after a delay. Starts the STRATEGO. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function STRATEGO:__Start(delay) end

---Triggers the FSM event "Stop". Stops the STRATEGO and all its event handlers.
function STRATEGO:Stop() end

---Triggers the FSM event "Stop" after a delay. Stops the STRATEGO and all its event handlers.
---@param delay? number Delay in seconds.
function STRATEGO:__Stop(delay) end

---FSM Function OnAfterNodeEvent. A node changed coalition.
---@param From? string State.
---@param Event? string Trigger.
---@param To? string State.
---@param OpsZone? OPSZONE The OpsZone triggering the event.
---@param Coalition? number The coalition of the new owner.
---@return STRATEGO # self
function STRATEGO:OnAfterNodeEvent(From, Event, To, OpsZone, Coalition) end
