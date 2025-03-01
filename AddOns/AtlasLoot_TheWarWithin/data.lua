-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 11)

AtlasLoot:RegisterModules(addonname)

local AL = AtlasLoot.Locales

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "LFRWithPreset", {
	Item = {
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 17)
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", {
	Item = {
		item1bonus = "Scaling",
		addDifficultyBonus = true,
	},
}, 1)
local NORMAL_RAID_DIFF = data:AddDifficulty(AL["Normal"], "NormalRaidWithPreset", {
	Item = {
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 14)
local NORMAL_DUNGEON_DIFF = data:AddDifficulty(AL["Normal"], "DungeonWithPreset", {
	Item = {
		item1bonus = "Scaling",
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 1)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", nil, 2)
local HEROIC_DUNGEON_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicDungeonWithPreset", {
	Item = {
		item2bonus = "BfAMaxItemLvl", --"BfAHCDungeonTitanforged",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 2)
local MYTHICD_DIFF = data:AddDifficulty(AL["Mythic"], "h", nil, 23)
local MYTHICD_DUNGEON_DIFF = data:AddDifficulty(AL["Mythic"], "MythicDungeonWithPreset", {
	Item = {
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 23)
local MYTHICD2_DIFF = data:AddDifficulty(AL["Mythic"], "h", nil, 23)
local MYTHICD2_DUNGEON_DIFF = data:AddDifficulty(AL["Mythic"], "MythicDungeon2WithPreset", {
	Item = {
		item1bonus = "LegionMDungeon2",
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 23)
local HEROIC_PRE_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicWithPreset", {
	Item = {
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 15)
local MYTHIC_DIFF = data:AddDifficulty(AL["Mythic"], "m", nil, 16)
local MYTHIC_PRE_DIFF = data:AddDifficulty(AL["Mythic"], "MyhticWithPreset", {
	Item = {
		item2bonus = "BfAMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 16)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)


-- /////////////////////////////////
-- Instance
-- /////////////////////////////////
--[[
data["InstanceName"] = {
	EncounterJournalID = 111,
	MapID = 749,
	-- AtlasMapID = "",
	ContentType = DUNGEON_CONTENT / RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- bossN
			EncounterJournalID = 1111,
			[NORMAL_RAID_DIFF] = {
				{ 1, 193711 }, -- temp
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}
]]

data["The Rookery"] = {
	EncounterJournalID = 1268,
	MapID = 2315,
	AtlasMapID = "TheRookery",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Kyrioss
			EncounterJournalID = 2566,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221034 }, -- Thunder-Clad Legguards
				{ 2, 221032 }, -- Voltaic Stormcaller
				{ 3, 221036 }, -- Tempestwind Handlers
				{ 4, 221035 }, -- Treads of the Galvanic Skysoarer
				{ 5, 221037 }, -- Charged Rookfeather Wraps
				{ 6, 219294 }, -- Charged Stormrook Plume
				{ 7, 221033 }, -- Hyperactive Stormclaw
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Stormguard Gorren
			EncounterJournalID = 2567,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 219295 }, -- Sigil of Algari Concordance
				{ 2, 221042 }, -- Squallrider's Kilt
				{ 3, 221043 }, -- Cloudstrider Soles
				{ 4, 221041 }, -- Boltbreaker Armor
				{ 5, 221040 }, -- Lightning-Conductor's Bands
				{ 6, 221038 }, -- Crashing Thunderhammer
				{ 7, 221045 }, -- Galebreaker Bulwark
				{ 8, 221039 }, -- Ireborne Stormbow
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Voidstone Monstrosity
			EncounterJournalID = 2568,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221197 }, -- Hoop of the Blighted
				{ 2, 221049 }, -- Jerkin of Awakened Stone
				{ 3, 221048 }, -- Amice of Oblivion
				{ 4, 221050 }, -- Ancient Hardened Legwraps
				{ 5, 221046 }, -- Behemoth Kneebender
				{ 6, 219296 }, -- Entropic Skardyn Core
				{ 7, 221047 }, -- Monstrosity's Gaze
				{ 8, 221044 }, -- Shadowskean of the Colossus
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9, 223121 }, -- Formula: Enchanted Weathered Harbinger Crest
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

data["The Stonevault"] = {
	EncounterJournalID = 1269,
	MapID = 2341,
	AtlasMapID = "TheStonevault",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- E.D.N.A.
			EncounterJournalID = 2572,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221077 }, -- "Emergency Stop" Keychain
				{ 2, 221076 }, -- E.D.N.A. Stabilizers
				{ 3, 221075 }, -- Reinforced Anti-Intruder Chainmail
				{ 4, 221073 }, -- Earthen Nullification Aegis
				{ 5, 219315 }, -- Refracting Aggression Module
				{ 6, 221078 }, -- Endoskeletal Polecrank
				{ 7, 221074 }, -- Augmented Refractor Cannon
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Skarmorak
			EncounterJournalID = 2579,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221082 }, -- Tainted Earthshard Walkers
				{ 2, 221080 }, -- Corpseleecher Grips
				{ 3, 221079 }, -- Crystal-Fissure Girdle
				{ 4, 221081 }, -- Guise of the Construct
				{ 5, 219300 }, -- Skarmorak Shard
				{ 6, 221083 }, -- Wardbreaker of the Fractured
				{ 7, 221084 }, -- Skardyn Mercybringer
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Master Machinists
			EncounterJournalID = 2590,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221088 }, -- Anvilhide Cape
				{ 2, 221087 }, -- Dorlita's Safety Belt
				{ 3, 221086 }, -- Machinist's Searing Handguards
				{ 4, 221085 }, -- Melodious Iron Songspire
				{ 5, 219301 }, -- Overclocked Gear-a-Rang Launcher
				{ 6, 219302 }, -- Scrapsinger's Symphony
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Void Speaker Eirich
			EncounterJournalID = 2582,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 219303 }, -- High Speaker's Accretion
				{ 2, 221092 }, -- Legplates of Broken Trust
				{ 3, 221094 }, -- Whispering Umbral Mantle
				{ 4, 221095 }, -- Shadowed Orator's Tunic
				{ 5, 221089 }, -- Silver-Tongued Boltcaster
				{ 6, 221090 }, -- Eirich's Fist of Deception
				{ 7, 221091 }, -- Cutting-Edge Sermon
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 8,  223121 }, -- Formula: Enchanted Weathered Harbinger Crest
				{ 9,  223122 }, -- Formula: Enchanted Runed Harbinger Crest
				{ 10, 223123 }, -- Formula: Enchanted Gilded Harbinger Crest
				{ 11, 223088 }, -- Design: Elusive Blasphemite
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
				{ 12, 221093 }, -- Deeply Corrupted Coil
				{ 13, 223087 }, -- Design: Culminating Blasphemite
				{ 14, 226683, "mount" }, -- Malfunctioning Mechsuit
			},
		},
	}
}

data["Priory of the Sacred Flame"] = {
	EncounterJournalID = 1267,
	MapID = 2308,
	AtlasMapID = "PrioryoftheSacredFlame",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Captain Dailcry
			EncounterJournalID = 2571,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 219308 }, -- Signet of the Priory
				{ 2, 221118 }, -- Flameforged Armguard
				{ 3, 221119 }, -- Holybound Grips
				{ 4, 221121 }, -- Honorbound Retainer's Sash
				{ 5, 221120 }, -- Stalwart Guardian's Boots
				{ 6, 221117 }, -- Sanctified Priory Wall
				{ 7, 221116 }, -- Glorious Defender's Poleaxe
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Baron Braunpyke
			EncounterJournalID = 2570,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221123 }, -- Devoted Plate Walkers
				{ 2, 221125 }, -- Helm of the Righteous Crusade
				{ 3, 221124 }, -- Consecrated Baron's Bindings
				{ 4, 221122 }, -- Hand of Beledar
				{ 5, 221126 }, -- Zealous Warden's Raiment
				{ 6, 219309 }, -- Tome of Light's Devotion
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Prioress Murrpray
			EncounterJournalID = 2573,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221200 }, -- Radiant Necromancer's Band
				{ 2, 221129 }, -- Divine Pyrewalkers
				{ 3, 221203 }, -- Reanimator's Pyreforged Shoulders
				{ 4, 221130 }, -- Seraphic Wraps of the Ordained
				{ 5, 221131 }, -- Elysian Flame Crown
				{ 6, 221127 }, -- Emberbrand Zweihander
				{ 7, 219310 }, -- Bursting Lightshard
				{ 8, 221128 }, -- Starforged Seraph's Mace
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9,  223121 }, -- Formula: Enchanted Weathered Harbinger Crest
				{ 10, 223122 }, -- Formula: Enchanted Runed Harbinger Crest
				{ 11, 223123 }, -- Formula: Enchanted Gilded Harbinger Crest
				{ 12, 223088 }, -- Design: Elusive Blasphemite
				{ 13, 223098 }, -- Pattern: Waders of the Unifying Flame
				{ 14, 223117 }, -- Formula: Enchant Ring - Radiant Mastery
				{ 15, 223115 }, -- Formula: Enchant Ring - Radiant Critical Strike
				{ 16, 223116 }, -- Formula: Enchant Ring - Radiant Haste
				{ 17, 223118 }, -- Formula: Enchant Ring - Radiant Versatility
				{ 18, 223120 }, -- Formula: Enchant Weapon - Authority of Radiant Power
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

