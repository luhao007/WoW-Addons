-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSTargetUnitTracker = private.NewLib("RareScannerTargetUnitTracker")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")

-- Timers
local CHECK_TARGETS_TIMER

---============================================================================
-- Get NPC IDs
---============================================================================

local previousMapID
local cachedNpcIDs
local recentlySeen = {}

local function GetMapNpcs()
	-- Disable alerts for rare NPCs
	if (not RSConfigDB.IsScanningForNpcs()) then
		RSLogger:PrintDebugMessage("Desactivado TargetUnit por haber deshabilitado alertas de NPCs")
		return nil
	end
			
	-- Gets MAPID from players position
	local mapID = C_Map.GetBestMapForUnit("player")
	if (not mapID or mapID == 0) then
		return nil
	end
	
	-- Disable alerts for filtered zones
	if (RSConfigDB.IsZoneFiltered(mapID) or RSConfigDB.IsZoneFilteredOnlyAlerts(mapID)) then
		RSLogger:PrintDebugMessage(string.format("Desactivado TargetUnit en esta zona [%s]", mapID))
		return nil
	end

	-- If same zone return already cached
	if (cachedNpcIDs and previousMapID and previousMapID == mapID) then
		return cachedNpcIDs, mapID, false
	end
	
	-- Otherwise refresh cache
	cachedNpcIDs = {}
	previousMapID = mapID
	
	-- Gets NPCs in the map
	RSLogger:PrintDebugMessage(string.format("TargetUnit refrescando lista para mapa [%s]", mapID))
	if (RSMapDB.IsZoneWithoutVignette(mapID)) then
		cachedNpcIDs = RSNpcDB.GetNpcIDsByMapID(mapID, false, true)
	else
		cachedNpcIDs = RSNpcDB.GetNpcIDsByMapID(mapID, true, true)
	end
	
	return cachedNpcIDs, mapID, true
end

---============================================================================
-- Event: ADDON_ACTION_FORBIDDEN
-- Fired when TargetUnit actually tries to target a NPC
---============================================================================

local npcFound = false
local function OnAddonActionForbidden(addonName, functionName)
	if (addonName == 'RareScanner') then
		npcFound = true
	end
end

---============================================================================
-- Routine to track NPCs
---============================================================================

local unitTargetFrame = CreateFrame("FRAME");

local function CloseErrorPopUp()
	if (StaticPopup_HasDisplayedFrames()) then
        for idx = STATICPOPUP_NUMDIALOGS,1,-1 do
            local dialog = _G["StaticPopup"..idx]
            local OnCancel = dialog.OnCancel;
			local noCancelOnEscape = dialog.noCancelOnEscape;
			if ( OnCancel and not noCancelOnEscape) then
				OnCancel(dialog);
			end
			StaticPopupSpecial_Hide(dialog)
        end
    end
end

local checking = false
local function TargetUnits(rareScannerButton, mapID, npcIDs)
	-- If already running ignore it
	if (checking) then
		RSLogger:PrintDebugMessage("En bucle actual,mente")
		return
	end

	-- If tracker disabled
	if (not RSConfigDB.IsScanningTargetUnit()) then
		return
	end
	
	-- Gets NPCs in the current map
	local npcIDs, mapID, newMap = GetMapNpcs()
	if (not npcIDs) then
		RSLogger:PrintDebugMessage("Desactivado TargetUnit por no haberse obtenido NPCs para este mapa")
		return
	end
	
	checking = true
	for _, npcID in ipairs (npcIDs) do
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		local filtered = false
	
		-- If NPC is filtered
		if (not filtered and RSConfigDB.IsNpcFiltered(npcID)) then
			filtered = true
			--RSLogger:PrintDebugMessage(string.format("Desactivado TargetUnit para este NPC [%s] por estar filtrando (completo)", npcID))
		end
		
		-- If NPC zone is filtered
		if (not filtered and RSConfigDB.IsEntityZoneFilteredOnlyAlerts(npcID, RSConstants.NPC_VIGNETTE, mapID)) then
			filtered = true
			--RSLogger:PrintDebugMessage(string.format("Desactivado TargetUnit para este NPC [%s] por estar filtrando su zona [%s]", npcID, mapID))
		end
		
		-- If NPC is recently seen
		if (not filtered and recentlySeen[npcID]) then
			filtered = true
			--RSLogger:PrintDebugMessage(string.format("Desactivado TargetUnit para este NPC [%s] por haberse encontrado recientemente", npcID))
		end
		
		-- If NPC has quest completed
		if (npcInfo and npcInfo.questID) then
			for _, questID in ipairs(npcInfo.questID) do
				if (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
					filtered = true
					--RSLogger:PrintDebugMessage(string.format("Desactivado TargetUnit para este NPC [%s] por tener quest completa)", npcID))
					break
				end
			end
		end
		
		-- If NPC has weekly quest completed
		if (npcInfo and npcInfo.warbandQuestID and RSConfigDB.IsWeeklyRepNpcFilterEnabled()) then
			for _, questID in ipairs(npcInfo.warbandQuestID) do
				if (C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
					filtered = true
					--RSLogger:PrintDebugMessage(string.format("Desactivado TargetUnit para este NPC [%s] por tener quest semanal completa)", npcID))
					break
				end
			end
		end
		
		if (not filtered) then
			local npcName = RSNpcDB.GetNpcName(npcID)
			if (npcName) then
				TargetUnit(npcName)
				if (npcFound) then
					-- Hide error message
					-- WATCH OUT! This might produce taint
					CloseErrorPopUp()
					
					local x, y = RSNpcDB.GetBestInternalNpcCoordinates(npcID, mapID)
					rareScannerButton:SimulateRareFound(npcID, nil, RSNpcDB.GetNpcName(npcID), x, y, RSConstants.NPC_VIGNETTE, RSConstants.TRACKING_SYSTEM.UNIT_TARGET)
					recentlySeen[npcID] = time() + RSConstants.RECENTLY_SEEN_RESET_TIMER
					npcFound = false
				end
			end
		end
	end
	checking = false
end

---============================================================================
-- Initialize ticker
---============================================================================

function RSTargetUnitTracker.Init(rareScannerButton)	
	unitTargetFrame:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	unitTargetFrame:SetScript("OnEvent", function(self, event, ...)
		if (event == "ADDON_ACTION_FORBIDDEN") then
			OnAddonActionForbidden(...)
		end
	end)
	
	-- Mutes the dialog sound
	if (RSConfigDB.IsScanningTargetUnit() and RSConfigDB.IsMutingTargetUnitSound()) then
		MuteSoundFile(RSConstants.ERROR_SOUND_CLOSE_ID)
		MuteSoundFile(RSConstants.ERROR_SOUND_OPEN_ID)
	end
	
	C_Timer.NewTicker(RSConstants.CHECK_TARGETS_TIMER, function()
		TargetUnits(rareScannerButton)
	end)
	
	C_Timer.NewTicker(RSConstants.CHECK_RESET_RECENTLY_SEEN_TIMER, function()
		for npcID, timer in pairs(recentlySeen) do
			if (time() > timer) then
				recentlySeen[npcID] = nil
			end
		end
	end)
end

---============================================================================
-- Refresh
---============================================================================

function RSTargetUnitTracker.Refresh()
	previousMapID = nil
end