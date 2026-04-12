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

---@type string
local ENABLED_SAVE_KEY = "keysCapTooltipEnabled"
--#endregion

--- Compose a text with the amount of collected currency
---@param collected number
---@param max number
---@return string
local function GetCollectedText(collected, max)
    local wrapColor = collected ~= max
        and _G["GREEN_FONT_COLOR"]
        or _G["WHITE_FONT_COLOR"]

    local text = wrapColor:WrapTextInColorCode(
        format(_G["GENERIC_FRACTION_STRING"], collected, max))

    return text
end

--- Compose a locale for [Delver's Bounty](https://www.wowhead.com/item=233071/delvers-bounty) looted this week.
---@return string # Composed locale.
local function GetMapInfoText()
    local collectedCount = 0
    if C_QuestLog.IsQuestFlaggedCompleted(Config.BOUNTY_MAP_QUEST) then
        collectedCount = 1
    end

    local weekText = strtrim(format(_G["CURRENCY_THIS_WEEK"], ""))
    local mapAmountText = GetCollectedText(collectedCount, Config.BOUNTY_MAP_MAX_PER_WEEK)

    local mapInfoText = format("%s%s", _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(weekText .. ": "), mapAmountText)

    return mapInfoText
end

--- Helper function to parse a toltip and find a matching line by the pattern.
---@param tooltip GameTooltip
---@param matchPattern string
---@return FontString|nil # The matching line, or `nil` if no matching line is found or it contains a secret value.
local function FindLineInTooltip(tooltip, matchPattern)
    for i = 1, tooltip:NumLines(), 1 do
        ---@type FontString
        local line = _G["GameTooltipTextLeft" .. i]

        if line == nil then
            break
        end

        local text = line:GetText()

        if text == nil or issecretvalue(text) then
            break
        end

        if strmatch(text, matchPattern) then
            return line
        end
    end

    return nil
end

---@return boolean
local function CanProcessTooltip()
    if not DelveCompanionCharacterData[ENABLED_SAVE_KEY] then
        return false
    end
    if InCombatLockdown() then
        return false
    end

    return true
end

---@param tooltipDataHandler table [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@return table|nil data
local function GetPrimaryData(tooltipDataHandler)
    if tooltipDataHandler == nil or issecrettable(tooltipDataHandler) then
        return nil
    end

    local data = tooltipDataHandler:GetPrimaryTooltipData()
    if data == nil or issecrettable(data) then
        return nil
    end

    return data
end

--- Post Call for a `GameTooltip` of type `Enum.TooltipDataType.Currency`. Used to add additional lines into the tooltip.
---@param tooltipDataHandler table [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@param ... any
local function TooltipPostCallCurrency(tooltipDataHandler, ...)
    if not CanProcessTooltip() then
        return
    end

    local primaryData = GetPrimaryData(tooltipDataHandler)

    if primaryData == nil then
        return
    end
end

--- Post Call for a `GameTooltip` of type `Enum.TooltipDataType.Item`. Used to add additional lines into the tooltip.
---@param tooltipDataHandler table [TooltipDataHandlerMixin](https://www.townlong-yak.com/framexml/live/Blizzard_SharedXMLGame/TooltipDataHandler.lua#189).
---@param ... any
local function TooltipPostCallItem(tooltipDataHandler, ...)
    if not CanProcessTooltip() then
        return
    end

    local primaryData = GetPrimaryData(tooltipDataHandler)

    if primaryData == nil then
        return
    end

    local tooltipId = primaryData.id
    if tContains(Config.BOUNTY_MAPS, tooltipId) then
        -- Logger:Log("[TooltipExtension] Bounty map tooltip")

        ---@type string
        local lineToMatch = _G["ITEM_UNIQUE"]
        local line = FindLineInTooltip(tooltipDataHandler, lineToMatch)

        if line then
            local text = format(line:GetText() .. "\n%s", GetMapInfoText())
            line:SetText(text)
        end
    end
end

function DelveCompanion_TooltipExtension_Init()
    -- TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, TooltipPostCallCurrency) -- Not used at the moment
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, TooltipPostCallItem)
end
