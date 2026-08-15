local ADDON_NAME, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function ns.LoadTBCContinentInfo(self)
local db = ns.Addon.db.profile
local nodes = ns.nodes

  --#####################################################################################################
  --##########################        function to hide all nodes below         ##########################
  --#####################################################################################################
  if not db.activate.HideMapNote then


  --##################################################################################################
  --####################################         Continent         ###################################
  --##################################################################################################
		if db.activate.Continent then
            
            
    --###################
    --##### Kalimdor ####
    --###################        
			if self.db.profile.showContinentKalimdor then


        -- Raids
        if self.db.profile.showContinentRaids then

          nodes[1414][40808546] = { mnID = 1451, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Temple of Ahn'Qiraj"] .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid" }
    			nodes[1414][42408638] = { mnID = 1451, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_RUINSOFAHNQIRAJ1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid" }
    			nodes[1414][56327161] = { mnID = 1445, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_ONYXIASLAIR1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid" }
        end


        -- Dungeons

        if self.db.profile.showContinentDungeons then
          nodes[1414][43763504] = { mnID = 1440, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Blackfathom Deeps"] .. " " .. "[" .. LEVEL .. ": " .. "24-32]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "15", type = "Dungeon" }
    		  nodes[1414][42537013] = { mnID = 1444, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Dire Maul"] .. " " .. "[" .. LEVEL .. ": " .. "55-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "45", type = "Dungeon" }
          nodes[1414][45976847] = { mnID = 1444, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Dire Maul"] .. " " .. "[" .. LEVEL .. ": " .. "55-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "45", type = "Dungeon" }
          nodes[1414][38225775] = { mnID = 1443, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_MARAUDON1 .. " " .. "[" .. LEVEL .. ": " .. "46-55]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "30", type = "Dungeon" }
    		  nodes[1414][52757105] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_RAZORFENDOWNS1 .. " " .. "[" .. LEVEL .. ": " .. "37-46]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "35", type = "Dungeon" }
          nodes[1414][50657013] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_RAZORFENKRAUL1 .. " " .. "[" .. LEVEL .. ": " .. "29-38]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "25", type = "Dungeon" }
    		  nodes[1414][51885554] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_WAILINGCAVERNS1 .. " " .. "[" .. LEVEL .. ": " .. "17-24]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "10", type = "Dungeon" }
          nodes[1414][54107955] = { mnID = 1446, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_ZULFARRAK .. " " .. "[" .. LEVEL .. ": " .. "42-56", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "35", type = "Dungeon" }
    		  --nodes[1414][58164464] = { mnID = 1454, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_RAGEFIRE1 .. " " .. "[" .. LEVEL .. ": " .. "13-18]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "8", type = "Dungeon" }
        end


        -- Blizz Pois
        if self.db.profile.activate.RemoveBlizzPOIs then

          if self.faction == "Alliance" or db.activate.EnemyFaction then
            nodes[1414][39941176] = { mnID = 1457, name = "", type = "AIcon", showOnContinent = true, showInZone = false, showOnMinimap = false, TransportName = L["Darnassus"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Portal"] .. "\n" .. " => " .. L["Blasted Lands"] }
            nodes[1414][29842672] = { mnID = 1943, name = "", type = "AIcon", showOnContinent = true, showInZone = false, showOnMinimap = false, TransportName = L["Exodar"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Portal"] .. "\n" .. " => " .. L["Stormwind"] }
          end

          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1414][58164464] = { mnID = 1454, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HIcon" , TransportName = DUNGEON_FLOOR_ORGRIMMAR0 .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. CALENDAR_TYPE_DUNGEON .. "\n" .. " => " .. DUNGEON_FLOOR_RAGEFIRE1 } 
            nodes[1414][46965720] = { mnID = 1456, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HIcon" , TransportName = L["Thunder Bluff"] .. " - " .. FACTION_HORDE } 
          end

        end


        -- Dungeons and not Blizz for Ragefire

        if self.db.profile.showContinentDungeons and not self.db.profile.activate.RemoveBlizzPOIs then
                
          if self.db.profile.showContinentDungeons then
            nodes[1414][58164464] = { mnID = 1454, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_RAGEFIRE1 .. " " .. "[" .. LEVEL .. ": " .. "13-18]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "8", type = "Dungeon" }
          end
        end

        -- Zeppelin
        if self.db.profile.showContinentZeppelins then   

          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1414][59154686] = { mnID = 1411, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HZeppelin" , TransportName = L["Durotar"] .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. L["Zeppelin"] .. "\n" .. " => " .. L["Grom'gol, Stranglethorn Vale"] .. "\n" .. " => " .. L["Tirisfal Glades"] .. " - " .. L["Undercity"] }
          end     
        end


        -- Ships
        if self.db.profile.showContinentShips then

        nodes[1414][57305757] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "Ship" , TransportName = L["Ratchet"] .. " - " .. FACTION_NEUTRAL .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. POSTMASTER_LETTER_STRANGLETHORNVALE } -- Ship from Booty Bay to Ratchet

        if self.faction == "Alliance" or db.activate.EnemyFaction then
          nodes[1414][44132395] = { mnID = 1439, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "AShip" , TransportName = L["Auberdine"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Teldrassil"] .. "\n" .. " => " .. POSTMASTER_LETTER_WETLANDS } -- Ship from Booty Bay to Ratchet
          nodes[1414][43761657] = { mnID = 1438, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "AShip" , TransportName = L["Teldrassil"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Auberdine"] } -- Ship from Booty Bay to Ratchet
          nodes[1414][59036699] = { mnID = 1445, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "AShip" , TransportName = L["Theramore Isle"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. POSTMASTER_LETTER_WETLANDS } -- Ship from Dustwallow Marsh to Menethil Harbor
          nodes[1414][28682746] = { mnID = 1438, name = "", type = "AShip", showOnContinent = true, showInZone = false, showOnMinimap = false, TransportName = L["Ship"] .. "\n" .. " => " .. L["Rut'theran"] } --
          nodes[1414][42701806] = { mnID = 1438, name = "", type = "AShip", showOnContinent = true, showInZone = false, showOnMinimap = false, TransportName = L["Teldrassil"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Azuremyst Isle"] } -- Ship from Booty Bay to Ratchet
        end
      end

      -- Flight Point
        if self.db.profile.showContinentFP then
          nodes[1414][56535547] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- Barrens
          nodes[1414][49377682] = { mnID = 1449, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- Un'Goro

          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1414][58732404] = { mnID = 1452, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Winterquell
            nodes[1414][52012152] = { mnID = 1450, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Moonglade
            nodes[1414][47163133] = { mnID = 1448, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Felwood
            nodes[1414][53174261] = { mnID = 1440, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Ashenvale
            nodes[1414][43713806] = { mnID = 1440, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Ashenvale
            nodes[1414][58303690] = { mnID = 1447, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Azshara
            nodes[1414][43534767] = { mnID = 1442, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Stonetalon Mountains
            nodes[1414][53505339] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Barrens
            nodes[1414][51416133] = { mnID = 1413, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Barrens
            nodes[1414][45995653] = { mnID = 1412, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Thunder Bluff
            nodes[1414][37375893] = { mnID = 1443, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Desolace
            nodes[1414][45746965] = { mnID = 1444, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Feralas
            nodes[1414][44027925] = { mnID = 1451, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Silithus
            nodes[1414][54126447] = { mnID = 1445, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Dustwood
            nodes[1414][52767389] = { mnID = 1441, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Thousend Needles
            nodes[1414][56468017] = { mnID = 1446, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Tanaris
          end

          if self.faction == "Alliance" or db.activate.EnemyFaction then
            nodes[1414][32352691] = { mnID = 1943, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Winterquell
            nodes[1414][30881771] = { mnID = 1950, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Winterquell
            nodes[1414][59412402] = { mnID = 1452, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Winterquell
            nodes[1414][53252125] = { mnID = 1450, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Moonglade
            nodes[1414][44632569] = { mnID = 1439, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Auberdine
            nodes[1414][51652642] = { mnID = 1448, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Felwood
            nodes[1414][47164028] = { mnID = 1440, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Ashenvale
            nodes[1414][56894065] = { mnID = 1447, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Azshara
            nodes[1414][42364083] = { mnID = 1442, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Stonetalon Mountains
            nodes[1414][42855117] = { mnID = 1443, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Desolace
            nodes[1414][48497019] = { mnID = 1444, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Feralas
            nodes[1414][37266966] = { mnID = 1444, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Feralas
            nodes[1414][44517888] = { mnID = 1451, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Silithus
            nodes[1414][58676743] = { mnID = 1445, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Dustwood
            nodes[1414][56468147] = { mnID = 1446, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Tanaris
            nodes[1414][44141645] = { mnID = 1438, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Teldrassil
          end
        end
      end


    --##########################
    --##### Eastern Kingdom ####
    --##########################
      if self.db.profile.showContinentEasternKingdom then


      -- Raids            
        if self.db.profile.showContinentRaids then
				  nodes[1415][47316955] = { mnID = 1428, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_MOLTENCORE1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid" }
          nodes[1415][47438463] = { mnID = 1434, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_ZULGURUB1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid" }
          nodes[1415][53692948] = { mnID = 1423, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Naxxramas"] .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid" }
          nodes[1415][54470345] = { mnID = 1957, name = DUNGEON_FLOOR_SUNWELLPLATEAU0 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showOnContinent = true, showInZone = false, showOnMinimap = false}
          nodes[1415][57922488] = { mnID = 1942, name = DUNGEON_FLOOR_ZULAMAN1 .. " " .. "[" .. LEVEL .. ": " .. "70]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "70", type = "Raid", showOnContinent = true, showInZone = false, showOnMinimap = false}
        end

      -- Dungeons
        if self.db.profile.showContinentDungeons then
          nodes[1415][40694180] = { mnID = 1421, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Shadowfang Keep"] .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "14", type = "Dungeon" }
				  nodes[1415][50743629] = { mnID = 1422, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Scholomance"] .. " " .. "[" .. LEVEL .. ": " .. "58-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "48", type = "Dungeon" }
				  nodes[1415][46083040] = { mnID = 1420, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_TIRISFAL13 .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "21", type = "Dungeon" }
				  nodes[1415][52582838] = { mnID = 1423, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_COTSTRATHOLME1 .. " " .. "[" .. LEVEL .. ": " .. "58-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "48", type = "Dungeon" }
				  nodes[1415][54542875] = { mnID = 1423, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_COTSTRATHOLME1 .. " " .. "[" .. LEVEL .. ": " .. "58-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "48", type = "Dungeon" }
				  nodes[1415][53817914] = { mnID = 1435, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_THETEMPLEOFATALHAKKAR1 .. " " .. "[" .. LEVEL .. ": " .. "50-56]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "45", type = "Dungeon" }
				  nodes[1415][52216332] = { mnID = 1418, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_BADLANDS18 .. " " .. "[" .. LEVEL .. ": " .. "41-51]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "30", type = "Dungeon" }
				  nodes[1415][53696534] = { mnID = 1418, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_BADLANDS18 .. " " .. "[" .. LEVEL .. ": " .. "41-51]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "30", type = "Dungeon" }
          nodes[1415][43025983] = { mnID = 1426, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_DUNMOROGH10 .. " " .. "[" .. LEVEL .. ": " .. "29-38]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "19", type = "Dungeon" }
          nodes[1415][40818171] = { mnID = 1436, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_THEDEADMINES1 .. " " .. "[" .. LEVEL .. ": " .. "17-26]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "10", type = "Dungeon" }
          --nodes[1415][42657289] = { mnID = 1453, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_THESTOCKADE1 .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "15", type = "Dungeon" }
          nodes[1415][56190253] = { mnID = 1957, name = L["Magisters' Terrace"] .. " " .. "[" .. LEVEL .. ": " .. "70]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "70", type = "Dungeon", showOnContinent = true, showInZone = false, showOnMinimap = false}
        end

        if self.db.profile.showContinentMultiple then
				  nodes[1415][47316955] = { mnID = 1428, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", dnID = DUNGEON_FLOOR_MOLTENCORE1 .. " " .. "[" .. LEVEL .. ": " .. "60+]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES15 .. " " .. "[" .. LEVEL .. ": " .. "60+]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES14 .. " " .. "[" .. LEVEL .. ": " .. "55-60]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES16 .. " " .. "[" .. LEVEL .. ": " .. "52-60]", type = "MultipleM" }
        end

        -- Blizz POIS
        if self.db.profile.activate.RemoveBlizzPOIs then

          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1415][56141401] = { mnID = 1954, name = "", type = "HIcon", showOnContinent = true, showInZone = false, showOnMinimap = false, TransportName = L["Silvermoon City"] .. " - " .. FACTION_HORDE  .. "\n" .. "\n" .. L["Portal"] .. "\n" .. " => " .. L["Undercity"] .. "\n" .. " => " .. L["Blasted Lands"]  }
            nodes[1415][43753592] = { mnID = 1458, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HIcon" , TransportName = L["Undercity"] .. " - " .. FACTION_HORDE }
          end
        
          if self.faction == "Alliance" or db.activate.EnemyFaction then
            nodes[1415][46455946] = { mnID = 1455, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "AIcon" , TransportName = L["Ironforge"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. DUNGEON_FLOOR_DEEPRUNTRAM1 .. "\n" .. " => " .. L["Stormwind"] } -- Transport to Ironforge Carriage 
            nodes[1415][42657289] = { mnID = 1453, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "AIcon" , TransportName = L["Stormwind"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. DUNGEON_FLOOR_DEEPRUNTRAM1 .. "\n" .. " => " .. L["Ironforge"] .. "\n" .. "\n" .. CALENDAR_TYPE_DUNGEON .. "\n" .. " => " .. DUNGEON_FLOOR_THESTOCKADE1 }
          end
        end

        -- Dungeons and not Blizz for Stockade
        if self.db.profile.showContinentDungeons and not self.db.profile.activate.RemoveBlizzPOIs then  
          if self.db.profile.showContinentDungeons then
              nodes[1415][42657289] = { mnID = 1453, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_THESTOCKADE1 .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "15", type = "Dungeon" }
          end
        end


        -- Zeppelin
        if self.db.profile.showContinentZeppelins then   
          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1415][43753371] = { mnID = 1420, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HZeppelin" , TransportName = L["Tirisfal Glades"] .. " " .. L["Zeppelin"] .. "\n" .. " => " .. L["Grom'gol, Stranglethorn Vale"] .. "\n" .. " => " .. L["Durotar"] }
            nodes[1415][43758668] = { mnID = 1434, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HZeppelin" , TransportName = L["Grom'gol, Stranglethorn Vale"] .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. L["Zeppelin"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0.. "\n" .. " => " .. L["Tirisfal Glades"] .. " - " .. L["Undercity"] }
          end
        end


        -- Continent Eastern Kingdom Transport and not RemoveBlizzPOIs
        if self.db.profile.showContinentTransport and not self.db.profile.activate.RemoveBlizzPOIs then

          if self.faction == "Alliance" or db.activate.EnemyFaction then
              nodes[1415][46455946] = { mnID = 1455, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "Carriage" , TransportName = L["Ironforge"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. DUNGEON_FLOOR_DEEPRUNTRAM1 .. "\n" .. " => " .. L["Stormwind"] } -- Transport to Ironforge Carriage 
              nodes[1415][42657289] = { mnID = 1429, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "Carriage" , TransportName = L["Stormwind"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. DUNGEON_FLOOR_DEEPRUNTRAM1 .. "\n" .. " => " .. L["Ironforge"] } -- Transport to Ironforge Carriage 
          end
        end


        -- Ships
        if self.db.profile.showContinentShips then
          nodes[1415][41799438] = { mnID = 1434, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "Ship" , TransportName = POSTMASTER_LETTER_STRANGLETHORNVALE .. " - " .. FACTION_NEUTRAL .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Ratchet"] } -- Ship from Booty Bay to Ratchet
                    
          if self.faction == "Alliance" or db.activate.EnemyFaction then
            nodes[1415][45845447] = { mnID = 1437, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "AShip" , TransportName = POSTMASTER_LETTER_WETLANDS .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ships"] .. "\n" .. " => " .. L["Theramore Isle"] .. "\n" .. " => " .. L["Auberdine"] } -- Ship from Menethil Harbor to Howling Fjord and Dustwallow Marsh
          end
        end


        -- Flight Point
        if self.db.profile.showContinentFP then
          nodes[1415][57002468] = { mnID = 1942, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1415][54910171] = { mnID = 1957, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 

          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1415][55521530] = { mnID = 1941, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1415][54792176] = { mnID = 1442, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1415][44003461] = { mnID = 1458, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Undercity
            nodes[1415][57613240] = { mnID = 1423, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Eastern Plaquelands
            nodes[1415][40573923] = { mnID = 1421, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Silverwood
            nodes[1415][56024309] = { mnID = 1425, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Hinterlands
            nodes[1415][52954438] = { mnID = 1417, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Arathi Highlands
            nodes[1415][46454089] = { mnID = 1424, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Hillsb
            nodes[1415][47196498] = { mnID = 1427, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Sengende Schlucht
            nodes[1415][49766534] = { mnID = 1418, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Badlands
            nodes[1415][49896866] = { mnID = 1428, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Burning Stepps
            nodes[1415][52587932] = { mnID = 1435, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Swamp of 
            nodes[1415][43269385] = { mnID = 1434, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Stranglethorn Vale
            nodes[1415][44128668] = { mnID = 1434, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- Stranglethorn Vale
          end

          if self.faction == "Alliance" or db.activate.EnemyFaction then
            --nodes[1415][47475262] = { mnID = 1455, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Ironfrge
            --nodes[1415][43336816] = { mnID = 1453, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Stormwind
            nodes[1415][48053757] = { mnID = 1422, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- W-Plaquelands
            nodes[1415][57493259] = { mnID = 1423, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Eastern Plaquelands
            nodes[1415][49273994] = { mnID = 1425, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Hinterlands
            nodes[1415][50624546] = { mnID = 1417, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Arathi Highlands
            nodes[1415][45474346] = { mnID = 1424, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Hillsb
            nodes[1415][46455486] = { mnID = 1437, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Wetlands
            nodes[1415][51606093] = { mnID = 1432, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Loch Modan
            nodes[1415][47316516] = { mnID = 1427, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Sengende Schlucht
            nodes[1415][51237157] = { mnID = 1428, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Burning Stepps
            nodes[1415][50017583] = { mnID = 1433, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Redridge Mountains
            nodes[1415][47567969] = { mnID = 1431, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Dämmerwood
            nodes[1415][41928024] = { mnID = 1436, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Westfall
            nodes[1415][52838208] = { mnID = 1419, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Blasted Lands
            nodes[1415][43519440] = { mnID = 1434, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- Stranglethorn Vale
           end

        end

    end


    --############################
    --##### Continent Outland ####
    --############################
    
      if self.db.profile.showContinentOutland then
    
      -- Outland Dungeons
        if self.db.profile.showContinentDungeons then
          nodes[1945][44447844] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Auchenai Crypts"] .. " " .. "[" .. LEVEL .. ": " .. "65-67]", type = "Dungeon" } -- Auchenai Crypts 
          nodes[1945][46167604] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_MANATOMBS1 .. " " .. "[" .. LEVEL .. ": " .. "64-66]", type = "Dungeon" } -- Mana-Tombs 
          nodes[1945][47647863] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Sethekk Halls"] .. " " .. "[" .. LEVEL .. ": " .. "67-69]", type = "Dungeon" } -- Sethekk Halls 
          nodes[1945][46168103] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_SHADOWLABYRINTH1 .. " " .. "[" .. LEVEL .. ": " .. "69-70]", type = "Dungeon" } -- Shadow Labyrinth 
          nodes[1945][65862008] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_THEBOTANICA1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Dungeon" } -- The Botanica 
          nodes[1945][65622506] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_THEMECHANAR1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Dungeon" } -- The Mechanar  
          nodes[1945][66722118] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["The Arcatraz"] .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Dungeon" } -- The Arcatraz
        end
      
      -- Outland Raids
        if self.db.profile.showContinentRaids then
          nodes[1945][66482303] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_TEMPESTKEEP1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid" } -- The Eye  
          nodes[1945][72638103] = { mnID = 1948, showOnContinent = true, showInZone = false, showOnMinimap = false, name = L["Black Temple"] .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid" } -- Black Temple 
          nodes[1945][45421915] = { mnID = 1949, showOnContinent = true, showInZone = false, showOnMinimap = false, name = DUNGEON_FLOOR_GRUULSLAIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid" } -- Gruul's Lairend
        end
  
      -- Outland Multiple
        if self.db.profile.showContinentMultiple then
          nodes[1945][56635240] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", dnID = DUNGEON_FLOOR_MAGTHERIDONSLAIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]" .. "\n" .. DUNGEON_FLOOR_THEBLOODFURNACE1 .. " " .. "[" .. LEVEL .. ": " .. "61-63]" .. "\n" .. DUNGEON_FLOOR_HELLFIRERAMPARTS1 .. " " .. "[" .. LEVEL .. ": " .. "60-62]" .. "\n" .. DUNGEON_FLOOR_THESHATTEREDHALLS1 .. " " .. "[" .. LEVEL .. ": " .. "69-70]", type = "MultipleM" } -- Hellfire Ramparts, The Blood Furnace, The Shattered Halls, Magtheridon's Lair 
          nodes[1945][34344538] = { mnID = 1946, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", dnID = DUNGEON_FLOOR_COILFANGRESERVOIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]" .. "\n" .. DUNGEON_FLOOR_THESTEAMVAULT1 .. " " .. "[" .. LEVEL .. ": " .. "68-70]" .. "\n" .. DUNGEON_FLOOR_THESLAVEPENS1 .. " " .. "[" .. LEVEL .. ": " .. "62-64]" .. "\n" .. DUNGEON_FLOOR_THEUNDERBOG1 .. " " .. "[" .. LEVEL .. ": " .. "63-65]", type = "MultipleM" } -- Slave Pens, The Steamvault, The Underbog, Serpentshrine Cavern
        end
  
      -- Outland Portals
        if self.db.profile.showContinentPortals then
                   
          nodes[1945][43186573] = { mnID = 1955, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "Portal", TransportName = L["Shattrath City"] .. "\n" .. "\n" .. L["Portals"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0  .. "\n" .. "\n" .. " => " .. L["Stormwind"] .. "\n" .. "\n" .. " => " .. L["Isle of Quel'Danas"] } -- Portal from Shattrath to Orgrimmar
          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1945][69025178] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "", type = "HPortal", TransportName = L["Hellfire Peninsula"] .. " " .. L["Portal"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0 } -- Portal from Hellfire to Orgrimmar 
          end
  
          if self.faction == "Alliance" or db.activate.EnemyFaction then
            nodes[1945][68905259] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = "" , type = "APortal", TransportName = L["Hellfire Peninsula"] .. " " .. L["Portal"] .. "\n" .. " => " .. L["Stormwind"] } -- Portal from Hellfire to Stormwind
          end

        end

      -- Flight Point
        if self.db.profile.showContinentFP then
          nodes[1945][70117599] = { mnID = 1948, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1945][67668463] = { mnID = 1948, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1945][43886551] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1945][42772431] = { mnID = 1949, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1945][53562339] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1945][57361401] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 
          nodes[1945][63622413] = { mnID = 1953, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_NEUTRAL, type = "TravelL"  } -- 

          if self.faction == "Horde" or db.activate.EnemyFaction then
            nodes[1945][59697562] = { mnID = 1948, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][48907194] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][33336054] = { mnID = 1951, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][44254895] = { mnID = 1946, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][29414785] = { mnID = 1946, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][47313222] = { mnID = 1949, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][39832872] = { mnID = 1949, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][50625466] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][60806109] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][59204767] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
            nodes[1945][68285098] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_HORDE, type = "TravelH"  } -- 
          end

          if self.faction == "Alliance" or db.activate.EnemyFaction then
            nodes[1945][61788371] = { mnID = 1948, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][51977544] = { mnID = 1952, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][32357323] = { mnID = 1951, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][39464785] = { mnID = 1946, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][31864141] = { mnID = 1946, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][42533387] = { mnID = 1949, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][35303111] = { mnID = 1949, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][50014803] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][58715557] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][65704730] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
            nodes[1945][68285245] = { mnID = 1944, showOnContinent = true, showInZone = false, showOnMinimap = false, name = MINIMAP_TRACKING_FLIGHTMASTER .. " - " .. FACTION_ALLIANCE, type = "TravelA"  } -- 
           end

        end

      end -- if self.db.profile.showContinentOutland then


    end -- if db.activate.Continent then
  end -- if not db.activate.HideMapNote then
end -- function ns.LoadCataContinentInfo(self)