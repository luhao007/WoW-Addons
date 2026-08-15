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

---@type string
local LOOT_INFO_BUTTON_PARENT_KEY = "ShowLootInfoButton"
--#endregion

---@class (exact) DelveEncounter
---@field EncounterRewardTrack Frame
---@field ExpBar JourneyEncounterExpBar
---@field ConfigPanel CompanionConfigPanel
---@field BountifulFrame DelveEncounterBountifulFrame
---@field ConsumablesFrame DelveEncounterConsumablesFrameXml
---@field GildedStashFrame DelveEncounterGildedStashFrame
---@field LootInfoButton MagicButton
local DelveEncounter = {}
DelveCompanion.EJExtension.DelveEncounter = DelveEncounter

--- Initialize elements in the Delve Encounter window.
---@param self DelveEncounter
---@param JourneysFrame Frame
function DelveEncounter:Init(JourneysFrame)
    -- Logger:Log("[DelveEncounter] Init started...")

    ---@type Frame
    local encRewardTrack = JourneysFrame.JourneyProgress.EncounterRewardProgressFrame

    if not encRewardTrack then
        Logger:Log("[DelveEncounter] EncounterRewardProgressFrame frame is nil. Cannot init!")
        return
    end

    do
        self.EncounterRewardTrack = encRewardTrack

        encRewardTrack:HookScript("OnShow",
            function()
                self:EncRewTrack_OnShowHook()
            end
        )

        encRewardTrack:HookScript("OnHide",
            function()
                self:EncRewTrack_OnHideHook()
            end
        )
    end

    ---@type Button
    local companionFrame = JourneysFrame.JourneyProgress.DelvesCompanionConfigurationFrame
    if not companionFrame then
        Logger:Log("[DelveEncounter] Companion frame is nil. Cannot init!")
        return
    end

    do
        companionFrame:ClearPoint("CENTER")
        companionFrame:SetPoint("LEFT", 30, 0)

        ---@type FontString
        local compName = companionFrame.CompanionConfigBtn.CompanionName
        compName:SetJustifyH("CENTER")
        compName:ClearAllPoints()
        compName:SetPoint("TOPLEFT", companionFrame.CompanionConfigBtn.Icon, "TOPRIGHT", 5, 17)

        ---@type JourneyEncounterExpBar
        local bar = CreateFrame("StatusBar", "$parent.CompanionExpBar", encRewardTrack,
            "DelveCompanionJourneyEncounterExpBarTemplate")
        bar:SetPoint("TOP", compName, "BOTTOM", 0, 2)
        self.ExpBar = bar

        local template = DelveCompanion.Variables.isPTR and "DelveCompanionCompanionConfigPanelTemplate"
            or "DelveCompanionCompanionConfigPanelTemplateOld"
        ---@type CompanionConfigPanel
        local configPanel = CreateFrame("Frame", "$parent.ConfigPanel", encRewardTrack, template)
        configPanel:SetPoint("TOP", bar, "BOTTOM", 0, 3)
        self.ConfigPanel = configPanel
    end

    do
        ---@type DelveEncounterBountifulFrame
        local bountifulFrame = CreateFrame("Frame", "$parent.BountifulPanel", encRewardTrack,
            "DelveCompanionDelveEncounterBountifulFrameTemplate")
        bountifulFrame:SetPoint("LEFT", companionFrame, "RIGHT", 0, -6)
        self.BountifulFrame = bountifulFrame

        ---@type DelveEncounterConsumablesFrame
        local consumablesFrame = CreateFrame("Frame", "$parent.ConsumalesPanel", encRewardTrack,
            "DelveCompanionDelveEncounterConsumablesFrameTemplate")
        consumablesFrame:SetPoint("LEFT", bountifulFrame, "RIGHT", 0, 0)
        self.ConsumablesFrame = consumablesFrame

        ---@type DelveEncounterGildedStashFrame
        local gildedStashFrame = CreateFrame("Frame", "$parent.GildedStashPanel", encRewardTrack,
            "DelveCompanionDelveEncounterGildedStashFrameTemplate")
        gildedStashFrame:SetPoint("LEFT", consumablesFrame, "RIGHT", 0, 0)
        self.GildedStashFrame = gildedStashFrame
    end

    do
        self:CreateLootInfoButton(encRewardTrack)
    end
