---@meta

---@class AIRBOSS.Radioitem
---@field Tplay number Abs time when transmission should be played.
---@field Tstarted number Abs time when transmission began to play.
---@field isplaying boolean Currently playing.
---@field radio AIRBOSS.Radio Radio object.
---@field call AIRBOSS.RadioCall Radio call.
---@field loud boolean If true, play loud version of file.
---@field interval number Interval in seconds after the last sound was played.

---@class AIRBOSS.PlayerData : AIRBOSS.FlightGroup
---@field unit UNIT Aircraft of the player.
---@field unitname string Name of the unit.
---@field client CLIENT Client object of player.
---@field callsign string Callsign of player.
---@field difficulty string Difficulty level.
---@field step string Current/next pattern step.
---@field warning boolean Set true once the player got a warning.
---@field passes number Number of passes.
---@field attitudemonitor boolean If true, display aircraft attitude and other parameters constantly.
---@field debrief table Debrief analysis of the current step of this pass.
---@field lastdebrief table Debrief of player performance of last completed pass.
---@field landed boolean If true, player landed or attempted to land.
---@field boltered boolean If true, player boltered.
---@field waveoff boolean If true, player was waved off during final approach.
---@field wop boolean If true, player was waved off during the pattern.
---@field lig boolean If true, player was long in the groove.
---@field owo boolean If true, own waveoff by player.
---@field wofd boolean If true, player was waved off because of a foul deck.
---@field Tlso number Last time the LSO gave an advice.
---@field Tgroove number Time in the groove in seconds.
---@field TIG0 number Time in groove start timer.getTime().
---@field wire number Wire caught by player when trapped.
---@field groove AIRBOSS.GroovePos Data table at each position in the groove. Elements are of type @{#AIRBOSS.GrooveData}.
---@field points table Points of passes until finally landed.
---@field finalscore number Final score if points are averaged over multiple passes.
---@field valid boolean If true, player made a valid approach. Is set true on start of Groove X.
---@field subtitles boolean If true, display subtitles of radio messages.
---@field showhints boolean If true, show step hints.
---@field trapsheet table Groove data table recorded every 0.5 seconds.
---@field trapon boolean If true, save trap sheets.
---@field debriefschedulerID string Debrief scheduler ID.
---@field SRS MSRS
---@field SRSQ MSRSQUEUE

---@class AIRBOSS.FlightElement
---@field unit UNIT Aircraft unit.
---@field unitname string Name of the unit.
---@field ai boolean If true, AI sits inside. If false, human player is flying.
---@field onboard string Onboard number of the aircraft.
---@field ballcall boolean If true, flight called the ball in the groove.
---@field recovered boolean If true, element was successfully recovered.

---@class AIRBOSS.FlightGroup
---@field group GROUP Flight group.
---@field groupname string Name of the group.
---@field nunits number Number of units in group.
---@field dist0 number Distance to carrier in meters when the group was first detected inside the CCA.
---@field time number Timestamp in seconds of timer.getAbsTime() of the last important event, e.g. added to the queue.
---@field flag number Flag value describing the current stack.
---@field ai boolean If true, flight is purly AI.
---@field actype string Aircraft type name.
---@field onboardnumbers table Onboard numbers of aircraft in the group.
---@field onboard string Onboard number of player or first unit in group.
---@field case number Recovery case of flight.
---@field seclead string Name of section lead.
---@field section table Other human flight groups belonging to this flight. This flight is the lead.
---@field holding boolean If true, flight is in holding zone.
---@field ballcall boolean If true, flight called the ball in the groove.
---@field elements table Flight group elements.
---@field Tcharlie number Charlie (abs) time in seconds.
---@field name string Player name or name of first AI unit.
---@field refueling boolean Flight is refueling.

---@class AIRBOSS.Checkpoint
---@field name string Name of checkpoint.
---@field Xmin number Minimum allowed longitual distance to carrier.
---@field Xmax number Maximum allowed longitual distance to carrier.
---@field Zmin number Minimum allowed latitudal distance to carrier.
---@field Zmax number Maximum allowed latitudal distance to carrier.
---@field LimitXmin number Latitudal threshold for triggering the next step if X<Xmin.
---@field LimitXmax number Latitudal threshold for triggering the next step if X>Xmax.
---@field LimitZmin number Latitudal threshold for triggering the next step if Z<Zmin.
---@field LimitZmax number Latitudal threshold for triggering the next step if Z>Zmax.

---@class AIRBOSS.LSOgrade
---@field grade string LSO grade, i.e. _OK_, OK, (OK), --, CUT
---@field points number Points received.
---@field finalscore number Points received after player has finally landed. This is the average over all incomplete passes (bolter, waveoff) before.
---@field details string Detailed flight analysis.
---@field wire number Wire caught.
---@field Tgroove number Time in the groove in seconds.
---@field case number Recovery case.
---@field wind string Wind speed on deck in knots.
---@field modex string Onboard number.
---@field airframe string Aircraft type name of player.
---@field carriertype string Carrier type name.
---@field carriername string Carrier name/alias.
---@field theatre string DCS map.
---@field mitime string Mission time in hh:mm:ss+d format
---@field midate string Mission date in yyyy/mm/dd format.
---@field osdate string Real live date. Needs **os** to be desanitized.

---@class AIRBOSS.GrooveData
---@field Step number Current step.
---@field Time number Time in seconds.
---@field Rho number Distance in meters.
---@field X number Distance in meters.
---@field Z number Distance in meters.
---@field AoA number Angle of Attack.
---@field Alt number Altitude in meters.
---@field GSE number Glideslope error in degrees.
---@field LUE number Lineup error in degrees.
---@field Pitch number Pitch angle in degrees.
---@field Roll number Roll angle in degrees.
---@field Yaw number Yaw angle in degrees.
---@field Vel number Total velocity in m/s.
---@field Vy number Vertical velocity in m/s.
---@field Gamma number Relative heading player to carrier's runway. 0=parallel, +-90=perpendicular.
---@field Grade string LSO grade.
---@field GradePoints number LSO grade points
---@field GradeDetail string LSO grade details.
---@field FlyThrough string Fly through up "/" or fly through down "\\".

---@class AIRBOSS.Recovery
---@field START number Start of recovery in seconds of abs mission time.
---@field STOP number End of recovery in seconds of abs mission time.
---@field CASE number Recovery case (1-3) of that time slot.
---@field OFFSET number Angle offset of the holding pattern in degrees. Usually 0, +-15, or +-30 degrees.
---@field OPEN boolean Recovery window is currently open.
---@field OVER boolean Recovery window is over and closed.
---@field WIND boolean Carrier will turn into the wind.
---@field SPEED number The speed in knots the carrier has during the recovery.
---@field UTURN boolean If true, carrier makes a U-turn to the point it came from before resuming its route to the next waypoint.
---@field ID number Recovery window ID.

---@class AIRBOSS.MarshalCalls
---@field AFFIRMATIVE AIRBOSS.RadioCall "Affirmative" call.
---@field ALTIMETER AIRBOSS.RadioCall "Altimeter" call.
---@field BRC AIRBOSS.RadioCall "BRC" call.
---@field CARRIERTURNTOHEADING AIRBOSS.RadioCall "Turn to heading" call.
---@field CASE AIRBOSS.RadioCall "Case" call.
---@field CHARLIETIME AIRBOSS.RadioCall "Charlie Time" call.
---@field CLEAREDFORRECOVERY AIRBOSS.RadioCall "You're cleared for case" call.
---@field DECKCLOSED AIRBOSS.RadioCall "Deck closed" sound.
---@field DEGREES AIRBOSS.RadioCall "Degrees" call.
---@field EXPECTED AIRBOSS.RadioCall "Expected" call.
---@field FLYNEEDLES AIRBOSS.RadioCall "Fly your needles" call.
---@field HOLDATANGELS AIRBOSS.RadioCall "Hold at angels" call.
---@field HOURS AIRBOSS.RadioCall "Hours" sound.
---@field MARSHALRADIAL AIRBOSS.RadioCall "Marshal radial" call.
---@field N0 AIRBOSS.RadioCall "Zero" call.
---@field N1 AIRBOSS.RadioCall "One" call.
---@field N2 AIRBOSS.RadioCall "Two" call.
---@field N3 AIRBOSS.RadioCall "Three" call.
---@field N4 AIRBOSS.RadioCall "Four" call.
---@field N5 AIRBOSS.RadioCall "Five" call.
---@field N6 AIRBOSS.RadioCall "Six" call.
---@field N7 AIRBOSS.RadioCall "Seven" call.
---@field N8 AIRBOSS.RadioCall "Eight" call.
---@field N9 AIRBOSS.RadioCall "Nine" call.
---@field NEGATIVE AIRBOSS.RadioCall "Negative" sound.
---@field NEWFB AIRBOSS.RadioCall "New final bearing" call.
---@field OBS AIRBOSS.RadioCall "Obs" call.
---@field POINT AIRBOSS.RadioCall "Point" call.
---@field RADIOCHECK AIRBOSS.RadioCall "Radio check" call.
---@field RECOVERY AIRBOSS.RadioCall "Recovery" call.
---@field RECOVERYOPSSTOPPED AIRBOSS.RadioCall "Recovery ops stopped" sound.
---@field RECOVERYPAUSEDNOTICE AIRBOSS.RadioCall "Recovery paused until further notice" call.
---@field RECOVERYPAUSEDRESUMED AIRBOSS.RadioCall "Recovery paused and will be resumed at" call.
---@field RESUMERECOVERY AIRBOSS.RadioCall "Resuming aircraft recovery" call.
---@field REPORTSEEME AIRBOSS.RadioCall "Report see me" call.
---@field ROGER AIRBOSS.RadioCall "Roger" call.
---@field SAYNEEDLES AIRBOSS.RadioCall "Say needles" call.
---@field STACKFULL AIRBOSS.RadioCall "Marshal stack is currently full. Hold outside 10 NM zone and wait for further instructions" call.
---@field STARTINGRECOVERY AIRBOSS.RadioCall "Starting aircraft recovery" call.
---@field CLICK AIRBOSS.RadioCall Radio end transmission click sound.
---@field NOISE AIRBOSS.RadioCall Static noise sound.

---@class AIRBOSS.LSOCalls
---@field BOLTER AIRBOSS.RadioCall "Bolter, Bolter" call.
---@field CALLTHEBALL AIRBOSS.RadioCall "Call the Ball" call.
---@field CHECK AIRBOSS.RadioCall "CHECK" call.
---@field CLEAREDTOLAND AIRBOSS.RadioCall "Cleared to land" call.
---@field COMELEFT AIRBOSS.RadioCall "Come left" call.
---@field DEPARTANDREENTER AIRBOSS.RadioCall "Depart and re-enter" call.
---@field EXPECTHEAVYWAVEOFF AIRBOSS.RadioCall "Expect heavy wavoff" call.
---@field EXPECTSPOT75 AIRBOSS.RadioCall "Expect spot 7.5" call.
---@field EXPECTSPOT5 AIRBOSS.RadioCall "Expect spot 5" call.
---@field FAST AIRBOSS.RadioCall "You're fast" call.
---@field FOULDECK AIRBOSS.RadioCall "Foul Deck" call.
---@field HIGH AIRBOSS.RadioCall "You're high" call.
---@field IDLE AIRBOSS.RadioCall "Idle" call.
---@field LONGINGROOVE AIRBOSS.RadioCall "You're long in the groove" call.
---@field LOW AIRBOSS.RadioCall "You're low" call.
---@field N0 AIRBOSS.RadioCall "Zero" call.
---@field N1 AIRBOSS.RadioCall "One" call.
---@field N2 AIRBOSS.RadioCall "Two" call.
---@field N3 AIRBOSS.RadioCall "Three" call.
---@field N4 AIRBOSS.RadioCall "Four" call.
---@field N5 AIRBOSS.RadioCall "Five" call.
---@field N6 AIRBOSS.RadioCall "Six" call.
---@field N7 AIRBOSS.RadioCall "Seven" call.
---@field N8 AIRBOSS.RadioCall "Eight" call.
---@field N9 AIRBOSS.RadioCall "Nine" call.
---@field PADDLESCONTACT AIRBOSS.RadioCall "Paddles, contact" call.
---@field POWER AIRBOSS.RadioCall "Power" call.
---@field RADIOCHECK AIRBOSS.RadioCall "Paddles, radio check" call.
---@field RIGHTFORLINEUP AIRBOSS.RadioCall "Right for line up" call.
---@field ROGERBALL AIRBOSS.RadioCall "Roger ball" call.
---@field SLOW AIRBOSS.RadioCall "You're slow" call.
---@field STABILIZED AIRBOSS.RadioCall "Stabilized" call.
---@field WAVEOFF AIRBOSS.RadioCall "Wave off" call.
---@field WELCOMEABOARD AIRBOSS.RadioCall "Welcome aboard" call.
---@field CLICK AIRBOSS.RadioCall Radio end transmission click sound.
---@field NOISE AIRBOSS.RadioCall Static noise sound.
---@field SPINIT AIRBOSS.RadioCall "Spin it" call.

---@class AIRBOSS.RadioCall
---@field file string Sound file name without suffix.
---@field suffix string File suffix/extension, e.g. "ogg".
---@field loud boolean Loud version of sound file available.
---@field subtitle string Subtitle displayed during transmission.
---@field duration number Duration of the sound in seconds. This is also the duration the subtitle is displayed.
---@field subduration number Duration in seconds the subtitle is displayed.
---@field modexsender string Onboard number of the sender (optional).
---@field modexreceiver string Onboard number of the receiver (optional).
---@field sender string Sender of the message (optional). Default radio alias.

---@class AIRBOSS.Radio
---@field frequency number Frequency in Hz.
---@field modulation number Band modulation.
---@field alias string Radio alias.

---@class AIRBOSS.LUE
---@field _max number Max _OK_ value. Default 0.5 deg.
---@field _min number Min _OK_ value. Default -0.5 deg.
---@field Left number (LUR) threshold. Default -1.0 deg.
---@field Right number (LUL) threshold. Default 1.0 deg.
---@field LeftMed number threshold for AA/OS measuring. Default -2.0 deg.
---@field RightMed number threshold for AA/OS measuring. Default 2.0 deg.
---@field LEFT number LUR  threshold. Default -3.0 deg.
---@field RIGHT number LUL  threshold. Default 3.0 deg.

---@class AIRBOSS.GLE
---@field _max number Max _OK_ value. Default 0.4 deg.
---@field _min number Min _OK_ value. Default -0.3 deg.
---@field High number (H) threshold. Default 0.8 deg.
---@field Low number (L) threshold. Default -0.6 deg.
---@field HIGH number H  threshold. Default 1.5 deg.
---@field LOW number L  threshold. Default -0.9 deg.

---@class AIRBOSS.AircraftAoA
---@field OnSpeedMin number Minimum on speed AoA. Values below are fast
---@field OnSpeedMax number Maximum on speed AoA. Values above are slow.
---@field OnSpeed number Optimal on-speed AoA.
---@field Fast number Fast AoA threshold. Smaller means faster.
---@field Slow number Slow AoA threshold. Larger means slower.
---@field FAST number Really fast AoA threshold.
---@field SLOW number Really slow AoA threshold.

---@class AIRBOSS.CarrierParameters
---@field rwyangle number Runway angle in degrees. for carriers with angled deck. For USS Stennis -9 degrees.
---@field sterndist number Distance in meters from carrier position to stern of carrier. For USS Stennis -150 meters.
---@field deckheight number Height of deck in meters. For USS Stennis ~63 ft = 19 meters.
---@field wire1 number Distance in meters from carrier position to first wire.
---@field wire2 number Distance in meters from carrier position to second wire.
---@field wire3 number Distance in meters from carrier position to third wire.
---@field wire4 number Distance in meters from carrier position to fourth wire.
---@field landingdist number Distance in meeters to the landing position.
---@field rwylength number Length of the landing runway in meters.
---@field rwywidth number Width of the landing runway in meters.
---@field totlength number Total length of carrier.
---@field totwidthstarboard number Total with of the carrier from stern position to starboard side (asymmetric carriers).
---@field totwidthport number Total with of the carrier from stern position to port side (asymmetric carriers).

---AIRBOSS class.
---@class AIRBOSS : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode. Messages to all about status.
---@field lid string Class id string for output to DCS log file.
---@field theatre string The DCS map used in the mission.
---@field carrier UNIT Aircraft carrier unit on which we want to practice.
---@field carriertype string Type name of aircraft carrier.
---@field carrierparam AIRBOSS.CarrierParameters Carrier specific parameters.
---@field alias string Alias of the carrier.
---@field airbase AIRBASE Carrier airbase object.
---@field waypoints table Waypoint coordinates of carrier.
---@field currentwp number Current waypoint, i.e. the one that has been passed last.
---@field beacon BEACON Carrier beacon for TACAN and ICLS.
---@field TACANon boolean Automatic TACAN is activated.
---@field TACANchannel number TACAN channel.
---@field TACANmode string TACAN mode, i.e. "X" or "Y".
---@field TACANmorse string TACAN morse code, e.g. "STN".
---@field ICLSon boolean Automatic ICLS is activated.
---@field ICLSchannel number ICLS channel.
---@field ICLSmorse string ICLS morse code, e.g. "STN".
---@field PilotRadio AIRBOSS.Radio Radio for Pilot calls.
---@field LSORadio AIRBOSS.Radio Radio for LSO calls.
---@field LSOFreq number LSO radio frequency in MHz.
---@field LSOModu string LSO radio modulation "AM" or "FM".
---@field MarshalRadio AIRBOSS.Radio Radio for carrier calls.
---@field MarshalFreq number Marshal radio frequency in MHz.
---@field MarshalModu string Marshal radio modulation "AM" or "FM".
---@field AirbossRadio AIRBOSS.Radio Radio for carrier calls.
---@field AirbossFreq number Airboss radio frequency in MHz.
---@field AirbossModu string Airboss radio modulation "AM" or "FM".
---@field TowerFreq number Tower radio frequency in MHz.
---@field radiotimer SCHEDULER Radio queue scheduler.
---@field zoneCCA ZONE_UNIT Carrier controlled area (CCA), i.e. a zone of 50 NM radius around the carrier.
---@field zoneCCZ ZONE_UNIT Carrier controlled zone (CCZ), i.e. a zone of 5 NM radius around the carrier.
---@field players table Table of players.
---@field menuadded table Table of units where the F10 radio menu was added.
---@field BreakEntry AIRBOSS.Checkpoint Break entry checkpoint.
---@field BreakEarly AIRBOSS.Checkpoint Early break checkpoint.
---@field BreakLate AIRBOSS.Checkpoint Late break checkpoint.
---@field Abeam AIRBOSS.Checkpoint Abeam checkpoint.
---@field Ninety AIRBOSS.Checkpoint At the ninety checkpoint.
---@field Wake AIRBOSS.Checkpoint Checkpoint right behind the carrier.
---@field Final AIRBOSS.Checkpoint Checkpoint when turning to final.
---@field Groove AIRBOSS.Checkpoint In the groove checkpoint.
---@field Platform AIRBOSS.Checkpoint Case II/III descent at 2000 ft/min at 5000 ft platform.
---@field DirtyUp AIRBOSS.Checkpoint Case II/III dirty up and on speed position at 1200 ft and 10-12 NM from the carrier.
---@field Bullseye AIRBOSS.Checkpoint Case III intercept glideslope and follow ICLS aka "bullseye".
---@field defaultcase number Default recovery case policy: 0 for automatic selection, or a fixed case 1, 2 or 3.
---@field case number Recovery case I, II or III currently in progress.
---@field recoverytimes table List of time windows when aircraft are recovered including the recovery case and holding offset.
---@field defaultoffset number Default holding pattern update if not specified otherwise.
---@field holdingoffset number Offset [degrees] of Case II/III holding pattern.
---@field flights table List of all flights in the CCA.
---@field Qmarshal table Queue of marshalling aircraft groups.
---@field Qpattern table Queue of aircraft groups in the landing pattern.
---@field Qwaiting table Queue of aircraft groups waiting outside 10 NM zone for the next free Marshal stack.
---@field Qspinning table Queue of aircraft currently spinning.
---@field RQMarshal table Radio queue of marshal.
---@field TQMarshal number Abs mission time, the last transmission ended.
---@field RQLSO table Radio queue of LSO.
---@field TQLSO number Abs mission time, the last transmission ended.
---@field Nmaxpattern number Max number of aircraft in landing pattern.
---@field Nmaxmarshal number Number of max Case I Marshal stacks available. Default 3, i.e. angels 2, 3 and 4.
---@field NmaxSection number Number of max section members (excluding the lead itself), i.e. NmaxSection=1 is a section of two.
---@field NmaxStack number Number of max flights per stack. Default 2.
---@field handleai boolean If true (default), handle AI aircraft.
---@field tanker RECOVERYTANKER Recovery tanker flying overhead of carrier.
---@field Corientation Vec3 Carrier orientation in space.
---@field Corientlast Vec3 Last known carrier orientation.
---@field Cposition COORDINATE Carrier position.
---@field defaultskill string Default player skill @{#AIRBOSS.Difficulty}.
---@field adinfinitum boolean If true, carrier patrols ad infinitum, i.e. when reaching its last waypoint it starts at waypoint one again.
---@field magvar number Magnetic declination in degrees.
---@field Tcollapse number Last time timer.gettime() the stack collapsed.
---@field recoverywindow AIRBOSS.Recovery Current or next recovery window opened.
---@field usersoundradio boolean Use user sound output instead of radio transmissions.
---@field Tqueue number Last time in seconds of timer.getTime() the queue was updated.
---@field dTqueue number Time interval in seconds for updating the queues etc.
---@field dTstatus number Time interval for call FSM status updates.
---@field menumarkzones boolean If false, disables the option to mark zones via smoke or flares.
---@field menusmokezones boolean If false, disables the option to mark zones via smoke.
---@field playerscores table Table holding all player scores and grades.
---@field autosave boolean If true, all player grades are automatically saved to a file on disk.
---@field autosavepath string Path where the player grades file is saved on auto save.
---@field autosavefilename string File name of the auto player grades save file. Default is auto generated from carrier name/alias.
---@field marshalradius number Radius of the Marshal stack zone.
---@field airbossnice boolean Airboss is a nice guy.
---@field staticweather boolean Mission uses static rather than dynamic weather.
---@field windowcount number Running number counting the recovery windows.
---@field LSOdT number Time interval in seconds before the LSO will make its next call.
---@field senderac string Name of the aircraft acting as sender for broadcasting radio messages from the carrier. DCS shortcoming workaround.
---@field radiorelayLSO string Name of the aircraft acting as sender for broadcasting LSO radio messages from the carrier. DCS shortcoming workaround.
---@field radiorelayMSH string Name of the aircraft acting as sender for broadcasting Marhsal radio messages from the carrier. DCS shortcoming workaround.
---@field turnintowind boolean If true, carrier is currently turning into the wind.
---@field detour boolean If true, carrier is currently making a detour from its path along the ME waypoints.
---@field Creturnto COORDINATE Position to return to after turn into the wind leg is over.
---@field squadsetAI SET_GROUP AI groups in this set will be handled by the airboss.
---@field excludesetAI SET_GROUP AI groups in this set will be explicitly excluded from handling by the airboss and not forced into the Marshal pattern.
---@field menusingle boolean If true, menu is optimized for a single carrier.
---@field collisiondist number Distance up to which collision checks are done.
---@field holdtimestamp number Timestamp when the carrier first came to an unexpected hold.
---@field Tmessage number Default duration in seconds messages are displayed to players.
---@field soundfolder string Folder within the mission (miz) file where airboss sound files are located.
---@field soundfolderLSO string Folder withing the mission (miz) file where LSO sound files are stored.
---@field soundfolderMSH string Folder withing the mission (miz) file where Marshal sound files are stored.
---@field despawnshutdown boolean Despawn group after engine shutdown.
---@field Tbeacon number Last time the beacons were refeshed.
---@field dTbeacon number Time interval to refresh the beacons. Default 5 minutes.
---@field LSOCall AIRBOSS.LSOCalls Radio voice overs of the LSO.
---@field MarshalCall AIRBOSS.MarshalCalls Radio voice over of the Marshal/Airboss.
---@field PilotCall AIRBOSS.PilotCalls Radio voice over from AI pilots.
---@field lowfuelAI number Low fuel threshold for AI groups in percent.
---@field emergency boolean If true (default), allow emergency landings, i.e. bypass any pattern and go for final approach.
---@field respawnAI boolean If true, respawn AI flights as they enter the CCA to detach and airfields from the mission plan. Default false.
---@field turning boolean If true, carrier is currently turning.
---@field gle AIRBOSS.GLE Glidesope error thresholds.
---@field lue AIRBOSS.LUE Lineup error thresholds.
---@field trapsheet boolean If true, players can save their trap sheets.
---@field trappath string Path where to save the trap sheets.
---@field trapprefix string File prefix for trap sheet files.
---@field initialmaxalt number Max altitude in meters to register in the inital zone.
---@field welcome boolean If true, display welcome message to player.
---@field skipperMenu boolean If true, add skipper menu.
---@field skipperSpeed number Speed in knots for manual recovery start.
---@field skipperCase number Manual recovery case.
---@field skipperUturn boolean U-turn on/off via menu.
---@field skipperOffset number Holding offset angle in degrees for Case II/III manual recoveries.
---@field skipperTime number Recovery time in min for manual recovery.
---@field intowindold boolean If true, use old into wind calculation.
AIRBOSS = {
  ClassName      = "AIRBOSS",
  Debug          = false,
  lid            = nil,
  theatre        = nil,
  carrier        = nil,
  carriertype    = nil,
  carrierparam   =  {},
  alias          = nil,
  airbase        = nil,
  waypoints      =  {},
  currentwp      = nil,
  beacon         = nil,
  TACANon        = nil,
  TACANchannel   = nil,
  TACANmode      = nil,
  TACANmorse     = nil,
  ICLSon         = nil,
  ICLSchannel    = nil,
  ICLSmorse      = nil,
  LSORadio       = nil,
  LSOFreq        = nil,
  LSOModu        = nil,
  MarshalRadio   = nil,
  MarshalFreq    = nil,
  MarshalModu    = nil,
  TowerFreq      = nil,
  radiotimer     = nil,
  zoneCCA        = nil,
  zoneCCZ        = nil,
  players        =  {},
  menuadded      =  {},
  BreakEntry     =  {},
  BreakEarly     =  {},
  BreakLate      =  {},
  Abeam          =  {},
  Ninety         =  {},
  Wake           =  {},
  Final          =  {},
  Groove         =  {},
  Platform       =  {},
  DirtyUp        =  {},
  Bullseye       =  {},
  defaultcase    = nil,
  case           = nil,
  defaultoffset  = nil,
  holdingoffset  = nil,
  recoverytimes  =  {},
  flights        =  {},
  Qpattern       =  {},
  Qmarshal       =  {},
  Qwaiting       =  {},
  Qspinning      =  {},
  RQMarshal      =  {},
  RQLSO          =  {},
  TQMarshal      =   0,
  TQLSO          =   0,
  Nmaxpattern    = nil,
  Nmaxmarshal    = nil,
  NmaxSection    = nil,
  NmaxStack      = nil,
  handleai       = nil,
  xtVoiceOvers   = nil,
  xtVoiceOversAI = nil,
  tanker         = nil,
  Corientation   = nil,
  Corientlast    = nil,
  Cposition      = nil,
  defaultskill   = nil,
  adinfinitum    = nil,
  magvar         = nil,
  Tcollapse      = nil,
  recoverywindow = nil,
  usersoundradio = nil,
  Tqueue         = nil,
  dTqueue        = nil,
  dTstatus       = nil,
  menumarkzones  = nil,
  menusmokezones = nil,
  playerscores   = nil,
  autosave       = nil,
  autosavefile   = nil,
  autosavepath   = nil,
  marshalradius  = nil,
  airbossnice    = nil,
  staticweather  = nil,
  windowcount    =   0,
  LSOdT          = nil,
  senderac       = nil,
  radiorelayLSO  = nil,
  radiorelayMSH  = nil,
  turnintowind   = nil,
  detour         = nil,
  squadsetAI     = nil,
  excludesetAI   = nil,
  menusingle     = nil,
  collisiondist  = nil,
  holdtimestamp  = nil,
  Tmessage       = nil,
  soundfolder    = nil,
  soundfolderLSO = nil,
  soundfolderMSH = nil,
  despawnshutdown= nil,
  dTbeacon       = nil,
  Tbeacon        = nil,
  LSOCall        = nil,
  MarshalCall    = nil,
  lowfuelAI      = nil,
  emergency      = nil,
  respawnAI      = nil,
  gle            =  {},
  lue            =  {},
  trapsheet      = nil,
  trappath       = nil,
  trapprefix     = nil,
  initialmaxalt  = nil,
  welcome        = nil,
  skipperMenu    = nil,
  skipperSpeed   = nil,
  skipperTime    = nil,
  skipperOffset  = nil,
  skipperUturn   = nil,
}

---Aircraft types capable of landing on carrier (human+AI).
---@class AIRBOSS.AircraftCarrier
---@field AV8B string AV-8B Night Harrier. Works only with the HMS Hermes, HMS Invincible, USS Tarawa, USS America, and Juan Carlos I.
---@field A4EC string A-4E Community mod.
---@field HORNET string F/A-18C Lot 20 Hornet by Eagle Dynamics.
---@field F14A string F-14A by Heatblur.
---@field F14BU string F-14BU by Heatblur.
---@field F14A_Early string F-14A-135-GR-Early by Heatblur.
---@field F14B string F-14B by Heatblur.
---@field F14A_AI string F-14A Tomcat (AI).
---@field FA18C string F/A-18C Hornet (AI).
---@field S3B string Lockheed S-3B Viking.
---@field S3BTANKER string Lockheed S-3B Viking tanker.
---@field E2D string Grumman E-2D Hawkeye AWACS.
---@field C2A string Grumman C-2A Greyhound from Military Aircraft Mod.
---@field T45C string T-45C by VNAO.
---@field RHINOE string F/A-18E Superhornet (mod).
---@field RHINOF string F/A-18F Superhornet (mod).
---@field GROWLER string FEA-18G Superhornet (mod).
---@field CORSAIR string F4U-1D Corsair.
---@field CORSAIR_CW string F4U-1D Corsair Mk.4 (clipped wing).
AIRBOSS.AircraftCarrier={
  AV8B="AV8BNA",
  HORNET="FA-18C_hornet",
  A4EC="A-4E-C",
  F14A="F-14A-135-GR",
  F14A_Early="F-14A-135-GR-Early",
  F14B="F-14B",
  F14BU="F-14BU",
  F14A_AI="F-14A",
  FA18C="F/A-18C",
  T45C="T-45",
  S3B="S-3B",
  S3BTANKER="S-3B Tanker",
  E2D="E-2C",
  C2A="C2A_Greyhound",
  RHINOE="FA-18E",
  RHINOF="FA-18F",
  GROWLER="EA-18G",
  CORSAIR="F4U-1D",
  CORSAIR_CW="F4U-1D CW",
  RAFALE="Rafale-M",  
}

---Carrier types.
---@class AIRBOSS.CarrierType
---@field ROOSEVELT string USS Theodore Roosevelt (CVN-71) [Super Carrier Module]
---@field LINCOLN string USS Abraham Lincoln (CVN-72) [Super Carrier Module]
---@field WASHINGTON string USS George Washington (CVN-73) [Super Carrier Module]
---@field STENNIS string USS John C. Stennis (CVN-74)
---@field TRUMAN string USS Harry S. Truman (CVN-75) [Super Carrier Module]
---@field FORRESTAL string USS Forrestal (CV-59) [Heatblur Carrier Module]
---@field VINSON string USS Carl Vinson (CVN-70) [Deprecated!]
---@field ESSEX string Essex class carrier (e.g. USS Yorktown (CV-10)) [Magnitude 3 Carrier Module]
---@field BONHOMMERICHARD string USS Bon Homme Richard carrier [VWV Mod]
---@field ESSEXSCB125 string Generic Essex class carrier with angled deck (SCB-125 upgrade) [VWV Mod]
---@field ENTERPRISE66 string USS Enterprise in the 1966 configuration [VWV Mod]
---@field ENTERPRISEMODERN string USS Enterprise in a modern configuration [Derived VWV Mod]
---@field HERMES string HMS Hermes (R12) [V/STOL Carrier]
---@field INVINCIBLE string HMS Invincible (R05) [V/STOL Carrier]
---@field TARAWA string USS Tarawa (LHA-1) [V/STOL Carrier]
---@field AMERICA string USS America (LHA-6) [V/STOL Carrier]
---@field JCARLOS string Juan Carlos I (L61) [V/STOL Carrier]
---@field HMAS string Canberra (L02) [V/STOL Carrier]
---@field KUZNETSOV string Admiral Kuznetsov (CV 1143.5)
AIRBOSS.CarrierType = {
  ROOSEVELT = "CVN_71",
  LINCOLN = "CVN_72",
  WASHINGTON = "CVN_73",
  TRUMAN = "CVN_75",
  STENNIS = "Stennis",
  FORRESTAL = "Forrestal",
  ENTERPRISE66 = "USS Enterprise 1966",
  ENTERPRISEMODERN = "cvn-65",
  VINSON = "VINSON",
  ESSEX = "Essex",
  BONHOMMERICHARD = "USS Bon Homme Richard",
  ESSEXSCB125 = "essex_scb125",
  HERMES = "HERMES81",
  INVINCIBLE = "hms_invincible",
  TARAWA = "LHA_Tarawa",
  AMERICA = "USS America LHA-6",
  JCARLOS = "L61",
  CANBERRA = "L02",
  KUZNETSOV = "KUZNECOW",
}

---Pattern steps.
---@class AIRBOSS.PatternStep
---@field UNDEFINED string "Undefined".
---@field REFUELING string "Refueling".
---@field SPINNING string "Spinning".
---@field COMMENCING string "Commencing".
---@field HOLDING string "Holding".
---@field WAITING string "Waiting for free Marshal stack".
---@field PLATFORM string "Platform".
---@field ARCIN string "Arc Turn In".
---@field ARCOUT string "Arc Turn Out".
---@field DIRTYUP string "Dirty Up".
---@field BULLSEYE string "Bullseye".
---@field INITIAL string "Initial".
---@field BREAKENTRY string "Break Entry".
---@field EARLYBREAK string "Early Break".
---@field LATEBREAK string "Late Break".
---@field ABEAM string "Abeam".
---@field NINETY string "Ninety".
---@field WAKE string "Wake".
---@field FINAL string "Final".
---@field GROOVE_XX string "Groove X".
---@field GROOVE_IM string "Groove In the Middle".
---@field GROOVE_IC string "Groove In Close".
---@field GROOVE_AR string "Groove At the Ramp".
---@field GROOVE_AL string "Groove Abeam Landing Spot".
---@field GROOVE_LC string "Groove Level Cross".
---@field GROOVE_IW string "Groove In the Wires".
---@field BOLTER string "Bolter Pattern".
---@field EMERGENCY string "Emergency Landing".
---@field DEBRIEF string "Debrief".
AIRBOSS.PatternStep = {
  UNDEFINED = "Undefined",
  REFUELING = "Refueling",
  SPINNING = "Spinning",
  COMMENCING = "Commencing",
  HOLDING = "Holding",
  WAITING = "Waiting for free Marshal stack",
  PLATFORM = "Platform",
  ARCIN = "Arc Turn In",
  ARCOUT = "Arc Turn Out",
  DIRTYUP = "Dirty Up",
  BULLSEYE = "Bullseye",
  INITIAL = "Initial",
  BREAKENTRY = "Break Entry",
  EARLYBREAK = "Early Break",
  LATEBREAK = "Late Break",
  ABEAM = "Abeam",
  NINETY = "Ninety",
  WAKE = "Wake",
  FINAL = "Turn Final",
  GROOVE_XX = "Groove X",
  GROOVE_IM = "Groove In the Middle",
  GROOVE_IC = "Groove In Close",
  GROOVE_AR = "Groove At the Ramp",
  GROOVE_IW = "Groove In the Wires",
  GROOVE_IWs = "Groove In the Wires stopped?", -- VNAO Edit - Added
  GROOVE_AL = "Groove Abeam Landing Spot",
  GROOVE_LC = "Groove Level Cross",
  BOLTER = "Bolter Pattern",
  EMERGENCY = "Emergency Landing",
  DEBRIEF = "Debrief",
}

---Groove position.
---@class AIRBOSS.GroovePos
---@field X0 string "X0": Entering the groove.
---@field XX string "XX": At the start, i.e. 3/4 from the run down.
---@field IM string "IM": In the middle.
---@field IC string "IC": In close.
---@field AR string "AR": At the ramp.
---@field AL string "AL": Abeam landing position (V/STOL).
---@field LC string "LC": Level crossing (V/STOL).
---@field IW string "IW": In the wires.
AIRBOSS.GroovePos = {
  X0 = "X0",
  XX = "XX",
  IM = "IM",
  IC = "IC",
  AR = "AR",
  AL = "AL",
  LC = "LC",
  IW = "IW",
}

---Difficulty level.
---@class AIRBOSS.Difficulty
---@field EASY string Flight Student. Shows tips and hints in important phases of the approach.
---@field NORMAL string Naval aviator. Moderate number of hints but not really zip lip.
---@field HARD string TOPGUN graduate. For people who know what they are doing. Nearly *ziplip*.
AIRBOSS.Difficulty = {
  EASY = "Flight Student",
  NORMAL = "Naval Aviator",
  HARD = "TOPGUN Graduate",
}

---Main group level radio menu: F10 Other/Airboss.
AIRBOSS.MenuF10 = {}

---Airboss class version.
AIRBOSS.version = "1.5.0"

---Create a new AIRBOSS class object for a specific aircraft carrier unit.
---@param carriername? any
---@param alias? any
---@return AIRBOSS # self or nil if carrier unit does not exist.
function AIRBOSS:New(carriername, alias) end

---Set the carrier illumination mode.
---@param Mode? number Options are: -2: OFF, -1: AUTO, 0: NAVIGATION, 1: AC LAUNCH, 2: AC RECOVERY
---@return AIRBOSS # self
function AIRBOSS:SetCarrierIllumination(Mode) end

---Set welcome messages for players.
---@param Switch? boolean If true, display welcome message to player.
---@return AIRBOSS # self
function AIRBOSS:SetWelcomePlayers(Switch) end

---Set carrier controlled area (CCA).
---This is a large zone around the carrier, which is constantly updated wrt the carrier position.
---@param Radius? number (Optional) Radius of zone in nautical miles (NM). Default 50 NM.
---@return AIRBOSS # self
function AIRBOSS:SetCarrierControlledArea(Radius) end

---Set carrier controlled zone (CCZ).
---This is a small zone (usually 5 NM radius) around the carrier, which is constantly updated wrt the carrier position.
---@param Radius? number (Optional) Radius of zone in nautical miles (NM). Default 5 NM.
---@return AIRBOSS # self
function AIRBOSS:SetCarrierControlledZone(Radius) end

---Set distance up to which water ahead is scanned for collisions.
---@param Distance? number (Optional) Distance in NM. Default 5 NM.
---@return AIRBOSS # self
function AIRBOSS:SetCollisionDistance(Distance) end

---Set the default recovery case.
---@param Case? number (Optional) Case of recovery: 0 for automatic selection, or 1, 2 or 3. Default 0.
---@return AIRBOSS # self
function AIRBOSS:SetRecoveryCase(Case) end

---Resolve an instantaneous recovery case without changing the default policy.
---@param Case? number (Optional) 0 for automatic selection, or 1, 2 or 3. Defaults to self.defaultcase.
---@return number # Resolved recovery case 1, 2 or 3.
function AIRBOSS:_ResolveRecoveryCase(Case) end

---Set holding pattern offset from final bearing for Case II/III recoveries.
---Usually, this is +-15 or +-30 degrees. You should not use and offset angle >= 90 degrees, because this will cause a devision by zero in some of the equations used to calculate the approach corridor.
---So best stick to the defaults up to 30 degrees.
---@param Offset? number (Optional) Offset angle in degrees. Default 0.
---@return AIRBOSS # self
function AIRBOSS:SetHoldingOffsetAngle(Offset) end

---Enable F10 menu to manually start recoveries.
---@param Duration? number (Optional) Default duration of the recovery in minutes. Default 30 min.
---@param WindOnDeck? number (Optional)  Default wind on deck in knots. Default 25 knots.
---@param Uturn? boolean (Optional) U-turn after recovery window closes on=true or off=false/nil. Default off.
---@param Offset? number (Optional) Relative Marshal radial in degrees for Case II/III recoveries. Default 30°.
---@return AIRBOSS # self
function AIRBOSS:SetMenuRecovery(Duration, WindOnDeck, Uturn, Offset) end

---Add aircraft recovery time window and recovery case.
---@param starttime? string (Optional) Start time, e.g. "8:00" for eight o'clock. Default now.
---@param stoptime? string (Optional) Stop time, e.g. "9:00" for nine o'clock. Default 90 minutes after start time.
---@param case? number (Optional) Recovery case 1, 2 or 3; 0 selects automatically at creation and uses Case III if night is detected within the planned window (one-minute checks including the end). If omitted, uses the configured default case (initially 0, automatic).
---@param holdingoffset? number (Optional) Only for CASE II/III: Angle in degrees the holding pattern is offset. Defaults to 0.
---@param turnintowind? boolean If true, carrier will turn into the wind 5 minutes before the recovery window opens.
---@param speed? number (Optional) Speed in knots during turn into wind leg. Default is 20.
---@param uturn? boolean (Optional) If true (or nil), carrier wil perform a U-turn and go back to where it came from before resuming its route to the next waypoint. If false, it will go directly to the next waypoint.
---@return AIRBOSS.Recovery # Recovery window.
function AIRBOSS:AddRecoveryWindow(starttime, stoptime, case, holdingoffset, turnintowind, speed, uturn) end

---Define a set of AI groups that are handled by the airboss.
---@param SetGroup? SET_GROUP The set of AI groups which are handled by the airboss.
---@return AIRBOSS # self
function AIRBOSS:SetSquadronAI(SetGroup) end

---Define a set of AI groups that excluded from AI handling. Members of this set will be left allone by the airboss and not forced into the Marshal pattern.
---@param SetGroup? SET_GROUP The set of AI groups which are excluded.
---@return AIRBOSS # self
function AIRBOSS:SetExcludeAI(SetGroup) end

---Add a group to the exclude set. If no set exists, it is created.
---@param Group? GROUP The group to be excluded.
---@return AIRBOSS # self
function AIRBOSS:AddExcludeAI(Group) end

---Close currently running recovery window and stop recovery ops. Recovery window is deleted.
---@param Delay? number (Optional) Delay in seconds before the window is deleted.
function AIRBOSS:CloseCurrentRecoveryWindow(Delay) end

---Delete all recovery windows.
---@param Delay? number (Optional) Delay in seconds before the windows are deleted.
---@return AIRBOSS # self
function AIRBOSS:DeleteAllRecoveryWindows(Delay) end

---Return the recovery window of the given ID.
---@param id? number The ID of the recovery window.
---@return AIRBOSS.Recovery # Recovery window with the right ID or nil if no such window exists.
function AIRBOSS:GetRecoveryWindowByID(id) end

---Delete a recovery window. If the window is currently open, it is closed and the recovery stopped.
---@param Window? AIRBOSS.Recovery|number|string Recovery window.
---@param Delay? number Delay in seconds, before the window is deleted.
function AIRBOSS:DeleteRecoveryWindow(Window, Delay) end

---Set time before carrier turns and recovery window opens.
---@param Interval? number (Optional) Time interval in seconds. Default 300 sec.
---@return AIRBOSS # self
function AIRBOSS:SetRecoveryTurnTime(Interval) end

---Set multiplayer environment wire correction.
---@param Dcorr? number (Optional) Correction distance in meters. Default 12 m.
---@return AIRBOSS # self
function AIRBOSS:SetMPWireCorrection(Dcorr) end

---Set time interval for updating queues and other stuff.
---@param TimeInterval? number (Optional) Time interval in seconds. Default 30 sec.
---@return AIRBOSS # self
function AIRBOSS:SetQueueUpdateTime(TimeInterval) end

---Set time interval between LSO calls. Optimal time in the groove is ~16 seconds. So the default of 4 seconds gives around 3-4 correction calls in the groove.
---@param TimeInterval? number (Optional) Time interval in seconds between LSO calls. Default 4 sec.
---@return AIRBOSS # self
function AIRBOSS:SetLSOCallInterval(TimeInterval) end

---Set if old into wind calculation is used when carrier turns into the wind for a recovery.
---@param SwitchOn? boolean If `true` or `nil`, use old into wind calculation.
---@return AIRBOSS # self
function AIRBOSS:SetIntoWindLegacy(SwitchOn) end

---Airboss is a rather nice guy and not strictly following the rules. Fore example, he does allow you into the landing pattern if you are not coming from the Marshal stack.
---@param Switch? boolean If true or nil, Airboss bends the rules a bit.
---@return AIRBOSS # self
function AIRBOSS:SetAirbossNiceGuy(Switch) end

---Allow emergency landings, i.e. bypassing any pattern and go directly to final approach.
---@param Switch? boolean If true or nil, emergency landings are okay.
---@return AIRBOSS # self
function AIRBOSS:SetEmergencyLandings(Switch) end

---Despawn AI groups after they they shut down their engines.
---@param Switch? boolean If true or nil, AI groups are despawned.
---@return AIRBOSS # self
function AIRBOSS:SetDespawnOnEngineShutdown(Switch) end

---Respawn AI groups once they reach the CCA. Clears any attached airbases and allows making them land on the carrier via script.
---@param Switch? boolean If true or nil, AI groups are respawned.
---@return AIRBOSS # self
function AIRBOSS:SetRespawnAI(Switch) end

---Give AI aircraft the refueling task if a recovery tanker is present or send them to the nearest divert airfield.
---@param LowFuelThreshold? number (Optional) Low fuel threshold in percent. AI will go refueling if their fuel level drops below this value. Default 10 %.
---@return AIRBOSS # self
function AIRBOSS:SetRefuelAI(LowFuelThreshold) end

---Set max altitude to register flights in the initial zone. Aircraft above this altitude will not be registerered.
---@param MaxAltitude? number (Optional) Max altitude in feet. Default 1300 ft.
---@return AIRBOSS # self
function AIRBOSS:SetInitialMaxAlt(MaxAltitude) end

---Set folder path where the airboss sound files are located **within you mission (miz) file**.
---The default path is "l10n/DEFAULT/" but sound files simply copied there will be removed by DCS the next time you save the mission.
---However, if you create a new folder inside the miz file, which contains the sounds, it will not be deleted and can be used.
---@param FolderPath? string The path to the sound files, e.g. "Airboss Soundfiles/".
---@return AIRBOSS # self
function AIRBOSS:SetSoundfilesFolder(FolderPath) end

---Set time interval for updating player status and other things.
---@param TimeInterval? number (Optional) Time interval in seconds. Default 0.5 sec.
---@return AIRBOSS # self
function AIRBOSS:SetStatusUpdateTime(TimeInterval) end

---Set duration how long messages are displayed to players.
---@param Duration? number (Optional) Duration in seconds. Default 10 sec.
---@return AIRBOSS # self
function AIRBOSS:SetDefaultMessageDuration(Duration) end

---@param _max? any
---@param _min? any
---@param High? any
---@param HIGH? any
---@param Low? any
---@param LOW? any
function AIRBOSS:SetGlideslopeErrorThresholds(_max, _min, High, HIGH, Low, LOW) end

---@param _max? any
---@param _min? any
---@param Left? any
---@param LeftMed? any
---@param LEFT? any
---@param Right? any
---@param RightMed? any
---@param RIGHT? any
function AIRBOSS:SetLineupErrorThresholds(_max, _min, Left, LeftMed, LEFT, Right, RightMed, RIGHT) end

---Set Case I Marshal radius. This is the radius of the valid zone around "the post" aircraft are supposed to be holding in the Case I Marshal stack.
---The post is 2.5 NM port of the carrier.
---@param Radius? number (Optional) Radius in NM. Default 2.8 NM, which gives a diameter of 5.6 NM.
---@return AIRBOSS # self
function AIRBOSS:SetMarshalRadius(Radius) end

---Optimized F10 radio menu for a single carrier. The menu entries will be stored directly under F10 Other/Airboss/ and not F10 Other/Airboss/"Carrier Alias"/.
---**WARNING**: If you use this with two airboss objects/carriers, the radio menu will be screwed up!
---@param Switch? boolean If true or nil single menu is enabled. If false, menu is for multiple carriers in the mission.
---@return AIRBOSS # self
function AIRBOSS:SetMenuSingleCarrier(Switch) end

---Enable or disable F10 radio menu for marking zones via smoke or flares.
---@param Switch? boolean If true or nil, menu is enabled. If false, menu is not available to players.
---@return AIRBOSS # self
function AIRBOSS:SetMenuMarkZones(Switch) end

---Enable or disable F10 radio menu for marking zones via smoke.
---@param Switch? boolean If true or nil, menu is enabled. If false, menu is not available to players.
---@return AIRBOSS # self
function AIRBOSS:SetMenuSmokeZones(Switch) end

---Enable saving of player's trap sheets and specify an optional directory path.
---@param Path? string (Optional) Path where to save the trap sheets.
---@param Prefix? string (Optional) Prefix for trap sheet files. File name will be saved as *prefix_aircrafttype-0001.csv*, *prefix_aircrafttype-0002.csv*, etc.
---@return AIRBOSS # self
function AIRBOSS:SetTrapSheet(Path, Prefix) end

---Specify weather the mission has set static or dynamic weather.
---@param Switch? boolean If true or nil, mission uses static weather. If false, dynamic weather is used in this mission.
---@return AIRBOSS # self
function AIRBOSS:SetStaticWeather(Switch) end

---Disable automatic TACAN activation
---@return AIRBOSS # self
function AIRBOSS:SetTACANoff() end

---Set TACAN channel of carrier and switches TACAN on.
---@param Channel? number (Optional) TACAN channel. Default 74.
---@param Mode? string (Optional) TACAN mode, i.e. "X" or "Y". Default "X".
---@param MorseCode? string (Optional) Morse code identifier. Three letters, e.g. "STN". Default "STN".
---@return AIRBOSS # self
function AIRBOSS:SetTACAN(Channel, Mode, MorseCode) end

---Disable automatic ICLS activation.
---@return AIRBOSS # self
function AIRBOSS:SetICLSoff() end

---Set ICLS channel of carrier.
---@param Channel? number (Optional) ICLS channel. Default 1.
---@param MorseCode? string (Optional) Morse code identifier. Three letters, e.g. "STN". Default "STN".
---@return AIRBOSS # self
function AIRBOSS:SetICLS(Channel, MorseCode) end

---Set beacon (TACAN/ICLS) time refresh interfal in case the beacons die.
---@param TimeInterval? number (Optional) Time interval in seconds. Default 1200 sec = 20 min.
---@return AIRBOSS # self
function AIRBOSS:SetBeaconRefresh(TimeInterval) end

---Set up SRS for usage without sound files
---@param PathToSRS? string Path to SRS folder, e.g. "C:\\Program Files\\DCS-SimpleRadio\\ExternalAudio".
---@param Port? number (Optional) Port of the SRS server, defaults to 5002.
---@param Culture? string (Optional) (Optional, Airboss Culture)  Culture, defaults to "en-US".
---@param Gender? string (Optional) (Optional, Airboss Gender)  Gender, e.g. "male" or "female". Defaults to "male".
---@param Voice? string (Optional, Airboss Voice) Set to use a specific voice. Will **override gender and culture** settings.
---@param GoogleCreds? string (Optional) Path to Google credentials, e.g. "C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourgooglekey.json".
---@param Volume? number (Optional) E.g. 0.75. Defaults to 1.0 (loudest).
---@param AltBackend? table (Optional) See MSRS for details.
---@return AIRBOSS # self
function AIRBOSS:EnableSRS(PathToSRS, Port, Culture, Gender, Voice, GoogleCreds, Volume, AltBackend) end

---Set LSO radio frequency and modulation. Default frequency is 264 MHz AM.
---@param Frequency? number (Optional) Frequency in MHz. Default 264 MHz.
---@param Modulation? string (Optional) Modulation, "AM" or "FM". Default "AM".
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS # self
function AIRBOSS:SetLSORadio(Frequency, Modulation, Voice, Gender, Culture) end

---Set Airboss radio frequency and modulation. Default frequency is Tower frequency.
---@param Frequency? number (Optional) Frequency in MHz. Default frequency is Tower frequency.
---@param Modulation? string (Optional) Modulation, "AM" or "FM". Default "AM".
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS # self
function AIRBOSS:SetAirbossRadio(Frequency, Modulation, Voice, Gender, Culture) end

---Set Marshal radio frequency and modulation. Default frequency is 305 MHz AM.
---@param Frequency? number (Optional) Frequency in MHz. Default 305 MHz.
---@param Modulation? string (Optional) Modulation, "AM" or "FM". Default "AM".
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS # self
function AIRBOSS:SetMarshalRadio(Frequency, Modulation, Voice, Gender, Culture) end

---Set unit name for sending radio messages.
---@param unitname? string Name of the unit.
---@return AIRBOSS # self
function AIRBOSS:SetRadioUnitName(unitname) end

---Set unit acting as radio relay for the LSO radio.
---@param unitname? string Name of the unit.
---@return AIRBOSS # self
function AIRBOSS:SetRadioRelayLSO(unitname) end

---Set unit acting as radio relay for the Marshal radio.
---@param unitname? string Name of the unit.
---@return AIRBOSS # self
function AIRBOSS:SetRadioRelayMarshal(unitname) end

---Use user sound output instead of radio transmission for messages. Might be handy if radio transmissions are broken.
---@return AIRBOSS # self
function AIRBOSS:SetUserSoundRadio() end

---Test LSO radio sounds.
---@param delay? number Delay in seconds be sound check starts.
---@return AIRBOSS # self
function AIRBOSS:SoundCheckLSO(delay) end

---Test Marshal radio sounds.
---@param delay? number Delay in seconds be sound check starts.
---@return AIRBOSS # self
function AIRBOSS:SoundCheckMarshal(delay) end

---Set number of aircraft units, which can be in the landing pattern before the pattern is full.
---@param nmax? number (Optional) Max number. Default 4. Minimum is 1, maximum is 6.
---@return AIRBOSS # self
function AIRBOSS:SetMaxLandingPattern(nmax) end

---Set number available Case I Marshal stacks. If Marshal stacks are full, flights requesting Marshal will be told to hold outside 10 NM zone until a stack becomes available again.
---Marshal stacks for Case II/III are unlimited.
---@param nmax? number (Optional) Max number of stacks available to players and AI flights. Default 3, i.e. angels 2, 3, 4. Minimum is 1.
---@return AIRBOSS # self
function AIRBOSS:SetMaxMarshalStacks(nmax) end

---Set max number of section members. Minimum is one, i.e. the section lead itself. Maximum number is four. Default is two, i.e. the lead and one other human flight.
---@param nmax? number Number of max allowed members including the lead itself. For example, Nmax=2 means a section lead plus one member.
---@return AIRBOSS # self
function AIRBOSS:SetMaxSectionSize(nmax) end

---Set maximum distance up to which section members are allowed (default: 100 meters).
---@param dmax? number (Optional) Max distance in meters (default 100 m). Minimum is 10 m, maximum is 5000 m.
---@return AIRBOSS # self
function AIRBOSS:SetMaxSectionDistance(dmax) end

---Set max number of flights per stack. All members of a section count as one "flight".
---@param nmax? number (Optional) Number of max allowed flights per stack. Default is two. Minimum is one, maximum is 4.
---@return AIRBOSS # self
function AIRBOSS:SetMaxFlightsPerStack(nmax) end

---Handle AI aircraft.
---@return AIRBOSS # self
function AIRBOSS:SetHandleAION() end

---Will play the inbound calls, commencing, initial, etc. from the player when requesteing marshal
---@param status? AIRBOSS (Optional) Boolean to activate (true) / deactivate (false) the radio inbound calls (default is ON)
---@return AIRBOSS # self
function AIRBOSS:SetExtraVoiceOvers(status) end

---Will simulate the inbound call, commencing, initial, etc from the AI when requested by Airboss
---@param status? AIRBOSS (Optional) Boolean to activate (true) / deactivate (false) the radio inbound calls (default is ON)
---@return AIRBOSS # self
function AIRBOSS:SetExtraVoiceOversAI(status) end

---Do not handle AI aircraft.
---@return AIRBOSS # self
function AIRBOSS:SetHandleAIOFF() end

---Define recovery tanker associated with the carrier.
---@param recoverytanker? RECOVERYTANKER Recovery tanker object.
---@return AIRBOSS # self
function AIRBOSS:SetRecoveryTanker(recoverytanker) end

---Define an AWACS associated with the carrier.
---@param awacs? RECOVERYTANKER AWACS (recovery tanker) object.
---@return AIRBOSS # self
function AIRBOSS:SetAWACS(awacs) end

---Set default player skill. New players will be initialized with this skill.
---
---* "Flight Student" = {#AIRBOSS.Difficulty.Easy}
---* "Naval Aviator" = {#AIRBOSS.Difficulty.Normal}
---* "TOPGUN Graduate" = {#AIRBOSS.Difficulty.Hard}
---@param skill? string (Optional) Player skill. Default "Naval Aviator".
---@return AIRBOSS # self
function AIRBOSS:SetDefaultPlayerSkill(skill) end

---Enable auto save of player results each time a player is *finally* graded. *Finally* means after the player landed on the carrier! After intermediate passes (bolter or waveoff) the stats are *not* saved.
---@param path? string (Optional) Path where to save the asset data file. Default is the DCS root installation directory or your "Saved Games\\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is generated automatically from airboss carrier name/alias.
---@return AIRBOSS # self
function AIRBOSS:SetAutoSave(path, filename) end

---Activate debug mode. Display debug messages on screen.
---@return AIRBOSS # self
function AIRBOSS:SetDebugModeON() end

---Carrier patrols ad inifintum. If the last waypoint is reached, it will go to waypoint one and repeat its route.
---@param switch? boolean If true or nil, patrol until the end of time. If false, go along the waypoints once and stop.
---@return AIRBOSS # self
function AIRBOSS:SetPatrolAdInfinitum(switch) end

---Set the magnetic declination (or variation). By default this is set to the standard declination of the map.
---@param declination? number (Optional) Declination in degrees or nil for default declination of the map.
---@return AIRBOSS # self
function AIRBOSS:SetMagneticDeclination(declination) end

---Deactivate debug mode. This is also the default setting.
---@return AIRBOSS # self
function AIRBOSS:SetDebugModeOFF() end

---Set FunkMan socket. LSO grades and trap sheets will be send to your Discord bot.
---**Requires running FunkMan program**.
---@param Port? number (Optional) Port. Default `10042`.
---@param Host? string (Optional) Host. Default `"127.0.0.1"`.
---@return AIRBOSS # self
function AIRBOSS:SetFunkManOn(Port, Host) end

---Get next time the carrier will start recovering aircraft.
---@param InSeconds? boolean (Optional) If true, abs. mission time seconds is returned. Default is a clock #string.
---@return string # Clock start (or start time in abs. seconds).
---@return string # Clock stop (or stop time in abs. seconds).
function AIRBOSS:GetNextRecoveryTime(InSeconds) end

---Check if carrier is recovering aircraft.
---@return boolean # If true, time slot for recovery is open.
function AIRBOSS:IsRecovering() end

---Check if carrier is idle, i.e. no operations are carried out.
---@return boolean # If true, carrier is in idle state.
function AIRBOSS:IsIdle() end

---Check if recovery of aircraft is paused.
---@return boolean # If true, recovery is paused
function AIRBOSS:IsPaused() end

---Activate TACAN and ICLS beacons.
function AIRBOSS:_ActivateBeacons() end

---On after Start event. Starts the AIRBOSS. Adds event handlers and schedules status updates of requests and queue.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:onafterStart(From, Event, To) end

---On after Status event. Checks for new flights, updates queue and checks player status.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:onafterStatus(From, Event, To) end

---Check AI status. Pattern queue AI in the groove? Marshal queue AI arrived in holding zone?
function AIRBOSS:_Status() end

---Check AI status. Pattern queue AI in the groove? Marshal queue AI arrived in holding zone?
function AIRBOSS:_CheckAIStatus() end

---Check if player in the landing pattern is too close to another aircarft in the pattern.
---@param player? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_CheckPlayerPatternDistance(player) end

---Check recovery times and start/stop recovery mode of aircraft.
function AIRBOSS:_CheckRecoveryTimes() end

---Get section lead of a flight.
---@param flight? AIRBOSS.FlightGroup|number|string
---@return AIRBOSS.FlightGroup # The leader of the section. Could be the flight itself.
---@return boolean # If true, flight is lead.
function AIRBOSS:_GetFlightLead(flight) end

---On before "RecoveryCase" event. Check if case or holding offset did change. If not transition is denied.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Case? number The recovery case (1, 2 or 3) to switch to.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:onbeforeRecoveryCase(From, Event, To, Case, Offset) end

---On after "RecoveryCase" event. Sets new aircraft recovery case. Updates
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Case? number The recovery case (1, 2 or 3) to switch to.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:onafterRecoveryCase(From, Event, To, Case, Offset) end

---On after "RecoveryStart" event. Recovery of aircraft is started and carrier switches to state "Recovering".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Case? number The recovery case (1, 2 or 3) to start.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:onafterRecoveryStart(From, Event, To, Case, Offset) end

---On after "RecoveryStop" event. Recovery of aircraft is stopped and carrier switches to state "Idle". Running recovery window is deleted.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:onafterRecoveryStop(From, Event, To) end

---On after "RecoveryPause" event. Recovery of aircraft is paused. Marshal queue stays intact.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param duration? number Duration of pause in seconds. After that recovery is resumed automatically.
function AIRBOSS:onafterRecoveryPause(From, Event, To, duration) end

---On after "RecoveryUnpause" event. Recovery of aircraft is resumed.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:onafterRecoveryUnpause(From, Event, To) end

---On after "PassingWaypoint" event. Carrier has just passed a waypoint
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param n? number Number of waypoint that was passed.
function AIRBOSS:onafterPassingWaypoint(From, Event, To, n) end

---On after "Idle" event. Carrier goes to state "Idle".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:onafterIdle(From, Event, To) end

---On after Stop event. Unhandle events.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:onafterStop(From, Event, To) end

---Init parameters for USS Stennis carrier.
function AIRBOSS:_InitStennis() end

---Init parameters for Nimitz class super carriers.
function AIRBOSS:_InitNimitz() end

---Init parameters for Forrestal class super carriers.
function AIRBOSS:_InitForrestal() end

---Init parameters for Enterprise carrier.
function AIRBOSS:_InitEnterprise() end

---Init parameters for Essec class carriers.
function AIRBOSS:_InitEssex() end

---Init parameters for CVA-31 Bon Homme Richard carriers.
function AIRBOSS:_InitBonHommeRichard() end

---Init parameters for Generic Essex SC125 class carriers.
function AIRBOSS:_InitEssexSCB125() end

---Init parameters for R12 HMS Hermes carrier.
function AIRBOSS:_InitHermes() end

---Init parameters for R05 HMS Invincible carrier.
function AIRBOSS:_InitInvincible() end

---Init parameters for LHA-1 Tarawa carrier.
function AIRBOSS:_InitTarawa() end

---Init parameters for LHA-6 America carrier.
function AIRBOSS:_InitAmerica() end

---Init parameters for L61 Juan Carlos carrier.
function AIRBOSS:_InitJcarlos() end

---Init parameters for L02 Canberra carrier.
function AIRBOSS:_InitCanberra() end

---Init parameters for Marshal Voice overs *Gabriella* by HighwaymanEd.
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversMarshalByGabriella(mizfolder) end

---Init parameters for Marshal Voice overs by *Raynor*.
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversMarshalByRaynor(mizfolder) end

---Set parameters for LSO Voice overs by *Raynor*.
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversLSOByRaynor(mizfolder) end

---Set parameters for LSO Voice overs by *funkyfranky*.
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversLSOByFF(mizfolder) end

---Intit parameters for Marshal Voice overs by *funkyfranky*.
---@param mizfolder? string (Optional) Folder within miz file where the sound files are located.
function AIRBOSS:SetVoiceOversMarshalByFF(mizfolder) end

---Init voice over radio transmission call.
function AIRBOSS:_InitVoiceOvers() end

---Init voice over radio transmission call.
---@param radiocall? AIRBOSS.RadioCall|number|string LSO or Marshal radio call object.
---@param duration? number Duration of the voice over in seconds.
---@param subtitle? string (Optional) Subtitle to be displayed along with voice over.
---@param subduration? number (Optional) Duration how long the subtitle is displayed.
---@param filename? string (Optional) Name of the voice over sound file.
---@param suffix? string (Optional) Extention of file. Default ".ogg".
function AIRBOSS:SetVoiceOver(radiocall, duration, subtitle, subduration, filename, suffix) end

---Get optimal aircraft AoA parameters..
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return AIRBOSS.AircraftAoA # AoA parameters for the given aircraft type.
function AIRBOSS:_GetAircraftAoA(playerData) end

---Convert AoA from arbitrary units to degrees.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param aoaunits? number AoA in arbitrary units.
---@return number # AoA in degrees.
function AIRBOSS:_AoAUnit2Deg(playerData, aoaunits) end

---Convert AoA from degrees to arbitrary units.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param degrees? number AoA in degrees.
---@return number # AoA in arbitrary units.
function AIRBOSS:_AoADeg2Units(playerData, degrees) end

---Get optimal aircraft flight parameters at checkpoint.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param step? string Pattern step.
---@return number # Altitude in meters or nil.
---@return number # Angle of Attack or nil.
---@return number # Distance to carrier in meters or nil.
---@return number # Speed in m/s or nil.
function AIRBOSS:_GetAircraftParameters(playerData, step) end

---Get next marshal flight which is ready to enter the landing pattern.
---@return AIRBOSS.FlightGroup # Marshal flight next in line and ready to enter the pattern. Or nil if no flight is ready.
function AIRBOSS:_GetNextMarshalFight() end

---Check marshal and pattern queues.
function AIRBOSS:_CheckQueue() end

---Clear flight for landing. AI are removed from Marshal queue and the Marshal stack is collapsed.
---If next in line is an AI flight, this is done. If human player is next, we wait for "Commence" via F10 radio menu command.
---@param flight? AIRBOSS.FlightGroup|number|string Flight to go to pattern.
function AIRBOSS:_ClearForLanding(flight) end

---Set player step. Any warning is erased and next step hint shown.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param step? string Next step.
---@param delay? number (Optional) Set set after a delay in seconds.
function AIRBOSS:_SetPlayerStep(playerData, step, delay) end

---Scan carrier zone for (new) units.
function AIRBOSS:_ScanCarrierZone() end

---Tell player to wait outside the 10 NM zone until a Marshal stack is available.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_WaitPlayer(playerData) end

---Orbit at a specified position at a specified altitude with a specified speed.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param stack? number The Marshal stack the player gets.
function AIRBOSS:_MarshalPlayer(playerData, stack) end

---Command AI flight to orbit outside the 10 NM zone and wait for a free Marshal stack.
---If the flight is not already holding in the Marshal stack, it is guided there first.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group.
---@param respawn? boolean If true respawn the group. Otherwise reset the mission task with new waypoints.
function AIRBOSS:_WaitAI(flight, respawn) end

---Command AI flight to orbit at a specified position at a specified altitude with a specified speed. If flight is not in the Marshal queue yet, it is added. This fixes the recovery case.
---If the flight is not already holding in the Marshal stack, it is guided there first.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group.
---@param nstack? number Stack number of group. Can also be the current stack if AI position needs to be updated wrt to changed carrier position.
---@param respawn? boolean If true, respawn the flight otherwise update mission task with new waypoints.
function AIRBOSS:_MarshalAI(flight, nstack, respawn) end

---Tell AI to refuel. Either at the recovery tanker or at the nearest divert airfield.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group.
function AIRBOSS:_RefuelAI(flight) end

---Tell AI to land on the carrier.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group.
function AIRBOSS:_LandAI(flight) end

---Get marshal altitude and two positions of a counter-clockwise race track pattern.
---@param stack? number Assigned stack number. Counting starts at one, i.e. stack=1 is the first stack.
---@param case? number (Optional) Recovery case. Default is self.case.
---@return number # Holding altitude in meters.
---@return COORDINATE # First race track coordinate.
---@return COORDINATE # Second race track coordinate.
function AIRBOSS:_GetMarshalAltitude(stack, case) end

---Calculate an estimate of the charlie time of the player based on how many other aircraft are in the marshal or pattern queue before him.
---@param flightgroup? AIRBOSS.FlightGroup|number|string Flight data.
---@return number # Charlie (abs) time in seconds. Or nil, if stack<0 or no recovery window will open.
function AIRBOSS:_GetCharlieTime(flightgroup) end

---Add a flight group to the Marshal queue at a specific stack. Flight is informed via message. This fixes the recovery case to the current case ops in progress self.case).
---@param flight? AIRBOSS.FlightGroup|number|string Flight group.
---@param stack? number Marshal stack. This (re-)sets the flag value.
function AIRBOSS:_AddMarshalGroup(flight, stack) end

---Collapse marshal stack.
---@param flight? AIRBOSS.FlightGroup|number|string Flight that left the marshal stack.
---@param nopattern? boolean If true, flight does not go to pattern.
function AIRBOSS:_CollapseMarshalStack(flight, nopattern) end

---Get next free Marshal stack. Depending on AI/human and recovery case.
---@param ai? boolean If true, get a free stack for an AI flight group.
---@param case? number (Optional) Recovery case. Default current (self) case in progress.
---@param empty? boolean (Optional) Return lowest stack that is completely empty.
---@return number # Lowest free stack available for the given case or nil if all Case I stacks are taken.
function AIRBOSS:_GetFreeStack(ai, case, empty) end

---Get next free Marshal stack. Depending on AI/human and recovery case.
---@param ai? boolean If true, get a free stack for an AI flight group.
---@param case? number (Optional) Recovery case. Default current (self) case in progress.
---@param empty? boolean Return lowest stack that is completely empty.
---@return number # Lowest free stack available for the given case or nil if all Case I stacks are taken.
function AIRBOSS:_GetFreeStack_Old(ai, case, empty) end

---Get number of (airborne) units in a flight.
---@param flight? AIRBOSS.FlightGroup|number|string The flight group.
---@param onground? boolean (Optional) If true, include units on the ground. By default only airborne units are counted.
---@return number # Number of units in flight including section members.
---@return number # Number of units in flight excluding section members.
---@return number # Number of section members.
function AIRBOSS:_GetFlightUnits(flight, onground) end

---Get number of groups and units in queue, which are alive and airborne. In units we count the section members as well.
---@param queue? table The queue. Can be self.flights, self.Qmarshal or self.Qpattern.
---@param case? number (Optional) Only count flights, which are in a specific recovery case. Note that you can use case=23 for flights that are either in Case II or III. By default all groups/units regardless of case are counted.
---@return number # Total number of flight groups in queue.
---@return number # Total number of aircraft in queue since each flight group can contain multiple aircraft.
function AIRBOSS:_GetQueueInfo(queue, case) end

---Print holding queue.
---@param queue? table Queue to print.
---@param name? string Queue name.
function AIRBOSS:_PrintQueue(queue, name) end

---Create a new flight group. Usually when a flight appears in the CCA.
---@param group? GROUP Aircraft group.
---@return AIRBOSS.FlightGroup # Flight group.
function AIRBOSS:_CreateFlightGroup(group) end

---Initialize player data after birth event of player unit.
---@param unitname? string Name of the player unit.
---@return AIRBOSS.PlayerData # Player data.
function AIRBOSS:_NewPlayer(unitname) end

---Initialize player data by (re-)setting parmeters to initial values.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param step? string (Optional) New player step. Default UNDEFINED.
---@return AIRBOSS.PlayerData # Initialized player data.
function AIRBOSS:_InitPlayer(playerData, step) end

---Get flight from group in a queue.
---@param group? GROUP Group that will be removed from queue.
---@param queue? table The queue from which the group will be removed.
---@return AIRBOSS.FlightGroup # Flight group or nil.
---@return number # Queue index or nil.
function AIRBOSS:_GetFlightFromGroupInQueue(group, queue) end

---Get element in flight.
---@param unitname? string Name of the unit.
---@return AIRBOSS.FlightElement # Element of the flight or nil.
---@return number # Element index or nil.
---@return AIRBOSS.FlightGroup # The Flight group or nil
function AIRBOSS:_GetFlightElement(unitname) end

---Get element in flight.
---@param unitname? string Name of the unit.
---@return boolean # If true, element could be removed or nil otherwise.
function AIRBOSS:_RemoveFlightElement(unitname) end

---Check if a group is in a queue.
---@param queue? table The queue to check.
---@param group? GROUP The group to be checked.
---@return boolean # If true, group is in the queue. False otherwise.
function AIRBOSS:_InQueue(queue, group) end

---Remove dead flight groups from all queues.
---@return AIRBOSS.FlightGroup # Flight group.
function AIRBOSS:_RemoveDeadFlightGroups() end

---Get the lead flight group of a flight group.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group to check.
---@return AIRBOSS.FlightGroup # Flight group of the leader or flight itself if no other leader.
function AIRBOSS:_GetLeadFlight(flight) end

---Check if all elements of a flight were recovered. This also checks potential section members.
---If so, flight is removed from the queue.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group to check.
---@return boolean # If true, all elements landed.
function AIRBOSS:_CheckSectionRecovered(flight) end

---Add flight to pattern queue and set recoverd to false for all elements of the flight and its section members.
---@param flight? any
function AIRBOSS:_AddFlightToPatternQueue(flight) end

---Sets flag recovered=true for a flight element, which was successfully recovered (landed).
---@param unit? UNIT The aircraft unit that was recovered.
---@return AIRBOSS.FlightGroup # Flight group of element.
function AIRBOSS:_RecoveredElement(unit) end

---Remove a flight group from the Marshal queue. Marshal stack is collapsed, too, if flight was in the queue. Waiting flights are send to marshal.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group that will be removed from queue.
---@param nopattern? boolean If true, flight is NOT going to landing pattern.
---@return boolean # True, flight was removed or false otherwise.
---@return number # Table index of the flight in the Marshal queue.
function AIRBOSS:_RemoveFlightFromMarshalQueue(flight, nopattern) end

---Remove a flight group from a queue.
---@param queue? table The queue from which the group will be removed.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group that will be removed from queue.
---@return boolean # True, flight was in Queue and removed. False otherwise.
---@return number # Table index of removed queue element or nil.
function AIRBOSS:_RemoveFlightFromQueue(queue, flight) end

---Remove a unit and its element from a flight group (e.g. when landed) and update all queues if the whole flight group is gone.
---@param unit? UNIT The unit to be removed.
function AIRBOSS:_RemoveUnitFromFlight(unit) end

---Remove a flight, which is a member of a section, from this section.
---@param flight? AIRBOSS.FlightGroup|number|string The flight to be removed from the section
function AIRBOSS:_RemoveFlightFromSection(flight) end

---Update section if a flight is removed.
---If removed flight is member of a section, he is removed for the leaders section.
---If removed flight is the section lead, we try to find a new leader.
---@param flight? AIRBOSS.FlightGroup|number|string The flight to be removed.
function AIRBOSS:_UpdateFlightSection(flight) end

---Remove a flight from Marshal, Pattern and Waiting queues. If flight is in Marhal queue, the above stack is collapsed.
---Also set player step to undefined if applicable or remove human flight if option *completely* is true.
---@param flight? AIRBOSS.PlayerData|number|string The flight to be removed.
---@param completely? boolean If true, also remove human flight from all flights table.
function AIRBOSS:_RemoveFlight(flight, completely) end

---Check current player status.
function AIRBOSS:_CheckPlayerStatus() end

---Checks if a player is in the pattern queue and has missed a step in Case II/III approach.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_CheckMissedStepOnEntry(playerData) end

---Set time in the groove for player.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_SetTimeInGroove(playerData) end

---Get time in the groove of player.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@return number # Player's time in groove in seconds.
function AIRBOSS:_GetTimeInGroove(playerData) end

---Airboss event handler for event birth.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventBirth(EventData) end

---Airboss event handler for event land.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventRunwayTouch(EventData) end

---Airboss event handler for event that a unit shuts down its engines.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventEngineShutdown(EventData) end

---Airboss event handler for event that a unit takes off.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventTakeoff(EventData) end

---Airboss event handler for event crash.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventCrash(EventData) end

---Airboss event handler for event Ejection.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventEjection(EventData) end

---Airboss event handler for event REMOVEUNIT.
---@param EventData? EVENTDATA
function AIRBOSS:OnEventRemoveUnit(EventData) end

---Airboss event handler for event player leave unit.
---@param EventData? EVENTDATA function AIRBOSS:OnEventPlayerLeaveUnit(EventData)
function AIRBOSS:_PlayerLeft(EventData) end

---Airboss event function handling the mission end event.
---Handles the case when the mission is ended.
---@param EventData? EVENTDATA Event data.
function AIRBOSS:OnEventMissionEnd(EventData) end

---Spinning
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_Spinning(playerData) end

---Waiting outside 10 NM zone for free Marshal stack.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_Waiting(playerData) end

---Holding.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_Holding(playerData) end

---Commence approach. This step initializes the player data. Section members are also set to commence. Next step depends on recovery case:
---
---* Case 1: Initial
---* Case 2/3: Platform
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param zonecheck? boolean If true, zone is checked before player is released.
function AIRBOSS:_Commencing(playerData, zonecheck) end

---Start pattern when player enters the initial zone in case I/II recoveries.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return boolean # True if player is in the initial zone.
function AIRBOSS:_Initial(playerData) end

---Check if player is in CASE II/III approach corridor.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_CheckCorridor(playerData) end

---Platform at 5k ft for case II/III recoveries. Descent at 2000 ft/min.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_Platform(playerData) end

---Arc in turn for case II/III recoveries.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_ArcInTurn(playerData) end

---Arc out turn for case II/III recoveries.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_ArcOutTurn(playerData) end

---Dirty up and level out at 1200 ft for case III recovery.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_DirtyUp(playerData) end

---Intercept glide slop and follow ICLS, aka Bullseye for case III recovery.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return boolean # If true, player is in bullseye zone.
function AIRBOSS:_Bullseye(playerData) end

---Bolter pattern. Sends player to abeam for Case I/II or Bullseye for Case III ops.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_BolterPattern(playerData) end

---Break entry for case I/II recoveries.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_BreakEntry(playerData) end

---Break.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param part? string Part of the break.
function AIRBOSS:_Break(playerData, part) end

---Long downwind leg check.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_CheckForLongDownwind(playerData) end

---Abeam position.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_Abeam(playerData) end

---At the Ninety.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_Ninety(playerData) end

---At the Wake.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_Wake(playerData) end

---Get groove data.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return AIRBOSS.GrooveData # Groove data table.
function AIRBOSS:_GetGrooveData(playerData) end

---Turn to final.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param nocheck? boolean If true, player is not checked to be in the right position.
function AIRBOSS:_Final(playerData, nocheck) end

---In the groove.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_Groove(playerData) end

---LSO check if player needs to wave off.
---Wave off conditions are:
---
---* Glideslope error <1.2 or >1.8 degrees.
---* |Line up error| > 3 degrees.
---* AoA check but only for TOPGUN graduates.
---@param glideslopeError? number Glideslope error in degrees.
---@param lineupError? number Line up error in degrees.
---@param AoA? number Angle of attack of player aircraft.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@return boolean # If true, player should wave off!
function AIRBOSS:_CheckWaveOff(glideslopeError, lineupError, AoA, playerData) end

---Check if other aircraft are currently on the landing runway.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@return boolean # If true, we have a foul deck.
function AIRBOSS:_CheckFoulDeck(playerData) end

---Get "stern" coordinate.
---@return COORDINATE # Coordinate at the rundown of the carrier.
function AIRBOSS:_GetSternCoord() end

---Get wire from draw argument.
---@return number # Trapped wire (1-4) or 99 if no wire was trapped.
function AIRBOSS:_GetWireFromDrawArg() end

---Get wire from landing position.
---@param Lcoord? COORDINATE Landing position.
---@param dc? number Distance correction. Shift the landing coord back if dc>0 and forward if dc<0.
---@return number # Trapped wire (1-4) or 99 if no wire was trapped.
function AIRBOSS:_GetWire(Lcoord, dc) end

---Trapped? Check if in air or not after landing event.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
function AIRBOSS:_Trapped(playerData) end

---Get Initial zone for Case I or II.
---@param case? number Recovery Case.
---@return ZONE_POLYGON_BASE # Initial zone.
function AIRBOSS:_GetZoneInitial(case) end

---Get lineup groove zone.
---@return ZONE_POLYGON_BASE # Lineup zone.
function AIRBOSS:_GetZoneLineup() end

---Get groove zone.
---@param l? number (Optional) Length of the groove in NM. Default 1.5 NM.
---@param w? number (Optional) Width of the groove in NM. Default 0.25 NM.
---@param b? number (Optional) Width of the beginning in NM. Default 0.10 NM.
---@return ZONE_POLYGON_BASE # Groove zone.
function AIRBOSS:_GetZoneGroove(l, w, b) end

---Get Bullseye zone with radius 1 NM and DME 3 NM from the carrier. Radial depends on recovery case.
---@param case? number Recovery case.
---@return ZONE_RADIUS # Arc in zone.
function AIRBOSS:_GetZoneBullseye(case) end

---Get dirty up zone with radius 1 NM and DME 9 NM from the carrier. Radial depends on recovery case.
---@param case? number Recovery case.
---@return ZONE_RADIUS # Dirty up zone.
function AIRBOSS:_GetZoneDirtyUp(case) end

---Get arc out zone with radius 1 NM and DME 12 NM from the carrier. Radial depends on recovery case.
---@param case? number Recovery case.
---@return ZONE_RADIUS # Arc in zone.
function AIRBOSS:_GetZoneArcOut(case) end

---Get arc in zone with radius 1 NM and DME 14 NM from the carrier. Radial depends on recovery case.
---@param case? number Recovery case.
---@return ZONE_RADIUS # Arc in zone.
function AIRBOSS:_GetZoneArcIn(case) end

---Get platform zone with radius 1 NM and DME 19 NM from the carrier. Radial depends on recovery case.
---@param case? number Recovery case.
---@return ZONE_RADIUS # Circular platform zone.
function AIRBOSS:_GetZonePlatform(case) end

---Get approach corridor zone. Shape depends on recovery case.
---@param case? number Recovery case.
---@param l? number (Optional) Length of the zone in NM. Default 31 (=21+10) NM.
---@return ZONE_POLYGON_BASE # Box zone.
function AIRBOSS:_GetZoneCorridor(case, l) end

---Get zone of carrier. Carrier is approximated as rectangle.
---@return ZONE # Zone surrounding the carrier.
function AIRBOSS:_GetZoneCarrierBox() end

---Get zone of landing runway.
---@return ZONE_POLYGON # Zone surrounding landing runway.
function AIRBOSS:_GetZoneRunwayBox() end

---Allow for Clear to land call from LSO approaching abeam the landing spot if stable as per NATOPS 00-80T
---@return ZONE_POLYGON # Zone surrounding landing runway.
function AIRBOSS:_GetZoneAbeamLandingSpot() end

---Get zone of the primary landing spot of the USS Tarawa.
---@return ZONE_POLYGON # Zone surrounding landing runway.
function AIRBOSS:_GetZoneLandingSpot() end

---Get holding zone of player.
---@param case? number Recovery case.
---@param stack? number Marshal stack number.
---@return ZONE # Holding zone.
function AIRBOSS:_GetZoneHolding(case, stack) end

---Get zone where player are automatically commence when enter.
---@param case? number Recovery case.
---@param stack? number Stack for Case II/III as we commence from stack>=1.
---@return ZONE # Holding zone.
function AIRBOSS:_GetZoneCommence(case, stack) end

---Provide info about player status on the fly.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_AttitudeMonitor(playerData) end

---Get glide slope of aircraft unit.
---@param unit? UNIT Aircraft unit.
---@param optangle? number (Optional) Return glide slope relative to this angle, i.e. the error from the optimal glide slope ~3.5 degrees.
---@return number # Glide slope angle in degrees measured from the deck of the carrier and third wire.
function AIRBOSS:_Glideslope(unit, optangle) end

---Get glide slope of aircraft unit.
---@param unit? UNIT Aircraft unit.
---@param optangle? number (Optional) Return glide slope relative to this angle, i.e. the error from the optimal glide slope ~3.5 degrees.
---@return number # Glide slope angle in degrees measured from the deck of the carrier and third wire.
function AIRBOSS:_Glideslope2(unit, optangle) end

---Get line up of player wrt to carrier.
---@param unit? UNIT Aircraft unit.
---@param runway? boolean If true, include angled runway.
---@return number # Line up with runway heading in degrees. 0 degrees = perfect line up. +1 too far left. -1 too far right.
function AIRBOSS:_Lineup(unit, runway) end

---VNAO Edit - Added this function
---Get line up of player wrt to carrier.
---@param unit? UNIT Aircraft unit.
---@param runway? boolean If true, include angled runway.
---@return number # Line up with runway heading in degrees. 0 degrees = perfect line up. +1 too far left. -1 too far right.
function AIRBOSS:_LineupWIRE(unit, runway) end

---VNAO Edit - Added this function
---Get L/R Nozzle Position from Argument and L/R Burner Argument
---@param unit? UNIT Aircraft unit.
---@return number # Left Nozzle position argument
function AIRBOSS:_NozzleArgumentLeft(unit) end

---VNAO Edit - Added this function
---Get L/R Nozzle Position from Argument and L/R Burner Argument
---@param unit? UNIT Aircraft unit.
---@return number # Right Nozzle position argument
function AIRBOSS:_NozzleArgumentRight(unit) end

---Get altitude of aircraft wrt carrier deck. Should give zero when the aircraft touched down.
---@param unit? UNIT Aircraft unit.
---@return number # Altitude in meters wrt carrier height.
function AIRBOSS:_GetAltCarrier(unit) end

---Get optimal landing position of the aircraft. Usually between second and third wire. In case of Tarawa, Canberrra, Juan Carlos and America we take the abeam landing spot 120 ft above and 21 ft abeam the 7.5 position, for the Juan Carlos I, HMS Invincible, and HMS Hermes and Invincible it is 120 ft above and 21 ft abeam the 5 position. For CASE III it is 120ft directly above the landing spot.
---@return COORDINATE # Optimal landing coordinate.
function AIRBOSS:_GetOptLandingCoordinate() end

---VNAO Edit - dded this whole function
---Get optimal landing position of the aircraft. Usually between second and third wire. In case of Tarawa, Canberrra, Juan Carlos and America we take the abeam landing spot 120 ft above and 21 ft abeam the 7.5 position, for the Juan Carlos I, HMS Invincible, and HMS Hermes and Invincible it is 120 ft above and 21 ft abeam the 5 position. For CASE III it is 120ft directly above the landing spot.
---@return COORDINATE # Optimal landing coordinate.
function AIRBOSS:_GetOptLandingCoordinateWIRE() end

---Get landing spot on Tarawa and others.
---@return COORDINATE # Primary landing spot coordinate.
function AIRBOSS:_GetLandingSpotCoordinate() end

---Get true (or magnetic) heading of carrier.
---@param magnetic? boolean (Optional) If true, calculate magnetic heading. By default true heading is returned.
---@return number # Carrier heading in degrees.
function AIRBOSS:GetHeading(magnetic) end

---Get base recovery course (BRC) of carrier.
---The is the magnetic heading of the carrier.
---@return number # BRC in degrees.
function AIRBOSS:GetBRC() end

---Get wind direction and speed at carrier position.
---@param alt? number (Optional) Altitude ASL in meters. Default 18 m.
---@param magnetic? boolean (Optional) Direction including magnetic declination.
---@param coord? COORDINATE (Optional) Coordinate at which to get the wind. Default is current carrier position.
---@return number # Direction the wind is blowing **from** in degrees.
---@return number # Wind speed in m/s.
function AIRBOSS:GetWind(alt, magnetic, coord) end

---Get wind speed on carrier deck parallel and perpendicular to runway.
---@param alt? number (Optional) Altitude in meters. Default 18 m.
---@return number # Wind component parallel to runway im m/s.
---@return number # Wind component perpendicular to runway in m/s.
---@return number # Total wind strength in m/s.
function AIRBOSS:GetWindOnDeck(alt) end

---Get true (or magnetic) heading of carrier into the wind. This accounts for the angled runway.
---@param vdeck? number Desired wind velocity over deck in knots.
---@param magnetic? boolean (Optional) If true, calculate magnetic heading. By default true heading is returned.
---@param coord? COORDINATE (Optional) Coordinate from which heading is calculated. Default is current carrier position.
---@return number # Carrier heading in degrees.
---@return number # Carrier speed in knots to reach desired wind speed on deck.
function AIRBOSS:GetHeadingIntoWind(vdeck, magnetic, coord) end

---Get true (or magnetic) heading of carrier into the wind. This accounts for the angled runway.
---@param vdeck? number Desired wind velocity over deck in knots.
---@param magnetic? boolean (Optional) If true, calculate magnetic heading. By default true heading is returned.
---@param coord? COORDINATE (Optional) Coordinate from which heading is calculated. Default is current carrier position.
---@return number # Carrier heading in degrees.
function AIRBOSS:GetHeadingIntoWind_old(vdeck, magnetic, coord) end

---Get true (or magnetic) heading of carrier into the wind. This accounts for the angled runway.
---Implementation based on [Mags & Bambi](https://magwo.github.io/carrier-cruise/).
---@param vdeck? number Desired wind velocity over deck in knots.
---@param magnetic? boolean (Optional) If true, calculate magnetic heading. By default true heading is returned.
---@param coord? COORDINATE (Optional) Coordinate from which heading is calculated. Default is current carrier position.
---@return number # Carrier heading in degrees.
---@return number # Carrier speed in knots to reach desired wind speed on deck.
function AIRBOSS:GetHeadingIntoWind_new(vdeck, magnetic, coord) end

---Get base recovery course (BRC) when the carrier would head into the wind.
---This includes the current wind direction and accounts for the angled runway.
---@param vdeck? number Desired wind velocity over deck in knots.
---@return number # BRC into the wind in degrees.
function AIRBOSS:GetBRCintoWind(vdeck) end

---Get final bearing (FB) of carrier.
---By default, the routine returns the magnetic FB depending on the current map (Caucasus, NTTR, Normandy, Persion Gulf etc).
---The true bearing can be obtained by setting the *TrueNorth* parameter to true.
---@param magnetic? boolean If true, magnetic FB is returned.
---@return number # FB in degrees.
function AIRBOSS:GetFinalBearing(magnetic) end

---Get radial with respect to carrier BRC or FB and (optionally) holding offset.
---
---* case=1: radial=FB-180
---* case=2: radial=HDG-180 (+offset)
---* case=3: radial=FB-180 (+offset)
---@param case? number Recovery case.
---@param magnetic? boolean (Optional) If true, magnetic radial is returned. Default is true radial.
---@param offset? boolean (Optional) If true, inlcude holding offset.
---@param inverse? boolean (Optional) Return inverse, i.e. radial-180 degrees.
---@return number # Radial in degrees.
function AIRBOSS:GetRadial(case, magnetic, offset, inverse) end

---Get difference between to headings in degrees taking into accound the [0,360) periodocity.
---@param hdg1? number Heading one.
---@param hdg2? number Heading two.
---@return number # Difference between the two headings in degrees.
function AIRBOSS:_GetDeltaHeading(hdg1, hdg2) end

---Get relative heading of player wrt carrier.
---This is the angle between the direction/orientation vector of the carrier and the direction/orientation vector of the provided unit.
---Note that this is calculated in the X-Z plane, i.e. the altitude Y is not taken into account.
---@param unit? UNIT Player unit.
---@param runway? boolean (Optional) If true, return relative heading of unit wrt to angled runway of the carrier.
---@return number # Relative heading in degrees. An angle of 0 means, unit fly parallel to carrier. An angle of + or - 90 degrees means, unit flies perpendicular to carrier.
function AIRBOSS:_GetRelativeHeading(unit, runway) end

---Get relative velocity of player unit wrt to carrier
---@param unit? UNIT Player unit.
---@return number # Relative velocity in m/s.
function AIRBOSS:_GetRelativeVelocity(unit) end

---Calculate distances between carrier and aircraft unit.
---@param unit? UNIT Aircraft unit.
---@return number # Distance [m] in the direction of the orientation of the carrier.
---@return number # Distance [m] perpendicular to the orientation of the carrier.
---@return number # Distance [m] to the carrier.
---@return number # Angle [Deg] from carrier to plane. Phi=0 if the plane is directly behind the carrier, phi=90 if the plane is starboard, phi=180 if the plane is in front of the carrier.
function AIRBOSS:_GetDistances(unit) end

---Check limits for reaching next step.
---@param X? number X position of player unit.
---@param Z? number Z position of player unit.
---@param check? AIRBOSS.Checkpoint|number|string Checkpoint.
---@return boolean # If true, checkpoint condition for next step was reached.
function AIRBOSS:_CheckLimits(X, Z, check) end

---LSO advice radio call.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param glideslopeError? number Error in degrees.
---@param lineupError? number Error in degrees.
function AIRBOSS:_LSOadvice(playerData, glideslopeError, lineupError) end

---Grade player time in the groove - from turning to final until touchdown.
---
---If time
---
---* < 9 seconds: No Grade "--"
---* 9-11 seconds: Fair "(OK)"
---* 12-21 seconds: OK (15-18 is ideal)
---* 22-24 seconds: Fair "(OK)
---* > 24 seconds: No Grade "--"
---
---If you manage to be between 16.4 and and 16.6 seconds, you will even get and okay underline "\_OK\_".
---No groove time for Harrier on LHA, LHD set to Tgroove Unicorn as starting point to allow possible _OK_ 5.0.
---
---If time in the AV-8B
---
---* < 55 seconds: Fast V/STOL
---* < 75 seconds: OK V/STOL
---* > 76 Seconds: SLOW V/STOL (Early hover stop selection)
---
---If you manage to be between 60.0 and 65.0 seconds in the AV-8B, you will even get and okay underline "\_OK\_"
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return string # LSO grade for time in groove, i.e. \_OK\_, OK, (OK), --.
function AIRBOSS:_EvalGrooveTime(playerData) end

---Grade approach.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return string # LSO grade, i.g. _OK_, OK, (OK), --, etc.
---@return number # Points.
---@return string # LSO analysis of flight path.
function AIRBOSS:_LSOgrade(playerData) end

---Grade flight data.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param groovestep? string Step in the groove.
---@return string # LSO grade or empty string if flight data table is nil.
---@return number # Number of deviations from perfect flight path.
function AIRBOSS:_Flightdata2Text(playerData, groovestep) end

---Get short name of the grove step.
---@param step? string Player step.
---@param n? number (Optional) Use -1 for previous or +1 for next. Default 0.
---@return string # Shortcut name "X", "RB", "IM", "AR", "IW".
function AIRBOSS:_GS(step, n) end

---Check if a player is within the right area.
---@param X? number X distance player to carrier.
---@param Z? number Z distance player to carrier.
---@param pos? AIRBOSS.Checkpoint|number|string Position data limits.
---@return boolean # If true, approach should be aborted.
function AIRBOSS:_CheckAbort(X, Z, pos) end

---Generate a text if a player is too far from where he should be.
---@param X? number X distance player to carrier.
---@param Z? number Z distance player to carrier.
---@param posData? AIRBOSS.Checkpoint|number|string Checkpoint data.
function AIRBOSS:_TooFarOutText(X, Z, posData) end

---Pattern aborted.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param X? number X distance player to carrier.
---@param Z? number Z distance player to carrier.
---@param posData? AIRBOSS.Checkpoint|number|string Checkpoint data.
---@param patternwo? boolean (Optional) Pattern wave off.
function AIRBOSS:_AbortPattern(playerData, X, Z, posData, patternwo) end

---Display hint to player.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param delay? number (Optional) Delay before playing sound messages. Default 0 sec.
---@param soundoff? boolean If true, don't play and sound hint.
function AIRBOSS:_PlayerHint(playerData, delay, soundoff) end

---Display hint for flight students about the (next) step. Message is displayed after one second.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param step? string Step for which hint is given.
function AIRBOSS:_StepHint(playerData, step) end

---Evaluate player's altitude at checkpoint.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param altopt? number Optimal altitude in meters.
---@return string # Feedback text.
---@return string # Debriefing text.
---@return AIRBOSS.RadioCall # Radio call.
function AIRBOSS:_AltitudeCheck(playerData, altopt) end

---Score for correct AoA.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param optaoa? number Optimal AoA.
---@return string # Feedback message text or easy and normal difficulty level or nil for hard.
---@return string # Debriefing text.
---@return AIRBOSS.RadioCall # Radio call.
function AIRBOSS:_AoACheck(playerData, optaoa) end

---Evaluate player's speed.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param speedopt? number Optimal speed in m/s.
---@return string # Feedback text.
---@return string # Debriefing text.
---@return AIRBOSS.RadioCall # Radio call.
function AIRBOSS:_SpeedCheck(playerData, speedopt) end

---Evaluate player's distance to the boat at checkpoint.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param optdist? number Optimal distance in meters.
---@return string # Feedback message text.
---@return string # Debriefing text.
---@return AIRBOSS.RadioCall # Distance radio call. Not implemented yet.
function AIRBOSS:_DistanceCheck(playerData, optdist) end

---Append text to debriefing.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param hint? string Debrief text of this step.
---@param step? string (Optional) Current step in the pattern. Default from playerData.
function AIRBOSS:_AddToDebrief(playerData, hint, step) end

---Debrief player and set next step.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
function AIRBOSS:_Debrief(playerData) end

---Check for possible collisions between two coordinates.
---@param coordto? COORDINATE Coordinate to which the collision is check.
---@param coordfrom? COORDINATE Coordinate from which the collision is check.
---@return boolean # If true, surface type ahead is not deep water.
---@return number # Max free distance in meters.
function AIRBOSS:_CheckCollisionCoord(coordto, coordfrom) end

---Check Collision.
---@param fromcoord? COORDINATE (Optional) Coordinate from which the path to the next WP is calculated. Default current carrier position.
---@return boolean # If true, surface type ahead is not deep water.
function AIRBOSS:_CheckFreePathToNextWP(fromcoord) end

---Find free path to the next waypoint.
function AIRBOSS:_Pathfinder() end

---Carrier resumes the route at its next waypoint.
---@param gotocoord? COORDINATE (Optional) First goto this coordinate before resuming route.
---@return AIRBOSS # self
function AIRBOSS:CarrierResumeRoute(gotocoord) end

---Let the carrier make a detour to a given point. When it reaches the point, it will resume its normal route.
---@param coord? COORDINATE Coordinate of the detour.
---@param speed? number (Optional) Speed in knots. Default is current carrier velocity.
---@param uturn? boolean (Optional) If true, carrier will go back to where it came from before it resumes its route to the next waypoint.
---@param uspeed? number (Optional) Speed in knots after U-turn. Default is same as before.
---@param tcoord? COORDINATE Additional coordinate to make turn smoother.
---@return AIRBOSS # self
function AIRBOSS:CarrierDetour(coord, speed, uturn, uspeed, tcoord) end

---Let the carrier turn into the wind.
---@param time? number Time in seconds.
---@param vdeck? number Speed on deck m/s. Carrier will
---@param uturn? boolean Make U-turn and go back to initial after downwind leg.
---@return AIRBOSS # self
function AIRBOSS:CarrierTurnIntoWind(time, vdeck, uturn) end

---Get next waypoint of the carrier.
---@return COORDINATE # Coordinate of the next waypoint.
---@return number # Number of waypoint.
function AIRBOSS:_GetNextWaypoint() end

---Initialize Mission Editor waypoints.
---@return AIRBOSS # self
function AIRBOSS:_InitWaypoints() end

---Patrol carrier.
---@param n? number Next waypoint number.
---@return AIRBOSS # self
function AIRBOSS:_PatrolRoute(n) end

---Estimated the carrier position at some point in the future given the current waypoints and speeds.
---@return time # ETA abs. time in seconds.
function AIRBOSS:_GetETAatNextWP() end

---Check if carrier is turning. If turning started or stopped, we inform the players via radio message.
function AIRBOSS:_CheckCarrierTurning() end

---Check if heading or position of carrier have changed significantly.
function AIRBOSS:_CheckPatternUpdate() end

---Function called when a group is passing a waypoint.
---@param group? GROUP Group that passed the waypoint
---@param airboss? AIRBOSS Airboss object.
---@param i? number Waypoint number that has been reached.
---@param final? number Final waypoint number.
function AIRBOSS._PassingWaypoint(group, airboss, i, final) end

---Carrier Strike Group resumes the route of the waypoints defined in the mission editor.
---@param group? GROUP Carrier Strike Group that passed the waypoint.
---@param airboss? AIRBOSS Airboss object.
---@param gotocoord? COORDINATE Go to coordinate before route is resumed.
function AIRBOSS._ResumeRoute(group, airboss, gotocoord) end

---Function called when a group has reached the holding zone.
---@param group? GROUP Group that reached the holding zone.
---@param airboss? AIRBOSS Airboss object.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group that has reached the holding zone.
function AIRBOSS._ReachedHoldingZone(group, airboss, flight) end

---Function called when a group should be send to the Marshal stack. If stack is full, it is send to wait.
---@param group? GROUP Group that reached the holding zone.
---@param airboss? AIRBOSS Airboss object.
---@param flight? AIRBOSS.FlightGroup|number|string Flight group that has reached the holding zone.
function AIRBOSS._TaskFunctionMarshalAI(group, airboss, flight) end

---Get aircraft nickname.
---@param actype? string Aircraft type name.
---@return string # Aircraft nickname. E.g. "Hornet" for the F/A-18C or "Tomcat" For the F-14A.
function AIRBOSS:_GetACNickname(actype) end

---Get onboard number of player or client.
---@param group? GROUP Aircraft group.
---@return string # Onboard number as string.
function AIRBOSS:_GetOnboardNumberPlayer(group) end

---Get onboard numbers of all units in a group.
---@param group? GROUP Aircraft group.
---@param playeronly? boolean If true, return the onboard number for player or client skill units.
---@return table # Table of onboard numbers.
function AIRBOSS:_GetOnboardNumbers(group, playeronly) end

---Get Tower frequency of carrier.
function AIRBOSS:_GetTowerFrequency() end

---Get error margin depending on player skill.
---
---* Flight students: 10% and 20%
---* Naval Aviators: 5% and 10%
---* TOPGUN Graduates: 2.5% and 5%
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@return number # Error margin for still being okay.
---@return number # Error margin for really sucking.
function AIRBOSS:_GetGoodBadScore(playerData) end

---Check whether an aircraft type name is any F-14 Tomcat variant.
---Central predicate so that adding a new Tomcat variant only requires editing
---this function and the AIRBOSS.AircraftCarrier enum.
---@param actype? string Aircraft type name, e.g. from `unit:GetTypeName()` or `playerData.actype`.
---@param IncludeAI? boolean If true, also match the AI-only F-14A (AIRBOSS.AircraftCarrier.F14A_AI).
---@return boolean # If true, actype is an F-14 variant.
function AIRBOSS:_IsTomcat(actype, IncludeAI) end

---Check if aircraft is capable of landing on this aircraft carrier.
---@param unit? UNIT Aircraft unit. (Will also work with groups as given parameter.)
---@return boolean # If true, aircraft can land on a carrier.
function AIRBOSS:_IsCarrierAircraft(unit) end

---Checks if a human player sits in the unit.
---@param unit? UNIT Aircraft unit.
---@return boolean # If true, human player inside the unit.
function AIRBOSS:_IsHumanUnit(unit) end

---Checks if a group has a human player.
---@param group? GROUP Aircraft group.
---@return boolean # If true, human player inside group.
function AIRBOSS:_IsHuman(group) end

---Get fuel state in pounds.
---@param unit? UNIT The unit for which the mass is determined.
---@return number # Fuel state in pounds.
function AIRBOSS:_GetFuelState(unit) end

---Convert altitude from meters to angels (thousands of feet).
---@param alt? any
---@return number # Altitude in Anglels = thousands of feet using math.floor().
function AIRBOSS:_GetAngels(alt) end

---Get unit masses especially fuel from DCS descriptor values.
---@param unit? UNIT The unit for which the mass is determined.
---@return number # Mass of fuel in kg.
---@return number # Empty weight of unit in kg.
---@return number # Max weight of unit in kg.
---@return number # Max cargo weight in kg.
function AIRBOSS:_GetUnitMasses(unit) end

---Get player data from unit object
---@param unit? UNIT Unit in question.
---@return AIRBOSS.PlayerData # Player data or nil if not player with this name or unit exists.
function AIRBOSS:_GetPlayerDataUnit(unit) end

---Get player data from group object.
---@param group? GROUP Group in question.
---@return AIRBOSS.PlayerData # Player data or nil if not player with this name or unit exists.
function AIRBOSS:_GetPlayerDataGroup(group) end

---Returns the unit of a player and the player name from the self.players table if it exists.
---@param _unitName? string Name of the player unit.
---@return UNIT # Unit of player or nil.
---@return string # Name of player or nil.
function AIRBOSS:_GetPlayerUnit(_unitName) end

---Returns the unit of a player and the player name. If the unit does not belong to a player, nil is returned.
---@param _unitName? string Name of the player unit.
---@return UNIT # Unit of player or nil.
---@return string # Name of the player or nil.
function AIRBOSS:_GetPlayerUnitAndName(_unitName) end

---Get carrier coalition.
---@return number # Coalition side of carrier.
function AIRBOSS:GetCoalition() end

---Get carrier coordinate.
---@return COORDINATE # Carrier coordinate.
function AIRBOSS:GetCoordinate() end

---Get carrier coordinate.
---@return COORDINATE # Carrier coordinate.
function AIRBOSS:GetCoord() end

---Get static weather of this mission from env.mission.weather.
function AIRBOSS:_GetStaticWeather() end

---Function called by DCS timer. Unused.
---@param param? table Parameters.
---@param time? number Time.
function AIRBOSS._CheckRadioQueueT(param, time) end

---Check radio queue for transmissions to be broadcasted.
---@param radioqueue? table The radio queue.
---@param name? string Name of the queue.
function AIRBOSS:_CheckRadioQueue(radioqueue, name) end

---Add Radio transmission to radio queue.
---@param radio? AIRBOSS.Radio|number|string Radio sending the transmission.
---@param call? AIRBOSS.RadioCall|number|string Radio sound files and subtitles.
---@param loud? boolean If true, play loud sound file version.
---@param delay? number Delay in seconds, before the message is broadcasted.
---@param interval? number Interval in seconds after the last sound has been played.
---@param click? boolean If true, play radio click at the end.
---@param pilotcall? boolean If true, it's a pilot call.
function AIRBOSS:RadioTransmission(radio, call, loud, delay, interval, click, pilotcall) end

---Set SRS voice for the pilot calls.
---@param Voice? string (Optional) SRS specific voice
---@param Gender? string (Optional) SRS specific gender
---@param Culture? string (Optional) SRS specific culture
---@return AIRBOSS # self
function AIRBOSS:SetSRSPilotVoice(Voice, Gender, Culture) end

---Check if a call needs a subtitle because the complete voice overs are not available.
---@param call? AIRBOSS.RadioCall|number|string Radio sound files and subtitles.
---@return boolean # If true, call needs a subtitle.
function AIRBOSS:_NeedsSubtitle(call) end

---Broadcast radio message.
---@param radio? AIRBOSS.Radio|number|string Radio sending transmission.
---@param call? AIRBOSS.RadioCall|number|string Radio sound files and subtitles.
---@param loud? boolean Play loud version of file.
function AIRBOSS:Broadcast(radio, call, loud) end

---Player user sound to player if he is inside the CCA.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param radio? AIRBOSS.Radio|number|string The radio used for transmission.
---@param call? AIRBOSS.RadioCall|number|string Radio sound files and subtitles.
---@param loud? boolean If true, play loud sound file version.
---@param delay? number Delay in seconds, before the message is broadcasted.
function AIRBOSS:Sound2Player(playerData, radio, call, loud, delay) end

---Create radio subtitle from radio call.
---@param radio? AIRBOSS.Radio|number|string The radio used for transmission.
---@param call? AIRBOSS.RadioCall|number|string Radio sound files and subtitles.
---@param loud? boolean If true, append "!" else ".".
---@return string # Subtitle to be displayed.
function AIRBOSS:_RadioSubtitle(radio, call, loud) end

---Get full file name for radio call.
---@param call? AIRBOSS.RadioCall|number|string Radio sound files and subtitles.
---@param loud? boolean Use loud version of file if available.
---@param channel? string Radio channel alias "LSO" or "LSOCall", "MARSHAL" or "MarshalCall".
---@return string # The file name of the radio sound.
function AIRBOSS:_RadioFilename(call, loud, channel) end

---Format text into SRS friendly string
---@param text? string
---@return string # text
function AIRBOSS:_GetNiceSRSText(text) end

---Send text message to player client.
---Message format will be "SENDER: RECCEIVER, MESSAGE".
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param message? string The message to send.
---@param sender? string (Optional) The person who sends the message or nil. Defaults to nil.
---@param receiver? string (Optional) The person who receives the message. Default player's onboard number. Set to "" for no receiver.
---@param duration? number (Optional) Display message duration. Default 10 seconds.
---@param clear? boolean I(Optional) f true, clear screen from previous messages. Defaults to false.
---@param delay? number (Optional) Delay in seconds, before the message is displayed.
function AIRBOSS:MessageToPlayer(playerData, message, sender, receiver, duration, clear, delay) end

---Send text message to all players in the pattern queue.
---Message format will be "SENDER: RECCEIVER, MESSAGE".
---@param message? string The message to send.
---@param sender? string (Optional) The person who sends the message or nil. Defaults to "LSO".
---@param receiver? string (Optional) The person who receives the message. Default player's onboard number. Set to "" for no receiver.
---@param duration? number (Optional) Display message duration. Default 10 seconds.
---@param clear? boolean (Optional) If true, clear screen from previous messages.
---@param delay? number (Optional) Delay in seconds, before the message is displayed.
function AIRBOSS:MessageToPattern(message, sender, receiver, duration, clear, delay) end

---Send text message to all players in the marshal queue.
---Message format will be "SENDER: RECCEIVER, MESSAGE".
---@param message? string The message to send.
---@param sender? string (Optional) The person who sends the message or nil. Defaults to "Marshal".
---@param receiver? string (Optional) The person who receives the message. Default player's onboard number. Set to "" for no receiver.
---@param duration? number (Optional) Display message duration. Default 10 seconds.
---@param clear? boolean (Optional) If true, clear screen from previous messages.
---@param delay? number (Optional) Delay in seconds, before the message is displayed.
function AIRBOSS:MessageToMarshal(message, sender, receiver, duration, clear, delay) end

---Generate a new radio call (deepcopy) from an existing default call.
---@param call? AIRBOSS.RadioCall|number|string Radio call to be enhanced.
---@param sender? string (Optional) Sender of the message. Default is the radio alias.
---@param subtitle? string (Optional) Subtitle of the message. Default from original radio call. Use "" for no subtitle.
---@param subduration? number (Optional) Time in seconds the subtitle is displayed. Default 10 seconds.
---@param modexreceiver? string (Optional) Onboard number of the receiver or nil.
---@param modexsender? string (Optional) Onboard number of the sender or nil.
function AIRBOSS:_NewRadioCall(call, sender, subtitle, subduration, modexreceiver, modexsender) end

---Get unit from which we want to transmit a radio message. This has to be an aircraft for subtitles to work.
---@param radio? AIRBOSS.Radio|number|string Airboss radio data.
---@return UNIT # Sending aircraft unit or nil if was not setup, is not an aircraft or is not alive.
function AIRBOSS:_GetRadioSender(radio) end

---Check if text is an onboard number of a flight.
---@param text? string Text to check.
---@return boolean # If true, text is an onboard number of a flight.
function AIRBOSS:_IsOnboard(text) end

---Convert a number (as string) into an outsound and play it to a player group. E.g. for board number or headings.
---@param playerData? AIRBOSS.PlayerData|number|string Player data.
---@param sender? string Who is sending the call, either "LSO" or "MARSHAL".
---@param number? string Number string, e.g. "032" or "183".
---@param delay? number Delay before transmission in seconds.
---@return number # Duration of the call in seconds.
function AIRBOSS:_Number2Sound(playerData, sender, number, delay) end

---Convert a number (as string) into a radio message.
---E.g. for board number or headings.
---@param radio? AIRBOSS.Radio|number|string Radio used for transmission.
---@param number? string Number string, e.g. "032" or "183".
---@param delay? number Delay before transmission in seconds.
---@param interval? number Interval between the next call.
---@param pilotcall? boolean If true, use pilot sound files.
---@return number # Duration of the call in seconds.
function AIRBOSS:_Number2Radio(radio, number, delay, interval, pilotcall) end

---Aircraft request marshal (Inbound call both for players and AI).
---@param unit? any
---@param modex? string Tail number.
---@return UNIT # Unit of player or nil.
function AIRBOSS:_MarshallInboundCall(unit, modex) end

---Aircraft commencing call (both for players and AI).
---@param unit? any
---@param modex? string Tail number.
---@return UNIT # Unit of player or nil.
function AIRBOSS:_CommencingCall(unit, modex) end

---AI aircraft calls the ball.
---@param modex? string Tail number.
---@param nickname? string Aircraft nickname.
---@param fuelstate? number Aircraft fuel state in thouthands of pounds.
function AIRBOSS:_LSOCallAircraftBall(modex, nickname, fuelstate) end

---AI is bingo and goes to the recovery tanker.
---@param modex? string Tail number.
function AIRBOSS:_MarshalCallGasAtTanker(modex) end

---AI is bingo and goes to the divert field.
---@param modex? string Tail number.
---@param divertname? string Name of the divert field.
function AIRBOSS:_MarshalCallGasAtDivert(modex, divertname) end

---Inform everyone that recovery ops are stopped and deck is closed.
---@param case? number Recovery case.
function AIRBOSS:_MarshalCallRecoveryStopped(case) end

---Inform everyone that recovery is paused and will resume at a certain time.
function AIRBOSS:_MarshalCallRecoveryPausedUntilFurtherNotice() end

---Inform everyone that recovery is paused and will resume at a certain time.
---@param clock? string Time.
function AIRBOSS:_MarshalCallRecoveryPausedResumedAt(clock) end

---Inform flight that he is cleared for recovery.
---@param modex? string Tail number.
---@param case? number Recovery case.
function AIRBOSS:_MarshalCallClearedForRecovery(modex, case) end

---Inform everyone that recovery is resumed after pause.
function AIRBOSS:_MarshalCallResumeRecovery() end

---Inform everyone about new final bearing.
---@param FB? number Final Bearing in degrees.
function AIRBOSS:_MarshalCallNewFinalBearing(FB) end

---Compile a radio call when Marshal tells a flight the holding altitude.
---@param hdg? number Heading in degrees.
function AIRBOSS:_MarshalCallCarrierTurnTo(hdg) end

---Compile a radio call when Marshal tells a flight the holding altitude.
---@param modex? string Tail number.
---@param nwaiting? number Number of flights already waiting.
function AIRBOSS:_MarshalCallStackFull(modex, nwaiting) end

---Compile a radio call when Marshal tells a flight the holding altitude.
---@param case? any
function AIRBOSS:_MarshalCallRecoveryStart(case) end

---Compile a radio call when Marshal tells a flight the holding altitude.
---@param modex? string Tail number.
---@param case? number Recovery case.
---@param brc? number Base recovery course.
---@param altitude? number Holding altitude.
---@param charlie? string Charlie Time estimate.
---@param qfe? number Alitmeter inHg.
function AIRBOSS:_MarshalCallArrived(modex, case, brc, altitude, charlie, qfe) end

---Add menu commands for player.
---@param _unitName? string Name of player unit.
function AIRBOSS:_AddF10Commands(_unitName) end

---Reset player status. Player is removed from all queues and its status is set to undefined.
---@param _unitName? string Name fo the player unit.
---@param case? number Recovery case.
function AIRBOSS:_SkipperStartRecovery(_unitName, case) end

---Skipper Stop recovery function.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_SkipperStopRecovery(_unitName) end

---Skipper set recovery offset angle.
---@param _unitName? string Name fo the player unit.
---@param offset? number Recovery holding offset angle in degrees for Case II/III.
function AIRBOSS:_SkipperRecoveryOffset(_unitName, offset) end

---Skipper set recovery time.
---@param _unitName? string Name fo the player unit.
---@param time? number Recovery time in minutes.
function AIRBOSS:_SkipperRecoveryTime(_unitName, time) end

---Skipper set recovery speed.
---@param _unitName? string Name fo the player unit.
---@param speed? number Recovery speed in knots.
function AIRBOSS:_SkipperRecoverySpeed(_unitName, speed) end

---Skipper set recovery speed.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_SkipperRecoveryUturn(_unitName) end

---Reset player status. Player is removed from all queues and its status is set to undefined.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_ResetPlayerStatus(_unitName) end

---Request marshal.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_RequestMarshal(_unitName) end

---Request emergency landing.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_RequestEmergency(_unitName) end

---Request spinning.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_RequestSpinning(_unitName) end

---Request to commence landing approach.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_RequestCommence(_unitName) end

---Player requests refueling.
---@param _unitName? string Name of the player unit.
function AIRBOSS:_RequestRefueling(_unitName) end

---Remove a member from the player's section.
---@param playerData? AIRBOSS.PlayerData|number|string Player
---@param sectionmember? AIRBOSS.PlayerData|number|string The section member to be removed.
---@return boolean # If true, flight was a section member and could be removed. False otherwise.
function AIRBOSS:_RemoveSectionMember(playerData, sectionmember) end

---Set all flights within maxsectiondistance meters to be part of my section (default: 100 meters).
---@param _unitName? string Name of the player unit.
function AIRBOSS:_SetSection(_unitName) end

---Display top 10 player scores.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_DisplayScoreBoard(_unitName) end

---Display top 10 player scores.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_DisplayPlayerGrades(_unitName) end

---Display last debriefing.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_DisplayDebriefing(_unitName) end

---Display marshal or pattern queue.
---@param _unitname? string Name of the player unit.
---@param qname? string Name of the queue.
function AIRBOSS:_DisplayQueue(_unitname, qname) end

---Report information about carrier.
---@param _unitname? string Name of the player unit.
function AIRBOSS:_DisplayCarrierInfo(_unitname) end

---Report weather conditions at the carrier location. Temperature, QFE pressure and wind data.
---@param _unitname? string Name of the player unit.
function AIRBOSS:_DisplayCarrierWeather(_unitname) end

---Set difficulty level.
---@param _unitname? string Name of the player unit.
---@param difficulty? AIRBOSS.Difficulty|number|string Difficulty level.
function AIRBOSS:_SetDifficulty(_unitname, difficulty) end

---Turn player's aircraft attitude display on or off.
---@param _unitname? string Name of the player unit.
function AIRBOSS:_SetHintsOnOff(_unitname) end

---Turn player's aircraft attitude display on or off.
---@param _unitname? string Name of the player unit.
function AIRBOSS:_DisplayAttitude(_unitname) end

---Turn radio subtitles of player on or off.
---@param _unitname? string Name of the player unit.
function AIRBOSS:_SubtitlesOnOff(_unitname) end

---Turn radio subtitles of player on or off.
---@param _unitname? string Name of the player unit.
function AIRBOSS:_TrapsheetOnOff(_unitname) end

---Display player status.
---@param _unitName? string Name of the player unit.
function AIRBOSS:_DisplayPlayerStatus(_unitName) end

---Mark current marshal zone of player by either smoke or flares.
---@param _unitName? string Name of the player unit.
---@param flare? boolean If true, flare the zone. If false, smoke the zone.
function AIRBOSS:_MarkMarshalZone(_unitName, flare) end

---Mark CASE I or II/II zones by either smoke or flares.
---@param _unitName? string Name of the player unit.
---@param flare? boolean If true, flare the zone. If false, smoke the zone.
function AIRBOSS:_MarkCaseZones(_unitName, flare) end

---LSO radio check. Will broadcase LSO message at given LSO frequency.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_LSORadioCheck(_unitName) end

---Marshal radio check. Will broadcase Marshal message at given Marshal frequency.
---@param _unitName? string Name fo the player unit.
function AIRBOSS:_MarshalRadioCheck(_unitName) end

---Save trapsheet data.
---@param playerData? AIRBOSS.PlayerData|number|string Player data table.
---@param grade? AIRBOSS.LSOgrade|number|string LSO grad data.
function AIRBOSS:_SaveTrapSheet(playerData, grade) end

---On before "Save" event. Checks if io and lfs are available.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
function AIRBOSS:onbeforeSave(From, Event, To, path, filename) end

---On after "Save" event. Player data is saved to file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is saved. If nil, file is saved in the DCS root installtion directory or your "Saved Games" folder if lfs was desanitized.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
function AIRBOSS:onafterSave(From, Event, To, path, filename) end

---On before "Load" event. Checks if the file that the player grades from exists.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is loaded from. Default is the DCS installation root directory or your "Saved Games\\DCS" folder if lfs was desanizized.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
function AIRBOSS:onbeforeLoad(From, Event, To, path, filename) end

---On after "Load" event. Loads grades of all players from file.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string (Optional) Path where the file is loaded from. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if lfs was desanizied.
---@param filename? string (Optional) File name for saving the player grades. Default is "AIRBOSS-<ALIAS>_LSOgrades.csv".
function AIRBOSS:onafterLoad(From, Event, To, path, filename) end

---On after "LSOGrade" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param playerData? AIRBOSS.PlayerData|number|string Player Data.
---@param grade? AIRBOSS.LSOgrade|number|string LSO grade.
function AIRBOSS:onafterLSOGrade(From, Event, To, playerData, grade) end

---Triggers the FSM event "Start" that starts the airboss. Initializes parameters and starts event handlers.
function AIRBOSS:Start() end

---Triggers the FSM event "Start" that starts the airboss after a delay. Initializes parameters and starts event handlers.
---@param delay? number Delay in seconds.
function AIRBOSS:__Start(delay) end

---On after "Start" user function. Called when the AIRBOSS FSM is started.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:OnAfterStart(From, Event, To) end

---Triggers the FSM event "Idle" that puts the carrier into state "Idle" where no recoveries are carried out.
function AIRBOSS:Idle() end

---Triggers the FSM delayed event "Idle" that puts the carrier into state "Idle" where no recoveries are carried out.
---@param delay? number Delay in seconds.
function AIRBOSS:__Idle(delay) end

---Triggers the FSM event "RecoveryStart" that starts the recovery of aircraft. Marshalling aircraft are send to the landing pattern.
---@param Case? number Recovery case (1, 2 or 3) that is started.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:RecoveryStart(Case, Offset) end

---Triggers the FSM delayed event "RecoveryStart" that starts the recovery of aircraft. Marshalling aircraft are send to the landing pattern.
---@param delay? number Delay in seconds.
---@param Case? number Recovery case (1, 2 or 3) that is started.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:__RecoveryStart(delay, Case, Offset) end

---On after "RecoveryStart" user function. Called when recovery of aircraft is started and carrier switches to state "Recovering".
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param Case? number The recovery case (1, 2 or 3) to start.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:OnAfterRecoveryStart(From, Event, To, Case, Offset) end

---Triggers the FSM event "RecoveryStop" that stops the recovery of aircraft.
function AIRBOSS:RecoveryStop() end

---Triggers the FSM delayed event "RecoveryStop" that stops the recovery of aircraft.
---@param delay? number Delay in seconds.
function AIRBOSS:__RecoveryStop(delay) end

---On after "RecoveryStop" user function. Called when recovery of aircraft is stopped.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function AIRBOSS:OnAfterRecoveryStop(From, Event, To) end

---Triggers the FSM event "RecoveryPause" that pauses the recovery of aircraft.
---@param duration? number Duration of pause in seconds. After that recovery is automatically resumed.
function AIRBOSS:RecoveryPause(duration) end

---Triggers the FSM delayed event "RecoveryPause" that pauses the recovery of aircraft.
---@param delay? number Delay in seconds.
---@param duration? number Duration of pause in seconds. After that recovery is automatically resumed.
function AIRBOSS:__RecoveryPause(delay, duration) end

---Triggers the FSM event "RecoveryUnpause" that resumes the recovery of aircraft if it was paused.
function AIRBOSS:RecoveryUnpause() end

---Triggers the FSM delayed event "RecoveryUnpause" that resumes the recovery of aircraft if it was paused.
---@param delay? number Delay in seconds.
function AIRBOSS:__RecoveryUnpause(delay) end

---Triggers the FSM event "RecoveryCase" that switches the aircraft recovery case.
---@param Case? number The new recovery case (1, 2 or 3).
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:RecoveryCase(Case, Offset) end

---Triggers the delayed FSM event "RecoveryCase" that sets the used aircraft recovery case.
---@param delay? number Delay in seconds.
---@param Case? number The new recovery case (1, 2 or 3).
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:__RecoveryCase(delay, Case, Offset) end

---Triggers the FSM event "PassingWaypoint". Called when the carrier passes a waypoint.
---@param waypoint? number Number of waypoint.
function AIRBOSS:PassingWaypoint(waypoint) end

---Triggers the FSM delayed event "PassingWaypoint". Called when the carrier passes a waypoint.
---@param delay? number Delay in seconds.
---@param Case? number Recovery case (1, 2 or 3) that is started.
---@param Offset? number Holding pattern offset angle in degrees for CASE II/III recoveries.
function AIRBOSS:__PassingWaypoint(delay, Case, Offset) end

---On after "PassingWaypoint" user function. Called when the carrier passes a waypoint of its route.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param waypoint? number Number of waypoint.
function AIRBOSS:OnAfterPassingWaypoint(From, Event, To, waypoint) end

---Triggers the FSM event "Save" that saved the player scores to a file.
---@param path? string Path where the file is saved. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:Save(path, filename) end

---Triggers the FSM delayed event "Save" that saved the player scores to a file.
---@param delay? number Delay in seconds.
---@param path? string Path where the file is saved. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:__Save(delay, path, filename) end

---On after "Save" event user function. Called when the player scores are saved to disk.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is saved. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:OnAfterSave(From, Event, To, path, filename) end

---Triggers the FSM event "Load" that loads the player scores from a file. AIRBOSS FSM must **not** be started at this point.
---@param path? string Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is AIRBOSS-<ALIAS>_LSOgrades.csv.
function AIRBOSS:Load(path, filename) end

---Triggers the FSM delayed event "Load" that loads the player scores from a file. AIRBOSS FSM must **not** be started at this point.
---@param delay? number Delay in seconds.
---@param path? string Path where the file is located. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:__Load(delay, path, filename) end

---On after "Load" event user function. Called when the player scores are loaded from disk.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param path? string Path where the file is located. Default is the DCS installation root directory or your "Saved Games\DCS" folder if lfs was desanitized.
---@param filename? string (Optional) File name. Default is AIRBOSS-*ALIAS*_LSOgrades.csv.
function AIRBOSS:OnAfterLoad(From, Event, To, path, filename) end

---Triggers the FSM event "LSOGrade". Called when the LSO grades a player
---@param playerData? AIRBOSS.PlayerData|number|string Player Data.
---@param grade? AIRBOSS.LSOgrade|number|string LSO grade.
function AIRBOSS:LSOGrade(playerData, grade) end

---Triggers the FSM event "LSOGrade". Delayed called when the LSO grades a player.
---@param delay? number Delay in seconds.
---@param playerData? AIRBOSS.PlayerData|number|string Player Data.
---@param grade? AIRBOSS.LSOgrade|number|string LSO grade.
function AIRBOSS:__LSOGrade(delay, playerData, grade) end

---On after "LSOGrade" user function. Called when the carrier passes a waypoint of its route.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param playerData? AIRBOSS.PlayerData|number|string Player Data.
---@param grade? AIRBOSS.LSOgrade|number|string LSO grade.
function AIRBOSS:OnAfterLSOGrade(From, Event, To, playerData, grade) end

---Triggers the FSM event "Marshal". Called when a flight is send to the Marshal stack.
---@param flight? AIRBOSS.FlightGroup|number|string The flight group data.
function AIRBOSS:Marshal(flight) end

---Triggers the FSM event "Marshal". Delayed call when a flight is send to the Marshal stack.
---@param delay? number Delay in seconds.
---@param flight? AIRBOSS.FlightGroup|number|string The flight group data.
function AIRBOSS:__Marshal(delay, flight) end

---On after "Marshal" user function. Called when a flight is send to the Marshal stack.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
---@param flight? AIRBOSS.FlightGroup|number|string The flight group data.
function AIRBOSS:OnAfterMarshal(From, Event, To, flight) end

---Triggers the FSM event "Stop" that stops the airboss. Event handlers are stopped.
function AIRBOSS:Stop() end

---Triggers the FSM event "Stop" that stops the airboss after a delay. Event handlers are stopped.
---@param delay? number Delay in seconds.
function AIRBOSS:__Stop(delay) end
