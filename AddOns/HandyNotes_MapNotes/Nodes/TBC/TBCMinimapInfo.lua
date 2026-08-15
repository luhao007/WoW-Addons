local ADDON_NAME, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function ns.LoadTBCMiniMapInfo(self)
local db = ns.Addon.db.profile
local minimap = ns.minimap

    --#####################################################################################################
    --##########################        function to hide all minimap below         ##########################
    --#####################################################################################################
    if not db.activate.HideMapNote then


        --##################################################################################################
        --####################################         MiniMap         ###################################
        --##################################################################################################
		if db.activate.MiniMap then
            
            
            --###################
            --##### Kalimdor ####
            --###################
            
			if self.db.profile.showMiniMapKalimdor then


            -- Raids

                if self.db.profile.showMiniMapRaids then

                    minimap[1451][25239137] = { mnID = 1451, name = L["Temple of Ahn'Qiraj"] .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
    				minimap[1451][29049322] = { mnID = 1451, name = DUNGEON_FLOOR_RUINSOFAHNQIRAJ1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
    			    minimap[1445][52877752] = { mnID = 1445, name = DUNGEON_FLOOR_ONYXIASLAIR1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }

                end


            -- Dungeons

                if self.db.profile.showMiniMapDungeons then
                    minimap[1440][13961306] = { mnID = 1440, name = L["Blackfathom Deeps"] .. " " .. "[" .. LEVEL .. ": " .. "24-32]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "15", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
    			    minimap[1444][59034298] = { mnID = 1444, name = L["Dire Maul"] .. " " .. "[" .. LEVEL .. ": " .. "55-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "45", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1444][76883670] = { mnID = 1444, name = L["Dire Maul"] .. " " .. "[" .. LEVEL .. ": " .. "55-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "45", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1443][28986219] = { mnID = 1443, name = DUNGEON_FLOOR_MARAUDON1 .. " " .. "[" .. LEVEL .. ": " .. "46-55]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "30", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
    			    minimap[1413][49189322] = { mnID = 1413, name = DUNGEON_FLOOR_RAZORFENDOWNS1 .. " " .. "[" .. LEVEL .. ": " .. "37-46]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "35", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1413][41798934] = { mnID = 1413, name = DUNGEON_FLOOR_RAZORFENKRAUL1 .. " " .. "[" .. LEVEL .. ": " .. "29-38]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "25", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
    			    minimap[1413][45973633] = { mnID = 1413, name = DUNGEON_FLOOR_WAILINGCAVERNS1 .. " " .. "[" .. LEVEL .. ": " .. "17-24]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "10", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1446][38712008] = { mnID = 1446, name = DUNGEON_FLOOR_ZULFARRAK .. " " .. "[" .. LEVEL .. ": " .. "42-56", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "35", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                end


            -- Blizz Pois

                if self.db.profile.activate.RemoveBlizzPOIs then

                    if self.faction == "Alliance" or db.activate.EnemyFaction then
                    
                        minimap[1438][27385702] = { mnID = 1457, name = "", type = "AIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Darnassus"] .. " - " .. FACTION_ALLIANCE }
                        minimap[1943][24734852] = { mnID = 1947, name = "", type = "AIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Exodar"] .. " - " .. FACTION_ALLIANCE  .. "\n" .. "\n" .. L["Portal"] .. "\n" .. " => " .. L["Stormwind"] }
                        minimap[1943][34034427] = { mnID = 1947, name = "", type = "AIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Exodar"] .. " - " .. FACTION_ALLIANCE  .. "\n" .. "\n" .. L["Portal"] .. "\n" .. " => " .. L["Stormwind"] }

                    end

                    if self.faction == "Horde" or db.activate.EnemyFaction then
                        minimap[1411][45600899] = { mnID = 1454, name = "", type = "HIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = DUNGEON_FLOOR_ORGRIMMAR0 .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. CALENDAR_TYPE_DUNGEON .. "\n" .. " => " .. DUNGEON_FLOOR_RAGEFIRE1 } 
                    end

                end


            -- Zeppelin
                if self.db.profile.showMiniMapZeppelins then   

                    if self.faction == "Horde" or db.activate.EnemyFaction then
                        minimap[1411][50281195] = { mnID = 1434, name = "", type = "HZeppelin", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Zeppelin"] .. " - " .. FACTION_HORDE .. "\n" .. " => " .. L["Grom'gol, Stranglethorn Vale"] }
                        minimap[1411][50771406] = { mnID = 1420, name = "", type = "HZeppelin", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Zeppelin"] .. " - " .. FACTION_HORDE .. "\n" .. " => " .. L["Tirisfal Glades"] .. " - " .. L["Undercity"] }

                    end
                    
                end


            -- Ships
                if self.db.profile.showMiniMapShips then

                    minimap[1413][63803771] = { mnID = 1434, name = "", type = "Ship", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Ratchet"] .. " - " .. FACTION_NEUTRAL .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. POSTMASTER_LETTER_STRANGLETHORNVALE } -- Ship from Booty Bay to Ratchet
                

                    if self.faction == "Alliance" or db.activate.EnemyFaction then
                        minimap[1439][33273982] = { mnID = 1438, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Auberdine"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Teldrassil"] } -- 
                        minimap[1439][32294340] = { mnID = 1437, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Auberdine"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. POSTMASTER_LETTER_WETLANDS } -- 
                        minimap[1438][55039414] = { mnID = 1439, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Teldrassil"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Auberdine"] } -- Ship from Booty Bay to Ratchet
                        minimap[1445][71835683] = { mnID = 1437, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Theramore Isle"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. POSTMASTER_LETTER_WETLANDS } -- Ship from Dustwallow Marsh to Menethil Harbor
                        minimap[1444][43334275] = { name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = DUNGEON_FLOOR_NIGHTMARERAID9 .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Feathermoon Stronghold"] } -- Ship from Feralas to Feathermoon
                        minimap[1444][31023982] = { name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Feathermoon Stronghold"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. DUNGEON_FLOOR_NIGHTMARERAID9 } -- Ship from Feathermoon to Feralas
                        minimap[1438][51938943] = { mnID = 1943, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Ship"] .. "\n" .. " => " .. L["Azuremyst Isle"] } -- Ship from Booty Bay to Ratchet
                        minimap[1943][20065421] = { mnID = 1439, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Ship"] .. "\n" .. " => " .. L["Rut'theran"] } --

                    end

                end

            end


            --##########################
            --##### Eastern Kingdom ####
            --##########################

            if self.db.profile.showMiniMapEasternKingdom then


            -- Raids            

                if self.db.profile.showMiniMapRaids then

				    minimap[1427][34958438] = { mnID = 1428, name = DUNGEON_FLOOR_MOLTENCORE1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1428][29383823] = { mnID = 1428, name = DUNGEON_FLOOR_MOLTENCORE1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1434][53731730] = { mnID = 1434, name = DUNGEON_FLOOR_ZULGURUB1 .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1423][38962562] = { mnID = 1423, name = L["Naxxramas"] .. " " .. "[" .. LEVEL .. ": " .. "60+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1942][82156413] = { mnID = 1942, name = DUNGEON_FLOOR_ZULAMAN1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1957][44134538] = { mnID = 1957, name = DUNGEON_FLOOR_SUNWELLPLATEAU0 .. " " .. "[" .. LEVEL .. ": " .. "70+]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true }

                end


            -- Dungeons

                if self.db.profile.showMiniMapDungeons then
                    minimap[1421][44746773] = { mnID = 1421, name = L["Shadowfang Keep"] .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "14", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1422][68887290] = { mnID = 1422, name = L["Scholomance"] .. " " .. "[" .. LEVEL .. ": " .. "58-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "48", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1420][82603359] = { mnID = 1420, name = DUNGEON_FLOOR_TIRISFAL13 .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "21", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1423][31231582] = { mnID = 1423, name = DUNGEON_FLOOR_COTSTRATHOLME1 .. " " .. "[" .. LEVEL .. ": " .. "58-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "48", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1423][47942391] = { mnID = 1423, name = DUNGEON_FLOOR_COTSTRATHOLME1 .. " " .. "[" .. LEVEL .. ": " .. "58-60]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "48", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1435][69195221] = { mnID = 1435, name = DUNGEON_FLOOR_THETEMPLEOFATALHAKKAR1 .. " " .. "[" .. LEVEL .. ": " .. "50-56]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "45", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1418][44441195] = { mnID = 1418, name = DUNGEON_FLOOR_BADLANDS18 .. " " .. "[" .. LEVEL .. ": " .. "41-51]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "30", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1418][64884316] = { mnID = 1418, name = DUNGEON_FLOOR_BADLANDS18 .. " " .. "[" .. LEVEL .. ": " .. "41-51]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "30", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1426][24243984] = { mnID = 1426, name = DUNGEON_FLOOR_DUNMOROGH10 .. " " .. "[" .. LEVEL .. ": " .. "29-38]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "19", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1436][42407161] = { mnID = 1436, name = DUNGEON_FLOOR_THEDEADMINES1 .. " " .. "[" .. LEVEL .. ": " .. "17-26]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "10", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    minimap[1957][61243079] = { mnID = 1957, name = L["Magisters' Terrace"] .. " " .. "[" .. LEVEL .. ": " .. "70]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "70", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }

                end

                if self.db.profile.showMiniMapMultiple then
				    minimap[1427][34958438] = { mnID = 1427, name = "", dnID = DUNGEON_FLOOR_MOLTENCORE1 .. " " .. "[" .. LEVEL .. ": " .. "60+]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES15 .. " " .. "[" .. LEVEL .. ": " .. "60+]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES14 .. " " .. "[" .. LEVEL .. ": " .. "55-60]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES16 .. " " .. "[" .. LEVEL .. ": " .. "52-60]", type = "MultipleM", showInZone = false, showOnContinent = false, showOnMinimap = true }
				    minimap[1428][29383823] = { mnID = 1428, name = "", dnID = DUNGEON_FLOOR_MOLTENCORE1 .. " " .. "[" .. LEVEL .. ": " .. "60+]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES15 .. " " .. "[" .. LEVEL .. ": " .. "60+]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES14 .. " " .. "[" .. LEVEL .. ": " .. "55-60]" .. "\n" .. DUNGEON_FLOOR_BURNINGSTEPPES16 .. " " .. "[" .. LEVEL .. ": " .. "52-60]", type = "MultipleM", showInZone = false, showOnContinent = false, showOnMinimap = true }
                end


            -- Blizz POIS

                if self.db.profile.activate.RemoveBlizzPOIs then

                    if self.faction == "Horde" or db.activate.EnemyFaction then
                      minimap[1420][61806939] = { mnID = 1458, name = "", type = "HIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Undercity"] .. " - " .. FACTION_HORDE }
                    end
        
                    if self.faction == "Alliance" or db.activate.EnemyFaction then
                      minimap[1426][54353411] = { mnID = 1455, name = "", type = "AIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Ironforge"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. DUNGEON_FLOOR_DEEPRUNTRAM1 .. "\n" .. " => " .. L["Stormwind"] } -- Transport to Ironforge Carriage 
                      minimap[1429][24793263] = { mnID = 1453, name = "", type = "AIcon", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Stormwind"] .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. DUNGEON_FLOOR_DEEPRUNTRAM1 .. "\n" .. " => " .. L["Ironforge"] .. "\n" .. "\n" .. CALENDAR_TYPE_DUNGEON .. "\n" .. " => " .. DUNGEON_FLOOR_THESTOCKADE1 }
                    end

                end

            -- Dungeons and not Blizz for Stockade

                if self.db.profile.showMiniMapDungeons and not self.db.profile.activate.RemoveBlizzPOIs then
                
                    if self.db.profile.showMiniMapDungeons then
                        minimap[1429][24793263] = { mnID = 1453, name = DUNGEON_FLOOR_THESTOCKADE1 .. " " .. "[" .. LEVEL .. ": " .. "22-30]", dnID = REQUIRES_LABEL .. " " .. MINIMUM .. " " .. LEVEL .. " " .. "15", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true }
                    end
                end


            -- Zeppelin
                if self.db.profile.showMiniMapZeppelins then   

                    if self.faction == "Horde" or db.activate.EnemyFaction then

                        minimap[1420][60565871] = { mnID = 1411, name = "", type = "HZeppelin", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Tirisfal Glades"] .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. L["Zeppelin"] .. "\n" .. " => " .. L["Durotar"] }
                        minimap[1420][62025913] = { mnID = 1415, name = "", type = "HZeppelin", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Tirisfal Glades"] .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. L["Zeppelin"] .. "\n" .. " => " .. L["Grom'gol, Stranglethorn Vale"]}
                        minimap[1434][31552891] = { mnID = 1420, name = "", type = "HZeppelin", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Grom'gol, Stranglethorn Vale"] .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. L["Zeppelin"] .. "\n" .. " => " .. L["Tirisfal Glades"] .. " - " .. L["Undercity"] }
                        minimap[1434][31223030] = { mnID = 1411, name = "", type = "HZeppelin", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = L["Grom'gol, Stranglethorn Vale"] .. " - " .. FACTION_HORDE .. "\n" .. "\n" .. L["Zeppelin"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0 }

                    end

                end

            -- Ships
                if self.db.profile.showMiniMapShips then

                    minimap[1434][25677301] = { mnID = 1413, name = "", type = "Ship", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = POSTMASTER_LETTER_STRANGLETHORNVALE .. " - " .. FACTION_NEUTRAL .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Ratchet"] } -- Ship from Booty Bay to Ratchet
                    
                    if self.faction == "Alliance" or db.activate.EnemyFaction then
                        minimap[1437][04896329] = { mnID = 1445, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = POSTMASTER_LETTER_WETLANDS .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Theramore Isle"] } -- Ship from Menethil Harbor to Howling Fjord and Dustwallow Marsh
                        minimap[1437][04455693] = { mnID = 1445, name = "", type = "AShip", showInZone = false, showOnContinent = false, showOnMinimap = true, TransportName = POSTMASTER_LETTER_WETLANDS .. " - " .. FACTION_ALLIANCE .. "\n" .. "\n" .. L["Ship"] .. "\n" .. " => " .. L["Auberdine"] } -- Ship from Menethil Harbor to Howling Fjord and Dustwallow Marsh

                    end

                end

            end


            --###################
            --##### Outland ####
            --###################
            
            if self.db.profile.showZoneOutland then
    
            -- Outland Dungeons
                if self.db.profile.showZoneDungeons then
                    minimap[1952][34306560] = { mnID = 1952, name = L["Auchenai Crypts"] .. " " .. "[" .. LEVEL .. ": " .. "65-67]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Auchenai Crypts 
                    minimap[1952][39705770] = { mnID = 1952, name = DUNGEON_FLOOR_MANATOMBS1 .. " " .. "[" .. LEVEL .. ": " .. "64-66]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Mana-Tombs 
                    minimap[1952][44906560] = { mnID = 1952, name = L["Sethekk Halls"] .. " " .. "[" .. LEVEL .. ": " .. "67-69]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Sethekk Halls 
                    minimap[1952][39607360] = { mnID = 1952, name = DUNGEON_FLOOR_SHADOWLABYRINTH1 .. " " .. "[" .. LEVEL .. ": " .. "69-70]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Shadow Labyrinth 
                    minimap[1953][71705500] = { mnID = 1953, name = DUNGEON_FLOOR_THEBOTANICA1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Botanica 
                    minimap[1953][70606980] = { mnID = 1953, name = DUNGEON_FLOOR_THEMECHANAR1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Mechanar  
                    minimap[1953][74405770] = { mnID = 1953, name = L["The Arcatraz"] .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Arcatraz
                    minimap[1944][45985183] = { mnID = 1944, name = DUNGEON_FLOOR_THEBLOODFURNACE1 .. " " .. "[" .. LEVEL .. ": " .. "61-63]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Blood Furnace 
                    minimap[1944][47575360] = { mnID = 1944, name = DUNGEON_FLOOR_HELLFIRERAMPARTS1 .. " " .. "[" .. LEVEL .. ": " .. "60-62]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Hellfire Ramoarts
                    minimap[1944][47025203] = { mnID = 1944, name = DUNGEON_FLOOR_THESHATTEREDHALLS1 .. " " .. "[" .. LEVEL .. ": " .. "69-70]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Shattered Halls  
                    minimap[1946][48903570] = { mnID = 1946, name = DUNGEON_FLOOR_THESLAVEPENS1 .. " " .. "[" .. LEVEL .. ": " .. "62-64]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Arcatraz
                    minimap[1946][50303330] = { mnID = 1946, name = DUNGEON_FLOOR_THESTEAMVAULT1 .. " " .. "[" .. LEVEL .. ": " .. "68-70]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Blood Furnace 
                    minimap[1946][54203450] = { mnID = 1946, name = DUNGEON_FLOOR_THEUNDERBOG1 .. " " .. "[" .. LEVEL .. ": " .. "63-65]", type = "Dungeon", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Hellfire Ramoarts
                end
            
            -- Outland Raids
                if self.db.profile.showZoneRaids then
                    minimap[1953][73806380] = { mnID = 1953, name = DUNGEON_FLOOR_TEMPESTKEEP1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Eye  
                    minimap[1948][71004660] = { mnID = 1948, name = L["Black Temple"] .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Black Temple 
                    minimap[1949][69302370] = { mnID = 1949, name = DUNGEON_FLOOR_GRUULSLAIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Gruul's Lairend
                    minimap[1944][46555286] = { mnID = 1944, name = DUNGEON_FLOOR_MAGTHERIDONSLAIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Hellfire Ramparts, The Blood Furnace, The Shattered Halls, Magtheridon's Lair 
                    minimap[1946][51903280] = { mnID = 1946, name = DUNGEON_FLOOR_COILFANGRESERVOIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]", type = "Raid", showInZone = false, showOnContinent = false, showOnMinimap = true } -- The Shattered Halls  
                end
            
            
            -- Outland Multiple
                if self.db.profile.showZoneMultiple then
                    minimap[1946][50104095] = { mnID = 1946, name = "", dnID = DUNGEON_FLOOR_COILFANGRESERVOIR1 .. " " .. "[" .. LEVEL .. ": " .. "70]" .. "\n" .. DUNGEON_FLOOR_THESTEAMVAULT1 .. " " .. "[" .. LEVEL .. ": " .. "68-70]" .. "\n" .. DUNGEON_FLOOR_THESLAVEPENS1 .. " " .. "[" .. LEVEL .. ": " .. "62-64]" .. "\n" .. DUNGEON_FLOOR_THEUNDERBOG1 .. " " .. "[" .. LEVEL .. ": " .. "63-65]", type = "MultipleM", showInZone = false, showOnContinent = false, showOnMinimap = true } -- Slave Pens, The Steamvault, The Underbog, Serpentshrine Cavern
                end
            
            -- Outland Portals
                if self.db.profile.showZonePortals then
                    minimap[1952][29602266] = { mnID = 1955, name = "", type = "Portal", TransportName = L["Shattrath City"] .. "\n" .. "\n" .. L["Portals"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0  .. "\n" .. "\n" .. " => " .. L["Stormwind"] .. "\n" .. "\n" .. " => " .. L["Isle of Quel'Danas"], showInZone = false, showOnContinent = false, showOnMinimap = true } -- Portal from Shattrath to Orgrimmar

                    if self.faction == "Horde" or db.activate.EnemyFaction then
                        minimap[1945][69025178] = { mnID = 1454, name = "", type = "HPortal", TransportName = L["Hellfire Peninsula"] .. " " .. L["Portal"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0, showInZone = false, showOnContinent = false, showOnMinimap = true } -- Portal from Hellfire to Orgrimmar 
                        minimap[1944][88574770] = { mnID = 1454, name = "", type = "HPortal", TransportName = L["Hellfire Peninsula"] .. " " .. L["Portal"] .. "\n" .. " => " .. DUNGEON_FLOOR_ORGRIMMAR0, showInZone = false, showOnContinent = false, showOnMinimap = true } -- Portal from Hellfire to Orgrimmar 
                    end
            
                    if self.faction == "Alliance" or db.activate.EnemyFaction then
                        minimap[1945][68905259] = { mnID = 1453,  name = "" , type = "APortal", TransportName = L["Hellfire Peninsula"] .. " " .. L["Portal"] .. "\n" .. " => " .. L["Stormwind"], showInZone = false, showOnContinent = false, showOnMinimap = true } -- Portal from Hellfire to Stormwind
                        minimap[1944][88615281] = { mnID = 1453,  name = "" , type = "APortal", TransportName = L["Hellfire Peninsula"] .. " " .. L["Portal"] .. "\n" .. " => " .. L["Stormwind"], showInZone = false, showOnContinent = false, showOnMinimap = true } -- Portal from Hellfire to Stormwind                   
                    end

                end
        
            end -- if self.db.profile.showZoneOutland then

        end
    end
end