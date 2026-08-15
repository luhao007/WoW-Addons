-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local GetAchievementInfo = GetAchievementInfo
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 7)

AtlasLoot:RegisterModules(addonname)

local AL = AtlasLoot.Locales

local ADD_SCALING = {
	Item = {
		addDifficultyBonus = true,
	}
}

local RF_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY3, "LFRWithPreset", {
	Item = {
		--item1bonus = "LegionLFR",
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 17)
local NORMAL_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "n", {
	Item = {
		item1bonus = "Scaling",
		addDifficultyBonus = true,
	},
}, 1)
local NORMAL_RAID_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "NormalRaidWithPreset", {
	Item = {
		--item1bonus = nil,
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 14)
local NORMAL_DUNGEON_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "DungeonWithPreset", {
	Item = {
		item1bonus = "Scaling",
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 1)
local HEROIC_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY2, "h", nil, 2)
local HEROIC_DUNGEON_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY2, "HeroicDungeonWithPreset", {
	Item = {
		--item1bonus = "LegionHCDungeon",
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 2)
local MYTHICD_DUNGEON_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY6, "MythicDungeonWithPreset", {
	Item = {
		--item1bonus = "LegionMDungeon",
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 23)
local HEROIC_PRE_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY2, "HeroicWithPreset", {
	Item = {
		--item1bonus = "LegionHeroicRaid",
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 15)
local MYTHIC_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY6, "m", nil, 16)
local MYTHIC_PRE_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY6, "MyhticWithPreset", {
	Item = {
		--item1bonus = "LegionMythicRaid",
		item2bonus = "LegionMaxItemLvl",
		autoCompleteItem2 = true,
		addDifficultyBonus = true,
	},
}, 16)
local TIMEWALKING_DUNGEON_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY_TIMEWALKER, "timewalkingDungeonWithPreset", ADD_SCALING, 24)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local DUNGEON_CONTENT = data:AddContentType(DUNGEONS, ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(RAIDS, ATLASLOOT_RAID_COLOR)

-- Shared loot tables
local LEGION_DUNGEON_HERO_AC_TABLE = { --[Legion Dungeon Hero]
	name = select(2, GetAchievementInfo(11164)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 11164 },
		{ 2, 10781 }, { 17, 10784 },
		{ 3, 10788 }, { 18, 10796 },
		{ 4, 10799 }, { 19, 10802 },
		{ 5, 10805 }, { 20, 10808 },
	},
}

local LEGION_GLORY_OF_THE_HERO_AC_TABLE = { --[Glory of the Legion Hero]
	name = select(2, GetAchievementInfo(11163)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 11163, "mount225765" },
		{ 2, 10456 }, { 17, 10457 },
		{ 3, 10458 }, { 18, 10766 },
		{ 4, 10769 }, { 19, 10996 },
		{ 5, 10875 }, { 20, 10544 },
		{ 6, 10542 }, { 21, 10543 },
		{ 7, 10554 }, { 22, 10553 },
		{ 8, 10679 }, { 23, 10680 },
		{ 9,  10707 }, { 24, 10709 },
		{ 10, 10710 }, { 25, 10711 },
		{ 11, 10413 }, { 26, 10411 },
		{ 12, 10412 }, { 27, 10776 },
		{ 13, 10775 }, { 28, 10773 },
		{ 14, 10610 }, { 29, 10611 },
	},
}

local LEGION_RAID1_AC_TABLE = { -- [Glory of the Legion Raider]
	name = select(2, GetAchievementInfo(11180)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 11180, "mount193007" },
		{ 2, 10555 }, { 17, 10771 },
		{ 3, 10753 }, { 18, 10830 },
		{ 4, 10663 }, { 19, 10772 },
		{ 5, 10755 }, { 20, 10678 },
		{ 6, 10697 }, { 21, 10742 },
		{ 7, 10817 }, { 22, 10851 },
		{ 8, 10754 }, { 23, 10704 },
		{ 9,  10575 }, { 24, 10699 },
		{ 10, 10696 },
	},
}

local LEGION_TRIAL_OF_VALOR_AC_TABLE = { -- Heroic: Trial of Valor
	name = select(2, GetAchievementInfo(11426)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 11426 },
	}
}

local LEGION_GLORY_TOMB_RAIDER_AC_TABLE = { -- Glory of the Tomb Raider
	name = select(2, GetAchievementInfo(11763)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1,  11763 }, -- Glory of the Tomb Raider
		{ 2,  11724 }, -- Fel Turkey!
		{ 3,  11696 }, -- Grin and Bear It
		{ 4,  11683 }, -- Bingo!
		{ 5,  11676 }, -- Five Course Seafood Buffet
		{ 17, 11675 }, -- Sky Walker
		{ 18, 11674 }, -- Great Soul, Great Purpose
		{ 19, 11773 }, -- Wax On, Wax Off
		{ 20, 11770 }, -- Dark Souls
		{ 21, 11699 }, -- Grand Fin-ale
	}
}


local LEGION_WORLD_BOSS_AC_TABLE = {
	name = select(2, GetAchievementInfo(11160)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 11160 }, -- Unleashed Monstrosities
	}
}

local LEGION_WORLD_BOSS_AC_TABLE2 = {
	name = select(2, GetAchievementInfo(11786)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 11786 }, -- Terrors of the Shore
	}
}

-- /////////////////////////////////
-- Instance
-- /////////////////////////////////
data["TheArcway"] = {
	EncounterJournalID = 726,
	MapID = 749,
	AtlasMapID = "TheArcway",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Ivanyr
			EncounterJournalID = 1497,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  134467 }, -- Nether Mindsnappers
				{ 2,  134501 }, -- Crackling Overcharge Chestguard
				{ 3,  137398 }, -- Portable Manacracker
				{ 4,  134280 }, -- Swordsinger's Wristguards
				{ 5,  134269 }, -- Arcane Defender's Belt
				{ 6,  134421 }, -- Ink-Smudged Handwraps
				{ 7,  137397 }, -- Tunnel Trudger Footguards
				{ 8,  134309 }, -- Manawracker Shoulders
				{ 9,  134298 }, -- Ley Dragoon's Stompers
				{ 10, 134526 }, -- Gnawed Thumb Ring
				{ 12, 137399 }, -- Ivanyr's Hunger
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Corstilax
			EncounterJournalID = 1498,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  134424 }, -- Collar of Enclosure
				{ 2,  134488 }, -- Stabilized Energy Pendant
				{ 3,  137400 }, -- Coagulated Nightwell Residue
				{ 4,  134453 }, -- Spaulders of Aberrant Inhibition
				{ 5,  134522 }, -- Detention Wristclamps
				{ 6,  134463 }, -- Decontaminated Chain Tunic
				{ 7,  134402 }, -- Cape of Rigid Order
				{ 9,  137403 }, -- Quarantine Catalyst
				{ 10, 137402 }, -- Cleansing Isotope
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --General Xakal
			EncounterJournalID = 1499,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  134396 }, -- Netherwhisper Slippers
				{ 2,  134533 }, -- Ring of Looming Menace
				{ 3,  134387 }, -- Mardum Chain Helm
				{ 4,  134449 }, -- Bloodclaw Leggings
				{ 5,  137406 }, -- Terrorbound Nexus
				{ 6,  134359 }, -- Portalguard Legplates
				{ 7,  137404 }, -- Legwraps of Reverberating Shadows
				{ 8,  134373 }, -- Felbat Leather Vest
				{ 9,  137405 }, -- Remorseless Chain Armbands
				{ 10, 134509 }, -- Fists of the Legion
				{ 12, 137407 }, -- Sealed Fel Fissure
				{ 13, 137408 }, -- Xakal's Determination
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Nal'tira
			EncounterJournalID = 1500,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  137409 }, -- Manafang Waistguard
				{ 2,  137410 }, -- Greathelm of Barbed Chelicerae
				{ 3,  133766 }, -- Nether Anti-Toxin
				{ 4,  134472 }, -- Arcane Exterminator's Shoulderguards
				{ 5,  134410 }, -- Cloak of Mana-Spun Silk
				{ 6,  134540 }, -- Ring of Twisted Webbing
				{ 7,  134435 }, -- Tunnel Fiend Bracers
				{ 9,  137411 }, -- Nal'tira's Venom Gland
				{ 10, 137412 }, -- Fistful of Eyes
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Advisor Vandros
			EncounterJournalID = 1501,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  137417 }, -- Treads of Fates Entwined
				{ 2,  134304 }, -- Manawracker Crown
				{ 3,  134286 }, -- Swordsinger's Shoulders
				{ 4,  134518 }, -- Frozen Pendulum Shoulderguards
				{ 5,  134475 }, -- Mute Erasure Legguards
				{ 6,  134267 }, -- Arcane Defender's Breastplate
				{ 7,  137419 }, -- Chrono Shard
				{ 8,  137413 }, -- Time-Breached Waistband
				{ 9,  134413 }, -- Fluxflow Robes
				{ 10, 134297 }, -- Ley Dragoon's Gloves
				{ 11, 134444 }, -- Mana-Lanced Gloves
				{ 12, 137416 }, -- Chain of Causal Links
				{ 13, 137418 }, -- Erratically Ticking Talisman
				{ 14, 137415 }, -- Gaze of Fleeting Hours
				{ 16, 137421 }, -- Accelerating Torrent
				{ 17, 137420 }, -- Split Second
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

data["AssaultOnVioletHold"] = {
	EncounterJournalID = 777,
	MapID = 732,
	AtlasMapID = "AssaultonVioletHold",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Festerface
			EncounterJournalID = 1693,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137437 }, -- Slimeflow Breastplate
				{ 2,  134454 }, -- Spaulders of Unstable Experiments
				{ 3,  137479 }, -- Cowl of Promising News
				{ 4,  137436 }, -- Pustulous Girdle
				{ 5,  137438 }, -- Band of Decaying Rubies
				{ 6,  137439 }, -- Tiny Oozeling in a Jar
				{ 7,  134414 }, -- Fetid Gutcover Apron
				{ 8,  137434 }, -- Split-Vein Bracers
				{ 9,  137435 }, -- Blightbile Waistband
				{ 10, 134468 }, -- Gloves of Flesh-Shaping
				{ 12, 137465 }, -- Festerface's Rotted Gut
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 125, "ac9023" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --Shivermaw
			EncounterJournalID = 1694,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134411 }, -- Iceblood Shroud
				{ 2,  134445 }, -- Frostcarver Grips
				{ 3,  134434 }, -- Cinch of Freezing Fog
				{ 4,  137440 }, -- Shivermaw's Jawbone
				{ 5,  134476 }, -- Wyrmwing Kilt
				{ 6,  134523 }, -- Etched Dragonbone Warboots
				{ 7,  134493 }, -- Band of Crystalline Bone
				{ 9,  137466 }, -- Frostwyrm Heart
				{ 10, 137468 }, -- Bonecrushing Hail
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --Blood Princess Thalena
			EncounterJournalID = 1702,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134422 }, -- Satin Throatclutchers
				{ 2,  137460 }, -- Constricting Chain Harness
				{ 3,  137462 }, -- Jewel of Insatiable Desire
				{ 4,  134404 }, -- Stole of Malefic Repose
				{ 5,  134457 }, -- Sash of the Twilight Princess
				{ 6,  137461 }, -- Breathless Choker
				{ 7,  134516 }, -- Tassets of Ravenous Euphoria
				{ 9,  137471 }, -- Drop of True Blood
				{ 10, 137478 }, -- Reflection of Sorrow
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 120, "ac9551" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --Mindflayer Kaahrj
			EncounterJournalID = 1686,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 137433 }, -- Obelisk of the Void
				{ 2, 134479 }, -- Mantle of the Abyss
				{ 3, 134439 }, -- Tunic of the Underworld
				{ 4, 137431 }, -- Despair-Bound Armplates
				{ 5, 134498 }, -- Chain of a Hundred Maws
				{ 6, 137432 }, -- Ring of Mind-Shielding
				{ 7, 134425 }, -- Hood of Ancient Evil
				{ 9, 137464 }, -- Tendril of Darkness
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 217, "ac10080" },
			},
		},
		{ --Millificent Manastorm
			EncounterJournalID = 1688,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137441 }, -- Millificent's Turboview Specs
				{ 2,  137443 }, -- Mithril Melon Vault
				{ 3,  137445 }, -- Insurmountable Skullfortress
				{ 4,  137444 }, -- Plasma-Drilled Steel Toes
				{ 5,  134502 }, -- Exo-Mesh Carpalform Armplates Mk. VII
				{ 6,  134534 }, -- Dingy Wedding Band
				{ 7,  137446 }, -- Elementium Bomb Squirrel Generator
				{ 8,  134430 }, -- Magnificent Aeroglide Shoulderpads
				{ 9,  134450 }, -- D-Lux Slipstream Pants
				{ 10, 137442 }, -- Compact Trifold Wristbands
				{ 12, 137469 }, -- Thorium-Plated Egg
				{ 13, 137470 }, -- Rocket Chicken Rocket Fuel
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 217, "ac10080" },
			},
		},
		{ --Anub'esset
			EncounterJournalID = 1696,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137424 }, -- Burrow-Dweller Leggings
				{ 2,  137428 }, -- Chestguard of Ravaged Chitin
				{ 3,  137430 }, -- Impenetrable Nerubian Husk
				{ 4,  134489 }, -- Seal of Malicious Deceit
				{ 5,  137425 }, -- Cryptwalker Bracers
				{ 6,  137427 }, -- Corpse Feast Headwrap
				{ 7,  137429 }, -- Serrated Mandible Grips
				{ 8,  134506 }, -- Legplates of the Swarm
				{ 9,  134418 }, -- Scarab-Caller Grips
				{ 10, 134485 }, -- Cuffs of the Nerubian Empire
				{ 12, 137463 }, -- Fealty of Nerub
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 217, "ac10080" },
			},
		},
		{ --Sael'orn
			EncounterJournalID = 1697,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137452 }, -- Thrumming Gossamer
				{ 2,  134527 }, -- Loop of Eightfold Eyes
				{ 3,  137449 }, -- Wicked Broodmother's Chestguard
				{ 4,  134357 }, -- Portalguard Waistplate
				{ 5,  137450 }, -- Leggings of Acidic Venom
				{ 6,  134482 }, -- Cinch of Frozen Fear
				{ 7,  134393 }, -- Netherwhisper Gloves
				{ 8,  134521 }, -- Dread-Stricken Shoulderguards
				{ 9,  137447 }, -- Lair Matron's Spaulders
				{ 10, 137451 }, -- Vision of the Spider Queen
				{ 11, 134541 }, -- Tightweb Choker
				{ 12, 134390 }, -- Mardum Chain Vest
				{ 13, 134371 }, -- Felbat Leather Gloves
				{ 14, 137448 }, -- Toxin-Stitched Footwraps
				{ 15, 134436 }, -- Armbands of Slaughter
				{ 16, 137473 }, -- Phase Spider Mandible
				{ 17, 137474 }, -- Loyalty to the Matriarch
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				-- { 217, "ac10080" },
			},
		},
		{ --Fel Lord Betrug
			EncounterJournalID = 1711,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137456 }, -- Belt of Mighty Links
				{ 2,  134360 }, -- Portalguard Shoulders
				{ 3,  134395 }, -- Netherwhisper Robes
				{ 4,  134368 }, -- Felbat Leather Wristwraps
				{ 5,  134446 }, -- Vigilant Bondbreaker Headdress
				{ 6,  137457 }, -- Chestplate of the Obstinate Conqueror
				{ 7,  134466 }, -- Begrudging Trudgers
				{ 8,  137454 }, -- Footguards of Stayed Execution
				{ 9,  134389 }, -- Mardum Chain Pauldrons
				{ 10, 137455 }, -- Spaulders of Tense Sinew
				{ 11, 137459 }, -- Chaos Talisman
				{ 12, 137458 }, -- Chaos-Forged Necklace
				{ 13, 134407 }, -- Rugged Marauder Cape
				{ 14, 134515 }, -- Greaves of Ruinous Dominion
				{ 15, 137453 }, -- Legwraps of Rampant Turmoil
				{ 16, 137472 }, -- Betrug's Vigor
				{ 17, 137476 }, -- Brand of Tyranny
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 217, "ac10080" },
			},
		},
		--[[		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
]]
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["BlackRookHold"] = {
	EncounterJournalID = 740,
	MapID = 751,
	AtlasMapID = "BlackRookHoldA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --The Amalgam of Souls
			EncounterJournalID = 1518,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134437 }, -- Harrowing Soulspun Bracers
				{ 2,  134469 }, -- Midnight Reaper Handwraps
				{ 3,  139241 }, -- Rook Footman's Warboots
				{ 4,  139245 }, -- Shadow Archer's Spaulders
				{ 5,  136714 }, -- Amalgam's Seventh Spine
				{ 6,  134442 }, -- Tooled Rivermoor Boots
				{ 7,  136977 }, -- Shadowfeather Shawl
				{ 8,  139246 }, -- Ravencourt Formal Robes
				{ 9,  139242 }, -- Raven's Veil Gloves
				{ 10, 136976 }, -- Etheldrin's Breastplate
				{ 12, 136719 }, -- Curdled Soul Essence
				{ 13, 137270 }, -- Howling Echoes
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134437 }, -- Harrowing Soulspun Bracers
				{ 2,  134469 }, -- Midnight Reaper Handwraps
				{ 3,  139241 }, -- Rook Footman's Warboots
				{ 4,  139245 }, -- Shadow Archer's Spaulders
				{ 5,  136714 }, -- Amalgam's Seventh Spine
				{ 6,  134442 }, -- Tooled Rivermoor Boots
				{ 7,  136977 }, -- Shadowfeather Shawl
				{ 8,  139246 }, -- Ravencourt Formal Robes
				{ 9,  139242 }, -- Raven's Veil Gloves
				{ 10, 136976 }, -- Etheldrin's Breastplate
			},
		},
		{ --Illysanna Ravencrest
			EncounterJournalID = 1653,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  136978 }, -- Ember of Nullification
				{ 2,  134490 }, -- Ring of Contempt
				{ 3,  134419 }, -- Slippers of Heedless Sacrifice
				{ 4,  134440 }, -- Soulstarve Hood
				{ 5,  134412 }, -- Cloak of Unwavering Loyalty
				{ 6,  134519 }, -- Ravencrest Bonecrush Gauntlets
				{ 7,  136724 }, -- Soul-Torn Fury Cinch
				{ 9,  136720 }, -- Snapped Emerald Pendant
				{ 10, 136769 }, -- Ravencrest's Wrath
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 116, "ac8993" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 136978 }, -- Ember of Nullification
				{ 2, 134490 }, -- Ring of Contempt
				{ 3, 134419 }, -- Slippers of Heedless Sacrifice
				{ 4, 134440 }, -- Soulstarve Hood
				{ 5, 134412 }, -- Cloak of Unwavering Loyalty
				{ 6, 134519 }, -- Ravencrest Bonecrush Gauntlets
				{ 7, 136724 }, -- Soul-Torn Fury Cinch
			},
		},
		{ --Smashspite the Hateful
			EncounterJournalID = 1664,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134362 }, -- Portalguard Wristguard
				{ 2,  134507 }, -- Leadfoot Earthshakers
				{ 3,  134391 }, -- Netherwhisper Cinch
				{ 4,  134528 }, -- Band of Callous Dominance
				{ 5,  134483 }, -- Fel-Hammered Greaves
				{ 6,  136979 }, -- Shorn Batbrood Cuffs
				{ 7,  136715 }, -- Spiked Counterweight
				{ 8,  134373 }, -- Felbat Leather Vest
				{ 9,  134390 }, -- Mardum Chain Vest
				{ 10, 134426 }, -- Collar of Raking Claws
				{ 12, 136721 }, -- Mo'arg Eyepatch
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134362 }, -- Portalguard Wristguard
				{ 2,  134507 }, -- Leadfoot Earthshakers
				{ 3,  134391 }, -- Netherwhisper Cinch
				{ 4,  134528 }, -- Band of Callous Dominance
				{ 5,  134483 }, -- Fel-Hammered Greaves
				{ 6,  136979 }, -- Shorn Batbrood Cuffs
				{ 7,  136715 }, -- Spiked Counterweight
				{ 8,  134373 }, -- Felbat Leather Vest
				{ 9,  134390 }, -- Mardum Chain Vest
				{ 10, 134426 }, -- Collar of Raking Claws
			},
		},
		{ --Lord Kur'talos Ravencrest
			EncounterJournalID = 1672,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  136770 }, -- Drape of the Raven Lord
				{ 2,  136716 }, -- Caged Horror
				{ 3,  139243 }, -- Raven's Veil Belt
				{ 4,  139247 }, -- Ravencourt Formal Mantle
				{ 5,  134384 }, -- Mardum Chain Wristclamp
				{ 6,  134431 }, -- Latosius's Blasting Gloves
				{ 7,  139240 }, -- Rook Footman's Legplates
				{ 8,  139244 }, -- Shadow Archer's Helm
				{ 9,  134358 }, -- Portalguard Helm
				{ 10, 134370 }, -- Felbat Leather Leggings
				{ 11, 134510 }, -- Pauldrons of Ancient Command
				{ 12, 134394 }, -- Netherwhisper Leggings
				{ 13, 134477 }, -- Ravencrest's Unerring Striders
				{ 14, 134499 }, -- Raven Filigree Pendant
				{ 15, 134451 }, -- Legguards of Endless Horrors
				{ 16, 137272 }, -- Cruelty of Dantalionax
				{ 17, 136717 }, -- Absolved Ravencrest Brooch
				{ 18, 136718 }, -- Mark of Varo'then
				--{ 220, "ac9037" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 212, "113682:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core of Flame
				--{ 221, "ac9046" },
				--{ 222, "ac9005" },
				--{ 223, "ac9008" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 221, "ac10076" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  136770 }, -- Drape of the Raven Lord
				{ 2,  136716 }, -- Caged Horror
				{ 3,  139243 }, -- Raven's Veil Belt
				{ 4,  139247 }, -- Ravencourt Formal Mantle
				{ 5,  134384 }, -- Mardum Chain Wristclamp
				{ 6,  134431 }, -- Latosius's Blasting Gloves
				{ 7,  139240 }, -- Rook Footman's Legplates
				{ 8,  139244 }, -- Shadow Archer's Helm
				{ 9,  134358 }, -- Portalguard Helm
				{ 10, 134370 }, -- Felbat Leather Leggings
				{ 11, 134510 }, -- Pauldrons of Ancient Command
				{ 12, 134394 }, -- Netherwhisper Leggings
				{ 13, 134477 }, -- Ravencrest's Unerring Striders
				{ 14, 134499 }, -- Raven Filigree Pendant
				{ 15, 134451 }, -- Legguards of Endless Horrors
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

-- Cathedral of Eternal Night
data["CathedralofEternalNight"] = {
	EncounterJournalID = 900,
	MapID = 845,
	ItemBaseLvl = 174,
	AtlasMapID = "CathedralofEternalNightA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Agronox
			EncounterJournalID = 1905,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  144469 }, -- Caretaker's Budding Mantle
				{ 2,  144491 }, -- Choking Vine Bindings
				{ 3,  144490 }, -- Corruption-Fused Stompers
				{ 4,  144468 }, -- Felpruner's Shroud
				{ 5,  144470 }, -- Grovetender's Handwraps
				{ 6,  144497 }, -- Petrified Husk Girdle
				{ 7,  144477 }, -- Splinters of Agronax
				{ 8,  144483 }, -- Spore-Coated Vest
				{ 9,  144498 }, -- Vambraces of Fel Crust
				{ 11, 144458 }, -- Agronax's Unsullied Heartwood
				{ 12, 144459 }, -- Knot of Fel
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Thrashbite the Scornful
			EncounterJournalID = 1906,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  144492 }, -- Chain-Draped Gauntlets
				{ 2,  144482 }, -- Fel-Oiled Infernal Machine
				{ 3,  144493 }, -- Link-Lashed Spaulders
				{ 4,  144479 }, -- Master Thrasher's Lockcollar
				{ 5,  144485 }, -- Mo'arg Heavyweight's Wristwraps
				{ 6,  144471 }, -- Pulverizing Felsoles
				{ 7,  144484 }, -- Tattered Scornful Leggings
				{ 8,  144499 }, -- Tenderized Breastplate
				{ 9,  144472 }, -- Thrashbite's Cummerbund
				{ 11, 144461 }, -- Thrashbite's Spite
				{ 12, 144462 }, -- Fel-Tempered Link
				{ 13, 144460 }, -- Fury of the Scorned
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Domatrax
			EncounterJournalID = 1904,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  144496 }, -- Burning Chain Waistguard
				{ 2,  144476 }, -- Cloak of the Unending Assault
				{ 3,  144475 }, -- Dark Mistress' Cuffs
				{ 4,  144495 }, -- Domatrax's Chain Hauberk
				{ 5,  144488 }, -- Feaster Hide Gloves
				{ 6,  144503 }, -- Helm of Domatrax
				{ 7,  144481 }, -- Ring of Fel Domination
				{ 8,  144474 }, -- Sheer Felwoven Hosiery
				{ 9,  144489 }, -- Shoulderguards of Legion Domination
				{ 10, 144500 }, -- Two-Toed Thrashstompers
				{ 12, 144467 }, -- Vial of Eternal Moon
				{ 13, 144466 }, -- Gore-Flecked Feaster Fang
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Mephistroth
			EncounterJournalID = 1878,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  144478 }, -- Band of Dark Solitude
				{ 2,  144486 }, -- Cerulean Shadowfade Belt
				{ 3,  144501 }, -- Dread Commander's Pauldrons
				{ 4,  144480 }, -- Dreadstone of Endless Shadows
				{ 5,  144494 }, -- Imposing Dreadsoul Headgear
				{ 6,  144473 }, -- Nathrezim Acolyte's Robes
				{ 7,  144502 }, -- Shadowed Grips of the Nathrezim
				{ 8,  144487 }, -- Treads of Creeping Shadows
				{ 10, 144465 }, -- Essence of the Legion Tempest
				{ 11, 144464 }, -- Mephistroth's Nail
				{ 12, 144463 }, -- Shard of Kaldorei Stained Glass
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	},
}

