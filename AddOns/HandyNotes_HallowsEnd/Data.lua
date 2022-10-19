local _, ns = ...
local points = ns.points
local texturesL = ns.texturesL
local scalingL = ns.scalingL
local texturesS = ns.texturesS
local scalingS = ns.scalingS

-- =============================
-- Tricks and Treats of Kalimdor
-- =============================
-- 963 = Alliance
-- 965 = Horde

points[ 97 ] = { -- Azuremyst Isle
	[48504915] = { 963, 2, "0", "", "Azure Watch" },
	[29604160] = { 963, 9, "0", "", "Seat of the Naaru" },
}
points[ 106 ] = { -- Bloodmyst Isle
	[55655980] = { 963, 3, "0", "", "Blood Watch" },
}
points[ 63 ] = { -- Ashenvale
	[36954930] = { 963, 1, "0", "", "Astranaar" },
	[38604240] = { 965, 1, "0", "", "Hellscream's Watch" },
	[50206730] = { 965, 2, "0", "", "Silverwind Refuge" },
	[73906060] = { 965, 3, "0", "", "Splintertree Post" },
	[12903410] = { 965, 4, "0", "", "Zoram'gar Outpost" },
}
points[ 76 ] = { -- Azshara
	[57005030] = { 965, 5, "0", "", "Bilgewater Harbor" },
}
points[ 62 ] = { -- Darkshore
	[50751885] = { 963, 4, "0", "You may need to speak to Zidormi", "Lor'danel" },
}
points[ 89 ] = { -- Darnassus
	[62303285] = { 963, 5, "0", "You may need to speak to Zidormi", "Craftsmen's Terrace" },
}
points[ 66 ] = { -- Desolace
	[56705010] = { 963, 6, "0", "", "Karnum's Glade" },
	[66250665] = { 963, 7, "0", "", "Nigel's Point" },
	[56705011] = { 965, 6, "0", "", "Karnum's Glade" },
	[24106830] = { 965, 7, "0", "", "Shadowprey Village" },
}
points[ 1 ] = { -- Durotar
	[51604160] = { 965, 8, "0", "", "Razor Hill" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[41907410] = { 963, 8, "0", "Upstairs, inside the main hut", "Mudsprocket" },
	[36803240] = { 965, 9, "0", "", "Brackenwall Village" },
	[41907411] = { 965, 10, "0", "Upstairs, inside the main hut", "Mudsprocket" },
}
points[ 103 ] = { -- The Exodar
	[59251930] = { 963, 9, "0", "", "Seat of the Naaru" },
}
points[ 77 ] = { -- Felwood
	[61852665] = { 963, 10, "0", "", "Talonbranch Glade" },
	[44602890] = { 963, 11, "0", "", "Whisperwind Grove" },
	[44602891] = { 965, 11, "0", "", "Whisperwind Grove" },
}
points[ 69 ] = { -- Feralas
	[51051780] = { 963, 12, "0", "", "Dreamer's Rest" },
	[46354515] = { 963, 13, "0", "", "Feathemoon Stronghold" },
	[41401570] = { 965, 12, "0", "", "Camp Ataya" },
	[74804510] = { 965, 13, "0", "", "Camp Mojache" },
	[52004760] = { 965, 14, "0", "", "Stonemaul Hold" },
}
points[ 7 ] = { -- Mulgore
	[46806040] = { 965, 15, "0", "", "Bloodhoof Village" },
}
points[ 10 ] = { -- Northern Barrens
	[67307460] = { 963, 14, "0", "", "Ratchet" },
	[49505790] = { 965, 16, "0", "", "The Crossroads" },
	[56204000] = { 965, 17, "0", "", "Grol'dom Farm" },
	[62501660] = { 965, 18, "0", "", "Nozzlepot's Outpost" },
	[67307461] = { 965, 19, "0", "", "Ratchet" },
}
points[ 85 ] = { -- Orgrimmar
	[53607870] = { 965, 20, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Valley of Strength" },
}
points[ 81 ] = { -- Silithus
	[55503680] = { 963, 15, "0", "At the back of the Inn, below the Flight Masters.\n"
									.."You may need to speak to Zidormi", "Cenarion Hold" },
	[55503681] = { 965, 21, "0", "At the back of the Inn, below the Flight Masters.\n"
									.."You may need to speak to Zidormi", "Cenarion Hold" },
}
points[ 199 ] = { -- Southern Barrens
	[40706930] = { 965, 22, "0", "", "Desolation Hold" },
	[49056845] = { 963, 16, "0", "", "Fort Triumph" },
	[39001095] = { 963, 17, "0", "", "Honor's Stand" },
	[65604660] = { 963, 18, "0", "", "Northwatch Hold" },
	[39302010] = { 965, 23, "0", "", "Hunter's Hill" },
}
points[ 65 ] = { -- Stonetalon Mountains
	[31506070] = { 963, 19, "0", "", "Farwatcher's Glen" },
	[71057910] = { 963, 20, "0", "", "Northatch Expedition Base" },
	[39553280] = { 963, 21, "0", "", "Thal'darah Overlook" },
	[59055630] = { 963, 22, "0", "", "Windshear Hold" },
	[66506420] = { 965, 24, "0", "", "Krom'gar Fortress" },
	[50406380] = { 965, 25, "0", "", "Sun Rock Retreat" },
}
points[ 71 ] = { -- Tanaris
	[55706090] = { 963, 23, "0", "", "Bootlegger Outpost" },
	[52602710] = { 963, 24, "0", "", "Gadgetzan" },
	[55706091] = { 965, 26, "0", "", "Bootlegger Outpost" },
	[52602711] = { 965, 27, "0", "", "Gadgetzan" },
}
points[ 57 ] = { -- Teldrassil
	[55415224] = { 963, 25, "0", "You may need to speak to Zidormi", "Dolanaar" },
	[29004320] = { 963, 5, "0", "You may need to speak to Zidormi", "Craftsmen's Terrace" },
}
points[ 88 ] = { -- Thunder Bluff
	[45606490] = { 965, 28, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Lower Rise" },
}
points[ 78 ] = { -- Un'Goro Crater
	[55306210] = { 963, 26, "0", "", "Marshal's Stand" },
	[55306211] = { 965, 29, "0", "", "Marshal's Stand" },
}
points[ 83 ] = { -- Winterspring
	[59805110] = { 963, 27, "0", "", "Everlook" },
	[59805111] = { 965, 30, "0", "", "Everlook" },
}
points[ 12 ] = { -- Kalimdor continent map hacks
	-- Azuremyst Isle
	[32402650] = { 963, 2, "0", "", "Azure Watch" },
	-- Desolace
	[41805446] = { 963, 6, "0", "", "Karnum's Glade" },
	-- Dustwallow Marsh
	[55006904] = { 965, 10, "0", "Upstairs, inside the main hut", "Mudsprocket" },
	-- Mount Hyjal
	[51052923] = { 5837, 2, "0", "", "Grove of Aessina" },
	[56182771] = { 5837, 3, "0", "", "Nordrassil" },
	[53803031] = { 5838, 4, "0", "", "Shrine of Aviana" },
	-- Silithus
	[44397818] = { 963, 15, "0", "At the back of the Inn, below the Flight Masters.\n"
									.."You may need to speak to Zidormi", "Cenarion Hold" },
	-- Tanaris
	[57468564] = { 965, 23, "0", "", "Bootlegger Outpost" },
	[56867902] = { 965, 24, "0", "", "Gadgetzan" },
	-- Teldrassil
	[44000950] = { 963, 25, "0", "", "Dolanaar" },
	[39001010] = { 963, 5, "0", "", "Craftsmen's Terrace" },
	-- Uldum
	[48948847] = { 5837, 10, "0", "", "Ramkahen" },
	-- Un'Goro Crater
	[50498075] = { 963, 26, "0", "", "Marshal's Stand" },
	-- Winterspring
	[59072288] = { 963, 27, "0", "", "Everlook" },
}

-- ==============================
-- Cleanup in Stormwind/Undercity - Added 4.1.0
-- ==============================
-- 1040 2 = Alliance. Quest 29144 R
-- 1041 2 = Horde. Quest 29375 R
-- ================
-- Stink Bombs Away - Added 4.1.0
-- ================
-- 1040 1 = Alliance. Quest 29054 R
-- 1041 1 = Horde. Quest 29374 R
-- =========================
-- A Time to Lose/Break Down - Added 4.2.0
-- =========================
-- 1040 4 = Alliance. Quest 29371 R
-- 1041 4 = Horde. Quest 29377 R
-- =====================================
-- Tricks and Treats of Eastern Kingdoms
-- =====================================
-- 966 = Alliance
-- 967 = Horde

points[ 14 ] = { -- Arathi Highlands
	[40104910] = { 966, 1, "0", "", "Refuge Point" },
	[69023328] = { 967, 1, "0", "", "Hammerfall" },
}
points[ 15 ] = { -- Badlands
	[20855630] = { 966, 2, "0", "", "Dragon's Mouth" },
	[65853565] = { 966, 3, "0", "", "Fuselight" },
	[65853566] = { 967, 2, "0", "", "Fuselight" },
	[18364273] = { 967, 3, "0", "", "New Kargath" },
}
points[ 17 ] = { -- Blasted Lands
	[60651400] = { 966, 4, "0", "", "Nethergarde Keep" },
	[44358755] = { 966, 5, "0", "", "Surwich" },
	[40471129] = { 967, 4, "0", "", "Dreadmaul Hold" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40907370] = { 966, 6, "0", "", "Booty Bay" },
	[40907371] = { 967, 5, "0", "", "Booty Bay" },
	[35052723] = { 967, 6, "0", "", "Hardwrench Hideaway" },
}
points[ 27 ] = { -- Dun Morogh
	[54455075] = { 966, 7, "0", "", "Kharanos" },
	[57202690] = { 966, 13, "0", "Inside the Stonefire Tavern", "The Commons" },
}
points[ 47 ] = { -- Duskwood
	[73754420] = { 966, 8, "0", "", "Darkshire" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75605230] = { 966, 9, "0", "", "Light's Hope Chapel" },
	[75605231] = { 967, 7, "0", "", "Light's Hope Chapel" },
}
points[ 37 ] = { -- Elwynn Forest
	[43756590] = { 966, 10, "0", "", "Goldshire" },
	[23603250] = { 966, 19, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "" },
	[32205080] = { 1040, 1, 29054, "Pickup the quest here from Gretchen Fenlow. Soon after\n"
									.."completion you could consider logging out. You will\n"
									.."respawn in Tirisfal Glades. This will save a lot of\n"
									.."time if you also intend doing \"A Time to Lose\"", "" },
	[29694442] = { 1040, 2, 29144, "Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled.\n"
									.."Go to System->Graphics->Effects. If you get debuffed then\n"
									.."you may cleanse yourself. Shapeshifting also works.", "" },
	[32005060] = { 1040, 4, 29371, "Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", "" },
	[22133396] = { 1041, 1, 29374, "If you logout while in Stormwind you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Break Down\".", "" },
	[34104740] = { 1041, 4, 29377, "The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", "" },
}
points[ 94 ] = { -- Eversong Woods
	[43707102] = { 967, 8, "0", "", "Fairbreeze Village" },
	[48214788] = { 967, 9, "0", "", "Falconwing Square" },
	[56204420] = { 967, 17, "0", "", "The Bazaar" },
	[59904170] = { 967, 18, "0", "", "The Royal Exchange" },
}
points[ 95 ] = { -- Ghostlands
	[48673192] = { 967, 10, "0", "", "Tranquillien" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[60266374] = { 967, 11, "0", "", "Eastpoint Tower" },
	[57854728] = { 967, 12, "0", "", "Tarren Mill" },
}
points[ 26 ] = { -- The Hinterlands
	[14154465] = { 966, 11, "0", "", "Aerie Peak" },
	[66154440] = { 966, 12, "0", "", "Stormfeather Outpost" },
	[31805786] = { 967, 13, "0", "", "Hiri'watha Research Station" },
	[78188148] = { 967, 14, "0", "", "Revantusk Village" },
}
points[ 87 ] = { -- Ironforge
	[18405090] = { 966, 13, "0", "Inside the Stonefire Tavern", "The Commons" },
}
points[ 48 ] = { -- Loch Modan
	[83006350] = { 966, 14, "0", "", "Farstrider Lodge" },
	[35504850] = { 966, 15, "0", "", "Thelsamar" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[53156695] = { 966, 16, "0", "", "Fort Livingston" },
	[37375178] = { 967, 15, "0", "", "Grom'gol Base Camp" },
}
points[ 49 ] = { -- Redridge Mountains
	[26454150] = { 966, 17, "0", "", "Lakeshire" },
}
points[ 32 ] = { -- Searing Gorge
	[39456600] = { 966, 18, "0", "", "Iron Summit" },
	[39456601] = { 967, 16, "0", "", "Iron Summit" },
}
points[ 110 ] = { -- Silvermoon City
	[67607286] = { 967, 17, "0", "", "The Bazaar" },
	[79405765] = { 967, 18, "0", "", "The Royal Exchange" },
}
points[ 21 ] = { -- Silverpine Forest
	[44292027] = { 967, 19, "0", "", "Forsaken Rear Guard" },
	[46454290] = { 967, 20, "0", "", "The Sepulcher" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[52104380] = { 966, 16, "0", "", "Fort Livingston" },
	[38007790] = { 966, 6, "0", "", "Booty Bay" },
	[43503470] = { 967, 15, "0", "", "Grom'gol Base Camp" },
	[38007791] = { 967, 5, "0", "", "Booty Bay" },
	[33505310] = { 967, 6, "0", "", "Hardwrench Hideaway" },
}
points[ 84 ] = { -- Stormwind City
	[60507525] = { 966, 19, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "" },
	[75119665] = { 1040, 1, 29054, "Pickup the quest here from Gretchen Fenlow. Soon after\n"
									.."completion you could consider logging out. You will\n"
									.."respawn in Tirisfal Glades. This will save a lot of\n"
									.."time if you also intend doing \"A Time to Lose\"", "" },
	[70108390] = { 1040, 2, 29144, "Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled.\n"
									.."Go to System->Graphics->Effects. If you get debuffed then\n"
									.."you may cleanse yourself. Shapeshifting also works.", "" },
	[74729626] = { 1040, 4, 29371, "Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", "" },
	[55006300] = { 1041, 1, 29374, "If you logout while in Stormwind you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Break Down\".", "" },
	[78918986] = { 1041, 4, 29377, "The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", "" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[71601410] = { 966, 20, "0", "", "Bogpaddle" },
	[28903235] = { 966, 21, "0", "", "The Harborage" },
	[71601411] = { 967, 21, "0", "", "Bogpaddle" },
	[46895682] = { 967, 22, "0", "", "Stonard" },
}
points[ 18 ] = { -- Tirisfal Glades
	[61508111] = { 967, 25, "0", "", "The Trade Quarter" },
	[60905140] = { 967, 23, "0", "You may need to speak to Zidormi", "Brill" },
	[83007200] = { 967, 24, "0", "", "The Bulwark" },
	
	[62406680] = { 1041, 1, 29374, "Pickup the quest here from Candace Fenlow. Soon after\n"
									.."completion you could consider logging out. You will\n"
									.."respawn in Elwynn Forest. This will save a lot of\n"
									.."time if you also intend doing \"A Time to Break Down\".", "" },
	[62006660] = { 1041, 2, 29375, "Pickup the quest from Candace Fenlow who is in the Ruins\n"
									.."of Lordaeron. To see the orange plumes you must have\n"
									.."\"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then\n"
									.."you may cleanse yourself. Shapeshifting also works.", "" },
	[66606200] = { 1041, 2, 29375, "If things are not \"peaceful\" then do NOT attempt to\n"
									.."enter Lordaeron. Speak to Zidormi who is nearby.", "" },
	[62006780] = { 1041, 4, 29377, "Pickup the quest here from Darkcaller Yanks. See my travel\n"
									.."notes for the quest \"Stink Bombs Away\". Approach from\n"
									.."the east, hugging the terrain. A large tree will cover your\n"
									.."final approach.", "" },
	[61508110] = { 1040, 1, 29054, "If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\"", "" },
	[62406820] = { 1040, 4, 29371, "The location of the Horde Wickerman.\n"
									.."Approach from as high up as possible. Plummet down. Land\n"
									.."between the Wickerman and the wall, preferably with a\n"
									.."pillar providing a little cover. The pillar where the\n"
									.."green bubbling liquid begins is perfect. Do NOT try to\n"
									.."target the Wickerman. Stand near it and click on your\n"
									.."Dousing Agent. Immediately mount and hit \"space\" to\n"
									.."fly straight up.", "" },
}
points[ 90 ] = { -- Undercity
	[67763761] = { 967, 25, "0", "", "The Trade Quarter" },
	[76503301] = { 1041, 2, 29375, "To see the orange plumes you must have \"Particle Density\"\n"
									.."at least minimally enabled via System->Graphics->Effects.", "" },
	[75703300] = { 1040, 1, 29054, "If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\".", "" },
	[76105320] = { 1040, 4, 29371, "Logout while in Undercity doing \"Stink Bombs "
									.."Away\"\nfor faster travelling back to Lordaeron.", "" },
}
points[ 22 ] = { -- Western Plaguelands
	[43358435] = { 966, 22, "0", "", "Chillwind Camp" },
	[48266367] = { 967, 26, "0", "", "Andorhal" },
}
points[ 52 ] = { -- Westfall
	[52905370] = { 966, 25, "0", "In the Inn or atop the tower, depending upon your quest phase", "Sentinel Hill" },
}
points[ 56 ] = { -- Wetlands
	[10806095] = { 966, 23, "0", "", "Menethil Harbor" },
	[26052595] = { 966, 24, "0", "", "Swiftgear Station" },
	[58203920] = { 966, 26, "0", "", "Greenwarden's Grove" },
}
points[ 13 ] = { -- Eastern Kingdoms continent map hacks
	-- Searing Gorge does not display pins automatically on the continent for Alliance
	[47106730] = { 966, 18, "0", "", "Iron Summit" },
	-- Same for the Eastern Plaguelands
	[57603260] = { 966, 9, "0", "", "Light's Hope Chapel" },
	-- Only Bogpaddle refuses to be shown. Whatever!
	[53907710] = { 966, 20, "0", "", "Bogpaddle" },
	-- Vashj'ir
	[34346363] = { 5837, 13, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "Silver Tide Hollow" },
	[36336030] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "Deepmist Grotto" },
	[34346364] = { 5838, 12, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "Silver Tide Hollow" },
}

-- ============================
-- Tricks and Treats of Outland
-- ============================
-- 969 = Alliance
-- 968 = Horde

points[ 105 ] = { -- Blade's Edge Mountains
	[62903830] = { 969, 1, "0", "Inside the inn, mailbox at the front", "Evergrove" },
	[35806370] = { 969, 2, "0", "At the rear of the inn,\nbehind the main building", "Sylvanaar" },
	[61106810] = { 969, 3, "0", "At the rear of the inn,\nThe building has a mailbox", "Toshley's Station" },
	[62903831] = { 968, 1, "0", "Inside the inn, mailbox at the front", "Evergrove" },
	[76206040] = { 968, 2, "0", "Inside the main building", "Mok'Nathal Village" },
	[53405550] = { 968, 3, "0", "Inside the main building", "Thunderlord Stronghold" },
}
points[ 100 ] = { -- Hellfire Peninsula
	[54206370] = { 969, 4, "0", "In the inn, mailbox at the front", "Honor Hold" },
	[23403660] = { 969, 5, "0", "In the main building at the end of the promenade", "Temple of Telhamat" },
	[26905940] = { 968, 4, "0", "In the lower, domed building", "Falcon Watch" },
	[56803750] = { 968, 5, "0", "In the smaller of the two main buildings", "Thrallmar" },
}
points[ 107 ] = { -- Nagrand
	[54207590] = { 969, 6, "0", "Below the Flight Master", "Telaar" },
	[56603550] = { 968, 6, "0", "At the entrance to the huge round building", "Garadar" },
}
points[ 109 ] = { -- Netherstorm
	[32006455] = { 969, 7, "0", "A little inside the main building", "Area 52" },
	[43303610] = { 969, 8, "0", "Fly high up. Inside the lowest building", "The Stormspire" },
	[32006456] = { 968, 7, "0", "A little inside the main building", "Area 52" },
	[43303611] = { 968, 8, "0", "Fly high up. Inside the lowest building", "The Stormspire" },
}
points[ 104 ] = { -- Shadowmoon Valley
	[61002820] = { 969, 9, "0", "You must be Aldor", "Altar of Sha'tar" },
	[56405980] = { 969, 9, "0", "You must be Scryer", "Sanctum of the Stars" },
	[37005830] = { 969, 10, "0", "In the dining area of the Kharanos-style inn with\n"
					.."brewing iconography. Don't enter the big building", "Wildhammer Stronghold" },
	[61002821] = { 968, 9, "0", "You must be Aldor", "Altar of Sha'tar" },
	[56405981] = { 968, 9, "0", "You must be Scryer", "Sanctum of the Stars" },
	[30302770] = { 968, 10, "0", "In the main building", "Shadowmoon Village" },
}
points[ 111 ] = { -- Shattrath City
	[28204900] = { 969, 11, "0", "You must be Aldor", "Aldor Rise" },
	[56258180] = { 969, 11, "0", "You must be Scryer", "Scryer's Tier" },
	[28204901] = { 968, 11, "0", "You must be Aldor", "Aldor Rise" },
	[56258181] = { 968, 11, "0", "You must be Scryer", "Scryer's Tier" },
}
points[ 108 ] = { -- Terokkar Forest
	[56605320] = { 969, 12, "0", "Inside the only round, domed (elven) building", "Allerian Stronghold" },
	[48704520] = { 968, 12, "0", "Inside the huge round building", "Stonebreaker Hold" },
}
points[ 102 ] = { -- Zangarmarsh
	[78456290] = { 969, 13, "0", "Inside the main building", "Cenarion Refuge" },
	[41902620] = { 969, 14, "0", "Inside the building with the mailbox", "Orebor Harborage" },
	[67204890] = { 969, 15, "0", "Right next to the innkeeper", "Telredor" },
	[30705085] = { 968, 13, "0", "In an upper level pavillion", "Zabra'jin" },
	[78456291] = { 968, 14, "0", "Inside the main building", "Cenarion Refuge" },
}
points[ 101 ] = { -- Outland continent map hacks
	[42602400] = { 969, 1, "0", "Inside the inn, mailbox at the front", "Evergrove" },
	[53102370] = { 969, 7, "0", "A little inside the main building", "Area 52" },
	[67608550] = { 969, 9, "0", "You must be Scryer", "Sanctum of the Stars" },
}
-- ==============================
-- Tricks and Treats of Northrend
-- ==============================
-- 5836 = Alliance
-- 5835 = Horde

points[ 114 ] = { -- Borean Tundra
	[54802110] = { 5836, 1, "0", "", "Fizzcrank Airstrip" },
	[77805220] = { 5836, 2, "0", "Inside the inn / main building", "Unu'pe" },
	[58206670] = { 5836, 3, "0", "Quite a ways inside the inn.\nAdjacent to the Flight Master", "Valiance Keep" },
	[47501190] = { 5835, 1, "0", "", "Bor'gorok Outpost" },
	[75503660] = { 5835, 2, "0", "", "Taunka'le Village" },
	[77805221] = { 5835, 3, "0", "Inside the inn / main building", "Unu'pe" },
	[41805440] = { 5835, 4, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Warsong Hold" },
}
points[ 127 ] = { -- Crystalsong Forest
	[29003240] = { 5836, 4, "0", "", "The Legerdemain Lounge" },
	[24903750] = { 5836, 5, "0", "Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", "A Hero's Welcome" },
	[27304170] = { 5836, 6, "0", "Cantrips & Crows", "The Underbelly" },
	[29003241] = { 5835, 5, "0", "", "The Legerdemain Lounge" },
	[30703770] = { 5835, 6, "0", "The Filthy Animal\nDon't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Sunreaver's Sanctuary" },
	[27304171] = { 5835, 7, "0", "Cantrips & Crows", "The Underbelly" },
}
points[ 125 ] = { -- Dalaran
	[48204050] = { 5836, 4, "0", "", "The Legerdemain Lounge" },
	[42206360] = { 5836, 5, "0", "Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", "A Hero's Welcome" },
	[37605980] = { 5836, 6, "0", "Cantrips & Crows", "The Underbelly" },
	[48204051] = { 5835, 5, "0", "", "The Legerdemain Lounge" },
	[66703000] = { 5835, 6, "0", "The Filthy Animal\nDon't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Sunreaver's Sanctuary" },
	[37605981] = { 5835, 7, "0", "Cantrips & Crows", "The Underbelly" },
}
points[ 126 ] = { -- The Underbelly
	[40205950] = { 5836, 6, "0", "Cantrips & Crows", "The Underbelly" },
	[40205951] = { 5835, 7, "0", "Cantrips & Crows", "The Underbelly" },
}
points[ 115 ] = { -- Dragonblight
	[49507320] = { 5836, 7, "0", "", "Moa'ki Harbor" },
	[27605530] = { 5836, 8, "0", "", "Stars' Rest" },
	[78805010] = { 5836, 9, "0", "", "Wintergarde Keep" },
	[62205550] = { 5836, 10, "0", "The ground floor", "Wyrmrest Temple" },
	[38704680] = { 5835, 8, "0", "", "Agmar's Hammer" },
	[49507321] = { 5835, 9, "0", "", "Moa'ki Harbor" },
	[78506200] = { 5835, 10, "0", "", "Venomspite" },
	[62205551] = { 5835, 11, "0", "The ground floor", "Wyrmrest Temple" },
}
points[ 116 ] = { -- Grizzly Hills
	[33306020] = { 5836, 11, "0", "", "Amberpine Lodge" },
	[61002680] = { 5836, 12, "0", "", "Westfall Brigade" },
	[65404710] = { 5835, 12, "0", "", "Camp Oneqwah" },
	[20906470] = { 5835, 13, "0", "", "Conquest Hold" },
}
points[ 117 ] = { -- Howling Fjord
	[60401590] = { 5836, 13, "0", "", "Fort Wildervar" },
	[26805980] = { 5836, 14, "0", "", "Kamagua" },
	[58306280] = { 5836, 15, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Valgarde" },
	[30804140] = { 5836, 16, "0", "", "Westguard Keep" },
	[49401080] = { 5835, 14, "0", "", "Camp Winterhoof" },
	[26805981] = { 5835, 15, "0", "", "Kamagua" },
	[52106620] = { 5835, 16, "0", "", "New Agamand" },
	[79203050] = { 5835, 17, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Vengeance Landing" },
}
points[ 119 ] = { -- Sholazar Basin
	[26905915] = { 5836, 17, "0", "", "Nesingwary Base Camp" },
}
points[ 120 ] = { -- Storm Peaks
	[31303830] = { 5836, 18, "0", "Quest phasing issues reported", "Bouldercrag's Refuge" },
	[30007520] = { 5836, 19, "0", "", "Frosthold" },
	[42708630] = { 5836, 20, "0", "", "K3" },
	[31303831] = { 5835, 19, "0", "Quest phasing issues reported", "Bouldercrag's Refuge" },
	[66605110] = { 5835, 20, "0", "", "Camp Tunka'lo" },
	[37004960] = { 5835, 21, "0", "", "Grom'arsh Crash Site" },
	[42708631] = { 5835, 22, "0", "", "K3" },
}
points[ 121 ] = { -- Zul'Drak
	[41306700] = { 5836, 21, "0", "", "The Argent Stand" },
	[59305720] = { 5836, 22, "0", "", "Zim'Torga" },
	[41306701] = { 5835, 23, "0", "", "The Argent Stand" },
	[59305721] = { 5835, 24, "0", "", "Zim'Torga" },
}
points[ 113 ] = { -- Northrend continent map hacks
	[65954514] = { 5836, 21, "0", "", "The Argent Stand" },
	[70724254] = { 5836, 22, "0", "", "Zim'Torga" },
	[51086056] = { 5836, 10, "0", "The ground floor", "Wyrmrest Temple" },
	[48364192] = { 5836, 4, "0", "", "The Legerdemain Lounge" },
	[47006580] = { 5835, 9, "0", "", "Moa'ki Harbor" },
	[53862170] = { 5835, 19, "0", "Quest phasing issues reported", "Bouldercrag's Refuge" },
	[58163982] = { 5835, 22, "0", "", "K3" },
}	
-- ==================================
-- Tricks and Treats of the Cataclysm
-- ==================================
-- 5837 = Alliance
-- 5838 = Horde

points[ 207 ] = { -- Deepholm
	[47305170] = { 5837, 1, "0", "", "Temple of Earth" },
	[51204990] = { 5838, 1, "0", "", "Temple of Earth" },
}
points[ 198 ] = { -- Mount Hyjal
	[18603730] = { 5837, 2, "0", "", "Grove of Aessina" },
	[63052410] = { 5837, 3, "0", "", "Nordrassil" },
	[42654570] = { 5837, 4, "0", "", "Shrine of Aviana" },
	[18603731] = { 5838, 2, "0", "", "Grove of Aessina" },
	[63052411] = { 5838, 3, "0", "", "Nordrassil" },
	[42654571] = { 5838, 4, "0", "", "Shrine of Aviana" },
}
points[ 241 ] = { -- Twilight Highlands
	[60305820] = { 5837, 5, "0", "", "Firebeard's Patrol" },
	[79457850] = { 5837, 6, "0", "", "Highbank" },
	[49603035] = { 5837, 7, "0", "", "Thundermar" },
	[43505720] = { 5837, 8, "0", "", "Victor's Point" },
	[53004300] = { 5838, 5, "0", "", "Bloodgulch" },
	[45807770] = { 5838, 6, "0", "", "Crushblow" },
	[76201820] = { 5838, 7, "0", "", "The Krazzworks" },
}
points[ 249 ] = { -- Uldum
	[26550720] = { 5837, 9, "0", "", "Oasis of Vir'sar" },
	[54653300] = { 5837, 10, "0", "", "Ramkahen" },
	[26550721] = { 5838, 8, "0", "", "Oasis of Vir'sar" },
	[54653301] = { 5838, 9, "0", "", "Ramkahen" },
}
points[ 204 ] = { -- Abyssal Depths in Vashj'ir
	[61897915] = { 5837, 11, "0", "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance", "" },
	[94867350] = { 5838, 11, "0", "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[60005670] = { 5838, 13, "0", "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 201 ] = { -- Kelp'thar Forest in Vashj'ir
	[60686609] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[60686610] = { 5838, 10, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[20007114] = { 5837, 11, "0", "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance", "" },
	[68261539] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[51564153] = { 5837, 13, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[45025707] = { 5837, 14, "0", "Inside the Tranquil Wash. Dive straight down. The icon marks the entrance", "" },
	[68261540] = { 5838, 10, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", " " },
	[47706640] = { 5838, 11, "0", "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[51564155] = { 5838, 12, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[18415228] = { 5838, 13, "0", "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 203 ] = { -- Vashj'ir
	[43817203] = { 5837, 11, "0", "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance", "" },
	[77513310] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[65845135] = { 5837, 13, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[61286220] = { 5837, 14, "0", "Inside the Tranquil Wash. Dive straight down. The icon marks the entrance", "" },
	[77513311] = { 5838, 10, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[63156871] = { 5838, 11, "0", "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[65855137] = { 5838, 12, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", " " },
	[42705886] = { 5838, 13, "0", "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 948 ] = { -- The Maelstrom
	[50002900] = { 5837, 1, "0", "", "Temple of Earth" },
	[50002901] = { 5838, 1, "0", "", "Temple of Earth" },
}
-- =================================
-- Tricks and Treats of the Pandaria
-- =================================
-- 7601 = Alliance
-- 7602 = Horde

points[ 422 ] = { -- Dread Wastes
	[55903220] = { 7601, 1, "0", "", "Klaxxi'vess" },
	[55207120] = { 7601, 2, "0", "", "Soggy's Gamble" },
	[55903221] = { 7602, 1, "0", "", "Klaxxi'vess" },
	[55207121] = { 7602, 2, "0", "", "Soggy's Gamble" },
}
points[ 371 ] = { -- The Jade Forest
	[45704360] = { 7601, 3, "0", "", "Dawn's Blossom" },
	[48003460] = { 7601, 4, "0", "", "Greenstone Village" },
	[54606330] = { 7601, 5, "0", "", "Jade Temple Grounds" },
	[44808440] = { 7601, 6, "0", "", "Paw'don Village" },
	[59608320] = { 7601, 7, "0", "", "Pearlfin Village" },
	[55702440] = { 7601, 8, "0", "", "Sri-La Village" },
	[41602310] = { 7601, 9, "0", "", "Tian Monastery" },
	[45704361] = { 7602, 3, "0", "", "Dawn's Blossom" },
	[48003461] = { 7602, 4, "0", "", "Greenstone Village" },
	[28004740] = { 7602, 5, "0", "", "Grookin Hill" },
	[28451330] = { 7602, 6, "0", "", "Honeydew Village" },
	[54606331] = { 7602, 7, "0", "", "Jade Temple Grounds" },
	[55702441] = { 7602, 8, "0", "", "Sri-La Village" },
	[41602311] = { 7602, 9, "0", "", "Tian Monastery" },
}
points[ 418 ] = { -- Krasarang Wilds
	[51407720] = { 7601, 10, "0", "", "Marista" },
	[75900690] = { 7601, 11, "0", "", "Zhu's Watch" },
	[28255070] = { 7602, 10, "0", "", "Dawnchaser Retreat" },
	[51407721] = { 7602, 11, "0", "", "Marista" },
	[61002510] = { 7602, 12, "0", "", "Thunder Cleft" },
	[75900691] = { 7602, 13, "0", "", "Zhu's Watch" },
}
points[ 379 ] = { -- Kun-Lai Summit
	[72709220] = { 7601, 12, "0", "", "Binan Village" },
	[64206120] = { 7601, 13, "0", "", "The Grummle Bazaar" },
	[57405990] = { 7601, 14, "0", "", "One Keg" },
	[54108280] = { 7601, 15, "0", "", "Westwind Rest" },
	[62302900] = { 7601, 16, "0", "", "Zouchin Village" },
	[72709221] = { 7602, 14, "0", "", "Binan Village" },
	[62808050] = { 7602, 15, "0", "", "Eastwind Rest" },
	[64206121] = { 7602, 16, "0", "", "The Grummle Bazaar" },
	[57405991] = { 7602, 17, "0", "", "One Keg" },
	[62302901] = { 7602, 18, "0", "", "Zouchin Village" },
}
points[ 433 ] = { -- The Veiled Stair
	[55007220] = { 7601, 17, "0", "", "Tavern in the Mists" },
	[55007221] = { 7602, 19, "0", "", "Tavern in the Mists" },
}
points[ 388 ] = { -- Townlong Steppes
	[71105780] = { 7601, 18, "0", "", "Longying Outpost" },
	[71105781] = { 7602, 20, "0", "", "Longying Outpost" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[35107770] = { 7601, 19, "0", "", "Mistfall Village" },
	[87006900] = { 7601, 20, "0", "", "Shrine of Seven Stars" },
	[35107771] = { 7602, 21, "0", "", "Mistfall Village" },
	[62001630] = { 7602, 22, "0", "", "Shrine of Two Moons" },
}
points[ 376 ] = { -- Valley of the Four Winds
	[83602010] = { 7601, 21, "0", "", "Pang's Stead" },
	[19805570] = { 7601, 22, "0", "", "Stoneplow" },
	[83602011] = { 7602, 23, "0", "", "Pang's Stead" },
	[19805571] = { 7602, 24, "0", "", "Stoneplow" },
}
points[ 424 ] = { -- Pandaria continent map hacks
	-- Dread Wastes
	[36136200] = { 7602, 1, "0", "", "Klaxxi'vess" },
	-- The Jade Forest
	[71635776] = { 7602, 7, "0", "", "Jade Temple Grounds" },
	[72134025] = { 7602, 8, "0", "", "Sri-La Village" },
	[65783967] = { 7602, 9, "0", "", "Tian Monastery" },
	-- Kun-Lai Summit
	[54554746] = { 7601, 12, "0", "", "Binan Village" },
	[48383443] = { 7602, 17, "0", "", "One Keg" },
	-- Krasarang Wilds
	[60356774] = { 7601, 11, "0", "", "Zhu's Watch" },
	-- Vale of Eternal Blossoms
	[46155843] = { 7602, 21, "0", "", "Mistfall Village" },
	-- The Veiled Stair
	[57545660] = { 7601, 17, "0", "", "Tavern in the Mists" },
	-- Valley of the Four Winds
	[44166808] = { 7601, 22, "0", "", "Stoneplow" },
}
-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
texturesL[1] = "Interface\\PlayerFrame\\MonkLightPower"
texturesL[2] = "Interface\\PlayerFrame\\MonkDarkPower"
texturesL[3] = "Interface\\Common\\Indicator-Red"
texturesL[4] = "Interface\\Common\\Indicator-Yellow"
texturesL[5] = "Interface\\Common\\Indicator-Green"
texturesL[6] = "Interface\\Common\\Indicator-Gray"
texturesL[7] = "Interface\\Common\\Friendship-ManaOrb"	
texturesL[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
texturesL[9] = "Interface\\Store\\Category-icon-pets"
texturesL[10] = "Interface\\Store\\Category-icon-featured"
texturesL[11] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\AzerothCandySwirl"
texturesL[12] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\Pumpkin"
texturesL[13] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\EvilPumpkin"
texturesL[14] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenBat"
texturesL[15] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenCat"
texturesL[16] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenGhost"
texturesL[17] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenWitch"
texturesS[1] = "Interface\\Common\\RingBorder"
texturesS[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesS[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesS[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesS[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesS[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesS[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesS[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
texturesS[9] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\AzerothCandySwirl"
texturesS[10] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\Pumpkin"
texturesS[11] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\EvilPumpkin"
texturesS[12] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenBat"
texturesS[13] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenCat"
texturesS[14] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenGhost"
texturesS[15] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenWitch"

scalingL[1] = 0.85
scalingL[2] = 0.85
scalingL[3] = 0.83
scalingL[4] = 0.83
scalingL[5] = 0.83
scalingL[6] = 0.83
scalingL[7] = 0.95
scalingL[8] = 0.95
scalingL[9] = 1.2
scalingL[10] = 1.2
scalingL[11] = 0.75
scalingL[12] = 0.75
scalingL[13] = 0.75
scalingL[14] = 0.75
scalingL[15] = 0.75
scalingL[16] = 0.75
scalingL[17] = 0.75
scalingS[1] = 0.58
scalingS[2] = 0.77
scalingS[3] = 0.77
scalingS[4] = 0.77
scalingS[5] = 0.68
scalingS[6] = 0.65
scalingS[7] = 0.62
scalingS[8] = 0.93
scalingS[9] = 0.75
scalingS[10] = 0.75
scalingS[11] = 0.75
scalingS[12] = 0.75
scalingS[13] = 0.75
scalingS[14] = 0.75
scalingS[15] = 0.75

