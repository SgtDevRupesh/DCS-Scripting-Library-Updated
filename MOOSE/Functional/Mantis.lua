---@meta

---**MANTIS** class, extends Core.Base#BASE
---@class MANTIS : BASE
---@field ClassName string
---@field name string Name of this Mantis
---@field SAM_Templates_Prefix string Prefix to build the #SET_GROUP for SAM sites
---@field SAM_Group SET_GROUP The SAM #SET_GROUP
---@field EWR_Templates_Prefix string Prefix to build the #SET_GROUP for EWR group
---@field EWR_Group SET_GROUP The EWR #SET_GROUP
---@field Adv_EWR_Group SET_GROUP The EWR #SET_GROUP used for advanced mode
---@field HQ_Template_CC string The ME name of the HQ object
---@field HQ_CC GROUP The #GROUP object of the HQ
---@field SAM_Table table Table of SAM sites
---@field lid string Prefix for logging
---@field Detection DETECTION_AREAS The #DETECTION_AREAS object for EWR
---@field AWACS_Detection DETECTION_AREAS The #DETECTION_AREAS object for AWACS
---@field debug boolean Switch on extra messages
---@field verbose boolean Switch on extra logging
---@field checkradius number Radius of the SAM sites
---@field grouping number Radius to group detected objects
---@field acceptrange number Radius of the EWR detection
---@field detectinterval number Interval in seconds for the target detection
---@field engagerange number Firing engage range of the SAMs, see [https://wiki.hoggitworld.com/view/DCS_option_engagementRange]
---@field autorelocate boolean Relocate HQ and EWR groups in random intervals. Note: You need to select units for this which are *actually mobile*
---@field advanced boolean Use advanced mode, will decrease reactivity of MANTIS, if HQ and/or EWR network dies. Set SAMs to RED state if both are dead. Requires usage of an HQ object
---@field adv_ratio number Percentage to use for advanced mode, defaults to 100%
---@field adv_state number Advanced mode state tracker
---@field advAwacs boolean Boolean switch to use Awacs as a separate detection stream
---@field awacsrange number Detection range of an optional Awacs unit
---@field UseEmOnOff boolean Decide if we are using Emissions on/off (true) or AlarmState red/green (default)
---@field Shorad SHORAD SHORAD Object, if available
---@field ShoradLink boolean If true, #MANTIS has #SHORAD enabled
---@field ShoradTime number Timer in seconds, how long #SHORAD will be active after a detection inside of the defense range
---@field ShoradActDistance number Distance of an attacker in meters from a Mantis SAM site, on which Shorad will be switched on. Useful to not give away Shorad sites too early. Default 15km. Should be smaller than checkradius.
---@field checkforfriendlies boolean If true, do not activate a SAM installation if a friendly aircraft is in firing range.
---@field FilterZones table Table of Core.Zone#ZONE Zones Consider SAM groups in this zone(s) only for this MANTIS instance, must be handed as #table of Zone objects.
---@field SmokeDecoy boolean If true, smoke short range SAM units as decoy if a plane is in firing range.
---@field SmokeDecoyColor number Color to use, defaults to SMOKECOLOR.White.
---@field checkcounter number Counter for SAM Table refreshes.
---@field DLinkCacheTime number Seconds after which cached contacts in DLink will decay.
---@field logsamstatus boolean Log SAM status in dcs.log every cycle if true.
---@field DetectAccoustic boolean Set if we can also detect units accousticly.
---@field DetectAccousticRadius number We can hear in this range.
---@field DetectAccousticCategories table We can hear these categories.
MANTIS = {
  ClassName             = "MANTIS",
  name                  = "mymantis",
  version               = "0.9.45",
  SAM_Templates_Prefix  = "",
  SAM_Group             = nil,
  EWR_Templates_Prefix  = "",
  EWR_Group             = nil,
  Adv_EWR_Group         = nil,
  HQ_Template_CC        = "",
  HQ_CC                 = nil,
  SAM_Table             = {},
  SAM_Table_Long        = {},
  SAM_Table_Medium      = {},
  SAM_Table_Short       = {},
  SAM_Table_PointDef    = {},
  lid                   = "",
  Detection             = nil,
  AWACS_Detection       = nil,
  debug                 = false,
  checkradius           = 25000,
  grouping              = 5000,
  acceptrange           = 80000,
  detectinterval        = 30,
  engagerange           = 95,
  autorelocate          = false,
  advanced              = false,
  adv_ratio             = 100,
  adv_state             = 0,
  AWACS_Prefix          = "",
  advAwacs              = false,
  verbose               = false,
  awacsrange            = 250000,
  Shorad                = nil,
  ShoradLink            = false,
  ShoradTime            = 600,
  ShoradActDistance     = 25000,
  UseEmOnOff            = false,
  TimeStamp             = 0,
  state2flag            = false,
  SamStateTracker       = {},
  DLink                 = false,
  DLTimeStamp           = 0,
  Padding               = 10,
  SuppressedGroups      = {},
  automode              = true,
  autoshorad            = true,
  ShoradGroupSet        = nil,
  checkforfriendlies    = false,
  SmokeDecoy            = false,
  SmokeDecoyColor       = SMOKECOLOR.White,
  checkcounter          = 1,
  DLinkCacheTime        = 120,
  logsamstatus          = false,
  DetectAccoustic       = false,
  DetectAccousticRadius = 2000,
  DetectAccousticCategories = {Unit.Category.HELICOPTER},
  ARMWeaponSeen = {},
  InboundARMs = {},
}

---Advanced state enumerator
---@class MANTIS.AdvancedState
MANTIS.AdvancedState = {
  GREEN = 0,
  AMBER = 1,
  RED = 2,
}

---SAM Type
---@class MANTIS.SamType
MANTIS.SamType = {
  SHORT = "Short",
  MEDIUM = "Medium",
  LONG = "Long",
  POINT = "Point",
}

---SAM Radiusscale
---@class MANTIS.radiusscale
MANTIS.radiusscale = {}

---SAM data
---@class MANTIS.SamData
---@field Range number Max firing range in km
---@field Blindspot number no-firing range (green circle)
---@field Height number Max firing height in km
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
---@field Radar string Radar typename on unit level (used as key)
---@field Point string Point defense capable
---@field ARMCapacity ARMCapacit ie how many (H)ARMs the system can defend at the same time
MANTIS.SamData = {
  ["Hawk"] = { Range=35, Blindspot=0, Height=12, Type="Medium", Radar="Hawk" }, -- measures in km
  ["NASAMS"] = { Range=14, Blindspot=0, Height=7, Type="Short", Radar="NSAMS", ARMCapacity=1 }, -- AIM 120B
  ["Patriot"] = { Range=99, Blindspot=0, Height=25, Type="Long", Radar="Patriot str" },
  ["Rapier"] = { Range=10, Blindspot=0, Height=3, Type="Short", Radar="rapier" },
  ["SA-2"] = { Range=40, Blindspot=7, Height=25, Type="Medium", Radar="S_75M_Volhov" },
  ["SA-3"] = { Range=18, Blindspot=6, Height=18, Type="Short", Radar="5p73 s-125 ln" },
  ["SA-5"] = { Range=250, Blindspot=7, Height=40, Type="Long", Radar="5N62V" },
  ["SA-6"] = { Range=25, Blindspot=0, Height=8, Type="Medium", Radar="1S91" },
  ["SA-10"] = { Range=119, Blindspot=0, Height=18, Type="Long" , Radar="S-300PS 4", ARMCapacity=4},
  ["SA-11"] = { Range=35, Blindspot=0, Height=20, Type="Medium", Radar="SA-11" },
  ["Roland"] = { Range=6, Blindspot=0, Height=5, Type="Short", Radar="Roland", ARMCapacity=1 },
  ["Gepard"] = { Range=5, Blindspot=0, Height=4, Type="Point", Radar="Gepard" },
  ["HQ-7"] = { Range=12, Blindspot=0, Height=3, Type="Short", Radar="HQ-7" },
  ["SA-9"] = { Range=4, Blindspot=0, Height=3, Type="Point", Radar="Strela", Point="true" },
  ["SA-8"] = { Range=10, Blindspot=0, Height=5, Type="Short", Radar="Osa 9A33" },
  ["SA-19"] = { Range=8, Blindspot=0, Height=3, Type="Short", Radar="Tunguska" },
  ["SA-15"] = { Range=11, Blindspot=0, Height=6, Type="Point", Radar="Tor 9A331", Point="true", ARMCapacity=2 },
  ["SA-13"] = { Range=5, Blindspot=0, Height=3, Type="Point", Radar="Strela", Point="true" },
  ["Avenger"] = { Range=4, Blindspot=0, Height=3, Type="Short", Radar="Avenger" },
  ["Chaparral"] = { Range=8, Blindspot=0, Height=3, Type="Short", Radar="Chaparral" },
  ["Linebacker"] = { Range=4, Blindspot=0, Height=3, Type="Point", Radar="Linebacker", Point="true" },
  ["Silkworm"] = { Range=90, Blindspot=1, Height=0.2, Type="Long", Radar="Silkworm" },
  ["C-RAM"] = { Range=2, Blindspot=0, Height=2, Type="Point", Radar="HEMTT_C-RAM_Phalanx", Point="true" },
  ["SA-10B"] = { Range=75, Blindspot=0, Height=18, Type="Medium" , Radar="SA-10B", ARMCapacity=4},
  ["SA-17"] = { Range=50, Blindspot=3, Height=50, Type="Medium", Radar="SA-17", ARMCapacity=4 },
  ["SA-20A"] = { Range=150, Blindspot=5, Height=27, Type="Long" , Radar="S-300PMU1", ARMCapacity=16},
  ["SA-20B"] = { Range=200, Blindspot=4, Height=27, Type="Long" , Radar="S-300PMU2", ARMCapacity=18},
  ["S-300VM"] = { Range=200, Blindspot=5, Height=30, Type="Long" , Radar="9S32ME", ARMCapacity=4},  -- SA-23 Gladiator/Giant
  ["S-300V4"] = { Range=380, Blindspot=5, Height=30, Type="Long" , Radar="9S32M-1E", ARMCapacity=4},  -- SA-23B
  ["S-400"] = { Range=380, Blindspot=5, Height=30, Type="Long" , Radar="92N6E", ARMCapacity=4},  -- SA-21 Growler
  ["HQ-2"] = { Range=50, Blindspot=6, Height=35, Type="Medium", Radar="HQ_2_Guideline_LN" },
  ["TAMIR IDFA"] = { Range=20, Blindspot=0.6, Height=12.3, Type="Short", Radar="IRON_DOME_LN" },
  ["STUNNER IDFA"] = { Range=250, Blindspot=1, Height=45, Type="Long", Radar="DAVID_SLING_LN" },
  ["Nike"] = { Range=155, Blindspot=6, Height=30, Type="Long", Radar="HIPAR" },
  ["Dog Ear"] = { Range=11, Blindspot=0, Height=9, Type="Point", Radar="Dog Ear", Point="true" },
  ["Pantsir S1"] = { Range=20, Blindspot=1.2, Height=15, Type="Point", Radar="PantsirS1" , Point="true", ARMCapacity=3 }, 
  ["Tor M2"] = { Range=12, Blindspot=1, Height=10, Type="Point", Radar="TorM2", Point="true", ARMCapacity=4  },
  ["IRIS-T SLM"] = { Range=40, Blindspot=0.5, Height=20, Type="Medium", Radar="CH_IRIST_SLM", ARMCapacity=12  }, -- 4 per starter, usually 3 starters in a battery
  ["SON-9"] = { Range=20, Blindspot=0, Height=14, Type="Point", Radar="SON_9", Point="true" }, -- Fire Can FCR for S-60/KS-19 AAA
  ["HQ-11"] = { Range=30, Blindspot=2, Height=15, Type="Medium", Radar="HQ11_USLANTCOM", ARMCapacity=4 }, -- FM-3000: missile D_min 2km / Range_max 30km / H_max 15km, 8 rails, 60km search radar
  ["Mistral Unimog"] = { Range=5, Blindspot=0.6, Height=3, Type="Point", Radar="USLANTCOM_UNIMOG_MISTRAL_CL", Point="true" }, -- IR only, no radar: unaffected by emissions on/off
}

---SAM data HDS
---@class MANTIS.SamDataHDS
---@field Range number Max firing range in km
---@field Blindspot number no-firing range (green circle)
---@field Height number Max firing height in km
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
---@field Radar string Radar typename on unit level (used as key)
---@field Point string Point defense capable
MANTIS.SamDataHDS = {
  ["SA-2 HDS"] = { Range=56, Blindspot=7, Height=30, Type="Medium", Radar="V759" }, 
  ["SA-3 HDS"] = { Range=20, Blindspot=6, Height=30, Type="Short", Radar="V-601P" },  
  ["SA-10B HDS"] = { Range=90, Blindspot=5, Height=25, Type="Long" , Radar="5P85CE ln", ARMCapacity=8}, -- V55RUD
  ["SA-10C HDS"] = { Range=75, Blindspot=5, Height=25, Type="Long" , Radar="5P85SE ln", ARMCapacity=3}, -- V55RUD
  ["SA-17 HDS"] = { Range=50, Blindspot=3, Height=50, Type="Medium", Radar="SA-17", ARMCapacity=4 },
  ["SA-12 HDS"] = { Range=100, Blindspot=6, Height=30, Type="Long" , Radar="S-300V 9A82 l", ARMCapacity=12},
  ["SA-23 HDS"] = { Range=200, Blindspot=1, Height=50, Type="Long", Radar="S-300VM 9A82ME", ARMCapacity=14 },
  ["HQ-2 HDS"] = { Range=50, Blindspot=6, Height=35, Type="Medium", Radar="HQ_2_Guideline_LN" },
  ["SAMPT Block 1 HDS"] = { Range=120, Blindspot=1, Height=20, Type="long", Radar="SAMPT_MLT_Blk1" }, -- Block 1 Launcher
  ["SAMPT Block 1INT HDS"] = { Range=150, Blindspot=1, Height=25, Type="long", Radar="SAMPT_MLT_Blk1NT" }, -- Block 1-INT Launcher
  ["SAMPT Block 2 HDS"] = { Range=200, Blindspot=10, Height=70, Type="long", Radar="SAMPT_MLT_Blk2" }, -- Block 2 Launcher
}

---SAM data SMA
---@class MANTIS.SamDataSMA
---@field Range number Max firing range in km
---@field Blindspot number no-firing range (green circle)
---@field Height number Max firing height in km
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
---@field Radar string Radar typename on unit level (used as key)
---@field Point string Point defense capable
MANTIS.SamDataSMA = {
   ["RBS98M SMA"] = { Range=20, Blindspot=0.2, Height=8, Type="Short", Radar="RBS-98" },
   ["RBS70 SMA"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="RBS-70" },  
   ["RBS70M SMA"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="BV410_RBS70" }, 
   ["RBS90 SMA"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="RBS-90" }, 
   ["RBS90M SMA"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="BV410_RBS90" },  
   ["RBS103A SMA"] = { Range=160, Blindspot=1, Height=36, Type="Long", Radar="LvS-103_Lavett103_Rb103A" },
   ["RBS103B SMA"] = { Range=120, Blindspot=3, Height=24.5, Type="Long", Radar="LvS-103_Lavett103_Rb103B" }, 
   ["RBS103AM SMA"] = { Range=160, Blindspot=1, Height=36, Type="Long", Radar="LvS-103_Lavett103_HX_Rb103A" },
   ["RBS103BM SMA"] = { Range=120, Blindspot=3, Height=24.5, Type="Long", Radar="LvS-103_Lavett103_HX_Rb103B" },
   ["Lvkv9040M SMA"] = { Range=2, Blindspot=0.1, Height=1.2, Type="Point", Radar="LvKv9040",Point="true" },   
}

---SAM data CH
---@class MANTIS.SamDataCH
---@field Range number Max firing range in km
---@field Blindspot number no-firing range (green circle)
---@field Height number Max firing height in km
---@field Type string #MANTIS.SamType of SAM, i.e. SHORT, MEDIUM or LONG (range)
---@field Radar string Radar typename on unit level (used as key)
---@field Point string Point defense capable
MANTIS.SamDataCH = {
   ["2S38 CHM"] = { Range=6, Blindspot=0.1, Height=4.5, Type="Short", Radar="2S38" },
   ["PantsirS1 CHM"] = { Range=20, Blindspot=1.2, Height=15, Type="Point", Radar="PantsirS1", Point="true", ARMCapacity=3 }, 
   ["PantsirS2 CHM"] = { Range=30, Blindspot=1.2, Height=18, Type="Medium", Radar="PantsirS2", ARMCapacity=4 }, 
   ["PGL-625 CHM"] = { Range=10, Blindspot=1, Height=5, Type="Short", Radar="PGL_625" }, 
   ["HQ-17A CHM"] = { Range=15, Blindspot=1.5, Height=10, Type="Short", Radar="HQ17A" }, 
   ["M903PAC2 CHM"] = { Range=120, Blindspot=3, Height=24.5, Type="Long", Radar="MIM104_M903_PAC2" },
   ["M903PAC3 CHM"] = { Range=160, Blindspot=1, Height=40, Type="Long", Radar="MIM104_M903_PAC3" }, 
   ["TorM2 CHM"] = { Range=12, Blindspot=1, Height=10, Type="Point", Radar="TorM2", Point="true", ARMCapacity=3  },
   ["TorM2K CHM"] = { Range=12, Blindspot=1, Height=10, Type="Point", Radar="TorM2K", Point="true", ARMCapacity=4  },
   ["TorM2M CHM"] = { Range=16, Blindspot=1, Height=10, Type="Point", Radar="TorM2M", Point="true", ARMCapacity=4  }, 
   ["NASAMS3-AMRAAMER CHM"] = { Range=50, Blindspot=2, Height=35.7, Type="Medium", Radar="CH_NASAMS3_LN_AMRAAM_ER" }, 
   ["NASAMS3-AIM9X2 CHM"] = { Range=20, Blindspot=0.2, Height=18, Type="Short", Radar="CH_NASAMS3_LN_AIM9X2" },
   ["C-RAM CHM"] = { Range=2, Blindspot=0, Height=2, Type="Point", Radar="CH_Centurion_C_RAM", Point="true" }, 
   ["PGZ-09 CHM"] = { Range=4, Blindspot=0.5, Height=3, Type="Point", Radar="CH_PGZ09", Point="true" },
   ["S350-9M100 CHM"] = { Range=15, Blindspot=1, Height=8, Type="Short", Radar="CH_S350_50P6_9M100", ARMCapacity=20 },
   ["S350-9M96D CHM"] = { Range=150, Blindspot=2.5, Height=30, Type="Long", Radar="CH_S350_50P6_9M96D", ARMCapacity=20 },
   ["LAV-AD CHM"] = { Range=8, Blindspot=0.16, Height=4.8, Type="Short", Radar="CH_LAVAD" }, 
   ["HQ-22 CHM"] = { Range=170, Blindspot=5, Height=27, Type="Long", Radar="CH_HQ22_LN" }, 
   ["PGZ-95 CHM"] = { Range=2.5, Blindspot=0.5, Height=2, Type="Point", Radar="CH_PGZ95",Point="true" },
   ["LD-3000 CHM"] = { Range=2.5, Blindspot=0.1, Height=3, Type="Point", Radar="CH_LD3000_stationary", Point="true" }, 
   ["LD-3000M CHM"] = { Range=2.5, Blindspot=0.1, Height=3, Type="Point", Radar="CH_LD3000", Point="true" },  
   ["FlaRakRad CHM"] = { Range=8, Blindspot=1.5, Height=6, Type="Short", Radar="CH_FlaRakRad" },  
   ["IRIS-T SLM CHM"] = { Range=40, Blindspot=0.5, Height=20, Type="Medium", Radar="CH_IRIST_SLM" }, 
   ["M903PAC2KAT1 CHM"] = { Range=120, Blindspot=3, Height=24.5, Type="Long", Radar="CH_MIM104_M903_PAC2_KAT1" }, 
   ["Skynex CHM"] = { Range=3.5, Blindspot=0.1, Height=3.5, Type="Point", Radar="CH_SkynexHX", Point="true" },
   ["Skyshield CHM"] = { Range=3.5, Blindspot=0.1, Height=3.5, Type="Point", Radar="CH_Skyshield_Gun", Point="true" },
   ["WieselOzelot CHM"] = { Range=8, Blindspot=0.16, Height=4.8, Type="Short", Radar="CH_Wiesel2Ozelot" }, 
   ["BukM3-9M317M CHM"] = { Range=70, Blindspot=0.25, Height=35, Type="Medium", Radar="CH_BukM3_9A317M", ARMCapacity=20 },  
   ["BukM3-9M317MA CHM"] = { Range=70, Blindspot=0.25, Height=35, Type="Medium", Radar="CH_BukM3_9A317MA",  ARMCapacity=20 },  
   ["SkySabre CHM"] = { Range=30, Blindspot=0.5, Height=10, Type="Medium", Radar="CH_SkySabreLN" },  
   ["Stormer CHM"] = { Range=7.5, Blindspot=0.3, Height=7, Type="Short", Radar="CH_StormerHVM" },  
   ["THAAD CHM"] = { Range=200, Blindspot=40, Height=150, Type="Long", Radar="CH_THAAD_M1120" },  
   ["USInfantryFIM92K CHM"] = { Range=8, Blindspot=0.16, Height=4.8, Type="Short", Radar="CH_USInfantry_FIM92" },
   ["RBS98M CHM"] = { Range=20, Blindspot=0.2, Height=8, Type="Short", Radar="RBS-98" },
   ["RBS70 CHM"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="RBS-70" },  
   ["RBS70M CHM"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="BV410_RBS70" }, 
   ["RBS90 CHM"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="RBS-90" }, 
   ["RBS90M CHM"] = { Range=8, Blindspot=0.25, Height=6, Type="Short", Radar="BV410_RBS90" },  
   ["RBS103A CHM"] = { Range=160, Blindspot=1, Height=36, Type="Long", Radar="LvS-103_Lavett103_Rb103A" },
   ["RBS103B CHM"] = { Range=120, Blindspot=3, Height=24.5, Type="Long", Radar="LvS-103_Lavett103_Rb103B" }, 
   ["RBS103AM CHM"] = { Range=160, Blindspot=1, Height=36, Type="Long", Radar="LvS-103_Lavett103_HX_Rb103A" },
   ["RBS103BM CHM"] = { Range=120, Blindspot=3, Height=24.5, Type="Long", Radar="LvS-103_Lavett103_HX_Rb103B" },
   ["Lvkv9040M CHM"] = { Range=2, Blindspot=0.1, Height=1.2, Type="Point", Radar="LvKv9040",Point="true" },   
}

---@class MANTIS.SamDataNaval
MANTIS.SamDataNaval = {
  ["Ticonderoga"]        = { Range=150, Blindspot=4, Height=33, Type="Long",   Radar="CH_Ticonderoga" },
  ["Ticonderoga CMP"]    = { Range=150, Blindspot=4, Height=33, Type="Long",   Radar="CH_Ticonderoga_CMP" },
  ["Arleigh Burke IIA"]  = { Range=150, Blindspot=4, Height=33, Type="Long",   Radar="CH_Arleigh_Burke_IIA" },
  ["Arleigh Burke III"]  = { Range=180, Blindspot=3, Height=33, Type="Long",   Radar="CH_Arleigh_Burke_III" },
  ["Constellation"]      = { Range=120, Blindspot=3, Height=27, Type="Long",   Radar="CH_Constellation" },

  ["Type 45"]            = { Range=120, Blindspot=3, Height=30, Type="Long",   Radar="Type45" },            -- Aster 15/30, SAMPSON
  ["Type 26"]            = { Range=25,  Blindspot=1, Height=10, Type="Medium", Radar="CH_Type26" },          -- Sea Ceptor / CAMM

  ["F124 Sachsen"]       = { Range=120, Blindspot=3, Height=24, Type="Long",   Radar="CH_F124" },            -- SM-2/ESSM, APAR (X-band)

  ["Type 052D"]          = { Range=100, Blindspot=5, Height=27, Type="Long",   Radar="Type052D" },           -- HHQ-9
  ["Type 055"]           = { Range=150, Blindspot=5, Height=30, Type="Long",   Radar="Type055" },            -- HHQ-9B
  ["Type 054B"]          = { Range=70,  Blindspot=2, Height=20, Type="Medium", Radar="CH_Type054B" },         -- HHQ-16
  ["Type 056A"]          = { Range=9,   Blindspot=0.3, Height=6, Type="Point", Radar="CH_Type056A", Point="true" }, -- HHQ-10 (IR)

  ["Admiral Gorshkov"]   = { Range=150, Blindspot=3, Height=30, Type="Long",   Radar="CH_Admiral_Gorshkov" }, -- Poliment-Redut 9M96D
  ["Grigorovich AShM"]   = { Range=50,  Blindspot=2, Height=15, Type="Medium", Radar="CH_Grigorovich_AShM" }, -- Shtil-1
  ["Grigorovich LACM"]   = { Range=50,  Blindspot=2, Height=15, Type="Medium", Radar="CH_Grigorovich_LACM" },
  ["Steregushchiy"]      = { Range=50,  Blindspot=1.5, Height=20, Type="Medium", Radar="CH_Steregushchiy" },  -- Redut 9M96
  ["Gremyashchiy AShM"]  = { Range=50,  Blindspot=1.5, Height=20, Type="Medium", Radar="CH_Gremyashchiy_AShM" },
  ["Gremyashchiy LACM"]  = { Range=50,  Blindspot=1.5, Height=20, Type="Medium", Radar="CH_Gremyashchiy_LACM" },
  ["Karakurt AShM"]      = { Range=20,  Blindspot=1, Height=15, Type="Point",  Radar="CH_Karakurt_AShM", Point="true" }, -- Pantsir-M
  ["Karakurt LACM"]      = { Range=20,  Blindspot=1, Height=15, Type="Point",  Radar="CH_Karakurt_LACM", Point="true" },

  ["Type 022 FAC"]       = { Range=5,   Blindspot=0.2, Height=4, Type="Point", Radar="CH_Type022", Point="true" },
  ["IRGCN FAC AShM"]     = { Range=5,   Blindspot=0.2, Height=4, Type="Point", Radar="CH_IranFAC_MG", Point="true" },       -- MANPADS
  ["IRGCN FAC Igla"]     = { Range=5,   Blindspot=0.2, Height=4, Type="Point", Radar="CH_IranFAC_MG_AShM", Point="true" },  -- Igla
  ["Strb 90 FAC"]        = { Range=4,   Blindspot=0.2, Height=3, Type="Point", Radar="Strb90", Point="true" },
  ["Visby"]              = { Range=4,   Blindspot=0.2, Height=3, Type="Point", Radar="HSwMS_Visby", Point="true" },         -- gun/CIWS

  ["CG Ticonderoga"]        = { Range=120, Blindspot=3, Height=30, Type="Long",   Radar="TICONDEROG" },  -- SM-2/SPY-1  NOTE: id has NO trailing 'E'
  ["DDG Arleigh Burke IIa"] = { Range=120, Blindspot=3, Height=30, Type="Long",   Radar="USS_Arleigh_Burke_IIa" }, -- SM-2/SPY-1D
  ["FFG Perry"]             = { Range=38,  Blindspot=2, Height=15, Type="Medium", Radar="PERRY" },        -- SM-1MR (est. real range)
  ["CVN Roosevelt"]         = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="CVN_71", Point="true" }, -- NSSM/RAM
  ["CVN Lincoln"]           = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="CVN_72", Point="true" },
  ["CVN Washington"]        = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="CVN_73", Point="true" },
  ["CVN Stennis"]           = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="Stennis", Point="true" },
  ["CVN Truman"]            = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="CVN_75", Point="true" },
  ["CVN Vinson"]            = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="VINSON", Point="true" },
  ["LHA Tarawa"]            = { Range=15,  Blindspot=1, Height=8,  Type="Point",  Radar="LHA_Tarawa", Point="true" }, -- RAM/Sea Sparrow
  ["Cruiser Moskva"]        = { Range=75,  Blindspot=5, Height=25, Type="Long",   Radar="MOSCOW" },       -- S-300F (SA-N-6)
  ["BC Pyotr Velikiy"]      = { Range=150, Blindspot=5, Height=27, Type="Long",   Radar="PIOTR" },        -- S-300F/FM
  ["Frigate Neustrashimy"]  = { Range=12,  Blindspot=1, Height=6,  Type="Short",  Radar="NEUSTRASH" },    -- Kinzhal (SA-N-9)
  ["Frigate Rezky"]         = { Range=15,  Blindspot=1, Height=5,  Type="Short",  Radar="REZKY" },        -- OSA-M (SA-N-4)
  ["Corvette Grisha"]       = { Range=15,  Blindspot=1, Height=5,  Type="Short",  Radar="ALBATROS" },     -- OSA-M (SA-N-4)
  ["Corvette Molniya"]      = { Range=5,   Blindspot=0.3, Height=3, Type="Point", Radar="MOLNIYA", Point="true" }, -- Strela
  ["CV Kuznetsov"]          = { Range=12,  Blindspot=1, Height=6,  Type="Short",  Radar="KUZNECOW" },     -- Kinzhal/Kashtan
  ["CV Kuznetsov 2017"]     = { Range=12,  Blindspot=1, Height=6,  Type="Short",  Radar="CV_1143_5" },
  ["Patrol Bykov TorM2KM"]  = { Range=15,  Blindspot=1, Height=6,  Type="Short",  Radar="CHAP_Project22160_TorM2KM" }, -- Tor
  ["Patrol Bykov"]          = { Range=7,   Blindspot=0.3, Height=4, Type="Point", Radar="CHAP_Project22160", Point="true" },
  ["Type 052C"]             = { Range=100, Blindspot=5, Height=27, Type="Long",   Radar="Type_052C" },    -- HHQ-9
  ["Type 052B"]             = { Range=30,  Blindspot=2, Height=15, Type="Medium", Radar="Type_052B" },    -- HHQ-16/Shtil
  ["Type 054A"]             = { Range=45,  Blindspot=2, Height=18, Type="Medium", Radar="Type_054A" },    -- HHQ-16
  ["Type 071 LPD"]          = { Range=9,   Blindspot=0.5, Height=6, Type="Point", Radar="Type_071", Point="true" }, -- HHQ-10
  ["HMS Invincible"]        = { Range=40,  Blindspot=2, Height=18, Type="Medium", Radar="hms_invincible" }, -- Sea Dart

  ["HMAS Hobart DDG-39"]       = { Range=100, Blindspot=3, Height=30, Type="Long",  Radar="DDG39" }, -- AEGIS SPY-1D(V), SM-2
  ["F100 Alvaro de Bazan"]     = { Range=100, Blindspot=3, Height=30, Type="Long",  Radar="F100" },  -- AEGIS SPY-1D, SM-2
  ["F105 Cristobal Colon"]     = { Range=100, Blindspot=3, Height=30, Type="Long",  Radar="F105" },  -- AEGIS SPY-1D, SM-2
  ["LHD Canberra L02"]         = { Range=3,   Blindspot=0.1, Height=2, Type="Point", Radar="L02", Point="true" }, -- 3x Phalanx only
  ["LPD Castilla L52"]         = { Range=3,   Blindspot=0.1, Height=2, Type="Point", Radar="L52", Point="true" }, -- 2x Phalanx (NO_SAM attr)
  ["LHD Juan Carlos I L61"]    = { Range=1.5, Blindspot=0.1, Height=0.8, Type="Point", Radar="L61", Point="true" }, -- .50cal mounts only

  ["USS America LHA-6"] = { Range=20, Blindspot=0.4, Height=15, Type="Short", Radar="USS America LHA-6" }, -- Sea Sparrow + RAM + Phalanx

  ["HMS Duncan (Type 45)"]     = { Range=100, Blindspot=3, Height=30, Type="Long",   Radar="HMS Duncan" },             -- Aster/Sea Viper (mod: MK41_SM2)
  ["Aquitaine D650 (FREMM)"]   = { Range=120, Blindspot=3, Height=27, Type="Long",   Radar="Aquitaine D650" },          -- SYLVER Aster 30 (distanceMax 120km)
  ["Normandie D651 (FREMM)"]   = { Range=120, Blindspot=3, Height=27, Type="Long",   Radar="D651_Normandie" },          -- SYLVER Aster 30
  ["MEKO-200HN Hydra"]         = { Range=50,  Blindspot=2, Height=20, Type="Medium", Radar="MEKO_HN" },                 -- MK41 (mod SM-2 / real ESSM)
  ["MEKO-200TN Barbaros"]      = { Range=50,  Blindspot=2, Height=20, Type="Medium", Radar="MEKO_TN" },                 -- MK41 + SeaZenith CIWS
  ["Sovremenny Adm. Ushakov"]  = { Range=46,  Blindspot=2, Height=15, Type="Medium", Radar="Admiral Ushakov" },         -- SA-N-7 Gadfly
  ["Udaloy II Chabanenko"]     = { Range=12,  Blindspot=1, Height=6,  Type="Short",  Radar="Udaloy II DDG Admiral Chabanenko" }, -- SA-N-9 Klinok
  ["USS San Antonio LPD-17"]   = { Range=15,  Blindspot=1, Height=8,  Type="Short",  Radar="USS San Antonio LPD-17" },  -- Sea Sparrow
  ["USS Oak Hill LSD-51"]      = { Range=9,   Blindspot=0.5, Height=6, Type="Point", Radar="USS_Oak_Hill LSD-51", Point="true" }, -- RAM + Phalanx
  ["USS Blue Ridge LCC-19"]    = { Range=3,   Blindspot=0.1, Height=2, Type="Point", Radar="USS_Blue_Ridge", Point="true" },      -- Phalanx only
  ["Sacramento AOE-1"]         = { Range=9,   Blindspot=0.5, Height=6, Type="Point", Radar="USS_Support_Ship_Sacramento_AOE-1", Point="true" }, -- RAM + Phalanx
  ["Henry Kaiser T-AO-187"]    = { Range=1.5, Blindspot=0.1, Height=0.8,Type="Point", Radar="USNS_Henry_Kaiser", Point="true" },  -- .50cal only (negligible)
  ["HMS Albion L14"]           = { Range=3,   Blindspot=0.1, Height=2, Type="Point", Radar="HMS_Albion L14", Point="true" },      -- Phalanx only
  ["LPD Foudre"]               = { Range=6,   Blindspot=0.3, Height=4, Type="Point", Radar="LPD_Foundre", Point="true" },         -- Mistral (IR)
  ["Osa-I Missile Boat"]       = { Range=4,   Blindspot=0.2, Height=3, Type="Point", Radar="OSA_One", Point="true" },             -- AK-230 (NO_SAM)
  ["Osa-II Missile Boat"]      = { Range=4,   Blindspot=0.2, Height=3, Type="Point", Radar="OSA_Two", Point="true" },             -- AK-230
  ["IRIS Alvand"]              = { Range=4,   Blindspot=0.2, Height=3, Type="Point", Radar="IRIS_Alvand", Point="true" },         -- OtoBreda 40mm / 20mm
}

