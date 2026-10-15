---@meta

---@class TARS.Snapshot
---@field unit UNIT MOOSE UNIT wrapper or STATIC wrapper.
---@field dcsObj Object Raw DCS object reference.
---@field category number `Object.Category.*` of the detected object.
---@field type string DCS type name.
---@field name string DCS unit name (registry key).
---@field point Vec3 World position at detection time.
---@field time number Mission time of the snapshot.
---@field groupID number Group ID (units only).
---@field groupCat number Group category (units only).
---@field coa number Coalition side (units only).
---@field ammo table Ammo table at detection (units only).
---@field life number Health 0-100 at detection (units only).
---@field playername string Player name who captured the data.

---@class TARS.MenuData
---@field menuHandle MENU_GROUP Root sub-menu. Call `:Remove()` to destroy.
---@field itemValidate MENU_GROUP_COMMAND "TARS validation" — present in GROUND_NEW; removed after validation.
---@field itemInfo MENU_GROUP_COMMAND "TARS capture config" — always present.
---@field itemStart MENU_GROUP_COMMAND "Start filming" — added on takeoff.
---@field itemStb MENU_GROUP_COMMAND "STB & Resume" — added on takeoff.
---@field itemStop MENU_GROUP_COMMAND "Stop filming" — added on takeoff.
---@field approved boolean `true` after successful ground validation.
---@field unitName string DCS unit name.
---@field groupID number Numeric group ID.
---@field playerName string Player display name.

---@class TARS.PlatformParams
---@field minAlt number Minimum AGL altitude (m) for valid detections.
---@field maxAlt number Maximum AGL altitude (m) for valid detections.
---@field maxRoll number Maximum bank angle (degrees) — camera must be level.
---@field maxPitch number Maximum pitch angle (degrees) — camera must be level.
---@field fov number Camera half-angle FOV (degrees). Not used for visual-recon helis.
---@field duration number Remaining expositions (shots) for this sortie.
---@field offset number Forward look-ahead (radians).
---@field name string Human-readable label in player messages.
---@field minRange number Detection radius (m) at `minAlt` — visual-recon helis only.
---@field optimalAlt number Optimal AGL (m) — triggers the dual-cone model.
---@field optimalRange number Detection radius (m) at `optimalAlt`.
---@field maxRange number Detection radius (m) at `maxAlt`.
---@field overlap number Optional frame overlap 0–1 (default 0.5). Used by `_CalcInterval`.

---@class TARS_SESSION : BASE
---@field debug boolean Enable debugging in TARS_SESSION.
---@field debugunitsearch boolean Enable Target Search Debug.
---@field unit UNIT The MOOSE UNIT object for the recon aircraft.
---@field lid string Log-line prefix shown in Moose.log entries.
---@field vec3 Vec3 World position snapshot taken at session creation.
---@field coa number Coalition side (1 = Red, 2 = Blue).
---@field type string DCS type name of the aircraft (key into `TARS.parameters`).
---@field group GROUP MOOSE GROUP the aircraft belongs to.
---@field groupID number Numeric group ID.
---@field objectName string DCS unit name — used as the registry key.
---@field playerName string Human-readable player name as shown in the scoreboard.
---@field playerID number Numeric DCS unit ID, used as F10-menu and message key.
---@field ammo table Ammo table snapshot from `unit:GetAmmo()`.
---@field time number Mission time (seconds) when the session was last refreshed.
---@field category number Group category at session creation.
---@field capturing boolean `true` while the capture loop is actively running.
---@field duration number Total expositions (shots) available per sortie.
---@field targetList table Targets detected this pass, not yet reported. `[unitName] = snap`.
---@field captureCount number Total unique targets captured this sortie.
---@field loop boolean `true` while the `TARS.CaptureLoop` timer is scheduled.
---@field standby boolean `true` when film is paused without ending the session.
---@field filmExhausted boolean `true` when `duration` reached zero.
---@field sessionEnded boolean `true` after STOP or film exhaustion; awaiting debrief.
---@field wasCapturing boolean `true` if capture was active at the moment of touchdown.
---@field landingScheduled boolean `true` once the debrief timer has been registered.
---@field lastTakeoffTime number Mission time of the last takeoff, used for debouncing.
---@field Callback TARS The TARS Callback object for menu functions etc.
---@field PilotParameterHelper boolean If true, there will be messages about the correct parameters to the UNIT.
TARS_SESSION = {}

TARS_SESSION.debug = false

TARS_SESSION.debugunitsearch = false

