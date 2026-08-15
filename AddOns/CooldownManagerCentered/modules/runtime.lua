local _, ns = ...

local Runtime = {}
ns.Runtime = Runtime

local function UpdateRuntime()
    if Runtime.isInEditMode or Runtime.hasSettingsOpened then
        Runtime.stop = true
    else
        Runtime.stop = false
    end
end

Runtime.stop = false
Runtime.isInEditMode = false
Runtime.hasSettingsOpened = false
Runtime.clientSceneActive = false

local viewers = {
    ["BuffIconCooldownViewer"] = BuffIconCooldownViewer,
    ["BuffBarCooldownViewer"] = BuffBarCooldownViewer,
    ["EssentialCooldownViewer"] = EssentialCooldownViewer,
    ["UtilityCooldownViewer"] = UtilityCooldownViewer,
}

function Runtime:IsReady(viewerNameOrFrame)
    local viewer = nil
    if type(viewerNameOrFrame) == "string" then
        viewer = _G[viewerNameOrFrame]
    elseif type(viewerNameOrFrame) == "table" then
        viewer = viewerNameOrFrame
    end
    if not viewer or not viewer.IsInitialized or not EditModeManagerFrame then
        return false
    end

    if EditModeManagerFrame.layoutApplyInProgress or not viewer:IsInitialized() then
        return false
    end

    return true
end

function Runtime:IsAllReady()
    for _, viewer in pairs(viewers) do
        if not self:IsReady(viewer) then
            return false
        end
    end
    return true
end

-- CMC previously used ShowUIPanel after PLAYER_ENTERING_WORLD. This call made
-- Blizzard viewers visible before CMC changed their anchors. The call is disabled
-- during taint tests because it can run Blizzard refresh code in a tainted add-on
-- execution path. Blizzard now controls viewer visibility with the
-- cooldownViewerEnabled CVar and the visibleSetting value.

EventRegistry:RegisterCallback("CooldownViewerSettings.OnDataChanged", function()
    if ns.BuffData then
        ns.BuffData.InvalidateScan()
    end
    if not Runtime:IsAllReady() then
        return
    end
    C_Timer.After(0, function()
        if ns.BuffData then
            ns.BuffData.ScanTrackedBuffs(true)
        end
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end
        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end
        if ns.Stacks then
            ns.Stacks:RefreshAll()
        end
        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
    end)
end)
EventRegistry:RegisterCallback("CooldownViewerSettings.OnShow", function(arg1)
    Runtime.hasSettingsOpened = true
    UpdateRuntime()
    if ns.CooldownStyle then
        ns.CooldownStyle:RefreshCombatGlowState()
    end
    if ns.TrackerAssignmentPanel then
        ns.TrackerAssignmentPanel:EnsureTrackerPanel()
    end
    -- After the tracker tab so the Buffs tab can anchor directly beneath it.
    if ns.BuffAssignmentPanel then
        ns.BuffAssignmentPanel:EnsureSettingsTab()
    end
    if not Runtime:IsAllReady() then
        return
    end
    if ns.CMCVisibility then
        ns.CMCVisibility:UpdateAll()
    end
    C_Timer.After(0, function()
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end
        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end
        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
        if ns.CooldownManager then
            ns.CooldownManager.UpdateUtilityDimming(true)
        end
    end)
end)
EventRegistry:RegisterCallback("CooldownViewerSettings.OnHide", function()
    Runtime.hasSettingsOpened = false
    UpdateRuntime()
    if ns.CooldownStyle then
        ns.CooldownStyle:RefreshCombatGlowState()
    end
    if not Runtime:IsAllReady() then
        return
    end
    if ns.CMCVisibility then
        ns.CMCVisibility:UpdateAll()
    end
    C_Timer.After(0, function()
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end
        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end

        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
        if ns.CooldownManager then
            ns.CooldownManager.UpdateUtilityDimming(true)
        end
    end)
end)

hooksecurefunc(EditModeManagerFrame, "Show", function()
    Runtime.isInEditMode = true
    UpdateRuntime()
    if not Runtime:IsAllReady() then
        return
    end
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefreshAll()
    end
    if ns.CMCVisibility then
        ns.CMCVisibility:UpdateAll()
    end

    C_Timer.After(0, function()
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end

        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end

        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
        if ns.CooldownManager then
            ns.CooldownManager.UpdateUtilityDimming(true)
        end

        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end
    end)
end)

hooksecurefunc(EditModeManagerFrame, "Hide", function()
    Runtime.isInEditMode = false
    UpdateRuntime()
    if not Runtime:IsAllReady() then
        return
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefreshAll()
    end
    if ns.CMCVisibility then
        ns.CMCVisibility:UpdateAll()
    end
    C_Timer.After(0, function()
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end
        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end

        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
        if ns.CooldownManager then
            ns.CooldownManager.UpdateUtilityDimming(true)
        end
    end)
end)
local EventHandler = {}
EventHandler.events = {}
EventHandler.frame = CreateFrame("FRAME")

