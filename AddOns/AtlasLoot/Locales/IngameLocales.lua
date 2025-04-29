local _G = getfenv(0)

local AtlasLoot = _G.AtlasLoot

-- lua
local rawget = rawget
local _, tmp1
local months = {
	MONTH_JANUARY,
	MONTH_FEBRUARY,
	MONTH_MARCH,
	MONTH_APRIL,
	MONTH_MAY,
	MONTH_JUNE,
	MONTH_JULY,
	MONTH_AUGUST,
	MONTH_SEPTEMBER,
	MONTH_OCTOBER,
	MONTH_NOVEMBER,
	MONTH_DECEMBER,
}

local GetAchievementInfo, UnitSex = _G.GetAchievementInfo, _G.UnitSex

local function GetSpecNameById(id)
	_, tmp1 = GetSpecializationInfoByID(id)
	return tmp1
end

local function GetAchievementName(id)
	_, tmp1 = GetAchievementInfo(id)
	return tmp1
end

local function GetBuildingName(id)
	_, tmp1 = C_Garrison.GetBuildingInfo(id)
	return tmp1
end

local function GetFactionName(id)
	return C_Reputation.GetFactionDataByID(id).name
end

local function GetMapName(id)
	return C_Map.GetMapInfo(id).name
end

local function AtlasLoot_GetClassName(class)
	if (not LOCALIZED_CLASS_NAMES_MALE[class]) then
		return nil;
	end
	if (UnitSex("player") == "3") then
		return LOCALIZED_CLASS_NAMES_FEMALE[class];
	else
		return LOCALIZED_CLASS_NAMES_MALE[class];
	end
end

