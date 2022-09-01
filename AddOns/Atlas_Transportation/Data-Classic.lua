-- $Id: Data-Classic.lua 140 2022-02-20 07:16:06Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert@gmail.com>
	Copyright 2010 - Lothaer <lothayer@gmail.com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 2 of the License, or
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

local WoWClassicEra, WoWClassicTBC, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 20000 then
	WoWClassicEra = true
elseif wowtocversion > 19999 and wowtocversion < 90000 then 
	WoWClassicTBC = true
else
	WoWRetail = true
end

local db = {}
private.db = db

local BLUE = "|cff6666ff"
local GREN = "|cff66cc33"
local _RED = "|cffcc3333"
local ORNG = "|cffcc9933"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local LBLU = "|cff33cccc"
local CYAN = "|cff00ffff"
local GREY = "|cff999999"
local ALAN = "|cff7babe0" -- Alliance's taxi node
local HRDE = "|cffda6955" -- Horde's taxi node
local NUTL = "|cfffee570" -- Nutral taxi node
local INDENT = "      "

db.category = L[private.category]

local CL = {
	["HUNTER"] 	= "|cffabd473",
	["WARLOCK"] 	= "|cff8788ee",
	["PRIEST"] 	= "|cffffffff",
	["PALADIN"] 	= "|cfff58cba",
	["MAGE"] 	= "|cff3fc7eb",
	["ROGUE"] 	= "|cfffff569",
	["DRUID"] 	= "|cffff7d0a",
	["SHAMAN"] 	= "|cff0070de",
	["WARRIOR"] 	= "|cffc79c6e",
	["DEATHKNIGHT"]	= "|cffc41f3b",
	["MONK"] 	= "|cff00ff96",
	["DEMONHUNTER"]	= "|cffa330c9",
}

