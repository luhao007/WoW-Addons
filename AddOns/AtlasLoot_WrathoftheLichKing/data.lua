-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = select
local format = string.format

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 3)

AtlasLoot:RegisterModules(addonname)

local ADD_SCALING = {
	Item = {
		addDifficultyBonus = true,
	}
}

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "n", ADD_SCALING, 1)
local HEROIC_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY2, "h", ADD_SCALING, 2)
local MYTHIC_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY6, "m", ADD_SCALING, 23)
local TIMEWALKING_DUNGEON_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY_TIMEWALKER, "timewalkingDungeonWithPreset", ADD_SCALING, 24)

local NORMAL_RAID_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY1, "rn", ADD_SCALING, 3)
local HEROIC_RAID_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY2, "rh", ADD_SCALING, 5)
local P25_DIFF = data:AddDifficulty(RAID_DIFFICULTY_25PLAYER, "p25", ADD_SCALING, 4)
local P25H_DIFF = data:AddDifficulty(RAID_DIFFICULTY_25PLAYER_HEROIC, "p25h", ADD_SCALING, 6)
local TIMEWALKING_RAID_DIFF = data:AddDifficulty(PLAYER_DIFFICULTY_TIMEWALKER, "timewalkingRaidWithPreset", ADD_SCALING, 33)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local DUNGEON_CONTENT = data:AddContentType(DUNGEONS, ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(RAIDS, ATLASLOOT_RAID_COLOR)

-- Shared loot tables
local WOTLK_DUNGEONMASTER_AC_TABLE = { --[Northrend Dungeonmaster]
	name = select(2, GetAchievementInfo(1288)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1288 },
		{ 2, 477 }, { 17, 478 },
		{ 3, 479 }, { 18, 480 },
		{ 4, 481 }, { 19, 482 },
		{ 5, 483 }, { 20, 484 },
		{ 6, 485 }, { 21, 486 },
		{ 7, 487 }, { 22, 488 },
	},
}

local WOTLK_DUNGEON_HERO_AC_TABLE = { --[Northrend Dungeon Hero]
	name = select(2, GetAchievementInfo(1289)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 1289 },
		{ 2, 489 }, { 17, 490 },
		{ 3, 500 }, { 18, 491 },
		{ 4, 492 }, { 19, 493 },
		{ 5, 494 }, { 20, 495 },
		{ 6, 496 }, { 21, 497 },
		{ 7, 498 }, { 22, 499 },
	},
}

local WOTLK_GLORY_OF_THE_HERO_AC_TABLE = { --[Glory of the Hero]
	name = select(2, GetAchievementInfo(2136)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 2136, "mount59961" },
		{ 2, 1919 }, { 17, 2150 },
		{ 3, 2036 }, { 18, 2037 },
		{ 4, 1296 }, { 19, 1297 },
		{ 5, 1860 }, { 20, 1862 },
		{ 6, 2038 }, { 21, 2056 },
		{ 7, 2151 }, { 22, 2039 },
		{ 8, 2057 }, { 23, 1816 },
		{ 9,  1865 }, { 24, 2041 },
		{ 10, 2153 }, { 25, 1864 },
		{ 11, 2152 }, { 26, 2040 },
		{ 12, 2058 }, { 27, 1866 },
		{ 13, 2154 }, { 28, 2155 },
		{ 14, 1867 }, { 29, 1834 },
		{ 15,  2042 }, { 30, 1817 },
		{ 101, 1872 }, { 116, 2043 },
		{ 102, 1873 }, { 117, 2156 },
		{ 103, 2157 }, { 118, 1871 },
		{ 104, 1868 }, { 119, 2044 },
		{ 105, 2045 }, { 120, 2046 },
	},
}

local WOTLK_RAID1_10_AC_TABLE = { --[Glory of the Raider (10 player)]
	name = select(2, GetAchievementInfo(2137)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 2137 },
		{ 2, 578 }, { 17, 1858 },
		{ 3, 1856 }, { 18, 1996 },
		{ 4, 1997 }, { 19, 2178 },
		{ 5, 2180 }, { 20, 622 },
		{ 6, 1874 }, { 21, 1869 },
		{ 7, 2047 }, { 22, 2051 },
		{ 8, 2146 }, { 23, 2176 },
		{ 9, 2148 }, { 24, 2184 },
	},
}

local WOTLK_RAID1_25_AC_TABLE = { --[Glory of the Raider (25 player)]
	name = select(2, GetAchievementInfo(2138)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[P25_DIFF] = {
		{ 1, 2138 },
		{ 2, 579 }, { 17, 1859 },
		{ 3, 1857 }, { 18, 2139 },
		{ 4, 2140 }, { 19, 2179 },
		{ 5, 2177 }, { 20, 2181 },
		{ 6, 623 }, { 21, 1875 },
		{ 7, 1870 }, { 22, 2048 },
		{ 8, 2149 }, { 23, 2054 },
		{ 9, 2147 }, { 24, 2185 },
	},
}

local WOTLK_RAID2_10_AC_TABLE = { --[Glory of the Ulduar Raider (10 player)]
	name = select(2, GetAchievementInfo(2957)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 2957, "mount63963" },
		{ 2, 3056 }, { 17, 2930 },
		{ 3, 2923 }, { 18, 3058 },
		{ 4, 2941 }, { 19, 2953 },
		{ 5, 3006 }, { 20, 3182 },
		{ 6, 3176 }, { 21, 3179 },
		{ 7, 3180 }, { 22, 3181 },
		{ 8, 3158 }
	},
}

local WOTLK_RAID2_25_AC_TABLE = { --[Glory of the Ulduar Raider (25 player)]
	name = select(2, GetAchievementInfo(2958)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[P25_DIFF] = {
		{ 1, 2958, "mount63956" },
		{ 2, 3057 }, { 17, 2929 },
		{ 3, 2924 }, { 18, 3059 },
		{ 4, 2944 }, { 19, 2954 },
		{ 5, 3007 }, { 20, 3184 },
		{ 6, 3183 }, { 21, 3187 },
		{ 7, 3189 }, { 22, 3188 },
		{ 8, 3163 }
	},
}

local WOTLK_RAID3_10_AC_TABLE = { --[Glory of the Icecrown Raider (10 player)]
	name = select(2, GetAchievementInfo(4602)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 4602, "mount72808" },
		{ 2, 4534 }, { 17, 4535 },
		{ 3, 4536 }, { 18, 4537 },
		{ 4, 4538 }, { 19, 4577 },
		{ 5, 4578 }, { 20, 4582 },
		{ 6, 4539 }, { 21, 4579 },
		{ 7, 4580 }, { 22, 4601 },
	},
	[HEROIC_DIFF] = {
		{ 1, 4602, "mount72808" },
		{ 2, 4628 }, { 17, 4629 },
		{ 3, 4630 }, { 18, 4631 },
	},
}

local WOTLK_RAID3_25_AC_TABLE = { --[Glory of the Icecrown Raider (25 player)]
	name = select(2, GetAchievementInfo(4603)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[P25_DIFF] = {
		{ 1, 4603, "mount72807" },
		{ 2, 4610 }, { 17, 4611 },
		{ 3, 4612 }, { 18, 4613 },
		{ 4, 4614 }, { 19, 4615 },
		{ 5, 4616 }, { 20, 4617 },
		{ 6, 4618 }, { 21, 4619 },
		{ 7, 4620 }, { 22, 4621 },
		{ 8, 4622 }
	},
	[P25H_DIFF] = {
		{ 1, 4603, "mount72807" },
		{ 2, 4632 }, { 17, 4633 },
		{ 3, 4634 }, { 18, 4635 },
	},
}

data["AhnKahet"] = {
	EncounterJournalID = 271,
	MapID = 132,
	AtlasMapID = "AhnKahet",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --AhnkahetNadox
			EncounterJournalID = 580,
			[NORMAL_DIFF] = {
				{ 1, 35606 }, -- Blade of Nadox
				{ 2, 37592 }, -- Brood Plague Helmet
				{ 3, 37594 }, -- Elder Headpiece
				{ 4, 37593 }, -- Sprinting Shoulderpads
				{ 5, 35607 }, -- Ahn'kahar Handwraps
				{ 6, 35608 }, -- Crawler-Emblem Belt
				{ 7, 37591 }, -- Nerubian Shield Ring
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2038" },
			},
		},
		{ --AhnkahetTaldaram
			EncounterJournalID = 581,
			[NORMAL_DIFF] = {
				{ 1, 35609 }, -- Talisman of Scourge Command
				{ 2, 37595 }, -- Necklace of Taldaram
				{ 3, 35610 }, -- Slasher's Amulet
				{ 4, 37612 }, -- Bonegrinder Breastplate
				{ 5, 37613 }, -- Flame Sphere Bindings
				{ 6, 37614 }, -- Gauntlets of the Plundering Geist
				{ 7, 35611 }, -- Gloves of the Blood Prince
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --AhnkahetAmanitar
			EncounterJournalID = 583,
			[HEROIC_DIFF] = {
				{ 1, 43284 }, -- Amanitar Skullbow
				{ 2, 43285 }, -- Amulet of the Spell Flinger
				{ 3, 43287 }, -- Silken Bridge Handwraps
				{ 4, 43286 }, -- Legguards of Swarming Attacks
			},
		},
		{ --AhnkahetJedoga
			EncounterJournalID = 582,
			[NORMAL_DIFF] = {
				{ 1, 43281 }, -- Edge of Oblivion
				{ 2, 44191 }, -- Ice-Rimed Chopper
				{ 3, 43280 }, -- Faceguard of the Hammer Clan
				{ 4, 43282 }, -- Shadowseeker's Pendant
				{ 5, 43278 }, -- Cloak of the Darkcaster
				{ 6, 43283 }, -- Subterranean Waterfall Shroud
				{ 7, 43279 }, -- Battlechest of the Twilight Cult
				{ 8, 43277 }, -- Jedoga's Greatring
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2056" },
			},
		},
		{ --AhnkahetVolazj
			EncounterJournalID = 584,
			[NORMAL_DIFF] = {
				{ 1,  37617 }, -- Staff of Sinister Claws
				{ 2,  37615 }, -- Titanium Compound Bow
				{ 3,  37619 }, -- Wand of Ahn'kahet
				{ 4,  35612 }, -- Mantle of Echoing Bats
				{ 5,  37620 }, -- Bracers of the Herald
				{ 6,  37623 }, -- Fiery Obelisk Handguards
				{ 7,  35613 }, -- Pyramid Embossed Belt
				{ 8,  37616 }, -- Kilt of the Forgotten One
				{ 9,  37622 }, -- Skirt of the Old Kingdom
				{ 10, 37618 }, -- Greaves of Ancient Evil
				{ 11, 35614 }, -- Volazj's Sabatons
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 13, 41790,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Precise Scarlet Ruby
				{ 14, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, "ac1658" },
				{ 17, "ac1862" },
			},
		},
		{ --AhnkahetTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35616 }, -- Spored Tendrils Spaulders
				{ 2, 35615 }, -- Glowworm Cavern Bindings
			},
			[HEROIC_DIFF] = {
				{ 1, 37625 }, -- Web Winder Gloves
				{ 2, 37624 }, -- Stained-Glass Shard Ring
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["AzjolNerub"] = {
	EncounterJournalID = 272,
	MapID = 157,
	AtlasMapID = "AzjolNerub",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --AzjolNerubKrikthir
			EncounterJournalID = 585,
			[NORMAL_DIFF] = {
				{ 1,  35655 },                         -- Cobweb Machete
				{ 2,  37216 },                         -- Facade Shield of Glyphs
				{ 3,  157582 },                        -- Nerubian Mantle
				{ 4,  37219 },                         -- Custodian's Chestpiece
				{ 5,  37217 },                         -- Golden Limb Bands
				{ 6,  35656 },                         -- Aura Focused Gauntlets
				{ 7,  35657 },                         -- Exquisite Spider-Silk Footwraps
				{ 8,  37218 },                         -- Stone-Worn Footwraps
				{ 10, 74616, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Gatewatcher's Talisman
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1296" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188402 }, -- Cobweb Machete
				{ 2, 188411 }, -- Facade Shield of Glyphs
				{ 3, 188428 }, -- Nerubian Mantle
				{ 4, 188414 }, -- Custodian's Chestpiece
				{ 5, 188412 }, -- Golden Limb Bands
				{ 6, 188403 }, -- Aura Focused Gauntlets
				{ 7, 188413 }, -- Stone-Worn Footwraps
				{ 8, 188404 }, -- Exquisite Spider-Silk Footwraps
			},
		},
		{ --AzjolNerubHadronox
			EncounterJournalID = 586,
			[NORMAL_DIFF] = {
				{ 1, 35658 }, -- Life-Staff of the Web Lair
				{ 2, 35660 }, -- Spinneret Epaulets
				{ 3, 37222 }, -- Egg Sac Robes
				{ 4, 37230 }, -- Grotto Mist Gloves
				{ 5, 157581 }, -- Skittering Gauntlets
				{ 6, 37221 }, -- Hollowed Mandible Legplates
				{ 7, 35659 }, -- Treads of Aspiring Heights
				{ 8, 37220 }, -- Essence of Gossamer
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1297" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188405 }, -- Life-Staff of the Web Lair
				{ 2, 188407 }, -- Spinneret Epaulets
				{ 3, 188417 }, -- Egg Sac Robes
				{ 4, 188418 }, -- Grotto Mist Gloves
				{ 5, 188427 }, -- Skittering Gauntlets
				{ 6, 188416 }, -- Hollowed Mandible Legplates
				{ 7, 188406 }, -- Treads of Aspiring Heights
				{ 8, 188415 }, -- Essence of Gossamer
			},
		},
		{ --AzjolNerubAnubarak
			EncounterJournalID = 587,
			[NORMAL_DIFF] = {
				{ 1,  37235 },                         -- Crypt Lord's Deft Blade
				{ 2,  37238 },                         -- Rod of the Fallen Monarch
				{ 3,  37237 },                         -- Chitin Shell Greathelm
				{ 4,  37236 },                         -- Insect Vestments
				{ 5,  37240 },                         -- Flamebeard's Bracers
				{ 6,  37241 },                         -- Ancient Aligned Girdle
				{ 7,  35663 },                         -- Charmed Silken Cord
				{ 8,  37242 },                         -- Sash of the Servant
				{ 9,  35662 },                         -- Wing Cover Girdle
				{ 10, 37232 },                         -- Ring of the Traitor King
				{ 11, 35661 },                         -- Signet of Arachnathid Command
				{ 12, 43411, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Anub'arak's Broken Husk
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 12, 43102 }, -- Frozen Orb
				{ 16, "ac1658" },
				{ 17, "ac1860" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188420 }, -- Crypt Lord's Deft Blade
				{ 2,  188423 }, -- Rod of the Fallen Monarch
				{ 3,  188422 }, -- Chitin Shell Greathelm
				{ 4,  188421 }, -- Insect Vestments
				{ 5,  188424 }, -- Flamebeard's Bracers
				{ 6,  188425 }, -- Ancient Aligned Girdle
				{ 7,  188410 }, -- Charmed Silken Cord
				{ 8,  188426 }, -- Sash of the Servant
				{ 9,  188409 }, -- Wing Cover Girdle
				{ 10, 188419 }, -- Ring of the Traitor King
				{ 11, 188408 }, -- Signet of Arachnathid Command
			},
		},
		{ --AzjolNerubTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[HEROIC_DIFF] = {
				{ 1, 37243 }, -- Treasure Seeker's Belt
				{ 2, 37625 }, -- Web Winder Gloves
				{ 3, 37624 }, -- Stained-Glass Shard Ring
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["DrakTharonKeep"] = {
	EncounterJournalID = 273,
	MapID = 160,
	AtlasMapID = "DrakTharonKeep",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --DrakTharonKeepTrollgore
			EncounterJournalID = 588,
			[NORMAL_DIFF] = {
				{ 1, 35618 }, -- Troll Butcherer
				{ 2, 35620 }, -- Berserker's Horns
				{ 3, 37715 }, -- Cowl of the Dire Troll
				{ 4, 37714 }, -- Batrider's Cord
				{ 5, 35619 }, -- Infection Resistant Legguards
				{ 6, 37717 }, -- Legs of Physical Regeneration
				{ 7, 37712 }, -- Terrace Defence Boots
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2151" },
			},
		},
		{ --DrakTharonKeepNovos
			EncounterJournalID = 589,
			[NORMAL_DIFF] = {
				{ 1, 37721 }, -- Cursed Lich Blade
				{ 2, 35630 }, -- Summoner's Stone Gavel
				{ 3, 37718 }, -- Temple Crystal Fragment
				{ 4, 35631 }, -- Crystal Pendant of Warding
				{ 5, 157558 }, -- Shoddily Stitched Shoulderguards
				{ 6, 37722 }, -- Breastplate of Undeath
				{ 7, 35632 }, -- Robes of Novos
				{ 8, 40490 }, -- Necromantic Wristguards
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2057" },
			},
		},
		{ --DrakTharonKeepKingDred
			EncounterJournalID = 590,
			[NORMAL_DIFF] = {
				{ 1,  35633 },                         -- Staff of the Great Reptile
				{ 2,  37726 },                         -- King Dred's Helm
				{ 3,  35634 },                         -- Scabrous-Hide Helm
				{ 4,  37724 },                         -- Handler's Arm Strap
				{ 5,  37725 },                         -- Savage Wound Wrap
				{ 6,  157561 },                        -- Dino-Toothed Waistguard
				{ 7,  35635 },                         -- Stable Master's Breeches
				{ 8,  37723 },                         -- Incisor Fragment
				{ 10, 74755, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- King Dred's Tooth
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2039" },
			},
		},
		{ --DrakTharonKeepTharonja
			EncounterJournalID = 591,
			[NORMAL_DIFF] = {
				{ 1,  37733 }, -- Mojo Masked Crusher
				{ 2,  35636 }, -- Tharon'ja's Aegis
				{ 3,  35638 }, -- Helmet of Living Flesh
				{ 4,  37735 }, -- Ziggurat Imprinted Chestguard
				{ 5,  37788 }, -- Limb Regeneration Bracers
				{ 6,  37798 }, -- Overlook Handguards
				{ 7,  37791 }, -- Leggings of the Winged Serpent
				{ 8,  35637 }, -- Muradin's Lost Greaves
				{ 9,  37784 }, -- Keystone Great-Ring
				{ 10, 37732 }, -- Spectral Seal of the Prophet
				{ 11, 37734 }, -- Talisman of Troll Divinity
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 12, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, "ac1658" },
			},
		},
		{ --DrakTharonKeepTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35641 }, -- Scytheclaw Boots
				{ 2, 35640 }, -- Darkweb Bindings
				{ 3, 35639 }, -- Brighthelm of Guarding
			},
			[HEROIC_DIFF] = {
				{ 1, 37799 }, -- Reanimator's Cloak
				{ 2, 37800 }, -- Aviary Guardsman's Hauberk
				{ 3, 37801 }, -- Waistguard of the Risen Knight
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["Gundrak"] = {
	EncounterJournalID = 274,
	MapID = 153,
	AtlasMapID = "Gundrak",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --GundrakSladran
			EncounterJournalID = 592,
			[NORMAL_DIFF] = {
				{ 1, 35583 }, -- Witch Doctor's Wildstaff
				{ 2, 37626 }, -- Wand of Sseratus
				{ 3, 37627 }, -- Snake Den Spaulders
				{ 4, 35584 }, -- Embroidered Gown of Zul'Drak
				{ 5, 157578 }, -- Belt of Vile Concoctions
				{ 6, 37628 }, -- Slad'ran's Coiled Cord
				{ 7, 35585 }, -- Cannibal's Legguards
				{ 8, 37629 }, -- Slithering Slippers
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2058" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127527 }, -- Witch Doctor's Wildstaff
				{ 2, 127538 }, -- Wand of Sseratus
				{ 3, 127539 }, -- Snake Den Spaulders
				{ 4, 127528 }, -- Embroidered Gown of Zul'Drak
				{ 5, 127548 }, -- Helm of Cheated Fate
				{ 6, 127540 }, -- Slad'ran's Coiled Cord
				{ 7, 127529 }, -- Cannibal's Legguards
				{ 8, 127541 }, -- Slithering Slippers
			},
		},
		{ --GundrakColossus
			EncounterJournalID = 593,
			[NORMAL_DIFF] = {
				{ 1, 35590 },                         -- Drakkari Hunting Bow
				{ 2, 37636 },                         -- Helm of Cheated Fate
				{ 3, 37635 },                         -- Pauldrons of the Colossus
				{ 4, 35591 },                         -- Shoulderguards of the Ice Troll
				{ 5, 35592 },                         -- Hauberk of Totemic Mastery
				{ 6, 37634 },                         -- Bracers of the Divine Elemental
				{ 7, 37637 },                         -- Living Mojo Belt
				{ 9, 43158, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Drakkari Colossus Fragment
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127533 }, -- Drakkari Hunting Bow
				{ 2, 127537 }, -- Snowmelt Silken Cinch
				{ 3, 127547 }, -- Pauldrons of the Colossus
				{ 4, 127534 }, -- Shoulderguards of the Ice Troll
				{ 5, 127535 }, -- Hauberk of Totemic Mastery
				{ 6, 127546 }, -- Bracers of the Divine Elemental
				{ 7, 127549 }, -- Living Mojo Belt
			},
		},
		{ --GundrakMoorabi
			EncounterJournalID = 594,
			[NORMAL_DIFF] = {
				{ 1, 37631 }, -- Fist of the Deity
				{ 2, 35587 }, -- Frozen Scepter of Necromancy
				{ 3, 37633 }, -- Ground Tremor Helm
				{ 4, 157584 }, -- Drape of Moorabi
				{ 5, 37630 }, -- Shroud of Moorabi
				{ 6, 35588 }, -- Forlorn Breastplate of War
				{ 7, 37632 }, -- Mojo Frenzy Greaves
				{ 8, 35589 }, -- Arcane Focal Signet
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2040" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  127543 }, -- Fist of the Deity
				{ 2,  127530 }, -- Frozen Scepter of Necromancy
				{ 3,  127545 }, -- Ground Tremor Helm
				{ 4,  127558 }, -- Burning Skull Pendant
				{ 5,  127542 }, -- Shroud of Moorabi
				{ 6,  127531 }, -- Forlorn Breastplate of War
				{ 7,  127544 }, -- Mojo Frenzy Greaves
				{ 8,  127532 }, -- Arcane Focal Signet
				{ 9,  127554 }, -- Hemorrhaging Circle
				{ 10, 127560 }, -- Belt of Tasseled Lanterns
			},
		},
		{ --GundrakEck
			EncounterJournalID = 595,
			[HEROIC_DIFF] = {
				{ 1, 43311 }, -- Helmet of the Shrine
				{ 2, 43310 }, -- Engraved Chestplate of Eck
				{ 3, 43313 }, -- Leggings of the Ruins Dweller
				{ 4, 43312 }, -- Gorloc Muddy Footwraps
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127565 }, -- Helmet of the Shrine
				{ 2, 127564 }, -- Engraved Chestplate of Eck
				{ 3, 127567 }, -- Leggings of the Ruins Dweller
				{ 4, 127566 }, -- Gorloc Muddy Footwraps
			},
		},
		{ --GundrakGaldarah
			EncounterJournalID = 596,
			[NORMAL_DIFF] = {
				{ 1,  43309 }, -- Amulet of the Stampede
				{ 2,  43305 }, -- Shroud of Akali
				{ 3,  37641 }, -- Arcane Flame Altar-Garb
				{ 4,  37639 }, -- Grips of the Beast God
				{ 5,  37645 }, -- Horn-Tipped Gauntlets
				{ 6,  37643 }, -- Sash of Blood Removal
				{ 7,  37644 }, -- Gored Hide Legguards
				{ 8,  37640 }, -- Boots of Transformation
				{ 9,  43306 }, -- Gal'darah's Signet
				{ 10, 37642 }, -- Hemorrhaging Circle
				{ 11, 37638 }, -- Offering of Sacrifice
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 12, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, "ac1658" },
				{ 17, "ac2152" },
				{ 18, "ac1864" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  127563 }, -- Amulet of the Stampede
				{ 2,  127561 }, -- Shroud of Akali
				{ 3,  127553 }, -- Arcane Flame Altar-Garb
				{ 4,  127551 }, -- Grips of the Beast God
				{ 5,  127557 }, -- Horn-Tipped Gauntlets
				{ 6,  127555 }, -- Sash of Blood Removal
				{ 7,  127556 }, -- Gored Hide Legguards
				{ 8,  127552 }, -- Boots of Transformation
				{ 9,  127562 }, -- Gal'darah's Signet
				{ 10, 127559 }, -- Cloak of Bloodied Waters
				{ 11, 127550 }, -- Offering of Sacrifice
				{ 12, 127536 }, -- Steel Bear Trap Bracers
			},
		},
		{ --GundrakTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35594 }, -- Snowmelt Silken Cinch
				{ 2, 35593 }, -- Steel Bear Trap Bracers
			},
			[HEROIC_DIFF] = {
				{ 1, 37647 }, -- Cloak of Bloodied Waters
				{ 2, 37648 }, -- Belt of Tasseled Lanterns
				{ 3, 37646 }, -- Burning Skull Pendant
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["UlduarHallsofLightning"] = {
	EncounterJournalID = 275,
	MapID = 138,
	AtlasMapID = "UlduarHallsofLightning",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --HallsofLightningBjarngrim
			EncounterJournalID = 597,
			[NORMAL_DIFF] = {
				{ 1, 36980 }, -- Hewn Sparring Quarterstaff
				{ 2, 157580 }, -- Spark of the Forge
				{ 3, 37814 }, -- Iron Dwarf Smith Pauldrons
				{ 4, 36982 }, -- Mantle of Electrical Charges
				{ 5, 37825 }, -- Traditionally Dyed Handguards
				{ 6, 37826 }, -- The General's Steel Girdle
				{ 7, 37818 }, -- Patroller's War-Kilt
				{ 8, 36979 }, -- Bjarngrim Family Signet
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1834" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127504 }, -- Iron Dwarf Smith Pauldrons
				{ 2, 127506 }, -- Traditionally Dyed Handguards
				{ 3, 127507 }, -- The General's Steel Girdle
				{ 4, 127505 }, -- Patroller's War-Kilt
			},
		},
		{ --HallsofLightningVolkhan
			EncounterJournalID = 598,
			[NORMAL_DIFF] = {
				{ 1, 36984 }, -- Eternally Folded Blade
				{ 2, 36985 }, -- Volkhan's Hood
				{ 3, 36983 }, -- Cape of Seething Steam
				{ 4, 37840 }, -- Shroud of Reverberation
				{ 5, 37843 }, -- Giant-Hair Woven Gloves
				{ 6, 37842 }, -- Belt of Vivacity
				{ 7, 36986 }, -- Kilt of Molten Golems
				{ 8, 157579 }, -- Slag-Stained Legplates
				{ 9, 37841 }, -- Slag Footguards
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2042" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127525 }, -- Helm of the Lightning Halls
				{ 2, 127508 }, -- Shroud of Reverberation
				{ 3, 127511 }, -- Giant-Hair Woven Gloves
				{ 4, 127510 }, -- Belt of Vivacity
				{ 5, 127507 }, -- The General's Steel Girdle
				{ 6, 127509 }, -- Slag Footguards
			},
		},
		{ --HallsofLightningIonar
			EncounterJournalID = 599,
			[NORMAL_DIFF] = {
				{ 1, 39534 }, -- Pauldrons of the Lightning Revenant
				{ 2, 39657 }, -- Tornado Cuffs
				{ 3, 37846 }, -- Charged-Bolt Grips
				{ 4, 39536 }, -- Thundercloud Grasps
				{ 5, 37845 }, -- Cord of Swirling Winds
				{ 6, 39535 }, -- Ionar's Girdle
				{ 7, 37847 }, -- Skywall Striders
				{ 8, 37844 }, -- Winged Talisman
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127519 }, -- Ornate Woolen Stola
				{ 2, 127514 }, -- Charged-Bolt Grips
				{ 3, 127513 }, -- Cord of Swirling Winds
				{ 4, 127515 }, -- Skywall Striders
				{ 5, 127512 }, -- Winged Talisman
			},
		},
		{ --HallsofLightningLoken
			EncounterJournalID = 600,
			[NORMAL_DIFF] = {
				{ 1,  37852 },                         -- Colossal Skull-Clad Cleaver
				{ 2,  37848 },                         -- Lightning Giant Staff
				{ 3,  36989 },                         -- Ancient Measuring Rod
				{ 4,  36994 },                         -- Projectile Activator
				{ 5,  36996 },                         -- Hood of the Furtive Assassin
				{ 6,  37849 },                         -- Planetary Helm
				{ 7,  36988 },                         -- Chaotic Spiral Amulet
				{ 8,  37851 },                         -- Ornate Woolen Stola
				{ 9,  36991 },                         -- Raiments of the Titans
				{ 10, 37853 },                         -- Advanced Tooled-Leather Bands
				{ 11, 36995 },                         -- Fists of Loken
				{ 12, 37850 },                         -- Flowing Sash of Order
				{ 13, 37855 },                         -- Mail Girdle of the Audient Earth
				{ 14, 36992 },                         -- Leather-Braced Chain Leggings
				{ 15, 37854 },                         -- Woven Bracae Leggings
				{ 16, 36993 },                         -- Seal of the Pantheon
				{ 19, 41799, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Eternal Earthsiege Diamond
				{ 20, 43151, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Loken's Tongue
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 17, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 22, "ac1658" },
				{ 23, "ac1867" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127520 }, -- Colossal Skull-Clad Cleaver
				{ 2, 127516 }, -- Lightning Giant Staff
				{ 3, 127524 }, -- Librarian's Paper Cutter
				{ 4, 127517 }, -- Planetary Helm
				{ 5, 127521 }, -- Advanced Tooled-Leather Bands
				{ 6, 127518 }, -- Flowing Sash of Order
				{ 7, 127523 }, -- Mail Girdle of the Audient Earth
				{ 8, 127522 }, -- Woven Bracae Leggings
			},
		},
		{ --HallsofLightningTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 36997 }, -- Sash of the Hardened Watcher
				{ 2, 37000 }, -- Storming Vortex Bracers
				{ 3, 36999 }, -- Boots of the Terrestrial Guardian
			},
			[HEROIC_DIFF] = {
				{ 1, 37858 }, -- Awakened Handguards
				{ 2, 37857 }, -- Helm of the Lightning Halls
				{ 3, 37856 }, -- Librarian's Paper Cutter
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

local FH_TRASH_MOBS = {
	name = AL["Trash Mobs"],
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1, 49854 }, -- Mantle of Tattered Feathers
		{ 2, 49855 }, -- Plated Grips of Korth'azz
		{ 3, 49853 }, -- Titanium Links of Lore
		{ 4, 49852 }, -- Coffin Nail
	},
	[HEROIC_DIFF] = {
		{ 1,  50318 }, -- Ghostly Wristwraps
		{ 2,  50315 }, -- Seven-Fingered Claws
		{ 3,  50319 }, -- Unsharpened Ice Razor
		{ 5,  50380 }, -- Battered Hilt
		{ 6,  50379 }, -- Battered Hilt
		{ 7,  50047 }, -- Quel'Delar, Lens of the Mind
		{ 8,  50046 }, -- Quel'Delar, Cunning of the Shadows
		{ 9,  50049 }, -- Quel'Delar, Ferocity of the Scorned
		{ 10, 50048 }, -- Quel'Delar, Might of the Faithful
		{ 11, 50051 }, -- Hammer of Purified Flame
		{ 12, 50050 }, -- Cudgel of Furious Justice
		{ 13, 50052 }, -- Lightborn Spire
	},
}
data["FHHallsOfReflection"] = {
	EncounterJournalID = 276,
	MapID = 185,
	AtlasMapID = "FHHallsOfReflection",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --HoRFalric
			EncounterJournalID = 601,
			[NORMAL_DIFF] = {
				{ 1,  50290 }, -- Falric's Wrist-Chopper
				{ 2,  49827 }, -- Ghoulslicer
				{ 3,  50291 }, -- Soulsplinter
				{ 4,  49830 }, -- Fallen Sentry's Hood
				{ 5,  50293 }, -- Spaulders of Black Betrayal
				{ 6,  49829 }, -- Valonforth's Tarnished Pauldrons
				{ 7,  49832 }, -- Eerie Runeblade Polisher
				{ 8,  50294 }, -- Chestpiece of High Treason
				{ 9,  50292 }, -- Bracer of Worn Molars
				{ 10, 49828 }, -- Marwyn's Macabre Fingertips
				{ 11, 49831 }, -- Muddied Boots of Brill
				{ 12, 50295 }, -- Spiked Toestompers
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --HoRMarwyn
			EncounterJournalID = 602,
			[NORMAL_DIFF] = {
				{ 1,  50296 }, -- Orca-Hunter's Harpoon
				{ 2,  49833 }, -- Splintered Icecrown Parapet
				{ 3,  49835 }, -- Splintered Door of the Citadel
				{ 4,  50298 }, -- Sightless Crown of Ulmaas
				{ 5,  49834 }, -- Frayed Abomination Stitching Shoulders
				{ 6,  50300 }, -- Choking Hauberk
				{ 7,  50297 }, -- Frostsworn Bone Chestpiece
				{ 8,  49838 }, -- Carpal Tunnelers
				{ 9,  49837 }, -- Mitts of Burning Hail
				{ 10, 50299 }, -- Suspiciously Soft Gloves
				{ 11, 49836 }, -- Frostsworn Bone Leggings
				{ 12, 50260 }, -- Ephemeral Snowflake
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --HoRLichKing
			EncounterJournalID = 603,
			[NORMAL_DIFF] = {
				{ 1,  49839 }, -- Mourning Malice
				{ 2,  50303 }, -- Black Icicle
				{ 3,  49845 }, -- Bone Golem Scapula
				{ 4,  49846 }, -- Chilled Heart of the Glacier
				{ 5,  49840 }, -- Hate-Forged Cleaver
				{ 6,  50302 }, -- Liar's Tongue
				{ 7,  49844 }, -- Crypt Fiend Slayer
				{ 8,  50309 }, -- Shriveled Heart
				{ 9,  49851 }, -- Greathelm of the Silver Hand
				{ 10, 50311 }, -- Second Helm of the Executioner
				{ 11, 49849 }, -- Tattered Glacial-Woven Hood
				{ 12, 50310 }, -- Fossilized Ammonite Choker
				{ 13, 49848 }, -- Grim Lasher Shoulderguards
				{ 14, 49842 }, -- Tapestry of the Frozen Throne
				{ 15, 49841 }, -- Blackened Geist Ribs
				{ 16, 50312 }, -- Chestguard of Broken Branches
				{ 17, 49843 }, -- Crystalline Citadel Gauntlets
				{ 18, 50304 }, -- Hoarfrost Gauntlets
				{ 19, 50314 }, -- Strip of Remorse
				{ 20, 49847 }, -- Legguards of Untimely Demise
				{ 21, 50308 }, -- Blighted Leather Footpads
				{ 22, 50305 }, -- Grinning Skull Boots
				{ 23, 50313 }, -- Oath of Empress Zoe
				{ 24, 50306 }, -- The Lady's Promise
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 25, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 27, "ac4526" },
			},
		},
		FH_TRASH_MOBS,
	}
}

data["UlduarHallsofStone"] = {
	EncounterJournalID = 277,
	MapID = 140,
	AtlasMapID = "UlduarHallsofStone",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --HallsofStoneKrystallus
			EncounterJournalID = 604,
			[NORMAL_DIFF] = {
				{ 1, 37649 }, -- Quarry Chisel
				{ 2, 35670 }, -- Brann's Lost Mining Helmet
				{ 3, 35672 }, -- Hollow Geode Helm
				{ 4, 37652 }, -- Spaulders of Krystallus
				{ 5, 35673 }, -- Leggings of Burning Gleam
				{ 6, 37650 }, -- Shardling Legguards
				{ 7, 37651 }, -- The Prospector's Prize
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --HallsofStoneMaiden
			EncounterJournalID = 605,
			[NORMAL_DIFF] = {
				{ 1, 38618 },                         -- Hammer of Grief
				{ 2, 38613 },                         -- Chain of Fiery Orbs
				{ 3, 38614 },                         -- Embrace of Sorrow
				{ 4, 38615 },                         -- Lightning-Charged Gloves
				{ 5, 38616 },                         -- Maiden's Girdle
				{ 6, 38611 },                         -- Ringlet of Repose
				{ 7, 38617 },                         -- Woeful Band
				{ 9, 74830, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Crystal Tear of Grief
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1866" },
			},
		},
		{ --HallsofStoneTribunal
			EncounterJournalID = 606,
			[NORMAL_DIFF] = {
				{ 1, 37653 }, -- Sword of Justice
				{ 2, 37655 }, -- Mantle of the Tribunal
				{ 3, 35677 }, -- Cosmos Vestments
				{ 4, 35675 }, -- Linked Armor of the Sphere
				{ 5, 157564 }, -- Marbled Bracers
				{ 6, 37656 }, -- Raging Construct Bands
				{ 7, 35676 }, -- Constellation Leggings
				{ 8, 37654 }, -- Sabatons of the Ages
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2154" },
			},
		},
		{ --HallsofStoneSjonnir
			EncounterJournalID = 607,
			[NORMAL_DIFF] = {
				{ 1,  37667 }, -- The Fleshshaper
				{ 2,  35679 }, -- Static Cowl
				{ 3,  35680 }, -- Amulet of Wills
				{ 4,  37658 }, -- Sun-Emblazoned Chestplate
				{ 5,  37668 }, -- Bands of the Stoneforge
				{ 6,  37670 }, -- Sjonnir's Girdle
				{ 7,  35678 }, -- Ironshaper's Legplates
				{ 8,  37669 }, -- Leggings of the Stone Halls
				{ 9,  37666 }, -- Boots of the Whirling Mist
				{ 10, 37660 }, -- Forge Ember
				{ 11, 37657 }, -- Spark of Life
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 12, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, "ac1658" },
				{ 17, "ac2155" },
			},
		},
		{ --HallsofStoneTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35682 }, -- Rune Giant Bindings
				{ 2, 35683 }, -- Palladium Ring
				{ 3, 35681 }, -- Unrelenting Blade
			},
			[HEROIC_DIFF] = {
				{ 1, 37673 }, -- Dark Runic Mantle
				{ 2, 37672 }, -- Patina-Coated Breastplate
				{ 3, 37671 }, -- Refined Ore Gloves
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["FHPitOfSaron"] = {
	EncounterJournalID = 278,
	MapID = 184,
	AtlasMapID = "FHPitOfSaron",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --PoSGarfrost
			EncounterJournalID = 608,
			[NORMAL_DIFF] = {
				{ 1,  49802 },                         -- Garfrost's Two-Ton Hammer
				{ 2,  49801 },                         -- Unspeakable Secret
				{ 3,  50227 },                         -- Surgeon's Needle
				{ 4,  49804 },                         -- Polished Mirror Helm
				{ 5,  50228 },                         -- Barbed Ymirheim Choker
				{ 6,  50234 },                         -- Shoulderplates of Frozen Blood
				{ 7,  50233 },                         -- Spurned Val'kyr Shoulderguards
				{ 8,  50230 },                         -- Malykriss Vambraces
				{ 9,  49806 },                         -- Flayer's Black Belt
				{ 10, 50229 },                         -- Legguards of the Frosty Depths
				{ 11, 49805 },                         -- Ice-Steeped Sandals
				{ 12, 49803 },                         -- Ring of Carnelian and Bone
				{ 14, 49723, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- The Forgemaster's Hammer
			},
			[HEROIC_DIFF] = {
				{ 1, 49802 }, -- Garfrost's Two-Ton Hammer
				{ 2, 50227 }, -- Surgeon's Needle
				{ 3, 50228 }, -- Barbed Ymirheim Choker
				{ 4, 50234 }, -- Shoulderplates of Frozen Blood
				{ 5, 50233 }, -- Spurned Val'kyr Shoulderguards
				{ 6, 49806 }, -- Flayer's Black Belt
				{ 7, 49805 }, -- Ice-Steeped Sandals
				--{ 16, "ac4524" },
			},
			[MYTHIC_DIFF] = {
				GetItemsFromDiff = HEROIC_DIFF,
			},
		},
		{ --PoSKrickIck
			EncounterJournalID = 609,
			[NORMAL_DIFF] = {
				{ 1,  49807 }, -- Krick's Beetle Stabber
				{ 2,  50262 }, -- Felglacier Bolter
				{ 3,  50266 }, -- Ancient Polar Bear Hide
				{ 4,  50264 }, -- Chewed Leather Wristguards
				{ 5,  49809 }, -- Wristguards of Subterranean Moss
				{ 6,  49808 }, -- Bent Gold Belt
				{ 7,  50263 }, -- Braid of Salt and Fire
				{ 8,  49810 }, -- Scabrous Zombie Belt
				{ 9,  49811 }, -- Black Dragonskin Breeches
				{ 10, 50265 }, -- Blackened Ghoul Skin Leggings
				{ 11, 49812 }, -- Purloined Wedding Ring
				{ 12, 50235 }, -- Ick's Rotting Thumb
			},
			[HEROIC_DIFF] = {
				{ 1, 49807 }, -- Krick's Beetle Stabber
				{ 2, 50264 }, -- Chewed Leather Wristguards
				{ 3, 49809 }, -- Wristguards of Subterranean Moss
				{ 4, 49808 }, -- Bent Gold Belt
				{ 5, 50263 }, -- Braid of Salt and Fire
				{ 6, 49810 }, -- Scabrous Zombie Leather Belt
				{ 7, 49811 }, -- Black Dragonskin Breeches
				{ 8, 49812 }, -- Purloined Wedding Ring
				{ 9, 252421 }, -- Rotting Globule
			},
			[MYTHIC_DIFF] = {
				GetItemsFromDiff = HEROIC_DIFF,
			},
		},
		{ --PoSTyrannus
			EncounterJournalID = 610,
			[NORMAL_DIFF] = {
				{ 1,  50267 }, -- Tyrannical Beheader
				{ 2,  50273 }, -- Engraved Gargoyle Femur
				{ 3,  50268 }, -- Rimefang's Claw
				{ 4,  49813 }, -- Rimebane Rifle
				{ 5,  49821 }, -- Protector of Frigid Souls
				{ 6,  49824 }, -- Horns of the Spurned Val'kyr
				{ 7,  49819 }, -- Skeleton Lord's Cranium
				{ 8,  49818 }, -- Painfully Sharp Choker
				{ 9,  49823 }, -- Cloak of the Fallen Cardinal
				{ 10, 50285 }, -- Icebound Bronze Cuirass
				{ 11, 50272 }, -- Frost Wyrm Ribcage
				{ 12, 49825 }, -- Palebone Robes
				{ 13, 49816 }, -- Scourgelord's Frigid Chestplate
				{ 14, 49826 }, -- Shroud of Rime
				{ 15, 49820 }, -- Gondria's Spectral Bracer
				{ 16, 50284 }, -- Rusty Frozen Fingerguards
				{ 17, 50270 }, -- Belt of Rotted Fingernails
				{ 18, 50269 }, -- Fleshwerk Leggings
				{ 19, 49822 }, -- Rimewoven Silks
				{ 20, 49817 }, -- Shaggy Wyrmleather Leggings
				{ 21, 50286 }, -- Prelate's Snowshoes
				{ 22, 50283 }, -- Mudslide Boots
				{ 23, 50271 }, -- Band of Stained Souls
				{ 24, 50259 }, -- Nevermelting Ice Crystal
				{ 26, 267007 }, -- Eye of Acherus
			},
			[HEROIC_DIFF] = {
				{ 1,  49813 }, -- Rimebane Rifle
				{ 2,  49824 }, -- Horns of the Spurned Val'kyr
				{ 3,  49819 }, -- Skeleton Lord's Cranium
				{ 4,  49823 }, -- Cloak of the Fallen Cardinal
				{ 5,  50272 }, -- Frost Wyrm Ribcage
				{ 6,  49825 }, -- Palebone Robes
				{ 7,  49817 }, -- Shaggy Wyrmleather Leggings
				{ 8,  50259 }, -- Nevermelting Ice Crystal
				{ 10, 267007 }, -- Eye of Acherus
				--{ 23, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				--{ 25, "ac4525" },
			},
			[MYTHIC_DIFF] = {
				GetItemsFromDiff = HEROIC_DIFF,
			},
		},
		FH_TRASH_MOBS,
	}
}

data["CoTOldStratholme"] = {
	EncounterJournalID = 279,
	MapID = 130,
	AtlasMapID = "CoTOldStratholme",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --CoTStratholmeMeathook
			EncounterJournalID = 611,
			[NORMAL_DIFF] = {
				{ 1, 37081 }, -- Meathook's Slicer
				{ 2, 37679 }, -- Spaulders of the Abomination
				{ 3, 37678 }, -- Bile-Cured Gloves
				{ 4, 37680 }, -- Belt of Unified Souls
				{ 5, 37083 }, -- Kilt of Sewn Flesh
				{ 6, 37675 }, -- Legplates of Steel Implants
				{ 7, 37082 }, -- Slaughterhouse Sabatons
				{ 8, 37079 }, -- Enchanted Wire Stitching
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTStratholmeSalramm
			EncounterJournalID = 612,
			[NORMAL_DIFF] = {
				{ 1, 37681 }, -- Gavel of the Fleshcrafter
				{ 2, 37086 }, -- Tome of Salramm
				{ 3, 37684 }, -- Forgotten Shadow Hood
				{ 4, 37683 }, -- Necromancer's Amulet
				{ 5, 37084 }, -- Flowing Cloak of Command
				{ 6, 37682 }, -- Bindings of Dark Will
				{ 7, 37088 }, -- Spiked Metal Cilice
				{ 8, 37095 }, -- Waistband of the Thuzadin
				{ 9, 157563 }, -- Freshly Sewn Leggings
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTStratholmeEpoch
			EncounterJournalID = 613,
			[NORMAL_DIFF] = {
				{ 1, 37099 }, -- Sempiternal Staff
				{ 2, 37096 }, -- Necklace of the Chrono-Lord
				{ 3, 37686 }, -- Cracked Epoch Grasps
				{ 4, 37687 }, -- Gloves of Distorted Time
				{ 5, 37106 }, -- Ouroboros Belt
				{ 6, 37688 }, -- Legplates of the Infinite Drakonid
				{ 7, 37105 }, -- Treads of Altered History
				{ 8, 37685 }, -- Mobius Band
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --CoTStratholmeMalGanis
			EncounterJournalID = 614,
			[NORMAL_DIFF] = {
				{ 1,  37108 }, -- Dreadlord's Blade
				{ 2,  37112 }, -- Beguiling Scepter
				{ 3,  37693 }, -- Greed
				{ 4,  37692 }, -- Pierce's Pistol
				{ 5,  37107 }, -- Leeka's Shield
				{ 6,  43085 }, -- Royal Crest of Lordaeron
				{ 7,  37689 }, -- Pendant of the Nathrezim
				{ 8,  37109 }, -- Discarded Silver Hand Spaulders
				{ 9,  37691 }, -- Mantle of Deceit
				{ 10, 37690 }, -- Pauldrons of Destiny
				{ 11, 37113 }, -- Demonic Fabric Bands
				{ 12, 37696 }, -- Plague-Infected Bracers
				{ 13, 37110 }, -- Gauntlets of Dark Conversion
				{ 14, 37114 }, -- Gloves of Northern Lordaeron
				{ 15, 37695 }, -- Legguards of Nature's Power
				{ 16, 37694 }, -- Band of Guile
				{ 17, 37111 }, -- Soul Preserver
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 18, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 20, "ac1658" },
			},
		},
		{ --CoTStratholmeTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  37117 },     -- King's Square Bracers
				{ 2,  37116 },     -- Epaulets of Market Row
				{ 3,  37115 },     -- Crusader's Square Pauldrons
				{ 5,  "INV_Box_01", "ac1817", AL["Infinite Corruptor"], nil },
				{ 6,  43951,        "mount" }, -- Reins of the Bronze Drake
				{ 16, "ac1872" },
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["FHTheForgeOfSouls"] = {
	EncounterJournalID = 280,
	MapID = 183,
	AtlasMapID = "FHTheForgeOfSouls",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --FoSBronjahm
			EncounterJournalID = 615,
			[NORMAL_DIFF] = {
				{ 1,  49783 }, -- Lucky Old Sun
				{ 2,  50191 }, -- Nighttime
				{ 3,  50197 }, -- Eyes of Bewilderment
				{ 4,  50196 }, -- Love's Prisoner
				{ 5,  49785 }, -- Bewildering Shoulderpads
				{ 6,  50193 }, -- Very Fashionable Shoulders
				{ 7,  49786 }, -- Robes of the Cheating Heart
				{ 8,  49787 }, -- Seven Stormy Mornings
				{ 9,  49788 }, -- Cold Sweat Grips
				{ 10, 50194 }, -- Weeping Gauntlets
				{ 11, 49784 }, -- Minister's Number One Legplates
				{ 13, 50317 }, -- Papa's New Bag
				{ 14, 50316 }, -- Papa's Brand New Bag
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac4522" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188473 }, -- Nighttime
				{ 2,  188455 }, -- Lucky Old Sun
				{ 3,  188477 }, -- Eyes of Bewilderment
				{ 4,  188476 }, -- Love's Prisoner
				{ 5,  188474 }, -- Very Fashionable Shoulders
				{ 6,  188457 }, -- Bewildering Shoulderpads
				{ 7,  188458 }, -- Robes of the Cheating Heart
				{ 8,  188459 }, -- Seven Stormy Mornings
				{ 9,  188460 }, -- Cold Sweat Grips
				{ 10, 188475 }, -- Weeping Gauntlets
				{ 11, 188456 }, -- Minister's Number One Legplates
				{ 13, 50317 }, -- Papa's New Bag
				{ 14, 50316 }, -- Papa's Brand New Bag
			},
		},
		{ --FoSDevourer
			EncounterJournalID = 616,
			[NORMAL_DIFF] = {
				{ 1,  49790 }, -- Blood Boil Lancet
				{ 2,  49793 }, -- Tower of the Mouldering Corpse
				{ 3,  50203 }, -- Blood Weeper
				{ 4,  49789 }, -- Heartshiver
				{ 5,  50210 }, -- Seethe
				{ 6,  50206 }, -- Frayed Scoundrel's Cap
				{ 7,  50214 }, -- Helm of the Spirit Shock
				{ 8,  50211 }, -- Arcane Loops of Anger
				{ 9,  49799 }, -- Coil of Missing Gems
				{ 10, 50208 }, -- Pauldrons of the Souleater
				{ 11, 49792 }, -- Accursed Crawling Cape
				{ 12, 49791 }, -- Lost Reliquary Chestguard
				{ 13, 50213 }, -- Mord'rethar Robes
				{ 14, 49797 }, -- Brace Guards of the Starless Night
				{ 15, 50209 }, -- Essence of Suffering
				{ 16, 50212 }, -- Essence of Desire
				{ 17, 49796 }, -- Essence of Anger
				{ 18, 49794 }, -- Legplates of Frozen Granite
				{ 19, 50207 }, -- Black Spire Sabatons
				{ 20, 50215 }, -- Recovered Reliquary Boots
				{ 21, 49795 }, -- Sollerets of Suffering
				{ 22, 49798 }, -- Soul Screaming Boots
				{ 23, 49800 }, -- Spiteful Signet
				{ 24, 50198 }, -- Needle-Encrusted Scorpion
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 25, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 27, "ac4523" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188462 }, -- Blood Boil Lancet
				{ 2,  188465 }, -- Tower of the Mouldering Corpse
				{ 3,  188479 }, -- Blood Weeper
				{ 4,  188461 }, -- Heartshiver
				{ 5,  188484 }, -- Seethe
				{ 6,  188480 }, -- Frayed Scoundrel's Cap
				{ 7,  188488 }, -- Helm of the Spirit Shock
				{ 8,  188485 }, -- Arcane Loops of Anger
				{ 9,  188471 }, -- Coil of Missing Gems
				{ 10, 188482 }, -- Pauldrons of the Souleater
				{ 11, 188464 }, -- Accursed Crawling Cape
				{ 12, 188463 }, -- Lost Reliquary Chestguard
				{ 13, 188487 }, -- Mord'rethar Robes
				{ 14, 188469 }, -- Brace Guards of the Starless Night
				{ 15, 188483 }, -- Essence of Suffering
				{ 16, 188486 }, -- Essence of Desire
				{ 17, 188468 }, -- Essence of Anger
				{ 18, 188466 }, -- Legplates of Frozen Granite
				{ 19, 188481 }, -- Black Spire Sabatons
				{ 20, 188489 }, -- Recovered Reliquary Boots
				{ 21, 188467 }, -- Sollerets of Suffering
				{ 22, 188470 }, -- Soul Screaming Boots
				{ 23, 188472 }, -- Spiteful Signet
				{ 24, 188478 }, -- Needle-Encrusted Scorpion
			},
		},
		FH_TRASH_MOBS,
	}
}

data["TheNexus"] = {
	EncounterJournalID = 281,
	MapID = 129,
	AtlasMapID = "TheNexus",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --TheNexusKolurg
			EncounterJournalID = 833,
			[HEROIC_DIFF] = {
				{ 1, 37728 }, -- Cloak of the Enemy
				{ 2, 37729 }, -- Grips of Sculptured Icicles
				{ 3, 37731 }, -- Opposed Stasis Leggings
				{ 4, 37730 }, -- Cleric's Linen Shoes
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127568 }, -- Glacier Sharpened Vileblade
				{ 2, 127603 }, -- Cloak of the Enemy
				{ 3, 127600 }, -- Rippling Azure Cloak
				{ 4, 127604 }, -- Grips of Sculptured Icicles
				{ 5, 127606 }, -- Opposed Stasis Leggings
				{ 6, 127569 }, -- Attuned Crystalline Boots
				{ 7, 127605 }, -- Cleric's Linen Shoes
				{ 8, 127570 }, -- Band of Glittering Permafrost
				{ 9, 127594 }, -- Sphere of Red Dragon's Blood
			},
		},
		{ --TheNexusStoutbeard
			EncounterJournalID = 617,
			[HEROIC_DIFF] = {
				{ 1, 37728 }, -- Cloak of the Enemy
				{ 2, 37729 }, -- Grips of Sculptured Icicles
				{ 3, 37731 }, -- Opposed Stasis Leggings
				{ 4, 37730 }, -- Cleric's Linen Shoes
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127568 }, -- Glacier Sharpened Vileblade
				{ 2, 127603 }, -- Cloak of the Enemy
				{ 3, 127600 }, -- Rippling Azure Cloak
				{ 4, 127604 }, -- Grips of Sculptured Icicles
				{ 5, 127606 }, -- Opposed Stasis Leggings
				{ 6, 127569 }, -- Attuned Crystalline Boots
				{ 7, 127605 }, -- Cleric's Linen Shoes
				{ 8, 127570 }, -- Band of Glittering Permafrost
				{ 9, 127594 }, -- Sphere of Red Dragon's Blood
			},
		},
		{ --TheNexusTelestra
			EncounterJournalID = 618,
			[NORMAL_DIFF] = {
				{ 1, 35617 }, -- Wand of Shimmering Scales
				{ 2, 37134 }, -- Telestra's Journal
				{ 3, 37135 }, -- Arcane-Shielded Helm
				{ 4, 37139 }, -- Spaulders of the Careless Thief
				{ 5, 37138 }, -- Bands of Channeled Energy
				{ 6, 35604 }, -- Insulating Bindings
				{ 7, 35605 }, -- Belt of Draconic Runes
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2150" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127579 }, -- Wand of Shimmering Scales
				{ 2, 127580 }, -- Telestra's Journal
				{ 3, 127581 }, -- Arcane-Shielded Helm
				{ 4, 127583 }, -- Spaulders of the Careless Thief
				{ 5, 127582 }, -- Bands of Channeled Energy
				{ 6, 127577 }, -- Insulating Bindings
				{ 7, 127578 }, -- Belt of Draconic Runes
			},
		},
		{ --TheNexusAnomalus
			EncounterJournalID = 619,
			[NORMAL_DIFF] = {
				{ 1, 35598 }, -- Tome of the Lore Keepers
				{ 2, 37149 }, -- Helm of Anomalus
				{ 3, 37141 }, -- Amulet of Dazzling Light
				{ 4, 37144 }, -- Hauberk of the Arcane Wraith
				{ 5, 35599 }, -- Gauntlets of Serpent Scales
				{ 6, 35600 }, -- Cleated Ice Boots
				{ 7, 37150 }, -- Rift Striders
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2037" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127574 }, -- Drakonid Arm Blade
				{ 2, 127575 }, -- Chiseled Stalagmite Pauldrons
				{ 3, 127590 }, -- Gloves of the Crystal Gardener
				{ 4, 127589 }, -- Girdle of Ice
				{ 5, 127591 }, -- Frozen Forest Kilt
				{ 6, 127602 }, -- Cavern Leather Treads
				{ 7, 127576 }, -- Greaves of the Blue Flight
				{ 8, 127588 }, -- Band of Frosted Thorns
			},
		},
		{ --TheNexusOrmorok
			EncounterJournalID = 620,
			[NORMAL_DIFF] = {
				{ 1, 35601 }, -- Drakonid Arm Blade
				{ 2, 35602 }, -- Chiseled Stalagmite Pauldrons
				{ 3, 37153 }, -- Gloves of the Crystal Gardener
				{ 4, 157559 }, -- Chilly Cinch
				{ 5, 37152 }, -- Girdle of Ice
				{ 6, 37155 }, -- Frozen Forest Kilt
				{ 7, 35603 }, -- Greaves of the Blue Flight
				{ 8, 37151 }, -- Band of Frosted Thorns
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127568 }, -- Glacier Sharpened Vileblade
				{ 2, 127603 }, -- Cloak of the Enemy
				{ 3, 127600 }, -- Rippling Azure Cloak
				{ 4, 127604 }, -- Grips of Sculptured Icicles
				{ 5, 127606 }, -- Opposed Stasis Leggings
				{ 6, 127569 }, -- Attuned Crystalline Boots
				{ 7, 127605 }, -- Cleric's Linen Shoes
				{ 8, 127570 }, -- Band of Glittering Permafrost
				{ 9, 127594 }, -- Sphere of Red Dragon's Blood
			},
		},
		{ --TheNexusKeristrasza
			EncounterJournalID = 621,
			[NORMAL_DIFF] = {
				{ 1,  35595 }, -- Glacier Sharpened Vileblade
				{ 2,  37169 }, -- War Mace of Unrequited Love
				{ 3,  37162 }, -- Bulwark of the Noble Protector
				{ 4,  37165 }, -- Crystal-Infused Tunic
				{ 5,  37170 }, -- Interwoven Scale Bracers
				{ 6,  37172 }, -- Gloves of Glistening Runes
				{ 7,  157565 }, -- Tangler-Leather Gloves
				{ 8,  37171 }, -- Flame-Bathed Steel Girdle
				{ 9,  35596 }, -- Attuned Crystalline Boots
				{ 10, 37167 }, -- Dragon Slayer's Sabatons
				{ 11, 35597 }, -- Band of Glittering Permafrost
				{ 12, 37166 }, -- Sphere of Red Dragon's Blood
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 13, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, "ac1658" },
				{ 17, "ac2036" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 127596 }, -- War Mace of Unrequited Love
				{ 2, 127592 }, -- Bulwark of the Noble Protector
				{ 3, 127593 }, -- Crystal-Infused Tunic
				{ 4, 127597 }, -- Interwoven Scale Bracers
				{ 5, 127599 }, -- Gloves of Glistening Runes
				{ 6, 127598 }, -- Flame-Bathed Steel Girdle
				{ 7, 127595 }, -- Dragon Slayer's Sabatons
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["TheOculus"] = {
	EncounterJournalID = 282,
	MapID = 143,
	AtlasMapID = "TheOculus",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --OcuDrakos
			EncounterJournalID = 622,
			[NORMAL_DIFF] = {
				{ 1, 157562 }, -- Rod of Aggressive Questioning
				{ 2, 36944 }, -- Lifeblade of Belgaristrasz
				{ 3, 37255 }, -- The Interrogator
				{ 4, 36943 }, -- Timeless Beads of Eternos
				{ 5, 37258 }, -- Drakewing Raiments
				{ 6, 36946 }, -- Runic Cage Chestpiece
				{ 7, 37256 }, -- Scaled Armor of Drakos
				{ 8, 36945 }, -- Verdisa's Cuffs of Dreaming
				{ 9, 37257 }, -- Band of Torture
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --OcuCloudstrider
			EncounterJournalID = 623,
			[NORMAL_DIFF] = {
				{ 1, 37260 }, -- Cloudstrider's Waraxe
				{ 2, 36948 }, -- Horned Helm of Varos
				{ 3, 36947 }, -- Centrifuge Core Cloak
				{ 4, 36950 }, -- Wing Commander's Breastplate
				{ 5, 37261 }, -- Gloves of Radiant Light
				{ 6, 36949 }, -- Gloves of the Azure-Lord
				{ 7, 37262 }, -- Azure Ringmail Leggings
				{ 8, 37263 }, -- Legplates of the Oculus Guardian
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --OcuUrom
			EncounterJournalID = 624,
			[NORMAL_DIFF] = {
				{ 1, 36953 }, -- Spaulders of Skillful Maneuvers
				{ 2, 37288 }, -- Catalytic Bands
				{ 3, 36951 }, -- Sidestepping Handguards
				{ 4, 36952 }, -- Girdle of Obscuring
				{ 5, 37289 }, -- Sash of Phantasmal Images
				{ 6, 36954 }, -- The Conjurer's Slippers
				{ 7, 37195 }, -- Band of Enchanted Growth
				{ 8, 37264 }, -- Pendulum of Telluric Currents
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --OcuEregos
			EncounterJournalID = 625,
			[NORMAL_DIFF] = {
				{ 1,  36975 },                         -- Malygos' Favor
				{ 2,  37360 },                         -- Staff of Draconic Combat
				{ 3,  36962 },                         -- Wyrmclaw Battleaxe
				{ 4,  37294 },                         -- Crown of Unbridled Magic
				{ 5,  36971 },                         -- Headguard of Westrift
				{ 6,  36969 },                         -- Helm of the Ley-Guardian
				{ 7,  37293 },                         -- Mask of the Watcher
				{ 8,  37291 },                         -- Ancient Dragon Spirit Cape
				{ 9,  36974 },                         -- Eregos' Ornamented Chestguard
				{ 10, 36973 },                         -- Vestments of the Scholar
				{ 11, 37361 },                         -- Cuffs of Winged Levitation
				{ 12, 37363 },                         -- Gauntlets of Dragon Wrath
				{ 13, 37362 },                         -- Leggings of Protective Auras
				{ 14, 37292 },                         -- Ley-Guardian's Legguards
				{ 15, 36961 },                         -- Dragonflight Great-Ring
				{ 16, 36972 },                         -- Tome of Arcane Phenomena
				{ 19, 41798, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Bracing Earthsiege Diamond
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 17, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 21, 52676,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Cache of the Ley-Guardian
				{ 23, "ac1658" },
				{ 24, "ac1868" },
				{ 25, "ac1871" },
				{ 26, "ac2046" },
				{ 27, "ac2045" },
				{ 28, "ac2044" },
			},
		},
		{ --OcuTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 36978 }, -- Ley-Whelphide Belt
				{ 2, 36977 }, -- Bindings of the Construct
				{ 3, 36976 }, -- Ring-Lord's Leggings
			},
			[HEROIC_DIFF] = {
				{ 1, 37366 }, -- Drake-Champion's Bracers
				{ 2, 37365 }, -- Bands of the Sky Ring
				{ 3, 37290 }, -- Dragon Prow Amulet
				{ 4, 37364 }, -- Frostbridge Orb
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["VioletHold"] = {
	EncounterJournalID = 283,
	MapID = 168,
	AtlasMapID = "VioletHold",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --VioletHoldErekem
			EncounterJournalID = 626,
			[NORMAL_DIFF] = {
				{ 1, 43407 }, -- Stormstrike Mace
				{ 2, 157583 }, -- Protector's Buckler
				{ 3, 43406 }, -- Cloak of the Gushing Wound
				{ 4, 43363 }, -- Screeching Cape
				{ 5, 43375 }, -- Trousers of the Arakkoa
				{ 6, 157567 }, -- Bodyguard's Treads
				{ 7, 43405 }, -- Sabatons of Erekem
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1865" },
			},
		},
		{ --VioletHoldMoragg
			EncounterJournalID = 627,
			[NORMAL_DIFF] = {
				{ 1, 43409 }, -- Saliva Corroded Pike
				{ 2, 43387 }, -- Shoulderplates of the Beholder
				{ 3, 43410 }, -- Moragg's Chestguard
				{ 4, 157566 }, -- Vest of the Observant
				{ 5, 43382 }, -- Band of Eyes
				{ 6, 43408 }, -- Solitaire of Reflecting Beams
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1865" },
			},
		},
		{ --VioletHoldIchoron
			EncounterJournalID = 628,
			[NORMAL_DIFF] = {
				{ 1, 35643 }, -- Spaulders of Ichoron
				{ 2, 43401 }, -- Water-Drenched Robe
				{ 3, 37862 }, -- Gauntlets of the Water Revenant
				{ 4, 35647 }, -- Handguards of Rapid Pursuit
				{ 5, 157569 }, -- Chain Leggings of the Tide
				{ 6, 37869 }, -- Globule Signet
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2041" },
				{ 17, "ac1865" },
			},
		},
		{ --VioletHoldXevozz
			EncounterJournalID = 629,
			[NORMAL_DIFF] = {
				{ 1, 35642 }, -- Riot Shield
				{ 2, 157575 }, -- Crystal of Ensnared Power
				{ 3, 37861 }, -- Necklace of Arcane Spheres
				{ 4, 157571 }, -- Gauntlets of Stuttering Reality
				{ 5, 37868 }, -- Girdle of the Ethereal
				{ 6, 35644 }, -- Xevozz's Belt
				{ 7, 37867 }, -- Footwraps of Teleportation
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1865" },
			},
		},
		{ --VioletHoldLavanthor
			EncounterJournalID = 630,
			[NORMAL_DIFF] = {
				{ 1, 37871 }, -- The Key
				{ 2, 35645 }, -- Prison Warden's Shotgun
				{ 3, 157570 }, -- Helm of Cauterization
				{ 4, 157572 }, -- Pauldrons of the Great Tide
				{ 5, 35646 }, -- Lava Burn Gloves
				{ 6, 37870 }, -- Twin-Headed Boots
				{ 7, 37872 }, -- Lavanthor's Talisman
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1865" },
			},
		},
		{ --VioletHoldZuramat
			EncounterJournalID = 631,
			[NORMAL_DIFF] = {
				{ 1, 157568 }, -- Helm of Dire Vision
				{ 2, 43403 }, -- Shroud of Darkness
				{ 3, 43358 }, -- Pendant of Shadow Beams
				{ 4, 43404 }, -- Zuramat's Necklace
				{ 5, 43353 }, -- Void Sentry Legplates
				{ 6, 43402 }, -- The Obliterator Greaves
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2153" },
				{ 17, "ac1865" },
			},
		},
		{ --VioletHoldCyanigosa
			EncounterJournalID = 632,
			[NORMAL_DIFF] = {
				{ 1,  35649 }, -- Jailer's Baton
				{ 2,  37883 }, -- Staff of Trickery
				{ 3,  37875 }, -- Spaulders of the Violet Hold
				{ 4,  37884 }, -- Azure Cloth Bindings
				{ 5,  150845 }, -- Bracers of Ley-Line Eradication
				{ 6,  37874 }, -- Gauntlets of Capture
				{ 7,  37886 }, -- Handgrips of the Savage Emissary
				{ 8,  35651 }, -- Plate Claws of the Dragon
				{ 9,  43500 }, -- Bolstered Legplates
				{ 10, 37876 }, -- Cyanigosa's Leggings
				{ 11, 35650 }, -- Boots of the Portal Guardian
				{ 12, 37873 }, -- Mark of the War Prisoner
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 13, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, "ac1658" },
				{ 17, "ac1816" },
			},
		},
		{ --VioletHoldTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35654 }, -- Bindings of the Bastille
				{ 2, 35653 }, -- Girdle of the Mystical Prison
				{ 3, 35652 }, -- Incessant Torch
			},
			[HEROIC_DIFF] = {
				{ 1, 35654 }, -- Bindings of the Bastille
				{ 2, 37890 }, -- Chain Gang Legguards
				{ 3, 37891 }, -- Cast Iron Shackles
				{ 4, 35653 }, -- Girdle of the Mystical Prison
				{ 5, 37889 }, -- Prison Manifest
				{ 6, 35652 }, -- Incessant Torch
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["TrialOfTheChampion"] = {
	EncounterJournalID = 284,
	MapID = 171,
	AtlasMapID = "TrialOfTheChampion",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --TrialoftheChampionChampions
			EncounterJournalID = 834,
			[NORMAL_DIFF] = {
				{ 1,  47493 }, -- Edge of Ruin
				{ 2,  47172 }, -- Helm of the Bested Gallant
				{ 3,  47250 }, -- Pauldrons of the Deafening Gale
				{ 4,  47176 }, -- Breastplate of the Imperial Joust
				{ 5,  47178 }, -- Carapace of Grim Visions
				{ 6,  47244 }, -- Chestguard of the Ravenous Fiend
				{ 7,  47173 }, -- Bindings of the Wicked
				{ 8,  47177 }, -- Gloves of the Argent Fanatic
				{ 9,  47170 }, -- Belt of Fierce Competition
				{ 10, 47181 }, -- Belt of the Churning Blaze
				{ 11, 47174 }, -- Binding of the Tranquil Glade
				{ 12, 47185 }, -- Leggings of the Haggard Apprentice
				{ 13, 47249 }, -- Leggings of the Snowy Bramble
				{ 14, 47171 }, -- Legguards of Abandoned Fealty
				{ 15, 47175 }, -- Scale Boots of the Outlander
				{ 16, 47248 }, -- Treads of Dismal Fortune
				{ 17, 47243 }, -- Mark of the Relentless
				{ 18, 47213 }, -- Abyssal Rune
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --TrialoftheChampionEadricthePure
			EncounterJournalID = 635,
			[NORMAL_DIFF] = {
				{ 1,  47508 }, -- Aledar's Battlestar
				{ 2,  47509 }, -- Mariel's Sorrow
				{ 3,  47500 }, -- Peacekeeper Blade
				{ 4,  47497 }, -- Helm of the Crestfallen Challenger
				{ 5,  47494 }, -- Ancient Pendant of Arathor
				{ 6,  47502 }, -- Majestic Silversmith Shoulderplates
				{ 7,  47210 }, -- Mantle of Gnarled Overgrowth
				{ 8,  47501 }, -- Kurisu's Indecision
				{ 9,  47176 }, -- Breastplate of the Imperial Joust
				{ 10, 47178 }, -- Carapace of Grim Visions
				{ 11, 47496 }, -- Armbands of the Wary Lookout
				{ 12, 47197 }, -- Gauntlets of the Stouthearted Crusader
				{ 13, 47498 }, -- Gloves of Dismal Fortune
				{ 14, 47177 }, -- Gloves of the Argent Fanatic
				{ 15, 47181 }, -- Belt of the Churning Blaze
				{ 16, 47202 }, -- Leggings of Brazen Trespass
				{ 17, 47185 }, -- Leggings of the Haggard Apprentice
				{ 18, 47495 }, -- Legplates of Relentless Onslaught
				{ 19, 47503 }, -- Legplates of the Argent Armistice
				{ 20, 47504 }, -- Barkhide Treads
				{ 21, 47201 }, -- Boots of Heartfelt Repentance
				{ 22, 47199 }, -- Greaves of the Grand Paladin
				{ 23, 47200 }, -- Signet of Purity
				{ 24, 47213 }, -- Abyssal Rune
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 26, "ac3803" },
			},
		},
		{ --TrialoftheChampionConfessorPaletress
			EncounterJournalID = 636,
			[NORMAL_DIFF] = {
				{ 1,  47522 }, -- Marrowstrike
				{ 2,  47500 }, -- Peacekeeper Blade
				{ 3,  47217 }, -- Gaze of the Somber Keeper
				{ 4,  47497 }, -- Helm of the Crestfallen Challenger
				{ 5,  47494 }, -- Ancient Pendant of Arathor
				{ 6,  47219 }, -- Brilliant Hailstone Amulet
				{ 7,  47245 }, -- Pauldrons of Concealed Loathing
				{ 8,  47514 }, -- Regal Aurous Shoulderplates
				{ 9,  47176 }, -- Breastplate of the Imperial Joust
				{ 10, 47178 }, -- Carapace of Grim Visions
				{ 11, 47496 }, -- Armbands of the Wary Lookout
				{ 12, 47211 }, -- Wristguards of Ceaseless Regret
				{ 13, 47498 }, -- Gloves of Dismal Fortune
				{ 14, 47177 }, -- Gloves of the Argent Fanatic
				{ 15, 47212 }, -- Mercy's Hold
				{ 16, 47181 }, -- Belt of the Churning Blaze
				{ 17, 47218 }, -- The Confessor's Binding
				{ 18, 47510 }, -- Trueheart Girdle
				{ 19, 47185 }, -- Leggings of the Haggard Apprentice
				{ 20, 47495 }, -- Legplates of Relentless Onslaught
				{ 21, 47511 }, -- Plated Greaves of Providence
				{ 22, 47512 }, -- Sinner's Confession
				{ 23, 47213 }, -- Abyssal Rune
				{ 24, 47214 }, -- Banner of Victory
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 26, "ac3802" },
			},
		},
		{ --TrialoftheChampionBlackKnight
			EncounterJournalID = 637,
			[NORMAL_DIFF] = {
				{ 1,  49682 }, -- Black Knight's Rondel
				{ 2,  47569 }, -- Spectral Kris
				{ 3,  47568 }, -- True-Aim Long Rifle
				{ 4,  47564 }, -- Gaze of the Unknown
				{ 5,  47220 }, -- Helm of the Violent Fray
				{ 6,  47529 }, -- Mask of Distant Memory
				{ 7,  47562 }, -- Symbol of Redemption
				{ 8,  47566 }, -- The Warlord's Depravity
				{ 9,  47226 }, -- Mantle of Inconsolable Fear
				{ 10, 47221 }, -- Shoulderpads of the Infamous Knave
				{ 11, 47232 }, -- Drape of the Undefeated
				{ 12, 47527 }, -- Embrace of Madness
				{ 13, 47565 }, -- Vambraces of Unholy Command
				{ 14, 47567 }, -- Gauntlets of Revelation
				{ 15, 47561 }, -- Gloves of the Dark Exile
				{ 16, 47230 }, -- Handwraps of Surrendered Hope
				{ 17, 47231 }, -- Belt of Merciless Cruelty
				{ 18, 47229 }, -- Girdle of Arrogant Downfall
				{ 19, 47563 }, -- Girdle of the Dauntless Conqueror
				{ 20, 47227 }, -- Girdle of the Pallid Knight
				{ 21, 47228 }, -- Leggings of the Bloodless Knight
				{ 22, 47560 }, -- Boots of the Crackling Flame
				{ 23, 47222 }, -- Uruka's Band of Zeal
				{ 24, 47215 }, -- Tears of the Vanquished
				{ 25, 47216 }, -- The Black Heart
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 26, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 28, "ac3804" },
			},
		},
	}
}

data["UtgardeKeep"] = {
	EncounterJournalID = 285,
	MapID = 133,
	AtlasMapID = "UtgardeKeep",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --UtgardeKeepKeleseth
			EncounterJournalID = 638,
			[NORMAL_DIFF] = {
				{ 1, 37179 }, -- Infantry Assault Blade
				{ 2, 35570 }, -- Keleseth's Blade of Evocation
				{ 3, 37177 }, -- Wand of the San'layn
				{ 4, 37180 }, -- Battlemap Hide Helm
				{ 5, 35572 }, -- Reinforced Velvet Helm
				{ 6, 35571 }, -- Dragon Stabler's Gauntlets
				{ 7, 37178 }, -- Strategist's Belt
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac1919" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188440 }, -- Infantry Assault Blade
				{ 2, 188429 }, -- Keleseth's Blade of Evocation
				{ 3, 188438 }, -- Wand of the San'layn
				{ 4, 188441 }, -- Battlemap Hide Helm
				{ 5, 188431 }, -- Reinforced Velvet Helm
				{ 6, 188430 }, -- Dragon Stabler's Gauntlets
				{ 7, 188439 }, -- Strategist's Belt
			},
		},
		{ --UtgardeKeepSkarvald
			EncounterJournalID = 639,
			[NORMAL_DIFF] = {
				{ 1, 35573 }, -- Arm Blade of Augelmir
				{ 2, 37181 }, -- Dagger of Betrayal
				{ 3, 157555 }, -- Constructor's Worklight
				{ 4, 37182 }, -- Helmet of the Constructor
				{ 5, 35574 }, -- Chestplate of the Northern Lights
				{ 6, 37184 }, -- Dalronn's Jerkin
				{ 7, 35575 }, -- Skarvald's Dragonskin Habergeon
				{ 8, 37183 }, -- Bindings of the Tunneler
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1, 188432 }, -- Arm Blade of Augelmir
				{ 2, 188442 }, -- Dagger of Betrayal
				{ 3, 188454 }, -- Constructor's Worklight
				{ 4, 188443 }, -- Helmet of the Constructor
				{ 5, 188433 }, -- Chestplate of the Northern Lights
				{ 6, 188445 }, -- Dalronn's Jerkin
				{ 7, 188434 }, -- Skarvald's Dragonskin Habergeon
				{ 8, 188444 }, -- Bindings of the Tunneler
			},
		},
		{ --UtgardeKeepIngvar
			EncounterJournalID = 640,
			[NORMAL_DIFF] = {
				{ 1,  37190 },                         -- Enraged Feral Staff
				{ 2,  35576 },                         -- Ingvar's Monolithic Cleaver
				{ 3,  37191 },                         -- Drake-Mounted Crossbow
				{ 4,  37188 },                         -- Plunderer's Helmet
				{ 5,  35578 },                         -- Overlaid Chain Spaulders
				{ 6,  37194 },                         -- Sharp-Barbed Leather Belt
				{ 7,  37189 },                         -- Breeches of the Caller
				{ 8,  35577 },                         -- Holistic Patchwork Breeches
				{ 9,  37193 },                         -- Staggering Legplates
				{ 10, 37192 },                         -- Annhylde's Ring
				{ 11, 37186 },                         -- Unsmashable Heavy Band
				{ 14, 33330, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Ingvar's Head
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 12, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 16, 41793,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Fierce Monarch Topaz
				{ 18, "ac1658" },
			},
			[TIMEWALKING_DUNGEON_DIFF] = {
				{ 1,  188449 }, -- Enraged Feral Staff
				{ 2,  188435 }, -- Ingvar's Monolithic Cleaver
				{ 3,  188450 }, -- Drake-Mounted Crossbow
				{ 4,  188447 }, -- Plunderer's Helmet
				{ 5,  188437 }, -- Overlaid Chain Spaulders
				{ 6,  188453 }, -- Sharp-Barbed Leather Belt
				{ 7,  188448 }, -- Breeches of the Caller
				{ 8,  188436 }, -- Holistic Patchwork Breeches
				{ 9,  188452 }, -- Staggering Legplates
				{ 10, 188451 }, -- Annhylde's Ring
				{ 11, 188446 }, -- Unsmashable Heavy Band
			},
		},
		{ --UtgardeKeepTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35580 }, -- Skein Woven Mantle
				{ 2, 35579 }, -- Vrykul Shackles
			},
			[HEROIC_DIFF] = {
				{ 1, 37197 }, -- Tattered Castle Drape
				{ 2, 37196 }, -- Runecaster's Mantle
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["UtgardePinnacle"] = {
	EncounterJournalID = 286,
	MapID = 136,
	AtlasMapID = "UtgardePinnacle",
	ContentType = DUNGEON_CONTENT,
	items = {
		{ --UPSorrowgrave
			EncounterJournalID = 641,
			[NORMAL_DIFF] = {
				{ 1, 37037 }, -- Ritualistic Athame
				{ 2, 37038 }, -- Brazier Igniter
				{ 3, 37368 }, -- Silent Spectator Shoulderpads
				{ 4, 37370 }, -- Cuffs of the Trussed Hall
				{ 5, 37040 }, -- Svala's Bloodied Shackles
				{ 6, 37043 }, -- Tear-Linked Gauntlets
				{ 7, 37369 }, -- Sorrowgrave's Breeches
				{ 8, 37367 }, -- Echoing Stompers
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, "ac2043" },
			},
		},
		{ --UPPalehoof
			EncounterJournalID = 642,
			[NORMAL_DIFF] = {
				{ 1, 37050 }, -- Trophy Gatherer
				{ 2, 37051 }, -- Seal of Valgarde
				{ 3, 37376 }, -- Ferocious Pauldrons of the Rhino
				{ 4, 37373 }, -- Massive Spaulders of the Jormungar
				{ 5, 37048 }, -- Shroud of Resurrection
				{ 6, 37052 }, -- Reanimated Armor
				{ 7, 37374 }, -- Ravenous Leggings of the Furbolg
				{ 8, 37371 }, -- Ring of the Frenzied Wolvar
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
			},
		},
		{ --UPSkadi
			EncounterJournalID = 643,
			[NORMAL_DIFF] = {
				{ 1, 37384 }, -- Staff of Wayward Principles
				{ 2, 37377 }, -- Netherbreath Spellblade
				{ 3, 37053 }, -- Amulet of Deflected Blows
				{ 4, 37055 }, -- Silken Amice of the Ymirjar
				{ 5, 37057 }, -- Drake Rider's Tunic
				{ 6, 37379 }, -- Skadi's Iron Belt
				{ 7, 37389 }, -- Crenelation Leggings
				{ 8, 37056 }, -- Harpooner's Striders
				{ 9, 157560 }, -- Skadi's Scaled Boots
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 16, 44151,   "mount" }, -- Reins of the Blue Proto-Drake
				{ 18, "ac1873" },
				{ 19, "ac2156" },
			},
		},
		{ --UPYmiron
			EncounterJournalID = 644,
			[NORMAL_DIFF] = {
				{ 1,  37060 },                         -- Jeweled Coronation Sword
				{ 2,  37401 },                         -- Red Sword of Courage
				{ 3,  37065 },                         -- Ymiron's Blade
				{ 4,  37061 },                         -- Tor's Crest
				{ 5,  37062 },                         -- Crown of Forgotten Kings
				{ 6,  37397 },                         -- Gold Amulet of Kings
				{ 7,  37067 },                         -- Ceremonial Pyre Mantle
				{ 8,  37398 },                         -- Mantle of Discarded Ways
				{ 9,  37395 },                         -- Ornamented Plate Regalia
				{ 10, 37409 },                         -- Gilt-Edged Leather Gauntlets
				{ 11, 37408 },                         -- Girdle of Bane
				{ 12, 37407 },                         -- Sovereign's Belt
				{ 13, 37066 },                         -- Ancient Royal Legguards
				{ 14, 37058 },                         -- Signet of Ranulf
				{ 15, 37390 },                         -- Meteorite Whetstone
				{ 16, 37064 },                         -- Vestige of Haldor
				{ 19, 41797, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Design: Austere Earthsiege Diamond
			},
			[HEROIC_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 17, 43102,   [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Frozen Orb
				{ 21, "ac1658" },
				{ 22, "ac1790" },
				{ 23, "ac2157" },
			},
		},
		{ --UPTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 37070 }, -- Tundra Wolf Boots
				{ 2, 37069 }, -- Dragonflayer Seer's Bindings
				{ 3, 37068 }, -- Berserker's Sabatons
			},
			[HEROIC_DIFF] = {
				{ 1, 37587 }, -- Ymirjar Physician's Robe
				{ 2, 37590 }, -- Bands of Fading Light
			},
		},
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["IcecrownCitadel"] = {
	EncounterJournalID = 758,
	MapID = 186,
	AtlasMapID = "IcecrownCitadelA",
	ContentType = RAID_CONTENT,
	items = {
		{ --ICC LordMarrowgar
			EncounterJournalID = 1624,
			[NORMAL_RAID_DIFF] = {
				{ 1,  50764 },  -- Shawl of Nerubian Silk
				{ 2,  50773 },  -- Cord of the Patronizing Practitioner
				{ 3,  50774 },  -- Coldwraith Bracers
				{ 4,  50762 },  -- Linked Scourge Vertebrae
				{ 5,  50775 },  -- Corrupted Silverplate Leggings
				{ 6,  50772 },  -- Ancient Skeletal Boots
				{ 8,  50763 },  -- Marrowgar's Scratching Choker
				{ 9,  50339 },  -- Sliver of Pure Ice
				{ 11, 142094,  "pet1963" }, -- Fragment of Frozen Bone -> Boneshard, Added in patch 7.1.0.22731
				{ 16, 50771 },  -- Frost Needle
				{ 17, 50761 },  -- Citadel Enforcer's Claymore
				{ 18, 50759 },  -- Bone Warden's Splitter
				{ 19, 50760 },  -- Bonebreaker Scepter
				{ 21, "ac4534" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51933 },  -- Shawl of Nerubian Silk
				{ 2,  51930 },  -- Cord of the Patronizing Practitioner
				{ 3,  51929 },  -- Coldwraith Bracers
				{ 4,  51935 },  -- Linked Scourge Vertebrae
				{ 5,  51928 },  -- Corrupted Silverplate Leggings
				{ 6,  51931 },  -- Ancient Skeletal Boots
				{ 8,  51934 },  -- Marrowgar's Scratching Choker
				{ 9,  50346 },  -- Sliver of Pure Ice
				{ 11, 142094,  "pet1963" }, -- Fragment of Frozen Bone -> Boneshard, Added in patch 7.1.0.22731
				{ 16, 51932 },  -- Frost Needle
				{ 17, 51936 },  -- Citadel Enforcer's Claymore
				{ 18, 51938 },  -- Bone Warden's Splitter
				{ 19, 51937 },  -- Bonebreaker Scepter
				{ 21, 49908 },  -- Primordial Saronite
				{ 23, "ac4534" },
			},
			[P25_DIFF] = {
				{ 1,  49978 },  -- Crushing Coldwraith Belt
				{ 2,  49979 },  -- Handguards of Winter's Respite
				{ 3,  49950 },  -- Frostbitten Fur Boots
				{ 4,  49952 },  -- Snowserpent Mail Helm
				{ 5,  49980 },  -- Rusted Bonespike Pauldrons
				{ 6,  49951 },  -- Gendarme's Cuirass
				{ 7,  49960 },  -- Bracers of Dark Reckoning
				{ 8,  49964 },  -- Legguards of Lost Hope
				{ 10, 49975 },  -- Bone Sentinel's Amulet
				{ 11, 49949 },  -- Band of the Bone Colossus
				{ 12, 49977 },  -- Loop of the Endless Labyrinth
				{ 13, 49967 },  -- Marrowgar's Frigid Eye
				{ 15, 142094,  "pet1963" }, -- Fragment of Frozen Bone -> Boneshard, Added in patch 7.1.0.22731
				{ 16, 49968 },  -- Frozen Bonespike
				{ 17, 50415 },  -- Bryntroll, the Bone Arbiter
				{ 18, 49976 },  -- Bulwark of Smouldering Steel
				{ 20, 50274 },  -- Shadowfrost Shard
				{ 21, 49908 },  -- Primordial Saronite
				{ 23, "ac4610" },
			},
			[P25H_DIFF] = {
				{ 1,  50613 },  -- Crushing Coldwraith Belt
				{ 2,  50615 },  -- Handguards of Winter's Respite
				{ 3,  50607 },  -- Frostbitten Fur Boots
				{ 4,  50605 },  -- Snowserpent Mail Helm
				{ 5,  50617 },  -- Rusted Bonespike Pauldrons
				{ 6,  50606 },  -- Gendarme's Cuirass
				{ 7,  50611 },  -- Bracers of Dark Reckoning
				{ 8,  50612 },  -- Legguards of Lost Hope
				{ 10, 50609 },  -- Bone Sentinel's Amulet
				{ 11, 50604 },  -- Band of the Bone Colossus
				{ 12, 50614 },  -- Loop of the Endless Labyrinth
				{ 13, 50610 },  -- Marrowgar's Frigid Eye
				{ 15, 142094,  "pet1963" }, -- Fragment of Frozen Bone -> Boneshard, Added in patch 7.1.0.22731
				{ 16, 50608 },  -- Frozen Bonespike
				{ 17, 50709 },  -- Bryntroll, the Bone Arbiter
				{ 18, 50616 },  -- Bulwark of Smouldering Steel
				{ 20, 50274 },  -- Shadowfrost Shard
				{ 21, 49908 },  -- Primordial Saronite
				{ 23, "ac4610" },
			},
		},
		{ --ICC LadyDeathwhisper
			EncounterJournalID = 1625,
			[NORMAL_RAID_DIFF] = {
				{ 1,  50785 }, -- Bracers of Dark Blessings
				{ 2,  50782 }, -- Sister's Handshrouds
				{ 3,  50780 }, -- Chestguard of the Frigid Noose
				{ 4,  50778 }, -- Soulthief's Braided Belt
				{ 5,  50783 }, -- Boots of the Frozen Seed
				{ 6,  50777 }, -- Handgrips of Frost and Sleet
				{ 7,  50784 }, -- Deathspeaker Disciple's Belt
				{ 8,  50779 }, -- Deathspeaker Zealot's Helm
				{ 9,  50786 }, -- Ghoul Commander's Cuirass
				{ 16, 50342 }, -- Whispering Fanged Skull
				{ 18, 50776 }, -- Njorndar Bone Bow
				{ 19, 50781 }, -- Scourgelord's Baton
				{ 21, "ac4535" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51918 }, -- Bracers of Dark Blessings
				{ 2,  51921 }, -- Sister's Handshrouds
				{ 3,  51923 }, -- Chestguard of the Frigid Noose
				{ 4,  51925 }, -- Soulthief's Braided Belt
				{ 5,  51920 }, -- Boots of the Frozen Seed
				{ 6,  51926 }, -- Handgrips of Frost and Sleet
				{ 7,  51919 }, -- Deathspeaker Disciple's Belt
				{ 8,  51924 }, -- Deathspeaker Zealot's Helm
				{ 9,  51917 }, -- Ghoul Commander's Cuirass
				{ 16, 50343 }, -- Whispering Fanged Skull
				{ 18, 51927 }, -- Njorndar Bone Bow
				{ 19, 51922 }, -- Scourgelord's Baton
				{ 21, 49908 }, -- Primordial Saronite
				{ 23, "ac4535" },
			},
			[P25_DIFF] = {
				{ 1,  49991 }, -- Shoulders of Mercy Killing
				{ 2,  49994 }, -- The Lady's Brittle Bracers
				{ 3,  49987 }, -- Cultist's Bloodsoaked Spaulders
				{ 4,  49996 }, -- Deathwhisper Chestpiece
				{ 5,  49988 }, -- Leggings of Northern Lights
				{ 6,  49993 }, -- Necrophotic Greaves
				{ 7,  49986 }, -- Broken Ram Skull Helm
				{ 8,  49995 }, -- Fallen Lord's Handguards
				{ 9,  49983 }, -- Blood-Soaked Saronite Stompers
				{ 11, 49989 }, -- Ahn'kahar Onyx Neckguard
				{ 12, 49985 }, -- Juggernaut Band
				{ 13, 49990 }, -- Ring of Maddening Whispers
				{ 16, 49982 }, -- Heartpierce
				{ 17, 49992 }, -- Nibelung
				{ 18, 50034 }, -- Zod's Repeating Longbow
				{ 20, 50274 }, -- Shadowfrost Shard
				{ 21, 49908 }, -- Primordial Saronite
				{ 23, "ac4611" },
			},
			[P25H_DIFF] = {
				{ 1,  50643 }, -- Shoulders of Mercy Killing
				{ 2,  50651 }, -- The Lady's Brittle Bracers
				{ 3,  50646 }, -- Cultist's Bloodsoaked Spaulders
				{ 4,  50649 }, -- Deathwhisper Raiment
				{ 5,  50645 }, -- Leggings of Northern Lights
				{ 6,  50652 }, -- Necrophotic Greaves
				{ 7,  50640 }, -- Broken Ram Skull Helm
				{ 8,  50650 }, -- Fallen Lord's Handguards
				{ 9,  50639 }, -- Blood-Soaked Saronite Stompers
				{ 11, 50647 }, -- Ahn'kahar Onyx Neckguard
				{ 12, 50642 }, -- Juggernaut Band
				{ 13, 50644 }, -- Ring of Maddening Whispers
				{ 16, 50641 }, -- Heartpierce
				{ 17, 50648 }, -- Nibelung
				{ 18, 50638 }, -- Zod's Repeating Longbow
				{ 20, 50274 }, -- Shadowfrost Shard
				{ 21, 49908 }, -- Primordial Saronite
				{ 23, "ac4611" },
			},
		},
		{ --ICC GunshipBattle
			EncounterJournalID = 1626,
			[NORMAL_RAID_DIFF] = {
				{ 1,  50791 }, -- Saronite Gargoyle Cloak
				{ 2,  50795 }, -- Cord of Dark Suffering
				{ 3,  50797 }, -- Ice-Reinforced Vrykul Helm
				{ 4,  50792 }, -- Pauldrons of Lost Hope
				{ 5,  50789 }, -- Icecrown Rampart Bracers
				{ 6,  50796 }, -- Bracers of Pale Illumination
				{ 7,  50788 }, -- Bone Drake's Enameled Boots
				{ 9,  50790 }, -- Abomination's Bloody Ring
				{ 10, 50340 }, -- Muradin's Spyglass
				{ 16, 50793 }, -- Midnight Sun
				{ 17, 50787 }, -- Frost Giant's Cleaver
				{ 18, 50794 }, -- Neverending Winter
				{ 20, "ac4536" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51912 }, -- Saronite Gargoyle Cloak
				{ 2,  51908 }, -- Cord of Dark Suffering
				{ 3,  51906 }, -- Ice-Reinforced Vrykul Helm
				{ 4,  51911 }, -- Pauldrons of Lost Hope
				{ 5,  51914 }, -- Icecrown Rampart Bracers
				{ 6,  51907 }, -- Bracers of Pale Illumination
				{ 7,  51915 }, -- Bone Drake's Enameled Boots
				{ 9,  51913 }, -- Abomination's Bloody Ring
				{ 10, 50345 }, -- Muradin's Spyglass
				{ 16, 51910 }, -- Midnight Sun
				{ 17, 51916 }, -- Frost Giant's Cleaver
				{ 18, 51909 }, -- Neverending Winter
				{ 20, 49908 }, -- Primordial Saronite
				{ 22, "ac4536" },
			},
			[P25_DIFF] = {
				{ 1,  49998 }, -- Shadowvault Slayer's Cloak
				{ 2,  50006 }, -- Corp'rethar Ceremonial Crown
				{ 3,  50011 }, -- Gunship Captain's Mittens
				{ 4,  50001 }, -- Ikfirus' Sack of Wonder
				{ 5,  50009 }, -- Boots of Unnatural Growth
				{ 6,  50000 }, -- Scourge Hunter's Vambraces
				{ 7,  50003 }, -- Boneguard Commander's Pauldrons
				{ 8,  50002 }, -- Polar Bear Claw Bracers
				{ 9,  50010 }, -- Waistband of Righteous Fury
				{ 11, 50274 }, -- Shadowfrost Shard
				{ 12, 49908 }, -- Primordial Saronite
				{ 16, 50005 }, -- Amulet of the Silent Eulogy
				{ 17, 50008 }, -- Ring of Rapid Ascent
				{ 18, 49999 }, -- Skeleton Lord's Circle
				{ 19, 50359 }, -- Althor's Abacus
				{ 20, 50352 }, -- Corpse Tongue Coin
				{ 22, 50411 }, -- Scourgeborne Waraxe
				{ 24, "ac4612" },
			},
			[P25H_DIFF] = {
				{ 1,  50653 }, -- Shadowvault Slayer's Cloak
				{ 2,  50661 }, -- Corp'rethar Ceremonial Crown
				{ 3,  50663 }, -- Gunship Captain's Mittens
				{ 4,  50656 }, -- Ikfirus' Sack of Wonder
				{ 5,  50665 }, -- Boots of Unnatural Growth
				{ 6,  50655 }, -- Scourge Hunter's Vambraces
				{ 7,  50660 }, -- Boneguard Commander's Pauldrons
				{ 8,  50659 }, -- Polar Bear Claw Bracers
				{ 9,  50667 }, -- Waistband of Righteous Fury
				{ 11, 50274 }, -- Shadowfrost Shard
				{ 12, 49908 }, -- Primordial Saronite
				{ 16, 50658 }, -- Amulet of the Silent Eulogy
				{ 17, 50664 }, -- Ring of Rapid Ascent
				{ 18, 50657 }, -- Skeleton Lord's Circle
				{ 19, 50366 }, -- Althor's Abacus
				{ 20, 50349 }, -- Corpse Tongue Coin
				{ 22, 50654 }, -- Scourgeborne Waraxe
				{ 24, "ac4612" },
			},
		},
		{ --ICC Saurfang
			EncounterJournalID = 1628,
			[NORMAL_RAID_DIFF] = {
				{ 1,  50807 },  -- Thaumaturge's Crackling Cowl
				{ 2,  50804 },  -- Icecrown Spire Sandals
				{ 3,  50799 },  -- Scourge Stranglers
				{ 4,  50806 },  -- Leggings of Unrelenting Blood
				{ 5,  50800 },  -- Hauberk of a Thousand Cuts
				{ 6,  50801 },  -- Blade-Scored Carapace
				{ 7,  50802 },  -- Gargoyle Spit Bracers
				{ 8,  50808 },  -- Deathforged Legplates
				{ 10, 142095,  "pet1964" }, -- Remains of a Blood Beast -> Blood Boil, Added in patch 7.1.0.22731
				{ 16, 50809 },  -- Soulcleave Pendant
				{ 17, 50803 },  -- Saurfang's Cold-Forged Band
				{ 19, 50798 },  -- Ramaladni's Blade of Culling
				{ 20, 50805 },  -- Mag'hari Chieftain's Staff
				{ 22, "ac4537" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51896 },  -- Thaumaturge's Crackling Cowl
				{ 2,  51899 },  -- Icecrown Spire Sandals
				{ 3,  51904 },  -- Scourge Stranglers
				{ 4,  51897 },  -- Leggings of Unrelenting Blood
				{ 5,  51903 },  -- Hauberk of a Thousand Cuts
				{ 6,  51902 },  -- Blade-Scored Carapace
				{ 7,  51901 },  -- Gargoyle Spit Bracers
				{ 8,  51895 },  -- Deathforged Legplates
				{ 10, 51894 },  -- Soulcleave Pendant
				{ 11, 51900 },  -- Saurfang's Cold-Forged Band
				{ 13, 142095,  "pet1964" }, -- Remains of a Blood Beast -> Blood Boil, Added in patch 7.1.0.22731
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, 51905 },  -- Ramaladni's Blade of Culling
				{ 21, 51898 },  -- Mag'hari Chieftain's Staff
				{ 23, 49908 },  -- Primordial Saronite
				{ 25, "ac4537" },
			},
			[P25_DIFF] = {
				{ 1,  50014 },  -- Greatcloak of the Turned Champion
				{ 2,  50333 },  -- Toskk's Maximized Wristguards
				{ 3,  50015 },  -- Belt of the Blood Nova
				{ 4,  50362 },  -- Deathbringer's Will
				{ 5,  50412 },  -- Bloodvenom Blade
				{ 7,  50274 },  -- Shadowfrost Shard
				{ 8,  49908 },  -- Primordial Saronite
				{ 10, 142095,  "pet1964" }, -- Remains of a Blood Beast -> Blood Boil, Added in patch 7.1.0.22731
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, "ac4613" },
			},
			[P25H_DIFF] = {
				{ 1,  50668 },  -- Greatcloak of the Turned Champion
				{ 2,  50670 },  -- Toskk's Maximized Wristguards
				{ 3,  50671 },  -- Belt of the Blood Nova
				{ 4,  50363 },  -- Deathbringer's Will
				{ 5,  50672 },  -- Bloodvenom Blade
				{ 7,  50274 },  -- Shadowfrost Shard
				{ 8,  49908 },  -- Primordial Saronite
				{ 10, 142095,  "pet1964" }, -- Remains of a Blood Beast -> Blood Boil, Added in patch 7.1.0.22731
				{ 16, 52030 },  -- Conqueror's Mark of Sanctification
				{ 17, 52029 },  -- Protector's Mark of Sanctification
				{ 18, 52028 },  -- Vanquisher's Mark of Sanctification
				{ 20, 52027 },  -- Conqueror's Mark of Sanctification
				{ 21, 52026 },  -- Protector's Mark of Sanctification
				{ 22, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 24, "ac4613" },
			},
		},
		{ --ICC Festergut
			EncounterJournalID = 1629,
			[NORMAL_RAID_DIFF] = {
				{ 1,  50859 }, -- Cloak of Many Skins
				{ 2,  50988 }, -- Bloodstained Surgeon's Shoulderguards
				{ 3,  50990 }, -- Kilt of Untreated Wounds
				{ 4,  50985 }, -- Wrists of Septic Shock
				{ 5,  50858 }, -- Plague-Soaked Leather Leggings
				{ 6,  50812 }, -- Taldron's Long Neglected Boots
				{ 7,  50967 }, -- Festergut's Gaseous Gloves
				{ 8,  50811 }, -- Festering Fingerguards
				{ 16, 50852 }, -- Precious' Putrid Collar
				{ 17, 50986 }, -- Signet of Putrefaction
				{ 19, 50810 }, -- Gutbuster
				{ 20, 50966 }, -- Abracadaver
				{ 22, "ac4577" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51888 }, -- Cloak of Many Skins
				{ 2,  51883 }, -- Bloodstained Surgeon's Shoulderguards
				{ 3,  51882 }, -- Kilt of Untreated Wounds
				{ 4,  51885 }, -- Wrists of Septic Shock
				{ 5,  51889 }, -- Plague-Soaked Leather Leggings
				{ 6,  51891 }, -- Taldron's Long Neglected Boots
				{ 7,  51886 }, -- Festergut's Gaseous Gloves
				{ 8,  51892 }, -- Festering Fingerguards
				{ 16, 51890 }, -- Precious' Putrid Collar
				{ 17, 51884 }, -- Signet of Putrefaction
				{ 19, 51893 }, -- Gutbuster
				{ 20, 51887 }, -- Abracadaver
				{ 22, 49908 }, -- Primordial Saronite
				{ 24, "ac4577" },
			},
			[P25_DIFF] = {
				{ 1,  50063 }, -- Lingering Illness
				{ 2,  50056 }, -- Plaguebringer's Stained Pants
				{ 3,  50062 }, -- Plague Scientist's Boots
				{ 4,  50042 }, -- Gangrenous Leggings
				{ 5,  50041 }, -- Leather of Stitched Scourge Parts
				{ 6,  50059 }, -- Horrific Flesh Epaulets
				{ 7,  50038 }, -- Carapace of Forgotten Kings
				{ 8,  50064 }, -- Unclean Surgical Gloves
				{ 9,  50413 }, -- Nerub'ar Stalker's Cord
				{ 10, 50060 }, -- Faceplate of the Forgotten
				{ 11, 50037 }, -- Fleshrending Gauntlets
				{ 12, 50036 }, -- Belt of Broken Bones
				{ 16, 50061 }, -- Holiday's Grace
				{ 17, 50414 }, -- Might of Blight
				{ 19, 50035 }, -- Black Bruise
				{ 20, 50040 }, -- Distant Land
				{ 22, 50226 }, -- Festergut's Acidic Blood
				{ 24, 50274 }, -- Shadowfrost Shard
				{ 25, 49908 }, -- Primordial Saronite
				{ 27, "ac4615" },
			},
			[P25H_DIFF] = {
				{ 1,  50702 }, -- Lingering Illness
				{ 2,  50694 }, -- Plaguebringer's Stained Pants
				{ 3,  50699 }, -- Plague Scientist's Boots
				{ 4,  50697 }, -- Gangrenous Leggings
				{ 5,  50696 }, -- Leather of Stitched Scourge Parts
				{ 6,  50698 }, -- Horrific Flesh Epaulets
				{ 7,  50689 }, -- Carapace of Forgotten Kings
				{ 8,  50703 }, -- Unclean Surgical Gloves
				{ 9,  50688 }, -- Nerub'ar Stalker's Cord
				{ 10, 50701 }, -- Faceplate of the Forgotten
				{ 11, 50690 }, -- Fleshrending Gauntlets
				{ 12, 50691 }, -- Belt of Broken Bones
				{ 16, 50700 }, -- Holiday's Grace
				{ 17, 50693 }, -- Might of Blight
				{ 19, 50692 }, -- Black Bruise
				{ 20, 50695 }, -- Distant Land
				{ 22, 50226 }, -- Festergut's Acidic Blood
				{ 24, 50274 }, -- Shadowfrost Shard
				{ 25, 49908 }, -- Primordial Saronite
				{ 27, "ac4615" },
			},
		},
		{ --ICC Rotface
			EncounterJournalID = 1630,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51007 }, -- Ether-Soaked Bracers
				{ 2,  51005 }, -- Gloves of Broken Fingers
				{ 3,  51009 }, -- Chestguard of the Failed Experiment
				{ 4,  51002 }, -- Taldron's Short-Sighted Helm
				{ 5,  51006 }, -- Shuffling Shoes
				{ 6,  51000 }, -- Flesh-Shaper's Gurney Strap
				{ 8,  51008 }, -- Choker of Filthy Diamonds
				{ 9,  51001 }, -- Rotface's Rupturing Ring
				{ 16, 51003 }, -- Abomination Knuckles
				{ 17, 51004 }, -- Lockjaw
				{ 18, 50998 }, -- Shaft of Glacial Ice
				{ 20, "ac4538" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51872 }, -- Ether-Soaked Bracers
				{ 2,  51874 }, -- Gloves of Broken Fingers
				{ 3,  51870 }, -- Chestguard of the Failed Experiment
				{ 4,  51877 }, -- Taldron's Short-Sighted Helm
				{ 5,  51873 }, -- Shuffling Shoes
				{ 6,  51879 }, -- Flesh-Shaper's Gurney Strap
				{ 8,  51871 }, -- Choker of Filthy Diamonds
				{ 9,  51878 }, -- Rotface's Rupturing Ring
				{ 16, 51876 }, -- Abomination Knuckles
				{ 17, 51875 }, -- Lockjaw
				{ 18, 51881 }, -- Shaft of Glacial Ice
				{ 20, 49908 }, -- Primordial Saronite
				{ 22, "ac4538" },
			},
			[P25_DIFF] = {
				{ 1,  50019 }, -- Winding Sheet
				{ 2,  50032 }, -- Death Surgeon's Sleeves
				{ 3,  50026 }, -- Helm of the Elder Moon
				{ 4,  50021 }, -- Aldriana's Gloves of Secrecy
				{ 5,  50022 }, -- Dual-Bladed Pauldrons
				{ 6,  50030 }, -- Bloodsunder's Bracers
				{ 7,  50020 }, -- Raging Behemoth's Shoulderplates
				{ 8,  50024 }, -- Blightborne Warplate
				{ 9,  50027 }, -- Rot-Resistant Breastplate
				{ 11, 50023 }, -- Bile-Encrusted Medallion
				{ 12, 50025 }, -- Seal of Many Mouths
				{ 13, 50353 }, -- Dislodged Foreign Object
				{ 16, 50028 }, -- Trauma
				{ 17, 50016 }, -- Rib Spreader
				{ 18, 50033 }, -- Corpse-Impaling Spike
				{ 20, 50231 }, -- Rotface's Acidic Blood
				{ 22, 50274 }, -- Shadowfrost Shard
				{ 23, 49908 }, -- Primordial Saronite
				{ 25, "ac4614" },
			},
			[P25H_DIFF] = {
				{ 1,  50677 }, -- Winding Sheet
				{ 2,  50686 }, -- Death Surgeon's Sleeves
				{ 3,  50679 }, -- Helm of the Elder Moon
				{ 4,  50675 }, -- Aldriana's Gloves of Secrecy
				{ 5,  50673 }, -- Dual-Bladed Pauldrons
				{ 6,  50687 }, -- Bloodsunder's Bracers
				{ 7,  50674 }, -- Raging Behemoth's Shoulderplates
				{ 8,  50681 }, -- Blightborne Warplate
				{ 9,  50680 }, -- Rot-Resistant Breastplate
				{ 11, 50682 }, -- Bile-Encrusted Medallion
				{ 12, 50678 }, -- Seal of Many Mouths
				{ 13, 50348 }, -- Dislodged Foreign Object
				{ 16, 50685 }, -- Trauma
				{ 17, 50676 }, -- Rib Spreader
				{ 18, 50684 }, -- Corpse-Impaling Spike
				{ 20, 50231 }, -- Rotface's Acidic Blood
				{ 22, 50274 }, -- Shadowfrost Shard
				{ 23, 49908 }, -- Primordial Saronite
				{ 25, "ac4614" },
			},
		},
		{ --ICC Putricide
			EncounterJournalID = 1631,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51020 },  -- Shoulders of Ruinous Senility
				{ 2,  51017 },  -- Cauterized Cord
				{ 3,  51013 },  -- Discarded Bag of Entrails
				{ 4,  51015 },  -- Shoulderpads of the Morbid Ritual
				{ 5,  51019 },  -- Rippling Flesh Kilt
				{ 6,  51014 },  -- Scalpel-Sharpening Shoulderguards
				{ 7,  51018 },  -- Chestplate of Septic Stitches
				{ 9,  142096,  "pet1965" }, -- Putricide's Alchemy Supplies -> Blightbreath
				{ 16, 51012 },  -- Infected Choker
				{ 17, 51016 },  -- Pendant of Split Veins
				{ 18, 50341 },  -- Unidentifiable Organ
				{ 20, 51011 },  -- Flesh-Carving Scalpel
				{ 21, 51010 },  -- The Facelifter
				{ 23, "ac4578" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51859 },  -- Shoulders of Ruinous Senility
				{ 2,  51862 },  -- Cauterized Cord
				{ 3,  51866 },  -- Discarded Bag of Entrails
				{ 4,  51864 },  -- Shoulderpads of the Morbid Ritual
				{ 5,  51860 },  -- Rippling Flesh Kilt
				{ 6,  51865 },  -- Scalpel-Sharpening Shoulderguards
				{ 7,  51861 },  -- Chestplate of Septic Stitches
				{ 9,  51867 },  -- Infected Choker
				{ 10, 51863 },  -- Pendant of Split Veins
				{ 11, 50344 },  -- Unidentifiable Organ
				{ 13, 142096,  "pet1965" }, -- Putricide's Alchemy Supplies -> Blightbreath
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, 51868 },  -- Flesh-Carving Scalpel
				{ 21, 51869 },  -- The Facelifter
				{ 23, 49908 },  -- Primordial Saronite
				{ 25, "ac4578" },
			},
			[P25_DIFF] = {
				{ 1,  50067 },  -- Astrylian's Sutured Cinch
				{ 2,  50069 },  -- Professor's Bloodied Smock
				{ 3,  50351 },  -- Tiny Abomination in a Jar
				{ 4,  50179 },  -- Last Word
				{ 5,  50068 },  -- Rigormortis
				{ 7,  50274 },  -- Shadowfrost Shard
				{ 8,  49908 },  -- Primordial Saronite
				{ 10, 142096,  "pet1965" }, -- Putricide's Alchemy Supplies -> Blightbreath
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, "ac4616" },
			},
			[P25H_DIFF] = {
				{ 1,  50707 },  -- Astrylian's Sutured Cinch
				{ 2,  50705 },  -- Professor's Bloodied Smock
				{ 3,  50706 },  -- Tiny Abomination in a Jar
				{ 4,  50708 },  -- Last Word
				{ 5,  50704 },  -- Rigormortis
				{ 7,  50274 },  -- Shadowfrost Shard
				{ 8,  49908 },  -- Primordial Saronite
				{ 10, 142096,  "pet1965" }, -- Putricide's Alchemy Supplies -> Blightbreath
				{ 16, 52030 },  -- Conqueror's Mark of Sanctification
				{ 17, 52029 },  -- Protector's Mark of Sanctification
				{ 18, 52028 },  -- Vanquisher's Mark of Sanctification
				{ 20, 52027 },  -- Conqueror's Mark of Sanctification
				{ 21, 52026 },  -- Protector's Mark of Sanctification
				{ 22, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 24, "ac4616" },
			},
		},
		{ --ICC Council
			EncounterJournalID = 1632,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51382 }, -- Heartsick Mender's Cape
				{ 2,  51379 }, -- Bloodsoul Raiment
				{ 3,  51380 }, -- Pale Corpse Boots
				{ 4,  51023 }, -- Taldaram's Soft Slippers
				{ 5,  51325 }, -- Blood-Drinker's Girdle
				{ 6,  51383 }, -- Spaulders of the Blood Princes
				{ 7,  51025 }, -- Battle-Maiden's Legguards
				{ 9,  51381 }, -- Cerise Coiled Ring
				{ 10, 51024 }, -- Thrice Fanged Signet
				{ 16, 51021 }, -- Soulbreaker
				{ 17, 51022 }, -- Hersir's Greatspear
				{ 18, 51326 }, -- Wand of Ruby Claret
				{ 20, "ac4582" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51848 }, -- Heartsick Mender's Cape
				{ 2,  51851 }, -- Bloodsoul Raiment
				{ 3,  51850 }, -- Pale Corpse Boots
				{ 4,  51856 }, -- Taldaram's Soft Slippers
				{ 5,  51853 }, -- Blood-Drinker's Girdle
				{ 6,  51847 }, -- Spaulders of the Blood Princes
				{ 7,  51854 }, -- Battle-Maiden's Legguards
				{ 9,  51849 }, -- Cerise Coiled Ring
				{ 10, 51855 }, -- Thrice Fanged Signet
				{ 16, 51858 }, -- Soulbreaker
				{ 17, 51857 }, -- Hersir's Greatspear
				{ 18, 51852 }, -- Wand of Ruby Claret
				{ 20, 49908 }, -- Primordial Saronite
				{ 22, "ac4582" },
			},
			[P25_DIFF] = {
				{ 1,  50074 }, -- Royal Crimson Cloak
				{ 2,  50172 }, -- Sanguine Silk Robes
				{ 3,  50176 }, -- San'layn Ritualist Gloves
				{ 4,  50073 }, -- Geistlord's Punishment Sack
				{ 5,  50171 }, -- Shoulders of Frost-Tipped Thorns
				{ 6,  50177 }, -- Mail of Crimson Coins
				{ 7,  50071 }, -- Treads of the Wasteland
				{ 8,  50072 }, -- Landsoul's Horned Greathelm
				{ 9,  50175 }, -- Crypt Keeper's Bracers
				{ 10, 50075 }, -- Taldaram's Plated Fists
				{ 16, 50174 }, -- Incarnadine Band of Mending
				{ 17, 50170 }, -- Valanar's Other Signet Ring
				{ 19, 50184 }, -- Keleseth's Seducer
				{ 20, 49919 }, -- Cryptmaker
				{ 21, 50173 }, -- Shadow Silk Spindle
				{ 23, 50274 }, -- Shadowfrost Shard
				{ 24, 49908 }, -- Primordial Saronite
				{ 26, "ac4617" },
			},
			[P25H_DIFF] = {
				{ 1,  50718 }, -- Royal Crimson Cloak
				{ 2,  50717 }, -- Sanguine Silk Robes
				{ 3,  50722 }, -- San'layn Ritualist Gloves
				{ 4,  50713 }, -- Geistlord's Punishment Sack
				{ 5,  50715 }, -- Shoulders of Frost-Tipped Thorns
				{ 6,  50723 }, -- Mail of Crimson Coins
				{ 7,  50711 }, -- Treads of the Wasteland
				{ 8,  50712 }, -- Landsoul's Horned Greathelm
				{ 9,  50721 }, -- Crypt Keeper's Bracers
				{ 10, 50716 }, -- Taldaram's Plated Fists
				{ 16, 50720 }, -- Incarnadine Band of Mending
				{ 17, 50714 }, -- Valanar's Other Signet Ring
				{ 19, 50710 }, -- Keleseth's Seducer
				{ 20, 50603 }, -- Cryptmaker
				{ 21, 50719 }, -- Shadow Silk Spindle
				{ 23, 50274 }, -- Shadowfrost Shard
				{ 24, 49908 }, -- Primordial Saronite
				{ 26, "ac4617" },
			},
		},
		{ --ICC Lanathel
			EncounterJournalID = 1633,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51554 }, -- Cowl of Malefic Repose
				{ 2,  51552 }, -- Shoulderpads of the Searing Kiss
				{ 3,  51550 }, -- Ivory-Inlaid Leggings
				{ 4,  51551 }, -- Chestguard of Siphoned Elements
				{ 5,  51386 }, -- Throatrender Handguards
				{ 6,  51556 }, -- Veincrusher Gauntlets
				{ 7,  51555 }, -- Tightening Waistband
				{ 16, 51548 }, -- Collar of Haughty Disdain
				{ 17, 51387 }, -- Seal of the Twilight Queen
				{ 19, 51384 }, -- Bloodsipper
				{ 20, 51385 }, -- Stakethrower
				{ 21, 51553 }, -- Lana'thel's Bloody Nail
				{ 23, "ac4539" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51837 }, -- Cowl of Malefic Repose
				{ 2,  51839 }, -- Shoulderpads of the Searing Kiss
				{ 3,  51841 }, -- Ivory-Inlaid Leggings
				{ 4,  51840 }, -- Chestguard of Siphoned Elements
				{ 5,  51844 }, -- Throatrender Handguards
				{ 6,  51835 }, -- Veincrusher Gauntlets
				{ 7,  51836 }, -- Tightening Waistband
				{ 9,  51842 }, -- Collar of Haughty Disdain
				{ 10, 51843 }, -- Seal of the Twilight Queen
				{ 16, 52027 }, -- Conqueror's Mark of Sanctification
				{ 17, 52026 }, -- Protector's Mark of Sanctification
				{ 18, 52025 }, -- Vanquisher's Mark of Sanctification
				{ 20, 51846 }, -- Bloodsipper
				{ 21, 51845 }, -- Stakethrower
				{ 22, 51838 }, -- Lana'thel's Bloody Nail
				{ 24, 49908 }, -- Primordial Saronite
				{ 26, "ac4539" },
			},
			[P25_DIFF] = {
				{ 1,  50182 }, -- Blood Queen's Crimson Choker
				{ 2,  50180 }, -- Lana'thel's Chain of Flagellation
				{ 3,  50354 }, -- Bauble of True Blood
				{ 4,  50178 }, -- Bloodfall
				{ 5,  50181 }, -- Dying Light
				{ 6,  50065 }, -- Icecrown Glacial Wall
				{ 8,  50274 }, -- Shadowfrost Shard
				{ 9,  49908 }, -- Primordial Saronite
				{ 16, 52027 }, -- Conqueror's Mark of Sanctification
				{ 17, 52026 }, -- Protector's Mark of Sanctification
				{ 18, 52025 }, -- Vanquisher's Mark of Sanctification
				{ 20, "ac4618" },
			},
			[P25H_DIFF] = {
				{ 1,  50724 }, -- Blood Queen's Crimson Choker
				{ 2,  50728 }, -- Lana'thel's Chain of Flagellation
				{ 3,  50726 }, -- Bauble of True Blood
				{ 4,  50727 }, -- Bloodfall
				{ 5,  50725 }, -- Dying Light
				{ 6,  50729 }, -- Icecrown Glacial Wall
				{ 8,  50274 }, -- Shadowfrost Shard
				{ 9,  49908 }, -- Primordial Saronite
				{ 16, 52030 }, -- Conqueror's Mark of Sanctification
				{ 17, 52029 }, -- Protector's Mark of Sanctification
				{ 18, 52028 }, -- Vanquisher's Mark of Sanctification
				{ 20, 52027 }, -- Conqueror's Mark of Sanctification
				{ 21, 52026 }, -- Protector's Mark of Sanctification
				{ 22, 52025 }, -- Vanquisher's Mark of Sanctification
				{ 24, "ac4618" },
			},
		},
		{ --ICC Valithria
			EncounterJournalID = 1634,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51584 }, -- Lich Wrappings
				{ 2,  51777 }, -- Leggings of the Refracted Mind
				{ 3,  51585 }, -- Sister Svalna's Spangenhelm
				{ 4,  51565 }, -- Skinned Whelp Shoulders
				{ 5,  51583 }, -- Stormbringer Gloves
				{ 6,  51566 }, -- Legguards of the Twisted Dream
				{ 7,  51586 }, -- Emerald Saint's Spaulders
				{ 8,  51563 }, -- Taiga Bindings
				{ 9,  51564 }, -- Ironrope Belt of Ymirjar
				{ 16, 51562 }, -- Oxheart
				{ 17, 51582 }, -- Sister Svalna's Aether Staff
				{ 18, 51561 }, -- Dreamhunter's Carbine
				{ 20, "ac4579" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51826 }, -- Lich Wrappings
				{ 2,  51823 }, -- Leggings of the Refracted Mind
				{ 3,  51825 }, -- Sister Svalna's Spangenhelm
				{ 4,  51830 }, -- Skinned Whelp Shoulders
				{ 5,  51827 }, -- Stormbringer Gloves
				{ 6,  51829 }, -- Legguards of the Twisted Dream
				{ 7,  51824 }, -- Emerald Saint's Spaulders
				{ 8,  51832 }, -- Taiga Bindings
				{ 9,  51831 }, -- Ironrope Belt of Ymirjar
				{ 16, 51833 }, -- Oxheart
				{ 17, 51828 }, -- Sister Svalna's Aether Staff
				{ 18, 51834 }, -- Dreamhunter's Carbine
				{ 20, 49908 }, -- Primordial Saronite
				{ 22, "ac4579" },
			},
			[P25_DIFF] = {
				{ 1,  50205 }, -- Frostbinder's Shredded Cape
				{ 2,  50418 }, -- Robe of the Waking Nightmare
				{ 3,  50417 }, -- Bracers of Eternal Dreaming
				{ 4,  50202 }, -- Snowstorm Helm
				{ 5,  50188 }, -- Anub'ar Stalker's Gloves
				{ 6,  50187 }, -- Coldwraith Links
				{ 7,  50199 }, -- Leggings of Dying Candles
				{ 8,  50192 }, -- Scourge Reaver's Legplates
				{ 9,  50416 }, -- Boots of the Funeral March
				{ 10, 50190 }, -- Grinning Skull Greatboots
				{ 16, 50195 }, -- Noose of Malachite
				{ 17, 50185 }, -- Devium's Eternally Cold Ring
				{ 18, 50186 }, -- Frostbrood Sapphire Ring
				{ 20, 50183 }, -- Lungbreaker
				{ 21, 50472 }, -- Nightmare Ender
				{ 23, 50274 }, -- Shadowfrost Shard
				{ 24, 49908 }, -- Primordial Saronite
				{ 26, "ac4619" },
			},
			[P25H_DIFF] = {
				{ 1,  50628 }, -- Frostbinder's Shredded Cape
				{ 2,  50629 }, -- Robe of the Waking Nightmare
				{ 3,  50630 }, -- Bracers of Eternal Dreaming
				{ 4,  50626 }, -- Snowstorm Helm
				{ 5,  50619 }, -- Anub'ar Stalker's Gloves
				{ 6,  50620 }, -- Coldwraith Links
				{ 7,  50623 }, -- Leggings of Dying Candles
				{ 8,  50624 }, -- Scourge Reaver's Legplates
				{ 9,  50632 }, -- Boots of the Funeral March
				{ 10, 50625 }, -- Grinning Skull Greatboots
				{ 16, 50627 }, -- Noose of Malachite
				{ 17, 50622 }, -- Devium's Eternally Cold Ring
				{ 18, 50618 }, -- Frostbrood Sapphire Ring
				{ 20, 50621 }, -- Lungbreaker
				{ 21, 50631 }, -- Nightmare Ender
				{ 23, 50274 }, -- Shadowfrost Shard
				{ 24, 49908 }, -- Primordial Saronite
				{ 26, "ac4619" },
			},
		},
		{ --ICC Sindragosa
			EncounterJournalID = 1635,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51790 },  -- Robes of Azure Downfall
				{ 2,  51783 },  -- Vambraces of the Frost Wyrm Queen
				{ 3,  51789 },  -- Icicle Shapers
				{ 4,  51792 },  -- Shoulderguards of Crystalline Bone
				{ 5,  51785 },  -- Wyrmwing Treads
				{ 6,  51782 },  -- Etched Dragonbone Girdle
				{ 7,  51786 },  -- Legplates of Aetheric Strife
				{ 8,  51787 },  -- Scourge Fanged Stompers
				{ 10, 142097,  "pet1966" }, -- Skull of a Frozen Whelp -> Soulbroken Whelpling
				{ 16, 51779 },  -- Rimetooth Pendant
				{ 18, 51784 },  -- Splintershard
				{ 19, 51788 },  -- Bleak Coldarra Carver
				{ 20, 51791 },  -- Lost Pavise of the Blue Flight
				{ 22, "ac4580" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51813 },  -- Robes of Azure Downfall
				{ 2,  51820 },  -- Vambraces of the Frost Wyrm Queen
				{ 3,  51814 },  -- Icicle Shapers
				{ 4,  51811 },  -- Shoulderguards of Crystalline Bone
				{ 5,  51818 },  -- Wyrmwing Treads
				{ 6,  51821 },  -- Etched Dragonbone Girdle
				{ 7,  51817 },  -- Legplates of Aetheric Strife
				{ 8,  51816 },  -- Scourge Fanged Stompers
				{ 10, 51822 },  -- Rimetooth Pendant
				{ 12, 142097,  "pet1966" }, -- Skull of a Frozen Whelp -> Soulbroken Whelpling
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, 51819 },  -- Splintershard
				{ 21, 51815 },  -- Bleak Coldarra Carver
				{ 22, 51812 },  -- Lost Pavise of the Blue Flight
				{ 24, 49908 },  -- Primordial Saronite
				{ 26, "ac4580" },
			},
			[P25_DIFF] = {
				{ 1,  50421 },  -- Sindragosa's Cruel Claw
				{ 2,  50424 },  -- Memory of Malygos
				{ 3,  50360 },  -- Phylactery of the Nameless Lich
				{ 4,  50361 },  -- Sindragosa's Flawless Fang
				{ 5,  50423 },  -- Sundial of Eternal Dusk
				{ 7,  50274 },  -- Shadowfrost Shard
				{ 8,  49908 },  -- Primordial Saronite
				{ 10, 142097,  "pet1966" }, -- Skull of a Frozen Whelp -> Soulbroken Whelpling
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, "ac4620" },
			},
			[P25H_DIFF] = {
				{ 1,  50633 },  -- Sindragosa's Cruel Claw
				{ 2,  50636 },  -- Memory of Malygos
				{ 3,  50365 },  -- Phylactery of the Nameless Lich
				{ 4,  50364 },  -- Sindragosa's Flawless Fang
				{ 5,  50635 },  -- Sundial of Eternal Dusk
				{ 7,  50274 },  -- Shadowfrost Shard
				{ 8,  49908 },  -- Primordial Saronite
				{ 10, 142097,  "pet1966" }, -- Skull of a Frozen Whelp -> Soulbroken Whelpling
				{ 16, 52030 },  -- Conqueror's Mark of Sanctification
				{ 17, 52029 },  -- Protector's Mark of Sanctification
				{ 18, 52028 },  -- Vanquisher's Mark of Sanctification
				{ 20, 52027 },  -- Conqueror's Mark of Sanctification
				{ 21, 52026 },  -- Protector's Mark of Sanctification
				{ 22, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 24, "ac4620" },
			},
		},
		{ --ICC LichKing
			EncounterJournalID = 1636,
			[NORMAL_RAID_DIFF] = {
				{ 1,  51801 },  -- Pugius, Fist of Defiance
				{ 2,  51803 },  -- Tel'thas, Dagger of the Blood King
				{ 3,  51800 },  -- Stormfury, Black Blade of the Betrayer
				{ 4,  51795 },  -- Troggbane, Axe of the Frostborne King
				{ 5,  51798 },  -- Valius, Gavel of the Lightbringer
				{ 6,  51796 },  -- Warmace of Menethil
				{ 7,  51799 },  -- Halion, Staff of Forgotten Love
				{ 8,  51797 },  -- Tainted Twig of Nordrassil
				{ 9,  51802 },  -- Windrunner's Heartseeker
				{ 11, 142098,  "pet1967" }, -- Drudge Remains -> Drudge Ghoul
				{ 16, "ac4530" },
				{ 17, "ac4601" },
				{ 18, "ac4581" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  51941 },  -- Pugius, Fist of Defiance
				{ 2,  51939 },  -- Tel'thas, Dagger of the Blood King
				{ 3,  51942 },  -- Stormfury, Black Blade of the Betrayer
				{ 4,  51947 },  -- Troggbane, Axe of the Frostborne King
				{ 5,  51944 },  -- Valius, Gavel of the Lightbringer
				{ 6,  51946 },  -- Warmace of Menethil
				{ 7,  51943 },  -- Halion, Staff of Forgotten Love
				{ 8,  51945 },  -- Tainted Twig of Nordrassil
				{ 9,  51940 },  -- Windrunner's Heartseeker
				{ 11, 142099,  "pet1968" }, -- Call of the Frozen Blade -> Wicked Soul
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, 49908 },  -- Primordial Saronite
				{ 22, "ac4583" },
				{ 23, "ac4601" },
				{ 24, "ac4581" },
			},
			[P25_DIFF] = {
				{ 1,  50426 },  -- Heaven's Fall, Kryss of a Thousand Lies
				{ 2,  50427 },  -- Bloodsurge, Kel'Thuzad's Blade of Agony
				{ 3,  50070 },  -- Glorenzelg, High-Blade of the Silver Hand
				{ 4,  50012 },  -- Havoc's Call, Blade of Lordaeron Kings
				{ 5,  50428 },  -- Royal Scepter of Terenas II
				{ 6,  49997 },  -- Mithrios, Bronzebeard's Legacy
				{ 7,  50425 },  -- Oathbinder, Charge of the Ranger-General
				{ 8,  50429 },  -- Archus, Greatstaff of Antonidas
				{ 9,  49981 },  -- Fal'inrush, Defender of Quel'thalas
				{ 11, 142098,  "pet1967" }, -- Drudge Remains -> Drudge Ghoul
				{ 16, 52027 },  -- Conqueror's Mark of Sanctification
				{ 17, 52026 },  -- Protector's Mark of Sanctification
				{ 18, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 20, 50274 },  -- Shadowfrost Shard
				{ 21, 49908 },  -- Primordial Saronite
				{ 23, "ac4597" },
				{ 24, "ac4621" },
				{ 25, "ac4622" },
			},
			[P25H_DIFF] = {
				{ 1,  50736 },  -- Heaven's Fall, Kryss of a Thousand Lies
				{ 2,  50732 },  -- Bloodsurge, Kel'Thuzad's Blade of Agony
				{ 3,  50730 },  -- Glorenzelg, High-Blade of the Silver Hand
				{ 4,  50737 },  -- Havoc's Call, Blade of Lordaeron Kings
				{ 5,  50734 },  -- Royal Scepter of Terenas II
				{ 6,  50738 },  -- Mithrios, Bronzebeard's Legacy
				{ 7,  50735 },  -- Oathbinder, Charge of the Ranger-General
				{ 8,  50731 },  -- Archus, Greatstaff of Antonidas
				{ 9,  50733 },  -- Fal'inrush, Defender of Quel'thalas
				{ 11, 142099,  "pet1968" }, -- Call of the Frozen Blade -> Wicked Soul
				{ 12, 50818,   "mount" }, -- Invincible's Reins
				{ 14, 50274 },  -- Shadowfrost Shard
				{ 15, 49908 },  -- Primordial Saronite
				{ 16, 52030 },  -- Conqueror's Mark of Sanctification
				{ 17, 52029 },  -- Protector's Mark of Sanctification
				{ 18, 52028 },  -- Vanquisher's Mark of Sanctification
				{ 20, 52027 },  -- Conqueror's Mark of Sanctification
				{ 21, 52026 },  -- Protector's Mark of Sanctification
				{ 22, 52025 },  -- Vanquisher's Mark of Sanctification
				{ 25, "ac4584" },
				{ 26, "ac4621" },
				{ 27, "ac4622" },
			},
		},
		{ --ICC Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 50449 }, -- Stiffened Corpse Shoulderpads
				{ 2, 50450 }, -- Leggings of Dubious Charms
				{ 3, 50451 }, -- Belt of the Lonely Noble
				{ 4, 50452 }, -- Wodin's Lucky Necklace
				{ 5, 50447 }, -- Harbinger's Bone Band
				{ 6, 50453 }, -- Ring of Rotting Sinew
				{ 7, 50444 }, -- Rowan's Rifle of Silver Bullets
			},
		},
		{ --Tier 10 Sets
			name = format(AL["Tier %d Sets"], 10),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:10",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:10",
			[P25H_DIFF] = "AtlasLoot_Collections:TIERSETS:10",
		},
		{ --The AshenVerdict
			FactionID = 1156,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:WOTLKFACTIONS:7",
		},
		WOTLK_RAID3_10_AC_TABLE,
		WOTLK_RAID3_25_AC_TABLE,
	}
}

data["Naxxramas"] = {
	EncounterJournalID = 754,
	MapID = 162,
	AtlasMapID = "Naxxramas",
	ContentType = RAID_CONTENT,
	items = {
		{ --Naxx80 AnubRekhan
			EncounterJournalID = 1601,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39192 }, -- Gloves of Dark Gestures
				{ 2,  39190 }, -- Agonal Sash
				{ 3,  39191 }, -- Splint-Bound Leggings
				{ 4,  39189 }, -- Boots of Persistence
				{ 5,  39188 }, -- Chivalric Chestguard
				{ 6,  39139 }, -- Ravaging Sabatons
				{ 16, 39146 }, -- Collar of Dissolution
				{ 17, 39193 }, -- Band of Neglected Pleas
				{ 18, 39141 }, -- Deflection Band
				{ 20, 39140 }, -- Knife of Incision
			},
			[P25_DIFF] = {
				{ 1,  39719 }, -- Mantle of the Locusts
				{ 2,  39721 }, -- Sash of the Parlor
				{ 3,  39720 }, -- Leggings of Atrophy
				{ 4,  39722 }, -- Swarm Bindings
				{ 5,  39701 }, -- Dawnwalkers
				{ 6,  39702 }, -- Arachnoid Gold Band
				{ 7,  39718 }, -- Corpse Scarab Handguards
				{ 8,  39704 }, -- Pauldrons of Unnatural Death
				{ 9,  39703 }, -- Rescinding Grips
				{ 10, 39717 }, -- Inexorable Sabatons
				{ 11, 39706 }, -- Sabatons of Sudden Reprisal
				{ 12, 40071 }, -- Chains of Adoration
				{ 13, 40065 }, -- Fool's Trial
				{ 14, 40069 }, -- Heritage
				{ 15, 40064 }, -- Thunderstorm Amulet
				{ 16, 40080 }, -- Lost Jewel
				{ 17, 40075 }, -- Ruthlessness
				{ 18, 40107 }, -- Sand-Worn Band
				{ 19, 40074 }, -- Strong-Handed Ring
				{ 21, 39714 }, -- Webbed Death
				{ 22, 40208 }, -- Cryptfiend's Bite
				{ 23, 39716 }, -- Shield of Assimilation
				{ 24, 39712 }, -- Gemmed Wand of the Nerubians
			},
		},
		{ --Naxx80 Faerlina
			EncounterJournalID = 1602,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39216 }, -- Sash of Mortal Desire
				{ 2,  39215 }, -- Boots of the Follower
				{ 3,  39196 }, -- Boots of the Worshiper
				{ 4,  39217 }, -- Avenging Combat Leggings
				{ 5,  39194 }, -- Rusted-Link Spiked Gauntlets
				{ 6,  39198 }, -- Frostblight Pauldrons
				{ 7,  39195 }, -- Bracers of Lost Sentiments
				{ 8,  39197 }, -- Gauntlets of the Master
				{ 16, 39200 }, -- Grieving Spellblade
				{ 17, 39199 }, -- Watchful Eye
				{ 19, "ac1997" },
			},
			[P25_DIFF] = {
				{ 1,  39732 }, -- Faerlina's Madness
				{ 2,  39731 }, -- Punctilious Bindings
				{ 3,  39733 }, -- Gloves of Token Respect
				{ 4,  39735 }, -- Belt of False Dignity
				{ 5,  39756 }, -- Tunic of Prejudice
				{ 6,  39727 }, -- Dislocating Handguards
				{ 7,  39724 }, -- Cult's Chestguard
				{ 8,  39734 }, -- Atonement Greaves
				{ 9,  39723 }, -- Fire-Scorched Greathelm
				{ 10, 39725 }, -- Epaulets of the Grieving Servant
				{ 11, 39729 }, -- Bracers of the Tyrant
				{ 12, 39726 }, -- Callous-Hearted Gauntlets
				{ 14, 39730 }, -- Widow's Fury
				{ 16, 40071 }, -- Chains of Adoration
				{ 17, 40065 }, -- Fool's Trial
				{ 18, 40069 }, -- Heritage
				{ 19, 40064 }, -- Thunderstorm Amulet
				{ 20, 40080 }, -- Lost Jewel
				{ 21, 40075 }, -- Ruthlessness
				{ 22, 40107 }, -- Sand-Worn Band
				{ 23, 40108 }, -- Seized Beauty
				{ 24, 40074 }, -- Strong-Handed Ring
				{ 26, "ac2140" },
			},
		},
		{ --Naxx80 Maexxna
			EncounterJournalID = 1603,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39225 },  -- Cloak of Armed Strife
				{ 2,  39230 },  -- Spaulders of the Monstrosity
				{ 3,  39224 },  -- Leggings of Discord
				{ 4,  39228 },  -- Web Cocoon Grips
				{ 6,  39232 },  -- Pendant of Lost Vocations
				{ 7,  39231 },  -- Timeworn Silken Band
				{ 8,  39229 },  -- Embrace of the Spider
				{ 10, 93030,   "pet1143" }, -- Dusty Clutch of Eggs
				{ 16, 39226 },  -- Maexxna's Femur
				{ 17, 39221 },  -- Wraith Spear
				{ 18, 39233 },  -- Aegis of Damnation
				{ 20, "ac1858" },
			},
			[P25_DIFF] = {
				{ 1,  40250 },  -- Aged Winter Cloak
				{ 2,  40254 },  -- Cloak of Averted Crisis
				{ 3,  40252 },  -- Cloak of the Shadowed Sun
				{ 4,  40253 },  -- Shawl of the Old Maid
				{ 5,  40251 },  -- Shroud of Luminosity
				{ 6,  40062 },  -- Digested Silken Robes
				{ 7,  40060 },  -- Distorted Limbs
				{ 8,  39768 },  -- Cowl of the Perished
				{ 9,  40063 },  -- Mantle of Shattered Kinship
				{ 10, 39765 },  -- Sinner's Bindings
				{ 11, 39761 },  -- Infectious Skitterer Leggings
				{ 12, 40061 },  -- Quivering Tunic
				{ 13, 39762 },  -- Torn Web Wrapping
				{ 14, 39760 },  -- Helm of Diminished Pride
				{ 15, 39767 },  -- Undiminished Battleplate
				{ 16, 39764 },  -- Bindings of the Hapless Prey
				{ 17, 39759 },  -- Ablative Chitin Girdle
				{ 19, 40257 },  -- Defender's Code
				{ 20, 40255 },  -- Dying Curse
				{ 21, 40258 },  -- Forethought Talisman
				{ 22, 40256 },  -- Grim Toll
				{ 24, 39763 },  -- Wraith Strike
				{ 25, 39758 },  -- The Jawbone
				{ 26, 39766 },  -- Matriarch's Spawn
				{ 28, 93030,   "pet1143" }, -- Dusty Clutch of Eggs
				{ 30, "ac1859" },
			},
		},
		{ --Naxx80 Noth
			EncounterJournalID = 1604,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39241 }, -- Dark Shroud of the Scourge
				{ 2,  39242 }, -- Robes of Hoarse Breaths
				{ 3,  39240 }, -- Noth's Curse
				{ 4,  39237 }, -- Spaulders of Resumed Battle
				{ 5,  39243 }, -- Handgrips of the Foredoomed
				{ 6,  39236 }, -- Trespasser's Boots
				{ 7,  39239 }, -- Chestplate of the Risen Soldier
				{ 8,  39235 }, -- Bone-Framed Bracers
				{ 9,  39234 }, -- Plague-Impervious Boots
				{ 16, 39244 }, -- Ring of the Fated
			},
			[P25_DIFF] = {
				{ 1,  40602 }, -- Robes of Mutation
				{ 2,  40198 }, -- Bands of Impurity
				{ 3,  40197 }, -- Gloves of the Fallen Wizard
				{ 4,  40186 }, -- Thrusting Bands
				{ 5,  40200 }, -- Belt of Potent Chanting
				{ 6,  40193 }, -- Tunic of Masked Suffering
				{ 7,  40196 }, -- Legguards of the Undisturbed
				{ 8,  40184 }, -- Crippled Treads
				{ 9,  40185 }, -- Shoulderguards of Opportunity
				{ 10, 40188 }, -- Gauntlets of the Disobediant
				{ 11, 40187 }, -- Poignant Sabatons
				{ 13, 40189 }, -- Angry Dread
				{ 14, 40192 }, -- Accursed Spine
				{ 16, 40071 }, -- Chains of Adoration
				{ 17, 40065 }, -- Fool's Trial
				{ 18, 40069 }, -- Heritage
				{ 19, 40064 }, -- Thunderstorm Amulet
				{ 20, 40080 }, -- Lost Jewel
				{ 21, 40075 }, -- Ruthlessness
				{ 22, 40107 }, -- Sand-Worn Band
				{ 23, 40108 }, -- Seized Beauty
				{ 24, 40074 }, -- Strong-Handed Ring
			},
		},
		{ --Naxx80 Heigan
			EncounterJournalID = 1605,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39252 }, -- Preceptor's Bindings
				{ 2,  39254 }, -- Saltarello Shoes
				{ 3,  39247 }, -- Cuffs of Dark Shadows
				{ 4,  39248 }, -- Tunic of the Lost Pack
				{ 5,  39251 }, -- Necrogenic Belt
				{ 6,  39249 }, -- Shoulderplates of Bloodshed
				{ 16, 39246 }, -- Amulet of Autopsy
				{ 17, 39250 }, -- Ring of Holy Cleansing
				{ 19, 39245 }, -- Demise
				{ 20, 39255 }, -- Staff of the Plague Beast
				{ 22, "ac1996" },
			},
			[P25_DIFF] = {
				{ 1,  40250 }, -- Aged Winter Cloak
				{ 2,  40254 }, -- Cloak of Averted Crisis
				{ 3,  40252 }, -- Cloak of the Shadowed Sun
				{ 4,  40253 }, -- Shawl of the Old Maid
				{ 5,  40251 }, -- Shroud of Luminosity
				{ 6,  40234 }, -- Heigan's Putrid Vestments
				{ 7,  40236 }, -- Serene Echoes
				{ 8,  40238 }, -- Gloves of the Dancing Bear
				{ 9,  40205 }, -- Stalk-Skin Belt
				{ 10, 40235 }, -- Helm of Pilgrimage
				{ 11, 40209 }, -- Bindings of the Decrepit
				{ 12, 40201 }, -- Leggings of Colossal Strides
				{ 13, 40237 }, -- Eruption-Scarred Boots
				{ 14, 40203 }, -- Breastplate of Tormented Rage
				{ 15, 40210 }, -- Chestguard of Bitter Charms
				{ 16, 40204 }, -- Legguards of the Apostle
				{ 17, 40206 }, -- Iron-Spring Jumpers
				{ 19, 40257 }, -- Defender's Code
				{ 20, 40255 }, -- Dying Curse
				{ 21, 40258 }, -- Forethought Talisman
				{ 22, 40256 }, -- Grim Toll
				{ 24, 40208 }, -- Cryptfiend's Bite
				{ 25, 40233 }, -- The Undeath Carrier
				{ 27, "ac2139" },
			},
		},
		{ --Naxx80 Loatheb
			EncounterJournalID = 1606,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39259 },  -- Fungi-Stained Coverings
				{ 2,  39260 },  -- Helm of the Corrupted Mind
				{ 3,  39258 },  -- Legplates of Inescapable Death
				{ 4,  39257 },  -- Loatheb's Shadow
				{ 5,  39256 },  -- Sulfur Stave
				{ 7,  93032,   "pet1144" }, -- Blighted Spore
				{ 16, 40622 },  -- Spaulders of the Lost Conqueror
				{ 17, 40623 },  -- Spaulders of the Lost Protector
				{ 18, 40624 },  -- Spaulders of the Lost Vanquisher
				{ 20, "ac2182" },
			},
			[P25_DIFF] = {
				{ 1,  40247 },  -- Cowl of Innocent Delight
				{ 2,  40246 },  -- Boots of Impetuous Ideals
				{ 3,  40249 },  -- Vest of Vitality
				{ 4,  40243 },  -- Footwraps of Vile Deceit
				{ 5,  40242 },  -- Grotesque Handgrips
				{ 6,  40241 },  -- Girdle of Unity
				{ 7,  40240 },  -- Greaves of Turbulence
				{ 9,  93032,   "pet1144" }, -- Blighted Spore
				{ 16, 40244 },  -- The Impossible Dream
				{ 17, 40239 },  -- The Hand of Nerub
				{ 18, 40245 },  -- Fading Glow
				{ 20, 40637 },  -- Mantle of the Lost Conqueror
				{ 21, 40638 },  -- Mantle of the Lost Protector
				{ 22, 40639 },  -- Mantle of the Lost Vanquisher
				{ 24, "ac2183" },
			},
		},
		{ --Naxx80 Razuvious
			EncounterJournalID = 1607,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39297 }, -- Cloak of Darkening
				{ 2,  39310 }, -- Mantle of the Extensive Mind
				{ 3,  39309 }, -- Leggings of the Instructor
				{ 4,  39299 }, -- Rapid Attack Gloves
				{ 5,  39308 }, -- Girdle of Lenience
				{ 6,  39307 }, -- Iron Rings of Endurance
				{ 7,  39306 }, -- Plated Gloves of Relief
				{ 8,  39298 }, -- Waistguard of the Tutor
				{ 16, 39296 }, -- Accursed Bow of the Elite
				{ 17, 39311 }, -- Scepter of Murmuring Spirits
			},
			[P25_DIFF] = {
				{ 1,  40325 }, -- Bindings of the Expansive Mind
				{ 2,  40326 }, -- Boots of Forlorn Wishes
				{ 3,  40305 }, -- Spaulders of Egotism
				{ 4,  40319 }, -- Chestpiece of Suspicion
				{ 5,  40323 }, -- Esteemed Bindings
				{ 6,  40315 }, -- Shoulderpads of Secret Arts
				{ 7,  40324 }, -- Bands of Mutual Respect
				{ 8,  40327 }, -- Girdle of Recuperation
				{ 9,  40306 }, -- Bracers of the Unholy Knight
				{ 10, 40316 }, -- Gauntlets of Guiding Touch
				{ 11, 40317 }, -- Girdle of Razuvious
				{ 12, 40318 }, -- Legplates of Double Strikes
				{ 13, 40320 }, -- Faithful Steel Sabatons
				{ 16, 40071 }, -- Chains of Adoration
				{ 17, 40065 }, -- Fool's Trial
				{ 18, 40069 }, -- Heritage
				{ 19, 40064 }, -- Thunderstorm Amulet
				{ 20, 40080 }, -- Lost Jewel
				{ 21, 40075 }, -- Ruthlessness
				{ 22, 40107 }, -- Sand-Worn Band
				{ 23, 40108 }, -- Seized Beauty
				{ 24, 40074 }, -- Strong-Handed Ring
			},
		},
		{ --Naxx80 Gothik
			EncounterJournalID = 1608,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39390 }, -- Resurgent Phantom Bindings
				{ 2,  39386 }, -- Tunic of Dislocation
				{ 3,  39391 }, -- Heinous Mail Chestguard
				{ 4,  39379 }, -- Spectral Rider's Girdle
				{ 5,  39345 }, -- Girdle of the Ascended Phantom
				{ 6,  39369 }, -- Sabatons of Deathlike Gloom
				{ 16, 39392 }, -- Veiled Amulet of Life
				{ 17, 39389 }, -- Signet of the Malevolent
				{ 18, 39388 }, -- Spirit-World Glass
				{ 20, 39344 }, -- Slayer of the Lifeless
			},
			[P25_DIFF] = {
				{ 1,  40250 }, -- Aged Winter Cloak
				{ 2,  40254 }, -- Cloak of Averted Crisis
				{ 3,  40252 }, -- Cloak of the Shadowed Sun
				{ 4,  40253 }, -- Shawl of the Old Maid
				{ 5,  40251 }, -- Shroud of Luminosity
				{ 6,  40339 }, -- Gothik's Cowl
				{ 7,  40338 }, -- Bindings of Yearning
				{ 8,  40329 }, -- Hood of the Exodus
				{ 9,  40341 }, -- Shackled Cinch
				{ 10, 40333 }, -- Leggings of Fleeting Moments
				{ 11, 40340 }, -- Helm of Unleashed Energy
				{ 12, 40331 }, -- Leggings of Failed Escape
				{ 13, 40328 }, -- Helm of Vital Protection
				{ 14, 40334 }, -- Burdened Shoulderplates
				{ 15, 40332 }, -- Abetment Bracers
				{ 16, 40330 }, -- Bracers of Unrelenting Attack
				{ 18, 40257 }, -- Defender's Code
				{ 19, 40255 }, -- Dying Curse
				{ 20, 40258 }, -- Forethought Talisman
				{ 21, 40256 }, -- Grim Toll
				{ 23, 40336 }, -- Life and Death
				{ 24, 40335 }, -- Touch of Horror
			},
		},
		{ --Naxx80 FourHorsemen
			EncounterJournalID = 1609,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39396 }, -- Gown of Blaumeux
				{ 2,  39397 }, -- Pauldrons of Havoc
				{ 3,  39395 }, -- Thane's Tainted Greathelm
				{ 4,  39393 }, -- Claymore of Ancient Power
				{ 5,  39394 }, -- Charmed Cierge
				{ 16, 40610 }, -- Chestguard of the Lost Conqueror
				{ 17, 40611 }, -- Chestguard of the Lost Protector
				{ 18, 40612 }, -- Chestguard of the Lost Vanquisher
				{ 20, "ac2176" },
			},
			[P25_DIFF] = {
				{ 1,  40286 }, -- Mantle of the Corrupted
				{ 2,  40349 }, -- Gloves of Peaceful Death
				{ 3,  40344 }, -- Helm of the Grave
				{ 4,  40352 }, -- Leggings of Voracious Shadows
				{ 5,  40347 }, -- Zeliek's Gauntlets
				{ 7,  40345 }, -- Broken Promise
				{ 8,  40343 }, -- Armageddon
				{ 9,  40348 }, -- Damnation
				{ 10, 40346 }, -- Final Voyage
				{ 11, 40350 }, -- Urn of Lost Memories
				{ 16, 40625 }, -- Breastplate of the Lost Conqueror
				{ 17, 40626 }, -- Breastplate of the Lost Protector
				{ 18, 40627 }, -- Breastplate of the Lost Vanquisher
				{ 20, "ac2177" },
			},
		},
		{ --Naxx80 Patchwerk
			EncounterJournalID = 1610,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39272 }, -- Drape of Surgery
				{ 2,  39273 }, -- Sullen Cloth Boots
				{ 3,  39275 }, -- Contagion Gloves
				{ 4,  39274 }, -- Retcher's Shoulderpads
				{ 5,  39267 }, -- Abomination Shoulderblades
				{ 6,  39262 }, -- Gauntlets of Combined Strength
				{ 7,  39261 }, -- Tainted Girdle of Mending
				{ 16, 39271 }, -- Blade of Dormant Memories
				{ 17, 39270 }, -- Hatestrike
				{ 19, "ac1856" },
			},
			[P25_DIFF] = {
				{ 1,  40271 }, -- Sash of Solitude
				{ 2,  40269 }, -- Boots of Persuasion
				{ 3,  40260 }, -- Belt of the Tortured
				{ 4,  40270 }, -- Boots of Septic Wounds
				{ 5,  40262 }, -- Gloves of Calculated Risk
				{ 6,  40272 }, -- Girdle of the Gambit
				{ 7,  40261 }, -- Crude Discolored Battlegrips
				{ 8,  40263 }, -- Fleshless Girdle
				{ 9,  40259 }, -- Waistguard of Divine Grace
				{ 11, 40264 }, -- Split Greathammer
				{ 12, 40266 }, -- Hero's Surrender
				{ 13, 40265 }, -- Arrowsong
				{ 14, 40273 }, -- Surplus Limb
				{ 16, 40071 }, -- Chains of Adoration
				{ 17, 40065 }, -- Fool's Trial
				{ 18, 40069 }, -- Heritage
				{ 19, 40064 }, -- Thunderstorm Amulet
				{ 20, 40080 }, -- Lost Jewel
				{ 21, 40075 }, -- Ruthlessness
				{ 22, 40107 }, -- Sand-Worn Band
				{ 23, 40108 }, -- Seized Beauty
				{ 24, 40074 }, -- Strong-Handed Ring
				{ 26, "ac1857" },
			},
		},
		{ --Naxx80 Grobbulus
			EncounterJournalID = 1611,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39284 }, -- Miasma Mantle
				{ 2,  39285 }, -- Handgrips of Turmoil
				{ 3,  39283 }, -- Putrescent Bands
				{ 4,  39279 }, -- Blistered Belt of Decay
				{ 5,  39278 }, -- Bands of Anxiety
				{ 6,  39280 }, -- Leggings of Innumerable Barbs
				{ 8,  39282 }, -- Bone-Linked Amulet
				{ 9,  39277 }, -- Sealing Ring of Grobbulus
				{ 16, 39281 }, -- Infection Repulser
				{ 17, 39276 }, -- The Skull of Ruin
			},
			[P25_DIFF] = {
				{ 1,  40250 }, -- Aged Winter Cloak
				{ 2,  40254 }, -- Cloak of Averted Crisis
				{ 3,  40252 }, -- Cloak of the Shadowed Sun
				{ 4,  40253 }, -- Shawl of the Old Maid
				{ 5,  40251 }, -- Shroud of Luminosity
				{ 6,  40287 }, -- Cowl of Vanity
				{ 7,  40351 }, -- Mantle of the Fatigued Sage
				{ 8,  40289 }, -- Sympathetic Amice
				{ 9,  40277 }, -- Tunic of Indulgence
				{ 10, 40285 }, -- Desecrated Past
				{ 11, 40288 }, -- Spaulders of Incoherence
				{ 12, 40283 }, -- Fallout Impervious Tunic
				{ 13, 40282 }, -- Slime Stream Bands
				{ 14, 40275 }, -- Depraved Linked Belt
				{ 15, 40279 }, -- Chestguard of the Exhausted
				{ 16, 40274 }, -- Bracers of Liberation
				{ 17, 40278 }, -- Girdle of Chivalry
				{ 19, 40257 }, -- Defender's Code
				{ 20, 40255 }, -- Dying Curse
				{ 21, 40258 }, -- Forethought Talisman
				{ 22, 40256 }, -- Grim Toll
				{ 24, 40281 }, -- Twilight Mist
				{ 25, 40280 }, -- Origin of Nightmares
				{ 26, 40284 }, -- Plague Igniter
			},
		},
		{ --Naxx80 Gluth
			EncounterJournalID = 1612,
			[NORMAL_RAID_DIFF] = {
				{ 1,   39272 }, -- Drape of Surgery
				{ 2,   39284 }, -- Miasma Mantle
				{ 3,   39396 }, -- Gown of Blaumeux
				{ 4,   39309 }, -- Leggings of the Instructor
				{ 5,   39237 }, -- Spaulders of Resumed Battle
				{ 6,   39279 }, -- Blistered Belt of Decay
				{ 7,   39191 }, -- Splint-Bound Leggings
				{ 8,   39215 }, -- Boots of the Follower
				{ 9,   39294 }, -- Arc-Scorched Helmet
				{ 10,  39248 }, -- Tunic of the Lost Pack
				{ 11,  39194 }, -- Rusted-Link Spiked Gauntlets
				{ 12,  39251 }, -- Necrogenic Belt
				{ 13,  39379 }, -- Spectral Rider's Girdle
				{ 14,  39188 }, -- Chivalric Chestguard
				{ 15,  39345 }, -- Girdle of the Ascended Phantom
				{ 16,  39146 }, -- Collar of Dissolution
				{ 17,  39232 }, -- Pendant of Lost Vocations
				{ 18,  39193 }, -- Band of Neglected Pleas
				{ 19,  39388 }, -- Spirit-World Glass
				{ 21,  39200 }, -- Grieving Spellblade
				{ 22,  39281 }, -- Infection Repulser
				{ 23,  39344 }, -- Slayer of the Lifeless
				{ 24,  39394 }, -- Charmed Cierge
				{ 26,  93029, "pet1146" }, -- Gluth's Bone
				{ 101, 40622 }, -- Spaulders of the Lost Conqueror
				{ 102, 40623 }, -- Spaulders of the Lost Protector
				{ 103, 40624 }, -- Spaulders of the Lost Vanquisher
				{ 105, 40610 }, -- Chestguard of the Lost Conqueror
				{ 106, 40611 }, -- Chestguard of the Lost Protector
				{ 107, 40612 }, -- Chestguard of the Lost Vanquisher
				{ 116, 40619 }, -- Leggings of the Lost Conqueror
				{ 117, 40620 }, -- Leggings of the Lost Protector
				{ 118, 40621 }, -- Leggings of the Lost Vanquisher
			},
			[P25_DIFF] = {
				{ 1,   40247 }, -- Cowl of Innocent Delight
				{ 2,   40289 }, -- Sympathetic Amice
				{ 3,   40602 }, -- Robes of Mutation
				{ 4,   39733 }, -- Gloves of Token Respect
				{ 5,   40303 }, -- Wraps of the Persecuted
				{ 6,   40326 }, -- Boots of Forlorn Wishes
				{ 7,   40296 }, -- Cover of Silence
				{ 8,   39768 }, -- Cowl of the Perished
				{ 9,   40319 }, -- Chestpiece of Suspicion
				{ 10,  40260 }, -- Belt of the Tortured
				{ 11,  40205 }, -- Stalk-Skin Belt
				{ 12,  40270 }, -- Boots of Septic Wounds
				{ 13,  40193 }, -- Tunic of Masked Suffering
				{ 14,  40209 }, -- Bindings of the Decrepit
				{ 15,  40302 }, -- Benefactor's Gauntlets
				{ 16,  39718 }, -- Corpse Scarab Handguards
				{ 17,  40242 }, -- Grotesque Handgrips
				{ 18,  39760 }, -- Helm of Diminished Pride
				{ 19,  40185 }, -- Shoulderguards of Opportunity
				{ 20,  40203 }, -- Breastplate of Tormented Rage
				{ 21,  40332 }, -- Abetment Bracers
				{ 22,  40188 }, -- Gauntlets of the Disobediant
				{ 23,  40259 }, -- Waistguard of Divine Grace
				{ 24,  40204 }, -- Legguards of the Apostle
				{ 25,  39717 }, -- Inexorable Sabatons
				{ 26,  40206 }, -- Iron-Spring Jumpers
				{ 27,  40297 }, -- Sabatons of Endurance
				{ 101, 40350 }, -- Urn of Lost Memories
				{ 103, 40281 }, -- Twilight Mist
				{ 104, 39714 }, -- Webbed Death
				{ 105, 39730 }, -- Widow's Fury
				{ 106, 40343 }, -- Armageddon
				{ 107, 40239 }, -- The Hand of Nerub
				{ 108, 40280 }, -- Origin of Nightmares
				{ 109, 39716 }, -- Shield of Assimilation
				{ 110, 40265 }, -- Arrowsong
				{ 111, 40346 }, -- Final Voyage
				{ 113, 93029, "pet1146" }, -- Gluth's Bone
				{ 116, 40637 }, -- Mantle of the Lost Conqueror
				{ 117, 40638 }, -- Mantle of the Lost Protector
				{ 118, 40639 }, -- Mantle of the Lost Vanquisher
				{ 120, 40625 }, -- Breastplate of the Lost Conqueror
				{ 121, 40626 }, -- Breastplate of the Lost Protector
				{ 122, 40627 }, -- Breastplate of the Lost Vanquisher
				{ 124, 40634 }, -- Legplates of the Lost Conqueror
				{ 125, 40635 }, -- Legplates of the Lost Protector
				{ 126, 40636 }, -- Legplates of the Lost Vanquisher
			},
		},
		{ --Naxx80 Thaddius
			EncounterJournalID = 1613,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39295 }, -- Cowl of Sheet Lightning
				{ 2,  39294 }, -- Arc-Scorched Helmet
				{ 3,  39293 }, -- Blackened Legplates of Feugen
				{ 4,  39292 }, -- Repelling Charge
				{ 5,  39291 }, -- Torment of the Banished
				{ 16, 40619 }, -- Leggings of the Lost Conqueror
				{ 17, 40620 }, -- Leggings of the Lost Protector
				{ 18, 40621 }, -- Leggings of the Lost Vanquisher
				{ 20, "ac2178" },
				{ 21, "ac2180" },
			},
			[P25_DIFF] = {
				{ 1,  40303 }, -- Wraps of the Persecuted
				{ 2,  40301 }, -- Cincture of Polarity
				{ 3,  40296 }, -- Cover of Silence
				{ 4,  40304 }, -- Headpiece of Fungal Bloom
				{ 5,  40299 }, -- Pauldrons of the Abandoned
				{ 6,  40302 }, -- Benefactor's Gauntlets
				{ 7,  40298 }, -- Faceguard of the Succumbed
				{ 8,  40294 }, -- Riveted Abomination Leggings
				{ 9,  40297 }, -- Sabatons of Endurance
				{ 16, 40300 }, -- Spire of Sunset
				{ 18, 40634 }, -- Legplates of the Lost Conqueror
				{ 19, 40635 }, -- Legplates of the Lost Protector
				{ 20, 40636 }, -- Legplates of the Lost Vanquisher
				{ 22, "ac2179" },
				{ 23, "ac2181" },
			},
		},
		{ --Naxx80 Sapphiron
			EncounterJournalID = 1614,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39415 }, -- Shroud of the Citadel
				{ 2,  39404 }, -- Cloak of Mastery
				{ 3,  39409 }, -- Cowl of Winged Fear
				{ 4,  39408 }, -- Leggings of Sapphiron
				{ 5,  39399 }, -- Helm of the Vast Legions
				{ 6,  39405 }, -- Helmet of the Inner Sanctum
				{ 7,  39403 }, -- Helm of the Unsubmissive
				{ 8,  39398 }, -- Massive Skeletal Ribcage
				{ 16, 39401 }, -- Circle of Death
				{ 17, 39407 }, -- Circle of Life
				{ 19, "ac572" },
				{ 20, "ac2146" },
			},
			[P25_DIFF] = {
				{ 1,  40381 }, -- Sympathy
				{ 2,  40380 }, -- Gloves of Grandeur
				{ 3,  40376 }, -- Legwraps of the Defeated Dragon
				{ 4,  40362 }, -- Gloves of Fast Reactions
				{ 5,  40379 }, -- Legguards of the Boneyard
				{ 6,  40367 }, -- Boots of the Great Construct
				{ 7,  40366 }, -- Platehelm of the Great Wyrm
				{ 8,  40377 }, -- Noble Birthright Pauldrons
				{ 9,  40365 }, -- Breastplate of Frozen Pain
				{ 10, 40363 }, -- Bone-Inlaid Legguards
				{ 12, 40368 }, -- Murder"
				{ 16, 40378 }, -- Ceaseless Pity
				{ 17, 40374 }, -- Cosmic Lights
				{ 18, 40369 }, -- Icy Blast Amulet
				{ 19, 40370 }, -- Gatekeeper
				{ 20, 40375 }, -- Ring of Decaying Beauty
				{ 21, 40371 }, -- Bandit's Insignia
				{ 22, 40373 }, -- Extract of Necromatic Power
				{ 23, 40372 }, -- Rune of Repulsion
				{ 24, 40382 }, -- Soul of the Dead
				{ 26, "ac573" },
				{ 27, "ac2147" },
			},
		},
		{ --Naxx80 KelThuzad
			EncounterJournalID = 1615,
			[NORMAL_RAID_DIFF] = {
				{ 1,  39425 }, -- Cloak of the Dying
				{ 2,  39421 }, -- Gem of Imprisoned Vassals
				{ 3,  39416 }, -- Kel'Thuzad's Reach
				{ 4,  39424 }, -- The Soulblade
				{ 5,  39420 }, -- Anarchy
				{ 6,  39417 }, -- Death's Bite
				{ 7,  39423 }, -- Hammer of the Astral Plane
				{ 8,  39422 }, -- Staff of the Plaguehound
				{ 9,  39426 }, -- Wand of the Archlich
				{ 10, 39419 }, -- Nerubian Conquerer
				{ 16, 40616 }, -- Helm of the Lost Conqueror
				{ 17, 40617 }, -- Helm of the Lost Protector
				{ 18, 40618 }, -- Helm of the Lost Vanquisher
				{ 20, "ac574" },
				{ 21, "ac1658" },
				{ 22, "ac2184" },
			},
			[P25_DIFF] = {
				{ 1,  40405 }, -- Cape of the Unworthy Wizard
				{ 2,  40403 }, -- Drape of the Deadly Foe
				{ 3,  40398 }, -- Leggings of Mortal Arrogance
				{ 5,  40383 }, -- Calamity's Grasp
				{ 6,  40386 }, -- Sinister Revenge
				{ 7,  40396 }, -- The Turning Tide
				{ 8,  40395 }, -- Torch of Holy Fire
				{ 9,  40402 }, -- Last Laugh
				{ 10, 40384 }, -- Betrayer of Humanity
				{ 11, 40388 }, -- Journey's End
				{ 12, 40401 }, -- Voice of Reason
				{ 13, 40400 }, -- Wall of Terror
				{ 14, 40385 }, -- Envoy of Mortality
				{ 16, 40387 }, -- Boundless Ambition
				{ 17, 40399 }, -- Signet of Manifested Pain
				{ 19, 40631 }, -- Crown of the Lost Conqueror
				{ 20, 40632 }, -- Crown of the Lost Protector
				{ 21, 40633 }, -- Crown of the Lost Vanquisher
				{ 23, "ac575" },
				{ 24, "ac1658" },
				{ 25, "ac2185" },
			},
		},
		{ --Naxx80 Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_RAID_DIFF] = {
				{ 1, 39467 }, -- Minion Bracers
				{ 2, 39472 }, -- Chain of Latent Energies
				{ 3, 39470 }, -- Medallion of the Disgraced
				{ 4, 39427 }, -- Omen of Ruin
				{ 5, 39468 }, -- The Stray
				{ 6, 39473 }, -- Contortion
			},
			[P25_DIFF] = {
				{ 1, 40410 }, -- Shadow of the Ghoul
				{ 2, 40409 }, -- Boots of the Escaped Captive
				{ 3, 40414 }, -- Shoulderguards of the Undaunted
				{ 4, 40412 }, -- Ousted Bead Necklace
				{ 5, 40408 }, -- Haunting Call
				{ 6, 40407 }, -- Silent Crusader
				{ 7, 40406 }, -- Inevitable Defeat
			},
		},
		{ --Tier 7 Sets
			name = format(AL["Tier %d Sets"], 7),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
		},
		WOTLK_RAID1_10_AC_TABLE,
		WOTLK_RAID1_25_AC_TABLE,
	}
}

data["OnyxiasLair"] = {
	EncounterJournalID = 760,
	MapID = 248,
	AtlasMapID = "OnyxiasLair",
	ContentType = RAID_CONTENT,
	items = {
		{ --Onyxia
			EncounterJournalID = 1651,
			[NORMAL_RAID_DIFF] = {
				{ 1,   49307 }, -- Fluttering Sapphiron Drape
				{ 2,   49316 }, -- Circlet of Transcendence
				{ 3,   49317 }, -- Coronet of Transcendence
				{ 4,   49315 }, -- Nemesis Skullcover
				{ 5,   49318 }, -- Netherwind Hood
				{ 6,   49322 }, -- Bloodfang Mask
				{ 7,   49327 }, -- Stormrage Antlers
				{ 8,   49328 }, -- Stormrage Helm
				{ 9,   49326 }, -- Stormrage Hood
				{ 10,  49331 }, -- Coif of Ten Storms
				{ 11,  49330 }, -- Cowl of Ten Storms
				{ 12,  49329 }, -- Gaze of Ten Storms
				{ 13,  49319 }, -- Dragonstalker's Helmet
				{ 14,  49320 }, -- Faceguard of Wrath
				{ 15,  49321 }, -- Greathelm of Wrath
				{ 16,  49333 }, -- Frostforged Helmet
				{ 17,  49332 }, -- Frostforged Ringhelm
				{ 18,  49323 }, -- Judgement Cover
				{ 19,  49325 }, -- Judgement Helm
				{ 20,  49324 }, -- Judgement Helmet
				{ 22,  49306 }, -- Eskhandar's Choker
				{ 23,  49309 }, -- Runed Ring of Binding
				{ 24,  49463 }, -- Purified Shard of the Flame
				{ 25,  49310 }, -- Purified Shard of the Scale
				{ 101, 49304 }, -- Sharpened Fang of the Mystics
				{ 102, 49437 }, -- Rusted Gutgore Ripper
				{ 103, 49298 }, -- Glinting Azuresong Mageblade
				{ 104, 49303 }, -- Gleaming Quel'Serrar
				{ 105, 49296 }, -- Singed Vis'kag the Bloodletter
				{ 106, 49299 }, -- Keen Obsidian Edged Blade
				{ 107, 49297 }, -- Empowered Deathbringer
				{ 108, 49302 }, -- Reclaimed Shadowstrike
				{ 109, 49301 }, -- Reclaimed Thunderstrike
				{ 110, 49305 }, -- Snub-Nose Blastershot Launcher
				{ 111, 49308 }, -- Antique Cornerstone Grimoire
				{ 116, 49644 }, -- Head of Onyxia
				{ 117, 49485 }, -- Sparkling Onyxia Tooth Pendant
				{ 118, 49486 }, -- Polished Dragonslayer's Signet
				{ 119, 49487 }, -- Purified Onyxia Blood Talisman
				{ 121, 49295 }, -- Enlarged Onyxia Hide Backpack
				{ 122, 49294 }, -- Ashen Sack of Gems
				{ 124, 49636,   "mount" }, -- Reins of the Onyxian Drake
				{ 126, "ac4396" },
				{ 127, "ac4403" },
				{ 128, "ac4402" },
				{ 129, "ac4404" },
			},
			[P25_DIFF] = {
				{ 1,   49491 }, -- Flowing Sapphiron Drape
				{ 2,   49482 }, -- Aurora of Transcendence
				{ 3,   49483 }, -- Halo of Transcendence
				{ 4,   49484 }, -- Nemesis Skullcap
				{ 5,   49481 }, -- Netherwind Crown
				{ 6,   49477 }, -- Bloodfang Hood
				{ 7,   49472 }, -- Stormrage Crown
				{ 8,   49473 }, -- Stormrage Cover
				{ 9,   49471 }, -- Stormrage Coverlet
				{ 10,  49469 }, -- Crown of Ten Storms
				{ 11,  49468 }, -- Helm of Ten Storms
				{ 12,  49470 }, -- Helmet of Ten Storms
				{ 13,  49480 }, -- Dragonstalker's Helm
				{ 14,  49479 }, -- Helm of Wrath
				{ 15,  49478 }, -- Helmet of Wrath
				{ 16,  49467 }, -- Frostforged Greathelm
				{ 17,  49466 }, -- Frostforged Helm
				{ 18,  49476 }, -- Judgement Crown
				{ 19,  49475 }, -- Judgement Heaume
				{ 20,  49474 }, -- Judgement Hood
				{ 22,  49492 }, -- Eskhandar's Links
				{ 23,  49489 }, -- Signified Ring of Binding
				{ 24,  49464 }, -- Shiny Shard of the Flame
				{ 25,  49488 }, -- Shiny Shard of the Scale
				{ 101, 49494 }, -- Honed Fang of the Mystics
				{ 102, 49465 }, -- Tarnished Gutgore Ripper
				{ 103, 49499 }, -- Polished Azuresong Mageblade
				{ 104, 49495 }, -- Burnished Quel'Serrar
				{ 105, 49501 }, -- Tempered Vis'kag the Bloodletter
				{ 106, 49498 }, -- Sharpened Obsidian Edged Blade
				{ 107, 49500 }, -- Raging Deathbringer
				{ 108, 49496 }, -- Reinforced Shadowstrike
				{ 109, 49497 }, -- Reinforced Thunderstrike
				{ 110, 49493 }, -- Rifled Blastershot Launcher
				{ 111, 49490 }, -- Antediluvian Cornerstone Grimoire
				{ 116, 49644 }, -- Head of Onyxia
				{ 117, 49485 }, -- Sparkling Onyxia Tooth Pendant
				{ 118, 49486 }, -- Polished Dragonslayer's Signet
				{ 119, 49487 }, -- Purified Onyxia Blood Talisman
				{ 121, 49295 }, -- Enlarged Onyxia Hide Backpack
				{ 122, 49294 }, -- Ashen Sack of Gems
				{ 124, 49636,   "mount" }, -- Reins of the Onyxian Drake
				{ 126, "ac4397" },
				{ 127, "ac4406" },
				{ 128, "ac4405" },
				{ 129, "ac4407" },
			},
		},
	}
}

data["TheEyeOfEternity"] = {
	EncounterJournalID = 756,
	MapID = 141,
	AtlasMapID = "TheEyeOfEternity",
	ContentType = RAID_CONTENT,
	items = {
		{ --Malygos
			EncounterJournalID = 1617,
			[NORMAL_RAID_DIFF] = {
				{ 1,  40526 }, -- Gown of the Spell-Weaver
				{ 2,  40519 }, -- Footsteps of Malygos
				{ 3,  40511 }, -- Focusing Energy Epaulets
				{ 4,  40486 }, -- Necklace of the Glittering Chamber
				{ 5,  40474 }, -- Surge Needle Ring
				{ 6,  40491 }, -- Hailstorm
				{ 7,  40488 }, -- Ice Spire Scepter
				{ 8,  40489 }, -- Greatstaff of the Nexus
				{ 9,  40497 }, -- Black Ice
				{ 10, 40475 }, -- Barricade of Eternity
				{ 16, 44650 }, -- Heart of Magic
				{ 17, 44658 }, -- Chain of the Ancient Wyrm
				{ 18, 44660 }, -- Drakescale Collar
				{ 19, 44659 }, -- Pendant of the Dragonsworn
				{ 20, 44657 }, -- Torque of the Red Dragonflight
				{ 22, 43952,   "mount" }, -- Reins of the Azure Drake
				{ 23, 43953,   "mount" }, -- Reins of the Blue Drake
				{ 25, "ac622" },
				{ 26, "ac1658" },
				{ 27, "ac1869" },
				{ 28, "ac2148" },
				{ 29, "ac1874" },
			},
			[P25_DIFF] = {
				{ 1,   40562 }, -- Hood of Rationality
				{ 2,   40555 }, -- Mantle of Dissemination
				{ 3,   40194 }, -- Blanketing Robes of Snow
				{ 4,   40561 }, -- Leash of Heedless Magic
				{ 5,   40560 }, -- Leggings of the Wanton Spellcaster
				{ 6,   40558 }, -- Arcanic Tramplers
				{ 7,   40594 }, -- Spaulders of Catatonia
				{ 8,   40539 }, -- Chestguard of the Recluse
				{ 9,   40541 }, -- Frosted Adroit Handguards
				{ 10,  40566 }, -- Unravelling Strands of Sanity
				{ 11,  40543 }, -- Blue Aspect Helm
				{ 12,  40588 }, -- Tunic of the Artifact Guardian
				{ 13,  40564 }, -- Winter Spectacle Gloves
				{ 14,  40549 }, -- Boots of the Renewed Flight
				{ 15,  40590 }, -- Elevated Lair Pauldrons
				{ 16,  40589 }, -- Legplates of Sovereignty
				{ 17,  40592 }, -- Boots of Healing Energies
				{ 18,  40591 }, -- Melancholy Sabatons
				{ 20,  40532 }, -- Living Ice Crystals
				{ 21,  40531 }, -- Mark of Norgannon
				{ 23,  43952,   "mount" }, -- Reins of the Azure Drake
				{ 24,  43953,   "mount" }, -- Reins of the Blue Drake
				{ 26,  44651 }, -- Heart of Magic
				{ 27,  44664 }, -- Favor of the Dragon Queen
				{ 28,  44662 }, -- Life-Binder's Locket
				{ 29,  44665 }, -- Nexus War Champion Beads
				{ 30,  44661 }, -- Wyrmrest Necklace of Power
				{ 101, "ac623" },
				{ 102, "ac1658" },
				{ 103, "ac1870" },
				{ 104, "ac2149" },
				{ 105, "ac1875" },
			},
		},
		WOTLK_RAID1_10_AC_TABLE,
		WOTLK_RAID1_25_AC_TABLE,
	}
}

data["ObsidianSanctum"] = {
	EncounterJournalID = 755,
	MapID = 155,
	AtlasMapID = "ObsidianSanctum",
	ContentType = RAID_CONTENT,
	items = {
		{ --Sartharion
			EncounterJournalID = 1616,
			[NORMAL_RAID_DIFF] = {
				{ 1,   40428 },     -- Titan's Outlook
				{ 2,   40427 },     -- Circle of Arcane Streams
				{ 3,   40426 },     -- Signet of the Accord
				{ 4,   40430 },     -- Majestic Dragon Figurine
				{ 5,   40429 },     -- Crimson Steel
				{ 6,   43345 },     -- Dragon Hide Bag
				{ 7,   43347 },     -- Satchel of Spoils
				{ 9,   "INV_Box_01", "ac2049", BONUS_LOOT_LABEL, nil },
				{ 10,  43988 },     -- Gale-Proof Cloak
				{ 11,  43990 },     -- Blade-Scarred Tunic
				{ 12,  43991 },     -- Legguards of Composure
				{ 13,  43989 },     -- Remembrance Girdle
				{ 14,  43992 },     -- Volitant Amulet
				{ 16,  40613 },     -- Gloves of the Lost Conqueror
				{ 17,  40614 },     -- Gloves of the Lost Protector
				{ 18,  40615 },     -- Gloves of the Lost Vanquisher
				{ 20,  "INV_Box_01", "ac2050", BONUS_LOOT_LABEL, nil },
				{ 21,  43995 },     -- Enamored Cowl
				{ 22,  43998 },     -- Chestguard of Flagrant Prowess
				{ 23,  43996 },     -- Sabatons of Firmament
				{ 24,  43994 },     -- Belabored Legplates
				{ 25,  43993 },     -- Greatring of Collision
				{ 27,  "INV_Box_01", "ac2051", BONUS_LOOT_LABEL, nil },
				{ 28,  43986,        "mount" }, -- Reins of the Black Drake
				{ 101, "ac1876" },
				{ 102, "ac1658" },
				{ 103, "ac2047" },
				{ 104, "ac624" },
			},
			[P25_DIFF] = {
				{ 1,   40437 },     -- Concealment Shoulderpads
				{ 2,   40439 },     -- Mantle of the Eternal Sentinel
				{ 3,   40451 },     -- Hyaline Helm of the Sniper
				{ 4,   40438 },     -- Council Chamber Epaulets
				{ 5,   40453 },     -- Chestplate of the Great Aspects
				{ 6,   40446 },     -- Dragon Brood Legguards
				{ 7,   40433 },     -- Wyrmrest Band
				{ 8,   40431 },     -- Fury of the Five Flights
				{ 9,   40432 },     -- Illustration of the Dragon Soul
				{ 10,  40455 },     -- Staff of Restraint
				{ 11,  43345 },     -- Dragon Hide Bag
				{ 12,  43346 },     -- Large Satchel of Spoils
				{ 13,  40628 },     -- Gauntlets of the Lost Conqueror
				{ 14,  40629 },     -- Gauntlets of the Lost Protector
				{ 15,  40630 },     -- Gauntlets of the Lost Vanquisher
				{ 16,  "INV_Box_01", "ac2052", BONUS_LOOT_LABEL, nil },
				{ 17,  44002 },     -- The Sanctum's Flowing Vestments
				{ 18,  44003 },     -- Upstanding Spaulders
				{ 19,  44004 },     -- Bountiful Gauntlets
				{ 20,  44000 },     -- Dragonstorm Breastplate
				{ 22,  "INV_Box_01", "ac2053", BONUS_LOOT_LABEL, nil },
				{ 23,  44005 },     -- Pennant Cloak
				{ 24,  44008 },     -- Unsullied Cuffs
				{ 25,  44007 },     -- Headpiece of Reconciliation
				{ 26,  44011 },     -- Leggings of the Honored
				{ 27,  44006 },     -- Obsidian Greathelm
				{ 29,  "INV_Box_01", "ac2054", BONUS_LOOT_LABEL, nil },
				{ 30,  43954,        "mount" }, -- Reins of the Twilight Drake
				{ 101, "ac625" },
				{ 102, "ac1658" },
				{ 103, "ac2048" },
				{ 104, "ac1877" },
			},
		},
		{ --Tier 7 Sets
			name = format(AL["Tier %d Sets"], 7),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
		},
		WOTLK_RAID1_10_AC_TABLE,
		WOTLK_RAID1_25_AC_TABLE,
	}
}

data["RubySanctum"] = {
	EncounterJournalID = 761,
	MapID = 200,
	AtlasMapID = "RubySanctum",
	ContentType = RAID_CONTENT,
	items = {
		{ --Halion
			EncounterJournalID = 1652,
			[NORMAL_RAID_DIFF] = {
				{ 1,  53115 }, -- Abduction's Cover
				{ 2,  53118 }, -- Misbegotten Belt
				{ 3,  53114 }, -- Gloaming Sark
				{ 4,  53117 }, -- Changeling Gloves
				{ 5,  53113 }, -- Twilight Scale Shoulders
				{ 6,  53119 }, -- Boots of Divided Being
				{ 7,  53112 }, -- Bracers of the Heir
				{ 8,  53121 }, -- Surrogate Belt
				{ 9,  53111 }, -- Scion's Treads
				{ 16, 53103 }, -- Baltharus' Gift
				{ 17, 53116 }, -- Saviana's Tribute
				{ 18, 53110 }, -- Zarithrian's Offering
				{ 20, "ac4817" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  54556 }, -- Abduction's Cover
				{ 2,  54562 }, -- Misbegotten Belt
				{ 3,  54561 }, -- Gloaming Sark
				{ 4,  54560 }, -- Changeling Gloves
				{ 5,  54566 }, -- Twilight Scale Shoulders
				{ 6,  54558 }, -- Boots of Divided Being
				{ 7,  54559 }, -- Bracers of the Heir
				{ 8,  54565 }, -- Surrogate Belt
				{ 9,  54564 }, -- Scion's Treads
				{ 16, 54557 }, -- Baltharus' Gift
				{ 17, 54563 }, -- Saviana's Tribute
				{ 18, 54567 }, -- Zarithrian's Offering
				{ 20, "ac4818" },
			},
			[P25_DIFF] = {
				{ 1,  53489 }, -- Cloak of Burning Dusk
				{ 2,  53486 }, -- Bracers of Fiery Night
				{ 3,  53134 }, -- Phaseshifter's Bracers
				{ 4,  53126 }, -- Umbrage Armbands
				{ 5,  53488 }, -- Split Shape Belt
				{ 6,  53127 }, -- Returning Footfalls
				{ 7,  53125 }, -- Apocalypse's Advance
				{ 8,  53487 }, -- Foreshadow Steps
				{ 9,  53129 }, -- Treads of Impending Resurrection
				{ 16, 53132 }, -- Penumbra Pendant
				{ 17, 53490 }, -- Ring of Phased Regeneration
				{ 18, 53133 }, -- Signet of Twilight
				{ 19, 54572 }, -- Charred Twilight Scale
				{ 20, 54573 }, -- Glowing Twilight Scale
				{ 21, 54571 }, -- Petrified Twilight Scale
				{ 22, 54569 }, -- Sharpened Twilight Scale
				{ 24, "ac4815" },
			},
			[P25H_DIFF] = {
				{ 1,  54583 }, -- Cloak of Burning Dusk
				{ 2,  54582 }, -- Bracers of Fiery Night
				{ 3,  54584 }, -- Phaseshifter's Bracers
				{ 4,  54580 }, -- Umbrage Armbands
				{ 5,  54587 }, -- Split Shape Belt
				{ 6,  54577 }, -- Returning Footfalls
				{ 7,  54578 }, -- Apocalypse's Advance
				{ 8,  54586 }, -- Foreshadow Steps
				{ 9,  54579 }, -- Treads of Impending Resurrection
				{ 16, 54581 }, -- Penumbra Pendant
				{ 17, 54585 }, -- Ring of Phased Regeneration
				{ 18, 54576 }, -- Signet of Twilight
				{ 19, 54588 }, -- Charred Twilight Scale
				{ 20, 54589 }, -- Glowing Twilight Scale
				{ 21, 54591 }, -- Petrified Twilight Scale
				{ 22, 54590 }, -- Sharpened Twilight Scale
				{ 24, "ac4816" },
			},
		},
	}
}

data["TrialoftheCrusader"] = {
	EncounterJournalID = 757,
	MapID = 172,
	AtlasMapID = "TrialOfTheCrusader",
	ContentType = RAID_CONTENT,
	items = {
		{ --TrialoftheCrusader NorthrendBeasts
			EncounterJournalID = 1618,
			[NORMAL_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47617, [ATLASLOOT_IT_HORDE] = 47855 }, -- Icehowl Cinch / Icehowl Binding
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47613, [ATLASLOOT_IT_HORDE] = 47857 }, -- Shoulderpads of the Glacial Wilds / Pauldrons of the Glacial Wilds
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47608, [ATLASLOOT_IT_HORDE] = 47853 }, -- Acidmaw Boots / Acidmaw Treads
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47616, [ATLASLOOT_IT_HORDE] = 47860 }, -- Shoulderguards of the Spirit Walker / Pauldrons of the Spirit Walker
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47610, [ATLASLOOT_IT_HORDE] = 47850 }, -- Armbands of the Northern Stalker / Bracers of the Northern Stalker
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47611, [ATLASLOOT_IT_HORDE] = 47852 }, -- Dreadscale Armguards / Dreadscale Bracers
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47609, [ATLASLOOT_IT_HORDE] = 47851 }, -- Gauntlets of Rising Anger / Gauntlets of Mounting Anger
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47615, [ATLASLOOT_IT_HORDE] = 47859 }, -- Belt of the Frozen Reach / Belt of the Impaler
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47614, [ATLASLOOT_IT_HORDE] = 47858 }, -- Girdle of the Impaler / Girdle of the Frozen Reach
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47607, [ATLASLOOT_IT_HORDE] = 47849 }, -- Collar of Ceaseless Torment / Collar of Unending Torment
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47578, [ATLASLOOT_IT_HORDE] = 47854 }, -- Carnivorous Band / Gormok's Band
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47612, [ATLASLOOT_IT_HORDE] = 47856 }, -- Rod of Imprisoned Souls / Scepter of Imprisoned Souls
				{ 21, 142083,                          "pet1952" },        -- Giant Worm Egg -> Dreadmaw
				{ 22, 142084,                          "pet1953" },        -- Magnataur Hunting Horn -> Snobold Runt
				{ 24, "ac3936" },
				{ 25, "ac3797" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47921, [ATLASLOOT_IT_HORDE] = 47994 }, -- Icehowl Cinch / Icehowl Binding
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47923, [ATLASLOOT_IT_HORDE] = 47996 }, -- Shoulderpads of the Glacial Wilds / Pauldrons of the Glacial Wilds
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47919, [ATLASLOOT_IT_HORDE] = 47992 }, -- Acidmaw Boots / Acidmaw Treads
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47926, [ATLASLOOT_IT_HORDE] = 47999 }, -- Shoulderguards of the Spirit Walker / Pauldrons of the Spirit Walker
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47916, [ATLASLOOT_IT_HORDE] = 47989 }, -- Armbands of the Northern Stalker / Bracers of the Northern Stalker
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47918, [ATLASLOOT_IT_HORDE] = 47991 }, -- Dreadscale Armguards / Dreadscale Bracers
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47917, [ATLASLOOT_IT_HORDE] = 47990 }, -- Gauntlets of Rising Anger / Gauntlets of Mounting Anger
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47924, [ATLASLOOT_IT_HORDE] = 47998 }, -- Belt of the Frozen Reach / Belt of the Impaler
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47925, [ATLASLOOT_IT_HORDE] = 47997 }, -- Girdle of the Impaler / Girdle of the Frozen Reach
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47915, [ATLASLOOT_IT_HORDE] = 47988 }, -- Collar of Ceaseless Torment / Collar of Unending Torment
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47920, [ATLASLOOT_IT_HORDE] = 47993 }, -- Carnivorous Band / Gormok's Band
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47922, [ATLASLOOT_IT_HORDE] = 47995 }, -- Rod of Imprisoned Souls / Scepter of Imprisoned Souls
				{ 21, 142083,                          "pet1952" },        -- Giant Worm Egg --> Dreadmaw
				{ 22, 142084,                          "pet1953" },        -- Magnataur Hunting Horn -> Snobold Runt
				{ 24, "ac3936" },
				{ 25, "ac3797" },
			},
			[P25_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 46970, [ATLASLOOT_IT_HORDE] = 47257 }, -- Drape of the Untamed Predator / Cloak of the Untamed Predator
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 46976, [ATLASLOOT_IT_HORDE] = 47256 }, -- Shawl of the Refreshing Winds / Drape of the Refreshing Winds
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 46992, [ATLASLOOT_IT_HORDE] = 47264 }, -- Flowing Vestments of Ascent / Flowing Robes of Ascent
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 46972, [ATLASLOOT_IT_HORDE] = 47258 }, -- Cord of the Tenebrous Mist / Belt of the Tenebrous Mist
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 46974, [ATLASLOOT_IT_HORDE] = 47259 }, -- Leggings of the Broken Beast / Legwraps of the Broken Beast
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 46988, [ATLASLOOT_IT_HORDE] = 47262 }, -- Boots of the Unrelenting Storm / Boots of the Harsh Winter
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 46960, [ATLASLOOT_IT_HORDE] = 47251 }, -- Breastplate of Cruel Intent / Cuirass of Cruel Intent
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 46990, [ATLASLOOT_IT_HORDE] = 47265 }, -- Belt of the Ice Burrower / Binding of the Ice Burrower
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 46962, [ATLASLOOT_IT_HORDE] = 47254 }, -- Chestplate of the Towering Monstrosity / Hauberk of the Towering Monstrosity
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 46961, [ATLASLOOT_IT_HORDE] = 47253 }, -- Boneshatter Armplates / Boneshatter Vambraces
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 46985, [ATLASLOOT_IT_HORDE] = 47263 }, -- Boots of the Courageous / Sabatons of the Courageous
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 46959, [ATLASLOOT_IT_HORDE] = 47252 }, -- Band of the Violent Temperment / Ring of the Violent Temperament
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 46979, [ATLASLOOT_IT_HORDE] = 47261 }, -- Blade of Tarasque / Barb of Tarasque
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 46958, [ATLASLOOT_IT_HORDE] = 47255 }, -- Steel Bladebreaker / Stygian Bladebreaker
				{ 22, [ATLASLOOT_IT_ALLIANCE] = 46963, [ATLASLOOT_IT_HORDE] = 47260 }, -- Crystal Plated Vanguard / Forlorn Barrier
				{ 24, 142083,                          "pet1952" },        -- Giant Worm Egg --> Dreadmaw
				{ 25, 142084,                          "pet1953" },        -- Magnataur Hunting Horn -> Snobold Runt
				{ 27, "ac3937" },
				{ 28, "ac3813" },
			},
			[P25H_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 46971, [ATLASLOOT_IT_HORDE] = 47418 }, -- Drape of the Untamed Predator / Cloak of the Untamed Predator
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 46977, [ATLASLOOT_IT_HORDE] = 47417 }, -- Shawl of the Refreshing Winds / Drape of the Refreshing Winds
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 46993, [ATLASLOOT_IT_HORDE] = 47425 }, -- Flowing Vestments of Ascent / Flowing Robes of Ascent
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 46973, [ATLASLOOT_IT_HORDE] = 47419 }, -- Cord of the Tenebrous Mist / Belt of the Tenebrous Mist
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 46975, [ATLASLOOT_IT_HORDE] = 47420 }, -- Leggings of the Broken Beast / Legwraps of the Broken Beast
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 46989, [ATLASLOOT_IT_HORDE] = 47423 }, -- Boots of the Unrelenting Storm / Boots of the Harsh Winter
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 46965, [ATLASLOOT_IT_HORDE] = 47412 }, -- Breastplate of Cruel Intent / Cuirass of Cruel Intent
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 46991, [ATLASLOOT_IT_HORDE] = 47426 }, -- Belt of the Ice Burrower / Binding of the Ice Burrower
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 46968, [ATLASLOOT_IT_HORDE] = 47415 }, -- Chestplate of the Towering Monstrosity / Hauberk of the Towering Monstrosity
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 46967, [ATLASLOOT_IT_HORDE] = 47414 }, -- Boneshatter Armplates / Boneshatter Vambraces
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 46986, [ATLASLOOT_IT_HORDE] = 47424 }, -- Boots of the Courageous / Sabatons of the Courageous
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 46966, [ATLASLOOT_IT_HORDE] = 47413 }, -- Band of the Violent Temperment / Ring of the Violent Temperament
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 46980, [ATLASLOOT_IT_HORDE] = 47422 }, -- Blade of Tarasque / Barb of Tarasque
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 46969, [ATLASLOOT_IT_HORDE] = 47416 }, -- Steel Bladebreaker / Stygian Bladebreaker
				{ 22, [ATLASLOOT_IT_ALLIANCE] = 46964, [ATLASLOOT_IT_HORDE] = 47421 }, -- Crystal Plated Vanguard / Forlorn Barrier
				{ 24, 142083,                          "pet1952" },        -- Giant Worm Egg --> Dreadmaw
				{ 25, 142084,                          "pet1953" },        -- Magnataur Hunting Horn -> Snobold Runt
				{ 27, "ac3937" },
				{ 28, "ac3813" },
			},
		},
		{ --TrialoftheCrusader LordJaraxxus
			EncounterJournalID = 1619,
			[NORMAL_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47663, [ATLASLOOT_IT_HORDE] = 47861 }, -- Felspark Bindings / Felspark Bracers
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47620, [ATLASLOOT_IT_HORDE] = 47865 }, -- Leggings of the Demonic Messenger / Legwraps of the Demonic Messenger
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47669, [ATLASLOOT_IT_HORDE] = 47863 }, -- Belt of the Winter Solstice / Belt of the Bloodhoof Emissary
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47621, [ATLASLOOT_IT_HORDE] = 47866 }, -- Girdle of the Farseer / Darkspear Ritual Binding
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 49235, [ATLASLOOT_IT_HORDE] = 49236 }, -- Boots of Tortured Space / Sabatons of Tortured Space
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47683, [ATLASLOOT_IT_HORDE] = 47867 }, -- Sentinel Scouting Greaves / Warsong Poacher's Greaves
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47680, [ATLASLOOT_IT_HORDE] = 47869 }, -- Armguards of the Nether Lord / Armplates of the Nether Lord
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47711, [ATLASLOOT_IT_HORDE] = 47870 }, -- Girdle of the Nether Champion / Belt of the Nether Champion
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47619, [ATLASLOOT_IT_HORDE] = 47872 }, -- Amulet of Binding Elements / Fortitude of the Infernal
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47679, [ATLASLOOT_IT_HORDE] = 47864 }, -- Endurance of the Infernal / Pendant of Binding Elements
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47618, [ATLASLOOT_IT_HORDE] = 47862 }, -- Firestorm Ring / Firestorm Band
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47703, [ATLASLOOT_IT_HORDE] = 47868 }, -- Planestalker Signet / Planestalker Band
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 47676, [ATLASLOOT_IT_HORDE] = 47871 }, -- Dirk of the Night Watch / Orcish Deathblade
				{ 23, "ac3996" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47927, [ATLASLOOT_IT_HORDE] = 48000 }, -- Felspark Bindings / Felspark Bracers
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47931, [ATLASLOOT_IT_HORDE] = 48004 }, -- Leggings of the Demonic Messenger / Legwraps of the Demonic Messenger
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47929, [ATLASLOOT_IT_HORDE] = 48002 }, -- Belt of the Winter Solstice / Belt of the Bloodhoof Emissary
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47932, [ATLASLOOT_IT_HORDE] = 48005 }, -- Girdle of the Farseer / Darkspear Ritual Binding
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 49238, [ATLASLOOT_IT_HORDE] = 49237 }, -- Boots of Tortured Space / Sabatons of Tortured Space
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47933, [ATLASLOOT_IT_HORDE] = 48006 }, -- Sentinel Scouting Greaves / Warsong Poacher's Greaves
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47935, [ATLASLOOT_IT_HORDE] = 48008 }, -- Armguards of the Nether Lord / Armplates of the Nether Lord
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47937, [ATLASLOOT_IT_HORDE] = 48009 }, -- Girdle of the Nether Champion / Belt of the Nether Champion
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47930, [ATLASLOOT_IT_HORDE] = 48011 }, -- Amulet of Binding Elements / Fortitude of the Infernal
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47939, [ATLASLOOT_IT_HORDE] = 48003 }, -- Endurance of the Infernal / Pendant of Binding Elements
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47928, [ATLASLOOT_IT_HORDE] = 48001 }, -- Firestorm Ring / Firestorm Band
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47934, [ATLASLOOT_IT_HORDE] = 48007 }, -- Planestalker Signet / Planestalker Band
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 47938, [ATLASLOOT_IT_HORDE] = 48010 }, -- Dirk of the Night Watch / Orcish Deathblade
				{ 23, "ac3996" },
			},
			[P25_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47042, [ATLASLOOT_IT_HORDE] = 47275 }, -- Pride of the Eredar / Pride of the Demon Lord
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47051, [ATLASLOOT_IT_HORDE] = 47274 }, -- Leggings of the Soothing Touch / Pants of the Soothing Touch
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47000, [ATLASLOOT_IT_HORDE] = 47270 }, -- Cuirass of Calamitous Fate / Vest of Calamitous Fate
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47055, [ATLASLOOT_IT_HORDE] = 47277 }, -- Bracers of the Autumn Willow / Bindings of the Autumn Willow
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47056, [ATLASLOOT_IT_HORDE] = 47280 }, -- Bracers of Cloudy Omen / Wristwraps of Cloudy Omen
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 46999, [ATLASLOOT_IT_HORDE] = 47268 }, -- Bloodbath Belt / Bloodbath Girdle
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47057, [ATLASLOOT_IT_HORDE] = 47279 }, -- Legplates of Failing Light / Leggings of Failing Light
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47052, [ATLASLOOT_IT_HORDE] = 47273 }, -- Legguards of Feverish Dedication / Legplates of Feverish Dedication
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 46997, [ATLASLOOT_IT_HORDE] = 47269 }, -- Dawnbreaker Greaves / Dawnbreaker Sabatons
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47043, [ATLASLOOT_IT_HORDE] = 47272 }, -- Charge of the Demon Lord / Charge of the Eredar
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47223, [ATLASLOOT_IT_HORDE] = 47278 }, -- Ring of the Darkmender / Circle of the Darkmender
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 47041, [ATLASLOOT_IT_HORDE] = 47271 }, -- Solace of the Defeated / Solace of the Fallen
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 47053, [ATLASLOOT_IT_HORDE] = 47276 }, -- Symbol of Transgression / Talisman of Heedless Sins
				{ 23, [ATLASLOOT_IT_ALLIANCE] = 46996, [ATLASLOOT_IT_HORDE] = 47266 }, -- Lionhead Slasher / Blood Fury
				{ 24, [ATLASLOOT_IT_ALLIANCE] = 46994, [ATLASLOOT_IT_HORDE] = 47267 }, -- Talonstrike / Death's Head Crossbow
				{ 26, "ac3997" },
			},
			[P25H_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47063, [ATLASLOOT_IT_HORDE] = 47436 }, -- Pride of the Eredar / Pride of the Demon Lord
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47062, [ATLASLOOT_IT_HORDE] = 47435 }, -- Leggings of the Soothing Touch / Pants of the Soothing Touch
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47004, [ATLASLOOT_IT_HORDE] = 47431 }, -- Cuirass of Calamitous Fate / Vest of Calamitous Fate
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47066, [ATLASLOOT_IT_HORDE] = 47438 }, -- Bracers of the Autumn Willow / Bindings of the Autumn Willow
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47068, [ATLASLOOT_IT_HORDE] = 47441 }, -- Bracers of Cloudy Omen / Wristwraps of Cloudy Omen
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47002, [ATLASLOOT_IT_HORDE] = 47429 }, -- Bloodbath Belt / Bloodbath Girdle
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47067, [ATLASLOOT_IT_HORDE] = 47440 }, -- Legplates of Failing Light / Leggings of Failing Light
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47061, [ATLASLOOT_IT_HORDE] = 47434 }, -- Legguards of Feverish Dedication / Legplates of Feverish Dedication
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47003, [ATLASLOOT_IT_HORDE] = 47430 }, -- Dawnbreaker Greaves / Dawnbreaker Sabatons
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47060, [ATLASLOOT_IT_HORDE] = 47433 }, -- Charge of the Demon Lord / Charge of the Eredar
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47224, [ATLASLOOT_IT_HORDE] = 47439 }, -- Ring of the Darkmender / Circle of the Darkmender
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 47059, [ATLASLOOT_IT_HORDE] = 47432 }, -- Solace of the Defeated / Solace of the Fallen
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 47064, [ATLASLOOT_IT_HORDE] = 47437 }, -- Symbol of Transgression / Talisman of Heedless Sins
				{ 23, [ATLASLOOT_IT_ALLIANCE] = 47001, [ATLASLOOT_IT_HORDE] = 47427 }, -- Lionhead Slasher / Blood Fury
				{ 24, [ATLASLOOT_IT_ALLIANCE] = 46995, [ATLASLOOT_IT_HORDE] = 47428 }, -- Talonstrike / Death's Head Crossbow
				{ 26, "ac3997" },
			},
		},
		{ --TrialoftheCrusader FactionChampions
			name = AL["Faction Champions"],
			[NORMAL_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47721, [ATLASLOOT_IT_HORDE] = 47873 }, -- Sandals of the Silver Magus / Sunreaver Magus' Sandals
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47719, [ATLASLOOT_IT_HORDE] = 47878 }, -- Gloves of the Silver Assassin / Sunreaver Assassin's Gloves
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47718, [ATLASLOOT_IT_HORDE] = 47875 }, -- Helm of the Silver Ranger / Sunreaver Ranger's Helm
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47717, [ATLASLOOT_IT_HORDE] = 47876 }, -- Faceplate of the Silver Champion / Sunreaver Champion's Faceplate
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47720, [ATLASLOOT_IT_HORDE] = 47877 }, -- Pauldrons of the Silver Defender / Sunreaver Defender's Pauldrons
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47728, [ATLASLOOT_IT_HORDE] = 47880 }, -- Binding Light / Binding Stone
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47727, [ATLASLOOT_IT_HORDE] = 47882 }, -- Fervor of the Frostborn / Eitrigg's Oath
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47726, [ATLASLOOT_IT_HORDE] = 47879 }, -- Talisman of Volatile Power / Fetish of Volatile Power
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47725, [ATLASLOOT_IT_HORDE] = 47881 }, -- Victor's Call / Vengeance of the Forsaken
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47724, [ATLASLOOT_IT_HORDE] = 47874 }, -- Blade of the Silver Disciple / Sunreaver Disciple's Blade
				{ 18, "ac3798" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47940, [ATLASLOOT_IT_HORDE] = 48012 }, -- Sandals of the Silver Magus / Sunreaver Magus' Sandals
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47945, [ATLASLOOT_IT_HORDE] = 48017 }, -- Gloves of the Silver Assassin / Sunreaver Assassin's Gloves
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47942, [ATLASLOOT_IT_HORDE] = 48014 }, -- Helm of the Silver Ranger / Sunreaver Ranger's Helm
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47943, [ATLASLOOT_IT_HORDE] = 48015 }, -- Faceplate of the Silver Champion / Sunreaver Champion's Faceplate
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47944, [ATLASLOOT_IT_HORDE] = 48016 }, -- Pauldrons of the Silver Defender / Sunreaver Defender's Pauldrons
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47947, [ATLASLOOT_IT_HORDE] = 48019 }, -- Binding Light / Binding Stone
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47949, [ATLASLOOT_IT_HORDE] = 48021 }, -- Fervor of the Frostborn / Eitrigg's Oath
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47946, [ATLASLOOT_IT_HORDE] = 48018 }, -- Talisman of Volatile Power / Fetish of Volatile Power
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47948, [ATLASLOOT_IT_HORDE] = 48020 }, -- Victor's Call / Vengeance of the Forsaken
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47941, [ATLASLOOT_IT_HORDE] = 48013 }, -- Blade of the Silver Disciple / Sunreaver Disciple's Blade
				{ 18, "ac3798" },
			},
			[P25_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47089, [ATLASLOOT_IT_HORDE] = 47291 }, -- Cloak of Displacement / Shroud of Displacement
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47081, [ATLASLOOT_IT_HORDE] = 47286 }, -- Cord of Biting Cold / Belt of Biting Cold
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47092, [ATLASLOOT_IT_HORDE] = 47293 }, -- Boots of the Mourning Widow / Sandals of the Mourning Widow
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47094, [ATLASLOOT_IT_HORDE] = 47292 }, -- Vestments of the Shattered Fellowship / Robes of the Shattered Fellowship
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47071, [ATLASLOOT_IT_HORDE] = 47284 }, -- Treads of the Icewalker / Icewalker Treads
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47073, [ATLASLOOT_IT_HORDE] = 47281 }, -- Bracers of the Untold Massacre / Bracers of the Silent Massacre
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47083, [ATLASLOOT_IT_HORDE] = 47289 }, -- Legguards of Concealed Hatred / Leggings of Concealed Hatred
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47090, [ATLASLOOT_IT_HORDE] = 47295 }, -- Boots of Tremoring Earth / Sabatons of Tremoring Earth
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47082, [ATLASLOOT_IT_HORDE] = 47288 }, -- Chestplate of the Frostborn Hero / Chestplate of the Frostwolf Hero
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47093, [ATLASLOOT_IT_HORDE] = 47294 }, -- Vambraces of the Broken Bond / Bracers of the Broken Bond
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47072, [ATLASLOOT_IT_HORDE] = 47283 }, -- Girdle of Bloodied Scars / Belt of Bloodied Scars
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47070, [ATLASLOOT_IT_HORDE] = 47282 }, -- Ring of Callous Aggression / Band of Callous Aggression
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47080, [ATLASLOOT_IT_HORDE] = 47290 }, -- Satrina's Impeding Scarab / Juggernaut's Vitality
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 47069, [ATLASLOOT_IT_HORDE] = 47285 }, -- Justicebringer / Dual-blade Butcher
				{ 22, [ATLASLOOT_IT_ALLIANCE] = 47079, [ATLASLOOT_IT_HORDE] = 47287 }, -- Bastion of Purity / Bastion of Resolve
			},
			[P25H_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47095, [ATLASLOOT_IT_HORDE] = 47452 }, -- Cloak of Displacement / Shroud of Displacement
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47084, [ATLASLOOT_IT_HORDE] = 47447 }, -- Cord of Biting Cold / Belt of Biting Cold
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47097, [ATLASLOOT_IT_HORDE] = 47454 }, -- Boots of the Mourning Widow / Sandals of the Mourning Widow
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47096, [ATLASLOOT_IT_HORDE] = 47453 }, -- Vestments of the Shattered Fellowship / Robes of the Shattered Fellowship
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47077, [ATLASLOOT_IT_HORDE] = 47445 }, -- Treads of the Icewalker / Icewalker Treads
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47074, [ATLASLOOT_IT_HORDE] = 47442 }, -- Bracers of the Untold Massacre / Bracers of the Silent Massacre
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47087, [ATLASLOOT_IT_HORDE] = 47450 }, -- Legguards of Concealed Hatred / Leggings of Concealed Hatred
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47099, [ATLASLOOT_IT_HORDE] = 47456 }, -- Boots of Tremoring Earth / Sabatons of Tremoring Earth
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47086, [ATLASLOOT_IT_HORDE] = 47449 }, -- Chestplate of the Frostborn Hero / Chestplate of the Frostwolf Hero
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47098, [ATLASLOOT_IT_HORDE] = 47455 }, -- Vambraces of the Broken Bond / Bracers of the Broken Bond
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47076, [ATLASLOOT_IT_HORDE] = 47444 }, -- Girdle of Bloodied Scars / Belt of Bloodied Scars
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47075, [ATLASLOOT_IT_HORDE] = 47443 }, -- Ring of Callous Aggression / Band of Callous Aggression
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47088, [ATLASLOOT_IT_HORDE] = 47451 }, -- Satrina's Impeding Scarab / Juggernaut's Vitality
				{ 21, [ATLASLOOT_IT_ALLIANCE] = 47078, [ATLASLOOT_IT_HORDE] = 47446 }, -- Justicebringer / Dual-blade Butcher
				{ 22, [ATLASLOOT_IT_ALLIANCE] = 47085, [ATLASLOOT_IT_HORDE] = 47448 }, -- Bastion of Purity / Bastion of Resolve
			},
		},
		{ --TrialoftheCrusader TwinValkyrs
			EncounterJournalID = 1622,
			[NORMAL_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47745, [ATLASLOOT_IT_HORDE] = 47889 }, -- Gloves of Looming Shadow / Looming Shadow Wraps
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 49231, [ATLASLOOT_IT_HORDE] = 49232 }, -- Boots of the Grieving Soul / Sandals of the Grieving Soul
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47746, [ATLASLOOT_IT_HORDE] = 47891 }, -- Helm of the Snowy Grotto / Helm of the High Mesa
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47739, [ATLASLOOT_IT_HORDE] = 47887 }, -- Armor of Shifting Shadows / Vest of Shifting Shadows
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47744, [ATLASLOOT_IT_HORDE] = 47893 }, -- Gloves of the Azure Prophet / Sen'jin Ritualist Gloves
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47738, [ATLASLOOT_IT_HORDE] = 47885 }, -- Sabatons of the Lingering Vortex / Greaves of the Lingering Vortex
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47747, [ATLASLOOT_IT_HORDE] = 47890 }, -- Darkbane Pendant / Darkbane Amulet
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47700, [ATLASLOOT_IT_HORDE] = 47888 }, -- Loop of the Twin Val'kyr / Band of the Twin Val'kyr
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47742, [ATLASLOOT_IT_HORDE] = 47913 }, -- Chalice of Benedictus / Lightbane Focus
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47736, [ATLASLOOT_IT_HORDE] = 47886 }, -- Icefall Blade / Nemesis Blade
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47737, [ATLASLOOT_IT_HORDE] = 47884 }, -- Reckoning / Edge of Agony
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47743, [ATLASLOOT_IT_HORDE] = 47892 }, -- Enlightenment / Illumination
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47740, [ATLASLOOT_IT_HORDE] = 47883 }, -- The Diplomat / Widebarrel Flintlock
				{ 21, "ac3799" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47956, [ATLASLOOT_IT_HORDE] = 48028 }, -- Gloves of Looming Shadow / Looming Shadow Wraps
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 49234, [ATLASLOOT_IT_HORDE] = 49233 }, -- Boots of the Grieving Soul / Sandals of the Grieving Soul
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47959, [ATLASLOOT_IT_HORDE] = 48034 }, -- Helm of the Snowy Grotto / Helm of the High Mesa
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47954, [ATLASLOOT_IT_HORDE] = 48026 }, -- Armor of Shifting Shadows / Vest of Shifting Shadows
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47961, [ATLASLOOT_IT_HORDE] = 48038 }, -- Gloves of the Azure Prophet / Sen'jin Ritualist Gloves
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47952, [ATLASLOOT_IT_HORDE] = 48024 }, -- Sabatons of the Lingering Vortex / Greaves of the Lingering Vortex
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47957, [ATLASLOOT_IT_HORDE] = 48030 }, -- Darkbane Pendant / Darkbane Amulet
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47955, [ATLASLOOT_IT_HORDE] = 48027 }, -- Loop of the Twin Val'kyr / Band of the Twin Val'kyr
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47958, [ATLASLOOT_IT_HORDE] = 48032 }, -- Chalice of Benedictus / Lightbane Focus
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47953, [ATLASLOOT_IT_HORDE] = 48025 }, -- Icefall Blade / Nemesis Blade
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47951, [ATLASLOOT_IT_HORDE] = 48023 }, -- Reckoning / Edge of Agony
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47960, [ATLASLOOT_IT_HORDE] = 48036 }, -- Enlightenment / Illumination
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47950, [ATLASLOOT_IT_HORDE] = 48022 }, -- The Diplomat / Widebarrel Flintlock
				{ 21, "ac3799" },
			},
			[P25_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47126, [ATLASLOOT_IT_HORDE] = 47301 }, -- Skyweaver Robes / Skyweaver Vestments
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47141, [ATLASLOOT_IT_HORDE] = 47306 }, -- Bindings of Dark Essence / Dark Essence Bindings
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47107, [ATLASLOOT_IT_HORDE] = 47308 }, -- Belt of the Merciless Killer / Belt of Pale Thorns
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47140, [ATLASLOOT_IT_HORDE] = 47299 }, -- Cord of Pale Thorns / Belt of the Pitiless Killer
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47106, [ATLASLOOT_IT_HORDE] = 47296 }, -- Sabatons of Ruthless Judgment / Greaves of Ruthless Judgment
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47142, [ATLASLOOT_IT_HORDE] = 47310 }, -- Breastplate of the Frozen Lake / Chestplate of the Frozen Lake
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47108, [ATLASLOOT_IT_HORDE] = 47298 }, -- Bracers of the Shieldmaiden / Armguards of the Shieldmaiden
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47121, [ATLASLOOT_IT_HORDE] = 47304 }, -- Legguards of Ascension / Legplates of Ascension
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47116, [ATLASLOOT_IT_HORDE] = 47307 }, -- The Arbiter's Muse / Cry of the Val'kyr
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47105, [ATLASLOOT_IT_HORDE] = 47305 }, -- The Executioner's Malice / Legionnaire's Gorget
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47139, [ATLASLOOT_IT_HORDE] = 47297 }, -- Wail of the Val'kyr / The Executioner's Vice
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47115, [ATLASLOOT_IT_HORDE] = 47303 }, -- Death's Verdict / Death's Choice
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47138, [ATLASLOOT_IT_HORDE] = 47309 }, -- Chalice of Searing Light / Mystifying Charm
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47104, [ATLASLOOT_IT_HORDE] = 47300 }, -- Twin Spike / Gouge of the Frigid Heart
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47114, [ATLASLOOT_IT_HORDE] = 47302 }, -- Lupine Longstaff / Twin's Pact
				{ 21, "ac3815" },
			},
			[P25H_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47129, [ATLASLOOT_IT_HORDE] = 47462 }, -- Skyweaver Robes / Skyweaver Vestments
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47143, [ATLASLOOT_IT_HORDE] = 47467 }, -- Bindings of Dark Essence / Dark Essence Bindings
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47112, [ATLASLOOT_IT_HORDE] = 47469 }, -- Belt of the Merciless Killer / Belt of Pale Thorns
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47145, [ATLASLOOT_IT_HORDE] = 47460 }, -- Cord of Pale Thorns / Belt of the Pitiless Killer
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47109, [ATLASLOOT_IT_HORDE] = 47457 }, -- Sabatons of Ruthless Judgment / Greaves of Ruthless Judgment
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47147, [ATLASLOOT_IT_HORDE] = 47471 }, -- Breastplate of the Frozen Lake / Chestplate of the Frozen Lake
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47111, [ATLASLOOT_IT_HORDE] = 47459 }, -- Bracers of the Shieldmaiden / Armguards of the Shieldmaiden
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47132, [ATLASLOOT_IT_HORDE] = 47465 }, -- Legguards of Ascension / Legplates of Ascension
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47133, [ATLASLOOT_IT_HORDE] = 47468 }, -- The Arbiter's Muse / Cry of the Val'kyr
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47110, [ATLASLOOT_IT_HORDE] = 47466 }, -- The Executioner's Malice / Legionnaire's Gorget
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47144, [ATLASLOOT_IT_HORDE] = 47458 }, -- Wail of the Val'kyr / The Executioner's Vice
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47131, [ATLASLOOT_IT_HORDE] = 47464 }, -- Death's Verdict / Death's Choice
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47146, [ATLASLOOT_IT_HORDE] = 47470 }, -- Chalice of Searing Light / Mystifying Charm
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47113, [ATLASLOOT_IT_HORDE] = 47461 }, -- Twin Spike / Gouge of the Frigid Heart
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47130, [ATLASLOOT_IT_HORDE] = 47463 }, -- Lupine Longstaff / Twin's Pact
				{ 21, "ac3815" },
			},
		},
		{ --TrialoftheCrusader Anubarak
			EncounterJournalID = 1623,
			[NORMAL_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47838, [ATLASLOOT_IT_HORDE] = 47906 }, -- Vestments of the Sleepless / Robes of the Sleepless
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47837, [ATLASLOOT_IT_HORDE] = 47909 }, -- Cinch of the Undying / Belt of the Eternal
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47832, [ATLASLOOT_IT_HORDE] = 47904 }, -- Spaulders of the Snow Bandit / Shoulderpads of the Snow Bandit
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47813, [ATLASLOOT_IT_HORDE] = 47897 }, -- Helmet of the Crypt Lord / Helm of the Crypt Lord
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47829, [ATLASLOOT_IT_HORDE] = 47901 }, -- Pauldrons of the Timeless Hunter / Pauldrons of the Shadow Hunter
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47811, [ATLASLOOT_IT_HORDE] = 47896 }, -- Chestguard of the Warden / Stoneskin Chestplate
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47836, [ATLASLOOT_IT_HORDE] = 47902 }, -- Legplates of the Immortal Spider / Legplates of Redeemed Blood
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47830, [ATLASLOOT_IT_HORDE] = 47908 }, -- Legplates of the Silver Hand / Sunwalker Legguards
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47810, [ATLASLOOT_IT_HORDE] = 47899 }, -- Crusader's Glory / Ardent Guard
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47814, [ATLASLOOT_IT_HORDE] = 47903 }, -- Westfall Saber / Forsaken Bonecarver
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47808, [ATLASLOOT_IT_HORDE] = 47898 }, -- The Lion's Maw / Frostblade Hatchet
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47809, [ATLASLOOT_IT_HORDE] = 47894 }, -- Argent Resolve / Mace of the Earthborn Chieftain
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47816, [ATLASLOOT_IT_HORDE] = 47905 }, -- The Grinder / Blackhorn Bludgeon
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47834, [ATLASLOOT_IT_HORDE] = 47911 }, -- Fordragon Blades / Anguish
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47815, [ATLASLOOT_IT_HORDE] = 47900 }, -- Cold Convergence / Perdition
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47835, [ATLASLOOT_IT_HORDE] = 47910 }, -- Bulwark of the Royal Guard / Aegis of the Coliseum
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47812, [ATLASLOOT_IT_HORDE] = 47895 }, -- Vigilant Ward / Pride of the Kor'kron
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 47741, [ATLASLOOT_IT_HORDE] = 47907 }, -- Baelgun's Heavy Crossbow / Darkmaw Crossbow
				{ 22, 142085,                          "pet1954" },        -- Nerubian Relic -> Nerubian Swarmer
				{ 24, "ac3917" },
				{ 25, "ac3800" },
			},
			[HEROIC_RAID_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47974, [ATLASLOOT_IT_HORDE] = 48051 }, -- Vestments of the Sleepless / Robes of the Sleepless
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47977, [ATLASLOOT_IT_HORDE] = 48054 }, -- Cinch of the Undying / Belt of the Eternal
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47972, [ATLASLOOT_IT_HORDE] = 48049 }, -- Spaulders of the Snow Bandit / Shoulderpads of the Snow Bandit
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47965, [ATLASLOOT_IT_HORDE] = 48042 }, -- Headpiece of the Crypt Lord / Helm of the Crypt Lord
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47969, [ATLASLOOT_IT_HORDE] = 48046 }, -- Pauldrons of the Timeless Hunter / Pauldrons of the Shadow Hunter
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47964, [ATLASLOOT_IT_HORDE] = 48041 }, -- Chestguard of the Warden / Stoneskin Chestplate
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47976, [ATLASLOOT_IT_HORDE] = 48047 }, -- Legplates of the Immortal Spider / Legplates of Redeemed Blood
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47970, [ATLASLOOT_IT_HORDE] = 48053 }, -- Legplates of the Silver Hand / Sunwalker Legguards
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47967, [ATLASLOOT_IT_HORDE] = 48044 }, -- Crusader's Glory / Ardent Guard
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47971, [ATLASLOOT_IT_HORDE] = 48048 }, -- Westfall Saber / Forsaken Bonecarver
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47966, [ATLASLOOT_IT_HORDE] = 48043 }, -- The Lion's Maw / Frostblade Hatchet
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47962, [ATLASLOOT_IT_HORDE] = 48039 }, -- Argent Resolve / Mace of the Earthborn Chieftain
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47973, [ATLASLOOT_IT_HORDE] = 48050 }, -- The Grinder / Blackhorn Bludgeon
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47979, [ATLASLOOT_IT_HORDE] = 48056 }, -- Fordragon Blades / Anguish
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47968, [ATLASLOOT_IT_HORDE] = 48045 }, -- Cold Convergence / Perdition
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47978, [ATLASLOOT_IT_HORDE] = 48055 }, -- Bulwark of the Royal Guard / Aegis of the Coliseum
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47963, [ATLASLOOT_IT_HORDE] = 48040 }, -- Vigilant Ward / Pride of the Kor'kron
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 47975, [ATLASLOOT_IT_HORDE] = 48052 }, -- Baelgun's Heavy Crossbow / Darkmaw Crossbow
				{ 22, 142085,                          "pet1954" },        -- Nerubian Relic -> Nerubian Swarmer
				{ 24, "ac3917" },
				{ 25, "ac3918" },
				{ 26, "ac3800" },
			},
			[P25_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47225, [ATLASLOOT_IT_HORDE] = 47328 }, -- Maiden's Favor / Maiden's Adoration
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47183, [ATLASLOOT_IT_HORDE] = 47320 }, -- Strength of the Nerub / Might of the Nerub
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47203, [ATLASLOOT_IT_HORDE] = 47324 }, -- Armbands of the Ashen Saint / Bindings of the Ashen Saint
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47235, [ATLASLOOT_IT_HORDE] = 47326 }, -- Gloves of the Lifeless Touch / Handwraps of the Lifeless Touch
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47187, [ATLASLOOT_IT_HORDE] = 47317 }, -- Leggings of the Deepening Void / Breeches of the Deepening Void
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47194, [ATLASLOOT_IT_HORDE] = 47321 }, -- Footpads of the Icy Floe / Boots of the Icy Floe
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47151, [ATLASLOOT_IT_HORDE] = 47313 }, -- Bracers of Dark Determination / Armbands of Dark Determination
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47186, [ATLASLOOT_IT_HORDE] = 47318 }, -- Legwraps of the Awakening / Leggings of the Awakening
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47204, [ATLASLOOT_IT_HORDE] = 47325 }, -- Chestguard of Flowing Elements / Cuirass of Flowing Elements
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47152, [ATLASLOOT_IT_HORDE] = 47311 }, -- Belt of Deathly Dominion / Waistguard of Deathly Dominion
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47184, [ATLASLOOT_IT_HORDE] = 47319 }, -- Legguards of the Lurking Threat / Leggings of the Lurking Threat
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47234, [ATLASLOOT_IT_HORDE] = 47330 }, -- Gloves of Bitter Reprisal / Gauntlets of Bitter Reprisal
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47195, [ATLASLOOT_IT_HORDE] = 47323 }, -- Belt of the Forgotten Martyr / Girdle of the Forgotten Martyr
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47150, [ATLASLOOT_IT_HORDE] = 47312 }, -- Greaves of the 7th Legion / Greaves of the Saronite Citadel
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47054, [ATLASLOOT_IT_HORDE] = 47315 }, -- Band of Deplorable Violence / Band of the Traitor King
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47149, [ATLASLOOT_IT_HORDE] = 47327 }, -- Signet of the Traitor King / Lurid Manifestation
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 47182, [ATLASLOOT_IT_HORDE] = 47316 }, -- Reign of the Unliving / Reign of the Dead
				{ 22, [ATLASLOOT_IT_ALLIANCE] = 47148, [ATLASLOOT_IT_HORDE] = 47314 }, -- Stormpike Cleaver / Hellscream Slicer
				{ 23, [ATLASLOOT_IT_ALLIANCE] = 47193, [ATLASLOOT_IT_HORDE] = 47322 }, -- Misery's End / Suffering's End
				{ 24, [ATLASLOOT_IT_ALLIANCE] = 47233, [ATLASLOOT_IT_HORDE] = 47329 }, -- Archon Glaive / Hellion Glaive
				{ 26, 142085,                          "pet1954" },        -- Nerubian Relic -> Nerubian Swarmer
				{ 27, "ac3916" },
				{ 28, "ac3816" },
			},
			[P25H_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47238, [ATLASLOOT_IT_HORDE] = 47490 }, -- Maiden's Favor / Maiden's Adoration
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47192, [ATLASLOOT_IT_HORDE] = 47481 }, -- Strength of the Nerub / Might of the Nerub
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47208, [ATLASLOOT_IT_HORDE] = 47485 }, -- Armbands of the Ashen Saint / Bindings of the Ashen Saint
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47236, [ATLASLOOT_IT_HORDE] = 47487 }, -- Gloves of the Lifeless Touch / Handwraps of the Lifeless Touch
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47189, [ATLASLOOT_IT_HORDE] = 47478 }, -- Leggings of the Deepening Void / Breeches of the Deepening Void
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47205, [ATLASLOOT_IT_HORDE] = 47482 }, -- Footpads of the Icy Floe / Boots of the Icy Floe
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47155, [ATLASLOOT_IT_HORDE] = 47474 }, -- Bracers of Dark Determination / Armbands of Dark Determination
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47190, [ATLASLOOT_IT_HORDE] = 47479 }, -- Legwraps of the Awakening / Leggings of the Awakening
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47209, [ATLASLOOT_IT_HORDE] = 47486 }, -- Chestguard of Flowing Elements / Cuirass of Flowing Elements
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47153, [ATLASLOOT_IT_HORDE] = 47472 }, -- Belt of Deathly Dominion / Waistguard of Deathly Dominion
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47191, [ATLASLOOT_IT_HORDE] = 47480 }, -- Legguards of the Lurking Threat / Leggings of the Lurking Threat
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47240, [ATLASLOOT_IT_HORDE] = 47492 }, -- Gloves of Bitter Reprisal / Gauntlets of Bitter Reprisal
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47207, [ATLASLOOT_IT_HORDE] = 47484 }, -- Belt of the Forgotten Martyr / Girdle of the Forgotten Martyr
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47154, [ATLASLOOT_IT_HORDE] = 47473 }, -- Greaves of the 7th Legion / Greaves of the Saronite Citadel
				{ 16, 47242 },                                             -- Trophy of the Crusade
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47237, [ATLASLOOT_IT_HORDE] = 47476 }, -- Band of Deplorable Violence / Band of the Traitor King
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47157, [ATLASLOOT_IT_HORDE] = 47489 }, -- Signet of the Traitor King / Lurid Manifestation
				{ 20, [ATLASLOOT_IT_ALLIANCE] = 47188, [ATLASLOOT_IT_HORDE] = 47477 }, -- Reign of the Unliving / Reign of the Dead
				{ 22, [ATLASLOOT_IT_ALLIANCE] = 47156, [ATLASLOOT_IT_HORDE] = 47475 }, -- Stormpike Cleaver / Hellscream Slicer
				{ 23, [ATLASLOOT_IT_ALLIANCE] = 47206, [ATLASLOOT_IT_HORDE] = 47483 }, -- Misery's End / Suffering's End
				{ 24, [ATLASLOOT_IT_ALLIANCE] = 47239, [ATLASLOOT_IT_HORDE] = 47491 }, -- Archon Glaive / Hellion Glaive
				{ 26, 142085,                          "pet1954" },        -- Nerubian Relic -> Nerubian Swarmer
				{ 27, "ac3916" },
				{ 28, "ac3812" },
				{ 30, "ac3816" },
			},
		},
		{ --TrialoftheCrusader Patterns
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 245)..")",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = 47622, [ATLASLOOT_IT_HORDE] = 47640 }, -- Plans: Breastplate of the White Knight (p2 450)
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = 47623, [ATLASLOOT_IT_HORDE] = 47641 }, -- Plans: Saronite Swordbreakers (p2 450)
				{ 3,  [ATLASLOOT_IT_ALLIANCE] = 47627, [ATLASLOOT_IT_HORDE] = 47642 }, -- Plans: Sunforged Bracers (p2 450)
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = 47626, [ATLASLOOT_IT_HORDE] = 47643 }, -- Plans: Sunforged Breastplate (p2 450)
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = 47624, [ATLASLOOT_IT_HORDE] = 47644 }, -- Plans: Titanium Razorplate (p2 450)
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = 47625, [ATLASLOOT_IT_HORDE] = 47645 }, -- Plans: Titanium Spikeguards (p2 450)
				{ 7,  [ATLASLOOT_IT_ALLIANCE] = 47629, [ATLASLOOT_IT_HORDE] = 47646 }, -- Pattern: Black Chitin Bracers (p7 450)
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = 47635, [ATLASLOOT_IT_HORDE] = 47647 }, -- Pattern: Bracers of Swift Death (p7 450)
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 47631, [ATLASLOOT_IT_HORDE] = 47648 }, -- Pattern: Crusader's Dragonscale Bracers (p7 450)
				{ 10, [ATLASLOOT_IT_ALLIANCE] = 47630, [ATLASLOOT_IT_HORDE] = 47649 }, -- Pattern: Crusader's Dragonscale Breastplate (p7 450)
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 47628, [ATLASLOOT_IT_HORDE] = 47650 }, -- Pattern: Ensorcelled Nerubian Breastplate (p7 450)
				{ 12, [ATLASLOOT_IT_ALLIANCE] = 47634, [ATLASLOOT_IT_HORDE] = 47651 }, -- Pattern: Knightbane Carapace (p7 450)
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 47632, [ATLASLOOT_IT_HORDE] = 47652 }, -- Pattern: Lunar Eclipse Chestguard (p7 450)
				{ 14, [ATLASLOOT_IT_ALLIANCE] = 47633, [ATLASLOOT_IT_HORDE] = 47653 }, -- Pattern: Moonshadow Armguards (p7 450)
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 47654, [ATLASLOOT_IT_HORDE] = 47639 }, -- Pattern: Bejeweled Wizard's Bracers (p8 450)
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 47655, [ATLASLOOT_IT_HORDE] = 47638 }, -- Pattern: Merlin's Robe (p8 450)
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 47656, [ATLASLOOT_IT_HORDE] = 47637 }, -- Pattern: Royal Moonshroud Bracers (p8 450)
				{ 19, [ATLASLOOT_IT_ALLIANCE] = 47657, [ATLASLOOT_IT_HORDE] = 47636 }, -- Pattern: Royal Moonshroud Robe (p8 450)
				{ 21, 47556 },                                             -- Crusader Orb
			},
		},
		{ --Tier 9 Sets
			name = format(AL["Tier %d Sets"], 9),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:9",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:9",
			[P25H_DIFF] = "AtlasLoot_Collections:TIERSETS:9",
		},
	}
}

data["Ulduar"] = {
	EncounterJournalID = 759,
	MapID = 147,
	AtlasMapID = "UlduarA",
	ContentType = RAID_CONTENT,
	items = {
		{ --Ulduar Leviathan
			EncounterJournalID = 1637,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45282 }, -- Ironsoul
				{ 2,   45287 }, -- Firesoul
				{ 3,   45132 }, -- Golden Saronite Dragon
				{ 4,   45284 }, -- Kinetic Ripper
				{ 5,   45110 }, -- Titanguard
				{ 6,   45115 }, -- Leviathan Fueling Manual
				{ 7,   45107 }, -- Iron Riveted War Helm
				{ 8,   45289 }, -- Lifespark Visage
				{ 9,   45118 }, -- Steamworker's Goggles
				{ 10,  45116 }, -- Freya's Choker of Warding
				{ 11,  45285 }, -- Might of the Leviathan
				{ 12,  45133 }, -- Pendant of Fiery Havoc
				{ 13,  45300 }, -- Mantle of Fiery Vengeance
				{ 14,  45136 }, -- Shoulderpads of Dormant Energies
				{ 15,  45288 }, -- Firestrider Chestguard
				{ 16,  45291 }, -- Combustion Bracers
				{ 17,  45283 }, -- Flamewatch Armguards
				{ 18,  45108 }, -- Mechanist's Bindings
				{ 19,  45111 }, -- Mimiron's Inferno Couplings
				{ 20,  45117 }, -- Constructor's Handwraps
				{ 21,  45109 }, -- Gloves of the Fiery Behemoth
				{ 22,  45293 }, -- Handguards of Potent Cures
				{ 23,  45119 }, -- Embrace of the Leviathan
				{ 24,  45295 }, -- Gilded Steel Legplates
				{ 25,  45134 }, -- Plated Leggings of Ruination
				{ 26,  45135 }, -- Boots of Fiery Resolution
				{ 27,  45113 }, -- Glowing Ring of Reclamation
				{ 28,  45297 }, -- Shimmering Seal
				{ 29,  45106 }, -- Strength of the Automaton
				{ 30,  45112 }, -- The Leviathan's Coil
				{ 101, 45292 }, -- Energy Siphon
				{ 102, 45286 }, -- Pyrite Infuser
				{ 103, 45038 }, -- Fragment of Val'anyr
				{ 104, 45087 }, -- Runed Orb
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  156012 }, -- Ironsoul
				{ 2,  155924 }, -- Titanguard
				{ 3,  156014 }, -- Kinetic Ripper
				{ 4,  155933 }, -- Golden Saronite Dragon
				{ 5,  156017 }, -- Firesoul
				{ 6,  155928 }, -- Leviathan Fueling Manual
				{ 7,  156019 }, -- Lifespark Visage
				{ 8,  155921 }, -- Iron Riveted War Helm
				{ 9,  155931 }, -- Steamworker's Goggles
				{ 10, 156028 }, -- Mantle of Fiery Vengeance
				{ 11, 155937 }, -- Shoulderpads of Dormant Energies
				{ 12, 156018 }, -- Firestrider Chestguard
				{ 13, 155922 }, -- Mechanist's Bindings
				{ 14, 156020 }, -- Combustion Bracers
				{ 15, 156013 }, -- Flamewatch Armguards
				{ 16, 155925 }, -- Mimiron's Inferno Couplings
				{ 17, 156022 }, -- Handguards of Potent Cures
				{ 18, 155923 }, -- Gloves of the Fiery Behemoth
				{ 19, 155930 }, -- Constructor's Handwraps
				{ 20, 155932 }, -- Embrace of the Leviathan
				{ 21, 155935 }, -- Plated Leggings of Ruination
				{ 22, 156024 }, -- Gilded Steel Legplates
				{ 23, 155936 }, -- Boots of Fiery Resolution
				{ 24, 156021 }, -- Energy Siphon
				{ 25, 156016 }, -- Pyrite Infuser
				{ 26, 45038 }, -- Fragment of Val'anyr
				{ 27, 45087 }, -- Runed Orb
			},
		},
		{ --Ulduar Ignis
			EncounterJournalID = 1638,
			[NORMAL_RAID_DIFF] = {
				{ 1,  45171 }, -- Intensity
				{ 2,  45311 }, -- Relentless Edge
				{ 3,  45165 }, -- Worldcarver
				{ 4,  45309 }, -- Rifle of the Platinum Guard
				{ 5,  45170 }, -- Scepter of Creation
				{ 6,  45314 }, -- Igniter Rod
				{ 7,  45164 }, -- Helm of the Furnace Master
				{ 8,  45321 }, -- Pauldrons of Tempered Will
				{ 9,  45186 }, -- Soot-Covered Mantle
				{ 10, 45318 }, -- Drape of Fuming Anger
				{ 11, 45317 }, -- Shawl of the Caretaker
				{ 12, 45167 }, -- Lifeforge Breastplate
				{ 13, 45316 }, -- Armbraces of the Vibrant Flame
				{ 14, 45187 }, -- Wristguards of the Firetender
				{ 15, 45310 }, -- Gauntlets of the Iron Furnace
				{ 16, 45312 }, -- Gloves of Smoldering Touch
				{ 17, 45185 }, -- Flamewrought Cinch
				{ 18, 45161 }, -- Girdle of Embers
				{ 19, 45166 }, -- Charred Saronite Greaves
				{ 20, 45162 }, -- Flamestalker Boots
				{ 21, 45157 }, -- Cindershard Ring
				{ 22, 45168 }, -- Pyrelight Circle
				{ 23, 45313 }, -- Furnace Stone
				{ 24, 45158 }, -- Heart of Iron
				{ 25, 45038 }, -- Fragment of Val'anyr
				{ 26, 45087 }, -- Runed Orb
				{ 28, 142086, "pet1955" }, -- Red-Hot Coal -> Magma Rageling
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  156039 }, -- Relentless Edge
				{ 2,  155956 }, -- Worldcarver
				{ 3,  155961 }, -- Intensity
				{ 4,  156037 }, -- Rifle of the Platinum Guard
				{ 5,  155960 }, -- Scepter of Creation
				{ 6,  156042 }, -- Igniter Rod
				{ 7,  155955 }, -- Helm of the Furnace Master
				{ 8,  156049 }, -- Pauldrons of Tempered Will
				{ 9,  155963 }, -- Soot-Covered Mantle
				{ 10, 156045 }, -- Shawl of the Caretaker
				{ 11, 156046 }, -- Drape of Fuming Anger
				{ 12, 155958 }, -- Lifeforge Breastplate
				{ 13, 156044 }, -- Armbraces of the Vibrant Flame
				{ 14, 155964 }, -- Wristguards of the Firetender
				{ 15, 156038 }, -- Gauntlets of the Iron Furnace
				{ 16, 156040 }, -- Gloves of Smoldering Touch
				{ 17, 155962 }, -- Flamewrought Cinch
				{ 18, 155953 }, -- Girdle of Embers
				{ 19, 155954 }, -- Flamestalker Boots
				{ 20, 155957 }, -- Charred Saronite Greaves
				{ 21, 156041 }, -- Furnace Stone
				{ 22, 155952 }, -- Heart of Iron
				{ 23, 45038 }, -- Fragment of Val'anyr
				{ 24, 45087 }, -- Runed Orb
				{ 26, 142086, "pet1955" }, -- Red-Hot Coal -> Magma Rageling
			},
		},
		{ --Ulduar Razorscale
			EncounterJournalID = 1639,
			[NORMAL_RAID_DIFF] = {
				{ 1,  45298 }, -- Razorscale Talon
				{ 2,  45142 }, -- Remorse
				{ 3,  45147 }, -- Guiding Star
				{ 4,  45137 }, -- Veranus' Bane
				{ 5,  45299 }, -- Dragonsteel Faceplate
				{ 6,  45150 }, -- Collar of the Wyrmhunter
				{ 7,  45140 }, -- Razorscale Shoulderguards
				{ 8,  45138 }, -- Drape of the Drakerider
				{ 9,  45305 }, -- Breastplate of the Afterlife
				{ 10, 45146 }, -- Shackles of the Odalisque
				{ 11, 45149 }, -- Bracers of the Broodmother
				{ 12, 45301 }, -- Bracers of the Smothering Inferno
				{ 13, 45151 }, -- Belt of the Fallen Wyrm
				{ 14, 45139 }, -- Dragonslayer's Brace
				{ 15, 45306 }, -- Binding of the Dragon Matriarch
				{ 16, 45304 }, -- Stormtempered Girdle
				{ 17, 45143 }, -- Saronite Mesh Legguards
				{ 18, 45141 }, -- Proto-Hide Leggings
				{ 19, 45307 }, -- Ironscale Leggings
				{ 20, 45302 }, -- Treads of the Invader
				{ 21, 45303 }, -- Band of Draconic Guile
				{ 22, 45308 }, -- Eye of the Broodmother
				{ 23, 45148 }, -- Living Flame
				{ 24, 45038 }, -- Fragment of Val'anyr
				{ 25, 45087 }, -- Runed Orb
				{ 27, 142087, "pet1956" }, -- Ironbound Collar -> Ironbound Proto-Whelp
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  155946 }, -- Guiding Star
				{ 2,  156026 }, -- Razorscale Talon
				{ 3,  155943 }, -- Remorse
				{ 4,  155938 }, -- Veranus' Bane
				{ 5,  155949 }, -- Collar of the Wyrmhunter
				{ 6,  156027 }, -- Dragonsteel Faceplate
				{ 7,  155941 }, -- Razorscale Shoulderguards
				{ 8,  155939 }, -- Drape of the Drakerider
				{ 9,  156033 }, -- Breastplate of the Afterlife
				{ 10, 155948 }, -- Bracers of the Broodmother
				{ 11, 156029 }, -- Bracers of the Smothering Inferno
				{ 12, 155945 }, -- Shackles of the Odalisque
				{ 13, 155950 }, -- Belt of the Fallen Wyrm
				{ 14, 156034 }, -- Binding of the Dragon Matriarch
				{ 15, 155940 }, -- Dragonslayer's Brace
				{ 16, 156032 }, -- Stormtempered Girdle
				{ 17, 156035 }, -- Ironscale Leggings
				{ 18, 155942 }, -- Proto-Hide Leggings
				{ 19, 155944 }, -- Saronite Mesh Legguards
				{ 20, 156030 }, -- Treads of the Invader
				{ 21, 156036 }, -- Eye of the Broodmother
				{ 22, 155947 }, -- Living Flame
				{ 23, 45038 }, -- Fragment of Val'anyr
				{ 24, 45087 }, -- Runed Orb
				{ 26, 142087, "pet1956" }, -- Ironbound Collar -> Ironbound Proto-Whelp
			},
		},
		{ --Ulduar Deconstructor
			EncounterJournalID = 1640,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45868 }, -- Aesir's Edge
				{ 2,   45256 }, -- Twisted Visage
				{ 3,   45246 }, -- Golem-Shard Sticker
				{ 4,   45685 }, -- Plasma Foil
				{ 5,   45442 }, -- Sorthalis, Hammer of the Watchers
				{ 6,   45870 }, -- Magnetized Projectile Emitter
				{ 7,   45257 }, -- Quartz Crystal Wand
				{ 8,   45682 }, -- Pulsing Spellshield
				{ 9,   45687 }, -- Helm of Veiled Energies
				{ 10,  45443 }, -- Charm of Meticulous Timing
				{ 11,  45253 }, -- Mantle of Wavering Calm
				{ 12,  45251 }, -- Shoulderplates of the Deconstructor
				{ 13,  45677 }, -- Treacherous Shoulderpads
				{ 14,  45445 }, -- Breastplate of the Devoted
				{ 15,  45867 }, -- Breastplate of the Stoneshaper
				{ 16,  45676 }, -- Chestplate of Vicious Potency
				{ 17,  45259 }, -- Quartz-Studded Harness
				{ 18,  45686 }, -- Vest of the Glowing Crescent
				{ 19,  45680 }, -- Armbands of the Construct
				{ 20,  45869 }, -- Fluxing Energy Coils
				{ 21,  45446 }, -- Grasps of Reason
				{ 22,  45252 }, -- Horologist's Wristguards
				{ 23,  45679 }, -- Gloves of Taut Grip
				{ 24,  45444 }, -- Gloves of the Steady Hand
				{ 25,  45694 }, -- Conductive Cord
				{ 26,  45248 }, -- Clockwork Legplates
				{ 27,  45260 }, -- Boots of Hasty Revival
				{ 28,  45249 }, -- Brass-Lined Boots
				{ 29,  45258 }, -- Sandals of Rash Temperament
				{ 30,  45250 }, -- Crazed Construct Ring
				{ 101, 45675 }, -- Power Enhancing Loop
				{ 102, 45871 }, -- Seal of Ulduar
				{ 103, 45247 }, -- Signet of the Earthshaker
				{ 104, 45038 }, -- Fragment of Val'anyr
				{ 105, 45087 }, -- Runed Orb
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  156290 }, -- Aesir's Edge
				{ 2,  155993 }, -- Twisted Visage
				{ 3,  155985 }, -- Golem-Shard Sticker
				{ 4,  156265 }, -- Plasma Foil
				{ 5,  156164 }, -- Sorthalis, Hammer of the Watchers
				{ 6,  156292 }, -- Magnetized Projectile Emitter
				{ 7,  155994 }, -- Quartz Crystal Wand
				{ 8,  156264 }, -- Pulsing Spellshield
				{ 9,  156267 }, -- Helm of Veiled Energies
				{ 10, 155992 }, -- Mantle of Wavering Calm
				{ 11, 155990 }, -- Shoulderplates of the Deconstructor
				{ 12, 156261 }, -- Treacherous Shoulderpads
				{ 13, 156167 }, -- Breastplate of the Devoted
				{ 14, 156289 }, -- Breastplate of the Stoneshaper
				{ 15, 156260 }, -- Chestplate of Vicious Potency
				{ 16, 155996 }, -- Quartz-Studded Harness
				{ 17, 156266 }, -- Vest of the Glowing Crescent
				{ 18, 156263 }, -- Armbands of the Construct
				{ 19, 156291 }, -- Fluxing Energy Coils
				{ 20, 156168 }, -- Grasps of Reason
				{ 21, 155991 }, -- Horologist's Wristguards
				{ 22, 156262 }, -- Gloves of Taut Grip
				{ 23, 156166 }, -- Gloves of the Steady Hand
				{ 24, 156268 }, -- Conductive Cord
				{ 25, 155987 }, -- Clockwork Legplates
				{ 26, 155997 }, -- Boots of Hasty Revival
				{ 27, 155988 }, -- Brass-Lined Boots
				{ 28, 155995 }, -- Sandals of Rash Temperament
				{ 29, 45038 }, -- Fragment of Val'anyr
				{ 30, 45087 }, -- Runed Orb
			},
		},
		{ --Ulduar IronCouncil, The Assembly of Iron
			EncounterJournalID = 1641,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45234 }, -- Rapture
				{ 2,   45233 }, -- Stormrune Edge
				{ 3,   45607 }, -- Fang of Oblivion
				{ 4,   45448 }, -- Perilous Bite
				{ 5,   45331 }, -- Rune-Etched Nightblade
				{ 6,   45332 }, -- Stormtip
				{ 7,   45449 }, -- The Masticator
				{ 8,   45226 }, -- Ancient Iron Heaume
				{ 9,   45329 }, -- Circlet of True Sight
				{ 10,  45193 }, -- Insurmountable Fervor
				{ 11,  45243 }, -- Sapphire Amulet of Renewal
				{ 12,  45236 }, -- Unblinking Eye
				{ 13,  45447 }, -- Watchful Eye of Fate
				{ 14,  45227 }, -- Iron-Studded Mantle
				{ 15,  45245 }, -- Shoulderpads of the Intruder
				{ 16,  45322 }, -- Cloak of the Iron Council
				{ 17,  45242 }, -- Drape of Mortal Downfall
				{ 18,  45224 }, -- Drape of the Lithe
				{ 19,  45237 }, -- Phaelia's Vestments of the Sprouting Seed
				{ 20,  45240 }, -- Raiments of the Iron Council
				{ 21,  45225 }, -- Steelbreaker's Embrace
				{ 22,  45423 }, -- Runetouch Wristwraps
				{ 23,  45228 }, -- Handguards of the Enclave
				{ 24,  45239 }, -- Runeshaper's Gloves
				{ 25,  45241 }, -- Belt of Colossal Rage
				{ 26,  45455 }, -- Belt of the Crystal Tree
				{ 27,  45333 }, -- Belt of the Iron Servant
				{ 28,  45324 }, -- Leggings of Swift Reflexes
				{ 29,  45238 }, -- Overload Legwraps
				{ 30,  45378 }, -- Boots of the Petrified Forest
				{ 101, 45330 }, -- Greaves of Iron Intensity
				{ 102, 45244 }, -- Greaves of Swift Vengeance
				{ 103, 45232 }, -- Runed Ironhide Boots
				{ 104, 45418 }, -- Lady Maye's Sapphire Ring
				{ 105, 45456 }, -- Loop of the Agile
				{ 106, 45235 }, -- Radiant Seal
				{ 107, 45038 }, -- Fragment of Val'anyr
				{ 108, 45087 }, -- Runed Orb
				{ 110, 142088, "pet1957" }, -- Stormforged Rune -> Runeforged Servitor
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,   155973 }, -- Rapture
				{ 2,   155972 }, -- Stormrune Edge
				{ 3,   156611 }, -- Fang of Oblivion
				{ 4,   156170 }, -- Perilous Bite
				{ 5,   156057 }, -- Rune-Etched Nightblade
				{ 6,   156058 }, -- Stormtip
				{ 7,   156171 }, -- The Masticator
				{ 8,   155968 }, -- Ancient Iron Heaume
				{ 9,   156055 }, -- Circlet of True Sight
				{ 10,  155969 }, -- Iron-Studded Mantle
				{ 11,  155984 }, -- Shoulderpads of the Intruder
				{ 12,  156050 }, -- Cloak of the Iron Council
				{ 13,  155981 }, -- Drape of Mortal Downfall
				{ 14,  155966 }, -- Drape of the Lithe
				{ 15,  155976 }, -- Phaelia's Vestments of the Sprouting Seed
				{ 16,  155979 }, -- Raiments of the Iron Council
				{ 17,  155967 }, -- Steelbreaker's Embrace
				{ 18,  156146 }, -- Runetouch Wristwraps
				{ 19,  155970 }, -- Handguards of the Enclave
				{ 20,  155978 }, -- Runeshaper's Gloves
				{ 21,  155980 }, -- Belt of Colossal Rage
				{ 22,  156177 }, -- Belt of the Crystal Tree
				{ 23,  156059 }, -- Belt of the Iron Servant
				{ 24,  156051 }, -- Leggings of Swift Reflexes
				{ 25,  155977 }, -- Overload Legwraps
				{ 26,  156102 }, -- Boots of the Petrified Forest
				{ 27,  156056 }, -- Greaves of Iron Intensity
				{ 28,  155983 }, -- Greaves of Swift Vengeance
				{ 29,  155971 }, -- Runed Ironhide Boots
				{ 30,  45038 }, -- Fragment of Val'anyr
				{ 101, 45087 }, -- Runed Orb
				{ 103, 142088, "pet1957" }, -- Stormforged Rune -> Runeforged Servitor
			},
		},
		{ --Ulduar Kologarn
			EncounterJournalID = 1642,
			[NORMAL_RAID_DIFF] = {
				{ 1,  45695 }, -- Spire of Withering Dreams
				{ 2,  45266 }, -- Malice
				{ 3,  45700 }, -- Stoneguard
				{ 4,  45261 }, -- Giant's Bane
				{ 5,  45271 }, -- Ironmender
				{ 6,  45696 }, -- Mark of the Unyielding
				{ 7,  45262 }, -- Necklace of Unerring Mettle
				{ 8,  45699 }, -- Pendant of the Piercing Glare
				{ 9,  45697 }, -- Shoulderguards of the Solemn Watch
				{ 10, 45265 }, -- Shoulderpads of the Monolith
				{ 11, 45704 }, -- Shawl of the Shattered Giant
				{ 12, 45272 }, -- Robes of the Umbral Brute
				{ 13, 45275 }, -- Bracers of Unleashed Magic
				{ 14, 45264 }, -- Decimator's Armguards
				{ 15, 45269 }, -- Unfaltering Armguards
				{ 16, 45268 }, -- Gloves of the Pythonic Guardian
				{ 17, 45273 }, -- Handwraps of Plentiful Recovery
				{ 18, 45274 }, -- Leggings of the Stoneweaver
				{ 19, 45267 }, -- Saronite Plated Legguards
				{ 20, 45701 }, -- Greaves of the Earthbinder
				{ 21, 45698 }, -- Sabatons of the Iron Watcher
				{ 22, 45702 }, -- Emerald Signet Ring
				{ 23, 45703 }, -- Spark of Hope
				{ 24, 45263 }, -- Wrathstone
				{ 25, 45038 }, -- Fragment of Val'anyr
				{ 26, 45087 }, -- Runed Orb
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  156269 }, -- Spire of Withering Dreams
				{ 2,  156003 }, -- Malice
				{ 3,  156274 }, -- Stoneguard
				{ 4,  155998 }, -- Giant's Bane
				{ 5,  156007 }, -- Ironmender
				{ 6,  156271 }, -- Shoulderguards of the Solemn Watch
				{ 7,  156002 }, -- Shoulderpads of the Monolith
				{ 8,  156278 }, -- Shawl of the Shattered Giant
				{ 9,  156008 }, -- Robes of the Umbral Brute
				{ 10, 156011 }, -- Bracers of Unleashed Magic
				{ 11, 156001 }, -- Decimator's Armguards
				{ 12, 156006 }, -- Unfaltering Armguards
				{ 13, 156005 }, -- Gloves of the Pythonic Guardian
				{ 14, 156009 }, -- Handwraps of Plentiful Recovery
				{ 15, 156010 }, -- Leggings of the Stoneweaver
				{ 16, 156004 }, -- Saronite Plated Legguards
				{ 17, 156275 }, -- Greaves of the Earthbinder
				{ 18, 156272 }, -- Sabatons of the Iron Watcher
				{ 19, 156277 }, -- Spark of Hope
				{ 20, 156000 }, -- Wrathstone
				{ 21, 45038 }, -- Fragment of Val'anyr
				{ 22, 45087 }, -- Runed Orb
			},
		},
		{ --Ulduar Auriaya
			EncounterJournalID = 1643,
			[NORMAL_RAID_DIFF] = {
				{ 1,  45437 }, -- Runescribed Blade
				{ 2,  45315 }, -- Stonerender
				{ 3,  45713 }, -- Nurturing Touch
				{ 4,  45327 }, -- Siren's Cry
				{ 5,  45707 }, -- Shieldwall of the Breaker
				{ 6,  45864 }, -- Cover of the Keepers
				{ 7,  45435 }, -- Cowl of the Absolute
				{ 8,  45439 }, -- Unwavering Stare
				{ 9,  45440 }, -- Amice of the Stoic Watch
				{ 10, 45711 }, -- Ironaya's Discarded Mantle
				{ 11, 45832 }, -- Mantle of the Preserver
				{ 12, 45320 }, -- Shoulderplates of the Eternal
				{ 13, 45319 }, -- Cloak of the Makers
				{ 14, 45712 }, -- Chestplate of Titanic Fury
				{ 15, 45865 }, -- Raiments of the Corrupted
				{ 16, 45334 }, -- Unbreakable Chestguard
				{ 17, 45325 }, -- Gloves of the Stonereaper
				{ 18, 45709 }, -- Nimble Climber's Belt
				{ 19, 45708 }, -- Archaedas' Lost Legplates
				{ 20, 45434 }, -- Greaves of the Rockmender
				{ 21, 45441 }, -- Sandals of the Ancient Keeper
				{ 22, 45326 }, -- Platinum Band of the Aesir
				{ 23, 45438 }, -- Ring of the Faithful Servant
				{ 24, 45866 }, -- Elemental Focus Stone
				{ 25, 45038 }, -- Fragment of Val'anyr
				{ 26, 45087 }, -- Runed Orb
				{ 28, 142089, "pet1958" }, -- Glittering Ball of Yarn -> Sanctum Cub
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  156159 }, -- Runescribed Blade
				{ 2,  156043 }, -- Stonerender
				{ 3,  156284 }, -- Nurturing Touch
				{ 4,  156054 }, -- Siren's Cry
				{ 5,  156279 }, -- Shieldwall of the Breaker
				{ 6,  156286 }, -- Cover of the Keepers
				{ 7,  156158 }, -- Cowl of the Absolute
				{ 8,  156161 }, -- Unwavering Stare
				{ 9,  156162 }, -- Amice of the Stoic Watch
				{ 10, 156282 }, -- Ironaya's Discarded Mantle
				{ 11, 156285 }, -- Mantle of the Preserver
				{ 12, 156048 }, -- Shoulderplates of the Eternal
				{ 13, 156047 }, -- Cloak of the Makers
				{ 14, 156283 }, -- Chestplate of Titanic Fury
				{ 15, 156287 }, -- Raiments of the Corrupted
				{ 16, 156060 }, -- Unbreakable Chestguard
				{ 17, 156052 }, -- Gloves of the Stonereaper
				{ 18, 156281 }, -- Nimble Climber's Belt
				{ 19, 156280 }, -- Archaedas' Lost Legplates
				{ 20, 156157 }, -- Greaves of the Rockmender
				{ 21, 156163 }, -- Sandals of the Ancient Keeper
				{ 22, 156288 }, -- Elemental Focus Stone
				{ 23, 45038 }, -- Fragment of Val'anyr
				{ 24, 45087 }, -- Runed Orb
				{ 26, 142089, "pet1958" }, -- Glittering Ball of Yarn -> Sanctum Cub
			},
		},
		{ --Ulduar Hodir
			EncounterJournalID = 1644,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45886 }, -- Icecore Staff
				{ 2,   45457 }, -- Staff of Endless Winter
				{ 3,   45458 }, -- Stormedge
				{ 4,   45612 }, -- Constellus
				{ 5,   45876 }, -- Shiver
				{ 6,   45872 }, -- Avalanche
				{ 7,   45887 }, -- Ice Layered Barrier
				{ 8,   45450 }, -- Northern Barrier
				{ 9,   45877 }, -- The Boreal Guard
				{ 10,  45464 }, -- Cowl of Icy Breaths
				{ 11,  45459 }, -- Frigid Strength of Hodir
				{ 12,  45461 }, -- Drape of Icy Intent
				{ 13,  45873 }, -- Winter's Frigid Embrace
				{ 14,  45453 }, -- Winter's Icy Embrace
				{ 15,  45460 }, -- Bindings of Winter Gale
				{ 16,  45888 }, -- Bitter Cold Armguards
				{ 17,  45454 }, -- Frost-Bound Chain Bracers
				{ 18,  45462 }, -- Gloves of the Frozen Glade
				{ 19,  45452 }, -- Frostplate Greaves
				{ 20,  45451 }, -- Frozen Loop
				{ 21,  45874 }, -- Signet of Winter
				{ 22,  45632 }, -- Breastplate of the Wayward Conqueror
				{ 23,  45633 }, -- Breastplate of the Wayward Protector
				{ 24,  45634 }, -- Breastplate of the Wayward Vanquisher
				{ 25,  45650 }, -- Leggings of the Wayward Conqueror
				{ 26,  45651 }, -- Leggings of the Wayward Protector
				{ 27,  45652 }, -- Leggings of the Wayward Vanquisher
				{ 28,  45038 }, -- Fragment of Val'anyr
				{ 29,  45087 }, -- Runed Orb
				{ 30,  138800 }, -- Illusion: Blade Ward
				{ 101, 142090, "pet1959" }, -- Ominous Pile of Snow -> Winter Rageling
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,   156299 }, -- Icecore Staff
				{ 2,   156179 }, -- Staff of Endless Winter
				{ 3,   156180 }, -- Stormedge
				{ 4,   156612 }, -- Constellus
				{ 5,   156297 }, -- Shiver
				{ 6,   156294 }, -- Avalanche
				{ 7,   156300 }, -- Ice Layered Barrier
				{ 8,   156172 }, -- Northern Barrier
				{ 9,   156298 }, -- The Boreal Guard
				{ 10,  156186 }, -- Cowl of Icy Breaths
				{ 11,  156183 }, -- Drape of Icy Intent
				{ 12,  156295 }, -- Winter's Frigid Embrace
				{ 13,  156175 }, -- Winter's Icy Embrace
				{ 14,  156182 }, -- Bindings of Winter Gale
				{ 15,  156301 }, -- Bitter Cold Armguards
				{ 16,  156176 }, -- Frost-Bound Chain Bracers
				{ 17,  156184 }, -- Gloves of the Frozen Glade
				{ 18,  156174 }, -- Frostplate Greaves
				{ 19,  156418 }, -- Conqueror's Aegis Breastplate
				{ 20,  156367 }, -- Conqueror's Darkruned Chestguard
				{ 21,  156385 }, -- Conqueror's Deathbringer Robe
				{ 22,  156488 }, -- Conqueror's Glaivedancer Breastplate
				{ 23,  156378 }, -- Conqueror's Kirin Tor Tunic
				{ 24,  156439 }, -- Conqueror's Nightsong Vestments
				{ 25,  156414 }, -- Conqueror's Raiments of Sanctification
				{ 26,  156388 }, -- Conqueror's Scourgestalker Tunic
				{ 27,  156408 }, -- Conqueror's Siegebreaker Breastplate
				{ 28,  156498 }, -- Conqueror's Steelfist Breastplate
				{ 29,  156372 }, -- Conqueror's Terrorblade Breastplate
				{ 30,  156451 }, -- Conqueror's Worldbreaker Hauberk
				{ 101, 156108 }, -- Valorous Aegis Legguards
				{ 102, 156064 }, -- Valorous Darkruned Legplates
				{ 103, 156143 }, -- Valorous Deathbringer Leggings
				{ 104, 156496 }, -- Valorous Glaivedancer Legplates
				{ 105, 156091 }, -- Valorous Kirin Tor Leggings
				{ 106, 156118 }, -- Valorous Leggings of Sanctification
				{ 107, 156078 }, -- Valorous Nightsong Trousers
				{ 108, 156087 }, -- Valorous Scourgestalker Legguards
				{ 109, 156150 }, -- Valorous Siegebreaker Legguards
				{ 110, 156506 }, -- Valorous Steelfist Legplates
				{ 111, 156123 }, -- Valorous Terrorblade Legplates
				{ 112, 156132 }, -- Valorous Worldbreaker Kilt
				{ 113, 45038 }, -- Fragment of Val'anyr
				{ 114, 45087 }, -- Runed Orb
				{ 115, 138800 }, -- Illusion: Blade Ward
				{ 116, 142090, "pet1959" }, -- Ominous Pile of Snow -> Winter Rageling
			},
		},
		{ --Ulduar Thorim
			EncounterJournalID = 1645,
			[NORMAL_RAID_DIFF] = {
				{ 1,  45930 }, -- Combatant's Bootblade
				{ 2,  45892 }, -- Legacy of Thunder
				{ 3,  45463 }, -- Vulmir, the Northern Tempest
				{ 4,  45570 }, -- Skyforge Crossbow
				{ 5,  45470 }, -- Wisdom's Hold
				{ 6,  45893 }, -- Guise of the Midgard Serpent
				{ 7,  45472 }, -- Warhelm of the Champion
				{ 8,  45933 }, -- Pendant of the Shallow Grave
				{ 9,  45474 }, -- Pauldrons of the Combatant
				{ 10, 45473 }, -- Embrace of the Gladiator
				{ 11, 45928 }, -- Gauntlets of the Thunder God
				{ 12, 45927 }, -- Handwraps of Resonance
				{ 13, 45467 }, -- Belt of the Betrayed
				{ 14, 45895 }, -- Belt of the Blood Pit
				{ 15, 45468 }, -- Leggings of Lost Love
				{ 16, 45894 }, -- Leggings of Unstable Discharge
				{ 17, 45471 }, -- Fate's Clutch
				{ 18, 45469 }, -- Sif's Promise
				{ 19, 45931 }, -- Mjolnir Runestone
				{ 20, 45466 }, -- Scale of Fates
				{ 21, 45929 }, -- Sif's Remembrance
				{ 22, 45638 }, -- Crown of the Wayward Conqueror
				{ 23, 45639 }, -- Crown of the Wayward Protector
				{ 24, 45640 }, -- Crown of the Wayward Vanquisher
				{ 25, 45659 }, -- Spaulders of the Wayward Conqueror
				{ 26, 45660 }, -- Spaulders of the Wayward Protector
				{ 27, 45661 }, -- Spaulders of the Wayward Vanquisher
				{ 28, 45038 }, -- Fragment of Val'anyr
				{ 29, 45087 }, -- Runed Orb
				{ 30, 138800 }, -- Illusion: Blade Ward
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,   156309 }, -- Combatant's Bootblade
				{ 2,   156302 }, -- Legacy of Thunder
				{ 3,   156185 }, -- Vulmir, the Northern Tempest
				{ 4,   156610 }, -- Skyforge Crossbow
				{ 5,   156191 }, -- Wisdom's Hold
				{ 6,   156303 }, -- Guise of the Midgard Serpent
				{ 7,   156193 }, -- Warhelm of the Champion
				{ 8,   156195 }, -- Pauldrons of the Combatant
				{ 9,   156194 }, -- Embrace of the Gladiator
				{ 10,  156307 }, -- Gauntlets of the Thunder God
				{ 11,  156306 }, -- Handwraps of Resonance
				{ 12,  156188 }, -- Belt of the Betrayed
				{ 13,  156305 }, -- Belt of the Blood Pit
				{ 14,  156189 }, -- Leggings of Lost Love
				{ 15,  156304 }, -- Leggings of Unstable Discharge
				{ 16,  156310 }, -- Mjolnir Runestone
				{ 17,  156187 }, -- Scale of Fates
				{ 18,  156308 }, -- Sif's Remembrance
				{ 19,  156420 }, -- Conqueror's Aegis Faceguard
				{ 20,  156417 }, -- Conqueror's Circlet of Sanctification
				{ 21,  156369 }, -- Conqueror's Darkruned Faceguard
				{ 22,  156387 }, -- Conqueror's Deathbringer Hood
				{ 23,  156490 }, -- Conqueror's Glaivedancer Helmet
				{ 24,  156377 }, -- Conqueror's Kirin Tor Hood
				{ 25,  156436 }, -- Conqueror's Nightsong Cover
				{ 26,  156390 }, -- Conqueror's Scourgestalker Headpiece
				{ 27,  156412 }, -- Conqueror's Siegebreaker Greathelm
				{ 28,  156500 }, -- Conqueror's Steelfist Helmet
				{ 29,  156374 }, -- Conqueror's Terrorblade Helmet
				{ 30,  156454 }, -- Conqueror's Worldbreaker Helm
				{ 101, 156109 }, -- Valorous Aegis Shoulderguards
				{ 102, 156065 }, -- Valorous Darkruned Shoulderplates
				{ 103, 156145 }, -- Valorous Deathbringer Shoulderpads
				{ 104, 156497 }, -- Valorous Glaivedancer Pauldrons
				{ 105, 156093 }, -- Valorous Kirin Tor Shoulderpads
				{ 106, 156077 }, -- Valorous Nightsong Mantle
				{ 107, 156088 }, -- Valorous Scourgestalker Spaulders
				{ 108, 156117 }, -- Valorous Shoulderpads of Sanctification
				{ 109, 156151 }, -- Valorous Siegebreaker Pauldrons
				{ 110, 156507 }, -- Valorous Steelfist Pauldrons
				{ 111, 156124 }, -- Valorous Terrorblade Pauldrons
				{ 112, 156133 }, -- Valorous Worldbreaker Shoulderpads
				{ 113, 45038 }, -- Fragment of Val'anyr
				{ 114, 45087 }, -- Runed Orb
				{ 115, 138800 }, -- Illusion: Blade Ward
			},
		},
		{ --Ulduar Freya
			EncounterJournalID = 1646,
			[NORMAL_RAID_DIFF] = {
				{ 1,  45613 }, -- Dreambinder
				{ 2,  45479 }, -- The Lifebinder
				{ 3,  45934 }, -- Unraveling Reach
				{ 4,  45484 }, -- Bladetwister
				{ 5,  45947 }, -- Serilas, Blood Blade of Invar One-Arm
				{ 6,  45294 }, -- Petrified Ivy Sprig
				{ 7,  45935 }, -- Ironbark Faceguard
				{ 8,  45485 }, -- Bronze Pendant of the Vanir
				{ 9,  45480 }, -- Nymph Heart Charm
				{ 10, 45945 }, -- Seed of Budding Carnage
				{ 11, 45486 }, -- Drape of the Sullen Goddess
				{ 12, 45941 }, -- Chestguard of the Lasher
				{ 13, 45940 }, -- Tunic of the Limber Stalker
				{ 14, 45481 }, -- Gauntlets of Ruthless Reprisal
				{ 15, 45943 }, -- Gloves of Whispering Winds
				{ 16, 45487 }, -- Handguards of Revitalization
				{ 17, 45488 }, -- Leggings of the Enslaved Idol
				{ 18, 45482 }, -- Leggings of the Lifetender
				{ 19, 45936 }, -- Legplates of Flourishing Resolve
				{ 20, 45483 }, -- Boots of the Servant
				{ 21, 45946 }, -- Fire Orchid Signet
				{ 22, 45644 }, -- Gloves of the Wayward Conqueror
				{ 23, 45645 }, -- Gloves of the Wayward Protector
				{ 24, 45646 }, -- Gloves of the Wayward Vanquisher
				{ 25, 45653 }, -- Legplates of the Wayward Conqueror
				{ 26, 45654 }, -- Legplates of the Wayward Protector
				{ 27, 45655 }, -- Legplates of the Wayward Vanquisher
				{ 28, 45038 }, -- Fragment of Val'anyr
				{ 30, 142091, "pet1960" }, -- Blessed Seed -> Snaplasher
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,   156613 }, -- Dreambinder
				{ 2,   156196 }, -- The Lifebinder
				{ 3,   156312 }, -- Unraveling Reach
				{ 4,   156201 }, -- Bladetwister
				{ 5,   156320 }, -- Serilas, Blood Blade of Invar One-Arm
				{ 6,   156023 }, -- Petrified Ivy Sprig
				{ 7,   156313 }, -- Ironbark Faceguard
				{ 8,   156203 }, -- Drape of the Sullen Goddess
				{ 9,   156316 }, -- Chestguard of the Lasher
				{ 10,  156315 }, -- Tunic of the Limber Stalker
				{ 11,  156198 }, -- Gauntlets of Ruthless Reprisal
				{ 12,  156317 }, -- Gloves of Whispering Winds
				{ 13,  156204 }, -- Handguards of Revitalization
				{ 14,  156205 }, -- Leggings of the Enslaved Idol
				{ 15,  156199 }, -- Leggings of the Lifetender
				{ 16,  156314 }, -- Legplates of Flourishing Resolve
				{ 17,  156200 }, -- Boots of the Servant
				{ 18,  156107 }, -- Valorous Aegis Handguards
				{ 19,  156063 }, -- Valorous Darkruned Gauntlets
				{ 20,  156142 }, -- Valorous Deathbringer Gloves
				{ 21,  156494 }, -- Valorous Glaivedancer Gauntlets
				{ 22,  156116 }, -- Valorous Gloves of Sanctification
				{ 23,  156379 }, -- Valorous Kirin Tor Gauntlets
				{ 24,  156076 }, -- Valorous Nightsong Gloves
				{ 25,  156085 }, -- Valorous Scourgestalker Handguards
				{ 26,  156149 }, -- Valorous Siegebreaker Handguards
				{ 27,  156504 }, -- Valorous Steelfist Gauntlets
				{ 28,  156121 }, -- Valorous Terrorblade Gauntlets
				{ 29,  156130 }, -- Valorous Worldbreaker Gloves
				{ 30,  156421 }, -- Conqueror's Aegis Legguards
				{ 101, 156370 }, -- Conqueror's Darkruned Legguards
				{ 102, 156386 }, -- Conqueror's Deathbringer Leggings
				{ 103, 156491 }, -- Conqueror's Glaivedancer Legplates
				{ 104, 156381 }, -- Conqueror's Kirin Tor Leggings
				{ 105, 156437 }, -- Conqueror's Nightsong Trousers
				{ 106, 156416 }, -- Conqueror's Pants of Sanctification
				{ 107, 156391 }, -- Conqueror's Scourgestalker Legguards
				{ 108, 156415 }, -- Conqueror's Siegebreaker Legguards
				{ 109, 156501 }, -- Conqueror's Steelfist Legplates
				{ 110, 156375 }, -- Conqueror's Terrorblade Legplates
				{ 111, 156455 }, -- Conqueror's Worldbreaker Kilt
				{ 112, 45038 }, -- Fragment of Val'anyr
				{ 114, 142091, "pet1960" }, -- Blessed Seed -> Snaplasher
			},
		},
		{ --Ulduar Mimiron
			EncounterJournalID = 1647,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45494 }, -- Delirium's Touch
				{ 2,   45990 }, -- Fusion Blade
				{ 3,   45489 }, -- Insanity's Grip
				{ 4,   45972 }, -- Pulse Baton
				{ 5,   45620 }, -- Starshard Edge
				{ 6,   45497 }, -- Crown of Luminescence
				{ 7,   45993 }, -- Mimiron's Flight Goggles
				{ 8,   45492 }, -- Malleable Steelweave Mantle
				{ 9,   45974 }, -- Shoulderguards of Assimilation
				{ 10,  45493 }, -- Asimov's Drape
				{ 11,  45973 }, -- Stylish Power Cape
				{ 12,  45496 }, -- Titanskin Cloak
				{ 13,  45663 }, -- Armbands of Bedlam
				{ 14,  45976 }, -- Static Charge Handwraps
				{ 15,  45975 }, -- Cable of the Metrognome
				{ 16,  45491 }, -- Waistguard of the Creator
				{ 17,  45982 }, -- Fused Alloy Legplates
				{ 18,  45988 }, -- Greaves of the Iron Army
				{ 19,  45989 }, -- Tempered Mercury Greaves
				{ 20,  45495 }, -- Conductive Seal
				{ 21,  45490 }, -- Pandora's Plea
				{ 22,  45641 }, -- Gauntlets of the Wayward Conqueror
				{ 23,  45642 }, -- Gauntlets of the Wayward Protector
				{ 24,  45643 }, -- Gauntlets of the Wayward Vanquisher
				{ 25,  45647 }, -- Helm of the Wayward Conqueror
				{ 26,  45648 }, -- Helm of the Wayward Protector
				{ 27,  45649 }, -- Helm of the Wayward Vanquisher
				{ 28,  45038 }, -- Fragment of Val'anyr
				{ 29,  45087 }, -- Runed Orb
				{ 30,  138800 }, -- Illusion: Blade Ward
				{ 101, 142092, "pet1961" }, -- Overcomplicated Controller -> G0-R41-0N Ultratonk
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,   156211 }, -- Delirium's Touch
				{ 2,   156329 }, -- Fusion Blade
				{ 3,   156206 }, -- Insanity's Grip
				{ 4,   156321 }, -- Pulse Baton
				{ 5,   156614 }, -- Starshard Edge
				{ 6,   156214 }, -- Crown of Luminescence
				{ 7,   156330 }, -- Mimiron's Flight Goggles
				{ 8,   156209 }, -- Malleable Steelweave Mantle
				{ 9,   156323 }, -- Shoulderguards of Assimilation
				{ 10,  156210 }, -- Asimov's Drape
				{ 11,  156322 }, -- Stylish Power Cape
				{ 12,  156213 }, -- Titanskin Cloak
				{ 13,  156258 }, -- Armbands of Bedlam
				{ 14,  156325 }, -- Static Charge Handwraps
				{ 15,  156324 }, -- Cable of the Metrognome
				{ 16,  156208 }, -- Waistguard of the Creator
				{ 17,  156326 }, -- Fused Alloy Legplates
				{ 18,  156327 }, -- Greaves of the Iron Army
				{ 19,  156328 }, -- Tempered Mercury Greaves
				{ 20,  156207 }, -- Pandora's Plea
				{ 21,  156419 }, -- Conqueror's Aegis Handguards
				{ 22,  156368 }, -- Conqueror's Darkruned Handguards
				{ 23,  156383 }, -- Conqueror's Deathbringer Gloves
				{ 24,  156489 }, -- Conqueror's Glaivedancer Gauntlets
				{ 25,  156409 }, -- Conqueror's Handwraps of Sanctification
				{ 26,  156380 }, -- Conqueror's Kirin Tor Gauntlets
				{ 27,  156434 }, -- Conqueror's Nightsong Gloves
				{ 28,  156389 }, -- Conqueror's Scourgestalker Handguards
				{ 29,  156410 }, -- Conqueror's Siegebreaker Handguards
				{ 30,  156499 }, -- Conqueror's Steelfist Gauntlets
				{ 101, 156373 }, -- Conqueror's Terrorblade Gauntlets
				{ 102, 156452 }, -- Conqueror's Worldbreaker Gloves
				{ 103, 156106 }, -- Valorous Aegis Faceguard
				{ 104, 156115 }, -- Valorous Cowl of Sanctification
				{ 105, 156062 }, -- Valorous Darkruned Helmet
				{ 106, 156140 }, -- Valorous Deathbringer Hood
				{ 107, 156495 }, -- Valorous Glaivedancer Helmet
				{ 108, 156090 }, -- Valorous Kirin Tor Hood
				{ 109, 156459 }, -- Valorous Nightsong Cover
				{ 110, 156086 }, -- Valorous Scourgestalker Headpiece
				{ 111, 156148 }, -- Valorous Siegebreaker Greathelm
				{ 112, 156505 }, -- Valorous Steelfist Helmet
				{ 113, 156122 }, -- Valorous Terrorblade Helmet
				{ 114, 156131 }, -- Valorous Worldbreaker Helm
				{ 115, 45038 }, -- Fragment of Val'anyr
				{ 116, 45087 }, -- Runed Orb
				{ 117, 138800 }, -- Illusion: Blade Ward
				{ 119, 142092, "pet1961" }, -- Overcomplicated Controller -> G0-R41-0N Ultratonk
			},
		},
		{ --Ulduar Vezax
			EncounterJournalID = 1648,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45996 }, -- Hoperender
				{ 2,   45498 }, -- Lotrafen, Spear of the Damned
				{ 3,   46033 }, -- Tortured Earth
				{ 4,   45516 }, -- Voldrethar, Dark Blade of Oblivion
				{ 5,   46035 }, -- Aesuga, Hand of the Ardent Champion
				{ 6,   46011 }, -- Shadowbite
				{ 7,   46036 }, -- Void Sabre
				{ 8,   45511 }, -- Scepter of Lost Souls
				{ 9,   45502 }, -- Helm of the Faceless
				{ 10,  46008 }, -- Choker of the Abyss
				{ 11,  46015 }, -- Pendant of Endless Despair
				{ 12,  45517 }, -- Pendulum of Infinity
				{ 13,  45514 }, -- Mantle of the Unknowing
				{ 14,  46013 }, -- Underworld Mantle
				{ 15,  46032 }, -- Drape of the Faceless General
				{ 16,  46014 }, -- Saronite Animus Cloak
				{ 17,  45519 }, -- Vestments of the Blind Denizen
				{ 18,  46012 }, -- Vestments of the Piercing Light
				{ 19,  46009 }, -- Bindings of the Depths
				{ 20,  45997 }, -- Gauntlets of the Wretched
				{ 21,  45512 }, -- Grips of the Unbroken
				{ 22,  45520 }, -- Handwraps of the Vigilant
				{ 23,  45505 }, -- Belt of Clinging Hope
				{ 24,  45508 }, -- Belt of the Darkspeaker
				{ 25,  45504 }, -- Darkcore Leggings
				{ 26,  46034 }, -- Leggings of Profound Darkness
				{ 27,  45513 }, -- Boots of the Forgotten Depths
				{ 28,  45501 }, -- Boots of the Underdweller
				{ 29,  46010 }, -- Darkstone Ring
				{ 30,  45503 }, -- Metallic Loop of the Sufferer
				{ 101, 45515 }, -- Ring of the Vacant Eye
				{ 102, 45518 }, -- Flare of the Heavens
				{ 103, 45507 }, -- The General's Heart
				{ 104, 45038 }, -- Fragment of Val'anyr
				{ 105, 45087 }, -- Runed Orb
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  156331 }, -- Hoperender
				{ 2,  156215 }, -- Lotrafen, Spear of the Damned
				{ 3,  156353 }, -- Tortured Earth
				{ 4,  156228 }, -- Voldrethar, Dark Blade of Oblivion
				{ 5,  156355 }, -- Aesuga, Hand of the Ardent Champion
				{ 6,  156336 }, -- Shadowbite
				{ 7,  156356 }, -- Void Sabre
				{ 8,  156223 }, -- Scepter of Lost Souls
				{ 9,  156217 }, -- Helm of the Faceless
				{ 10, 156226 }, -- Mantle of the Unknowing
				{ 11, 156338 }, -- Underworld Mantle
				{ 12, 156352 }, -- Drape of the Faceless General
				{ 13, 156339 }, -- Saronite Animus Cloak
				{ 14, 156231 }, -- Vestments of the Blind Denizen
				{ 15, 156337 }, -- Vestments of the Piercing Light
				{ 16, 156334 }, -- Bindings of the Depths
				{ 17, 156332 }, -- Gauntlets of the Wretched
				{ 18, 156224 }, -- Grips of the Unbroken
				{ 19, 156232 }, -- Handwraps of the Vigilant
				{ 20, 156220 }, -- Belt of Clinging Hope
				{ 21, 156222 }, -- Belt of the Darkspeaker
				{ 22, 156219 }, -- Darkcore Leggings
				{ 23, 156354 }, -- Leggings of Profound Darkness
				{ 24, 156225 }, -- Boots of the Forgotten Depths
				{ 25, 156216 }, -- Boots of the Underdweller
				{ 26, 156230 }, -- Flare of the Heavens
				{ 27, 156221 }, -- The General's Heart
				{ 28, 45038 }, -- Fragment of Val'anyr
				{ 29, 45087 }, -- Runed Orb
			},
		},
		{ --Ulduar YoggSaron
			EncounterJournalID = 1649,
			[NORMAL_RAID_DIFF] = {
				{ 1,   46016 }, -- Abaddon
				{ 2,   45533 }, -- Dark Edge of Depravity
				{ 3,   46025 }, -- Devotion
				{ 4,   45521 }, -- Earthshaper
				{ 5,   46067 }, -- Hammer of Crushing Whispers
				{ 6,   46097 }, -- Caress of Insanity
				{ 7,   46024 }, -- Kingsbane
				{ 8,   45527 }, -- Soulscribe
				{ 9,   46031 }, -- Touch of Madness
				{ 10,  46018 }, -- Deliverance
				{ 11,  45532 }, -- Cowl of Dark Whispers
				{ 12,  46028 }, -- Faceguard of the Eyeless Horror
				{ 13,  45523 }, -- Garona's Guise
				{ 14,  46022 }, -- Pendant of a Thousand Maws
				{ 15,  46068 }, -- Amice of Inconceivable Horror
				{ 16,  45529 }, -- Shawl of Haunted Memories
				{ 17,  45524 }, -- Chestguard of Insidious Intent
				{ 18,  45531 }, -- Chestguard of the Fallen God
				{ 19,  46095 }, -- Soul-Devouring Cinch
				{ 20,  46019 }, -- Leggings of the Insatiable
				{ 21,  45536 }, -- Legguards of Cunning Deception
				{ 22,  46030 }, -- Treads of the Dragon Council
				{ 23,  45537 }, -- Treads of the False Oracle
				{ 24,  45525 }, -- Godbane Signet
				{ 25,  45530 }, -- Sanity's Bond
				{ 26,  45534 }, -- Seal of the Betrayed King
				{ 27,  46096 }, -- Signet of Soft Lament
				{ 28,  45522 }, -- Blood of the Old God
				{ 29,  46021 }, -- Royal Seal of King Llane
				{ 30,  45535 }, -- Show of Faith
				{ 101, 46312 }, -- Vanquished Clutches of Yogg-Saron
				{ 102, 45635 }, -- Chestguard of the Wayward Conqueror
				{ 103, 45636 }, -- Chestguard of the Wayward Protector
				{ 104, 45637 }, -- Chestguard of the Wayward Vanquisher
				{ 105, 45656 }, -- Mantle of the Wayward Conqueror
				{ 106, 45657 }, -- Mantle of the Wayward Protector
				{ 107, 45658 }, -- Mantle of the Wayward Vanquisher
				{ 108, 45038 }, -- Fragment of Val'anyr
				{ 109, 45087 }, -- Runed Orb
				{ 110, 138801 }, -- Illusion: Blood Draining
				{ 112, 45693,  "mount" }, -- Mimiron's Head
				{ 113, 142093, "pet1962" }, -- Wriggling Darkness -> Creeping Tentacle
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,   156341 }, -- Abaddon
				{ 2,   156243 }, -- Dark Edge of Depravity
				{ 3,   156348 }, -- Devotion
				{ 4,   156233 }, -- Earthshaper
				{ 5,   156357 }, -- Hammer of Crushing Whispers
				{ 6,   156361 }, -- Caress of Insanity
				{ 7,   156347 }, -- Kingsbane
				{ 8,   156238 }, -- Soulscribe
				{ 9,   156351 }, -- Touch of Madness
				{ 10,  156343 }, -- Deliverance
				{ 11,  156242 }, -- Cowl of Dark Whispers
				{ 12,  156349 }, -- Faceguard of the Eyeless Horror
				{ 13,  156235 }, -- Garona's Guise
				{ 14,  156358 }, -- Amice of Inconceivable Horror
				{ 15,  156239 }, -- Shawl of Haunted Memories
				{ 16,  156236 }, -- Chestguard of Insidious Intent
				{ 17,  156241 }, -- Chestguard of the Fallen God
				{ 18,  156359 }, -- Soul-Devouring Cinch
				{ 19,  156344 }, -- Leggings of the Insatiable
				{ 20,  156246 }, -- Legguards of Cunning Deception
				{ 21,  156350 }, -- Treads of the Dragon Council
				{ 22,  156247 }, -- Treads of the False Oracle
				{ 23,  156234 }, -- Blood of the Old God
				{ 24,  156345 }, -- Royal Seal of King Llane
				{ 25,  156245 }, -- Show of Faith
				{ 26,  156458 }, -- Vanquished Clutches of Yogg-Saron
				{ 27,  156422 }, -- Conqueror's Aegis Shoulderguards
				{ 28,  156371 }, -- Conqueror's Darkruned Pauldrons
				{ 29,  156384 }, -- Conqueror's Deathbringer Shoulderpads
				{ 30,  156492 }, -- Conqueror's Glaivedancer Pauldrons
				{ 101, 156382 }, -- Conqueror's Kirin Tor Shoulderpads
				{ 102, 156411 }, -- Conqueror's Mantle of Sanctification
				{ 103, 156441 }, -- Conqueror's Nightsong Mantle
				{ 104, 156392 }, -- Conqueror's Scourgestalker Spaulders
				{ 105, 156413 }, -- Conqueror's Siegebreaker Pauldrons
				{ 106, 156502 }, -- Conqueror's Steelfist Pauldrons
				{ 107, 156376 }, -- Conqueror's Terrorblade Pauldrons
				{ 108, 156456 }, -- Conqueror's Worldbreaker Shoulderpads
				{ 109, 156105 }, -- Valorous Aegis Breastplate
				{ 110, 156061 }, -- Valorous Darkruned Battleplate
				{ 111, 156144 }, -- Valorous Deathbringer Robe
				{ 112, 156493 }, -- Valorous Glaivedancer Breastplate
				{ 113, 156092 }, -- Valorous Kirin Tor Tunic
				{ 114, 156079 }, -- Valorous Nightsong Vestments
				{ 115, 156119 }, -- Valorous Robe of Sanctification
				{ 116, 156089 }, -- Valorous Scourgestalker Tunic
				{ 117, 156147 }, -- Valorous Siegebreaker Breastplate
				{ 118, 156503 }, -- Valorous Steelfist Breastplate
				{ 119, 156120 }, -- Valorous Terrorblade Breastplate
				{ 120, 156134 }, -- Valorous Worldbreaker Hauberk
				{ 121, 45038 }, -- Fragment of Val'anyr
				{ 122, 45087 }, -- Runed Orb
				{ 123, 138801 }, -- Illusion: Blood Draining
				{ 125, 45693,  "mount" }, -- Mimiron's Head
				{ 126, 142093, "pet1962" }, -- Wriggling Darkness -> Creeping Tentacle
			},
		},
		{ --Ulduar Algalon
			EncounterJournalID = 1650,
			[NORMAL_RAID_DIFF] = {
				{ 1,   45613 }, -- Dreambinder
				{ 2,   45612 }, -- Constellus
				{ 3,   45607 }, -- Fang of Oblivion
				{ 4,   45620 }, -- Starshard Edge
				{ 5,   45570 }, -- Skyforge Crossbow
				{ 6,   45587 }, -- Bulwark of Algalon
				{ 7,   45617 }, -- Cosmos
				{ 8,   45610 }, -- Boundless Gaze
				{ 9,   46047 }, -- Pendant of the Somber Witness
				{ 10,  46040 }, -- Strength of the Heavens
				{ 11,  46044 }, -- Observer's Mantle
				{ 12,  46037 }, -- Shoulderplates of the Celestial Watch
				{ 13,  46042 }, -- Drape of the Messenger
				{ 14,  46039 }, -- Breastplate of the Timeless
				{ 15,  45611 }, -- Solar Bindings
				{ 16,  46043 }, -- Gloves of the Endless Dark
				{ 17,  45665 }, -- Pharos Gloves
				{ 18,  46045 }, -- Pulsar Gloves
				{ 19,  45616 }, -- Star-Beaded Clutch
				{ 20,  46041 }, -- Starfall Girdle
				{ 21,  45619 }, -- Starwatcher's Binding
				{ 22,  45594 }, -- Legplates of the Endless Void
				{ 23,  46049 }, -- Zodiac Leggings
				{ 24,  45615 }, -- Planewalker Treads
				{ 25,  45599 }, -- Sabatons of Lifeless Night
				{ 26,  46050 }, -- Starlight Treads
				{ 27,  46048 }, -- Band of Lights
				{ 28,  46046 }, -- Nebula Band
				{ 29,  45609 }, -- Comet's Trail
				{ 30,  46038 }, -- Dark Matter
				{ 101, 46051 }, -- Meteorite Crystal
				{ 102, 45038 }, -- Fragment of Val'anyr
				{ 103, 45087 }, -- Runed Orb
			},
		},
		{ --Ulduar Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_RAID_DIFF] = {
				{ 1,  46341 }, -- Drape of the Spellweaver
				{ 2,  46347 }, -- Cloak of the Dormant Blaze
				{ 3,  46344 }, -- Iceshear Mantle
				{ 4,  46346 }, -- Boots of Unsettled Prey
				{ 5,  46345 }, -- Bracers of Righteous Reformation
				{ 6,  46340 }, -- Adamant Handguards
				{ 8,  46343 }, -- Fervor of the Protectorate
				{ 16, 46339 }, -- Mimiron's Repeater
				{ 17, 46351 }, -- Bloodcrush Cudgel
				{ 18, 46350 }, -- Pillar of Fortitude
				{ 19, 46342 }, -- Golemheart Longbow
			},
			[TIMEWALKING_RAID_DIFF] = {
				{ 1,  45541 }, -- Shroud of Alteration
				{ 2,  45549 }, -- Grips of Chaos
				{ 3,  45547 }, -- Relic Hunter's Cord
				{ 4,  45548 }, -- Belt of the Sleeper
				{ 5,  45543 }, -- Shoulders of Misfortune
				{ 6,  45544 }, -- Leggings of the Tortured Earth
				{ 7,  45542 }, -- Greaves of the Stonewarder
				{ 9,  45540 }, -- Bladebearer's Signet
				{ 10, 45539 }, -- Pendant of Focused Energies
				{ 11, 45538 }, -- Titanstone Pendant
				{ 16, 45605 }, -- Daschal's Bite
			},
		},
		{ --Ulduar Patterns
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 226)..")",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  45089 }, -- Plans: Battlelord's Plate Boots
				{ 2,  45088 }, -- Plans: Belt of the Titans
				{ 3,  45092 }, -- Plans: Indestructible Plate Girdle
				{ 4,  45090 }, -- Plans: Plate Girdle of Righteousness
				{ 5,  45093 }, -- Plans: Spiked Deathdealers
				{ 6,  45091 }, -- Plans: Treads of Destiny
				{ 8,  45100 }, -- Pattern: Belt of Arctic Life
				{ 9,  45094 }, -- Pattern: Belt of Dragons
				{ 10, 45096 }, -- Pattern: Blue Belt of Chaos
				{ 11, 45095 }, -- Pattern: Boots of Living Scale
				{ 12, 45101 }, -- Pattern: Boots of Wintry Endurance
				{ 13, 45098 }, -- Pattern: Death-warmed Belt
				{ 14, 45099 }, -- Pattern: Footpads of Silence
				{ 15, 45097 }, -- Pattern: Lightning Grounded Boots
				{ 16, 45104 }, -- Pattern: Cord of the White Dawn
				{ 17, 45102 }, -- Pattern: Sash of Ancient Power
				{ 18, 45105 }, -- Pattern: Savior's Slippers
				{ 19, 45103 }, -- Pattern: Spellslinger's Slippers
				{ 21, 46027 }, -- Formula: Enchant Weapon - Blade Ward
				{ 22, 46348 }, -- Formula: Enchant Weapon - Blood Draining
				{ 24, 45087 }, -- Runed Orb
			},
		},
		{ --Tier 8 Sets
			name = format(AL["Tier %d Sets"], 8),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:8",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:8",
		},
		WOTLK_RAID2_10_AC_TABLE,
		WOTLK_RAID2_25_AC_TABLE,
	}
}

data["VaultofArchavon"] = {
	EncounterJournalID = 753,
	MapID = 156,
	AtlasMapID = "VaultOfArchavon",
	ContentType = RAID_CONTENT,
	items = {
		{ --Archavon
			EncounterJournalID = 1597,
			[NORMAL_DIFF] = {
				{ 1,   "ICON_spell_deathknight_frostpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 2,   39617 },                                                    -- Heroes' Scourgeborne Battleplate
				{ 3,   39618 },                                                    -- Heroes' Scourgeborne Gauntlets
				{ 4,   39620 },                                                    -- Heroes' Scourgeborne Legplates
				{ 6,   "ICON_spell_deathknight_bloodpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 7,   39623 },                                                    -- Heroes' Scourgeborne Chestguard
				{ 8,   39624 },                                                    -- Heroes' Scourgeborne Handguards
				{ 9,   39626 },                                                    -- Heroes' Scourgeborne Legguards
				{ 16,  "ICON_Spell_deathknight_classicon",     nil,                         ALIL["DEATHKNIGHT"], nil },
				{ 17,  40781 },                                                    -- Hateful Gladiator's Dreadplate Chestpiece
				{ 18,  40803 },                                                    -- Hateful Gladiator's Dreadplate Gauntlets
				{ 19,  40841 },                                                    -- Hateful Gladiator's Dreadplate Legguards
				{ 101, "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 102, 39547 },                                                    -- Heroes' Dreamwalker Vestments
				{ 103, 39544 },                                                    -- Heroes' Dreamwalker Gloves
				{ 104, 39546 },                                                    -- Heroes' Dreamwalker Trousers
				{ 106, "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 107, 39554 },                                                    -- Heroes' Dreamwalker Raiments
				{ 108, 39557 },                                                    -- Heroes' Dreamwalker Handgrips
				{ 109, 39555 },                                                    -- Heroes' Dreamwalker Legguards
				{ 111, "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 112, 39538 },                                                    -- Heroes' Dreamwalker Robe
				{ 113, 39543 },                                                    -- Heroes' Dreamwalker Handguards
				{ 114, 39539 },                                                    -- Heroes' Dreamwalker Leggings
				{ 116, "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 117, 41314 },                                                    -- Hateful Gladiator's Wyrmhide Robes
				{ 118, 41291 },                                                    -- Hateful Gladiator's Wyrmhide Gloves
				{ 119, 41302 },                                                    -- Hateful Gladiator's Wyrmhide Legguards
				{ 121, "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 122, 41659 },                                                    -- Hateful Gladiator's Dragonhide Robes
				{ 123, 41771 },                                                    -- Hateful Gladiator's Dragonhide Gloves
				{ 124, 41665 },                                                    -- Hateful Gladiator's Dragonhide Legguards
				{ 126, "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 127, 41308 },                                                    -- Hateful Gladiator's Kodohide Robes
				{ 128, 41284 },                                                    -- Hateful Gladiator's Kodohide Gloves
				{ 129, 41296 },                                                    -- Hateful Gladiator's Kodohide Legguards
				{ 201, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 202, 39579 },                                                    -- Heroes' Crypstalker Tunic
				{ 203, 39582 },                                                    -- Heroes' Crypstalker Handguards
				{ 204, 39580 },                                                    -- Heroes' Crypstalker Legguards
				{ 206, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 207, 39492 },                                                    -- Heroes' Frostfire Robe
				{ 208, 39495 },                                                    -- Heroes' Frostfire Gloves
				{ 209, 39493 },                                                    -- Heroes' Frostfire Leggings
				{ 211, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 212, 39558 },                                                    -- Heroes' Bonescythe Breastplate
				{ 213, 39560 },                                                    -- Heroes' Bonescythe Gauntlets
				{ 214, 39564 },                                                    -- Heroes' Bonescythe Legplates
				{ 216, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 217, 41085 },                                                    -- Hateful Gladiator's Chain Armor
				{ 218, 41141 },                                                    -- Hateful Gladiator's Chain Gauntlets
				{ 219, 41203 },                                                    -- Hateful Gladiator's Chain Leggings
				{ 221, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 222, 41950 },                                                    -- Hateful Gladiator's Silk Raiment
				{ 223, 41969 },                                                    -- Hateful Gladiator's Silk Handguards
				{ 224, 41957 },                                                    -- Hateful Gladiator's Silk Trousers
				{ 226, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 227, 41648 },                                                    -- Hateful Gladiator's Leather Tunic
				{ 228, 41765 },                                                    -- Hateful Gladiator's Leather Gloves
				{ 229, 41653 },                                                    -- Hateful Gladiator's Leather Legguards
				{ 301, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 302, 39629 },                                                    -- Heroes' Redemption Tunic
				{ 303, 39632 },                                                    -- Heroes' Redemption Gloves
				{ 304, 39630 },                                                    -- Heroes' Redemption Greaves
				{ 306, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 307, 39633 },                                                    -- Heroes' Redemption Chestpiece
				{ 308, 39634 },                                                    -- Heroes' Redemption Gauntlets
				{ 309, 39636 },                                                    -- Heroes' Redemption Legplates
				{ 311, "ICON_spell_holy_devotionaura",         nil,                         ALIL["PALADIN"],     ALIL["Protection"] },
				{ 312, 39638 },                                                    -- Heroes' Redemption Breastplate
				{ 313, 39639 },                                                    -- Heroes' Redemption Handguards
				{ 314, 39641 },                                                    -- Heroes' Redemption Legguards
				{ 316, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 317, 40904 },                                                    -- Hateful Gladiator's Ornamented Chestguard
				{ 318, 40925 },                                                    -- Hateful Gladiator's Ornamented Gloves
				{ 319, 40937 },                                                    -- Hateful Gladiator's Ornamented Legplates
				{ 321, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 322, 40782 },                                                    -- Hateful Gladiator's Scaled Chestpiece
				{ 323, 40802 },                                                    -- Hateful Gladiator's Scaled Gauntlets
				{ 324, 40842 },                                                    -- Hateful Gladiator's Scaled Legguards
				{ 401, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 402, 39515 },                                                    -- Heroes' Robe of Faith
				{ 403, 39519 },                                                    -- Heroes' Gloves of Faith
				{ 404, 39517 },                                                    -- Heroes' Leggings of Faith
				{ 406, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 407, 39523 },                                                    -- Heroes' Raiments of Faith
				{ 408, 39530 },                                                    -- Heroes' Handwraps of Faith
				{ 409, 39528 },                                                    -- Heroes' Pants of Faith
				{ 416, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 417, 41857 },                                                    -- Hateful Gladiator's Mooncloth Robe
				{ 418, 41872 },                                                    -- Hateful Gladiator's Mooncloth Gloves
				{ 419, 41862 },                                                    -- Hateful Gladiator's Mooncloth Leggings
				{ 421, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 422, 41919 },                                                    -- Hateful Gladiator's Satin Robe
				{ 423, 41938 },                                                    -- Hateful Gladiator's Satin Gloves
				{ 424, 41925 },                                                    -- Hateful Gladiator's Satin Leggings
				{ 501, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 502, 39592 },                                                    -- Heroes' Earthshatter Hauberk
				{ 503, 39593 },                                                    -- Heroes' Earthshatter Gloves
				{ 504, 39595 },                                                    -- Heroes' Earthshatter Kilt
				{ 506, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 507, 39597 },                                                    -- Heroes' Earthshatter Chestguard
				{ 508, 39601 },                                                    -- Heroes' Earthshatter Grips
				{ 509, 39603 },                                                    -- Heroes' Earthshatter War-Kilt
				{ 511, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 512, 39588 },                                                    -- Heroes' Earthshatter Tunic
				{ 513, 39591 },                                                    -- Heroes' Earthshatter Handguards
				{ 514, 39589 },                                                    -- Heroes' Earthshatter Legguards
				{ 516, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 517, 40989 },                                                    -- Hateful Gladiator's Mail Armor
				{ 518, 41005 },                                                    -- Hateful Gladiator's Mail Gauntlets
				{ 519, 41031 },                                                    -- Hateful Gladiator's Mail Leggings
				{ 521, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 522, 41079 },                                                    -- Hateful Gladiator's Linked Armor
				{ 523, 41135 },                                                    -- Hateful Gladiator's Linked Gauntlets
				{ 524, 41162 },                                                    -- Hateful Gladiator's Linked Leggings
				{ 526, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 527, 40988 },                                                    -- Hateful Gladiator's Ringmail Armor
				{ 528, 40999 },                                                    -- Hateful Gladiator's Ringmail Gauntlets
				{ 529, 41025 },                                                    -- Hateful Gladiator's Ringmail Leggings
				{ 601, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 602, 39497 },                                                    -- Heroes' Plagueheart Robe
				{ 603, 39500 },                                                    -- Heroes' Plagueheart Gloves
				{ 604, 39498 },                                                    -- Heroes' Plagueheart Leggings
				{ 606, "ICON_ability_warrior_innerrage",       nil,                         ALIL["WARRIOR"],     ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 607, 39606 },                                                    -- Heroes' Dreadnaught Battleplate
				{ 608, 39609 },                                                    -- Heroes' Dreadnaught Gauntlets
				{ 609, 39607 },                                                    -- Heroes' Dreadnaught Legplates
				{ 611, "ICON_ability_warrior_defensivestance", nil,                         ALIL["WARRIOR"],     ALIL["Protection"] },
				{ 612, 39611 },                                                    -- Heroes' Dreadnaught Breastplate
				{ 613, 39622 },                                                    -- Heroes' Dreadnaught Handguards
				{ 614, 39612 },                                                    -- Heroes' Dreadnaught Legguards
				{ 616, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 617, 42001 },                                                    -- Hateful Gladiator's Felweave Raiment
				{ 618, 42015 },                                                    -- Hateful Gladiator's Felweave Handguards
				{ 619, 42003 },                                                    -- Hateful Gladiator's Felweave Trousers
				{ 621, "ICON_inv_sword_27",                    nil,                         ALIL["WARRIOR"],     nil },
				{ 622, 40783 },                                                    -- Hateful Gladiator's Plate Chestpiece
				{ 623, 40801 },                                                    -- Hateful Gladiator's Plate Gauntlets
				{ 624, 40840 },                                                    -- Hateful Gladiator's Plate Legguards
				{ 626, [ATLASLOOT_IT_ALLIANCE] = 43959,        [ATLASLOOT_IT_HORDE] = 44083 }, -- Reins of the Grand Black War Mammoth
				{ 628, "ac1722" },
				{ 629, "ac4016" },
			},
			[P25_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 2,   40550 }, -- Valorous Scourgeborne Battleplate
				{ 3,   40552 }, -- Valorous Scourgeborne Gauntlets
				{ 4,   40556 }, -- Valorous Scourgeborne Legplates
				{ 7,   40559 }, -- Valorous Scourgeborne Chestguard
				{ 8,   40563 }, -- Valorous Scourgeborne Handguards
				{ 9,   40567 }, -- Valorous Scourgeborne Legguards
				{ 17,  40784 }, -- Deadly Gladiator's Dreadplate Chestpiece
				{ 18,  40806 }, -- Deadly Gladiator's Dreadplate Gauntlets
				{ 19,  40845 }, -- Deadly Gladiator's Dreadplate Legguards
				{ 102, 40469 }, -- Valorous Dreamwalker Vestments
				{ 103, 40466 }, -- Valorous Dreamwalker Gloves
				{ 104, 40468 }, -- Valorous Dreamwalker Trousers
				{ 107, 40471 }, -- Valorous Dreamwalker Raiments
				{ 108, 40472 }, -- Valorous Dreamwalker Handgrips
				{ 109, 40493 }, -- Valorous Dreamwalker Legguards
				{ 112, 40463 }, -- Valorous Dreamwalker Robe
				{ 113, 40460 }, -- Valorous Dreamwalker Handguards
				{ 114, 40462 }, -- Valorous Dreamwalker Leggings
				{ 117, 41315 }, -- Deadly Gladiator's Wyrmhide Robes
				{ 118, 41292 }, -- Deadly Gladiator's Wyrmhide Gloves
				{ 119, 41303 }, -- Deadly Gladiator's Wyrmhide Legguards
				{ 122, 41660 }, -- Deadly Gladiator's Dragonhide Robes
				{ 123, 41772 }, -- Deadly Gladiator's Dragonhide Gloves
				{ 124, 41666 }, -- Deadly Gladiator's Dragonhide Legguards
				{ 127, 41309 }, -- Deadly Gladiator's Kodohide Robes
				{ 128, 41286 }, -- Deadly Gladiator's Kodohide Gloves
				{ 129, 41297 }, -- Deadly Gladiator's Kodohide Legguards
				{ 202, 40503 }, -- Valorous Crypstalker Tunic
				{ 203, 40504 }, -- Valorous Crypstalker Handguards
				{ 204, 40506 }, -- Valorous Crypstalker Legguards
				{ 207, 40418 }, -- Valorous Frostfire Robe
				{ 208, 40415 }, -- Valorous Frostfire Gloves
				{ 209, 40417 }, -- Valorous Frostfire Leggings
				{ 212, 40495 }, -- Valorous Bonescythe Breastplate
				{ 213, 40496 }, -- Valorous Bonescythe Gauntlets
				{ 214, 40500 }, -- Valorous Bonescythe Legplates
				{ 217, 41086 }, -- Deadly Gladiator's Chain Armor
				{ 218, 41142 }, -- Deadly Gladiator's Chain Gauntlets
				{ 219, 41204 }, -- Deadly Gladiator's Chain Leggings
				{ 222, 41951 }, -- Deadly Gladiator's Silk Raiment
				{ 223, 41970 }, -- Deadly Gladiator's Silk Handguards
				{ 224, 41958 }, -- Deadly Gladiator's Silk Trousers
				{ 227, 41649 }, -- Deadly Gladiator's Leather Tunic
				{ 228, 41766 }, -- Deadly Gladiator's Leather Gloves
				{ 229, 41654 }, -- Deadly Gladiator's Leather Legguards
				{ 302, 40569 }, -- Valorous Redemption Tunic
				{ 303, 40570 }, -- Valorous Redemption Gloves
				{ 304, 40572 }, -- Valorous Redemption Greaves
				{ 307, 40574 }, -- Valorous Redemption Chestpiece
				{ 308, 40575 }, -- Valorous Redemption Gauntlets
				{ 309, 40577 }, -- Valorous Redemption Legplates
				{ 312, 40579 }, -- Valorous Redemption Breastplate
				{ 313, 40580 }, -- Valorous Redemption Handguards
				{ 314, 40583 }, -- Valorous Redemption Legguards
				{ 317, 40905 }, -- Deadly Gladiator's Ornamented Chestguard
				{ 318, 40926 }, -- Deadly Gladiator's Ornamented Gloves
				{ 319, 40938 }, -- Deadly Gladiator's Ornamented Legplates
				{ 322, 40785 }, -- Deadly Gladiator's Scaled Chestpiece
				{ 323, 40805 }, -- Deadly Gladiator's Scaled Gauntlets
				{ 324, 40846 }, -- Deadly Gladiator's Scaled Legguards
				{ 402, 40449 }, -- Valorous Robe of Faith
				{ 403, 40445 }, -- Valorous Gloves of Faith
				{ 404, 40448 }, -- Valorous Leggings of Faith
				{ 407, 40458 }, -- Valorous Raiments of Faith
				{ 408, 40454 }, -- Valorous Handwraps of Faith
				{ 409, 40457 }, -- Valorous Pants of Faith
				{ 417, 41858 }, -- Deadly Gladiator's Mooncloth Robe
				{ 418, 41873 }, -- Deadly Gladiator's Mooncloth Gloves
				{ 419, 41863 }, -- Deadly Gladiator's Mooncloth Leggings
				{ 422, 41920 }, -- Deadly Gladiator's Satin Robe
				{ 423, 41939 }, -- Deadly Gladiator's Satin Gloves
				{ 424, 41926 }, -- Deadly Gladiator's Satin Leggings
				{ 502, 40514 }, -- Valorous Earthshatter Hauberk
				{ 503, 40515 }, -- Valorous Earthshatter Gloves
				{ 504, 40517 }, -- Valorous Earthshatter Kilt
				{ 507, 40523 }, -- Valorous Earthshatter Chestguard
				{ 508, 40520 }, -- Valorous Earthshatter Grips
				{ 509, 40522 }, -- Valorous Earthshatter War-Kilt
				{ 512, 40508 }, -- Valorous Earthshatter Tunic
				{ 513, 40509 }, -- Valorous Earthshatter Handguards
				{ 514, 40512 }, -- Valorous Earthshatter Legguards
				{ 517, 40991 }, -- Deadly Gladiator's Mail Armor
				{ 518, 41006 }, -- Deadly Gladiator's Mail Gauntlets
				{ 519, 41032 }, -- Deadly Gladiator's Mail Leggings
				{ 522, 41080 }, -- Deadly Gladiator's Linked Armor
				{ 523, 41136 }, -- Deadly Gladiator's Linked Gauntlets
				{ 524, 41198 }, -- Deadly Gladiator's Linked Leggings
				{ 527, 40990 }, -- Deadly Gladiator's Ringmail Armor
				{ 528, 41000 }, -- Deadly Gladiator's Ringmail Gauntlets
				{ 529, 41026 }, -- Deadly Gladiator's Ringmail Leggings
				{ 602, 40423 }, -- Valorous Plagueheart Robe
				{ 603, 40420 }, -- Valorous Plagueheart Gloves
				{ 604, 40422 }, -- Valorous Plagueheart Leggings
				{ 607, 40525 }, -- Valorous Dreadnaught Battleplate
				{ 608, 40527 }, -- Valorous Dreadnaught Gauntlets
				{ 609, 40529 }, -- Valorous Dreadnaught Legplates
				{ 612, 40544 }, -- Valorous Dreadnaught Breastplate
				{ 613, 40545 }, -- Valorous Dreadnaught Handguards
				{ 614, 40547 }, -- Valorous Dreadnaught Legguards
				{ 617, 41997 }, -- Deadly Gladiator's Felweave Raiment
				{ 618, 42016 }, -- Deadly Gladiator's Felweave Handguards
				{ 619, 42004 }, -- Deadly Gladiator's Felweave Trousers
				{ 622, 40786 }, -- Deadly Gladiator's Plate Chestpiece
				{ 623, 40804 }, -- Deadly Gladiator's Plate Gauntlets
				{ 624, 40844 }, -- Deadly Gladiator's Plate Legguards
				{ 628, "ac1721" },
				{ 629, "ac4017" },
			},
		},
		{ --Emalon
			EncounterJournalID = 1598,
			[NORMAL_DIFF] = {
				{ 1,   "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 2,   45351 },                                                    -- Valorous Nightsong Gloves
				{ 3,   45353 },                                                    -- Valorous Nightsong Trousers
				{ 5,   "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 6,   45355 },                                                    -- Valorous Nightsong Handgrips
				{ 7,   45357 },                                                    -- Valorous Nightsong Legguards
				{ 9,   "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 10,  45345 },                                                    -- Valorous Nightsong Handguards
				{ 11,  45347 },                                                    -- Valorous Nightsong Leggings
				{ 16,  "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 17,  41292 },                                                    -- Deadly Gladiator's Wyrmhide Gloves
				{ 18,  41303 },                                                    -- Deadly Gladiator's Wyrmhide Legguards
				{ 20,  "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 21,  41772 },                                                    -- Deadly Gladiator's Dragonhide Gloves
				{ 22,  41666 },                                                    -- Deadly Gladiator's Dragonhide Legguards
				{ 24,  "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 25,  41286 },                                                    -- Deadly Gladiator's Kodohide Gloves
				{ 26,  41297 },                                                    -- Deadly Gladiator's Kodohide Legguards
				{ 101, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 102, 45360 },                                                    -- Valorous Scourgestalker Handguards
				{ 103, 45362 },                                                    -- Valorous Scourgestalker Legguards
				{ 105, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 106, 46131 },                                                    -- Valorous Kirin Tor Gauntlets
				{ 107, 45367 },                                                    -- Valorous Kirin Tor Leggings
				{ 109, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 110, 45397 },                                                    -- Valorous Terrorblade Gauntlets
				{ 111, 45399 },                                                    -- Valorous Terrorblade Legplates
				{ 113, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 114, 45419 },                                                    -- Valorous Deathbringer Gloves
				{ 115, 45420 },                                                    -- Valorous Deathbringer Leggings
				{ 116, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 117, 41142 },                                                    -- Deadly Gladiator's Chain Gauntlets
				{ 118, 41204 },                                                    -- Deadly Gladiator's Chain Leggings
				{ 120, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 121, 41970 },                                                    -- Deadly Gladiator's Silk Handguards
				{ 122, 41958 },                                                    -- Deadly Gladiator's Silk Trousers
				{ 124, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 125, 41766 },                                                    -- Deadly Gladiator's Leather Gloves
				{ 126, 41654 },                                                    -- Deadly Gladiator's Leather Legguards
				{ 128, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 129, 42016 },                                                    -- Deadly Gladiator's Felweave Handguards
				{ 130, 42004 },                                                    -- Deadly Gladiator's Felweave Trousers
				{ 201, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 202, 45370 },                                                    -- Valorous Aegis Gloves
				{ 203, 45371 },                                                    -- Valorous Aegis Greaves
				{ 205, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 206, 45376 },                                                    -- Valorous Aegis Gauntlets
				{ 207, 45379 },                                                    -- Valorous Aegis Legplates
				{ 209, "ICON_spell_holy_devotionaura",         nil,                         ALIL["PALADIN"],     ALIL["Protection"] },
				{ 210, 45383 },                                                    -- Valorous Aegis Handguards
				{ 211, 45384 },                                                    -- Valorous Aegis Legguards
				{ 216, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 217, 40926 },                                                    -- Deadly Gladiator's Ornamented Gloves
				{ 218, 40938 },                                                    -- Deadly Gladiator's Ornamented Legplates
				{ 220, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 221, 40805 },                                                    -- Deadly Gladiator's Scaled Gauntlets
				{ 222, 40846 },                                                    -- Deadly Gladiator's Scaled Legguards
				{ 301, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 302, 45387 },                                                    -- Valorous Gloves of Sanctification
				{ 303, 45388 },                                                    -- Valorous Leggings of Sanctification
				{ 305, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 306, 45392 },                                                    -- Valorous Handwraps of Sanctification
				{ 307, 45394 },                                                    -- Valorous Pants of Sanctification
				{ 316, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 317, 41873 },                                                    -- Deadly Gladiator's Mooncloth Gloves
				{ 318, 41863 },                                                    -- Deadly Gladiator's Mooncloth Leggings
				{ 320, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 321, 41939 },                                                    -- Deadly Gladiator's Satin Gloves
				{ 322, 41926 },                                                    -- Deadly Gladiator's Satin Leggings
				{ 401, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 402, 45406 },                                                    -- Valorous Worldbreaker Gloves
				{ 403, 45409 },                                                    -- Valorous Worldbreaker Kilt
				{ 405, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 406, 45414 },                                                    -- Valorous Worldbreaker Grips
				{ 407, 45416 },                                                    -- Valorous Worldbreaker War-Kilt
				{ 409, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 410, 45401 },                                                    -- Valorous Worldbreaker Handguards
				{ 411, 45403 },                                                    -- Valorous Worldbreaker Legguards
				{ 416, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 417, 41006 },                                                    -- Deadly Gladiator's Mail Gauntlets
				{ 418, 41032 },                                                    -- Deadly Gladiator's Mail Leggings
				{ 420, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 421, 41136 },                                                    -- Deadly Gladiator's Linked Gauntlets
				{ 422, 41198 },                                                    -- Deadly Gladiator's Linked Leggings
				{ 424, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 425, 41000 },                                                    -- Deadly Gladiator's Ringmail Gauntlets
				{ 426, 41026 },                                                    -- Deadly Gladiator's Ringmail Leggings
				{ 501, "ICON_spell_deathknight_frostpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 502, 45341 },                                                    -- Valorous Darkruned Gauntlets
				{ 503, 45343 },                                                    -- Valorous Darkruned Legplates
				{ 505, "ICON_spell_deathknight_bloodpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 506, 45337 },                                                    -- Valorous Darkruned Handguards
				{ 507, 45338 },                                                    -- Valorous Darkruned Legguards
				{ 509, "ICON_ability_warrior_innerrage",       nil,                         ALIL["WARRIOR"],     ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 510, 45430 },                                                    -- Valorous Siegebreaker Gauntlets
				{ 511, 45432 },                                                    -- Valorous Siegebreaker Legplates
				{ 513, "ICON_ability_warrior_defensivestance", nil,                         ALIL["WARRIOR"],     ALIL["Protection"] },
				{ 514, 45426 },                                                    -- Valorous Siegebreaker Handguards
				{ 515, 45427 },                                                    -- Valorous Siegebreaker Legguards
				{ 516, "ICON_Spell_deathknight_classicon",     nil,                         ALIL["DEATHKNIGHT"], nil },
				{ 517, 40806 },                                                    -- Deadly Gladiator's Dreadplate Gauntlets
				{ 518, 40845 },                                                    -- Deadly Gladiator's Dreadplate Legguards
				{ 524, "ICON_inv_sword_27",                    nil,                         ALIL["WARRIOR"],     nil },
				{ 525, 40804 },                                                    -- Deadly Gladiator's Plate Gauntlets
				{ 526, 40844 },                                                    -- Deadly Gladiator's Plate Legguards
				{ 601, 41908 },                                                    -- Deadly Gladiator's Cuffs of Dominance
				{ 602, 41897 },                                                    -- Deadly Gladiator's Cord of Dominance
				{ 603, 41902 },                                                    -- Deadly Gladiator's Treads of Dominance
				{ 605, 41892 },                                                    -- Deadly Gladiator's Cuffs of Salvation
				{ 606, 41880 },                                                    -- Deadly Gladiator's Cord of Salvation
				{ 607, 41884 },                                                    -- Deadly Gladiator's Treads of Salvation
				{ 616, 41639 },                                                    -- Deadly Gladiator's Armwraps of Dominance
				{ 617, 41629 },                                                    -- Deadly Gladiator's Belt of Dominance
				{ 618, 41634 },                                                    -- Deadly Gladiator's Boots of Dominance
				{ 620, 41624 },                                                    -- Deadly Gladiator's Armwraps of Salvation
				{ 621, 41616 },                                                    -- Deadly Gladiator's Belt of Salvation
				{ 622, 41620 },                                                    -- Deadly Gladiator's Boots of Salvation
				{ 624, 41839 },                                                    -- Deadly Gladiator's Armwraps of Triumph
				{ 625, 41831 },                                                    -- Deadly Gladiator's Belt of Triumph
				{ 626, 41835 },                                                    -- Deadly Gladiator's Boots of Triumph
				{ 701, 41064 },                                                    -- Deadly Gladiator's Wristguards of Dominance
				{ 702, 41069 },                                                    -- Deadly Gladiator's Waistguard of Dominance
				{ 703, 41074 },                                                    -- Deadly Gladiator's Sabatons of Dominance
				{ 705, 41059 },                                                    -- Deadly Gladiator's Wristguards of Salvation
				{ 706, 41048 },                                                    -- Deadly Gladiator's Waistguard of Salvation
				{ 707, 41054 },                                                    -- Deadly Gladiator's Sabatons of Salvation
				{ 709, 41224 },                                                    -- Deadly Gladiator's Wristguards of Triumph
				{ 710, 41234 },                                                    -- Deadly Gladiator's Waistguard of Triumph
				{ 711, 41229 },                                                    -- Deadly Gladiator's Sabatons of Triumph
				{ 716, 40982 },                                                    -- Deadly Gladiator's Bracers of Salvation
				{ 717, 40974 },                                                    -- Deadly Gladiator's Girdle of Salvation
				{ 718, 40975 },                                                    -- Deadly Gladiator's Greaves of Salvation
				{ 720, 40888 },                                                    -- Deadly Gladiator's Bracers of Triumph
				{ 721, 40879 },                                                    -- Deadly Gladiator's Girdle of Triumph
				{ 722, 40880 },                                                    -- Deadly Gladiator's Greaves of Triumph
				{ 801, 42064 },                                                    -- Deadly Gladiator's Cloak of Ascendancy
				{ 802, 42066 },                                                    -- Deadly Gladiator's Cloak of Deliverance
				{ 803, 42062 },                                                    -- Deadly Gladiator's Cloak of Dominance
				{ 804, 42065 },                                                    -- Deadly Gladiator's Cloak of Salvation
				{ 805, 42063 },                                                    -- Deadly Gladiator's Cloak of Subjugation
				{ 806, 42067 },                                                    -- Deadly Gladiator's Cloak of Triumph
				{ 807, 42068 },                                                    -- Deadly Gladiator's Cloak of Victory
				{ 809, 42030 },                                                    -- Deadly Gladiator's Pendant of Ascendancy
				{ 810, 42032 },                                                    -- Deadly Gladiator's Pendant of Deliverance
				{ 811, 42029 },                                                    -- Deadly Gladiator's Pendant of Dominance
				{ 812, 42033 },                                                    -- Deadly Gladiator's Pendant of Salvation
				{ 813, 42031 },                                                    -- Deadly Gladiator's Pendant of Subjugation
				{ 814, 42027 },                                                    -- Deadly Gladiator's Pendant of Triumph
				{ 815, 42028 },                                                    -- Deadly Gladiator's Pendant of Victory
				{ 816, 42114 },                                                    -- Deadly Gladiator's Band of Ascendancy
				{ 817, 42115 },                                                    -- Deadly Gladiator's Band of Victory
				{ 819, [ATLASLOOT_IT_ALLIANCE] = 43959,        [ATLASLOOT_IT_HORDE] = 44083 }, -- Reins of the Grand Black War Mammoth
				{ 821, "ac3136" },
				{ 822, "ac4016" },
			},
			[P25_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 2,   46189 }, -- Conqueror's Nightsong Gloves
				{ 3,   46192 }, -- Conqueror's Nightsong Trousers
				{ 6,   46158 }, -- Conqueror's Nightsong Handgrips
				{ 7,   46160 }, -- Conqueror's Nightsong Legguards
				{ 10,  46183 }, -- Conqueror's Nightsong Handguards
				{ 11,  46185 }, -- Conqueror's Nightsong Leggings
				{ 17,  41293 }, -- Furious Gladiator's Wyrmhide Gloves
				{ 18,  41304 }, -- Furious Gladiator's Wyrmhide Legguards
				{ 21,  41773 }, -- Furious Gladiator's Dragonhide Gloves
				{ 22,  41667 }, -- Furious Gladiator's Dragonhide Legguards
				{ 25,  41287 }, -- Furious Gladiator's Kodohide Gloves
				{ 26,  41298 }, -- Furious Gladiator's Kodohide Legguards
				{ 102, 46142 }, -- Conqueror's Scourgestalker Handguards
				{ 103, 46144 }, -- Conqueror's Scourgestalker Legguards
				{ 106, 46132 }, -- Conqueror's Kirin Tor Gauntlets
				{ 107, 46133 }, -- Conqueror's Kirin Tor Leggings
				{ 110, 46124 }, -- Conqueror's Terrorblade Gauntlets
				{ 111, 46126 }, -- Conqueror's Terrorblade Legplates
				{ 114, 46135 }, -- Conqueror's Deathbringer Gloves
				{ 115, 46139 }, -- Conqueror's Deathbringer Leggings
				{ 117, 41143 }, -- Furious Gladiator's Chain Gauntlets
				{ 118, 41205 }, -- Furious Gladiator's Chain Leggings
				{ 121, 41971 }, -- Furious Gladiator's Silk Handguards
				{ 122, 41959 }, -- Furious Gladiator's Silk Trousers
				{ 125, 41767 }, -- Furious Gladiator's Leather Gloves
				{ 126, 41655 }, -- Furious Gladiator's Leather Legguards
				{ 129, 42017 }, -- Furious Gladiator's Felweave Handguards
				{ 130, 42005 }, -- Furious Gladiator's Felweave Trousers
				{ 202, 46179 }, -- Conqueror's Aegis Gloves
				{ 203, 46181 }, -- Conqueror's Aegis Greaves
				{ 206, 46155 }, -- Conqueror's Aegis Gauntlets
				{ 207, 46153 }, -- Conqueror's Aegis Legplates
				{ 210, 46174 }, -- Conqueror's Aegis Handguards
				{ 211, 46176 }, -- Conqueror's Aegis Legguards
				{ 217, 40927 }, -- Furious Gladiator's Ornamented Gloves
				{ 218, 40939 }, -- Furious Gladiator's Ornamented Legplates
				{ 221, 40808 }, -- Furious Gladiator's Scaled Gauntlets
				{ 222, 40849 }, -- Furious Gladiator's Scaled Legguards
				{ 302, 46188 }, -- Conqueror's Gloves of Sanctification
				{ 303, 46195 }, -- Conqueror's Leggings of Sanctification
				{ 306, 46163 }, -- Conqueror's Handwraps of Sanctification
				{ 307, 46170 }, -- Conqueror's Pants of Sanctification
				{ 317, 41874 }, -- Furious Gladiator's Mooncloth Gloves
				{ 318, 41864 }, -- Furious Gladiator's Mooncloth Leggings
				{ 321, 41940 }, -- Furious Gladiator's Satin Gloves
				{ 322, 41927 }, -- Furious Gladiator's Satin Leggings
				{ 402, 46207 }, -- Conqueror's Worldbreaker Gloves
				{ 403, 46210 }, -- Conqueror's Worldbreaker Kilt
				{ 406, 46200 }, -- Conqueror's Worldbreaker Grips
				{ 407, 46208 }, -- Conqueror's Worldbreaker War-Kilt
				{ 410, 46199 }, -- Conqueror's Worldbreaker Handguards
				{ 411, 46202 }, -- Conqueror's Worldbreaker Legguards
				{ 417, 41007 }, -- Furious Gladiator's Mail Gauntlets
				{ 418, 41033 }, -- Furious Gladiator's Mail Leggings
				{ 421, 41137 }, -- Furious Gladiator's Linked Gauntlets
				{ 422, 41199 }, -- Furious Gladiator's Linked Leggings
				{ 425, 41001 }, -- Furious Gladiator's Ringmail Gauntlets
				{ 426, 41027 }, -- Furious Gladiator's Ringmail Leggings
				{ 502, 46113 }, -- Conqueror's Darkruned Gauntlets
				{ 503, 46116 }, -- Conqueror's Darkruned Legplates
				{ 506, 46119 }, -- Conqueror's Darkruned Handguards
				{ 507, 46121 }, -- Conqueror's Darkruned Legguards
				{ 510, 46148 }, -- Conqueror's Siegebreaker Gauntlets
				{ 511, 46150 }, -- Conqueror's Siegebreaker Legplates
				{ 514, 46164 }, -- Conqueror's Siegebreaker Handguards
				{ 515, 46169 }, -- Conqueror's Siegebreaker Legguards
				{ 517, 40809 }, -- Furious Gladiator's Dreadplate Gauntlets
				{ 518, 40848 }, -- Furious Gladiator's Dreadplate Legguards
				{ 525, 40807 }, -- Furious Gladiator's Plate Gauntlets
				{ 526, 40847 }, -- Furious Gladiator's Plate Legguards
				{ 601, 41909 }, -- Furious Gladiator's Cuffs of Dominance
				{ 602, 41898 }, -- Furious Gladiator's Cord of Dominance
				{ 603, 41903 }, -- Furious Gladiator's Treads of Dominance
				{ 605, 41893 }, -- Furious Gladiator's Cuffs of Salvation
				{ 606, 41881 }, -- Furious Gladiator's Cord of Salvation
				{ 607, 41885 }, -- Furious Gladiator's Slippers of Salvation
				{ 616, 41640 }, -- Furious Gladiator's Armwraps of Dominance
				{ 617, 41630 }, -- Furious Gladiator's Belt of Dominance
				{ 618, 41635 }, -- Furious Gladiator's Boots of Dominance
				{ 620, 41625 }, -- Furious Gladiator's Armwraps of Salvation
				{ 621, 41617 }, -- Furious Gladiator's Belt of Salvation
				{ 622, 41621 }, -- Furious Gladiator's Boots of Salvation
				{ 624, 41840 }, -- Furious Gladiator's Armwraps of Triumph
				{ 625, 41832 }, -- Furious Gladiator's Belt of Triumph
				{ 626, 41836 }, -- Furious Gladiator's Boots of Triumph
				{ 701, 41065 }, -- Furious Gladiator's Wristguards of Dominance
				{ 702, 41070 }, -- Furious Gladiator's Waistguard of Dominance
				{ 703, 41075 }, -- Furious Gladiator's Sabatons of Dominance
				{ 705, 41060 }, -- Furious Gladiator's Wristguards of Salvation
				{ 706, 41051 }, -- Furious Gladiator's Waistguard of Salvation
				{ 707, 41055 }, -- Furious Gladiator's Sabatons of Salvation
				{ 709, 41225 }, -- Furious Gladiator's Wristguards of Triumph
				{ 710, 41235 }, -- Furious Gladiator's Waistguard of Triumph
				{ 711, 41230 }, -- Furious Gladiator's Sabatons of Triumph
				{ 716, 40983 }, -- Furious Gladiator's Bracers of Salvation
				{ 717, 40976 }, -- Furious Gladiator's Girdle of Salvation
				{ 718, 40977 }, -- Furious Gladiator's Greaves of Salvation
				{ 720, 40889 }, -- Furious Gladiator's Bracers of Triumph
				{ 721, 40881 }, -- Furious Gladiator's Girdle of Triumph
				{ 722, 40882 }, -- Furious Gladiator's Greaves of Triumph
				{ 801, 42071 }, -- Furious Gladiator's Cloak of Ascendancy
				{ 802, 42073 }, -- Furious Gladiator's Cloak of Deliverance
				{ 803, 42069 }, -- Furious Gladiator's Cloak of Dominance
				{ 804, 42072 }, -- Furious Gladiator's Cloak of Salvation
				{ 805, 42070 }, -- Furious Gladiator's Cloak of Subjugation
				{ 806, 42074 }, -- Furious Gladiator's Cloak of Triumph
				{ 807, 42075 }, -- Furious Gladiator's Cloak of Victory
				{ 808, 42037 }, -- Furious Gladiator's Pendant of Ascendancy
				{ 809, 42039 }, -- Furious Gladiator's Pendant of Deliverance
				{ 810, 42036 }, -- Furious Gladiator's Pendant of Dominance
				{ 811, 42040 }, -- Furious Gladiator's Pendant of Salvation
				{ 812, 42038 }, -- Furious Gladiator's Pendant of Subjugation
				{ 813, 46373 }, -- Furious Gladiator's Pendant of Sundering
				{ 814, 42034 }, -- Furious Gladiator's Pendant of Triumph
				{ 815, 42035 }, -- Furious Gladiator's Pendant of Victory
				{ 816, 42116 }, -- Furious Gladiator's Band of Dominance
				{ 817, 42117 }, -- Furious Gladiator's Band of VicTriumphtory
				{ 821, "ac3137" },
				{ 822, "ac4017" },
			},
		},
		{ --Koralon
			EncounterJournalID = 1599,
			[NORMAL_DIFF] = {
				{ 1,   "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 2,   [ATLASLOOT_IT_ALLIANCE] = 48162,        [ATLASLOOT_IT_HORDE] = 48183 }, -- Stormrage's Gloves of Conquest / Runetotem's Gloves of Conquest
				{ 3,   [ATLASLOOT_IT_ALLIANCE] = 48160,        [ATLASLOOT_IT_HORDE] = 48185 }, -- Stormrage's Trousers of Conquest / Runetotem's Trousers of Conquest
				{ 5,   "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 6,   [ATLASLOOT_IT_ALLIANCE] = 48213,        [ATLASLOOT_IT_HORDE] = 48192 }, -- Stormrage's Handgrips of Conquest / Runetotem's Handgrips of Conquest
				{ 7,   [ATLASLOOT_IT_ALLIANCE] = 48215,        [ATLASLOOT_IT_HORDE] = 48190 }, -- Stormrage's Legguards of Conquest / Runetotem's Legguards of Conquest
				{ 9,   "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 10,  [ATLASLOOT_IT_ALLIANCE] = 48132,        [ATLASLOOT_IT_HORDE] = 48153 }, -- Stormrage's Handguards of Conquest / Runetotem's Handguards of Conquest
				{ 11,  [ATLASLOOT_IT_ALLIANCE] = 48130,        [ATLASLOOT_IT_HORDE] = 48155 }, -- Stormrage's Leggings of Conquest / Runetotem's Leggings of Conquest
				{ 16,  "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 17,  41293 },                                                    -- Furious Gladiator's Wyrmhide Gloves
				{ 18,  41304 },                                                    -- Furious Gladiator's Wyrmhide Legguards
				{ 20,  "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 21,  41773 },                                                    -- Furious Gladiator's Dragonhide Gloves
				{ 22,  41667 },                                                    -- Furious Gladiator's Dragonhide Legguards
				{ 24,  "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 25,  41287 },                                                    -- Furious Gladiator's Kodohide Gloves
				{ 26,  41298 },                                                    -- Furious Gladiator's Kodohide Legguards
				{ 101, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 102, [ATLASLOOT_IT_ALLIANCE] = 48254,        [ATLASLOOT_IT_HORDE] = 48276 }, -- Windrunner's Handguards of Conquest
				{ 103, [ATLASLOOT_IT_ALLIANCE] = 48252,        [ATLASLOOT_IT_HORDE] = 48278 }, -- Windrunner's Legguards of Conquest
				{ 105, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 106, [ATLASLOOT_IT_ALLIANCE] = 47752,        [ATLASLOOT_IT_HORDE] = 47773 }, -- Khadgar's Gauntlets of Conquest / Sunstrider's Gauntlets of Conquest
				{ 107, [ATLASLOOT_IT_ALLIANCE] = 47750,        [ATLASLOOT_IT_HORDE] = 47775 }, -- Khadgar's Leggings of Conquest / Sunstrider's Leggings of Conquest
				{ 109, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 110, [ATLASLOOT_IT_ALLIANCE] = 48222,        [ATLASLOOT_IT_HORDE] = 48244 }, -- VanCleef's Gauntlets of Conquest / Garona's Gauntlets of Conquest
				{ 111, [ATLASLOOT_IT_ALLIANCE] = 48220,        [ATLASLOOT_IT_HORDE] = 48246 }, -- VanCleef's Legplates of Conquest / Garona's Legplates of Conquest
				{ 113, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 114, [ATLASLOOT_IT_ALLIANCE] = 47783,        [ATLASLOOT_IT_HORDE] = 47802 }, -- Kel'Thuzad's Gloves of Conquest / Gul'dan's Gloves of Conquest
				{ 115, [ATLASLOOT_IT_ALLIANCE] = 47785,        [ATLASLOOT_IT_HORDE] = 47800 }, -- Kel'Thuzad's Leggings of Conquest / Gul'dan's Leggings of Conquest
				{ 116, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 117, 41143 },                                                    -- Furious Gladiator's Chain Gauntlets
				{ 118, 41205 },                                                    -- Furious Gladiator's Chain Leggings
				{ 120, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 121, 41971 },                                                    -- Furious Gladiator's Silk Handguards
				{ 122, 41959 },                                                    -- Furious Gladiator's Silk Trousers
				{ 124, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 125, 41767 },                                                    -- Furious Gladiator's Leather Gloves
				{ 126, 41655 },                                                    -- Furious Gladiator's Leather Legguards
				{ 128, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 129, 42017 },                                                    -- Furious Gladiator's Felweave Handguards
				{ 130, 42005 },                                                    -- Furious Gladiator's Felweave Trousers
				{ 201, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 202, [ATLASLOOT_IT_ALLIANCE] = 48574,        [ATLASLOOT_IT_HORDE] = 48598 }, -- Turalyon's Gloves of Conquest / Liadrin's Gloves of Conquest
				{ 203, [ATLASLOOT_IT_ALLIANCE] = 48568,        [ATLASLOOT_IT_HORDE] = 48596 }, -- Turalyon's Greaves of Conquest / Liadrin's Greaves of Conquest
				{ 205, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 206, [ATLASLOOT_IT_ALLIANCE] = 48603,        [ATLASLOOT_IT_HORDE] = 48630 }, -- Turalyon's Gauntlets of Conquest / Liadrin's Gauntlets of Conquest
				{ 207, [ATLASLOOT_IT_ALLIANCE] = 48605,        [ATLASLOOT_IT_HORDE] = 48628 }, -- Turalyon's Legplates of Conquest / Liadrin's Legplates of Conquest
				{ 209, "ICON_spell_holy_devotionaura",         nil,                         ALIL["PALADIN"],     ALIL["Protection"] },
				{ 210, [ATLASLOOT_IT_ALLIANCE] = 48633,        [ATLASLOOT_IT_HORDE] = 48653 }, -- Turalyon's Handguards of Conquest / Liadrin's Handguards of Conquest
				{ 211, [ATLASLOOT_IT_ALLIANCE] = 48635,        [ATLASLOOT_IT_HORDE] = 48655 }, -- Turalyon's Legguards of Conquest / Liadrin's Legguards of Conquest
				{ 216, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 217, 40927 },                                                    -- Furious Gladiator's Ornamented Gloves
				{ 218, 40939 },                                                    -- Furious Gladiator's Ornamented Legplates
				{ 220, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 221, 40808 },                                                    -- Furious Gladiator's Scaled Gauntlets
				{ 222, 40849 },                                                    -- Furious Gladiator's Scaled Legguards
				{ 301, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 302, [ATLASLOOT_IT_ALLIANCE] = 47982,        [ATLASLOOT_IT_HORDE] = 48067 }, -- Velen's Gloves of Conquest / Zabra's Gloves of Conquest
				{ 303, [ATLASLOOT_IT_ALLIANCE] = 47980,        [ATLASLOOT_IT_HORDE] = 48069 }, -- Velen's Leggings of Conquest / Zabra's Leggings of Conquest
				{ 305, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 306, [ATLASLOOT_IT_ALLIANCE] = 48072,        [ATLASLOOT_IT_HORDE] = 48097 }, -- Velen's Handwraps of Conquest / Zabra's Handwraps of Conquest
				{ 307, [ATLASLOOT_IT_ALLIANCE] = 48074,        [ATLASLOOT_IT_HORDE] = 48099 }, -- Velen's Pants of Conquest / Zabra's Pants of Conquest
				{ 316, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 317, 41874 },                                                    -- Furious Gladiator's Mooncloth Gloves
				{ 318, 41864 },                                                    -- Furious Gladiator's Mooncloth Leggings
				{ 320, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 321, 41940 },                                                    -- Furious Gladiator's Satin Gloves
				{ 322, 41927 },                                                    -- Furious Gladiator's Satin Leggings
				{ 401, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 402, [ATLASLOOT_IT_ALLIANCE] = 48312,        [ATLASLOOT_IT_HORDE] = 48337 }, -- Nobundo's Gloves of Conquest / Thrall's Gloves of Conquest
				{ 403, [ATLASLOOT_IT_ALLIANCE] = 48314,        [ATLASLOOT_IT_HORDE] = 48339 }, -- Nobundo's Kilt of Conquest / Thrall's Kilt of Conquest
				{ 405, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 406, [ATLASLOOT_IT_ALLIANCE] = 48342,        [ATLASLOOT_IT_HORDE] = 48367 }, -- Nobundo's Grips of Conquest / Thrall's Grips of Conquest
				{ 407, [ATLASLOOT_IT_ALLIANCE] = 48344,        [ATLASLOOT_IT_HORDE] = 48369 }, -- Nobundo's War-Kilt of Conquest / Thrall's War-Kilt of Conquest
				{ 409, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 410, [ATLASLOOT_IT_ALLIANCE] = 48284,        [ATLASLOOT_IT_HORDE] = 48296 }, -- Nobundo's Handguards of Conquest / Thrall's Handguards of Conquest
				{ 411, [ATLASLOOT_IT_ALLIANCE] = 48282,        [ATLASLOOT_IT_HORDE] = 48298 }, -- Nobundo's Legguards of Conquest / Thrall's Legguards of Conquest
				{ 416, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 417, 41007 },                                                    -- Furious Gladiator's Mail Gauntlets
				{ 418, 41033 },                                                    -- Furious Gladiator's Mail Leggings
				{ 420, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 421, 41137 },                                                    -- Furious Gladiator's Linked Gauntlets
				{ 422, 41199 },                                                    -- Furious Gladiator's Linked Leggings
				{ 424, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 425, 41001 },                                                    -- Furious Gladiator's Ringmail Gauntlets
				{ 426, 41027 },                                                    -- Furious Gladiator's Ringmail Leggings
				{ 501, "ICON_spell_deathknight_frostpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 502, [ATLASLOOT_IT_ALLIANCE] = 48480,        [ATLASLOOT_IT_HORDE] = 48502 }, -- Thassarian's Gauntlets of Conquest / Koltira's Gauntlets of Conquest
				{ 503, [ATLASLOOT_IT_ALLIANCE] = 48476,        [ATLASLOOT_IT_HORDE] = 48504 }, -- Thassarian's Legplates of Conquest / Koltira's Legplates of Conquest
				{ 505, "ICON_spell_deathknight_bloodpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 506, [ATLASLOOT_IT_ALLIANCE] = 48537,        [ATLASLOOT_IT_HORDE] = 48559 }, -- Thassarian's Handguards of Conquest / Koltira's Handguards of Conquest
				{ 507, [ATLASLOOT_IT_ALLIANCE] = 48533,        [ATLASLOOT_IT_HORDE] = 48561 }, -- Thassarian's Legguards of Conquest / Koltira's Legguards of Conquest
				{ 509, "ICON_ability_warrior_innerrage",       nil,                         ALIL["WARRIOR"],     ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 510, [ATLASLOOT_IT_ALLIANCE] = 48375,        [ATLASLOOT_IT_HORDE] = 48387 }, -- Wrynn's Gauntlets of Conquest / Hellscream's Gauntlets of Conquest
				{ 511, [ATLASLOOT_IT_ALLIANCE] = 48373,        [ATLASLOOT_IT_HORDE] = 48389 }, -- Wrynn's Legplates of Conquest / Hellscream's Legplates of Conquest
				{ 513, "ICON_ability_warrior_defensivestance", nil,                         ALIL["WARRIOR"],     ALIL["Protection"] },
				{ 514, [ATLASLOOT_IT_ALLIANCE] = 48449,        [ATLASLOOT_IT_HORDE] = 48457 }, -- Wrynn's Handguards of Conquest / Hellscream's Handguards of Conquest
				{ 515, [ATLASLOOT_IT_ALLIANCE] = 48445,        [ATLASLOOT_IT_HORDE] = 48459 }, -- Wrynn's Legguards of Conquest / Hellscream's Legguards of Conquest
				{ 516, "ICON_Spell_deathknight_classicon",     nil,                         ALIL["DEATHKNIGHT"], nil },
				{ 517, 40809 },                                                    -- Furious Gladiator's Dreadplate Gauntlets
				{ 518, 40848 },                                                    -- Furious Gladiator's Dreadplate Legguards
				{ 524, "ICON_inv_sword_27",                    nil,                         ALIL["WARRIOR"],     nil },
				{ 525, 40807 },                                                    -- Furious Gladiator's Plate Gauntlets
				{ 526, 40847 },                                                    -- Furious Gladiator's Plate Legguards
				{ 601, 41909 },                                                    -- Furious Gladiator's Cuffs of Dominance
				{ 602, 41898 },                                                    -- Furious Gladiator's Cord of Dominance
				{ 603, 41903 },                                                    -- Furious Gladiator's Slippers of Dominance
				{ 605, 41893 },                                                    -- Furious Gladiator's Cuffs of Salvation
				{ 606, 41881 },                                                    -- Furious Gladiator's Cord of Salvation
				{ 607, 41885 },                                                    -- Furious Gladiator's Slippers of Salvation
				{ 616, 41640 },                                                    -- Furious Gladiator's Armwraps of Dominance
				{ 617, 41630 },                                                    -- Furious Gladiator's Belt of Dominance
				{ 618, 41635 },                                                    -- Furious Gladiator's Boots of Dominance
				{ 620, 41625 },                                                    -- Furious Gladiator's Armwraps of Salvation
				{ 621, 41617 },                                                    -- Furious Gladiator's Belt of Salvation
				{ 622, 41621 },                                                    -- Furious Gladiator's Boots of Salvation
				{ 624, 41840 },                                                    -- Furious Gladiator's Armwraps of Triumph
				{ 625, 41832 },                                                    -- Furious Gladiator's Belt of Triumph
				{ 626, 41836 },                                                    -- Furious Gladiator's Boots of Triumph
				{ 701, 41065 },                                                    -- Furious Gladiator's Wristguards of Dominance
				{ 702, 41070 },                                                    -- Furious Gladiator's Waistguard of Dominance
				{ 703, 41075 },                                                    -- Furious Gladiator's Sabatons of Dominance
				{ 705, 41060 },                                                    -- Furious Gladiator's Wristguards of Salvation
				{ 706, 41051 },                                                    -- Furious Gladiator's Waistguard of Salvation
				{ 707, 41055 },                                                    -- Furious Gladiator's Sabatons of Salvation
				{ 709, 41225 },                                                    -- Furious Gladiator's Wristguards of Triumph
				{ 710, 41235 },                                                    -- Furious Gladiator's Waistguard of Triumph
				{ 711, 41230 },                                                    -- Furious Gladiator's Sabatons of Triumph
				{ 716, 40983 },                                                    -- Furious Gladiator's Bracers of Salvation
				{ 717, 40976 },                                                    -- Furious Gladiator's Girdle of Salvation
				{ 718, 40977 },                                                    -- Furious Gladiator's Greaves of Salvation
				{ 720, 40889 },                                                    -- Furious Gladiator's Bracers of Triumph
				{ 721, 40881 },                                                    -- Furious Gladiator's Girdle of Triumph
				{ 722, 40882 },                                                    -- Furious Gladiator's Greaves of Triumph
				{ 801, 42071 },                                                    -- Furious Gladiator's Cloak of Ascendancy
				{ 802, 42073 },                                                    -- Furious Gladiator's Cloak of Deliverance
				{ 803, 42069 },                                                    -- Furious Gladiator's Cloak of Dominance
				{ 804, 42072 },                                                    -- Furious Gladiator's Cloak of Salvation
				{ 805, 42070 },                                                    -- Furious Gladiator's Cloak of Subjugation
				{ 806, 42074 },                                                    -- Furious Gladiator's Cloak of Triumph
				{ 807, 42075 },                                                    -- Furious Gladiator's Cloak of Victory
				{ 808, 42037 },                                                    -- Furious Gladiator's Pendant of Ascendancy
				{ 809, 42039 },                                                    -- Furious Gladiator's Pendant of Deliverance
				{ 810, 42036 },                                                    -- Furious Gladiator's Pendant of Dominance
				{ 811, 42040 },                                                    -- Furious Gladiator's Pendant of Salvation
				{ 812, 42038 },                                                    -- Furious Gladiator's Pendant of Subjugation
				{ 813, 46373 },                                                    -- Furious Gladiator's Pendant of Sundering
				{ 814, 42034 },                                                    -- Furious Gladiator's Pendant of Triumph
				{ 815, 42035 },                                                    -- Furious Gladiator's Pendant of Victory
				{ 816, 42116 },                                                    -- Furious Gladiator's Band of Dominance
				{ 817, 42117 },                                                    -- Furious Gladiator's Band of Triumph
				{ 819, [ATLASLOOT_IT_ALLIANCE] = 43959,        [ATLASLOOT_IT_HORDE] = 44083 }, -- Reins of the Grand Black War Mammoth
				{ 821, "ac3836" },
				{ 822, "ac4016" },
			},
			[P25_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 2,   [ATLASLOOT_IT_ALLIANCE] = 48163, [ATLASLOOT_IT_HORDE] = 48182 }, -- Stormrage's Gloves of Triumph / Runetotem's Gloves of Triumph
				{ 3,   [ATLASLOOT_IT_ALLIANCE] = 48165, [ATLASLOOT_IT_HORDE] = 48180 }, -- Stormrage's Trousers of Triumph / Runetotem's Trousers of Triumph
				{ 6,   [ATLASLOOT_IT_ALLIANCE] = 48212, [ATLASLOOT_IT_HORDE] = 48193 }, -- Stormrage's Handgrips of Triumph / Runetotem's Handgrips of Triumph
				{ 7,   [ATLASLOOT_IT_ALLIANCE] = 48210, [ATLASLOOT_IT_HORDE] = 48195 }, -- Stormrage's Legguards of Triumph / Runetotem's Legguards of Triumph
				{ 10,  [ATLASLOOT_IT_ALLIANCE] = 48133, [ATLASLOOT_IT_HORDE] = 48152 }, -- Stormrage's Handguards of Triumph / Runetotem's Handguards of Triumph
				{ 11,  [ATLASLOOT_IT_ALLIANCE] = 48135, [ATLASLOOT_IT_HORDE] = 48150 }, -- Stormrage's Leggings of Triumph / Runetotem's Leggings of Triumph
				{ 17,  41294 },                                             -- Relentless Gladiator's Wyrmhide Gloves
				{ 18,  41305 },                                             -- Relentless Gladiator's Wyrmhide Legguards
				{ 21,  41774 },                                             -- Relentless Gladiator's Dragonhide Gloves
				{ 22,  41668 },                                             -- Relentless Gladiator's Dragonhide Legguards
				{ 25,  41288 },                                             -- Relentless Gladiator's Kodohide Gloves
				{ 26,  41299 },                                             -- Relentless Gladiator's Kodohide Legguards
				{ 102, [ATLASLOOT_IT_ALLIANCE] = 48256, [ATLASLOOT_IT_HORDE] = 48273 }, -- Windrunner's Handguards of Triumph
				{ 103, [ATLASLOOT_IT_ALLIANCE] = 48258, [ATLASLOOT_IT_HORDE] = 48271 }, -- Windrunner's Legguards of Triumph
				{ 106, [ATLASLOOT_IT_ALLIANCE] = 47753, [ATLASLOOT_IT_HORDE] = 47772 }, -- Khadgar's Gauntlets of Triumph / Sunstrider's Gauntlets of Triumph
				{ 107, [ATLASLOOT_IT_ALLIANCE] = 47755, [ATLASLOOT_IT_HORDE] = 47770 }, -- Khadgar's Leggings of Triumph / Sunstrider's Leggings of Triumph
				{ 110, [ATLASLOOT_IT_ALLIANCE] = 48224, [ATLASLOOT_IT_HORDE] = 48241 }, -- VanCleef's Gauntlets of Triumph / Garona's Gauntlets of Triumph
				{ 111, [ATLASLOOT_IT_ALLIANCE] = 48226, [ATLASLOOT_IT_HORDE] = 48239 }, -- VanCleef's Legplates of Triumph / Garona's Legplates of Triumph
				{ 114, [ATLASLOOT_IT_ALLIANCE] = 47782, [ATLASLOOT_IT_HORDE] = 47803 }, -- Kel'Thuzad's Gloves of Triumph / Gul'dan's Gloves of Triumph
				{ 115, [ATLASLOOT_IT_ALLIANCE] = 47780, [ATLASLOOT_IT_HORDE] = 47805 }, -- Kel'Thuzad's Leggings of Triumph / Gul'dan's Leggings of Triumph
				{ 117, 41144 },                                             -- Relentless Gladiator's Chain Gauntlets
				{ 118, 41206 },                                             -- Relentless Gladiator's Chain Leggings
				{ 121, 41972 },                                             -- Relentless Gladiator's Silk Handguards
				{ 122, 41960 },                                             -- Relentless Gladiator's Silk Trousers
				{ 125, 41768 },                                             -- Relentless Gladiator's Leather Gloves
				{ 126, 41656 },                                             -- Relentless Gladiator's Leather Legguards
				{ 129, 42018 },                                             -- Relentless Gladiator's Felweave Handguards
				{ 130, 42006 },                                             -- Relentless Gladiator's Felweave Trousers
				{ 202, [ATLASLOOT_IT_ALLIANCE] = 48576, [ATLASLOOT_IT_HORDE] = 48593 }, -- Turalyon's Gloves of Triumph / Liadrin's Gloves of Triumph
				{ 203, [ATLASLOOT_IT_ALLIANCE] = 48578, [ATLASLOOT_IT_HORDE] = 48591 }, -- Turalyon's Greaves of Triumph / Liadrin's Greaves of Triumph
				{ 206, [ATLASLOOT_IT_ALLIANCE] = 48608, [ATLASLOOT_IT_HORDE] = 48625 }, -- Turalyon's Gauntlets of Triumph / Liadrin's Gauntlets of Triumph
				{ 207, [ATLASLOOT_IT_ALLIANCE] = 48610, [ATLASLOOT_IT_HORDE] = 48623 }, -- Turalyon's Legplates of Triumph / Liadrin's Legplates of Triumph
				{ 210, [ATLASLOOT_IT_ALLIANCE] = 48640, [ATLASLOOT_IT_HORDE] = 48658 }, -- Turalyon's Handguards of Triumph / Liadrin's Handguards of Triumph
				{ 211, [ATLASLOOT_IT_ALLIANCE] = 48638, [ATLASLOOT_IT_HORDE] = 48660 }, -- Turalyon's Legguards of Triumph / Liadrin's Legguards of Triumph
				{ 217, 40928 },                                             -- Relentless Gladiator's Ornamented Gloves
				{ 218, 40940 },                                             -- Relentless Gladiator's Ornamented Legplates
				{ 221, 40812 },                                             -- Relentless Gladiator's Scaled Gauntlets
				{ 222, 40852 },                                             -- Relentless Gladiator's Scaled Legguards
				{ 302, [ATLASLOOT_IT_ALLIANCE] = 47983, [ATLASLOOT_IT_HORDE] = 48066 }, -- Velen's Gloves of Triumph / Zabra's Gloves of Triumph
				{ 303, [ATLASLOOT_IT_ALLIANCE] = 47985, [ATLASLOOT_IT_HORDE] = 48064 }, -- Velen's Leggings of Triumph / Zabra's Leggings of Triumph
				{ 306, [ATLASLOOT_IT_ALLIANCE] = 48077, [ATLASLOOT_IT_HORDE] = 48096 }, -- Velen's Handwraps of Triumph / Zabra's Handwraps of Triumph
				{ 307, [ATLASLOOT_IT_ALLIANCE] = 48079, [ATLASLOOT_IT_HORDE] = 48094 }, -- Velen's Pants of Triumph / Zabra's Pants of Triumph
				{ 317, 41875 },                                             -- Relentless Gladiator's Mooncloth Gloves
				{ 318, 41865 },                                             -- Relentless Gladiator's Mooncloth Leggings
				{ 321, 41941 },                                             -- Relentless Gladiator's Satin Gloves
				{ 322, 41928 },                                             -- Relentless Gladiator's Satin Leggings
				{ 402, [ATLASLOOT_IT_ALLIANCE] = 48317, [ATLASLOOT_IT_HORDE] = 48334 }, -- Nobundo's Gloves of Triumph / Thrall's Gloves of Triumph
				{ 403, [ATLASLOOT_IT_ALLIANCE] = 48319, [ATLASLOOT_IT_HORDE] = 48332 }, -- Nobundo's Kilt of Triumph / Thrall's Kilt of Triumph
				{ 406, [ATLASLOOT_IT_ALLIANCE] = 48347, [ATLASLOOT_IT_HORDE] = 48364 }, -- Nobundo's Grips of Triumph / Thrall's Grips of Triumph
				{ 407, [ATLASLOOT_IT_ALLIANCE] = 48349, [ATLASLOOT_IT_HORDE] = 48362 }, -- Nobundo's War-Kilt of Triumph / Thrall's War-Kilt of Triumph
				{ 410, [ATLASLOOT_IT_ALLIANCE] = 48286, [ATLASLOOT_IT_HORDE] = 48301 }, -- Nobundo's Handguards of Triumph / Thrall's Handguards of Triumph
				{ 411, [ATLASLOOT_IT_ALLIANCE] = 48288, [ATLASLOOT_IT_HORDE] = 48303 }, -- Nobundo's Legguards of Triumph / Thrall's Legguards of Triumph
				{ 417, 41008 },                                             -- Relentless Gladiator's Mail Gauntlets
				{ 418, 41034 },                                             -- Relentless Gladiator's Mail Leggings
				{ 421, 41138 },                                             -- Relentless Gladiator's Linked Gauntlets
				{ 422, 41200 },                                             -- Relentless Gladiator's Linked Leggings
				{ 425, 41002 },                                             -- Relentless Gladiator's Ringmail Gauntlets
				{ 426, 41028 },                                             -- Relentless Gladiator's Ringmail Leggings
				{ 502, [ATLASLOOT_IT_ALLIANCE] = 48482, [ATLASLOOT_IT_HORDE] = 48499 }, -- Thassarian's Gauntlets of Triumph / Koltira's Gauntlets of Triumph
				{ 503, [ATLASLOOT_IT_ALLIANCE] = 48484, [ATLASLOOT_IT_HORDE] = 48497 }, -- Thassarian's Legplates of Triumph / Koltira's Legplates of Triumph
				{ 506, [ATLASLOOT_IT_ALLIANCE] = 48539, [ATLASLOOT_IT_HORDE] = 48556 }, -- Thassarian's Handguards of Triumph / Koltira's Handguards of Triumph
				{ 507, [ATLASLOOT_IT_ALLIANCE] = 48541, [ATLASLOOT_IT_HORDE] = 48554 }, -- Thassarian's Legguards of Triumph / Koltira's Legguards of Triumph
				{ 510, [ATLASLOOT_IT_ALLIANCE] = 48377, [ATLASLOOT_IT_HORDE] = 48392 }, -- Wrynn's Gauntlets of Triumph / Hellscream's Gauntlets of Triumph
				{ 511, [ATLASLOOT_IT_ALLIANCE] = 48379, [ATLASLOOT_IT_HORDE] = 48394 }, -- Wrynn's Legplates of Triumph / Hellscream's Legplates of Triumph
				{ 514, [ATLASLOOT_IT_ALLIANCE] = 48452, [ATLASLOOT_IT_HORDE] = 48462 }, -- Wrynn's Handguards of Triumph / Hellscream's Handguards of Triumph
				{ 515, [ATLASLOOT_IT_ALLIANCE] = 48446, [ATLASLOOT_IT_HORDE] = 48464 }, -- Wrynn's Legguards of Triumph / Hellscream's Legguards of Triumph
				{ 517, 40811 },                                             -- Relentless Gladiator's Dreadplate Gauntlets
				{ 518, 40851 },                                             -- Relentless Gladiator's Dreadplate Legguards
				{ 525, 40810 },                                             -- Relentless Gladiator's Plate Gauntlets
				{ 526, 40850 },                                             -- Relentless Gladiator's Plate Legguards
				{ 601, 41910 },                                             -- Relentless Gladiator's Cuffs of Dominance
				{ 602, 41899 },                                             -- Relentless Gladiator's Cord of Dominance
				{ 603, 41904 },                                             -- Relentless Gladiator's Treads of Dominance
				{ 605, 41894 },                                             -- Relentless Gladiator's Cuffs of Salvation
				{ 606, 41882 },                                             -- Relentless Gladiator's Cord of Salvation
				{ 607, 41886 },                                             -- Relentless Gladiator's Treads of Salvation
				{ 609, 49181 },                                             -- Relentless Gladiator's Cuffs of Alacrity
				{ 610, 49179 },                                             -- Relentless Gladiator's Cord of Alacrity
				{ 611, 49183 },                                             -- Relentless Gladiator's Treads of Alacrity
				{ 616, 41641 },                                             -- Relentless Gladiator's Armwraps of Dominance
				{ 617, 41631 },                                             -- Relentless Gladiator's Belt of Dominance
				{ 618, 41636 },                                             -- Relentless Gladiator's Boots of Dominance
				{ 620, 41626 },                                             -- Relentless Gladiator's Armwraps of Salvation
				{ 621, 41618 },                                             -- Relentless Gladiator's Belt of Salvation
				{ 622, 41622 },                                             -- Relentless Gladiator's Boots of Salvation
				{ 624, 41841 },                                             -- Relentless Gladiator's Armwraps of Triumph
				{ 625, 41833 },                                             -- Relentless Gladiator's Belt of Triumph
				{ 626, 41837 },                                             -- Relentless Gladiator's Boots of Triumph
				{ 701, 41066 },                                             -- Relentless Gladiator's Wristguards of Dominance
				{ 702, 41071 },                                             -- Relentless Gladiator's Waistguard of Dominance
				{ 703, 41076 },                                             -- Relentless Gladiator's Sabatons of Dominance
				{ 705, 41061 },                                             -- Relentless Gladiator's Wristguards of Salvation
				{ 706, 41052 },                                             -- Relentless Gladiator's Waistguard of Salvation
				{ 707, 41056 },                                             -- Relentless Gladiator's Sabatons of Salvation
				{ 709, 41226 },                                             -- Relentless Gladiator's Wristguards of Triumph
				{ 710, 41236 },                                             -- Relentless Gladiator's Waistguard of Triumph
				{ 711, 41231 },                                             -- Relentless Gladiator's Sabatons of Triumph
				{ 716, 40984 },                                             -- Relentless Gladiator's Bracers of Salvation
				{ 717, 40978 },                                             -- Relentless Gladiator's Girdle of Salvation
				{ 718, 40979 },                                             -- Relentless Gladiator's Greaves of Salvation
				{ 720, 40890 },                                             -- Relentless Gladiator's Bracers of Triumph
				{ 721, 40883 },                                             -- Relentless Gladiator's Girdle of Triumph
				{ 722, 40884 },                                             -- Relentless Gladiator's Greaves of Triumph
				{ 801, 42078 },                                             -- Relentless Gladiator's Cloak of Ascendancy
				{ 802, 42080 },                                             -- Relentless Gladiator's Cloak of Deliverance
				{ 803, 42076 },                                             -- Relentless Gladiator's Cloak of Dominance
				{ 804, 42079 },                                             -- Relentless Gladiator's Cloak of Salvation
				{ 805, 42077 },                                             -- Relentless Gladiator's Cloak of Subjugation
				{ 806, 42081 },                                             -- Relentless Gladiator's Cloak of Triumph
				{ 807, 42082 },                                             -- Relentless Gladiator's Cloak of Victory
				{ 808, 42044 },                                             -- Relentless Gladiator's Pendant of Ascendancy
				{ 809, 42046 },                                             -- Relentless Gladiator's Pendant of Deliverance
				{ 810, 42043 },                                             -- Relentless Gladiator's Pendant of Dominance
				{ 811, 42047 },                                             -- Relentless Gladiator's Pendant of Salvation
				{ 812, 42045 },                                             -- Relentless Gladiator's Pendant of Subjugation
				{ 813, 46374 },                                             -- Relentless Gladiator's Pendant of Sundering
				{ 814, 42041 },                                             -- Relentless Gladiator's Pendant of Triumph
				{ 815, 42042 },                                             -- Relentless Gladiator's Pendant of Victory
				{ 816, 42118 },                                             -- Relentless Gladiator's Band of Ascendancy
				{ 817, 42119 },                                             -- Relentless Gladiator's Band of Victory
				{ 821, "ac3837" },
				{ 822, "ac4017" },
			},
		},
		{ --Toravon
			EncounterJournalID = 1600,
			[NORMAL_DIFF] = {
				{ 1,   "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 2,   50822 },                                                    -- Lasherweave's Gloves
				{ 3,   50820 },                                                    -- Lasherweave's Trousers
				{ 5,   "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 6,   50827 },                                                    -- Lasherweave's Handgrips
				{ 7,   50825 },                                                    -- Lasherweave's Legguards
				{ 9,   "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 10,  50107 },                                                    -- Lasherweave's Gauntlets
				{ 11,  50109 },                                                    -- Lasherweave's Legplates
				{ 16,  "ICON_spell_nature_starfall",           nil,                         ALIL["DRUID"],       ALIL["Balance"] },
				{ 17,  41294 },                                                    -- Relentless Gladiator's Wyrmhide Gloves
				{ 18,  41305 },                                                    -- Relentless Gladiator's Wyrmhide Legguards
				{ 20,  "ICON_ability_druid_catform",           nil,                         ALIL["DRUID"],       ALIL["Feral"] },
				{ 21,  41774 },                                                    -- Relentless Gladiator's Dragonhide Gloves
				{ 22,  41668 },                                                    -- Relentless Gladiator's Dragonhide Legguards
				{ 24,  "ICON_spell_nature_healingtouch",       nil,                         ALIL["DRUID"],       ALIL["Restoration"] },
				{ 25,  41288 },                                                    -- Relentless Gladiator's Kodohide Gloves
				{ 26,  41299 },                                                    -- Relentless Gladiator's Kodohide Legguards
				{ 101, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 102, 50114 },                                                    -- Ahn'Kahar Blood Hunter's Handguards
				{ 103, 50116 },                                                    -- Ahn'Kahar Blood Hunter's Legguards
				{ 105, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 106, 50275 },                                                    -- Bloodmage Gloves
				{ 107, 50277 },                                                    -- Bloodmage Leggings
				{ 109, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 110, 50088 },                                                    -- Shadowblade Gauntlets
				{ 111, 50090 },                                                    -- Shadowblade Legplates
				{ 113, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 114, 50240 },                                                    -- Dark Coven Gloves
				{ 115, 50242 },                                                    -- Dark Coven Leggings
				{ 116, "ICON_inv_weapon_bow_07",               nil,                         ALIL["HUNTER"],      nil },
				{ 117, 41144 },                                                    -- Relentless Gladiator's Chain Gauntlets
				{ 118, 41206 },                                                    -- Relentless Gladiator's Chain Leggings
				{ 120, "ICON_inv_staff_13",                    nil,                         ALIL["MAGE"],        nil },
				{ 121, 41972 },                                                    -- Relentless Gladiator's Silk Handguards
				{ 122, 41960 },                                                    -- Relentless Gladiator's Silk Trousers
				{ 124, "ICON_inv_throwingknife_04",            nil,                         ALIL["ROGUE"],       nil },
				{ 125, 41768 },                                                    -- Relentless Gladiator's Leather Gloves
				{ 126, 41656 },                                                    -- Relentless Gladiator's Leather Legguards
				{ 128, "ICON_spell_nature_drowsy",             nil,                         ALIL["WARLOCK"],     nil },
				{ 129, 42018 },                                                    -- Relentless Gladiator's Felweave Handguards
				{ 130, 42006 },                                                    -- Relentless Gladiator's Felweave Trousers
				{ 201, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 202, 50868 },                                                    -- Lightsworn Gloves
				{ 203, 50866 },                                                    -- Lightsworn Greaves
				{ 205, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 206, 50327 },                                                    -- Lightsworn Gauntlets
				{ 207, 50325 },                                                    -- Lightsworn Legplates
				{ 209, "ICON_spell_holy_devotionaura",         nil,                         ALIL["PALADIN"],     ALIL["Protection"] },
				{ 210, 50863 },                                                    -- Lightsworn Handguards
				{ 211, 50861 },                                                    -- Lightsworn Legguards
				{ 216, "ICON_Spell_Holy_HolyBolt",             nil,                         ALIL["PALADIN"],     ALIL["Holy"] },
				{ 217, 40928 },                                                    -- Relentless Gladiator's Ornamented Gloves
				{ 218, 40940 },                                                    -- Relentless Gladiator's Ornamented Legplates
				{ 220, "ICON_Spell_Holy_AuraOfLight",          nil,                         ALIL["PALADIN"],     ALIL["Retribution"] },
				{ 221, 40812 },                                                    -- Relentless Gladiator's Scaled Gauntlets
				{ 222, 40852 },                                                    -- Relentless Gladiator's Scaled Legguards
				{ 301, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 302, 50766 },                                                    -- Crimson Acolyte Gloves
				{ 303, 50769 },                                                    -- Crimson Acolyte Leggings
				{ 305, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 306, 50391 },                                                    -- Crimson Acolyte Handwraps
				{ 307, 50393 },                                                    -- Crimson Acolyte Pants
				{ 316, "ICON_spell_holy_guardianspirit",       nil,                         ALIL["PRIEST"],      ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 317, 41875 },                                                    -- Relentless Gladiator's Mooncloth Gloves
				{ 318, 41865 },                                                    -- Relentless Gladiator's Mooncloth Leggings
				{ 320, "ICON_spell_shadow_shadowwordpain",     nil,                         ALIL["PRIEST"],      ALIL["Shadow"] },
				{ 321, 41941 },                                                    -- Relentless Gladiator's Satin Gloves
				{ 322, 41928 },                                                    -- Relentless Gladiator's Satin Leggings
				{ 401, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 402, 50842 },                                                    -- Frost Witch's Gloves
				{ 403, 50844 },                                                    -- Frost Witch's Kilt
				{ 405, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 406, 50831 },                                                    -- Frost Witch's Grips
				{ 407, 50833 },                                                    -- Frost Witch's War-Kilt
				{ 409, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 410, 50836 },                                                    -- Frost Witch's Handguards
				{ 411, 50838 },                                                    -- Frost Witch's Legguards
				{ 416, "ICON_Spell_Nature_Lightning",          nil,                         ALIL["SHAMAN"],      ALIL["Elemental"] },
				{ 417, 41008 },                                                    -- Relentless Gladiator's Mail Gauntlets
				{ 418, 41034 },                                                    -- Relentless Gladiator's Mail Leggings
				{ 420, "ICON_spell_nature_lightningshield",    nil,                         ALIL["SHAMAN"],      ALIL["Enhancement"] },
				{ 421, 41138 },                                                    -- Relentless Gladiator's Linked Gauntlets
				{ 422, 41200 },                                                    -- Relentless Gladiator's Linked Leggings
				{ 424, "ICON_spell_nature_magicimmunity",      nil,                         ALIL["SHAMAN"],      ALIL["Restoration"] },
				{ 425, 41002 },                                                    -- Relentless Gladiator's Ringmail Gauntlets
				{ 426, 41028 },                                                    -- Relentless Gladiator's Ringmail Leggings
				{ 501, "ICON_spell_deathknight_frostpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 502, 50095 },                                                    -- Scourgelord Gauntlets
				{ 503, 50097 },                                                    -- Scourgelord Legplates
				{ 505, "ICON_spell_deathknight_bloodpresence", nil,                         ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 506, 50856 },                                                    -- Scourgelord Handguards
				{ 507, 50854 },                                                    -- Scourgelord Legguards
				{ 509, "ICON_ability_warrior_innerrage",       nil,                         ALIL["WARRIOR"],     ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 510, 50079 },                                                    -- Ymirjar Lord's Gauntlets
				{ 511, 50081 },                                                    -- Ymirjar Lord's Legplates
				{ 513, "ICON_ability_warrior_defensivestance", nil,                         ALIL["WARRIOR"],     ALIL["Protection"] },
				{ 514, 50849 },                                                    -- Ymirjar Lord's Handguards
				{ 515, 50847 },                                                    -- Ymirjar Lord's Legguards
				{ 516, "ICON_Spell_deathknight_classicon",     nil,                         ALIL["DEATHKNIGHT"], nil },
				{ 517, 40811 },                                                    -- Relentless Gladiator's Dreadplate Gauntlets
				{ 518, 40851 },                                                    -- Relentless Gladiator's Dreadplate Legguards
				{ 524, "ICON_inv_sword_27",                    nil,                         ALIL["WARRIOR"],     nil },
				{ 525, 40810 },                                                    -- Relentless Gladiator's Plate Gauntlets
				{ 526, 40850 },                                                    -- Relentless Gladiator's Plate Legguards
				{ 601, 41910 },                                                    -- Relentless Gladiator's Cuffs of Dominance
				{ 602, 41899 },                                                    -- Relentless Gladiator's Cord of Dominance
				{ 603, 41904 },                                                    -- Relentless Gladiator's Treads of Dominance
				{ 605, 41894 },                                                    -- Relentless Gladiator's Cuffs of Salvation
				{ 606, 41882 },                                                    -- Relentless Gladiator's Cord of Salvation
				{ 607, 41886 },                                                    -- Relentless Gladiator's Treads of Salvation
				{ 609, 49181 },                                                    -- Relentless Gladiator's Cuffs of Alacrity
				{ 610, 49179 },                                                    -- Relentless Gladiator's Cord of Alacrity
				{ 611, 49183 },                                                    -- Relentless Gladiator's Treads of Alacrity
				{ 616, 41641 },                                                    -- Relentless Gladiator's Armwraps of Dominance
				{ 617, 41631 },                                                    -- Relentless Gladiator's Belt of Dominance
				{ 618, 41636 },                                                    -- Relentless Gladiator's Boots of Dominance
				{ 620, 41626 },                                                    -- Relentless Gladiator's Armwraps of Salvation
				{ 621, 41618 },                                                    -- Relentless Gladiator's Belt of Salvation
				{ 622, 41622 },                                                    -- Relentless Gladiator's Boots of Salvation
				{ 624, 41841 },                                                    -- Relentless Gladiator's Armwraps of Triumph
				{ 625, 41833 },                                                    -- Relentless Gladiator's Belt of Triumph
				{ 626, 41837 },                                                    -- Relentless Gladiator's Boots of Triumph
				{ 701, 41066 },                                                    -- Relentless Gladiator's Wristguards of Dominance
				{ 702, 41071 },                                                    -- Relentless Gladiator's Waistguard of Dominance
				{ 703, 41076 },                                                    -- Relentless Gladiator's Sabatons of Dominance
				{ 705, 41061 },                                                    -- Relentless Gladiator's Wristguards of Salvation
				{ 706, 41052 },                                                    -- Relentless Gladiator's Waistguard of Salvation
				{ 707, 41056 },                                                    -- Relentless Gladiator's Sabatons of Salvation
				{ 709, 41226 },                                                    -- Relentless Gladiator's Wristguards of Triumph
				{ 710, 41236 },                                                    -- Relentless Gladiator's Waistguard of Triumph
				{ 711, 41231 },                                                    -- Relentless Gladiator's Sabatons of Triumph
				{ 716, 40984 },                                                    -- Relentless Gladiator's Bracers of Salvation
				{ 717, 40978 },                                                    -- Relentless Gladiator's Girdle of Salvation
				{ 718, 40979 },                                                    -- Relentless Gladiator's Greaves of Salvation
				{ 720, 40890 },                                                    -- Relentless Gladiator's Bracers of Triumph
				{ 721, 40883 },                                                    -- Relentless Gladiator's Girdle of Triumph
				{ 722, 40884 },                                                    -- Relentless Gladiator's Greaves of Triumph
				{ 801, 42078 },                                                    -- Relentless Gladiator's Cloak of Ascendancy
				{ 802, 42080 },                                                    -- Relentless Gladiator's Cloak of Deliverance
				{ 803, 42076 },                                                    -- Relentless Gladiator's Cloak of Dominance
				{ 804, 42079 },                                                    -- Relentless Gladiator's Cloak of Salvation
				{ 805, 42077 },                                                    -- Relentless Gladiator's Cloak of Subjugation
				{ 806, 42081 },                                                    -- Relentless Gladiator's Cloak of Triumph
				{ 807, 42082 },                                                    -- Relentless Gladiator's Cloak of Victory
				{ 808, 42044 },                                                    -- Relentless Gladiator's Pendant of Ascendancy
				{ 809, 42046 },                                                    -- Relentless Gladiator's Pendant of Deliverance
				{ 810, 42043 },                                                    -- Relentless Gladiator's Pendant of Dominance
				{ 811, 42047 },                                                    -- Relentless Gladiator's Pendant of Salvation
				{ 812, 42045 },                                                    -- Relentless Gladiator's Pendant of Subjugation
				{ 813, 46374 },                                                    -- Relentless Gladiator's Pendant of Sundering
				{ 814, 42041 },                                                    -- Relentless Gladiator's Pendant of Triumph
				{ 815, 42042 },                                                    -- Relentless Gladiator's Pendant of Victory
				{ 816, 42118 },                                                    -- Relentless Gladiator's Band of Ascendancy
				{ 817, 42119 },                                                    -- Relentless Gladiator's Band of Victory
				{ 819, [ATLASLOOT_IT_ALLIANCE] = 43959,        [ATLASLOOT_IT_HORDE] = 44083 }, -- Reins of the Grand Black War Mammoth
				{ 821, "ac4585" },
			},
			[P25_DIFF] = {
				GetItemsFromDiff = NORMAL_DIFF,
				{ 2,   51148 }, -- Sanctified Lasherweave's Gloves
				{ 3,   51146 }, -- Sanctified Lasherweave's Trousers
				{ 6,   51144 }, -- Sanctified Lasherweave's Handgrips
				{ 7,   51142 }, -- Sanctified Lasherweave's Legguards
				{ 10,  51138 }, -- Sanctified Lasherweave's Gauntlets
				{ 11,  51136 }, -- Sanctified Lasherweave's Legplates
				{ 17,  51434 }, -- Wrathful Gladiator's Wyrmhide Gloves
				{ 18,  51436 }, -- Wrathful Gladiator's Wyrmhide Legguards
				{ 21,  51426 }, -- Wrathful Gladiator's Dragonhide Gloves
				{ 22,  51428 }, -- Wrathful Gladiator's Dragonhide Legguards
				{ 25,  51420 }, -- Wrathful Gladiator's Kodohide Gloves
				{ 26,  51422 }, -- Wrathful Gladiator's Kodohide Legguards
				{ 102, 51154 }, -- Sanctified Ahn'Kahar Blood Hunter's Handguards
				{ 103, 51152 }, -- Sanctified Ahn'Kahar Blood Hunter's Legguards
				{ 106, 51159 }, -- Sanctified Bloodmage Gloves
				{ 107, 51157 }, -- Sanctified Bloodmage Leggings
				{ 110, 51188 }, -- Sanctified Shadowblade Gauntlets
				{ 111, 51186 }, -- Sanctified Shadowblade Legplates
				{ 114, 51209 }, -- Sanctified Dark Coven Gloves
				{ 115, 51207 }, -- Sanctified Dark Coven Leggings
				{ 117, 51459 }, -- Wrathful Gladiator's Chain Gauntlets
				{ 118, 51461 }, -- Wrathful Gladiator's Chain Leggings
				{ 121, 51464 }, -- Wrathful Gladiator's Silk Handguards
				{ 122, 51466 }, -- Wrathful Gladiator's Silk Trousers
				{ 125, 51493 }, -- Wrathful Gladiator's Leather Gloves
				{ 126, 51495 }, -- Wrathful Gladiator's Leather Legguards
				{ 129, 51537 }, -- Wrathful Gladiator's Felweave Handguards
				{ 130, 51539 }, -- Wrathful Gladiator's Felweave Trousers
				{ 202, 51169 }, -- Sanctified Lightsworn Gloves
				{ 203, 51168 }, -- Sanctified Lightsworn Greaves
				{ 206, 51163 }, -- Sanctified Lightsworn Gauntlets
				{ 207, 51161 }, -- Sanctified Lightsworn Legplates
				{ 210, 51172 }, -- Sanctified Lightsworn Handguards
				{ 211, 51171 }, -- Sanctified Lightsworn Legguards
				{ 217, 51469 }, -- Wrathful Gladiator's Ornamented Gloves
				{ 218, 51471 }, -- Wrathful Gladiator's Ornamented Legplates
				{ 221, 51475 }, -- Wrathful Gladiator's Scaled Gauntlets
				{ 222, 51477 }, -- Wrathful Gladiator's Scaled Legguards
				{ 302, 51179 }, -- Sanctified Crimson Acolyte Gloves
				{ 303, 51177 }, -- Sanctified Crimson Acolyte Leggings
				{ 306, 51183 }, -- Sanctified Crimson Acolyte Handwraps
				{ 307, 51181 }, -- Sanctified Crimson Acolyte Pants
				{ 317, 51483 }, -- Wrathful Gladiator's Mooncloth Gloves
				{ 318, 51485 }, -- Wrathful Gladiator's Mooncloth Leggings
				{ 321, 51488 }, -- Wrathful Gladiator's Satin Gloves
				{ 322, 51490 }, -- Wrathful Gladiator's Satin Leggings
				{ 402, 51201 }, -- Sanctified Frost Witch's Gloves
				{ 403, 51203 }, -- Sanctified Frost Witch's Kilt
				{ 406, 51196 }, -- Sanctified Frost Witch's Grips
				{ 407, 51198 }, -- Sanctified Frost Witch's War-Kilt
				{ 410, 51191 }, -- Sanctified Frost Witch's Handguards
				{ 411, 51193 }, -- Sanctified Frost Witch's Legguards
				{ 417, 51510 }, -- Wrathful Gladiator's Mail Gauntlets
				{ 418, 51512 }, -- Wrathful Gladiator's Mail Leggings
				{ 421, 51504 }, -- Wrathful Gladiator's Linked Gauntlets
				{ 422, 51506 }, -- Wrathful Gladiator's Linked Leggings
				{ 425, 51498 }, -- Wrathful Gladiator's Ringmail Gauntlets
				{ 426, 51500 }, -- Wrathful Gladiator's Ringmail Leggings
				{ 502, 51128 }, -- Sanctified Scourgelord Gauntlets
				{ 503, 51126 }, -- Sanctified Scourgelord Legplates
				{ 506, 51132 }, -- Sanctified Scourgelord Handguards
				{ 507, 51131 }, -- Sanctified Scourgelord Legguards
				{ 510, 51213 }, -- Sanctified Ymirjar Lord's Gauntlets
				{ 511, 51211 }, -- Sanctified Ymirjar Lord's Legplates
				{ 514, 51217 }, -- Sanctified Ymirjar Lord's Handguards
				{ 515, 51216 }, -- Sanctified Ymirjar Lord's Legguards
				{ 517, 51414 }, -- Wrathful Gladiator's Dreadplate Gauntlets
				{ 518, 51416 }, -- Wrathful Gladiator's Dreadplate Legguards
				{ 525, 51542 }, -- Wrathful Gladiator's Plate Gauntlets
				{ 526, 51544 }, -- Wrathful Gladiator's Plate Legguards
				{ 601, 51329 }, -- Wrathful Gladiator's Cuffs of Dominance
				{ 602, 51327 }, -- Wrathful Gladiator's Cord of Dominance
				{ 603, 51328 }, -- Wrathful Gladiator's Treads of Dominance
				{ 605, 51367 }, -- Wrathful Gladiator's Cuffs of Salvation
				{ 606, 51365 }, -- Wrathful Gladiator's Cord of Salvation
				{ 607, 51366 }, -- Wrathful Gladiator's Treads of Salvation
				{ 609, 51339 }, -- Wrathful Gladiator's Cuffs of Alacrity
				{ 610, 51337 }, -- Wrathful Gladiator's Cord of Alacrity
				{ 611, 51338 }, -- Wrathful Gladiator's Treads of Alacrity
				{ 616, 51345 }, -- Wrathful Gladiator's Armwraps of Dominance
				{ 617, 51343 }, -- Wrathful Gladiator's Belt of Dominance
				{ 618, 51344 }, -- Wrathful Gladiator's Boots of Dominance
				{ 620, 51342 }, -- Wrathful Gladiator's Armwraps of Salvation
				{ 621, 51340 }, -- Wrathful Gladiator's Belt of Salvation
				{ 622, 51341 }, -- Wrathful Gladiator's Boots of Salvation
				{ 624, 51370 }, -- Wrathful Gladiator's Armwraps of Triumph
				{ 625, 51368 }, -- Wrathful Gladiator's Belt of Triumph
				{ 626, 51369 }, -- Wrathful Gladiator's Boots of Triumph
				{ 701, 51376 }, -- Wrathful Gladiator's Wristguards of Dominance
				{ 702, 51374 }, -- Wrathful Gladiator's Waistguard of Dominance
				{ 703, 51375 }, -- Wrathful Gladiator's Sabatons of Dominance
				{ 705, 51373 }, -- Wrathful Gladiator's Wristguards of Salvation
				{ 706, 51371 }, -- Wrathful Gladiator's Waistguard of Salvation
				{ 707, 51372 }, -- Wrathful Gladiator's Sabatons of Salvation
				{ 709, 51352 }, -- Wrathful Gladiator's Wristguards of Triumph
				{ 710, 51350 }, -- Wrathful Gladiator's Waistguard of Triumph
				{ 711, 51351 }, -- Wrathful Gladiator's Sabatons of Triumph
				{ 716, 51361 }, -- Wrathful Gladiator's Bracers of Salvation
				{ 717, 51359 }, -- Wrathful Gladiator's Girdle of Salvation
				{ 718, 51360 }, -- Wrathful Gladiator's Greaves of Salvation
				{ 720, 51364 }, -- Wrathful Gladiator's Bracers of Triumph
				{ 721, 51362 }, -- Wrathful Gladiator's Girdle of Triumph
				{ 722, 51363 }, -- Wrathful Gladiator's Greaves of Triumph
				{ 801, 51334 }, -- Wrathful Gladiator's Cloak of Ascendancy
				{ 802, 51348 }, -- Wrathful Gladiator's Cloak of Deliverance
				{ 803, 51330 }, -- Wrathful Gladiator's Cloak of Dominance
				{ 804, 51346 }, -- Wrathful Gladiator's Cloak of Salvation
				{ 805, 51332 }, -- Wrathful Gladiator's Cloak of Subjugation
				{ 806, 51354 }, -- Wrathful Gladiator's Cloak of Triumph
				{ 807, 51356 }, -- Wrathful Gladiator's Cloak of Victory
				{ 808, 51335 }, -- Wrathful Gladiator's Pendant of Ascendancy
				{ 809, 51349 }, -- Wrathful Gladiator's Pendant of Deliverance
				{ 810, 51331 }, -- Wrathful Gladiator's Pendant of Dominance
				{ 811, 51347 }, -- Wrathful Gladiator's Pendant of Salvation
				{ 812, 51333 }, -- Wrathful Gladiator's Pendant of Subjugation
				{ 813, 51353 }, -- Wrathful Gladiator's Pendant of Sundering
				{ 814, 51355 }, -- Wrathful Gladiator's Pendant of Triumph
				{ 815, 51357 }, -- Wrathful Gladiator's Pendant of Victory
				{ 816, 51336 }, -- Wrathful Gladiator's Band of Dominance
				{ 817, 51358 }, -- Wrathful Gladiator's Band of Triumph
				{ 821, "ac4586" },
			},
		},
		{ --Tier 7 Sets
			name = format(AL["Tier %d Sets"], 7),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
		},
		{ --Tier 8 Sets
			name = format(AL["Tier %d Sets"], 8),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:8",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:8",
		},
		{ --Tier 9 Sets
			name = format(AL["Tier %d Sets"], 9),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:9",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:9",
		},
		{ --Tier 10 Sets
			name = format(AL["Tier %d Sets"], 10),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:10",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:10",
		},
	}
}