---@class TARS : BASE
---@field version string Semantic version string, e.g. `"v2.1.0"`.
---@field lid string Log-line prefix shown in Moose.log entries.
---@field locale string Active locale: `"en"` (default), `"de"`, `"fr"`.
---@field mooseScoring boolean Enable MOOSE SCORING backend.
---@field debug boolean Enable debugging in TARS.
---@field valueScoring number Points awarded per detected target (MOOSE path).
---@field landingDelay number Seconds after touchdown before landing is confirmed.
---@field debriefDelay number Seconds after confirmation before F10 marks appear.
---@field landingDistance number Max distance (m) from an allied base/FARP for a valid debrief.
---@field _vAltMin number Minimum AGL (m) for visual-recon helicopters.
---@field _vRangeMin number Detection radius (m) at `_vAltMin`.
---@field _vAltOpti number Optimal AGL (m) for visual-recon helicopters.
---@field _vRangeOpti number Detection radius (m) at `_vAltOpti`.
---@field _vAltMax number Maximum AGL (m) for visual-recon helicopters.
---@field _vRangeMax number Detection radius (m) at `_vAltMax`.
---@field filmLimitEnabled boolean Cap the number of detections per sortie.
---@field filmLimitMax number Maximum unique detections allowed per sortie.
---@field detectUnits boolean Master toggle for detecting DCS Unit objects.
---@field units table Sub-toggles `{ air, ground, ship }` for unit categories.
---@field detectStatics boolean Master toggle for detecting DCS Static objects.
---@field statics table Sub-config for static filtering (`farps`, `captureExceptions`, whitelist).
---@field recoNameFilter table `{ enabled=#boolean, keyword=#string }` — restricts TARS menus to matching group names.
---@field targetNameFilter table `{ enabled=#boolean, keywords=#table }` — per-coalition keyword lists for target filtering.
---@field reconTypes table Map of `[typeName] = true` for all recon-capable DCS type names.
---@field parameters table Map of `[typeName] = #TARS.PlatformParams` with per-platform sensor profiles.
---@field allowedAmmo table Map of `[weaponDisplayName] = true` for permitted loadout items.
---@field instances table Runtime map `[unitName] = #TARS_SESSION` of active sorties.
---@field groundMenus table Runtime map `[playerName] = #TARS.MenuData` of open F10 menus.
---@field detectedTargets table Lifetime map `[unitName] = #TARS.Snapshot` of all reported targets.
---@field marks table `{ blue = {}, red = {} }` — maps `[unitName] = markID`.
---@field redMarkCount number Next available mark ID for Red coalition marks.
---@field blueMarkCount number Next available mark ID for Blue coalition marks.
---@field scoring SCORING MOOSE SCORING instance (nil if mooseScoring is false).
---@field PilotParameterHelper boolean If true, there will be messages about the correct parameters to the UNIT.
TARS = {}

TARS.version = "v2.3.2"

TARS.debug = false

TARS.mooseScoring = true

TARS.valueScoring = 100

TARS.landingDelay = 30

TARS.debriefDelay = 60

TARS.landingDistance = 2500

TARS.PilotParameterHelper = false

TARS._vAltMin = 100

TARS._vAltOpti = 500

TARS._vAltMax = 1500

TARS.filmLimitEnabled = true

TARS.filmLimitMax = 25

TARS.detectUnits = true

TARS.detectStatics = false

TARS.units = { air=false, ground=true, ship=true }

TARS.statics = {
    farps=true,
    captureExceptions=false, captureExceptionsList={},
    captureUnique=false,     captureUniqueList={},
}

TARS.recoNameFilter = { enabled=false, keyword="Reco" }

TARS.targetNameFilter = {
    enabled  = true,
    keywords = {
        [coalition.side.BLUE] = { "USA" },
        [coalition.side.RED]  = { "USSR" },
    },
}

TARS.reconTypes = {
    ["MiG-21Bis"]=true, ["AJS37"]=true, ["Mirage-F1EE"]=true,
    ["F-5E-3"]=true,    ["F-14A-135-GR"]=true, ["F-14B"]=true,
    ["F-4E-45MC"]=true, ["P-51D"]=true, ["P-51D-30-NA"]=true,
    ["SpitfireLFMkIX"]=true, ["FW-190A8"]=true, ["FW-190D9"]=true,
    ["SA342M"]=true, ["SA342L"]=true, ["UH-1H"]=true, ["OH58D"]=true,
    ["Mi-8MT"]=true, ["MH-6J"]=true,
    ["OH-6A"]=true,
}

---@class TARS.parameters
---@field parameters table
TARS.parameters = {}

TARS.allowedAmmo = {
    ["AIM-9B"]=true,["AIM-9D"]=true,["AIM-9E"]=true,["AIM-9G"]=true,
    ["AIM-9H"]=true,["AIM-9J"]=true,["AIM-9L"]=true,["AIM-9M"]=true,
    ["AIM-9N"]=true,["AIM-9P"]=true,["AIM-9P3"]=true,["AIM-9P5"]=true,
    ["AIM-9JULI"]=true,
    ["R-3S"]=true,["R-13M"]=true,["R-13M1"]=true,["R-60"]=true,["R-60M"]=true,
    ["R550 Magic II"]=true,
    ["7_62x51"]=true,
}

