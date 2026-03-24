-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 12)

AtlasLoot:RegisterModules(addonname)

local AL = AtlasLoot.Locales

local ADD_SCALING = {
	Item = {
		addDifficultyBonus = true,
	}
}

local NORMAL_DUNGEON_DIFF = data:AddDifficulty(AL["Normal"], "DungeonWithPreset", ADD_SCALING, 1)
local HEROIC_DUNGEON_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicDungeonWithPreset", ADD_SCALING, 2)
local MYTHICD_DUNGEON_DIFF = data:AddDifficulty(AL["Mythic"], "MythicDungeonWithPreset", ADD_SCALING, 23)

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "LFRWithPreset", ADD_SCALING, 17)
local NORMAL_RAID_DIFF = data:AddDifficulty(AL["Normal"], "NormalRaidWithPreset", ADD_SCALING, 14)
local HEROIC_PRE_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicWithPreset", ADD_SCALING, 15)
local MYTHIC_PRE_DIFF = data:AddDifficulty(AL["Mythic"], "MyhticWithPreset", ADD_SCALING, 16)

local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)


-- /////////////////////////////////
-- Instance
-- /////////////////////////////////

data["Windrunner Spire"] = {
	EncounterJournalID = 1299,
	MapID = 2492,
	AtlasMapID = "WindrunnerSpire",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Emberdawn
			EncounterJournalID = 2655,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251078 }, -- Emberdawn Defender
				{ 2, 251077 }, -- Roostwarden's Bough
				{ 3, 251080 }, -- Brambledawn Halo
				{ 4, 251079 }, -- Amberfrond Bracers
				{ 5, 251081 }, -- Embergrove Grasps
				{ 6, 251082 }, -- Snapvine Cinch
				{ 7, 250144 }, -- Emberwing Feather
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Derelict Duo
			EncounterJournalID = 2656,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251083 }, -- Excavating Cudgel
				{ 2, 251085 }, -- Mantle of Dark Devotion
				{ 3, 251086 }, -- Riphook Defender
				{ 4, 251087 }, -- Legwraps of Lingering Legacies
				{ 5, 251084 }, -- Whipcoil Sabatons
				{ 6, 250226 }, -- Latch's Crooked Hook
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Commander Kroluk
			EncounterJournalID = 2657,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251088 }, -- Warworn Cleaver
				{ 2, 251092 }, -- Fallen Grunt's Mantle
				{ 3, 251089 }, -- Grips of Forgotten Honor
				{ 4, 251090 }, -- Commander's Faded Breeches
				{ 5, 251091 }, -- Sabatons of Furious Revenge
				{ 6, 250227 }, -- Kroluk's Warbanner
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- The Restless Heart
			EncounterJournalID = 2658,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251095 }, -- Hurricane's Heart
				{ 2,  251094 }, -- Sigil of the Restless Heart
				{ 3,  251098 }, -- Fletcher's Faded Faceplate
				{ 4,  251096 }, -- Pendant of Aching Grief
				{ 5,  251097 }, -- Spaulders of Arrow's Flight
				{ 6,  251099 }, -- Vest of the Howling Gale
				{ 7,  250256 }, -- Heart of Wind
				{ 16, 256653 }, -- Pattern: Ranger-General's Grips
				{ 17, 258125 }, -- Pattern: Sunfire Sash
				{ 18, 256683 }, -- Silvermoon Training Dummy
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9, 262914, "mount" }, -- Spectral Hawkstrider
			},
		},
	}
}

