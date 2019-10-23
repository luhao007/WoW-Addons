-- local MODULES_ORDER = nil

local CURRENT_LIST = nil

local function GetModuleName(MODULE)
    return MODULE.Header.Text:GetText()
end

local function GetPreviousModule(MODULE)
    local previous = nil
    for i,v in ipairs(ObjectiveTrackerFrame.MODULES) do
        if v == MODULE then
            return previous
        end
        
        previous = v
    end
    
    return nil
end

local function GetModuleIndex(MODULE)
    for i,v in ipairs(ObjectiveTrackerFrame.MODULES) do
        if v == MODULE then
            return i
        end
    end
    
    return nil
end

local function AddModuleInfo(MODULE)
    if MODULE.BtWObjectiveFilter ~= nil then
        return
    end
    
    MODULE.BtWObjectiveFilter = {
        ["previous"] = GetPreviousModule(MODULE),
        ["visible"] = true
    }
end

local blizzard_ObjectiveTracker_ReorderModules = ObjectiveTracker_ReorderModules
local function AnchorBlock(block, anchorBlock, checkFit)
	local module = block.module;
	local blocksFrame = module.BlocksFrame;
	local offsetY = module.blockOffsetY;
	block:ClearAllPoints();
	if ( anchorBlock ) then
		if ( anchorBlock.isHeader ) then
			offsetY = module.fromHeaderOffsetY;
		end
		-- check if the block can fit
		if ( checkFit and (blocksFrame.contentsHeight + block.height - offsetY > blocksFrame.maxHeight) ) then
			return;
		end
		if ( block.isHeader ) then
			offsetY = offsetY + anchorBlock.module.fromModuleOffsetY;
			block:SetPoint("LEFT", OBJECTIVE_TRACKER_HEADER_OFFSET_X, 0);
		else
			block:SetPoint("LEFT", module.blockOffsetX, 0);
		end
		block:SetPoint("TOP", anchorBlock, "BOTTOM", 0, offsetY);
	else
		offsetY = 0;
		-- check if the block can fit
		if ( checkFit and (blocksFrame.contentsHeight + block.height > blocksFrame.maxHeight) ) then
			return;
		end
		-- if the blocks frame is a scrollframe, attach to its scrollchild
		if ( block.isHeader ) then
			block:SetPoint("TOPLEFT", blocksFrame.ScrollContents or blocksFrame, "TOPLEFT", OBJECTIVE_TRACKER_HEADER_OFFSET_X, offsetY);
		else
			block:SetPoint("TOPLEFT", blocksFrame.ScrollContents or blocksFrame, "TOPLEFT", module.blockOffsetX, offsetY);
		end
	end
	return offsetY;
end

function ObjectiveTracker_ReorderModules()
    local modules = ObjectiveTrackerFrame.MODULES;
    local modulesUIOrder = ObjectiveTrackerFrame.MODULES_UI_ORDER;
    local detachIndex = nil;
    local anchorBlock = nil;
    
    for i = 1, #modulesUIOrder do
        AddModuleInfo(modulesUIOrder[i])
        
        if modulesUIOrder[i].BtWObjectiveFilter.visible and modulesUIOrder[i].topBlock and modulesUIOrder[i].topBlock:IsVisible() then
            if modulesUIOrder[i] == SCENARIO_CONTENT_TRACKER_MODULE then
                AnchorBlock(SCENARIO_CONTENT_TRACKER_MODULE.topBlock, anchorBlock);
                anchorBlock = ScenarioBlocksFrame;
            elseif modulesUIOrder[i] == AUTO_QUEST_POPUP_TRACKER_MODULE then -- Why is this really needed??
                AnchorBlock(AUTO_QUEST_POPUP_TRACKER_MODULE.Header, anchorBlock);
                AnchorBlock(AUTO_QUEST_POPUP_TRACKER_MODULE.firstBlock, AUTO_QUEST_POPUP_TRACKER_MODULE.Header);
                anchorBlock = modulesUIOrder[i].lastBlock;
            else
                AnchorBlock(modulesUIOrder[i].topBlock, anchorBlock);
                anchorBlock = modulesUIOrder[i].lastBlock;
            end
        end
    end
end

function BtWObjectiveFilter_ModuleIsVisible(index)
    local MODULE = ObjectiveTrackerFrame.MODULES_UI_ORDER[index]
    
    AddModuleInfo(MODULE)
    
    return MODULE.BtWObjectiveFilter.visible ~= false
end

