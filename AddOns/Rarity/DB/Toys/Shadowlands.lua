local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local shadowlandsToys = {
	-- 9.0 Toys
	["Borr-Geth's Fiery Brimstone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Borr-Geth's Fiery Brimstone"],
		itemId = 184312,
		npcs = {157833},
		chance = 4,
		questId = {57469},
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, x = 39.6, y = 40.8, n = L["Borr-Geth"]}
		}
	},
	["Ancient Elethium Coin"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Ancient Elethium Coin"],
		itemId = 184292,
		npcs = {162849},
		chance = 8,
		questId = {60987},
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, x = 16.4, y = 50.6, n = L["Morguliax"]}
		}
	},
	["Orophea's Lyre"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Orophea's Lyre"],
		itemId = 181794,
		npcs = {172577},
		chance = 2,
		questId = {61519},
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, x = 23.6, y = 21.6, n = L["Orophea"]}
		}
	},
	["Smolderheart"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Smolderheart"],
		itemId = 180873,
		npcs = {160857},
		chance = 25,
		questId = {58263},
		coords = {
			{m = CONSTANTS.UIMAPIDS.REVENDRETH, x = 34.08, y = 55.47, n = L["Sire Ladinas"]}
		}
	},
	["Regenerating Slime Vial"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Regenerating Slime Vial"],
		itemId = 184476,
		npcs = {162727},
		chance = 10,
		questId = {58870},
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 52.75, y = 35.28, n = L["Bubbleblood"]}
		}
	},
	["Malfunctioning Goliath Gauntlet"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Malfunctioning Goliath Gauntlet"],
		itemId = 184396,
		items = {180647},
		chance = 20, -- Estimate
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION}
		}
	},
	["Mark of Purity"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Mark of Purity"],
		itemId = 184435,
		items = {180647},
		chance = 20, -- Estimate
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION}
		}
	},
	["Infested Arachnid Casing"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Infested Arachnid Casing"],
		itemId = 184495,
		items = {180646},
		chance = 20, -- Estimate
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Acrobatic Steward"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Acrobatic Steward"],
		itemId = 184418,
		chance = 20, -- Average
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION}
		}
	},
	["Ever-Abundant Hearth"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Ever-Abundant Hearth"],
		itemId = 184404,
		npcs = {171009},
		chance = 8,
		questId = {60998},
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION, x = 51.4, y = 19.0, n = L["Enforcer Aegeon"]}
		}
	},
	["Soothing Vesper"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Soothing Vesper"],
		itemId = 184415,
		chance = 12, -- Average
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION}
		}
	},
	["Mnemonic Attunement Pane"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Mnemonic Attunement Pane"],
		itemId = 184413,
		npcs = {171008},
		chance = 10,
		questId = {60997},
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION, x = 43.6, y = 25.6, n = L["Unstable Memory"]}
		}
	},
	["Vixx's Chest of Tricks"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.LEGION,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Vixx's Chest of Tricks"],
		itemId = 152982,
		npcs = {127882},
		chance = 4,
		coords = {
			{m = CONSTANTS.UIMAPIDS.SEAT_OF_THE_TRIUMVIRATE}
		}
	},
	["Unstable Portal Emitter"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.LEGION,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Unstable Portal Emitter"],
		itemId = 153004,
		npcs = {127882},
		chance = 7,
		coords = {
			{m = CONSTANTS.UIMAPIDS.SEAT_OF_THE_TRIUMVIRATE}
		}
	},
	["Kevin's Party Supplies"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Kevin's Party Supplies"],
		itemId = 184447,
		chance = 11,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Battlecry of Krexus"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Battlecry of Krexus"],
		itemId = 184318,
		chance = 25,
		sourceText = L["Only members of the Necrolord covenant will be able to reach this cache."],
		questId = {60368},
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 44.1, y = 40.0, n = L["Blackhound Cache"]}
		}
	},
	["Blight-Touched Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Blight-Touched Egg"],
		itemId = 184104,
		npcs = {
			162258,
			162588,
			172390,
			162259,
			170456,
			162589,
			170893,
			164587
		},
		chance = 500,
		sourceText = L["Dropped by various flying creatures in Maldraxxus. Will hatch into Callow Flayedwing after five days."],
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Necroray Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Necroray Egg"],
		itemId = 184159,
		items = {181732, 181733},
		chance = 50,
		sourceText = L[
			"Sometimes contained in the caches awarded for completing any covenant's Calling in Maldraxxus. Will hatch into one of three Necroray mounts after three days."
		],
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	-- 9.1
	["Gravewing Crystal"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Gravewing Crystal"],
		itemId = 187283,
		npcs = {179985},
		chance = 100, -- Blind guess
		unique = true,
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.VENTHYR,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 45.8, y = 80.6, n = L["Stygian Stonecrusher"]},
		}
	},
	["Small Corpsefly Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Small Corpsefly Egg"],
		itemId = 187181,
		npcs = {180042},
		chance = 100, -- Blind guess
		unique = true,
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.NECROLORD,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 59.7, y = 43.3, n = L["Fleshwing"]},
		}
	},
	["Vesper of Harmony"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Vesper of Harmony"],
		isToy = true,
		itemId = 187176,
		npcs = {180032},
		chance = 100, -- Blind guess
		unique = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 47.0, y = 35.5, n = L["Wild Worldcracker"]}
		}
	},
	["Bonestorm Top"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Bonestorm Top"],
		isToy = true,
		itemId = 183901,
		npcs = {158025},
		chance = 100, -- Blind guess
		unique = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, x = 48.8, y = 81.4, n = L["Darklord Taraxis"]}
		}
	},
	["Vesper of Faith"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Vesper of Faith"],
		itemId = 187185,
		items = {185993},
		chance = 100, -- Blind guess
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Bottled Shade Heart"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Bottled Shade Heart"],
		isToy = true,
		itemId = 187139,
		npcs = {179735},
		chance = 100, -- Blind guess
		unique = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, x = 28.5, y = 24.9, n = L["Torglluun"]}
		}
	},
	["Maw-Ocular Viewfinder"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Maw-Ocular Viewfinder"],
		isToy = true,
		itemId = 187420,
		npcs = {179914},
		chance = 100, -- Blind guess
		unique = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 50.2, y = 75.4, n = L["Observer Yorik"]}
		}
	},
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.toys, shadowlandsToys)
