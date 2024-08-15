-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner service libraries
local RSMap = private.ImportLib("RareScannerMap")
local RSNpcPOI = private.ImportLib("RareScannerNpcPOI")
local RSLootTooltip = private.ImportLib("RareScannerLootTooltip")

-- Thirdparty
local LibDialog = LibStub("LibDialog-1.0RS")

-----------------------------------------------------
-- Filters panel
-----------------------------------------------------

RSExplorerFilters = { };

local filters = { }

local currentContinentDropDownValues = { }

local function MapByName_Sort(mapIDs)
	local comparison = function(mapID1, mapID2)
		local mapName1 = RSMapDB.GetMapName(mapID1) or ""
		local mapName2 = RSMapDB.GetMapName(mapID2) or ""

		-- Otherwise order by name
		local strCmpResult = strcmputf8i(mapName1, mapName2);
		if (strCmpResult ~= 0) then
			return strCmpResult < 0;
		end
	end
				
	table.sort(mapIDs, comparison)
end

local function AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
	if (RSNpcDB.IsInternalNpcMultiZone(npcID)) then
		for mapID, _ in pairs (npcInfo.zoneID) do
			local continentID = RSMapDB.GetContinentOfMap(mapID)
			if (continentID) then
				if (not continentDropDownValuesNotSorted[continentID]) then
					continentDropDownValuesNotSorted[continentID] = {}
				end
				if (not RSUtils.Contains(continentDropDownValuesNotSorted[continentID], mapID)) then
					table.insert(continentDropDownValuesNotSorted[continentID], mapID)
				end
			end
		end
	else
		local continentID = RSMapDB.GetContinentOfMap(npcInfo.zoneID)
		if (continentID) then
			if (not continentDropDownValuesNotSorted[continentID]) then
				continentDropDownValuesNotSorted[continentID] = {}
			end
			if (not RSUtils.Contains(continentDropDownValuesNotSorted[continentID], npcInfo.zoneID)) then
				table.insert(continentDropDownValuesNotSorted[continentID], npcInfo.zoneID)
			end
		end
	end
end

local function PopulateContinentDropDown(mainFrame, continentDropDown)
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
	
	currentContinentDropDownValues = { }
	local continentDropDownValuesNotSorted = { }
	if (RSUtils.GetTableLength(filters) > 0) then
		for npcID, npcInfo in pairs (RSNpcDB.GetAllInternalNpcInfo()) do
			local filtered = false
			
			-- Ignore if part of a disabled event
			if (RSNpcDB.IsDisabledEvent(npcID)) then
				filtered = true
			end
			
			-- Ignore if dead
			if (not filters[RSConstants.EXPLORER_FILTER_DEAD] and RSNpcDB.IsNpcKilled(npcID)) then
				filtered = true
			end
			
			-- Ignore if filtered
			if (not filtered and not filters[RSConstants.EXPLORER_FILTER_FILTERED] and RSConfigDB.GetNpcFiltered(npcID) ~= nil) then
				filtered = true
			end
			
			-- Add if matches collections
			if (not filtered) then
				if (filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
					AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
				elseif (filters[RSConstants.EXPLORER_FILTER_DROP_PETS] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.PET]) > 0) then
					AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
				elseif (filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.TOY]) > 0) then
					AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
				elseif (filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) > 0) then
					if (filters[RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES]) then
						for _, itemID in pairs(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) do
							if (RSCollectionsDB.IsNotCollectedClassAppearance(itemID)) then
								AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
								break
							end
						end
					else
						AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
					end
				elseif (filters[RSConstants.EXPLORER_FILTER_DROP_DRAKEWATCHER] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.DRAKEWATCHER]) > 0) then
					AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
				elseif (filters[RSConstants.EXPLORER_FILTER_PART_ACHIEVEMENT] and RSAchievementDB.GetNotCompletedAchievementLink(npcID)) then
					AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
				elseif (filters[RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES] and (not collectionsLoot or not collectionsLoot[npcID])) then
					AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
				else
					for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do	
						if (filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)]) > 0) then
							AddContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted)
						end
					end
				end
			end
		end
    end
    
    -- Sort continents by name
    local continentsSorted = { }
   	for continentID, _ in pairs(continentDropDownValuesNotSorted) do
   		table.insert(continentsSorted, continentID)
   	end
	MapByName_Sort(continentsSorted)

	-- Sort maps by name
	for continentID, mapIDs in pairs (continentDropDownValuesNotSorted) do
		local mapIDs = continentDropDownValuesNotSorted[continentID]
		MapByName_Sort(mapIDs)
		currentContinentDropDownValues[continentID] = mapIDs
	end
	
	-- If player is locking current map check if available and selects it
	if (RSConfigDB.IsLockingCurrentMap()) then
		-- Gets players map ID
		local currentPlayerMapID = C_Map.GetBestMapForUnit("player");
		if (currentPlayerMapID) then
			-- Gets players continent map ID
			local currentPlayerContinentID = RSMapDB.GetContinentOfMap(currentPlayerMapID)
			if (currentPlayerContinentID and RSUtils.Contains(continentsSorted, currentPlayerContinentID) and RSUtils.Contains(currentContinentDropDownValues[currentPlayerContinentID], currentPlayerMapID)) then
				RSConfigDB.SetExplorerContinentMapID(currentPlayerContinentID)
				RSConfigDB.SetExplorerMapID(currentPlayerMapID)
			end
		end
	end
	
	-- Tries to select the previous continent/map
	local previousContinentID = RSConfigDB.GetExplorerContinenMapID()
	local previousMapID = RSConfigDB.GetExplorerMapID()

	if (previousContinentID and previousMapID and RSUtils.Contains(continentsSorted, previousContinentID) and RSUtils.Contains(currentContinentDropDownValues[previousContinentID], previousMapID)) then
		continentDropDown:GenerateMenu()
		mainFrame:ShowContentPanels()
		mainFrame.ScanRequired:Hide()
		mainFrame.CustomLoot:Hide()
	-- Otherwise select the first map available
	elseif (RSUtils.GetTableLength(continentsSorted) > 0) then
   		for _, continentID in ipairs(continentsSorted) do
   			RSConfigDB.SetExplorerContinentMapID(continentID)
   			local mapID = currentContinentDropDownValues[continentID][1]
   			RSConfigDB.SetExplorerMapID(mapID)
			continentDropDown:GenerateMenu()
			break
	   	end
	   	
		mainFrame:ShowContentPanels()
		mainFrame.ScanRequired:Hide()
		mainFrame.CustomLoot:Hide()
	else
		continentDropDown:GenerateMenu()
		mainFrame:HideContentPanels()
		mainFrame.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_NO_RESULTS"])
		mainFrame.ScanRequired.StartScanningButton:Hide()
		mainFrame.ScanRequired:Show()
		mainFrame.Filters:Show()
   	end
end