data["CourtOfStars"] = {
	EncounterJournalID = 800,
	MapID = 761,
	AtlasMapID = "CourtofStarsA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Patrol Captain Gerdo
			EncounterJournalID = 1718,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  137482 }, -- Duskwatch Guard's Boots
				{ 2,  137484 }, -- Flask of the Solemn Night
				{ 3,  134308 }, -- Manawracker Sandals
				{ 4,  134280 }, -- Swordsinger's Wristguards
				{ 5,  137483 }, -- Cape of the Duskwatch
				{ 6,  134480 }, -- Epaulets of Deceitful Intent
				{ 7,  134296 }, -- Ley Dragoon's Wristbraces
				{ 8,  134268 }, -- Arcane Defender's Gauntlets
				{ 9,  137480 }, -- Guileful Intruder Handguards
				{ 10, 134415 }, -- Arcanist's Resonant Robes
				{ 12, 137490 }, -- Self-Forging Credentials
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  137482 }, -- Duskwatch Guard's Boots
				{ 2,  137484 }, -- Flask of the Solemn Night
				{ 3,  134308 }, -- Manawracker Sandals
				{ 4,  134280 }, -- Swordsinger's Wristguards
				{ 5,  137483 }, -- Cape of the Duskwatch
				{ 6,  134480 }, -- Epaulets of Deceitful Intent
				{ 7,  134296 }, -- Ley Dragoon's Wristbraces
				{ 8,  134268 }, -- Arcane Defender's Gauntlets
				{ 9,  137480 }, -- Guileful Intruder Handguards
				{ 10, 134415 }, -- Arcanist's Resonant Robes
			},
		},
		{ --Talixae Flamewreath
			EncounterJournalID = 1719,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  134392 }, -- Netherwhisper Hood
				{ 2,  134529 }, -- Chain of Scorched Bones
				{ 3,  134503 }, -- Inferno Breastplate
				{ 4,  134385 }, -- Mardum Chain Gloves
				{ 5,  134374 }, -- Felbat Leather Pauldrons
				{ 6,  137485 }, -- Infernal Writ
				{ 7,  134460 }, -- Fevermelt Legguards
				{ 8,  137488 }, -- Cord of Wicked Pyromania
				{ 9,  134360 }, -- Portalguard Shoulders
				{ 10, 134473 }, -- Collar of Fiery Allegiance
				{ 12, 137492 }, -- Flamewreath Spark
				{ 13, 137491 }, -- Felsworn Covenant
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134392 }, -- Netherwhisper Hood
				{ 2,  134529 }, -- Chain of Scorched Bones
				{ 3,  134503 }, -- Inferno Breastplate
				{ 4,  134385 }, -- Mardum Chain Gloves
				{ 5,  134374 }, -- Felbat Leather Pauldrons
				{ 6,  137485 }, -- Infernal Writ
				{ 7,  134460 }, -- Fevermelt Legguards
				{ 8,  137488 }, -- Cord of Wicked Pyromania
				{ 9,  134360 }, -- Portalguard Shoulders
				{ 10, 134473 }, -- Collar of Fiery Allegiance
			},
		},
		{ --Advisor Melandrus
			EncounterJournalID = 1720,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  137487 }, -- Strand of the Stars
				{ 2,  134298 }, -- Ley Dragoon's Stompers
				{ 3,  137499 }, -- Roaring Breeze Waistguard
				{ 4,  134310 }, -- Manawracker Bindings
				{ 5,  134287 }, -- Swordsinger's Belt
				{ 6,  137496 }, -- Suramar Magistrate Leggings
				{ 7,  134447 }, -- Veil of Unseen Strikes
				{ 8,  137489 }, -- Arcane-Bound Gale Chain
				{ 9,  137497 }, -- Footpads of the Swift Balestra
				{ 10, 134432 }, -- Amice of the Unfurling Tempest
				{ 11, 137486 }, -- Windscar Whetstone
				{ 12, 137498 }, -- Luminous Bladesworn Hauberk
				{ 13, 134542 }, -- Jeweled Signet of Melandrus
				{ 14, 134271 }, -- Arcane Defender's Pants
				{ 15, 134513 }, -- Helmet of Reverent Loyalty
				{ 16, 137495 }, -- Crux of Blind Faith
				{ 17, 137493 }, -- Edge of the First Blade
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  137487 }, -- Strand of the Stars
				{ 2,  134298 }, -- Ley Dragoon's Stompers
				{ 3,  137499 }, -- Roaring Breeze Waistguard
				{ 4,  134310 }, -- Manawracker Bindings
				{ 5,  134287 }, -- Swordsinger's Belt
				{ 6,  137496 }, -- Suramar Magistrate Leggings
				{ 7,  134447 }, -- Veil of Unseen Strikes
				{ 8,  137489 }, -- Arcane-Bound Gale Chain
				{ 9,  137497 }, -- Footpads of the Swift Balestra
				{ 10, 134432 }, -- Amice of the Unfurling Tempest
				{ 11, 137486 }, -- Windscar Whetstone
				{ 12, 137498 }, -- Luminous Bladesworn Hauberk
				{ 13, 134542 }, -- Jeweled Signet of Melandrus
				{ 14, 134271 }, -- Arcane Defender's Pants
				{ 15, 134513 }, -- Helmet of Reverent Loyalty
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["DarkheartThicket"] = {
	EncounterJournalID = 762,
	MapID = 733,
	AtlasMapID = "DarkheartThicket",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Archdruid Glaidalis
			EncounterJournalID = 1654,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134520 }, -- Thornscar Wristguards
				{ 2,  134487 }, -- Arch-Druid's Tainted Seal
				{ 3,  139086 }, -- Night Dreamer Crest
				{ 4,  139058 }, -- Nightsfall Helmet
				{ 5,  137301 }, -- Corrupted Starlight
				{ 6,  139077 }, -- Bramblemail Belt
				{ 7,  134429 }, -- Grove Darkener's Treads
				{ 8,  134423 }, -- Poisonroot Belt
				{ 9,  139071 }, -- Tranquil Bough Vest
				{ 10, 137300 }, -- Gloves of Wretched Lesions
				{ 12, 137303 }, -- Touch of Nightfall
				{ 13, 137302 }, -- Misshapen Abomination Heart
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 130, "ac9083" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134520 }, -- Thornscar Wristguards
				{ 2,  134487 }, -- Arch-Druid's Tainted Seal
				{ 3,  139086 }, -- Night Dreamer Crest
				{ 4,  139058 }, -- Nightsfall Helmet
				{ 5,  137301 }, -- Corrupted Starlight
				{ 6,  139077 }, -- Bramblemail Belt
				{ 7,  134429 }, -- Grove Darkener's Treads
				{ 8,  134423 }, -- Poisonroot Belt
				{ 9,  139071 }, -- Tranquil Bough Vest
				{ 10, 137300 }, -- Gloves of Wretched Lesions
			},
		},
		{ --Oakheart
			EncounterJournalID = 1655,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134452 }, -- Epaulets of Dessicated Foliage
				{ 2,  137304 }, -- Oakheart's Trunkwarmers
				{ 3,  137306 }, -- Oakheart's Gnarled Root
				{ 4,  121325 }, -- Terrorweave Gloves
				{ 5,  137305 }, -- Blighted Grasp Bracers
				{ 6,  121319 }, -- Vilescale Helm
				{ 7,  121299 }, -- Dreadhide Girdle
				{ 8,  134531 }, -- Band of Twisted Bark
				{ 9,  121280 }, -- Wracksoul Legplates
				{ 10, 134500 }, -- Breastplate of Preservation
				{ 12, 137308 }, -- Clotted Sap of the Grove
				{ 13, 137307 }, -- Corrupted Knot
				--{ 216, "ac9038" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 217, "ac9047" },
				--{ 218, "ac9082" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 217, "ac10079" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134452 }, -- Epaulets of Dessicated Foliage
				{ 2,  137304 }, -- Oakheart's Trunkwarmers
				{ 3,  137306 }, -- Oakheart's Gnarled Root
				{ 4,  121325 }, -- Terrorweave Gloves
				{ 5,  137305 }, -- Blighted Grasp Bracers
				{ 6,  121319 }, -- Vilescale Helm
				{ 7,  121299 }, -- Dreadhide Girdle
				{ 8,  134531 }, -- Band of Twisted Bark
				{ 9,  121280 }, -- Wracksoul Legplates
				{ 10, 134500 }, -- Breastplate of Preservation
			},
		},
		{ --Dresaron
			EncounterJournalID = 1656,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  139089 }, -- Night Dreamer Robe
				{ 2,  137310 }, -- Greatbelt of Disruption
				{ 3,  139082 }, -- Bramblemail Greaves
				{ 4,  134464 }, -- Whelp Handler's Lined Boots
				{ 5,  139056 }, -- Nightsfall Gauntlets
				{ 6,  137312 }, -- Nightmare Egg Shell
				{ 7,  137309 }, -- Slipstream Shoulderpads
				{ 8,  137311 }, -- Chain of the Green Flight
				{ 9,  139070 }, -- Tranquil Bough Hood
				{ 10, 134461 }, -- Thermal Bindings
				{ 12, 137313 }, -- Roiling Fog
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  139089 }, -- Night Dreamer Robe
				{ 2,  137310 }, -- Greatbelt of Disruption
				{ 3,  139082 }, -- Bramblemail Greaves
				{ 4,  134464 }, -- Whelp Handler's Lined Boots
				{ 5,  139056 }, -- Nightsfall Gauntlets
				{ 6,  137312 }, -- Nightmare Egg Shell
				{ 7,  137309 }, -- Slipstream Shoulderpads
				{ 8,  137311 }, -- Chain of the Green Flight
				{ 9,  139070 }, -- Tranquil Bough Hood
				{ 10, 134461 }, -- Thermal Bindings
			},
		},
		{ --Shade of Xavius
			EncounterJournalID = 1657,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  121316 }, -- Vilescale Bracers
				{ 2,  134504 }, -- Curserunner Soulcrushers
				{ 3,  121293 }, -- Dreadhide Boots
				{ 4,  121326 }, -- Terrorweave Leggings
				{ 5,  137314 }, -- Wristbands of Cursed Torment
				{ 6,  137322 }, -- Mantle of the Resolute Champion
				{ 7,  121276 }, -- Wracksoul Chestplate
				{ 8,  137315 }, -- Writhing Heart of Darkness
				{ 9,  134405 }, -- Cloak of Fading Echoes
				{ 10, 134537 }, -- Signet of the Highborne Magi
				{ 11, 134448 }, -- Ashen Satyr Leggings
				{ 12, 137321 }, -- Burning Sky Pauldrons
				{ 13, 137320 }, -- Gloves of Vile Defiance
				{ 14, 137319 }, -- Paranoid Sprinters
				{ 15, 134462 }, -- Dream Bolstered Chestguard
				{ 16, 137317 }, -- Xavius' Mad Whispers
				{ 17, 137316 }, -- Torch of Shaladrassil
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  121316 }, -- Vilescale Bracers
				{ 2,  134504 }, -- Curserunner Soulcrushers
				{ 3,  121293 }, -- Dreadhide Boots
				{ 4,  121326 }, -- Terrorweave Leggings
				{ 5,  137314 }, -- Wristbands of Cursed Torment
				{ 6,  137322 }, -- Mantle of the Resolute Champion
				{ 7,  121276 }, -- Wracksoul Chestplate
				{ 8,  137315 }, -- Writhing Heart of Darkness
				{ 9,  134405 }, -- Cloak of Fading Echoes
				{ 10, 134537 }, -- Signet of the Highborne Magi
				{ 11, 134448 }, -- Ashen Satyr Leggings
				{ 12, 137321 }, -- Burning Sky Pauldrons
				{ 13, 137320 }, -- Gloves of Vile Defiance
				{ 14, 137319 }, -- Paranoid Sprinters
				{ 15, 134462 }, -- Dream Bolstered Chestguard
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["EyeOfAzshara"] = {
	EncounterJournalID = 716,
	MapID = 713,
	AtlasMapID = "EyeofAzshara",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Warlord Parjesh
			EncounterJournalID = 1480,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137362 }, -- Parjesh's Medallion
				{ 2,  134484 }, -- Crestrider Conduit Bracers
				{ 3,  134261 }, -- Seawitch Gloves
				{ 4,  134492 }, -- Hatecoil Commander's Amulet
				{ 5,  137361 }, -- Roaring Shellbreaker Greatbelt
				{ 6,  134441 }, -- Shellshock Footguards
				{ 7,  134251 }, -- Sea Stalker's Cinch
				{ 8,  134223 }, -- Coralplate Chestguard
				{ 9,  137360 }, -- Shoulderpads of Crashing Waves
				{ 10, 134240 }, -- Brinewashed Leather Cowl
				{ 12, 137363 }, -- Bloodied Spearhead
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 220, "ac9054" },
				--{ 221, "ac9026" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 220, "ac10084" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  137362 }, -- Parjesh's Medallion
				{ 2,  134484 }, -- Crestrider Conduit Bracers
				{ 3,  134261 }, -- Seawitch Gloves
				{ 4,  134492 }, -- Hatecoil Commander's Amulet
				{ 5,  137361 }, -- Roaring Shellbreaker Greatbelt
				{ 6,  134441 }, -- Shellshock Footguards
				{ 7,  134251 }, -- Sea Stalker's Cinch
				{ 8,  134223 }, -- Coralplate Chestguard
				{ 9,  137360 }, -- Shoulderpads of Crashing Waves
				{ 10, 134240 }, -- Brinewashed Leather Cowl
			},
		},
		{ --Lady Hatecoil
			EncounterJournalID = 1490,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137364 }, -- Crashing Oceantide Mantle
				{ 2,  134471 }, -- Helm of Endless Dunes
				{ 3,  134263 }, -- Seawitch Robes
				{ 4,  134505 }, -- Horizon Line Warboots
				{ 5,  134230 }, -- Coralplate Wristguard
				{ 6,  137367 }, -- Stormsinger Fulmination Charge
				{ 7,  134433 }, -- Cord of the Sea-Caller
				{ 8,  134253 }, -- Sea Stalker's Gloves
				{ 9,  134238 }, -- Brinewashed Leather Pants
				{ 10, 134525 }, -- Seal of the Nazjatar Empire
				{ 12, 137366 }, -- Gift of the Ocean Empress
				{ 13, 137365 }, -- Condensed Saltsea Globule
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 124, "ac9018" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  137364 }, -- Crashing Oceantide Mantle
				{ 2,  134471 }, -- Helm of Endless Dunes
				{ 3,  134263 }, -- Seawitch Robes
				{ 4,  134505 }, -- Horizon Line Warboots
				{ 5,  134230 }, -- Coralplate Wristguard
				{ 6,  137367 }, -- Stormsinger Fulmination Charge
				{ 7,  134433 }, -- Cord of the Sea-Caller
				{ 8,  134253 }, -- Sea Stalker's Gloves
				{ 9,  134238 }, -- Brinewashed Leather Pants
				{ 10, 134525 }, -- Seal of the Nazjatar Empire
			},
		},
		{ --King Deepbeard
			EncounterJournalID = 1491,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134514 }, -- Keelhauler Legplates
				{ 2,  134456 }, -- Taut Halyard Waistband
				{ 3,  137368 }, -- Breastplate of Ten Lashes
				{ 4,  134539 }, -- Braided Silver Ring
				{ 5,  134406 }, -- Mainsail Cloak
				{ 6,  137369 }, -- Giant Ornamental Pearl
				{ 7,  134428 }, -- Rising Ocean Legwraps
				{ 9,  137370 }, -- Heart of the Sea
				{ 10, 137371 }, -- Tumultuous Aftershock
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 134514 }, -- Keelhauler Legplates
				{ 2, 134456 }, -- Taut Halyard Waistband
				{ 3, 137368 }, -- Breastplate of Ten Lashes
				{ 4, 134539 }, -- Braided Silver Ring
				{ 5, 134406 }, -- Mainsail Cloak
				{ 6, 137369 }, -- Giant Ornamental Pearl
				{ 7, 134428 }, -- Rising Ocean Legwraps
			},
		},
		{ --Serpentrix
			EncounterJournalID = 1479,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137372 }, -- Wristbands of the Swirling Deeps
				{ 2,  134239 }, -- Brinewashed Leather Grips
				{ 3,  134256 }, -- Sea Stalker's Leggings
				{ 4,  134438 }, -- Tunic of the Pitiless Monstrosity
				{ 5,  134260 }, -- Seawitch Hood
				{ 6,  134508 }, -- Stormwake Handguards
				{ 7,  134465 }, -- Hydra Scale Sabatons
				{ 8,  137373 }, -- Tempered Egg of Serpentrix
				{ 9,  134228 }, -- Coralplate Pauldrons
				{ 11, 137377 }, -- Serpentrix's Guile
				{ 12, 137375 }, -- Blazing Hydra Flame Sac
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 120, "ac9025" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 137372 }, -- Wristbands of the Swirling Deeps
				{ 2, 134239 }, -- Brinewashed Leather Grips
				{ 3, 134256 }, -- Sea Stalker's Leggings
				{ 4, 134438 }, -- Tunic of the Pitiless Monstrosity
				{ 5, 134260 }, -- Seawitch Hood
				{ 6, 134508 }, -- Stormwake Handguards
				{ 7, 134465 }, -- Hydra Scale Sabatons
				{ 8, 137373 }, -- Tempered Egg of Serpentrix
				{ 9, 134228 }, -- Coralplate Pauldrons
			},
		},
		{ --Wrath of Azshara
			EncounterJournalID = 1492,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134497 }, -- Stormcharged Choker
				{ 2,  134259 }, -- Seawitch Cinch
				{ 3,  134237 }, -- Brinewashed Leather Boots
				{ 4,  134225 }, -- Coralplate Girdle
				{ 5,  137378 }, -- Bottled Hurricane
				{ 6,  134532 }, -- Band of Fused Coral
				{ 7,  134459 }, -- Cuffs of the Arcane Storm
				{ 8,  134417 }, -- Slippers of Martyrdom
				{ 9,  134478 }, -- Thundercrush Pauldrons
				{ 10, 134255 }, -- Sea Stalker's Hood
				{ 11, 134512 }, -- Casque of the Deep
				{ 13, 137381 }, -- Pact of Vengeful Service
				{ 14, 137379 }, -- Tempestbinder's Crystal
				{ 15, 137380 }, -- Rage of the Tides
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 220, "ac9054" },
				--{ 221, "ac9026" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 220, "ac10084" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134497 }, -- Stormcharged Choker
				{ 2,  134259 }, -- Seawitch Cinch
				{ 3,  134237 }, -- Brinewashed Leather Boots
				{ 4,  134225 }, -- Coralplate Girdle
				{ 5,  137378 }, -- Bottled Hurricane
				{ 6,  134532 }, -- Band of Fused Coral
				{ 7,  134459 }, -- Cuffs of the Arcane Storm
				{ 8,  134417 }, -- Slippers of Martyrdom
				{ 9,  134478 }, -- Thundercrush Pauldrons
				{ 10, 134255 }, -- Sea Stalker's Hood
				{ 11, 134512 }, -- Casque of the Deep
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["HallsOfValor"] = {
	EncounterJournalID = 721,
	MapID = 704,
	AtlasMapID = "HallsofValorA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Hymdall
			EncounterJournalID = 1485,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  133642 }, -- Horn of Valor
				{ 2,  134216 }, -- Bonespeaker Cowl
				{ 3,  136774 }, -- Cushioned Treads of Glory
				{ 4,  133628 }, -- Battleborne Sentinel Gauntlets
				{ 5,  134194 }, -- Biornskin Leggings
				{ 6,  134213 }, -- Tideskorn Mantle
				{ 7,  133621 }, -- Adorned Guardian's Bracers
				{ 8,  134179 }, -- Skoldiir Breastplate
				{ 9,  133805 }, -- Thundercaller's Chain
				{ 11, 133763 }, -- Key to the Halls
				{ 12, 136973 }, -- Burden of Vigilance
				--{ 221, "114780:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pure Solium Band
				--{ 223, "ac8843" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 224, "ac8844" },
				--{ 225, "ac9036" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 224, "ac10081" },
			},
		},
		{ --Hyrja
			EncounterJournalID = 1486,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134186 }, -- Skoldiir Bracers
				{ 2,  133620 }, -- Amice of the Enlightened
				{ 3,  133622 }, -- Thunderfused Val'kyr Hauberk
				{ 4,  134209 }, -- Tideskorn Gauntlets
				{ 5,  134196 }, -- Biornskin Hood
				{ 6,  133613 }, -- Solsten's Arcing Runecord
				{ 7,  134219 }, -- Bonespeaker Robes
				{ 8,  133646 }, -- Mote of Sanctification
				{ 9,  133679 }, -- Val'kyr Ascension Signet
				{ 10, 136772 }, -- Valkyra Protector Greatboots
				{ 12, 136974 }, -- Empowerment of Thunder
				{ 13, 136771 }, -- Eyir's Blessing
				--{ 221, "114780:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pure Solium Band
				--{ 223, "ac8843" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 224, "ac8844" },
				--{ 225, "ac9036" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 224, "ac10081" },
			},
		},
		{ --Fenryr
			EncounterJournalID = 1487,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 133639 }, -- Goldscar Pelt
				{ 2, 133626 }, -- Runebands of the Worthy
				{ 3, 136975 }, -- Hunger of the Pack
				{ 4, 136773 }, -- Greatbelt of Alpha Dominance
				{ 5, 133615 }, -- Hide of Fenryr
				{ 6, 133609 }, -- Silken Bloodscent Gloves
				{ 7, 133633 }, -- Wolfstride Pendant
				{ 9, 133687 }, -- Fenryr's Bloodstained Fang
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 118, "ac9033" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --God-King Skovald
			EncounterJournalID = 1488,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134182 }, -- Skoldiir Helm
				{ 2,  134222 }, -- Bonespeaker Bracers
				{ 3,  133641 }, -- Eye of Skovald
				{ 4,  133630 }, -- Greaves of the God-King
				{ 5,  133617 }, -- Cruel Vice Grips
				{ 6,  133638 }, -- Woe-Bearer's Band
				{ 7,  133623 }, -- Felstep Footguards
				{ 8,  134193 }, -- Biornskin Moccasins
				{ 9,  136775 }, -- Infernal Mantle of Conquest
				{ 10, 134212 }, -- Tideskorn Leggings
				{ 11, 133764 }, -- Ragnarok Ember
				{ 12, 136778 }, -- Skovald's Resolve
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --Odyn
			EncounterJournalID = 1489,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  139281 }, -- Glory Seeker's Helm
				{ 2,  133767 }, -- Pendant of the Stormforger
				{ 3,  133647 }, -- Gift of Radiance
				{ 4,  134217 }, -- Bonespeaker Gloves
				{ 5,  139282 }, -- Solid Gold Bracelets
				{ 6,  133765 }, -- Cape of Valarjar Courage
				{ 7,  136776 }, -- Bjorn's Hunting Strap
				{ 8,  134207 }, -- Tideskorn Cinch
				{ 9,  134180 }, -- Skoldiir Gauntlets
				{ 10, 134192 }, -- Biornskin Bracer
				{ 11, 139280 }, -- Treads of Light
				{ 12, 136777 }, -- Collar of Honorable Exultation
				{ 13, 133631 }, -- Pauldrons of the All-Father
				{ 14, 133610 }, -- Leggings of Swirling Runes
				{ 15, 139283 }, -- Wristbands of Magnificent Splendor
				{ 16, 133686 }, -- Stormforged Inferno
				{ 17, 133685 }, -- Odyn's Boon
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 120, "ac9035" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["MawOfSouls"] = {
	EncounterJournalID = 727,
	MapID = 706,
	AtlasMapID = "MawofSoulsA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Ymiron, the Fallen King
			EncounterJournalID = 1502,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  133644 }, -- Memento of Angerboda
				{ 2,  133616 }, -- Legwraps of Unworthy Souls
				{ 3,  133637 }, -- Utgarde Royal Signet
				{ 4,  134179 }, -- Skoldiir Breastplate
				{ 5,  133629 }, -- Crown of Fallen Kings
				{ 6,  134210 }, -- Tideskorn Sabatons
				{ 7,  134217 }, -- Bonespeaker Gloves
				{ 8,  134199 }, -- Biornskin Belt
				{ 9,  133625 }, -- Shoulderguards of Bane
				{ 10, 133614 }, -- Frost-Stricken Cuffs
				{ 12, 133682 }, -- Northern Gale
				{ 13, 137326 }, -- Fragmented Meteorite Whetstone
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 120, "ac9493" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --Harbaron
			EncounterJournalID = 1512,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134197 }, -- Biornskin Vest
				{ 2,  137325 }, -- Afterlife Manacles
				{ 3,  134211 }, -- Tideskorn Coif
				{ 4,  134183 }, -- Skoldiir Legguards
				{ 5,  133645 }, -- Naglfar Fare
				{ 6,  133632 }, -- Void-Touched Wristplates
				{ 7,  137324 }, -- Bleak Underworld Treads
				{ 8,  133771 }, -- Seacursed Wrap
				{ 9,  134218 }, -- Bonespeaker Leggings
				{ 10, 133611 }, -- Soul-Stitched Robes
				{ 12, 133768 }, -- Harbaron's Tether
				{ 13, 137327 }, -- Relinquishing Grip of Helheim
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 120, "ac9017" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ --Helya
			EncounterJournalID = 1663,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  133608 }, -- Mistbound Helarjar Footwraps
				{ 2,  137332 }, -- Mantle of the Dark Sea
				{ 3,  134221 }, -- Bonespeaker Mantle
				{ 4,  133636 }, -- Brysngamen, Torc of Helheim
				{ 5,  137329 }, -- Figurehead of the Naglfar
				{ 6,  137333 }, -- Seaworthy Deck Hands
				{ 7,  134214 }, -- Tideskorn Vest
				{ 8,  134195 }, -- Biornskin Gloves
				{ 9,  133769 }, -- Tempered Seaborne Leggings
				{ 10, 133618 }, -- Kraken Hide Helm
				{ 11, 134184 }, -- Skoldiir Shoulderguards
				{ 12, 133634 }, -- Grasping Tentacle Loop
				{ 13, 137331 }, -- Belt of Eternal Torment
				{ 14, 133770 }, -- Slack Tide Girdle
				{ 15, 137334 }, -- Salt-Laden Stompers
				{ 16, 133683 }, -- Seacursed Mist
				{ 17, 133684 }, -- Screams of the Unworthy
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["Neltharion'sLair"] = {
	EncounterJournalID = 767,
	MapID = 731,
	AtlasMapID = "NeltharionsLair",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Rokmora
			EncounterJournalID = 1662,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  139121 }, -- Skyhorn Mantle
				{ 2,  137338 }, -- Shard of Rokmora
				{ 3,  134481 }, -- Boulderbuckle Strap
				{ 4,  134427 }, -- Riverrider Legwraps
				{ 5,  139105 }, -- Rivermane Sandals
				{ 6,  137337 }, -- Deepfurrow Bracers
				{ 7,  134491 }, -- Understone Gorget
				{ 8,  139095 }, -- Greystone Belt
				{ 9,  139130 }, -- Sunfrost Wristwraps
				{ 10, 137336 }, -- Vest of Rupturing Diamonds
				{ 12, 137340 }, -- Crystalline Energies
				{ 13, 137339 }, -- Quivering Blightshard Husk
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 120, "ac9045" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  139121 }, -- Skyhorn Mantle
				{ 2,  137338 }, -- Shard of Rokmora
				{ 3,  134481 }, -- Boulderbuckle Strap
				{ 4,  134427 }, -- Riverrider Legwraps
				{ 5,  139105 }, -- Rivermane Sandals
				{ 6,  137337 }, -- Deepfurrow Bracers
				{ 7,  134491 }, -- Understone Gorget
				{ 8,  139095 }, -- Greystone Belt
				{ 9,  139130 }, -- Sunfrost Wristwraps
				{ 10, 137336 }, -- Vest of Rupturing Diamonds
			},
		},
		{ --Ularogg Cragshaper
			EncounterJournalID = 1665,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134141 }, -- Rockbound Sabatons
				{ 2,  134443 }, -- Gravelworn Handguards
				{ 3,  134177 }, -- Roggthread Mantle
				{ 4,  134164 }, -- Bitestone Wristwrap
				{ 5,  134530 }, -- Loop of Vitriolic Intent
				{ 6,  137354 }, -- Tunic of Screaming Earth
				{ 7,  137341 }, -- Cragshaper's Fitted Hood
				{ 8,  137344 }, -- Talisman of the Cragshaper
				{ 9,  137342 }, -- Rock Solid Legplates
				{ 10, 134152 }, -- Steelgazer Hide Hood
				{ 12, 137347 }, -- Fragment of Loathing
				{ 13, 137346 }, -- Murmuring Idol
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 130, "ac9058" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134141 }, -- Rockbound Sabatons
				{ 2,  134443 }, -- Gravelworn Handguards
				{ 3,  134177 }, -- Roggthread Mantle
				{ 4,  134164 }, -- Bitestone Wristwrap
				{ 5,  134530 }, -- Loop of Vitriolic Intent
				{ 6,  137354 }, -- Tunic of Screaming Earth
				{ 7,  137341 }, -- Cragshaper's Fitted Hood
				{ 8,  137344 }, -- Talisman of the Cragshaper
				{ 9,  137342 }, -- Rock Solid Legplates
				{ 10, 134152 }, -- Steelgazer Hide Hood
			},
		},
		{ --Naraxas
			EncounterJournalID = 1673,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137349 }, -- Naraxas' Spiked Tongue
				{ 2,  134458 }, -- Wristbands of Rousing Violence
				{ 3,  134524 }, -- Band of the Wyrm Matron
				{ 4,  134511 }, -- Subterranean Horror Faceguard
				{ 5,  137348 }, -- Gauntlets of Innumerable Barbs
				{ 6,  134416 }, -- Offal Galoshes
				{ 7,  134408 }, -- Putrid Carapace
				{ 9,  137351 }, -- Noxious Entrails
				{ 10, 137350 }, -- Monstrous Gluttony
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 126, "ac9056" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 137349 }, -- Naraxas' Spiked Tongue
				{ 2, 134458 }, -- Wristbands of Rousing Violence
				{ 3, 134524 }, -- Band of the Wyrm Matron
				{ 4, 134511 }, -- Subterranean Horror Faceguard
				{ 5, 137348 }, -- Gauntlets of Innumerable Barbs
				{ 6, 134416 }, -- Offal Galoshes
				{ 7, 134408 }, -- Putrid Carapace
			},
		},
		{ --Dargrul the Underking
			EncounterJournalID = 1687,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134455 }, -- Sinister Ashfall Cord
				{ 2,  134154 }, -- Steelgazer Hide Mantle
				{ 3,  134171 }, -- Roggthread Cord
				{ 4,  137353 }, -- Charskin Legguards
				{ 5,  137355 }, -- Rumblestone Gauntlets
				{ 6,  137357 }, -- Mark of Dargrul
				{ 7,  134166 }, -- Bitestone Boots
				{ 8,  134420 }, -- Gloves of the Mountain Conquest
				{ 9,  134470 }, -- Mountain Throne Coif
				{ 10, 134517 }, -- Tremorguard Pauldrons
				{ 11, 134474 }, -- Faultline Leggings
				{ 12, 137352 }, -- Tunic of Smoldering Ire
				{ 13, 134135 }, -- Rockbound Chestguard
				{ 14, 134495 }, -- Chain of the Underking
				{ 16, 137359 }, -- Pebble of Ages
				{ 17, 137358 }, -- Hate-Sculpted Magma
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134455 }, -- Sinister Ashfall Cord
				{ 2,  134154 }, -- Steelgazer Hide Mantle
				{ 3,  134171 }, -- Roggthread Cord
				{ 4,  137353 }, -- Charskin Legguards
				{ 5,  137355 }, -- Rumblestone Gauntlets
				{ 6,  137357 }, -- Mark of Dargrul
				{ 7,  134166 }, -- Bitestone Boots
				{ 8,  134420 }, -- Gloves of the Mountain Conquest
				{ 9,  134470 }, -- Mountain Throne Coif
				{ 10, 134517 }, -- Tremorguard Pauldrons
				{ 11, 134474 }, -- Faultline Leggings
				{ 12, 137352 }, -- Tunic of Smoldering Ire
				{ 13, 134135 }, -- Rockbound Chestguard
				{ 14, 134495 }, -- Chain of the Underking
			},
		},
		LEGION_DUNGEON_HERO_AC_TABLE,
		LEGION_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["ReturnToKarazhan"] = {
	EncounterJournalID = 860,
	MapID = 809,
	AtlasMapID = "ReturntoKarazhanA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Opera Hall: Wikket
			EncounterJournalID = 1820,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142198 }, -- Inordinately Wonderous Wristguards
				{ 2,  142204 }, -- Boots of False Promises
				{ 3,  142296 }, -- Wikket Witch's Hat
				{ 4,  142298 }, -- Astonishingly Scarlet Slippers
				{ 5,  142300 }, -- Greaves of Miraculous Magnificence
				{ 6,  142137 }, -- Short Jibbet Waistguard
				{ 7,  142205 }, -- Jabber Grookin' Gauntlets
				{ 8,  142299 }, -- Horkin' Stuff-Lobbers
				{ 10, 142179 }, -- Memory of Betrayal
				{ 11, 142175 }, -- Arcanum of Weightlessness
				{ 12, 142194 }, -- Gloomy Vortex
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Opera Hall: Westfall Story
			EncounterJournalID = 1826,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142164 }, -- Toe Knee's Promise
				{ 2,  142146 }, -- Blackfin Wristband
				{ 3,  142302 }, -- Armguards of Burning Passion
				{ 4,  142154 }, -- Bracelets of the Sorrowful Bride
				{ 5,  142201 }, -- Mantle of Conflicted Loyalties
				{ 6,  142160 }, -- Mrrgria's Favor
				{ 8,  142186 }, -- Mrrmgmrl Grmmlmglrg
				{ 9,  142178 }, -- Ruffian's Poisoned Blade
				{ 10, 142190 }, -- Love's Intermission
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Opera Hall: Beautiful Beast
			EncounterJournalID = 1827,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142196 }, -- Cinch of Improbable Desire
				{ 2,  142168 }, -- Majordomo's Dinner Bell
				{ 3,  142202 }, -- Trousers of Royal Vanity
				{ 4,  142206 }, -- Cloak of Sweltering Flame
				{ 5,  142197 }, -- Legguards of Imprisonment
				{ 6,  142304 }, -- Visage of Brutish Iron
				{ 8,  142188 }, -- Spellbound Rose Petal
				{ 9,  142184 }, -- Candle of Flickering Lumens
				{ 10, 142192 }, -- Ghastly Curse
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Maiden of Virtue
			EncounterJournalID = 1825,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 142139 }, -- Vest of Wanton Deeds
				{ 2, 142138 }, -- Confiscated Manacles
				{ 3, 142153 }, -- Cord of the Penitent
				{ 4, 142170 }, -- Drape of Shame
				{ 5, 142124 }, -- Treads of the Depraved
				{ 6, 142158 }, -- Faith's Crucible
				{ 8, 142193 }, -- Begrudging Confessions
				{ 9, 142187 }, -- Virtuous Directive
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Attumen the Huntsman
			EncounterJournalID = 1835,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142136 }, -- Mantle of Hideous Trophies
				{ 2,  142174 }, -- Choker of Barbed Reins
				{ 3,  142148 }, -- Wilderness Stalker's Softsoles
				{ 4,  142126 }, -- Helm of Phantasmal Scars
				{ 5,  142236 }, -- Midnight's Eternal Reins
				{ 6,  142140 }, -- Calliard's Galoshes
				{ 7,  142161 }, -- Inescapable Dread
				{ 9,  142183 }, -- Lava-Quenched Hoofplate
				{ 10, 142185 }, -- Fear of Predation
				{ 11, 142191 }, -- Dirge of the Hunted
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Moroes
			EncounterJournalID = 1837,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142147 }, -- Robes of Wicked Modesty
				{ 2,  142134 }, -- Castellan's Blinders
				{ 3,  142123 }, -- Breastplate of Obligation
				{ 4,  142171 }, -- Seal of Darkshire Nobility
				{ 5,  142143 }, -- Willbreaker Legguards
				{ 6,  142159 }, -- Bloodstained Handkerchief
				{ 7,  138797 }, -- Illusion: Mongoose
				{ 9,  142177 }, -- Jagged Emerald
				{ 10, 142189 }, -- Perfectly Preserved Apple
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --The Curator
			EncounterJournalID = 1836,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142149 }, -- Gloves of Arcane Confluence
				{ 2,  142125 }, -- Repurposed Golem Grips
				{ 3,  142172 }, -- Terestian's Signet Ring
				{ 4,  142133 }, -- Gauntlets of Confinement
				{ 5,  142165 }, -- Deteriorated Construct Core
				{ 6,  142141 }, -- Custodian's Soothing Touch
				{ 7,  142130 }, -- Bite-Marked Wristplates
				{ 9,  142181 }, -- Seeping Corruption
				{ 10, 142309 }, -- Fauna Analysis Widget
				{ 11, 142176 }, -- Arcing Static Charge
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Shade of Medivh
			EncounterJournalID = 1817,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142207 }, -- Amulet of the Last Guardian
				{ 2,  142157 }, -- Aran's Relaxing Ruby
				{ 3,  142129 }, -- Spellwarding Waistguard
				{ 4,  142131 }, -- Frozen-Link Chestguard
				{ 5,  142152 }, -- Shoulderpads of Chaotic Thought
				{ 6,  142169 }, -- Raven Eidolon
				{ 7,  142145 }, -- Girdle of Ghostly Exclusion
				{ 9,  142310 }, -- Anthology of Horrors
				{ 10, 142308 }, -- Ageless Winter
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Mana Devourer
			EncounterJournalID = 1818,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  142162 }, -- Fluctuating Energy
				{ 2,  142144 }, -- Unending Horizon Spaulders
				{ 3,  142150 }, -- Hood of Uncanny Perspectives
				{ 4,  142135 }, -- Legguards of Countless Hours
				{ 5,  142128 }, -- Pauldrons of Encroaching Limits
				{ 6,  142215 }, -- Wine-Stained Mantle
				{ 8,  142180 }, -- Grisly Schism
				{ 9,  142305 }, -- Suffused Manapearl
				{ 10, 142307 }, -- Miniature Bonfire
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ --Viz'aduum the Watcher
			EncounterJournalID = 1838,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 142151 }, -- Leggings of Countless Worlds
				{ 2, 142132 }, -- Doomstride Footguards
				{ 3, 142127 }, -- Tassets of Perpetual Despair
				{ 4, 142142 }, -- Unbound Reality Mask
				{ 5, 142173 }, -- Ring of Collapsing Futures
				{ 6, 142167 }, -- Eye of Command
				{ 8, 142306 }, -- Rift Stabilization Shard
				{ 9, 142182 }, -- Viz'aduum's Mindstone
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	}
}