data["Ara-Kara, City of Echoes"] = {
	EncounterJournalID = 1271,
	MapID = 2357,
	AtlasMapID = "AraKaraCityofEchoes",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Avanoxx
			EncounterJournalID = 2583,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 219314 }, -- Ara-Kara Sacbrood
				{ 2, 221151 }, -- Devourer's Gauntlets
				{ 3, 221153 }, -- Gauzewoven Legguards
				{ 4, 221150 }, -- Arachnoid Soulcleaver
				{ 5, 221152 }, -- Silksteel Striders
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Anub'zekt
			EncounterJournalID = 2584,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221154 }, -- Swarmcaller's Shroud
				{ 2, 221158 }, -- Burrower's Cinch
				{ 3, 221156 }, -- Cryptbound Headpiece
				{ 4, 221155 }, -- Swarm Monarch's Spaulders
				{ 5, 221157 }, -- Unbreakable Beetlebane Bindings
				{ 6, 219316 }, -- Ceaseless Swarmgland
				{ 7, 219315 }, -- Refracting Aggression Module
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Ki'katal the Harvester
			EncounterJournalID = 2585,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221164 }, -- Archaic Venomancer's Footwraps
				{ 2, 221160 }, -- Blight Hunter's Scalpelglaive
				{ 3, 221162 }, -- Claws of Tainted Ichor
				{ 4, 221161 }, -- Experimental Goresilk Chestguard
				{ 5, 219317 }, -- Harvester's Edict
				{ 6, 221159 }, -- Harvester's Interdiction
				{ 7, 221165 }, -- Unceremonious Bloodletter
				{ 8, 221163 }, -- Whispering Mask
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9,  223121 }, -- Formula: Enchanted Weathered Harbinger Crest
				{ 10, 223122 }, -- Formula: Enchanted Runed Harbinger Crest
				{ 11, 223123 }, -- Formula: Enchanted Gilded Harbinger Crest
				{ 12, 223088 }, -- Design: Elusive Blasphemite
				{ 13, 223142 }, -- Formula: Enchant Ring - Cursed Mastery
				{ 14, 223143 }, -- Formula: Enchant Ring - Cursed Versatility
				{ 15, 223141 }, -- Formula: Enchant Ring - Cursed Critical Strike
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}

