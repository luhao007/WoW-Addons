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
local data = AtlasLoot.ItemDB:Add(addonname, 8)

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

-- Shared loot tables
local BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE = {	--[BattleforAzeroth Dungeon Hero]
	name = select(2, GetAchievementInfo(12807)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 12807 },
		{ 2, 12505 },			{ 17, 12501 },
		{ 3, 12484 },			{ 18, 12832 },
		{ 4, 12837 },			{ 19, 12825 },
		{ 5, 12841 },			{ 20, 12845 },
	},
}

local BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE = {	--[Glory of the Wartorn Hero]
	name = select(2, GetAchievementInfo(12812)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[MYTHIC_DIFF] = {
		{ 1, 12812, --[[ "mount239049" ]] },
		{ 2, 12550 },			{ 17, 12548 },
		{ 3, 12998 },			{ 18, 12489 },
		{ 4, 12495 },			{ 19, 12490 },
		{ 5, 12600 },			{ 20, 12601 },
		{ 6, 12602 },			{ 21, 12270 },
		{ 7, 12272 },			{ 22, 12273 },
		{ 8, 12549 },			{ 23, 12498 },
		{ 9, 12499 },			{ 24, 12503 },
		{ 10, 12507 },			{ 25, 12508 },
		{ 11, 12457 },			{ 26, 12462 },
		{ 12, 12855 },			{ 27, 12854 },
		{ 13, 12727 },			{ 28, 12726 },
		{ 14, 12722 },			{ 29, 12723 },
		{ 15, 12721 },
	},
}
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
data["Atal'Dazar"] = {
	EncounterJournalID = 968,
	MapID = 934,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Priestess Alun'za
			EncounterJournalID = 2082,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 158321 }, -- Wand of Zealous Purification
				{ 2, 158322 }, -- Aureus Vessel
				{ 3, 158309 }, -- Wristlinks of Alchemical Transfusion
				{ 4, 158313 }, -- Legplates of Beaten Gold
				{ 5, 155861 }, -- Embellished Ritual Sabatons
				{ 6, 158319 }, -- My'das Talisman
				{ 7, 158306 }, -- Belt of Gleaming Determination
				{ 8, 158347 }, -- Cincture of Glittering Gold
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12272" }, -- AC: Mythic: Atal`Dazar "Gold Fever"
				{ 17, "ac12270" }, -- AC: Mythic: Atal`Dazar "Bringing Hexy Back"
			},
		},
		{ -- Vol'kaal
			EncounterJournalID = 2036,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 155869 }, -- Shambling Berserker's Leggings
				{ 2, 159632 }, -- Adulation Enforcer
				{ 3, 158317 }, -- Gauntlets of Eternal Service
				{ 4, 159445 }, -- Grips of the Everlasting Guardian
				{ 5, 158375 }, -- Drape of the Loyal Vassal
				{ 6, 158320 }, -- Revitalizing Voodoo Totem
				{ 7, 158348 }, -- Wraps of Everliving Fealty
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12270" }, -- AC: Mythic: Atal`Dazar "Bringing Hexy Back"
			},
		},
		{ -- Rezan
			EncounterJournalID = 2083,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 158713 }, -- Disc of Indomitable Will
				{ 2, 160214 }, -- Venerated Raptorhide Bindings
				{ 3, 160269 }, -- Soulrending Claw
				{ 4, 159458 }, -- Seal of the Regal Loa
				{ 5, 155868 }, -- Kilt of Fanatical Consumption
				{ 6, 158711 }, -- Hallowed Ossein Longbow
				{ 7, 158712 }, -- Rezan's Gleaming Eye
				{ 8, 158303 }, -- Devilsaur Worshiper's Sandals
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12270" }, -- AC: Mythic: Atal`Dazar "Bringing Hexy Back"
			},
		},
		{ -- Yazma
			EncounterJournalID = 2030,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 158304 }, -- Mantle of Fastidious Machinations
				{ 2, 158323 }, -- Soulrender's Fang
				{ 3, 159233 }, -- Loa Betrayer's Vestments
				{ 4, 159610 }, -- Vessel of Skittering Shadows
				{ 5, 160212 }, -- Shadowshroud Vambraces
				{ 6, 159358 }, -- Coif of the Court Spider
				{ 7, 155866 }, -- Soulspun Casque
				{ 8, 158308 }, -- Souldrifting Sabatons
				{ 9, 158315 }, -- Secret Spinner's Miter
				{ 10, 155860 }, -- Spymaster's Wrap
				{ 16, "ac12824" }, -- AC: Atal'Dazar
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12825" }, -- AC: Heroic: Atal'Dazar
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12826" }, -- AC: Mythic: Atal'Dazar
				{ 17, "ac12270" }, -- AC: Mythic: Atal`Dazar "Bringing Hexy Back"
				{ 18, "ac12273" }, -- AC: Mythic: Atal`Dazar "It's Lit!"
				{ 19, "ac13002" }, -- AC: Mythic: Atal'Dazar Guild Run
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Freehold"] = {
	EncounterJournalID = 1001,
	MapID = 936,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Skycap'n Kragg
			EncounterJournalID = 2102,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159633 }, -- Sharkbait's Fishhook
				{ 2, 159353 }, -- Chain-Linked Safety Cord
				{ 3, 158360 }, -- Sharkbait Harness Girdle
				{ 4, 155862 }, -- Kragg's Rigging Scalers
				{ 5, 155884 }, -- Parrotfeather Cloak
				{ 6, 159227 }, -- Silk Cuffs of the Skycap'n
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12548" }, -- AC: Mythic: Freehold "I'm in Charge Now!"
				{ 17, "ac12550" }, -- AC: Mythic: Freehold "Pecking Order"
			},
		},
		{ -- Council o' Captains
			EncounterJournalID = 2093,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 158314 }, -- Seal of Questionable Loyalties
				{ 2, 158346 }, -- Sailcloth Waistband
				{ 3, 158351 }, -- Dashing Bilge Rat Shoes
				{ 4, 159297 }, -- Silver-Trimmed Breeches
				{ 5, 159130 }, -- Captain's Diplomacy
				{ 6, 159132 }, -- Jolly's Boot Dagger
				{ 7, 159356 }, -- Raoul's Barrelhook Bracers
				{ 8, 158311 }, -- Concealed Fencing Plates
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12550" }, -- AC: Mythic: Freehold "Pecking Order"
			},
		},
		{ -- Ring of Booty
			EncounterJournalID = 2094,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 158302 }, -- Chum-Coated Leggings
				{ 2, 155889 }, -- Sharkhide Grips
				{ 3, 155891 }, -- Greasy Bacon-Grabbers
				{ 4, 159634 }, -- Jeweled Sharksplitter
				{ 5, 158361 }, -- Sharkwater Waders
				{ 6, 158305 }, -- Sea Dog's Cuffs
				{ 7, 155892 }, -- Bite-Resistant Chain Gloves
				{ 8, 158356 }, -- Shell-Kickers
				{ 9, 155890 }, -- Sharktooth-Knuckled Grips
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12550" }, -- AC: Mythic: Freehold "Pecking Order"
			},
		},
		{ -- Harlan Sweete
			EncounterJournalID = 2095,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159352 }, -- Gaping Maw Shoulderguard
				{ 2, 159407 }, -- Lockjaw Shoulderplate
				{ 3, 155886 }, -- Smartly Plumed Cap
				{ 4, 155888 }, -- Irontide Captain's Hat
				{ 5, 155887 }, -- Sweete's Jeweled Headgear
				{ 6, 159299 }, -- Gold-Tasseled Epaulets
				{ 7, 155881 }, -- Harlan's Loaded Dice
				{ 8, 159635 }, -- Bloody Tideturner
				{ 9, 155885 }, -- Sea-Brawler's Greathelm
				{ 10, 158301 }, -- Ruffled Poet Blouse
				{ 16, "ac12831" }, -- AC: Freehold
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12832" }, -- AC: Heroic: Freehold
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12833" }, -- AC: Mythic: Freehold
				{ 17, "ac12998" }, -- AC: Mythic: Freehold "That Sweete Booty"
				{ 18, "ac12550" }, -- AC: Mythic: Freehold "Pecking Order"
				{ 19, "ac12999" }, -- AC: Mythic: Freehold Guild Run
				{ 21, 159842, "mount" }, -- Sharkbait
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Kings' Rest"] = {
	EncounterJournalID = 1041,
	MapID = 1004,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- The Golden Serpent
			EncounterJournalID = 2165,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159413 }, -- Gauntlets of the Avian Sentinel
				{ 2, 159617 }, -- Lustrous Golden Plumage
				{ 3, 159313 }, -- Breeches of the Sacred Hall
				{ 4, 159234 }, -- Down-Lined Breeches
				{ 5, 159137 }, -- Gilded Serpent's Tooth
				{ 6, 159369 }, -- Belt of the Consecrated Tomb
				{ 7, 159412 }, -- Auric Puddle Stompers
				{ 8, 159304 }, -- Goldfeather Boots
				{ 16, "ac12722" }, -- AC: Mythic: Kings' Rest "It Belongs in a Mausoleum!"
			},
		},
		{ -- Mchimba the Embalmer
			EncounterJournalID = 2171,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 160213 }, -- Sepulchral Construct's Gloves
				{ 2, 159618 }, -- Mchimba's Ritual Bandages
				{ 3, 159409 }, -- Embalmer's Steadying Bracers
				{ 4, 159312 }, -- Desiccator's Blessed Gloves
				{ 5, 159642 }, -- Royal Purifier's Spade
				{ 6, 159459 }, -- Ritual Binder's Ring
				{ 7, 159667 }, -- Vessel of Last Rites
				{ 16, "ac12721" }, -- AC: Mythic: Kings' Rest "Wrap God"
				{ 17, "ac12722" }, -- AC: Mythic: Kings' Rest "It Belongs in a Mausoleum!"
			},
		},
		{ -- The Council of Tribes
			EncounterJournalID = 2170,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159371 }, -- Boots of the Headlong Conqueror
				{ 2, 159288 }, -- Cloak of the Restless Tribes
				{ 3, 160216 }, -- Crackling Jade Kilij
				{ 4, 159136 }, -- Jeweled Dagger of Subjugation
				{ 5, 159300 }, -- Kula's Butchering Wristwraps
				{ 6, 159243 }, -- Sandals of Wise Voodoo
				{ 7, 159643 }, -- Crossbow of Forgotten Majesty
				{ 8, 159418 }, -- Girdle of Pestilent Purification
				{ 16, "ac12722" }, -- AC: Mythic: Kings' Rest "It Belongs in a Mausoleum!"
			},
		},
		{ -- Dazar, The First King
			EncounterJournalID = 2172,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159236 }, -- Headdress of the First Empire
				{ 2, 159645 }, -- Headcracker of Supplication
				{ 3, 159422 }, -- Helm of the Raptor King
				{ 4, 158344 }, -- Mantle of Ceremonial Ascension
				{ 5, 159368 }, -- Spaulders of Prime Emperor
				{ 6, 159644 }, -- Geti'ikku, Cut of Death
				{ 7, 159301 }, -- Primal Dinomancer's Belt
				{ 8, 159423 }, -- Pauldrons of the Great Unifier
				{ 9, 158355 }, -- Loa-Blessed Chestguard
				{ 10, 159303 }, -- Vest of Reverent Adoration
				{ 16, "ac12848" }, -- AC: Mythic: Kings' Rest
				{ 17, "ac12723" }, -- AC: Mythic: Kings' Rest "How to Keep a Mummy"
				{ 18, "ac13008" }, -- AC: Mythic: Kings' Rest Guild Run 
				{ 20, 159921, "mount" }, -- Mummified Raptor Skull
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Shrine of the Storm"] = {
	EncounterJournalID = 1036,
	MapID = 1039,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Aqu'sirr
			EncounterJournalID = 2153,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159420 }, -- Stormsurger's Sabatons
				{ 2, 159239 }, -- Aqu'sirr's Swirling Sash
				{ 3, 159366 }, -- Water Shapers
				{ 4, 159619 }, -- Briny Barnacle
				{ 5, 158318 }, -- Murky Cerulean Signet
				{ 6, 159321 }, -- Gloves of Corrupted Waters
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12600" }, -- AC: Mythic: Shrine of the Storm "Breath of the Shrine"
			},
		},
		{ -- Tidesage Council
			EncounterJournalID = 2154,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159295 }, -- Footpads of the Serene Wake
				{ 2, 159359 }, -- Sea Priest's Greaves
				{ 3, 159311 }, -- Blessing Bearer's Waders
				{ 4, 159419 }, -- Ironhull's Reinforced Legplates
				{ 5, 159614 }, -- Galecaller's Boon
				{ 6, 159426 }, -- Belt of the Unrelenting Gale
				{ 7, 158371 }, -- Seabreeze
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12600" }, -- AC: Mythic: Shrine of the Storm "Breath of the Shrine"
			},
		},
		{ -- Lord Stormsong
			EncounterJournalID = 2155,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159308 }, -- Bracers of the Sacred Fleet
				{ 2, 159421 }, -- Gauntlets of Total Subservience
				{ 3, 159646 }, -- Aq'mar, the Tidecaller
				{ 4, 159242 }, -- Leggings of the Drowned Lord
				{ 5, 159364 }, -- Bindings of the Calling Depths
				{ 6, 159289 }, -- Void-Drenched Cape
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12601" }, -- AC: Mythic: Shrine of the Storm "The Void Lies Sleeping"
				{ 17, "ac12600" }, -- AC: Mythic: Shrine of the Storm "Breath of the Shrine"
			},
		},
		{ -- Vol'zith the Whisperer
			EncounterJournalID = 2156,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159307 }, -- Tentacle-Laced Spaulders
				{ 2, 159354 }, -- Hauberk of Sunken Despair
				{ 3, 159238 }, -- Mantle of Void-Touched Waters
				{ 4, 159135 }, -- Deep Fathom's Bite
				{ 5, 159302 }, -- Cowl of Fluid Machinations
				{ 6, 159244 }, -- Stormlurker's Cowl
				{ 7, 159430 }, -- Helm of Abyssal Malevolence
				{ 8, 159408 }, -- Chestguard of the Deep Denizen
				{ 9, 159620 }, -- Conch of Dark Whispers
				{ 10, 159377 }, -- Chain of Consummate Power
				{ 16, "ac12835" }, -- AC: Shrine of the Storm
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12837" }, -- AC: Heroic: Shrine of the Storm
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12838" }, -- AC: Mythic: Shrine of the Storm
				{ 17, "ac12602" }, -- AC: Mythic: Shrine of the Storm "Trust No One"
				{ 18, "ac12600" }, -- AC: Mythic: Shrine of the Storm "Breath of the Shrine"
				{ 19, "ac13001" }, -- AC: Mythic: Shrine of the Storm Guild Run
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Siege of Boralus"] = {
	EncounterJournalID = 1023,
	MapID = 1162,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Chopper Redhook
			EncounterJournalID = 2132,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159973 }, -- Boarder's Billy Club
				{ 2, 159972 }, -- Mutineer's Fate
				{ 3, 159968 }, -- Gloves of the Iron Reavers
				{ 4, 159969 }, -- Powdershot Leggings
				{ 5, 159965 }, -- Redhook's Cummerbund
				{ 6, 159427 }, -- Legplates of the Irontide Raider
				{ 7, 162541 }, -- Band of the Roving Scalawag
				{ 8, 159251 }, -- Top-Sail Footwraps
				{ 16, "ac12489" }, -- AC: Mythic: Waycrest Manor shared "Losing My Profession"
			},
		},
		{ -- Dread Captain Lockwood
			EncounterJournalID = 2173,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159309 }, -- Port Pillager's Belt
				{ 2, 159649 }, -- Saber of Dread Pirate Lockwood
				{ 3, 159623 }, -- Dead-Eye Spyglass
				{ 4, 159250 }, -- Powder Monkey's Leggings
				{ 5, 159237 }, -- Captain's Dustfinders
				{ 6, 159434 }, -- Cannoneer's Toolbelt
				{ 7, 159429 }, -- Rope-Scored Gauntlets
				{ 8, 159372 }, -- Dread Captain's Irons
				{ 9, 159320 }, -- Besieger's Deckstalkers
				{ 10, 159379 }, -- Sure-Foot Sabatons
				{ 16, "ac12727" }, -- AC: Mythic: Siege of Boralus "Stand by Me"
				{ 17, "ac12489" }, -- AC: Mythic: Waycrest Manor shared "Losing My Profession"
			},
		},
		{ -- Hadal Darkfathom
			EncounterJournalID = 2134,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159322 }, -- Seawalker's Pantaloons
				{ 2, 159386 }, -- Anchor Chain Girdle
				{ 3, 159428 }, -- Ballast Sinkers
				{ 4, 159650 }, -- Dismembered Submersible Claw
				{ 5, 159622 }, -- Hadal's Nautilus
				{ 6, 159461 }, -- Band of the Ancient Dredger
				{ 16, "ac12489" }, -- AC: Mythic: Waycrest Manor shared "Losing My Profession"
			},
		},
		{ -- Viq'Goth
			EncounterJournalID = 2140,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 159431 }, -- Kraken Shell Pauldrons
				{ 2, 159362 }, -- Tri-Heart Chestguard
				{ 3, 159651 }, -- Coral-Edged Crescent
				{ 4, 159310 }, -- Circlet of the Enveloping Leviathan
				{ 5, 159252 }, -- Grasping Crown of the Deep
				{ 6, 159314 }, -- Cephalohide Jacket
				{ 7, 159376 }, -- Hook-Barbed Spaulders
				{ 8, 159416 }, -- Harpooner's Plate Cuirass
				{ 9, 159256 }, -- Iron-Kelp Wristwraps
				{ 16, "ac12847" }, -- AC: Mythic: Siege of Boralus
				{ 17, "ac12726" }, -- AC: Mythic: Siege of Boralus "A Fish Out of Water"
				{ 18, "ac12489" }, -- AC: Mythic: Waycrest Manor shared "Losing My Profession"
				{ 19, "ac13007" }, -- AC: Mythic: Siege of Boralus Guild Run
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Temple of Sethraliss"] = {
	EncounterJournalID = 1030,
	MapID = 1038,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Adderis and Aspix
			EncounterJournalID = 2142,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159388 }, -- Sabatons of Coruscating Energy
				{ 2, 158370 }, -- Twin-Strike Polearm
				{ 3, 159317 }, -- Whirling Dervish Sash
				{ 4, 159259 }, -- Sandswept Sandals
				{ 5, 159636 }, -- Staff of the Lightning Serpent
				{ 6, 159263 }, -- Bindings of the Slithering Current
				{ 7, 159329 }, -- Leggings of the Galeforce Viper
				{ 8, 159380 }, -- Arc-Glass Bindings
				{ 9, 159425 }, -- Shard-Tipped Vambraces
				{ 10, 159435 }, -- Legplates of Charged Duality
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Merektha
			EncounterJournalID = 2143,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159637 }, -- Snakebite Recurve
				{ 2, 158714 }, -- Swarm's Edge
				{ 3, 162544 }, -- Jade Ophidian Band
				{ 4, 159437 }, -- Fangproof Gauntlets
				{ 5, 159375 }, -- Legguards of the Awakening Brood
				{ 6, 159327 }, -- Sand-Shined Snakeskin Sandals
				{ 7, 159255 }, -- Ouroborial Sash
				{ 8, 158367 }, -- Merektha's Fang
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 9, 160832, "pet2186" }, -- Viable Cobra Egg
			},
		},
		{ -- Galvazzt
			EncounterJournalID = 2144,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159442 }, -- Sand-Scoured Greatbelt
				{ 2, 159247 }, -- Handwraps of Oscillating Polarity
				{ 3, 158366 }, -- Charged Sandstone Band
				{ 4, 158374 }, -- Tiny Electromental in a Jar
				{ 5, 158369 }, -- Galvanized Stormcrusher
				{ 6, 159664 }, -- Bulwark of Brimming Potential
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Avatar of Sethraliss
			EncounterJournalID = 2145,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159337 }, -- Grips of Electrified Defense
				{ 2, 158368 }, -- Fangs of Intertwined Essence
				{ 3, 159257 }, -- Robes of the Reborn Serpent
				{ 4, 159439 }, -- C'thraxxi Binders Pauldrons
				{ 5, 159370 }, -- Corrupted Hexxer's Vestments
				{ 6, 159374 }, -- Sethraliss' Fanged Helm
				{ 7, 159424 }, -- Desert Guardian's Breastplate
				{ 8, 159318 }, -- Hood of the Slithering Loa
				{ 9, 159254 }, -- Brood Cleanser's Amice
				{ 10, 158373 }, -- Resonating Crystal Scimitar
				{ 16, "ac12504" }, -- AC: The Temple of Sethraliss
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12505" }, -- AC: Heroic: The Temple of Sethraliss
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12506" }, -- AC: Mythic: The Temple of Sethraliss
				{ 17, "ac13004" }, -- AC: Mythic: The Temple of Sethraliss Guild Run
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
	}
}

