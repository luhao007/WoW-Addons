local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--#region Constants

---@type string
local NEMESIS_ACTIVE_ATLAS = "GM-icon-difficulty-mythicSelected-hover"
local NEMESIS_INACTIVE_ATLAS = "GM-icon-difficulty-mythic-pressed"
--#endregion

--- A button representing a Delve in the Delves list.
---@class (exact) DelveInstanceButton : DelveInstanceButtonXml
---@field data DelveData?
---@field waypointTracker DelveWaypointTracker
DelveCompanion_DelveInstanceButtonMixin = {}

---@param self DelveInstanceButton
---@param data DelveData
function DelveCompanion_DelveInstanceButtonMixin:Init(data)
    self.data = data

    self.DelveName:SetText(data.delveName)
    if C_Texture.GetAtlasInfo(data.config.atlasBgID) ~= nil then
        self.DelveArtBg:SetAtlas(data.config.atlasBgID)
    end

    local waypointTracker = CreateFromMixins(DelveCompanion_DelveWaypointMixin)
    waypointTracker:Prepare()
    self.waypointTracker = waypointTracker

    self.RightIconsContainer:Layout()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:Refresh()
    self.BountifulIcon:SetShown(self.data.isBountiful)

    if self.data.config.nemesisInfo ~= nil then
        self.NemesisIcon:Show()
        self.NemesisIcon:SetAtlas(self.data.config.nemesisInfo.isCurrentSeason
            and NEMESIS_ACTIVE_ATLAS
            or NEMESIS_INACTIVE_ATLAS)

        local isLocked = UnitLevel("player") < self.data.levelRequired
        self.LockIcon:SetShown(isLocked)
        self.DelveArtBg:SetDesaturated(isLocked)
    else
        self.DelveArtBg:SetDesaturated(false)
        self.NemesisIcon:Hide()
        self.LockIcon:Hide()
    end

    do
        local achievements = self.data.config.achievements
        self.RightIconsContainer.NotCompletedStoryIcon:SetShown(
            achievements ~= nil
            and achievements.story ~= nil
            and not self.data.isStoryCompleted
        )
    end

    self.waypointTracker.Update(self.data)
    self.RightIconsContainer.WaypointIcon:SetShown(self.waypointTracker.isActive)

    self.RightIconsContainer:Layout()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnEvent(event, ...)
    self:Refresh()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnShow()
    -- Logger.Log("[DelveInstanceButton] OnShow start")

    self:RegisterEvent("SUPER_TRACKING_CHANGED")
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnHide()
    -- Logger.Log("[DelveInstanceButton] OnHide start")

    self:UnregisterEvent("SUPER_TRACKING_CHANGED")
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnEnter()
    -- Logger.Log("[DelveInstanceButton] OnEnter start")

    self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnLeave()
    -- Logger.Log("[DelveInstanceButton] OnLeave start")

    GameTooltip:Hide()
end

---@param self DelveInstanceButton
function DelveCompanion_DelveInstanceButtonMixin:OnClick()
    if self.waypointTracker:VerifyInput() then
        self.waypointTracker:ToggleTracking(self.data)
        self:Refresh()
        self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
    else
        -- EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.DELVE_INSTANCE_BUTTON_CLICK, self.data)
    end
end

--#region XML Annotations

---@class (exact) RightIconsContainer : HorizontalLayoutFrame
---@field WaypointIcon Frame
---@field NotCompletedStoryIcon Frame

--- `DelveCompanionDelveInstanceButtonTemplate`
---@class (exact) DelveInstanceButtonXml : Button
---@field DefaultBg Texture
---@field DelveArtBg Texture
---@field DelveName FontString
---@field BountifulIcon Texture
---@field NemesisIcon Texture
---@field LockIcon Texture
---@field RightIconsContainer RightIconsContainer
--#endregion
