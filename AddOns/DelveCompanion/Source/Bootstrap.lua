local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

---@class Bootstrap
local Bootstrap = {}

-- Check whether any optional dependencies are loaded.
---@param self Bootstrap
function Bootstrap:ProcessOptionalDependencies()
    DelveCompanion.Variables.tomTomAvailable = TomTom ~= nil
    DelveCompanion.Variables.mpeAvailable = MapPinEnhanced ~= nil
end

---@param self Bootstrap
function Bootstrap:OnAddonLoaded()
    -- Logger.Log("[Bootstrap] OnAddonLoaded start...")

    self:ProcessOptionalDependencies() -- Should be before any other initializations!

    DelveCompanion.AddonSettings:ProcessAccountSave()
    DelveCompanion.AddonSettings:ProcessCharacterSave()

    -- Logger.Log("[Bootstrap] OnAddonLoaded finish")
end

---@param self Bootstrap
function Bootstrap:OnPlayerLogin()
    -- Logger.Log("[Bootstrap] OnPlayerLogin start...")

    DelveCompanion.Variables.maxLevelReached =
        UnitLevel("player") == GetMaxLevelForExpansionLevel(Config.DELVES_MIN_EXPANSION)

    DelveCompanion.AddonSettings:Init()
    DelveCompanion.ProgressTracker:Init()
    DelveCompanion.InDelveWidget:Init()

    DelveCompanion:InitDelvesData()
    DelveCompanion_TooltipExtension_Init()

    -- Logger.Log("[Bootstrap] OnPlayerLogin finish")
end

-- EventRegistry:RegisterFrameEventAndCallback("GOSSIP_SHOW", function(payload, arg1, arg2)
--     if arg1 == "delves-difficulty-picker" then
--         -- local options = DelvesDifficultyPickerFrame:GetOptions()
--         Logger.Log("=================")
--         Logger.Log("Modifiers info:")
--         Logger.LogTable(DelvesDifficultyPickerFrame.DelveModifiersWidgetContainer.widgetFrames)
--     end
-- end)

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    Bootstrap:OnAddonLoaded()
end) -- 1st
EventRegistry:RegisterFrameEventAndCallback("PLAYER_LOGIN", function()
    Bootstrap:OnPlayerLogin()
end) -- 2nd
