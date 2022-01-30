local addonName, addonTable = ...

local L = LibStub("AceLocale-3.0"):GetLocale("Rarity")
local CONSTANTS = addonTable.constants

local shadowlandsMounts = {
	-- 9.0 Mounts
	["Horrid Dredwing"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Horrid Dredwing"],
		itemId = 180461,
		spellId = 332882,
		npcs = {165290},
		chance = 100,
		questId = {59612},
		coords = {
			{m = CONSTANTS.UIMAPIDS.REVENDRETH, x = 46.0, y = 78.5, n = L["Harika the Horrid"]}
		},
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.VENTHYR
	},
	["Bonehoof Tauralus"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Bonehoof Tauralus"],
		itemId = 182075,
		spellId = 332457,
		npcs = { 162586 },
		chance = 100,
		questId = {58783},
		coords = {
			{ m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 44.2, y = 51.2, n = L["Tahonta"] },
		},
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.NECROLORD,
		sourceText = L["This mount can only drop while having the Abomination Stitching construct Neena as your active companion."],
		requiresCompletedQuestId = { 57603 } -- This quest represents having the companion Neena summoned.
	},

	["Hopecrusher Gargon"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Hopecrusher Gargon"],
		itemId = 180581,
		spellId = 312753,
		npcs = {166679},
		chance = 100,
		groupSize = 5,
		equalOdds = true,
		questId = {59900},
		coords = {
			{m = CONSTANTS.UIMAPIDS.REVENDRETH, x = 51.98, y = 51.80, n = L["Hopecrusher"]}
		},
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.VENTHYR
	},
	["Reins of the Colossal Slaughterclaw"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Reins of the Colossal Slaughterclaw"],
		spellId = 327405,
		itemId = 182081,
		items = {180646},
		chance = 20, -- Estimate
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Amber Ardenmoth"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Amber Ardenmoth"],
		spellId = 342666,
		itemId = 183800,
		items = {180649},
		chance = 20, -- Estimate
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARDENWEALD}
		}
	},
	["Phalynx of Humility"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Phalynx of Humility"],
		spellId = 334386,
		itemId = 180762,
		chance = 50,
		questId = {61688},
		sourceText = L["This mount can only drop for Kyrians. Requires channeling anima to Temple of Purity."],
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION, x = 60.23, y = 78.11, n = L["Penitence of Purity"]}
		}
	},
	["Bulbous Necroray"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Bulbous Necroray"],
		spellId = 344574,
		itemId = 184160,
		items = {184158},
		chance = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Pestilent Necroray"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Pestilent Necroray"],
		spellId = 344575,
		itemId = 184162,
		items = {184158},
		chance = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Infested Necroray"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Infested Necroray"],
		spellId = 344576,
		itemId = 184161,
		items = {184158},
		chance = 3,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS}
		}
	},
	["Silessa's Battle Harness"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Silessa's Battle Harness"],
		spellId = 333023,
		itemId = 183798,
		chance = 100,
		coords = {
			{m = CONSTANTS.UIMAPIDS.REVENDRETH}
		}
	},
	-- 9.0 Mounts
	["Endmire Flyer Tether"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Endmire Flyer Tether"],
		itemId = 180582,
		spellId = 332905,
		npcs = {166521},
		chance = 100,
		questId = {59869},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.REVENDRETH, x = 62.0, y = 47.0, n = L["Famu the Infinite"]}
		}
	},
	["Wild Glimmerfur Prowler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Wild Glimmerfur Prowler"],
		itemId = 180730,
		spellId = 334366,
		npcs = {168647},
		chance = 100,
		questId = {61632},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.ARDENWEALD, x = 30.4, y = 55.2, n = L["Valfir the Unrelenting"]}
		},
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.NIGHT_FAE
	},
	["Predatory Plagueroc"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Predatory Plagueroc"],
		itemId = 182080,
		spellId = 336045,
		npcs = {162741},
		chance = 33,
		questId = {58872},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 31.4, y = 35.6, n = L["Gieger"]}
		},
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.NECROLORD
	},
	["Slime-Covered Reins of the Hulking Deathroc"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Slime-Covered Reins of the Hulking Deathroc"],
		itemId = 182079,
		spellId = 336042,
		npcs = {157309},
		chance = 33,
		questId = {61720},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 58.6, y = 74.2, n = L["Violet Mistake"]}
		}
	},
	["Gorespine"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Gorespine"],
		itemId = 182084,
		spellId = 332480,
		npcs = {162690},
		chance = 50,
		questId = {58851},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 65.8, y = 35.3, n = L["Nerissa Heartless"]}
		}
	},
	["Blisterback Bloodtusk"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Blisterback Bloodtusk"],
		itemId = 182085,
		spellId = 332478,
		npcs = {162819},
		chance = 33,
		questId = {58889},
		tooltipNpcs = {162818},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 33.6, y = 80.6, n = L["Warbringer Mal'Korak"]}
		}
	},
	["Armored Bonehoof Tauralus"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Armored Bonehoof Tauralus"],
		itemId = 181815,
		spellId = 332466,
		npcs = {168147},
		chance = 100, -- Estimate
		questId = {58784},
		tooltipNpcs = {168148},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 50.67, y = 47.37, n = L["Sabriel the Bonecleaver"]}
		},
		requiresCovenant = true,
		requiredCovenantID = CONSTANTS.COVENANT_IDS.NECROLORD
	},
	-- Note: This appears to not have made it to live, so I'm disabling it until further notice
	-- ["Bonecleaver's Skullboar"] = {
	-- 	cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
	-- 	type = CONSTANTS.ITEM_TYPES.MOUNT,
	-- 	method = CONSTANTS.DETECTION_METHODS.NPC,
	-- 	name = L["Bonecleaver's Skullboar"],
	-- 	itemId = 182083,
	-- 	spellId = 332482,
	-- 	npcs = { 168147 },
	-- 	chance = 100,	-- Estimate
	-- 	questId = { 58784 },
	-- 	tooltipNpcs = { 168148 },
	-- 	groupSize = 5,
	-- 	equalOdds = true,
	-- 	coords = {
	-- 		{ m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 50.67, y = 47.37, n = L["Sabriel the Bonecleaver"] },
	-- 	},
	-- },

	["Mawsworn Soulhunter"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Mawsworn Soulhunter"],
		itemId = 184167,
		spellId = 312762,
		npcs = {174861},
		chance = 50,
		questId = 63433,
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, x = 53.5, y = 79.5, n = L["Gorged Shadehound"]}
		}
	},
	["Gnawed Reins of the Battle-Bound Warhound"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Gnawed Reins of the Battle-Bound Warhound"],
		itemId = 184062,
		spellId = 344228,
		npcs = {162873, 162880, 162875, 162853, 162874, 162872},
		chance = 100, -- Estimate
		questId = 62786,
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.MALDRAXXUS, x = 50.67, y = 47.37, n = L["Theater of Pain"]}
		}
	},
	["Marrowfang's Reins"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Marrowfang's Reins"],
		spellId = 336036,
		itemId = 181819,
		npcs = {99999},
		tooltipNpcs = {162693},
		statisticId = {14404},
		chance = 100,
		equalOdds = true,
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		groupSize = 5,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_NECROTIC_WAKE}
		}
	},
	["Impressionable Gorger Spawn"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Impressionable Gorger Spawn"],
		itemId = 180583,
		spellId = 333027,
		npcs = {160821},
		chance = 100, -- Estimate,
		questId = 58259,
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.REVENDRETH, x = 38.60, y = 72.00, n = L["Worldedge Gorger"]}
		}
	},
	["Ascended Skymane"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.SPECIAL,
		name = L["Ascended Skymane"],
		spellId = 342335,
		itemId = 183741,
		chance = 20,
		tooltipNpcs = {170834, 170835, 170833, 170832, 170836},
		questId = {60933},
		groupSize = 5,
		equalOdds = true,
		coords = {
			{m = CONSTANTS.UIMAPIDS.BASTION, x = 53.50, y = 88.37, n = L["Cache of the Ascended"]}
		}
	},
	-- 9.1 Mounts
	["Fierce Razorwing"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Fierce Razorwing"],
		spellId = 354359,
		itemId = 186649,
		items = {186650},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Beryl Shardhide"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Beryl Shardhide"],
		spellId = 347810,
		itemId = 186644,
		items = {186650},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Soulbound Gloomcharger's Reins"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Soulbound Gloomcharger's Reins"],
		spellId = 354352,
		itemId = 186657,
		items = {187029},
		chance = 8,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Tamed Mauler Harness"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Tamed Mauler Harness"],
		spellId = 347536,
		itemId = 186641,
		items = {187028},
		chance = 100, -- Blind guess
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA}
		}
	},
	["Chain of Bahmethra"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Chain of Bahmethra"],
		spellId = 352309,
		itemId = 185973,
		questId = {63854},
		items = {185972},
		chance = 50,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Rampaging Mauler"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Rampaging Mauler"],
		itemId = 187183,
		spellId = 356501,
		npcs = {179472},
		questId = {64246},
		chance = 50, -- Estimate,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, n = L["Konthrogz the Obliterator"]}
		}
	},
	["Garnet Razorwing"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Garnet Razorwing"],
		itemId = 186652,
		spellId = 354360,
		npcs = {180160},
		questId = {64455},
		chance = 100, -- Estimate,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 56.3, y = 66.3, n = L["Reliwik the Defiant"]}
		}
	},
	["Crimson Shardhide"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Crimson Shardhide"],
		itemId = 186645,
		spellId = 354357,
		npcs = {179684},
		questId = {64233},
		chance = 100, -- Estimate,
		coords = {
			{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 45.35, y = 30.34, n = L["Malbog"]}
		}
	},
	["Fallen Charger's Reins"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Fallen Charger's Reins"],
		itemId = 186659,
		spellId = 354353,
		npcs = {179460},
		chance = 7,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW, n = L["Fallen Charger"]}
		}
	},
	["Cartel Master's Gearglider"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.NPC,
		name = L["Cartel Master's Gearglider"],
		spellId = 353263,
		itemId = 186638,
		npcs = {180863},
		chance = 100,
		groupSize = 5,
		equalOdds = true,
		statisticId = {15168},
		instanceDifficulties = {[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "So'leah",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_DUNGEON] = true
				}
			}
		},
		coords = {
			{m = CONSTANTS.UIMAPIDS.TAZAVESH_THE_VEILED_MARKET, i = true}
		}
	},
	["Sanctum Gloomcharger's Reins"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.BOSS,
		name = L["Sanctum Gloomcharger's Reins"],
		spellId = 354351,
		itemId = 186656,
		npcs = {99999},
		tooltipNpcs = {178738},
		chance = 100,
		groupSize = 10,
		equalOdds = true,
		statisticId = {15145, 15144, 15147, 15146},
		lockoutDetails = {
			mode = CONSTANTS.DEFEAT_DETECTION.MODE_AND,
			{
				encounterName = "The Nine",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.NORMAL_RAID] = true
				}
			},
			{
				encounterName = "The Nine",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.HEROIC_RAID] = true
				}
			},
			{
				encounterName = "The Nine",
				instanceDifficulties = {
					[CONSTANTS.INSTANCE_DIFFICULTIES.MYTHIC_RAID] = true
				}
			},
			{
				encounterName = "The Nine",
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
			{m = CONSTANTS.UIMAPIDS.SANCTUM_OF_DOMINATION, i = true}
		}
	},
	["Undying Darkhound's Harness"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Undying Darkhound's Harness"],
		spellId = 352742,
		itemId = 186103,
		items = {185992},
		chance = 25,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Legsplitter War Harness"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Legsplitter War Harness"],
		spellId = 352441,
		itemId = 186000,
		items = {185991},
		chance = 25,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Harvester's Dredwing Saddle"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.USE,
		name = L["Harvester's Dredwing Saddle"],
		spellId = 332904,
		itemId = 185996,
		items = {185990},
		chance = 25,
		coords = {
			{m = CONSTANTS.UIMAPIDS.THE_MAW}
		}
	},
	["Dusklight Razorwing"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.COLLECTION,
		name = L["Dusklight Razorwing"],
		spellId = 354361,
		itemId = 186651,
		collectedItemId = {187054},
		chance = 10,
		obtain = L["Dropped from various creatures in Korthia"],
		tooltipNpcs = {177913, 177645, 177295, 179472, 179859, 177646, 177245, 177582},
		sourceText = L[
			"Bring the 10 Lost Razorwing Egg to the Razorwing Nest in Korthia."
		],
		coords = {{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 25.6, y = 51.1, n = L["Razorwing Nest"]}}
	},
	["Darkmaul"] = {
		cat = CONSTANTS.ITEM_CATEGORIES.SHADOWLANDS,
		type = CONSTANTS.ITEM_TYPES.MOUNT,
		method = CONSTANTS.DETECTION_METHODS.COLLECTION,
		name = L["Darkmaul"],
		spellId = 354358,
		itemId = 186646,
		collectedItemId = {187153},
		chance = 10,
		obtain = L["The Mawshrooms are obtained from treasure nodes called Invasive Mawshroom in Korthia."],
		sourceText = L[
			"Darkmaul is obtained by feeding a friendly NPC in Korthia called Darkmaul 10 Tasty Mawshroom"
		],
		coords = {{m = CONSTANTS.UIMAPIDS.KORTHIA, x = 42.8, y = 32.7, n = L["Darkmaul"]}}
	},
}

Rarity.ItemDB.MergeItems(Rarity.ItemDB.mounts, shadowlandsMounts)
