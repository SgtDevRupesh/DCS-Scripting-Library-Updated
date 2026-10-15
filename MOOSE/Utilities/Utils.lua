---@meta

---Smoke color enum `trigger.smokeColor`.
---@class SMOKECOLOR
---@field Green number Green smoke (0)
---@field Red number Red smoke (1)
---@field White number White smoke (2)
---@field Orange number Orange smoke (3)
---@field Blue number Blue smoke (4)
SMOKECOLOR = {}

---Flare colur enum `trigger.flareColor`.
---@class FLARECOLOR
---@field Green number (0)
---@field Red number Red flare (1)
---@field White number White flare (2)
---@field Yellow number Yellow flare (3)
FLARECOLOR = {}

---Big smoke preset enum.
---@class BIGSMOKEPRESET
---@field SmallSmokeAndFire number Small moke and fire (1)
---@field MediumSmokeAndFire number Medium smoke and fire (2)
---@field LargeSmokeAndFire number Large smoke and fire (3)
---@field HugeSmokeAndFire number Huge smoke and fire (4)
---@field SmallSmoke number Small smoke (5)
---@field MediumSmoke number Medium smoke (6)
---@field LargeSmoke number Large smoke (7)
---@field HugeSmoke number Huge smoke (8)
BIGSMOKEPRESET = {
  SmallSmokeAndFire=1,
  MediumSmokeAndFire=2,
  LargeSmokeAndFire=3,
  HugeSmokeAndFire=4,
  SmallSmoke=5,
  MediumSmoke=6,
  LargeSmoke=7,
  HugeSmoke=8,
}

---DCS map as returned by `env.mission.theatre`.
---@class DCSMAP
---@field Caucasus string Caucasus map.
---@field Normandy string Normandy map.
---@field NTTR string Nevada Test and Training Range map.
---@field PersianGulf string Persian Gulf map.
---@field TheChannel string The Channel map.
---@field Syria string Syria map.
---@field MarianaIslands string Mariana Islands map.
---@field Falklands string South Atlantic map.
---@field Sinai string Sinai map.
---@field Kola string Kola map.
---@field Afghanistan string Afghanistan map
---@field Iraq string Iraq map
---@field GermanyCW string Germany Cold War map
DCSMAP = {
  Caucasus="Caucasus",
  NTTR="Nevada",
  Normandy="Normandy",
  PersianGulf="PersianGulf",
  TheChannel="TheChannel",
  Syria="Syria",
  MarianaIslands="MarianaIslands",
  Falklands="Falklands",
  Sinai="SinaiMap",
  Kola="Kola",
  Afghanistan="Afghanistan",
  Iraq="Iraq",
  GermanyCW="GermanyCW",
}

---See [DCS_enum_callsigns](https://wiki.hoggitworld.com/view/DCS_enum_callsigns)
---@class CALLSIGN
CALLSIGN={
  Aircraft={
    Enfield=1,
    Springfield=2,
    Uzi=3,
    Colt=4,
    Dodge=5,
    Ford=6,
    Chevy=7,
    Pontiac=8,
    Hawg=9,
    Boar=10,
    Pig=11,
    Tusk=12,
  },
  AWACS={
    Overlord=1,
    Magic=2,
    Wizard=3,
    Focus=4,
    Darkstar=5,
  },
  Tanker={
    Texaco=1,
    Arco=2,
    Shell=3,
    Navy_One=4,
    Mauler=5,
    Bloodhound=6,
    },
  JTAC={
    Axeman=1,
    Darknight=2,
    Warrior=3,
    Pointer=4,
    Eyeball=5,
    Moonbeam=6,
    Whiplash=7,
    Finger=8,
    Pinpoint=9,
    Ferret=10,
    Shaba=11,
    Playboy=12,
    Hammer=13,
    Jaguar=14,
    Deathstar=15,
    Anvil=16,
    Firefly=17,
    Mantis=18,
    Badger=19,
  },
  FARP={
    London=1,
    Dallas=2,
    Paris=3,
    Moscow=4,
    Berlin=5,
    Rome=6,
    Madrid=7,
    Warsaw=8,
    Dublin=9,
    Perth=10,
  },
  F16={
    Viper=9,
    Venom=10,
    Lobo=11,
    Cowboy=12,
    Python=13,
    Rattler=14,
    Panther=15,
    Wolf=16,
    Weasel=17,
    Wild=18,
    Ninja=19,
    Jedi=20,
  },
  F18={
    Hornet=9,
    Squid=10,
    Ragin=11,
    Roman=12,
    Sting=13,
    Jury=14,
    Jokey=15,
    Ram=16,
    Hawk=17,
    Devil=18,
    Check=19,
    Snake=20,
  },
  F15E={
    Dude=9,
    Thud=10,
    Gunny=11,
    Trek=12,
    Sniper=13,
    Sled=14,
    Best=15,
    Jazz=16,
    Rage=17,
    Tahoe=18,
  },
  B1B={
    Bone=9,
    Dark=10,
    Vader=11
  },
  B52={
    Buff=9,
    Dump=10,
    Kenworth=11,
  },
  TransportAircraft={
    Heavy=9,
    Trash=10,
    Cargo=11,
    Ascot=12,
  },
  AH64={
    Army_Air = 9,
    Apache = 10,
    Crow = 11,
    Sioux = 12,
    Gatling = 13,
    Gunslinger = 14,
    Hammerhead = 15,
    Bootleg = 16,
    Palehorse = 17,
    Carnivor = 18,
    Saber = 19,
  },
  Kiowa = {
    Anvil = 1,
    Azrael = 2,
    BamBam = 3,
    Blackjack = 4,
    Bootleg = 5,
    BurninStogie = 6,
    Chaos = 7,
    CrazyHorse = 8,
    Crusader = 9,
    Darkhorse = 10,
    Eagle = 11,
    Lighthorse = 12,
    Mustang = 13,
    Outcast = 14,
    Palehorse = 15,
    Pegasus = 16,
    Pistol = 17,
    Roughneck = 18,
    Saber = 19,
    Shamus = 20,
    Spur = 21,
    Stetson = 22,
    Wrath = 23,
  },
  Intruder = {
    Raygun = 4,
    Heartless = 5,
    Viceroy = 6,
    Cupcake = 7,
    ["Flying Tiger"] = 8,
    ["Flying Ace"]  = 9,
    Buckeye = 10,
    Goldplate = 11,
    Phoenix = 12,
    Electron = 13,
    Rustler = 14,
    Vixen = 15,
    Jackal = 16,
    Milestone = 17,
    Devil = 18,
  },
} --#CALLSIGN

---Utilities static class.
---@class UTILS
---@field _MarkID number Marker index counter. Running number when marker is added.
UTILS = {
  _MarkID = 1
}

---Function to infer instance of an object
---
---### Examples:
---
---   * UTILS.IsInstanceOf( 'some text', 'string' ) will return true
---   * UTILS.IsInstanceOf( some_function, 'function' ) will return true
---   * UTILS.IsInstanceOf( 10, 'number' ) will return true
---   * UTILS.IsInstanceOf( false, 'boolean' ) will return true
---   * UTILS.IsInstanceOf( nil, 'nil' ) will return true
---
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', ZONE ) will return true
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'ZONE' ) will return true
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'zone' ) will return true
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'BASE' ) will return true
---
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'GROUP' ) will return false
---@param object? any
---@param className? any
---@return boolean
function UTILS.IsInstanceOf(object, className) end

---Deep copy a table. See http://lua-users.org/wiki/CopyTable
---@param object? table The input table.
---@return table # Copy of the input table.
function UTILS.DeepCopy(object) end

---Serialize a given table.
---@param tbl? table Input table.
---@return string # Table as a string.
function UTILS.OneLineSerialize(tbl) end

---Serialize a table to a single line string.
---@param tbl? table table to serialize.
---@return string # string containing serialized table.
function UTILS._OneLineSerialize(tbl) end

