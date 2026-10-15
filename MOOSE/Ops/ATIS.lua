---@meta

---@class ATIS.Soundfile
---@field filename string Name of the file
---@field duration number Duration in seconds.

---@class ATIS.NavPoint
---@field frequency number Nav point frequency.
---@field runway string Runway, *e.g.* "21".
---@field leftright boolean If true, runway has left "L" and right "R" runways.

---ATIS class.
---@class ATIS : FSM
---@field ClassName string Name of the class.
---@field lid string Class id string for output to DCS log file.
---@field theatre string DCS map name.
---@field airbasename string The name of the airbase.
---@field airbase AIRBASE The airbase object.
---@field frequency number Radio frequency in MHz.
---@field modulation number Radio modulation 0=AM or 1=FM.
---@field power number Radio power in Watts. Default 100 W.
---@field radioqueue RADIOQUEUE Radio queue for broadcasing messages.
---@field soundpath string Path to sound files.
---@field soundpathAirports string Path to airport names sound files.
---@field soundpathNato string Path to NATO alphabet sound files.
---@field relayunitname string Name of the radio relay unit.
---@field towerfrequency table Table with tower frequencies.
---@field activerunway string The active runway specified by the user.
---@field subduration number Duration how long subtitles are displayed in seconds.
---@field metric boolean If true, use metric units. If false, use imperial (default).
---@field PmmHg boolean If true, give pressure in millimeters of Mercury. Default is inHg for imperial and hectopascal (hPa, which is the same as millibar - mbar) for metric units.
---@field qnhonly boolean If true, suppresses reporting QFE. Default is to report both QNH and QFE.
---@field TDegF boolean If true, give temperature in degrees Fahrenheit. Default is in degrees Celsius independent of chosen unit system.
---@field zuludiff number Time difference local vs. zulu in hours.
---@field zulutimeonly boolean If true, suppresses report of local time, sunrise, and sunset.
---@field magvar number Magnetic declination/variation at the airport in degrees.
---@field ils table Table of ILS frequencies (can be runway specific).
---@field ndbinner table Table of inner NDB frequencies (can be runway specific).
---@field ndbouter table Table of outer NDB frequencies (can be runway specific).
---@field tacan number TACAN channel.
---@field vor number VOR frequency.
---@field rsbn number RSBN channel.
---@field prmg table PRMG channels (can be runway specific).
---@field rwylength boolean If true, give info on runway length.
---@field elevation boolean If true, give info on airfield elevation.
---@field runwaymag table Table of magnetic runway headings.
---@field runwaym2t number Optional correction for magnetic to true runway heading conversion (and vice versa) in degrees.
---@field windtrue boolean Report true (from) heading of wind. Default is magnetic.
---@field altimeterQNH boolean Report altimeter QNH.
---@field usemarker boolean Use mark on the F10 map.
---@field markerid number Numerical ID of the F10 map mark point.
---@field relHumidity number Relative humidity (used to approximately calculate the dew point).
---@field useSRS boolean If true, use SRS for transmission.
---@field msrs MSRS Moose SRS object.
---@field dTQueueCheck number Time interval to check the radio queue. Default 5 sec or 90 sec if SRS is used.
---@field ReportmBar boolean Report mBar/hpa even if not metric, i.e. for Mirage flights
---@field TransmitOnlyWithPlayers boolean For SRS - If true, only transmit if there are alive Players.
---@field SRSText string Text of the complete SRS message (if done at least once, else nil)
---@field ATISforFARPs boolean Will be set to true if the base given is a FARP/Helipad
---@field gettext TEXTANDSOUND Gettext for localization
---@field locale string Current locale
ATIS = {
  ClassName      = "ATIS",
  lid            =   nil,
  theatre        =   nil,
  airbasename    =   nil,
  airbase        =   nil,
  frequency      =   nil,
  modulation     =   nil,
  power          =   nil,
  radioqueue     =   nil,
  soundpath      =   nil,
  relayunitname  =   nil,
  towerfrequency =   nil,
  activerunway   =   nil,
  subduration    =   nil,
  metric         =   nil,
  PmmHg          =   nil,
  qnhonly        =   false,
  TDegF          =   nil,
  zuludiff       =   nil,
  zulutimeonly   =   false,
  magvar         =   nil,
  ils            =    {},
  ndbinner       =    {},
  ndbouter       =    {},
  vor            =   nil,
  tacan          =   nil,
  rsbn           =   nil,
  prmg           =    {},
  rwylength      =   nil,
  elevation      =   nil,
  runwaymag      =    {},
  runwaym2t      =   nil,
  windtrue       =   nil,
  altimeterQNH   =   nil,
  usemarker      =   nil,
  markerid       =   nil,
  relHumidity    =   nil,
  ReportmBar     =   false,
  TransmitOnlyWithPlayers = false,
  ATISforFARPs   =   false,
  locale         =   "en",
}

---NATO alphabet.
---@class ATIS.Alphabet
ATIS.Alphabet = {
  [1]  = "Alfa",
  [2]  = "Bravo",
  [3]  = "Charlie",
  [4]  = "Delta",
  [5]  = "Echo",
  [6]  = "Delta",
  [7]  = "Echo",
  [8]  = "Foxtrot",
  [9]  = "Golf",
  [10] = "Hotel",
  [11] = "India",
  [12] = "Juliett",
  [13] = "Kilo",
  [14] = "Lima",
  [15] = "Mike",
  [16] = "November",
  [17] = "Oscar",
  [18] = "Papa",
  [19] = "Quebec",
  [20] = "Romeo",
  [21] = "Sierra",
  [22] = "Tango",
  [23] = "Uniform",
  [24] = "Victor",
  [25] = "Whiskey",
  [26] = "Xray",
  [27] = "Yankee",
  [28] = "Zulu",
}