---Jammer Loadout Configurations (v8: Max 3 Pods)
---@class MANTIS.JammerLoadouts
MANTIS.JammerLoadouts = {
  ["1xALQ99"]={name="1x AN/ALQ-99",description="Baseline single pod. Full 64MHz-20GHz spectrum.",mult_LOW=1.12,mult_S=1.10,mult_IJ=1.12,mult_OPT=1.00,bt_mod=1.00,range_mod=1.00,tier="ALQ99"},
  ["2xALQ99"]={name="2x AN/ALQ-99",description="Two pods. Improved ERP with log stacking.",mult_LOW=1.40,mult_S=1.36,mult_IJ=1.40,mult_OPT=1.02,bt_mod=1.00,range_mod=1.03,tier="ALQ99"},
  ["3xALQ99"]={name="3x AN/ALQ-99 (Maximum Legacy)",description="Max legacy barrage. Highest broadband ERP.",mult_LOW=1.58,mult_S=1.52,mult_IJ=1.58,mult_OPT=1.04,bt_mod=1.00,range_mod=1.06,tier="ALQ99"},
  ["1xALQ249"]={name="1x AN/ALQ-249 (AESA)",description="AESA 2-18GHz. High peak+wider window. Blind <2GHz.",mult_LOW=0.15,mult_S=1.82,mult_IJ=1.70,mult_OPT=1.00,bt_mod=1.28,range_mod=1.16,tier="ALQ249"},
  ["2xALQ249"]={name="2x AN/ALQ-249",description="Two AESA pods. Strong S/IJ dominance.",mult_LOW=0.15,mult_S=2.30,mult_IJ=2.15,mult_OPT=1.00,bt_mod=1.38,range_mod=1.26,tier="ALQ249"},
  ["3xALQ249"]={name="3x AN/ALQ-249 (Maximum AESA)",description="Max AESA ERP. Extreme S/IJ. No LOW coverage.",mult_LOW=0.15,mult_S=2.75,mult_IJ=2.58,mult_OPT=1.00,bt_mod=1.48,range_mod=1.35,tier="ALQ249"},
  ["1xALQ99_1xALQ249"]={name="1x ALQ-99 + 1x ALQ-249",description="Balanced coverage. AESA S/IJ + ALQ-99 LOW-band.",mult_LOW=1.14,mult_S=1.90,mult_IJ=1.80,mult_OPT=1.01,bt_mod=1.22,range_mod=1.12,tier="Mixed"},
  ["1xALQ99_2xALQ249"]={name="1x ALQ-99 + 2x ALQ-249 [Recommended]",description="Best all-around. High AESA ERP + LOW coverage.",mult_LOW=1.10,mult_S=2.38,mult_IJ=2.22,mult_OPT=1.01,bt_mod=1.35,range_mod=1.24,tier="Mixed"},
  ["2xALQ99_1xALQ249"]={name="2x ALQ-99 + 1x ALQ-249",description="Strong LOW-band + AESA S/IJ boost.",mult_LOW=1.42,mult_S=2.10,mult_IJ=2.04,mult_OPT=1.03,bt_mod=1.25,range_mod=1.15,tier="Mixed"},
}

