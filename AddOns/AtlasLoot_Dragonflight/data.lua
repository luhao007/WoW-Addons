-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 10)

AtlasLoot:RegisterModules(addonname)

local AL = AtlasLoot.Locales

local NORMAL_DUNGEON_DIFF = data:AddDifficulty(AL["Normal"], "DungeonWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 1)
local HEROIC_DUNGEON_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicDungeonWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 2)
local MYTHICD_DUNGEON_DIFF = data:AddDifficulty(AL["Mythic"], "MythicDungeonWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 23)

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "LFRWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 17)
local NORMAL_RAID_DIFF = data:AddDifficulty(AL["Normal"], "NormalRaidWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 14)
local HEROIC_PRE_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 15)
local MYTHIC_PRE_DIFF = data:AddDifficulty(AL["Mythic"], "MyhticWithPreset", {
	Item = {
		addDifficultyBonus = true,
	},
}, 16)

local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)


-- /////////////////////////////////
-- Instance
-- /////////////////////////////////
--[[
data["InstanceName"] = {
	EncounterJournalID = 111,
	MapID = 749,
	ContentType = DUNGEON_CONTENT / RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- bossN
			EncounterJournalID = 1111,
			[NORMAL_RAID_DIFF] = {
			},
		},
	}
}
]]
data["Algeth'ar Academy"] = {
	EncounterJournalID = 1201,
	MapID = 2097,
	AtlasMapID = "AlgetharAcademy",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Vexamus
			EncounterJournalID = 2509,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193711 }, -- Spellbane Cutlass
				{ 2, 193710 }, -- Spellboon Saber
				{ 3, 193709 }, -- Vexamus' Expulsion Rod
				{ 4, 193708 }, -- Platinum Star Band
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Overgrown Ancient
			EncounterJournalID = 2512,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193713 }, -- Experimental Safety Gloves
				{ 2, 193714 }, -- Frenzyroot Cuffs
				{ 3, 193715 }, -- Boots of Explosive Growth
				{ 4, 193716 }, -- Algeth'ar Hedgecleaver
				{ 5, 193717 }, -- Mystakra's Harvester
				{ 6, 193712 }, -- Potion-Stained Cloak
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Crawth
			EncounterJournalID = 2495,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193720 }, -- Bronze Challenger's Robe
				{ 2, 193721 }, -- Ruby Contestant's Gloves
				{ 3, 193722 }, -- Azure Belt of Competition
				{ 4, 193723 }, -- Obsidian Goaltending Spire
				{ 5, 193718 }, -- Emerald Coach's Whistle
				{ 6, 193719 }, -- Dragon Games Equipment
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Echo of Doragosa
			EncounterJournalID = 2514,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193706 }, -- Venerated Professor's Greaves
				{ 2, 193707 }, -- Final Grade
				{ 3, 193701 }, -- Algeth'ar Puzzle Box
				{ 4, 193703 }, -- Organized Pontificator's Mask
				{ 5, 193704 }, -- Scaled Commencement Spaulders
				{ 6, 198059 }, -- Titan Training Matrix IV
				{ 7, 193705 }, -- Breastplate of Proven Knowledge
				{ 8, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193706 }, -- Venerated Professor's Greaves
				{ 2, 193707 }, -- Final Grade
				{ 3, 193701 }, -- Algeth'ar Puzzle Box
				{ 4, 193703 }, -- Organized Pontificator's Mask
				{ 5, 193704 }, -- Scaled Commencement Spaulders
				{ 6, 198059 }, -- Titan Training Matrix IV
				{ 7, 193705 }, -- Breastplate of Proven Knowledge
				{ 8, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193706 }, -- Venerated Professor's Greaves
				{ 2, 193707 }, -- Final Grade
				{ 3, 193701 }, -- Algeth'ar Puzzle Box
				{ 4, 193703 }, -- Organized Pontificator's Mask
				{ 5, 193704 }, -- Scaled Commencement Spaulders
				{ 6, 198059 }, -- Titan Training Matrix IV
				{ 7, 193705 }, -- Breastplate of Proven Knowledge
				{ 8, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["Brackenhide Hollow"] = {
	EncounterJournalID = 1196,
	MapID = 2096,
	AtlasMapID = "BrackenhideHollow",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Hackclaw's War-Band
			EncounterJournalID = 2471,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193671 }, -- Bloodied Wedding Ring
				{ 2, 193672 }, -- Frenzying Signoll Flare
				{ 3, 193673 }, -- Ravenous Pursuer's Footwraps
				{ 4, 193674 }, -- Ancestral Stoneshaper
				{ 5, 193675 }, -- Poached Kalu'ak Spear
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Treemouth
			EncounterJournalID = 2473,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193657 }, -- Binders of the Moldering
				{ 2, 193658 }, -- Bough of Deterioration
				{ 3, 193652 }, -- Treemouth's Festering Splinter
				{ 4, 193653 }, -- Mask of Imperishable Leaves
				{ 5, 193654 }, -- Ancient Rotwalkers
				{ 6, 193655 }, -- Rooted Shoulders of Putrefaction
				{ 7, 193656 }, -- Swollen Bark Clasp
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Gutshot
			EncounterJournalID = 2472,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193666 }, -- Tuskarr Bone Necklace
				{ 2, 193667 }, -- Boastful Stalker's Epaulets
				{ 3, 193669 }, -- Trapmaster's Utility Belt
				{ 4, 193670 }, -- Gutshot's Trophy Hunter
				{ 5, 193793 }, -- Ferocious Hyena Hidebinders
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Decatriarch Wratheye
			EncounterJournalID = 2474,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193664 }, -- Rot-Carved Totemic Shank
				{ 2, 193665 }, -- Decatriarch's Bone Pestle
				{ 3, 193660 }, -- Idol of Pure Decay
				{ 4, 193661 }, -- Blightweaver's Clutches
				{ 5, 193662 }, -- Tassets of Densified Ooze
				{ 6, 193663 }, -- Decay Mother's Wrathful Gaze
				{ 7, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193664 }, -- Rot-Carved Totemic Shank
				{ 2, 193665 }, -- Decatriarch's Bone Pestle
				{ 3, 193660 }, -- Idol of Pure Decay
				{ 4, 193661 }, -- Blightweaver's Clutches
				{ 5, 193662 }, -- Tassets of Densified Ooze
				{ 6, 193663 }, -- Decay Mother's Wrathful Gaze
				{ 7, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193664 }, -- Rot-Carved Totemic Shank
				{ 2, 193665 }, -- Decatriarch's Bone Pestle
				{ 3, 193660 }, -- Idol of Pure Decay
				{ 4, 193661 }, -- Blightweaver's Clutches
				{ 5, 193662 }, -- Tassets of Densified Ooze
				{ 6, 193663 }, -- Decay Mother's Wrathful Gaze
				{ 7, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["Halls of Infusion"] = {
	EncounterJournalID = 1204,
	MapID = 2082,
	AtlasMapID = "HallsofInfusion",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Watcher Irideus
			EncounterJournalID = 2504,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193743 }, -- Irideus Fragment
				{ 2, 193744 }, -- Watcher's Clasp of Purpose
				{ 3, 193745 }, -- Rod of Perfect Order
				{ 4, 193746 }, -- Gauntlets of Incalculable Power
				{ 5, 193747 }, -- Titan-Forged Blaster
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Gulping Goliath
			EncounterJournalID = 2507,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193770 }, -- Swoglet Stompers
				{ 2, 193729 }, -- Tongue Hacker
				{ 3, 193730 }, -- Croaking Dagger
				{ 4, 193724 }, -- Lily-Laced Bracelets
				{ 5, 193725 }, -- Ancient Hornswog Spaulders
				{ 6, 193726 }, -- Amphibian's Bellowing Crown
				{ 7, 193760 }, -- Ravenous Omnivore's Girdle
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Khajin the Unyielding
			EncounterJournalID = 2510,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193734 }, -- Hauberk of Frozen Fervor
				{ 2, 193735 }, -- Earthshaker's Steel Visor
				{ 3, 193731 }, -- Circle of Ascended Frost
				{ 4, 193732 }, -- Globe of Jagged Ice
				{ 5, 193733 }, -- Khajin's Hailstone Footwraps
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Primal Tsunami
			EncounterJournalID = 2511,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193741 }, -- Mantle of Crushing Waves
				{ 2, 193742 }, -- Undertow Tideblade
				{ 3, 193736 }, -- Water's Beating Heart
				{ 4, 193738 }, -- Robe of Plunging Depths
				{ 5, 193739 }, -- Treads of Restored Order
				{ 6, 193740 }, -- Torrential Downpour Gauntlets
				{ 7, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193741 }, -- Mantle of Crushing Waves
				{ 2, 193742 }, -- Undertow Tideblade
				{ 3, 193736 }, -- Water's Beating Heart
				{ 4, 193738 }, -- Robe of Plunging Depths
				{ 5, 193739 }, -- Treads of Restored Order
				{ 6, 193740 }, -- Torrential Downpour Gauntlets
				{ 7, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193741 }, -- Mantle of Crushing Waves
				{ 2, 193742 }, -- Undertow Tideblade
				{ 3, 193736 }, -- Water's Beating Heart
				{ 4, 193738 }, -- Robe of Plunging Depths
				{ 5, 193739 }, -- Treads of Restored Order
				{ 6, 193740 }, -- Torrential Downpour Gauntlets
				{ 7, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["Neltharus"] = {
	EncounterJournalID = 1199,
	MapID = 2080,
	AtlasMapID = "Neltharus",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Chargath, Bane of Scales
			EncounterJournalID = 2490,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193727 }, -- Obsidian-Hardened Wraps
				{ 2, 193771 }, -- Pristine Magma Stompers
				{ 3, 193772 }, -- Dragonscale Ripper
				{ 4, 193768 }, -- Scalebane Signet
				{ 5, 193769 }, -- Erupting Spear Fragment
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Forgemaster Gorek
			EncounterJournalID = 2489,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193783 }, -- Irontorch Igniter
				{ 2, 193784 }, -- Forgemaster's Grips
				{ 3, 193785 }, -- Forgestorm
				{ 4, 193780 }, -- Flare-Singed Strap
				{ 5, 193781 }, -- Lavabearer Legwraps
				{ 6, 193782 }, -- Emberguard Harness
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Magmatusk
			EncounterJournalID = 2494,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193790 }, -- Searing Tusk Shard
				{ 2, 193786 }, -- Mutated Magmammoth Scale
				{ 3, 193787 }, -- Mammoth-Trainer's Drape
				{ 4, 193788 }, -- Molten Magma Mantle
				{ 5, 193789 }, -- Fural's Blazing Faulds
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Warlord Sargha
			EncounterJournalID = 2501,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193776 }, -- Dragonkiln Chestguard
				{ 2, 193777 }, -- Helm of Hardened Gold
				{ 3, 193778 }, -- Qalashi Defender
				{ 4, 193779 }, -- Sargha's Smasher
				{ 5, 193773 }, -- Spoils of Neltharus
				{ 6, 193775 }, -- Warlord's Cindermitts
				{ 7, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193776 }, -- Dragonkiln Chestguard
				{ 2, 193777 }, -- Helm of Hardened Gold
				{ 3, 193778 }, -- Qalashi Defender
				{ 4, 193779 }, -- Sargha's Smasher
				{ 5, 193773 }, -- Spoils of Neltharus
				{ 6, 193775 }, -- Warlord's Cindermitts
				{ 7, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193776 }, -- Dragonkiln Chestguard
				{ 2, 193777 }, -- Helm of Hardened Gold
				{ 3, 193778 }, -- Qalashi Defender
				{ 4, 193779 }, -- Sargha's Smasher
				{ 5, 193773 }, -- Spoils of Neltharus
				{ 6, 193775 }, -- Warlord's Cindermitts
				{ 7, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["Ruby Life Pools"] = {
	EncounterJournalID = 1202,
	MapID = 2095,
	--AtlasMapID = "",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Melidrussa Chillworn
			EncounterJournalID = 2488,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193728 }, -- Scaleguard's Stalwart Greatboots
				{ 2, 193757 }, -- Ruby Whelp Shell
				{ 3, 193758 }, -- Subjugator's Chilling Grips
				{ 4, 193759 }, -- Egg Tender's Leggings
				{ 5, 193761 }, -- Chillworn's Infusion Staff
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Kokia Blazehoof
			EncounterJournalID = 2485,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193762 }, -- Blazebinder's Hoof
				{ 2, 193763 }, -- Fireproof Drape
				{ 3, 193764 }, -- Invader's Firestorm Chestguard
				{ 4, 193765 }, -- Blazebound Lieutenant's Helm
				{ 5, 193766 }, -- Kokia's Burnout Rod
				{ 6, 193767 }, -- Havoc Crusher
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Kyrakka and Erkhart Stormvein
			EncounterJournalID = 2503,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1,  193751 }, -- Crown of Roaring Storms
				{ 2,  193753 }, -- Breastplate of Soaring Terror
				{ 3,  193755 }, -- Backdraft Cleaver
				{ 4,  193748 }, -- Kyrakka's Searing Embers
				{ 5,  193750 }, -- Wind Soarer's Breeches
				{ 6,  193752 }, -- Galerattle Gauntlets
				{ 7,  193756 }, -- Skyferno Rondel
				{ 8,  193754 }, -- Drake Rider's Stecktarge
				{ 9,  193691 }, -- Sky Saddle Cord
				{ 10, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1,  193751 }, -- Crown of Roaring Storms
				{ 2,  193753 }, -- Breastplate of Soaring Terror
				{ 3,  193755 }, -- Backdraft Cleaver
				{ 4,  193748 }, -- Kyrakka's Searing Embers
				{ 5,  193750 }, -- Wind Soarer's Breeches
				{ 6,  193752 }, -- Galerattle Gauntlets
				{ 7,  193756 }, -- Skyferno Rondel
				{ 8,  193754 }, -- Drake Rider's Stecktarge
				{ 9,  193691 }, -- Sky Saddle Cord
				{ 10, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1,  193751 }, -- Crown of Roaring Storms
				{ 2,  193753 }, -- Breastplate of Soaring Terror
				{ 3,  193755 }, -- Backdraft Cleaver
				{ 4,  193748 }, -- Kyrakka's Searing Embers
				{ 5,  193750 }, -- Wind Soarer's Breeches
				{ 6,  193752 }, -- Galerattle Gauntlets
				{ 7,  193756 }, -- Skyferno Rondel
				{ 8,  193754 }, -- Drake Rider's Stecktarge
				{ 9,  193691 }, -- Sky Saddle Cord
				{ 10, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["The Azure Vault"] = {
	EncounterJournalID = 1203,
	MapID = 2073,
	AtlasMapID = "AzureVault",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Leymor
			EncounterJournalID = 2492,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193636 }, -- Cinch of Forgotten Duty
				{ 2, 193637 }, -- Spaulders of Wild Growth
				{ 3, 193638 }, -- Ley-Line Tracer
				{ 4, 193633 }, -- Unstable Arcane Loop
				{ 5, 193634 }, -- Burgeoning Seed
				{ 6, 193635 }, -- Infused Elemental Bands
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Azureblade
			EncounterJournalID = 2494,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193629 }, -- Cloak of Lost Devotion
				{ 2, 193630 }, -- Twenty-Two-League Striders
				{ 3, 193631 }, -- Horizon Splitter
				{ 4, 193632 }, -- Tz'onna, Fear-Striker
				{ 5, 193628 }, -- Tome of Unstable Power
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Telash Greywing
			EncounterJournalID = 2483,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193650 }, -- Illusion Breaker's Waistguard
				{ 2, 193651 }, -- Golden-Winged Rod
				{ 3, 193647 }, -- Custodian's Medallion of Delusion
				{ 4, 193648 }, -- Azureblade's Work Gloves
				{ 5, 193649 }, -- Mirage Bindings
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Umbrelskul
			EncounterJournalID = 2508,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193643 }, -- Stasis-Freed Leggings
				{ 2, 193644 }, -- Cuirass of Irreparable Madness
				{ 3, 193645 }, -- Crystalized Bulwark
				{ 4, 193646 }, -- Refraction's Edge
				{ 5, 193642 }, -- Mantle of Yearned Freedom
				{ 6, 193641 }, -- Headwrap of the Abandoned
				{ 7, 193639 }, -- Umbrelskul's Fractured Heart
				{ 8, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193643 }, -- Stasis-Freed Leggings
				{ 2, 193644 }, -- Cuirass of Irreparable Madness
				{ 3, 193645 }, -- Crystalized Bulwark
				{ 4, 193646 }, -- Refraction's Edge
				{ 5, 193642 }, -- Mantle of Yearned Freedom
				{ 6, 193641 }, -- Headwrap of the Abandoned
				{ 7, 193639 }, -- Umbrelskul's Fractured Heart
				{ 8, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193643 }, -- Stasis-Freed Leggings
				{ 2, 193644 }, -- Cuirass of Irreparable Madness
				{ 3, 193645 }, -- Crystalized Bulwark
				{ 4, 193646 }, -- Refraction's Edge
				{ 5, 193642 }, -- Mantle of Yearned Freedom
				{ 6, 193641 }, -- Headwrap of the Abandoned
				{ 7, 193639 }, -- Umbrelskul's Fractured Heart
				{ 8, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["The Nokhud Offensive"] = {
	EncounterJournalID = 1198,
	MapID = 2093,
	AtlasMapID = "NokhudOffensive",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- Granyth
			EncounterJournalID = 2498,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193692 }, -- Stoneroot Headdress
				{ 2, 193693 }, -- Shikaar Ranger Bracers
				{ 3, 193694 }, -- Drake Hunter's Greaves
				{ 4, 193695 }, -- Quarryslayer Glaive
				{ 5, 193689 }, -- Granyth's Enduring Scale
				{ 6, 193690 }, -- Drake Hunter Shoulderpads
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- The Raging Tempest
			EncounterJournalID = 2497,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193699 }, -- Staff of Violent Storms
				{ 2, 193700 }, -- Strike Twice
				{ 3, 193696 }, -- Thunderous Downburst Ring
				{ 4, 193697 }, -- Bottle of Spiraling Winds
				{ 5, 193698 }, -- Thrashing Wind Vambraces
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Teera and Maruuk
			EncounterJournalID = 2478,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193678 }, -- Miniature Singing Stone
				{ 2, 193679 }, -- Idol of Trampling Hooves
				{ 3, 193680 }, -- Tunic of the Eternal Hunt
				{ 4, 193681 }, -- Bow of the First Khanam
				{ 5, 193676 }, -- Ukhel Ancestry Beads
				{ 6, 193677 }, -- Furious Ragefeather
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Balakar Khan
			EncounterJournalID = 2477,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193685 }, -- Lightning-Charged Striders
				{ 2, 193686 }, -- Nokhud Traditionalist's Pauldrons
				{ 3, 193687 }, -- Koroleth's Crackling Dagger
				{ 4, 193688 }, -- Stormslash
				{ 5, 193683 }, -- Blessed Ohn'ir Robes
				{ 6, 193684 }, -- Legguards of Adamant Rule
				{ 7, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193685 }, -- Lightning-Charged Striders
				{ 2, 193686 }, -- Nokhud Traditionalist's Pauldrons
				{ 3, 193687 }, -- Koroleth's Crackling Dagger
				{ 4, 193688 }, -- Stormslash
				{ 5, 193683 }, -- Blessed Ohn'ir Robes
				{ 6, 193684 }, -- Legguards of Adamant Rule
				{ 7, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193685 }, -- Lightning-Charged Striders
				{ 2, 193686 }, -- Nokhud Traditionalist's Pauldrons
				{ 3, 193687 }, -- Koroleth's Crackling Dagger
				{ 4, 193688 }, -- Stormslash
				{ 5, 193683 }, -- Blessed Ohn'ir Robes
				{ 6, 193684 }, -- Legguards of Adamant Rule
				{ 7, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["Uldaman: Legacy of Tyr"] = {
	EncounterJournalID = 1197,
	MapID = 2071,
	AtlasMapID = "UldamanLegacyofTyr",
	ContentType = DUNGEON_CONTENT,
	items =
	{
		{ -- The Lost Dwarves
			EncounterJournalID = 2475,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193812 }, -- Fierce Boreal Armguards
				{ 2, 193820 }, -- Stout Shield
				{ 3, 193815 }, -- Homeland Raid Horn
				{ 4, 193816 }, -- Lost Hero's Waist Wrap
				{ 5, 193817 }, -- Treads of the Swift
				{ 6, 193819 }, -- Old Seafarer's Headpiece
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Bromach
			EncounterJournalID = 2487,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193818 }, -- Rock Shovelers
				{ 2, 193813 }, -- Excavated Earthen Wristslabs
				{ 3, 193814 }, -- Unearthed Trogglodicer
				{ 4, 193668 }, -- Troggskin Waistband
				{ 5, 193809 }, -- Bromach's Disentombed Locket
				{ 6, 193810 }, -- Miner's Sturdy Trousers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Sentinel Talondras
			EncounterJournalID = 2484,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193804 }, -- Eternal Sentry's Ring
				{ 2, 193805 }, -- Inexorable Resonator
				{ 3, 193806 }, -- Ancient Crosswrapped Sandals
				{ 4, 193807 }, -- Shoulders of Animated Stone
				{ 5, 193808 }, -- Sentinel's Battle Lance
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Emberon
			EncounterJournalID = 2476,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193797 }, -- Bouldersplitter
				{ 2, 193792 }, -- Animated Shackles
				{ 3, 193794 }, -- Gatekeeper's Girdle
				{ 4, 193795 }, -- Keeper's Iron Grips
				{ 5, 193796 }, -- Vault Piercer
				{ 6, 193811 }, -- Annora's Punctured Leggings
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Chrono-Lord Deios
			EncounterJournalID = 2479,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 193791 }, -- Time-Breaching Talon
				{ 2, 193799 }, -- Crazed Traveler's Legwraps
				{ 3, 193800 }, -- Vision of Foreshadowed Ends
				{ 4, 193801 }, -- Fatebound Chainmail
				{ 5, 193802 }, -- Pauldrons of Immutable Truth
				{ 6, 193803 }, -- Infinite Dragonspire
				{ 7, 198056 }, -- Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193791 }, -- Time-Breaching Talon
				{ 2, 193799 }, -- Crazed Traveler's Legwraps
				{ 3, 193800 }, -- Vision of Foreshadowed Ends
				{ 4, 193801 }, -- Fatebound Chainmail
				{ 5, 193802 }, -- Pauldrons of Immutable Truth
				{ 6, 193803 }, -- Infinite Dragonspire
				{ 7, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193791 }, -- Time-Breaching Talon
				{ 2, 193799 }, -- Crazed Traveler's Legwraps
				{ 3, 193800 }, -- Vision of Foreshadowed Ends
				{ 4, 193801 }, -- Fatebound Chainmail
				{ 5, 193802 }, -- Pauldrons of Immutable Truth
				{ 6, 193803 }, -- Infinite Dragonspire
				{ 7, 198059 }, -- Titan Training Matrix IV
			},
		},
	}
}