local function FilterDropDownMenu_SetupMenu(dropDown, rootDescription)	
	-- Collections menu
	local collectionsSubmenu = rootDescription:CreateButton(AL["EXPLORER_FILTER_COLLECTIONS"]);
	local mountsFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_MOUNTS"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_MOUNTS)
	mountsFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingMounts(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingMounts(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local petsFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_PETS"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_PETS)
	petsFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingPets(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingPets(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local toysFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_TOYS"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_TOYS)
	toysFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingToys(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingToys(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local appearancesFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_APPEARANCES"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_APPEARANCES)
	appearancesFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingAppearances(false)
			filters[filterKey] = nil
			
			-- Also disables searching for appearances for the current class
			filters[RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES] = false
			RSConfigDB.SetSearchingClassAppearances(false)
		else
			RSConfigDB.SetSearchingAppearances(true)
			filters[filterKey] = true
		end
		
		return MenuResponse.Refresh;
	end)
	
	local appearancesClassFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_CLASS_APPEARANCES"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES)
	appearancesClassFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingClassAppearances(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingClassAppearances(true)
			filters[filterKey] = true
		end
		
		return MenuResponse.Refresh;
	end)
	appearancesClassFilter:SetEnabled(function() return RSConfigDB.IsSearchingAppearances() end)

	local drakewatcherFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_DRAKEWATCHER"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_DRAKEWATCHER)
	drakewatcherFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingDrakewatcher(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingDrakewatcher(true)
			filters[filterKey] = true
		end
		
		return MenuResponse.Refresh;
	end)
	
	local itemGroups = RSCollectionsDB.GetItemGroups()
	if (itemGroups) then
		for groupKey, groupName in pairs (itemGroups) do
			if (RSCollectionsDB.HasGroupItems(groupKey)) then
				local customFilter = collectionsSubmenu:CreateRadio(string.format(AL["EXPLORER_FILTER_CUSTOM"], groupName), 
					function(filterKey) return filters[filterKey] end, 
					function(filterKey)
						-- Overriden by SetResponder
					end,
					string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey))
				customFilter:SetResponder(function(filterKey)
					if (filters[filterKey]) then
						RSConfigDB.SetSearchingCustom(groupKey, false)
						filters[filterKey] = nil
					else
						RSConfigDB.SetSearchingCustom(groupKey, true)
						filters[filterKey] = true
					end
					
					return MenuResponse.Refresh;
				end)
			end
		end
	end

	-- State menu
	local stateSubmenu = rootDescription:CreateButton(AL["EXPLORER_FILTER_STATE"]);
	local deadFilter = stateSubmenu:CreateRadio(AL["EXPLORER_FILTER_DEAD"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DEAD)
	deadFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetShowDead(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetShowDead(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local filteredFilter = stateSubmenu:CreateRadio(AL["EXPLORER_FILTER_FILTERED"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_FILTERED)
	filteredFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetShowFiltered(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetShowFiltered(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local noCollectiblesFilter = stateSubmenu:CreateRadio(AL["EXPLORER_FILTER_WITHOUT_COLLECTIBLES"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES)
	noCollectiblesFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetShowWithoutCollectibles(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetShowWithoutCollectibles(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
end

local function ContinentDropDownMenu_SetupMenu(dropDown, rootDescription)
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
	
	local continentsSorted = { }
   	for continentID, _ in pairs(currentContinentDropDownValues) do
   		table.insert(continentsSorted, continentID)
   	end
	MapByName_Sort(continentsSorted)
	
	-- Continents submenu
	for _, continentID in ipairs(continentsSorted) do
		local continentName = RSMapDB.GetMapName(continentID)
		if (continentName) then
			local continentSubmenu = rootDescription:CreateRadio(continentName, 
				function(continentID) return continentID == RSConfigDB.GetExplorerContinenMapID() end, 
				function(continentID) end,
				continentID)
				
			-- Maps submenu
			for mapContinentID, mapIDs in pairs(currentContinentDropDownValues) do
				if (continentID == mapContinentID) then
					for _, mapID in ipairs (mapIDs) do
						local mapName = RSMapDB.GetMapName(mapID)
						
						continentSubmenu:CreateRadio(mapName, 
							function(mapID) return mapID == RSConfigDB.GetExplorerMapID() end, 
							function(mapID) 
								RSConfigDB.SetExplorerContinentMapID(continentID)
			  					RSConfigDB.SetExplorerMapID(mapID)
			  					
			  					-- Refresh list
			  					dropDown:GetParent().mainFrame.RareNPCList:UpdateRareList()
							end,
							mapID)
			  		end
				end
			end
  		end
	end
end

function RSExplorerFilters:Initialize(mainFrame)
	if (mainFrame.initialized) then
		mainFrame:Refresh()
	else
		self.mainFrame = mainFrame
		
		self.FilterDropDown:SetText(AL["EXPLORER_FILTERS"]);
		self.FilterDropDown:SetupMenu(FilterDropDownMenu_SetupMenu)
		self.FilterDropDown:SetUpdateCallback(function() mainFrame:Refresh() end)
		
		self.ContinentDropDown:SetDefaultText(AL["EXPLORER_NO_RESULTS"])
		PopulateContinentDropDown(self.mainFrame, self.ContinentDropDown)
		self.ContinentDropDown:SetupMenu(ContinentDropDownMenu_SetupMenu)
		
		self.LockCurrentZoneCheckButton.Text:SetText(AL["EXPLORER_LOCK_CURRENT_ZONE"])
		self.LockCurrentZoneCheckButton.tooltip = AL["EXPLORER_LOCK_CURRENT_ZONE_DESC"]
		self.LockCurrentZoneCheckButton:SetChecked(RSConfigDB.IsLockingCurrentMap())
		self.LockCurrentZoneCheckButton.func = function(self, checked)
			RSConfigDB.SetLockingCurrentMap(checked)
		end
		
		self.RestartScanningButton:SetText(AL["EXPLORER_RESCANN"])
		self.RestartScanningButton.tooltip = AL["EXPLORER_RESCANN_DESC"]
	end
end

function RSExplorerFilters:RestartScanning(self, button)
	local mainFrame = self:GetParent().mainFrame
	mainFrame.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_SCAN_MANUAL"])
	mainFrame.ScanRequired.StartScanningButton:SetText(AL["EXPLORER_START_SCAN"])
	mainFrame.ScanRequired.StartScanningButton:Show()
	mainFrame.ScanRequired:Show()
	mainFrame:ShowCustomLootPanels()
	mainFrame:HideContentPanels()
end

-----------------------------------------------------
-- Rare list panel
-----------------------------------------------------

RSExplorerRareList = { };

local RARE_BUTTON_HEIGHT = 56;
local RARE_LIST_BUTTON_OFFSET = -6;
local RARE_LIST_BUTTON_INITIAL_OFFSET = -7;
local RARE_TEXTURE_OFFSET = -24;

function RSExplorerRareList_GetButtonHeight()
	return RARE_BUTTON_HEIGHT;
end

function RSExplorerRareList_GetTopButton(self, offset)
	local buttonHeight = self.listScroll.buttonHeight;
	local raresList = self.raresList;
	local totalHeight = 0;
	for i = 1, #raresList do
		local height = RARE_BUTTON_HEIGHT - RARE_LIST_BUTTON_OFFSET;
		totalHeight = totalHeight + height;
		if (totalHeight > offset) then
			return i - 1, height + offset - totalHeight;
		end
	end
	
	--We're scrolled completely off the bottom
	return #self.raresList, 0;
end

function RSExplorerRareList_Sort(self)
	local raresList = self.raresList
	local raresListInfo = self.raresListInfo
	
	local comparison = function(npcID1, npcID2) --whether the first argument should be before the second argument in the sequence
		-- Order by missing collectibles
		if (raresListInfo[npcID1].hasMissingMount ~= raresListInfo[npcID2].hasMissingMount) then
			if (raresListInfo[npcID1].hasMissingMount) then return true end
			if (raresListInfo[npcID2].hasMissingMount) then return false end
		end
				
		if (raresListInfo[npcID1].hasMissingPet ~= raresListInfo[npcID2].hasMissingPet) then
			if (raresListInfo[npcID1].hasMissingPet) then return true end
			if (raresListInfo[npcID2].hasMissingPet) then return false end
		end
				
		if (raresListInfo[npcID1].hasMissingToy ~= raresListInfo[npcID2].hasMissingToy) then
			if (raresListInfo[npcID1].hasMissingToy) then return true end
			if (raresListInfo[npcID2].hasMissingToy) then return false end
		end
				
		if (raresListInfo[npcID1].hasMissingDrakewatcher ~= raresListInfo[npcID2].hasMissingDrakewatcher) then
			if (raresListInfo[npcID1].hasMissingDrakewatcher) then return true end
			if (raresListInfo[npcID2].hasMissingDrakewatcher) then return false end
		end
				
		if (raresListInfo[npcID1].hasMissingAppearance ~= raresListInfo[npcID2].hasMissingAppearance) then
			if (raresListInfo[npcID1].hasMissingAppearance) then return true end
			if (raresListInfo[npcID2].hasMissingAppearance) then return false end
		end
				
		if (raresListInfo[npcID1].hasMissingCustom ~= raresListInfo[npcID2].hasMissingCustom) then
			if (raresListInfo[npcID1].hasMissingCustom) then return true end
			if (raresListInfo[npcID2].hasMissingCustom) then return false end
		end
				
		if (raresListInfo[npcID1].dead ~= raresListInfo[npcID2].dead) then
			if (raresListInfo[npcID1].dead) then return false end
			if (raresListInfo[npcID2].dead) then return true end
		end
				
		if (raresListInfo[npcID1].filtered ~= raresListInfo[npcID2].filtered) then
			if (raresListInfo[npcID1].filtered) then return false end
			if (raresListInfo[npcID2].filtered) then return true end
		end
		
		-- Otherwise order by name
		local strCmpResult = strcmputf8i(raresListInfo[npcID1].name, raresListInfo[npcID2].name);
		if (strCmpResult ~= 0) then
			return strCmpResult < 0;
		end
	end
	
	-- Order
	table.sort(self.raresList, comparison);
end

function RSExplorerRareList:Initialize(mainFrame)
	if (mainFrame.initialized) then
		return
	end
	
	self.mainFrame = mainFrame
	self.listScroll.update = function() self:UpdateData(); end;
	self.listScroll.dynamic = function(offset) return RSExplorerRareList_GetTopButton(self, offset) end;

	HybridScrollFrame_CreateButtons(self.listScroll, "RSExplorerListTemplate", 7, RARE_LIST_BUTTON_INITIAL_OFFSET, nil, nil, nil, RARE_LIST_BUTTON_OFFSET);
	self:UpdateRareList();
end

function RSExplorerRareList:AddFilteredRareToList(npcID, npcInfo, npcName)
	if (self.raresListInfo[npcID]) then
		return
	end
	
	self.raresListInfo[npcID] = {}
	self.raresListInfo[npcID].mapID = npcInfo.zoneID
	self.raresListInfo[npcID].displayID = npcInfo.displayID
	self.raresListInfo[npcID].name = npcName
	self.raresListInfo[npcID].filtered = RSConfigDB.GetNpcFiltered(npcID) ~= nil
	self.raresListInfo[npcID].dead = RSNpcDB.IsNpcKilled(npcID)
	self.raresListInfo[npcID].custom = npcInfo.custom
					
	tinsert(self.raresList, npcID)
	
	-- add extra information
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()
	if (collectionsLoot[RSConstants.ITEM_SOURCE.NPC] and collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID]) then
		if (RSUtils.GetTableLength(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
			self.raresListInfo[npcID].hasMissingMount = true
		else
			self.raresListInfo[npcID].hasMissingMount = false
		end
		if (RSUtils.GetTableLength(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][RSConstants.ITEM_TYPE.PET]) > 0) then
			self.raresListInfo[npcID].hasMissingPet = true
		else
			self.raresListInfo[npcID].hasMissingPet = false
		end
		if (RSUtils.GetTableLength(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][RSConstants.ITEM_TYPE.TOY]) > 0) then
			self.raresListInfo[npcID].hasMissingToy = true
		else
			self.raresListInfo[npcID].hasMissingToy = false
		end
		if (RSUtils.GetTableLength(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][RSConstants.ITEM_TYPE.APPEARANCE]) > 0) then
			if (RSConfigDB.IsSearchingClassAppearances()) then
				local found = false
				for _, itemID in pairs(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][RSConstants.ITEM_TYPE.APPEARANCE]) do
					if (RSCollectionsDB.IsNotCollectedClassAppearance(itemID)) then
						found = true
						break
					end
				end
				
				if (found) then
					self.raresListInfo[npcID].hasMissingAppearance = true
				end
			else
				self.raresListInfo[npcID].hasMissingAppearance = true
			end
		else
			self.raresListInfo[npcID].hasMissingAppearance = false
		end
		if (RSUtils.GetTableLength(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][RSConstants.ITEM_TYPE.DRAKEWATCHER]) > 0) then
			self.raresListInfo[npcID].hasMissingDrakewatcher = true
		else
			self.raresListInfo[npcID].hasMissingDrakewatcher = false
		end
		
		-- for custom items we show the texture only if they user is not filtering for an specific group
		for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do	
			if (RSUtils.GetTableLength(collectionsLoot[RSConstants.ITEM_SOURCE.NPC][npcID][string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)]) > 0 and RSConfigDB.IsSearchingCustom(groupKey)) then
				self.raresListInfo[npcID].hasMissingCustom = true
				break
			else
				self.raresListInfo[npcID].hasMissingCustom = false
			end
		end
	end
end

function RSExplorerRareList:UpdateRareList()
	self.raresList = {}
	self.raresListInfo = {}
	self.selectedNpcId = nil
	self.mapID = RSConfigDB.GetExplorerMapID()
	
	-- Load list
	for npcID, npcName in pairs(RSNpcDB.GetAllNpcNames()) do
		if (RSNpcDB.IsInternalNpcInMap(npcID, self.mapID, false)) then
			local npcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, self.mapID)
			
			if (npcInfo and npcInfo.displayID) then
				local filtered = false
				-- Ignore if dead
				if (not filters[RSConstants.EXPLORER_FILTER_DEAD] and RSNpcDB.IsNpcKilled(npcID)) then
					filtered = true
				end
				
				-- Ignore if filtered
				if (not filtered and not filters[RSConstants.EXPLORER_FILTER_FILTERED] and RSConfigDB.GetNpcFiltered(npcID) ~= nil) then
					filtered = true
				end
			
				if (not filtered) then
					local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
					
					if (filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
						self:AddFilteredRareToList(npcID, npcInfo, npcName)
					end
						
					if (filters[RSConstants.EXPLORER_FILTER_DROP_PETS] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.PET]) > 0) then
						self:AddFilteredRareToList(npcID, npcInfo, npcName)
					end
								
					if (filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.TOY]) > 0) then
						self:AddFilteredRareToList(npcID, npcInfo, npcName)
					end
								
					if (filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) > 0) then
						if (filters[RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES]) then
							for _, itemID in pairs(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) do
								if (RSCollectionsDB.IsNotCollectedClassAppearance(itemID)) then
									self:AddFilteredRareToList(npcID, npcInfo, npcName)
									break
								end
							end
						else
							self:AddFilteredRareToList(npcID, npcInfo, npcName)
						end
					end
								
					if (filters[RSConstants.EXPLORER_FILTER_DROP_DRAKEWATCHER] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.DRAKEWATCHER]) > 0) then
						self:AddFilteredRareToList(npcID, npcInfo, npcName)
					end
					
					for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do	
						if (filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)]) > 0) then
							self:AddFilteredRareToList(npcID, npcInfo, npcName)
						end
					end
								
					if (filters[RSConstants.EXPLORER_FILTER_PART_ACHIEVEMENT] and RSAchievementDB.GetNotCompletedAchievementLink(npcID, self.mapID)) then
						self:AddFilteredRareToList(npcID, npcInfo, npcName)
					end
								
					if (filters[RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES]) then
						if (not collectionsLoot or not collectionsLoot[npcID]) then
							self:AddFilteredRareToList(npcID, npcInfo, npcName)
						elseif (filters[RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES] and collectionsLoot and collectionsLoot[npcID] and RSUtils.GetTableLength(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) > 0) then
							for _, itemID in pairs(collectionsLoot[npcID][RSConstants.ITEM_TYPE.APPEARANCE]) do
								if (not RSCollectionsDB.IsNotCollectedClassAppearance(itemID)) then
									self:AddFilteredRareToList(npcID, npcInfo, npcName)
									break
								end
							end
						end
					end
				end
			else
				RSLogger:PrintDebugMessage(string.format("RSExplorerRareList:UpdateRareList: [npcID=%s]. Saltado por no tener informacion o displayID", npcID))
			end
		end
	end
	
	-- Sort
	RSExplorerRareList_Sort(self)
				
	-- Scroll to top
	HybridScrollFrame_ScrollToIndex(self.listScroll, 1, RSExplorerRareList_GetButtonHeight);
	self:Show()	
	self:UpdateData()
	
	-- Select first NPC	
	if (not self.selectedNpcId and RSUtils.GetTableLength(self.raresList) > 0) then
		self:SelectNpc(self.raresList[1])
	end
