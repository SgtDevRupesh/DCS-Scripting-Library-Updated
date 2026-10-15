---@meta

---@class RANGE.Soundfile
---@field filename string Name of the file
---@field duration number Duration in seconds.

---@class RANGE.StrafeResult
---@field player string Player name.
---@field airframe string Aircraft type of player.
---@field time number Time via timer.getAbsTime() in seconds of impact.
---@field date string OS date.
---@field name string Name of the target pit.
---@field roundsFired number Number of rounds fired.
---@field roundsHit number Number of rounds that hit the target.
---@field strafeAccuracy number Accuracy of the run in percent.
---@field clock string Time of the run.
---@field rangename string Name of the range.
---@field invalid boolean Invalid pass.
---@field player string Player name.
---@field airframe string Aircraft type of player.
---@field time number Time via timer.getAbsTime() in seconds of impact.
---@field date string OS date.

---@class RANGE.BombResult
---@field name string Name of closest target.
---@field distance number Distance in meters.
---@field radial number Radial in degrees.
---@field weapon string Name of the weapon.
---@field quality string Hit quality.
---@field player string Player name.
---@field airframe string Aircraft type of player.
---@field time number Time via timer.getAbsTime() in seconds of impact.
---@field date string OS date.
---@field attackHdg number Attack heading in degrees.
---@field attackVel number Attack velocity in knots.
---@field attackAlt number Attack altitude in feet.
---@field clock string Time of the run.
---@field rangename string Name of the range.

---@class RANGE.StrafeStatus
---@field hits number Number of hits on target.
---@field time number Number of times.
---@field ammo number Amount of ammo.
---@field pastfoulline boolean If `true`, player passed foul line. Invalid pass.
---@field zone RANGE.StrafeTarget Strafe target.

---@class RANGE.StrafeTarget
---@field name string Name of the unit.
---@field polygon ZONE_POLYGON Polygon zone.
---@field coordinate COORDINATE Center coordinate of the pit.
---@field goodPass number Number of hits for a good pass.
---@field targets table Table of target units.
---@field foulline number Foul line
---@field smokepoints number Number of smoke points.
---@field heading number Heading of pit.

---@class RANGE.BombTarget
---@field name string Name of unit.
---@field target UNIT Target unit.
---@field coordinate COORDINATE Coordinate of the target.
---@field goodhitrange number Range in meters for a good hit.
---@field move boolean If true, unit move randomly.
---@field speed number Speed of unit.
---@field type RANGE.TargetType Type of target.

---@class RANGE.PlayerData
---@field smokebombimpact boolean Smoke bomb impact points.
---@field flaredirecthits boolean Flare when player directly hits a target.
---@field smokecolor number Color of smoke.
---@field flarecolor number Color of flares.
---@field messages boolean Display info messages.
---@field client CLIENT Client object of player.
---@field unitname string Name of player aircraft unit.
---@field unit UNIT Player unit.
---@field playername string Name of player.
---@field airframe string Aircraft type name.
---@field inzone boolean If true, player is inside the range zone.
---@field targeton boolean Target on.

