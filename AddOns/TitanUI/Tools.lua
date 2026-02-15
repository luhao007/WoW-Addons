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

--[[
local function SendSlash(slash, params)
	DEFAULT_CHAT_FRAME.editBox:SetText(_G[slash] .. " " .. tostring(params))
	ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
end
SendSlash("SLASH_TitanPanel1", "reset")
--]]
local function SendSlash(slash)
	DEFAULT_CHAT_FRAME.editBox:SetText(slash)
	ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
end

local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_PLUGIN
	local root = rootDescription -- menu widget to start with

	local config = L["TITAN_PANEL_MENU_CONFIGURATION"].." "
	Titan_Menu.AddCommand(root, id, config..L["TITAN_PANEL_MENU_OPTIONS_BARS"],
		function()
			TitanUpdateConfig("init")
			AceConfigDialog:Open("Titan Panel Bars")
		end)

	Titan_Menu.AddCommand(root, id, config..L["TITAN_PANEL_MENU_PLUGINS"],
		function()
			TitanUpdateConfig("init")
			AceConfigDialog:Open("Titan Panel Addon Control")
		end)

	Titan_Menu.AddCommand(root, id, config..L["TITAN_PANEL_MENU_PROFILES"],
		function()
			TitanUpdateConfig("init")
			AceConfigDialog:Open("Titan Panel Addon Chars")
		end)

	Titan_Menu.AddDivider(root)
	local t_reset = "/titanpanel reset"
	Titan_Menu.AddCommand(root, id, t_reset,
		function()
			SendSlash(t_reset)
		end)

	Titan_Menu.AddDivider(root)
	local fstack = "/fstack"
	Titan_Menu.AddCommand(root, id, fstack,
		function()
			SendSlash(fstack)
		end)

	Titan_Menu.AddDivider(root)
	local lua_cmd = "/lua"
	Titan_Menu.AddCommand(root, id, lua_cmd,
		function()
			SendSlash(lua_cmd)
		end)
end

-- Grab the button text to display
local function GetButtonText(id)
	local strA, strB = TITLE, ""
	return strA, strB
end

-- Create the tooltip string
local function GetTooltipText()
	local res = ""
	local rtn = "\n"
	local tab = "\t"

	local realm = TitanUtils_GetNormalText("Current Server :") .. tab
		.. TitanUtils_GetHighlightText(GetRealmName()) .. rtn

	local now = _G.time()

	local resets = "Resets in Server Time" .. rtn
	local week_reset = C_DateAndTime.GetSecondsUntilWeeklyReset()
	local weekly = TitanUtils_GetNormalText("Weekly :") .. tab
		.. TitanUtils_GetHighlightText(TitanUtils_GetDateText(week_reset + now, true)) .. rtn

	local day_reset = C_DateAndTime.GetSecondsUntilDailyReset()
	local daily = TitanUtils_GetNormalText("Daily :") .. tab
		.. TitanUtils_GetHighlightText(TitanUtils_GetDateText(day_reset + now, true)) .. rtn

	local hints = ""
		.. TitanUtils_GetGreenText("Left Click: Reloads the User Interface") .. rtn
		.. TitanUtils_GetGreenText("Right Click: For Shortcuts and Debug Tools") .. rtn

	res = res
		.. realm
		.. rtn
		.. resets .. daily .. weekly
		.. rtn
		.. hints

	return res
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
		--		menuTextFunction = CreateMenu,
		menuContextFunction = GeneratorFunction, -- NEW scheme
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
		C_UI.Reload() --ReloadUI()
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
