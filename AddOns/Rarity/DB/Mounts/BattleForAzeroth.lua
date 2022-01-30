local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local bfaMounts = {
	--- 8.0
	["Witherbark Direwing"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Witherbark Direwing"],
		itemId = 163706,
		spellId = 279868,
		npcs = {142692},
		chance = 33,
		questId = {53091, 53517},
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 67.48, y = 60.58, n = L["Nimar the Slayer"]}
		}
	},
	["Lil' Donkey"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Lil' Donkey"],
		itemId = 163646,
		spellId = 279608,
		npcs = {142423},
		chance = 33,
		questId = {53014, 53518},
		coords = {
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 27.46,
				y = 55.89,
				n = L["Overseer Krix"] .. " - " .. L["Horde controls Stromgarde"]
			},
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 33.04,
				y = 37.49,
				n = L["Overseer Krix"] .. " - " .. L["Alliance controls Stromgarde"]
			},
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 33.44, y = 36.94, n = L["Cave Entrance"]}
		}
	},
	["Skullripper"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Skullripper"],
		itemId = 163645,
		spellId = 279611,
		npcs = {142437},
		chance = 33,
		questId = {53022, 53526},
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 57.15, y = 45.75, n = L["Skullripper"]}
		}
	},
	["Swift Albino Raptor"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Swift Albino Raptor"],
		itemId = 163644,
		spellId = 279569,
		npcs = {142709},
		chance = 33,
		questId = {53083, 53504},
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS, x = 67.06, y = 65.89, n = L["Beastrider Kama"]}
		}
	},
	["Highland Mustang"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Highland Mustang"],
		itemId = 163579,
		spellId = 279456,
		npcs = {142741},
		chance = 33,
		questId = 53085,
		requiresAlliance = true,
		coords = {
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 53.97,
				y = 56.96,
				n = L["Doomrider Helgrim"] .. " - " .. L["Alliance controls Stromgarde"] .. " - " .. L["Alliance only"]
			}
		}
	},
	["Broken Highland Mustang"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Broken Highland Mustang"],
		itemId = 163578,
		spellId = 279457,
		npcs = {142739},
		chance = 33,
		questId = 53088,
		requiresHorde = true,
		coords = {
			{
				m = CONSTANTS.UIMAPIDS.ARATHI_HIGHLANDS,
				x = 49.27,
				y = 40.05,
				n = L["Knight-Captain Aldrin"] .. " - " .. L["Horde controls Stromgarde"] .. " - " .. L["Horde only"]
			}
		}
	},
	["Captured Dune Scavenger"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Captured Dune Scavenger"],
		itemId = 163576,
		spellId = 237286,
		npcs = {
			128682,
			123774,
			136191,
			134429,
			129778,
			134427,
			129652,
			134560,
			134103,
			128678,
			123773,
			134559,
			123775,
			128749,
			127406,
			122746,
			123864,
			136545,
			122782,
			123863
		},
		chance = 3000,
		coords = {
			{m = CONSTANTS.UIMAPIDS.VOLDUN}
		}
	},
	["Chewed-On Reins of the Terrified Pack Mule"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Chewed-On Reins of the Terrified Pack Mule"],
		itemId = 163574,
		spellId = 260174,
		npcs = {
			131534,
			133892,
			133889,
			141642,
			131519,
			137134,
			133736,
			131530,
			131529
		},
		chance = 4000,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DRUSTVAR}
		}
	},
	["Reins of a Tamed Bloodfeaster"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Reins of a Tamed Bloodfeaster"],
		itemId = 163575,
		spellId = 243795,
		npcs = {
			126888,
			126187,
			133077,
			122239,
			127919,
			120607,
			136639,
			127224,
			136293,
			133279,
			133063,
			128734,
			127928,
			120606,
			124547,
			124688
		},
		chance = 3000,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZMIR}
		}
	},
	["Goldenmane's Reins"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Goldenmane's Reins"],
		itemId = 163573,
		spellId = 260175,
		npcs = {
			129750,
			131646,
			135585,
			138167,
			138332,
			141143,
			137202,
			138168,
			130641,
			131166,
			138226,
			130897,
			135584,
			140209,
			137893,
			138170,
			137156,
			130006,
			131404,
			136158,
			130039,
			132226,
			138340,
			137155,
			130531
		},
		chance = 3000,
		coords = {
			{m = CONSTANTS.UIMAPIDS.STORMSONG_VALLEY}
		}
	},
	-- 8.1

	["Ashenvale Chimaera"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Ashenvale Chimaera"],
		itemId = 166432,
		spellId = 288495,
		npcs = {148787},
		chance = 20,
		questId = {54695, 54696},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 56.4, y = 30.8, n = L["Alash'anir"]}
		}
	},
	["Caged Bear"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Caged Bear"],
		itemId = 166438,
		spellId = 288438,
		npcs = {149652},
		chance = 20,
		questId = {54883},
		requiresAlliance = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 49.2, y = 24.8, n = L["Agathe Wyrmwood"] .. " - " .. L["Alliance only"]}
		}
	},
	["Blackpaw"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Blackpaw"],
		itemId = 166428,
		spellId = 288438,
		npcs = {149660},
		chance = 20,
		requiresHorde = true,
		questId = {54890},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 49.2, y = 24.8, n = L["Blackpaw"] .. " - " .. L["Horde only"]}
		}
	},
	["Captured Kaldorei Nightsaber"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Captured Kaldorei Nightsaber"],
		itemId = 166437,
		spellId = 288505,
		npcs = {149655},
		chance = 20,
		questId = {54886},
		requiresAlliance = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 50.6, y = 32.6, n = L["Croz Bloodrage"] .. " - " .. L["Alliance only"]}
		}
	},
	["Kaldorei Nightsaber"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Kaldorei Nightsaber"],
		itemId = 166435,
		spellId = 288505,
		npcs = {149663},
		chance = 20,
		questId = {54892},
		requiresHorde = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 39.9, y = 33.0, n = L["Shadowclaw"] .. " - " .. L["Horde only"]}
		}
	},
	["Umber Nightsaber"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Umber Nightsaber"],
		itemId = 166803,
		spellId = 288503,
		npcs = {148037},
		chance = 20,
		questId = {54431},
		requiresHorde = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 42, y = 77.6, n = L["Athil Dewfire"] .. " - " .. L["Horde only"]}
		}
	},
	["Captured Umber Nightsaber"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Captured Umber Nightsaber"],
		itemId = 166434,
		spellId = 288503,
		npcs = {147701},
		chance = 20,
		questId = {54277},
		requiresAlliance = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.DARKSHORE, x = 63.7, y = 20.9, n = L["Moxo the Beheader"] .. " - " .. L["Alliance only"]}
		}
	},
	["Glacial Tidestorm"] = {
        cat = CONSTANTS.ITEM_CATEGORIES.BFA,
        type = CONSTANTS.ITEM_TYPES.MOUNT,
        method = CONSTANTS.DETECTION_METHODS.BOSS,
        name = L["Glacial Tidestorm"],
        spellId = 289555,
        itemId = 166705,
        npcs = {99999},
        tooltipNpcs = {165396}, -- Lady Jaina Proudmoore
        instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true},
        chance = 100,
        wasGuaranteed = true,
        groupSize = 10,
        equalOdds = true,
        statisticId = {13382},
        coords = {{m = CONSTANTS.UIMAPIDS.BATTLE_FOR_DAZARALOR_RAID, i = true}}
	},
	-- 8.2 Mounts
	["Royal Snapdragon"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Royal Snapdragon"],
		spellId = 294038,
		itemId = 169198,
		items = {169940, 169939},
		chance = 19,
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Rusted Keys to the Junkheap Drifter"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Rusted Keys to the Junkheap Drifter"],
		itemId = 168370,
		spellId = 297157,
		npcs = {152182},
		chance = 200,
		questId = {55811},
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 65.8, y = 79.6, n = L["Rustfeather"]}
		}
	},
	["Rusty Mechanocrawler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Rusty Mechanocrawler"],
		itemId = 168823,
		spellId = 291492,
		npcs = {154342, 151934},
		chance = 333,
		questId = {55512},
		coords = {
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND, x = 52.0, y = 41.4, n = L["Arachnoid Harvester"]}
		}
	},
	["Silent Glider"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Silent Glider"],
		itemId = 169163,
		spellId = 300149,
		npcs = {152290},
		chance = 200,
		questId = {56298},
		coords = {
			{m = CONSTANTS.UIMAPIDS.NAZJATAR}
		}
	},
	["Mechagon Peacekeeper"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Mechagon Peacekeeper"],
		spellId = 299158,
		itemId = 168826,
		npcs = {150190},
		chance = 200,
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
	-- 8.3 Mounts
	["Xinlao"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Xinlao"],
		itemId = 174840,
		spellId = 316723,
		npcs = {157466},
		chance = 100,
		questId = {57363},
		coords = {
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS, x = 34.15, y = 68.05, n = L["Anh-De the Loyal"]}
		}
	},
	["Reins of the Drake of the Four Winds"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Reins of the Drake of the Four Winds"],
		itemId = 174641,
		spellId = 315847,
		npcs = {157134},
		chance = 100,
		questId = {57259},
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM, x = 73.96, y = 83.52, n = L["Ishak of the Four Winds"]}
		}
	},
	["Malevolent Drone"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Malevolent Drone"],
		itemId = 174769,
		spellId = 316337,
		npcs = {162147},
		chance = 100,
		questId = {58696},
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM, x = 30.85, y = 49.71, n = L["Corpse Eater"]}
		}
	},
	["Clutch of Ha-Li"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Clutch of Ha-Li"],
		itemId = 173887,
		spellId = 312751,
		npcs = {157153},
		chance = 100,
		questId = {57344},
		coords = {
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS, x = 36.6, y = 37.6, n = L["Ha-Li"]}
		}
	},
	["Ren's Stalwart Hound"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Ren's Stalwart Hound"],
		itemId = 174841,
		spellId = 316722,
		npcs = {157160},
		chance = 100,
		questId = {57345},
		coords = {
			{m = CONSTANTS.UIMAPIDS.VALE_OF_ETERNAL_BLOSSOMS, x = 10, y = 33, n = L["Houndlord Ren"]}
		}
	},
	["Waste Marauder"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Waste Marauder"],
		itemId = 174753,
		spellId = 316275,
		npcs = {157146},
		chance = 100,
		questId = {57273},
		coords = {
			{m = CONSTANTS.UIMAPIDS.ULDUM, x = 68.23, y = 31.97, n = L["Rotfeaster"]}
		}
	},
	["Slightly Damp Pile of Fur"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Slightly Damp Pile of Fur"],
		itemId = 174842,
		spellId = 298367,
		npcs = {138794},
		chance = 100,
		groupSize = 3,
		equalOdds = true,
		questId = {53000},
		worldQuestId = 52196,
		coords = {
			{m = CONSTANTS.UIMAPIDS.VOLDUN, x = 44.6, y = 56.2, n = L["Dunegorger Kraulok"]}
		}
	},
	["Mail Muncher"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Mail Muncher"],
		itemId = 174653,
		spellId = 315987,
		npcs = {160708},
		tooltipNpcs = {160708},
		chance = 100,
		coords = {
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_STORMWIND},
			{m = CONSTANTS.UIMAPIDS.HORRIFIC_VISION_OF_ORGRIMMAR}
		}
	},
	-- 8.0 Mounts
	["Sharkbait's Favorite Crackers"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Sharkbait's Favorite Crackers"],
		spellId = 254813,
		itemId = 159842,
		npcs = {126983},
		statisticId = {12752},
		chance = 200,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Lord Harlan Sweete",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true
				}
			}
		},
		coords = {
			{m = CONSTANTS.UIMAPIDS.FREEHOLD, i = true}
		}
	},
	["Underrot Crawg Harness"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Underrot Crawg Harness"],
		spellId = 273541,
		itemId = 160829,
		npcs = {99999},
		tooltipNpcs = {133007},
		statisticId = {12745},
		chance = 200,
		equalOdds = true,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		groupSize = 5,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_UNDERROT, i = true}
		}
	},
	["Mummified Raptor Skull"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Mummified Raptor Skull"],
		spellId = 266058,
		itemId = 159921,
		npcs = {99999},
		tooltipNpcs = {136160},
		statisticId = {12763},
		chance = 200,
		equalOdds = true,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		groupSize = 5,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KINGS_REST, i = true}
		}
	},
	["Twilight Avenger"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Twilight Avenger"],
		spellId = 279466,
		itemId = 163584,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Craghorn Chasm-Leaper"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Craghorn Chasm-Leaper"],
		spellId = 279467,
		itemId = 163583,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Qinsho's Eternal Hound"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Qinsho's Eternal Hound"],
		spellId = 279469,
		itemId = 163582,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Squawks"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Squawks"],
		spellId = 254811,
		itemId = 163586,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Surf Jelly"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Surf Jelly"],
		spellId = 278979,
		itemId = 163585,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Great Sea Ray"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.FISHING,
		name = L["Great Sea Ray"],
		spellId = 278803,
		itemId = 163131,
		chance = 10000,
		zones = {
			"896", -- Drustvar
			"895", -- Tiragarde
			"942", -- SSValley
			"862", -- Zuldazar
			"863", -- Nazmir
			"864", -- Vol'dun
			"875", -- Zandalar
			"876", -- Kul'tiras
			"974", -- Tol'Dagor
			"1161", -- Boralus
			"1364", -- Battle for Dazar'alor (Raid)
			"1462", -- Mechagon Island
			"1165" -- Dazar'alor
		},
		coords = {
			{m = CONSTANTS.UIMAPIDS.DRUSTVAR},
			{m = CONSTANTS.UIMAPIDS.TIRAGARDE_SOUND},
			{m = CONSTANTS.UIMAPIDS.STORMSONG_VALLEY},
			{m = CONSTANTS.UIMAPIDS.ZULDAZAR},
			{m = CONSTANTS.UIMAPIDS.NAZMIR},
			{m = CONSTANTS.UIMAPIDS.VOLDUN},
			{m = CONSTANTS.UIMAPIDS.ZANDALAR},
			{m = CONSTANTS.UIMAPIDS.KULTIRAS},
			{m = CONSTANTS.UIMAPIDS.TORDAGOR},
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.BATTLE_FOR_DAZARALOR_RAID},
			{m = CONSTANTS.UIMAPIDS.MECHAGON_ISLAND},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	-- 8.1 Mounts

	["G.M.O.D."] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["G.M.O.D."],
		spellId = 289083,
		itemId = 166518,
		npcs = {99999},
		tooltipNpcs = {144796},
		tooltipModifier = {
			condition = CONSTANTS.TOOLTIP_FILTERS.IS_PLAYER_IN_LFR,
			action = CONSTANTS.TOOLTIP_ACTIONS.OVERRIDE_TOOLTIP_NPCS,
			value = 146409
		},
		chance = 100,
		groupSize = 5,
		equalOdds = true,
		statisticId = {13372, 13373, 13374, 13379},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "Mekkatorque",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "Mekkatorque",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "Mekkatorque",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "Lady Jaina Proudmoore",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true
				}
			}
		},
		instanceDifficulties = {
			[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true, -- Normal (Raids)
			[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true, -- Heroic (Raids)
			[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true, -- Mythic (Raids)
			[CONSTANTS.INSTANCE_DIFFICULTIES.LFR] = true -- LFR
		},
		coords = {
			{m = 1364, i = true}
		}
	},
	["Risen Mare"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Risen Mare"],
		spellId = 288722,
		itemId = 166466,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Island Thunderscale"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Island Thunderscale"],
		spellId = 288721,
		itemId = 166467,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Bloodgorged Hunter"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Bloodgorged Hunter"],
		spellId = 288720,
		itemId = 166468,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	["Stonehide Elderhorn"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Stonehide Elderhorn"],
		spellId = 288712,
		itemId = 166470,
		npcs = 99999,
		chance = 100,
		equalOdds = true,
		groupSize = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BORALUS},
			{m = CONSTANTS.UIMAPIDS.DAZARALOR}
		}
	},
	-- 8.3
	["Ny'alotha Allseer"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.BFA,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Ny'alotha Allseer"],
		spellId = 308814,
		itemId = 174872,
		npcs = {99999},
		tooltipNpcs = {158041}, -- N'Zoth the Corruptor
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true},
		chance = 100,
		wasGuaranteed = true,
		groupSize = 10,
		equalOdds = true,
		statisticId = {14138},
		coords = {{m = CONSTANTS.UIMAPIDS.NYALOTHA, i = true}}
	}
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.mounts, bfaMounts)
