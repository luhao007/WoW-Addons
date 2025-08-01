-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSNpcPOI = private.NewLib("RareScannerNpcPOI")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSProfessionDB = private.ImportLib("RareScannerProfessionDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")

---============================================================================
-- Not discovered entities
--- In order to avoid long process time, it caches these list on load
---============================================================================

local notDiscoveredNpcIDs = {}

function RSNpcPOI.InitializeNotDiscoveredNpcs()
	for npcID, _ in pairs (RSNpcDB.GetAllInternalNpcInfo()) do
		if (not RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
			notDiscoveredNpcIDs[npcID] = true
		end
	end
end

local function RefreshNotDiscoveredNpcs(npcID)
	if (not RSGeneralDB.GetAlreadyFoundEntity(npcID) and not notDiscoveredNpcIDs[npcID]) then
		notDiscoveredNpcIDs[npcID] = true
	end
end

local function RemoveNotDiscoveredNpc(npcID)
	if (npcID) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("RemoveNotDiscoveredNpc. NPC [%s] pasa a estar 'descubierto'", npcID))
		notDiscoveredNpcIDs[npcID] = nil
	end
end

---============================================================================
-- Dreamsurge NPCs POIs
---- NPCs that are part of a dreamsurge event (Dragonflight)
---============================================================================

local function findClosestSpot(npcID, mapID, poiX, poiY)
	local mapNpcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, mapID)
  	if (not mapNpcInfo or not mapNpcInfo.overlay) then
    	return poiX, poiY
  	else
    	local xyDistances = {}
    	for _, coordinatePair in ipairs (mapNpcInfo.overlay) do
      		local coordx, coordy =  strsplit("-", coordinatePair)
          		local distance = RSUtils.DistanceBetweenCoords(coordx, poiX, coordy, poiY)
      			if (distance > 0.01) then
            		xyDistances[coordinatePair] = distance
      			end
        	end
  
    		if (RSUtils.GetTableLength(xyDistances) == 0) then
    			return poiX, poiY
        	end
  
        	local distances = {}
        	for xy, distance in pairs (xyDistances) do
          		table.insert(distances, distance)
        	end
        
        	local min = math.min(unpack(distances))
        	for xy, distance in pairs (xyDistances) do
          		if (distance == min) then
            		local xo, yo = strsplit("-", xy)
        		return xo, yo
      		end
    	end
	end
end

local function GetMinieventXY(npcID, mapID, atlasName)
	local areaPOIs = GetAreaPOIsForPlayerByMapIDCached(mapID);
  	for _, areaPoiID in ipairs(areaPOIs) do
    	local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, areaPoiID);
    	if (poiInfo) then
	    	local isPrimaryMapForPOI = poiInfo.isPrimaryMapForPOI
    		local x, y = poiInfo.position:GetXY()
	    	
	  		if (isPrimaryMapForPOI and poiInfo.atlasName == atlasName) then
		      	return findClosestSpot(npcID, mapID, x, y)
	    	end
	    end
	end
end

---============================================================================
-- Storm invasion NPCs POIs
---- NPCs that are part of a storm invasion event (Dragonflight)
---============================================================================

local function GetStormInvasionAtlasName(minieventID)
	if (not minieventID) then
		return nil
	end
	
	if (minieventID == RSConstants.DRAGONFLIGHT_STORM_INVASTION_FIRE_MINIEVENT) then
    	return RSConstants.FIRE_STORM_ATLAS 
  	elseif (minieventID == RSConstants.DRAGONFLIGHT_STORM_INVASTION_WATER_MINIEVENT) then
    	return RSConstants.WATER_STORM_ATLAS 
  	elseif (minieventID == RSConstants.DRAGONFLIGHT_STORM_INVASTION_EARTH_MINIEVENT) then
    	return RSConstants.EARTH_STORM_ATLAS 
  	elseif (minieventID == RSConstants.DRAGONFLIGHT_STORM_INVASTION_AIR_MINIEVENT) then
    	return RSConstants.AIR_STORM_ATLAS
  	end
  
  	return nil
end

