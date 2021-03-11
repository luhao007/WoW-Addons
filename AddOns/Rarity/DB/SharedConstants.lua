local addonName, addonTable = ...

-- Set up shared constants (for ease of use, mainly)
-- Note: Don't change the string values, refactoring is only partially complete (search all files to see)
-- They were originally hardcoded EVERYWHERE and are also used directly as keys in the DB...
addonTable.constants = addonTable.constants or {}

local C = addonTable.constants

-- Types of items
C.TOOLTIP = {
	ACTIVATION_METHOD_HOVER = "ACTIVATION_METHOD_HOVER",
	ACTIVATION_METHOD_CLICK = "ACTIVATION_METHOD_CLICK",
}

-- Misc. stuff for the detailed lockout storage / defeat detection
C.DEFEAT_DETECTION = {
	MODE_OR = 1,
	MODE_AND = 2,
}

-- Embedded mapIDs: It's best to avoid hardcoding these in case of yet another re-mapping on Blizzard's end...
C.UIMAPIDS = {

	ARATHI_HIGHLANDS = 14,
	DARKSHORE = 62,
	SILITHUS = 81,

	ICECROWN = 118,

	DEEPHOLM = 207,
	TWILIGHT_HIGHLANDS = 241,
	TOL_BARAD = 244,
	TOL_BARAD_PENINSULA = 245,
	ULDUM_CATACLYSM = 249,

	MAGISTERS_TERRACE_GRAND_MAGISTERS_ASYLUM = 348,
	MAGISTERS_TERRACE_OBSERVATION_GROUNDS = 349,

	FROSTFIRE_RIDGE = 525,
	LUNARFALL_GARRISON = 582,
	FROSTWALL_GARRISON = 590,

	KROKUUN = 830,
	MACAREE = 882,
	ANTORAN_WASTES = 885,

	SEAT_OF_THE_TRIUMVIRATE = 903,

	ZANDALAR = 875,
	KULTIRAS = 876,
	FREEHOLD = 936,
	TOLDAGOR = 974,
	KINGS_REST = 1004,
	TEMPLE_OF_SETHRALISS = 1043,
	THE_UNDERROT = 1042,
	BORALUS = 1161,
	DAZARALOR = 1165,
	BATTLE_FOR_DAZARALOR_RAID = 1364,
	NAZJATAR = 1355,
	MECHAGON_ISLAND = 1462,
	MECHAGON_ISLAND_DUNGEON = 1490,
	NAZMIR = 863,
	VOLDUN = 864,
	ZULDAZAR = 862,
	TIRAGARDE_SOUND = 895,
	DRUSTVAR = 896,
	STORMSONG_VALLEY = 942,
	ULDUM = 1527,
	VALE_OF_ETERNAL_BLOSSOMS = 1530,

	HORRIFIC_VISION_OF_STORMWIND = 1470,
	HORRIFIC_VISION_OF_ORGRIMMAR = 1469,

	NYALOTHA = 1582, -- Generic (doesn't matter which subzone, as waypoints inside of instances can no longer be set)

	BASTION = 1533,
	REVENDRETH = 1525,
	MALDRAXXUS = 1536,
	ARDENWEALD = 1565,

	THE_MAW = 1543,
	TORGHAST = 1751,

	THE_NECROTIC_WAKE = 1666,
	MISTS_OF_TIRNA_SCITHE = 1669,
	PLAGUEFALL = 1674,
	SANGUINE_DEPTHS = 1675,

	CASTLE_NATHRIA = 1735,
}

-- Types of items
C.ITEM_TYPES = {
	MOUNT = "MOUNT",
	PET = "PET",
	ITEM = "ITEM",
}

-- Types of different detection methods
C.DETECTION_METHODS = {
	NPC = "NPC",
	BOSS = "BOSS",
	ZONE = "ZONE",
	USE = "USE",
	FISHING = "FISHING",
	ARCH = "ARCH",
	SPECIAL = "SPECIAL",
	MINING = "MINING",
	COLLECTION = "COLLECTION",
}

-- Categories (expansions-based, with some special types of items)
C.ITEM_CATEGORIES = {
	CLASSIC = "BASE",
	TBC = "TBC",
	WOTLK = "WOTLK",
	CATA = "CATA",
	MOP = "MOP",
	WOD = "WOD",
	LEGION = "LEGION",
	BFA = "BFA",
	SHADOWLANDS = "SHADOWLANDS",
	HOLIDAY = "HOLIDAY",
}

-- Instance difficulties
C.INSTANCE_DIFFICULTIES = {
	NONE = 0,
	HEROIC_DUNGEON = 2,
	RAID_10_NORMAL = 3,
	RAID_25_NORMAL = 4,
	RAID_10_HEROIC = 5,
	RAID_25_HEROIC = 6,
	LEGACY_LFR = 7,
	NORMAL_RAID = 14, -- Normal (Raids)
	HEROIC_RAID = 15, -- Heroic (Raids)
	MYTHIC_RAID = 16, -- Mythic (Raids)
	LFR = 17,
	MYTHIC_DUNGEON = 23, -- Mythic 5-player instance
	TIMEWALKING_DUNGEON = 24, -- Timewalking 5-player instance
	TIMEWALKING_RAID = 33,
}


-- LDB feed text
C.LDB_TEXT_STYLES = {
	FEED_MINIMAL = "FEED_MINIMAL",
	FEED_VERBOSE = "FEED_VERBOSE",
}

C.SORT_METHODS = {
	SORT_NAME = "SORT_NAME",
	SORT_DIFFICULTY = "SORT_DIFFICULTY",
	SORT_PROGRESS = "SORT_PROGRESS",
	SORT_CATEGORY = "SORT_CATEGORY",
	SORT_ZONE = "SORT_ZONE",
}

C.COVENANT_IDS = {
	KYRIAN = 1,
	VENTHYR = 2,
	NIGHT_FAE = 3,
	NECROLORD = 4,
}

addonTable.constants = C
