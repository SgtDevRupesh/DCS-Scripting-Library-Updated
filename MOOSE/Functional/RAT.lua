---@meta

---@class RAT.AtcFlight
---@field destination string Name of the destination airbase.
---@field Tarrive number Time stamp when flight arrived at holding.
---@field holding number Holding time.
---@field Tonfinal number Time stamp when flight started final approach.

---@class RAT.AtcAirport
---@field queue table Queue.
---@field busy boolean Whether airport is busy.
---@field onfinal table List of flights on final.
---@field Nonfinal number Number of flights on final.
---@field traffic number Number of flights that landed (just for stats).
---@field Tlastclearance number Time stamp when last flight started final approach.

---@class RAT.RatCraft
---@field index number Spawn index.
---@field group Group The aircraft group.
---@field flightgroup FLIGHTGROUP The flight group.
---@field destination AIRBASE Destination of this group. Can also be a ZONE.
---@field departure AIRBASE Departure place of this group. Can also be a ZONE.
---@field waypoints table Waypoints.
---@field airborne boolean Whether this group is airborne.
---@field nunits number Number of units.
---@field Pnow COORDINATE Current position.
---@field Distance number Distance travelled in meters.
---@field takeoff number Takeoff type.
---@field landing number Laning type.
---@field wpdesc table Waypoint descriptins.
---@field wpstatus table Waypoint status.
---@field active boolean Whether the group is active or uncontrolled.
---@field status string Status of the group.
---@field livery string Livery of the group.
---@field despawnme boolean Despawn group if `true` in the next status update.
---@field nrespawn number Number of respawns.

