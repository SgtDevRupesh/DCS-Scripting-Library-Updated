---@meta

---@class AIRBASE.Runway
---@field name string Runway name.
---@field idx string Runway ID: heading 070° ==> idx="07". Mostly same as magheading.
---@field heading number True heading of the runway in degrees.
---@field magheading number Magnetic heading of the runway in degrees. This is what is marked on the runway.
---@field length number Length of runway in meters.
---@field width number Width of runway in meters.
---@field zone ZONE_POLYGON Runway zone.
---@field center COORDINATE Center of the runway.
---@field position COORDINATE Position of runway start.
---@field endpoint COORDINATE End point of runway.
---@field isLeft boolean If `true`, this is the left of two parallel runways. If `false`, this is the right of two runways. If `nil`, no parallel runway exists.

---@class AIRBASE.ParkingSpot
---@field Coordinate COORDINATE Coordinate of the parking spot.
---@field TerminalID number Terminal ID of the spot. Generally, this is not the same number as displayed in the mission editor.
---@field TerminalType AIRBASE.TerminalType Type of the spot, i.e. for which type of aircraft it can be used.
---@field TOAC boolean Takeoff or landing aircarft. I.e. this stop is occupied currently by an aircraft until it took of or until it landed.
---@field Free boolean This spot is currently free, i.e. there is no alive aircraft on it at the present moment.
---@field TerminalID0 number Unknown what this means. If you know, please tell us!
---@field DistToRwy number Distance to runway in meters. Currently bugged and giving the same number as the TerminalID.
---@field AirbaseName string Name of the airbase.
---@field MarkerID number Numerical ID of marker placed at parking spot.
---@field Marker MARKER The marker on the F10 map.
---@field ClientSpot string If `true`, this is a parking spot of a client aircraft.
---@field ClientName string Client unit name of this spot.
---@field Status string Status of spot e.g. `AIRBASE.SpotStatus.FREE`.
---@field OccupiedBy string Name of the aircraft occupying the spot or "unknown". Can be *nil* if spot is not occupied.
---@field ReservedBy string Name of the aircraft for which this spot is reserved. Can be *nil* if spot is not reserved.

---@class AIRBASE : POSITIONABLE
---@field ClassName string Name of the class, i.e. "AIRBASE".
---@field CategoryName table Names of airbase categories.
---@field AirbaseName string Name of the airbase.
---@field AirbaseID number Airbase ID.
---@field AirbaseZone ZONE Circular zone around the airbase with a radius of 2500 meters. For ships this is a ZONE_UNIT object.
---@field category number Airbase category.
---@field descriptors table DCS descriptors.
---@field isAirdrome boolean Airbase is an airdrome.
---@field isHelipad boolean Airbase is a helipad.
---@field isShip boolean Airbase is a ship.
---@field isZell boolean Airbase is a ZELL Booster.
---@field parking table Parking spot data.
---@field parkingByID table Parking spot data table with ID as key.
---@field parkingWhitelist table List of parking spot terminal IDs considered for spawning.
---@field parkingBlacklist table List of parking spot terminal IDs **not** considered for spawning.
---@field parkingCircle ZONE_RADIUS Minimum bounding circle enclosing all parking spots.
---@field runways table Runways of airdromes.
---@field runwayLanding AIRBASE.Runway Runway used for landing.
---@field runwayTakeoff AIRBASE.Runway Runway used for takeoff.
---@field storage STORAGE The DCS warehouse storage.
AIRBASE = {
  ClassName = "AIRBASE",
  CategoryName = {
    [Airbase.Category.AIRDROME] = "Airdrome",
    [Airbase.Category.HELIPAD] = "Helipad",
    [Airbase.Category.SHIP] = "Ship",
  },
  activerwyno = nil,
}

---Airbases of the Caucasus map
---
---* `AIRBASE.Caucasus.Anapa_Vityazevo` Anapa-Vityazevo
---* `AIRBASE.Caucasus.Batumi` Batumi
---* `AIRBASE.Caucasus.Beslan` Beslan
---* `AIRBASE.Caucasus.Gelendzhik` Gelendzhik
---* `AIRBASE.Caucasus.Gudauta` Gudauta
---* `AIRBASE.Caucasus.Kobuleti` Kobuleti
---* `AIRBASE.Caucasus.Krasnodar_Center` Krasnodar-Center
---* `AIRBASE.Caucasus.Krasnodar_Pashkovsky` Krasnodar-Pashkovsky
---* `AIRBASE.Caucasus.Krymsk` Krymsk
---* `AIRBASE.Caucasus.Kutaisi` Kutaisi
---* `AIRBASE.Caucasus.Maykop_Khanskaya` Maykop-Khanskaya
---* `AIRBASE.Caucasus.Mineralnye_Vody` Mineralnye Vody
---* `AIRBASE.Caucasus.Mozdok` Mozdok
---* `AIRBASE.Caucasus.Nalchik` Nalchik
---* `AIRBASE.Caucasus.Novorossiysk` Novorossiysk
---* `AIRBASE.Caucasus.Senaki_Kolkhi` Senaki-Kolkhi
---* `AIRBASE.Caucasus.Sochi_Adler` Sochi-Adler
---* `AIRBASE.Caucasus.Soganlug` Soganlug
---* `AIRBASE.Caucasus.Sukhumi_Babushara` Sukhumi-Babushara
---* `AIRBASE.Caucasus.Tbilisi_Lochini` Tbilisi-Lochini
---* `AIRBASE.Caucasus.Vaziani` Vaziani
AIRBASE.Caucasus = {
  ["Anapa_Vityazevo"] = "Anapa-Vityazevo",
  ["Batumi"] = "Batumi",
  ["Beslan"] = "Beslan",
  ["Gelendzhik"] = "Gelendzhik",
  ["Gudauta"] = "Gudauta",
  ["Kobuleti"] = "Kobuleti",
  ["Krasnodar_Center"] = "Krasnodar-Center",
  ["Krasnodar_Pashkovsky"] = "Krasnodar-Pashkovsky",
  ["Krymsk"] = "Krymsk",
  ["Kutaisi"] = "Kutaisi",
  ["Maykop_Khanskaya"] = "Maykop-Khanskaya",
  ["Mineralnye_Vody"] = "Mineralnye Vody",
  ["Mozdok"] = "Mozdok",
  ["Nalchik"] = "Nalchik",
  ["Novorossiysk"] = "Novorossiysk",
  ["Senaki_Kolkhi"] = "Senaki-Kolkhi",
  ["Sochi_Adler"] = "Sochi-Adler",
  ["Soganlug"] = "Soganlug",
  ["Sukhumi_Babushara"] = "Sukhumi-Babushara",
  ["Tbilisi_Lochini"] = "Tbilisi-Lochini",
  ["Vaziani"] = "Vaziani",
}

---Airbases of the Nevada map
---
---* `AIRBASE.Nevada.Beatty` Beatty
---* `AIRBASE.Nevada.Boulder_City` Boulder City
---* `AIRBASE.Nevada.Creech` Creech
---* `AIRBASE.Nevada.Echo_Bay` Echo Bay
---* `AIRBASE.Nevada.Groom_Lake` Groom Lake
---* `AIRBASE.Nevada.Henderson_Executive` Henderson Executive
---* `AIRBASE.Nevada.Jean` Jean
---* `AIRBASE.Nevada.Laughlin` Laughlin
---* `AIRBASE.Nevada.Lincoln_County` Lincoln County
---* `AIRBASE.Nevada.McCarran_International` McCarran International
---* `AIRBASE.Nevada.Mesquite` Mesquite
---* `AIRBASE.Nevada.Mina` Mina
---* `AIRBASE.Nevada.Nellis` Nellis
---* `AIRBASE.Nevada.North_Las_Vegas` North Las Vegas
---* `AIRBASE.Nevada.Pahute_Mesa` Pahute Mesa
---* `AIRBASE.Nevada.Tonopah` Tonopah
---* `AIRBASE.Nevada.Tonopah_Test_Range` Tonopah Test Range
AIRBASE.Nevada = {
  ["Beatty"] = "Beatty",
  ["Boulder_City"] = "Boulder City",
  ["Creech"] = "Creech",
  ["Echo_Bay"] = "Echo Bay",
  ["Groom_Lake"] = "Groom Lake",
  ["Henderson_Executive"] = "Henderson Executive",
  ["Jean"] = "Jean",
  ["Laughlin"] = "Laughlin",
  ["Lincoln_County"] = "Lincoln County",
  ["McCarran_International"] = "McCarran International",
  ["Mesquite"] = "Mesquite",
  ["Mina"] = "Mina",
  ["Nellis"] = "Nellis",
  ["North_Las_Vegas"] = "North Las Vegas",
  ["Pahute_Mesa"] = "Pahute Mesa",
  ["Tonopah"] = "Tonopah",
  ["Tonopah_Test_Range"] = "Tonopah Test Range",
}

