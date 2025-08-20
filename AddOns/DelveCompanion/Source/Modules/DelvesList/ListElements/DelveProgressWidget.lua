local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--- Delve widget displayed for each Delve button in the Delves list.
---@class (exact) DelvesProgressWidget : DelvesProgressWidgetXml
DelveCompanion_DelveProgressWidgetMixin = {}

---@param self DelvesProgressWidget
function DelveCompanion_DelveProgressWidgetMixin:OnLoad()
    EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.SETTING_CHANGE,
        function(_, changedVarKey, newValue)
            if not (changedVarKey == "delveProgressWidgetsEnabled") then
                return
            end

            self:SetShown(newValue)
        end, self)

    self:SetShown(DelveCompanionAccountData.delveProgressWidgetsEnabled)
end

---@param self DelvesProgressWidget
function DelveCompanion_DelveProgressWidgetMixin:Init(storyAchID, chestAchID)
    local defs = DelveCompanion.Definitions

    -- Story progress
    do
        local achID = storyAchID
        self.Story:SetFrameInfo(defs.CodeType.Achievement, achID)

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
        self.Story:SetOnClick(function() OpenAchievementFrameToAchievement(achID) end)
    end

    -- Chest progress
    do
        local achID = chestAchID
        self.Chest:SetFrameInfo(defs.CodeType.Achievement, achID)

        ---@type number, number
        local quantity, reqQuantity = select(4, GetAchievementCriteriaInfo(achID, 1))
        local text = format(_G["GENERIC_FRACTION_STRING"], quantity, reqQuantity)
        if quantity == reqQuantity then
            text = _G["DIM_GREEN_FONT_COLOR"]:WrapTextInColorCode(text)
        end
        self.Chest:SetLabelText(text)
        self.Chest:SetOnClick(function() OpenAchievementFrameToAchievement(achID) end)
    end
end

--#region Xml annotations

--- `DelveCompanionDelveProgressWidgetTemplate`
---@class DelvesProgressWidgetXml : Frame
---@field Story CustomActionWidget
---@field Chest CustomActionWidget
--#endregion