TARS.instances       = {}

TARS.groundMenus     = {}

TARS.detectedTargets = {}

TARS.marks           = { blue={}, red={} }

TARS.redMarkCount = 150000

TARS.blueMarkCount = 160000

---Active locale used by `TARS:_T()`. Set before `TARS:New()`.
TARS.locale = "en"

---Nested localization table: `TARS.Messages[locale][messageID] = string`.
TARS.Messages = {
 
    en = {
        TARS_FILM_START           = "[TARS] Capture activated. Expositions remaining: %d",
        TARS_FILM_EXHAUSTED       = "[TARS] Film exhausted. Return to base for debrief.",
        TARS_FILM_STOP            = "[TARS] Session capture ended. Return to base for debrief.",
        TARS_FILM_TIME_UP         = "[TARS] Film time exhausted. Return to base.",
        TARS_FILM_CAP_REACHED     = "[TARS] Maximum captures reached (%d). Return to base for debrief.",
        TARS_FILM_STB_MANUAL      = "[TARS] <>Manual<> Film manual STB.",
        TARS_FILM_RESUME_MANUAL   = "[TARS] <>Manual<> Film manual resume.",
        TARS_FILM_STB_LAND        = "[TARS] <>Landing<> Film auto STB.",
        TARS_FILM_RESUME_TO       = "[TARS] <>TakeOff<> Film auto resume. %d expositions",
        TARS_FILM_STB_LOCKED      = "[TARS] Film is STB — takeoff to resume.",
        TARS_FILM_ALREADY_ACTIVE  = "[TARS] Film already active.",
        TARS_FILM_NO_CAPTURE      = "[TARS] No active film.",
        TARS_FILM_NO_CAPTURE_STOP = "[TARS] No active film to stop.",
        TARS_CAPTURE_TICK         = "EXPOSITIONS REMAINING: %d",
        TARS_CAPTURE_HIT          = "[TARS] +1 Captured target (%d total)",
        TARS_CAPTURE_HIT_MAX      = "[TARS] +1 Captured target (%d total) / %d max",
 
        TARS_SESSION_ENDED        = "[TARS] Session ended. Return to base for debrief.",
        TARS_LAND_VALIDATED       = "[TARS] Landing validated, await your debriefing!",
        TARS_LAND_VALIDATED_TIME  = "[TARS] Targets shown in %d seconds.",
        TARS_NOT_AT_BASE          = "[TARS] Not on allied base or FARP. Return for debrief.",
        TARS_DEBRIEF_TARGETS      = "[TARS] %d targets captured. +%d points.",
        TARS_DEBRIEF_CREDITS      = "You received %d credits for reconnaissance.",
        TARS_DEBRIEF_COALITION    = "%s gathered intel on %d targets.",
        TARS_READY                = "[TARS] Ready for recon.",
 
        TARS_VALID_OK_HDR         = "[TARS] Configuration is valid - Ready for takeoff",
        TARS_VALID_REFUSED_WPN    = "[TARS] Your configuration loadout is not ready. Check your weapons.",
        TARS_VALID_REFUSED_AMMO   = "Refused : ammo %s",
        TARS_VALID_AIRBORNE       = "[TARS] Validation only on ground.",
        TARS_VALID_RUNNING        = "[TARS] Validation already done — film is running.",
        TARS_VALID_GROUP_FILTER   = "[TARS] Task available for group name >%s< only.",
        TARS_VALIDATE_FIRST       = "[TARS] Validate first on ground.",
        TARS_NO_SESSION           = "[TARS] No session actived.",
        TARS_CONFIG_CHANGED       = "[TARS] Config changed — session ended.",
        TARS_LOADOUT_BAD          = "[TARS] Loadout not ready. Check your weapons.",
 
        TARS_PLATFORM_INFO        = "[TARS] Platform information",
        TARS_PLATFORM_LABEL       = "Platform",
        TARS_PLATFORM_ALT         = "Altitude",
        TARS_PLATFORM_FOV         = "FOV",
        TARS_PLATFORM_FILM        = "Film",
 
        TARS_MENU_ROOT            = "Task TARS",
        TARS_MENU_VALIDATE        = "TARS validation",
        TARS_MENU_INFO            = "TARS my capture config",
        TARS_MENU_START           = "TARS mode : Start filming",
        TARS_MENU_STB             = "TARS mode : Standby & Resume",
        TARS_MENU_STOP            = "TARS mode : Stop filming",
    },
 
    de = {
        TARS_FILM_START           = "[TARS] Aufnahme aktiviert. Verbleibende Aufnahmen: %d.",
        TARS_FILM_EXHAUSTED       = "[TARS] Film aufgebraucht. Kehren Sie zur Basis für das Briefing zurück.",
        TARS_FILM_STOP            = "[TARS] Aufnahmesitzung beendet. Kehren Sie zur Basis zurück.",
        TARS_FILM_TIME_UP         = "[TARS] Filmzeit abgelaufen. Kehren Sie zur Basis zurück.",
        TARS_FILM_CAP_REACHED     = "[TARS] Maximale Aufnahmen erreicht (%d). Kehren Sie zur Basis zurück.",
        TARS_FILM_STB_MANUAL      = "[TARS] <>Manuell<> Film manuell auf Standby.",
        TARS_FILM_RESUME_MANUAL   = "[TARS] <>Manuell<> Film manuell fortgesetzt.",
        TARS_FILM_STB_LAND        = "[TARS] <>Landung<> Film automatisch auf Standby.",
        TARS_FILM_RESUME_TO       = "[TARS] <>Takeoff<> Film fortgesetzt. %d Aufnahmen.",
        TARS_FILM_STB_LOCKED      = "[TARS] Film ist auf Standby — starten Sie, um fortzufahren.",
        TARS_FILM_ALREADY_ACTIVE  = "[TARS] Aufnahme bereits aktiv.",
        TARS_FILM_NO_CAPTURE      = "[TARS] Keine aktive Aufnahme.",
        TARS_FILM_NO_CAPTURE_STOP = "[TARS] Keine aktive Aufnahme zum Stoppen.",
        TARS_CAPTURE_TICK         = "Verbleibende Aufnahmen: %d.",
        TARS_CAPTURE_HIT          = "[TARS] +1 Ziel erfasst (%d gesamt)",
        TARS_CAPTURE_HIT_MAX      = "[TARS] +1 Ziel erfasst (%d gesamt) / %d max",
 
        TARS_SESSION_ENDED        = "[TARS] Sitzung beendet. Kehren Sie zur Basis für das Briefing zurück.",
        TARS_LAND_VALIDATED       = "[TARS] Landung erfolgreich, bitte warten Sie auf Ihr Debriefing!",
        TARS_LAND_VALIDATED_TIME  = "[TARS] Ziele werden in %d Sekunden angezeigt.",
        TARS_NOT_AT_BASE          = "[TARS] Nicht auf verbündeter Basis oder FARP. Kehren Sie zurück.",
        TARS_DEBRIEF_TARGETS      = "[TARS] %d Ziele erfasst. +%d Punkte.",
        TARS_DEBRIEF_CREDITS      = "Sie erhalten %d Credits für die Aufklärung.",
        TARS_DEBRIEF_COALITION    = "%s hat Informationen über %d Ziele gesammelt.",
        TARS_READY                = "[TARS] Bereit zur Aufklärung.",
 
        TARS_VALID_OK_HDR         = "[TARS] Konfiguration gültig - Bereit zum Start",
        TARS_VALID_REFUSED_WPN    = "[TARS] Ihre Konfiguration ist nicht bereit. Überprüfen Sie Ihre Waffen.",
        TARS_VALID_REFUSED_AMMO   = "Abgelehnt : Munition %s",
        TARS_VALID_AIRBORNE       = "[TARS] Validierung nur am Boden möglich.",
        TARS_VALID_RUNNING        = "[TARS] Validierung bereits erfolgt — Film läuft.",
        TARS_VALID_GROUP_FILTER   = "[TARS] Aufgabe nur für Gruppenname >%s< verfügbar.",
        TARS_VALIDATE_FIRST       = "[TARS] Zuerst am Boden validieren.",
        TARS_NO_SESSION           = "[TARS] Keine aktive Sitzung.",
        TARS_CONFIG_CHANGED       = "[TARS] Konfiguration geändert — Aufnahme beendet.",
        TARS_LOADOUT_BAD          = "[TARS] Ausrüstung nicht bereit. Überprüfen Sie Ihre Waffen.",
 
        TARS_PLATFORM_INFO        = "[TARS] Plattforminformationen",
        TARS_PLATFORM_LABEL       = "Plattform",
        TARS_PLATFORM_ALT         = "Höhe",
        TARS_PLATFORM_FOV         = "Sichtfeld",
        TARS_PLATFORM_FILM        = "Film",
 
        TARS_MENU_ROOT            = "Aufgabe TARS",
        TARS_MENU_VALIDATE        = "TARS Validierung",
        TARS_MENU_INFO            = "TARS meine Aufnahmekonfiguration",
        TARS_MENU_START           = "TARS Modus : Aufnahme starten",
        TARS_MENU_STB             = "TARS Modus : Standby & Fortsetzen",
        TARS_MENU_STOP            = "TARS Modus : Aufnahme stoppen",
    },
 
    fr = {
        TARS_FILM_START           = "[TARS] Capture activée. Expositions restantes : %d",
        TARS_FILM_EXHAUSTED       = "[TARS] Film épuisé. Retournez à la base pour le compte-rendu.",
        TARS_FILM_STOP            = "[TARS] Session de capture terminée. Retournez à la base.",
        TARS_FILM_TIME_UP         = "[TARS] Temps de film épuisé. Retournez à la base.",
        TARS_FILM_CAP_REACHED     = "[TARS] Nombre maximum de captures atteint (%d). Retournez à la base.",
        TARS_FILM_STB_MANUAL      = "[TARS] <>Manuel<> Film en STB manuel.",
        TARS_FILM_RESUME_MANUAL   = "[TARS] <>Manuel<> Reprise manuel du film.",
        TARS_FILM_STB_LAND        = "[TARS] <>Atterrissage<> Film en STB automatique.",
        TARS_FILM_RESUME_TO       = "[TARS] <>Décollage<> Film repris. %d expositions",
        TARS_FILM_STB_LOCKED      = "[TARS] Film en STB — décollez pour reprendre.",
        TARS_FILM_ALREADY_ACTIVE  = "[TARS] Film déjà activé.",
        TARS_FILM_NO_CAPTURE      = "[TARS] Aucun film activé.",
        TARS_FILM_NO_CAPTURE_STOP = "[TARS] Aucun film actif à stopper.",
        TARS_CAPTURE_TICK         = "[TARS] EXPOSITIONS RESTANTES : %d",
        TARS_CAPTURE_HIT          = "[TARS] +1 Cible capturée (%d au total)",
        TARS_CAPTURE_HIT_MAX      = "[TARS] +1 Cible capturée (%d au total) / %d max",
 
        TARS_SESSION_ENDED        = "[TARS] Session terminée. Retournez à la base pour le debriefing.",
        TARS_LAND_VALIDATED       = "[TARS] Atterrissage validé, attendez votre debriefing !",
        TARS_LAND_VALIDATED_TIME  = "[TARS] Cibles affichées dans %d seconds.",
        TARS_NOT_AT_BASE          = "[TARS] Vous n'êtes pas sur une base ou FARP alliée. Retourné pour le debriefing.",
        TARS_DEBRIEF_TARGETS      = "[TARS] %d cibles capturées. +%d points.",
        TARS_DEBRIEF_CREDITS      = "Vous avez reçu %d crédits pour la reconnaissance.",
        TARS_DEBRIEF_COALITION    = "%s a recueilli des renseignements sur %d cibles.",
        TARS_READY                = "[TARS] Prêt pour la reconnaissance.",
 
        TARS_VALID_OK_HDR         = "[TARS] Configuration valide - Prêt au décollage",
        TARS_VALID_REFUSED_WPN    = "[TARS] Votre configuration n'est pas prête. Vérifiez vos armes.",
        TARS_VALID_REFUSED_AMMO   = "Refusé : munition %s",
        TARS_VALID_AIRBORNE       = "[TARS] Validation uniquement au sol.",
        TARS_VALID_RUNNING        = "[TARS] Validation déjà effectuée — le film tourne.",
        TARS_VALID_GROUP_FILTER   = "[TARS] Tâche disponible pour le groupe >%s< uniquement.",
        TARS_VALIDATE_FIRST       = "[TARS] Validez d'abord au sol.",
        TARS_NO_SESSION           = "[TARS] Aucune session active.",
        TARS_CONFIG_CHANGED       = "[TARS] Configuration modifiée — session terminée.",
        TARS_LOADOUT_BAD          = "[TARS] Chargement pas prêt. Vérifiez vos armes.",
 
        TARS_PLATFORM_INFO        = "[TARS] Informations sur la plateforme",
        TARS_PLATFORM_LABEL       = "Plateforme",
        TARS_PLATFORM_ALT         = "Altitude",
        TARS_PLATFORM_FOV         = "Champ de vision",
        TARS_PLATFORM_FILM        = "Film",
 
        TARS_MENU_ROOT            = "Mission TARS",
        TARS_MENU_VALIDATE        = "TARS validation",
        TARS_MENU_INFO            = "TARS ma config de capture",
        TARS_MENU_START           = "TARS mode : Démarrer le film",
        TARS_MENU_STB             = "TARS mode : Standby & Reprise",
        TARS_MENU_STOP            = "TARS mode : Arrêter le film",
    },
}

