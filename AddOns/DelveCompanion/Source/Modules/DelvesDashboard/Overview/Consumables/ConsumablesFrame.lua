local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--- Frame with Delve-related consumables.
---@class (exact) OverviewConsumablesFrame : OverviewConsumablesFrameXml
DelveCompanion_OverviewConsumablesFrameMixin = {}

--- Update consumables with the actual player's state.
---@param self OverviewConsumablesFrame
function DelveCompanion_OverviewConsumablesFrameMixin:UpdateConsumables()
    -- Restored Coffer Keys
    do
        local keysCount = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE).quantity
        self.Keys:SetLabelText(keysCount)

        self.Keys.Icon:SetDesaturated(keysCount == 0 and
            DelveCompanion.Variables.keysCollected >= #Config.BOUNTIFUL_KEY_QUESTS_DATA)
    end

    -- Delver's Bounty
    do
        local mapsCount = C_Item.GetItemCount(Config.BOUNTY_MAP_ITEM_CODE)
        local mapsLine = tostring(mapsCount)

        if mapsCount >= Config.BOUNTY_MAP_MAX_PER_WEEK then
            mapsLine = _G["GREEN_FONT_COLOR"]:WrapTextInColorCode(mapsLine)
        elseif C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) then
            mapsLine = _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(mapsLine)
            self.BountyMap.Icon:SetDesaturated(true)
        else
            mapsLine = _G["HIGHLIGHT_FONT_COLOR"]:WrapTextInColorCode(mapsLine)
            self.BountyMap.Icon:SetDesaturated(false)
        end
        self.BountyMap:SetLabelText(mapsLine)
    end

    -- Coffer Key Shards
    do
        local shardsCount = C_Item.GetItemCount(Config.KEY_SHARD_ITEM_CODE)
        local shardsLine = tostring(shardsCount)
        if shardsCount >= Config.SHARDS_FOR_KEY then
            shardsLine = _G["GREEN_FONT_COLOR"]:WrapTextInColorCode(shardsLine)
            self.Shards.Icon:SetDesaturated(false)
        else
            shardsLine = _G["HIGHLIGHT_FONT_COLOR"]:WrapTextInColorCode(shardsLine)
            self.Shards.Icon:SetDesaturated(true)
        end
        self.Shards:SetLabelText(shardsLine)
    end

    -- Radiant Echo
    do
        local echoCount = C_Item.GetItemCount(Config.ECHO_ITEM_CODE)

        self.Echoes.Icon:SetDesaturated(echoCount == 0)
        self.Echoes:SetLabelText(echoCount)
    end
end

---@param self OverviewConsumablesFrame
function DelveCompanion_OverviewConsumablesFrameMixin:OnLoad()
    -- Logger.Log("OverviewConsumablesFrame OnLoad start")

    local defs = DelveCompanion.Definitions
    self.Keys:SetFrameInfo(defs.CodeType.Currency, Config.BOUNTIFUL_KEY_CURRENCY_CODE)
    do
        self.Shards:SetFrameInfo(defs.CodeType.Item, Config.KEY_SHARD_ITEM_CODE)
        local macroText = string.format("/use item:%s", Config.KEY_SHARD_ITEM_CODE)
        self.Shards:SetInsecureAction({ type1 = "macro", macrotext = macroText })
    end

    do
        self.BountyMap:SetFrameInfo(defs.CodeType.Item, Config.BOUNTY_MAP_ITEM_CODE)
        local macroText = string.format("/use item:%s", Config.BOUNTY_MAP_ITEM_CODE)
        self.BountyMap:SetInsecureAction({ type1 = "macro", macrotext = macroText })
    end
    self.Echoes:SetFrameInfo(defs.CodeType.Item, Config.ECHO_ITEM_CODE)
end

---@param self OverviewConsumablesFrame
function DelveCompanion_OverviewConsumablesFrameMixin:OnEvent(event, ...)
    -- Logger.Log("OverviewConsumablesFrame OnEvent start")

    C_Timer.After(0.5, function()
        self:UpdateConsumables()
    end)
end

---@param self OverviewConsumablesFrame
function DelveCompanion_OverviewConsumablesFrameMixin:OnShow()
    -- Logger.Log("OverviewConsumablesFrame OnShow start")

    DelveCompanion:CacheKeysCount()
    self:UpdateConsumables()

    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:RegisterEvent("BAG_UPDATE")
end

---@param self OverviewConsumablesFrame
function DelveCompanion_OverviewConsumablesFrameMixin:OnHide()
    -- Logger.Log("OverviewConsumablesFrame OnHide start")

    self:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:UnregisterEvent("BAG_UPDATE")
end

--#region XML Annotations

--- `DelveCompanionOverviewConsumablesFrameTemplate`
---@class (exact) OverviewConsumablesFrameXml : Frame
---@field Keys CustomActionWidget
---@field Shards CustomActionWidget
---@field BountyMap CustomActionWidget
---@field Echoes CustomActionWidget

--#endregion
