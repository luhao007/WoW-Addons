-- what's the name of this addon?
local AMC_thisAddonName = ...
local AMC_myCategory = AtlasMajorCities_loc["Atlas_Category"];

local _G = getfenv(0)
local LibStub = _G.LibStub
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")

-- color variable entry from Atlas.lua
local GREN = "|cff66cc33";

-- general switch to load all the code to edit the DB
AtlasMajorCities_EditMode = false;
-- remove also the comments in Bindings.xml to activate it

-- all the saved variables
AtlasMajorCities_DB = {};
AtlasMajorCities_Continent = {};
AtlasMajorCities_City = {};
AtlasMajorCities_Zone = {};
AtlasMajorCities_Shop = {};
AtlasMajorCities_Title = {};
AtlasMajorCities_NPC = {};
AtlasMajorCities_Comment = {};
AtlasMajorCities_Adds = nil;
AtlasMajorCities_Input = nil;

-- uiMapID to MapName table
local AMC_uiMapID_to_MapName = {
	[622] = "AshranAllianceFactionHub",
	[624] = "AshranHordeFactionHub",
	[125] = "Dalaran1_",
	[126] = "Dalaran2_",
	[627] = "Dalaran7010_",
	[628] = "Dalaran7011_",
	[629] = "Dalaran7010_",
	[89] = "Darnassus",
	[87] = "Ironforge",
	[85] = "Orgrimmar1_",
	[86] = "Orgrimmar2_",
	[111] = "ShattrathCity",
	[393] = "ShrineofSevenStars3_",
	[394] = "ShrineofSevenStars4_",
	[391] = "ShrineofTwoMoons1_",
	[392] = "ShrineofTwoMoons2_",
	[110] = "SilvermoonCity",
	[84] = "StormwindCity",
	[103] = "TheExodar",
	[83] = "ThunderBluff",
	[998] = "Undercity",
}

-- assign internal city names to image keys (there a empty image with this name is needed in subfolder images)
local AMC_myDataKeys = {
	["TheExodar"]                = "EX",
	["Darnassus"]                = "DN",
	["Ironforge"]                = "IF",
	["StormwindCity"]            = "SW",
	["SilvermoonCity"]           = "SM",
	["Undercity"]                = "UC",
	["ThunderBluff"]             = "TB",
	["Orgrimmar1_"]              = "OG",
	["Orgrimmar2_"]              = "OGC",
	["ShattrathCity"]            = "SR",
	["Dalaran1_"]                = "DL",
	["Dalaran2_"]                = "DLS",
	["Dalaran7010_"]             = "DLL",
	["Dalaran7011_"]             = "DLLS",
	["Dalaran7012_"]             = "DLLA",
	["ShrineofTwoMoons1_"]       = "STM1",
	["ShrineofTwoMoons2_"]       = "STM2",
	["ShrineofSevenStars3_"]     = "SSS3",
	["ShrineofSevenStars4_"]     = "SSS4",
	["AshranAllianceFactionHub"] = "AAFH",
	["AshranHordeFactionHub"]    = "AHFH",
}

local AMC_cityMapPath = {
	["TheExodar"]                = "Interface\\Worldmap\\TheExodar\\TheExodar",
	["Darnassus"]                = "Interface\\Worldmap\\Darnassus\\Darnassus",
	["Ironforge"]                = "Interface\\Worldmap\\Ironforge\\Ironforge",
	["StormwindCity"]            = "Interface\\Worldmap\\StormwindCity\\StormwindCity",
	["SilvermoonCity"]           = "Interface\\Worldmap\\SilvermoonCity\\SilvermoonCity",
	["Undercity"]                = "Interface\\Worldmap\\Undercity\\Undercity",
	["ThunderBluff"]             = "Interface\\Worldmap\\ThunderBluff\\ThunderBluff",
	["Orgrimmar1_"]              = "Interface\\Worldmap\\Orgrimmar\\Orgrimmar",
	["Orgrimmar2_"]              = "Interface\\Worldmap\\Orgrimmar\\Orgrimmar1_",
	["ShattrathCity"]            = "Interface\\Worldmap\\ShattrathCity\\ShattrathCity",
	["Dalaran1_"]                = "Interface\\Worldmap\\Dalaran\\Dalaran1_",
	["Dalaran2_"]                = "Interface\\Worldmap\\Dalaran\\Dalaran2_",
	["Dalaran7010_"]             = "Interface\\Worldmap\\Dalaran70\\Dalaran7010_",
	["Dalaran7011_"]             = "Interface\\Worldmap\\Dalaran70\\Dalaran7011_",
	["Dalaran7012_"]             = "Interface\\Worldmap\\Dalaran70\\Dalaran7012_",
	["ShrineofTwoMoons1_"]       = "Interface\\Worldmap\\MicroDungeon\\ValeOfEternalBlossoms\\ShrineofTwoMoons\\ShrineofTwoMoons1_",
	["ShrineofTwoMoons2_"]       = "Interface\\Worldmap\\MicroDungeon\\ValeOfEternalBlossoms\\ShrineofTwoMoons\\ShrineofTwoMoons2_",
	["ShrineofSevenStars3_"]     = "Interface\\Worldmap\\MicroDungeon\\ValeOfEternalBlossoms\\ShrineofSevenStars\\ShrineofSevenStars3_",
	["ShrineofSevenStars4_"]     = "Interface\\Worldmap\\MicroDungeon\\ValeOfEternalBlossoms\\ShrineofSevenStars\\ShrineofSevenStars4_",
	["AshranAllianceFactionHub"] = "Interface\\Worldmap\\AshranAllianceFactionHub\\AshranAllianceFactionHub",
	["AshranHordeFactionHub"]    = "Interface\\Worldmap\\AshranHordeFactionHub\\AshranHordeFactionHub",
}

-- the left and right skip together must be 33.4
AtlasMajorCities_XMapCoordSkip = {
	["TheExodar1"] = 19.7,
	["TheExodar2"] = 13.7,
	["Darnassus1"] = 14.7,
	["Darnassus2"] = 18.7,
	["Ironforge1"] = 14.4,
	["Ironforge2"] = 19.0,
	["StormwindCity1"] = 22.0,
	["StormwindCity2"] = 11.4,
	["SilvermoonCity1"] = 33.4,
	["SilvermoonCity2"] = 0.0,
	["Undercity1"] = 33.4,
	["Undercity2"] = 0.0,
	["ThunderBluff1"] = 17.4,
	["ThunderBluff2"] = 16.0,
	["Orgrimmar1_1"] = 18.9,
	["Orgrimmar1_2"] = 14.5,
	["Orgrimmar2_1"] = 16.9,
	["Orgrimmar2_2"] = 16.5,
	["ShattrathCity1"] = 15.0,
	["ShattrathCity2"] = 18.4,
	["Dalaran1_1"] = 12.4,
	["Dalaran1_2"] = 21.0,
	["Dalaran2_1"] = 10.4,
	["Dalaran2_2"] = 23.0,
	["Dalaran7010_1"] = 12.4,
	["Dalaran7010_2"] = 21.0,
	["Dalaran7011_1"] = 16.4,
	["Dalaran7011_2"] = 17.0,
	["Dalaran7012_1"] = 13.4,
	["Dalaran7012_2"] = 20.0,
	["ShrineofTwoMoons1_1"] = 17.0,
	["ShrineofTwoMoons1_2"] = 16.4,
	["ShrineofTwoMoons2_1"] = 15.2,
	["ShrineofTwoMoons2_2"] = 18.2,
	["ShrineofSevenStars3_1"] = 19.0,
	["ShrineofSevenStars3_2"] = 14.4,
	["ShrineofSevenStars4_1"] = 21.4,
	["ShrineofSevenStars4_2"] = 12.0,
	["AshranAllianceFactionHub1"] = 14.0,
	["AshranAllianceFactionHub2"] = 19.4,
	["AshranHordeFactionHub1"]    = 33.4,
	["AshranHordeFactionHub2"]    = 0.0,
}