---Tiered loadout keys for F10 menu (v8: 3/3/3)
---@class MANTIS.JammerLoadoutTiers
MANTIS.JammerLoadoutTiers = {
  ALQ99  = {"1xALQ99","2xALQ99","3xALQ99"},
  ALQ249 = {"1xALQ249","2xALQ249","3xALQ249"},
  Mixed  = {"1xALQ99_1xALQ249","1xALQ99_2xALQ249","2xALQ99_1xALQ249"},
}

---Jitter configuration: ±10% per evaluation (EW Fundamentals Ch.9)
---@class MANTIS.JammerJitterPercent
MANTIS.JammerJitterPercent = {}

---Jammer SAM Parameters — v9 curves (v8.1) {peak%, mu_nm, sigma_L, tail_dist, band, floor%}
---v9 changes from v8:
---  * Width rework: curves now track radar detection/track envelope (not just missile range)
---  * Long-range systems widened (SA-5, SA-21, SA-23, Nike, PAC-2, S-300/400 family)
---  * Short-range systems tightened (SA-19, SON-9, HQ-7, Rapier)
---  * HAWK widened to match CW illuminator envelope (~90nm)
---floor: residual effectiveness inside burnthrough (now tapers past mu with R^2 falloff)
---  5 = legacy radar, no ECCM | 3 = moderate ECCM | 2 = advanced ECCM/AESA | 0 = optical/IR
---@class MANTIS.JammerSAMParams
MANTIS.JammerSAMParams = {
  ["Nike"]       ={peak=78,mu=55,sigma_L=22,tail_dist=110,band="S",  floor=5},
  ["Hawk"]       ={peak=30,mu=22,sigma_L=9, tail_dist=55, band="IJ", floor=3},
  ["SA-2"]       ={peak=75,mu=40,sigma_L=16,tail_dist=90, band="S",  floor=5},
  ["SA-3"]       ={peak=45,mu=22,sigma_L=10,tail_dist=52, band="IJ", floor=5},
  ["SA-5"]       ={peak=52,mu=75,sigma_L=26,tail_dist=145,band="S",  floor=5},
  ["SA-6"]       ={peak=33,mu=18,sigma_L=8, tail_dist=48, band="IJ", floor=3},
  ["SA-8"]       ={peak=38,mu=10,sigma_L=4, tail_dist=24, band="IJ", floor=3},
  ["SA-9"]       ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["SA-10"]      ={peak=32,mu=50,sigma_L=20,tail_dist=95, band="S",  floor=3},
  ["SA-10B"]     ={peak=30,mu=52,sigma_L=20,tail_dist=100,band="S",  floor=3},
  ["SA-11"]      ={peak=52,mu=28,sigma_L=12,tail_dist=58, band="IJ", floor=3},
  ["SA-13"]      ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["SA-15"]      ={peak=30,mu=11,sigma_L=5, tail_dist=22, band="IJ", floor=3},
  ["SA-17"]      ={peak=24,mu=32,sigma_L=14,tail_dist=68, band="IJ", floor=2},
  ["SA-19"]      ={peak=25,mu=8, sigma_L=3.5,tail_dist=16,band="IJ", floor=2},
  ["SA-20A"]     ={peak=22,mu=65,sigma_L=24,tail_dist=115,band="S",  floor=2},
  ["SA-20B"]     ={peak=20,mu=68,sigma_L=24,tail_dist=120,band="S",  floor=2},
  ["S-300VM"]    ={peak=16,mu=80,sigma_L=30,tail_dist=135,band="S",  floor=2}, -- SA-23 canonical
  ["S-300V4"]    ={peak=14,mu=85,sigma_L=30,tail_dist=145,band="S",  floor=2}, -- SA-23B canonical
  ["S-400"]      ={peak=18,mu=80,sigma_L=30,tail_dist=150,band="S",  floor=2}, -- SA-21 canonical
  ["NASAMS"]     ={peak=25,mu=28,sigma_L=12,tail_dist=52, band="IJ", floor=2},
  ["Patriot"]    ={peak=32,mu=62,sigma_L=24,tail_dist=110,band="S",  floor=3},
  ["Rapier"]     ={peak=12,mu=6, sigma_L=2.5,tail_dist=14,band="IJ", floor=0},
  ["Gepard"]     ={peak=18,mu=6, sigma_L=2, tail_dist=18, band="IJ", floor=0},
  ["Roland"]     ={peak=35,mu=5, sigma_L=2, tail_dist=12, band="IJ", floor=3},
  ["HQ-7"]       ={peak=38,mu=8, sigma_L=3.5,tail_dist=18,band="IJ", floor=3},
  ["HQ-2"]       ={peak=70,mu=38,sigma_L=15,tail_dist=80, band="S",  floor=5},
  ["C-RAM"]      ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["Avenger"]    ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["Chaparral"]  ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["Linebacker"] ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["Silkworm"]   ={peak=35,mu=20,sigma_L=8, tail_dist=40, band="IJ", floor=3},
  ["Dog Ear"]    ={peak=40,mu=10,sigma_L=4, tail_dist=20, band="IJ", floor=5},
  ["Pantsir S1"] ={peak=10,mu=9, sigma_L=4, tail_dist=20, band="IJ", floor=0}, -- SA-22 canonical
  ["Tor M2"]     ={peak=28,mu=14,sigma_L=6, tail_dist=30, band="IJ", floor=3},
  ["IRIS-T SLM"] ={peak=18,mu=22,sigma_L=10,tail_dist=50, band="IJ", floor=2},
  ["SON-9"]      ={peak=48,mu=14,sigma_L=6, tail_dist=30, band="IJ", floor=5},
  ["TAMIR IDFA"]  ={peak=19,mu=25,sigma_L=12,tail_dist=52,band="S",  floor=2},
  ["STUNNER IDFA"]={peak=16,mu=45,sigma_L=18,tail_dist=80,band="S",  floor=2},
  ["SA-10C HDS"]         ={peak=30,mu=50,sigma_L=20,tail_dist=92, band="S",  floor=3},
  ["SA-12 HDS"]          ={peak=35,mu=50,sigma_L=18,tail_dist=90, band="S",  floor=3},
  ["SAMPT Block 1 HDS"]  ={peak=28,mu=45,sigma_L=18,tail_dist=85, band="S",  floor=3},
  ["SAMPT Block 1INT HDS"]={peak=26,mu=48,sigma_L=18,tail_dist=88,band="S",  floor=3},
  ["SAMPT Block 2 HDS"]  ={peak=22,mu=52,sigma_L=20,tail_dist=92, band="S",  floor=2},
  ["RBS70 SMA"]    ={peak=5, mu=4, sigma_L=2, tail_dist=10,band="OPT",floor=0},  -- canonical for RBS70 family
  ["RBS90 SMA"]    ={peak=5, mu=4, sigma_L=2, tail_dist=10,band="OPT",floor=0},  -- canonical for RBS90 family
  ["RBS98M SMA"]   ={peak=25,mu=12,sigma_L=5, tail_dist=25,band="IJ", floor=3},  -- canonical
  ["RBS103A SMA"]  ={peak=20,mu=55,sigma_L=20,tail_dist=90,band="S",  floor=2},  -- canonical
  ["RBS103B SMA"]  ={peak=22,mu=45,sigma_L=18,tail_dist=80,band="S",  floor=2},  -- canonical
  ["Lvkv9040M SMA"]={peak=15,mu=3, sigma_L=1, tail_dist=8, band="OPT",floor=0},  -- canonical
  ["2S38 CHM"]             ={peak=8, mu=3, sigma_L=1, tail_dist=8,  band="OPT",floor=0},
  ["PGL-625 CHM"]          ={peak=12,mu=6, sigma_L=2.5,tail_dist=14,band="OPT",floor=0}, -- Type-08
  ["HQ-17A CHM"]           ={peak=30,mu=11,sigma_L=5, tail_dist=24, band="IJ", floor=3},
  ["M903PAC3 CHM"]         ={peak=15,mu=58,sigma_L=22,tail_dist=105,band="S",  floor=2},
  ["TorM2M CHM"]           ={peak=26,mu=16,sigma_L=6, tail_dist=32, band="IJ", floor=3}, -- variant
  ["NASAMS3-AMRAAMER CHM"] ={peak=20,mu=35,sigma_L=14,tail_dist=65, band="IJ", floor=2},
  ["NASAMS3-AIM9X2 CHM"]   ={peak=10,mu=15,sigma_L=6, tail_dist=30, band="IJ", floor=0},
  ["PGZ-09 CHM"]           ={peak=22,mu=5, sigma_L=2, tail_dist=14, band="IJ", floor=0}, -- Type-09
  ["PGZ-95 CHM"]           ={peak=15,mu=4, sigma_L=2, tail_dist=10, band="OPT",floor=0},
  ["S350-9M100 CHM"]       ={peak=18,mu=35,sigma_L=15,tail_dist=78, band="IJ", floor=2}, -- SA-28 canonical
  ["HQ-22 CHM"]            ={peak=20,mu=70,sigma_L=26,tail_dist=120,band="S",  floor=2},
  ["IRIS-T SLM CHM"]       ={peak=18,mu=22,sigma_L=10,tail_dist=50, band="IJ", floor=2}, -- will be aliased
  ["Skynex CHM"]           ={peak=12,mu=4, sigma_L=2, tail_dist=10, band="OPT",floor=0},
  ["Skyshield CHM"]        ={peak=12,mu=4, sigma_L=2, tail_dist=10, band="OPT",floor=0},
  ["BukM3-9M317M CHM"]     ={peak=22,mu=38,sigma_L=16,tail_dist=75, band="IJ", floor=2}, -- SA-27 canonical
  ["SkySabre CHM"]         ={peak=18,mu=18,sigma_L=7, tail_dist=40, band="IJ", floor=2},
  ["Stormer CHM"]          ={peak=10,mu=5, sigma_L=2, tail_dist=12, band="OPT",floor=0},
  ["THAAD CHM"]            ={peak=10,mu=90,sigma_L=38,tail_dist=140,band="IJ", floor=0},
  ["WieselOzelot CHM"]     ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["USInfantryFIM92K CHM"] ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
  ["HQ-11"]                ={peak=16,mu=23,sigma_L=10,tail_dist=50, band="IJ", floor=2},
  ["Mistral Unimog"]       ={peak=3, mu=3, sigma_L=1, tail_dist=5,  band="OPT",floor=0},
}

