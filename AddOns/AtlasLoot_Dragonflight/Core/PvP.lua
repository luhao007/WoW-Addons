-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select, type = select, type
local string = _G.string
local format = string.format

-- WoW
local UnitFactionGroup = UnitFactionGroup
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...
local AtlasLoot = _G.AtlasLoot
local data = private.data

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales


-- change sortorder for factions
local ALLIANCE_DIFF, HORDE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

local PVP_CONTENT = data:AddContentType(AL["PvP"], ATLASLOOT_PVP_COLOR)

--[[ template
data["LEGION7SET"] = {
	name = format(EXPANSION_NAME6.." "..AL["Season %d"], 7).." "..AL["Class Sets"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{ -- DEATHKNIGHT
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DEMONHUNTER
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DRUID
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- HUNTER
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- MAGE
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- MONK
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- PALADIN
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- PRIEST
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- ROGUE
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- SHAMAN
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- WARLOCK
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- WARRIOR
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
	},
}

data["LEGION7GEAR"] = {
	name = format(EXPANSION_NAME6.." "..AL["Season %d"], 7).." "..AL["Non-Set Gear"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{
			name = format(AL["Legion Season %d Elite"], 7),
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{
			name = format(AL["Legion Season %d"], 7),
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
	},
}
--]]

-- https://www.wowhead.com/items?filter=197;13999;0
data["DFSEASON1"] = {
	name = format(AL["Season %d"], 1),
	ContentType = PVP_CONTENT,
	items = { 
		{ -- Non-Set Gear
			name = AL["Non-Set Gear"],
			[ALLIANCE_DIFF] = {
				{ 1, 201449 }, -- Crimson Aspirant's Badge of Ferocity
				{ 2, 201452 }, -- Crimson Aspirant's Emblem
				{ 3, 201450 }, -- Crimson Aspirant's Medallion
				{ 4, 201451 }, -- Crimson Aspirant's Insignia of Alacrity
				{ 5, 201453 }, -- Crimson Aspirant's Sigil of Adaptation

				{ 16, 201807 }, -- Crimson Gladiator's Badge of Ferocity
				{ 17, 201809 }, -- Crimson Gladiator's Emblem
				{ 18, 201810 }, -- Crimson Gladiator's Medallion
				{ 19, 201808 }, -- Crimson Gladiator's Insignia of Alacrity
				{ 20, 201811 }, -- Crimson Gladiator's Sigil of Adaptation

				{ 22, 202086, "mount" }, -- Crimson Gladiator's Drake
				{ 23, 201789, "mount" }, -- Vicious Sabertooth
				{ 24, 201250 }, -- Victorious Contender's Strongbox
				{ 25, 201836 }, -- Aspects' Token of Merit
				{ 26, 201792 }, -- Highland Drake: Embodiment of the Crimson Gladiator
				{ 27, 202047 }, -- Gleaming Incarnate Thunderstone
				
				{ 101, 199090 }, -- Drakebreaker's Impaler
				{ 102, 199078 }, -- Drakebreaker's Shiv
				{ 103, 199091 }, -- Drakebreaker's Javelin
				{ 104, 198959 }, -- Drakebreaker's Wrap
				{ 105, 199079 }, -- Drakebreaker's Horn
				{ 106, 199093 }, -- Drakebreaker's Rod
				{ 107, 198960 }, -- Drakebreaker's Cape
				{ 108, 199081 }, -- Drakebreaker's Staff
				{ 109, 199094 }, -- Drakebreaker's Mallet
				{ 110, 198961 }, -- Drakebreaker's Cloak
				{ 111, 199082 }, -- Drakebreaker's Pole
				{ 112, 199095 }, -- Drakebreaker's Crusher
				{ 113, 198962 }, -- Drakebreaker's Shroud
				{ 114, 199084 }, -- Drakebreaker's Broadsword
				{ 115, 199096 }, -- Drakebreaker's Mace
				{ 116, 199070 }, -- Drakebreaker's Cleaver
				{ 117, 199085 }, -- Drakebreaker's Greatsword
				{ 118, 199071 }, -- Drakebreaker's Hatchet
				{ 119, 199086 }, -- Drakebreaker's Scepter
				{ 120, 199072 }, -- Drakebreaker's Hacker
				{ 121, 199087 }, -- Drakebreaker's Maul
				{ 122, 199075 }, -- Drakebreaker's Heartseeker
				{ 123, 199088 }, -- Drakebreaker's Cudgel
				{ 124, 199076 }, -- Drakebreaker's Glaive
				{ 125, 199089 }, -- Drakebreaker's Bulwark
				{ 126, 199077 }, -- Drakebreaker's Dagger

				{ 201, 201745 }, -- Crimson Aspirant's Band
				{ 202, 201760 }, -- Crimson Aspirant's Battleaxe
				{ 203, 201965 }, -- Crimson Aspirant's Blade
				{ 204, 201752 }, -- Crimson Aspirant's Cape
				{ 205, 201748 }, -- Crimson Aspirant's Choker
				{ 206, 201750 }, -- Crimson Aspirant's Cloak
				{ 207, 201761 }, -- Crimson Aspirant's Dagger
				{ 208, 201751 }, -- Crimson Aspirant's Drape
				{ 209, 201768 }, -- Crimson Aspirant's Gavel
				{ 210, 201753 }, -- Crimson Aspirant's Greatcloak
				{ 211, 201765 }, -- Crimson Aspirant's Greatsword
				{ 212, 201773 }, -- Crimson Aspirant's Hammer
				{ 213, 201774 }, -- Crimson Aspirant's Knife
				{ 214, 201772 }, -- Crimson Aspirant's Longspear
				{ 215, 201762 }, -- Crimson Aspirant's Mace
				{ 216, 201747 }, -- Crimson Aspirant's Necklace
				{ 217, 201749 }, -- Crimson Aspirant's Pendant
				{ 218, 201763 }, -- Crimson Aspirant's Polearm
				{ 219, 201964 }, -- Crimson Aspirant's Pulverizer
				{ 220, 201771 }, -- Crimson Aspirant's Recurve
				{ 221, 201744 }, -- Crimson Aspirant's Ring
				{ 222, 201770 }, -- Crimson Aspirant's Ripper
				{ 223, 201769 }, -- Crimson Aspirant's Shield
				{ 224, 201746 }, -- Crimson Aspirant's Signet
				{ 225, 201764 }, -- Crimson Aspirant's Staff
				{ 226, 201963 }, -- Crimson Aspirant's Sword
				{ 227, 201766 }, -- Crimson Aspirant's Torch
				{ 228, 201767 }, -- Crimson Aspirant's Warglaive

				
				{ 301, 201801 }, -- Crimson Gladiator's Ring
				{ 302, 201802 }, -- Crimson Gladiator's Band
				{ 303, 201803 }, -- Crimson Gladiator's Signet
				{ 304, 201804 }, -- Crimson Gladiator's Necklace
				{ 305, 201805 }, -- Crimson Gladiator's Pendant
				{ 306, 201806 }, -- Crimson Gladiator's Amulet
				{ 307, 201972 }, -- Crimson Gladiator's Splitter
				{ 308, 201973 }, -- Crimson Gladiator's Dagger
				{ 309, 201974 }, -- Crimson Gladiator's Warglaive
				{ 310, 201975 }, -- Crimson Gladiator's Spear
				{ 311, 201976 }, -- Crimson Gladiator's Staff
				{ 312, 201977 }, -- Crimson Gladiator's Hand Cannon
				{ 313, 201978 }, -- Crimson Gladiator's Greatsword
				{ 314, 201979 }, -- Crimson Gladiator's Gavel
				{ 315, 201980 }, -- Crimson Gladiator's Horn
				{ 316, 201981 }, -- Crimson Gladiator's Shield
				{ 317, 201982 }, -- Crimson Gladiator's Wand
				{ 318, 201983 }, -- Crimson Gladiator's Axe
				{ 319, 201984 }, -- Crimson Gladiator's Knife
				{ 320, 201985 }, -- Crimson Gladiator's Mace
				{ 321, 201987 }, -- Crimson Gladiator's Polearm
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 23, 201788, "mount" }, -- Vicious Sabertooth
			},
		},
		{ -- Mail
			name = AL["Mail"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201119 }, -- Crimson Aspirant's Chain Belt
				{ 2 , 201156 }, -- Crimson Aspirant's Chain Bracer
				{ 3 , 201152 }, -- Crimson Aspirant's Chain Clasp
				{ 4 , 201105 }, -- Crimson Aspirant's Chain Gauntlets
				{ 5 , 201138 }, -- Crimson Aspirant's Chain Handguards
				{ 6 , 201140 }, -- Crimson Aspirant's Chain Headguard
				{ 7 , 201107 }, -- Crimson Aspirant's Chain Helm
				{ 8 , 201111 }, -- Crimson Aspirant's Chain Leggings
				{ 9 , 201100 }, -- Crimson Aspirant's Chain Sabatons
				{ 10, 201149 }, -- Crimson Aspirant's Chain Shoulderguards
				{ 11, 201116 }, -- Crimson Aspirant's Chain Spaulders
				{ 12, 201132 }, -- Crimson Aspirant's Chain Stompers
				{ 13, 201128 }, -- Crimson Aspirant's Chain Tunic
				{ 14, 201096 }, -- Crimson Aspirant's Chain Vest
				{ 15, 201144 }, -- Crimson Aspirant's Chain Wargreaves
				{ 16, 201123 }, -- Crimson Aspirant's Chain Wristwraps

				{ 101, 198596 }, -- Drakebreaker's Bracers
				{ 102, 198595 }, -- Drakebreaker's Cinch
				{ 103, 198594 }, -- Drakebreaker's Shoulderguards
				{ 104, 198593 }, -- Drakebreaker's Greaves
				{ 105, 198592 }, -- Drakebreaker's Coif
				{ 106, 198591 }, -- Drakebreaker's Grips
				{ 107, 198590 }, -- Drakebreaker's Striders
				{ 108, 198589 }, -- Drakebreaker's Chestguard

				{ 116, 193461 }, -- Infurious Boots of Reprieve
				{ 117, 193462 }, -- Infurious Chainhelm Protector
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- Leather
			name = AL["Leather"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201157 }, -- Crimson Aspirant's Leather Armguards
				{ 2 , 201120 }, -- Crimson Aspirant's Leather Belt
				{ 3 , 201101 }, -- Crimson Aspirant's Leather Boots
				{ 4 , 201112 }, -- Crimson Aspirant's Leather Breeches
				{ 5 , 201153 }, -- Crimson Aspirant's Leather Cord
				{ 6 , 201133 }, -- Crimson Aspirant's Leather Footpads
				{ 7 , 201102 }, -- Crimson Aspirant's Leather Gloves
				{ 8 , 201135 }, -- Crimson Aspirant's Leather Grips
				{ 9 , 201108 }, -- Crimson Aspirant's Leather Helm
				{ 10, 201145 }, -- Crimson Aspirant's Leather Leggings
				{ 11, 201146 }, -- Crimson Aspirant's Leather Mantle
				{ 12, 201141 }, -- Crimson Aspirant's Leather Mask
				{ 13, 201113 }, -- Crimson Aspirant's Leather Spaulders
				{ 14, 201129 }, -- Crimson Aspirant's Leather Tunic
				{ 15, 201097 }, -- Crimson Aspirant's Leather Vest
				{ 16, 201124 }, -- Crimson Aspirant's Leather Wristwraps

				{ 101, 198574 }, -- Drakebreaker's Handguards
				{ 102, 198580 }, -- Drakebreaker's Epaulets
				{ 103, 198579 }, -- Drakebreaker's Vest
				{ 104, 198578 }, -- Drakebreaker's Bindings
				{ 105, 198577 }, -- Drakebreaker's Sash
				{ 106, 198576 }, -- Drakebreaker's Breeches
				{ 107, 198575 }, -- Drakebreaker's Cowl
				{ 108, 198573 }, -- Drakebreaker's Waders

				{ 116, 193455 }, -- Infurious Footwraps of Indemnity
				{ 117, 193456 }, -- Infurious Spirit's Hood
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- Plate
			name = AL["Plate"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201155 }, -- Crimson Aspirant's Plate Armguards
				{ 2 , 201127 }, -- Crimson Aspirant's Plate Armor
				{ 3 , 201095 }, -- Crimson Aspirant's Plate Chestplate
				{ 4 , 201122 }, -- Crimson Aspirant's Plate Cuffs
				{ 5 , 201103 }, -- Crimson Aspirant's Plate Gauntlets
				{ 6 , 201117 }, -- Crimson Aspirant's Plate Girdle
				{ 7 , 201150 }, -- Crimson Aspirant's Plate Greatbelt
				{ 8 , 201136 }, -- Crimson Aspirant's Plate Handguards
				{ 9 , 201125 }, -- Crimson Aspirant's Plate Headguard
				{ 10, 201093 }, -- Crimson Aspirant's Plate Helm
				{ 11, 201109 }, -- Crimson Aspirant's Plate Legguards
				{ 12, 201147 }, -- Crimson Aspirant's Plate Pauldrons
				{ 13, 201114 }, -- Crimson Aspirant's Plate Shoulders
				{ 14, 201130 }, -- Crimson Aspirant's Plate Stompers
				{ 15, 201098 }, -- Crimson Aspirant's Plate Warboots
				{ 16, 201142 }, -- Crimson Aspirant's Plate Wargreaves

				{ 101, 198585 }, -- Drakebreaker's Legguards
				{ 102, 198587 }, -- Drakebreaker's Girdle
				{ 103, 198586 }, -- Drakebreaker's Mantle
				{ 104, 198588 }, -- Drakebreaker's Armplates
				{ 105, 198584 }, -- Drakebreaker's Gauntlets
				{ 106, 198583 }, -- Drakebreaker's Sabatons
				{ 107, 198582 }, -- Drakebreaker's Breastplate
				{ 108, 198581 }, -- Drakebreaker's Helm

				{ 116, 191985 }, -- Infurious Warboots of Impunity
				{ 117, 190522 }, -- Infurious Helm of Vengeance
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- Cloth
			name = AL["Cloth"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201151 }, -- Crimson Aspirant's Silk Belt
				{ 2 , 201154 }, -- Crimson Aspirant's Silk Bindings
				{ 3 , 201118 }, -- Crimson Aspirant's Silk Cord
				{ 4 , 201139 }, -- Crimson Aspirant's Silk Cover
				{ 5 , 201131 }, -- Crimson Aspirant's Silk Footwraps
				{ 6 , 201104 }, -- Crimson Aspirant's Silk Gloves
				{ 7 , 201137 }, -- Crimson Aspirant's Silk Handwraps
				{ 8 , 201106 }, -- Crimson Aspirant's Silk Hood
				{ 9 , 201110 }, -- Crimson Aspirant's Silk Leggings
				{ 10, 201143 }, -- Crimson Aspirant's Silk Legwraps
				{ 11, 201115 }, -- Crimson Aspirant's Silk Mantle
				{ 12, 201148 }, -- Crimson Aspirant's Silk Shawl
				{ 13, 201099 }, -- Crimson Aspirant's Silk Treads
				{ 14, 201094 }, -- Crimson Aspirant's Silk Tunic
				{ 15, 201126 }, -- Crimson Aspirant's Silk Vest
				{ 16, 201121 }, -- Crimson Aspirant's Silk Wristwraps

				{ 101, 198565 }, -- Drakebreaker's Vestment
				{ 102, 198572 }, -- Drakebreaker's Shoulderpads
				{ 103, 198571 }, -- Drakebreaker's Cuffs
				{ 104, 198570 }, -- Drakebreaker's Cord
				{ 105, 198569 }, -- Drakebreaker's Leggings
				{ 106, 198568 }, -- Drakebreaker's Hood
				{ 107, 198567 }, -- Drakebreaker's Gloves
				{ 108, 198566 }, -- Drakebreaker's Boots

				{ 116, 193524 }, -- Infurious Legwraps of Possibility
				{ 117, 193513 }, -- Infurious Binding of Gesticulation
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- EVOKER
			name = ATLASLOOT_EVOKER_COLOR..ALIL["EVOKER"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201504 }, -- Crimson Gladiator's Chain Vest
				{ 2 , 201505 }, -- Crimson Gladiator's Chain Tunic
				{ 3 , 201506 }, -- Crimson Gladiator's Chain Sabatons
				{ 4 , 201507 }, -- Crimson Gladiator's Chain Boots
				{ 5 , 201508 }, -- Crimson Gladiator's Chain Gauntlets
				{ 6 , 201509 }, -- Crimson Gladiator's Chain Handguards
				{ 7 , 201510 }, -- Crimson Gladiator's Chain Helm
				{ 8 , 201511 }, -- Crimson Gladiator's Chain Faceguard
				{ 9 , 201512 }, -- Crimson Gladiator's Chain Leggings
				{ 10, 201513 }, -- Crimson Gladiator's Chain Breeches
				{ 11, 201514 }, -- Crimson Gladiator's Chain Monnion
				{ 12, 201515 }, -- Crimson Gladiator's Chain Shoulderguard
				{ 13, 201516 }, -- Crimson Gladiator's Chain Belt
				{ 14, 201517 }, -- Crimson Gladiator's Chain Girdle
				{ 15, 201518 }, -- Crimson Gladiator's Chain Wristguards
				{ 16, 201519 }, -- Crimson Gladiator's Chain Bracers
				{ 17, 201902 }, -- Crimson Gladiator's Cloak
				{ 18, 201903 }, -- Crimson Gladiator's Drape
				{ 19, 201904 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DEATHKNIGHT
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201520 }, -- Crimson Gladiator's Plate Chestguard
				{ 2 , 201521 }, -- Crimson Gladiator's Plate Chestplate
				{ 3 , 201522 }, -- Crimson Gladiator's Plate Warboots
				{ 4 , 201523 }, -- Crimson Gladiator's Plate Stompers
				{ 5 , 201524 }, -- Crimson Gladiator's Plate Gauntlets
				{ 6 , 201525 }, -- Crimson Gladiator's Plate Handguards
				{ 7 , 201526 }, -- Crimson Gladiator's Plate Helm
				{ 8 , 201527 }, -- Crimson Gladiator's Plate Helmet
				{ 9 , 201528 }, -- Crimson Gladiator's Plate Legguards
				{ 10, 201529 }, -- Crimson Gladiator's Plate Wargreaves
				{ 11, 201530 }, -- Crimson Gladiator's Plate Shoulders
				{ 12, 201531 }, -- Crimson Gladiator's Plate Pauldrons
				{ 13, 201532 }, -- Crimson Gladiator's Plate Girdle
				{ 14, 201533 }, -- Crimson Gladiator's Plate Greatbelt
				{ 15, 201534 }, -- Crimson Gladiator's Plate Wristguards
				{ 16, 201535 }, -- Crimson Gladiator's Plate Vambraces
				{ 17, 201911 }, -- Crimson Gladiator's Cloak
				{ 18, 201912 }, -- Crimson Gladiator's Drape
				{ 19, 201913 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DEMONHUNTER
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201568 }, -- Crimson Gladiator's Leather Vest
				{ 2 , 201569 }, -- Crimson Gladiator's Leather Jerkin
				{ 3 , 201570 }, -- Crimson Gladiator's Leather Boots
				{ 4 , 201571 }, -- Crimson Gladiator's Leather Treads
				{ 5 , 201572 }, -- Crimson Gladiator's Leather Gloves
				{ 6 , 201573 }, -- Crimson Gladiator's Leather Grips
				{ 7 , 201574 }, -- Crimson Gladiator's Leather Helm
				{ 8 , 201575 }, -- Crimson Gladiator's Leather Mask
				{ 9 , 201576 }, -- Crimson Gladiator's Leather Breeches
				{ 10, 201577 }, -- Crimson Gladiator's Leather Legwraps
				{ 11, 201578 }, -- Crimson Gladiator's Leather Spaulders
				{ 12, 201579 }, -- Crimson Gladiator's Leather Shoulderpads
				{ 13, 201580 }, -- Crimson Gladiator's Leather Belt
				{ 14, 201581 }, -- Crimson Gladiator's Leather Strap
				{ 15, 201582 }, -- Crimson Gladiator's Leather Wristwraps
				{ 16, 201583 }, -- Crimson Gladiator's Leather Wristguards
				{ 17, 201890 }, -- Crimson Gladiator's Cloak
				{ 18, 201891 }, -- Crimson Gladiator's Drape
				{ 19, 201892 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DRUID
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201585 }, -- Crimson Gladiator's Leather Vest
				{ 2 , 201586 }, -- Crimson Gladiator's Leather Jerkin
				{ 3 , 201587 }, -- Crimson Gladiator's Leather Boots
				{ 4 , 201588 }, -- Crimson Gladiator's Leather Treads
				{ 5 , 201589 }, -- Crimson Gladiator's Leather Gloves
				{ 6 , 201590 }, -- Crimson Gladiator's Leather Grips
				{ 7 , 201591 }, -- Crimson Gladiator's Leather Helm
				{ 8 , 201592 }, -- Crimson Gladiator's Leather Mask
				{ 9 , 201593 }, -- Crimson Gladiator's Leather Breeches
				{ 10, 201594 }, -- Crimson Gladiator's Leather Legwraps
				{ 11, 201595 }, -- Crimson Gladiator's Leather Spaulders
				{ 12, 201596 }, -- Crimson Gladiator's Leather Shoulderpads
				{ 13, 201597 }, -- Crimson Gladiator's Leather Belt
				{ 14, 201598 }, -- Crimson Gladiator's Leather Strap
				{ 15, 201599 }, -- Crimson Gladiator's Leather Wristwraps
				{ 16, 201600 }, -- Crimson Gladiator's Leather Wristguards
				{ 17, 201893 }, -- Crimson Gladiator's Cloak
				{ 18, 201894 }, -- Crimson Gladiator's Drape
				{ 19, 201895 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- HUNTER
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201634 }, -- Crimson Gladiator's Chain Vest
				{ 2 , 201635 }, -- Crimson Gladiator's Chain Tunic
				{ 3 , 201636 }, -- Crimson Gladiator's Chain Sabatons
				{ 4 , 201637 }, -- Crimson Gladiator's Chain Boots
				{ 5 , 201638 }, -- Crimson Gladiator's Chain Gauntlets
				{ 6 , 201639 }, -- Crimson Gladiator's Chain Handguards
				{ 7 , 201640 }, -- Crimson Gladiator's Chain Helm
				{ 8 , 201641 }, -- Crimson Gladiator's Chain Faceguard
				{ 9 , 201642 }, -- Crimson Gladiator's Chain Leggings
				{ 10, 201643 }, -- Crimson Gladiator's Chain Breeches
				{ 11, 201644 }, -- Crimson Gladiator's Chain Monnion
				{ 12, 201645 }, -- Crimson Gladiator's Chain Shoulderguard
				{ 13, 201646 }, -- Crimson Gladiator's Chain Belt
				{ 14, 201647 }, -- Crimson Gladiator's Chain Girdle
				{ 15, 201648 }, -- Crimson Gladiator's Chain Wristguards
				{ 16, 201649 }, -- Crimson Gladiator's Chain Bracers
				{ 17, 201905 }, -- Crimson Gladiator's Cloak
				{ 18, 201906 }, -- Crimson Gladiator's Drape
				{ 19, 201907 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- MAGE
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201472 }, -- Crimson Gladiator's Silk Tunic
				{ 2 , 201473 }, -- Crimson Gladiator's Silk Blouse
				{ 3 , 201474 }, -- Crimson Gladiator's Silk Slippers
				{ 4 , 201475 }, -- Crimson Gladiator's Silk Treads
				{ 5 , 201476 }, -- Crimson Gladiator's Silk Gloves
				{ 6 , 201477 }, -- Crimson Gladiator's Silk Handwraps
				{ 7 , 201478 }, -- Crimson Gladiator's Silk Hood
				{ 8 , 201479 }, -- Crimson Gladiator's Silk Guise
				{ 9 , 201480 }, -- Crimson Gladiator's Silk Leggings
				{ 10, 201481 }, -- Crimson Gladiator's Silk Trousers
				{ 11, 201482 }, -- Crimson Gladiator's Silk Mantle
				{ 12, 201483 }, -- Crimson Gladiator's Silk Amice
				{ 13, 201484 }, -- Crimson Gladiator's Silk Cord
				{ 14, 201485 }, -- Crimson Gladiator's Silk Belt
				{ 15, 201486 }, -- Crimson Gladiator's Silk Wristwraps
				{ 16, 201487 }, -- Crimson Gladiator's Silk Armbands
				{ 17, 201797 }, -- Crimson Gladiator's Cloak
				{ 18, 201798 }, -- Crimson Gladiator's Drape
				{ 19, 201799 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- MONK
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201602 }, -- Crimson Gladiator's Leather Vest
				{ 2 , 201603 }, -- Crimson Gladiator's Leather Jerkin
				{ 3 , 201604 }, -- Crimson Gladiator's Leather Boots
				{ 4 , 201605 }, -- Crimson Gladiator's Leather Treads
				{ 5 , 201606 }, -- Crimson Gladiator's Leather Gloves
				{ 6 , 201607 }, -- Crimson Gladiator's Leather Grips
				{ 7 , 201608 }, -- Crimson Gladiator's Leather Helm
				{ 8 , 201609 }, -- Crimson Gladiator's Leather Mask
				{ 9 , 201610 }, -- Crimson Gladiator's Leather Breeches
				{ 10, 201611 }, -- Crimson Gladiator's Leather Legwraps
				{ 11, 201612 }, -- Crimson Gladiator's Leather Spaulders
				{ 12, 201613 }, -- Crimson Gladiator's Leather Shoulderpads
				{ 13, 201614 }, -- Crimson Gladiator's Leather Belt
				{ 14, 201615 }, -- Crimson Gladiator's Leather Strap
				{ 15, 201616 }, -- Crimson Gladiator's Leather Wristwraps
				{ 16, 201617 }, -- Crimson Gladiator's Leather Wristguards
				{ 17, 201896 }, -- Crimson Gladiator's Cloak
				{ 18, 201897 }, -- Crimson Gladiator's Drape
				{ 19, 201898 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- PALADIN
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201665 }, -- Crimson Gladiator's Plate Chestguard
				{ 2 , 201666 }, -- Crimson Gladiator's Plate Chestplate
				{ 3 , 201667 }, -- Crimson Gladiator's Plate Warboots
				{ 4 , 201668 }, -- Crimson Gladiator's Plate Stompers
				{ 5 , 201669 }, -- Crimson Gladiator's Plate Gauntlets
				{ 6 , 201670 }, -- Crimson Gladiator's Plate Handguards
				{ 7 , 201671 }, -- Crimson Gladiator's Plate Helm
				{ 8 , 201672 }, -- Crimson Gladiator's Plate Helmet
				{ 9 , 201673 }, -- Crimson Gladiator's Plate Legguards
				{ 10, 201674 }, -- Crimson Gladiator's Plate Wargreaves
				{ 11, 201675 }, -- Crimson Gladiator's Plate Shoulders
				{ 12, 201676 }, -- Crimson Gladiator's Plate Pauldrons
				{ 13, 201677 }, -- Crimson Gladiator's Plate Girdle
				{ 14, 201678 }, -- Crimson Gladiator's Plate Greatbelt
				{ 15, 201679 }, -- Crimson Gladiator's Plate Wristguards
				{ 16, 201680 }, -- Crimson Gladiator's Plate Vambraces
				{ 17, 201914 }, -- Crimson Gladiator's Cloak
				{ 18, 201915 }, -- Crimson Gladiator's Drape
				{ 19, 201916 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- PRIEST
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201536 }, -- Crimson Gladiator's Silk Robe
				{ 2 , 201537 }, -- Crimson Gladiator's Silk Vestments
				{ 3 , 201538 }, -- Crimson Gladiator's Silk Slippers
				{ 4 , 201539 }, -- Crimson Gladiator's Silk Treads
				{ 5 , 201540 }, -- Crimson Gladiator's Silk Gloves
				{ 6 , 201541 }, -- Crimson Gladiator's Silk Handwraps
				{ 7 , 201542 }, -- Crimson Gladiator's Silk Hood
				{ 8 , 201543 }, -- Crimson Gladiator's Silk Guise
				{ 9 , 201544 }, -- Crimson Gladiator's Silk Leggings
				{ 10, 201545 }, -- Crimson Gladiator's Silk Trousers
				{ 11, 201546 }, -- Crimson Gladiator's Silk Mantle
				{ 12, 201547 }, -- Crimson Gladiator's Silk Amice
				{ 13, 201548 }, -- Crimson Gladiator's Silk Cord
				{ 14, 201549 }, -- Crimson Gladiator's Silk Belt
				{ 15, 201550 }, -- Crimson Gladiator's Silk Wristwraps
				{ 16, 201551 }, -- Crimson Gladiator's Silk Armbands
				{ 17, 201884 }, -- Crimson Gladiator's Cloak
				{ 18, 201885 }, -- Crimson Gladiator's Drape
				{ 19, 201886 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- ROGUE
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201618 }, -- Crimson Gladiator's Leather Vest
				{ 2 , 201619 }, -- Crimson Gladiator's Leather Jerkin
				{ 3 , 201620 }, -- Crimson Gladiator's Leather Boots
				{ 4 , 201621 }, -- Crimson Gladiator's Leather Treads
				{ 5 , 201622 }, -- Crimson Gladiator's Leather Gloves
				{ 6 , 201623 }, -- Crimson Gladiator's Leather Grips
				{ 7 , 201624 }, -- Crimson Gladiator's Leather Helm
				{ 8 , 201625 }, -- Crimson Gladiator's Leather Mask
				{ 9 , 201626 }, -- Crimson Gladiator's Leather Breeches
				{ 10, 201627 }, -- Crimson Gladiator's Leather Legwraps
				{ 11, 201628 }, -- Crimson Gladiator's Leather Spaulders
				{ 12, 201629 }, -- Crimson Gladiator's Leather Shoulderpads
				{ 13, 201630 }, -- Crimson Gladiator's Leather Belt
				{ 14, 201631 }, -- Crimson Gladiator's Leather Strap
				{ 15, 201632 }, -- Crimson Gladiator's Leather Wristwraps
				{ 16, 201633 }, -- Crimson Gladiator's Leather Wristguards
				{ 17, 201899 }, -- Crimson Gladiator's Cloak
				{ 18, 201900 }, -- Crimson Gladiator's Drape
				{ 19, 201901 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- SHAMAN
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201650 }, -- Crimson Gladiator's Chain Vest
				{ 2 , 201651 }, -- Crimson Gladiator's Chain Tunic
				{ 3 , 201652 }, -- Crimson Gladiator's Chain Sabatons
				{ 4 , 201653 }, -- Crimson Gladiator's Chain Boots
				{ 5 , 201654 }, -- Crimson Gladiator's Chain Gauntlets
				{ 6 , 201655 }, -- Crimson Gladiator's Chain Handguards
				{ 7 , 201656 }, -- Crimson Gladiator's Chain Helm
				{ 8 , 201657 }, -- Crimson Gladiator's Chain Faceguard
				{ 9 , 201658 }, -- Crimson Gladiator's Chain Leggings
				{ 10, 201659 }, -- Crimson Gladiator's Chain Breeches
				{ 11, 201660 }, -- Crimson Gladiator's Chain Monnion
				{ 12, 201661 }, -- Crimson Gladiator's Chain Shoulderguard
				{ 13, 201662 }, -- Crimson Gladiator's Chain Belt
				{ 14, 201663 }, -- Crimson Gladiator's Chain Girdle
				{ 15, 201664 }, -- Crimson Gladiator's Chain Wristguards
				{ 16, 201701 }, -- Crimson Gladiator's Chain Bracers
				{ 17, 201908 }, -- Crimson Gladiator's Cloak
				{ 18, 201909 }, -- Crimson Gladiator's Drape
				{ 19, 201910 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- WARLOCK
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201552 }, -- Crimson Gladiator's Silk Robe
				{ 2 , 201553 }, -- Crimson Gladiator's Silk Vestments
				{ 3 , 201554 }, -- Crimson Gladiator's Silk Slippers
				{ 4 , 201555 }, -- Crimson Gladiator's Silk Treads
				{ 5 , 201556 }, -- Crimson Gladiator's Silk Gloves
				{ 6 , 201557 }, -- Crimson Gladiator's Silk Handwraps
				{ 7 , 201558 }, -- Crimson Gladiator's Silk Hood
				{ 8 , 201559 }, -- Crimson Gladiator's Silk Guise
				{ 9 , 201560 }, -- Crimson Gladiator's Silk Leggings
				{ 10, 201561 }, -- Crimson Gladiator's Silk Trousers
				{ 11, 201562 }, -- Crimson Gladiator's Silk Mantle
				{ 12, 201563 }, -- Crimson Gladiator's Silk Amice
				{ 13, 201564 }, -- Crimson Gladiator's Silk Cord
				{ 14, 201565 }, -- Crimson Gladiator's Silk Belt
				{ 15, 201566 }, -- Crimson Gladiator's Silk Wristwraps
				{ 16, 201567 }, -- Crimson Gladiator's Silk Armbands
				{ 17, 201887 }, -- Crimson Gladiator's Cloak
				{ 18, 201888 }, -- Crimson Gladiator's Drape
				{ 19, 201889 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- WARRIOR
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[ALLIANCE_DIFF] = {
				{ 1 , 201681 }, -- Crimson Gladiator's Plate Chestguard
				{ 2 , 201682 }, -- Crimson Gladiator's Plate Chestplate
				{ 3 , 201683 }, -- Crimson Gladiator's Plate Warboots
				{ 4 , 201684 }, -- Crimson Gladiator's Plate Stompers
				{ 5 , 201685 }, -- Crimson Gladiator's Plate Gauntlets
				{ 6 , 201686 }, -- Crimson Gladiator's Plate Handguards
				{ 7 , 201687 }, -- Crimson Gladiator's Plate Helm
				{ 8 , 201688 }, -- Crimson Gladiator's Plate Helmet
				{ 9 , 201689 }, -- Crimson Gladiator's Plate Legguards
				{ 10, 201690 }, -- Crimson Gladiator's Plate Wargreaves
				{ 11, 201691 }, -- Crimson Gladiator's Plate Shoulders
				{ 12, 201692 }, -- Crimson Gladiator's Plate Pauldrons
				{ 13, 201693 }, -- Crimson Gladiator's Plate Girdle
				{ 14, 201694 }, -- Crimson Gladiator's Plate Greatbelt
				{ 15, 201695 }, -- Crimson Gladiator's Plate Wristguards
				{ 16, 201696 }, -- Crimson Gladiator's Plate Vambraces
				{ 17, 201917 }, -- Crimson Gladiator's Cloak
				{ 18, 201918 }, -- Crimson Gladiator's Drape
				{ 19, 201919 }, -- Crimson Gladiator's Shawl
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
	},
}
