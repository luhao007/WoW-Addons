local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

---@type number
local UPDATE_ATTEMPT_FREQUENCY = 0.25
--#endregion

--- Frame to display information about Great Vault rewards.
---@class (exact) GVDetailsItem : GVDetailsItemXml
---@field rewardInfo WeeklyRewardActivityInfo Cached Great Vault reward info.
---@field unlocked boolean Whether this reward is unlocked.
---@field maxUpgraded boolean Whether this reward has reached maximum possible Item Level.
---@field nextLevel number Delve tier to be completed to increase reward Item Level.
---@field nextItemLevel number Item Level reward will become if `nextLevel` Delve tier is completed.
---@field updateTimer number Internal timer to handle frame `OnUpdate`.
DelveCompanion_GreatVaultItemMixin = {}

--- Update GV reward with the actual Great Vault progress.
---@param self GVDetailsItem
function DelveCompanion_GreatVaultItemMixin:Update()
    if self.rewardInfo.progress < self.rewardInfo.threshold then
        self.ItemInfoLabel:SetText(
            format(_G["GENERIC_FRACTION_STRING"], self.rewardInfo.progress, self.rewardInfo.threshold))
        return
    end

    self.ItemInfoLabel:Hide()
    -- Curent level info
    -- Logger.Log("Updating %s with id: %d", self:GetDebugName(), self.info.id)

    local itemLink, upgradeItemLink = C_WeeklyRewards.GetExampleRewardItemHyperlinks(self.rewardInfo.id)
    ---@type number?
    local itemLevel
    if itemLink then
        itemLevel = C_Item.GetDetailedItemLevelInfo(itemLink)
    end

    if not itemLevel then
        -- Logger.Log("Item level is not ready. Enable OnUpdate...")

        self.updateTimer = 0
        self:SetScript("OnUpdate", self.OnUpdate)
        return
    end

    self.ItemInfoLabel:SetText(format(_G["WEEKLY_REWARDS_ITEM_LEVEL_WORLD"], itemLevel, self.rewardInfo.level))
    self.ItemInfoLabel:Show()

    -- Upgrade level info

    if self.rewardInfo.level >= Config.GREAT_VAULT_UPGRADE_MAX_TIER then
        self.maxUpgraded = true
        return
    end

    ---@type number?
    local upgradeItemLevel
    if upgradeItemLink then
        upgradeItemLevel = C_Item.GetDetailedItemLevelInfo(upgradeItemLink)
    end

    if not upgradeItemLevel then
        -- Logger.Log("Item upgrade level is not ready. Enable OnUpdate...")

        self.updateTimer = 0
        self:SetScript("OnUpdate", self.OnUpdate)
        return
    end

    local hasData, _, nextLevel, nextItemLevel = C_WeeklyRewards.GetNextActivitiesIncrease(
        self.rewardInfo.activityTierID,
        self.rewardInfo.level)

    self.maxUpgraded = false
    if hasData then
        self.nextLevel = nextLevel
        self.nextItemLevel = nextItemLevel
    else
        self.nextLevel = self.rewardInfo.level + 1
        self.nextItemLevel = upgradeItemLevel
    end
end

--- If Great Vault data cannot be retrived, use `OnUpdate` to make another attempt.
---@param self GVDetailsItem
---@param delta number
function DelveCompanion_GreatVaultItemMixin:OnUpdate(delta)
    self.updateTimer = self.updateTimer + delta
    if self.updateTimer >= UPDATE_ATTEMPT_FREQUENCY then
        self.updateTimer = 0
        self:SetScript("OnUpdate", nil)
        self:Update()
    end
end

--- Tooltip format if a reward has reached maximum possible Item Level.
---@param self GVDetailsItem
function DelveCompanion_GreatVaultItemMixin:ShowMaxUpgradeTooltip()
    local tooltip = GameTooltip
    tooltip:SetOwner(self, "ANCHOR_RIGHT")

    GameTooltip_AddInstructionLine(tooltip, _G["WEEKLY_REWARDS_MAXED_REWARD"], true)

    -- Logger.Log("Show tooltip: max upgrade")
    tooltip:Show()
end

--- Tooltip format if a reward Item Level can be increased.
---@param self GVDetailsItem
function DelveCompanion_GreatVaultItemMixin:ShowUpgradeTooltip()
    local tooltip = GameTooltip
    tooltip:SetOwner(self, "ANCHOR_RIGHT")

    local improveLine = format(_G["WEEKLY_REWARDS_IMPROVE_ITEM_LEVEL"], self.nextItemLevel)
    GameTooltip_AddInstructionLine(tooltip, improveLine, true)

    local reqLine = format(_G["WEEKLY_REWARDS_COMPLETE_WORLD"], self.nextLevel)
    GameTooltip_AddHighlightLine(tooltip, reqLine, true)

    -- Logger.Log("Show tooltip: upgrade")
    tooltip:Show()
end

--- Tooltip format if a reward is not unlocked yet.
---@param self GVDetailsItem
function DelveCompanion_GreatVaultItemMixin:ShowLockedTooltip()
    local tooltip = GameTooltip
    tooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip_SetTitle(tooltip, _G["WEEKLY_REWARDS_UNLOCK_REWARD"], nil, true)

    local reqLine = _G["GREAT_VAULT_REWARDS_WORLD_INCOMPLETE"]
    if self.layoutIndex == 2 then
        reqLine = _G["GREAT_VAULT_REWARDS_WORLD_COMPLETED_FIRST"]
    elseif self.layoutIndex == 3 then
        reqLine = _G["GREAT_VAULT_REWARDS_WORLD_COMPLETED_SECOND"]
    end

    local diff = self.rewardInfo.threshold - self.rewardInfo.progress
    GameTooltip_AddNormalLine(tooltip, format(reqLine, diff), true)

    -- Logger.Log("Show tooltip: locked")
    tooltip:Show()
end

---@param self GVDetailsItem
function DelveCompanion_GreatVaultItemMixin:OnEnter()
    -- Logger.Log("%s OnEnter start", self:GetDebugName())
    if not self.unlocked then
        self:ShowLockedTooltip()
    elseif self.maxUpgraded then
        self:ShowMaxUpgradeTooltip()
    else
        self:ShowUpgradeTooltip()
    end
end

---@param self GVDetailsItem
function DelveCompanion_GreatVaultItemMixin:OnLeave()
    GameTooltip:Hide()
end

--#region XML Annotations

--- `DelveCompanionGreatVaultItemTemplate`
---@class (exact) GVDetailsItemXml : Frame
---@field layoutIndex number
---@field ItemInfoLabel FontString

--#endregion