end

local function ToggleButtonTexture(activeTextures, texture, hasMissingType)
	if (hasMissingType) then
		texture:ClearAllPoints();
		texture:SetPoint("TOPRIGHT", -2 + (activeTextures * RARE_TEXTURE_OFFSET), -2)
		texture:Show()
		return activeTextures + 1
	else
		texture:Hide()
		return activeTextures
	end
end

function RSExplorerRareList:UpdateData()
	local scrollFrame = self.listScroll;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
	local numRares = #self.raresList
	
	local skipped = 0
	for i = 1, numButtons do
		local button = buttons[i];
		local index = offset + i + skipped; -- adjust index
		local npcID = self.raresList[index]
		
		if (index <= numRares) then
			local retOk, _ = pcall(SetPortraitTextureFromCreatureDisplayID, button.RareNPC.PortraitFrame.Portrait, self.raresListInfo[npcID].displayID)
			if (not retOk) then
				RSLogger:PrintDebugMessage(string.format("RSExplorerRareList:UpdateData: [npcID=%s][displayID=%s] Error al cargar el portaretrato.", npcID, self.raresListInfo[npcID].npcInfo.displayID or "nil"))
			end
			
			local activeTextures = 0
			activeTextures = ToggleButtonTexture(activeTextures, button.RareNPC.MountTexture, self.raresListInfo[npcID].hasMissingMount)
			activeTextures = ToggleButtonTexture(activeTextures, button.RareNPC.PetTexture, self.raresListInfo[npcID].hasMissingPet)
			activeTextures = ToggleButtonTexture(activeTextures, button.RareNPC.ToyTexture, self.raresListInfo[npcID].hasMissingToy)
			activeTextures = ToggleButtonTexture(activeTextures, button.RareNPC.DrakewatcherTexture, self.raresListInfo[npcID].hasMissingDrakewatcher)
			activeTextures = ToggleButtonTexture(activeTextures, button.RareNPC.AppearanceTexture, self.raresListInfo[npcID].hasMissingAppearance)
			activeTextures = ToggleButtonTexture(activeTextures, button.RareNPC.CustomTexture, self.raresListInfo[npcID].hasMissingCustom)
			
			if (self.selectedNpcId and self.selectedNpcId == npcID) then
				button.RareNPC.Selected:Show()
			else
				button.RareNPC.Selected:Hide()
			end
			
			button.RareNPC.npcID = npcID
			button.RareNPC.mapID = self.raresListInfo[npcID].mapID
			button.RareNPC.Name:SetText(self.raresListInfo[npcID].name)
			
			if (self.raresListInfo[npcID].dead) then
				button.RareNPC.Name:SetTextColor(0, 1, 1, 1)
			elseif (self.raresListInfo[npcID].filtered) then
				button.RareNPC.Name:SetTextColor(0.83, 0.83, 0.83, 1)
			else
				button.RareNPC.Name:SetTextColor(1, 0.85, 0, 1)
			end
			
			if (self.raresListInfo[npcID].filtered) then
				button.RareNPC.PortraitFrame.Portrait:SetDesaturated(1)
				button.RareNPC.MountTexture:SetDesaturated(1)
				button.RareNPC.PetTexture:SetDesaturated(1)
				button.RareNPC.ToyTexture:SetDesaturated(1)
				button.RareNPC.DrakewatcherTexture:SetDesaturated(1)
				button.RareNPC.AppearanceTexture:SetDesaturated(1)
				button.RareNPC.CustomTexture:SetDesaturated(1)
			else
				button.RareNPC.PortraitFrame.Portrait:SetDesaturated(nil)
				button.RareNPC.MountTexture:SetDesaturated(nil)
				button.RareNPC.PetTexture:SetDesaturated(nil)
				button.RareNPC.ToyTexture:SetDesaturated(nil)
				button.RareNPC.DrakewatcherTexture:SetDesaturated(nil)
				button.RareNPC.AppearanceTexture:SetDesaturated(nil)
				button.RareNPC.CustomTexture:SetDesaturated(nil)
			end
			
			if (self.raresListInfo[npcID].custom) then
				button.RareNPC.PortraitFrame.RareOverlay:Hide()
				button.RareNPC.PortraitFrame.CustomOverlay:Show()
			else
				button.RareNPC.PortraitFrame.RareOverlay:Show()
				button.RareNPC.PortraitFrame.CustomOverlay:Hide()
			end
			
			button:Show()
		else
			button:Hide()
		end
	end
	
	-- calculate the total height to pass to the HybridScrollFrame
	local totalHeight = -RARE_LIST_BUTTON_INITIAL_OFFSET;
	for i = 1, numRares do
		totalHeight = totalHeight + (RARE_BUTTON_HEIGHT - RARE_LIST_BUTTON_OFFSET);
	end

	local displayedHeight = numButtons * scrollFrame.buttonHeight;
	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);
