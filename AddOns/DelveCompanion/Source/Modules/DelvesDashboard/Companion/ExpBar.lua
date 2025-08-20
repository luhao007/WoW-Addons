local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@type DashboardCompanion
local DashboardCompanion = DelveCompanion.DelvesDashboard.Companion

--- Companion experience bar to display the current level progress.
---@class (exact) DashboardExpBar : DashboardExpBarXml
---@field factionID number Faction ID of the current season Companion.
---@field rankInfo FriendshipReputationRankInfo
---@field repInfo FriendshipReputationInfo
DelveCompanion_DashboardExpBarMixin = {}

--- Convert total experience gained into the current level progress.
---@param self DashboardExpBar
---@return number current Exp obtained on this level
---@return number needed Exp required to reach the next level
function DelveCompanion_DashboardExpBarMixin:GetLevelProgress()
    local repInfo = self.repInfo

    local current = repInfo.standing - repInfo.reactionThreshold
    local needed = repInfo.nextThreshold - repInfo.reactionThreshold

    return current, needed
end

--- Cache experience data.
---@param self DashboardExpBar
function DelveCompanion_DashboardExpBarMixin:RefreshExpProgress()
    self.rankInfo = C_GossipInfo.GetFriendshipReputationRanks(self.factionID)
    self.repInfo = C_GossipInfo.GetFriendshipReputation(self.factionID)
end

---@param self DashboardExpBar
function DelveCompanion_DashboardExpBarMixin:OnLoad()
    -- Logger.Log("DashboardExpBar OnLoad start")

    self:SetPoint("TOP", DashboardCompanion.ParentFrame.PanelTitle, "BOTTOM")

    self.factionID = C_DelvesUI.GetFactionForCompanion()
    self:SetStatusBarColor(_G["FACTION_GREEN_COLOR"]:GetRGB())
end

---@param self DashboardExpBar
function DelveCompanion_DashboardExpBarMixin:OnShow()
    -- Logger.Log("DashboardExpBar OnShow start")

    self:RefreshExpProgress()
    local companionRankInfo = self.rankInfo

    ---@type number
    local barValue = 1
    local barText = format(_G["LEVEL_GAINED"], companionRankInfo.currentLevel)

    if companionRankInfo.currentLevel < companionRankInfo.maxLevel then
        local current, needed = self:GetLevelProgress()
        barValue = current / needed
    else
        barText = format("%s (%s)", barText, _G["GUILD_RECRUITMENT_MAXLEVEL"])
    end

    self:SetValue(barValue)
    self.BarText:SetText(barText)
end

---@param self DashboardExpBar
function DelveCompanion_DashboardExpBarMixin:OnEnter()
    -- Logger.Log("DashboardExpBar OnEnter start")

    local tooltip = GameTooltip
    tooltip:SetOwner(self, "ANCHOR_TOP")

    local rankInfo = self.rankInfo
    local repInfo = self.repInfo
    local wrapText = true

    if rankInfo.maxLevel > 0 then
        GameTooltip_SetTitle(tooltip,
            format("%s (%d / %d)", repInfo.name, rankInfo.currentLevel, rankInfo.maxLevel),
            HIGHLIGHT_FONT_COLOR)
    else
        GameTooltip_SetTitle(tooltip, repInfo.name, HIGHLIGHT_FONT_COLOR)
    end

    ReputationUtil.TryAppendAccountReputationLineToTooltip(tooltip, self.factionID)

    GameTooltip_AddBlankLineToTooltip(tooltip)
    GameTooltip_AddNormalLine(tooltip, repInfo.text, wrapText)
    if repInfo.nextThreshold then
        local current, needed = self:GetLevelProgress()
        GameTooltip_AddHighlightLine(tooltip,
            format("%s (%d / %d)", repInfo.reaction, current, needed),
            wrapText)
    else
        GameTooltip_AddHighlightLine(tooltip, repInfo.reaction, wrapText)
    end

    tooltip:Show()
    DashboardCompanion.ParentFrame.PanelTitle:Hide()
end

---@param self DashboardExpBar
function DelveCompanion_DashboardExpBarMixin:OnLeave()
    -- Logger.Log("DashboardExpBar OnLeave start")

    GameTooltip:Hide()
    DashboardCompanion.ParentFrame.PanelTitle:Show()
end

--#region XML Annotations

--- `DelveCompanionDashboardExpBarTemplate`
---@class (exact) DashboardExpBarXml : StatusBar
---@field Background Texture
---@field BarText FontString

--#endregion
