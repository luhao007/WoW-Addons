local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

---@type string
local LOOT_INFO_BUTTON_PARENT_KEY = "ShowLootInfoButton"

---@type number
local DASHBOARD_PANELS_DEFAULT_SPACING = 5
---@type number
local DASHBOARD_PANELS_CUSTOM_SPACING = -20
--#endregion

---@class (exact) DelvesDashboard
---@field ButtonPanelFrame HorizontalLayoutFrame
---@field LootInfo LootInfoFrame
---@field GreatVault DashboardGV
---@field Overview DashOverview
---@field Companion DashboardCompanion
local DelvesDashboard = {}
DelveCompanion.DelvesDashboard = DelvesDashboard

--- Add a button to open Delves' Loot info.
---@param parent any
local function CreateLootInfoButton(parent)
    local button = CreateFrame("Button",
        "$parent." .. LOOT_INFO_BUTTON_PARENT_KEY,
        parent,
        "DelveCompanionLootInfoButtonTemplate")
    button:SetParentKey(LOOT_INFO_BUTTON_PARENT_KEY)

    button:SetTextToFit(_G["LOOT"])

    button:HookScript("OnClick", function()
        GameTooltip:Hide()
        ToggleFrame(DelvesDashboard.LootInfo)
    end)

    button:HookScript("OnEnter", function()
        if DelvesDashboard.LootInfo:IsShown() then
            return
        end

        local tooltip = GameTooltip
        tooltip:SetOwner(button, "ANCHOR_TOP")
        GameTooltip_AddInstructionLine(tooltip, Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION, true)

        tooltip:Show()
    end)

    button:HookScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

local function UpdateButtonPanelSpacing()
    if DelveCompanionCharacterData.dashOverviewEnabled then
        DelvesDashboard.ButtonPanelFrame.spacing = DASHBOARD_PANELS_CUSTOM_SPACING
    else
        DelvesDashboard.ButtonPanelFrame.spacing = DASHBOARD_PANELS_DEFAULT_SPACING
    end

    DelvesDashboard.ButtonPanelFrame:Layout()
end

local function OnSettingChanged(_, changedVarKey, newValue)
    if changedVarKey == "displayCompanionConfig" or changedVarKey == "companionConfigLayout" then
        DelvesDashboard.Companion.ConfigWidget:Refresh(newValue)
    elseif changedVarKey == "gvDetailsEnabled" then
        DelvesDashboard.GreatVault.CustomDetails.shouldRefresh = true
    elseif changedVarKey == "dashOverviewEnabled" then
        DelvesDashboard.Overview:SetShown(newValue)
        UpdateButtonPanelSpacing()
    end
end

local function InitDelvesDashboard()
    if not DelveCompanion.Variables.maxLevelReached then
        return
    end

    local DelvesDashboardFrame = DelvesDashboardFrame
    if not DelvesDashboardFrame then
        Logger.Log("DelvesDashboardFrame is nil. Delves UI extension is not inited.")
        return
    end

    do
        ---@type LootInfoFrame
        local lootInfoFrame = CreateFrame("Frame",
            "$parent.LootInfoFrame", DelvesDashboardFrame,
            "DelveCompanionLootInfoFrameTemplate")
        DelvesDashboard.LootInfo = lootInfoFrame

        CreateLootInfoButton(DelvesDashboardFrame)
        DelvesDashboardFrame:HookScript("OnHide", function()
            DelvesDashboard.LootInfo:Hide()
        end)
    end

    do
        local compPanel = DelvesDashboardFrame.ButtonPanelLayoutFrame.CompanionConfigButtonPanel
        DelvesDashboard.Companion:Init(compPanel)
    end

    do
        local gvPanel = DelvesDashboardFrame.ButtonPanelLayoutFrame.GreatVaultButtonPanel
        DelvesDashboard.GreatVault:Init(gvPanel)
    end

    do
        ---@type DashOverview
        local dashOverview = CreateFrame("Frame", "$parentDashboardOverview",
            DelvesDashboardFrame.ButtonPanelLayoutFrame, "DelveCompanionDashboardOverviewFrame")

        DelvesDashboard.Overview = dashOverview
    end

    DelvesDashboard.ButtonPanelFrame = DelvesDashboardFrame.ButtonPanelLayoutFrame
    UpdateButtonPanelSpacing()

    EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.SETTING_CHANGE, OnSettingChanged, DelvesDashboard)
end

EventUtil.ContinueOnAddOnLoaded(DelveCompanion.Definitions.DependencyAddonName.delvesDashboardUI, InitDelvesDashboard)
