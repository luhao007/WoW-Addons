--[===[ File
Contains various utility routines used by Titan and Plugins for menus (right click)
--]===]

--[===[
Titan controls menus for its builtin plugins. 
Third party Titan plugins may have Titan control its menu.
LDB plugins are assumed to control their own menus.

The Titan routines abstract the menu creation built into WoW.
The abstractions :
: Insulate 3rd party Titan plugin authors from Blizz or lib changes.
: Allow better maintainance if implementation changes.

Currently Titan 'supports' three menu schemes
1- Abstract of an old drop down lib - L_UIDropDownMenu_*
2- Abstract of Blizzard UIDropDownMenu routines
3- Abstract of Blizzard_Menu which was introduced in 11.0.0

Having 3 methods evolved over the history of WoW and Titan, not to be dug up :).
1- This method is really for very old third party Titan plugins in Classic Era so they can run unchanged.
Many of these addons run but may not be actively maintained.
This wraps UIDropDownMenu routines to look like the lib routines.

2- This method wraps UIDropDownMenu routines with Titan oriented routines.

3- This method wraps the new Blizzard_Menu general routines to be oriented toward Titan features.
This method is very different from UIDropDownMenu. The two are distinct and do not overlap.
Titan uses the general routines to allow Blizzard_Menu to handle menu show / hide, and placement.
There is less flexability with the tradeoff being a consistent style and behavior.

When a menu is requested, Titan will use the .registry to find the routine to call.
This routine is expected to fill in the menu using one of the methods listed above.
In Jan 2026 Titan added a .registry on each bar for the new menu scheme to start combining plugin and bar routines,

Titan will use, in order :
1) registry.menuContextFunction  : NEW Jan 2026
2) registry.menuTextFunction  : Feb 2024
3) "TitanPanelRightClickMenu_Prepare" .. id .. "Menu" : Old as Titan :)


Jan 2026 : 
- Created this file by moving menu routines from TitanUtils.
- The UIDropDownMenu was deprecated as of 11.0.0 (Dragonflight) and could be removed from the game code.
- Thankfully the new method, Blizzard_Menu, is present in all versions of WoW.
Titan uses this scheme for its built-in plugins across all WoW versions.

Notes: 
- A Titan plugin being updated after 2026 Jan should switch to the Blizzard_Menu method.

- As of May 2025 Classic Era is the only version using an explicit timer to close menus.
Titan uses a routine only in CE (UIDropDownMenu_StartCounting) to determine which version to use.

- local drop_down_1 = "" -- changes depending on the drop down menu version. Blizzard hard-codes the value...

--]===]

local _G = getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)

local drop_down_1 = "" -- changes if using Blizz drop down (retail) or lib (Classic)

--====== Set the default drop down menu routines per retail or Classic
drop_down_1 = "DropDownList1" -- Boo!! Per hard-coded Blizz UIDropDownMenu.lua


--[[ UI dropdown lib wrappers - Classic Era plugins mainly
Local helper(s) from the Ace lib.
--]]
-- L_UIDropDownMenuTemplate

---Ensure the menu is created properly including back drop
---@param name table | string
---@param parent Frame
---@return any
local function create_DropDownMenu(name, parent)
	local f
	if type(name) == "table" then
		f = name
		name = f:GetName()
	else
		f = CreateFrame("Frame", name, parent or nil)
	end

	--if not name then name = "" end

	f:SetSize(40, 32)

	f.Left = f:CreateTexture(name and (name .. "Left") or nil, "ARTWORK")
	f.Left:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	f.Left:SetSize(25, 64)
	f.Left:SetPoint("TOPLEFT", f, 0, 17)
	f.Left:SetTexCoord(0, 0.1953125, 0, 1)

	f.Middle = f:CreateTexture(name and (name .. "Middle") or nil, "ARTWORK")
	f.Middle:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	f.Middle:SetSize(115, 64)
	f.Middle:SetPoint("LEFT", f.Left, "RIGHT")
	f.Middle:SetTexCoord(0.1953125, 0.8046875, 0, 1)

	f.Right = f:CreateTexture(name and (name .. "Right") or nil, "ARTWORK")
	f.Right:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	f.Right:SetSize(25, 64)
	f.Right:SetPoint("LEFT", f.Middle, "RIGHT")
	f.Right:SetTexCoord(0.8046875, 1, 0, 1)

	f.Text = f:CreateFontString(name and (name .. "Text") or nil, "ARTWORK", "GameFontHighlightSmall")
	f.Text:SetWordWrap(false)
	f.Text:SetJustifyH("RIGHT")
	f.Text:SetSize(0, 10)
	f.Text:SetPoint("RIGHT", f.Right, -43, 2)

	f.Icon = f:CreateTexture(name and (name .. "Icon") or nil, "OVERLAY")
	f.Icon:Hide()
	f.Icon:SetSize(16, 16)
	f.Icon:SetPoint("LEFT", 30, 2)

	-- // UIDropDownMenuButtonScriptTemplate
	f.Button = CreateFrame("Button", name and (name .. "Button") or nil, f)
	f.Button:SetMotionScriptsWhileDisabled(true)
	f.Button:SetSize(24, 24)
	f.Button:SetPoint("TOPRIGHT", f.Right, -16, -18)

	f.Button.NormalTexture = f.Button:CreateTexture(name and (name .. "NormalTexture") or nil)
	f.Button.NormalTexture:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	f.Button.NormalTexture:SetSize(24, 24)
	f.Button.NormalTexture:SetPoint("RIGHT", f.Button, 0, 0)
	f.Button:SetNormalTexture(f.Button.NormalTexture)

	f.Button.PushedTexture = f.Button:CreateTexture(name and (name .. "PushedTexture") or nil)
	f.Button.PushedTexture:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	f.Button.PushedTexture:SetSize(24, 24)
	f.Button.PushedTexture:SetPoint("RIGHT", f.Button, 0, 0)
	f.Button:SetPushedTexture(f.Button.PushedTexture)

	f.Button.DisabledTexture = f.Button:CreateTexture(name and (name .. "DisabledTexture") or nil)
	f.Button.DisabledTexture:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	f.Button.DisabledTexture:SetSize(24, 24)
	f.Button.DisabledTexture:SetPoint("RIGHT", f.Button, 0, 0)
	f.Button:SetDisabledTexture(f.Button.DisabledTexture)

	f.Button.HighlightTexture = f.Button:CreateTexture(name and (name .. "HighlightTexture") or nil)
	f.Button.HighlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	f.Button.HighlightTexture:SetSize(24, 24)
	f.Button.HighlightTexture:SetPoint("RIGHT", f.Button, 0, 0)
	f.Button.HighlightTexture:SetBlendMode("ADD")
	f.Button:SetHighlightTexture(f.Button.HighlightTexture)

	-- Button Script
	f.Button:SetScript("OnEnter", function(self, motion)
		local parent = self:GetParent()
		local myscript = parent:GetScript("OnEnter")
		if (myscript ~= nil) then
			myscript(parent)
		end
	end)
	f.Button:SetScript("OnLeave", function(self, motion)
		local parent = self:GetParent()
		local myscript = parent:GetScript("OnLeave")
		if (myscript ~= nil) then
			myscript(parent)
		end
	end)
	f.Button:SetScript("OnMouseDown", function(self, button)
		if self:IsEnabled() then
			local parent = self:GetParent()
			ToggleDropDownMenu(nil, nil, parent)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		end
	end)

	-- UIDropDownMenu Script
	f:SetScript("OnHide", function(self)
		CloseDropDownMenus()
	end)

	return f