---Runway correction for converting true to magnetic heading.
---@class ATIS.RunwayM2T
---@field Caucasus number 0° (East).
---@field Nevada number +12° (East).
---@field Normandy number -10° (West).
---@field PersianGulf number +2° (East).
---@field TheChannel number -10° (West).
---@field Syria number +5° (East).
---@field MarianaIslands number +2° (East).
---@field SinaiMap number +5° (East).
---@field Kola number +15° (East).
---@field Afghanistan number +3° (East).
---@field Iraq number +4.4° (East).
---@field GermanyCW number +0.1° (East).
ATIS.RunwayM2T = {
  Caucasus = 0,
  Nevada = 12,
  Normandy = -10,
  PersianGulf = 2,
  TheChannel = -10,
  Syria = 5,
  MarianaIslands = 2,
  Falklands = 12,
  SinaiMap = 5,
  Kola = 15,
  Afghanistan = 3,
  Iraq=4.4,
  GermanyCW=0.1,
}

---Whether ICAO phraseology is used for ATIS broadcasts.
---@class ATIS.ICAOPhraseology
---@field Caucasus boolean true.
---@field Nevada boolean false.
---@field Normandy boolean true.
---@field PersianGulf boolean true.
---@field TheChannel boolean true.
---@field Syria boolean true.
---@field MarianaIslands boolean true.
---@field Falklands boolean true.
---@field SinaiMap boolean true.
---@field Kola boolean true.
---@field Afghanistan boolean true.
---@field Iraq boolean true.
---@field GermanyCW boolean true.
ATIS.ICAOPhraseology = {
  Caucasus = true,
  Nevada = false,
  Normandy = true,
  PersianGulf = true,
  TheChannel = true,
  Syria = true,
  MarianaIslands = true,
  Falklands = true,
  SinaiMap = true,
  Kola = true,
  Afghanistan = true,
  Iraq = true,
  GermanyCW = true,
}

