local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) DelveEncounterGildedStashFrame : DelveEncounterGildedStashFrameXml
---@field tooltipDesc string Cached toltip text of `Gilded Stash`.
DelveCompanion_DelveEncounterGildedStashFrameMixin = {}

--- Show tooltip hovering over `Gilded Stash` container.
---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:PrepareContainerTooltip()
    self.Widget:HookScript("OnEnter", function()
        local tooltip = GameTooltip
        tooltip:SetOwner(self.Widget, "ANCHOR_TOP")

        GameTooltip_AddNormalLine(tooltip, self.tooltipDesc, true)
        GameTooltip_AddBlankLineToTooltip(tooltip)
        GameTooltip_AddHighlightLine(tooltip, Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE, true)
        tooltip:Show()
    end)
    self.Widget:HookScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

--- Attempt to get information about `Gilded Stash` using Delves' `UiWidgetID`.
---@param self DelveEncounterGildedStashFrame
---@param expansion number Current expansion opened in EJ
---@return SpellDisplayVisualizationInfo|nil # Returns the 1st found widget info. Or `nil` if any found.
function DelveCompanion_DelveEncounterGildedStashFrameMixin:TryGetStashInfo(expansion)
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
function DelveCompanion_DelveEncounterGildedStashFrameMixin:OnLoad()
    -- Logger.Log("[DelveEncounterGildedStashFrame] OnLoad start")

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
    -- Logger.Log("[DelveEncounterGildedStashFrame] OnShow start")

    ---@type number
    local expansion = GetEJTierData(EJ_GetCurrentTier()).expansionLevel

    local stashDisplayInfo = self:TryGetStashInfo(expansion)
    if not stashDisplayInfo then
        if expansion == LE_EXPANSION_WAR_WITHIN then
            self.ErrorLabel:SetText(Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_TWW)
        elseif expansion == LE_EXPANSION_MIDNIGHT then
            self.ErrorLabel:SetText(Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_MIDNIGHT)
        end
        self.ErrorLabel:Show()
        self.Widget:Hide()
        return
    end

    self.tooltipDesc = stashDisplayInfo.spellInfo.tooltip

    C_Timer.After(0.15, function()
        local countStr = strmatch(self.tooltipDesc, _G["GENERIC_FRACTION_STRING"])
        local collectedCount = tonumber(strsub(countStr, 1, 1))
        local maxCount = tonumber(strsub(countStr, 3, 3))

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

        self.ErrorLabel:Hide()
        self.Widget:Show()
    end)
end

---@param self DelveEncounterGildedStashFrame
function DelveCompanion_DelveEncounterGildedStashFrameMixin:OnHide()
    -- Logger.Log("[DelveEncounterGildedStashFrame] OnHide start")

    self.Widget:Hide()
    self.ErrorLabel:Hide()
end

--#region XML Annotations

---@class (exact) DelveEncounterGildedStashWidgetXml : Frame
---@field Icon Texture
---@field FadeBg Texture
---@field CheckMark Texture
---@field RedX Texture

--- `DelveCompanionDelveEncounterGildedStashFrameTemplate`
---@class (exact) DelveEncounterGildedStashFrameXml : Frame
---@field ErrorLabel FontString
---@field Widget DelveEncounterGildedStashWidgetXml

--#endregion