-- Seat of the Triumvirate
data["SeatoftheTriumvirate"] = {
	EncounterJournalID = 945,
	MapID = 903,
	AtlasMapID = "TheSeatoftheTriumvirate",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ -- Zuraal the Ascended
			EncounterJournalID = 1979,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 151312 }, -- Ampoule of Pure Void
				{ 2, 151329 }, -- Breastplate of the Dark Touch
				{ 3, 151320 }, -- Void-Coated Stompers
				{ 4, 151300 }, -- Handwraps of the Ascended
				{ 5, 151308 }, -- Eredath Seal of Nobility
				{ 6, 151336 }, -- Voidlashed Hood
				{ 7, 258514 }, -- Umbral Spire of Zuraal
				-- { 3,  151331 }, -- Pauldrons of the Broken
				-- { 5,  151326 }, -- Waistguard of Bound Energy
				-- { 6,  151315 }, -- Bracers of Dark Binding
				-- { 8,  151304 }, -- Subjugator's Leggings

				--[[ { 12, 151291 }, -- Frozen Void Shard
				{ 13, 151293 }, -- Orb of the Abandoned Magi ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Saprish
			EncounterJournalID = 1980,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  151327 }, -- Girdle of the Shadowguard
				{ 2,  151314 }, -- Shifting Stalker Hide Pants
				{ 3,  151318 }, -- Gloves of the Dark Shroud
				{ 4,  151307 }, -- Void Stalker's Contract
				{ 5,  151330 }, -- Trap Jammers
				{ 6,  151303 }, -- Voidbender Robe
				{ 7,  151321 }, -- Darkfang Scale Wristguards
				{ 8,  151323 }, -- Pauldrons of the Void Hunter
				{ 9,  151337 }, -- Shadow-Weaver's Crown
				{ 10, 258516 }, -- Wand of Saprish's Gaze

				--[[ { 5,  151294 }, -- Coalesced Void
				{ 10, 151295 }, -- Darkstorm Arrowhead ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- Viceroy Nezhar
			EncounterJournalID = 1981,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  151299 }, -- Viceroy's Umbral Mantle
				{ 2,  151333 }, -- Crown of the Dark Envoy
				{ 3,  151309 }, -- Necklace of the Twisting Void
				{ 4,  151332 }, -- Voidclaw Gauntlets
				{ 5,  151325 }, -- Void-Linked Robe
				{ 6,  151305 }, -- Entropic Wristwraps
				{ 7,  151310 }, -- Reality Breacher
				{ 8,  151317 }, -- Footpads of Seeping Dread
				{ 9,  258524 }, -- Grips of the Dark Viceroy
				{ 10, 258523 }, -- Nezhar's Netherclaw
				-- { 3,  151316 }, -- Cinch of the Umbral Lasher
				-- { 11, 151338 }, -- Leggings of Shifting Darkness

				--[[ { 1,  151297 }, -- Carved Argunite Idol
				{ 5,  151290 }, -- Darktide Fervor
				{ 7,  151288 }, -- Void-Resistant Seedpod ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
		{ -- L'ura
			EncounterJournalID = 1982,
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  151301 }, -- Slippers of Growing Despair
				{ 2,  151322 }, -- Void-Touched Grips
				{ 3,  151313 }, -- Vest of the Void's Embrace
				{ 4,  151311 }, -- Band of the Triumvirate
				{ 5,  151302 }, -- Cord of Unraveling Reality
				{ 6,  151319 }, -- Twilight's Edge Spaulders
				{ 7,  151328 }, -- Vambraces of Lost Hope
				{ 8,  151340 }, -- Echo of L'ura
				{ 9,  258525 }, -- Scepter of the Endless Night
				{ 11, 241044 }, -- Argussian Crate
				-- { 9,  151339 }, -- Legplates of Ultimate Sacrifice
				-- { 3,  151324 }, -- Helm of Shadowy Descent

				--[[ { 2,  151289 }, -- Badge of the Fallen Vindicator
				{ 5,  151296 }, -- Blood of the Vanquished
				{ 13, 151292 }, -- Sanctified Eredar Lock ]]
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = HEROIC_DUNGEON_DIFF,
			},
		},
	},
}