---Airbases of the Normandy map
---
---* `AIRBASE.Normandy.Abbeville_Drucat` Abbeville Drucat
---* `AIRBASE.Normandy.Alderney` Alderney
---* `AIRBASE.Normandy.Amiens_Glisy` Amiens-Glisy
---* `AIRBASE.Normandy.Argentan` Argentan
---* `AIRBASE.Normandy.Avranches_Le_Val_Saint_Pere` Avranches Le Val-Saint-Pere
---* `AIRBASE.Normandy.Azeville` Azeville
---* `AIRBASE.Normandy.Barville` Barville
---* `AIRBASE.Normandy.Bazenville` Bazenville
---* `AIRBASE.Normandy.Beaumont_le_Roger` Beaumont-le-Roger
---* `AIRBASE.Normandy.Beauvais_Tille` Beauvais-Tille
---* `AIRBASE.Normandy.Bembridg` Bembridg
---* `AIRBASE.Normandy.Beny_sur_Mer` Beny-sur-Mer
---* `AIRBASE.Normandy.Bernay_Saint_Martin` Bernay Saint Martin
---* `AIRBASE.Normandy.Beuzeville` Beuzeville
---* `AIRBASE.Normandy.Biggin_Hill` Biggin Hill
---* `AIRBASE.Normandy.Biniville` Biniville
---* `AIRBASE.Normandy.Broglie` Broglie
---* `AIRBASE.Normandy.Brucheville` Brucheville
---* `AIRBASE.Normandy.Cardonville` Cardonville
---* `AIRBASE.Normandy.Carpiquet` Carpiquet
---* `AIRBASE.Normandy.Chailey` Chailey
---* `AIRBASE.Normandy.Chippelle` Chippelle
---* `AIRBASE.Normandy.Conches` Conches
---* `AIRBASE.Normandy.Cormeilles_en_Vexin` Cormeilles-en-Vexin
---* `AIRBASE.Normandy.Creil` Creil
---* `AIRBASE.Normandy.Cretteville` Cretteville
---* `AIRBASE.Normandy.Cricqueville_en_Bessin` Cricqueville-en-Bessin
---* `AIRBASE.Normandy.Deanland` Deanland
---* `AIRBASE.Normandy.Deauville` Deauville
---* `AIRBASE.Normandy.Detling` Detling
---* `AIRBASE.Normandy.Deux_Jumeaux` Deux Jumeaux
---* `AIRBASE.Normandy.Dinan_Trelivan` Dinan-Trelivan
---* `AIRBASE.Normandy.Dunkirk_Mardyck` Dunkirk-Mardyck
---* `AIRBASE.Normandy.Eastchurch` Eastchurch
---* `AIRBASE.Normandy.Essay` Essay
---* `AIRBASE.Normandy.Evreux` Evreux
---* `AIRBASE.Normandy.Farnborough` Farnborough
---* `AIRBASE.Normandy.Fecamp_Benouville` Fecamp-Benouville
---* `AIRBASE.Normandy.Flers` Flers
---* `AIRBASE.Normandy.Ford` Ford
---* `AIRBASE.Normandy.Friston` Friston
---* `AIRBASE.Normandy.Funtington` Funtington
---* `AIRBASE.Normandy.Goulet` Goulet
---* `AIRBASE.Normandy.Gravesend` Gravesend
---* `AIRBASE.Normandy.Guernsey` Guernsey
---* `AIRBASE.Normandy.Guyancourt` Guyancourt
---* `AIRBASE.Normandy.Hauterive` Hauterive
---* `AIRBASE.Normandy.Hawkinge` Hawkinge
---* `AIRBASE.Normandy.Headcorn` Headcorn
---* `AIRBASE.Normandy.Heathrow` Heathrow
---* `AIRBASE.Normandy.High_Halden` High Halden
---* `AIRBASE.Normandy.Holmsley_South` Holmsley South
---* `AIRBASE.Normandy.Jersey` Jersey
---* `AIRBASE.Normandy.Kenley` Kenley
---* `AIRBASE.Normandy.Lantheuil` Lantheuil
---* `AIRBASE.Normandy.Lashenden` Lashenden
---* `AIRBASE.Normandy.Le_Molay` Le Molay
---* `AIRBASE.Normandy.Lessay` Lessay
---* `AIRBASE.Normandy.Lignerolles` Lignerolles
---* `AIRBASE.Normandy.Longues_sur_Mer` Longues-sur-Mer
---* `AIRBASE.Normandy.Lonrai` Lonrai
---* `AIRBASE.Normandy.Lymington` Lymington
---* `AIRBASE.Normandy.Lympne` Lympne
---* `AIRBASE.Normandy.Manston` Manston
---* `AIRBASE.Normandy.Maupertus` Maupertus
---* `AIRBASE.Normandy.Meautis` Meautis
---* `AIRBASE.Normandy.Merville_Calonne` Merville Calonne
---* `AIRBASE.Normandy.Needs_Oar_Point` Needs Oar Point
---* `AIRBASE.Normandy.Northolt` Northolt
---* `AIRBASE.Normandy.Odiham` Odiham
---* `AIRBASE.Normandy.Orly` Orly
---* `AIRBASE.Normandy.Picauville` Picauville
---* `AIRBASE.Normandy.Poix` Poix
---* `AIRBASE.Normandy.Ronai` Ronai
---* `AIRBASE.Normandy.Rouen_Boos` Rouen-Boos
---* `AIRBASE.Normandy.Rucqueville` Rucqueville
---* `AIRBASE.Normandy.Saint_Pierre_du_Mont` Saint Pierre du Mont
---* `AIRBASE.Normandy.Saint_Andre_de_lEure` Saint-Andre-de-lEure
---* `AIRBASE.Normandy.Saint_Aubin` Saint-Aubin
---* `AIRBASE.Normandy.Saint_Omer_Wizernes` Saint-Omer Wizernes
---* `AIRBASE.Normandy.Saint_Pol_Bryas` Saint-Pol-Bryas
---* `AIRBASE.Normandy.Sainte_Croix_sur_Mer` Sainte-Croix-sur-Mer
---* `AIRBASE.Normandy.Sainte_Laurent_sur_Mer` Sainte-Laurent-sur-Mer
---* `AIRBASE.Normandy.Sommervieu` Sommervieu
---* `AIRBASE.Normandy.Stoney_Cross` Stoney Cross
---* `AIRBASE.Normandy.Tangmere` Tangmere
---* `AIRBASE.Normandy.Triqueville` Triqueville
---* `AIRBASE.Normandy.Villacoublay` Villacoublay
---* `AIRBASE.Normandy.Vrigny` Vrigny
---* `AIRBASE.Normandy.West_Malling` West Malling
AIRBASE.Normandy = {
  ["Abbeville_Drucat"] = "Abbeville Drucat",
  ["Alderney"] = "Alderney",
  ["Amiens_Glisy"] = "Amiens-Glisy",
  ["Argentan"] = "Argentan",
  ["Avranches_Le_Val_Saint_Pere"] = "Avranches Le Val-Saint-Pere",
  ["Azeville"] = "Azeville",
  ["Barville"] = "Barville",
  ["Bazenville"] = "Bazenville",
  ["Beaumont_le_Roger"] = "Beaumont-le-Roger",
  ["Beauvais_Tille"] = "Beauvais-Tille",
  ["Bembridg"] = "Bembridg",
  ["Beny_sur_Mer"] = "Beny-sur-Mer",
  ["Bernay_Saint_Martin"] = "Bernay Saint Martin",
  ["Beuzeville"] = "Beuzeville",
  ["Biggin_Hill"] = "Biggin Hill",
  ["Biniville"] = "Biniville",
  ["Broglie"] = "Broglie",
  ["Brucheville"] = "Brucheville",
  ["Cardonville"] = "Cardonville",
  ["Carpiquet"] = "Carpiquet",
  ["Chailey"] = "Chailey",
  ["Chippelle"] = "Chippelle",
  ["Conches"] = "Conches",
  ["Cormeilles_en_Vexin"] = "Cormeilles-en-Vexin",
  ["Creil"] = "Creil",
  ["Cretteville"] = "Cretteville",
  ["Cricqueville_en_Bessin"] = "Cricqueville-en-Bessin",
  ["Deanland"] = "Deanland",
  ["Deauville"] = "Deauville",
  ["Detling"] = "Detling",
  ["Deux_Jumeaux"] = "Deux Jumeaux",
  ["Dinan_Trelivan"] = "Dinan-Trelivan",
  ["Dunkirk_Mardyck"] = "Dunkirk-Mardyck",
  ["Eastchurch"] = "Eastchurch",
  ["Essay"] = "Essay",
  ["Evreux"] = "Evreux",
  ["Farnborough"] = "Farnborough",
  ["Fecamp_Benouville"] = "Fecamp-Benouville",
  ["Flers"] = "Flers",
  ["Ford"] = "Ford",
  ["Friston"] = "Friston",
  ["Funtington"] = "Funtington",
  ["Goulet"] = "Goulet",
  ["Gravesend"] = "Gravesend",
  ["Guernsey"] = "Guernsey",
  ["Guyancourt"] = "Guyancourt",
  ["Hauterive"] = "Hauterive",
  ["Hawkinge"] = "Hawkinge",
  ["Headcorn"] = "Headcorn",
  ["Heathrow"] = "Heathrow",
  ["High_Halden"] = "High Halden",
  ["Holmsley_South"] = "Holmsley South",
  ["Jersey"] = "Jersey",
  ["Kenley"] = "Kenley",
  ["Lantheuil"] = "Lantheuil",
  ["Lashenden"] = "Lashenden",
  ["Le_Molay"] = "Le Molay",
  ["Lessay"] = "Lessay",
  ["Lignerolles"] = "Lignerolles",
  ["Longues_sur_Mer"] = "Longues-sur-Mer",
  ["Lonrai"] = "Lonrai",
  ["Lymington"] = "Lymington",
  ["Lympne"] = "Lympne",
  ["Manston"] = "Manston",
  ["Maupertus"] = "Maupertus",
  ["Meautis"] = "Meautis",
  ["Merville_Calonne"] = "Merville Calonne",
  ["Needs_Oar_Point"] = "Needs Oar Point",
  ["Northolt"] = "Northolt",
  ["Odiham"] = "Odiham",
  ["Orly"] = "Orly",
  ["Picauville"] = "Picauville",
  ["Poix"] = "Poix",
  ["Ronai"] = "Ronai",
  ["Rouen_Boos"] = "Rouen-Boos",
  ["Rucqueville"] = "Rucqueville",
  ["Saint_Pierre_du_Mont"] = "Saint Pierre du Mont",
  ["Saint_Andre_de_lEure"] = "Saint-Andre-de-lEure",
  ["Saint_Aubin"] = "Saint-Aubin",
  ["Saint_Omer_Wizernes"] = "Saint-Omer Wizernes",
  ["Saint_Pol_Bryas"] = "Saint-Pol-Bryas",
  ["Sainte_Croix_sur_Mer"] = "Sainte-Croix-sur-Mer",
  ["Sainte_Laurent_sur_Mer"] = "Sainte-Laurent-sur-Mer",
  ["Sommervieu"] = "Sommervieu",
  ["Stoney_Cross"] = "Stoney Cross",
  ["Tangmere"] = "Tangmere",
  ["Triqueville"] = "Triqueville",
  ["Villacoublay"] = "Villacoublay",
  ["Vrigny"] = "Vrigny",
  ["West_Malling"] = "West Malling",
}

---Airbases of the Persian Gulf map
---
---* `AIRBASE.PersianGulf.Abu_Dhabi_Intl` Abu Dhabi Intl
---* `AIRBASE.PersianGulf.Abu_Musa_Island` Abu Musa Island
---* `AIRBASE.PersianGulf.Al_Ain_Intl` Al Ain Intl
---* `AIRBASE.PersianGulf.Al_Dhafra_AFB` Al Dhafra AFB
---* `AIRBASE.PersianGulf.Al_Maktoum_Intl` Al Maktoum Intl
---* `AIRBASE.PersianGulf.Al_Minhad_AFB` Al Minhad AFB
---* `AIRBASE.PersianGulf.Al_Bateen` Al-Bateen
---* `AIRBASE.PersianGulf.Bandar_Abbas_Intl` Bandar Abbas Intl
---* `AIRBASE.PersianGulf.Bandar_Lengeh` Bandar Lengeh
---* `AIRBASE.PersianGulf.Bandar_e_Jask` Bandar-e-Jask
---* `AIRBASE.PersianGulf.Dubai_Intl` Dubai Intl
---* `AIRBASE.PersianGulf.Fujairah_Intl` Fujairah Intl
---* `AIRBASE.PersianGulf.Havadarya` Havadarya
---* `AIRBASE.PersianGulf.Jiroft` Jiroft
---* `AIRBASE.PersianGulf.Kerman` Kerman
---* `AIRBASE.PersianGulf.Khasab` Khasab
---* `AIRBASE.PersianGulf.Kish_Intl` Kish Intl
---* `AIRBASE.PersianGulf.Lar` Lar
---* `AIRBASE.PersianGulf.Lavan_Island` Lavan Island
---* `AIRBASE.PersianGulf.Liwa_AFB` Liwa AFB
---* `AIRBASE.PersianGulf.Qeshm_Island` Qeshm Island
---* `AIRBASE.PersianGulf.Quasoura_airport` Quasoura_airport
---* `AIRBASE.PersianGulf.Ras_Al_Khaimah_Intl` Ras Al Khaimah Intl
---* `AIRBASE.PersianGulf.Sas_Al_Nakheel` Sas Al Nakheel
---* `AIRBASE.PersianGulf.Sharjah_Intl` Sharjah Intl
---* `AIRBASE.PersianGulf.Shiraz_Intl` Shiraz Intl
---* `AIRBASE.PersianGulf.Sir_Abu_Nuayr` Sir Abu Nuayr
---* `AIRBASE.PersianGulf.Sirri_Island` Sirri Island
---* `AIRBASE.PersianGulf.Tunb_Island_AFB` Tunb Island AFB
---* `AIRBASE.PersianGulf.Tunb_Kochak` Tunb Kochak
AIRBASE.PersianGulf = {
  ["Abu_Dhabi_Intl"] = "Abu Dhabi Intl",
  ["Abu_Musa_Island"] = "Abu Musa Island",
  ["Al_Ain_Intl"] = "Al Ain Intl",
  ["Al_Dhafra_AFB"] = "Al Dhafra AFB",
  ["Al_Maktoum_Intl"] = "Al Maktoum Intl",
  ["Al_Minhad_AFB"] = "Al Minhad AFB",
  ["Al_Bateen"] = "Al-Bateen",
  ["Bandar_Abbas_Intl"] = "Bandar Abbas Intl",
  ["Bandar_Lengeh"] = "Bandar Lengeh",
  ["Bandar_e_Jask"] = "Bandar-e-Jask",
  ["Dubai_Intl"] = "Dubai Intl",
  ["Fujairah_Intl"] = "Fujairah Intl",
  ["Havadarya"] = "Havadarya",
  ["Jiroft"] = "Jiroft",
  ["Kerman"] = "Kerman",
  ["Khasab"] = "Khasab",
  ["Kish_Intl"] = "Kish Intl",
  ["Lar"] = "Lar",
  ["Lavan_Island"] = "Lavan Island",
  ["Liwa_AFB"] = "Liwa AFB",
  ["Qeshm_Island"] = "Qeshm Island",
  ["Quasoura_airport"] = "Quasoura_airport",
  ["Ras_Al_Khaimah_Intl"] = "Ras Al Khaimah Intl",
  ["Sas_Al_Nakheel"] = "Sas Al Nakheel",
  ["Sharjah_Intl"] = "Sharjah Intl",
  ["Shiraz_Intl"] = "Shiraz Intl",
  ["Sir_Abu_Nuayr"] = "Sir Abu Nuayr",
  ["Sirri_Island"] = "Sirri Island",
  ["Tunb_Island_AFB"] = "Tunb Island AFB",
  ["Tunb_Kochak"] = "Tunb Kochak",
}

---Airbases of the The Channel map
---
---* `AIRBASE.TheChannel.Abbeville_Drucat` Abbeville Drucat
---* `AIRBASE.TheChannel.Biggin_Hill` Biggin Hill
---* `AIRBASE.TheChannel.Detling` Detling
---* `AIRBASE.TheChannel.Dunkirk_Mardyck` Dunkirk Mardyck
---* `AIRBASE.TheChannel.Eastchurch` Eastchurch
---* `AIRBASE.TheChannel.Hawkinge` Hawkinge
---* `AIRBASE.TheChannel.Headcorn` Headcorn
---* `AIRBASE.TheChannel.High_Halden` High Halden
---* `AIRBASE.TheChannel.Lympne` Lympne
---* `AIRBASE.TheChannel.Manston` Manston
---* `AIRBASE.TheChannel.Merville_Calonne` Merville Calonne
---* `AIRBASE.TheChannel.Saint_Omer_Longuenesse` Saint Omer Longuenesse
AIRBASE.TheChannel = {
  ["Abbeville_Drucat"] = "Abbeville Drucat",
  ["Biggin_Hill"] = "Biggin Hill",
  ["Detling"] = "Detling",
  ["Dunkirk_Mardyck"] = "Dunkirk Mardyck",
  ["Eastchurch"] = "Eastchurch",
  ["Hawkinge"] = "Hawkinge",
  ["Headcorn"] = "Headcorn",
  ["High_Halden"] = "High Halden",
  ["Lympne"] = "Lympne",
  ["Manston"] = "Manston",
  ["Merville_Calonne"] = "Merville Calonne",
  ["Saint_Omer_Longuenesse"] = "Saint Omer Longuenesse",
}