-- set after addon load
AtlasMajorCities_VariablesLoaded = false;

-- flag for addon database (db0) or user database (db)
AtlasMajorCities_UserDB = false;

-- flag at which position the labels are shown (-1 - moving labels ; 0 - label pos. ; 1 - shop pos. ; 2 - shop sign pos.)
AtlasMajorCities_LabelAtPos = 0;

-- indicates the actual shown city map
AtlasMajorCities_ShownCity = "";

-- data field put into Atlas
local AMC_myAtlasData = {};

-- font object in the AtlasMajorCities_Frame
local AMC_FrameLabel;

-- the with of the table window with the shop list
local AMC_TableMaxWidth = 430;

-- counted number of displayed map labels
local AMC_NumFramesSmall = 0;
local AMC_NumFrames = 0;

-- some saved hooks
local AMC_AtlasFrameDropDownType_Initialize_Orig = nil;
local AMC_AtlasFrameDropDownType_OnClick_Orig = nil;

-- Atlas main menu index of AMC
local AMC_AtlasMainMenuIndex = 0;

-- texture of the player arrow
local AMC_PlayerArrow_Frame;
local AMC_PlayerArrow_FrameSmall;
local AMC_PlayerArrow_Tex;
local AMC_PlayerArrow_TexSmall;

-- key bindings
BINDING_HEADER_AMC_TITLE  = "AtlasMajorCities Enhanced";
BINDING_NAME_AMC_ZONE     = AtlasMajorCities_loc["BIND_ZONE"];
BINDING_NAME_AMC_CREATE   = AtlasMajorCities_loc["BIND_CREATE"];
BINDING_NAME_AMC_ASSIGN   = AtlasMajorCities_loc["BIND_ASSIGN"];
BINDING_NAME_AMC_LABEL    = AtlasMajorCities_loc["BIND_LABEL"];
BINDING_NAME_AMC_SIGN     = AtlasMajorCities_loc["BIND_SIGN"];
BINDING_NAME_AMC_TITLE    = AtlasMajorCities_loc["BIND_TITLE"];
BINDING_NAME_AMC_COMMENT  = AtlasMajorCities_loc["BIND_COMMENT"];
BINDING_NAME_AMC_TOOLTIP1 = AtlasMajorCities_loc["BIND_TOOLTIP1"];
BINDING_NAME_AMC_TOOLTIP2 = AtlasMajorCities_loc["BIND_TOOLTIP2"];

-- ***********************************************************************************************************************************
-- general sub-routines
-- ***********************************************************************************************************************************

local AMC_DBbase, AMC_DBcontinent, AMC_DBcity, AMC_DBzone, AMC_DBshop, AMC_DBtitle, AMC_DBnpc, AMC_DBcomment;
local AMC_Pbase, AMC_Pcontinent, AMC_Pcity, AMC_Pzone, AMC_Pshop, AMC_Ptitle, AMC_Pnpc, AMC_Pcomment;

local function FAMC_SetDBTables()
	local partDB = ( AtlasMajorCities_UserDB and AtlasMajorCities_Adds );
	local baseDB = ( not AtlasMajorCities_UserDB or partDB );

	if ( baseDB ) then
		AMC_DBbase = AtlasMajorCities_DB0;
		AMC_DBcontinent = AtlasMajorCities_Continent0;
		AMC_DBcity = AtlasMajorCities_City0;
		AMC_DBzone = AtlasMajorCities_Zone0;
		AMC_DBshop = AtlasMajorCities_Shop0;
		AMC_DBtitle = AtlasMajorCities_Title0;
		AMC_DBnpc = AtlasMajorCities_NPC0;
		AMC_DBcomment = AtlasMajorCities_Comment0;
	else
		AMC_DBbase = AtlasMajorCities_DB;
		AMC_DBcontinent = AtlasMajorCities_Continent;
		AMC_DBcity = AtlasMajorCities_City;
		AMC_DBzone = AtlasMajorCities_Zone;
		AMC_DBshop = AtlasMajorCities_Shop;
		AMC_DBtitle = AtlasMajorCities_Title;
		AMC_DBnpc = AtlasMajorCities_NPC;
		AMC_DBcomment = AtlasMajorCities_Comment;
	end

	if ( partDB ) then
		AMC_Pbase = AtlasMajorCities_DB;
		AMC_Pcontinent = AtlasMajorCities_Continent;
		AMC_Pcity = AtlasMajorCities_City;
		AMC_Pzone = AtlasMajorCities_Zone;
		AMC_Pshop = AtlasMajorCities_Shop;
		AMC_Ptitle = AtlasMajorCities_Title;
		AMC_Pnpc = AtlasMajorCities_NPC;
		AMC_Pcomment = AtlasMajorCities_Comment;
	else
		AMC_Pbase = nil;
		AMC_Pcontinent = nil;
		AMC_Pcity = nil;
		AMC_Pzone = nil;
		AMC_Pshop = nil;
		AMC_Ptitle = nil;
		AMC_Pnpc = nil;
		AMC_Pcomment = nil;
	end
end

function AtlasMajorCities_GetShopTitleText(skey, city, shop)
	local sign, title;
	if ( AMC_Pshop and skey and AMC_Pshop[skey] ) then sign =  AMC_Pshop[skey]; end
	if ( not sign and skey )                      then sign = AMC_DBshop[skey]; end
	if ( sign == "deleted" ) then sign = nil; end
	local tkey = city.."-"..shop;
	if ( AMC_Ptitle and AMC_Ptitle[tkey] ) then title =  AMC_Ptitle[tkey]; end
	if ( not title )                       then title = AMC_DBtitle[tkey]; end
	if ( title == "deleted" ) then title = nil; end
	if ( sign and title ) then title = "* "..sign.." ."..title..".*";
	elseif ( sign )       then title = "* "..sign.." *";
	elseif ( title )      then title = "*."..title..".*";
	end
	return title;
end

function AtlasMajorCities_GetNPCText(sval)
	local npc, comment;
	local nkey = "NPC"..tostring(sval);
	if ( AMC_Pcomment and AMC_Pcomment[nkey] ) then comment =  AMC_Pcomment[nkey]; end
	if ( not comment )                         then comment = AMC_DBcomment[nkey]; end
	if ( comment == "deleted" ) then comment = nil; end
	if ( comment ) then comment = " ("..comment..")"; else comment = ""; end
	if ( AMC_Pnpc and AMC_Pnpc[nkey] ) then npc =  AMC_Pnpc[nkey]; end
	if ( not npc )                     then npc = AMC_DBnpc[nkey]; end
	if ( npc ) then return npc..comment; end
end

-- get the actual map name
local function FAMC_GetActualMapName()
--	local oMapID = GetCurrentMapAreaID();
--	SetMapToCurrentZone();
--	local oMapID = WorldMapFrame:GetMapID(); -- user might have other map opened
	local uiMapID = C_Map.GetBestMapForUnit("player");
--	if (uiMapID) then WorldMapFrame:SetMapID(uiMapID); end

