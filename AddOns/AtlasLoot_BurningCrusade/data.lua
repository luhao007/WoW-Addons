-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

local EJ_GetEncounterInfo = EJ_GetEncounterInfo
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 2)

AtlasLoot:RegisterModules(addonname)

local AL = AtlasLoot.Locales

local ADD_SCALING = {
	Item = {
		addDifficultyBonus = true,
	}
}

local NORMAL_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "n", ADD_SCALING, 1)
local HEROIC_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY2, "h", ADD_SCALING, 2)
local TIMEWALKING_DUNGEON_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY_TIMEWALKER, "timewalkingDungeonWithPreset", ADD_SCALING, 24)

local NORMAL_RAID_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "rn", ADD_SCALING, 3)
local P25_DIFF = data:AddDifficulty(RAID_DIFFICULTY_25PLAYER, "p25", ADD_SCALING, 4)
local TIMEWALKING_RAID_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY_TIMEWALKER, "timewalkingRaidWithPreset", ADD_SCALING, 33)

local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local DUNGEON_CONTENT = data:AddContentType(DUNGEONS, ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(RAIDS, ATLASLOOT_RAID_COLOR)

-- Shared loot tables
local BC_DUNGEONMASTER_AC_TABLE = { --[Outland Dungeonmaster]
	name = select(2, GetAchievementInfo(1284)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1284 },
		{ 2, 647 }, { 17, 648 },
		{ 3, 649 }, { 18, 650 },
		{ 4, 651 }, { 19, 652 },
		{ 5, 653 }, { 20, 654 },
		{ 6, 655 }, { 21, 656 },
		{ 7, 657 }, { 22, 658 },
		{ 8, 659 }, { 23, 660 },
		{ 9, 661 }, { 24, 666 },
	},
}

local BC_DUNGEON_HERO_AC_TABLE = { --[Outland Dungeon Hero]
	name = select(2, GetAchievementInfo(1287)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 1287 },
		{ 2, 667 }, { 17, 668 },
		{ 3, 669 }, { 18, 670 },
		{ 4, 671 }, { 19, 673 },
		{ 5, 674 }, { 20, 675 },
		{ 6, 676 }, { 21, 677 },
		{ 7, 678 }, { 22, 679 },
		{ 8, 680 }, { 23, 681 },
		{ 9, 682 }, { 24, 672 },
	},
}

local BC_RAID_AC_TABLE = { --[Outland Raider]
	name = select(2, GetAchievementInfo(1286)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1286 },
		{ 2, 690 }, { 17, 692 },
		{ 3, 693 }, { 18, 694 },
		{ 4, 695 }, { 19, 696 },
		{ 5, 697 }, { 20, 698 },
	},
}

