---@meta

---@class AMMOTRUCK.data
---@field group GROUP
---@field name string
---@field statusquo AMMOTRUCK.State
---@field timestamp number
---@field ammo number
---@field coordinate COORDINATE
---@field targetname string
---@field targetgroup GROUP
---@field targetcoordinate COORDINATE
---@field reloads number

---**AMMOTRUCK** class, extends Core.Fsm#FSM
---@class AMMOTRUCK : FSM
---@field ClassName string Class Name
---@field lid string Lid for log entries
---@field version string Version string
---@field alias string Alias name
---@field debug boolean Debug flag
---@field trucklist table List of (alive) #AMMOTRUCK.data trucks
---@field targetlist table List of (alive) #AMMOTRUCK.data artillery
---@field coalition number Coalition this is for
---@field truckset SET_GROUP SET of trucks
---@field targetset SET_GROUP SET of artillery
---@field remunitionqueue table List of (alive) #AMMOTRUCK.data artillery to be reloaded
---@field waitingtargets table List of (alive) #AMMOTRUCK.data artillery waiting
---@field ammothreshold number Threshold (min) ammo before sending a truck
---@field remunidist number Max distance trucks will go
---@field monitor number Monitor interval in seconds
---@field unloadtime number Unload time in seconds
---@field waitingtime number Max waiting time in seconds
---@field routeonroad boolean Route truck on road if true (default)
---@field reloads number Number of reloads a single truck can do before he must return home
AMMOTRUCK = {
  ClassName = "AMMOTRUCK",
  lid = "",
  version = "0.0.12",
  alias = "",
  debug = false,
  trucklist = {},
  targetlist = {},
  coalition = nil,
  truckset = nil,
  targetset = nil,
  remunitionqueue = {},
  waitingtargets = {},
  ammothreshold = 5,
  remunidist = 20000,
  monitor = -60,
  unloadtime = 600,
  waitingtime = 1800,
  routeonroad = true,
  reloads = 5,
}

---@class AMMOTRUCK.State
AMMOTRUCK.State = {
  IDLE = "idle",
  DRIVING = "driving",
  ARRIVED = "arrived",
  UNLOADING = "unloading",
  RETURNING = "returning",
  WAITING = "waiting",
  RELOADING = "reloading",
  OUTOFAMMO = "outofammo",
  REQUESTED = "requested",
}

---@param Truckset? SET_GROUP Set of truck groups
---@param Targetset? SET_GROUP Set of artillery groups
---@param Coalition? number Coalition
---@param Alias? string Alias Name
---@param Homezone? ZONE Home, return zone for trucks
---@return AMMOTRUCK # self
function AMMOTRUCK:New(Truckset, Targetset, Coalition, Alias, Homezone) end

---@param dataset? table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK # self
function AMMOTRUCK:CheckDrivingTrucks(dataset) end

---@param Group? GROUP
---@return AMMOTRUCK # self
function AMMOTRUCK:GetAmmoStatus(Group) end

---@param dataset? table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK # self
function AMMOTRUCK:CheckWaitingTargets(dataset) end

---@param dataset? table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK # self
function AMMOTRUCK:CheckReturningTrucks(dataset) end

---@param name? string Artillery group name to find
---@return AMMOTRUCK.data # Data
function AMMOTRUCK:FindTarget(name) end

---@param name? string Truck group name to find
---@return AMMOTRUCK.data # Data
function AMMOTRUCK:FindTruck(name) end

---@param dataset? table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK # self
function AMMOTRUCK:CheckArrivedTrucks(dataset) end

---@param dataset? table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK # self
function AMMOTRUCK:CheckUnloadingTrucks(dataset) end

---@return AMMOTRUCK # self
function AMMOTRUCK:CheckTargetsAlive() end

---@return AMMOTRUCK # self
function AMMOTRUCK:CheckTrucksAlive() end

---@param From? string
---@param Event? string
---@param To? string
---@return AMMOTRUCK # self
function AMMOTRUCK:onafterStart(From, Event, To) end

---@param From? string
---@param Event? string
---@param To? string
---@return AMMOTRUCK # self
function AMMOTRUCK:onafterMonitor(From, Event, To) end

---@param From? string
---@param Event? string
---@param To? string
---@param Truckdata? AMMOTRUCK.data|number|string
---@param Aridata? AMMOTRUCK.data|number|string
---@return AMMOTRUCK # self
function AMMOTRUCK:onafterRouteTruck(From, Event, To, Truckdata, Aridata) end

---@param From? string
---@param Event? string
---@param To? string
---@param Truckdata? AMMOTRUCK.data|number|string
---@return AMMOTRUCK # self
function AMMOTRUCK:onafterTruckUnloading(From, Event, To, Truckdata) end

---@param From? string
---@param Event? string
---@param To? string
---@param Truck? AMMOTRUCK.data|number|string
---@return AMMOTRUCK # self
function AMMOTRUCK:onafterTruckReturning(From, Event, To, Truck) end

---@param From? string
---@param Event? string
---@param To? string
---@return AMMOTRUCK # self
function AMMOTRUCK:onafterStop(From, Event, To) end

---Triggers the FSM event "Stop". Stops the AMMOTRUCK and all its event handlers.
function AMMOTRUCK:Stop() end

---Triggers the FSM event "Stop" after a delay. Stops the AMMOTRUCK and all its event handlers.
---@param delay? number Delay in seconds.
function AMMOTRUCK:__Stop(delay) end

---On after "RouteTruck" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Truck? AMMOTRUCK.data|number|string
---@param Artillery? AMMOTRUCK.data|number|string
function AMMOTRUCK:OnAfterRouteTruck(From, Event, To, Truck, Artillery) end

---On after "TruckUnloading" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Truck? AMMOTRUCK.data|number|string
function AMMOTRUCK:OnAfterTruckUnloading(From, Event, To, Truck) end

---On after "TruckReturning" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Truck? AMMOTRUCK.data|number|string
function AMMOTRUCK:OnAfterTruckReturning(From, Event, To, Truck) end

---On after "RouteTruck" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Truck? AMMOTRUCK.data|number|string
function AMMOTRUCK:OnAfterRouteTruck(From, Event, To, Truck) end

---On after "TruckHome" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Truck? AMMOTRUCK.data|number|string
function AMMOTRUCK:OnAfterTruckHome(From, Event, To, Truck) end