--[[
	local MapName, _, _, isMicro, MicroMap = GetMapInfo();
	if ( isMicro ) then MapName = MicroMap; end
	dungeonLevel = GetCurrentMapDungeonLevel();
	if ( dungeonLevel > 0 ) then
		MapName = MapName..dungeonLevel.."_";
	else
		if ( MapName == "Dalaran" ) then MapName = "Dalaran1_"; end
		if ( MapName == "Orgrimmar" ) then MapName = "Orgrimmar1_"; end
	end
]]
	local MapName = AMC_uiMapID_to_MapName[uiMapID]
	-- check if the city is included in the AMC city list
	if ( AMC_Pcity and not AMC_Pcity[MapName] and not AMC_DBcity[MapName] ) then MapName = nil;
	elseif ( not AMC_Pcity and not AMC_DBcity[MapName] ) then MapName = nil; end

	-- arith: fixed the issue that worldmap was always forced to current-map when Atlas is opened.
	--if (oMapID) then SetMapByID(oMapID); end
--	if (oMapID) then WorldMapFrame:SetMapID(oMapID); end
	
	return MapName;
end

-- get the actual localized map name
local function FAMC_GetActual_LC_MapName()
	local MapName = FAMC_GetActualMapName();
	if ( MapName ) then
		if ( AMC_Pcity and AMC_Pcity[MapName] ) then
			MapName = AMC_Pcity[MapName];
		elseif ( AMC_DBcity and AMC_DBcity[MapName] ) then
			MapName = AMC_DBcity[MapName];
		end
		if ( MapName == "deleted" ) then MapName = nil; end
	end
	return MapName;
end

-- set the frame position at the AtlasMap
local function FAMC_SetMapFramePosition(valx, valy, mapframe, small)
	-- compute and set position of frame object at the map
	local x1 = AtlasMajorCities_XMapCoordSkip[AtlasMajorCities_ShownCity.."1"];
	local x2 = AtlasMajorCities_XMapCoordSkip[AtlasMajorCities_ShownCity.."2"];
	local xpos = (valx - x1) / (100.0 - x1 - x2);
	local ypos = valy / 100.0;
	local wmap, hmap;
	if ( small ) then
		wmap = AtlasMapSmall:GetWidth();
		hmap = AtlasMapSmall:GetHeight();
	else
		wmap = AtlasMap:GetWidth();
		hmap = AtlasMap:GetHeight();
	end
	local xoff = math.floor(wmap*xpos+0.5);
	local yoff = math.floor(hmap*(-ypos)+0.5);
	if ( small ) then
		mapframe:SetPoint("CENTER", AtlasMapSmall, "TOPLEFT", xoff, yoff);
	else
		mapframe:SetPoint("CENTER", AtlasMap, "TOPLEFT", xoff, yoff);
	end
	return xoff, yoff;
end

-- ***********************************************************************************************************************************
-- sub-routines for initialization
-- ***********************************************************************************************************************************

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- sub-sub-routine for OnLoad
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- create the player arrow frame
local function FAMC_InitPlayerArrow()
	AMC_PlayerArrow_Frame = CreateFrame("FRAME", "AMC_PlayerArrow_Frame", AtlasFrame);
	AMC_PlayerArrow_Tex = AMC_PlayerArrow_Frame:CreateTexture("AMC_PlayerArrow_Tex", "ARTWORK");
	AMC_PlayerArrow_Tex:SetWidth(42);
	AMC_PlayerArrow_Tex:SetHeight(42);
	AMC_PlayerArrow_Tex:SetPoint("CENTER", AMC_PlayerArrow_Frame, "CENTER", 0, 0);
	AMC_PlayerArrow_Tex:SetTexture("Interface\\MINIMAP\\MinimapArrow");
	AMC_PlayerArrow_Frame:SetWidth(42);
	AMC_PlayerArrow_Frame:SetHeight(42);
	AMC_PlayerArrow_Frame:ClearAllPoints();
	AMC_PlayerArrow_Frame:SetPoint("CENTER", AtlasMap, "TOPLEFT", 0, 0);
	AMC_PlayerArrow_Frame:SetFrameStrata("HIGH");
	AMC_PlayerArrow_Frame:Hide();

	-- setup small frame
	AMC_PlayerArrow_FrameSmall = CreateFrame("FRAME", "AMC_PlayerArrow_FrameSmall", AtlasFrameSmall);
	AMC_PlayerArrow_TexSmall = AMC_PlayerArrow_FrameSmall:CreateTexture("AMC_PlayerArrow_TexSmall", "ARTWORK");
	AMC_PlayerArrow_TexSmall:SetWidth(42);
	AMC_PlayerArrow_TexSmall:SetHeight(42);
	AMC_PlayerArrow_TexSmall:SetPoint("CENTER", AMC_PlayerArrow_FrameSmall, "CENTER", 0, 0);
	AMC_PlayerArrow_TexSmall:SetTexture("Interface\\MINIMAP\\MinimapArrow");
	AMC_PlayerArrow_FrameSmall:SetWidth(42);
	AMC_PlayerArrow_FrameSmall:SetHeight(42);
	AMC_PlayerArrow_FrameSmall:ClearAllPoints();
	AMC_PlayerArrow_FrameSmall:SetPoint("CENTER", AtlasMapSmall, "TOPLEFT", 0, 0);
	AMC_PlayerArrow_FrameSmall:SetFrameStrata("HIGH");
	AMC_PlayerArrow_FrameSmall:Hide();
end

-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

-- define the hooks, the player arrow, and register with Atlas
local function FAMC_OnLoad(self)
	-- hook to the Atlas function AtlasFrameDropDownType_Initialize to get the menu index of AMC
	AMC_AtlasFrameDropDownType_Initialize_Orig = AtlasFrameDropDownType_Initialize;
	AtlasFrameDropDownType_Initialize = AtlasMajorCities_AtlasFrameDropDownType_Initialize_Hook;

	-- hook to the Atlas function AtlasFrameDropDown_OnShow() to set the AMC zone menu to the actual map
	AMC_AtlasFrameDropDownType_OnClick_Orig = AtlasFrameDropDownType_OnClick;
	AtlasFrameDropDownType_OnClick = AtlasMajorCities_AtlasFrameDropDownType_OnClick_Hook;

	-- create a hiden font string to wrap the displayed shop names
	AMC_FrameLabel = AtlasMajorCities_Frame:CreateFontString("AMC_FrameLabel", "BACKGROUND", "GameFontHighlight");

	-- create the player arrow frame
	FAMC_InitPlayerArrow();

	-- check if the user-DB is used
	local index = next(AtlasMajorCities_DB);
	if ( not index ) then AtlasMajorCities_Adds = nil; AtlasMajorCities_Input = nil; end
	if ( index and AtlasMajorCities_EditMode ) then AtlasMajorCities_UserDB = true; end

	-- Register AMC with Atlas (put city names and city keys)
	AtlasMajorCities_RegisterWithAtlas("init");

	AtlasMajorCities_VariablesLoaded = true;
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- update the city list in Atlas (called at load and edit of the city names)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- register AMC with Atlas (like Atlas_RegisterPlugin)
function AtlasMajorCities_RegisterWithAtlas(init)
	-- set basic switches and input DBs
	FAMC_SetDBTables();

	-- create the input DB for Atlas
	local myData = {};
	myData["Search"] = AtlasMajorCities_SearchCall;
	local city;
	for city in pairs(AMC_DBbase) do
		local myDataKey = AMC_myDataKeys[city];
		if ( myDataKey ) then
			local city_list = {};
			city_list.AMCName = city;

			if ( AMC_Pcity and AMC_Pcity[city] )                then city_list.ZoneName = {  AMC_Pcity[city] }; end
			if ( not city_list.ZoneName and AMC_DBcity[city] )  then city_list.ZoneName = { AMC_DBcity[city] }; end
			if ( AMC_Pcity and (AMC_Pcity[city] == "deleted") ) then city_list.ZoneName = { city }; end
			if ( not city_list.ZoneName )                       then city_list.ZoneName = { city }; end

			if ( AMC_Pcontinent and AMC_Pcontinent[city] )              then city_list.Location = {  AMC_Pcontinent[city] }; end
			if ( not city_list.Location )                               then city_list.Location = { AMC_DBcontinent[city] }; end
			if ( AMC_Pcontinent and AMC_Pcontinent[city] == "deleted" ) then city_list.Location = nil; end

			-- fill city list with empty entries, because AtlasLoot counts for it (the Atlas list shows 24 entries)
			for idx = 1, 24 do
				local temp = {}
				table.insert(city_list, temp)
			end

			myData[myDataKey] = city_list;
		end
	end

	-- add AMC to the category pull-down menu
	if ( init ) then
		local i = getn(Atlas_MapTypes) + 1;
		Atlas_MapTypes[i] = GREN..AMC_myCategory;
	end

	-- load city data and its image list (ATLAS_PLUGINS)
	local name = AMC_thisAddonName;
	ATLAS_PLUGINS[name] = {};
	local k, v;
	for k, v in pairs(myData) do
		table.insert(ATLAS_PLUGINS[name], k);
		AtlasMaps[k] = v;
	end

	-- add an AMC map pull-down menu to Atlas
	if ( init ) then
		table.insert(ATLAS_PLUGIN_DATA, myData);
	else
		local plugin_key, plugin_data;
		for plugin_key, plugin_data in pairs(ATLAS_PLUGIN_DATA) do
			if ( plugin_data.Search == AtlasMajorCities_SearchCall ) then
				ATLAS_PLUGIN_DATA[plugin_key] = myData;
				break;
			end
		end
	end

	-- set actual map to saved state
	if ( init ) then
