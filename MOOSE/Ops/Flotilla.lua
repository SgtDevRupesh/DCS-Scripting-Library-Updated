---@meta

---FLOTILLA class.
---@class FLOTILLA : COHORT
---@field ClassName string Name of the class.
---@field verbose number Verbosity level.
---@field weaponData OPSGROUP.WeaponData Weapon data table with key=BitType.
FLOTILLA = {
  ClassName      = "FLOTILLA",
  verbose        =     0,
  weaponData     =    {},
}

---FLOTILLA class version.
FLOTILLA.version = "0.1.0"

---Create a new FLOTILLA object and start the FSM.
---@param TemplateGroupName? string Name of the template group.
---@param Ngroups? number (Optional) Number of asset groups of this flotilla. Default 3.
---@param FlotillaName? string Name of the flotilla. Must be **unique**!
---@return FLOTILLA # self
function FLOTILLA:New(TemplateGroupName, Ngroups, FlotillaName) end

---Set fleet of this flotilla.
---@param Fleet? FLEET The fleet.
---@return FLOTILLA # self
function FLOTILLA:SetFleet(Fleet) end

---Get fleet of this flotilla.
---@return FLEET # The fleet.
function FLOTILLA:GetFleet() end

---On after Start event. Starts the FLIGHTGROUP FSM and event handlers.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLOTILLA:onafterStart(From, Event, To) end

---On after "Status" event.
---@param From? string From state.
---@param Event? string Event.
---@param To? string To state.
function FLOTILLA:onafterStatus(From, Event, To) end