AIRBASE.Syria = {
  ["Abu_al_Duhur"] = "Abu al-Duhur",
  ["Adana_Sakirpasa"] = "Adana Sakirpasa",
  ["Adiyaman"] = "Adiyaman",
  ["Akrotiri"] = "Akrotiri",
  ["Al_Dumayr"] = "Al-Dumayr",
  ["Al_Qusayr"] = "Al Qusayr",
  ["Aleppo"] = "Aleppo",
  ["An_Nasiriyah"] = "An Nasiriyah",
  ["At_Tanf"] = "At Tanf",
  ["Bassel_Al_Assad"] = "Bassel Al-Assad",
  ["Beirut_Rafic_Hariri"] = "Beirut-Rafic Hariri",
  ["Ben_Gurion"] = "Ben Gurion",
  ["Chukurova"] = "Chukurova",
  ["Damascus"] = "Damascus",
  ["Deir_ez_Zor"] = "Deir ez-Zor",
  ["Diyarbakir"] = "Diyarbakir",
  ["Ercan"] = "Ercan",
  ["Eyn_Shemer"] = "Eyn Shemer",
  ["Gaziantep"] = "Gaziantep",
  ["Gazipasa"] = "Gazipasa",
  ["Gecitkale"] = "Gecitkale",
  ["Gulechoba"] = "Gulechoba",
  ["H3"] = "H3",
  ["H3_Northwest"] = "H3 Northwest",
  ["H3_Southwest"] = "H3 Southwest",
  ["H4"] = "H4",
  ["H4_Emergency"] = "H4 Emergency",
  ["HC01"] = "HC01",
  ["HC02"] = "HC02",
  ["HC03"] = "HC03",
  ["HC04"] = "HC04",
  ["HC05"] = "HC05",
  ["HC06"] = "HC06",
  ["HI01"] = "HI01",
  ["HI02"] = "HI02",
  ["HI03"] = "HI03",
  ["HI05"] = "HI05",
  ["HI06"] = "HI06",
  ["HI07"] = "HI07",
  ["HI08"] = "HI08",
  ["HI09"] = "HI09",
  ["HI11"] = "HI11",
  ["HI12"] = "HI12",
  ["HI13"] = "HI13",
  ["HI14"] = "HI14",
  ["HI15"] = "HI15",
  ["HI16"] = "HI16",
  ["HI17"] = "HI17",
  ["HI18"] = "HI18",
  ["HI20"] = "HI20",
  ["HI21"] = "HI21",
  ["HI22"] = "HI22",
  ["HI23"] = "HI23",
  ["HI24"] = "HI24",
  ["HI25"] = "HI25",
  ["HI26"] = "HI26",
  ["HJ01"] = "HJ01",
  ["HJ02"] = "HJ02",
  ["HJ03"] = "HJ03",
  ["HJ04"] = "HJ04",
  ["HL01"] = "HL01",
  ["HL02"] = "HL02",
  ["HL03"] = "HL03",
  ["HL04"] = "HL04",
  ["HL05"] = "HL05",
  ["HL06"] = "HL06",
  ["HL07"] = "HL07",
  ["HL08"] = "HL08",
  ["HL09"] = "HL09",
  ["HL10"] = "HL10",
  ["HL11"] = "HL11",
  ["HL12"] = "HL12",
  ["HL13"] = "HL13",
  ["HMed00"] = "HMed00",
  ["HMed01"] = "HMed01",
  ["HMed02"] = "HMed02",
  ["HMed03"] = "HMed03",
  ["HMed04"] = "HMed04",
  ["HMed05"] = "HMed05",
  ["HMed06"] = "HMed06",
  ["HMed07"] = "HMed07",
  ["HMed08"] = "HMed08",
  ["HMed09"] = "HMed09",
  ["HMed10"] = "HMed10",
  ["HMed11"] = "HMed11",
  ["HMed12"] = "HMed12",
  ["HMed13"] = "HMed13",
  ["HMed14"] = "HMed14",
  ["HMed15"] = "HMed15",
  ["HMed16"] = "HMed16",
  ["HMed17"] = "HMed17",
  ["HMed18"] = "HMed18",
  ["HMed19"] = "HMed19",
  ["HMed20"] = "HMed20",
  ["HMed21"] = "HMed21",
  ["HMed22"] = "HMed22",
  ["HMed23"] = "HMed23",
  ["HMed24"] = "HMed24",
  ["HMed25"] = "HMed25",
  ["HMed26"] = "HMed26",
  ["HMed27"] = "HMed27",
  ["HMed28"] = "HMed28",
  ["HMed29"] = "HMed29",
  ["HMed30"] = "HMed30",
  ["HOil01"] = "HOil01",
  ["HOil02"] = "HOil02",
  ["HOil03"] = "HOil03",
  ["HOil04"] = "HOil04",
  ["HOil05"] = "HOil05",
  ["HOil06"] = "HOil06",
  ["HS02"] = "HS02",
  ["HS03"] = "HS03",
  ["HS04"] = "HS04",
  ["HS05"] = "HS05",
  ["HS06"] = "HS06",
  ["HS07"] = "HS07",
  ["HS08"] = "HS08",
  ["HS09"] = "HS09",
  ["HS10"] = "HS10",
  ["HS11"] = "HS11",
  ["HS12"] = "HS12",
  ["HS13"] = "HS13",
  ["HS14"] = "HS14",
  ["HS15"] = "HS15",
  ["HS16"] = "HS16",
  ["HS17"] = "HS17",
  ["HS18"] = "HS18",
  ["HS19"] = "HS19",
  ["HS20"] = "HS20",
  ["HS21"] = "HS21",
  ["HS22"] = "HS22",
  ["HS23"] = "HS23",
  ["HS24"] = "HS24",
  ["HS25"] = "HS25",
  ["HS26"] = "HS26",
  ["HS27"] = "HS27",
  ["HS28"] = "HS28",
  ["HS29"] = "HS29",
  ["HS30"] = "HS30",
  ["HS31"] = "HS31",
  ["HS32"] = "HS32",
  ["HS33"] = "HS33",
  ["HS34"] = "HS34",
  ["HS35"] = "HS35",
  ["HS36"] = "HS36",
  ["HS37"] = "HS37",
  ["HS38"] = "HS38",
  ["HS39"] = "HS39",
  ["HS40"] = "HS40",
  ["HS41"] = "HS41",
  ["HS42"] = "HS42",
  ["HStad01"] = "HStad01",
  ["HStad02"] = "HStad02",
  ["HStad03"] = "HStad03",
  ["HStad04"] = "HStad04",
  ["HStad05"] = "HStad05",
  ["HStad06"] = "HStad06",
  ["HT01"] = "HT01",
  ["HT02"] = "HT02",
  ["H_med_orig_01"] = "H_med_orig_01",
  ["H_med_orig_02"] = "H_med_orig_02",
  ["H_med_orig_03"] = "H_med_orig_03",
  ["H_med_orig_04"] = "H_med_orig_04",
  ["H_med_orig_05"] = "H_med_orig_05",
  ["H_med_orig_06"] = "H_med_orig_06",
  ["H_med_orig_07"] = "H_med_orig_07",
  ["H_med_orig_08"] = "H_med_orig_08",
  ["H_med_orig_09"] = "H_med_orig_09",
  ["Haifa"] = "Haifa",
  ["Hama"] = "Hama",
  ["Hatay"] = "Hatay",
  ["Hatzerim"] = "Hatzerim",
  ["Hatzor"] = "Hatzor",
  ["Herzliya"] = "Herzliya",
  ["Incirlik"] = "Incirlik",
  ["Jirah"] = "Jirah",
  ["Kahramanmaras"] = "Kahramanmaras",
  ["Kedem"] = "Kedem",
  ["Khalkhalah"] = "Khalkhalah",
  ["Kharab_Ishk"] = "Kharab Ishk",
  ["King_Abdullah_II"] = "King Abdullah II",
  ["King_Hussein_Air_College"] = "King Hussein Air College",
  ["Kingsfield"] = "Kingsfield",
  ["Kiryat_Shmona"] = "Kiryat Shmona",
  ["Konya"] = "Konya",
  ["Kuweires"] = "Kuweires",
  ["Lakatamia"] = "Lakatamia",
  ["Larnaca"] = "Larnaca",
  ["Marj_Ruhayyil"] = "Marj Ruhayyil",
  ["Marj_as_Sultan_North"] = "Marj as Sultan North",
  ["Marj_as_Sultan_South"] = "Marj as Sultan South",
  ["Marka"] = "Marka",
  ["Megiddo"] = "Megiddo",
  ["Mezzeh"] = "Mezzeh",
  ["Minakh"] = "Minakh",
  ["Muwaffaq_Salti"] = "Muwaffaq Salti",
  ["Naqoura"] = "Naqoura",
  ["Nevatim"] = "Nevatim",
  ["Nicosia"] = "Nicosia",
  ["Palmachim"] = "Palmachim",
  ["Palmyra"] = "Palmyra",
  ["Paphos"] = "Paphos",
  ["Pinarbashi"] = "Pinarbashi",
  ["Prince_Hassan"] = "Prince Hassan",
  ["Qabr_as_Sitt"] = "Qabr as Sitt",
  ["Ramat_David"] = "Ramat David",
  ["Rayak"] = "Rayak",
  ["Rene_Mouawad"] = "Rene Mouawad",
  ["Rosh_Pina"] = "Rosh Pina",
  ["Ruwayshid"] = "Ruwayshid",
  ["Sanliurfa"] = "Sanliurfa",
  ["Sanliurfa_Heliport"] = "Sanliurfa Heliport",
  ["Sayqal"] = "Sayqal",
  ["Shayrat"] = "Shayrat",
  ["T2"] = "T2",
  ["T3"] = "T3",
  ["Tabqa"] = "Tabqa",
  ["Taftanaz"] = "Taftanaz",
  ["Tal_Siman"] = "Tal Siman",
  ["Tel_Nof"] = "Tel Nof",
  ["Teyman"] = "Teyman",
  ["Tha_lah"] = "Tha'lah",
  ["Tiyas"] = "Tiyas",
  ["Wujah_Al_Hajar"] = "Wujah Al Hajar",
  ["Zarqa"] = "Zarqa",
}

---Airbases of the Mariana Islands map
---
---* `AIRBASE.MarianaIslands.Andersen_AFB` Andersen AFB
---* `AIRBASE.MarianaIslands.Antonio_B_Won_Pat_Intl` Antonio B. Won Pat Intl
---* `AIRBASE.MarianaIslands.North_West_Field` North West Field
---* `AIRBASE.MarianaIslands.Olf_Orote` Olf Orote
---* `AIRBASE.MarianaIslands.Pagan_Airstrip` Pagan Airstrip
---* `AIRBASE.MarianaIslands.Rota_Intl` Rota Intl
---* `AIRBASE.MarianaIslands.Saipan_Intl` Saipan Intl
---* `AIRBASE.MarianaIslands.Tinian_Intl` Tinian Intl
AIRBASE.MarianaIslands = {
  ["Andersen_AFB"] = "Andersen AFB",
  ["Antonio_B_Won_Pat_Intl"] = "Antonio B. Won Pat Intl",
  ["North_West_Field"] = "North West Field",
  ["Olf_Orote"] = "Olf Orote",
  ["Pagan_Airstrip"] = "Pagan Airstrip",
  ["Rota_Intl"] = "Rota Intl",
  ["Saipan_Intl"] = "Saipan Intl",
  ["Tinian_Intl"] = "Tinian Intl",
}

---Airbases of the MarianaIslandsWWII map
---
---* `AIRBASE.MarianaIslandsWWII.Agana` Agana
---* `AIRBASE.MarianaIslandsWWII.Airfield_3` Airfield 3
---* `AIRBASE.MarianaIslandsWWII.Charon_Kanoa` Charon Kanoa
---* `AIRBASE.MarianaIslandsWWII.Gurguan_Point` Gurguan Point
---* `AIRBASE.MarianaIslandsWWII.Isley` Isley
---* `AIRBASE.MarianaIslandsWWII.Kagman` Kagman
---* `AIRBASE.MarianaIslandsWWII.Marpi` Marpi
---* `AIRBASE.MarianaIslandsWWII.Orote` Orote
---* `AIRBASE.MarianaIslandsWWII.Pagan` Pagan
---* `AIRBASE.MarianaIslandsWWII.Rota` Rota
---* `AIRBASE.MarianaIslandsWWII.Ushi` Ushi
AIRBASE.MarianaIslandsWWII = {
  ["Agana"] = "Agana",
  ["Airfield_3"] = "Airfield 3",
  ["Charon_Kanoa"] = "Charon Kanoa",
  ["Gurguan_Point"] = "Gurguan Point",
  ["Isley"] = "Isley",
  ["Kagman"] = "Kagman",
  ["Marpi"] = "Marpi",
  ["Orote"] = "Orote",
  ["Pagan"] = "Pagan",
  ["Rota"] = "Rota",
  ["Ushi"] = "Ushi",
}

---Airbases of the South Atlantic (Falklands) map
---
---* `AIRBASE.SouthAtlantic.Almirante_Schroeders` Almirante Schroeders
---* `AIRBASE.SouthAtlantic.Comandante_Luis_Piedrabuena` Comandante Luis Piedrabuena
---* `AIRBASE.SouthAtlantic.Cullen` Cullen
---* `AIRBASE.SouthAtlantic.El_Calafate` El Calafate
---* `AIRBASE.SouthAtlantic.Franco_Bianco` Franco Bianco
---* `AIRBASE.SouthAtlantic.Gobernador_Gregores` Gobernador Gregores
---* `AIRBASE.SouthAtlantic.Goose_Green` Goose Green
---* `AIRBASE.SouthAtlantic.Gull_Point` Gull Point
---* `AIRBASE.SouthAtlantic.Hipico_Flying_Club` Hipico Flying Club
---* `AIRBASE.SouthAtlantic.Mount_Pleasant` Mount Pleasant
---* `AIRBASE.SouthAtlantic.O_Higgins` O'Higgins
---* `AIRBASE.SouthAtlantic.Pampa_Guanaco` Pampa Guanaco
---* `AIRBASE.SouthAtlantic.Port_Stanley` Port Stanley
---* `AIRBASE.SouthAtlantic.Porvenir` Porvenir
---* `AIRBASE.SouthAtlantic.Puerto_Natales` Puerto Natales
---* `AIRBASE.SouthAtlantic.Puerto_Santa_Cruz` Puerto Santa Cruz
---* `AIRBASE.SouthAtlantic.Puerto_Williams` Puerto Williams
---* `AIRBASE.SouthAtlantic.Punta_Arenas` Punta Arenas
---* `AIRBASE.SouthAtlantic.Rio_Chico` Rio Chico
---* `AIRBASE.SouthAtlantic.Rio_Gallegos` Rio Gallegos
---* `AIRBASE.SouthAtlantic.Rio_Grande` Rio Grande
---* `AIRBASE.SouthAtlantic.Rio_Turbio` Rio Turbio
---* `AIRBASE.SouthAtlantic.San_Carlos_FOB` San Carlos FOB
---* `AIRBASE.SouthAtlantic.San_Julian` San Julian
---* `AIRBASE.SouthAtlantic.Tolhuin` Tolhuin
---* `AIRBASE.SouthAtlantic.Ushuaia` Ushuaia
---* `AIRBASE.SouthAtlantic.Ushuaia_Helo_Port` Ushuaia Helo Port
AIRBASE.SouthAtlantic = {
  ["Almirante_Schroeders"] = "Almirante Schroeders",
  ["Comandante_Luis_Piedrabuena"] = "Comandante Luis Piedrabuena",
  ["Cullen"] = "Cullen",
  ["El_Calafate"] = "El Calafate",
  ["Franco_Bianco"] = "Franco Bianco",
  ["Gobernador_Gregores"] = "Gobernador Gregores",
  ["Goose_Green"] = "Goose Green",
  ["Gull_Point"] = "Gull Point",
  ["Hipico_Flying_Club"] = "Hipico Flying Club",
  ["Mount_Pleasant"] = "Mount Pleasant",
  ["O_Higgins"] = "O'Higgins",
  ["Pampa_Guanaco"] = "Pampa Guanaco",
  ["Port_Stanley"] = "Port Stanley",
  ["Porvenir"] = "Porvenir",
  ["Puerto_Natales"] = "Puerto Natales",
  ["Puerto_Santa_Cruz"] = "Puerto Santa Cruz",
  ["Puerto_Williams"] = "Puerto Williams",
  ["Punta_Arenas"] = "Punta Arenas",
  ["Rio_Chico"] = "Rio Chico",
  ["Rio_Gallegos"] = "Rio Gallegos",
  ["Rio_Grande"] = "Rio Grande",
  ["Rio_Turbio"] = "Rio Turbio",
  ["San_Carlos_FOB"] = "San Carlos FOB",
  ["San_Julian"] = "San Julian",
  ["Tolhuin"] = "Tolhuin",
  ["Ushuaia"] = "Ushuaia",
  ["Ushuaia_Helo_Port"] = "Ushuaia Helo Port",
}