data["VaultOfTheWardens"] = {
	EncounterJournalID = 707,
	MapID = 710,
	AtlasMapID = "VaultoftheWardensA",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --Tirathon Saltheril
			EncounterJournalID = 1467,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  134398 }, -- Netherwhisper Wristguard
				{ 2,  137537 }, -- Tirathon's Betrayal
				{ 3,  137509 }, -- Glaivemaster's Studded Grips
				{ 4,  137532 }, -- Seal of Saltheril
				{ 5,  137502 }, -- Hood of Indignation
				{ 6,  134369 }, -- Felbat Leather Boots
				{ 7,  137517 }, -- Striders of Furious Flight
				{ 8,  137524 }, -- Mortar Guard Shoulderplates
				{ 9,  134390 }, -- Mardum Chain Vest
				{ 10, 134362 }, -- Portalguard Wristguard
				{ 12, 137542 }, -- Metamorphosis Spark
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 126, "ac9056" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  134398 }, -- Netherwhisper Wristguard
				{ 2,  137537 }, -- Tirathon's Betrayal
				{ 3,  137509 }, -- Glaivemaster's Studded Grips
				{ 4,  137532 }, -- Seal of Saltheril
				{ 5,  137502 }, -- Hood of Indignation
				{ 6,  134369 }, -- Felbat Leather Boots
				{ 7,  137517 }, -- Striders of Furious Flight
				{ 8,  137524 }, -- Mortar Guard Shoulderplates
				{ 9,  134390 }, -- Mardum Chain Vest
				{ 10, 134362 }, -- Portalguard Wristguard
			},
		},
		{ --Inquisitor Tormentorum
			EncounterJournalID = 1695,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 137538 }, -- Orb of Torment
				{ 2, 137511 }, -- Hood of the Blind Executioner
				{ 3, 137518 }, -- Leggings of Biting Links
				{ 4, 137525 }, -- Blood-Spattered Gauntlets
				{ 5, 137530 }, -- Drape of Vile Misfortune
				{ 6, 137503 }, -- Amice of Cruel Laughter
				{ 8, 137544 }, -- Prisoner's Wail
				{ 9, 137543 }, -- Soulsap Shackles
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 126, "ac9056" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 137538 }, -- Orb of Torment
				{ 2, 137511 }, -- Hood of the Blind Executioner
				{ 3, 137518 }, -- Leggings of Biting Links
				{ 4, 137525 }, -- Blood-Spattered Gauntlets
				{ 5, 137530 }, -- Drape of Vile Misfortune
				{ 6, 137503 }, -- Amice of Cruel Laughter
			},
		},
		{ --Ash'golm
			EncounterJournalID = 1468,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137512 }, -- Flame Juggler's Armbands
				{ 2,  137535 }, -- Lavadrip Pendant
				{ 3,  137539 }, -- Faulty Countermeasure
				{ 4,  137526 }, -- Crown of Ash
				{ 5,  137505 }, -- Leggings of the Third Degree
				{ 6,  137504 }, -- Flameheart Vestment
				{ 7,  137520 }, -- Permafrost Waistband
				{ 8,  137523 }, -- Magmacrusher Girdle
				{ 9,  137510 }, -- Charskin Mantle
				{ 10, 137519 }, -- Lavabreaker Gauntlets
				{ 12, 137546 }, -- Molten Giant's Eye
				{ 13, 137545 }, -- Flashfrozen Ember
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 126, "ac9056" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  137512 }, -- Flame Juggler's Armbands
				{ 2,  137535 }, -- Lavadrip Pendant
				{ 3,  137539 }, -- Faulty Countermeasure
				{ 4,  137526 }, -- Crown of Ash
				{ 5,  137505 }, -- Leggings of the Third Degree
				{ 6,  137504 }, -- Flameheart Vestment
				{ 7,  137520 }, -- Permafrost Waistband
				{ 8,  137523 }, -- Magmacrusher Girdle
				{ 9,  137510 }, -- Charskin Mantle
				{ 10, 137519 }, -- Lavabreaker Gauntlets
			},
		},
		{ --Glazer
			EncounterJournalID = 1469,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 137527 }, -- Polished Jade Chestguard
				{ 2, 137533 }, -- Ring of Minute Mirrors
				{ 3, 137506 }, -- Gloves of Unseen Evil
				{ 4, 137513 }, -- Girdle of Lidless Sight
				{ 5, 137536 }, -- Pendant of the Watchful Eye
				{ 6, 137516 }, -- Collar of Blindsight
				{ 7, 137540 }, -- Concave Reflecting Lens
				{ 9, 137547 }, -- Pulsing Prism
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 126, "ac9056" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 137527 }, -- Polished Jade Chestguard
				{ 2, 137533 }, -- Ring of Minute Mirrors
				{ 3, 137506 }, -- Gloves of Unseen Evil
				{ 4, 137513 }, -- Girdle of Lidless Sight
				{ 5, 137536 }, -- Pendant of the Watchful Eye
				{ 6, 137516 }, -- Collar of Blindsight
				{ 7, 137540 }, -- Concave Reflecting Lens
			},
		},
		{ --Cordana Felsong
			EncounterJournalID = 1470,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  137514 }, -- Chestguard of Insidious Desire
				{ 2,  134356 }, -- Portalguard Gauntlets
				{ 3,  137522 }, -- Bracers of Twisted Revelation
				{ 4,  137507 }, -- Waistband of Spiritual Doom
				{ 5,  137515 }, -- Warden's Martial Greaves
				{ 6,  134392 }, -- Netherwhisper Hood
				{ 7,  137531 }, -- Cloak of Enthralling Darkness
				{ 8,  137508 }, -- Shadewalker Footwraps
				{ 9,  137528 }, -- Legguards of Illusory Burdens
				{ 10, 134386 }, -- Mardum Chain Boots
				{ 11, 137521 }, -- Shoulderguards of Shunned Duty
				{ 12, 137529 }, -- Pathfinders of Dark Omens
				{ 13, 134371 }, -- Felbat Leather Gloves
				{ 14, 137541 }, -- Moonlit Prism
				{ 16, 137549 }, -- Shade of the Vault
				{ 17, 137550 }, -- Moonglaive Dervish
				{ 18, 137548 }, -- Elune's Light
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				--{ 126, "ac9056" },
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  137514 }, -- Chestguard of Insidious Desire
				{ 2,  134356 }, -- Portalguard Gauntlets
				{ 3,  137522 }, -- Bracers of Twisted Revelation
				{ 4,  137507 }, -- Waistband of Spiritual Doom
				{ 5,  137515 }, -- Warden's Martial Greaves
				{ 6,  134392 }, -- Netherwhisper Hood
				{ 7,  137531 }, -- Cloak of Enthralling Darkness
				{ 8,  137508 }, -- Shadewalker Footwraps
				{ 9,  137528 }, -- Legguards of Illusory Burdens
				{ 10, 134386 }, -- Mardum Chain Boots
				{ 11, 137521 }, -- Shoulderguards of Shunned Duty
				{ 12, 137529 }, -- Pathfinders of Dark Omens
				{ 13, 134371 }, -- Felbat Leather Gloves
				{ 14, 137541 }, -- Moonlit Prism
			},
		},
	}
}

