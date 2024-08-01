-- $Id: Atlas_Scenarios.lua 53 2018-08-08 17:27:31Z arith $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2012 ~ 2018 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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
local _G = getfenv(0)
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")

local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Atlas_Scenarios")
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local ALIL = Atlas_IngameLocales

local BLUE = "|cff6666ff"
local GREN = "|cff66cc33"
local _RED = "|cffcc3333"
local ORNG = "|cffcc9933"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local CYAN = "|cff00ffff"
local GREY = "|cff999999"
local YELL = "|cffcccc00"
local INDENT = "      "

local myCategory = L["Scenarios Maps"]

local function Atlas_GetAchievementName(achievementID, eng_desc)
	local _, name = GetAchievementInfo(achievementID)

	if (name) then
		return name
	else
		return eng_desc
	end
end

local function Atlas_GetAchievementDesc(achievementID, eng_desc)
	local _, _, _, _, _, _, _, description = GetAchievementInfo(achievementID)

	if (description) then
		return description
	else
		return eng_desc
	end
end

local Scenario = LibStub:GetLibrary("Lib-Scenarios") 

local function Atlas_GetScenarioNameByID(scID)
	return Scenario:GetScenarioNameByID(scID)
end

local function Atlas_GetScenarioStepNameByID(scID, stID, isfinal)
	if (not (scID and stID)) then return end
	if (isfinal) then
		return L["Final Stage"]..ALC["Hyphen"]..Scenario:GetScenarioStepNameByID(scID, stID)
	else
		return format(L["Stage %d"], stID)..ALC["Hyphen"]..Scenario:GetScenarioStepNameByID(scID, stID)
	end
end

local function Atlas_GetScenarioStepDescByID(scID, stID)
	return Scenario:GetScenarioStepDescByID(scID, stID)
end

local SN = Atlas_GetScenarioNameByID
local SS = Atlas_GetScenarioStepNameByID
local SD = Atlas_GetScenarioStepDescByID

