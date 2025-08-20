local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

--#endregion

--- Compose a locale for [Delver's Bounty](https://www.wowhead.com/item=233071/delvers-bounty) looted this week.
---@return string # Composed locale.
local function GetMapInfoText()
    local mapAmountWrapColor = _G["GREEN_FONT_COLOR"]
    local collectedCount = 0
    if C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) then
        mapAmountWrapColor = _G["WHITE_FONT_COLOR"]
        collectedCount = 1
    end

    local weekText = strtrim(format(_G["CURRENCY_THIS_WEEK"], ""))
    local mapAmountText = mapAmountWrapColor:WrapTextInColorCode(
        format(_G["GENERIC_FRACTION_STRING"], collectedCount, Config.BOUNTY_MAP_MAX_PER_WEEK))
    local mapInfoText = format("%s%s", _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(weekText .. ": "), mapAmountText)

    return mapInfoText
end

--- Compose a locale for number of [Restored Coffer Keys](https://www.wowhead.com/currency=3028/restored-coffer-key) player has got from Caches this week.
---@return string # Composed locale.
local function GetKeysInfoText()
    local weekText = strtrim(format(_G["CURRENCY_THIS_WEEK"], Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX))
    local keysCollected = DelveCompanion.Variables.keysCollected
    local maxKeys = #Config.BOUNTIFUL_KEY_QUESTS_DATA
    local keysAmountWrapColor = keysCollected ~= maxKeys
        and _G["GREEN_FONT_COLOR"]
        or _G["WHITE_FONT_COLOR"]

    local keysAmountText = keysAmountWrapColor:WrapTextInColorCode(format(_G["GENERIC_FRACTION_STRING"],
        keysCollected, maxKeys))
    local keysInfoText = format("%s%s", _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(weekText .. ": "),
        keysAmountText)

    return keysInfoText
end

--- Helper function to parse a toltip and find a matching line by the pattern.
---@param tooltip GameTooltip
---@param matchPattern string
---@return FontString|nil # The matching line, or `nil` if no matching line is found.
local function FindLineInTooltip(tooltip, matchPattern)
    for i = 1, tooltip:NumLines(), 1 do
        ---@type FontString
        local line = _G["GameTooltipTextLeft" .. i]
        if line and line:GetText() and strmatch(line:GetText(), matchPattern) then
            return line
        end
    end

    return nil
end

--- Post Call for a `GameTooltip` of type `Enum.TooltipDataType.Currency`. Used to add additional lines into the tooltip.
---@param tooltipDataHandler any [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@param ... any
local function TooltipPostCallCurrency(tooltipDataHandler, ...)
    if not DelveCompanionCharacterData.keysCapTooltipEnabled then
        return
    end

    local tooltipId = tooltipDataHandler:GetPrimaryTooltipData().id
    if tooltipId == Config.BOUNTIFUL_KEY_CURRENCY_CODE then
        local lineToMatch = format(_G["CURRENCY_TOTAL"], "", "%s*(.+)")
        local line = FindLineInTooltip(tooltipDataHandler, lineToMatch)

        if line then
            local text = format(line:GetText() .. "\n%s", GetKeysInfoText())
            line:SetText(text)
        end
    end
end

--- Post Call for a `GameTooltip` of type `Enum.TooltipDataType.Item`. Used to add additional lines into the tooltip.
---@param tooltipDataHandler any [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@param ... any
local function TooltipPostCallItem(tooltipDataHandler, ...)
    if not DelveCompanionCharacterData.keysCapTooltipEnabled then
        return
    end

    local tooltipId = tooltipDataHandler:GetPrimaryTooltipData().id
    if tooltipId == Config.BOUNTY_MAP_ITEM_CODE then
        local lineToMatch = _G["ITEM_UNIQUE"]
        local line = FindLineInTooltip(tooltipDataHandler, lineToMatch)

        if line then
            local text = format(line:GetText() .. "\n%s", GetMapInfoText())
            line:SetText(text)
        end
    elseif FindInTable(Config.BOUNTIFUL_KEY_SOURCE_CACHES_DATA, tooltipId) then
        local iconPath = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE).iconFileID
        local lineText = string.join("", GetKeysInfoText(), " |T", iconPath, ":20|t")
        GameTooltip_AddBlankLineToTooltip(tooltipDataHandler)
        GameTooltip_AddHighlightLine(tooltipDataHandler, lineText, true)
    end
end

function DelveCompanion_TooltipExtension_Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, TooltipPostCallCurrency)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, TooltipPostCallItem)

    EventRegistry:RegisterFrameEventAndCallback("QUEST_LOG_UPDATE", function()
        DelveCompanion:CacheKeysCount()
    end)
end