---Airbases of the Sinai map
---
---* `AIRBASE.Sinai.Abu_Rudeis` Abu Rudeis
---* `AIRBASE.Sinai.Abu_Suwayr` Abu Suwayr
---* `AIRBASE.Sinai.Al_Bahr_al_Ahmar` Al Bahr al Ahmar
---* `AIRBASE.Sinai.Al_Ismailiyah` Al Ismailiyah
---* `AIRBASE.Sinai.Al_Khatatbah` Al Khatatbah
---* `AIRBASE.Sinai.Al_Mansurah` Al Mansurah
---* `AIRBASE.Sinai.Al_Rahmaniyah_Air_Base` Al Rahmaniyah Air Base
---* `AIRBASE.Sinai.As_Salihiyah` As Salihiyah
---* `AIRBASE.Sinai.AzZaqaziq` AzZaqaziq
---* `AIRBASE.Sinai.Baluza` Baluza
---* `AIRBASE.Sinai.Ben_Gurion` Ben-Gurion
---* `AIRBASE.Sinai.Beni_Suef` Beni Suef
---* `AIRBASE.Sinai.Bilbeis_Air_Base` Bilbeis Air Base
---* `AIRBASE.Sinai.Bir_Hasanah` Bir Hasanah
---* `AIRBASE.Sinai.Birma_Air_Base` Birma Air Base
---* `AIRBASE.Sinai.Borg_El_Arab_International_Airport` Borg El Arab International Airport
---* `AIRBASE.Sinai.Cairo_International_Airport` Cairo International Airport
---* `AIRBASE.Sinai.Cairo_West` Cairo West
---* `AIRBASE.Sinai.Damascus_Intl` Damascus Intl
---* `AIRBASE.Sinai.Difarsuwar_Airfield` Difarsuwar Airfield
---* `AIRBASE.Sinai.Ein_Shamer` Ein Shamer
---* `AIRBASE.Sinai.El_Arish` El Arish
---* `AIRBASE.Sinai.El_Gora` El Gora
---* `AIRBASE.Sinai.El_Minya` El Minya
---* `AIRBASE.Sinai.Fayed` Fayed
---* `AIRBASE.Sinai.Gebel_El_Basur_Air_Base` Gebel El Basur Air Base
---* `AIRBASE.Sinai.Hatzerim` Hatzerim
---* `AIRBASE.Sinai.Hatzor` Hatzor
---* `AIRBASE.Sinai.Hurghada_International_Airport` Hurghada International Airport
---* `AIRBASE.Sinai.Inshas_Airbase` Inshas Airbase
---* `AIRBASE.Sinai.Jiyanklis_Air_Base` Jiyanklis Air Base
---* `AIRBASE.Sinai.Kedem` Kedem
---* `AIRBASE.Sinai.Khalkhalah_Air_Base` Khalkhalah Air Base
---* `AIRBASE.Sinai.Kibrit_Air_Base` Kibrit Air Base
---* `AIRBASE.Sinai.King_Feisal_Air_Base` King Feisal Air Base
---* `AIRBASE.Sinai.Kom_Awshim` Kom Awshim
---* `AIRBASE.Sinai.Megiddo` Megiddo
---* `AIRBASE.Sinai.Melez` Melez
---* `AIRBASE.Sinai.Mezzeh_Air_Base` Mezzeh Air Base
---* `AIRBASE.Sinai.Nevatim` Nevatim
---* `AIRBASE.Sinai.Ovda` Ovda
---* `AIRBASE.Sinai.Palmachim` Palmachim
---* `AIRBASE.Sinai.Quwaysina` Quwaysina
---* `AIRBASE.Sinai.Rafic_Hariri_Intl` Rafic Hariri Intl
---* `AIRBASE.Sinai.Ramat_David` Ramat David
---* `AIRBASE.Sinai.Ramon_Airbase` Ramon Airbase
---* `AIRBASE.Sinai.Ramon_International_Airport` Ramon International Airport
---* `AIRBASE.Sinai.Sde_Dov` Sde Dov
---* `AIRBASE.Sinai.Sharm_El_Sheikh_International_Airport` Sharm El Sheikh International Airport
---* `AIRBASE.Sinai.St_Catherine` St Catherine
---* `AIRBASE.Sinai.Taba_International_Airport` Taba International Airport
---* `AIRBASE.Sinai.Tabuk` Tabuk
---* `AIRBASE.Sinai.TabukHeliBase` TabukHeliBase
---* `AIRBASE.Sinai.Tel_Nof` Tel Nof
---* `AIRBASE.Sinai.Wadi_Abu_Rish` Wadi Abu Rish
---* `AIRBASE.Sinai.Wadi_al_Jandali` Wadi al Jandali
AIRBASE.Sinai = {
  ["Abu_Rudeis"] = "Abu Rudeis",
  ["Abu_Suwayr"] = "Abu Suwayr",
  ["Al_Bahr_al_Ahmar"] = "Al Bahr al Ahmar",
  ["Al_Ismailiyah"] = "Al Ismailiyah",
  ["Al_Khatatbah"] = "Al Khatatbah",
  ["Al_Mansurah"] = "Al Mansurah",
  ["Al_Rahmaniyah_Air_Base"] = "Al Rahmaniyah Air Base",
  ["As_Salihiyah"] = "As Salihiyah",
  ["AzZaqaziq"] = "AzZaqaziq",
  ["Baluza"] = "Baluza",
  ["Ben_Gurion"] = "Ben-Gurion",
  ["Beni_Suef"] = "Beni Suef",
  ["Bilbeis_Air_Base"] = "Bilbeis Air Base",
  ["Bir_Hasanah"] = "Bir Hasanah",
  ["Birma_Air_Base"] = "Birma Air Base",
  ["Borg_El_Arab_International_Airport"] = "Borg El Arab International Airport",
  ["Cairo_International_Airport"] = "Cairo International Airport",
  ["Cairo_West"] = "Cairo West",
  ["Damascus_Intl"] = "Damascus Intl",
  ["Difarsuwar_Airfield"] = "Difarsuwar Airfield",
  ["Ein_Shamer"] = "Ein Shamer",
  ["El_Arish"] = "El Arish",
  ["El_Gora"] = "El Gora",
  ["El_Minya"] = "El Minya",
  ["Fayed"] = "Fayed",
  ["Gebel_El_Basur_Air_Base"] = "Gebel El Basur Air Base",
  ["Hatzerim"] = "Hatzerim",
  ["Hatzor"] = "Hatzor",
  ["Hurghada_International_Airport"] = "Hurghada International Airport",
  ["Inshas_Airbase"] = "Inshas Airbase",
  ["Jiyanklis_Air_Base"] = "Jiyanklis Air Base",
  ["Kedem"] = "Kedem",
  ["Khalkhalah_Air_Base"] = "Khalkhalah Air Base",
  ["Kibrit_Air_Base"] = "Kibrit Air Base",
  ["King_Feisal_Air_Base"] = "King Feisal Air Base",
  ["Kom_Awshim"] = "Kom Awshim",
  ["Megiddo"] = "Megiddo",
  ["Melez"] = "Melez",
  ["Mezzeh_Air_Base"] = "Mezzeh Air Base",
  ["Nevatim"] = "Nevatim",
  ["Ovda"] = "Ovda",
  ["Palmachim"] = "Palmachim",
  ["Quwaysina"] = "Quwaysina",
  ["Rafic_Hariri_Intl"] = "Rafic Hariri Intl",
  ["Ramat_David"] = "Ramat David",
  ["Ramon_Airbase"] = "Ramon Airbase",
  ["Ramon_International_Airport"] = "Ramon International Airport",
  ["Sde_Dov"] = "Sde Dov",
  ["Sharm_El_Sheikh_International_Airport"] = "Sharm El Sheikh International Airport",
  ["St_Catherine"] = "St Catherine",
  ["Taba_International_Airport"] = "Taba International Airport",
  ["Tabuk"] = "Tabuk",
  ["TabukHeliBase"] = "TabukHeliBase",
  ["Tel_Nof"] = "Tel Nof",
  ["Wadi_Abu_Rish"] = "Wadi Abu Rish",
  ["Wadi_al_Jandali"] = "Wadi al Jandali",
}

AIRBASE.SinaiMap = {
  ["Abu_Rudeis"] = "Abu Rudeis",
  ["Abu_Suwayr"] = "Abu Suwayr",
  ["Al_Bahr_al_Ahmar"] = "Al Bahr al Ahmar",
  ["Al_Ismailiyah"] = "Al Ismailiyah",
  ["Al_Khatatbah"] = "Al Khatatbah",
  ["Al_Mansurah"] = "Al Mansurah",
  ["Al_Rahmaniyah_Air_Base"] = "Al Rahmaniyah Air Base",
  ["As_Salihiyah"] = "As Salihiyah",
  ["AzZaqaziq"] = "AzZaqaziq",
  ["Baluza"] = "Baluza",
  ["Ben_Gurion"] = "Ben-Gurion",
  ["Beni_Suef"] = "Beni Suef",
  ["Bilbeis_Air_Base"] = "Bilbeis Air Base",
  ["Bir_Hasanah"] = "Bir Hasanah",
  ["Birma_Air_Base"] = "Birma Air Base",
  ["Borg_El_Arab_International_Airport"] = "Borg El Arab International Airport",
  ["Cairo_International_Airport"] = "Cairo International Airport",
  ["Cairo_West"] = "Cairo West",
  ["Damascus_Intl"] = "Damascus Intl",
  ["Difarsuwar_Airfield"] = "Difarsuwar Airfield",
  ["Ein_Shamer"] = "Ein Shamer",
  ["El_Arish"] = "El Arish",
  ["El_Gora"] = "El Gora",
  ["El_Minya"] = "El Minya",
  ["Fayed"] = "Fayed",
  ["Gebel_El_Basur_Air_Base"] = "Gebel El Basur Air Base",
  ["Hatzerim"] = "Hatzerim",
  ["Hatzor"] = "Hatzor",
  ["Hurghada_International_Airport"] = "Hurghada International Airport",
  ["Inshas_Airbase"] = "Inshas Airbase",
  ["Jiyanklis_Air_Base"] = "Jiyanklis Air Base",
  ["Kedem"] = "Kedem",
  ["Khalkhalah_Air_Base"] = "Khalkhalah Air Base",
  ["Kibrit_Air_Base"] = "Kibrit Air Base",
  ["King_Feisal_Air_Base"] = "King Feisal Air Base",
  ["Kom_Awshim"] = "Kom Awshim",
  ["Megiddo"] = "Megiddo",
  ["Melez"] = "Melez",
  ["Mezzeh_Air_Base"] = "Mezzeh Air Base",
  ["Nevatim"] = "Nevatim",
  ["Ovda"] = "Ovda",
  ["Palmachim"] = "Palmachim",
  ["Quwaysina"] = "Quwaysina",
  ["Rafic_Hariri_Intl"] = "Rafic Hariri Intl",
  ["Ramat_David"] = "Ramat David",
  ["Ramon_Airbase"] = "Ramon Airbase",
  ["Ramon_International_Airport"] = "Ramon International Airport",
  ["Sde_Dov"] = "Sde Dov",
  ["Sharm_El_Sheikh_International_Airport"] = "Sharm El Sheikh International Airport",
  ["St_Catherine"] = "St Catherine",
  ["Taba_International_Airport"] = "Taba International Airport",
  ["Tabuk"] = "Tabuk",
  ["TabukHeliBase"] = "TabukHeliBase",
  ["Tel_Nof"] = "Tel Nof",
  ["Wadi_Abu_Rish"] = "Wadi Abu Rish",
  ["Wadi_al_Jandali"] = "Wadi al Jandali",
}

---Airbases of the Kola map
---
---* `AIRBASE.Kola.Afrikanda` Afrikanda
---* `AIRBASE.Kola.Alakurtti` Alakurtti
---* `AIRBASE.Kola.Alta` Alta
---* `AIRBASE.Kola.Andoya` Andoya
---* `AIRBASE.Kola.Arvidsjaur` Arvidsjaur
---* `AIRBASE.Kola.Banak` Banak
---* `AIRBASE.Kola.Bardufoss` Bardufoss
---* `AIRBASE.Kola.Boden_Heli_Base` Boden Heli Base
---* `AIRBASE.Kola.Bodo` Bodo
---* `AIRBASE.Kola.Enontekio` Enontekio
---* `AIRBASE.Kola.Evenes` Evenes
---* `AIRBASE.Kola.Hemavan` Hemavan
---* `AIRBASE.Kola.Hosio` Hosio
---* `AIRBASE.Kola.Ivalo` Ivalo
---* `AIRBASE.Kola.Jokkmokk` Jokkmokk
---* `AIRBASE.Kola.Kalevala` Kalevala
---* `AIRBASE.Kola.Kalixfors` Kalixfors
---* `AIRBASE.Kola.Kallax` Kallax
---* `AIRBASE.Kola.Kemi_Tornio` Kemi Tornio
---* `AIRBASE.Kola.Kilpyavr` Kilpyavr
---* `AIRBASE.Kola.Kirkenes` Kirkenes
---* `AIRBASE.Kola.Kiruna` Kiruna
---* `AIRBASE.Kola.Kittila` Kittila
---* `AIRBASE.Kola.Koshka_Yavr` Koshka Yavr
---* `AIRBASE.Kola.Kuusamo` Kuusamo
---* `AIRBASE.Kola.Luostari_Pechenga` Luostari Pechenga
---* `AIRBASE.Kola.Monchegorsk` Monchegorsk
---* `AIRBASE.Kola.Murmansk_International` Murmansk International
---* `AIRBASE.Kola.Olenya` Olenya
---* `AIRBASE.Kola.Poduzhemye` Poduzhemye
---* `AIRBASE.Kola.Rovaniemi` Rovaniemi
---* `AIRBASE.Kola.Severomorsk_1` Severomorsk-1
---* `AIRBASE.Kola.Severomorsk_3` Severomorsk-3
---* `AIRBASE.Kola.Sodankyla` Sodankyla
---* `AIRBASE.Kola.Vidsel` Vidsel
---* `AIRBASE.Kola.Vuojarvi` Vuojarvi
AIRBASE.Kola = {
  ["Afrikanda"] = "Afrikanda",
  ["Alakurtti"] = "Alakurtti",
  ["Alta"] = "Alta",
  ["Andoya"] = "Andoya",
  ["Arvidsjaur"] = "Arvidsjaur",
  ["Banak"] = "Banak",
  ["Bardufoss"] = "Bardufoss",
  ["Boden_Heli_Base"] = "Boden Heli Base",
  ["Bodo"] = "Bodo",
  ["Enontekio"] = "Enontekio",
  ["Evenes"] = "Evenes",
  ["Hemavan"] = "Hemavan",
  ["Hosio"] = "Hosio",
  ["Ivalo"] = "Ivalo",
  ["Jokkmokk"] = "Jokkmokk",
  ["Kalevala"] = "Kalevala",
  ["Kalixfors"] = "Kalixfors",
  ["Kallax"] = "Kallax",
  ["Kemi_Tornio"] = "Kemi Tornio",
  ["Kilpyavr"] = "Kilpyavr",
  ["Kirkenes"] = "Kirkenes",
  ["Kiruna"] = "Kiruna",
  ["Kittila"] = "Kittila",
  ["Koshka_Yavr"] = "Koshka Yavr",
  ["Kuusamo"] = "Kuusamo",
  ["Luostari_Pechenga"] = "Luostari Pechenga",
  ["Monchegorsk"] = "Monchegorsk",
  ["Murmansk_International"] = "Murmansk International",
  ["Olenya"] = "Olenya",
  ["Poduzhemye"] = "Poduzhemye",
  ["Rovaniemi"] = "Rovaniemi",
  ["Severomorsk_1"] = "Severomorsk-1",
  ["Severomorsk_3"] = "Severomorsk-3",
  ["Sodankyla"] = "Sodankyla",
  ["Vidsel"] = "Vidsel",
  ["Vuojarvi"] = "Vuojarvi",
}

