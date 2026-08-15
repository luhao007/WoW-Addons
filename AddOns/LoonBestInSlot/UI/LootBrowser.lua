LBIS.BrowserWindow = {
    MaxHeight = 0,
    CompareTooltip = {},
    LastFeaturesOpenTime = time({year=2022, month=12, day=10, hour=22})
}

-- Custom tab system for Midnight (CharacterFrameTabButtonTemplate removed)
local LBIS_TABS = {}
local LBIS_ACTIVE_TAB = nil

local function SetActiveTab(tabIndex)
    LBIS_ACTIVE_TAB = tabIndex
    for i, tab in ipairs(LBIS_TABS) do
        if i == tabIndex then
            tab:SetNormalFontObject("GameFontHighlight")
            tab.bg:SetColorTexture(0.15, 0.15, 0.35, 1)
            tab.topBorder:Show()
        else
            tab:SetNormalFontObject("GameFontNormalSmall")
            tab.bg:SetColorTexture(0.08, 0.08, 0.16, 0.9)
            tab.topBorder:Hide()
        end
    end
end

function LBIS.BrowserWindow:OpenWindow(tabName)
    LBIS:BuildItemCache()
    if not LBIS.BrowserWindow.Window then
        LBIS.BrowserWindow:CreateBrowserWindow();
    end
    if tabName ~= nil then
        LBISSettings.OpenTab = tabName;
    end
    LBIS.BrowserWindow:RefreshItems();
    LBIS.BrowserWindow.Window:Show();
end

function LBIS.BrowserWindow:ToggleWindow()
    if LBIS.BrowserWindow.Window and LBIS.BrowserWindow.Window:IsShown() then
        LBIS.BrowserWindow.Window:Hide();
    else
        LBIS.BrowserWindow:OpenWindow();
    end
end

local customListTabButton;
local customEditTabButton;
local LBIS_USE_PANEL_TABS = false  -- Set by createTabs if PanelTabButtonTemplate works

local function SwitchToTab(tabIndex)
    if LBIS_USE_PANEL_TABS and LBIS.BrowserWindow.Window and LBIS.BrowserWindow.Window.Container then
        pcall(PanelTemplates_SetTab, LBIS.BrowserWindow.Window.Container, tabIndex)
    else
        SetActiveTab(tabIndex)
    end
end

function LBIS.BrowserWindow:RefreshItems()    

    if LBISSettings.ShowCustom and customListTabButton then
        customListTabButton:Show()
        customEditTabButton:Show()
    elseif customListTabButton then
        customListTabButton:Hide()
        customEditTabButton:Hide()
    end

    if LBISSettings.OpenTab == "ItemList" then
        SwitchToTab(1);
        LBIS.ItemList:UpdateItems();
    elseif LBISSettings.OpenTab == "GemList" then
        SwitchToTab(2);
        LBIS.GemList:UpdateItems();
    elseif LBISSettings.OpenTab == "EnchantList" then
        SwitchToTab(3);
        LBIS.EnchantList:UpdateItems();
    elseif LBISSettings.OpenTab == "EmbellishmentList" then
        SwitchToTab(4);
        LBIS.EmbellishmentList:UpdateItems();
    elseif LBISSettings.OpenTab == "CustomItemList" then
        SwitchToTab(5);
        LBIS.CustomItemList:UpdateItems();
    elseif LBISSettings.OpenTab == "CustomEditList" then
        SwitchToTab(6);
        LBIS.CustomEditList:UpdateItems();
    end
end

local failedLoad = false;
local window_cache = {};

function LBIS:InitializeUI()
    for specId, spec in pairs(LBIS.ClassSpec) do
        if strlen(spec.Spec) > 0 then
            window_cache[spec.Class..": "..spec.Spec] = {};
        end
    end
end