---Sound files.
---@class ATIS.Sound
---@field ActiveRunway ATIS.Soundfile
---@field AdviceOnInitial ATIS.Soundfile
---@field Airport ATIS.Soundfile
---@field Altimeter ATIS.Soundfile
---@field At ATIS.Soundfile
---@field CloudBase ATIS.Soundfile
---@field CloudCeiling ATIS.Soundfile
---@field CloudsBroken ATIS.Soundfile
---@field CloudsFew ATIS.Soundfile
---@field CloudsNo ATIS.Soundfile
---@field CloudsNotAvailable ATIS.Soundfile
---@field CloudsOvercast ATIS.Soundfile
---@field CloudsScattered ATIS.Soundfile
---@field Decimal ATIS.Soundfile
---@field DegreesCelsius ATIS.Soundfile
---@field DegreesFahrenheit ATIS.Soundfile
---@field DewPoint ATIS.Soundfile
---@field Dust ATIS.Soundfile
---@field Elevation ATIS.Soundfile
---@field EndOfInformation ATIS.Soundfile
---@field Feet ATIS.Soundfile
---@field Fog ATIS.Soundfile
---@field Gusting ATIS.Soundfile
---@field HectoPascal ATIS.Soundfile
---@field Hundred ATIS.Soundfile
---@field InchesOfMercury ATIS.Soundfile
---@field Information ATIS.Soundfile
---@field Kilometers ATIS.Soundfile
---@field Knots ATIS.Soundfile
---@field Left ATIS.Soundfile
---@field MegaHertz ATIS.Soundfile
---@field Meters ATIS.Soundfile
---@field MetersPerSecond ATIS.Soundfile
---@field Miles ATIS.Soundfile
---@field MillimetersOfMercury ATIS.Soundfile
---@field N0 ATIS.Soundfile
---@field N1 ATIS.Soundfile
---@field N2 ATIS.Soundfile
---@field N3 ATIS.Soundfile
---@field N4 ATIS.Soundfile
---@field N5 ATIS.Soundfile
---@field N6 ATIS.Soundfile
---@field N7 ATIS.Soundfile
---@field N8 ATIS.Soundfile
---@field N9 ATIS.Soundfile
---@field NauticalMiles ATIS.Soundfile
---@field None ATIS.Soundfile
---@field QFE ATIS.Soundfile
---@field QNH ATIS.Soundfile
---@field Rain ATIS.Soundfile
---@field Right ATIS.Soundfile
---@field Snow ATIS.Soundfile
---@field SnowStorm ATIS.Soundfile
---@field SunriseAt ATIS.Soundfile
---@field SunsetAt ATIS.Soundfile
---@field Temperature ATIS.Soundfile
---@field Thousand ATIS.Soundfile
---@field ThunderStorm ATIS.Soundfile
---@field TimeLocal ATIS.Soundfile
---@field TimeZulu ATIS.Soundfile
---@field TowerFrequency ATIS.Soundfile
---@field Visibilty ATIS.Soundfile
---@field WeatherPhenomena ATIS.Soundfile
---@field WindFrom ATIS.Soundfile
---@field ILSFrequency ATIS.Soundfile
---@field InnerNDBFrequency ATIS.Soundfile
---@field OuterNDBFrequency ATIS.Soundfile
---@field PRMGChannel ATIS.Soundfile
---@field RSBNChannel ATIS.Soundfile
---@field RunwayLength ATIS.Soundfile
---@field TACANChannel ATIS.Soundfile
---@field VORFrequency ATIS.Soundfile
ATIS.Sound = {
  ActiveRunway = { filename = "ActiveRunway.ogg", duration = 0.85 },
  ActiveRunwayDeparture = { filename = "ActiveRunwayDeparture.ogg", duration = 1.50 },
  ActiveRunwayArrival = { filename = "ActiveRunwayArrival.ogg", duration = 1.38 },
  AdviceOnInitial = { filename = "AdviceOnInitial.ogg", duration = 2.98 },
  Airport = { filename = "Airport.ogg", duration = 0.55 },
  Altimeter = { filename = "Altimeter.ogg", duration = 0.91 },
  At = { filename = "At.ogg", duration = 0.32 },
  CloudBase = { filename = "CloudBase.ogg", duration = 0.69 },
  CloudCeiling = { filename = "CloudCeiling.ogg", duration = 0.53 },
  CloudsBroken = { filename = "CloudsBroken.ogg", duration = 0.81 },
  CloudsFew = { filename = "CloudsFew.ogg", duration = 0.74 },
  CloudsNo = { filename = "CloudsNo.ogg", duration =  0.69},
  CloudsNotAvailable = { filename = "CloudsNotAvailable.ogg", duration = 2.64 },
  CloudsOvercast = { filename = "CloudsOvercast.ogg", duration = 0.82 },
  CloudsScattered = { filename = "CloudsScattered.ogg", duration = 0.89 },
  Decimal = { filename = "Decimal.ogg", duration = 0.71 },
  DegreesCelsius = { filename = "DegreesCelsius.ogg", duration = 1.08 },
  DegreesFahrenheit = { filename = "DegreesFahrenheit.ogg", duration = 1.07 },
  DewPoint = { filename = "DewPoint.ogg", duration = 0.59 },
  Dust = { filename = "Dust.ogg", duration = 0.37 },
  Elevation = { filename = "Elevation.ogg", duration = 0.92 },
  EndOfInformation = { filename = "EndOfInformation.ogg", duration = 1.24 },
  Feet = { filename = "Feet.ogg", duration = 0.34 },
  Fog = { filename = "Fog.ogg", duration = 0.41 },
  Gusting = { filename = "Gusting.ogg", duration = 0.58 },
  HectoPascal = { filename = "HectoPascal.ogg", duration = 0.92 },
  Hundred = { filename = "Hundred.ogg", duration = 0.53 },
  ILSFrequency = { filename = "ILSFrequency.ogg", duration = 1.30 },
  InchesOfMercury = { filename = "InchesOfMercury.ogg", duration = 1.26 },
  Information = { filename = "Information.ogg", duration = 0.99 },  
  InnerNDBFrequency = { filename = "InnerNDBFrequency.ogg", duration = 1.69 },
  Kilometers = { filename = "Kilometers.ogg", duration = 0.93 },
  Knots = { filename = "Knots.ogg", duration = 0.46 },
  Left = { filename = "Left.ogg", duration = 0.41 },
  MegaHertz = { filename = "MegaHertz.ogg", duration = 0.83 },
  Meters = { filename = "Meters.ogg", duration = 0.55 },
  MetersPerSecond = { filename = "MetersPerSecond.ogg", duration = 1.03 },
  Miles = { filename = "Miles.ogg", duration = 0.44 },
  MillimetersOfMercury = { filename = "MillimetersOfMercury.ogg", duration = 1.59 },
  Minus = { filename = "Minus.ogg", duration = 0.55 },
  N0 = { filename = "N-0.ogg", duration = 0.52 },
  N1 = { filename = "N-1.ogg", duration = 0.35 },
  N2 = { filename = "N-2.ogg", duration = 0.41 },
  N3 = { filename = "N-3.ogg", duration = 0.34 },
  N4 = { filename = "N-4.ogg", duration = 0.37 },
  N5 = { filename = "N-5.ogg", duration = 0.40 },
  N6 = { filename = "N-6.ogg", duration = 0.46 },
  N7 = { filename = "N-7.ogg", duration = 0.52 },
  N8 = { filename = "N-8.ogg", duration = 0.36 },
  N9 = { filename = "N-9.ogg", duration = 0.51 },
  NauticalMiles = { filename = "NauticalMiles.ogg", duration = 0.93 },
  None = { filename = "None.ogg", duration = 0.33 },
  OuterNDBFrequency = { filename = "OuterNDBFrequency.ogg", duration = 1.70 },
  PRMGChannel = { filename = "PRMGChannel.ogg", duration = 1.27 },  
  QFE = { filename = "QFE.ogg", duration = 0.90 },
  QNH = { filename = "QNH.ogg", duration = 0.94 },
  Rain = { filename = "Rain.ogg", duration = 0.35 },
  Right = { filename = "Right.ogg", duration = 0.31 },
  RSBNChannel = { filename = "RSBNChannel.ogg", duration = 1.26 },
  RunwayLength = { filename = "RunwayLength.ogg", duration = 0.81 },    
  Snow = { filename = "Snow.ogg", duration = 0.40 },
  SnowStorm = { filename = "SnowStorm.ogg", duration = 0.73 },
  StatuteMiles = { filename = "StatuteMiles.ogg", duration = 0.90 },
  SunriseAt = { filename = "SunriseAt.ogg", duration = 0.82 },
  SunsetAt = { filename = "SunsetAt.ogg", duration = 0.87 },
  TACANChannel = { filename = "TACANChannel.ogg", duration = 0.81 },  
  Temperature = { filename = "Temperature.ogg", duration = 0.70 },
  Thousand = { filename = "Thousand.ogg", duration = 0.58 },
  ThunderStorm = { filename = "ThunderStorm.ogg", duration = 0.79 },
  TimeLocal = { filename = "TimeLocal.ogg", duration = 0.83 },
  TimeZulu = { filename = "TimeZulu.ogg", duration = 0.83 },
  TowerFrequency = { filename = "TowerFrequency.ogg", duration = 1.05 },
  Visibilty = { filename = "Visibility.ogg", duration = 1.16 },
  VORFrequency = { filename = "VORFrequency.ogg", duration = 1.28 },  
  WeatherPhenomena = { filename = "WeatherPhenomena.ogg", duration = 1.09 },
  WindFrom = { filename = "WindFrom.ogg", duration = 0.63 },
  Zulu = { filename = "Zulu.ogg", duration = 0.51 },
}