---@class MANTIS.JammerSAMParamsNaval
MANTIS.JammerSAMParamsNaval = {
  ["CH_Ticonderoga"]        = { peak=17, mu=70, sigma_L=24, tail_dist=115, band="S",  floor=2 },
  ["CH_Ticonderoga_CMP"]    = { peak=17, mu=70, sigma_L=24, tail_dist=115, band="S",  floor=2 },
  ["CH_Arleigh_Burke_IIA"]  = { peak=17, mu=70, sigma_L=24, tail_dist=115, band="S",  floor=2 },
  ["CH_Arleigh_Burke_III"]  = { peak=14, mu=83, sigma_L=28, tail_dist=130, band="S",  floor=2 }, -- SPY-6 AESA
  ["CH_Constellation"]      = { peak=14, mu=63, sigma_L=22, tail_dist=100, band="S",  floor=2 }, -- SPY-6(V)3
  ["Type45"]                = { peak=16, mu=62, sigma_L=24, tail_dist=110, band="S",  floor=2 }, -- SAMPSON
  ["CH_Type26"]             = { peak=18, mu=18, sigma_L=7,  tail_dist=40,  band="IJ", floor=2 }, -- CAMM active RH
  ["CH_F124"]               = { peak=18, mu=62, sigma_L=24, tail_dist=110, band="IJ", floor=2 }, -- APAR X-band
  ["Type052D"]              = { peak=20, mu=55, sigma_L=22, tail_dist=110, band="S",  floor=2 },
  ["Type055"]               = { peak=16, mu=65, sigma_L=24, tail_dist=120, band="S",  floor=2 },
  ["CH_Type054B"]           = { peak=22, mu=38, sigma_L=16, tail_dist=75,  band="S",  floor=3 },
  ["CH_Type056A"]           = { peak=8,  mu=5,  sigma_L=2,  tail_dist=12,  band="OPT",floor=0 }, -- HHQ-10 IR
  ["CH_Admiral_Gorshkov"]   = { peak=16, mu=80, sigma_L=30, tail_dist=145, band="S",  floor=2 }, -- Poliment AESA
  ["CH_Grigorovich_AShM"]   = { peak=50, mu=28, sigma_L=12, tail_dist=58,  band="IJ", floor=3 }, -- Shtil-1
  ["CH_Grigorovich_LACM"]   = { peak=50, mu=28, sigma_L=12, tail_dist=58,  band="IJ", floor=3 },
  ["CH_Steregushchiy"]      = { peak=22, mu=35, sigma_L=15, tail_dist=70,  band="S",  floor=2 }, -- Redut
  ["CH_Gremyashchiy_AShM"]  = { peak=22, mu=35, sigma_L=15, tail_dist=70,  band="S",  floor=2 },
  ["CH_Gremyashchiy_LACM"]  = { peak=22, mu=35, sigma_L=15, tail_dist=70,  band="S",  floor=2 },
  ["CH_Karakurt_AShM"]      = { peak=10, mu=9,  sigma_L=4,  tail_dist=20,  band="IJ", floor=0 }, -- Pantsir-M
  ["CH_Karakurt_LACM"]      = { peak=10, mu=9,  sigma_L=4,  tail_dist=20,  band="IJ", floor=0 },
  ["CH_Type022"]            = { peak=3,  mu=3,  sigma_L=1,  tail_dist=5,   band="OPT",floor=0 },
  ["CH_IranFAC_MG"]         = { peak=3,  mu=3,  sigma_L=1,  tail_dist=5,   band="OPT",floor=0 },
  ["CH_IranFAC_MG_AShM"]    = { peak=3,  mu=3,  sigma_L=1,  tail_dist=5,   band="OPT",floor=0 },
  ["Strb90"]                = { peak=3,  mu=3,  sigma_L=1,  tail_dist=5,   band="OPT",floor=0 },
  ["HSwMS_Visby"]           = { peak=3,  mu=3,  sigma_L=1,  tail_dist=5,   band="OPT",floor=0 }, -- gun/CIWS: unjammable

  ["TICONDEROG"]            = { peak=17, mu=60, sigma_L=22, tail_dist=110, band="S",  floor=2 }, -- SPY-1  (NO trailing E)
  ["USS_Arleigh_Burke_IIa"] = { peak=17, mu=60, sigma_L=22, tail_dist=110, band="S",  floor=2 }, -- SPY-1D
  ["PERRY"]                 = { peak=33, mu=20, sigma_L=9,  tail_dist=48,  band="IJ", floor=3 }, -- SM-1 / SPG-51 (X-band illum)
  ["MOSCOW"]                = { peak=32, mu=42, sigma_L=18, tail_dist=90,  band="S",  floor=3 }, -- S-300F
  ["PIOTR"]                 = { peak=28, mu=70, sigma_L=26, tail_dist=130, band="S",  floor=3 }, -- S-300F/FM
  ["NEUSTRASH"]             = { peak=28, mu=8,  sigma_L=3.5,tail_dist=18,  band="IJ", floor=2 }, -- Kinzhal
  ["REZKY"]                 = { peak=35, mu=8,  sigma_L=3.5,tail_dist=18,  band="IJ", floor=3 }, -- OSA-M
  ["MOLNIYA"]               = { peak=3,  mu=3,  sigma_L=1,  tail_dist=5,   band="OPT",floor=0 }, -- Strela
  ["KUZNECOW"]              = { peak=24, mu=8,  sigma_L=3.5,tail_dist=18,  band="IJ", floor=2 }, -- Kinzhal/Kashtan
  ["CHAP_Project22160_TorM2KM"] = { peak=28, mu=12, sigma_L=5, tail_dist=28, band="IJ", floor=3 }, -- Tor M2KM
  ["Type_052C"]             = { peak=20, mu=55, sigma_L=22, tail_dist=110, band="S",  floor=2 }, -- HHQ-9
  ["Type_052B"]             = { peak=30, mu=20, sigma_L=10, tail_dist=48,  band="S",  floor=3 }, -- HHQ-16/Shtil
  ["Type_054A"]             = { peak=26, mu=28, sigma_L=12, tail_dist=58,  band="S",  floor=3 }, -- HHQ-16
  ["hms_invincible"]        = { peak=36, mu=25, sigma_L=11, tail_dist=52,  band="IJ", floor=3 }, -- Sea Dart / Type 909
  ["CVN_71"]                = { peak=8,  mu=5,  sigma_L=2,  tail_dist=12,  band="OPT",floor=0 }, -- NSSM/RAM (carrier point)

  ["USS America LHA-6"] = { peak=22, mu=11, sigma_L=5, tail_dist=25, band="IJ", floor=3 },
  ["DDG39"]                             = { peak=17, mu=55, sigma_L=22, tail_dist=110, band="S", floor=2 }, -- SPY-1D(V)
  ["F100"]                              = { peak=17, mu=55, sigma_L=22, tail_dist=110, band="S", floor=2 }, -- SPY-1D
  ["F105"]                              = { peak=17, mu=55, sigma_L=22, tail_dist=110, band="S", floor=2 }, -- SPY-1D
  ["HMS Duncan"]                        = { peak=16, mu=54, sigma_L=22, tail_dist=110, band="S",  floor=2 }, -- Aster (ECM_K 0.65)
  ["Aquitaine D650"]                    = { peak=16, mu=65, sigma_L=24, tail_dist=120, band="S",  floor=2 }, -- Aster 30 (mod ECM_K 5.0 - see note)
  ["D651_Normandie"]                    = { peak=16, mu=65, sigma_L=24, tail_dist=120, band="S",  floor=2 }, -- Aster 30
  ["MEKO_HN"]                           = { peak=22, mu=27, sigma_L=12, tail_dist=55,  band="IJ", floor=2 }, -- ESSM/SM-2
  ["MEKO_TN"]                           = { peak=22, mu=27, sigma_L=12, tail_dist=55,  band="IJ", floor=2 },
  ["Admiral Ushakov"]                   = { peak=48, mu=25, sigma_L=11, tail_dist=55,  band="IJ", floor=3 }, -- SA-N-7 Gadfly
  ["Udaloy II DDG Admiral Chabanenko"]  = { peak=28, mu=7,  sigma_L=3,  tail_dist=18,  band="IJ", floor=3 }, -- SA-N-9 Klinok
  ["USS San Antonio LPD-17"]            = { peak=22, mu=8,  sigma_L=4,  tail_dist=20,  band="IJ", floor=3 }, -- Sea Sparrow
  ["LPD_Foundre"]                       = { peak=10, mu=3,  sigma_L=2,  tail_dist=10,  band="OPT",floor=0 }, -- Mistral (IR, near-unjammable)
}