-- /////////////////////////////////
-- Raid
-- /////////////////////////////////

-- Antorus, the Burning Throne
data["AntorustheBurningThrone"] = {
	EncounterJournalID = 946,
	MapID = 909,
	AtlasMapID = "AntorustheBurningThroneA",
	ContentType = RAID_CONTENT,
	items = {
		{ -- Garothi Worldbreaker
			EncounterJournalID = 1992,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152017 }, -- Soul-Tempered Chestplate
				{ 2,  152002 }, -- Battalion-Shattering Leggings
				{ 3,  151937 }, -- Cloak of the Burning Vanguard
				{ 4,  151956 }, -- Garothi Feedback Conduit
				{ 5,  151943 }, -- Crown of Relentless Annihilation
				{ 6,  152009 }, -- Doomwalker Warboots
				{ 7,  151962 }, -- Prototype Personnel Decimator
				{ 8,  151951 }, -- Enhanced Worldscorcher Cinch
				{ 9,  151998 }, -- Heedless Eradication Gauntlets
				{ 10, 151987 }, -- Breach-Blocker Legguards
				{ 11, 151988 }, -- Shoulderpads of the Demonic Blitz
				{ 13, 152036 }, -- Hellfire Ignition Switch
				{ 14, 152031 }, -- Doomfire Dynamo
				{ 15, 152028 }, -- Spurting Reaver Heart
				{ 16, 152039 }, -- Viscous Reaver-Coolant
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Felhounds of Sargeras
			EncounterJournalID = 1987,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  151968 }, -- Shadow-Singed Fang
				{ 2,  151949 }, -- Soul-Siphon Mantle
				{ 3,  152000 }, -- Shadowfused Chain Coif
				{ 4,  151973 }, -- Collar of Null-Flame
				{ 5,  152012 }, -- Molten Bite Handguards
				{ 6,  151974 }, -- Eye of Shatug
				{ 7,  151947 }, -- Vestments of Enflamed Blight
				{ 8,  152021 }, -- Flamelicked Girdle
				{ 9,  152645 }, -- Eye of F'harg
				{ 10, 151983 }, -- Vicious Flamepaws
				{ 11, 151980 }, -- Harness of Oppressing Dark
				{ 12, 152004 }, -- Pauldrons of the Soulburner
				{ 14, 152027 }, -- Gravitational Condensate
				{ 15, 152059 }, -- Whistling Ulna
				{ 16, 152056 }, -- Corrupting Dewclaw
				{ 17, 152291 }, -- Fraternal Fervor
				{ 19, 152816 }, -- Antoran Charhound
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Antoran High Command
			EncounterJournalID = 1997,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152119 }, -- Felreaper Drape
				{ 2,  152154 }, -- Gilded Seraph's Drape
				{ 3,  152131 }, -- Serpentstalker Drape
				{ 4,  152011 }, -- Eredar Warcouncil Sabatons
				{ 5,  151953 }, -- Man'ari Pyromancer Cuffs
				{ 6,  152143 }, -- Cloak of Chi'Ji
				{ 7,  151992 }, -- Fiendish Logistician's Wristwraps
				{ 8,  151969 }, -- Terminus Signaling Beacon
				{ 9,  151985 }, -- General Erodus' Tricorne
				{ 10, 152113 }, -- Dreadwake Greatcloak
				{ 11, 152179 }, -- Juggernaut Cloak
				{ 12, 152125 }, -- Bearmantle Cloak
				{ 13, 152136 }, -- Runebound Cape
				{ 14, 151957 }, -- Ishkar's Felshield Emitter
				{ 15, 152149 }, -- Light's Vanguard Greatcloak
				{ 16, 152172 }, -- Grim Inquisitor's Cloak
				{ 17, 152424 }, -- Legwraps of the Seasoned Exterminator
				{ 18, 151994 }, -- Fleet Commander's Hauberk
				{ 19, 152006 }, -- Depraved Tactician's Waistguard
				{ 20, 152161 }, -- Cloak of the Dashing Scoundrel
				{ 21, 152019 }, -- Pauldrons of the Eternal Offensive
				{ 22, 152167 }, -- Drape of Venerated Spirits
				{ 24, 152293 }, -- Fasces of the Endless Legions
				{ 25, 152295 }, -- Svirax's Grim Trophy
				{ 26, 152043 }, -- Lightshield Amplifier
				{ 27, 152032 }, -- Twisted Engineer's Fel-Infuser
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Portal Keeper Hasabel
			EncounterJournalID = 1985,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  151976 }, -- Riftworld Codex
				{ 2,  152008 }, -- Reality-Splitting Wristguards
				{ 3,  151965 }, -- Vulcanarcore Pendant
				{ 4,  151958 }, -- Tarratus Keystone
				{ 5,  152001 }, -- Nexus Conductor's Headgear
				{ 6,  152063 }, -- Seal of the Portalmaster
				{ 7,  151945 }, -- Lady Dacidion's Silk Slippers
				{ 8,  151990 }, -- Portal Keeper's Cincture
				{ 9,  152086 }, -- Grips of Hungering Shadows
				{ 10, 152020 }, -- Nathrezim Battle Girdle
				{ 11, 151941 }, -- Aranasi Shadow-Weaver's Gloves
				{ 13, 152049 }, -- Fel-Engraved Handbell
				{ 14, 152057 }, -- Crepuscular Skitterer Egg
				{ 15, 152035 }, -- Blazing Dreadsteed Horseshoe
				{ 16, 152041 }, -- Sublimating Portal Frost
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Eonar the Life-Binder
			EncounterJournalID = 2025,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152158 }, -- Gilded Seraph's Robes
				{ 2,  152007 }, -- Sash of the Gilded Rose
				{ 3,  152166 }, -- Robes of Venerated Spirits
				{ 4,  152112 }, -- Dreadwake Bonecage
				{ 5,  152178 }, -- Juggernaut Breastplate
				{ 6,  152124 }, -- Bearmantle Harness
				{ 7,  151981 }, -- Life-Bearing Footpads
				{ 8,  152140 }, -- Runebound Tunic
				{ 9,  152148 }, -- Light's Vanguard Breastplate
				{ 10, 151970 }, -- Vitality Resonator
				{ 11, 152160 }, -- Vest of the Dashing Scoundrel
				{ 12, 152023 }, -- Vambraces of Life's Assurrance
				{ 13, 152013 }, -- Helmet of the Hidden Sanctuary
				{ 14, 152681 }, -- Headdress of Living Brambles
				{ 15, 152176 }, -- Grim Inquisitor's Robes
				{ 16, 152118 }, -- Felreaper Vest
				{ 17, 152688 }, -- Loop of the Life-Binder
				{ 18, 152130 }, -- Serpentstalker Tunic
				{ 19, 151952 }, -- Cord of Blossoming Petals
				{ 20, 152142 }, -- Tunic of Chi'Ji
				{ 22, 152047 }, -- Ironvine Thorn
				{ 23, 152054 }, -- Unwavering Soul Essence
				{ 24, 152061 }, -- Droplets of the Cleansing Storm
				{ 25, 152044 }, -- Spark of Everburning Light
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Imonar the Soulhunter
			EncounterJournalID = 2009,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152146 }, -- Leggings of Chi'Ji
				{ 2,  151999 }, -- Preysnare Vicegrips
				{ 3,  152170 }, -- Leggings of Venerated Spirits
				{ 4,  152116 }, -- Dreadwake Legplates
				{ 5,  152182 }, -- Juggernaut Legplates
				{ 6,  151938 }, -- Drape of the Spirited Hunt
				{ 7,  152128 }, -- Bearmantle Legguards
				{ 8,  151989 }, -- Spaulders of the Relentless Tracker
				{ 9,  152152 }, -- Light's Vanguard Legplates
				{ 10, 151939 }, -- Whisperstep Runners
				{ 11, 152687 }, -- Imonar's Demi-Gauntlets
				{ 12, 152164 }, -- Pants of the Dashing Scoundrel
				{ 13, 152416 }, -- Shoulderguards of Indomitable Purpose
				{ 14, 151996 }, -- Deft Soulhunter's Sabatons
				{ 15, 152122 }, -- Felreaper Leggings
				{ 16, 152157 }, -- Gilded Seraph's Leggings
				{ 17, 151944 }, -- Soulhunter's Cowl
				{ 18, 152134 }, -- Serpentstalker Legguards
				{ 19, 152139 }, -- Runebound Leggings
				{ 20, 152175 }, -- Grim Inquisitor's Leggings
				{ 22, 152042 }, -- Hoarfrost-Beast Talon
				{ 23, 152050 }, -- Mysterious Petrified Egg
				{ 24, 152024 }, -- Fallen Magi's Seerstone
				{ 25, 152045 }, -- Venerated Puresoul Idol
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Kin'garoth
			EncounterJournalID = 2004,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152150 }, -- Light's Vanguard Gauntlets
				{ 2,  152162 }, -- Gloves of the Dashing Scoundrel
				{ 3,  152120 }, -- Felreaper Gloves
				{ 4,  152155 }, -- Gilded Seraph's Handwraps
				{ 5,  152132 }, -- Serpentstalker Grips
				{ 6,  151955 }, -- Acrid Catalyst Injector
				{ 7,  152144 }, -- Grips of Chi'Ji
				{ 8,  152137 }, -- Runebound Gloves
				{ 9,  152280 }, -- Scalding Shatterguards
				{ 10, 151963 }, -- Forgefiend's Fabricator
				{ 11, 152412 }, -- Depraved Machinist's Footpads
				{ 12, 152168 }, -- Gloves of Venerated Spirits
				{ 13, 152114 }, -- Dreadwake Gauntlets
				{ 14, 152180 }, -- Juggernaut Gauntlets
				{ 15, 152064 }, -- Band of the Sargerite Smith
				{ 16, 152126 }, -- Bearmantle Paws
				{ 17, 151975 }, -- Apocalypse Drive
				{ 18, 151948 }, -- Magma-Spattered Smock
				{ 19, 152014 }, -- Titan-Subjugator's Visage
				{ 20, 152173 }, -- Grim Inquisitor's Gloves
				{ 22, 152051 }, -- Eidolon of Life
				{ 23, 152034 }, -- Obliterator Propellant
				{ 24, 152055 }, -- Kin'garoth's Oil-Sump
				{ 25, 152048 }, -- Decimator Crankshaft
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- The Coven of Shivarra
			EncounterJournalID = 1986,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152177 }, -- Grim Inquisitor's Shoulderguards
				{ 2,  152123 }, -- Felreaper Spaulders
				{ 3,  152003 }, -- Legguards of Numbing Gloom
				{ 4,  152135 }, -- Serpentstalker Mantle
				{ 5,  152147 }, -- Meditation Spheres of Chi'Ji
				{ 6,  152159 }, -- Gilded Seraph's Amice
				{ 7,  151946 }, -- Fervent Twilight Legwraps
				{ 8,  152171 }, -- Pauldrons of Venerated Spirits
				{ 9,  152117 }, -- Dreadwake Pauldrons
				{ 10, 152183 }, -- Juggernaut Pauldrons
				{ 11, 152284 }, -- Zealous Tormentor's Ring
				{ 12, 152129 }, -- Bearmantle Shoulders
				{ 13, 152141 }, -- Runebound Mantle
				{ 14, 151977 }, -- Diima's Glacial Aegis
				{ 15, 152289 }, -- Highfather's Machination
				{ 16, 152153 }, -- Light's Vanguard Shoulderplates
				{ 17, 151971 }, -- Sheath of Asara
				{ 18, 152010 }, -- Burning Coven Sabatons
				{ 19, 152165 }, -- Shoulderpads of the Dashing Scoundrel
				{ 20, 151984 }, -- Lurid Grips of the Obscene
				{ 21, 152414 }, -- Bracers of Wanton Morality
				{ 23, 152046 }, -- Coven Prayer Bead
				{ 24, 152058 }, -- Stormcaller's Fury
				{ 25, 152040 }, -- Frigid Gloomstone
				{ 26, 152029 }, -- Shivarran Cachabon
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Varimathras
			EncounterJournalID = 1983,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  151942 }, -- Cord of Surging Hysteria
				{ 2,  151991 }, -- Belt of Fractured Sanity
				{ 3,  151997 }, -- Nathrezim Shade-Walkers
				{ 4,  151954 }, -- Blood-Drenched Bindings
				{ 5,  152015 }, -- Greaves of Mercurial Alliegance
				{ 6,  151964 }, -- Seeping Scourgewing
				{ 7,  151960 }, -- Carafe of Searing Light
				{ 8,  151979 }, -- Vest of Unfathomable Anguish
				{ 9,  151966 }, -- Riveted Choker of Delirium
				{ 10, 152281 }, -- Varimathras' Shattered Manacles
				{ 11, 151995 }, -- Robes of the Forsaken Dreadlord
				{ 13, 152092 }, -- Nathrezim Incisor
				{ 14, 152025 }, -- Thu'rayan Lash
				{ 15, 152037 }, -- Tormentor's Brand
				{ 16, 152060 }, -- Neuroshock Electrode
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Aggramar
			EncounterJournalID = 1984,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  152115 }, -- Dreadwake Helm
				{ 2,  152181 }, -- Juggernaut Helm
				{ 3,  152127 }, -- Bearmantle Headdress
				{ 4,  152174 }, -- Grim Inquisitor's Death Mask
				{ 5,  152151 }, -- Light's Vanguard Helm
				{ 6,  152093 }, -- Gorshalach's Legacy
				{ 7,  152163 }, -- Cavalier Hat of the Dashing Scoundrel
				{ 8,  151950 }, -- Fallen Avenger's Amice
				{ 9,  151978 }, -- Foe-Breaker Titanguard
				{ 10, 152282 }, -- Caustic Titanspite Legguards
				{ 11, 152121 }, -- Felreaper Hood
				{ 12, 152156 }, -- Gilded Seraph's Crown
				{ 13, 152169 }, -- Headdress of Venerated Spirits
				{ 14, 152133 }, -- Serpentstalker Helmet
				{ 15, 152062 }, -- Greatcloak of the Dark Pantheon
				{ 16, 152683 }, -- World-Ravager Waistguard
				{ 17, 151940 }, -- Sandals of the Reborn Colossus
				{ 18, 152022 }, -- Grond-Father Girdle
				{ 19, 152684 }, -- Greatboots of the Searing Tempest
				{ 20, 152145 }, -- Douli of Chi'Ji
				{ 21, 152138 }, -- Runebound Collar
				{ 22, 152018 }, -- Breastplate of Molten Rebirth
				{ 24, 152026 }, -- Prototype Titan-Disc
				{ 25, 152038 }, -- Pyretic Bronze Clasp
				{ 26, 152052 }, -- Sporemound Seedling
				{ 27, 152033 }, -- Sliver of Corruption
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Argus the Unmaker
			EncounterJournalID = 2031,
			[RF_DIFF] = {
				{ 1,  151972 }, -- Sullied Seal of the Pantheon
				{ 2,  151982 }, -- Vest of Waning Life
				{ 3,  151986 }, -- Death-Enveloping Cincture
				{ 4,  152005 }, -- Pauldrons of Colossal Burden
				{ 5,  152016 }, -- Cosmos-Culling Legplates
				{ 6,  152283 }, -- Chain of the Unmaker
				{ 7,  152423 }, -- Helm of the Awakened Soul
				{ 8,  152679 }, -- Gambeson of Sargeras' Corruption
				{ 9,  152680 }, -- Handwraps of Inevitable Doom
				{ 10, 152686 }, -- Nascent Deathbringer's Clutches
				{ 12, 155846 }, -- Miniaturized Cosmic Beacon
				{ 13, 155847 }, -- Cruor of the Avenger
				{ 14, 155848 }, -- Condensed Blight Orb
				{ 15, 155849 }, -- Flickering Ember of Rage
				{ 16, 155850 }, -- Rime of the Spirit Realm
				{ 17, 155851 }, -- Reorigination Spark
				{ 18, 155852 }, -- Volatile Soul Fragment
				{ 19, 155853 }, -- Conch of the Thunderer
				{ 20, 155854 }, -- Root of the Lifebinder
				{ 21, 155855 }, -- Mote of the Forgemaster
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
				{ 23, 154172 }, -- Aman'Thul's Vision
				{ 24, 154173 }, -- Aggramar's Conviction
				{ 25, 154174 }, -- Golganneth's Vitality
				{ 26, 154175 }, -- Eonar's Compassion
				{ 27, 154176 }, -- Khaz'goroth's Courage
				{ 28, 154177 }, -- Norgannon's Prowess
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 30, 152789 }, -- Shackled Ur'zul
			},
		},
		{ --Tier 21 Sets
			name = format(AL["Tier %d Sets"], 21),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:21",
		},
	},
}