function LBIS.BrowserWindow:CreateItemRow(specItem, specItemSource, frameName, point, rowFunc)
    local window = LBIS.BrowserWindow.Window;
    local spacing = 1;
    local reusing = false;

    local f = nil;
    if(next(window_cache[LBISSettings.SelectedSpec]) ~= nil) then
		for i=1, #window_cache[LBISSettings.SelectedSpec] do			
            if(frameName == window_cache[LBISSettings.SelectedSpec][i]:GetName()) then
                f = window_cache[LBISSettings.SelectedSpec][i];
                reusing = true;
				break;
            end
        end
    end

    if not reusing then        
        f = CreateFrame("Frame", frameName, window.Container);

        local rowHeight = rowFunc(f, specItem, specItemSource);
        
        local l = f:CreateLine();
        l:SetColorTexture(1,1,1,0.5);
        l:SetThickness(1);
        l:SetStartPoint("BOTTOMLEFT",5, 0);
        l:SetEndPoint("BOTTOMRIGHT",-5, 0);
        f:SetSize(window.ScrollFrame:GetWidth(), rowHeight);

        tinsert(window_cache[LBISSettings.SelectedSpec], f);
    end

    f:ClearAllPoints();
    f:SetPoint("TOPLEFT", window.Container, 0, point);
    
    point = point - (f:GetHeight()+spacing);
    
    LBIS.BrowserWindow.MaxHeight = LBIS.BrowserWindow.MaxHeight + (f:GetHeight()+spacing);

    f:Show(); -- forcing a show since if we are reusing, the old child was previously hidden

    return point;
end

function LBIS.BrowserWindow:UpdateItemsForSpec(rowFunc)
            
    if LBISSettings.SelectedSpec == "" then
        return;
    end
    
    LBIS.SearchFrame:HideSearchFrame();
    LBIS.BrowserWindow.Window.HideUnavailable();

    local window = LBIS.BrowserWindow.Window;
    local point = -2;
    local function clear_content(self)
        for i=1, self:GetNumChildren() do
        
            local child = select(i, self:GetChildren());
                        
            child:Hide();
        end
    end
    clear_content(window.Container);
    
    LBIS.BrowserWindow.MaxHeight = 0;
    
    local topl = window.Container:CreateLine();
    topl:SetColorTexture(1,1,1,0.5);
    topl:SetThickness(1);
    topl:SetStartPoint("TOPLEFT",5, 0);
    topl:SetEndPoint("TOPRIGHT",-5, 0);
    
    failedLoad = false;

    --LBIS:MeasureCode("UpdateItemsForSpec", function ()
        rowFunc(point);
    --end);


    if failedLoad then
        LBIS:Error("Failed to load one or more items into browser. Type /reload to attempt to fix", "");
    end

    window.Container:SetSize(window.ScrollFrame:GetWidth(), window.ScrollFrame:GetHeight());

    if LBIS.BrowserWindow.MaxHeight-window.ScrollFrame:GetHeight() > 0 then
        window.ScrollBar:SetMinMaxValues(0, (LBIS.BrowserWindow.MaxHeight-window.ScrollFrame:GetHeight()));
        window.ScrollBar:Enable();
    else
        window.ScrollBar:SetMinMaxValues(0, 0);
        window.ScrollBar:Disable();
    end
    window.ScrollFrame:SetScrollChild(window.Container);
end

