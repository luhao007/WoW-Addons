local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Table containing all addon runtime variables.
---@class (exact) Variables
---@field delvesData table<number, DelveData[]> Table containing all Delves' runtime data (refer to [DelveData](lua://DelveData)).
---@field maxLevelReached boolean Whether player has reached max level of the current expansion.
---@field tomTomAvailable boolean Whether TomTom addon is loaded.
---@field mpeAvailable boolean Whether MapPinEnhanced addon is loaded.
---@field isPTR boolean A flag used to check client version: Mainline or PTR.
local Variables = {
    delvesData = {},
    maxLevelReached = false,
    tomTomAvailable = false,
    mpeAvailable = false,
    isPTR = (select(4, GetBuildInfo())) >= 120001
}
DelveCompanion.Variables = Variables