data["Magisters Terrace Midnight"] = {
	EncounterJournalID = 1300,
	MapID = 2511,
	AtlasMapID = "MagistersTerraceMidnight",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Arcanotron Custos
			EncounterJournalID = 2659,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251100 }, -- Malfeasance Mallet
				{ 2, 251101 }, -- Arcane Guardian's Shell
				{ 3, 251103 }, -- Custodial Cuffs
				{ 4, 251102 }, -- Clasp of Compliance
				{ 5, 251104 }, -- Leggings of Orderly Conduct
				{ 6, 250246 }, -- Refueling Orb
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Seranel Sunlash
			EncounterJournalID = 2661,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251106 }, -- Resolute Runeglaive
				{ 2, 251105 }, -- Ward of the Spellbreaker
				{ 3, 251109 }, -- Spellsnap Shadowmask
				{ 4, 260312 }, -- Defiant Defender's Drape
				{ 5, 251108 }, -- Wraps of Watchful Wrath
				{ 6, 251110 }, -- Sunlash's Sunsash
				{ 7, 251107 }, -- Oathsworn Stompers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Gemellus
			EncounterJournalID = 2660,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251111 }, -- Splitshroud Stinger
				{ 2, 251114 }, -- Voidwarped Oozemail
				{ 3, 251113 }, -- Gloves of Viscous Goo
				{ 4, 251112 }, -- Shadowsplit Girdle
				{ 5, 251115 }, -- Bifurcation Band
				{ 6, 250242 }, -- Jelly Replicator
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Degentrius
			EncounterJournalID = 2662,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251117 }, -- Whirling Voidcleaver
				{ 2,  251122 }, -- Shadowslash Slicer
				{ 3,  251119 }, -- Vortex Visage
				{ 4,  251120 }, -- Wraps of Umbral Descent
				{ 5,  251118 }, -- Legplates of Lingering Dusk
				{ 6,  251121 }, -- Domanaar's Dire Treads
				{ 7,  250257 }, -- Eye of the Drowning Void
				{ 16, 256755 }, -- Formula: Enchant Chest - Mark of the Magister
				{ 17, 256759 }, -- Formula: Enchant Weapon - Flames of the Sin'dorei
				{ 18, 258033 }, -- Pattern: Arcanoweave Lining
				{ 19, 263230 }, -- Magister's Bookshelf
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9, 260231, "mount" }, -- Lucent Hawkstrider
			},
		},
	}
}

data["Murder Row"] = {
	EncounterJournalID = 1304,
	MapID = 2433,
	AtlasMapID = "MurderRow",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Kystia Manaheart
			EncounterJournalID = 2679,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251123 }, -- Nibbles' Training Rod
				{ 2, 251126 }, -- Greathelm of Temptation
				{ 3, 251127 }, -- Nibbling Armbands
				{ 4, 251124 }, -- Gauntlets of Fevered Defense
				{ 5, 251125 }, -- Felsoaked Soles
				{ 6, 250243 }, -- Manaheart's Binding Flame
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Zaen Bladesorrow
			EncounterJournalID = 2680,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251128 }, -- Bladesorrow
				{ 2, 251131 }, -- Jangling Felpaulets
				{ 3, 251132 }, -- Speakeasy Shroud
				{ 4, 251133 }, -- Overseer's Vambraces
				{ 5, 251129 }, -- Counterfeit Clutches
				{ 6, 251130 }, -- Breeches of Deft Deals
				{ 7, 250215 }, -- Freightrunner's Flask
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Xathuux the Annihilator
			EncounterJournalID = 2681,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251134 }, -- Xathuux's Cleave
				{ 2, 251135 }, -- Fury-fletched Armlets
				{ 3, 251137 }, -- Tempestuous Sandals
				{ 4, 251136 }, -- Signet of Snarling Servitude
				{ 5, 250228 }, -- Resonant Bellowstone
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Lithiel Cinderfury
			EncounterJournalID = 2682,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251140 }, -- Vilefiend's Guise
				{ 2,  251142 }, -- Pendant of Malefic Fury
				{ 3,  251138 }, -- Cinderfury Shoulderguards
				{ 4,  251139 }, -- Summoner's Searing Shirt
				{ 5,  251141 }, -- Lithiel's Linked Leggings
				{ 6,  250255 }, -- Unstable Felheart Crystal
				{ 16, 256640 }, -- Pattern: Row Walker's Insurance
				{ 17, 256746 }, -- Formula: Smuggler's Enchanted Edge
				{ 18, 258518 }, -- Plans: Murder Row Fishhook
				{ 19, 258487 }, -- Plans: Murder Row Fleet Feet
				{ 20, 263238 }, -- Illicit Long Table
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

