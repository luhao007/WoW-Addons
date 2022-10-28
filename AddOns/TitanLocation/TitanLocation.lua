--[[
-- **************************************************************************
-- * TitanLocation.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************
--]]
-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_LOCATION_ID = "Location";
local OFFSET_X = 0.0022  --  0.0022;
local OFFSET_Y = -0.0262  --  -0.0262;
local cachedX = 0;
local cachedY = 0;
local updateTable = {TITAN_LOCATION_ID, TITAN_PANEL_UPDATE_BUTTON};
-- ******************************** Variables *******************************
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true);
local AceTimer = LibStub("AceTimer-3.0");
local LocationTimer = nil;

-- ******************************** Functions *******************************

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
--]]
function TitanPanelLocationButton_OnLoad(self)
	self.registry = {
		id = TITAN_LOCATION_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_LOCATION_MENU_TEXT"],
		buttonTextFunction = "TitanPanelLocationButton_GetButtonText",
		tooltipTitle = L["TITAN_LOCATION_TOOLTIP"],
		tooltipTextFunction = "TitanPanelLocationButton_GetTooltipText",
		icon = "Interface\\AddOns\\TitanLocation\\TitanLocation",
		iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			ShowZoneText = 1,
			ShowCoordsText = true,
			ShowCoordsOnMap = false,
			ShowCursorOnMap = false,
			ShowLocOnMiniMap = 1,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			CoordsFormat = L["TITAN_LOCATION_FORMAT"],
			UpdateWorldmap = false,
			DisplayOnRightSide = false,
		}
	};

	self:RegisterEvent("ZONE_CHANGED");
	self:RegisterEvent("ZONE_CHANGED_INDOORS");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");

	TitanPanelLocation_CreateMapFrames();
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_OnShow()
-- DESC : Display button when plugin is visible
-- **************************************************************************
--]]
function TitanPanelLocationButton_OnShow()
	TitanPanelLocation_HandleUpdater();
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_OnHide()
-- DESC : Destroy repeating timer when plugin is hidden
-- **************************************************************************
--]]
function TitanPanelLocationButton_OnHide()
	AceTimer.CancelTimer("TitanPanelLocation", LocationTimer, true)
	LocationTimer = nil;
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_GetButtonText(id)
-- DESC : Calculate coordinates and then display data on button
-- VARS : id = button ID
-- **************************************************************************
--]]
function TitanPanelLocationButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local locationText = ""

	-- Coordinates text, if requested
	if (TitanGetVar(TITAN_LOCATION_ID, "ShowCoordsText")) then
		button.px, button.py = TitanPanelGetPlayerMapPosition();
		-- cache coordinates for update checking later on
		cachedX = button.px;
		cachedY = button.py;
		if button.px == nil then button.px = 0 end
		if button.py == nil then button.py = 0 end

		if button.px == 0 and button.py == 0 then
			locationText = "";
		else
		locationText = format(TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat"), 100 * button.px, 100 * button.py)
		end
	else
		locationText = "";
	end

	-- Zone text, if requested
	if (TitanGetVar(TITAN_LOCATION_ID, "ShowZoneText")) then
		if (TitanUtils_ToString(button.subZoneText) == '') then
			if (button.zoneText == '') then
				local _
-- DF change of API
--				_, _, button.zoneText = C_Map.GetMapInfo(C_Map.GetBestMapUnit("player"));
				_, _, button.zoneText = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"));
			end
			locationText = TitanUtils_ToString(button.zoneText)..' '..locationText;
		else
			locationText = TitanUtils_ToString(button.subZoneText)..' '..locationText;
		end
	else
		if button.px == 0 and button.py == 0 then
			locationText = L["TITAN_LOCATION_NO_COORDS"];
		end
	end

	-- Color per type of zone (friendly, contested, hostile)
	local locationRichText;
	if (TitanGetVar(TITAN_LOCATION_ID, "ShowColoredText")) then
		if (TitanPanelLocationButton.isArena) then
			locationRichText = TitanUtils_GetRedText(locationText);
		elseif (TitanPanelLocationButton.pvpType == "friendly") then
			locationRichText = TitanUtils_GetGreenText(locationText);
		elseif (TitanPanelLocationButton.pvpType == "hostile") then
			locationRichText = TitanUtils_GetRedText(locationText);
		elseif (TitanPanelLocationButton.pvpType == "contested") then
			locationRichText = TitanUtils_GetNormalText(locationText);
		else
			locationRichText = TitanUtils_GetNormalText(locationText);
		end
	else
		locationRichText = TitanUtils_GetHighlightText(locationText);
	end

	return L["TITAN_LOCATION_BUTTON_LABEL"], locationRichText;
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
--]]
function TitanPanelLocationButton_GetTooltipText()
	local pvpInfoRichText;

	pvpInfoRichText = "";
	if (TitanPanelLocationButton.pvpType == "sanctuary") then
		pvpInfoRichText = TitanUtils_GetGreenText(SANCTUARY_TERRITORY);
	elseif (TitanPanelLocationButton.pvpType == "arena") then
		TitanPanelLocationButton.subZoneText = TitanUtils_GetRedText(TitanPanelLocationButton.subZoneText);
		pvpInfoRichText = TitanUtils_GetRedText(CONTESTED_TERRITORY);
		elseif (TitanPanelLocationButton.pvpType == "friendly") then
		pvpInfoRichText = TitanUtils_GetGreenText(format(FACTION_CONTROLLED_TERRITORY, TitanPanelLocationButton.factionName));
	elseif (TitanPanelLocationButton.pvpType == "hostile") then
		pvpInfoRichText = TitanUtils_GetRedText(format(FACTION_CONTROLLED_TERRITORY, TitanPanelLocationButton.factionName));
	elseif (TitanPanelLocationButton.pvpType == "contested") then
		pvpInfoRichText = TitanUtils_GetRedText(CONTESTED_TERRITORY);
	else
		pvpInfoRichText = ""
	end

	return ""..
		L["TITAN_LOCATION_TOOLTIP_ZONE"].."\t"..TitanUtils_GetHighlightText(TitanPanelLocationButton.zoneText).."\n"..
		TitanUtils_Ternary((TitanPanelLocationButton.subZoneText == ""), "", L["TITAN_LOCATION_TOOLTIP_SUBZONE"].."\t"..TitanUtils_GetHighlightText(TitanPanelLocationButton.subZoneText).."\n")..
		TitanUtils_Ternary((pvpInfoRichText == ""), "", L["TITAN_LOCATION_TOOLTIP_PVPINFO"].."\t"..pvpInfoRichText.."\n")..
		"\n"..
		TitanUtils_GetHighlightText(L["TITAN_LOCATION_TOOLTIP_HOMELOCATION"]).."\n"..
		L["TITAN_LOCATION_TOOLTIP_INN"].."\t"..TitanUtils_GetHighlightText(GetBindLocation()).."\n"..
		TitanUtils_GetGreenText(L["TITAN_LOCATION_TOOLTIP_HINTS_1"]).."\n"..
		TitanUtils_GetGreenText(L["TITAN_LOCATION_TOOLTIP_HINTS_2"]);
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_OnEvent()
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
--]]
function TitanPanelLocationButton_OnEvent(self, event, ...)
-- DF TODO See if we can turn off zone on minimap
--[=[
	if event == "PLAYER_ENTERING_WORLD" then
		if not TitanGetVar(TITAN_LOCATION_ID, "ShowLocOnMiniMap") and MinimapBorderTop and MinimapBorderTop:IsShown() then
			TitanPanelLocationButton_LocOnMiniMap()
		end
	end
--]=]
	TitanPanelLocationButton_UpdateZoneInfo(self);
	TitanPanelPluginHandle_OnUpdate(updateTable);
	TitanPanelLocation_HandleUpdater();
