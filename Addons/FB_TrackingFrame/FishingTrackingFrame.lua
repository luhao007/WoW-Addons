-- Handle tracking cycle fish

FB_TFConstants = {};

-- set up
local FL = LibStub("LibFishing-1.0");
FL:Translate("FB_OutfitDisplayFrame", FB_TFTranslations, FB_TFConstants);

local FBAPI = LibStub("FishingBuddyApi-1.0");

-- Temporary, until we're pretty sure everyone has upgraded
local function RegisterHandlers(...)
    if (FBAPI) then
        return FBAPI:RegisterHandlers(...);
    else
        return FishingBuddy.API.RegisterHandlers(...);
    end
end

local TrackingOptions = {
    ["TrackHidden"] = {
        ["text"] = FB_TFConstants.CONFIG_TRACKHIDDEN_ONOFF,
        ["tooltip"] = FB_TFConstants.CONFIG_TRACKHIDDEN_INFO,
        ["v"] = 1,
        ["default"] = true },
        ["TrackThese"] = {
            ["setup"] =
            function(button)
                button:SetWidth(FishingBuddyFrameInset:GetWidth());
                button:SetHeight(FishingBuddyFrameInset:GetHeight()-32);
            end,
            ["margin"] = { 8, 0 },
            ["button"] = "FishingTrackingChooser", },
};

local NUM_THINGIES_DISPLAYED = 16;
local FRAME_THINGIEHEIGHT = 20;
FB_TFConstants.FRAME_THINGIEHEIGHT = FRAME_THINGIEHEIGHT;

local GH = LibStub("GraphHandler-1.0");

local byweeks = {
    FB_TFConstants.ABBREV_JANUARY,
    FB_TFConstants.ABBREV_APRIL,
    FB_TFConstants.ABBREV_JULY,
    FB_TFConstants.ABBREV_OCTOBER,
    FB_TFConstants.ABBREV_DECEMBER,
};

-- free up the space
FB_TFTranslations = nil;

--

FB_TrackingFrame = {};

local GetSettingBool = FishingBuddy.GetSettingBool;

local trackingWordMap = {
    ["WEEKLY"] = FBConstants.WEEKLY,
    ["HOURLY"] = FBConstants.HOURLY,
    [FBConstants.WEEKLY] = "WEEKLY",
    [FBConstants.HOURLY] = "HOURLY",
};

local hourlyfish = {
    [13759] = {
        ["enUS"] = "Raw Nightfin Snapper",
        ["deDE"] = "Roher Nachtflossenschnapper",
        ["frFR"] = "Lutjan nagenuit cru",
        ["zhTW"] = "新鮮的夜鱗鯛魚",
        ["c"] = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 },
        ["t"] = "INV_Misc_Fish_23",
    },
    [13760] = {
        ["enUS"] = "Raw Sunscale Salmon",
        ["deDE"] = "Roher Sonnenschuppenlachs",
        ["frFR"] = "Saumon sol\195\169caille cru",
        ["zhTW"] = "新鮮的陽鱗鮭魚",
        ["c"] = { r = 0.8, g = 0.8, b = 0.1, a = 0.75 },
        ["t"] = "INV_Misc_Fish_19",
    },
};
local weeklyfish = {
    [13756] = {
        ["enUS"] = "Raw Summer Bass",
        ["deDE"] = "Roher Sommerbarsch",
        ["frFR"] = "Perche estivale crue",
        ["zhTW"] = "新鮮的夏日鱸魚",
        ["c"] = { r = 1.0, g = 1.0, b = 0.0, a = 0.75 },
        ["t"] = "INV_Misc_Fish_03",
    },
    [13755] = {
        ["enUS"] = "Winter Squid",
        ["deDE"] = "Winterkalmar",
        ["frFR"] = "Calmar hivernal",
        ["zhTW"] = "冬魷魚",
        ["c"] = { r = 0.4, g = 0.1, b = 0.4, a = 0.75 },
        ["t"] = "INV_Misc_Fish_13",
    },
};

