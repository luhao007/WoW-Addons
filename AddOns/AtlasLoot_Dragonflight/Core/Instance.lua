-- $Id: Instance.lua 8 2022-11-20 08:02:32Z arithmandar $
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
local _, private = ...
local AtlasLoot = _G.AtlasLoot
local data = private.data
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
	--AtlasMapID = "",
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
	--AtlasMapID = "",
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
	--AtlasMapID = "",
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
	--AtlasMapID = "",
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
				{ 1, 193751 }, -- Crown of Roaring Storms
				{ 2, 193753 }, -- Breastplate of Soaring Terror
				{ 3, 193755 }, -- Backdraft Cleaver
				{ 4, 193748 }, -- Kyrakka's Searing Embers
				{ 5, 193750 }, -- Wind Soarer's Breeches
				{ 6, 193752 }, -- Galerattle Gauntlets
				{ 7, 193756 }, -- Skyferno Rondel
				{ 8, 193754 }, -- Drake Rider's Stecktarge
				{ 9, 193691 }, -- Sky Saddle Cord
				{ 10, 198056 }, --Titan Training Matrix II
			},
			[HEROIC_DUNGEON_DIFF] = {
				{ 1, 193751 }, -- Crown of Roaring Storms
				{ 2, 193753 }, -- Breastplate of Soaring Terror
				{ 3, 193755 }, -- Backdraft Cleaver
				{ 4, 193748 }, -- Kyrakka's Searing Embers
				{ 5, 193750 }, -- Wind Soarer's Breeches
				{ 6, 193752 }, -- Galerattle Gauntlets
				{ 7, 193756 }, -- Skyferno Rondel
				{ 8, 193754 }, -- Drake Rider's Stecktarge
				{ 9, 193691 }, -- Sky Saddle Cord
				{ 10, 198058 }, --Titan Training Matrix III
			},
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 193751 }, -- Crown of Roaring Storms
				{ 2, 193753 }, -- Breastplate of Soaring Terror
				{ 3, 193755 }, -- Backdraft Cleaver
				{ 4, 193748 }, -- Kyrakka's Searing Embers
				{ 5, 193750 }, -- Wind Soarer's Breeches
				{ 6, 193752 }, -- Galerattle Gauntlets
				{ 7, 193756 }, -- Skyferno Rondel
				{ 8, 193754 }, -- Drake Rider's Stecktarge
				{ 9, 193691 }, -- Sky Saddle Cord
				{ 10, 198059 }, --Titan Training Matrix IV
			},
		},
	}
}

data["The Azure Vault"] = {
	EncounterJournalID = 1203,
	MapID = 2073,
	--AtlasMapID = "",
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
	--AtlasMapID = "",
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
	--AtlasMapID = "",
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
				{ 1, 194304 }, -- Iceblood Deathsnare
				{ 2, 195506 }, -- Diamond-Etched Gauntlets
				{ 3, 196603 }, -- Venerated Jade Forgestone
				{ 4, 195510 }, -- Frostbreath Thumper
				{ 5, 196598 }, -- Mystic Jade Forgestone
				{ 6, 195505 }, -- Caustic Coldsteel Slicer
				{ 7, 195507 }, -- Unnatural Dripstone Cinch
				{ 8, 195509 }, -- Ice-Climber's Cleats
				{ 9, 195511 }, -- Acid-Proof Webbing
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
				{ 1, 196597 }, -- Mystic Garnet Forgestone
				{ 2, 195491 }, -- Infused Stormglaives
				{ 3, 195493 }, -- Ascended Squallspires
				{ 4, 195495 }, -- Daring Chasm-Leapers
				{ 5, 196592 }, -- Zenith Garnet Forgestone
				{ 6, 196587 }, -- Dreadful Garnet Forgestone
				{ 7, 196602 }, -- Venerated Garnet Forgestone
				{ 8, 195494 }, -- Dathea's Cyclonic Cage
				{ 9, 195481 }, -- Scepter of Drastic Measures
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
				{ 1, 195517 }, -- Kurog's Thunderhooves
				{ 2, 194306 }, -- All-Totem of the Master
				{ 3, 195512 }, -- Fist of the Grand Summoner
				{ 4, 195514 }, -- Treacherous Totem Wraps
				{ 5, 196596 }, -- Mystic Amethyst Forgestone
				{ 6, 195513 }, -- Scripture of Primal Devotion
				{ 7, 194305 }, -- Controlled Current Technique
				{ 8, 196586 }, -- Dreadful Amethyst Forgestone
				{ 9, 195516 }, -- Surging-Song Conductors
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
				{ 1, 195519 }, -- Kharnalex, The First Light
				{ 2, 195521 }, -- Ornamental Drakonid Claw
				{ 3, 194308 }, -- Manic Grieftorch
				{ 4, 195525 }, -- Loyal Flametender's Bracers
				{ 5, 196594 }, -- Zenith Lapis Forgestone
				{ 6, 196599 }, -- Mystic Lapis Forgestone
				{ 7, 196604 }, -- Venerated Lapis Forgestone
				{ 8, 195520 }, -- Broodsworn Legionnaire's Pavise
				{ 9, 194307 }, -- Broodkeeper's Promise
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
				{ 1, 195532 }, -- Sandals of the Wild Sovereign
				{ 2, 196605 }, -- Venerated Topaz Forgestone
				{ 3, 195527 }, -- Neltharax, Enemy of the Sky
				{ 4, 195529 }, -- Stormlash's Last Resort
				{ 5, 195531 }, -- Calamitous Shockguards
				{ 6, 195533 }, -- Shackles of Titanic Failure
				{ 7, 196600 }, -- Mystic Topaz Forgestone
				{ 8, 196590 }, -- Dreadful Topaz Forgestone
				{ 9, 194309 }, -- Spiteful Storm
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