end
--
-- Wrap the drop down lib as if it were Ace lib 4.0 so Classic Titan plugins look the same
-- These need to be global to act like the older version
--
-- L_UIDropDownMenuDelegate_OnAttributeChanged -- Different in 4.0
function L_UIDropDownMenu_InitializeHelper(frame)
	UIDropDownMenu_InitializeHelper(frame)
end

function L_Create_UIDropDownMenu(name, parent)
	local f = create_DropDownMenu(name, parent)
	return f
end

function L_UIDropDownMenu_Initialize(frame, initFunction, displayMode, level, menuList)
	UIDropDownMenu_Initialize(frame, initFunction, displayMode, level, menuList)
end

function L_UIDropDownMenu_SetInitializeFunction(frame, initFunction)
	UIDropDownMenu_SetInitializeFunction(frame, initFunction)
end

function L_UIDropDownMenu_SetDisplayMode(frame, displayMode)
	UIDropDownMenu_SetDisplayMode(frame, displayMode)
end

function L_UIDropDownMenu_RefreshDropDownSize(self)
	UIDropDownMenu_RefreshDropDownSize(self)
end

--function L_UIDropDownMenu_OnUpdate(self, elapsed) -- Different in 4.0
function L_UIDropDownMenu_StartCounting(frame)
	---@diagnostic disable-next-line: undefined-global
	UIDropDownMenu_StartCounting(frame) -- CE file only
end

function L_UIDropDownMenu_StopCounting(frame)
	---@diagnostic disable-next-line: undefined-global
	UIDropDownMenu_StopCounting(frame) -- CE file only
end

--function L_UIDropDownMenuButtonInvisibleButton_OnEnter(self)) -- Different in 4.0
--function L_UIDropDownMenuButtonInvisibleButton_OnLeave(self)) -- Different in 4.0
--function L_UIDropDownMenuButton_OnEnter(self) -- Different in 4.0
--function L_UIDropDownMenuButton_OnLeave(self) -- Different in 4.0
function L_UIDropDownMenu_CreateInfo()
	return UIDropDownMenu_CreateInfo()
end

function L_UIDropDownMenu_CreateFrames(level, index)
	UIDropDownMenu_CreateFrames(level, index)
end

function L_UIDropDownMenu_AddSeparator(level)
	UIDropDownMenu_AddSeparator(level)
end

function L_UIDropDownMenu_AddSpace(level) -- new in 4.0
	UIDropDownMenu_AddSpace(level)
end

function L_UIDropDownMenu_AddButton(info, level)
	UIDropDownMenu_AddButton(info, level)
end

function L_UIDropDownMenu_CheckAddCustomFrame(self, button, info)
	UIDropDownMenu_CheckAddCustomFrame(self, button, info)
end

function L_UIDropDownMenu_RegisterCustomFrame(self, customFrame)
	UIDropDownMenu_RegisterCustomFrame(self, customFrame)
end

function L_UIDropDownMenu_GetMaxButtonWidth(self)
	return UIDropDownMenu_GetMaxButtonWidth(self)
end

function L_UIDropDownMenu_GetButtonWidth(button)
	return UIDropDownMenu_GetButtonWidth(button)
end

function L_UIDropDownMenu_Refresh(frame, useValue, dropdownLevel)
	UIDropDownMenu_Refresh(frame, useValue, dropdownLevel)
end

function L_UIDropDownMenu_RefreshAll(frame, useValue)
	UIDropDownMenu_RefreshAll(frame, useValue)
end

function L_UIDropDownMenu_SetIconImage(icon, texture, info)
	UIDropDownMenu_SetIconImage(icon, texture, info)
end

function L_UIDropDownMenu_SetSelectedName(frame, name, useValue)
	UIDropDownMenu_SetSelectedName(frame, name, useValue)
end

function L_UIDropDownMenu_SetSelectedValue(frame, value, useValue)
	UIDropDownMenu_SetSelectedValue(frame, value, useValue)
end

function L_UIDropDownMenu_SetSelectedID(frame, id, useValue)
	UIDropDownMenu_SetSelectedID(frame, id, useValue)
end

function L_UIDropDownMenu_GetSelectedName(frame)
	return UIDropDownMenu_GetSelectedName(frame)
end

function L_UIDropDownMenu_GetSelectedID(frame)
	return UIDropDownMenu_GetSelectedID(frame)
end

function L_UIDropDownMenu_GetSelectedValue(frame)
	return UIDropDownMenu_GetSelectedValue(frame)
end

--function L_UIDropDownMenuButton_OnClick(self) -- Different in 4.0
function L_HideDropDownMenu(level)
	HideDropDownMenu(level)