data["AuchAuchenaiCrypts"] = {
	EncounterJournalID = 247,
	MapID = 256,
	AtlasMapID = "AuchAuchenaiCrypts",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --AuchCryptsShirrak
			EncounterJournalID = 523,
			[NORMAL_DIFF] = {
				{ 1,  27846 }, -- Claw of the Watcher
				{ 2,  25964 }, -- Shaarde the Lesser
				{ 3,  27410 }, -- Collar of Command
				{ 4,  27408 }, -- Hope Bearer Helm
				{ 5,  27409 }, -- Raven-Heart Headdress
				{ 6,  27866 }, -- Scintillating Headdress of Second Sight
				{ 7,  27847 }, -- Fanblade Pauldrons
				{ 8,  27865 }, -- Bracers of Shirrak
				{ 9,  27493 }, -- Gloves of the Deadwatcher
				{ 10, 27845 }, -- Magma Plume Boots
				{ 11, 26055 }, -- Oculus of the Hidden Eye
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --AuchCryptsExarch
			EncounterJournalID = 524,
			[NORMAL_DIFF] = {
				{ 1,  27412 }, -- Ironstaff of Regeneration
				{ 2,  27872 }, -- The Harvester of Souls
				{ 3,  27415 }, -- Darkguard Face Mask
				{ 4,  27414 }, -- Mok'Nathal Beast-Mask
				{ 5,  27871 }, -- Maladaar's Blessed Chaplet
				{ 6,  29354 }, -- Light-Touched Stole of Altruism
				{ 7,  29257 }, -- Sash of Arcane Visions
				{ 8,  29244 }, -- Wave-Song Girdle
				{ 9,  27870 }, -- Doomplate Legguards
				{ 10, 27867 }, -- Boots of the Unjust
				{ 11, 27411 }, -- Slippers of Serenity
				{ 12, 27523 }, -- Exarch's Diamond Band
				{ 13, 27413 }, -- Ring of the Exarchs
				{ 14, 27869 }, -- Soulpriest's Ring of Resolve
				{ 15, 27416 }, -- Fetish of the Fallen
				{ 16, "ac666" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac672" },
			},
		},
		{ --AuchCryptsAvatar
			name = AL["Avatar of the Martyred"],
			[HEROIC_DIFF] = {
				{ 1, 27878 }, -- Auchenai Death Shroud
				{ 2, 28268 }, -- Natural Mender's Wraps
				{ 3, 27876 }, -- Will of the Fallen Exarch
				{ 4, 27937 }, -- Sky Breaker
				{ 5, 27877 }, -- Draenic Wildstaff
				{ 6, 27797 }, -- Wastewalker Shoulderpads
			},
		},
		{ --AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23605 }, -- Plans: Felsteel Gloves
				{ 2, 22544 }, -- Formula: Enchant Boots - Dexterity
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --LowerCity
			FactionID = 1011,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:7",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["HCHellfireRamparts"] = {
	EncounterJournalID = 248,
	MapID = 347,
	AtlasMapID = "HCHellfireRamparts",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --HCRampWatchkeeper
			EncounterJournalID = 527,
			[NORMAL_DIFF] = {
				{ 1,  24020 }, -- Shadowrend Longblade
				{ 2,  27449 }, -- Blood Knight Defender
				{ 3,  24024 }, -- Pauldrons of Arcane Rage
				{ 4,  27448 }, -- Cloak of the Everliving
				{ 5,  24021 }, -- Light-Touched Breastplate
				{ 6,  24023 }, -- Bracers of Finesse
				{ 7,  27447 }, -- Bracers of Just Rewards
				{ 8,  24022 }, -- Scale Leggings of the Skirmisher
				{ 9,  27451 }, -- Boots of the Darkwalker
				{ 10, 27450 }, -- Wild Stalker Boots
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --HCRampOmor
			EncounterJournalID = 528,
			[NORMAL_DIFF] = {
				{ 1,  24069 }, -- Crystalfire Staff
				{ 2,  24094 }, -- Heart Fire Warhammer
				{ 3,  27463 }, -- Terror Flame Dagger
				{ 4,  27476 }, -- Truncheon of Five Hells
				{ 5,  27477 }, -- Faol's Signet of Cleansing
				{ 6,  27466 }, -- Headdress of Alacrity
				{ 7,  24073 }, -- Garrote-String Necklace
				{ 8,  24096 }, -- Heartblood Prayer Beads
				{ 9,  27464 }, -- Omor's Unyielding Will
				{ 10, 27539 }, -- Justice Bearer's Pauldrons
				{ 11, 27906 }, -- Crimsonforge Breastplate
				{ 12, 27462 }, -- Crimson Bracers of Gloom
				{ 13, 24090 }, -- Bloodstained Ravager Gauntlets
				{ 14, 27465 }, -- Mana-Etched Gloves
				{ 15, 27478 }, -- Girdle of the Blasted Reaches
				{ 16, 24091 }, -- Tenacious Defender
				{ 17, 27467 }, -- Silent-Strider Kneeboots
				{ 18, 27895 }, -- Band of Many Prisms
				{ 20, "ac647" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 20, "ac667" },
			},
		},
		{ --HCRampVazruden
			EncounterJournalID = 529,
			[NORMAL_DIFF] = {
				{ 1,  24044 }, -- Hellreaver
				{ 2,  24155 }, -- Ursol's Claw
				{ 3,  29346 }, -- Feltooth Eviscerator
				{ 4,  27455 }, -- Irondrake Faceguard
				{ 5,  27454 }, -- Volcanic Pauldrons
				{ 6,  24150 }, -- Mok'Nathal Wildercloak
				{ 7,  27461 }, -- Chestguard of the Prowler
				{ 8,  27456 }, -- Raiments of Nature's Breath
				{ 9,  27452 }, -- Light Scribe Bands
				{ 10, 27459 }, -- Vambraces of Daring
				{ 11, 27457 }, -- Life Bearer's Gauntlets
				{ 12, 32077 }, -- Wrath-Infused Gauntlets
				{ 13, 29238 }, -- Lion's Heart Girdle
				{ 14, 24063 }, -- Shifting Sash of Midnight
				{ 15, 29264 }, -- Tree-Mender's Belt
				{ 16, 24046 }, -- Kilt of Rolling Thunders
				{ 17, 24083 }, -- Lifegiver Britches
				{ 18, 27458 }, -- Oceansong Kilt
				{ 19, 24064 }, -- Ironsole Clompers
				{ 20, 27453 }, -- Averinn's Ring of Slaying
				{ 21, 24045 }, -- Band of Renewal
				{ 22, 24151 }, -- Mok'Nathal Clan Ring
				{ 23, 27460 }, -- Reavers' Ring
				{ 24, 24154 }, -- Witching Band
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 26, "ac667" },
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --HonorHold
			FactionID = 946,
			ExtraList = true,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:4",
		},
		{ --Thrallmar
			FactionID = 947,
			ExtraList = true,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:21",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["MagistersTerrace"] = {
	EncounterJournalID = 249,
	MapID = 348,
	AtlasMapID = "MagistersTerrace",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --SMTFireheart
			EncounterJournalID = 530,
			[NORMAL_DIFF] = {
				{ 1, 34604 }, -- Jaded Crystal Dagger
				{ 2, 34699 }, -- Sun-Forged Cleaver
				{ 3, 34601 }, -- Shoulderplates of Everlasting Pain
				{ 4, 34702 }, -- Cloak of Swift Mending
				{ 5, 34697 }, -- Bindings of Raging Fire
				{ 6, 34698 }, -- Bracers of the Forest Stalker
				{ 7, 34602 }, -- Eversong Cuffs
				{ 8, 34700 }, -- Gauntlets of Divine Blessings
				{ 9, 34701 }, -- Leggings of the Betrayed
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  133467 }, -- Jaded Crystal Dagger
				{ 2,  133433 }, -- Sun-Forged Cleaver
				{ 3,  133465 }, -- Shoulderplates of Everlasting Pain
				{ 4,  133436 }, -- Cloak of Swift Mending
				{ 5,  133431 }, -- Bindings of Raging Fire
				{ 6,  133432 }, -- Bracers of the Forest Stalker
				{ 7,  133466 }, -- Eversong Cuffs
				{ 8,  133434 }, -- Gauntlets of Divine Blessings
				{ 9,  133457 }, -- Gloves of Arcane Acuity
				{ 10, 133435 }, -- Leggings of the Betrayed
				{ 11, 133454 }, -- Band of Celerity
			},
		},
		{ --SMTVexallus
			EncounterJournalID = 531,
			[NORMAL_DIFF] = {
				{ 1,  34608 }, -- Rod of the Blazing Light
				{ 2,  34606 }, -- Edge of Oppression
				{ 3,  34703 }, -- Latro's Dancing Blade
				{ 4,  34607 }, -- Fel-Tinged Mantle
				{ 5,  34708 }, -- Cloak of the Coming Night
				{ 6,  34605 }, -- Breastplate of Fierce Survival
				{ 7,  34705 }, -- Bracers of Divine Infusion
				{ 8,  34707 }, -- Boots of Resuscitation
				{ 9,  34704 }, -- Band of Arcane Alacrity
				{ 10, 34706 }, -- Band of Determination
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  133471 }, -- Rod of the Blazing Light
				{ 2,  133469 }, -- Edge of Oppression
				{ 3,  133437 }, -- Latro's Dancing Blade
				{ 4,  133470 }, -- Fel-Tinged Mantle
				{ 5,  133442 }, -- Cloak of the Coming Night
				{ 6,  133468 }, -- Breastplate of Fierce Survival
				{ 7,  133478 }, -- Netherforce Chestplate
				{ 8,  133439 }, -- Bracers of Divine Infusion
				{ 9,  133441 }, -- Boots of Resuscitation
				{ 10, 133438 }, -- Band of Arcane Alacrity
				{ 11, 133440 }, -- Band of Determination
				{ 12, 133430 }, -- Kharmaa's Ring of Fate
			},
		},
		{ --SMTDelrissa
			EncounterJournalID = 532,
			[NORMAL_DIFF] = {
				{ 1, 34790 }, -- Battle-Mace of the High Priestess
				{ 2, 34788 }, -- Duskhallow Mantle
				{ 3, 34792 }, -- Cloak of the Betrayed
				{ 4, 34789 }, -- Bracers of Slaughter
				{ 5, 34791 }, -- Gauntlets of the Tranquil Waves
				{ 6, 34473 }, -- Commendation of Kael'thas
				{ 7, 34472 }, -- Shard of Contempt
				{ 8, 34470 }, -- Timbal's Focusing Crystal
				{ 9, 34471 }, -- Vial of the Sunwell
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  133446 }, -- Battle-Mace of the High Priestess
				{ 2,  133444 }, -- Duskhallow Mantle
				{ 3,  133448 }, -- Cloak of the Betrayed
				{ 4,  133445 }, -- Bracers of Slaughter
				{ 5,  133447 }, -- Gauntlets of the Tranquil Waves
				{ 6,  133458 }, -- Sunrage Treads
				{ 7,  133456 }, -- Sunstrider Warboots
				{ 8,  133464 }, -- Commendation of Kael'thas
				{ 9,  133463 }, -- Shard of Contempt
				{ 10, 133461 }, -- Timbal's Focusing Crystal
				{ 11, 133462 }, -- Vial of the Sunwell
			},
		},
		{ --SMTKaelthas
			EncounterJournalID = 533,
			[NORMAL_DIFF] = {
				{ 1,  34794 }, -- Axe of Shattered Dreams
				{ 2,  34797 }, -- Sun-Infused Focus Staff
				{ 3,  34616 }, -- Breeching Comet
				{ 4,  34611 }, -- Cudgel of Consecration
				{ 5,  34609 }, -- Quickening Blade of the Prince
				{ 6,  34795 }, -- Helm of Sanctification
				{ 7,  34613 }, -- Shoulderpads of the Silvermoon Retainer
				{ 8,  34810 }, -- Cloak of Blade Turning
				{ 9,  34799 }, -- Hauberk of the War Bringer
				{ 10, 34615 }, -- Netherforce Chestplate
				{ 11, 34796 }, -- Robes of Summer Flame
				{ 12, 34610 }, -- Scarlet Sin'dorei Robes
				{ 13, 34614 }, -- Tunic of the Ranger Lord
				{ 14, 34808 }, -- Gloves of Arcane Acuity
				{ 15, 34793 }, -- Cord of Reconstruction
				{ 16, 34612 }, -- Greaves of the Penitent Knight
				{ 17, 34809 }, -- Sunrage Treads
				{ 18, 34807 }, -- Sunstrider Warboots
				{ 19, 34798 }, -- Band of Celerity
				{ 20, 34625 }, -- Kharmaa's Ring of Fate
				{ 22, "ac661" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 22, 35275 }, -- Orb of the Sin'dorei
				{ 23, 35513,  "mount" }, -- Swift White Hawkstrider
				{ 24, 35504,  "pet175" }, -- Phoenix Hatchling
				{ 26, "ac682" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  133450 }, -- Axe of Shattered Dreams
				{ 2,  133453 }, -- Sun-Infused Focus Staff
				{ 3,  133479 }, -- Breeching Comet
				{ 4,  133474 }, -- Cudgel of Consecration
				{ 5,  133472 }, -- Quickening Blade of the Prince
				{ 6,  133451 }, -- Helm of Sanctification
				{ 7,  133476 }, -- Shoulderpads of the Silvermoon Retainer
				{ 8,  133459 }, -- Cloak of Blade Turning
				{ 9,  133455 }, -- Hauberk of the War Bringer
				{ 10, 133452 }, -- Robes of Summer Flame
				{ 11, 133473 }, -- Scarlet Sin'dorei Robes
				{ 12, 133477 }, -- Tunic of the Ranger Lord
				{ 13, 133449 }, -- Cord of Reconstruction
				{ 14, 133475 }, -- Greaves of the Penitent Knight
				{ 16, 35275 }, -- Orb of the Sin'dorei
				{ 17, 35513, "mount" }, -- Swift White Hawkstrider
				{ 18, 35504, "pet175" }, -- Phoenix Hatchling
			},
		},
		{ --SMTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35516 }, -- Sun Touched Satchel
			},
		},
		{ --SunOffensive
			FactionID = 1077,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:11",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["AuchManaTombs"] = {
	EncounterJournalID = 250,
	MapID = 272,
	AtlasMapID = "AuchManaTombs",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --AuchManaPandemonius
			EncounterJournalID = 534,
			[NORMAL_DIFF] = {
				{ 1,  25943 }, -- Creepjacker
				{ 2,  27814 }, -- Twinblade of Mastery
				{ 3,  27817 }, -- Starbolt Longbow
				{ 4,  25939 }, -- Voidfire Wand
				{ 5,  28166 }, -- Shield of the Void
				{ 6,  27816 }, -- Mindrage Pauldrons
				{ 7,  27818 }, -- Starry Robes of the Crescent
				{ 8,  25942 }, -- Faith Bearer's Gauntlets
				{ 9,  27813 }, -- Boots of the Colossus
				{ 10, 25941 }, -- Boots of the Outlander
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  127219 }, -- Creepjacker
				{ 2,  127234 }, -- Twinblade of Mastery
				{ 3,  127216 }, -- Voidfire Wand
				{ 4,  127236 }, -- Starbolt Longbow
				{ 5,  127254 }, -- Shield of the Void
				{ 6,  127235 }, -- Mindrage Pauldrons
				{ 7,  127237 }, -- Starry Robes of the Crescent
				{ 8,  127218 }, -- Faith Bearer's Gauntlets
				{ 9,  127249 }, -- Wastewalker Leggings
				{ 10, 127217 }, -- Boots of the Outlander
				{ 11, 127233 }, -- Boots of the Colossus
			},
		},
		{ --AuchManaTavarok
			EncounterJournalID = 535,
			[NORMAL_DIFF] = {
				{ 1,  25944 }, -- Shaarde the Greater
				{ 2,  25950 }, -- Staff of Polarities
				{ 3,  25952 }, -- Scimitar of the Nexus-Stalkers
				{ 4,  25947 }, -- Lightning-Rod Pauldrons
				{ 5,  27826 }, -- Mantle of the Sea Wolf
				{ 6,  25945 }, -- Cloak of Revival
				{ 7,  27824 }, -- Robe of the Great Dark Beyond
				{ 8,  27823 }, -- Shard Encrusted Breastplate
				{ 9,  27825 }, -- Predatory Gloves
				{ 10, 27821 }, -- Extravagant Boots of Malice
				{ 11, 25946 }, -- Nethershade Boots
				{ 12, 27822 }, -- Crystal Band of Valor
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  127220 }, -- Shaarde the Greater
				{ 2,  127224 }, -- Staff of Polarities
				{ 3,  127225 }, -- Scimitar of the Nexus-Stalkers
				{ 4,  127223 }, -- Lightning-Rod Pauldrons
				{ 5,  127243 }, -- Mantle of the Sea Wolf
				{ 6,  127221 }, -- Cloak of Revival
				{ 7,  127241 }, -- Robe of the Great Dark Beyond
				{ 8,  127240 }, -- Shard Encrusted Breastplate
				{ 9,  127232 }, -- Gauntlets of Vindication
				{ 10, 127242 }, -- Predatory Gloves
				{ 11, 127238 }, -- Extravagant Boots of Malice
				{ 12, 127222 }, -- Nethershade Boots
				{ 13, 127239 }, -- Crystal Band of Valor
			},
		},
		{ --AuchManaYor
			EncounterJournalID = 536,
			[HEROIC_DIFF] = {
				{ 1,  31570 }, -- Mistshroud Tunic
				{ 2,  31562 }, -- Skystalker's Tunic
				{ 3,  31578 }, -- Slatesteel Breastplate
				{ 4,  31554 }, -- Windchanneller's Tunic
				{ 5,  31923 }, -- Band of the Crystalline Void
				{ 6,  31919 }, -- Nexus-Prince's Ring of Balance
				{ 7,  31922 }, -- Ring of Conflict Survival
				{ 8,  31920 }, -- Shaffar's Band of Brutality
				{ 9,  31921 }, -- Yor's Collapsing Band
				{ 10, 31924 }, -- Yor's Revenge
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  127422 }, -- Mistshroud Tunic
				{ 2,  127421 }, -- Skystalker's Tunic
				{ 3,  127423 }, -- Slatesteel Breastplate
				{ 4,  127420 }, -- Windchanneller's Tunic
				{ 5,  127428 }, -- Band of the Crystalline Void
				{ 6,  127231 }, -- Longstrider's Loop
				{ 7,  127424 }, -- Nexus-Prince's Ring of Balance
				{ 8,  127427 }, -- Ring of Conflict Survival
				{ 9,  127425 }, -- Shaffar's Band of Brutality
				{ 10, 127426 }, -- Yor's Collapsing Band
				{ 11, 127429 }, -- Yor's Revenge
			},
		},
		{ --AuchManaNexusPrince
			EncounterJournalID = 537,
			[NORMAL_DIFF] = {
				{ 1,  27829 },                          -- Axe of the Nexus-Kings
				{ 2,  27842 },                          -- Grand Scepter of the Nexus-Kings
				{ 3,  27840 },                          -- Scepter of Sha'tar
				{ 4,  28400 },                          -- Warp-Storm Warblade
				{ 5,  25953 },                          -- Ethereal Warp-Bow
				{ 6,  32082 },                          -- The Fel Barrier
				{ 7,  25955 },                          -- Mask of the Howling Storm
				{ 8,  25954 },                          -- Sigil of Shaffar
				{ 9,  27831 },                          -- Mantle of the Unforgiven
				{ 10, 27844 },                          -- Pauldrons of Swift Retribution
				{ 11, 29240 },                          -- Bands of Negation
				{ 12, 27827 },                          -- Lucid Dream Bracers
				{ 13, 25956 },                          -- Nexus-Bracers of Vigor
				{ 14, 27798 },                          -- Gauntlets of Vindication
				{ 15, 27843 },                          -- Glyph-Lined Sash
				{ 16, 27835 },                          -- Stillwater Girdle
				{ 17, 30535 },                          -- Forestwalker Kilt
				{ 18, 27837 },                          -- Wastewalker Leggings
				{ 19, 25957 },                          -- Ethereal Boots of the Skystrider
				{ 20, 29352 },                          -- Cobalt Band of Tyrigosa
				{ 21, 25962 },                          -- Longstrider's Loop
				{ 22, 27828 },                          -- Warp-Scarab Brooch
				{ 24, 22921,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Recipe: Major Frost Protection Potion
				{ 26, "ac651" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 26, "ac671" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  127246 }, -- Axe of the Nexus-Kings
				{ 2,  127251 }, -- Grand Scepter of the Nexus-Kings
				{ 3,  127250 }, -- Scepter of Sha'tar
				{ 4,  127255 }, -- Warp-Storm Warblade
				{ 5,  127226 }, -- Ethereal Warp-Bow
				{ 6,  127259 }, -- The Fel Barrier
				{ 7,  127228 }, -- Mask of the Howling Storm
				{ 8,  127227 }, -- Sigil of Shaffar
				{ 9,  127247 }, -- Mantle of the Unforgiven
				{ 10, 127253 }, -- Pauldrons of Swift Retribution
				{ 11, 127256 }, -- Bands of Negation
				{ 12, 127244 }, -- Lucid Dream Bracers
				{ 13, 127229 }, -- Nexus-Bracers of Vigor
				{ 14, 127252 }, -- Glyph-Lined Sash
				{ 15, 127248 }, -- Stillwater Girdle
				{ 16, 127258 }, -- Forestwalker Kilt
				{ 17, 127230 }, -- Ethereal Boots of the Skystrider
				{ 18, 127257 }, -- Cobalt Band of Tyrigosa
				{ 19, 127245 }, -- Warp-Scarab Brooch
			},
		},
		{ --AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23615 }, -- Plans: Swiftsteel Gloves
				{ 2, 22543 }, -- Formula: Enchant Boots - Fortitude
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --Consortium
			FactionID = 933,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:15",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CoTOldHillsbrad"] = {
	EncounterJournalID = 251,
	MapID = 274,
	AtlasMapID = "CoTOldHillsbrad",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --CoTHillsbradDrake
			EncounterJournalID = 538,
			[NORMAL_DIFF] = {
				{ 1,  28210 }, -- Bloodskull Destroyer
				{ 2,  28213 }, -- Lordaeron Medical Guide
				{ 3,  28215 }, -- Mok'Nathal Mask of Battle
				{ 4,  27417 }, -- Ravenwing Pauldrons
				{ 5,  27423 }, -- Cloak of Impulsiveness
				{ 6,  28214 }, -- Grips of the Lunar Eclipse
				{ 7,  28212 }, -- Aran's Sorcerous Slacks
				{ 8,  27418 }, -- Stormreaver Shadow-Kilt
				{ 9,  27420 }, -- Uther's Ceremonial Warboots
				{ 10, 27436 }, -- Iron Band of the Unbreakable
				{ 11, 28211 }, -- Lieutenant's Signet of Lordaeron
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTHillsbradSkarloc
			EncounterJournalID = 539,
			[NORMAL_DIFF] = {
				{ 1,  27424 },                         -- Amani Venom-Axe
				{ 2,  28216 },                         -- Dathrohan's Ceremonial Hammer
				{ 3,  27426 },                         -- Northshire Battlemace
				{ 4,  28220 },                         -- Moon-Crown Antlers
				{ 5,  28217 },                         -- Tarren Mill Vitality Locket
				{ 6,  27427 },                         -- Durotan's Battle Harness
				{ 7,  27428 },                         -- Stormfront Gauntlets
				{ 8,  28219 },                         -- Emerald-Scale Greaves
				{ 9,  28218 },                         -- Pontiff's Pantaloons of Prophecy
				{ 10, 27430 },                         -- Scaled Greaves of Patience
				{ 11, 28221 },                         -- Boots of the Watchful Heart
				{ 13, 22927, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Recipe: Ironshield Potion
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTHillsbradHunter
			EncounterJournalID = 540,
			[NORMAL_DIFF] = {
				{ 1,  28222 },                          -- Reaver of the Infinites
				{ 2,  27431 },                          -- Time-Shifted Dagger
				{ 3,  28226 },                          -- Timeslicer
				{ 4,  28225 },                          -- Doomplate Warhelm
				{ 5,  28224 },                          -- Wastewalker Helm
				{ 6,  27440 },                          -- Diamond Prism of Recurrence
				{ 7,  28233 },                          -- Necklace of Resplendent Hope
				{ 8,  27434 },                          -- Mantle of Perenolde
				{ 9,  27433 },                          -- Pauldrons of Sufferance
				{ 10, 28344 },                          -- Wyrmfury Pauldrons
				{ 11, 28401 },                          -- Hauberk of Desolation
				{ 12, 28191 },                          -- Mana-Etched Vestments
				{ 13, 29246 },                          -- Nightfall Wristguards
				{ 14, 29250 },                          -- Cord of Sanctification
				{ 15, 27911 },                          -- Epoch's Whispering Cinch
				{ 16, 30536 },                          -- Greaves of the Martyr
				{ 17, 30534 },                          -- Wyrmscale Greaves
				{ 18, 27432 },                          -- Broxigar's Ring of Valor
				{ 19, 27904 },                          -- Resounding Ring of Glory
				{ 20, 28227 },                          -- Sparking Arcanite Ring
				{ 21, 28223 },                          -- Arcanist's Stone
				{ 23, 24173,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Circlet of Arcane Might
				{ 25, "ac652" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 25, "ac673" },
			},
		},
		{ --CoTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  25729 }, -- Pattern: Stylin' Adventure Hat
				{ 3,  "INV_Box_01", nil, AL["Don Carlos"],          nil },
				{ 4,  38506 }, -- Don Carlos' Famous Hat
				{ 5,  38329 }, -- Don Carlos' Hat
				{ 6,  38276 }, -- Haliscan Brimmed Hat
				{ 16, "INV_Box_01", nil, AL["Thomas Yance"],        nil },
				{ 17, 25725 }, -- Pattern: Riding Crop
				{ 19, "INV_Box_01", nil, AL["Aged Dalaran Wizard"], nil },
				{ 20, 22539 }, -- Formula: Enchant Shield - Intellect
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --KeepersofTime
			FactionID = 989,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:5",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["AuchSethekkHalls"] = {
	EncounterJournalID = 252,
	MapID = 258,
	AtlasMapID = "AuchSethekkHalls",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --AuchSethekkDarkweaver
			EncounterJournalID = 541,
			[NORMAL_DIFF] = {
				{ 1, 27919 },                         -- Light-Woven Slippers
				{ 2, 27914 },                         -- Moonstrider Boots
				{ 3, 27915 },                         -- Sky-Hunter Swift Boots
				{ 4, 27918 },                         -- Bands of Syth
				{ 6, 24160, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Khorium Inferno Band
				{ 8, 27633, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Terokk's Mask
			},
			[HEROIC_DIFF] = {
				{ 1, 27919 },                         -- Light-Woven Slippers
				{ 2, 27914 },                         -- Moonstrider Boots
				{ 3, 27915 },                         -- Sky-Hunter Swift Boots
				{ 4, 27918 },                         -- Bands of Syth
				{ 6, 24160, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Khorium Inferno Band
				{ 8, 27633, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Terokk's Mask
				{ 9, 25461, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Book of Forgotten Names
			},
		},
		{ --AuchSethekkRavenGod
			EncounterJournalID = 542,
			[HEROIC_DIFF] = {
				{ 1, 32781 }, -- Talon of Anzu
				{ 2, 32780 }, -- The Boomstick
				{ 3, 32769 }, -- Belt of the Raven Lord
				{ 4, 27936 }, -- Greaves of Desolation
				{ 5, 32778 }, -- Boots of Righteous Fortitude
				{ 6, 32779 }, -- Band of Frigid Elements
				{ 8, 32768, "mount" }, -- Reins of the Raven Lord
			},
		},
		{ --AuchSethekkTalonKing
			EncounterJournalID = 543,
			[NORMAL_DIFF] = {
				{ 1,  27986 }, -- Crow Wing Reaper
				{ 2,  29355 }, -- Terokk's Shadowstaff
				{ 3,  27980 }, -- Terokk's Nightmace
				{ 4,  27776 }, -- Shoulderpads of Assassination
				{ 5,  32073 }, -- Spaulders of Dementia
				{ 6,  27946 }, -- Avian Cloak of Feathers
				{ 7,  27981 }, -- Sethekk Oracle Cloak
				{ 8,  29249 }, -- Bands of the Benevolent
				{ 9,  29259 }, -- Bracers of the Hunt
				{ 10, 27985 }, -- Deathforge Girdle
				{ 11, 27875 }, -- Hallowed Trousers
				{ 12, 27838 }, -- Incanter's Trousers
				{ 13, 27948 }, -- Trousers of Oblivion
				{ 14, 27925 }, -- Ravenclaw Band
				{ 16, "ac653" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac674" },
			},
		},
		{ --AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 25731 }, -- Pattern: Stylin' Crimson Hat
				{ 3, 27634 }, -- The Saga of Terokk
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --LowerCity
			FactionID = 1011,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:7",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["AuchShadowLabyrinth"] = {
	EncounterJournalID = 253,
	MapID = 260,
	AtlasMapID = "AuchShadowLabyrinth",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --AuchShadowHellmaw
			EncounterJournalID = 544,
			[NORMAL_DIFF] = {
				{ 1, 27885 }, -- Soul-Wand of the Aldor
				{ 2, 27887 }, -- Platinum Shield of the Valorous
				{ 3, 27888 }, -- Dream-Wing Helm
				{ 4, 27889 }, -- Jaedenfire Gloves of Annihilation
				{ 5, 27908 }, -- Leggings of Assassination
				{ 6, 27884 }, -- Ornate Boots of the Sanctified
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --AuchShadowBlackheart
			EncounterJournalID = 545,
			[NORMAL_DIFF] = {
				{ 1, 27890 },                         -- Wand of the Netherwing
				{ 2, 28134 },                         -- Brooch of Heightened Potential
				{ 3, 27892 },                         -- Cloak of the Inciter
				{ 4, 27893 },                         -- Ornate Leggings of the Venerated
				{ 5, 27891 },                         -- Adamantine Figurine
				{ 7, 30808, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Book of Fel Names
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 9, 25728 }, -- Pattern: Stylin' Purple Hat
			},
		},
		{ --AuchShadowGrandmaster
			EncounterJournalID = 546,
			[NORMAL_DIFF] = {
				{ 1, 27901 },                         -- Blackout Truncheon
				{ 2, 27898 },                         -- Wrathfire Hand-Cannon
				{ 3, 27775 },                         -- Hallowed Pauldrons
				{ 4, 27897 },                         -- Breastplate of Many Graces
				{ 5, 27468 },                         -- Moonglade Handwraps
				{ 6, 27909 },                         -- Tidefury Kilt
				{ 7, 27900 },                         -- Jewel of Charismatic Mystique
				{ 9, 30827, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Lexicon Demonica
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --AuchShadowMurmur
			EncounterJournalID = 547,
			[NORMAL_DIFF] = {
				{ 1,  27903 },                          -- Sonic Spear
				{ 2,  27905 },                          -- Greatsword of Horrid Dreams
				{ 3,  29353 },                          -- Shockwave Truncheon
				{ 4,  27913 },                          -- Whispering Blade of Slaying
				{ 5,  27910 },                          -- Silvermoon Crest Shield
				{ 6,  27803 },                          -- Shoulderguards of the Bold
				{ 7,  27778 },                          -- Spaulders of Oblivion
				{ 8,  28230 },                          -- Hallowed Garments
				{ 9,  27912 },                          -- Harness of the Deep Currents
				{ 10, 28232 },                          -- Robe of Oblivion
				{ 11, 29357 },                          -- Master Thief's Gloves
				{ 12, 29261 },                          -- Girdle of Ferocity
				{ 13, 30532 },                          -- Kirin Tor Master's Trousers
				{ 14, 27902 },                          -- Silent Slippers of Meditation
				{ 16, 24309,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Spellstrike Pants
				{ 18, "ac654" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 18, 31722,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Murmur's Essence
				{ 19, 33840,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Murmur's Whisper
				{ 21, "ac675" },
			},
		},
		{ --AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23607 }, -- Plans: Felsteel Helm
				{ 3, "INV_Box_01", nil, AL["First Fragment Guardian"], nil },
				{ 4, 24514 }, -- First Key Fragment
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --LowerCity
			FactionID = 1011,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:7",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["TempestKeepArcatraz"] = {
	EncounterJournalID = 254,
	MapID = 269,
	AtlasMapID = "TempestKeepArcatraz",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --TKArcUnbound
			EncounterJournalID = 548,
			[NORMAL_DIFF] = {
				{ 1, 28415 }, -- Hood of Oblivion
				{ 2, 28374 }, -- Mana-Sphere Shoulderguards
				{ 3, 28373 }, -- Cloak of Scintillating Auras
				{ 4, 28396 }, -- Gloves of the Unbound
				{ 5, 28375 }, -- Rubium War-Girdle
				{ 6, 28384 }, -- Outland Striders
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --TKArcDalliah
			EncounterJournalID = 549,
			[NORMAL_DIFF] = {
				{ 1, 28416 },                         -- Hungering Spineripper
				{ 2, 28392 },                         -- Reflex Blades
				{ 3, 28386 },                         -- Nether Core's Control Rod
				{ 4, 28387 },                         -- Lamp of Peaceful Repose
				{ 5, 28414 },                         -- Helm of Assassination
				{ 6, 28390 },                         -- Thatia's Self-Correcting Gauntlets
				{ 7, 28384 },                         -- Outland Striders
				{ 9, 24308, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Whitemend Pants
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --TKArcScryer
			EncounterJournalID = 550,
			[NORMAL_DIFF] = {
				{ 1, 28393 }, -- Warmaul of Infused Light
				{ 2, 28397 }, -- Emberhawk Crossbow
				{ 3, 28413 }, -- Hallowed Crown
				{ 4, 28403 }, -- Doomplate Chestguard
				{ 5, 28391 }, -- Worldfire Chestguard
				{ 6, 28398 }, -- The Sleeper's Cord
				{ 7, 28394 }, -- Ryngo's Band of Ingenuity
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --TKArcHarbinger
			EncounterJournalID = 551,
			[NORMAL_DIFF] = {
				{ 1,  29360 }, -- Vileblade of the Betrayer
				{ 2,  28412 }, -- Lamp of Peaceful Radiance
				{ 3,  28419 }, -- Choker of Fluid Thought
				{ 4,  28205 }, -- Breastplate of the Bold
				{ 5,  28231 }, -- Tidefury Chestpiece
				{ 6,  29252 }, -- Bracers of Dignity
				{ 7,  29241 }, -- Belt of Depravity
				{ 8,  29248 }, -- Shadowstep Striders
				{ 9,  28406 }, -- Sigil-Laced Boots
				{ 10, 28407 }, -- Elementium Band of the Sentry
				{ 11, 28418 }, -- Shiffar's Nexus-Horn
				{ 13, "ac660" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 13, 33861,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Scroll of Skyriss
				{ 15, "ac681" },
			},
		},
		{ --TKTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23606 }, -- Plans: Felsteel Leggings
				{ 2,  22556 }, -- Formula: Enchant 2H Weapon - Major Agility
				{ 3,  21905 }, -- Pattern: Arcanoweave Bracers
				{ 16, "INV_Box_01", nil, AL["Third Fragment Guardian"], nil },
				{ 17, 24488 }, -- Third Key Fragment
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CoTBlackMorass"] = {
	EncounterJournalID = 255,
	MapID = 273,
	AtlasMapID = "CoTBlackMorass",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --CoTMorassDeja
			EncounterJournalID = 552,
			[NORMAL_DIFF] = {
				{ 1, 27987 }, -- Melmorta's Twilight Longbow
				{ 2, 27993 }, -- Mask of Inner Fire
				{ 3, 27994 }, -- Mantle of Three Terrors
				{ 4, 27995 }, -- Sun-Gilded Shouldercaps
				{ 5, 27988 }, -- Burnoose of Shifting Ages
				{ 6, 27977 }, -- Legplates of the Bold
				{ 7, 27873 }, -- Moonglade Pants
				{ 8, 27996 }, -- Ring of Spiritual Precision
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTMorassTemporus
			EncounterJournalID = 553,
			[NORMAL_DIFF] = {
				{ 1, 28033 }, -- Epoch-Mender
				{ 2, 29356 }, -- Quantum Blade
				{ 3, 28184 }, -- Millennium Blade
				{ 4, 28187 }, -- Star-Heart Lamp
				{ 5, 28186 }, -- Laughing Skull Battle-Harness
				{ 6, 27509 }, -- Handgrips of Assassination
				{ 7, 28185 }, -- Khadgar's Kilt of Abjuration
				{ 8, 28034 }, -- Hourglass of the Unraveller
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTMorassAeonus
			EncounterJournalID = 554,
			[NORMAL_DIFF] = {
				{ 1,  28188 }, -- Bloodfire Greatstaff
				{ 2,  28189 }, -- Latro's Shifting Sword
				{ 3,  28206 }, -- Cowl of the Guiltless
				{ 4,  28192 }, -- Helm of Desolation
				{ 5,  28193 }, -- Mana-Etched Crown
				{ 6,  28207 }, -- Pauldrons of the Crimson Flight
				{ 7,  28194 }, -- Primal Surge Bracers
				{ 8,  29247 }, -- Girdle of the Deathdealer
				{ 9,  29253 }, -- Girdle of Valorous Deeds
				{ 10, 30531 }, -- Breeches of the Occultist
				{ 11, 27839 }, -- Legplates of the Righteous
				{ 12, 28190 }, -- Scarab of the Infinite Cycle
				{ 14, "ac655" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 14, 33858,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Aeonus' Hourglass
				{ 16, "ac676" },
			},
		},
		{ --CoTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 25730 }, -- Pattern: Stylin' Jungle Hat
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --KeepersofTime
			FactionID = 989,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:5",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["HCBloodFurnace"] = {
	EncounterJournalID = 256,
	MapID = 261,
	AtlasMapID = "HCBloodFurnace",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --HCFurnaceMaker
			EncounterJournalID = 555,
			[NORMAL_DIFF] = {
				{ 1,  24384 },                         -- Diamond-Core Sledgemace
				{ 2,  27488 },                         -- Mage-Collar of the Firestorm
				{ 3,  24385 },                         -- Pendant of Battle-Lust
				{ 4,  27485 },                         -- Embroidered Cape of Mysteries
				{ 5,  27483 },                         -- Moon-Touched Bands
				{ 6,  24387 },                         -- Ironblade Gauntlets
				{ 7,  24388 },                         -- Girdle of the Gale Storm
				{ 8,  27487 },                         -- Bloodlord Legplates
				{ 10, 73200, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Fel Infusion Rod
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188277 }, -- Diamond-Core Sledgemace
				{ 2, 188294 }, -- Mage-Collar of the Firestorm
				{ 3, 188278 }, -- Pendant of Battle-Lust
				{ 4, 188292 }, -- Embroidered Cape of Mysteries
				{ 5, 188291 }, -- Moon-Touched Bands
				{ 6, 188279 }, -- Ironblade Gauntlets
				{ 7, 188280 }, -- Girdle of the Gale Storm
				{ 8, 188293 }, -- Bloodlord Legplates
			},
		},
		{ --HCFurnaceBroggok
			EncounterJournalID = 556,
			[NORMAL_DIFF] = {
				{ 1,  27490 }, -- Firebrand Battleaxe
				{ 2,  24389 }, -- Legion Blunderbuss
				{ 3,  24392 }, -- Arcing Bracers
				{ 4,  27494 }, -- Emerald Eye Bracer
				{ 5,  27489 }, -- Virtue Bearer's Vambraces
				{ 6,  24393 }, -- Bloody Surgeon's Mitts
				{ 7,  24391 }, -- Kilt of the Night Strider
				{ 8,  27492 }, -- Moonchild Leggings
				{ 9,  27848 }, -- Embroidered Spellpyre Boots
				{ 10, 27491 }, -- Signet of Repose
				{ 11, 24390 }, -- Auslese's Light Channeler
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188296 }, -- Firebrand Battleaxe
				{ 2,  188281 }, -- Legion Blunderbuss
				{ 3,  188284 }, -- Arcing Bracers
				{ 4,  188299 }, -- Emerald Eye Bracer
				{ 5,  188295 }, -- Virtue Bearer's Vambraces
				{ 6,  188285 }, -- Bloody Surgeon's Mitts
				{ 7,  188283 }, -- Kilt of the Night Strider
				{ 8,  188298 }, -- Moonchild Leggings
				{ 9,  188308 }, -- Embroidered Spellpyre Boots
				{ 10, 188297 }, -- Signet of Repose
				{ 11, 188282 }, -- Auslese's Light Channeler
			},
		},
		{ --HCFurnaceBreaker
			EncounterJournalID = 557,
			[NORMAL_DIFF] = {
				{ 1,  24394 }, -- Warsong Howling Axe
				{ 2,  27512 }, -- The Willbreaker
				{ 3,  27507 }, -- Adamantine Repeater
				{ 4,  27505 }, -- Ruby Helm of the Just
				{ 5,  27495 }, -- Soldier's Dog Tags
				{ 6,  29347 }, -- Talisman of the Breaker
				{ 7,  32080 }, -- Mantle of Shadowy Embrace
				{ 8,  24398 }, -- Mantle of the Dusk-Dweller
				{ 9,  24397 }, -- Raiments of Divine Authority
				{ 10, 27506 }, -- Robe of Effervescent Light
				{ 11, 24396 }, -- Vest of Vengeance
				{ 12, 28264 }, -- Wastewalker Tunic
				{ 13, 27497 }, -- Doomplate Gauntlets
				{ 14, 24395 }, -- Mindfire Waistband
				{ 15, 27514 }, -- Leggings of the Unrepentant
				{ 16, 27788 }, -- Bloodsworn Warboots
				{ 17, 29239 }, -- Eaglecrest Warboots
				{ 18, 29245 }, -- Wave-Crest Striders
				{ 19, 28121 }, -- Icon of Unyielding Courage
				{ 21, "ac648" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 21, 33814,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Keli'dan's Feathered Stave
				{ 23, "ac668" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188286 }, -- Warsong Howling Axe
				{ 2,  188305 }, -- The Willbreaker
				{ 3,  188304 }, -- Adamantine Repeater
				{ 4,  188302 }, -- Ruby Helm of the Just
				{ 5,  188300 }, -- Soldier's Dog Tags
				{ 6,  188313 }, -- Talisman of the Breaker
				{ 7,  188314 }, -- Mantle of Shadowy Embrace
				{ 8,  188290 }, -- Mantle of the Dusk-Dweller
				{ 9,  188289 }, -- Raiments of Divine Authority
				{ 10, 188303 }, -- Robe of Effervescent Light
				{ 11, 188288 }, -- Vest of Vengeance
				{ 12, 188310 }, -- Wastewalker Tunic
				{ 13, 188301 }, -- Doomplate Gauntlets
				{ 14, 188287 }, -- Mindfire Waistband
				{ 15, 188306 }, -- Leggings of the Unrepentant
				{ 16, 188307 }, -- Bloodsworn Warboots
				{ 17, 188311 }, -- Eaglecrest Warboots
				{ 18, 188312 }, -- Wave-Crest Striders
				{ 19, 188309 }, -- Icon of Unyielding Courage
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --HonorHold
			FactionID = 946,
			ExtraList = true,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:4",
		},
		{ --Thrallmar
			FactionID = 947,
			ExtraList = true,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:21",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["TempestKeepBotanica"] = {
	EncounterJournalID = 257,
	MapID = 266,
	AtlasMapID = "TempestKeepBotanica",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --TKBotSarannis
			EncounterJournalID = 558,
			[NORMAL_DIFF] = {
				{ 1, 28311 },                         -- Revenger
				{ 2, 28350 },                         -- Warhelm of the Bold
				{ 3, 28306 },                         -- Towering Mantle of the Hunt
				{ 4, 28301 },                         -- Sarannis' Mystic Sheen
				{ 5, 28304 },                         -- Prismatic Mittens of Mending
				{ 6, 28347 },                         -- Warpscale Leggings
				{ 8, 28769, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Keystone
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188372 }, -- Revenger
				{ 2, 188394 }, -- Warhelm of the Bold
				{ 3, 188371 }, -- Towering Mantle of the Hunt
				{ 4, 188369 }, -- Sarannis' Mystic Sheen
				{ 5, 188370 }, -- Prismatic Mittens of Mending
				{ 6, 188391 }, -- Warpscale Leggings
			},
		},
		{ --TKBotFreywinn
			EncounterJournalID = 559,
			[NORMAL_DIFF] = {
				{ 1,  28315 },                         -- Stormreaver Warblades
				{ 2,  28316 },                         -- Aegis of the Sunbird
				{ 3,  28348 },                         -- Moonglade Cowl
				{ 4,  28321 },                         -- Enchanted Thorium Torque
				{ 5,  28228 },                         -- Beast Lord Cuirass
				{ 6,  28317 },                         -- Energis Armwraps
				{ 7,  28318 },                         -- Obsidian Clodstompers
				{ 9,  23617, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Plans: Earthpeace Breastplate
				{ 11, 31744, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Botanist's Field Guide
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188373 }, -- Stormreaver Warblades
				{ 2, 188374 }, -- Aegis of the Sunbird
				{ 3, 188392 }, -- Moonglade Cowl
				{ 4, 188377 }, -- Enchanted Thorium Torque
				{ 5, 188367 }, -- Beast Lord Cuirass
				{ 6, 188375 }, -- Energis Armwraps
				{ 7, 188376 }, -- Obsidian Clodstompers
			},
		},
		{ --TKBotThorngrin
			EncounterJournalID = 560,
			[NORMAL_DIFF] = {
				{ 1, 28325 },                         -- Dreamer's Dragonstaff
				{ 2, 28322 },                         -- Runed Dagger of Solace
				{ 3, 28324 },                         -- Gauntlets of Cruel Intention
				{ 4, 28327 },                         -- Arcane Netherband
				{ 5, 28323 },                         -- Ring of Umbral Doom
				{ 7, 24310, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Battlecast Pants
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188381 }, -- Dreamer's Dragonstaff
				{ 2, 188378 }, -- Runed Dagger of Solace
				{ 3, 188380 }, -- Gauntlets of Cruel Intention
				{ 4, 188382 }, -- Arcane Netherband
				{ 5, 188379 }, -- Ring of Umbral Doom
			},
		},
		{ --TKBotLaj
			EncounterJournalID = 561,
			[NORMAL_DIFF] = {
				{ 1, 28349 },                         -- Tidefury Helm
				{ 2, 28340 },                         -- Mantle of Autumn
				{ 3, 27739 },                         -- Spaulders of the Righteous
				{ 4, 28328 },                         -- Mithril-Bark Cloak
				{ 5, 28338 },                         -- Devil-Stitched Leggings
				{ 6, 28339 },                         -- Boots of the Shifting Sands
				{ 8, 72706, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Rapidly Evolving Frond
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188393 }, -- Tidefury Helm
				{ 2, 188386 }, -- Mantle of Autumn
				{ 3, 188366 }, -- Spaulders of the Righteous
				{ 4, 188383 }, -- Mithril-Bark Cloak
				{ 5, 188384 }, -- Devil-Stitched Leggings
				{ 6, 188385 }, -- Boots of the Shifting Sands
			},
		},
		{ --TKBotSplinter
			EncounterJournalID = 562,
			[NORMAL_DIFF] = {
				{ 1,  29359 },                          -- Feral Staff of Lashing
				{ 2,  28367 },                          -- Greatsword of Forlorn Visions
				{ 3,  28341 },                          -- Warpstaff of Arcanum
				{ 4,  28345 },                          -- Warp Splinter's Thorn
				{ 5,  28343 },                          -- Jagged Bark Pendant
				{ 6,  28371 },                          -- Netherfury Cape
				{ 7,  28229 },                          -- Incanter's Robe
				{ 8,  28342 },                          -- Warp-Infused Drape
				{ 9,  32072 },                          -- Gauntlets of Dissension
				{ 10, 29258 },                          -- Boots of Ethereal Manipulation
				{ 11, 29262 },                          -- Boots of the Endless Hunt
				{ 12, 28370 },                          -- Bangle of Endless Blessings
				{ 14, 24311,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Whitemend Hood
				{ 16, 31085,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Top Shard of the Arcatraz Key
				{ 18, "ac659" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 17, 33859,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Warp Splinter Clipping
				{ 18, nil },
				{ 19, "ac680" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188400 }, -- Feral Staff of Lashing
				{ 2,  188395 }, -- Greatsword of Forlorn Visions
				{ 3,  188387 }, -- Warpstaff of Arcanum
				{ 4,  188390 }, -- Warp Splinter's Thorn
				{ 5,  188389 }, -- Jagged Bark Pendant
				{ 6,  188397 }, -- Netherfury Cape
				{ 7,  188368 }, -- Incanter's Robe
				{ 8,  188388 }, -- Warp-Infused Drape
				{ 9,  188401 }, -- Gauntlets of Dissension
				{ 10, 188398 }, -- Boots of Ethereal Manipulation
				{ 11, 188399 }, -- Boots of the Endless Hunt
				{ 12, 188396 }, -- Bangle of Endless Blessings
			},
		},
		{ --TKTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 24172 }, -- Design: Coronet of Verdant Flame
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["TempestKeepMechanar"] = {
	EncounterJournalID = 258,
	MapID = 267,
	AtlasMapID = "TempestKeepMechanar",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --TKMechCapacitus
			EncounterJournalID = 563,
			[NORMAL_DIFF] = {
				{ 1, 28253 },                         -- Plasma Rat's Hyper-Scythe
				{ 2, 28257 },                         -- Hammer of the Penitent
				{ 3, 28254 },                         -- Warp Engineer's Prismatic Chain
				{ 4, 28255 },                         -- Lunar-Claw Pauldrons
				{ 5, 28256 },                         -- Thoriumweave Cloak
				{ 7, 35582, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Schematic: Rocket Boots Xtreme Lite
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --TKMechCacheoftheLegion
			name = AL["Cache of the Legion"],
			[NORMAL_DIFF] = {
				{ 1, 28249 }, -- Capacitus' Cloak of Calibration
				{ 2, 28250 }, -- Vestia's Pauldrons of Inner Grace
				{ 3, 28252 }, -- Bloodfyre Robes of Annihilation
				{ 4, 28251 }, -- Boots of the Glade-Keeper
				{ 6, 72663 }, -- Blinding Fury
			},
		},
		{ --TKMechSepethrea
			EncounterJournalID = 564,
			[NORMAL_DIFF] = {
				{ 1, 28263 },                         -- Stellaris
				{ 2, 28260 },                         -- Manual of the Nethermancer
				{ 3, 28275 },                         -- Beast Lord Helm
				{ 4, 28262 },                         -- Jade-Skull Breastplate
				{ 5, 28202 },                         -- Moonglade Robe
				{ 6, 28259 },                         -- Cosmic Lifeband
				{ 8, 22920, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Recipe: Major Fire Protection Potion
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --TKMechCalc
			EncounterJournalID = 565,
			[NORMAL_DIFF] = {
				{ 1,  28267 },                          -- Edge of the Cosmos
				{ 2,  27899 },                          -- Mana Wrath
				{ 3,  29362 },                          -- The Sun Eater
				{ 4,  28286 },                          -- Telescopic Sharprifle
				{ 5,  28285 },                          -- Helm of the Righteous
				{ 6,  28278 },                          -- Incanter's Cowl
				{ 7,  28269 },                          -- Baba's Cloak of Arcanistry
				{ 8,  28204 },                          -- Tunic of Assassination
				{ 9,  32076 },                          -- Handguards of the Steady
				{ 10, 28266 },                          -- Molten Earth Kilt
				{ 11, 30533 },                          -- Vanquisher's Legplates
				{ 12, 29251 },                          -- Boots of the Pious
				{ 13, 28265 },                          -- Dath'Remar's Ring of Defense
				{ 14, 28288 },                          -- Abacus of Violent Odds
				{ 16, 21907,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Arcanoweave Robe
				{ 18, 31086,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Bottom Shard of the Arcatraz Key
				{ 20, "ac658" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 19, 33860,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pathaleon's Projector
				{ 20, nil },
				{ 21, "ac679" },
			},
		},
		{ --TKTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 22920 }, -- Recipe: Major Fire Protection Potion
				{ 2, 21906 }, -- Pattern: Arcanoweave Boots
				{ 4, "INV_Box_01", nil, AL["Overcharged Manacell"], nil },
				{ 5, 30824 }, -- Overcharged Manacell
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["HCTheShatteredHalls"] = {
	EncounterJournalID = 259,
	MapID = 246,
	AtlasMapID = "HCTheShatteredHalls",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --HCHallsNethekurse
			EncounterJournalID = 566,
			[NORMAL_DIFF] = {
				{ 1,  27534 },                         -- Hortus' Seal of Brilliance
				{ 2,  27520 },                         -- Greathelm of the Unbreakable
				{ 3,  27519 },                         -- Cloak of Malice
				{ 4,  27517 },                         -- Bands of Nethekurse
				{ 5,  27521 },                         -- Telaari Hunting Girdle
				{ 6,  27529 },                         -- Figurine of the Colossus
				{ 8,  24312, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Spellstrike Hood
				{ 10, 23735, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Grand Warlock's Amulet
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 11, 25462, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Tome of Dusk
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 123995 }, -- Hortus' Seal of Brilliance
				{ 2, 123984 }, -- Greathelm of the Unbreakable
				{ 3, 123983 }, -- Cloak of Malice
				{ 4, 123981 }, -- Bands of Nethekurse
				{ 5, 123985 }, -- Telaari Hunting Girdle
				{ 6, 123992 }, -- Figurine of the Colossus
			},
		},
		{ --HCHallsPorung
			EncounterJournalID = 728,
			[HEROIC_DIFF] = {
				{ 1, 30710 }, -- Blood Guard's Necklace of Ferocity
				{ 2, 30705 }, -- Spaulders of Slaughter
				{ 3, 27474 }, -- Beast Lord Handguards
				{ 4, 27536 }, -- Hallowed Handwraps
				{ 5, 30708 }, -- Belt of Flowing Thought
				{ 6, 30709 }, -- Pantaloons of Flaming Wrath
				{ 7, 30707 }, -- Nimble-Foot Treads
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 124015 }, -- Blood Guard's Necklace of Ferocity
				{ 2, 124000 }, -- Justice Bearer's Pauldrons
				{ 3, 124011 }, -- Spaulders of Slaughter
				{ 4, 123997 }, -- Hallowed Handwraps
				{ 5, 124013 }, -- Belt of Flowing Thought
				{ 6, 124014 }, -- Pantaloons of Flaming Wrath
				{ 7, 124012 }, -- Nimble-Foot Treads
			},
		},
		{ --HCHallsOmrogg
			EncounterJournalID = 568,
			[NORMAL_DIFF] = {
				{ 1,  27524 },                         -- Firemaul of Destruction
				{ 2,  27868 },                         -- Runesong Dagger
				{ 3,  27526 },                         -- Skyfire Hawk-Bow
				{ 4,  29263 },                         -- Forestheart Bracers
				{ 5,  27522 },                         -- World's End Bracers
				{ 6,  29254 },                         -- Boots of the Righteous Path
				{ 7,  27525 },                         -- Jeweled Boots of Sanctification
				{ 9,  72597, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- O'mrogg's Warcloth
				{ 10, 30829, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Tear of the Earthmother
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 123987 }, -- Firemaul of Destruction
				{ 2, 124002 }, -- Runesong Dagger
				{ 3, 123989 }, -- Skyfire Hawk-Bow
				{ 4, 124029 }, -- Forestheart Bracers
				{ 5, 123986 }, -- World's End Bracers
				{ 6, 124027 }, -- Boots of the Righteous Path
				{ 7, 123988 }, -- Jeweled Boots of Sanctification
			},
		},
		{ --HCHallsKargath
			EncounterJournalID = 569,
			[NORMAL_DIFF] = {
				{ 1,  27533 },                          -- Demonblood Eviscerator
				{ 2,  27538 },                          -- Lightsworn Hammer
				{ 3,  29348 },                          -- The Bladefist
				{ 4,  27540 },                          -- Nexus Torch
				{ 5,  27802 },                          -- Tidefury Shoulderguards
				{ 6,  29255 },                          -- Bands of Rarefied Magic
				{ 7,  27528 },                          -- Gauntlets of Desolation
				{ 8,  27535 },                          -- Gauntlets of the Righteous
				{ 9,  27537 },                          -- Gloves of Oblivion
				{ 10, 27531 },                          -- Wastewalker Gloves
				{ 11, 27527 },                          -- Greaves of the Shatterer
				{ 13, 23723,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Warchief Kargath's Fist
				{ 16, "ac657" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 14, 33815,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Bladefist's Seal
				{ 16, "ac678" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  123994 }, -- Demonblood Eviscerator
				{ 2,  123999 }, -- Lightsworn Hammer
				{ 3,  124030 }, -- The Bladefist
				{ 4,  124001 }, -- Nexus Torch
				{ 5,  124028 }, -- Bands of Rarefied Magic
				{ 6,  123991 }, -- Gauntlets of Desolation
				{ 7,  123996 }, -- Gauntlets of the Righteous
				{ 8,  123998 }, -- Gloves of Oblivion
				{ 9,  123993 }, -- Wastewalker Gloves
				{ 10, 123990 }, -- Greaves of the Shatterer
			},
		},
		{ --HCHallsTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 22554 }, -- Formula: Enchant 2H Weapon - Savagery
				{ 3, "INV_Box_01", nil, AL["Shattered Hand Executioner"], nil },
				{ 4, 31716 }, -- Unused Axe of the Executioner
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --HonorHold
			FactionID = 946,
			ExtraList = true,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:4",
		},
		{ --Thrallmar
			FactionID = 947,
			ExtraList = true,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:21",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CFRTheSlavePens"] = {
	EncounterJournalID = 260,
	MapID = 265,
	AtlasMapID = "CFRTheSlavePens",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --CFRSlaveMennu
			EncounterJournalID = 570,
			[NORMAL_DIFF] = {
				{ 1,  24361 }, -- Spellfire Longsword
				{ 2,  27543 }, -- Starlight Dagger
				{ 3,  24356 }, -- Wastewalker Shiv
				{ 4,  27546 }, -- Traitor's Noose
				{ 5,  24357 }, -- Vest of Living Lightning
				{ 6,  27541 }, -- Archery Belt of the Broken
				{ 7,  27542 }, -- Cord of Belief
				{ 8,  24360 }, -- Tracker's Belt
				{ 9,  27545 }, -- Mennu's Scaled Leggings
				{ 10, 24359 }, -- Princely Reign Leggings
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CFRSlaveRokmar
			EncounterJournalID = 571,
			[NORMAL_DIFF] = {
				{ 1,  24378 },                         -- Coilfang Hammer of Renewal
				{ 2,  24380 },                         -- Calming Spore Reed
				{ 3,  24381 },                         -- Coilfang Needler
				{ 4,  27551 },                         -- Skeletal Necklace of Battlerage
				{ 5,  24379 },                         -- Bogstrok Scale Cloak
				{ 6,  27550 },                         -- Ironscale War Cloak
				{ 7,  27547 },                         -- Coldwhisper Cord
				{ 8,  27548 },                         -- Girdle of Many Blessings
				{ 9,  28124 },                         -- Liar's Cord
				{ 10, 27549 },                         -- Wavefury Boots
				{ 11, 24376 },                         -- Runed Fungalcap
				{ 13, 72118, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Invader's Claw
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CFRSlaveQuagmirran
			EncounterJournalID = 572,
			[NORMAL_DIFF] = {
				{ 1,  27741 },                          -- Bleeding Hollow Warhammer
				{ 2,  27673 },                          -- Phosphorescent Blade
				{ 3,  27714 },                          -- Swamplight Lantern
				{ 4,  29349 },                          -- Adamantine Chain of the Unbroken
				{ 5,  27796 },                          -- Mana-Etched Spaulders
				{ 6,  27713 },                          -- Pauldrons of Desolation
				{ 7,  32078 },                          -- Pauldrons of Wild Magic
				{ 8,  24366 },                          -- Scorpid-Sting Mantle
				{ 9,  24362 },                          -- Spore-Soaked Vaneer
				{ 10, 28337 },                          -- Breastplate of Righteous Fury
				{ 11, 24363 },                          -- Unscarred Breastplate
				{ 12, 27712 },                          -- Shackles of Quagmirran
				{ 13, 24365 },                          -- Deft Handguards
				{ 14, 27672 },                          -- Girdle of the Immovable
				{ 15, 27742 },                          -- Mage-Fury Girdle
				{ 16, 24364 },                          -- Azureplate Greaves
				{ 17, 27800 },                          -- Earthsoul Britches
				{ 18, 30538 },                          -- Midnight Legguards
				{ 19, 29242 },                          -- Boots of Blasphemy
				{ 20, 27740 },                          -- Band of Ursol
				{ 21, 27683 },                          -- Quagmirran's Eye
				{ 23, 72119,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Slave Master's Eye
				{ 25, "ac649" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 24, 33821,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Heart of Quagmirran
				{ 25, nil },
				{ 26, "ac669" },
			},
		},
		{ --MidsummerFireFestivalAhune
			name = AL["Ahune"].." ("..AL["Midsummer Fire Festival"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:MidsummerFireFestival:1",
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CFRTheSteamvault"] = {
	EncounterJournalID = 261,
	MapID = 263,
	AtlasMapID = "CFRTheSteamvault",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --CFRSteamThespia
			EncounterJournalID = 573,
			[NORMAL_DIFF] = {
				{ 1, 27789 },                         -- Cloak of Whispering Shells
				{ 2, 27806 },                         -- Fathomheart Gauntlets
				{ 3, 27475 },                         -- Gauntlets of the Bold
				{ 4, 27508 },                         -- Incanter's Gloves
				{ 5, 27783 },                         -- Moonrage Girdle
				{ 6, 27784 },                         -- Scintillating Coral Band
				{ 8, 30828, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Vial of Underworld Loam
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CFRSteamSteamrigger
			EncounterJournalID = 574,
			[NORMAL_DIFF] = {
				{ 1,  27791 },                         -- Serpentcrest Life-Staff
				{ 2,  27794 },                         -- Recoilless Rocket Ripper X-54
				{ 3,  27790 },                         -- Mask of Penance
				{ 4,  27792 },                         -- Steam-Hinge Chain of Valor
				{ 5,  27787 },                         -- Chestguard of No Remorse
				{ 6,  27793 },                         -- Earth Mantle Handwraps
				{ 7,  27795 },                         -- Sash of Serpentra
				{ 9,  23887, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Schematic: Rocket Boots Xtreme
				{ 11, 72574, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Irradiated Gear
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CFRSteamWarlord
			EncounterJournalID = 575,
			[NORMAL_DIFF] = {
				{ 1,  29351 },                          -- Wrathtide Longbow
				{ 2,  27801 },                          -- Beast Lord Mantle
				{ 3,  27738 },                          -- Incanter's Pauldrons
				{ 4,  27737 },                          -- Moonglade Shoulders
				{ 5,  27804 },                          -- Devilshark Cape
				{ 6,  28203 },                          -- Breastplate of the Righteous
				{ 7,  27799 },                          -- Vermillion Robes of the Dominant
				{ 8,  29463 },                          -- Amber Bands of the Aggressor
				{ 9,  29243 },                          -- Wave-Fury Vambraces
				{ 10, 27510 },                          -- Tidefury Gauntlets
				{ 11, 27874 },                          -- Beast Lord Leggings
				{ 12, 30543 },                          -- Pontifex Kilt
				{ 13, 27805 },                          -- Ring of the Silver Hand
				{ 15, 24313,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Pattern: Battlecast Hood
				{ 16, "ac656" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, 31721,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Kalithresh's Trident
				{ 17, 33827,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Warlord's Treatise
				{ 19, "ac677" },
			},
		},
		{ --CFRSteamTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  24159 }, -- Design: Khorium Band of Frost
				{ 3,  22533 }, -- Formula: Enchant Bracer - Fortitude
				{ 5,  24367 }, -- Orders from Lady Vashj
				{ 16, "INV_Box_01", nil, AL["Second Fragment Guardian"], nil },
				{ 17, 24487 }, -- Second Key Fragment
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CFRTheUnderbog"] = {
	EncounterJournalID = 262,
	MapID = 262,
	AtlasMapID = "CFRTheUnderbog",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --CFRUnderHungarfen
			EncounterJournalID = 576,
			[NORMAL_DIFF] = {
				{ 1, 27747 }, -- Boggspine Knuckles
				{ 2, 27746 }, -- Arcanium Signet Bands
				{ 3, 24451 }, -- Lykul Bloodbands
				{ 4, 27745 }, -- Hungarhide Gauntlets
				{ 5, 24450 }, -- Manaspark Gloves
				{ 6, 24452 }, -- Starlight Gauntlets
				{ 7, 27743 }, -- Girdle of Living Flame
				{ 8, 27748 }, -- Cassock of the Loyal
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188336 }, -- Boggspine Knuckles
				{ 2, 188316 }, -- Lykul Bloodbands
				{ 3, 188335 }, -- Arcanium Signet Bands
				{ 4, 188317 }, -- Starlight Gauntlets
				{ 5, 188334 }, -- Hungarhide Gauntlets
				{ 6, 188315 }, -- Manaspark Gloves
				{ 7, 188333 }, -- Girdle of Living Flame
				{ 8, 188337 }, -- Cassock of the Loyal
			},
		},
		{ --CFRUnderGhazan
			EncounterJournalID = 577,
			[NORMAL_DIFF] = {
				{ 1,  27757 }, -- Greatstaff of the Leviathan
				{ 2,  24461 }, -- Hatebringer
				{ 3,  27759 }, -- Headdress of the Tides
				{ 4,  27758 }, -- Hydra-Fang Necklace
				{ 5,  24462 }, -- Luminous Pearls of Insight
				{ 6,  24460 }, -- Talisman of Tenacity
				{ 7,  24459 }, -- Cloak of Healing Rays
				{ 8,  27760 }, -- Dunewind Sash
				{ 9,  27755 }, -- Girdle of Gallantry
				{ 10, 24458 }, -- Studded Girdle of Virtue
				{ 11, 27761 }, -- Ring of the Shadow Deeps
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188339 }, -- Greatstaff of the Leviathan
				{ 2,  188326 }, -- Hatebringer
				{ 3,  188341 }, -- Headdress of the Tides
				{ 4,  188340 }, -- Hydra-Fang Necklace
				{ 5,  188327 }, -- Luminous Pearls of Insight
				{ 6,  188325 }, -- Talisman of Tenacity
				{ 7,  188324 }, -- Cloak of Healing Rays
				{ 8,  188342 }, -- Dunewind Sash
				{ 9,  188338 }, -- Girdle of Gallantry
				{ 10, 188323 }, -- Studded Girdle of Virtue
				{ 11, 188343 }, -- Ring of the Shadow Deeps
			},
		},
		{ --CFRUnderSwamplord
			EncounterJournalID = 578,
			[NORMAL_DIFF] = {
				{ 1,  27767 }, -- Bogreaver
				{ 2,  24453 }, -- Zangartooth Shortblade
				{ 3,  27763 }, -- Crown of the Forest Lord
				{ 4,  27766 }, -- Swampstone Necklace
				{ 5,  24457 }, -- Truth Bearer Shoulderguards
				{ 6,  24454 }, -- Cloak of Enduring Swiftness
				{ 7,  24455 }, -- Tunic of the Nightwatcher
				{ 8,  27765 }, -- Armwraps of Disdain
				{ 9,  27764 }, -- Hands of the Sun
				{ 10, 24456 }, -- Greaves of the Iron Guardian
				{ 11, 27762 }, -- Weathered Band of the Swamplord
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188349 }, -- Bogreaver
				{ 2,  188318 }, -- Zangartooth Shortblade
				{ 3,  188345 }, -- Crown of the Forest Lord
				{ 4,  188348 }, -- Swampstone Necklace
				{ 5,  188322 }, -- Truth Bearer Shoulderguards
				{ 6,  188319 }, -- Cloak of Enduring Swiftness
				{ 7,  188320 }, -- Tunic of the Nightwatcher
				{ 8,  188347 }, -- Armwraps of Disdain
				{ 9,  188346 }, -- Hands of the Sun
				{ 10, 188321 }, -- Greaves of the Iron Guardian
				{ 11, 188344 }, -- Weathered Band of the Swamplord
			},
		},
		{ --CFRUnderStalker
			EncounterJournalID = 579,
			[NORMAL_DIFF] = {
				{ 1,  27769 },                          -- Endbringer
				{ 2,  24464 },                          -- The Stalker's Fangs
				{ 3,  29350 },                          -- The Black Stalk
				{ 4,  27772 },                          -- Stormshield of Renewal
				{ 5,  27781 },                          -- Demonfang Ritual Helm
				{ 6,  27938 },                          -- Savage Mask of the Lynx Lord
				{ 7,  27779 },                          -- Bone Chain Necklace
				{ 8,  27771 },                          -- Doomplate Shoulderguards
				{ 9,  24463 },                          -- Pauldrons of Brute Force
				{ 10, 24481 },                          -- Robes of the Augurer
				{ 11, 24465 },                          -- Shamblehide Chestguard
				{ 12, 27768 },                          -- Oracle Belt of Timeless Mystery
				{ 13, 27773 },                          -- Barbaric Legstraps
				{ 14, 27907 },                          -- Mana-Etched Pantaloons
				{ 15, 24466 },                          -- Skulldugger's Leggings
				{ 16, 30541 },                          -- Stormsong Kilt
				{ 17, 29265 },                          -- Barkchip Boots
				{ 18, 32081 },                          -- Eye of the Stalker
				{ 19, 27780 },                          -- Ring of Fabled Hope
				{ 20, 27896 },                          -- Alembic of Infernal Power
				{ 21, 27770 },                          -- Argussian Compass
				{ 23, 24248,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Brain of the Black Stalker
				{ 25, "ac650" },
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 24, 33826,  [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Black Stalker Egg
				{ 25, nil },
				{ 26, "ac670" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188351 }, -- Endbringer
				{ 2,  188329 }, -- The Stalker's Fangs
				{ 3,  188363 }, -- The Black Stalk
				{ 4,  188354 }, -- Stormshield of Renewal
				{ 5,  188358 }, -- Demonfang Ritual Helm
				{ 6,  188361 }, -- Savage Mask of the Lynx Lord
				{ 7,  188356 }, -- Bone Chain Necklace
				{ 8,  188353 }, -- Doomplate Shoulderguards
				{ 9,  188328 }, -- Pauldrons of Brute Force
				{ 10, 188332 }, -- Robes of the Augurer
				{ 11, 188330 }, -- Shamblehide Chestguard
				{ 12, 188350 }, -- Oracle Belt of Timeless Mystery
				{ 13, 188360 }, -- Mana-Etched Pantaloons
				{ 14, 188364 }, -- Stormsong Kilt
				{ 15, 188355 }, -- Barbaric Legstraps
				{ 16, 188331 }, -- Skulldugger's Leggings
				{ 17, 188362 }, -- Barkchip Boots
				{ 18, 188357 }, -- Ring of Fabled Hope
				{ 19, 188365 }, -- Eye of the Stalker
				{ 20, 188359 }, -- Alembic of Infernal Power
				{ 21, 188352 }, -- Argussian Compass
			},
		},
		{ --Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{ --CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["BlackTemple"] = {
	EncounterJournalID = 751,
	MapID = 339,
	AtlasMapID = "BlackTempleStart",
	ContentType = RAID_CONTENT,
	items = {
		{ --BTNajentus
			EncounterJournalID = 1582,
			[P25_DIFF] = {
				{ 1,  32239 }, -- Slippers of the Seacaller
				{ 2,  32240 }, -- Guise of the Tidal Lurker
				{ 3,  32377 }, -- Mantle of Darkness
				{ 4,  32241 }, -- Helm of Soothing Currents
				{ 5,  32234 }, -- Fists of Mukoa
				{ 6,  32242 }, -- Boots of Oceanic Fury
				{ 7,  32232 }, -- Eternium Shell Bracers
				{ 8,  32243 }, -- Pearl Inlaid Boots
				{ 9,  32245 }, -- Tide-Stomper's Greaves
				{ 16, 32238 }, -- Ring of Calming Waves
				{ 17, 32247 }, -- Ring of Captured Storms
				{ 19, 32237 }, -- The Maelstrom's Fury
				{ 20, 32236 }, -- Rising Tide
				{ 21, 32248 }, -- Halberd of Desolation
				{ 23, 122104, "pet1623" }, -- Leviathan Hatchling
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150447 }, -- Halberd of Desolation
				{ 2,  150438 }, -- The Maelstrom's Fury
				{ 3,  150437 }, -- Rising Tide
				{ 4,  150481 }, -- Cowl of Benevolence
				{ 5,  150441 }, -- Guise of the Tidal Lurker
				{ 6,  150520 }, -- Mantle of Darkness
				{ 7,  150434 }, -- Eternium Shell Bracers
				{ 8,  150435 }, -- Fists of Mukoa
				{ 9,  150443 }, -- Boots of Oceanic Fury
				{ 10, 150444 }, -- Pearl Inlaid Boots
				{ 11, 150445 }, -- Tide-Stomper's Greaves
				{ 12, 150440 }, -- Slippers of the Seacaller
				{ 14, 122104, "pet1623" }, -- Leviathan Hatchling
			},
		},
		{ --BTSupremus
			EncounterJournalID = 1583,
			[P25_DIFF] = {
				{ 1,  32256 }, -- Waistwrap of Infinity
				{ 2,  32252 }, -- Nether Shadow Tunic
				{ 3,  32259 }, -- Bands of the Coming Storm
				{ 4,  32251 }, -- Wraps of Precise Flight
				{ 5,  32258 }, -- Naturalist's Preserving Cinch
				{ 6,  32250 }, -- Pauldrons of Abyssal Fury
				{ 8,  32260 }, -- Choker of Endless Nightmares
				{ 9,  32261 }, -- Band of the Abyssal Lord
				{ 16, 32254 }, -- The Brutalizer
				{ 17, 32262 }, -- Syphon of the Nathrezim
				{ 18, 32255 }, -- Felstone Bulwark
				{ 19, 32253 }, -- Legionkiller
				{ 21, 122106, "pet1624" }, -- Abyssius
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150460 }, -- Syphon of the Nathrezim
				{ 2,  150451 }, -- Legionkiller
				{ 3,  150453 }, -- Felstone Bulwark
				{ 4,  150532 }, -- Veil of Turning Leaves
				{ 5,  150454 }, -- Waistwrap of Infinity
				{ 6,  150456 }, -- Naturalist's Preserving Cinch
				{ 7,  150512 }, -- Leggings of Devastation
				{ 8,  150459 }, -- Band of the Abyssal Lord
				{ 10, 122106, "pet1624" }, -- Abyssius
			},
		},
		{ --BTAkama
			EncounterJournalID = 1584,
			[P25_DIFF] = {
				{ 1,  32273 }, -- Amice of Brilliant Light
				{ 2,  32270 }, -- Focused Mana Bindings
				{ 3,  32513 }, -- Wristbands of Divine Influence
				{ 4,  32265 }, -- Shadow-Walker's Cord
				{ 5,  32271 }, -- Kilt of Immortal Nature
				{ 6,  32264 }, -- Shoulders of the Hidden Predator
				{ 7,  32275 }, -- Spiritwalker Gauntlets
				{ 8,  32276 }, -- Flashfire Girdle
				{ 9,  32279 }, -- The Seeker's Wristguards
				{ 10, 32278 }, -- Grips of Silent Justice
				{ 11, 32263 }, -- Praetorian's Legguards
				{ 12, 32268 }, -- Myrmidon's Treads
				{ 16, 32266 }, -- Ring of Deceitful Intent
				{ 18, 32361 }, -- Blind-Seers Icon
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1, 150452 }, -- The Brutalizer
				{ 2, 150507 }, -- Blind-Seers Icon
				{ 3, 150469 }, -- Amice of Brilliant Light
				{ 4, 150535 }, -- Shroud of the Highborne
				{ 5, 150473 }, -- The Seeker's Wristguards
				{ 6, 150470 }, -- Spiritwalker Gauntlets
				{ 7, 150463 }, -- Shadow-Walker's Cord
			},
		},
		{ --BTBloodboil
			EncounterJournalID = 1586,
			[P25_DIFF] = {
				{ 1,  32337 }, -- Shroud of Forgiveness
				{ 2,  32338 }, -- Blood-Cursed Shoulderpads
				{ 3,  32340 }, -- Garments of Temperance
				{ 4,  32339 }, -- Belt of Primal Majesty
				{ 5,  32334 }, -- Vest of Mounting Assault
				{ 6,  32342 }, -- Girdle of Mighty Resolve
				{ 7,  32333 }, -- Girdle of Stability
				{ 8,  32341 }, -- Leggings of Divine Retribution
				{ 16, 32335 }, -- Unstoppable Aggressor's Ring
				{ 17, 32501 }, -- Shadowmoon Insignia
				{ 19, 32269 }, -- Messenger of Fate
				{ 20, 32344 }, -- Staff of Immaculate Recovery
				{ 21, 32343 }, -- Wand of Prismatic Focus
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150496 }, -- Staff of Immaculate Recovery
				{ 2,  150466 }, -- Messenger of Fate
				{ 3,  150495 }, -- Wand of Prismatic Focus
				{ 4,  150462 }, -- Shoulders of the Hidden Predator
				{ 5,  150486 }, -- Vest of Mounting Assault
				{ 6,  150530 }, -- Wristbands of Divine Influence
				{ 7,  150491 }, -- Belt of Primal Majesty
				{ 8,  150471 }, -- Flashfire Girdle
				{ 9,  150494 }, -- Girdle of Mighty Resolve
				{ 10, 150493 }, -- Leggings of Divine Retribution
				{ 11, 150511 }, -- Shadowmaster's Boots
				{ 12, 150526 }, -- Shadowmoon Insignia
			},
		},
		{ --BTReliquaryofSouls
			EncounterJournalID = 1587,
			[P25_DIFF] = {
				{ 1,  32353 }, -- Gloves of Unfailing Faith
				{ 2,  32351 }, -- Elunite Empowered Bracers
				{ 3,  32347 }, -- Grips of Damnation
				{ 4,  32352 }, -- Naturewarden's Treads
				{ 5,  32517 }, -- The Wavemender's Mantle
				{ 6,  32346 }, -- Boneweave Girdle
				{ 7,  32354 }, -- Crown of Empowered Fate
				{ 8,  32345 }, -- Dreadboots of the Legion
				{ 16, 32349 }, -- Translucent Spellthread Necklace
				{ 17, 32362 }, -- Pendant of Titans
				{ 19, 32332 }, -- Torch of the Damned
				{ 20, 32363 }, -- Naaru-Blessed Life Rod
				{ 21, 32350 }, -- Touch of Inspiration
				{ 23, 122107, "pet1625" }, -- Fragment of Anger
				{ 24, 122108, "pet1626" }, -- Fragment of Suffering
				{ 25, 122109, "pet1627" }, -- Fragment of Desire
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150484 }, -- Torch of the Damned
				{ 2,  150509 }, -- Naaru-Blessed Life Rod
				{ 3,  150506 }, -- Crown of Empowered Fate
				{ 4,  150490 }, -- Blood-Cursed Shoulderpads
				{ 5,  150531 }, -- The Wavemender's Mantle
				{ 6,  150503 }, -- Elunite Empowered Bracers
				{ 7,  150505 }, -- Gloves of Unfailing Faith
				{ 8,  150499 }, -- Grips of Damnation
				{ 9,  150498 }, -- Boneweave Girdle
				{ 10, 150485 }, -- Girdle of Stability
				{ 11, 150497 }, -- Dreadboots of the Legion
				{ 12, 150504 }, -- Naturewarden's Treads
				{ 16, 122107, "pet1625" }, -- Fragment of Anger
				{ 17, 122108, "pet1626" }, -- Fragment of Suffering
				{ 18, 122109, "pet1627" }, -- Fragment of Desire
			},
		},
		{ --BTGorefiend
			EncounterJournalID = 1585,
			[P25_DIFF] = {
				{ 1,  32323 }, -- Shadowmoon Destroyer's Drape
				{ 2,  32329 }, -- Cowl of Benevolence
				{ 3,  32327 }, -- Robe of the Shadow Council
				{ 4,  32324 }, -- Insidious Bands
				{ 5,  32328 }, -- Botanist's Gloves of Growth
				{ 6,  32510 }, -- Softstep Boots of Tracking
				{ 7,  32280 }, -- Gauntlets of Enforcement
				{ 8,  32512 }, -- Girdle of Lordaeron's Fallen
				{ 16, 32348 }, -- Soul Cleaver
				{ 17, 32325 }, -- Rifle of the Stoic Guardian
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150500 }, -- Soul Cleaver
				{ 2,  150477 }, -- Rifle of the Stoic Guardian
				{ 3,  150475 }, -- Shadowmoon Destroyer's Drape
				{ 4,  150479 }, -- Robe of the Shadow Council
				{ 5,  150476 }, -- Insidious Bands
				{ 6,  150480 }, -- Botanist's Gloves of Growth
				{ 7,  150474 }, -- Gauntlets of Enforcement
				{ 8,  150533 }, -- Belt of Divine Guidance
				{ 9,  150529 }, -- Girdle of Lordaeron's Fallen
				{ 10, 150528 }, -- Softstep Boots of Tracking
			},
		},
		{ --BTShahraz
			EncounterJournalID = 1588,
			[P25_DIFF] = {
				{ 1,  32367 }, -- Leggings of Devastation
				{ 2,  32366 }, -- Shadowmaster's Boots
				{ 3,  32365 }, -- Heartshatter Breastplate
				{ 4,  32370 }, -- Nadina's Pendant of Purity
				{ 5,  32369 }, -- Blade of Savagery
				{ 16, 31101 }, -- Pauldrons of the Forgotten Conqueror
				{ 17, 31103 }, -- Pauldrons of the Forgotten Protector
				{ 18, 31102 }, -- Pauldrons of the Forgotten Vanquisher
				{ 20, 122110, "pet1628" }, -- Sister of Temptation
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150514 }, -- Blade of Savagery
				{ 2,  150519 }, -- Forest Prowler's Helm
				{ 3,  150442 }, -- Helm of Soothing Currents
				{ 4,  150516 }, -- Helm of the Illidari Shatterer
				{ 5,  150571 }, -- Gronnstalker's Spaulders
				{ 6,  150935 }, -- Illidari Shoulderpads
				{ 7,  150556 }, -- Lightbringer Shoulderguards
				{ 8,  150558 }, -- Mantle of the Malefic
				{ 9,  150568 }, -- Mantle of the Tempest
				{ 10, 150555 }, -- Onslaught Shoulderguards
				{ 11, 150768 }, -- Shoulderguards of the Broken Sage
				{ 12, 150565 }, -- Shoulderpads of Absolution
				{ 13, 150560 }, -- Skyshatter Mantle
				{ 14, 150563 }, -- Slayer's Shoulderpads
				{ 15, 150573 }, -- Thunderheart Spaulders
				{ 16, 150765 }, -- Undying Vigil Shoulderguards
				{ 17, 150492 }, -- Garments of Temperance
				{ 18, 150510 }, -- Heartshatter Breastplate
				{ 19, 150467 }, -- Focused Mana Bindings
				{ 20, 150468 }, -- Kilt of Immortal Nature
				{ 22, 122110, "pet1628" }, -- Sister of Temptation
			},
		},
		{ --BTCouncil
			EncounterJournalID = 1589,
			[P25_DIFF] = {
				{ 1,  32331 }, -- Cloak of the Illidari Council
				{ 2,  32519 }, -- Belt of Divine Guidance
				{ 3,  32518 }, -- Veil of Turning Leaves
				{ 4,  32376 }, -- Forest Prowler's Helm
				{ 5,  32373 }, -- Helm of the Illidari Shatterer
				{ 6,  32505 }, -- Madness of the Betrayer
				{ 16, 31098 }, -- Leggings of the Forgotten Conqueror
				{ 17, 31100 }, -- Leggings of the Forgotten Protector
				{ 18, 31099 }, -- Leggings of the Forgotten Vanquisher
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150536 }, -- Cowl of the Illidari High Lord
				{ 2,  150483 }, -- Cloak of the Illidari Council
				{ 3,  150572 }, -- Gronnstalker's Leggings
				{ 4,  150933 }, -- Illidari Leggings
				{ 5,  150567 }, -- Leggings of Absolution
				{ 6,  150580 }, -- Leggings of the Malefic
				{ 7,  150570 }, -- Leggings of the Tempest
				{ 8,  150769 }, -- Legwraps of the Broken Sage
				{ 9,  150557 }, -- Lightbringer Legguards
				{ 10, 150554 }, -- Onslaught Legguards
				{ 11, 150562 }, -- Skyshatter Legguards
				{ 12, 150564 }, -- Slayer's Legguards
				{ 13, 150575 }, -- Thunderheart Legguards
				{ 14, 150766 }, -- Undying Vigil Legplates
				{ 15, 150527 }, -- Madness of the Betrayer
			},
		},
		{ --BTIllidanStormrage
			EncounterJournalID = 1590,
			[P25_DIFF] = {
				{ 1,  32524 }, -- Shroud of the Highborne
				{ 2,  32525 }, -- Cowl of the Illidari High Lord
				{ 3,  32235 }, -- Cursed Vision of Sargeras
				{ 4,  32521 }, -- Faceplate of the Impenetrable
				{ 6,  32497 }, -- Stormrage Signet Ring
				{ 7,  32483 }, -- The Skull of Gul'dan
				{ 8,  32496 }, -- Memento of Tyrande
				{ 10, 32837 }, -- Warglaive of Azzinoth
				{ 11, 32838 }, -- Warglaive of Azzinoth
				{ 16, 31089 }, -- Chestguard of the Forgotten Conqueror
				{ 17, 31091 }, -- Chestguard of the Forgotten Protector
				{ 18, 31090 }, -- Chestguard of the Forgotten Vanquisher
				{ 20, 32471 }, -- Shard of Azzinoth
				{ 21, 32500 }, -- Crystal Spire of Karabor
				{ 22, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
				{ 23, 32375 }, -- Bulwark of Azzinoth
				{ 24, 32336 }, -- Black Bow of the Betrayer
				{ 26, "ac697" },
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  150517 }, -- Zhar'doom, Greatstaff of the Devourer
				{ 2,  150525 }, -- Crystal Spire of Karabor
				{ 3,  150521 }, -- Shard of Azzinoth
				{ 4,  150488 }, -- Black Bow of the Betrayer
				{ 5,  150518 }, -- Bulwark of Azzinoth
				{ 6,  150436 }, -- Cursed Vision of Sargeras
				{ 7,  150534 }, -- Faceplate of the Impenetrable
				{ 8,  150553 }, -- Gronnstalker's Chestguard
				{ 9,  150934 }, -- Illidari Robe
				{ 10, 150770 }, -- Jerkin of the Broken Sage
				{ 11, 150552 }, -- Lightbringer Chestguard
				{ 12, 150551 }, -- Onslaught Chestguard
				{ 13, 150559 }, -- Robe of the Malefic
				{ 14, 150569 }, -- Robes of the Tempest
				{ 15, 150566 }, -- Shroud of Absolution
				{ 16, 150561 }, -- Skyshatter Breastplate
				{ 17, 150550 }, -- Slayer's Chestguard
				{ 18, 150574 }, -- Thunderheart Tunic
				{ 19, 150767 }, -- Undying Vigil Battleplate
				{ 20, 150524 }, -- Stormrage Signet Ring
				{ 21, 150523 }, -- Memento of Tyrande
				{ 22, 150522 }, -- The Skull of Gul'dan
			},
		},
		{ --BTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  32590 }, -- Nethervoid Cloak
				{ 2,  34012 }, -- Shroud of the Final Stand
				{ 3,  32609 }, -- Boots of the Divine Light
				{ 4,  32593 }, -- Treads of the Den Mother
				{ 5,  32592 }, -- Chestguard of Relentless Storms
				{ 6,  32608 }, -- Pillager's Gauntlets
				{ 7,  32606 }, -- Girdle of the Lightbearer
				{ 8,  32591 }, -- Choker of Serrated Blades
				{ 9,  32589 }, -- Hellfire-Encased Pendant
				{ 10, 32526 }, -- Band of Devastation
				{ 11, 32528 }, -- Blessed Band of Karabor
				{ 12, 32527 }, -- Ring of Ancient Knowledge
				{ 16, 34009 }, -- Hammer of Judgement
				{ 17, 32943 }, -- Swiftsteel Bludgeon
				{ 18, 34011 }, -- Illidari Runeshield
				{ 20, 32228 }, -- Empyrean Sapphire
				{ 21, 32231 }, -- Pyrestone
				{ 22, 32229 }, -- Lionseye
				{ 23, 32249 }, -- Seaspray Emerald
				{ 24, 32230 }, -- Shadowsong Amethyst
				{ 25, 32227 }, -- Crimson Spinel
				{ 27, 32428 }, -- Heart of Darkness
				{ 28, 32897 }, -- Mark of the Illidari
			},
		},
		{ --BTPatterns
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 141)..")",
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  32738 }, -- Plans: Dawnsteel Bracers
				{ 2,  32739 }, -- Plans: Dawnsteel Shoulders
				{ 3,  32736 }, -- Plans: Swiftsteel Bracers
				{ 4,  32737 }, -- Plans: Swiftsteel Shoulders
				{ 5,  32748 }, -- Pattern: Bindings of Lightning Reflexes
				{ 6,  32744 }, -- Pattern: Bracers of Renewed Life
				{ 7,  32750 }, -- Pattern: Living Earth Bindings
				{ 8,  32751 }, -- Pattern: Living Earth Shoulders
				{ 9,  32749 }, -- Pattern: Shoulders of Lightning Reflexes
				{ 10, 32745 }, -- Pattern: Shoulderpads of Renewed Life
				{ 11, 32746 }, -- Pattern: Swiftstrike Bracers
				{ 12, 32747 }, -- Pattern: Swiftstrike Shoulders
				{ 16, 32754 }, -- Pattern: Bracers of Nimble Thought
				{ 17, 32755 }, -- Pattern: Mantle of Nimble Thought
				{ 18, 32753 }, -- Pattern: Swiftheal Mantle
				{ 19, 32752 }, -- Pattern: Swiftheal Wraps
			},
		},
		{ --Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:6",
		},
		{ --Ashtongue
			FactionID = 1012,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:1:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["GruulsLair"] = {
	EncounterJournalID = 746,
	MapID = 330,
	AtlasMapID = "GruulsLair",
	ContentType = RAID_CONTENT,
	items = {
		{ --GruulsLairHighKingMaulgar
			EncounterJournalID = 1564,
			[P25_DIFF] = {
				{ 1,  28797 }, -- Brute Cloak of the Ogre-Magi
				{ 2,  28799 }, -- Belt of Divine Inspiration
				{ 3,  28796 }, -- Malefic Mask of the Shadows
				{ 4,  28801 }, -- Maulgar's Warhelm
				{ 5,  28795 }, -- Bladespire Warbands
				{ 6,  28800 }, -- Hammer of the Naaru
				{ 16, 29763 }, -- Pauldrons of the Fallen Champion
				{ 17, 29764 }, -- Pauldrons of the Fallen Defender
				{ 18, 29762 }, -- Pauldrons of the Fallen Hero
			},
		},
		{ --GruulGruul
			EncounterJournalID = 1565,
			[P25_DIFF] = {
				{ 1,  28804 }, -- Collar of Cho'gall
				{ 2,  28803 }, -- Cowl of Nature's Breath
				{ 3,  28828 }, -- Gronn-Stitched Girdle
				{ 4,  28827 }, -- Gauntlets of the Dragonslayer
				{ 5,  28810 }, -- Windshear Boots
				{ 6,  28824 }, -- Gauntlets of Martial Perfection
				{ 7,  28822 }, -- Teeth of Gruul
				{ 8,  28823 }, -- Eye of Gruul
				{ 9,  28830 }, -- Dragonspine Trophy
				{ 16, 29766 }, -- Leggings of the Fallen Champion
				{ 17, 29767 }, -- Leggings of the Fallen Defender
				{ 18, 29765 }, -- Leggings of the Fallen Hero
				{ 20, 28802 }, -- Bloodmaw Magus-Blade
				{ 21, 28794 }, -- Axe of the Gronn Lords
				{ 22, 28825 }, -- Aldori Legacy Defender
				{ 24, "ac692" },
			},
		},
		{ --Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:4:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["CoTHyjal"] = {
	EncounterJournalID = 750,
	MapID = 329,
	AtlasMapID = "CoTHyjal",
	ContentType = RAID_CONTENT,
	items = {
		{ --MountHyjalWinterchill
			EncounterJournalID = 1577,
			[P25_DIFF] = {
				{ 1,  30871 }, -- Bracers of Martyrdom
				{ 2,  30870 }, -- Cuffs of Devastation
				{ 3,  30863 }, -- Deadly Cuffs
				{ 4,  30868 }, -- Rejuvenating Bracers
				{ 5,  30864 }, -- Bracers of the Pathfinder
				{ 6,  30869 }, -- Howling Wind Bracers
				{ 7,  30873 }, -- Stillwater Boots
				{ 8,  30866 }, -- Blood-stained Pauldrons
				{ 9,  30862 }, -- Blessed Adamantite Bracers
				{ 10, 30861 }, -- Furious Shackles
				{ 16, 30865 }, -- Tracker's Blade
				{ 17, 30872 }, -- Chronicle of Dark Secrets
				{ 19, 32459 }, -- Time-Phased Phylactery
			},
		},
		{ --MountHyjalAnetheron
			EncounterJournalID = 1578,
			[P25_DIFF] = {
				{ 1,  30884 }, -- Hatefury Mantle
				{ 2,  30888 }, -- Anetheron's Noose
				{ 3,  30885 }, -- Archbishop's Slippers
				{ 4,  30879 }, -- Don Alejandro's Money Belt
				{ 5,  30886 }, -- Enchanted Leather Sandals
				{ 6,  30887 }, -- Golden Links of Restoration
				{ 7,  30880 }, -- Quickstrider Moccasins
				{ 8,  30878 }, -- Glimmering Steel Mantle
				{ 16, 30874 }, -- The Unbreakable Will
				{ 17, 30881 }, -- Blade of Infamy
				{ 18, 30883 }, -- Pillar of Ferocity
				{ 19, 30882 }, -- Bastion of Light
				{ 21, 122111, "pet1629" }, -- Stinkrot
			},
		},
		{ --MountHyjalKazrogal
			EncounterJournalID = 1579,
			[P25_DIFF] = {
				{ 1,  30895 }, -- Angelista's Sash
				{ 2,  30916 }, -- Leggings of Channeled Elements
				{ 3,  30894 }, -- Blue Suede Shoes
				{ 4,  30917 }, -- Razorfury Mantle
				{ 5,  30914 }, -- Belt of the Crescent Moon
				{ 6,  30891 }, -- Black Featherlight Boots
				{ 7,  30892 }, -- Beast-Tamer's Shoulders
				{ 8,  30919 }, -- Valestalker Girdle
				{ 9,  30893 }, -- Sun-Touched Chain Leggings
				{ 10, 30915 }, -- Belt of Seething Fury
				{ 16, 30918 }, -- Hammer of Atonement
				{ 17, 30889 }, -- Kaz'rogal's Hardened Heart
			},
		},
		{ --MountHyjalAzgalor
			EncounterJournalID = 1580,
			[P25_DIFF] = {
				{ 1,  30899 }, -- Don Rodrigo's Poncho
				{ 2,  30898 }, -- Shady Dealer's Pantaloons
				{ 3,  30900 }, -- Bow-Stitched Leggings
				{ 4,  30896 }, -- Glory of the Defender
				{ 5,  30897 }, -- Girdle of Hope
				{ 6,  30901 }, -- Boundless Agony
				{ 16, 31092 }, -- Gloves of the Forgotten Conqueror
				{ 17, 31094 }, -- Gloves of the Forgotten Protector
				{ 18, 31093 }, -- Gloves of the Forgotten Vanquisher
				{ 20, 122105, "pet1622" }, -- Grotesque
			},
		},
		{ --MountHyjalArchimonde
			EncounterJournalID = 1581,
			[P25_DIFF] = {
				{ 1,  30913 }, -- Robes of Rhonin
				{ 2,  30912 }, -- Leggings of Eternity
				{ 3,  30905 }, -- Midnight Chestguard
				{ 4,  30907 }, -- Mail of Fevered Pursuit
				{ 5,  30904 }, -- Savior's Grasp
				{ 6,  30903 }, -- Legguards of Endless Rage
				{ 7,  30911 }, -- Scepter of Purification
				{ 9,  30910 }, -- Tempest of Chaos
				{ 10, 30902 }, -- Cataclysm's Edge
				{ 11, 30908 }, -- Apostle of Argus
				{ 12, 30909 }, -- Antonidas' Aegis of Rapt Concentration
				{ 13, 30906 }, -- Bristleblitz Striker
				{ 16, 31097 }, -- Helm of the Forgotten Conqueror
				{ 17, 31095 }, -- Helm of the Forgotten Protector
				{ 18, 31096 }, -- Helm of the Forgotten Vanquisher
				{ 20, 122112, "pet1631" }, -- Hyjal Wisp
				{ 22, "ac695" },
			},
		},
		{ --MountHyjalTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  32590 }, -- Nethervoid Cloak
				{ 2,  34010 }, -- Pepe's Shroud of Pacification
				{ 3,  32609 }, -- Boots of the Divine Light
				{ 4,  32592 }, -- Chestguard of Relentless Storms
				{ 5,  32591 }, -- Choker of Serrated Blades
				{ 6,  32589 }, -- Hellfire-Encased Pendant
				{ 7,  34009 }, -- Hammer of Judgement
				{ 8,  32946 }, -- Claw of Molten Fury
				{ 9,  32945 }, -- Fist of Molten Fury
				{ 11, 32428 }, -- Heart of Darkness
				{ 12, 32897 }, -- Mark of the Illidari
				{ 16, 32285 }, -- Design: Flashing Crimson Spinel
				{ 17, 32289 }, -- Design: Stormy Empyrean Sapphire
				{ 18, 32295 }, -- Design: Mystic Lionseye
				{ 19, 32303 }, -- Design: Inscribed Pyrestone
				{ 20, 32298 }, -- Design: Shifting Shadowsong Amethyst
				{ 21, 32297 }, -- Design: Sovereign Shadowsong Amethyst
				{ 22, 32307 }, -- Design: Veiled Shadowsong Amethyst
			},
		},
		{ --Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:6",
		},
		{ --ScaleSands
			FactionID = 990,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:17:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["Karazhan"] = {
	EncounterJournalID = 745,
	MapID = 350,
	AtlasMapID = "KarazhanStart",
	ContentType = RAID_CONTENT,
	items = {
		{ --KaraNamed
			EncounterJournalID = 1552,
			[NORMAL_RAID_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Hyakiss the Lurker"],   nil },
				{ 2,  30675 }, -- Lurker's Cord
				{ 3,  30676 }, -- Lurker's Grasp
				{ 4,  30677 }, -- Lurker's Belt
				{ 5,  30678 }, -- Lurker's Girdle
				{ 7,  "INV_Box_01", nil, AL["Rokad the Ravager"],    nil },
				{ 8,  30684 }, -- Ravager's Cuffs
				{ 9,  30685 }, -- Ravager's Wrist-Wraps
				{ 10, 30686 }, -- Ravager's Bands
				{ 11, 30687 }, -- Ravager's Bracers
				{ 16, "INV_Box_01", nil, AL["Shadikith the Glider"], nil },
				{ 17, 30680 }, -- Glider's Foot-Wraps
				{ 18, 30681 }, -- Glider's Boots
				{ 19, 30682 }, -- Glider's Sabatons
				{ 20, 30683 }, -- Glider's Greaves
			},
		},
		{ --KaraAttumen
			EncounterJournalID = 1553,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28477 }, -- Harbinger Bands
				{ 2,  28507 }, -- Handwraps of Flowing Thought
				{ 3,  28508 }, -- Gloves of Saintly Blessings
				{ 4,  28453 }, -- Bracers of the White Stag
				{ 5,  28506 }, -- Gloves of Dexterous Manipulation
				{ 6,  28503 }, -- Whirlwind Bracers
				{ 7,  28454 }, -- Stalker's War Bands
				{ 8,  28502 }, -- Vambraces of Courage
				{ 9,  28505 }, -- Gauntlets of Renewed Hope
				{ 16, 28509 }, -- Worgen Claw Necklace
				{ 17, 28510 }, -- Spectral Band of Innervation
				{ 19, 28504 }, -- Steelhawk Crossbow
				{ 21, 30480, "mount" }, -- Fiery Warhorse's Reins
				{ 23, 23809 }, -- Schematic: Stabilized Eternium Scope
			},
		},
		{ --KaraMoroes
			EncounterJournalID = 1554,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28529 }, -- Royal Cloak of Arathi Kings
				{ 2,  28570 }, -- Shadow-Cloak of Dalaran
				{ 3,  28565 }, -- Nethershard Girdle
				{ 4,  28545 }, -- Edgewalker Longboots
				{ 5,  28567 }, -- Belt of Gale Force
				{ 6,  28566 }, -- Crimson Girdle of the Indomitable
				{ 7,  28569 }, -- Boots of Valiance
				{ 16, 28530 }, -- Brooch of Unquenchable Fury
				{ 17, 28528 }, -- Moroes' Lucky Pocket Watch
				{ 19, 28524 }, -- Emerald Ripper
				{ 20, 28525 }, -- Signet of Unshakable Faith
				{ 22, 22559 }, -- Formula: Enchant Weapon - Mongoose
			},
		},
		{ --KaraMaiden
			EncounterJournalID = 1555,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28511 }, -- Bands of Indwelling
				{ 2,  28515 }, -- Bands of Nefarious Deeds
				{ 3,  28517 }, -- Boots of Foretelling
				{ 4,  28514 }, -- Bracers of Maliciousness
				{ 5,  28521 }, -- Mitts of the Treemender
				{ 6,  28520 }, -- Gloves of Centering
				{ 7,  28519 }, -- Gloves of Quickening
				{ 8,  28512 }, -- Bracers of Justice
				{ 9,  28518 }, -- Iron Gauntlets of the Maiden
				{ 16, 28516 }, -- Barbed Choker of Discipline
				{ 18, 28522 }, -- Shard of the Virtuous
			},
		},
		{ --KaraOperaEvent
			EncounterJournalID = 1556,
			[NORMAL_RAID_DIFF] = {
				{ 1,  "INV_Box_01", nil,      AL["Shared"],            nil },
				{ 2,  28594 },       -- Trial-Fire Trousers
				{ 3,  28591 },       -- Earthsoul Leggings
				{ 4,  28589 },       -- Beastmaw Pauldrons
				{ 5,  28593 },       -- Eternium Greathelm
				{ 6,  28590 },       -- Ribbon of Sacrifice
				{ 8,  "INV_Box_01", nil,      AL["The Crone"],         nil },
				{ 9,  28586 },       -- Wicked Witch's Hat
				{ 10, 28585 },       -- Ruby Slippers
				{ 11, 28587 },       -- Legacy
				{ 12, 28588 },       -- Blue Diamond Witchwand
				{ 16, "INV_Box_01", nil,      AL["Romulo & Julianne"], nil },
				{ 17, 28578 },       -- Masquerade Gown
				{ 18, 28579 },       -- Romulo's Poison Vial
				{ 19, 28572 },       -- Blade of the Unrequited
				{ 20, 28573 },       -- Despair
				{ 23, "INV_Box_01", nil,      AL["The Big Bad Wolf"],  nil },
				{ 24, 28582 },       -- Red Riding Hood's Cloak
				{ 25, 28583 },       -- Big Bad Wolf's Head
				{ 26, 28584 },       -- Big Bad Wolf's Paw
				{ 27, 28581 },       -- Wolfslayer Sniper Rifle
				{ 28, 97548,        "pet1226" }, -- Spiky Collar
			},
		},
		{ --KaraNightbane
			name = AL["Nightbane"],
			[NORMAL_RAID_DIFF] = {
				{ 1,  28602 }, -- Robe of the Elder Scribes
				{ 2,  28600 }, -- Stonebough Jerkin
				{ 3,  28601 }, -- Chestguard of the Conniver
				{ 4,  28599 }, -- Scaled Breastplate of Carnage
				{ 5,  28610 }, -- Ferocious Swift-Kickers
				{ 6,  28597 }, -- Panzar'Thar Breastplate
				{ 7,  28608 }, -- Ironstriders of Urgency
				{ 9,  24139 }, -- Faint Arcane Essence
				{ 16, 28609 }, -- Emberspur Talisman
				{ 18, 28604 }, -- Nightstaff of the Everliving
				{ 19, 28611 }, -- Dragonheart Flameshield
				{ 20, 28606 }, -- Shield of Impenetrable Darkness
				{ 21, 28603 }, -- Talisman of Nightbane
			},
		},
		{ --KaraCurator
			EncounterJournalID = 1557,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28612 }, -- Pauldrons of the Solace-Giver
				{ 2,  28647 }, -- Forest Wind Shoulderpads
				{ 3,  28631 }, -- Dragon-Quake Shoulderguards
				{ 4,  28621 }, -- Wrynn Dynasty Greaves
				{ 5,  28649 }, -- Garona's Signet Ring
				{ 6,  28633 }, -- Staff of Infinite Mysteries
				{ 16, 29757 }, -- Gloves of the Fallen Champion
				{ 17, 29758 }, -- Gloves of the Fallen Defender
				{ 18, 29756 }, -- Gloves of the Fallen Hero
				{ 20, 97549, "pet1227" }, -- Instant Arcane Sanctum Security Kit
			},
		},
		{ --KaraIllhoof
			EncounterJournalID = 1560,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28660 }, -- Gilded Thorium Cloak
				{ 2,  28653 }, -- Shadowvine Cloak of Infusion
				{ 3,  28652 }, -- Cincture of Will
				{ 4,  28654 }, -- Malefic Girdle
				{ 5,  28655 }, -- Cord of Nature's Sustenance
				{ 6,  28656 }, -- Girdle of the Prowler
				{ 7,  28662 }, -- Breastplate of the Lightbinder
				{ 16, 28661 }, -- Mender's Heart-Ring
				{ 17, 28785 }, -- The Lightning Capacitor
				{ 19, 28657 }, -- Fool's Bane
				{ 20, 28658 }, -- Terestian's Stranglestaff
				{ 22, 97551, "pet1229" }, -- Satyr Charm
				{ 24, 22561 }, -- Formula: Enchant Weapon - Soulfrost
			},
		},
		{ --KaraAran
			EncounterJournalID = 1559,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28672 }, -- Drape of the Dark Reavers
				{ 2,  28726 }, -- Mantle of the Mind Flayer
				{ 3,  28670 }, -- Boots of the Infernal Coven
				{ 4,  28663 }, -- Boots of the Incorrupt
				{ 5,  28669 }, -- Rapscallion Boots
				{ 6,  28671 }, -- Steelspine Faceguard
				{ 7,  28666 }, -- Pauldrons of the Justice-Seeker
				{ 9,  23933 }, -- Medivh's Journal
				{ 16, 28674 }, -- Saberclaw Talisman
				{ 17, 28675 }, -- Shermanar Great-Ring
				{ 18, 28727 }, -- Pendant of the Violet Eye
				{ 20, 28673 }, -- Tirisfal Wand of Ascendancy
				{ 21, 28728 }, -- Aran's Soothing Sapphire
				{ 23, 22560 }, -- Formula: Enchant Weapon - Sunfire
			},
		},
		{ --KaraNetherspite
			EncounterJournalID = 1561,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28744 }, -- Uni-Mind Headdress
				{ 2,  28742 }, -- Pantaloons of Repentence
				{ 3,  28732 }, -- Cowl of Defiance
				{ 4,  28741 }, -- Skulker's Greaves
				{ 5,  28735 }, -- Earthblood Chestguard
				{ 6,  28740 }, -- Rip-Flayer Leggings
				{ 7,  28743 }, -- Mantle of Abrahmis
				{ 8,  28733 }, -- Girdle of Truth
				{ 16, 28731 }, -- Shining Chain of the Afterworld
				{ 17, 28730 }, -- Mithril Band of the Unscarred
				{ 19, 28729 }, -- Spiteblade
				{ 20, 28734 }, -- Jewel of Infinite Possibilities
			},
		},
		{ --KaraChess
			EncounterJournalID = 1562,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28756 }, -- Headdress of the High Potentate
				{ 2,  28755 }, -- Bladed Shoulderpads of the Merciless
				{ 3,  28750 }, -- Girdle of Treachery
				{ 4,  28752 }, -- Forestlord Striders
				{ 5,  28751 }, -- Heart-Flame Leggings
				{ 6,  28746 }, -- Fiend Slayer Boots
				{ 7,  28748 }, -- Legplates of the Innocent
				{ 8,  28747 }, -- Battlescar Boots
				{ 16, 28745 }, -- Mithril Chain of Heroism
				{ 17, 28753 }, -- Ring of Recurrence
				{ 19, 28749 }, -- King's Defender
				{ 20, 28754 }, -- Triptych Shield of the Ancients
			},
		},
		{ --KaraPrince
			EncounterJournalID = 1563,
			[NORMAL_RAID_DIFF] = {
				{ 1,  28765 }, -- Stainless Cloak of the Pure Hearted
				{ 2,  28766 }, -- Ruby Drape of the Mysticant
				{ 3,  28764 }, -- Farstrider Wildercloak
				{ 4,  28762 }, -- Adornment of Stolen Souls
				{ 5,  28763 }, -- Jade Ring of the Everliving
				{ 6,  28757 }, -- Ring of a Thousand Marks
				{ 8,  28770 }, -- Nathrezim Mindblade
				{ 9,  28768 }, -- Malchazeen
				{ 10, 28767 }, -- The Decapitator
				{ 11, 28773 }, -- Gorehowl
				{ 12, 28771 }, -- Light's Justice
				{ 13, 28772 }, -- Sunfury Bow of the Phoenix
				{ 16, 29760 }, -- Helm of the Fallen Champion
				{ 17, 29761 }, -- Helm of the Fallen Defender
				{ 18, 29759 }, -- Helm of the Fallen Hero
				{ 20, 97550,  "pet1228" }, -- Netherspace Portal-Stone
				{ 22, "ac690" },
			},
		},
		{ --KaraTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_RAID_DIFF] = {
				{ 1,  30642 }, -- Drape of the Righteous
				{ 2,  30668 }, -- Grasp of the Dead
				{ 3,  30673 }, -- Inferno Waist Cord
				{ 4,  30644 }, -- Grips of Deftness
				{ 5,  30674 }, -- Zierhut's Lost Treads
				{ 6,  30643 }, -- Belt of the Tracker
				{ 7,  30641 }, -- Boots of Elusion
				{ 9,  23857 }, -- Legacy of the Mountain King
				{ 10, 23864 }, -- Torment of the Worgen
				{ 11, 23862 }, -- Redemption of the Fallen
				{ 12, 23865 }, -- Wrath of the Titans
				{ 14, 21882 }, -- Soul Essence
				{ 16, 30666 }, -- Ritssyn's Lost Pendant
				{ 17, 30667 }, -- Ring of Unrelenting Storms
				{ 19, 21903 }, -- Pattern: Soulcloth Shoulders
				{ 20, 21904 }, -- Pattern: Soulcloth Vest
				{ 21, 22545 }, -- Formula: Enchant Boots - Surefooted
				{ 23, 24492 }, -- Keanna's Log
			},
		},
		{ --Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:4",
		},
		{ --TheVioletEye
			FactionID = 967,
			CoinTexture = "Reputation",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:20",
		},
		BC_RAID_AC_TABLE,
	}
}

data["HCMagtheridonsLair"] = {
	EncounterJournalID = 747,
	MapID = 331,
	AtlasMapID = "HCMagtheridonsLair",
	ContentType = RAID_CONTENT,
	items = {
		{ --HCMagtheridon
			EncounterJournalID = 1566,
			[P25_DIFF] = {
				{ 1,  28777 }, -- Cloak of the Pit Stalker
				{ 2,  28780 }, -- Soul-Eater's Handwraps
				{ 3,  28776 }, -- Liar's Tongue Gloves
				{ 4,  28778 }, -- Terror Pit Girdle
				{ 5,  28775 }, -- Thundering Greathelm
				{ 6,  28779 }, -- Girdle of the Endless Pit
				{ 7,  28789 }, -- Eye of Magtheridon
				{ 9,  28774 }, -- Glaive of the Pit
				{ 10, 28782 }, -- Crystalheart Pulse-Staff
				{ 11, 29458 }, -- Aegis of the Vindicator
				{ 12, 28783 }, -- Eredar Wand of Obliteration
				{ 13, 28781 }, -- Karaborian Talisman
				{ 15, 34846 }, -- Black Sack of Gems
				{ 16, 29754 }, -- Chestguard of the Fallen Champion
				{ 17, 29753 }, -- Chestguard of the Fallen Defender
				{ 18, 29755 }, -- Chestguard of the Fallen Hero
				{ 20, 32385 }, -- Magtheridon's Head
				{ 21, 28791 }, -- Ring of the Recalcitrant
				{ 22, 28790 }, -- Naaru Lightwarden's Band
				{ 23, 28793 }, -- Band of Crimson Fury
				{ 24, 28792 }, -- A'dal's Signet of Defense
				{ 26, 34845 }, -- Pit Lord's Satchel
				{ 28, "ac693" },
			},
		},
		{ --Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:4:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["CFRSerpentshrineCavern"] = {
	EncounterJournalID = 748,
	MapID = 332,
	AtlasMapID = "CFRSerpentshrineCavern",
	ContentType = RAID_CONTENT,
	items = {
		{ --CFRSerpentHydross
			EncounterJournalID = 1567,
			[P25_DIFF] = {
				{ 1,  30056 }, -- Robe of Hateful Echoes
				{ 2,  32516 }, -- Wraps of Purification
				{ 3,  30050 }, -- Boots of the Shifting Nightmare
				{ 4,  30055 }, -- Shoulderpads of the Stranger
				{ 5,  30047 }, -- Blackfathom Warbands
				{ 6,  30054 }, -- Ranger-General's Chestguard
				{ 7,  30048 }, -- Brighthelm of Justice
				{ 8,  30053 }, -- Pauldrons of the Wardancer
				{ 16, 30052 }, -- Ring of Lethality
				{ 17, 33055 }, -- Band of Vile Aggression
				{ 18, 30664 }, -- Living Root of the Wildheart
				{ 19, 30629 }, -- Scarab of Displacement
				{ 21, 30049 }, -- Fathomstone
				{ 23, 97553, "pet1231" }, -- Tainted Core
			},
		},
		{ --CFRSerpentLurker
			EncounterJournalID = 1568,
			[P25_DIFF] = {
				{ 1,  30064 }, -- Cord of Screaming Terrors
				{ 2,  30067 }, -- Velvet Boots of the Guardian
				{ 3,  30062 }, -- Grove-Bands of Remulos
				{ 4,  30060 }, -- Boots of Effortless Striking
				{ 5,  30066 }, -- Tempest-Strider Boots
				{ 6,  30065 }, -- Glowing Breastplate of Truth
				{ 7,  30057 }, -- Bracers of Eradication
				{ 16, 30059 }, -- Choker of Animalistic Fury
				{ 17, 30061 }, -- Ancestral Ring of Conquest
				{ 18, 33054 }, -- The Seal of Danzalar
				{ 19, 30665 }, -- Earring of Soulful Meditation
				{ 21, 30058 }, -- Mallet of the Tides
			},
		},
		{ --CFRSerpentLeotheras
			EncounterJournalID = 1569,
			[P25_DIFF] = {
				{ 1,  30092 }, -- Orca-Hide Boots
				{ 2,  30097 }, -- Coral-Barbed Shoulderpads
				{ 3,  30091 }, -- True-Aim Stalker Bands
				{ 4,  30096 }, -- Girdle of the Invulnerable
				{ 5,  30627 }, -- Tsunami Talisman
				{ 6,  30095 }, -- Fang of the Leviathan
				{ 16, 30239 }, -- Gloves of the Vanquished Champion
				{ 17, 30240 }, -- Gloves of the Vanquished Defender
				{ 18, 30241 }, -- Gloves of the Vanquished Hero
			},
		},
		{ --CFRSerpentKarathress
			EncounterJournalID = 1570,
			[P25_DIFF] = {
				{ 1,  30100 }, -- Soul-Strider Boots
				{ 2,  30101 }, -- Bloodsea Brigand's Vest
				{ 3,  30099 }, -- Frayed Tether of the Drowned
				{ 4,  30663 }, -- Fathom-Brooch of the Tidewalker
				{ 5,  30626 }, -- Sextant of Unstable Currents
				{ 6,  30090 }, -- World Breaker
				{ 16, 30245 }, -- Leggings of the Vanquished Champion
				{ 17, 30246 }, -- Leggings of the Vanquished Defender
				{ 18, 30247 }, -- Leggings of the Vanquished Hero
			},
		},
		{ --CFRSerpentMorogrim
			EncounterJournalID = 1571,
			[P25_DIFF] = {
				{ 1,  30098 }, -- Razor-Scale Battlecloak
				{ 2,  30079 }, -- Illidari Shoulderpads
				{ 3,  30075 }, -- Gnarled Chestpiece of the Ancients
				{ 4,  30085 }, -- Mantle of the Tireless Tracker
				{ 5,  30068 }, -- Girdle of the Tidal Call
				{ 6,  30084 }, -- Pauldrons of the Argent Sentinel
				{ 7,  30081 }, -- Warboots of Obliteration
				{ 16, 30008 }, -- Pendant of the Lost Ages
				{ 17, 30083 }, -- Ring of Sundered Souls
				{ 18, 33058 }, -- Band of the Vigilant
				{ 19, 30720 }, -- Serpent-Coil Braid
				{ 21, 30082 }, -- Talon of Azshara
				{ 22, 30080 }, -- Luminescent Rod of the Naaru
				{ 24, 97552, "pet1230" }, -- Shell of Tide-Calling
			},
		},
		{ --CFRSerpentVashj
			EncounterJournalID = 1572,
			[P25_DIFF] = {
				{ 1,  30107 }, -- Vestments of the Sea-Witch
				{ 2,  30111 }, -- Runetotem's Mantle
				{ 3,  30106 }, -- Belt of One-Hundred Deaths
				{ 4,  30104 }, -- Cobra-Lash Boots
				{ 5,  30102 }, -- Krakken-Heart Breastplate
				{ 6,  30112 }, -- Glorious Gauntlets of Crestfall
				{ 7,  30109 }, -- Ring of Endless Coils
				{ 8,  30110 }, -- Coral Band of the Revived
				{ 9,  30621 }, -- Prism of Inner Calm
				{ 10, 30103 }, -- Fang of Vashj
				{ 11, 30108 }, -- Lightfathom Scepter
				{ 12, 30105 }, -- Serpent Spine Longbow
				{ 16, 30242 }, -- Helm of the Vanquished Champion
				{ 17, 30243 }, -- Helm of the Vanquished Defender
				{ 18, 30244 }, -- Helm of the Vanquished Hero
				{ 20, 97554,  "pet1232" }, -- Dripping Strider Egg
				{ 22, 29906 }, -- Vashj's Vial Remnant
				{ 24, "ac694" },
			},
		},
		{ --CFRSerpentTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  30027 }, -- Boots of Courage Unending
				{ 2,  30022 }, -- Pendant of the Perilous
				{ 3,  30620 }, -- Spyglass of the Hidden Fleet
				{ 5,  30021 }, -- Wildfury Greatstaff
				{ 7,  30324 }, -- Plans: Red Havoc Boots
				{ 8,  30322 }, -- Plans: Red Belt of Battle
				{ 9,  30323 }, -- Plans: Boots of the Protector
				{ 10, 30321 }, -- Plans: Belt of the Guardian
				{ 11, 30280 }, -- Pattern: Belt of Blasting
				{ 12, 30282 }, -- Pattern: Boots of Blasting
				{ 13, 30283 }, -- Pattern: Boots of the Long Road
				{ 14, 30281 }, -- Pattern: Belt of the Long Road
				{ 16, 30308 }, -- Pattern: Hurricane Boots
				{ 17, 30304 }, -- Pattern: Monsoon Belt
				{ 18, 30305 }, -- Pattern: Boots of Natural Grace
				{ 19, 30307 }, -- Pattern: Boots of the Crimson Hawk
				{ 20, 30306 }, -- Pattern: Boots of Utter Darkness
				{ 21, 30301 }, -- Pattern: Belt of Natural Power
				{ 22, 30303 }, -- Pattern: Belt of the Black Eagle
				{ 23, 30302 }, -- Pattern: Belt of Deep Shadow
				{ 25, 30183 }, -- Nether Vortex
				{ 27, 32897 }, -- Mark of the Illidari
			},
		},
		{ --Tier 5 Sets
			name = format(AL["Tier %d Sets"], 5),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:5",
		},
		{ --CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["SunwellPlateau"] = {
	EncounterJournalID = 752,
	MapID = 335,
	AtlasMapID = "SunwellPlateau",
	ContentType = RAID_CONTENT,
	items = {
		{ --SPKalecgos
			EncounterJournalID = 1591,
			[P25_DIFF] = {
				{ 1,  34170 }, -- Pantaloons of Calming Strife
				{ 2,  34386 }, -- Pantaloons of Growing Strife
				{ 3,  34169 }, -- Breeches of Natural Aggression
				{ 4,  34384 }, -- Breeches of Natural Splendor
				{ 5,  34168 }, -- Starstalker Legguards
				{ 6,  34167 }, -- Legplates of the Holy Juggernaut
				{ 7,  34382 }, -- Judicator's Legguards
				{ 8,  34166 }, -- Band of Lucent Beams
				{ 9,  34165 }, -- Fang of Kalecgos
				{ 10, 34164 }, -- Dragonscale-Encrusted Longblade
				{ 16, 34848 }, -- Bracers of the Forgotten Conqueror
				{ 17, 34851 }, -- Bracers of the Forgotten Protector
				{ 18, 34852 }, -- Bracers of the Forgotten Vanquisher
			},
		},
		{ --SPBrutallus
			EncounterJournalID = 1592,
			[P25_DIFF] = {
				{ 1,  34181 }, -- Leggings of Calamity
				{ 2,  34180 }, -- Felfury Legplates
				{ 3,  34381 }, -- Felstrength Legplates
				{ 4,  34178 }, -- Collar of the Pit Lord
				{ 5,  34177 }, -- Clutch of Demise
				{ 6,  34176 }, -- Reign of Misery
				{ 7,  34179 }, -- Heart of the Pit
				{ 16, 34853 }, -- Belt of the Forgotten Conqueror
				{ 17, 34854 }, -- Belt of the Forgotten Protector
				{ 18, 34855 }, -- Belt of the Forgotten Vanquisher
				{ 20, 122113, "pet1632" }, -- Sunblade Micro-Defender
			},
		},
		{ --SPFelmyst
			EncounterJournalID = 1593,
			[P25_DIFF] = {
				{ 1,  34352 }, -- Borderland Fortress Grips
				{ 2,  34188 }, -- Leggings of the Immortal Night
				{ 3,  34385 }, -- Leggings of the Immortal Beast
				{ 4,  34186 }, -- Chain Links of the Tumultuous Storm
				{ 5,  34383 }, -- Kilt of Spiritual Reconstruction
				{ 6,  34184 }, -- Brooch of the Highborne
				{ 7,  34185 }, -- Sword Breaker's Bulwark
				{ 8,  34182 }, -- Grand Magister's Staff of Torrents
				{ 16, 34856 }, -- Boots of the Forgotten Conqueror
				{ 17, 34857 }, -- Boots of the Forgotten Protector
				{ 18, 34858 }, -- Boots of the Forgotten Vanquisher
			},
		},
		{ --SPEredarTwins
			EncounterJournalID = 1594,
			[P25_DIFF] = {
				{ 1,  34205 }, -- Shroud of Redeemed Souls
				{ 2,  34190 }, -- Crimson Paragon's Cover
				{ 3,  34210 }, -- Amice of the Convoker
				{ 4,  34202 }, -- Shawl of Wonderment
				{ 5,  34393 }, -- Shoulderpads of Knowledge's Pursuit
				{ 6,  34209 }, -- Spaulders of Reclamation
				{ 7,  34391 }, -- Spaulders of Devastation
				{ 8,  34195 }, -- Shoulderpads of Vehemence
				{ 9,  34392 }, -- Demontooth Shoulderpads
				{ 10, 34194 }, -- Mantle of the Golden Forest
				{ 11, 34208 }, -- Equilibrium Epaulets
				{ 12, 34390 }, -- Erupting Epaulets
				{ 13, 34192 }, -- Pauldrons of Perseverance
				{ 14, 34388 }, -- Pauldrons of Berserking
				{ 16, 34193 }, -- Spaulders of the Thalassian Savior
				{ 17, 34389 }, -- Spaulders of the Thalassian Defender
				{ 18, 35290 }, -- Sin'dorei Pendant of Conquest
				{ 19, 35291 }, -- Sin'dorei Pendant of Salvation
				{ 20, 35292 }, -- Sin'dorei Pendant of Triumph
				{ 21, 34204 }, -- Amulet of Unfettered Magics
				{ 22, 34189 }, -- Band of Ruinous Delight
				{ 23, 34197 }, -- Shiv of Exsanguination
				{ 24, 34199 }, -- Archon's Gavel
				{ 25, 34203 }, -- Grip of Mannoroth
				{ 26, 34198 }, -- Stanchion of Primal Instinct
				{ 27, 34196 }, -- Golden Bow of Quel'Thalas
				{ 28, 34206 }, -- Book of Highborne Hymns
				{ 30, 122115, "pet1634" }, -- Wretched Servant
			},
		},
		{ --SPMuru
			EncounterJournalID = 1595,
			[P25_DIFF] = {
				{ 1,  34232 }, -- Fel Conquerer Raiments
				{ 2,  34233 }, -- Robes of Faltered Light
				{ 3,  34399 }, -- Robes of Ghostly Hatred
				{ 4,  34212 }, -- Sunglow Vest
				{ 5,  34398 }, -- Utopian Tunic of Elune
				{ 6,  34211 }, -- Harness of Carnal Instinct
				{ 7,  34397 }, -- Bladed Chaos Tunic
				{ 8,  34234 }, -- Shadowed Gauntlets of Paroxysm
				{ 9,  34408 }, -- Gloves of the Forest Drifter
				{ 10, 34229 }, -- Garments of Serene Shores
				{ 11, 34396 }, -- Garments of Crashing Shores
				{ 12, 34228 }, -- Vicious Hawkstrider Hauberk
				{ 13, 34215 }, -- Warharness of Reckless Fury
				{ 14, 34394 }, -- Breastplate of Agony's Aversion
				{ 15, 34240 }, -- Gauntlets of the Soothed Soul
				{ 16, 34216 }, -- Heroic Judicator's Chestguard
				{ 17, 34395 }, -- Noble Judicator's Chestguard
				{ 18, 34213 }, -- Ring of Hardened Resolve
				{ 19, 34230 }, -- Ring of Omnipotence
				{ 20, 35282 }, -- Sin'dorei Band of Dominance
				{ 21, 35283 }, -- Sin'dorei Band of Salvation
				{ 22, 35284 }, -- Sin'dorei Band of Triumph
				{ 23, 34427 }, -- Blackened Naaru Sliver
				{ 24, 34430 }, -- Glimmering Naaru Sliver
				{ 25, 34429 }, -- Shifting Naaru Sliver
				{ 26, 34428 }, -- Steely Naaru Sliver
				{ 27, 34214 }, -- Muramasa
				{ 28, 34231 }, -- Aegis of Angelic Fortune
				{ 30, 122114, "pet1633" }, -- Chaos Pup
			},
		},
		{ --SPKiljaeden
			EncounterJournalID = 1596,
			[P25_DIFF] = {
				{ 1,  34241 }, -- Cloak of Unforgivable Sin
				{ 2,  34242 }, -- Tattered Cape of Antonidas
				{ 3,  34339 }, -- Cowl of Light's Purity
				{ 4,  34405 }, -- Helm of Arcane Purity
				{ 5,  34340 }, -- Dark Conjuror's Collar
				{ 6,  34342 }, -- Handguards of the Dawn
				{ 7,  34406 }, -- Gloves of Tyri's Power
				{ 8,  34344 }, -- Handguards of Defiled Worlds
				{ 9,  34244 }, -- Duplicitous Guise
				{ 10, 34404 }, -- Mask of the Fury Hunter
				{ 11, 34245 }, -- Cover of Ursol the Wise
				{ 12, 34403 }, -- Cover of Ursoc the Mighty
				{ 13, 34333 }, -- Coif of Alleria
				{ 14, 34332 }, -- Cowl of Gul'dan
				{ 15, 34402 }, -- Shroud of Chieftain Ner'zhul
				{ 16, 34343 }, -- Thalassian Ranger Gauntlets
				{ 17, 34243 }, -- Helm of Burning Righteousness
				{ 18, 34401 }, -- Helm of Uther's Resolve
				{ 19, 34345 }, -- Crown of Anasterian
				{ 20, 34400 }, -- Crown of Dath'Remar
				{ 21, 34341 }, -- Borderland Paingrips
				{ 23, 34334 }, -- Thori'dal, the Stars' Fury
				{ 24, 34329 }, -- Crux of the Apocalypse
				{ 25, 34247 }, -- Apolyon, the Soul-Render
				{ 26, 34335 }, -- Hammer of Sanctification
				{ 27, 34331 }, -- Hand of the Deceiver
				{ 28, 34336 }, -- Sunflare
				{ 29, 34337 }, -- Golden Staff of the Sin'dorei
				{ 30, "ac698" },
			},
		},
		{ --SPTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  34351 }, -- Tranquil Majesty Wraps
				{ 2,  34407 }, -- Tranquil Moonlight Wraps
				{ 3,  34350 }, -- Gauntlets of the Ancient Shadowmoon
				{ 4,  34409 }, -- Gauntlets of the Ancient Frostwolf
				{ 5,  35733 }, -- Ring of Harmonic Beauty
				{ 6,  34183 }, -- Shivering Felspine
				{ 7,  34346 }, -- Mounting Vengeance
				{ 8,  34348 }, -- Wand of Cleansing Light
				{ 9,  34347 }, -- Wand of the Demonsoul
				{ 11, 35273 }, -- Study of Advanced Smelting
				{ 13, 34664 }, -- Sunmote
				{ 16, 32228 }, -- Empyrean Sapphire
				{ 17, 32231 }, -- Pyrestone
				{ 18, 32229 }, -- Lionseye
				{ 19, 32249 }, -- Seaspray Emerald
				{ 20, 32230 }, -- Shadowsong Amethyst
				{ 21, 32227 }, -- Crimson Spinel
				{ 23, 35208 }, -- Plans: Sunblessed Gauntlets
				{ 24, 35210 }, -- Plans: Sunblessed Breastplate
				{ 25, 35209 }, -- Plans: Hard Khorium Battlefists
				{ 26, 35211 }, -- Plans: Hard Khorium Battleplate
			},
		},
		{ --SPPatterns
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 159)..")",
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  35212 }, -- Pattern: Leather Gauntlets of the Sun
				{ 2,  35216 }, -- Pattern: Leather Chestguard of the Sun
				{ 3,  35213 }, -- Pattern: Fletcher's Gloves of the Phoenix
				{ 4,  35217 }, -- Pattern: Embrace of the Phoenix
				{ 5,  35214 }, -- Pattern: Gloves of Immortal Dusk
				{ 6,  35218 }, -- Pattern: Carapace of Sun and Shadow
				{ 7,  35215 }, -- Pattern: Sun-Drenched Scale Gloves
				{ 8,  35219 }, -- Pattern: Sun-Drenched Scale Chestguard
				{ 9,  35204 }, -- Pattern: Sunfire Handwraps
				{ 10, 35206 }, -- Pattern: Sunfire Robe
				{ 11, 35205 }, -- Pattern: Hands of Eternal Light
				{ 12, 35207 }, -- Pattern: Robe of Eternal Light
				{ 13, 35198 }, -- Design: Loop of Forged Power
				{ 14, 35201 }, -- Design: Pendant of Sunfire
				{ 15, 35199 }, -- Design: Ring of Flowing Life
				{ 16, 35202 }, -- Design: Amulet of Flowing Life
				{ 17, 35200 }, -- Design: Hard Khorium Band
				{ 18, 35203 }, -- Design: Hard Khorium Choker
				{ 19, 35186 }, -- Schematic: Annihilator Holo-Gogs
				{ 20, 35187 }, -- Schematic: Justicebringer 3000 Specs
				{ 21, 35189 }, -- Schematic: Powerheal 9000 Lens
				{ 22, 35190 }, -- Schematic: Hyper-Magnified Moon Specs
				{ 23, 35191 }, -- Schematic: Wonderheal XT68 Shades
				{ 24, 35192 }, -- Schematic: Primal-Attuned Goggles
				{ 25, 35193 }, -- Schematic: Lightning Etched Specs
				{ 26, 35194 }, -- Schematic: Surestrike Goggles v3.0
				{ 27, 35195 }, -- Schematic: Mayhem Projection Goggles
				{ 28, 35196 }, -- Schematic: Hard Khorium Goggles
				{ 29, 35197 }, -- Schematic: Quad Deathblow X44 Goggles
			},
		},
		{ --Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:6",
		},
		BC_RAID_AC_TABLE,
	}
}

data["TempestKeepTheEye"] = {
	EncounterJournalID = 749,
	MapID = 334,
	AtlasMapID = "TempestKeepTheEye",
	ContentType = RAID_CONTENT,
	items = {
		{ --TKEyeAlar
			EncounterJournalID = 1573,
			[P25_DIFF] = {
				{ 1,  29925 }, -- Phoenix-Wing Cloak
				{ 2,  29918 }, -- Mindstorm Wristbands
				{ 3,  29947 }, -- Gloves of the Searing Grip
				{ 4,  29921 }, -- Fire Crest Breastplate
				{ 5,  29922 }, -- Band of Al'ar
				{ 6,  29920 }, -- Phoenix-Ring of Rebirth
				{ 7,  30448 }, -- Talon of Al'ar
				{ 8,  30447 }, -- Tome of Fiery Redemption
				{ 16, 32944 }, -- Talon of the Phoenix
				{ 17, 29948 }, -- Claw of the Phoenix
				{ 18, 29924 }, -- Netherbane
				{ 19, 29949 }, -- Arcanite Steam-Pistol
				{ 20, 29923 }, -- Talisman of the Sun King
				{ 22, 97557, "pet1235" }, -- Brilliant Phoenix Hawk Feather
			},
		},
		{ --TKEyeVoidReaver
			EncounterJournalID = 1574,
			[P25_DIFF] = {
				{ 1,  29986 }, -- Cowl of the Grand Engineer
				{ 2,  29984 }, -- Girdle of Zaetar
				{ 3,  29985 }, -- Void Reaver Greaves
				{ 4,  29983 }, -- Fel-Steel Warhelm
				{ 5,  32515 }, -- Wristguards of Determination
				{ 6,  30619 }, -- Fel Reaver's Piston
				{ 7,  30450 }, -- Warp-Spring Coil
				{ 16, 30248 }, -- Pauldrons of the Vanquished Champion
				{ 17, 30249 }, -- Pauldrons of the Vanquished Defender
				{ 18, 30250 }, -- Pauldrons of the Vanquished Hero
				{ 20, 97555, "pet1233" }, -- Tiny Fel Engine Key
			},
		},
		{ --TKEyeSolarian
			EncounterJournalID = 1575,
			[P25_DIFF] = {
				{ 1,  29977 }, -- Star-Soul Breeches
				{ 2,  29972 }, -- Trousers of the Astromancer
				{ 3,  29966 }, -- Vambraces of Ending
				{ 4,  29976 }, -- Worldstorm Gauntlets
				{ 5,  29951 }, -- Star-Strider Boots
				{ 6,  29965 }, -- Girdle of the Righteous Path
				{ 7,  29950 }, -- Greaves of the Bloodwarder
				{ 8,  32267 }, -- Boots of the Resilient
				{ 16, 30446 }, -- Solarian's Sapphire
				{ 17, 30449 }, -- Void Star Talisman
				{ 19, 29962 }, -- Heartrazor
				{ 20, 29981 }, -- Ethereum Life-Staff
				{ 21, 29982 }, -- Wand of the Forgotten Star
				{ 23, 97556, "pet1234" }, -- Crystal of the Void
			},
		},
		{ --TKEyeKaelthas
			EncounterJournalID = 1576,
			[P25_DIFF] = {
				{ 1,  29992 }, -- Royal Cloak of the Sunstriders
				{ 2,  29989 }, -- Sunshower Light Cloak
				{ 3,  29994 }, -- Thalassian Wildercloak
				{ 4,  29990 }, -- Crown of the Sun
				{ 5,  29987 }, -- Gauntlets of the Sun King
				{ 6,  29995 }, -- Leggings of Murderous Intent
				{ 7,  29991 }, -- Sunhawk Leggings
				{ 8,  29998 }, -- Royal Gauntlets of Silvermoon
				{ 9,  29997 }, -- Band of the Ranger-General
				{ 10, 29993 }, -- Twinblade of the Phoenix
				{ 11, 29996 }, -- Rod of the Sun King
				{ 12, 29988 }, -- The Nexus Key
				{ 16, 30236 }, -- Chestguard of the Vanquished Champion
				{ 17, 30237 }, -- Chestguard of the Vanquished Defender
				{ 18, 30238 }, -- Chestguard of the Vanquished Hero
				{ 20, 32458,  "mount" }, -- Ashes of Al'ar
				{ 22, 32405 }, -- Verdant Sphere
				{ 23, 30018 }, -- Lord Sanguinar's Claim
				{ 24, 30017 }, -- Telonicus' Pendant of Mayhem
				{ 25, 30007 }, -- The Darkener's Grasp
				{ 26, 30015 }, -- The Sun King's Talisman
				{ 28, 29905 }, -- Kael's Vial Remnant
				{ 30, "ac696" },
			},
		},
		{ --TKEyeTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1,  30024 }, -- Mantle of the Elven Kings
				{ 2,  30020 }, -- Fire-Cord of the Magus
				{ 3,  30029 }, -- Bark-Gloves of Ancient Wisdom
				{ 4,  30026 }, -- Bands of the Celestial Archer
				{ 5,  30030 }, -- Girdle of Fallen Stars
				{ 6,  30028 }, -- Seventh Ring of the Tirisfalen
				{ 8,  30324 }, -- Plans: Red Havoc Boots
				{ 9,  30322 }, -- Plans: Red Belt of Battle
				{ 10, 30323 }, -- Plans: Boots of the Protector
				{ 11, 30321 }, -- Plans: Belt of the Guardian
				{ 12, 30280 }, -- Pattern: Belt of Blasting
				{ 13, 30282 }, -- Pattern: Boots of Blasting
				{ 14, 30283 }, -- Pattern: Boots of the Long Road
				{ 15, 30281 }, -- Pattern: Belt of the Long Road
				{ 16, 30308 }, -- Pattern: Hurricane Boots
				{ 17, 30304 }, -- Pattern: Monsoon Belt
				{ 18, 30305 }, -- Pattern: Boots of Natural Grace
				{ 19, 30307 }, -- Pattern: Boots of the Crimson Hawk
				{ 20, 30306 }, -- Pattern: Boots of Utter Darkness
				{ 21, 30301 }, -- Pattern: Belt of Natural Power
				{ 22, 30303 }, -- Pattern: Belt of the Black Eagle
				{ 23, 30302 }, -- Pattern: Belt of Deep Shadow
				{ 25, 30183 }, -- Nether Vortex
				{ 27, 32897 }, -- Mark of the Illidari
			},
		},
		{ --Tier 5 Sets
			name = format(AL["Tier %d Sets"], 5),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:5",
		},
		{ --Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["WorldBossesBC"] = {
	name = AL["World Bosses"],
	--	AtlasMapID = "",
	ContentType = RAID_CONTENT,
	items = {
		{ --DoomLordKazzak
			name = AL["Doom Lord Kazzak"],
			[NORMAL_DIFF] = {
				{ 1,  30735 }, -- Ancient Spellcloak of the Highborne
				{ 2,  30734 }, -- Leggings of the Seventh Circle
				{ 3,  30737 }, -- Gold-Leaf Wildboots
				{ 4,  30739 }, -- Scaled Greaves of the Marksman
				{ 5,  30740 }, -- Ripfiend Shoulderplates
				{ 6,  30741 }, -- Topaz-Studded Battlegrips
				{ 16, 30736 }, -- Ring of Flowing Light
				{ 17, 30738 }, -- Ring of Reciprocity
				{ 19, 30733 }, -- Hope Ender
				{ 20, 30732 }, -- Exodar Life-Staff
			},
		},
		{ --Doomwalker
			name = AL["Doomwalker"],
			[NORMAL_DIFF] = {
				{ 1,  30729 }, -- Black-Iron Battlecloak
				{ 2,  30725 }, -- Anger-Spark Gloves
				{ 3,  30727 }, -- Gilded Trousers of Benediction
				{ 4,  30730 }, -- Terrorweave Tunic
				{ 5,  30728 }, -- Fathom-Helm of the Deeps
				{ 6,  30731 }, -- Faceguard of the Endless Watch
				{ 16, 30726 }, -- Archaic Charm of Presence
				{ 18, 30723 }, -- Talon of the Tempest
				{ 19, 30722 }, -- Ethereum Nexus-Reaver
				{ 20, 30724 }, -- Barrel-Blade Longrifle
			},
		},
	}
}