ATIS.Messages = {
  EN =
  {
    HOURS = "hours",
    TIME = "Hours",
    NOCLOUDINFO = "Cloud coverage information not available",
    OVERCAST = "Overcast",
    BROKEN = "Broken clouds",
    SCATTERED = "Scattered clouds",
    FEWCLOUDS = "Few clouds",
    NOCLOUDS = "No clouds",
    AIRPORT = "Airport",
    INFORMATION ="Information",
    SUNRISEAT = "Sunrise at %s local time",
    SUNSETAT = "Sunset at %s local time",
    WINDFROMMS = "Wind from %s at %s m/s",
    WINDFROMKNOTS = "Wind from %s at %s knots",
    GUSTING = "gusting",
    VISIKM = "Visibility %s km",
    VISISM = "Visibility %s SM",
    RAIN = "rain",
    TSTORM = "thunderstorm",
    SNOW = "snow",
    SSTROM = "snowstorm",
    FOG = "fog",
    DUST = "dust",
    PHENOMENA = "Weather phenomena",
    CLOUDBASEM = "Cloud base %s, ceiling %s meters",
    CLOUDBASEFT = "Cloud base %s, ceiling %s feet",
    TEMPERATURE = "Temperature",
    DEWPOINT = "Dew point",
    ALTIMETER = "Altimeter",
    ACTIVERUN = "Active runway departure",
    ACTIVELANDING = "Active runway arrival",
    LEFT = "Left",
    RIGHT = "Right",
    RWYLENGTH = "Runway length",
    METERS = "meters",
    FEET = "feet",
    ELEVATION = "Elevation",
    TOWERFREQ = "Tower frequency",
    ILSFREQ = "ILS frequency",
    OUTERNDB = "Outer NDB frequency",
    INNERNDB = "Inner NDB frequency",
    VORFREQ = "VOR frequency",
    VORFREQTTS = "V O R frequency",
    TACANCH = "TACAN channel %dX Ray",
    RSBNCH = "RSBN channel",
    PRMGCH = "PRMG channel",
    ADVISE = "Advise on initial contact, you have information",
    STATUTE = "statute miles",
    DEGREES = "degrees Celsius",
    FAHRENHEIT = "degrees Fahrenheit",
    INCHHG = "inches of Mercury",
    MMHG = "millimeters of Mercury",
    HECTO = "hectopascals",
    METERSPER = "meters per second",
    TACAN = "tackan",
    FARP = "farp",
    DELIMITER = "point", -- decimal delimiter
  },
  DE =
  {
    HOURS = "Uhr",
    TIME = "Zeit",
    NOCLOUDINFO = "Informationen über Wolken nicht verfuegbar",
    OVERCAST = "Geschlossene Wolkendecke",
    BROKEN = "Stark bewoelkt",
    SCATTERED = "Bewoelkt",
    FEWCLOUDS = "Leicht bewoelkt",
    NOCLOUDS = "Klar",
    AIRPORT = "Flughafen",
    INFORMATION ="Information",
    SUNRISEAT = "Sonnenaufgang um %s lokaler Zeit",
    SUNSETAT = "Sonnenuntergang um %s lokaler Zeit",
    WINDFROMMS = "Wind aus %s mit %s m/s",
    WINDFROMKNOTS = "Wind aus %s mit %s Knoten",
    GUSTING = "boeig",
    VISIKM = "Sichtweite %s km",
    VISISM = "Sichtweite %s Meilen",
    RAIN = "Regen",
    TSTORM = "Gewitter",
    SNOW = "Schnee",
    SSTROM = "Schneesturm",
    FOG = "Nebel",
    DUST = "Staub",
    PHENOMENA = "Wetter Phaenomene",
    CLOUDBASEM = "Wolkendecke von %s bis %s Meter",
    CLOUDBASEFT = "Wolkendecke von %s bis %s Fuß",
    TEMPERATURE = "Temperatur",
    DEWPOINT = "Taupunkt",
    ALTIMETER = "Hoehenmesser",
    ACTIVERUN = "Aktive Startbahn",
    ACTIVELANDING = "Aktive Landebahn",
    LEFT = "Links",
    RIGHT = "Rechts",
    RWYLENGTH = "Startbahn",
    METERS = "Meter",
    FEET = "Fuß",
    ELEVATION = "Hoehe",
    TOWERFREQ = "Kontrollturm Frequenz",
    ILSFREQ = "ILS Frequenz",
    OUTERNDB = "Aeussere NDB Frequenz",
    INNERNDB = "Innere NDB Frequenz",
    VORFREQ = "VOR Frequenz",
    VORFREQTTS = "V O R Frequenz",
    TACANCH = "TACAN Kanal %d Xaver",
    RSBNCH = "RSBN Kanal",
    PRMGCH = "PRMG Kanal",
    ADVISE = "Hinweis bei Erstkontakt, Sie haben Informationen",
    STATUTE = "englische Meilen",
    DEGREES = "Grad Celsius",
    FAHRENHEIT = "Grad Fahrenheit",
    INCHHG = "Inches H G",
    MMHG = "Millimeter H G",
    HECTO = "Hektopascal",
    METERSPER = "Meter pro Sekunde",
    TACAN = "Tackan",
    FARP = "Farp",
    DELIMITER = "Komma", -- decimal delimiter
  },
  ES =
  {
    HOURS = "horas",
    TIME = "horas",
    NOCLOUDINFO = "Información sobre capa de nubes no disponible",
    OVERCAST = "Nublado",
    BROKEN = "Nubes rotas",
    SCATTERED = "Nubes dispersas",
    FEWCLOUDS = "Ligeramente nublado",
    NOCLOUDS = "Despejado",
    AIRPORT = "Aeropuerto",
    INFORMATION ="Informacion",
    SUNRISEAT = "Amanecer a las %s hora local",
    SUNSETAT = "Puesta de sol a las %s hora local",
    WINDFROMMS = "Viento procedente de %s con %s m/s",
    WINDFROMKNOTS = "Viento de %s con %s nudos",
    GUSTING = "ráfagas",
    VISIKM = "Visibilidad %s km",
    VISISM = "Visibilidad %s millas",
    RAIN = "Lluvia",
    TSTORM = "Tormenta",
    SNOW = "Nieve",
    SSTROM = "Tormenta de nieve",
    FOG = "Niebla",
    DUST = "Polvo",
    PHENOMENA = "Fenómenos meteorológicos",
    CLOUDBASEM = "Capa de nubes de %s a %s metros",
    CLOUDBASEFT = "Capa de nubes de %s a %s pies",
    TEMPERATURE = "Temperatura",
    DEWPOINT = "Punto de rocio",
    ALTIMETER = "Altímetro",
    ACTIVERUN = "Pista activa",
    ACTIVELANDING = "Pista de aterrizaje activa",
    LEFT = "Izquierda",
    RIGHT = "Derecha",
    RWYLENGTH = "Longitud de pista",
    METERS = "Metro",
    FEET = "Pie",
    ELEVATION = "Elevación",
    TOWERFREQ = "Frecuencias de la torre de control",
    ILSFREQ = "Fecuencia ILS",
    OUTERNDB = "Frecuencia NDB externa",
    INNERNDB = "Frecuencia NDB interior",
    VORFREQ = "Frecuencia VOR",
    VORFREQTTS = "Frecuencia V O R",
    TACANCH = "Canal TACAN %d Xaver",
    RSBNCH = "Canal RSBN",
    PRMGCH = "Canal PRMG",
    ADVISE = "Avise en el contacto inicial a torre de que tiene la informacion",
    STATUTE = "Millas inglesas",
    DEGREES = "Grados Celsius",
    FAHRENHEIT = "Grados Fahrenheit",
    INCHHG = "Pulgadas de mercurio",
    MMHG = "Milímeteros de Mercurio",
    HECTO = "Hectopascales",
    METERSPER = "Metros por segundo",
    TACAN = "Tacan",
    FARP = "Farp",
    DELIMITER = "Punto", -- decimal delimiter
  },
  FR = {
    HOURS = "Heures",
    TIME = "Temps",
    NOCLOUDINFO = "Informations sur la couverture nuageuse non disponibles",
    OVERCAST = "Ciel couvert",
    BROKEN = "Nuages fragmentés",
    SCATTERED = "Nuages épars",
    FEWCLOUDS = "Nuages rares",
    NOCLOUDS = "Clair",
    AIRPORT = "Aéroport",
    INFORMATION ="Information",
    SUNRISEAT = "Levé du soleil à %s heure locale",
    SUNSETAT = "Couché du soleil à %s heure locale",
    WINDFROMMS = "Vent du %s pour %s mètres par seconde",
    WINDFROMKNOTS = "Vent du %s pour %s noeuds",
    GUSTING = "Rafale de vent",
    VISIKM = "Visibilité %s kilomètres",
    VISISM = "Visibilité %s Miles",
    RAIN = "Pluie",
    TSTORM = "Orage",
    SNOW = "Neige",
    SSTROM = "Tempête de neige",
    FOG = "Brouillard",
    DUST = "Poussière",
    PHENOMENA = "Phénomène météorologique",
    CLOUDBASEM = "Couverture nuageuse de %s à %s mètres",
    CLOUDBASEFT = "Couverture nuageuse de %s à %s pieds",
    TEMPERATURE = "Température",
    DEWPOINT = "Point de rosée",
    ALTIMETER = "Altimètre",
    ACTIVERUN = "Décollages piste",
    ACTIVELANDING = "Atterrissages piste",
    LEFT = "Gauche",
    RIGHT = "Droite",
    RWYLENGTH = "Longueur de piste",
    METERS = "Mètre",
    FEET = "Pieds",
    ELEVATION = "Hauteur",
    TOWERFREQ = "Fréquences de la tour",
    ILSFREQ = "Fréquences ILS",
    OUTERNDB = "Fréquences Outer NDB",
    INNERNDB = "Fréquences Inner NDB",
    VORFREQ = "Fréquences VOR",
    VORFREQTTS = "Fréquences V O R",
    TACANCH = "Canal TACAN %d",
    RSBNCH = "Canal RSBN",
    PRMGCH = "Canal PRMG",
    ADVISE = "Informez le contrôle que vous avez copié l'information",
    STATUTE = "Statute Miles",
    DEGREES = "Degré celcius",
    FAHRENHEIT = "Degré Fahrenheit",
    INCHHG = "Pouces de mercure",
    MMHG = "Millimètres de mercure",
    HECTO = "Hectopascals",
    METERSPER = "Mètres par seconde",
    TACAN = "TAKAN",
    FARP = "FARPE",
    DELIMITER = "Décimal", -- decimal delimiter
  }
}