end

function L_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button,
							  autoHideDelay)
	ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button, autoHideDelay)
end

function L_CloseDropDownMenus(level)
	CloseDropDownMenus(level)
end

--function L_UIDropDownMenu_OnHide(self) -- Different in 4.0
-- 4.0 has 'contains mouse' routines for retail only
function L_UIDropDownMenu_SetWidth(frame, width, padding)
	UIDropDownMenu_SetWidth(frame, width, padding)
end

function L_UIDropDownMenu_SetButtonWidth(frame, width)
	UIDropDownMenu_SetButtonWidth(frame, width)
end

function L_UIDropDownMenu_SetText(frame, text)
	UIDropDownMenu_SetText(frame, text)
end

function L_UIDropDownMenu_GetText(frame)
	return UIDropDownMenu_GetText(frame)
end

function L_UIDropDownMenu_ClearAll(frame)
	UIDropDownMenu_ClearAll(frame)
end

function L_UIDropDownMenu_JustifyText(frame, justification)
	UIDropDownMenu_JustifyText(frame, justification)
end

function L_UIDropDownMenu_SetAnchor(dropdown, xOffset, yOffset, point, relativeTo, relativePoint)
	UIDropDownMenu_SetAnchor(dropdown, xOffset, yOffset, point, relativeTo, relativePoint)
end

function L_UIDropDownMenu_GetCurrentDropDown()
	return UIDropDownMenu_GetCurrentDropDown()
end

function L_UIDropDownMenuButton_GetChecked(self)
	return UIDropDownMenuButton_GetChecked(self)
end

function L_UIDropDownMenuButton_GetName(self)
	return UIDropDownMenuButton_GetName(self)
end

function L_UIDropDownMenuButton_OpenColorPicker(self, button)
	UIDropDownMenuButton_OpenColorPicker(self, button)
end

function L_UIDropDownMenu_DisableButton(level, id)
	UIDropDownMenu_DisableButton(level, id)
end

function L_UIDropDownMenu_EnableButton(level, id)
	UIDropDownMenu_EnableButton(level, id)
end

function L_UIDropDownMenu_SetButtonText(level, id, text, colorCode)
	UIDropDownMenu_SetButtonText(level, id, text, colorCode)
end

function L_UIDropDownMenu_SetButtonNotClickable(level, id)
	UIDropDownMenu_SetButtonNotClickable(level, id)
end

function L_UIDropDownMenu_SetButtonClickable(level, id)
	UIDropDownMenu_SetButtonClickable(level, id)
end

function L_UIDropDownMenu_DisableDropDown(dropDown)
	UIDropDownMenu_DisableDropDown(dropDown)
end

function L_UIDropDownMenu_EnableDropDown(dropDown)
	UIDropDownMenu_EnableDropDown(dropDown)
end

function L_UIDropDownMenu_IsEnabled(dropDown)
	return UIDropDownMenu_IsEnabled(dropDown)
end

function L_UIDropDownMenu_GetValue(id)
	return UIDropDownMenu_GetValue(id)
end

--====== Right click menu routines - Retail dropdown menu UIDROPDOWNMENU

---local Add menu button at the given level.
---@param info table Filled in button to add
---@param level number menu level
local function Add_button(info, level)
	UIDropDownMenu_AddButton(info, level)
end

---API Menu - Get the base frame name of the user selected menu (without level).
---@return string frame_name
function TitanPanelRightClickMenu_GetDropdownFrameBase()
	local res = ""

	res = "DropDownList" -- Boo!! Per hard-coded Blizz UIDropDownMenu.lua

	return res
end

---API Menu - Get the frame name of the user selected menu.
---@return string frame_name
function TitanPanelRightClickMenu_GetDropdownFrame()
	local res = ""

	res = "DropDownList" .. tostring(UIDROPDOWNMENU_MENU_LEVEL)

	return res
end

---API Menu - Get the current level of the user selected menu.
---@return number level
function TitanPanelRightClickMenu_GetDropdownLevel()
	--	local res = _G[drop_down_1]
	local res = 1 -- proper typing

	res = UIDROPDOWNMENU_MENU_LEVEL

	return res
end

---API Menu - Get the current value of the user selected menu.
---@return any Value <button>.value usually a string; could be table to hold needed info
function TitanPanelRightClickMenu_GetDropdMenuValue()
	local res = nil
	res = UIDROPDOWNMENU_MENU_VALUE
	return res
end

---API Menu - add given info (button) at the given menu level.
---@param info table Filled in button to add
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddButton(info, level)
	level = level or 1
	if (info) then
		Add_button(info, level)
	end
end

---API Menu - add a toggle Right Side (localized) command at the given level in the form of a button. Titan will properly control the "DisplayOnRightSide"
---@param id string Plugin id
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddToggleRightSide(id, level)
	level = level or 1
	local plugin = TitanUtils_GetPlugin(id)
	if plugin and plugin.controlVariables and plugin.controlVariables.DisplayOnRightSide then
		-- copy of TitanPanelRightClickMenu_AddToggleVar adding a remove button
		local info = {};
		info.text = L["TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE"];
		info.value = { id, "DisplayOnRightSide" };
		info.func = function()
			local bar = TitanUtils_GetWhichBar(id)
			TitanPanelRightClickMenu_ToggleVar({ id, "DisplayOnRightSide" })
			TitanPanel_RemoveButton(id);
			TitanUtils_AddButtonOnBar(bar, id)
		end
		info.checked = TitanGetVar(id, "DisplayOnRightSide");
		info.keepShownOnClick = 1;
		Add_button(info, level);
	end
end

---API Menu - add a localized title at the given level in the form of a button.
---@param title string localized title
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddTitle(title, level)
	level = level or 1
	if (title) then
		local info = {};
		info.text = title;
		info.notCheckable = true;
		info.notClickable = true;
		info.isTitle = 1;
		Add_button(info, level);
	end
end

