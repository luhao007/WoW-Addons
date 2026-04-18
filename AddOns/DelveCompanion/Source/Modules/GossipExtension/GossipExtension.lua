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
local EVENT_FRAME_NAME = "DelveCompanionGossipExtensionFrame"
---@type string
local DELVE_PICKER_KIT = "delves-difficulty-picker"
---@type string
local LOOT_INFO_BUTTON_PARENT_KEY = "LootInfoButton"
---@type string
local CANCEL_AUTO_ENTER_BUTTON_PARENT_KEY = "CancelAutoEnterButton"
---@type string
local AUTO_ENTER_CHECKBOX_PARENT_KEY = "AutoEnterCheckbox"

---@type number
local AUTO_ENTER_COUNTDOWN_TICK_SEC = 1
---@type number
local EXIT_TIMER_SEC = 10
--#endregion

---@class (exact) GossipExtension
---@field eventFrame Frame
---@field isDiffPickerSetupDone boolean
---@field LootInfoButton MagicButton
---@field CancelAutoEnterButton Button
---@field AutoEnterCheckbox CheckButton
---@field autoEnterCancelled boolean
---@field exitTimer boolean
local GossipExtension = {}
DelveCompanion.GossipExtension = GossipExtension

---@param self GossipExtension
function GossipExtension:Init()
    -- Logger:Log("[GossipExtension] Init started...")

    self.exitTimer = false
    self.isDiffPickerSetupDone = false

    do
        local frame = CreateFrame("Frame", EVENT_FRAME_NAME, UIParent)
        frame:RegisterEvent("GOSSIP_SHOW")

        frame:SetScript("OnEvent", function(owner, eventName, arg1, ...)
            C_Timer.After(0.25, function(...)
                self:ProcessEvent(eventName, arg1, ...)
            end)
        end)
        self.eventFrame = frame
    end

    do
        ---@param owner GossipExtension
        local function OnDelveInProgressChanged(owner)
            if not DelveCompanion.ProgressTracker.isDelveInProgress then
                self:StartExitTimer()
            end
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_IN_PROGRESS,
            OnDelveInProgressChanged, self)
    end
end

---@param self GossipExtension
function GossipExtension:ProcessEvent(eventName, arg1, ...)
    if eventName == "GOSSIP_SHOW" then
        if arg1 ~= DELVE_PICKER_KIT or not DelvesDifficultyPickerFrame:IsShown() then
            return
        end
        -- Logger:Log("[GossipExtension] Delve Gossip shown...")

        if not self.isDiffPickerSetupDone then
            self:SetupDiffPicker()
        end

        local isCompleted, isNemesis, isBountiful = self:GetDelveInfo()
        if DelveCompanionAccountData.displayStoryStatusInGossip and not isNemesis then
            self:DisplayStoryStatus(isCompleted)
        end
        self.LootInfoButton:SetShown(not isNemesis)
        self.AutoEnterCheckbox:SetShown(not isNemesis)
        self.AutoEnterCheckbox:SetChecked(DelveCompanionAccountData.delveAutoEnterEnabled)
        self:UpdateEnterButton(0)

        if DelveCompanionAccountData.delveAutoEnterEnabled then
            local tier = C_DelvesUI.HasActiveDelve() and self:GetDelveInProgressTier()
                or DelveCompanionAccountData.delveAutoEnterTier

            if tier < 1 or tier > DelveCompanion:GetDelvesMaxTier() then
                return
            end

            local canEnter = not isNemesis
                and not DelveCompanion.ProgressTracker.isDelveInProgress
                and not self.exitTimer
                and self:CanAutoEnter(tier, isBountiful)

            if canEnter then
                -- Logger:Log("[GossipExtension] Can enter Tier %d", tier)

                local delay = DelveCompanionAccountData.delveAutoEnterDelaySec
                if delay > 0 then
                    self.CancelAutoEnterButton:Show()
                    -- Logger:Log("[GossipExtension] Entering Tier %d in %d seconds.", tier, delay)
                    self:EnterWithDelay(delay, tier)
                else
                    self:EnterDelve(tier)
                end
            end
        end
    end
end

