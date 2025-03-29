local _G = _G
local AtlasLoot = _G.AtlasLoot
local Tooltip = {}
AtlasLoot.Tooltip = Tooltip

local STANDARD_TOOLTIP = "AtlasLootTooltip"

_G["AtlasLootTooltip"].shoppingTooltips = { ShoppingTooltip1, ShoppingTooltip2 }

local TooltipList = {
	"GameTooltip",
	"AtlasLootTooltip",
}

function Tooltip.GetTooltip()
	return _G[AtlasLoot.db.Tooltip.tooltip or STANDARD_TOOLTIP] or _G[STANDARD_TOOLTIP]
end

function Tooltip:AddTooltipSource(src)
	TooltipList[#TooltipList + 1] = src
end

function Tooltip:Refresh()
	AtlasLoot.db.Tooltip.tooltip = AtlasLoot.db.Tooltip.useGameTooltip and "GameTooltip" or "AtlasLootTooltip"
end
