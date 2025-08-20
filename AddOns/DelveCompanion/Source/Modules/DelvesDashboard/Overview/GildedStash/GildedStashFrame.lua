local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) GildedStashFrame : GildedStashFrameXml
---@field tooltipDesc string Cached toltip text of `Gilded Stash`.
DelveCompanion_OverviewGildedStashFrameMixin = {}

--- Show tooltip hovering over `Gilded Stash` container.
---@param self GildedStashFrame
function DelveCompanion_OverviewGildedStashFrameMixin:PrepareContainerTooltip()
    self.Container:HookScript("OnEnter", function()
        local tooltip = GameTooltip
        tooltip:SetOwner(self.Container, "ANCHOR_TOP")

        GameTooltip_AddNormalLine(tooltip, self.tooltipDesc, true)
        GameTooltip_AddBlankLineToTooltip(tooltip)
        GameTooltip_AddHighlightLine(tooltip, Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE, true)
        tooltip:Show()
    end)
    self.Container:HookScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

--- Attempt to get information about `Gilded Stash` using Delves' `UiWidgetID`.
---@param self GildedStashFrame
---@return SpellDisplayVisualizationInfo|nil # Returns the 1st found widget info. Or `nil` if any found.
function DelveCompanion_OverviewGildedStashFrameMixin:TryGetStashInfo()
    if not DelveCompanion:CanRetrieveDelveWidgetIDInfo() then
        return nil
    end

    for _, delveData in ipairs(DelveCompanion.Variables.delvesData) do
        local uiWidgetID = delveData.config.gildedStashUiWidgetID
        if uiWidgetID then
            local result = C_UIWidgetManager.GetSpellDisplayVisualizationInfo(uiWidgetID)
            if result then
                return result
            end
        end
    end

    return nil
end

---@param self GildedStashFrame
function DelveCompanion_OverviewGildedStashFrameMixin:OnLoad()
    -- Logger.Log("GildedStash OnLoad start")

    local stashSpell = Spell:CreateFromSpellID(Config.GILDED_STASH_SPELL_CODE)
    stashSpell:ContinueOnSpellLoad(function()
        self.Name:SetText(stashSpell:GetSpellName())

        ---@type string|number
        ---@diagnostic disable-next-line: undefined-field
        local spellTexture = stashSpell:GetSpellTexture()
        for i = 1, Config.GILDED_STASH_WEEKLY_CAP, 1 do
            ---@type GildedStashItem
            local stash = CreateFrame("Frame", nil, self.Container,
                "DelveCompanionDashboardOverviewGildedStashItemTemplate")
            stash.layoutIndex = i
            stash.Icon:SetTexture(spellTexture)
        end
        self.Container:Layout()
    end)
    self:PrepareContainerTooltip()

    self.ErrorLabel:SetText(Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA)
end

---@param self GildedStashFrame
function DelveCompanion_OverviewGildedStashFrameMixin:OnShow()
    -- Logger.Log("GildedStash OnShow start")

    local stashDisplayInfo = self:TryGetStashInfo()
    if not stashDisplayInfo then
        self.ErrorLabel:Show()
        self.Container:Hide()
        return
    end

    self.tooltipDesc = stashDisplayInfo.spellInfo.tooltip

    C_Timer.After(0.15, function()
        local collectedCount = tonumber(
            strsub(strmatch(self.tooltipDesc, _G["GENERIC_FRACTION_STRING"]), 1, 1))

        for _, child in pairs(self.Container:GetLayoutChildren()) do
            ---@type GildedStashItem
            local stash = child

            if collectedCount >= stash.layoutIndex then
                stash.CheckMark:Show()
                stash.FadeBg:Hide()
                stash.RedX:Hide()
            else
                stash.CheckMark:Hide()
                stash.FadeBg:Show()
                stash.RedX:Show()
            end
        end

        self.ErrorLabel:Hide()
        self.Container:Show()
    end)
end

--#region XML Annotations

--- `DelveCompanionOverviewGildedStashFrameTemplate`
---@class (exact) GildedStashFrameXml : Frame
---@field Name FontString
---@field ErrorLabel FontString
---@field Container HorizontalLayoutFrame

--#endregion
