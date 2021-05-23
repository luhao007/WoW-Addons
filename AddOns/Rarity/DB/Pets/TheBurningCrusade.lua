local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local tbcPets = {
	-- 2.x
	["Azure Whelpling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.ZONE,
		name = L["Azure Whelpling"],
		spellId = 10696,
		itemId = 34535,
		zones = {"83"},
		chance = 10000,
		creatureId = 7547,
		blackMarket = true,
		coords = {{m = 83}}
	},
	["Captured Firefly"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Captured Firefly"],
		spellId = 36034,
		itemId = 29960,
		npcs = {20197},
		chance = 1000,
		creatureId = 21076,
		blackMarket = true,
		coords = {{m = 102, x = 47.6, y = 32.6}}
	},
	["Mojo"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Mojo"],
		spellId = 43918,
		itemId = 33993,
		items = {33865},
		chance = 10,
		creatureId = 24480,
		coords = {{m = 333, x = 42, y = 52.9, i = true}}
	},
	["Phoenix Hatchling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Phoenix Hatchling"],
		spellId = 46599,
		itemId = 35504,
		npcs = {24664},
		chance = 11,
		creatureId = 26119,
		blackMarket = true,
		coords = {{m = 348, x = 8.6, y = 50.2, i = true, n = L["Kael'thas Sunstrider"]}}
	},
	["Chuck's Bucket"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Chuck's Bucket"],
		spellId = 46426,
		itemId = 35350,
		items = {35348},
		chance = 10,
		creatureId = 26056,
		coords = {{m = 111, x = 54.6, y = 39.6, n = L["Cupri"]}, {m = 108, x = 38.6, y = 12.8, n = L["Old Man Barlo"]}}
	},
	["Muckbreaths's Bucket"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Muckbreaths's Bucket"],
		spellId = 43698,
		itemId = 33818,
		items = {35348},
		chance = 10,
		creatureId = 24389,
		coords = {{m = 111, x = 54.6, y = 39.6, n = L["Cupri"]}, {m = 108, x = 38.6, y = 12.8, n = L["Old Man Barlo"]}}
	},
	["Snarly's Bucket"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Snarly's Bucket"],
		spellId = 46425,
		itemId = 35349,
		items = {35348},
		chance = 10,
		creatureId = 26050,
		coords = {{m = 111, x = 54.6, y = 39.6, n = L["Cupri"]}, {m = 108, x = 38.6, y = 12.8, n = L["Old Man Barlo"]}}
	},
	["Toothy's Bucket"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.TBC,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Toothy's Bucket"],
		spellId = 43697,
		itemId = 33816,
		items = {35348},
		chance = 10,
		creatureId = 24388,
		coords = {{m = 111, x = 54.6, y = 39.6, n = L["Cupri"]}, {m = 108, x = 38.6, y = 12.8, n = L["Old Man Barlo"]}}
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.pets, tbcPets)