--[[
	if TitanGetVar(TITAN_LOCATION_ID, "ShowLocOnMiniMap") and MinimapBorderTop:IsShown() then
		if not MinimapZoneTextButton:IsShown() then MinimapZoneTextButton:Show() end
		if not MiniMapWorldMapButton:IsShown() then MiniMapWorldMapButton:Show() end
	end
--]]
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_CheckForUpdate()
-- DESC : Function to throttle down unnecessary updates
-- **************************************************************************
--]]
function TitanPanelLocationButton_CheckForUpdate()
	local mapID = C_Map.GetBestMapForUnit("player")
	local tempx, tempy = TitanPanelGetPlayerMapPosition();
	if tempx ~= cachedX or tempy ~= cachedY then
		TitanPanelPluginHandle_OnUpdate(updateTable);
	end
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocation_HandleUpdater()
-- DESC : Check to see if you are inside an instance
-- **************************************************************************
--]]
function TitanPanelLocation_HandleUpdater()
	if TitanPanelLocationButton:IsVisible() and not LocationTimer then
		LocationTimer = AceTimer.ScheduleRepeatingTimer("TitanPanelLocation", TitanPanelLocationButton_CheckForUpdate, 0.5)
	end
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_OnClick(button)
-- DESC : Copies coordinates to chat line for shift-LeftClick
-- VARS : button = value of action
-- **************************************************************************
--]]
function TitanPanelLocationButton_OnClick(self, button)
	if (button == "LeftButton") then
		if (IsShiftKeyDown()) then
			local activeWindow = ChatEdit_GetActiveWindow();
			if ( activeWindow ) then
				local message = TitanUtils_ToString(self.zoneText).." "..
					format(TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat"), 100 * self.px, 100 * self.py);
				activeWindow:Insert(message);
			end
		else
			ToggleFrame(WorldMapFrame);
		end
	end
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_UpdateZoneInfo()
-- DESC : Update data on button
-- **************************************************************************
--]]
function TitanPanelLocationButton_UpdateZoneInfo(self)
	local _ = nil
	self.zoneText = GetZoneText();
	self.subZoneText = GetSubZoneText();
	self.pvpType, _, self.factionName = GetZonePVPInfo();