---Function to instantiate a new object of class MANTIS
---@param name? string Name of this MANTIS for reporting
---@param samprefix? string Prefixes for the SAM groups from the ME, e.g. all groups starting with "Red Sam..."
---@param ewrprefix? string Prefixes for the EWR groups from the ME, e.g. all groups starting with "Red EWR..."
---@param hq? string Group name of your HQ (optional)
---@param Coalition? string Coalition side of your setup, e.g. "blue", "red" or "neutral"
---@param dynamic? boolean Use constant (true) filtering or just filter once (false, default) (optional)
---@param awacs? string Group name of your Awacs (optional)
---@param EmOnOff? boolean Make MANTIS switch Emissions on and off instead of changing the alarm state between RED and GREEN (optional)
---@param Padding? number For #SEAD - Extra number of seconds to add to radar switch-back-on time (optional)
---@param Zones? table Table of Core.Zone#ZONE Zones Consider SAM groups in this zone(s) only for this MANTIS instance, must be handed as #table of Zone objects
---@return MANTIS # self
function MANTIS:New(name, samprefix, ewrprefix, hq, Coalition, dynamic, awacs, EmOnOff, Padding, Zones) end

---Set to accept accoustic detection. Set this *before* MANTIS starts!
---@param Radius? number (Optional) Radius in which we can "hear" units. Defaults to 2000 meters.
---@param UnitCategories? any (Optional) Set what Unit Categories we can "hear". Defaults to `{Unit.Category.HELICOPTER}`
---@param PlayersOnly? boolean (Optional) Detect only players in the allowed unit categories. Defaults to false.
---@param PlayerSnapshotProvider? function (Optional) Function receiving the opposing coalition and returning `{rows={{unit=nativeUnit,category=unitCategory,point=vec3},...}}` for its players. Without a provider, use coalition.getPlayers.
---@return MANTIS # self
function MANTIS:SetAccousticDetectionOn(Radius, UnitCategories, PlayersOnly, PlayerSnapshotProvider) end