---[INTERNAL] Returns the aircraft's signed bank/roll angle in radians.
---@param mooseUnit? UNIT The recon aircraft.
---@return number # Roll angle in radians.
function TARS.getRoll(mooseUnit) end

---[INTERNAL] Returns the aircraft's pitch angle in radians.
---@param mooseUnit? UNIT The recon aircraft.
---@return number # Pitch angle in radians.
function TARS.getPitch(mooseUnit) end

---Maps a 0–100 health value to a human-readable damage status label.
---@param life? number Health percentage (0–100), or nil.
---@return string # Damage label.
function TARS.life2text(life) end

---[INTERNAL] Populates all shared fields from a MOOSE UNIT object.
---@param unit? UNIT The recon aircraft's MOOSE UNIT.
function TARS_SESSION:_SetSharedParams(unit) end

---[INTERNAL] Refreshes aircraft references WITHOUT resetting sortie state.
---@param unit? UNIT The recon aircraft's MOOSE UNIT.
function TARS_SESSION:SetObjectParamsLight(unit) end

---[INTERNAL] Fully initialises (or resets) all sortie state.
---After a debrief reset, re-adds the validation menu item (GROUND_NEW state).
---@param unit? UNIT The recon aircraft's MOOSE UNIT.
---@return TARS_SESSION # self
function TARS_SESSION:SetObjectParams(unit) end