---RANGE class
---@class RANGE : FSM
---@field ClassName string Name of the Class.
---@field Debug boolean If true, debug info is sent as messages on the screen.
---@field verbose boolean Verbosity level. Higher means more output to DCS log file.
---@field lid string String id of range for output in DCS log.
---@field rangename string Name of the range.
---@field location COORDINATE Coordinate of the range location.
---@field rangeradius number Radius of range defining its total size for e.g. smoking bomb impact points and sending radio messages. Default 5 km.
---@field rangezone ZONE MOOSE zone object of the range. For example, no bomb impacts are smoked if bombs fall outside of the range zone.
---@field strafeTargets table Table of strafing targets.
---@field bombingTargets table Table of targets to bomb.
---@field nbombtargets number Number of bombing targets.
---@field nstrafetargets number Number of strafing targets.
---@field messages boolean Globally enable/disable all messages to players.
---@field MenuAddedTo table Table for monitoring which players already got an F10 menu.
---@field planes table Table for administration.
---@field strafeStatus table Table containing the current strafing target a player as assigned to.
---@field strafePlayerResults table Table containing the strafing results of each player.
---@field bombPlayerResults table Table containing the bombing results of each player.
---@field PlayerSettings table Individual player settings.
---@field dtBombtrack number Time step [sec] used for tracking released bomb/rocket positions. Default 0.005 seconds.
---@field BombtrackThreshold number Bombs/rockets/missiles are only tracked if player-range distance is smaller than this threshold [m]. Default 25000 m.
---@field Tmsg number Time [sec] messages to players are displayed. Default 30 sec.
---@field examinergroupname string Name of the examiner group which should get all messages.
---@field examinerexclusive boolean If true, only the examiner gets messages. If false, clients and examiner get messages.
---@field strafemaxalt number Maximum altitude in meters AGL for registering for a strafe run. Default is 914 m = 3000 ft.
---@field ndisplayresult number Number of (player) results that a displayed. Default is 10.
---@field BombSmokeColor SMOKECOLOR Color id used for smoking bomb targets.
---@field StrafeSmokeColor SMOKECOLOR Color id used to smoke strafe targets.
---@field StrafePitSmokeColor SMOKECOLOR Color id used to smoke strafe pit approach boxes.
---@field illuminationminalt number Minimum altitude in meters AGL at which illumination bombs are fired. Default is 500 m.
---@field illuminationmaxalt number Maximum altitude in meters AGL at which illumination bombs are fired. Default is 1000 m.
---@field scorebombdistance number Distance from closest target up to which bomb hits are counted. Default 1000 m.
---@field TdelaySmoke number Time delay in seconds between impact of bomb and starting the smoke. Default 3 seconds.
---@field trackbombs boolean If true (default), all bomb types are tracked and impact point to closest bombing target is evaluated.
---@field trackrockets boolean If true (default), all rocket types are tracked and impact point to closest bombing target is evaluated.
---@field trackmissiles boolean If true (default), all missile types are tracked and impact point to closest bombing target is evaluated.
---@field defaultsmokebomb boolean If true, initialize player settings to smoke bomb.
---@field autosave boolean If true, automatically save results every X seconds.
---@field instructorfreq number Frequency on which the range control transmitts.
---@field instructor RADIOQUEUE Instructor radio queue.
---@field rangecontrolfreq number Frequency on which the range control transmitts.
---@field rangecontrol RADIOQUEUE Range control radio queue.
---@field rangecontrolrelayname string Name of relay unit.
---@field instructorrelayname string Name of relay unit.
---@field soundpath string Path inside miz file where the sound files are located. Default is "Range Soundfiles/".
---@field targetsheet boolean If true, players can save their target sheets. Rangeboss will not work if targetsheets do not save.
---@field targetpath string Path where to save the target sheets.
---@field targetprefix string File prefix for target sheet files.
---@field controlmsrs MSRS SRS wrapper for range controller.
---@field controlsrsQ MSRSQUEUE SRS queue for range controller.
---@field instructmsrs MSRS SRS wrapper for range instructor.
---@field instructsrsQ MSRSQUEUE SRS queue for range instructor.
---@field Coalition number Coalition side for the menu, if any.
---@field menuF10root MENU_MISSION Specific user defined root F10 menu.
---@field ceilingaltitude number Range ceiling altitude in ft MSL.  Aircraft above this altitude are not considered to be in the range. Default is 20000 ft.
---@field ceilingenabled boolean Range has a ceiling and is not unlimited.  Default is false.
RANGE = {
  ClassName = "RANGE",
  Debug = false,
  verbose = 0,
  id = nil,
  rangename = nil,
  location = nil,
  messages = true,
  rangeradius = 5000,
  rangezone = nil,
  strafeTargets = {},
  bombingTargets = {},
  nbombtargets = 0,
  nstrafetargets = 0,
  MenuAddedTo = {},
  planes = {},
  strafeStatus = {},
  strafePlayerResults = {},
  bombPlayerResults = {},
  PlayerSettings = {},
  dtBombtrack = 0.005,
  BombtrackThreshold = 25000,
  Tmsg = 30,
  examinergroupname = nil,
  examinerexclusive = nil,
  strafemaxalt = 914,
  ndisplayresult = 10,
  BombSmokeColor = SMOKECOLOR.Red,
  StrafeSmokeColor = SMOKECOLOR.Green,
  StrafePitSmokeColor = SMOKECOLOR.White,
  illuminationminalt = 500,
  illuminationmaxalt = 1000,
  scorebombdistance = 1000,
  TdelaySmoke = 3.0,
  trackbombs = true,
  trackrockets = true,
  trackmissiles = true,
  defaultsmokebomb = true,
  autosave = false,
  instructorfreq = nil,
  instructor = nil,
  rangecontrolfreq = nil,
  rangecontrol = nil,
  soundpath = "Range Soundfiles/",
  targetsheet = nil,
  targetpath = nil,
  targetprefix = nil,
  Coalition = nil,
  ceilingaltitude = 20000,
  ceilingenabled = false,
  }

---Default range parameters.
---@class RANGE.Defaults
RANGE.Defaults = {
  goodhitrange = 25,
  strafemaxalt = 914,
  dtBombtrack = 0.005,
  Tmsg = 30,
  ndisplayresult = 10,
  rangeradius = 5000,
  TdelaySmoke = 3.0,
  boxlength = 3000,
  boxwidth = 300,
  goodpass = 20,
  foulline = 610
}

---Target type, i.e. unit, static, or coordinate.
---@class RANGE.TargetType
---@field UNIT string Target is a unitobject.
---@field STATIC string Target is a static object.
---@field COORD string Target is a coordinate.
---@field SCENERY string Target is a scenery object.
RANGE.TargetType = {
  UNIT = "Unit",
  STATIC = "Static",
  COORD = "Coordinate",
  SCENERY = "Scenery"
}

