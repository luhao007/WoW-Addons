local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

---@type number
local EJ_TABS_COUNT = 8
--#endregion

---@class (exact) EJExtension
---@field DelvesList DelvesList
---@field DelveEncounter DelveEncounter
local EJExtension = {}
DelveCompanion.EJExtension = EJExtension

local function ExpansionDropdown_Select(tier)
    EJExtension:OnExpansionDropdownSelected(tier)
end

---@param self EJExtension
function EJExtension:OnExpansionDropdownSelected(tier)
    EJ_SelectTier(tier)

    local EncounterJournal = EncounterJournal

    local tierData = GetEJTierData(tier)
    do
        -- JourneysFrame has an internal variable to control the current displayed expansion. It should be set to properly reflect expansion switch done on the Delves tab.

        if EncounterJournal.JourneysFrame then
            -- If tier is greater than EJ_TIER_DATA, either we have "current season" selected, or an expansion is missing. Fall back on the current expansion.
            -- EJ_TIER_DATA is a local table so ExpansionEnumToEJTierDataTableId is used instead.
            if tier > #ExpansionEnumToEJTierDataTableId then
                EncounterJournal.JourneysFrame.expansionFilter = LE_EXPANSION_LEVEL_CURRENT
            else
                EncounterJournal.JourneysFrame.expansionFilter = tierData.expansionLevel
            end
        end
    end

    -- As it's a custom function for the dropdown, DelvesList is always shown here.
    do
        self.DelvesList.Frame:Refresh()
    end
end

---@param self EJExtension
function EJExtension:OnContentTabSet(id)
    -- Logger:Log("EJ_ContentTab_Select Hook. Tab ID: %d", id)

    local EncounterJournal = EncounterJournal

    if id ~= self.DelvesList.TabButton:GetID() then
        self.DelvesList.Frame:Hide()
        PanelTemplates_DeselectTab(self.DelvesList.TabButton)

        return
    end

    EJ_HideNonInstancePanels()
    EncounterJournal_ShowGreatVaultButton()

    -- If the Delves tab is opened with an earlier expansion selected, set the selected EJ Tier to the current expansion.
    if EJ_GetCurrentTier() < self.DelvesList.delvesMinTier then
        ExpansionDropdown_Select(GetServerExpansionLevel() + 1)
    end
    self.DelvesList:SetupExpansionDropdownForDelves(EncounterJournal, ExpansionDropdown_Select)
    EncounterJournal_EnableExpansionDropdown(-40, -30, EncounterJournal)
    EncounterJournal.instanceSelect.ExpansionDropdown:SetShown(true)

    self.DelvesList.Frame:Show()
    PanelTemplates_SelectTab(self.DelvesList.TabButton)
end

---@param self EJExtension
function EJExtension:EJ_OnShowHook()
    -- Logger:Log("[EJExtension] OnShow hook")

    ---@type Frame
    local EncounterJournal = EncounterJournal

    do
        --- Re-order tabs in EncounterJournal
        ---@param tab Button
        ---@param relativeTo Button
        local function SetTabAnchor(tab, relativeTo)
            ---@type number,number
            local offsetX, offsetY = 3, 0

            tab:ClearAllPoints()
            tab:SetPoint("LEFT", relativeTo, "RIGHT", offsetX, offsetY)
        end

        SetTabAnchor(self.DelvesList.TabButton, EncounterJournal.suggestTab)
        SetTabAnchor(EncounterJournal.dungeonsTab, self.DelvesList.TabButton)
        SetTabAnchor(EncounterJournal.raidsTab, EncounterJournal.dungeonsTab)
        SetTabAnchor(EncounterJournal.TutorialsTab, EncounterJournal.raidsTab)
    end

    -- Being closed, EncounterJournal remembers the last opened tab.
    -- While OnContentTabSet is called before OnShow, the expansion dropdown gets reset somewhere in between.
    -- And if the last tab is the Delves tab, the dropdown will contain all expansions. So it should be set here for Delves.
    if EncounterJournal.selectedTab == self.DelvesList.TabButton:GetID() then
        self.DelvesList:SetupExpansionDropdownForDelves(EncounterJournal, ExpansionDropdown_Select)
    end
end

---@param self EJExtension
function EJExtension:Init()
    -- Logger:Log("[EJExtension] Init started...")

    ---@type Frame
    local EncounterJournal = EncounterJournal

    if not EncounterJournal then
        Logger:Log("[EJExtension] EncounterJournal is nil. Cannot init!")
        return
    end

    -- DelvesList
    do
        self.DelvesList:Init(EncounterJournal)

        -- TODO: Check later whether Blizz has changed smth that is a root cause of the issue #75
        -- PanelTemplates_SetNumTabs(EncounterJournal, EJ_TABS_COUNT)
    end

    -- JourneysFrame
    do
        self.DelveEncounter:Init(EncounterJournal.JourneysFrame)
    end

    EncounterJournal:HookScript("OnShow",
        function()
            EJExtension:EJ_OnShowHook()
        end
    )

    hooksecurefunc("EJ_ContentTab_Select",
        function(id)
            EJExtension:OnContentTabSet(id)
        end
    )
end

EventUtil.ContinueOnAddOnLoaded(DelveCompanion.Definitions.DependencyAddonName.encounterJournal,
    function()
        EJExtension:Init()
    end
)