data["The MOTHERLODE!!"] = {
	EncounterJournalID = 1012,
	MapID = 1010,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Coin-Operated Crowd Pummeler
			EncounterJournalID = 2109,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 155864 }, -- Power-Assisted Vicegrips
				{ 2, 159638 }, -- Electro-Arm Bludgeoner
				{ 3, 159357 }, -- Linked Pummeler Grips
				{ 4, 158353 }, -- Servo-Arm Bindings
				{ 5, 159663 }, -- G0-4W4Y Crowd Repeller
				{ 6, 158350 }, -- Rowdy Reveler's Legwraps
				{ 7, 159462 }, -- Footbomb Championship Ring
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Azerokk
			EncounterJournalID = 2114,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 158357 }, -- Bindings of Enraged Earth
				{ 2, 159679 }, -- Sabatons of Rampaging Elements
				{ 3, 159231 }, -- Mine Rat's Handwarmers
				{ 4, 159612 }, -- Azerokk's Resonating Heart
				{ 5, 158359 }, -- Stonefury Vambraces
				{ 6, 159361 }, -- Shalebiter Interlinked Chain
				{ 7, 159336 }, -- Mercenary Miner's Boots
				{ 8, 159725 }, -- Unscrupulous Geologist's Belt
				{ 9, 159226 }, -- Excavator's Safety Belt
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Rixxa Fluxflame
			EncounterJournalID = 2115,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159287 }, -- Cloak of Questionable Intent
				{ 2, 159240 }, -- Rixxa's Sweat-Wicking Cuffs
				{ 3, 159451 }, -- Leadplate Legguards
				{ 4, 159305 }, -- Corrosive Handler's Gloves
				{ 5, 159639 }, -- P.A.C.I.F.I.S.T. Mk7
				{ 6, 158341 }, -- Chemical Blaster's Legguards
				{ 7, 159235 }, -- Deranged Alchemist's Slippers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Mogul Razdunk
			EncounterJournalID = 2116,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159232 }, -- Exquisitely Aerodynamic Shoulderpads
				{ 2, 158364 }, -- High Altitude Turban
				{ 3, 159641 }, -- G3T-00t
				{ 4, 159298 }, -- Venture Co. Plenipotentiary Vest
				{ 5, 159360 }, -- Crashguard Spaulders
				{ 6, 159415 }, -- Skyscorcher Pauldrons
				{ 7, 158307 }, -- Shrapnel-Dampening Chestguard
				{ 8, 158349 }, -- Petticoat of the Self-Stylized Azerite Baron
				{ 9, 159611 }, -- Razdunk's Big Red Button
				{ 16, "ac12844" }, -- AC: The MOTHERLODE!!
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12845" }, -- AC: Heroic: The MOTHERLODE!!
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12846" }, -- AC: Mythic: The MOTHERLODE!!
				{ 17, "ac12854" }, -- AC: Mythic: The MOTHERLODE!! "Ready for Raiding VI"
				{ 18, "ac13006" }, -- AC: Mythic: The MOTHERLODE!! Guild Run
				{ 20, 161135, "mount" }, -- Schematic: Mecha-Mogul Mk2
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["The Underrot"] = {
	EncounterJournalID = 1022,
	MapID = 1041,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Elder Leaxa
			EncounterJournalID = 2157,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159624 }, -- Rotcrusted Voodoo Doll
				{ 2, 159443 }, -- Legplates of Profane Sacrifice
				{ 3, 159402 }, -- Waistguard of Sanguine Fervor
				{ 4, 159324 }, -- Blood Elder's Bindings
				{ 5, 159463 }, -- Loop of Pulsing Veins
				{ 6, 159652 }, -- Leaxa's Thought-Piercer
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12498" }, -- AC: Mythic: Underrot "Taint Nobody Got Time For That"
			},
		},
		{ -- Cragmaw the Infested
			EncounterJournalID = 2131,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159382 }, -- Blood Tick Crushers
				{ 2, 159433 }, -- Phosphorescent Armplates
				{ 3, 159396 }, -- Waders of the Infested
				{ 4, 159653 }, -- Bile-Stained Crawg Tusks
				{ 5, 159325 }, -- Bloodfeaster Belt
				{ 6, 159344 }, -- Underrot Grotto Tenders
				{ 7, 159436 }, -- Fluorescent Flora Stompers
				{ 8, 159134 }, -- Heart-Piercing Stalactite
				{ 9, 159275 }, -- Wristwraps of Twined Morels
				{ 10, 159269 }, -- Darklight Legwarmers
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Sporecaller Zancha
			EncounterJournalID = 2130,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159665 }, -- Targe of the Ancient Warder
				{ 2, 159270 }, -- Blood Warder's Moccasins
				{ 3, 159338 }, -- Pustule Bearer's Pants
				{ 4, 159626 }, -- Lingering Sporepods
				{ 5, 159410 }, -- Zancha's Venerated Greatbelt
				{ 6, 159292 }, -- Sporecaller's Shroud
				{ 7, 159384 }, -- Corpuscular Greaves
				{ 8, 159654 }, -- Corruption Borne Headlopper
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12549" }, -- AC: Mythic: Underrot "Not a Fun Guy"
			},
		},
		{ -- Unbound Abomination
			EncounterJournalID = 2158,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159446 }, -- Greathelm of the Putrid Path
				{ 2, 159253 }, -- Gloves of Staunched Wounds
				{ 3, 159330 }, -- Gore-Splattered Vest
				{ 4, 159381 }, -- Visage of Bloody Horrors
				{ 5, 159323 }, -- Shoulders of the Sanguine Monstrosity
				{ 6, 159655 }, -- Vile Exsanguinator
				{ 7, 159432 }, -- Breastplate of Arterial Protection
				{ 8, 159241 }, -- Blood-Drenched Robes
				{ 9, 159267 }, -- Pauldrons of Vile Corruption
				{ 10, 159385 }, -- Amalgamated Abomination Spaulders
				{ 11, 159625 }, -- Vial of Animated Blood
				{ 16, "ac12500" }, -- AC: Underrot
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12501" }, -- AC: Heroic: Underrot
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12502" }, -- AC: Mythic: Underrot
				{ 17, "ac12499" }, -- AC: Mythic: Underrot "Sporely Alive"
				{ 18, "ac13003" }, -- AC: Mythic: Underrot Guild Run
				{ 20, 160829, "mount" }, -- Underrot Crawg
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Tol Dagor"] = {
	EncounterJournalID = 1002,
	MapID = 974,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- The Sand Queen
			EncounterJournalID = 2097,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159392 }, -- Gaoler's Chainmail Gaiters
				{ 2, 159332 }, -- Wristguards of the Sandswimmer
				{ 3, 159668 }, -- Rattling Jar of Eyes
				{ 4, 160110 }, -- Warglaive of the Sand Queen
				{ 5, 159460 }, -- Overseer's Lost Seal
				{ 6, 160215 }, -- Sewer Grate Girdle
				{ 7, 159656 }, -- Halberd of the Unwary Guard
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Jes Howlis
			EncounterJournalID = 2098,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159266 }, -- Claw-Slit Brawler's Handwraps
				{ 2, 159666 }, -- Improvised Riot Shield
				{ 3, 159306 }, -- Singe-Blotched Britches
				{ 4, 159627 }, -- Jes' Howler
				{ 5, 159131 }, -- Howlis' Crystal Shiv
				{ 6, 159363 }, -- Gnawed Iron Fetters
				{ 7, 159293 }, -- Turncoat's Cape
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{ -- Knight Captain Valyri
			EncounterJournalID = 2099,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159277 }, -- Wild Pyromancer's Trousers
				{ 2, 159444 }, -- Gunpowder-Scoured Sabatons
				{ 3, 159343 }, -- Spark Dampening Footpads
				{ 4, 159390 }, -- Sure-Grip Munition Handlers
				{ 5, 159274 }, -- Knight Captain's Waistcord
				{ 6, 159441 }, -- Valyri's Fire-Proof Bracers
				{ 7, 159389 }, -- Flint-Linked Wristguards
				{ 8, 159333 }, -- Cincture of the Azerite Arsenal
				{ 9, 159615 }, -- Ignition Mage's Fuse
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12457" }, -- AC: Mythic: Tol Dagor "Remix to Ignition"
			},
		},
		{ -- Overseer Korgus
			EncounterJournalID = 2096,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159129 }, -- Flamecaster Botefeux
				{ 2, 159628 }, -- Kul Tiran Cannonball Runner
				{ 3, 159334 }, -- Flashpowder Hood
				{ 4, 159331 }, -- Pistoleer's Spaulders
				{ 5, 159414 }, -- Overseer's Riot Helmet
				{ 6, 159657 }, -- Korgus' Blackpowder Rifle
				{ 7, 159658 }, -- Cudgel of Correctional Oversight
				{ 8, 159391 }, -- Hood of the Dark Reaper
				{ 9, 159393 }, -- Cannoneer's Mantle
				{ 10, 159440 }, -- Ashvane Warden's Cuirass
				{ 11, 159268 }, -- Inmate's Straight Robe
				{ 16, "ac12840" }, -- AC: Tol Dagor
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12841" }, -- AC: Heroic: Tol Dagor
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12842" }, -- AC: Mythic: Tol Dagor
				{ 17, "ac12462" }, -- AC: Mythic: Tol Dagor "Shot Through the Heart"
				{ 18, "ac13005" }, -- AC: Mythic: Tol Dagor Guild Run
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Waycrest Manor"] = {
	EncounterJournalID = 1021,
	MapID = 1015,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- Heartsbane Triad
			EncounterJournalID = 2125,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159669 }, -- Solena's Watchful Collection
				{ 2, 159133 }, -- Jagged Iris Sica
				{ 3, 159450 }, -- Girdle of Burgeoning Apathy
				{ 4, 159272 }, -- Twisted Sisters Handwraps
				{ 5, 159340 }, -- Bracers of Dreadful Maladies
				{ 6, 159404 }, -- Bramble Looped Boots
				{ 7, 159400 }, -- Nettle-Scarred Greaves
				{ 8, 159449 }, -- Soulwarped Vambraces
				{ 9, 159345 }, -- Blight Toadskin Leggings
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12489" }, -- AC: Mythic: Waycrest Manor "Losing My Profession"
			},
		},
		{ -- Soulbound Goliath
			EncounterJournalID = 2126,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159399 }, -- Thornshaper Mitts
				{ 2, 159659 }, -- Sinister Wicker Talons
				{ 3, 159282 }, -- Drust-Thatched Wristwraps
				{ 4, 159456 }, -- Petrified Wickerplate Greaves
				{ 5, 159341 }, -- Hound-Jowl Waistband
				{ 6, 162548 }, -- Thornwoven Band
				{ 7, 159630 }, -- Balefire Branch
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12495" }, -- AC: Mythic: Waycrest Manor "Run Wild Like a Man On Fire"
				{ 17, "ac12489" }, -- AC: Mythic: Waycrest Manor "Losing My Profession"
			},
		},
		{ -- Raal the Gluttonous
			EncounterJournalID = 2127,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159294 }, -- Raal's Bib
				{ 2, 159660 }, -- Servant Splitter
				{ 3, 159346 }, -- Grubby Servant-Grabbers
				{ 4, 159452 }, -- Fatty Hooves of Gory Comfort
				{ 5, 159397 }, -- Slaughterhouse-Chain Bracers
				{ 6, 159285 }, -- Bloodstained Sous Chef Pants
				{ 7, 159616 }, -- Gore-Crusted Butcher's Block
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12489" }, -- AC: Mythic: Waycrest Manor "Losing My Profession"
			},
		},
		{ -- Lord and Lady Waycrest
			EncounterJournalID = 2128,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159631 }, -- Lady Waycrest's Music Box
				{ 2, 159457 }, -- Risen Lord's Oversized Gauntlets
				{ 3, 159661 }, -- Soulcharmer's Bludgeon
				{ 4, 159403 }, -- Waistguard of Deteriorating Grace
				{ 5, 159262 }, -- Belt of Undying Devotion
				{ 6, 158362 }, -- Lord Waycrest's Signet
				{ 7, 159347 }, -- Moss-Covered Wingtip Shoes
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12489" }, -- AC: Mythic: Waycrest Manor "Losing My Profession"
			},
		},
		{ -- Gorak Tul
			EncounterJournalID = 2129,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 159279 }, -- Soulfuel Headdress
				{ 2, 159448 }, -- Breastplate of the Vengeful
				{ 3, 159662 }, -- Blightreaper
				{ 4, 159398 }, -- Soulscarred Headgear
				{ 5, 159339 }, -- Gorak Tul's Mantle
				{ 6, 159455 }, -- Pauldrons of the Horned Horror
				{ 7, 159273 }, -- Amice of the Returned
				{ 8, 159335 }, -- Raiment of the Blighted Tribe
				{ 9, 159395 }, -- Deathslaver's Hauberk
				{ 16, "ac12483" }, -- AC: Waycrest Manor
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12484" }, -- AC: Heroic: Waycrest Manor
			},
			[MYTHICD_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 16, "ac12488" }, -- AC: Mythic: Waycrest Manor
				{ 17, "ac12490" }, -- AC: Mythic: Waycrest Manor "Alchemical Romance"
				{ 18, "ac12489" }, -- AC: Mythic: Waycrest Manor "Losing My Profession"
			},
		},
		BATTLEFORAZEROTH_DUNGEON_HERO_AC_TABLE,
		BATTLEFORAZEROTH_GLORY_OF_THE_WARTORN_HERO_AC_TABLE,
	}
}