---Airbases of the Afghanistan map
---
---* `AIRBASE.Afghanistan.Bagram` Bagram
---* `AIRBASE.Afghanistan.Bamyan` Bamyan
---* `AIRBASE.Afghanistan.Bost` Bost
---* `AIRBASE.Afghanistan.Camp_Bastion` Camp Bastion
---* `AIRBASE.Afghanistan.Camp_Bastion_Heliport` Camp Bastion Heliport
---* `AIRBASE.Afghanistan.Chaghcharan` Chaghcharan
---* `AIRBASE.Afghanistan.Dwyer` Dwyer
---* `AIRBASE.Afghanistan.FOB_Camp_Dubs` FOB Camp Dubs
---* `AIRBASE.Afghanistan.FOB_Clark` FOB Clark
---* `AIRBASE.Afghanistan.FOB_Salerno` FOB Salerno
---* `AIRBASE.Afghanistan.FOB_Thunder` FOB Thunder
---* `AIRBASE.Afghanistan.Farah` Farah
---* `AIRBASE.Afghanistan.Gardez` Gardez
---* `AIRBASE.Afghanistan.Ghazni_Heliport` Ghazni Heliport
---* `AIRBASE.Afghanistan.Herat` Herat
---* `AIRBASE.Afghanistan.Jalalabad` Jalalabad
---* `AIRBASE.Afghanistan.Kabul` Kabul
---* `AIRBASE.Afghanistan.Kandahar` Kandahar
---* `AIRBASE.Afghanistan.Kandahar_Heliport` Kandahar Heliport
---* `AIRBASE.Afghanistan.Khost` Khost
---* `AIRBASE.Afghanistan.Maymana_Zahiraddin_Faryabi` Maymana Zahiraddin Faryabi
---* `AIRBASE.Afghanistan.Nimroz` Nimroz
---* `AIRBASE.Afghanistan.Qala_i_Naw` Qala i Naw
---* `AIRBASE.Afghanistan.Sharana` Sharana
---* `AIRBASE.Afghanistan.Shindand` Shindand
---* `AIRBASE.Afghanistan.Shindand_Heliport` Shindand Heliport
---* `AIRBASE.Afghanistan.Tarinkot` Tarinkot
---* `AIRBASE.Afghanistan.Urgoon_Heliport` Urgoon Heliport
AIRBASE.Afghanistan = {
  ["Bagram"] = "Bagram",
  ["Bamyan"] = "Bamyan",
  ["Bost"] = "Bost",
  ["Camp_Bastion"] = "Camp Bastion",
  ["Camp_Bastion_Heliport"] = "Camp Bastion Heliport",
  ["Chaghcharan"] = "Chaghcharan",
  ["Dwyer"] = "Dwyer",
  ["FOB_Camp_Dubs"] = "FOB Camp Dubs",
  ["FOB_Clark"] = "FOB Clark",
  ["FOB_Salerno"] = "FOB Salerno",
  ["FOB_Thunder"] = "FOB Thunder",
  ["Farah"] = "Farah",
  ["Gardez"] = "Gardez",
  ["Ghazni_Heliport"] = "Ghazni Heliport",
  ["Herat"] = "Herat",
  ["Jalalabad"] = "Jalalabad",
  ["Kabul"] = "Kabul",
  ["Kandahar"] = "Kandahar",
  ["Kandahar_Heliport"] = "Kandahar Heliport",
  ["Khost"] = "Khost",
  ["Maymana_Zahiraddin_Faryabi"] = "Maymana Zahiraddin Faryabi",
  ["Nimroz"] = "Nimroz",
  ["Qala_i_Naw"] = "Qala i Naw",
  ["Sharana"] = "Sharana",
  ["Shindand"] = "Shindand",
  ["Shindand_Heliport"] = "Shindand Heliport",
  ["Tarinkot"] = "Tarinkot",
  ["Urgoon_Heliport"] = "Urgoon Heliport",
}

---Airbases of the Iraq map
---
---* `AIRBASE.Iraq.Al_Asad_Airbase` Al-Asad Airbase
---* `AIRBASE.Iraq.Al_Kut_Airport` Al-Kut Airport
---* `AIRBASE.Iraq.Al_Sahra_Airport` Al-Sahra Airport
---* `AIRBASE.Iraq.Al_Salam_Airbase` Al-Salam Airbase
---* `AIRBASE.Iraq.Al_Taji_Airport` Al-Taji Airport
---* `AIRBASE.Iraq.Al_Taquddum_Airport` Al-Taquddum Airport
---* `AIRBASE.Iraq.Baghdad_International_Airport` Baghdad International Airport
---* `AIRBASE.Iraq.Balad_Airbase` Balad Airbase
---* `AIRBASE.Iraq.Bashur_Airport` Bashur Airport
---* `AIRBASE.Iraq.Erbil_International_Airport` Erbil International Airport
---* `AIRBASE.Iraq.H_2_Airbase` H-2 Airbase
---* `AIRBASE.Iraq.H_3_Main_Airbase` H-3 Main Airbase
---* `AIRBASE.Iraq.H_3_Northwest_Airbase` H-3 Northwest Airbase
---* `AIRBASE.Iraq.H_3_Southwest_Airbase` H-3 Southwest Airbase
---* `AIRBASE.Iraq.K1_Base` K1 Base
---* `AIRBASE.Iraq.Kirkuk_International_Airport` Kirkuk International Airport
---* `AIRBASE.Iraq.Mosul_International_Airport` Mosul International Airport
---* `AIRBASE.Iraq.Qayyarah_Airfield_West` Qayyarah Airfield West
---* `AIRBASE.Iraq.Sulaimaniyah_International_Airport` Sulaimaniyah International Airport
AIRBASE.Iraq = {
  ["Al_Asad_Airbase"] = "Al-Asad Airbase",
  ["Al_Kut_Airport"] = "Al-Kut Airport",
  ["Al_Sahra_Airport"] = "Al-Sahra Airport",
  ["Al_Salam_Airbase"] = "Al-Salam Airbase",
  ["Al_Taji_Airport"] = "Al-Taji Airport",
  ["Al_Taquddum_Airport"] = "Al-Taquddum Airport",
  ["Baghdad_International_Airport"] = "Baghdad International Airport",
  ["Balad_Airbase"] = "Balad Airbase",
  ["Bashur_Airport"] = "Bashur Airport",
  ["Erbil_International_Airport"] = "Erbil International Airport",
  ["H_2_Airbase"] = "H-2 Airbase",
  ["H_3_Main_Airbase"] = "H-3 Main Airbase",
  ["H_3_Northwest_Airbase"] = "H-3 Northwest Airbase",
  ["H_3_Southwest_Airbase"] = "H-3 Southwest Airbase",
  ["K1_Base"] = "K1 Base",
  ["Kirkuk_International_Airport"] = "Kirkuk International Airport",
  ["Mosul_International_Airport"] = "Mosul International Airport",
  ["Qayyarah_Airfield_West"] = "Qayyarah Airfield West",
  ["Sulaimaniyah_International_Airport"] = "Sulaimaniyah International Airport",
}