data["Den of Nalorakk"] = {
	EncounterJournalID = 1311,
	MapID = 2513,
	AtlasMapID = "DenOfNalorakk",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- The Hoardmonger
			EncounterJournalID = 2776,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251143 }, -- Grim Harvest Gloves
				{ 2, 251146 }, -- Scavenger's Spaulders
				{ 3, 251147 }, -- Hoarded Harvest Wrap
				{ 4, 251144 }, -- Autumn's Boon Belt
				{ 5, 251145 }, -- Forgotten Tribe Footguards
				{ 6, 251148 }, -- Pilfered Precious Band
				{ 7, 250248 }, -- Mycolic Medicine
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Sentinel of Winter
			EncounterJournalID = 2777,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251149 }, -- Victor's Flashfrozen Blade
				{ 2, 251150 }, -- Tempest's Shelter
				{ 3, 251151 }, -- Sentinel Challenger's Prize
				{ 4, 251154 }, -- Winter's Embrace Bracers
				{ 5, 251152 }, -- Season's Turn Gauntlets
				{ 6, 251155 }, -- Tribal Defender's Cord
				{ 7, 251153 }, -- Arctic Explorer's Legwraps
				{ 8, 250244 }, -- Permafrost Essence
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Nalorakk
			EncounterJournalID = 2778,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251156 }, -- Fallen Speaker's Staff
				{ 2,  251158 }, -- Nalorakk's Nightmare
				{ 3,  251173 }, -- Yoke of the Charging Bear
				{ 4,  251159 }, -- War Trial Vestments
				{ 5,  251214 }, -- Bonds of the Hash'ura
				{ 6,  251160 }, -- Forest Dream Leg-guards
				{ 7,  250229 }, -- Idol of the War Loa
				{ 16, 256737 }, -- Formula: Enchant Chest - Mark of Nalorakk
				{ 17, 264332 }, -- Amani Ritual Altar
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

data["Maisara Caverns"] = {
	EncounterJournalID = 1315,
	MapID = 2501,
	AtlasMapID = "MaisaraCaverns",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Muro'jin and Nekraxx
			EncounterJournalID = 2810,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251162 }, -- Traitor's Talon
				{ 2, 251174 }, -- Deceiver's Rotbow
				{ 3, 251176 }, -- Reanimator's Weight
				{ 4, 263193 }, -- Trollhunter's Bands
				{ 5, 251166 }, -- Falconer's Cinch
				{ 6, 251167 }, -- Nightprey Stalkers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Vordaza
			EncounterJournalID = 2811,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251178 }, -- Ceremonial Hexblade
				{ 2, 251171 }, -- Enthralled Bonespines
				{ 3, 251161 }, -- Soulhunter's Mask
				{ 4, 251172 }, -- Vilehex Bonds
				{ 5, 251170 }, -- Wickedweave Trousers
				{ 6, 251169 }, -- Footwraps of Ill-Fate
				{ 7, 250223 }, -- Soulcatcher's Charm
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Rak'tul, Vessel of Souls
			EncounterJournalID = 2812,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251168 }, -- Liferipper's Cutlass
				{ 2,  251163 }, -- Berserker's Hexclaws
				{ 3,  251175 }, -- Soulblight Cleaver
				{ 4,  251177 }, -- Fetid Vilecrown
				{ 5,  251164 }, -- Amalgamation's Harness
				{ 6,  251179 }, -- Decaying Cuirass
				{ 7,  250258 }, -- Vessel of Tortured Souls
				{ 16, 256625 }, -- Pattern: Hexwoven Strand
				{ 17, 264717 }, -- Amani Warding Hex
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