---API Menu - add a toggle variable command at the given level in the form of a button.
---@param text string Localized text to show
---@param value string Internal button name
---@param functionName function | string Function to call on click
---@param level? number menu level
function TitanPanelRightClickMenu_AddCommand(text, value, functionName, level)
	level = level or 1
	local info = {};
	info.notCheckable = true;
	info.text = text;
	info.value = value;
	info.func = function()
		if functionName then
			local callback = functionName

			if type(callback) == 'string' then
				-- Function MUST be in global namespace
				callback = _G[callback]
			elseif type(callback) == 'function' then
				-- Can be global or local to the plugin
			else
				-- silently leave...
			end
			-- Redundant but the given string may not be a function
			if type(callback) == "function" then
				-- No return expected...
				callback(value)
			else
				-- Must be a function - spank developer
			end
		else
			-- Leave, creates an inactive button
		end
	end
	Add_button(info, level);
end

---API Menu - add a line at the given level in the form of an inactive button.
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddSeparator(level)
	level = level or 1

	UIDropDownMenu_AddSeparator(level)
end

---API Menu - add a blank line at the given level in the form of an inactive button.
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddSpacer(level)
	level = level or 1

	UIDropDownMenu_AddSpace(level)
end

---API This will remove the plugin from whichever Titan bar it is on.
---@param id string Plugin id
function TitanPanelRightClickMenu_Hide(id)
	TitanPanel_RemoveButton(id);
end

---API Menu - add a toggle variable command at the given level in the form of a button.
---@param text string Localized text to show
---@param id string Plugin id
---@param var string the saved variable of the plugin to toggle
---@param toggleTable nil ! NOT USED !
---@param level number menu level
function TitanPanelRightClickMenu_AddToggleVar(text, id, var, toggleTable, level)
	local info = {};
	info.text = text;
	info.value = { id, var, toggleTable };
	info.func = function()
		TitanPanelRightClickMenu_ToggleVar({ id, var, toggleTable })
	end
	info.checked = TitanGetVar(id, var);
	info.keepShownOnClick = 1;
	Add_button(info, level);
end

---API Menu - add a toggle Label (localized) command at the given level in the form of a button. Titan will properly control "ShowIcon"
---@param id string Plugin id
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddToggleIcon(id, level)
	level = level or 1
	local plugin = TitanUtils_GetPlugin(id)
	if plugin and plugin.controlVariables and plugin.controlVariables.ShowIcon then
		TitanPanelRightClickMenu_AddToggleVar(L["TITAN_PANEL_MENU_SHOW_ICON"], id, "ShowIcon", nil, level);
	end
end

---API Menu - add a toggle Label (localized) command at the given level in the form of a button. Titan will properly control "ShowLabelText"
---@param id string Plugin id
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddToggleLabelText(id, level)
	level = level or 1
	local plugin = TitanUtils_GetPlugin(id)
	if plugin and plugin.controlVariables and plugin.controlVariables.ShowLabelText then
		TitanPanelRightClickMenu_AddToggleVar(L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"], id, "ShowLabelText", nil, level);
	end
end

---API Menu - add a toggle Colored Text (localized) command at the given level in the form of a button. Titan will properly control "ShowColoredText"
---@param id string Plugin id
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddToggleColoredText(id, level)
	level = level or 1
	local plugin = TitanUtils_GetPlugin(id)
	if plugin and plugin.controlVariables and plugin.controlVariables.ShowColoredText then
		TitanPanelRightClickMenu_AddToggleVar(L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"], id, "ShowColoredText", nil, level);
	end
end

---API Menu - add a Hide (localized) command at the given level in the form of a button. When clicked this will remove the plugin from the Titan bar.
---@param id string Plugin id
---@param level? number menu level or 1
function TitanPanelRightClickMenu_AddHide(id, level)
	level = level or 1
	local info = {};
	info.notCheckable = true;
	info.text = L["TITAN_PANEL_MENU_HIDE"];
	info.value = nil -- value; huh - what should this be?
	info.func = function()
		TitanPanelRightClickMenu_Hide(id)
	end
	Add_button(info, level);
end

---API This will toggle the Titan variable and the update the button.
---@param value table Plugin id and var to toggle
--- Example: {TITAN_XP_ID, "ShowSimpleToLevel"}
function TitanPanelRightClickMenu_ToggleVar(value)
	-- Update 2024 Mar - Removed the 'reverse' check.
	-- Not sure it was ever used or even worked.
	--	local id, var, toggleTable = "", nil, {}
	local id, var = "", ""

	-- table expected else do nothing
	if type(value) ~= "table" then return end

	if value and value[1] then id = value[1] end
	if value and value[2] then var = value[2] end
	--	if value and value[3] then toggleTable = value[3] end

	-- Toggle var
	TitanToggleVar(id, var);
	TitanPanelButton_UpdateButton(id);
	--[=[]]
	if ( TitanPanelRightClickMenu_AllVarNil(id, toggleTable) ) then
		-- Undo if all vars in toggle table nil
		TitanToggleVar(id, var);
	else
		-- Otherwise continue and update the button
		TitanPanelButton_UpdateButton(id, 1);
	end
--]=]
end

---API Set backdrop of the plugin. Used for custom created controls (Clock / Volume) to give a consistent look.
---@param frame table Plugin control frame
function TitanPanelRightClickMenu_SetCustomBackdrop(frame)
	--[[
Blizzard decided to remove direct Backdrop API in 9.0 (Shadowlands)
so inherit the template (XML) and set the values in the code (Lua)

9.5 The tooltip template was removed from the GameTooltip.
--]]

	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileEdge = true,
		insets = { left = 1, right = 1, top = 1, bottom = 1 },
		tileSize = 8,
		edgeSize = 8,
	})

	frame:SetBackdropBorderColor(
		TOOLTIP_DEFAULT_COLOR.r,
		TOOLTIP_DEFAULT_COLOR.g,
		TOOLTIP_DEFAULT_COLOR.b);
	frame:SetBackdropColor(
		TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
		TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
		TOOLTIP_DEFAULT_BACKGROUND_COLOR.b
		, 1);
end