end

--[[
-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareLocationMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
--]]
function TitanPanelRightClickMenu_PrepareLocationMenu()
	local info

	-- level 2
	if TitanPanelRightClickMenu_GetDropdownLevel() == 2 then
		if TitanPanelRightClickMenu_GetDropdMenuValue() == "Options" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_OPTIONS"], TitanPanelRightClickMenu_GetDropdownLevel());
			info = {};
			info.text = L["TITAN_LOCATION_MENU_SHOW_ZONE_ON_PANEL_TEXT"];
			info.func = TitanPanelLocationButton_ToggleDisplay;
			info.checked = TitanGetVar(TITAN_LOCATION_ID, "ShowZoneText");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_LOCATION_MENU_SHOW_COORDS_ON_PANEL_TEXT"];
			info.func = function()
				TitanToggleVar(TITAN_LOCATION_ID, "ShowCoordsText");
				TitanPanelButton_UpdateButton(TITAN_LOCATION_ID);
			end
			info.checked = TitanGetVar(TITAN_LOCATION_ID, "ShowCoordsText");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
--[=[
			info = {};
			info.text = L["TITAN_LOCATION_MENU_SHOW_COORDS_ON_MAP_TEXT"];
			info.func = TitanPanelLocationButton_ToggleLocationOnMap;
			info.checked = TitanGetVar(TITAN_LOCATION_ID, "ShowCoordsOnMap");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_LOCATION_MENU_SHOW_LOC_ON_MINIMAP_TEXT"];
			info.func = function()
				TitanToggleVar(TITAN_LOCATION_ID, "ShowLocOnMiniMap");
				TitanPanelLocationButton_LocOnMiniMap()
			end
			info.checked = TitanGetVar(TITAN_LOCATION_ID, "ShowLocOnMiniMap");
			info.disabled = InCombatLockdown()
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
--]=]
			info = {};
			info.text = L["TITAN_LOCATION_MENU_UPDATE_WORLD_MAP"];
			info.func = function()
				TitanToggleVar(TITAN_LOCATION_ID, "UpdateWorldmap");
			end
			info.checked = TitanGetVar(TITAN_LOCATION_ID, "UpdateWorldmap");
			info.disabled = InCombatLockdown()
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end
		if TitanPanelRightClickMenu_GetDropdMenuValue() == "CoordFormat" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_LOCATION_FORMAT_COORD_LABEL"], TitanPanelRightClickMenu_GetDropdownLevel());
			info = {};
			info.text = L["TITAN_LOCATION_FORMAT_LABEL"];
			info.func = function()
				TitanSetVar(TITAN_LOCATION_ID, "CoordsFormat", L["TITAN_LOCATION_FORMAT"]);
				TitanPanelButton_UpdateButton(TITAN_LOCATION_ID);
			end
			info.checked = (TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat") == L["TITAN_LOCATION_FORMAT"])
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_LOCATION_FORMAT2_LABEL"];
			info.func = function()
				TitanSetVar(TITAN_LOCATION_ID, "CoordsFormat", L["TITAN_LOCATION_FORMAT2"]);
				TitanPanelButton_UpdateButton(TITAN_LOCATION_ID);
			end
			info.checked = (TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat") == L["TITAN_LOCATION_FORMAT2"])
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_LOCATION_FORMAT3_LABEL"];
			info.func = function()
				TitanSetVar(TITAN_LOCATION_ID, "CoordsFormat", L["TITAN_LOCATION_FORMAT3"]);
				TitanPanelButton_UpdateButton(TITAN_LOCATION_ID);
			end
			info.checked = (TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat") == L["TITAN_LOCATION_FORMAT3"])
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end
		return
	end

	-- level 1
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_LOCATION_ID].menuText);

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_PANEL_OPTIONS"];
	info.value = "Options"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_LOCATION_FORMAT_COORD_LABEL"];
	info.value = "CoordFormat"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_LOCATION_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_LOCATION_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_LOCATION_ID);
	TitanPanelRightClickMenu_AddToggleRightSide(TITAN_LOCATION_ID);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_LOCATION_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_ToggleDisplay()
