---@meta

---PLATOON class.
---@class PLATOON : COHORT
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field weaponData OPSGROUP.WeaponData Weapon data table with key=BitType.
PLATOON = {
  ClassName      = "PLATOON",
  verbose        =     0,
  weaponData     =    {},
}

---PLATOON class version.
PLATOON.version = "0.1.0"

---Create a new PLATOON object and start the FSM.
---@param TemplateGroupName? string Name of the template group.
---@param Ngroups? number (Optional) Number of asset groups of this platoon. Default 3.
---@param PlatoonName? string Name of the platoon. Must be **unique**!
---@return PLATOON # self
function PLATOON:New(TemplateGroupName, Ngroups, PlatoonName) end

---Set brigade of this platoon.
---@param Brigade? BRIGADE The brigade.
---@return PLATOON # self
function PLATOON:SetBrigade(Brigade) end

---Get brigade of this platoon.
---@return BRIGADE # The brigade.
function PLATOON:GetBrigade() end

---[[
---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLATOON:onafterStart(From, Event, To) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function PLATOON:onafterStatus(From, Event, To) end