data["Blinding Vale"] = {
	EncounterJournalID = 1309,
	MapID = 2500,
	AtlasMapID = "BlindingVale",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Lightblossom Trinity
			EncounterJournalID = 2769,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251181 }, -- Pruning Lance
				{ 2, 251180 }, -- Thornblade
				{ 3, 251184 }, -- Ironroot Collar
				{ 4, 251183 }, -- Rootwarden Wraps
				{ 5, 251185 }, -- Lightblossom Cinch
				{ 6, 251182 }, -- Bedrock Breeches
				{ 7, 250254 }, -- Seed of Radiant Hope
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Ikuzz the Light Hunter
			EncounterJournalID = 2770,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251186 }, -- Thorntalon Edge
				{ 2, 251187 }, -- Amirdrassil's Reach
				{ 3, 251188 }, -- Doompetal
				{ 4, 251190 }, -- Bloodthorn Burnous
				{ 5, 251189 }, -- Rootwalker Harness
				{ 6, 250238 }, -- Seed of the Devouring Wild
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Lightwarden Ruia
			EncounterJournalID = 2771,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251192 }, -- Branch of Pride
				{ 2, 251191 }, -- Luminescent Sprout
				{ 3, 251193 }, -- Taproot Ribs
				{ 4, 251165 }, -- Pulverizing Pads
				{ 5, 251194 }, -- Lightwarden's Bind
				{ 6, 250214 }, -- Lightspire Core
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Ziekket
			EncounterJournalID = 2772,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251195 }, -- Thorned Reply
				{ 2,  251196 }, -- Teldrassil's Sacrifice
				{ 3,  251199 }, -- Worldroot Canopy
				{ 4,  251200 }, -- Saptorbane Guards
				{ 5,  251197 }, -- Thornspike Gauntlets
				{ 6,  251198 }, -- Lightspore Leggings
				{ 7,  250259 }, -- Sapling of the Dawnroot
				{ 16, 256642 }, -- Pattern: Primal Spore Binding
				{ 17, 256652 }, -- Pattern: World Tender's Trunkplate
				{ 18, 253451 }, -- Veilroot Fountain
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9, 268728 }, -- Saptor Salve
			},
		},
	}
}

data["Nexus-Point Xenas"] = {
	EncounterJournalID = 1316,
	MapID = 2556,
	AtlasMapID = "NexusPointXenas",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Chief Corewright Kasreth
			EncounterJournalID = 2813,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251201 }, -- Corespark Multitool
				{ 2, 251202 }, -- Reflux Reflector
				{ 3, 251206 }, -- Fluxweave Cloak
				{ 4, 251203 }, -- Kasreth's Bindings
				{ 5, 251204 }, -- Corewright's Zappers
				{ 6, 251205 }, -- Leyline Leggings
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Corewarden Nysarra
			EncounterJournalID = 2814,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251207 }, -- Dreadflail Bludgeon
				{ 2, 251213 }, -- Nysarra's Mantle
				{ 3, 251209 }, -- Corewarden Cuffs
				{ 4, 251208 }, -- Lightscarred Cuisses
				{ 5, 251210 }, -- Eclipse Espadrilles
				{ 6, 251093 }, -- Omission of Light
				{ 7, 250253 }, -- Whisper of the Duskwraith
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Lothraxion
			EncounterJournalID = 2815,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251212 }, -- Radiant Slicer
				{ 2,  251157 }, -- Searing Spaulders
				{ 3,  251216 }, -- Maledict Vest
				{ 4,  251211 }, -- Fractured Fingerguards
				{ 5,  251215 }, -- Greaves of the Divine Guile
				{ 6,  251217 }, -- Occlusion of Void
				{ 7,  250241 }, -- Mark of Light
				{ 16, 256716 }, -- Design: Prismatic Focusing Iris
				{ 17, 264338 }, -- Domanaar Control Console
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

