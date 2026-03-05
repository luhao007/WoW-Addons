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
---@field LootInfo LootInfoFrameXml
---@field LotInfoButton MagicButton
local DelveEncounter = {}
DelveCompanion.EJExtension.DelveEncounter = DelveEncounter

---@param self DelveEncounter
function DelveEncounter:EncRewTrack_OnShowHook()
    -- Logger:Log("[DelveEncounter] EncRewTrack_OnShowHook...")

    ---@type EJTierData
    local tierData = GetEJTierData(EJ_GetCurrentTier())

    local progressFrame = self.EncounterRewardTrack:GetParent()
    if progressFrame == nil or progressFrame.majorFactionData == nil then
        return
    end

    -- Check whether the opened encounter is Delves, not something else (e.g. Prey).
    if not C_MajorFactions.ShouldUseJourneyRewardTrack(progressFrame.majorFactionData.factionID) then
        return
    end

    local companionID = progressFrame.majorFactionData.playerCompanionID

    do
        self.ExpBar.factionID = C_DelvesUI.GetFactionForCompanion(companionID)
        self.ExpBar:Show()
    end

    do
        local isCompUnlocked = C_QuestLog.IsQuestFlaggedCompleted(
            Config.COMPANION_UNLOCK_QUEST[tierData.expansionLevel])

        if isCompUnlocked then
            DelvesCompanionConfigurationFrame.playerCompanionID = companionID
            self.ConfigPanel:Show()
        end
    end

    do
        self.BountifulFrame:Show()
        self.ConsumablesFrame:Show()
        self.GildedStashFrame:SetShown(tierData.expansionLevel == LE_EXPANSION_MIDNIGHT)
        self.LotInfoButton:SetShown(tierData.expansionLevel == LE_EXPANSION_MIDNIGHT)
    end
end

---@param self DelveEncounter
function DelveEncounter:EncRewTrack_OnHideHook()
    -- Logger:Log("[DelveEncounter] EncRewTrack_OnHideHook...")

    self.ExpBar:Hide()
    self.ConfigPanel:Hide()
    self.BountifulFrame:Hide()
    self.ConsumablesFrame:Hide()
    self.GildedStashFrame:Hide()
    self.LootInfo:Hide()
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
        --- Add a button to open Delves' Loot info.
        ---@param parent any
        local function CreateLootInfoButton(parent, anchorFrame)
            local button = CreateFrame("Button",
                "$parent." .. LOOT_INFO_BUTTON_PARENT_KEY,
                parent,
                "DelveCompanionLootInfoButtonTemplate")
            self.LotInfoButton = button

            button:SetParentKey(LOOT_INFO_BUTTON_PARENT_KEY)
            button:SetPoint("TOPRIGHT", anchorFrame, "BOTTOMRIGHT", -3, 5)
            button:SetTextToFit(_G["LOOT"])

            button:HookScript("OnClick", function()
                if PlayerIsInCombat() then
                    return
                end

                GameTooltip:Hide()
                local lootFrame = self.LootInfo
                lootFrame:ClearAllPoints()
                lootFrame:SetPoint("BOTTOMLEFT", EncounterJournal, "BOTTOMRIGHT", -5, 0)

                ToggleFrame(self.LootInfo)
            end)

            button:HookScript("OnEnter", function()
                if self.LootInfo:IsShown() then
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

        ---@type LootInfoFrame
        local lootInfoFrame = CreateFrame("Frame",
            "$parent.LootInfoFrame", encRewardTrack,
            "DelveCompanionLootInfoFrameTemplate")
        self.LootInfo = lootInfoFrame

        CreateLootInfoButton(encRewardTrack, self.GildedStashFrame)
    end
end