---API Menu - add the set of options per the plugin registry control variables.
---@param id string Plugin id
---@param level? number If not present, default to 1 (top)
function TitanPanelRightClickMenu_AddControlVars(id, level)
	level = level or 1 -- assume top menu
	TitanPanelRightClickMenu_AddSeparator(level)

	TitanPanelRightClickMenu_AddToggleIcon(id, level)
	TitanPanelRightClickMenu_AddToggleLabelText(id, level)
	TitanPanelRightClickMenu_AddToggleColoredText(id, level)
	TitanPanelRightClickMenu_AddToggleRightSide(id, level)

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], id, TITAN_PANEL_MENU_FUNC_HIDE);
end

--====== Right click menu routines for Titan Panel bars and plugins

local function CloseAnyMenu()
	-- UIDropDownMenu from Blizzard
	if (_G["DropDownList1"] and _G["DropDownList1"]:IsVisible()) then
		_G["DropDownList1"]:Hide()
	else
		-- not open
	end

	-- Titan wrapped UIDropDownMenu
	if _G[drop_down_1] and _G[drop_down_1]:IsVisible() then
		_G[drop_down_1]:Hide()
	else
		-- not open
	end

	-- Newer Blizzard menu scheme
	local menu_mgr = Menu.GetManager()
	if (menu_mgr and menu_mgr:IsAnyMenuOpen()) then -- Blizzard_Menu
		menu_mgr:CloseMenus();
	else
		-- not open
	end
end

---Titan Close the right click menu of any plugin, if it was open. Only one can be open at a time.
function TitanUtils_CloseRightClickMenu()
	CloseAnyMenu()
end

local function PlaceMenu(self, menu)
	-- Mar 2023 : Rewritten to place menu relative to the passed in frame (button)
	-- Under the cover the menu is built as DropDownList1
	local frame = self:GetName()
	local menu_height = menu:GetHeight()
	local menu_width = menu:GetWidth()

	-- Adjust the Y offset as needed
	local ftop = _G[frame]:GetTop()
	local rel_y = ftop - menu_height
	if rel_y > 0 then
		menu.point = "TOP";
		menu.relativePoint = "BOTTOM";
	else
		-- too close to bottom of screen
		menu.point = "BOTTOM";
		menu.relativePoint = "TOP";
	end

	-- Adjust the X offset as needed
	local x_offset = 0
	local left = 0
	local flft = _G[frame]:GetLeft()
	local effscale = UIParent:GetEffectiveScale()
	if TitanBarData[frame] then
		-- on a Titan bar so use cursor for the 'left'
		left = GetCursorPosition() -- get x; ignore y
		left = left / effscale
		-- correct for beginning of Titan bar
		left = left - flft
	else
		-- a plugin
		left = flft
	end
	local rel_x = left + menu_width
	if (rel_x < GetScreenWidth()) then
		-- menu will fit
		menu.point = menu.point .. "LEFT";
		menu.relativePoint = menu.relativePoint .. "LEFT";

		if TitanBarData[frame] then
			x_offset = left
		else
			-- a plugin
			x_offset = 0
		end
	else
		-- Menu would go off right side of the screen
		menu.point = menu.point .. "RIGHT";
		menu.relativePoint = menu.relativePoint .. "RIGHT";

		if TitanBarData[frame] then
			-- correct is on Titan bar (bottom, far right)
			-- flip calc since we flipped the anchor to right
			x_offset = GetScreenWidth() - left
		else
			-- a plugin
			x_offset = 0
		end
	end
	--[[
print("RCM"
.." "..tostring(frame)..""
.." "..tostring(format("%0.1f", menu_height))..""
.." "..tostring(format("%0.1f", menu_width))..""
.." "..tostring(format("%0.1f", _G[frame]:GetLeft()))..""
.." "..tostring(menu.point)..""
.." "..tostring(menu.relativePoint)..""
.." "..tostring(format("%0.1f", left))..""
)
--]]
	ToggleDropDownMenu(1, nil, menu, frame, x_offset, 0, nil, self);
end

---local Prepare the plugin right click menu using the function given by the plugin OR Titan bar.
---@param self table Titan Bar or Plugin frame
---@param menu table Frame to use as the menu
--- Set Titan_Debug.titan.menu to output the error to Chat.
local function TitanRightClickMenu_OnLoad(self, menu)
	local id = ""
	local err = ""
	local context_menu = false

	if self.registry then
		id = self.registry.id -- is a plugin
	else
		id = "Bar"      -- is a Titan bar
	end

	if id == "" then
		err = "Could not display menu. "
			.. "Unknown Titan ID for "
			.. "'" .. (self:GetName() or "?") .. "'. "
	else
		--		local frame = TitanUtils_GetPlugin(id) -- get plugin frame
		local frame = self.registry
		local prepareFunction -- function to call

		if frame and frame.menuContextFunction then
			prepareFunction = frame.menuContextFunction -- Blizzard_Menu 2026 Jan
			context_menu = true
		elseif frame and frame.menuTextFunction then
			prepareFunction = frame.menuTextFunction -- Newer method 2024 Feb
		else
			-- Older method used when Titan was created
			prepareFunction = "TitanPanelRightClickMenu_Prepare" .. id .. "Menu"
			--
		end
		if type(prepareFunction) == 'string' then
			-- Function MUST be in global namespace
			-- Becomes nil if not found
			prepareFunction = _G[prepareFunction]
		elseif type(prepareFunction) == 'function' then
			-- Can be global or local to the plugin
		else
			-- Invalid type, do not even try...
			prepareFunction = nil
		end
		if prepareFunction then
			if context_menu then
				-- using newer context menu for this plugin
				Titan_Menu.AddContextMenu(self, prepareFunction)
			else
				-- deprecated, may be removed in future
				UIDropDownMenu_Initialize(menu, prepareFunction, "MENU")
				PlaceMenu(self, menu)
			end
		else
			err = "Could not display menu. "
				.. "No function for '" .. tostring(id) .. "' "
				.. "[" .. tostring(type(prepareFunction)) .. "] "
				.. "[" .. tostring(prepareFunction) .. "] "
				.. ". "
		end
	end

	if err == "" then
		-- all is good
	else
		Titan_Debug.Out('titan', 'menu', "Error: " .. err)
	end
