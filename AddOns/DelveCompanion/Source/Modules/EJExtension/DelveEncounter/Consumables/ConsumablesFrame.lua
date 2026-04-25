local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) DelveEncounterConsumablesFrame : DelveEncounterConsumablesFrameXml
DelveCompanion_DelveEncounterConsumablesFrameMixin = {}

--- Update consumables with the actual player's state.
---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:UpdateConsumables()
    -- Restored Coffer Keys
    do
        local keysCount = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE).quantity
        self.Keys:SetLabelText(keysCount)
        self.Keys.Icon:SetDesaturated(keysCount == 0)
    end

    ---@type number
    local expansion = DelveCompanion.EJExtension.DelveEncounter:GetExpansionForFaction(
        DelveCompanion.EJExtension.DelveEncounter:GetFactionIDs())

    if expansion == LE_EXPANSION_WAR_WITHIN then
        self.Keys:ClearAllPoints()
        ---@type string, number, number
        local point, xOffset, yOffset = "LEFT", 35, 0
        self.Keys:SetPoint(point, xOffset, yOffset)

        local echoCount = C_Item.GetItemCount(self.Echo.frameCode)
        self.Echo:SetLabelText(echoCount)
        self.Echo.Icon:SetDesaturated(echoCount == 0)
        self.Echo:Show()

        self.Shards:Hide()
        self.BountyMap:Hide()
        self.ManaCrystals:Hide()
    elseif expansion == LE_EXPANSION_MIDNIGHT then
        do
            self.Keys:ClearAllPoints()
            ---@type string, number, number
            local point, xOffset, yOffset = "TOPLEFT", 35, -22
            self.Keys:SetPoint(point, xOffset, yOffset)
            self.Echo:Hide()
        end

        ---@type string, number, CurrencyInfo
        local shardsLine, shardsCount, shardsInfo

        -- Coffer Key Shards
        do
            self.Shards:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, Config.KEY_SHARDS_CURRENCY_CODE)

            shardsInfo = C_CurrencyInfo.GetCurrencyInfo(Config.KEY_SHARDS_CURRENCY_CODE)
            shardsCount = shardsInfo.quantity

            shardsLine = tostring(shardsCount)
            if shardsCount >= Config.SHARDS_FOR_KEY then
                shardsLine = _G["GREEN_FONT_COLOR"]:WrapTextInColorCode(shardsLine)
                self.Shards.Icon:SetDesaturated(false)
            else
                shardsLine = _G["HIGHLIGHT_FONT_COLOR"]:WrapTextInColorCode(shardsLine)
                self.Shards.Icon:SetDesaturated(self.Shards.frameType == DelveCompanion.Definitions.CodeType.Item and
                    true
                    or shardsInfo.quantityEarnedThisWeek >= shardsInfo.maxWeeklyQuantity
                )
            end
            self.Shards:SetLabelText(shardsLine)
            self.Shards:Show()
        end

        -- Bounty Map
        do
            local mapCode = Config.BOUNTY_MAPS[expansion]

            self.BountyMap:SetFrameInfo(DelveCompanion.Definitions.CodeType.Item, mapCode)
            local macroText = string.format("/use item:%s", mapCode)
            self.BountyMap:SetInsecureAction({ type1 = "macro", macrotext = macroText })

            local mapsCount = C_Item.GetItemCount(mapCode)
            -- local mapsLine = tostring(mapsCount) -- TODO: re-enable if Tooltips stop being tainted...
            local mapsLine = string.format("%s", "|A:common-icon-redx:20:20|a")

            if mapsCount >= Config.BOUNTY_MAP_MAX_PER_WEEK then
                -- Has the Map in Inventory
                -- mapsLine = _G["GREEN_FONT_COLOR"]:WrapTextInColorCode(mapsLine) -- TODO: re-enable if Tooltips stop being tainted...
                mapsLine = string.format("%s", "|A:bag-main:20:20|a")
                self.BountyMap.Icon:SetDesaturated(false)
            elseif C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) then
                -- Looted and used already
                -- mapsLine = _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(mapsLine) -- TODO: re-enable if Tooltips stop being tainted...
                mapsLine = string.format("%s", "|A:common-icon-checkmark:20:20|a")
                self.BountyMap.Icon:SetDesaturated(true)
            else
                -- Map to be looted
                -- mapsLine = _G["HIGHLIGHT_FONT_COLOR"]:WrapTextInColorCode(mapsLine) -- TODO: re-enable if Tooltips stop being tainted...
                mapsLine = string.format("%s", "|A:common-icon-redx:20:20|a")
                self.BountyMap.Icon:SetDesaturated(false)
            end

            self.BountyMap:SetLabelText(mapsLine)
            self.BountyMap:Show()
        end

        -- Untainted Mana-Crystals
        do
            local crystalsInfo = C_CurrencyInfo.GetCurrencyInfo(Config.MANA_CRYSTALS_CURRENCY_CODE)
            local crystalsCount = crystalsInfo.discovered and crystalsInfo.quantity or 0
            self.ManaCrystals:SetLabelText(crystalsCount)
            self.ManaCrystals.Icon:SetDesaturated(crystalsCount == 0
                and crystalsInfo.quantityEarnedThisWeek >= crystalsInfo.maxWeeklyQuantity)
            self.ManaCrystals:Show()
        end
    end
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnLoad()
    -- Logger:Log("[DelveEncounterConsumablesFrame] OnLoad start")

    local defs = DelveCompanion.Definitions
    self.Keys:SetFrameInfo(defs.CodeType.Currency, Config.BOUNTIFUL_KEY_CURRENCY_CODE)
    self.ManaCrystals:SetFrameInfo(defs.CodeType.Currency, Config.MANA_CRYSTALS_CURRENCY_CODE)
    self.Echo:SetFrameInfo(defs.CodeType.Item, Config.ECHO_ITEM_CODE)
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnEvent(event, ...)
    -- Logger:Log("[DelveEncounterConsumablesFrame] OnEvent start")

    C_Timer.After(0.5, function()
        self:UpdateConsumables()
    end)
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnShow()
    -- Logger:Log("[DelveEncounterConsumablesFrame] OnShow start")

    self:UpdateConsumables()

    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:RegisterEvent("BAG_UPDATE")
end

---@param self DelveEncounterConsumablesFrame
function DelveCompanion_DelveEncounterConsumablesFrameMixin:OnHide()
    -- Logger:Log("[DelveEncounterConsumablesFrame] OnHide start")

    self:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:UnregisterEvent("BAG_UPDATE")
end

--#region XML Annotations

--- `DelveCompanionDelveEncounterConsumablesFrameTemplate`
---@class (exact) DelveEncounterConsumablesFrameXml : Frame
---@field Keys CustomActionWidget
---@field Shards CustomActionWidget
---@field Echo CustomActionWidget
---@field BountyMap CustomActionWidget
---@field ManaCrystals CustomActionWidget

--#endregion