---Sound files.
---@class RANGE.Sound
---@field RC0 RANGE.Soundfile
---@field RC1 RANGE.Soundfile
---@field RC2 RANGE.Soundfile
---@field RC3 RANGE.Soundfile
---@field RC4 RANGE.Soundfile
---@field RC5 RANGE.Soundfile
---@field RC6 RANGE.Soundfile
---@field RC7 RANGE.Soundfile
---@field RC8 RANGE.Soundfile
---@field RC9 RANGE.Soundfile
---@field RCAccuracy RANGE.Soundfile
---@field RCDegrees RANGE.Soundfile
---@field RCExcellentHit RANGE.Soundfile
---@field RCExcellentPass RANGE.Soundfile
---@field RCFeet RANGE.Soundfile
---@field RCFor RANGE.Soundfile
---@field RCGoodHit RANGE.Soundfile
---@field RCGoodPass RANGE.Soundfile
---@field RCHitsOnTarget RANGE.Soundfile
---@field RCImpact RANGE.Soundfile
---@field RCIneffectiveHit RANGE.Soundfile
---@field RCIneffectivePass RANGE.Soundfile
---@field RCInvalidHit RANGE.Soundfile
---@field RCLeftStrafePitTooQuickly RANGE.Soundfile
---@field RCPercent RANGE.Soundfile
---@field RCPoorHit RANGE.Soundfile
---@field RCPoorPass RANGE.Soundfile
---@field RCRollingInOnStrafeTarget RANGE.Soundfile
---@field RCTotalRoundsFired RANGE.Soundfile
---@field RCWeaponImpactedTooFar RANGE.Soundfile
---@field IR0 RANGE.Soundfile
---@field IR1 RANGE.Soundfile
---@field IR2 RANGE.Soundfile
---@field IR3 RANGE.Soundfile
---@field IR4 RANGE.Soundfile
---@field IR5 RANGE.Soundfile
---@field IR6 RANGE.Soundfile
---@field IR7 RANGE.Soundfile
---@field IR8 RANGE.Soundfile
---@field IR9 RANGE.Soundfile
---@field IRDecimal RANGE.Soundfile
---@field IRMegaHertz RANGE.Soundfile
---@field IREnterRange RANGE.Soundfile
---@field IRExitRange RANGE.Soundfile
RANGE.Sound = {
  RC0 = { filename = "RC-0.ogg", duration = 0.60 },
  RC1 = { filename = "RC-1.ogg", duration = 0.47 },
  RC2 = { filename = "RC-2.ogg", duration = 0.43 },
  RC3 = { filename = "RC-3.ogg", duration = 0.50 },
  RC4 = { filename = "RC-4.ogg", duration = 0.58 },
  RC5 = { filename = "RC-5.ogg", duration = 0.54 },
  RC6 = { filename = "RC-6.ogg", duration = 0.61 },
  RC7 = { filename = "RC-7.ogg", duration = 0.53 },
  RC8 = { filename = "RC-8.ogg", duration = 0.34 },
  RC9 = { filename = "RC-9.ogg", duration = 0.54 },
  RCAccuracy = { filename = "RC-Accuracy.ogg", duration = 0.67 },
  RCDegrees = { filename = "RC-Degrees.ogg", duration = 0.59 },
  RCExcellentHit = { filename = "RC-ExcellentHit.ogg", duration = 0.76 },
  RCExcellentPass = { filename = "RC-ExcellentPass.ogg", duration = 0.89 },
  RCFeet = { filename = "RC-Feet.ogg", duration = 0.49 },
  RCFor = { filename = "RC-For.ogg", duration = 0.64 },
  RCGoodHit = { filename = "RC-GoodHit.ogg", duration = 0.52 },
  RCGoodPass = { filename = "RC-GoodPass.ogg", duration = 0.62 },
  RCHitsOnTarget = { filename = "RC-HitsOnTarget.ogg", duration = 0.88 },
  RCImpact = { filename = "RC-Impact.ogg", duration = 0.61 },
  RCIneffectiveHit = { filename = "RC-IneffectiveHit.ogg", duration = 0.86 },
  RCIneffectivePass = { filename = "RC-IneffectivePass.ogg", duration = 0.99 },
  RCInvalidHit = { filename = "RC-InvalidHit.ogg", duration = 2.97 },
  RCLeftStrafePitTooQuickly = { filename = "RC-LeftStrafePitTooQuickly.ogg", duration = 3.09 },
  RCPercent = { filename = "RC-Percent.ogg", duration = 0.56 },
  RCPoorHit = { filename = "RC-PoorHit.ogg", duration = 0.54 },
  RCPoorPass = { filename = "RC-PoorPass.ogg", duration = 0.68 },
  RCRollingInOnStrafeTarget = { filename = "RC-RollingInOnStrafeTarget.ogg", duration = 1.38 },
  RCTotalRoundsFired = { filename = "RC-TotalRoundsFired.ogg", duration = 1.22 },
  RCWeaponImpactedTooFar = { filename = "RC-WeaponImpactedTooFar.ogg", duration = 3.73 },
  IR0 = { filename = "IR-0.ogg", duration = 0.55 },
  IR1 = { filename = "IR-1.ogg", duration = 0.41 },
  IR2 = { filename = "IR-2.ogg", duration = 0.37 },
  IR3 = { filename = "IR-3.ogg", duration = 0.41 },
  IR4 = { filename = "IR-4.ogg", duration = 0.37 },
  IR5 = { filename = "IR-5.ogg", duration = 0.43 },
  IR6 = { filename = "IR-6.ogg", duration = 0.55 },
  IR7 = { filename = "IR-7.ogg", duration = 0.43 },
  IR8 = { filename = "IR-8.ogg", duration = 0.38 },
  IR9 = { filename = "IR-9.ogg", duration = 0.55 },
  IRDecimal = { filename = "IR-Decimal.ogg", duration = 0.54 },
  IRMegaHertz = { filename = "IR-MegaHertz.ogg", duration = 0.87 },
  IREnterRange = { filename = "IR-EnterRange.ogg", duration = 4.83 },
  IRExitRange = { filename = "IR-ExitRange.ogg", duration = 3.10 },
}