---RAT class
---@class RAT : SPAWN
---@field ClassName string Name of the Class.
---@field lid string Log identifier.
---@field Debug boolean Turn debug messages on or off.
---@field templategroup GROUP Group serving as template for the RAT aircraft.
---@field alias string Alias for spawned group.
---@field spawninitialized boolean If RAT:Spawn() was already called this RAT object is set to true to prevent users to call it again.
---@field spawndelay number Delay time in seconds before first spawning happens.
---@field spawninterval number Interval between spawning units/groups. Note that we add a randomization of 50%.
---@field coalition number Coalition of spawn group template.
---@field country number Country of spawn group template.
---@field category string Category of aircarft: "plane" or "heli".
---@field groupsize number Number of aircraft in group.
---@field friendly string Possible departure/destination airport: all=blue+red+neutral, same=spawn+neutral, spawnonly=spawn, blue=blue+neutral, blueonly=blue, red=red+neutral, redonly=red.
---@field ctable table Table with the valid coalitions from choice self.friendly.
---@field aircraft table Table which holds the basic aircraft properties (speed, range, ...).
---@field Vcruisemax number Max cruise speed in m/s (250 m/s = 900 km/h = 486 kt) set by user.
---@field Vclimb number Default climb rate in ft/min.
---@field AlphaDescent number Default angle of descenti in degrees. A value of 3.6 follows the 3:1 rule of 3 miles of travel and 1000 ft descent.
---@field roe string ROE of spawned groups, default is weapon hold (this is a peaceful class for civil aircraft or ferry missions). Possible: "hold", "return", "free".
---@field rot string ROT of spawned groups, default is no reaction. Possible: "noreaction", "passive", "evade".
---@field takeoff number Takeoff type. 0=coldorhot.
---@field landing number Landing type. Determines if we actually land at an airport or treat it as zone.
---@field mindist number Min distance from departure to destination in meters. Default 5 km.
---@field maxdist number Max distance from departure to destination in meters. Default 5000 km.
---@field airports_map table All airports available on current map (Caucasus, Nevada, Normandy, ...).
---@field airports table All airports of friedly coalitions.
---@field random_departure boolean By default a random friendly airport is chosen as departure.
---@field random_destination boolean By default a random friendly airport is chosen as destination.
---@field departure_ports table Array containing the names of the destination airports or zones.
---@field destination_ports table Array containing the names of the destination airports or zones.
---@field Ndestination_Airports number Number of destination airports set via SetDestination().
---@field Ndestination_Zones number Number of destination zones set via SetDestination().
---@field Ndeparture_Airports number Number of departure airports set via SetDeparture().
---@field Ndeparture_Zones number Number of departure zones set via SetDeparture.
---@field excluded_ports table Array containing the names of explicitly excluded airports.
---@field destinationzone boolean Destination is a zone and not an airport.
---@field return_zones table Array containing the names of the return zones.
---@field returnzone boolean Zone where aircraft will fly to before returning to their departure airport.
---@field departure_Azone ZONE Zone containing the departure airports.
---@field destination_Azone ZONE Zone containing the destination airports.
---@field addfriendlydepartures boolean Add all friendly airports to departures.
---@field addfriendlydestinations boolean Add all friendly airports to destinations.
---@field ratcraft table Array with the spawned RAT aircraft.
---@field Tinactive number Time in seconds after which inactive units will be destroyed. Default is 300 seconds.
---@field reportstatus boolean Aircraft report status.
---@field statusinterval number Intervall between status checks (and reports if enabled).
---@field placemarkers boolean Place markers of waypoints on F10 map.
---@field FLcruise number Cruise altitude of aircraft. Default FL200 for planes and F005 for helos.
---@field FLuser number Flight level set by users explicitly.
---@field FLminuser number Minimum flight level set by user.
---@field FLmaxuser number Maximum flight level set by user.
---@field commute boolean Aircraft commute between departure and destination, i.e. when respawned the departure airport becomes the new destiation.
---@field starshape boolean If true, aircraft travel A-->B-->A-->C-->A-->D... for commute.
---@field homebase string Home base for commute and return zone. Aircraft will always return to this base but otherwise travel in a star shaped way.
---@field continuejourney boolean Aircraft will continue their journey, i.e. get respawned at their destination with a new random destination.
---@field ngroups number Number of groups to be spawned in total.
---@field alive number Number of groups which are alive.
---@field f10menu boolean If true, add an F10 radiomenu for RAT. Default is false.
---@field Menu table F10 menu items for this RAT object.
---@field SubMenuName string Submenu name for RAT object.
---@field respawn_at_landing boolean Respawn aircraft the moment they land rather than at engine shutdown.
---@field norespawn boolean Aircraft will not be respawned after they have finished their route.
---@field respawn_after_takeoff boolean Aircraft will be respawned directly after take-off.
---@field respawn_after_crash boolean Aircraft will be respawned after a crash, e.g. when they get shot down.
---@field respawn_inair boolean Aircraft are allowed to spawned in air if they cannot be respawned on ground because there is not free parking spot. Default is true.
---@field respawn_delay number Delay in seconds until a repawn happens.
---@field markerids table Array with marker IDs.
---@field waypointdescriptions table Table with strings for waypoint descriptions of markers.
---@field waypointstatus table Table with strings of waypoint status.
---@field livery string Livery of the aircraft set by user.
---@field skill string Skill of AI.
---@field ATCswitch boolean Enable/disable ATC if set to true/false.
---@field radio boolean If true/false disables radio messages from the RAT groups.
---@field frequency number Radio frequency used by the RAT groups.
---@field modulation string Ratio modulation. Either "FM" or "AM".
---@field uncontrolled boolean If true aircraft are spawned in uncontrolled state and will only sit on their parking spots. They can later be activated.
---@field invisible boolean If true aircraft are set to invisible for other AI forces.
---@field immortal boolean If true, aircraft are spawned as immortal.
---@field activate_uncontrolled boolean If true, uncontrolled are activated randomly after certain time intervals.
---@field activate_delay number Delay in seconds before first uncontrolled group is activated. Default is 5 seconds.
---@field activate_delta number Time interval in seconds between activation of uncontrolled groups. Default is 5 seconds.
---@field activate_frand number Randomization factor of time interval (activate_delta) between activating uncontrolled groups. Default is 0.
---@field activate_max number Maximum number of uncontrolled aircraft, which will be activated at the same time. Default is 1.
---@field onboardnum string Sets the onboard number prefix. Same as setting "TAIL #" in the mission editor.
---@field onboardnum0 number (Optional) Starting value of the automatically appended numbering of aircraft within a flight. Default is 1.
---@field checkonrunway boolean Aircraft are checked if they were accidentally spawned on the runway. Default is true.
---@field onrunwayradius number Distance (in meters) from a runway spawn point until a unit is considered to have accidentally been spawned on a runway. Default is 75 m.
---@field onrunwaymaxretry number Number of respawn retries (on ground) at other airports if a group gets accidentally spawned on the runway. Default is 3.
---@field checkontop boolean Aircraft are checked if they were accidentally spawned on top of another unit. Default is true.
---@field ontopradius number Radius in meters until which a unit is considered to be on top of another. Default is 2 m.
---@field termtype AIRBASE.TerminalType Type of terminal to be used when spawning at an airbase.
---@field parkingscanradius number Radius in meters until which parking spots are scanned for obstacles like other units, statics or scenery.
---@field parkingscanscenery boolean If true, area around parking spots is scanned for scenery objects. Default is false.
---@field parkingverysafe boolean If true, parking spots are considered as non-free until a possible aircraft has left and taken off. Default false.
---@field despawnair boolean If true, aircraft are despawned when they reach their destination zone. Default.
---@field eplrs boolean If true, turn on EPLSR datalink for the RAT group.
---@field NspawnMax number Max number of spawns.
RAT={
  ClassName = "RAT",        -- Name of class: RAT = Random Air Traffic.
  Debug=false,              -- Turn debug messages on or off.
  templategroup=nil,        -- Template group for the RAT aircraft.
  alias=nil,                -- Alias for spawned group.
  spawninitialized=false,   -- If RAT:Spawn() was already called this is set to true to prevent users to call it again.
  spawndelay=5,             -- Delay time in seconds before first spawning happens.
  spawninterval=5,          -- Interval between spawning units/groups. Note that we add a randomization of 50%.
  coalition = nil,          -- Coalition of spawn group template.
  country = nil,            -- Country of the group template.
  category = nil,           -- Category of aircarft: "plane" or "heli".
  groupsize=nil,            -- Number of aircraft in the group.
  friendly = "same",        -- Possible departure/destination airport: same=spawn+neutral, spawnonly=spawn, blue=blue+neutral, blueonly=blue, red=red+neutral, redonly=red, neutral.
  ctable = {},              -- Table with the valid coalitions from choice self.friendly.
  aircraft = {},            -- Table which holds the basic aircraft properties (speed, range, ...).
  Vcruisemax=nil,           -- Max cruise speed in set by user.
  Vclimb=1500,              -- Default climb rate in ft/min.
  AlphaDescent=3.6,         -- Default angle of descenti in degrees. A value of 3.6 follows the 3:1 rule of 3 miles of travel and 1000 ft descent.
  roe = "hold",             -- ROE of spawned groups, default is weapon hold (this is a peaceful class for civil aircraft or ferry missions). Possible: "hold", "return", "free".
  rot = "noreaction",       -- ROT of spawned groups, default is no reaction. Possible: "noreaction", "passive", "evade".
  takeoff = 0,              -- Takeoff type. 0=coldorhot.
  landing = 9,              -- Landing type. 9=landing.
  mindist = 5000,           -- Min distance from departure to destination in meters. Default 5 km.
  maxdist = 5000000,        -- Max distance from departure to destination in meters. Default 5000 km.
  airports_map={},          -- All airports available on current map (Caucasus, Nevada, Normandy, ...).
  airports={},              -- All airports of friedly coalitions.
  random_departure=true,    -- By default a random friendly airport is chosen as departure.
  random_destination=true,  -- By default a random friendly airport is chosen as destination.
  departure_ports={},       -- Array containing the names of the departure airports or zones.
  destination_ports={},     -- Array containing the names of the destination airports or zones.
  Ndestination_Airports=0,  -- Number of destination airports set via SetDestination().
  Ndestination_Zones=0,     -- Number of destination zones set via SetDestination().
  Ndeparture_Airports=0,    -- Number of departure airports set via SetDeparture().
  Ndeparture_Zones=0,       -- Number of departure zones set via SetDeparture.
  destinationzone=false,    -- Destination is a zone and not an airport.
  return_zones={},          -- Array containing the names of return zones.
  returnzone=false,         -- Aircraft will fly to a zone and back.
  excluded_ports={},        -- Array containing the names of explicitly excluded airports.
  departure_Azone=nil,      -- Zone containing the departure airports.
  destination_Azone=nil,    -- Zone containing the destination airports.
  addfriendlydepartures=false,   -- Add all friendly airports to departures.
  addfriendlydestinations=false, -- Add all friendly airports to destinations.
  ratcraft={},              -- Array with the spawned RAT aircraft.
  Tinactive=600,            -- Time in seconds after which inactive units will be destroyed. Default is 600 seconds.
  reportstatus=false,       -- Aircraft report status.
  statusinterval=30,        -- Intervall between status checks (and reports if enabled).
  placemarkers=false,       -- Place markers of waypoints on F10 map.
  FLcruise=nil,             -- Cruise altitude of aircraft. Default FL200 for planes and F005 for helos.
  FLminuser=nil,            -- Minimum flight level set by user.
  FLmaxuser=nil,            -- Maximum flight level set by user.
  FLuser=nil,               -- Flight level set by users explicitly.
  commute=false,            -- Aircraft commute between departure and destination, i.e. when respawned the departure airport becomes the new destiation.
  starshape=false,          -- If true, aircraft travel A-->B-->A-->C-->A-->D... for commute.
  homebase=nil,             -- Home base for commute.
  continuejourney=false,    -- Aircraft will continue their journey, i.e. get respawned at their destination with a new random destination.
  alive=0,                  -- Number of groups which are alive.
  ngroups=nil,              -- Number of groups to be spawned in total.
  f10menu=false,            -- Add an F10 menu for RAT.
  Menu={},                  -- F10 menu items for this RAT object.
  SubMenuName=nil,          -- Submenu name for RAT object.
  respawn_at_landing=false, -- Respawn aircraft the moment they land rather than at engine shutdown.
  norespawn=false,          -- Aircraft will not get respawned.
  respawn_after_takeoff=false, -- Aircraft will be respawned directly after takeoff.
  respawn_after_crash=true, -- Aircraft will be respawned after a crash.
  respawn_inair=true,        -- Aircraft are spawned in air if there is no free parking spot on the ground.
  respawn_delay=0,        -- Delay in seconds until repawn happens after landing.
  markerids={},             -- Array with marker IDs.
  waypointdescriptions={},  -- Array with descriptions for waypoint markers.
  waypointstatus={},        -- Array with status info on waypoints.
  livery=nil,               -- Livery of the aircraft.
  skill="High",             -- Skill of AI.
  ATCswitch=true,           -- Enable ATC.
  radio=nil,                -- If true/false disables radio messages from the RAT groups.
  frequency=nil,            -- Radio frequency used by the RAT groups.
  modulation=nil,           -- Ratio modulation. Either "FM" or "AM".
  actype=nil,               -- Aircraft type set by user. Changes the type of the template group.
  uncontrolled=false,       -- Spawn uncontrolled aircraft.
  invisible=false,          -- Spawn aircraft as invisible.
  immortal=false,           -- Spawn aircraft as indestructible.
  activate_uncontrolled=false, -- Activate uncontrolled aircraft (randomly).
  activate_delay=5,         -- Delay in seconds before first uncontrolled group is activated.
  activate_delta=5,         -- Time interval in seconds between activation of uncontrolled groups.
  activate_frand=0,         -- Randomization factor of time interval (activate_delta) between activating uncontrolled groups.
  activate_max=1,           -- Max number of uncontrolle aircraft, which will be activated at a time.
  onboardnum=nil,           -- Tail number.
  onboardnum0=1,            -- (Optional) Starting value of the automatically appended numbering of aircraft within a flight. Default is one.
  checkonrunway=true,       -- Check whether aircraft have been spawned on the runway.
  onrunwayradius=75,        -- Distance from a runway spawn point until a unit is considered to have accidentally been spawned on a runway.
  onrunwaymaxretry=3,       -- Number of respawn retries (on ground) at other airports if a group gets accidentally spawned on the runway.
  checkontop=false,         -- Check whether aircraft have been spawned on top of another unit.
  ontopradius=2,            -- Radius in meters until which a unit is considered to be on top of another.
  termtype=nil,             -- Terminal type.
  parkingscanradius=40,     -- Scan radius.
  parkingscanscenery=false, -- Scan parking spots for scenery obstacles.
  parkingverysafe=false,    -- Very safe option.
  despawnair=true,
  eplrs=false,
}

