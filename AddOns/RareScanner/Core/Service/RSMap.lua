-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSMap = private.NewLib("RareScannerMap")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSNpcPOI = private.ImportLib("RareScannerNpcPOI")
local RSContainerPOI = private.ImportLib("RareScannerContainerPOI")
local RSEventPOI = private.ImportLib("RareScannerEventPOI")
local RSGroupPOI = private.ImportLib("RareScannerGroupPOI")
local RSDragonGlyphPOI = private.ImportLib("RareScannerDragonGlyphPOI")
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")


---============================================================================
-- Not discovered entities
---- Stores in a temporal list all the not discovered entities to help displaying them on the map
---============================================================================

function RSMap.InitializeNotDiscoveredLists()
	RSEventPOI.InitializeNotDiscoveredEvents()
	RSNpcPOI.InitializeNotDiscoveredNpcs()
	RSContainerPOI.InitializeNotDiscoveredContainers()
end

---============================================================================
-- Groups of POIs
---============================================================================

local function CreateGroups(POIs)
	local checkedPOIs = {}

	for _, POI in ipairs (POIs) do
		local POIchecked = false;
		
		-- Skip POIs that are shown in the worldmap and POIs that shouldnt group up
		if (not POI.worldmap and POI.grouping) then
			for _, checkedPOI in ipairs (checkedPOIs) do
				if (POI.entityID ~= checkedPOI.entityID and not checkedPOI.worldmap) then
					local distance = RSUtils.Distance(POI, checkedPOI)
					if (distance >= 0 and distance <= RSConstants.MINIMUM_DISTANCE_PINS_WORLD_MAP) then
						RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("NPC [%s]: Cerca de [%s], distancia [%s].", POI.entityID, checkedPOI.entityID, distance))
						RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("NPC [%s]: Coordenadas [%s,%s].", POI.entityID, POI.x, POI.y))
						RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("NPC [%s]: Coordenadas [%s,%s].", checkedPOI.entityID, checkedPOI.x, checkedPOI.y))
						if (not checkedPOI.POIs) then
							checkedPOI.POIs = {}
						end
	
						tinsert(checkedPOI.POIs, POI)
						POIchecked = true;
						break;
					end
				end
			end
		end
	
		if (not POIchecked) then
			tinsert(checkedPOIs, POI)
		end
	end

	local resultPOIs = {}

	for _, checkedPOI in ipairs(checkedPOIs) do
		-- If the POI doesnt have a group
		if (not checkedPOI.POIs) then
			tinsert(resultPOIs, checkedPOI)
			-- If it does, create a group including the parent
		else
			local tempTable = checkedPOI.POIs
			--checkedPOIs.POIs = nil
			tinsert(tempTable, checkedPOI)
			tinsert(resultPOIs, RSGroupPOI.GetGroupPOI(tempTable))
		end
	end

	return resultPOIs;
end

---============================================================================
-- Map POIs
---- Manage adding icons to the world map and minimap
---============================================================================

local MapPOIs = {}

local function GetMapDragonGlyphsPOIs(mapID)
	-- Skip if not showing dragon glyphs
	if (not RSConfigDB.IsShowingDragonGlyphs()) then
		return
	end

	-- Add icons
	local dragonGlyphsPOIs = RSDragonGlyphPOI.GetDragonGlyphPOIs(mapID)
	if (RSUtils.GetTableLength(dragonGlyphsPOIs) > 0) then
		for _, POI in ipairs (dragonGlyphsPOIs) do
			tinsert(MapPOIs,POI)
		end
	end
end