data["Operation: Mechagon"] = {
	EncounterJournalID = 1178,
	MapID = 1490,
	ContentType = DUNGEON_CONTENT,
	items = 
	{
		{ -- King Gobbamak
			EncounterJournalID = 2357,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170507 },
				{ 2, 169054 },
			},
		},
		{ -- Gunker
			EncounterJournalID = 2358,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170508 },
				{ 2, 169056 },
			},
		},
		{ -- Trixie & Naeno
			EncounterJournalID = 2360,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170509 },
				{ 2, 169064 },
				{ 3, 169069 },
				{ 4, 169070 },
			},
		},
		{ -- HK-8 Aerial Oppression Unit
			EncounterJournalID = 2355,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170510 },
				{ 2, 168657 },
				{ 3, 167677 },
				{ 4, 168826 },
				{ 5, 169385 },
				{ 6, 168909 },
				{ 7, 169073 },
				{ 8, 169157 },
				{ 9, 169076 },
				{ 10, 169158 },
				{ 11, 169156 },
			},
		},
		{ -- Tussle Tonks
			EncounterJournalID = 2336,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170510 },
				{ 2, 168955 },
				{ 3, 168957 },
			},
		},
		{ -- K.U.-J.0.
			EncounterJournalID = 2339,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170508 },
				{ 2, 168970 },
				{ 3, 168968 },
			},
		},
		{ -- Machinist's Garden
			EncounterJournalID = 2348,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 170507 },
				{ 2, 167556 },
				{ 3, 168973 },
				{ 4, 168975 },
				{ 5, 169159 },
				{ 6, 169161 },
				{ 7, 168977 },
				{ 8, 169160 },
				{ 9, 169344 },
			},
		},
		{ -- King Mechagon
			EncounterJournalID = 2331,
			[MYTHICD_DUNGEON_DIFF] = {
				{ 1, 168830, "mount" },
				{ 2, 169172 },
				{ 3, 168671 },
				{ 4, 168842 },
				{ 5, 169378 },
				{ 6, 170509 },
				{ 7, 169774 },
				{ 8, 168984 },
				{ 9, 168985 },
				{ 10, 168986 },
			},
		},
	}
}
-- /////////////////////////////////
-- Raid
-- /////////////////////////////////