data["Voidscar Arena"] = {
	EncounterJournalID = 1313,
	MapID = 2572,
	AtlasMapID = "VoidscarArena",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Taz'Rah
			EncounterJournalID = 2791,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251218 }, -- Taz'Rah's Cosmic Edge
				{ 2, 251220 }, -- Voidscarred Crown
				{ 3, 251223 }, -- Somber Spaulders
				{ 4, 251221 }, -- Despondent's Gauntlets
				{ 5, 251222 }, -- Ethereal Netherwrap
				{ 6, 251219 }, -- Riftworn Stompers
				{ 7, 250225 }, -- Void Execution Mandate
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Atroxus
			EncounterJournalID = 2792,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 251225 }, -- Fang of Contagion
				{ 2, 251224 }, -- Hulking Handaxe
				{ 3, 251229 }, -- Visor of the Predator
				{ 4, 251227 }, -- Poisoner's Pauldrons
				{ 5, 251226 }, -- Hide of Pestilence
				{ 6, 251228 }, -- Behemoth Waistband
				{ 7, 252258 }, -- Sickening Signet of Atroxus
				{ 8, 250245 }, -- Tumor of the Swarm
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Charonus
			EncounterJournalID = 2793,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  251230 }, -- Charonic Crescent
				{ 2,  251231 }, -- Singularity Slicer
				{ 3,  251232 }, -- Overseer's Diadem
				{ 4,  251234 }, -- Graft of the Domanaar
				{ 5,  251233 }, -- Manipulator's Vest
				{ 6,  251235 }, -- Gravitic Girdle
				{ 7,  250224 }, -- Mindpiercer's Sigil
				{ 16, 256721 }, -- Design: Voidstone Shielding Array
				{ 17, 264336 }, -- Voidlight Brazier
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

