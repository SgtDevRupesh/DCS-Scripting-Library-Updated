---@meta

---@class ASTAR.Node
---@field id number Node id.
---@field coordinate COORDINATE Coordinate of the node.
---@field surfacetype number Surface type.
---@field valid table Cached valid/invalid nodes.
---@field cost table Cached cost.

---ASTAR class.
---@class ASTAR : BASE
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode. Messages to all about status.
---@field lid string Class id string for output to DCS log file.
---@field nodes table Table of nodes.
---@field counter number Node counter.
---@field Nnodes number Number of nodes.
---@field nvalid number Number of nvalid calls.
---@field nvalidcache number Number of cached valid evals.
---@field ncost number Number of cost evaluations.
---@field ncostcache number Number of cached cost evals.
---@field startNode ASTAR.Node Start node.
---@field endNode ASTAR.Node End node.
---@field startCoord COORDINATE Start coordinate.
---@field endCoord COORDINATE End coordinate.
---@field ValidNeighbourFunc function Function to check if a node is valid.
---@field ValidNeighbourArg table Optional arguments passed to the valid neighbour function.
---@field CostFunc function Function to calculate the heuristic "cost" to go from one node to another.
---@field CostArg table Optional arguments passed to the cost function.
ASTAR = {
  ClassName      = "ASTAR",
  Debug          =   nil,
  lid            =   nil,
  nodes          =    {},
  counter        =     1,
  Nnodes         =     0,
  ncost          =     0,
  ncostcache     =     0,
  nvalid         =     0,
  nvalidcache    =     0,
}

---ASTAR class version.
ASTAR.version = "0.4.0"

---Create a new ASTAR object.
---@return ASTAR # self
function ASTAR:New() end

---Set coordinate from where to start.
---@param Coordinate? COORDINATE Start coordinate.
---@return ASTAR # self
function ASTAR:SetStartCoordinate(Coordinate) end

---Set coordinate where you want to go.
---@param Coordinate? COORDINATE end coordinate.
---@return ASTAR # self
function ASTAR:SetEndCoordinate(Coordinate) end

---Create a node from a given coordinate.
---@param Coordinate? COORDINATE The coordinate where to create the node.
---@return ASTAR.Node # The node.
function ASTAR:GetNodeFromCoordinate(Coordinate) end

---Add a node to the table of grid nodes.
---@param Node? ASTAR.Node|number|string The node to be added.
---@return ASTAR # self
function ASTAR:AddNode(Node) end

---Add a node to the table of grid nodes specifying its coordinate.
---@param Coordinate? COORDINATE The coordinate where the node is created.
---@return ASTAR.Node # The node.
function ASTAR:AddNodeFromCoordinate(Coordinate) end

---Check if the coordinate of a node has is at a valid surface type.
---@param Node? ASTAR.Node|number|string The node to be added.
---@param SurfaceTypes? table Surface types, for example `{land.SurfaceType.WATER}`. By default all surface types are valid.
---@return boolean # If true, surface type of node is valid.
function ASTAR:CheckValidSurfaceType(Node, SurfaceTypes) end

---Add a function to determine if a neighbour of a node is valid.
---@param NeighbourFunction? function Function that needs to return *true* for a neighbour to be valid.
---@param ... any
---@return ASTAR # self
function ASTAR:SetValidNeighbourFunction(NeighbourFunction, ...) end

---Set valid neighbours to require line of sight between two nodes.
---@param CorridorWidth? number Width of LoS corridor in meters.
---@return ASTAR # self
function ASTAR:SetValidNeighbourLoS(CorridorWidth) end

---Set valid neighbours to be in a certain distance.
---@param MaxDistance? number (Optional) Max distance between nodes in meters. Default is 2000 m.
---@return ASTAR # self
function ASTAR:SetValidNeighbourDistance(MaxDistance) end

---Set valid neighbours to be in a certain distance.
---@param MaxDistance? number (Optional) Max distance between nodes in meters. Default is 2000 m.
---@return ASTAR # self
function ASTAR:SetValidNeighbourRoad(MaxDistance) end

---Set the function which calculates the "cost" to go from one to another node.
---The first to arguments of this function are always the two nodes under consideration. But you can add optional arguments.
---Very often the distance between nodes is a good measure for the cost.
---@param CostFunction? function Function that returns the "cost".
---@param ... any
---@return ASTAR # self
function ASTAR:SetCostFunction(CostFunction, ...) end

---Set heuristic cost to go from one node to another to be their 2D distance.
---@return ASTAR # self
function ASTAR:SetCostDist2D() end

---Set heuristic cost to go from one node to another to be their 3D distance.
---@return ASTAR # self
function ASTAR:SetCostDist3D() end

---Set heuristic cost to go from one node to another to be their 3D distance.
---@return ASTAR # self
function ASTAR:SetCostRoad() end