data["The Dawnbreaker"] = {
	EncounterJournalID = 1270,
	MapID = 2359,
	AtlasMapID = "TheDawnbreaker",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Speaker Shadowcrown
			EncounterJournalID = 2580,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221136 }, -- Devout Zealot's Ring
				{ 2, 221132 }, -- Overflowing Umbral Pail
				{ 3, 221134 }, -- Shadow Congregant's Belt
				{ 4, 221133 }, -- Girdle of Somber Ploys
				{ 5, 219311 }, -- Void Pactstone
				{ 6, 221135 }, -- Fanatic's Blackened Shoulderwraps
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Anub'ikkaj
			EncounterJournalID = 2581,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221141 }, -- High Nerubian Signet
				{ 2, 219312 }, -- Empowering Crystal of Anub'ikkaj
				{ 3, 221139 }, -- Dark Priest's Carapace
				{ 4, 221142 }, -- Scheming Assailer's Bands
				{ 5, 221202 }, -- Defiance Crusher's Sabatons
				{ 6, 221140 }, -- Shadowblight Mantle
				{ 7, 221137 }, -- Black Shepherd's Guisarme
				{ 8, 221138 }, -- Parson's Ornamented Blade
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Rasha'nan
			EncounterJournalID = 2593,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221145 }, -- Shipwrecker's Bludgeon
				{ 2, 221144 }, -- Zephyrous Sail Carver
				{ 3, 221143 }, -- Recurved Hull Impaler
				{ 4, 221146 }, -- Soaring Behemoth's Greathelm
				{ 5, 221148 }, -- Epaulets of the Clipped Wings
				{ 6, 221147 }, -- Goliath's Chitinous Chainmail
				{ 7, 221149 }, -- Membranous Slippers
				{ 8, 219313 }, -- Mereldar's Toll
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
	}
}