---Airbases of the GermanyCW map
---
---* `AIRBASE.GermanyCW.Adelsheim` Adelsheim
---* `AIRBASE.GermanyCW.Airracing_Frankfurt` Airracing Frankfurt
---* `AIRBASE.GermanyCW.Airracing_Koblenz` Airracing Koblenz
---* `AIRBASE.GermanyCW.Airracing_Luebeck` Airracing Lubeck
---* `AIRBASE.GermanyCW.Allstedt` Allstedt
---* `AIRBASE.GermanyCW.Altes_Lager` Altes Lager
---* `AIRBASE.GermanyCW.Bad_Duerkheim` Bad Durkheim
---* `AIRBASE.GermanyCW.Barth` Barth
---* `AIRBASE.GermanyCW.Bienenfarm` Bienenfarm
---* `AIRBASE.GermanyCW.Bindersleben` Bindersleben
---* `AIRBASE.GermanyCW.Bitburg` Bitburg
---* `AIRBASE.GermanyCW.Bornholm` Bornholm
---* `AIRBASE.GermanyCW.Brand` Brand
---* `AIRBASE.GermanyCW.Brandis` Brandis
---* `AIRBASE.GermanyCW.Braunschweig` Braunschweig
---* `AIRBASE.GermanyCW.Bremen` Bremen
---* `AIRBASE.GermanyCW.Briest` Briest
---* `AIRBASE.GermanyCW.Buechel` Buchel
---* `AIRBASE.GermanyCW.Bueckeburg` Buckeburg
---* `AIRBASE.GermanyCW.Celle` Celle
---* `AIRBASE.GermanyCW.Chojna` Chojna
---* `AIRBASE.GermanyCW.Cochstedt` Cochstedt
---* `AIRBASE.GermanyCW.Cologne` Cologne
---* `AIRBASE.GermanyCW.Damgarten` Damgarten
---* `AIRBASE.GermanyCW.Dedelow` Dedelow
---* `AIRBASE.GermanyCW.Dessau` Dessau
---* `AIRBASE.GermanyCW.Duesseldorf` Dusseldorf
---* `AIRBASE.GermanyCW.Falkenberg` Falkenberg
---* `AIRBASE.GermanyCW.Fassberg` Fassberg
---* `AIRBASE.GermanyCW.Finow` Finow
---* `AIRBASE.GermanyCW.Frankfurt` Frankfurt
---* `AIRBASE.GermanyCW.Fritzlar` Fritzlar
---* `AIRBASE.GermanyCW.Fulda` Fulda
---* `AIRBASE.GermanyCW.Gardelegen` Gardelegen
---* `AIRBASE.GermanyCW.Garz` Garz
---* `AIRBASE.GermanyCW.Gatow` Gatow
---* `AIRBASE.GermanyCW.Gelnhausen` Gelnhausen
---* `AIRBASE.GermanyCW.Giebelstadt` Giebelstadt
---* `AIRBASE.GermanyCW.Glindbruchkippe` Glindbruchkippe
---* `AIRBASE.GermanyCW.Gross_Mohrdorf` Gross Mohrdorf
---* `AIRBASE.GermanyCW.Grosse_Wiese` Grosse Wiese
---* `AIRBASE.GermanyCW.Guetersloh` Gutersloh
---* `AIRBASE.GermanyCW.H_FRG_01` H FRG 01
---* `AIRBASE.GermanyCW.H_FRG_02` H FRG 02
---* `AIRBASE.GermanyCW.H_FRG_03` H FRG 03
---* `AIRBASE.GermanyCW.H_FRG_04` H FRG 04
---* `AIRBASE.GermanyCW.H_FRG_05` H FRG 05
---* `AIRBASE.GermanyCW.H_FRG_06` H FRG 06
---* `AIRBASE.GermanyCW.H_FRG_07` H FRG 07
---* `AIRBASE.GermanyCW.H_FRG_08` H FRG 08
---* `AIRBASE.GermanyCW.H_FRG_09` H FRG 09
---* `AIRBASE.GermanyCW.H_FRG_10` H FRG 10
---* `AIRBASE.GermanyCW.H_FRG_11` H FRG 11
---* `AIRBASE.GermanyCW.H_FRG_12` H FRG 12
---* `AIRBASE.GermanyCW.H_FRG_13` H FRG 13
---* `AIRBASE.GermanyCW.H_FRG_14` H FRG 14
---* `AIRBASE.GermanyCW.H_FRG_15` H FRG 15
---* `AIRBASE.GermanyCW.H_FRG_16` H FRG 16
---* `AIRBASE.GermanyCW.H_FRG_17` H FRG 17
---* `AIRBASE.GermanyCW.H_FRG_18` H FRG 18
---* `AIRBASE.GermanyCW.H_FRG_19` H FRG 19
---* `AIRBASE.GermanyCW.H_FRG_20` H FRG 20
---* `AIRBASE.GermanyCW.H_FRG_21` H FRG 21
---* `AIRBASE.GermanyCW.H_FRG_23` H FRG 23
---* `AIRBASE.GermanyCW.H_FRG_25` H FRG 25
---* `AIRBASE.GermanyCW.H_FRG_27` H FRG 27
---* `AIRBASE.GermanyCW.H_FRG_30` H FRG 30
---* `AIRBASE.GermanyCW.H_FRG_31` H FRG 31
---* `AIRBASE.GermanyCW.H_FRG_32` H FRG 32
---* `AIRBASE.GermanyCW.H_FRG_34` H FRG 34
---* `AIRBASE.GermanyCW.H_FRG_38` H FRG 38
---* `AIRBASE.GermanyCW.H_FRG_39` H FRG 39
---* `AIRBASE.GermanyCW.H_FRG_40` H FRG 40
---* `AIRBASE.GermanyCW.H_FRG_41` H FRG 41
---* `AIRBASE.GermanyCW.H_FRG_42` H FRG 42
---* `AIRBASE.GermanyCW.H_FRG_43` H FRG 43
---* `AIRBASE.GermanyCW.H_FRG_44` H FRG 44
---* `AIRBASE.GermanyCW.H_FRG_45` H FRG 45
---* `AIRBASE.GermanyCW.H_FRG_46` H FRG 46
---* `AIRBASE.GermanyCW.H_FRG_47` H FRG 47
---* `AIRBASE.GermanyCW.H_FRG_48` H FRG 48
---* `AIRBASE.GermanyCW.H_FRG_49` H FRG 49
---* `AIRBASE.GermanyCW.H_FRG_50` H FRG 50
---* `AIRBASE.GermanyCW.H_FRG_51` H FRG 51
---* `AIRBASE.GermanyCW.H_GDR_01` H GDR 01
---* `AIRBASE.GermanyCW.H_GDR_02` H GDR 02
---* `AIRBASE.GermanyCW.H_GDR_03` H GDR 03
---* `AIRBASE.GermanyCW.H_GDR_04` H GDR 04
---* `AIRBASE.GermanyCW.H_GDR_05` H GDR 05
---* `AIRBASE.GermanyCW.H_GDR_06` H GDR 06
---* `AIRBASE.GermanyCW.H_GDR_07` H GDR 07
---* `AIRBASE.GermanyCW.H_GDR_08` H GDR 08
---* `AIRBASE.GermanyCW.H_GDR_09` H GDR 09
---* `AIRBASE.GermanyCW.H_GDR_10` H GDR 10
---* `AIRBASE.GermanyCW.H_GDR_11` H GDR 11
---* `AIRBASE.GermanyCW.H_GDR_12` H GDR 12
---* `AIRBASE.GermanyCW.H_GDR_13` H GDR 13
---* `AIRBASE.GermanyCW.H_GDR_14` H GDR 14
---* `AIRBASE.GermanyCW.H_GDR_15` H GDR 15
---* `AIRBASE.GermanyCW.H_GDR_16` H GDR 16
---* `AIRBASE.GermanyCW.H_GDR_17` H GDR 17
---* `AIRBASE.GermanyCW.H_GDR_18` H GDR 18
---* `AIRBASE.GermanyCW.H_GDR_19` H GDR 19
---* `AIRBASE.GermanyCW.H_GDR_21` H GDR 21
---* `AIRBASE.GermanyCW.H_GDR_22` H GDR 22
---* `AIRBASE.GermanyCW.H_GDR_24` H GDR 24
---* `AIRBASE.GermanyCW.H_GDR_25` H GDR 25
---* `AIRBASE.GermanyCW.H_GDR_26` H GDR 26
---* `AIRBASE.GermanyCW.H_GDR_30` H GDR 30
---* `AIRBASE.GermanyCW.H_GDR_31` H GDR 31
---* `AIRBASE.GermanyCW.H_GDR_32` H GDR 32
---* `AIRBASE.GermanyCW.H_GDR_33` H GDR 33
---* `AIRBASE.GermanyCW.H_GDR_34` H GDR 34
---* `AIRBASE.GermanyCW.H_Med_FRG_01` H Med FRG 01
---* `AIRBASE.GermanyCW.H_Med_FRG_02` H Med FRG 02
---* `AIRBASE.GermanyCW.H_Med_FRG_04` H Med FRG 04
---* `AIRBASE.GermanyCW.H_Med_FRG_06` H Med FRG 06
---* `AIRBASE.GermanyCW.H_Med_FRG_11` H Med FRG 11
---* `AIRBASE.GermanyCW.H_Med_FRG_12` H Med FRG 12
---* `AIRBASE.GermanyCW.H_Med_FRG_13` H Med FRG 13
---* `AIRBASE.GermanyCW.H_Med_FRG_14` H Med FRG 14
---* `AIRBASE.GermanyCW.H_Med_FRG_15` H Med FRG 15
---* `AIRBASE.GermanyCW.H_Med_FRG_16` H Med FRG 16
---* `AIRBASE.GermanyCW.H_Med_FRG_17` H Med FRG 17
---* `AIRBASE.GermanyCW.H_Med_FRG_21` H Med FRG 21
---* `AIRBASE.GermanyCW.H_Med_FRG_24` H Med FRG 24
---* `AIRBASE.GermanyCW.H_Med_FRG_26` H Med FRG 26
---* `AIRBASE.GermanyCW.H_Med_FRG_27` H Med FRG 27
---* `AIRBASE.GermanyCW.H_Med_FRG_29` H Med FRG 29
---* `AIRBASE.GermanyCW.H_Med_GDR_01` H Med GDR 01
---* `AIRBASE.GermanyCW.H_Med_GDR_02` H Med GDR 02
---* `AIRBASE.GermanyCW.H_Med_GDR_03` H Med GDR 03
---* `AIRBASE.GermanyCW.H_Med_GDR_08` H Med GDR 08
---* `AIRBASE.GermanyCW.H_Med_GDR_09` H Med GDR 09
---* `AIRBASE.GermanyCW.H_Med_GDR_10` H Med GDR 10
---* `AIRBASE.GermanyCW.H_Med_GDR_11` H Med GDR 11
---* `AIRBASE.GermanyCW.H_Med_GDR_12` H Med GDR 12
---* `AIRBASE.GermanyCW.H_Med_GDR_13` H Med GDR 13
---* `AIRBASE.GermanyCW.H_Med_GDR_14` H Med GDR 14
---* `AIRBASE.GermanyCW.H_Med_GDR_16` H Med GDR 16
---* `AIRBASE.GermanyCW.H_Radar_FRG_02` H Radar FRG 02
---* `AIRBASE.GermanyCW.H_Radar_GDR_01` H Radar GDR 01
---* `AIRBASE.GermanyCW.H_Radar_GDR_02` H Radar GDR 02
---* `AIRBASE.GermanyCW.H_Radar_GDR_03` H Radar GDR 03
---* `AIRBASE.GermanyCW.H_Radar_GDR_04` H Radar GDR 04
---* `AIRBASE.GermanyCW.H_Radar_GDR_05` H Radar GDR 05
---* `AIRBASE.GermanyCW.H_Radar_GDR_06` H Radar GDR 06
---* `AIRBASE.GermanyCW.H_Radar_GDR_07` H Radar GDR 07
---* `AIRBASE.GermanyCW.H_Radar_GDR_08` H Radar GDR 08
---* `AIRBASE.GermanyCW.H_Radar_GDR_09` H Radar GDR 09
---* `AIRBASE.GermanyCW.Hahn` Hahn
---* `AIRBASE.GermanyCW.Haina` Haina
---* `AIRBASE.GermanyCW.Hamburg` Hamburg
---* `AIRBASE.GermanyCW.Hamburg_Finkenwerder` Hamburg Finkenwerder
---* `AIRBASE.GermanyCW.Hannover` Hannover
---* `AIRBASE.GermanyCW.Hasselfelde` Hasselfelde
---* `AIRBASE.GermanyCW.Heidelberg` Heidelberg
---* `AIRBASE.GermanyCW.Herrenteich` Herrenteich
---* `AIRBASE.GermanyCW.Hildesheim` Hildesheim
---* `AIRBASE.GermanyCW.Hockenheim` Hockenheim
---* `AIRBASE.GermanyCW.Holzdorf` Holzdorf
---* `AIRBASE.GermanyCW.Kammermark` Kammermark
---* `AIRBASE.GermanyCW.Kastrup` Kastrup
---* `AIRBASE.GermanyCW.Kiel` Kiel
---* `AIRBASE.GermanyCW.Koethen` Kothen
---* `AIRBASE.GermanyCW.Laage` Laage
---* `AIRBASE.GermanyCW.Landstuhl` Landstuhl
---* `AIRBASE.GermanyCW.Langenselbold` Langenselbold
---* `AIRBASE.GermanyCW.Laerz` Larz
---* `AIRBASE.GermanyCW.Leipzig_Mockau` Leipzig Mockau
---* `AIRBASE.GermanyCW.Luebeck` Lubeck
---* `AIRBASE.GermanyCW.Lueneburg` Luneburg
---* `AIRBASE.GermanyCW.Mahlwinkel` Mahlwinkel
---* `AIRBASE.GermanyCW.Mainz_Finthen` Mainz Finthen
---* `AIRBASE.GermanyCW.Marxwalde` Marxwalde
---* `AIRBASE.GermanyCW.Mendig` Mendig
---* `AIRBASE.GermanyCW.Merseburg` Merseburg
---* `AIRBASE.GermanyCW.Neubrandenburg` Neubrandenburg
---* `AIRBASE.GermanyCW.Neuruppin` Neuruppin
---* `AIRBASE.GermanyCW.Nordholz` Nordholz
---* `AIRBASE.GermanyCW.Northeim` Northeim
---* `AIRBASE.GermanyCW.Noervenich` Norvenich
---* `AIRBASE.GermanyCW.Ober_Moerlen` Ober-Morlen
---* `AIRBASE.GermanyCW.Obermehler_Schlotheim` Obermehler Schlotheim
---* `AIRBASE.GermanyCW.Oranienburg` Oranienburg
---* `AIRBASE.GermanyCW.Parchim` Parchim
---* `AIRBASE.GermanyCW.Peenemuende` Peenemunde
---* `AIRBASE.GermanyCW.Perwenitz` Perwenitz
---* `AIRBASE.GermanyCW.Pferdsfeld` Pferdsfeld
---* `AIRBASE.GermanyCW.Pinnow` Pinnow
---* `AIRBASE.GermanyCW.Pottschutthoehe` Pottschutthohe
---* `AIRBASE.GermanyCW.Ramstein` Ramstein
---* `AIRBASE.GermanyCW.Revinge` Revinge
---* `AIRBASE.GermanyCW.Rinteln` Rinteln
---* `AIRBASE.GermanyCW.Schkeuditz` Schkeuditz
---* `AIRBASE.GermanyCW.Schoenefeld` Schonefeld
---* `AIRBASE.GermanyCW.Schweinfurt` Schweinfurt
---* `AIRBASE.GermanyCW.Sembach` Sembach
---* `AIRBASE.GermanyCW.Sittensen` Sittensen
---* `AIRBASE.GermanyCW.Spangdahlem` Spangdahlem
---* `AIRBASE.GermanyCW.Sperenberg` Sperenberg
---* `AIRBASE.GermanyCW.Sprendlingen` Sprendlingen
---* `AIRBASE.GermanyCW.Stendal` Stendal
---* `AIRBASE.GermanyCW.Sturup` Sturup
---* `AIRBASE.GermanyCW.Szczecin_Goleniow` Szczecin-Goleniow
---* `AIRBASE.GermanyCW.Tagra` Tagra
---* `AIRBASE.GermanyCW.Tegel` Tegel
---* `AIRBASE.GermanyCW.Tempelhof` Tempelhof
---* `AIRBASE.GermanyCW.Templin` Templin
---* `AIRBASE.GermanyCW.Thurland` Thurland
---* `AIRBASE.GermanyCW.Tutow` Tutow
---* `AIRBASE.GermanyCW.Uelzen` Uelzen
---* `AIRBASE.GermanyCW.Uetersen` Uetersen
---* `AIRBASE.GermanyCW.Ummern` Ummern
---* `AIRBASE.GermanyCW.Verden_Scharnhorst` Verden-Scharnhorst
---* `AIRBASE.GermanyCW.Walldorf` Walldorf
---* `AIRBASE.GermanyCW.Waren_Vielist` Waren Vielist
---* `AIRBASE.GermanyCW.Werneuchen` Werneuchen
---* `AIRBASE.GermanyCW.Weser_Wuemme` Weser Wumme
---* `AIRBASE.GermanyCW.Wiesbaden` Wiesbaden
---* `AIRBASE.GermanyCW.Wismar` Wismar
---* `AIRBASE.GermanyCW.Wittstock` Wittstock
---* `AIRBASE.GermanyCW.Worms` Worms
---* `AIRBASE.GermanyCW.Wunstorf` Wunstorf
---* `AIRBASE.GermanyCW.Zerbst` Zerbst
---* `AIRBASE.GermanyCW.Zoellschen` Zollschen
---* `AIRBASE.GermanyCW.Zweibruecken` Zweibrucken
AIRBASE.GermanyCW = {
  ["Adelsheim"] = "Adelsheim",
  ["Airracing_Frankfurt"] = "Airracing Frankfurt",
  ["Airracing_Koblenz"] = "Airracing Koblenz",
  ["Airracing_Luebeck"] = "Airracing Lubeck",
  ["Allstedt"] = "Allstedt",
  ["Altes_Lager"] = "Altes Lager",
  ["Bad_Duerkheim"] = "Bad Durkheim",
  ["Barth"] = "Barth",
  ["Bienenfarm"] = "Bienenfarm",
  ["Bindersleben"] = "Bindersleben",
  ["Bitburg"] = "Bitburg",
  ["Bornholm"] = "Bornholm",
  ["Brand"] = "Brand",
  ["Brandis"] = "Brandis",
  ["Braunschweig"] = "Braunschweig",
  ["Bremen"] = "Bremen",
  ["Briest"] = "Briest",
  ["Buechel"] = "Buchel",
  ["Bueckeburg"] = "Buckeburg",
  ["Celle"] = "Celle",
  ["Chojna"] = "Chojna",
  ["Cochstedt"] = "Cochstedt",
  ["Cologne"] = "Cologne",
  ["Damgarten"] = "Damgarten",
  ["Dedelow"] = "Dedelow",
  ["Dessau"] = "Dessau",
  ["Duesseldorf"] = "Dusseldorf",
  ["Falkenberg"] = "Falkenberg",
  ["Fassberg"] = "Fassberg",
  ["Finow"] = "Finow",
  ["Frankfurt"] = "Frankfurt",
  ["Fritzlar"] = "Fritzlar",
  ["Fulda"] = "Fulda",
  ["Gardelegen"] = "Gardelegen",
  ["Garz"] = "Garz",
  ["Gatow"] = "Gatow",
  ["Gelnhausen"] = "Gelnhausen",
  ["Giebelstadt"] = "Giebelstadt",
  ["Glindbruchkippe"] = "Glindbruchkippe",
  ["Gross_Mohrdorf"] = "Gross Mohrdorf",
  ["Grosse_Wiese"] = "Grosse Wiese",
  ["Guetersloh"] = "Gutersloh",
  ["H_FRG_01"] = "H FRG 01",
  ["H_FRG_02"] = "H FRG 02",
  ["H_FRG_03"] = "H FRG 03",
  ["H_FRG_04"] = "H FRG 04",
  ["H_FRG_05"] = "H FRG 05",
  ["H_FRG_06"] = "H FRG 06",
  ["H_FRG_07"] = "H FRG 07",
  ["H_FRG_08"] = "H FRG 08",
  ["H_FRG_09"] = "H FRG 09",
  ["H_FRG_10"] = "H FRG 10",
  ["H_FRG_11"] = "H FRG 11",
  ["H_FRG_12"] = "H FRG 12",
  ["H_FRG_13"] = "H FRG 13",
  ["H_FRG_14"] = "H FRG 14",
  ["H_FRG_15"] = "H FRG 15",
  ["H_FRG_16"] = "H FRG 16",
  ["H_FRG_17"] = "H FRG 17",
  ["H_FRG_18"] = "H FRG 18",
  ["H_FRG_19"] = "H FRG 19",
  ["H_FRG_20"] = "H FRG 20",
  ["H_FRG_21"] = "H FRG 21",
  ["H_FRG_23"] = "H FRG 23",
  ["H_FRG_25"] = "H FRG 25",
  ["H_FRG_27"] = "H FRG 27",
  ["H_FRG_30"] = "H FRG 30",
  ["H_FRG_31"] = "H FRG 31",
  ["H_FRG_32"] = "H FRG 32",
  ["H_FRG_34"] = "H FRG 34",
  ["H_FRG_38"] = "H FRG 38",
  ["H_FRG_39"] = "H FRG 39",
  ["H_FRG_40"] = "H FRG 40",
  ["H_FRG_41"] = "H FRG 41",
  ["H_FRG_42"] = "H FRG 42",
  ["H_FRG_43"] = "H FRG 43",
  ["H_FRG_44"] = "H FRG 44",
  ["H_FRG_45"] = "H FRG 45",
  ["H_FRG_46"] = "H FRG 46",
  ["H_FRG_47"] = "H FRG 47",
  ["H_FRG_48"] = "H FRG 48",
  ["H_FRG_49"] = "H FRG 49",
  ["H_FRG_50"] = "H FRG 50",
  ["H_FRG_51"] = "H FRG 51",
  ["H_GDR_01"] = "H GDR 01",
  ["H_GDR_02"] = "H GDR 02",
  ["H_GDR_03"] = "H GDR 03",
  ["H_GDR_04"] = "H GDR 04",
  ["H_GDR_05"] = "H GDR 05",
  ["H_GDR_06"] = "H GDR 06",
  ["H_GDR_07"] = "H GDR 07",
  ["H_GDR_08"] = "H GDR 08",
  ["H_GDR_09"] = "H GDR 09",
  ["H_GDR_10"] = "H GDR 10",
  ["H_GDR_11"] = "H GDR 11",
  ["H_GDR_12"] = "H GDR 12",
  ["H_GDR_13"] = "H GDR 13",
  ["H_GDR_14"] = "H GDR 14",
  ["H_GDR_15"] = "H GDR 15",
  ["H_GDR_16"] = "H GDR 16",
  ["H_GDR_17"] = "H GDR 17",
  ["H_GDR_18"] = "H GDR 18",
  ["H_GDR_19"] = "H GDR 19",
  ["H_GDR_21"] = "H GDR 21",
  ["H_GDR_22"] = "H GDR 22",
  ["H_GDR_24"] = "H GDR 24",
  ["H_GDR_25"] = "H GDR 25",
  ["H_GDR_26"] = "H GDR 26",
  ["H_GDR_30"] = "H GDR 30",
  ["H_GDR_31"] = "H GDR 31",
  ["H_GDR_32"] = "H GDR 32",
  ["H_GDR_33"] = "H GDR 33",
  ["H_GDR_34"] = "H GDR 34",
  ["H_Med_FRG_01"] = "H Med FRG 01",
  ["H_Med_FRG_02"] = "H Med FRG 02",
  ["H_Med_FRG_04"] = "H Med FRG 04",
  ["H_Med_FRG_06"] = "H Med FRG 06",
  ["H_Med_FRG_11"] = "H Med FRG 11",
  ["H_Med_FRG_12"] = "H Med FRG 12",
  ["H_Med_FRG_13"] = "H Med FRG 13",
  ["H_Med_FRG_14"] = "H Med FRG 14",
  ["H_Med_FRG_15"] = "H Med FRG 15",
  ["H_Med_FRG_16"] = "H Med FRG 16",
  ["H_Med_FRG_17"] = "H Med FRG 17",
  ["H_Med_FRG_21"] = "H Med FRG 21",
  ["H_Med_FRG_24"] = "H Med FRG 24",
  ["H_Med_FRG_26"] = "H Med FRG 26",
  ["H_Med_FRG_27"] = "H Med FRG 27",
  ["H_Med_FRG_29"] = "H Med FRG 29",
  ["H_Med_GDR_01"] = "H Med GDR 01",
  ["H_Med_GDR_02"] = "H Med GDR 02",
  ["H_Med_GDR_03"] = "H Med GDR 03",
  ["H_Med_GDR_08"] = "H Med GDR 08",
  ["H_Med_GDR_09"] = "H Med GDR 09",
  ["H_Med_GDR_10"] = "H Med GDR 10",
  ["H_Med_GDR_11"] = "H Med GDR 11",
  ["H_Med_GDR_12"] = "H Med GDR 12",
  ["H_Med_GDR_13"] = "H Med GDR 13",
  ["H_Med_GDR_14"] = "H Med GDR 14",
  ["H_Med_GDR_16"] = "H Med GDR 16",
  ["H_Radar_FRG_02"] = "H Radar FRG 02",
  ["H_Radar_GDR_01"] = "H Radar GDR 01",
  ["H_Radar_GDR_02"] = "H Radar GDR 02",
  ["H_Radar_GDR_03"] = "H Radar GDR 03",
  ["H_Radar_GDR_04"] = "H Radar GDR 04",
  ["H_Radar_GDR_05"] = "H Radar GDR 05",
  ["H_Radar_GDR_06"] = "H Radar GDR 06",
  ["H_Radar_GDR_07"] = "H Radar GDR 07",
  ["H_Radar_GDR_08"] = "H Radar GDR 08",
  ["H_Radar_GDR_09"] = "H Radar GDR 09",
  ["Hahn"] = "Hahn",
  ["Haina"] = "Haina",
  ["Hamburg"] = "Hamburg",
  ["Hamburg_Finkenwerder"] = "Hamburg Finkenwerder",
  ["Hannover"] = "Hannover",
  ["Hasselfelde"] = "Hasselfelde",
  ["Heidelberg"] = "Heidelberg",
  ["Herrenteich"] = "Herrenteich",
  ["Hildesheim"] = "Hildesheim",
  ["Hockenheim"] = "Hockenheim",
  ["Holzdorf"] = "Holzdorf",
  ["Kammermark"] = "Kammermark",
  ["Kastrup"] = "Kastrup",
  ["Kiel"] = "Kiel",
  ["Koethen"] = "Kothen",
  ["Laage"] = "Laage",
  ["Landstuhl"] = "Landstuhl",
  ["Langenselbold"] = "Langenselbold",
  ["Laerz"] = "Larz",
  ["Leipzig_Mockau"] = "Leipzig Mockau",
  ["Luebeck"] = "Lubeck",
  ["Lueneburg"] = "Luneburg",
  ["Mahlwinkel"] = "Mahlwinkel",
  ["Mainz_Finthen"] = "Mainz Finthen",
  ["Marxwalde"] = "Marxwalde",
  ["Mendig"] = "Mendig",
  ["Merseburg"] = "Merseburg",
  ["Neubrandenburg"] = "Neubrandenburg",
  ["Neuruppin"] = "Neuruppin",
  ["Nordholz"] = "Nordholz",
  ["Northeim"] = "Northeim",
  ["Noervenich"] = "Norvenich",
  ["Ober_Moerlen"] = "Ober-Morlen",
  ["Obermehler_Schlotheim"] = "Obermehler Schlotheim",
  ["Oranienburg"] = "Oranienburg",
  ["Parchim"] = "Parchim",
  ["Peenemuende"] = "Peenemunde",
  ["Perwenitz"] = "Perwenitz",
  ["Pferdsfeld"] = "Pferdsfeld",
  ["Pinnow"] = "Pinnow",
  ["Pottschutthoehe"] = "Pottschutthohe",
  ["Ramstein"] = "Ramstein",
  ["Revinge"] = "Revinge",
  ["Rinteln"] = "Rinteln",
  ["Schkeuditz"] = "Schkeuditz",
  ["Schoenefeld"] = "Schonefeld",
  ["Schweinfurt"] = "Schweinfurt",
  ["Sembach"] = "Sembach",
  ["Sittensen"] = "Sittensen",
  ["Spangdahlem"] = "Spangdahlem",
  ["Sperenberg"] = "Sperenberg",
  ["Sprendlingen"] = "Sprendlingen",
  ["Stendal"] = "Stendal",
  ["Sturup"] = "Sturup",
  ["Szczecin_Goleniow"] = "Szczecin-Goleniow",
  ["Tagra"] = "Tagra",
  ["Tegel"] = "Tegel",
  ["Tempelhof"] = "Tempelhof",
  ["Templin"] = "Templin",
  ["Thurland"] = "Thurland",
  ["Tutow"] = "Tutow",
  ["Uelzen"] = "Uelzen",
  ["Uetersen"] = "Uetersen",
  ["Ummern"] = "Ummern",
  ["Verden_Scharnhorst"] = "Verden-Scharnhorst",
  ["Walldorf"] = "Walldorf",
  ["Waren_Vielist"] = "Waren Vielist",
  ["Werneuchen"] = "Werneuchen",
  ["Weser_Wuemme"] = "Weser Wumme",
  ["Wiesbaden"] = "Wiesbaden",
  ["Wismar"] = "Wismar",
  ["Wittstock"] = "Wittstock",
  ["Worms"] = "Worms",
  ["Wunstorf"] = "Wunstorf",
  ["Zerbst"] = "Zerbst",
  ["Zoellschen"] = "Zollschen",
  ["Zweibruecken"] = "Zweibrucken",
}