-- /////////////////////////////////
-- Raid
-- /////////////////////////////////

data["Dragon Isles"] = {
	EncounterJournalID = 1205,
	MapID = 1978,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Strunraan, The Sky's Misery
			EncounterJournalID = 2515,
			[NORMAL_RAID_DIFF] = {
				{ 1, 200734 }, -- Striders of the Sky's Misery
				{ 2, 200687 }, -- Stormshale Cuffs
				{ 3, 200688 }, -- Tights of Twisting Winds
				{ 4, 200676 }, -- Static-Charged Scale
				{ 5, 200733 }, -- Storm Chaser's Waistguard
			},
		},
		{ -- Liskanoth, The Futurebane
			EncounterJournalID = 2518,
			[NORMAL_RAID_DIFF] = {
				{ 1, 200763 }, -- Frosted Scale Drape
				{ 2, 200743 }, -- Frozen Footwraps
				{ 3, 200744 }, -- Glacial Bindings
				{ 4, 200745 }, -- Horns of the Futurebane
				{ 5, 200746 }, -- Icebound Girdle
			},
		},
		{ -- Bazual, The Dreaded Flame
			EncounterJournalID = 2517,
			[NORMAL_RAID_DIFF] = {
				{ 1, 200660 }, -- Cinderfang Wrap
				{ 2, 200654 }, -- Magmatic Vestments
				{ 3, 200661 }, -- Basalt Brood Stompers
				{ 4, 200663 }, -- Shackles of the Dreaded Flame
				{ 5, 200761 }, -- Smoldering Sulfuron Signet
			},
		},
		{ -- Basrikron, The Shale Wing
			EncounterJournalID = 2506,
			[NORMAL_RAID_DIFF] = {
				{ 1, 200762 }, -- Earthspeaker's Brooch
				{ 2, 200742 }, -- Hardened Shale Breastplate
				{ 3, 200736 }, -- Belt of Living Earth
				{ 4, 200739 }, -- Stony Cragwalkers
				{ 5, 200740 }, -- Petrified Bracelets
			},
		},
	}
}