-- GetFishieRaw doesn't do the string format, so it might be
    -- faster and contribute to less GC activity
    local function GetFishieRaw(fid)
        if ( FishingBuddy.GetFishieRaw ) then
            return FishingBuddy.GetFishieRaw(fid);
        else
            return FishingBuddy.GetFishie(fid);
        end
    end

    local basetexture = "INV_Misc_Coin";
    local goldtexture = "_17";
    local silvertexture = "_18";
    local coppertexture = "_19";
    local function CoinP(fid)
        local _, texture, _, _, _, name = GetFishieRaw(fid);
        if ( texture and string.find(texture, basetexture) ) then
            return (string.find(texture, goldtexture) or
            string.find(texture, silvertexture) or
            string.find(texture, coppertexture));
        end
        return false;
    end

    local TrackFishies = nil;
    local function ResortFishies(force)
        if ( force ) then
            TrackFishies = nil;
        end
        if ( not TrackFishies ) then
            local sf = FishingBuddy.SortedFishies;
            TrackFishies = {};
            for idx=1,#sf do
                if ( not CoinP(sf[idx].id) ) then
                    tinsert(TrackFishies, sf[idx]);
                end
            end
        end
        return table.getn(TrackFishies);
    end

    local function UntrackThis(id, name)
        if ( not hourlyfish[id] and not weeklyfish[id] ) then
            for how in pairs(PBTF_Info) do
                if ( PBTF_Info[how][id] ) then
                    PBTF_Info[how][id] = nil;
                    FishingBuddy.Print(FB_TFConstants.NOTRACKMSG, name);
                end
            end
        else
            FishingBuddy.Message(FB_TFConstants.NOTRACKERRMSG);
        end
    end

    local function TrackThis(how, id, color, name, texture)
        if ( not PBTF_Info[how] ) then
            PBTF_Info[how] = {};
        end
        if ( not PBTF_Info["COLORS"] ) then
            PBTF_Info["COLORS"] = {};
        end
        local limit = 24;
        if ( how == "WEEKLY" ) then
            limit = 53;
        end
        if ( not PBTF_Info[how][id] ) then
            PBTF_Info[how][id] = {};
            PBTF_Info[how][id].data = {};
            for i=1,limit,1 do
                PBTF_Info[how][id].data[i] = 0;
            end
        end
        if ( name and not PBTF_Info[how][id].name ) then
            PBTF_Info[how][id].name = name;
        end
        if ( texture and not PBTF_Info[how][id].texture ) then
            PBTF_Info[how][id].texture = texture;
        end
        if ( not color and PBTF_Info[how][id].color ) then
            PBTF_Info["COLORS"][id] = PBTF_Info[how][id].color;
            PBTF_Info[how][id].color = nil;
        else
            if ( not color ) then
                color = { a = 1, r = 1, g = 1, b = 1};
            elseif ( type(color) == "string") then
                local a = tonumber(string.sub(color,1,2),16);
                local r = tonumber(string.sub(color,3,4),16);
                local g = tonumber(string.sub(color,5,6),16);
                local b = tonumber(string.sub(color,7,8),16);
                color = { a = a, r = r, g = g, b = b };
            end
            PBTF_Info[how][id].color = nil;
            PBTF_Info["COLORS"][id] = color;
        end
        PBTF_Info[how][id].plot = 1;
    end
    FishingBuddy.TrackThis = TrackThis;

    FishingBuddy.Commands[FB_TFConstants.TRACK] = {};
    FishingBuddy.Commands[FB_TFConstants.TRACK].args = {};
    FishingBuddy.Commands[FB_TFConstants.TRACK].args[1] = "[%w]+";
    FishingBuddy.Commands[FB_TFConstants.TRACK].args[2] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
    FishingBuddy.Commands[FB_TFConstants.TRACK].help = FB_TFConstants.TRACK_HELP;
    FishingBuddy.Commands[FB_TFConstants.TRACK].func =
    function(how, fishlink)
        if ( how and (how == FBConstants.HOURLY or
        how == FBConstants.WEEKLY)) then
            local c, i, n = FL:SplitLink(fishlink, true);
            if ( i ) then
                TrackThis(trackingWordMap[how], i, c, n);
                FishingBuddy.Print(FB_TFConstants.TRACKINGMSG, n, how);
                return true;
            end
        end
    end;
    FishingBuddy.Commands[FB_TFConstants.NOTRACK] = {};
    FishingBuddy.Commands[FB_TFConstants.NOTRACK].args = {};
    FishingBuddy.Commands[FB_TFConstants.NOTRACK].args[1] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
    FishingBuddy.Commands[FB_TFConstants.NOTRACK].help = FB_TFConstants.NOTRACK_HELP;
    FishingBuddy.Commands[FB_TFConstants.NOTRACK].func =
    function(fishlink)
        local c, i, n = FL:SplitLink(fishlink, true);
        if ( i ) then
            UntrackThis(i, n);
            return true;
        end
    end;
    FishingBuddy.Commands[FB_TFConstants.TRACKING] = {};
    FishingBuddy.Commands[FB_TFConstants.TRACKING].help = FB_TFConstants.TRACKING_HELP;
    FishingBuddy.Commands[FB_TFConstants.TRACKING].func =
    function()
        local pr = FishingBuddy.Print;
        for jdx in pairs(PBTF_Info) do
            local how = trackingWordMap[jdx];
            pr("Tracking "..how);
            local ft = PBTF_Info;
            for id in pairs(ft[jdx]) do
                local name;
                if ( ft[jdx][id].name ) then
                    name = ft[jdx][id].name;
                else
                    name = id;
                end
                local line = name.."; ";
                for k,v in pairs(ft[jdx][id].data) do
                    line = line.." "..k..": "..v;
                end
                pr(line);
            end
        end
        return true;
    end;

    local function InitTracking()
        if ( not PBTF_Info ) then
            PBTF_Info = { };
        end
        local l = GetLocale();
        for k,v in pairs(hourlyfish) do
            TrackThis("HOURLY", k, v.c, v[l], "Interface\\Icons\\"..v.t);
        end
        for k,v in pairs(weeklyfish) do
            TrackThis("WEEKLY", k, v.c, v[l], "Interface\\Icons\\"..v.t);
        end
    end

    local function AddTrackingHow(how, index, id, name)
        local ft = PBTF_Info;
        if ( not ft[how][id].name ) then
            ft[how][id].name = name;
        end
        index = tonumber(index);
        if ( not ft[how][id].data[index] ) then
            ft[how][id].data[index] = 0;
        end
        PBTF_Info[how][id].data[index] = ft[how][id].data[index] + 1;
        local g = _G["FishingTrackingFrameGraph"..how];
        if ( g.plotted[id] ) then
            g:RefreshPlot();
        end
    end

    local function AddTracking(id, name)
        local ft = PBTF_Info;
        local index;

        -- clean up fish removed from the tracking system
        local hourly = ft["HOURLY"][id];
        local weekly = ft["WEEKLY"][id];
        if ( hourly and hourly.nevermore ) then
            PBTF_Info["HOURLY"][id] = nil;
        end
        if ( weekly and weekly.nevermore ) then
            PBTF_Info["WEEKLY"][id] = nil;
        end

        ft = PBTF_Info;
        if ( not ft["HOURLY"][id] and not ft["WEEKLY"][id] ) then
            return false;
        end

        -- we might be tracking in both graphs
        if ( ft["HOURLY"][id] ) then
            index,_ = GetGameTime();
            AddTrackingHow("HOURLY", index+1, id, name);
        end
        if ( ft["WEEKLY"][id] ) then
            index = date("%W");
            AddTrackingHow("WEEKLY", tonumber(index)+1, id, name);
        end
        return true;
    end
    FishingBuddy.AddTracking = AddTracking;

    local function UpdateGraphData(graph, id, info)
        local maxval = 0;
        local n = table.getn(info.data);
        info.count = n;
        for idx=1,n do
            if ( info.data[idx] > maxval ) then
                maxval = info.data[idx];
            end
        end
        info.maxval = maxval;
        info.data = info.data;
        local color = PBTF_Info["COLORS"][id] or info.color;
        if ( type(color) == "string") then
            local a = tonumber(string.sub(info.color,1,2),16);
            local r = tonumber(string.sub(info.color,3,4),16);
            local g = tonumber(string.sub(info.color,5,6),16);
            local b = tonumber(string.sub(info.color,7,8),16);
            color = { a = a/256, r = r/256, g = g/256, b = b/256 };
        end
        if ( not color ) then
            color = { a = 1, r = 1, g = 1, b = 1};
        end
        PBTF_Info["COLORS"][id] = color;
        local name, texture;
        info.item, texture, _, _, _, name = FishingBuddy.GetFishie(id);
        if ( texture ) then
            info.texture = texture;
        end
        local loc = GetLocale();
        if ( not info.name ) then
            if ( hourlyfish[id] and hourlyfish[id][loc] ) then
                info.name = hourlyfish[id][loc];
            elseif ( weeklyfish[id] and weeklyfish[id][loc] ) then
                info.name = weeklyfish[id][loc];
            elseif ( not name ) then
                info.name = FBConstants.FISH.." ("..id..")";
            else
                info.name = name;
            end
        end
        if ( info.plot == 1 ) then
            if ( graph.plotted[id] ) then
                local ndx = graph.plotted[id];
                graph:UpdatePlotData(ndx, info.data);
            else
                local ndx = graph:AddPlotData(info.item, info.name, info.texture, color, info.data);
                graph.plotted[id] = ndx;
            end
        end
    end

    FB_TrackingFrame.OnShow = function(self)
        -- DrawTrackingGraphs();
        if ( not self.resized) then
            FishingTrackingFrameBg:ClearAllPoints();
            FishingTrackingFrameBg:SetPoint("TOPLEFT", FishingBuddyFrameInset, "TOPLEFT", 4, -2);

            FishingTrackingFrameBg:SetWidth(546);
            FishingTrackingFrameBg:SetHeight(540);

            local width = FishingBuddyFrameInset:GetWidth() - 40;
            local height = FishingBuddyFrameInset:GetHeight()/2 - 20;

            FishingTrackingFrameGraphHOURLY:SetWidth(width);
            FishingTrackingFrameGraphHOURLY:SetHeight(height);
            FishingTrackingFrameGraphWEEKLY:SetWidth(width);
            FishingTrackingFrameGraphWEEKLY:SetHeight(height);
            self.resized = 1;
        end
        FishingTrackingFrameGraphHOURLY:DrawPlot();
        FishingTrackingFrameGraphWEEKLY:DrawPlot();
    end

    local TrackingEvents = {};
    TrackingEvents[FBConstants.ADD_FISHIE_EVT] = function(id, name, zone, subzone)
        AddTracking(id, name);
        ResortFishies();
        if ( not CoinP(id) and not TrackFishies[id] ) then
            ResortFishies(1);
        end
    end

    local function UpdateTrackingGraph(how)
        local g = _G["FishingTrackingFrameGraph"..how];
        if ( not g.plotted ) then
            g.plotted = {};
        end
        for id,info in pairs(PBTF_Info[how]) do
            if ( g.plotted[id] and not info.plot ) then
                g:ClearPlot();
                g.plotted = {};
            end
        end
        for id,info in pairs(PBTF_Info[how]) do
            UpdateGraphData(g, id, info);
        end
    end

    local function TrackFishToggle(fishid, how)
        local tab = PBTF_Info[how];
        if ( not tab[fishid] ) then
            local ff = FishingBuddy_Info["Fishies"];
            TrackThis(how, fishid, PBTF_Info["COLORS"][fishid], ff[fishid].name);
        else
            if ( tab[fishid].plot == 1) then
                PBTF_Info[how][fishid].nevermore = not GetSettingBool("TrackHidden");
            else
                PBTF_Info[how][fishid].nevermore = nil;
                tab[fishid].plot = 0;
            end
            PBTF_Info[how][fishid].plot = 1 - tab[fishid].plot;
        end
        UpdateTrackingGraph(how);
    end

    function FishingTrackingCheck_OnClick(self)
        local parent = self:GetParent();
        TrackFishToggle(parent.fishid, self.how);
    end

    function FishingTrackingCheck_OnEnter(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        FL:AddTooltip(FB_TFConstants["TOOLTIP_"..self.how]);
        GameTooltip:Show();
    end

    function FishingTrackingCheck_OnLeave(self)
        GameTooltip:Hide();
    end

    local function UpdateColorSwatch(self, id, restore)
        local r, g, b;
        if restore then
            r, g, b, _ = unpack(restore);
        else
            r, g, b = ColorPickerFrame:GetColorRGB();
        end
        PBTF_Info["COLORS"][id] = { a = 1, r = r, g = g, b = b };
        local swatch = _G[self:GetName().."Texture"];
        swatch:SetTexture(r, g, b, 1);
    end

    function ShowColorPicker(r, g, b, a, changedCallback)
        ColorPickerFrame:SetColorRGB(r,g,b);
        ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a;
        ColorPickerFrame.previousValues = {r,g,b,a};
        ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc =
        changedCallback, changedCallback, changedCallback;
        ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
        ColorPickerFrame:Show();
    end

    function FishingTrackingSwatch_OnClick(self)
        local parent = self:GetParent();
        local color = PBTF_Info["COLORS"][parent.fishid];
        if ( not color ) then
            color = { a = 1.0, r = 0.5, g = 0.5, b = 0.5 };
        end
        ColorPickerFrame.hasOpacity = nil;
        ColorPickerFrame.opacity = nil;
        ShowColorPicker(color.r, color.g, color.b, nil,
        function(restore)
            local s = self;
            local i = parent.fishid;
            UpdateColorSwatch(s, i, restore);
        end);
    end

    local function UpdateTrackingScrollPosition()
        local fishcount = ResortFishies();
        local offset = FauxScrollFrame_GetOffset(FishingTrackingScrollFrame);
        if ( offset + NUM_THINGIES_DISPLAYED > fishcount ) then
            offset = fishcount - NUM_THINGIES_DISPLAYED;
            if ( offset < 0 ) then
                offset = 0;
            end
            FishingTrackingScrollFrameScrollBar:SetValue(offset);
        end
        FauxScrollFrame_Update( FishingTrackingScrollFrame, fishcount,
        NUM_THINGIES_DISPLAYED,
        FRAME_THINGIEHEIGHT,
        nil, nil, nil,
        FishingTrackingHighlightFrame,
        263, 263
    );
end

local function PlotP(how, fid)
    local fi = PBTF_Info;
    return (fi[how][fid] ~= nil and fi[how][fid].plot == 1);
end

FB_TrackingFrame.Update = function(self, forced)
    if ( not self:IsVisible() ) then
        return;
    end

    FishingTrackingHighlightFrame:Hide();
    UpdateTrackingScrollPosition();

    local offset = FauxScrollFrame_GetOffset(self);
    local limit = offset + NUM_THINGIES_DISPLAYED;
    local line = 1;
    local fishcount = ResortFishies();

    if ( limit >= fishcount ) then
        limit = fishcount-1;
    end
    for idx=offset,limit do
        local lname = "FishingTracking"..line;
        local locButton = _G[lname];
        if ( locButton ) then
            local checkh = _G[lname.."Hourly"];
            local checkw = _G[lname.."Weekly"];
            local icon = _G[lname.."IconTexture"];
            local swatch = _G[lname.."SwatchTexture"];

            local fid = TrackFishies[idx+1].id;
            local item, texture, _, _, _, name, _ = FishingBuddy.GetFishie(fid);
            text = FishingBuddy.StripRaw(name);
            locButton.item = item;
            locButton.fishid = fid;
            locButton.name = name;
            icon:SetTexture(texture);
            local color = PBTF_Info["COLORS"][fid];
            if ( not color ) then
                color = { a = 1.0, r = 0.5, g = 0.5, b = 0.5 };
            end
            swatch:SetTexture(color.r, color.g, color.b, 1);
            locButton:SetText(text);
            checkh:SetChecked(PlotP("HOURLY", fid));
            checkw:SetChecked(PlotP("WEEKLY", fid));
            locButton:Show();
        end
        line = line + 1;
    end
    while ( line <= NUM_THINGIES_DISPLAYED ) do
        local locButton = _G["FishingTracking"..line];
        if ( locButton ) then
            locButton:Hide();
        end
        line = line + 1;
    end
end

local function Chooser_OnShow(self, ...)
    if ( FishingBuddy.IsLoaded() ) then
        FB_TrackingFrame.Update(FishingTrackingScrollFrame);
    end
end

local function CreateGraph(self, how, xlabels, ...)
    local f1 = GH:NewGraph("FishingTrackingFrameGraph"..how, ...);
    local w = self:GetWidth()-60;
    local h = (self:GetHeight()-180)/2;

    f1:SetWidth(w);
    f1:SetHeight(h);
    f1:SetScript("OnMouseUp", FB_TrackingFrame_OnClick);
    f1:SetScript("OnEnter", FB_TrackingFrame_OnEnter);
    f1:SetScript("OnLeave", FB_TrackingFrame_OnLeave);
    UpdateTrackingGraph(how);
    f1:SetLabels(FB_TFConstants[how], xlabels)
    f1:Show();
end

FB_TrackingFrame.OnEvent = function(self, event)
    if ( FishingBuddy_Info and FishingBuddy_Info["FishTracking"] ) then
        PBTF_Info = {};
        for k,v in pairs(FishingBuddy_Info["FishTracking"]) do
            PBTF_Info[k] = v;
        end
        FishingBuddy_Info["FishTracking"] = nil;
    end

    InitTracking();

    if ( not PBTF_Info.updated ) then
        PBTF_Info.updated = 1;
        for id,info in pairs(PBTF_Info["HOURLY"]) do
            local data = {};
            for idx=0,23 do
                tinsert(data, info.data[idx]);
            end
            info.data = data;
        end
        for id,info in pairs(PBTF_Info["WEEKLY"]) do
            local data = {};
            for idx=0,52 do
                tinsert(data, info.data[idx]);
            end
            info.data = data;
        end
    end

    RegisterHandlers(TrackingEvents);
    FishingBuddy.Locations.PerFishOptions(TrackOptionsMenu);

    local xlabels = {"00:00", "06:00", "12:00", "18:00", "23:59"};
    CreateGraph(self, "HOURLY", xlabels, "TOPLEFT", FishingTrackingFrame, "TOPLEFT", 20, -80);
    CreateGraph(self, "WEEKLY", byweeks, "TOPLEFT", FishingTrackingFrameGraphHOURLY, "BOTTOMLEFT", 0, -10);

    groups = {}
    tinsert(groups, {
        ["name"] = FB_TFConstants.TRACKING_TAB,
        ["tooltip"] = FB_TFConstants.TRACKING_INFO,
        ["icon"] = "Interface\\Icons\\INV_Misc_Note_05",
        ["frame"] = self
    })
    target = FishingBuddy.CreateManagedFrameGroup(FBConstants.LOCATIONS_TAB,
                                        FBConstants.LOCATIONS_INFO,
                                        "_LOC",
                                        groups);

    optiontab = {
        ["name"] = FB_TFConstants.FILTER_TAB,
        ["icon"] = "Interface\\Icons\\Inv_Misc_Net_01",
        ["options"] = TrackingOptions
    }

    FishingBuddy.CreateManagedOptionsTab(target, FBConstants.LOCATIONS_TAB, target.groups, optiontab)
    -- Create the options frame and manage it now
    FishingTrackingChooser:SetScript("OnShow", Chooser_OnShow);

    self:UnregisterEvent("VARIABLES_LOADED");
end

FB_TrackingFrame.OnLoad = function(self)
    self:RegisterEvent("VARIABLES_LOADED");
end