EventHandler.events["EDIT_MODE_LAYOUTS_UPDATED"] = function(self, event, ...)
    if not Runtime:IsAllReady() then
        return
    end
    C_Timer.After(0.1, function()
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end
        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end

        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
    end)
end

-- EventHandler.events["TRAIT_CONFIG_UPDATED"] = function(self, event, ...)
-- if not Runtime:IsAllReady() then
--     return
-- end
-- C_Timer.After(0, function()
--     if ns.StyledIcons then
--         ns.StyledIcons:RefreshAll()
--     end

--     if ns.CooldownManager then
--         ns.CooldownManager.ForceRefreshAll()
--     end
-- end)
-- end

EventHandler.events["UPDATE_SHAPESHIFT_FORM"] = function(self, event, ...)
    if not Runtime:IsAllReady() then
        return
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefreshAll()
    end
end
EventHandler.events["PLAYER_REGEN_DISABLED"] = function(self, event, ...)
    -- Entering combat: drop the in-Edit-Mode CMC settings panel if it's open and
    -- keep it from reopening while locked down. Runs regardless of viewer
    -- readiness so the panel always closes on combat.
    if ns.EditModeViewerPanel then
        ns.EditModeViewerPanel:Hide()
    end

    if not Runtime:IsAllReady() then
        return
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefreshAll()
    end
    if ns.CooldownStyle then
        ns.CooldownStyle.HideSettingsItemIndicators()
    end
    C_Timer.After(0.1, function()
        if InCombatLockdown() and ns.SettingsTabs then
            ns.SettingsTabs:SetTabsShown(false)
            ns.SettingsTabs:DeactivateAll()
        end
    end)
end

EventHandler.events["PLAYER_REGEN_ENABLED"] = function(self, event, ...)
    if ns.CooldownStyle then
        ns.CooldownStyle.RefreshSettingsItemIndicators()
    end
    C_Timer.After(0.1, function()
        if not InCombatLockdown() and CooldownViewerSettings and CooldownViewerSettings:IsShown() and ns.SettingsTabs then
            ns.SettingsTabs:SetTabsShown(true)
        end
    end)
end

EventHandler.events["SPELL_UPDATE_COOLDOWN"] = function(self, event, spellId)
    if not Runtime:IsAllReady() then
        return
    end

    if ns.CooldownManager then
        ns.CooldownManager.UpdateUtilityDimming()
    end
end

EventHandler.events["SPELL_UPDATE_CHARGES"] = function(self, event, spellId)
    if not Runtime:IsAllReady() then
        return
    end

    if ns.CooldownManager then
        ns.CooldownManager.UpdateUtilityDimming()
    end
end

EventHandler.events["CLIENT_SCENE_OPENED"] = function(self, event, ...)
    local sceneType = ...
    Runtime.clientSceneActive = (sceneType == 1)
end
EventHandler.events["CLIENT_SCENE_CLOSED"] = function(self, event, ...)
    Runtime.clientSceneActive = false
end

for event in pairs(EventHandler.events) do
    EventHandler.frame:RegisterEvent(event)
end

EventHandler.frame:SetScript("OnEvent", function(self, event, ...)
    EventHandler.events[event](self, event, ...)
end)

hooksecurefunc(BuffIconCooldownViewer, "Layout", function()
    if not Runtime:IsReady(BuffIconCooldownViewer) or BuffIconCooldownViewer._cmc_Layout then
        return
    end
    if ns.StyledIcons then
        ns.StyledIcons:RefreshViewer("BuffIcons")
    end
    if ns.CooldownFont then
        ns.CooldownFont:RefreshViewer("BuffIconCooldownViewer")
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ icons = true })
    end
end)
hooksecurefunc(BuffBarCooldownViewer, "Layout", function()
    if not Runtime:IsReady(BuffBarCooldownViewer) or BuffBarCooldownViewer._cmc_Layout then
        return
    end
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ bars = true })
    end
end)
hooksecurefunc(EssentialCooldownViewer, "Layout", function()
    if not Runtime:IsReady(EssentialCooldownViewer) or EssentialCooldownViewer._cmc_Layout then
        return
    end
    if ns.StyledIcons then
        ns.StyledIcons:RefreshViewer("Essential")
    end
    if ns.CooldownFont then
        ns.CooldownFont:RefreshViewer("EssentialCooldownViewer")
    end
    if ns.RangeCheck then
        ns.RangeCheck:RefreshViewer("EssentialCooldownViewer")
    end
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ essential = true })
    end
end)
hooksecurefunc(UtilityCooldownViewer, "Layout", function()
    if not Runtime:IsReady(UtilityCooldownViewer) or UtilityCooldownViewer._cmc_Layout then
        return
    end
    if ns.StyledIcons then
        ns.StyledIcons:RefreshViewer("Utility")
    end
    if ns.CooldownFont then
        ns.CooldownFont:RefreshViewer("UtilityCooldownViewer")
    end
    if ns.RangeCheck then
        ns.RangeCheck:RefreshViewer("UtilityCooldownViewer")
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ utility = true })
    end
end)
