local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--- Custom Great Vault frame in Delves UI.
---@class (exact) GVDetailsFrame : GVDetailsXml, WeeklyRewardMixin
---@field shouldRefresh boolean Whether the frame has to update rewards progress.
DelveCompanion_GreatVaultDetailsMixin = CreateFromMixins(WeeklyRewardMixin)

function DelveCompanion_GreatVaultDetailsMixin:SetStateLoading()
    self:GetParent().PanelDescription:Hide()
    self:GetParent().GreatVaultButton:Hide()

    self.GVButton:Hide()
    self.Rewards:Hide()
    self.LoadingLabel:Show()
end

function DelveCompanion_GreatVaultDetailsMixin:SetStateDefault()
    self:GetParent().PanelDescription:Show()
    self:GetParent().GreatVaultButton:Show()

    self.GVButton:Hide()
    self.Rewards:Hide()
    self.LoadingLabel:Hide()
end

function DelveCompanion_GreatVaultDetailsMixin:SetStateCustom()
    self:GetParent().PanelDescription:Hide()
    self:GetParent().GreatVaultButton:Hide()

    self.GVButton:Show()
    self.Rewards:Show()
    self.LoadingLabel:Hide()
end

function DelveCompanion_GreatVaultDetailsMixin:CanDisplayCustomState()
    return self:HasUnlockedRewards(Config.ACTIVITY_TYPE) and
        not (C_WeeklyRewards.HasAvailableRewards() or C_WeeklyRewards.HasGeneratedRewards())
end

function DelveCompanion_GreatVaultDetailsMixin:Refresh()
    if DelveCompanionCharacterData.gvDetailsEnabled and self:CanDisplayCustomState() then
        local activitiesInfo = C_WeeklyRewards.GetActivities(Config.ACTIVITY_TYPE)
        if not activitiesInfo then
            Logger.Log("Cannot get Activity info")
            return
        end

        for index, child in ipairs(self.Rewards:GetLayoutChildren()) do
            ---@type GVDetailsItem
            local gvItem = child

            gvItem.rewardInfo = activitiesInfo[index]
            gvItem.unlocked = self:GetNumUnlockedRewards(Config.ACTIVITY_TYPE) >= index
            gvItem:Update()
        end

        self:SetStateCustom()
    else
        self:SetStateDefault()
    end

    self.shouldRefresh = false
end

---@param self GVDetailsFrame
function DelveCompanion_GreatVaultDetailsMixin:OnLoad()
    -- Logger.Log("GreatVaultDetails OnLoad start")

    for i = 1, self:GetMaxNumRewards(Config.ACTIVITY_TYPE), 1 do
        ---@type GVDetailsItem
        local gvItem = CreateFrame("Frame", nil, self.Rewards, "DelveCompanionGreatVaultItemTemplate")
        gvItem.layoutIndex = i
    end
    self.Rewards:Layout()

    self.LoadingLabel:SetText(_G["SEARCH_LOADING_TEXT"])
    self.GVButton:SetTextToFit(_G["RAF_VIEW_ALL_REWARDS"])

    self.shouldRefresh = true

    EventRegistry:RegisterFrameEventAndCallback("WEEKLY_REWARDS_UPDATE", function()
        if self:IsShown() then
            self:Refresh()
        else
            self.shouldRefresh = true
        end
    end)
end

---@param self GVDetailsFrame
function DelveCompanion_GreatVaultDetailsMixin:OnShow()
    -- Logger.Log("GreatVaultDetails OnShow start")

    if self.shouldRefresh then
        self:Refresh()
    end
end

---@param self GVDetailsFrame
function DelveCompanion_GreatVaultDetailsMixin:OnHide()
    --Logger.Log("GreatVaultDetails OnHide start")
end

--#region XML Annotations

--- `DelveCompanionGreatVaultDetailsFrame`
---@class (exact) GVDetailsXml : Frame
---@field LoadingLabel FontString
---@field GVButton MagicButton
---@field Rewards VerticalLayoutFrame

--#endregion
