local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

---@type table<number, string>
local RESPAWN_STATES = {
    [0] = "Unknown", -- Used for Reload UI and Logout cases in the midst of the Delve because there is no way to retrieve respawn state from the WoW API.
    [1] = "NotActivated",
    [2] = "Activated"
}

---@type string
local DISPLAY_RULE_SAVE_KEY = "inDelveWidgetDisplayRule"
--#endregion

---@class (exact) InDelveWidgetFrame : InDelveWidgetFrameXml
---@field isSet boolean
---@field delveExpansion number
---@field respawnState string
---@field Lure InDelveWidgetItem
---@field Map InDelveWidgetItem
---@field Radar InDelveWidgetItem
DelveCompanion_InDelveWidgetFrameMixin = {}

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:Refresh()
    if not self.isSet then
        return
    end

    do
        self:ClearAllPoints()

        ---@type string
        local point =
            DelveCompanionAccountData.inDelveWidgetDisplayRule ==
            DelveCompanion.Definitions.InDelveWidgetDisplayRule.left
            and "TOPRIGHT"
            or "TOPLEFT"

        ---@type string
        local relativePoint =
            DelveCompanionAccountData.inDelveWidgetDisplayRule ==
            DelveCompanion.Definitions.InDelveWidgetDisplayRule.left
            and "BOTTOMLEFT"
            or "BOTTOMRIGHT"

        self:SetPoint(point, ScenarioObjectiveTracker.Header, relativePoint, 0, 0)
    end

    local expansion = self.delveExpansion
    -- Nemesis Lure
    do
        local frame = self.Lure

        if (frame.itemCode) then
            local hasItemNow = C_Item.GetItemCount(frame.itemCode) > 0
            local isAvailable = hasItemNow                                          -- Has the lure
                and not C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) -- Can get the bounty map this week
                and (self.respawnState ~= RESPAWN_STATES[1])                        -- Respawn is activated
            frame:RefreshInteraction(isAvailable)
            frame:RefreshAnim(isAvailable and not frame.hasItem)

            frame.hasItem = hasItemNow
        end
    end

    -- Bounty Map
    do
        local frame = self.Map

        if (frame.itemCode) then
            local hasItemNow = C_Item.GetItemCount(frame.itemCode) > 0
            local activeBountySpell = DelveCompanion.Config.BOUNTY_ACTIVATED_SPELL[expansion]
            local isAvailable = hasItemNow                                       -- Has the bounty map
                and C_UnitAuras.GetPlayerAuraBySpellID(activeBountySpell) == nil -- Doesn't have an active map buff
            frame:RefreshInteraction(isAvailable)
            frame:RefreshAnim(isAvailable and not frame.hasItem)

            frame.hasItem = hasItemNow
        end
    end

    -- Loot Radar
    do
        local frame = self.Radar

        if (frame.itemCode) then
            local hasItemNow = C_Item.GetItemCount(frame.itemCode) > 0
            -- local activeRadarSpell = DelveCompanion.Config.LOOT_RADAR_ACTIVATED_SPELL
            local isAvailable = hasItemNow -- Has the radar
            --     and C_UnitAuras.GetPlayerAuraBySpellID(activeRadarSpell) == nil -- Doesn't have an active radar buff. IT DOES NOTHING as the aura is hidden at the moment.
            frame:RefreshInteraction(isAvailable)
            frame:RefreshAnim(isAvailable and not frame.hasItem)

            frame.hasItem = hasItemNow
        end
    end
end

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:PrepareWidget(isForced)
    local expansion = self.delveExpansion
    self.Lure:Set(Config.NEMESIS_LURE[expansion])
    self.Map:Set(Config.BOUNTY_MAPS[expansion])
    self.Radar:Set(Config.LOOT_RADAR_ITEM_CODE)

    self.respawnState = isForced and RESPAWN_STATES[0] or RESPAWN_STATES[1]
    self.isSet = true
end

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:ResetWidget()
    self.isSet = false
    self.respawnState = RESPAWN_STATES[0]
end

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:OnLoad()
    -- Logger.Log("[InDelveWidgetFrame] OnLoad start")

    self:ResetWidget()

    do
        local function CreateItem(name, parent, index)
            ---@type InDelveWidgetItem
            local widgetItem = CreateFrame("Frame", "$parent." .. name,
                parent,
                "DelvelCompanionInDelveWidgetItemTemplate")

            widgetItem.layoutIndex = index

            return widgetItem
        end

        local lure = CreateItem("Lure", self.Buttons, 1)
        self.Lure = lure
        local map = CreateItem("Map", self.Buttons, 2)
        self.Map = map
        local radar = CreateItem("Radar", self.Buttons, 3)
        self.Radar = radar

        self.Buttons:Layout()
    end

    do
        local function OnDelveRespawnActivated()
            self.respawnState = RESPAWN_STATES[2]
            self:Refresh()
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_RESPAWN_ACTIVATED,
            OnDelveRespawnActivated, self)
    end

    do
        local function OnSettingChanged(_, changedVarKey, newValue)
            if not (changedVarKey == DISPLAY_RULE_SAVE_KEY) then
                return
            end
            -- Logger.Log("[InDelveWidgetFrame] OnSettingChanged. Enabled: %s...", tostring(isEnabled))

            self:Refresh()
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.SETTING_CHANGE, OnSettingChanged, self)
    end
end

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:OnShow()
    -- Logger.Log("[InDelveWidgetFrame] OnShow start")

    self:Refresh()

    self:RegisterEvent("BAG_UPDATE")
end

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:OnEvent(event, ...)
    -- Logger.Log("[InDelveWidgetFrame] OnEvent start")

    C_Timer.After(0.5, function()
        self:Refresh()
    end)
end

---@param self InDelveWidgetFrame
function DelveCompanion_InDelveWidgetFrameMixin:OnHide()
    -- Logger.Log("[InDelveWidgetFrame] OnHide start")

    self:ResetWidget()

    self:UnregisterEvent("BAG_UPDATE")
end

--#region Xml annotations

--- `DelvelCompanionInDelveWidgetFrameTemplate`
---@class InDelveWidgetFrameXml : Frame
---@field Buttons VerticalLayoutFrame
--#endregion