end

---Titan Call the routine to build the plugin or bar menu then place it properly.
---@param self table Plugin frame
function TitanPanelRightClickMenu_Toggle(self)
	-- There are two places for the menu creation routine
	-- 1) Titan bar - creates same menu
	-- 2) Plugin creation via the .registry
	local frame = self:GetName()
	local menu = _G[self:GetName() .. TITAN_PANEL_CLICK_MENU_SUFFIX]

	-- Create menu based on the frame's routine for right click menu
	TitanRightClickMenu_OnLoad(self, menu)
end

---Titan Determine if a right click menu is shown. There can only be one.
---@return boolean IsVisible
function TitanPanelRightClickMenu_IsVisible()
	local res = false
	if _G[drop_down_1] and _G[drop_down_1]:IsVisible() then
		res = true
	else
		res = false
	end
	return res
end

---Titan Close the right click menu if shown. There can only be one.
function TitanPanelRightClickMenu_Close()
	CloseAnyMenu()
end

--[=====[ Implementation notes
--]=====]

--[=====[ NEW menu scheme Jan 2026
Blizzard introduced a new menu scheme in 11.0.0 (July 2024) coded in Blizzard_Menu.
The menu scheme is so different we use a new namespace for the new wrapper routines.

First: Blizzard_Menu works quite different than UIDropDownMenu.
UIDropDownMenu iterated over the code to create and show the menu.
Blizzard_Menu changed that scheme to iterate over the objects - not code.
It now expects a set of nested objects (sort of the old info) to be created.
One impact is - level and info.value disappear!
The dev no longer needs to check level and info.value to determine which portion of the menu to display.

Now a 'root description' / menu is created to act as the new 'level 1' or main menu.
The routine to create the new menu widgets is passed to the menu create.
The output is expected to be a nested set of tables describing the menu.

Nesting of submenus are created by attaching a new widget to a menu or button.
Much as child frames are created with a parent. This acts as the old info.hasArrow.

Second: The scheme using UIDropDownMenu was deprecated and could be removed in the future.
Titan needs to keep new and old schemes working side by side for now.
Thankfully, the two menu schemes work side by side BUT look different.

Third: Blizzard_Menu is intended for options using a frame with full blown menu widgets
such as dropdowns, toggles, sliders, and more. It is used for Blizzard options, character creation, and more.

We decided to KISS (Keep It Simple, Stupid) when using Blizzard_Menu.
We use a small number of routines designed to use menu default settings. There are very few options to tweak.
The routines used as base for Titan menus are:
- MenuUtil.CreateContextMenu -- root of the menu; old UIDropDownMenu_Initialize
- MenuUtil.CreateButton -- old info.text; info.func
- MenuUtil.CreateCheckbox -- old info.text; info.checked; info.func
- MenuUtil.CreateRadio -- old info.text; info.checked; info.func
- owner:SetEnabled -- old info.disabled
These handle over 90% of Titan and plugin needs.

Fourth: Titan wraps the parts of Blizzard_Menu used in a new Titan_Menu table / class.
Titan_Menu should protect Titan plugin devs when Blizzard changes the internal menu implementation.

=== Implementation notes
A new Titan registry attribute, .menuContextFunction, was added to the .registry for plugins to use.
It was created to explicitly state the plugin routine used to create the menu widgets.

When asked to create a menu, Titan will use the first method found.
In order these are :
1) registry.menuContextFunction  : NEW Jan 2026
2) registry.menuTextFunction  : Feb 2024
3) "TitanPanelRightClickMenu_Prepare" .. id .. "Menu" : Old as Titan :)

On right click, Titan will, in order :
1) Create the context menu
2) Add a menu title at top using .registry.id
3) Call the plugin to fill it as before - using pcall, placing error in the menu
4) Add the plugin designated control vars + right side + Hide on bottom of menu
The top and bottom of the menu are common so Titan adds them for consistent style and relieve the dev a bit.

The context menu holds all widgets - no nesting of context menus.
Titan provides routines in Titan_Menu to relieve the dev from some grunt work.
In both schemes, menu widgets are added in the order the code runs.

The old create menu is left in TitanBag for comparison. As a quick example:
=== OLD
	info = {};
	info.text = L["TITAN_BAG_MENU_OPEN_BAGS"]
	info.func = function()
		TitanToggleVar(TITAN_BAG_ID, "OpenBags")
	end
	info.checked = TitanGetVar(TITAN_BAG_ID, "OpenBags");
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
== NEW
	Titan_Menu.AddSelector(root, TITAN_BAG_ID, L["TITAN_BAG_MENU_OPEN_BAGS"], "OpenBags")
Where root is the context menu; the locale string (L) will be placed inline at the main menu.
===

Only atomic elements / widgets can easily be added to the context menu.
Such as command buttons (info.func) or radio / checkbox (info.checked and info.func).
Title, spacer, and divider are available.
Using code, widgets can be enhanced and interact but a complex widget is not possible.

It seems you can create frames and add new templates and widgets but additional code and knowledge will be needed :).
If you need complex widgets such as dropdown selector or slider you may need to create a virtual template;
meaning a fully fleshed frame in XML. This would be an options frame not a simple menu.

--]=====]

--[=====[ Wrapper implementation notes
Wrapper notes:
- The parameter 'owner' used below is a 'menu description' in the new terms.
-- Most Blizzard_Menu 'create' routines must have an owner to attach the widget to.
-- Most Blizzard_Menu 'create' routines return the resulting widget.

- Blizzard_Menu create routines pass 'is selected' and 'set selected' as functions.
The wrappers continue this and extends to other needed actions.
- Adds 'update Titan button' where it makes sense, relieving the dev from including it 'all over'.
- When a single selector is created, Titan uses a checkbox.
- When multiple selectors are created, Titan uses a radio.
- When multiple selectors are created, a divider (line) is added at top.
- AddSelector* is used when checkbox or radio buttons will be created.

--]=====]

--== menu helpers
local nop = function(obj) end