---Basic serialize (porting in Slmod's "safestring" basic serialize).
---@param s? string Table to serialize.
function UTILS.BasicSerialize(s) end

---Counts the number of elements in a table.
---@param T? table Table to count
---@return number # Number of elements in the table
function UTILS.TableLength(T) end

---Print a table to log in a nice format
---@param t? table The table to print
---@param indent? number (Optional) Number of indents. Defaults to 0.
---@param noprint? boolean Don't log but return text
---@param maxDepth? number (Optional) Only cycle this deep, defaults to 5.
---@param seen? table (Optional)
---@return string # text Text created on the fly of the log output
function UTILS.PrintTableToLog(t, indent, noprint, maxDepth, seen) end

---Returns table in a easy readable string representation.
---@param tbl? any
---@param loc? any
---@param indent? any
---@param tableshow_tbls? any
---@return Human # readable string representation of given table.
function UTILS.TableShow(tbl, loc, indent, tableshow_tbls) end

---Dumps the global table _G.
---This dumps the global table _G to a file in the DCS\Logs directory.
---This function requires you to disable script sanitization in $DCS_ROOT\Scripts\MissionScripting.lua to access lfs and io libraries.
---@param fname? string File name.
function UTILS.Gdump(fname) end

---Executes the given string.
---borrowed from Slmod
---@param s? string string containing LUA code.
---@return boolean # `true` if successfully executed, `false` otherwise.
function UTILS.DoString(s) end

---@param angle? any
function UTILS.ToDegree(angle) end

---@param angle? any
function UTILS.ToRadian(angle) end

---@param meters? any
function UTILS.MetersToNM(meters) end

---@param kilometers? any
function UTILS.KiloMetersToNM(kilometers) end

---@param meters? any
function UTILS.MetersToSM(meters) end

---@param kilometers? any
function UTILS.KiloMetersToSM(kilometers) end

---@param meters? any
function UTILS.MetersToFeet(meters) end

---@param kilometers? any
function UTILS.KiloMetersToFeet(kilometers) end

---@param NM? any
function UTILS.NMToMeters(NM) end

---@param NM? any
function UTILS.NMToKiloMeters(NM) end

---@param feet? any
function UTILS.FeetToMeters(feet) end

---@param knots? any
function UTILS.KnotsToKmph(knots) end

---@param knots? any
function UTILS.KmphToKnots(knots) end

---@param kmph? any
function UTILS.KmphToMps(kmph) end

---@param mps? any
function UTILS.MpsToKmph(mps) end

---@param miph? any
function UTILS.MiphToMps(miph) end

---Convert meters per second to miles per hour.
---@param mps? number Speed in m/s.
---@return number # Speed in miles per hour.
function UTILS.MpsToMiph(mps) end

---Convert meters per second to knots.
---@param mps? number Speed in m/s.
---@return number # Speed in knots.
function UTILS.MpsToKnots(mps) end

---Convert knots to meters per second.
---@param knots? number Speed in knots.
---@return number # Speed in m/s.
function UTILS.KnotsToMps(knots) end

---Convert temperature from Celsius to Fahrenheit.
---@param Celcius? number Temperature in degrees Celsius.
---@return number # Temperature in degrees Fahrenheit.
function UTILS.CelsiusToFahrenheit(Celcius) end

---Convert pressure from hecto Pascal (hPa) to inches of mercury (inHg).
---@param hPa? number Pressure in hPa.
---@return number # Pressure in inHg.
function UTILS.hPa2inHg(hPa) end

---Convert indicated airspeed (IAS) to true airspeed (TAS) for a given altitude above main sea level.
---The conversion is based on the approximation that TAS is ~2% higher than IAS with every 1000 ft altitude above sea level.
---@param ias? number Indicated air speed in any unit (m/s, km/h, knots, ...)
---@param altitude? number Altitude above main sea level in meters.
---@param oatcorr? number (Optional) Outside air temperature correction factor. Default 0.017.
---@return number # True airspeed in the same unit the IAS has been given.
function UTILS.IasToTas(ias, altitude, oatcorr) end

---Convert true airspeed (TAS) to indicated airspeed (IAS) for a given altitude above main sea level.
---The conversion is based on the approximation that TAS is ~2% higher than IAS with every 1000 ft altitude above sea level.
---@param tas? number True air speed in any unit (m/s, km/h, knots, ...)
---@param altitude? number Altitude above main sea level in meters.
---@param oatcorr? number (Optional) Outside air temperature correction factor. Default 0.017.
---@return number # Indicated airspeed in the same unit the TAS has been given.
function UTILS.TasToIas(tas, altitude, oatcorr) end

---Convert knots to altitude corrected KIAS, e.g. for tankers.
---@param knots? number Speed in knots.
---@param altitude? number Altitude in feet
---@return number # Corrected KIAS
function UTILS.KnotsToAltKIAS(knots, altitude) end

---Convert pressure from hecto Pascal (hPa) to millimeters of mercury (mmHg).
---@param hPa? number Pressure in hPa.
---@return number # Pressure in mmHg.
function UTILS.hPa2mmHg(hPa) end

---Convert kilo gramms (kg) to pounds (lbs).
---@param kg? number Mass in kg.
---@return number # Mass in lbs.
function UTILS.kg2lbs(kg) end

---@param lat? any
---@param lon? any
---@param acc? any
---@param DMS? any
function UTILS.tostringLL(lat, lon, acc, DMS) end

---@param lat? any
---@param lon? any
---@param acc? any
function UTILS.tostringLLM2KData(lat, lon, acc) end

---acc- the accuracy of each easting/northing.  0, 1, 2, 3, 4, or 5.
---@param MGRS? any
---@param acc? any
function UTILS.tostringMGRS(MGRS, acc) end

---From http://lua-users.org/wiki/SimpleRound
---use negative idp for rounding ahead of decimal place, positive for rounding after decimal place
---@param num? any
---@param idp? any
function UTILS.Round(num, idp) end

---Porting in Slmod's dostring - execute a string as LUA code with error handling.
---@param s? string The code as string to be executed
---@return boolean # success If true, code was successfully executed, else false
---@return string # Outcome Code outcome if successful or error string if not successful
function UTILS.DoString(s) end

---Here is a customized version of pairs, which I called spairs because it iterates over the table in a sorted order.
---@param t? table The table
---@param order? string (Optional) The sorting function
---@return string # key The index key
---@return string # value The value at the indexed key
function UTILS.spairs(t, order) end

---Here is a customized version of pairs, which I called kpairs because it iterates over the table in a sorted order, based on a function that will determine the keys as reference first.
---@param t? table The table
---@param getkey? string The function to determine the keys for sorting
---@param order? string (Optional) The sorting function itself
---@return string # key The index key
---@return string # value The value at the indexed key
function UTILS.kpairs(t, getkey, order) end

---Here is a customized version of pairs, which I called rpairs because it iterates over the table in a random order.
---@param t? table The table
---@return string # key The index key
---@return string # value The value at the indexed key
function UTILS.rpairs(t) end

---get a new mark ID for markings
function UTILS.GetMarkID() end

---Remove an object (marker, circle, arrow, text, quad, ...) on the F10 map.
---@param MarkID? number Unique ID of the object.
---@param Delay? number (Optional) Delay in seconds before the mark is removed.
function UTILS.RemoveMark(MarkID, Delay) end

---Test if a Vec2 is in a radius of another Vec2
---@param InVec2? any
---@param Vec2? any
---@param Radius? any
function UTILS.IsInRadius(InVec2, Vec2, Radius) end

---Test if a Vec3 is in the sphere of another Vec3
---@param InVec3? any
---@param Vec3? any
---@param Radius? any
function UTILS.IsInSphere(InVec3, Vec3, Radius) end

---Beaufort scale: returns Beaufort number and wind description as a function of wind speed in m/s.
---@param speed? number Wind speed in m/s.
---@return number # Beaufort number.
---@return string # Beauford wind description.
function UTILS.BeaufortScale(speed) end

---Split string at separators. C.f. [split-string-in-lua](http://stackoverflow.com/questions/1426954/split-string-in-lua).
---@param str? string Sting to split.
---@param sep? string Separator for split.
---@return table # Split text.
function UTILS.Split(str, sep) end

---Get a table of all characters in a string.
---@param str? string Sting.
---@return table # Individual characters.
function UTILS.GetCharacters(str) end

---Convert time in seconds to hours, minutes and seconds.
---@param seconds? number Time in seconds, e.g. from timer.getAbsTime() function.
---@param short? boolean (Optional) If true, use short output, i.e. (HH:)MM:SS without day.
---@return string # Time in format Hours:Minutes:Seconds+Days (HH:MM:SS+D).
function UTILS.SecondsToClock(seconds, short) end

---Seconds of today.
---@return number # Seconds passed since last midnight.
function UTILS.SecondsOfToday() end

---Cound seconds until next midnight.
---@return number # Seconds to midnight.
function UTILS.SecondsToMidnight() end

---Convert clock time from hours, minutes and seconds to seconds.
---@param clock? string String of clock time. E.g., "06:12:35" or "5:1:30+1". Format is (H)H:(M)M:((S)S)(+D) H=Hours, M=Minutes, S=Seconds, D=Days.
---@return number # Seconds. Corresponds to what you cet from timer.getAbsTime() function.
function UTILS.ClockToSeconds(clock) end

---Display clock and mission time on screen as a message to all.
---@param duration? number (Optional) Duration in seconds how long the time is displayed. Default is 5 seconds.
function UTILS.DisplayMissionTime(duration) end

---Replace illegal characters [<>|/?*:\\] in a string.
---@param Text? string Input text.
---@param ReplaceBy? string (Optional) Replace illegal characters by this character or string. Default underscore "_".
---@return string # The input text with illegal chars replaced.
function UTILS.ReplaceIllegalCharacters(Text, ReplaceBy) end

---Generate a Gaussian pseudo-random number.
---@param x0? number Expectation value of distribution.
---@param sigma? number (Optional) Standard deviation. Default 10.
---@param xmin? number (Optional) Lower cut-off value.
---@param xmax? number (Optional) Upper cut-off value.
---@param imax? number (Optional) Max number of tries to get a value between xmin and xmax (if specified). Default 100.
---@return number # Gaussian random number.
function UTILS.RandomGaussian(x0, sigma, xmin, xmax, imax) end

---Randomize a value by a certain amount.
---@param value? number The value which should be randomized
---@param fac? number Randomization factor.
---@param lower? number (Optional) Lower limit of the returned value.
---@param upper? number (Optional) Upper limit of the returned value.
---@return number # Randomized value.
function UTILS.Randomize(value, fac, lower, upper) end

---Calculate the [dot product](https://en.wikipedia.org/wiki/Dot_product) of two vectors. The result is a number.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return number # Scalar product of the two vectors a*b.
function UTILS.VecDot(a, b) end

---Calculate the [dot product](https://en.wikipedia.org/wiki/Dot_product) of two 2D vectors. The result is a number.
---@param a? Vec2 Vector in 2D with x, y components.
---@param b? Vec2 Vector in 2D with x, y components.
---@return number # Scalar product of the two vectors a*b.
function UTILS.Vec2Dot(a, b) end

---Calculate the [euclidean norm](https://en.wikipedia.org/wiki/Euclidean_distance) (length) of a 3D vector.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@return number # Norm of the vector.
function UTILS.VecNorm(a) end

---Calculate the [euclidean norm](https://en.wikipedia.org/wiki/Euclidean_distance) (length) of a 2D vector.
---@param a? Vec2 Vector in 2D with x, y components.
---@return number # Norm of the vector.
function UTILS.Vec2Norm(a) end

---Calculate the distance between two 2D vectors.
---@param a? Vec2 Vector in 2D with x, y components.
---@param b? Vec2 Vector in 2D with x, y components.
---@return number # Distance between the vectors.
function UTILS.VecDist2D(a, b) end

---Calculate the distance between two 3D vectors.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return number # Distance between the vectors.
function UTILS.VecDist3D(a, b) end

---Calculate the [cross product](https://en.wikipedia.org/wiki/Cross_product) of two 3D vectors. The result is a 3D vector.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return Vec3 # Vector
function UTILS.VecCross(a, b) end

---Calculate the difference between two 3D vectors by substracting the x,y,z components from each other.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return Vec3 # Vector c=a-b with c(i)=a(i)-b(i), i=x,y,z.
function UTILS.VecSubstract(a, b) end

---Scale a 3D vectors by multiplication with s.
---@param v? Vec3 A Vector in 3D with x, y, z components.
---@param s? number Scale
---@return Vec3 # Vec3
function UTILS.VecScale(v, s) end

---Substract is not a word, don't want to rename the original function because it's been around since forever
---@param a? any
---@param b? any
function UTILS.VecSubtract(a, b) end

---Calculate the difference between two 2D vectors by substracting the x,y components from each other.
---@param a? Vec2 Vector in 2D with x, y components.
---@param b? Vec2 Vector in 2D with x, y components.
---@return Vec2 # Vector c=a-b with c(i)=a(i)-b(i), i=x,y.
function UTILS.Vec2Substract(a, b) end

---Calculate the difference between two 3D vectors by substracting the x,y,z components from each other.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return Vec3 # Vector in 3D.
function UTILS.Vec3Substract(a, b) end

---Substract is not a word, don't want to rename the original function because it's been around since forever
---@param a? any
---@param b? any
function UTILS.Vec2Subtract(a, b) end

---Calculate the total vector of two 3D vectors by adding the x,y,z components of each other.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return Vec3 # Vector c=a+b with c(i)=a(i)+b(i), i=x,y,z.
function UTILS.VecAdd(a, b) end

---Calculate the total vector of two 2D vectors by adding the x,y components of each other.
---@param a? Vec2 Vector in 2D with x, y components.
---@param b? Vec2 Vector in 2D with x, y components.
---@return Vec2 # Vector c=a+b with c(i)=a(i)+b(i), i=x,y.
function UTILS.Vec2Add(a, b) end

---Calculate the angle between two 3D vectors.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param b? Vec3 Vector in 3D with x, y, z components.
---@return number # Angle alpha between and b in degrees. alpha=acos(a*b)/(|a||b|), (* denotes the dot product).
function UTILS.VecAngle(a, b) end

---Calculate "heading" of a 3D vector in the X-Z plane.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@return number # Heading in degrees in [0,360).
function UTILS.VecHdg(a) end

---Calculate "heading" of a 2D vector in the X-Y plane.
---@param a? Vec2 Vector in 2D with x, y components.
---@return number # Heading in degrees in [0,360).
function UTILS.Vec2Hdg(a) end

---Calculate the difference between two "heading", i.e. angles in [0,360) deg.
---@param h1? number Heading one.
---@param h2? number Heading two.
---@return number # Heading difference in degrees.
function UTILS.HdgDiff(h1, h2) end

---Returns the heading from one vec2/vec3 to another vec2/vec3.
---@param a? Vec3 From Vec2 or Vec3.
---@param b? Vec3 To Vec2 or Vec3.
---@return number # Heading in degrees.
function UTILS.HdgTo(a, b) end

---Translate 3D vector in the 2D (x,z) plane. y-component (usually altitude) unchanged.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param distance? number The distance to translate.
---@param angle? number Rotation angle in degrees.
---@return Vec3 # Vector rotated in the (x,z) plane.
function UTILS.VecTranslate(a, distance, angle) end

---Translate 2D vector in the 2D (x,z) plane.
---@param a? Vec2 Vector in 2D with x, y components.
---@param distance? number The distance to translate.
---@param angle? number Rotation angle in degrees.
---@return Vec2 # Translated vector.
function UTILS.Vec2Translate(a, distance, angle) end

---Calculate the lenght of a 3D vector
---@param v? Vec3 A Vector in 3D with x, y, z components.
---@return number # length
function UTILS.Vec3Length(v) end

---Rotate 3D vector in the 2D (x,z) plane. y-component (usually altitude) unchanged.
---@param a? Vec3 Vector in 3D with x, y, z components.
---@param angle? number Rotation angle in degrees.
---@return Vec3 # Vector rotated in the (x,z) plane.
function UTILS.Rotate2D(a, angle) end

---Rotate 2D vector in the 2D (x,z) plane.
---@param a? Vec2 Vector in 2D with x, y components.
---@param angle? number Rotation angle in degrees.
---@return Vec2 # Vector rotated in the (x,y) plane.
function UTILS.Vec2Rotate2D(a, angle) end

---Converts a TACAN Channel/Mode couple into a frequency in Hz.
---@param TACANChannel? number The TACAN channel, i.e. the 10 in "10X".
---@param TACANMode? string The TACAN mode, i.e. the "X" in "10X".
---@return number # Frequency in Hz or #nil if parameters are invalid.
function UTILS.TACANToFrequency(TACANChannel, TACANMode) end

---Returns the DCS map/theatre as optained by `env.mission.theatre`.
---@return string # DCS map name.
function UTILS.GetDCSMap() end

---Returns the mission date. This is the date the mission **started**.
---@return string # Mission date in yyyy/mm/dd format.
---@return number # The year anno domini.
---@return number # The month.
---@return number # The day.
function UTILS.GetDCSMissionDate() end

---Returns the day of the mission.
---@param Time? number (Optional) Abs. time in seconds. Default now, i.e. the value return from timer.getAbsTime().
---@return number # Day of the mission. Mission starts on day 0.
function UTILS.GetMissionDay(Time) end

---Returns the current day of the year of the mission.
---@param Time? number (Optional) Abs. time in seconds. Default now, i.e. the value return from timer.getAbsTime().
---@return number # Current day of year of the mission. For example, January 1st returns 0, January 2nd returns 1 etc.
function UTILS.GetMissionDayOfYear(Time) end

---Returns the magnetic declination of the map.
---Returned values for the current maps are:
---
---* Caucasus +6 (East), year ~ 2011
---* NTTR +12 (East), year ~ 2011
---* Normandy -10 (West), year ~ 1944
---* Persian Gulf +2 (East), year ~ 2011
---* The Cannel Map -10 (West)
---* Syria +5 (East)
---* Mariana Islands +2 (East)
---* Falklands +12 (East) - note there's a LOT of deviation across the map, as we're closer to the South Pole
---* Sinai +4.8 (East)
---* Kola +15 (East) - note there is a lot of deviation across the map (-1° to +24°), as we are close to the North pole
---* Afghanistan +3 (East) - actually +3.6 (NW) to +2.3 (SE)
---* Iraq +4.4 (East)
---* Germany Cold War +0.1 (East) - near Fulda
---@param map? string (Optional) Map for which the declination is returned. Default is from `env.mission.theatre`.
---@return number # Declination in degrees.
function UTILS.GetMagneticDeclination(map) end

---Checks if a file exists or not. This requires **io** to be desanitized.
---@param file? string File that should be checked.
---@return boolean # True if the file exists, false if the file does not exist or nil if the io module is not available and the check could not be performed.
function UTILS.FileExists(file) end

---Checks the current memory usage collectgarbage("count"). Info is printed to the DCS log file. Time stamp is the current mission runtime.
---@param output? boolean If true, print to DCS log file.
---@return number # Memory usage in kByte.
function UTILS.CheckMemory(output) end

---Get the coalition name from its numerical ID, e.g. coalition.side.RED.
---@param Coalition? number The coalition ID.
---@return string # The coalition name, i.e. "Neutral", "Red" or "Blue" (or "Unknown").
function UTILS.GetCoalitionName(Coalition) end

---Get the enemy coalition for a given coalition.
---@param Coalition? number The coalition ID.
---@param Neutral? boolean Include neutral as enemy.
---@return table # Enemy coalition table.
function UTILS.GetCoalitionEnemy(Coalition, Neutral) end

---Get the modulation name from its numerical value.
---@param Modulation? number The modulation enumerator number. Can be either 0 or 1.
---@return string # The modulation name, i.e. "AM"=0 or "FM"=1. Anything else will return "Unknown".
function UTILS.GetModulationName(Modulation) end

---Get the NATO reporting name of a unit type name
---@param Typename? number The type name.
---@return string # The Reporting name or "Bogey".
function UTILS.GetReportingName(Typename) end

---Get the callsign name from its enumerator value
---@param Callsign? number The enumerator callsign.
---@return string # The callsign name or "Ghostrider".
function UTILS.GetCallsignName(Callsign) end

---Get the time difference between GMT and local time.
---@return number # Local time difference in hours compared to GMT. E.g. Dubai is GMT+4 ==> +4 is returned.
function UTILS.GMTToLocalTimeDifference() end

---Get the day of the year. Counting starts on 1st of January.
---@param Year? number The year.
---@param Month? number The month.
---@param Day? number The day.
---@return number # The day of the year.
function UTILS.GetDayOfYear(Year, Month, Day) end

---Get sunrise or sun set of a specific day of the year at a specific location.
---@param DayOfYear? number The day of the year.
---@param Latitude? number Latitude.
---@param Longitude? number Longitude.
---@param Rising? boolean If true, calc sun rise, or sun set otherwise.
---@param Tlocal? number Local time offset in hours. E.g. +4 for a location which has GMT+4.
---@return number # Sun rise/set in seconds of the day.
function UTILS.GetSunRiseAndSet(DayOfYear, Latitude, Longitude, Rising, Tlocal) end

---Get sun rise of a specific day of the year at a specific location.
---@param Day? number Day of the year.
---@param Month? number Month of the year.
---@param Year? number Year.
---@param Latitude? number Latitude.
---@param Longitude? number Longitude.
---@param Tlocal? number (Optional) Local time offset in hours. E.g. +4 for a location which has GMT+4. Default 0.
---@return number # Sun rise in seconds of the day.
function UTILS.GetSunrise(Day, Month, Year, Latitude, Longitude, Tlocal) end

---Get sun set of a specific day of the year at a specific location.
---@param Day? number Day of the year.
---@param Month? number Month of the year.
---@param Year? number Year.
---@param Latitude? number Latitude.
---@param Longitude? number Longitude.
---@param Tlocal? number (Optional) Local time offset in hours. E.g. +4 for a location which has GMT+4. Default 0.
---@return number # Sun rise in seconds of the day.
function UTILS.GetSunset(Day, Month, Year, Latitude, Longitude, Tlocal) end

---Determine the carrier recovery case from night, fog visibility and cloud base.
---@param Coordinate? COORDINATE Observation position.
---@param Clock? string Optional mission time "HH:MM:SS+D". Defaults to now.
---@return number # Recovery case: 1, 2 or 3.
function UTILS.GetRecoveryCase(Coordinate, Clock) end

---Get OS time. Needs os to be desanitized!
---@return number # Os time in seconds.
function UTILS.GetOSTime() end

---Shuffle a table accoring to Fisher Yeates algorithm
---@param t? table Table to be shuffled.
---@return table # Shuffled table.
function UTILS.ShuffleTable(t) end

---Get a random element of a table.
---@param t? table Table.
---@param replace? boolean If `true`, the drawn element is replaced, i.e. not deleted.
---@return number # Table element.
function UTILS.GetRandomTableElement(t, replace) end

---(Helicopter) Check if one loading door is open.
---@param unit_name? string Unit name to be checked
---@return boolean # Outcome - true if a (loading door) is open, false if not, nil if none exists.
function UTILS.IsLoadingDoorOpen(unit_name) end

---Function to generate valid FM frequencies in mHz for radio beacons (FM).
---@return table # Table of frequencies.
function UTILS.GenerateFMFrequencies() end

---Function to generate valid VHF frequencies in kHz for radio beacons (FM).
---@return table # VHFrequencies
function UTILS.GenerateVHFrequencies() end

---Function to generate valid UHF Frequencies in mHz (AM). Can be between 220 and 399 mHz. 243 is auto-excluded.
---@param Start? any
---@param End? any
---@return table # UHF Frequencies
function UTILS.GenerateUHFrequencies(Start, End) end

---Function to generate valid laser codes for JTAC.
---@return table # Laser Codes.
function UTILS.GenerateLaserCodes() end

---Ensure the passed object is a table.
---@param Object? table The object that should be a table.
---@param ReturnNil? boolean If `true`, return `#nil` if `Object` is nil. Otherwise an empty table `{}` is returned.
---@return table # The object that now certainly *is* a table.
function UTILS.EnsureTable(Object, ReturnNil) end

---Function to save an object to a file
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file. Existing file will be overwritten.
---@param Data? string The data structure to save. This will be e.g. a string of text lines with an \\n at the end of each line.
---@return boolean # outcome True if saving is possible, else false.
function UTILS.SaveToFile(Path, Filename, Data) end

---Function to load an object from a file.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return boolean # outcome True if reading is possible and successful, else false.
---@return table # data The data read from the filesystem (table of lines of text). Each line is one single #string!
function UTILS.LoadFromFile(Path, Filename) end

---Function to check if a file exists.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return boolean # outcome True if reading is possible, else false.
function UTILS.CheckFileExists(Path, Filename) end

---Function to obtain a table of typenames from the group given with the number of units of the same type in the group.
---@param Group? GROUP The group to list
---@return table # Table of typnames and typename counts, e.g. `{["KAMAZ Truck"]=3,["ATZ-5"]=1}`
function UTILS.GetCountPerTypeName(Group) end

---Function to save the state of a list of groups found by name
---@param List? table Table of strings with groupnames
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Structured? boolean Append the data with a list of typenames in the group plus their count.
---@return boolean # outcome True if saving is successful, else false.
function UTILS.SaveStationaryListOfGroups(List, Path, Filename, Structured) end

---Function to save the state of a set of Wrapper.Group#GROUP objects.
---@param Set? SET_BASE of objects to save
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Structured? boolean Append the data with a list of typenames in the group plus their count.
---@return boolean # outcome True if saving is successful, else false.
function UTILS.SaveSetOfGroups(Set, Path, Filename, Structured) end

---Function to save the state of a set of Wrapper.Static#STATIC objects.
---@param Set? SET_BASE of objects to save
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return boolean # outcome True if saving is successful, else false.
function UTILS.SaveSetOfStatics(Set, Path, Filename) end

---Function to save the state of a list of statics found by name
---@param List? table Table of strings with statics names
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return boolean # outcome True if saving is successful, else false.
function UTILS.SaveStationaryListOfStatics(List, Path, Filename) end

---Load back a stationary list of groups from file.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Reduce? boolean If false, existing loaded groups will not be reduced to fit the saved number.
---@param Structured? boolean (Optional, needs Reduce = true) If true, and the data has been saved as structure before, remove the correct unit types as per the saved list.
---@param Cinematic? boolean (Optional, needs Structured = true) If true, place a fire/smoke effect on the dead static position.
---@param Effect? number (Optional) (Optional for Cinematic) What effect to use. Defaults to a random effect. Smoke presets are: 1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke.
---@param Density? number (Optional) (Optional for Cinematic) What smoke density to use, can be 0 to 1. Defaults to 0.5.
---@param Resurrection? boolean (Optional) If true, dead units can be restored on load. Defaults to false.
---@param ResurrectPercentage? number (Optional) Use this percentage of probability to resurrect a unit. [0..100], defaults to 25.
---@param Healmin? number (Optional) If set, life points of a resurrected unit will be randomly restored to min this percentage. [0..100], defaults to 25.
---@param Healmax? number (Optional) If set, life points of a resurrected unit will be randomly restored to max this percentage. [0..100], defaults to 75.
---@return table # Table of data objects (tables) containing groupname, coordinate and group object. Returns nil when file cannot be read.
---@return table # When using Cinematic: table of names of smoke and fire objects, so they can be extinguished with `COORDINATE.StopBigSmokeAndFire( name )`
function UTILS.LoadStationaryListOfGroups(Path, Filename, Reduce, Structured, Cinematic, Effect, Density, Resurrection, ResurrectPercentage, Healmin, Healmax) end

---Load back a SET of groups from file.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Spawn? boolean If set to false, do not re-spawn the groups loaded in location and reduce to size.
---@param Structured? boolean (Optional, needs Spawn=true)If true, and the data has been saved as structure before, remove the correct unit types as per the saved list.
---@param Cinematic? boolean (Optional, needs Structured=true) If true, place a fire/smoke effect on the dead static position.
---@param Effect? number (Optional) (Optional for Cinematic) What effect to use. Defaults to a random effect. Smoke presets are: 1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke.
---@param Density? number (Optional) (Optional for Cinematic) What smoke density to use, can be 0 to 1. Defaults to 0.5.
---@return SET_GROUP # Set of GROUP objects. Returns nil when file cannot be read. Returns a table of data entries if Spawn is false: `{ groupname=groupname, size=size, coordinate=coordinate, template=template }`
---@return table # When using Cinematic: table of names of smoke and fire objects, so they can be extinguished with `COORDINATE.StopBigSmokeAndFire( name )`
function UTILS.LoadSetOfGroups(Path, Filename, Spawn, Structured, Cinematic, Effect, Density) end

---Load back a SET of statics from file.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return SET_STATIC # Set SET_STATIC containing the static objects.
function UTILS.LoadSetOfStatics(Path, Filename) end

---Load back a stationary list of statics from file.
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Reduce? boolean If false, do not destroy the units with size=0.
---@param Dead? boolean (Optional, needs Reduce = true) If Dead is true, re-spawn the dead object as dead and do not just delete it.
---@param Cinematic? boolean (Optional, needs Dead = true) If true, place a fire/smoke effect on the dead static position.
---@param Effect? number (Optional) (Optional for Cinematic) What effect to use. Defaults to a random effect. Smoke presets are: 1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke.
---@param Density? number (Optional) (Optional for Cinematic) What smoke density to use, can be 0 to 1. Defaults to 0.5.
---@return table # Table of data objects (tables) containing staticname, size (0=dead else 1), coordinate and the static object. Dead objects will have coordinate points `{x=0,y=0,z=0}`
---@return table # When using Cinematic: table of names of smoke and fire objects, so they can be extinguished with `COORDINATE.StopBigSmokeAndFire( name )` Returns nil when file cannot be read.
function UTILS.LoadStationaryListOfStatics(Path, Filename, Reduce, Dead, Cinematic, Effect, Density) end

---Heading Degrees (0-360) to Cardinal
---@param Heading? number The heading
---@return string # Cardinal, e.g. "NORTH"
function UTILS.BearingToCardinal(Heading) end

---Adjust given heading so that is is in [0, 360).
---@param Heading? number The heading in degrees.
---@return number # Adjust heading in [0,360).
function UTILS.AdjustHeading360(Heading) end

---Create a BRAA NATO call string BRAA between two GROUP objects
---@param FromGrp? GROUP GROUP object
---@param ToGrp? GROUP GROUP object
---@return string # Formatted BRAA NATO call
function UTILS.ToStringBRAANATO(FromGrp, ToGrp) end

---Check if an object is contained in a table.
---@param Table? table The table.
---@param Object? table The object to check.
---@param Key? string (Optional) Key to check. By default, the object itself is checked.
---@return boolean # Returns `true` if object is in table.
function UTILS.IsInTable(Table, Object, Key) end

---Check if any object of multiple given objects is contained in a table.
---@param Table? table The table.
---@param Objects? table The objects to check.
---@param Key? string (Optional) Key to check.
---@return boolean # Returns `true` if object is in table.
function UTILS.IsAnyInTable(Table, Objects, Key) end

---Helper function to plot a racetrack on the F10 Map - curtesy of Buur.
---@param Coordinate? COORDINATE
---@param Altitude? number Altitude in feet
---@param Speed? number (Optional) Speed in knots. Defaults to 350.
---@param Heading? number (Optional) Heading in degrees. Defaults to 270.
---@param Leg? number (Optional) Leg in NM. Defaults to 10nm.
---@param Coalition? number (Optional) Coalition side, e.g. coaltion.side.RED or coaltion.side.BLUE. Defaults to -1.
---@param Color? table (Optional) Color of the line in RGB, e.g. {1,0,0} for red, Defaults to {1,0,0}.
---@param Alpha? number (Optional) Transparency factor, between 0.1 and 1. Defaults to 1.
---@param LineType? number (Optional) Line type to be used, line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean
function UTILS.PlotRacetrack(Coordinate, Altitude, Speed, Heading, Leg, Coalition, Color, Alpha, LineType, ReadOnly) end

---Get the current time in a "nice" format like 21:01:15
---@return string # Returns string with the current time
function UTILS.TimeNow() end

---Given 2 "nice" time string, returns the difference between the two in seconds
---@param start_time? string Time string like "07:15:22"
---@param end_time? string Time string like "08:11:27"
---@return number # Seconds between start_time and end_time
function UTILS.TimeDifferenceInSeconds(start_time, end_time) end

---Check if the current time is later than time_string.
---@param time_string? any
---@return boolean # True if later, False if before
function UTILS.TimeLaterThan(time_string) end

---Check if the current time is before time_string.
---@param time_string? any
---@return boolean # False if later, True if before
function UTILS.TimeBefore(time_string) end

---Combines two time strings to give you a new time. For example "15:16:32" and "02:06:24" would return "17:22:56"
---@param time_string_01? string Time string like "07:15:22"
---@param time_string_02? string Time string like "08:11:27"
---@return string # Result of the two time string combined
function UTILS.CombineTimeStrings(time_string_01, time_string_02) end

---Subtracts two time string to give you a new time. For example "15:16:32" and "02:06:24" would return "13:10:08"
---@param time_string_01? string Time string like "07:15:22"
---@param time_string_02? string Time string like "08:11:27"
---@return string # Result of the two time string subtracted
function UTILS.SubtractTimeStrings(time_string_01, time_string_02) end

---Checks if the current time is in between start_time and end_time
---@param start_time? any
---@param end_time? any
---@return boolean # True if it is, False if it's not
function UTILS.TimeBetween(start_time, end_time) end

---Easy to read one line to roll the dice on something. 1% is very unlikely to happen, 99% is very likely to happen
---@param chance? number (optional) Percentage chance you want something to happen. Defaults to a random number if not given
---@return boolean # True if the dice roll was within the given percentage chance of happening
function UTILS.PercentageChance(chance) end

---Easy to read one liner to clamp a value
---@param value? number Input value
---@param min? number Minimal value that should be respected
---@param max? number Maximal value that should be respected
---@return number # Clamped value
function UTILS.Clamp(value, min, max) end

---Clamp an angle so that it's always between 0 and 360 while still being correct
---@param value? number Input value
---@return number # Clamped value
function UTILS.ClampAngle(value) end

---Remap an input to a new value in a given range. For example:
---UTILS.RemapValue(20, 10, 30, 0, 200) would return 100
---20 is 50% between 10 and 30
---50% between 0 and 200 is 100
---@param value? number Input value
---@param old_min? number Min value to remap from
---@param old_max? number Max value to remap from
---@param new_min? number Min value to remap to
---@param new_max? number Max value to remap to
---@return number # Remapped value
function UTILS.RemapValue(value, old_min, old_max, new_min, new_max) end

---Given a triangle made out of 3 vector 2s, return a vec2 that is a random number in this triangle
---@param pt1? Vec2 Min value to remap from
---@param pt2? Vec2 Max value to remap from
---@param pt3? Vec2 Max value to remap from
---@return Vec2 # Random point in triangle
function UTILS.RandomPointInTriangle(pt1, pt2, pt3) end

---Checks if a given angle (heading) is between 2 other angles. Min and max have to be given in clockwise order For example:
---UTILS.AngleBetween(350, 270, 15) would return True
---UTILS.AngleBetween(22, 95, 20) would return False
---@param angle? number Min value to remap from
---@param min? number Max value to remap from
---@param max? number Max value to remap from
---@return boolean
function UTILS.AngleBetween(angle, min, max) end

---Easy to read one liner to write a JSON file. Everything in @data should be serializable
---json.lua exists in the DCS install Scripts folder
---@param data? table table to write
---@param file_path? string File path
function UTILS.WriteJSON(data, file_path) end

---Easy to read one liner to read a JSON file.
---json.lua exists in the DCS install Scripts folder
---@param file_path? string File path
---@return table
function UTILS.ReadJSON(file_path) end

---Get the properties names and values of properties set up on a Zone in the Mission Editor.
---This doesn't work for any zones created in MOOSE
---@param zone_name? string Name of the zone as set up in the Mission Editor
---@return table # with all the properties on a zone
function UTILS.GetZoneProperties(zone_name) end

---Rotates a point around another point with a given angle. Useful if you're loading in groups or
---statics but you want to rotate them all as a collection. You can get the center point of everything
---and then rotate all the positions of every object around this center point.
---@param point? Vec2 Point that you want to rotate
---@param pivot? Vec2 Pivot point of the rotation
---@param angle? number How many degrees the point should be rotated
---@return Vec2 # Rotated point
function UTILS.RotatePointAroundPivot(point, pivot, angle) end

---Makes a string semi-unique by attaching a random number between 0 and 1 million to it
---@param base? string String you want to unique-fy
---@return string # Unique string
function UTILS.UniqueName(base) end

---Check if a string starts with something
---@param str? string String to check
---@param value? string
---@return boolean # True if str starts with value
function string.startswith(str, value) end

---Check if a string ends with something
---@param str? string String to check
---@param value? string
---@return boolean # True if str ends with value
function string.endswith(str, value) end

---Splits a string on a separator. For example:
---string.split("hello_dcs_world", "-") would return {"hello", "dcs", "world"}
---@param input? string String to split
---@param separator? string What to split on
---@return table # individual strings
function string.split(input, separator) end

---Checks if a string contains a substring. Easier to remember for Python people :)
---string.split("hello_dcs_world", "-") would return {"hello", "dcs", "world"}
---@param str? string
---@param value? string
---@return boolean # True if str contains value
function string.contains(str, value) end

---Moves an object from one table to another
---@param obj? table object to move
---@param from_table? table table to move from
---@param to_table? table table to move to
function table.move_object(obj, from_table, to_table) end

---Given tbl is a indexed table ({"hello", "dcs", "world"}), checks if element exists in the table.
---The table can be made up out of complex tables or values as well
---@param tbl? table
---@param element? string
---@return boolean # True if tbl contains element
function table.contains(tbl, element) end

---Checks if a table contains a specific key.
---@param tbl? table Table to check
---@param key? string Key to look for
---@return boolean # True if tbl contains key
function table.contains_key(tbl, key) end

---Inserts a unique element into a table.
---@param tbl? table Table to insert into
---@param element? string Element to insert
function table.insert_unique(tbl, element) end

---Removes an element from a table by its value.
---@param tbl? table Table to remove from
---@param element? string Element to remove
function table.remove_by_value(tbl, element) end

---Removes an element from a table by its key.
---@param table? table Table to remove from
---@param key? string Key of the element to remove
---@return string # Removed element
function table.remove_key(table, key) end

---Finds the index of an element in a table.
---@param table? table Table to search
---@param element? string Element to find
---@return number # Index of the element, or nil if not found
function table.index_of(table, element) end

---Counts the number of elements in a table.
---@param T? table Table to count
---@return number # Number of elements in the table
function table.length(T) end

---Slices a table between two indices, much like Python's my_list[2:-1]
---@param tbl? table Table to slice
---@param first? number Starting index
---@param last? number Ending index
---@return table # Sliced table
function table.slice(tbl, first, last) end

---Counts the number of occurrences of a value in a table.
---@param tbl? table Table to search
---@param value? string Value to count
---@return number # Number of occurrences of the value
function table.count_value(tbl, value) end

---Add 2 table together, t2 gets added to t1
---@param t1? table First table
---@param t2? table Second table
---@return table # Combined table
function table.combine(t1, t2) end

---Merges two tables into one. If a key exists in both t1 and t2, the value of t1 with be overwritten by the value of t2
---@param t1? table First table
---@param t2? table Second table
---@return table # Merged table
function table.merge(t1, t2) end

---Adds an item to the end of a table.
---@param tbl? table Table to add to
---@param item? string Item to add
function table.add(tbl, item) end

---Shuffles the elements of a table.
---@param tbl? table Table to shuffle
---@return table # Shuffled table
function table.shuffle(tbl) end

---Finds a key-value pair in a table.
---@param tbl? table Table to search
---@param key? string Key to find
---@param value? string Value to find
---@return table # Table containing the key-value pair, or nil if not found
function table.find_key_value_pair(tbl, key, value) end

---Convert a decimal to octal
---@param Number? number the number to convert
---@return number # Octal
function UTILS.DecimalToOctal(Number) end

---Convert an octal to decimal
---@param Number? number the number to convert
---@return number # Decimal
function UTILS.OctalToDecimal(Number) end

---HexToRGBA
---@param hex_string? any
---@return table # R, G, B, A
function UTILS.HexToRGBA(hex_string) end

---Function to save the position of a set of #OPSGROUP (ARMYGROUP) objects.
---@param Set? SET_OPSGROUP of ops objects to save
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@param Structured? boolean Append the data with a list of typenames in the group plus their count.
---@return boolean # outcome True if saving is successful, else false.
function UTILS.SaveSetOfOpsGroups(Set, Path, Filename, Structured) end

---Load back a #OPSGROUP (ARMYGROUP) data from file for use with {Ops.Brigade#BRIGADE.LoadBackAssetInPosition}()
---@param Path? string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename? string The name of the file.
---@return table # Returns a table of data entries: `{ groupname=groupname, size=size, coordinate=coordinate, template=template, structure=structure, legion=legion, alttemplate=alttemplate }` Returns nil when the file cannot be read.
function UTILS.LoadSetOfOpsGroups(Path, Filename) end

---Get the clock position from a relative heading
---@param refHdg? number The heading of the reference object (such as a Wrapper.UNIT) in 0-360
---@param tgtHdg? number The absolute heading from the reference object to the target object/point in 0-360
---@return string # text Text in clock heading such as "4 O'CLOCK"
function UTILS.ClockHeadingString(refHdg, tgtHdg) end

---Get a NATO abbreviated MGRS text for SRS use, optionally with prosody slow tag
---@param Text? string The input string, e.g. "MGRS 4Q FJ 12345 67890"
---@param Slow? boolean Optional - add slow tags, if the backend is not Hound
---@param Backend? string The TTS Backend used
---@return string # Output for (Slow) spelling in SRS TTS e.g. "MGRS;<prosody rate="slow">4;Quebec;Foxtrot;Juliett;1;2;3;4;5;6;7;8;niner;zero;</prosody>"
function UTILS.MGRSStringToSRSFriendly(Text, Slow, Backend) end

---Read csv file and convert it to a lua table.
---The csv must have a header specifing the names of the columns. The column names are used as table keys.
---@param filename? string File name including full path on local disk.
---@return table # The table filled with data from the csv file.
function UTILS.ReadCSV(filename) end

---Seed the LCG random number generator.
---@param seed? number (Optional) Seed value. Default is a random number using math.random()
function UTILS.LCGRandomSeed(seed) end

---Return a pseudo-random number using the LCG algorithm.
---@return number # Random number between 0 and 1.
function UTILS.LCGRandom() end

---Create a table of grid-points for n points.
---@param startVec2? number Starting DCS#Vec2 map coordinate, e.g. `{x=63598575,y=-63598575}`
---@param n? number Number of points to generate.
---@param spacingX? number Horizonzal spacing (meters).
---@param spacingY? number Vertical spacing (meters).
---@return table # Grid Table of DCS#Vec2 entries.
function UTILS.GenerateGridPoints(startVec2, n, spacingX, spacingY) end

---Spawns a new FARP of a defined type and coalition and functional statics (fuel depot, ammo storage, tent, windsock) around that FARP to make it operational.
---Adds vehicles from template if given. Fills the FARP warehouse with liquids and known materiels.
---References: [DCS Forum Topic](https://forum.dcs.world/topic/282989-farp-equipment-to-run-it)
---@param Name? string Name of this FARP installation. Must be unique.
---@param Coordinate? COORDINATE Where to spawn the FARP.
---@param FARPType? string (Optional) Type of FARP, can be one of the known types ENUMS.FARPType.FARP, ENUMS.FARPType.INVISIBLE, ENUMS.FARPType.HELIPADSINGLE, ENUMS.FARPType.PADSINGLE. Defaults to ENUMS.FARPType.FARP.
---@param Coalition? number (Optional) Coalition of this FARP, i.e. coalition.side.BLUE or coalition.side.RED, defaults to coalition.side.BLUE.
---@param Country? number (Optional) Country of this FARP, defaults to country.id.USA (blue) or country.id.RUSSIA (red).
---@param CallSign? number (Optional) Callsign of the FARP ATC, defaults to CALLSIGN.FARP.Berlin.
---@param Frequency? number (Optional) Frequency of the FARP ATC Radio, defaults to 127.5 (MHz).
---@param Modulation? number (Optional) Modulation of the FARP ATC Radio, defaults to radio.modulation.AM.
---@param ADF? number ADF Beacon (FM) Frequency in KHz, e.g. 428. If not nil, creates an VHF/FM ADF Beacon for this FARP. Requires a sound called "beacon.ogg" to be in the mission (trigger "sound to" ...)
---@param SpawnRadius? number (Optional) Radius of the FARP, i.e. where the FARP objects will be placed in meters, not more than 150m away. Defaults to 100.
---@param VehicleTemplate? string , template name for additional vehicles. Can be nil for no additional vehicles.
---@param Liquids? number (Optional) Tons of fuel to be added initially to the FARP. Defaults to 10 (tons). Set to 0 for no fill.
---@param Equipment? number (Optional)  Number of equipment items per known item to be added initially to the FARP. Defaults to 10 (items). Set to 0 for no fill.
---@param Airframes? number Number of helicopter airframes per known type in Ops.CSAR#CSAR.AircraftType to be added initially to the FARP. Set to 0 for no airframes.
---@param F10Text? string Text to display on F10 map if given. Handy to post things like the ADF beacon Frequency, Callsign and ATC Frequency.
---@param DynamicSpawns? boolean If true, allow Dynamic Spawns from this FARP.
---@param HotStart? boolean If true and DynamicSpawns is true, allow hot starts for Dynamic Spawns from this FARP.
---@param NumberPads? number If given, spawn this number of pads.
---@param SpacingX? number (Optional) For NumberPads > 1, space this many meters horizontally. Defaults to 100.
---@param SpacingY? number (Optional) For NumberPads > 1, space this many meters vertically. Defaults to 100.
---@return STATIC[] # Table of spawned objects and vehicle object (if given).
---@return string # ADFBeaconName Name of the ADF beacon, to be able to remove/stop it later.
---@return number # MarkerID ID of the F10 Text, to be able to remove it later.
function UTILS.SpawnFARPAndFunctionalStatics(Name, Coordinate, FARPType, Coalition, Country, CallSign, Frequency, Modulation, ADF, SpawnRadius, VehicleTemplate, Liquids, Equipment, Airframes, F10Text, DynamicSpawns, HotStart, NumberPads, SpacingX, SpacingY) end

---Spawn a MASH at a given coordinate, optionally, add an ADF Beacon.
---@param Name? string Unique Name of the Mash.
---@param Coordinate? COORDINATE Coordinate where to spawn the MASH. Can be given as a Core.Zone#ZONE object, in this case we take the center coordinate.
---@param Country? number Country ID the MASH belongs to, e.g. country.id.USA or country.id.RUSSIA.
---@param ADF? number (Optional) ADF Frequency in kHz (Kilohertz), if given activate an ADF Beacon at the location of the MASH.
---@param Livery? string (Optional) The livery of the static CH-47, defaults to dark green.
---@param DeployHelo? boolean (Optional) If true, deploy the helicopter static.
---@param MASHRadio? number (Optional) MASH Radio Frequency, defaults to 127.5.
---@param MASHRadioModulation? number (Optional) MASH Radio Modulation, defaults to radio.modulation.AM.
---@param MASHCallsign? number (Optional) Defaults to CALLSIGN.FARP.Berlin.
---@param Templates? table (Optional) You can hand in your own template table of numbered(!) entries. Each entry consist of a relative(!) x,y position and data of a static, shape_name is optional. Also, livery_id is optional, but is applied to the helicopter static only.
---@return table # Table of Wrapper.Static#STATIC objects that were spawned.
---@return string # ADFName Name of the ADF Beacon to remove it later.
function UTILS.SpawnMASHStatics(Name, Coordinate, Country, ADF, Livery, DeployHelo, MASHRadio, MASHRadioModulation, MASHCallsign, Templates) end

---Converts a Vec2 to a Vec3.
---@param vec? any
---@param y? any
function UTILS.Vec2toVec3(vec, y) end

---Converts a Vec3 to a Vec2
---@param Vec3? any
---@return Vec2 # The Vec2 output
function UTILS.Vec3toVec2(Vec3) end

---Get the correction needed for true north in radians
---@param gPoint? any
---@return number # correction
function UTILS.GetNorthCorrection(gPoint) end

---Convert time in seconds to a DHMS table `{d = days, h = hours, m = minutes, s = seconds}`
---@param timeInSec? any
---@return table # Table with DHMS data
function UTILS.GetDHMS(timeInSec) end

---Returns heading-error corrected direction in radians.
---True-north corrected direction from point along vector vec.
---@param vec? any
---@param point? any
---@return direction # corrected direction from point.
function UTILS.GetDirectionRadians(vec, point) end

---Raycasting a point in polygon. Code from http://softsurfer.com/Archive/algorithm_0103/algorithm_0103.htm
---@param point? any
---@param poly? table Polygon Table of Vec2/3 point forming the Polygon
---@param maxalt? number Altitude limit (optional)
function UTILS.IsPointInPolygon(point, poly, maxalt) end

---Vector scalar multiplication.
---@param vec? any
---@param mult? number scalar multiplicator
---@return Vec3 # new vector multiplied with the given scalar
function UTILS.ScalarMult(vec, mult) end

---Utilities weather class for fog mainly.
---@class UTILS.Weather
UTILS.Weather = {}

---Returns the current fog thickness in meters. Returns zero if fog is not present.
function UTILS.Weather.GetFogThickness() end

---Sets the fog to the desired thickness in meters at sea level.
---@param Thickness? number Thickness in meters. Any fog animation will be discarded. Valid range : 100 to 5000 meters
function UTILS.Weather.SetFogThickness(Thickness) end

---Removes the fog.
function UTILS.Weather.RemoveFog() end

---Gets the maximum visibility distance of the current fog setting.
---Returns 0 if no fog is present.
function UTILS.Weather.GetFogVisibilityDistanceMax() end

---Sets the maximum visibility at sea level in meters.
---@param Thickness? number Thickness in meters. Limit: 100 to 100000
function UTILS.Weather.SetFogVisibilityDistance(Thickness) end

--- Uses data from the passed table to change the fog visibility and thickness over a desired timeframe. This allows for a gradual increase/decrease of fog values rather than abruptly applying the values.
---Animation Key Format: {time, visibility, thickness}
---@param AnimationKeys? table Table of AnimationKey tables
function UTILS.Weather.SetFogAnimation(AnimationKeys) end

---The fog animation will be discarded and whatever the current thickness and visibility are set to will remain
function UTILS.Weather.StopFogAnimation() end

---Find a ME created zone by its name
---@param name? any
function UTILS.GetEnvZone(name) end

---net.dostring_in
---@param State? any
---@param DoString? any
function UTILS.DoStringIn(State, DoString) end

---Show a picture on the screen to all
---@param FilePath? any
---@param Duration? number (Optional) Duration in seconds, defaults to 10
---@param ClearView? boolean (Optional) If true, clears the view before showing the picture, defaults to false
---@param StartDelay? number (Optional) Delay in seconds before showing the picture, defaults to 0
---@param HorizontalAlign? number (Optional) Horizontal alignment of the picture, 0: Left, 1: Center, 2: Right. Defaults to 1.
---@param VerticalAlign? number (Optional) Vertical alignment of the picture, 0: Top, 1: Center, 2: Bottom. Defaults to 1.
---@param Size? number (Optional) Size of the picture in percent, defaults to 100
---@param SizeUnits? number (Optional) Size units, 0 for % of original picture size, and 1 for % of window size. Defaults to 0.
function UTILS.ShowPictureToAll(FilePath, Duration, ClearView, StartDelay, HorizontalAlign, VerticalAlign, Size, SizeUnits) end

---Show a picture on the screen to Coalition
---@param Coalition? number Coalition ID, can be coalition.side.BLUE, coalition.side.RED or coalition.side.NEUTRAL
---@param FilePath? any
---@param Duration? number (Optional) Duration in seconds, defaults to 10
---@param ClearView? boolean (Optional) If true, clears the view before showing the picture, defaults to false
---@param StartDelay? number (Optional) Delay in seconds before showing the picture, defaults to 0
---@param HorizontalAlign? number (Optional) Horizontal alignment of the picture, 0: Left, 1: Center, 2: Right. Defaults to 1.
---@param VerticalAlign? number (Optional) Vertical alignment of the picture, 0: Top, 1: Center, 2: Bottom. Defaults to 1.
---@param Size? number (Optional) Size of the picture in percent, defaults to 100
---@param SizeUnits? number (Optional) Size units, 0 for % of original picture size, and 1 for % of window size. Defaults to 0.
function UTILS.ShowPictureToCoalition(Coalition, FilePath, Duration, ClearView, StartDelay, HorizontalAlign, VerticalAlign, Size, SizeUnits) end

---Show a picture on the screen to Country
---@param Country? number Country ID, can be country.id.USA, country.id.RUSSIA, etc.
---@param FilePath? any
---@param Duration? number (Optional) Duration in seconds, defaults to 10
---@param ClearView? boolean (Optional) If true, clears the view before showing the picture, defaults to false
---@param StartDelay? number (Optional) Delay in seconds before showing the picture, defaults to 0
---@param HorizontalAlign? number (Optional) Horizontal alignment of the picture, 0: Left, 1: Center, 2: Right. Defaults to 1.
---@param VerticalAlign? number (Optional) Vertical alignment of the picture, 0: Top, 1: Center, 2: Bottom. Defaults to 1.
---@param Size? number (Optional)  Size of the picture in percent, defaults to 100
---@param SizeUnits? number (Optional) Size units, 0 for % of original picture size, and 1 for % of window size. Defaults to 0.
function UTILS.ShowPictureToCountry(Country, FilePath, Duration, ClearView, StartDelay, HorizontalAlign, VerticalAlign, Size, SizeUnits) end

---Show a picture on the screen to Group
---@param Group? GROUP Group to show the picture to
---@param FilePath? any
---@param Duration? number (Optional) Duration in seconds, defaults to 10
---@param ClearView? boolean (Optional) If true, clears the view before showing the picture, defaults to false
---@param StartDelay? number (Optional) Delay in seconds before showing the picture, defaults to 0
---@param HorizontalAlign? number (Optional) Horizontal alignment of the picture, 0: Left, 1: Center, 2: Right. Defaults to 1.
---@param VerticalAlign? number (Optional) Vertical alignment of the picture, 0: Top, 1: Center, 2: Bottom. Defaults to 1.
---@param Size? number (Optional) Size of the picture in percent, defaults to 100
---@param SizeUnits? number (Optional) Size units, 0 for % of original picture size, and 1 for % of window size. Defaults to 0.
function UTILS.ShowPictureToGroup(Group, FilePath, Duration, ClearView, StartDelay, HorizontalAlign, VerticalAlign, Size, SizeUnits) end

---Show a picture on the screen to Unit
---@param Unit? UNIT Unit to show the picture to
---@param FilePath? any
---@param Duration? number (Optional) Duration in seconds, defaults to 10
---@param ClearView? boolean (Optional) If true, clears the view before showing the picture, defaults to false
---@param StartDelay? number (Optional) Delay in seconds before showing the picture, defaults to 0
---@param HorizontalAlign? number (Optional) Horizontal alignment of the picture, 0: Left, 1: Center, 2: Right. Defaults to 1.
---@param VerticalAlign? number (Optional) Vertical alignment of the picture, 0: Top, 1: Center, 2: Bottom. Defaults to 1.
---@param Size? number (Optional) Size of the picture in percent, defaults to 100
---@param SizeUnits? number (Optional) Size units, 0 for % of original picture size, and 1 for % of window size. Defaults to 0.
function UTILS.ShowPictureToUnit(Unit, FilePath, Duration, ClearView, StartDelay, HorizontalAlign, VerticalAlign, Size, SizeUnits) end

---Load a mission file. This will replace the current mission with the one given carrying along the online clients.
---@param FileName? string Mission filename
function UTILS.LoadMission(FileName) end

---Set the mission briefing for a coalition.
---@param Coalition? number Briefing coalition ID, can be coalition.side.BLUE, coalition.side.RED or coalition.side.NEUTRAL
---@param Text? string Briefing text, can contain newlines, will be converted formatted properly for DCS.
---@param Picture? string (Optional) Picture file path, can be a file in the DEFAULT folder inside the .miz. Defaults to "".
function UTILS.SetMissionBriefing(Coalition, Text, Picture) end

---Show a helper gate at a DCS#Vec3 position
---@param pos? Vec3 The position
---@param heading? number Heading in degrees, can be 0..359 degrees
function UTILS.ShowHelperGate(pos, heading) end

---Show a helper gate for a unit.
---@param Unit? UNIT The unit to show the gate for
---@param Flag? number Helper gate flag
function UTILS.ShowHelperGateForUnit(Unit, Flag) end

---Set the carrier illumination mode. -2: OFF, -1: AUTO, 0: NAVIGATION, 1: AC LAUNCH, 2: AC RECOVERY
---@param UnitID? number Carrier unit ID ( UNIT:GetID() )
---@param Mode? number Illumination mode, can be -2: OFF, -1: AUTO, 0: NAVIGATION, 1: AC LAUNCH, 2: AC RECOVERY
function UTILS.SetCarrierIlluminationMode(UnitID, Mode) end

---Shell a zone, zone must ME created
---@param name? string The name of the ME created zone
---@param power? number Equals kg of TNT, e.g. 75
---@param count? any
function UTILS.ShellZone(name, power, count) end

---Remove objects from a zone, zone must ME created
---@param name? string The name of the ME created zone
---@param type? number Type of objects to remove can be 0:all, 1: trees, 2:objects
function UTILS.RemoveObjects(name, type) end

---Remove scenery objects from a zone, zone must ME created
---@param name? string The name of the ME created zone
---@param level? number Level of removal
function UTILS.DestroyScenery(name, level) end

---Search for clear zones in a given area. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param Vec3? any
---@param SearchRadius? number Radius of the search area.
---@param PosRadius? number Required clear radius around each position.
---@param NumPositions? number Number of positions to find.
---@return table # A table of DCS#Vec2 positions that are clear of map objects within the given PosRadius.
function UTILS.GetSimpleZones(Vec3, SearchRadius, PosRadius, NumPositions) end

---Search for clear ground spawn zones within this zone. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param Zone? ZONE to search.
---@param PosRadius? any
---@param NumPositions? any
---@return table # A table of DCS#Vec2 positions that are clear of map objects within the given PosRadius. nil if no clear positions are found.
function UTILS.GetClearZonePositions(Zone, PosRadius, NumPositions) end

---Search for a random clear ground spawn coordinate within this zone. A powerful and efficient function using Disposition to find clear areas for spawning ground units avoiding trees, water and map scenery.
---@param Zone? ZONE to search.
---@param PosRadius? number (Optional) Required clear radius around each position. (Default is math.min(Radius/10, 200))
---@param NumPositions? number (Optional) Number of positions to find. (Default 50)
---@return COORDINATE # A random coordinate for a clear zone. nil if no clear positions are found.
---@return number # Assigned radius for the found zones. nil if no clear positions are found.
function UTILS.GetRandomClearZoneCoordinate(Zone, PosRadius, NumPositions) end

---Find the point on the radius of a circle closest to a point outside of the radius.
---@param Vec1? Vec2 Simple Vec2 marking the middle of the circle.
---@param Radius? number The radius of the circle.
---@param Vec2? Vec2 Simple Vec2 marking the point outside of the circle.
---@return Vec2 # Vec2 point on the radius.
function UTILS.FindNearestPointOnCircle(Vec1, Radius, Vec2) end

---This function uses Disposition and other fallback logic to find better ground positions for ground units.
---NOTE: This is not a spawn randomizer.
---It will try to find clear ground locations avoiding trees, water, roads, runways, map scenery, statics and other units in the area and modifies the provided positions table.
---Maintains the original layout and unit positions as close as possible by searching for the next closest valid position to each unit.
---@param Positions? table A table of DCS#Vec2 or DCS#Vec3, can be a units table from the group template.
---@param Anchor? Vec2 (Optional) DCS#Vec2 or DCS#Vec3 as anchor point to calculate offset of the units.
---@param MaxRadius? number (Optional) Max radius to search for valid ground locations in meters. Default is double the max radius of the units.
---@param Spacing? number (Optional) Minimum spacing between units in meters. Default is 5% of the search radius or 5 meters, whichever is larger.
function UTILS.ValidateAndRepositionGroundUnits(Positions, Anchor, MaxRadius, Spacing) end

---This function uses Disposition and other fallback logic to find better ground positions for statics.
---NOTE: This is not a spawn randomizer.
---It will try to find clear ground locations avoiding trees, water, roads, runways, map scenery, statics and other units in the area and modifies the provided positions table.
---Maintains the original layout and unit positions as close as possible by searching for the next closest valid position to each unit.
---@param Country? any
---@param Category? any
---@param Type? any
---@param Position? Vec2 DCS#Vec2 or DCS#Vec3 initial spawn location.
---@param ShapeName? any
---@param MaxRadius? number (Optional) Max radius to search for valid ground locations in meters. Default is double the max radius of the static.
---@return Vec2 # Initial Position if it's valid, else a valid spawn position. nil if no valid position found.
function UTILS.ValidateAndRepositionStatic(Country, Category, Type, Position, ShapeName, MaxRadius) end

---This function can be used to scan all airdromes of a map and write the Moose enums to a file.
function UTILS.CreateAirbaseEnum() end

---Calculate then center and radius of a circle enclosing a list if DCS#Vec2 points.
---@param points? table Table of DCS#Vec2 entries
---@return Vec2 # center DCS#Vec2
---@return number # radius
function UTILS.GetCenterAndRadius(points) end

---More accurate: Minimum bounding circle (Welzl's algorithm), calculate then center and radius of a circle enclosing a list if DCS#Vec2 points.
---@param points? table Table of DCS#Vec2 entries
---@return Vec2 # center DCS#Vec2
---@return number # radius
function UTILS.GetMinimumBoundingCircle(points) end

---Calculated optimal intercepting course (Bearing)
---@param A1? Vec3 Position of flight one
---@param V1? Vec3 VelocityVector of flight one
---@param A2? Vec3 Position of flight two
---@param V2_speed? number Speed of A2 in m/s
---@return number # Bearing Bearing course for A2 to take for an intercept of A1 or nil if aspect is hot/cold.
function UTILS.CalculateInterceptBearing(A1, V1, A2, V2_speed) end
