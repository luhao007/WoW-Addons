---@diagnostic disable: duplicate-set-field
--[[ Tools.lua

The intent of this addon is provide a LDB example that works with Titan.
See dev notes at bottom.

By: The Titan Panel Development Team

--]]

-- ******************************** Constants *******************************

local add_on_id, NS = ...                            -- folder and Lua table
local _G = _G                                                --getfenv(0);

local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true) -- Titan_ID
local AceConfigDialog = LibStub("AceConfigDialog-3.0")       -- Titan_ID

local artwork_path = "Interface\\AddOns\\" .. add_on_id .. "\\Artwork\\"
local TITLE = "Titan UI"
local add_on_frame_name = "AddonFrame" .. add_on_id .. ""
local add_on_frame = {}
local VERSION = C_AddOns.GetAddOnMetadata(add_on_id, "Version")

-- ******************************** Variables *******************************
local trace = false -- true / false    Make true when debug output is needed.

local function SendSlash(slash)
	DEFAULT_CHAT_FRAME.editBox:SetText(slash)
	ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
end

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
	-- in case we can and want to modify in future...
	return elementDescription
end

---comment
---@param owner any Not used in this routine
---@param rootDescription table Root Menu object
local function GeneratorFunction(owner, rootDescription)
	local id = add_on_id
	local root = rootDescription -- menu widget to start with
	local elementDescription = {} -- used if creating nested menus

	if TitanUpdateConfig then -- Titan_ID
		local config = L["TITAN_PANEL_MENU_CONFIGURATION"] .. " "
		GenCommand(root, id, config .. L["TITAN_PANEL_MENU_OPTIONS_BARS"],
			function()
				TitanUpdateConfig("init")
				AceConfigDialog:Open("Titan Panel Bars")
			end)

		GenCommand(root, id, config .. L["TITAN_PANEL_MENU_PLUGINS"],
			function()
				TitanUpdateConfig("init")
				AceConfigDialog:Open("Titan Panel Addon Control")
			end)

		GenCommand(root, id, config .. L["TITAN_PANEL_MENU_PROFILES"],
			function()
				TitanUpdateConfig("init")
				AceConfigDialog:Open("Titan Panel Addon Profiles")
			end)

		elementDescription = root:CreateDivider()
		local t_reset = "/titanpanel reset"
		GenCommand(root, id, t_reset,
			function()
				SendSlash(t_reset)
			end)
	else
		-- skip, Titan not enabled
	end

	-- Helpful commands to developers
	elementDescription = root:CreateDivider()
	local fstack = "/fstack"
	GenCommand(root, id, fstack,
		function()
			SendSlash(fstack)
		end)

	elementDescription = root:CreateDivider()
	local lua_cmd = "/lua"
	GenCommand(root, id, lua_cmd,
		function()
			SendSlash(lua_cmd)
		end)

	elementDescription = root:CreateDivider()
	local etrace_cmd = "/eventtrace"
	GenCommand(root, id, etrace_cmd,
		function()
			SendSlash(etrace_cmd)
		end)

	elementDescription = root:CreateDivider()
	local api_cmd = "/api"
	GenCommand(root, id, api_cmd,
		function()
			SendSlash(api_cmd)
		end)

	elementDescription = root:CreateDivider()
	GenCommand(root, id, "Key binds - Keys",
		function()
			NS.GetKeyBinds("keys")
		end)
	GenCommand(root, id, "Key binds - Category",
		function()
			NS.GetKeyBinds("category")
		end)

	elementDescription = root:CreateDivider()
	GenCommand(root, id, "List Addons",
		function()
			NS.GetAddons()
		end)
end

--- Fill the tooltip given by the display addon
---@param tooltip table Tooltip frame from display addon
local function GetTooltipText(tooltip)
	local res = ""
	local rtn = "\n"
	local tab = "\t"

	tooltip:AddLine(TITLE .. " " .. VERSION)

	tooltip:AddDoubleLine(TitanUtils_GetNormalText("Current Server :"),
		TitanUtils_GetHighlightText(GetRealmName()))

	tooltip:AddLine("  ")

	local now = _G.time()

	local resets = "Resets in Server Time" .. rtn
	tooltip:AddLine(resets)
	local week_reset = C_DateAndTime.GetSecondsUntilWeeklyReset()
	tooltip:AddDoubleLine(TitanUtils_GetNormalText("Weekly :"),
		TitanUtils_GetHighlightText(TitanUtils_GetDateText(week_reset + now, true)))

	local day_reset = C_DateAndTime.GetSecondsUntilDailyReset()
	tooltip:AddDoubleLine(TitanUtils_GetNormalText("Daily :"),
		TitanUtils_GetHighlightText(TitanUtils_GetDateText(day_reset + now, true)))

	tooltip:AddLine("  ")

	tooltip:AddLine(TitanUtils_GetGreenText("Left Click: Reloads the User Interface"))
	tooltip:AddLine(TitanUtils_GetGreenText("Right Click: For Shortcuts and Debug Tools"))
end