---Global list of all defined range names.
RANGE.Names = {}

---Main radio menu on group level.
RANGE.MenuF10 = {}

---Range script version.
RANGE.version = "2.8.1"

---RANGE contructor. Creates a new RANGE object.
---@param RangeName? string Name of the range. Has to be unique. Will we used to create F10 menu items etc.
---@param Coalition? number (optional) Coalition of the range, if any, e.g. coalition.side.BLUE.
---@return RANGE # RANGE object.
function RANGE:New(RangeName, Coalition) end

---Initializes number of targets and location of the range. Starts the event handlers.
function RANGE:onafterStart() end

---Set the root F10 menu under which the range F10 menu is created.
---@param menu? MENU_MISSION The root F10 menu.
---@return RANGE # self
function RANGE:SetMenuRoot(menu) end

---Set maximal strafing altitude. Player entering a strafe pit above that altitude are not registered for a valid pass.
---@param maxalt? number (Optional) Maximum altitude in meters AGL. Default is 914 m = 3000 ft.
---@return RANGE # self
function RANGE:SetMaxStrafeAlt(maxalt) end

---Set time interval for tracking bombs. A smaller time step increases accuracy but needs more CPU time.
---@param dt? number (Optional) Time interval in seconds. Default is 0.005 s.
---@return RANGE # self
function RANGE:SetBombtrackTimestep(dt) end

---Set time how long (most) messages are displayed.
---@param time? number (Optional) Time in seconds. Default is 30 s.
---@return RANGE # self
function RANGE:SetMessageTimeDuration(time) end

---Automatically save player results to disc.
---@return RANGE # self
function RANGE:SetAutosaveOn() end

---Switch off auto save player results.
---@return RANGE # self
function RANGE:SetAutosaveOff() end

---Enable saving of player's target sheets and specify an optional directory path.
---@param path? string (Optional) Path where to save the target sheets.
---@param prefix? string (Optional) Prefix for target sheet files. File name will be saved as *prefix_aircrafttype-0001.csv*, *prefix_aircrafttype-0002.csv*, etc.
---@return RANGE # self
function RANGE:SetTargetSheet(path, prefix) end

---Set FunkMan socket. Bombing and strafing results will be send to your Discord bot.
---**Requires running FunkMan program**.
---@param Port? number (Optional) Port. Default `10042`.
---@param Host? string (Optional) Host. Default "127.0.0.1".
---@return RANGE # self
function RANGE:SetFunkManOn(Port, Host) end

---Set messages to examiner. The examiner will receive messages from all clients.
---@param examinergroupname? string Name of the group of the examiner.
---@param exclusively? boolean If true, messages are send exclusively to the examiner, i.e. not to the clients.
---@return RANGE # self
function RANGE:SetMessageToExaminer(examinergroupname, exclusively) end

---Set max number of player results that are displayed.
---@param nmax? number (Optional) Number of results. Default is 10.
---@return RANGE # self
function RANGE:SetDisplayedMaxPlayerResults(nmax) end

---Set range radius. Defines the area in which e.g. bomb impacts are smoked.
---@param radius? number (Optional) Radius in km. Default 5 km.
---@return RANGE # self
function RANGE:SetRangeRadius(radius) end

---Set player setting whether bomb impact points are smoked or not.
---@param switch? boolean (Optional) If true nor nil default is to smoke impact points of bombs.
---@return RANGE # self
function RANGE:SetDefaultPlayerSmokeBomb(switch) end

---Set bomb track threshold distance. Bombs/rockets/missiles are only tracked if player-range distance is less than this distance. Default 25 km.
---@param distance? number (Optional) Threshold distance in km. Default 25 km.
---@return RANGE # self
function RANGE:SetBombtrackThreshold(distance) end

---Set range location. If this is not done, one (random) unit position of the range is used to determine the location of the range.
---The range location determines the position at which the weather data is evaluated.
---@param coordinate? COORDINATE Coordinate of the range.
---@return RANGE # self
function RANGE:SetRangeLocation(coordinate) end

---Set range zone. For example, no bomb impact points are smoked if a bomb falls outside of this zone.
---If a zone is not explicitly specified, the range zone is determined by its location and radius.
---@param zone? ZONE MOOSE zone defining the range perimeters.
---@return RANGE # self
function RANGE:SetRangeZone(zone) end

---Set range ceiling altitude in feet MSL.
---@param altitude? number (optional) Ceiling altitude of the range in ft MSL. Default 20000ft MSL
---@return RANGE # self
function RANGE:SetRangeCeiling(altitude) end

---Enable range ceiling. Aircraft must be below the ceiling altitude to be considered in the range zone.
---@param enabled? boolean (Optional) True if you would like to enable the ceiling check.  If no value give, will Default to false.
---@return RANGE # self
function RANGE:EnableRangeCeiling(enabled) end

