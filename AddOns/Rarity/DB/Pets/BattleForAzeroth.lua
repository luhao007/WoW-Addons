local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local bfaPets = {
	-- 8.0 Pets
	["Scuttle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Scuttle"],
		spellId = 177244,
		itemId = 163797,
		chance = 1000,
		creatureId = 143794,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Captain Nibs"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Captain Nibs"],
		spellId = 177243,
		itemId = 163798,
		chance = 1000,
		creatureId = 143795,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Barnaby"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Barnaby"],
		spellId = 177242,
		itemId = 163799,
		chance = 1000,
		creatureId = 143796,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Poro"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Poro"],
		spellId = 177241,
		itemId = 163800,
		chance = 1000,
		creatureId = 143797,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Octopode Fry"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Octopode Fry"],
		spellId = 177240,
		itemId = 163801,
		chance = 1000,
		creatureId = 143798,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Inky"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Inky"],
		spellId = 177239,
		itemId = 163802,
		chance = 1000,
		creatureId = 143799,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Sparkleshell Sandcrawler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Sparkleshell Sandcrawler"],
		spellId = 177237,
		itemId = 163803,
		chance = 1000,
		creatureId = 143801,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Kindleweb Spiderling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Kindleweb Spiderling"],
		spellId = 177236,
		itemId = 163804,
		chance = 1000,
		creatureId = 143802,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Mischievous Zephyr"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Mischievous Zephyr"],
		spellId = 177221,
		itemId = 163814,
		chance = 1000,
		creatureId = 143812,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Littlehoof"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Littlehoof"],
		spellId = 177219,
		itemId = 163815,
		chance = 1000,
		creatureId = 143813,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Snapper"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Snapper"],
		spellId = 177217,
		itemId = 163816,
		chance = 1000,
		creatureId = 143814,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Sunscale Hatchling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Sunscale Hatchling"],
		spellId = 280331,
		itemId = 163817,
		chance = 1000,
		creatureId = 143815,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Bloodstone Tunneler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Bloodstone Tunneler"],
		spellId = 280332,
		itemId = 163818,
		chance = 1000,
		creatureId = 143816,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Snort"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Snort"],
		spellId = 280333,
		itemId = 163819,
		chance = 1000,
		creatureId = 143817,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Muskflank Calfling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Muskflank Calfling"],
		spellId = 280334,
		itemId = 163820,
		chance = 1000,
		creatureId = 143818,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Juvenile Brineshell"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Juvenile Brineshell"],
		spellId = 280335,
		itemId = 163821,
		chance = 1000,
		creatureId = 143819,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Kunchong Hatchling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Kunchong Hatchling"],
		spellId = 280336,
		itemId = 163822,
		chance = 1000,
		creatureId = 143820,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Coldlight Surfrunner"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Coldlight Surfrunner"],
		spellId = 280337,
		itemId = 163823,
		chance = 1000,
		creatureId = 143821,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Voru'kar Leecher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Voru'kar Leecher"],
		spellId = 280338,
		itemId = 163824,
		chance = 1000,
		creatureId = 143822,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Tinder Pup"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Tinder Pup"],
		spellId = 177230,
		itemId = 163807,
		chance = 1000,
		creatureId = 143805,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Sandshell Chitterer"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Sandshell Chitterer"],
		spellId = 177229,
		itemId = 163808,
		chance = 1000,
		creatureId = 143806,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Deathsting Scorpid"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Deathsting Scorpid"],
		spellId = 177228,
		itemId = 163809,
		chance = 1000,
		creatureId = 143807,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Thistlebrush Bud"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Thistlebrush Bud"],
		spellId = 177226,
		itemId = 163810,
		chance = 1000,
		creatureId = 143808,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Giggling Flame"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Giggling Flame"],
		spellId = 177225,
		itemId = 163811,
		chance = 1000,
		creatureId = 143809,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Laughing Stonekin"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Laughing Stonekin"],
		spellId = 177224,
		itemId = 163812,
		chance = 1000,
		creatureId = 143810,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Playful Frostkin"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Playful Frostkin"],
		spellId = 177222,
		itemId = 163813,
		chance = 1000,
		creatureId = 143811,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["False Knucklebump"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["False Knucklebump"],
		spellId = 177231,
		itemId = 163806,
		chance = 1000,
		creatureId = 143804,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Craghoof Kid"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Craghoof Kid"],
		spellId = 177235,
		itemId = 163805,
		chance = 1000,
		creatureId = 143803,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Mana-Warped Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Mana-Warped Egg"],
		npcs = {142716},
		spellId = 279930,
		itemId = 163712,
		creatureId = 143628,
		questId = {53090, 53515},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 52.3, y = 72.4, n = L["Man-Hunter Rog"]}
		}
	},
	["Fuzzy Creepling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Fuzzy Creepling"],
		npcs = {142438},
		spellId = 279631,
		itemId = 163648,
		creatureId = 143499,
		questId = {53024, 53528},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 56.7, y = 54.1, n = L["Venomarus"]}
		}
	},
	["Aldrusian Sproutling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Aldrusian Sproutling"],
		npcs = {142508},
		spellId = 279638,
		itemId = 163650,
		creatureId = 143503,
		questId = {53013, 53505},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 22.9, y = 22.2, n = L["Branchlord Aldrus"]}
		}
	},
	["Tiny Grimoire"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Tiny Grimoire"],
		npcs = {142688},
		spellId = 279643,
		itemId = 163652,
		creatureId = 143507,
		questId = {53084, 53507},
		chance = 20,
		coords = {
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 50.8,
				y = 36.5,
				n = L["Darbel Montrose"] .. " - " .. L["Alliance controls Stromgarde"]
			},
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 50.4,
				y = 61.2,
				n = L["Darbel Montrose"] .. " - " .. L["Horde controls Stromgarde"]
			}
		}
	},
	["Scabby"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Scabby"],
		npcs = {142440},
		spellId = 279686,
		itemId = 163684,
		creatureId = 143533,
		questId = {53015, 53529},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 14, y = 36.9, n = L["Yogursa"]}
		}
	},
	["Teeny Titan Orb"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Teeny Titan Orb"],
		npcs = {141668},
		spellId = 279657,
		itemId = 163677,
		creatureId = 143515,
		questId = {53059, 53508},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 56.6, y = 36.0, n = L["Echo of Myzrael"]}
		}
	},
	["Shard of Fozruk"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Shard of Fozruk"],
		npcs = {142433},
		spellId = 279929,
		itemId = 163711,
		creatureId = 143627,
		questId = {53019, 53510},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 51, y = 53.2, n = L["Fozruk"]}
		}
	},
	["Angry Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Angry Egg"],
		npcs = {142436},
		spellId = 279723,
		itemId = 163689,
		creatureId = 143563,
		questId = {53016, 53522},
		chance = 20,
		coords = {
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 18.4,
				y = 27.9,
				n = L["Ragebeak"] .. " - " .. L["Alliance controls Stromgarde"]
			},
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 11.9,
				y = 52.1,
				n = L["Ragebeak"] .. " - " .. L["Horde controls Stromgarde"]
			}
		}
	},
	["Plagued Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Plagued Egg"],
		npcs = {142435},
		spellId = 279724,
		itemId = 163690,
		creatureId = 143564,
		questId = {53020, 53519},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 36.9, y = 66, n = L["Plaguefeather"]}
		}
	},
	["Filthy Bucket"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Filthy Bucket"],
		itemId = 160704,
		spellId = 273184,
		creatureId = 139049,
		npcs = {135448},
		chance = 10,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		coords = {
			{m = CONSTANTS.UIMAPIDS.TOLDAGOR, n = L["Gol'than the Malodorous"]}
		}
	},
	["Wind-Up Frog"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Wind-Up Frog"],
		spellId = 280617,
		itemId = 163860,
		creatureId = 143957,
		items = {160324},
		chance = 50,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NONE}
		}
	},
	["Undulating Blue Sac"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Undulating Blue Sac"],
		spellId = 280618,
		itemId = 163861,
		creatureId = 143958,
		items = {160324},
		chance = 50,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NONE}
		}
	},
	["Baby Crawg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Baby Crawg"],
		spellId = 279435,
		itemId = 163859,
		creatureId = 143374,
		items = {160324},
		chance = 50,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NONE}
		}
	},
	["Ball of Tentacles"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Ball of Tentacles"],
		spellId = 280619,
		itemId = 163858,
		creatureId = 143959,
		items = {160324},
		chance = 50,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NONE}
		}
	},
	-- 8.1 Pets

	["Albatross Feather"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Albatross Feather"],
		spellId = 289606,
		itemId = 166714,
		items = {166295},
		chance = 10,
		creatureId = 149363,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS}
		}
	},
	["Cobalt Raven Hatchling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Cobalt Raven Hatchling"],
		spellId = 289629,
		itemId = 166718,
		items = {166297},
		chance = 10,
		creatureId = 149375,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DRUSTVAR}
		}
	},
	["Violet Abyssal Eel"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Violet Abyssal Eel"],
		spellId = 289633,
		itemId = 166719,
		items = {166294},
		chance = 10,
		creatureId = 149376,
		coords = {
			{m = CONSTANTS.UIMAPIDS.STORMSONG_VALLEY}
		}
	},
	["Pair of Tiny Bat Wings"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Pair of Tiny Bat Wings"],
		spellId = 289622,
		itemId = 166716,
		items = {166282},
		chance = 10,
		creatureId = 149372,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZMIR}
		}
	},
	["Darkshore Sentinel"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Darkshore Sentinel"],
		spellId = 288486,
		itemId = 166449,
		npcs = {148037, 149141},
		chance = 7,
		creatureId = 148781,
		questId = {54431, 54768},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 42, y = 77.6, n = L["Burninator Mark V"] .. " - " .. L["Alliance only"]},
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 42, y = 77.6, n = L["Athil Dewfire"] .. " - " .. L["Horde only"]}
		}
	},
	["Rattling Bones"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Rattling Bones"],
		spellId = 288592,
		itemId = 166451,
		npcs = {147260},
		chance = 7,
		creatureId = 148825,
		questId = {54232, 54233},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 39.2, y = 62, n = L["Conflagros"]}
		}
	},
	["Everburning Treant"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Everburning Treant"],
		spellId = 288597,
		itemId = 166453,
		npcs = {147664, 147758},
		chance = 7,
		creatureId = 148843,
		questId = {54274, 54291},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 62.5, y = 9.4, n = L["Zim'kaga"] .. " - " .. L["Alliance only"]},
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 45.2, y = 75.1, n = L["Onu"] .. " - " .. L["Horde only"]}
		}
	},
	["Binding of Cyclarus"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Binding of Cyclarus"],
		spellId = 288582,
		itemId = 166448,
		npcs = {147241},
		chance = 7,
		creatureId = 148784,
		questId = {54229, 54230},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 43.8, y = 53.6, n = L["Cyclarus"]}
		}
	},
	["Bottled Essence of Hydrath"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Bottled Essence of Hydrath"],
		spellId = 288595,
		itemId = 166452,
		npcs = {147240},
		chance = 7,
		creatureId = 148841,
		questId = {54227, 54228},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 53.0, y = 31.8, n = L["Hydrath"]}
		}
	},
	["Squishy Purple Goo"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Squishy Purple Goo"],
		spellId = 288598,
		itemId = 166454,
		npcs = {147897},
		chance = 7,
		creatureId = 148844,
		questId = {54320, 54321},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 40.7, y = 84.6, n = L["Soggoth the Slitherer"]}
		}
	},
	["Zur'aj the Depleted"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Zur'aj the Depleted"],
		spellId = 288600,
		itemId = 166455,
		npcs = {147942},
		chance = 7,
		creatureId = 148846,
		questId = {54397, 54398},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 40.6, y = 82.7, n = L["Twilight Prophet Graeme"]}
		}
	},
	["Spawn of Krag'wa"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Spawn of Krag'wa"],
		itemId = 165848,
		spellId = 286484,
		creatureId = 147585,
		npcs = {99999},
		tooltipNpcs = {144747, 144941, 144767, 144963},
		lockBossName = "Conclave of the Chosen",
		chance = 20,
		statisticId = {13366},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = 1364, i = true}
		}
	},
	["Thundering Scale of Akunda"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Thundering Scale of Akunda"],
		itemId = 165847,
		spellId = 286482,
		creatureId = 147587,
		npcs = {99999},
		tooltipNpcs = {144747, 144941, 144767, 144963},
		lockBossName = "Conclave of the Chosen",
		chance = 20,
		statisticId = {13364, 13365, 13366},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = 1364, i = true}
		}
	},
	["Enchanted Talon of Pa'ku"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Enchanted Talon of Pa'ku"],
		itemId = 165846,
		spellId = 286483,
		creatureId = 147586,
		npcs = {99999},
		tooltipNpcs = {144747, 144941, 144767, 144963},
		lockBossName = "Conclave of the Chosen",
		chance = 50,
		statisticId = {13364, 13365, 13366},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = 1364, i = true}
		}
	},
	["Baby Stonehide"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Baby Stonehide"],
		spellId = 288867,
		itemId = 166486,
		chance = 1000,
		creatureId = 148976,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Leatherwing Screecher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Leatherwing Screecher"],
		spellId = 288868,
		itemId = 166487,
		chance = 1000,
		creatureId = 148979,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Rotting Ghoul"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Rotting Ghoul"],
		spellId = 288870,
		itemId = 166488,
		chance = 1000,
		creatureId = 148981,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Thunderscale Whelpling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Thunderscale Whelpling"],
		spellId = 288916,
		itemId = 166499,
		chance = 1000,
		creatureId = 148995,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Scritches"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Scritches"],
		spellId = 288914,
		itemId = 166498,
		chance = 1000,
		creatureId = 148991,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Tonguelasher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Tonguelasher"],
		spellId = 288910,
		itemId = 166495,
		chance = 1000,
		creatureId = 148990,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Lord Woofington"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Lord Woofington"],
		spellId = 288901,
		itemId = 166494,
		chance = 1000,
		creatureId = 148989,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Firesting Buzzer"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Firesting Buzzer"],
		spellId = 288895,
		itemId = 166493,
		chance = 1000,
		creatureId = 148988,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Needleback Pup"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Needleback Pup"],
		spellId = 288875,
		itemId = 166489,
		chance = 1000,
		creatureId = 148982,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Shadefeather Hatchling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Shadefeather Hatchling"],
		spellId = 288889,
		itemId = 166492,
		chance = 1000,
		creatureId = 148984,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	-- 8.1.5 Pets

	["Stoneclaw"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Stoneclaw"],
		itemId = 167047,
		spellId = 291513,
		creatureId = 150354,
		npcs = {59915, 60043, 60047, 60051},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "The Stone Guard",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "The Stone Guard",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 471,
				i = true
			}
		}
	},
	["Wayward Spirit"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Wayward Spirit"],
		itemId = 167048,
		spellId = 291515,
		creatureId = 150356,
		npcs = {60143},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Gara'jal the Spiritbinder",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Gara'jal the Spiritbinder",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 10,
		coords = {
			{
				m = 471,
				i = true
			}
		}
	},
	["Celestial Gift"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Celestial Gift"],
		itemId = 167049,
		spellId = 291517,
		creatureId = 150357,
		npcs = {99999},
		tooltipNpcs = {60410},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Elegon",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Elegon",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 471,
				i = true
			}
		}
	},
	["Mogu Statue"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Mogu Statue"],
		itemId = 167050,
		spellId = 291533,
		creatureId = 150360,
		npcs = {60400, 60399},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Will of the Emperor",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Will of the Emperor",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 471,
				i = true
			}
		}
	},
	["Kor'thik Swarmling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Kor'thik Swarmling"],
		itemId = 167058,
		spellId = 291548,
		creatureId = 150374,
		npcs = {62980},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Imperial Vizier Zor'lok",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Imperial Vizier Zor'lok",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 475,
				i = true
			}
		}
	},
	["Tiny Amber Wings"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Tiny Amber Wings"],
		itemId = 167053,
		spellId = 291549,
		creatureId = 150375,
		npcs = {62543},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Blade Lord Ta'yak",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Blade Lord Ta'yak",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 3,
		coords = {
			{
				m = 475,
				i = true
			}
		}
	},
	["Spawn of Garalon"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Spawn of Garalon"],
		itemId = 167054,
		spellId = 291553,
		creatureId = 150377,
		npcs = {63191},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Garalon",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Garalon",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 475,
				i = true
			}
		}
	},
	["Amber Goo Puddle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Amber Goo Puddle"],
		itemId = 167055,
		spellId = 291556,
		creatureId = 150380,
		npcs = {62511},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Amber-Shaper Un'sok",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Amber-Shaper Un'sok",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 475,
				i = true
			}
		}
	},
	["Essence of Pride"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Essence of Pride"],
		itemId = 167056,
		spellId = 291560,
		creatureId = 150381,
		npcs = {62837},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Grand Empress Shek'zeer",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Grand Empress Shek'zeer",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 10,
		coords = {
			{
				m = 475,
				i = true
			}
		}
	},
	["Azure Cloud Serpent Egg"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Azure Cloud Serpent Egg"],
		itemId = 167051,
		spellId = 291537,
		creatureId = 150365,
		npcs = {99999},
		tooltipNpcs = {62442, 63025},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Tsulong",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Tsulong",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 3,
		coords = {
			{
				m = 456,
				i = true
			}
		}
	},
	["Spirit of the Spring"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Spirit of the Spring"],
		itemId = 167052,
		spellId = 291547,
		creatureId = 150372,
		npcs = {99999},
		tooltipNpcs = {62983},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Lei Shi",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_NORMAL] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_10_HEROIC] = true,
					[CONSTANTS.INSTANCE_DIFFICULTIES.RAID_25_HEROIC] = true
				}
			},
			{
				encounterName = "Lei Shi",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LEGACY_LFR] = true
				}
			}
		},
		chance = 4,
		coords = {
			{
				m = 456,
				i = true
			}
		}
	},
	-- 8.2 Pets

	["Adventurous Hopling Pack"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Adventurous Hopling Pack"],
		spellId = 300934,
		itemId = 169322,
		chance = 1000,
		creatureId = 154693,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Ghostly Whelpling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Ghostly Whelpling"],
		spellId = 300367,
		itemId = 169205,
		chance = 1000,
		creatureId = 154165,
		groupSize = 3,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Mindlost Bloodfrenzy"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Mindlost Bloodfrenzy"],
		itemId = 169360,
		spellId = 301031,
		creatureId = 154833,
		npcs = {99999},
		tooltipNpcs = {154986, 150653},
		groupSize = 5,
		equalOdds = true,
		statisticId = {
			13591,
			13592,
			13593,
			13594
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Blackwater Behemoth",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Blackwater Behemoth",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Blackwater Behemoth",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Blackwater Behemoth",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_ETERNAL_PALACE}
		}
	},
	["Lightless Ambusher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Lightless Ambusher"],
		itemId = 169358,
		spellId = 301029,
		creatureId = 154831,
		npcs = {99999},
		tooltipNpcs = {153142, 152236},
		groupSize = 5,
		equalOdds = true,
		statisticId = {
			13600,
			13601,
			13602,
			13603
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Lady Ashvane",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Lady Ashvane",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Lady Ashvane",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Lady Ashvane",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_ETERNAL_PALACE}
		}
	},
	["Zanj'ir Poker"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Zanj'ir Poker"],
		itemId = 169348,
		spellId = 301015,
		creatureId = 154819,
		npcs = {99999},
		tooltipNpcs = {155126},
		groupSize = 5,
		equalOdds = true,
		statisticId = {
			13616,
			13617,
			13618,
			13619
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Queen Azshara",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Queen Azshara",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Queen Azshara",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Queen Azshara",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 10, -- Blind guess (no data)
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_ETERNAL_PALACE}
		}
	},
	["Amethyst Softshell"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Amethyst Softshell"],
		npcs = {152794},
		spellId = 301034,
		itemId = 169363,
		creatureId = 154836,
		questId = {56268}, -- 56615 ?
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Pearlescent Glimmershell"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Pearlescent Glimmershell"],
		npcs = {152448},
		spellId = 301023,
		itemId = 169352,
		creatureId = 154825,
		questId = {56286}, -- 57260, 56597?
		chance = 100,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Brinestone Algan"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Brinestone Algan"],
		npcs = {150191},
		spellId = 301044,
		itemId = 169373,
		creatureId = 154845,
		questId = {55584},
		chance = 18,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 36.9, y = 11.2, n = L["Avarius"]}
		}
	},
	["Budding Algan"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Budding Algan"],
		npcs = {150583},
		spellId = 301045,
		itemId = 169374,
		creatureId = 154846,
		questId = {56291, 56917}, -- Which one is it?
		chance = 4,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Caverndark Nightmare"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Caverndark Nightmare"],
		npcs = {152464},
		spellId = 301027,
		itemId = 169356,
		creatureId = 154829,
		questId = {56283},
		chance = 25,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 42.29, y = 13.29, n = L["Caverndark Terror"]}
		}
	},
	["Chitterspine Needler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Chitterspine Needler"],
		npcs = {152465},
		spellId = 301026,
		itemId = 169355,
		creatureId = 154828,
		questId = {56608, 56275},
		-- Which one is it? Both completed upon killing it...
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Coral Lashling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Coral Lashling"],
		npcs = {149653},
		spellId = 301046,
		itemId = 169375,
		creatureId = 154847,
		questId = {55366}, -- 55366, 57186; 55404, 57042; 55366, 57187, 57188 ?
		chance = 12,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 54.8, y = 42.0, n = L["Carnivorous Lasher"]}
		}
	},
	["Daggertooth Frenzy"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Daggertooth Frenzy"],
		npcs = {152756},
		spellId = 301032,
		itemId = 169361,
		creatureId = 154834,
		questId = {56271},
		chance = 6,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Glittering Diamondshell"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Glittering Diamondshell"],
		npcs = {152795},
		spellId = 301021,
		itemId = 169350,
		creatureId = 154823,
		questId = {56277},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Murgle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Murgle"],
		npcs = {152323},
		spellId = 301042,
		itemId = 169371,
		creatureId = 154820,
		questId = {56582}, -- 55671 ?
		chance = 4,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 29.41, y = 28.98, n = L["King Gakula"]}
		}
	},
	["Necrofin Tadpole"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Necrofin Tadpole"],
		npcs = {152712},
		spellId = 301043,
		itemId = 169372,
		creatureId = 154821,
		questId = {56269, 56614}, -- Which one is it? Hmm..
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 39.25, y = 77.35, n = L["Blindlight"]}
		}
	},
	["Sandkeep"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Sandkeep"],
		npcs = {151870},
		spellId = 301040,
		itemId = 169369,
		creatureId = 154842,
		questId = {56276},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Scalebrood Hydra"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Scalebrood Hydra"],
		npcs = {152545, 152548, 152542},
		spellId = 301041,
		itemId = 169370,
		creatureId = 154843,
		questId = {52692, 56293, 56294},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 27.29, y = 37.16, n = L["Scale Matriarch Vynara"]},
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 35.6, y = 41, n = L["Scale Matriarch Gratinax"]},
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 28.8, y = 46.6, n = L["Scale Matriarch Zodia"]}
		}
	},
	["Seafury"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Seafury"],
		npcs = {152681},
		spellId = 301038,
		itemId = 169367,
		creatureId = 154840,
		questId = {56289},
		chance = 14,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 43.1, y = 87.22, n = L["Prince Typhonus"]}
		}
	},
	["Skittering Eel"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Skittering Eel"],
		npcs = {150468},
		spellId = 301047,
		itemId = 169376,
		creatureId = 154848,
		questId = {55603},
		chance = 13,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 48.34, y = 23.99, n = L["Vor'koth"]}
		}
	},
	["Spawn of Nalaada"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Spawn of Nalaada"],
		npcs = {152555},
		spellId = 301030,
		itemId = 169359,
		creatureId = 154832,
		questId = {56285},
		chance = 10,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 51.90, y = 75.40, n = L["Elderspawn Nalaada"]}
		}
	},
	["Stormwrath"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Stormwrath"],
		npcs = {152682},
		spellId = 301039,
		itemId = 169368,
		creatureId = 154841,
		questId = {56290},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR, x = 42.98, y = 75.09, n = L["Prince Vortran"]}
		}
	},
	["Wriggler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Wriggler"],
		npcs = {144644},
		spellId = 301037,
		itemId = 169366,
		creatureId = 154839,
		questId = {56274},
		chance = 9,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Arachnoid Skitterbot"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Arachnoid Skitterbot"],
		npcs = {151672},
		spellId = 301137,
		itemId = 169393,
		creatureId = 154894,
		questId = {55386},
		chance = 14,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 87.90, y = 19.60, n = L["Mecharantula"]}
		}
	},
	["Bonebiter"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Bonebiter"],
		npcs = {152001},
		spellId = 301136,
		itemId = 169392,
		creatureId = 154893,
		questId = {55537},
		chance = 6,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 65.94, y = 26.35, n = L["Bonepicker"]}
		}
	},
	["Lost Robogrip"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Lost Robogrip"],
		npcs = {151933},
		spellId = 301053,
		itemId = 169382,
		creatureId = 154854,
		questId = {55544},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 60.65, y = 42.22, n = L["Malfunctioning Beastbot"]}
		}
	},
	["Snowsoft Nibbler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Snowsoft Nibbler"],
		npcs = {151884},
		spellId = 301050,
		itemId = 169379,
		creatureId = 154851,
		questId = {55367},
		chance = 5,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND}
		}
	},
	["Spraybot 0D"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Spraybot 0D"],
		npcs = {152113},
		spellId = 303023,
		itemId = 169886,
		creatureId = 155600,
		questId = {55858},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 68.31, y = 47.18, n = L["The Kleptoboss"]}
		}
	},
	["Nameless Octopode"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Nameless Octopode"],
		itemId = 169362,
		spellId = 301033,
		creatureId = 154835,
		npcs = {99999},
		tooltipNpcs = {150859},
		groupSize = 5,
		equalOdds = true,
		statisticId = {
			13612,
			13613,
			13614,
			13615
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Za'qul",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Za'qul",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Za'qul",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Za'qul",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_ETERNAL_PALACE}
		}
	},
	["Sandclaw Nestseeker"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Sandclaw Nestseeker"],
		spellId = 301022,
		itemId = 169351,
		creatureId = 154824,
		chance = 250,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Armored Vaultbot"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Armored Vaultbot"],
		tooltipNpcs = {150394},
		spellId = 303784,
		itemId = 170072,
		creatureId = 155829,
		questId = {55546},
		chance = 75,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 53.99, y = 49.31, n = L["Armored Vaultbot"]}
		}
	},
	["Echoing Oozeling"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		items = {168394, 168395},
		name = L["Echoing Oozeling"],
		spellId = 301162,
		itemId = 169396,
		creatureId = 154904,
		questId = {55847}, -- Not sure which is correct: 55847, 57134, 57132, 56079 ? // 55847, 57132,
		chance = 20, -- Blind guess (no data)
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 70.12, y = 61.99, n = L["Reclamation Rig"]}
		}
	},
	["Microbot 8D"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		npcs = {150190},
		name = L["Microbot 8D"],
		spellId = 301056,
		itemId = 169385,
		creatureId = 154857,
		chance = 50,
		groupSize = 5,
		equalOdds = true,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "HK-8 Aerial Oppression Unit",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true
				}
			}
		},
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND_DUNGEON, i = true}
		}
	},
	["Golden Snorf"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		npcs = {150397},
		tooltipNpcs = {150396, 144249},
		statisticId = {13620},
		name = L["Golden Snorf"],
		spellId = 301049,
		itemId = 169378,
		creatureId = 154850,
		chance = 65,
		groupSize = 5,
		equalOdds = true,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "King Mechagon",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true
				}
			}
		},
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND_DUNGEON, i = true}
		}
	},
	-- 8.3 Pets
	['Box Labeled "Danger: Void Rat Inside"'] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L['Box Labeled "Danger: Void Rat Inside"'],
		spellId = 315301,
		itemId = 174460,
		chance = 100,
		creatureId = 161963,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_STORMWIND}
		}
	},
	["Swirling Black Bottle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Swirling Black Bottle"],
		spellId = 315302,
		itemId = 174461,
		chance = 100,
		creatureId = 161964,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_STORMWIND},
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_ORGRIMMAR}
		}
	},
	["Voidwoven Cat Collar"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Voidwoven Cat Collar"],
		spellId = 315298,
		itemId = 174459,
		chance = 100,
		creatureId = 161962,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_STORMWIND}
		}
	},
	["Void-Link Frostwolf Collar"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Void-Link Frostwolf Collar"],
		spellId = 312030,
		itemId = 174646,
		chance = 100,
		creatureId = 160196,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_ORGRIMMAR}
		}
	},
	["C'Thuffer"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["C'Thuffer"],
		spellId = 315290,
		itemId = 174457,
		chance = 100,
		creatureId = 161959,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_ORGRIMMAR}
		}
	},
	["Void-Scarred Hare"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Void-Scarred Hare"],
		spellId = 315297,
		itemId = 174458,
		chance = 100,
		creatureId = 161961,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_STORMWIND}
		}
	},
	["Box With Faintly Glowing 'Air' Holes"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Box With Faintly Glowing 'Air' Holes"],
		spellId = 312029,
		itemId = 173726,
		chance = 100,
		creatureId = 160187,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_ORGRIMMAR}
		}
	},
	["K'uddly"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["K'uddly"],
		npcs = {157176},
		spellId = 315339,
		itemId = 174473,
		creatureId = 161954,
		questId = {57342},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS, x = 51.85, y = 42.19, n = L["The Forgotten"]}
		}
	},
	["Cursed Dune Watcher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Cursed Dune Watcher"],
		spellId = 315367,
		itemId = 174481,
		items = {174484}, -- Uldum Accord Supplies
		chance = 100, -- Blind guess (no data)
		creatureId = 162007,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM}
		}
	},
	["Jade Defender"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Jade Defender"],
		spellId = 315371,
		itemId = 174479,
		items = {174483}, -- Rajani Supplies
		chance = 100,
		creatureId = 162013,
		coords = {
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS}
		}
	},
	["Black Chitinous Plate"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Black Chitinous Plate"],
		npcs = {162140},
		spellId = 315360,
		itemId = 174476,
		creatureId = 162004,
		questId = {58697},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM, x = 21.23, y = 61.05, n = L["Skikx'traz"]}
		}
	},
	["Wicked Lurker"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Wicked Lurker"],
		npcs = {157593},
		spellId = 315370,
		itemId = 174478,
		creatureId = 162012,
		questId = {58330},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM, x = 60, y = 72, n = L["Amalgamation of Flesh"]}
		}
	},
	["Corrupted Tentacle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Corrupted Tentacle"],
		npcs = {154495},
		spellId = 315353,
		itemId = 174474,
		creatureId = 161992,
		questId = {56303},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS, x = 52.51, y = 62.14, n = L["Will of N'zoth"]}
		}
	},
	["Stinky Sack"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Stinky Sack"],
		npcs = {154604},
		spellId = 315355,
		itemId = 174475,
		creatureId = 161997,
		questId = {56340},
		chance = 20,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM, x = 36.85, y = 20.93, n = L["Lord Aj'qirai"]}
		}
	},
	["Snarling Butterfly Crate"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Snarling Butterfly Crate"],
		spellId = 309522,
		itemId = 172493,
		npcs = {154154},
		chance = 20,
		creatureId = 158685,
		coords = {
			{m = CONSTANTS.UIMAPIDS.STORMSONG_VALLEY, x = 61.4, y = 16, n = L["Honey Smasher"]}
		}
	},
	["Eye of Corruption"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Eye of Corruption"],
		itemId = 174452,
		spellId = 315270,
		creatureId = 161946,
		npcs = {99999},
		tooltipNpcs = {158041},
		statisticId = {
			14135,
			14136,
			14137,
			14138
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "N'Zoth the Corruptor",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "N'Zoth the Corruptor",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "N'Zoth the Corruptor",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "N'Zoth the Corruptor",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 10, -- Blind guess (no data)
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NYALOTHA, i = true}
		}
	},
	["Void-Scarred Anubisath"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Void-Scarred Anubisath"],
		itemId = 174447,
		spellId = 315225,
		creatureId = 161921,
		npcs = {99999},
		tooltipNpcs = {156866},
		statisticId = {
			14127,
			14128,
			14129,
			14130
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Ra-den",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Ra-den",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Ra-den",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Ra-den",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 8,
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NYALOTHA, i = true}
		}
	},
	["Fractured Obsidian Claw"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Fractured Obsidian Claw"],
		itemId = 174446,
		spellId = 315221,
		creatureId = 161919,
		npcs = {99999},
		tooltipNpcs = {156523},
		statisticId = {
			14089,
			14091,
			14093,
			14094
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Maut",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Maut",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Maut",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Maut",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 5,
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NYALOTHA, i = true}
		}
	},
	["Aqir Hivespawn"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Aqir Hivespawn"],
		itemId = 174448,
		spellId = 315229,
		creatureId = 161923,
		npcs = {99999},
		tooltipNpcs = {157254},
		statisticId = {
			14107,
			14108,
			14109,
			14110
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 10,
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NYALOTHA, i = true}
		}
	},
	["Ra'kim"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Ra'kim"],
		itemId = 174449,
		spellId = 315231,
		creatureId = 161924,
		npcs = {99999},
		tooltipNpcs = {157254},
		statisticId = {
			14107,
			14108,
			14109,
			14110
		},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "The Hivemind",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true,
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
		},
		chance = 10, -- Blind guess (no data)
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NYALOTHA, i = true}
		}
	},
	["Bottle of Gloop"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.PET,
		method = CONSTANTS.DETECTION_METHODS.FISHING,
		name = L["Bottle of Gloop"],
		zones = {tostring(CONSTANTS.UIMAPIDS.ULDUM), tostring(CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS)},
		spellId = 315285,
		itemId = 174456,
		creatureId = 161951,
		chance = 500,
		requiresPool = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM},
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS}
		}
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.pets, bfaPets)
