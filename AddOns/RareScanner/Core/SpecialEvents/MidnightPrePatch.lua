-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")

-- RareScanner libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner services libraries
local RSTooltip = private.ImportLib("RareScannerTooltip")
local RSEntityStateHandler = private.ImportLib("RareScannerEntityStateHandler")
local RSButtonHandler = private.ImportLib("RareScannerButtonHandler")
local RSCommandLine = private.ImportLib("RareScannerCommandLine")

local RARESCANNERS_CMD = "rs"

-- Next spawn timer
local NEXT_RESPAWN = 602 --10 minutes
local COOLDOWN = 11 * 60 --11 minutes

-- Twilight Highlands rares order (pre-patch 12.0.0)
local MIDNIGHT_RARES_SPAWNING_ORDER = {246572,246844,246460,246471,246478,246559,246549,237853,237997,246272,246343,246462,246577,246840,246565,246578,246566,246558};

local function GetNextExactSpawnTime()
    local now = time()
    return now + NEXT_RESPAWN
end

local function MidnightPrePatch_CalculateSpawningTimers(npcID)
	local nextSpawningNPC = nil
	if (npcID and RSUtils.Contains(MIDNIGHT_RARES_SPAWNING_ORDER, npcID)) then
		private.dbglobal.midnightSpawningTimers = {}
		local nextSpawning = GetNextExactSpawnTime()
		local initFound = false
		for i, orderNpcID in ipairs (MIDNIGHT_RARES_SPAWNING_ORDER) do
			if (not initFound and orderNpcID == npcID) then
				initFound = true
			elseif (initFound) then
				if (not nextSpawningNPC) then
					nextSpawningNPC = orderNpcID
				end
				private.dbglobal.midnightSpawningTimers[orderNpcID] = nextSpawning
				nextSpawning = nextSpawning + NEXT_RESPAWN
			end
		end

		for i, orderNpcID in ipairs (MIDNIGHT_RARES_SPAWNING_ORDER) do
			if (orderNpcID ~= npcID) then
				if (not nextSpawningNPC) then
					nextSpawningNPC = orderNpcID
				end
				private.dbglobal.midnightSpawningTimers[orderNpcID] = nextSpawning
				nextSpawning = nextSpawning + NEXT_RESPAWN
			else
				break
			end
		end

		private.dbglobal.midnightSpawningTimers[npcID] = nextSpawning
	end

	return nextSpawningNPC
end

local function MidnightPrePatch_PrintNextSpawn(npcID)
	local nextSpawningNPC = MidnightPrePatch_CalculateSpawningTimers(npcID)
	if (nextSpawningNPC) then
		local name = RSNpcDB.GetNpcName(nextSpawningNPC)
		if (name) then
			RSLogger:PrintMessage(string.format(AL["PRE_PATCH_NEXTSPAWN"], name))
			RSGeneralDB.SetRecentlySeen(nextSpawningNPC)
		end
	end
end

local function MidnightPrePatch_AddNextSpawningTimerCell(tooltip, npcID)
	if (private.dbglobal.midnightSpawningTimers and private.dbglobal.midnightSpawningTimers[npcID]) then
		local timeLeft = private.dbglobal.midnightSpawningTimers[npcID] - time()
		if (timeLeft > 0) then
			local line = tooltip:AddLine()
			tooltip:SetCell(line, 1, string.format(AL["PRE_PATCH_SPAWNINGTIMER"], RSUtils.TextColor(RSTimeUtils.TimeStampToClock(timeLeft), "FF8000")), nil, "LEFT", 10)
		end
	end
end