---Switch off accoustic detection.
---@return MANTIS # self
function MANTIS:SetAccousticDetectionOff() end

---[Internal] Function to manage hits on SAM units
---@param EventData? EVENTDATA The EVENT data
---@return MANTIS # self
function MANTIS:_EventHandler(EventData) end

---[Internal] Function to get the self.SAM_Table
---@return table # table
function MANTIS:_GetSAMTable() end

---[Internal] Function to set the self.SAM_Table
---@param table? any
---@return MANTIS # self
function MANTIS:_SetSAMTable(table) end

---Function to set the grouping radius of the detection in meters
---@param radius? number Radius upon which detected objects will be grouped
function MANTIS:SetEWRGrouping(radius) end

---Add a SET_ZONE of zones for Shoot&Scoot - SHORAD units will move around
---@param ZoneSet? SET_ZONE Set of zones to be used. Units will move around to the next (random) zone between 100m and 3000m away.
---@param Number? number (Optional) Number of closest zones to be considered, defaults to 3.
---@param Random? boolean If true, use a random coordinate inside the next zone to scoot to.
---@param Formation? string (Optional) Formation to use, defaults to "Cone". See mission editor dropdown for options.
---@return MANTIS # self
function MANTIS:AddScootZones(ZoneSet, Number, Random, Formation) end

