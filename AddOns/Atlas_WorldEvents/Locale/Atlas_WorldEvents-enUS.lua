-- $Id: Atlas_WorldEvents-enUS.lua 113 2020-10-18 15:14:01Z arith $
--[[

	Atlas World Events, a World of Warcraft map browser for world events
	Copyright 2011 ~ 2020 Arith Hsu

	This file is a plugin of Atlas.

	Atlas World Events is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas World Events is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas_WorldEvents", "enUS", true);

if L then


	-- ----------------------------------------------------------------------
	-- Common
	-- ----------------------------------------------------------------------
	L["World Events Maps"] = "World Events Maps";
	L["Lower"] = "Lower";
	L["Major Cities"] = "Major Cities";
	L["Red: "] = "Red: ";
	L["Blue: "] = "Blue: ";
	L["Orange: "]  = "Orange: ";
	L["Purple: "] = "Purple: ";
	L["Quest: "] = "Quest: ";
	L["Start"] = "Start"; -- The quest started NPC
	L["End"] = "End"; -- The quest ended NPC
	L["Horde Questline"] = "Horde Questline";
	L["Alliance Questline"] = "Alliance Quest line";
	L["Portals"] = "Portals";
	L["Daily Quest"] = "Daily Quest";
	L["Quest Destination"] = "Quest Destination";
	L["Daily Group"] = "Daily Group";

	-- ----------------------------------------------------------------------
	-- World Events
	-- ----------------------------------------------------------------------
	L["Lunar Festival"] = "Lunar Festival";
	L["Lunar_Date"] = "Feb. 16 ~ Mar. 02"; 	-- update dates for year 2015

	L["Midsummer Fire Festival"] = "Midsummer Fire Festival";
	L["Midsummer_Date"] = "Jun. 21 - Jul. 5"; 	-- update dates for year 2015

	L["Hallow's End"] = "Hallow's End";
	L["Hallow_Date"] = "Oct. 18 ~ Nov. 01";	-- update dates for year 2015
	
	L["Harvest Festival"] = "Harvest Festival";	
	L["Harvest_Date"] = "Sep. 21 ~ Sep. 28";		-- update dates for year 2015

	L["Brewfest"] = "Brewfest";
	L["Brewfest_Date"] = "Sep. 20 ~ Oct. 6"; 	-- update dates for year 2015

	L["Love is in the Air"] = "Love is in the Air";
	L["Love_Date"] = "Feb. 02 - Feb. 16";		-- update dates for year 2015

	-- Darkmoon Faire
	L["The first Sunday each month, last for a week"] = "The first Sunday each month, last for a week";
	
	L["Feast of Winter Veil"] = "Feast of Winter Veil";
	L["Winter_Date"] = "Dec. 16 - Jan. 02";	-- update dates for year 2015

	-- ----------------------------------------------------------------------
	-- Lunar Festival
	-- ----------------------------------------------------------------------
	-- Azeroth
	L["Elder Hammershout"] = "Elder Hammershout";	-- 15562
	L["Elder Stormbrow"] = "Elder Stormbrow";	-- 15565
	L["Elder Skychaser"] = "Elder Skychaser";	-- 15577
	L["Elder Winterhoof"] = "Elder Winterhoof";	-- 15576
	L["Elder Starglade"] = "Elder Starglade";	-- 15596
	L["Elder Bellowrage"] = "Elder Bellowrage";	-- 15563
	L["Elder Starsong"] = "Elder Starsong";	-- 15593
	L["Elder Rumblerock"] = "Elder Rumblerock";	-- 15557
	L["Elder Dawnstrider"] = "Elder Dawnstrider";
	L["Elder Ironband"] = "Elder Ironband";
	L["Elder Morndeep"] = "Elder Morndeep";
	L["Elder Stonefort"] = "Elder Stonefort";
	L["Elder Goldwell"] = "Elder Goldwell";
	L["Elder Bronzebeard"] = "Elder Bronzebeard";
	L["Elder Silvervein"] = "Elder Silvervein";
	L["Elder Highpeak"] = "Elder Highpeak";
	L["Elder Snowcrown"] = "Elder Snowcrown";
	L["Elder Windrun"] = "Elder Windrun";
	L["Elder Farwhisper"] = "Elder Farwhisper";
	L["Elder Meadowrun"] = "Elder Meadowrun";
	L["Elder Moonstrike"] = "Elder Moonstrike";
	L["Elder Graveborn"] = "Elder Graveborn";
	L["Elder Darkcore"] = "Elder Darkcore";
	L["Elder Obsidian"] = "Elder Obsidian";
	L["Moonlance the Elder"] = "Moonlance the Elder";
	L["Firebeard the Elder"] = "Firebeard the Elder";
	L["Darkfeather the Elder"] = "Darkfeather the Elder";
	-- Kalimdor
	L["Valadar Starsong"] = "Valadar Starsong";	-- 15864
	L["Fariel Starsong"] = "Fariel Starsong";
	L["Omen"] = "Omen";
	L["Elder Bladeleaf"] = "Elder Bladeleaf";
	L["Elder Bladeswift"] = "Elder Bladeswift";
	L["Elder Starweave"] = "Elder Starweave";
	L["Elder Nightwind"] = "Elder Nightwind";
	L["Elder Brightspear"] = "Elder Brightspear";
	L["Elder Stonespire"] = "Elder Stonespire";
	L["Elder Skygleam"] = "Elder Skygleam";
	L["Elder Darkhorn"] = "Elder Darkhorn";
	L["Runetotem the Elder"] = "Runetotem the Elder";	-- 15572
	L["Elder Windtotem"] = "Elder Windtotem";
	L["Elder Moonwarden"] = "Elder Moonwarden";
	L["Elder High Mountain"] = "Elder High Mountain";
	L["Elder Bloodhoof"] = "Elder Bloodhoof";
	L["Elder Ezra Wheathoof"] = "Elder Ezra Wheathoof";
	L["Elder Skyseer"] = "Elder Skyseer";
	L["Elder Morningdew"] = "Elder Morningdew";
	L["Elder Dreamseer"] = "Elder Dreamseer";
	L["Elder Wildmane"] = "Elder Wildmane";
	L["Elder Ragetotem"] = "Elder Ragetotem";
	L["Elder Thunderhorn"] = "Elder Thunderhorn";
	L["Elder Bladesing"] = "Elder Bladesing";	-- 15599
	L["Elder Primestone"] = "Elder Primestone";
	L["Grimtotem Elder"] = "Grimtotem Elder";
	L["Elder Mistwalker"] = "Elder Mistwalker";
	L["Elder Splitrock"] = "Elder Splitrock";
	L["Elder Riversong"] = "Elder Riversong";
	L["Evershade the Elder"] = "Evershade the Elder";
	L["Windsong the Elder"] = "Windsong the Elder";
	L["Menkhaf the Elder"] = "Menkhaf the Elder";
	L["Sekhemi the Elder"] = "Sekhemi the Elder";
	-- Northrend
	L["Elder Sardis"] = "Elder Sardis";
	L["Elder Pamuya"] = "Elder Pamuya";
	L["Elder Northal"] = "Elder Northal";
	L["Elder Igasho"] = "Elder Igasho";
	L["Elder Arp"] = "Elder Arp";	-- 30364
	L["Elder Sandrene"] = "Elder Sandrene";
	L["Elder Wanikaya"] = "Elder Wanikaya";
	L["Elder Bluewolf"] = "Elder Bluewolf";
	L["Elder Nurgen"] = "Elder Nurgen";
	L["Elder Morthie"] = "Elder Morthie";
	L["Elder Skywarden"] = "Elder Skywarden";
	L["Elder Thoim"] = "Elder Thoim";
	L["Elder Graymane"] = "Elder Graymane";
	L["Elder Fargal"] = "Elder Fargal";
	L["Elder Stonebeard"] = "Elder Stonebeard";
	L["Elder Yurauk"] = "Elder Yurauk";
	L["Elder Muraco"] = "Elder Muraco";
	L["Elder Ohanzee"] = "Elder Ohanzee";
	L["Elder Tauros"] = "Elder Tauros";
	L["Elder Beldak"] = "Elder Beldak";	-- 30357
	L["Elder Whurain"] = "Elder Whurain";
	L["Elder Lunaro"] = "Elder Lunaro";
	L["Elder Jarten"] = "Elder Jarten";
	L["Elder Chogan'gada"] = "Elder Chogan'gada";
	L["Elder Kilias"] = "Elder Kilias";
	-- Deepholm
	L["Elder Stonebrand"] = "Elder Stonebrand";
	L["Elder Deepforge"] = "Elder Deepforge";

	-- ----------------------------------------------------------------------
	-- Hallow's End
	-- ----------------------------------------------------------------------
	L["Trick: "] = "Trick: ";
	L["Masked Orphan Matron"] = "Masked Orphan Matron";
	L["Orc Commoner"] = "Orc Commoner";
	L["Fire Training"] = "Fire Training";
	L["\"Let the Fires Come!\""] = "\"Let the Fires Come!\"";
	L["Stop the Fires!"] = "Stop the Fires!";
	L["Hallow's End Treats for Spoops!"] = "Hallow's End Treats for Spoops!";
	L["Spoops"] = "Spoops";
	L["Orgrimmar Nougat"] = "Orgrimmar Nougat";
	L["Darkspear Gumdrop"] = "Darkspear Gumdrop";
	L["Thunder Bluff Marzipan"] = "Thunder Bluff Marzipan";
	L["Undercity Mint"] = "Undercity Mint";
	L["Innkeeper Gryshka"] = "Innkeeper Gryshka";
	L["Kali Remik"] = "Kali Remik";
	L["Innkeeper Pala"] = "Innkeeper Pala";
	L["Innkeeper Norman"] = "Innkeeper Norman";
	L["Costumed Orphan Matron"] = "Costumed Orphan Matron";
	L["Human Commoner"] = "Human Commoner";
	L["Fire Brigade Practice"] = "Fire Brigade Practice";
	L["Hallow's End Treats for Jesper!"] = "Hallow's End Treats for Jesper!";
	L["Jesper"] = "Jesper";
	L["Stormwind Nougat"] = "Stormwind Nougat";
	L["Gnomeregan Gumdrop"] = "Gnomeregan Gumdrop";
	L["Ironforge Mint"] = "Ironforge Mint";
	L["Darnassus Marzipan"] = "Darnassus Marzipan";
	L["Innkeeper Allison"] = "Innkeeper Allison";
	L["Talvash del Kissel"] = "Talvash del Kissel";
	L["Innkeeper Firebrew"] = "Innkeeper Firebrew";
	L["Innkeeper Saelienne"] = "Innkeeper Saelienne";
	L["Candy Buckets"] = "Candy Buckets";

	-- ----------------------------------------------------------------------
	-- Harvest Festival
	-- ----------------------------------------------------------------------
	-- Quest
	L["Honoring a Hero"] = "Honoring a Hero";
	
	-- NPC
	L["Javnir Nashak"] = "Javnir Nashak";
	
	L["Wagner Hammerstrike"] = "Wagner Hammerstrike";
	
	-- ----------------------------------------------------------------------
	-- Darkmoon Faire
	-- ----------------------------------------------------------------------
	-- Darkmoon Faire - NPC
	L["Selina Dourman <Darkmoon Faire Information>"] = "Selina Dourman <Darkmoon Faire Information>"; -- 10445
	L["Zina Sharpworth <Game Tokens>"] = "Zina Sharpworth <Game Tokens>"; -- 55266
	L["Mola <Whack-a-Mole>"] = "Mola <Whack-a-Mole>"; -- 54601
	L["Maxima Blastenheimer <Darkmoon Faire Cannoneer>"] = "Maxima Blastenheimer <Darkmoon Faire Cannoneer>"; -- 15303
	L["Rinling"] = "Rinling"; -- 14841
	L["Sazz Coincatcher <Game Tokens>"] = "Sazz Coincatcher <Game Tokens>"; -- 55264
	L["Gelvas Grimegate <Souvenir & Toy Prizes>"] = "Gelvas Grimegate <Souvenir & Toy Prizes>"; -- 14828
	L["Aimee <Pie, Pastry & Cakes>"] = "Aimee <Pie, Pastry & Cakes>"; -- 29548
	L["Finlay Coolshot <Tonk Challenge>"] = "Finlay Coolshot <Tonk Challenge>"; -- 54605
	L["Stamp Thunderhorn <Food Vendor>"] = "Stamp Thunderhorn <Food Vendor>"; -- 14845
	L["Professor Thaddeus Paleo <Darkmoon Cards>"] = "Professor Thaddeus Paleo <Darkmoon Cards>"; -- 14847
	L["Chronos <He Who Never Forgets!>"] = "Chronos <He Who Never Forgets!>"; -- 14833
	L["Sylannia <Drink Vendor>"] = "Sylannia <Drink Vendor>"; -- 14844
	L["Baruma <Replica Armor Prizes>"] = "Baruma <Replica Armor Prizes>"; -- 57983
	L["Barum <Replica Armor Prizes>"] = "Barum <Replica Armor Prizes>"; -- 55072
	L["Daenrand Dawncrest <Heirloom Prizes>"] = "Daenrand Dawncrest <Heirloom Prizes>"; -- 56335
	L["Kerri Hicks <The Strongest Woman Alive!>"] = "Kerri Hicks <The Strongest Woman Alive!>"; -- 14832
	L["Lhara <Pet & Mount Prizes>"] = "Lhara <Pet & Mount Prizes>"; -- 14846
	L["Boomie Sparks <Fireworks>"] = "Boomie Sparks <Fireworks>"; -- 55278
	L["Trixi Sharpworth <Game Tokens>"] = "Trixi Sharpworth <Game Tokens>"; -- 55339
	L["Korgol Crushskull <The Pit Master>"] = "Korgol Crushskull <The Pit Master>"; -- 55402
	L["Sayge"] = "Sayge"; -- 14822
	L["Jessica Rogers <Ring Toss>"] = "Jessica Rogers <Ring Toss>"; -- 54485
	L["Rona Greenteeth"] = "Rona Greenteeth"; -- 56041
	L["Tatia Brine <Fishing Supplies>"] = "Tatia Brine <Fishing Supplies>"; -- 56069
	L["Teleportologist Fozlebub <Gone Fishin'>"] = "Teleportologist Fozlebub <Gone Fishin'>"; -- 57850
	L["Steven Stagnaro <Fishing Trainer>"] = "Steven Stagnaro <Fishing Trainer>"; -- 56068

	L["Entrance (Transported)"] = "Entrance (Transported)";
	L["Petting Zoo"] = "Petting Zoo";
	L["L90ETC Concert"] = "L90ETC Concert";

	-- Darkmoon Faire - Quest
	L["Target: Turtle"] = "Target: Turtle"; -- 29455
	L["Tonk Commander"] = "Tonk Commander"; -- 29434
	L["He Shoots, He Scores!"] = "He Shoots, He Scores!"; -- 29438
	L["The Humanoid Cannonball"] = "The Humanoid Cannonball"; -- 29436
	L["It's Hammer Time"] = "It's Hammer Time"; -- 29463
	L["Test Your Strength"] = "Test Your Strength"; -- 29433
	L["Putting the Crunch in the Frog"] = "Putting the Crunch in the Frog"; -- 29509
	L["Putting Trash to Good Use"] = "Putting Trash to Good Use"; -- 29510
	L["Putting the Carnies Back Together Again"] = "Putting the Carnies Back Together Again"; -- 29512
	L["Keeping the Faire Sparkling"] = "Keeping the Faire Sparkling"; -- 29516

	-- ----------------------------------------------------------------------
	-- Brewfest
	-- ----------------------------------------------------------------------
	-- Queest
	L["Brewfest!"] = "Brewfest!"; -- 11441 / 11446
	L["Catch the Wild Wolpertinger!"] = "Catch the Wild Wolpertinger!"; -- 11117 / 11431
	L["Pink Elekks On Parade"] = "Pink Elekks On Parade"; -- 11118 / 11120
	L["Chug and Chuck!"] = "Chug and Chuck!"; -- 12022 / 12191
	L["Now This is Ram Racing... Almost."] = "Now This is Ram Racing... Almost."; -- 11318 / 11409
	L["There and Back Again"] = "There and Back Again"; -- 11122 / 11412
	L["A New Supplier of Souvenirs"] = "A New Supplier of Souvenirs"; -- 29396 / 29397
	L["Bark for the Barleybrews!"] = "Bark for the Barleybrews!"; -- 11293
	L["Bark for the Thunderbrews!"] = "Bark for the Thunderbrews!"; -- 11294
	L["Bark for Drohn's Distillery!"] = "Bark for Drohn's Distillery!"; -- 11407
	L["Bark for T'chali's Voodoo Brewery!"] = "Bark for T'chali's Voodoo Brewery!"; -- 11408
	L["Brew For Brewfest"] = "Brew For Brewfest"; -- 29394 / 29393
	L["This One Time, When I Was Drunk..."] = "This One Time, When I Was Drunk..."; -- 12020
	L["Brew of the Month Club"] = "Brew of the Month Club";
	-- Brewfest - NPC
	L["Dwarf Commoner"] = "Dwarf Commoner";
	L["Gnome Commoner"] = "Gnome Commoner";
	L["Night Elf Commoner"] = "Night Elf Commoner";
	L["Human Commoner"] = "Human Commoner";
	L["Draenei Commoner"] = "Draenei Commoner";
	L["Orc Commoner"] = "Orc Commoner";
	L["Troll Commoner"] = "Troll Commoner";
	L["Tauren Commoner"] = "Tauren Commoner";
	L["Forsaken Commoner"] = "Forsaken Commoner";
	L["Blood Elf Commoner"] = "Blood Elf Commoner";
	L["Ipfelkofer Ironkeg"] = "Ipfelkofer Ironkeg";
	L["Goldark Snipehunter"] = "Goldark Snipehunter";
	L["Boxey Boltspinner"] = "Boxey Boltspinner";
	L["Neill Ramstein"] = "Neill Ramstein";
	L["Flynn Firebrew"] = "Flynn Firebrew";
	L["Pol Amberstill"] = "Pol Amberstill";
	L["Belbi Quikswitch"] = "Belbi Quikswitch";
	L["Becan Barleybrew"] = "Becan Barleybrew";
	L["Daran Thunderbrew"] = "Daran Thunderbrew";
	L["Dark Iron Mole Machine Wreckage"] = "Dark Iron Mole Machine Wreckage"; -- 189989
	L["Larkin Thunderbrew"] = "Larkin Thunderbrew";
	L["Ray'ma"] = "Ray'ma";
	L["Tapper Swindlekeg"] = "Tapper Swindlekeg";
	L["Glodrak Huntsniper"] = "Glodrak Huntsniper";
	L["Bizzle Quicklift"] = "Bizzle Quicklift";
	L["Ram Master Ray"] = "Ram Master Ray";
	L["Bok Dropcertain"] = "Bok Dropcertain";
	L["Driz Tumblequick"] = "Driz Tumblequick";
	L["Blix Fixwidget"] = "Blix Fixwidget";
	L["Cort Gorestein"] = "Cort Gorestein";
	L["Ja'ron"] = "Ja'ron";

	-- ----------------------------------------------------------------------
	-- Love is in the Air
	-- ----------------------------------------------------------------------
	-- Quests
	L["Bonbon Blitz"] = "Bonbon Blitz";
	L["A Perfect Puff of Perfume"] = "A Perfect Puff of Perfume";
	L["A Cloudlet of Classy Cologne"] = "A Cloudlet of Classy Cologne";
	L["A gift for a Lord of Ironforge"] = "A gift for a Lord of Ironforge";
	L["A gift for a Lord of Stormwind"] = "A gift for a Lord of Stormwind";
	L["Uncommon Scents"] = "Uncommon Scents";
	L["Something Stinks"] = "Something Stinks";
	L["Pilfering Perfume"] = "Pilfering Perfume";
	L["Fireworks At The Gilded Rose"] = "Fireworks At The Gilded Rose";
	L["Hot On The Trail"] = "Hot On The Trail";
	L["A Friendly Chat..."] = "A Friendly Chat...";
	L["Snivel's Sweetheart"] = "Snivel's Sweetheart";
	L["Something is in the Air (and it Ain't Love)"] = "Something is in the Air (and it Ain't Love)";
	L["Crushing the Crown"] = "Crushing the Crown";
	L["A Gift for the Prophet"] = "A Gift for the Prophet";
	L["A Gift for the High Priestess of Elune"] = "A Gift for the High Priestess of Elune";
	L["A Gift for the Regent Lord of Quel'Thalas"] = "A Gift for the Regent Lord of Quel'Thalas";
	L["A Gift for the Banshee Queen"] = "A Gift for the Banshee Queen";
	L["A Gift for the Warchief"] = "A Gift for the Warchief";
	L["A Gift for the High Chieftain"] = "A Gift for the High Chieftain";
	-- NPC
	L["Kwee Q. Peddlefeet"] = "Kwee Q. Peddlefeet";
	L["Public Relations Agent"] = "Public Relations Agent";
	L["Junior Detective"] = "Junior Detective";
	L["Detective Snap Snagglebolt"] = "Detective Snap Snagglebolt";
	L["Inspector Snip Snagglebolt"] = "Inspector Snip Snagglebolt";
	L["Marion Sutton"] = "Marion Sutton";
	L["Faded Lovely Greeting Card"] = "Faded Lovely Greeting Card";
	L["King Varian Wrynn"] = "King Varian Wrynn";
	L["Muradin Bronzebeard"] = "Muradin Bronzebeard";
	L["Prophet Velen"] = "Prophet Velen";
	L["Tyrande Whisperwind"] = "Tyrande Whisperwind";
	L["Lor'themar Theron"] = "Lor'themar Theron";
	L["Baine Bloodhoof"] = "Baine Bloodhoof";
	L["Lady Sylvanas Windrunner"] = "Lady Sylvanas Windrunner";
	L["Roka"] = "Roka";
	-- Mics.
	L["The Gilded Rose"] = "The Gilded Rose";
	L["Gotri's Traveling Gear"] = "Gotri's Traveling Gear";
	
	-- ----------------------------------------------------------------------
	-- Feast of Winter Veil
	-- ----------------------------------------------------------------------
	-- Quest
	L["Great-father Winter is Here!"] = "Great-father Winter is Here!";
	L["Greatfather Winter is Here!"] = "Greatfather Winter is Here!";
	L["You're a Mean One..."] = "You're a Mean One...";
	L["A Smokywood Pastures' Thank You!"] = "A Smokywood Pastures' Thank You!";
	L["Treats for Great-father Winter"] = "Treats for Great-father Winter";
	L["Treats for Greatfather Winter"] = "Treats for Greatfather Winter";
	L["The Reason for the Season"] = "The Reason for the Season";
	L["The Feast of Winter Veil"] = "The Feast of Winter Veil";
	-- Horde NPC
	L["Kaymard Copperpinch"] = "Kaymard Copperpinch";
	L["Great-father Winter"] = "Great-father Winter";
	L["Furmund"] = "Furmund";
	L["Sagorne Creststrider"] = "Sagorne Creststrider";
	-- Alliance NPC
	L["Wulmort Jinglepocket"] = "Wulmort Jinglepocket";
	L["Greatfather Winter"] = "Greatfather Winter";
	L["Goli Krumn"] = "Goli Krumn";
	L["Historian Karnik"] = "Historian Karnik";
	-- Other
	L["The Abominable Greench"] = "The Abominable Greench";

	-- ----------------------------------------------------------------------
	-- Location Description
	-- ----------------------------------------------------------------------
	L["(Outside the city gate)"] = "(Outside the city gate)"; -- Elder Hammershout is outside the Stormwind City gate.
	L["(Outside the gate)"] = "(Outside the gate)"; -- Elder Starglade is outside the gate of Zul'Gurub
	L["(On the roof of the bank)"] = "(On the roof of the bank)";
	L["(On the ground)"] = "(On the ground)";
	L["(The roof of Scholomance, outside the dungeon)"] = "(The roof of Scholomance, outside the dungeon)";
	L["Southeast coast of the Lake Elune'ara"] = "Southeast coast of the Lake Elune'ara";
	L["(Next to the flight master)"] = "(Next to the flight master)";
	L["(Inside the fortress)"] = "(Inside the fortress)"; -- The Elder Bluewolf is inside the Wintergrasp Fortress

	L["Quest: Elune's Blessing"] = "Quest: Elune's Blessing";

	-- ----------------------------------------------------------------------
	-- Tanaan Junger Hunter
	-- ----------------------------------------------------------------------
	L["Jungle Hunter"] = "Jungle Hunter";
	L["Jungle Stalker"] = "Jungle Stalker";
	L["Defeat rare creatures in Tanaan Jungle"] = "Defeat rare creatures in Tanaan Jungle";
end