data["Voidspire"] = {
	EncounterJournalID = 1307,
	MapID = 2529,
	AtlasMapID = "VoidspireA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ -- Imperator Averzian
			EncounterJournalID = 2733,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249293 }, -- Weight of Command
				{ 2,  249279 }, -- Sunstrike Rifle
				{ 3,  249275 }, -- Bulwark of Noble Resolve
				{ 4,  249306 }, -- Devouring Night's Visage
				{ 5,  249313 }, -- Light-Judged Spaulders
				{ 6,  249335 }, -- Imperator's Banner
				{ 7,  249310 }, -- Robes of the Voidbound
				{ 8,  249326 }, -- Light's March Bracers
				{ 9,  249319 }, -- Endless March Waistwrap
				{ 10, 249323 }, -- Leggings of the Devouring Advance
				{ 11, 249320 }, -- Sabatons of Obscurement
				{ 12, 249334 }, -- Void-Claimed Shinkickers
				{ 13, 249344 }, -- Light Company Guidon
				{ 16, 264497 }, -- Imperator's Torment Crystal
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Vorasius
			EncounterJournalID = 2734,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249302 }, -- Inescapable Reach
				{ 2,  249925 }, -- Hungering Victory
				{ 3,  249276 }, -- Grimoire of the Eternal Light
				{ 4,  249317 }, -- Frenzy's Rebuke
				{ 5,  249327 }, -- Void-Skinned Bracers
				{ 6,  249315 }, -- Voracious Wristwraps
				{ 7,  249332 }, -- Parasite Stompers
				{ 8,  249336 }, -- Signet of the Starved Beast
				{ 9,  249342 }, -- Heart of Ancient Hunger
				{ 10, 249353 }, -- Voidcast Hungering Nullcore
				{ 11, 249352 }, -- Voidcured Hungering Nullcore
				{ 12, 249354 }, -- Voidforged Hungering Nullcore
				{ 13, 249351 }, -- Voidwoven Hungering Nullcore
				{ 16, 258522 }, -- Plans: Bloomforged Greataxe
				{ 17, 264498 }, -- Voltaic Trigore Egg
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Fallen-King Salhadaar
			EncounterJournalID = 2736,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249281 }, -- Blade of the Final Twilight
				{ 2,  249298 }, -- Tormentor's Bladed Fists
				{ 3,  249316 }, -- Crown of the Fractured Tyrant
				{ 4,  249337 }, -- Ribbon of Coiled Malice
				{ 5,  249308 }, -- Despotic Raiment
				{ 6,  249304 }, -- Fallen King's Cuffs
				{ 7,  249314 }, -- Twisted Twilight Sash
				{ 8,  249341 }, -- Volatile Void Suffuser
				{ 9,  249340 }, -- Wraps of Cosmic Madness
				{ 10, 249365 }, -- Voidcast Unraveled Nullcore
				{ 11, 249364 }, -- Voidcured Unraveled Nullcore
				{ 12, 249366 }, -- Voidforged Unraveled Nullcore
				{ 13, 249363 }, -- Voidwoven Unraveled Nullcore
				{ 15, 264672 }, -- Cosmic Ritual Stone
				{ 16, 258123 }, -- Pattern: Sunfire Silk Spellthread
				{ 17, 264494 }, -- Banded Domanaar Storage Crate
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Vaelgor & Ezzorak
			EncounterJournalID = 2735,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249287 }, -- Clutchmates' Caress
				{ 2,  249280 }, -- Emblazoned Sunglaive
				{ 3,  249318 }, -- Nullwalker's Dread Epaulettes
				{ 4,  249370 }, -- Draconic Nullcape
				{ 5,  249321 }, -- Vaelgor's Fearsome Grasp
				{ 6,  249331 }, -- Ezzorak's Gloombind
				{ 7,  249305 }, -- Slippers of the Midnight Flame
				{ 8,  249339 }, -- Gloom-Spattered Dreadscale
				{ 9,  249346 }, -- Vaelgor's Final Stare
				{ 10, 249361 }, -- Voidcast Corrupted Nullcore
				{ 11, 249360 }, -- Voidcured Corrupted Nullcore
				{ 12, 249362 }, -- Voidforged Corrupted Nullcore
				{ 13, 249359 }, -- Voidwoven Corrupted Nullcore
				{ 16, 258521 }, -- Plans: Blood Knight's Impetus
				{ 17, 264491 }, -- Voidbound Holding Cell
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Lightblinded Vanguard
			EncounterJournalID = 2737,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249277 }, -- Bellamy's Final Judgement
				{ 2,  249294 }, -- Blade of the Blind Verdict
				{ 3,  249333 }, -- Blooming Barklight Spaulders
				{ 4,  249330 }, -- War Chaplain's Grips
				{ 5,  249303 }, -- Waistcord of the Judged
				{ 6,  249311 }, -- Lightblood Greaves
				{ 7,  249369 }, -- Bond of Light
				{ 8,  249808 }, -- Litany of Lightblind Wrath
				{ 9,  249357 }, -- Voidcast Fanatical Nullcore
				{ 10, 249356 }, -- Voidcured Fanatical Nullcore
				{ 11, 249358 }, -- Voidforged Fanatical Nullcore
				{ 12, 249355 }, -- Voidwoven Fanatical Nullcore
				{ 16, 258517 }, -- Plans: Knight-Commander's Palisade
				{ 17, 262957 }, -- Tattered Vanguard Banner
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Crown of the Cosmos
			EncounterJournalID = 2738,
			[NORMAL_RAID_DIFF] = {
				{ 1,  260423 }, -- Arator's Swift Remembrance
				{ 2,  249295 }, -- Turalyon's False Echo
				{ 3,  249288 }, -- Ranger-Captain's Lethal Recurve
				{ 4,  249329 }, -- Gaze of the Unrestrained
				{ 5,  249368 }, -- Eternal Voidsong Chain
				{ 6,  249309 }, -- Sunbound Breastplate
				{ 7,  249325 }, -- Untethered Berserker's Grips
				{ 8,  249380 }, -- Hate-Tied Waistchain
				{ 9,  249312 }, -- Nightblade's Pantaloons
				{ 10, 249382 }, -- Canopy Walker's Footwraps
				{ 11, 249809 }, -- Locus-Walker's Ribbon
				{ 12, 249345 }, -- Ranger-Captain's Iridescent Insignia
				{ 16, 269269 }, -- Devouring Ritual Spire
				{ 17, 268049 }, -- Voidspire Vanquisher's Argent Trophy
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 18, 265951 }, -- Voidspire Vanquisher's Aureate Trophy
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = HEROIC_PRE_DIFF,
				{ 19, 266887 }, -- Voidspire Vanquisher's Gleaming Trophy
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}