ATIS.locale = "en"

---ATIS class version.
ATIS.version = "1.0.1"

---Create a new ATIS class object for a specific airbase.
---@param AirbaseName? string Name of the airbase.
---@param Frequency? number (Optional) Radio frequency in MHz. Default 143.00 MHz. When using **SRS** this can be passed as a table of multiple frequencies.
---@param Modulation? number (Optional) Radio modulation: 0=AM, 1=FM. Default 0=AM. See `radio.modulation.AM` and `radio.modulation.FM` enumerators. When using **SRS** this can be passed as a table of multiple modulations.
---@return ATIS # self
function ATIS:New(AirbaseName, Frequency, Modulation) end

---[Internal] Init localization
---@return ATIS # self
function ATIS:_InitLocalization() end

---Set locale for localized text-to-sound output via SRS, defaults to "en".
---@param locale? string Locale for localized text-to-sound output via SRS, defaults to "en".
---@return ATIS # self
function ATIS:SetLocale(locale) end

---Set sound files folder within miz file (not your local hard drive!).
---@param pathMain? string (Optional) Path to folder containing main sound files. Default "ATIS Soundfiles/". Mind the slash "/" at the end!
---@param pathAirports? string (Optional) Path folder containing the airport names sound files. Default is `"ATIS Soundfiles/<Map Name>"`, *e.g.* `"ATIS Soundfiles/Caucasus/"`.
---@param pathNato? string (Optional) Path folder containing the NATO alphabet sound files. Default is "ATIS Soundfiles/NATO Alphabet/".
---@return ATIS # self
function ATIS:SetSoundfilesPath(pathMain, pathAirports, pathNato) end

