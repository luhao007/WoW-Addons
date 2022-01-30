local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local wotlkToys = {
	-- Toys (3.x)
	["Frenzyheart Brew"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Frenzyheart Brew"],
		itemId = 44719,
		items = {44718},
		chance = 4,
		sourceText = L[
			"Contained in Ripe Disgusting Jar, which is obtained by becoming Revered with Frenzyheart Tribe, purchasing a Disgusting Jar from their reputation vendor, and waiting three days."
		],
		coords = {{m = 119, x = 55, y = 69}}
	},
	["Unusual Compass"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Unusual Compass"],
		itemId = 45984,
		items = {46007},
		chance = 20,
		coords = {{m = 125, x = 52.6, y = 65.6}}
	},
	["Decahedral Dwarven Dice"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Decahedral Dwarven Dice"],
		itemId = 36863,
		chance = 300,
		npcs = { 27357, 32149, 29614, 27367, 27203, 29330},
		pickpocket = true,
		coords = {{m = CONSTANTS.UIMAPIDS.DRAGONBLIGHT}, {m = CONSTANTS.UIMAPIDS.ICECROWN}}
	},
	["Worn Troll Dice"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Worn Troll Dice"],
		itemId = 36862,
		chance = 300,
		npcs = {
			26550,
			34838,
			34734,
			30037,
			34728,
			34839,
			23663,
			29880,
			23665,
			23660,
			39438,
			27260,
			28465,
			28504,
			28123,
			31258,
			27424,
			23655,
			28388,
			28836,
		},
		pickpocket = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HROTHGARS_LANDING},
			{m = CONSTANTS.UIMAPIDS.ICECROWN},
			{m = CONSTANTS.UIMAPIDS.HOWLING_FJORD},
			{m = CONSTANTS.UIMAPIDS.GRIZZLY_HILLS},
			{m = CONSTANTS.UIMAPIDS.ZUL_DRAK},
			{m = CONSTANTS.UIMAPIDS.SHOLAZAR_BASIN},
		}
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.toys, wotlkToys)
