-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local string = _G.string
local format = string.format

-- WoW
local UnitFactionGroup = UnitFactionGroup
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...

local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "rf", nil, 17)
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", nil, 14)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", nil, 15)
local P25_DIFF = data:AddDifficulty(AL["25 Player"], "p25", nil, 4)
local P25H_DIFF = data:AddDifficulty(AL["25 Player Heroic"], "p25h", nil, 6)
local MYTHIC_DIFF = data:AddDifficulty(AL["Mythic"], "m", nil, 16)

local LEGENDARY_DIFF = data:AddDifficulty(ITEM_QUALITY5_DESC)

local WOD_DIFF = data:AddDifficulty(EXPANSION_NAME5)
local MOP_DIFF = data:AddDifficulty(EXPANSION_NAME4)
local CATA_DIFF = data:AddDifficulty(EXPANSION_NAME3)
local WOTLK_DIFF = data:AddDifficulty(EXPANSION_NAME2)
local BC_DIFF = data:AddDifficulty(EXPANSION_NAME1)
local CLASSIC_DIFF = data:AddDifficulty(EXPANSION_NAME0)

local HORDE_DIFF, ALLIANCE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

local NEUTRAL_DIFF       = data:AddDifficulty(FACTION_STANDING_LABEL4)

local NORMAL_ITTYPE      = data:AddItemTableType("Item", "Item")
local RAID_ITTYPE        = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...
local SET_ITTYPE         = data:AddItemTableType("Set", "Item")  -- Normal, Thunder-/Warforged...
local I_A_ITTYPE         = data:AddItemTableType("Item", "Achievement")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local ACH_EXTRA_ITTYPE   = data:AddExtraItemTableType("Achievement")

local COLLECTION_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTION_COLOR)

local function GetSpellInfo(spellID)
	local temp = C_Spell.GetSpellInfo(spellID)
	return temp.name, nil, temp.iconID
end

data["ARTIFACTS"]          = {
	name = SPLASH_LEGION_BOX_FEATURE2_TITLE,
	ContentType = COLLECTION_CONTENT,
	items = {
		{
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[NORMAL_DIFF] = {
				{ 1,  128292 },
				{ 2,  128402 },
				{ 3,  128403 },
				{ 5,  140538, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140554, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 8,  136796, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139673, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139674, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139675, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139676, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139677, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139678, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139679, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139680, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140962, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140935, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140963, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[NORMAL_DIFF] = {
				{ 1,  127829 },
				{ 2,  128832 },
				{ 4,  140560, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 16, 139715, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139716, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139717, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139718, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139719, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139720, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139721, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139722, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140964, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140936, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140965, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[NORMAL_DIFF] = {
				{ 1,  128306 },
				{ 2,  128821 },
				{ 3,  128860 },
				{ 4,  128858 },
				{ 6,  140540, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 7,  140542, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 8,  140549, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 10, 136787, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 11, 136789, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 12, 136790, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 13, 136794, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 14, 136795, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139723, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139724, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139725, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139726, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139727, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139728, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139729, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139730, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140966, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140937, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140967, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[NORMAL_DIFF] = {
				{ 1,  128808 },
				{ 2,  128826 },
				{ 3,  128861 },
				{ 5,  140539, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140544, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 7,  140548, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 9,  136780, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 10, 136781, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 11, 136855, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139707, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139708, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139709, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139710, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139711, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139712, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139713, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139714, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140968, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140938, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140969, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[NORMAL_DIFF] = {
				{ 1,  127857 },
				{ 2,  128862 },
				{ 3,  128820 },
				{ 5,  140550, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 16, 139747, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139748, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139749, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139750, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139751, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139752, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139753, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139754, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140970, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140939, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140971, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[NORMAL_DIFF] = {
				{ 1,  128940 },
				{ 2,  128937 },
				{ 3,  128938 },
				{ 5,  140543, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140551, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 7,  140564, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 9,  136800, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139731, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139732, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139733, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139734, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139735, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139736, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139737, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139738, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140972, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140940, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140973, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[NORMAL_DIFF] = {
				{ 1,  120978 },
				{ 2,  128823 },
				{ 3,  128866 },
				{ 5,  140535, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140547, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 7,  140555, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 8,  140558, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 10, 136801, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139690, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139691, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139692, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139693, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139694, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139695, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139696, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139697, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140974, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140941, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140975, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[NORMAL_DIFF] = {
				{ 1,  128825 },
				{ 2,  128868 },
				{ 3,  128827 },
				{ 5,  140552, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 16, 139755, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139756, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139757, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139758, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139759, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139760, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139761, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139762, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140976, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140942, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140977, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[NORMAL_DIFF] = {
				{ 1,  128476 },
				{ 2,  128870 },
				{ 3,  128872 },
				{ 5,  140541, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140556, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 8,  136803, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139739, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139740, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139741, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139742, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139743, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139744, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139745, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139746, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140978, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140943, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140979, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[NORMAL_DIFF] = {
				{ 1,  128935 },
				{ 2,  128819 },
				{ 3,  128911 },
				{ 5,  140536, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140545, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 7,  140546, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 9,  136934, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 10, 136935, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 11, 136937, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 12, 136938, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 13, 138490, [PRICE_EXTRA_ITTYPE] = "money:500000" },
				{ 16, 139698, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139699, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139700, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139701, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139702, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139703, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139704, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139705, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140980, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140944, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140981, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[NORMAL_DIFF] = {
				{ 1,  128943 },
				{ 2,  128941 },
				{ 3,  128942 },
				{ 5,  140553, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 16, 139763, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139764, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139765, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139766, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139767, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139768, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139769, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139770, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140982, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140945, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140983, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
		{
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[NORMAL_DIFF] = {
				{ 1,  128289 },
				{ 2,  128908 },
				{ 3,  128910 },
				{ 5,  140537, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 6,  140557, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 7,  140559, [PRICE_EXTRA_ITTYPE] = "money:1000000" },
				{ 16, 139681, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 17, 139682, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 18, 139683, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 19, 139684, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 20, 139685, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 21, 139686, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 22, 139687, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 23, 139688, [PRICE_EXTRA_ITTYPE] = "money:5000000" },
				{ 25, 140984, [PRICE_EXTRA_ITTYPE] = "orderresources:500" },
				{ 26, 140946, [PRICE_EXTRA_ITTYPE] = "orderresources:2000" },
				{ 27, 140985, [PRICE_EXTRA_ITTYPE] = "orderresources:4000" },
			},
		},
	},
}

data["TIMEWALKINGEVENT"]   = {
	name = AL["Timewalking Dungeon Event"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{ -- Any Timewalking Vendor
			name = AL["Any Timewalking Vendor"],
			[NORMAL_DIFF] = {
				{ 1,  205208, "mount",                                  [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Sandy Shalewing
				{ 2,  232624, "mount",                                  [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Timely Buzzbee
				{ 16, 122338, [PRICE_EXTRA_ITTYPE] = "timewarped:750" },                                -- Ancient Heirloom Armor Casing
				{ 17, 122339, [PRICE_EXTRA_ITTYPE] = "timewarped:900" },                                -- Ancient Heirloom Scabbard
				{ 18, 122340, [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                               -- Timeworn Heirloom Armor Casing
				{ 19, 122341, [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                               -- Timeworn Heirloom Scabbard
				{ 20, 151614, [PRICE_EXTRA_ITTYPE] = "timewarped:1000", },                              -- Weathered Heirloom Armor Casing
				{ 21, 151615, [PRICE_EXTRA_ITTYPE] = "timewarped:1200", },                              -- Weathered Heirloom Scabbard
				{ 22, 167731, [PRICE_EXTRA_ITTYPE] = "timewarped:1000", },                              -- Battle-Hardened Heirloom Armor Casing
				{ 23, 167732, [PRICE_EXTRA_ITTYPE] = "timewarped:1200", },                              -- Battle-Hardened Heirloom Scabbard
				{ 24, 187997, [PRICE_EXTRA_ITTYPE] = "timewarped:1000", },                              -- Eternal Heirloom Armor Casing
				{ 25, 187998, [PRICE_EXTRA_ITTYPE] = "timewarped:1200", },                              -- Eternal Heirloom Scabbard
				{ 26, 204336, [PRICE_EXTRA_ITTYPE] = "timewarped:1000", },                              -- Awakened Heirloom Armor Casing
				{ 27, 204337, [PRICE_EXTRA_ITTYPE] = "timewarped:1200", },                              -- Awakened Heirloom Scabbard
			},
		},
		{ -- Battle for Azeroth
			name = EXPANSION_NAME7,
			[NORMAL_DIFF] = {
				{ 1,   245695,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Reins of the Moonlit Nightsaber
				{ 2,   245694,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Reins of the Ivory Savagemane
				{ 3,   245543,                        "pet4849",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Flotsam Harvester
				{ 4,   245574,                        "pet4852",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Lil' Daz'ti
				{ 5,   245942,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Sea-Blessed Shrine
				{ 6,   246227,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Lightning-Blessed Spire
				{ 8,   238821,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Champions of Azeroth
				{ 9,   238822,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Tortollan Seekers
				{ 10,  238823,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Rustbolt Resistance
				{ 11,  238826,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Rajani
				{ 12,  238827,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Uldum Accord
				{ 13,  [ATLASLOOT_IT_HORDE] = 238816, [ATLASLOOT_IT_ALLIANCE] = 238803,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Order of Embers / Talanji's Expedition
				{ 14,  [ATLASLOOT_IT_HORDE] = 238818, [ATLASLOOT_IT_ALLIANCE] = 238804,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of Proudmoore Admiralty / Zandalari Empire
				{ 15,  [ATLASLOOT_IT_HORDE] = 238817, [ATLASLOOT_IT_ALLIANCE] = 238805,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of Storm's Wake / Voldunai
				{ 16,  [ATLASLOOT_IT_HORDE] = 238819, [ATLASLOOT_IT_ALLIANCE] = 238806,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the 7th Legion / Honorbound
				{ 17,  [ATLASLOOT_IT_HORDE] = 238820, [ATLASLOOT_IT_ALLIANCE] = 238809,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Waveblade Ankoan / Unshackled
				{ 19,  244430,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Fang of the Dark Prophets
				{ 20,  244432,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- 7th Legion Commander's Crest
				{ 21,  244471,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Time-Lost Tempest Caller
				{ 22,  244145,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Ashvane Smuggler's Attire
				{ 23,  244224,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Bloodsail Smuggler's Attire
				{ 24,  244306,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Ensemble: Golden Fleet's Sailing Garb
				{ 25,  244327,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Ensemble: Zocalo Merchant's Wear
				{ 26,  244426,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Dinomancer's Calming Rod
				{ 27,  244427,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Blood Witch's Hex Cane
				{ 28,  244428,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Fang of Sethraliss
				{ 29,  244431,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Tideguard's Blessed Gavel
				{ 30,  244433,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Waycrest Training Buckler
				{ 101, 244434,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Witch-Hunter's Shortsword
				{ 102, 244436,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Parrot King's Hook-Leg
				{ 103, 244437,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Dark Ranger's Black Bow
				{ 104, 244438,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Nazmani Blood Drinker
				{ 105, 244439,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Stormcrook of the Faithless
				{ 106, 244440,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Blade of the Rezani Prelate
				{ 107, 244441,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Dazar's Ceremonial Negotiator
				{ 108, 244445,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Razdunk's WR0-NC4 5300
				{ 110, "243558:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Stormsong Mariner's Cuff
				{ 111, "243559:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Pilfered Wristguards of Aka'ali
				{ 112, "243560:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Naval Officer's Armband
				{ 113, "243561:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Ancient Nazmani Bracelet
				{ 114, "243562:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Mirestained Scout's Mantle
				{ 115, "243563:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Tal'aman Ambassador's Amice
				{ 116, "243564:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Boralus Cityguard Spaulders
				{ 117, "243565:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Navigator's Flagship Mantle
				{ 118, "243566:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Waycrest Sentry Cloak
				{ 119, "243567:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Cloak of the Tideguard
				{ 120, "243568:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Tidecaller's Ritual Cape
				{ 121, "243569:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Bloodstained Shawl of Tal'Gurub
				{ 122, "244150:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Seaglass Ritual Rod
				{ 123, "244151:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Ashvane Ore Crusher
				{ 124, "244152:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Pilfered Golden Scepter
				{ 125, "244153:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Reclaimed Ancestral Blade of the Deeps
				{ 126, "244154:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Freehold Boarding Halberd
				{ 127, "244155:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Siren Slayer's Trident
				{ 128, "244156:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Crackling Stormbow of the Devoted
				{ 129, "244157:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Blessed Bulwark of Zanchul
				{ 130, "244158:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Azerite-Carved Ritual Kris
				{ 201, "244159:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Tol'Dagor Pocket Shank
				{ 202, "244160:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Junkyard Clobberstick
				{ 203, "244161:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Mugambala Champion's Axe
				{ 204, "244162:12264",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Bondo's Spare Mechano-Clamps
			},
		},
		{ -- Legion
			name = EXPANSION_NAME6,
			[NORMAL_DIFF] = {
				{ 1,   234721,         "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Ur'zul Fleshripper Bridle
				{ 2,   187595,         "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Favor of the Val'sharah Hippogryph
				{ 3,   187591,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Nightborne Guard's Vigilance
				{ 4,   207114,         [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Grimoire of the Fiendish Imp
				{ 6,   141018,         [PRICE_EXTRA_ITTYPE] = "timewarped:150" },                               -- Sargerei Blood Vessel
				{ 7,   187596,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Meat Delivery
				{ 8,   187597,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Fish Delivery
				{ 9,   187598,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Cloth Delivery
				{ 10,  187599,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Herb Delivery
				{ 11,  187600,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Ore Delivery
				{ 12,  187601,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Leather Delivery
				{ 13,  187604,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Enchantment Delivery
				{ 14,  187605,         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Broken Isles Gem Delivery
				{ 16,  146941,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Valarjar Insignia
				{ 17,  146942,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Dreamweaver Insignia
				{ 18,  146943,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Court of Farondis Insignia
				{ 19,  146944,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Highmountain Tribe Insignia
				{ 20,  146945,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Wardens Insignia
				{ 21,  146946,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Nightfallen Insignia
				{ 22,  146950,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Legionfall Insignia
				{ 23,  152957,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Army of the Light Insignia
				{ 24,  152960,         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Argussian Reach Insignia
				{ 26,  234945,         [PRICE_EXTRA_ITTYPE] = "timewarped:4000" },                              -- Ensemble: Invasion Stalker's Guise
				{ 27,  234946,         [PRICE_EXTRA_ITTYPE] = "timewarped:4000" },                              -- Ensemble: Broken Shore Battlemender's Gear
				{ 28,  244824,         [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Time-Lost Dreadbow of the Banshee
				{ 29,  187562,         [PRICE_EXTRA_ITTYPE] = "timewarped:3000" },                              -- Replica Aegis of Aggramar
				{ 30,  234949,         [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Howling Echoes
				{ 101, 234955,         [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Hate-Sculpted Magma
				{ 102, 234956,         [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Rod of Crystalline Energies
				{ 103, 234957,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Monstrous Gluttony
				{ 104, 234958,         [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Fenryr's Bloodstained Fang
				{ 105, 234959,         [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Key to the Halls
				{ 106, 234947,         [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Drake Hunter's Kit
				{ 107, 234948,         [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Drekirjar Warrior's Battlegear
				{ 108, 188209,         [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Ensemble: Ravencrest's Battleplate
				{ 109, 244837,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Mage-Forged Dragonblade
				{ 110, 244836,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Cane of the Runic Wanderer
				{ 111, 244834,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Hippogryph Lancer's Magespear
				{ 112, 244833,         [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Stonedark Chieftain's Bartered Tool
				{ 113, 244828,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Nightforged Spellblade
				{ 114, 244823,         [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Silver Dragonblade of the Resistance
				{ 115, 227287,         [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Skovald's Resolve
				{ 116, 227294,         [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ravencrest's Wrath
				{ 117, 234954,         [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Corrupted Knot
				{ 118, 244830,         [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Krokuun Tunneler's Axe
				{ 119, 244827,         [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Valarjar Sparring Buckler
				{ 121, "187563:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Suramar Guard's Shield
				{ 122, "187564:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Nightborne Arcshield
				{ 123, "187565:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Argussian Reach Longbow
				{ 124, "187566:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Arcsmasher
				{ 125, "187567:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Nightborne Arcsaber
				{ 126, "187578:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Warpcaster's Staff
				{ 127, "187579:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Nar'thalas Ceremonial Tunic
				{ 128, "187580:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Nar'thalas Ceremonial Legwraps
				{ 129, "187581:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Nar'thalas Scrollmantle
				{ 130, "187582:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Thorignir Heartguard
				{ 201, "187583:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Thorignir Breeches
				{ 202, "187584:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Thorignir Spaulders
				{ 203, "187585:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Leyguard Cuirass
				{ 204, "187586:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Leyguard Greaves
				{ 205, "187587:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Leyguard Mantle
				{ 206, "187588:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Black Rook Elite Chestguard
				{ 207, "187589:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Black Rook Elite Legguards
				{ 208, "187590:10845", [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Black Rook Elite Shoulderplates
				-- These items seem to be gone from the vendor, possibly because they have the same appearance as cheaper timewarped items
				--{ 110, 234952,         [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Crux of Blind Faith
				--{ 111, 234953,         [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Edge of the First Blade
			},
		},
		{ -- Warlords of Draenor
			name = EXPANSION_NAME5,
			[NORMAL_DIFF] = {
				{ 1,   234716,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Nightfall Skyreaver's Reins
				{ 2,   167894,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Beastlord's Irontusk
				{ 3,   167895,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Beastlord's Warwolf
				{ 4,   168014,                        [PRICE_EXTRA_ITTYPE] = "timewarped:750" },                               -- Banner of the Burning Blade
				{ 5,   168012,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Apexis Focusing Shard
				{ 6,   234906,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Auchenai Tabard
				{ 7,   234907,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Tattered Iron Horde Tabard
				{ 9,   167924,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Arakkoa Outcasts
				{ 10,  167925,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Order of the Awakened
				{ 11,  167926,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Steamwheedle Preservation Society
				{ 12,  167927,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Saberstalkers
				{ 13,  [ATLASLOOT_IT_HORDE] = 167928, [ATLASLOOT_IT_ALLIANCE] = 167929,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Frostwolf Orcs / Council of Exarchs
				{ 14,  [ATLASLOOT_IT_HORDE] = 167930, [ATLASLOOT_IT_ALLIANCE] = 167932,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Laughing Skull Orcs / Sha'tari Defense
				{ 15,  [ATLASLOOT_IT_HORDE] = 168017, [ATLASLOOT_IT_ALLIANCE] = 168018,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Vol'jin's Headhunters / Hand of the Prophet
				{ 16,  234901,                        [PRICE_EXTRA_ITTYPE] = "timewarped:4000" },                              -- Ensemble: Karabor Priest's Vestments
				{ 17,  234902,                        [PRICE_EXTRA_ITTYPE] = "timewarped:4000" },                              -- Ensemble: Shattrath Artificer's Regalia
				{ 18,  234903,                        [PRICE_EXTRA_ITTYPE] = "timewarped:4000" },                              -- Ensemble: Gorgrond Cragstalker's Hunting Gear
				{ 19,  234904,                        [PRICE_EXTRA_ITTYPE] = "timewarped:4000" },                              -- Ensemble: Shadowmoon Anchorite's Guardplate
				{ 20,  244726,                        [PRICE_EXTRA_ITTYPE] = "timewarped:3000" },                              -- Time-Lost Sight of the Shadowmoon
				{ 21,  244785,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Time-Lost Wolfbite, Legacy of Garad
				{ 22,  244730,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Razorwall of the Foundry
				{ 23,  244725,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Frostwall Defender's Axe
				{ 24,  244734,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Anchorite's Crystal Torch
				{ 25,  244732,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Lunarfall Scout's Shortsword
				{ 26,  244731,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Rangari Climbing Hooks
				{ 27,  244721,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Crystalsmith's Energy Focus
				{ 28,  244727,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Warsong Raider's Longbow
				{ 29,  244729,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Mok'gol Howling Shield
				{ 30,  244724,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Vindicator's Taladite Warmaul
				{ 101, 244723,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Blade of the Pale Flame
				{ 102, 244787,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Elodor Attuning Beacon
				{ 103, 244786,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Grom'gar Hunting Spear
				{ 104, 244776,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Truesteel Gavel
				{ 105, 244733,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Aruuna Miner's Pick
				{ 106, 244722,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Bloodied Ashran Battletome
				{ 107, 244728,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Lunarfall Rifle
				{ 108, 244784,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Beastmaster's Lost Hatchet
				{ 110, "116765:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Positive Pantaloons
				{ 111, "116834:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Whitesea's Waistwrap
				{ 112, "119226:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Blammo's Blammer
				{ 113, "119370:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Rattlekilt
				{ 114, "119372:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Ironstudded Scale Girdle
				{ 115, "119382:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Hershak's Heavy Legguards
				{ 116, "119384:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Krud's Girthy Girdle
				{ 117, "119396:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Shadowspeaker's Shard
				{ 118, "127296:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Twisted Taboo Handwraps
				{ 119, "127304:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Cave Keeper Wraps
				{ 120, "127311:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Serpentine Gloves
				{ 121, "127319:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Krag'goth's Iron Gauntlets
				{ 122, "127320:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Mo'gruth's Discarded Parade Helm
				{ 123, "127339:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:100" },                               -- Forgotten Champion's Blade
				{ 124, "113287:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Shard of Scorn
				{ 125, "116110:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Zorkra's Hood
				{ 126, "109057:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Frogskin Diving Cap
				{ 127, "109074:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Fine Void-Chain Cinch
				{ 128, "112096:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Dented Ogre Skullcap
				{ 129, "113557:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Dragonrider's Tinkered Leggings
			},
		},
		{ -- Mists of Pandaria
			name = EXPANSION_NAME4,
			[NORMAL_DIFF] = {
				{ 1,   87775,                         "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Yu'lei, Daughter of Jade
				{ 2,   234740,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Copper-Maned Quilen Reins
				{ 3,   143953,                        "pet2017",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Infinite Hatchling
				{ 4,   143954,                        "pet2018",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Paradox Spirit
				{ 5,   144393,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Portable Yak Wash
				{ 6,   144072,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Adopted Puppy Crate
				{ 7,   234756,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Kor'kron Tabard
				{ 8,   234755,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Tabard of the Pandaren Elders
				{ 10,  143948,                        [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Chilled Satchel of Vegetables
				{ 11,  79264,                         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Ruby Shard
				{ 12,  79265,                         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Blue Feather
				{ 13,  79266,                         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Jade Cat
				{ 14,  79267,                         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Lovely Apple
				{ 15,  79268,                         [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Marsh Lily
				{ 16,  143935,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The Klaxxi
				{ 17,  143936,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Shado-Pan
				{ 18,  143937,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Golden Lotus
				{ 19,  143938,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The August Celestials
				{ 20,  [ATLASLOOT_IT_HORDE] = 143939, [ATLASLOOT_IT_ALLIANCE] = 143940,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Sunreaver Onslaught / Kirin Tor Offensive
				{ 21,  143941,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The Tillers
				{ 22,  143942,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Order of the Cloud Serpent
				{ 23,  [ATLASLOOT_IT_HORDE] = 143943, [ATLASLOOT_IT_ALLIANCE] = 143944,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Dominance Offensive / Operation: Shieldwall
				{ 24,  143945,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Shado-Pan Assault
				{ 25,  143946,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The Anglers
				{ 26,  143947,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of Emperor Shaohao
				{ 28,  234774,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Crimson Amber Incubator
				{ 29,  234796,                        [PRICE_EXTRA_ITTYPE] = "timewarped:800" },                               -- Embroidered Shado-Pan Kilt
				{ 30,  234762,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Embroidered Shado-Pan Robes
				{ 101, 234764,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Fist of Knives
				{ 102, 234794,                        [PRICE_EXTRA_ITTYPE] = "timewarped:800" },                               -- Gilded Shado-Pan Kilt
				{ 103, 234759,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Gilded Shado-Pan Robes
				{ 104, 234757,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Kor'kron Pauldrons
				{ 105, 234772,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Kris of the Mogu Shaman
				{ 106, 234771,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Mogu Lightning Spitter
				{ 107, 234781,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Mogu'shan Vault's Improvised Shield
				{ 108, 234787,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Mogu'shan Warden's Crystal Spear
				{ 109, 234784,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Pandaren Bolt Thrower
				{ 110, 234791,                        [PRICE_EXTRA_ITTYPE] = "timewarped:3000" },                              -- Reforged Harmonic Mallet
				{ 111, 234790,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Restored Harmonic Mallet
				{ 112, 234795,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Shado-Pan Guise
				{ 113, 234763,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Bloody Expeditionary Cleaver
				{ 114, 234783,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Caravan Guard's Buckler
				{ 115, 234767,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Flame-Bladed Long Sword
				{ 116, 234765,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Flame-Bladed Steel Sword
				{ 117, 234789,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Gourd-Topped Mallet
				{ 118, 234773,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Imperial Gut Render
				{ 119, 234770,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Pandaren Guard's Halberd
				{ 120, 234769,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Pandaren Guard's Poleaxe
				{ 121, 234766,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Ringed Pandaren Falchion
				{ 122, 234776,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Saurok Mystic's Voodoo Stick
				{ 123, 234778,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Staff of the Jade Serpent
				{ 124, 234777,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Stave-Master's Spire
				{ 125, 234768,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Jungle Gourd Splitter
				{ 126, 234775,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Amber Pandaren Fan
				{ 128, "144059:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Ambersmith Legplates
				{ 129, "144054:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Blackguard Cape
				{ 130, "144052:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Bloodseeker's Solitaire
				{ 201, "144053:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Choker of the Klaxxi'va
				{ 202, "144057:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Dreadsworn Slayer Legs
				{ 203, "144045:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Fingers of the Loneliest Monk
				{ 204, "144047:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Gauntlets of Jade Sutras
				{ 205, "144044:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Gloves of Red Feathers
				{ 206, "144056:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Leggings of the Poisoned Soul
				{ 207, "144058:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Locust Swarm Legguards
				{ 208, "144060:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Mantle of the Golden Sun
				{ 209, "144046:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Ravenmane's Gloves
				{ 210, "144055:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Sagewhisper's Wrap
				{ 211, "144049:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Sandals of the Elder Sage
				{ 212, "144070:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Shado-Pan Dragon Gun
				{ 213, "144063:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Stonetoe Spaulders
				{ 214, "144051:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Storm-Sing Sandals
				{ 215, "144050:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Tukka-Tuk's Hairy Boots
				{ 216, "144061:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Whitepetal Shouldergarb
				{ 217, "144062:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35" },                                -- Windwalker Spaulders
				{ 218, "144048:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Yu'lon Guardian Boots
			},
		},
		{ -- Cataclysm
			name = EXPANSION_NAME3,
			[NORMAL_DIFF] = {
				{ 1,   234730,                           "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Broodling of Sinestra
				{ 2,   133542,                           [PRICE_EXTRA_ITTYPE] = "timewarped:3000" },                              -- Tosselwrench's Mega-Accurate Simulation Viewfinder
				{ 3,   133511,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Gurboggle's Gleaming Bauble
				{ 4,   [ATLASLOOT_IT_ALLIANCE] = 234860, [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Explorer's League Deepholm Expedition Tabard
				{ 5,   [ATLASLOOT_IT_HORDE] = 234861,    [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Reliquary Tabard
				{ 7,   67414,                            [PRICE_EXTRA_ITTYPE] = "timewarped:150" },                               -- Bag of Shiny Things
				{ 8,   [ATLASLOOT_IT_HORDE] = 133545,    [ATLASLOOT_IT_ALLIANCE] = 49602,         [PRICE_EXTRA_ITTYPE] = "timewarped:10" }, -- Earl Black Tea / "New!" Kaja'Cola
				{ 9,   21548,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Pattern: Stormshroud Gloves
				{ 10,  15764,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Pattern: Stormshroud Shoulders
				{ 11,  15753,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Pattern: Stormshroud Armor
				{ 12,  14493,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Pattern: Robe of Winter Nightag
				{ 13,  13497,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Recipe: Greater Arcane Protection Potion
				{ 14,  13308,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Schematic: Ice Deflector
				{ 15,  12227,                            [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Recipe: Lean Wolf Steak
				{ 16,  5489,                             [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Recipe: Lean Venison
				{ 17,  3734,                             [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Recipe: Big Bear Steak
				{ 19,  133160,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of Therazane
				{ 20,  133154,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Ramkahen
				{ 21,  [ATLASLOOT_IT_HORDE] = 133150,    [ATLASLOOT_IT_ALLIANCE] = 133151,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Wildhammer Clan / Dragonmaw Clan
				{ 22,  133159,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The Earthen Ring
				{ 23,  133152,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Guardians of Hyjal
				{ 25,  234855,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Vestments of the Twisted Grove
				{ 26,  234856,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Twilight Zealot's Battleplate
				{ 27,  234857,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Twilight Hunter's Guise
				{ 28,  234859,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Twilight Acolyte's Regalia
				{ 29,  244551,                           [PRICE_EXTRA_ITTYPE] = "timewarped:3000" },                              -- Time-Lost Worldbreaker
				{ 30,  244680,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Morchie's Desynchronized Chime
				{ 101, 244647,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Crook of the White Flame
				{ 102, 244542,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Chronosmith's Temporal Safeguard
				{ 103, 244544,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Forest Watcher's Rune-Axe
				{ 104, 244541,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Zin-Azshari Court Scepter
				{ 105, 244681,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Pyrewood Silver Blade
				{ 106, 244543,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Scimitar of the Crocolisk God
				{ 107, 244652,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Prayer Beacon of the Goddess
				{ 108, 244650,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Fort Triumph Longbow
				{ 109, 244546,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Forgotten Bow of the Banshee
				{ 110, 244649,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Shadowforge Senator's Ledger
				{ 111, 244648,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Scripture of the Scarlet High Priest
				{ 112, 244540,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Charred Flamewake Sprout
				{ 113, 244549,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Light's Dawn Cryptblade
				{ 114, 244550,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Sunwalker's Ashen Warmaul
				{ 115, 244646,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Seared Root of Regrowth
				{ 116, 244548,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Shattered Highvale Staff
				{ 117, 244651,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Forest Ranger's Buckler
				{ 119, "133520:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Seal of the Grand Architect
				{ 120, "133521:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Band of Reconstruction
				{ 121, "133522:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Ring of Torn Flesh
				{ 122, "133523:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Emergency Descent Loop
				{ 123, "133524:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Signet of the Resolute
				{ 124, "133525:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Bones of the Damned
				{ 125, "133526:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Lightwarper Vestments
				{ 126, "133527:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Ghostworld Chestguard
				{ 127, "133528:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Decaying Herbalist's Robes
				{ 128, "133529:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Belt of Hidden Keys
				{ 129, "133530:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Cord of Dragon Sinew
				{ 130, "133531:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Blinding Girdle of Truth
				{ 201, "133532:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Vestal's Irrepressible Girdle
				{ 202, "133533:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Flashing Bracers of Warmth
				{ 203, "133534:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Dragonbelly Bracers
				{ 204, "133535:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Bracers of Manifold Pockets
				{ 205, "133536:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Bracers of the Black Dream
				{ 206, "133537:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Kiroptyric Sigil
				{ 207, "133538:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Bottled Wishes
				{ 208, "133539:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Reflection of the Light
				{ 209, "133540:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Rotting Skull
				{ 210, "133541:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Fire of the Deep
			},
		},
		{ -- Wrath of the Lich King
			name = EXPANSION_NAME2,
			[NORMAL_DIFF] = {
				{ 1,   129922,                           "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Bridle of the Ironbound Wraithcharger
				{ 2,   231374,                           "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Enchanted Spellweave Carpet
				{ 3,   231356,                           "pet4686",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Specter
				{ 4,   129938,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Will of Northrend
				{ 5,   129965,                           [PRICE_EXTRA_ITTYPE] = "timewarped:750" },                               -- Grizzlesnout's Fang
				{ 6,   129952,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Hourglass of Eternity
				{ 7,   [ATLASLOOT_IT_ALLIANCE] = 232476, [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Explorer's League Tabard
				{ 8,   [ATLASLOOT_IT_HORDE] = 232477,    [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Hand of Vengeance Tabard
				{ 10,  44113,                            [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Small Spice Bag
				{ 11,  46007,                            [PRICE_EXTRA_ITTYPE] = "timewarped:150" },                               -- Bag of Fishing Treasures
				{ 13,  129940,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Kirin Tor
				{ 14,  129941,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Ebon Blade
				{ 15,  [ATLASLOOT_IT_HORDE] = 129954,    [ATLASLOOT_IT_ALLIANCE] = 129955,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of the Alliance Vanguard / Commendation of the Horde Expedition
				{ 16,  129942,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Argent Crusade
				{ 17,  129943,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Sons of Hodir
				{ 18,  129944,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Wyrmrest Accord
				{ 20,  231999,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Dragonflayer's Heartpiercer
				{ 21,  232003,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Wolf-Eyed Sharpshooter
				{ 22,  232004,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Ironforge Hammerhead Rifle
				{ 23,  232008,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Magehunter's Ornate Dagger
				{ 24,  232019,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Dark Ritualists Spellblade
				{ 25,  232020,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Stormforged Short Blade
				{ 26,  232025,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Frost Giant's Claws
				{ 27,  232026,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Drakkari Voodoo Stick
				{ 28,  232027,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Dragonflayer's Iron Cleaver
				{ 29,  232028,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Warsong Coldweather Cleaver
				{ 30,  232041,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Titan-Spark Longblade
				{ 101, 232042,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Azure Magus' Blade
				{ 102, 232043,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Crystal-Maw Basher
				{ 103, 232052,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Dragonflayer's Wing Splitter
				{ 104, 232055,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Griffon's Teeth Ripper
				{ 105, 232056,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Ymirjar Battle Harpoon
				{ 106, 232058,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Ceremonial Stratholme Shield
				{ 107, 232059,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Tainted Keeper's Visage
				{ 108, 232060,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Coldarra Spellbinder's Stave
				{ 109, 232063,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Drakkari Head Splitter
				{ 110, 232064,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Leviathan Mk II Crowd Control Blade
				{ 111, 232078,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Ghostly Titan Astrolabe
				{ 112, 232291,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Battered Bulwark of the Argent Crusade
				{ 113, 232313,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Coldarra Spellbinder's Regalia
				{ 114, 232314,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Jotunheim Berserker's Battleplate
				{ 115, 232315,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Ymirjar Deathbringer's Battleplate
				{ 116, 232316,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Brunnhildar Scout's Kit
				{ 117, 232317,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Drakkari Stalker's Trappings
				{ 118, 232000,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Frosted Ymirheim Battle Bow
				{ 119, 232010,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Vrykul Gutripper
				{ 121, [ATLASLOOT_IT_HORDE] = 171995,    [ATLASLOOT_IT_ALLIANCE] = 171999,        [PRICE_EXTRA_ITTYPE] = "timewarped:25" }, -- Coldstep Sandals / Slippers
				{ 122, "129868:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Kyzoc's Ground Stompers
				{ 123, "129869:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Xintor's Expeditionary Boots
				{ 124, "129870:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Pack-Ice Striders
				{ 125, "129871:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Boots of Captain Ellis
				{ 126, "129872:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Band of Channeled Magic
				{ 127, "129873:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Renewal of Life
				{ 128, "129874:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Ring of Invincibility
				{ 129, "129875:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Signet of the Impregnable Fortress
				{ 130, "129876:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Bloodshed Band
				{ 201, "129877:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Logsplitters
				{ 202, "129879:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Gloves of False Gestures
				{ 203, "129880:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Gauntlets of the Kraken
				{ 204, "129881:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Cat Burglar's Grips
				{ 205, "129882:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Evoker's Charm
				{ 206, "129883:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Spiked Battleguard Choker
				{ 207, "129884:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Brooch of the Wailing Night
				{ 208, "129885:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Frozen Tear of Elune
				{ 209, "129886:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Shard of the Crystal Forest
				{ 210, "129889:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Castle Breaker's Battleplate
				{ 211, "129890:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Longstrider's Vest
				{ 212, "129891:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Shadow Seeker's Tunic
				{ 213, "129892:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Meteor Chaser's Raiment
				{ 214, "129893:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Sundial of the Exiled
				{ 215, "129895:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Valor Medal of the First War
				{ 216, "129896:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Mirror of Truth
				{ 217, "129897:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- The Egg of Mortal Essence
				{ 218, "129898:10845",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Mark of Supremacy
			},
		},
		{ -- The Burning Crusade
			name = EXPANSION_NAME1,
			[NORMAL_DIFF] = {
				{ 1,   129923,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Reins of the Eclipse Dragonhawk
				{ 2,   224399,                        "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Reins of the Amani Hunting Bear
				{ 3,   231365,                        "pet4689",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Karazhan Syphoner
				{ 4,   129929,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Ever-Shifting Mirror
				{ 5,   129926,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1250" },                              -- Mark of the Ashtongue
				{ 6,   151184,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Verdant Throwing Sphere
				{ 7,   151016,                        [PRICE_EXTRA_ITTYPE] = "timewarped:750" },                               -- Fractured Necrolyte Skull
				{ 8,   207112,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1000" },                              -- Grimoire of the Void-Touched Fel Imp
				{ 9,   232478,                        [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Area 52 Tabard
				{ 10,  [ATLASLOOT_IT_HORDE] = 23388,  [PRICE_EXTRA_ITTYPE] = "timewarped:500" },                               -- Tranquillien Tabard
				{ 12,  33844,                         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Barrel of Fish
				{ 13,  33857,                         [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Crate of Meat
				{ 14,  35348,                         [PRICE_EXTRA_ITTYPE] = "timewarped:150" },                               -- Bag of Fishing Treasures
				{ 16,  [ATLASLOOT_IT_HORDE] = 129947, [ATLASLOOT_IT_ALLIANCE] = 129948,        [PRICE_EXTRA_ITTYPE] = "timewarped:50" }, -- Commendation of Thrallmar / Honor Hold
				{ 17,  129945,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The Consortium
				{ 18,  129946,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of The Sha'tar
				{ 19,  129949,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Cenarion Expedition
				{ 20,  129950,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Keepers of Time
				{ 21,  129951,                        [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of Lower City
				{ 23,  232001,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Blazing Skyhawk Repeater
				{ 24,  232002,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Amani Tracker's Blunderbuss
				{ 25,  232021,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Sunburst Sticker
				{ 26,  232022,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Point of the Nether Vortex
				{ 27,  232023,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Chilled Obsidian Dragon's Tooth
				{ 28,  232024,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Sunfury Stalker's Fists
				{ 29,  232029,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Auchenai Vindicator's Crystal Cleaver
				{ 30,  232040,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Corrupted Sunblade
				{ 101, 232044,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Hammer of the Forest Loas
				{ 102, 232048,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Felguard Sentinel's Polearm
				{ 103, 232050,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Ashtongue Guardian's Spire
				{ 104, 232051,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Ashtongue Channeler's Staff
				{ 105, 232057,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Drake's Breath Heater Shield
				{ 106, 232061,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Cenarion Guardian's Stave
				{ 107, 232066,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Icefrost Focuser
				{ 108, 232067,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1800" },                              -- Amani'shi Voodoo Bow
				{ 109, 232345,                        [PRICE_EXTRA_ITTYPE] = "timewarped:3000" },                              -- Xu'rakas, Glaive of Command
				{ 110, 232318,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Shadowmoon Warlock's Vestments
				{ 111, 232319,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Auchenai Priest's Raiment
				{ 112, 232320,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Telhamat Anchorite's Raiment
				{ 113, 232321,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Boulderfist Mystic's Battlegear
				{ 114, 232322,                        [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Ensemble: Cenarion Mender's Battlegear
				{ 115, 232062,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Shadowsword Vanquisher's Blade
				{ 116, 232065,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Crimson Draenethyst Crusher
				{ 117, 232039,                        [PRICE_EXTRA_ITTYPE] = "timewarped:1200" },                              -- Crystal-Hooked Shortsword
				{ 119, [ATLASLOOT_IT_HORDE] = 171995, [ATLASLOOT_IT_ALLIANCE] = 171999,        [PRICE_EXTRA_ITTYPE] = "timewarped:25" }, -- Coldstep Sandals / Slippers
				{ 120, "129829:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Staff of the Forest Lord
				{ 121, "129827:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- The Blade of Harbingers
				{ 122, "129828:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Staff of the Soul-Eater
				{ 123, "129845:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Crossbow of Relentless Strikes
				{ 124, "129931:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- The Mutilator
				{ 125, "129861:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Sword of Unyielding Force
				{ 126, "129856:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Vanir's Fist of Brutality
				{ 127, "129858:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Gavel of Naaru Blessings
				{ 128, "129857:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Scryer's Blade of Focus
				{ 129, "129839:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35", },                               -- Talisman of Kalecgos
				{ 130, "129846:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35", },                               -- Mazthoril Honor Shield
				{ 201, "129847:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:35", },                               -- Azure-Shield of Coldarra
				{ 202, "129848:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Bloodlust Brooch
				{ 203, "129851:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Essence of the Martyr
				{ 204, "129849:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Gnomeregan Auto-Blocker 601
				{ 205, "129937:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Emblem of Fury
				{ 206, "129850:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Icon of the Silver Crescent
				{ 207, "129832:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Blood Knight War Cloak
				{ 208, "129833:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Shawl of Shifting Probabilities
				{ 209, "129831:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Dory's Embrace
				{ 210, "129830:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Farstrider Defender's Cloak
				{ 211, "129834:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Bishop's Cloak
				{ 212, "129837:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Cowl of Naaru Blessings
				{ 213, "129836:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Mask of the Deceiver
				{ 214, "129835:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Faceguard of Determination
				{ 215, "129838:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Storm Master's Helmet
				{ 216, "129840:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Rushing Storm Kilt
				{ 217, "129842:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Legplates of Unending Fury
				{ 218, "129841:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Trousers of the Scryers' Retainer
				{ 219, "129843:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Corrupted Soulcloth Pantaloons
				{ 220, "129854:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Girdle of Seething Rage
				{ 221, "129852:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Belt of the Silent Path
				{ 222, "129855:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Voodoo-Woven Belt
				{ 223, "129853:10845",                [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Aftershock Waistguard
			},
		},
		{ -- Classic
			name = EXPANSION_NAME0,
			[NORMAL_DIFF] = {
				{ 1,   224398,                           "mount",                                 [PRICE_EXTRA_ITTYPE] = "timewarped:5000" }, -- Reins of the Frayfeather Hippogryph
				{ 2,   224406,                           "pet4592",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Misty
				{ 3,   224410,                           "pet4593",                               [PRICE_EXTRA_ITTYPE] = "timewarped:2200" }, -- Craggles
				{ 4,   224192,                           [PRICE_EXTRA_ITTYPE] = "timewarped:200" },                               -- Practice Ravager
				{ 6,   224190,                           [PRICE_EXTRA_ITTYPE] = "timewarped:25" },                                -- Kreeg's Hardy Draught
				{ 7,   6522,                             [PRICE_EXTRA_ITTYPE] = "timewarped:2" },                                 -- Deviate Fish
				{ 8,   6657,                             [PRICE_EXTRA_ITTYPE] = "timewarped:10" },                                -- Savory Deviate Delight
				{ 9,   8529,                             [PRICE_EXTRA_ITTYPE] = "timewarped:10" },                                -- Noggenfogger Elixir
				{ 10,  225378,                           [PRICE_EXTRA_ITTYPE] = "timewarped:200", [ATLASLOOT_IT_AMOUNT1] = 25 },  -- Mohawk Grenade
				{ 12,  224558,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Brood of Nozdormu
				{ 13,  224561,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Hydraxian Waterlords
				{ 14,  224567,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Argent Dawn
				{ 15,  224566,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Timbermaw Hold
				{ 16,  224570,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Zandalar Tribe
				{ 17,  224571,                           [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Thorium Brotherhood
				{ 18,  [ATLASLOOT_IT_ALLIANCE] = 224565, [PRICE_EXTRA_ITTYPE] = "timewarped:50" },                                -- Commendation of the Wintersaber Trainers
				{ 20,  227703,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Farstrider's Huntsblade
				{ 21,  227704,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Claymore of the Knight's Pledge
				{ 22,  227705,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Runed-Ice Dirk
				{ 23,  227706,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Doomreaper's Scythe
				{ 24,  227707,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Doomwail Reaper
				{ 25,  227709,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Kirin Tor Adept's Stave
				{ 26,  227711,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Tusked Branch of War
				{ 27,  227712,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Emberswirl Bulwark
				{ 28,  227717,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Sermons of the Naaru
				{ 29,  227714,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2000" },                              -- Gilded Drakecrest Shield
				{ 30,  227718,                           [PRICE_EXTRA_ITTYPE] = "timewarped:2500" },                              -- Bearded Branch of Lore
				{ 101, 234624,                           [PRICE_EXTRA_ITTYPE] = "timewarped:1500" },                              -- Longsword of the Knight's Pledge
				{ 103, "234862:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Ogre Captain's Armor
				{ 104, "224853:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Adventurer's Pith Helmet
				{ 105, "224854:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Holy Shroud
				{ 106, "224855:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Helm of Narv
				{ 107, "224856:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Mugthol's Helm
				{ 108, "224857:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Feet of the Lynx
				{ 109, "224858:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Coldstone Slippers
				{ 110, "224859:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Caverndeep Trudgers
				{ 111, "224860:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Boots of Avoidance
				{ 112, "225181:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Unearthed Bands
				{ 113, "225182:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Aristocratic Cuffs
				{ 114, "225183:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Slimescale Bracers
				{ 115, "225184:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Runed Golem Shackles
				{ 116, "225186:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Freezing Band
				{ 117, "225187:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:25", },                               -- Blackmetal Cape
				{ 118, "225188:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Lefty's Brass Knuckle
				{ 119, "225189:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Lightforged Blade
				{ 120, "225190:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Pendulum of Doom
				{ 121, "225191:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Gut Ripper
				{ 122, "225192:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Bow of Searing Arrows
				{ 123, "225193:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Elemental Mage Staff
				{ 124, "225194:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:35", },                               -- Redbeard Crest
				{ 125, "225195:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Axe of the Deep Woods
				{ 126, "225196:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Grimlok's Charge
				{ 127, "225197:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Crimson Shocker
				{ 128, "225198:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Warden Staff
				{ 129, "225199:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Flurry Axe
				{ 130, "225200:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:50", },                               -- Alcor's Sunrazor
				{ 201, "225201:11072",                   [PRICE_EXTRA_ITTYPE] = "timewarped:100", },                              -- Precisely Calibrated Rifle
			},
		},
	},
}

data["APEXISCRYSTALGEAR"]  = {
	name = AL["Apexis Crystal"].." "..AL["Vendors"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{
			name = string.format(AL["ilvl %d"], 650).." "..AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1,  128225, [PRICE_EXTRA_ITTYPE] = "apexis:20000" }, -- Empowered Apexis Fragment
				{ 3,  124554, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Hood
				{ 4,  124556, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Spaulders
				{ 5,  124560, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Cloak
				{ 6,  124551, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Tunic
				{ 7,  124550, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Bracers
				{ 8,  124553, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Gauntlets
				{ 9,  124557, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Girdle
				{ 10, 124555, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Leggings
				{ 11, 124552, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Treads
				{ 18, 124559, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Choker
				{ 19, 124558, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Ring
				{ 20, 124561, [PRICE_EXTRA_ITTYPE] = "apexis:5000" }, -- Baleful Trinket
				{ 22, 124562, [PRICE_EXTRA_ITTYPE] = "apexis:10000" }, -- Baleful Armament
			},
		},
		{
			name = AL["Miscellaneous"],
			[NORMAL_DIFF] = {
				{ 1,   123974, "mount",                                            [PRICE_EXTRA_ITTYPE] = "apexis:150000" },   -- Reins of the Corrupted Dreadwing
				{ 2,   116785, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Swift Frostwolf
				{ 3,   116665, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Armored Irontusk
				{ 4,   116775, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" }, -- Breezestrider Stallion
				{ 5,   116672, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Domesticated Razorback
				{ 6,   116664, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Dusty Rockhide
				{ 7,   116782, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Ironside Warwolf
				{ 8,   116768, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:500000000:apexis:5000" }, -- Mosshide Riverwallow
				{ 9,   116776, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" }, -- Pale Thorngrazer
				{ 10,  116772, "mount",                                            [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Shadowmane Charger
				{ 16,  128478, "pet1693",                                          [PRICE_EXTRA_ITTYPE] = "apexis:2000" },     -- Blazing Firehawk
				{ 17,  119146, "pet1458",                                          [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" }, -- Bone Wasp
				{ 18,  119149, "pet1430",                                          [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" }, -- Captured Forest Sproutling
				{ 19,  119142, "pet1450",                                          [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" }, -- Draenei Micro Defender
				{ 20,  119141, "pet1542",                                          [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" }, -- Frostwolf Pup
				{ 21,  119148, "pet1571",                                          [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" }, -- Indentured Albino River Calf
				{ 22,  119143, "pet1574",                                          [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" }, -- Son of Sethe
				{ 24,  127774, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },                                                         -- Gemcutter Module: Multistrike
				{ 26,  128441, [PRICE_EXTRA_ITTYPE] = "apexis:1000" },                                                         -- Contract: Solar Priest Vayx
				{ 27,  119821, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },                                                         -- Contract: Dawnseeker Rukaryx
				{ 29,  122283, [PRICE_EXTRA_ITTYPE] = "apexis:50000" },                                                        -- Rukhmar's Sacred Memory
				{ 101, 118673, [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:1000" },                                          -- Golden Visage of the Laughing Skull
				{ 102, 118672, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },                                          -- Bloody Visage of the Laughing Skul
				{ 103, 118671, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },                                          -- Frozen Visage of the Laughing Skull
				{ 104, 118674, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },                                          -- Visage of the Laughing Skull
				{ 106, 118666, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },                                                -- Arakkoa Elixir
				{ 107, 118665, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },                                                -- Exarch Elixir
				{ 108, 118664, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },                                                -- Frostwolf Elixir
				{ 109, 118668, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },                                                -- Laughing Skull Elixir
				{ 110, 118669, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },                                                -- Sha'tari Elixir
				{ 111, 118667, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },                                                -- Steamwheedle Elixir
			},
		},
	},
}

data["BOEWORLDEPICS"]      = {
	name = AL["BoE World Epics"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{ -- Warlords of Draenor
			name = EXPANSION_NAME5,
			[NORMAL_DIFF] = {
				{ 1,   118814 }, -- Berserker's Windwrap
				{ 2,   118812 }, -- Flamelicked Cloak of Kaufebyrd
				{ 3,   118816 }, -- Gorenscale Mesh Cloak
				{ 4,   118808 }, -- Highmaul Magi Scarf
				{ 5,   118810 }, -- Rinnila's Regal Cloak
				{ 16,  118893 }, -- Lylirra's Shining Circlet
				{ 17,  118889 }, -- Ephew's Enlightened Mantle
				{ 18,  118885 }, -- Gem-Inlaid Velvet Cinch
				{ 19,  118894 }, -- Toria's Perseverance
				{ 20,  118890 }, -- Studded Frostboar Leather Spaulders
				{ 21,  118886 }, -- Waistgirdle of the Mountain
				{ 22,  118895 }, -- Plume Adorned Headdress
				{ 23,  118891 }, -- Dunestalker's Mantle
				{ 24,  118887 }, -- Cloudcaller's Linked Belt
				{ 25,  118896 }, -- Helmet of Vile Indignation
				{ 26,  118892 }, -- Botani-Barbed Pauldrons
				{ 27,  118888 }, -- Ashelia's Adorned Waistguard
				{ 101, 118848 }, -- Battle Hardened Gorget
				{ 102, 118842 }, -- Dorian's Cipher Key
				{ 103, 118840 }, -- Firecrystal Chain
				{ 104, 118846 }, -- Gorget of Primal Might
				{ 105, 118844 }, -- Osseric's Ossified Chained Orb
				{ 106, 118864 }, -- Aryu's Puzzle Ring
				{ 107, 118862 }, -- Knobbly Ancient's Tendril
				{ 108, 118868 }, -- Ransacker's Ring of Plunder
				{ 109, 118866 }, -- Seal of Yen Ta
				{ 110, 118870 }, -- Signet of the Traitor General
				{ 116, 118878 }, -- Copeland's Clarity
				{ 117, 118880 }, -- Everburning Candle
				{ 118, 118884 }, -- Kyb's Foolish Perseverance
				{ 119, 118876 }, -- Lucky Double-Sided Coin
				{ 120, 118882 }, -- Scabbard of Kyanos
				{ 122, 118852 }, -- Erorus' Ledger of Trade
				{ 123, 118851 }, -- Genesaur Braid
				{ 124, 118874 }, -- Blackrock Bulwark
				{ 125, 118872 }, -- Disc of the Third Moon
			},
		},
		{ -- Mists of Pandaria
			name = EXPANSION_NAME4,
			[NORMAL_DIFF] = {
				{ 1,   90580 },                  -- Cristof's Crushing Cloak
				{ 2,   90589 },                  -- Dirl's Drafty Drape
				{ 3,   90586 },                  -- Dory's Pageantry
				{ 4,   90578 },                  -- Zom's Rain-Stained Cloak
				{ 5,   90573 },                  -- Wang's Unshakable Smile
				{ 6,   90587 },                  -- Natli's Fireheart Robe
				{ 7,   90574 },                  -- Etoshia's Elegant Gloves
				{ 8,   90588 },                  -- Rittsyn's Ruinblasters
				{ 9,   90585 },                  -- Vulajin's Vicious Breastplate
				{ 10,  90572 },                  -- Kilt of Pandaren Promises
				{ 11,  90570 },                  -- Legguards of Sleeting Arrows
				{ 12,  87695 },                  -- Treads of Edward the Odd
				{ 13,  90576 },                  -- Spaulders of the Scorned
				{ 14,  90577 },                  -- Boblet's Bouncing Hauberk
				{ 15,  90579 },                  -- Legplates of Durable Dreams
				{ 16,  90582 },                  -- Buc-Zakai Memento
				{ 17,  90583 },                  -- Don Guerrero's Glorious Choker
				{ 18,  90590 },                  -- Dorian's Necklace of Burgeoning Dreams
				{ 20,  90581 },                  -- Jan-Ho's Unwavering Seal
				{ 21,  90584 },                  -- Perculia's Peculiar Signet
				{ 22,  90591 },                  -- Ring of the Shipwrecked Prince
				{ 24,  90571 },                  -- Scroll of Whispered Secrets
				{ 25,  90575 },                  -- Sutiru's Brazen Bulwark
				{ 27,  88165, nil, nil, GetSpellInfo(921) }, -- Vine-Cracked Junkbox
				{ 28,  88149 },                  -- The Gloaming Blade
				{ 29,  88150 },                  -- Krol Scimitar
				{ 101, 90721 },                  -- Cournith Waterstrider's Silken Finery
				{ 102, 90725 },                  -- Gaarn's Leggings of Infestation
				{ 103, 90720 },                  -- Silent Leggings of the Ghostpaw
				{ 104, 90724 },                  -- Spriggin's Sproggin' Leggin'
				{ 105, 90723 },                  -- Arness's Scaled Leggings
				{ 106, 90719 },                  -- Go-Kan's Golden Trousers
				{ 107, 90722 },                  -- Torik-Ethis' Gilded Legplates
				{ 108, 90717 },                  -- Qu'nas' Apocryphal Legplates
				{ 109, 90718 },                  -- Torik-Ethis' Bloodied Legguards
				{ 116, 87650 },                  -- Fishsticker Crossbow
				{ 117, 87641 },                  -- Yaungol Battle Barrier
			},
		},
		{ -- Cataclysm
			name = EXPANSION_NAME3,
			[NORMAL_DIFF] = {
				{ 1,  67134 },                  -- Dory's Finery
				{ 2,  67140 },                  -- Drape of Inimitable Fate
				{ 3,  67131 },                  -- Ritssyn's Ruminous Drape
				{ 4,  67142 },                  -- Zom's Electrostatic Cloak
				{ 5,  67147 },                  -- Je'Tze's Sparkling Tiara
				{ 6,  67133 },                  -- Dizze's Whirling Robe
				{ 7,  67132 },                  -- Grips of the Failed Immortal
				{ 8,  67146 },                  -- Woundsplicer Handwraps
				{ 9,  67135 },                  -- Morrie's Waywalker Wrap
				{ 10, 67150 },                  -- Arrowsinger Legguards
				{ 11, 67148 },                  -- Kilt of Trollish Dreams
				{ 12, 67144 },                  -- Pauldrons of Edward the Odd
				{ 13, 67143 },                  -- Icebone Hauberk
				{ 14, 67141 },                  -- Corefire Legplates
				{ 16, 67138 },                  -- Buc-Zakai Choker
				{ 17, 67137 },                  -- Don Rodrigo's Fabulous Necklace
				{ 18, 67130 },                  -- Dorian's Lost Necklace
				{ 20, 67139 },                  -- Blauvelt's Family Crest
				{ 21, 67136 },                  -- Gilnean Ring of Ruination
				{ 22, 67129 },                  -- Signet of High Arcanist Savor
				{ 24, 67149 },                  -- Heartbound Tome
				{ 25, 67145 },                  -- Blockade's Lost Shield
				{ 27, 63349, nil, nil, GetSpellInfo(921) }, -- Flame-Scarred Junkbox
				{ 28, 68163 },                  -- The Twilight Blade
				{ 29, 68161 },                  -- Krol Decapitator
			},
		},
		{ -- Wrath of the Lich King
			name = EXPANSION_NAME2,
			[NORMAL_DIFF] = {
				{ 1,  44309 },                  -- Sash of Jordan
				{ 2,  44312 },                  -- Wapach's Spaulders of Solidarity
				{ 4,  44308 },                  -- Signet of Edward the Odd
				{ 5,  37835 },                  -- Je'Tze's Bell
				{ 16, 44310 },                  -- Namlak's Supernumerary Sticker
				{ 17, 44311 },                  -- Avool's Sword of Jin
				{ 18, 44313 },                  -- Zom's Crackling Bulwark
				{ 20, 43575, nil, nil, GetSpellInfo(921) }, -- Reinforced Junkbox
				{ 21, 43613 },                  -- The Dusk Blade
				{ 22, 43611 },                  -- Krol Cleaver
			},
		},
		{ -- The Burning Crusade
			name = EXPANSION_NAME1,
			[NORMAL_DIFF] = {
				{ 1,  31329 }, -- Lifegiving Cloak
				{ 2,  31340 }, -- Will of Edward the Odd
				{ 3,  31343 }, -- Kamaei's Cerulean Skirt
				{ 4,  31333 }, -- The Night Watchman
				{ 5,  31335 }, -- Kilt of Living Growth
				{ 6,  31330 }, -- Lightning Crown
				{ 7,  31328 }, -- Leggings of Beast Mastery
				{ 8,  31320 }, -- Chestguard of Exile
				{ 10, 31338 }, -- Charlotte's Ivy
				{ 11, 31321 }, -- Choker of Repentance
				{ 13, 31319 }, -- Band of Impenetrable Defenses
				{ 14, 31339 }, -- Lola's Eve
				{ 15, 31326 }, -- Truestrike Ring
				{ 16, 31331 }, -- The Night Blade
				{ 17, 31342 }, -- The Ancient Scepter of Sue-Min
				{ 18, 31336 }, -- Blade of Wizardry
				{ 19, 31332 }, -- Blinkstrike
				{ 20, 31318 }, -- Singing Crystal Axe
				{ 21, 31322 }, -- The Hammer of Destiny
				{ 22, 31334 }, -- Staff of Natural Fury
				{ 23, 31323 }, -- Don Santos' Famous Hunting Rifle
			},
		},
		{ -- Classic
			name = EXPANSION_NAME0,
			[NORMAL_DIFF] = {
				{ 1,   3475 }, -- Cloak of Flames
				{ 2,   14553 }, -- Sash of Mercy
				{ 3,   2245 }, -- Helm of Narv
				{ 4,   14552 }, -- Stockade Pauldrons
				{ 5,   14554 }, -- Cloudkeeper Legplates
				{ 7,   1443 }, -- Jeweled Amulet of Cainwyn
				{ 8,   14558 }, -- Lady Maye's Pendant
				{ 9,   2246 }, -- Myrmidon's Signet
				{ 10,  833 }, -- Lifestone
				{ 11,  14557 }, -- The Lion Horn of Stormwind
				{ 16,  14555 }, -- Alcor's Sunrazor
				{ 17,  811 }, -- Axe of the Deep Woods
				{ 18,  2243 }, -- Hand of Edward the Odd
				{ 19,  2244 }, -- Krol Blade
				{ 20,  1728 }, -- Teebu's Blazing Longsword
				{ 21,  1263 }, -- Brain Hacker
				{ 22,  2801 }, -- Blade of Hanna
				{ 23,  647 }, -- Destiny
				{ 24,  944 }, -- Elemental Mage Staff
				{ 25,  2099 }, -- Dwarven Hand Cannon
				{ 26,  1168 }, -- Skullflame Shield
				{ 101, 3075 }, -- Eye of Flame
				{ 102, 940 }, -- Robes of Insight
				{ 103, 14551 }, -- Edgemaster's Handguards
				{ 104, 17007 }, -- Stonerender Gauntlets
				{ 105, 14549 }, -- Boots of Avoidance
				{ 107, 1315 }, -- Lei of Lilies
				{ 108, 942 }, -- Freezing Band
				{ 109, 1447 }, -- Ring of Saviors
				{ 116, 2164 }, -- Gut Ripper
				{ 117, 2163 }, -- Shadowblade
				{ 118, 871 }, -- Flurry Axe
				{ 119, 810 }, -- Hammer of the Northern Wind
				{ 120, 809 }, -- Bloodrazor
				{ 121, 2291 }, -- Kang the Decapitator
				{ 122, 2915 }, -- Taran Icebreaker
				{ 123, 812 }, -- Glowing Brightwood Staff
				{ 124, 943 }, -- Warden Staff
				{ 125, 2824 }, -- Hurricane
				{ 126, 2100 }, -- Precisely Calibrated Boomstick
				{ 127, 1169 }, -- Blackskull Shield
				{ 128, 1979 }, -- Wall of the Dead
				{ 201, 867 }, -- Gloves of Holy Might
				{ 202, 1981 }, -- Icemail Jerkin
				{ 204, 1980 }, -- Underworld Band
				{ 216, 868 }, -- Ardent Custodian
				{ 217, 869 }, -- Dazzling Longsword
				{ 218, 870 }, -- Fiery War Axe
				{ 219, 1982 }, -- Nightblade
				{ 220, 873 }, -- Staff of Jordan
				{ 221, 2825 }, -- Bow of Searing Arrows
				{ 222, 1204 }, -- The Green Tower
			},
		},
	},
}

-- Challenge Mode Gear
data["CMGEAR"]             = {
	name = AL["Challenge Mode Gear"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{ -- Warlords of Draenor
			name = EXPANSION_NAME5,
			[NORMAL_DIFF] = {
				{ 1,  "ac8899" },    -- Challenge Warlord: Gold
				{ 2,  118408 },      -- Elemental Crescent
				{ 3,  118399 },      -- Sunblade
				{ 4,  118398 },      -- Soul Eater
				{ 5,  118395 },      -- Claws of Creation
				{ 6,  118396 },      -- Bloodmaw Gargoyle
				{ 7,  118397 },      -- Equus
				{ 8,  118405 },      -- Shifting Felblade
				{ 9,  118413 },      -- Flamegrinder
				{ 10, 118412 },      -- Greatsword of the Inferno
				{ 12, "ac8898", "mount171848" }, -- Challenge Warlord: Silver / Challenger's War Yeti
				{ 14, "ac8897" },    -- Challenge Warlord: Bronze
				{ 17, 118401 },      -- Arcana Shard Spire
				{ 18, 118402 },      -- Greatstaff of Infinite Knowledge
				{ 19, 118403 },      -- Dimension-Ripper's Staff
				{ 20, 118409 },      -- Cloudsong Glaive
				{ 21, 118404 },      -- Living Longbow
				{ 22, 118411 },      -- Crystal-Shot Longrifle
				{ 23, 118410 },      -- Tesseract Timepiece
				{ 24, 118407 },      -- Face of the Guardian
				{ 25, 118406 },      -- Furnace of the Great Machine
			},
		},
		{ -- Mists of Pandaria
			name = EXPANSION_NAME4,
			[NORMAL_DIFF] = {
				{ 1,  "setCMMoP:dk:n" },
				{ 3,  "setCMMoP:druid:n" },
				{ 5,  "setCMMoP:hunter:n" },
				{ 7,  "setCMMoP:mage:n" },
				{ 9,  "setCMMoP:monk:n" },
				{ 11, "setCMMoP:paladin:n" },
				{ 16, "setCMMoP:priest:n" },
				{ 18, "setCMMoP:rogue:n" },
				{ 20, "setCMMoP:shaman:n" },
				{ 22, "setCMMoP:warlock:n" },
				{ 24, "setCMMoP:warrior:n" },
			},
		},
	},
}

data["MOUNTS"]             = {
	name = AL["Mounts"],
	ContentType = COLLECTION_CONTENT,
	TableType = NORMAL_ITTYPE,
	items =
	{
		{ -- The War Within
			name = EXPANSION_NAME10,
			[ALLIANCE_DIFF] = {
				{ 1,   229947, "mount" },                                                -- Violet Goblin Shredder
				{ 2,   229955, "mount" },                                                -- Darkfuse Spy-Eye
				{ 3,   229953, "mount" },                                                -- Salvaged Goblin Gazillionaire's Flying Machine
				{ 4,   229941, "mount", [PRICE_EXTRA_ITTYPE] = "234741:25" },            -- Innovation Investigator
				{ 5,   229954, "mount", [PRICE_EXTRA_ITTYPE] = "234741:25" },            -- Margin Manipulator
				{ 6,   229949, "mount" },                                                -- Personalized Goblin S.C.R.A.P.per
				{ 7,   236960, "mount" },                                                -- Prototype A.S.M.R.
				{ 8,   223270, "mount" },                                                -- Alunira
				{ 9,   232639, "mount", [QUEST_EXTRA_ITTYPE] = 85811 },                  -- Thrayir, Eyes of the Siren
				{ 10,  237141, "mount" },                                                -- Enterprising Shreddertank
				{ 11,  224150, "mount", [QUEST_EXTRA_ITTYPE] = 83722 },                  -- Siesbarg
				{ 12,  229950, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Darkfuse Demolisher
				{ 13,  229974, "mount", [QUEST_EXTRA_ITTYPE] = 85243 },                  -- Delver's Gob-Trotter
				{ 14,  225548, "mount" },                                                -- Wick's Lead
				{ 15,  233064, "mount" },                                                -- Bronze Goblin Waveshredder
				{ 16,  223269, "mount" },                                                -- Machine Defense Unit 1-11
				{ 17,  229952, "mount", [PRICE_EXTRA_ITTYPE] = "234741:25" },            -- Asset Advocator
				{ 18,  223153, "mount", [PRICE_EXTRA_ITTYPE] = "225557:900" },           -- Reins of the Soaring Meaderbee
				{ 19,  221967, "mount" },                                                -- Crowd Pummeler 2-30
				{ 20,  235549, "mount", [ACH_EXTRA_ITTYPE] = 41533 },                    -- Crimson Shreddertank
				{ 21,  229940, "mount", [PRICE_EXTRA_ITTYPE] = "money:9712500" },        -- Flarendo the Furious
				{ 22,  221765, "mount" },                                                -- Stonevault Mechsuit
				{ 23,  231173, "mount", [ACH_EXTRA_ITTYPE] = 41286 },                    -- Junkmaestro's Magnetomech
				{ 24,  229956, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Mean Green Flying Machine
				{ 25,  223315, "mount" },                                                -- Beledar's Spawn
				{ 26,  235626, "mount" },                                                -- Keys to the Big G
				{ 27,  229418, "mount" },                                                -- Reins of the Trader's Gilded Brutosaur
				{ 28,  229948, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Blackwater Shredder Deluxe Mk 2
				{ 29,  229935, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Crimson Armored Growler
				{ 30,  219391, "mount", [QUEST_EXTRA_ITTYPE] = 81510 },                  -- Delver's Dirigible
				{ 101, 223318, "mount" },                                                -- Dauntless Imperial Lynx
				{ 102, 233489, "mount", [QUEST_EXTRA_ITTYPE] = 86485 },                  -- Prismatic Snapdragon
				{ 103, 229945, "mount", [PRICE_EXTRA_ITTYPE] = "money:6250000" },        -- Thunderdrum Misfire
				{ 104, 229946, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Ocher Delivery Rocket
				{ 105, 229348, "mount" },                                                -- Keys to Incognitro, the Indecipherable Felcycle
				{ 106, 224415, "mount", [ACH_EXTRA_ITTYPE] = 40438 },                    -- Ivory Goliathus
				{ 107, 235515, "mount", [ACH_EXTRA_ITTYPE] = 40953 },                    -- Jani's Trashpile
				{ 108, 234740, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Copper-Maned Quilen Reins
				{ 109, 224147, "mount" },                                                -- Reins of the Sureki Skyrazor
				{ 110, 229944, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- The Topskimmer Special
				{ 111, 225250, "mount" },                                                -- Startouched Furline
				{ 112, 233058, "mount", [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:10000" }, -- Soweezi's Vintage Waveshredder
				{ 113, 233286, "mount" },                                                -- Meeksi Brewthief
				{ 114, 232991, "mount", [ACH_EXTRA_ITTYPE] = 41133 },                    -- The Breaker's Song
				{ 115, 233285, "mount" },                                                -- Meeksi Teatuft
				{ 116, 235646, "mount", [PRICE_EXTRA_ITTYPE] = "tender:325" },           -- Shimmermist Free Runner
				{ 117, 229989, "mount", [ACH_EXTRA_ITTYPE] = 41128 },                    -- Vicious Electro Eel
				{ 118, 234721, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Ur'zul Fleshripper Bridle
				{ 119, 229924, "mount", [PRICE_EXTRA_ITTYPE] = "money:6250000" },        -- Darkfuse Chompactor
				{ 120, 229987, "mount", [ACH_EXTRA_ITTYPE] = 41032 },                    -- Prized Gladiator's Fel Bat
				{ 121, 224151, "mount" },                                                -- Reins of the Ascendant Skyrazor
				{ 122, 229936, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Violet Armored Growler
				{ 123, 235286, "mount" },                                                -- Sha-Warped Cloud Serpent
				{ 124, 223314, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Shackled Shadow
				{ 125, 229937, "mount" },                                                -- Blackwater Bonecrusher
				{ 126, 223501, "mount" },                                                -- Regurgitated Mole Reins
				{ 127, 234716, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Nightfall Skyreaver's Reins
				{ 128, 229957, "mount" },                                                -- Bilgewater Bombardier
				{ 129, 223276, "mount", [PRICE_EXTRA_ITTYPE] = "kej:2020" },             -- Widow's Undercrawler
				{ 130, 205208, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Sandy Shalewing
				{ 201, 234730, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Broodling of Sinestra
				{ 202, 228760, "mount", [ACH_EXTRA_ITTYPE] = 40976 },                    -- Reins of the Coldflame Tempest
				{ 203, 232624, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Timely Buzzbee
				{ 204, 235650, "mount", [PRICE_EXTRA_ITTYPE] = "tender:700" },           -- Pearlescent Butterfly
				{ 205, 235287, "mount" },                                                -- Sha-Warped Riding Tiger
				{ 206, 223158, "mount", [ACH_EXTRA_ITTYPE] = 40097 },                    -- Raging Cinderbee
				{ 207, 226357, "mount", [ACH_EXTRA_ITTYPE] = 20525 },                    -- Diamond Mechsuit
				{ 208, 233282, "mount" },                                                -- Meeksi Rufflefur
				{ 209, 223267, "mount", [ACH_EXTRA_ITTYPE] = 40702 },                    -- Swarmite Skyhunter
				{ 210, 222989, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Cyan Glowmite
				{ 211, 232901, "mount", [PRICE_EXTRA_ITTYPE] = "ancestrycoin:75" },      -- Lunar Launcher
				{ 212, 233283, "mount" },                                                -- Meeksi Softpaw
				{ 213, 224398, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Reins of the Frayfeather Hippogryph
				{ 214, 221753, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Smoldering Cinderbee
				{ 215, 229951, "mount" },                                                -- Venture Co-ordinator
				{ 216, 223317, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Vermillion Imperial Lynx
				{ 217, 223278, "mount", [PRICE_EXTRA_ITTYPE] = "kej:2020" },             -- Heritage Undercrawler
				{ 218, 235657, "mount", [PRICE_EXTRA_ITTYPE] = "tender:700" },           -- Ruby Butterfly
				{ 219, 232926, "mount" },                                                -- Love Witch's Sweeper
				{ 220, 223266, "mount", [ACH_EXTRA_ITTYPE] = 40232 },                    -- Reins of the Shadowed Swarmite
				{ 221, 223572, "mount", [ACH_EXTRA_ITTYPE] = 40307 },                    -- Reins of the Slatestone Ramolith
				{ 222, 233023, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" },           -- Silvermoon Sweeper
				{ 223, 226506, "mount", [PRICE_EXTRA_ITTYPE] = "tender:750" },           -- Hand of Reshkigaal
				{ 224, 231374, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Enchanted Spellweave Carpet
				{ 225, 224399, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Reins of the Amani Hunting Bear
				{ 226, 223586, "mount", [ACH_EXTRA_ITTYPE] = 40393 },                    -- Forged Gladiator's Fel Bat
				{ 227, 233284, "mount" },                                                -- Meeksi Rollingpaw
				{ 228, 217985, "mount", [PRICE_EXTRA_ITTYPE] = "residualMemories:20000" }, -- Remembered Golden Gryphon
				{ 229, 223264, "mount", [PRICE_EXTRA_ITTYPE] = "kej:3940" },             -- Aquamarine Swarmite
				{ 230, 223279, "mount", [PRICE_EXTRA_ITTYPE] = "kej:2020" },             -- Royal Court Undercrawler
				{ 301, 228751, "mount" },                                                -- Gigantic Grrloc
				{ 302, 230201, "mount" },                                                -- Chaos-Forged Wind Rider
				{ 303, 230184, "mount" },                                                -- Chaos-Forged Gryphon
				{ 304, 223571, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Shale Ramolith
				{ 305, 223505, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Crimson Mudnose
				{ 306, 230200, "mount" },                                                -- Chaos-Forged Dreadwing
				{ 307, 230185, "mount" },                                                -- Chaos-Forged Hippogryph
				{ 308, 223274, "mount", [PRICE_EXTRA_ITTYPE] = "kej:2815" },             -- Ferocious Jawcrawler
				{ 309, 227362, "mount" },                                                -- Golden Ashes of Al'ar
				{ 310, 233241, "mount" },                                                -- Hooktalon
				{ 311, 231297, "mount" },                                                -- Timbered Sky Snake
				{ 312, 233240, "mount" },                                                -- Polly Roger
				{ 313, 233020, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" },           -- Twilight Witch's Sweeper
				{ 314, 235344, "mount" },                                                -- Blazing Royal Fire Hawk
				{ 315, 233019, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" },           -- Sky Witch's Sweeper
				{ 316, 233354, "mount", [PRICE_EXTRA_ITTYPE] = "tender:500" },           -- Savage Alabaster Battle Turtle
				{ 317, 235556, "mount", [PRICE_EXTRA_ITTYPE] = "tender:575" },           -- Violet Darkmoon Charger
				{ 318, 223511, "mount", [ACH_EXTRA_ITTYPE] = 40396 },                    -- Vicious Skyflayer
				{ 319, 226041, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" },           -- Keg Leg's Radiant Crocolisk
				{ 320, 229128, "mount" },                                                -- Harmonious Salutations Bear
				{ 321, 226042, "mount" },                                                -- Plunderlord's Midnight Crocolisk
				{ 322, 233243, "mount" },                                                -- Silver Tidestallion
				{ 323, 235662, "mount", [PRICE_EXTRA_ITTYPE] = "tender:325" },           -- Emerald Snail
				{ 324, 226040, "mount" },                                                -- Plunderlord's Golden Crocolisk
				{ 325, 226044, "mount" },                                                -- Plunderlord's Weathered Crocolisk
				{ 326, 233242, "mount" },                                                -- Royal Seafeather
				{ 327, 235555, "mount", [PRICE_EXTRA_ITTYPE] = "tender:575" },           -- Lively Darkmoon Charger
				{ 328, 238829, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Radiant Imperial Lynx
				{ 329, 238897, "mount", [PRICE_EXTRA_ITTYPE] = "tender:550" },           -- Spring Harvesthog
				{ 330, 210141, "mount", [PRICE_EXTRA_ITTYPE] = "tender:325" },           -- Brown-Furred Spiky Bakar
				{ 401, 235711, "mount", [PRICE_EXTRA_ITTYPE] = "displacedCorruptedMementos:40000" }, -- Corruption of the Aspects
				{ 402, 223265, "mount" },                                                -- Nesting Swarmite
				{ 403, 235709, "mount", [ACH_EXTRA_ITTYPE] = 41966 },                    -- Ny'alothan Shadow Worm
				{ 404, 235712, "mount" },                                                -- Void-Crystal Panther
				{ 405, 235705, "mount" },                                                -- Void-Forged Stallion's Reins
				{ 406, 235700, "mount" },                                                -- Reins of the Void-Scarred Gryphon
				{ 407, 235706, "mount" },                                                -- Void-Scarred Pack Mother's Harness
				{ 408, 235707, "mount" },                                                -- Reins of the Void-Scarred Windrider
				{ 409, 211089, "mount" },                                                -- Felreaver Deathcycle
				{ 410, 174654, "mount", [ACH_EXTRA_ITTYPE] = 41929 },                    -- Black Serpent of N'Zoth
				{ 411, 174653, "mount" },                                                -- Mail Muncher
				{ 412, 174770, "mount", [PRICE_EXTRA_ITTYPE] = "displacedCorruptedMementos:20000" }, -- Wicked Swarmer
				{ 413, 238967, "mount" },                                                -- Molten Cormaera
				{ 414, 238941, "mount", [PRICE_EXTRA_ITTYPE] = "tender:700" },           -- Coldflame Cormaera
				{ 415, 236415, "mount", [PRICE_EXTRA_ITTYPE] = "tender:325" },           -- Reins of the Spotted Black Riding Goat
				{ 416, 239020, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:100" }, -- Tyrannotort's Treat
				{ 417, 245695, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Reins of the Moonlit Nightsaber
				{ 418, 245694, "mount", [PRICE_EXTRA_ITTYPE] = "timewarped:5000" },      -- Reins of the Ivory Savagemane
				{ 419, 246237, "mount", [ACH_EXTRA_ITTYPE] = 42212 },                    -- OC91 Chariot
				{ 420, 245936, "mount", [PRICE_EXTRA_ITTYPE] = "tender:325" },           -- Unarmored Deathtusk Felboar
				{ 421, 243596, "mount", [PRICE_EXTRA_ITTYPE] = "tender:575" },           -- Wailing Banshee's Charger
				{ 422, 243594, "mount" },                                                -- Forsaken's Grotesque Charger
				{ 423, 238739, "mount", [ACH_EXTRA_ITTYPE] = 41779 },                    -- Chrono Corsair
				{ 424, 243572, "mount", [PRICE_EXTRA_ITTYPE] = "tender:0" },             -- Grandmaster's Prophetic Board
				{ 425, 243591, "mount", [PRICE_EXTRA_ITTYPE] = "tender:700" },           -- Grandmaster's Royal Board
				{ 426, 250240, "mount", [ACH_EXTRA_ITTYPE] = 61017 },                    -- Phase-Lost Slateback
				{ 427, 238051, "mount", [QUEST_EXTRA_ITTYPE] = 91782 },                  -- Delver's Mana-Skimmer
				{ 428, 246160, "mount" },                                                -- Sthaarbs's Last Lunch
				{ 429, 242733, "mount", [QUEST_EXTRA_ITTYPE] = 90769 },                  -- Blue Barry
				{ 430, 246159, "mount" },                                                -- Translocated Gorger
				{ 501, 242734, "mount" },                                                -- Curious Slateback
				{ 502, 243061, "mount" },                                                -- Unbound Star-Eater
				{ 503, 237485, "mount", [ACH_EXTRA_ITTYPE] = 41980 },                    -- Terror of the Night
				{ 504, 242713, "mount", [QUEST_EXTRA_ITTYPE] = 88976 },                  -- Resplendent K'arroc
				{ 505, 242714, "mount", [ACH_EXTRA_ITTYPE] = 41597 },                    -- Umbral K'arroc
				{ 506, 246067, "mount" },                                                -- Pearlescent Krolusk
				{ 507, 246445, "mount", [QUEST_EXTRA_ITTYPE] = 91413 },                  -- Reins of the Royal Voidwing
				{ 508, 248248, "mount", [ACH_EXTRA_ITTYPE] = 41973 },                    -- Azure Void Flyer
				{ 509, 247822, "mount", [ACH_EXTRA_ITTYPE] = 42172 },                    -- Scarlet Void Flyer
				{ 510, 243157, "mount", [ACH_EXTRA_ITTYPE] = 42043 },                    -- Vicious Void Creeper
				{ 511, 232617, "mount", [ACH_EXTRA_ITTYPE] = 41049 },                    -- Astral Gladiator's Fel Bat
				{ 512, 186640, "mount" },                                                -- Vandal's Gearglider
				{ 513, 242728, "mount" },                                                -- The Bone Freezer
				{ 514, 242729, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:8125" }, -- Ruby Void Creeper
				{ 515, 237484, "mount", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:11375" }, -- Terror of the Wastes
				{ 516, 242730, "mount", [PRICE_EXTRA_ITTYPE] = "untetheredCoin:7" },     -- Acidic Void Creeper
				{ 517, 242717, "mount", [PRICE_EXTRA_ITTYPE] = "untetheredCoin:10" },    -- Lavender K'arroc
				{ 518, 246698, "mount" },                                                -- Sunwarmed Furline
				{ 519, 247792, "mount", [PRICE_EXTRA_ITTYPE] = "tender:0" },             -- High Shaman's Aerie Gryphon
				{ 520, 247793, "mount", [PRICE_EXTRA_ITTYPE] = "tender:650" },           -- Cinder-Plumed Highland Gryphon
				{ 521, 247795, "mount", [PRICE_EXTRA_ITTYPE] = "tender:325" },           -- Ornery Breezestrider
				{ 522, 248761, "mount" },                                                -- Brewfest Bomber
				{ 523, 246921, "mount", [PRICE_EXTRA_ITTYPE] = "tender:0" },             -- Legion Forged Elekk
				{ 524, 247723, "mount", [PRICE_EXTRA_ITTYPE] = "tender:700" },           -- The Headless Horseman's Hallowed Charger
				{ 525, 247721, "mount" },                                                -- The Headless Horseman's Ghoulish Charger
				{ 526, 250929, "mount", [PRICE_EXTRA_ITTYPE] = "tender:0" },             -- Prized Turkey
				{ 527, 250926, "mount", [PRICE_EXTRA_ITTYPE] = "tender:500" },           -- Highlands Gobbler
				-- { 329, 223570, "mount" }, -- Reins of the Ebonhide Ramolith (not yet available)
				-- { 321, 235554, "mount" }, -- Midnight Darkmoon Charger (not yet available)
				-- { 323, 235659, "mount" }, -- Midnight Butterfly (not yet available)
				-- { 325, 235557, "mount" }, -- Snowy Darkmoon Charger (not yet available)
				-- { 327, 235658, "mount" }, -- Spring Butterfly (not yet available)
				-- { 327, 186639, "mount" }, -- Xy Trustee's Gearglider (not yet available)
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 117, 229988, "mount", [ACH_EXTRA_ITTYPE] = 41129 },          -- Vicious Electro Eel
				{ 228, 217987, "mount", [PRICE_EXTRA_ITTYPE] = "residualMemories:20000" }, -- Remembered Wind Rider
				{ 318, 221813, "mount", [ACH_EXTRA_ITTYPE] = 40397 },          -- Vicious Skyflayer
				{ 510, 243159, "mount", [ACH_EXTRA_ITTYPE] = 42042 },          -- Vicious Void Creeper
			},
		},
		{ -- Dragonflight
			name = EXPANSION_NAME9,
			[ALLIANCE_DIFF] = {
				{ 1,   192601, "mount" },                             -- Loyal Magmammoth
				{ 2,   192761, "mount" },                             -- Tamed Skitterfly
				{ 3,   192762, "mount" },                             -- Azure Skitterfly
				{ 4,   192764, "mount" },                             -- Verdant Skitterfly
				{ 5,   192775, "mount" },                             -- Stormhide Salamanther
				{ 6,   192777, "mount" },                             -- Magmashell
				{ 7,   192779, "mount" },                             -- Seething Slug
				{ 8,   192784, "mount", [ACH_EXTRA_ITTYPE] = 16295 }, -- Shellack
				{ 9,   192786, "mount", [PRICE_EXTRA_ITTYPE] = "202173:1000" }, -- Slumbering Worldsnail Shell
				{ 10,  192791, "mount" },                             -- Plainswalker Bearer
				{ 11,  192799, "mount" },                             -- Lizi's Reins
				{ 12,  192800, "mount" },                             -- Skyskin Hornstrider
				{ 13,  192806, "mount", [ACH_EXTRA_ITTYPE] = 16355 }, -- Raging Magmammoth
				{ 14,  194034, "mount" },                             -- Renewed Proto-Drake
				{ 15,  194106, "mount" },                             -- Highland Drake
				{ 16,  194521, "mount" },                             -- Cliffside Wylderdrake
				{ 17,  194549, "mount" },                             -- Windborne Velocidrake
				{ 18,  194705, "mount" },                             -- Highland Drake
				{ 19,  198654, "mount", [ACH_EXTRA_ITTYPE] = 15834 }, -- Otterworldly Ottuk Carrier
				{ 20,  198808, "mount" },                             -- Guardian Vorquin
				{ 21,  198809, "mount" },                             -- Armored Vorquin Leystrider
				{ 22,  198810, "mount" },                             -- Swift Armored Vorquin
				{ 23,  198811, "mount" },                             -- Majestic Armored Vorquin
				{ 24,  198821, "mount" },                             -- Divine Kiss of Ohn'ahra
				{ 25,  198825, "mount" },                             -- Zenet Hatchling
				{ 26,  198870, "mount" },                             -- Otto
				{ 27,  198871, "mount" },                             -- Iskaara Trader's Ottuk
				{ 28,  198872, "mount" },                             -- Brown Scouting Ottuk
				{ 29,  198873, "mount" },                             -- Ivory Trader's Ottuk
				{ 30,  199412, "mount" },                             -- Hailstorm Armoredon
				{ 101, 200118, "mount" },                             -- Yellow Scouting Ottuk
				{ 102, 201425, "mount" },                             -- Yellow War Ottuk
				{ 103, 201426, "mount" },                             -- Brown War Ottuk
				{ 104, 201440, "mount" },                             -- Reins of the Liberated Slyvern
				{ 105, 201454, "mount" },                             -- Temperamental Skyclaw
				{ 106, 201702, "mount" },                             -- Crimson Vorquin
				{ 107, 201704, "mount" },                             -- Sapphire Vorquin
				{ 108, 201719, "mount" },                             -- Obsidian Vorquin
				{ 109, 201720, "mount" },                             -- Bronze Vorquin
				{ 110, 201788, "mount" },                             -- Vicious Sabertooth
				{ 111, 201789, "mount" },                             -- Vicious Sabertooth
				{ 112, 202086, "mount" },                             -- Crimson Gladiator's Drake
				{ 113, 192766, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" }, -- Amber Skitterfly
				{ 114, 221814, "mount", [PRICE_EXTRA_ITTYPE] = "tender:700" }, -- Pearlescent Goblin Wave Shredder
				{ 115, 210973, "mount", [PRICE_EXTRA_ITTYPE] = "lovetoken:270" }, -- Heartseeker Mana Ray
				{ 116, 223449, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" }, -- Kor'kron Warsaber
				{ 117, 223469, "mount", [PRICE_EXTRA_ITTYPE] = "tender:600" }, -- Sentinel War Wolf

			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 19, 198654, "mount", [ACH_EXTRA_ITTYPE] = 15833 }, -- Otterworldly Ottuk Carrier
			},
		},
		{ -- Shadowlands
			name = EXPANSION_NAME8,
			[NORMAL_DIFF] = {
				{ 1,   180263, "mount" }, -- Dreamlight Runestag
				{ 2,   180413, "mount" }, -- Shadeleaf Runestag
				{ 3,   180414, "mount" }, -- Wakener's Runestag
				{ 4,   180415, "mount" }, -- Winterborn Runestag
				{ 5,   180461, "mount" }, -- Horrid Dredwing
				{ 6,   180581, "mount" }, -- Hopecrusher Gargon
				{ 7,   180582, "mount" }, -- Endmire Flyer Tether
				{ 8,   180721, "mount" }, -- Enchanted Dreamlight Runestag
				{ 9,   180722, "mount" }, -- Enchanted Shadeleaf Runestag
				{ 10,  180723, "mount" }, -- Enchanted Wakener's Runestag
				{ 11,  180724, "mount" }, -- Enchanted Winterborn Runestag
				{ 12,  180725, "mount" }, -- Spinemaw Gladechewer
				{ 13,  180726, "mount" }, -- Pale Acidmaw
				{ 14,  180727, "mount" }, -- Shimmermist Runner
				{ 15,  180728, "mount" }, -- Swift Gloomhoof
				{ 16,  180729, "mount" }, -- Duskflutter Ardenmoth
				{ 17,  180730, "mount" }, -- Wild Glimmerfur Prowler
				{ 18,  180731, "mount" }, -- Wildseed Cradle
				{ 19,  180748, "mount" }, -- Silky Shimmermoth
				{ 20,  180761, "mount" }, -- Phalynx of Loyalty
				{ 21,  180762, "mount" }, -- Phalynx of Humility
				{ 22,  180763, "mount" }, -- Phalynx of Courage
				{ 23,  180764, "mount" }, -- Phalynx of Purity
				{ 24,  180765, "mount" }, -- Eternal Phalynx of Purity
				{ 25,  180766, "mount" }, -- Eternal Phalynx of Courage
				{ 26,  180767, "mount" }, -- Eternal Phalynx of Loyalty
				{ 27,  180768, "mount" }, -- Eternal Phalynx of Humility
				{ 28,  180772, "mount" }, -- Silverwind Larion
				{ 29,  180773, "mount" }, -- Sundancer
				{ 30,  180945, "mount" }, -- Crypt Gargon
				{ 101, 180948, "mount" }, -- Battle Gargon Vrednic
				{ 102, 181300, "mount" }, -- Gruesome Flayedwing
				{ 103, 181316, "mount" }, -- Silvertip Dredwing
				{ 104, 181317, "mount" }, -- Dauntless Duskrunner
				{ 105, 181815, "mount" }, -- Armored Bonehoof Tauralus
				{ 106, 192557, "mount" }, -- Restoration Deathwalker
				{ 107, 181818, "mount" }, -- Chewed Reins of the Callow Flayedwing
				{ 108, 181819, "mount" }, -- Marrowfang's Reins
				{ 109, 181820, "mount" }, -- Armored Chosen Tauralus
				{ 110, 181821, "mount" }, -- Armored Plaguerot Tauralus
				{ 111, 181822, "mount" }, -- Armored War-Bred Tauralus
				{ 112, 182074, "mount" }, -- Chosen Tauralus
				{ 113, 182075, "mount" }, -- Bonehoof Tauralus
				{ 114, 182076, "mount" }, -- Plaguerot Tauralus
				{ 115, 182077, "mount" }, -- War-Bred Tauralus
				{ 116, 182078, "mount" }, -- Bonesewn Fleshroc
				{ 117, 182079, "mount" }, -- Slime-Covered Reins of the Hulking Deathroc
				{ 118, 182080, "mount" }, -- Predatory Plagueroc
				{ 119, 182081, "mount" }, -- Reins of the Colossal Slaughterclaw
				{ 120, 182082, "mount" }, -- Lurid Bloodtusk
				{ 121, 191566, "mount" }, -- Elusive Emerald Hawkstrider
				{ 122, 182084, "mount" }, -- Gorespine
				{ 123, 182085, "mount" }, -- Blisterback Bloodtusk
				{ 124, 182209, "mount" }, -- Desire's Battle Gargon
				{ 125, 182332, "mount" }, -- Gravestone Battle Armor
				{ 126, 182589, "mount" }, -- Loyal Gorger
				{ 127, 182596, "mount" }, -- Rampart Screecher
				{ 128, 182614, "mount" }, -- Blanchy's Reins
				{ 129, 182650, "mount" }, -- Arboreal Gulper
				{ 130, 182717, "mount" }, -- Sintouched Deathwalker
				{ 201, 182954, "mount" }, -- Inquisition Gargon
				{ 202, 183052, "mount" }, -- Darkwarren Hardshell
				{ 203, 183053, "mount" }, -- Umbral Scythehorn
				{ 204, 183518, "mount" }, -- Court Sinrunner
				{ 205, 183615, "mount" }, -- Warstitched Darkhound
				{ 206, 183617, "mount" }, -- Chittering Animite
				{ 207, 183618, "mount" }, -- Highwind Darkmane
				{ 208, 183715, "mount" }, -- Sinfall Gargon
				{ 209, 183740, "mount" }, -- Gilded Prowler
				{ 210, 183741, "mount" }, -- Ascended Skymane
				{ 211, 183798, "mount" }, -- Silessa's Battle Harness
				{ 212, 183800, "mount" }, -- Amber Ardenmoth
				{ 213, 183801, "mount" }, -- Vibrant Flutterwing
				{ 214, 183937, "mount" }, -- Sinful Gladiator's Soul Eater
				{ 215, 184013, "mount" }, -- Vicious War Spider
				{ 216, 184014, "mount" }, -- Vicious War Spider
				{ 217, 184062, "mount" }, -- Gnawed Reins of the Battle-Bound Warhound
				{ 218, 184160, "mount" }, -- Bulbous Necroray
				{ 219, 184161, "mount" }, -- Infested Necroray
				{ 220, 184162, "mount" }, -- Pestilent Necroray
				{ 221, 184166, "mount" }, -- Corridor Creeper
				{ 222, 184167, "mount" }, -- Mawsworn Soulhunter
				{ 223, 184168, "mount" }, -- Bound Shadehound
				{ 224, 184183, "mount" }, -- Voracious Gorger
				{ 225, 185973, "mount" }, -- Chain of Bahmethra
				{ 226, 185996, "mount" }, -- Harvester's Dredwing Saddle
				{ 227, 186000, "mount" }, -- Legsplitter War Harness
				{ 228, 186103, "mount" }, -- Undying Darkhound's Harness
				{ 229, 186177, "mount" }, -- Unchained Gladiator's Soul Eater
				{ 230, 186178, "mount" }, -- Vicious War Gorm
				{ 301, 186179, "mount" }, -- Vicious War Gorm
				{ 302, 186469, "mount" }, -- Illidari Doomhawk
				{ 303, 186476, "mount" }, -- Sinfall Gravewing
				{ 304, 186477, "mount" }, -- Pale Gravewing
				{ 305, 186478, "mount" }, -- Obsidian Gravewing
				{ 306, 186479, "mount" }, -- Mastercraft Gravewing
				{ 307, 186480, "mount" }, -- Battle-Hardened Aquilon
				{ 308, 186482, "mount" }, -- Elysian Aquilon
				{ 309, 186483, "mount" }, -- Forsworn Aquilon
				{ 310, 186485, "mount" }, -- Ascendant's Aquilon
				{ 311, 186487, "mount" }, -- Maldraxxian Corpsefly Harness
				{ 312, 186488, "mount" }, -- Regal Corpsefly Harness
				{ 313, 186489, "mount" }, -- Lord of the Corpseflies
				{ 314, 186490, "mount" }, -- Battlefield Swarmer Harness
				{ 315, 191290, "mount" }, -- Eternal Gladiator's Soul Eater
				{ 316, 186492, "mount" }, -- Summer Wilderling Harness
				{ 317, 186493, "mount" }, -- Ardenweald Wilderling Harness
				{ 318, 186494, "mount" }, -- Autumnal Wilderling Harness
				{ 319, 186495, "mount" }, -- Winter Wilderling Harness
				{ 320, 186637, "mount" }, -- Tazavesh Gearglider
				{ 321, 186638, "mount" }, -- Cartel Master's Gearglider
				{ 322, 190766, "mount" }, -- Spectral Mawrat's Tail
				{ 323, 191123, "mount" }, -- Grimhowl's Face Axe
				{ 324, 186641, "mount" }, -- Tamed Mauler Harness
				{ 325, 186642, "mount" }, -- Vengeance's Reins
				{ 326, 186643, "mount" }, -- Reins of the Wanderer
				{ 327, 186644, "mount" }, -- Beryl Shardhide
				{ 328, 186645, "mount" }, -- Crimson Shardhide
				{ 329, 186646, "mount" }, -- Darkmaul
				{ 330, 186647, "mount" }, -- Amber Shardhide
				{ 401, 186648, "mount" }, -- Soaring Razorwing
				{ 402, 186649, "mount" }, -- Fierce Razorwing
				{ 403, 186651, "mount" }, -- Dusklight Razorwing
				{ 404, 186652, "mount" }, -- Garnet Razorwing
				{ 405, 186653, "mount" }, -- Bracer of Hrestimorak
				{ 406, 186654, "mount" }, -- Bracelet of Salaranga
				{ 407, 186655, "mount" }, -- Mawsworn Charger's Reins
				{ 408, 186656, "mount" }, -- Sanctum Gloomcharger's Reins
				{ 409, 186657, "mount" }, -- Soulbound Gloomcharger's Reins
				{ 410, 186659, "mount" }, -- Fallen Charger's Reins
				{ 411, 186713, "mount" }, -- Nilganihmaht Control Ring
				{ 412, 187183, "mount" }, -- Rampaging Mauler
				{ 413, 187525, "mount" }, -- Soultwisted Deathwalker
				{ 414, 187595, "mount" }, -- Favor of the Val'sharah Hippogryph
				{ 415, 187629, "mount" }, -- Heartlight Stone
				{ 416, 187630, "mount" }, -- Curious Crystalsniffer
				{ 417, 187631, "mount" }, -- Darkened Vombata
				{ 418, 187632, "mount" }, -- Adorned Vombata
				{ 419, 187638, "mount" }, -- Deathrunner
				{ 420, 187639, "mount" }, -- Pale Regal Cervid
				{ 421, 187640, "mount" }, -- Anointed Protostag Reins
				{ 422, 187641, "mount" }, -- Reins of the Sundered Zerethsteed
				{ 423, 187642, "mount" }, -- Vicious Warstalker
				{ 424, 187644, "mount" }, -- Vicious Warstalker
				{ 425, 187660, "mount" }, -- Vespoid Flutterer
				{ 426, 187663, "mount" }, -- Bronzewing Vespoid
				{ 427, 187664, "mount" }, -- Forged Spiteflyer
				{ 428, 187665, "mount" }, -- Buzz
				{ 429, 187666, "mount" }, -- Desertwing Hunter
				{ 430, 187667, "mount" }, -- Mawdapted Raptora
				{ 501, 187668, "mount" }, -- Raptora Swooper
				{ 502, 187669, "mount" }, -- Serenade
				{ 503, 187670, "mount" }, -- Bronze Helicid
				{ 504, 187671, "mount" }, -- Unsuccessful Prototype Fleetpod
				{ 505, 187672, "mount" }, -- Scarlet Helicid
				{ 506, 187673, "mount" }, -- Cryptic Aurelid
				{ 507, 187675, "mount" }, -- Shimmering Aurelid
				{ 508, 187676, "mount" }, -- Deepstar Polyp
				{ 509, 187677, "mount" }, -- Genesis Crawler
				{ 510, 187678, "mount" }, -- Tarachnid Creeper
				{ 511, 187679, "mount" }, -- Ineffable Skitterer
				{ 512, 187680, "mount" }, -- Vicious War Croaker
				{ 513, 187681, "mount" }, -- Vicious War Croaker
				{ 514, 187682, "mount" }, -- Wastewarped Deathwalker
				{ 515, 187683, "mount" }, -- Goldplate Bufonid
				{ 516, 188674, "mount" }, -- Mage-Bound Spelltome
				{ 517, 188696, "mount" }, -- Sturdy Soulsteel Mawrat Harness
				{ 518, 188700, "mount" }, -- Sturdy Silver Mawrat Harness
				{ 519, 188736, "mount" }, -- Sturdy Gilded Mawrat Harness
				{ 520, 188808, "mount" }, -- Patient Bufonid
				{ 521, 188809, "mount" }, -- Prototype Leaper
				{ 522, 188810, "mount" }, -- Russet Bufonid
				{ 523, 189507, "mount" }, -- Cosmic Gladiator's Soul Eater
				{ 524, 190170, "mount" }, -- Jigglesworth, Sr.
				{ 525, 190580, "mount" }, -- Heartbond Lupine
				{ 526, 190581, "mount" }, -- Nether-Gorged Greatwyrm
				{ 527, 190765, "mount" }, -- Iska's Mawrat Leash
				{ 528, 190768, "mount" }, -- Fractal Cypher of the Zereth Overseer
				{ 529, 190771, "mount" }, -- Fractal Cypher of the Carcinized Zerethsteed
			},
		},
		{ -- Achievements
			name = AL["Achievements"],
			CoinTexture = "Achievement",
			[NORMAL_DIFF] = {
				-- Alliance
				{ 1,   93385,  "ac7928" }, -- Grand Gryphon
				{ 2,   120968, "ac9909" }, -- Chauffeured Chopper
				{ 3,   44843,  "ac2536" }, -- Blue Dragonhawk, Mountain o' Mounts
				{ 4,   89785,  "ac6828" }, -- Pandaren Kite String, Pandaren Ambassador
				{ 5,   44223,  "ac614" }, -- Reins of the Black War Bear, For the Alliance!
				{ 6,   98259,  "ac8304" }, -- Armored Blue Dragonhawk, Mount Parade
				{ 7,   62298,  "ac4912" }, -- Reins of the Golden King
				{ 8,   69226,  "ac9598" }, -- Felfirehawk
				{ 9,   91802,  "ac7860" }, -- Jade Pandaren Kite String
				{ 10,  70909,  "ac5328" }, -- Reins of the Vicious War Steed
				-- Horde
				{ 16,  93386,  "ac7929" }, -- Grand Wyvern2
				{ 17,  122703, "ac9909" }, -- Chauffeured Chopper
				{ 18,  44842,  "ac2537" }, -- Red Dragonhawk2
				{ 19,  81559,  "ac6827" }, -- Pandaren Kite String2
				{ 20,  44224,  "ac619" }, -- Reins of the Black War Bear2
				{ 21,  98104,  "ac8302" }, -- Armored Red Dragonhawk2
				{ 22,  67107,  "ac5492" }, -- Reins of the Kor'kron Annihilator2
				{ 23,  69226,  "ac9599" }, -- Felfirehawk2
				{ 24,  91802,  "ac7862" }, -- Jade Pandaren Kite String2
				{ 25,  70910,  "ac5325" }, -- Horn of the Vicious War Wolf2

				{ 12,  87769,  "ac6927" }, -- Reins of the Crimson Cloud Serpent
				{ 13,  87773,  "ac6932" }, -- Reins of the Heavenly Crimson Cloud Serpent
				{ 14,  93662,  "ac8124" }, -- Reins of the Armored Skyscreamer
				{ 15,  104208, "ac8454" }, -- Reins of Galakras

				{ 27,  44178,  "ac2143" }, -- Reins of the Albino Drake
				{ 28,  77068,  "ac6169" }, -- Reins of the Twilight Harbinger
				{ 29,  44160,  "ac2136" }, -- Reins of the Red Proto-Drake
				{ 101, 128282, "ac10110" }, -- Warmongering Gladiator's Felblood Gronnling
				{ 102, 44177,  "ac2144" }, -- Reins of the Violet Proto-Drake
				{ 116, 45801,  "ac2958" }, -- Reins of the Ironbound Proto-Drake
				{ 117, 45802,  "ac2957" }, -- Reins of the Rusted Proto-Drake
				{ 118, 51954,  "ac4602" }, -- Reins of the Bloodbathed Frostbrood Vanquisher
				{ 119, 51955,  "ac4603" }, -- Reins of the Icebound Frostbrood Vanquisher
				{ 104, 62900,  "ac4845" }, -- Reins of the Volcanic Stone Drake
				{ 105, 62901,  "ac4853" }, -- Reins of the Drake of the East Wind
				{ 106, 69213,  "ac5866" }, -- Flameward Hippogryph
				{ 107, 69230,  "ac5828" }, -- Corrupted Egg of Millagazor
				{ 109, 63125,  "ac4988" }, -- Reins of the Dark Phoenix
				{ 110, 85666,  "ac6682" }, -- Reins of the Thundering Jade Cloud Serpent
				{ 111, 118676, "ac9713" }, -- Reins of the Emerald Drake
				{ 112, 115484, "ac9550" }, -- Core Hound Chain
				{ 113, 116383, "ac8985" }, -- Gorestrider Gronnling
				{ 121, 127140, "ac10149" }, -- Infernal Direwolf
				{ 122, 116666, "ac9669" }, -- Blacksteel Battleboar
				{ 123, 116668, "ac9539" }, -- Armored Frostboar
				{ 124, 116670, "ac9396" }, -- Frostplains Battleboar
				{ 125, 116781, "ac9540" }, -- Armored Frostwolf
				{ 126, 116791, "ac8898" }, -- Challenger's War Yeti
				{ 127, 98618,  "ac8345" }, -- Hearthsteed
			},
		},
		{ -- Faction
			name = AL["Factions"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				-- Stormwind , Classic
				{ 1,   "f72rep5" },
				{ 2,   18776,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Palomino
				{ 3,   18777,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Brown Steed
				{ 4,   18778,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift White Steed
				{ 5,   25473,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Blue Gryphon
				{ 6,   25527,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Red Gryphon
				{ 7,   25528,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Green Gryphon
				{ 8,   25529,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Purple Gryphon
				{ 9,   2411,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Black Stallion Bridle
				{ 10,  2414,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Pinto Bridle
				{ 11,  5655,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Chestnut Mare Bridle
				{ 12,  5656,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Brown Horse Bridle
				{ 13,  25470,      "mount", [PRICE_EXTRA_ITTYPE] = "money:500000" }, -- Golden Gryphon
				{ 14,  25471,      "mount", [PRICE_EXTRA_ITTYPE] = "money:500000" }, -- Ebon Gryphon
				{ 15,  25472,      "mount", [PRICE_EXTRA_ITTYPE] = "money:500000" }, -- Snowy Gryphon
				{ 16,  102514,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Reins of the Vicious Warsaber
				{ 17,  116777,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Ram
				{ 18,  124089,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Mechanostrider
				{ 19,  140350,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Elekk
				{ 20,  142234,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Bear
				{ 21,  142237,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Lion
				{ 22,  143648,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Turtle
				{ 23,  140353,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious Gilnean Warhorse
				{ 24,  116789,     "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000000" }, -- Champion's Treadblade, alliance only
				-- Wintersaber Trainers, Classic
				{ 26,  "f589rep8" },
				{ 27,  13086,      "mount" }, -- Reins of the Winterspring Frostsaber
				-- Ironforge, Classic
				{ 101, "f47rep5" },
				{ 102, 18785,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift White Ram
				{ 103, 18786,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Brown Ram
				{ 104, 18787,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Gray Ram
				{ 105, 5864,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Gray Ram
				{ 106, 5872,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Brown Ram
				{ 107, 5873,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- White Ram
				-- Gnomeregan, Classic
				{ 109, "f54rep5" },
				{ 110, 18772,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Green Mechanostrider
				{ 111, 18773,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift White Mechanostrider
				{ 112, 18774,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Yellow Mechanostrider
				{ 113, 8563,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Red Mechanostrider
				{ 114, 8595,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Blue Mechanostrider
				{ 115, 13321,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Green Mechanostrider
				{ 116, 13322,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Unpainted Mechanostrider
				-- Darnassus, Classic
				{ 118, "f69rep5" },
				{ 119, 18766,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Swift Frostsaber
				{ 120, 18767,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Swift Mistsaber
				{ 121, 18902,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Swift Stormsaber
				{ 122, 8632,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Spotted Frostsaber
				{ 123, 47100,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Striped Dawnsaber
				{ 124, 8631,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Striped Frostsaber
				{ 125, 8629,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Striped Nightsaber
				-- Exodar, BC
				{ 201, "f930rep5" },
				{ 202, 29745,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Great Blue Elekk
				{ 203, 29746,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Great Green Elekk
				{ 204, 29747,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Great Purple Elekk
				{ 205, 28481,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Brown Elekk
				{ 206, 29744,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Gray Elekk
				{ 207, 29743,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Purple Elekk
				-- Kurenai, BC
				{ 216, "f978rep8" },
				{ 217, 29227,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Cobalt War Talbuk
				{ 218, 29229,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Silver War Talbuk
				{ 219, 29230,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Tan War Talbuk
				{ 220, 29231,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the White War Talbuk
				{ 221, 31830,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the Cobalt Riding Talbuk
				{ 222, 31832,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the Silver Riding Talbuk
				{ 223, 31834,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the Tan Riding Talbuk
				{ 224, 31836,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the White Riding Talbuk
				-- Kirin Tor, WotLK
				{ 301, "f1090rep5" },
				{ 302, 44225,      "mount", [PRICE_EXTRA_ITTYPE] = "money:7500000" }, -- Reins of the Armored Brown Bear
				{ 303, 44689,      "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" }, -- Armored Snowy Gryphon
				{ 304, 44230,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Wooly Mammoth
				{ 305, 44235,      "mount", [PRICE_EXTRA_ITTYPE] = "money:200000000" }, -- Reins of the Traveler's Tundra Mammoth
				-- The Sons of Hodir, WotLK
				{ 307, "f1119rep7" },
				{ 308, 43958,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000000" }, -- Reins of the Ice Mammoth
				{ 309, 43961,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Grand Ice Mammoth
				-- The Silver Covenant, WotLK
				{ 311, "f1094rep8" },
				{ 312, 46813,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:150" }, -- Silver Covenant Hippogryph
				{ 313, 46815,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Quel'dorei Steed
				-- Argent Tournament, WotLK
				{ 316, "f1106rep5" },
				{ 317, 45591,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Darnassian Nightsaber
				{ 318, 45590,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Exodar Elekk
				{ 319, 45589,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Gnomeregan Mechanostrider
				{ 320, 45586,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Ironforge Ram
				{ 321, 45125,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Stormwind Steed
				{ 322, 46745,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Great Red Elekk
				{ 323, 46752,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Swift Gray Steed
				{ 324, 46744,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Swift Moonsaber
				{ 325, 46748,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Swift Violet Ram
				{ 326, 46747,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Turbostrider
				-- Gilneas, Cata
				{ 401, "f1134rep5" },
				{ 402, 73839,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Mountain Horse
				{ 403, 73838,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Mountain Horse
				-- Baradin's Wardens, Cata
				{ 405, "f1177rep8" },
				{ 406, 63039,      "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:200" }, -- Reins of the Drake of the West Wind
				{ 407, 64998,      "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:165" }, -- Reins of the Spectral Steed
				-- Operation: Shieldwall, MoP
				{ 409, "f1376rep8" },
				{ 410, 93168,      "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" }, -- Grand Armored Gryphon
				{ 411, 93385,      "mount" },                              -- Grand Gryphon1, reward from quest: The Silence (32455)
				-- Kirin Tor Offensive, MoP
				{ 413, "f1387rep8" },
				{ 414, 95564,      "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Golden Primal Direhorn
				-- Tushui Pandaren, MoP
				{ 416, "f1353rep5" },
				{ 417, 82811,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Red Dragon Turtle
				{ 418, 87801,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Green Dragon Turtle
				{ 419, 87802,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Black Dragon Turtle
				{ 420, 87803,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Blue Dragon Turtle
				{ 421, 87804,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Brown Dragon Turtle
				{ 422, 87805,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Purple Dragon Turtle
				{ 423, 82765,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Green Dragon Turtle
				{ 424, 87795,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Black Dragon Turtle
				{ 425, 87796,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Blue Dragon Turtle
				{ 426, 87797,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Brown Dragon Turtle
				{ 427, 87799,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Purple Dragon Turtle
				{ 428, 87800,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Red Dragon Turtle
				-- Council of Exarchs, WoD
				{ 501, "f1731rep8" },
				{ 502, 116664,     "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Dusty Rockhide
				-- Sha'tari Defense, WoD
				{ 504, "f1710rep8" },
				{ 505, 116665,     "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Armored Irontusk
				-- Wrynn's Vanguard, WoD
				{ 507, "f1682rep8" },
				{ 508, 116776,     "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" }, -- Pale Thorngrazer
				-- Hand of the Prophet
				{ 510, "f1847rep8" },
				{ 511, 128527,     "mount", [PRICE_EXTRA_ITTYPE] = "money:25000000" }, -- Deathtusk Felboar
			},
			[HORDE_DIFF] = {
				-- Orgrimmar, Classic
				{ 1,   "f76rep5" },
				{ 2,   18796,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Horn of the Swift Brown Wolf
				{ 3,   18797,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Horn of the Swift Timber Wolf
				{ 4,   18798,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Horn of the Swift Gray Wolf
				{ 5,   1132,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Horn of the Timber Wolf
				{ 6,   5665,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Horn of the Dire Wolf
				{ 7,   5668,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Horn of the Brown Wolf
				{ 8,   46099,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Horn of the Black Wolf
				{ 9,   25477,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Red Wind Rider
				{ 10,  25531,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Green Wind Rider
				{ 11,  25532,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Yellow Wind Rider
				{ 12,  25533,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Purple Wind Rider
				{ 13,  25474,      "mount", [PRICE_EXTRA_ITTYPE] = "money:500000" }, -- Tawny Wind Rider
				{ 14,  25475,      "mount", [PRICE_EXTRA_ITTYPE] = "money:500000" }, -- Blue Wind Rider
				{ 15,  25476,      "mount", [PRICE_EXTRA_ITTYPE] = "money:500000" }, -- Green Wind Rider
				{ 16,  116778,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Raptor
				{ 17,  124540,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Kodo
				{ 18,  102533,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Reins of the Vicious Skeletal Warhorse
				{ 19,  140348,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious Warstrider
				{ 20,  140354,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Trike
				{ 21,  142235,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Bear
				{ 22,  142437,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Scorpion
				{ 23,  143649,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Vicious War Turtle
				{ 24,  143864,     "mount", [PRICE_EXTRA_ITTYPE] = "vicioussaddle:1" }, -- Reins of the Prestigious War Wolf
				-- Darkspear Trolls, Classic
				{ 26,  "f530rep8" },
				{ 27,  46102,      "mount", }, -- Whistle of the Venomhide Ravasaur
				-- Thunder Bluff, Classic
				{ 101, "f81rep5" },
				{ 102, 18793,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Great White Kodo
				{ 103, 18794,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Great Brown Kodo
				{ 104, 18795,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Great Gray Kodo
				{ 105, 15277,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Gray Kodo
				{ 106, 15290,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Brown Kodo
				{ 107, 46100,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- White Kodo
				-- Darkspear Trolls, (Durotar), Classic
				{ 109, "f530rep5" },
				{ 110, 18788,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Blue Raptor
				{ 111, 18789,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Olive Raptor
				{ 112, 18790,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Orange Raptor
				{ 113, 8588,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Whistle of the Emerald Raptor
				{ 114, 8591,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Whistle of the Turquoise Raptor
				{ 115, 8592,       "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Whistle of the Violet Raptor
				-- Undercity, Classic
				{ 116, "f68rep5" },
				{ 117, 13334,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Green Skeletal Warhorse
				{ 118, 18791,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Purple Skeletal Warhorse
				{ 119, 47101,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Ochre Skeletal Warhorse
				{ 120, 13331,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Red Skeletal Horse
				{ 121, 13332,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Blue Skeletal Horse
				{ 122, 13333,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Brown Skeletal Horse
				{ 123, 46308,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Black Skeletal Horse
				-- Silvermoon City, BC
				{ 201, "f911rep5" },
				{ 202, 28936,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Pink Hawkstrider
				{ 203, 29223,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Green Hawkstrider
				{ 204, 29224,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Swift Purple Hawkstrider
				{ 205, 28927,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Red Hawkstrider
				{ 206, 29220,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Blue Hawkstrider
				{ 207, 29221,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Black Hawkstrider
				{ 208, 29222,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Purple Hawkstrider
				-- The Mag'har, BC
				{ 216, "f941rep8" },
				{ 217, 31829,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the Cobalt Riding Talbuk
				{ 218, 29102,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Cobalt War Talbuk
				{ 219, 31831,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the Silver Riding Talbuk
				{ 220, 29104,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Silver War Talbuk
				{ 221, 31833,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the Tan Riding Talbuk
				{ 222, 29105,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Tan War Talbuk
				{ 223, 31835,      "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" }, -- Reins of the White Riding Talbuk
				{ 224, 29103,      "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the White War Talbuk
				-- Kirin Tor, WotLK
				{ 301, "f1090rep5" },
				{ 302, 44226,      "mount", [PRICE_EXTRA_ITTYPE] = "money:7500000" }, -- Reins of the Armored Brown Bear
				{ 303, 44231,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Wooly Mammoth
				{ 304, 44234,      "mount", [PRICE_EXTRA_ITTYPE] = "money:200000000" }, -- Reins of the Traveler's Tundra Mammoth
				{ 305, 44690,      "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" }, -- Armored Blue Wind Rider
				-- The Sons of Hodir, WotLK
				{ 307, "f1119rep7" },
				{ 308, 44080,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000000" }, -- Reins of the Ice Mammoth
				{ 309, 44086,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Grand Ice Mammoth
				-- The Sunreavers, WotLK
				{ 311, "f1124rep8" },
				{ 312, 46816,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:150" }, -- Sunreaver Hawkstrider
				{ 313, 46814,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Sunreaver Dragonhawk
				-- Argent Tournament, WotLK
				{ 316, "f1106rep5" },
				{ 317, 45593,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Darkspear Raptor
				{ 318, 45597,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Forsaken Warhorse
				{ 319, 46750,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Great Golden Kodo
				{ 320, 45595,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Orgrimmar Wolf
				{ 321, 45596,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Silvermoon Hawkstrider
				{ 322, 46749,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Swift Burgundy Wolf
				{ 323, 46743,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Swift Purple Raptor
				{ 324, 46751,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Swift Red Hawkstrider
				{ 325, 45592,      "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Thunder Bluff Kodo
				{ 326, 46746,      "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- White Skeletal Warhorse
				-- Bilgewater Cartel, Cata
				{ 401, "f1133rep5" },
				{ 402, 62462,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Goblin Turbo-Trike Key
				{ 403, 62461,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Goblin Trike Key
				-- Hellscream's Reach, Cata
				{ 405, "f1178rep8" },
				{ 406, 65356,      "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:200" }, -- Reins of the Drake of the West Wind
				{ 407, 64999,      "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Spectral Wolf
				-- Dominance Offensive, MoP
				{ 409, "f1375rep8" },
				{ 410, 93169,      "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" }, -- Grand Armored Wyvern
				-- Sunreaver Onslaught, MoP
				{ 412, "f1388rep8" },
				{ 413, 95565,      "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Crimson Primal Direhorn
				-- Huojin Pandaren, MoP
				{ 416, "f1352rep5" },
				{ 417, 82811,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Red Dragon Turtle
				{ 418, 87801,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Green Dragon Turtle
				{ 419, 87802,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Black Dragon Turtle
				{ 420, 87803,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Blue Dragon Turtle
				{ 421, 87804,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Brown Dragon Turtle
				{ 422, 87805,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Purple Dragon Turtle
				{ 423, 82765,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Green Dragon Turtle
				{ 424, 87795,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Black Dragon Turtle
				{ 425, 87796,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Blue Dragon Turtle
				{ 426, 87797,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Brown Dragon Turtle
				{ 427, 87799,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Purple Dragon Turtle
				{ 428, 87800,      "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Red Dragon Turtle
				-- Swift Frostwolf, WoD
				{ 501, "f1445rep8" },
				{ 502, 116785,     "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Swift Frostwolf
				-- Vol'jin's Spear, WoD
				{ 504, "f1681rep8" },
				{ 505, 116775,     "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" }, -- Breezestrider Stallion
				-- Laughing Skull Orcs, WoD
				{ 507, "f1708rep8" },
				{ 508, 116782,     "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Ironside Warwolf
				-- Vol'jin's Headhunters
				{ 510, "f1848rep8" },
				{ 515, 128526,     "mount", [PRICE_EXTRA_ITTYPE] = "money:25000000" }, -- Deathtusk Felboar
			},
			[NEUTRAL_DIFF] = {
				-- Sha'tari Skyguard, BC
				{ 1,   "f1031rep8" },
				{ 2,   32314,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Green Riding Nether Ray
				{ 3,   32316,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Purple Riding Nether Ray
				{ 4,   32317,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Red Riding Nether Ray
				{ 5,   32318,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Silver Riding Nether Ray
				{ 6,   32319,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Blue Riding Nether Ray
				-- Netherwing, BC
				{ 08,  "f1015rep8" },
				{ 09,  32857,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Onyx Netherwing Drake
				{ 10,  32858,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Azure Netherwing Drake
				{ 11,  32859,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Cobalt Netherwing Drake
				{ 12,  32860,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Purple Netherwing Drake
				{ 13,  32861,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Veridian Netherwing Drake
				{ 14,  32862,       "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Reins of the Violet Netherwing Drake
				-- Cenarion Expedition, BC
				{ 16,  "f942rep8" },
				{ 17,  33999,       "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" }, -- Cenarion War Hippogryph
				-- Argent Tournament, WoLTK
				{ 19,  "f1106rep5" },
				{ 20,  47180,       "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Argent Warhorse
				{ 21,  45725,       "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:150" }, -- Argent Hippogryph
				{ 22,  47179,       "mount", [PRICE_EXTRA_ITTYPE] = "championsseal:100" }, -- Argent Charger
				-- The Wyrmrest Accord, WoLTK
				{ 24,  "f1091rep8" },
				{ 25,  43955,       "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" }, -- Reins of the Red Drake
				-- Ramkahen, Cata
				{ 27,  "f1173rep8" },
				{ 28,  63044,       "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Brown Riding Camel
				{ 29,  63045,       "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Reins of the Tan Riding Camel
				-- The Anglers, MoP
				{ 101, "f1302rep8" },
				{ 102, 81354,       "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000" }, -- Reins of the Azure Water Strider
				-- Order of the Cloud Serpent, MoP
				{ 104, "f1271rep8" },
				{ 105, 79802,       "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Jade Cloud Serpent
				{ 106, 85429,       "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Golden Cloud Serpent
				{ 107, 85430,       "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Azure Cloud Serpent
				-- Shado-Pan, MoP
				{ 109, "f1270rep8" },
				{ 110, 89305,       "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Reins of the Green Shado-Pan Riding Tiger
				{ 111, 89306,       "mount", [PRICE_EXTRA_ITTYPE] = "money:25000000" }, -- Reins of the Red Shado-Pan Riding Tiger
				{ 112, 89307,       "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Reins of the Blue Shado-Pan Riding Tiger
				-- The Klaxxi, MoP
				{ 114, "f1337rep8" },
				{ 115, 85262,       "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Amber Scorpion
				-- Golden Lotus, MoP
				{ 116, "f1269rep8" },
				{ 117, 87782,       "mount", [PRICE_EXTRA_ITTYPE] = "money:25000000" }, -- Reins of the Golden Riding Crane
				{ 118, 87783,       "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Reins of the Regal Riding Crane
				{ 119, 87781,       "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Reins of the Azure Riding Crane
				-- The Tillers, MoP
				{ 121, "f1272rep8" },
				{ 122, 89362,       "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Reins of the Brown Riding Goat
				{ 123, 89390,       "mount", [PRICE_EXTRA_ITTYPE] = "money:32500000" }, -- Reins of the White Riding Goat
				{ 124, 89391,       "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Reins of the Black Riding Goat
				-- The August Celestials, MoP
				{ 126, "f1341rep8" },
				{ 127, 89304,       "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Thundering August Cloud Serpent
				-- The Lorewalkers, MoP
				{ 129, "f1345rep8" },
				{ 130, 89363,       "mount", [PRICE_EXTRA_ITTYPE] = "money:6000000" }, -- Disc of the Red Flying Cloud
				-- Emperor Shaohao, MoP
				{ 201, "f1492rep8" },
				{ 202, 87774,       "mount", [PRICE_EXTRA_ITTYPE] = "timelesscoin:100000" }, -- Reins of the Heavenly Golden Cloud Serpent
				-- Nat Pagle, WoD
				{ 204, "f1358rep16" },                                           -- required Best Friend
				{ 205, 87791,       "mount", [PRICE_EXTRA_ITTYPE] = "luckycoin:100" }, -- Reins of the Crimson Water Strider
				-- Arakkoa Outcasts, WoD
				{ 207, "f1515rep8" },
				{ 208, 116772,      "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Shadowmane Charger
				-- Order of the Awakened, MoD
				{ 210, "f1849rep5" },
				{ 211, 123974,      "mount", [PRICE_EXTRA_ITTYPE] = "apexis:150000" }, -- Reins of the Corrupted Dreadwing
				-- Steamwheedle Perservation Society
				{ 213, "f1711rep5" },
				{ 214, 116672,      "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" }, -- Domesticated Razorback
				-- The Saberstalkers, MoD
				{ 216, "f1850rep5" },
				{ 217, 116671,      "mount", [PRICE_EXTRA_ITTYPE] = "bfclaw:1000" }, -- Wild Goretusk
				{ 218, 128481,      "mount", [PRICE_EXTRA_ITTYPE] = "bfclaw:5000" }, -- Bristling Hellboar
				-- Argussian Reach, Legion 7.3
				{ 220, "f2170rep5" },
				{ 221, 152791,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Sable Ruinstrider, Exalted
				{ 222, 152793,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Russet Ruinstrider, Exalted
				{ 223, 152794,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Amethyst Ruinstrider, Exalted
				{ 224, 152795,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Beryl Ruinstrider, Exalted
				{ 225, 152796,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Umber Ruinstrider, Exalted
				{ 226, 152797,      "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Reins of the Cerulean Ruinstrider, Exalted
				-- Army of the Light, Legion 7.3
				{ 301, "f2165rep8" },
				{ 302, 152788,      "mount", [PRICE_EXTRA_ITTYPE] = "money:6250000000" }, -- Lightforged Warframe, Exalted
			},
		},
		{ -- Black Market Auction House
			name = AL["Black Market Auction House"],
			[NORMAL_DIFF] = {
				{ 1,   13335,  "mount" }, -- Deathcharger's Reins
				{ 2,   23720,  "mount" }, -- Riding Turtle
				{ 3,   19872,  "mount" }, -- Swift Razzashi Raptor
				{ 4,   19902,  "mount" }, -- Swift Zulian Tiger
				{ 5,   30480,  "mount" }, -- Fiery Warhorse's Reins
				{ 6,   32458,  "mount" }, -- Ashes of Al'ar
				{ 7,   32768,  "mount" }, -- Reins of the Raven Lord
				{ 8,   35513,  "mount" }, -- Swift White Hawkstrider
				{ 9,   43952,  "mount" }, -- Reins of the Azure Drake
				{ 10,  43953,  "mount" }, -- Reins of the Blue Drake
				{ 11,  43962,  "mount" }, -- Reins of the White Polar Bear
				{ 12,  44151,  "mount" }, -- Reins of the Blue Proto-Drake
				{ 13,  44175,  "mount" }, -- Reins of the Plagued Proto-Drake
				{ 14,  44707,  "mount" }, -- Reins of the Green Proto-Drake
				{ 15,  45693,  "mount" }, -- Mimiron's Head
				{ 16,  45802,  "mount" }, -- Reins of the Rusted Proto-Drake
				{ 17,  49286,  "mount" }, -- X-51 Nether-Rocket X-TREME
				{ 18,  49636,  "mount" }, -- Reins of the Onyxian Drake
				{ 19,  50818,  "mount" }, -- Invincible's Reins
				{ 20,  54068,  "mount" }, -- Wooly White Rhino
				{ 21,  63040,  "mount" }, -- Reins of the Drake of the North Wind
				{ 22,  63041,  "mount" }, -- Reins of the Drake of the South Wind
				{ 23,  63043,  "mount" }, -- Reins of the Vitreous Stone Drake
				{ 24,  69224,  "mount" }, -- Smoldering Egg of Millagazor
				{ 25,  71665,  "mount" }, -- Flametalon of Alysrazor
				{ 26,  77067,  "mount" }, -- Reins of the Blazing Drake
				{ 27,  77069,  "mount" }, -- Life-Binder's Handmaiden
				{ 28,  78919,  "mount" }, -- Experiment 12-B
				{ 29,  87771,  "mount" }, -- Reins of the Heavenly Onyx Cloud Serpent
				{ 30,  87777,  "mount" }, -- Reins of the Astral Cloud Serpent
				{ 101, 89783,  "mount" }, -- Son of Galleon's Saddle
				{ 102, 90655,  "mount" }, -- Reins of the Thundering Ruby Cloud Serpent
				{ 103, 95057,  "mount" }, -- Reins of the Thundering Cobalt Cloud Serpent
				{ 104, 95059,  "mount" }, -- Clutch of Ji-Kun
				{ 105, 104253, "mount" }, -- Kor'kron Juggernaut
				{ 106, 104269, "mount" }, -- Reins of the Thundering Onyx Cloud Serpent
				{ 107, 115484, "mount" }, -- Core Hound Chain
			},
		},
		{ -- Crafting
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
				{ 1,  65891,  "mount" }, -- Vial of the Sands
				{ 3,  60954,  "mount" }, -- Fossilized Raptor
				{ 4,  64883,  "mount" }, -- Scepter of Azj'Aqir
				{ 6,  95416,  "mount" }, -- Sky Golem
				{ 7,  41508,  "mount" }, -- Mechano-Hog
				{ 8,  44413,  "mount" }, -- Mekgineer's Chopper
				{ 9,  34061,  "mount" }, -- Turbo-Charged Flying Machine
				{ 10, 34060,  "mount" }, -- Flying Machine
				{ 11, 87250,  "mount" }, -- Depleted-Kyparium Rocket
				{ 12, 87251,  "mount" }, -- Geosynchronous World Spinner
				{ 14, 108883, "mount" }, -- Riding Harness
				{ 16, 82453,  "mount" }, -- Jeweled Onyx Panther
				{ 17, 83087,  "mount" }, -- Ruby Panther
				{ 18, 83088,  "mount" }, -- Jade Panther
				{ 19, 83089,  "mount" }, -- Sunstone Panther
				{ 20, 83090,  "mount" }, -- Sapphire Panther
				{ 22, 115363, "mount" }, -- Creeping Carpet
				{ 23, 44558,  "mount" }, -- Magnificent Flying Carpet
				{ 24, 54797,  "mount" }, -- Frosty Flying Carpet
				{ 25, 44554,  "mount" }, -- Flying Carpet
			},
		},
		{ -- Dungeons & Raids
			name = AL["Dungeons"].." & "..AL["Raids"],
			[WOD_DIFF] = {
				{ 1,  123890, "mount" }, -- Felsteel Annihilator
				{ 2,  116660, "mount" }, -- Ironhoof Destroyer
				-- { 5, 133543, "mount" }, -- Reins of the Infinite Timereaver
				-- Tanaan Jungle
				{ 4,  116658, "mount" }, -- Tundra Icehoof
				{ 5,  116669, "mount" }, -- Armored Razorback
				{ 6,  116780, "mount" }, -- Warsong Direfang
				-- Garrison
				{ 8,  116663, "mount" }, -- Shadowhide Pearltusk
				{ 9,  116673, "mount" }, -- Giant Coldsnout
				{ 10, 116786, "mount" }, -- Smoky Direwolf
				{ 11, 116779, "mount" }, -- Garn Steelmaw
				{ 12, 128671, "mount" }, -- Minion of Grumpus
				-- World
				{ 16, 116771, "mount" }, -- Solar Spirehawk
				{ 17, 116659, "mount" }, -- Bloodhoof Bull
				{ 18, 116661, "mount" }, -- Mottled Meadowstomper
				{ 19, 116674, "mount" }, -- Great Greytusk
				{ 20, 116767, "mount" }, -- Sapphire Riverbeast
				{ 21, 116773, "mount" }, -- Swift Breezestrider
				{ 22, 116792, "mount" }, -- Sunhide Gronnling
				{ 23, 116794, "mount" }, -- Garn Nighthowl
				{ 25, 119180 }, -- Goren "Log" Roller
				{ 26, 113543 }, -- Spirit of Shinri
			},
			[MOP_DIFF] = {
				{ 1,  87777,  "mount" }, -- Reins of the Astral Cloud Serpent
				{ 3,  93666,  "mount" }, -- Spawn of Horridon
				{ 4,  95059,  "mount" }, -- Clutch of Ji-Kun
				{ 6,  87771,  "mount" }, -- Reins of the Heavenly Onyx Cloud Serpent
				{ 8,  104253, "mount" }, -- Kor'kron Juggernaut
				{ 10, 89783,  "mount" }, -- Son of Galleon's Saddle
				{ 11, 90655,  "mount" }, -- Reins of the Thundering Ruby Cloud Serpent
				{ 12, 104269, "mount" }, -- Reins of the Thundering Onyx Cloud Serpent
				{ 13, 95057,  "mount" }, -- Reins of the Thundering Cobalt Cloud Serpent
				{ 16, 94228,  "mount" }, -- Reins of the Cobalt Primordial Direhorn
				{ 17, 94229,  "mount" }, -- Reins of the Slate Primordial Direhorn
				{ 18, 94230,  "mount" }, -- Reins of the Amber Primordial Direhorn
				{ 19, 94231,  "mount" }, -- Reins of the Jade Primordial Direhorn
				{ 21, 94291,  "mount" }, -- Reins of the Red Primal Raptor
				{ 22, 94292,  "mount" }, -- Reins of the Black Primal Raptor
				{ 23, 94293,  "mount" }, -- Reins of the Green Primal Raptor
				{ 25, 101675 }, -- Shimmering Moonstone
				{ 26, 89697 }, -- Bag of Kafa Beans
				{ 27, 89770 }, -- Tuft of Yak Fur
				{ 28, 89682 }, -- Oddly-Shaped Horn
				{ 29, 104329 }, -- Ash-Covered Horn
			},
			[CATA_DIFF] = {
				{ 1,  77067, "mount" }, -- Reins of the Blazing Drake
				{ 2,  77069, "mount" }, -- Life-Binder's Handmaiden
				{ 3,  78919, "mount" }, -- Experiment 12-B
				{ 5,  71665, "mount" }, -- Flametalon of Alysrazor
				{ 6,  69224, "mount" }, -- Smoldering Egg of Millagazor
				{ 8,  63041, "mount" }, -- Reins of the Drake of the South Wind
				{ 16, 63040, "mount" }, -- Reins of the Drake of the North Wind
				{ 18, 63043, "mount" }, -- Reins of the Vitreous Stone Drake
				{ 20, 68823, "mount" }, -- Armored Razzashi Raptor
				{ 21, 68824, "mount" }, -- Swift Zulian Panther
				{ 22, 69747, "mount" }, -- Amani Battle Bear
				{ 24, 63042, "mount" }, -- Reins of the Phosphorescent Stone Drake
				{ 25, 63046, "mount" }, -- Reins of the Grey Riding Camel
				{ 26, 67151, "mount" }, -- Reins of Poseidus
			},
			[WOTLK_DIFF] = {
				{ 1,  43952,                           "mount" },                            -- Reins of the Azure Drake
				{ 2,  43953,                           "mount" },                            -- Reins of the Blue Drake
				{ 4,  43954,                           "mount" },                            -- Reins of the Twilight Drake
				{ 5,  43986,                           "mount" },                            -- Reins of the Black Drake
				{ 7,  44168,                           "mount" },                            -- Reins of the Time-Lost Proto-Drake
				{ 8,  43962,                           "mount" },                            -- Reins of the White Polar Bear
				{ 10, 45693,                           "mount" },                            -- Mimiron's Head
				{ 12, 49636,                           "mount" },                            -- Reins of the Onyxian Drake
				{ 14, 50818,                           "mount" },                            -- Invincible's Reins
				{ 15, [ATLASLOOT_IT_ALLIANCE] = 43959, "mount", [ATLASLOOT_IT_HORDE] = 44083, "mount" }, -- Reins of the Grand Black War Mammoth
				-- Horde{ 1, 44083, "mount" }, -- Reins of the Grand Black War Mammoth
				{ 16, 43951,                           "mount" },                            -- Reins of the Bronze Drake
				{ 18, 44151,                           "mount" },                            -- Reins of the Blue Proto-Drake
				{ 20, 46109,                           "mount" },                            -- Sea Turtle
				{ 21, 44707,                           "mount" },                            -- Reins of the Green Proto-Drake
				{ 22, 50250,                           "mount" },                            -- Big Love Rocket
			},
			[BC_DIFF] = {
				{ 1,  32458, "mount" }, -- Ashes of Al'ar
				{ 3,  32768, "mount" }, -- Reins of the Raven Lord
				{ 5,  30480, "mount" }, -- Fiery Warhorse's Reins
				{ 7,  35513, "mount" }, -- Swift White Hawkstrider
				{ 16, 37828, "mount" }, -- Great Brewfest Kodo
				{ 18, 37012, "mount" }, -- The Horseman's Reins
			},
			[CLASSIC_DIFF] = {
				--{ 1, 19872, "mount" }, -- Swift Razzashi Raptor
				--{ 2, 19902, "mount" }, -- Swift Zulian Tiger
				{ 1, 13335, "mount" }, -- Deathcharger's Reins
				{ 3, 21218, "mount" }, -- Blue Qiraji Resonating Crystal
				{ 4, 21321, "mount" }, -- Red Qiraji Resonating Crystal
				{ 5, 21323, "mount" }, -- Green Qiraji Resonating Crystal
				{ 6, 21324, "mount" }, -- Yellow Qiraji Resonating Crystal
			},
		},
		{ -- In-game Shop
			name = AL["Shop"],
			[NORMAL_DIFF] = {
				{ 1,  54811,  "mount" }, -- Celestial Steed
				{ 2,  69846,  "mount" }, -- Winged Guardian
				{ 3,  78924,  "mount" }, -- Heart of the Aspects
				{ 4,  92724,  "mount" }, -- Swift Windsteed
				{ 5,  95341,  "mount" }, -- Armored Bloodwing
				{ 6,  97989,  "mount" }, -- Enchanted Fey Dragon
				{ 7,  107951, "mount" }, -- Iron Skyreaver
				{ 8,  112326, "mount" }, -- Warforged Nightmare
				{ 9,  112327, "mount" }, -- Grinning Reaver
				{ 10, 112326, "mount" }, -- Warforged Nightmare
			},
		},
		--[[		{ -- Vendor
			name = AL["Vendor"],
			[ALLIANCE_DIFF] = {
				--Both
				-- Eastern Kingdoms
				{ 217, 40775, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000000" }, -- Winged Steed of the Ebon Blade, Death Knight only
				-- Pandaria
				{ 301, 84101, "mount", [PRICE_EXTRA_ITTYPE] = "money:1200000000" }, -- Reins of the Grand Expedition Yak
				{ 302, 87788, "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Grey Riding Yak
				{ 303, 87789, "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Blonde Riding Yak

				-- guild
				{ 125, 67107, "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Reins of the Kor'kron Annihilator, guild, horde
				{ 118, 62298, "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Reins of the Golden King, guild, alliance
				{ 310, 63125, "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Dark Phoenix, guild
				{ 311, 85666, "mount", [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Reins of the Thundering Jade Cloud Serpent
				{ 312, 116666, "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000" }, -- Blacksteel Battleboar, Achievement: Guild Glory of the Draenor Raider

				-- Draenor, garrison
				{ 313, 116667, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" }, -- Rocktusk Battleboar
				{ 315, 116655, "mount", [PRICE_EXTRA_ITTYPE] = "money:200000000" }, -- Witherhide Cliffstomper
				-- Draenor, Ashran
				{ 521, 116768, "mount", [PRICE_EXTRA_ITTYPE] = "money:500000000:apexis:5000" }, -- Mosshide Riverwallow
				-- Deeprun Tram for alliance, Brawl'gar Arena for horde
				{ 314, 98405, "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Brawler's Burly Mushan Beast, Brawl'gar Arena

				-- World Events
				-- Brewfest
				{ 316, 33977, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Swift Brewfest Ram
				{ 317, 33976, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Brewfest Ram
				-- Darkmoon Island
				{ 507, 73766, "mount", [PRICE_EXTRA_ITTYPE] = "darkmoon:180" }, -- Darkmoon Dancing Bear
				{ 524, 72140, "mount", [PRICE_EXTRA_ITTYPE] = "darkmoon:180" }, -- Swift Forest Strider
				-- Hallow's End
				{ 509, 37011, "mount", [PRICE_EXTRA_ITTYPE] = "trickytreat:150" }, -- Magic Broom
				-- Love is in the Air
				{ 519, 72146, "mount", [PRICE_EXTRA_ITTYPE] = "lovetoken:270" }, -- Swift Lovebird
				-- Noblegarden
				{ 523, 72145, "mount", [PRICE_EXTRA_ITTYPE] = "noblegardenchocolate:500" }, -- Swift Springstrider

				-- Pandaren only?
				{ 325, 91010, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Red Dragon Turtle
				{ 326, 91011, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Black Dragon Turtle
				{ 327, 91012, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Green Dragon Turtle
				{ 328, 91013, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Blue Dragon Turtle
				{ 329, 91014, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Brown Dragon Turtle
				{ 330, 91015, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Reins of the Great Purple Dragon Turtle
				{ 407, 91004, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Green Dragon Turtle
				{ 408, 91005, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Brown Dragon Turtle
				{ 409, 91006, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Purple Dragon Turtle
				{ 410, 91007, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Red Dragon Turtle
				{ 411, 91008, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Black Dragon Turtle
				{ 412, 91009, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Reins of the Blue Dragon Turtle

				-- Pandaria, Timeless Isle
				{ 508, 103638, "mount", [PRICE_EXTRA_ITTYPE] = "bloodycoin:500" }, -- Reins of the Ashhide Mushan Beast

			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
]]
		{ -- No longer available
			name = AL["No longer available"],
			[NORMAL_DIFF] = {
				{ 1,   128281, "ac10098" }, -- Wild Gladiator's Felblood Gronnling
				{ 2,   128277, "ac9239" }, -- Primal Gladiator's Felblood Gronnling
				{ 3,   89154,  "mount" }, -- Reins of the Crimson Pandaren Phoenix
				{ 4,   90710,  "mount" }, -- Reins of the Ashen Pandaren Phoenix
				{ 5,   90711,  "mount" }, -- Reins of the Emerald Pandaren Phoenix
				{ 6,   90712,  "mount" }, -- Reins of the Violet Pandaren Phoenix
				{ 7,   95041,  "mount" }, -- Malevolent Gladiator's Cloud Serpent
				{ 8,   104246, "mount" }, -- Reins of the Kor'kron War Wolf
				{ 9,   104325, "mount" }, -- Tyrannical Gladiator's Cloud Serpent
				{ 10,  104326, "mount" }, -- Grievous Gladiator's Cloud Serpent
				{ 11,  104327, "mount" }, -- Prideful Gladiator's Cloud Serpent
				{ 12,  30609,  "mount" }, -- Swift Nether Drake
				{ 13,  33809,  "mount" }, -- Amani War Bear
				{ 14,  34092,  "mount" }, -- Merciless Nether Drake
				{ 15,  37676,  "mount" }, -- Vengeful Nether Drake
				{ 16,  43516,  "mount" }, -- Brutal Nether Drake
				{ 17,  44164,  "mount" }, -- Reins of the Black Proto-Drake
				{ 18,  46171,  "mount" }, -- Furious Gladiator's Frost Wyrm
				{ 19,  46708,  "mount" }, -- Deadly Gladiator's Frost Wyrm
				{ 20,  47840,  "mount" }, -- Relentless Gladiator's Frost Wyrm
				{ 21,  50435,  "mount" }, -- Wrathful Gladiator's Frost Wyrm
				{ 22,  71339,  "mount" }, -- Vicious Gladiator's Twilight Drake
				{ 23,  71954,  "mount" }, -- Ruthless Gladiator's Twilight Drake
				{ 24,  85785,  "mount" }, -- Cataclysmic Gladiator's Twilight Drake
				{ 25,  76889,  "mount" }, -- Spectral Gryphon
				{ 26,  76902,  "mount" }, -- Spectral Wind Rider
				{ 27,  21176,  "mount" }, -- Black Qiraji Resonating Crystal
				{ 28,  8586,   "mount" }, -- Whistle of the Mottled Red Raptor
				{ 29,  12302,  "mount" }, -- Reins of the Ancient Frostsaber
				{ 30,  12303,  "mount" }, -- Reins of the Nightsaber
				{ 101, 12330,  "mount" }, -- Horn of the Red Wolf
				{ 102, 12351,  "mount" }, -- Horn of the Arctic Wolf
				{ 103, 12353,  "mount" }, -- White Stallion Bridle
				{ 104, 12354,  "mount" }, -- Palomino Bridle
				{ 105, 13317,  "mount" }, -- Whistle of the Ivory Raptor
				{ 106, 13326,  "mount" }, -- White Mechanostrider Mod B
				{ 107, 13327,  "mount" }, -- Icy Blue Mechanostrider Mod A
				{ 108, 13328,  "mount" }, -- Black Ram
				{ 109, 13329,  "mount" }, -- Frost Ram
				{ 110, 15292,  "mount" }, -- Green Kodo
				{ 111, 15293,  "mount" }, -- Teal Kodo
				{ 112, 49044,  "mount" }, -- Swift Alliance Steed
				{ 113, 49046,  "mount" }, -- Swift Horde Wolf
				{ 114, 49096,  "mount" }, -- Crusader's White Warhorse
				{ 115, 49098,  "mount" }, -- Crusader's Black Warhorse
				{ 116, 76755,  "mount" }, -- Tyrael's Charger
				{ 117, 116788, "ac9496" }, -- Warlord's Deathwheel
			},
		},
	},
}

data["CLASSICSETS"]        = {
	name = AL["Classic Sets"],
	ContentType = COLLECTION_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{
			name = ALIL["Ahn'Qiraj"].." "..AL["Sets"],
			[NORMAL_DIFF] = {
				{ 1,  "AQ40:druid:n" },
				{ 3,  "AQ40:hunter:n" },
				{ 5,  "AQ40:mage:n" },
				{ 7,  "AQ40:paladin:n" },
				{ 9,  "AQ40:priest:n" },
				{ 16, "AQ40:rogue:n" },
				{ 18, "AQ40:shaman:n" },
				{ 20, "AQ40:warlock:n" },
				{ 22, "AQ40:warrior:n" },
			},
		},
		{
			name = ALIL["Ruins of Ahn'Qiraj"].." "..AL["Sets"],
			[NORMAL_DIFF] = {
				{ 1,  "AQ20:druid:n" },
				{ 3,  "AQ20:hunter:n" },
				{ 5,  "AQ20:mage:n" },
				{ 7,  "AQ20:paladin:n" },
				{ 9,  "AQ20:priest:n" },
				{ 16, "AQ20:rogue:n" },
				{ 18, "AQ20:shaman:n" },
				{ 20, "AQ20:warlock:n" },
				{ 22, "AQ20:warrior:n" },
			},
		},
		{ -- Scholomance Sets
			name = C_Map.GetMapInfo(476).name.." "..AL["Sets"],
			[NORMAL_DIFF] = {
				{ 1,  "Scholomance:scholocloth:n" },
				{ 3,  "Scholomance:schololeather:n" },
				{ 16, "Scholomance:scholomail:n" },
				{ 18, "Scholomance:scholoplate:n" },
			},
		},
		{
			name = AL["Miscellaneous"].." "..AL["Sets"],
			[NORMAL_DIFF] = {
				{ 1,  "ClassicMisc:ironweavebattlesuit:n" },
				{ 3,  "ClassicMisc:thegladiator:n" },
				{ 5,  "ClassicMisc:thepostmaster:n" },
				{ 16, "ClassicMisc:chainofthescarletcrusade:n" },
				{ 18, "ClassicMisc:embraceoftheviper:n" },
				{ 20, "ClassicMisc:defiasleather:n" },
			},
		},
	},
}

data["DUNGEONSETS"]        = {
	name = AL["Dungeon Sets"],
	ContentType = COLLECTION_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{
			name = format(AL["Dungeon %d Sets"], 3).." ("..EXPANSION_NAME1..")",
			[NORMAL_DIFF] = {
				{ 1,  "Dungeon3:moongladeraiment:n" },
				{ 3,  "Dungeon3:beastlordarmor:n" },
				{ 5,  "Dungeon3:incantersregalia:n" },
				{ 7,  "Dungeon3:righteousarmor:n" },
				{ 9,  "Dungeon3:hallowedraiment:n" },
				{ 14, "Dungeon3:manaechedregalia:n" },
				{ 15, "Dungeon3:wastewalkerarmor:n" },
				{ 16, "Dungeon3:assassinationarmor:n" },
				{ 18, "Dungeon3:tidefuryraiment:n" },
				{ 20, "Dungeon3:oblivionraiment:n" },
				{ 22, "Dungeon3:boldarmor:n" },
				{ 29, "Dungeon3:desolationbattlegear:n" },
				{ 30, "Dungeon3:doomplatebattlegear:n" },
			},
		},
		{
			name = format(AL["Dungeon %d Sets"], 2).." ("..EXPANSION_NAME0..")",
			[NORMAL_DIFF] = {
				{ 1,  "Dungeon2:druid:n" },
				{ 3,  "Dungeon2:hunter:n" },
				{ 5,  "Dungeon2:mage:n" },
				{ 7,  "Dungeon2:paladin:n" },
				{ 9,  "Dungeon2:priest:n" },
				{ 16, "Dungeon2:rogue:n" },
				{ 18, "Dungeon2:shaman:n" },
				{ 20, "Dungeon2:warlock:n" },
				{ 22, "Dungeon2:warrior:n" },
			},
		},
		{
			name = format(AL["Dungeon %d Sets"], 1).." ("..EXPANSION_NAME0..")",
			[NORMAL_DIFF] = {
				{ 1,  "Dungeon1:druid:n" },
				{ 3,  "Dungeon1:hunter:n" },
				{ 5,  "Dungeon1:mage:n" },
				{ 7,  "Dungeon1:paladin:n" },
				{ 9,  "Dungeon1:priest:n" },
				{ 16, "Dungeon1:rogue:n" },
				{ 18, "Dungeon1:shaman:n" },
				{ 20, "Dungeon1:warlock:n" },
				{ 22, "Dungeon1:warrior:n" },
			},
		},
	},
}

data["GARRISON"]           = {
	name = AL["Garrison"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{ -- Dwarven Bunker / War Mill
			name = ALIL["DBWM"],
			[ALLIANCE_DIFF] = {
				{ 1,  114746 },                                        -- Goredrenched Armor Set
				{ 2,  114622 },                                        -- Goredrenched Weaponry
				{ 3,  114806 },                                        -- Blackrock Armor Set
				{ 4,  114081 },                                        -- Blackrock Weaponry
				{ 5,  114807 },                                        -- War Ravaged Armor Set
				{ 6,  114616 },                                        -- War Ravaged Weaponry
				{ 7,  120301 },                                        -- Armor Enhancement Token
				{ 8,  120302 },                                        -- Weapon Enhancement Token
				{ 10, 113681 },                                        -- Iron Horde Scraps
				{ 12, 118365,                      [QUEST_EXTRA_ITTYPE] = 37092 }, -- Stormwind Tabard
				{ 16, "setDBWMSets:stormwindset:n" },                  -- SW Set
				{ 18, "setDBWMSets:clothset:n" },                      -- Cloth Set
				{ 19, "setDBWMSets:leatherset:n" },                    -- Leather Set
				{ 20, "setDBWMSets:mailset:n" },                       -- Mail Set
				{ 21, "setDBWMSets:plateset:n" },                      -- Plate Set
				{ 23, "ac9129" },                                      -- Filling the Ranks
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 12, 118372,                      [QUEST_EXTRA_ITTYPE] = 37043 }, -- Orgrimmar Tabard
				{ 16, "setDBWMSets:orgrimmarset:n" },                  -- OG Set
			},
		},
		{
			name = ALIL["Enchanter's Study"],
			[NORMAL_DIFF] = {
				{ 1,  "prof173716" }, -- Illusion: Agility
				{ 2,  "prof173717" }, -- Illusion: Battlemaster
				{ 3,  "prof173718" }, -- Illusion: Berserking
				{ 4,  "prof174979" }, -- Illusion: Blood Draining
				{ 5,  "prof173720" }, -- Illusion: Crusader
				{ 6,  "prof173721" }, -- Illusion: Elemental Force
				{ 7,  "prof173722" }, -- Illusion: Executioner
				{ 8,  "prof173723" }, -- Illusion: Fiery Weapon
				{ 9,  "prof173719" }, -- Illusion: Greater Spellpower
				{ 10, "prof173724" }, -- Illusion: Hidden
				{ 11, "prof175070" }, -- Illusion: Jade Spirit
				{ 12, "prof173725" }, -- Illusion: Landslide
				{ 13, "prof173726" }, -- Illusion: Lifestealing
				{ 14, "prof175085" }, -- Illusion: Mending
				{ 15, "prof173727" }, -- Illusion: Mongoose
				{ 16, "prof173729" }, -- Illusion: Power Torrent
				{ 17, "prof175086" }, -- Illusion: River's Song
				{ 18, "prof173730" }, -- Illusion: Spellsurge
				{ 19, "prof173731" }, -- Illusion: Striking
				{ 20, "prof173732" }, -- Illusion: Unholy
				{ 22, "ICON_inv_throwingknife_04",   nil, ALIL["ROGUE"],  nil },
				{ 23, "prof173728" }, -- Illusion: Poisoned
				{ 25, "ICON_Spell_Nature_BloodLust", nil, ALIL["SHAMAN"], nil },
				{ 26, "prof175076" }, -- Illusion: Earthliving
				{ 27, "prof175072" }, -- Illusion: Flametongue
				{ 28, "prof175071" }, -- Illusion: Frostbrand
				{ 29, "prof175078" }, -- Illusion: Rockbiter
				{ 30, "prof175074" }, -- Illusion: Windfury
			},
		},
		{
			name = ALIL["Engineering Works"],
			[NORMAL_DIFF] = {
				{ 1,  109644, [PRICE_EXTRA_ITTYPE] = "money:16000" }, -- Walter
				{ 2,  109574, [PRICE_EXTRA_ITTYPE] = "money:16000" }, -- GUMM-E
				{ 16, 117438, [PRICE_EXTRA_ITTYPE] = "money:13260" }, -- Gnomish Net Launcher
				{ 17, 117403, [PRICE_EXTRA_ITTYPE] = "money:12220" }, -- Gyro-Radiant Reflector
				{ 18, 117402, [PRICE_EXTRA_ITTYPE] = "money:12181" }, -- Ultra-Electrified Reflector
			},
		},
		{
			name = ALIL["Fishing Shack"],
			[NORMAL_DIFF] = {
				{ 1,  "ICON_achievement_faction_anglers", nil,                               ALIL["Nat Pagle"],                  AL["Best Friend"] },
				{ 2,  87791,                              "mount",                           [PRICE_EXTRA_ITTYPE] = "117397:100" }, -- Reins of the Crimson Water Strider
				{ 4,  "ICON_achievement_faction_anglers", nil,                               ALIL["Nat Pagle"],                  AL["Good Friend"] },
				{ 5,  117404,                             "pet115",                          [PRICE_EXTRA_ITTYPE] = "117397:50" }, -- Land Shark
				{ 7,  "ICON_achievement_faction_anglers", nil,                               ALIL["Nat Pagle"],                  AL["Friend"] },
				{ 8,  117405,                             [PRICE_EXTRA_ITTYPE] = "117397:25" },                         -- Nat's Drinking Hat
				{ 9,  [ATLASLOOT_IT_ALLIANCE] = 116826,   [ATLASLOOT_IT_HORDE] = 116825,     [PRICE_EXTRA_ITTYPE] = "117397:25" }, -- Draenic Fishing Pole / Savage Fishing Pole
				{ 16, 117401,                             [PRICE_EXTRA_ITTYPE] = "117397:25" },                         -- Nat's Draenic Fishing Journal
				{ 18, "ac9462" },                                                                                       -- Draenor Angler
			},
		},
		{ -- Gnomish Gearworks / Goblin Workshop
			name = ALIL["GGGW"],
			[NORMAL_DIFF] = {
				{ 1,  114246 },                                              -- "Skyterror" Personal Delivery System
				{ 2,  114974 },                                              -- Pneumatic Power Gauntlet
				{ 3,  114975 },                                              -- Pneumatic Power Gauntlet
				{ 4,  119158 },                                              -- Robo-Rooster
				{ 5,  114983 },                                              -- Sticky Grenade Launcher
				{ 16, 114244 },                                              -- GG-117 Micro-Jetpack
				{ 17, 115530 },                                              -- N.U.K.U.L.A.R. Target Painter
				{ 18, [ATLASLOOT_IT_ALLIANCE] = 114924, [ATLASLOOT_IT_HORDE] = 114925 }, -- Prototype Mekgineer's Chopper / Prototype Mechano-Hog
				{ 19, 114744 },                                              -- Sentry Turret Dispensor
				{ 20, 114633 },                                              -- XD-57 "Bullseye" Guided Rocket Kit
				{ 22, "ac9527" },                                            -- Terrific Technology
			},
		},
		{ -- Lunarfall Inn / Frostwall Tavern
			name = ALIL["LIFT"],
			[NORMAL_DIFF] = {
				{ 1,  118921,  "pet1566",                              [QUEST_EXTRA_ITTYPE] = 37150 }, -- Everbloom Peachick
				{ 2,  118923,  "pet1567",                              [QUEST_EXTRA_ITTYPE] = 37164 }, -- Sentinel's Companion
				{ 4,  119083,  [QUEST_EXTRA_ITTYPE] = 37152 },                             -- Fruit Basket
				{ 5,  118937,  [QUEST_EXTRA_ITTYPE] = 37160 },                             -- Gamon's Braid
				{ 6,  119039,  [QUEST_EXTRA_ITTYPE] = 37156 },                             -- Lilian's Warning Sign
				{ 7,  118938,  [QUEST_EXTRA_ITTYPE] = 37179 },                             -- Manastorm's Duplicator
				{ 8,  119003,  [QUEST_EXTRA_ITTYPE] = 37163 },                             -- Void Totem
				{ 10, 119093,  [QUEST_EXTRA_ITTYPE] = 37159 },                             -- Aviana's Feather
				{ 11, 118935,  [QUEST_EXTRA_ITTYPE] = 37165 },                             -- Ever-Blooming Frond
				{ 12, 118936,  [QUEST_EXTRA_ITTYPE] = 37149 },                             -- Manual of Void-Calling
				{ 13, 119092,  [QUEST_EXTRA_ITTYPE] = 37157 },                             -- Moroes' Famous Polish
				{ 14, 118922,  [QUEST_EXTRA_ITTYPE] = 37148 },                             -- Oralius' Whispering Crystal
				{ 16, 118930,  [QUEST_EXTRA_ITTYPE] = 37166 },                             -- Bag of Everbloom Herbs
				{ 17, 118924,  [QUEST_EXTRA_ITTYPE] = 37167 },                             -- Cache of Arms
				{ 18, 118928,  [QUEST_EXTRA_ITTYPE] = 37158 },                             -- Faintly-Sparkling Cache
				{ 19, 118926,  [QUEST_EXTRA_ITTYPE] = 37161 },                             -- Huge Pile of Skins
				{ 20, 118931,  [QUEST_EXTRA_ITTYPE] = 37154 },                             -- Leonid's Bag of Supplies
				{ 21, 118927,  [QUEST_EXTRA_ITTYPE] = 37162 },                             -- Maximillian's Laundry
				{ 22, 118925,  [QUEST_EXTRA_ITTYPE] = 37155 },                             -- Plundered Booty
				{ 23, 118929,  [QUEST_EXTRA_ITTYPE] = 37153 },                             -- Sack of Mined Ore
				{ 25, 118918,  [QUEST_EXTRA_ITTYPE] = 37151 },                             -- Bloody Bandanna
				{ 27, 119207,  [PRICE_EXTRA_ITTYPE] = "money:50000000" },                  -- Meat Cleaver
				{ 29, "ac9703" },                                                          -- Stay Awhile and Listen
			},
		},
		{
			name = AL["Primal Trader"],
			[NORMAL_DIFF] = {
				{ 1,  110611, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- Burnished Leather
				{ 2,  111366, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- Gearspring Parts
				{ 3,  111556, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- Hexweave Cloth
				{ 4,  115524, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- Taladite Crystal
				{ 5,  108257, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- Truesteel Ingot
				{ 6,  112377, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- War Paints
				{ 16, 108996, [PRICE_EXTRA_ITTYPE] = "120945:10" }, -- Alchemical Catalyst
				{ 17, 118472, [PRICE_EXTRA_ITTYPE] = "120945:50" }, -- Savage Blood
				{ 18, 113264, [PRICE_EXTRA_ITTYPE] = "120945:25" }, -- Sorcerous Air
				{ 19, 113263, [PRICE_EXTRA_ITTYPE] = "120945:25" }, -- Sorcerous Earth
				{ 20, 113261, [PRICE_EXTRA_ITTYPE] = "120945:25" }, -- Sorcerous Fire
				{ 21, 113262, [PRICE_EXTRA_ITTYPE] = "120945:25" }, -- Sorcerous Water
			},
		},
		{
			name = ALIL["Stables"],
			[NORMAL_DIFF] = {
				{ 1,  116656,                                                "mount" },                                -- Trained Icehoof
				{ 2,  116662,                                                "mount" },                                -- Trained Meadowstomper
				{ 3,  116676,                                                "mount" },                                -- Trained Riverwallow
				{ 4,  116675,                                                "mount" },                                -- Trained Rocktusk
				{ 5,  116774,                                                "mount" },                                -- Trained Silverpelt
				{ 6,  116784,                                                "mount" },                                -- Trained Snarler
				{ 16, [ATLASLOOT_IT_ALLIANCE] = { "ac9539", "mount171629" }, [ATLASLOOT_IT_HORDE] = { "ac9705", "mount171629" } }, -- Armored Frostboar
				{ 17, "ac9526" },                                                                                      -- Master of Mounts
				{ 18, [ATLASLOOT_IT_ALLIANCE] = { "ac9540", "mount171838" }, [ATLASLOOT_IT_HORDE] = { "ac9706", "mount171838" } }, -- Armored Frostwolf
			},
		},
		{
			name = ALIL["The Tannery"],
			[NORMAL_DIFF] = {
				{ 1,  116993,                                             "prof176408" },                        -- Archmage's Tent
				{ 2,  116994,                                             "prof176409" },                        -- Brute's Tent
				{ 3,  116996,                                             "prof176412" },                        -- Crusader's Tent
				{ 4,  117000,                                             "prof176415" },                        -- Deathweaver's Hovel
				{ 5,  117005,                                             "prof176421" },                        -- Distressingly Furry Tent
				{ 6,  116991,                                             "prof176404" },                        -- Enchanter's Tent
				{ 7,  116986,                                             "prof176392" },                        -- Fine Blue and Gold Tent
				{ 8,  116988,                                             "prof176399" },                        -- Fine Blue and Green Tent
				{ 9,  116987,                                             "prof176397" },                        -- Fine Blue and Purple Tent
				{ 10, 116989,                                             "prof176401" },                        -- Ironskin Tent
				{ 11, 117009,                                             "prof176426" },                        -- Nomad's Spiked Tent
				{ 12, 116990,                                             "prof176402" },                        -- Outcast's Tent
				{ 13, 117001,                                             "prof176416" },                        -- Patchwork Hut
				{ 14, 116992,                                             "prof176405" },                        -- Savage Leather Tent
				{ 15, 117004,                                             "prof176420" },                        -- Simple Tent
				{ 16, 116995,                                             "prof176411" },                        -- Sturdy Tent
				{ 17, 117008,                                             "prof176425" },                        -- Voodoo Doctor's Hovel
				{ 19, [ATLASLOOT_IT_ALLIANCE] = { 117002, "prof176417" }, [ATLASLOOT_IT_HORDE] = { 116997, "prof176413" } }, -- Elune's Retreat / Blood Elven Tent
				{ 20, [ATLASLOOT_IT_ALLIANCE] = { 116998, "prof176414" }, [ATLASLOOT_IT_HORDE] = { 117003, "prof176418" } }, -- High Elven Tent / Orgrimmar's Reach
				{ 21, [ATLASLOOT_IT_ALLIANCE] = { 117006, "prof176422" }, [ATLASLOOT_IT_HORDE] = { 117007, "prof176424" } }, -- Ornate Alliance Tent / Ornate Horde Tent
			},
		},
	},
}

data["HEIRLOOM"]           = {
	name = AL["Heirloom"],
	ContentType = COLLECTION_CONTENT,
	items =
	{
		{ --ArmorWeaponEnhancements
			name = AL["Armor Enhancements"].." / "..AL["Weapon Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  122338, [PRICE_EXTRA_ITTYPE] = "money:10000000-darkmoon:100-championsseal:55-honor:2000-ancestrycoin:40" }, -- Ancient Heirloom Armor Casing
				{ 2,  122340, [PRICE_EXTRA_ITTYPE] = "money:20000000-ancestrycoin:75" },                              -- Timeworn Heirloom Armor Casing
				{ 16, 122339, [PRICE_EXTRA_ITTYPE] = "money:12000000-darkmoon:120-championsseal:65-honor:2400-lovetoken:200" }, -- Ancient Heirloom Scabbard
				{ 17, 122341, [PRICE_EXTRA_ITTYPE] = "money:50000000-lovetoken:450" },                                -- Timeworn Heirloom Scabbard
			},
		},
		{ --HeirloomClothCloaks
			name = AL["Cloth"].." / "..AL["Cloaks"],
			[NORMAL_DIFF] = {
				{ 1,  "122250:Stage3H", 122340 },                                                  -- Tattered Dreadmist Mask  (Stage 3)
				{ 2,  "122250:Stage2H", 122338 },                                                  -- Tattered Dreadmist Mask  (Stage 2)
				{ 3,  "122250",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Tattered Dreadmist Mask
				{ 5,  "122360:Stage3H", 122340 },                                                  -- Tattered Dreadmist Mantle (Stage 3)
				{ 6,  "122360:Stage2H", 122338 },                                                  -- Tattered Dreadmist Mantle (Stage 2)
				{ 7,  "122360",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Tattered Dreadmist Mantle
				{ 9,  "122384:Stage3H", 122340 },                                                  -- Tattered Dreadmist Robe (Stage 3)
				{ 10, "122384:Stage2H", 122338 },                                                  -- Tattered Dreadmist Robe (Stage 2)
				{ 11, "122384",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Tattered Dreadmist Robe
				{ 13, "122256:Stage3H", 122340 },                                                  -- Tattered Dreadmist Leggings (Stage 3)
				{ 14, "122256:Stage2H", 122338 },                                                  -- Tattered Dreadmist Leggings (Stage 2)
				{ 15, "122256",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Tattered Dreadmist Leggings
				{ 16, "122262:Stage3H", 122340 },                                                  -- Ancient Bloodmoon Cloak (Stage 3)
				{ 17, "122262:Stage2H", 122338 },                                                  -- Ancient Bloodmoon Cloak (Stage 2)
				{ 18, "122262",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Ancient Bloodmoon Cloak
				{ 20, "122261:Stage3H", 122340 },                                                  -- Inherited Cape of the Black Baron (Stage 3)
				{ 21, "122261:Stage2H", 122338 },                                                  -- Inherited Cape of the Black Baron (Stage 2)
				{ 22, "122261",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Inherited Cape of the Black Baron
				{ 24, "122266:Stage3H", 122340 },                                                  -- Ripped Sandstorm Cloak (Stage 3)
				{ 25, "122266:Stage2H", 122338 },                                                  -- Ripped Sandstorm Cloak (Stage 2)
				{ 26, "122266",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Ripped Sandstorm Cloak
				{ 28, "122260:Stage3H", 122340 },                                                  -- Worn Stoneskin Gargoyle Cape (Stage 3)
				{ 29, "122260:Stage2H", 122338 },                                                  -- Worn Stoneskin Gargoyle Cape (Stage 2)
				{ 30, "122260",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Worn Stoneskin Gargoyle Cape
			},
		},
		{ --HeirloomLeather
			name = AL["Leather"],
			[NORMAL_DIFF] = {
				{ 1,  "122248:Stage3H", 122340 },                                                  -- Stained Shadowcraft Cap  (Stage 3)
				{ 2,  "122248:Stage2H", 122338 },                                                  -- Stained Shadowcraft Cap  (Stage 2)
				{ 3,  "122248",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Stained Shadowcraft Cap
				{ 5,  "122358:Stage3H", 122340 },                                                  -- Stained Shadowcraft Spaulders (Stage 3)
				{ 6,  "122358:Stage2H", 122338 },                                                  -- Stained Shadowcraft Spaulders (Stage 2)
				{ 7,  "122358",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Stained Shadowcraft Spaulders
				{ 9,  "122383:Stage3H", 122340 },                                                  -- Stained Shadowcraft Tunic (Stage 3)
				{ 10, "122383:Stage2H", 122338 },                                                  -- Stained Shadowcraft Tunic (Stage 2)
				{ 11, "122383",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Stained Shadowcraft Tunic
				{ 13, "122254:Stage3H", 122340 },                                                  -- Stained Shadowcraft Pants (Stage 3)
				{ 14, "122254:Stage2H", 122338 },                                                  -- Stained Shadowcraft Pants (Stage 2)
				{ 15, "122254",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Stained Shadowcraft Pants
				{ 16, "122249:Stage3H", 122340 },                                                  -- Preened Tribal War Feathers (Stage 3)
				{ 17, "122249:Stage2H", 122338 },                                                  -- Preened Tribal War Feathers (Stage 2)
				{ 18, "122249",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Preened Tribal War Feathers
				{ 20, "122359:Stage3H", 122340 },                                                  -- Preened Ironfeather Shoulders (Stage 3)
				{ 21, "122359:Stage2H", 122338 },                                                  -- Preened Ironfeather Shoulders (Stage 2)
				{ 22, "122359",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Preened Ironfeather Shoulders
				{ 24, "122382:Stage3H", 122340 },                                                  -- Preened Ironfeather Breastplate (Stage 3)
				{ 25, "122382:Stage2H", 122338 },                                                  -- Preened Ironfeather Breastplate (Stage 2)
				{ 26, "122382",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Preened Ironfeather Breastplate
				{ 28, "122255:Stage3H", 122340 },                                                  -- Preened Wildfeather Leggings (Stage 3)
				{ 29, "122255:Stage2H", 122338 },                                                  -- Preened Wildfeather Leggings (Stage 2)
				{ 30, "122255",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Preened Wildfeather Leggings
			},
		},
		{ --HeirloomMail
			name = AL["Mail"],
			[NORMAL_DIFF] = {
				{ 1,  "122246:Stage3H", 122340 },                                                  -- Tarnished Raging Berserker's Helm (Stage 3)
				{ 2,  "122246:Stage2H", 122338 },                                                  -- Tarnished Raging Berserker's Helm (Stage 2)
				{ 3,  "122246",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Tarnished Raging Berserker's Helm
				{ 5,  "122356:Stage3H", 122340 },                                                  -- Champion Herod's Shoulder (Stage 3)
				{ 6,  "122356:Stage2H", 122338 },                                                  -- Champion Herod's Shoulder (Stage 2)
				{ 7,  "122356",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Champion Herod's Shoulder
				{ 9,  "122379:Stage3H", 122340 },                                                  -- Champion's Deathdealer Breastplate (Stage 3)
				{ 10, "122379:Stage2H", 122338 },                                                  -- Champion's Deathdealer Breastplate (Stage 2)
				{ 11, "122379",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Champion's Deathdealer Breastplate
				{ 13, "122252:Stage3H", 122340 },                                                  -- Tarnished Leggings of Destruction (Stage 3)
				{ 14, "122252:Stage2H", 122338 },                                                  -- Tarnished Leggings of Destruction (Stage 2)
				{ 15, "122252",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Tarnished Leggings of Destruction
				{ 16, "122247:Stage3H", 122340 },                                                  -- Mystical Coif of Elements (Stage 3)
				{ 17, "122247:Stage2H", 122338 },                                                  -- Mystical Coif of Elements (Stage 2)
				{ 18, "122247",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Mystical Coif of Elements
				{ 20, "122357:Stage3H", 122340 },                                                  -- Mystical Pauldrons of Elements (Stage 3)
				{ 21, "122357:Stage2H", 122338 },                                                  -- Mystical Pauldrons of Elements (Stage 2)
				{ 22, "122357",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Mystical Pauldrons of Elements
				{ 24, "122380:Stage3H", 122340 },                                                  -- Mystical Vest of Elements (Stage 3)
				{ 25, "122380:Stage2H", 122338 },                                                  -- Mystical Vest of Elements (Stage 2)
				{ 26, "122380",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Mystical Vest of Elements
				{ 28, "122253:Stage3H", 122340 },                                                  -- Mystical Kilt of Elements (Stage 3)
				{ 29, "122253:Stage2H", 122338 },                                                  -- Mystical Kilt of Elements (Stage 2)
				{ 30, "122253",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Mystical Kilt of Elements
			},
		},
		{ --HeirloomPlate
			name = AL["Plate"],
			[NORMAL_DIFF] = {
				{ 1,   "122263:Stage3H", 122340 },                                                  -- Burnished Helm of Might (Stage 3)
				{ 2,   "122263:Stage2H", 122338 },                                                  -- Burnished Helm of Might (Stage 2)
				{ 3,   "122263",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Burnished Helm of Might
				{ 5,   "122388:Stage3H", 122340 },                                                  -- Burnished Pauldrons of Might (Stage 3)
				{ 6,   "122388:Stage2H", 122338 },                                                  -- Burnished Pauldrons of Might (Stage 2)
				{ 7,   "122388",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Burnished Pauldrons of Might
				{ 9,   "122387:Stage3H", 122340 },                                                  -- Burnished Breastplate of Might (Stage 3)
				{ 10,  "122387:Stage2H", 122338 },                                                  -- Burnished Breastplate of Might (Stage 2)
				{ 11,  "122387",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Burnished Breastplate of Might
				{ 13,  "122264:Stage3H", 122340 },                                                  -- Burnished Legplates of Might (Stage 3)
				{ 14,  "122264:Stage2H", 122338 },                                                  -- Burnished Legplates of Might (Stage 2)
				{ 15,  "122264",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Burnished Legplates of Might
				{ 16,  "122245:Stage3H", 122340 },                                                  -- Polished Helm of Valor (Stage 3)
				{ 17,  "122245:Stage2H", 122338 },                                                  -- Polished Helm of Valor (Stage 2)
				{ 18,  "122245",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Polished Helm of Valor
				{ 20,  "122355:Stage3H", 122340 },                                                  -- Polished Spaulders of Valor (Stage 3)
				{ 21,  "122355:Stage2H", 122338 },                                                  -- Polished Spaulders of Valor (Stage 2)
				{ 22,  "122355",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Polished Spaulders of Valor
				{ 24,  "122381:Stage3H", 122340 },                                                  -- Polished Breastplate of Valor (Stage 3)
				{ 25,  "122381:Stage2H", 122338 },                                                  -- Polished Breastplate of Valor (Stage 2)
				{ 26,  "122381",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Polished Breastplate of Valor
				{ 28,  "122251:Stage3H", 122340 },                                                  -- Polished Legplates of Valor (Stage 3)
				{ 29,  "122251:Stage2H", 122338 },                                                  -- Polished Legplates of Valor (Stage 2)
				{ 30,  "122251",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Polished Legplates of Valor
				{ 101, "127012:Stage3H", 122340 },                                                  -- Pristine Lightforge Helm
				{ 102, "127012:Stage2H", 122338 },                                                  -- Pristine Lightforge Helm
				{ 103, "127012",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Pristine Lightforge Helm
				{ 105, "127011:Stage3H", 122340 },                                                  -- Pristine Lightforge Breastplate
				{ 106, "127011:Stage2H", 122338 },                                                  -- Pristine Lightforge Breastplate
				{ 107, "127011",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Pristine Lightforge Breastplate
				{ 109, "127012:Stage3H", 122340 },                                                  -- Pristine Lightforge Legplates
				{ 110, "127012:Stage2H", 122338 },                                                  -- Pristine Lightforge Legplates
				{ 111, "127012",         [PRICE_EXTRA_ITTYPE] = "money:5000000" },                  -- Pristine Lightforge Legplates
			},
		},
		{ --HeirloomWeapons
			name = AL["Weapons"].." & "..AL["Shields"],
			[NORMAL_DIFF] = {
				{ 1,   "122349:Stage3H", 122341 },                                                  -- Bloodied Arcanite Reaper
				{ 2,   "122349:Stage2H", 122339 },                                                  -- Bloodied Arcanite Reaper
				{ 3,   "122349",         [PRICE_EXTRA_ITTYPE] = "money:7500000-darkmoon:75-championsseal:40" }, -- Bloodied Arcanite Reaper
				{ 5,   "122352:Stage3H", 122341 },                                                  -- Charmed Ancient Bone Bow
				{ 6,   "122352:Stage2H", 122339 },                                                  -- Charmed Ancient Bone Bow
				{ 7,   "122352",         [PRICE_EXTRA_ITTYPE] = "money:7500000-darkmoon:75-championsseal:40" }, -- Charmed Ancient Bone Bow
				{ 9,   "122353:Stage3H", 122341 },                                                  -- Dignified Headmaster's Charge
				{ 10,  "122353:Stage2H", 122339 },                                                  -- Dignified Headmaster's Charge
				{ 11,  "122353",         [PRICE_EXTRA_ITTYPE] = "money:7500000-darkmoon:75-championsseal:40" }, -- Dignified Headmaster's Charge
				{ 13,  "122363:Stage3H", 122341 },                                                  -- Burnished Warden Staff
				{ 14,  "122363:Stage2H", 122339 },                                                  -- Burnished Warden Staff
				{ 15,  "122363",         [PRICE_EXTRA_ITTYPE] = "money:7500000-darkmoon:75-championsseal:40" }, -- Burnished Warden Staff
				{ 16,  "122386:Stage3H", 122341 },                                                  -- Repurposed Lava Dredger
				{ 17,  "122386:Stage2H", 122339 },                                                  -- Repurposed Lava Dredger
				{ 18,  "122386",         [PRICE_EXTRA_ITTYPE] = "money:7500000-darkmoon:75-championsseal:40" }, -- Repurposed Lava Dredger
				{ 20,  "122391:Stage3H", 122340 },                                                  -- Flamescarred Draconian Deflector
				{ 21,  "122391:Stage2H", 122338 },                                                  -- Flamescarred Draconian Deflector
				{ 22,  "122391",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Flamescarred Draconian Deflector
				{ 24,  "122392:Stage3H", 122340 },                                                  -- Weathered Observer's Shield
				{ 25,  "122392:Stage2H", 122338 },                                                  -- Weathered Observer's Shield
				{ 26,  "122392",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Weathered Observer's Shield
				{ 28,  "122390:Stage3H", 122340 },                                                  -- Musty Tome of the Lost
				{ 29,  "122390:Stage2H", 122338 },                                                  -- Musty Tome of the Lost
				{ 30,  "122390",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:50-championsseal:25" }, -- Musty Tome of the Lost
				{ 101, "122350:Stage3H", 122341 },                                                  -- Balanced Heartseeker
				{ 102, "122350:Stage2H", 122339 },                                                  -- Balanced Heartseeker
				{ 103, "122350",         [PRICE_EXTRA_ITTYPE] = "money:6500000-darkmoon:50-championsseal:25" }, -- Balanced Heartseeker
				{ 105, "122351:Stage3H", 122341 },                                                  -- Venerable Dal'Rend's Sacred Charge
				{ 106, "122351:Stage2H", 122339 },                                                  -- Venerable Dal'Rend's Sacred Charge
				{ 107, "122351",         [PRICE_EXTRA_ITTYPE] = "money:6500000-darkmoon:50-championsseal:25" }, -- Venerable Dal'Rend's Sacred Charge
				{ 109, "122354:Stage3H", 122341 },                                                  -- Devout Aurastone Hammer
				{ 110, "122354:Stage2H", 122339 },                                                  -- Devout Aurastone Hammer
				{ 111, "122354",         [PRICE_EXTRA_ITTYPE] = "money:6500000-darkmoon:50-championsseal:25" }, -- Devout Aurastone Hammer
				{ 113, "122385:Stage3H", 122341 },                                                  -- Venerable Mass of McGowan
				{ 114, "122385:Stage2H", 122339 },                                                  -- Venerable Mass of McGowan
				{ 115, "122385",         [PRICE_EXTRA_ITTYPE] = "money:6500000-darkmoon:50-championsseal:25" }, -- Venerable Mass of McGowan
				{ 116, "122389:Stage3H", 122341 },                                                  -- Bloodsoaked Skullforge Reaver
				{ 117, "122389:Stage2H", 122339 },                                                  -- Bloodsoaked Skullforge Reaver
				{ 118, "122389",         [PRICE_EXTRA_ITTYPE] = "money:6500000-darkmoon:50-championsseal:25" }, -- Bloodsoaked Skullforge Reaver
				{ 120, "122396:Stage3H", 122341 },                                                  -- Brawler's Razor Claws
				{ 121, "122396:Stage2H", 122339 },                                                  -- Brawler's Razor Claws
				{ 122, "122396",         [PRICE_EXTRA_ITTYPE] = "money:8000000" },                  -- Brawler's Razor Claws
			},
		},
		{ --HeirloomTrinketsNecklacesRings
			name = AL["Trinkets"].." & "..AL["Necklaces"].." & "..AL["Rings"],
			[NORMAL_DIFF] = {
				{ 1,   "122362:Stage3H", 122340 },                                                  -- Discerning Eye of the Beast
				{ 2,   "122362:Stage2H", 122338 },                                                  -- Discerning Eye of the Beast
				{ 3,   "122362",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:70-championsseal:35" }, -- Discerning Eye of the Beast
				{ 5,   "122662:Stage3H", 122340 },                                                  -- Eternal Talisman of Evasion
				{ 6,   "122662:Stage2H", 122338 },                                                  -- Eternal Talisman of Evasion
				{ 7,   "122662",         [PRICE_EXTRA_ITTYPE] = "money:7000000" },                  -- Eternal Talisman of Evasion
				{ 9,   "122666:Stage3H", 122340 },                                                  -- Eternal Woven Ivy Necklace
				{ 10,  "122666:Stage2H", 122338 },                                                  -- Eternal Woven Ivy Necklace
				{ 11,  "122666",         [PRICE_EXTRA_ITTYPE] = "money:7000000" },                  -- Eternal Woven Ivy Necklace
				{ 13,  "122663:Stage3H", 122340 },                                                  -- Eternal Amulet of the Redeemed
				{ 14,  "122663:Stage2H", 122338 },                                                  -- Eternal Amulet of the Redeemed
				{ 15,  "122663",         [PRICE_EXTRA_ITTYPE] = "money:7000000" },                  -- Eternal Amulet of the Redeemed
				{ 16,  "122361:Stage3H", 122340 },                                                  -- Swift Hand of Justice
				{ 17,  "122361:Stage2H", 122338 },                                                  -- Swift Hand of Justice
				{ 18,  "122361",         [PRICE_EXTRA_ITTYPE] = "money:5000000-darkmoon:70-championsseal:35" }, -- Swift Hand of Justice
				{ 20,  "122667:Stage3H", 122340 },                                                  -- Eternal Emberfury Talisman
				{ 21,  "122667:Stage2H", 122338 },                                                  -- Eternal Emberfury Talisman
				{ 22,  "122667",         [PRICE_EXTRA_ITTYPE] = "money:7000000" },                  -- Eternal Emberfury Talisman
				{ 24,  "122668:Stage3H", 122340 },                                                  -- Eternal Will of the Martyr
				{ 25,  "122668:Stage2H", 122338 },                                                  -- Eternal Will of the Martyr
				{ 26,  "122668",         [PRICE_EXTRA_ITTYPE] = "money:7000000" },                  -- Eternal Will of the Martyr
				{ 28,  "122664:Stage3H", 122340 },                                                  -- Eternal Horizon Choker
				{ 29,  "122664:Stage2H", 122338 },                                                  -- Eternal Horizon Choker
				{ 30,  "122664",         [PRICE_EXTRA_ITTYPE] = "money:7000000" },                  -- Eternal Horizon Choker
				{ 101, "122529:Stage3H", 122340 },                                                  -- Dread Pirate Ring
				{ 102, "122529:Stage2H", 122338 },                                                  -- Dread Pirate Ring
				{ 103, "122529",         [QUEST_EXTRA_ITTYPE] = 8193 },                             -- Dread Pirate Ring
				{ 105, "128169:Stage3H", 122340 },                                                  -- Signet of the Third Fleet
				{ 106, "128169:Stage2H", 122338 },                                                  -- Signet of the Third Fleet
				{ 107, "128169" },                                                                  --, [QUEST_EXTRA_ITTYPE] = 8193 },	-- Signet of the Third Fleet
				{ 109, "128172:Stage3H", 122340 },                                                  -- Captain Sander's Returned Band
				{ 110, "128172:Stage2H", 122338 },                                                  -- Captain Sander's Returned Band
				{ 111, "128172" },                                                                  --, [QUEST_EXTRA_ITTYPE] = 8193 },	-- Captain Sander's Returned Band
				{ 113, "128173:Stage3H", 122340 },                                                  -- Admiral Taylor's Loyalty Ring
				{ 114, "128173:Stage2H", 122338 },                                                  -- Admiral Taylor's Loyalty Ring
				{ 115, "128173" },                                                                  --, [QUEST_EXTRA_ITTYPE] = 8193 },	-- Admiral Taylor's Loyalty Ring
				{ 116, "126948" },                                                                  --, [QUEST_EXTRA_ITTYPE] = 8193 },	-- Defending Champion
				{ 118, "126949" },                                                                  --, [QUEST_EXTRA_ITTYPE] = 8193 },	-- Returning Champion
				{ 120, "128318" },                                                                  --, [QUEST_EXTRA_ITTYPE] = 8193 },	-- Touch of the Void
			},
		},
		{ --HeirloomPVPArmor
			name = AL["PvP"].." "..AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1,  "122372:Stage3H", 122340 },                                -- Strengthened Stockade Pauldrons
				{ 2,  "122372:Stage2H", 122338 },                                -- Strengthened Stockade Pauldrons
				{ 3,  "122372",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Strengthened Stockade Pauldrons
				{ 16, "122373:Stage3H", 122340 },                                -- Pristine Lightforge Spaulders
				{ 17, "122373:Stage2H", 122338 },                                -- Pristine Lightforge Spaulders
				{ 18, "122373",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Pristine Lightforge Spaulders
				{ 5,  "122374:Stage3H", 122340 },                                -- Prized Beastmaster's Mantle
				{ 6,  "122374:Stage2H", 122338 },                                -- Prized Beastmaster's Mantle
				{ 7,  "122374",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Prized Beastmaster's Mantle
				{ 20, "122375:Stage3H", 122340 },                                -- Aged Pauldrons of The Five Thunders
				{ 21, "122375:Stage2H", 122338 },                                -- Aged Pauldrons of The Five Thunders
				{ 22, "122375",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Aged Pauldrons of The Five Thunders
				{ 9,  "122376:Stage3H", 122340 },                                -- Exceptional Stormshroud Shoulders
				{ 10, "122376:Stage2H", 122338 },                                -- Exceptional Stormshroud Shoulders
				{ 11, "122376",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Exceptional Stormshroud Shoulders
				{ 24, "122377:Stage3H", 122340 },                                -- Lasting Feralheart Spaulders
				{ 25, "122377:Stage2H", 122338 },                                -- Lasting Feralheart Spaulders
				{ 26, "122377",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Lasting Feralheart Spaulders
				{ 13, "122378:Stage3H", 122340 },                                -- Exquisite Sunderseer Mantle
				{ 14, "122378:Stage2H", 122338 },                                -- Exquisite Sunderseer Mantle
				{ 15, "122378",         [PRICE_EXTRA_ITTYPE] = "money:5000000-honor:1000" }, -- Exquisite Sunderseer Mantle
			},
		},
		{ --HeirloomPVPWeapon
			name = AL["PvP"].." "..AL["Weapons"],
			[NORMAL_DIFF] = {
				{ 1,  "122364:Stage3H", 122341 },                                -- Sharpened Scarlet Kris
				{ 2,  "122364:Stage2H", 122339 },                                -- Sharpened Scarlet Kris
				{ 3,  "122364",         [PRICE_EXTRA_ITTYPE] = "money:6500000-honor:1000" }, -- Sharpened Scarlet Kris
				{ 5,  "122367:Stage3H", 122341 },                                -- The Blessed Hammer of Grace
				{ 6,  "122367:Stage2H", 122339 },                                -- The Blessed Hammer of Grace
				{ 7,  "122367",         [PRICE_EXTRA_ITTYPE] = "money:6500000-honor:1000" }, -- The Blessed Hammer of Grace
				{ 9,  "122369:Stage3H", 122341 },                                -- Battleworn Thrash Blade
				{ 10, "122369:Stage2H", 122339 },                                -- Battleworn Thrash Blade
				{ 11, "122369",         [PRICE_EXTRA_ITTYPE] = "money:6500000-honor:1000" }, -- Battleworn Thrash Blade
				{ 16, "122366:Stage3H", 122341 },                                -- Upgraded Dwarven Hand Cannon
				{ 17, "122366:Stage2H", 122339 },                                -- Upgraded Dwarven Hand Cannon
				{ 18, "122366",         [PRICE_EXTRA_ITTYPE] = "money:7500000-honor:1500" }, -- Upgraded Dwarven Hand Cannon
				{ 20, "122368:Stage3H", 122341 },                                -- Grand Staff of Jordan
				{ 21, "122368:Stage2H", 122339 },                                -- Grand Staff of Jordan
				{ 22, "122368",         [PRICE_EXTRA_ITTYPE] = "money:7500000-honor:1500" }, -- Grand Staff of Jordan
				{ 24, "122365:Stage3H", 122341 },                                -- Reforged Truesilver Champion
				{ 25, "122365:Stage2H", 122339 },                                -- Reforged Truesilver Champion
				{ 26, "122365",         [PRICE_EXTRA_ITTYPE] = "money:7500000-honor:1500" }, -- Reforged Truesilver Champion

			},
		},
		{ --HeirloomPVPTrinkets
			name = AL["PvP"].." "..AL["Trinkets"],
			[ALLIANCE_DIFF] = {
				{ 1,  "122530:Stage3H", 122340 },                                -- Inherited Mark of Tyranny
				{ 2,  "122530:Stage2H", 122338 },                                -- Inherited Mark of Tyranny
				{ 3,  "122530",         [PRICE_EXTRA_ITTYPE] = "money:7000000-honor:1250" }, -- Strengthened Stockade Pauldrons
				{ 16, "122371:Stage3H", 122340 },                                -- Inherited Insignia of the Alliance
				{ 17, "122371:Stage2H", 122338 },                                -- Inherited Insignia of the Alliance
				{ 18, "122371",         [PRICE_EXTRA_ITTYPE] = "money:7000000-honor:1250" }, -- Inherited Insignia of the Alliance
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, "122370:Stage3H", 122340 },                                -- Inherited Insignia of the Horde
				{ 17, "122370:Stage2H", 122338 },                                -- Inherited Insignia of the Horde
				{ 18, "122370",         [PRICE_EXTRA_ITTYPE] = "money:7000000-honor:1250" }, -- Inherited Insignia of the Horde
			},
		},
		{ --HeirloomMiscellaneous
			name = AL["Miscellaneous"],
			[NORMAL_DIFF] = {
				{ 1, 122703, "ac9909" }, -- Chauffeured Chopper
			},
		},
	},
}

data["LEGION_LEGENDARIES"] = {
	name = AL["Legendary Items"].." - "..EXPANSION_NAME6,
	ContentType = COLLECTION_CONTENT,
	items = {
		{ -- all classes
			name = ALL_CLASSES,
			[LEGENDARY_DIFF] = {
				{ 1,  144249 }, -- Archimonde's Hatred Reborn
				{ 2,  144258 }, -- Velen's Future Sight
				{ 3,  144259 }, -- Kil'jaeden's Burning Wish
				{ 4,  132444 }, -- Prydaz, Xavaric's Magnum Opus
				{ 5,  132452 }, -- Sephuz's Secret
				{ 16, 143613 }, -- Distilled Titan Essence
			},
		},
		{ -- DEATHKNIGHT
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[LEGENDARY_DIFF] = {
				{ 1,  144280 }, -- Death March
				{ 2,  132459 }, -- Perseverance of the Ebon Martyr
				{ 3,  137075 }, -- Tak'theritrix's Shoulderpads
				{ 4,  144281 }, -- Skullflower's Haemostasis
				{ 5,  132376 }, -- Acherus Drapes
				{ 6,  132366 }, -- Koltira's Newfound Will
				{ 7,  132367 }, -- Service of Gorefiend
				{ 8,  132441 }, -- Draugr, Girdle of the Everlasting King
				{ 9,  144293 }, -- Consort's Cold Core
				{ 10, 132453 }, -- Rattlegore Bone Legplates
				{ 11, 132365 }, -- Shackles of Bryndaor
				{ 12, 132458 }, -- Toravon's Whiteout Bindings
				{ 13, 132448 }, -- The Instructor's Fourth Lesson
				{ 14, 137037 }, -- Uvanimor, the Unbeautiful
				{ 15, 137223 }, -- Seal of Necrofantasia
				{ 16, 133974 }, -- Lana'thel's Lament
			},
		},
		{ -- DEMONHUNTER
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[LEGENDARY_DIFF] = {
				{ 1,  137061 }, -- Raddon's Cascading Eyes
				{ 2,  144279 }, -- Delusions of Grandeur
				{ 3,  137071 }, -- Runemaster's Pauldrons
				{ 4,  137014 }, -- Achor, the Eternal Hunger
				{ 5,  137066 }, -- Cloak of Fel Flames
				{ 6,  133976 }, -- Cinidaria, the Symbiote
				{ 7,  138949 }, -- Kirel Narak
				{ 8,  137022 }, -- Loramus Thalipedes' Sacrifice
				{ 9,  137091 }, -- The Defiler's Lost Vambraces
				{ 10, 137090 }, -- Mo'arg Bionic Stabilizers
				{ 11, 144292 }, -- Spirit of the Darkness Flame
				{ 12, 138854 }, -- Fragment of the Betrayer's Prison
				{ 13, 137038 }, -- Anger of the Half-Giants
			},
		},
		{ -- DRUID
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[LEGENDARY_DIFF] = {
				{ 1,  144432 }, -- Oakheart's Puny Quods
				{ 2,  137062 }, -- The Emerald Dreamcatcher
				{ 3,  137072 }, -- Aman'Thul's Wisdom
				{ 4,  144295 }, -- Lady and the Child
				{ 5,  137015 }, -- Ekowraith, Creator of Worlds
				{ 6,  137078 }, -- The Dark Titan's Advice
				{ 7,  133976 }, -- Cinidaria, the Symbiote
				{ 8,  144354 }, -- Fiery Red Maimers
				{ 9,  137067 }, -- Elize's Everlasting Encasement
				{ 10, 137023 }, -- Promise of Elune, the Moon Goddess
				{ 11, 137024 }, -- Ailuro Pouncers
				{ 12, 137025 }, -- Skysec's Hold
				{ 13, 137026 }, -- Essence of Infusion
				{ 14, 137092 }, -- Oneth's Intuition
				{ 15, 137095 }, -- Edraith, Bonds of Aglaya
				{ 16, 137056 }, -- Luffa Wrappings
				{ 17, 137094 }, -- The Wildshaper's Clutch
				{ 18, 144242 }, -- X'oni's Caress
				{ 19, 137039 }, -- Impeccable Fel Essence
				{ 20, 137040 }, -- Chatoyant Signet
				{ 21, 137041 }, -- Dual Determination
				{ 22, 137042 }, -- Tearstone of Elune
			},
		},
		{ -- HUNTER
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[LEGENDARY_DIFF] = {
				{ 1,  137064 }, -- The Shadow Hunter's Voodoo Mask
				{ 2,  144326 }, -- The Mantle of Command
				{ 3,  144361 }, -- Butcher's Bone Apron
				{ 4,  137082 }, -- Helbrine, Rope of the Mist Marauder
				{ 5,  137080 }, -- Roar of the Seven Lions
				{ 6,  137081 }, -- War Belt of the Sentinel Army
				{ 7,  132466 }, -- Roots of Shaladrassil
				{ 8,  137227 }, -- Qa'pla, Eredun War Order
				{ 9,  137033 }, -- Ullr's Feather Snowshoes
				{ 10, 137034 }, -- Nesingwary's Trapping Treads
				{ 11, 141353 }, -- Magnetized Blasting Cap Launcher
				{ 12, 137101 }, -- Call of the Wild
				{ 13, 144303 }, -- MKII Gyroscopic Stabilizer
				{ 14, 137382 }, -- The Apex Predator's Claw
				{ 15, 137043 }, -- Frizzo's Fingertrap
				{ 16, 137055 }, -- Zevrim's Hunger
			},
		},
		{ -- MAGE
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[LEGENDARY_DIFF] = {
				{ 1,  144274 }, -- Gravity Spiral
				{ 2,  132863 }, -- Darckli's Dragonfire Diadem
				{ 3,  144260 }, -- Ice Time
				{ 4,  133977 }, -- Belo'vir's Final Stand
				{ 5,  133970 }, -- Zann'esu Journey
				{ 6,  132442 }, -- Cord of Infinity
				{ 7,  132454 }, -- Koralon's Burning Touch
				{ 8,  132451 }, -- Mystic Kilt of the Rune Master
				{ 9,  132455 }, -- Norgannon's Foresight
				{ 10, 132406 }, -- Marquee Bindings of the Sun King
				{ 11, 132413 }, -- Rhonin's Assaulting Armwraps
				{ 12, 138140 }, -- Magtheridon's Banished Bracers
				{ 13, 144355 }, -- Pyrotex Ignition Cloth
				{ 14, 132411 }, -- Lady Vashj's Grasp
				{ 15, 132410 }, -- Shard of the Exodar
			},
		},
		{ -- MONK
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[LEGENDARY_DIFF] = {
				{ 1,  137063 }, -- Fundamental Observation
				{ 2,  137073 }, -- Unison Spaulders
				{ 3,  144239 }, -- The Emperor's Capacitor
				{ 4,  144340 }, -- Shelter of Rin
				{ 5,  137016 }, -- Sal'salabim's Lost Tunic
				{ 6,  137019 }, -- Cenedril, Reflector of Hatred
				{ 7,  137079 }, -- Gai Plin's Soothing Sash
				{ 8,  138879 }, -- Ovyd's Winter Wrap
				{ 9,  133976 }, -- Cinidaria, the Symbiote
				{ 10, 137068 }, -- Leggings of The Black Flame
				{ 11, 137027 }, -- Firestone Walkers
				{ 12, 137028 }, -- Ei'thas, Lunar Glides of Eramas
				{ 13, 137029 }, -- Katsuo's Eclipse
				{ 14, 137096 }, -- Petrichor Lagniappe
				{ 15, 137097 }, -- Drinking Horn Cover
				{ 16, 144277 }, -- Anvil-Hardened Wristwraps
				{ 17, 137057 }, -- Hidden Master's Forbidden Touch
				{ 18, 137044 }, -- Jewel of the Lost Abbey
				{ 19, 137220 }, -- March of the Legion
				{ 20, 137045 }, -- Eye of Collidus the Warp-Watcher
			},
		},
		{ -- PALADIN
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[LEGENDARY_DIFF] = {
				{ 1,  144275 }, -- Saruan's Resolve
				{ 2,  137065 }, -- Justice Gaze
				{ 3,  144358 }, -- Ashes to Dust
				{ 4,  137076 }, -- Obsidian Stone Spaulders
				{ 5,  137017 }, -- Breastplate of the Golden Val'kyr
				{ 6,  137020 }, -- Whisper of the Nathrezim
				{ 7,  144273 }, -- Maraad's Dying Breath
				{ 8,  137086 }, -- Chain of Thrayn
				{ 9,  137070 }, -- Tyelca, Ferren Marcus's Stature
				{ 10, 132443 }, -- Aggramar's Stride
				{ 11, 137105 }, -- Uther's Guard
				{ 12, 140846 }, -- Aegisjalmur, the Armguards of Awe
				{ 13, 137059 }, -- Tyr's Hand of Faith
				{ 14, 137046 }, -- Ilterendi, Crown Jewel of Silvermoon
				{ 15, 137047 }, -- Heathcliff's Immortality
				{ 16, 137048 }, -- Liadrin's Fury Unleashed
			},
		},
		{ -- PRIEST
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[LEGENDARY_DIFF] = {
				{ 1,  133971 }, -- Zenk'aram, Iridi's Anadem
				{ 2,  144244 }, -- Kam Xi'raff
				{ 3,  132437 }, -- Mother Shahraz's Seduction
				{ 4,  132861 }, -- Estel, Dejahna's Inspiration
				{ 5,  137109 }, -- X'anshi, Shroud of Archbishop Benedictus
				{ 6,  144438 }, -- Zeks Exterminatus
				{ 7,  133800 }, -- Cord of Maiev, Priestess of the Moon
				{ 8,  132864 }, -- Mangaza's Madness
				{ 9,  132445 }, -- Al'maiesh, the Cord of Hope
				{ 10, 132447 }, -- Entrancing Trousers of An'juna
				{ 11, 132455 }, -- Norgannon's Foresight
				{ 12, 132409 }, -- Anund's Seared Shackles
				{ 13, 132436 }, -- Skjoldr, Sanctuary of Ivagont
				{ 14, 132450 }, -- Muze's Unwavering Will
				{ 15, 144247 }, -- Rammal's Ulterior Motive
				{ 16, 132461 }, -- Xalan the Feared's Clench
				{ 17, 133973 }, -- The Twins' Painful Touch
				{ 18, 137276 }, -- N'ero, Band of Promises
				{ 19, 132449 }, -- Phyrix's Embrace
			},
		},
		{ -- ROGUE
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[LEGENDARY_DIFF] = {
				{ 1,  144236 }, -- Mantle of the Master Assassin
				{ 2,  137021 }, -- The Dreadlord's Deceit
				{ 3,  133976 }, -- Cinidaria, the Symbiote
				{ 4,  137069 }, -- Will of Valeera
				{ 5,  137032 }, -- Shadow Satyr's Walk
				{ 6,  137031 }, -- Thraxi's Tricksy Treads
				{ 7,  137030 }, -- Duskwalker's Footpads
				{ 8,  137100 }, -- Denial of the Half-Giants
				{ 9,  137099 }, -- Greenskin's Waterlogged Wristcuffs
				{ 10, 137098 }, -- Zoldyck Family Training Shackles
				{ 11, 141321 }, -- Shivarran Symmetry
				{ 12, 137049 }, -- Insignia of Ravenholdt
			},
		},
		{ -- SHAMAN
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[LEGENDARY_DIFF] = {
				{ 1,  143732 }, -- Uncertain Reminder
				{ 2,  137074 }, -- Echoes of the Great Sundering
				{ 3,  137616 }, -- Emalon's Charged Core
				{ 4,  137103 }, -- Storm Tempests
				{ 5,  137085 }, -- Intact Nazjatar Molting
				{ 6,  137083 }, -- Pristine Proto-Scale Girdle
				{ 7,  132466 }, -- Roots of Shaladrassil
				{ 8,  138117 }, -- Spiritual Journey
				{ 9,  137035 }, -- The Deceiver's Blood Pact
				{ 10, 137036 }, -- Elemental Rebalancers
				{ 11, 137102 }, -- Al'Akir's Acrimony
				{ 12, 137104 }, -- Nobundo's Redemption
				{ 13, 137084 }, -- Akainu's Absolute Justice
				{ 14, 137058 }, -- Praetorian's Tidecallers
				{ 15, 137050 }, -- Eye of the Twisting Nether
				{ 16, 137051 }, -- Focuser of Jonat, the Elder
			},
		},
		{ -- WARLOCK
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[LEGENDARY_DIFF] = {
				{ 1,  144385 }, -- Wakener's Loyalty
				{ 2,  132394 }, -- Hood of Eternal Disdain
				{ 3,  144369 }, -- Lessons of Space-Time
				{ 4,  132393 }, -- Recurrent Ritual
				{ 5,  144364 }, -- Reap and Sow
				{ 6,  132375 }, -- Odr, Shawl of the Ymirjar
				{ 7,  132456 }, -- Feretory of Souls
				{ 8,  132457 }, -- Power Cord of Lethtendris
				{ 9,  132374 }, -- Kazzak's Final Curse
				{ 10, 132357 }, -- Pillars of the Dark Portal
				{ 11, 132455 }, -- Norgannon's Foresight
				{ 12, 132379 }, -- Sin'dorei Spite
				{ 13, 132381 }, -- Streten's Sleepless Shackles
				{ 14, 132407 }, -- Magistrike Restraints
				{ 15, 132460 }, -- Alythess's Pyrogenics
				{ 16, 132369 }, -- Wilfred's Sigil of Superior Summoning
				{ 17, 132378 }, -- Sacrolash's Dark Strike
			},
		},
		{ -- WARRIOR
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[LEGENDARY_DIFF] = {
				{ 1,  137088 }, -- Ceann-Ar Charger
				{ 2,  143728 }, -- Timeless Stratagem
				{ 3,  137018 }, -- Destiny Driver
				{ 4,  137053 }, -- Kazzalax, Fujieda's Fury
				{ 5,  137089 }, -- Thundergod's Vigor
				{ 6,  137087 }, -- Naj'entus's Vertebrae
				{ 7,  137077 }, -- Weight of the Earth
				{ 8,  132443 }, -- Aggramar's Stride
				{ 9,  137107 }, -- Mannoroth's Bloodletting Manacles
				{ 10, 137108 }, -- Kakushan's Stormscale Gauntlets
				{ 11, 137060 }, -- Archavon's Heavy Hand
				{ 12, 137052 }, -- Ayala's Stone Heart
				{ 13, 137054 }, -- The Walls Fell
			},
		},
	},
}

data["LEGENDARIES"]        = {
	name = AL["Legendary Items"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{ -- Dragonflight
			name = EXPANSION_NAME9,
			[NORMAL_DIFF] = {
				{ 1, 204177 }, -- Nasz'uro, the Unbound Legacy
				{ 3, 207728 }, -- Fyr'alath the Dreamrender
				{ 4, 206448 }, -- Fyr'alath the Dreamrender
			},
		},
		{ -- Shadowlands
			name = EXPANSION_NAME8,
			[NORMAL_DIFF] = {
				{ 1, 186414, "ac15191" }, -- Rae'shalare, Death's Whisper
			},
		},
		{ -- BFA
			name = EXPANSION_NAME7,
			[NORMAL_DIFF] = {
				{ 1, 169223 }, -- Ashjra'kamas, Shroud of Resolve
			},
		},
		{ -- Warlords of Draenor
			name = EXPANSION_NAME5,
			[ALLIANCE_DIFF] = {
				{ 1,  124634, "ac10021" }, -- Thorasus, the Stone Heart of Draenor
				{ 2,  124635, "ac10021" }, -- Nithramus, the All-Seer
				{ 3,  124636, "ac10021" }, -- Maalus, the Blood Drinker
				{ 4,  124637, "ac10021" }, -- Sanctus, Sigil of the Unbroken
				{ 5,  124638, "ac10021" }, -- Etheralus, the Eternal Reward
				{ 16, 127785 }, -- Crystallized Fel
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 124634, "ac10148" }, -- Thorasus, the Stone Heart of Draenor
				{ 2, 124635, "ac10148" }, -- Nithramus, the All-Seer
				{ 3, 124636, "ac10148" }, -- Maalus, the Blood Drinker
				{ 4, 124637, "ac10148" }, -- Sanctus, Sigil of the Unbroken
				{ 5, 124638, "ac10148" }, -- Etheralus, the Eternal Reward
			},
		},
		{ -- Mists of Pandaria
			name = EXPANSION_NAME4,
			[ALLIANCE_DIFF] = {
				{ 1,  102248, "ac8325" }, -- Fen-Yu, Fury of Xuen
				{ 2,  102249, "ac8325" }, -- Gong-Lu, Strength of Xuen
				{ 3,  102247, "ac8325" }, -- Jina-Kang, Kindness of Chi-Ji
				{ 4,  102245, "ac8325" }, -- Qian-Le, Courage of Niuzao
				{ 5,  102250, "ac8325" }, -- Qian-Ying, Fortitude of Niuzao
				{ 6,  102246, "ac8325" }, -- Xing-Ho, Breath of Yu'lon
				{ 8,  95346,  "ac7535" }, -- Capacitive Primal Diamond
				{ 9,  95345,  "ac7535" }, -- Courageous Primal Diamond
				{ 10, 95344,  "ac7535" }, -- Indomitable Primal Diamond
				{ 11, 95347,  "ac7535" }, -- Sinister Primal Diamond
				{ 16, 93403,  "ac7534" }, -- Eye of the Black Prince
				{ 19, 89873,  "ac7533" }, -- Crystallized Dread
				{ 20, 89882,  "ac7533" }, -- Crystallized Horror
				{ 21, 89881,  "ac7533" }, -- Crystallized Terror
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 93403, "ac8008" }, -- Eye of the Black Prince
			},
		},
		{ -- Cataclysm
			name = EXPANSION_NAME3,
			[NORMAL_DIFF] = {
				{ 1,  77949, "ac6181" }, -- Golad, Twilight of Aspects
				{ 2,  77950, "ac6181" }, -- Tiriosh, Nightmare of Ages
				{ 3,  77947 }, -- The Sleeper
				{ 4,  77948 }, -- The Dreamer
				{ 5,  77945 }, -- Fear
				{ 6,  77946 }, -- Vengeance
				{ 16, 71086, "ac5839" }, -- Dragonwrath, Tarecgosa's Rest
				{ 17, 71085 }, -- Runestaff of Nordrassil
				{ 18, 71084 }, -- Branch of Nordrassil
			},
		},
		{ -- Wrath of the Lich King
			name = EXPANSION_NAME2,
			[NORMAL_DIFF] = {
				{ 1,  49623, "ac4623" }, -- Shadowmourne
				{ 2,  49888 }, -- Shadow's Edge
				{ 16, 46017, "ac3142" }, -- Val'anyr, Hammer of Ancient Kings
			},
		},
		{ -- The Burning Crusade
			name = EXPANSION_NAME1,
			[NORMAL_DIFF] = {
				{ 1,  34334, "ac725" }, -- Thori'dal, the Stars' Fury
				{ 3,  32837, "ac426" }, -- Warglaive of Azzinoth
				{ 4,  32838, "ac426" }, -- Warglaive of Azzinoth
				{ 16, 30312 }, -- Infinity Blade
				{ 17, 30311 }, -- Warp Slicer
				{ 18, 30316 }, -- Devastation
				{ 19, 30317 }, -- Cosmic Infuse
				{ 20, 30313 }, -- Staff of Disintegration
				{ 21, 30318 }, -- Netherstrand Longbow
				{ 22, 30314 }, -- Phaseshift Bulwark
			},
		},
		{ -- Classic
			name = EXPANSION_NAME0,
			[NORMAL_DIFF] = {
				{ 1,  22632, "ac425" }, -- Atiesh, Greatstaff of the Guardian
				{ 2,  22589, "ac425" }, -- Atiesh, Greatstaff of the Guardian
				{ 3,  22631, "ac425" }, -- Atiesh, Greatstaff of the Guardian
				{ 4,  22630, "ac425" }, -- Atiesh, Greatstaff of the Guardian
				{ 6,  21176, "ac416" }, -- Black Qiraji Resonating Crystal
				{ 16, 19019, "ac428" }, -- Thunderfury, Blessed Blade of the Windseeker
				{ 18, 17182, "ac429" }, -- Sulfuras, Hand of Ragnaros
				{ 19, 17193 }, -- Sulfuron Hammer
			},
		},
	},
}

data["MOLTENFRONT"]        = {
	name = ALIL["Molten Front"].." "..AL["Rewards"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{
			name = AL["Vendor"]..": "..AL["Zen'Vorka"],
			[ALLIANCE_DIFF] = {
				{ 1,  70108, [PRICE_EXTRA_ITTYPE] = "money:1801998" }, -- Pyrelord Greaves
				{ 2,  70107, [PRICE_EXTRA_ITTYPE] = "money:1014508" }, -- Fireheart Necklace
				{ 3,  70106, [PRICE_EXTRA_ITTYPE] = "money:1014508" }, -- Nightweaver's Amulet
				{ 4,  70105, [PRICE_EXTRA_ITTYPE] = "money:1014508" }, -- Matoclaw's Band
				{ 6,  71631, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Zen'Vorka's Cache
				{ 16, 70145, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Darnassus Writ of Commendation
				{ 17, 70146, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Exodar Writ of Commendation
				{ 18, 71087, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Gilneas Writ of Commendation
				{ 19, 70147, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Gnomeregan Writ of Commendation
				{ 20, 70148, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Ironforge Writ of Commendation
				{ 21, 70152, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Stormwind Writ of Commendation
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 71088, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Bilgewater Writ of Commendation
				{ 17, 70149, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Orgrimmar Writ of Commendation
				{ 18, 70150, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Sen'jin Writ of Commendation
				{ 19, 70151, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Silvermoon Writ of Commendation
				{ 20, 70153, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Thunder Bluff Writ of Commendation
				{ 21, 70154, [PRICE_EXTRA_ITTYPE] = "worldtree:30" }, -- Undercity Writ of Commendation
			},
		},
		{
			name = AL["Vendor"]..": "..AL["Ayla Shadowstorm"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil,                                   AL["Ayla Shadowstorm"],                 nil, [QUEST_EXTRA_ITTYPE] = 29279 },
				{ 2,  70110,        [PRICE_EXTRA_ITTYPE] = "money:1014508" },                             -- Band of Glittering Lights
				{ 3,  70113,        [PRICE_EXTRA_ITTYPE] = "money:1014508" },                             -- Moon Blessed Band
				{ 4,  70142,        [PRICE_EXTRA_ITTYPE] = "money:1528525" },                             -- Moonwell Chalice
				{ 5,  70143,        [PRICE_EXTRA_ITTYPE] = "money:1528525" },                             -- Moonwell Phial
				{ 6,  70112,        [PRICE_EXTRA_ITTYPE] = "money:982176" },                              -- Globe of Moonlight
				{ 17, 70175,        [PRICE_EXTRA_ITTYPE] = "money:3000000" },                             -- Pattern: Triple-Reinforced Mining Bag (p7 500)
				{ 18, 70174,        [PRICE_EXTRA_ITTYPE] = "money:3000000" },                             -- Pattern: Royal Scribe's Satchel (p7 510)
				{ 19, 70176,        [PRICE_EXTRA_ITTYPE] = "money:3000000" },                             -- Pattern: Luxurious Silk Gem Bag (p8 515)
				{ 21, 70160,        "pet318",                              [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Crimson Lasher
				{ 22, 70161,        [PRICE_EXTRA_ITTYPE] = "money:5000000" },                             -- Mushroom Chair
			},
		},
		{
			name = AL["Vendor"]..": "..AL["Varlan Highbough"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil,                                    AL["Varlan Highbough"],                 nil, [QUEST_EXTRA_ITTYPE] = 29283 },
				{ 2,  70122,        [PRICE_EXTRA_ITTYPE] = "money:840360" },                               -- Aviana's Grips
				{ 3,  70123,        [PRICE_EXTRA_ITTYPE] = "money:1525210" },                              -- Lancer's Greaves
				{ 4,  70127,        [PRICE_EXTRA_ITTYPE] = "money:1014508" },                              -- Lylagar Horn Ring
				{ 5,  70126,        [PRICE_EXTRA_ITTYPE] = "money:1014508" },                              -- Nemesis Shell Band
				{ 6,  70124,        [PRICE_EXTRA_ITTYPE] = "money:1014508" },                              -- Spirit Fragment Band
				{ 7,  70141,        [PRICE_EXTRA_ITTYPE] = "money:1528525" },                              -- Dwyer's Caber
				{ 17, 70140,        "pet317",                               [PRICE_EXTRA_ITTYPE] = "money:15000000" }, -- Hyjal Bear Cub
				{ 18, 70159,        [PRICE_EXTRA_ITTYPE] = "money:35000000" },                             -- Mylune's Call
			},
		},
		{
			name = AL["Vendor"]..": "..AL["Damek Bloombeard"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil,                                   AL["Damek Bloombeard"], nil, [QUEST_EXTRA_ITTYPE] = 29281 },
				{ 2,  70118,        [PRICE_EXTRA_ITTYPE] = "money:731902" }, -- Widow's Clutches
				{ 3,  70114,        [PRICE_EXTRA_ITTYPE] = "money:902050" }, -- Fireplume Girdle
				{ 4,  70115,        [PRICE_EXTRA_ITTYPE] = "money:1636746" }, -- Fiery Treads
				{ 5,  70121,        [PRICE_EXTRA_ITTYPE] = "money:1178682" }, -- Ricket's Gun Show
				{ 6,  70116,        [PRICE_EXTRA_ITTYPE] = "money:1279180" }, -- Gauntlets of Living Obsidium
				{ 7,  70117,        [PRICE_EXTRA_ITTYPE] = "money:1283724" }, -- Belt of Living Obsidium
				{ 8,  70120,        [PRICE_EXTRA_ITTYPE] = "money:1174260" }, -- Rickety Belt
				{ 9,  70119,        [PRICE_EXTRA_ITTYPE] = "money:1014508" }, -- Meteorite Ring
				{ 10, 70144,        [PRICE_EXTRA_ITTYPE] = "money:1528524" }, -- Ricket's Magnetic Fireball
				{ 17, 70166,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Brainsplinter (p2 525)
				{ 18, 70169,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Elementium-Edged Scalper (p2 525)
				{ 19, 70168,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Lightforged Elementium Hammer (p2 525)
				{ 20, 70172,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Masterwork Elementium Deathblade (p2 525)
				{ 21, 70167,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Masterwork Elementium Spellblade (p2 525)
				{ 22, 70170,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Pyrium Spellward (p2 525)
				{ 23, 70171,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Unbreakable Guardian (p2 525)
				{ 24, 70173,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Plans: Witch-Hunter's Harvester (p2 525)
				{ 25, 70177,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Schematic: Flintlocke's Woodchucker (p5 515)
				{ 26, 71078,        [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Schematic: Extreme-Impact Hole Puncher (p5 525)
			},
		},
	},
}

data["TABARDS"]            = {
	name = AL["Tabards"],
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ -- The War Within
			name = EXPANSION_NAME10,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,   218352 },                                     -- Expeditionary Tabard
				{ 2,   224166 },                                     -- Awakened Tabard
				{ 3,   218349 },                                     -- Tabard of the Severed Threads
				{ 4,   218346 },                                     -- Honorary Councilmember's Tabard
				{ 5,   218343 },                                     -- Tabard of the Assembly
				{ 6,   225946 },                                     -- Slightly Singed Arathi Tabard
				{ 7,   225999 },                                     -- Earthen Adventurer's Tabard
				{ 8,   226016 },                                     -- Darkened Tabard of the Arathi
				{ 9,   233932 },                                     -- Awakened Ambassador's Tabard
				{ 10,  233928 },                                     -- Adventurous Lamplighter's Tabard
				{ 11,  226220 },                                     -- Machine-Warden's Tabard
				{ 12,  225977, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Camo Tabard
				{ 13,  226369, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Faded Tabard
				{ 14,  229999, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Cloudy Tabard
				{ 15,  224165, [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:500" }, -- Dornogal Tabard
				{ 16,  224168, [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:500" }, -- Earthen Expedition Tabard
				{ 17,  224167, [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:500" }, -- Gundargaz Tabard
				{ 18,  232476, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Explorer's League Tabard
				{ 19,  234860, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Explorer's League Deepholm Expedition Tabard
				{ 20,  234756, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Kor'kron Tabard
				{ 21,  232478, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Area 52 Tabard
				{ 22,  234755, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Tabard of the Pandaren Elders
				{ 23,  234907, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Tattered Iron Horde Tabard
				{ 24,  234906, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Auchenai Tabard
				{ 25,  223616, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Forged Gladiator's Tabard
				{ 26,  228908 },                                     -- Bot Wrangler's Violet Apron
				{ 27,  228909 },                                     -- Bot Wrangler's Crimson Apron
				{ 28,  228762 },                                     -- Classic Lively Tabard
				{ 29,  228761 },                                     -- Classic Brick Tabard
				{ 30,  228763 },                                     -- Classic Crimson Tabard
				{ 101, 228764 },                                     -- Classic Sunny Tabard
				{ 102, 231526, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:1625" }, -- Bilgewater Undermine Tabard
				{ 103, 231528, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:1625" }, -- Blackwater Undermine Tabard
				{ 104, 231527, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:1625" }, -- Steamwheedle Undermine Tabard
				{ 105, 231542, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:1625" }, -- Venture Co. Undermine Tabard
				{ 106, 233288 },                                     -- Radiant Recruit's Tabard
				{ 107, 233289 },                                     -- Radiant Stalwart's Tabard
				{ 108, 233290 },                                     -- Sacred Templar's Tabard
				{ 109, 245968 },                                     -- Tabard of the Trust
				{ 110, 232908 },                                     -- Astral Gladiator's Tabard
				-- { 1, 233929 }, -- Sacred Tabard of the Priori (currently unobtainable)
				-- { 1, 224169 }, -- Stonebound Tabard (currently unobtainable)
				-- { 1, 249562 }, -- Skymaster's Silver Tabard (currently unobtainable)
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 18, 232477, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Hand of Vengeance Tabard
				{ 19, 234861, [PRICE_EXTRA_ITTYPE] = "timewarped:500" }, -- Reliquary Tabard
			},
		},
		{ -- Dragonflight
			name = EXPANSION_NAME9,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,   194675 },                                     -- Gilded Dracthyr's Tabard
				{ 2,   198802, [PRICE_EXTRA_ITTYPE] = "money:10000000" }, -- Artisan's Consortium Tabard
				{ 3,   198730 },                                     -- Dragonscale Expedition Tabard
				{ 4,   198731 },                                     -- Iskaara Tuskarr Tabard
				{ 5,   198732 },                                     -- Valdrakken Accord Tabard
				{ 6,   205286 },                                     -- Loamm Niffen Tabard
				{ 7,   210501 },                                     -- Dream Wardens Tabard
				{ 8,   210469 },                                     -- Personal Tabard
				{ 9,   208199 },                                     -- Tabard of the Tyr's Guard
				{ 10,  219349 },                                     -- Plunderlord's Tabard
				{ 11,  204445 },                                     -- Black Dragonflight's Tabard
				{ 12,  212336 },                                     -- The Tavern's Tabard
				{ 13,  205414 },                                     -- Ornate Black Dragon Labwear Coat
				{ 14,  205957 },                                     -- Azure Renewal Tabard
				{ 15,  207016 },                                     -- Rift-Mender's Tabard
				{ 16,  210787 },                                     -- Elegant Green Dragon Tabard
				{ 17,  213518 },                                     -- Classic Sepia Tabard
				{ 18,  211926 },                                     -- Riders of Azeroth Tabard
				{ 19,  213593 },                                     -- Frosted Riders of Azeroth Tabard
				{ 20,  212686 },                                     -- Azure Riders of Azeroth Tabard
				{ 21,  211928 },                                     -- Ruby Riders of Azeroth Tabard
				{ 22,  202090, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Crimson Gladiator's Tabard
				{ 23,  205362, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Obsidian Gladiator's Tabard
				{ 24,  209610, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Verdant Gladiator's Tabard
				{ 25,  216667, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Draconic Gladiator's Tabard
				{ 26,  206786, [PRICE_EXTRA_ITTYPE] = "paracausalFlakes:1500" }, -- Scourge Victorious Tabard
				{ 27,  206788, [PRICE_EXTRA_ITTYPE] = "paracausalFlakes:1500" }, -- Utopian Tabard
				{ 28,  190800, [PRICE_EXTRA_ITTYPE] = "tender:125" }, -- Gleaming Mail Tabard
				{ 29,  190801, [PRICE_EXTRA_ITTYPE] = "tender:125" }, -- Shadowy Mail Tabard
				{ 30,  190671, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Tabard of Wild Might
				{ 101, 213396, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Midnight Tabard
				{ 102, 221794, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Carrot Tabard
				{ 103, 211267, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Snowy Tabard
				{ 104, 212544, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Aquatic Tabard
				{ 105, 223170, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Deep Tabard
				{ 106, 212990, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Violet Tabard
				{ 107, 212374, [PRICE_EXTRA_ITTYPE] = "tender:100" }, -- Classic Rosy Tabard
				{ 108, 210424, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250" }, -- Darnassian Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1,   202197 }, -- Emboldened Dracthyr's Tabard
				{ 108, 209065 }, -- Forsaken Champion's Tabard
				{ 109, 209068 }, -- Queen Loyalist's Tabard
			},
		},
		{ -- Shadowlands
			name = EXPANSION_NAME8,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  168100, [PRICE_EXTRA_ITTYPE] = "money:25" }, -- Alliance Tabard
				{ 2,  178336, [PRICE_EXTRA_ITTYPE] = "money:2250000" }, -- Tabard of the Wild Hunt
				{ 3,  178991, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Tabard of the Ascended
				{ 4,  179282, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, -- Court of Harvesters Tabard
				{ 5,  180431, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Sinful Gladiator's Tabard
				{ 6,  180456, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, -- Colors of the Undying Army
				{ 7,  185303, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Unchained Gladiator's Tabard
				{ 8,  186777, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Cosmic Gladiator's Tabard
				{ 9,  186997, [PRICE_EXTRA_ITTYPE] = "stygia:3000" }, -- Death's Advance Tabard
				{ 10, 190611, [PRICE_EXTRA_ITTYPE] = "money:8000000" }, -- Tabard of the Enlightened
				{ 11, 192206 },                             -- Eternal Gladiator's Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 178120, [PRICE_EXTRA_ITTYPE] = "money:25" }, -- Horde Tabard
			},
		},
		{ -- BFA
			name = EXPANSION_NAME7,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  133670, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Slayer's Tabard
				{ 2,  160543 },                                 -- Tabard of the Tortollan Seekers
				{ 3,  160544, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Champions of Azeroth Tabard
				{ 4,  163055 },                                 -- Dueler's Tabard
				{ 5,  168619, [PRICE_EXTRA_ITTYPE] = "money:1024000" }, -- Rustbolt Resistance Tabard
				{ 6,  168915, [PRICE_EXTRA_ITTYPE] = "money:2000000" }, -- Tabard of Brew
				{ 7,  171361, [PRICE_EXTRA_ITTYPE] = "money:50000000100" }, -- Renowned Explorer's Tabard
				{ 8,  174647, [PRICE_EXTRA_ITTYPE] = "money:2400000" }, -- Rajani Tabard
				{ 9,  174648, [PRICE_EXTRA_ITTYPE] = "money:2400000" }, -- Uldum Accord Tabard
				{ 10, 160539, [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Tabard of the 7th Legion
				{ 11, 160540, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Proudmoore Admiralty Tabard
				{ 12, 160541, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Order of Embers Tabard
				{ 13, 160542, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Storm's Wake Tabard
				{ 14, 161329 },                                 -- Tabard of the Dark Iron
				{ 15, 165010 },                                 -- Tabard of Kul Tiras
				{ 16, 167811, [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Brawler's Guild Tabard
				{ 17, 168610, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Tabard of the Waveblade Ankoan
				{ 18, 174068 },                                 -- Mechagonian Tabard
				{ 19, 164573 },                                 -- Dread Gladiator's Tabard
				{ 20, 164910 },                                 -- Sinister Gladiator's Tabard
				{ 21, 167363 },                                 -- Notorious Gladiator's Tabard
				{ 22, 172652 },                                 -- Corrupted Gladiator's Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 10, 160545, [PRICE_EXTRA_ITTYPE] = "money:5000000" }, -- Tabard of the Honorbound
				{ 11, 160546, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Tabard of the Zandalari Empire
				{ 12, 160547, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Talanji's Expedition Tabard
				{ 13, 160548, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Tabard of the Voldunai
				{ 14, 161328 },                              -- Tabard of the Mag'har Clans
				{ 15, 165001 },                              -- Tabard of the Zandalari
				{ 16, 167812, [PRICE_EXTRA_ITTYPE] = "money:30000000" }, -- Brawler's Guild Tabard
				{ 17, 169274, [PRICE_EXTRA_ITTYPE] = "money:6250000" }, -- Tabard of the Unshackled
				{ 18, 174069 },                              -- Tabard of the Vulpera
				{ 19, 164572 },                              -- Dread Gladiator's Tabard
				{ 20, 164909 },                              -- Sinister Gladiator's Tabard
				{ 21, 167362 },                              -- Notorious Gladiator's Tabard
				{ 22, 172651 },                              -- Corrupted Gladiator's Tabard
			},
		},
		{ -- Legion
			name = EXPANSION_NAME6,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  138429 },                                 -- Cropped Tabard of the Scarlet Crusade
				{ 2,  142504 },                                 -- Hidden Tabard
				{ 3,  140575, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Nightfallen Tabard
				{ 4,  140576, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Tabard of the Highmountain Tribe
				{ 5,  140577, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Court of Farondis Tabard
				{ 6,  140578, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Dreamweaver Initiate's Tabard
				{ 7,  140579, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Valarjar Tabard
				{ 8,  140580, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Warden's Tabard
				{ 9,  140667, [PRICE_EXTRA_ITTYPE] = "money:6000000" }, -- Tabard of the Dreamweavers
				{ 10, 147205, [PRICE_EXTRA_ITTYPE] = "nethershard:10000" }, -- Legionfall Tabard
				{ 11, 152399, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Army of the Light Tabard
				{ 12, 152669, [PRICE_EXTRA_ITTYPE] = "money:3000000" }, -- Argussian Reach Tabard
				{ 13, 156666 },                                 -- Master Trainer's Tabard
				{ 14, 157756 },                                 -- Lightforged Tabard (Alliance)
				{ 15, 157758 },                                 -- Ren'dorei Tabard (Alliance)
				{ 16, 147337 },                                 -- Cruel Gladiator's Tabard
				{ 17, 147339 },                                 -- Ferocious Gladiator's Tabard
				{ 18, 149443 },                                 -- Fierce Gladiator's Tabard
				{ 19, 149447 },                                 -- Dominant Gladiator's Tabard
				{ 20, 149451 },                                 -- Demonic Gladiator's Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 14, 157757 }, -- Highmountain Tabard (Horde)
				{ 15, 157759 }, -- Shal'dorei Tabard (Horde)
				{ 16, 147336 }, -- Cruel Gladiator's Tabard
				{ 17, 147338 }, -- Ferocious Gladiator's Tabard
				{ 18, 149442 }, -- Fierce Gladiator's Tabard
				{ 19, 149446 }, -- Dominating Gladiator's Tabard
				{ 20, 149450 }, -- Demonic Gladiator's Tabard
			},
		},
		{ -- WoD
			name = EXPANSION_NAME5,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  119136, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Arakkoa Outcasts Tabard	-- NEUTRAL
				{ 2,  119137, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Steamwheedle "Preservation" Society Tabard	-- NEUTRAL
				{ 3,  128449, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Saberstalkers Tabard
				{ 4,  128450, [PRICE_EXTRA_ITTYPE] = "money:300000" }, -- Order of the Awakened Tabard
				{ 16, 119135, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Council of Exarchs Tabard
				{ 17, 119140, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Sha'tari Defense Tabard
				{ 18, 115517, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Wrynn's Vanguard Tabard
				{ 19, 118365, [QUEST_EXTRA_ITTYPE] = 37092 }, -- Stormwind Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 119133, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Frostwolf Tabard
				{ 17, 119138, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Laughing Skull Orcs Tabard
				{ 18, 115518, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Vol'jin's Spear Tabard
				{ 19, 118372, [QUEST_EXTRA_ITTYPE] = 37043 }, -- Orgrimmar Tabard
			},
		},
		{ -- MoP
			name = EXPANSION_NAME4,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  89401, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Anglers Tabard	-- NEUTRAL
				{ 2,  89799, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- August Celestials Tabard	-- NEUTRAL
				{ 3,  89797, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Golden Lotus Tabard	-- NEUTRAL
				{ 4,  89798, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Klaxxi Tabard	-- NEUTRAL
				{ 5,  89795, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Lorewalkers Tabard	-- NEUTRAL
				{ 6,  89796, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Order of the Cloud Serpent Tabard	-- NEUTRAL
				{ 7,  89800, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Shado-Pan Tabard	-- NEUTRAL
				{ 8,  97131, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Shado-Pan Assault Tabard	-- NEUTRAL
				{ 9,  89784, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Tillers Tabard	-- NEUTRAL
				{ 16, 95591, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Kirin Tor Offensive Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 95592, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Sunreaver Onslaught Tabard
			},
		},
		{ -- Cataclysm
			name = EXPANSION_NAME3,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  65904, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of Ramkahen	-- NEUTRAL
				{ 2,  65905, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Earthen Ring	-- NEUTRAL
				{ 3,  65906, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Guardians of Hyjal	-- NEUTRAL
				{ 4,  65907, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of Therazane	-- NEUTRAL
				{ 16, 63379, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" }, -- Baradin's Wardens Tabard
				{ 17, 65908, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Wildhammer Clan
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 63378, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" }, -- Hellscream's Reach Tabard
				{ 17, 65909, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Dragonmaw Clan
			},
		},
		{ -- WoLTK
			name = EXPANSION_NAME2,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 43155, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Ebon Blade	-- NEUTRAL
				{ 2, 43157, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Kirin Tor	-- NEUTRAL
				{ 3, 43156, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Wyrmrest Accord	-- NEUTRAL
			},
			[HORDE_DIFF] = ALLIANCE_DIFF,
		},
		{ -- BC
			name = EXPANSION_NAME1,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  31779, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Aldor Tabard	-- NEUTRAL
				{ 2,  31780, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Scryers Tabard	-- NEUTRAL
				{ 4,  31804, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Cenarion Expedition Tabard	-- NEUTRAL
				{ 5,  31776, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Consortium Tabard	-- NEUTRAL
				{ 6,  31777, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Keepers of Time Tabard	-- NEUTRAL
				{ 7,  31778, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Lower City Tabard	-- NEUTRAL
				{ 8,  32828, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Ogri'la Tabard	-- NEUTRAL
				{ 9,  31781, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Sha'tar Tabard	-- NEUTRAL
				{ 10, 32445, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Skyguard Tabard	-- NEUTRAL
				{ 11, 31775, [PRICE_EXTRA_ITTYPE] = "24245:10" }, -- Sporeggar Tabard	-- NEUTRAL
				{ 12, 35221, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Shattered Sun	-- NEUTRAL
				{ 16, 23999, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Honor Hold Tabard
				{ 17, 31774, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Honor Hold Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 24004, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Thrallmar Tabard
				{ 17, 31773, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Mag'har Tabard
			},
		},
		{ -- Classic
			name = EXPANSION_NAME0,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 43154, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Argent Crusade	-- NEUTRAL
			},
			[HORDE_DIFF] = ALLIANCE_DIFF
		},
		{ -- Faction
			name = AL["Factions"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  45579, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darnassus Tabard
				{ 2,  45577, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Ironforge Tabard
				{ 3,  45578, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gnomeregan Tabard
				{ 4,  45574, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Stormwind Tabard
				{ 16, 45580, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Exodar Tabard
				{ 17, 64882, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gilneas Tabard
				{ 18, 83079, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Tushui Tabard
			},
			[HORDE_DIFF] = {
				{ 1,  45582, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darkspear Tabard
				{ 2,  45581, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Orgrimmar Tabard
				{ 3,  45584, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Thunder Bluff Tabard
				{ 4,  45583, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Undercity Tabard
				{ 16, 45585, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Silvermoon City Tabard
				{ 17, 64884, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Bilgewater Cartel Tabard
				{ 18, 83080, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Huojin Tabard
			},
		},
		{ -- Guild
			name = AL["Guild"],
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 69210, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, -- Guild Tabard	-- NEUTRAL
				{ 2, 69209, [PRICE_EXTRA_ITTYPE] = "money:1250000" }, -- Illustrious Guild Tabard -- NEUTRAL
				{ 3, 5976,  [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Guild Tabard	-- NEUTRAL
			},
		},
		{ -- Achievement & Quest Rewards
			name = AL["Achievement & Quest Rewards"],
			CoinTexture = "Achievement",
			[ALLIANCE_DIFF] = {
				{ 1,  43300, 7520 },             -- Loremaster's Colors	-- NEUTRAL
				{ 2,  43349, 876 },              -- Tabard of Brute Force	-- NEUTRAL
				{ 3,  40643, 1021 },             -- Tabard of the Achiever	-- NEUTRAL
				{ 4,  43348, 45 },               -- Tabard of the Explorer	-- NEUTRAL
				{ 6,  49052, 3857 },             -- Tabard of Conquest
				{ 16, 24344, [QUEST_EXTRA_ITTYPE] = 9762 }, -- Tabard of the Hand
				{ 18, 35280, [QUEST_EXTRA_ITTYPE] = 11972 }, -- Tabard of Summer Flames
				{ 19, 35279, [QUEST_EXTRA_ITTYPE] = 11972 }, -- Tabard of Summer Skies
				{ 21, 31405, [QUEST_EXTRA_ITTYPE] = 10781 }, -- Purple Trophy Tabard of the Illidari
				{ 22, 31404, [QUEST_EXTRA_ITTYPE] = 10781 }, -- Green Trophy Tabard of the Illidari
				{ 24, 86468, [QUEST_EXTRA_ITTYPE] = 31820 }, -- Apron	-- NEUTRAL
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 6,  49054, 3957 },             -- Tabard of Conquest
				{ 16, 25549, [QUEST_EXTRA_ITTYPE] = 28473 }, -- Blood Knight Tabard
			},
		},
		{ -- Argent Tournament
			name = AL["Argent Tournament"],
			[ALLIANCE_DIFF] = {
				{ 1,  46874, [PRICE_EXTRA_ITTYPE] = "champseal:50" }, -- Argent Crusader's Tabard	-- NEUTRAL
				{ 3,  45579, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darnassus Tabard
				{ 4,  45577, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Ironforge Tabard
				{ 5,  45578, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gnomeregan Tabard
				{ 6,  45574, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Stormwind Tabard
				{ 16, 46817, [PRICE_EXTRA_ITTYPE] = "champseal:50" }, -- Silver Covenant Tabard
				{ 18, 45580, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Exodar Tabard
				{ 19, 64882, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gilneas Tabard
				{ 20, 83079, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Tushui Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 46818, [PRICE_EXTRA_ITTYPE] = "champseal:50" }, -- Sunreaver Tabard
				{ 3,  45582, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darkspear Tabard
				{ 4,  45581, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Orgrimmar Tabard
				{ 5,  45584, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Thunder Bluff Tabard
				{ 6,  45583, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Undercity Tabard
				{ 18, 45585, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Silvermoon City Tabard
				{ 19, 64884, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Bilgewater Cartel Tabard
				{ 20, 83080, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Huojin Tabard
			},
		},
		{ -- PvP
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1,  115972, [PRICE_EXTRA_ITTYPE] = "conquest:1000" }, -- Primal Gladiator's Tabard
				{ 3,  15196,  [PRICE_EXTRA_ITTYPE] = "markofhonor:1" }, -- Private's Tabard
				{ 4,  15198,  [PRICE_EXTRA_ITTYPE] = "markofhonor:1" }, -- Knight's Colors
				{ 18, 19506,  [PRICE_EXTRA_ITTYPE] = "markofhonor:10" }, -- Silverwing Battle Tabard
				{ 19, 19032,  [PRICE_EXTRA_ITTYPE] = "markofhonor:10" }, -- Stormpike Battle Tabard
				{ 20, 20132,  [PRICE_EXTRA_ITTYPE] = "markofhonor:10" }, -- Arathor Battle Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 3,  15197, [PRICE_EXTRA_ITTYPE] = "markofhonor:1" }, -- Scout's Tabard
				{ 4,  15199, [PRICE_EXTRA_ITTYPE] = "markofhonor:1" }, -- Stone Guard's Herald
				{ 18, 19505, [PRICE_EXTRA_ITTYPE] = "markofhonor:10" }, -- Warsong Battle Tabard
				{ 19, 19031, [PRICE_EXTRA_ITTYPE] = "markofhonor:10" }, -- Frostwolf Battle Tabard
				{ 20, 20131, [PRICE_EXTRA_ITTYPE] = "markofhonor:10" }, -- Battle Tabard of the Defilers
			},
		},
		{ -- Unobtainable Tabards
			name = AL["Unobtainable Tabards"],
			[NORMAL_DIFF] = {
				{ 1,  19160 },                                     -- Contest Winner's Tabard
				{ 3,  36941,                                           1636 }, -- Competitor's Tabard
				{ 4,  89196,                                           7467 }, -- Theramore Tabard
				{ 5,  22999,                                           2116 }, -- Tabard of the Argent Dawn
				{ 6,  28788,                                           2079 }, -- Tabard of the Protector
				{ 8,  "ICON_achievement_featsofstrength_gladiator_10", nil, AL["Arena Reward"],      nil },
				{ 9,  45983 },                                     -- Furious Gladiator's Tabard
				{ 10, 49086, },                                    -- Relentless Gladiator's Tabard
				{ 11, 51534 },                                     -- Wrathful Gladiator's Tabard
				{ 12, 98162 },                                     -- Tyrannical Gladiator's Tabard
				{ 13, 101697 },                                    -- Grievous Gladiator's Tabard
				{ 16, "INV_Box_01",                                    nil, AL["Card Game Tabards"], nil },
				{ 17, 38312 },                                     -- Tabard of Brilliance
				{ 18, 23705 },                                     -- Tabard of Flame
				{ 19, 23709 },                                     -- Tabard of Frost
				{ 20, 38313 },                                     -- Tabard of Fury
				{ 21, 38309 },                                     -- Tabard of Nature
				{ 22, 38310 },                                     -- Tabard of the Arcane
				{ 23, 38314 },                                     -- Tabard of the Defender
				{ 24, 38311 },                                     -- Tabard of the Void
			},
		},
	},
}

data["TIERSETS"]           = {
	name = AL["Tier Sets"],
	ContentType = COLLECTION_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{ -- Tier 34 Sets
			name = format(AL["Tier %d Sets"], 34).." ("..EXPANSION_NAME10..")",
			tier = 34,
			[RF_DIFF] = {
				{ 1,  "Tier34:deathknight:LFRWithDifficulty" },
				{ 3,  "Tier34:demonhunter:LFRWithDifficulty" },
				{ 5,  "Tier34:druid:LFRWithDifficulty" },
				{ 7,  "Tier34:evoker:LFRWithDifficulty" },
				{ 9,  "Tier34:hunter:LFRWithDifficulty" },
				{ 11, "Tier34:mage:LFRWithDifficulty" },
				{ 13, "Tier34:monk:LFRWithDifficulty" },
				{ 15, "Tier34:rogue:LFRWithDifficulty" },
				{ 16, "Tier34:paladin:LFRWithDifficulty" },
				{ 18, "Tier34:priest:LFRWithDifficulty" },
				{ 20, "Tier34:shaman:LFRWithDifficulty" },
				{ 22, "Tier34:warlock:LFRWithDifficulty" },
				{ 24, "Tier34:warrior:LFRWithDifficulty" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier34:deathknight:NormalWithDifficulty" },
				{ 3,  "Tier34:demonhunter:NormalWithDifficulty" },
				{ 5,  "Tier34:druid:NormalWithDifficulty" },
				{ 7,  "Tier34:evoker:NormalWithDifficulty" },
				{ 9,  "Tier34:hunter:NormalWithDifficulty" },
				{ 11, "Tier34:mage:NormalWithDifficulty" },
				{ 13, "Tier34:monk:NormalWithDifficulty" },
				{ 15, "Tier34:rogue:NormalWithDifficulty" },
				{ 16, "Tier34:paladin:NormalWithDifficulty" },
				{ 18, "Tier34:priest:NormalWithDifficulty" },
				{ 20, "Tier34:shaman:NormalWithDifficulty" },
				{ 22, "Tier34:warlock:NormalWithDifficulty" },
				{ 24, "Tier34:warrior:NormalWithDifficulty" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier34:deathknight:HeroicWithDifficulty" },
				{ 3,  "Tier34:demonhunter:HeroicWithDifficulty" },
				{ 5,  "Tier34:druid:HeroicWithDifficulty" },
				{ 7,  "Tier34:evoker:HeroicWithDifficulty" },
				{ 9,  "Tier34:hunter:HeroicWithDifficulty" },
				{ 11, "Tier34:mage:HeroicWithDifficulty" },
				{ 13, "Tier34:monk:HeroicWithDifficulty" },
				{ 15, "Tier34:rogue:HeroicWithDifficulty" },
				{ 16, "Tier34:paladin:HeroicWithDifficulty" },
				{ 18, "Tier34:priest:HeroicWithDifficulty" },
				{ 20, "Tier34:shaman:HeroicWithDifficulty" },
				{ 22, "Tier34:warlock:HeroicWithDifficulty" },
				{ 24, "Tier34:warrior:HeroicWithDifficulty" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier34:deathknight:MythicWithDifficulty" },
				{ 3,  "Tier34:demonhunter:MythicWithDifficulty" },
				{ 5,  "Tier34:druid:MythicWithDifficulty" },
				{ 7,  "Tier34:evoker:MythicWithDifficulty" },
				{ 9,  "Tier34:hunter:MythicWithDifficulty" },
				{ 11, "Tier34:mage:MythicWithDifficulty" },
				{ 13, "Tier34:monk:MythicWithDifficulty" },
				{ 15, "Tier34:rogue:MythicWithDifficulty" },
				{ 16, "Tier34:paladin:MythicWithDifficulty" },
				{ 18, "Tier34:priest:MythicWithDifficulty" },
				{ 20, "Tier34:shaman:MythicWithDifficulty" },
				{ 22, "Tier34:warlock:MythicWithDifficulty" },
				{ 24, "Tier34:warrior:MythicWithDifficulty" },
			},
		},
		{ -- Tier 33 Sets
			name = format(AL["Tier %d Sets"], 33).." ("..EXPANSION_NAME10..")",
			tier = 33,
			[RF_DIFF] = {
				{ 1,  "Tier33:deathknight:LFRWithDifficulty" },
				{ 3,  "Tier33:demonhunter:LFRWithDifficulty" },
				{ 5,  "Tier33:druid:LFRWithDifficulty" },
				{ 7,  "Tier33:evoker:LFRWithDifficulty" },
				{ 9,  "Tier33:hunter:LFRWithDifficulty" },
				{ 11, "Tier33:mage:LFRWithDifficulty" },
				{ 13, "Tier33:monk:LFRWithDifficulty" },
				{ 15, "Tier33:rogue:LFRWithDifficulty" },
				{ 16, "Tier33:paladin:LFRWithDifficulty" },
				{ 18, "Tier33:priest:LFRWithDifficulty" },
				{ 20, "Tier33:shaman:LFRWithDifficulty" },
				{ 22, "Tier33:warlock:LFRWithDifficulty" },
				{ 24, "Tier33:warrior:LFRWithDifficulty" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier33:deathknight:NormalWithDifficulty" },
				{ 3,  "Tier33:demonhunter:NormalWithDifficulty" },
				{ 5,  "Tier33:druid:NormalWithDifficulty" },
				{ 7,  "Tier33:evoker:NormalWithDifficulty" },
				{ 9,  "Tier33:hunter:NormalWithDifficulty" },
				{ 11, "Tier33:mage:NormalWithDifficulty" },
				{ 13, "Tier33:monk:NormalWithDifficulty" },
				{ 15, "Tier33:rogue:NormalWithDifficulty" },
				{ 16, "Tier33:paladin:NormalWithDifficulty" },
				{ 18, "Tier33:priest:NormalWithDifficulty" },
				{ 20, "Tier33:shaman:NormalWithDifficulty" },
				{ 22, "Tier33:warlock:NormalWithDifficulty" },
				{ 24, "Tier33:warrior:NormalWithDifficulty" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier33:deathknight:HeroicWithDifficulty" },
				{ 3,  "Tier33:demonhunter:HeroicWithDifficulty" },
				{ 5,  "Tier33:druid:HeroicWithDifficulty" },
				{ 7,  "Tier33:evoker:HeroicWithDifficulty" },
				{ 9,  "Tier33:hunter:HeroicWithDifficulty" },
				{ 11, "Tier33:mage:HeroicWithDifficulty" },
				{ 13, "Tier33:monk:HeroicWithDifficulty" },
				{ 15, "Tier33:rogue:HeroicWithDifficulty" },
				{ 16, "Tier33:paladin:HeroicWithDifficulty" },
				{ 18, "Tier33:priest:HeroicWithDifficulty" },
				{ 20, "Tier33:shaman:HeroicWithDifficulty" },
				{ 22, "Tier33:warlock:HeroicWithDifficulty" },
				{ 24, "Tier33:warrior:HeroicWithDifficulty" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier33:deathknight:MythicWithDifficulty" },
				{ 3,  "Tier33:demonhunter:MythicWithDifficulty" },
				{ 5,  "Tier33:druid:MythicWithDifficulty" },
				{ 7,  "Tier33:evoker:MythicWithDifficulty" },
				{ 9,  "Tier33:hunter:MythicWithDifficulty" },
				{ 11, "Tier33:mage:MythicWithDifficulty" },
				{ 13, "Tier33:monk:MythicWithDifficulty" },
				{ 15, "Tier33:rogue:MythicWithDifficulty" },
				{ 16, "Tier33:paladin:MythicWithDifficulty" },
				{ 18, "Tier33:priest:MythicWithDifficulty" },
				{ 20, "Tier33:shaman:MythicWithDifficulty" },
				{ 22, "Tier33:warlock:MythicWithDifficulty" },
				{ 24, "Tier33:warrior:MythicWithDifficulty" },
			},
		},
		{ -- Tier 32 Sets
			name = format(AL["Tier %d Sets"], 32).." ("..EXPANSION_NAME10..")",
			tier = 32,
			[RF_DIFF] = {
				{ 1,  "Tier32:deathknight:LFRWithDifficulty" },
				{ 3,  "Tier32:demonhunter:LFRWithDifficulty" },
				{ 5,  "Tier32:druid:LFRWithDifficulty" },
				{ 7,  "Tier32:evoker:LFRWithDifficulty" },
				{ 9,  "Tier32:hunter:LFRWithDifficulty" },
				{ 11, "Tier32:mage:LFRWithDifficulty" },
				{ 13, "Tier32:monk:LFRWithDifficulty" },
				{ 15, "Tier32:rogue:LFRWithDifficulty" },
				{ 16, "Tier32:paladin:LFRWithDifficulty" },
				{ 18, "Tier32:priest:LFRWithDifficulty" },
				{ 20, "Tier32:shaman:LFRWithDifficulty" },
				{ 22, "Tier32:warlock:LFRWithDifficulty" },
				{ 24, "Tier32:warrior:LFRWithDifficulty" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier32:deathknight:NormalWithDifficulty" },
				{ 3,  "Tier32:demonhunter:NormalWithDifficulty" },
				{ 5,  "Tier32:druid:NormalWithDifficulty" },
				{ 7,  "Tier32:evoker:NormalWithDifficulty" },
				{ 9,  "Tier32:hunter:NormalWithDifficulty" },
				{ 11, "Tier32:mage:NormalWithDifficulty" },
				{ 13, "Tier32:monk:NormalWithDifficulty" },
				{ 15, "Tier32:rogue:NormalWithDifficulty" },
				{ 16, "Tier32:paladin:NormalWithDifficulty" },
				{ 18, "Tier32:priest:NormalWithDifficulty" },
				{ 20, "Tier32:shaman:NormalWithDifficulty" },
				{ 22, "Tier32:warlock:NormalWithDifficulty" },
				{ 24, "Tier32:warrior:NormalWithDifficulty" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier32:deathknight:HeroicWithDifficulty" },
				{ 3,  "Tier32:demonhunter:HeroicWithDifficulty" },
				{ 5,  "Tier32:druid:HeroicWithDifficulty" },
				{ 7,  "Tier32:evoker:HeroicWithDifficulty" },
				{ 9,  "Tier32:hunter:HeroicWithDifficulty" },
				{ 11, "Tier32:mage:HeroicWithDifficulty" },
				{ 13, "Tier32:monk:HeroicWithDifficulty" },
				{ 15, "Tier32:rogue:HeroicWithDifficulty" },
				{ 16, "Tier32:paladin:HeroicWithDifficulty" },
				{ 18, "Tier32:priest:HeroicWithDifficulty" },
				{ 20, "Tier32:shaman:HeroicWithDifficulty" },
				{ 22, "Tier32:warlock:HeroicWithDifficulty" },
				{ 24, "Tier32:warrior:HeroicWithDifficulty" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier32:deathknight:MythicWithDifficulty" },
				{ 3,  "Tier32:demonhunter:MythicWithDifficulty" },
				{ 5,  "Tier32:druid:MythicWithDifficulty" },
				{ 7,  "Tier32:evoker:MythicWithDifficulty" },
				{ 9,  "Tier32:hunter:MythicWithDifficulty" },
				{ 11, "Tier32:mage:MythicWithDifficulty" },
				{ 13, "Tier32:monk:MythicWithDifficulty" },
				{ 15, "Tier32:rogue:MythicWithDifficulty" },
				{ 16, "Tier32:paladin:MythicWithDifficulty" },
				{ 18, "Tier32:priest:MythicWithDifficulty" },
				{ 20, "Tier32:shaman:MythicWithDifficulty" },
				{ 22, "Tier32:warlock:MythicWithDifficulty" },
				{ 24, "Tier32:warrior:MythicWithDifficulty" },
			},
		},
		{ -- Tier 21 Sets
			name = format(AL["Tier %d Sets"], 21).." ("..EXPANSION_NAME6..")",
			tier = 21,
			[RF_DIFF] = {
				{ 1,  "Tier21:deathknight:LFRWithDifficulty" },
				{ 3,  "Tier21:demonhunter:LFRWithDifficulty" },
				{ 5,  "Tier21:druid:LFRWithDifficulty" },
				{ 7,  "Tier21:hunter:LFRWithDifficulty" },
				{ 9,  "Tier21:mage:LFRWithDifficulty" },
				{ 11, "Tier21:monk:LFRWithDifficulty" },
				{ 13, "Tier21:rogue:LFRWithDifficulty" },
				{ 15, "Tier21:paladin:LFRWithDifficulty" },
				{ 16, "Tier21:priest:LFRWithDifficulty" },
				{ 18, "Tier21:shaman:LFRWithDifficulty" },
				{ 20, "Tier21:warlock:LFRWithDifficulty" },
				{ 22, "Tier21:warrior:LFRWithDifficulty" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier21:deathknight:NormalWithDifficulty" },
				{ 3,  "Tier21:demonhunter:NormalWithDifficulty" },
				{ 5,  "Tier21:druid:NormalWithDifficulty" },
				{ 7,  "Tier21:hunter:NormalWithDifficulty" },
				{ 9,  "Tier21:mage:NormalWithDifficulty" },
				{ 11, "Tier21:monk:NormalWithDifficulty" },
				{ 13, "Tier21:rogue:NormalWithDifficulty" },
				{ 15, "Tier21:paladin:NormalWithDifficulty" },
				{ 16, "Tier21:priest:NormalWithDifficulty" },
				{ 18, "Tier21:shaman:NormalWithDifficulty" },
				{ 20, "Tier21:warlock:NormalWithDifficulty" },
				{ 22, "Tier21:warrior:NormalWithDifficulty" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier21:deathknight:HeroicWithDifficulty" },
				{ 3,  "Tier21:demonhunter:HeroicWithDifficulty" },
				{ 5,  "Tier21:druid:HeroicWithDifficulty" },
				{ 7,  "Tier21:hunter:HeroicWithDifficulty" },
				{ 9,  "Tier21:mage:HeroicWithDifficulty" },
				{ 11, "Tier21:monk:HeroicWithDifficulty" },
				{ 13, "Tier21:rogue:HeroicWithDifficulty" },
				{ 15, "Tier21:paladin:HeroicWithDifficulty" },
				{ 16, "Tier21:priest:HeroicWithDifficulty" },
				{ 18, "Tier21:shaman:HeroicWithDifficulty" },
				{ 20, "Tier21:warlock:HeroicWithDifficulty" },
				{ 22, "Tier21:warrior:HeroicWithDifficulty" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier21:deathknight:MythicWithDifficulty" },
				{ 3,  "Tier21:demonhunter:MythicWithDifficulty" },
				{ 5,  "Tier21:druid:MythicWithDifficulty" },
				{ 7,  "Tier21:hunter:MythicWithDifficulty" },
				{ 9,  "Tier21:mage:MythicWithDifficulty" },
				{ 11, "Tier21:monk:MythicWithDifficulty" },
				{ 13, "Tier21:rogue:MythicWithDifficulty" },
				{ 15, "Tier21:paladin:MythicWithDifficulty" },
				{ 16, "Tier21:priest:MythicWithDifficulty" },
				{ 18, "Tier21:shaman:MythicWithDifficulty" },
				{ 20, "Tier21:warlock:MythicWithDifficulty" },
				{ 22, "Tier21:warrior:MythicWithDifficulty" },
			},
		},
		{ -- Tier 20 Sets
			name = format(AL["Tier %d Sets"], 20).." ("..EXPANSION_NAME6..")",
			tier = 20,
			[RF_DIFF] = {
				{ 1,  "Tier20:deathknight:LFRWithDifficulty" },
				{ 3,  "Tier20:demonhunter:LFRWithDifficulty" },
				{ 5,  "Tier20:druid:LFRWithDifficulty" },
				{ 7,  "Tier20:hunter:LFRWithDifficulty" },
				{ 9,  "Tier20:mage:LFRWithDifficulty" },
				{ 11, "Tier20:monk:LFRWithDifficulty" },
				{ 13, "Tier20:rogue:LFRWithDifficulty" },
				{ 15, "Tier20:paladin:LFRWithDifficulty" },
				{ 16, "Tier20:priest:LFRWithDifficulty" },
				{ 18, "Tier20:shaman:LFRWithDifficulty" },
				{ 20, "Tier20:warlock:LFRWithDifficulty" },
				{ 22, "Tier20:warrior:LFRWithDifficulty" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier20:deathknight:NormalWithDifficulty" },
				{ 3,  "Tier20:demonhunter:NormalWithDifficulty" },
				{ 5,  "Tier20:druid:NormalWithDifficulty" },
				{ 7,  "Tier20:hunter:NormalWithDifficulty" },
				{ 9,  "Tier20:mage:NormalWithDifficulty" },
				{ 11, "Tier20:monk:NormalWithDifficulty" },
				{ 13, "Tier20:rogue:NormalWithDifficulty" },
				{ 15, "Tier20:paladin:NormalWithDifficulty" },
				{ 16, "Tier20:priest:NormalWithDifficulty" },
				{ 18, "Tier20:shaman:NormalWithDifficulty" },
				{ 20, "Tier20:warlock:NormalWithDifficulty" },
				{ 22, "Tier20:warrior:NormalWithDifficulty" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier20:deathknight:HeroicWithDifficulty" },
				{ 3,  "Tier20:demonhunter:HeroicWithDifficulty" },
				{ 5,  "Tier20:druid:HeroicWithDifficulty" },
				{ 7,  "Tier20:hunter:HeroicWithDifficulty" },
				{ 9,  "Tier20:mage:HeroicWithDifficulty" },
				{ 11, "Tier20:monk:HeroicWithDifficulty" },
				{ 13, "Tier20:rogue:HeroicWithDifficulty" },
				{ 15, "Tier20:paladin:HeroicWithDifficulty" },
				{ 16, "Tier20:priest:HeroicWithDifficulty" },
				{ 18, "Tier20:shaman:HeroicWithDifficulty" },
				{ 20, "Tier20:warlock:HeroicWithDifficulty" },
				{ 22, "Tier20:warrior:HeroicWithDifficulty" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier20:deathknight:MythicWithDifficulty" },
				{ 3,  "Tier20:demonhunter:MythicWithDifficulty" },
				{ 5,  "Tier20:druid:MythicWithDifficulty" },
				{ 7,  "Tier20:hunter:MythicWithDifficulty" },
				{ 9,  "Tier20:mage:MythicWithDifficulty" },
				{ 11, "Tier20:monk:MythicWithDifficulty" },
				{ 13, "Tier20:rogue:MythicWithDifficulty" },
				{ 15, "Tier20:paladin:MythicWithDifficulty" },
				{ 16, "Tier20:priest:MythicWithDifficulty" },
				{ 18, "Tier20:shaman:MythicWithDifficulty" },
				{ 20, "Tier20:warlock:MythicWithDifficulty" },
				{ 22, "Tier20:warrior:MythicWithDifficulty" },
			},
		},
		{ -- Tier 19 Sets
			name = format(AL["Tier %d Sets"], 19).." ("..EXPANSION_NAME6..")",
			tier = 19,
			[RF_DIFF] = {
				{ 1,  "Tier19:deathknight:LFRWithDifficulty" },
				{ 3,  "Tier19:demonhunter:LFRWithDifficulty" },
				{ 5,  "Tier19:druid:LFRWithDifficulty" },
				{ 7,  "Tier19:hunter:LFRWithDifficulty" },
				{ 9,  "Tier19:mage:LFRWithDifficulty" },
				{ 11, "Tier19:monk:LFRWithDifficulty" },
				{ 13, "Tier19:rogue:LFRWithDifficulty" },
				{ 15, "Tier19:paladin:LFRWithDifficulty" },
				{ 16, "Tier19:priest:LFRWithDifficulty" },
				{ 18, "Tier19:shaman:LFRWithDifficulty" },
				{ 20, "Tier19:warlock:LFRWithDifficulty" },
				{ 22, "Tier19:warrior:LFRWithDifficulty" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier19:deathknight:NormalWithDifficulty" },
				{ 3,  "Tier19:demonhunter:NormalWithDifficulty" },
				{ 5,  "Tier19:druid:NormalWithDifficulty" },
				{ 7,  "Tier19:hunter:NormalWithDifficulty" },
				{ 9,  "Tier19:mage:NormalWithDifficulty" },
				{ 11, "Tier19:monk:NormalWithDifficulty" },
				{ 13, "Tier19:rogue:NormalWithDifficulty" },
				{ 15, "Tier19:paladin:NormalWithDifficulty" },
				{ 16, "Tier19:priest:NormalWithDifficulty" },
				{ 18, "Tier19:shaman:NormalWithDifficulty" },
				{ 20, "Tier19:warlock:NormalWithDifficulty" },
				{ 22, "Tier19:warrior:NormalWithDifficulty" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier19:deathknight:HeroicWithDifficulty" },
				{ 3,  "Tier19:demonhunter:HeroicWithDifficulty" },
				{ 5,  "Tier19:druid:HeroicWithDifficulty" },
				{ 7,  "Tier19:hunter:HeroicWithDifficulty" },
				{ 9,  "Tier19:mage:HeroicWithDifficulty" },
				{ 11, "Tier19:monk:HeroicWithDifficulty" },
				{ 13, "Tier19:rogue:HeroicWithDifficulty" },
				{ 15, "Tier19:paladin:HeroicWithDifficulty" },
				{ 16, "Tier19:priest:HeroicWithDifficulty" },
				{ 18, "Tier19:shaman:HeroicWithDifficulty" },
				{ 20, "Tier19:warlock:HeroicWithDifficulty" },
				{ 22, "Tier19:warrior:HeroicWithDifficulty" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier19:deathknight:MythicWithDifficulty" },
				{ 3,  "Tier19:demonhunter:MythicWithDifficulty" },
				{ 5,  "Tier19:druid:MythicWithDifficulty" },
				{ 7,  "Tier19:hunter:MythicWithDifficulty" },
				{ 9,  "Tier19:mage:MythicWithDifficulty" },
				{ 11, "Tier19:monk:MythicWithDifficulty" },
				{ 13, "Tier19:rogue:MythicWithDifficulty" },
				{ 15, "Tier19:paladin:MythicWithDifficulty" },
				{ 16, "Tier19:priest:MythicWithDifficulty" },
				{ 18, "Tier19:shaman:MythicWithDifficulty" },
				{ 20, "Tier19:warlock:MythicWithDifficulty" },
				{ 22, "Tier19:warrior:MythicWithDifficulty" },
			},
		},
		{ -- Tier 18 Sets
			name = format(AL["Tier %d Sets"], 18).." ("..EXPANSION_NAME5..")",
			tier = 18,
			[RF_DIFF] = {
				{ 1,  "Tier18:rfcloth:rf" },
				{ 3,  "Tier18:rfleather:rf" },
				{ 16, "Tier18:rfmail:rf" },
				{ 18, "Tier18:rfplate:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier18:dk:n" },
				{ 3,  "Tier18:druid:n" },
				{ 5,  "Tier18:hunter:n" },
				{ 7,  "Tier18:mage:n" },
				{ 9,  "Tier18:monk:n" },
				{ 11, "Tier18:paladin:n" },
				{ 16, "Tier18:priest:n" },
				{ 18, "Tier18:rogue:n" },
				{ 20, "Tier18:shaman:n" },
				{ 22, "Tier18:warlock:n" },
				{ 24, "Tier18:warrior:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier18:dk:hB1" },
				{ 3,  "Tier18:druid:hB1" },
				{ 5,  "Tier18:hunter:hB1" },
				{ 7,  "Tier18:mage:hB1" },
				{ 9,  "Tier18:monk:hB1" },
				{ 11, "Tier18:paladin:hB1" },
				{ 16, "Tier18:priest:hB1" },
				{ 18, "Tier18:rogue:hB1" },
				{ 20, "Tier18:shaman:hB1" },
				{ 22, "Tier18:warlock:hB1" },
				{ 24, "Tier18:warrior:hB1" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier18:dk:mB1" },
				{ 3,  "Tier18:druid:mB1" },
				{ 5,  "Tier18:hunter:mB1" },
				{ 7,  "Tier18:mage:mB1" },
				{ 9,  "Tier18:monk:mB1" },
				{ 11, "Tier18:paladin:mB1" },
				{ 16, "Tier18:priest:mB1" },
				{ 18, "Tier18:rogue:mB1" },
				{ 20, "Tier18:shaman:mB1" },
				{ 22, "Tier18:warlock:mB1" },
				{ 24, "Tier18:warrior:mB1" },
			},
		},
		{ -- Tier 17 Sets
			name = format(AL["Tier %d Sets"], 17).." ("..EXPANSION_NAME5..")",
			tier = 17,
			[RF_DIFF] = {
				{ 1,  "Tier17:rfcloth:rf" },
				{ 3,  "Tier17:rfleather:rf" },
				{ 16, "Tier17:rfmail:rf" },
				{ 18, "Tier17:rfplate:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier17:dk:n" },
				{ 3,  "Tier17:druid:n" },
				{ 5,  "Tier17:hunter:n" },
				{ 7,  "Tier17:mage:n" },
				{ 9,  "Tier17:monk:n" },
				{ 11, "Tier17:paladin:n" },
				{ 16, "Tier17:priest:n" },
				{ 18, "Tier17:rogue:n" },
				{ 20, "Tier17:shaman:n" },
				{ 22, "Tier17:warlock:n" },
				{ 24, "Tier17:warrior:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier17:dk:hB1" },
				{ 3,  "Tier17:druid:hB1" },
				{ 5,  "Tier17:hunter:hB1" },
				{ 7,  "Tier17:mage:hB1" },
				{ 9,  "Tier17:monk:hB1" },
				{ 11, "Tier17:paladin:hB1" },
				{ 16, "Tier17:priest:hB1" },
				{ 18, "Tier17:rogue:hB1" },
				{ 20, "Tier17:shaman:hB1" },
				{ 22, "Tier17:warlock:hB1" },
				{ 24, "Tier17:warrior:hB1" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier17:dk:mB1" },
				{ 3,  "Tier17:druid:mB1" },
				{ 5,  "Tier17:hunter:mB1" },
				{ 7,  "Tier17:mage:mB1" },
				{ 9,  "Tier17:monk:mB1" },
				{ 11, "Tier17:paladin:mB1" },
				{ 16, "Tier17:priest:mB1" },
				{ 18, "Tier17:rogue:mB1" },
				{ 20, "Tier17:shaman:mB1" },
				{ 22, "Tier17:warlock:mB1" },
				{ 24, "Tier17:warrior:mB1" },
			},
		},
		{ -- Tier 16 Sets
			name = format(AL["Tier %d Sets"], 16).." ("..EXPANSION_NAME4..")",
			tier = 16,
			[RF_DIFF] = {
				{ 1,  "Tier16:hunter:rf" },
				{ 2,  "Tier16:mage:rf" },
				{ 3,  "Tier16:rogue:rf" },
				{ 4,  "Tier16:warlock:rf" },
				{ 6,  "Tier16:deathknightblood:rf" },
				{ 7,  "Tier16:deathknightdps:rf" },
				{ 9,  "Tier16:druidbalance:rf" },
				{ 10, "Tier16:druidferal:rf" },
				{ 11, "Tier16:druidguardian:rf" },
				{ 12, "Tier16:druidrestoration:rf" },
				{ 14, "Tier16:priestheal:rf" },
				{ 15, "Tier16:priestshadow:rf" },
				{ 16, "Tier16:monkbrewmaster:rf" },
				{ 17, "Tier16:monkmistweaver:rf" },
				{ 18, "Tier16:monkwindwalker:rf" },
				{ 20, "Tier16:paladinholy:rf" },
				{ 21, "Tier16:paladinprotection:rf" },
				{ 22, "Tier16:paladinretribution:rf" },
				{ 24, "Tier16:shamanelemental:rf" },
				{ 25, "Tier16:shamanenhancement:rf" },
				{ 26, "Tier16:shamanrestoration:rf" },
				{ 28, "Tier16:warriordps:rf" },
				{ 29, "Tier16:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier16:hunter:n" },
				{ 2,  "Tier16:mage:n" },
				{ 3,  "Tier16:rogue:n" },
				{ 4,  "Tier16:warlock:n" },
				{ 6,  "Tier16:deathknightblood:n" },
				{ 7,  "Tier16:deathknightdps:n" },
				{ 9,  "Tier16:druidbalance:n" },
				{ 10, "Tier16:druidferal:n" },
				{ 11, "Tier16:druidguardian:n" },
				{ 12, "Tier16:druidrestoration:n" },
				{ 14, "Tier16:priestheal:n" },
				{ 15, "Tier16:priestshadow:n" },
				{ 16, "Tier16:monkbrewmaster:n" },
				{ 17, "Tier16:monkmistweaver:n" },
				{ 18, "Tier16:monkwindwalker:n" },
				{ 20, "Tier16:paladinholy:n" },
				{ 21, "Tier16:paladinprotection:n" },
				{ 22, "Tier16:paladinretribution:n" },
				{ 24, "Tier16:shamanelemental:n" },
				{ 25, "Tier16:shamanenhancement:n" },
				{ 26, "Tier16:shamanrestoration:n" },
				{ 28, "Tier16:warriordps:n" },
				{ 29, "Tier16:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier16:hunter:h" },
				{ 2,  "Tier16:mage:h" },
				{ 3,  "Tier16:rogue:h" },
				{ 4,  "Tier16:warlock:h" },
				{ 6,  "Tier16:deathknightblood:h" },
				{ 7,  "Tier16:deathknightdps:h" },
				{ 9,  "Tier16:druidbalance:h" },
				{ 10, "Tier16:druidferal:h" },
				{ 11, "Tier16:druidguardian:h" },
				{ 12, "Tier16:druidrestoration:h" },
				{ 14, "Tier16:priestheal:h" },
				{ 15, "Tier16:priestshadow:h" },
				{ 16, "Tier16:monkbrewmaster:h" },
				{ 17, "Tier16:monkmistweaver:h" },
				{ 18, "Tier16:monkwindwalker:h" },
				{ 20, "Tier16:paladinholy:h" },
				{ 21, "Tier16:paladinprotection:h" },
				{ 22, "Tier16:paladinretribution:h" },
				{ 24, "Tier16:shamanelemental:h" },
				{ 25, "Tier16:shamanenhancement:h" },
				{ 26, "Tier16:shamanrestoration:h" },
				{ 28, "Tier16:warriordps:h" },
				{ 29, "Tier16:warriorprotection:h" },
			},
			[MYTHIC_DIFF] = {
				{ 1,  "Tier16:hunter:m" },
				{ 2,  "Tier16:mage:m" },
				{ 3,  "Tier16:rogue:m" },
				{ 4,  "Tier16:warlock:m" },
				{ 6,  "Tier16:deathknightblood:m" },
				{ 7,  "Tier16:deathknightdps:m" },
				{ 9,  "Tier16:druidbalance:m" },
				{ 10, "Tier16:druidferal:m" },
				{ 11, "Tier16:druidguardian:m" },
				{ 12, "Tier16:druidrestoration:m" },
				{ 14, "Tier16:priestheal:m" },
				{ 15, "Tier16:priestshadow:m" },
				{ 16, "Tier16:monkbrewmaster:m" },
				{ 17, "Tier16:monkmistweaver:m" },
				{ 18, "Tier16:monkwindwalker:m" },
				{ 20, "Tier16:paladinholy:m" },
				{ 21, "Tier16:paladinprotection:m" },
				{ 22, "Tier16:paladinretribution:m" },
				{ 24, "Tier16:shamanelemental:m" },
				{ 25, "Tier16:shamanenhancement:m" },
				{ 26, "Tier16:shamanrestoration:m" },
				{ 28, "Tier16:warriordps:m" },
				{ 29, "Tier16:warriorprotection:m" },
			},
		},
		{ -- Tier 15 Sets
			name = format(AL["Tier %d Sets"], 15).." ("..EXPANSION_NAME4..")",
			tier = 15,
			[RF_DIFF] = {
				{ 1,  "Tier15:hunter:rf" },
				{ 2,  "Tier15:mage:rf" },
				{ 3,  "Tier15:rogue:rf" },
				{ 4,  "Tier15:warlock:rf" },
				{ 6,  "Tier15:deathknightblood:rf" },
				{ 7,  "Tier15:deathknightdps:rf" },
				{ 9,  "Tier15:druidbalance:rf" },
				{ 10, "Tier15:druidferal:rf" },
				{ 11, "Tier15:druidguardian:rf" },
				{ 12, "Tier15:druidrestoration:rf" },
				{ 14, "Tier15:priestheal:rf" },
				{ 15, "Tier15:priestshadow:rf" },
				{ 16, "Tier15:monkbrewmaster:rf" },
				{ 17, "Tier15:monkmistweaver:rf" },
				{ 18, "Tier15:monkwindwalker:rf" },
				{ 20, "Tier15:paladinholy:rf" },
				{ 21, "Tier15:paladinprotection:rf" },
				{ 22, "Tier15:paladinretribution:rf" },
				{ 24, "Tier15:shamanelemental:rf" },
				{ 25, "Tier15:shamanenhancement:rf" },
				{ 26, "Tier15:shamanrestoration:rf" },
				{ 28, "Tier15:warriordps:rf" },
				{ 29, "Tier15:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier15:hunter:n" },
				{ 2,  "Tier15:mage:n" },
				{ 3,  "Tier15:rogue:n" },
				{ 4,  "Tier15:warlock:n" },
				{ 6,  "Tier15:deathknightblood:n" },
				{ 7,  "Tier15:deathknightdps:n" },
				{ 9,  "Tier15:druidbalance:n" },
				{ 10, "Tier15:druidferal:n" },
				{ 11, "Tier15:druidguardian:n" },
				{ 12, "Tier15:druidrestoration:n" },
				{ 14, "Tier15:priestheal:n" },
				{ 15, "Tier15:priestshadow:n" },
				{ 16, "Tier15:monkbrewmaster:n" },
				{ 17, "Tier15:monkmistweaver:n" },
				{ 18, "Tier15:monkwindwalker:n" },
				{ 20, "Tier15:paladinholy:n" },
				{ 21, "Tier15:paladinprotection:n" },
				{ 22, "Tier15:paladinretribution:n" },
				{ 24, "Tier15:shamanelemental:n" },
				{ 25, "Tier15:shamanenhancement:n" },
				{ 26, "Tier15:shamanrestoration:n" },
				{ 28, "Tier15:warriordps:n" },
				{ 29, "Tier15:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier15:hunter:h" },
				{ 2,  "Tier15:mage:h" },
				{ 3,  "Tier15:rogue:h" },
				{ 4,  "Tier15:warlock:h" },
				{ 6,  "Tier15:deathknightblood:h" },
				{ 7,  "Tier15:deathknightdps:h" },
				{ 9,  "Tier15:druidbalance:h" },
				{ 10, "Tier15:druidferal:h" },
				{ 11, "Tier15:druidguardian:h" },
				{ 12, "Tier15:druidrestoration:h" },
				{ 14, "Tier15:priestheal:h" },
				{ 15, "Tier15:priestshadow:h" },
				{ 16, "Tier15:monkbrewmaster:h" },
				{ 17, "Tier15:monkmistweaver:h" },
				{ 18, "Tier15:monkwindwalker:h" },
				{ 20, "Tier15:paladinholy:h" },
				{ 21, "Tier15:paladinprotection:h" },
				{ 22, "Tier15:paladinretribution:h" },
				{ 24, "Tier15:shamanelemental:h" },
				{ 25, "Tier15:shamanenhancement:h" },
				{ 26, "Tier15:shamanrestoration:h" },
				{ 28, "Tier15:warriordps:h" },
				{ 29, "Tier15:warriorprotection:h" },
			},
		},
		{ -- Tier 14 Sets
			name = format(AL["Tier %d Sets"], 14).." ("..EXPANSION_NAME4..")",
			tier = 14,
			[RF_DIFF] = {
				{ 1,  "Tier14:hunter:rf" },
				{ 2,  "Tier14:mage:rf" },
				{ 3,  "Tier14:rogue:rf" },
				{ 4,  "Tier14:warlock:rf" },
				{ 6,  "Tier14:deathknightblood:rf" },
				{ 7,  "Tier14:deathknightdps:rf" },
				{ 9,  "Tier14:druidbalance:rf" },
				{ 10, "Tier14:druidferal:rf" },
				{ 11, "Tier14:druidguardian:rf" },
				{ 12, "Tier14:druidrestoration:rf" },
				{ 14, "Tier14:priestheal:rf" },
				{ 15, "Tier14:priestshadow:rf" },
				{ 16, "Tier14:monkbrewmaster:rf" },
				{ 17, "Tier14:monkmistweaver:rf" },
				{ 18, "Tier14:monkwindwalker:rf" },
				{ 20, "Tier14:paladinholy:rf" },
				{ 21, "Tier14:paladinprotection:rf" },
				{ 22, "Tier14:paladinretribution:rf" },
				{ 24, "Tier14:shamanelemental:rf" },
				{ 25, "Tier14:shamanenhancement:rf" },
				{ 26, "Tier14:shamanrestoration:rf" },
				{ 28, "Tier14:warriordps:rf" },
				{ 29, "Tier14:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier14:hunter:n" },
				{ 2,  "Tier14:mage:n" },
				{ 3,  "Tier14:rogue:n" },
				{ 4,  "Tier14:warlock:n" },
				{ 6,  "Tier14:deathknightblood:n" },
				{ 7,  "Tier14:deathknightdps:n" },
				{ 9,  "Tier14:druidbalance:n" },
				{ 10, "Tier14:druidferal:n" },
				{ 11, "Tier14:druidguardian:n" },
				{ 12, "Tier14:druidrestoration:n" },
				{ 14, "Tier14:priestheal:n" },
				{ 15, "Tier14:priestshadow:n" },
				{ 16, "Tier14:monkbrewmaster:n" },
				{ 17, "Tier14:monkmistweaver:n" },
				{ 18, "Tier14:monkwindwalker:n" },
				{ 20, "Tier14:paladinholy:n" },
				{ 21, "Tier14:paladinprotection:n" },
				{ 22, "Tier14:paladinretribution:n" },
				{ 24, "Tier14:shamanelemental:n" },
				{ 25, "Tier14:shamanenhancement:n" },
				{ 26, "Tier14:shamanrestoration:n" },
				{ 28, "Tier14:warriordps:n" },
				{ 29, "Tier14:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier14:hunter:h" },
				{ 2,  "Tier14:mage:h" },
				{ 3,  "Tier14:rogue:h" },
				{ 4,  "Tier14:warlock:h" },
				{ 6,  "Tier14:deathknightblood:h" },
				{ 7,  "Tier14:deathknightdps:h" },
				{ 9,  "Tier14:druidbalance:h" },
				{ 10, "Tier14:druidferal:h" },
				{ 11, "Tier14:druidguardian:h" },
				{ 12, "Tier14:druidrestoration:h" },
				{ 14, "Tier14:priestheal:h" },
				{ 15, "Tier14:priestshadow:h" },
				{ 16, "Tier14:monkbrewmaster:h" },
				{ 17, "Tier14:monkmistweaver:h" },
				{ 18, "Tier14:monkwindwalker:h" },
				{ 20, "Tier14:paladinholy:h" },
				{ 21, "Tier14:paladinprotection:h" },
				{ 22, "Tier14:paladinretribution:h" },
				{ 24, "Tier14:shamanelemental:h" },
				{ 25, "Tier14:shamanenhancement:h" },
				{ 26, "Tier14:shamanrestoration:h" },
				{ 28, "Tier14:warriordps:h" },
				{ 29, "Tier14:warriorprotection:h" },
			},
		},
		{ -- Tier 13 Sets
			name = format(AL["Tier %d Sets"], 13).." ("..EXPANSION_NAME3..")",
			tier = 13,
			[RF_DIFF] = {
				{ 1,  "Tier13:deathknightblood:rf" },
				{ 2,  "Tier13:deathknightdps:rf" },
				{ 4,  "Tier13:druidbalance:rf" },
				{ 5,  "Tier13:druidferal:rf" },
				{ 6,  "Tier13:druidrestoration:rf" },
				{ 8,  "Tier13:hunter:rf" },
				{ 10, "Tier13:mage:rf" },
				{ 12, "Tier13:paladinholy:rf" },
				{ 13, "Tier13:paladinprotection:rf" },
				{ 14, "Tier13:paladinretribution:rf" },
				{ 16, "Tier13:priestheal:rf" },
				{ 17, "Tier13:priestshadow:rf" },
				{ 19, "Tier13:rogue:rf" },
				{ 21, "Tier13:shamanelemental:rf" },
				{ 22, "Tier13:shamanenhancement:rf" },
				{ 23, "Tier13:shamanrestoration:rf" },
				{ 25, "Tier13:warlock:rf" },
				{ 27, "Tier13:warriordps:rf" },
				{ 28, "Tier13:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1,  "Tier13:deathknightblood:n" },
				{ 2,  "Tier13:deathknightdps:n" },
				{ 4,  "Tier13:druidbalance:n" },
				{ 5,  "Tier13:druidferal:n" },
				{ 6,  "Tier13:druidrestoration:n" },
				{ 8,  "Tier13:hunter:n" },
				{ 10, "Tier13:mage:n" },
				{ 12, "Tier13:paladinholy:n" },
				{ 13, "Tier13:paladinprotection:n" },
				{ 14, "Tier13:paladinretribution:n" },
				{ 16, "Tier13:priestheal:n" },
				{ 17, "Tier13:priestshadow:n" },
				{ 19, "Tier13:rogue:n" },
				{ 21, "Tier13:shamanelemental:n" },
				{ 22, "Tier13:shamanenhancement:n" },
				{ 23, "Tier13:shamanrestoration:n" },
				{ 25, "Tier13:warlock:n" },
				{ 27, "Tier13:warriordps:n" },
				{ 28, "Tier13:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier13:deathknightblood:h" },
				{ 2,  "Tier13:deathknightdps:h" },
				{ 4,  "Tier13:druidbalance:h" },
				{ 5,  "Tier13:druidferal:h" },
				{ 6,  "Tier13:druidrestoration:h" },
				{ 8,  "Tier13:hunter:h" },
				{ 10, "Tier13:mage:h" },
				{ 12, "Tier13:paladinholy:h" },
				{ 13, "Tier13:paladinprotection:h" },
				{ 14, "Tier13:paladinretribution:h" },
				{ 16, "Tier13:priestheal:h" },
				{ 17, "Tier13:priestshadow:h" },
				{ 19, "Tier13:rogue:h" },
				{ 21, "Tier13:shamanelemental:h" },
				{ 22, "Tier13:shamanenhancement:h" },
				{ 23, "Tier13:shamanrestoration:h" },
				{ 25, "Tier13:warlock:h" },
				{ 27, "Tier13:warriordps:h" },
				{ 28, "Tier13:warriorprotection:h" },
			},
		},
		{ -- Tier 12 Sets
			name = format(AL["Tier %d Sets"], 12).." ("..EXPANSION_NAME3..")",
			tier = 12,
			[NORMAL_DIFF] = {
				{ 1,  "Tier12:deathknightblood:n" },
				{ 2,  "Tier12:deathknightdps:n" },
				{ 4,  "Tier12:druidbalance:n" },
				{ 5,  "Tier12:druidferal:n" },
				{ 6,  "Tier12:druidrestoration:n" },
				{ 8,  "Tier12:hunter:n" },
				{ 10, "Tier12:mage:n" },
				{ 12, "Tier12:paladinholy:n" },
				{ 13, "Tier12:paladinprotection:n" },
				{ 14, "Tier12:paladinretribution:n" },
				{ 16, "Tier12:priestheal:n" },
				{ 17, "Tier12:priestshadow:n" },
				{ 19, "Tier12:rogue:n" },
				{ 21, "Tier12:shamanelemental:n" },
				{ 22, "Tier12:shamanenhancement:n" },
				{ 23, "Tier12:shamanrestoration:n" },
				{ 25, "Tier12:warlock:n" },
				{ 27, "Tier12:warriordps:n" },
				{ 28, "Tier12:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier12:deathknightblood:h" },
				{ 2,  "Tier12:deathknightdps:h" },
				{ 4,  "Tier12:druidbalance:h" },
				{ 5,  "Tier12:druidferal:h" },
				{ 6,  "Tier12:druidrestoration:h" },
				{ 8,  "Tier12:hunter:h" },
				{ 10, "Tier12:mage:h" },
				{ 12, "Tier12:paladinholy:h" },
				{ 13, "Tier12:paladinprotection:h" },
				{ 14, "Tier12:paladinretribution:h" },
				{ 16, "Tier12:priestheal:h" },
				{ 17, "Tier12:priestshadow:h" },
				{ 19, "Tier12:rogue:h" },
				{ 21, "Tier12:shamanelemental:h" },
				{ 22, "Tier12:shamanenhancement:h" },
				{ 23, "Tier12:shamanrestoration:h" },
				{ 25, "Tier12:warlock:h" },
				{ 27, "Tier12:warriordps:h" },
				{ 28, "Tier12:warriorprotection:h" },
			},
		},
		{ -- Tier 11 Sets
			name = format(AL["Tier %d Sets"], 11).." ("..EXPANSION_NAME3..")",
			tier = 11,
			[NORMAL_DIFF] = {
				{ 1,  "Tier11:deathknightblood:n" },
				{ 2,  "Tier11:deathknightdps:n" },
				{ 4,  "Tier11:druidbalance:n" },
				{ 5,  "Tier11:druidferal:n" },
				{ 6,  "Tier11:druidrestoration:n" },
				{ 8,  "Tier11:hunter:n" },
				{ 10, "Tier11:mage:n" },
				{ 12, "Tier11:paladinholy:n" },
				{ 13, "Tier11:paladinprotection:n" },
				{ 14, "Tier11:paladinretribution:n" },
				{ 16, "Tier11:priestheal:n" },
				{ 17, "Tier11:priestshadow:n" },
				{ 19, "Tier11:rogue:n" },
				{ 21, "Tier11:shamanelemental:n" },
				{ 22, "Tier11:shamanenhancement:n" },
				{ 23, "Tier11:shamanrestoration:n" },
				{ 25, "Tier11:warlock:n" },
				{ 27, "Tier11:warriordps:n" },
				{ 28, "Tier11:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1,  "Tier11:deathknightblood:h" },
				{ 2,  "Tier11:deathknightdps:h" },
				{ 4,  "Tier11:druidbalance:h" },
				{ 5,  "Tier11:druidferal:h" },
				{ 6,  "Tier11:druidrestoration:h" },
				{ 8,  "Tier11:hunter:h" },
				{ 10, "Tier11:mage:h" },
				{ 12, "Tier11:paladinholy:h" },
				{ 13, "Tier11:paladinprotection:h" },
				{ 14, "Tier11:paladinretribution:h" },
				{ 16, "Tier11:priestheal:h" },
				{ 17, "Tier11:priestshadow:h" },
				{ 19, "Tier11:rogue:h" },
				{ 21, "Tier11:shamanelemental:h" },
				{ 22, "Tier11:shamanenhancement:h" },
				{ 23, "Tier11:shamanrestoration:h" },
				{ 25, "Tier11:warlock:h" },
				{ 27, "Tier11:warriordps:h" },
				{ 28, "Tier11:warriorprotection:h" },
			},
		},
		{ -- Tier 10 Sets
			name = format(AL["Tier %d Sets"], 10).." ("..EXPANSION_NAME2..")",
			tier = 10,
			[NORMAL_DIFF] = {
				{ 1,  "Tier10:deathknightblood:n" },
				{ 2,  "Tier10:deathknightdps:n" },
				{ 4,  "Tier10:druidbalance:n" },
				{ 5,  "Tier10:druidferal:n" },
				{ 6,  "Tier10:druidrestoration:n" },
				{ 8,  "Tier10:hunter:n" },
				{ 10, "Tier10:mage:n" },
				{ 12, "Tier10:paladinholy:n" },
				{ 13, "Tier10:paladinprotection:n" },
				{ 14, "Tier10:paladinretribution:n" },
				{ 16, "Tier10:priestheal:n" },
				{ 17, "Tier10:priestshadow:n" },
				{ 19, "Tier10:rogue:n" },
				{ 21, "Tier10:shamanelemental:n" },
				{ 22, "Tier10:shamanenhancement:n" },
				{ 23, "Tier10:shamanrestoration:n" },
				{ 25, "Tier10:warlock:n" },
				{ 27, "Tier10:warriordps:n" },
				{ 28, "Tier10:warriorprotection:n" },
			},
			[P25_DIFF] = {
				{ 1,  "Tier10:deathknightblood:p25" },
				{ 2,  "Tier10:deathknightdps:p25" },
				{ 4,  "Tier10:druidbalance:p25" },
				{ 5,  "Tier10:druidferal:p25" },
				{ 6,  "Tier10:druidrestoration:p25" },
				{ 8,  "Tier10:hunter:p25" },
				{ 10, "Tier10:mage:p25" },
				{ 12, "Tier10:paladinholy:p25" },
				{ 13, "Tier10:paladinprotection:p25" },
				{ 14, "Tier10:paladinretribution:p25" },
				{ 16, "Tier10:priestheal:p25" },
				{ 17, "Tier10:priestshadow:p25" },
				{ 19, "Tier10:rogue:p25" },
				{ 21, "Tier10:shamanelemental:p25" },
				{ 22, "Tier10:shamanenhancement:p25" },
				{ 23, "Tier10:shamanrestoration:p25" },
				{ 25, "Tier10:warlock:p25" },
				{ 27, "Tier10:warriordps:p25" },
				{ 28, "Tier10:warriorprotection:p25" },
			},
			[P25H_DIFF] = {
				{ 1,  "Tier10:deathknightblood:p25h" },
				{ 2,  "Tier10:deathknightdps:p25h" },
				{ 4,  "Tier10:druidbalance:p25h" },
				{ 5,  "Tier10:druidferal:p25h" },
				{ 6,  "Tier10:druidrestoration:p25h" },
				{ 8,  "Tier10:hunter:p25h" },
				{ 10, "Tier10:mage:p25h" },
				{ 12, "Tier10:paladinholy:p25h" },
				{ 13, "Tier10:paladinprotection:p25h" },
				{ 14, "Tier10:paladinretribution:p25h" },
				{ 16, "Tier10:priestheal:p25h" },
				{ 17, "Tier10:priestshadow:p25h" },
				{ 19, "Tier10:rogue:p25h" },
				{ 21, "Tier10:shamanelemental:p25h" },
				{ 22, "Tier10:shamanenhancement:p25h" },
				{ 23, "Tier10:shamanrestoration:p25h" },
				{ 25, "Tier10:warlock:p25h" },
				{ 27, "Tier10:warriordps:p25h" },
				{ 28, "Tier10:warriorprotection:p25h" },
			},
		},
		{ -- Tier 9 Sets
			name = format(AL["Tier %d Sets"], 9).." ("..EXPANSION_NAME2..")",
			tier = 9,
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightblood:n",   [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightblood:n" },
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightdps:n",     [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightdps:n" },
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidbalance:n",       [ATLASLOOT_IT_HORDE] = "Tier9H:druidbalance:n" },
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidferal:n",         [ATLASLOOT_IT_HORDE] = "Tier9H:druidferal:n" },
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidrestoration:n",   [ATLASLOOT_IT_HORDE] = "Tier9H:druidrestoration:n" },
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:hunter:n",             [ATLASLOOT_IT_HORDE] = "Tier9H:hunter:n" },
				{ 10, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:mage:n",               [ATLASLOOT_IT_HORDE] = "Tier9H:mage:n" },
				{ 12, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinholy:n",        [ATLASLOOT_IT_HORDE] = "Tier9H:paladinholy:n" },
				{ 13, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinprotection:n",  [ATLASLOOT_IT_HORDE] = "Tier9H:paladinprotection:n" },
				{ 14, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinretribution:n", [ATLASLOOT_IT_HORDE] = "Tier9H:paladinretribution:n" },
				{ 16, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestheal:n",         [ATLASLOOT_IT_HORDE] = "Tier9H:priestheal:n" },
				{ 17, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestshadow:n",       [ATLASLOOT_IT_HORDE] = "Tier9H:priestshadow:n" },
				{ 19, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:rogue:n",              [ATLASLOOT_IT_HORDE] = "Tier9H:rogue:n" },
				{ 21, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanelemental:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:shamanelemental:n" },
				{ 22, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanenhancement:n",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanenhancement:n" },
				{ 23, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanrestoration:n",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanrestoration:n" },
				{ 25, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warlock:n",            [ATLASLOOT_IT_HORDE] = "Tier9H:warlock:n" },
				{ 27, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriordps:n",         [ATLASLOOT_IT_HORDE] = "Tier9H:warriordps:n" },
				{ 28, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriorprotection:n",  [ATLASLOOT_IT_HORDE] = "Tier9H:warriorprotection:n" },
			},
			[P25_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightblood:p25",   [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightblood:p25" },
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightdps:p25",     [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightdps:p25" },
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidbalance:p25",       [ATLASLOOT_IT_HORDE] = "Tier9H:druidbalance:p25" },
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidferal:p25",         [ATLASLOOT_IT_HORDE] = "Tier9H:druidferal:p25" },
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidrestoration:p25",   [ATLASLOOT_IT_HORDE] = "Tier9H:druidrestoration:p25" },
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:hunter:p25",             [ATLASLOOT_IT_HORDE] = "Tier9H:hunter:p25" },
				{ 10, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:mage:p25",               [ATLASLOOT_IT_HORDE] = "Tier9H:mage:p25" },
				{ 12, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinholy:p25",        [ATLASLOOT_IT_HORDE] = "Tier9H:paladinholy:p25" },
				{ 13, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinprotection:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:paladinprotection:p25" },
				{ 14, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinretribution:p25", [ATLASLOOT_IT_HORDE] = "Tier9H:paladinretribution:p25" },
				{ 16, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestheal:p25",         [ATLASLOOT_IT_HORDE] = "Tier9H:priestheal:p25" },
				{ 17, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestshadow:p25",       [ATLASLOOT_IT_HORDE] = "Tier9H:priestshadow:p25" },
				{ 19, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:rogue:p25",              [ATLASLOOT_IT_HORDE] = "Tier9H:rogue:p25" },
				{ 21, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanelemental:p25",    [ATLASLOOT_IT_HORDE] = "Tier9H:shamanelemental:p25" },
				{ 22, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanenhancement:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanenhancement:p25" },
				{ 23, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanrestoration:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanrestoration:p25" },
				{ 25, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warlock:p25",            [ATLASLOOT_IT_HORDE] = "Tier9H:warlock:p25" },
				{ 27, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriordps:p25",         [ATLASLOOT_IT_HORDE] = "Tier9H:warriordps:p25" },
				{ 28, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriorprotection:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:warriorprotection:p25" },
			},
			[P25H_DIFF] = {
				{ 1,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightblood:p25h",   [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightblood:p25h" },
				{ 2,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightdps:p25h",     [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightdps:p25h" },
				{ 4,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidbalance:p25h",       [ATLASLOOT_IT_HORDE] = "Tier9H:druidbalance:p25h" },
				{ 5,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidferal:p25h",         [ATLASLOOT_IT_HORDE] = "Tier9H:druidferal:p25h" },
				{ 6,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidrestoration:p25h",   [ATLASLOOT_IT_HORDE] = "Tier9H:druidrestoration:p25h" },
				{ 8,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:hunter:p25h",             [ATLASLOOT_IT_HORDE] = "Tier9H:hunter:p25h" },
				{ 10, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:mage:p25h",               [ATLASLOOT_IT_HORDE] = "Tier9H:mage:p25h" },
				{ 12, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinholy:p25h",        [ATLASLOOT_IT_HORDE] = "Tier9H:paladinholy:p25h" },
				{ 13, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinprotection:p25h",  [ATLASLOOT_IT_HORDE] = "Tier9H:paladinprotection:p25h" },
				{ 14, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinretribution:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:paladinretribution:p25h" },
				{ 16, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestheal:p25h",         [ATLASLOOT_IT_HORDE] = "Tier9H:priestheal:p25h" },
				{ 17, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestshadow:p25h",       [ATLASLOOT_IT_HORDE] = "Tier9H:priestshadow:p25h" },
				{ 19, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:rogue:p25h",              [ATLASLOOT_IT_HORDE] = "Tier9H:rogue:p25h" },
				{ 21, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanelemental:p25h",    [ATLASLOOT_IT_HORDE] = "Tier9H:shamanelemental:p25h" },
				{ 22, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanenhancement:p25h",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanenhancement:p25h" },
				{ 23, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanrestoration:p25h",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanrestoration:p25h" },
				{ 25, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warlock:p25h",            [ATLASLOOT_IT_HORDE] = "Tier9H:warlock:p25h" },
				{ 27, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriordps:p25h",         [ATLASLOOT_IT_HORDE] = "Tier9H:warriordps:p25h" },
				{ 28, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriorprotection:p25h",  [ATLASLOOT_IT_HORDE] = "Tier9H:warriorprotection:p25h" },
			},
		},
		{ -- Tier 8 Sets
			name = format(AL["Tier %d Sets"], 8).." ("..EXPANSION_NAME2..")",
			tier = 8,
			[NORMAL_DIFF] = {
				{ 1,  "Tier8:deathknightblood:n" },
				{ 2,  "Tier8:deathknightdps:n" },
				{ 4,  "Tier8:druidbalance:n" },
				{ 5,  "Tier8:druidferal:n" },
				{ 6,  "Tier8:druidrestoration:n" },
				{ 8,  "Tier8:hunter:n" },
				{ 10, "Tier8:mage:n" },
				{ 12, "Tier8:paladinholy:n" },
				{ 13, "Tier8:paladinprotection:n" },
				{ 14, "Tier8:paladinretribution:n" },
				{ 16, "Tier8:priestheal:n" },
				{ 17, "Tier8:priestshadow:n" },
				{ 19, "Tier8:rogue:n" },
				{ 21, "Tier8:shamanelemental:n" },
				{ 22, "Tier8:shamanenhancement:n" },
				{ 23, "Tier8:shamanrestoration:n" },
				{ 25, "Tier8:warlock:n" },
				{ 27, "Tier8:warriordps:n" },
				{ 28, "Tier8:warriorprotection:n" },
			},
			[P25_DIFF] = {
				{ 1,  "Tier8:deathknightblood:p25" },
				{ 2,  "Tier8:deathknightdps:p25" },
				{ 4,  "Tier8:druidbalance:p25" },
				{ 5,  "Tier8:druidferal:p25" },
				{ 6,  "Tier8:druidrestoration:p25" },
				{ 8,  "Tier8:hunter:p25" },
				{ 10, "Tier8:mage:p25" },
				{ 12, "Tier8:paladinholy:p25" },
				{ 13, "Tier8:paladinprotection:p25" },
				{ 14, "Tier8:paladinretribution:p25" },
				{ 16, "Tier8:priestheal:p25" },
				{ 17, "Tier8:priestshadow:p25" },
				{ 19, "Tier8:rogue:p25" },
				{ 21, "Tier8:shamanelemental:p25" },
				{ 22, "Tier8:shamanenhancement:p25" },
				{ 23, "Tier8:shamanrestoration:p25" },
				{ 25, "Tier8:warlock:p25" },
				{ 27, "Tier8:warriordps:p25" },
				{ 28, "Tier8:warriorprotection:p25" },
			},
		},
		{ -- Tier 7 Sets
			name = format(AL["Tier %d Sets"], 7).." ("..EXPANSION_NAME2..")",
			tier = 7,
			[NORMAL_DIFF] = {
				{ 1,  "Tier7:deathknightblood:n" },
				{ 2,  "Tier7:deathknightdps:n" },
				{ 4,  "Tier7:druidbalance:n" },
				{ 5,  "Tier7:druidferal:n" },
				{ 6,  "Tier7:druidrestoration:n" },
				{ 8,  "Tier7:hunter:n" },
				{ 10, "Tier7:mage:n" },
				{ 12, "Tier7:paladinholy:n" },
				{ 13, "Tier7:paladinprotection:n" },
				{ 14, "Tier7:paladinretribution:n" },
				{ 16, "Tier7:priestheal:n" },
				{ 17, "Tier7:priestshadow:n" },
				{ 19, "Tier7:rogue:n" },
				{ 21, "Tier7:shamanelemental:n" },
				{ 22, "Tier7:shamanenhancement:n" },
				{ 23, "Tier7:shamanrestoration:n" },
				{ 25, "Tier7:warlock:n" },
				{ 27, "Tier7:warriordps:n" },
				{ 28, "Tier7:warriorprotection:n" },
			},
			[P25_DIFF] = {
				{ 1,  "Tier7:deathknightblood:p25" },
				{ 2,  "Tier7:deathknightdps:p25" },
				{ 4,  "Tier7:druidbalance:p25" },
				{ 5,  "Tier7:druidferal:p25" },
				{ 6,  "Tier7:druidrestoration:p25" },
				{ 8,  "Tier7:hunter:p25" },
				{ 10, "Tier7:mage:p25" },
				{ 12, "Tier7:paladinholy:p25" },
				{ 13, "Tier7:paladinprotection:p25" },
				{ 14, "Tier7:paladinretribution:p25" },
				{ 16, "Tier7:priestheal:p25" },
				{ 17, "Tier7:priestshadow:p25" },
				{ 19, "Tier7:rogue:p25" },
				{ 21, "Tier7:shamanelemental:p25" },
				{ 22, "Tier7:shamanenhancement:p25" },
				{ 23, "Tier7:shamanrestoration:p25" },
				{ 25, "Tier7:warlock:p25" },
				{ 27, "Tier7:warriordps:p25" },
				{ 28, "Tier7:warriorprotection:p25" },
			},
		},
		{ -- Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6).." ("..EXPANSION_NAME1..")",
			tier = 6,
			[P25_DIFF] = {
				{ 1,  "Tier6:druidbalance:p25" },
				{ 2,  "Tier6:druidferal:p25" },
				{ 3,  "Tier6:druidrestoration:p25" },
				{ 5,  "Tier6:hunter:p25" },
				{ 7,  "Tier6:mage:p25" },
				{ 9,  "Tier6:paladinholy:p25" },
				{ 10, "Tier6:paladinprotection:p25" },
				{ 11, "Tier6:paladinretribution:p25" },
				{ 13, "Tier6:priestheal:p25" },
				{ 14, "Tier6:priestshadow:p25" },
				{ 16, "Tier6:rogue:p25" },
				{ 18, "Tier6:shamanelemental:p25" },
				{ 19, "Tier6:shamanenhancement:p25" },
				{ 20, "Tier6:shamanrestoration:p25" },
				{ 22, "Tier6:warlock:p25" },
				{ 24, "Tier6:warriordps:p25" },
				{ 25, "Tier6:warriorprotection:p25" },
			},
		},
		{ -- Tier 5 Sets
			name = format(AL["Tier %d Sets"], 5).." ("..EXPANSION_NAME1..")",
			tier = 5,
			[P25_DIFF] = {
				{ 1,  "Tier5:druidbalance:p25" },
				{ 2,  "Tier5:druidferal:p25" },
				{ 3,  "Tier5:druidrestoration:p25" },
				{ 5,  "Tier5:hunter:p25" },
				{ 7,  "Tier5:mage:p25" },
				{ 9,  "Tier5:paladinholy:p25" },
				{ 10, "Tier5:paladinprotection:p25" },
				{ 11, "Tier5:paladinretribution:p25" },
				{ 13, "Tier5:priestheal:p25" },
				{ 14, "Tier5:priestshadow:p25" },
				{ 16, "Tier5:rogue:p25" },
				{ 18, "Tier5:shamanelemental:p25" },
				{ 19, "Tier5:shamanenhancement:p25" },
				{ 20, "Tier5:shamanrestoration:p25" },
				{ 22, "Tier5:warlock:p25" },
				{ 24, "Tier5:warriordps:p25" },
				{ 25, "Tier5:warriorprotection:p25" },
			},
		},
		{ -- Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4).." ("..EXPANSION_NAME1..")",
			tier = 4,
			[NORMAL_DIFF] = {
				{ 1,  "Tier4:druidbalance:n" },
				{ 2,  "Tier4:druidferal:n" },
				{ 3,  "Tier4:druidrestoration:n" },
				{ 5,  "Tier4:hunter:n" },
				{ 7,  "Tier4:mage:n" },
				{ 9,  "Tier4:paladinholy:n" },
				{ 10, "Tier4:paladinprotection:n" },
				{ 11, "Tier4:paladinretribution:n" },
				{ 13, "Tier4:priestheal:n" },
				{ 14, "Tier4:priestshadow:n" },
				{ 16, "Tier4:rogue:n" },
				{ 18, "Tier4:shamanelemental:n" },
				{ 19, "Tier4:shamanenhancement:n" },
				{ 20, "Tier4:shamanrestoration:n" },
				{ 22, "Tier4:warlock:n" },
				{ 24, "Tier4:warriordps:n" },
				{ 25, "Tier4:warriorprotection:n" },
			},
		},
		{ -- Tier 3 Sets
			name = format(AL["Tier %d Sets"], 3).." ("..EXPANSION_NAME0..")",
			tier = 3,
			[NORMAL_DIFF] = {
				{ 1,  "Tier3:druid:n" },
				{ 3,  "Tier3:hunter:n" },
				{ 5,  "Tier3:mage:n" },
				{ 7,  "Tier3:paladin:n" },
				{ 9,  "Tier3:priest:n" },
				{ 16, "Tier3:rogue:n" },
				{ 18, "Tier3:shaman:n" },
				{ 20, "Tier3:warlock:n" },
				{ 22, "Tier3:warrior:n" },
			},
		},
		{ -- Tier 2 Sets
			name = format(AL["Tier %d Sets"], 2).." ("..EXPANSION_NAME0..")",
			tier = 2,
			[NORMAL_DIFF] = {
				{ 1,  "Tier2:druid:n" },
				{ 3,  "Tier2:hunter:n" },
				{ 5,  "Tier2:mage:n" },
				{ 7,  "Tier2:paladin:n" },
				{ 9,  "Tier2:priest:n" },
				{ 16, "Tier2:rogue:n" },
				{ 18, "Tier2:shaman:n" },
				{ 20, "Tier2:warlock:n" },
				{ 22, "Tier2:warrior:n" },
			},
		},
		{ -- Tier 1 Sets
			name = format(AL["Tier %d Sets"], 1).." ("..EXPANSION_NAME0..")",
			tier = 1,
			[NORMAL_DIFF] = {
				{ 1,  "Tier1:druid:n" },
				{ 3,  "Tier1:hunter:n" },
				{ 5,  "Tier1:mage:n" },
				{ 7,  "Tier1:paladin:n" },
				{ 9,  "Tier1:priest:n" },
				{ 16, "Tier1:rogue:n" },
				{ 18, "Tier1:shaman:n" },
				{ 20, "Tier1:warlock:n" },
				{ 22, "Tier1:warrior:n" },
			},
		},
	},
}

data["TIERSETS_BYCLASS"]   = {
	name = AL["Tier Sets - per Class"],
	ContentType = COLLECTION_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{ -- DEATHKNIGHT
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier7:deathknightblood:n" },
				{ 2,   "Tier7:deathknightdps:n" },
				{ 3,   "Tier7:deathknightblood:p25" },
				{ 4,   "Tier7:deathknightdps:p25" },
				{ 6,   "Tier8:deathknightblood:n" },
				{ 7,   "Tier8:deathknightdps:n" },
				{ 8,   "Tier8:deathknightblood:p25" },
				{ 9,   "Tier8:deathknightdps:p25" },
				{ 11,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightblood:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightblood:n" },
				{ 12,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightblood:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightblood:p25" },
				{ 13,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightblood:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightblood:p25h" },
				{ 14,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightdps:n",      [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightdps:n" },
				{ 15,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightdps:p25",    [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightdps:p25" },
				{ 16,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:deathknightdps:p25h",   [ATLASLOOT_IT_HORDE] = "Tier9H:deathknightdps:p25h" },
				{ 18,  "Tier10:deathknightblood:n" },
				{ 19,  "Tier10:deathknightdps:n" },
				{ 20,  "Tier10:deathknightblood:p25" },
				{ 21,  "Tier10:deathknightdps:p25" },
				{ 22,  "Tier10:deathknightblood:p25h" },
				{ 23,  "Tier10:deathknightdps:p25h" },
				{ 25,  "Tier11:deathknightblood:n" },
				{ 26,  "Tier11:deathknightdps:n" },
				{ 27,  "Tier11:deathknightblood:h" },
				{ 28,  "Tier11:deathknightdps:h" },
				{ 101, "Tier12:deathknightblood:n" },
				{ 102, "Tier12:deathknightdps:n" },
				{ 103, "Tier12:deathknightblood:h" },
				{ 104, "Tier12:deathknightdps:h" },
				{ 106, "Tier13:deathknightblood:rf" },
				{ 107, "Tier13:deathknightdps:rf" },
				{ 108, "Tier13:deathknightblood:n" },
				{ 109, "Tier13:deathknightdps:n" },
				{ 110, "Tier13:deathknightblood:h" },
				{ 111, "Tier13:deathknightdps:h" },
				{ 116, "Tier14:deathknightblood:rf" },
				{ 117, "Tier14:deathknightdps:rf" },
				{ 118, "Tier14:deathknightblood:n" },
				{ 119, "Tier14:deathknightdps:n" },
				{ 120, "Tier14:deathknightblood:h" },
				{ 121, "Tier14:deathknightdps:h" },
				{ 123, "Tier15:deathknightblood:rf" },
				{ 124, "Tier15:deathknightdps:rf" },
				{ 125, "Tier15:deathknightblood:n" },
				{ 126, "Tier15:deathknightdps:n" },
				{ 127, "Tier15:deathknightblood:h" },
				{ 128, "Tier15:deathknightdps:h" },
				{ 201, "Tier16:deathknightblood:rf" },
				{ 202, "Tier16:deathknightdps:rf" },
				{ 203, "Tier16:deathknightblood:n" },
				{ 204, "Tier16:deathknightdps:n" },
				{ 205, "Tier16:deathknightblood:h" },
				{ 206, "Tier16:deathknightdps:h" },
				{ 207, "Tier16:deathknightblood:m" },
				{ 208, "Tier16:deathknightdps:m" },
				{ 210, "Tier17:dk:n" },
				{ 211, "Tier17:dk:hB1" },
				{ 212, "Tier17:dk:mB1" },
				{ 216, "Tier18:dk:n" },
				{ 217, "Tier18:dk:hB1" },
				{ 218, "Tier18:dk:mB1" },
				{ 220, "Tier19:deathknight:LFRWithDifficulty" },
				{ 221, "Tier19:deathknight:NormalWithDifficulty" },
				{ 222, "Tier19:deathknight:HeroicWithDifficulty" },
				{ 223, "Tier19:deathknight:MythicWithDifficulty" },
				{ 225, "Tier20:deathknight:LFRWithDifficulty" },
				{ 226, "Tier20:deathknight:NormalWithDifficulty" },
				{ 227, "Tier20:deathknight:HeroicWithDifficulty" },
				{ 228, "Tier20:deathknight:MythicWithDifficulty" },
				{ 301, "Tier21:deathknight:LFRWithDifficulty" },
				{ 302, "Tier21:deathknight:NormalWithDifficulty" },
				{ 303, "Tier21:deathknight:HeroicWithDifficulty" },
				{ 304, "Tier21:deathknight:MythicWithDifficulty" },
				{ 306, "Tier32:deathknight:LFRWithDifficulty" },
				{ 307, "Tier32:deathknight:NormalWithDifficulty" },
				{ 308, "Tier32:deathknight:HeroicWithDifficulty" },
				{ 309, "Tier32:deathknight:MythicWithDifficulty" },
				{ 311, "Tier33:deathknight:LFRWithDifficulty" },
				{ 312, "Tier33:deathknight:NormalWithDifficulty" },
				{ 313, "Tier33:deathknight:HeroicWithDifficulty" },
				{ 314, "Tier33:deathknight:MythicWithDifficulty" },
				{ 316, "Tier34:deathknight:LFRWithDifficulty" },
				{ 317, "Tier34:deathknight:NormalWithDifficulty" },
				{ 318, "Tier34:deathknight:HeroicWithDifficulty" },
				{ 319, "Tier34:deathknight:MythicWithDifficulty" },
			},
		},
		{ -- DEMONHUNTER
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[NORMAL_DIFF] = {
				{ 1,  "Tier19:demonhunter:LFRWithDifficulty" },
				{ 2,  "Tier19:demonhunter:NormalWithDifficulty" },
				{ 3,  "Tier19:demonhunter:HeroicWithDifficulty" },
				{ 4,  "Tier19:demonhunter:MythicWithDifficulty" },
				{ 6,  "Tier20:demonhunter:LFRWithDifficulty" },
				{ 7,  "Tier20:demonhunter:NormalWithDifficulty" },
				{ 8,  "Tier20:demonhunter:HeroicWithDifficulty" },
				{ 9,  "Tier20:demonhunter:MythicWithDifficulty" },
				{ 11, "Tier21:demonhunter:LFRWithDifficulty" },
				{ 12, "Tier21:demonhunter:NormalWithDifficulty" },
				{ 13, "Tier21:demonhunter:HeroicWithDifficulty" },
				{ 14, "Tier21:demonhunter:MythicWithDifficulty" },
				{ 16, "Tier32:demonhunter:LFRWithDifficulty" },
				{ 17, "Tier32:demonhunter:NormalWithDifficulty" },
				{ 18, "Tier32:demonhunter:HeroicWithDifficulty" },
				{ 19, "Tier32:demonhunter:MythicWithDifficulty" },
				{ 21, "Tier33:demonhunter:LFRWithDifficulty" },
				{ 22, "Tier33:demonhunter:NormalWithDifficulty" },
				{ 23, "Tier33:demonhunter:HeroicWithDifficulty" },
				{ 24, "Tier33:demonhunter:MythicWithDifficulty" },
				{ 26, "Tier34:demonhunter:LFRWithDifficulty" },
				{ 27, "Tier34:demonhunter:NormalWithDifficulty" },
				{ 28, "Tier34:demonhunter:HeroicWithDifficulty" },
				{ 29, "Tier34:demonhunter:MythicWithDifficulty" },
			},
		},
		{ -- DRUID
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:druid:n" },
				{ 3,   "Tier2:druid:n" },
				{ 5,   "Tier3:druid:n" },
				{ 7,   "Tier4:druidbalance:n" },
				{ 8,   "Tier4:druidferal:n" },
				{ 9,   "Tier4:druidrestoration:n" },
				{ 11,  "Tier5:druidbalance:p25" },
				{ 12,  "Tier5:druidferal:p25" },
				{ 13,  "Tier5:druidrestoration:p25" },
				{ 16,  "Tier6:druidbalance:p25" },
				{ 17,  "Tier6:druidferal:p25" },
				{ 18,  "Tier6:druidrestoration:p25" },
				{ 20,  "Tier7:druidbalance:n" },
				{ 21,  "Tier7:druidferal:n" },
				{ 22,  "Tier7:druidrestoration:n" },
				{ 23,  "Tier7:druidbalance:p25" },
				{ 24,  "Tier7:druidferal:p25" },
				{ 25,  "Tier7:druidrestoration:p25" },
				{ 101, "Tier8:druidbalance:n" },
				{ 102, "Tier8:druidferal:n" },
				{ 103, "Tier8:druidrestoration:n" },
				{ 104, "Tier8:druidbalance:p25" },
				{ 105, "Tier8:druidferal:p25" },
				{ 106, "Tier8:druidrestoration:p25" },
				{ 108, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidbalance:n",        [ATLASLOOT_IT_HORDE] = "Tier9H:druidbalance:n" },
				{ 109, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidbalance:p25",      [ATLASLOOT_IT_HORDE] = "Tier9H:druidbalance:p25" },
				{ 110, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidbalance:p25h",     [ATLASLOOT_IT_HORDE] = "Tier9H:druidbalance:p25h" },
				{ 111, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidferal:n",          [ATLASLOOT_IT_HORDE] = "Tier9H:druidferal:n" },
				{ 112, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidferal:p25",        [ATLASLOOT_IT_HORDE] = "Tier9H:druidferal:p25" },
				{ 113, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidferal:p25h",       [ATLASLOOT_IT_HORDE] = "Tier9H:druidferal:p25h" },
				{ 114, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidrestoration:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:druidrestoration:n" },
				{ 115, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidrestoration:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:druidrestoration:p25" },
				{ 116, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:druidrestoration:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:druidrestoration:p25h" },
				{ 118, "Tier10:druidbalance:n" },
				{ 119, "Tier10:druidferal:n" },
				{ 120, "Tier10:druidrestoration:n" },
				{ 121, "Tier10:druidbalance:p25" },
				{ 122, "Tier10:druidferal:p25" },
				{ 123, "Tier10:druidrestoration:p25" },
				{ 124, "Tier10:druidbalance:p25h" },
				{ 125, "Tier10:druidferal:p25h" },
				{ 126, "Tier10:druidrestoration:p25h" },
				{ 201, "Tier11:druidbalance:n" },
				{ 202, "Tier11:druidferal:n" },
				{ 203, "Tier11:druidrestoration:n" },
				{ 204, "Tier11:druidbalance:h" },
				{ 205, "Tier11:druidferal:h" },
				{ 206, "Tier11:druidrestoration:h" },
				{ 208, "Tier12:druidbalance:n" },
				{ 209, "Tier12:druidferal:n" },
				{ 210, "Tier12:druidrestoration:n" },
				{ 211, "Tier12:druidbalance:h" },
				{ 212, "Tier12:druidferal:h" },
				{ 213, "Tier12:druidrestoration:h" },
				{ 216, "Tier13:druidbalance:rf" },
				{ 217, "Tier13:druidferal:rf" },
				{ 218, "Tier13:druidrestoration:rf" },
				{ 219, "Tier13:druidbalance:n" },
				{ 220, "Tier13:druidferal:n" },
				{ 221, "Tier13:druidrestoration:n" },
				{ 222, "Tier13:druidbalance:h" },
				{ 223, "Tier13:druidferal:h" },
				{ 224, "Tier13:druidrestoration:h" },
				{ 301, "Tier14:druidbalance:rf" },
				{ 302, "Tier14:druidferal:rf" },
				{ 303, "Tier14:druidguardian:rf" },
				{ 304, "Tier14:druidrestoration:rf" },
				{ 305, "Tier14:druidbalance:n" },
				{ 306, "Tier14:druidferal:n" },
				{ 307, "Tier14:druidguardian:n" },
				{ 308, "Tier14:druidrestoration:n" },
				{ 309, "Tier14:druidbalance:h" },
				{ 310, "Tier14:druidferal:h" },
				{ 311, "Tier14:druidguardian:h" },
				{ 312, "Tier14:druidrestoration:h" },
				{ 316, "Tier15:druidbalance:rf" },
				{ 317, "Tier15:druidferal:rf" },
				{ 318, "Tier15:druidguardian:rf" },
				{ 319, "Tier15:druidrestoration:rf" },
				{ 320, "Tier15:druidbalance:n" },
				{ 321, "Tier15:druidferal:n" },
				{ 322, "Tier15:druidguardian:n" },
				{ 323, "Tier15:druidrestoration:n" },
				{ 324, "Tier15:druidbalance:h" },
				{ 325, "Tier15:druidferal:h" },
				{ 326, "Tier15:druidguardian:h" },
				{ 327, "Tier15:druidrestoration:h" },
				{ 401, "Tier16:druidbalance:rf" },
				{ 402, "Tier16:druidferal:rf" },
				{ 403, "Tier16:druidguardian:rf" },
				{ 404, "Tier16:druidrestoration:rf" },
				{ 405, "Tier16:druidbalance:n" },
				{ 406, "Tier16:druidferal:n" },
				{ 407, "Tier16:druidguardian:n" },
				{ 408, "Tier16:druidrestoration:n" },
				{ 409, "Tier16:druidbalance:h" },
				{ 410, "Tier16:druidferal:h" },
				{ 411, "Tier16:druidguardian:h" },
				{ 412, "Tier16:druidrestoration:h" },
				{ 413, "Tier16:druidbalance:m" },
				{ 414, "Tier16:druidferal:m" },
				{ 415, "Tier16:druidguardian:m" },
				{ 416, "Tier16:druidrestoration:m" },
				{ 418, "Tier17:druid:n" },
				{ 419, "Tier17:druid:hB1" },
				{ 420, "Tier17:druid:mB1" },
				{ 422, "Tier18:druid:n" },
				{ 423, "Tier18:druid:hB1" },
				{ 424, "Tier18:druid:mB1" },
				{ 426, "Tier19:druid:LFRWithDifficulty" },
				{ 427, "Tier19:druid:NormalWithDifficulty" },
				{ 428, "Tier19:druid:HeroicWithDifficulty" },
				{ 429, "Tier19:druid:MythicWithDifficulty" },
				{ 501, "Tier20:druid:LFRWithDifficulty" },
				{ 502, "Tier20:druid:NormalWithDifficulty" },
				{ 503, "Tier20:druid:HeroicWithDifficulty" },
				{ 504, "Tier20:druid:MythicWithDifficulty" },
				{ 506, "Tier21:druid:LFRWithDifficulty" },
				{ 507, "Tier21:druid:NormalWithDifficulty" },
				{ 508, "Tier21:druid:HeroicWithDifficulty" },
				{ 509, "Tier21:druid:MythicWithDifficulty" },
				{ 511, "Tier32:druid:LFRWithDifficulty" },
				{ 512, "Tier32:druid:NormalWithDifficulty" },
				{ 513, "Tier32:druid:HeroicWithDifficulty" },
				{ 514, "Tier32:druid:MythicWithDifficulty" },
				{ 516, "Tier33:druid:LFRWithDifficulty" },
				{ 517, "Tier33:druid:NormalWithDifficulty" },
				{ 518, "Tier33:druid:HeroicWithDifficulty" },
				{ 519, "Tier33:druid:MythicWithDifficulty" },
				{ 521, "Tier34:druid:LFRWithDifficulty" },
				{ 522, "Tier34:druid:NormalWithDifficulty" },
				{ 523, "Tier34:druid:HeroicWithDifficulty" },
				{ 524, "Tier34:druid:MythicWithDifficulty" },
			},
		},
		{ -- EVOKER
			name = ATLASLOOT_EVOKER_COLOR..ALIL["EVOKER"],
			[NORMAL_DIFF] = {
				{ 1,  "Tier32:evoker:LFRWithDifficulty" },
				{ 2,  "Tier32:evoker:NormalWithDifficulty" },
				{ 3,  "Tier32:evoker:HeroicWithDifficulty" },
				{ 4,  "Tier32:evoker:MythicWithDifficulty" },
				{ 6,  "Tier33:evoker:LFRWithDifficulty" },
				{ 7,  "Tier33:evoker:NormalWithDifficulty" },
				{ 8,  "Tier33:evoker:HeroicWithDifficulty" },
				{ 9,  "Tier33:evoker:MythicWithDifficulty" },
				{ 11, "Tier34:evoker:LFRWithDifficulty" },
				{ 12, "Tier34:evoker:NormalWithDifficulty" },
				{ 13, "Tier34:evoker:HeroicWithDifficulty" },
				{ 14, "Tier34:evoker:MythicWithDifficulty" },
			},
		},
		{ -- HUNTER
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:hunter:n" },
				{ 3,   "Tier2:hunter:n" },
				{ 5,   "Tier3:hunter:n" },
				{ 6,   "Tier4:hunter:n" },
				{ 8,   "Tier5:hunter:p25" },
				{ 11,  "Tier6:hunter:p25" },
				{ 13,  "Tier7:hunter:n" },
				{ 14,  "Tier7:hunter:p25" },
				{ 16,  "Tier8:hunter:n" },
				{ 17,  "Tier8:hunter:p25" },
				{ 19,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:hunter:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:hunter:n" },
				{ 20,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:hunter:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:hunter:p25" },
				{ 21,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:hunter:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:hunter:p25h" },
				{ 23,  "Tier10:hunter:n" },
				{ 24,  "Tier10:hunter:p25" },
				{ 25,  "Tier10:hunter:p25h" },
				{ 27,  "Tier11:hunter:n" },
				{ 28,  "Tier11:hunter:h" },
				{ 101, "Tier12:hunter:n" },
				{ 102, "Tier12:hunter:h" },
				{ 104, "Tier13:hunter:rf" },
				{ 105, "Tier13:hunter:n" },
				{ 106, "Tier13:hunter:h" },
				{ 108, "Tier14:hunter:rf" },
				{ 109, "Tier14:hunter:n" },
				{ 110, "Tier14:hunter:h" },
				{ 112, "Tier15:hunter:rf" },
				{ 113, "Tier15:hunter:n" },
				{ 114, "Tier15:hunter:h" },
				{ 116, "Tier16:hunter:rf" },
				{ 117, "Tier16:hunter:n" },
				{ 118, "Tier16:hunter:h" },
				{ 119, "Tier16:hunter:m" },
				{ 121, "Tier17:hunter:n" },
				{ 122, "Tier17:hunter:hB1" },
				{ 123, "Tier17:hunter:mB1" },
				{ 125, "Tier18:hunter:n" },
				{ 126, "Tier18:hunter:hB1" },
				{ 127, "Tier18:hunter:mB1" },
				{ 201, "Tier19:hunter:LFRWithDifficulty" },
				{ 202, "Tier19:hunter:NormalWithDifficulty" },
				{ 203, "Tier19:hunter:HeroicWithDifficulty" },
				{ 204, "Tier19:hunter:MythicWithDifficulty" },
				{ 206, "Tier20:hunter:LFRWithDifficulty" },
				{ 207, "Tier20:hunter:NormalWithDifficulty" },
				{ 208, "Tier20:hunter:HeroicWithDifficulty" },
				{ 209, "Tier20:hunter:MythicWithDifficulty" },
				{ 211, "Tier21:hunter:LFRWithDifficulty" },
				{ 212, "Tier21:hunter:NormalWithDifficulty" },
				{ 213, "Tier21:hunter:HeroicWithDifficulty" },
				{ 214, "Tier21:hunter:MythicWithDifficulty" },
				{ 216, "Tier32:hunter:LFRWithDifficulty" },
				{ 217, "Tier32:hunter:NormalWithDifficulty" },
				{ 218, "Tier32:hunter:HeroicWithDifficulty" },
				{ 219, "Tier32:hunter:MythicWithDifficulty" },
				{ 221, "Tier33:hunter:LFRWithDifficulty" },
				{ 222, "Tier33:hunter:NormalWithDifficulty" },
				{ 223, "Tier33:hunter:HeroicWithDifficulty" },
				{ 224, "Tier33:hunter:MythicWithDifficulty" },
				{ 226, "Tier34:hunter:LFRWithDifficulty" },
				{ 227, "Tier34:hunter:NormalWithDifficulty" },
				{ 228, "Tier34:hunter:HeroicWithDifficulty" },
				{ 229, "Tier34:hunter:MythicWithDifficulty" },
			},
		},
		{ -- MAGE
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:mage:n" },
				{ 3,   "Tier2:mage:n" },
				{ 5,   "Tier3:mage:n" },
				{ 7,   "Tier4:mage:n" },
				{ 9,   "Tier5:mage:p25" },
				{ 11,  "Tier6:mage:p25" },
				{ 13,  "Tier7:mage:n" },
				{ 14,  "Tier7:mage:p25" },
				{ 16,  "Tier8:mage:n" },
				{ 17,  "Tier8:mage:p25" },
				{ 19,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:mage:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:mage:n" },
				{ 20,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:mage:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:mage:p25" },
				{ 21,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:mage:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:mage:p25h" },
				{ 23,  "Tier10:mage:n" },
				{ 24,  "Tier10:mage:p25" },
				{ 25,  "Tier10:mage:p25h" },
				{ 27,  "Tier11:mage:n" },
				{ 28,  "Tier11:mage:h" },
				{ 101, "Tier12:mage:n" },
				{ 102, "Tier12:mage:h" },
				{ 104, "Tier13:mage:rf" },
				{ 105, "Tier13:mage:n" },
				{ 106, "Tier13:mage:h" },
				{ 108, "Tier14:mage:rf" },
				{ 109, "Tier14:mage:n" },
				{ 110, "Tier14:mage:h" },
				{ 112, "Tier15:mage:rf" },
				{ 113, "Tier15:mage:n" },
				{ 114, "Tier15:mage:h" },
				{ 116, "Tier16:mage:rf" },
				{ 117, "Tier16:mage:n" },
				{ 118, "Tier16:mage:h" },
				{ 119, "Tier16:mage:m" },
				{ 121, "Tier17:mage:n" },
				{ 122, "Tier17:mage:hB1" },
				{ 123, "Tier17:mage:mB1" },
				{ 125, "Tier18:mage:n" },
				{ 126, "Tier18:mage:hB1" },
				{ 127, "Tier18:mage:mB1" },
				{ 201, "Tier19:mage:LFRWithDifficulty" },
				{ 202, "Tier19:mage:NormalWithDifficulty" },
				{ 203, "Tier19:mage:HeroicWithDifficulty" },
				{ 204, "Tier19:mage:MythicWithDifficulty" },
				{ 206, "Tier20:mage:LFRWithDifficulty" },
				{ 207, "Tier20:mage:NormalWithDifficulty" },
				{ 208, "Tier20:mage:HeroicWithDifficulty" },
				{ 209, "Tier20:mage:MythicWithDifficulty" },
				{ 211, "Tier21:mage:LFRWithDifficulty" },
				{ 212, "Tier21:mage:NormalWithDifficulty" },
				{ 213, "Tier21:mage:HeroicWithDifficulty" },
				{ 214, "Tier21:mage:MythicWithDifficulty" },
				{ 216, "Tier32:mage:LFRWithDifficulty" },
				{ 217, "Tier32:mage:NormalWithDifficulty" },
				{ 218, "Tier32:mage:HeroicWithDifficulty" },
				{ 219, "Tier32:mage:MythicWithDifficulty" },
				{ 221, "Tier33:mage:LFRWithDifficulty" },
				{ 222, "Tier33:mage:NormalWithDifficulty" },
				{ 223, "Tier33:mage:HeroicWithDifficulty" },
				{ 224, "Tier33:mage:MythicWithDifficulty" },
				{ 226, "Tier34:mage:LFRWithDifficulty" },
				{ 227, "Tier34:mage:NormalWithDifficulty" },
				{ 228, "Tier34:mage:HeroicWithDifficulty" },
				{ 229, "Tier34:mage:MythicWithDifficulty" },
			},
		},
		{ -- MONK
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier14:monkbrewmaster:rf" },
				{ 2,   "Tier14:monkmistweaver:rf" },
				{ 3,   "Tier14:monkwindwalker:rf" },
				{ 4,   "Tier14:monkbrewmaster:n" },
				{ 5,   "Tier14:monkmistweaver:n" },
				{ 6,   "Tier14:monkwindwalker:n" },
				{ 7,   "Tier14:monkbrewmaster:h" },
				{ 8,   "Tier14:monkmistweaver:h" },
				{ 9,   "Tier14:monkwindwalker:h" },
				{ 16,  "Tier15:monkbrewmaster:rf" },
				{ 17,  "Tier15:monkmistweaver:rf" },
				{ 18,  "Tier15:monkwindwalker:rf" },
				{ 19,  "Tier15:monkbrewmaster:n" },
				{ 20,  "Tier15:monkmistweaver:n" },
				{ 21,  "Tier15:monkwindwalker:n" },
				{ 22,  "Tier15:monkbrewmaster:h" },
				{ 23,  "Tier15:monkmistweaver:h" },
				{ 24,  "Tier15:monkwindwalker:h" },
				{ 101, "Tier16:monkbrewmaster:rf" },
				{ 102, "Tier16:monkmistweaver:rf" },
				{ 103, "Tier16:monkwindwalker:rf" },
				{ 104, "Tier16:monkbrewmaster:n" },
				{ 105, "Tier16:monkmistweaver:n" },
				{ 106, "Tier16:monkwindwalker:n" },
				{ 107, "Tier16:monkbrewmaster:h" },
				{ 108, "Tier16:monkmistweaver:h" },
				{ 109, "Tier16:monkwindwalker:h" },
				{ 110, "Tier16:monkbrewmaster:m" },
				{ 111, "Tier16:monkmistweaver:m" },
				{ 112, "Tier16:monkwindwalker:m" },
				{ 116, "Tier17:monk:n" },
				{ 117, "Tier17:monk:hB1" },
				{ 118, "Tier17:monk:mB1" },
				{ 120, "Tier18:monk:n" },
				{ 121, "Tier18:monk:hB1" },
				{ 122, "Tier18:monk:mB1" },
				{ 124, "Tier19:monk:LFRWithDifficulty" },
				{ 125, "Tier19:monk:NormalWithDifficulty" },
				{ 126, "Tier19:monk:HeroicWithDifficulty" },
				{ 127, "Tier19:monk:MythicWithDifficulty" },
				{ 201, "Tier20:monk:LFRWithDifficulty" },
				{ 202, "Tier20:monk:NormalWithDifficulty" },
				{ 203, "Tier20:monk:HeroicWithDifficulty" },
				{ 204, "Tier20:monk:MythicWithDifficulty" },
				{ 206, "Tier21:monk:LFRWithDifficulty" },
				{ 207, "Tier21:monk:NormalWithDifficulty" },
				{ 208, "Tier21:monk:HeroicWithDifficulty" },
				{ 209, "Tier21:monk:MythicWithDifficulty" },
				{ 211, "Tier32:monk:LFRWithDifficulty" },
				{ 212, "Tier32:monk:NormalWithDifficulty" },
				{ 213, "Tier32:monk:HeroicWithDifficulty" },
				{ 214, "Tier32:monk:MythicWithDifficulty" },
				{ 216, "Tier33:monk:LFRWithDifficulty" },
				{ 217, "Tier33:monk:NormalWithDifficulty" },
				{ 218, "Tier33:monk:HeroicWithDifficulty" },
				{ 219, "Tier33:monk:MythicWithDifficulty" },
				{ 221, "Tier34:monk:LFRWithDifficulty" },
				{ 222, "Tier34:monk:NormalWithDifficulty" },
				{ 223, "Tier34:monk:HeroicWithDifficulty" },
				{ 224, "Tier34:monk:MythicWithDifficulty" },
			},
		},
		{ -- PALADIN
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:paladin:n" },
				{ 3,   "Tier2:paladin:n" },
				{ 5,   "Tier3:paladin:n" },
				{ 7,   "Tier4:paladinholy:n" },
				{ 8,   "Tier4:paladinprotection:n" },
				{ 9,   "Tier4:paladinretribution:n" },
				{ 11,  "Tier5:paladinholy:p25" },
				{ 12,  "Tier5:paladinprotection:p25" },
				{ 13,  "Tier5:paladinretribution:p25" },
				{ 16,  "Tier6:paladinholy:p25" },
				{ 17,  "Tier6:paladinprotection:p25" },
				{ 18,  "Tier6:paladinretribution:p25" },
				{ 20,  "Tier7:paladinholy:n" },
				{ 21,  "Tier7:paladinprotection:n" },
				{ 22,  "Tier7:paladinretribution:n" },
				{ 23,  "Tier7:paladinholy:p25" },
				{ 24,  "Tier7:paladinprotection:p25" },
				{ 25,  "Tier7:paladinretribution:p25" },
				{ 101, "Tier8:paladinholy:n" },
				{ 102, "Tier8:paladinprotection:n" },
				{ 103, "Tier8:paladinretribution:n" },
				{ 104, "Tier8:paladinholy:p25" },
				{ 105, "Tier8:paladinprotection:p25" },
				{ 106, "Tier8:paladinretribution:p25" },
				{ 108, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinholy:n",           [ATLASLOOT_IT_HORDE] = "Tier9H:paladinholy:n" },
				{ 109, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinholy:p25",         [ATLASLOOT_IT_HORDE] = "Tier9H:paladinholy:p25" },
				{ 110, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinholy:p25h",        [ATLASLOOT_IT_HORDE] = "Tier9H:paladinholy:p25h" },
				{ 111, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinprotection:n",     [ATLASLOOT_IT_HORDE] = "Tier9H:paladinprotection:n" },
				{ 112, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinprotection:p25",   [ATLASLOOT_IT_HORDE] = "Tier9H:paladinprotection:p25" },
				{ 113, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinprotection:p25h",  [ATLASLOOT_IT_HORDE] = "Tier9H:paladinprotection:p25h" },
				{ 114, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinretribution:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:paladinretribution:n" },
				{ 115, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinretribution:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:paladinretribution:p25" },
				{ 116, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:paladinretribution:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:paladinretribution:p25h" },
				{ 118, "Tier10:paladinholy:n" },
				{ 119, "Tier10:paladinprotection:n" },
				{ 120, "Tier10:paladinretribution:n" },
				{ 121, "Tier10:paladinholy:p25" },
				{ 122, "Tier10:paladinprotection:p25" },
				{ 123, "Tier10:paladinretribution:p25" },
				{ 124, "Tier10:paladinholy:p25h" },
				{ 125, "Tier10:paladinprotection:p25h" },
				{ 126, "Tier10:paladinretribution:p25h" },
				{ 201, "Tier11:paladinholy:n" },
				{ 202, "Tier11:paladinprotection:n" },
				{ 203, "Tier11:paladinretribution:n" },
				{ 204, "Tier11:paladinholy:h" },
				{ 205, "Tier11:paladinprotection:h" },
				{ 206, "Tier11:paladinretribution:h" },
				{ 208, "Tier12:paladinholy:n" },
				{ 209, "Tier12:paladinprotection:n" },
				{ 210, "Tier12:paladinretribution:n" },
				{ 211, "Tier12:paladinholy:h" },
				{ 212, "Tier12:paladinprotection:h" },
				{ 213, "Tier12:paladinretribution:h" },
				{ 216, "Tier13:paladinholy:rf" },
				{ 217, "Tier13:paladinprotection:rf" },
				{ 218, "Tier13:paladinretribution:rf" },
				{ 219, "Tier13:paladinholy:n" },
				{ 220, "Tier13:paladinprotection:n" },
				{ 221, "Tier13:paladinretribution:n" },
				{ 222, "Tier13:paladinholy:h" },
				{ 223, "Tier13:paladinprotection:h" },
				{ 224, "Tier13:paladinretribution:h" },
				{ 301, "Tier14:paladinholy:rf" },
				{ 302, "Tier14:paladinprotection:rf" },
				{ 303, "Tier14:paladinretribution:rf" },
				{ 304, "Tier14:paladinholy:n" },
				{ 305, "Tier14:paladinprotection:n" },
				{ 306, "Tier14:paladinretribution:n" },
				{ 307, "Tier14:paladinholy:h" },
				{ 308, "Tier14:paladinprotection:h" },
				{ 309, "Tier14:paladinretribution:h" },
				{ 316, "Tier15:paladinholy:rf" },
				{ 317, "Tier15:paladinprotection:rf" },
				{ 318, "Tier15:paladinretribution:rf" },
				{ 319, "Tier15:paladinholy:n" },
				{ 320, "Tier15:paladinprotection:n" },
				{ 321, "Tier15:paladinretribution:n" },
				{ 322, "Tier15:paladinholy:h" },
				{ 323, "Tier15:paladinprotection:h" },
				{ 324, "Tier15:paladinretribution:h" },
				{ 401, "Tier16:paladinholy:rf" },
				{ 402, "Tier16:paladinprotection:rf" },
				{ 403, "Tier16:paladinretribution:rf" },
				{ 404, "Tier16:paladinholy:n" },
				{ 405, "Tier16:paladinprotection:n" },
				{ 406, "Tier16:paladinretribution:n" },
				{ 407, "Tier16:paladinholy:h" },
				{ 408, "Tier16:paladinprotection:h" },
				{ 409, "Tier16:paladinretribution:h" },
				{ 410, "Tier16:paladinholy:m" },
				{ 411, "Tier16:paladinprotection:m" },
				{ 412, "Tier16:paladinretribution:m" },
				{ 416, "Tier17:paladin:n" },
				{ 417, "Tier17:paladin:hB1" },
				{ 418, "Tier17:paladin:mB1" },
				{ 420, "Tier18:paladin:n" },
				{ 421, "Tier18:paladin:hB1" },
				{ 422, "Tier18:paladin:mB1" },
				{ 424, "Tier19:paladin:LFRWithDifficulty" },
				{ 425, "Tier19:paladin:NormalWithDifficulty" },
				{ 426, "Tier19:paladin:HeroicWithDifficulty" },
				{ 427, "Tier19:paladin:MythicWithDifficulty" },
				{ 501, "Tier20:paladin:LFRWithDifficulty" },
				{ 502, "Tier20:paladin:NormalWithDifficulty" },
				{ 503, "Tier20:paladin:HeroicWithDifficulty" },
				{ 504, "Tier20:paladin:MythicWithDifficulty" },
				{ 506, "Tier21:paladin:LFRWithDifficulty" },
				{ 507, "Tier21:paladin:NormalWithDifficulty" },
				{ 508, "Tier21:paladin:HeroicWithDifficulty" },
				{ 509, "Tier21:paladin:MythicWithDifficulty" },
				{ 511, "Tier32:paladin:LFRWithDifficulty" },
				{ 512, "Tier32:paladin:NormalWithDifficulty" },
				{ 513, "Tier32:paladin:HeroicWithDifficulty" },
				{ 514, "Tier32:paladin:MythicWithDifficulty" },
				{ 516, "Tier33:paladin:LFRWithDifficulty" },
				{ 517, "Tier33:paladin:NormalWithDifficulty" },
				{ 518, "Tier33:paladin:HeroicWithDifficulty" },
				{ 519, "Tier33:paladin:MythicWithDifficulty" },
				{ 521, "Tier34:paladin:LFRWithDifficulty" },
				{ 522, "Tier34:paladin:NormalWithDifficulty" },
				{ 523, "Tier34:paladin:HeroicWithDifficulty" },
				{ 524, "Tier34:paladin:MythicWithDifficulty" },
			},
		},
		{ -- PRIEST
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:priest:n" },
				{ 3,   "Tier2:priest:n" },
				{ 5,   "Tier3:priest:n" },
				{ 7,   "Tier4:priestheal:n" },
				{ 8,   "Tier4:priestshadow:n" },
				{ 10,  "Tier5:priestheal:p25" },
				{ 11,  "Tier5:priestshadow:p25" },
				{ 13,  "Tier6:priestheal:p25" },
				{ 14,  "Tier6:priestshadow:p25" },
				{ 16,  "Tier7:priestheal:n" },
				{ 17,  "Tier7:priestshadow:n" },
				{ 18,  "Tier7:priestheal:p25" },
				{ 19,  "Tier7:priestshadow:p25" },
				{ 21,  "Tier8:priestheal:n" },
				{ 22,  "Tier8:priestshadow:n" },
				{ 23,  "Tier8:priestheal:p25" },
				{ 24,  "Tier8:priestshadow:p25" },
				{ 101, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestheal:n",      [ATLASLOOT_IT_HORDE] = "Tier9H:priestheal:n" },
				{ 102, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestheal:p25",    [ATLASLOOT_IT_HORDE] = "Tier9H:priestheal:p25" },
				{ 103, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestheal:p25h",   [ATLASLOOT_IT_HORDE] = "Tier9H:priestheal:p25h" },
				{ 104, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestshadow:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:priestshadow:n" },
				{ 105, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestshadow:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:priestshadow:p25" },
				{ 106, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:priestshadow:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:priestshadow:p25h" },
				{ 108, "Tier10:priestheal:n" },
				{ 109, "Tier10:priestshadow:n" },
				{ 110, "Tier10:priestheal:p25" },
				{ 111, "Tier10:priestshadow:p25" },
				{ 112, "Tier10:priestheal:p25h" },
				{ 113, "Tier10:priestshadow:p25h" },
				{ 116, "Tier11:priestheal:n" },
				{ 117, "Tier11:priestshadow:n" },
				{ 118, "Tier11:priestheal:h" },
				{ 119, "Tier11:priestshadow:h" },
				{ 121, "Tier12:priestheal:n" },
				{ 122, "Tier12:priestshadow:n" },
				{ 123, "Tier12:priestheal:h" },
				{ 124, "Tier12:priestshadow:h" },
				{ 201, "Tier13:priestheal:rf" },
				{ 202, "Tier13:priestshadow:rf" },
				{ 203, "Tier13:priestheal:n" },
				{ 204, "Tier13:priestshadow:n" },
				{ 205, "Tier13:priestheal:h" },
				{ 206, "Tier13:priestshadow:h" },
				{ 208, "Tier14:priestheal:rf" },
				{ 209, "Tier14:priestshadow:rf" },
				{ 210, "Tier14:priestheal:n" },
				{ 211, "Tier14:priestshadow:n" },
				{ 212, "Tier14:priestheal:h" },
				{ 213, "Tier14:priestshadow:h" },
				{ 216, "Tier15:priestheal:rf" },
				{ 217, "Tier15:priestshadow:rf" },
				{ 218, "Tier15:priestheal:n" },
				{ 219, "Tier15:priestshadow:n" },
				{ 220, "Tier15:priestheal:h" },
				{ 221, "Tier15:priestshadow:h" },
				{ 223, "Tier16:priestheal:rf" },
				{ 224, "Tier16:priestshadow:rf" },
				{ 225, "Tier16:priestheal:n" },
				{ 226, "Tier16:priestshadow:n" },
				{ 227, "Tier16:priestheal:h" },
				{ 228, "Tier16:priestshadow:h" },
				{ 229, "Tier16:priestheal:m" },
				{ 230, "Tier16:priestshadow:m" },
				{ 301, "Tier17:priest:n" },
				{ 302, "Tier17:priest:hB1" },
				{ 303, "Tier17:priest:mB1" },
				{ 305, "Tier18:priest:n" },
				{ 306, "Tier18:priest:hB1" },
				{ 307, "Tier18:priest:mB1" },
				{ 309, "Tier19:priest:LFRWithDifficulty" },
				{ 310, "Tier19:priest:NormalWithDifficulty" },
				{ 311, "Tier19:priest:HeroicWithDifficulty" },
				{ 312, "Tier19:priest:MythicWithDifficulty" },
				{ 316, "Tier20:priest:LFRWithDifficulty" },
				{ 317, "Tier20:priest:NormalWithDifficulty" },
				{ 318, "Tier20:priest:HeroicWithDifficulty" },
				{ 319, "Tier20:priest:MythicWithDifficulty" },
				{ 321, "Tier21:priest:LFRWithDifficulty" },
				{ 322, "Tier21:priest:NormalWithDifficulty" },
				{ 323, "Tier21:priest:HeroicWithDifficulty" },
				{ 324, "Tier21:priest:MythicWithDifficulty" },
				{ 326, "Tier32:priest:LFRWithDifficulty" },
				{ 327, "Tier32:priest:NormalWithDifficulty" },
				{ 328, "Tier32:priest:HeroicWithDifficulty" },
				{ 329, "Tier32:priest:MythicWithDifficulty" },
				{ 401, "Tier33:priest:LFRWithDifficulty" },
				{ 402, "Tier33:priest:NormalWithDifficulty" },
				{ 403, "Tier33:priest:HeroicWithDifficulty" },
				{ 404, "Tier33:priest:MythicWithDifficulty" },
				{ 406, "Tier34:priest:LFRWithDifficulty" },
				{ 407, "Tier34:priest:NormalWithDifficulty" },
				{ 408, "Tier34:priest:HeroicWithDifficulty" },
				{ 409, "Tier34:priest:MythicWithDifficulty" },
			},
		},
		{ -- ROGUE
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:rogue:n" },
				{ 3,   "Tier2:rogue:n" },
				{ 5,   "Tier3:rogue:n" },
				{ 7,   "Tier4:rogue:n" },
				{ 9,   "Tier5:rogue:p25" },
				{ 11,  "Tier6:rogue:p25" },
				{ 13,  "Tier7:rogue:n" },
				{ 14,  "Tier7:rogue:p25" },
				{ 16,  "Tier8:rogue:n" },
				{ 17,  "Tier8:rogue:p25" },
				{ 19,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:rogue:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:rogue:n" },
				{ 20,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:rogue:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:rogue:p25" },
				{ 21,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:rogue:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:rogue:p25h" },
				{ 23,  "Tier10:rogue:n" },
				{ 24,  "Tier10:rogue:p25" },
				{ 25,  "Tier10:rogue:p25h" },
				{ 27,  "Tier11:rogue:n" },
				{ 28,  "Tier11:rogue:h" },
				{ 101, "Tier12:rogue:n" },
				{ 102, "Tier12:rogue:h" },
				{ 104, "Tier13:rogue:rf" },
				{ 105, "Tier13:rogue:n" },
				{ 106, "Tier13:rogue:h" },
				{ 108, "Tier14:rogue:rf" },
				{ 109, "Tier14:rogue:n" },
				{ 110, "Tier14:rogue:h" },
				{ 112, "Tier15:rogue:rf" },
				{ 113, "Tier15:rogue:n" },
				{ 114, "Tier15:rogue:h" },
				{ 116, "Tier16:rogue:rf" },
				{ 117, "Tier16:rogue:n" },
				{ 118, "Tier16:rogue:h" },
				{ 119, "Tier16:rogue:m" },
				{ 121, "Tier17:rogue:n" },
				{ 122, "Tier17:rogue:hB1" },
				{ 123, "Tier17:rogue:mB1" },
				{ 125, "Tier18:rogue:n" },
				{ 126, "Tier18:rogue:hB1" },
				{ 127, "Tier18:rogue:mB1" },
				{ 201, "Tier19:rogue:LFRWithDifficulty" },
				{ 202, "Tier19:rogue:NormalWithDifficulty" },
				{ 203, "Tier19:rogue:HeroicWithDifficulty" },
				{ 204, "Tier19:rogue:MythicWithDifficulty" },
				{ 206, "Tier20:rogue:LFRWithDifficulty" },
				{ 207, "Tier20:rogue:NormalWithDifficulty" },
				{ 208, "Tier20:rogue:HeroicWithDifficulty" },
				{ 209, "Tier20:rogue:MythicWithDifficulty" },
				{ 211, "Tier21:rogue:LFRWithDifficulty" },
				{ 212, "Tier21:rogue:NormalWithDifficulty" },
				{ 213, "Tier21:rogue:HeroicWithDifficulty" },
				{ 214, "Tier21:rogue:MythicWithDifficulty" },
				{ 216, "Tier32:rogue:LFRWithDifficulty" },
				{ 217, "Tier32:rogue:NormalWithDifficulty" },
				{ 218, "Tier32:rogue:HeroicWithDifficulty" },
				{ 219, "Tier32:rogue:MythicWithDifficulty" },
				{ 221, "Tier33:rogue:LFRWithDifficulty" },
				{ 222, "Tier33:rogue:NormalWithDifficulty" },
				{ 223, "Tier33:rogue:HeroicWithDifficulty" },
				{ 224, "Tier33:rogue:MythicWithDifficulty" },
				{ 226, "Tier34:rogue:LFRWithDifficulty" },
				{ 227, "Tier34:rogue:NormalWithDifficulty" },
				{ 228, "Tier34:rogue:HeroicWithDifficulty" },
				{ 229, "Tier34:rogue:MythicWithDifficulty" },
			},
		},
		{ -- SHAMAN
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:shaman:n" },
				{ 3,   "Tier2:shaman:n" },
				{ 5,   "Tier3:shaman:n" },
				{ 7,   "Tier4:shamanelemental:n" },
				{ 8,   "Tier4:shamanenhancement:n" },
				{ 9,   "Tier4:shamanrestoration:n" },
				{ 11,  "Tier5:shamanelemental:p25" },
				{ 12,  "Tier5:shamanenhancement:p25" },
				{ 13,  "Tier5:shamanrestoration:p25" },
				{ 16,  "Tier6:shamanelemental:p25" },
				{ 17,  "Tier6:shamanenhancement:p25" },
				{ 18,  "Tier6:shamanrestoration:p25" },
				{ 20,  "Tier7:shamanelemental:n" },
				{ 21,  "Tier7:shamanenhancement:n" },
				{ 22,  "Tier7:shamanrestoration:n" },
				{ 23,  "Tier7:shamanelemental:p25" },
				{ 24,  "Tier7:shamanenhancement:p25" },
				{ 25,  "Tier7:shamanrestoration:p25" },
				{ 101, "Tier8:shamanelemental:n" },
				{ 102, "Tier8:shamanenhancement:n" },
				{ 103, "Tier8:shamanrestoration:n" },
				{ 104, "Tier8:shamanelemental:p25" },
				{ 105, "Tier8:shamanenhancement:p25" },
				{ 106, "Tier8:shamanrestoration:p25" },
				{ 108, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanelemental:n",      [ATLASLOOT_IT_HORDE] = "Tier9H:shamanelemental:n" },
				{ 109, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanelemental:p25",    [ATLASLOOT_IT_HORDE] = "Tier9H:shamanelemental:p25" },
				{ 110, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanelemental:p25h",   [ATLASLOOT_IT_HORDE] = "Tier9H:shamanelemental:p25h" },
				{ 111, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanenhancement:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:shamanenhancement:n" },
				{ 112, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanenhancement:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanenhancement:p25" },
				{ 113, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanenhancement:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:shamanenhancement:p25h" },
				{ 114, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanrestoration:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:shamanrestoration:n" },
				{ 115, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanrestoration:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:shamanrestoration:p25" },
				{ 116, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:shamanrestoration:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:shamanrestoration:p25h" },
				{ 118, "Tier10:shamanelemental:n" },
				{ 119, "Tier10:shamanenhancement:n" },
				{ 120, "Tier10:shamanrestoration:n" },
				{ 121, "Tier10:shamanelemental:p25" },
				{ 122, "Tier10:shamanenhancement:p25" },
				{ 123, "Tier10:shamanrestoration:p25" },
				{ 124, "Tier10:shamanelemental:p25h" },
				{ 125, "Tier10:shamanenhancement:p25h" },
				{ 126, "Tier10:shamanrestoration:p25h" },
				{ 201, "Tier11:shamanelemental:n" },
				{ 202, "Tier11:shamanenhancement:n" },
				{ 203, "Tier11:shamanrestoration:n" },
				{ 204, "Tier11:shamanelemental:h" },
				{ 205, "Tier11:shamanenhancement:h" },
				{ 206, "Tier11:shamanrestoration:h" },
				{ 208, "Tier12:shamanelemental:n" },
				{ 209, "Tier12:shamanenhancement:n" },
				{ 210, "Tier12:shamanrestoration:n" },
				{ 211, "Tier12:shamanelemental:h" },
				{ 212, "Tier12:shamanenhancement:h" },
				{ 213, "Tier12:shamanrestoration:h" },
				{ 216, "Tier13:shamanelemental:rf" },
				{ 217, "Tier13:shamanenhancement:rf" },
				{ 218, "Tier13:shamanrestoration:rf" },
				{ 219, "Tier13:shamanelemental:n" },
				{ 220, "Tier13:shamanenhancement:n" },
				{ 221, "Tier13:shamanrestoration:n" },
				{ 222, "Tier13:shamanelemental:h" },
				{ 223, "Tier13:shamanenhancement:h" },
				{ 224, "Tier13:shamanrestoration:h" },
				{ 301, "Tier14:shamanelemental:rf" },
				{ 302, "Tier14:shamanenhancement:rf" },
				{ 303, "Tier14:shamanrestoration:rf" },
				{ 304, "Tier14:shamanelemental:n" },
				{ 305, "Tier14:shamanenhancement:n" },
				{ 306, "Tier14:shamanrestoration:n" },
				{ 307, "Tier14:shamanelemental:h" },
				{ 308, "Tier14:shamanenhancement:h" },
				{ 309, "Tier14:shamanrestoration:h" },
				{ 316, "Tier15:shamanelemental:rf" },
				{ 317, "Tier15:shamanenhancement:rf" },
				{ 318, "Tier15:shamanrestoration:rf" },
				{ 319, "Tier15:shamanelemental:n" },
				{ 320, "Tier15:shamanenhancement:n" },
				{ 321, "Tier15:shamanrestoration:n" },
				{ 322, "Tier15:shamanelemental:h" },
				{ 323, "Tier15:shamanenhancement:h" },
				{ 324, "Tier15:shamanrestoration:h" },
				{ 401, "Tier16:shamanelemental:rf" },
				{ 402, "Tier16:shamanenhancement:rf" },
				{ 403, "Tier16:shamanrestoration:rf" },
				{ 404, "Tier16:shamanelemental:n" },
				{ 405, "Tier16:shamanenhancement:n" },
				{ 406, "Tier16:shamanrestoration:n" },
				{ 407, "Tier16:shamanelemental:h" },
				{ 408, "Tier16:shamanenhancement:h" },
				{ 409, "Tier16:shamanrestoration:h" },
				{ 410, "Tier16:shamanelemental:m" },
				{ 411, "Tier16:shamanenhancement:m" },
				{ 412, "Tier16:shamanrestoration:m" },
				{ 416, "Tier17:shaman:n" },
				{ 417, "Tier17:shaman:hB1" },
				{ 418, "Tier17:shaman:mB1" },
				{ 420, "Tier18:shaman:n" },
				{ 421, "Tier18:shaman:hB1" },
				{ 422, "Tier18:shaman:mB1" },
				{ 424, "Tier19:shaman:LFRWithDifficulty" },
				{ 425, "Tier19:shaman:NormalWithDifficulty" },
				{ 426, "Tier19:shaman:HeroicWithDifficulty" },
				{ 427, "Tier19:shaman:MythicWithDifficulty" },
				{ 501, "Tier20:shaman:LFRWithDifficulty" },
				{ 502, "Tier20:shaman:NormalWithDifficulty" },
				{ 503, "Tier20:shaman:HeroicWithDifficulty" },
				{ 504, "Tier20:shaman:MythicWithDifficulty" },
				{ 506, "Tier21:shaman:LFRWithDifficulty" },
				{ 507, "Tier21:shaman:NormalWithDifficulty" },
				{ 508, "Tier21:shaman:HeroicWithDifficulty" },
				{ 509, "Tier21:shaman:MythicWithDifficulty" },
				{ 511, "Tier32:shaman:LFRWithDifficulty" },
				{ 512, "Tier32:shaman:NormalWithDifficulty" },
				{ 513, "Tier32:shaman:HeroicWithDifficulty" },
				{ 514, "Tier32:shaman:MythicWithDifficulty" },
				{ 516, "Tier33:shaman:LFRWithDifficulty" },
				{ 517, "Tier33:shaman:NormalWithDifficulty" },
				{ 518, "Tier33:shaman:HeroicWithDifficulty" },
				{ 519, "Tier33:shaman:MythicWithDifficulty" },
				{ 521, "Tier34:shaman:LFRWithDifficulty" },
				{ 522, "Tier34:shaman:NormalWithDifficulty" },
				{ 523, "Tier34:shaman:HeroicWithDifficulty" },
				{ 524, "Tier34:shaman:MythicWithDifficulty" },
			},
		},
		{ -- WARLOCK
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:warlock:n" },
				{ 3,   "Tier2:warlock:n" },
				{ 5,   "Tier3:warlock:n" },
				{ 7,   "Tier4:warlock:n" },
				{ 9,   "Tier5:warlock:p25" },
				{ 11,  "Tier6:warlock:p25" },
				{ 13,  "Tier7:warlock:n" },
				{ 14,  "Tier7:warlock:p25" },
				{ 16,  "Tier8:warlock:n" },
				{ 17,  "Tier8:warlock:p25" },
				{ 19,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warlock:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:warlock:n" },
				{ 20,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warlock:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:warlock:p25" },
				{ 21,  [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warlock:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:warlock:p25h" },
				{ 23,  "Tier10:warlock:n" },
				{ 24,  "Tier10:warlock:p25" },
				{ 25,  "Tier10:warlock:p25h" },
				{ 27,  "Tier11:warlock:n" },
				{ 28,  "Tier11:warlock:h" },
				{ 101, "Tier12:warlock:n" },
				{ 102, "Tier12:warlock:h" },
				{ 104, "Tier13:warlock:rf" },
				{ 105, "Tier13:warlock:n" },
				{ 106, "Tier13:warlock:h" },
				{ 109, "Tier14:warlock:rf" },
				{ 110, "Tier14:warlock:n" },
				{ 111, "Tier14:warlock:h" },
				{ 113, "Tier15:warlock:rf" },
				{ 114, "Tier15:warlock:n" },
				{ 115, "Tier15:warlock:h" },
				{ 116, "Tier16:warlock:rf" },
				{ 117, "Tier16:warlock:n" },
				{ 118, "Tier16:warlock:h" },
				{ 119, "Tier16:warlock:m" },
				{ 121, "Tier17:warlock:n" },
				{ 122, "Tier17:warlock:hB1" },
				{ 123, "Tier17:warlock:mB1" },
				{ 125, "Tier18:warlock:n" },
				{ 126, "Tier18:warlock:hB1" },
				{ 127, "Tier18:warlock:mB1" },
				{ 201, "Tier19:warlock:LFRWithDifficulty" },
				{ 202, "Tier19:warlock:NormalWithDifficulty" },
				{ 203, "Tier19:warlock:HeroicWithDifficulty" },
				{ 204, "Tier19:warlock:MythicWithDifficulty" },
				{ 206, "Tier20:warlock:LFRWithDifficulty" },
				{ 207, "Tier20:warlock:NormalWithDifficulty" },
				{ 208, "Tier20:warlock:HeroicWithDifficulty" },
				{ 209, "Tier20:warlock:MythicWithDifficulty" },
				{ 211, "Tier21:warlock:LFRWithDifficulty" },
				{ 212, "Tier21:warlock:NormalWithDifficulty" },
				{ 213, "Tier21:warlock:HeroicWithDifficulty" },
				{ 214, "Tier21:warlock:MythicWithDifficulty" },
				{ 216, "Tier32:warlock:LFRWithDifficulty" },
				{ 217, "Tier32:warlock:NormalWithDifficulty" },
				{ 218, "Tier32:warlock:HeroicWithDifficulty" },
				{ 219, "Tier32:warlock:MythicWithDifficulty" },
				{ 221, "Tier33:warlock:LFRWithDifficulty" },
				{ 222, "Tier33:warlock:NormalWithDifficulty" },
				{ 223, "Tier33:warlock:HeroicWithDifficulty" },
				{ 224, "Tier33:warlock:MythicWithDifficulty" },
				{ 226, "Tier34:warlock:LFRWithDifficulty" },
				{ 227, "Tier34:warlock:NormalWithDifficulty" },
				{ 228, "Tier34:warlock:HeroicWithDifficulty" },
				{ 229, "Tier34:warlock:MythicWithDifficulty" },
			},
		},
		{ -- WARRIOR
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[NORMAL_DIFF] = {
				{ 1,   "Tier1:warrior:n" },
				{ 3,   "Tier2:warrior:n" },
				{ 5,   "Tier3:warrior:n" },
				{ 7,   "Tier4:warriordps:n" },
				{ 8,   "Tier4:warriorprotection:n" },
				{ 10,  "Tier5:warriordps:p25" },
				{ 11,  "Tier5:warriorprotection:p25" },
				{ 13,  "Tier6:warriordps:p25" },
				{ 14,  "Tier6:warriorprotection:p25" },
				{ 16,  "Tier7:warriordps:n" },
				{ 17,  "Tier7:warriorprotection:n" },
				{ 18,  "Tier7:warriordps:p25" },
				{ 19,  "Tier7:warriorprotection:p25" },
				{ 21,  "Tier8:warriordps:n" },
				{ 22,  "Tier8:warriorprotection:n" },
				{ 23,  "Tier8:warriordps:p25" },
				{ 24,  "Tier8:warriorprotection:p25" },
				{ 101, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriordps:n",           [ATLASLOOT_IT_HORDE] = "Tier9H:warriordps:n" },
				{ 102, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriordps:p25",         [ATLASLOOT_IT_HORDE] = "Tier9H:warriordps:p25" },
				{ 103, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriordps:p25h",        [ATLASLOOT_IT_HORDE] = "Tier9H:warriordps:p25h" },
				{ 104, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriorprotection:n",    [ATLASLOOT_IT_HORDE] = "Tier9H:warriorprotection:n" },
				{ 105, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriorprotection:p25",  [ATLASLOOT_IT_HORDE] = "Tier9H:warriorprotection:p25" },
				{ 106, [ATLASLOOT_IT_ALLIANCE] = "Tier9A:warriorprotection:p25h", [ATLASLOOT_IT_HORDE] = "Tier9H:warriorprotection:p25h" },
				{ 108, "Tier10:warriordps:n" },
				{ 109, "Tier10:warriorprotection:n" },
				{ 110, "Tier10:warriordps:p25" },
				{ 111, "Tier10:warriorprotection:p25" },
				{ 112, "Tier10:warriordps:p25h" },
				{ 113, "Tier10:warriorprotection:p25h" },
				{ 116, "Tier11:warriordps:n" },
				{ 117, "Tier11:warriorprotection:n" },
				{ 118, "Tier11:warriordps:h" },
				{ 119, "Tier11:warriorprotection:h" },
				{ 121, "Tier12:warriordps:n" },
				{ 122, "Tier12:warriorprotection:n" },
				{ 123, "Tier12:warriordps:h" },
				{ 124, "Tier12:warriorprotection:h" },
				{ 201, "Tier13:warriordps:rf" },
				{ 202, "Tier13:warriorprotection:rf" },
				{ 203, "Tier13:warriordps:n" },
				{ 204, "Tier13:warriorprotection:n" },
				{ 205, "Tier13:warriordps:h" },
				{ 206, "Tier13:warriorprotection:h" },
				{ 208, "Tier14:warriordps:rf" },
				{ 209, "Tier14:warriorprotection:rf" },
				{ 210, "Tier14:warriordps:n" },
				{ 211, "Tier14:warriorprotection:n" },
				{ 212, "Tier14:warriordps:h" },
				{ 213, "Tier14:warriorprotection:h" },
				{ 216, "Tier15:warriordps:rf" },
				{ 217, "Tier15:warriorprotection:rf" },
				{ 218, "Tier15:warriordps:n" },
				{ 219, "Tier15:warriorprotection:n" },
				{ 220, "Tier15:warriordps:h" },
				{ 221, "Tier15:warriorprotection:h" },
				{ 223, "Tier16:warriordps:rf" },
				{ 224, "Tier16:warriorprotection:rf" },
				{ 225, "Tier16:warriordps:n" },
				{ 226, "Tier16:warriorprotection:n" },
				{ 227, "Tier16:warriordps:h" },
				{ 228, "Tier16:warriorprotection:h" },
				{ 229, "Tier16:warriordps:m" },
				{ 230, "Tier16:warriorprotection:m" },
				{ 301, "Tier17:warrior:n" },
				{ 302, "Tier17:warrior:hB1" },
				{ 303, "Tier17:warrior:mB1" },
				{ 305, "Tier18:warrior:n" },
				{ 306, "Tier18:warrior:hB1" },
				{ 307, "Tier18:warrior:mB1" },
				{ 309, "Tier19:warrior:LFRWithDifficulty" },
				{ 310, "Tier19:warrior:NormalWithDifficulty" },
				{ 311, "Tier19:warrior:HeroicWithDifficulty" },
				{ 312, "Tier19:warrior:MythicWithDifficulty" },
				{ 316, "Tier20:warrior:LFRWithDifficulty" },
				{ 317, "Tier20:warrior:NormalWithDifficulty" },
				{ 318, "Tier20:warrior:HeroicWithDifficulty" },
				{ 319, "Tier20:warrior:MythicWithDifficulty" },
				{ 321, "Tier21:warrior:LFRWithDifficulty" },
				{ 322, "Tier21:warrior:NormalWithDifficulty" },
				{ 323, "Tier21:warrior:HeroicWithDifficulty" },
				{ 324, "Tier21:warrior:MythicWithDifficulty" },
				{ 326, "Tier32:warrior:LFRWithDifficulty" },
				{ 327, "Tier32:warrior:NormalWithDifficulty" },
				{ 328, "Tier32:warrior:HeroicWithDifficulty" },
				{ 329, "Tier32:warrior:MythicWithDifficulty" },
				{ 401, "Tier33:warrior:LFRWithDifficulty" },
				{ 402, "Tier33:warrior:NormalWithDifficulty" },
				{ 403, "Tier33:warrior:HeroicWithDifficulty" },
				{ 404, "Tier33:warrior:MythicWithDifficulty" },
				{ 406, "Tier34:warrior:LFRWithDifficulty" },
				{ 407, "Tier34:warrior:NormalWithDifficulty" },
				{ 408, "Tier34:warrior:HeroicWithDifficulty" },
				{ 409, "Tier34:warrior:MythicWithDifficulty" },
			},
		},

	},
}

data["TIMELESSISLE"]       = {
	name = ALIL["Timeless Isle"].." "..AL["Rewards"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{
			name = ALIL["Timeless Isle"].." "..AL["Rewards"],
			[NORMAL_DIFF] = {
				{ 1,   103989, [PRICE_EXTRA_ITTYPE] = "timelesscoin:50000" },                  -- Alacrity of Xuen
				{ 2,   103988, [PRICE_EXTRA_ITTYPE] = "timelesscoin:50000" },                  -- Contemplation of Chi-Ji
				{ 3,   103986, [PRICE_EXTRA_ITTYPE] = "timelesscoin:50000" },                  -- Discipline of Xuen
				{ 4,   103990, [PRICE_EXTRA_ITTYPE] = "timelesscoin:50000" },                  -- Resolve of Niuzao
				{ 5,   103987, [PRICE_EXTRA_ITTYPE] = "timelesscoin:50000" },                  -- Yu'lon's Bite
				{ 6,   103678, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Time-Lost Artifact
				{ 8,   103982, [PRICE_EXTRA_ITTYPE] = "timelesscoin:50000" },                  -- Burden of Eternity
				{ 10,  87774,  [PRICE_EXTRA_ITTYPE] = "timelesscoin:100000" },                 -- Reins of the Heavenly Golden Cloud Serpent
				{ 11,  104295, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Harmonious Porcupette
				{ 12,  104332, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Sky Lantern
				{ 16,  105921, [PRICE_EXTRA_ITTYPE] = "timelesscoin:20000" },                  -- Cloudscorcher Greatstaff
				{ 17,  105923, [PRICE_EXTRA_ITTYPE] = "timelesscoin:20000" },                  -- Contemplation of Shaohao
				{ 18,  105927, [PRICE_EXTRA_ITTYPE] = "timelesscoin:20000" },                  -- Featherdraw Longbow
				{ 19,  105924, [PRICE_EXTRA_ITTYPE] = "timelesscoin:10000" },                  -- Hozen Can Opener
				{ 20,  105926, [PRICE_EXTRA_ITTYPE] = "timelesscoin:10000" },                  -- Ordon Sacrificial Dagger
				{ 21,  105920, [PRICE_EXTRA_ITTYPE] = "timelesscoin:10000" },                  -- Pandaren Peace Offering
				{ 22,  105929, [PRICE_EXTRA_ITTYPE] = "timelesscoin:10000" },                  -- Scavenged Pandaren Dagger
				{ 23,  105925, [PRICE_EXTRA_ITTYPE] = "timelesscoin:20000" },                  -- Yak-Herder's Longstaff
				{ 24,  105919, [PRICE_EXTRA_ITTYPE] = "timelesscoin:10000" },                  -- Daylight Protectorate
				{ 25,  105922, [PRICE_EXTRA_ITTYPE] = "timelesscoin:10000" },                  -- Shield of the Eternal Noon
				{ 27,  104013, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Timeless Cloth Armor Cache
				{ 28,  104012, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Timeless Leather Armor Cache
				{ 29,  104010, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Timeless Mail Armor Cache
				{ 30,  104009, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },                   -- Timeless Plate Armor Cache
				{ 101, 103685, [PRICE_EXTRA_ITTYPE] = "timelesscoin:2500" },                   -- Celestial Defender's Medallion
				{ 102, 101538, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500" },                    -- Kukuru's Cache Key
				{ 103, 103683, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },                    -- Mask of Anger
				{ 104, 103681, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },                    -- Mask of Doubt
				{ 105, 103679, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },                    -- Mask of Fear
				{ 106, 103680, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },                    -- Mask of Hatred
				{ 107, 103682, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },                    -- Mask of Violence
				{ 108, 103684, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500" },                    -- Scroll of Challenge
				{ 109, 103786, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500",   [ATLASLOOT_IT_AMOUNT1] = 5 }, -- "Dapper Gentleman" Costume
				{ 110, 103795, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500",   [ATLASLOOT_IT_AMOUNT1] = 5 }, -- "Dread Pirate" Costume
				{ 111, 103789, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500",   [ATLASLOOT_IT_AMOUNT1] = 5 }, -- "Little Princess" Costume
				{ 112, 103797, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500",   [ATLASLOOT_IT_AMOUNT1] = 5 }, -- Big Pink Bow
				{ 113, 71153,  [PRICE_EXTRA_ITTYPE] = "timelesscoin:500",   [ATLASLOOT_IT_AMOUNT1] = 25 }, -- Magical Pet Biscuit
				{ 114, 103977, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500" },                    -- Time-Worn Journal
				{ 116, 102467, [PRICE_EXTRA_ITTYPE] = "timelesscoin:2500" },                   -- Censer of Eternal Agony
				{ 118, 103638, [PRICE_EXTRA_ITTYPE] = "bloodycoin:500" },                      -- Reins of the Ashhide Mushan Beast
				{ 119, 103639, [PRICE_EXTRA_ITTYPE] = "bloodycoin:20" },                       -- Pouch of White Ash
				{ 120, 103637, [PRICE_EXTRA_ITTYPE] = "bloodycoin:100" },                      -- Vengeful Porcupette
				{ 121, 102463, [PRICE_EXTRA_ITTYPE] = "bloodycoin:50" },                       -- Fire-Watcher's Oath
				{ 122, 102464, [PRICE_EXTRA_ITTYPE] = "bloodycoin:1" },                        -- Black Ash
				{ 124, 102145, [PRICE_EXTRA_ITTYPE] = "101529:3" },                            -- Chi-Chi, Hatchling of Chi-Ji
				{ 125, 101771, [PRICE_EXTRA_ITTYPE] = "101529:3" },                            -- Xu-Fu, Cub of Xuen
				{ 126, 102147, [PRICE_EXTRA_ITTYPE] = "101529:3" },                            -- Yu'la, Broodling of Yu'lon
				{ 127, 102146, [PRICE_EXTRA_ITTYPE] = "101529:3" },                            -- Zao, Calfling of Niuzao
				{ 128, 98715,  [PRICE_EXTRA_ITTYPE] = "101529:3" },                            -- Marked Flawless Battle-Stone
				{ 129, 86143,  [PRICE_EXTRA_ITTYPE] = "101529:1",           [ATLASLOOT_IT_AMOUNT1] = 25 }, -- Battle Pet Bandage
				{ 130, 98114,  [PRICE_EXTRA_ITTYPE] = "101529:1" },                            -- Pet Treat
			},
		},
	},
}

data["COMPANIONS"]         = {
	name = COMPANIONS,
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ -- The War Within
			name = EXPANSION_NAME10,
			-- CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1,   232843, "pet4642" },                                               -- Gorillion
				{ 2,   232838, "pet4639" },                                               -- Viridian Mechasaur
				{ 3,   238796, "pet4791" },                                               -- Thrrrdgl
				{ 4,   232852, "pet4636" },                                               -- Mutt
				{ 5,   236768, "pet4759" },                                               -- Craboom
				{ 6,   232847, "pet4646" },                                               -- Personal-Use Sapper
				{ 7,   232848, "pet4647" },                                               -- Mr. DELVER
				{ 8,   223155, "pet4469" },                                               -- Bop
				{ 9,   224766, "pet4596" },                                               -- Faithful Dog
				{ 10,  232858, "pet4655", [PRICE_EXTRA_ITTYPE] = "vintageKajaCola:1" },   -- Cruncher
				{ 11,  232859, "pet4653", [PRICE_EXTRA_ITTYPE] = "vintageKajaCola:3" },   -- Lab Rat
				{ 12,  238261, "pet4762" },                                               -- Tock the Clocker Spaniel
				{ 13,  233056, "pet4708", [QUEST_EXTRA_ITTYPE] = 86261 },                 -- Marmaduke
				{ 14,  232839, "pet4637", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Wavebreaker Mechasaur
				{ 15,  232840, "pet4661", [PRICE_EXTRA_ITTYPE] = "234741:5" },            -- Mechagopher
				{ 16,  232842, "pet4638", [PRICE_EXTRA_ITTYPE] = "234741:10" },           -- Crimson Mechasaur
				{ 17,  232853, "pet4632", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Eepy
				{ 18,  221496, "pet4496" },                                               -- Wriggle
				{ 19,  221850, "pet4464", [PRICE_EXTRA_ITTYPE] = "kej:2250" },            -- Freshly Webbed Kebab / Bean
				{ 20,  234379, "pet4726" },                                               -- Crackleroar
				{ 21,  221546, "pet4534" },                                               -- Nightfarm Growthling
				{ 22,  223624, "pet4575" },                                               -- Sneef
				{ 23,  232851, "pet4641", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Rocketfist
				{ 24,  225337, "pet4506" },                                               -- Violet Sporbit
				{ 25,  232845, "pet4645", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Bilgewater Junkhauler
				{ 26,  232844, "pet4640" },                                               -- Fuz-Size Flarendo
				{ 27,  221819, "pet4472" },                                               -- Shadowbog Hopper
				{ 28,  222971, "pet4489" },                                               -- Bouncer
				{ 29,  232841, "pet4644", [PRICE_EXTRA_ITTYPE] = "234741:8" },            -- Professor Punch
				{ 30,  232849, "pet4650", [PRICE_EXTRA_ITTYPE] = "234741:5" },            -- Venture Companyman
				{ 101, 220782, "pet4462", [QUEST_EXTRA_ITTYPE] = 82007 },                 -- Thunder
				{ 102, 232895, "pet4701", [QUEST_EXTRA_ITTYPE] = 85711 },                 -- Spotty
				{ 103, 222974, "pet4543", [PRICE_EXTRA_ITTYPE] = "undercoin:10000" },     -- Sir Shady Mrrgglton Junior
				{ 104, 220771, "pet4467" },                                               -- Hallowed Glowfly
				{ 105, 229366, "pet4629" },                                               -- Brrrgl
				{ 106, 224646, "pet4598", [PRICE_EXTRA_ITTYPE] = "224642:1" },            -- Coppers the Kobold
				{ 107, 232850, "pet4649", [PRICE_EXTRA_ITTYPE] = "234741:5" },            -- Blackwater Kegmover
				{ 108, 221486, "pet4455", [PRICE_EXTRA_ITTYPE] = "kej:2250" },            -- Rak-Ush Threadling
				{ 109, 232806, "pet4643" },                                               -- Tiny Torq
				{ 110, 231294, "pet4682" },                                               -- Reven
				{ 111, 232846, "pet4648", [PRICE_EXTRA_ITTYPE] = "234741:5" },            -- Steamwheedle Flunkie
				{ 112, 225544, "pet4599" },                                               -- Mind Slurp
				{ 113, 222972, "pet4491", [PRICE_EXTRA_ITTYPE] = "kej:2250" },            -- Jump Jump
				{ 114, 224549, "pet4594" },                                               -- Sewer Turtle Whistle
				{ 115, 222968, "pet4476", [PRICE_EXTRA_ITTYPE] = "kej:2250" },            -- Itchbite
				{ 116, 221821, "pet4517", [ACH_EXTRA_ITTYPE] = 40194 },                   -- Waxwick
				{ 117, 232855, "pet4631", [ACH_EXTRA_ITTYPE] = 41551 },                   -- Foreman
				{ 118, 222970, "pet4490", [ACH_EXTRA_ITTYPE] = 40980 },                   -- Fuzzy
				{ 119, 223487, "pet4482" },                                               -- Writhing Transmutagen
				{ 120, 229368, "pet4630" },                                               -- Gill'el
				{ 121, 222973, "pet4492", [PRICE_EXTRA_ITTYPE] = "kej:2250" },            -- Fringe
				{ 122, 221820, "pet4537" },                                               -- Chester
				{ 123, 228765, "pet4616" },                                               -- Gummi
				{ 124, 232807, "pet4664", [ACH_EXTRA_ITTYPE] = 41349 },                   -- Iron Chick
				{ 125, 232519, "pet4690" },                                               -- Razeshi B.
				{ 126, 224439, "pet4470" },                                               -- Oop'lajax
				{ 127, 224450, "pet4527" },                                               -- Lil' Moss Rosy
				{ 128, 228790, "pet4617" },                                               -- Thrillbot 9000
				{ 129, 228793, "pet4618" },                                               -- Chillbot 9000
				{ 130, 222980, "pet4542", [ACH_EXTRA_ITTYPE] = 41200 },                   -- Slim
				{ 201, 224259, "pet4590" },                                               -- Flash
				{ 202, 221849, "pet4465", [QUEST_EXTRA_ITTYPE] = 79110 },                 -- Vanilla
				{ 203, 222966, "pet4473" },                                               -- Spinner
				{ 204, 231310, "pet4684" },                                               -- Timbered Sky Snakelet
				{ 205, 221760, "pet4513" },                                               -- Pillarnest Bonedrinker
				{ 206, 221848, "pet4463", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Tiberius
				{ 207, 224101, "pet4586", [PRICE_EXTRA_ITTYPE] = "PetCharm:50" },         -- Brown Leafbug
				{ 208, 224261, "pet4589" },                                               -- Gale
				{ 209, 232531, "pet4691" },                                               -- Grunch
				{ 210, 221494, "pet4495", [PRICE_EXTRA_ITTYPE] = "PetCharm:50" },         -- Skippy
				{ 211, 221761, "pet4511", [PRICE_EXTRA_ITTYPE] = "PetCharm:50" },         -- Venomwing
				{ 212, 224260, "pet4591" },                                               -- Thundo
				{ 213, 222964, "pet4520", [QUEST_EXTRA_ITTYPE] = 80316 },                 -- Fathom Incher
				{ 214, 223623, "pet4576", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Guacamole
				{ 215, 223625, "pet4570", [QUEST_EXTRA_ITTYPE] = 79683 },                 -- Cinderwold Sizzlestinger
				{ 216, 228740, "pet4614" },                                               -- Gizmo the Pure
				{ 217, 235358, "pet4733" },                                               -- Merriment
				{ 218, 224579, "pet3362" },                                               -- Sapphire Crab
				{ 219, 221548, "pet4536" },                                               -- Blightbud
				{ 220, 224760, "pet4597", [PRICE_EXTRA_ITTYPE] = "224642:1" },            -- Wobbles
				{ 221, 231365, "pet4689", [PRICE_EXTRA_ITTYPE] = "timewarped:2200" },     -- Karazhan Syphoner
				{ 222, 232923, "pet4704", [PRICE_EXTRA_ITTYPE] = "lovetoken:40" },        -- Living Rose
				{ 223, 233366, "pet4719", [PRICE_EXTRA_ITTYPE] = "tender:300" },          -- Wind-Up Woofer
				{ 224, 224410, "pet4593", [PRICE_EXTRA_ITTYPE] = "timewarped:2200" },     -- Craggles
				{ 225, 234395, "pet4727", [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:750" }, -- Skitterbite
				{ 226, 222965, "pet4530", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Loamy
				{ 227, 223802, "pet4581", [ACH_EXTRA_ITTYPE] = 40088 },                   -- Ruby-Eyed Stagshell
				{ 228, 234396, "pet4728", [PRICE_EXTRA_ITTYPE] = "tender:350" },          -- Teatuft Tamer
				{ 229, 234397, "pet4729", [PRICE_EXTRA_ITTYPE] = "tender:350" },          -- Fullbelly Rollingpaw
				{ 230, 228758, "pet4615" },                                               -- Parrlok
				{ 301, 230011, "pet4679" },                                               -- Lil'Kaz's Hilt
				{ 302, 233247, "pet4692" },                                               -- Sparklesnap
				{ 303, 233361, "pet4718", [PRICE_EXTRA_ITTYPE] = "tender:300" },          -- Wind-Up Wuffi
				{ 304, 218086, "pet4450", [PRICE_EXTRA_ITTYPE] = "residualMemories:10000" }, -- Remembered Riverpaw
				{ 305, 222978, "pet4546", [PRICE_EXTRA_ITTYPE] = "PetCharm:50" },         -- Sandstone Ramolith
				{ 306, 225935, "pet4582", [QUEST_EXTRA_ITTYPE] = 79123 },                 -- Rak-Ush Battleshell
				{ 307, 228781, "pet4678" },                                               -- Lil'Doomy's Hilt
				{ 308, 224406, "pet4592", [PRICE_EXTRA_ITTYPE] = "timewarped:2200" },     -- Misty
				{ 309, 233251, "pet4426" },                                               -- Bubbles
				{ 310, 218245, "pet4451", [PRICE_EXTRA_ITTYPE] = "residualMemories:10000" }, -- Remembered Construct
				{ 311, 232653, "pet4694" },                                               -- Portentous Present
				{ 312, 218246, "pet4452", [PRICE_EXTRA_ITTYPE] = "residualMemories:10000" }, -- Remembered Spawn
				{ 313, 221811, "pet4524", [PRICE_EXTRA_ITTYPE] = "PetCharm:50" },         -- Starkstripe Hopper
				{ 314, 235989, "pet4695" },                                               -- Parley
				{ 315, 231356, "pet4686", [PRICE_EXTRA_ITTYPE] = "timewarped:2200" },     -- Specter
				{ 316, 225934, "pet4500", [ACH_EXTRA_ITTYPE] = 40869 },                   -- Lil' Bonechewer
				{ 317, 226104, "pet4602", [PRICE_EXTRA_ITTYPE] = "tender:330" },          -- Claudius
				{ 318, 229993, "pet4669", [PRICE_EXTRA_ITTYPE] = "tender:400" },          -- Bluedoo
				{ 319, 233252, "pet4435" },                                               -- Happy
				{ 320, 233248, "pet4425" },                                               -- Glamrok
				{ 321, 238986, "pet4794", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Mister Mans
				{ 322, 241188, "pet4804", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:6500" }, -- Swiftpaw
				{ 323, 221851, "pet4466" },                                               -- Argos
				{ 324, 232857, "pet4635" },                                               -- Goggles
				{ 325, 241193, "pet3245" },                                               -- Helpful Workshop Bot
				{ 326, 236409, "pet4757", [PRICE_EXTRA_ITTYPE] = "tender:350" },          -- Frumpy Softpaw
				{ 327, 34492,  "pet168",  [PRICE_EXTRA_ITTYPE] = "tender:200" },          -- Rocket Chicken
				{ 328, 238942, "pet4793" },                                               -- Weechi
				{ 329, 235980, "pet4756", [PRICE_EXTRA_ITTYPE] = "displacedCorruptedMementos:5000" }, -- Scourge of the Aspects
				{ 330, 235794, "pet4747" },                                               -- Eye of Chaos
				{ 401, 235793, "pet4748" },                                               -- Parrot Cage (Void-Scarred Parrot)
				{ 402, 235795, "pet4749" },                                               -- Void-Scarred Scorpid
				{ 403, 235797, "pet4750" },                                               -- Void-Scarred Egg
				{ 404, 174461, "pet2842" },                                               -- Swirling Black Bottle (Anomalus)
				{ 405, 174457, "pet2838" },                                               -- C'Thuffer
				{ 406, 174463, "pet2844", [ACH_EXTRA_ITTYPE] = 41928 },                   -- Reek
				{ 407, 174459, "pet2840" },                                               -- Voidwoven Cat Collar (Void-Scarred Cat)
				{ 408, 174458, "pet2839" },                                               -- Void-Scarred Hare
				{ 409, 174646, "pet2797" },                                               -- Void-Link Frostwolf Collar (Void-Scarred Pup)
				{ 410, 174460, "pet2841" },                                               -- Box Labeled "Danger: Void Rat Inside" (Void-Scarred Rat)
				{ 411, 173726, "pet2796" },                                               -- Box With Faintly Glowing 'Air' Holes (Void-Scarred Toad)
				{ 412, 239019, "pet4806", [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:100" }, -- Mean-Ball Ball Bag
				{ 413, 245543, "pet4849", [PRICE_EXTRA_ITTYPE] = "timewarped:2200" },     -- Flotsam Harvester
				{ 414, 245574, "pet4852", [PRICE_EXTRA_ITTYPE] = "timewarped:2200" },     -- Lil' Daz'ti
				{ 415, 205013, "pet3518", [ACH_EXTRA_ITTYPE] = 41092 },                   -- Reek
				{ 416, 239082, "pet4796" },                                               -- Sa'bak's Blessed
				{ 417, 246451, "pet4858" },                                               -- Shadefur Brewthief
				{ 418, 245272, "pet4846" },                                               -- Heka'Tarnos, Bringer of Discord
				{ 419, 245254, "pet4842" },                                               -- Duskthief
				{ 420, 245214, "pet4838" },                                               -- Palek'ti, the Mouth of Nothingness
				{ 421, 244915, "pet4834" },                                               -- Jimmy
				{ 422, 245269, "pet4845" },                                               -- Mr. Long-Legs
				{ 423, 243158, "pet4813" },                                               -- Ixthal the Observling
				{ 424, 245256, "pet4843" },                                               -- Sao'rhon
				{ 425, 246723, "pet4860" },                                               -- Unfazed Diver
				{ 426, 245255, "pet4841", [ACH_EXTRA_ITTYPE] = 41979 },                   -- Starlight
				{ 427, 244910, "pet4829", [PRICE_EXTRA_ITTYPE] = "untetheredCoin:4" },    -- Penumbral Terror
				{ 428, 244467, "pet4825" },                                               -- Veridian Thorntail
				{ 429, 245274, "pet4848" },                                               -- Cerulean Lapbug
				{ 430, 245273, "pet4847" },                                               -- Copper Lapbug
				{ 501, 244907, "pet4827" },                                               -- Dread Horrorling
				{ 502, 244909, "pet4828" },                                               -- Impartial Watcher
				{ 503, 244916, "pet4835" },                                               -- Cyan Siphonmite
				{ 504, 244468, "pet4826" },                                               -- Scrappy Thorntail
				{ 505, 245252, "pet4840" },                                               -- Graceful Cosmic Ray Pup
				{ 506, 245215, "pet4839" },                                               -- Shimmering Inchshifter
				{ 507, 245212, "pet4836" },                                               -- Vitriolic Inchshifter
				{ 508, 245253, "pet4844" },                                               -- Inquisitive Cosmic Ray Pup
				{ 509, 244914, "pet4833" },                                               -- Xanthous Siphonmite
				{ 510, 205148, "pet3542", [PRICE_EXTRA_ITTYPE] = "tender:200" },          -- Soot-Stained Shalewing
				{ 511, 246337, "pet4853", [PRICE_EXTRA_ITTYPE] = "tender:250" },          -- Rustyroot Fel Snooter
				-- { 311, 233057, "pet4709" }, -- Rock Hound Mica
				-- { 312, 221764, "pet4519" }, -- Burntram
				-- { 317, 222969, "pet4474" }, -- Anub'Rekyute
				-- { 322, 221759, "pet4512" }, -- Sceaduthax
				-- { 325, 222979, "pet4545" }, -- Clay Stonecharger
				-- { 327, 221195, "pet4458" }, -- Illskitter
				-- { 324, 234905, "pet4730" }, -- Mech-Friend Maya
				-- { 324, 221492, "pet4459" }, -- Moss Skipper
				-- { 325, 221493, "pet4493" }, -- Admiral
				-- { 326, 221495, "pet4497" }, -- Waddles
				-- { 327, 222967, "pet4475" }, -- Webbers
				-- { 114, 232856, "pet4633" }, -- Scruff
				-- { 203, 232854, "pet4634" }, -- Grinner
			}
		},
		{ -- Dragonflight
			name = EXPANSION_NAME9,
			-- CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1,   190583, "pet3248" },                                        -- Ichabod
				{ 2,   191126, "pet3256" },                                        -- Obsidian Whelpling
				{ 3,   191886, "pet3274" },                                        -- Alvin the Anvil
				{ 4,   191915, "pet3259" },                                        -- Shaggy
				{ 5,   191930, "pet3261" },                                        -- Wakyn
				{ 6,   191932, "pet3262" },                                        -- Violet Violence
				{ 7,   191936, "pet3263" },                                        -- Secretive Frogduck
				{ 8,   191941, "pet3264" },                                        -- Crystalline Mini-Monster
				{ 9,   191946, "pet3265" },                                        -- Mister Muskoxeles
				{ 10,  192459, "pet3270" },                                        -- Jean's Lucky Fish
				{ 11,  193066, "pet3275" },                                        -- Chestnut
				{ 12,  193071, "pet3278" },                                        -- Pistachio
				{ 13,  193225, "pet3284" },                                        -- Whiskuk
				{ 14,  193235, "pet3285" },                                        -- Luvvy
				{ 15,  193363, "pet3290" },                                        -- Bunbo
				{ 16,  193364, "pet3291" },                                        -- Scruffles
				{ 17,  193373, "pet3292" },                                        -- Phoenix Wishwing
				{ 18,  193374, "pet3293" },                                        -- Ashenwing
				{ 19,  193377, "pet3294" },                                        -- Gerald
				{ 20,  193429, "pet3297" },                                        -- Time-Lost Salamanther
				{ 21,  193484, "pet3302" },                                        -- Pilot
				{ 22,  193571, "pet3303" },                                        -- Mallard Duckling
				{ 23,  193572, "pet3306" },                                        -- Quack-E
				{ 24,  193618, "pet3317" },                                        -- Hoofhelper
				{ 25,  193619, "pet3319" },                                        -- Yipper
				{ 26,  193834, "pet3321" },                                        -- Blackfeather Nester
				{ 27,  193835, "pet3323" },                                        -- Brightfeather
				{ 28,  193837, "pet3326" },                                        -- Backswimmer Timbertooth
				{ 29,  193850, "pet3330" },                                        -- Buckie
				{ 30,  193851, "pet3332" },                                        -- Patos
				{ 101, 193852, "pet3269" },                                        -- Azure Frillfish
				{ 102, 193853, "pet3331" },                                        -- Emmah
				{ 103, 193854, "pet3333" },                                        -- Berylmane
				{ 104, 193855, "pet3334" },                                        -- Time-Lost Vorquin Foal
				{ 105, 193885, "pet3345" },                                        -- Jeweled Amber Whelpling
				{ 106, 193886, "pet3344" },                                        -- Jeweled Sapphire Whelpling
				{ 107, 193887, "pet3346" },                                        -- Jeweled Ruby Whelpling
				{ 108, 193888, "pet3347" },                                        -- Jeweled Emerald Whelpling
				{ 109, 193889, "pet3256" },                                        -- Jeweled Onyx Whelpling
				{ 110, 193908, "pet3338" },                                        -- Koboldt
				{ 111, 194098, "pet3350" },                                        -- Lord Basilton
				{ 112, 198353, "pet3368" },                                        -- Shiverweb Egg
				{ 113, 198622, "pet3342" },                                        -- Spyragos
				{ 114, 198725, "pet3381" },                                        -- Gray Marmoni
				{ 115, 198726, "pet3380" },                                        -- Black Skitterbug
				{ 116, 199109, "pet3348" },                                        -- Primal Stormling
				{ 117, 199172, "pet3309" },                                        -- Viridescent Duck
				{ 118, 199175, "pet3316" },                                        -- Lubbins
				{ 119, 199326, "pet3376" },                                        -- Chip
				{ 120, 199688, "pet3279" },                                        -- Bronze Racing Enthusiast
				{ 121, 199757, "pet3378" },                                        -- Magic Nibbler
				{ 122, 199758, "pet3379" },                                        -- Crimson Proto-Whelp
				{ 123, 199916, "pet3365" },                                        -- Roseate Hopper
				{ 124, 200114, "pet3382" },                                        -- Stormie
				{ 125, 200173, "pet3287" },                                        -- Ghostflame
				{ 126, 200183, "pet3355" },                                        -- Echo of the Cave
				{ 127, 200255, "pet3289" },                                        -- Echo of the Inferno
				{ 128, 200260, "pet3299" },                                        -- Echo of the Depths
				{ 129, 200263, "pet3310" },                                        -- Echo of the Heights
				{ 130, 200276, "pet3311" },                                        -- Ohuna Companion
				{ 201, 200290, "pet3325" },                                        -- Bakar Companion
				{ 202, 200479, "pet3390" },                                        -- Sophic Amalgamation
				{ 203, 200519, "pet3286" },                                        -- Mister Toots
				{ 204, 200872, "pet3405" },                                        -- Living Mud Mask
				{ 205, 200874, "pet3406" },                                        -- Lady Feathersworth
				{ 206, 200927, "pet3408" },                                        -- Petal
				{ 207, 200930, "pet3414" },                                        -- Obsidian Proto-Whelp
				{ 208, 201260, "pet3410" },                                        -- Dust Spirit
				{ 209, 201261, "pet3411" },                                        -- Blaze Spirit
				{ 210, 201262, "pet3412" },                                        -- Gale Spirit
				{ 211, 201265, "pet3409" },                                        -- Tide Spirit
				{ 212, 201441, "pet3407" },                                        -- Scout
				{ 213, 201463, "pet3415" },                                        -- Cubbly
				{ 214, 201703, "pet3417" },                                        -- Pinkie
				{ 215, 201707, "pet3416" },                                        -- Troubled Tome
				{ 216, 201838, "pet3359" },                                        -- Snowclaw Cub
				{ 217, 202085, "pet3360" },                                        -- Bugbiter Tortoise
				{ 218, 212786, "pet4409", [PRICE_EXTRA_ITTYPE] = "noblegardenchocolate:250" }, -- Lovely Duckling
				{ 219, 223145, "pet4548", [PRICE_EXTRA_ITTYPE] = "tender:500" },   -- Marrlok
				{ 220, 206174, "pet3582", [PRICE_EXTRA_ITTYPE] = "tender:500" },   -- Blub
				{ 221, 223474, "pet4566", [PRICE_EXTRA_ITTYPE] = "tender:300" },   -- Worgli the Apprehensive
				{ 222, 211271, "pet3491" },                                        -- Arfus
				-- { 12,  193068 }, -- Time-Lost Treeflitter
				-- { 21,  193380 }, -- Pink Salamanther
				-- { 26,  193587 }, -- Time-Lost Duck
				-- { 27,  193614 }, -- Groundshaker
				-- { 30,  193620 }, -- Time-Lost Slyvern
			}
		},
	},
}

data["TOYS"]               = {
	name = TOY,
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ -- The War Within
			name = EXPANSION_NAME10,
			-- CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1,   236687 },                                     -- Explosive Hearthstone
				{ 2,   226373, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Everlasting Noggenfogger Elixir
				{ 3,   237382, [PRICE_EXTRA_ITTYPE] = "emptyKajaCola:999" }, -- Undermine Supply Crate
				{ 4,   226810 },                                     -- Infiltrator's Shroud
				{ 5,   235041, [QUEST_EXTRA_ITTYPE] = 85657 },       -- Cyrce's Circlet
				{ 6,   237345, [PRICE_EXTRA_ITTYPE] = "227673:5" },  -- Limited Edition Rocket Bobber
				{ 7,   231064, [PRICE_EXTRA_ITTYPE] = "undercoin:2500" }, -- Throwaway Gangster Disguise
				{ 8,   230850, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:10" }, -- Delve-O-Bot 7001
				{ 9,   237347, [PRICE_EXTRA_ITTYPE] = "227673:5" },  -- Organically-Sourced Wellington Bobber
				{ 10,  234950, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Atomic Regoblinator
				{ 11,  230727, [QUEST_EXTRA_ITTYPE] = 85244 },       -- Explosive Victory
				{ 12,  235050, [ACH_EXTRA_ITTYPE] = 41588 },         -- Desk-in-a-Box
				{ 13,  225659 },                                     -- Arathi Book Collection
				{ 14,  221966 },                                     -- Wormhole Generator: Khaz Algar
				{ 15,  235801, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Personal Fishing Barge
				{ 16,  237346, [PRICE_EXTRA_ITTYPE] = "227673:5" },  -- Artisan Beverage Goblet Bobber
				{ 17,  225641 },                                     -- Illusive Kobyss Lure
				{ 18,  230924 },                                     -- Spotlight Materializer 1000
				{ 19,  235807, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Storefront-in-a-Box
				{ 20,  233202, [QUEST_EXTRA_ITTYPE] = 84675 },       -- G.O.L.E.M, Jr.
				{ 21,  228940, [PRICE_EXTRA_ITTYPE] = "kej:3000" },  -- Notorious Thread's Hearthstone
				{ 22,  235220 },                                     -- Fireworks Hat
				{ 23,  236769, [ACH_EXTRA_ITTYPE] = 41211 },         -- Gallagio Pipeline Rerouter
				{ 24,  234951 },                                     -- Uncracked Cold Ones
				{ 25,  235017 },                                     -- Glittering Vault Shard
				{ 26,  211931 },                                     -- Abyss Caller Horn
				{ 27,  224251, [ACH_EXTRA_ITTYPE] = 40314 },         -- Memory Chord
				{ 28,  235519 },                                     -- Prized Legend's Pennant
				{ 29,  228698, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Candleflexer's Dumbbell
				{ 30,  233486, [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:750" }, -- Hallowfall Supply Cache
				{ 101, 225910 },                                     -- Pileus Delight
				{ 102, 219387 },                                     -- Barrel of Fireworks
				{ 103, 236751 },                                     -- Take-Home Flarendo
				{ 104, 228705, [PRICE_EXTRA_ITTYPE] = "kej:1750" },  -- Arachnoserum
				{ 105, 235015, [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:750" }, -- Awakened Supply Crate
				{ 106, 228914, [PRICE_EXTRA_ITTYPE] = "kej:1500" },  -- Arachnophile Spectacles
				{ 107, 236749 },                                     -- Take-Home Torq
				{ 108, 228789 },                                     -- Coldflame Ring
				{ 109, 221962 },                                     -- Defective Escape Pod
				{ 110, 219403 },                                     -- Stonebound Lantern
				{ 111, 215145 },                                     -- Remembrance Stone
				{ 112, 228707, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Trial of Burning Light
				{ 113, 221964 },                                     -- Filmless Camera
				{ 114, 225347 },                                     -- Web-Vandal's Spinning Wheel
				{ 115, 228966 },                                     -- Starry-Eyed Goggles
				{ 116, 224585 },                                     -- Hanna's Locket
				{ 117, 226191, [PRICE_EXTRA_ITTYPE] = "money:7500" }, -- Web Pet Leash
				{ 118, 225556 },                                     -- Ancient Construct
				{ 119, 227539, [ACH_EXTRA_ITTYPE] = 40795 },         -- Unbound Strategist's Pennant
				{ 120, 228413 },                                     -- Lampyridae Lure
				{ 121, 224783 },                                     -- Sovereign's Finery Chest
				{ 122, 225547, [QUEST_EXTRA_ITTYPE] = 83500 },       -- Toxic Victory
				{ 123, 225933 },                                     -- Forged Legend's Pennant
				{ 124, 235288 },                                     -- Sha-Warped Tea Set
				{ 125, 234473, [PRICE_EXTRA_ITTYPE] = "flameBlessedIron:750" }, -- Soweezi's Comfy Lawn Chair
				{ 126, 223312, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:10" }, -- Trusty Hat
				{ 127, 235670, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Bilgewater Cartel Banner
				{ 128, 235671, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Blackwater Cartel Banner
				{ 129, 235669, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Steamwheedle Cartel Banner
				{ 130, 235672, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Venture Co. Banner
				{ 201, 235799, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Throwin' Sawblade
				{ 202, 215147 },                                     -- Beautification Iris
				{ 203, 225969, [ACH_EXTRA_ITTYPE] = 40096 },         -- Forged Flag of Victory
				{ 204, 224552 },                                     -- Cave Spelunker's Torch
				{ 205, 218308 },                                     -- Winter Veil Cracker
				{ 206, 227538, [ACH_EXTRA_ITTYPE] = 40792 },         -- Unbound Legend's Pennant
				{ 207, 228706, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Rockslidomancer's Stone
				{ 208, 224192, [PRICE_EXTRA_ITTYPE] = "timewarped:200" }, -- Practice Ravager
				{ 209, 224643, [PRICE_EXTRA_ITTYPE] = "224642:1" },  -- Pet-Sized Candle
				{ 210, 224554 },                                     -- Silver Linin' Scepter
				{ 211, 226519, [PRICE_EXTRA_ITTYPE] = "kej:1100" },  -- General's Expertise
				{ 212, 232301 },                                     -- Tempered Banner of the Algari
				{ 213, 232305 },                                     -- Forged Champion's Prestigious Banner
				{ 214, 229828 },                                     -- 20th Anniversary Balloon Chest
				{ 215, 218310 },                                     -- Box of Puntables
				{ 216, 238850, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Arathi Entertainer's Flame
				{ 217, 238852, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Flame's Radiance Banner
				{ 218, 239693, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:5000" }, -- Radiant Lynx Whistle
				{ 219, 174920 },                                     -- Coifcurl's Close Shave Kit
				{ 220, 174926 },                                     -- Overly Sensitive Void Spectacles
				{ 221, 174928 },                                     -- Rotten Apple
				{ 222, 174921 },                                     -- Void-Touched Skull
				{ 223, 174924 },                                     -- Void-Touched Souvenir Totem
				{ 224, 239007 },                                     -- Dastardly Banner
				{ 225, 239018, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:100" }, -- Winner's Podium
				{ 226, 244888 },                                     -- Echo of the Xal'atath, Blade of the Black Empire
				{ 227, 245567 },                                     -- K'aresh Memory Crystal
				{ 228, 245631 },                                     -- Royal Visage
				{ 229, 245942, [PRICE_EXTRA_ITTYPE] = "timewarped:1000" }, -- Sea-Blessed Shrine
				{ 230, 246227, [PRICE_EXTRA_ITTYPE] = "timewarped:1000" }, -- Lightning-Blessed Spire
				{ 301, 235016, [ACH_EXTRA_ITTYPE] = 42241 },         -- Redeployment Module
				{ 302, 244470, [QUEST_EXTRA_ITTYPE] = 91089 },       -- Etheric Victory
				{ 303, 246903, [PRICE_EXTRA_ITTYPE] = "untetheredCoin:3" }, -- Guise of the Phase Diver
				{ 304, 246905, [PRICE_EXTRA_ITTYPE] = "untetheredCoin:3" }, -- Overtuned K'areshi Goggles
				{ 305, 246907, [PRICE_EXTRA_ITTYPE] = "untetheredCoin:3" }, -- Broker Supply Crate
				{ 306, 246908, [PRICE_EXTRA_ITTYPE] = "untetheredCoin:3" }, -- K'areshi Supply Crate
				{ 307, 250722, [PRICE_EXTRA_ITTYPE] = "untetheredCoin:3" }, -- Ethereal Stall
				{ 308, 246565 },                                     -- Cosmic Hearthstone
				{ 309, 245970 },                                     -- P.O.S.T. Master's Express Hearthstone
				{ 310, 242323 },                                     -- Chowdar's Favorite Ribbon
				{ 311, 244792, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:10" }, -- Etheric Brannmorpher
				{ 312, 243056, [PRICE_EXTRA_ITTYPE] = "resonanceCrystal:10" }, -- Delver's Mana-Bound Ethergate
				{ 313, 245946, [PRICE_EXTRA_ITTYPE] = "brewfest:200" }, -- Brewer's Balloon
				-- { 310, 249713 },                                     -- Cartel Transmorpher (currently unobtainable)
			}
		},
		{ -- Dragonflight
			name = EXPANSION_NAME9,
			-- CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1,   191891 },                                        -- Professor Chirpsnide's Im-PECK-able Harpy Disguise
				{ 2,   192443 },                                        -- Element-Infused Rocket Helmet
				{ 3,   192495 },                                        -- Malfunctioning Stealthman 54
				{ 4,   193032 },                                        -- Jeweled Offering
				{ 5,   193033 },                                        -- Convergent Prism
				{ 6,   193476 },                                        -- Gnoll Tent
				{ 7,   193478 },                                        -- Tuskarr Beanbag
				{ 8,   194052 },                                        -- Forlorn Funeral Pall
				{ 9,   194056 },                                        -- Duck-Stuffed Duck Lovie
				{ 10,  194057 },                                        -- Cushion of Time Travel
				{ 11,  194058 },                                        -- Cold Cushion
				{ 12,  194059 },                                        -- Market Tent
				{ 13,  194060 },                                        -- Dragonscale Expedition's Expedition Tent
				{ 14,  194885 },                                        -- Ohuna Perch
				{ 15,  197719 },                                        -- Artisan's Sign
				{ 16,  197961 },                                        -- Whelps on Strings
				{ 17,  197986 },                                        -- Murglasses
				{ 18,  198039 },                                        -- Rock of Appreciation
				{ 19,  198090 },                                        -- Jar of Excess Slime
				{ 20,  198156 },                                        -- Wyrmhole Generator
				{ 21,  198173 },                                        -- Atomic Recalibrator
				{ 22,  198206 },                                        -- Environmental Emulator
				{ 23,  198227 },                                        -- Giggle Goggles
				{ 24,  198264 },                                        -- Centralized Precipitation Emitter
				{ 25,  198402 },                                        -- Maruuk Cooking Pot
				{ 26,  198409 },                                        -- Personal Shell
				{ 27,  198428 },                                        -- Tuskarr Dinghy
				{ 28,  198474 },                                        -- Artist's Easel
				{ 29,  198537 },                                        -- Taivan's Trumpet
				{ 30,  198646 },                                        -- Ornate Dragon Statue
				{ 101, 198720 },                                        -- Soft Purple Pillow
				{ 102, 198721 },                                        -- Skinny Reliquary Pillow
				{ 103, 198722 },                                        -- Small Triangular Pillow
				{ 104, 198728 },                                        -- Explorer's League Banner
				{ 105, 198729 },                                        -- Reliquary Banner
				{ 106, 198827 },                                        -- Magical Snow Sled
				{ 107, 198857 },                                        -- Lucky Duck
				{ 108, 199337 },                                        -- Bag of Furious Winds
				{ 109, 199554 },                                        -- S.E.A.T.
				{ 110, 199649 },                                        -- Dragon Tea Set
				{ 111, 199650 },                                        -- Whale Bone Tea Set
				{ 112, 199767 },                                        -- Red Dragon Banner
				{ 113, 199768 },                                        -- Black Dragon Banner
				{ 114, 199769 },                                        -- Blue Dragon Banner
				{ 115, 199770 },                                        -- Bronze Dragon Banner
				{ 116, 199771 },                                        -- Green Dragon Banner
				{ 117, 199892 },                                        -- Tuskarr Traveling Soup Pot
				{ 118, 199894 },                                        -- Fisherman's Folly
				{ 119, 199896 },                                        -- Rubbery Fish Head
				{ 120, 199897 },                                        -- Blue-Covered Beanbag
				{ 121, 199899 },                                        -- Iskaara Tug Sled
				{ 122, 199902 },                                        -- Wayfinder's Compass
				{ 123, 200116 },                                        -- Everlasting Horn of Lavaswimming
				-- { 124, 200142 }, -- Generous Goblin Grenade (unobtainable)
				{ 125, 200148 },                                        -- A Collection Of Me
				{ 126, 200160 },                                        -- Notfar's Favorite Food
				{ 127, 200178 },                                        -- Infected Ichor
				{ 128, 200198 },                                        -- Primalist Prison
				{ 129, 200249 },                                        -- Mage's Chewed Wand
				{ 130, 200469 },                                        -- Khadgar's Disenchanting Rod
				{ 201, 200550 },                                        -- Very Comfortable Pelt
				{ 202, 200551 },                                        -- Comfortable Pile of Pelts
				{ 203, 200597 },                                        -- Lover's Bouquet
				{ 204, 200628 },                                        -- Somewhat-Stabilized Arcana
				{ 205, 200630 },                                        -- Ohn'ir Windsage's Hearthstone
				{ 206, 200631 },                                        -- Happy Tuskarr Palooza
				{ 207, 200636 },                                        -- Primal Invocation Quintessence
				{ 208, 200640 },                                        -- Obsidian Egg Clutch
				{ 209, 200707 },                                        -- Armoire of Endless Cloaks
				{ 210, 200857 },                                        -- Talisman of Sargha
				{ 211, 200869 },                                        -- Ohn Lite Branded Horn
				{ 212, 200878 },                                        -- Wheeled Floaty Boaty Controller
				{ 213, 200926 },                                        -- Compendium of Love
				{ 214, 200960 },                                        -- Seed of Renewed Souls
				{ 215, 200999 },                                        -- The Super Shellkhan Gang
				{ 216, 201435 },                                        -- Shuffling Sands
				{ 217, 201815 },                                        -- Cloak of Many Faces
				{ 218, 201927 },                                        -- Gleaming Arcanocrystal
				{ 219, 201933 },                                        -- Black Dragon's Challenge Dummy
				{ 220, 202019 },                                        -- Golden Dragon Goblet
				{ 221, 202021 },                                        -- Breaker's Flag of Victory
				{ 222, 202022 },                                        -- Yennu's Kite
				{ 223, 202042 },                                        -- Aquatic Shades
				{ 224, 202711 },                                        -- Lost Compass
				{ 225, 204675, [PRICE_EXTRA_ITTYPE] = "noblegardenchocolate:200" }, -- A Drake's Big Basket of Eggs
				{ 226, 218112, [PRICE_EXTRA_ITTYPE] = "tender:200" },   -- Colorful Beach Chair
				{ 227, 212518, [PRICE_EXTRA_ITTYPE] = "ridersOfAzerothBadge:40" }, -- Vial of Endless Draconic Scales
				{ 228, 212525, [PRICE_EXTRA_ITTYPE] = "tender:200" },   -- Delicate Ebony Parasol
			}
		},
	},
}