function BtWObjectiveFilter_ModuleShow(index, set)
    local MAINMODULE = ObjectiveTrackerFrame.MODULES_UI_ORDER[index]
    for i = 2, #ObjectiveTrackerFrame.MODULES_UI_ORDER do
        local MODULE = ObjectiveTrackerFrame.MODULES_UI_ORDER[i]
        
        if MODULE.Header == MAINMODULE.Header then
            AddModuleInfo(MODULE)
            
            MODULE.BtWObjectiveFilter.visible = true
            if set ~= false then
                CURRENT_LIST[i] = true
            end
            
            table.insert(ObjectiveTrackerFrame.MODULES, MODULE)
        end
    end
    
    ObjectiveTracker_ReorderModules();
    
    ObjectiveTracker_Update()
end

function BtWObjectiveFilter_ModuleHide(index, set)
    local MAINMODULE = ObjectiveTrackerFrame.MODULES_UI_ORDER[index]

    MAINMODULE.Header.added = false

    ObjectiveTrackerFrame.BlocksFrame.currentBlock = nil;
    ObjectiveTrackerFrame.BlocksFrame.contentsHeight = 0;
    
    for i = 2, #ObjectiveTrackerFrame.MODULES_UI_ORDER do
        local MODULE = ObjectiveTrackerFrame.MODULES_UI_ORDER[i]
        
        if MODULE.Header == MAINMODULE.Header then
            AddModuleInfo(MODULE)
            
            MODULE.BtWObjectiveFilter.visible = false
            if set ~= false then
                CURRENT_LIST[i] = false
            end

            if MODULE == SCENARIO_CONTENT_TRACKER_MODULE then
                ScenarioBlocksFrame_Hide();
            else
                MODULE:BeginLayout();
                MODULE:EndLayout();
            end
            
            table.remove(ObjectiveTrackerFrame.MODULES, GetModuleIndex(MODULE));
        end
    end
    
    ObjectiveTracker_CheckAndHideHeader(MAINMODULE.Header);
    
    ObjectiveTracker_ReorderModules();
end

function BtWObjectiveFilter_ModuleToggle(index)
    if BtWObjectiveFilter_ModuleIsVisible(index) then
        return BtWObjectiveFilter_ModuleHide(index)
    else
        return BtWObjectiveFilter_ModuleShow(index)
    end
end


function BtWObjectiveFilterButton_OnClick(self)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    ToggleDropDownMenu(1, nil, BtWObjectiveFilterDropDown, "BtWObjectiveFilterButton", 0, 0);
end

function BtWObjectiveFilterDropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, BtWObjectiveFilterDropDown_Initialize, "MENU");
end

function BtWObjectiveFilterDropDown_Initialize(self, level)
    local info = UIDropDownMenu_CreateInfo();
    info.keepShownOnClick = true;
    
    if ObjectiveTrackerFrame.MODULES_UI_ORDER ~= nil then
        for i = 2, #ObjectiveTrackerFrame.MODULES_UI_ORDER do
            if ObjectiveTrackerFrame.MODULES_UI_ORDER[i].Header then
                ObjectiveTrackerFrame.MODULES_UI_ORDER[i].Header.breenAdded = false
            end
        end
        
        for i = 2, #ObjectiveTrackerFrame.MODULES_UI_ORDER do
            local MODULE = ObjectiveTrackerFrame.MODULES_UI_ORDER[i]
            
            if MODULE.Header and not MODULE.Header.breenAdded then
                AddModuleInfo(MODULE)
        
                info.text = GetModuleName(MODULE)
                info.func = function(_, index)
                                BtWObjectiveFilter_ModuleToggle(index)
                            end
                info.arg1 = i
                info.checked = MODULE.BtWObjectiveFilter.visible;
                info.isNotRadio = true;
                UIDropDownMenu_AddButton(info, level)
            
                MODULE.Header.breenAdded = true
            end
        end
        
        info = UIDropDownMenu_CreateInfo();
        info.text = BtWObjectiveFilter_GetCurrentListTitle()
        info.isTitle = true
        UIDropDownMenu_AddButton(info, level)
    end
end

function BtWObjectiveFilter_ToggleFromList(list)
    for i = 2, #ObjectiveTrackerFrame.MODULES_UI_ORDER do
        local isVisible = BtWObjectiveFilter_ModuleIsVisible(i)
        local toVisible = CURRENT_LIST[i] ~= false
        
        if not toVisible and isVisible then
            BtWObjectiveFilter_ModuleHide(i, false)
        elseif toVisible and not isVisible then
            BtWObjectiveFilter_ModuleShow(i, false)
        end
    end