end

local function RSExplorerLoadMap(mapID, mapFrame)
	-- Avoid refreshing if the map didn't change
	if (mapFrame.mapID and mapFrame.mapID == mapID) then
		return
	end
	
	mapFrame.mapID = mapID
	
	-- Initialize variables
	if (not mapFrame.detailLayerPool) then
		mapFrame.detailLayerPool = CreateFramePool("FRAME", mapFrame, "RSMapCanvasDetailLayerTemplate");
		mapFrame.iconsPool = CreateFramePool("FRAME", mapFrame, "RSMapCanvasDetailIconsTemplate");
		mapFrame.overlayIconsPool = CreateFramePool("FRAME", mapFrame, "RSMapCanvasDetailIconsTemplate");
	end
	
	-- Load map frame
	mapFrame.detailLayerPool:ReleaseAll();
	
	local layers = C_Map.GetMapArtLayers(mapID);	
	for layerIndex, layerInfo in ipairs(layers) do
		local detailLayer = mapFrame.detailLayerPool:Acquire();
		detailLayer:SetAllPoints(mapFrame);
		detailLayer:SetMapAndLayer(mapID, layerIndex, mapFrame);
		detailLayer:Show();
	end
end

local function AddIcon(icon, texture, x, y, r, g, b)
	if (not x or not y) then
		return
	end
	
	icon.Texture:SetTexture(texture)
	if (r and g and b) then
		icon.Texture:SetVertexColor(r, g, b, 0.4)
		icon.Texture:SetDrawLayer("ARTWORK");
	else
		icon.Texture:SetDrawLayer("OVERLAY");
	end
	
	local xOffset = 0
	local yOffset = 0
	if (x > 1) then
		xOffset = ((x / 100) * icon:GetParent():GetWidth()) / 100
		yOffset = ((y / 100) * icon:GetParent():GetHeight()) / 100
	else
		xOffset = x * icon:GetParent():GetWidth()
		yOffset = y * icon:GetParent():GetHeight()
	end
	
	icon:SetPoint("CENTER", icon:GetParent(), "TOPLEFT", xOffset, -yOffset)
	icon:Show()
end

function RSExplorerRareListButton_OnClick(self, button)
	local mainFrame = self:GetParent():GetParent():GetParent():GetParent().mainFrame
	if (button == "LeftButton") then
		mainFrame.RareNPCList:SelectNpc(self.npcID)
	elseif (button == "RightButton") then
		local npcName = RSNpcDB.GetNpcName(self.npcID)
		if (RSConfigDB.GetNpcFiltered(self.npcID) ~= nil) then
			RSLogger:PrintMessage(AL["ENABLED_SEARCHING_RARE"]..npcName)
			RSConfigDB.DeleteNpcFiltered(self.npcID)
		else
			RSLogger:PrintMessage(AL["DISABLED_SEARCHING_RARE"]..npcName)
			RSConfigDB.SetNpcFiltered(self.npcID)
		end
		mainFrame:Refresh()
	end
end

function RSExplorerRareListButton_OnEnter(self)
	local mainFrame = self:GetParent():GetParent():GetParent():GetParent().mainFrame
	local tooltip = mainFrame.Tooltip
	tooltip:SetOwner(self, "ANCHOR_LEFT")
	tooltip:SetText(RSNpcDB.GetNpcName(self.npcID))
	tooltip:AddLine(AL["EXPLORER_BUTTON_TOOLTIP1"], 1, 1, 1)
	if (RSConfigDB.GetNpcFiltered(self.npcID) ~= nil) then
		tooltip:AddLine(AL["EXPLORER_BUTTON_TOOLTIP2"], 1, 1, 1)
	else
		tooltip:AddLine(AL["EXPLORER_BUTTON_TOOLTIP3"], 1, 1, 1)
	end
	tooltip:Show()
end

function RSExplorerRareListButton_OnLeave(self)
	local mainFrame = self:GetParent():GetParent():GetParent():GetParent().mainFrame
	local tooltip = mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerRareList:AddItems(parentFrame, itemType, customGroupKeys)
	local mainFrame = self:GetParent()
	
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
	if (collectionsLoot and collectionsLoot[self.selectedNpcId]) then
		local itemIDs = collectionsLoot[self.selectedNpcId][itemType]
		
	    if (RSUtils.GetTableLength(itemIDs) > 0) then
			local xOffset = 0
			local yOffset = -8
			local numColumn = 0
			local numRow = 0
			local maxLines = 1
			local maxItemsPerRow
    		if (itemType ~= RSConstants.ITEM_TYPE.APPEARANCE and not RSUtils.Contains(customGroupKeys, itemType)) then
    			maxItemsPerRow = 3
 			else
 				maxLines = 4
    			maxItemsPerRow = 7
 			end
 			
	    	-- Custom settings reuse grid properties
	    	if (RSUtils.Contains(customGroupKeys, itemType) and mainFrame.RareInfo.Custom.grid) then
	    		xOffset, yOffset, numRow, numColumn, maxItemsPerRow = unpack(mainFrame.RareInfo.Custom.grid)
	    	end
   
	    	for _, itemID in ipairs(itemIDs) do
	    		-- If appearance only add if not filtering by class
	    		if (itemType ~= RSConstants.ITEM_TYPE.APPEARANCE or not RSConfigDB.IsSearchingClassAppearances() or RSCollectionsDB.IsNotCollectedClassAppearance(itemID)) then
		    		local _, _, _, _, icon, _, _ = C_Item.GetItemInfoInstant(itemID)
		    		local lootItem = mainFrame.lootItemsPool:Acquire();
		    		
		    		if (math.fmod(numColumn, maxItemsPerRow) == 0) then
		    			xOffset = xOffset + 10
		    		else
		    			xOffset = xOffset + lootItem:GetWidth() + 2
		    		end
		    		
		    		lootItem.itemID = itemID
		    		lootItem.Icon:SetTexture(icon)
		    		lootItem.isMount = itemType == RSConstants.ITEM_TYPE.MOUNT
		    		lootItem.isPet = itemType == RSConstants.ITEM_TYPE.PET
		    		lootItem.istoy = itemType == RSConstants.ITEM_TYPE.TOY
		    		lootItem.isDrakewatcher = itemType == RSConstants.ITEM_TYPE.DRAKEWATCHER
		    		lootItem.isAppearance = itemType == RSConstants.ITEM_TYPE.APPEARANCE
		    		lootItem.isCustom = RSUtils.Contains(customGroupKeys, itemType)
		    		
		    		lootItem:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xOffset, yOffset)
		    		lootItem:Show()
		    		
		    		numColumn = numColumn + 1
		    		
		    		if (math.fmod(numColumn, maxItemsPerRow) == 0) then
	    				numRow = numRow + 1
	    				if (numRow == maxLines) then	
	    					break
	    				end
	    				
	    				xOffset = 0
	    				numColumn = 0
	    				if (numRow > 1 and not lootItem.isAppearance and not lootItem.isCustom) then			
			    			break
			    		else	
			    			maxItemsPerRow = 8
			    			yOffset = yOffset - lootItem:GetHeight() - 2 
			    		end
	    			end
	    		end
	    	end
 			
	    	-- Custom settings save current grid properties
	    	if (RSUtils.Contains(customGroupKeys, itemType)) then
	    		mainFrame.RareInfo.Custom.grid = { xOffset, yOffset, numRow, numColumn, maxItemsPerRow }
	    	end
		end
	end