---Terminal Types of parking spots. See also https://wiki.hoggitworld.com/view/DCS_func_getParking
---
---Supported types are:
---
---* AIRBASE.TerminalType.Runway = 16: Valid spawn points on runway.
---* AIRBASE.TerminalType.HelicopterOnly = 40: Special spots for Helicopers.
---* AIRBASE.TerminalType.Shelter = 68: Hardened Air Shelter. Currently only on Caucaus map.
---* AIRBASE.TerminalType.OpenMed = 72: Open/Shelter air airplane only.
---* AIRBASE.TerminalType.OpenBig = 104: Open air spawn points. Generally larger but does not guarantee large aircraft are capable of spawning there.
---* AIRBASE.TerminalType.OpenMedOrBig = 176: Combines OpenMed and OpenBig spots.
---* AIRBASE.TerminalType.HelicopterUsable = 216: Combines HelicopterOnly, OpenMed and OpenBig.
---* AIRBASE.TerminalType.FighterAircraft = 244: Combines Shelter. OpenMed and OpenBig spots. So effectively all spots usable by fixed wing aircraft.
---@class AIRBASE.TerminalType
---@field Runway number 16: Valid spawn points on runway.
---@field HelicopterOnly number 40: Special spots for Helicopers.
---@field Shelter number 68: Hardened Air Shelter. Currently only on Caucaus map.
---@field OpenMed number 72: Open/Shelter air airplane only.
---@field SmallSizeFigher number 100: Tight spots for smaller type fixed wing aircraft, like the F-16. Example of these spots: 04, 05, 06 on Muwaffaq_Salti. A Viper sized plane can spawn here, but an A-10 or Strike Eagle can't
---@field OpenBig number 104: Open air spawn points. Generally larger but does not guarantee large aircraft are capable of spawning there.
---@field OpenMedOrBig number 176: Combines OpenMed and OpenBig spots.
---@field HelicopterUsable number 216: Combines HelicopterOnly, OpenMed and OpenBig.
---@field FighterAircraft number 244: Combines Shelter, OpenMed and OpenBig spots. So effectively all spots usable by fixed wing aircraft.
---@field FighterAircraftSmall number 344: Combines Shelter, SmallsizeFighter, OpenMed and OpenBig spots. So effectively all spots usable by small fixed wing aircraft.
AIRBASE.TerminalType = {
  Runway=16,
  HelicopterOnly=40,
  Shelter=68,
  OpenMed=72,
  SmallSizeFighter=100,
  OpenBig=104,
  OpenMedOrBig=176,
  HelicopterUsable=216,
  FighterAircraft=244,
  FighterAircraftSmall=344,
}

---Status of a parking spot.
---@class AIRBASE.SpotStatus
---@field FREE string Spot is free.
---@field OCCUPIED string Spot is occupied.
---@field RESERVED string Spot is reserved.
AIRBASE.SpotStatus = {
  FREE="Free",
  OCCUPIED="Occupied",
  RESERVED="Reserved",
}

---Create a new AIRBASE from DCSAirbase.
---@param AirbaseName? string The name of the airbase.
---@return AIRBASE # self
function AIRBASE:Register(AirbaseName) end

---Get the true airbase center as seen in the ME. The position returned by the dcs object is is wrong and often at the start of the runway.
---@return Vec2 # The center of the true center of the airbase if it contains runways, otherwise the default DCS object position.
function AIRBASE:GetVec2() end

---Get the category of this airbase. This is only a debug function because DCS 2.9 incorrectly returns heliports as airdromes.
function AIRBASE:_GetCategory() end

---Finds a AIRBASE from the _DATABASE using a DCSAirbase object.
---@param DCSAirbase? Airbase An existing DCS Airbase object reference.
---@return AIRBASE # self
function AIRBASE:Find(DCSAirbase) end

---Find a AIRBASE in the _DATABASE using the name of an existing DCS Airbase.
---@param AirbaseName? string The Airbase Name.
---@return AIRBASE # self
function AIRBASE:FindByName(AirbaseName) end

---Find a AIRBASE in the _DATABASE by its ID.
---@param id? number Airbase ID.
---@return AIRBASE # self
function AIRBASE:FindByID(id) end

