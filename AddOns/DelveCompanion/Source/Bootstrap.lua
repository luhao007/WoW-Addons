local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

local function OnPlayerLogin()
    -- Logger.Log("OnPlayerLogin start...")

    DelveCompanion.AddonSettings:Init()

    DelveCompanion.Variables.maxLevelReached = UnitLevel("player") == DelveCompanion.Config.EXPANSION_MAX_LEVEL
    if DelveCompanion.Variables.maxLevelReached then
        DelveCompanion_TooltipExtension_Init()
    end

    -- Logger.Log("OnPlayerLogin finish")
end

local function OnAddonLoaded()
    -- Logger.Log("OnAddonLoaded start...")

    DelveCompanion.Variables.tomTomAvailable = TomTom ~= nil
    DelveCompanion.Variables.mpeAvailable = MapPinEnhanced ~= nil

    DelveCompanion:InitAccountSave()
    DelveCompanion:InitCharacterSave()

    DelveCompanion:InitDelvesData()

    -- Logger.Log("OnAddonLoaded finish")
end

EventRegistry:RegisterFrameEventAndCallback("PLAYER_LOGIN", OnPlayerLogin)
-- EventRegistry:RegisterFrameEventAndCallback("GOSSIP_SHOW", function(payload, arg1, arg2)
--     if arg1 == "delves-difficulty-picker" then
--         -- local options = DelvesDifficultyPickerFrame:GetOptions()
--         Logger.Log("=================")
--         Logger.Log("Modifiers info:")
--         Logger.LogTable(DelvesDifficultyPickerFrame.DelveModifiersWidgetContainer.widgetFrames)
--     end
-- end)
EventUtil.ContinueOnAddOnLoaded(addonName, OnAddonLoaded)