end

function RSExplorerRareList:SelectNpc(npcID)
	local mainFrame = self:GetParent()
	self.selectedNpcId = npcID
	self:UpdateData()
	
	local internalInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, self.mapID)
	
	-- Name
	mainFrame.RareInfo.Name:SetText(RSNpcDB.GetNpcName(npcID))
	
	-- Map
	local mapFrame = mainFrame.RareInfo.Map
	RSExplorerLoadMap(self.mapID, mapFrame)
	
	-- Icons / Spawning points
	mapFrame.overlayIconsPool:ReleaseAll()
	if (internalInfo.overlay) then
		local r, g, b = RSConfigDB.GetWorldMapOverlayColour(1)
		
		for _, coordinates in ipairs (internalInfo.overlay) do
			local x, y = strsplit("-", coordinates)
			local overlayIcon = mapFrame.overlayIconsPool:Acquire();
			AddIcon(overlayIcon, RSConstants.OVERLAY_SPOT_TEXTURE, tonumber(x), tonumber(y), r, g, b)
		end
	end
		
	-- Icons / Skull
	mapFrame.iconsPool:ReleaseAll()
	local npcPOI = RSNpcPOI.GetNpcPOI(npcID, self.mapID, internalInfo, RSGeneralDB.GetAlreadyFoundEntity(npcID))
	if (npcPOI) then
		local mainIcon = mapFrame.iconsPool:Acquire();
		AddIcon(mainIcon, npcPOI.Texture, tonumber(internalInfo.x), tonumber(internalInfo.y))
	end
	
	-- Achievement
	if (RSUtils.GetTableLength(npcPOI.achievementIDs) > 0) then
		for _, achievementID in ipairs(npcPOI.achievementIDs) do
			mainFrame.RareInfo.AchievementIcon.achievementLink = RSAchievementDB.GetCachedAchievementInfo(achievementID).link
			mainFrame.RareInfo.AchievementIcon:Show()
			break
		end
	else
		mainFrame.RareInfo.AchievementIcon:Hide()
	end
	
	-- Loot
	mainFrame.lootItemsPool:ReleaseAll();
	self:AddItems(mainFrame.RareInfo.Mounts, RSConstants.ITEM_TYPE.MOUNT)
	self:AddItems(mainFrame.RareInfo.Pets, RSConstants.ITEM_TYPE.PET)
	self:AddItems(mainFrame.RareInfo.Toys, RSConstants.ITEM_TYPE.TOY)
	self:AddItems(mainFrame.RareInfo.Drakewatcher, RSConstants.ITEM_TYPE.DRAKEWATCHER)
	self:AddItems(mainFrame.RareInfo.Appearances, RSConstants.ITEM_TYPE.APPEARANCE)
	
	-- Refresh internal loot grid
	mainFrame.RareInfo.Custom.grid = nil
	
	-- With custom items take into account only if not filtered
	local customGroupKeys = {}
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		if (RSConfigDB.IsSearchingCustom(groupKey)) then
			tinsert(customGroupKeys, string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey))
		end
	end
	
	for _, customGroupKey in ipairs(customGroupKeys) do
		self:AddItems(mainFrame.RareInfo.Custom, customGroupKey, customGroupKeys)
	end
end

-----------------------------------------------------
-- Rare loot
-----------------------------------------------------

