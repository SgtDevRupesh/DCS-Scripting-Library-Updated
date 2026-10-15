---@meta

---@class ENUMS.Storage.weapons.AH64D

---@class ENUMS.Storage.weapons.UH1H

---@class ENUMS.Storage.weapons.OH58

---@class ENUMS.Storage.weapons.CH47

---@class ENUMS.Storage.weapons.Gazelle

---@class ENUMS.Storage.weapons.torpedoes

---@class ENUMS.Storage.weapons.adapters

---@class ENUMS.Storage.weapons.droptanks

---@class ENUMS.Storage.weapons.containers

---@class ENUMS.Storage.weapons.nurs

---@class ENUMS.Storage.weapons.bombs

---@class ENUMS.Storage.weapons.missiles

---@class ENUMS.Storage.weapons

---[DCS Enum world](https://wiki.hoggitworld.com/view/DCS_enum_world)
---@class ENUMS
ENUMS = {}

---Rules of Engagement.
---@class ENUMS.ROE
---@field WeaponFree number [AIR] AI will engage any enemy group it detects. Target prioritization is based based on the threat of the target.
---@field OpenFireWeaponFree number [AIR] AI will engage any enemy group it detects, but will prioritize targets specified in the groups tasking.
---@field OpenFire number [AIR, GROUND, NAVAL] AI will engage only targets specified in its taskings.
---@field ReturnFire number [AIR, GROUND, NAVAL] AI will only engage threats that shoot first.
---@field WeaponHold number [AIR, GROUND, NAVAL] AI will hold fire under all circumstances.
ENUMS.ROE = {
  WeaponFree=0,
  OpenFireWeaponFree=1,
  OpenFire=2,
  ReturnFire=3,
  WeaponHold=4,
  }

---Reaction On Threat.
---@class ENUMS.ROT
---@field NoReaction number No defensive actions will take place to counter threats.
---@field PassiveDefense number AI will use jammers and other countermeasures in an attempt to defeat the threat. AI will not attempt a maneuver to defeat a threat.
---@field EvadeFire number AI will react by performing defensive maneuvers against incoming threats. AI will also use passive defense.
---@field BypassAndEscape number AI will attempt to avoid enemy threat zones all together. This includes attempting to fly above or around threats.
---@field AllowAbortMission number If a threat is deemed severe enough the AI will abort its mission and return to base.
ENUMS.ROT = {
  NoReaction=0,
  PassiveDefense=1,
  EvadeFire=2,
  BypassAndEscape=3,
  AllowAbortMission=4,
}

---Alarm state.
---@class ENUMS.AlarmState
---@field Auto number AI will automatically switch alarm states based on the presence of threats. The AI kind of cheats in this regard.
---@field Green number Group is not combat ready. Sensors are stowed if possible.
---@field Red number Group is combat ready and actively searching for targets. Some groups like infantry will not move in this state.
ENUMS.AlarmState = {
  Auto=0,
  Green=1,
  Red=2,
}

---Weapon types. See the [Weapon Flag](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag) enumerotor on hoggit wiki.
---@class ENUMS.WeaponFlag
ENUMS.WeaponFlag={
  LGB                  =          2,
  TvGB                 =          4,
  SNSGB                =          8,
  HEBomb               =         16,
  Penetrator           =         32,
  NapalmBomb           =         64,
  FAEBomb              =        128,
  ClusterBomb          =        256,
  Dispencer            =        512,
  CandleBomb           =       1024,
  ParachuteBomb        = 2147483648,
  LightRocket          =       2048,
  MarkerRocket         =       4096,
  CandleRocket         =       8192,
  HeavyRocket          =      16384,
  AntiRadarMissile     =      32768,
  AntiShipMissile      =      65536,
  AntiTankMissile      =     131072,
  FireAndForgetASM     =     262144,
  LaserASM             =     524288,
  TeleASM              =    1048576,
  CruiseMissile        =    2097152,
  AntiRadarMissile2    = 1073741824,
  SRAM                 =    4194304,
  MRAAM                =    8388608,
  LRAAM                =   16777216,
  IR_AAM               =   33554432,
  SAR_AAM              =   67108864,
  AR_AAM               =  134217728,
  GunPod               =  268435456,
  BuiltInCannon        =  536870912,
  GuidedBomb           =         14, -- (LGB + TvGB + SNSGB)
  AnyUnguidedBomb      = 2147485680, -- (HeBomb + Penetrator + NapalmBomb + FAEBomb + ClusterBomb + Dispencer + CandleBomb + ParachuteBomb)
  AnyBomb              = 2147485694, -- (GuidedBomb + AnyUnguidedBomb)
  AnyRocket            =      30720, -- LightRocket + MarkerRocket + CandleRocket + HeavyRocket
  GuidedASM            =    1572864, -- (LaserASM + TeleASM)
  TacticalASM          =    1835008, -- (GuidedASM + FireAndForgetASM)
  AnyASM               =    4161536, -- (AntiRadarMissile + AntiShipMissile + AntiTankMissile + FireAndForgetASM + GuidedASM + CruiseMissile)
  AnyASM2              = 1077903360, -- 4161536+1073741824,
  AnyAAM               =  264241152, -- IR_AAM + SAR_AAM + AR_AAM + SRAAM + MRAAM + LRAAM
  AnyAutonomousMissile =   36012032, -- IR_AAM + AntiRadarMissile + AntiShipMissile + FireAndForgetASM + CruiseMissile
  AnyMissile           =  268402688, -- AnyASM + AnyAAM
  Cannons              =  805306368, -- GUN_POD + BuiltInCannon
  Torpedo              = 4294967296,
  Decoys               = 8589934592,
  SmokeShell                =  17179869184,
  IlluminationShell         =  34359738368,
  MarkerShell               =  51539607552,
  MarkerWeapon              =  51539620864,
  SubmunitionDispenserShell =  68719476736,
  ConventionalShell         = 206963736576,
  Auto                 = 265214230526, -- Any Weapon (AnyBomb + AnyRocket + AnyMissile + Cannons + Torpedos)
  AutoDCS              =   1073741822, -- Something if often see
  AnyAG                =   2956984318, -- Any Air-To-Ground Weapon
  AnyAA                =    264241152, -- Any Air-To-Air Weapon
  AnyUnguided          =   2952822768, -- Any Unguided Weapon
  AnyGuided            =    268402702, -- Any Guided Weapon
  AnyShell             = 258503344128, -- Any Shell
}

---Weapon types by category. See the [Weapon Flag](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag) enumerator on hoggit wiki.
---@class ENUMS.WeaponType
---@field Bomb table Bombs.
---@field Rocket table Rocket.
---@field Gun table Guns.
---@field Missile table Missiles.
---@field AAM table Air-to-Air missiles.
---@field Torpedo table Torpedos.
---@field Any table Combinations.
ENUMS.WeaponType={}

ENUMS.WeaponType.Bomb={
  LGB                  =          2,
  TvGB                 =          4,
  SNSGB                =          8,
  HEBomb               =         16,
  Penetrator           =         32,
  NapalmBomb           =         64,
  FAEBomb              =        128,
  ClusterBomb          =        256,
  Dispencer            =        512,
  CandleBomb           =       1024,
  ParachuteBomb        = 2147483648,
  GuidedBomb           =         14, -- (LGB + TvGB + SNSGB)
  AnyUnguidedBomb      = 2147485680, -- (HeBomb + Penetrator + NapalmBomb + FAEBomb + ClusterBomb + Dispencer + CandleBomb + ParachuteBomb)
  AnyBomb              = 2147485694, -- (GuidedBomb + AnyUnguidedBomb)
}

ENUMS.WeaponType.Rocket={
  LightRocket          =       2048,
  MarkerRocket         =       4096,
  CandleRocket         =       8192,
  HeavyRocket          =      16384,
  AnyRocket            =      30720, -- LightRocket + MarkerRocket + CandleRocket + HeavyRocket
}

ENUMS.WeaponType.Gun={
  GunPod               =  268435456,
  BuiltInCannon        =  536870912,
  Cannons              =  805306368, -- GUN_POD + BuiltInCannon
}

ENUMS.WeaponType.Missile={
  AntiRadarMissile     =      32768,
  AntiShipMissile      =      65536,
  AntiTankMissile      =     131072,
  FireAndForgetASM     =     262144,
  LaserASM             =     524288,
  TeleASM              =    1048576,
  CruiseMissile        =    2097152,
  AntiRadarMissile2    = 1073741824,
  GuidedASM            =    1572864, -- (LaserASM + TeleASM)
  TacticalASM          =    1835008, -- (GuidedASM + FireAndForgetASM)
  AnyASM               =    4161536, -- (AntiRadarMissile + AntiShipMissile + AntiTankMissile + FireAndForgetASM + GuidedASM + CruiseMissile)
  AnyASM2              = 1077903360, -- 4161536+1073741824,
  AnyAutonomousMissile =   36012032, -- IR_AAM + AntiRadarMissile + AntiShipMissile + FireAndForgetASM + CruiseMissile
  AnyMissile           =  268402688, -- AnyASM + AnyAAM
}

ENUMS.WeaponType.AAM={
  SRAM                 =    4194304,
  MRAAM                =    8388608,
  LRAAM                =   16777216,
  IR_AAM               =   33554432,
  SAR_AAM              =   67108864,
  AR_AAM               =  134217728,
  AnyAAM               =  264241152, -- IR_AAM + SAR_AAM + AR_AAM + SRAAM + MRAAM + LRAAM
}

ENUMS.WeaponType.Torpedo={
  Torpedo              = 4294967296,
}

ENUMS.WeaponType.Any={
  Weapon               = 265214230526, -- Any Weapon (AnyBomb + AnyRocket + AnyMissile + Cannons + Torpedos)
  AG                   =   2956984318, -- Any Air-To-Ground Weapon
  AA                   =    264241152, -- Any Air-To-Air Weapon
  Unguided             =   2952822768, -- Any Unguided Weapon
  Guided               =    268402702, -- Any Guided Weapon
}

---Mission tasks.
---@class ENUMS.MissionTask
---@field NOTHING string No special task. Group can perform the minimal tasks: Orbit, Refuelling, Follow and Aerobatics.
---@field AFAC string Forward Air Controller Air. Can perform the tasks: Attack Group, Attack Unit, FAC assign group, Bombing, Attack Map Object.
---@field ANTISHIPSTRIKE string Naval ops. Can perform the tasks: Attack Group, Attack Unit.
---@field AWACS string AWACS.
---@field CAP string Combat Air Patrol.
---@field CAS string Close Air Support.
---@field ESCORT string Escort another group.
---@field FIGHTERSWEEP string Fighter sweep.
---@field GROUNDATTACK string Ground attack.
---@field GROUNDESCORT string Ground escort another group.
---@field INTERCEPT string Intercept.
---@field PINPOINTSTRIKE string Pinpoint strike.
---@field RECONNAISSANCE string Reconnaissance mission.
---@field REFUELING string Refueling mission.
---@field RUNWAYATTACK string Attack the runway of an airdrome.
---@field SEAD string Suppression of Enemy Air Defenses.
---@field TRANSPORT string Troop transport.
ENUMS.MissionTask={
  NOTHING="Nothing",
  AFAC="AFAC",
  ANTISHIPSTRIKE="Antiship Strike",
  AWACS="AWACS",
  CAP="CAP",
  CAS="CAS",
  ESCORT="Escort",
  GROUNDESCORT="Ground escort",
  FIGHTERSWEEP="Fighter Sweep",
  GROUNDATTACK="Ground Attack",
  INTERCEPT="Intercept",
  PINPOINTSTRIKE="Pinpoint Strike",
  RECONNAISSANCE="Reconnaissance",
  REFUELING="Refueling",
  RUNWAYATTACK="Runway Attack",
  SEAD="SEAD",
  TRANSPORT="Transport",
}

---Formations (new). See the [Formations](https://wiki.hoggitworld.com/view/DCS_enum_formation) on hoggit wiki.
---@class ENUMS.Formation
ENUMS.Formation={}

ENUMS.Formation.FixedWing={}

ENUMS.Formation.FixedWing.LineAbreast={}

ENUMS.Formation.FixedWing.LineAbreast.Close = 65537

ENUMS.Formation.FixedWing.LineAbreast.Open = 65538

ENUMS.Formation.FixedWing.LineAbreast.Group = 65539

ENUMS.Formation.FixedWing.Trail={}

ENUMS.Formation.FixedWing.Trail.Close = 131073

ENUMS.Formation.FixedWing.Trail.Open = 131074

ENUMS.Formation.FixedWing.Trail.Group = 131075

ENUMS.Formation.FixedWing.Wedge={}

ENUMS.Formation.FixedWing.Wedge.Close = 196609

ENUMS.Formation.FixedWing.Wedge.Open = 196610

ENUMS.Formation.FixedWing.Wedge.Group = 196611

ENUMS.Formation.FixedWing.EchelonRight={}

ENUMS.Formation.FixedWing.EchelonRight.Close = 262145

ENUMS.Formation.FixedWing.EchelonRight.Open = 262146

ENUMS.Formation.FixedWing.EchelonRight.Group = 262147

ENUMS.Formation.FixedWing.EchelonLeft={}

ENUMS.Formation.FixedWing.EchelonLeft.Close = 327681

ENUMS.Formation.FixedWing.EchelonLeft.Open = 327682

ENUMS.Formation.FixedWing.EchelonLeft.Group = 327683

ENUMS.Formation.FixedWing.FingerFour={}

ENUMS.Formation.FixedWing.FingerFour.Close = 393217

ENUMS.Formation.FixedWing.FingerFour.Open = 393218

ENUMS.Formation.FixedWing.FingerFour.Group = 393219

ENUMS.Formation.FixedWing.Spread={}

ENUMS.Formation.FixedWing.Spread.Close = 458753

ENUMS.Formation.FixedWing.Spread.Open = 458754

ENUMS.Formation.FixedWing.Spread.Group = 458755

ENUMS.Formation.FixedWing.BomberElement={}

ENUMS.Formation.FixedWing.BomberElement.Close = 786433

ENUMS.Formation.FixedWing.BomberElement.Open = 786434

ENUMS.Formation.FixedWing.BomberElement.Group = 786435

ENUMS.Formation.FixedWing.BomberElementHeight={}

ENUMS.Formation.FixedWing.BomberElementHeight.Close = 851968

ENUMS.Formation.FixedWing.FighterVic={}

ENUMS.Formation.FixedWing.FighterVic.Close = 917505

ENUMS.Formation.FixedWing.FighterVic.Open = 917506

ENUMS.Formation.RotaryWing={}

ENUMS.Formation.RotaryWing.Column={}

ENUMS.Formation.RotaryWing.Column.D70 = 720896

ENUMS.Formation.RotaryWing.Wedge={}

ENUMS.Formation.RotaryWing.Wedge.D70 = 8

ENUMS.Formation.RotaryWing.FrontRight={}

ENUMS.Formation.RotaryWing.FrontRight.D300 = 655361

ENUMS.Formation.RotaryWing.FrontRight.D600 = 655362

ENUMS.Formation.RotaryWing.FrontLeft={}

ENUMS.Formation.RotaryWing.FrontLeft.D300 = 655617

ENUMS.Formation.RotaryWing.FrontLeft.D600 = 655618

ENUMS.Formation.RotaryWing.EchelonRight={}

ENUMS.Formation.RotaryWing.EchelonRight.D70 = 589825

ENUMS.Formation.RotaryWing.EchelonRight.D300 = 589826

ENUMS.Formation.RotaryWing.EchelonRight.D600 = 589827

ENUMS.Formation.RotaryWing.EchelonLeft={}

ENUMS.Formation.RotaryWing.EchelonLeft.D70 = 590081

ENUMS.Formation.RotaryWing.EchelonLeft.D300 = 590082

ENUMS.Formation.RotaryWing.EchelonLeft.D600 = 590083

ENUMS.Formation.Vehicle={}

ENUMS.Formation.Vehicle.Vee = "Vee"

ENUMS.Formation.Vehicle.EchelonRight = "EchelonR"

ENUMS.Formation.Vehicle.OffRoad = "Off Road"

ENUMS.Formation.Vehicle.Rank = "Rank"

ENUMS.Formation.Vehicle.EchelonLeft = "EchelonL"

ENUMS.Formation.Vehicle.OnRoad = "On Road"

ENUMS.Formation.Vehicle.Cone = "Cone"

ENUMS.Formation.Vehicle.Diamond = "Diamond"

---Formations (old). The old format is a simplified version of the new formation enums, which allow more sophisticated settings.
---See the [Formations](https://wiki.hoggitworld.com/view/DCS_enum_formation) on hoggit wiki.
---@class ENUMS.FormationOld
ENUMS.FormationOld={}

ENUMS.FormationOld.FixedWing={}

ENUMS.FormationOld.FixedWing.LineAbreast = 1

ENUMS.FormationOld.FixedWing.Trail = 2

ENUMS.FormationOld.FixedWing.Wedge = 3

ENUMS.FormationOld.FixedWing.EchelonRight = 4

ENUMS.FormationOld.FixedWing.EchelonLeft = 5

ENUMS.FormationOld.FixedWing.FingerFour = 6

ENUMS.FormationOld.FixedWing.SpreadFour = 7

ENUMS.FormationOld.FixedWing.BomberElement = 12

ENUMS.FormationOld.FixedWing.BomberElementHeight = 13

ENUMS.FormationOld.FixedWing.FighterVic = 14

ENUMS.FormationOld.RotaryWing={}

ENUMS.FormationOld.RotaryWing.Wedge = 8

ENUMS.FormationOld.RotaryWing.Echelon = 9

ENUMS.FormationOld.RotaryWing.Front = 10

ENUMS.FormationOld.RotaryWing.Column = 11

---Morse Code. See the [Wikipedia](https://en.wikipedia.org/wiki/Morse_code).
---
---* Short pulse "*"
---* Long pulse "-"
---
---Pulses are separated by a blank character " ".
---@class ENUMS.Morse
ENUMS.Morse={}

ENUMS.Morse.A = "* -"

ENUMS.Morse.B = "- * * *"

ENUMS.Morse.C = "- * - *"

ENUMS.Morse.D = "- * *"

ENUMS.Morse.E = "*"

ENUMS.Morse.F = "* * - *"

ENUMS.Morse.G = "- - *"

ENUMS.Morse.H = "* * * *"

ENUMS.Morse.I = "* *"

ENUMS.Morse.J = "* - - -"

ENUMS.Morse.K = "- * -"

ENUMS.Morse.L = "* - * *"

ENUMS.Morse.M = "- -"

ENUMS.Morse.N = "- *"

ENUMS.Morse.O = "- - -"

ENUMS.Morse.P = "* - - *"

ENUMS.Morse.Q = "- - * -"

ENUMS.Morse.R = "* - *"

ENUMS.Morse.S = "* * *"

ENUMS.Morse.T = "-"

ENUMS.Morse.U = "* * -"

ENUMS.Morse.V = "* * * -"

ENUMS.Morse.W = "* - -"

ENUMS.Morse.X = "- * * -"

ENUMS.Morse.Y = "- * - -"

ENUMS.Morse.Z = "- - * *"

ENUMS.Morse.N1 = "* - - - -"

ENUMS.Morse.N2 = "* * - - -"

ENUMS.Morse.N3 = "* * * - -"

ENUMS.Morse.N4 = "* * * * -"

ENUMS.Morse.N5 = "* * * * *"

ENUMS.Morse.N6 = "- * * * *"

ENUMS.Morse.N7 = "- - * * *"

ENUMS.Morse.N8 = "- - - * *"

ENUMS.Morse.N9 = "- - - - *"

ENUMS.Morse.N0 = "- - - - -"

---ISO (639-1) 2-letter Language Codes. See the [Wikipedia](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
---@class ENUMS.ISOLang
ENUMS.ISOLang = {}

---Phonetic Alphabet (NATO). See the [Wikipedia](https://en.wikipedia.org/wiki/NATO_phonetic_alphabet).
---@class ENUMS.Phonetic
ENUMS.Phonetic = {}

---Reporting Names (NATO). See the [Wikipedia](https://en.wikipedia.org/wiki/List_of_NATO_reporting_names_for_fighter_aircraft).
---DCS known aircraft types
---@class ENUMS.ReportingName
ENUMS.ReportingName = {}

---Enums for Link16 transmit power
---@class ENUMS.Link16Power
ENUMS.Link16Power = {
  none = 0,
  low = 1,
  medium = 2,
  high = 3,
}

---Enums for the STORAGE class for stores - which need to be in ""
---@class ENUMS.Storage
ENUMS.Storage = {
  weapons = {
    missiles = {}, -- Missiles
    bombs = {}, -- Bombs
    nurs = {}, --  Rockets and unguided
    containers = {}, -- Containers
    shells = {}, -- Shells
    gunmounts = {}, -- Gun Mounts
    droptanks = {}, -- Droptanks
    adapters = {}, -- Adapter
    torpedoes = {}, -- Torpedoes
    Gazelle = {}, -- Gazelle specifics
    CH47 = {}, -- Chinook specifics
    OH58 = {}, -- Kiowa specifics
    UH1H = {}, -- Huey specifics
    AH64D = {}, -- Huey specifics
    UH60L = {}, -- Blackhawk specifics
  }
}

---@class ENUMS.FARPType
---@field FARP string
---@field INVISIBLE string
---@field HELIPADSINGLE string
---@field PADSINGLE string
ENUMS.FARPType = {
  FARP = "FARP",
  INVISIBLE = "INVISIBLE",
  HELIPADSINGLE = "HELIPADSINGLE",
  PADSINGLE = "PADSINGLE",
}

---@class ENUMS.FARPObjectTypeNamesAndShape
---@field FARP string
---@field INVISIBLE string
---@field HELIPADSINGLE string
---@field PADSINGLE string
ENUMS.FARPObjectTypeNamesAndShape ={
  [ENUMS.FARPType.FARP] = { TypeName="FARP", ShapeName="FARPS"},
  [ENUMS.FARPType.INVISIBLE] = { TypeName="Invisible FARP", ShapeName="invisiblefarp"},
  [ENUMS.FARPType.HELIPADSINGLE] = { TypeName="SINGLE_HELIPAD", ShapeName="FARP"},
  [ENUMS.FARPType.PADSINGLE] = { TypeName="FARP_SINGLE_01", ShapeName="FARP_SINGLE_01"},
}

---Radio frequency bands (HF, VHF, UHF)
---@class ENUMS.FrequencyBand
---@field HF number High frequency
---@field VHF_LOW number Very high frequency
---@field VHF_HI number Very high frequency
---@field UHF number Ultra high frequency
ENUMS.FrequencyBand = {
  HF = 0,
  VHF_LOW = 1,
  VHF_HI = 2,
  UHF = 3,
}

---Radio modulation types (AM, FM)
---@class ENUMS.ModulationType
---@field AM number Amplitude modulation
---@field FM number Frequency modulation
---@field AMFM number Amplitude and frequency modulation
---@field DISCARD number Discard modulation
ENUMS.ModulationType = {
  AM = 0,
  FM = 1,
  AMFM = 2,
  DISCARD = -1,
}