local function createTabs(window, content)

    LBIS_TABS = {}

    -- Try retail tab template
    local tabTemplate = nil
    for _, tmpl in ipairs({"PanelTabButtonTemplate", "CharacterFrameTabButtonTemplate", "TabButtonTemplate"}) do
        local ok = pcall(function()
            local test = CreateFrame("Button", "LBISTabTest", UIParent, tmpl)
            test:Hide()
            test:SetParent(nil)
        end)
        if ok then
            tabTemplate = tmpl
            break
        end
    end

    local function makeTab(name, parent, text, anchorTo, tabIndex)
        local btn
        if tabTemplate then
            -- Use Blizzard retail tab template
            btn = CreateFrame("Button", name, parent, tabTemplate)
            btn:SetID(tabIndex)
            btn:SetText(text)
            if btn.Text then
                btn.Text:SetText(text)
            end
            -- Size from text
            local textWidth = btn:GetFontString() and btn:GetFontString():GetStringWidth() or 50
            btn:SetSize(math.max(textWidth + 40, 80), 32)
        else
            -- Fallback: custom styled tabs
            btn = CreateFrame("Button", name, parent)
            btn:SetSize(80, 28)

            local bg = btn:CreateTexture(nil, "BACKGROUND")
            bg:SetPoint("TOPLEFT", 1, -1)
            bg:SetPoint("BOTTOMRIGHT", -1, 0)
            bg:SetColorTexture(0.08, 0.08, 0.16, 0.9)
            btn.bg = bg

            local topBorder = btn:CreateTexture(nil, "ARTWORK")
            topBorder:SetPoint("TOPLEFT", 0, 0)
            topBorder:SetPoint("TOPRIGHT", 0, 0)
            topBorder:SetHeight(2)
            topBorder:SetColorTexture(0.9, 0.8, 0.2, 1)
            topBorder:Hide()
            btn.topBorder = topBorder

            btn:SetNormalFontObject("GameFontNormalSmall")
            btn:SetHighlightFontObject("GameFontHighlight")
            btn:SetText(text)

            local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
            highlight:SetAllPoints(bg)
            highlight:SetColorTexture(0.3, 0.3, 0.5, 0.3)
        end

        -- Position
        if anchorTo then
            btn:SetPoint("LEFT", anchorTo, "RIGHT", tabTemplate and -16 or 2, 0)
        else
            btn:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", tabTemplate and 11 or 10, tabTemplate and -30 or -26)
        end

        table.insert(LBIS_TABS, btn)
        return btn
    end

    local function tabClick(tabIndex, tabName)
        return function(self)
            PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
            LBISSettings.OpenTab = tabName
            LBIS.BrowserWindow:RefreshItems()
        end
    end

    local itemListTabButton = makeTab("ContainerTab1", window, LBIS.L["Items"], nil, 1)
    itemListTabButton:SetScript("OnClick", tabClick(1, "ItemList"))

    local gemListTabButton = makeTab("ContainerTab2", window, LBIS.L["Gems"], itemListTabButton, 2)
    gemListTabButton:SetScript("OnClick", tabClick(2, "GemList"))

    local enchantListTabButton = makeTab("ContainerTab3", window, LBIS.L["Enchants"], gemListTabButton, 3)
    enchantListTabButton:SetScript("OnClick", tabClick(3, "EnchantList"))

    local embListTabButton = makeTab("ContainerTab4", window, "Embellish", enchantListTabButton, 4)
    embListTabButton:SetScript("OnClick", tabClick(4, "EmbellishmentList"))

    customListTabButton = makeTab("ContainerTab5", window, LBIS.L["Custom"], embListTabButton, 5)
    customListTabButton:SetScript("OnClick", tabClick(5, "CustomItemList"))

    customEditTabButton = makeTab("ContainerTab6", window, LBIS.L["Edit"], customListTabButton, 6)
    customEditTabButton:SetScript("OnClick", tabClick(6, "CustomEditList"))

    if tabTemplate then
        PanelTemplates_SetNumTabs(content, 6)
        PanelTemplates_SetTab(content, 1)
        LBIS_USE_PANEL_TABS = true
    else
        SetActiveTab(1)
    end
end

