---@meta

---SQUADRON class.
---@class SQUADRON : COHORT
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field lid string Class id string for output to DCS log file.
---@field name string Name of the squadron.
---@field templatename string Name of the template group.
---@field aircrafttype string Type of the airframe the squadron is using.
---@field templategroup GROUP Template group.
---@field ngrouping number User defined number of units in the asset group.
---@field assets table Squadron assets.
---@field missiontypes table Capabilities (mission types and performances) of the squadron.
---@field fuellow number Low fuel threshold.
---@field fuellowRefuel boolean If `true`, flight tries to refuel at the nearest tanker.
---@field maintenancetime number Time in seconds needed for maintenance of a returned flight.
---@field repairtime number Time in seconds for each
---@field livery string Livery of the squadron.
---@field skill number Skill of squadron members.
---@field modex number Modex.
---@field modexcounter number Counter to incease modex number for assets.
---@field callsignName string Callsign name.
---@field callsigncounter number Counter to increase callsign names for new assets.
---@field Ngroups number Number of asset flight groups this squadron has.
---@field engageRange number Mission range in meters.
---@field attribute string Generalized attribute of the squadron template group.
---@field tankerSystem number For tanker squads, the refuel system used (boom=0 or probpe=1). Default nil.
---@field refuelSystem number For refuelable squads, the refuel system used (boom=0 or probe=1). Default nil.
---@field tacanChannel table List of TACAN channels available to the squadron.
---@field radioFreq number Radio frequency in MHz the squad uses.
---@field radioModu number Radio modulation the squad uses.
---@field takeoffType string Take of type.
---@field parkingIDs table Parking IDs for this squadron.
---@field despawnAfterLanding boolean Aircraft are despawned after landing.
---@field despawnAfterHolding boolean Aircraft are despawned after holding.
SQUADRON = {
  ClassName      = "SQUADRON",
  verbose        =     0,
  modex          =   nil,
  modexcounter   =     0,
  callsignName   =   nil,
  callsigncounter=    11,
  tankerSystem   =   nil,
  refuelSystem   =   nil,
}

---SQUADRON class version.
SQUADRON.version = "0.8.1"

---Create a new SQUADRON object and start the FSM.
---@param TemplateGroupName? string Name of the template group.
---@param Ngroups? number (Optional) Number of asset groups of this squadron. Default 3.
---@param SquadronName? string Name of the squadron, e.g. "VFA-37". Must be **unique**!
---@return SQUADRON # self
function SQUADRON:New(TemplateGroupName, Ngroups, SquadronName) end

---Set number of units in groups.
---@param nunits? number (Optional) Number of units. Must be >=1 and <=4. Default 2.
---@return SQUADRON # self
function SQUADRON:SetGrouping(nunits) end

---Set valid parking spot IDs. Assets of this squad are only allowed to be spawned at these parking spots. **Note** that the IDs are different from the ones displayed in the mission editor!
---@param ParkingIDs? table Table of parking ID numbers or a single `#number`.
---@return SQUADRON # self
function SQUADRON:SetParkingIDs(ParkingIDs) end

---Set takeoff type. All assets of this squadron will be spawned with cold (default) or hot engines.
---Spawning on runways is not supported.
---@param TakeoffType? string (Optional) Take off type: "Cold" (default) or "Hot" with engines on or "Air" for spawning in air.
---@return SQUADRON # self
function SQUADRON:SetTakeoffType(TakeoffType) end

---Set takeoff type cold (default). All assets of this squadron will be spawned with engines off (cold).
---@return SQUADRON # self
function SQUADRON:SetTakeoffCold() end

---Set takeoff type hot. All assets of this squadron will be spawned with engines on (hot).
---@return SQUADRON # self
function SQUADRON:SetTakeoffHot() end

---Set takeoff type air. All assets of this squadron will be spawned in air above the airbase.
---@return SQUADRON # self
function SQUADRON:SetTakeoffAir() end

---Set despawn after landing. Aircraft will be despawned after the landing event.
---Can help to avoid DCS AI taxiing issues.
---@param Switch? boolean (Optional) If `true` (default), activate despawn after landing.
---@return SQUADRON # self
function SQUADRON:SetDespawnAfterLanding(Switch) end

---Set despawn after holding. Aircraft will be despawned when they arrive at their holding position at the airbase.
---Can help to avoid DCS AI taxiing issues.
---@param Switch? boolean (Optional) If `true` (default), activate despawn after holding.
---@return SQUADRON # self
function SQUADRON:SetDespawnAfterHolding(Switch) end

---Set low fuel threshold.
---@param LowFuel? number (Optional) Low fuel threshold in percent. Default 25.
---@return SQUADRON # self
function SQUADRON:SetFuelLowThreshold(LowFuel) end

---Set if low fuel threshold is reached, flight tries to refuel at the neares tanker.
---@param switch? boolean If true or nil, flight goes for refuelling. If false, turn this off.
---@return SQUADRON # self
function SQUADRON:SetFuelLowRefuel(switch) end

---Set airwing.
---@param Airwing? AIRWING The airwing.
---@return SQUADRON # self
function SQUADRON:SetAirwing(Airwing) end

---Get airwing.
---@param Airwing? any
---@return AIRWING # The airwing.
function SQUADRON:GetAirwing(Airwing) end

---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SQUADRON:onafterStart(From, Event, To) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function SQUADRON:onafterStatus(From, Event, To) end
