-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local LibDialog = LibStub("LibDialog-1.0RS")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")

---============================================================================
-- Start filtering by collections
---============================================================================

LibDialog:Register(RSConstants.EXPLORER_FILTERING_DIALOG, {
	text = string.format(AL["EXPLORER_FILTERING_DIALOG"], AL["EXPLORER_FILTERS"], AL["EXPLORER_FILTER_COLLECTIONS"], AL["EXPLORER_FILTER_MOUNTS"], AL["EXPLORER_FILTER_TOYS"]),
	no_close_button = true,
    buttons = {
        {
            text = YES,
            on_click = function(self, mouseButton, down)
            	local callback = self.data.callback
        		RSCollectionsDB.ApplyFilters(self.data.filters, function()
					callback()
					RSLogger:PrintMessage(AL["LOG_DONE"])
				end)
            end,
        },
        {
            text = NO,
            on_click = function(self, mouseButton, down)
            	LibDialog:Dismiss(RSConstants.EXPLORER_FILTERING_DIALOG)
            end,
        },
    },          
})

---============================================================================
-- Apply collections filters to loot displayed
---============================================================================

LibDialog:Register(RSConstants.APPLY_COLLECTIONS_LOOT_FILTERS, {
	text = AL["APPLY_COLLECTIONS_LOOT_FILTERS"],
	no_close_button = true,
    buttons = {
        {
            text = YES,
            on_click = function(self, mouseButton, down)
				RSConfigDB.SetFilteringByExplorerResults(true); 
				
				if (self.data.filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS]) then
					RSConfigDB.SetShowingMissingMounts(true)
				else
					RSConfigDB.SetShowingMissingMounts(false)
				end
				
				if (self.data.filters[RSConstants.EXPLORER_FILTER_DROP_PETS]) then
					RSConfigDB.SetShowingMissingPets(true)
				else
					RSConfigDB.SetShowingMissingPets(false)
				end
				
				if (self.data.filters[RSConstants.EXPLORER_FILTER_DROP_TOYS]) then
					RSConfigDB.SetShowingMissingToys(true)
				else
					RSConfigDB.SetShowingMissingToys(false)
				end
				
				if (self.data.filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES]) then
					RSConfigDB.SetShowingMissingAppearances(true)
				else
					RSConfigDB.SetShowingMissingAppearances(false)
				end
				
				if (self.data.filters[RSConstants.EXPLORER_FILTER_DROP_CLASS_APPEARANCES]) then
					RSConfigDB.SetShowingMissingClassAppearances(true)
				else
					RSConfigDB.SetShowingMissingClassAppearances(false)
				end
				
				if (self.data.filters[RSConstants.EXPLORER_FILTER_DROP_DRAKEWATCHER]) then
					RSConfigDB.SetShowingMissingDrakewatcher(true)
				else
					RSConfigDB.SetShowingMissingDrakewatcher(false)
				end
				
				for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
					if (self.data.filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)]) then
						RSConfigDB.SetShowingCustomItems(groupKey, true)
					else
						RSConfigDB.SetShowingCustomItems(groupKey, false)
					end
				end
				
				RSLogger:PrintMessage(AL["LOG_LOOT_FILTERS_APPLIED"])
            end,
        },
        {
            text = NO,
            on_click = function(self, mouseButton, down)
                LibDialog:Dismiss(RSConstants.APPLY_COLLECTIONS_LOOT_FILTERS)
            end,
        },
    },          
})

---============================================================================
-- Scan not done
---============================================================================

LibDialog:Register(RSConstants.EXPLORER_SCAN_NOT_DONE, {
	text = AL["EXPLORER_SCAN_NOT_DONE"],
	no_close_button = true,
    buttons = {
        {
            text = YES,
            on_click = function(self, mouseButton, down)
            	RSExplorerFrame:Show()
            end,
        },
        {
            text = NO,
            on_click = function(self, mouseButton, down)
            	LibDialog:Dismiss(RSConstants.EXPLORER_SCAN_NOT_DONE)
            end,
        },
    },          
})

---============================================================================
-- TargetUnit tracker warning
---============================================================================

LibDialog:Register(RSConstants.TARGET_UNIT_WARNING, {
	text = AL["TARGET_UNIT_WARNING"],
	no_close_button = true,
    buttons = {
        {
            text = YES,
            on_click = function(self, mouseButton, down)
            	RSConfigDB.SetScanningTargetUnit(true)
            	LibStub("AceConfigRegistry-3.0"):NotifyChange("RareScanner General")
            end,
        },
        {
            text = NO,
            on_click = function(self, mouseButton, down)
            	RSConfigDB.SetScanningTargetUnit(false)
            	LibDialog:Dismiss(RSConstants.TARGET_UNIT_WARNING)
            end,
        },
    },          
})


---============================================================================
-- Explorer custom loot messages
---============================================================================

LibDialog:Register(RSConstants.ITEM_LIST_VALIDATION_ERROR, {
	text = AL["EXPLORER_CUSTOM_ITEMS_LIST_VALIDATION"],
	no_close_button = false,
	no_cancel_on_escape = true
})

LibDialog:Register(RSConstants.ITEM_LIST_WRONG_IDS_ERROR, {
	text = AL["EXPLORER_CUSTOM_ITEMS_WRONG_IDS_VALIDATION"],
	no_close_button = false,
	no_cancel_on_escape = true
})

LibDialog:Register(RSConstants.DELETE_GROUP_CONFIRMATION, {
	text = AL["EXPLORER_CUSTOM_ITEMS_DELETE_GROUP_CONFIRMATION"],
	no_close_button = true,
    buttons = {
        {
            text = YES,
            on_click = function(self, mouseButton, down)
            	local callback = self.data.callback
        		callback()
            end,
        },
        {
            text = NO,
            on_click = function(self, mouseButton, down)
            	LibDialog:Dismiss(RSConstants.DELETE_GROUP_CONFIRMATION)
            end,
        },
    },          
})