---Set smoke color for marking bomb targets. By default bomb targets are marked by red smoke.
---@param colorid? SMOKECOLOR (Optional) Color id. Default `SMOKECOLOR.Red`.
---@return RANGE # self
function RANGE:SetBombTargetSmokeColor(colorid) end

---Set score bomb distance.
---@param distance? number (Optional) Distance in meters. Default 1000 m.
---@return RANGE # self
function RANGE:SetScoreBombDistance(distance) end

---Set smoke color for marking strafe targets. By default strafe targets are marked by green smoke.
---@param colorid? SMOKECOLOR (Optional) Color id. Default `SMOKECOLOR.Green`.
---@return RANGE # self
function RANGE:SetStrafeTargetSmokeColor(colorid) end

---Set smoke color for marking strafe pit approach boxes. By default strafe pit boxes are marked by white smoke.
---@param colorid? SMOKECOLOR (Optional) Color id. Default `SMOKECOLOR.White`.
---@return RANGE # self
function RANGE:SetStrafePitSmokeColor(colorid) end

---Set time delay between bomb impact and starting to smoke the impact point.
---@param delay? number (Optional) Time delay in seconds. Default is 3 seconds.
---@return RANGE # self
function RANGE:SetSmokeTimeDelay(delay) end

---Enable debug modus.
---@return RANGE # self
function RANGE:DebugON() end

---Disable debug modus.
---@return RANGE # self
function RANGE:DebugOFF() end

---Disable ALL messages to players.
---@return RANGE # self
function RANGE:SetMessagesOFF() end

---Enable messages to players. This is the default
---@return RANGE # self
function RANGE:SetMessagesON() end

---Enables tracking of all bomb types. Note that this is the default setting.
---@return RANGE # self
function RANGE:TrackBombsON() end

---Disables tracking of all bomb types.
---@return RANGE # self
function RANGE:TrackBombsOFF() end

---Enables tracking of all rocket types. Note that this is the default setting.
---@return RANGE # self
function RANGE:TrackRocketsON() end

---Disables tracking of all rocket types.
---@return RANGE # self
function RANGE:TrackRocketsOFF() end

---Enables tracking of all missile types. Note that this is the default setting.
---@return RANGE # self
function RANGE:TrackMissilesON() end

---Disables tracking of all missile types.
---@return RANGE # self
function RANGE:TrackMissilesOFF() end

---Use SRS Simple-Text-To-Speech for transmissions. No sound files necessary.
---@param PathToSRS? string Path to SRS directory.
---@param Port? number (Optional) SRS port. Default 5002.
---@param Coalition? number (Optional) Coalition side, e.g. `coalition.side.BLUE` or `coalition.side.RED`. Default `coalition.side.BLUE`.
---@param Frequency? number (Optional) Frequency to use. Default is 256 MHz for range control and 305 MHz for instructor. If given, both control and instructor get this frequency.
---@param Modulation? number (Optional) Modulation to use, defaults to radio.modulation.AM
---@param Volume? number (Optional) Volume, between 0.0 and 1.0. Defaults to 1.0
---@param PathToGoogleKey? string Path to Google TTS credentials.
---@param Provider? string (Optional) TTS Provider to be used.
---@param Backend? string (Optional) TTS Backend to be used.
---@return RANGE # self
function RANGE:SetSRS(PathToSRS, Port, Coalition, Frequency, Modulation, Volume, PathToGoogleKey, Provider, Backend) end

---(SRS) Set range control frequency and voice. Use `RANGE:SetSRS()` once first before using this function.
---@param frequency? number (Optional) Frequency in MHz. Default 256 MHz.
---@param modulation? number (Optional) Modulation, defaults to radio.modulation.AM.
---@param voice? string Voice.
---@param culture? string (Optional) Culture, defaults to "en-US".
---@param gender? string (Optional) Gender, defaults to "female".
---@param relayunitname? string Name of the unit used for transmission location.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return RANGE # self
function RANGE:SetSRSRangeControl(frequency, modulation, voice, culture, gender, relayunitname, Speaker) end

---(SRS) Set range instructor frequency and voice. Use `RANGE:SetSRS()` once first before using this function.
---@param frequency? number (Optional) Frequency in MHz. Default 305 MHz.
---@param modulation? number (Optional) Modulation, defaults to radio.modulation.AM.
---@param voice? string Voice.
---@param culture? string (Optional) Culture, defaults to "en-US".
---@param gender? string (Optional) Gender, defaults to "male".
---@param relayunitname? string Name of the unit used for transmission location.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return RANGE # self
function RANGE:SetSRSRangeInstructor(frequency, modulation, voice, culture, gender, relayunitname, Speaker) end

---Enable range control and set frequency (non-SRS).
---@param frequency? number (Optional) Frequency in MHz. Default 256 MHz.
---@param relayunitname? string Name of the unit used for transmission.
---@return RANGE # self
function RANGE:SetRangeControl(frequency, relayunitname) end

---Enable instructor radio and set frequency (non-SRS).
---@param frequency? number (Optional) Frequency in MHz. Default 305 MHz.
---@param relayunitname? string Name of the unit used for transmission.
---@return RANGE # self
function RANGE:SetInstructorRadio(frequency, relayunitname) end