---Set the path to the csv file that contains information about the used sound files.
---The parameter file has to be located on your local disk (**not** inside the miz file).
---@param csvfile? string Full path to the csv file on your local disk.
---@return ATIS # self
function ATIS:SetSoundfilesInfo(csvfile) end

---Set airborne unit (airplane or helicopter), used to transmit radio messages including subtitles.
---Best is to place the unit on a parking spot of the airbase and set it to *uncontrolled* in the mission editor.
---@param unitname? string Name of the unit.
---@return ATIS # self
function ATIS:SetRadioRelayUnitName(unitname) end

---Set tower frequencies.
---@param freqs? table Table of frequencies in MHz. A single frequency can be given as a plain number (*i.e.* must not be table).
---@return ATIS # self
function ATIS:SetTowerFrequencies(freqs) end

---For SRS - Switch to only transmit if there are players on the server.
---@param Switch? boolean If true, only send SRS if there are alive Players.
---@return ATIS # self
function ATIS:SetTransmitOnlyWithPlayers(Switch) end

---Set active runway for **landing** operations. This can be used if the automatic runway determination via the wind direction gives incorrect results.
---For example, use this if there are two runways with the same directions.
---@param runway? string Active runway, *e.g.* "31L".
---@return ATIS # self
function ATIS:SetActiveRunway(runway) end

---Set the active runway for landing.
---@param runway? string (Optional) Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param preferleft? boolean (Optional) If true, perfer the left runway. If false, prefer the right runway. If nil (default), do not care about left or right.
---@return ATIS # self
function ATIS:SetActiveRunwayLanding(runway, preferleft) end

---Set the active runway for take-off.
---@param runway? string : Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param preferleft? boolean (Optional) If true, perfer the left runway. If false, prefer the right runway. If nil (default), do not care about left or right.
---@return ATIS # self
function ATIS:SetActiveRunwayTakeoff(runway, preferleft) end

---Give information on runway length.
---@return ATIS # self
function ATIS:SetRunwayLength() end

---Give information on runway length.
---@return ATIS # self
function ATIS:SetRunwayLength() end

---Give information on airfield elevation
---@return ATIS # self
function ATIS:SetElevation() end

---Set radio power. Note that this only applies if no relay unit is used.
---@param power? number (Optional) Radio power in Watts. Default 100 W.
---@return ATIS # self
function ATIS:SetRadioPower(power) end

---Use F10 map mark points.
---@param switch? boolean (Optional) If *true* or *nil*, marks are placed on F10 map. If *false* this feature is set to off (default).
---@return ATIS # self
function ATIS:SetMapMarks(switch) end

---Return the complete SRS Text block, if at least generated once. Else nil.
---@return string # SRSText
function ATIS:GetSRSText() end

---Set magnetic runway headings as depicted on the runway, *e.g.* "13" for 130° or "25L" for the left runway with magnetic heading 250°.
---@param headings? table Magnetic headings. Inverse (-180°) headings are added automatically. You only need to specify one heading per runway direction. "L"eft and "R" right can also be appended.
---@return ATIS # self
function ATIS:SetRunwayHeadingsMagnetic(headings) end

---Set duration how long subtitles are displayed.
---@param duration? number (Optional) Duration in seconds. Default 10 seconds.
---@return ATIS # self
function ATIS:SetSubtitleDuration(duration) end

---Set unit system to metric units.
---@return ATIS # self
function ATIS:SetMetricUnits() end

---Set unit system to imperial units.
---@return ATIS # self
function ATIS:SetImperialUnits() end

---Set pressure unit to millimeters of mercury (mmHg).
---Default is inHg for imperial and hPa (=mBar) for metric units.
---@return ATIS # self
function ATIS:SetPressureMillimetersMercury() end

---Set temperature to be given in degrees Fahrenheit.
---@return ATIS # self
function ATIS:SetTemperatureFahrenheit() end