---[INTERNAL] Creates a new TARS_SESSION for the given MOOSE UNIT.
---@param unit? UNIT The recon aircraft's MOOSE UNIT.
---@param Callback? TARS The TARS singleton (for callbacks and config access).
---@return TARS_SESSION # self The newly created session.
function TARS_SESSION:New(unit, Callback) end

---[INTERNAL] Merges a `FindTargets` result into this session's target list.
---Notifies the player per new detection using the active locale.
---@param list? table Map of `[unitName] = Wrapper.Unit#UNIT` from `TARS_SESSION:FindTargets()`.
function TARS_SESSION:AddToTargetList(list) end

---[INTERNAL] Publishes all captured targets as F10 coalition marks.
---@return number # count Number of marks placed or updated this debrief.
function TARS_SESSION:ReturnReconTargets() end

---[INTERNAL] Starts the dynamic-interval capture loop.
---The first tick fires after 2 seconds; subsequent ticks are spaced by
---`_CalcInterval()` which adapts to the aircraft's current speed and altitude.
function TARS_SESSION:CaptureData() end

---[INTERNAL] Removes this session from the global registry.
function TARS_SESSION:Delete() end

---[INTERNAL] Returns a unit's current health as a 0–100 percentage.
---@param unit? UNIT
---@return number # Health 0–100, or nil.
function TARS_SESSION:_NormalizeLife(unit) end