local prevNpc = nil
local lastTimeFound = nil
function RareScanner:MidnightPrePatch_Initialize()
	-- Add hooks wherever we need them
	if (not RSConstants.EVENTS[RSConstants.MIDNIGHT_PRE_PATCH_EVENT]) then
		return
	end

	local original_AddAlert = RSButtonHandler.AddAlert
	function RSButtonHandler.AddAlert(button, vignetteInfo, isNavigating)
		original_AddAlert(button, vignetteInfo, isNavigating)		
		local _, _, _, _, _, id, _ = strsplit("-", vignetteInfo.objectGUID);
		local entityID = tonumber(id)
		
		-- Skip if not a pre-patch rare NPC
		if (not entityID or not RSUtils.Contains(MIDNIGHT_RARES_SPAWNING_ORDER, entityID)) then
			return
		end
		
		-- Skip if not found in this session but the timer in the database didn't expire yet
		if (not prevNpc and private.dbglobal.midnightSpawningTimers and private.dbglobal.midnightSpawningTimers[entityID] and private.dbglobal.midnightSpawningTimers[entityID] - time() > 0) then
			prevNpc = entityID
			return
		end
		
		-- Skip if not found in the current session or the cooldown didn't expire yet
		if ((prevNpc and prevNpc == entityID) or (lastTimeFound and time() - lastTimeFound >= COOLDOWN)) then
			return
		end
		
		if (not prevNpc) then
			RSLogger:PrintMessage(AL["PRE_PATCH_FIRST_FOUND"])
		end
		
		prevNpc = entityID
		lastTimeFound = time()
		MidnightPrePatch_CalculateSpawningTimers(entityID);
	end

	local original_SetDeadNpcByZone = RSEntityStateHandler.SetDeadNpcByZone
	function RSEntityStateHandler.SetDeadNpcByZone(npcID, mapID, loadingAddon)
		original_SetDeadNpcByZone(npcID, mapID, loadingAddon)
		MidnightPrePatch_PrintNextSpawn(npcID)
	end

	local original_AddSpecialEventsLines = RSTooltip.AddSpecialEventsLines
	function RSTooltip.AddSpecialEventsLines(pin, tooltip)
		original_AddSpecialEventsLines(self, pin, tooltip);
		MidnightPrePatch_AddNextSpawningTimerCell(tooltip, pin.POI.entityID)
	end

	local original_PrintHelp = RSCommandLine.PrintHelp
	function RSCommandLine.PrintHelp()
		original_PrintHelp()
		print("|cFFFBFF00   /"..RARESCANNERS_CMD.." "..RSConstants.CMD_MIDNIGHT_PRE_PATCH.." |cFF00FFFB"..AL["CMD_HELP_MIDNIGHT_PRE_PATCH"])
	end
	
	local original_SlashCommand = RSCommandLine.SlashCommand
	function RSCommandLine.SlashCommand(command, ...)
		if (command == RSConstants.CMD_MIDNIGHT_PRE_PATCH) then
			if (not private.dbglobal.midnightSpawningTimers) then
				RSLogger:PrintMessage(AL["PRE_PATCH_MIDNIGHT_NO_TIMERS"])
				return
			end
			
			local spawnTimers = {}
			for _, npcID in ipairs(MIDNIGHT_RARES_SPAWNING_ORDER) do
				local spawnTime = private.dbglobal.midnightSpawningTimers[npcID]
			    if (spawnTime and spawnTime - time() > 0) then
			        table.insert(spawnTimers, {
			            npcID = npcID,
			            time = spawnTime
			        })
			    end
			end
			
			if (RSUtils.GetTableLength(spawnTimers) > 0) then
				table.sort(spawnTimers, function(a, b)
				    return a.time < b.time
				end)
				
				for _, spawnTimer in ipairs(spawnTimers) do
					RSLogger:PrintMessage(string.format("[%s]: %s", RSTimeUtils.TimeStampToClock(spawnTimer.time, false, true), RSNpcDB.GetNpcName(spawnTimer.npcID)))
				end
			else
				RSLogger:PrintMessage(AL["PRE_PATCH_MIDNIGHT_NO_TIMERS"])
			end
		else
			original_SlashCommand(command, ...)
		end
	end
end