data["City of Threads"] = {
	EncounterJournalID = 1274,
	MapID = 2313,
	AtlasMapID = "CityofThreads",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Orator Krix'vizk
			EncounterJournalID = 2594,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221166 }, -- Krix'vizk's Speech Rod
				{ 2, 221169 }, -- Whisperer's Echoing Steps
				{ 3, 221168 }, -- Cinch of Lingering Influence
				{ 4, 219318 }, -- Oppressive Orator's Larynx
				{ 5, 221167 }, -- Vociferous Subjugator's Bracers
				{ 6, 221170 }, -- Subduer's Terrorgrips
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Fangs of the Queen
			EncounterJournalID = 2595,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221173 }, -- Legplates of Duality
				{ 2, 221171 }, -- Kingslayer's Frostfang
				{ 3, 221172 }, -- Pail of Preserved Obscurity
				{ 4, 221175 }, -- Shadowchill Amice
				{ 5, 221174 }, -- Penumbral Rimeguards
				{ 6, 219319 }, -- Twin Fang Instruments
				{ 7, 221176 }, -- Arachnofrost Vest
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- The Coaglamation
			EncounterJournalID = 2600,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221181 }, -- Elder's Hemolymphal Periapt
				{ 2, 221179 }, -- Coagulum Cuirass
				{ 3, 221180 }, -- Gorebound Stranglers
				{ 4, 221178 }, -- Ichor-Stained Sollerets
				{ 5, 221182 }, -- Vitriolic Veinwoven Wraps
				{ 6, 221177 }, -- Old-Blood Hielaman
				{ 7, 219320 }, -- Viscous Coaglam
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Izo, the Grand Splicer
			EncounterJournalID = 2596,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221189 }, -- Experiment 08752's Band
				{ 2, 219321 }, -- Cirral Concoctory
				{ 3, 221185 }, -- Flesh Connector's Epaulets
				{ 4, 221186 }, -- Entwined Chimeric Legguards
				{ 5, 221188 }, -- Viscera-Lathered Coat
				{ 6, 221187 }, -- Intertwiner's Shadowcowl
				{ 7, 221184 }, -- Surgical Heartstopper
				{ 8, 221183 }, -- Splice 'n Dice
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9,  223121 }, -- Formula: Enchanted Weathered Harbinger Crest
				{ 10, 223122 }, -- Formula: Enchanted Runed Harbinger Crest
				{ 11, 223123 }, -- Formula: Enchanted Gilded Harbinger Crest
				{ 12, 223142 }, -- Formula: Enchant Ring - Cursed Mastery
				{ 13, 223143 }, -- Formula: Enchant Ring - Cursed Versatility
				{ 14, 223141 }, -- Formula: Enchant Ring - Cursed Critical Strike
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
				{ 15, 221174 }, -- Penumbral Rimeguards
			},
		},
	}
}