-- Prepare necessary elements in [DelvesDifficultyPickerFrame](https://www.townlong-yak.com/framexml/live/Blizzard_DelvesDifficultyPicker/Blizzard_DelvesDifficultyPicker.xml).
---@param self GossipExtension
function GossipExtension:SetupDiffPicker()
    self:CreateLootInfoButton()
    self:CreateAutoEnterCancelButton()
    self:CreateAutoEnterCheckbox()

    DelvesDifficultyPickerFrame:HookScript("OnHide", function()
        self.exitTimer = false
        self.autoEnterCancelled = false

        self.LootInfoButton:Hide()
        DelveCompanion:GetLootInfoFrame():Hide()
        self.CancelAutoEnterButton:Hide()
        self.AutoEnterCheckbox:Hide()
    end)

    self.isDiffPickerSetupDone = true
end

-- Determine which Delve player is going to enter and retrieve its params from DelveData.
---@param self GossipExtension
---@return boolean isStoryCompleted Whether the active Story Variant is completed.
---@return boolean isNemesis Whether it's a Nemesis Delve.
---@return boolean isBountiful Whether the Delve is Bountiful now.
function GossipExtension:GetDelveInfo()
    local delveName = C_GossipInfo.GetText()
    local isCompleted, isNemesis, isBountiful = false, false, false

    for _, expansionDelves in pairs(DelveCompanion.Variables.delvesData) do
        for _, data in pairs(expansionDelves) do
            if strmatch(delveName, data.delveName) then
                if data.config.nemesisInfo then
                    isNemesis = true
                else
                    isCompleted = data.isStoryCompleted
                    isBountiful = data.isBountiful
                end
                break
            end
        end
    end

    return isCompleted, isNemesis, isBountiful
end

-- Get Tier of the in progress Delve.
---@param self GossipExtension
---@return number
function GossipExtension:GetDelveInProgressTier()
    local optionInfo = C_GossipInfo.GetActiveDelveGossip()
    if not optionInfo then
        -- Presumably, it cannot happen. But if does, return a tier that's higher than possible.
        local impossibleTier = DelveCompanion:GetDelvesMaxTier() + 1
        return impossibleTier
    end

    return optionInfo.orderIndex + 1
end

-- Retrieve the highest unlocked Delve Tier stored in CVar. From [Blizzard_DelvesDifficultyPicker.lua](https://www.townlong-yak.com/framexml/live/Blizzard_DelvesDifficultyPicker/Blizzard_DelvesDifficultyPicker.lua)
---@param self GossipExtension
---@return number highestTier
function GossipExtension:GetHighestUnlockedTier()
    local HIGHEST_TIER_UNLOCKED_CVAR = "highestUnlockedTieredEntranceTier"
    local pdeID = C_DelvesUI.GetTieredEntrancePDEID()
    local defaultTier = 0

    return GetCVarTableValue(HIGHEST_TIER_UNLOCKED_CVAR, pdeID, defaultTier)

    -- TODO: Brutforce check. Remove it if the CVar way works fine.
    -- local options = C_GossipInfo.GetOptions()
    -- if options then
    --     local optionIndex = tier - 1
    --     for _, optionInfo in ipairs(options) do
    --         if optionInfo.orderIndex == optionIndex and optionInfo.status == Enum.GossipOptionStatus.Available then
    --             Logger:Log("[GossipExtension] Required Tier %d is Available.", tier)
    --             canEnter = true
    --             break
    --         end
    --     end
    -- end
end

-- Helper function to check that auto enter request is valid. Required primarly for the delayed entering.
---@param self GossipExtension
function GossipExtension:IsEnteringPossible()
    return DelvesDifficultyPickerFrame:IsShown()
        and not self.exitTimer
        and not self.autoEnterCancelled
end

--#region Auto Enter

---@param self GossipExtension
---@param tier number Tier the player wants to auto enter.
---@param isBountiful boolean Whether the Delve is Bountiful now.
---@return boolean canEnter Whether the Delve can be entered.
function GossipExtension:CanAutoEnter(tier, isBountiful)
    -- Logger:Log("[GossipExtension] Checking eligibility to enter Tier %d.", tier)

    local highestTier = self:GetHighestUnlockedTier()
    -- Logger:Log("[GossipExtension] Highest unlocked: Tier %d.", highestTier)

    -- if C_DelvesUI.HasActiveDelve() then
    --     local optionInfo = C_GossipInfo.GetActiveDelveGossip()
    --     if not optionInfo then
    --         return false
    --     end

    --     local activeTier = optionInfo.orderIndex + 1
    --     -- Logger:Log("[GossipExtension] Tier %d is already in progress.", activeTier)

    --     -- TODO: need to decide whether it's a good decision. For now seems not.
    --     -- if activeTier ~= tier then
    --     --     Logger:Log("[GossipExtension] Cannot enter: the active Tier %d doesn't match the desired Tier %d.",
    --     --         activeTier, tier)
    --     --     return false
    --     -- end

    --     if highestTier >= activeTier then
    --         return true
    --     end
    -- end

    -- Check that the desired Tier is available.
    if highestTier < tier then
        -- Logger:Log("[GossipExtension] Cannot enter: the desired Tier %d is unavailable.", tier)
        return false
    end


    -- Do not enter if no key for a Bountiful Delve.
    if isBountiful then
        local keysCount = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE).quantity
        local shardsCount = C_CurrencyInfo.GetCurrencyInfo(Config.KEY_SHARDS_CURRENCY_CODE).quantity

        if keysCount < 1 and shardsCount < Config.SHARDS_FOR_KEY then
            -- Logger:Log("[GossipExtension] Cannot enter Bountiful Delve: no keys.")
            return false
        end
    end

    return true
end

---@param self GossipExtension
---@param delaySec number A delay (in seconds) that should elapse before entering the Delve.
---@param tier number Delve Tier to enter.
function GossipExtension:EnterWithDelay(delaySec, tier)
    if not self:IsEnteringPossible() then
        return
    end

    -- Logger:Log("[GossipExtension] Auto Enter countdown: %d.", delaySec)
    self:UpdateEnterButton(delaySec)

    delaySec = delaySec - AUTO_ENTER_COUNTDOWN_TICK_SEC
    C_Timer.After(AUTO_ENTER_COUNTDOWN_TICK_SEC, function(cb)
        if delaySec > 0 then
            self:EnterWithDelay(delaySec, tier)
        else
            self:EnterDelve(tier)
        end
    end)
end

---@param self GossipExtension
---@param tier number Delve Tier to enter.
function GossipExtension:EnterDelve(tier)
    if not self:IsEnteringPossible() then
        return
    end

    -- Logger:Log("[GossipExtension] Entering Tier %d...", tier)
    C_GossipInfo.SelectOptionByIndex(tier - 1)
end

---@param self GossipExtension
function GossipExtension:StartExitTimer()
    self.exitTimer = true
    -- Logger:Log("[GossipExtension] Start Exit timer for: %d seconds.", EXIT_TIMER_SEC)

    C_Timer.After(EXIT_TIMER_SEC, function(cb)
        self.exitTimer = false
        -- Logger:Log("[GossipExtension]  Exit timer finished")
    end)
end

---@param self GossipExtension
---@param countdown number
function GossipExtension:UpdateEnterButton(countdown)
    if not DelvesDifficultyPickerFrame:IsShown() then
        return
    end

    ---@type Button
    local button = DelvesDifficultyPickerFrame.EnterDelveButton
    local defaultText = _G["DELVES_DIFFICULTY_PICKER_ENTER"]

    if countdown < 1 then
        button:SetText(defaultText)
    else
        local newText = string.format("%s: %d", defaultText, countdown)
        button:SetText(newText)
    end
end

---@param self GossipExtension
function GossipExtension:CancelAutoEnter()
    self.autoEnterCancelled = true
    self.CancelAutoEnterButton:Hide()
    self:UpdateEnterButton(0)
end

---@param self GossipExtension
function GossipExtension:CreateAutoEnterCancelButton()
    local button = CreateFrame("Button",
        "$DelveCompanion." .. CANCEL_AUTO_ENTER_BUTTON_PARENT_KEY,
        DelvesDifficultyPickerFrame,
        "UIPanelCloseButtonNoScripts")
    button:Hide()
    self.CancelAutoEnterButton = button

    local buttonSize = 40
    button:SetSize(buttonSize, buttonSize)
    button:SetParentKey(CANCEL_AUTO_ENTER_BUTTON_PARENT_KEY)
    button:SetPoint("LEFT", DelvesDifficultyPickerFrame.EnterDelveButton, "RIGHT", 10, -1)

    button:HookScript("OnClick", function()
        self:CancelAutoEnter()
    end)
    button:HookScript("OnEnter", function()
        local tooltip = GameTooltip
        tooltip:SetOwner(button, "ANCHOR_TOP")
        GameTooltip_AddInstructionLine(tooltip, Lockit.UI_DELVE_AUTO_ENTER_CANCEL_TOOLTIP_INSTRUCTION, true)

        tooltip:Show()
    end)
    button:HookScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

---@param self GossipExtension
function GossipExtension:CreateAutoEnterCheckbox()
    local cb = CreateFrame("CheckButton",
        "$DelveCompanion." .. AUTO_ENTER_CHECKBOX_PARENT_KEY,
        DelvesDifficultyPickerFrame,
        "UICheckButtonTemplate"
    )
    self.AutoEnterCheckbox = cb
    cb:SetPoint("BOTTOMLEFT", DelvesDifficultyPickerFrame, "BOTTOMLEFT", 0, 0)
    cb.Text:SetWidth(75)
    cb.Text:SetText(Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_NAME)

    cb:HookScript("OnShow", function()
        cb:SetChecked(DelveCompanionAccountData.delveAutoEnterEnabled)
    end)
    cb:HookScript("OnEnter", function()
        local tooltip = GameTooltip
        tooltip:SetOwner(cb, "ANCHOR_TOP")
        GameTooltip_SetTitle(tooltip,
            Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_NAME,
            HIGHLIGHT_FONT_COLOR)
        GameTooltip_AddNormalLine(tooltip, Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_TOOLTIP, true)

        tooltip:Show()
    end)
    cb:HookScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    cb:HookScript("OnClick", function()
        DelveCompanionAccountData.delveAutoEnterEnabled = cb:GetChecked()
    end)
end

--#endregion

--#region Story Variant status

---@param self GossipExtension
---@param isCompleted boolean Whether the active Story is completed.
function GossipExtension:DisplayStoryStatus(isCompleted)
    if not DelvesDifficultyPickerFrame:IsShown() then
        return
    end

    local sequence = isCompleted
        and string.format("|cnDIM_GREEN_FONT_COLOR:%s|r", Lockit.UI_DELVE_STORY_VARIANT_COMPLETED_SEQUENCE)
        or string.format("|cnWARNING_FONT_COLOR:%s|r", Lockit.UI_DELVE_STORY_VARIANT_NOT_COMPLETED_SEQUENCE)
    local statusText = string.format("|cnHIGHLIGHT_FONT_COLOR:%s:|r\n%s", _G["STORY_PROGRESS"], sequence)
    local descriptionText = string.format("%s\n\n%s", C_GossipInfo.GetCustomGossipDescriptionString(), statusText)

    DelvesDifficultyPickerFrame.Description:SetText(descriptionText)
end

--#endregion

--#region Loot Info

--- Add a button to open Delves' Loot info.
---@param self GossipExtension
function GossipExtension:CreateLootInfoButton()
    local button = CreateFrame("Button",
        "$DelveCompanion." .. LOOT_INFO_BUTTON_PARENT_KEY,
        DelvesDifficultyPickerFrame,
        "DelveCompanionLootInfoButtonTemplate")
    button:Hide()
    self.LootInfoButton = button

    button:SetParentKey(LOOT_INFO_BUTTON_PARENT_KEY)
    button:SetPoint("BOTTOMRIGHT", DelvesDifficultyPickerFrame, "BOTTOMRIGHT", -2, 3)
    button:SetTextToFit(_G["LOOT"])

    button:HookScript("OnClick", function()
        if InCombatLockdown() then
            return
        end

        GameTooltip:Hide()
        local lootFrame = DelveCompanion:GetLootInfoFrame()
        lootFrame:ClearAllPoints()
        lootFrame:SetPoint("BOTTOMLEFT", DelvesDifficultyPickerFrame, "BOTTOMRIGHT", 0, 0)

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

--#endregion