---Categories of the RAT class.
---@class RAT.cat
---@field plane string Plane.
---@field heli string Heli.
RAT.cat={
  plane="plane",
  heli="heli",
}

---RAT waypoint type.
---@class RAT.wp
RAT.wp={
  coldorhot=0,
  air=1,
  runway=2,
  hot=3,
  cold=4,
  climb=5,
  cruise=6,
  descent=7,
  holding=8,
  landing=9,
  finalwp=10,
}

---RAT aircraft status.
---@class RAT.status
RAT.status={
  Departure="At departure point",
  Climb="Climbing",
  Cruise="Cruising",
  Uturn="Flying back home",
  Descent="Descending",
  DescentHolding="Descend to holding point",
  Holding="Holding",
  Destination="Arrived at destination",
  Uncontrolled="Uncontrolled",
  Spawned="Spawned",
  EventBirthAir="Born in air",
  EventBirth="Ready and starting engines",
  EventEngineStartAir="On journey", -- Started engines (in air)
  EventEngineStart="Started engines and taxiing",
  EventTakeoff="Airborne after take-off",
  EventLand="Landed and taxiing",
  EventEngineShutdown="Engines off",
  EventDead="Dead",
  EventCrash="Crashed",
}

---RAT friendly coalitions.
---@class RAT.coal
RAT.coal={
  same="same",
  sameonly="sameonly",
  neutral="neutral",
}

---RAT unit conversions.
---@class RAT.unit
RAT.unit={
  ft2meter=0.305,
  kmh2ms=0.278,
  FL2m=30.48,
  nm2km=1.852,
  nm2m=1852,
}

---RAT rules of engagement.
---@class RAT.ROE
RAT.ROE={
  weaponhold="hold",
  weaponfree="free",
  returnfire="return",
}

---RAT reaction to threat.
---@class RAT.ROT
RAT.ROT={
  evade="evade",
  passive="passive",
  noreaction="noreaction",
}

---RAT ATC.
---@class RAT.ATC
---@field init boolean True if ATC was initialized.
---@field flight table List of flights.
---@field airport table List of airports.
---@field unregistered number Enumerator for unregistered flights unregistered=-1.
---@field Nclearance number Number of flights that get landing clearance simultaniously. Default 2.
---@field delay number Delay between landing flights in seconds. Default 240 sec.
---@field messages boolean If `true`, ATC sends messages.
---@field T0 number Time stamp [sec, timer.getTime()] when ATC was initialized.
---@field onfinal number Enumerator onfinal=100.
RAT.ATC={
  init=false,
  flight={},
  airport={},
  unregistered=-1,
  onfinal=-100,
  Nclearance=2,
  delay=240,
  messages=true,
}

---Running number of placed markers on the F10 map.
RAT.markerid = 0

---Some ID to identify who we are in output of the DCS.log file.
RAT.id = "RAT | "

---RAT version.
RAT.version={
  version = "3.0.0",
  print = true,
}

---Create a new RAT object.
---@param groupname? string Name of the group as defined in the mission editor. This group is serving as a template for all spawned units.
---@param alias? string (Optional) Alias of the group. This is and optional parameter but must(!) be used if the same template group is used for more than one RAT object.
---@return RAT # Object of RAT class or nil if the group does not exist in the mission editor.
function RAT:New(groupname, alias) end

---Stop RAT spawning by unhandling events, stoping schedulers etc.
---@param delay? number Delay before stop in seconds.
function RAT:Stop(delay) end

---Triggers the spawning of AI aircraft. Note that all additional options should be set before giving the spawn command.
---@param naircraft? number (Optional) Number of aircraft to spawn. Default is one aircraft.
---@return boolean # True if spawning was successful or nil if nothing was spawned.
function RAT:Spawn(naircraft) end

---Function checks consistency of user input and automatically adjusts parameters if necessary.
function RAT:_CheckConsistency() end

---Set the friendly coalitions from which the airports can be used as departure and destination.
---@param friendly? string (Optional) "same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
---@return RAT # RAT self object.
function RAT:SetCoalition(friendly) end

---Set coalition of RAT group. You can make red templates blue and vice versa.
---Note that a country is also set automatically if it has not done before via RAT:SetCountry.
---
---* For blue, the country is set to USA.
---* For red, the country is set to RUSSIA.
---* For neutral, the country is set to SWITZERLAND.
---
---This is important, since it is ultimately the COUNTRY that determines the coalition of the aircraft.
---You can set the country explicitly via the RAT:SetCountry() function if necessary.
---@param color? string Color of coalition, i.e. "red" or blue" or "neutral".
---@return RAT # RAT self object.
function RAT:SetCoalitionAircraft(color) end

