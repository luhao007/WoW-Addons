-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSMapDB = private.NewLib("RareScannerMapDB")

-- RareScanner internal libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSConstants = private.ImportLib("RareScannerConstants")


---============================================================================
-- Auxiliar functions
---============================================================================

local function BelongsToZone(entityID, mapID, zoneIds, infoAlreadyFound, alreadyChecked)
	if (not entityID or not mapID or not zoneIds) then
		return false
	end

	-- Tries to find in main zone
	local zone = zoneIds[mapID]

	-- Tries to find in sub zone
	if (not zone) then
		for mainZoneID, subZonesIDs in pairs (private.SUBZONES_IDS) do
			if (RSUtils.Contains(subZonesIDs, mapID)) then
				zone = zoneIds[mainZoneID]
				break
			end
		end
	end

	if (zone) then
		if (RSUtils.Contains(zone, RSConstants.ALL_ZONES) or RSUtils.Contains(zone, C_Map.GetMapArtID(mapID))) then
			return true
		end
	elseif (not alreadyChecked) then
		if (infoAlreadyFound) then
			return BelongsToZone(entityID, infoAlreadyFound.mapID, zoneIds, infoAlreadyFound, true)
		end
	end

	return false
end

---============================================================================
-- Continents database
---============================================================================

function RSMapDB.GetContinents()
	return private.CONTINENT_ZONE_IDS
end

function RSMapDB.GetContinentInfo(mapID)
	if (mapID and RSMapDB.GetContinents()[mapID]) then
		return RSMapDB.GetContinents()[mapID]
	end
	
	return nil
end

function RSMapDB.GetActiveMapIDsWithNamesByMapID(mapID)
	local mapIDs = {}
	
	-- Ignore world maps
	if (mapID == RSConstants.AZEROTH or mapID == RSConstants.COSMIC) then
		return
	end
		
	-- If a continent
	local continentInfo = RSMapDB.GetContinents()[mapID]
	if (continentInfo) then
		mapIDs = continentInfo.zones
	-- If not a continent
	else
		tinsert(mapIDs, mapID)
	end
	
	-- Add subzones
	for _, mapID_ in ipairs(mapIDs) do
		local subMapIDs = private.SUBZONES_IDS[mapID_];
		if (subMapIDs) then
			for _, subMapID in ipairs (subMapIDs) do 
				if (not RSUtils.Contains(mapIDs, subMapID)) then
					tinsert(mapIDs, subMapID)
				end
			end
		end
	end
	
	local mapIDsWithNames = {}
	for _, mapID_ in ipairs (mapIDs) do
		local mapName = RSMapDB.GetMapName(mapID_)
		if (mapName) then
			mapIDsWithNames[mapID_] = string.format("%s (%s)", mapName, mapID_)
		else
			mapIDsWithNames[mapID_] = tostring(mapID_)
		end
	end
	
	return mapIDsWithNames
end

function RSMapDB.GetContinentOfMap(mapID)
	if (mapID) then
		for continentID, info in pairs(RSMapDB.GetContinents()) do
			if (RSUtils.Contains(info.zones, mapID)) then
				if (info.zonefilter and info.npcfilter) then
					return continentID
				else
					break
				end
			end
		end
	end
	
	return nil
end

function RSMapDB.IsMapInCurrentExpansion(mapID)
	if (not mapID) then
		return false
	end

	-- check if the map is in the continent
	for _, continentInfo in pairs (RSMapDB.GetContinents()) do
		local mapInContinent = RSUtils.Contains(continentInfo.zones, mapID)

		-- check if the mapID is in a subzone into the continent
		if (not mapInContinent) then
			for _, parentMapID in ipairs (continentInfo.zones) do
				if (RSMapDB.IsMapInParentMap(parentMapID, mapID)) then
					mapInContinent = true
					break
				end
			end
		end

		if (mapInContinent) then
			if (not continentInfo.current) then
				return false
			elseif (RSUtils.Contains(continentInfo.current, RSConstants.ALL_ZONES) or RSUtils.Contains(continentInfo.current, mapID)) then
				return true
			end
		end
	end

	return false;
end

---============================================================================
-- Subzones database
---============================================================================

function RSMapDB.IsMapInParentMap(parentMapID, subzoneMapID)
	if (parentMapID and subzoneMapID) then
		local subzones = private.SUBZONES_IDS[parentMapID]
		if (subzones and RSUtils.Contains(subzones, subzoneMapID)) then
			return true;
		end
	end

	return false
end

---============================================================================
-- Permanent state areas database
---============================================================================

function RSMapDB.GetPermanentKillZoneIDs()
	return private.PERMANENT_KILLS_ZONE_IDS
end

function RSMapDB.GetPermanentKillZoneArtID(mapID)
	if (mapID) then
		return private.PERMANENT_KILLS_ZONE_IDS[mapID]
	end

	return nil
end

function RSMapDB.IsEntityInPermanentZone(entityID, mapID, infoAlreadyFound, alreadyChecked)
	return BelongsToZone(entityID, mapID, RSMapDB.GetPermanentKillZoneIDs(), infoAlreadyFound, alreadyChecked)
end

---============================================================================
-- Reseteable state areas database
---============================================================================

function RSMapDB.GetReseteableKillZoneIDs()
	return private.RESETABLE_KILLS_ZONE_IDS
end

function RSMapDB.GetReseteableKillZoneArtID(mapID)
	if (mapID) then
		return private.RESETABLE_KILLS_ZONE_IDS[mapID]
	end

	return nil
end

function RSMapDB.IsEntityInReseteableZone(entityID, mapID, infoAlreadyFound, alreadyChecked)
	return BelongsToZone(entityID, mapID, RSMapDB.GetReseteableKillZoneIDs(), infoAlreadyFound, alreadyChecked)
end

function RSMapDB.IsReseteableKillMapID(mapID, artID)
	if (mapID) then
		local reseteableArtIDs = RSMapDB.GetReseteableKillZoneArtID(mapID)
		if (reseteableArtIDs and (RSUtils.Contains(reseteableArtIDs, RSConstants.ALL_ZONES) or RSUtils.Contains(reseteableArtIDs, artID))) then
			return true;
		end
	end

	return false
end

---============================================================================
-- Zones without vignette
---============================================================================
--
function RSMapDB.IsZoneWithoutVignette(mapID)
	if (mapID and private.ZONES_WITHOUT_VIGNETTE[mapID]) then
		return RSUtils.Contains(private.ZONES_WITHOUT_VIGNETTE[mapID], C_Map.GetMapArtID(mapID))
	end

	return false
end

---============================================================================
-- Map names
---============================================================================

function RSMapDB.GetMapName(mapID)
	local mapInfo = C_Map.GetMapInfo(mapID)
	if (mapInfo) then
		-- For those zones with the same name, add a comment
		if (AL["ZONE_"..mapID] ~= "ZONE_"..mapID) then
			return string.format(AL["ZONE_"..mapID], mapInfo.name)
		else
			return mapInfo.name
		end
	end
	
	return AL["ZONES_CONTINENT_LIST"][mapID]
end