local IngameLocales = {
	-- ######################################################################
	-- Factions
	-- ######################################################################
	-- Legion
	["Bizmo's Brawlpub"]      = GetFactionName(2011),
	["Brawl'gar Arena"]       = GetFactionName(2010),
	-- Warlords of Draenor
	--	["Bizmo's Brawlpub"] = GetFactionName(1691),
	--	["Brawl'gar Arena"] = GetFactionName(1690),
	-- Mists of Pandaria
	["Nat Pagle"]             = GetFactionName(1358),
	["Old Hillpaw"]           = GetFactionName(1276),
	["Sho"]                   = GetFactionName(1278),
	["The August Celestials"] = GetFactionName(1341),

	-- ######################################################################
	-- Months
	-- ######################################################################
	["January"]               = months[1],
	["February"]              = months[2],
	["March"]                 = months[3],
	["April"]                 = months[4],
	["May"]                   = months[5],
	["June"]                  = months[6],
	["July"]                  = months[7],
	["August"]                = months[8],
	["September"]             = months[9],
	["October"]               = months[10],
	["November"]              = months[11],
	["December"]              = months[12],

	-- ######################################################################
	-- Class Specs
	-- ######################################################################
	["Balance"]               = GetSpecNameById(102),
	["Feral"]                 = GetSpecNameById(103),
	["Guardian"]              = GetSpecNameById(104),
	["Restoration"]           = GetSpecNameById(105),
	["Blood"]                 = GetSpecNameById(250),
	["Frost"]                 = GetSpecNameById(251),
	["Unholy"]                = GetSpecNameById(252),
	["Brewmaster"]            = GetSpecNameById(268),
	["Mistweaver"]            = GetSpecNameById(270),
	["Windwalker"]            = GetSpecNameById(269),
	["Discipline"]            = GetSpecNameById(256),
	["Holy"]                  = GetSpecNameById(257),
	["Shadow"]                = GetSpecNameById(258),
	["Protection"]            = GetSpecNameById(66),
	["Retribution"]           = GetSpecNameById(70),
	["Elemental"]             = GetSpecNameById(262),
	["Enhancement"]           = GetSpecNameById(263),
	["Arms"]                  = GetSpecNameById(71),
	["Fury"]                  = GetSpecNameById(72),

	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic
	["Ahn'Qiraj"]             = GetMapName(319),
	["Blackrock Depths"]      = GetMapName(242),
	["Blackwing Lair"]        = GetMapName(287),
	["Lower Blackrock Spire"] = GetAchievementName(643),
	["Molten Core"]           = GetMapName(232),
	["Orgrimmar"]             = GetMapName(85),
	["Ruins of Ahn'Qiraj"]    = GetMapName(247),
	["Shadowfang Keep"]       = GetMapName(310),
	["Stormwind City"]        = GetMapName(84),
	["Upper Blackrock Spire"] = GetAchievementName(1307),

	-- Burning Crusade
	["Black Temple"]          = GetMapName(339),
	["Gruul's Lair"]          = GetMapName(330),
	["Hyjal Summit"]          = GetMapName(329),
	["Karazhan"]              = GetMapName(350),
	["Magtheridon's Lair"]    = GetMapName(331),
	["Outland"]               = GetMapName(101),
	["Serpentshrine Cavern"]  = GetMapName(332),
	["Shattrath City"]        = GetMapName(111),
	["Sunwell Plateau"]       = GetMapName(335),
	["Tempest Keep"]          = GetMapName(334),
	["The Slave Pens"]        = GetMapName(265),

	-- Wrath of the Lich King
	["Dalaran"]               = GetMapName(125),
	["Icecrown"]              = GetMapName(118),
	["Icecrown Citadel"]      = GetMapName(186),
	["Naxxramas"]             = GetMapName(162),
	["Northrend"]             = GetMapName(113),
	["Onyxia's Lair"]         = GetMapName(248),
	["The Eye of Eternity"]   = GetMapName(141),
	["The Obsidian Sanctum"]  = GetMapName(155),
	["The Ruby Sanctum"]      = GetMapName(200),
	["Trial of the Crusader"] = GetMapName(172),
	["Ulduar"]                = GetMapName(147),
	["Vault of Archavon"]     = GetMapName(156),

	-- Cataclysm
	["Molten Front"]          = GetMapName(338),

	-- Mists of Pandaria
	["Scarlet Monastery"]     = GetMapName(435),
	["Timeless Isle"]         = GetMapName(554),

	-- Battle for Azeroth
	["Kul Tiras"] = GetMapName(876),
	["Zandalar"] = GetMapName(875),
	["Boralus"]     = GetMapName(1161),
	["Dazar'alor"]     = GetMapName(1165),

	-- The War Within
	["Dornogal"]     = GetMapName(2339),
	["Khaz Algar"]     = GetMapName(2274),

	-- ######################################################################
	-- Garrison Buildings
	-- ######################################################################
	["DBWM"]                  = GetBuildingName(10), -- Client autoselection
	["Enchanter's Study"]     = GetBuildingName(126),
	["Engineering Works"]     = GetBuildingName(124),
	["Fishing Shack"]         = GetBuildingName(135),
	["GGGW"]                  = GetBuildingName(164), -- Client autoselection
	["LIFT"]                  = GetBuildingName(36), -- Client autoselection
	["Salvage Yard"]          = GetBuildingName(141),
	["Stables"]               = GetBuildingName(67),
	["The Tannery"]           = GetBuildingName(122),

	-- data from Core/ItemInfo.lua is generated after loading

	-- ######################################################################
	-- Class
	-- ######################################################################
	["DEATHKNIGHT"]           = AtlasLoot_GetClassName("DEATHKNIGHT"),
	["DEMONHUNTER"]           = AtlasLoot_GetClassName("DEMONHUNTER"),
	["DRUID"]                 = AtlasLoot_GetClassName("DRUID"),
	["EVOKER"]                = AtlasLoot_GetClassName("EVOKER"),
	["HUNTER"]                = AtlasLoot_GetClassName("HUNTER"),
	["MAGE"]                  = AtlasLoot_GetClassName("MAGE"),
	["MONK"]                  = AtlasLoot_GetClassName("MONK"),
	["PALADIN"]               = AtlasLoot_GetClassName("PALADIN"),
	["PRIEST"]                = AtlasLoot_GetClassName("PRIEST"),
	["ROGUE"]                 = AtlasLoot_GetClassName("ROGUE"),
	["SHAMAN"]                = AtlasLoot_GetClassName("SHAMAN"),
	["WARLOCK"]               = AtlasLoot_GetClassName("WARLOCK"),
	["WARRIOR"]               = AtlasLoot_GetClassName("WARRIOR"),
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end })