---Function to set accept and reject zones.
---@param AcceptZones? table Table of @{Core.Zone#ZONE} objects
---@param RejectZones? table Table of @{Core.Zone#ZONE} objects
---@param ConflictZones? table Table of @{Core.Zone#ZONE} objects
---@return MANTIS # self
function MANTIS:AddZones(AcceptZones, RejectZones, ConflictZones) end

---Add a single reject zone to MANTIS.
---@param Zone? ZONE The zone to be added
---@return MANTIS # self
function MANTIS:AddRejectZone(Zone) end

---Add a single accept zone to MANTIS.
---@param Zone? ZONE The zone to be added
---@return MANTIS # self
function MANTIS:AddAcceptZone(Zone) end

---Add a single conflict zone to MANTIS.
---@param Zone? ZONE The zone to be added
---@return MANTIS # self
function MANTIS:AddConflictZone(Zone) end

---Function to set corridor zones.
---@param CorridorZones? SET_ZONE Can be handed in as SET\_ZONE or single ZONE object.
---@return MANTIS # self
function MANTIS:SetCorridorZones(CorridorZones) end

---Function to add one corridor zone.
---@param CorridorZone? ZONE The ZONE object to be added.
---@return MANTIS # self
function MANTIS:AddCorridorZone(CorridorZone) end

---Function to set corridor zone floor and ceiling in FEET.
---@param Floor? number Floor altitude ASL in feet.
---@param Ceiling? number Ceiling altitude ASL in feet.
---@return MANTIS # self
function MANTIS:SetCorridorZoneFloorAndCeiling(Floor, Ceiling) end

---Function to set corridor zone floor and ceiling in METERS.
---@param Floor? number Floor altitude ASL in meters.
---@param Ceiling? number Ceiling altitude ASL in meters.
---@return MANTIS # self
function MANTIS:SetCorridorZoneFloorAndCeilingMeters(Floor, Ceiling) end

---Function to set the detection radius of the EWR in meters. (Deprecated, SAM range is used)
---@param radius? number Radius of the EWR detection zone
function MANTIS:SetEWRRange(radius) end

---Function to set switch-on/off zone for the SAM sites in meters. Overwritten per SAM in automode.
---@param radius? number Radius of the firing zone in classic mode
function MANTIS:SetSAMRadius(radius) end

---Function to set SAM firing engage range, 0-100 percent, e.g. 85
---@param range? number Percent of the max fire range
function MANTIS:SetSAMRange(range) end

---Function to set Short Range SAMs to spit out smoke as decoy, if an enemy plane is in range.
---@param Onoff? boolean Set to true for on and nil/false for off.
---@param Color? number (Optional) Color to use, defaults to `SMOKECOLOR.White`
function MANTIS:SetSmokeDecoy(Onoff, Color) end

---Function to set number of SAMs going active on a valid, detected thread
---@param Short? number (Optional) Number of short-range systems activated, defaults to 2.
---@param Mid? number (Optional) Number of mid-range systems activated, defaults to 2.
---@param Long? number (Optional) Number of long-range systems activated, defaults to 1.
---@param Classic? number (Optional) (non-automode) Number of overall systems activated, defaults to 6.
---@param Point? number (Optional) Number of point defense and AAA systems activated, defaults to 6.
---@return MANTIS # self
function MANTIS:SetMaxActiveSAMs(Short, Mid, Long, Classic, Point) end

---Function to set a new SAM firing engage range, use this method to adjust range while running MANTIS, e.g. for different setups day and night
---@param range? number Percent of the max fire range
function MANTIS:SetNewSAMRangeWhileRunning(range) end

---Function to set switch-on/off the debug state
---@param onoff? boolean Set true to switch on
function MANTIS:Debug(onoff) end

---Function to get the HQ object for further use
---@return GROUP # The HQ #GROUP object or *nil* if it doesn't exist
function MANTIS:GetCommandCenter() end

---Function to set separate AWACS detection instance
---@param prefix? string Name of the AWACS group in the mission editor
function MANTIS:SetAwacs(prefix) end

---Function to set AWACS detection range. Defaults to 250.000m (250km) - use **before** starting your Mantis!
---@param range? number Detection range of the AWACS group
function MANTIS:SetAwacsRange(range) end

---Function to set the HQ object for further use
---@param group? GROUP The #GROUP object to be set as HQ
function MANTIS:SetCommandCenter(group) end

---Function to set how long INTEL DLINK remembers contacts.
---@param seconds? number Remember this many seconds, at least 5 seconds.
---@return MANTIS # self
function MANTIS:SetDLinkCacheTime(seconds) end

---Function to set the detection interval
---@param interval? number The interval in seconds
function MANTIS:SetDetectInterval(interval) end

---Function to set Advanded Mode
---@param onoff? boolean If true, will activate Advanced Mode
---@param ratio? number (Optional)  Percentage to use for advanced mode, defaults to 100%
function MANTIS:SetAdvancedMode(onoff, ratio) end

---Set using Emissions on/off instead of changing alarm state
---@param switch? boolean Decide if we are changing alarm state or Emission state
function MANTIS:SetUsingEmOnOff(switch) end

---Set using your own #INTEL_DLINK object instead of #DETECTION
---@param DLink? INTEL_DLINK The data link object to be used.
function MANTIS:SetUsingDLink(DLink) end

---[Internal] Function to check if HQ is alive
---@return boolean # True if HQ is alive, else false
function MANTIS:_CheckHQState() end

---[Internal] Function to check if EWR is (at least partially) alive
---@return boolean # True if EWR is alive, else false
function MANTIS:_CheckEWRState() end

---[Internal] Check if any EWR or AWACS is still alive
---@return boolean # outcome
function MANTIS:_CheckAnyEWRAlive() end

---[Internal] Function to determine state of the advanced mode
---@return number # Newly calculated interval
---@return number # Previous state for tracking 0, 1, or 2
function MANTIS:_CalcAdvState() end

---Function to set autorelocation for HQ and EWR objects. Note: Units must be actually mobile in DCS!
---@param hq? boolean If true, will relocate HQ object
---@param ewr? boolean If true, will relocate  EWR objects
function MANTIS:SetAutoRelocate(hq, ewr) end

---[Internal] Function to execute the relocation
---@return MANTIS # self
function MANTIS:_RelocateGroups() end

---[Internal] Function to check accept and reject zones
---@param coord? COORDINATE The coordinate to check
---@return boolean # outcome
function MANTIS:_CheckCoordinateInZones(coord) end

---[Internal] Function to prefilter height based and check for Helo activity.
---@param height? number
---@param SamCoordinate? COORDINATE
---@param contactSnapshot? table Contact facts captured once for the current check.
---@return table # set
function MANTIS:_PreFilterHeight(height, SamCoordinate, contactSnapshot) end

---[Internal] Function to check if any object is in the given SAM zone
---@param dectset? table Table of coordinates of detected items
---@param samcoordinate? COORDINATE Coordinate object.
---@param radius? number Radius to check.
---@param height? number Height to check.
---@param dlink? boolean Data from DLINK.
---@param contactSnapshot? table Contact facts captured once for the current check.
---@param closeRadius? number (Optional) Radius requiring a qualifying close threat.
---@param zoneResults? table (Optional) Coordinate-zone results shared only within the current check.
---@return boolean # True if in any zone, else false
---@return number # Distance Target distance in meters or zero when no object is in zone
---@return boolean # CloseThreat True if a qualifying target is within closeRadius; nil when no close check is requested or no target qualifies.
function MANTIS:_CheckObjectInZone(dectset, samcoordinate, radius, height, dlink, contactSnapshot, closeRadius, zoneResults) end

---[Internal] Function to start the detection via EWR groups - if INTEL isn\'t available
---@return Functional.Detection # #DETECTION_AREAS The running detection set
function MANTIS:StartDetection() end

---[Internal] Function to start the detection with INTEL via EWR groups
---@return INTEL_DLINK # The running detection set
function MANTIS:StartIntelDetection() end

---[Internal] Function to start the detection via AWACS if defined as separate (classic)
---@return Functional.Detection # #DETECTION_AREAS The running detection set
function MANTIS:StartAwacsDetection() end

---[Internal] Function to get SAM firing data from units types.
---@param grpname? string Name of the group
---@param mod? boolean HDS mod flag
---@param sma? boolean SMA mod flag
---@param chm? boolean CH mod flag
---@param group? GROUP (Optional) Already resolved group.
---@param DCSGroup? Group (Optional) Native group resolved for this wrapper during the current synchronous operation.
---@param Units? table (Optional) Current Wrapper.Unit#UNIT objects from this group, not native DCS units.
---@return number # range Max firing range
---@return number # height Max firing height
---@return string # type Long, medium or short range
---@return number # blind "blind" spot
function MANTIS:_GetSAMDataFromUnits(grpname, mod, sma, chm, group, DCSGroup, Units) end

---[Internal] Function to get SAM firing data for naval (ship) groups.
---Matches the unit type name exactly against #MANTIS.SamDataNaval and, as a side
---effect, stashes the hull's jammer curve in self._samJammerParams[grpname] so the
---SOJ jammer extension can suppress it by type name (not group name).
---@param grpname? string Name of the ship group
---@param group? GROUP (Optional) Already resolved ship group.
---@param Units? table (Optional) Current Wrapper.Unit#UNIT objects from this group, not native DCS units.
---@return number # range Max firing range (m)
---@return number # height Max firing height (m)
---@return string # type #MANTIS.SamType
---@return number # blind Blind spot
---@return number # ARMCapacity
function MANTIS:_GetNavalSAMData(grpname, group, Units) end

---[Internal] Classify a naval group PER UNIT. Each hull matching #MANTIS.SamDataNaval
---becomes its own SAM-table record keyed by UNIT name, record[8] = parent group name.
---@param group? any
---@param grpname? any
---@param SAM_Tbl? any
---@param SAM_Tbl_lg? any
---@param SAM_Tbl_md? any
---@param SAM_Tbl_sh? any
---@param SAM_Tbl_pt? any
---@param SEAD_Grps? any
---@param Units? table (Optional) Current Wrapper.Unit#UNIT objects from this group, not native DCS units.
---@return boolean # handled True if at least one unit was classified.
function MANTIS:_BuildNavalUnitEntries(group, grpname, SAM_Tbl, SAM_Tbl_lg, SAM_Tbl_md, SAM_Tbl_sh, SAM_Tbl_pt, SEAD_Grps, Units) end

---[Internal] Group ALARM-STATE arbiter for per-unit naval control.
---DCS reliably honors only GROUP-level alarm state on ships, so per-unit
---tracking decides intent and this function applies ONE alarm state per ship
---group as the final word of each cycle:
---  RED   if any managed unit is RED and not jammed (threat / hit / surface
---        wake), or the group is outside EWR radar coverage (autonomous
---        search, see SetNavalAutonomy) with at least one unjammed unit;
---  GREEN otherwise -- including full jamming suppression, which overrides
---        autonomy (a fully jammed group cannot search).
---@return MANTIS # self
function MANTIS:_ApplyNavalAlarmState() end

---[Internal] Function to get SAM firing data
---@param grpname? string Name of the group
---@param group? GROUP (Optional) Already resolved group.
---@param isship? boolean (Optional) Already resolved ship classification.
---@param DCSGroup? Group (Optional) Native group resolved for this wrapper during the current synchronous operation.
---@param Units? table (Optional) Current Wrapper.Unit#UNIT objects from this group, not native DCS units.
---@return number # range Max firing range
---@return number # height Max firing height
---@return string # type Long, medium or short range
---@return number # blind "blind" spot
function MANTIS:_GetSAMRange(grpname, group, isship, DCSGroup, Units) end

---[Internal] Check tracking radar availability and switch off sites without a working TR.
---@param group? GROUP The SAM group.
---@param grpname? string The group name.
---@param ammo? table The group's cached ammunition and tracking state.
---@param lostUnitName? string (Optional) Unit reported lost by the current event.
---@param Units? table (Optional) Current Wrapper.Unit#UNIT objects from this group, not native DCS units.
function MANTIS:_RefreshSAMTracking(group, grpname, ammo, lostUnitName, Units) end

---[Internal] Refresh the ground group's ammunition and tracking state in MANTIS_AMMO.
---Cache fields: object is the native DCS group identity; units and template identify static-set replacements;
---isSAM records radar SAM classification;
---missiles is the latest missile count; empty requires two consecutive zero samples;
---canSleep enables the empty-ammo veto outside POINT; trUnits contains expected tracking radar names;
---trLost records loss of every required TR; advancedSleeping records a site held off in advanced state 2.
---@param group? GROUP The ground group.
---@param grpname? string The group name.
---@param reset? boolean Recreate the cache for startup.
---@param samType? string The classified #MANTIS.SamType.
---@param DCSGroup? Group (Optional) Native group resolved for this wrapper during the current synchronous operation.
---@param Units? table (Optional) Current Wrapper.Unit#UNIT objects from this group, not native DCS units.
---@return MANTIS # self
function MANTIS:_RefreshSAMAmmo(group, grpname, reset, samType, DCSGroup, Units) end

---[Internal] Function to set the SAM start state
---@return MANTIS # self
function MANTIS:SetSAMStartState() end

---[Internal] Function to update SAM table and SEAD state
---@return MANTIS # self
function MANTIS:_RefreshSAMTable() end

---Function to link up #MANTIS with a #SHORAD installation
---@param Shorad? SHORAD The #SHORAD object
---@param Shoradtime? number Number of seconds #SHORAD stays active post wake-up
function MANTIS:AddShorad(Shorad, Shoradtime) end

---Function to unlink #MANTIS from a #SHORAD installation
function MANTIS:RemoveShorad() end

---[Internal] Function to smoke a group in decoy.
---@param Group? GROUP
---@return MANTIS # self
function MANTIS:_SmokeUnits(Group) end

---[Internal] Check if a system can and should defend for HARMs itself
---@param targetGroup? GROUP
---@param targetName? string
---@param attackerGroup? GROUP
---@param weaponName? string
---@param weaponWrapper? WEAPON
---@param tti? number
---@param delay? number
---@return boolean # Outcome
function MANTIS:SeadAllowSuppression(targetGroup, targetName, attackerGroup, weaponName, weaponWrapper, tti, delay) end

---[Internal] Check detection function
---@param samset? table Table of SAM data
---@param detset? table Table of COORDINATES
---@param dlink? boolean Using DLINK
---@param limit? number of SAM sites to go active on a contact
---@param contactSnapshot? table Contact facts captured once for the current check.
---@param zoneResults? table (Optional) Coordinate-zone results shared only within the current check.
---@return number # instatusred
---@return number # instatusgreen
---@return number # activeshorads
function MANTIS:_CheckLoop(samset, detset, dlink, limit, contactSnapshot, zoneResults) end

---[Internal] Check detection function
---@param detection? DETECTION_AREAS Detection object
---@param dlink? boolean
---@param reporttolog? boolean
---@return MANTIS # self
function MANTIS:_Check(detection, dlink, reporttolog) end

---[Internal] Relocation relay function
---@return MANTIS # self
function MANTIS:_Relocate() end

---[Internal] Check advanced state
---@return MANTIS # self
function MANTIS:_CheckAdvState() end

---[Internal] Check DLink state
---@return MANTIS # self
function MANTIS:_CheckDLinkState() end

---[Internal] Function to set start state
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@return MANTIS # self
function MANTIS:onafterStart(From, Event, To) end

---[Internal] Before status function for MANTIS
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@return MANTIS # self
function MANTIS:onbeforeStatus(From, Event, To) end

---[Internal] Status function for MANTIS
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@return MANTIS # self
function MANTIS:onafterStatus(From, Event, To) end

---[Internal] Function to stop MANTIS and its INTEL detectors.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@return MANTIS # self
function MANTIS:onafterStop(From, Event, To) end

---[Internal] Function triggered by Event Relocating
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@return MANTIS # self
function MANTIS:onafterRelocating(From, Event, To) end

---[Internal] Function triggered by Event GreenState
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The GROUP object whose state was changed
---@return MANTIS # self
function MANTIS:onafterGreenState(From, Event, To, Group) end

---[Internal] Function triggered by Event RedState
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The GROUP object whose state was changed
---@return MANTIS # self
function MANTIS:onafterRedState(From, Event, To, Group) end

---[Internal] Function triggered by Event AdvStateChange
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Oldstate? number Old state - 0 = green, 1 = amber, 2 = red
---@param Newstate? number New state - 0 = green, 1 = amber, 2 = red
---@param Interval? number Calculated detection interval based on state and advanced feature setting
---@return MANTIS # self
function MANTIS:onafterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval) end

---[Internal] Function triggered by Event ShoradActivated
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Name? string Name of the GROUP which SHORAD shall protect
---@param Radius? number Radius around the named group to find SHORAD groups
---@param Ontime? number Seconds the SHORAD will stay active
function MANTIS:onafterShoradActivated(From, Event, To, Name, Radius, Ontime) end

---[Internal] Function triggered by Event SeadSuppressionStart
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The suppressed GROUP object
---@param Name? string Name of the suppressed group
---@param Attacker? GROUP The attacking GROUP object
function MANTIS:onafterSeadSuppressionStart(From, Event, To, Group, Name, Attacker) end

---[Internal] Function triggered by Event SeadSuppressionEnd
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The suppressed GROUP object
---@param Name? string Name of the suppressed group
function MANTIS:onafterSeadSuppressionEnd(From, Event, To, Group, Name) end

---[Internal] Function triggered by Event SeadSuppressionPlanned
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The suppressed GROUP object
---@param Name? string Name of the suppressed group
---@param SuppressionStartTime? number Model start time of the suppression from `timer.getTime()`
---@param SuppressionEndTime? number Model end time of the suppression from `timer.getTime()`
---@param Attacker? GROUP The attacking GROUP object
function MANTIS:onafterSeadSuppressionPlanned(From, Event, To, Group, Name, SuppressionStartTime, SuppressionEndTime, Attacker) end

---Add client jammer aircraft support. Call BEFORE :Start().
---@param clientSet? SET_GROUP SET_GROUP of client jammer aircraft, or a prefix string
---@param defaultLoadout? string Default loadout key (default "1xALQ99_2xALQ249")
---@return MANTIS # self
function MANTIS:AddJammer(clientSet, defaultLoadout) end

---Add AI jammer aircraft. Call BEFORE :Start(). Can be called multiple times.
---AI jammers start OFF; use SetJammerActive(unitName, true) to activate via script.
---@param aiSet? SET_GROUP SET_GROUP or prefix string for AI jammer aircraft
---@param loadout? string Loadout key for these AI aircraft (default "1xALQ99_2xALQ249")
---@return MANTIS # self
function MANTIS:AddJammerAI(aiSet, loadout) end

---[Internal] Core jamming probability curve (v9 / v8.1 engine).
---Features: decoupled bt_mod/range_mod, tapering residual floor, ±10% jitter.
---@param d? number Distance in nautical miles
---@param params? table {peak, mu, sigma_L, tail_dist, band, floor}
---@param loadoutKey? string Key into JammerLoadouts
---@return number # Jamming probability as fraction (0.0-0.95)
function MANTIS:_JamGaussianExp(d, params, loadoutKey) end

---[Internal] Build cached sorted key lists for the resolver.
---Called once on first use. Avoids re-scanning/re-sorting JammerSAMParams every cycle.
---@return MANTIS # self
function MANTIS:_BuildJammerKeyCache() end

---[Internal] Resolve a SAM group name to its jammer parameters.
---Uses cached sorted key lists and per-name memoization for performance.
---Substring matching with digit-boundary protection prevents false matches
---(e.g. "SA-22 Pantsir" no longer matches "SA-2").
---@param grpname? string The SAM group name
---@return table # params or nil
function MANTIS:_ResolveJammerParams(grpname) end

---[Internal] Count table entries
---@param t? any
function MANTIS:_CountTable(t) end

---[Internal] Iterate any supported SET type, calling fn(unit, group) for each alive unit.
---Supports SET_GROUP (via ForEachGroupAlive) and SET_CLIENT/SET_PLAYER (via ForEachClient).
---Note: callback receives ALL alive units — caller must check InAir() for snapshot logic.
---Menu setup happens for ground units too so clients see the menu before takeoff.
---@param set? any
---@param fn? function Callback receiving (unit, group)
---@return MANTIS # self
function MANTIS:_IterateJammerSet(set, fn) end

---[Internal] Update jammer aircraft states and build snapshot.
---@return MANTIS # self
function MANTIS:_UpdateJammers() end

---[Internal] Compute which SAMs are jammed this cycle.
---@return MANTIS # self
function MANTIS:_ComputeJammedSAMs() end

---[Internal] Set up tiered F10 jammer menu for a player unit.
---@param unit? UNIT
---@param group? GROUP
---@return MANTIS # self
function MANTIS:_SetupJammerMenu(unit, group) end

---[Internal] F10 callback: Set loadout and show Music toggle
---@param unitName? any
---@param loadoutKey? any
---@param group? any
---@param rootMenu? any
function MANTIS:_JammerMenuSetLoadout(unitName, loadoutKey, group, rootMenu) end

---[Internal] Show "Music On" menu entry (jammer is OFF, click to turn ON)
---@param unitName? any
---@param group? any
---@param rootMenu? any
function MANTIS:_ShowMusicOn(unitName, group, rootMenu) end

---[Internal] Show "Music Off" menu entry (jammer is ON, click to turn OFF)
---@param unitName? any
---@param group? any
---@param rootMenu? any
function MANTIS:_ShowMusicOff(unitName, group, rootMenu) end

---On After "JammerSuppression" event
---@param From? any
---@param Event? any
---@param To? any
---@param Group? any
---@param Name? any
---@param Probability? any
function MANTIS:onafterJammerSuppression(From, Event, To, Group, Name, Probability) end

---On After "JammerActivated" event
---@param From? any
---@param Event? any
---@param To? any
---@param UnitName? any
---@param Loadout? any
function MANTIS:onafterJammerActivated(From, Event, To, UnitName, Loadout) end

---On After "JammerDeactivated" event
---@param From? any
---@param Event? any
---@param To? any
---@param UnitName? any
function MANTIS:onafterJammerDeactivated(From, Event, To, UnitName) end

---Get table of currently jammed SAM group names.
---@return table # {samName = probability}
function MANTIS:GetJammedSAMs() end

---Get number of active jammer aircraft.
---@return number
function MANTIS:GetActiveJammerCount() end

---Print a debug report of the jammer system to dcs.log and screen.
---Lists registered aircraft, their states, snapshot count, and currently
---jammed SAMs with their probabilities. Use this to diagnose menu issues,
---missing aircraft, or unexpected SAM matching.
---@param toScreen? boolean If true, also display report on screen (default false)
---@return MANTIS # self
function MANTIS:JammerDebug(toScreen) end

---Test the SAM resolver against a hypothetical group name.
---Useful for verifying naming convention before mission start.
---@param testName? string The hypothetical SAM group name to test
---@return string # Matched JammerSAMParams key, or "NO MATCH"
function MANTIS:JammerTestResolver(testName) end

---Manually set a jammer aircraft loadout (AI scripted control).
---@param unitName? string DCS unit name
---@param loadoutKey? string Key into JammerLoadouts
---@return MANTIS # self
function MANTIS:SetJammerLoadout(unitName, loadoutKey) end

---Manually activate/deactivate a jammer aircraft (AI scripted control).
---@param unitName? string DCS unit name
---@param active? boolean true=on, false=off
---@return MANTIS # self
function MANTIS:SetJammerActive(unitName, active) end

---[Internal] Override: _CheckLoop with jammer suppression.
---@param samset? table Table of SAM data.
---@param detset? table Table of COORDINATES.
---@param dlink? boolean Using DLINK.
---@param limit? number Number of SAM sites allowed active on a contact.
---@param contactSnapshot? table Contact facts captured once for the current check.
---@param zoneResults? table (Optional) Coordinate-zone results shared only within the current check.
---@return number # instatusred
---@return number # instatusgreen
---@return number # activeshorads
function MANTIS:_CheckLoop(samset, detset, dlink, limit, contactSnapshot, zoneResults) end

---[Internal] Override: onbeforeStatus with jammer update.
---@param From? any
---@param Event? any
---@param To? any
function MANTIS:onbeforeStatus(From, Event, To) end

---@param speed? any
---@param radius? any
---@param onroad? any
---@param shortcut? any
---@param formation? any
---@param onland? any
function CONTROLLABLE:RelocateGroundRandomInRadius(speed, radius, onroad, shortcut, formation, onland) end

---[Internal] Check if any enemy surface combatant is within radius of a coordinate.
---Builds a live enemy-ship SET_GROUP lazily on first use.
---@param coord? COORDINATE Ship position.
---@param radius? number Trigger radius in meters.
---@return boolean # found
function MANTIS:_EnemySurfaceInRange(coord, radius) end

---Configure naval AUTONOMY outside EWR coverage. Default: ENABLED, 150km.
---Ships mirror the ground-SAM umbrella concept: a ship group within CoverageKM
---of any alive EWR group (including EWR-role ships or AWACS ships in the EWR
---set) is managed normally -- alarm GREEN until MANTIS detects a threat inside
---one of its units' envelopes. A group OUTSIDE coverage goes alarm RED and
---searches/engages autonomously on its own radars until coverage is restored.
---Full jamming suppression overrides autonomy and forces the group GREEN.
---@param onoff? boolean Enable (true) or disable (false).
---@param coveragekm? number (Optional) Coverage radius in KILOMETERS around each alive EWR (default 150).
---@return MANTIS # self
function MANTIS:SetNavalAutonomy(onoff, coveragekm) end

---Enable/disable PER-UNIT classification and switching for naval groups. Default: ENABLED.
---Mixed-hull ship groups (e.g. a carrier escorted by destroyers) get one SAM entry PER
---SHIP -- each hull with its own type, range, state and jamming curve, switched via
---UNIT:EnableEmission while the group stays alarm RED (weapons hot). Disable to revert
---to legacy group-level naval handling (first matched hull defines the whole group).
---@param onoff? boolean Enable (true) or disable (false).
---@return MANTIS # self
function MANTIS:SetNavalPerUnit(onoff) end

---Enable/disable the naval surface wake-up and optionally set a fixed trigger radius.
---Default: ENABLED, radius = each ship's own engagement radius from SamDataNaval.
---When enabled, a MANTIS-quiet ship goes active (RED / emissions on) whenever an
---enemy surface combatant closes within the trigger radius, so anti-ship
---engagements are not blocked by EMCON. Jamming still wins: a jammed ship stays
---suppressed. Ships only -- ground SAM behavior is unchanged.
---@param onoff? boolean Enable (true) or disable (false).
---@param radiuskm? number (Optional) Fixed trigger radius in KILOMETERS for all ships.
---@return MANTIS # self
function MANTIS:SetNavalSurfaceWakeup(onoff, radiuskm) end

---Include or exclude naval SAMs from SEAD emission-shutdown evasion. Default: EXCLUDED.
---Surface combatants engage inbound ARMs/ASMs with hard-kill defenses (SAMs, CIWS);
---going emissions-dark would disable exactly those defenses. Ground SAM behavior is
---unchanged. Takes effect at the next SAM table refresh (every 3rd detection cycle).
---@param onoff? boolean If true, ships use SEAD EMCON evasion like ground SAMs.
---@return MANTIS # self
function MANTIS:SetNavalSEAD(onoff) end

---Add a NAVYGROUP to this MANTIS as SAM shooter and/or EWR picket.
---IMPORTANT: MANTIS does not change ROE. NAVYGROUP defaults to Return Fire --
---set NavyGroup:SwitchROE(ENUMS.ROE.WeaponFree) in your mission if the ship
---should engage detected targets rather than only return fire.
---@param NavyGroup? NAVYGROUP The navy group to add.
---@param Role? string "SAM" (default) = managed shooter, or "EWR" = unmanaged, always-radiating sensor/picket (coverage source). "BOTH" is deprecated and treated as SAM.
---@return MANTIS # self
function MANTIS:AddNavyGroup(NavyGroup, Role) end

---[Internal, static] Inject NAVYGROUP:SetMANTIS. Idempotent; safe if NAVYGROUP absent.
function MANTIS._InjectNavyGroupAPI() end

---Register this NAVYGROUP with a MANTIS instance as SAM shooter and/or EWR picket.
---@param Mantis? MANTIS The MANTIS instance.
---@param Role? string "SAM" (default) = managed shooter, or "EWR" = unmanaged, always-radiating sensor/picket (coverage source). "BOTH" is deprecated and treated as SAM.
---@return NAVYGROUP # self
function NAVYGROUP:SetMANTIS(Mantis, Role) end

---Triggers the FSM event "Start". Starts the MANTIS. Initializes parameters and starts event handlers.
function MANTIS:Start() end

---Triggers the FSM event "Start" after a delay. Starts the MANTIS. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function MANTIS:__Start(delay) end

---Triggers the FSM event "Stop" after a delay. Stops the MANTIS and all its event handlers.
---@param delay? number Delay in seconds.
function MANTIS:__Stop(delay) end

---Triggers the FSM event "Status".
function MANTIS:Status() end

---Triggers the FSM event "Status" after a delay.
---@param delay? number Delay in seconds.
function MANTIS:__Status(delay) end

---On After "Relocating" event. HQ and/or EWR moved.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@return MANTIS # self
function MANTIS:OnAfterRelocating(From, Event, To) end

---On After "GreenState" event. A SAM group was switched to GREEN alert.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The GROUP object whose state was changed
---@return MANTIS # self
function MANTIS:OnAfterGreenState(From, Event, To, Group) end

---On After "RedState" event. A SAM group was switched to RED alert.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The GROUP object whose state was changed
---@return MANTIS # self
function MANTIS:OnAfterRedState(From, Event, To, Group) end

---On After "AdvStateChange" event. Advanced state changed, influencing detection speed.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Oldstate? number Old state - 0 = green, 1 = amber, 2 = red
---@param Newstate? number New state - 0 = green, 1 = amber, 2 = red
---@param Interval? number Calculated detection interval based on state and advanced feature setting
---@return MANTIS # self
function MANTIS:OnAfterAdvStateChange(From, Event, To, Oldstate, Newstate, Interval) end

---On After "ShoradActivated" event. Mantis has activated a SHORAD.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Name? string Name of the GROUP which SHORAD shall protect
---@param Radius? number Radius around the named group to find SHORAD groups
---@param Ontime? number Seconds the SHORAD will stay active
function MANTIS:OnAfterShoradActivated(From, Event, To, Name, Radius, Ontime) end

---On After "SeadSuppressionPlanned" event. Mantis has planned to switch off a site to defend SEAD attack.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The suppressed GROUP object
---@param Name? string Name of the suppressed group
---@param SuppressionStartTime? number Model start time of the suppression from `timer.getTime()`
---@param SuppressionEndTime? number Model end time of the suppression from `timer.getTime()`
---@param Attacker? GROUP The attacking GROUP object
function MANTIS:OnAfterSeadSuppressionPlanned(From, Event, To, Group, Name, SuppressionStartTime, SuppressionEndTime, Attacker) end

---On After "SeadSuppressionStart" event. Mantis has switched off a site to defend a SEAD attack.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The suppressed GROUP object
---@param Name? string Name of the suppressed group
---@param Attacker? GROUP The attacking GROUP object
function MANTIS:OnAfterSeadSuppressionStart(From, Event, To, Group, Name, Attacker) end

---On After "SeadSuppressionEnd" event. Mantis has switched on a site after a SEAD attack.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The suppressed GROUP object
---@param Name? string Name of the suppressed group
function MANTIS:OnAfterSeadSuppressionEnd(From, Event, To, Group, Name) end

---On After "SAMUnitHit" event. A SAM Unit was hit.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The GROUP of the hit UNIT object
---@param Name? string Name of the suppressed group
function MANTIS:OnAfterSeadSuppressionEnd(From, Event, To, Group, Name) end

---On After "SAMUnitLoast" event. A SAM Unit was lost.
---@param From? string The From State
---@param Event? string The Event
---@param To? string The To State
---@param Group? GROUP The GROUP of the lost UNIT object
---@param Name? string Name of the suppressed group
function MANTIS:OnAfterSeadSuppressionEnd(From, Event, To, Group, Name) end
