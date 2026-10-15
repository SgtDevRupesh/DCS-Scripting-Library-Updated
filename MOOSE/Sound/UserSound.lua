---@meta

---@class USERSOUND : BASE
USERSOUND = {
  ClassName = "USERSOUND",
}

---USERSOUND Constructor.
---@param UserSoundFileName? string The filename of the usersound.
---@return USERSOUND
function USERSOUND:New(UserSoundFileName) end

---Set usersound filename.
---@param UserSoundFileName? string The filename of the usersound.
---@return USERSOUND # The usersound instance.
function USERSOUND:SetFileName(UserSoundFileName) end

---Play the usersound to all players.
---@return USERSOUND # The usersound instance.
function USERSOUND:ToAll() end

---Play the usersound to the given coalition.
---@param Coalition? coalition The coalition to play the usersound to.
---@return USERSOUND # The usersound instance.
function USERSOUND:ToCoalition(Coalition) end

---Play the usersound to the given country.
---@param Country? country The country to play the usersound to.
---@return USERSOUND # The usersound instance.
function USERSOUND:ToCountry(Country) end

---Play the usersound to the given {Wrapper.Group}.
---@param Group? GROUP The @{Wrapper.Group} to play the usersound to.
---@param Delay? number (Optional) Delay in seconds, before the sound is played. Default 0.
---@return USERSOUND # The usersound instance.
function USERSOUND:ToGroup(Group, Delay) end

---Play the usersound to the given {Wrapper.Unit}.
---@param Unit? UNIT The @{Wrapper.Unit} to play the usersound to.
---@param Delay? number (Optional) Delay in seconds, before the sound is played. Default 0.
---@return USERSOUND # The usersound instance.
function USERSOUND:ToUnit(Unit, Delay) end

---Play the usersound to the given {Wrapper.Client}.
---@param Client? any
---@param Delay? number (Optional) Delay in seconds, before the sound is played. Default 0.
---@return USERSOUND # The usersound instance.
function USERSOUND:ToClient(Client, Delay) end