---Create a header with the text and color given
---@param owner table Menu object
---@param label string Text to use
---@param color table Color to use
---@return table menu_obj
local function GenHeader(owner, label, color)
	if color == nil then
		color = GRAY_FONT_COLOR
	end
	local elementDescription =
		owner:CreateTitle(label, color)

	elementDescription:AddInitializer(function(frame, description, menu)
		local fontFile, height, flags = frame.fontString:GetFont()
	end
	)

	-- in case we can and want need to modify in future...
	return elementDescription
end

---Create menu to show to user
---@param owner table Menu object
---@return table menu_obj
function AddContextMenu(owner)
	local function gen_menu(plugin_frame, rootDescription)
		local root = rootDescription
		local elementDescription = {}

		elementDescription = root:CreateTitle(TITLE)
		elementDescription = root:CreateDivider()

		-- Attach widgets or show error!
		local succ, val = pcall(GeneratorFunction, plugin_frame, root)
		if succ then
			-- all good
		else
			GenHeader(root, add_on_id .. " !! " .. val, RED_FONT_COLOR)
		end

		-- Add the control variables + right side + Hide
		--			GenControlVars(root, plugin_frame.registry.id, true)
	end

	-- This does return a menu object but we choose to let Blizz handle opening through closing.
	return MenuUtil.CreateContextMenu(owner, gen_menu)

	-- CreateContextMenu will take other parameters (as ...) which are passed to GeneratorFunction.
end

---Create the LDB object and any init
---@param self table Plugin frame
local function OnLoad(self)
	local notes = ""
		.. "Adds a click to Reload UI and as menu for select help & tools to Titan Panel.\n"
	--		.."- xxx.\n"
	--[[
	Initialize the Data Broker 'button'.
	This is the heart of a LDB plugin. It determines how the display addon is to treat this addon.

	On successful :NewDataObject the display addon will have created a 'button' to display.

	Setting the type is required so the LDB lib and display addon know what to do. See the LDB spec.

	id passed in (add_on_id) will be the name Titan uses for the plugin. Found in the Titan Config or Titan right click menu.

	Below is a simple launcher.
	If creating a data source then routines will be needed to update .icon; .label; .text as needed.
	The LDB lib will handle the callback to the display addon.


	This addon tells the display addon to give it a blank tooltip by creating OnTooltipShow.
	When the display addon needs the tooltip, it will call this routine to have it filled in.
	Then the display addon will handle placement and show / hide.


	Note on Tooltips: The LDB spec is unclear on priority of method to choose. These include
	-- .tooltip : Implies a static tooltip; dislay addon will handle placement and show / hide
	-- OnTooltipShow : Display addon sends a blank GameTooltip type frame to be filled; 
	dislay addon will handle placement and show / hide
	-- OnEnter / OnLeave : Implies LDB is taking full control of tooltip; 
	dislay addon will call when cursor enters / leaves LDB 'button'


	--]]

	add_on_frame.obj =
		LibStub("LibDataBroker-1.1"):NewDataObject(add_on_id, -- Name used within Titan
			{
				type          = "launcher",             -- required
				-- LDB spec: The two options are:
				--      "data source" - Expected to show some type of info
				--      "launcher" - Expected to open another window or perform some action
				icon          = artwork_path .. "TitanReload", -- The icon used by the display addon
				label         = TITLE,             -- button label used by the display addon
				text          = "Reload UI", -- info displaed by the display addon; Updated as needed with this plugin if data source
				OnTooltipShow = function(tooltip)
					-- For the 'button' the display addon creates
					-- The display addon will give the empty tooltip then handle placement and show / hide
					GetTooltipText(tooltip)
				end,
				OnClick       = function(self, button)
					-- For the 'button' the display addon creates
					if (button == "LeftButton") then
						C_UI.Reload() -- user wants to reload the WoW UI
					elseif (button == "RightButton") then
						-- Create a menu using MenuUtil
						AddContextMenu(add_on_frame)
					end
				end,
				-- Titan specific!!
				-- Built-ins is reserved keyword for plugins bundled with Titan; default is General
				-- TITAN_PANEL_BUTTONS_PLUGIN_CATEGORY has list of categories
				category      = "Built-ins",
				notes      = notes,
			}
		)
end

---Create needed frames
local function Create_Frames()
	if _G[add_on_frame] then
		return -- if already created
	end

	if trace then
		TitanPluginDebug(add_on_id, "TS frames"
			.. " '" .. tostring(add_on_frame_name) .. "'"
		)
	end

	-- addon frame to get events and scripts
	add_on_frame = CreateFrame("Button", add_on_frame_name, UIParent)
	add_on_frame:SetFrameStrata("FULLSCREEN")
	-- Using SetScript to set "OnLoad" does not work
	--
	-- This routine sets the guts of the LDB addon
	OnLoad(add_on_frame);

	-- There is no frame for the user so On* scripts are not needed.
	-- The display addon will handle place and react to the LDB object.
	--[[
	add_on_frame:SetScript("OnShow", function(self)
		OnShow(self)
	end)
	add_on_frame:SetScript("OnClick", function(self, button)
		-- Typically this routine handles actions on left click
		OnClick(self, button);
	end)
--]]
end

Create_Frames() -- do the work

--[[ Development notes
The intent of this plugin a LDB example developers can use.
It also helps ensure Titan changes do not break simple LDB addons :).

This has Titan as a dependency.
If used as a generic LDB addon then remove all code with TITAN_ID in comments!!!
--]]
