local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) GildedStashWidgetState
---@field error number
---@field locked number
---@field info number
local WidgetState = {
    error = 1,
    locked = 2,
    info = 3
}

---@class (exact) DelveEncounterGildedStashFrame : DelveEncounterGildedStashFrameXml
---@field state GildedStashWidgetState
---@field tooltipDesc string Cached toltip text of `Gilded Stash`.
DelveCompanion_DelveEncounterGildedStashFrameMixin = {}

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:OnLoad()
    -- Logger:Log("[DelveEncounterGildedStashFrame] OnLoad start")

    self.state = WidgetState.error
    self.ErrorLabel:SetText(Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_MIDNIGHT)

    local stashSpell = Spell:CreateFromSpellID(Config.GILDED_STASH_SPELL_CODE)
    stashSpell:ContinueOnSpellLoad(function()
        ---@type string|number
        ---@diagnostic disable-next-line: undefined-field
        local spellTexture = stashSpell:GetSpellTexture()
        self.Widget.Icon:SetTexture(spellTexture)
    end)
    self:PrepareContainerTooltip()
end

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:OnShow()
    -- Logger:Log("[DelveEncounterGildedStashFrame] OnShow start")

    self:HideAll()
    self:UpdateState()

    C_Timer.After(0.15, function()
        self:Refresh()
        self.Widget.Icon:Show()
    end)
end

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:OnHide()
    -- Logger:Log("[DelveEncounterGildedStashFrame] OnHide start")

    self:HideAll()
end

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:HideAll()
    self.ErrorLabel:Hide()
    self.Widget.Icon:Hide()
    self.Widget.FadeBg:Hide()
    self.Widget.Lock:Hide()
    self.Widget.CheckMark:Hide()
    self.Widget.RedX:Hide()
    self.Widget:Hide()
end

--- Show tooltip hovering over `Gilded Stash` container.
---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:PrepareContainerTooltip()
    self.Widget:HookScript("OnEnter", function()
        local tooltip = GameTooltip
        tooltip:SetOwner(self.Widget, "ANCHOR_TOP")

        GameTooltip_AddNormalLine(tooltip, self.tooltipDesc, true)
        GameTooltip_AddBlankLineToTooltip(tooltip)
        GameTooltip_AddHighlightLine(tooltip,
            string.format(Lockit.UI_GILDED_STASH_CRESTS_NOTE, Config.GILDED_STASH_MYHT_CRESTS,
                select(2, self:GetStashDropCount()) * Config.GILDED_STASH_MYHT_CRESTS),
            true)
        if self.state == WidgetState.locked then
            GameTooltip_AddColoredLine(tooltip,
                string.format(Lockit.UI_JOURNEY_LEVEL_REQUIRED, Config.GILDED_STASH_MYTH_JOURNEY_LEVEL_REQUIRED),
                _G["WARNING_FONT_COLOR"],
                true)
        else
            GameTooltip_AddHighlightLine(tooltip, Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE, true)
        end
        tooltip:Show()
    end)

    self.Widget:HookScript("OnLeave", function()
        securecall(GameTooltip.Hide, GameTooltip)
    end)
end

--- Attempt to get information about `Gilded Stash` using Delves' `UiWidgetID`.
---@param self DelveEncounterGildedStashFrame
---@param expansion number Current expansion opened in EJ
---@return SpellDisplayVisualizationInfo|nil # Returns the 1st found widget info. Or `nil` if any found.
function DelveCompanion_DelveEncounterGildedStashFrameMixin:GetStashInfo(expansion)
    if not DelveCompanion:CanRetrieveDelveWidgetIDInfo(expansion) then
        return nil
    end

    for _, delveData in ipairs(DelveCompanion.Variables.delvesData[expansion]) do
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

---@param self DelveEncounterGildedStashFrame
---@return number collectedCount
---@return number maxCount
function DelveCompanion_DelveEncounterGildedStashFrameMixin:GetStashDropCount()
    local countStr = strmatch(self.tooltipDesc, _G["GENERIC_FRACTION_STRING"])
    local collectedCount = tonumber(strsub(countStr, 1, 1))
    local maxCount = tonumber(strsub(countStr, 3, 3))

    return collectedCount, maxCount
end

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:UpdateState()
    local data = DelveCompanion.EJExtension.DelveEncounter:GetFactionData()

    if not data then
        self.state = WidgetState.error
        return
    end

    local stashDisplayInfo = self:GetStashInfo(data.expansionID)
    if not stashDisplayInfo then
        self.state = WidgetState.error
        return
    end

    self.tooltipDesc = stashDisplayInfo.spellInfo.tooltip

    if data.renownLevel < Config.GILDED_STASH_MYTH_JOURNEY_LEVEL_REQUIRED then
        self.state = WidgetState.locked
        return
    end

    self.state = WidgetState.info
end

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:Refresh()
    -- Logger:Log("[DelveEncounterGildedStashFrame] Refresh")

    if self.state == WidgetState.error then
        self.ErrorLabel:Show()
    elseif self.state == WidgetState.locked then
        local widget = self.Widget
        widget.Icon:SetDesaturated(true)
        widget.FadeBg:Show()
        widget.Lock:Show()
        widget:Show()
    elseif self.state == WidgetState.info then
        local collectedCount, maxCount = self:GetStashDropCount()

        local widget = self.Widget

        if collectedCount >= maxCount then
            widget.CheckMark:Show()
            widget.FadeBg:Hide()
            widget.RedX:Hide()
        else
            widget.CheckMark:Hide()
            widget.FadeBg:Show()
            widget.RedX:Show()
        end

        self.Widget.Icon:SetDesaturated(false)
        self.Widget:Show()
    end
end

--#region XML Annotations

---@class (exact) DelveEncounterGildedStashWidgetXml : Frame
---@field Icon Texture
---@field FadeBg Texture
---@field CheckMark Texture
---@field RedX Texture
---@field Lock Texture

--- `DelveCompanionDelveEncounterGildedStashFrameTemplate`
---@class (exact) DelveEncounterGildedStashFrameXml : Frame
---@field ErrorLabel FontString
---@field Widget DelveEncounterGildedStashWidgetXml

--#endregion