---Set sound files folder within miz file.
---@param path? string (Optional) Path for sound files. Default "Range Soundfiles/". Mind the slash "/" at the end!
---@return RANGE # self
function RANGE:SetSoundfilesPath(path) end

---Set the path to the csv file that contains information about the used sound files.
---The parameter file has to be located on your local disk (**not** inside the miz file).
---@param csvfile? string Full path to the csv file on your local disk.
---@return RANGE # self
function RANGE:SetSoundfilesInfo(csvfile) end

---Add new strafe pit. For a strafe pit, hits from guns are counted. One pit can consist of several units.
---A strafe run approach is only valid if the player enters via a zone in front of the pit, which is defined by boxlength, boxwidth, and heading.
---Furthermore, the player must not be too high and fly in the direction of the pit to make a valid target apporoach.
---@param targetnames? table Single or multiple (Table) unit or static names defining the strafe targets. The first target in the list determines the approach box origin (heading and box).
---@param boxlength? number (Optional) Length of the approach box in meters. Default is 3000 m.
---@param boxwidth? number (Optional) Width of the approach box in meters. Default is 300 m.
---@param heading? number (Optional) Approach box heading in degrees (originating FROM the target). Default is the heading set in the ME for the first target unit
---@param inverseheading? boolean (Optional) Use inverse heading (heading --> heading - 180 Degrees). Default is false.
---@param goodpass? number (Optional) Number of hits for a "good" strafing pass. Default is 20.
---@param foulline? number (Optional) Foul line distance. Hits from closer than this distance are not counted. Default is 610 m = 2000 ft. Set to 0 for no foul line.
---@return RANGE # self
function RANGE:AddStrafePit(targetnames, boxlength, boxwidth, heading, inverseheading, goodpass, foulline) end

---Add all units of a group as one new strafe target pit.
---For a strafe pit, hits from guns are counted. One pit can consist of several units.
---Note, an approach is only valid, if the player enters via a zone in front of the pit, which defined by boxlength and boxheading.
---Furthermore, the player must not be too high and fly in the direction of the pit to make a valid target apporoach.
---@param group? GROUP MOOSE group of unit names defining the strafe target pit. The first unit in the group determines the approach zone (heading and box).
---@param boxlength? number (Optional) Length of the approach box in meters. Default is 3000 m.
---@param boxwidth? number (Optional) Width of the approach box in meters. Default is 300 m.
---@param heading? number (Optional) Approach heading in Degrees. Default is heading of the unit as defined in the mission editor.
---@param inverseheading? boolean (Optional) Take inverse heading (heading --> heading - 180 Degrees). Default is false.
---@param goodpass? number (Optional) Number of hits for a "good" strafing pass. Default is 20.
---@param foulline? number (Optional) Foul line distance. Hits from closer than this distance are not counted. Default 610 m = 2000 ft. Set to 0 for no foul line.
---@return RANGE # self
function RANGE:AddStrafePitGroup(group, boxlength, boxwidth, heading, inverseheading, goodpass, foulline) end

---Add bombing target(s) to range.
---@param targetnames? table Single or multiple (Table) names of unit or static objects serving as bomb targets.
---@param goodhitrange? number (Optional) Max distance from target unit (in meters) which is considered as a good hit. Default is 25 m.
---@param randommove? boolean (Optional) If true, unit will move randomly within the range. Default is false.
---@return RANGE # self
function RANGE:AddBombingTargets(targetnames, goodhitrange, randommove) end

---Add a unit or static object as bombing target.
---@param unit? POSITIONABLE Positionable (unit or static) of the bombing target.
---@param goodhitrange? number Max distance from unit which is considered as a good hit.
---@param randommove? boolean (Optional) If true, unit will move randomly within the range. Default is false.
---@return RANGE # self
function RANGE:AddBombingTargetUnit(unit, goodhitrange, randommove) end

---Add a coordinate of a bombing target. This
---@param coord? COORDINATE The coordinate.
---@param name? string Name of target.
---@param goodhitrange? number Max distance from unit which is considered as a good hit.
---@return RANGE # self
function RANGE:AddBombingTargetCoordinate(coord, name, goodhitrange) end

---Add a scenery object as bombing target.
---@param scenery? SCENERY Scenary object.
---@param goodhitrange? number Max distance from unit which is considered as a good hit.
---@return RANGE # self
function RANGE:AddBombingTargetScenery(scenery, goodhitrange) end

---Add all units of a group as bombing targets.
---@param group? GROUP Group of bombing targets. Can also be given as group name.
---@param goodhitrange? number Max distance from unit which is considered as a good hit.
---@param randommove? boolean (Optional) If true, unit will move randomly within the range. Default is false.
---@return RANGE # self
function RANGE:AddBombingTargetGroup(group, goodhitrange, randommove) end

---Measures the foule line distance between two unit or static objects.
---@param namepit? string Name of the strafe pit target object.
---@param namefoulline? string Name of the fould line distance marker object.
---@return number # Foul line distance in meters.
function RANGE:GetFoullineDistance(namepit, namefoulline) end

---Range event handler for event birth.
---@param EventData? EVENTDATA
function RANGE:OnEventBirth(EventData) end