---Create a rectangular grid of nodes between star and end coordinate.
---The coordinate system is oriented along the line between start and end point.
---@param ValidSurfaceTypes? table Valid surface types. By default is all surfaces are allowed.
---@param BoxHY? number (Optional) Box "height" in meters along the y-coordinate. Default 40000 meters (40 km).
---@param SpaceX? number (Optional) Additional space in meters before start and after end coordinate. Default 10000 meters (10 km).
---@param deltaX? number (Optional) Increment in the direction of start to end coordinate in meters. Default 2000 meters.
---@param deltaY? number (Optional) Increment perpendicular to the direction of start to end coordinate in meters. Default is same as deltaX.
---@param MarkGrid? boolean If true, create F10 map markers at grid nodes.
---@return ASTAR # self
function ASTAR:CreateGrid(ValidSurfaceTypes, BoxHY, SpaceX, deltaX, deltaY, MarkGrid) end

---Function to check if two nodes have line of sight (LoS).
---@param nodeA? ASTAR.Node|number|string First node.
---@param nodeB? ASTAR.Node|number|string Other node.
---@param corridor? number (Optional) Width of corridor in meters.
---@return boolean # If true, two nodes have LoS.
function ASTAR.LoS(nodeA, nodeB, corridor) end

---Function to check if two nodes have a road connection.
---@param nodeA? ASTAR.Node|number|string First node.
---@param nodeB? ASTAR.Node|number|string Other node.
---@return boolean # If true, two nodes are connected via a road.
function ASTAR.Road(nodeA, nodeB) end

---Function to check if distance between two nodes is less than a threshold distance.
---@param nodeA? ASTAR.Node|number|string First node.
---@param nodeB? ASTAR.Node|number|string Other node.
---@param distmax? number (Optional) Max distance in meters. Default is 2000 m.
---@return boolean # If true, distance between the two nodes is below threshold.
function ASTAR.DistMax(nodeA, nodeB, distmax) end

---Heuristic cost is given by the 2D distance between the nodes.
---@param nodeA? ASTAR.Node|number|string First node.
---@param nodeB? ASTAR.Node|number|string Other node.
---@return number # Distance between the two nodes.
function ASTAR.Dist2D(nodeA, nodeB) end

---Heuristic cost is given by the 3D distance between the nodes.
---@param nodeA? ASTAR.Node|number|string First node.
---@param nodeB? ASTAR.Node|number|string Other node.
---@return number # Distance between the two nodes.
function ASTAR.Dist3D(nodeA, nodeB) end

---Heuristic cost is given by the distance between the nodes on road.
---@param nodeA? ASTAR.Node|number|string First node.
---@param nodeB? ASTAR.Node|number|string Other node.
---@return number # Distance between the two nodes.
function ASTAR.DistRoad(nodeA, nodeB) end

---Find the closest node from a given coordinate.
---@param Coordinate? COORDINATE .
---@return ASTAR.Node # Cloest node to the coordinate.
---@return number # Distance to closest node in meters.
function ASTAR:FindClosestNode(Coordinate) end

---Find the start node.
---@return ASTAR # self
function ASTAR:FindStartNode() end

---Add a node.
---@return ASTAR # self
function ASTAR:FindEndNode() end

---A* pathfinding function. This seaches the path along nodes between start and end nodes/coordinates.
---@param ExcludeStartNode? boolean If *true*, do not include start node in found path. Default is to include it.
---@param ExcludeEndNode? boolean If *true*, do not include end node in found path. Default is to include it.
---@return table # Table of nodes from start to finish.
function ASTAR:GetPath(ExcludeStartNode, ExcludeEndNode) end

---Heuristic "cost" function to go from node A to node B. Default is the distance between the nodes.
---@param nodeA? ASTAR.Node|number|string Node A.
---@param nodeB? ASTAR.Node|number|string Node B.
---@return number # "Cost" to go from node A to node B.
function ASTAR:_HeuristicCost(nodeA, nodeB) end

---Check if going from a node to a neighbour is possible.
---@param node? ASTAR.Node|number|string A node.
---@param neighbor? ASTAR.Node|number|string Neighbour node.
---@return boolean # If true, transition between nodes is possible.
function ASTAR:_IsValidNeighbour(node, neighbor) end

---Calculate 2D distance between two nodes.
---@param nodeA? ASTAR.Node|number|string Node A.
---@param nodeB? ASTAR.Node|number|string Node B.
---@return number # Distance between nodes in meters.
function ASTAR:_DistNodes(nodeA, nodeB) end

---Function that calculates the lowest F score.
---@param set? table The set of nodes IDs.
---@param f_score? number F score.
---@return ASTAR.Node # Best node.
function ASTAR:_LowestFscore(set, f_score) end

---Function to get valid neighbours of a node.
---@param theNode? ASTAR.Node|number|string The node.
---@param nodes? table Possible neighbours.
function ASTAR:_NeighbourNodes(theNode, nodes) end

---Function to check if a node is not in a set.
---@param set? table Set of nodes.
---@param theNode? ASTAR.Node|number|string The node to check.
---@return boolean # If true, the node is not in the set.
function ASTAR:_NotIn(set, theNode) end

---Unwind path function.
---@param flat_path? table Flat path.
---@param map? table Map.
---@param current_node? ASTAR.Node|number|string The current node.
---@return table # Unwinded path.
function ASTAR:_UnwindPath(flat_path, map, current_node) end
