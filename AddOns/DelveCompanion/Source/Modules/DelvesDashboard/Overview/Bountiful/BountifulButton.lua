local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@class (exact) OverviewBountifulButton : OverviewBountifulButtonXml
---@field data DelveData
---@field waypointTracker DelveWaypointTracker
DelveCompanion_OverviewBountifulButtonMixin = {}

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnLoad()
    -- Logger.Log("OverviewBountifulButton OnLoad start")
    -- NOTE: BountifulButton is acquired from a FramePool so OnLoad is called only once per button lifetime.
    -- Only one-time initializations here.
end

---@param self OverviewBountifulButton
---@param data DelveData
---@param index number
function DelveCompanion_OverviewBountifulButtonMixin:Init(data, index)
    ---@diagnostic disable-next-line: inject-field
    self.layoutIndex = index
    self.data = data

    local waypointTracker = CreateFromMixins(DelveCompanion_DelveWaypointMixin)
    waypointTracker:Prepare()
    self.waypointTracker = waypointTracker
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:Update()
    self.waypointTracker.Update(self.data)
    self.WaypointIcon:SetShown(self.waypointTracker.isActive)

    ---@type number
    local achIcon = select(10, GetAchievementInfo(self.data.config.achievements.story))
    self.ArtBg:SetTexture(achIcon)
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnEvent(event, ...)
    self:Update()
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnShow()
    -- Logger.Log("OverviewBountifulButton OnShow start")

    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self:Update()
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnHide()
    self:UnregisterEvent("SUPER_TRACKING_CHANGED")
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnEnter()
    self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnLeave()
    GameTooltip:Hide()
end

---@param self OverviewBountifulButton
function DelveCompanion_OverviewBountifulButtonMixin:OnClick()
    if self.waypointTracker:VerifyInput() then
        self.waypointTracker:ToggleTracking(self.data)
        self:Update()
        self.waypointTracker:DisplayDelveTooltip(self, "ANCHOR_TOP", self.data)
    end
end

--#region XML Annotations

--- `DelveCompanionOverviewBountifulButtonTemplate`
---@class (exact) OverviewBountifulButtonXml : Button
---@field layoutIndex number
---@field Background Texture
---@field ArtBg Texture
---@field WaypointIcon Texture

--#endregion