local function GetMapNotDiscoveredPOIs(mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
	-- Skip if not showing 'not discovered' icons in old expansions
	if (not RSConfigDB.IsShowingOldNotDiscoveredMapIcons() and not RSMapDB.IsMapInCurrentExpansion(mapID)) then
		return
	end

	-- Add icons
	local notDiscoveredNpcPOIs = RSNpcPOI.GetMapNotDiscoveredNpcPOIs(mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
	if (RSUtils.GetTableLength(notDiscoveredNpcPOIs) > 0) then
		for _, POI in ipairs (notDiscoveredNpcPOIs) do
			tinsert(MapPOIs,POI)
		end
	end
	local notDiscoveredContainerPOIs = RSContainerPOI.GetMapNotDiscoveredContainerPOIs(mapID, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
	if (RSUtils.GetTableLength(notDiscoveredContainerPOIs) > 0) then
		for _, POI in ipairs (notDiscoveredContainerPOIs) do
			tinsert(MapPOIs,POI)
		end
	end
	local notDiscoveredEventPOIs = RSEventPOI.GetMapNotDiscoveredEventPOIs(mapID, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
	if (RSUtils.GetTableLength(notDiscoveredEventPOIs) > 0) then
		for _, POI in ipairs (notDiscoveredEventPOIs) do
			tinsert(MapPOIs,POI)
		end
	end
end

function RSMap.GetMapPOIs(mapID, onWorldMap, onMiniMap)
	-- Clear previous list
	MapPOIs = {}

	-- Skip if zone filtered
	if (RSConfigDB.IsZoneFiltered(mapID) or RSConfigDB.IsZoneFilteredOnlyWorldmap(mapID)) then
		return
	end

	-- Extract world quests in the area.
	local questsOnMap = C_TaskQuest.GetQuestsOnMap(mapID)
	local questTitles = {}
	if (questsOnMap) then
		for _, info in ipairs (questsOnMap) do
			if (info.questID and HaveQuestData(info.questID)) then
				local title, _, _ = C_TaskQuest.GetQuestInfoByQuestID(info.questID)
				table.insert(questTitles, title)
			end
		end
	end

	-- Extract ingame vignettes
	local vignetteGUIDs = C_VignetteInfo.GetVignettes();
	
	-- Extract ingame area POIs
	local areaPOIs = GetAreaPOIsForPlayerByMapIDCached(mapID);

	-- Extract POIs from already found entities
	for entityID, entityInfo in pairs (RSGeneralDB.GetAlreadyFoundEntities()) do
		-- Extract POI from already found NPC
		local POI = nil
		if (RSConstants.IsNpcAtlas(entityInfo.atlasName)) then
			POI = RSNpcPOI.GetMapAlreadyFoundNpcPOI(entityID, entityInfo, mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
		elseif (RSConstants.IsContainerAtlas(entityInfo.atlasName)) then
			POI = RSContainerPOI.GetMapAlreadyFoundContainerPOI(entityID, entityInfo, mapID, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
		elseif (RSConstants.IsEventAtlas(entityInfo.atlasName)) then
			POI = RSEventPOI.GetMapAlreadyFoundEventPOI(entityID, entityInfo, mapID, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
		end

		if (POI) then
			tinsert(MapPOIs,POI)
		end
	end
	
	-- extract POIs from recently seen entities (multi spawn)
	local recentlySeenEntities = RSRecentlySeenTracker.GetAllRecentlySeenSpots()
	if (RSUtils.GetTableLength(recentlySeenEntities) > 0) then
		for entityID, entityInfo in pairs (recentlySeenEntities) do
			if (type(entityInfo) == "table") then
				for xy, info in pairs (entityInfo) do
					if (info.mapID == mapID) then
						local entityInfo = {}
						entityInfo.mapID = mapID
						entityInfo.coordX = info.x
						entityInfo.coordY = info.y
						entityInfo.foundTime = info.time
					
						local POI = nil
						if (RSConstants.IsNpcAtlas(info.atlasName)) then
							RSNpcDB.DeleteNpcKilled(entityID)
							POI = RSNpcPOI.GetMapAlreadyFoundNpcPOI(entityID, entityInfo, mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
						elseif (RSConstants.IsContainerAtlas(info.atlasName)) then
							RSContainerDB.DeleteContainerOpened(entityID)
							POI = RSContainerPOI.GetMapAlreadyFoundContainerPOI(entityID, entityInfo, mapID, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
						elseif (RSConstants.IsEventAtlas(info.atlasName)) then
							RSEventDB.DeleteEventCompleted(entityID)
							POI = RSEventPOI.GetMapAlreadyFoundEventPOI(entityID, entityInfo, mapID, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
						end
		
						if (POI) then						
							-- Ignore if added by already found entitites
							local alreadyAdded = false
							for _, MapPOI in ipairs (MapPOIs) do
								if (POI.entityID == MapPOI.entityID and POI.x == MapPOI.x and POI.y == MapPOI.y) then
									alreadyAdded = true
									break
								end
							end
							
							if (not alreadyAdded) then
								tinsert(MapPOIs,POI)
							end
						end
					end
				end
			end
		end
	end

	-- Extract POIs not discovered
	GetMapNotDiscoveredPOIs(mapID, questTitles, vignetteGUIDs, areaPOIs, onWorldMap, onMiniMap)
	
	-- Extract POIs dragon glyphs
	GetMapDragonGlyphsPOIs(mapID)

	-- Create groups if the pins go in the worldmap
	if (onWorldMap) then
		return CreateGroups(MapPOIs)
	end

	return MapPOIs
end

function RSMap.GetWorldMapPOI(objectGUID, vignetteInfo, mapID)
	if (not objectGUID or not mapID) then
		return nil
	end
	
	local _, _, _, _, _, vignetteObjectID = strsplit("-", objectGUID)
		
	if (vignetteInfo.type == Enum.VignetteType.Treasure or RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
		local containerID = tonumber(vignetteObjectID)
		
		-- If pre-event, sets the container ID
		if (RSConstants.CONTAINERS_WITH_PRE_EVENT[containerID]) then
			containerID = RSContainerDB.GetFinalContainerID(containerID)
		end
		
		local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(containerID)
		
		if (containerInfo or alreadyFoundInfo) then
			return RSContainerPOI.GetContainerPOI(containerID, mapID, containerInfo, alreadyFoundInfo)
		end
	elseif ((vignetteInfo.type == Enum.VignetteType.Torghast and not RSUtils.Contains(RSConstants.EVENTS_WITH_NPC_VIGNETTE, tonumber(vignetteObjectID)))
		or RSConstants.IsNpcAtlas(vignetteInfo.atlasName) 
		or (vignetteInfo.atlasName == RSConstants.NPC_VIGNETTE_BOSS and RSUtils.Contains(RSConstants.WORLDBOSSES, tonumber(vignetteObjectID))) 
		or (RSConstants.IsEventAtlas(vignetteInfo.atlasName) and RSConstants.NPCS_WITH_PRE_EVENT[tonumber(vignetteObjectID)])) then
		local npcID = tonumber(vignetteObjectID)

		-- If Ancestral Spirit in Forbidden Reach or Loam Scoat in Zaralek Cavern, locate real NPC
		if ((npcID == RSConstants.FORBIDDEN_REACH_ANCESTRAL_SPIRIT or npcID == RSConstants.ZARALEK_CAVERN_LOAM_SCOUT) and RSNpcDB.GetNpcId(vignetteInfo.name, mapID)) then
			npcID = RSNpcDB.GetNpcId(vignetteInfo.name, mapID)
		-- If pre-event, sets the NPC ID
		elseif (RSConstants.NPCS_WITH_PRE_EVENT[npcID]) then
			npcID = RSNpcDB.GetFinalNpcID(npcID)
		end
		
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(npcID)
		
		if (npcInfo or alreadyFoundInfo) then
			return RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
		end
	elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName) or (vignetteInfo.atlasName == RSConstants.EVENT_SCRAP_VIGNETTE and mapID == RSConstants.UNDERMINE)) then
		local eventID = tonumber(vignetteObjectID)
		
		local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(eventID)
	
		if (eventInfo or alreadyFoundInfo) then
			return RSEventPOI.GetEventPOI(eventID, mapID, eventInfo, alreadyFoundInfo)
		end
	end
	
	return nil
end

---============================================================================
-- Map options button
---============================================================================

local worldMapButton
function RSMap.LoadWorldMapButton()
	if (RSConfigDB.IsShowingWorldmapButton()) then 
		local rwm = LibStub('Krowi_WorldMapButtons-1.4')
		worldMapButton = rwm:Add("RSWorldMapButtonTemplate", 'DROPDOWNBUTTON')
	end
end

function RSMap.ToggleWorldmapButton() 
	if (worldMapButton) then
		if (RSConfigDB.IsShowingWorldmapButton()) then 
			worldMapButton:Show() 
		else 
			worldMapButton:Hide() 
		end 
	else
		RSMap.LoadWorldMapButton()
	end
end
