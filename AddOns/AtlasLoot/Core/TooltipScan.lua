local _G = _G
local AtlasLoot = _G.AtlasLoot
local TooltipScan = {}
AtlasLoot.TooltipScan = TooltipScan

-- lua
local match, find = string.match, string.find

-- WoW
local GetSpellLink = C_Spell.GetSpellLink

local cache = {}
setmetatable(cache, { __mode = "kv" })

local AtlasLootScanTooltip = CreateFrame("GameTooltip", "AtlasLootScanTooltip", nil, "GameTooltipTemplate")
AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")

function TooltipScan.GetTradeskillLink(tradeskillID)
	if not tradeskillID then return end
	if cache[tradeskillID] then
		return cache[tradeskillID][1], cache[tradeskillID][2]
	end
	local TradeskillLink = nil
	local TradeskillName = nil
	AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootScanTooltip:ClearLines()
	AtlasLootScanTooltip:SetHyperlink("enchant:"..tradeskillID)
	AtlasLootScanTooltip:Show()
	local text = _G["AtlasLootScanTooltipTextLeft1"]:GetText()
	if text and find(text, ":") then
		TradeskillLink = "|cffffd000|Henchant:"..tradeskillID.."|h["..text.."]|h|r"
		TradeskillName = match(text, "(%w+):")
	else
		TradeskillLink = GetSpellLink(tradeskillID)
	end
	AtlasLootScanTooltip:Hide()
	cache[tradeskillID] = { TradeskillLink, TradeskillName }
	return TradeskillLink, TradeskillName
end