---local Helper Add a simple header for a list
---@param owner table Menu widget object
---@param label string Label of the selector
---@param color table Color object
---@return table elementDescription
local function GenHeader(owner, label, color)
	if color == nil then
		color = GRAY_FONT_COLOR
	end
	local elementDescription =
		owner:CreateTitle(label, color)

	elementDescription:AddInitializer(function(frame, description, menu)
		local fontFile, height, flags = frame.fontString:GetFont()
		--[[
		print("Hdr"
	.." "..tostring(fontFile)..""
	.." "..tostring(height)..""
	.." "..tostring(flags)..""
	)
	--]]
	end
	)

	-- in case we can and want need to modify in future...
	return elementDescription
end

---local Add a button that, when pressed runs a command passing any given parameters
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the  selector
---@param function_name function
---@param ... any
---@return table elementDescription
local function GenCommand(owner, id, label, function_name, ...)
	--    local callback = function_name
	local params = ...

	local elementDescription =
		owner:CreateButton(label, -- was info.text
			function()      -- was info.func
				function_name(params)
			end,
			id
		)
	-- in case we can and want need to modify in future...
	return elementDescription
	--[[
    if function_name then
        if type(callback) == 'string' then
            -- Function MUST be in global namespace
            callback = _G[callback]
        elseif type(callback) == 'function' then
            -- Can be global or local to the plugin
        else
            -- silently leave...
        end
        -- Redundant but the given string may not be a function
        if type(callback) == "function" then
            -- No return expected...
            callback(id)
        else
            -- Must be a function - spank developer
            -- Leave, create an inactive button
            callback = function() end
        end
    else
        -- Leave, create an inactive button
        callback = function() end
    end
--]]
end

---local Helper Add a simple radio
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the selector
---@param opt string Plugin option to read / change
---@return table elementDescription
local function GenRadio(owner, id, label, opt)
	local elementDescription =
		owner:CreateRadio(label, -- was info.text
			function()     -- isSelected was info.checked
				return TitanGetVar(id, opt)
			end,
			function() -- SetSelected which was info.func
				local val = not TitanGetVar(id, opt)
				TitanSetVar(id, opt, val)
				TitanPanelButton_UpdateButton(id);
			end
		)
	-- in case we can and want need to modify in future...
	return elementDescription
end

---local Helper Add a simple checkbox
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the selector
---@param opt string Plugin option to read / change
---@return table elementDescription
local function GenCheckbox(owner, id, label, opt)
	local elementDescription =
		owner:CreateCheckbox(label, -- was info.text
			function()        -- isSelected was info.checked
				return TitanGetVar(id, opt)
			end,
			function() -- SetSelected which was info.func
				local val = not TitanGetVar(id, opt)
				TitanSetVar(id, opt, val)
				TitanPanelButton_UpdateButton(id);
			end
		)
	-- in case we can and want need to modify in future...
	return elementDescription
end

---local Helper to Create a simple selector (radio) off the owner and call the function
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the selector
---@param opt string Plugin option to read / change
---@param sel_func function
---@param ... any
---@return table elementDescription
local function GenSelectorCommand(owner, id, label, opt, sel_func, ...)
	local params = ...

	local elementDescription =
		owner:CreateRadio(label, -- was info.text
			function()     -- isSelected was info.checked
				return TitanGetVar(id, opt)
			end,
			function() -- SetSelected which was info.func
				local val = not TitanGetVar(id, opt)
				TitanSetVar(id, opt, val)
				-- Once the opt is set run the command
				sel_func(params)
				-- Then update...
				TitanPanelButton_UpdateButton(id);
			end
		)
	-- in case we can and want need to modify in future...
	return elementDescription
end

---local Add title to owner
---@param owner table Menu widget object
---@param label string Label of the selector
---@return table elementDescription
local function GenTitle(owner, label)
	local elementDescription = owner:CreateTitle(label)
	return elementDescription
end

