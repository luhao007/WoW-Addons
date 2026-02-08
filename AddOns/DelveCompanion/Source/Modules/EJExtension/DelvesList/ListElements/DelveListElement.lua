local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--#region Constants

---@type number
local ACHIEVEMENT_HIDE_INCOMPLETE_BIT = 0x800
---@type string
local INFO_WIDGET_SAVE_KEY = "delvesListInfoWidgetsEnabled"
--#endregion

--- Composit frame to display a Delve button and other related elements (progress widget, etc).
---@class (exact) DelveListElement : DelveListElementXml
DelveCompanion_DelveListElementMixin = {}

---@param self DelveListElement
---@param data DelveData
function DelveCompanion_DelveListElementMixin:Init(data)
    -- Logger.Log("[DelveListElement] Init: %s", data.delveName)

    self.InstanceButton:Init(data)
    self.InstanceButton:Refresh()

    if data.config.achievements and DelveCompanionAccountData[INFO_WIDGET_SAVE_KEY] then
        local canShowNemesis = false
        if data.config.nemesisInfo ~= nil then
            ---@type number,_,_,_,_,number
            local completed, _, _, _, _, flags = select(4, GetAchievementInfo(data.config.achievements.nemesisSolo))
            local isHidden = bit.band(flags, ACHIEVEMENT_HIDE_INCOMPLETE_BIT) > 0
            canShowNemesis = data.config.nemesisInfo.isCurrentSeason or completed or not isHidden
        end
        self.InfoWidget:Init(data.config.achievements, canShowNemesis)
        self.InfoWidget:Refresh()
        self.InfoWidget:Show()
    else
        self.InfoWidget:Hide()
    end
end

---@param self DelveListElement
function DelveCompanion_DelveListElementMixin:OnShow()
end

---@param self DelveListElement
function DelveCompanion_DelveListElementMixin:OnHide()
end

--#region XML Annotations

--- `DelveCompanionDelveListElementTemplate`
---@class (exact) DelveListElementXml : Frame
---@field InstanceButton DelveInstanceButton
---@field InfoWidget DLDelveInfoWidget
--#endregion