--		local catName = Atlas_DropDownLayouts_Order[Atlas.db.profile.options.dropdowns.menuType];
--		local subcatOrder = Atlas_DropDownLayouts_Order[catName];
--		if ( ATLAS_OLD_TYPE and ATLAS_OLD_TYPE <= getn(subcatOrder) + getn(Atlas_MapTypes) ) then
		if ( ATLAS_OLD_TYPE and ATLAS_OLD_TYPE <= ATLAS_MODULE_MENUS + getn(Atlas_MapTypes) ) then
			Atlas.db.profile.options.dropdowns.module = ATLAS_OLD_TYPE;
			Atlas.db.profile.options.dropdowns.zone = ATLAS_OLD_ZONE;
		end
	end

	Atlas:PopulateDropdowns();
	Atlas_Refresh();

	if ( AtlasMajorCities_EditMode and not init ) then
		DEFAULT_CHAT_FRAME:AddMessage("New registered with Atlas", .9, .0, .9);
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- sub-sub-routine for OnUpdate
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- set the player arrow on the Atlas map
local function FAMC_SetPlayerArrow(small)
	if ( AMC_AtlasMainMenuIndex == 0 ) then return; end
	if ( not AtlasFrame:IsShown() and not AtlasFrameSmall:IsShown() ) then return; end

	local Pshow = true;
	if ( Atlas.db.profile.options.dropdowns.module ~= AMC_AtlasMainMenuIndex ) then Pshow = false; end

	local CityName = FAMC_GetActualMapName();
	if ( not CityName or (AtlasMajorCities_ShownCity == "") or (CityName ~= AtlasMajorCities_ShownCity) ) then Pshow = false; end

	if ( Pshow ) then
		-- set player arrow to its map position
		local uiMapID = C_Map.GetBestMapForUnit("player");
		local posXY, posX, posY;
		if (uiMapID) then 
			posXY = C_Map.GetPlayerMapPosition(uiMapID, "player") or nil;
		end
		if (posXY) then
			posX, posY = posXY:GetXY();
		else
			posX, posY = 0, 0;
		end

		AMC_PlayerArrow_Frame:ClearAllPoints();
		AMC_PlayerArrow_FrameSmall:ClearAllPoints();
		if ( small ) then
			posX, posY = FAMC_SetMapFramePosition(posX * 100, posY * 100, AMC_PlayerArrow_FrameSmall, true);
		else
			posX, posY = FAMC_SetMapFramePosition(posX * 100, posY * 100, AMC_PlayerArrow_Frame);
		end

		if ( posX > 0 and posY < 0 and posX < 512 and posY > -512 ) then
			-- turn player arrow to its facing angle (-PI < North (=0) < PI)
			local FacingAngleRad = GetPlayerFacing();
			if ( small ) then
				AMC_PlayerArrow_TexSmall:SetRotation(FacingAngleRad,0.485,0.65);
			else
				AMC_PlayerArrow_Tex:SetRotation(FacingAngleRad,0.485,0.65);
			end

			if ( small ) then
				AMC_PlayerArrow_FrameSmall:Show();
				AMC_PlayerArrow_Frame:Hide();
			else
				AMC_PlayerArrow_FrameSmall:Hide();
				AMC_PlayerArrow_Frame:Show();
			end
		else
			AMC_PlayerArrow_FrameSmall:Hide();
			AMC_PlayerArrow_Frame:Hide();
		end
	else
		AMC_PlayerArrow_FrameSmall:Hide();
		AMC_PlayerArrow_Frame:Hide();
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- definition of the hooks for Atlas pull-down menu handling
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- get index of AMC in the AtlasFrameDropDownType menu
function AtlasMajorCities_AtlasFrameDropDownType_Initialize_Hook()
	-- call original function first
	AMC_AtlasFrameDropDownType_Initialize_Orig();

	local atlasCategory = AtlasMajorCities_loc["Atlas_Category"];
	local i;
	for i = 1, getn(Atlas_MapTypes), 1 do
		if ( string.find(Atlas_MapTypes[i], atlasCategory) ) then
			AMC_AtlasMainMenuIndex = ATLAS_MODULE_MENUS + i;
			break;
		end
	end
end

-- set initial AMC menu entry to actual map
function AtlasMajorCities_AtlasFrameDropDownType_OnClick_Hook(self)
	-- check if the AMC menu is called
	local thisID = self:GetID();
	if ( thisID == AMC_AtlasMainMenuIndex ) then
		-- check if the player is in a atlas major city and get its name
		local MapName = FAMC_GetActual_LC_MapName();
		if ( MapName ) then
			-- find the menu index of the actual city and activate it (like the original function)
			local idx = 0;
			local v;
			for _,v in pairs(ATLAS_DROPDOWNS[thisID]) do
				idx = idx + 1;
				if ( AtlasMaps[v].ZoneName[1] == MapName ) then
					L_UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, thisID);
					Atlas.db.profile.options.dropdowns.module = thisID;
					Atlas.db.profile.options.dropdowns.zone = idx;
					AtlasFrameDropDown_OnShow();
					Atlas_Refresh();
					return;
				end
			end
		end
	end

	-- no AMC menu entry, so call original function
	AMC_AtlasFrameDropDownType_OnClick_Orig(self);
end

