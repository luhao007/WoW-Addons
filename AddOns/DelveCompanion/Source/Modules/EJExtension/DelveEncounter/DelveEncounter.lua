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

---@param self DelveEncounter
---@return number? factionID Faction ID of the displayed encounter.
---@return number? companionID Companion ID of displayed encounter.
function DelveEncounter:GetFactionIDs()
    local progressFrame = self.EncounterRewardTrack:GetParent()

    if progressFrame == nil
        or progressFrame.majorFactionData == nil
        or progressFrame.majorFactionData.factionID == nil
        or progressFrame.majorFactionData.playerCompanionID == nil then
        return nil, nil
    end

    return progressFrame.majorFactionData.factionID, progressFrame.majorFactionData.playerCompanionID
end

---@param self DelveEncounter
---@param factionID number Faction ID of the displayed encounter.
---@return number expansion LE_EXPANSION of the displayed encounter.
function DelveEncounter:GetExpansionForFaction(factionID)
    return FindInTableIf(
        Config.DELVE_FACTION_ID,
        function(id)
            return id == factionID
        end
    )
end

---@param self DelveEncounter
function DelveEncounter:Refresh()
    -- Logger:Log("[DelveEncounter] Refresh...")

    local factionID, companionID = self:GetFactionIDs()
    if factionID == nil or companionID == nil then
        return
    end

    -- Check whether the opened encounter is Delves, not something else (e.g. Prey).
    if not C_MajorFactions.ShouldUseJourneyRewardTrack(factionID) then
        return
    end

    do
        self.ExpBar.factionID = C_DelvesUI.GetFactionForCompanion(companionID)
        self.ExpBar:Show()
    end

    do
        local traitTreeID = C_DelvesUI.GetTraitTreeForCompanion(companionID)
        if C_Traits.GetConfigIDByTreeID(traitTreeID) then
            DelvesCompanionConfigurationFrame.playerCompanionID = companionID
            self.ConfigPanel:Show()
        end
    end

    ---@type number
    local expansion = self:GetExpansionForFaction(factionID)
    do
        self.BountifulFrame:Show()
        self.ConsumablesFrame:Show()
        self.GildedStashFrame:SetShown(expansion == LE_EXPANSION_MIDNIGHT)
        self.LootInfoButton:SetShown(expansion == LE_EXPANSION_MIDNIGHT)
    end
end

---@param self DelveEncounter
function DelveEncounter:EncRewTrack_OnShowHook()
    -- Logger:Log("[DelveEncounter] EncRewTrack_OnShowHook...")

    -- Journeys frame is very unoptimised at the moment.
    -- This hook is triggered switching a table with the opened Delves encounter and returning back. But in fact, the Journeys list is shown, not the actual encounter.
    -- The delayed refresh is a dirty workaround to avoid errors.
    -- TODO: remove the timer if Blizzard fix the Journeys tab behaviour.
    C_Timer.After(0.1, function()
        self:Refresh()
    end)
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

---@param self DelveEncounter
function DelveEncounter:EncRewTrack_OnHideHook()
    -- Logger:Log("[DelveEncounter] EncRewTrack_OnHideHook...")

    self:HideAll()
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

        GameTooltip:Hide()
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
        GameTooltip:Hide()
    end)
end

--- Initialize Delves list.
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

        ---@type CompanionConfigPanel
        local configPanel = CreateFrame("Frame", "$parent.ConfigPanel", encRewardTrack,
            "DelveCompanionCompanionConfigPanelTemplate")
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