if (WoWClassicEra) then
	db.maps = {
		TransAllianceEast_Classic = {
			ZoneName = { BZ["Eastern Kingdoms"]..ALAN..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
			WorldMapID = 13,
			Faction = "Alliance",
			{ BLUE.." A) "..BZ["Auberdine"]..ALC["Comma"].._RED..BZ["Darkshore"] };
			{ BLUE.." B) "..BZ["Ratchet"]..ALC["Comma"].._RED..BZ["The Barrens"] };
			{ BLUE.." C) "..BZ["Theramore Isle"]..ALC["Comma"].._RED..BZ["Dustwallow Marsh"] };
			{ };
			{ WHIT.." 1) "..BZ["Light's Hope Chapel"]..ALC["Comma"].._RED..BZ["Eastern Plaguelands"] },
			{ WHIT.." 2) "..BZ["Chillwind Point"]..ALC["Comma"].._RED..BZ["Western Plaguelands"] },
			{ WHIT.." 3) "..BZ["Aerie Peak"]..ALC["Comma"].._RED..BZ["The Hinterlands"] },
			{ WHIT.." 4) "..BZ["Southshore"]..ALC["Comma"].._RED..BZ["Hillsbrad Foothills"] },
			{ WHIT.." 5) "..BZ["Refuge Pointe"]..ALC["Comma"].._RED..BZ["Arathi Highlands"] },
			{ WHIT.." 6) "..BZ["Menethil Harbor"]..ALC["Comma"].._RED..BZ["Wetlands"] },
			{ WHIT.." 7) "..BZ["Ironforge"]..ALC["Comma"].._RED..BZ["Dun Morogh"] },
			{ WHIT.." 8) "..BZ["Thelsamar"]..ALC["Comma"].._RED..BZ["Loch Modan"] },
			{ WHIT.." 9) "..BZ["Thorium Point"]..ALC["Comma"].._RED..BZ["Searing Gorge"] },
			{ WHIT.."10) "..BZ["Morgan's Vigil"]..ALC["Comma"].._RED..BZ["Burning Steppes"] },
			{ WHIT.."11) "..BZ["Stormwind"]..ALC["Comma"].._RED..BZ["Elwynn Forest"] },
			{ WHIT.."12) "..BZ["Lakeshire"]..ALC["Comma"].._RED..BZ["Redridge Mountains"] },
			{ WHIT.."13) "..BZ["Sentinel Hill"]..ALC["Comma"].._RED..BZ["Westfall"] },
			{ WHIT.."14) "..BZ["Darkshire"]..ALC["Comma"].._RED..BZ["Duskwood"] },
			{ WHIT.."15) "..BZ["Nethergarde Keep"]..ALC["Comma"].._RED..BZ["Blasted Lands"] },
			{ WHIT.."16) "..BZ["Booty Bay"]..ALC["Comma"].._RED..BZ["Stranglethorn Vale"] },
			{ "" },
			{ _RED..L["Legend"] },
			{ BLUE.."-- : "..L["Ship / Zeppelin sailing path to destination"] },
		},
		TransHordeEast_Classic = {
			ZoneName = { BZ["Eastern Kingdoms"]..HRDE..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
			WorldMapID = 13,
			Faction = "Horde",
			{ BLUE.." A) "..BZ["Orgrimmar"]..ALC["Comma"].._RED..BZ["Durotar"] },
			{ BLUE.." B) "..BZ["Ratchet"]..ALC["Comma"].._RED..BZ["The Barrens"] },
			{ };
			{ WHIT.." 1) "..BZ["Light's Hope Chapel"]..ALC["Comma"].._RED..BZ["Eastern Plaguelands"] },
			{ WHIT.." 2) "..BZ["Undercity"]..ALC["Comma"].._RED..BZ["Tirisfal Glades"] },
			{ WHIT.." 3) "..BZ["The Sepulcher"]..ALC["Comma"].._RED..BZ["Silverpine Forest"] },
			{ WHIT.." 4) "..BZ["Tarren Mill"]..ALC["Comma"].._RED..BZ["Hillsbrad Foothills"] },
			{ WHIT.." 5) "..BZ["Revantusk Village"]..ALC["Comma"].._RED..BZ["The Hinterlands"] },
			{ WHIT.." 6) "..BZ["Hammerfall"]..ALC["Comma"].._RED..BZ["Arathi Highlands"] },
			{ WHIT.." 7) "..BZ["Thorium Point"]..ALC["Comma"].._RED..BZ["Searing Gorge"] },
			{ WHIT.." 8) "..BZ["Kargath"]..ALC["Comma"].._RED..BZ["Badlands"] },
			{ WHIT.." 9) "..BZ["Flame Crest"]..ALC["Comma"].._RED..BZ["Burning Steppes"] },
			{ WHIT.."10) "..BZ["Stonard"]..ALC["Comma"].._RED..BZ["Swamp of Sorrows"] },
			{ WHIT.."11) "..BZ["Grom'gol"]..ALC["Comma"].._RED..BZ["Stranglethorn Vale"] },
			{ WHIT.."12) "..BZ["Booty Bay"]..ALC["Comma"].._RED..BZ["Stranglethorn Vale"] },
			{ "" },
			{ _RED..L["Legend"] },
			{ BLUE.."-- : "..L["Ship / Zeppelin sailing path to destination"] },
			{ NUTL.."-- : "..L["Ship / Zeppelin sailing path to destination"] },
		},
		TransAllianceWest_Classic = {
			ZoneName = { BZ["Kalimdor"]..ALAN..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
			WorldMapID = 12,
			Faction = "Alliance",
			{ BLUE.." A) "..BZ["Menethil Harbor"]..", ".._RED..BZ["Wetlands"] };
			{ BLUE.." B) "..BZ["Stormwind City"]..", ".._RED..BZ["Elwynn Forest"] };
			{ BLUE.." C) "..BZ["Booty Bay"]..", ".._RED..BZ["Stranglethorn Vale"] };
			{ };
			{ WHIT.." 1) "..BZ["Rut'theran Village"]..ALC["Comma"].._RED..BZ["Teldrassil"] },
			{ WHIT.." 2) "..BZ["Nighthaven"]..ALC["Comma"].._RED..BZ["Moonglade"] },
			{ WHIT.." 3) "..BZ["Everlook"]..ALC["Comma"].._RED..BZ["Winterspring"] },
			{ WHIT.." 4) "..BZ["Auberdine"]..ALC["Comma"].._RED..BZ["Darkshore"] },
			{ WHIT.." 5) "..BZ["Talonbranch Glade"]..ALC["Comma"].._RED..BZ["Felwood"] },
			{ WHIT.." 6) "..BZ["Stonetalon Peak"]..ALC["Comma"].._RED..BZ["Stonetalon Mountains"] },
			{ WHIT.." 7) "..BZ["Astranaar"]..ALC["Comma"].._RED..BZ["Ashenvale"] },
			{ WHIT.." 8) "..BZ["Forest Song"]..ALC["Comma"].._RED..BZ["Ashenvale"] },
			{ WHIT.." 9) "..BZ["Talrendis Point"]..ALC["Comma"].._RED..BZ["Azshara"] },
			{ WHIT.."10) "..BZ["Nijel's Point"]..ALC["Comma"].._RED..BZ["Desolace"] },
			{ NUTL.."11) "..BZ["Ratchet"]..ALC["Comma"].._RED..BZ["The Barrens"] },
			{ WHIT.."12) "..BZ["Theramore"]..ALC["Comma"].._RED..BZ["Dustwallow Marsh"] },
			{ WHIT.."13) "..BZ["Feathermoon"]..ALC["Comma"].._RED..BZ["Feralas"] },
			{ WHIT.."14) "..BZ["Thalanaar"]..ALC["Comma"].._RED..BZ["Feralas"] },
			{ NUTL.."15) "..BZ["Marshal's Refuge"]..ALC["Comma"].._RED..BZ["Un'Goro Crater"] },
			{ WHIT.."16) "..BZ["Cenarion Hold"]..ALC["Comma"].._RED..BZ["Silithus"] },
			{ WHIT.."17) "..BZ["Gadgetzan"]..ALC["Comma"].._RED..BZ["Tanaris"] },
			{ "" },
			{ _RED..L["Legend"] },
			{ NUTL..L["Yellow"]..ALC["Colon"]..L["Taxi Nodes"]..ALC["Hyphen"]..L["Nutral"] },
			{ BLUE.."-- : "..L["Ship / Zeppelin sailing path to destination"] },
		},
		TransHordeWest_Classic = {
			ZoneName = { BZ["Kalimdor"]..HRDE..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
			WorldMapID = 12,
			Faction = "Horde",
			{ BLUE.." A) "..BZ["Undercity"]..ALC["Comma"].._RED..BZ["Tirisfal Glades"] },
			{ BLUE.." B) "..BZ["Grom'gol"]..ALC["Comma"].._RED..BZ["Stranglethorn Vale"] },
			{ BLUE.." C) "..BZ["Booty Bay"]..ALC["Comma"].._RED..BZ["Stranglethorn Vale"] },
			{ };
			{ WHIT.." 1) "..BZ["Shrine of Remulos"]..ALC["Comma"].._RED..BZ["Moonglade"] },
			{ WHIT.." 2) "..BZ["Everlook"]..ALC["Comma"].._RED..BZ["Winterspring"] },
			{ WHIT.." 3) "..BZ["Bloodvenom Post"]..ALC["Comma"].._RED..BZ["Felwood"] },
			{ WHIT.." 4) "..BZ["Zoram'gar Outpost"]..ALC["Comma"].._RED..BZ["Ashenvale"] },
			{ WHIT.." 5) "..BZ["Valormok"]..ALC["Comma"].._RED..BZ["Azshara"] },
			{ WHIT.." 6) "..BZ["Splintertree Post"]..ALC["Comma"].._RED..BZ["Ashenvale"] },
			{ WHIT.." 7) "..BZ["Orgrimmar"]..ALC["Comma"].._RED..BZ["Durotar"] },
			{ WHIT.." 8) "..BZ["Sun Rock Retreat"]..ALC["Comma"].._RED..BZ["Stonetalon Mountains"] },
			{ WHIT.." 9) "..BZ["Crossroads"]..ALC["Comma"].._RED..BZ["The Barrens"] },
			{ NUTL.."10) "..BZ["Ratchet"]..ALC["Comma"].._RED..BZ["The Barrens"] },
			{ WHIT.."11) "..BZ["Shadowprey Village"]..ALC["Comma"].._RED..BZ["Desolace"] },
			{ WHIT.."12) "..BZ["Thunder Bluff"]..ALC["Comma"].._RED..BZ["Mulgore"] },
			{ WHIT.."13) "..BZ["Camp Taurajo"]..ALC["Comma"].._RED..BZ["The Barrens"] },
			{ WHIT.."14) "..BZ["Brackenwall Village"]..ALC["Comma"].._RED..BZ["Dustwallow Marsh"] },
			{ WHIT.."15) "..BZ["Camp Mojache"]..ALC["Comma"].._RED..BZ["Feralas"] },
			{ WHIT.."16) "..BZ["Freewind Post"]..ALC["Comma"].._RED..BZ["Thousand Needles"] },
			{ NUTL.."17) "..BZ["Marshal's Refuge"]..ALC["Comma"].._RED..BZ["Un'Goro Crater"] },
			{ WHIT.."18) "..BZ["Cenarion Hold"]..ALC["Comma"].._RED..BZ["Silithus"] },
			{ WHIT.."19) "..BZ["Gadgetzan"]..ALC["Comma"].._RED..BZ["Tanaris"] },
			{ "" },
			{ _RED..L["Legend"] },
			{ NUTL..L["Yellow"]..ALC["Colon"]..L["Taxi Nodes"]..ALC["Hyphen"]..L["Nutral"] },
			{ BLUE.."-- : "..L["Ship / Zeppelin sailing path to destination"] },
			{ NUTL.."-- : "..L["Ship / Zeppelin sailing path to destination"] },
		},
	}

	db.coords = {
	}
end

Atlas:RegisterPlugin(private.addon_name, private.db.category, private.db.maps, private.db.coords)

