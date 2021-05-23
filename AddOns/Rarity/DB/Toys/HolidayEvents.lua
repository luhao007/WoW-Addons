local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local holidayEventToys = {
	-- Toys (Holiday)
	["Blight Boar Microphone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Blight Boar Microphone"],
		itemId = 151265,
		npcs = {122899},
		chance = 10,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.DARKMOON_FAIRE,
		coords = {{m = 407, x = 65.6, y = 67}},
		questId = {47767}
	},
	["Coin of Many Faces"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Coin of Many Faces"],
		itemId = 128807,
		npcs = {96535, 96538, 96637, 96536},
		chance = 100,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.HALLOWS_END,
		coords = {{m = 104, x = 40.6, y = 79.4}}
	},
	["Crashin' Thrashin' Battleship)"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Crashin' Thrashin' Battleship"],
		itemId = 172223,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		requiresAlliance = true,
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Crashin' Thrashin' Flamer Controller"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Crashin' Thrashin' Flamer Controller"],
		itemId = 108632,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Crashin' Thrashin' Flyer Controller"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Crashin' Thrashin' Flyer Controller"],
		itemId = 104318,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Crashin' Thrashin' Juggernaught"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Crashin' Thrashin' Juggernaught"],
		itemId = 172222,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		requiresHorde = true,
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Crashin' Thrashin' Racer Controller"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Crashin' Thrashin' Racer Controller"],
		itemId = 37710,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Crashin' Thrashin' Shredder Controller"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Crashin' Thrashin' Shredder Controller"],
		itemId = 116763,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Disposable Winter Veil Suits"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Disposable Winter Veil Suits"],
		itemId = 139337,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Endothermic Blaster"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Endothermic Blaster"],
		itemId = 128636,
		items = {116762},
		chance = 200,  -- Guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Foot Ball"] = {		-- WHY is this item here? It can be purchased from vendor
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Foot Ball"],
		itemId = 90888,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Fuzzy Green Lounge Cushion"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Fuzzy Green Lounge Cushion"],
		itemId = 116692,
		items = {21271, 21270, 116762},
		chance = 4,
		sourceText = L["Available starting December 25th"],
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {8788, 8767},
		coords = {{m = 86, x = 49.1, y = 78.2, h = true}, {m = 87, x = 33.4, y = 65.9, a = true}}
	},
	["Greatfather Winter's Hearthstone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Greatfather Winter's Hearthstone"],
		itemId = 162973,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Hearthstation (Horde)"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Hearthstation"],
		itemId = 151344,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		requiresHorde = true,
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Hearthstation (Alliance)"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Hearthstation"],
		itemId = 151343,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		requiresAlliance = true,
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["MiniZep Controller"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["MiniZep Controller"],
		itemId = 46709,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Moonfang Shroud"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Moonfang Shroud"],
		itemId = 101571,
		npcs = {71992},
		chance = 5,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.DARKMOON_FAIRE,
		coords = {{m = 407, x = 39.8, y = 44.4}}
	},
	["Moonfang's Paw"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Moonfang's Paw"],
		itemId = 105898,
		npcs = {71992},
		chance = 5,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.DARKMOON_FAIRE,
		coords = {{m = 407, x = 39.8, y = 44.4}}
	},
	["Pineapple Lounge Cushion"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Pineapple Lounge Cushion"],
		itemId = 116689,
		items = {21271, 21270, 116762},
		chance = 4,
		sourceText = L["Available starting December 25th"],
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {8788, 8767},
		coords = {{m = 86, x = 49.1, y = 78.2, h = true}, {m = 87, x = 33.4, y = 65.9, a = true}}
	},
	["Red Wooden Sled"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Red Wooden Sled"],
		itemId = 128776,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Sack of Spectral Spiders"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Sack of Spectral Spiders"],
		itemId = 128794,
		npcs = {96323},
		chance = 8,
		questId = 39617,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.HALLOWS_END,
		coords = {zoneOverride = L["Draenor Garrison"], {m = 579}, {m = 585}}
	},
	["Safari Lounge Cushion"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Safari Lounge Cushion"],
		itemId = 116690,
		items = {21271, 21270, 116762},
		chance = 4,
		sourceText = L["Available starting December 25th"],
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {8788, 8767},
		coords = {{m = 86, x = 49.1, y = 78.2, h = true}, {m = 87, x = 33.4, y = 65.9, a = true}}
	},
	["Scroll of Storytelling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Scroll of Storytelling"],
		itemId = 116456,
		items = {116762},
		chance = 8,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Silver-Plated Turkey Shooter"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Silver-Plated Turkey Shooter"],
		itemId = 116400,
		items = {116404},
		chance = 33,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.PILGRIMS_BOUNTY,
		coords = {
			{m = 87, x = 60, y = 34.2, q = 14048, a = true},
			{m = 87, x = 60, y = 34.2, q = 14051, a = true},
			{m = 89, x = 61.8, y = 46.4, q = 14054, a = true},
			{m = 37, x = 33.8, y = 50.8, q = 14055, a = true},
			{m = 37, x = 33.6, y = 50.6, q = 14053, a = true},
			{m = 1, x = 46.4, y = 13.8, q = 14061, h = true},
			{m = 1, x = 46.4, y = 13.8, q = 14062, h = true},
			{m = 88, x = 31, y = 69.6, q = 14060, h = true},
			{m = 998, x = 65.2, y = 13.8, q = 14058, h = true},
			{m = 998, x = 63.4, y = 9, q = 14059, h = true}
		}
	},
	["Special Edition Foot Ball"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Special Edition Foot Ball"],
		itemId = 90888,
		items = {93626, 116762},
		chance = 75,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["The Heartbreaker"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["The Heartbreaker"],
		itemId = 50471,
		items = {54537},
		chance = 83,
		groupSize = 5,
		equalOdds = true,
		sourceText = L[
			"Can be contained in Heart-Shaped Box, rewarded for defeating the World Event Dungeon during Love is in the Air."
		],
		lockDungeonId = 288,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.LOVE_IS_IN_THE_AIR,
		coords = {{m = 310, x = 40, y = 52.6, i = true}}
	},
	["The Pigskin"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["The Pigskin"],
		itemId = 90883,
		items = {116762},
		chance = 50,
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Toy Weapon Set (Horde)"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Toy Weapon Set"],
		itemId = 151348,
		items = {116762},
		chance = 200, -- Guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		requiresHorde = true,
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Toy Weapon Set (Alliance)"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Toy Weapon Set"],
		itemId = 151349,
		items = {116762},
		chance = 200, -- Guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		requiresAlliance = true,
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Wild Holly"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Wild Holly"],
		itemId = 172219,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Wreath-A-Rang"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Wreath-A-Rang"],
		itemId = 178530,
		items = {116762},
		chance = 100, -- Blind guess
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {6983, 7043},
		coords = {{m = CONSTANTS.UIMAPIDS.HILLSBRAD_FOOTHILLS, x = 43.6, y = 39.6}}
	},
	["Zhevra Lounge Cushion"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.HOLIDAY,
		type = CONSTANTS.ITEM_TYPES.ITEM,
		isToy = true,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Zhevra Lounge Cushion"],
		itemId = 116691,
		items = {21271, 21270, 116762},
		chance = 4,
		sourceText = L["Available starting December 25th"],
		holidayTexture = CONSTANTS.HOLIDAY_TEXTURES.WINTERS_VEIL,
		questId = {8788, 8767},
		coords = {{m = 86, x = 49.1, y = 78.2, h = true}, {m = 87, x = 33.4, y = 65.9, a = true}}
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.toys, holidayEventToys)