---[INTERNAL] Freezes a MOOSE object into a `TARS.Snapshot`.
---@param _Object? UNIT MOOSE UNIT or STATIC.
---@return TARS.Snapshot # snap
function TARS_SESSION:_FreezeUnit(_Object) end

---[INTERNAL] Calculates the 2-D ground point ahead of the aircraft.
---@param unit? UNIT
---@param params? TARS.PlatformParams|number|string
---@param center_shift? number shift value
---@return table # `{ x, z, MSL, alt }` ahead of the aircraft.
function TARS_SESSION:_OffsetCalc(unit, params, center_shift) end

---[INTERNAL] Validates a single DCS/MOOSE object against all active filters.
---Returns true if the object should be added to the target list.
---@param _Object? UNIT MOOSE UNIT or STATIC.
---@return boolean
function TARS_SESSION:_ValidateObjectFound(_Object) end

---[INTERNAL] Main capture tick. Scheduled dynamically via `timer.scheduleFunction`.
---The interval between ticks is calculated from the aircraft's current speed
---and camera footprint via `_CalcInterval()`, ensuring adequate frame overlap
---regardless of whether the platform is a slow helicopter or a fast jet.
---`duration` is decremented by the actual interval each tick.
---@return nil
function TARS_SESSION:CaptureLoop() end

---[INTERNAL] Two-segment linear interpolation for visual-recon helicopter range.
---@param params? TARS.PlatformParams|number|string
---@param altitude? number AGL in metres.
---@return number # radius Detection sphere radius in metres.
function TARS_SESSION:_CalcVisualRange(params, altitude) end

---[INTERNAL] Calculates the capture interval in seconds based on current speed and altitude.
---Uses the camera footprint width and the configured overlap to determine how long
---the aircraft needs to travel before the next frame is needed.
---Clamped between 5 and 120 seconds to prevent extreme values.
---@param unit? UNIT The recon aircraft.
---@param params? TARS.PlatformParams|number|string Platform parameter table.
---@return number # interval Capture interval in seconds.
function TARS_SESSION:_CalcInterval(unit, params) end