local function createDropDowns(window)
    -- Build class -> specs mapping
    local classesList = {}
    local classSpecs = {}
    for specId, spec in pairs(LBIS.ClassSpec) do
        local className = spec.Class
        if not classSpecs[className] then
            classSpecs[className] = {}
            table.insert(classesList, className)
        end
        local specString = className
        if strlen(spec.Spec) > 0 then
            specString = className..": "..spec.Spec
        end
        table.insert(classSpecs[className], { label = specString, specName = spec.Spec, specIDNumeric = spec.SpecID })
        LBIS.NameToSpecId[specString] = specId
    end
    table.sort(classesList)
    for _, cls in ipairs(classesList) do
        table.sort(classSpecs[cls], function(a,b) return a.label < b.label end)
    end

    -- Build track groups
    local trackGroups = {}
    local groupOrder = {}
    for _, track in ipairs(LBIS.UpgradeTracks) do
        if not trackGroups[track.group] then
            trackGroups[track.group] = {}
            table.insert(groupOrder, track.group)
        end
        table.insert(trackGroups[track.group], track)
    end

    local defaultTrackText = "|cffff8000289|r (Max)"
    for _, track in ipairs(LBIS.UpgradeTracks) do
        if track.bonusId == (LBIS.SelectedTrackBonusId or 12806) then
            defaultTrackText = track.label
            break
        end
    end

    if LBIS_HAS_RETAIL_DROPDOWN then
        -- ============ RETAIL DROPDOWNS ============

        -- Spec dropdown (hierarchical: Class > Spec)
        local CLASS_COLORS_RETAIL = {
            -- Keys: English class names normalized via LBIS.ENGLISH_CLASS (no spaces).
            ["DeathKnight"] = "ffc41e3a", ["DemonHunter"] = "ffa330c9",
            ["Druid"] = "ffff7c0a", ["Evoker"] = "ff33937f",
            ["Hunter"] = "ffaad372", ["Mage"] = "ff3fc7eb",
            ["Monk"] = "ff00ff98", ["Paladin"] = "fff48cba",
            ["Priest"] = "ffffffff", ["Rogue"] = "fffff468",
            ["Shaman"] = "ff0070dd", ["Warlock"] = "ff8788ee",
            ["Warrior"] = "ffc69b6d",
        }
        local specDropdown = CreateFrame("DropdownButton", "LBIS_SpecDropdown", window, "WowStyle1DropdownTemplate")
        specDropdown:SetSelectionText(function() return LBISSettings.SelectedSpec or "" end)
        specDropdown:SetupMenu(function(dd, rootDescription)
            for _, className in ipairs(classesList) do
                -- resolve the English class name so colors work on any locale
                local englishKey = (LBIS.ENGLISH_CLASS and LBIS.ENGLISH_CLASS[className]) or className
                local hexColor = CLASS_COLORS_RETAIL[englishKey] or "ffffffff"
                local coloredName = "|c" .. hexColor .. className .. "|r"
                local classMenu = rootDescription:CreateButton(coloredName)
                for _, spec in ipairs(classSpecs[className]) do
                    classMenu:CreateRadio(
                        spec.specName ~= "" and spec.specName or "All",
                        function() return LBISSettings.SelectedSpec == spec.label end,
                        function()
                            LBISSettings.SelectedSpec = spec.label
                            LBISSettings.SelectedSpecID = spec.specIDNumeric
                            LBIS.BrowserWindow:RefreshItems()
                        end
                    )
                end
            end
        end)
        specDropdown:SetWidth(180)
        local specTitle = specDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        specTitle:SetText('Spec:')
        specTitle:SetPoint("RIGHT", specDropdown, "LEFT", -2, 0)
        window.SpecDropDown = specDropdown
        window.SpecDropDown:SetPoint("TOPLEFT", window, 55, -30)

        -- Slot dropdown
        local slotItems = { LBIS.L["All"], LBIS.L["Head"], LBIS.L["Shoulder"], LBIS.L["Back"], LBIS.L["Chest"], LBIS.L["Wrist"],
            LBIS.L["Hands"], LBIS.L["Waist"], LBIS.L["Legs"], LBIS.L["Feet"], LBIS.L["Neck"], LBIS.L["Ring"], LBIS.L["Trinket"],
            LBIS.L["Main Hand"], LBIS.L["Off Hand"], LBIS.L["Ranged/Relic"] }
        local slotDropdown = CreateFrame("DropdownButton", "LBIS_SlotDropdown", window, "WowStyle1DropdownTemplate")
        slotDropdown:SetSelectionText(function() return LBISSettings.SelectedSlot or LBIS.L["All"] end)
        slotDropdown:SetupMenu(function(dd, rootDescription)
            for _, val in ipairs(slotItems) do
                rootDescription:CreateRadio(val,
                    function() return LBISSettings.SelectedSlot == val end,
                    function() LBISSettings.SelectedSlot = val; LBIS.BrowserWindow:RefreshItems() end
                )
            end
        end)
        slotDropdown:SetWidth(130)
        local slotTitle = slotDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        slotTitle:SetText('Slot:')
        slotTitle:SetPoint("RIGHT", slotDropdown, "LEFT", -2, 0)
        window.SlotDropDown = slotDropdown
        window.SlotDropDown:SetPoint("LEFT", window.SpecDropDown, "RIGHT", 30, 0)

        -- ilvl / Track dropdown (hierarchical: Champion > / Hero > / Great Vault >)
        local trackDropdown = CreateFrame("DropdownButton", "LBIS_TrackDropdown", window, "WowStyle1DropdownTemplate")
        trackDropdown:SetSelectionText(function() return LBISSettings.SelectedTrack or defaultTrackText end)
        trackDropdown:SetupMenu(function(dd, rootDescription)
            for _, groupName in ipairs(groupOrder) do
                local groupMenu = rootDescription:CreateButton(groupName)
                for _, track in ipairs(trackGroups[groupName]) do
                    groupMenu:CreateRadio(track.label,
                        function() return LBIS.SelectedTrackBonusId == track.bonusId end,
                        function()
                            LBIS.SelectedTrackBonusId = track.bonusId
                            LBISSettings.SelectedTrack = track.label
                            if LBISServerSettings then LBISServerSettings.ItemCache = {} end
                            LBIS.BrowserWindow:RefreshItems()
                        end
                    )
                end
            end
        end)
        trackDropdown:SetWidth(150)
        local trackTitle = trackDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        trackTitle:SetText('ilvl:')
        trackTitle:SetPoint("RIGHT", trackDropdown, "LEFT", -2, 0)
        window.PhaseDropDown = trackDropdown
        window.PhaseDropDown:SetPoint("LEFT", window.SlotDropDown, "RIGHT", 30, 0)

        -- Source dropdown
        local sourceItems = { LBIS.L["All"], LBIS.L["Drop"], LBIS.L["Raid"], LBIS.L["Crafted"] }
        local sourceDropdown = CreateFrame("DropdownButton", "LBIS_SourceDropdown", window, "WowStyle1DropdownTemplate")
        sourceDropdown:SetSelectionText(function() return LBISSettings.SelectedSourceType or LBIS.L["All"] end)
        sourceDropdown:SetupMenu(function(dd, rootDescription)
            for _, val in ipairs(sourceItems) do
                rootDescription:CreateRadio(val,
                    function() return LBISSettings.SelectedSourceType == val end,
                    function() LBISSettings.SelectedSourceType = val; LBIS.BrowserWindow:RefreshItems() end
                )
            end
        end)
        sourceDropdown:SetWidth(100)
        local srcTitle = sourceDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        srcTitle:SetText('Source:')
        srcTitle:SetPoint("RIGHT", sourceDropdown, "LEFT", -2, 0)
        window.SourceDropDown = sourceDropdown
        window.SourceDropDown:SetPoint("LEFT", window.PhaseDropDown, "RIGHT", 40, 0)

        -- Zone dropdown
        local zoneItems = { LBIS.L["All"], "Skyreach", "Pit of Saron", "Seat of the Triumvirate",
            "Algeth'ar Academy", "Windrunner Spire", "Magisters' Terrace", "Nexus-Point Xenas",
            "Maisara Caverns", "The Voidspire", "The Dreamrift", "March on Quel'Danas" }
        local zoneDropdown = CreateFrame("DropdownButton", "LBIS_ZoneDropdown", window, "WowStyle1DropdownTemplate")
        zoneDropdown:SetSelectionText(function() return LBISSettings.SelectedZone or LBIS.L["All"] end)
        zoneDropdown:SetupMenu(function(dd, rootDescription)
            for _, val in ipairs(zoneItems) do
                rootDescription:CreateRadio(val,
                    function() return LBISSettings.SelectedZone == val end,
                    function() LBISSettings.SelectedZone = val; LBIS.BrowserWindow:RefreshItems() end
                )
            end
        end)
        zoneDropdown:SetWidth(130)
        local zoneTitle = zoneDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        zoneTitle:SetText('Zone:')
        zoneTitle:SetPoint("RIGHT", zoneDropdown, "LEFT", -2, 0)
        window.RaidDropDown = zoneDropdown
        window.RaidDropDown:SetPoint("LEFT", window.SourceDropDown, "RIGHT", 40, 0)

        -- Hidden rank dropdown (needed by some code paths)
        local rankDropdown = CreateFrame("Frame", nil, window)
        rankDropdown:SetSize(1,1)
        rankDropdown.Show = function() end
        rankDropdown.Hide = function() end
        window.RankDropDown = rankDropdown

    else
        -- ============ CLASSIC LIBDD FALLBACK ============
        local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

        -- Spec dropdown (hierarchical)
        local CLASS_COLORS = {
            -- Keys: English class names normalized via LBIS.ENGLISH_CLASS (no spaces).
            ["DeathKnight"] = "|cffc41e3a", ["DemonHunter"] = "|cffa330c9",
            ["Druid"] = "|cffff7c0a", ["Evoker"] = "|cff33937f",
            ["Hunter"] = "|cffaad372", ["Mage"] = "|cff3fc7eb",
            ["Monk"] = "|cff00ff98", ["Paladin"] = "|cfff48cba",
            ["Priest"] = "|cffffffff", ["Rogue"] = "|cfffff468",
            ["Shaman"] = "|cff0070dd", ["Warlock"] = "|cff8788ee",
            ["Warrior"] = "|cffc69b6d",
        }
        local specDropdown = LibDD:Create_UIDropDownMenu('$parent_spec_dropdown', window)
        LibDD:UIDropDownMenu_Initialize(specDropdown, function(self, level, menuList)
            if level == 1 then
                for _, className in ipairs(classesList) do
                    local info = LibDD:UIDropDownMenu_CreateInfo()
                    -- resolve the English class name so colors work on any locale
                    local englishKey = (LBIS.ENGLISH_CLASS and LBIS.ENGLISH_CLASS[className]) or className
                    local color = CLASS_COLORS[englishKey] or "|cffffffff"
                    info.text = color .. className .. "|r"
                    info.hasArrow = true
                    info.notCheckable = true
                    info.menuList = className
                    LibDD:UIDropDownMenu_AddButton(info, level)
                end
            elseif level == 2 then
                local specs = classSpecs[menuList]
                if specs then
                    for _, spec in ipairs(specs) do
                        local info = LibDD:UIDropDownMenu_CreateInfo()
                        info.text = spec.specName ~= "" and spec.specName or "All"
                        info.checked = (LBISSettings.SelectedSpec == spec.label)
                        info.isNotRadio = false
                        info.func = function()
                            LBISSettings.SelectedSpec = spec.label
                            LBISSettings.SelectedSpecID = spec.specIDNumeric
                            LibDD:UIDropDownMenu_SetText(specDropdown, spec.label)
                            LibDD:CloseDropDownMenus()
                            LBIS.BrowserWindow:RefreshItems()
                        end
                        LibDD:UIDropDownMenu_AddButton(info, level)
                    end
                end
            end
        end)
        LibDD:UIDropDownMenu_SetText(specDropdown, LBISSettings.SelectedSpec or "")
        LibDD:UIDropDownMenu_SetWidth(specDropdown, 140, 0)
        local dd_title = specDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        dd_title:SetText('Spec:')
        dd_title:SetPoint("TOPLEFT", (-1 * dd_title:GetStringWidth()) + 20, -8)
        window.SpecDropDown = specDropdown
        window.SpecDropDown:SetPoint("TOPLEFT", window, 15, -28)

        -- Slot dropdown
        local slot_opts = {
            ['name']='slot', ['parent']=window, ['title']='Slot:',
            ['items']= { LBIS.L["All"], LBIS.L["Head"], LBIS.L["Shoulder"], LBIS.L["Back"], LBIS.L["Chest"], LBIS.L["Wrist"],
                LBIS.L["Hands"], LBIS.L["Waist"], LBIS.L["Legs"], LBIS.L["Feet"], LBIS.L["Neck"], LBIS.L["Ring"], LBIS.L["Trinket"],
                LBIS.L["Main Hand"], LBIS.L["Off Hand"], LBIS.L["Ranged/Relic"] },
            ['defaultVal']=LBISSettings.SelectedSlot,
            ['changeFunc']=function(_, val) LBISSettings.SelectedSlot = val; LBIS.BrowserWindow:RefreshItems() end
        }
        window.SlotDropDown = LBIS:CreateDropdown(slot_opts, 90)
        window.SlotDropDown:SetPoint("TOPLEFT", window, 190, -28)

        -- Track dropdown (hierarchical)
        local trackDropdown = LibDD:Create_UIDropDownMenu('$parent_track_dropdown', window)
        LibDD:UIDropDownMenu_Initialize(trackDropdown, function(self, level, menuList)
            if level == 1 then
                for _, groupName in ipairs(groupOrder) do
                    local info = LibDD:UIDropDownMenu_CreateInfo()
                    info.text = groupName
                    info.hasArrow = true
                    info.notCheckable = true
                    info.menuList = groupName
                    LibDD:UIDropDownMenu_AddButton(info, level)
                end
            elseif level == 2 then
                local groupTracks = trackGroups[menuList]
                if groupTracks then
                    for _, track in ipairs(groupTracks) do
                        local info = LibDD:UIDropDownMenu_CreateInfo()
                        info.text = track.label
                        info.checked = (LBIS.SelectedTrackBonusId == track.bonusId)
                        info.isNotRadio = false
                        info.func = function()
                            LBIS.SelectedTrackBonusId = track.bonusId
                            LBISSettings.SelectedTrack = track.label
                            LibDD:UIDropDownMenu_SetText(trackDropdown, track.label)
                            if LBISServerSettings then LBISServerSettings.ItemCache = {} end
                            LibDD:CloseDropDownMenus()
                            LBIS.BrowserWindow:RefreshItems()
                        end
                        LibDD:UIDropDownMenu_AddButton(info, level)
                    end
                end
            end
        end)
        LibDD:UIDropDownMenu_SetText(trackDropdown, LBISSettings.SelectedTrack or defaultTrackText)
        LibDD:UIDropDownMenu_SetWidth(trackDropdown, 140, 0)
        local t_title = trackDropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        t_title:SetText('ilvl:')
        t_title:SetPoint("TOPLEFT", (-1 * t_title:GetStringWidth()) + 20, -8)
        window.PhaseDropDown = trackDropdown
        window.PhaseDropDown:SetPoint("TOPLEFT", window, 320, -28)

        -- Rank dropdown (hidden)
        local rank_opts = {
            ['name']='rank', ['parent']=window, ['title']='Rank:',
            ['items']= { LBIS.L["All"], "BIS" },
            ['defaultVal']=LBISSettings.SelectedRank,
            ['changeFunc']=function(_, val) LBISSettings.SelectedRank = val; LBIS.BrowserWindow:RefreshItems() end
        }
        window.RankDropDown = LBIS:CreateDropdown(rank_opts, 70)
        window.RankDropDown:SetPoint("TOPLEFT", window, 330, -28)

        -- Source dropdown
        local source_opts = {
            ['name']='source', ['parent']=window, ['title']='Source:',
            ['items']= { LBIS.L["All"], LBIS.L["Drop"], LBIS.L["Raid"], LBIS.L["Crafted"] },
            ['defaultVal']= LBISSettings.SelectedSourceType or LBIS.L["All"],
            ['changeFunc']=function(_, val) LBISSettings.SelectedSourceType = val; LBIS.BrowserWindow:RefreshItems() end
        }
        window.SourceDropDown = LBIS:CreateDropdown(source_opts, 80)
        window.SourceDropDown:SetPoint("TOPLEFT", window, 510, -28)

        -- Zone dropdown
        local zone_opts = {
            ['name']='zone', ['parent']=window, ['title']='Zone:',
            ['items']= { LBIS.L["All"], "Skyreach", "Pit of Saron", "Seat of the Triumvirate",
                "Algeth'ar Academy", "Windrunner Spire", "Magisters' Terrace", "Nexus-Point Xenas",
                "Maisara Caverns", "The Voidspire", "The Dreamrift", "March on Quel'Danas" },
            ['defaultVal']= LBISSettings.SelectedZone,
            ['changeFunc']=function(_, val) LBISSettings.SelectedZone = val; LBIS.BrowserWindow:RefreshItems() end
        }
        window.RaidDropDown = LBIS:CreateDropdown(zone_opts, 120)
        window.RaidDropDown:SetPoint("TOPLEFT", window, 640, -28)
    end