-- ***********************************************************************************************************************************
-- sub-routines for the update of the map frame
-- ***********************************************************************************************************************************

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- sub-sub-routines for FAMC_UpdateMapFrame()
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- insert the actual city map image in the AtlasMap-Frame
local function FAMC_InsertCityMap(city, small)
	if ( small ) then
		AtlasMapSmall:SetTexture("");
	else
		AtlasMap:SetTexture("");
	end

	-- tiles size scaled to 512 pixel map hight (AtlasMap size) -> 769 pixel width of whole map
	-- original size: 256x256 (233x155) = 1001x667 -> 197x197 (178x118) = 769x512
	local tsize = 197;
	-- tile size with removed right border
	local tsizex = 178;
	-- tile size with removed lower border
	local tsizey = 118;

	-- number of pixel to skip in x direction
	local xskip1 = math.floor(AtlasMajorCities_XMapCoordSkip[city.."1"] / 100.0 * 769 + 0.5);
	local xskip2 = math.floor(AtlasMajorCities_XMapCoordSkip[city.."2"] / 100.0 * 769 + 0.5);

	local idx;
	for idx = 1, 12 do
		local tex;
		if ( small ) then
			tex = getglobal("AMC_Atlas_MapSmall_"..idx);
			if ( not tex ) then tex = AtlasFrameSmall:CreateTexture("AMC_Atlas_MapSmall_"..idx, "BACKGROUND"); end
		else
			tex = getglobal("AMC_Atlas_Map_"..idx);
			if ( not tex ) then tex = AtlasFrame:CreateTexture("AMC_Atlas_Map_"..idx, "BACKGROUND"); end
		end

		-- set the tile size, include xskip
		if ( idx == 1 or idx == 5 or idx == 9 ) then
			if ( tsize < xskip1 ) then tex:SetWidth(1);
					      else tex:SetWidth(tsize - xskip1);
			end
		end
		if ( idx == 2 or idx == 6 or idx == 10 ) then
			if ( tsize < xskip1 ) then tex:SetWidth(tsize + tsize - xskip1);
					      else tex:SetWidth(tsize);
			end
		end
		if ( idx == 3 or idx == 7 or idx == 11 ) then
			if ( tsizex < xskip2 ) then tex:SetWidth(tsize + tsizex - xskip2);
					       else tex:SetWidth(tsize);
			end
		end
		if ( idx == 4 or idx == 8 or idx == 12 ) then
			if ( tsizex < xskip2 ) then tex:SetWidth(1);
					       else tex:SetWidth(tsizex - xskip2);
			end
		end
		if ( idx > 8 ) then tex:SetHeight(tsizey);
			       else tex:SetHeight(tsize);
		end

		-- set position of tile, include xskip
		local int, flt = math.modf((idx - 0.97) / 4.0);
		flt = math.floor(flt * 4.0 + 0.5);
		local xpos = flt * tsize - xskip1;
		if ( xpos < 0 ) then xpos = 0; end
		local ypos = int * tsize;
		if ( small ) then
			tex:SetPoint("TOPLEFT", "AtlasFrameSmall", "TOPLEFT", 18 + xpos, -84 - ypos);
		else
			tex:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18 + xpos, -84 - ypos);
		end

		-- set region for tiles, include xskip and border
		local xstart = 0.0;
		local xend = 1.0;
		local yend = 1.0;
		if ( idx == 1 or idx == 5 or idx == 9 ) then
			if ( tsize < xskip1 ) then xstart = 0.0;
					      else xstart = xskip1 / tsize;
			end
		end
		if ( idx == 2 or idx == 6 or idx == 10 ) then
			if ( tsize < xskip1 ) then xstart = (xskip1 - tsize) / tsize;
					      else xstart = 0.0;
			end
		end
		if ( idx == 3 or idx == 7 or idx == 11 ) then
			if ( tsizex < xskip2 ) then xend = (tsize + tsizex - xskip2) / tsize;
					       else xend = 1.0;
			end
		end
		if ( idx == 4 or idx == 8 or idx == 12 ) then
			if ( tsizex < xskip2 ) then xend = 0.0;
					       else xend = (tsizex - xskip2) / tsize;
			end
		end
		if ( idx > 8 ) then yend = tsizey / tsize; end
		tex:SetTexCoord(xstart, xend, 0.0, yend);

		-- insert image
		tex:SetTexture(AMC_cityMapPath[city]..idx);
	end
end

-- clean the AtlasMap-Frame to show the map display of Atlas
local function FAMC_CleanOldCityMap(small)
	local numFrames;
	if ( small ) then
		if ( AMC_NumFramesSmall == 0 ) then return; end
		numFrames = AMC_NumFramesSmall;
	else
		if ( AMC_NumFrames == 0 ) then return; end
		numFrames = AMC_NumFrames;
	end

	local mapframe, maplabel, idx;
	for idx = 1, numFrames do
		if ( small ) then
			mapframe = getglobal("AMC_Atlas_FrameSmall"..idx);
		else
			mapframe = getglobal("AMC_Atlas_Frame"..idx);
		end
		mapframe:Hide();
		mapframe:ClearAllPoints();

		if ( small ) then
			maplabel = getglobal("AMC_Atlas_ImageSmall"..idx);
		else
			maplabel = getglobal("AMC_Atlas_Image"..idx);
		end
		if ( maplabel ) then maplabel:SetTexture(""); end

		if ( small ) then
			maplabel = getglobal("AMC_Atlas_LabelSmall"..idx);
		else
			maplabel = getglobal("AMC_Atlas_Label"..idx);
		end
		if ( maplabel ) then maplabel:SetText(""); end
	end
	if ( small ) then
		AMC_NumFramesSmall = 0;
	else
		AMC_NumFrames = 0;
	end
	AtlasMajorCities_ShownCity = "";
end

-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

-- update the map display of Atlas
local function FAMC_UpdateMapFrame()
	-- get city name
	local zoneID = ATLAS_DROPDOWNS[Atlas.db.profile.options.dropdowns.module][Atlas.db.profile.options.dropdowns.zone];
	local city, key, val;
	for key, val in pairs(AMC_myDataKeys) do
		if ( val == zoneID ) then city = key; end
	end

	-- update the map display
	if ( city ) then
		-- use internal maps -> empty provided map
		FAMC_InsertCityMap(city, true);
		FAMC_InsertCityMap(city);
	else
		-- clear internal maps -> use provided map
		local idx;
		for idx = 1, 12 do
			local tex;
			tex = getglobal("AMC_Atlas_MapSmall_"..idx);
			if ( tex ) then tex:ClearAllPoints(); tex:SetTexture(""); end
			tex = getglobal("AMC_Atlas_Map_"..idx);
			if ( tex ) then tex:ClearAllPoints(); tex:SetTexture(""); end
		end
	end

	-- remove labels and images of old map
	FAMC_CleanOldCityMap(true);
	FAMC_CleanOldCityMap();
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- sub-sub-routines for FAMC_SetMapLabels()
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- create a label texture or string to insert in the label frame
local function FAMC_SetupLabelFrame(label, mapframe, small)
	local maplabel;
	if ( string.sub(label,11) == "@" ) then  -- (the label starts behind the color string)
		if ( small ) then
			maplabel = getglobal("AMC_Atlas_ImageSmall"..AMC_NumFramesSmall);
		else
			maplabel = getglobal("AMC_Atlas_Image"..AMC_NumFrames);
		end
		if ( not maplabel ) then
			if ( small ) then
				maplabel = mapframe:CreateTexture("AMC_Atlas_ImageSmall"..AMC_NumFramesSmall, "BACKGROUND")
			else
				maplabel = mapframe:CreateTexture("AMC_Atlas_Image"..AMC_NumFrames, "BACKGROUND")
			end
			maplabel:SetWidth(15);
			maplabel:SetHeight(15);
			maplabel:SetPoint("CENTER", mapframe, "CENTER", 0, 0);
		end
	else
		if ( small ) then
			maplabel = getglobal("AMC_Atlas_LabelSmall"..AMC_NumFramesSmall);
		else
			maplabel = getglobal("AMC_Atlas_Label"..AMC_NumFrames);
		end
		if ( not maplabel ) then
			if ( small ) then
				maplabel = mapframe:CreateFontString("AMC_Atlas_LabelSmall"..AMC_NumFramesSmall, "MEDIUM", "SystemFont_Outline");
			else
				maplabel = mapframe:CreateFontString("AMC_Atlas_Label"..AMC_NumFrames, "MEDIUM", "SystemFont_Outline");
			end
			maplabel:SetPoint("CENTER", mapframe, "CENTER", 0, 0);
		end
	end
	return maplabel;