data["Vault of the Incarnates"] = {
	EncounterJournalID = 1200,
	MapID = 2119,
	AtlasMapID = "VaultoftheIncarnates",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Eranog
			EncounterJournalID = 2480,
			[NORMAL_RAID_DIFF] = {
				{ 1, 195476 }, -- Eranog's Adorned Sallet
				{ 2, 195478 }, -- Valdrakken Protector's Turncoat
				{ 3, 195480 }, -- Seal of Diurna's Chosen
				{ 4, 195482 }, -- Decorated Commander's Cindercloak
				{ 5, 194299 }, -- Decoration of Flame
				{ 6, 195490 }, -- Searing Blazecaster
				{ 7, 195477 }, -- Scaldrons of Molten Might
				{ 8, 195479 }, -- Flametender's Legwraps
				{ 9, 195475 }, -- Flame Marshal's Bulwark
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
		{ -- Terros
			EncounterJournalID = 2500,
			[NORMAL_RAID_DIFF] = {
				{ 1, 195502 }, -- Terros's Captive Core
				{ 2, 195504 }, -- Awakened Planar Pillar
				{ 3, 195497 }, -- Quake-Detecting Seismostaff
				{ 4, 195499 }, -- Faultline Mantle
				{ 5, 195501 }, -- Fused Shale Waistband
				{ 6, 195503 }, -- Enduring Shard of Terros
				{ 7, 195498 }, -- Gaze of the Living Quarry
				{ 8, 195500 }, -- Compressed Cultist's Frock
				{ 9, 194303 }, -- Rumbling Ruby
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
		{ -- The Primal Council
			EncounterJournalID = 2486,
			[NORMAL_RAID_DIFF] = {
				{ 1, 195487 }, -- Embar's Ashen Hauberk
				{ 2, 195489 }, -- Maul of the Earthshaper
				{ 3, 195484 }, -- Icewrath's Channeling Conduit
				{ 4, 194301 }, -- Whispering Incarnate Icon
				{ 5, 195518 }, -- Imbued Qalashi Crusher
				{ 6, 195488 }, -- Opalfang's Earthbound Legguards
				{ 7, 195485 }, -- Councilor's Terrormask
				{ 8, 194300 }, -- Conjured Chillglobe
				{ 9, 195486 }, -- Twisted Loam Spaulders
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
		{ -- Sennarth, the Cold Breath
			EncounterJournalID = 2482,
			[NORMAL_RAID_DIFF] = {
				{ 1,  194304 }, -- Iceblood Deathsnare
				{ 2,  195506 }, -- Diamond-Etched Gauntlets
				{ 3,  196603 }, -- Venerated Jade Forgestone
				{ 4,  195510 }, -- Frostbreath Thumper
				{ 5,  196598 }, -- Mystic Jade Forgestone
				{ 6,  195505 }, -- Caustic Coldsteel Slicer
				{ 7,  195507 }, -- Unnatural Dripstone Cinch
				{ 8,  195509 }, -- Ice-Climber's Cleats
				{ 9,  195511 }, -- Acid-Proof Webbing
				{ 10, 196593 }, -- Zenith Jade Forgestone
				{ 11, 196588 }, -- Dreadful Jade Forgestone
				{ 12, 195508 }, -- Chilled Silken Restraints
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
		{ -- Dathea, Ascended
			EncounterJournalID = 2502,
			[NORMAL_RAID_DIFF] = {
				{ 1,  196597 }, -- Mystic Garnet Forgestone
				{ 2,  195491 }, -- Infused Stormglaives
				{ 3,  195493 }, -- Ascended Squallspires
				{ 4,  195495 }, -- Daring Chasm-Leapers
				{ 5,  196592 }, -- Zenith Garnet Forgestone
				{ 6,  196587 }, -- Dreadful Garnet Forgestone
				{ 7,  196602 }, -- Venerated Garnet Forgestone
				{ 8,  195494 }, -- Dathea's Cyclonic Cage
				{ 9,  195481 }, -- Scepter of Drastic Measures
				{ 10, 195496 }, -- Eye of the Vengeful Hurricane
				{ 11, 195492 }, -- Windborne Hatsuburi
				{ 12, 194302 }, -- Storm-Eater's Boon
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
		{ -- Kurog Grimtotem
			EncounterJournalID = 2491,
			[NORMAL_RAID_DIFF] = {
				{ 1,  195517 }, -- Kurog's Thunderhooves
				{ 2,  194306 }, -- All-Totem of the Master
				{ 3,  195512 }, -- Fist of the Grand Summoner
				{ 4,  195514 }, -- Treacherous Totem Wraps
				{ 5,  196596 }, -- Mystic Amethyst Forgestone
				{ 6,  195513 }, -- Scripture of Primal Devotion
				{ 7,  194305 }, -- Controlled Current Technique
				{ 8,  196586 }, -- Dreadful Amethyst Forgestone
				{ 9,  195516 }, -- Surging-Song Conductors
				{ 10, 196591 }, -- Zenith Amethyst Forgestone
				{ 11, 195483 }, -- Awak'mani, Grimtotem's Legacy
				{ 12, 195515 }, -- Magatha's Spiritual Sash
				{ 13, 196601 }, -- Venerated Amethyst Forgestone
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
		{ -- Broodkeeper Diurna
			EncounterJournalID = 2493,
			[NORMAL_RAID_DIFF] = {
				{ 1,  195519 }, -- Kharnalex, The First Light
				{ 2,  195521 }, -- Ornamental Drakonid Claw
				{ 3,  194308 }, -- Manic Grieftorch
				{ 4,  195525 }, -- Loyal Flametender's Bracers
				{ 5,  196594 }, -- Zenith Lapis Forgestone
				{ 6,  196599 }, -- Mystic Lapis Forgestone
				{ 7,  196604 }, -- Venerated Lapis Forgestone
				{ 8,  195520 }, -- Broodsworn Legionnaire's Pavise
				{ 9,  194307 }, -- Broodkeeper's Promise
				{ 10, 196589 }, -- Dreadful Lapis Forgestone
				{ 11, 195526 }, -- Seal of Filial Duty
				{ 12, 195524 }, -- Matriarch's Opulent Girdle
				{ 13, 195522 }, -- Tassets of the Tarasek Legion
				{ 14, 195523 }, -- Eggtender's Safety Mitts
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
		{ -- Raszageth the Storm-Eater
			EncounterJournalID = 2499,
			[NORMAL_RAID_DIFF] = {
				{ 1,  195532 }, -- Sandals of the Wild Sovereign
				{ 2,  196605 }, -- Venerated Topaz Forgestone
				{ 3,  195527 }, -- Neltharax, Enemy of the Sky
				{ 4,  195529 }, -- Stormlash's Last Resort
				{ 5,  195531 }, -- Calamitous Shockguards
				{ 6,  195533 }, -- Shackles of Titanic Failure
				{ 7,  196600 }, -- Mystic Topaz Forgestone
				{ 8,  196590 }, -- Dreadful Topaz Forgestone
				{ 9,  194309 }, -- Spiteful Storm
				{ 10, 196595 }, -- Zenith Topaz Forgestone
				{ 11, 195528 }, -- Incarnate Sky-Splitter
				{ 12, 195530 }, -- Loathsome Thunderhosen
				{ 13, 194310 }, -- Desperate Invoker's Codex
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
	}
}

data["Aberrus, the Shadowed Crucible"] = {
	EncounterJournalID = 1208,
	MapID = 2166,
	AtlasMapID = "Aberrus",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Kazzara, the Hellforged
			EncounterJournalID = 2522,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202557 }, -- Hellsteel Mutilator
				{ 2,  202594 }, -- Bloodstench Skinguards
				{ 3,  202583 }, -- Grasps of Welded Anguish
				{ 4,  202590 }, -- Kazzara's Grafted Companion
				{ 5,  202589 }, -- Sash of Abandoned Hope
				{ 6,  202576 }, -- Dreadrift Stompers
				{ 7,  202616 }, -- Enduring Dreadplate
				{ 8,  202573 }, -- Etchings of the Captive Revenant
				{ 9,  202559 }, -- Infernal Shadelance
				{ 10, 202600 }, -- Reanimator's Wicked Cassock
				{ 11, 202602 }, -- Violent Gravemask
				{ 12, 202612 }, -- Screaming Black Dragonscale
				{ 13, 205145 }, -- Plans: Shadowed Impact Buckler
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
		{ -- The Amalgamation Chamber
			EncounterJournalID = 2529,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202579 }, -- Attendant's Concocting Cover
				{ 2,  202598 }, -- Cuirass of Meticulous Mixture
				{ 3,  202617 }, -- Elementium Pocket Anvil
				{ 4,  202572 }, -- Entropic Convergence Loop
				{ 5,  202605 }, -- Gloomfused Chemistry Belt
				{ 6,  202563 }, -- Obsidian Stirring Staff
				{ 7,  202568 }, -- Scholar's Thinking Cudgel
				{ 8,  202595 }, -- Shoulderplates of Planar Isolation
				{ 9,  202596 }, -- Tassets of Blistering Twilight
				{ 10, 202593 }, -- Unstable Vial Handlers
				{ 11, 202615 }, -- Vessel of Searing Shadow
				{ 12, 204696 }, -- Recipe: Draconic Phial Cauldron
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
		{ -- The Forgotten Experiments
			EncounterJournalID = 2530,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202652 }, -- Discarded Creation's Restraint
				{ 2,  202588 }, -- Exacting Augmenter's Sabatons
				{ 3,  202571 }, -- Experiment 1, Kitewing
				{ 4,  202582 }, -- Manacles of Cruel Progress
				{ 5,  202575 }, -- Neldris's Sinewy Scapula
				{ 6,  203729 }, -- Ominous Chromatic Essence
				{ 7,  202566 }, -- Rionthus's Bladed Visage
				{ 8,  204318 }, -- Thadrion's Erratic Arcanotrode
				{ 9,  202624 }, -- Dreadful Mixing Fluid
				{ 10, 202625 }, -- Mystic Mixing Fluid
				{ 11, 202626 }, -- Venerated Mixing Fluid
				{ 12, 202638 }, -- Zenith Mixing Fluid
				{ 13, 205140 }, -- Pattern: Undulating Sporecloak
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
		{ -- Assault of the Zaqali
			EncounterJournalID = 2524,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202574 }, -- Flamebound Huntsman's Footpads
				{ 2,  202591 }, -- Gatecrasher Giant's Coif
				{ 3,  202618 }, -- Kagni's Scorching Talisman
				{ 4,  202597 }, -- Obsidian Guard's Chausses
				{ 5,  202577 }, -- Seal of the Defiant Hordes
				{ 6,  204279 }, -- Wallclimber's Incursion Hatchet
				{ 7,  202586 }, -- Warlord's Volcanic Vest
				{ 8,  202604 }, -- Boulder-Tossing Bands
				{ 9,  202607 }, -- Brutal Dragonslayer's Trophy
				{ 10, 202580 }, -- Mystic's Scalding Frame
				{ 11, 202578 }, -- Phoenix-Plume Gloves
				{ 12, 202613 }, -- Zaqali Chaos Grapnel
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
		{ -- Rashok, the Elder
			EncounterJournalID = 2525,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202655 }, -- Elder's Volcanic Binding
				{ 2,  202603 }, -- Sandals of Ancient Fury
				{ 3,  202659 }, -- Shackles of the Shadowed Bastille
				{ 4,  204466 }, -- Tormentor's Siphoning Signet
				{ 5,  202592 }, -- Unyielding Goliath's Burgonet
				{ 6,  204319 }, -- Bloodfire Extraction Conduit
				{ 7,  202614 }, -- Rashok's Molten Heart
				{ 8,  202569 }, -- Djaruun, Pillar of the Elder Flame
				{ 9,  202634 }, -- Dreadful Cooling Fluid
				{ 10, 202635 }, -- Mystic Cooling Fluid
				{ 11, 202636 }, -- Venerated Cooling Fluid
				{ 12, 202640 }, -- Zenith Cooling Fluid
				{ 13, 205144 }, -- Plans: Shadowed Razing Annihilator
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
		{ -- The Vigilant Steward, Zskarn
			EncounterJournalID = 2532,
			[NORMAL_RAID_DIFF] = {
				{ 1,  204393 }, -- Clasps of the Diligent Steward
				{ 2,  202610 }, -- Dragonfire Bomb Dispenser
				{ 3,  204467 }, -- Drape of the Dracthyr Trials
				{ 4,  204391 }, -- Failed Applicant's Footpads
				{ 5,  204322 }, -- Failure Disposal Cannon
				{ 6,  204320 }, -- Proctor's Tactical Cleaver
				{ 7,  204400 }, -- Recycled Golemskin Waistguard
				{ 8,  202555 }, -- Zskarn's Autopsy Scalpel
				{ 9,  202631 }, -- Dreadful Ventilation Fluid
				{ 10, 202632 }, -- Mystic Ventilation Fluid
				{ 11, 202633 }, -- Venerated Ventilation Fluid
				{ 12, 202639 }, -- Zenith Ventilation Fluid
				{ 13, 205036 }, -- Schematic: Tinker: Shadowflame Rockets
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
		{ -- Magmorax
			EncounterJournalID = 2527,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202560 }, -- Claws of the Blazing Behemoth
				{ 2,  204394 }, -- Cuffs of the Savage Serpent
				{ 3,  204395 }, -- Hydratooth Girdle
				{ 4,  203996 }, -- Igneous Flowstone
				{ 5,  202570 }, -- Lavaflow Control Rod
				{ 6,  204397 }, -- Magmorax's Fourth Collar
				{ 7,  204396 }, -- Spittle-Resistant Sollerets
				{ 8,  202627 }, -- Dreadful Melting Fluid
				{ 9,  202628 }, -- Mystic Melting Fluid
				{ 10, 202629 }, -- Venerated Melting Fluid
				{ 11, 202630 }, -- Zenith Melting Fluid
				{ 12, 204975 }, -- Formula: Enchant Weapon - Shadowflame Wreathe
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
		{ -- Echo of Neltharion
			EncounterJournalID = 2523,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202606 }, -- Ashkandur, Fall of the Brotherhood
				{ 2,  202558 }, -- Calamity's Herald
				{ 3,  204324 }, -- Echo's Maddening Volume
				{ 4,  204398 }, -- Onyx Impostor's Birthright
				{ 5,  204392 }, -- Treads of Fractured Realities
				{ 6,  203714 }, -- Ward of Faceless Ire
				{ 7,  202601 }, -- Twisted Vision's Demigaunts
				{ 8,  204201 }, -- Neltharion's Call to Chaos
				{ 9,  204202 }, -- Neltharion's Call to Dominance
				{ 10, 204211 }, -- Neltharion's Call to Suffering
				{ 11, 202621 }, -- Dreadful Corrupting Fluid
				{ 12, 202622 }, -- Mystic Corrupting Fluid
				{ 13, 202623 }, -- Venerated Corrupting Fluid
				{ 14, 202637 }, -- Zenith Corrupting Fluid
				{ 15, 204968 }, -- Pattern: Shadowflame-Tempered Armor Patch
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
		{ -- Scalecommander Sarkareth
			EncounterJournalID = 2520,
			[NORMAL_RAID_DIFF] = {
				{ 1,  202584 }, -- Scalecommander's Ebon Schynbalds
				{ 2,  204390 }, -- Bonds of Desperate Ascension
				{ 3,  202565 }, -- Erethos, the Empty Promise
				{ 4,  204399 }, -- Oblivion's Immortal Coil
				{ 5,  203963 }, -- Beacon to the Beyond
				{ 6,  202585 }, -- Coattails of the Rightful Heir
				{ 7,  204424 }, -- Crechebound Soldier's Boots
				{ 8,  202564 }, -- Fang of the Sundered Flame
				{ 9,  202587 }, -- Oathbreaker's Obsessive Gauntlets
				{ 10, 202599 }, -- Sarkareth's Abyssal Embrace
				{ 11, 204465 }, -- Voice of the Silent Star
				{ 12, 206955 }, -- Highland Drake: Embodiment of the Hellforged
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
	}
}

data["Amirdrassil, the Dream's Hope"] = {
	EncounterJournalID = 1207,
	MapID = 2232,
	AtlasMapID = "AmirdrassilA",
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items =
	{
		{ -- Gnarlroot
			EncounterJournalID = 2564,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207142 }, -- Ancient Haubark
				{ 2,  207117 }, -- Requiem Rootmantle
				{ 3,  207153 }, -- Seared Ironwood Greaves
				{ 4,  207133 }, -- Silent Tormentor's Hood
				{ 5,  207120 }, -- Anguished Restraints
				{ 6,  207169 }, -- Branch of the Tormented Ancient
				{ 7,  207797 }, -- Defender of the Ancient
				{ 8,  207144 }, -- Forlorn Leaf Clasp
				{ 9,  207800 }, -- Gnarlroot's Bonecrusher
				{ 10, 207160 }, -- Inflammable Drapeleaf
				{ 11, 207794 }, -- Staff of Incandescent Torment
				{ 12, 207126 }, -- Twisted Blossom Stompers
				{ 13, 210170 }, -- Design: Dreamtender's Charm
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
		{ -- Igira the Cruel
			EncounterJournalID = 2554,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207165 }, -- Bandolier of Twisted Blades
				{ 2,  207131 }, -- Bloody Dragonhide Belt
				{ 3,  207118 }, -- Elder's Volcanic Wrap
				{ 4,  207787 }, -- Igira's Flaying Hatchet
				{ 5,  207162 }, -- Signet of the Last Elder
				{ 6,  207150 }, -- Agonizing Manacles
				{ 7,  207783 }, -- Cruel Dreamcarver
				{ 8,  207140 }, -- Drakestalker's Trophy Pauldrons
				{ 9,  207466 }, -- Dreadful Tormented Dreamheart
				{ 10, 207467 }, -- Mystic Tormented Dreamheart
				{ 11, 207468 }, -- Venerated Tormented Dreamheart
				{ 12, 207469 }, -- Zenith Tormented Dreamheart
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
		{ -- Volcoross
			EncounterJournalID = 2557,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207175 }, -- Coiled Serpent Idol
				{ 2,  207130 }, -- Flamewaker's Grips
				{ 3,  207128 }, -- Primordial Serpent's Bindings
				{ 4,  207121 }, -- Vesture of the Smoldering Serpent
				{ 5,  207146 }, -- Jeweled Sash of the Viper
				{ 6,  207148 }, -- Lavaforged Sollerets
				{ 7,  207122 }, -- Lost Scholar's Belted Treads
				{ 8,  207785 }, -- Magmatic Volcannon
				{ 9,  210214 }, -- Ouroboreal Necklet
				{ 10, 207141 }, -- Snake Eater's Cowl
				{ 11, 207152 }, -- Volcanic Spelunker's Vents
				{ 12, 207789 }, -- Volcoross's Barbed Fang
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
		{ -- Council of Dreams
			EncounterJournalID = 2555,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207138 }, -- Aerwynn's Ritual Sarong
				{ 2,  207139 }, -- Cleats of the Savage Claw
				{ 3,  207151 }, -- Emerald Guardian's Casque
				{ 4,  207173 }, -- Gift of Ursine Vengeance
				{ 5,  207168 }, -- Pip's Emerald Friendship Badge
				{ 6,  207782 }, -- Sickle of the White Stag
				{ 7,  207127 }, -- Strigine Epaulets
				{ 8,  207784 }, -- Thorncaller Claw
				{ 9,  207796 }, -- Trickster's Captivating Chime
				{ 10, 207119 }, -- Urctos's Hibernal Dial
				{ 11, 210206 }, -- Verdant Sanctuary Bands
				{ 12, 210205 }, -- Vigilant Protector's Bracers
				{ 13, 210169 }, -- Pattern: Verdant Conduit
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
		{ -- Larodar, Keeper of the Flame
			EncounterJournalID = 2553,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207790 }, -- Larodar's Moonblade
				{ 2,  207116 }, -- Lost Scholar's Timely Hat
				{ 3,  207149 }, -- Phlegethic Girdle
				{ 4,  207792 }, -- Scythe of the Fallen Keeper
				{ 5,  207170 }, -- Smoldering Seedling
				{ 6,  207143 }, -- Twisted Flamecuffs
				{ 7,  207159 }, -- Band of Burning Thorns
				{ 8,  207129 }, -- Robes of the Ashen Grove
				{ 9,  207474 }, -- Dreadful Ashen Dreamheart
				{ 10, 207475 }, -- Mystic Ashen Dreamheart
				{ 11, 207476 }, -- Venerated Ashen Dreamheart
				{ 12, 207477 }, -- Zenith Ashen Dreamheart
				{ 13, 210175 }, -- Formula: Enchant Weapon - Dreaming Devotion
				{ 14, 209035 }, -- Hearthstone of the Flame
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
		{ -- Nymue, Weaver of the Cycle
			EncounterJournalID = 2556,
			[NORMAL_RAID_DIFF] = {
				{ 1,  208445 }, -- Amulet of Eonar's Chosen
				{ 2,  207135 }, -- Eternal Sentinel's Cord
				{ 3,  207123 }, -- Lifewoven Slippers
				{ 4,  208615 }, -- Nymue's Unraveling Spindle
				{ 5,  207798 }, -- Verdant Matrix Beacon
				{ 6,  207155 }, -- Eldermoss Gauntlets
				{ 7,  210203 }, -- Wellspring Wristlets
				{ 8,  208616 }, -- Dreambinder, Loom of the Great Cycle
				{ 9,  207462 }, -- Dreadful Verdurous Dreamheart
				{ 10, 207463 }, -- Mystic Verdurous Dreamheart
				{ 11, 207464 }, -- Venerated Verdurous Dreamheart
				{ 12, 207465 }, -- Zenith Verdurous Dreamheart
				{ 13, 210670 }, -- Pattern: Verdant Tether
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
		{ -- Smolderon
			EncounterJournalID = 2563,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207167 }, -- Ashes of the Embersoul
				{ 2,  207166 }, -- Cataclysmic Signet Brand
				{ 3,  207791 }, -- Remnant Charglaive
				{ 4,  210204 }, -- Fading Flame Wristbands
				{ 5,  207156 }, -- Fused Obsidian Sabatons
				{ 6,  207799 }, -- Incandescent Soulcleaver
				{ 7,  207161 }, -- Mantle of Blazing Sacrifice
				{ 8,  207478 }, -- Dreadful Smoldering Dreamheart
				{ 9,  207479 }, -- Mystic Smoldering Dreamheart
				{ 10, 207480 }, -- Venerated Smoldering Dreamheart
				{ 11, 207481 }, -- Zenith Smoldering Dreamheart
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
		{ -- Tindral Sageswift, Seer of the Flame
			EncounterJournalID = 2565,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207780 }, -- Ashen Ranger's Longbow
				{ 2,  207172 }, -- Belor'relos, the Suncaller
				{ 3,  207795 }, -- Eternal Kindler's Greatstaff
				{ 4,  207163 }, -- Eye of the Rising Flame
				{ 5,  207137 }, -- Flameseer's Winged Grasps
				{ 6,  207157 }, -- Smoldering Chevalier's Greatbelt
				{ 7,  207781 }, -- Betrayer's Cinderblade
				{ 8,  207134 }, -- Tasseted Emberwalkers
				{ 9,  207470 }, -- Dreadful Blazing Dreamheart
				{ 10, 207471 }, -- Mystic Blazing Dreamheart
				{ 11, 207472 }, -- Venerated Blazing Dreamheart
				{ 12, 207473 }, -- Zenith Blazing Dreamheart
				{ 13, 210644 }, -- Plans: Flourishing Dream Helm
				{ 14, 211280 }, -- Feather of the Smoke Red Moon
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
		{ -- Fyrakk the Blazing
			EncounterJournalID = 2519,
			[NORMAL_RAID_DIFF] = {
				{ 1,  207728 }, -- Fyr'alath the Dreamrender
				{ 2,  207154 }, -- Carapace of the Unbending Flame
				{ 3,  207132 }, -- Frenzied Incarnate Legwraps
				{ 4,  207793 }, -- Rashon, the Immortal Blaze
				{ 5,  207115 }, -- Twisting Shadow Claws
				{ 6,  207788 }, -- Vakash, the Shadowed Inferno
				{ 7,  207124 }, -- Blooming Redeemer's Sash
				{ 8,  207145 }, -- Boots of the Molten Hoard
				{ 9,  207786 }, -- Gholak, the Final Conflagration
				{ 10, 207171 }, -- Blossom of Amirdrassil
				{ 11, 207174 }, -- Fyrakk's Tainted Rageheart
				{ 12, 208614 }, -- Augury of the Primal Flame
				{ 13, 210947 }, -- Flame-Warped Curio
				{ 14, 210536 }, -- Renewed Proto-Drake: Embodiment of the Blazing
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 15, 210061, "mount" }, -- Reins of Anu'relos, Flame's Guidance
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}
