---@meta

---@class FLIGHTCONTROL.ParkingSpot : AIRBASE.ParkingSpot
---@field ParkingGuard GROUP Parking guard for this spot.

---@class FLIGHTCONTROL.HoldingStack
---@field flightgroup FLIGHTGROUP Flight group of this stack.
---@field angels number Holding altitude in Angels.
---@field pos0 COORDINATE First position of racetrack holding pattern.
---@field pos1 COORDINATE Second position of racetrack holding pattern.
---@field heading number Heading.

---@class FLIGHTCONTROL.HoldingPattern
---@field arrivalzone ZONE Zone where aircraft should arrive.
---@field uid number Unique ID.
---@field name string Name of the zone, which is <zonename>-<uid>.
---@field pos0 COORDINATE First position of racetrack holding pattern.
---@field pos1 COORDINATE Second position of racetrack holding pattern.
---@field angelsmin number Smallest holding altitude in angels.
---@field angelsmax number Largest holding alitude in angels.
---@field stacks table Holding stacks.
---@field markArrival number Marker ID of the arrival zone.
---@field markArrow number Marker ID of the direction.

---FLIGHTCONTROL class.
---@class FLIGHTCONTROL : FSM
---@field ClassName string Name of the class.
---@field verbose boolean Verbosity level.
---@field theatre string The DCS map used in the mission.
---@field lid string Class id string for output to DCS log file.
---@field airbasename string Name of airbase.
---@field alias string Radio alias, e.g. "Batumi Tower".
---@field airbasetype number Type of airbase.
---@field airbase AIRBASE Airbase object.
---@field zoneAirbase ZONE Zone around the airbase.
---@field parking table Parking spots table.
---@field flights table All flights table.
---@field clients table Table with all clients spawning at this airbase.
---@field atis ATIS ATIS object.
---@field frequency number ATC radio frequency in MHz.
---@field modulation number ATC radio modulation, *e.g.* `radio.modulation.AM`.
---@field NlandingTot number Max number of aircraft groups in the landing pattern.
---@field NlandingTakeoff number Max number of groups taking off to allow landing clearance.
---@field NtaxiTot number Max number of aircraft groups taxiing to runway for takeoff.
---@field NtaxiInbound boolean Include inbound taxiing groups.
---@field NtaxiLanding number Max number of aircraft landing for groups taxiing to runway for takeoff.
---@field dTlanding number Time interval in seconds between landing clearance.
---@field Tlanding number Time stamp (abs.) when last flight got landing clearance.
---@field Nparkingspots number Total number of parking spots.
---@field parkingGuard SPAWN Parking guard spawner.
---@field holdingpatterns table Holding points.
---@field hpcounter number Counter for holding zones.
---@field msrsqueue MSRSQUEUE Queue for TTS transmissions using MSRS class.
---@field msrsTower MSRS Moose SRS wrapper.
---@field msrsPilot MSRS Moose SRS wrapper.
---@field Tlastmessage number Time stamp (abs.) of last radio transmission.
---@field dTmessage number Time interval between messages.
---@field markPatterns boolean If `true`, park holding pattern.
---@field speedLimitTaxi number Taxi speed limit in m/s.
---@field runwaydestroyed number Time stamp (abs), when runway was destroyed. If `nil`, runway is operational.
---@field runwayrepairtime number Time in seconds until runway will be repaired after it was destroyed. Default is 3600 sec (one hour).
---@field markerParking boolean If `true`, occupied parking spots are marked.
---@field nosubs boolean If `true`, SRS TTS is without subtitles.
---@field Nplayers number Number of human players. Updated at each StatusUpdate call.
---@field radioOnlyIfPlayers boolean Activate to limit transmissions only if players are active at the airbase.
FLIGHTCONTROL = {
  ClassName      = "FLIGHTCONTROL",
  verbose        =     0,
  lid            =   nil,
  theatre        =   nil,
  airbasename    =   nil,
  airbase        =   nil,
  airbasetype    =   nil,
  zoneAirbase    =   nil,
  parking        =    {},
  runways        =    {},
  flights        =    {},
  clients        =    {},
  atis           =   nil,
  Nlanding         = nil,
  dTlanding        = nil,
  Nparkingspots    = nil,
  holdingpatterns  =  {},
  hpcounter        =   0,
  nosubs         =  false,
  Nplayers       =     0,
}