---Set relative humidity. This is used to approximately calculate the dew point.
---Note that the dew point is only an artificial information as DCS does not have an atmospheric model that includes humidity (yet).
---@param Humidity? number (Optional) Relative Humidity, i.e. a number between 0 and 100 %. Default is 50 %.
---@return ATIS # self
function ATIS:SetRelativeHumidity(Humidity) end

---Report altimeter QNH.
---@param switch? boolean If true or nil, report altimeter QHN. If false, report QFF.
---@return ATIS # self
function ATIS:SetAltimeterQNH(switch) end

---Additionally report altimeter QNH/QFE in hPa, even if not set to metric.
---@param switch? boolean If true or nil, report mBar/hPa in addition.
---@return ATIS # self
function ATIS:SetReportmBar(switch) end

---Additionally report free text, only working with SRS(!)
---@param text? string The text to report at the end of the ATIS message, e.g. runway closure, warnings, etc.
---@return ATIS # self
function ATIS:SetAdditionalInformation(text) end

---Suppresses QFE readout. Default is to report both QNH and QFE.
---@return ATIS # self
function ATIS:ReportQNHOnly() end

---Set magnetic declination/variation at the airport.
---
---Default is per map:
---
---* Caucasus +6 (East), year ~ 2011
---* NTTR +12 (East), year ~ 2011
---* Normandy -10 (West), year ~ 1944
---* Persian Gulf +2 (East), year ~ 2011
---
---To get *true* from *magnetic* heading one has to add easterly or substract westerly variation, e.g
---
---A magnetic heading of 180° corresponds to a true heading of
---
---  * 186° on the Caucaus map
---  * 192° on the Nevada map
---  * 170° on the Normandy map
---  * 182° on the Persian Gulf map
---
---Likewise, to convert *true* into *magnetic* heading, one has to substract easterly and add westerly variation.
---
---Or you make your life simple and just include the sign so you don't have to bother about East/West.
---@param magvar? number (Optional) Magnetic variation in degrees. Positive for easterly and negative for westerly variation. Default is magnatic declinaton of the used map, c.f. @{Utilities.Utils#UTILS.GetMagneticDeclination}.
---@return ATIS # self
function ATIS:SetMagneticDeclination(magvar) end

---Explicitly set correction of magnetic to true heading for runways.
---@param correction? number Correction of magnetic to true heading for runways in degrees.
---@return ATIS # self
function ATIS:SetRunwayCorrectionMagnetic2True(correction) end

---Set wind direction (from) to be reported as *true* heading. Default is magnetic.
---@return ATIS # self
function ATIS:SetReportWindTrue() end

---Set time local difference with respect to Zulu time.
---Default is per map:
---
---   * Caucasus +4
---   * Nevada -8
---   * Normandy 0
---   * Persian Gulf +4
---   * The Channel +2 (should be 0)
---@param delta? number Time difference in hours.
---@return ATIS # self
function ATIS:SetZuluTimeDifference(delta) end

---Suppresses local time, sunrise, and sunset. Default is to report all these times.
---@return ATIS # self
function ATIS:ReportZuluTimeOnly() end

---Add ILS station. Note that this can be runway specific.
---@param frequency? number ILS frequency in MHz.
---@param runway? string (Optional) Runway for which the given ILS frequency applies. Default all (*nil*).
---@return ATIS # self
function ATIS:AddILS(frequency, runway) end

---Set VOR station.
---@param frequency? number VOR frequency.
---@return ATIS # self
function ATIS:SetVOR(frequency) end

---Add outer NDB. Note that this can be runway specific.
---@param frequency? number NDB frequency in MHz.
---@param runway? string (Optional) Runway for which the given NDB frequency applies. Default all (*nil*).
---@return ATIS # self
function ATIS:AddNDBouter(frequency, runway) end

---Add inner NDB. Note that this can be runway specific.
---@param frequency? number NDB frequency in MHz.
---@param runway? string (Optional) Runway for which the given NDB frequency applies. Default all (*nil*).
---@return ATIS # self
function ATIS:AddNDBinner(frequency, runway) end

---Set TACAN channel.
---@param channel? number TACAN channel.
---@return ATIS # self
function ATIS:SetTACAN(channel) end

---Set RSBN channel.
---@param channel? number RSBN channel.
---@return ATIS # self
function ATIS:SetRSBN(channel) end

---Add PRMG channel. Note that this can be runway specific.
---@param channel? number PRMG channel.
---@param runway? string (Optional) Runway for which the given PRMG channel applies. Default all (*nil*).
---@return ATIS # self
function ATIS:AddPRMG(channel, runway) end

---Place marks with runway data on the F10 map.
---@param markall? boolean (Optional) If true, mark all runways of the map. By default only the current ATIS runways are marked.
function ATIS:MarkRunways(markall) end

---Use SRS Simple-Text-To-Speech for transmissions. No sound files necessary.`SetSRS()` will try to use as many attributes configured with {Sound.SRS#MSRS.LoadConfigFile}() as possible.
---@param PathToSRS? string (Optional) Path to SRS directory (only necessary if SRS exe backend is used).
---@param Gender? string (Optional) Gender: "male" or "female" (default).
---@param Culture? string (Optional) Culture, e.g. "en-GB" (default).
---@param Voice? string (Optional) Specific voice. Overrides `Gender` and `Culture`.
---@param Port? number (Optional) SRS port. Default 5002.
---@param GoogleKey? string (Optional) Path to Google JSON-Key (SRS exe backend) or Google API key (DCS-gRPC backend).
---@param Provider? string (Optional) TTS Provider to be used.
---@param Speaker? string (Optional) Use a specific speaker for a voice if Piper is used as provider (only Hound-TTS backend).
---@return ATIS # self
function ATIS:SetSRS(PathToSRS, Gender, Culture, Voice, Port, GoogleKey, Provider, Speaker) end

---Set an alternative provider to the one set in your MSRS configuration file.
---@param Provider? string The provider to use. Known providers are: `MSRS.Provider.WINDOWS` and `MSRS.Provider.GOOGLE`
---@return ATIS # self
function ATIS:SetSRSProvider(Provider) end

---Set the time interval between radio queue updates.
---@param TimeInterval? number (Optional) Interval in seconds. Default 5 sec.
---@return ATIS # self
function ATIS:SetQueueUpdateTime(TimeInterval) end

---Get the coalition of the associated airbase.
---@return number # Coalition of the associated airbase.
function ATIS:GetCoalition() end

---Start ATIS FSM.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ATIS:onafterStart(From, Event, To) end

---Update status.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ATIS:onafterStatus(From, Event, To) end

---Check if radio queue is empty. If so, start broadcasting the message again.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ATIS:onafterCheckQueue(From, Event, To) end

---Broadcast ATIS radio message.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function ATIS:onafterBroadcast(From, Event, To) end

---Text report of ATIS information. Information delimitor is a semicolon ";" and a line break "\n".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Text? string Report text.
function ATIS:onafterReport(From, Event, To, Text) end

---Base captured
---@param EventData? EVENTDATA Event data.
function ATIS:OnEventBaseCaptured(EventData) end

---Update F10 map marker.
---@param information? string Information tag text.
---@param runact? string Active runway text.
---@param wind? string Wind text.
---@param altimeter? string Altimeter text.
---@param temperature? string Temperature text.
---@return number # Marker ID.
function ATIS:UpdateMarker(information, runact, wind, altimeter, temperature) end

---Get active runway runway.
---@param Takeoff? boolean (Optional) If `true`, get runway for takeoff. Default is for landing.
---@return string # Active runway, e.g. "31" for 310 deg.
---@return boolean # Use Left=true, Right=false, or nil.
function ATIS:GetActiveRunway(Takeoff) end

---Get runway from user supplied magnetic heading.
---@param windfrom? number Wind direction (from) in degrees.
---@return string # Runway magnetic heading divided by ten (and rounded). Eg, "13" for 130°.
function ATIS:GetMagneticRunway(windfrom) end

---Get nav aid data.
---@param navpoints? table Nav points data table.
---@param runway? string (Active) runway, *e.g.* "31".
---@param left? boolean If *true*, left runway, if *false, right, else does not matter.
---@return ATIS.NavPoint # Nav point data table.
function ATIS:GetNavPoint(navpoints, runway, left) end

---Get runway heading without left or right info.
---@param runway? string Runway heading, *e.g.* "31L".
---@return string # Runway heading without left or right, *e.g.* "31".
function ATIS:GetRunwayWithoutLR(runway) end

---Get info if left or right runway is active.
---@param runway? string Runway heading, *e.g.* "31L".
---@return boolean # If *true*, left runway is active. If *false*, right runway. If *nil*, neither applies.
function ATIS:GetRunwayLR(runway) end

---Transmission via RADIOQUEUE.
---@param sound? ATIS.Soundfile|number|string ATIS sound object.
---@param interval? number Interval in seconds after the last transmission finished.
---@param subtitle? string Subtitle of the transmission.
---@param path? string (Optional) Path to sound file. Default `self.soundpath`.
function ATIS:Transmission(sound, interval, subtitle, path) end

---Play all audio files.
function ATIS:SoundCheck() end

---Get weather of this mission from env.mission.weather variable.
---@return table # Clouds table which has entries "thickness", "density", "base", "iprecptns".
---@return number # Visibility distance in meters.
---@return number # Ground turbulence in m/s.
---@return table # Fog table, which has entries "thickness", "visibility" or nil if fog is disabled in the mission.
---@return number # Dust density or nil if dust is disabled in the mission.
---@return boolean # static If true, static weather is used. If false, dynamic weather is used.
function ATIS:GetMissionWeather() end

---Get thousands of a number.
---@param n? number Number, *e.g.* 4359.
---@return string # Thousands of n, *e.g.* "4" for 4359.
---@return string # Hundreds of n, *e.g.* "4" for 4359 because its rounded.
function ATIS:_GetThousandsAndHundreds(n) end

---Triggers the FSM event "Start". Starts the ATIS.
function ATIS:Start() end

---Triggers the FSM event "Start" after a delay.
---@param delay? number Delay in seconds.
function ATIS:__Start(delay) end

---Triggers the FSM event "Stop". Stops the ATIS.
function ATIS:Stop() end

---Triggers the FSM event "Stop" after a delay.
---@param delay? number Delay in seconds.
function ATIS:__Stop(delay) end

---Triggers the FSM event "Status".
function ATIS:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function ATIS:__Status(delay) end

---Triggers the FSM event "Broadcast".
function ATIS:Broadcast() end

---Triggers the FSM event "Broadcast" after a delay.
---@param delay? number Delay in seconds.
function ATIS:__Broadcast(delay) end

---Triggers the FSM event "CheckQueue".
function ATIS:CheckQueue() end

---Triggers the FSM event "CheckQueue" after a delay.
---@param delay? number Delay in seconds.
function ATIS:__CheckQueue(delay) end

---Triggers the FSM event "Report".
---@param Text? string Report text.
function ATIS:Report(Text) end

---Triggers the FSM event "Report" after a delay.
---@param delay? number Delay in seconds.
---@param Text? string Report text.
function ATIS:__Report(delay, Text) end

---On after "Report" event user function.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Text? string Report text.
function ATIS:OnAfterReport(From, Event, To, Text) end