data["The Eternal Palace"] = {
	EncounterJournalID = 1179,
	MapID = 1512,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = 
	{
		{ -- Abyssal Commander Sivara
			EncounterJournalID = 2352,
			[NORMAL_RAID_DIFF] = {
				{ 1, 168903 },
				{ 2, 168477 },
				{ 3, 168345 },
				{ 4, 168377 },
				{ 5, 168905 },
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
		{ -- Blackwater Behemoth
			EncounterJournalID = 2347,
			[NORMAL_RAID_DIFF] = {
				{ 1, 169360 },
				{ 2, 168397 },
				{ 3, 168343 },
				{ 4, 168376 },
				{ 5, 168379 },
				{ 6, 169304 },
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
		{ -- Radiance of Azshara
			EncounterJournalID = 2353,
			[NORMAL_RAID_DIFF] = {
				{ 1, 169694 },
				{ 2, 168348 },
				{ 3, 168378 },
				{ 4, 168380 },
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
		{ -- Lady Ashvane
			EncounterJournalID = 2354,
			[NORMAL_RAID_DIFF] = {
				{ 1, 169358 },
				{ 2, 168904 },
				{ 3, 168347 },
				{ 4, 168883 },
				{ 5, 168889 },
				{ 6, 169305 },
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
		{ -- Orgozoa
			EncounterJournalID = 2351,
			[NORMAL_RAID_DIFF] = {
				{ 1, 168346 },
				{ 2, 168604 },
				{ 3, 168875 },
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
		{ -- The Queen's Court
			EncounterJournalID = 2359,
			[NORMAL_RAID_DIFF] = {
				{ 1, 169694 },
				{ 2, 168896 },
				{ 3, 168350 },
				{ 4, 168879 },
				{ 5, 168890 },
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
		{ -- Za'qul, Harbinger of Ny'alotha
			EncounterJournalID = 2349,
			[NORMAL_RAID_DIFF] = {
				{ 1, 169362 },
				{ 2, 168349 },
				{ 3, 168391 },
				{ 4, 169306 },
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
		{ -- Queen Azshara
			EncounterJournalID = 2361,
			[NORMAL_RAID_DIFF] = {
				{ 1, 169694 },
				{ 2, 169348 },
				{ 3, 168275 },
				{ 4, 168887 },
				{ 5, 168871 },
				{ 6, 168891 },
				{ 7, 169314 },
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, 168857 },
			},
			[RF_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},		
		},
	}
}

data["Battle of Dazar'alor"] = {
	EncounterJournalID = 1176,
	MapID = 1352,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = 
	{
		{ -- Champion of the Light
			EncounterJournalID = 2335,
			[RF_DIFF] = {
				{ 1, 165551 }, -- Bracers of Zealous Calling
				{ 2, 165514 }, -- Gloves of Spiritual Grace
				{ 3, 165517 }, -- Bracers of Regal Devotion
				{ 4, 165533 }, -- Lightgrace Sabatons
				{ 5, 165549 }, -- Crusade Pummelers
				{ 6, 165834 }, -- Divine Fury Raiment
				{ 7, 165519 }, -- Cowl of Righteous Resolve
				{ 8, 165921 }, -- Pauldrons of Ancestral Vengeance
				{ 9, 165550 }, -- Breastplate of Divine Purification
				{ 10, 165919 }, -- Desecrated Blade of the Disciples
				{ 11, 165586 }, -- Dawnbreaker
				{ 12, 165584 }, -- Sunburst Crest
				{ 13, 165569 }, -- Ward of Envelopment
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Jadefire Masters
			EncounterJournalID = 2323,
			[RF_DIFF] = {
				{ 1, 165503 }, -- Manceroy's Flamefists
				{ 2, 165521 }, -- Cranedancer Leggings
				{ 3, 165531 }, -- Grips of Harmonious Spirits
				{ 4, 165552 }, -- Embersear Waistguard
				{ 5, 165565 }, -- Band of Multi-Sided Strikes
				{ 6, 165500 }, -- Blazewing Hood
				{ 7, 165516 }, -- Mestrah's Singing Spaulders
				{ 8, 165540 }, -- Mistfire Raiment
				{ 9, 165548 }, -- Helm of Tempered Jade
				{ 10, 165587 }, -- Phoenixfire Staff
				{ 11, 165568 }, -- Invocation of Yu'lon
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Grong, the Revenant
			EncounterJournalID = 2340,
			[RF_DIFF] = {
				{ 1, 165499 }, -- Leggings of Dire Research
				{ 2, 165525 }, -- Stretched Sinew Waistcord
				{ 3, 165534 }, -- Ape Wrangler's Wristguards
				{ 4, 165551 }, -- Splinter-Bone Vambraces
				{ 5, 165513 }, -- Silverback Cloak
				{ 6, 165922 }, -- Bristling Fur-Lined Amice
				{ 7, 165515 }, -- Grongpelt Vest
				{ 8, 165535 }, -- Simian Berserker's Helm
				{ 9, 165555 }, -- Spaulders of the Gorilla King
				{ 10, 165920 }, -- Apetagonizer's Claw
				{ 11, 165588 }, -- Bonelash Paw
				{ 12, 165589 }, -- Hornridged Crusher
				{ 13, 165582 }, -- Cursed Monkey Palm
				{ 14, 165574 }, -- Grong's Primal Rage
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Opulence
			EncounterJournalID = 2342,
			[RF_DIFF] = {
				{ 1, 165504 }, -- Waistcord of Flowing Silk
				{ 2, 165524 }, -- Amethyst-Studded Bindings
				{ 3, 165541 }, -- Boots of the Gilded Path
				{ 4, 165538 }, -- Goldenscale Girdle
				{ 5, 165561 }, -- Coinage Stampers
				{ 6, 165818 }, -- Crown of the Seducer
				{ 7, 165526 }, -- Crown of A'akul's Dark Reign
				{ 8, 165820 }, -- Electrified Crown of Rahu'ai
				{ 9, 165821 }, -- Crown of Bloody Succession
				{ 10, 165591 }, -- Bloodtooth, the Soulfeaster
				{ 11, 165592 }, -- Goblet of Glittering Favor
				{ 12, 165593 }, -- Greed's Folly
				{ 13, 165571 }, -- Incandescent Sliver
				{ 14, 165573 }, -- Diamond-Laced Refracting Prism
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Conclave of the Chosen
			EncounterJournalID = 2330,
			[RF_DIFF] = {
				{ 1, 165502 }, -- Lightfeather Footpads
				{ 2, 165560 }, -- Arcing Thunderlizard Legplates
				{ 3, 165512 }, -- Loa Exultant's Shroud
				{ 4, 165507 }, -- Mantle of the Skyterror
				{ 5, 165833 }, -- Vestments of Indomitable Will
				{ 6, 165532 }, -- Gonk's Scale Robes
				{ 7, 165562 }, -- Ridgeplate Pauldrons
				{ 8, 165595 }, -- Blade of Encroaching Death
				{ 9, 165599 }, -- Pterrorwing Longbow
				{ 10, 165594 }, -- Akunda's Shocksplitter
				{ 11, 166418}, -- Crest of Pa'ku Alliance
				{ 12, 165581 }, -- Crest of Pa'ku Horde
				{ 13, 165579 }, -- Arcing Thunderlizard Legplates
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
				{ 14, 165846 }, -- Enchanted Talon of Pa'ku
				{ 15, 165847 }, -- Thundering Scale of Akunda
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 16, 165848 }, -- Spawn of Krag'wa
			},
		},
		{ -- King Rastakhan
			EncounterJournalID = 2335,
			[RF_DIFF] = {
				{ 1, 165536 }, -- Deathhunter's Legguards
				{ 2, 165558 }, -- Roka's Bonecrushing Manacles
				{ 3, 165567 }, -- Seal of the Zandalari Empire
				{ 4, 165498 }, -- Vestments of the Afterlife
				{ 5, 165523 }, -- Phantom Stalker Shoulders
				{ 6, 165537 }, -- Mantle of the Soulbinder's Caress
				{ 7, 165832 }, -- Breastplate of the Deathbound
				{ 8, 165596 }, -- Last Fang of Rezan
				{ 9, 165597 }, -- Deathspeaker Spire
				{ 10, 165577 }, -- Bwonsamdi's Bargain
				{ 11, 165578}, -- Mirror of Entwined Fate
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- High Tinker Mekkatorque
			EncounterJournalID = 2334,
			[RF_DIFF] = {
				{ 1, 165508 }, -- Lever Stabilizing Wristwraps
				{ 2, 165522 }, -- Mech-Jockey Grips
				{ 3, 165924 }, -- High Tinker's Cape
				{ 4, 165497 }, -- Giga-Charged Shoulderpads
				{ 5, 165830 }, -- Mekkatorque's Bomber Jacket
				{ 6, 165543 }, -- Target-Tracking Headgear
				{ 7, 165825 }, -- Dyno-Sprocket Spaulders
				{ 8, 165598 }, -- Servo-Claw Smasher
				{ 9, 165600 }, -- Twin-Pipe Buster Cannon
				{ 10, 165580 }, -- Ramping Amplitude Gigavolt Engine
				{ 11, 165572 }, -- Variable Intensity Gigavolt Oscillating Reactor
				{ 12, 166518 }, -- G.M.O.D.
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Stormwall Blockade
			EncounterJournalID = 2337,
			[RF_DIFF] = {
				{ 1, 165506 }, -- Wavecaller Leggings
				{ 2, 165528 }, -- Kelp-Laced Greaves
				{ 3, 165546 }, -- Slimy Kelpweavers
				{ 4, 165556 }, -- Stormwrought Gauntlets
				{ 5, 165822 }, -- Cowl of Tideborne Omens
				{ 6, 165819 }, -- Tidemother's Cover
				{ 7, 165923 }, -- Tidal Shroud Spaulders
				{ 8, 165557 }, -- Sea Swell Chestplate
				{ 9, 165601}, -- Storm-Toothed Kasuyu
				{ 10, 165603 }, -- Siren's Song
				{ 11, 165585 }, -- Blockade Bulward
				{ 12, 165602 }, -- Crash of Tides
				{ 13, 165590 }, -- Docksplitter Siege Hook
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Lady Jaina Proudmoore
			EncounterJournalID = 2343,
			[RF_DIFF] = {
				{ 1, 165527 }, -- Embossed Deckwalkers
				{ 2, 165542 }, -- Icebinder's Bracers
				{ 3, 165559 }, -- Hullplate Girdle
				{ 4, 165566 }, -- Lord Admiral's Signet
				{ 5, 165505 }, -- Robes of Biting Cold
				{ 6, 165824 }, -- Admiralty's Ceremonial Epaulets
				{ 7, 165831 }, -- Flag Officer's Overcoat
				{ 8, 165823 }, -- Glaciercrest Helm
				{ 9, 165604 }, -- Daelin Proudmoore's Saber
				{ 10, 165583 }, -- Fogbreaker, Light of the Sea
				{ 11, 165570 }, -- Everchill Anchor
				{ 12, 165576 }, -- Tidestorm Codex
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 13, 166705 }, -- Glacial Tidestorm
			},
		},
	}
}

data["Crucible of Storms"] = {
	EncounterJournalID = 1177,
	MapID = 2096,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = 
	{
		{ -- The Restless Cabal
			EncounterJournalID = 2328,
			[RF_DIFF] = {
				{ 1, 167833 }, -- Fathom Dredgers
				{ 2, 167840 }, -- Mindthief's Eldritch Clasp
				{ 3, 167842 }, -- Fa'thuul's Floodguards
				{ 4, 167219 }, -- Gloves of the Undying Pact
				{ 5, 167837 }, -- Insurgent's Scouring Chain
				{ 6, 167863 }, -- Pillar of the Drowned Cabal
				{ 7, 167218 }, -- Zaxasj's Deepstriders
				{ 8, 167841 }, -- Abyssal Speaker's Gauntlets
				{ 9, 167838 }, -- Leggings of the Aberrant Tidesage
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
		{ -- Uu'nat, Harbinger of the Void
			EncounterJournalID = 2332,
			[RF_DIFF] = {
				{ 1, 167217 }, -- Legplates of Unbound Anguish
				{ 2, 167864 }, -- Trident of Deep Ocean
				{ 3, 167866 }, -- Lurker's Insidious Gift
				{ 4, 167835 }, -- Malformed Herald's Legwraps
				{ 5, 167868 }, -- Idol of Indiscriminate Consumption
				{ 6, 167865 }, -- Void Stone
				{ 7, 167867 }, -- Harbinger's Inscrutable Will
				{ 8, 167839 }, -- Grips of Forsaken Sanity
				{ 9, 167834 }, -- Stormglide Steps
			},
			[NORMAL_RAID_DIFF] = {
				GetItemsFromDiff = RF_DIFF,
			},
			[HEROIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
			},
		},
	}
}
data["Uldir"] = {
	EncounterJournalID = 1031,
	MapID = 1861,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = 
	{
		{ -- Taloc
			EncounterJournalID = 2168,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160629 }, -- Rubywrought Sparkguards
				{ 2, 160631 }, -- Legguards of Coalescing Plasma
				{ 3, 160618 }, -- Gloves of Descending Madness
				{ 4, 160680 }, -- Titanspark Animator
				{ 5, 160637 }, -- Crimson Colossus Armguards
				{ 6, 160639 }, -- Greaves of Unending Vigil
				{ 7, 160679 }, -- Khor, Hammer of the Corrupted
				{ 8, 160651 }, -- Vigilant's Bloodshaper
				{ 9, 160652 }, -- Construct Overcharger
				{ 10, 160714 }, -- Volatile Walkers
				{ 11, 160622 }, -- Bloodstorm Buckle
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
		{ -- MOTHER
			EncounterJournalID = 2167,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160695 }, -- Uldir Subject Manifest
				{ 2, 160682 }, -- Mother's Twin Gaze
				{ 3, 160626 }, -- Gloves of Involuntary Amputation
				{ 4, 160645 }, -- Rot-Scour Ring
				{ 5, 160615 }, -- Leggings of Lingering Infestation
				{ 6, 160632 }, -- Flame-Sterilized Spaulders
				{ 7, 160634 }, -- Gridrunner Galea
				{ 8, 160681 }, -- Glaive of the Keepers
				{ 9, 160638 }, -- Decontaminator's Greatbelt
				{ 10, 160625 }, -- Pathogenic Legwraps
				{ 11, 160683 }, -- Latticework Scalpel
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
		{ -- Fetid Devourer
			EncounterJournalID = 2146,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160689 }, -- Regurgitated Purifier's Flamestaff
				{ 2, 160685 }, -- Biomelding Cleaver
				{ 3, 160619 }, -- Jerkin of the Aberrant Chimera
				{ 4, 160648 }, -- Frenetic Corpuscle
				{ 5, 160635 }, -- Waste Disposal Crushers
				{ 6, 160643 }, -- Fetid Horror's Tanglecloak
				{ 7, 160616 }, -- Horrific Amalgam's Hood
				{ 8, 160628 }, -- Fused Monstrosity Stompers
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
		{ -- Zek'voz, Herald of N'zoth
			EncounterJournalID = 2169,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160627 }, -- Chainvest of Assured Quality
				{ 2, 160633 }, -- Titanspark Energy Girdle
				{ 3, 160650 }, -- Disc of Systematic Regression
				{ 4, 160624 }, -- Quarantine Protocol Treads
				{ 5, 160718 }, -- Greaves of Creeping Darkness
				{ 6, 160617 }, -- Void-Lashed Wristband
				{ 7, 160647 }, -- Ring of the Infinite Void
				{ 8, 160717 }, -- Replicated Chitin Cord
				{ 9, 160687 }, -- Containment Analysis Baton
				{ 10, 160688 }, -- Void-Binder
				{ 11, 160640 }, -- Warboots of Absolute Eradication
				{ 12, 160613 }, -- Mantle of Contained Corruption
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
		{ -- Vectis
			EncounterJournalID = 2166,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160644 }, -- Plasma-Spattered Greatcloak
				{ 2, 160678 }, -- Bow of Virulent Infection
				{ 3, 160716 }, -- Blighted Anima Greaves
				{ 4, 160734 }, -- Cord of Animated Contagion
				{ 5, 160655 }, -- Syringe of Bloodborne Infirmity
				{ 6, 160623 }, -- Hood of Pestilent Ichor
				{ 7, 160649 }, -- Inoculating Extract
				{ 8, 160636 }, -- Chestguard of Virulent Mutagens
				{ 9, 160698 }, -- Vector Deflector
				{ 10, 160715 }, -- Mutagenic Protofluid Handwraps
				{ 11, 160621 }, -- Wristwraps of Coursing Miasma
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
		{ -- Zul, Reborn
			EncounterJournalID = 2195,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160642 }, -- Cloak of Rippling Whispers
				{ 2, 160719 }, -- Visage of the Ascended Prophet
				{ 3, 160691 }, -- Tusk of the Reborn Prophet
				{ 4, 160723 }, -- Imperious Vambraces
				{ 5, 160620 }, -- Usurper's Bloodcaked Spaulders
				{ 6, 160684 }, -- Pursax, the Backborer
				{ 7, 160630 }, -- Crest of the Undying Visionary
				{ 8, 160722 }, -- Chestplate of Apocalyptic Machinations
				{ 9, 160724 }, -- Cincture of Profane Deeds
				{ 10, 160720 }, -- Armbands of Sacrosanct Acts
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
		{ -- Mythrax the Unraveler
			EncounterJournalID = 2194,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160614 }, -- Robes of the Unraveler
				{ 2, 160721 }, -- Oblivion Crushers
				{ 3, 160725 }, -- C'thraxxi General's Hauberk
				{ 4, 160686 }, -- Voror, Gleaming Blade of the Stalwart
				{ 5, 160646 }, -- Band of Certain Annihilation
				{ 6, 160692 }, -- Luminous Edge of Virtue
				{ 7, 160656 }, -- Twitching Tentacle of Xalzaix
				{ 8, 160696 }, -- Codex of Imminent Ruin
				{ 9, 160653 }, -- Xalzaix's Veiled Eye
				{ 10, 163596 }, -- Cowl of Dark Portents
				{ 11, 160641 }, -- Chitinspine Pauldrons
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
		{ -- G'huun
			EncounterJournalID = 2147,
			[NORMAL_RAID_DIFF] = {
				{ 1, 160732 }, -- Helm of the Defiled Laboratorium
				{ 2, 160693 }, -- Lancet of the Deft Hand
				{ 3, 160727 }, -- Cord of Septic Envelopment
				{ 4, 160699 }, -- Barricade of Purifying Resolve
				{ 5, 160731 }, -- Spaulders of Coagulated Viscera
				{ 6, 160733 }, -- Hematocyst Stompers
				{ 7, 160690 }, -- Heptavium, Staff of Torturous Knowledge
				{ 8, 160694 }, -- Re-Origination Pulse Rifle
				{ 9, 160726 }, -- Amice of Corrupting Horror
				{ 10, 160728 }, -- Tunic of the Sanguine Deity
				{ 11, 160654 }, -- Vanquished Tendril of G'huun
				{ 12, 160729 }, -- Striders of the Putrescent Path
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

data["Azeroth"] = {
	EncounterJournalID = 1028,
	--MapID = 0,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = 
	{
		{ -- T'zane
			EncounterJournalID = 2139,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161392 }, -- Bindings of Eternal Fears
				{ 2, 161396 }, -- Petrified Mask of the Afterlife
				{ 3, 164383 }, -- Death Devouring Girdle
				{ 4, 161387 }, -- Wailing Terror Leggings
				{ 5, 161389 }, -- Cinch of All-Consuming Death
				{ 6, 161391 }, -- Deathshambler's Shoulderpads
				{ 7, 161393 }, -- Legguards of the Barkbound Dead
				{ 8, 161395 }, -- Swampwalker's Soul-Treads
				{ 9, 161397 }, -- Soulplank Vambraces
				{ 10, 161411 }, -- T'zane's Barkspines
				{ 11, 161412 }, -- Spiritbound Voodoo Burl
			},
		},
		{ -- Ji'arak
			EncounterJournalID = 2141,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161407 }, -- Windshear Leggings
				{ 2, 161409 }, -- Stormcrash Chestguard
				{ 3, 161388 }, -- Gloves of Enveloping Winds
				{ 4, 161394 }, -- Hurricane Cinch
				{ 5, 164384 }, -- Windswept Dinorider's Cape
				{ 6, 161401 }, -- Matriarch's Shadowveil
				{ 7, 161403 }, -- Avian Clutch Belt
				{ 8, 161390 }, -- Savage Terrorwing Leggings
				{ 9, 161371 }, -- Galebreaker's Sabatons
			},
		},
		{ -- Hailstone Construct
			EncounterJournalID = 2197,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161362 }, -- Frostbreath Leggings
				{ 2, 161364 }, -- Chill's End Wristguards
				{ 3, 161366 }, -- Ice Stalker Boots
				{ 4, 161368 }, -- Freezing Tempest Waistguard
				{ 5, 161370 }, -- Glacial Spike Gauntlets
				{ 6, 161372 }, -- Ice-Carved Shoulderplates
				{ 7, 161361 }, -- Ice-Rimed Slippers
				{ 8, 161380 }, -- Drust-Runed Icicle
				{ 9, 161367 }, -- Hailstone Hauberk
				{ 10, 164386 }, -- Girdle of Biting Winds
				{ 11, 161381 }, -- Permafrost-Encrusted Heart
			},
		},
		{ -- Azurethos, The Winged Typhoon
			EncounterJournalID = 2199,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161377 }, -- Azurethos' Singed Plumage
				{ 2, 161379 }, -- Galecaller's Beak
				{ 3, 161398 }, -- Talonscored Azure Vambraces
				{ 4, 161363 }, -- Sandals of Rustling Rage
				{ 5, 161365 }, -- Footpads of the Encircling Storm
				{ 6, 161352 }, -- Chestguard of Dire Winds
				{ 7, 161369 }, -- Bindings of the Winged Typhoon
				{ 8, 161356 }, -- Feathered Galeforce Crest
				{ 9, 161378 }, -- Plume of the Seaborne Avian
				{ 10, 161360 }, -- Roost-Defender's Legguards
				{ 11, 161350 }, -- Windcaller's Down Handwraps
			},
		},
		{ -- Doom's Howl
			EncounterJournalID = 2213,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161467 }, -- Vest of the Veiled Gryphon
				{ 2, 161469 }, -- Sharpshooter's Chainmail Hauberk
				{ 3, 161471 }, -- Lion's Roar Pauldrons
				{ 4, 161473 }, -- Lion's Guile
				{ 5, 161464 }, -- Alliance Bowman's Coif
				{ 6, 161466 }, -- Battlemage's Collar
				{ 7, 161468 }, -- Gilded-Wing Shoulderguards
				{ 8, 161470 }, -- Polished Shieldbearer's Breastplate
				{ 9, 161472 }, -- Lion's Grace
				{ 10, 161474 }, -- Lion's Strength
				{ 11, 161465 }, -- Warcaster's Arcane Mantle
			},
		},
		{ -- Warbringer Yenajz
			EncounterJournalID = 2198,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161349 }, -- Amice of the Rending Abyss
				{ 2, 161351 }, -- Wristwraps of Warped Reality
				{ 3, 161353 }, -- Shadow-Wreathed Gloves
				{ 4, 161355 }, -- Yenajz's Chitinous Stompers
				{ 5, 161357 }, -- Spaulders of the Enveloping Maw
				{ 6, 161359 }, -- Band of Intense Gravitation
				{ 7, 161376 }, -- Prism of Dark Intensity
				{ 8, 161354 }, -- Leggings of the Endless Void
				{ 9, 161358 }, -- Existence-Shattering Gauntlets
			},
		},
		{ -- Dunegorger Kraulok
			EncounterJournalID = 2210,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161400 }, -- Raider's Shrouding Thobe
				{ 2, 161402 }, -- Gloves of the Desert Assassin
				{ 3, 161419 }, -- Kraulok's Claw
				{ 4, 161406 }, -- Shrouded Sandscale Bracers
				{ 5, 161408 }, -- Sandswept Legionnaire's Legplates
				{ 6, 161399 }, -- Cord of Flowing Sands
				{ 7, 161404 }, -- Hood of the Sinuous Devilsaur
				{ 8, 161405 }, -- Dunegorger's Grips
				{ 9, 164385 }, -- Desert Nomad's Wrap
			},
		},
		{ -- Ivus the Decayed
			EncounterJournalID = 2345,
			[NORMAL_RAID_DIFF] = {
				{ 1, 161417 }, -- Ancient Knot of Wisdom
				{ 2, 161415 }, -- Forest Lord's Razorleaf
				{ 3, 166691 }, -- Forest Protector's Shoulderguards
				{ 4, 166683 }, -- Garments of the Forest Lord
				{ 5, 166694 }, -- Gnarled Bough Gauntlets
				{ 6, 166686 }, -- Ivus's Tanglemoss Waistcord
				{ 7, 161413 }, -- Knot of Ancient Fury
				{ 8, 166695 }, -- Petrified Ironbark Crown
				{ 9, 166690 }, -- Protector's Tangleroot Belt
				{ 10, 166698 }, -- Stoneroot Stompers
				{ 11, 166687 }, -- Warring Ancient's Mask
			},
		},
	}
}
