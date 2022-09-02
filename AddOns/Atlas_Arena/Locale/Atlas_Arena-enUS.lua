--[[

	Atlas Arena, a World of Warcraft instance map browser
	Copyright 2010 ~ 2022 Arith Hsu

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
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas_Arena", "enUS", true);

if L then
	--Common
	L["Arena Maps"] = "Arena Maps";
	L["Quests"] = "Quests";
	L["Start"] = "Start";
	
	-- Gurubashi Arena
	L["Short John Mithril"] = "Short John Mithril";
	L["Stone Guard Towhide"] = "Stone Guard Towhide";

	-- Circle of Blood Arena
	L["Frixee Brasstumbler <Arena Vendor>"] = "Frixee Brasstumbler <Arena Vendor>";
	L["Meminnie <Arena Vendor>"] = "Meminnie <Arena Vendor>";
	
	-- The Ring of Trials
	L["Kelara <Keeper of Sha'tari Heirlooms>"] = "Kelara <Keeper of Sha'tari Heirlooms>";
	L["Grikkin Copperspring <Arena Vendor>"] = "Grikkin Copperspring <Arena Vendor>";
	
	-- The Ring of Blood
	L["Mogor <Hero of the Warmaul>"] = "Mogor <Hero of the Warmaul>"; -- 18069
	L["Gurgthock"] = "Gurgthock"; -- 18471	
	
	-- The Rumble Cage
	L["Dr. Dealwell"] = "Dr. Dealwell";
	L["Katrina Turner"] = "Katrina Turner";
	L["Vixton Pinchwhistle <Legacy Arena Armor>"] = "Vixton Pinchwhistle <Legacy Arena Armor>"; -- 20278
	L["Blazzek the Biter <Legacy Arena Weapons>"] = "Blazzek the Biter <Legacy Arena Weapons>"; -- 40216
	L["Evee Copperspring <Arena Vendor>"] = "Evee Copperspring <Arena Vendor>";
	L["Ecton Brasstumbler <Arena Vendor>"] = "Ecton Brasstumbler <Arena Vendor>";
	
	-- Dalaran Sewers
	L["Xazi Smolderpipe <Arena Vendor>"] = "Xazi Smolderpipe <Arena Vendor>";
	L["Zom Bocom <Apprentice Arena Vendor>"] = "Zom Bocom <Apprentice Arena Vendor>";
	L["Nargle Lashcord <Veteran Arena Vendor>"] = "Nargle Lashcord <Veteran Arena Vendor>";
	L["Trapjaw Rix <Exceptional Arena Weaponry>"] = "Trapjaw Rix <Exceptional Arena Weaponry>";

	-- The Crucible of Carnage
	L["Gurgthock <Fight Promoter>"] = "Gurgthock <Fight Promoter>"; -- 46935
	L["Wodin the Troll-Servant"] = "Wodin the Troll-Servant"; -- 46936

	-- Valhalas
	L["Geirrvif"] = "Geirrvif"; -- 31135
	L["Gjonner the Merciless"] = "Gjonner the Merciless"; -- 31154
	
	-- Amphitheater of Anguish
	L["Yggdras"] = "Yggdras";
	L["Stinkbeard"] = "Stinkbeard";
	L["Elemental Lord"] = "Elemental Lord";
	L["Az'Barin, Prince of the Gust"] = "Az'Barin, Prince of the Gust";
	L["Duke Singen <The New Hotness>"] = "Duke Singen <The New Hotness>";
	L["Erathius, King of Dirt"] = "Erathius, King of Dirt";
	L["Gargoral the Water Lord"] = "Gargoral the Water Lord";
	L["Orinoko Tuskbreaker"] = "Orinoko Tuskbreaker";
	L["Korrak the Bloodrager <Champion of the Winterax>"] = "Korrak the Bloodrager <Champion of the Winterax>";
	L["Vladof the Butcher"] = "Vladof the Butcher";
end
