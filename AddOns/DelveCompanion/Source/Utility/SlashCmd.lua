local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

--#endregion

SLASH_DELVECOMPANION_SHOWDELVES1 = "/delvecompanion"
SLASH_DELVECOMPANION_SHOWDELVES2 = "/delvecomp"
SLASH_DELVECOMPANION_SHOWDELVES3 = "/delves"
SlashCmdList["DELVECOMPANION_SHOWDELVES"] = function(msg)
    DelveCompanion_CompartmentOnClick(addonName, DelveCompanion.Definitions.ButtonAlias.leftClick)
end
