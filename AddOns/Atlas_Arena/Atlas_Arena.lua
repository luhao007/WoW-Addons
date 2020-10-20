--[[

	Atlas Arena, a World of Warcraft instance map browser
	Copyright 2010 ~ 2020 Arith Hsu

	This file is a plugin of Atlas.

	Atlas Arena is free software; you can redistribute it and/or modify
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
local _G = getfenv(0)
local LibStub = _G.LibStub
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Atlas_Arena")
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")

local BLUE = "|cff6666ff"
local GREY = "|cff999999"
local GREN = "|cff66cc33"
local YELL = "|cffcccc00"
local _RED = "|cffcc6666"
local ORNG = "|cffcc9933"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local CYAN = "|cff008888"
local INVIS = "|c00000000"
local INDENT = "   "

local myCategory = L["Arena Maps"]

local myData = {
	-- Blade's Edge Arena
	CircleOfBlood_Arena = {
		ZoneName = { BZ["Blade's Edge Arena"] },
		Location = { BZ["Circle of Blood Arena"]..ALC["Comma"]..BZ["Blade's Edge Mountains"]..ALC["Comma"]..BZ["Outland"] },
		LevelRange = "10-90 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE..BZ["Circle of Blood Arena"] },
		{ "" },
		{ WHIT.."1) "..L["Frixee Brasstumbler <Arena Vendor>"] },
		{ WHIT.."2) "..L["Meminnie <Arena Vendor>"] },
	},
	-- Dalaran Arena
	Dalaran_Sewers_Arena = {
		ZoneName = { BZ["Dalaran Arena"] },
		Location = { BZ["Dalaran Sewers"]..ALC["Comma"]..BZ["Dalaran"]..ALC["Comma"]..BZ["Northrend"] },
		LevelRange = "10-90 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE..BZ["Dalaran Arena"] },
		{ "" },
		{ WHIT.."1) "..L["Xazi Smolderpipe <Arena Vendor>"] },
		{ WHIT.."2) "..L["Zom Bocom <Apprentice Arena Vendor>"] },
		{ WHIT.."3) "..L["Nargle Lashcord <Veteran Arena Vendor>"] },
		{ WHIT.."4) "..L["Trapjaw Rix <Exceptional Arena Weaponry>"] },
	},
	-- Nagrand Arena
	RingOfTrials_Arena = {
		ZoneName = { BZ["Nagrand Arena"] },
		Location = { BZ["The Ring of Trials"]..ALC["Comma"]..BZ["Nagrand"]..ALC["Comma"]..BZ["Outland"] },
		LevelRange = "10-90 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE..BZ["Nagrand Arena"] },
		{ "" },
		{ WHIT.."1) "..L["Kelara <Keeper of Sha'tari Heirlooms>"] },
		{ WHIT.."2) "..L["Grikkin Copperspring <Arena Vendor>"] },
	},
	-- The Ring of Blood
	RingofBlood_Arena = {
		ZoneName = { BZ["The Ring of Blood"] },
		Location = { BZ["Laughing Skull Ruins"]..ALC["Comma"]..BZ["Nagrand"]..ALC["Comma"]..BZ["Outland"] },
		LevelRange = "65-70 ("..L["Quests"]..")",
		PlayerLimit = "5",
		{ BLUE..BZ["The Ring of Blood"] },
		{ "" },
		{ WHIT.."1) "..L["Mogor <Hero of the Warmaul>"] }, -- 18069
		{ WHIT.."2) "..L["Wodin the Troll-Servant"] }, -- 22893
		{ WHIT.."3) "..L["Gurgthock"] }, -- 18471
	},
	
	-- The Ring of Valor
	RingOfValor_Arena = {
		ZoneName = { BZ["The Ring of Valor"] },
		Location = { BZ["Orgrimmar"]..ALC["Comma"]..BZ["Kalimdor"] },
		LevelRange = "10-90 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE..BZ["The Ring of Valor"] },
	},
	-- Ruins of Lordaeron
	RuinsOfLordaeron_Arena = {
		ZoneName = { BZ["Ruins of Lordaeron"] },
		Location = { BZ["Ruins of Lordaeron"]..ALC["Comma"]..BZ["Eastern Kingdoms"] },
		LevelRange = "10-90 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE..BZ["Ruins of Lordaeron"] },
	},
	-- Gurubashi Arena
	Gurubashi_Arena = {
		ZoneName = { BZ["Gurubashi Arena"] },
		Location = { BZ["The Cape of Stranglethorn"]..ALC["Comma"]..BZ["Eastern Kingdoms"] },
		LevelRange = "30-45 (PvP)",
		--PlayerLimit = "N/A",
		{ BLUE..BZ["Gurubashi Arena"] },
		{ "" },
		{ WHIT.."1) "..L["Short John Mithril"] },
		{ WHIT.."2) "..L["Stone Guard Towhide"] },
	},
	-- The Rumble Cage
	RumbleCage_Arena = {
		ZoneName = { BZ["The Rumble Cage"] },
		Location = { BZ["Gadgetzan"]..ALC["Comma"]..BZ["Tanaris"]..ALC["Comma"]..BZ["Kalimdor"] },
		LevelRange = "47-50 ("..L["Quests"]..")",
		{ BLUE..BZ["The Rumble Cage"] },
		{ "" },
		{ WHIT.."1) "..L["Dr. Dealwell"] },
		{ WHIT.."2) "..L["Katrina Turner"] },
		{ WHIT.."3) "..L["Vixton Pinchwhistle <Legacy Arena Armor>"] }, 
		{ WHIT.."4) "..L["Blazzek the Biter <Legacy Arena Weapons>"] },
		{ WHIT.."5) "..L["Evee Copperspring <Arena Vendor>"] },
		{ WHIT.."6) "..L["Ecton Brasstumbler <Arena Vendor>"] },
	},
	-- The Crucible of Carnage
	CrucibleofCarnage_Arena = {
		ZoneName = { BZ["Crucible of Carnage"] },
		Location = { BZ["Twilight Highlands"]..ALC["Comma"]..BZ["Eastern Kingdoms"] },
		LevelRange = "84-85 ("..L["Quests"]..")",
		PlayerLimit = "5",
		{ BLUE..BZ["Crucible of Carnage"] },
		{ "" },
		{ WHIT.."1) "..L["Gurgthock <Fight Promoter>"] },
		{ WHIT.."2) "..L["Wodin the Troll-Servant"] },
	},
	-- Valhalas
	Valhalas_Arena = {
		ZoneName = { BZ["Valhalas"] },
		Location = { BZ["Icecrown"]..ALC["Comma"]..BZ["Northrend"] },
		LevelRange = "77-80 ("..L["Quests"]..")",
		PlayerLimit = "5",
		{ BLUE..BZ["Valhalas"] },
		{ "" },
		{ WHIT.."1) "..L["Geirrvif"] },
		{ WHIT.."2) "..L["Gjonner the Merciless"] },
	},
	-- Amphitheater of Anguish
	AmphitheaterofAnguish_Arena = {
		ZoneName = { BZ["Amphitheater of Anguish"] },
		Location = { BZ["Zul'Drak"]..ALC["Comma"]..BZ["Outland"] },
		LevelRange = "75-80 ("..L["Quests"]..")",
		PlayerLimit = "5",
		{ BLUE..BZ["Amphitheater of Anguish"] },
		{ "" },
		{ GREN.."1) "..L["Gurgthock <Fight Promoter>"] },
		{ GREN.."2) "..L["Wodin the Troll-Servant"] },
		{ "" },
		{ WHIT.."1) "..L["Yggdras"] },
		{ WHIT..INDENT..L["Stinkbeard"] },
		{ WHIT..INDENT..L["Elemental Lord"] },
		{ WHIT..INDENT..INDENT..L["Az'Barin, Prince of the Gust"] },
		{ WHIT..INDENT..INDENT..L["Duke Singen <The New Hotness>"] },
		{ WHIT..INDENT..INDENT..L["Erathius, King of Dirt"] },
		{ WHIT..INDENT..INDENT..L["Gargoral the Water Lord"] },
		{ WHIT..INDENT..L["Orinoko Tuskbreaker"] },
		{ WHIT..INDENT..L["Korrak the Bloodrager <Champion of the Winterax>"] },
		{ WHIT..INDENT..L["Vladof the Butcher"] },
	},
	-- Tol'Viron Arena
	TolViron = {
		ZoneName = { BZ["Tol'viron Arena"] },
		Location = { BZ["Uldum"]..ALC["Comma"]..BZ["Kalimdor"] },
		LevelRange = "90-110 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE.."A) "..L["Start"] },
	},
	-- The Tiger's Peak
	TigersPeak = {
		ZoneName = { BZ["The Tiger's Peak"] },
		Location = { BZ["Shado-Pan Monastery"]..ALC["Comma"]..BZ["Kun-Lai Summit"] },
		LevelRange = "90-110 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE.."A) "..L["Start"] },
	},
	-- Black Rook Hold Arena
	BlackRookHoldArena = {
		ZoneName = { BZ["Black Rook Hold Arena"] },
		Location = { BZ["Val'sharah"]..ALC["Comma"]..BZ["Broken Isles"] },
		LevelRange = "90-110 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE.."A) "..L["Start"] },
	},
	-- Ashamane's Fall
	AshamanesFall = {
		ZoneName = { BZ["Ashamane's Fall"] },
		Location = { BZ["Val'sharah"]..ALC["Comma"]..BZ["Broken Isles"] },
		LevelRange = "90-110 (PvP)",
		PlayerLimit = "2v2, 3v3, 5v5",
		{ BLUE.."A) "..L["Start"] },
	},
}

Atlas:RegisterPlugin("Atlas_Arena", myCategory, myData)