end

-- setup a static label frame menu
local function FAMC_DisableMovableLabel(mapframe)
	if ( AtlasMajorCities_LabelAtPos == 1 ) then
		mapframe:SetScript("OnMouseDown", function(self,button)
			if ( button == "RightButton" ) then
				local menu = AtlasMajorCities_Label_Menu(self);
				if ( menu ) then
					local AMC_Menu = CreateFrame("Frame","AMC_Menu",UIParent,"UIDropDownMenuTemplate");
					-- Make the menu appear at the cursor: 
					EasyMenu(menu, AMC_Menu, "cursor", 0 , 0, "MENU");
				end
			end
		end)
	else
		mapframe:SetScript("OnMouseDown",nil);
	end
	mapframe:SetScript("OnMouseUp",nil);
	mapframe:SetScript("OnHide",nil)
	mapframe:SetMovable(false);
end

-- setup a movable label frame
local function FAMC_AllowMovableLabel(mapframe)
	mapframe:SetMovable(true);
	mapframe:SetScript("OnMouseDown", function(self,button)
		if ( (button == "LeftButton") and not self.isMoving ) then
			local x, y;
			_, _, _, x, y = self:GetPoint(1);
			self.x1 = math.floor(x+0.5);
			self.y1 = math.floor(y+0.5);
			self:StartMoving();
			_, _, _, x, y = self:GetPoint(1);
			self.x2 = math.floor(x+0.5);
			self.y2 = math.floor(y+0.5);
			self.isMoving = true;
		end
	end)
	mapframe:SetScript("OnMouseUp", function(self,button)
		if ( (button == "LeftButton") and self.isMoving ) then
			local x, y;
			_, _, _, x, y = self:GetPoint(1);
			self.x3 = math.floor(x+0.5);
			self.y3 = math.floor(y+0.5);
			self:StopMovingOrSizing();
			self:SetUserPlaced(false);
			self.isMoving = false;
			AtlasMajorCities_Label_SetNewPos(self);
			self:ClearAllPoints();
			self:SetPoint("CENTER", AtlasMap, "TOPLEFT", self.x1, self.y1);
		end
	end)
	mapframe:SetScript("OnHide", function(self,button)
		if ( self.isMoving ) then
			self:StopMovingOrSizing();
			self:SetUserPlaced(false);
			self.isMoving = false;
			self:ClearAllPoints();
			self:SetPoint("CENTER", AtlasMap, "TOPLEFT", self.x1, self.y1);
		end
	end)
end

-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

-- set the labels for the actual map
local function FAMC_SetMapLabels(label, x, y, id, small)
	if ( small ) then
		AMC_NumFramesSmall = AMC_NumFramesSmall + 1;
	else
		AMC_NumFrames = AMC_NumFrames + 1;
	end

	-- get or create next label frame at the map
	local mapframe;
	if ( small ) then
		mapframe = getglobal("AMC_Atlas_FrameSmall"..AMC_NumFramesSmall);
		if ( not mapframe ) then
			mapframe = CreateFrame("FRAME", "AMC_Atlas_FrameSmall"..AMC_NumFramesSmall, AtlasFrameSmall);
		end
	else
		mapframe = getglobal("AMC_Atlas_Frame"..AMC_NumFrames);
		if ( not mapframe ) then
			mapframe = CreateFrame("FRAME", "AMC_Atlas_Frame"..AMC_NumFrames, AtlasFrame);
		end
	end

	-- create label object
	local maplabel = FAMC_SetupLabelFrame(label, mapframe, small);

	-- compute and set position of frame object at the map
	FAMC_SetMapFramePosition(x, y, mapframe, small);

	mapframe:EnableMouse(true);
	mapframe:SetID(tonumber(id));

	-- set letter box icon or label text and frame size
	if ( string.sub(label,11) == "@" ) then  -- (the label start behind the color string)
		maplabel:SetTexture("Interface\\Minimap\\Tracking\\Mailbox");
		mapframe:SetWidth(15);
		mapframe:SetHeight(15);

		FAMC_DisableMovableLabel(mapframe);
	else
		maplabel:SetText(label);
		mapframe:SetWidth(maplabel:GetWidth());
		mapframe:SetHeight(maplabel:GetHeight());

		mapframe:SetScript("OnEnter",AtlasMajorCities_Label_ShowTT);
		mapframe:SetScript("OnLeave",AtlasMajorCities_Label_HideTT);

		if ( (AtlasMajorCities_LabelAtPos == -1) and not small ) then
			FAMC_AllowMovableLabel(mapframe);
		else
			FAMC_DisableMovableLabel(mapframe);
		end
	end
	mapframe:Show();
end

-- ***********************************************************************************************************************************
-- sub-routine to show a tooltip at the map labels
-- ***********************************************************************************************************************************

-- give tooltip an opaque background
local function FAMC_OpaqueTTBG()
	local TT_tex = getglobal("AMC_GameTooltip_BG");
	if ( not TT_tex ) then
		TT_tex = GameTooltip:CreateTexture("AMC_GameTooltip_BG", "BACKGROUND");
	end
	TT_tex:SetTexture([[Interface\ChatFrame\ChatFrameBackground]]);
	TT_tex:SetPoint("TOPLEFT",GameTooltip,"TOPLEFT",4,-5);
	TT_tex:SetPoint("BOTTOMRIGHT",GameTooltip,"BOTTOMRIGHT",-4,5);
	TT_tex:SetVertexColor(0.0, 0.0, 0.0);
end

-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

function AtlasMajorCities_Label_ShowTT(self)
	local ID = self:GetID();
	local city = AtlasMajorCities_ShownCity;
	FAMC_SetDBTables();

	-- get the shop
	local slist;
	if ( AMC_Pbase and AMC_Pbase[city] ) then slist = AMC_Pbase[city][ID + 1000000]; end
	if ( not slist ) then slist = AMC_DBbase[city][ID]; end
	local zone = "Zone"..slist.Zone;

	-- get shop color
	local TT_color = AtlasMajorCities_ZoneColors[city][zone];

	-- get the zone of the shop
	local TT_zone;
	if ( AMC_Pzone and AMC_Pzone[city.."-"..zone] )   then TT_zone =  "=- "..AMC_Pzone[city.."-"..zone].." -="; end
	if ( not TT_zone and AMC_DBzone[city.."-"..zone]) then TT_zone = "=- "..AMC_DBzone[city.."-"..zone].." -="; end

	-- get shop title
	local shop = string.sub(tostring(ID + 1000000),2);
	local TT_shop = AtlasMajorCities_GetShopTitleText(slist.sID, city, shop);

	-- add zone and shop title
	local showTT = false;
	if ( TT_shop ) then
		showTT = true;
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
		if ( TT_zone ) then GameTooltip:SetText(TT_color..TT_zone); end
		GameTooltip:AddLine(TT_color..TT_shop);
	end

	-- get and add the NPCs
	local skey, sval;
	for skey, sval in pairs(slist) do
		if ( type(skey) == "number" ) then
			local TT_npc = AtlasMajorCities_GetNPCText(sval);
			if ( not showTT ) then
				showTT = true;
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
				if ( TT_zone ) then GameTooltip:SetText(TT_color..TT_zone); end
			end
			if ( TT_npc ) then
				GameTooltip:AddLine(TT_color..TT_npc);
			end
		end
	end

	-- set background and display the tooltip
	if ( showTT ) then
		GameTooltip:SetScale(0.8);
		-- give tooltip an opaque background
		FAMC_OpaqueTTBG();
		GameTooltip:Show();
	end