---Range event handler for event hit.
---@param EventData? EVENTDATA
function RANGE:OnEventHit(EventData) end

---Function called on impact of a tracked weapon.
---@param weapon? WEAPON The weapon object.
---@param self RANGE RANGE object.
---@param playerData? RANGE.PlayerData|number|string Player data table.
---@param attackHdg? number Attack heading.
---@param attackAlt? number Attack altitude.
---@param attackVel? number Attack velocity.
function RANGE._OnImpact(weapon, self, playerData, attackHdg, attackAlt, attackVel) end

---Range event handler for event shot (when a unit releases a rocket or bomb (but not a fast firing gun).
---@param EventData? EVENTDATA
function RANGE:OnEventShot(EventData) end

---Check spawn queue and spawn aircraft if necessary.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RANGE:onafterStatus(From, Event, To) end

---Function called after player enters the range zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Player data.
function RANGE:onafterEnterRange(From, Event, To, player) end

---Function called after player leaves the range zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Player data.
function RANGE:onafterExitRange(From, Event, To, player) end

---Function called after bomb impact on range.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param result? RANGE.BombResult|number|string Result of bomb impact.
---@param player? RANGE.PlayerData|number|string Player data table.
function RANGE:onafterImpact(From, Event, To, result, player) end

---Function called after strafing run.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Player data table.
---@param result? RANGE.StrafeResult|number|string Result of run.
function RANGE:onafterStrafeResult(From, Event, To, player, result) end

---Function called before save event. Checks that io and lfs are desanitized.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RANGE:onbeforeSave(From, Event, To) end

---Function called after save.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RANGE:onafterSave(From, Event, To) end

---Function called before save event. Checks that io and lfs are desanitized.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RANGE:onbeforeLoad(From, Event, To) end

---On after "Load" event. Loads results of all players from file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function RANGE:onafterLoad(From, Event, To) end

---Save target sheet.
---@param _playername? string Player name.
---@param result? RANGE.StrafeResult|number|string Results table.
function RANGE:_SaveTargetSheet(_playername, result) end

---Display top 10 stafing results of a specific player.
---@param _unitName? string Name of the player unit.
function RANGE:_DisplayMyStrafePitResults(_unitName) end

---Display top 10 strafing results of all players.
---@param _unitName? string Name fo the player unit.
function RANGE:_DisplayStrafePitResults(_unitName) end

---Display top 10 bombing run results of specific player.
---@param _unitName? string Name of the player unit.
function RANGE:_DisplayMyBombingResults(_unitName) end

---Display best bombing results of top 10 players.
---@param _unitName? string Name of player unit.
function RANGE:_DisplayBombingResults(_unitName) end

---Report information like bearing and range from player unit to range.
---@param _unitname? string Name of the player unit.
function RANGE:_DisplayRangeInfo(_unitname) end

---Display bombing target locations to player.
---@param _unitname? string Name of the player unit.
function RANGE:_DisplayBombTargets(_unitname) end

---Display pit location and heading to player.
---@param _unitname? string Name of the player unit.
function RANGE:_DisplayStrafePits(_unitname) end

---Report weather conditions at range. Temperature, QFE pressure and wind data.
---@param _unitname? string Name of the player unit.
function RANGE:_DisplayRangeWeather(_unitname) end

---Check status of players.
function RANGE:_CheckPlayers() end

---Check if player is inside a strafing zone. If he is, we start looking for hits. If he was and left the zone again, the result is stored.
---@param _unitName? string Name of player unit.
function RANGE:_CheckInZone(_unitName) end

---Add menu commands for player.
---@param _unitName? string Name of player unit.
function RANGE:_AddF10Commands(_unitName) end

---Get the number of shells a unit currently has.
---@param target? RANGE.BombTarget|number|string Bomb target data.
---@return COORDINATE # Target coordinate.
function RANGE:_GetBombTargetCoordinate(target) end

---Get the number of shells a unit currently has.
---@param unitname? string Name of the player unit.
---@return Number # of shells left
function RANGE:_GetAmmo(unitname) end

---Mark targets on F10 map.
---@param _unitName? string Name of the player unit.
function RANGE:_MarkTargetsOnMap(_unitName) end

---Illuminate targets. Fires illumination bombs at one random bomb and one random strafe target at a random altitude between 400 and 800 m.
---@param _unitName? string (Optional) Name of the player unit.
function RANGE:_IlluminateBombTargets(_unitName) end

---Reset player statistics.
---@param _unitName? string Name of the player unit.
function RANGE:_ResetRangeStats(_unitName) end

---Display message to group.
---@param _unit? UNIT Player unit.
---@param _text? string Message text.
---@param _time? number Duration how long the message is displayed.
---@param _clear? boolean Clear up old messages.
---@param display? boolean If true, display message regardless of player setting "Messages Off".
---@param _togroup? boolean If true, display the message to the group in any case
function RANGE:_DisplayMessageToGroup(_unit, _text, _time, _clear, display, _togroup) end

---Toggle status of smoking bomb impact points.
---@param unitname? string Name of the player unit.
function RANGE:_SmokeBombImpactOnOff(unitname) end

---Toggle status of time delay for smoking bomb impact points
---@param unitname? string Name of the player unit.
function RANGE:_SmokeBombDelayOnOff(unitname) end

---Toggle display messages to player.
---@param unitname? string Name of the player unit.
function RANGE:_MessagesToPlayerOnOff(unitname) end

---Targetsheet saves if player on or off.
---@param _unitname? string Name of the player unit.
function RANGE:_TargetsheetOnOff(_unitname) end

---Toggle status of flaring direct hits of range targets.
---@param unitname? string Name of the player unit.
function RANGE:_FlareDirectHitsOnOff(unitname) end

---Mark bombing targets with smoke.
---@param unitname? string Name of the player unit.
function RANGE:_SmokeBombTargets(unitname) end

---Mark strafing targets with smoke.
---@param unitname? string Name of the player unit.
function RANGE:_SmokeStrafeTargets(unitname) end

---Mark approach boxes of strafe targets with smoke.
---@param unitname? string Name of the player unit.
function RANGE:_SmokeStrafeTargetBoxes(unitname) end

---Sets the smoke color used to smoke players bomb impact points.
---@param _unitName? string Name of the player unit.
---@param color? SMOKECOLOR ID of the smoke color.
function RANGE:_playersmokecolor(_unitName, color) end

---Sets the flare color used when player makes a direct hit on target.
---@param _unitName? string Name of the player unit.
---@param color? FLARECOLOR ID of flare color.
function RANGE:_playerflarecolor(_unitName, color) end

---Converts a smoke color id to text. E.g. SMOKECOLOR.Blue --> "blue".
---@param color? SMOKECOLOR Color Id.
---@return string # Color text.
function RANGE:_smokecolor2text(color) end

---Sets the flare color used to flare players direct target hits.
---@param color? FLARECOLOR Color Id.
---@return string # Color text.
function RANGE:_flarecolor2text(color) end

---Checks if a static object with a certain name exists. It also added it to the MOOSE data base, if it is not already in there.
---@param name? string Name of the potential static object.
---@return boolean # Returns true if a static with this name exists. Retruns false if a unit with this name exists. Returns nil if neither unit or static exist.
function RANGE:_CheckStatic(name) end

---Get max speed of controllable.
---@param controllable? CONTROLLABLE
---@return Maximum # speed in km/h.
function RANGE:_GetSpeed(controllable) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param _unitName? string Name of the player unit.
---@param PlayerName? any
---@return UNIT # Unit of player.
---@return string # Name of the player.
---@return boolean # If true, group has > 1 player in it
function RANGE:_GetPlayerUnitAndName(_unitName, PlayerName) end

---Returns a string which consists of the player name.
---@param unitname? string Name of the player unit.
function RANGE:_myname(unitname) end

---Triggers the FSM event "Start". Starts the RANGE. Initializes parameters and starts event handlers.
function RANGE:Start() end

---Triggers the FSM event "Start" after a delay. Starts the RANGE. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function RANGE:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the RANGE and all its event handlers.
---@param delay? number Delay in seconds.
function RANGE:__Stop(delay) end

---Triggers the FSM event "Status".
function RANGE:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function RANGE:__Status(delay) end

---Triggers the FSM event "Impact".
---@param result? RANGE.BombResult|number|string Data of bombing run.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:Impact(result, player) end

---Triggers the FSM delayed event "Impact".
---@param delay? number Delay in seconds before the function is called.
---@param result? RANGE.BombResult|number|string Data of the bombing run.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:__Impact(delay, result, player) end

---On after "Impact" event user function. Called when a bomb/rocket/missile impacted.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param result? RANGE.BombResult|number|string Data of the bombing run.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:OnAfterImpact(From, Event, To, result, player) end

---Triggers the FSM event "RollingIn".
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
---@param target? RANGE.StrafeTarget|number|string Strafe target.
function RANGE:RollingIn(player, target) end

---On after "RollingIn" event user function. Called when a player rolls in to a strafe taret.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
---@param target? RANGE.StrafeTarget|number|string Strafe target.
function RANGE:OnAfterRollingIn(From, Event, To, player, target) end

---Triggers the FSM event "StrafeResult".
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
---@param result? RANGE.StrafeResult|number|string Data of the strafing run.
function RANGE:StrafeResult(player, result) end

---On after "StrafeResult" event user function. Called when a player finished a strafing run.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
---@param result? RANGE.StrafeResult|number|string Data of the strafing run.
function RANGE:OnAfterStrafeResult(From, Event, To, player, result) end

---Triggers the FSM event "EnterRange".
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:EnterRange(player) end

---Triggers the FSM delayed event "EnterRange".
---@param delay? number Delay in seconds before the function is called.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:__EnterRange(delay, player) end

---On after "EnterRange" event user function. Called when a player enters the range zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:OnAfterEnterRange(From, Event, To, player) end

---Triggers the FSM event "ExitRange".
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:ExitRange(player) end

---Triggers the FSM delayed event "ExitRange".
---@param delay? number Delay in seconds before the function is called.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:__ExitRange(delay, player) end

---On after "ExitRange" event user function. Called when a player leaves the range zone.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param player? RANGE.PlayerData|number|string Data of player settings etc.
function RANGE:OnAfterExitRange(From, Event, To, player) end