---local Add the desired control vars to the owner; this expected to end the menu!
---@param owner table Menu widget object
---@param id string Plugin ID
---@param add_hide boolean
local function GenControlVars(owner, id, add_hide)
	owner:CreateDivider()

	local plugin = TitanUtils_GetPlugin(id)

	if plugin and plugin.controlVariables and plugin.controlVariables.ShowIcon then
		GenCheckbox(owner, id, L["TITAN_PANEL_MENU_SHOW_ICON"], "ShowIcon")
	end
	if plugin and plugin.controlVariables and plugin.controlVariables.ShowLabelText then
		GenCheckbox(owner, id, L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"], "ShowLabelText")
	end
	if plugin and plugin.controlVariables and plugin.controlVariables.ShowRegularText then --(LDB data sources only atm)
		GenCheckbox(owner, id, L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"], "TITAN_PANEL_MENU_SHOW_PLUGIN_TEXT")
	end
	if plugin and plugin.controlVariables and plugin.controlVariables.ShowColoredText then
		GenCheckbox(owner, id, L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"], "ShowColoredText")
	end

	owner:CreateCheckbox(L["TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE"],
		function() -- isSelected
			return TitanGetVar(id, "DisplayOnRightSide")
		end,
		function() -- SetSelected
			local bar = TitanUtils_GetWhichBar(id)
			TitanPanelRightClickMenu_ToggleVar({ id, "DisplayOnRightSide" })
			TitanPanel_RemoveButton(id);
			TitanUtils_AddButtonOnBar(bar, id)
		end
	)

	if add_hide then
		Titan_Menu.AddSpacer(owner)

		GenCommand(owner, id, L["TITAN_PANEL_MENU_HIDE"], TitanPanelRightClickMenu_Hide, id)
	else
		-- not requested
	end
end

local function MarkFromList(id, opt, list)
	for idx = 1, #list do
		local list_opt = list[idx][2]

		if list_opt == opt then
			TitanSetVar(id, list_opt, true);
		else
			TitanSetVar(id, list_opt, false);
		end
	end
end

---API Add divider (line) to owner
---@param owner table Menu widget object
---@return table elementDescription
function Titan_Menu.AddDivider(owner)
	local elementDescription = owner:CreateDivider()
	return elementDescription
end

---API Add spacer (blank) to owner
---@param owner table Menu widget object
---@return table elementDescription
function Titan_Menu.AddSpacer(owner)
	local elementDescription = owner:CreateSpacer()
	return elementDescription
end

---API Add text, no actions
---@param owner table Menu widget object
---@param label string Label of the selector
---@param color? table Color object, if nil defaults to gray
---@return table elementDescription
function Titan_Menu.AddText(owner, label, color)
	local elementDescription = GenHeader(owner, label, color)

	return elementDescription
end

---API Set Enabled attribute on a widget using a function
---@param owner table Menu widget object
---@param enabled boolean
function Titan_Menu.SetAtribEnabled(owner, enabled)
	owner:SetEnabled(enabled) -- .isEnabled
end

---API Add a simple button to owner; expect this to be a parent
---@param owner table Menu widget object
---@param label string Label of the selector
---@return table elementDescription
function Titan_Menu.AddButton(owner, label)
	local elementDescription = owner:CreateButton(label)
	return elementDescription
end

---API Create a simple selector off the owner
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the selector
---@param opt string Plugin option to read / change
---@return table elementDescription
function Titan_Menu.AddSelector(owner, id, label, opt)
	local elementDescription = GenCheckbox(owner, id, label, opt)
	return elementDescription
end

---API Create a simple selector off the owner
---@param owner table Menu widget object
---@param label string Label of the selector
---@param isSelected function
---@param setSelected function
---@param data table Pass to functions as is
---@return table elementDescription
function Titan_Menu.AddSelectorGeneric(owner, label, isSelected, setSelected, data)
	local elementDescription =
		owner:CreateCheckbox(label, -- was info.text
			isSelected,
			setSelected,
			data -- passed to both functions as table
		)
	-- in case we can and want need to modify in future...
	return elementDescription
end

---API Create a selector for each item in list; N selectors > N options (only one true)
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string? For Title, if desired
---@param list table Label - option pair table
function Titan_Menu.AddSelectorExclusiveList(owner, id, label, list)
	Titan_Menu.AddDivider(owner)

	if label == nil then
		-- no title wanted
	else
		GenHeader(owner, label, GRAY_FONT_COLOR)
	end

	-- Whip through list of label - option (vars)
	for idx = 1, #list do
		local optlabel = list[idx][1]
		local opt = list[idx][2]
		owner:CreateRadio(
			optlabel,
			function() -- isSelected
				return TitanGetVar(id, opt)
			end,
			function() -- SetSelected
				MarkFromList(id, opt, list)
				TitanPanelButton_UpdateButton(id);
			end
		)
	end
end

---API Create a selector for each item in list; N selectors > 1 option
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string? For Title, if desired
---@param opt string Plugin option to read / change
---@param list table Label - Value pair table
---@param sel_func? function
---@param ... any
function Titan_Menu.AddSelectorList(owner, id, label, opt, list, sel_func, ...)
	local params = ...

	Titan_Menu.AddDivider(owner)

	if label == nil then
		-- no title wanted
	else
		GenHeader(owner, label, GRAY_FONT_COLOR)
	end

	-- Whip through list of label - option (vars)
	for idx = 1, #list do
		local optlabel = list[idx][1]
		local optvalue = list[idx][2]
		owner:CreateRadio(
			optlabel,
			function() -- isSelected
				return (TitanGetVar(id, opt) == optvalue)
			end,
			function() -- SetSelected
				TitanSetVar(id, opt, optvalue)
				-- Once the opt is set run the command
				if sel_func == nil then
					-- nothing requested
				else
					sel_func(params)
				end
				TitanPanelButton_UpdateButton(id);
			end
		)
	end
end

---API Add a button that, when pressed runs a command passing any given paramters
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the  selector
---@param function_name function
---@return table elementDescription
function Titan_Menu.AddCommand(owner, id, label, function_name, ...)
	local params = ...
	local elementDescription = GenCommand(owner, id, label, function_name, params)
	return elementDescription
end

---Titan Add the desired control vars to the owner; this expected to end the menu!
---@param owner table Menu widget object
---@param id string Plugin ID
function Titan_Menu.AddControlVars(owner, id)
	GenControlVars(owner, id, false)
end

---API Helper to Create a simple selector (radio) off the owner and call the function before updating buttonplugin text.
---@param owner table Menu widget object
---@param id string Plugin ID
---@param label string Label of the selector
---@param opt string Plugin option to read / change
---@param function_name function
---@param ... any
---@return table elementDescription
function Titan_Menu.AddSelectorCommand(owner, id, label, opt, function_name, ...)
	local elementDescription = GenSelectorCommand(owner, id, label, opt, function_name, ...)
	return elementDescription
end

---Titan ONLY, called by Titan right click handler!
---Create Root menu description to attach menu widgets to
---@param owner table Plugin object / table
---@param gen_function function Used to add descriptions / widgets
---@return table Root Root description / widget
function Titan_Menu.AddContextMenu(owner, gen_function, ...)
	local params = ...

	local function gen_menu(plugin_frame, rootDescription, params_gen)
		local root = rootDescription

		-- Add a tile and divider to the menu
		local id = ""
		if plugin_frame.registry and plugin_frame.registry.menuText then
			id = plugin_frame.registry.menuText
		else
			id = "??"
		end
		GenTitle(root, id)
		Titan_Menu.AddDivider(root)

		-- Attach widgets or show error!
		local succ, val = pcall(gen_function, plugin_frame, root, params)
		if succ then
			-- all good
		else
			GenHeader(root, id .. " !! " .. val, RED_FONT_COLOR)
		end

		if plugin_frame and plugin_frame.registry.category == Titan_Global.categories.TitanBar then
			-- Titan bar; do not show the control vars atm
		else
			-- Add the control variables + right side + Hide
			GenControlVars(root, plugin_frame.registry.id, true)
		end
	end

	-- This does return a menu object but we choose to let Blizz handle opening through closing.
	return MenuUtil.CreateContextMenu(owner, gen_menu, params)

	-- CreateContextMenu will take other parameters (as ...) which are passed to GeneratorFunction.
	-- A handy feature but not used in Titan.
end