function RSExplorerRareInfoLootItem_OnEnter(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	local itemIcon = self
	local item = Item:CreateFromItemID(self.itemID)
	item:ContinueOnItemLoad(function()
		tooltip:SetOwner(itemIcon, "BOTTOM_LEFT")
		tooltip:SetHyperlink(item:GetItemLink())
		
		-- Adds extra information
		RSLootTooltip.AddRareScannerInformation(tooltip, item:GetItemLink(), self.itemID)

		tooltip:Show()
	end)
end

function RSExplorerRareInfoLootItem_OnLeave(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerRareInfoAchievement_OnEnter(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:SetOwner(self, "BOTTOM_LEFT")
	tooltip:SetHyperlink(self.achievementLink)
	tooltip:Show()
end

function RSExplorerRareInfoAchievement_OnLeave(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerRareInfoLootItem_OnClick(self, button)
	local itemIcon = self
	local item = Item:CreateFromItemID(self.itemID)
	item:ContinueOnItemLoad(function()
		if (IsControlKeyDown()) then
			if (itemIcon.isMount) then
				DressUpMountLink(item:GetItemLink())
			elseif (itemIcon.isPet) then
				DressUpBattlePetLink(item:GetItemLink())
			elseif (itemIcon.isAppearance) then
				DressUpItemLink(item:GetItemLink())
			end
		elseif (IsShiftKeyDown()) then
			ChatEdit_LinkItem(self.itemID, item:GetItemLink())
		end
	end)
end

-----------------------------------------------------
-- Rare detail frame
-----------------------------------------------------

RSExplorerDetailMap = { };

function RSExplorerDetailMap:OnLoad()
	self.detailTilePool = CreateTexturePool(self, "BACKGROUND", -7);
	self.overlayTexturePool = CreateTexturePool(self, "ARTWORK", 0);
	self.textureLoadGroup = CreateFromMixins(TextureLoadingGroupMixin);
	self.defailedTextureLoadGroup = CreateFromMixins(TextureLoadingGroupMixin);
end

function RSExplorerDetailMap:IsFullyLoaded()
	return not self.isWaitingForLoad;
end

function RSExplorerDetailMap:SetMapAndLayer(mapID, layerIndex, mapFrame)
	local mapArtID = C_Map.GetMapArtID(mapID) -- phased map art may be different for the same mapID
	if (self.mapID ~= mapID or self.mapArtID ~= mapArtID or self.layerIndex ~= layerIndex) then
		self.mapID = mapID;
		self.mapArtID = mapArtID;
		self.layerIndex = layerIndex;
		self:RefreshDetailTiles(mapFrame);
	end
end

function RSExplorerDetailMap:RefreshDetailTiles(mapFrame)
	self.detailTilePool:ReleaseAll();
	self.overlayTexturePool:ReleaseAll();
	self.textureLoadGroup:Reset();
	self.defailedTextureLoadGroup:Reset();
	self.isWaitingForLoad = true;
	self:SetAlpha(0);
	
	local layers = C_Map.GetMapArtLayers(self.mapID);
	local layerInfo = layers[self.layerIndex];
	local numDetailTilesRows = math.ceil(layerInfo.layerHeight / layerInfo.tileHeight);
	local numDetailTilesCols = math.ceil(layerInfo.layerWidth / layerInfo.tileWidth);
	local textures = C_Map.GetMapArtLayerTextures(self.mapID, self.layerIndex);
	local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(self.mapID)
	
	local prevRowDetailTile;
	local prevColDetailTile;
	
	-- Add unexplored layer
	for tileCol = 1, numDetailTilesCols do
		for tileRow = 1, numDetailTilesRows do
			if tileRow == 1 then
				prevRowDetailTile = nil;
			end
			local detailTile = self.detailTilePool:Acquire();
			self.textureLoadGroup:AddTexture(detailTile);
			local textureIndex = (tileRow - 1) * numDetailTilesCols + tileCol;
			detailTile:SetTexture(textures[textureIndex], nil, nil, "TRILINEAR");
			detailTile:ClearAllPoints();
			if prevRowDetailTile then
				detailTile:SetPoint("TOPLEFT", prevRowDetailTile, "BOTTOMLEFT");
			else
				if prevColDetailTile then
					detailTile:SetPoint("TOPLEFT", prevColDetailTile, "TOPRIGHT");
				else
					detailTile:SetPoint("TOPLEFT", self);
				end
			end
			detailTile:SetDrawLayer("BACKGROUND", -8 + self.layerIndex);
			detailTile:Show();			
			prevRowDetailTile = detailTile;
			if tileRow == 1 then
				prevColDetailTile = detailTile;
			end
		end
	end
	
	-- Add explored overlay
	if (exploredMapTextures) then
		local TILE_SIZE_WIDTH = layerInfo.tileWidth;
		local TILE_SIZE_HEIGHT = layerInfo.tileHeight;
		for i, exploredTextureInfo in ipairs(exploredMapTextures) do
			local numTexturesWide = ceil(exploredTextureInfo.textureWidth/TILE_SIZE_WIDTH);
			local numTexturesTall = ceil(exploredTextureInfo.textureHeight/TILE_SIZE_HEIGHT);
			local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight;
			for j = 1, numTexturesTall do
				if ( j < numTexturesTall ) then
					texturePixelHeight = TILE_SIZE_HEIGHT;
					textureFileHeight = TILE_SIZE_HEIGHT;
				else
					texturePixelHeight = mod(exploredTextureInfo.textureHeight, TILE_SIZE_HEIGHT);
					if ( texturePixelHeight == 0 ) then
						texturePixelHeight = TILE_SIZE_HEIGHT;
					end
					textureFileHeight = 16;
					while(textureFileHeight < texturePixelHeight) do
						textureFileHeight = textureFileHeight * 2;
					end
				end
				for k = 1, numTexturesWide do
					local texture = self.overlayTexturePool:Acquire();
					self.defailedTextureLoadGroup:AddTexture(texture);
					if ( k < numTexturesWide ) then
						texturePixelWidth = TILE_SIZE_WIDTH;
						textureFileWidth = TILE_SIZE_WIDTH;
					else
						texturePixelWidth = mod(exploredTextureInfo.textureWidth, TILE_SIZE_WIDTH);
						if ( texturePixelWidth == 0 ) then
							texturePixelWidth = TILE_SIZE_WIDTH;
						end
						textureFileWidth = 16;
						while(textureFileWidth < texturePixelWidth) do
							textureFileWidth = textureFileWidth * 2;
						end
					end
					texture:SetWidth(texturePixelWidth);
					texture:SetHeight(texturePixelHeight);
					texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight);
					texture:SetPoint("TOPLEFT", exploredTextureInfo.offsetX + (TILE_SIZE_WIDTH * (k-1)), -(exploredTextureInfo.offsetY + (TILE_SIZE_HEIGHT * (j - 1))));
					texture:SetTexture(exploredTextureInfo.fileDataIDs[((j - 1) * numTexturesWide) + k], nil, nil, "TRILINEAR");
					texture:SetDrawLayer("ARTWORK", -1);
					texture:Show();
				end
			end
		end
	end
	
	-- Rescale
	local mapWidth = layerInfo.layerWidth
	if (mapWidth ~= mapFrame:GetWidth()) then
		local scaleFactor = mapFrame:GetWidth() / mapWidth
		self:SetScale(scaleFactor)
	end
end


function RSExplorerDetailMap:OnUpdate()
	if (self.isWaitingForLoad and self.textureLoadGroup:IsFullyLoaded() and self.defailedTextureLoadGroup:IsFullyLoaded()) then
		self.isWaitingForLoad = nil;
		self:RefreshAlpha();
		self.textureLoadGroup:Reset();
		self.defailedTextureLoadGroup:Reset();
	end
end

function RSExplorerDetailMap:RefreshAlpha()
	if (self:IsFullyLoaded()) then
		self:SetAlpha(1);
	else
		self:SetAlpha(0);
	end
end

-----------------------------------------------------
-- Control frames
-----------------------------------------------------

RSExplorerControl = {}

function RSExplorerControl:Initialize(mainFrame)
	if (mainFrame.initialized) then
		return
	end
	
	self.mainFrame = mainFrame
	self.ApplyFiltersButton:SetText(AL["EXPLORER_FILTERING"])
	self.ApplyFiltersButton.tooltip = string.format(AL["EXPLORER_FILTERING_DESC"], AL["EXPLORER_FILTERS"], AL["EXPLORER_FILTER_COLLECTIONS"])
	self.CreateProfilesBackupCheckButton.Text:SetText(AL["EXPLORER_CREATE_BACKUP"])
	self.CreateProfilesBackupCheckButton.tooltip = string.format(AL["EXPLORER_CREATE_BACKUP_DESC"], AL["EXPLORER_FILTERING"])
	self.CreateProfilesBackupCheckButton:SetChecked(RSConfigDB.IsCreateProfileBackup())
	self.CreateProfilesBackupCheckButton.func = function(self, checked)
		RSConfigDB.SetCreateProfileBackup(checked)
	end
	
	self.AutoFilterCheckButton.Text:SetText(AL["EXPLORER_AUTO_FILTER"])
	self.AutoFilterCheckButton.tooltip = AL["EXPLORER_AUTO_FILTER_DESC"]
	self.AutoFilterCheckButton:SetChecked(RSConfigDB.IsAutoFilteringOnCollect())
	self.AutoFilterCheckButton.func = function(self, checked)
		RSConfigDB.SetAutoFilteringOnCollect(checked)
	end
end

function RSExplorerControl:StartScanning(self, button)
	if (self:IsShown()) then
		local mainFrame = self:GetParent():GetParent()
		
		self:Hide()
		self:GetParent().ScanProcessText:Show()
		mainFrame:HideCustomLootPanels()
		
		local manualScan = self:GetParent().ScanRequiredText:GetText() == AL["EXPLORER_SCAN_MANUAL"]
		
		RSCollectionsDB.ApplyCollectionsEntitiesFilters(function()
	    	self:GetParent():Hide()
			self:GetParent().ScanProcessText:Hide()
    		mainFrame.RareInfo:Show()
			mainFrame:Initialize()
	    end, self:GetParent().ScanProcessText, manualScan)
	end
end

function RSExplorerControl:ApplyFilters(self, button)
	local mainFrame = self:GetParent().mainFrame
	local data = {
		callback = function()
			mainFrame:Refresh()
			local subdata = {
				filters = filters
			}
			LibDialog:Spawn(RSConstants.APPLY_COLLECTIONS_LOOT_FILTERS, subdata)
		end,
		filters = filters
	}
	LibDialog:Spawn(RSConstants.EXPLORER_FILTERING_DIALOG, data)
end

-----------------------------------------------------
-- Custom loot panel
-----------------------------------------------------

RSExplorerLoot = { };

local GROUP_BUTTON_HEIGHT = 20;

function RSExplorerGroupList_GetButtonHeight()
	return GROUP_BUTTON_HEIGHT;
end

function RSExplorerGroupList_GetTopButton(self, offset)
	local buttonHeight = self.GroupList.listScroll.buttonHeight;
	local groupList = self.groupList;
	local totalHeight = 0;
	for i = 1, #raresList do
		local height = GROUP_BUTTON_HEIGHT;
		totalHeight = totalHeight + height;
		if (totalHeight > offset) then
			return i - 1, height + offset - totalHeight;
		end
	end
	
	--We're scrolled completely off the bottom
	return #self.groupList, 0;
end

function RSExplorerGroupListButton_OnClick(self, button)
	local customLoot = self:GetParent():GetParent():GetParent():GetParent():GetParent()
	if (button == "LeftButton") then
		customLoot:SelectGroup(self.groupKey, self.groupName)
	end
end

local function LootGroupDropDown_SetupMenu(dropDown, rootDescription)
	local itemGroups = RSCollectionsDB.GetItemGroups()
	
	for key, name in pairs(itemGroups) do
		rootDescription:CreateRadio(name, 
			function(key)
				return dropDown.selectedGroupKey == key
			end, 
			function(key)
				dropDown.selectedGroupKey = key
			end,
			key)
	end
	
	-- Selects the first value
 	if (not dropDown.selectedGroupKey) then
	 	for key, name in pairs (itemGroups) do
			dropDown.selectedGroupKey = key
			break
		end
	end
end

function RSExplorerLoot:AddNewGroup(editbox)
	local value = editbox:GetText()
	if (value and strtrim(value) ~= '') then
		local key = RSCollectionsDB.AddItemGroup(value)
		if (key) then
			editbox:GetParent().LootGroupDropDown.selectedGroupKey = key
			editbox:GetParent().LootGroupDropDown:GenerateMenu()
			editbox:SetText("")
			editbox:ClearFocus()
			self:UpdateGroupList()
		end
	end
end

function RSExplorerLoot:EditGroupName(editbox)
	local mainFrame = editbox:GetParent():GetParent()
	local controlFrame = mainFrame.ControlFrame
	local newGroupName = editbox:GetText()
	
	-- Change name
	RSCollectionsDB.SetGroupName(self.GroupList.selectedGroup, newGroupName)
	
	-- Refresh group dropdown if selected
	if (self.ControlFrame.LootGroupDropDown.selectedGroupKey == self.GroupList.selectedGroup) then
		controlFrame.LootGroupDropDown:GenerateMenu()
	end
	
	self:UpdateGroupList()
end

function RSExplorerLoot:DeleteGroup(buttonFrame, button)
	local mainFrame = self
	local data = {
		callback = function()
			RSCollectionsDB.DeleteItemGroup(mainFrame.GroupList.selectedGroup)
	
			-- Selects the first item in the list
			for key, name in pairs(RSCollectionsDB.GetItemGroups()) do
				mainFrame.ControlFrame.LootGroupDropDown.selectedGroupKey = key
				mainFrame.ControlFrame.LootGroupDropDown:GenerateMenu()
				break
			end
			
			mainFrame.GroupInfo.lootItemsPool:ReleaseAll();
			mainFrame:UpdateGroupList()
		end
	}
	LibDialog:Spawn(RSConstants.DELETE_GROUP_CONFIRMATION, data)
end

function RSExplorerLoot:AddItems(editbox)
	local value = editbox:GetText()
	local groupKey = self.GroupList.selectedGroup
	if (value and strtrim(value) ~= '') then
		-- Validates string
		if (string.match(value, "[^0-9,]")) then
			LibDialog:Spawn(RSConstants.ITEM_LIST_VALIDATION_ERROR);
			return
		end
		
		-- Validates items
		local errorIDs = {}
		for itemIDstring in string.gmatch(value, '([^,]+)') do
			local itemID = tonumber(itemIDstring)
			local ret, _, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = pcall(C_Item.GetItemInfoInstant, itemID)
			if (not ret or not icon) then
				tinsert(errorIDs, itemID)
			else
				RSCollectionsDB.AddGroupItem(groupKey, itemID)
			end
		end
		
		-- Prints wrong IDs
		if (RSUtils.GetTableLength(errorIDs) > 0) then
			LibDialog:Spawn(RSConstants.ITEM_LIST_WRONG_IDS_ERROR);
			local errorIDsString
			for _, itemID in ipairs(errorIDs) do
				if (not errorIDsString) then
					errorIDsString = itemID
				else
					errorIDsString = string.format("%s, %s", errorIDsString, itemID)
				end
			end
			RSLogger:PrintMessage(string.format(AL["EXPLORER_CUSTOM_ITEMS_WRONG_IDS_CHAT"], errorIDsString))
			return
		end
		
		-- Clean inputfield
		editbox:SetText("")
		
		-- Refresh info panel
		self:Refresh()
	end
end

function RSExplorerLoot:Refresh()
	self:SelectGroup(self.GroupList.selectedGroup, self.GroupList.groupName)
end

function RSExplorerLoot:UpdateData()
	local scrollFrame = self.GroupList.listScroll;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
	local numGroups = #self.GroupList.groupList
	
	local skipped = 0
	for i = 1, numButtons do
		local button = buttons[i];
		local index = offset + i + skipped; -- adjust index
		
		if (index <= numGroups) then
			local groupName = self.GroupList.groupList[i]
			local groupKey = RSCollectionsDB.GetGroupKeyByName(groupName)
			button.Group.groupKey = groupKey
			button.Group.groupName = groupName
			button.Group.Name:SetText(groupName)
			
			if (self.GroupList.selectedGroup and self.GroupList.selectedGroup == groupKey) then
				button.Group.Selected:Show()
			else
				button.Group.Selected:Hide()
			end
			
			button:Show()
		else
			button:Hide()
		end
	end
	
	-- calculate the total height to pass to the HybridScrollFrame
	local totalHeight = 0;
	for i = 1, numGroups do
		totalHeight = totalHeight + (GROUP_BUTTON_HEIGHT);
	end

	local displayedHeight = numButtons * scrollFrame.buttonHeight;
	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);
end

function RSExplorerLoot:SelectGroup(groupKey, groupName)
	self.GroupList.selectedGroup = groupKey
	self.GroupList.groupName = groupName
	self:UpdateData()
	self.GroupInfo.EditGroupName:SetText(groupName)
	
	-- Cleans current list
	self.GroupInfo.lootItemsPool:ReleaseAll();
		
	-- Name
	local itemIDs = RSCollectionsDB.GetGroupItems(groupKey)
	if (RSUtils.GetTableLength(itemIDs) == 0) then
		self.GroupInfo.NoItems:Show()
	else
		self.GroupInfo.NoItems:Hide()
		
		local xOffset = 0
		local yOffset = -2
		local numColumn = 0
		local numRow = 0
		local maxLines = 8
		local maxItemsPerRow = 17
    	for _, itemID in ipairs(itemIDs) do
    		local _, _, _, _, icon, _, _ = C_Item.GetItemInfoInstant(itemID)
    		local lootItem = self.GroupInfo.lootItemsPool:Acquire();
    		
    		if (math.fmod(numColumn, maxItemsPerRow) ~= 0) then
    			xOffset = xOffset + lootItem:GetWidth() + 2
    		end
    		
    		lootItem.itemID = itemID
    		lootItem.groupKey = groupKey
    		lootItem.Icon:SetTexture(icon)
    		lootItem:SetPoint("TOPLEFT", self.GroupInfo.ItemPanel, "TOPLEFT", xOffset, yOffset)
    		lootItem:Show()
    		
    		numColumn = numColumn + 1
    		
    		if (math.fmod(numColumn, maxItemsPerRow) == 0) then
				numRow = numRow + 1
				if (numRow == maxLines) then
					break
				end
				
				xOffset = 0
				numColumn = 0
				yOffset = yOffset - lootItem:GetHeight() - 2
			end
    	end
	end
end

function RSExplorerLoot:UpdateGroupList()
	local groupValueList = {}
	self.GroupList.selectedGroup = nil
	
	-- Load list
	for key, name in pairs(RSCollectionsDB.GetItemGroups()) do
		tinsert(groupValueList, name)
	end
	
	local comparison = function(value1, value2)
		-- Otherwise order by name
		local strCmpResult = strcmputf8i(value1, value2);
		if (strCmpResult ~= 0) then
			return strCmpResult < 0;
		end
		
		return false
	end
	
	-- Sort
	table.sort(groupValueList, comparison)
	self.GroupList.groupList = groupValueList
				
	-- Scroll to top
	HybridScrollFrame_ScrollToIndex(self.GroupList.listScroll, 1, RSExplorerGroupList_GetButtonHeight);
	self:Show()	
	self:UpdateData()
	
	-- Select first group	
	if (not self.GroupList.selectedGroup and RSUtils.GetTableLength(groupValueList) > 0) then
		self:SelectGroup(RSCollectionsDB.GetGroupKeyByName(groupValueList[1]), groupValueList[1])
	end
end

function RSExplorerCustomLootItem_OnEnter(self)
	local customLoot = self:GetParent():GetParent()
	local tooltip = customLoot.mainFrame.Tooltip
	local itemIcon = self
	local item = Item:CreateFromItemID(self.itemID)
	item:ContinueOnItemLoad(function()
		tooltip:SetOwner(itemIcon, "BOTTOM_LEFT")
		tooltip:SetHyperlink(item:GetItemLink())
		
		-- Adds extra information only for this tooltip
		tooltip:AddLine(RSUtils.TextColor(string.format(AL["EXPLORER_CUSTOM_ITEMS_TOOLTIP_ID"], item:GetItemID()), "FFFF00"))
		tooltip:AddLine(" ")
		tooltip:AddLine("|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:0:32|t "..RSUtils.TextColor(AL["EXPLORER_CUSTOM_ITEMS_TOOLTIP_DROP"], "00FF00"))
		
		tooltip:Show()
	end)
end

function RSExplorerCustomLootItem_OnLeave(self)
	local customLoot = self:GetParent():GetParent()
	local tooltip = customLoot.mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerCustomLootItem_OnClick(self, button)
	local customLoot = self:GetParent():GetParent()
	local itemIcon = self
	
	if (button == "LeftButton" and not IsAltKeyDown() and IsShiftKeyDown()) then
		local item = Item:CreateFromItemID(itemIcon.itemID)
		item:ContinueOnItemLoad(function()
			ChatEdit_LinkItem(self.itemID, item:GetItemLink())
		end)
	elseif (button == "LeftButton" and IsAltKeyDown() and IsShiftKeyDown()) then
		RSCollectionsDB.DeleteGroupItem(self.groupKey, itemIcon.itemID)
		customLoot:Refresh()
	end
end

function RSExplorerLoot:Initialize(mainFrame)
	if (self.initialized) then
		return
	end
	
	self.initialized = true
	self.mainFrame = mainFrame
	self.ControlFrame.mainFrame = mainFrame
	
	-- Control panel
	self.ControlFrame.LootGroupLabel:SetText(AL["EXPLORER_CUSTOM_ITEMS_GROUP"])
	self.ControlFrame.LootNewGroupLabel:SetText(AL["EXPLORER_CUSTOM_ITEMS_ADD_GROUP"])
	self.ControlFrame.LootGroupDropDown.tooltip = AL["EXPLORER_CUSTOM_ITEMS_GROUP_DESC"]
	self.ControlFrame.LootGroupDropDown:SetupMenu(LootGroupDropDown_SetupMenu)
	self.ControlFrame.NewGroup.tooltip = AL["EXPLORER_CUSTOM_ITEMS_ADD_GROUP_DESC"]
	self.ControlFrame.ItemListLabel:SetText(AL["EXPLORER_CUSTOM_ITEMS_LIST"])
	self.ControlFrame.ItemList.tooltip = AL["EXPLORER_CUSTOM_ITEMS_LIST_DESC"]
	
	-- Group info
	self.GroupInfo.mainFrame = mainFrame
	self.GroupInfo.DeleteGroup:SetText(AL["EXPLORER_CUSTOM_ITEMS_DELETE_GROUP"])
	self.GroupInfo.EditGroupName.tooltip = AL["EXPLORER_CUSTOM_ITEMS_EDIT_GROUP"]
	self.GroupInfo.NoItems:SetText(AL["EXPLORER_CUSTOM_ITEMS_GROUP_EMPTY"])
	self.GroupInfo.lootItemsPool = CreateFramePool("Button", self.GroupInfo, "RSExplorerCustomLootItemTemplate");
	
	-- Group list
	self.GroupList.update = function() self:UpdateData(); end;
	self.GroupList.dynamic = function(offset) return RSExplorerGroupList_GetTopButton(self, offset)	end;
	HybridScrollFrame_CreateButtons(self.GroupList.listScroll, "RSExplorerGroupListTemplate");
	self:UpdateGroupList();
	
	-- Starts hidding it
	mainFrame:HideCustomLootPanels()
end

-----------------------------------------------------
-- Explorer main frame
-----------------------------------------------------

RSExplorerMixin = { };

function RSExplorerMixin:OnLoad()
	self.lootItemsPool = CreateFramePool("Button", self.RareInfo, "RSExplorerRareInfoLootItemTemplate");
	self.RareInfo.Mounts.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\MountsCorner.blp")
	self.RareInfo.Mounts.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Mounts.Texture.tooltip = AL["EXPLORER_MOUNTS"]
	self.RareInfo.Pets.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\PetsCorner.blp")
	self.RareInfo.Pets.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Pets.Texture.tooltip = AL["EXPLORER_PETS"]
	self.RareInfo.Toys.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\ToysCorner.blp")
	self.RareInfo.Toys.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Toys.Texture.tooltip = AL["EXPLORER_TOYS"]
	self.RareInfo.Drakewatcher.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\DrakewatcherCorner.blp")
	self.RareInfo.Drakewatcher.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Drakewatcher.Texture.tooltip = AL["EXPLORER_DRAKEWATCHER"]
	self.RareInfo.Appearances.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\AppearancesCorner.blp")
	self.RareInfo.Appearances.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Appearances.Texture.tooltip = AL["EXPLORER_APPEARANCES"]
	self.RareInfo.Custom.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\CustomCorner.blp")
	self.RareInfo.Custom.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Custom.Texture.tooltip = AL["EXPLORER_CUSTOM"]
	self:RegisterForDrag("LeftButton");
	tinsert(UISpecialFrames, self:GetName());
end

function RSExplorerMixin:HideCustomLootPanels()
	self.CustomLoot:Hide()
	self.CustomLoot.background:Hide()
	self.CustomLoot.background2:Hide()
	self.CustomLoot.Border:Hide()
	self.CustomLoot.ControlFrame:Hide()
	self.CustomLoot.GroupList:Hide()
	self.CustomLoot.GroupInfo:Hide()
	
	-- Move to the center
	self.ScanRequired:SetPoint("TOPLEFT")
	self.ScanRequired:SetPoint("TOPRIGHT")
	self.ScanRequired.moved = false
end

function RSExplorerMixin:ShowCustomLootPanels()
	self.CustomLoot:Show()
	self.CustomLoot.background:Show()
	self.CustomLoot.background2:Show()
	self.CustomLoot.Border:Show()
	self.CustomLoot.ControlFrame:Show()
	self.CustomLoot.GroupList:Show()
	self.CustomLoot.GroupInfo:Show()
	
	-- Move to the bottom
	if (not self.ScanRequired.moved) then
		local pointte, relativeTote, relativePointte, xOfste, yOfste = self.ScanRequired:GetPoint()
		self.ScanRequired:SetPoint(pointte, relativeTote, relativePointte, xOfste, yOfste - 300)
		self.ScanRequired.moved = true
	end
end

function RSExplorerMixin:HideContentPanels()
	self.RareInfo:Hide()
	self.RareNPCList:Hide()
	self.RareNPCList.background:Hide()
	self.RareNPCList.ElevatedFrame:Hide()
	self.RareNPCList.listScroll:Hide()
	self.Filters:Hide()
	self.Control:Hide()
end

function RSExplorerMixin:ShowContentPanels()
	self.RareInfo:Show()
	self.RareNPCList:Show()
	self.RareNPCList.background:Show()
	self.RareNPCList.ElevatedFrame:Show()
	self.RareNPCList.listScroll:Show()
	self.Filters:Show()
	self.Control:Show()
end

function RSExplorerMixin:Initialize()
	filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] = RSConfigDB.IsSearchingMounts()
	filters[RSConstants.EXPLORER_FILTER_DROP_PETS] = RSConfigDB.IsSearchingPets()
	filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] = RSConfigDB.IsSearchingToys()
	filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] = RSConfigDB.IsSearchingAppearances()
	filters[RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES] = RSConfigDB.IsSearchingClassAppearances()
	filters[RSConstants.EXPLORER_FILTER_DROP_DRAKEWATCHER] = RSConfigDB.IsSearchingDrakewatcher()
	filters[RSConstants.EXPLORER_FILTER_DEAD] = RSConfigDB.IsShowDead()
	filters[RSConstants.EXPLORER_FILTER_FILTERED] = RSConfigDB.IsShowFiltered()
	filters[RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES] = RSConfigDB.IsShowWithoutCollectibles()
	
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] = RSConfigDB.IsSearchingCustom(groupKey)
	end
	
	self.Filters:Initialize(self);
	self.RareNPCList:Initialize(self);
	self.Control:Initialize(self);
	self.CustomLoot:Initialize(self);
	self.initialized = true