data["Dreamrift"] = {
	EncounterJournalID = 1314,
	MapID = 2531,
	AtlasMapID = "Dreamrift",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ -- Chimaerus the Undreamt God
			EncounterJournalID = 2795,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249278 }, -- Alnscorned Spire
				{ 2,  249922 }, -- Tome of Alnscorned Regret
				{ 3,  249374 }, -- Scorn-Scarred Shul'ka's Belt
				{ 4,  249371 }, -- Scornbane Waistguard
				{ 5,  249373 }, -- Dream-Scorched Striders
				{ 6,  249381 }, -- Greaves of the Unformed
				{ 7,  249343 }, -- Gaze of the Alnseer
				{ 8,  249805 }, -- Undreamt God's Oozing Vestige
				{ 9,  249349 }, -- Alncast Riftbloom
				{ 10, 249348 }, -- Alncured Riftbloom
				{ 11, 249350 }, -- Alnforged Riftbloom
				{ 12, 249347 }, -- Alnwoven Riftbloom
				{ 16, 256656 }, -- Pattern: World Tender's Barkclasp
				{ 17, 256750 }, -- Formula: Enchant Weapon - Worldsoul Cradle
				{ 18, 264246 }, -- Eerie Iridescent Riftshroom
				{ 19, 267645 }, -- Dreamrift Vanquisher's Argent Trophy
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 20, 265950 }, -- Dreamrift Vanquisher's Aureate Trophy
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = HEROIC_PRE_DIFF,
				{ 21, 266886 }, -- Dreamrift Vanquisher's Gleaming Trophy
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}

data["March on Quel'Danas"] = {
	EncounterJournalID = 1308,
	MapID = 2533,
	AtlasMapID = "MarchOnQuelDanas",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ -- Belo'ren, Child of Al'ar
			EncounterJournalID = 2739,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249283 }, -- Belo'melorn, the Shattered Talon
				{ 2,  249284 }, -- Belo'ren's Swift Talon
				{ 3,  249921 }, -- Thalassian Dawnguard
				{ 4,  249328 }, -- Echoing Void Mantle
				{ 5,  249322 }, -- Radiant Clutchtender's Jerkin
				{ 6,  249307 }, -- Emberborn Grasps
				{ 7,  249376 }, -- Whisper-Inscribed Sash
				{ 8,  249324 }, -- Eternal Flame Scaleguards
				{ 9,  249377 }, -- Darkstrider Treads
				{ 10, 249919 }, -- Sin'dorei Band of Hope
				{ 11, 249806 }, -- Radiant Plume
				{ 12, 249807 }, -- The Eternal Egg
				{ 13, 260235 }, -- Umbral Plume
				{ 16, 256715 }, -- Design: Thalassian Phoenix Torque
				{ 17, 264187 }, -- Blessed Phoenix Egg
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Midnight Falls
			EncounterJournalID = 2740,
			[NORMAL_RAID_DIFF] = {
				{ 1,  249296 }, -- Alah'endal, the Dawnsong
				{ 2,  249286 }, -- Brazier of the Dissonant Dirge
				{ 3,  260408 }, -- Lightless Lament
				{ 4,  249913 }, -- Mask of Darkest Intent
				{ 5,  249914 }, -- Oblivion Guise
				{ 6,  250247 }, -- Amulet of the Abyssal Hymn
				{ 7,  249912 }, -- Robes of Endless Oblivion
				{ 8,  249915 }, -- Extinction Guards
				{ 9,  249920 }, -- Eye of Midnight
				{ 10, 249811 }, -- Light of the Cosmic Crescendo
				{ 11, 249810 }, -- Shadow of the Empyrean Requiem
				{ 12, 249367 }, -- Chiming Void Curio
				{ 16, 258519 }, -- Plans: Magister's Valediction
				{ 17, 264492 }, -- Chaotic Void Maw
				{ 18, 267646 }, -- March on Quel'Danas Vanquisher's Argent Trophy
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 19, 265949 }, -- March on Quel'Danas Vanquisher's Aureate Trophy
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = HEROIC_PRE_DIFF,
				{ 14, 246590, "mount" }, -- Ashes of Belo'ren
				{ 20, 266885 }, -- March on Quel'Danas Vanquisher's Gleaming Trophy
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}

