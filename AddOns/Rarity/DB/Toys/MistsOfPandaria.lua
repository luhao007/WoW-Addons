local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local mopToys = {
	-- Toys (5.x)
	["Ai-Li's Skymirror"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Ai-Li's Skymirror"],
		itemId = 86589,
		npcs = {50821},
		chance = 7,
		coords = {{m = 422, x = 34.8, y = 23.2}}
	},
	["Blackflame Daggers"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Blackflame Daggers"],
		itemId = 104302,
		npcs = {73171},
		chance = 100,
		coords = {{m = 554, x = 63.6, y = 43.6}}
	},
	["Chalice of Secrets"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Chalice of Secrets"],
		itemId = 86575,
		npcs = {50359},
		chance = 5,
		coords = {{m = 390, x = 39.8, y = 25}}
	},
	["Eternal Kiln"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Eternal Kiln"],
		itemId = 104309,
		npcs = {72896},
		chance = 250,
		coords = {{m = 554, x = 68.6, y = 35.2}}
	},
	["Farwater Conch"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Farwater Conch"],
		itemId = 86581,
		npcs = {50769},
		chance = 7,
		coords = {{m = 379, x = 74.4, y = 79.2}}
	},
	["Gastropod Shell"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Gastropod Shell"],
		itemId = 98136,
		npcs = {68220},
		chance = 150,
		coords = {{m = 510, x = 44.4, y = 80.4, i = true}}
	},
	["Hozen Beach Ball"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Hozen Beach Ball"],
		itemId = 86593,
		npcs = {50836},
		chance = 7,
		coords = {{m = 422, x = 55.4, y = 63.4}}
	},
	["Kang's Bindstone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Kang's Bindstone"],
		itemId = 86571,
		npcs = {50349},
		chance = 5,
		coords = {{m = 390, x = 15, y = 35.6}}
	},
	["Mr. Smite's Brass Compass"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Mr. Smite's Brass Compass"],
		itemId = 86568,
		npcs = {50336},
		chance = 10,
		coords = {{m = 390, x = 87.8, y = 44.6}}
	},
	["Odd Polished Stone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Odd Polished Stone"],
		itemId = 104262,
		npcs = {72970, 72809},
		chance = 250,
		sourceText = L[
			"This item has a 1 in 4 chance to drop from Golganarr, a rare spawn on Timeless Isle. It has a 1 in 250 chance to drop from Eroded Cliffdweller on Timeless Isle."
		],
		coords = {{m = 554, x = 63.4, y = 60.6}}
	},
	["Pandaren Firework Launcher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Pandaren Firework Launcher"],
		itemId = 86588,
		npcs = {50817},
		chance = 10,
		coords = {{m = 379, x = 40.8, y = 42.4}}
	},
	["Panflute of Pandaria"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Panflute of Pandaria"],
		itemId = 86586,
		npcs = {50806},
		chance = 7,
		coords = {{m = 390, x = 39.4, y = 53.6}}
	},
	["Rime of the Time-Lost Mariner"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Rime of the Time-Lost Mariner"],
		itemId = 104294,
		npcs = {73281},
		chance = 7,
		coords = {{m = 554, x = 25.8, y = 23.2}}
	},
	["Warning Sign"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Warning Sign"],
		itemId = 104331,
		npcs = {73169},
		chance = 100,
		coords = {{m = 554, x = 53.6, y = 83}}
	},
	-- Toys (7.x) -- some of these are toy conversions in 7.x but I marked them as the expansion they came out in
	["Aqua Jewel"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Aqua Jewel"],
		itemId = 86582,
		npcs = {50780},
		chance = 10,
		coords = {{m = 390, x = 69.6, y = 30.8, n = L["Sahn Tidehunter"]}}
	},
	["Essence of the Breeze"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Essence of the Breeze"],
		itemId = 86590,
		npcs = {50822},
		chance = 5,
		coords = {{m = 390, x = 42.6, y = 69.0, n = L["Ai-Ran the Shifting Cloud"]}}
	},
	["Hardened Shell"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Hardened Shell"],
		itemId = 86584,
		npcs = {50789},
		chance = 6,
		coords = {{m = 379, x = 63.8, y = 13.8, n = L["Nessos the Oracle"]}}
	}, -- Chelon and Great Turtle Furyshell drop the shell too with a 1.7% chance
	["Shard of Archstone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Shard of Archstone"],
		itemId = 86573,
		npcs = {50354},
		chance = 6,
		coords = {{m = 379, x = 57.6, y = 75.0, n = L["Havak"]}}
	},
	["Primal Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Primal Egg"],
		itemId = 94295,
		npcs = {
			69983,
			69991,
			69992,
			69993,
			70004,
			70005,
			70006,
			70007,
			70008,
			70009,
			70010,
			70011,
			70012,
			70013,
			70014,
			70015,
			70016,
			70017,
			70018,
			70019,
			70020,
			70021
		},
		chance = 100,
		unique = true,
		sourceText = L[
			"Dropped by dinosaurs on Isle of Giants Will hatch into one of three Primal Raptor mounts after three days."
		],
		coords = {{m = 507}}
	},
	["Skyshard"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.MOP,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		method = CONSTANTS.DETECTION_METHODS.ZONE,
		name = L["Skyshard"],
		spellId = 90655,
		itemId = 86547,
		zones = {"390", "395", "396", "1530", "1570"},
		chance = 1000,
		sourceText = L[
			"Dropped by any mob in Vale of Eternal Blossoms (except minor mobs). 10 of these can be combined to pierce Alani's shield, allowing combat and a guaranteed drop of Reins of the Thundering Ruby Cloud Serpent."
		],
		coords = {{m = 390}, {m = 395}, {m = 396}, {m = 1530}},
		repeatable = true
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.toys, mopToys)