-- DESC : Set option to show zone text
-- **************************************************************************
--]]
function TitanPanelLocationButton_ToggleDisplay()
	TitanToggleVar(TITAN_LOCATION_ID, "ShowZoneText");
	TitanPanelButton_UpdateButton(TITAN_LOCATION_ID);
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_ToggleLocationOnMap()
-- DESC : Set option to show player coordinates on map
-- **************************************************************************
--]]
function TitanPanelLocationButton_ToggleLocationOnMap()
	TitanToggleVar(TITAN_LOCATION_ID, "ShowCoordsOnMap");
	if (TitanGetVar(TITAN_LOCATION_ID, "ShowCoordsOnMap")) then
		TitanMapPlayerLocation:Show();
	else
		TitanMapPlayerLocation:Hide();
	end
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocationButton_ToggleCursorLocationOnMap()
-- DESC : Set option to show cursor coordinates on map
-- **************************************************************************
--]]
function TitanPanelLocationButton_ToggleCursorLocationOnMap()
	TitanToggleVar(TITAN_LOCATION_ID, "ShowCursorOnMap");
	if (TitanGetVar(TITAN_LOCATION_ID, "ShowCursorOnMap")) then
		TitanMapCursorLocation:Show();
	else
		TitanMapCursorLocation:Hide();
	end
end

function TitanPanelLocationButton_LocOnMiniMap()
	if TitanGetVar(TITAN_LOCATION_ID, "ShowLocOnMiniMap") then
		MinimapBorderTop:Show()
		MinimapZoneTextButton:Show()
		MiniMapWorldMapButton:Show()
	else
		MinimapBorderTop:Hide()
		MinimapZoneTextButton:Hide()
		MiniMapWorldMapButton:Hide()
	end
	-- adjust MiniMap frame if needed
	TitanPanel_AdjustFrames(false);
end