---Flight status.
---@class FLIGHTCONTROL.FlightStatus
---@field UNKNOWN string Flight is unknown.
---@field INBOUND string Flight is inbound.
---@field HOLDING string Flight is holding.
---@field LANDING string Flight is landing.
---@field TAXIINB string Flight is taxiing to parking area.
---@field ARRIVED string Flight arrived at parking spot.
---@field TAXIOUT string Flight is taxiing to runway for takeoff.
---@field READYTX string Flight is ready to taxi.
---@field READYTO string Flight is ready for takeoff.
---@field TAKEOFF string Flight is taking off.
FLIGHTCONTROL.FlightStatus={
  UNKNOWN="Unknown",
  PARKING="Parking",
  READYTX="Ready To Taxi",
  TAXIOUT="Taxi To Runway",
  READYTO="Ready For Takeoff",
  TAKEOFF="Takeoff",          
  INBOUND="Inbound",
  HOLDING="Holding",
  LANDING="Landing",
  TAXIINB="Taxi To Parking",
  ARRIVED="Arrived",
}

---FlightControl class version.
FLIGHTCONTROL.version = "0.7.7"

---Create a new FLIGHTCONTROL class object for an associated airbase.
---@param AirbaseName? string Name of the airbase.
---@param Frequency? number (Optional) Radio frequency in MHz. Default 143.00 MHz. Can also be given as a `#table` of multiple frequencies.
---@param Modulation? number (Optional) Radio modulation: 0=AM (default), 1=FM. See `radio.modulation.AM` and `radio.modulation.FM` enumerators. Can also be given as a `#table` of multiple modulations.
---@param PathToSRS? string (Optional) Path to the directory, where SRS is located.
---@param Port? number (Optional) Port of SRS Server, defaults to 5002
---@param GoogleKey? string (Optional) Path to the Google JSON-Key.
---@param Provider? string (Optional) TTS Provider to be used.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:New(AirbaseName, Frequency, Modulation, PathToSRS, Port, GoogleKey, Provider) end

---Set verbosity level.
---@param VerbosityLevel? number (Optional) Level of output (higher=more). Default 0.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetVerbosity(VerbosityLevel) end

---Limit radio transmissions only if human players are registered at the airbase.
---This can be used to reduce TTS messages on heavy missions.
---@param Switch? boolean If `true` or `nil` no transmission if there are no players. Use `false` enable TTS with no players.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetRadioOnlyIfPlayers(Switch) end

---Set whether to only transmit TTS messages if there are players on the server.
---@param Switch? boolean If `true`, only send TTS messages if there are alive Players. If `false` or `nil`, transmission are done also if no players are on the server.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetTransmitOnlyWithPlayers(Switch) end

---Set subtitles to appear on SRS TTS messages.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SwitchSubtitlesOn() end

---Set subtitles to appear on SRS TTS messages.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SwitchSubtitlesOff() end

---Set the tower frequency.
---@param Frequency? number (Optional) Frequency in MHz. Default 305 MHz.
---@param Modulation? number (Optional) Modulation `radio.modulation.AM`=0, `radio.modulation.FM`=1. Default `radio.modulation.AM`.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetFrequency(Frequency, Modulation) end

---Set the SRS server port.
---@param Port? number (Optional) Port to be used. Defaults to 5002.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetSRSPort(Port) end

---Set SRS options for a given MSRS object.
---@param msrs? MSRS Moose SRS object.
---@param Gender? string (Optional) Gender: "male" or "female" (default).
---@param Culture? string (Optional) Culture, e.g. "en-GB" (default).
---@param Voice? string Specific voice. Overrides `Gender` and `Culture`.
---@param Volume? number (Optional) Volume. Default 1.0.
---@param Label? string Name under which SRS transmits.
---@param PathToGoogleCredentials? string (Optional) Path to google credentials json file.
---@param Port? number (Optional) Server port for SRS. Defaults to 5002.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:_SetSRSOptions(msrs, Gender, Culture, Voice, Volume, Label, PathToGoogleCredentials, Port, Speaker) end

