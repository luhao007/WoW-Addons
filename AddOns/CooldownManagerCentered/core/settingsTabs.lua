local _, ns = ...

local SettingsTabs = {}
ns.SettingsTabs = SettingsTabs

local entries = {}
local lastActive = nil

function SettingsTabs:RegisterPanel(panel, tab, label)
    for _, entry in ipairs(entries) do
        if entry.panel == panel then
            return
        end
    end
    entries[#entries + 1] = { panel = panel, tab = tab, label = label }
end

function SettingsTabs:SetTabsShown(shown)
    for _, entry in ipairs(entries) do
        entry.tab:SetShown(shown)
    end
end

local function HideNativeContent()
    CooldownViewerSettings.CooldownScroll:Hide()
end

local function RestoreNativeContent()
    CooldownViewerSettings.CooldownScroll:Show()
end

function SettingsTabs:Activate(panel, onActivated)
    if InCombatLockdown() then
        return
    end

    CooldownViewerSettings.SpellsTab:SetChecked(false)
    CooldownViewerSettings.AurasTab:SetChecked(false)
    if CooldownViewerSettings.GroupBuffsTab then
        CooldownViewerSettings.GroupBuffsTab:SetChecked(false)
    end
    for _, entry in ipairs(entries) do
        if entry.panel == panel then
            entry.tab:SetChecked(true)
            entry.panel:Show()
        else
            entry.tab:SetChecked(false)
            entry.panel:Hide()
        end
    end
    CooldownViewerSettings:SetToplevel(false)
    HideNativeContent()
    CooldownViewerSettingsCloseButton:Hide()
    CooldownViewerSettingsCloseButton:Show()

    lastActive = panel

    if onActivated then
        onActivated()
    end
end

function SettingsTabs:Restore()
    if not lastActive then
        return
    end
    for _, entry in ipairs(entries) do
        if entry.panel == lastActive then
            SettingsTabs:Activate(lastActive)
            return
        end
    end
end

function SettingsTabs:DeactivateAll()
    for _, entry in ipairs(entries) do
        if entry.panel:IsShown() then
            entry.panel:Hide()
        end
        if entry.tab then
            entry.tab:SetChecked(false)
        end
    end
    lastActive = nil
    RestoreNativeContent()
    local mode = CooldownViewerSettings.displayMode
    CooldownViewerSettings.SpellsTab:SetChecked(mode == "spells")
    CooldownViewerSettings.AurasTab:SetChecked(mode == "auras")
    if CooldownViewerSettings.GroupBuffsTab then
        CooldownViewerSettings.GroupBuffsTab:SetChecked(mode == "groupBuffs")
    end
end