end

function LBIS.BrowserWindow:CreateBrowserWindow()
    local step = 25;
    local windowName = "LootBrowserWindow";

    -- Try retail portrait frame template, fallback to BackdropTemplate
    local window
    local usePortraitFrame = false
    local ok = pcall(function()
        window = CreateFrame("Frame", windowName, UIParent, "PortraitFrameTemplate")
        usePortraitFrame = true
    end)
    if not ok or not window then
        window = CreateFrame("Frame", windowName, UIParent, "BackdropTemplate")
        window:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = 1, tileSize = 10, edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })
        window:SetBackdropBorderColor(0.6, 0.6, 0.6)
        window:SetBackdropColor(0.05, 0.05, 0.12)
    end

    if usePortraitFrame then
        -- Retail portrait frame setup
        if window.SetPortraitToAsset then
            window:SetPortraitToAsset("Interface\\Icons\\INV_Chest_Plate16")
        end
        if window.SetTitle then
            window:SetTitle(LBIS.L["Loon Best In Slot Browser"])
        end
        -- PortraitFrameTemplate has its own CloseButton
    else
        -- Legacy close button
        local windowCloseButton = CreateFrame("Button", windowName.."CloseButton", window)
        windowCloseButton:SetPoint("TOPRIGHT", window, "TOPRIGHT", -2, -2)
        windowCloseButton:SetSize(24, 24)
        windowCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
        windowCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
        windowCloseButton:SetScript("OnClick", function(self)
            window:Hide()
        end)

        -- Title bar
        local header = window:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        header:SetPoint("TOP", window, "TOP", 0, -6)
        header:SetText(LBIS.L["Loon Best In Slot Browser"])
    end
    
    local scrollframe = CreateFrame("ScrollFrame", "ScrollFrame", window);
    local scrollbar = CreateFrame("Slider", "ScrollBar", scrollframe, "UIPanelScrollBarTemplate");
    local content = CreateFrame("Frame", "Container", scrollframe);
    
	tinsert(UISpecialFrames, windowName)	-- allow ESC close

    local function UpdateScrollValue(self, delta)
        if not scrollbar:IsEnabled() then
            return;
        end
        if(delta == 1 and scrollbar:GetValue() >= 0) then
            if(scrollbar:GetValue()-step < 0) then
                scrollbar:SetValue(0);
            else scrollbar:SetValue(scrollbar:GetValue() - step) end
        elseif(delta == -1 and scrollbar:GetValue() < LBIS.BrowserWindow.MaxHeight) then
            if(scrollbar:GetValue()+step > LBIS.BrowserWindow.MaxHeight) then
                scrollbar:SetValue(LBIS.BrowserWindow.MaxHeight);
            else scrollbar:SetValue(scrollbar:GetValue() + step) end
        end
    end

    --parent frame 
    window:SetSize(920, 600);
    window:SetPoint("CENTER", 0, 0);
    window:SetToplevel(true);
    window:SetMovable(true);
    window:EnableMouse(true);
    window:EnableMouseWheel(true);
    window:SetFrameStrata("HIGH");

    window:RegisterForDrag("LeftButton");

    -- Only create header if not using portrait frame (which has built-in title)
    if not usePortraitFrame then
        local header = window:CreateFontString(nil, nil, "GameFontHighlightMed2");
        header:SetText(LBIS.L["Loon Best In Slot Browser"]);
        header:SetPoint("TOP", window, -5, -5);
    end

    local topLine = window:CreateLine();
    topLine:SetColorTexture(1,1,1,0.3);
    topLine:SetThickness(1);
    topLine:SetStartPoint("TOPLEFT",10, -59);
    topLine:SetEndPoint("TOPRIGHT",-25, -59);

    scrollframe:SetPoint("TOPLEFT", 10, -60);
    scrollframe:SetPoint("BOTTOMRIGHT", -25, 10);
    
    scrollframe:EnableMouse(true);
    scrollframe:EnableMouseWheel(true);
    scrollframe:SetScript("OnMouseWheel", UpdateScrollValue);

    scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 4, -12);
    scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 4, 10);
    scrollbar:SetMinMaxValues(0,0);
    scrollbar:SetWidth(16);
    scrollbar:SetValue(0);
    scrollbar:SetValueStep(step);

    scrollbar:SetScript("OnValueChanged",
        function (self, value) 
            self:GetParent():SetVerticalScroll(value);
        end
    );

    window:SetScript("OnDragStart", function(self) self:StartMoving() end);
    window:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);

    createDropDowns(window);
    createTabs(window, content);

    local f = CreateFrame("Frame", nil, content);				
	f.t = f:CreateFontString(nil, nil, "GameFontNormal");
	f.t:SetText("Wowhead Guide not available");
	f.t:SetPoint("CENTER");				
	f:SetSize(scrollframe:GetWidth(), scrollframe:GetHeight());
	f:ClearAllPoints();
	f:SetPoint("TOPLEFT", content, 0, 0);
    f:Hide();

    local function showUnavailable(text)
        if text == nil then
            text = "Wowhead Guide not available";
        end
        f.t:SetText(text);
        f:Show();
    end

    LBIS.BrowserWindow.Window = window;
    LBIS.BrowserWindow.Window.ScrollFrame = scrollframe;
    LBIS.BrowserWindow.Window.ScrollBar = scrollbar;
    LBIS.BrowserWindow.Window.Container = content;
    LBIS.BrowserWindow.Window.ShowUnavailable = showUnavailable;
    LBIS.BrowserWindow.Window.HideUnavailable = function () f:Hide() end;

    LBIS.SearchFrame:CreateSearch();

    LBIS:RegisterTooltip();

end