data["WorldBossesMidnight"] = {
	name = AL["World Bosses"],
	ContentType = RAID_CONTENT,
	items = {
		{ -- Lu'ashal
			EncounterJournalID = 2827,
			[NORMAL_RAID_DIFF] = {
				{ 1, 250451 }, -- Dawncrazed Beast Cleaver
				{ 2, 250453 }, -- Scepter of the Unbound Light
				{ 3, 250447 }, -- Radiant Eversong Scepter
				{ 4, 250459 }, -- Bramblestalker's Feathered Cowl
				{ 5, 250458 }, -- Host Commander's Casque
				{ 6, 250456 }, -- Wretched Scholar's Gilded Robe
				{ 7, 250457 }, -- Devouring Outrider's Chausses
				{ 8, 250462 }, -- Forgotten Farstrider's Insignia
			},
		},
		{ -- Thorm'belan
			EncounterJournalID = 2829,
			[NORMAL_RAID_DIFF] = {
				{ 1, 250455 }, -- Beastly Blossombarb
				{ 2, 250452 }, -- Blooming Thornblade
				{ 3, 250449 }, -- Skulking Nettledirk
				{ 4, 250459 }, -- Bramblestalker's Feathered Cowl
				{ 5, 250458 }, -- Host Commander's Casque
				{ 6, 250456 }, -- Wretched Scholar's Gilded Robe
				{ 7, 250457 }, -- Devouring Outrider's Chausses
				{ 8, 250462 }, -- Forgotten Farstrider's Insignia
			},
		},
		{ -- Predaxas
			EncounterJournalID = 2828,
			[NORMAL_RAID_DIFF] = {
				{ 1, 250454 }, -- Devouring Vanguard's Soulcleaver
				{ 2, 250448 }, -- Voidbender's Spire
				{ 3, 250460 }, -- Encroaching Shadow Signet
				{ 4, 250459 }, -- Bramblestalker's Feathered Cowl
				{ 5, 250458 }, -- Host Commander's Casque
				{ 6, 250456 }, -- Wretched Scholar's Gilded Robe
				{ 7, 250457 }, -- Devouring Outrider's Chausses
				{ 8, 250462 }, -- Forgotten Farstrider's Insignia
			},
		},
		{ -- Cragpine
			EncounterJournalID = 2782,
			[NORMAL_RAID_DIFF] = {
				{ 1, 250450 }, -- Forest Sentinel's Savage Longbow
				{ 2, 250446 }, -- Cragtender Bulwark
				{ 3, 250461 }, -- Chain of the Ancient Watcher
				{ 4, 250459 }, -- Bramblestalker's Feathered Cowl
				{ 5, 250458 }, -- Host Commander's Casque
				{ 6, 250456 }, -- Wretched Scholar's Gilded Robe
				{ 7, 250457 }, -- Devouring Outrider's Chausses
				{ 8, 250462 }, -- Forgotten Farstrider's Insignia
			},
		},
	}
}