---Set country of RAT group.
---See [DCS_enum_country](https://wiki.hoggitworld.com/view/DCS_enum_country).
---
---This overrules the coalition settings. So if you want your group to be of a specific coalition, you have to set a country that is part of that coalition.
---@param id? country.id|number|string DCS country enumerator ID. For example country.id.USA or country.id.RUSSIA.
---@return RAT # RAT self object.
function RAT:SetCountry(id) end

---Set the terminal type the aircraft use when spawning at an airbase. See [DCS_func_getParking](https://wiki.hoggitworld.com/view/DCS_func_getParking).
---Note that some additional terminal types have been introduced. Check {Wrapper.Airbase#AIRBASE} class for details.
---Also note that only airports which have this kind of terminal are possible departures and/or destinations.
---@param termtype? AIRBASE.TerminalType|number|string Type of terminal. Use enumerator AIRBASE.TerminalType.XXX.
---@return RAT # RAT self object.
function RAT:SetTerminalType(termtype) end

---Set the scan radius around parking spots. Parking spot is considered to be occupied if any obstacle is found with the radius.
---@param radius? number (Optional) Radius in meters. Default 50 m.
---@return RAT # RAT self object.
function RAT:SetParkingScanRadius(radius) end

---Enables scanning for scenery objects around parking spots which might block the spot.
---@return RAT # RAT self object.
function RAT:SetParkingScanSceneryON() end

---Disables scanning for scenery objects around parking spots which might block the spot. This is also the default setting.
---@return RAT # RAT self object.
function RAT:SetParkingScanSceneryOFF() end

---A parking spot is not free until a possible aircraft has left and taken off.
---@return RAT # RAT self object.
function RAT:SetParkingSpotSafeON() end

---A parking spot is free as soon as possible aircraft has left the place. This is the default.
---@return RAT # RAT self object.
function RAT:SetParkingSpotSafeOFF() end

---Aircraft that reach their destination zone are not despawned. They will probably go the the nearest airbase and try to land.
---@return RAT # RAT self object.
function RAT:SetDespawnAirOFF() end

---Set takeoff type. Starting cold at airport, starting hot at airport, starting at runway, starting in the air.
---Default is "takeoff-coldorhot". So there is a 50% chance that the aircraft starts with cold engines and 50% that it starts with hot engines.
---@param type? string Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
---@return RAT # RAT self object.
function RAT:SetTakeoff(type) end

---Set takeoff type cold. Aircraft will spawn at a parking spot with engines off.
---@return RAT # RAT self object.
function RAT:SetTakeoffCold() end

---Set takeoff type to hot. Aircraft will spawn at a parking spot with engines on.
---@return RAT # RAT self object.
function RAT:SetTakeoffHot() end

---Set takeoff type to runway. Aircraft will spawn directly on the runway.
---@return RAT # RAT self object.
function RAT:SetTakeoffRunway() end

---Set takeoff type to cold or hot. Aircraft will spawn at a parking spot with 50:50 change of engines on or off.
---@return RAT # RAT self object.
function RAT:SetTakeoffColdOrHot() end

---Set takeoff type to air. Aircraft will spawn in the air.
---@return RAT # RAT self object.
function RAT:SetTakeoffAir() end

---Set possible departure ports. This can be an airport or a zone.
---@param departurenames? string Name or table of names of departure airports or zones.
---@return RAT # RAT self object.
function RAT:SetDeparture(departurenames) end

---Set name of destination airports or zones for the AI aircraft.
---@param destinationnames? string Name of the destination airport or #table of destination airports.
---@return RAT # RAT self object.
function RAT:SetDestination(destinationnames) end

---Destinations are treated as zones. Aircraft will not land but rather be despawned when they reach a random point in the zone.
---@return RAT # RAT self object.
function RAT:DestinationZone() end

---Aircraft will fly to a random point within a zone and then return to its departure airport or zone.
---@return RAT # RAT self object.
function RAT:ReturnZone() end

---Include all airports which lie in a zone as possible destinations.
---@param zone? ZONE Zone in which the destination airports lie. Has to be a MOOSE zone.
---@return RAT # RAT self object.
function RAT:SetDestinationsFromZone(zone) end

---Include all airports which lie in a zone as possible destinations.
---@param zone? ZONE Zone in which the departure airports lie. Has to be a MOOSE zone.
---@return RAT # RAT self object.
function RAT:SetDeparturesFromZone(zone) end

---Add all friendly airports to the list of possible departures.
---@return RAT # RAT self object.
function RAT:AddFriendlyAirportsToDepartures() end

---Add all friendly airports to the list of possible destinations
---@return RAT # RAT self object.
function RAT:AddFriendlyAirportsToDestinations() end

---Airports, FARPs and ships explicitly excluded as departures and destinations.
---@param ports? string Name or table of names of excluded airports.
---@return RAT # RAT self object.
function RAT:ExcludedAirports(ports) end

---Set skill of AI aircraft. Default is "High".
---@param skill? string Skill, options are "Average", "Good", "High", "Excellent" and "Random". Parameter is case insensitive.
---@return RAT # RAT self object.
function RAT:SetAISkill(skill) end

---Set livery of aircraft. If more than one livery is specified in a table, the actually used one is chosen randomly from the selection.
---@param skins? table Name of livery or table of names of liveries.
---@return RAT # RAT self object.
function RAT:Livery(skins) end

---Change aircraft type. This is a dirty hack which allows to change the aircraft type of the template group.
---Note that all parameters like cruise speed, climb rate, range etc are still taken from the template group which likely leads to strange behaviour.
---@param actype? string Type of aircraft which is spawned independent of the template group. Use with care and expect problems!
---@return RAT # RAT self object.
function RAT:ChangeAircraft(actype) end

---Aircraft will continue their journey from their destination. This means they are respawned at their destination and get a new random destination.
---@return RAT # RAT self object.
function RAT:ContinueJourney() end

---Aircraft will commute between their departure and destination airports or zones.
---@param starshape? boolean If true, keep homebase, i.e. travel A-->B-->A-->C-->A-->D... instead of A-->B-->A-->B-->A...
---@return RAT # RAT self object.
function RAT:Commute(starshape) end

---Set the delay before first group is spawned.
---@param delay? number (Optional) Delay in seconds. Default is 5 seconds. Minimum delay is 0.5 seconds.
---@return RAT # RAT self object.
function RAT:SetSpawnDelay(delay) end

---Set the interval between spawnings of the template group.
---@param interval? number (Optional) Interval in seconds. Default is 5 seconds. Minimum is 0.5 seconds.
---@return RAT # RAT self object.
function RAT:SetSpawnInterval(interval) end

---Set max number of groups that will be spawned. When this limit is reached, no more RAT groups are spawned.
---@param Nmax? number (Optional) Max number of groups. Default `nil`=unlimited.
---@return RAT # RAT self object.
function RAT:SetSpawnLimit(Nmax) end

---Make aircraft respawn the moment they land rather than at engine shut down.
---@param delay? number (Optional) Delay in seconds until respawn happens after landing. Default is 1 second. Minimum is 1 second.
---@return RAT # RAT self object.
function RAT:RespawnAfterLanding(delay) end

---Sets the delay between despawning and respawning aircraft.
---@param delay? number (Optional) Delay in seconds until respawn happens. Default is 1 second. Minimum is 1 second.
---@return RAT # RAT self object.
function RAT:SetRespawnDelay(delay) end

---Aircraft will not get respawned when they finished their route.
---@return RAT # RAT self object.
function RAT:NoRespawn() end

---Number of tries to respawn an aircraft in case it has accidentally been spawned on runway.
---@param n? number (Optional) Number of retries. Default is 3.
---@return RAT # RAT self object.
function RAT:SetMaxRespawnTriedWhenSpawnedOnRunway(n) end

---A new aircraft is spawned directly after the last one took off. This creates a lot of outbound traffic. Aircraft are not respawned after they reached their destination.
---Therefore, this option is not to be used with the "commute" or "continue journey" options.
---@return RAT # RAT self object.
function RAT:RespawnAfterTakeoff() end

---Aircraft will be respawned after they crashed or get shot down. This is the default behavior.
---@return RAT # RAT self object.
function RAT:RespawnAfterCrashON() end

---Aircraft will not be respawned after they crashed or get shot down.
---@return RAT # RAT self object.
function RAT:RespawnAfterCrashOFF() end

---If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport. Note that this is also the default behavior.
---@return RAT # RAT self object.
function RAT:RespawnInAirAllowed() end

---If aircraft cannot be spawned on parking spots, it is NOT allowed to spawn them in air. This has only impact if aircraft are supposed to be spawned on the ground (and not in a zone).
---@return RAT # RAT self object.
function RAT:RespawnInAirNotAllowed() end

---Check if aircraft have accidentally been spawned on the runway. If so they will be removed immediately.
---@param switch? boolean If true, check is performed. If false, this check is omitted.
---@param distance? any
---@return RAT # RAT self object.
function RAT:CheckOnRunway(switch, distance) end

---Check if aircraft have accidentally been spawned on top of each other. If yes, they will be removed immediately.
---@param switch? boolean If true, check is performed. If false, this check is omitted.
---@param radius? number (Optional) Radius in meters until which a unit is considered to be on top of each other. Default is 2 m.
---@return RAT # RAT self object.
function RAT:CheckOnTop(switch, radius) end

---Enable Radio. Overrules the ME setting.
---@return RAT # RAT self object.
function RAT:RadioON() end

---Disable Radio. Overrules the ME setting.
---@return RAT # RAT self object.
function RAT:RadioOFF() end

---Set radio frequency.
---@param frequency? number Radio frequency.
---@return RAT # RAT self object.
function RAT:RadioFrequency(frequency) end

---Set radio modulation. Default is AM.
---@param modulation? string Either "FM" or "AM". If no value is given, modulation is set to AM.
---@return RAT # RAT self object.
function RAT:RadioModulation(modulation) end

---Radio menu On. Default is off.
---@return RAT # RAT self object.
function RAT:RadioMenuON() end

---Radio menu Off. This is the default setting.
---@return RAT # RAT self object.
function RAT:RadioMenuOFF() end

---Aircraft are invisible.
---@return RAT # RAT self object.
function RAT:Invisible() end

---Turn EPLRS datalink on/off.
---@param switch? boolean If true (or nil), turn EPLRS on.
---@return RAT # RAT self object.
function RAT:SetEPLRS(switch) end

---Aircraft are immortal.
---@return RAT # RAT self object.
function RAT:Immortal() end

---Spawn aircraft in uncontrolled state. Aircraft will only sit at their parking spots. They can be activated randomly by the RAT:ActivateUncontrolled() function.
---@return RAT # RAT self object.
function RAT:Uncontrolled() end

---Define how aircraft that are spawned in uncontrolled state are activate.
---@param maxactivated? number (Optional) Maximal numnber of activated aircraft. Absolute maximum will be the number of spawned groups. Default is 1.
---@param delay? number (Optional) Time delay in seconds before (first) aircraft is activated. Default is 1 second.
---@param delta? number (Optional) Time difference in seconds before next aircraft is activated. Default is 1 second.
---@param frand? number (Optional) Factor [0,...,1] for randomization of time difference between aircraft activations. Default is 0, i.e. no randomization.
---@return RAT # RAT self object.
function RAT:ActivateUncontrolled(maxactivated, delay, delta, frand) end

---Set the time after which inactive groups will be destroyed.
---@param time? number (Optional) Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
---@return RAT # RAT self object.
function RAT:TimeDestroyInactive(time) end

---Set the maximum cruise speed of the aircraft.
---@param speed? number Speed in km/h.
---@return RAT # RAT self object.
function RAT:SetMaxCruiseSpeed(speed) end

---Set the minimum cruise speed of the aircraft.
---@param speed? number Speed in km/h.
---@return RAT # RAT self object.
function RAT:SetMinCruiseSpeed(speed) end

---Set the climb rate. This automatically sets the climb angle.
---@param rate? number (Optional) Climb rate in ft/min. Default is 1500 ft/min. Minimum is 100 ft/min. Maximum is 15,000 ft/min.
---@return RAT # RAT self object.
function RAT:SetClimbRate(rate) end

---Set the angle of descent. Default is 3.6 degrees, which corresponds to 3000 ft descent after one mile of travel.
---@param angle? number Angle of descent in degrees. Minimum is 0.5 deg. Maximum 50 deg.
---@return RAT # RAT self object.
function RAT:SetDescentAngle(angle) end

---Set rules of engagement (ROE). Default is weapon hold. This is a peaceful class.
---@param roe? string "hold" = weapon hold, "return" = return fire, "free" = weapons free.
---@return RAT # RAT self object.
function RAT:SetROE(roe) end

---Set reaction to threat (ROT). Default is no reaction, i.e. aircraft will simply ignore all enemies.
---@param rot? string "noreaction" = no reaction to threats, "passive" = passive defence, "evade" = evade enemy attacks.
---@return RAT # RAT self object.
function RAT:SetROT(rot) end

---Set the name of the F10 submenu. Default is the name of the template group.
---@param name? string Submenu name.
---@return RAT # RAT self object.
function RAT:MenuName(name) end

---Enable ATC, which manages the landing queue for RAT aircraft if they arrive simultaniously at the same airport.
---@param switch? boolean Enable ATC (true) or Disable ATC (false). No argument means ATC enabled.
---@return RAT # RAT self object.
function RAT:EnableATC(switch) end

---Turn messages from ATC on or off. Default is on. This setting effects all RAT objects and groups!
---@param switch? boolean Enable (true) or disable (false) messages from ATC.
---@return RAT # RAT self object.
function RAT:ATC_Messages(switch) end

---Max number of planes that get landing clearance of the RAT ATC. This setting effects all RAT objects and groups!
---@param n? number (Optional) Number of aircraft that are allowed to land simultaniously. Default is 2.
---@return RAT # RAT self object.
function RAT:ATC_Clearance(n) end

---Delay between granting landing clearance for simultanious landings. This setting effects all RAT objects and groups!
---@param time? number (Optional) Delay time when the next aircraft will get landing clearance event if the previous one did not land yet. Default is 240 sec.
---@return RAT # RAT self object.
function RAT:ATC_Delay(time) end

---Set minimum distance between departure and destination. Default is 5 km.
---Minimum distance should not be smaller than maybe ~100 meters to ensure that departure and destination are different.
---@param dist? number Distance in km.
---@return RAT # RAT self object.
function RAT:SetMinDistance(dist) end

---Set maximum distance between departure and destination. Default is 5000 km but aircarft range is also taken into account automatically.
---@param dist? number Distance in km.
---@return RAT # RAT self object.
function RAT:SetMaxDistance(dist) end

---Turn debug messages on or off. Default is off.
---@param switch? boolean Turn debug on=true or off=false. No argument means on.
---@return RAT # RAT self object.
function RAT:_Debug(switch) end

---Enable debug mode. More output in dcs.log file and onscreen messages to all.
---@return RAT # RAT self object.
function RAT:Debugmode() end

---Aircraft report status update messages along the route.
---@param switch? boolean Swtich reports on (true) or off (false). No argument is on.
---@return RAT # RAT self object.
function RAT:StatusReports(switch) end

---Place markers of waypoints on the F10 map. Default is off.
---@param switch? boolean true=yes, false=no.
---@return RAT # RAT self object.
function RAT:PlaceMarkers(switch) end

---Set flight level. Setting this value will overrule all other logic. Aircraft will try to fly at this height regardless.
---@param FL? number Fight Level in hundrets of feet. E.g. FL200 = 20000 ft ASL.
---@return RAT # RAT self object.
function RAT:SetFL(FL) end

---Set max flight level. Setting this value will overrule all other logic. Aircraft will try to fly at less than this FL regardless.
---@param FL? number Maximum Fight Level in hundrets of feet.
---@return RAT # RAT self object.
function RAT:SetFLmax(FL) end

---Set max cruising altitude above sea level.
---@param alt? number Altitude ASL in meters.
---@return RAT # RAT self object.
function RAT:SetMaxCruiseAltitude(alt) end

---Set min flight level. Setting this value will overrule all other logic. Aircraft will try to fly at higher than this FL regardless.
---@param FL? number Maximum Fight Level in hundrets of feet.
---@return RAT # RAT self object.
function RAT:SetFLmin(FL) end

---Set min cruising altitude above sea level.
---@param alt? number Altitude ASL in meters.
---@return RAT # RAT self object.
function RAT:SetMinCruiseAltitude(alt) end

---Set flight level of cruising part. This is still be checked for consitancy with selected route and prone to radomization.
---Default is FL200 for planes and FL005 for helicopters.
---@param FL? number Flight level in hundrets of feet. E.g. FL200 = 20000 ft ASL.
---@return RAT # RAT self object.
function RAT:SetFLcruise(FL) end

---Set cruising altitude. This is still be checked for consitancy with selected route and prone to radomization.
---@param alt? number Cruising altitude ASL in meters.
---@return RAT # RAT self object.
function RAT:SetCruiseAltitude(alt) end

---Set onboard number prefix. Same as setting "TAIL #" in the mission editor. Note that if you dont use this function, the values defined in the template group of the ME are taken.
---@param tailnumprefix? string String of the tail number prefix. If flight consists of more than one aircraft, two digits are appended automatically, i.e. <tailnumprefix>001, <tailnumprefix>002, ...
---@param zero? number (Optional) Starting value of the automatically appended numbering of aircraft within a flight. Default is 0.
---@return RAT # RAT self object.
function RAT:SetOnboardNum(tailnumprefix, zero) end

---Initialize basic parameters of the aircraft based on its (template) group in the mission editor.
---@param DCSgroup? Group Group of the aircraft in the mission editor.
function RAT:_InitAircraft(DCSgroup) end

---Spawn the AI aircraft with a route.
---Sets the departure and destination airports and waypoints.
---Modifies the spawn template.
---Sets ROE/ROT.
---Initializes the ratcraft array and group menu.
---@param _departure? string (Optional) Name of departure airbase.
---@param _destination? string (Optional) Name of destination airbase.
---@param _takeoff? number Takeoff type id.
---@param _landing? number Landing type id.
---@param _livery? string Livery to use for this group.
---@param _waypoint? table First waypoint to be used (for continue journey, commute, etc).
---@param _lastpos? COORDINATE (Optional) Position where the aircraft will be spawned.
---@param _nrespawn? number Number of already performed respawn attempts (e.g. spawning on runway bug).
---@param parkingdata? table Explicitly specify the parking spots when spawning at an airport.
---@return number # Spawn index.
function RAT:_SpawnWithRoute(_departure, _destination, _takeoff, _landing, _livery, _waypoint, _lastpos, _nrespawn, parkingdata) end

---Check if a given airbase has a FLIGHTCONTROL.
---@param airbase? AIRBASE The airbase.
---@return boolean # `true` if the airbase has a FLIGHTCONTROL.
function RAT:_IsFlightControlAirbase(airbase) end

---Clear flight for landing. Sets tigger value to 1.
---@param name? string Name of flight to be cleared for landing.
function RAT:ClearForLanding(name) end

---Despawn the original group and re-spawn a new one.
---@param group? GROUP The group that should be respawned.
---@param lastpos? COORDINATE Last known position of the group.
---@param delay? number Delay before despawn in seconds.
function RAT:_Respawn(group, lastpos, delay) end

---Despawn group. The `FLIGHTGROUP` is despawned and stopped. The ratcraft is removed from the self.ratcraft table. Menues are removed.
---@param group? GROUP Group to be despawned.
---@param delay? number (Optional) Delay in seconds before the despawn happens. Default is immidiately.
function RAT:_Despawn(group, delay) end

---Set the route of the AI plane. Due to DCS landing bug, this has to be done before the unit is spawned.
---@param takeoff? number Takeoff type. Could also be air start.
---@param landing? number Landing type. Could also be a destination in air.
---@param _departure? AIRBASE (Optional) Departure airbase.
---@param _destination? AIRBASE (Optional) Destination airbase.
---@param _waypoint? table Initial waypoint.
---@return AIRBASE # Departure airbase.
---@return AIRBASE # Destination airbase.
---@return table # Table of flight plan waypoints.
---@return table # Table of waypoint descriptions.
---@return table # Table of waypoint status.
function RAT:_SetRoute(takeoff, landing, _departure, _destination, _waypoint) end

---Set the departure airport of the AI. If no airport name is given explicitly an airport from the coalition is chosen randomly.
---If takeoff style is set to "air", we use zones around the airports or the zones specified by user input.
---@param takeoff? number Takeoff type.
---@return AIRBASE # Departure airport if spawning at airport.
---@return ZONE # Departure zone if spawning in air.
function RAT:_PickDeparture(takeoff) end

---Pick destination airport or zone depending on departure position.
---@param departure? AIRBASE Departure airport or zone.
---@param q? COORDINATE Coordinate of the departure point.
---@param minrange? number Minimum range to q in meters.
---@param maxrange? number Maximum range to q in meters.
---@param random? boolean Destination is randomly selected from friendly airport (true) or from destinations specified by user input (false).
---@param landing? number Number indicating whether we land at a destination airport or fly to a zone object.
---@return AIRBASE # destination Destination airport or zone.
function RAT:_PickDestination(departure, q, minrange, maxrange, random, landing) end

---Find airports within a zone.
---@param zone? ZONE
---@return table # Table with airport names that lie within the zone.
function RAT:_GetAirportsInZone(zone) end

---Check if airport is excluded from possible departures and destinations.
---@param port? string Name of airport, FARP or ship to check.
---@return boolean # true if airport is excluded and false otherwise.
function RAT:_Excluded(port) end

---Check if airport is friendly, i.e. belongs to the right coalition.
---@param port? string Name of airport, FARP or ship to check.
---@return boolean # true if airport is friendly and false otherwise.
function RAT:_IsFriendly(port) end

---Get all airports of the current map.
function RAT:_GetAirportsOfMap() end

---Get all "friendly" airports of the current map. Fills the self.airports{} table.
function RAT:_GetAirportsOfCoalition() end

---Report status of RAT groups.
---@param message? boolean (Optional) Send message with report to all if true.
---@param forID? number (Optional) Send message only for this ID.
function RAT:Status(message, forID) end

---Remove ratcraft from self.ratcraft table.
---@param ratcraft? RAT.RatCraft|number|string The ratcraft to be removed.
---@return RAT # self
function RAT:_RemoveRatcraft(ratcraft) end

---Get ratcraft from group.
---@param group? Group The group object.
---@return RAT.RatCraft # The ratcraft object.
function RAT:_GetRatcraftFromGroup(group) end

---Get (relative) life of first unit of a group.
---@param group? GROUP Group of unit.
---@return number # Life of unit in percent.
function RAT:_GetLife(group) end

---Set status of group.
---@param group? GROUP Group.
---@param status? string Status of group.
function RAT:_SetStatus(group, status) end

---Get RatCraft from a given group.
---@param group? GROUP Group.
---@return RAT.RatCraft # Rat craft object.
function RAT:_GetRatcraftFromGroup(group) end

---Get status of group.
---@param group? GROUP Group.
---@return string # status Status of group.
function RAT:GetStatus(group) end

---Function is executed when a unit is spawned.
---@param EventData? EVENTDATA
function RAT:_OnBirth(EventData) end

---Function is executed when a unit starts its engines.
---@param EventData? EVENTDATA
function RAT:_OnEngineStartup(EventData) end

---Function is executed when a unit takes off.
---@param EventData? EVENTDATA
function RAT:_OnTakeoff(EventData) end

---Function is executed when a unit lands.
---@param EventData? EVENTDATA
function RAT:_OnLand(EventData) end

---Function is executed when a unit shuts down its engines.
---@param EventData? EVENTDATA
function RAT:_OnEngineShutdown(EventData) end

---Function is executed when a unit is hit.
---@param EventData? EVENTDATA
function RAT:_OnHit(EventData) end

---Function is executed when a unit is dead or crashes.
---@param EventData? EVENTDATA
function RAT:_OnDeadOrCrash(EventData) end

---Function is executed when a unit is dead.
---@param EventData? EVENTDATA
function RAT:_OnDead(EventData) end

---Function is executed when a unit crashes.
---@param EventData? EVENTDATA
function RAT:_OnCrash(EventData) end

---Create a waypoint that can be used with the Route command.
---@param index? number Running index of waypoints. Starts with 1 which is normally departure/spawn waypoint.
---@param description? string Descrition of Waypoint.
---@param Type? number Type of waypoint.
---@param Coord? COORDINATE 3D coordinate of the waypoint.
---@param Speed? number Speed in m/s.
---@param Altitude? number Altitude in m.
---@param Airport? AIRBASE Airport of object to spawn.
---@return table # Waypoints for DCS task route or spawn template.
function RAT:_Waypoint(index, description, Type, Coord, Speed, Altitude, Airport) end

---Provide information about the assigned flightplan.
---@param waypoints? table Waypoints of the flight plan.
---@param comment? string Some comment to identify the provided information.
---@param waypointdescriptions? table Waypoint descriptions.
---@return number # total Total route length in meters.
function RAT:_Routeinfo(waypoints, comment, waypointdescriptions) end

---Anticipated group name from alias and spawn index.
---@param index? number (Optional) Spawnindex of group if given or self.SpawnIndex+1 by default.
---@return string # Name the group will get after it is spawned.
function RAT:_AnticipatedGroupName(index) end

---Randomly activates an uncontrolled aircraft.
function RAT:_ActivateUncontrolled() end

---Set RAT group to (in-)visible for other AI forces.
---@param group? GROUP Group to be set (in)visible.
---@param switch? boolean If true, the group is invisible. If false the group will be visible.
function RAT:_CommandInvisible(group, switch) end

---Set RAT group to be (im-)mortal.
---@param group? GROUP Group to be set (im-)mortal.
---@param switch? boolean True enables immortality, false disables it.
function RAT:_CommandImmortal(group, switch) end

---Get aircraft dimensions length, width, height.
---@param unit? UNIT The unit which is we want the size of.
---@return number # Size, i.e. max(length,width) of unit.
function RAT:_GetObjectSize(unit) end

---Find aircraft that have accidentally been spawned on top of each other.
---@param group? GROUP Units of this group will be checked.
---@param distmin? number Allowed distance in meters between units. Units with a distance smaller than this number are considered to be on top of each other.
---@return boolean # True if group was destroyed because it was on top of another unit. False if otherwise.
function RAT:_CheckOnTop(group, distmin) end

---Calculate minimum distance between departure and destination for given minimum flight level and climb/decent rates.
---@param alpha? number Angle of climb [rad].
---@param beta? number Angle of descent [rad].
---@param ha? number Height difference between departure and cruise altiude.
---@param hb? number Height difference between cruise altitude and destination.
---@return number # d1 Minimum distance for climb phase to reach cruise altitude.
---@return number # d2 Minimum distance for descent phase to reach destination height.
---@return number # dtot Minimum total distance to climb and descent.
function RAT:_MinDistance(alpha, beta, ha, hb) end

---Add names of all friendly airports to possible departure or destination airports if they are not already in the list.
---@param ports? table List of departure or destination airports/zones that will be added.
function RAT:_AddFriendlyAirports(ports) end

---Check if a name/string is in a list or not.
---@param liste? table List of names to be checked.
---@param name? string Name to be checked for.
function RAT:_NameInList(liste, name) end

---Get destination airbase of a given ratcraft.
---@param ratcraft? RAT.RatCraft|number|string Ratcraft object.
---@return AIRBASE # Destination airbase or nil.
function RAT:_GetDestinationAirbase(ratcraft) end

---Get departure airbase of a given ratcraft.
---@param ratcraft? RAT.RatCraft|number|string Ratcraft object.
---@return AIRBASE # Destination airbase or nil.
function RAT:_GetDepartureAirbase(ratcraft) end

---Test if an airport exists on the current map.
---@param name? string
---@return boolean # True if airport exsits, false otherwise.
function RAT:_AirportExists(name) end

---Test if a zone exists.
---@param name? string
---@return boolean # True if zone exsits, false otherwise.
function RAT:_ZoneExists(name) end

---Set ROE for a group.
---@param flightgroup? FLIGHTGROUP Group for which the ROE is set.
---@param roe? string ROE of group.
function RAT:_SetROE(flightgroup, roe) end

---Set ROT for a group.
---@param flightgroup? FLIGHTGROUP Group for which the ROT is set.
---@param rot? string ROT of group.
function RAT:_SetROT(flightgroup, rot) end

---Create a table with the valid coalitions for departure and destination airports.
function RAT:_SetCoalitionTable() end

---Determine the heading from point a to point b.
---@param a? COORDINATE Point from.
---@param b? COORDINATE Point to.
---@return number # Heading/angle in degrees.
function RAT:_Course(a, b) end

---Determine the heading for an aircraft to be entered in the route template.
---@param course? number The course between two points in degrees.
---@return number # heading Heading in rad.
function RAT:_Heading(course) end

---Randomize a value by a certain amount.
---@param value? number The value which should be randomized
---@param fac? number Randomization factor.
---@param lower? number (Optional) Lower limit of the returned value.
---@param upper? number (Optional) Upper limit of the returned value.
---@return number # Randomized value.
function RAT:_Randomize(value, fac, lower, upper) end

---Place markers of the waypoints. Note we assume a very specific number and type of waypoints here.
---@param waypoints? table Table with waypoints.
---@param waypointdescriptions? table Table with waypoint descriptions
---@param index? number Spawn index of group.
function RAT:_PlaceMarkers(waypoints, waypointdescriptions, index) end

---Set a marker visible for all on the F10 map.
---@param text? string Info text displayed at maker.
---@param wp? table Position of marker coming in as waypoint, i.e. has x, y and alt components.
---@param index? number Spawn index of group.
function RAT:_SetMarker(text, wp, index) end

---Delete all markers on F10 map.
function RAT:_DeleteMarkers() end

---Modifies the template of the group to be spawned.
---In particular, the waypoints of the group's flight plan are copied into the spawn template.
---This allows to spawn at airports and also land at other airports, i.e. circumventing the DCS "landing bug".
---@param waypoints? table The waypoints of the AI flight plan.
---@param livery? string (Optional) Livery of the aircraft. All members of a flight will get the same livery.
---@param spawnplace? COORDINATE (Optional) Place where spawning should happen. If not present, first waypoint is taken.
---@param departure? AIRBASE Departure airbase or zone.
---@param takeoff? number Takeoff type.
---@param parkingdata? table Parking data, i.e. parking spot coordinates and terminal ids for all units of the group.
---@param uncontrolled? boolean If `true`, group is spawned uncontrolled.
---@return boolean # True if modification was successful or nil if not, e.g. when no parking space was found and spawn in air is disabled.
function RAT:_ModifySpawnTemplate(waypoints, livery, spawnplace, departure, takeoff, parkingdata, uncontrolled) end

---Initializes the ATC arrays and starts schedulers.
---@param airports_map? table List of all airports of the map.
function RAT._ATCInit(airports_map) end

---Adds andd initializes a new flight after it was spawned.
---@param name? string Group name of the flight.
---@param dest? string Name of the destination airport.
function RAT:_ATCAddFlight(name, dest) end

---Deletes a flight from ATC lists after it landed.
---@param t? table Table.
---@param entry? string Flight name which shall be deleted.
function RAT._ATCDelFlight(t, entry) end

---Registers a flight once it is near its holding point at the final destination.
---@param name? string Group name of the flight.
---@param time? number Time the fight first registered.
function RAT._ATCRegisterFlight(name, time) end

---ATC status report about flights.
function RAT._ATCStatus() end

---Main ATC function. Updates the landing queue of all airports and inceases holding time for all flights.
function RAT._ATCCheck() end

---Giving landing clearance for aircraft by setting user flag.
---@param airportname? string Name of destination airport.
---@param flightname? string Group name of flight, which gets landing clearence.
function RAT._ATCClearForLanding(airportname, flightname) end

---Takes care of organisational stuff after a plane has landed.
---@param name? string Group name of flight.
function RAT._ATCFlightLanded(name) end

---Creates a landing queue for all flights holding at airports. Aircraft with longest holding time gets first permission to land.
function RAT._ATCQueue() end

---RATMANAGER class
---@class RATMANAGER : BASE
---@field ClassName string Name of the Class.
---@field Debug boolean If true, be more verbose on output in DCS.log file.
---@field rat table Array holding RAT objects etc.
---@field name string Name (alias) of RAT object.
---@field alive table Number of currently alive groups.
---@field min table Minimum number of RAT groups alive.
---@field nrat number Number of RAT objects.
---@field ntot number Total number of active RAT groups.
---@field Tcheck number Time interval in seconds between checking of alive groups.
---@field dTspawn number Time interval in seconds between spawns of groups.
---@field manager SCHEDULER Scheduler managing the RAT objects.
---@field managerid number Managing scheduler id.
RATMANAGER={
  ClassName="RATMANAGER",
  Debug=false,
  rat={},
  name={},
  alive={},
  planned={},
  min={},
  nrat=0,
  ntot=nil,
  Tcheck=60,
  dTspawn=1.0,
  manager=nil,
  managerid=nil,
}

---Some ID to identify who we are in output of the DCS.log file.
RATMANAGER.id = "RATMANAGER | "

---Creates a new RATMANAGER object.
---@param ntot? number Total number of RAT flights.
---@return RATMANAGER # RATMANAGER object
function RATMANAGER:New(ntot) end

---Adds a RAT object to the RAT manager. Parameter min specifies the limit how many RAT groups are at least alive.
---@param ratobject? RAT RAT object to be managed.
---@param min? number (Optional) Minimum number of groups for this RAT object. Default is 1.
---@return RATMANAGER # RATMANAGER self object.
function RATMANAGER:Add(ratobject, min) end

---Starts the RAT manager and spawns the initial random number RAT groups for each RAT object.
---@param delay? number (Optional) Time delay in seconds after which the RAT manager is started. Default is 5 seconds.
---@return RATMANAGER # RATMANAGER self object.
function RATMANAGER:Start(delay) end

---Stops the RAT manager.
---@param delay? number (Optional) Delay in seconds before the manager is stopped. Default is 1 second.
---@return RATMANAGER # RATMANAGER self object.
function RATMANAGER:Stop(delay) end

---Sets the time interval between checks of alive RAT groups. Default is 60 seconds.
---@param dt? number Time interval in seconds.
---@return RATMANAGER # RATMANAGER self object.
function RATMANAGER:SetTcheck(dt) end

---Sets the time interval between spawning of groups.
---@param dt? number (Optional) Time interval in seconds. Default is 1 second.
---@return RATMANAGER # RATMANAGER self object.
function RATMANAGER:SetTspawn(dt) end

---Manager function. Calculating the number of current groups and respawning new groups if necessary.
function RATMANAGER:_Manage() end

---Instantly starts the RAT manager and spawns the initial random number RAT groups for each RAT object.
---@param i? number Index.
function RATMANAGER:_Spawn(i) end

---Counts the number of alive RAT objects.
function RATMANAGER:_Count() end

---Rolls the dice for the number of necessary spawns.
---@param nrat? number Number of RAT objects.
---@param ntot? number Total number of RAT flights.
---@param min? table Minimum number of groups for each RAT object.
---@param alive? table Number of alive groups of each RAT object.
function RATMANAGER:_RollDice(nrat, ntot, min, alive) end