data["BrokenIsles"] = {
	EncounterJournalID = 822,
	MapID = 619,
	ItemBaseLvl = 172,
	AtlasMapID = "OR_BrokenIsles",
	ContentType = RAID_CONTENT,
	items = {
		{ --Ana-Mouz
			EncounterJournalID = 1790,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141423 }, -- Crop Top Chain Hauberk
				{ 2, 141486 }, -- Demonic Birthstone Ring
				{ 3, 141419 }, -- Skimpy Demonleather Tunic
				{ 4, 141413 }, -- Low-Cut Chestplate
				{ 5, 141427 }, -- Sheer Felthreaded Robe
				{ 6, 141448 }, -- Imp Mother's Loincloth
				{ 8, 141520 }, -- Imp-Eye Diamond
				-- { 16, "ac9423" },
			},
		},
		{ --Calamir
			EncounterJournalID = 1774,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141437 }, -- Warboots of Smoldering Fury
				{ 2, 141432 }, -- Frostburned Sabatons
				{ 3, 141430 }, -- Mana-Tanned Sandals
				{ 4, 141533 }, -- Ring of Frozen Magic
				{ 5, 141443 }, -- Sandals of Frozen Ash
				{ 6, 141438 }, -- Pendant of Cold Flame
				{ 8, 141522 }, -- Calamir's Jaw
				--{ 24, "ac9425" },
			},
		},
		{ --Drugon the Frostblood
			EncounterJournalID = 1789,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141535 }, -- Ettin Fingernail
				{ 2, 141439 }, -- Ettinbone Bracers
				{ 3, 141538 }, -- Giant's Handkerchief
				{ 4, 141428 }, -- Snowdrift Bracers
				{ 5, 141429 }, -- Wax-Sealed Leather Bracers
				{ 6, 141433 }, -- Assorted Dragonscale Bracers
				{ 8, 141517 }, -- Drugon's Snowglobe
				-- { 16, "ac9423" },
			},
		},
		{ --Flotsam
			EncounterJournalID = 1795,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141466 }, -- Blackwater Raider Handguards
				{ 2, 141475 }, -- Salt-Stained Tuskarr Gloves
				{ 3, 141539 }, -- Ragged Azsharan Sail Fragment
				{ 4, 141470 }, -- Faded Bloodsail Handwraps
				{ 5, 141544 }, -- Marshstomper Oracle's Loop
				{ 6, 141476 }, -- Kezan Pirate's Mitts
				{ 8, 141516 }, -- "Liberated" Un'goro Relic
				-- { 16, "ac9423" },
			},
		},
		{ --Humongris
			EncounterJournalID = 1770,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141416 }, -- Padawsen's Squished Pauldrons
				{ 2, 141536 }, -- Padawsen's Unlucky Charm
				{ 3, 141426 }, -- Shoulderplates of Oversized Sorcery
				{ 4, 141445 }, -- Mantle of the Aspiring Spellgiant
				{ 5, 141540 }, -- Coerced Wizard's Cloak
				{ 6, 141422 }, -- Shoulderguards of Unimaginative Magic
				{ 8, 141521 }, -- Sea Giant Toothpick Fragment
				-- { 16, "ac9423" },
			},
		},
		{ --Levantus
			EncounterJournalID = 1769,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141431 }, -- Hook-Fingered Gauntlets
				{ 2, 141440 }, -- Seaweed "Leather" Mitts
				{ 3, 141441 }, -- Chum-Chopper Gauntlets
				{ 4, 141435 }, -- Whirlpool Gloves
				{ 5, 141545 }, -- Ring of Deep Sea Pearls
				{ 6, 141473 }, -- Krakentooth Necklace
				{ 8, 141523 }, -- Fel-Scented Bait
				--{ 22, "ac9423" },
			},
		},
		{ --Na'zak the Fiend
			EncounterJournalID = 1783,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141425 }, -- Avalanche Resistant Legplates
				{ 2, 141488 }, -- Mana-Dowsing Ring
				{ 3, 141534 }, -- Loop of Polished Pebbles
				{ 4, 141421 }, -- Venomscarred Chain Leggings
				{ 5, 141415 }, -- Na'zak's Dusty Pantaloons
				{ 6, 141417 }, -- Dessicated Leather Pants
				{ 8, 141515 }, -- Leystone Nugget
				-- { 16, "ac9423" },
			},
		},
		{ --Nithogg
			EncounterJournalID = 1749,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141424 }, -- Stormbattered Casque
				{ 2, 141418 }, -- Helm of the Mountain Recluse
				{ 3, 141546 }, -- Cursed Warden's Keepsake
				{ 4, 141420 }, -- Coif of Unstable Discharge
				{ 5, 141541 }, -- Windwhipped Greatcloak
				{ 6, 141414 }, -- Hood of Scorned Brood
				{ 8, 141519 }, -- Pillaged Titan Disc
				-- { 16, "ac9423" },
			},
		},
		{ --Shar'thos
			EncounterJournalID = 1763,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141542 }, -- Despoiled Dreamthread Cloak
				{ 2, 141487 }, -- Tunic of Waking Nightmares
				{ 3, 141481 }, -- Chestplate of Blackened Emeralds
				{ 4, 141547 }, -- Choker of Dreamthorns
				{ 5, 141495 }, -- Robe of Fever Dreams
				{ 6, 141491 }, -- Hauberk of the Snarled Vale
				{ 8, 141518 }, -- Decaying Dragonfang
				-- { 16, "ac9423" },
			},
		},
		{ --The Soultakers
			EncounterJournalID = 1756,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141444 }, -- Hel-Cursed Belt
				{ 2, 141537 }, -- Thrice-Accursed Compass
				{ 3, 141436 }, -- Helchain Waistguard
				{ 4, 141434 }, -- Cord of Kept Souls
				{ 5, 141442 }, -- Sea-Reaver's Girdle
				{ 6, 141506 }, -- Soultrapper's Pendant
				{ 8, 141514 }, -- Barnacled Mistcaller Orb
				--{ 16, "ac9423" },
			},
		},
		{ --Withered J'im
			EncounterJournalID = 1796,
			[NORMAL_RAID_DIFF] = {
				{ 1, 141459 }, -- Manacrystal-Adorned Helmet
				{ 2, 141453 }, -- Magic-Warped Hood
				{ 3, 141482 }, -- Unstable Arcanocrystal
				{ 4, 141455 }, -- Cave Skulker's Helm
				{ 5, 141449 }, -- Mana Scavenger's Mask
				{ 6, 141492 }, -- Dingy Suramar Mercantile Signet
				{ 7, 141543 }, -- Drape of the Mana-Starved
				-- { 16, "ac9423" },
			},
		},
		{ -- Brutallus
			EncounterJournalID = 1883,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147742 }, -- Violent Zealot's Shoulderpads
				{ 2,  147748 }, -- Gauntlets of Dreadful Tenacity
				{ 3,  147765 }, -- Clasp of Burning Demise
				{ 4,  147739 }, -- Rigid Meteorguard Gauntlets
				{ 5,  147747 }, -- Armbands of Crude Strategy
				{ 6,  147749 }, -- Polished Felfury Helmet
				{ 7,  147732 }, -- Leggings of Echoing Calamity
				{ 9,  147756 }, -- Crashing Ember
				{ 10, 147755 }, -- Brutallus's Wretched Heart
			},
		},
		{ -- Malificus
			EncounterJournalID = 1884,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147744 }, -- Treads of Disorderly Retreat
				{ 2,  147733 }, -- Doomsayer's Ritualistic Vestment
				{ 3,  147735 }, -- Cuffs of Fearful Service
				{ 4,  147741 }, -- Legguards of Unholy Disdain
				{ 5,  147745 }, -- Taloned Brain-Scrapers
				{ 6,  147764 }, -- Cloak of Growing Mistrust
				{ 7,  147740 }, -- Plague-Resistant Headcover
				{ 8,  147750 }, -- Malicious Zealot's Legplates
				{ 10, 147754 }, -- Gory Dreadlord Horn
				{ 11, 147758 }, -- Beguiling Revelation
			},
		},
		{ -- Si'vash
			EncounterJournalID = 1885,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147731 }, -- Cowl of Plumbed Depths
				{ 2,  147767 }, -- Coral Band of the Abyss
				{ 3,  147737 }, -- Shorebreaker Robes
				{ 4,  147751 }, -- Si'vashi Guard's Breastplate
				{ 5,  147752 }, -- Pauldrons of the Engulfing Tide
				{ 6,  147746 }, -- Glistening Seaspray Legguards
				{ 7,  147736 }, -- Dockthrasher Cinch
				{ 9,  147757 }, -- Globule of Submersion
				{ 10, 147761 }, -- Sandblasted Conch
			},
		},
		{ -- Apocron
			EncounterJournalID = 1956,
			[NORMAL_RAID_DIFF] = {
				{ 1, 147730 }, -- Ashen Worldscorcher Gloves
				{ 2, 147766 }, -- Band of Dark Millennia
				{ 3, 147734 }, -- Spaulders of Forgotten Worlds
				{ 4, 147738 }, -- Doom-Herald's Footpads
				{ 5, 147743 }, -- Harness of Devouring Flame
				{ 6, 147753 }, -- Reaver's Rattling Girdle
				{ 8, 147759 }, -- Charged Felfire Casing
				{ 9, 147760 }, -- Apocron's Energy Core
			},
		},
		LEGION_WORLD_BOSS_AC_TABLE,
		LEGION_WORLD_BOSS_AC_TABLE2,
	}
}

data["TheEmeraldNightmare"] = {
	EncounterJournalID = 768,
	MapID = 777,
	ItemBaseLvl = 168,
	AtlasMapID = "TheEmeraldNightmareA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ --Nythendra
			EncounterJournalID = 1703,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: Buggy Fight in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  139224 }, -- Insect-Etched Chestplate
				{ 2,  139320 }, -- Ravaged Seed Pod
				{ 3,  139200 }, -- Stained Maggot Squishers
				{ 4,  139235 }, -- Wristclamps of Mad Dreams
				{ 5,  139197 }, -- Lifeless Buckled Girdle
				{ 6,  139212 }, -- Creeping String of Larva
				{ 7,  139214 }, -- Greyed Dragonscale Coif
				{ 8,  139321 }, -- Swarming Plaguehive
				{ 9,  139236 }, -- Grubby Silver Ring
				{ 10, 139191 }, -- Ancient Dreamwoven Mantle
				{ 12, 139252 }, -- Preserved Worldseed
				{ 13, 139249 }, -- Shaladrassil's Blossom
				{ 14, 139251 }, -- Despoiled Dragonscale
				{ 15, 139250 }, -- Unwaking Slumber
				{ 16, "ac10555" }, -- AC: Buggy Fight
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac10821" }, -- AC: Mythic: Nythendra
			},
		},
		{ --Il'gynoth, Heart of Corruption
			EncounterJournalID = 1738,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 19, nil }, -- ignore the AC: Took the Red Eye Down in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  139237 }, -- Dreadful Cyclopean Signet
				{ 2,  139326 }, -- Wriggling Sinew
				{ 3,  139215 }, -- Singular Chain Leggings
				{ 4,  139202 }, -- Dreamsculptor's Gloves
				{ 5,  139324 }, -- Goblet of Nightmarish Ichor
				{ 6,  139206 }, -- Otherworldy Leather Mantle
				{ 7,  139227 }, -- Waistplate of Nameless Horror
				{ 8,  139188 }, -- Celestially Aligned Hood
				{ 9,  139213 }, -- Gauntlets of Malevolent Intent
				{ 10, 139233 }, -- Pauldrons of Shifting Runes
				{ 11, 139325 }, -- Spontaneous Appendages
				{ 12, 139187 }, -- Cinch of Cosmic Insignficance
				{ 14, 139256 }, -- Sloshing Core of Hatred
				{ 15, 139258 }, -- Radiating Metallic Shard
				{ 16, 139257 }, -- Gore-Drenched Fetish
				{ 17, 139259 }, -- Cube of Malice
				{ 19, "ac10830" }, -- AC: Took the Red Eye Down
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 20, "ac10823" }, -- AC: Mythic: Il'gynoth
			},
		},
		{ --Elerethe Renferal
			EncounterJournalID = 1744,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: Webbing Crashers in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  138217 }, -- Pliable Spider Silk Cinch
				{ 2,  139209 }, -- Wristwraps of Broken Trust
				{ 3,  138221 }, -- Gossamer-Spun Greatcloak
				{ 4,  139230 }, -- Storm-Battered Legplates
				{ 5,  139322 }, -- Cocoon of Enforced Solitude
				{ 6,  139204 }, -- Mask of Multitudinous Eyes
				{ 7,  139221 }, -- Patient Ambusher's Hauberk
				{ 8,  139229 }, -- Venom-Fanged Barbute
				{ 9,  139219 }, -- Black Venom Sabatons
				{ 10, 139323 }, -- Twisting Wind
				{ 11, 139190 }, -- Ragged Horrorweave Leggings
				{ 13, 139254 }, -- Shrieking Bloodstone
				{ 14, 139253 }, -- Fel-Bloated Venom Sac
				{ 15, 139255 }, -- Scything Quill
				{ 16, "ac10771" }, -- AC: Webbing Crashers
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac10822" }, -- AC: Mythic: Elerethe Renferal
			},
		},
		{ --Ursoc
			EncounterJournalID = 1667,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 19, nil }, -- ignore the AC: Scare Bear in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  139327 }, -- Unbridled Fury
				{ 2,  139239 }, -- Cursed Beartooth Necklace
				{ 3,  139196 }, -- Ragged Fur Wristwraps
				{ 4,  139328 }, -- Ursoc's Rending Paw
				{ 5,  139217 }, -- Matted Fur Pauldrons
				{ 6,  139234 }, -- Trampling Warboots
				{ 7,  139330 }, -- Heightened Senses
				{ 8,  139208 }, -- Scarred Ragefang Chestpiece
				{ 9,  139195 }, -- Crimson Wool-Lined Slippers
				{ 10, 139329 }, -- Bloodthirsty Instinct
				{ 11, 139201 }, -- Splotched Bloodfur Leggings
				{ 12, 139220 }, -- Scored Ironclaw Sabatons
				{ 13, 139226 }, -- Primal Gauntlets of Rage
				{ 15, 139260 }, -- Bloodied Bear Fang
				{ 16, 139261 }, -- Tuft of Ironfur
				{ 17, 139262 }, -- Reverberating Femur
				{ 19, "ac10753" }, -- AC: Scare Bear
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 20, "ac10824" }, -- AC: Mythic: Ursoc
			},
		},
		{ --Dragons of Nightmare, Ysondre
			EncounterJournalID = 1704,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 20, nil }, -- ignore the AC: Imagined Dragons World Tour in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  138219 },  -- Dragonspur Wristguards
				{ 2,  138212 },  -- Handwraps of Delusional Power
				{ 3,  138215 },  -- Dreamscale Inlaid Vestments
				{ 4,  138225 },  -- Phantasmal Echo
				{ 5,  138214 },  -- Gauntlets of the Demented Mind
				{ 6,  138216 },  -- Horror Inscribed Chestguard
				{ 7,  138218 },  -- Dragonbone Wristclamps
				{ 8,  138220 },  -- Mindrend Band
				{ 9,  138222 },  -- Vial of Nightmare Fog
				{ 10, 138224 },  -- Unstable Horrorslime
				{ 11, 138211 },  -- Malignant Sabatons
				{ 12, 139205 },  -- Cowl of Fright
				{ 14, 138226 },  -- Nightmare Engulfed Jewel
				{ 15, 138227 },  -- Entrancing Stone
				{ 16, 138228 },  -- Bioluminescent Mushroom
				{ 18, 136903,   "pet1723" }, -- Nightmare Whelpling
				{ 20, "ac10663" }, -- AC: Imagined Dragons World Tour
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 21, "ac10825" }, -- AC: Mythic: Dragons of Nightmare
			},
		},
		{ --Cenarius
			EncounterJournalID = 1750,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: Use the Force(s) in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  139207 }, -- Tunic of the Grove Keeper
				{ 2,  139194 }, -- Cozy Dryad Hoof-Socks
				{ 3,  139211 }, -- Laughing Sister's Pouch-Chain
				{ 4,  139333 }, -- Horn of Cenarius
				{ 5,  139192 }, -- Mantle of Perpetual Bloom
				{ 6,  139225 }, -- Fitted Ironbark Gauntlets
				{ 7,  139248 }, -- Evergreen Vinewrap Drape
				{ 8,  139334 }, -- Nature's Call
				{ 9,  139231 }, -- Crown of Steely Brambles
				{ 10, 139218 }, -- Thorny Bramblemail Pauldrons
				{ 11, 139198 }, -- Forest-Lord's Waistwrap
				{ 13, 139264 }, -- Uplifting Emerald
				{ 14, 139263 }, -- Blessing of Cenarius
				{ 15, 139265 }, -- Radiant Dragon Egg
				{ 16, "ac10772" }, -- AC: Use the Force(s)
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac10826" }, -- AC: Mythic: Cenarius
			},
		},
		{ --Xavius
			EncounterJournalID = 1726,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 20, nil }, -- ignore the AC: I Attack the Darkness in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  139332 }, -- Blackened Portalstone Necklace
				{ 2,  139336 }, -- Bough of Corruption
				{ 3,  139216 }, -- Disjointed Linkage Leggings
				{ 4,  139189 }, -- Hood of Darkened Visions
				{ 5,  139193 }, -- Maddening Robe of Secrets
				{ 6,  139228 }, -- Eon-Tempered Waistplate
				{ 7,  139232 }, -- Midnight Herald's Pauldrons
				{ 8,  139222 }, -- Manacles of the Nightmare Colossus
				{ 9,  139199 }, -- Boots of Endless Betrayal
				{ 10, 139203 }, -- Repulsive Leathery Pants
				{ 11, 139238 }, -- Twice-Warped Azsharan Signet
				{ 12, 139335 }, -- Grotesque Statuette
				{ 13, 141006 }, -- The First Satyr's Spaulders
				{ 15, 139266 }, -- Fragment of Eternal Spite
				{ 16, 139267 }, -- Azsharan Councillor's Clasp
				{ 17, 139268 }, -- Nightmarish Elm Branch
				{ 18, 139269 }, -- Crystallized Drop of Eternity
				{ 20, "ac10755" }, -- AC: I Attack the Darkness
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 21, "ac10827" }, -- AC: Mythic: Xavius
			},
		},
		LEGION_RAID1_AC_TABLE,
	},
}

