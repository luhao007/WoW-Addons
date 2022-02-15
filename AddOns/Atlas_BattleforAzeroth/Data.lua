-- $Id: Data.lua 19 2022-02-02 17:10:50Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2020 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local BF = Atlas_GetLocaleLibBabble("LibBabble-Faction-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local BfA = Atlas:GetModule(private.module_name)

local db = {}
BfA.db = db

local function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	return Atlas:GetBossName(bossname, encounterID, creatureIndex, private.module_name)
end

local BLUE = "|cff6666ff"
local GREN = "|cff66cc33"
local GREY = "|cff999999"
local LBLU = "|cff33cccc"
local _RED = "|cffcc3333"
local ORNG = "|cffcc9933"
local PINK = "|ccfcc33cc"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local YLOW = "|cffcccc33"
local INDENT = "      "

db.AtlasMaps = {
	-- /////////////////////////////////
	-- Kul Tiras instances
	-- /////////////////////////////////
	-- Battle of Dazar'alor, Raid
	BattleofDazaralor = {
		ZoneName = { BZ["Battle of Dazar'alor"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
--		Acronym = "",
		WorldMapID = 1352,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 1) "..Atlas_GetBossName("Champion of the Light", 2333), 2333},
		{ WHIT..INDENT..Atlas_GetBossName("Frida Ironbellows", 2333, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Anointed Disciple", 2333, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Darkforged Crusader", 2333, 3), },
		{ WHIT.." 1) "..Atlas_GetBossName("Champion of the Light", 2334), 2334},
		{ WHIT..INDENT..Atlas_GetBossName("High Tinker Mekkatorque", 2334, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Spark Bot", 2334, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Explosive Sheep", 2334, 3), },
		{ WHIT.." 2) "..Atlas_GetBossName("Jadefire Masters", 2323), 2323},
		{ WHIT..INDENT..Atlas_GetBossName("Ma'ra Grimfang", 2323, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Anathos Firecaller", 2323, 2), },
		{ WHIT.." 2) "..Atlas_GetBossName("Grong, the Jungle Lord", 2325), 2325},
		{ WHIT..INDENT..Atlas_GetBossName("Grong", 2325, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Flying Ape Wranglers", 2325, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Apetagonizer 3000", 2325, 3), },
		{ WHIT.." 2) "..Atlas_GetBossName("Grong, the Revenant", 2340), 2340},
		{ WHIT..INDENT..Atlas_GetBossName("Death Specter", 2340, 2), },
		{ WHIT.." 3) "..Atlas_GetBossName("Jadefire Masters", 2341), 2341},
		{ WHIT..INDENT..Atlas_GetBossName("Manceroy Flamefist", 2341, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Mestrah", 2341, 2), },
		{ WHIT.." 3) "..Atlas_GetBossName("Opulence", 2342), 2342},
		{ WHIT.." 4) "..Atlas_GetBossName("Conclave of the Chosen", 2330), 2330},
		{ WHIT..INDENT..Atlas_GetBossName("Pa'ku's Aspect", 2330, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Gonk's Aspect", 2330, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Kimbul's Aspect", 2330, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Akunda's Aspect", 2330, 4), },
		{ WHIT.." 6) "..Atlas_GetBossName("King Rastakhan", 2335), 2335},
		{ WHIT..INDENT..Atlas_GetBossName("Bwonsamdi", 2335, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Prelate Za'lan", 2335, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Headhunter Gal'wana", 2335, 4), },
		{ WHIT..INDENT..Atlas_GetBossName("Siegebreaker Roka", 2335, 5), },
		{ WHIT..INDENT..Atlas_GetBossName("Rastari Honorguard", 2335, 6), },
		{ WHIT.." 7) "..Atlas_GetBossName("High Tinker Mekkatorque", 2334), 2334},
		{ WHIT..INDENT..Atlas_GetBossName("Spark Bot", 2334, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Explosive Sheep", 2334, 3), },
		{ WHIT.." 8) "..Atlas_GetBossName("Stormwall Blockade", 2337), 2337},
		{ WHIT..INDENT..Atlas_GetBossName("Laminaria", 2337, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Sister Katherine", 2337, 2), },
		{ WHIT.." 9) "..Atlas_GetBossName("Lady Jaina Proudmoore", 2343), 2343},
	},
	-- Crucible of Storms, Raid
	CrucibleofStorms = {
		ZoneName = { BZ["Crucible of Storms"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1952,
		DungeonHeroicID = 1953,
		DungeonMythicID = 1954,
		PlayerLimit = { 10, 30 },
--		Acronym = "",
		WorldMapID = 1345, -- 1346
		JournalInstanceID = 1177,
		ZoneID = 10057,
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 1) "..Atlas_GetBossName("The Restless Cabal", 2328), 2328},
		{ WHIT..INDENT..Atlas_GetBossName("Zaxasj the Speaker", 2328, 1) },
		{ WHIT..INDENT..Atlas_GetBossName("Fa'thuul the Feared", 2328, 2) },
		{ WHIT.." 2) "..Atlas_GetBossName("Uu'nat, Harbinger of the Void", 2332), 2332},
	},
	-- Freehold
	Freehold = {
		ZoneName = { BZ["Freehold"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1672,
		DungeonHeroicID = 1773,
		DungeonMythicID = 1704,
--		Acronym = "",
		WorldMapID = 936,
		JournalInstanceID = 1001,
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 1) "..Atlas_GetBossName("Skycap'n Kragg", 2102), 2102},
		{ WHIT..INDENT..Atlas_GetBossName("Shark Bait", 2012, 2), },
		{ WHIT.." 2) "..Atlas_GetBossName("Council o' Captains", 2093), 2093},
		{ WHIT..INDENT..Atlas_GetBossName("Captain Eudora", 2093, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Captain Jolly", 2093, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Captain Raoul", 2093, 3), },
		{ WHIT.." 3) "..Atlas_GetBossName("Ring of Booty", 2094), 2094},
		{ WHIT.." 4) "..Atlas_GetBossName("Harlan Sweete", 2095), 2095},
	},
	-- Operation: Mechagon
	OperationMechagon = {
		ZoneName = { BZ["Operation: Mechagon"] },
		Location = { BZ["Mechagon"] },
	},
	-- Shrine of the Storm
	ShrineoftheStormA = {
		ZoneName = { BZ["Shrine of the Storm"]..ALC["MapA"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1709,
		DungeonHeroicID = 1774,
		DungeonMythicID = 1710,
		--Acronym = "",
		WorldMapID = 1039,
		JournalInstanceID = 1036,
		ZoneID = 9525,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "ShrineoftheStormB",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..ALC["Connection"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Aqu'sirr", 2153), 2153 },
		{ WHIT.." 2) "..Atlas_GetBossName("Tidesage Council", 2154), 2154 },
		{ WHIT..INDENT..Atlas_GetBossName("Brother Ironhull", 2154, 1) },
		{ WHIT..INDENT..Atlas_GetBossName("Galecaller Faye", 2154, 2) },
		{ WHIT.." 4) "..Atlas_GetBossName("Vol'zith the Whisperer", 2156), 2156 },
	},
	ShrineoftheStormB = {
		ZoneName = { BZ["Shrine of the Storm"]..ALC["MapB"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1709,
		DungeonHeroicID = 1774,
		DungeonMythicID = 1710,
		--Acronym = "",
		WorldMapID = 1040,
		JournalInstanceID = 1036,
		ZoneID = 9525,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "ShrineoftheStormA",
		{ BLUE.." B) "..ALC["Connection"], 10002 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lord Stormsong", 2155), 2155 },
	},
	-- Siege of Boralus
	SiegeofBoralus = {
		ZoneName = { BZ["Siege of Boralus"] },
		Location = { BZ["Tiragarde Sound"] },
--		DungeonID = 0,
		DungeonHeroicID = 1700,
--		DungeonMythicID = 0,
--		Acronym = "",
		WorldMapID = 1162,
		JournalInstanceID = 1023,
		ZoneID = 9354,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Chopper Redhook", 2132), 2132 },
		{ WHIT..INDENT..Atlas_GetBossName("Sergeant Bainbridge", 2133), 2133  },
		{ WHIT.." 2) "..Atlas_GetBossName("Dread Captain Lockwood", 2173), 2173 },
		{ WHIT.." 3) "..Atlas_GetBossName("Hadal Darkfathom", 2134), 2134 },
		{ WHIT.." 4) "..Atlas_GetBossName("Viq'Goth", 2140), 2140 },
	},
	-- Tol Dagor
	TolDagorA = {
		ZoneName = { BZ["Tol Dagor"]..ALC["MapA"] },
		Location = { BZ["Tol Dagor"] },
		DungeonID = 1713,
		DungeonHeroicID = 1778,
		DungeonMythicID = 1714,
--		Acronym = "",
		WorldMapID = 974,
		JournalInstanceID = 1002,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "TolDagorB",
		{ WHIT.." 1) "..Atlas_GetBossName("The Sand Queen", 2097), 2097},
		{ WHIT.." 3) "..Atlas_GetBossName("Knight Captain Valyri", 2099), 2099},
		{ WHIT.." 4) "..Atlas_GetBossName("Overseer Korgus", 2096), 2096},
	},
	TolDagorB = {
		ZoneName = { BZ["Tol Dagor"]..ALC["MapB"] },
		Location = { BZ["Tol Dagor"] },
		DungeonID = 1713,
		DungeonHeroicID = 1778,
		DungeonMythicID = 1714,
--		Acronym = "",
		WorldMapID = 977,
		JournalInstanceID = 1002,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "TolDagorA",
		{ BLUE.." B-E) "..ALC["Connection"], 10002 },
		{ WHIT.." 2) "..Atlas_GetBossName("Jes Howlis", 2098), 2098},
	},
	-- Waycrest Manor
	WaycrestManorA = {
		ZoneName = { BZ["Waycrest Manor"]..ALC["MapA"] },
		Location = { BZ["Drustvar"] },
		DungeonID = 1705,
		DungeonHeroicID = 1779,
		DungeonMythicID = 1706,
--		Acronym = "",
		WorldMapID = 1015,
		JournalInstanceID = 1021,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "WaycrestManorB",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..ALC["Connection"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Heartsbane Triad", 2125), 2125},
		{ WHIT.." 2) "..Atlas_GetBossName("Soulbound Goliath", 2126), 2126},
		{ WHIT.." 3) "..Atlas_GetBossName("Raal the Gluttonous", 2127), 2127},
	},
	WaycrestManorB = {
		ZoneName = { BZ["Waycrest Manor"]..ALC["MapB"] },
		Location = { BZ["Drustvar"] },
		DungeonID = 1705,
		DungeonHeroicID = 1779,
		DungeonMythicID = 1706,
--		Acronym = "",
		WorldMapID = 1018,
		JournalInstanceID = 1021,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "WaycrestManorA",
		{ BLUE.." B-D) "..ALC["Connection"], 10002 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lord and Lady Waycrest", 2128), 2128},
		{ WHIT.." 5) "..Atlas_GetBossName("Gorak Tul", 2129), 2129},
	},
	
	-- /////////////////////////////////
	-- Zuldazar instances
	-- /////////////////////////////////
	-- Atal'Dazar
	AtalDazar = {
		ZoneName = { BZ["Atal'Dazar"] },
		Location = { BZ["Zuldazar"] },
		DungeonID = 1668,
		DungeonHeroicID = 1772,
		DungeonMythicID = 1669,
		--Acronym = "",
		WorldMapID = 934,
		JournalInstanceID = 968,
		ZoneID = 9028,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Priestess Alun'za", 2082), 2082 },
		{ WHIT.." 2) "..Atlas_GetBossName("Vol'kaal", 2036), 2036 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rezan", 2083), 2083 },
		{ WHIT..INDENT..Atlas_GetBossName("Ancient Bones", 2083, 2), },
		{ WHIT.." 4) "..Atlas_GetBossName("Yazma", 2030), 2030 },
	},
	-- Kings' Rest
	KingsRest = {
		ZoneName = { BZ["Kings' Rest"] },
		Location = { BZ["Zuldazar"] },
		DungeonID = 1784,
		DungeonHeroicID = 1785,
--		DungeonMythicID = 1785,
--		Acronym = "",
		WorldMapID = 1004,
		JournalInstanceID = 1041,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("The Golden Serpent", 2165), 2165},
		{ WHIT.." 2) "..Atlas_GetBossName("Mchimba the Embalmer", 2171), 2171},
		{ WHIT.." 3) "..Atlas_GetBossName("The Council of Tribes", 2170), 2170},
		{ WHIT..INDENT..Atlas_GetBossName("Aka'ali the Conqueror", 2170, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Zanazal the Wise", 2170, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Kula the Butcher", 2170, 3), },
		{ WHIT.." 4) "..Atlas_GetBossName("Dazar, The First King", 2172), 2172},
	},
	-- The MOTHERLODE!!
	TheMOTHERLODE = {
		ZoneName = { BZ["The MOTHERLODE!!"] },
		Location = { BZ["Zuldazar"] },
		DungeonID = 1707,
		DungeonHeroicID = 1776,
		DungeonMythicID = 1708,
--		Acronym = "",
		WorldMapID = 1010,
		JournalInstanceID = 1012,
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 1) "..Atlas_GetBossName("Coin-Operated Crowd Pummeler", 2109), 2109},
		{ WHIT.." 2) "..Atlas_GetBossName("Azerokk", 2114), 2114},
		{ WHIT.." 3) "..Atlas_GetBossName("Rixxa Fluxflame", 2115), 2115},
		{ WHIT.." 4) "..Atlas_GetBossName("Mogul Razdunk", 2116), 2116},
	},
	-- Temple of Sethraliss
	TempleofSethraliss = {
		ZoneName = { BZ["Temple of Sethraliss"] },
		Location = { BZ["Vol'dun"] },
		DungeonID = 1694,
		DungeonHeroicID = 1775,
		DungeonMythicID = 1695,
--		Acronym = "",
		WorldMapID = 1038,
		JournalInstanceID = 1030,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Adderis and Aspix", 2142), 2142},
		{ WHIT.." 2) "..Atlas_GetBossName("Merektha", 2143), 2143},
		{ WHIT..INDENT..Atlas_GetBossName("Venomous Ophidian", 2143, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Sand-crusted Striker", 2143, 3), },
		{ WHIT.." 3) "..Atlas_GetBossName("Galvazzt", 2144), 2144},
		{ WHIT.." 4) "..Atlas_GetBossName("Avatar of Sethraliss", 2145), 2145},
		{ WHIT..INDENT..Atlas_GetBossName("Hoodoo Hexxer", 2145, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Heart Guardian", 2145, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Plague Doctor", 2145, 4), },
	},
	-- Uldir
	Uldir = {
		ZoneName = { BZ["Uldir"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
--		Acronym = "",
		WorldMapID = 1148,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
--		{ WHIT..INDENT..Atlas_GetBossName("", 2168, 2), },
		{ WHIT.." 1) "..Atlas_GetBossName("Taloc", 2168), 2168},
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Droplet", 2168, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Coalesced Blood", 2168, 3), },
		{ WHIT.." 2) "..Atlas_GetBossName("MOTHER", 2167), 2167},
		{ WHIT..INDENT..Atlas_GetBossName("Remnant of Corruption", 2167, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Resistant Bacterium", 2167, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Viral Contagion", 2167, 4), },
		{ WHIT.." 3) "..Atlas_GetBossName("Fetid Devourer", 2146), 2146},
		{ WHIT..INDENT..Atlas_GetBossName("Corruption Corpuscle", 2146, 2), },
		{ WHIT.." 3) "..Atlas_GetBossName("Zek'voz, Herald of N'zoth", 2169), 2169},
		{ WHIT..INDENT..Atlas_GetBossName("Zek'voz", 2169, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Silithid Warrior", 2169, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Nerubian Voidweaver", 2169, 3), },
		{ WHIT.." 4) "..Atlas_GetBossName("Vectis", 2166), 2166},
		{ WHIT.." 6) "..Atlas_GetBossName("Zul, Reborn", 2195), 2195},
		{ WHIT..INDENT..Atlas_GetBossName("Zul", 2195, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Nazmani Crusher", 2195, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Nazmani Bloodhexer", 2195, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Bloodthirsty Crawg", 2195, 4), },
		{ WHIT.." 8) "..Atlas_GetBossName("Mythrax the Unraveler", 2194), 2194},
		{ WHIT.." 11) "..Atlas_GetBossName("G'huun", 2147), 2147},
		{ WHIT..INDENT..Atlas_GetBossName("Blightspreader Tendril", 2147, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Cyclopean Terror", 2147, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Dark Young", 2147, 4), },
	},
	-- The Underrot
	TheUnderrot = {
		ZoneName = { BZ["The Underrot"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1711,
		DungeonHeroicID = 1777,
		DungeonMythicID = 1712,
--		Acronym = "",
		WorldMapID = 1041,
		JournalInstanceID = 1022,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Elder Leaxa", 2157), 2157},
		{ WHIT.." 2) "..Atlas_GetBossName("Cragmaw the Infested", 2131), 2131},
		{ WHIT.." 3) "..Atlas_GetBossName("Sporecaller Zancha", 2130), 2130},
		{ WHIT.." 4) "..Atlas_GetBossName("Unbound Abomination", 2158), 2158},
	},

	-- The Eternal Palace
	TheEternalPalace = {
		ZoneName = { BZ["The Eternal Palace"] },
		Location = { BZ["Nazjatar"] },
	},
}

--[[ /////////////////////////////////////////
 Atlas Map NPC Description Data
 zoneID = {
	{ ID or letter mark, encounterID or customizedID, x, y, x_largeMap, y_largeMap, color of the letter mark };
	{ "A", 10001, 241, 460 };
	{ 1, 1694, 373, 339 };
 };
/////////////////////////////////////////////]]
db.AtlasMaps_NPC_DB = {
	Freehold = {
		{  1, 2102, 458, 276 },
		{  2, 2093, 238, 302 },
		{  3, 2094, 112, 306 },
		{  4, 2095, 176, 147 },
	},
	SiegeofBoralus = {
		{ "A", 10001, 364, 80 },
		{ 1, 2132, 248, 131 },
		{ 2, 2173, 200, 286 }, 
		{ 3, 2134, 147, 384 },
		{ 4, 2140, 202, 465 },
	},
	ShrineoftheStormA = {
		{ "A", 10001, 188, 103 },
		{ "B", 10002, 217, 399 },
		{ 1, 2153, 154, 228 },
		{ 2, 2154,  25, 226 },
		{ 4, 2156, 435, 385 },
	},
	ShrineoftheStormB = {
		{ "B", 10002, 90, 179 },
		{ 3, 2155, 371, 339 }, 
	},
	TolDagorA = {
		{ 1, 2097, 258, 252 },
		{ 3, 2099, 209, 304 }, 
		{ 4, 2096, 180, 234 }, 
	},
	TolDagorB = {
		{ "B", 10002, 405, 37 }, 
		{ "B", 10002, 213, 59 }, 
		{ "C", 10002, 69, 193 },
		{ "C", 10002, 81, 461 },
		{ "D", 10002, 48, 434 },
		{ "D", 10002, 293, 452 }, 
		{ "E", 10002, 428, 280 }, 
		{ 2, 2098, 107, 434 }, 
	},
	WaycrestManorA = {
		{ "A", 10001, 256, 500 },
		{ "B", 10002, 196, 335 }, 
		{ "B", 10002, 316, 294 },
		{ 1, 2125, 116, 450 },
		{ 2, 2126, 250, 240 }, 
		{ 3, 2127, 375, 341 }
	},
	WaycrestManorB = {
		{ "B", 10002, 335, 44 },
		{ "B", 10002, 15094, 44 },
		{ "C", 10002, 256, 146 },
		{ "C", 10002, 480, 264 },
		{ "D", 10002, 326, 442 },
		{ "D", 10002, 89, 372 },
		{ 4, 2128, 349, 289 },
		{ 5, 2129, 121, 256 },
	},
	AtalDazar = {
		{ "A", 10001, 458, 256 },
		{ 1, 2082, 247, 435 },
		{ 2, 2036, 247, 78 },
		{ 3, 2083, 247, 247 },
		{ 4, 2030, 91, 247 },
	},
	KingsRest = {
		{ "A", 10001, 500, 256 },
		{ 1, 2165, 436, 328 },
		{ 2, 2171, 287, 151 },
		{ 3, 2170, 225, 389 },
		{ 4, 2172, 39, 246 },
	},
	TheMOTHERLODE = {
		{ 1, 2109, 206, 201 },
		{ 2, 2114, 83, 84 },
		{ 3, 2115, 282, 53 }, 
		{ 4, 2116, 396, 149 },
	},
	TempleofSethraliss = {
		{ "A", 10001, 357, 497 },
		{ 1, 2109, 351, 403 }, 
		{ 2, 2114, 220, 311 },
		{ 3, 2115, 232, 232 },
		{ 4, 2116, 108, 29 },
	},
	TheUnderrot = {
		{ "A", 10001, 246, 497 },
		{ 1, 2157, 256, 300 }, 
		{ 2, 2131, 447, 310 },
		{ 3, 2130, 382, 175 },
		{ 4, 2158, 65, 44 },
	},
}

--[[
	AssocDefaults{}

	Default map to be auto-selected when no SubZone data is available.

	For example, "Dire Maul" has a subzone called "Warpwood Quarter" located in East Dirl Maul, however, there are also 
	some areas which have not been named with any subzone, and we would like to pick a proper default map in this condition.

	Define this table entries only when the instance has multiple maps.

	Table index is zone name, it need to be localized value, but we will handle the localization with BabbleSubZone library.
	The table value is map's key-name.
]]
db.AssocDefaults = {
--	[BZ["Black Rook Hold"]] = 		"BlackRookHoldA",
}

--[[
	SubZoneData{}

	Define SubZone data for default map to be selected for instance which has multiple maps.
	Subzone data should be able to be pulled out from WMOAreaTable for indoor areas, or from AreaTable for outdoor areas.

	Array Syntax: 
	["localized zone name"] = {
		["atlas map name"] = {
			["localized subzone name 1"],
			["localized subzone name 2"],
		},
	},
]]
db.SubZoneData = {
--	[BZ["Trial of Valor"]] = {
--		["TrialofValorA"] = {
--		
--		},
--		["TrialofValorB"] = {
--		
--		},
--	},
}

--[[
	OutdoorZoneToAtlas{}

	Maps to auto-select to from outdoor zones.

	Table index is sub-zone name, it need to be localized value, but we will handle
	the localization with BabbleSubZone library.
	The table value is map's key-name.

	Duplicates are commented out.
	Not for localization.
]]
db.OutdoorZoneToAtlas = {
--	[BZ["Dalaran"]] = 			"AssaultonVioletHold",
}

db.EntToInstMatches = {
--	["TheNightholdEnt"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightholdG" },
}

db.InstToEntMatches = {
--	["TheArcway"] = 			{"TheArcwayEnt"},
}

db.MapSeries = {
	["ShrineoftheStormA"] = 		{"ShrineoftheStormA", "ShrineoftheStormB"},
	["ShrineoftheStormB"] = 		{"ShrineoftheStormA", "ShrineoftheStormB"},
	["TolDagorA"] = 			{"TolDagorA", "TolDagorB"},
	["TolDagorB"] = 			{"TolDagorA", "TolDagorB"},
	["WaycrestManorA"] = 			{"WaycrestManorA", "WaycrestManorB"},
	["WaycrestManorB"] = 			{"WaycrestManorA", "WaycrestManorB"},
}

db.SubZoneAssoc = {
--	["BlackRookHoldA"] = 			BZ["Black Rook Hold"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_KULTIRAS,
		ATLAS_DDL_CONTINENT_ZANDALAR,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_110TO120,
		ATLAS_DDL_LEVEL_120PLUS,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_BFA,
	},
	[ATLAS_DDL_PARTYSIZE] = {
		ATLAS_DDL_PARTYSIZE_5,
		ATLAS_DDL_PARTYSIZE_10,
		ATLAS_DDL_PARTYSIZE_20TO40,
	},
	[ATLAS_DDL_TYPE] = {
		ATLAS_DDL_TYPE_INSTANCE,
		ATLAS_DDL_TYPE_ENTRANCE,
	},
}
db.DropDownLayouts = {
	[ATLAS_DDL_CONTINENT] = {
		[ATLAS_DDL_CONTINENT_KULTIRAS] = {
--			"CrucibleofStorms", -- Raid
--			"BattleofDazaralor", -- Raid
			"Freehold",
			"SiegeofBoralus",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
		},
		[ATLAS_DDL_CONTINENT_ZANDALAR] = {
			"AtalDazar",
			"KingsRest",
			"TheMOTHERLODE",
			"TempleofSethraliss",
--			"Uldir", -- Raid
			"TheUnderrot",
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_BFA] = {
			"AtalDazar",
			"SiegeofBoralus",
--			"BattleofDazaralor",
--			"CrucibleofStorms",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"KingsRest",
			"TheMOTHERLODE",
			"TempleofSethraliss",
--			"Uldir",
			"TheUnderrot",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_110TO120] = {
			"AtalDazar",
			"SiegeofBoralus",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"TheUnderrot",
		},
		[ATLAS_DDL_LEVEL_120PLUS] = {
--			"BattleofDazaralor",
--			"CrucibleofStorms",
			"KingsRest",
--			"Uldir",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"AtalDazar",
			"SiegeofBoralus",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"KingsRest",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"TheUnderrot",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
--			"BattleofDazaralor",
--			"CrucibleofStorms",
--			"Uldir",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"AtalDazar",
			"SiegeofBoralus",
--			"BattleofDazaralor",
--			"CrucibleofStorms",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"KingsRest",
			"TheMOTHERLODE",
			"TempleofSethraliss",
--			"Uldir",
			"TheUnderrot",
		},
		[ATLAS_DDL_TYPE_ENTRANCE] = {
		},
	},
}