local myData = {
--************************************************
-- Scenarios
--************************************************
	SC_ABrewingStorm = {
		ZoneName = { SN(65) }, -- A Brewing Storm
		Location = { BZ["Thunderpaw Overlook"]..ALC["Comma"]..BZ["The Jade Forest"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..BZ["Thunderpaw Overlook"]..ALC["Hyphen"]..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(65, 1) },
		{ INDENT..INDENT..GREY..SD(65, 1) },
		{ INDENT..YELL.."- "..SS(65, 2) },
		{ INDENT..INDENT..GREY..SD(65, 2) },
		{ BLUE.." B) "..BZ["Thunderpaw Refuge"]..ALC["Hyphen"]..ALC["End"] },
		{ INDENT..YELL.."- "..SS(65, 3, true) },
		{ INDENT..INDENT..GREY..SD(65, 3) },
	},
	SC_ALittlePatience = {
		ZoneName = { SN(183) }, -- A Little Patience
		Location = { BZ["The Deepwild"]..ALC["Comma"]..BZ["Krasarang Wilds"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(183, 1) },
		{ INDENT..INDENT..GREY..SD(183, 1) },
		{ INDENT..BLUE.." B) "..L["Traps"] },
		{ BLUE.." C) "..L["Commander Scargash"] },
		{ INDENT..YELL.."- "..SS(183, 2, true) },
		{ INDENT..INDENT..GREY..SD(183, 2) },
	}, 
	SC_ArenaOfAnnihilation = {
		ZoneName = { SN(58) }, -- Arena of Annihilation
		Location = { BZ["Temple of the White Tiger"]..ALC["Comma"]..BZ["Kun-Lai Summit"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Summon"] },
		{ INDENT..YELL.."- "..SS(58, 1) },
		{ INDENT..INDENT..GREY..SD(58, 1) },
		{ INDENT..YELL.."- "..SS(58, 2) },
		{ INDENT..INDENT..GREY..SD(58, 2) },
		{ INDENT..YELL.."- "..SS(58, 3) },
		{ INDENT..INDENT..GREY..SD(58, 3) },
		{ INDENT..YELL.."- "..SS(58, 4) },
		{ INDENT..INDENT..GREY..SD(58, 4) },
		{ INDENT..YELL.."- "..SS(58, 5, true)..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ INDENT..INDENT..GREY..SD(58, 5) },
		{ INDENT..INDENT..YELL..L["Defeat Maki Waterblade"] },
		{ INDENT..INDENT..YELL..L["Defeat Satay Byu"] },
		{ INDENT..INDENT..YELL..L["Defeat Cloudbender Kobo"] },
	},
	SC_AssaultonZanvess = {
		ZoneName = { SN(181) },  -- Assault on Zan'vess, alsi in ID 203
		Location = { BZ["Zan'vess"]..ALC["Comma"]..BZ["Dread Wastes"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.."A) "..ALC["Start"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ BLUE.."B) "..ALC["Start"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ YELL.."- "..SS(181, 1) },
		{ INDENT..GREY..SD(181, 1) },
		{ YELL.."- "..SS(181, 2) },
		{ BLUE.."C) "..L["Kyparite Quarry Sonic Control Towers"] },
		{ BLUE.."D) "..L["Whispering Stones Sonic Control Towers"] },
		{ BLUE.."E) "..L["Venomsting Pits Sonic Control Towers"] },
		{ INDENT..GREY..SD(181, 2) },
		{ BLUE.."F) "..L["Landing"] },
		{ YELL.."- "..SS(181, 3) },
		{ INDENT..GREY..SD(181, 3) },
		{ INDENT..WHIT.."1) "..L["Squad Leader Bosh"] },
		{ BLUE.."G) "..BZ["Heart of Zan'vess"] },
		{ YELL.."- "..SS(181, 4, true) },
		{ INDENT..GREY..SD(181, 4) },
		{ INDENT..WHIT.."- "..L["Commander Tel'vrak"] },
	},
	SC_BattleontheHighSeasAlliance = {
		ZoneName = { SN(182)..ALC["Hyphen"]..FACTION_ALLIANCE }, -- Battle on the High Seas
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(182, 1) },
		{ INDENT..INDENT..GREY..SD(182, 1) },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Drak'on"] },
		{ INDENT..BLUE.."B) "..L["Transport Cannon"] },
		{ BLUE.." C) "..L["Rope Pile"] },
		{ BLUE.." D) "..L["Steal Explosives"] },
		{ INDENT..YELL.."- "..SS(182, 2) },
		{ INDENT..INDENT..GREY..SD(182, 2) },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Sparklighter"] },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Fizzel"] },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Blasthammer"] },
		{ INDENT..YELL.."- "..SS(182, 3) },
		{ INDENT..INDENT..GREY..SD(182, 3) },
		{ INDENT..INDENT.._RED..L["Run to the top deck and swing away!"] },
		{ INDENT..BLUE.."E) "..L["Rope Pile"] },
		{ INDENT..BLUE.."F) "..L["Transport Cannon"] },
		{ BLUE.." G) "..L["Admiral Hagman"] },
		{ INDENT..YELL.."- "..SS(182, 4, true) },
		{ INDENT..INDENT..GREY..SD(182, 4) },
		{ INDENT..INDENT.."- "..L["Admiral Hagman"] },
	},
	SC_BattleontheHighSeasHorde = {
		ZoneName = { SN(239)..ALC["Hyphen"]..FACTION_HORDE }, -- Battle on the High Seas
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(239, 1) },
		{ INDENT..INDENT..GREY..SD(239, 1) },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Parker"] },
		{ INDENT..BLUE.."B) "..L["Transport Cannon"] },
		{ BLUE.." C) "..L["Rope Pile"] },
		{ BLUE.." D) "..L["Steal Explosives"] },
		{ INDENT..YELL.."- "..SS(239, 2) },
		{ INDENT..INDENT..GREY..SD(239, 2) },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Fuseblast"] },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Fizzboil"] },
		{ INDENT..INDENT..WHIT.."- "..L["Lieutenant Boltblaster"] },
		{ INDENT..YELL.."- "..SS(239, 3) },
		{ INDENT..INDENT..GREY..SD(239, 3) },
		{ INDENT..INDENT.._RED..L["Run to the top deck and swing away!"] },
		{ INDENT..BLUE.."E) "..L["Rope Pile"] },
		{ INDENT..BLUE.."F) "..L["Transport Cannon"] },
		{ BLUE.." G) "..L["Admiral Hodgson"] },
		{ INDENT..YELL.."- "..SS(239, 4, true) },
		{ INDENT..INDENT..GREY..SD(239, 4) },
		{ INDENT..INDENT.."- "..L["Admiral Hodgson"] },
	},
	SC_BloodintheSnow = {
		ZoneName = { SN(210) }, -- Blood in the Snow
		Location = { BZ["Shimmer Ridge"]..ALC["Comma"]..BZ["Dun Morogh"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ YELL.."- "..SS(210, 1) },
		{ INDENT..GREY..SD(210, 1) },
		{ INDENT..GREN.."1) "..L["Dark Iron Mountaineers"] },
		{ YELL.."- "..SS(210, 2) },
		{ INDENT..GREY..SD(210, 2) },
		{ INDENT..GREN.."2) "..L["Scout Stonebeard"] },
		{ YELL.."- "..SS(210, 3) },
		{ INDENT..GREY..SD(210, 3) },
		{ INDENT..GREN.."3) "..L["Scout Boldbrew"] },
		{ YELL.."- "..SS(210, 4) },
		{ INDENT..GREY..SD(210, 4) },
		{ INDENT..GREN.."4) "..L["Scout Forgefellow"] },
		{ YELL.."- "..SS(210, 5) },
		{ INDENT..GREY..SD(210, 5) },
		{ INDENT..WHIT.."1) "..L["Farastu"] },
		{ YELL.."- "..SS(210, 6, true) },
		{ INDENT..GREY..SD(210, 6) },
		{ INDENT..WHIT.."2) "..L["Hekima the Wise"] },
	},
	SC_BrewmoonFestival = {
		ZoneName = { SN(63) }, -- Brewmoon Festival
		Location = { BZ["Binan Village"]..ALC["Comma"]..BZ["Kun-Lai Summit"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(63, 1) },
		{ INDENT..INDENT..GREY..SD(63, 1) },
		{ INDENT..INDENT..WHIT.." 1) "..L["Den Mother Moof"] },
		{ INDENT..INDENT..WHIT.." 2) "..L["Li Te"] },
		{ INDENT..INDENT..WHIT.." 3) "..L["Karsar the Bloodletter"] },
		{ INDENT..INDENT..GREN.." 4) "..L["Brewmaster Boof"] },
		{ BLUE.." B) "..L["Defence Point"] },
		{ INDENT..YELL.."- "..SS(63, 2) },
		{ INDENT..INDENT..GREY..SD(63, 2) },
		{ INDENT..YELL.."- "..SS(63, 3) },
		{ INDENT..INDENT..GREY..SD(63, 3) },
		{ BLUE.." C) "..L["Final Stage"] },
		{ INDENT..YELL.."- "..SS(63, 4, true) },
		{ INDENT..INDENT..GREY..SD(63, 4) },
	},
	SC_CryptofForgottenKings = {
		ZoneName = { SN(39) }, -- Crypt of Forgotten Kings
		Location = { BZ["Guo-Lai Halls"]..ALC["Comma"]..BZ["Vale of Eternal Blossoms"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(39, 1) },
		{ INDENT..INDENT..GREY..SD(39, 1) },
		{ INDENT..INDENT..WHIT.." 1) "..L["Jin Ironfist"] },
		{ BLUE.." B) "..L["Pool of Life"] },
		{ INDENT..YELL.."- "..SS(39, 2) },
		{ INDENT..INDENT..GREY..SD(39, 2) },
		{ BLUE.." C) "..L["Treasure Urn"] },
		{ BLUE.." D) "..ALC["Connection"] },
		{ INDENT..YELL.."- "..SS(39, 3) },
		{ INDENT..INDENT..GREY..SD(39, 3) },
		{ INDENT..YELL.."- "..SS(39, 4, true) },
		{ INDENT..INDENT..GREY..SD(39, 4) },
		{ INDENT..INDENT..WHIT.." 2) "..L["Abomination of Anger"] },
	},
	SC_DaggerintheDark = {
		ZoneName = { SN(179) }, -- Dagger in the Dark
		Location = { BZ["The Veiled Stair"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.."A) "..ALC["Start"] },
		{ YELL.."- "..SS(179, 1) },
		{ INDENT..GREY..SD(179, 1) },
		{ INDENT..GREN.."- "..L["Vol'jin"] },
		{ BLUE.."B) "..L["Saurok Cave"] },
		{ YELL.."- "..SS(179, 2) },
		{ INDENT..GREY..SD(179, 2) },
		{ YELL.."- "..SS(179, 3) },
		{ INDENT..GREY..SD(179, 3) },
		{ INDENT..WHIT.."1) "..L["Darkhatched Lizard-Lord"] },
		{ BLUE.."C) "..L["Cave"] },
		{ YELL.."- "..SS(179, 4) },
		{ INDENT..GREY..SD(179, 4) },
		{ INDENT..GREN.."1') "..L["The Spring Drifter"] },
		{ INDENT..BLUE.."D) "..L["Docking"] },
		{ BLUE.."E) "..L["Saurok Hatchery"] },
		{ YELL.."- "..SS(179, 5) },
		{ INDENT..GREY..SD(179, 5) },
		{ YELL.."- "..SS(179, 6) },
		{ INDENT..GREY..SD(179, 6) },
		{ INDENT..WHIT.."2) "..L["Broodmaster Noshi"] },
		{ YELL.."- "..SS(179, 7) },
		{ INDENT..GREY..SD(179, 7) },
		{ INDENT..GREN.."2') "..L["West Statue"] },
		{ INDENT..GREN.."3') "..L["East Statue"] },
		{ YELL.."- "..SS(179, 8, true) },
		{ INDENT..GREY..SD(179, 8) },
		{ INDENT..WHIT.."2) "..L["Rak'gor Bloodrazor"] },
	},
	SC_DarkHeartofPandaria = {
		ZoneName = { SN(216) }, -- Dark Heart of Pandaria
		Location = { BZ["Big Blossom Excavation"]..ALC["Comma"]..BZ["Vale of Eternal Blossoms"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.."A) "..ALC["Start"] },
		{ YELL.."- "..SS(216, 1) },
		{ INDENT..GREY..SD(216, 1) },
		{ INDENT..GREN.."1) "..L["Grizzle Gearslip"] },
		{ YELL.."- "..SS(216, 2) },
		{ INDENT..GREY..SD(216, 2) },
		{ INDENT..WHIT.."1) "..L["Urtharges the Destroyer"]..ALC["L-Parenthesis"]..ALC["Wanders"] },
		{ YELL.."- "..SS(216, 3) },
		{ INDENT..GREY..SD(216, 3) },
		{ BLUE.."B) "..ALC["Tunnel"] },
		{ YELL.."- "..SS(216, 4) },
		{ INDENT..GREY..SD(216, 4) },
		{ INDENT..GREN.."2) "..L["Crafty the Ambitious"] },
		{ YELL.."- "..SS(216, 5, true) },
		{ INDENT..GREY..SD(216, 5) },
		{ INDENT..WHIT.."2) "..L["Echo of Y'Sharrj"] },
		{ INDENT..GREN.."3) "..L["Norushen"] },
	},
	SC_DominationPoint = {
		ZoneName = { SN(201) }, -- Domination Point
		Location = { BZ["Krasarang Wilds"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.."A) "..ALC["Start"] },
		{ YELL.."- "..SS(201, 1) },
		{ INDENT..GREY..SD(201, 1) },
		{ YELL.."- "..SS(201, 2) },
		{ INDENT..GREY..SD(201, 2) },
		{ INDENT..GREN.."1) "..L["General Nazgrim"] },
		{ YELL.."- "..SS(201, 3) },
		{ INDENT..GREY..SD(201, 3) },
		{ INDENT..BLUE.."B) "..L["Attackers"] },
		{ YELL.."- "..SS(201, 4) },
		{ INDENT..GREY..SD(201, 4) },
		{ INDENT..GREN.."- "..L["Warlord Bloodhilt"] },
		{ INDENT..WHIT.."- "..L["Cordfellow Hack"] },
		{ YELL.."- "..SS(201, 5) },
		{ INDENT..GREY..SD(201, 5) },
		{ INDENT..GREN.."2) "..L["Rivett Clutchpop"] },
		{ INDENT..GREN.."3) "..L["Shademaster Kiryn"] },
		{ INDENT..GREN.."4) "..L["Shokia"] },
		{ YELL.."- "..SS(201, 6) },
		{ INDENT..GREY..SD(201, 6) },
		{ INDENT..BLUE.."C) "..L["Weapons"] },
		{ YELL.."- "..SS(201, 7, true) },
		{ INDENT..GREY..SD(201, 7) },
		{ INDENT..WHIT.."- "..L["Wave One"] },
		{ INDENT..WHIT.."- "..L["Wave Two"] },
		{ INDENT..WHIT.."- "..L["Wave Three"] },
		{ INDENT..WHIT.."- "..L["Joan Lorraine"] },
	},
	SC_GreenstoneVillage = {
		ZoneName = { SN(40) }, -- Greenstone Village
		Location = { BZ["Greenstone Village"]..ALC["Comma"]..BZ["The Jade Forest"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(40, 1) },
		{ INDENT..INDENT..GREY..SD(40, 1) },
		{ BLUE.." B) "..BZ["Greenstone Dojo"] },
		{ INDENT..YELL.."- "..SS(40, 2) },
		{ INDENT..INDENT..GREY..SD(40, 2) },
		{ INDENT..YELL.."- "..SS(40, 3) },
		{ INDENT..INDENT..GREY..SD(40, 3) },
		{ BLUE.." C) "..BZ["Greenstone Masons' Quarter"] },
		{ INDENT..YELL.."- "..SS(40, 4) },
		{ INDENT..INDENT..GREY..SD(40, 4) },
		{ INDENT..YELL.."- "..SS(40, 5, true) },
		{ INDENT..INDENT..GREY..SD(40, 5) },
	},
	SC_LionsLanding = {
		ZoneName = { SN(184) }, -- Lion's Landing
		Location = { BZ["Krasarang Cove"]..ALC["Comma"]..BZ["Krasarang Wilds"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ YELL.."- "..SS(184, 1) },
		{ INDENT..GREY..SD(184, 1) },
		{ INDENT..GREN.."1) "..L["Daggin Windbeard"] },
		{ YELL.."- "..SS(184, 2) },
		{ INDENT..GREY..SD(184, 2) },
		{ INDENT..GREN.."2) "..L["Admiral Taylor"] },
		{ YELL.."- "..SS(184, 3) },
		{ INDENT..GREY..SD(184, 3) },
		{ INDENT..BLUE.."B) "..L["Attackers"] },
		{ YELL.."- "..SS(184, 4) },
		{ INDENT..GREY..SD(184, 4) },
		{ INDENT..GREN.."3) "..L["High Marshal Twinbraid"] },
		{ INDENT..WHIT.."- "..L["Wolf-Rider Gaja"] },
		{ YELL.."- "..SS(184, 5) },
		{ INDENT..GREY..SD(184, 5) },
		{ INDENT..GREN.."4) "..L["Amber Kearnen"] },
		{ INDENT..GREN.."5) "..L["Sully \"The Pickle\" McLeary"] },
		{ INDENT..GREN.."6) "..L["Mishka"] },
		{ YELL.."- "..SS(184, 6) },
		{ INDENT..GREY..SD(184, 6) },
		{ INDENT..BLUE.."C) "..L["Weapons"] },
		{ YELL.."- "..SS(184, 7, true) },
		{ INDENT..GREY..SD(184, 7) },
		{ INDENT..WHIT.."- "..L["Wave One"] },
		{ INDENT..WHIT.."- "..L["Wave Two"] },
		{ INDENT..WHIT.."- "..L["Wave Three"] },
		{ INDENT..WHIT.."- "..L["Thaumaturge Saresse"] },
	},
	SC_TheSecretsofRagefire = {
		ZoneName = { SN(219) }, -- The Secrets of Ragefire
		Location = { BZ["Ragefire Chasm"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ YELL.."- "..SS(219, 1) },
		{ INDENT..GREY..SD(219, 1) },
		{ INDENT..BLUE.."B) "..L["Door"] },
		{ INDENT..WHIT.."1) "..L["Dark Shaman Xorenth"] },
		{ YELL.."- "..SS(219, 2) },
		{ INDENT..GREY..SD(219, 2) },
		{ INDENT..GREN.."1) "..L["Supply Crates"] },
		{ INDENT..GREN.."2) "..L["Proto-drake Eggs"] },
		{ INDENT..GREN.."3) "..L["Pandaria Artifacts"] },
		{ YELL.."- "..SS(219, 3) },
		{ INDENT..GREY..SD(219, 3) },
		{ INDENT..BLUE.."C) "..L["Sealed Gate"] },
		{ INDENT..GREN.."1) "..L["Battery"]..ALC["Comma"]..L["Pool Pony"] },
		{ INDENT..GREN.."2) "..L["Broken Proto-Drake Egg"] },
		{ INDENT..GREN.."3) "..L["Cannon Balls"] },
		{ YELL.."- "..SS(219, 4, true) },
		{ INDENT..GREY..SD(219, 4) },
		{ INDENT..WHIT.."1) "..L["Flame Hound"] },
		{ INDENT..INDENT..WHIT..L["Kor'kron Dire Soldier"] },
		{ INDENT..INDENT..WHIT..L["Overseer Elaglo"] },
	},
	SC_TheramoresFallAlliance = {
		ZoneName = { SN(71)..ALC["Hyphen"]..FACTION_ALLIANCE }, -- Theramore's Fall
		Location = { BZ["Theramore"]..ALC["Comma"]..BZ["Dustwallow Marsh"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(71, 1) },
		{ INDENT..INDENT..GREY..SD(71, 1) },
		{ BLUE.." B) "..L["Horde Ships"] },
		{ INDENT..YELL.."- "..SS(71, 2) },
		{ INDENT..INDENT..GREY..SD(71, 2) },
		{ BLUE.." C) "..L["The heart of ruined Theramore"] },
		{ INDENT..YELL.."- "..SS(71, 3) },
		{ INDENT..INDENT..GREY..SD(71, 3) },
		{ BLUE.." D) "..L["Jaina"] },
		{ INDENT..YELL.."- "..SS(71, 4) },
		{ INDENT..INDENT..GREY..SD(71, 4) },
		{ BLUE.." E) "..L["West Gate"] },
		{ INDENT..YELL.."- "..SS(71, 5) },
		{ INDENT..INDENT..GREY..SD(71, 5) },
		{ BLUE.." D) "..L["Jaina"] },
		{ INDENT..YELL.."- "..SS(71, 6, true) },
		{ INDENT..INDENT..GREY..SD(71, 6) },
	},
	SC_TheramoresFallHorde = {
		ZoneName = { SN(72)..ALC["Hyphen"]..FACTION_HORDE }, -- Theramore's Fall
		Location = { BZ["Theramore"]..ALC["Comma"]..BZ["Dustwallow Marsh"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ BLUE.." B) "..L["Alliance Ships"] },
		{ INDENT..YELL.."- "..SS(72, 1) },
		{ INDENT..INDENT..GREY..SD(72, 1) },
		{ GREN.." C) "..L["The Blastmaster"] },
		{ INDENT..YELL.."- "..SS(72, 2) },
		{ INDENT..INDENT..GREY..SD(72, 2) },
		{ BLUE.." D) "..L["Baldruc and Gryphon"] },
		{ INDENT..YELL.."- "..SS(72, 3) },
		{ INDENT..INDENT..GREY..SD(72, 3) },
		{ BLUE.." E) "..L["Tanks"] },
		{ INDENT..YELL.."- "..SS(72, 4) },
		{ INDENT..INDENT..GREY..SD(72, 4) },
		{ BLUE.." F) "..L["Thalen Songweaver"] },
		{ INDENT..YELL.."- "..SS(72, 5, true) },
		{ INDENT..INDENT..GREY..SD(72, 5) },
	},
	SC_TrovesoftheThunderKing = {
		ZoneName = { SN(215) }, -- Troves of the Thunder King
		Location = { BZ["Thunder King's Citadel"]..ALC["Comma"]..BZ["Isle of Thunder"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "1",
		{ ORNG..ALC["Key"]..ALC["Colon"]..ALIL["Key to the Palace of Lei Shen"] },
		{ ORNG..ALC["Key"]..ALC["Colon"]..ALIL["Burial Trove Key"] },
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(215, 1) },
		{ INDENT..INDENT..GREY..SD(215, 1) },
		{ INDENT..YELL.."- "..SS(215, 2, true) },
		{ INDENT..INDENT..GREY..SD(215, 2) },
		{ INDENT..INDENT..WHIT.." 1) "..L["God-Hulk Gulkan"] },
		{ INDENT..INDENT..GREN.." 1') "..L["Lever"] },
		{ INDENT..INDENT..GREN.." 2') "..L["Tenwu of the Red Smoke"] },
	},
	SC_UngaIngoo = {
		ZoneName = { SN(15) }, -- Unga Ingoo
		Location = { BZ["Unga Ingoo"]..ALC["Comma"]..BZ["Krasarang Wilds"] },
		LevelRange = "90",
		MinLevel = "90",
		PlayerLimit = "3",
		{ BLUE.." A) "..ALC["Start"] },
		{ INDENT..YELL.."- "..SS(15, 1) },
		{ INDENT..INDENT..GREY..SD(15, 1) },
		{ BLUE.." B) "..L["Brewing Cauldron"]..ALC["Slash"]..ALC["End"] },
		{ INDENT..YELL.."- "..SS(15, 2) },
		{ INDENT..INDENT..GREY..SD(15, 2) },
		{ INDENT..YELL.."- "..SS(15, 3, true) },
		{ INDENT..INDENT..GREY..SD(15, 3) },
	},
	SC_BrokenShore = {
		ZoneName = { GREN..SN(786) }, -- The Battle for Broken Shore, ID: 786 (Alliance) and 1189 (Horde)
		Location = { BZ["Broken Isles"] },
		LevelRange = "100",
		MinLevel = "100",
		--WorldMapID = 858,
		LargeMap = "SC_BrokenShore",
		{ YELL.."- "..SS(786, 1) },
		{ INDENT..GREY..SD(786, 1) },
		{ INDENT..BLUE.." A) "..L["Alliance Ships"], 10001 },
		{ INDENT..BLUE.." B) "..L["Horde Ships"], 10002 },
		{ BLUE.." C) "..L["Beach"], 10003 },
		{ INDENT..YELL.."- "..SS(786, 2) },
		{ INDENT..INDENT..GREY..SD(786, 2) },
		{ INDENT..INDENT..INDENT..GREY..L["33 Deamons slain"] },
		{ INDENT..INDENT..INDENT..GREY..L["3 Lords slain"] },
		{ INDENT..INDENT..INDENT..GREY..L["3 Spires of Woe destroyed"] },
		{ INDENT..YELL.."- "..SS(786, 3) },
		{ INDENT..INDENT..GREY..SD(786, 3)..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ INDENT..INDENT..GREY..SD(1189, 3)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ YELL.."- "..SS(786, 4)..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ INDENT..GREY..SD(786, 4) },
		{ INDENT..GREN.." 1) "..L["King Varian Wrynn"], 10004 },
		{ YELL.."- "..SS(1189, 4)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ INDENT..GREY..SD(1189,4 ) },
		{ INDENT..GREN.." 2) "..L["Sylvanas and Baine"], 10005 },
		{ YELL.."- "..SS(786, 5) },
		{ INDENT..GREY..SD(786, 5) },
		{ INDENT..BLUE.." D) "..L["Portal"], 10006 },
		{ YELL.."- "..SS(786, 6) },
		{ INDENT..GREY..SD(786, 6) },
		{ INDENT..BLUE.." E) "..BZ["The Black City"], 10007 },
		{ BLUE.." F) "..BZ["Tomb Approach"], 10008 },
		{ INDENT..YELL.."- "..SS(786, 7) },
		{ INDENT..INDENT..GREY..SD(786, 7) },
		{ INDENT..INDENT..GREN.." 3) "..L["Highlord Tirion Fordring"], 10009 },
		{ INDENT..YELL.."- "..SS(786, 8) },
		{ INDENT..INDENT..GREY..SD(786, 8) },
		{ INDENT..INDENT.._RED.." 1) "..L["Krosus"], 10010 },
		{ YELL.."- "..SS(786, 9, true)..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ INDENT..GREY..SD(786, 9) },
		{ INDENT..BLUE.." G) "..L["Alliance's final stop"], 10011 },
		{ INDENT.._RED.." 2) "..L["Gul'dan"], 10012 },
		{ YELL.."- "..SS(1189, 9, true)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ INDENT..GREY..SD(1189, 9) },
		{ INDENT..BLUE.." H) "..L["Horde's final stop"], 10013 },
		{ "" },
	},
	SC_Demon_Invasion = {
		ZoneName = { L["Demon Invasion"] },
		Location = { BZ["Eastern Kingdoms"]..ALC["Slash"]..BZ["Kalimdor"] },
		{ ORNG..ACHIEVEMENTS..ALC["Colon"] },
		{ GREN..Atlas_GetAchievementName(11200, "Stand Against the Legion") },
		{ INDENT..GREY..Atlas_GetAchievementDesc(11200, "Defend against the Burning Legion by completing an invasion during the Legion pre-launch events.") },
		{ GREN..Atlas_GetAchievementName(11201, "Defender of Azeroth: Legion Invasions") },
		{ INDENT..GREY..Atlas_GetAchievementDesc(11201, "Defend against each of the Legion's assaults on Azeroth during the Legion pre-launch events.") },
		{ "" },
		{ WHIT.." 1) "..BZ["Azshara"] },
		{ YELL..SN(958) }, -- Invasion: Azshara
		{ INDENT..YELL..SS(958, 1) },
		{ INDENT..INDENT..GREY..SD(958, 1) },
		{ INDENT..YELL..SS(958, 2) },
		{ INDENT..INDENT..GREY..SD(958, 2) },
		{ INDENT..YELL..SS(958, 3) },
		{ INDENT..INDENT..GREY..SD(958, 3) },
		{ INDENT..YELL..SS(958, 4, true) },
		{ INDENT..INDENT..GREY..SD(958, 4) },
		{ "" },
		{ WHIT.." 2) "..BZ["Northern Barrens"] },
		{ YELL..SN(907) }, -- Invasion: Northern Barrens
		{ INDENT..YELL..SS(907, 1) },
		{ INDENT..INDENT..GREY..SD(907, 1) },
		{ INDENT..YELL..SS(907, 2) },
		{ INDENT..INDENT..GREY..SD(907, 2) },
		{ INDENT..YELL..SS(907, 3) },
		{ INDENT..INDENT..GREY..SD(907, 3) },
		{ INDENT..YELL..SS(907, 4, true) },
		{ INDENT..INDENT..GREY..SD(907, 4) },
		{ "" },
		{ WHIT.." 3) "..BZ["Tanaris"] },
		{ YELL..SN(806) }, -- Invasion: Tanaris
		{ INDENT..YELL..SS(806, 1) },
		{ INDENT..INDENT..GREY..SD(806, 1) },
		{ INDENT..YELL..SS(806, 2) },
		{ INDENT..INDENT..GREY..SD(806, 2) },
		{ INDENT..YELL..SS(806, 3) },
		{ INDENT..INDENT..GREY..SD(806, 3) },
		{ INDENT..YELL..SS(806, 4, true) },
		{ INDENT..INDENT..GREY..SD(806, 4) },
		{ "" },
		{ WHIT.." 4) "..BZ["Hillsbrad Foothills"] },
		{ YELL..SN(916) }, -- Invasion: Hillsbrad Foothills
		{ INDENT..YELL..SS(916, 1) },
		{ INDENT..INDENT..GREY..SD(916, 1) },
		{ INDENT..YELL..SS(916, 2) },
		{ INDENT..INDENT..GREY..SD(916, 2) },
		{ INDENT..YELL..SS(916, 3) },
		{ INDENT..INDENT..GREY..SD(916, 3) },
		{ INDENT..YELL..SS(916, 4, true) },
		{ INDENT..INDENT..GREY..SD(916, 4) },
		{ "" },
		{ WHIT.." 5) "..BZ["Dun Morogh"] },
		{ YELL..SN(959) }, -- Invasion: Dun Morogh
		{ INDENT..YELL..SS(959, 1) },
		{ INDENT..INDENT..GREY..SD(959, 1) },
		{ INDENT..YELL..SS(959, 2) },
		{ INDENT..INDENT..GREY..SD(959, 2) },
		{ INDENT..YELL..SS(959, 3) },
		{ INDENT..INDENT..GREY..SD(959, 3) },
		{ INDENT..YELL..SS(959, 4, true) },
		{ INDENT..INDENT..GREY..SD(959, 4) },
		{ "" },
		{ WHIT.." 6) "..BZ["Westfall"] },
		{ YELL..SN(897) }, -- Invasion: Westfall
		{ INDENT..YELL..SS(897, 1) },
		{ INDENT..INDENT..GREY..SD(897, 1) },
		{ INDENT..YELL..SS(897, 2) },
		{ INDENT..INDENT..GREY..SD(897, 2) },
		{ INDENT..YELL..SS(897, 3) },
		{ INDENT..INDENT..GREY..SD(897, 3) },
		{ INDENT..YELL..SS(897, 4, true) },
		{ INDENT..INDENT..GREY..SD(897, 4) },
	},
	SC_AssaultonBrokenShore = {
		ZoneName = { GREN..SN(1280) }, -- The Assault on Broken Shore
		Location = { BZ["Broken Shore"]..ALC["Comma"]..BZ["Broken Isles"] },
		LevelRange = "110",
		MinLevel = "110",
		WorldMapID = 858,
		LargeMap = "SC_AssaultonBrokenShore",
		{ YELL.."- "..SS(1280, 1) }, -- Into the Fray
		{ INDENT..GREY..SD(1280, 1) }, -- Reach the Broken Shore
		{ INDENT..BLUE.." A) "..L["Landing point"], 10001 },
		{ YELL.."- "..SS(1280, 2) }, -- Vanguard of the Assault
		{ INDENT..GREY..SD(1280, 2) }, -- Secure the beach
		{ YELL.."- "..SS(1280, 3) }, -- Might of the Legion
		{ INDENT..GREY..SD(1280, 3) }, -- Defeat Lord Kalgorath
		{ INDENT..WHIT.." 1) "..L["Lord Kalgorath"], 116291 },
		{ YELL.."- "..SS(1280, 4) }, -- Rifts of Chaos
		{ INDENT..GREY..SD(1280, 4) }, -- Close the portals and defeat Dread Commander Arganoth's forces
		{ INDENT..BLUE.." B) "..L["Stage area"], 10002 },
		{ YELL.."- "..SS(1280, 5) }, -- The Doomguard's Command
		{ INDENT..GREY..SD(1280, 5) }, -- Defeat Dread Commander Arganoth
		{ INDENT..WHIT.." 2) "..L["Dread Commander Arganoth"], 90705 },
		{ YELL.."- "..SS(1280, 6) }, -- Gateway to Ruin
		{ INDENT..GREY..SD(1280, 6) }, -- Take the Demonic Gateway to the base of the command ship.
		{ INDENT..BLUE.." C) "..L["Demonic Gateway"], 10003 },
		{ YELL.."- "..SS(1280, 7) }, -- Pillar of Fire
		{ INDENT..GREY..SD(1280, 7) }, -- Place Arcane Bombs in Mephistroth's command ship.
		{ INDENT..BLUE.." D) "..L["Command ship"], 10004 },
		{ YELL.."- "..SS(1280, 8, true) }, -- Mephistroth
		{ INDENT..GREY..SD(1280, 8) }, -- Defeat Mephistroth.
	},
}

local myDB = {
	SC_BrokenShore = {
		{ "A", 10001, 257, 457, 413, 573, "Blue" }, -- Alliance Ships
		{ "B", 10002, 304, 436, 474, 544, "Blue" }, -- Horde Ships
		{ "C", 10003, 242, 439, 388, 552, "Blue" }, -- Beach
		{ "C", 10003, 300, 409, 456, 512, "Blue" }, -- Beach
		{ "1", 10004, 129, 254, 247, 305, "Green" }, -- King Varian Wrynn
		{ "2", 10005, 304, 290, 474, 358, "Green" }, -- Sylvanas and Baine
		{ "D", 10006, 136, 223, 254, 260, "Blue" }, -- Portal
		{ "D", 10006, 309, 262, 481, 320, "Blue" }, -- Portal
		{ "E", 10007, 194, 255, 334, 310, "Blue" }, -- The Black City
		{ "E", 10007, 337, 276, 523, 335, "Blue" }, -- The Black City
		{ "F", 10008, 315, 150, 491, 171, "Blue" }, -- Tomb Approach
		{ "F", 10008, 334, 178, 513, 202, "Blue" }, -- Tomb Approach
		{ "3", 10009, 339, 151, 518, 164, "Green" }, -- Highlord Tirion Fordring
		{ "1", 10010, 329, 160, 512, 180, "Red" }, -- Krosus
		{ "G", 10011, 345, 119, 530, 125, "Blue" }, -- Alliance's final stop
		{ "2", 10012, 362, 108, 558, 103, "Red" }, -- Gul'dan
		{ "H", 10013, 390, 135, 596, 149, "Blue" }, -- Horde's final stop
		{ "H", 10013, 427, 137, 632, 158, "Blue" }, -- Horde's final stop
	},
	SC_AssaultonBrokenShore = {
		{ "A", 10001, 417, 314, 560, 463, "Blue" }; 
		{ "B", 10002, 415, 144, 567, 298, "Blue" }; 
		{ "C", 10003, 385, 148, 528, 292, "Blue" }; 
		{ "D", 10004, 332,  96, 474, 247, "Blue" }; 
		{ "1", 116291, 193, 296, 337, 447, "White" };
		{ "2", 90705,  400, 160, 541, 312, "White" };
	};
}

Atlas:RegisterPlugin("Atlas_Scenarios", myCategory, myData, myDB)