---[INTERNAL] Checks a point is inside of an elipse
---@param ox? any
---@param oz? any
---@param cx? any
---@param cz? any
---@param a? any
---@param b? any
---@param heading_rad? any
---@return boolean # IsInElipse
function TARS_SESSION.isInEllipse(ox, oz, cx, cz, a, b, heading_rad) end

---[INTERNAL] earches for targets in a sphere ahead of the aircraft.
---@return table # `[unitName] = Wrapper.Unit#UNIT` [INTERNAL] Searches for targets in an elliptical footprint ahead of the aircraft.
---@return table # `[unitName] = Wrapper.Unit#UNIT`
function TARS_SESSION:FindTargets() end

---[INTERNAL] Returns the active TARS_SESSION for a unit name, or nil.
---@param unitName? string
---@return TARS_SESSION # or nil
function TARS:GetInstance(unitName) end

---[INTERNAL] Resolves a localized string by message ID.
---Lookup order: `TARS.Messages[locale][id]` → `TARS.Messages["en"][id]` → raw id.
---Passes extra arguments through `string.format` when provided.
---@param id? string Message ID (key in `TARS.Messages[locale]`).
---@param ... any
---@return string # Resolved, formatted string.
function TARS:_Txt(id, ...) end

---[INTERNAL] Sends a localized MESSAGE to a single unit by player name.
---@param text? string Resolved message text.
---@param seconds? number Display duration in seconds.
---@param playerName? string Player display name.
---@param Silent? boolean Do not send via SRS if this is true.
function TARS:_MsgUnit(text, seconds, playerName, Silent) end

---[INTERNAL] Sends a localized MESSAGE to an entire coalition.
---@param text? string Resolved message text.
---@param seconds? number Display duration in seconds.
---@param coa? number Coalition side (1 = Red, 2 = Blue).
function TARS:_MsgCoalition(text, seconds, coa) end

---[INTERNAL] Awards credits via DCSBot (if loaded).
---@param name? string Player display name.
---@param points? number Credits to award.
---@return boolean # `true` if credited.
function TARS:_AddUserPoints(name, points) end

---[INTERNAL] Resolves the MOOSE UNIT for a player from the groundMenus registry.
---@param playerName? string
---@return UNIT # unit or nil.
function TARS:_GetUnitFromPlayerName(playerName) end

---[INTERNAL] F10 callback: ground validation.
---@param playerName? string
function TARS:_CbValidate(playerName) end

---[INTERNAL] F10 callback: show platform info.
---@param playerName? string
function TARS:_CbInfo(playerName) end

---[INTERNAL] F10 callback: start capture.
---@param playerName? string
function TARS:_CbStart(playerName) end

---[INTERNAL] F10 callback: toggle STB.
---@param playerName? string
function TARS:_CbStb(playerName) end

---[INTERNAL] F10 callback: stop capture.
---@param playerName? string
function TARS:_CbStop(playerName) end

---[INTERNAL] Creates and registers a new TARS_SESSION.
---@param unit? UNIT
---@return TARS_SESSION
function TARS:CreateInstance(unit) end

---[INTERNAL] Validates the aircraft loadout.
---@param unit? UNIT
---@return boolean # reconOk
---@return string # refusedWeapon or nil
function TARS:CheckIfRecon(unit) end

---[INTERNAL] Validates loadout on the ground and sets the approved flag.
---@param unit? UNIT
function TARS:CheckTask(unit) end

---[INTERNAL] Arms the capture session.
---@param instance? TARS_SESSION
function TARS:Control(instance) end

---[INTERNAL] Ends the capture session; marks it as awaiting debrief.
---@param instance? TARS_SESSION
function TARS:StopCapture(instance) end

---[INTERNAL] Toggles film standby on/off.
---@param instance? TARS_SESSION
function TARS:StandbyCapture(instance) end

---[INTERNAL] Sends platform capabilities as a HUD message.
---All labels are resolved through the active locale.
---@param instance? TARS_SESSION
function TARS:ShowPlatformInfo(instance) end

---[INTERNAL] Places a coalition F10 map marker for a detected target snapshot.
---@param snap? TARS.Snapshot|number|string
---@param coa? number Coalition side.
---@return number # counter Mark ID used.
function TARS:OutMark(snap, coa) end

---[INTERNAL] Debrief: publishes marks and awards points after a valid landing.
---@param instance? TARS_SESSION
function TARS:ProcessLanding(instance) end

---[INTERNAL] Removes F10 marks for units that no longer exist.
---@param _? boolean
---@param time? number
---@return number # time + 120
function TARS:RemoveUnusedMarks(_, time) end