---Get the DCS object of an airbase
---@return Airbase # DCS airbase object.
function AIRBASE:GetDCSObject() end

---Get the airbase zone.
---@return ZONE_RADIUS # The zone radius of the airbase.
function AIRBASE:GetZone() end

---Get the DCS warehouse.
---@return Warehouse # The DCS warehouse object.
function AIRBASE:GetWarehouse() end

---Get the warehouse storage of this airbase. The returned `STORAGE` object is the wrapper of the DCS warehouse.
---This allows you to add and remove items such as aircraft, liquids, weapons and other equipment.
---@return STORAGE # The storage.
function AIRBASE:GetStorage() end

---Enables or disables automatic capturing of the airbase.
---@param Switch? boolean If `true`, enable auto capturing. If `false`, disable it.
---@return AIRBASE # self
function AIRBASE:SetAutoCapture(Switch) end

---Enables automatic capturing of the airbase.
---@return AIRBASE # self
function AIRBASE:SetAutoCaptureON() end

---Disables automatic capturing of the airbase.
---@return AIRBASE # self
function AIRBASE:SetAutoCaptureOFF() end

---Returns whether auto capturing of the airbase is on or off.
---@return boolean # Returns `true` if auto capturing is on, `false` if off and `nil` if the airbase object cannot be retrieved.
function AIRBASE:IsAutoCapture() end

---Sets the coalition of the airbase.
---@param Coal? number Coalition that the airbase should have (0=Neutral, 1=Red, 2=Blue).
---@return AIRBASE # self
function AIRBASE:SetCoalition(Coal) end

---Get all airbases of the current map. This includes ships and FARPS.
---@param coalition? Coalition (Optional) Return only airbases belonging to the specified coalition. By default, all airbases of the map are returned.
---@param category? number (Optional) Return only airbases of a certain category, e.g. Airbase.Category.FARP
---@return table # Table containing all airbase objects of the current map.
function AIRBASE.GetAllAirbases(coalition, category) end

---Get all airbase names of the current map. This includes ships and FARPS.
---@param coalition? Coalition (Optional) Return only airbases belonging to the specified coalition. By default, all airbases of the map are returned.
---@param category? number (Optional) Return only airbases of a certain category, e.g. `Airbase.Category.HELIPAD`.
---@return table # Table containing all airbase names of the current map.
function AIRBASE.GetAllAirbaseNames(coalition, category) end

---Get ID of the airbase.
---@param unique? boolean (Optional) If true, ships will get a negative sign as the unit ID might be the same as an airbase ID. Default off!
---@return number # The airbase ID.
function AIRBASE:GetID(unique) end

---Set parking spot whitelist. Only these spots will be considered for spawning.
---Black listed spots overrule white listed spots.
---**NOTE** that terminal IDs are not necessarily the same as those displayed in the mission editor!
---@param TerminalIdWhitelist? table Table of white listed terminal IDs.
---@return AIRBASE # self
function AIRBASE:SetParkingSpotWhitelist(TerminalIdWhitelist) end

---Set parking spot blacklist. These parking spots will *not* be used for spawning.
---Black listed spots overrule white listed spots.
---**NOTE** that terminal IDs are not necessarily the same as those displayed in the mission editor!
---@param TerminalIdBlacklist? table Table of black listed terminal IDs.
---@return AIRBASE # self
function AIRBASE:SetParkingSpotBlacklist(TerminalIdBlacklist) end

---Sets the ATC belonging to an airbase object to be silent and unresponsive. This is useful for disabling the award winning ATC behavior in DCS.
---Note that this DOES NOT remove the airbase from the list. It just makes it unresponsive and silent to any radio calls to it.
---@param Silent? boolean If `true`, enable silent mode. If `false` or `nil`, disable silent mode.
---@return AIRBASE # self
function AIRBASE:SetRadioSilentMode(Silent) end

---Check whether or not the airbase has been silenced.
---@return boolean # If `true`, silent mode is enabled.
function AIRBASE:GetRadioSilentMode() end

---Get category of airbase.
---@return number # Category of airbase from GetDesc().category.
function AIRBASE:GetAirbaseCategory() end

---Check if airbase is an airdrome.
---@return boolean # If true, airbase is an airdrome.
function AIRBASE:IsAirdrome() end

---Check if airbase is a helipad.
---@return boolean # If true, airbase is a helipad.
function AIRBASE:IsHelipad() end

---Check if airbase is a ship.
---@return boolean # If true, airbase is a ship.
function AIRBASE:IsShip() end

---Check if airbase is a ZELL booster.
---@return boolean # If true, airbase is a ZELL booster.
function AIRBASE:IsZell() end

---Returns a table of parking data for a given airbase. If the optional parameter *available* is true only available parking will be returned, otherwise all parking at the base is returned. Term types have the following enumerated values:
---
---* 16 : Valid spawn points on runway
---* 40 : Helicopter only spawn
---* 68 : Hardened Air Shelter
---* 72 : Open/Shelter air airplane only
---* 104: Open air spawn
---
---Note that only Caucuses will return 68 as it is the only map currently with hardened air shelters.
---104 are also generally larger, but does not guarantee a large aircraft like the B-52 or a C-130 are capable of spawning there.
---
---Table entries:
---
---* Term_index is the id for the parking
---* vTerminal pos is its vec3 position in the world
---* fDistToRW is the distance to the take-off position for the active runway from the parking.
---@param available? boolean If true, only available parking spots will be returned.
---@return table # Table with parking data. See https://wiki.hoggitworld.com/view/DCS_func_getParking
function AIRBASE:GetParkingData(available) end

---Get number of parking spots at an airbase. Optionally, a specific terminal type can be requested.
---@param termtype? AIRBASE.TerminalType|number|string (Optional) Terminal type of which the number of spots is counted. Default all spots but spawn points on runway.
---@return number # Number of parking spots at this airbase.
function AIRBASE:GetParkingSpotsNumber(termtype) end

---Get number of free parking spots at an airbase.
---@param termtype? AIRBASE.TerminalType|number|string Terminal type.
---@param allowTOAC? boolean (Optional) If true, spots are considered free even though TO_AC is true. Default is off which is saver to avoid spawning aircraft on top of each other. Option might be enabled for FARPS and ships.
---@return number # Number of free parking spots at this airbase.
function AIRBASE:GetFreeParkingSpotsNumber(termtype, allowTOAC) end

---Get the coordinates of free parking spots at an airbase.
---@param termtype? AIRBASE.TerminalType|number|string Terminal type.
---@param allowTOAC? boolean (Optional) If true, spots are considered free even though TO_AC is true. Default is off which is saver to avoid spawning aircraft on top of each other. Option might be enabled for FARPS and ships.
---@return table # Table of coordinates of the free parking spots.
function AIRBASE:GetFreeParkingSpotsCoordinates(termtype, allowTOAC) end

---Get the coordinates of all parking spots at an airbase. Optionally only those of a specific terminal type. Spots on runways are excluded if not explicitly requested by terminal type.
---@param termtype? AIRBASE.TerminalType|number|string (Optional) Terminal type. Default all.
---@return table # Table of coordinates of parking spots.
function AIRBASE:GetParkingSpotsCoordinates(termtype) end

---Get the DCS#Vec2s of all parking spots at an airbase. Optionally only those of a specific terminal type. Spots on runways are excluded if not explicitly requested by terminal type.
---@param termtype? AIRBASE.TerminalType|number|string (Optional) Terminal type. Default all.
---@return table # Table of DCS#Vec2 of parking spots.
function AIRBASE:GetParkingSpotsVec2s(termtype) end

---Get the the bounding circular zone around all parking spots of an airbase.
---@param mark? boolean (Optional) Draw zone on map on first call of this function.
---@return ZONE_RADIUS # BoundingZone
function AIRBASE:GetMinimumBoundingCircleFromParkingSpots(mark) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---@return AIRBASE # self
function AIRBASE:_InitParkingSpots() end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---@param TerminalID? number Terminal ID.
---@return AIRBASE.ParkingSpot # Parking spot.
function AIRBASE:_GetParkingSpotByID(TerminalID) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---@param termtype? AIRBASE.TerminalType|number|string Terminal type.
---@return table # Table free parking spots. Table has the elements ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
function AIRBASE:GetParkingSpotsTable(termtype) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---@param termtype? AIRBASE.TerminalType|number|string Terminal type.
---@param allowTOAC? boolean (Optional) If true, spots are considered free even though TO_AC is true. Default is off which is saver to avoid spawning aircraft on top of each other. Option might be enabled for FARPS and ships.
---@return table # Table free parking spots. Table has the elements ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
function AIRBASE:GetFreeParkingSpotsTable(termtype, allowTOAC) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---@param TerminalID? number The terminal ID of the parking spot.
---@return AIRBASE.ParkingSpot # Table free parking spots. Table has the elements ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
function AIRBASE:GetParkingSpotData(TerminalID) end

---Place markers of parking spots on the F10 map.
---@param termtype? AIRBASE.TerminalType|number|string Terminal type for which marks should be placed.
---@param mark? boolean (Optional) If false, do not place markers but only give output to DCS.log file. Default true.
function AIRBASE:MarkParkingSpots(termtype, mark) end

---Seach unoccupied parking spots at the airbase for a specific group of aircraft. The routine also optionally checks for other unit, static and scenery options in a certain radius around the parking spot.
---The dimension of the spawned aircraft and of the potential obstacle are taken into account. Note that the routine can only return so many spots that are free.
---@param group? GROUP Aircraft group for which the parking spots are requested.
---@param terminaltype? AIRBASE.TerminalType|number|string (Optional) Only search spots at a specific terminal type. Default is all types execpt on runway.
---@param scanradius? number (Optional) Radius in meters around parking spot to scan for obstacles. Default 50 m.
---@param scanunits? boolean (Optional) Scan for units as obstacles. Default true.
---@param scanstatics? boolean (Optional) Scan for statics as obstacles. Default true.
---@param scanscenery? boolean (Optional) Scan for scenery as obstacles. Default false. Can cause problems with e.g. shelters.
---@param verysafe? boolean (Optional) If true, wait until an aircraft has taken off until the parking spot is considered to be free. Defaul false.
---@param nspots? number (Optional) Number of freeparking spots requested. Default is the number of aircraft in the group.
---@param parkingdata? table (Optional) Parking spots data table. If not given it is automatically derived from the GetParkingSpotsTable() function.
---@return table # Table of coordinates and terminal IDs of free parking spots. Each table entry has the elements .Coordinate and .TerminalID.
function AIRBASE:FindFreeParkingSpotForAircraft(group, terminaltype, scanradius, scanunits, scanstatics, scanscenery, verysafe, nspots, parkingdata) end

---Check black and white lists.
---@param TerminalID? number Terminal ID to check.
---@return boolean # `true` if this is a valid spot.
function AIRBASE:_CheckParkingLists(TerminalID) end

---Helper function to check for the correct terminal type including "artificial" ones.
---@param Term_Type? number Terminal type from getParking routine.
---@param termtype? AIRBASE.TerminalType|number|string Terminal type from AIRBASE.TerminalType enumerator.
---@return boolean # True if terminal types match.
function AIRBASE._CheckTerminalType(Term_Type, termtype) end

---Get runways.
---@return table # Runway data.
function AIRBASE:GetRunways() end

---Get runway by its name.
---@param Name? string Name of the runway, e.g. "31" or "21L".
---@return AIRBASE.Runway # Runway data.
function AIRBASE:GetRunwayByName(Name) end

---Init runways.
---@param IncludeInverse? boolean If `true` or `nil`, include inverse runways.
---@return table # Runway data.
function AIRBASE:_InitRunways(IncludeInverse) end

---Get runways data. Only for airdromes!
---@param magvar? number (Optional) Magnetic variation in degrees.
---@param mark? boolean (Optional) Place markers with runway data on F10 map.
---@return table # Runway data.
function AIRBASE:GetRunwayData(magvar, mark) end

---Set the active runway for landing and takeoff.
---@param Name? string Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param PreferLeft? boolean (Optional) If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
function AIRBASE:SetActiveRunway(Name, PreferLeft) end

---Set the active runway for landing.
---@param Name? string Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param PreferLeft? boolean (Optional) If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
---@return AIRBASE.Runway # The active runway for landing.
function AIRBASE:SetActiveRunwayLanding(Name, PreferLeft) end

---Get the active runways.
---@return AIRBASE.Runway # The active runway for landing.
---@return AIRBASE.Runway # The active runway for takeoff.
function AIRBASE:GetActiveRunway() end

---Get the active runway for landing.
---@return AIRBASE.Runway # The active runway for landing.
function AIRBASE:GetActiveRunwayLanding() end

---Get the active runway for takeoff.
---@return AIRBASE.Runway # The active runway for takeoff.
function AIRBASE:GetActiveRunwayTakeoff() end

---Set the active runway for takeoff.
---@param Name? string Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param PreferLeft? boolean (Optional) If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
---@return AIRBASE.Runway # The active runway for landing.
function AIRBASE:SetActiveRunwayTakeoff(Name, PreferLeft) end

---Get the runway where aircraft would be taking of or landing into the direction of the wind.
---NOTE that this requires the wind to be non-zero as set in the mission editor.
---@param PreferLeft? boolean (Optional) If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
---@return AIRBASE.Runway # Active runway data table.
function AIRBASE:GetRunwayIntoWind(PreferLeft) end

---Get name of a given runway, e.g. "31L".
---@param Runway? AIRBASE.Runway|number|string (Optional) The runway. Default is the active runway.
---@param LongLeftRight? boolean If `true`, return "Left" or "Right" instead of "L" or "R".
---@return string # Name of the runway or "XX" if it could not be found.
function AIRBASE:GetRunwayName(Runway, LongLeftRight) end

---Function that checks if at leat one unit of a group has been spawned close to a spawn point on the runway.
---@param group? GROUP Group to be checked.
---@param radius? number (Optional) Radius around the spawn point to be checked. Default is 50 m.
---@param despawn? boolean If true, the group is destroyed.
---@return boolean # True if group is within radius around spawn points on runway.
function AIRBASE:CheckOnRunWay(group, radius, despawn) end

---Get category of airbase.
---@return number # Category of airbase from GetDesc().category.
function AIRBASE:GetCategory() end

---Get category name of airbase.
---@return string # Category of airbase, i.e. Airdrome, Ship, or Helipad
function AIRBASE:GetCategoryName() end