local function GetStormInvasionXY(npcID, mapID, minieventID)
	local npcStormAtlasName = GetStormInvasionAtlasName(minieventID) 
  	if (not npcStormAtlasName) then
    	return nil
  	end
   
  	local areaPOIs = GetAreaPOIsForPlayerByMapIDCached(mapID);
  	for _, areaPoiID in ipairs(areaPOIs) do
    	local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, areaPoiID);
    	if (poiInfo) then
	    	local isPrimaryMapForPOI = poiInfo.isPrimaryMapForPOI
    		local x, y = poiInfo.position:GetXY()
	    	
	    	-- Fix primatyMapForPOI for event in Cobalt Galery and The primalist future
	    	if (not isPrimaryMapForPOI) then
	    		if (mapID == RSConstants.THE_AZURE_SPAN and RSUtils.Round(x, 2) == "0.47" and RSUtils.Round(y, 2) == "0.22") then
	    			isPrimaryMapForPOI = true
	    		elseif (mapID == RSConstants.THE_PRIMALIST_FUTURE) then
	    			isPrimaryMapForPOI = true
	    		end
	    	-- Fix primatyMapForPOI for event in Valdrakken/The primalist future
	    	elseif (mapID == RSConstants.VALDRAKKEN and RSUtils.Round(x, 2) == "0.60" and RSUtils.Round(y, 2) == "0.82") then
    			isPrimaryMapForPOI = false
			end
	    	
	  		if (isPrimaryMapForPOI and poiInfo.atlasName == npcStormAtlasName) then
		      	return findClosestSpot(npcID, mapID, x, y)
	    	end
	    end
	end
end

---============================================================================
-- NPC Map POIs
---- Manage adding NPC icons to the world map and minimap
---============================================================================

function RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
	local POI = {}
	POI.entityID = npcID
	POI.isNpc = true
	POI.grouping = true
	POI.name = RSNpcDB.GetNpcName(npcID)
	POI.mapID = mapID	
	POI.foundTime = alreadyFoundInfo and alreadyFoundInfo.foundTime
	POI.isDead = RSNpcDB.IsNpcKilled(npcID)
	POI.isDiscovered = POI.isDead or alreadyFoundInfo ~= nil
	POI.isFriendly = RSNpcDB.IsInternalNpcFriendly(npcID)
	POI.achievementIDs = RSAchievementDB.GetNotCompletedAchievementIDsByMap(npcID, mapID)
	
	if (npcInfo) then
		POI.worldmap = npcInfo.worldmap
		POI.factionID = npcInfo.factionID
		POI.minieventID = npcInfo.minieventID
		POI.custom = npcInfo.custom
	end
	
	-- Coordinates
	if (GetStormInvasionAtlasName(POI.minieventID)) then
    	POI.x, POI.y = GetStormInvasionXY(npcID, mapID, POI.minieventID)
  	elseif (POI.minieventID == RSConstants.DRAGONFLIGHT_DREAMSURGE_MINIEVENT) then
    	POI.x, POI.y = GetMinieventXY(npcID, mapID, RSConstants.DREAMSURGE_ICON_ATLAS)
  	elseif (POI.minieventID == RSConstants.DRAGONFLIGHT_FYRAKK_MINIEVENT) then
    	POI.x, POI.y = GetMinieventXY(npcID, mapID, RSConstants.FYRAKK_ICON_ATLAS)
  	elseif (alreadyFoundInfo and alreadyFoundInfo.mapID == mapID) then
		POI.x = alreadyFoundInfo.coordX
		POI.y = alreadyFoundInfo.coordY
  	else
	  	POI.x, POI.y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
	end
	
	-- Textures
	if (POI.isDead) then
		POI.Texture = RSConstants.BLUE_NPC_TEXTURE
	elseif (POI.isFriendly) then
		POI.Texture = RSConstants.LIGHT_BLUE_NPC_TEXTURE
	elseif (RSRecentlySeenTracker.IsRecentlySeen(npcID, POI.x, POI.y)) then
		POI.Texture = RSConstants.PINK_NPC_TEXTURE
	elseif (POI.custom) then
		POI.Texture = RSConstants.PURPLE_NPC_TEXTURE
	elseif (not POI.isDiscovered) then
		POI.Texture = RSConstants.RED_NPC_TEXTURE
	else
		POI.Texture = RSConstants.NORMAL_NPC_TEXTURE
	end
	
	-- Mini icons
	if (npcInfo and npcInfo.prof) then
		POI.iconAtlas = RSConstants.PROFFESION_ICON_ATLAS
	elseif (POI.minieventID and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[POI.minieventID] and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[POI.minieventID].atlas) then
		POI.iconAtlas = RSConstants.MINIEVENTS_WORLDMAP_FILTERS[POI.minieventID].atlas
	elseif (RSUtils.GetTableLength(POI.achievementIDs) > 0) then
		POI.iconAtlas = RSConstants.ACHIEVEMENT_ICON_ATLAS
	end
	
	return POI
end