---Set SRS options for tower voice.
---@param Gender? string (Optional) Gender: "male" or "female" (default).
---@param Culture? string (Optional) Culture, e.g. "en-GB" (default).
---@param Voice? string Specific voice. Overrides `Gender` and `Culture`. See [Google Voices](https://cloud.google.com/text-to-speech/docs/voices).
---@param Volume? number (Optional) Volume. Default 1.0.
---@param Label? string (Optional) Name under which SRS transmits. Default `self.alias`.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetSRSTower(Gender, Culture, Voice, Volume, Label, Speaker) end

---Set SRS options for pilot voice.
---@param Gender? string (Optional) Gender: "male" (default) or "female".
---@param Culture? string (Optional) Culture, e.g. "en-US" (default).
---@param Voice? string Specific voice. Overrides `Gender` and `Culture`.
---@param Volume? number (Optional) Volume. Default 1.0.
---@param Label? string (Optional) Name under which SRS transmits. Default "Pilot".
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetSRSPilot(Gender, Culture, Voice, Volume, Label, Speaker) end

---Set the number of aircraft groups, that are allowed to land simultaneously.
---Note that this restricts AI and human players.
---
---By default, up to two groups get landing clearance. They are spaced out in time, i.e. after the first one got cleared, the second has to wait a bit.
---This
---
---By default, landing clearance is only given when **no** other flight is taking off. You can adjust this for airports with more than one runway or
---in cases where simultaneous takeoffs and landings are unproblematic. Note that only because there are multiple runways, it does not mean the AI uses them.
---@param Nlanding? number (Optional) Max number of aircraft landing simultaneously. Default 2.
---@param Ntakeoff? number (Optional) Allowed number of aircraft taking off for groups to get landing clearance. Default 0.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetLimitLanding(Nlanding, Ntakeoff) end

---Set time interval between landing clearance of groups.
---@param dt? number (Optional) Time interval in seconds. Default 180 sec (3 min).
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetLandingInterval(dt) end

---Set the number of **AI** aircraft groups, that are allowed to taxi simultaneously.
---If the limit is reached, other AI groups not get taxi clearance to taxi to the runway.
---
---By default, this only counts the number of AI that taxi from their parking position to the runway.
---You can also include inbound AI that taxi from the runway to their parking position.
---This can be handy for problematic (usually smaller) airdromes, where there is only one taxiway inbound and outbound flights.
---
---By default, AI will not get cleared for taxiing if at least one other flight is currently landing. If this is an unproblematic airdrome, you can
---also allow groups to taxi if planes are landing, *e.g.* if there are two separate runways.
---
---NOTE that human players are *not* restricted as they should behave better (hopefully) than the AI.
---@param Ntaxi? number (Optional) Max number of groups allowed to taxi. Default 2.
---@param IncludeInbound? boolean If `true`, the above
---@param Nlanding? number (Optional) Max number of landing flights. Default 0.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetLimitTaxi(Ntaxi, IncludeInbound, Nlanding) end

---Add a holding pattern.
---This is a zone where the aircraft...
---@param ArrivalZone? ZONE Zone where planes arrive.
---@param Heading? number Heading in degrees.
---@param Length? number (Optional) Length in nautical miles. Default 15 NM.
---@param FlightlevelMin? number (Optional) Min flight level. Default 5.
---@param FlightlevelMax? number (Optional) Max flight level. Default 15.
---@param Prio? number (Optional) Priority. Lower is higher. Default 50.
---@return FLIGHTCONTROL.HoldingPattern # Holding pattern table.
function FLIGHTCONTROL:AddHoldingPattern(ArrivalZone, Heading, Length, FlightlevelMin, FlightlevelMax, Prio) end

---Remove a holding pattern.
---@param HoldingPattern? FLIGHTCONTROL.HoldingPattern|number|string Holding pattern to be removed.
function FLIGHTCONTROL:RemoveHoldingPattern(HoldingPattern) end

---Set to mark the holding patterns on the F10 map.
---@param Switch? boolean If `true` (or `nil`), mark holding patterns.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetMarkHoldingPattern(Switch) end

---Set speed limit for taxiing.
---@param SpeedLimit? number Speed limit in knots. If `nil`, no speed limit.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetSpeedLimitTaxi(SpeedLimit) end

---Set the parking guard group. This group is used to block (AI) aircraft from taxiing until they get clearance. It should contain of only one unit, *e.g.* a simple soldier.
---@param TemplateGroupName? string Name of the template group.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetParkingGuard(TemplateGroupName) end

---Set the parking guard static. This static is used to block (AI) aircraft from taxiing until they get clearance.
---@param TemplateStaticName? string Name of the template static.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetParkingGuardStatic(TemplateStaticName) end

---Set ATIS.
---@param Atis? ATIS ATIS.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetATIS(Atis) end

---Get coordinate of the airbase.
---@return COORDINATE # Coordinate of the airbase.
function FLIGHTCONTROL:GetCoordinate() end

---Get coalition of the airbase.
---@return number # Coalition ID.
function FLIGHTCONTROL:GetCoalition() end

---Get country of the airbase.
---@return number # Country ID.
function FLIGHTCONTROL:GetCountry() end

---Set the time until the runway(s) of an airdrome are repaired after it has been destroyed.
---Note that this is the time, the DCS engine uses not something we can control on a user level or we could get via scripting.
---You need to input the value. On the DCS forum it was stated that this is currently one hour. Hence this is the default value.
---@param RepairTime? number (Optional) Time in seconds until the runway is repaired. Default 3600sec (one hour).
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetRunwayRepairtime(RepairTime) end

---Check if runway is operational.
---@return number # Time in seconds until the runway is repaired. Will return 0 if runway is repaired.
function FLIGHTCONTROL:GetRunwayRepairtime() end

---Check if runway is operational.
---@return boolean # If `true`, runway is operational.
function FLIGHTCONTROL:IsRunwayOperational() end

---Check if runway is destroyed.
---@return boolean # If `true`, runway is destroyed.
function FLIGHTCONTROL:IsRunwayDestroyed() end

---Is flight in queue of this flightcontrol.
---@param Flight? FLIGHTGROUP Flight group.
---@return boolean # If `true`, flight is in queue.
function FLIGHTCONTROL:IsFlight(Flight) end

---Check if coordinate is on runway.
---@param Coordinate? COORDINATE
---@return boolean # If `true`, coordinate is on a runway.
function FLIGHTCONTROL:IsCoordinateRunway(Coordinate) end

---Start FLIGHTCONTROL FSM. Handle events.
function FLIGHTCONTROL:onafterStart() end

---On Before Update status.
function FLIGHTCONTROL:onbeforeStatusUpdate() end

---Update status.
function FLIGHTCONTROL:onafterStatusUpdate() end

---Stop FLIGHTCONTROL FSM.
function FLIGHTCONTROL:onafterStop() end

---Event handler for event birth.
---@param EventData? EVENTDATA
function FLIGHTCONTROL:OnEventBirth(EventData) end

---Event handling function.
---@param EventData? EVENTDATA Event data.
function FLIGHTCONTROL:OnEventCrashOrDead(EventData) end

---Event handler for event land.
---@param EventData? EVENTDATA
function FLIGHTCONTROL:OnEventLand(EventData) end

---Event handler for event takeoff.
---@param EventData? EVENTDATA
function FLIGHTCONTROL:OnEventTakeoff(EventData) end

---Event handler for event engine startup.
---@param EventData? EVENTDATA
function FLIGHTCONTROL:OnEventEngineStartup(EventData) end

---Event handler for event engine shutdown.
---@param EventData? EVENTDATA
function FLIGHTCONTROL:OnEventEngineShutdown(EventData) end

---Event handler for event kill.
---@param EventData? EVENTDATA
function FLIGHTCONTROL:OnEventKill(EventData) end

---On after "RunwayDestroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTCONTROL:onafterRunwayDestroyed(From, Event, To) end

---On after "RunwayRepaired" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTCONTROL:onafterRunwayRepaired(From, Event, To) end

---Check takeoff and landing queues.
function FLIGHTCONTROL:_CheckQueues() end

---Check if a flight can get clearance for taxi/takeoff.
---@param flight? FLIGHTGROUP Flight..
---@return boolean # If true, flight can.
function FLIGHTCONTROL:_CheckFlightTakeoff(flight) end

---Check if a flight can get clearance for taxi/takeoff.
---@param flight? FLIGHTGROUP Flight..
---@return boolean # If true, flight can.
function FLIGHTCONTROL:_CheckFlightLanding(flight) end

---Get next flight in line, either waiting for landing or waiting for takeoff.
---@return FLIGHTGROUP # Flight next in line and ready to enter the pattern. Or nil if no flight is ready.
---@return boolean # If true, flight is holding and waiting for landing, if false, flight is parking and waiting for takeoff.
---@return table # Parking data for holding flights or nil.
function FLIGHTCONTROL:_GetNextFlight() end

---Get next flight waiting for landing clearance.
---@return FLIGHTGROUP # Marshal flight next in line and ready to enter the pattern. Or nil if no flight is ready.
function FLIGHTCONTROL:_GetNextFightHolding() end

---Get next flight waiting for taxi and takeoff clearance.
---@return FLIGHTGROUP # Marshal flight next in line and ready to enter the pattern. Or nil if no flight is ready.
function FLIGHTCONTROL:_GetNextFightParking() end

---Print queue.
---@param queue? table Queue to print.
---@param name? string Queue name.
---@return string # Queue text.
function FLIGHTCONTROL:_PrintQueue(queue, name) end

---Set flight status.
---@param flight? FLIGHTGROUP Flight group.
---@param status? string New status.
function FLIGHTCONTROL:SetFlightStatus(flight, status) end

---Get flight status.
---@param flight? FLIGHTGROUP Flight group.
---@return string # Flight status
function FLIGHTCONTROL:GetFlightStatus(flight) end

---Check if FC has control over this flight.
---@param flight? FLIGHTGROUP Flight group.
---@return boolean
function FLIGHTCONTROL:IsControlling(flight) end

---Check if a group is in a queue.
---@param queue? table The queue to check.
---@param group? GROUP The group to be checked.
---@return boolean # If true, group is in the queue. False otherwise.
function FLIGHTCONTROL:_InQueue(queue, group) end

---Get flights.
---@param Status? string Return only flights in this flightcontrol status, e.g. `FLIGHTCONTROL.Status.XXX`.
---@param GroupStatus? string Return only flights in this FSM status, e.g. `OPSGROUP.GroupStatus.TAXIING`.
---@param AI? boolean (Optional) If `true` only AI flights are returned. If `false`, only flights with clients are returned. If `nil` (default), all flights are returned.
---@return table # Table of flights.
function FLIGHTCONTROL:GetFlights(Status, GroupStatus, AI) end

---Count flights in a given status.
---@param Status? string Return only flights in this status.
---@param GroupStatus? string Count only flights in this FSM status, e.g. `OPSGROUP.GroupStatus.TAXIING`.
---@param AI? boolean (Optional) If `true` only AI flights are counted. If `false`, only flights with clients are counted. If `nil` (default), all flights are counted.
---@return number # Number of flights.
function FLIGHTCONTROL:CountFlights(Status, GroupStatus, AI) end

---Get the active runway based on current wind direction.
---@return AIRBASE.Runway # Active runway.
function FLIGHTCONTROL:GetActiveRunway() end

---Get the active runway for landing.
---@return AIRBASE.Runway # Active runway.
function FLIGHTCONTROL:GetActiveRunwayLanding() end

---Get the active runway for takeoff.
---@return AIRBASE.Runway # Active runway.
function FLIGHTCONTROL:GetActiveRunwayTakeoff() end

---Get the name of the active runway.
---@param Takeoff? boolean (Optional) If true, return takeoff runway name. Default is landing.
---@return string # Runway text, e.g. "31L" or "09".
function FLIGHTCONTROL:GetActiveRunwayText(Takeoff) end

---Init parking spots.
function FLIGHTCONTROL:_InitParkingSpots() end

---Get parking spot by its Terminal ID.
---@param TerminalID? number
---@return FLIGHTCONTROL.ParkingSpot # Parking spot data table.
function FLIGHTCONTROL:GetParkingSpotByID(TerminalID) end

---Set parking spot to FREE and update F10 marker.
---@param spot? AIRBASE.ParkingSpot|number|string The parking spot data table.
---@param status? string New status.
---@param unitname? string Name of the unit.
function FLIGHTCONTROL:_UpdateSpotStatus(spot, status, unitname) end

---Set parking spot to FREE and update F10 marker.
---@param spot? AIRBASE.ParkingSpot|number|string The parking spot data table.
function FLIGHTCONTROL:SetParkingFree(spot) end

---Set parking spot to RESERVED and update F10 marker.
---@param spot? AIRBASE.ParkingSpot|number|string The parking spot data table.
---@param unitname? string (Optional) Name of the unit occupying the spot. Default "unknown".
function FLIGHTCONTROL:SetParkingReserved(spot, unitname) end

---Set parking spot to OCCUPIED and update F10 marker.
---@param spot? AIRBASE.ParkingSpot|number|string The parking spot data table.
---@param unitname? string (Optional) Name of the unit occupying the spot. Default "unknown".
function FLIGHTCONTROL:SetParkingOccupied(spot, unitname) end

---Update parking markers.
---@param spot? AIRBASE.ParkingSpot|number|string The parking spot data table.
function FLIGHTCONTROL:UpdateParkingMarker(spot) end

---Check if parking spot is free.
---@param spot? AIRBASE.ParkingSpot|number|string Parking spot data.
---@return boolean # If true, parking spot is free.
function FLIGHTCONTROL:IsParkingFree(spot) end

---Check if a parking spot is reserved by a flight group.
---@param spot? AIRBASE.ParkingSpot|number|string Parking spot to check.
---@return string # Name of element or nil.
function FLIGHTCONTROL:IsParkingOccupied(spot) end

---Check if a parking spot is reserved by a flight group.
---@param spot? AIRBASE.ParkingSpot|number|string Parking spot to check.
---@return string # Name of element or *nil*.
function FLIGHTCONTROL:IsParkingReserved(spot) end

---Get free parking spots.
---@param terminal? number Terminal type or nil.
---@return number # Number of free spots. Total if terminal=nil or of the requested terminal type.
---@return table # Table of free parking spots of data type #FLIGHCONTROL.ParkingSpot.
function FLIGHTCONTROL:_GetFreeParkingSpots(terminal) end

---Get closest parking spot.
---@param Coordinate? COORDINATE Reference coordinate.
---@param TerminalType? number (Optional) Check only this terminal type.
---@param Status? boolean (Optional) Only consider spots that have this status.
---@return FLIGHTCONTROL.ParkingSpot # Closest parking spot.
function FLIGHTCONTROL:GetClosestParkingSpot(Coordinate, TerminalType, Status) end

---Get parking spot this player was initially spawned on.
---@param UnitName? string Name of the player unit.
---@return FLIGHTCONTROL.ParkingSpot # Player spot or nil.
function FLIGHTCONTROL:_GetPlayerSpot(UnitName) end

---Count number of parking spots.
---@param SpotStatus? string (Optional) Status of spot.
---@return number # Number of parking spots.
function FLIGHTCONTROL:CountParking(SpotStatus) end

---Create player menu.
---@param flight? FLIGHTGROUP Flight group.
---@param mainmenu? MENU_GROUP ATC root menu table.
function FLIGHTCONTROL:_CreatePlayerMenu(flight, mainmenu) end

---Player menu not implemented.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerNotImplemented(groupname) end

---Player radio check.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerRadioCheck(groupname) end

---Player confirm status.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerConfirmStatus(groupname) end

---Player info about airbase.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerInfoAirbase(groupname) end

---Player info about ATIS.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerInfoATIS(groupname) end

---Player info about traffic.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerInfoTraffic(groupname) end

---Player calls inbound.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestInbound(groupname) end

---Player vector to inbound
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerVectorInbound(groupname) end

---Player aborts inbound.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortInbound(groupname) end

---Player calls holding.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerHolding(groupname) end

---Player aborts holding.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortHolding(groupname) end

---Player confirms landing.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerConfirmLanding(groupname) end

---Player aborts landing.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortLanding(groupname) end

---Player request direct approach.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestDirectLanding(groupname) end

---Player requests taxi.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestTaxi(groupname) end

---Player aborts taxi.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortTaxi(groupname) end

---Player requests takeoff.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestTakeoff(groupname) end

---Player wants to abort takeoff.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortTakeoff(groupname) end

---Player reserves a parking spot.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestParking(groupname) end

---Player cancels parking spot reservation.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerCancelParking(groupname) end

---Player arrived at parking position.
---@param groupname? string Name of the flight group.
function FLIGHTCONTROL:_PlayerArrived(groupname) end

---Create a new flight group.
---@param group? GROUP Aircraft group.
---@return FLIGHTGROUP # Flight group.
function FLIGHTCONTROL:_CreateFlightGroup(group) end

---Remove flight from all queues.
---@param Flight? FLIGHTGROUP The flight to be removed.
function FLIGHTCONTROL:_RemoveFlight(Flight) end

---Get flight from group.
---@param group? GROUP Group that will be removed from queue.
---@return FLIGHTGROUP # Flight group or nil.
---@return number # Queue index or nil.
function FLIGHTCONTROL:_GetFlightFromGroup(group) end

---Get element of flight from its unit name.
---@param unitname? string Name of the unit.
---@return OPSGROUP.Element # Element of the flight or nil.
---@return number # Element index or nil.
---@return FLIGHTGROUP # The Flight group or nil.
function FLIGHTCONTROL:_GetFlightElement(unitname) end

---Check status of all registered flights and do some sanity checks.
function FLIGHTCONTROL:_CheckFlights() end

---Check status of all registered flights and do some sanity checks.
function FLIGHTCONTROL:_CheckParking() end

---Tell AI to land at the airbase. Flight is added to the landing queue.
---@param flight? FLIGHTGROUP Flight group.
---@param parking? table Free parking spots table.
function FLIGHTCONTROL:_LandAI(flight, parking) end

---Get holding stack.
---@param flight? FLIGHTGROUP Flight group.
---@return FLIGHTCONTROL.HoldingStack # Holding point.
function FLIGHTCONTROL:_GetHoldingStack(flight) end

---Count flights in holding pattern.
---@param Pattern? FLIGHTCONTROL.HoldingPattern|number|string The pattern.
---@return FLIGHTCONTROL.HoldingStack # Holding point.
function FLIGHTCONTROL:_CountFlightsInPattern(Pattern) end

---AI flight on final.
---@param flight? FLIGHTGROUP Flight group.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:_FlightOnFinal(flight) end

---Radio transmission from tower.
---@param Text? string The text to transmit.
---@param Flight? FLIGHTGROUP The flight.
---@param Delay? number (Optional) Delay in seconds before the text is transmitted. Default 0 sec.
function FLIGHTCONTROL:TransmissionTower(Text, Flight, Delay) end

---Radio transmission.
---@param Text? string The text to transmit.
---@param Flight? FLIGHTGROUP The flight.
---@param Delay? number (Optional) Delay in seconds before the text is transmitted. Default 0 sec.
function FLIGHTCONTROL:TransmissionPilot(Text, Flight, Delay) end

---Text message to group.
---@param Text? string The text to transmit.
---@param Flight? FLIGHTGROUP The flight.
---@param Duration? number (Optional) Duration in seconds. Default 5.
---@param Clear? boolean Clear screen.
---@param Delay? number (Optional) Delay in seconds before the text is transmitted. Default 0 sec.
function FLIGHTCONTROL:TextMessageToFlight(Text, Flight, Duration, Clear, Delay) end

---Clean text. Remove control sequences.
---@param Text? string The text.
function FLIGHTCONTROL:_CleanText(Text) end

---[INTERNAL] Add parking guard in front of a parking aircraft - delayed for MP.
---@param unit? UNIT The aircraft.
function FLIGHTCONTROL:_SpawnParkingGuard(unit) end

---Add parking guard in front of a parking aircraft.
---@param unit? UNIT The aircraft.
function FLIGHTCONTROL:SpawnParkingGuard(unit) end

---Remove parking guard.
---@param spot? FLIGHTCONTROL.ParkingSpot|number|string
---@param delay? number Delay in seconds.
function FLIGHTCONTROL:RemoveParkingGuard(spot, delay) end

---Check if a flight is on a runway
---@param flight? FLIGHTGROUP
function FLIGHTCONTROL:_IsFlightOnRunway(flight) end

---[User] Set callsign options for TTS output. See {Wrapper.Group#GROUP.GetCustomCallSign}() on how to set customized callsigns.
---@param ShortCallsign? boolean (Optional) If true, only call out the major flight number. Default = `true`.
---@param Keepnumber? boolean (Optional) If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers. Default = `true`.
---@param CallsignTranslations? table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@return FLIGHTCONTROL # self
function FLIGHTCONTROL:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations) end

---Get callsign name of a given flight.
---@param flight? FLIGHTGROUP Flight group.
---@return string # Callsign or "Ghostrider 1-1".
function FLIGHTCONTROL:_GetCallsignName(flight) end

---Get text for text-to-speech.
---Numbers are spaced out, e.g. "Heading 180" becomes "Heading 1 8 0 ".
---@param text? string Original text.
---@return string # Spoken text.
function FLIGHTCONTROL:_GetTextForSpeech(text) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param unitName? string Name of the player unit.
---@return UNIT # Unit of player or nil.
---@return string # Name of the player or nil.
function FLIGHTCONTROL:_GetPlayerUnitAndName(unitName) end

---Check holding pattern markers. Draw if they should exists and remove if they should not.
function FLIGHTCONTROL:_CheckMarkHoldingPatterns() end

---Draw marks of holding pattern (if they do not exist.
---@param Pattern? FLIGHTCONTROL.HoldingPattern|number|string Holding pattern table.
function FLIGHTCONTROL:_MarkHoldingPattern(Pattern) end

---Removem markers of holding pattern (if they exist).
---@param Pattern? FLIGHTCONTROL.HoldingPattern|number|string Holding pattern table.
function FLIGHTCONTROL:_UnMarkHoldingPattern(Pattern) end

---Add a holding pattern.
---@return FLIGHTCONTROL.HoldingPattern # Holding pattern table.
function FLIGHTCONTROL:_AddHoldingPatternBackup() end

---Triggers the FSM event "Start".
function FLIGHTCONTROL:Start() end

---Triggers the FSM event "Start" after a delay.
---@param delay? number Delay in seconds.
function FLIGHTCONTROL:__Start(delay) end

---Triggers the FSM event "Stop".
function FLIGHTCONTROL:Stop() end

---Triggers the FSM event "Stop" after a delay.
---@param delay? number Delay in seconds.
function FLIGHTCONTROL:__Stop(delay) end

---Triggers the FSM event "StatusUpdate".
function FLIGHTCONTROL:StatusUpdate() end

---Triggers the FSM event "StatusUpdate" after a delay.
---@param delay? number Delay in seconds.
function FLIGHTCONTROL:__StatusUpdate(delay) end

---Triggers the FSM event "RunwayDestroyed".
function FLIGHTCONTROL:RunwayDestroyed() end

---Triggers the FSM event "RunwayDestroyed" after a delay.
---@param delay? number Delay in seconds.
function FLIGHTCONTROL:__RunwayDestroyed(delay) end

---On after "RunwayDestroyed" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTCONTROL:OnAfterRunwayDestroyed(From, Event, To) end

---Triggers the FSM event "RunwayRepaired".
function FLIGHTCONTROL:RunwayRepaired() end

---Triggers the FSM event "RunwayRepaired" after a delay.
---@param delay? number Delay in seconds.
function FLIGHTCONTROL:__RunwayRepaired(delay) end

---On after "RunwayRepaired" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLIGHTCONTROL:OnAfterRunwayRepaired(From, Event, To) end

---Triggers the FSM event "PlayerSpeeding".
---@param Player? FLIGHTGROUP.PlayerData|number|string data.
function FLIGHTCONTROL:PlayerSpeeding(Player) end

---Triggers the FSM event "PlayerSpeeding" after a delay.
---@param delay? number Delay in seconds.
---@param Player? FLIGHTGROUP.PlayerData|number|string data.
function FLIGHTCONTROL:__PlayerSpeeding(delay, Player) end

---On after "PlayerSpeeding" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Player? FLIGHTGROUP.PlayerData|number|string data.
function FLIGHTCONTROL:OnAfterPlayerSpeeding(From, Event, To, Player) end