data["Darkflame Cleft"] = {
	EncounterJournalID = 1210,
	MapID = 2303,
	AtlasMapID = "DarkflameCleft",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Ol' Waxbeard
			EncounterJournalID = 2569,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221097 }, -- Arcane Scuttle
				{ 2, 219304 }, -- Conductor's Wax Whistle
				{ 3, 221098 }, -- Mole Knight's Grimemail
				{ 4, 221096 }, -- Rail Rider's Bisector
				{ 5, 221099 }, -- Wick's Golden Loop
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Blazikon
			EncounterJournalID = 2559,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221103 }, -- Flickering Glowtorc
				{ 2, 219305 }, -- Carved Blazikon Wax
				{ 3, 221100 }, -- Waxsteel Greathelm
				{ 4, 221102 }, -- Shimmering Glimclaws
				{ 5, 221101 }, -- Scent-Strong Candlecord
				{ 6, 221104 }, -- Gleamwax Shackles
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- The Candle King
			EncounterJournalID = 2560,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 219306 }, -- Burin of the Candle King
				{ 2, 221109 }, -- Candlebearer's Shroud
				{ 3, 221105 }, -- Dark Zone Headtaker
				{ 4, 221107 }, -- Gleamkeeper's Buckle
				{ 5, 221106 }, -- Gloomstomper's Sabatons
				{ 6, 221108 }, -- King's Malicious Clutches
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- The Darkness
			EncounterJournalID = 2561,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221112 }, -- Caliginous Claspers
				{ 2, 221110 }, -- Crepuscular Carver
				{ 3, 221113 }, -- Gloaming Visage
				{ 4, 221115 }, -- Photophobic Amice
				{ 5, 221111 }, -- Poleaxe of Somber Fate
				{ 6, 219307 }, -- Remnant of Darkness
				{ 7, 221114 }, -- Shadowspawn Leggings
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 8, 225548 }, -- Wick's Lead
			},
		},
	}
}

data["Cinderbrew Meadery"] = {
	EncounterJournalID = 1272,
	MapID = 2335,
	AtlasMapID = "CinderbrewMeadery",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Brew Master Aldryr
			EncounterJournalID = 2586,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221054 }, -- Chef Chewie's Towel
				{ 2, 221053 }, -- Battle-Scarred Fisticuffs
				{ 3, 221052 }, -- Foam-Ridden Pauldrons
				{ 4, 219297 }, -- Cinderbrew Stein
				{ 5, 221051 }, -- Crusher of the Unsettled
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- I'pa
			EncounterJournalID = 2587,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221060 }, -- Strapped Rescue-Keg
				{ 2, 221061 }, -- Hops-Laden Greatboots
				{ 3, 221056 }, -- Vessel of the Beverage
				{ 4, 221059 }, -- I'pa's Pale Aleguards
				{ 5, 221058 }, -- Brewery Toiler's Waistband
				{ 6, 221055 }, -- Cinderbrew-Soaked Cowl
				{ 7, 221057 }, -- Sticky Stirring Stick
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Benk Buzzbee
			EncounterJournalID = 2588,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221201 }, -- Fireproof Cinderbee Perch
				{ 2, 221064 }, -- Fuzzy Cindercuffs
				{ 3, 221063 }, -- Hivebreaker's Dipper
				{ 4, 221065 }, -- Pollen-Lugger Treads
				{ 5, 221067 }, -- Punctured Apiary Gloves
				{ 6, 219298 }, -- Ravenous Honey Buzzer
				{ 7, 221062 }, -- Scalding Queenmaker's Shiv
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Goldie Baronbottom
			EncounterJournalID = 2589,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 221198 }, -- 85-Year Tenure Ring
				{ 2, 219299 }, -- Synergistic Brewterializer
				{ 3, 221071 }, -- Backbreaking Bootstrappers
				{ 4, 221069 }, -- Slashproof Business Plate
				{ 5, 221070 }, -- "Azeroth's Greatest BEE.E.O." Cap
				{ 6, 221072 }, -- Moneymaking Businessmantle
				{ 7, 221068 }, -- Profit Divider
				{ 8, 223155 }, -- Bop
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9,  223121 }, -- Formula: Enchanted Weathered Harbinger Crest
				{ 10, 223122 }, -- Formula: Enchanted Runed Harbinger Crest
				{ 11, 223123 }, -- Formula: Enchanted Gilded Harbinger Crest
				{ 12, 223088 }, -- Design: Elusive Blasphemite
				{ 13, 224424 }, -- Pattern: Artisan Chef's Hat
				{ 14, 223102 }, -- Pattern: Busy Bee's Buckle
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