end

function BtWObjectiveFilter_GetCurrentList()
    for name,list in pairs(BtWObjectiveFilter_filter) do
        if list == CURRENT_LIST then
            return name
        end
    end
end

function BtWObjectiveFilter_GetCurrentListTitle()
    local name = BtWObjectiveFilter_GetCurrentList()
    if name == "defaults" then
        return "Default"
    elseif name == "resting" then
        return "Rested Area"
    elseif name == "scenario" then
        return "Scenario"
    elseif name == "raid" then
        return "Raid"
    elseif name == "dungeon" then
        return "Dungeon"
    elseif name == "mythic_plus" then
        return "Mythic Plus"
    elseif name == "bg" then
        return "Battleground"
    elseif name == "arena" then
        return "Arena"
    end
end

function BtWObjectiveFilter_IsCurrentList(name)
    return BtWObjectiveFilter_filter[name] == CURRENT_LIST
end

function BtWObjectiveFilter_SelectList(name)
    if BtWObjectiveFilter_filter[name] ~= nil and BtWObjectiveFilter_filter[name] ~= CURRENT_LIST then
        CURRENT_LIST = BtWObjectiveFilter_filter[name]
    
        BtWObjectiveFilter_ToggleFromList(BtWObjectiveFilter_filter[name])
    end
end

function BtWObjectiveFilter_UpdateList()
    local _, type, difficulty = GetInstanceInfo()
    
    if IsResting() then
        BtWObjectiveFilter_SelectList("resting")
    elseif type == "arena" then -- Arena
        BtWObjectiveFilter_SelectList("arena")
    elseif type == "pvp" then -- Battleground
        BtWObjectiveFilter_SelectList("bg")
    elseif type == "party" and difficulty == 8 then -- M+
        BtWObjectiveFilter_SelectList("mythic_plus")
    elseif type == "party" then -- Dungeon
        BtWObjectiveFilter_SelectList("dungeon")
    elseif type == "raid" then -- Raid
        BtWObjectiveFilter_SelectList("raid")
    elseif type == "scenario" then -- Scenario
        BtWObjectiveFilter_SelectList("scenario")
    else
        BtWObjectiveFilter_SelectList("defaults")
    end
end

function BtWObjectiveFilter_Initialize(self)
    self.initialized = true
    
    if BtWObjectiveFilter_filter == nil then
        BtWObjectiveFilter_filter = {
            ["defaults"] = {true},
            ["resting"] = {true},
            ["scenario"] = {true},
            ["raid"] = {true},
            ["dungeon"] = {true},
            ["mythic_plus"] = {true},
            ["bg"] = {true},
            ["arena"] = {true}
        }
    end
    
    if BtWObjectiveFilter_filter["bg"] == nil then
        BtWObjectiveFilter_filter["bg"] = {true}
    end
    
    if BtWObjectiveFilter_filter["arena"] == nil then
        BtWObjectiveFilter_filter["arena"] = {true}
    end
    
    if BtWObjectiveFilter_filter["mythic_plus"] == nil then
        BtWObjectiveFilter_filter["mythic_plus"] = {true}
    end
    
    if BtWObjectiveFilter_filter["dungeon"] == nil then
        BtWObjectiveFilter_filter["dungeon"] = {true}
    end
    
    if BtWObjectiveFilter_filter["raid"] == nil then
        BtWObjectiveFilter_filter["raid"] = {true}
    end
    
    if BtWObjectiveFilter_filter["scenario"] == nil then
        BtWObjectiveFilter_filter["scenario"] = {true}
    end
    
    if BtWObjectiveFilter_filter["resting"] == nil then
        BtWObjectiveFilter_filter["resting"] = {true}
    end
    
    if BtWObjectiveFilter_filter["defaults"] == nil then
        BtWObjectiveFilter_filter["defaults"] = {true}
    end
end

----- [[ EVENT HANDLER ]]

local frame = CreateFrame("Frame", nil)
local function eventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        if not self.initialized then
            BtWObjectiveFilter_Initialize(self);
        end
    
        BtWObjectiveFilter_UpdateList()
    elseif event == "SCENARIO_UPDATE" or event == "ZONE_CHANGED" then
        if self.initialized then
            BtWObjectiveFilter_UpdateList()
        end
    end
end
frame:SetScript("OnEvent", eventHandler);
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("SCENARIO_UPDATE");
frame:RegisterEvent("ZONE_CHANGED");
frame:Hide()