-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local LibTSMData = select(2, ...).LibTSMData
local Prospect = LibTSMData:Init("Prospect")
local DATA = {}




-- ============================================================================
-- Module Functions
-- ============================================================================

function Prospect.Get()
	if LibTSMData.IsRetail() then
		return DATA.Retail
	elseif LibTSMData.IsPandaClassic() then
		return DATA.Panda
	elseif LibTSMData.IsVanillaClassic() then
		return DATA.Vanilla
	else
		error("Unknown game version")
	end
end



-- ============================================================================
-- Vanilla
-- ============================================================================

DATA.Vanilla = {
}



-- ============================================================================
-- Panda
-- ============================================================================

DATA.Panda = {
	-- Uncommon Gems
	["i:774"] = { -- Malachite
		["i:2770"] = {requiredSkill = 20, matRate = 0.5000, minAmount = 1, maxAmount = 1, amountOfMats = 0.1000}, -- Copper Ore
	},
	["i:818"] = { -- Tigerseye
		["i:2770"] = {requiredSkill = 20, matRate = 0.5000, minAmount = 1, maxAmount = 1, amountOfMats = 0.1000}, -- Copper Ore
	},
	["i:1210"] = { -- Shadowgem
		["i:2771"] = {requiredSkill = 50, matRate = 0.3600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0720}, -- Tin Ore
		["i:2770"] = {requiredSkill = 20, matRate = 0.1000, minAmount = 1, maxAmount = 1, amountOfMats = 0.0200}, -- Copper Ore
	},
	["i:1206"] = { -- Moss Agate
		["i:2771"] = {requiredSkill = 50, matRate = 0.3600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0720}, -- Tin Ore
	},
	["i:1705"] = { -- Lesser Moonstone
		["i:2771"] = {requiredSkill = 50, matRate = 0.3600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0720}, -- Tin Ore
		["i:2772"] = {requiredSkill = 125, matRate = 0.3300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0660}, -- Iron Ore
	},
	["i:1529"] = { -- Jade
		["i:2772"] = {requiredSkill = 125, matRate = 0.3300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0660}, -- Iron Ore
		["i:2771"] = {requiredSkill = 50, matRate = 0.0325, minAmount = 1, maxAmount = 1, amountOfMats = 0.0065}, -- Tin Ore
	},
	["i:3864"] = { -- Citrine
		["i:2772"] = {requiredSkill = 125, matRate = 0.3300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0660}, -- Iron Ore
		["i:3858"] = {requiredSkill = 175, matRate = 0.3300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0660}, -- Mithril Ore
		["i:2771"] = {requiredSkill = 50, matRate = 0.0325, minAmount = 1, maxAmount = 1, amountOfMats = 0.0065}, -- Tin Ore
	},
	["i:7909"] = { -- Aquamarine
		["i:3858"] = {requiredSkill = 175, matRate = 0.3300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0660}, -- Mithril Ore
		["i:2772"] = {requiredSkill = 125, matRate = 0.0500, minAmount = 1, maxAmount = 1, amountOfMats = 0.0100}, -- Iron Ore
		["i:2771"] = {requiredSkill = 50, matRate = 0.0325, minAmount = 1, maxAmount = 1, amountOfMats = 0.0065}, -- Tin Ore
	},
	["i:7910"] = { -- Star Ruby
		[ "i:3858"] = {requiredSkill = 175, matRate = 0.3300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0660}, -- Mithril Ore
		["i:10620"] = {requiredSkill = 250, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Thorium Ore
		[ "i:2772"] = {requiredSkill = 125, matRate = 0.0500, minAmount = 1, maxAmount = 1, amountOfMats = 0.0100}, -- Iron Ore
	},
	["i:12361"] = { -- Blue Sapphire
		["i:10620"] = {requiredSkill = 250, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Thorium Ore
		[ "i:3858"] = {requiredSkill = 175, matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:12799"] = { -- Large Opal
		["i:10620"] = {requiredSkill = 250, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Thorium Ore
		[ "i:3858"] = {requiredSkill = 175, matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:12800"] = { -- Azerothian Diamond
		["i:10620"] = {requiredSkill = 250, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Thorium Ore
		[ "i:3858"] = {requiredSkill = 175, matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:12364"] = { -- Huge Emerald
		["i:10620"] = {requiredSkill = 250, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Thorium Ore
		[ "i:3858"] = {requiredSkill = 175, matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:23117"] = { -- Azure Moonstone
		["i:23424"] = {requiredSkill = 275, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Adamantite Ore
	},
	["i:23077"] = { -- Blood Garnet
		["i:23424"] = {requiredSkill = 275, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Adamantite Ore
	},
	["i:23079"] = { -- Deep Peridot
		["i:23424"] = {requiredSkill = 275, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Adamantite Ore
	},
	["i:21929"] = { -- Flame Spessarite
		["i:23424"] = {requiredSkill = 275, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Adamantite Ore
	},
	["i:23112"] = { -- Golden Draenite
		["i:23424"] = {requiredSkill = 275, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Adamantite Ore
	},
	["i:23107"] = { -- Shadow Draenite
		["i:23424"] = {requiredSkill = 275, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.1700, minAmount = 1, maxAmount = 1, amountOfMats = 0.0340}, -- Adamantite Ore
	},
	["i:36917"] = { -- Bloodstone
		["i:36909"] = {requiredSkill = 350, matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0355}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36923"] = { -- Chalcedony
		["i:36909"] = {requiredSkill = 350, matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0355}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36932"] = { -- Dark Jade
		["i:36909"] = {requiredSkill = 350, matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0355}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36929"] = { -- Huge Citrine
		["i:36909"] = {requiredSkill = 350, matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0355}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36926"] = { -- Shadow Crystal
		["i:36909"] = {requiredSkill = 350, matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0355}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36920"] = { -- Sun Crystal
		["i:36909"] = {requiredSkill = 350, matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0355}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:52182"] = { -- Jasper
		["i:53038"] = {requiredSkill = 425, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52180"] = { -- Nightstone
		["i:53038"] = {requiredSkill = 425, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52178"] = { -- Zephyrite
		["i:53038"] = {requiredSkill = 425, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52179"] = { -- Alicite
		["i:53038"] = {requiredSkill = 425, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52177"] = { -- Carnelian
		["i:53038"] = {requiredSkill = 425, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52181"] = { -- Hessonite
		["i:53038"] = {requiredSkill = 425, matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:76130"] = { -- Tiger Opal
		["i:72092"] = {requiredSkill = 500, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76133"] = { -- Lapis Lazuli
		["i:72092"] = {requiredSkill = 500, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76134"] = { -- Sunstone
		["i:72092"] = {requiredSkill = 500, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76135"] = { -- Roguestone
		["i:72092"] = {requiredSkill = 500, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76136"] = { -- Pandarian Garnet
		["i:72092"] = {requiredSkill = 500, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76137"] = { -- Alexandrite
		["i:72092"] = {requiredSkill = 500, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},

	-- Rare Gems
	["i:23440"] = { -- Dawnstone
		["i:23424"] = {requiredSkill = 275, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.0350, minAmount = 1, maxAmount = 1, amountOfMats = 0.0070}, -- Adamantite Ore
	},
	["i:23436"] = { -- Living Ruby
		["i:23424"] = {requiredSkill = 275, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.0350, minAmount = 1, maxAmount = 1, amountOfMats = 0.0070}, -- Adamantite Ore
	},
	["i:23441"] = { -- Nightseye
		["i:23424"] = {requiredSkill = 275, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.0350, minAmount = 1, maxAmount = 1, amountOfMats = 0.0070}, -- Adamantite Ore
	},
	["i:23439"] = { -- Noble Topaz
		["i:23424"] = {requiredSkill = 275, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.0350, minAmount = 1, maxAmount = 1, amountOfMats = 0.0070}, -- Adamantite Ore
	},
	["i:23438"] = { -- Star of Elune
		["i:23424"] = {requiredSkill = 275, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.0350, minAmount = 1, maxAmount = 1, amountOfMats = 0.0070}, -- Adamantite Ore
	},
	["i:23437"] = { -- Talasite
		["i:23424"] = {requiredSkill = 275, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Fel Iron Ore
		["i:23425"] = {requiredSkill = 325, matRate = 0.0350, minAmount = 1, maxAmount = 1, amountOfMats = 0.0070}, -- Adamantite Ore
	},
	["i:36921"] = { -- Autumn's Glow
		["i:36909"] = {requiredSkill = 350, matRate = 0.0100, minAmount = 1, maxAmount = 2, amountOfMats = 0.0020}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.0350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0071}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Titanium Ore
	},
	["i:36933"] = { -- Forest Emerald
		["i:36909"] = {requiredSkill = 350, matRate = 0.0100, minAmount = 1, maxAmount = 2, amountOfMats = 0.0020}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.0350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0071}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Titanium Ore
	},
	["i:36930"] = { -- Monarch Topaz
		["i:36909"] = {requiredSkill = 350, matRate = 0.0100, minAmount = 1, maxAmount = 2, amountOfMats = 0.0020}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.0350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0071}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Titanium Ore
	},
	["i:36918"] = { -- Scarlet Ruby
		["i:36909"] = {requiredSkill = 350, matRate = 0.0100, minAmount = 1, maxAmount = 2, amountOfMats = 0.0020}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.0350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0071}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Titanium Ore
	},
	["i:36924"] = { -- Sky Sapphire
		["i:36909"] = {requiredSkill = 350, matRate = 0.0100, minAmount = 1, maxAmount = 2, amountOfMats = 0.0020}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.0350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0071}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Titanium Ore
	},
	["i:36927"] = { -- Twilight Opal
		["i:36909"] = {requiredSkill = 350, matRate = 0.0100, minAmount = 1, maxAmount = 2, amountOfMats = 0.0020}, -- Cobalt Ore
		["i:36912"] = {requiredSkill = 400, matRate = 0.0350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0071}, -- Saronite Ore
		["i:36910"] = {requiredSkill = 450, matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Titanium Ore
	},
	["i:52192"] = { -- Dream Emerald
		["i:53038"] = {requiredSkill = 425, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52193"] = { -- Ember Topaz
		["i:53038"] = {requiredSkill = 425, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52190"] = { -- Inferno Ruby
		["i:53038"] = {requiredSkill = 425, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52195"] = { -- Amberjewel
		["i:53038"] = {requiredSkill = 425, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52194"] = { -- Demonseye
		["i:53038"] = {requiredSkill = 425, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52191"] = { -- Ocean Sapphire
		["i:53038"] = {requiredSkill = 425, matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {requiredSkill = 475, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {requiredSkill = 500, matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:76131"] = { -- Primordial Ruby
		["i:72092"] = {requiredSkill = 500, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76138"] = { -- River's Heart
		["i:72092"] = {requiredSkill = 500, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76139"] = { -- Wild Jade
		["i:72092"] = {requiredSkill = 500, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76140"] = { -- Vermillion Onyx
		["i:72092"] = {requiredSkill = 500, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76141"] = { -- Imperial Amethyst
		["i:72092"] = {requiredSkill = 500, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76142"] = { -- Sun's Radiance
		["i:72092"] = {requiredSkill = 500, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {requiredSkill = 550, matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {requiredSkill = 600, matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},

	-- Epic Gems
	["i:36931"] = { -- Ametrine
		["i:36910"] = {requiredSkill = 450, matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0061}, -- Titanium Ore
	},
	["i:36919"] = { -- Cardinal Ruby
		["i:36910"] = {requiredSkill = 450, matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0061}, -- Titanium Ore
	},
	["i:36928"] = { -- Dreadstone
		["i:36910"] = {requiredSkill = 450, matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0061}, -- Titanium Ore
	},
	["i:36934"] = { -- Eye of Zul
		["i:36910"] = {requiredSkill = 450, matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0061}, -- Titanium Ore
	},
	["i:36922"] = { -- King's Amber
		["i:36910"] = {requiredSkill = 450, matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0061}, -- Titanium Ore
	},
	["i:36925"] = { -- Majestic Zircon
		["i:36910"] = {requiredSkill = 450, matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0061}, -- Titanium Ore
	},
}



-- ============================================================================
-- Retail
-- ============================================================================

DATA.Retail = {
	-- Uncommon Gems
	["i:774"] = { -- Malachite
		["i:2770"] = {matRate = 0.5000, minAmount = 1, maxAmount = 1, amountOfMats = 0.1000}, -- Copper Ore
	},
	["i:818"] = { -- Tigerseye
		["i:2770"] = {matRate = 0.5000, minAmount = 1, maxAmount = 1, amountOfMats = 0.1000}, -- Copper Ore
	},
	["i:1210"] = { -- Shadowgem
		["i:2771"] = {matRate = 0.3800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0800}, -- Tin Ore
		["i:2770"] = {matRate = 0.1000, minAmount = 1, maxAmount = 1, amountOfMats = 0.0200}, -- Copper Ore
	},
	["i:1206"] = { -- Moss Agate
		["i:2771"] = {matRate = 0.3800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0800}, -- Tin Ore
	},
	["i:1705"] = { -- Lesser Moonstone
		["i:2771"] = {matRate = 0.3800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0800}, -- Tin Ore
		["i:2772"] = {matRate = 0.3400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0700}, -- Iron Ore
	},
	["i:1529"] = { -- Jade
		["i:2772"] = {matRate = 0.3400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0700}, -- Iron Ore
		["i:2771"] = {matRate = 0.0325, minAmount = 1, maxAmount = 1, amountOfMats = 0.0065}, -- Tin Ore
	},
	["i:3864"] = { -- Citrine
		["i:2772"] = {matRate = 0.3800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0785}, -- Iron Ore
		["i:3858"] = {matRate = 0.3600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0745}, -- Mithril Ore
		["i:2771"] = {matRate = 0.0325, minAmount = 1, maxAmount = 1, amountOfMats = 0.0065}, -- Tin Ore
	},
	["i:7909"] = { -- Aquamarine
		["i:3858"] = {matRate = 0.3600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0745}, -- Mithril Ore
		["i:2772"] = {matRate = 0.0500, minAmount = 1, maxAmount = 1, amountOfMats = 0.0100}, -- Iron Ore
		["i:2771"] = {matRate = 0.0325, minAmount = 1, maxAmount = 1, amountOfMats = 0.0065}, -- Tin Ore
	},
	["i:7910"] = { -- Star Ruby
		[ "i:3858"] = {matRate = 0.3600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0745}, -- Mithril Ore
		["i:10620"] = {matRate = 0.1600, minAmount = 1, maxAmount = 2, amountOfMats = 0.0330}, -- Thorium Ore
		[ "i:2772"] = {matRate = 0.0500, minAmount = 1, maxAmount = 1, amountOfMats = 0.0100}, -- Iron Ore
	},
	["i:12361"] = { -- Blue Sapphire
		["i:10620"] = {matRate = 0.3050, minAmount = 1, maxAmount = 2, amountOfMats = 0.0660}, -- Thorium Ore
		[ "i:3858"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:12799"] = { -- Large Opal
		["i:10620"] = {matRate = 0.3050, minAmount = 1, maxAmount = 2, amountOfMats = 0.0660}, -- Thorium Ore
		[ "i:3858"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:12800"] = { -- Azerothian Diamond
		["i:10620"] = {matRate = 0.3050, minAmount = 1, maxAmount = 2, amountOfMats = 0.0660}, -- Thorium Ore
		[ "i:3858"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:12364"] = { -- Huge Emerald
		["i:10620"] = {matRate = 0.3050, minAmount = 1, maxAmount = 2, amountOfMats = 0.0660}, -- Thorium Ore
		[ "i:3858"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045}, -- Mithril Ore
	},
	["i:23117"] = { -- Azure Moonstone
		["i:23424"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Adamantite Ore
	},
	["i:23077"] = { -- Blood Garnet
		["i:23424"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Adamantite Ore
	},
	["i:23079"] = { -- Deep Peridot
		["i:23424"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Adamantite Ore
	},
	["i:21929"] = { -- Flame Spessarite
		["i:23424"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Adamantite Ore
	},
	["i:23112"] = { -- Golden Draenite
		["i:23424"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Adamantite Ore
	},
	["i:23107"] = { -- Shadow Draenite
		["i:23424"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Adamantite Ore
	},
	["i:36917"] = { -- Bloodstone
		["i:36909"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Saronite Ore
		["i:36910"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36923"] = { -- Chalcedony
		["i:36909"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Saronite Ore
		["i:36910"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36932"] = { -- Dark Jade
		["i:36909"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Saronite Ore
		["i:36910"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36929"] = { -- Huge Citrine
		["i:36909"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Saronite Ore
		["i:36910"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36926"] = { -- Shadow Crystal
		["i:36909"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Saronite Ore
		["i:36910"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:36920"] = { -- Sun Crystal
		["i:36909"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Saronite Ore
		["i:36910"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.5000}, -- Titanium Ore
	},
	["i:52182"] = { -- Jasper
		["i:53038"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52180"] = { -- Nightstone
		["i:53038"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52178"] = { -- Zephyrite
		["i:53038"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52179"] = { -- Alicite
		["i:53038"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52177"] = { -- Carnelian
		["i:53038"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:52181"] = { -- Hessonite
		["i:53038"] = {matRate = 0.2350, minAmount = 1, maxAmount = 2, amountOfMats = 0.0500}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.1800, minAmount = 1, maxAmount = 2, amountOfMats = 0.0365}, -- Elementium Ore
		["i:52183"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Pyrite Ore
	},
	["i:76130"] = { -- Tiger Opal
		["i:72092"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76133"] = { -- Lapis Lazuli
		["i:72092"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76134"] = { -- Sunstone
		["i:72092"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76135"] = { -- Roguestone
		["i:72092"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76136"] = { -- Pandarian Garnet
		["i:72092"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76137"] = { -- Alexandrite
		["i:72092"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.2335, minAmount = 1, maxAmount = 2, amountOfMats = 0.0494}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 1, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:130173"] = { -- Deep Amber
		["i:123918"] = {matRate = 0.0500, minAmount = 1, maxAmount = 2, amountOfMats = 0.0100}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0500, minAmount = 2, maxAmount = 5, amountOfMats = 0.0350}, -- Felslate
	},
	["i:130174"] = { -- Azsunite
		["i:123918"] = {matRate = 0.0500, minAmount = 1, maxAmount = 2, amountOfMats = 0.0100}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0500, minAmount = 2, maxAmount = 5, amountOfMats = 0.0350}, -- Felslate
	},
	["i:130176"] = { -- Skystone
		["i:123918"] = {matRate = 0.0500, minAmount = 1, maxAmount = 2, amountOfMats = 0.0100}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0500, minAmount = 2, maxAmount = 5, amountOfMats = 0.0350}, -- Felslate
	},
	["i:130177"] = { -- Queen's Opal
		["i:123918"] = {matRate = 0.0500, minAmount = 1, maxAmount = 2, amountOfMats = 0.0100}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0500, minAmount = 2, maxAmount = 5, amountOfMats = 0.0350}, -- Felslate
	},
	["i:130175"] = { -- Chaotic Spinel
		["i:123918"] = {matRate = 0.0500, minAmount = 1, maxAmount = 2, amountOfMats = 0.0100}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0500, minAmount = 2, maxAmount = 5, amountOfMats = 0.0350}, -- Felslate
	},
	["i:130172"] = { -- Sangrite
		["i:123918"] = {matRate = 0.0500, minAmount = 1, maxAmount = 2, amountOfMats = 0.0100}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0500, minAmount = 2, maxAmount = 5, amountOfMats = 0.0350}, -- Felslate
	},
	["i:153700"] = { -- Golden Beryl
		["i:152512"] = {matRate = 0.1800, minAmount = 1, maxAmount = 4, amountOfMats = 0.0550}, -- Monelite Ore
		["i:152579"] = {matRate = 0.1950, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.2100, minAmount = 1, maxAmount = 4, amountOfMats = 0.0660}, -- Platinum Ore
	},
	["i:153701"] = { -- Rubellite
		["i:152512"] = {matRate = 0.1800, minAmount = 1, maxAmount = 4, amountOfMats = 0.0550}, -- Monelite Ore
		["i:152579"] = {matRate = 0.1950, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.2100, minAmount = 1, maxAmount = 4, amountOfMats = 0.0660}, -- Platinum Ore
	},
	["i:153702"] = { -- Kubiline
		["i:152512"] = {matRate = 0.1800, minAmount = 1, maxAmount = 4, amountOfMats = 0.0550}, -- Monelite Ore
		["i:152579"] = {matRate = 0.1950, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.2100, minAmount = 1, maxAmount = 4, amountOfMats = 0.0660}, -- Platinum Ore
	},
	["i:153703"] = { -- Solstone
		["i:152512"] = {matRate = 0.1800, minAmount = 1, maxAmount = 4, amountOfMats = 0.0550}, -- Monelite Ore
		["i:152579"] = {matRate = 0.1950, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.2100, minAmount = 1, maxAmount = 4, amountOfMats = 0.0660}, -- Platinum Ore
	},
	["i:153704"] = { -- Viridium
		["i:152512"] = {matRate = 0.1800, minAmount = 1, maxAmount = 4, amountOfMats = 0.0550}, -- Monelite Ore
		["i:152579"] = {matRate = 0.1950, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.2100, minAmount = 1, maxAmount = 4, amountOfMats = 0.0660}, -- Platinum Ore
	},
	["i:153705"] = { -- Kyanite
		["i:152512"] = {matRate = 0.1800, minAmount = 1, maxAmount = 4, amountOfMats = 0.0550}, -- Monelite Ore
		["i:152579"] = {matRate = 0.1950, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.2100, minAmount = 1, maxAmount = 4, amountOfMats = 0.0660}, -- Platinum Ore
	},
	["i:173108"] = { -- Oriblase
		["i:171828"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Laestrite Ore
		["i:171829"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Solenium Ore
		["i:171830"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Oxxein Ore
		["i:171831"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Phaedrum Ore
		["i:171832"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Sinvyr Ore
		["i:171833"] = {matRate = 0.3333, minAmount = 2, maxAmount = 4, amountOfMats = 0.2000}, -- Elethium Ore
		["i:187700"] = {matRate = 1.0000, minAmount = 1, maxAmount = 3, amountOfMats = 0.4000}, -- Progenium Ore
	},
	["i:173109"] = { -- Angerseye
		["i:171828"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Laestrite Ore
		["i:171829"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Solenium Ore
		["i:171830"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Oxxein Ore
		["i:171831"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Phaedrum Ore
		["i:171832"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Sinvyr Ore
		["i:171833"] = {matRate = 0.3333, minAmount = 2, maxAmount = 4, amountOfMats = 0.2000}, -- Elethium Ore
		["i:187700"] = {matRate = 1.0000, minAmount = 1, maxAmount = 3, amountOfMats = 0.4000}, -- Progenium Ore
	},
	["i:173110"] = { -- Umbryl
		["i:171828"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Laestrite Ore
		["i:171829"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Solenium Ore
		["i:171830"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Oxxein Ore
		["i:171831"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Phaedrum Ore
		["i:171832"] = {matRate = 0.3333, minAmount = 1, maxAmount = 2, amountOfMats = 0.1000}, -- Sinvyr Ore
		["i:171833"] = {matRate = 0.3333, minAmount = 2, maxAmount = 4, amountOfMats = 0.2000}, -- Elethium Ore
		["i:187700"] = {matRate = 1.0000, minAmount = 1, maxAmount = 3, amountOfMats = 0.4000}, -- Progenium Ore
	},
	["i:192837"] = { -- Queen's Ruby *
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192838"] = { -- Queen's Ruby **
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192839"] = { -- Queen's Ruby ***
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192840"] = { -- Mystic Sapphire *
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192841"] = { -- Mystic Sapphire **
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192842"] = { -- Mystic Sapphire ***
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192843"] = { -- Vibrant Emerald *
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192844"] = { -- Vibrant Emerald **
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192845"] = { -- Vibrant Emerald ***
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192846"] = { -- Sundered Onyx *
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192847"] = { -- Sundered Onyx **
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192848"] = { -- Sundered Onyx ***
		["i:190395"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1250, minAmount = 1, maxAmount = 2, amountOfMats = 0.0252, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1900, minAmount = 1, maxAmount = 3, amountOfMats = 0.0401, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.1300, minAmount = 1, maxAmount = 3, amountOfMats = 0.0260, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.2500, minAmount = 1, maxAmount = 4, amountOfMats = 0.0712, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.1400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0281, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192849"] = { -- Eternity Amber *
		["i:190395"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.4600, minAmount = 1, maxAmount = 5, amountOfMats = 0.1226, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.3850, minAmount = 1, maxAmount = 2, amountOfMats = 0.0844, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192850"] = { -- Eternity Amber **
		["i:190395"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.4600, minAmount = 1, maxAmount = 5, amountOfMats = 0.1226, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.3850, minAmount = 1, maxAmount = 2, amountOfMats = 0.0844, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192851"] = { -- Eternity Amber ***
		["i:190395"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.3500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0772, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.4550, minAmount = 1, maxAmount = 4, amountOfMats = 0.1100, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.3450, minAmount = 1, maxAmount = 4, amountOfMats = 0.0760, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.4600, minAmount = 1, maxAmount = 5, amountOfMats = 0.1226, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.3850, minAmount = 1, maxAmount = 2, amountOfMats = 0.0844, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},

	-- Rare Gems
	["i:23440"] = { -- Dawnstone
		["i:23424"] = {matRate = 0.0150, minAmount = 1, maxAmount = 1, amountOfMats = 0.0030}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Adamantite Ore
	},
	["i:23436"] = { -- Living Ruby
		["i:23424"] = {matRate = 0.0150, minAmount = 1, maxAmount = 1, amountOfMats = 0.0030}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Adamantite Ore
	},
	["i:23441"] = { -- Nightseye
		["i:23424"] = {matRate = 0.0150, minAmount = 1, maxAmount = 1, amountOfMats = 0.0030}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Adamantite Ore
	},
	["i:23439"] = { -- Noble Topaz
		["i:23424"] = {matRate = 0.0150, minAmount = 1, maxAmount = 1, amountOfMats = 0.0030}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Adamantite Ore
	},
	["i:23438"] = { -- Star of Elune
		["i:23424"] = {matRate = 0.0150, minAmount = 1, maxAmount = 1, amountOfMats = 0.0030}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Adamantite Ore
	},
	["i:23437"] = { -- Talasite
		["i:23424"] = {matRate = 0.0150, minAmount = 1, maxAmount = 1, amountOfMats = 0.0030}, -- Fel Iron Ore
		["i:23425"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Adamantite Ore
	},
	["i:36921"] = { -- Autumn's Glow
		["i:36909"] = {matRate = 0.0150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0030}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Saronite Ore
		["i:36910"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Titanium Ore
	},
	["i:36933"] = { -- Forest Emerald
		["i:36909"] = {matRate = 0.0150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0030}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Saronite Ore
		["i:36910"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Titanium Ore
	},
	["i:36930"] = { -- Monarch Topaz
		["i:36909"] = {matRate = 0.0150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0030}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Saronite Ore
		["i:36910"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Titanium Ore
	},
	["i:36918"] = { -- Scarlet Ruby
		["i:36909"] = {matRate = 0.0150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0030}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Saronite Ore
		["i:36910"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Titanium Ore
	},
	["i:36924"] = { -- Sky Sapphire
		["i:36909"] = {matRate = 0.0150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0030}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Saronite Ore
		["i:36910"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Titanium Ore
	},
	["i:36927"] = { -- Twilight Opal
		["i:36909"] = {matRate = 0.0150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0030}, -- Cobalt Ore
		["i:36912"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Saronite Ore
		["i:36910"] = {matRate = 0.0400, minAmount = 1, maxAmount = 2, amountOfMats = 0.0081}, -- Titanium Ore
	},
	["i:52192"] = { -- Dream Emerald
		["i:53038"] = {matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52193"] = { -- Ember Topaz
		["i:53038"] = {matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52190"] = { -- Inferno Ruby
		["i:53038"] = {matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52195"] = { -- Amberjewel
		["i:53038"] = {matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52194"] = { -- Demonseye
		["i:53038"] = {matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:52191"] = { -- Ocean Sapphire
		["i:53038"] = {matRate = 0.0125, minAmount = 1, maxAmount = 1, amountOfMats = 0.0025}, -- Obsidium Ore
		["i:52185"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Elementium Ore
		["i:52183"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Pyrite Ore
	},
	["i:76131"] = { -- Primordial Ruby
		["i:72092"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76138"] = { -- River's Heart
		["i:72092"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76139"] = { -- Wild Jade
		["i:72092"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76140"] = { -- Vermillion Onyx
		["i:72092"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76141"] = { -- Imperial Amethyst
		["i:72092"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:76142"] = { -- Sun's Radiance
		["i:72092"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Ghost Iron Ore
		["i:72093"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Kyparite
		["i:72103"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- White Trillium Ore
		["i:72094"] = {matRate = 0.1600, minAmount = 1, maxAmount = 3, amountOfMats = 0.0341}, -- Black Trillium Ore
	},
	["i:130179"] = { -- Eye of Prophecy
		["i:123918"] = {matRate = 0.0100, minAmount = 1, maxAmount = 1, amountOfMats = 0.0020}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0100, minAmount = 2, maxAmount = 5, amountOfMats = 0.0020}, -- Felslate
	},
	["i:130180"] = { -- Dawnlight
		["i:123918"] = {matRate = 0.0100, minAmount = 1, maxAmount = 1, amountOfMats = 0.0020}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0100, minAmount = 2, maxAmount = 5, amountOfMats = 0.0020}, -- Felslate
	},
	["i:130182"] = { -- Maelstrom Sapphire
		["i:123918"] = {matRate = 0.0100, minAmount = 1, maxAmount = 1, amountOfMats = 0.0020}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0100, minAmount = 2, maxAmount = 5, amountOfMats = 0.0020}, -- Felslate
	},
	["i:130183"] = { -- Shadowruby
		["i:123918"] = {matRate = 0.0100, minAmount = 1, maxAmount = 1, amountOfMats = 0.0020}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0100, minAmount = 2, maxAmount = 5, amountOfMats = 0.0020}, -- Felslate
	},
	["i:130178"] = { -- FuryStone
		["i:123918"] = {matRate = 0.0100, minAmount = 1, maxAmount = 1, amountOfMats = 0.0020}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0100, minAmount = 2, maxAmount = 5, amountOfMats = 0.0020}, -- Felslate
	},
	["i:130181"] = { -- Pandemonite
		["i:123918"] = {matRate = 0.0100, minAmount = 1, maxAmount = 1, amountOfMats = 0.0020}, -- Leystone Ore
		["i:123919"] = {matRate = 0.0100, minAmount = 2, maxAmount = 5, amountOfMats = 0.0020}, -- Felslate
	},
	["i:154120"] = { -- Owlseye
		["i:152512"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0086}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.1150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0237}, -- Platinum Ore
	},
	["i:154121"] = { -- Scarlet Diamond
		["i:152512"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0086}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.1150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0237}, -- Platinum Ore
	},
	["i:154122"] = { -- Tidal Amethyst
		["i:152512"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0086}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.1150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0237}, -- Platinum Ore
	},
	["i:154123"] = { -- Amberblaze
		["i:152512"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0086}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.1150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0237}, -- Platinum Ore
	},
	["i:154124"] = { -- Laribole
		["i:152512"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0086}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.1150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0237}, -- Platinum Ore
	},
	["i:154125"] = { -- Royal Quartz
		["i:152512"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0086}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0750, minAmount = 1, maxAmount = 2, amountOfMats = 0.0152}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.1150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0237}, -- Platinum Ore
	},
	["i:192852"] = { -- Alexstraszite *
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192853"] = { -- Alexstraszite **
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192855"] = { -- Alexstraszite ***
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192856"] = { -- Malygite *
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192857"] = { -- Malygite **
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192858"] = { -- Malygite ***
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192859"] = { -- Ysemerald *
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192860"] = { -- Ysemerald **
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192861"] = { -- Ysemerald ***
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192862"] = { -- Neltharite *
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192863"] = { -- Neltharite **
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192865"] = { -- Neltharite ***
		["i:190395"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0425, minAmount = 1, maxAmount = 2, amountOfMats = 0.0085, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.1350, minAmount = 1, maxAmount = 3, amountOfMats = 0.0279, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.2000, minAmount = 1, maxAmount = 3, amountOfMats = 0.0409, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.6075, minAmount = 1, maxAmount = 5, amountOfMats = 0.1510, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0225, minAmount = 1, maxAmount = 1, amountOfMats = 0.0045, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192866"] = { -- Nozdorite *
		["i:190395"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.7125, minAmount = 1, maxAmount = 4, amountOfMats = 0.1815, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0900, minAmount = 1, maxAmount = 2, amountOfMats = 0.0180, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192867"] = { -- Nozdorite **
		["i:190395"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.7125, minAmount = 1, maxAmount = 4, amountOfMats = 0.1815, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0900, minAmount = 1, maxAmount = 2, amountOfMats = 0.0180, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192868"] = { -- Nozdorite ***
		["i:190395"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.1500, minAmount = 1, maxAmount = 3, amountOfMats = 0.0310, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.2750, minAmount = 1, maxAmount = 4, amountOfMats = 0.0602, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.3250, minAmount = 1, maxAmount = 4, amountOfMats = 0.0725, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.7125, minAmount = 1, maxAmount = 4, amountOfMats = 0.1815, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0900, minAmount = 1, maxAmount = 2, amountOfMats = 0.0180, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},

	-- Epic Gems
	["i:36931"] = { -- Ametrine
		["i:36910"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Titanium Ore
	},
	["i:36919"] = { -- Cardinal Ruby
		["i:36910"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Titanium Ore
	},
	["i:36928"] = { -- Dreadstone
		["i:36910"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Titanium Ore
	},
	["i:36934"] = { -- Eye of Zul
		["i:36910"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Titanium Ore
	},
	["i:36922"] = { -- King's Amber
		["i:36910"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Titanium Ore
	},
	["i:36925"] = { -- Majestic Zircon
		["i:36910"] = {matRate = 0.0450, minAmount = 1, maxAmount = 2, amountOfMats = 0.0091}, -- Titanium Ore
	},
	["i:151719"] = { -- Lightsphene
		["i:151564"] = {matRate = 0.0300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0060}, -- Empyrium
	},
	["i:151720"] = { -- Chemirine
		["i:151564"] = {matRate = 0.0300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0060}, -- Empyrium
	},
	["i:151722"] = { -- Florid Malachite
		["i:151564"] = {matRate = 0.0300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0060}, -- Empyrium
	},
	["i:151721"] = { -- Hesselian
		["i:151564"] = {matRate = 0.0300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0060}, -- Empyrium
	},
	["i:151718"] = { -- Argulite
		["i:151564"] = {matRate = 0.0300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0060}, -- Empyrium
	},
	["i:151579"] = { -- Labradorite
		["i:151564"] = {matRate = 0.0300, minAmount = 1, maxAmount = 1, amountOfMats = 0.0060}, -- Empyrium
	},
	["i:153706"] = { -- Kraken's Eye
		["i:152512"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Monelite Ore
		["i:152579"] = {matRate = 0.0400, minAmount = 1, maxAmount = 1, amountOfMats = 0.0080}, -- Storm Silver Ore
		["i:152513"] = {matRate = 0.0450, minAmount = 1, maxAmount = 1, amountOfMats = 0.0090}, -- Platinum Ore
	},
	["i:168188"] = { -- Sage Agate
		["i:168185"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Osmenite Ore
	},
	["i:168193"] = { -- Azsharine
		["i:168185"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Osmenite Ore
	},
	["i:168189"] = { -- Dark Opal
		["i:168185"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Osmenite Ore
	},
	["i:168190"] = { -- Lava Lazuli
		["i:168185"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Osmenite Ore
	},
	["i:168191"] = { -- Sea Currant
		["i:168185"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Osmenite Ore
	},
	["i:168192"] = { -- Sand Spinel
		["i:168185"] = {matRate = 0.1650, minAmount = 1, maxAmount = 1, amountOfMats = 0.0330}, -- Osmenite Ore
	},
	["i:168635"] = { -- Leviathan's Eye
		["i:168185"] = {matRate = 0.1500, minAmount = 1, maxAmount = 1, amountOfMats = 0.0300}, -- Osmenite Ore
	},
	["i:192869"] = { -- Illimited Diamond *
		["i:190395"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 1, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 1, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 1, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 1, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 1, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 1, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 1, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 1, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 1, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.0700, minAmount = 1, maxAmount = 2, amountOfMats = 0.0140, targetQuality = 1, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0035, minAmount = 1, maxAmount = 2, amountOfMats = 0.0007, targetQuality = 1, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192870"] = { -- Illimited Diamond **
		["i:190395"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 2, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 2, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 2, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 2, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 2, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 2, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 2, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 2, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 2, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.0700, minAmount = 1, maxAmount = 2, amountOfMats = 0.0140, targetQuality = 2, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0035, minAmount = 1, maxAmount = 2, amountOfMats = 0.0007, targetQuality = 2, sourceQuality = 1}, -- Magma Thresher
	},
	["i:192871"] = { -- Illimited Diamond ***
		["i:190395"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 3, sourceQuality = 1}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 3, sourceQuality = 2}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0055, minAmount = 1, maxAmount = 2, amountOfMats = 0.0011, targetQuality = 3, sourceQuality = 3}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 3, sourceQuality = 1}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 3, sourceQuality = 2}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.0142, minAmount = 1, maxAmount = 2, amountOfMats = 0.0028, targetQuality = 3, sourceQuality = 3}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 3, sourceQuality = 1}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 3, sourceQuality = 2}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.0300, minAmount = 1, maxAmount = 2, amountOfMats = 0.0060, targetQuality = 3, sourceQuality = 3}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.0700, minAmount = 1, maxAmount = 2, amountOfMats = 0.0140, targetQuality = 3, sourceQuality = 1}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.0035, minAmount = 1, maxAmount = 2, amountOfMats = 0.0007, targetQuality = 3, sourceQuality = 1}, -- Magma Thresher
	},

	-- Essences
	["i:173170"] = { -- Essence of Rebirth
		["i:171828"] = {matRate = 0.0265, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Laestrite Ore
		["i:171831"] = {matRate = 0.2150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0645}, -- Phaedrum Ore
		["i:171833"] = {matRate = 0.2550, minAmount = 1, maxAmount = 2, amountOfMats = 0.0765}, -- Elethium Ore
		["i:187700"] = {matRate = 0.0450, minAmount = 1, maxAmount = 3, amountOfMats = 0.0180}, -- Progenium Ore
	},
	["i:173171"] = { -- Essence of Torment
		["i:171828"] = {matRate = 0.0265, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Laestrite Ore
		["i:171832"] = {matRate = 0.2150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0645}, -- Sinvyr Ore
		["i:171833"] = {matRate = 0.2550, minAmount = 1, maxAmount = 2, amountOfMats = 0.0765}, -- Elethium Ore
		["i:187700"] = {matRate = 0.0450, minAmount = 1, maxAmount = 3, amountOfMats = 0.0180}, -- Progenium Ore
	},
	["i:173172"] = { -- Essence of Servitude
		["i:171828"] = {matRate = 0.0265, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Laestrite Ore
		["i:171830"] = {matRate = 0.2150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0645}, -- Oxxein Ore
		["i:171833"] = {matRate = 0.2550, minAmount = 1, maxAmount = 2, amountOfMats = 0.0765}, -- Elethium Ore
		["i:187700"] = {matRate = 0.0450, minAmount = 1, maxAmount = 3, amountOfMats = 0.0180}, -- Progenium Ore
	},
	["i:173173"] = { -- Essence of Valor
		["i:171828"] = {matRate = 0.0265, minAmount = 1, maxAmount = 2, amountOfMats = 0.0080}, -- Laestrite Ore
		["i:171829"] = {matRate = 0.2150, minAmount = 1, maxAmount = 2, amountOfMats = 0.0645}, -- Solenium Ore
		["i:171833"] = {matRate = 0.2550, minAmount = 1, maxAmount = 2, amountOfMats = 0.0765}, -- Elethium Ore
		["i:187700"] = {matRate = 0.0450, minAmount = 1, maxAmount = 3, amountOfMats = 0.0180}, -- Progenium Ore
	},

	-- Other
	["i:192880"] = { -- Crumbled Stone
		["i:190395"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.5700, minAmount = 1, maxAmount = 3, amountOfMats = 0.2848}, -- Magma Thresher
	},
	["i:192872"] = { -- Fractured Glass
		["i:190395"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Khaz'gorite Ore ***
		["i:194545"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Prismatic Ore
		["i:199344"] = {matRate = 0.4250, minAmount = 1, maxAmount = 4, amountOfMats = 0.2507}, -- Magma Thresher
	},
	["i:194545"] = { -- Prismatic Ore
		["i:190395"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Serevite Ore *
		["i:190396"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Serevite Ore **
		["i:190394"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Serevite Ore ***
		["i:189143"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Draconium Ore *
		["i:188658"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Draconium Ore **
		["i:190311"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Draconium Ore ***
		["i:190312"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Khaz'gorite Ore *
		["i:190313"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Khaz'gorite Ore **
		["i:190314"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Khaz'gorite Ore ***
		["i:199344"] = {matRate = 0.0300, minAmount = 1, maxAmount = 6, amountOfMats = 0.0060}, -- Magma Thresher
	},
}