---[INTERNAL] Returns true if the unit is within landingDistance of any allied base/FARP.
---@param unit? UNIT
---@return boolean
function TARS:IsNearAlliedBase(unit) end

---[INTERNAL] Adds the "TARS validation" menu item using the active locale label.
---@param playerName? string
function TARS:_MenuAddValidation(playerName) end

---[INTERNAL] Removes the "TARS validation" menu item.
---@param playerName? string
function TARS:_MenuRemoveValidation(playerName) end

---[INTERNAL] Adds the three film-control items using the active locale labels.
---@param playerName? string
function TARS:_MenuAddFilmControls(playerName) end

---[INTERNAL] Removes the three film-control items.
---@param playerName? string
function TARS:_MenuRemoveFilmControls(playerName) end

---[INTERNAL] Creates the Task TARS F10 sub-menu and its initial items.
---Initial state (GROUND_NEW): "TARS validation" + "TARS capture config".
---@param unit? UNIT
---@param playerName? string
function TARS:AddBaseMenu(unit, playerName) end

---[INTERNAL] Removes the TARS F10 menu for a player.
---@param playerName? string
function TARS:RemoveGroundMenu(playerName) end

---[INTERNAL] Handles unit birth.
---@param EventData? EVENTDATA
function TARS:_OnEventBirth(EventData) end

---[INTERNAL] Handles engine startup (fallback for pre-loaded slots).
---@param EventData? EVENTDATA
function TARS:_OnEventEngineStartup(EventData) end

---[INTERNAL] Handles unit death.
---@param EventData? EVENTDATA
function TARS:_OnEventDead(EventData) end

---[INTERNAL] Handles player leaving a slot.
---@param EventData? EVENTDATA
function TARS:_OnEventPlayerLeaveUnit(EventData) end

---[INTERNAL] Handles takeoff events (TakeOff + RunwayTakeOff share this handler).
---Branch 1: capture active → validate config, auto-resume film.
---Branch 2: film inactive → check approval, create session, add film menus.
---@param EventData? EVENTDATA
function TARS:_OnEventTakeOff(EventData) end

---[INTERNAL] Handles landing events (Land + RunwayTouch share this handler).
---Branch 1: capture active → auto standby.
---Branch 2: session ended → schedule debrief, remove film menus.
---@param EventData? EVENTDATA
function TARS:_OnEventLand(EventData) end

---Creates the TARS singleton and wires up all event handlers.
---@param locale? string (optional) Set locale for text output, defaults to "en". "fr" and "de" available out-of-the-box.
---@return TARS # self
function TARS:New(locale) end

---Configure SRS radio output.
---@param Path? string (Optional) Path to SRS (or nil to use MSRS default)
---@param Frequency? number MHz, e.g. 251
---@param Modulation? number radio.modulation.AM or FM (default AM)
---@param Culture? string (Optional) BCP-47 culture string, e.g. "ru-RU"
---@param Gender? string (Optional) "male" or "female". Usually not used when using a specific voice.
---@param Voice? string MSRS voice constant; do not forget to adjust voice to your locale!
---@param Coalition? number MSRS Coalition, e.g. coalition.side.BLUE.
---@param Port? number (Optional) SRS port (default 5002)
---@param Speed? number (Optional) Speech speed (or nil to use MSRS default)
---@param Provider? string (Optional) Provider, e.g. MSRS.Provider.GOOGLE (or nil to use MSRS default)
---@param Backend? string (Optional) Backend, e.g. MSRS.Backend.HOUND (or nil to use MSRS default)
---@param Speaker? number (Optional, HOUND/PIPER only!) Speaker number, e.g. 11 for Speaker "318 (11)"
---@return TARS # self
function TARS:SetSRS(Path, Frequency, Modulation, Culture, Gender, Voice, Coalition, Port, Speed, Provider, Backend, Speaker) end

---Set SRS Voice Speaker for Hound/Piper
---@param Speaker? number Speaker number, e.g. 11 for Speaker "318 (11)"
---@return TARS # self
function TARS:SetSRSPiperSpeaker(Speaker) end

---Moose FSM Style callback function for mission designers. Optionally overwrite with own function. Processed after landing on debriefing analysis. Use for pre-processing.
---@param TargetSnap? TARS.Snapshot|number|string Table of data of a **single** found object in the last session.
---@return boolean # returnvalue If false, then `TARS:OnAfterDataProcessing` will NOT be called.
function TARS:OnBeforeDataProcessing(TargetSnap) end

---Moose FSM Style callback function for mission designers. Optionally overwrite with own function. Processed after landing on debriefing analysis.
---@param TargetSnap? TARS.Snapshot|number|string Table of data of a **single** found object in the last session.
---@return TARS # self
function TARS:OnAfterDataProcessing(TargetSnap) end