-- Invasion Points
data["InvasionPoints"] = {
	EncounterJournalID = 959,
	--MapID = 830,
	MapID = 929,
	--AtlasMapID = "InvasionPoints",
	ContentType = RAID_CONTENT,
	items = {
		{ -- Matron Folnuna
			EncounterJournalID = 2010,
			[NORMAL_RAID_DIFF] = {
				{ 1,  152349 }, -- Nefarious Light-Step Slippers
				{ 2,  152372 }, -- Waistguard of Devilish Deeds
				{ 3,  152359 }, -- Vile Drifter's Footpads
				{ 4,  152376 }, -- Crown of Burning Resolve
				{ 5,  152375 }, -- Gauntlets of Barbaric Cruelty
				{ 6,  152380 }, -- Waistguard of Fel Magics
				{ 7,  152356 }, -- Fel-Absorbant Wristbands
				{ 8,  152369 }, -- Helm of the Vigilant Eye
				{ 9,  152371 }, -- Shoulderguards of the Despondent Masses
				{ 10, 152358 }, -- Imp-Overseer's Vest
				{ 11, 152360 }, -- Gloves of Barbarous Feats
				{ 12, 152354 }, -- Accursed Defiler's Mantle
				{ 14, 152053 }, -- Essence of the Burgeoning Brood
				{ 15, 152346 }, -- Frigid Earing
			},
		},
		{ -- Mistress Alluradel
			EncounterJournalID = 2011,
			[NORMAL_RAID_DIFF] = {
				{ 1,  152362 }, -- Leggings of Heinous Acts
				{ 2,  152379 }, -- Spaulders of Vile Determination
				{ 3,  152366 }, -- Enthralling Chain Armor
				{ 4,  152372 }, -- Waistguard of Devilish Deeds
				{ 5,  152374 }, -- Soul Crushing Stompers
				{ 6,  152378 }, -- Breastplate of Terminal End
				{ 7,  152363 }, -- Fel-Spike Shoulderpads
				{ 8,  152364 }, -- Cinch of Detestable Guile
				{ 9,  152351 }, -- Mesmerizing Soul Hood
				{ 10, 152354 }, -- Accursed Defiler's Mantle
				{ 11, 152373 }, -- Poison-Barbed Bracers
				{ 12, 152349 }, -- Nefarious Light-Step Slippers
				{ 14, 152294 }, -- Fel Mistress' Brand
				{ 15, 152030 }, -- Scourge of Perverse Desire
			},
		},
		{ -- Inquisitor Meto
			EncounterJournalID = 2012,
			[NORMAL_RAID_DIFF] = {
				{ 1,  152364 }, -- Cinch of Detestable Guile
				{ 2,  152381 }, -- Tainted Corruptor's Vambraces
				{ 3,  152353 }, -- Robes of Demonic Purpose
				{ 4,  152370 }, -- Legguards of Doomed Chattel
				{ 5,  152361 }, -- Horned Hood of Retaliation
				{ 6,  152378 }, -- Breastplate of Terminal End
				{ 7,  152368 }, -- Fel-Linked Crushers
				{ 8,  152350 }, -- Gloves of Grim Direction
				{ 9,  152371 }, -- Shoulderguards of the Despondent Masses
				{ 10, 152380 }, -- Waistguard of Fel Magics
				{ 11, 152349 }, -- Nefarious Light-Step Slippers
				{ 12, 152359 }, -- Vile Drifter's Footpads
				{ 14, 152344 }, -- Meto's Orb of Entropy
				{ 15, 152290 }, -- Censer of Dark Intent
			},
		},
		{ -- Occularus
			EncounterJournalID = 2013,
			[NORMAL_RAID_DIFF] = {
				{ 1,  152377 }, -- Gore-Soaked Legplates
				{ 2,  152381 }, -- Tainted Corruptor's Vambraces
				{ 3,  152355 }, -- Sash of Diabolic Preparation
				{ 4,  152374 }, -- Soul Crushing Stompers
				{ 5,  152351 }, -- Mesmerizing Soul Hood
				{ 6,  152354 }, -- Accursed Defiler's Mantle
				{ 7,  152367 }, -- Sabatons of Ceaseless Assault
				{ 8,  152369 }, -- Helm of the Vigilant Eye
				{ 9,  152358 }, -- Imp-Overseer's Vest
				{ 10, 152373 }, -- Poison-Barbed Bracers
				{ 11, 152360 }, -- Gloves of Barbarous Feats
				{ 13, 152347 }, -- Occularus' Unblemished Lens
			},
		},
		{ -- Sotanathor
			EncounterJournalID = 2014,
			[NORMAL_RAID_DIFF] = {
				{ 1,  152377 }, -- Gore-Soaked Legplates
				{ 2,  152379 }, -- Spaulders of Vile Determination
				{ 3,  152366 }, -- Enthralling Chain Armor
				{ 4,  152353 }, -- Robes of Demonic Purpose
				{ 5,  152372 }, -- Waistguard of Devilish Deeds
				{ 6,  152361 }, -- Horned Hood of Retaliation
				{ 7,  152365 }, -- Bracers of Diabolic Fury
				{ 8,  152368 }, -- Fel-Linked Crushers
				{ 9,  152362 }, -- Leggings of Heinous Acts
				{ 10, 152350 }, -- Gloves of Grim Direction
				{ 11, 152375 }, -- Gauntlets of Barbaric Cruelty
				{ 12, 152352 }, -- Subjugated Drudge's Leggings
				{ 14, 152348 }, -- Sotanathor's Thundring Hoof
				{ 15, 152292 }, -- Spike of Immortal Command
			},
		},
		{ -- Pit Lord Vilemus
			EncounterJournalID = 2015,
			[NORMAL_RAID_DIFF] = {
				{ 1,  152368 }, -- Fel-Linked Crushers
				{ 2,  152370 }, -- Legguards of Doomed Chattel
				{ 3,  152355 }, -- Sash of Diabolic Preparation
				{ 4,  152374 }, -- Soul Crushing Stompers
				{ 5,  152376 }, -- Crown of Burning Resolve
				{ 6,  152363 }, -- Fel-Spike Shoulderpads
				{ 7,  152365 }, -- Bracers of Diabolic Fury
				{ 8,  152352 }, -- Subjugated Drudge's Leggings
				{ 9,  152356 }, -- Fel-Absorbant Wristbands
				{ 10, 152378 }, -- Breastplate of Terminal End
				{ 11, 152360 }, -- Gloves of Barbarous Feats
				{ 12, 152367 }, -- Sabatons of Ceaseless Assault
				{ 14, 152345 }, -- Vilemus' Bile
			},
		},
	},
}

data["TheNighthold"] = {
	EncounterJournalID = 786,
	MapID = 764,
	ItemBaseLvl = 176,
	AtlasMapID = "TheNightholdA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ --Skorpyron
			EncounterJournalID = 1706,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: Cage Rematch in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140902 }, -- Jagged Carapace Wristclamps
				{ 2,  140876 }, -- Stinger Resistant Bracers
				{ 3,  140790 }, -- Claw of the Crystalline Scorpid
				{ 4,  140789 }, -- Animated Exoskeleton
				{ 5,  140884 }, -- Leystone-Toe Kickers
				{ 6,  140901 }, -- Vintage Suramar Nobility Hat
				{ 7,  140888 }, -- Scorpid Handler's Gloves
				{ 8,  140875 }, -- Arcanochitin Hauberk
				{ 9,  140862 }, -- Gnawed Nightfallen Britches
				{ 10, 140849 }, -- Antiquated Highborne Cinch
				{ 11, 140898 }, -- Radiant String of Scorpid Eyes
				{ 13, 140815 }, -- Infused Chitin Fragment
				{ 14, 140840 }, -- Chittering Mandible
				{ 15, 140827 }, -- Manatoxin Gland
				{ 16, "ac10678" }, -- AC: Cage Rematch
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac10840" }, -- AC: Mythic: Skorpyron
			},
		},
		{ --Chronomatic Anomaly
			EncounterJournalID = 1725,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 18, nil }, -- ignore the AC: Grand Opening in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140872 },                                  -- Pauldrons of Warped Memory
				{ 2,  140848 },                                  -- Robes of Fluctuating Energy
				{ 3,  140882 },                                  -- Chrono-Tempered Legplates
				{ 4,  140792 },                                  -- Erratic Metronome
				{ 5,  140863 },                                  -- Temporally Displaced Gloves
				{ 6,  140853 },                                  -- Chaos-Scarred Mantle
				{ 7,  140903 },                                  -- Hood of Fading Opportunity
				{ 8,  140860 },                                  -- Stutterstep Treads
				{ 9,  140791 },                                  -- Royal Dagger Haft
				{ 10, 140879 },                                  -- Gauntlets of Fractured Eons
				{ 11, 140894 },                                  -- Zealous Timestone Pendant
				{ 12, 138828,   false, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Illusion: Chronos
				{ 14, 140831 },                                  -- Suspended Nightwell Droplet
				{ 15, 140821 },                                  -- Precipice of Eternity
				{ 16, 140843 },                                  -- Flickering Timespark
				{ 18, "ac10697" },                               -- AC: Grand Opening
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 19, "ac10842" }, -- AC: Mythic: Chronomatic Anomaly
			},
		},
		{ --Trilliax
			EncounterJournalID = 1731,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 28, nil }, -- ignore the AC: Gluten Free in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  138367 }, -- Cloak of Enveloped Dissonance
				{ 2,  140851 }, -- Nighthold Custodian's Hood
				{ 3,  140793 }, -- Perfectly Preserved Cake
				{ 4,  140871 }, -- Pertinacious Legplates
				{ 5,  138364 }, -- Dreadwyrm Greatcloak
				{ 6,  138368 }, -- Eagletalon Cloak
				{ 7,  138372 }, -- Cloak of Bound Elements
				{ 8,  140794 }, -- Arcanogolem Digit
				{ 9,  138375 }, -- Cape of Second Sight
				{ 10, 138371 }, -- Doomblade Shadowwrap
				{ 11, 140854 }, -- Perpetually Muddy Sandals
				{ 12, 138365 }, -- Cloak of Everburning Knowledge
				{ 13, 140880 }, -- Gilded Nightborne Waistplate
				{ 14, 138373 }, -- Cloak of Azj'Aqir
				{ 15, 138369 }, -- Greatmantle of the Highlord
				{ 16, 140869 }, -- Sterilizer's Insulated Gauntlets
				{ 17, 140865 }, -- Tunic of Unwavering Devotion
				{ 18, 140904 }, -- Immaculately Polished Boots
				{ 19, 138366 }, -- Cloak of the Astral Warden
				{ 20, 138370 }, -- Purifier's Drape
				{ 21, 138374 }, -- Greatcloak of the Obsidian Aspect
				{ 22, 140858 }, -- Cake Carrier's Girdle
				{ 24, 140812 }, -- Soggy Manascrubber Brush
				{ 25, 140838 }, -- Construct Personality Sphere
				{ 26, 140818 }, -- Foreign Contaminant
				{ 28, "ac10742" }, -- AC: Gluten Free
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 29, "ac10843" }, -- AC: Mythic: Trilliax
			},
		},
		{ --Spellblade Aluriel
			EncounterJournalID = 1751,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: A Change In Scenery in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140852 }, -- Master Warmage's Leggings
				{ 2,  140878 }, -- Duskwatch Plate Bracers
				{ 3,  140895 }, -- Spellblade's Gemmed Signet
				{ 4,  140867 }, -- Sabatons of Burning Steps
				{ 5,  140796 }, -- Entwined Elemental Foci
				{ 6,  140905 }, -- Gloves of Synchronus Elements
				{ 7,  140877 }, -- Captain's Parade Breastplate
				{ 8,  140866 }, -- Nightborne Battle-Magus Hood
				{ 9,  140868 }, -- Emblazoned Duskwatch Belt
				{ 10, 140795 }, -- Aluriel's Mirror
				{ 11, 140850 }, -- Bracers of Harnessed Flame
				{ 13, 140832 }, -- Heart of Frost
				{ 14, 140813 }, -- Arcana Crux
				{ 15, 140834 }, -- Soul of Flame
				{ 16, "ac10817" }, -- AC: A Change In Scenery
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac10844" }, -- AC: Mythic: Spellblade Aluriel
			},
		},
		{ --Tichondrius
			EncounterJournalID = 1762,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, nil }, -- ignore the AC: Not For You in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  138363 }, -- Shoulderplates of the Obsidian Aspect
				{ 2,  138336 }, -- Mantle of the Astral Warden
				{ 3,  140855 }, -- Dreadlord's Tattered Wingcover
				{ 4,  138348 }, -- Pauldrons of Bound Elements
				{ 5,  138321 }, -- Mantle of Everburning Knowledge
				{ 6,  138337 }, -- Pauldrons of Enveloped Dissonance
				{ 7,  138380 }, -- Shoulderguards of Second Sight
				{ 8,  138322 }, -- Purifier's Mantle
				{ 9,  138361 }, -- Dreadwyrm Shoulderguards
				{ 10, 138338 }, -- Doomblade Spaulders
				{ 11, 140798 }, -- Icon of Rot
				{ 12, 140892 }, -- Goresmeared Abyssal Waistplate
				{ 13, 138323 }, -- Pauldrons of Azj'Aqir
				{ 14, 140797 }, -- Fang of Tichcondrius
				{ 15, 138362 }, -- Pauldrons of the Highlord
				{ 16, 140906 }, -- Ring of Exclusive Servitude
				{ 17, 140859 }, -- Girdle of Nefarious Strategy
				{ 18, 138347 }, -- Eagletalon Spaulders
				{ 20, 140844 }, -- Archaic Nathrezim Keepsake
				{ 21, 140819 }, -- Vampiric Fetish
				{ 22, 140824 }, -- Writ of Subjugation
				{ 24, "ac10704" }, -- AC: Not For You
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac10847" }, -- AC: Mythic: Tichondrius
			},
		},
		{ --Krosus
			EncounterJournalID = 1713,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, nil }, -- ignore the AC: Burning Bridges in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  138320 }, -- Finery of Azj'Aqir
				{ 2,  140870 }, -- Architect's Coif of Despair
				{ 3,  138325 }, -- Tunic of Enveloped Dissonance
				{ 4,  138318 }, -- Robe of Everburning Knowledge
				{ 5,  140899 }, -- Beleron's Choker of Misery
				{ 6,  138376 }, -- Tunic of Second Sight
				{ 7,  140907 }, -- Bridgebreaker Gauntlets
				{ 8,  140800 }, -- Pharamere's Forbidden Grimore
				{ 9,  140887 }, -- Man'ari Skullbuckled Cinch
				{ 10, 138346 }, -- Raiment of Shackled Elements
				{ 11, 138350 }, -- Breastplate of the Highlord
				{ 12, 138324 }, -- Robe of the Astral Warden
				{ 13, 140857 }, -- Well-Flattened Wristguards
				{ 14, 138319 }, -- Purifier's Cassock
				{ 15, 138326 }, -- Doomblade Tunic
				{ 16, 138339 }, -- Eagletalon Tunic
				{ 17, 140799 }, -- Might of Krosus
				{ 18, 138351 }, -- Chestplate of the Obsidian Aspect
				{ 19, 138349 }, -- Dreadwyrm Breastplate
				{ 21, 140835 }, -- Unkindled Ember
				{ 22, 140816 }, -- Fingernail of the Fel Brute
				{ 23, 140825 }, -- Felfire Pitch
				{ 25, "ac10575" }, -- AC: Burning Bridges
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 26, "ac10848" }, -- AC: Mythic: Krosus
			},
		},
		{ --High Botanist Tel'arn
			EncounterJournalID = 1761,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: Fruit of All Evil in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140874 }, -- Thistle-Proof Thorngrabbers
				{ 2,  140861 }, -- Grove-Tender's Moccasins
				{ 3,  140908 }, -- Trousers of Cultivation
				{ 4,  140886 }, -- Woven Lasher Tendril Bracers
				{ 5,  140873 }, -- Shal'dorei Weedstompers
				{ 6,  140802 }, -- Nightblooming Frond
				{ 7,  140801 }, -- Fury of the Burning Sky
				{ 8,  140881 }, -- Eventide Casque
				{ 9,  140883 }, -- Shoulderguard of the Eclipse
				{ 10, 140896 }, -- Ring of Braided Stems
				{ 12, 140836 }, -- Sunflare Coal
				{ 13, 140822 }, -- Breath of Dusk
				{ 14, 140839 }, -- Parasitic Spore
				{ 16, "ac10754" }, -- AC: Fruit of All Evil
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac10846" }, -- AC: Mythic: High Botanist Tel'arn
			},
		},
		{ --Star Augur Etraeus
			EncounterJournalID = 1732,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, nil }, -- ignore the AC: Elementalry! in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140804 }, -- Star Gate
				{ 2,  138328 }, -- Gloves of Enveloped Dissonance
				{ 3,  140909 }, -- Astromancer's Greatcloak
				{ 4,  138340 }, -- Eagletalon Gauntlets
				{ 5,  138352 }, -- Dreadwyrm Gauntlets
				{ 6,  138329 }, -- Doomblade Gauntlets
				{ 7,  138341 }, -- Gauntlets of Bound Elements
				{ 8,  140891 }, -- Sabatons of Unchanging Fate
				{ 9,  140864 }, -- Mantle of the Torn Sky
				{ 10, 138311 }, -- Clutch of Azj'Aqir
				{ 11, 138377 }, -- Gloves of Second Sight
				{ 12, 138354 }, -- Gauntlets of the Obsidian Aspect
				{ 13, 140803 }, -- Etraeus' Celestial Map
				{ 14, 140900 }, -- Brooch of the Astral Scryer
				{ 15, 138310 }, -- Purifier's Gloves
				{ 16, 138327 }, -- Gloves of the Astral Warden
				{ 17, 140885 }, -- Treads of Galactic Odyssey
				{ 18, 138309 }, -- Gloves of Everburning Knowledge
				{ 19, 138353 }, -- Gauntlets of the Highlord
				{ 21, 140841 }, -- Tempest of the Heavens
				{ 22, 140845 }, -- Glistening Meteorite Shard
				{ 23, 140833 }, -- Sundered Comet
				{ 25, "ac10851" }, -- AC: Elementalry!
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 26, "ac10845" }, -- AC: Mythic: Star Augur Etraeus
			},
		},
		{ --Grand Magistrix Elisande
			EncounterJournalID = 1743,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 26, nil }, -- ignore the AC: Infinitesimal in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140893 }, -- Eternally Recurring Bracers
				{ 2,  138355 }, -- Dreadwyrm Crown
				{ 3,  138332 }, -- Doomblade Cowl
				{ 4,  138313 }, -- Purifier's Gorget
				{ 5,  140890 }, -- Belt of Celestial Alignment
				{ 6,  140805 }, -- Ephemeral Paradox
				{ 7,  140910 }, -- Cloak of Temporal Recalibration
				{ 8,  138314 }, -- Eyes of Azj'Aqir
				{ 9,  140806 }, -- Convergence of Fates
				{ 10, 140911 }, -- Mantle of Prestidigitation
				{ 11, 138342 }, -- Eagletalon Cowl
				{ 12, 140889 }, -- Bracers of Impossible Choices
				{ 13, 138343 }, -- Helm of Bound Elements
				{ 14, 138330 }, -- Hood of the Astral Warden
				{ 15, 138331 }, -- Hood of Enveloped Dissonance
				{ 16, 138356 }, -- Helmet of the Highlord
				{ 17, 140912 }, -- Waistplate of Fractured Realities
				{ 18, 138312 }, -- Hood of Everburning Knowledge
				{ 19, 138378 }, -- Mask of Second Sight
				{ 20, 138357 }, -- Warhelm of the Obsidian Aspect
				{ 22, 140810 }, -- Farsight Spiritjewel
				{ 23, 140837 }, -- Exothermic Core
				{ 24, 140842 }, -- Collapsing Epoch
				{ 26, "ac10699" }, -- AC: Infinitesimal
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 27, "ac10849" }, -- AC: Mythic: Grand Magistrix Elisande
			},
		},
		{ --Gul'dan
			EncounterJournalID = 1737,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 27, nil }, -- ignore the AC: I've Got My Eyes On You in LFR
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  140897 }, -- Ring of the Scoured Clan
				{ 2,  138359 }, -- Legplates of the Highlord
				{ 3,  140913 }, -- Breastplate of the Remembered King
				{ 4,  138344 }, -- Eagletalon Legchains
				{ 5,  138317 }, -- Leggings of Azj'Aqir
				{ 6,  138360 }, -- Legplates of the Obsidian Aspect
				{ 7,  138333 }, -- Leggings of the Astral Warden
				{ 8,  140914 }, -- Outcast Wanderer's Footrags
				{ 9,  138345 }, -- Leggings of Bound Elements
				{ 10, 140809 }, -- Whispers in the Dark
				{ 11, 138334 }, -- Leggings of Enveloped Dissonance
				{ 12, 140919 }, -- High Shadow Councilor's Wrap
				{ 13, 138379 }, -- Legwraps of Second Sight
				{ 14, 140807 }, -- Infernal Contract
				{ 15, 138358 }, -- Dreadwyrm Legplates
				{ 16, 140917 }, -- Netherbranded Shoulderpads
				{ 17, 138335 }, -- Doomblade Pants
				{ 18, 138315 }, -- Leggings of Everburning Knowledge
				{ 19, 138316 }, -- Purifier's Leggings
				{ 20, 140808 }, -- Draught of Souls
				{ 22, 140817 }, -- Lionshead Lapel Clasp
				{ 23, 140820 }, -- Phial of Fel Blood
				{ 24, 140826 }, -- Felstained Jawbone Fragments
				{ 25, 140823 }, -- Warchief's Shattered Tusk
				{ 27, "ac10696" }, -- AC: I've Got My Eyes On You
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 28, "ac10850" }, -- AC: Mythic: Gul'dan
			},
		},
		{ --Tier 19 Sets
			name = format(AL["Tier %d Sets"], 19),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:19",
		},
		LEGION_RAID1_AC_TABLE,
	},
}