end

function RSExplorerMixin:OnShow()
    -- check if there is a new database and it requires a new scan
    if (not RSCollectionsDB.IsCollectionsScanDoneWithCurrentVersion()) then
    	self.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_SCAN_REQUIRED"])
    	self.ScanRequired.StartScanningButton:SetText(AL["EXPLORER_START_SCAN"])
    	self.ScanRequired.StartScanningButton:Show()		
    	self.CustomLoot:Show()
    	self.ScanRequired:Show()
    	self:HideContentPanels()
		self.CustomLoot:Initialize(self);
    	self:ShowCustomLootPanels()
    elseif (not self.initialized) then
		self:Initialize()
	end
	-- change to player's zone
	if (RSConfigDB.IsLockingCurrentMap()) then
		self:Refresh()
	end
	
	self:Show()
end

function RSExplorerMixin:Refresh()
	if (self.initialized) then
		PopulateContinentDropDown(self, self.Filters.ContinentDropDown)
		self.RareNPCList:UpdateRareList()
	end
end

function RSExplorerMixin:ShowTooltip(frame, message)
	if (frame.tooltip or message) then
		local tooltip = self.Tooltip
		tooltip:SetOwner(frame, "ANCHOR_BOTTOM")
		tooltip:AddLine(message or frame.tooltip, 1, 1, 1, true)
		tooltip:Show()
	end
end

function RSExplorerMixin:HideTooltip(frame)
	if (frame.tooltip or message) then
		local tooltip = self.Tooltip
		tooltip:Hide()
	end
end
