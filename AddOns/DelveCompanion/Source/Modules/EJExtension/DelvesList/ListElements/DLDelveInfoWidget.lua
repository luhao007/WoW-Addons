local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--#region

--#endregion

--- A widget displayed under a Delve button in the Delves list.
---@class (exact) DLDelveInfoWidget : DLDelveInfoWidgetXml
DelveCompanion_DLDelveInfoWidgetMixin = {}

---@param self DLDelveInfoWidget
function DelveCompanion_DLDelveInfoWidgetMixin:OnLoad()
end

---@param self DLDelveInfoWidget
---@param frame CustomActionWidget
---@param achID number
function DelveCompanion_DLDelveInfoWidgetMixin:PrepareWidgetElement(frame, achID)
    frame:SetFrameInfo(DelveCompanion.Definitions.CodeType.Achievement, achID)
    frame:SetOnClick(function() OpenAchievementFrameToAchievement(achID) end)
    frame:Show()
end

---@param self DLDelveInfoWidget
---@param delveAchievements DelveConfigAchievements
function DelveCompanion_DLDelveInfoWidgetMixin:Init(delveAchievements, canShowNemesis)
    -- Story progress
    if delveAchievements.story ~= nil then
        self:PrepareWidgetElement(self.Story, delveAchievements.story)
    else
        self.Story:Hide()
    end

    -- Chest progress
    if delveAchievements.chest ~= nil then
        self:PrepareWidgetElement(self.Chest, delveAchievements.chest)
    else
        self.Chest:Hide()
    end

    -- Nemesis progress
    if canShowNemesis then
        self:PrepareWidgetElement(self.NemesisSolo, delveAchievements.nemesisSolo)
    else
        self.NemesisSolo:Hide()
    end
end

---@param self DLDelveInfoWidget
function DelveCompanion_DLDelveInfoWidgetMixin:Refresh()
    -- Story progress
    if self.Story.frameCode ~= nil then
        local achID = self.Story.frameCode

        local totalCount = GetAchievementNumCriteria(achID)
        local completedCount = 0
        for index = 1, totalCount, 1 do
            ---@type boolean
            local completed = select(3, GetAchievementCriteriaInfo(achID, index))
            if completed then
                completedCount = completedCount + 1
            end
        end
        local text = format(_G["GENERIC_FRACTION_STRING"], completedCount, totalCount)
        if completedCount == totalCount then
            text = _G["DIM_GREEN_FONT_COLOR"]:WrapTextInColorCode(text)
        end
        self.Story:SetLabelText(text)
    end

    -- Chest progress
    if self.Chest.frameCode ~= nil then
        local achID = self.Chest.frameCode

        ---@type number, number
        local quantity, reqQuantity = select(4, GetAchievementCriteriaInfo(achID, 1))
        local text = format(_G["GENERIC_FRACTION_STRING"], quantity, reqQuantity)
        if quantity == reqQuantity then
            text = _G["DIM_GREEN_FONT_COLOR"]:WrapTextInColorCode(text)
        end
        self.Chest:SetLabelText(text)
    end

    -- Nemesis progress
    if self.NemesisSolo.frameCode ~= nil then
        local achID = self.NemesisSolo.frameCode

        ---@type boolean
        local completed = select(4, GetAchievementInfo(achID))

        ---@type number, number
        local quantity, reqQuantity = completed and 1 or 0, 1
        local text = format(_G["GENERIC_FRACTION_STRING"], quantity, reqQuantity)
        if completed then
            text = _G["DIM_GREEN_FONT_COLOR"]:WrapTextInColorCode(text)
        end
        self.NemesisSolo:SetLabelText(text)
    end
end

--#region Xml annotations

--- `DelveCompanionDLDelveInfoWidgetTemplate`
---@class DLDelveInfoWidgetXml : Frame
---@field Story CustomActionWidget
---@field Chest CustomActionWidget
---@field NemesisSolo CustomActionWidget
--#endregion