-- Tomb of Sargeras
data["TombofSargeras"] = {
	EncounterJournalID = 875,
	MapID = 850,
	ItemBaseLvl = 188,
	AtlasMapID = "TombofSargerasA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ -- Goroth
			EncounterJournalID = 1862,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147055 }, -- Belt of Screaming Slag
				{ 2,  147039 }, -- Cinch of Sizzling Flesh
				{ 3,  146984 }, -- Cloak of Stifling Brimstone
				{ 4,  146986 }, -- Emberscatter Treads
				{ 5,  147022 }, -- Feverish Carapace
				{ 6,  147009 }, -- Infernal Cinders
				{ 7,  147065 }, -- Lava-Slough Legguards
				{ 8,  146992 }, -- Legwraps of Fused Loathing
				{ 9,  147057 }, -- Pain-Singed Armguards
				{ 10, 147069 }, -- Shoulderplates of Crackling Flame
				{ 11, 147027 }, -- Spirebreaker Harness
				{ 13, 147108 }, -- Brand of Relentless Agony
				{ 14, 147076 }, -- Charred Hymnal of the Moon
				{ 15, 147112 }, -- Felsoul Vortex
				{ 16, 147104 }, -- Icon of Perverse Animation
				{ 17, 147084 }, -- Imploding Infernal Star
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Demonic Inquisition
			EncounterJournalID = 1867,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147003 }, -- Barbaric Mindslaver
				{ 2,  147073 }, -- Bonemeal-Crusted Armplates
				{ 3,  147035 }, -- Bonespur Studded Legwraps
				{ 4,  146998 }, -- Braided Torture Lash
				{ 5,  147010 }, -- Cradle of Anguish
				{ 6,  147147 }, -- Crown of the Arcane Tempest
				{ 7,  147130 }, -- Demonbane Faceguard
				{ 8,  147183 }, -- Diabolic Helm
				{ 9,  147172 }, -- Fanged Slayer's Helm
				{ 10, 147051 }, -- Flesh Raking Leggings
				{ 11, 147124 }, -- Gravewarden Visage
				{ 12, 147178 }, -- Helmet of the Skybreaker
				{ 13, 147165 }, -- Hood of Blind Absolution
				{ 14, 146996 }, -- Mantle of Broken Spirits
				{ 15, 147053 }, -- Pauldrons of the Gibbering Eye
				{ 16, 147160 }, -- Radiant Lightbringer Crown
				{ 17, 147041 }, -- Sinew-Stitched Wristguards
				{ 18, 147136 }, -- Stormheart Headdress
				{ 19, 147013 }, -- String of Extracted Incisors
				{ 20, 147190 }, -- Titanic Onslaught Greathelm
				{ 21, 147142 }, -- Wildstalker Helmet
				{ 22, 147154 }, -- Xuen's Helm
				{ 24, 147080 }, -- Blood of the Unworthy
				{ 25, 147077 }, -- Inexorable Truth Serum
				{ 26, 147096 }, -- Inquisition's Master Key
				{ 27, 147088 }, -- Smoldering Thumbscrews
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Harjatan
			EncounterJournalID = 1856,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147002 }, -- Charm of the Rising Tide
				{ 2,  147129 }, -- Demonbane Gauntlets
				{ 3,  147182 }, -- Diabolic Gloves
				{ 4,  147037 }, -- Dripping Arcfin Shoulderpads
				{ 5,  147171 }, -- Fanged Slayer's Handguards
				{ 6,  147029 }, -- Glacier Walkers
				{ 7,  147164 }, -- Gloves of Blind Absolution
				{ 8,  147146 }, -- Gloves of the Arcane Tempest
				{ 9,  147123 }, -- Gravewarden Handguards
				{ 10, 147177 }, -- Grips of the Skybreaker
				{ 11, 147043 }, -- Hauberk of Frozen Mist
				{ 12, 147045 }, -- Insulated Finpads
				{ 13, 147159 }, -- Radiant Lightbringer Gauntlets
				{ 14, 147000 }, -- Ravenous Devotee's Bracelets
				{ 15, 146994 }, -- Robe of Aqueous Command
				{ 16, 147020 }, -- Scaled Band of Servitude
				{ 17, 147071 }, -- Shiversleet Waistguard
				{ 18, 147135 }, -- Stormheart Gloves
				{ 19, 147189 }, -- Titanic Onslaught Handguards
				{ 20, 147067 }, -- Wave-Hammered Breastplate
				{ 21, 147141 }, -- Wildstalker Gauntlets
				{ 22, 147153 }, -- Xuen's Gauntlets
				{ 24, 147100 }, -- Calcified Barnacle
				{ 25, 147109 }, -- Harjatan's Leering Eye
				{ 26, 147092 }, -- Ice-Threaded Conch
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Sisters of the Moon
			EncounterJournalID = 1903,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147005 }, -- Chalice of Moonlight
				{ 2,  147068 }, -- Cuirass of Blinding Dawn
				{ 3,  147061 }, -- Dusk-Crusher Handguards
				{ 4,  147033 }, -- Lunar-Wrath Headgear
				{ 5,  147054 }, -- Mantle of Waning Radiance
				{ 6,  147031 }, -- Moonfire Stranglers
				{ 7,  146997 }, -- Shoulderpads of Whispering Twilight
				{ 8,  146987 }, -- Slippers of Enduring Vigilance
				{ 9,  147017 }, -- Tarnished Sentinel Medallion
				{ 10, 147012 }, -- Umbral Moonglaives
				{ 11, 147056 }, -- Waistguard of Interminable Unity
				{ 12, 147021 }, -- Yathae's Thumb Ring
				{ 14, 147097 }, -- Blessing of the White Lady
				{ 15, 147101 }, -- Chiseled Starlight
				{ 16, 147089 }, -- Ferocity of the Devout
				{ 17, 147105 }, -- Moontalon's Feather
				{ 18, 147078 }, -- Mote of Astral Suffusion
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Mistress Sassz'ine
			EncounterJournalID = 1861,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147049 }, -- Azure Squallshaper's Helm
				{ 2,  147131 }, -- Demonbane Leggings
				{ 3,  147184 }, -- Diabolic Leggings
				{ 4,  147173 }, -- Fanged Slayer's Legguards
				{ 5,  147125 }, -- Gravewarden Legplates
				{ 6,  147028 }, -- Hide of the Abyssal Behemoth
				{ 7,  146990 }, -- Hundred-Fathom Veil
				{ 8,  147059 }, -- Iron Ballast Sabatons
				{ 9,  147166 }, -- Leggings of Blind Absolution
				{ 10, 147148 }, -- Leggings of the Arcane Tempest
				{ 11, 147179 }, -- Legguards of the Skybreaker
				{ 12, 147023 }, -- Leviathan's Hunger
				{ 13, 147161 }, -- Radiant Lightbringer Greaves
				{ 14, 147004 }, -- Sea Star of the Depthmother
				{ 15, 146985 }, -- Shroud of the Drowned Adherent
				{ 16, 147137 }, -- Stormheart Legguards
				{ 17, 147016 }, -- Terror From Below
				{ 18, 147191 }, -- Titanic Onslaught Greaves
				{ 19, 147011 }, -- Vial of Ceaseless Toxins
				{ 20, 147143 }, -- Wildstalker Leggings
				{ 21, 147155 }, -- Xuens' Legguards
				{ 23, 147113 }, -- Flawless Hurricane Pearl
				{ 24, 147093 }, -- Globe of Frothing Eddies
				{ 25, 147085 }, -- Mutated Nautilus
				{ 26, 147081 }, -- Pungent Chum
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- The Desolate Host
			EncounterJournalID = 1896,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147063 }, -- Armet of the Rotten Mind
				{ 2,  147128 }, -- Demonbane Shroud
				{ 3,  147181 }, -- Diabolic Shroud
				{ 4,  147145 }, -- Drape of the Arcane Tempest
				{ 5,  147176 }, -- Drape of the Skybreaker
				{ 6,  147040 }, -- Etched Bone Waistband
				{ 7,  147170 }, -- Fanged Slayer's Shroud
				{ 8,  147047 }, -- Gauntlets of Spiteful Haunting
				{ 9,  147070 }, -- Grave-Dredged Pauldrons
				{ 10, 147122 }, -- Gravewarden Cloak
				{ 11, 147014 }, -- Locket of Splintered Souls
				{ 12, 147158 }, -- Radiant Lightbringer Cape
				{ 13, 147024 }, -- Reliquary of the Damned
				{ 14, 147163 }, -- Shawl of Blind Absolution
				{ 15, 146995 }, -- Soul Queen's Ceremonial Robes
				{ 16, 147018 }, -- Spectral Thurible
				{ 17, 147134 }, -- Stormheart Drape
				{ 18, 147188 }, -- Titanic Onslaught Cloak
				{ 19, 147140 }, -- Wildstalker Cape
				{ 20, 147152 }, -- Xuen's Cloak
				{ 22, 147086 }, -- Befouled Effigy of Elune
				{ 23, 147106 }, -- Glowing Prayer Candle
				{ 24, 147110 }, -- Grimacing Highborne Skull
				{ 25, 147114 }, -- Preserved Starlight Incense
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Maiden of Vigilance
			EncounterJournalID = 1897,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147194 }, -- Band of Rescinded Truths
				{ 2,  147050 }, -- Crown of Discarded Hope
				{ 3,  147127 }, -- Demonbane Harness
				{ 4,  147185 }, -- Diabolic Robe
				{ 5,  147015 }, -- Engine of Eradication
				{ 6,  147169 }, -- Fanged Slayer's Chestguard
				{ 7,  147032 }, -- Gloves of Wayward Compulsions
				{ 8,  147121 }, -- Gravewarden Chestplate
				{ 9,  147175 }, -- Harness of the Skybreaker
				{ 10, 146993 }, -- Leggings of Divine Portents
				{ 11, 147157 }, -- Radiant Lightbringer Breastplate
				{ 12, 147025 }, -- Recompiled Guardian Module
				{ 13, 147167 }, -- Robes of Blind Absolution
				{ 14, 147149 }, -- Robes of the Arcane Tempest
				{ 15, 147060 }, -- Steadfast Purifier's Warboots
				{ 16, 147133 }, -- Stormheart Tunic
				{ 17, 146999 }, -- Strife-Riddled Cinch
				{ 18, 147187 }, -- Titanic Onslaught Breastplate
				{ 19, 147139 }, -- Wildstalker Chestguard
				{ 20, 147151 }, -- Xuen's Tunic
				{ 22, 147098 }, -- Fragment of Grace
				{ 23, 147090 }, -- Stabilized Extinction Protocol
				{ 24, 151189 }, -- Tears of the Maiden
				{ 25, 147115 }, -- Unfurling Origination
				{ 26, 147094 }, -- Virus of Lethargy
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Fallen Avatar
			EncounterJournalID = 1873,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  147006 }, -- Archive of Faith
				{ 2,  146991 }, -- Blackened Mask of Disgrace
				{ 3,  147042 }, -- Bracers of Rippling Darkness
				{ 4,  147193 }, -- Cape of Mindless Fury
				{ 5,  147132 }, -- Demonbane Shoulderpads
				{ 6,  147186 }, -- Diabolic Mantle
				{ 7,  147174 }, -- Fanged Slayer's Shoulderpads
				{ 8,  147030 }, -- Felscape Pathfinders
				{ 9,  147126 }, -- Gravewarden Pauldrons
				{ 10, 147062 }, -- Groundshatter Gauntlets
				{ 11, 147052 }, -- Legguards of Siphoned Power
				{ 12, 147168 }, -- Mantle of Blind Absolution
				{ 13, 147150 }, -- Mantle of the Arcane Tempest
				{ 14, 147001 }, -- Oathbreaker's Cuffs
				{ 15, 147180 }, -- Pauldrons of the Skybreaker
				{ 16, 147162 }, -- Radiant Lightbringer Shoulderguards
				{ 17, 147138 }, -- Stormheart Mantle
				{ 18, 147192 }, -- Titanic Onslaught Pauldrons
				{ 19, 147144 }, -- Wildstalker Spaulders
				{ 20, 147156 }, -- Xuen's Shoulderguards
				{ 22, 147091 }, -- Cleansing Ignition Catalyst
				{ 23, 147102 }, -- Reactive Pylon Casing
				{ 24, 147107 }, -- Valorous Spark of Hope
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ -- Kil'jaeden
			EncounterJournalID = 1898,
			[RF_DIFF] = NORMAL_RAID_DIFF,
			[NORMAL_RAID_DIFF] = {
				{ 1,  146988 }, -- Gloves of Furtive Oppression
				{ 2,  147066 }, -- Greaves of Impure Midnight
				{ 3,  147195 }, -- Seal of the Second Duumvirate
				{ 4,  147034 }, -- Shadow-Scarred Headcover
				{ 5,  147026 }, -- Shifting Cosmic Sliver
				{ 6,  147072 }, -- Soul-Render's Greatbelt
				{ 7,  151190 }, -- Specter of Betrayal
				{ 8,  147046 }, -- Star-Stalker Treads
				{ 9,  147007 }, -- The Deceiver's Grand Design
				{ 10, 147019 }, -- Tome of Unraveling Sanity
				{ 11, 147048 }, -- Vicegrip of the Unrepentant
				{ 12, 147347 }, -- Waistguard of Profane Duplicity
				{ 14, 147099 }, -- Boon of the Prophet
				{ 15, 147082 }, -- Man'ari Blood Pact
				{ 16, 147087 }, -- Ruinous Ashes
				{ 17, 147111 }, -- Scornful Reflection
				{ 18, 147095 }, -- Sphere of Entropy
				{ 19, 147079 }, -- Torn Fabric of Reality
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{ --Tier 20 Sets
			name = format(AL["Tier %d Sets"], 20),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:20",
		},
		LEGION_GLORY_TOMB_RAIDER_AC_TABLE,
	},
}

data["TrialOfValor"] = {
	EncounterJournalID = 861,
	MapID = 807,
	ItemBaseLvl = 172,
	AtlasMapID = "TrialofValorA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{ --Odyn
			EncounterJournalID = 1819,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: You Runed Everything!
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  142419 }, -- Sky-Valiant's Wristguards
				{ 2,  142410 }, -- Robes of Celestial Adornment
				{ 3,  142425 }, -- Goldrune Legplates
				{ 4,  142431 }, -- Gleaming Val'kyr Cuirass
				{ 5,  142508 }, -- Chains of the Valorous
				{ 6,  142540 }, -- Mantle of the Victorious Dead
				{ 7,  142422 }, -- Radiant Soul Sabatons
				{ 8,  142411 }, -- Cinch of Light
				{ 9,  142430 }, -- Gloves of Issued Challenge
				{ 10, 142520 }, -- Ring of Ascended Glory
				{ 11, 142421 }, -- Leggings of the Undaunted
				{ 13, 142511 }, -- Unforged Titansteel
				{ 14, 142519 }, -- Favor of the Prime Designate
				{ 15, 142514 }, -- Ravens' Sight
				{ 16, "ac11337" }, -- AC: You Runed Everything!
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac11396" }, -- AC: Mythic: Odyn
			},
		},
		{ --Guarm
			EncounterJournalID = 1830,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, nil }, -- ignore the AC: Boneafide Tri Tip
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  142432 }, -- Helbeast Skin Tunic
				{ 2,  142434 }, -- Kvaldir Exult's Grips
				{ 3,  142423 }, -- Bite-Resistant Wristclamps
				{ 4,  142412 }, -- Windwhipped Sailcloth
				{ 5,  142506 }, -- Eye of Guarm
				{ 6,  142435 }, -- Reinforced Hound-Handler's Gauntlets
				{ 7,  142426 }, -- Lead-Soled Seabed Striders
				{ 8,  142413 }, -- Leggings of the Lower Planes
				{ 9,  142415 }, -- Helhound Hair Bracers
				{ 10, 142417 }, -- Moccasins of Silent Passage
				{ 12, 142515 }, -- Chilled Incisor
				{ 13, 142512 }, -- Accursed Cuspid
				{ 14, 142516 }, -- Sizzling Fang
				{ 16, "ac11386" }, -- AC: Boneafide Tri Tip
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 17, "ac11397" }, -- AC: Mythic: Guarm
			},
		},
		{ --Helya
			EncounterJournalID = 1829,
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 18, nil }, -- ignore the AC: Patient Zero
			},
			[NORMAL_RAID_DIFF] = {
				{ 1,  142507 }, -- Brinewater Slime in a Bottle
				{ 2,  142427 }, -- Calcareous Wristclamps
				{ 3,  142429 }, -- Oiled Rigger's Handwraps
				{ 4,  142521 }, -- Drape of the Unworthy
				{ 5,  142418 }, -- Sucker-Scarred Leggings
				{ 6,  142416 }, -- Strand of Whelk Shells
				{ 7,  142424 }, -- Krakenbone Waistplate
				{ 8,  142420 }, -- Anchor Chain Waistguard
				{ 9,  142428 }, -- Sea Fan Pendant
				{ 10, 142433 }, -- Corroded Val'kyr Chainmail
				{ 11, 142414 }, -- Treads of the Drowned
				{ 13, 142518 }, -- Fury of the Sea
				{ 14, 142513 }, -- Token of the Lightning Keeper
				{ 15, 142517 }, -- Swell of the Tides
				{ 16, 142510 }, -- Phylactery of Unwilling Servitude
				{ 18, "ac11377" }, -- AC: Patient Zero
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 19, "ac11387" }, -- AC: The Chosen
				{ 20, "ac11398" }, -- AC: Mythic: Helya

			},
		},
		LEGION_TRIAL_OF_VALOR_AC_TABLE
	}
}