end

---@param self DelveEncounter
function DelveEncounter:EncRewTrack_OnShowHook()
    -- Logger:Log("[DelveEncounter] EncRewTrack_OnShowHook...")

    -- Journeys frame is very unoptimised.
    -- This hook is triggered switching a table with the opened Delves encounter and returning back. But in fact, the Journeys list is shown, not the actual encounter.
    self:Refresh()
end

---@param self DelveEncounter
function DelveEncounter:EncRewTrack_OnHideHook()
    -- Logger:Log("[DelveEncounter] EncRewTrack_OnHideHook...")
    self:HideAll()
end

--- Hides all addon-related frames.
---@param self DelveEncounter
function DelveEncounter:HideAll()
    self.ExpBar:Hide()
    self.ConfigPanel:Hide()
    self.BountifulFrame:Hide()
    self.ConsumablesFrame:Hide()
    self.GildedStashFrame:Hide()
    DelveCompanion:GetLootInfoFrame():Hide()
end

--- Add a button to open Delves' Loot info.
---@param self DelveEncounter
---@param parent any
function DelveEncounter:CreateLootInfoButton(parent)
    local button = CreateFrame("Button",
        "$parent." .. LOOT_INFO_BUTTON_PARENT_KEY,
        parent,
        "DelveCompanionLootInfoButtonTemplate")
    self.LootInfoButton = button

    button:SetParentKey(LOOT_INFO_BUTTON_PARENT_KEY)
    button:SetPoint("TOPRIGHT", self.GildedStashFrame, "BOTTOMRIGHT", -3, 5)
    button:SetTextToFit(_G["LOOT"])

    button:HookScript("OnClick", function()
        if InCombatLockdown() then
            return
        end

        securecall(GameTooltip.Hide, GameTooltip)
        local lootFrame = DelveCompanion:GetLootInfoFrame()
        lootFrame:ClearAllPoints()
        lootFrame:SetPoint("BOTTOMLEFT", EncounterJournal, "BOTTOMRIGHT", -5, 0)

        ToggleFrame(lootFrame)
    end)

    button:HookScript("OnEnter", function()
        if DelveCompanion:GetLootInfoFrame():IsShown() then
            return
        end

        local tooltip = GameTooltip
        tooltip:SetOwner(button, "ANCHOR_TOP")
        GameTooltip_AddInstructionLine(tooltip, Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION, true)

        tooltip:Show()
    end)

    button:HookScript("OnLeave", function()
        securecall(GameTooltip.Hide, GameTooltip)
    end)
end

---@param self DelveEncounter
---@return MajorFactionData data Currently displayed faction data. May return an empty table.
function DelveEncounter:GetFactionData()
    return self.EncounterRewardTrack:GetParent().majorFactionData
end

---@param self DelveEncounter
function DelveEncounter:Refresh()
    -- Logger:Log("[DelveEncounter] Refresh...")

    local data = self:GetFactionData()

    ---@type number
    local expansion = data.expansionID

    -- Check whether the opened encounter is Delves, not something else (e.g. Prey).
    if not data.factionID or not C_MajorFactions.ShouldUseJourneyRewardTrack(data.factionID) then
        return
    end

    do
        self.ExpBar.factionID = C_DelvesUI.GetFactionForCompanion(data.playerCompanionID)
        self.ExpBar:Show()
    end

    do
        local traitTreeID = C_DelvesUI.GetTraitTreeForCompanion(data.playerCompanionID)
        if C_Traits.GetConfigIDByTreeID(traitTreeID) then
            DelvesCompanionConfigurationFrame.playerCompanionID = data.playerCompanionID
            if DelveCompanion.Variables.isPTR then
                self.ConfigPanel.FlavorSlot:SetShown(expansion == LE_EXPANSION_MIDNIGHT)
            end
            self.ConfigPanel:Show()
        end
    end

    do
        self.BountifulFrame:Show()
        self.ConsumablesFrame:Show()
        self.GildedStashFrame:SetShown(expansion == LE_EXPANSION_MIDNIGHT)
        self.LootInfoButton:SetShown(expansion == LE_EXPANSION_MIDNIGHT)
    end
end
