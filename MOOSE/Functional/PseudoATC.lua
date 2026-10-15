---@meta

---PSEUDOATC class
---@class PSEUDOATC : BASE
---@field ClassName string Name of the Class.
---@field player table Table comprising each player info.
---@field Debug boolean If true, print debug info to dcs.log file.
---@field mdur number Duration in seconds how low messages to the player are displayed.
---@field mrefresh number Interval in seconds after which the F10 menu is refreshed. E.g. by the closest airports. Default is 120 sec.
---@field talt number Interval in seconds between reporting altitude until touchdown. Default 3 sec.
---@field chatty boolean Display some messages on events like take-off and touchdown.
---@field eventsmoose boolean [Deprecated] If true, events are handled by MOOSE. If false, events are handled directly by DCS eventhandler.
---@field reportplayername boolean If true, use playername not callsign on callouts
PSEUDOATC={
  ClassName = "PSEUDOATC",
  group={},
  Debug=false,
  mdur=30,
  mrefresh=120,
  talt=3,
  chatty=true,
  eventsmoose=true,
  reportplayername = false,
}

---Some ID to identify who we are in output of the DCS.log file.
PSEUDOATC.id = "PseudoATC | "

---PSEUDOATC version.
PSEUDOATC.version = "0.10.6"

---PSEUDOATC contructor.
---@return PSEUDOATC # Returns a PSEUDOATC object.
function PSEUDOATC:New() end

---Starts the PseudoATC event handlers.
function PSEUDOATC:Start() end

---Debug mode on. Send messages to everone.
function PSEUDOATC:DebugOn() end

---Debug mode off. This is the default setting.
function PSEUDOATC:DebugOff() end

---Chatty mode on. Display some messages on take-off and touchdown.
function PSEUDOATC:ChattyOn() end

---Chatty mode off. Don't display some messages on take-off and touchdown.
function PSEUDOATC:ChattyOff() end

---Set duration how long messages are displayed.
---@param duration? number (Optional) Time in seconds. Default is 30 sec.
function PSEUDOATC:SetMessageDuration(duration) end

---Use player name, not call sign, in callouts
function PSEUDOATC:SetReportPlayername() end

---Set time interval after which the F10 radio menu is refreshed.
---@param interval? number (Optional) Interval in seconds. Default is every 120 sec.
function PSEUDOATC:SetMenuRefresh(interval) end

---[Deprecated] Enable/disable event handling by MOOSE or DCS.
---@param switch? boolean (Optional) If true, events are handled by MOOSE (default). If false, events are handled directly by DCS.
function PSEUDOATC:SetEventsMoose(switch) end

---Set time interval for reporting altitude until touchdown.
---@param interval? number (Optional) Interval in seconds. Default is every 3 sec.
function PSEUDOATC:SetReportAltInterval(interval) end

---Function called my MOOSE event handler when a player enters a unit.
---@param EventData? EVENTDATA
function PSEUDOATC:_OnBirth(EventData) end

---Function called by MOOSE event handler when a player leaves a unit or dies.
---@param EventData? EVENTDATA
function PSEUDOATC:_PlayerLeft(EventData) end

---Function called by MOOSE event handler when a player landed.
---@param EventData? EVENTDATA
function PSEUDOATC:_PlayerLanded(EventData) end

---Function called by MOOSE/DCS event handler when a player took off.
---@param EventData? EVENTDATA
function PSEUDOATC:_PlayerTakeOff(EventData) end

---Function called when a player enters a unit.
---@param unit? UNIT Unit the player entered.
function PSEUDOATC:PlayerEntered(unit) end

---Function called when a player has landed.
---@param unit? UNIT Unit of player which has landed.
---@param place? string Name of the place the player landed at.
function PSEUDOATC:PlayerLanded(unit, place) end

---Function called when a player took off.
---@param unit? UNIT Unit of player which has landed.
---@param place? string Name of the place the player landed at.
function PSEUDOATC:PlayerTakeOff(unit, place) end

---Function called when a player leaves a unit or dies.
---@param unit? UNIT Player unit which was left.
function PSEUDOATC:PlayerLeft(unit) end

---Refreshes all player menues.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:MenuRefresh(GID, UID) end

---Create player menus.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:MenuCreatePlayer(GID, UID) end

---Clear player menus.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:MenuClear(GID, UID) end

---Create "F10/Pseudo ATC/Local Airports/Airport Name/" menu items each containing weather report and BR request.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:MenuAirports(GID, UID) end

---Create "F10/Pseudo ATC/Waypoints/<Waypoint i>  menu items.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:MenuWaypoints(GID, UID) end

---Weather Report. Report pressure QFE/QNH, temperature, wind at certain location.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
---@param position? COORDINATE Coordinates at which the pressure is measured.
---@param location? string Name of the location at which the pressure is measured.
function PSEUDOATC:ReportWeather(GID, UID, position, location) end

---Report airport radio information.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
---@param position? COORDINATE Coordinate of the airport.
---@param location? string Name of the airport.
function PSEUDOATC:ReportRadios(GID, UID, position, location) end

---Report absolute bearing and range from player unit to airport.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
---@param position? COORDINATE Coordinates at which the pressure is measured.
---@param location? string Name of the location at which the pressure is measured.
function PSEUDOATC:ReportBR(GID, UID, position, location) end

---Report altitude above ground level of player unit.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
---@param dt? number (Optional) Duration the message is displayed.
---@param _clear? boolean (Optional) Clear previouse messages.
---@return number # Altitude above ground.
function PSEUDOATC:ReportHeight(GID, UID, dt, _clear) end

---Toggle report altitude reporting on/off.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:AltidudeTimerToggle(GID, UID) end

---Start altitude reporting scheduler.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:AltitudeTimeStart(GID, UID) end

---Stop/destroy DCS scheduler function for reporting altitude.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:AltitudeTimerStop(GID, UID) end

---Create list of nearby airports sorted by distance to player unit.
---@param GID? number Group id of player unit.
---@param UID? number Unit id of player.
function PSEUDOATC:LocalAirports(GID, UID) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param _unitName? string Name of the player unit.
---@return UNIT # Unit of player.
---@return string # Name of the player.
---@return nil # If player does not exist.
function PSEUDOATC:_GetPlayerUnitAndName(_unitName) end

---Display message to group.
---@param _unit? UNIT Player unit.
---@param _text? string Message text.
---@param _time? number Duration how long the message is displayed.
---@param _clear? boolean Clear up old messages.
function PSEUDOATC:_DisplayMessageToGroup(_unit, _text, _time, _clear) end

---Returns a string which consits of this callsign and the player name.
---@param unitname? string Name of the player unit.
function PSEUDOATC:_myname(unitname) end

---Returns a string which consits of this callsign and the player name.
---@param path? string Path to map data, e.g. `[[<DCS_Install_Directory>\Mods\terrains\<Map_Name>\Radio.lua]]` (replace with correct path). Needs `lfs` and `io` to be desanitized in the `MissionScripting.lua` in `<DCS_Install_Directory>\Scripts`
---@return PSEUDOATC # self
function PSEUDOATC:SetUsingRadioInformationFromMap(path) end