end

function AtlasMajorCities_Label_HideTT(self)
	GameTooltip:Hide();
	local TT_tex = getglobal("AMC_GameTooltip_BG");
	if ( TT_tex ) then
		TT_tex:SetTexture(nil);
		TT_tex:ClearAllPoints();
	end
	GameTooltip:SetScale(1.0);
end

-- ***********************************************************************************************************************************
-- sub-routines for the list creation
-- ***********************************************************************************************************************************

-- define the sort order for zone, and shop
function AtlasMajorCities_CompareEntry(a, b)
	local sa, sb;
	if ( a.Name ) then sa = a.Name; end
	if ( b.Name ) then sb = b.Name; end
	if ( a.ID ) then sa = a.ID; end
	if ( b.ID ) then sb = b.ID; end
	if ( a.Label ) then sa = a.Label; end
	if ( b.Label ) then sb = b.Label; end

	-- set high number if ID="000000" (sort no position shop to bottom)
	if ( sa == "000000" ) then sa = "999999"; end
	if ( sb == "000000" ) then sb = "999999"; end

	-- check if both variables are defined
	if ( not sa and not sb ) then sa = "0"; sb = "1";
	elseif ( not sa )        then sa = "0";
	elseif ( not sb )        then sb = "0";
	end

	-- change variables, that strings are sorted to the top
	na = tonumber(sa); nb = tonumber(sb);
	if ( na and nb ) then sa = na; sb = nb;
		elseif ( na )    then sb = "."..sb;
	elseif ( nb )    then sa = "."..sa;
	end

	return sa < sb;
end

-- create the merged and sorted city list of all shops
local function FAMC_createMergedCityList()
	local city = AtlasMajorCities_ShownCity;
	local iclist = AMC_DBbase[city];
	local pclist = {}; if ( AMC_Pbase and AMC_Pbase[city] ) then pclist = AMC_Pbase[city]; end

	-- create city list
	local clist = {};
	local zid;
	for zid = 0, 10 do
		local zlist = {};

		local iskey, pskey, slist;
		for iskey, slist in pairs(iclist) do
			if ( slist.Zone == zid ) then
				-- check if this shop is in AMC_Pbase
				pskey = iskey + 1000000;
				if ( pclist[pskey] ) then slist = pclist[pskey]; end
				-- check if this shop entry was deleted (empty list)
				if ( next(slist) ) then table.insert(zlist, slist); end
			end
		end

		-- include added entries from AMC_Pbase
		if ( next(pclist) and AtlasMajorCities_Adds[city]) then
			for _, pskey in pairs(AtlasMajorCities_Adds[city]) do
				slist = pclist[pskey];
				if ( slist.Zone == zid ) then
					table.insert(zlist, slist);
				end
			end
		end

		-- check if this zone list is not empty
		if ( next(zlist) ) then
			zlist.Name = "Zone"..zid;
			table.sort(zlist, AtlasMajorCities_CompareEntry);
			table.insert(clist, zlist);
		end
	end
	table.sort(clist, AtlasMajorCities_CompareEntry);

	return clist;
end

-- compare shop entries with the Atlas search string
local function FAMC_lineMatches(line, search_text)
	if ( not line ) then return false; end
	local foundMatch = false;
	if (string.len(search_text) == 0) then
		foundMatch = true;
	else
		if ( string.gmatch ) then 
			if ( string.gmatch(string.lower(line), search_text)() ) then
				foundMatch = true;
			end
		else
			if ( string.gfind(string.lower(line), search_text)() ) then
				foundMatch = true;
			end
		end
	end
	return foundMatch;
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- sub-sub-routines for FAMC_AddOutputLines()
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- fill labelSpace with spaces up to the size of labelText
local function FAMC_GetEmptyLabelString(labelText)
	AMC_FrameLabel:SetText(labelText);
	local labelLen = AMC_FrameLabel:GetStringWidth();

	local labelSpace = "   ";
	AMC_FrameLabel:SetText(labelSpace);
	length = AMC_FrameLabel:GetStringWidth();
	while ( length < labelLen ) do
		AMC_FrameLabel:SetText(labelSpace.." ");
		length = AMC_FrameLabel:GetStringWidth();
		if ( length < labelLen ) then labelSpace = labelSpace.." "; end
	end

	return labelSpace;
end

-- get max. length of label text (dataShow) to fit in the Atlas list (AMC_TableMaxWidth)
local function FAMC_CutTextAtFrameLength(labelText, dataText)
	local nLetters = string.len(labelText);
	local dataShow = dataText;
	AMC_FrameLabel:SetText(labelText..dataShow);
	local length = AMC_FrameLabel:GetStringWidth();

	while ( length > AMC_TableMaxWidth ) do
		local index = string.len(dataShow) - string.find(string.reverse(dataShow), " ");
		-- ignore spaces of the labelText
		if ( index > nLetters ) then
			dataShow = string.sub(dataShow, 1, index);
			AMC_FrameLabel:SetText(labelText..dataShow);
			length = AMC_FrameLabel:GetStringWidth();
		else
			length = 0;
		end
	end

	return dataShow;
end

-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

-- create an entry shown in the Atlas shop list
-- (split up long lines and insert rest as new indented line)
local function FAMC_AddOutputLines(shopEntry, labelData, labelName, search_text, color, new, n)
	local dataText = labelData;
	local indent = "";

	local labelText = " "..labelName..") ";

	-- fill labelSpace with spaces up to the size of labelText
	local labelSpace = FAMC_GetEmptyLabelString(labelText);

	-- wrap text of the label entry in the Atlas list
	while ( dataText and dataText ~= "" ) do
		-- get max. length of label text (dataShow) to fit in the Atlas list
		local dataShow = FAMC_CutTextAtFrameLength(labelText, dataText);

		-- remove text in dataShow from dataText
		if ( dataText ~= "" ) then
			if ( dataText ~= dataShow ) then
				dataText = string.sub(dataText, string.len(dataShow) + 1);
				labelText = " "..labelName..") "..indent;
			else
				dataText = "";
			end
		end

		-- create entry for the Atlas list
		if ( shopEntry > 1 ) then
			if ( FAMC_lineMatches(dataShow, search_text) ) then
				new[n] = { labelSpace..indent..color..dataShow };
			else
				new[n] = { labelSpace..indent.."|c88888888"..dataShow };
			end
		else
			shopEntry = 2;
			if ( FAMC_lineMatches(dataShow, search_text) ) then
				new[n] = { " "..color..labelName..") "..indent..dataShow };
			else
				new[n] = { " ".."|c88888888"..labelName..") "..indent..dataShow };
			end
		end
		n = n + 1;
		indent = "    ";
	end
	return n;
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- sub-sub-routines for FAMC_AddShopToAtlasList()
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local function FAMC_GetZoneName(city, zone)
	local name;
	if ( AMC_Pzone and  AMC_Pzone[city.."-"..zone] ) then name =  "=- "..AMC_Pzone[city.."-"..zone].." -="; end
	if ( not name and AMC_DBzone[city.."-"..zone] )  then name = "=- "..AMC_DBzone[city.."-"..zone].." -="; end
	if ( AMC_Pzone and AMC_Pzone[city.."-"..zone] == "deleted" ) then name = ""; end
	if ( not name ) then name = ""; end
	return name;
