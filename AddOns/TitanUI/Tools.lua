---@diagnostic disable: duplicate-set-field
--[[
-- **************************************************************************
-- * TitanUI.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************
--]]
-- ******************************** Constants *******************************
local add_on = ...
local _G = _G --getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local artwork_path = "Interface\\AddOns\\TitanUI\\Artwork\\"
local TITAN_PLUGIN = "TitanUI"
local TITLE = "Titan UI"
local TITAN_BUTTON = "TitanPanel" .. TITAN_PLUGIN .. "Button"
local VERSION = C_AddOns.GetAddOnMetadata(add_on, "Version")

-- ******************************** Variables *******************************
local trace = false -- true / false    Make true when debug output is needed.

local function SendSlash(slash, params)
	DEFAULT_CHAT_FRAME.editBox:SetText(_G[slash].." "..tostring(params))
	ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
end

-- Create the right click menu for this plugin
local function CreateMenu()
	local info = {};

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PLUGIN].menuText);

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_PANEL_MENU_OPTIONS_BARS"]
	info.func = function()
		TitanUpdateConfig("init")
		AceConfigDialog:Open("Titan Panel Bars")
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_PANEL_MENU_PLUGINS"]
	info.func = function()
		TitanUpdateConfig("init")
		AceConfigDialog:Open("Titan Panel Addon Control")
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_PANEL_MENU_PROFILES"]
	info.func = function()
		TitanUpdateConfig("init")
		AceConfigDialog:Open("Titan Panel Addon Chars")
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSeparator(TitanPanelRightClickMenu_GetDropdownLevel());
	-- Option to toggle the framestack cmd
	info = {};
	info.notCheckable = true
	info.text = "/titanpanel reset"
	info.func = function()
		SendSlash("SLASH_TitanPanel1", "reset")
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSeparator(TitanPanelRightClickMenu_GetDropdownLevel());
	-- Option to toggle the framestack cmd
	info = {};
	info.notCheckable = true
	info.text = "Toggle frame details"
	info.func = function()
		SendSlash("SLASH_FRAMESTACK1")
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSeparator(TitanPanelRightClickMenu_GetDropdownLevel());

	-- Option to open WoWLua, if loaded
	info = {};
	info.notCheckable = true
	info.text = "Open WoWLua"
---@diagnostic disable-next-line: undefined-global
	info.disabled = (SLASH_WOWLUA1 == nil)
	info.func = function()
		SendSlash("SLASH_WOWLUA1")
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddControlVars(TITAN_PLUGIN)
end

-- Grab the button text to display
local function GetButtonText(id)
	local strA, strB = TITLE, ""
	return strA, strB
end

-- Create the tooltip string
local function GetTooltipText()
	local returnstring = ""
	returnstring = returnstring.."Left Click: Reloads the User Interface\n"
	returnstring = returnstring.."Right Click: For Shortcuts and Debug Tools\n"
	return returnstring
end

-- Create the .registry for Titan so it can register and place the plugin
-- Icon from : https://www.wowhead.com/icon=236372/achievement-bg-returnxflags-def-wsg

local function OnLoad(self)
	local notes = ""
		.. "Adds a click to Reload UI and as menu for select help & tools to Titan Panel.\n"
	--		.."- xxx.\n"
	self.registry = {
		id = TITAN_PLUGIN,
		category = "Built-ins",
		version = VERSION,
		menuText = TITLE,
		menuTextFunction = CreateMenu,
		buttonTextFunction = GetButtonText,
		tooltipTitle = TITLE,
		tooltipTextFunction = GetTooltipText,
		icon = artwork_path .. "TitanReload",
		iconWidth = 16,
		notes = notes,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
--			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
--			ShowColoredText = 1,
			DisplayOnRightSide = false,
		}
	};
end

-- Parse and react to registered events
local function OnEvent(self, event, a1, a2, ...)
end

-- Handle mouse clicks
local function OnClick(self, button)
	if trace then
		TitanPluginDebug(TITAN_PLUGIN, "TUI click"
			.. " " .. tostring(button) .. ""
		)
	end
	if (button == "LeftButton") then
		ReloadUI()
	end
end

local function OnShow(self)
	TitanPanelButton_UpdateButton(TITAN_PLUGIN);
end

-- ====== Create needed frames
local function Create_Frames()
	if _G[TITAN_BUTTON] then
		return -- if already created
	end

	if trace then
		TitanPluginDebug(TITAN_PLUGIN, "TS frames"
			.. " '" .. tostring(TITAN_BUTTON) .. "'"
		)
	end

	-- general container frame
	local f = CreateFrame("Frame", nil, UIParent)
	local window = CreateFrame("Button", TITAN_BUTTON, f, "TitanPanelComboTemplate")
	window:SetFrameStrata("FULLSCREEN")
	-- Using SetScript to set "OnLoad" does not work
	--
	-- This routine sets the guts of the plugin - the .registry
	OnLoad(window);

	window:SetScript("OnShow", function(self)
		OnShow(self)
		-- This routine ensures the plugin is put where the user requested it.
		-- Titan saves the bar the plugin was on. It does not save the relative order.
		TitanPanelButton_OnShow(self);
	end)
	window:SetScript("OnClick", function(self, button)
		-- Typically this routine handles actions on left click
		OnClick(self, button);
		-- Typically this routine handles the menu creation on right click
		TitanPanelButton_OnClick(self, button);
	end)
end

Create_Frames() -- do the work
