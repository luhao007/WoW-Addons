local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local wotlkMounts = {
	-- 3.x
	["Invincible's Reins"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Invincible's Reins"],
		spellId = 72286,
		itemId = 50818,
		npcs = {99999},
		tooltipNpcs = {36597},
		chance = 100,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true},
		statisticId = {4688},
		sourceText = L["25-player heroic"],
		blackMarket = true,
		wasGuaranteed = true,
		lockBossName = "The Lich King",
		coords = {{m = 191, x = 49.8, y = 52.8, i = true}}
	},
	["Mimiron's Head"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Mimiron's Head"],
		spellId = 63796,
		itemId = 45693,
		npcs = {33288},
		statisticId = {2869, 2883},
		chance = 100,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true},
		sourceText = L["Dropped by Yogg-Saron in Ulduar with no Keepers assisting"],
		wasGuaranteed = true,
		blackMarket = true,
		lockBossName = "Yogg-Saron",
		coords = {{m = 150, x = 68, y = 40.8, i = true}}
	},
	["Reins of the Azure Drake"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Reins of the Azure Drake"],
		spellId = 59567,
		itemId = 43952,
		npcs = {99999},
		tooltipNpcs = {28859},
		chance = 100,
		statisticId = {1391, 1394},
		sourceText = L["Dropped by Malygos in The Eye of Eternity (any raid size)"],
		blackMarket = true,
		lockBossName = "Malygos",
		coords = {{m = 141, x = 39, y = 51.8, i = true}}
	},
	["Reins of the Blue Drake"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Reins of the Blue Drake"],
		spellId = 59568,
		itemId = 43953,
		npcs = {99999},
		tooltipNpcs = {28859},
		chance = 100,
		statisticId = {1391, 1394},
		sourceText = L["Dropped by Malygos in The Eye of Eternity (any raid size)"],
		bonusSatchel = true,
		blackMarket = true,
		lockBossName = "Malygos",
		coords = {{m = 141, x = 39, y = 51.8, i = true}}
	},
	["Reins of the Blue Proto-Drake"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Reins of the Blue Proto-Drake"],
		spellId = 59996,
		itemId = 44151,
		npcs = {26693, 174062},
		chance = 77,
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_DUNGEON] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.TIMEWALKING_DUNGEON] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.NONE] = true
		},
		sourceText = L["Heroic difficulty"],
		bonusSatchel = true,
		blackMarket = true,
		lockBossName = "Skadi the Ruthless",
		coords = {{m = 136, x = 68.4, y = 36.2, i = true}, {m = CONSTANTS.UIMAPIDS.ICECROWN, x = 57.6, y = 56}}
	},
	["Reins of the Grand Black War Mammoth Alliance"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Reins of the Grand Black War Mammoth"],
		spellId = 61465,
		itemId = 43959,
		npcs = {99999},
		tooltipNpcs = {35013, 33993, 31125, 38433},
		chance = 100,
		requiresAlliance = true,
		blackMarket = true,
		statisticId = {1753, 1754, 2870, 3236, 4074, 4075, 4657, 4658},
		sourceText = L[
			"Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
		],
		lockBossName = "Archavon the Stone Watcher",
		coords = {
			{m = 156, x = 36, y = 55.4, i = true},
			{m = 156, x = 62.6, y = 55.4, i = true},
			{m = 156, x = 49.2, y = 17, i = true},
			{m = 156, x = 62.6, y = 36.8, i = true}
		}
	},
	["Reins of the Grand Black War Mammoth Horde"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Reins of the Grand Black War Mammoth"],
		spellId = 61467,
		itemId = 44083,
		npcs = {99999},
		tooltipNpcs = {35013, 33993, 31125, 38433},
		chance = 100,
		requiresHorde = true,
		blackMarket = true,
		statisticId = {1753, 1754, 2870, 3236, 4074, 4075, 4657, 4658},
		sourceText = L[
			"Dropped by Koralon the Flame Watcher, Emalon the Storm Watcher, Archavon the Stone Watcher, and Toravon the Ice Watcher in Vault of Archavon (any raid size)."
		],
		lockBossName = "Archavon the Stone Watcher",
		coords = {
			{m = 156, x = 36, y = 55.4, i = true},
			{m = 156, x = 62.6, y = 55.4, i = true},
			{m = 156, x = 49.2, y = 17, i = true},
			{m = 156, x = 62.6, y = 36.8, i = true}
		}
	},
	["Reins of the Green Proto-Drake"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Reins of the Green Proto-Drake"],
		spellId = 61294,
		itemId = 44707,
		items = {39883},
		chance = 20,
		sourceText = L[
			"Contained in Cracked Egg, which is obtained by becoming Revered with The Oracles, purchasing a Mysterious Egg from their reputation vendor, and waiting three days. The mount has a 5% chance to appear in the Cracked Egg."
		],
		bonusSatchel = true,
		blackMarket = true,
		coords = {{m = 119, x = 54.6, y = 56.2}}
	},
	["Reins of the Onyxian Drake"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Reins of the Onyxian Drake"],
		spellId = 69395,
		itemId = 49636,
		npcs = {99999},
		tooltipNpcs = {10184},
		chance = 100,
		statisticId = {1098},
		sourceText = L["Any raid size"],
		blackMarket = true,
		lockBossName = "Onyxia",
		coords = {{m = 248, x = 68, y = 31.4, i = true}}
	},
	["Reins of the White Polar Bear"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Reins of the White Polar Bear"],
		spellId = 54753,
		itemId = 43962,
		items = {44751, 69903},
		chance = 33,
		sourceText = L[
			"Contained in Hyldnir Spoils, which is rewarded for completing daily quests given by Gretta the Arbiter in Brunnhildar Village, Storm Peaks. The mount has a 3% chance to appear in Hyldnir Spoils."
		],
		bonusSatchel = true,
		blackMarket = true,
		coords = {{m = 120, x = 50.8, y = 65.6}}
	},
	["Sea Turtle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.WOTLK,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.FISHING,
		name = L["Sea Turtle"],
		spellId = 64731,
		itemId = 46109,
		zones = {
			"116",
			"127",
			"115",
			"117",
			"114",
			"119",
			"245",
			"241",
			"249",
			"207",
			"198",
			"418",
			"371",
			"376",
			"379",
			"390",
			"422",
			"388",
			"407",
			"554",
			"507",
			"504",
			"433"
		},
		chance = 10000,
		requiresPool = true,
		sourceText = L["Obtained very rarely by fishing in pools located in any expansion zone (not Classic zones)"],
		coords = {
			{m = 116},
			{m = 127},
			{m = 115},
			{m = 117},
			{m = 114},
			{m = 119},
			{m = 245},
			{m = 241},
			{m = 249},
			{m = 207},
			{m = 198},
			{m = 418},
			{m = 371},
			{m = 376},
			{m = 379},
			{m = 390},
			{m = 422},
			{m = 388},
			{m = 407},
			{m = 554},
			{m = 507},
			{m = 504},
			{m = 433}
		}
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.mounts, wotlkMounts)