end

local function FAMC_GetLabelPos(PosX, PosY, shop, sID)
	local xpos, ypos;
	if ( AtlasMajorCities_LabelAtPos <= 0 ) then
		xpos = PosX;
		ypos = PosY;
	elseif ( (AtlasMajorCities_LabelAtPos == 1) and (shop ~= "000000") ) then
		xpos = tonumber(string.sub(shop,1,3)) / 10.0;
		ypos = tonumber(string.sub(shop,4,6)) / 10.0;
	elseif ( (AtlasMajorCities_LabelAtPos == 2) and sID ) then
		local sid = sID;
		sid = string.sub(sid,string.len(sid)-5);
		xpos = tonumber(string.sub(sid,1,3)) / 10.0;
		ypos = tonumber(string.sub(sid,4,6)) / 10.0;
	end
	return xpos, ypos;
end

-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

-- check and add this shop to the Atlas list (new)
local function FAMC_AddShopToAtlasList(islist, search_text, shownAreaTitle, addSeparator, new, n)
	local city = AtlasMajorCities_ShownCity;
	local zone = "Zone"..islist.Zone;
	local color = AtlasMajorCities_ZoneColors[city][zone];
	local shop = islist.ID;
	local title = AtlasMajorCities_GetShopTitleText(islist.sID, city, shop);

	-- check if shop entries match the search string
	local foundMatch = false;
	if ( (search_text == "") or (title and FAMC_lineMatches(title, search_text)) ) then
		foundMatch = true;
	else
		local skey, sval;
		for skey, sval in pairs(islist) do
			if ( type(skey) == "number" ) then
				local npc = AtlasMajorCities_GetNPCText(sval);
				if ( FAMC_lineMatches(npc, search_text) ) then
					foundMatch = true;
					break;
				end
			end
		end
	end

	-- add the list entries of the shop
	if ( foundMatch ) then
		if ( not shownAreaTitle ) then
			local areaName = FAMC_GetZoneName(city, zone);
			new[n] = { color..areaName };
			n = n + 1;
			shownAreaTitle = true;
		end

		-- get the label and add its position to the map overlay table
		local labelName;
		if ( islist.Label ) then
			labelName = islist.Label;

			-- add the labels to the map
			local xpos, ypos = FAMC_GetLabelPos(islist.PosX, islist.PosY, shop, islist.sID);
			if ( xpos and ypos ) then
				FAMC_SetMapLabels(color..labelName, xpos, ypos, shop, true);
				FAMC_SetMapLabels(color..labelName, xpos, ypos, shop);
			end
		else
			labelName = "-";
		end

		-- insert shop title
		local shopEntry = 0;
		if ( title ) then
			shopEntry = 1;
			n = FAMC_AddOutputLines(shopEntry, title, labelName, search_text, color, new, n);
			addSeparator = true;
		end

		-- add the NPCs of this shop
		local skey, sval;
		for skey, sval in pairs(islist) do
			if ( type(skey) == "number" ) then
				local npc = AtlasMajorCities_GetNPCText(sval);
				shopEntry = shopEntry + 1;
				-- create an entry shown in the Atlas shop list
				n = FAMC_AddOutputLines(shopEntry, npc, labelName, search_text, color, new, n);
				addSeparator = true;
			end
		end
	end

	return n, shownAreaTitle, addSeparator;
end

-- ***********************************************************************************************************************************
-- sub-routines for OnUpdate and OnEvent
-- ***********************************************************************************************************************************

-- set the player arrow on the Atlas map
local AMC_AtlasFrame_IsSmall = false;
local function FAMC_OnUpdate(self, elapsed)
	-- check for change of AtlasFrame to AtlasFrameSmall
	if ( (AMC_AtlasFrame_IsSmall and not ATLAS_SMALLFRAME_SELECTED) or (not AMC_AtlasFrame_IsSmall and ATLAS_SMALLFRAME_SELECTED) ) then
		AMC_AtlasFrame_IsSmall = ATLAS_SMALLFRAME_SELECTED;
	end

	if ( AtlasMajorCities_EditMode ) then
		AtlasMajorCities_Edit_OnUpdate(self, elapsed);
	end

	if ( AMC_AtlasFrame_IsSmall ) then
		FAMC_SetPlayerArrow(true);
	else
		FAMC_SetPlayerArrow();
	end
end

-- start initialization of the addon
local function FAMC_OnEvent(self, event, addon)
	if ( (event == "ADDON_LOADED") and (addon == AMC_thisAddonName) ) then
		self:UnregisterEvent("ADDON_LOADED");
		FAMC_OnLoad(self);
		if ( AtlasMajorCities_EditMode ) then
			AtlasMajorCities_Edit_OnLoad(self);
		end
		self:SetScript("OnUpdate", FAMC_OnUpdate);
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- definition of the AMC-Frame
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- define the AMC main frame (invisible)
local AtlasMajorCities_Frame = CreateFrame("Frame", "AtlasMajorCities_Frame");
AtlasMajorCities_Frame:RegisterEvent("ADDON_LOADED");
AtlasMajorCities_Frame:SetScript("OnEvent", FAMC_OnEvent);

-- ###################################################################################################################################
-- main routine, called from Atlas
-- ###################################################################################################################################
-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

function AtlasMajorCities_SearchCall(data, text)
	local new = {};

	FAMC_UpdateMapFrame();

	if ( not data.AMCName ) then
		-- hide pull down menu with display options for the labels in edit mode
		if ( AtlasMajorCities_EditMode and AMC_LabelMode_TextFrame and AMC_LabelMode_PullDown ) then
			AMC_LabelMode_TextFrame:Hide();
			AMC_LabelMode_PullDown:Hide();
		end

		if ( text == "" ) then
			new = data;
		else
			new = AtlasSimpleSearch(data, text);
		end
	else
		-- show pull down menu with display options for the labels in edit mode
		if ( AtlasMajorCities_EditMode and AMC_LabelMode_TextFrame and AMC_LabelMode_PullDown ) then
			AMC_LabelMode_TextFrame:Show();
			AMC_LabelMode_PullDown:Show();
		end

		local search_text = string.lower(text);
		local n = 1;
		local addSeparator = false;
		local shownAreaTitle = false;

		-- set basic switches and input DBs
		FAMC_SetDBTables();

		-- set global variable with the city name used in the following functions
		AtlasMajorCities_ShownCity = data.AMCName;

		-- create the merged and sorted city list of all shops
		local clist = FAMC_createMergedCityList();

		-- assign zone list
		local zlist;
		for _, zlist in pairs(clist) do
			addSeparator = false;
			shownAreaTitle = false;

			-- assign shop list
			local zkey, slist;
			for zkey, slist in pairs(zlist) do
				if ( type(zkey) == "number" ) then
					-- check and add this shop to the Atlas list
					n, shownAreaTitle, addSeparator = FAMC_AddShopToAtlasList(slist, search_text, shownAreaTitle, addSeparator, new, n);
				end
			end
			if ( addSeparator ) then
				new[n] = { " " };
				n = n + 1;
			end
		end
	end

	return new;
end

-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