data["Nerub-ar Palace"] = {
	EncounterJournalID = 1273,
	MapID = 2291,
	AtlasMapID = "NerubarPalace",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ -- Ulgrax the Devourer
			EncounterJournalID = 2607,
			[NORMAL_RAID_DIFF] = {
				{ 1,  212386 }, -- Husk of Swallowing Darkness
				{ 2,  212423 }, -- Rebel's Drained Marrowslacks
				{ 3,  212419 }, -- Bile-Soaked Harness
				{ 4,  212428 }, -- Final Meal's Horns
				{ 5,  219915 }, -- Foul Behemoth's Chelicera
				{ 6,  212424 }, -- Seasoned Earthen Boulderplates
				{ 7,  212388 }, -- Ulgrax's Morsel-Masher
				{ 8,  212409 }, -- Venom-Etched Claw
				{ 9,  212426 }, -- Crunchy Intruder's Wristband
				{ 10, 212425 }, -- Devourer's Taut Innards
				{ 11, 212442 }, -- Greatbelt of the Hungerer
				{ 12, 212446 }, -- Royal Emblem of Nerub-ar
				{ 13, 212431 }, -- Undermoth-Lined Footpads
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- The Bloodbound Horror
			EncounterJournalID = 2611,
			[NORMAL_RAID_DIFF] = {
				{ 1,  212404 }, -- Scepter of Manifested Miasma
				{ 2,  212451 }, -- Aberrant Spellforge
				{ 3,  212395 }, -- Blood-Kissed Kukri
				{ 4,  212422 }, -- Bloodbound Horror's Legplates
				{ 5,  212447 }, -- Key to the Unseeming
				{ 6,  212417 }, -- Beyond's Dark Visage
				{ 7,  212438 }, -- Polluted Spectre's Wraps
				{ 8,  212439 }, -- Beacons of the False Dawn
				{ 9,  212421 }, -- Goresplattered Membrane
				{ 10, 212414 }, -- Lost Watcher's Remains
				{ 11, 225590 }, -- Boots of the Black Bulwark
				{ 12, 219917 }, -- Creeping Coagulum
				{ 13, 212430 }, -- Shattered Eye Cincture
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Sikran, Captain of the Sureki
			EncounterJournalID = 2599,
			[NORMAL_RAID_DIFF] = {
				{ 1,  212445 }, -- Chitin-Spiked Jackboots
				{ 2,  212416 }, -- Cosmic-Tinged Treads
				{ 3,  212392 }, -- Duelist's Dancing Steel
				{ 4,  212405 }, -- Flawless Phase Blade
				{ 5,  212413 }, -- Honored Executioner's Perforator
				{ 6,  212449 }, -- Sikran's Endless Arsenal
				{ 7,  212399 }, -- Splintershot Silkbow
				{ 8,  225577 }, -- Sureki Zealot's Insignia
				{ 9,  212415 }, -- Throne Defender's Bangles
				{ 10, 212427 }, -- Visor of the Ascended Captain
				{ 11, 225618 }, -- Dreadful Stalwart's Emblem
				{ 12, 225619 }, -- Mystic Stalwart's Emblem
				{ 13, 225620 }, -- Venerated Stalwart's Emblem
				{ 14, 225621 }, -- Zenith Stalwart's Emblem
				{ 15, 223097 }, -- Pattern: Adrenal Surge Clasp
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Rasha'nan
			EncounterJournalID = 2609,
			[NORMAL_RAID_DIFF] = {
				{ 1,  225583 }, -- Behemoth's Eroded Cinch
				{ 2,  212398 }, -- Bludgeons of Blistering Wind
				{ 3,  212440 }, -- Devotee's Discarded Headdress
				{ 4,  212448 }, -- Locket of Broken Memories
				{ 5,  212391 }, -- Predator's Feasthooks
				{ 6,  225586 }, -- Rasha'nan's Grotesque Talons
				{ 7,  212437 }, -- Ravaged Lamplighter's Manacles
				{ 8,  212453 }, -- Skyterror's Corrosive Organ
				{ 9,  225574 }, -- Wings of Shattered Sorrow
				{ 10, 225630 }, -- Dreadful Obscenity's Idol
				{ 11, 225631 }, -- Mystic Obscenity's Idol
				{ 12, 225632 }, -- Venerated Obscenity's Idol
				{ 13, 225633 }, -- Zenith Obscenity's Idol
				{ 14, 224435 }, -- Pattern: Duskthread Lining
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Broodtwister Ovi'nax
			EncounterJournalID = 2612,
			[NORMAL_RAID_DIFF] = {
				{ 1,  225580 }, -- Accelerated Ascension Coil
				{ 2,  225582 }, -- Assimilated Eggshell Slippers
				{ 3,  212418 }, -- Black Blood Injectors
				{ 4,  212387 }, -- Broodtwister's Grim Catalyst
				{ 5,  220305 }, -- Ovi'nax's Mercurial Egg
				{ 6,  225588 }, -- Sanguine Experiment's Bandages
				{ 7,  212389 }, -- Spire of Transfused Horrors
				{ 8,  225576 }, -- Writhing Ringworm
				{ 9,  212452 }, -- Gruesome Syringe
				{ 10, 225614 }, -- Dreadful Blasphemer's Effigy
				{ 11, 225615 }, -- Mystic Blasphemer's Effigy
				{ 12, 225616 }, -- Venerated Blasphemer's Effigy
				{ 13, 225617 }, -- Zenith Blasphemer's Effigy
				{ 14, 226190 }, -- Recipe: Sticky Sweet Treat
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Nexus-Princess Ky'veza
			EncounterJournalID = 2601,
			[NORMAL_RAID_DIFF] = {
				{ 1,  212441 }, -- Bindings of the Starless Night
				{ 2,  225591 }, -- Fleeting Massacre Footpads
				{ 3,  225581 }, -- Ky'veza's Covert Clasps
				{ 4,  225589 }, -- Nether Bounty's Greatbelt
				{ 5,  225636 }, -- Regicide
				{ 6,  212400 }, -- Shade-Touched Silencer
				{ 7,  221023 }, -- Treacherous Transmitter
				{ 8,  212456 }, -- Void Reaper's Contract
				{ 9,  219877 }, -- Void Reaper's Warp Blade
				{ 10, 225626 }, -- Dreadful Slayer's Icon
				{ 11, 225627 }, -- Mystic Slayer's Icon
				{ 12, 225628 }, -- Venerated Slayer's Icon
				{ 13, 225629 }, -- Zenith Slayer's Icon
				{ 14, 223048 }, -- Plans: Siphoning Stiletto
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- The Silken Court
			EncounterJournalID = 2608,
			[NORMAL_RAID_DIFF] = {
				{ 1,  212407 }, -- Anub'arash's Colossal Mandible
				{ 2,  212443 }, -- Shattershell Greaves
				{ 3,  225575 }, -- Silken Advisor's Favor
				{ 4,  225584 }, -- Skeinspinner's Duplicitous Cuffs
				{ 5,  220202 }, -- Spymaster's Web
				{ 6,  212450 }, -- Swarmlord's Authority
				{ 7,  212397 }, -- Takazj's Entropic Edict
				{ 8,  212432 }, -- Thousand-Scar Impalers
				{ 9,  212429 }, -- Whispering Voidlight Spaulders
				{ 10, 225622 }, -- Dreadful Conniver's Badge
				{ 11, 225623 }, -- Mystic Conniver's Badge
				{ 12, 225624 }, -- Venerated Conniver's Badge
				{ 13, 225625 }, -- Zenith Conniver's Badge
				{ 14, 223094 }, -- Design: Magnificent Jeweler's Setting
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Queen Ansurek
			EncounterJournalID = 2602,
			[NORMAL_RAID_DIFF] = {
				{ 1,  225634 }, -- Web-Wrapped Curio
				{ 2,  225579 }, -- Crest of the Caustic Despot
				{ 3,  225587 }, -- Devoted Offering's Irons
				{ 4,  212444 }, -- Frame of Felled Insurgents
				{ 5,  212435 }, -- Liquified Defector's Leggings
				{ 6,  212454 }, -- Mad Queen's Mandate
				{ 7,  212433 }, -- Omnivore's Venomous Camouflage
				{ 8,  212434 }, -- Voidspoken Sarong
				{ 9,  225585 }, -- Acrid Ascendant's Sash
				{ 10, 212401 }, -- Ansurek's Final Judgment
				{ 11, 212436 }, -- Clutches of Paranoia
				{ 12, 212420 }, -- Queensguard Carapace
				{ 13, 212394 }, -- Sovereign's Disdain
				{ 14, 225578 }, -- Seal of the Poisoned Pact
				{ 15, 223144 }, -- Formula: Enchant Weapon - Authority of the Depths
				{ 16, 224147, "mount" }, -- Reins of the Sureki Skyrazor
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, 224151, "mount" }, -- Reins of the Ascendant Skyrazor
			},
		},
	}
}