local function IsEventUnlocked(eventQuestIDs)
	for _, questID in ipairs(eventQuestIDs) do
		if (C_TaskQuest.IsActive(questID) or C_QuestLog.IsQuestFlaggedCompleted(questID)) then
			return true
		end
	end
	
	return false
end

local function IsNpcPOIFiltered(npcID, mapID, artID, npcInfo, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMinimap)
	local name = RSNpcDB.GetNpcName(npcID)
	
	-- Skip if part of a disabled event
	if (RSNpcDB.IsDisabledEvent(npcID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Parte de un evento desactivado.", npcID))
		return true
	end
	
	-- Skip if active while aura active
	if (npcInfo and npcInfo.spellID and not C_UnitAuras.GetPlayerAuraBySpellID(RSConstants.SEAFURY_TEMPEST_ID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado porque su evento no esta activo [%s].", npcID, npcInfo.spellID))
		return true
	end
	
	-- Skip if filtering by name in the world map search box
	if (name and RSGeneralDB.GetWorldMapTextFilter() and not RSUtils.Contains(name, RSGeneralDB.GetWorldMapTextFilter())) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado por nombre [%s][%s].", npcID, name, RSGeneralDB.GetWorldMapTextFilter()))
		return true
	end

	-- Skip if the entity is filtered
	if (RSConfigDB.IsNpcFiltered(npcID) or RSConfigDB.IsNpcFilteredOnlyWorldmap(npcID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado en opciones (filtro completo o mapa del mundo).", npcID))
		return true
	end
	
	-- Skip if custom NPC group filtered
	if (npcInfo and npcInfo.group and RSConfigDB.IsCustomNpcGroupFiltered(npcInfo.group)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado grupo.", npcID))
		return true
	end
	
	-- Skip if rare part of a filtered minievent
	local isMinieventWithFilter = false;
	if (npcInfo and npcInfo.minieventID) then
		isMinieventWithFilter = RSConstants.MINIEVENTS_WORLDMAP_FILTERS[npcInfo.minieventID].active
		
		-- Skip if minievent is filtered
		if (RSConfigDB.IsMinieventFiltered(npcInfo.minieventID)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado minievento [%s].", npcID, npcInfo.minieventID))
			return true
		-- Skip if Dreamsurge minievent is not up
		elseif (npcInfo.minieventID == RSConstants.DRAGONFLIGHT_DREAMSURGE_MINIEVENT and not GetMinieventXY(npcID, mapID, RSConstants.DREAMSURGE_ICON_ATLAS)) then
		    RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Investigacion pico onirico que no esta activa.", npcID))
		    return true
		-- Skip if Invasion storm minievent is not up
		elseif (GetStormInvasionAtlasName(npcInfo.minieventID) ~= nil and not GetStormInvasionXY(npcID, mapID, npcInfo.minieventID)) then
		    RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Invasión de tormentas [%s] que no esta activa.", npcID, GetStormInvasionAtlasName(npcInfo.minieventID)))
		    return true
		-- Skip if Fyrakk assault minievent is not up
		elseif (npcInfo.minieventID == RSConstants.DRAGONFLIGHT_FYRAKK_MINIEVENT and not GetMinieventXY(npcID, mapID, RSConstants.FYRAKK_ICON_ATLAS)) then
		    RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Asalto Fyrakk que no esta activo.", npcID))
		    return true
		end
	end
	
	-- Skip if not completed achievement and is filtered
	local isNotCompletedAchievement = RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(npcID, mapID)) > 0;
	if (not RSConfigDB.IsShowingAchievementRareNPCs() and isNotCompletedAchievement) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado NPC con logro.", npcID))
		return true
	end
	
	-- Skip if profession and filtered
	if (npcInfo and not RSConfigDB.IsShowingProfessionRareNPCs() and npcInfo.prof) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado NPC de profesion.", npcID))
		return true
	end
	
	-- Skip if other filtered
	if (not RSConfigDB.IsShowingOtherRareNPCs() and not isMinieventWithFilter and not isNotCompletedAchievement and (not npcInfo or not npcInfo.prof)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado otro NPC.", npcID))
		return true
	end

	-- Skip if not showing friendly NPCs and this one is friendly
	if (not RSConfigDB.IsShowingFriendlyNpcs() and RSNpcDB.IsInternalNpcFriendly(npcID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Es amistoso.", npcID))
		return true
	end

	-- Skip if the entity appears only while a quest event is going on and it isnt active
	if (npcInfo and npcInfo.zoneQuestId) then
		local active = false
		for _, questID in ipairs(npcInfo.zoneQuestId) do
			if (C_TaskQuest.IsActive(questID) or C_QuestLog.IsQuestFlaggedCompleted(questID)) then
				active = true
				break
			end
		end

		if (not active) then
			local eventUnlocked = true
			-- If the player haven't unlocked the event associated to the zoneQuestID
			if (mapID == RSConstants.ULDUM_MAPID and not IsEventUnlocked(RSConstants.ULDUM_INVASSION_QUESTS)) then
				eventUnlocked = false
			elseif (mapID == RSConstants.VALLEY_OF_ETERNAL_BLOSSOMS_MAPID and not IsEventUnlocked(RSConstants.VALLEY_BLOSSOMS_INVASSION_QUESTS)) then
				eventUnlocked = false
			end
			
			if (eventUnlocked) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Evento asociado no esta activo.", npcID))
				return true
			end
		end
	end

	-- Skip if for whatever reason we don't have its name (this shouldnt happend)
	local npcName = RSNpcDB.GetNpcName(npcID)
	if (not npcName) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Le falta el nombre!.", npcID))
		return true
	end

	-- Skip if this NPC has a world quest active right now
	-- We don't want to show our icon on top of the quest one
	if (RSUtils.Contains(questTitles, npcName)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Tiene misión del mundo activa.", npcID))
		return true
	end

	-- A 'not discovered' NPC will be setted as killed when the kill is detected while loading the addon and its questID is completed
	local npcDead = RSNpcDB.IsNpcKilled(npcID)

	-- Skip if dead 
	if (npcDead) then
		-- and not showing dead entities in 'not reseteable' maps
		if (RSConfigDB.IsShowingAlreadyKilledNpcsInReseteableZones() and not RSMapDB.IsReseteableKillMapID(mapID, artID)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Esta muerto (zona no reseteable).", npcID))
			return true
		--  and not showing dead entities
		elseif (not RSConfigDB.IsShowingAlreadyKilledNpcsInReseteableZones() and not RSConfigDB.IsShowingAlreadyKilledNpcs()) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Esta muerto.", npcID))
			return true
		end
	end
	
	-- Skip if wrong profession
	if (npcInfo and npcInfo.prof) then
		if (not RSProfessionDB.HasPlayerProfession(npcInfo.prof)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Profesión incorrecta.", npcID))
			return true
		end
	end

	-- Skip if an ingame vignette is already showing this entity (on Vignette)
	for _, vignetteGUID in ipairs(vignetteGUIDs) do
		local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID);
		if (vignetteInfo and vignetteInfo.objectGUID) then
			local _, _, _, _, _, vignetteNPCID, _ = strsplit("-", vignetteInfo.objectGUID);
			if (onWorldMap and vignetteInfo.onWorldMap and (tonumber(vignetteNPCID) == npcID or RSNpcDB.GetFinalNpcID(vignetteNPCID) == npcID)) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Hay un vignette del juego mostrándolo (Vignette onWorldmap).", npcID))
				return true
			end
			if (onMinimap and vignetteInfo.onMinimap and (tonumber(vignetteNPCID) == npcID or RSNpcDB.GetFinalNpcID(vignetteNPCID) == npcID)) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Hay un vignette del juego mostrándolo (Vignette onMinimap).", npcID))
				return true
			end
			-- If Ancestral Spirit in Forbidden Reach or Loam Scout in Zaralek Cavern, locate real NPC
			if ((tonumber(vignetteNPCID) == RSConstants.FORBIDDEN_REACH_ANCESTRAL_SPIRIT or tonumber(vignetteNPCID) == RSConstants.ZARALEK_CAVERN_LOAM_SCOUT) and npcID == RSNpcDB.GetNpcId(vignetteInfo.name, mapID)) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Hay un vignette del juego mostrándolo (Espiritú ancestral/Loam scout).", npcID))
				return true
			end
		end
	end
	
	-- Skip if an ingame area POI is already showing this entity
	for _, areaPoiID in ipairs(areaPOIs) do
		local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, areaPoiID);
		if (poiInfo) then
			if (RSNpcDB.GetFinalNpcID(areaPoiID) == npcID) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Hay un area POI del juego mostrándolo.", npcID))
				return true
			end
		end
	end
	
	-- Skip if it doesn't drop weekly rep anymore
	if (npcInfo and not RSConfigDB.IsShowingWeeklyRepFilterEnabled()) then
		if (npcInfo.warbandQuestID) then
			for _, questID in ipairs(npcInfo.warbandQuestID) do
				if (C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
					RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: No aporta reputación esta semana.", npcID))
					return true
				end
			end
		-- Also hide one time kill rare NPCs at Khaz Algar
		elseif (RSMapDB.GetContinentOfMap(mapID) == RSConstants.KHAZ_ALGAR and not RSUtils.Contains(RSConstants.IGNORE_NPCS_REPUTATION, npcID) and not RSUtils.Contains(RSConstants.TWW_MAPS_WITHOUT_REP, mapID)) then
			if (npcInfo.questID) then
				for _, questID in ipairs(npcInfo.questID) do
					if (C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
						RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: No aporta reputación nunca mas.", npcID))
						return true
					end
				end
			else
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Nunca ha aportado reputación.", npcID))
				return true
			end
		end
	end

	return false
end

function RSNpcPOI.GetMapNotDiscoveredNpcPOIs(mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMinimap)
	-- Skip if not showing NPC icons
	if (not RSConfigDB.IsShowingNpcs()) then
		return
	end
	
	-- Skip if not showing not discovered NPC icons
	if (not RSConfigDB.IsShowingNotDiscoveredNpcs()) then
		return
	end
	
	-- Refresh custom NPCs, just in case they were added after the list of not discovered was loaded
	for npcID, _ in pairs (RSNpcDB.GetAllCustomNpcInfo()) do
		RefreshNotDiscoveredNpcs(npcID)
	end

	local POIs = {}
	for npcID, _ in pairs(notDiscoveredNpcIDs) do
		local filtered = false
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		
		-- It it was a custom NPC and has being deleted it could be unsynchronized
		if (npcInfo == nil) then
			RemoveNotDiscoveredNpc(npcID)
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: Era un NPC personalizado y ya no existe.", npcID))
			filtered = true
		end

		-- Skip if it was discovered in this session
		if (not filtered and RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
			RemoveNotDiscoveredNpc(npcID)
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: Ya no es 'no descubierto'.", npcID))
			filtered = true
		end

		-- Skip if the entity belong to a different mapID/artID that the one displaying
		if (not filtered and not RSNpcDB.IsInternalNpcInMap(npcID, mapID)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: En distinta zona.", npcID))
			filtered = true
		end
		
		-- Skip if it doesnt have coordinates. This could happend if it is a custom NPC
		if (not filtered and (not npcInfo.x or not npcInfo.y)) then
			local x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
			if (not x or not y) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: No disponía de coordenadas.", npcID))
				filtered = true
			end
		end

		-- Skip if common filters
		if (not filtered and not IsNpcPOIFiltered(npcID, mapID, RSNpcDB.GetInternalNpcArtID(npcID, mapID), npcInfo, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMinimap)) then
			tinsert(POIs, RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo))
		end
	end

	return POIs
end

function RSNpcPOI.GetMapAlreadyFoundNpcPOI(npcID, alreadyFoundInfo, mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMinimap)
	-- Skip if not showing NPC icons
	if (not RSConfigDB.IsShowingNpcs()) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Iconos de NPCs deshabilitado.", npcID))
		return
	end

	local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
	local npcDead = RSNpcDB.IsNpcKilled(npcID)

	-- Skip if the entity has been seen before the max amount of time that the player want to see the icon on the map
	-- This filter doesnt apply to dead entities or worldmap npcs
	if (not npcDead and (npcInfo and not npcInfo.worldmap) and RSConfigDB.IsMaxSeenTimeFilterEnabled() and time() - alreadyFoundInfo.foundTime > RSTimeUtils.MinutesToSeconds(RSConfigDB.GetMaxSeenTimeFilter())) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Visto hace demasiado tiempo.", npcID))
		return
	end

	-- Skip if the entity belongs to a different map that the one displaying
	-- First checks with the already found information
	local correctMap = false
	if (RSGeneralDB.IsAlreadyFoundEntityInZone(npcID, mapID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("GetMapAlreadyFoundNpcPOI. NPC [%s] en zona correcta [alreadyFound].", npcID))
		correctMap = true
	end

	-- Then checks with the internal found information just in case its a multizone
	-- Its possible that the player is opening a map where this NPC can show up, but the last time seen was in a different map
	if (not correctMap) then
		if (not npcInfo or not RSNpcDB.IsInternalNpcInMap(npcID, mapID)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltando NPC [%s]: En distinta zona.", npcID))
			return
		-- Skip if it doesnt have coordinates. This could happend if it is a custom NPC
		elseif (not npcInfo.x or not npcInfo.y) then
			local x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
			if (not x or not y) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: No disponía de coordenadas.", npcID))
				return
			end
		end
	end

	-- Skip if common filters
	if (not IsNpcPOIFiltered(npcID, mapID, alreadyFoundInfo.artID, npcInfo, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMinimap)) then
		return RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
	end
end