--[[
-- **************************************************************************
-- NAME : TitanMapFrame_OnUpdate()
-- DESC : Update coordinates on map
-- **************************************************************************
--]]
function TitanMapFrame_OnUpdate(self, elapsed)
	-- using :Hide / :Show prevents coords from running
	-- TitanMapFrame:Hide() -- hide parent

	-- Determine the text to show for player coords

		local cursorLocationText, playerLocationText;
		self.px, self.py = TitanPanelGetPlayerMapPosition();
		if self.px == nil then self.px = 0 end
		if self.py == nil then self.py = 0 end
		if self.px == 0 and self.py == 0 then
			playerLocationText = L["TITAN_LOCATION_NO_COORDS"]
		else
			playerLocationText = format(TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat"), 100 * self.px, 100 * self.py);
		end
		TitanMapPlayerLocation:SetText(format(L["TITAN_LOCATION_MAP_PLAYER_COORDS_TEXT"], TitanUtils_GetHighlightText(playerLocationText)));

		-- Determine the text to show for cursor coords
		local cx, cy = GetCursorPosition();

		-- use the global cursor position to confirm the cursor is over the map, but then use a normalized cursor position to account for map zooming
		local left, bottom, width, height = WorldMapFrame.ScrollContainer:GetScaledRect();
		if (cx > left and cy > bottom and cx < left + width and cy < bottom+ height) then
			cx, cy = WorldMapFrame:GetNormalizedCursorPosition();
			cx, cy = cx or 0, cy or 0;
		else
			cx, cy = 0, 0
		end

		-- per the user requested format
		cursorLocationText = format(TitanGetVar(TITAN_LOCATION_ID, "CoordsFormat"), 100 * cx, 100 * cy);
		if (TitanGetVar(TITAN_LOCATION_ID, "ShowCoordsOnMap")) then
			TitanMapCursorLocation:SetText(format(L["TITAN_LOCATION_MAP_CURSOR_COORDS_TEXT"],
				TitanUtils_GetHighlightText(cursorLocationText)));
		else
			TitanMapPlayerLocation:SetText("");
			TitanMapCursorLocation:SetText("");
		end
--[==[
print("TLoc"
.." c "..tostring(cursorLocationText).." "
.." p "..tostring(playerLocationText).." "
)
--]==]
end

--[[
-- **************************************************************************
-- NAME : TitanPanelGetPlayerMapPosition()
-- DESC : Get the player coordinates
-- VARS : x = location on x axis, y = location on y axis
-- **************************************************************************
--]]
function TitanPanelGetPlayerMapPosition()
    local mapID = C_Map.GetBestMapForUnit("player")
    if mapID == nil then
        return nil, nil
    end

    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if position == nil then
        return nil, nil
    else
    	return position:GetXY()
	end
end

--[[
-- **************************************************************************
-- NAME : TitanPanelLocation_CreateMapFrames()
-- DESC : Adds player and cursor coords to the WorldMapFrame, unless the player has CT_MapMod
-- VARS : none
-- **************************************************************************
--]]
local TPL_CMF_IsFirstTime = true;
function TitanPanelLocation_CreateMapFrames()
	if (TPL_CMF_IsFirstTime) then
		TPL_CMF_IsFirstTime = false;

		-- avoid an addon conflict
		if (_G["CT_MapMod"]) then
			return;
		end

		-- create the frame to hold the font strings, and simulate an "OnUpdate" script handler using C_Timer for efficiency
		local frame = CreateFrame("FRAME", "TitanMapFrame", WorldMapFrame.BorderFrame)
		frame:SetFrameStrata("DIALOG") -- DF need to raise the strata to be seen
		local function updateFunc()
			TitanMapFrame_OnUpdate(frame, 0.07);	-- simulating an OnUpdate call
		end
		frame:HookScript("OnShow", function()
			frame.updateTicker = frame.updateTicker or C_Timer.NewTicker(0.07, updateFunc);
		end);
		frame:HookScript("OnHide", function()
			if (frame.updateTicker) then
				frame.updateTicker:Cancel();
				frame.updateTicker = nil;
			end
		end);

		-- create the font strings and update their position based in minimizing/maximizing the main map
		local playertext = frame:CreateFontString("TitanMapPlayerLocation", "ARTWORK", "GameFontNormal");
		local cursortext = frame:CreateFontString("TitanMapCursorLocation", "ARTWORK", "GameFontNormal");
		hooksecurefunc(WorldMapFrame.BorderFrame.MaximizeMinimizeFrame, "Maximize", function()
			playertext:ClearAllPoints();
			cursortext:ClearAllPoints();
			playertext:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -10, -28)
			cursortext:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -10, -43)
--[==[
print("TLoc max"
.." p "..tostring(playertext and true or false).." "
.." c "..tostring(cursortext and true or false).." "
)
--]==]
		end);
		hooksecurefunc(WorldMapFrame.BorderFrame.MaximizeMinimizeFrame, "Minimize", function()
			playertext:ClearAllPoints();
			cursortext:ClearAllPoints();
			playertext:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -50, -5)
--			playertext:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -50, 15)
			cursortext:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", 95, -5)
--			cursortext:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", 95, 5)
--[==[
print("TLoc min"
.." p "..tostring(playertext and true or false).." "
.."  "..tostring(playertext:GetText()).." "
.."  "..tostring(frame:GetFrameStrata()).." "
.."  "..tostring(frame:GetFrameLevel()).." "
.." c "..tostring(cursortext and true or false).." "
.."  "..tostring(cursortext:GetText()).." "
.."  "..tostring(WorldMapFrame:GetFrameStrata()).." "
.."  "..tostring(WorldMapFrame:GetFrameLevel()).." "
)
--]==]
		end);
--[==[
print("TLoc"
.." f "..tostring(frame and true or false).." "
.." ut "..tostring(frame.updateTicker and true or false).." "
.." p "..tostring(playertext and true or false).." "
.." c "..tostring(cursortext and true or false).." "
)
--]==]

	end
end
