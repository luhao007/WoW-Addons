---@diagnostic disable: duplicate-set-field
-- **************************************************************************
-- * TitanBag.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************

local addonName, addon = ...

-- ******************************** Constants *******************************
local _G = getfenv(0);

-- NOTE: The plugin id needs be unique across Titan plugins.
-- It does not need to match the addon id.
local artwork_path = "Interface\\AddOns\\" .. addonName .. "\\Artwork\\"
local TITAN_BAG_ID = "Bag";
-- NOTE: The convention is TitanPanel<id>Button to name Titan plugin frames
local TITAN_BUTTON = "TitanPanel" .. TITAN_BAG_ID .. "Button"

local TITAN_BAG_THRESHOLD_TABLE = {
	Values = { 0.5, 0.75, 0.9 },
	Colors = { HIGHLIGHT_FONT_COLOR, NORMAL_FONT_COLOR, ORANGE_FONT_COLOR, RED_FONT_COLOR },
}
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)

-- ******************************** Variables *******************************
local trace = false

local MIN_BAGS = 0
local MAX_BAGS = 0
local bag_data = {} -- to hold the user bag data

-- ******************************** Functions *******************************

-- Set so Retail and Classic can run
---@diagnostic disable-next-line: deprecated
local GetItemNow = C_Item.GetItemInfoInstant or GetItemInfoInstant

---Determine if this is a profession bag using only instant data rather than calling server
---@param slot number
---@return boolean
local function IsProfessionBagID(slot)
	-- The info needed is available using GetItemInfoInstant; only the bag slot or item id is required.
	-- A LOT of info is available but we only need class and subclass here.
	-- itemType : warcraft.wiki.gg/wiki/itemType
	local res = false
	local info, itemId, itemType, itemSubType, itemEquipLoc, itemTexture, classID, subclassID
	local inv_id = C_Container.ContainerIDToInventoryID(slot)

	if inv_id == nil then
		-- Only works on bag and bank bags NOT backpack!
		-- However the backpack is never a profession bag.
	else
		info = GetInventoryItemLink("player", inv_id)
		if info == nil then
			-- Slot likely empty, no need to process.
		else
			itemId, itemType, itemSubType, itemEquipLoc, itemTexture, classID, subclassID = GetItemNow(info)
			if classID == 1 then -- is a container / bag
				if subclassID >= 1 then
					-- profession bag of some type [2 - 10] Jan 2024 (DragonFlight / Wrath / Classic Era)
					-- OR soul bag [1]
					res = true
				else
					-- is a arrow or bullet bag; only two options
				end
			elseif classID == 6 then -- is a 'projectile' holder
				res = true
				-- is a ammo bag or quiver; only two options
			elseif classID == 11 then -- is a 'quiver'; Wrath and CE
				res = true
				-- is a ammo pouch or quiver; only two options
				-- style = subclassID + 20 -- change to get local color for name
			else
				-- not a profession bag
			end
		end
	end

	return res
end

---Tell the UI to open / close the bags
local function ToggleBags()
	if TitanGetVar(TITAN_BAG_ID, "OpenBags") then
		ToggleAllBags()
	else
		-- User has not enabled open on click
	end
end

---Collect bag info - name, slots (total, used, free), name (if available).
--- The bag name is not always available when player entering world but the required info is.
---@param id string Plugin ID
local function GetBagData(id)
	--[[
	The bag name is not always available when player entering world.
	The user may see bag name as <unknown> until an event triggers a bag check AND the name is available.
	Grabbing the total slots is available on client to determine if a bag exists and get its free / used counts.
	--]]
	-- 2024 Jan : Moved away from named based to id based. Allows name to come later from server
	-- 2024 Aug : Removed coloring of bag name to focus on counts which is the real info.

	if trace then
		TitanPluginDebug(TITAN_BAG_ID, "T GetBagData"
			.. " '" .. tostring(id) .. "'"
		)
	end
	local total_slots = 0
	local total_free = 0
	local total_used = 0
	local is_prof_bag = false
	-- calculated but not used ATM
	local prof_slots = 0
	local prof_free = 0
	local prof_used = 0

	for bag_slot = MIN_BAGS, MAX_BAGS do -- assuming 0 (Backpack) will not be a profession bag
		-- Ensure a blank structure exists.
		-- Blanking data may seem overkill but it allows the plugin to react to events without
		-- caring when they occur and it will set the bag name when it arrives AND an event occurs.
		bag_data[bag_slot] = {
			has_bag = false,
			name = "",
			max_slots = 0,
			free_slots = 0,
			used_slots = 0,
			style = "",
			color = "",
		}

		local slots = C_Container.GetContainerNumSlots(bag_slot)

		-- Check type here to set slot style properly.
		-- Profession bags are NOT included in overall free / used counts
		local bag_type = "none"
		is_prof_bag = IsProfessionBagID(bag_slot)

		-- Blizz treats 'last' slot as a reagent only slot...
		-- For our purpose, treat it as a profession bag.
		if is_prof_bag or bag_slot == 5 then
			bag_type = "profession"
		else
			bag_type = "normal"
		end
		bag_data[bag_slot].style = bag_type

		if slots > 0 then
			bag_data[bag_slot].has_bag = true

			local bag_name = (C_Container.GetBagName(bag_slot) or UNKNOWN)
			bag_data[bag_slot].name = bag_name
			bag_data[bag_slot].max_slots = slots

			local free = C_Container.GetContainerNumFreeSlots(bag_slot)
			local used = slots - free
			bag_data[bag_slot].free_slots = free
			bag_data[bag_slot].used_slots = used


			-- add to total
			if bag_data[bag_slot].style == "profession" then
				prof_slots = prof_slots + slots
				prof_free = prof_free + free
				prof_used = prof_used + used
			else
				total_slots = total_slots + slots
				total_free = total_free + free
				total_used = total_used + used
			end
		else
			bag_data[bag_slot].has_bag = false
			bag_data[bag_slot].name = NONE
		end

		if trace then
			TitanPluginDebug(TITAN_BAG_ID, "...T GetBagData"
				.. " " .. tostring(bag_slot) .. ""
				.. " ?:" .. tostring(bag_data[bag_slot].has_bag) .. ""
				.. " max: " .. tostring(bag_data[bag_slot].max_slots) .. ""
				.. " used: " .. tostring(bag_data[bag_slot].used_slots) .. ""
				.. " free: " .. tostring(bag_data[bag_slot].free_slots) .. ""
				.. " type: " .. tostring(bag_data[bag_slot].style) .. ""
				.. " prof: " .. tostring(is_prof_bag) .. ""
				.. " '" .. tostring(bag_data[bag_slot].name) .. "'"
			)
		end
	end

	-- Normal bags
	bag_data.total_slots = total_slots
	bag_data.total_free = total_free
	bag_data.total_used = total_used

	-- Profession / reagent bags
	bag_data.prof_slots = prof_slots
	bag_data.prof_free = prof_free
	bag_data.prof_used = prof_used
end

---plugin Handle registered events
---@param self Button
---@param event string
---@param ... any
local function OnEvent(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		-- Leave in case future code is needed...
	elseif event == "BAG_UPDATE" then
		-- update the plugin text
		TitanPanelButton_UpdateButton(TITAN_BAG_ID);
	elseif event == "BAG_CONTAINER_UPDATE" then
		-- 2024 Aug : Added as additional check if user swaps bags; may not be required
		-- update the plugin text
		TitanPanelButton_UpdateButton(TITAN_BAG_ID);
	end

	if trace then
		TitanPluginDebug(TITAN_BAG_ID, "_OnEvent"
			.. " " .. tostring(event) .. ""
		)
	end
end

---Opens all bags on a LeftClick
---@param self Button
---@param button string
local function OnClick(self, button)
	if (button == "LeftButton") then
		ToggleBags();
	end
end

--[[ Where the magic happens for plugin text!
It is good practice - and good memory - to document the 'why' the code does what it does.
And give details that are not obvious to the reader who did not write the code.
--]]

---Generate the plugin button text
---@param id string
---@return string
---@return string
local function GetButtonText(id)
	GetBagData(id)

	local bagText = ""
	if TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots") then
		bagText = format(L["TITAN_BAG_FORMAT"], bag_data.total_used, bag_data.total_slots);
	else
		bagText = format(L["TITAN_BAG_FORMAT"], bag_data.total_free, bag_data.total_slots);
	end

	local bagRichText = ""
	if (TitanGetVar(TITAN_BAG_ID, "ShowColoredText")) then
		local color = ""
		color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, bag_data.total_used / bag_data.total_slots);
		bagRichText = TitanUtils_GetColoredText(bagText, color);
	else
		bagRichText = TitanUtils_GetHighlightText(bagText);
	end

	bagRichText = bagRichText
	--..bagRichTextProf[1]..bagRichTextProf[2]..bagRichTextProf[3]..bagRichTextProf[4]..bagRichTextProf[5];

	if trace then
		TitanPluginDebug(TITAN_BAG_ID, "T GetBagData"
			.. " '" .. tostring(bagRichText) .. "'"
		)
	end
	return L["TITAN_BAG_BUTTON_LABEL"], bagRichText
	-- Notice the two return params - label and plugin text
end

---Determine the color based on percentage
---@param text string
---@param show_color boolean
---@param numerator number
---@param denom number
---@return string
local function ThresholdColor(text, show_color, numerator, denom)
	local res = ""
	local color = ""
	if show_color then
		if denom == 0 then
			color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, 1);
		else
			color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, numerator / denom);
		end
		res = TitanUtils_GetColoredText(text, color);
	else
		-- use without color
		res = TitanUtils_GetHighlightText(text);
	end

	return res
end

---Generate tooltip text
---@return string
local function GetTooltipText()
	-- Normal shows free / used of total per user options.
	-- Detailed shows list bags with profession bag counts in gray - not counted.
	-- Hint shows if user selects open bags on left click.
	--#region-- 2024 Aug (8.1.0) : With the addition of new 'reagent' slot, we dropped coloring & counting profession bags.
	local returnstring = "";
	local show_color = TitanGetVar(TITAN_BAG_ID, "ShowColoredText")

	-- Collect names and x / y numbers, color numbers if user requested
	if TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo") then
		returnstring = "\n";
		if TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots") then
			returnstring = returnstring .. TitanUtils_GetNormalText(L["TITAN_BAG_MENU_TEXT"])
				.. ":\t" .. TitanUtils_GetNormalText(L["TITAN_BAG_USED_SLOTS"]) .. ":\n";
		else
			returnstring = returnstring .. TitanUtils_GetNormalText(L["TITAN_BAG_MENU_TEXT"])
				.. ":\t" .. TitanUtils_GetNormalText(L["TITAN_BAG_FREE_SLOTS"]) .. ":\n";
		end

		for bag = MIN_BAGS, MAX_BAGS do
			local bagText = ""
			local bagRichText

			if bag_data[bag] then
				if bag_data[bag].has_bag then
					-- Format the x / y slots per user options
					if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
						bagText = format(L["TITAN_BAG_FORMAT"], bag_data[bag].used_slots, bag_data[bag].max_slots);
					else
						bagText = format(L["TITAN_BAG_FORMAT"], bag_data[bag].free_slots, bag_data[bag].max_slots);
					end
					-- Format x / y per user options
					if bag_data[bag].style == "profession" then
						bagRichText = TitanUtils_GetGrayText(bagText)
					else
						bagRichText = ThresholdColor(bagText, show_color, bag_data[bag].used_slots,
							bag_data[bag].max_slots)
					end
				else
					bagRichText = ""
				end
				-- Format bag name as 'normal' 2024 Aug
				local name_text = TitanUtils_GetNormalText(bag_data[bag].name)
				returnstring = returnstring .. name_text .. "\t" .. bagRichText .. "\n";
			else
				--Silent error - should never get here...
			end
		end
		returnstring = returnstring .. "------\t" .. "---\n";
	end

	-- Always show free / used of max slots to user
	local xofy = ""
	local slots = ""
	if TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots") then
		xofy = "" .. tostring(bag_data.total_used) .. "/" .. tostring(bag_data.total_slots)
		xofy = ThresholdColor(xofy, show_color, bag_data.total_used, bag_data.total_slots)
		slots = L["TITAN_BAG_USED_SLOTS"]
	else
		xofy = "" .. tostring(bag_data.total_free) .. "/" .. tostring(bag_data.total_slots)
		xofy = ThresholdColor(xofy, show_color, bag_data.total_free, bag_data.total_slots)
		slots = L["TITAN_BAG_FREE_SLOTS"]
	end
	returnstring = returnstring .. TitanUtils_GetNormalText(slots) .. ":\t" .. xofy .. "\n"

	-- Add Hint if user wants to open bags on left click.
	if TitanGetVar(TITAN_BAG_ID, "OpenBags") then
		returnstring = returnstring .. "\n" .. TitanUtils_GetGreenText(L["TITAN_BAG_TOOLTIP_HINTS"])
	else
		-- nop
	end
	return returnstring
end

--[=====[ OLD menu scheme
 Using registry.menuTextFunction
--]=====]
--Generate and display rightclick menu options for user.
local function PrepareBagMenu()
	local info
	-- level 1
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BAG_ID].menuText);

	info = {};
	info.text = L["TITAN_BAG_MENU_SHOW_USED_SLOTS"];
	info.func = function()
		TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", 1);
		TitanPanelButton_UpdateButton(TITAN_BAG_ID);
	end
	info.checked = TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots");
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.text = L["TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS"];
	info.func = function()
		TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", nil);
		TitanPanelButton_UpdateButton(TITAN_BAG_ID);
	end
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots"));
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.text = L["TITAN_BAG_MENU_SHOW_DETAILED"];
	info.func = function()
		TitanToggleVar(TITAN_BAG_ID, "ShowDetailedInfo");
	end
	info.checked = TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo");
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.text = L["TITAN_BAG_MENU_OPEN_BAGS"]
	info.func = function()
		TitanToggleVar(TITAN_BAG_ID, "OpenBags")
	end
	info.checked = TitanGetVar(TITAN_BAG_ID, "OpenBags");
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddControlVars(TITAN_BAG_ID)
end
--[=====[ NEW menu scheme Jan 2026

Blizzard introduced a new menu scheme in 11.0.0 (July 2024) coded in Blizzard_Menu.
Set registry.menuContextFunction  !!! This is how Titan knows to use the Blizzard_Menu scheme!!!

See TitanMenu.lua for more info on the wrappers Titan uses to help devs
and the differences in old and new schemes.

A new Titan registry attribute, .menuContextFunction, was added to the .registry.
It was created to do explicitly state the new plugin menu routine needed to create the menu widgets.
Titan will use, in order :
1) registry.menuContextFunction  : NEW Jan 2026
2) registry.menuTextFunction  : Feb 2024
3) "TitanPanelRightClickMenu_Prepare" .. id .. "Menu" : Old as Titan :)

On right click, Titan will create the context menu and call the plugin menu routine to fill it as before.
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
Where the parameters are:
- root - is the context menu to attach to
- id - plugin ID
- label - locale string 'Open Bags'
- opt - option as listed in .savedVariables
A labeled checkbox will be placed inline on the root menu. It will have a different style than the older TitanBag.
Note: 'root' could be at an arbitrary menu level. It is just a menu button.
Note: Titan_Menu.AddSelector passes the 'is selected' and 'set selected' as function. 
As a simple toggle, these functions are known.

--]=====]

---Generate and display right click menu options for user.
---@param owner table Plugin frame
---@param rootDescription table Menu context root
local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_BAG_ID
	local root = rootDescription -- menu widget to start with
	--[[
	'GeneratorFunction' is what Blizzard uses in its implementation, this name is abitrary

	The Titan right click handler will initiate creating the context menu by calling MenuUtil.CreateContextMenu.
	MenuUtil.CreateContextMenu will secure call this function with
	- 'owner' - which is _G[TITAN_BUTTON], the plugin frame
	- and
	- 'rootDescription' - the menu object internally created to attach menu widgets to
	
	rootDescription is the new dropdown level 1.
	Attaching a new menu object to a button description is the same as setting info.arrow.

	NOTES:
	- The API routines used here are in TitanMenu.lua. They wrap the Blizz scheme in case they change it...
	- The API routines add Titan patterns and conventions that used to be hand coded via info.* attributes.
	Ideally relieving the dev from tedious setup. And giving Titan menus a more consistent look.
	-
	- Titan will add a menu title at top using .registry.id
	- Titan will add the control vars on bottom of menu.

	Bags does not have a nested menu. 
	Use built-ins such as Gold for examples of nesting and more widget types.
--]]

	-- !! Title added by Titan

	-- These are simple toggles with Titan 'update button' on change
	Titan_Menu.AddSelector(root, id, L["TITAN_BAG_MENU_SHOW_DETAILED"], "ShowDetailedInfo")
	Titan_Menu.AddSelector(root, id, L["TITAN_BAG_MENU_OPEN_BAGS"], "OpenBags")

	local disp = { -- selectors using the same option - label, value
		{L["TITAN_BAG_MENU_SHOW_USED_SLOTS"], true},
		{L["TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS"], false},
	}
	-- This adds a divider before the selectors
	Titan_Menu.AddSelectorList(root, id, nil, "ShowUsedSlots", disp)

	-- !! Control vars added by Titan
end

---plugin Registers the plugin and simple init
---@param self Button
local function OnLoad(self)
	local notes = "" -- Added to Titan > Config > Plugin for user to read
		.. "Adds bag and free slot information to Titan Panel.\n"
		.. "- Menu moved to new scheme Jan 2026.\n"

	-- The guts of any Titan plugin! See comments at end of file below.
	self.registry = {
		id = TITAN_BAG_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_BAG_MENU_TEXT"],
		menuTextFunction = PrepareBagMenu, -- OLD scheme (2nd priority)
		menuContextFunction = GeneratorFunction, -- NEW scheme (1st priority)
		buttonTextFunction = GetButtonText,
		tooltipTitle = L["TITAN_BAG_TOOLTIP"],
		tooltipTextFunction = GetTooltipText,
		icon = artwork_path .. "TitanBag",
		iconWidth = 16,
		notes = notes,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			ShowUsedSlots = 1,
			ShowDetailedInfo = false,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			DisplayOnRightSide = false,
			OpenBags = true,
		}
	};

	-- As of Apr 2024 (10.2.7) the taint on opening bags in Retail is fixed.

	-- Reagent bag slot added end of DragonFlight for War Within expansion.
	if NUM_TOTAL_EQUIPPED_BAG_SLOTS == nil then -- NOT Retail as of DragonFlight WHY BLIZZ!?
		MAX_BAGS = Constants.InventoryConstants.NumBagSlots
	else                                     -- Classic API
		MAX_BAGS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
	end

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

---Prep and update plugin button here to minimize resources.
---@param self Button
local function OnShow(self)
	-- Register for bag updates and update the plugin text
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("BAG_CONTAINER_UPDATE")
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

---Shutdown plugin button here to minimize resources.
---@param self Button
local function OnHide(self)
	self:UnregisterEvent("BAG_UPDATE")
	self:UnregisterEvent("BAG_CONTAINER_UPDATE")
end

---Create needed plugin frames
local function Create_Frames()
	if _G[TITAN_BUTTON] then
		return -- if already created
	end
	-- Using _G converts the string into a table reference in the global namespace

	-- general container frame
	local f = CreateFrame("Frame", nil, UIParent)
	--	f:Hide()

	-- Titan plugin button
	--[[
	The plugin frame is created here.
	All scripts and events are attached to this frame.
	
	The typical plugin is a 'combo' which includes
	- an icon (can be shown or hidden)
	- label - value pair where the label can be turned off
	There can be multiple label - value pairs; TitanPerformance uses this scheme.
	
	The frame is 'forever' as are most of WoW game frames.
	--]]
	local window = CreateFrame("Button", TITAN_BUTTON, f, "TitanPanelComboTemplate")
	window:SetFrameStrata("FULLSCREEN")
	-- Using SetScript("OnLoad",   does not work
	OnLoad(window);
	--	TitanPanelButton_OnLoad(window); -- Titan XML template calls this...

	--[[
	Below are the frame 'events' that need to be processed.
	
	The desired Titan design is :
	- register events and timers when the user places the plugin on the bar (OnShow)
	- unregister events and timers when the user hides the plugin (OnHide).
	This reduces resources the plugin uses when the user does not want the plugin.
	
	Notes:
	- If a Titan bar is hidden, the plugins on it will still run.
	- Titan plugins are NOT child frames!! Plugins are not hidden (OnHide) when the bar they are on is hidden!
	--]]
	window:SetScript("OnShow", function(self)
		OnShow(self);
		TitanPanelButton_OnShow(self);
	end)
	window:SetScript("OnHide", function(self)
		OnHide(self)
	end)
	window:SetScript("OnEvent", function(self, event, ...)
		OnEvent(self, event, ...)
	end)
	window:SetScript("OnClick", function(self, button)
		OnClick(self, button);
		TitanPanelButton_OnClick(self, button);
	end)
end

Create_Frames() -- do the work

--[[ Titan Bag with Explanation

The intent is to clarify what may appear to be a daunting experience.

We suggest you grab your favorite beverage, read this doc, and relax!
Many of Titan plugin mysteries will be explained;
helping you create a tool your audience will enjoy. 🙂

The Titan team and its users are available to answer questions.
The two most used ways are :
- The Titan Discord community - faster
- Curse comments under Titan Panel addon

Using a text editor with code folding features will make this file easier to read and find information.
Notepad++ is a popular Windows code editor.
Visual Studio Code with a couple extensions is used to develop Titan and its built-ins.

Before you start changing this example, it is HIGHLY recommended to install the following WoW addons:
- BugGrabber : Grabs errors and stores them
- BugSack : The visual part of BugGrabber
- WowLua or Script Library or another addon that allows you to try Lua code directly inside WoW.

Small changes are recommended; then test your coding.
When testing, just start or reload WoW. All versions now check and load new files on reload.

--]]

--[[ Titan Panel Notes:
- Use the current version of Titan to ensure no errors.
- You may freely use this example for addon development and publish it on WoW addon sites like Curseforge. 
- If published, please add the Titan addon tag for users.
- The terms addon and plugin are essentially the same. 
Within this document, plugin is used when the addon is displayed by Titan.
- Titan includes several libraries under the Titan/libs folder. You are free to use these.
If you require additional libraries, please include them within your addon.

=== Out of Scope Notes:
- A discussion on Lua syntax. A basic understanding of Lua is assumed.
- Timers are outside the scope of this example. 
See other Titan built-in plugins that use timers (AceTimer) such as TitanClock.
- Localization of strings presented to the user. Titan uses AceLocale; other addons use different schemes.
- Titan includes the Ace libraries it uses - not the entire library. (https://www.wowace.com)
- The API for LDB (LibDataBroker) : (https://github.com/tekkub/libdatabroker-1-1)
- WoW images : Some image type info (https://warcraft.wiki.gg/wiki/API_TextureBase_SetTexture)
--]]

--[[ “Best Practices” When Creating Your Addon/Plugin
=== Naming Convention
When publishing your addon/plugin please use this naming convention :

Titan Panel [Name]

Using this naming format, most Titan users will understand this plugin is intended for Titan Panel.
They should know to contact you first instead of the Titan Panel team.
The Titan team does receive comments and errors from time to time. We usually tell them to contact the plugin developer.

=== Additional Help For You
A good Lua resource is https://www.lua.org/docs.html
NOTE: WoW uses Lua version 5.1 as its base.
NOTE: WoW does restrict, add, or even remove some Lua features. For example the file routines and many OS routines are not available to an addon.

There are sites that have deeper explanations about addon development, such as
- Wowhead.com
- Warcraft wiki (Warcraft.Wiki.gg).
Please use these or other sites for more detailed addon and API information. The API does change over time.
--]]

--[[ Running this right now!
The folder and .toc file prefix MUST be the same to load into WoW!
See the .toc section under Example Folder Structure.

=== Steps needed to run this as another plugin called TitanPlugin:
- Copy this example to your WoW installation: ../World of Warcraft/_retail_/Interface/AddOns
- Ensure the folder name is TitanPlugin
- Change TitanBag.toc to TitanPlugin.toc
- Open TitanBag.lua change line(s) below:

local TITAN_PLUGIN = "Bag"
==>>
local TITAN_PLUGIN = "Plugin"


- Start or reload WoW

That is it!
You should see another Titan Bag icon in any version of WoW you are running.
You are now ready to start changing code.

First Routines to change:
- GetBagData and local routines & variables will be replaced by your code.
- ToggleBags is called from OnClick. This will be replaced by your code that handles mouse clicks.
- CreateMenu will be changed to implement your right click menu, if one is needed.

Change other routines as needed to implement your idea.
--]]

--[[ Example Folder Structure
Inside this folder you will notice :
- Artwork folder : with one .tga file - the icon used by the plugin
- libs : empty, ready for any library routines you may need
- a .toc file
- one .lua file – for your great idea
- a ReadMe file - This file
--]]

--[[ .toc

The folder and the .toc files MUST have the same name!
Sort of... the name prior to the underscore(_) must be the same as the folder name.
The part after the underscore (postfix) has meaning to the WoW addon loader.
https://warcraft.wiki.gg/wiki/TOC_format : Contains the full list and A LOT more detail about .toc files

=== .toc internals
NOTE: The ## Interface value should match the current interface value of the corresponding WoW version.
In BattleNet this is typically shown below the 'Play' button.
DragonFlight 10.02.05 is represented without dots - 100207 - in the .toc.

If the interface value is higher or lower, WoW will complain that you are running 'out of date' addons.

The value Bag is a list representing retail, Classic, and Classic Era WoW versions.

== .lua

This is the code for the plugin.

Titan specific details will be noted and explained within the Lua file.
The comments will specify where names are important.

The plugin starts with local constants; then local variables; then functions.

Our suggestion to learn how plugins work is to start with Create_Frames routine at the bottom of the file. It is where the magic starts.

NOTES:
- Titan locale strings (using AceLocale) were left in the code so the example will run as is. Please use your own strings - localized or not.
- Feel free to look at Titan code for Lua examples.
- Any Lua routine in the Titan folder marked with ---API can be used by a plugin.
Titan API routines will be maintained and the functionality expected to remain stable.
Any parameter or functionality changes to API will be 'broadcast' on delivery sites and our Discord site.

=== .tga

This file is the icon used by the plugin.
This file is also specified in the .registry of the Lua file – detailed later in this doc.
--]]

--[[ Addon code flow

First step: ==== Starting or reloading WoW
Wow will load this addon after Titan is loaded.

NOTE: The .toc states Titan is required [## Dependencies: Titan].
WoW will load Titan BEFORE this addon.

Any code outside the Lua functions will be run.
Examples:
- local VERSION = GetAddOnMetadata(add_on, "Version") will run GetAddOnMetadata
- bag_info will be populated
- ...
- Create_Frames is called

Create_Frames will create the addon frame and name it the string in TITAN_BUTTON.
NOTE: The check at the top prevents recreating frames on reload of WoW (includes any WoW 'splash' screen)
All created frames will be in the global namespace.
All created frames are forever – they are not touched by the Lua garbage collection.

Then local OnLoad is called when WoW loads the frame into memory.

OnLoad does two important things
1) Sets the .registry of the addon - See the .registry attributes comment block below
2) Registers for event PLAYER_ENTERING_WORLD

NOTE: OnLoad should :
- Be small
- NOT assume plugin saved variable data are ready / loaded yet

Then Create_frames sets the frame scripts for the addon. See Frame Scripts block.

Next: ==== Waiting for WoW
WoW fires a bunch of events as this and other addons are loaded.

Eventually the game and all addons are loaded and this plugin receives the PLAYER_ENTERING_WORLD event via the frame script OnEvent.
When processing PLAYER_ENTERING_WORLD, only register for events and access local data this plugin needs.
Do NOT assume saved variables from the registry or any server data are ready.

Titan also receives the PLAYER_ENTERING_WORLD event.
It is best to assume there is NO guarantee this plugin receives the event before or after Titan!

Titan then processes its own data, creates Titan bars, registers Titan plugins and LDB addons, and syncs plugin saved variables.
Titan will process any saved variables specified in the .registry of this plugin!

Next: ==== Still waiting...
Titan shows the user requested bars with the user requested plugins.

By default Titan third party plugins are not enabled.
The user will enable your plugin via Titan menu or Titan Config.
OnShow is called by Titan only if the user has enabled the plugin.
It is called on enabling and then each start or reload of WoW.

OnShow now does the processing to set up this plugin and its data properly.
Lastly OnShow needs to call TitanPanelButton_UpdateButton to update the plugin text.
The plugin is now ready for the user.

NOTES: For OnShow
- It is best to assume any saved variables in .registry are NOT ready until OnShow!
- Register for needed events here to reduce resource usage and avoid surprises.
- Enable any timers or OnUpdate after this point.
- Process any saved variable data such as user options
- Set the initial plugin - icon, label, text

Next: ==== Ready to use your plugin. Yeah!
The plugin will be 'idle' until one of the following occur:
- Titan needs to (re)display this plugin - via TitanPanelButton_UpdateButton
- User changes a plugin option using the Titan plugin menu :  TitanPanelButton_UpdateButton
- User clicks on this plugin - Right click calls routine in registry .menuTextFunction; any other OnClick enabled
- Any registered event is received - OnEvent
- User mouses over plugin - OnEnter calls routine in registry .buttonTextFunction
- User mouse leaves plugin - OnLeave clears tooltip on timeout or click elsewhere
- A timer or callback calls a plugin routine – AceTimer

Next: ====
The above steps continue until:
- User hides the plugin - OnHide
- The user logs out the character or exits WoW or reloads UI - Onhide
- Cleanup any plugin specific data or objects

Notes: For Onhide :
- Any events should be unregistered here to reduce resources.
- Any timers should be stopped.

On logout or exit the saved variables are saved to the local system - .registry.savedVariables .
No additional actions are required.

==== TitanPanelButton_UpdateButton(TITAN_PLUGIN) should be called by this plugin whenever the plugin text changes :
- On processing an event registered for
- On user left click – some action taken
- On user right click – plugin menu changes

TitanPanelButton_UpdateButton will call the routine in registry .menuTextFunction - GetButtonText.
This is the magic that updates your plugin button text!

You will notice GetButtonText returns two values - a label and the actual text.
Display of the label is handled by the user selecting 'show label' in Titan config or Titan menu.
This is controlled by registry ShowLabelText.

NOTE: TitanPanelButton_UpdateButton can handle up to 4 label - value pairs.
TitanPerformance is an example that uses and shows multiple label - value pairs, based on user selection.

==== OnEnter and OnLeave
NOTE: The Titan template handles OnEnter and OnLeave to show or hide the tooltip.
Titan calls the specified routine to show the tooltip – registry.tooltipTextFunction.
Titan expects a formatted string as the return from the function.

==== Additional saved variables specific to this addon must be handled by this addon and are outside the scope of this example.
You can specify your own table to be saved. Titan Gold is a Titan plugin that has its own saved variables.
--]]

--[[ Frame Scripts

The frame scripts are how WoW and Titan interact with this addon.

NOTE: The creation of the frame also creates scripts handlers.
This is a bit hidden by the 'inherits' "TitanPanelComboTemplate" :
	local window = CreateFrame("Button", TITAN_BUTTON, f, "TitanPanelComboTemplate")
TitanTemplate.xml defines TitanPanelButtonTemplate as the base for each of its plugin types - Combo / Text / Icon.
TitanPanelButtonTemplate sets OnLoad / OnShow / OnClick / OnEnter / OnLeave where each calls TitanPanelButton_On*.
If the script is overriden in the plugin, it should call the appropriate TitanPanelButton_On* routine as shown below.
In a few cases, the default is not called because the plugin replaces what Titan would do.
TitanPerformance, for example overrides OnClick to create a custom right click menu.

==== OnShow script :
This is triggered when this plugin (frame) is shown.
Technically :
- WoW calls the now registered plugin frame - TITAN_BUTTON:OnShow() as set in Create_Frames
- Which calls the local OnShow to init the plugin
- Then calls TitanPanelButton_OnShow to update the plugin button text

==== OnClick script :
This is triggered when this plugin (frame) has been clicked by the mouse.
Technically :
- WoW calls the now registered plugin frame - TITAN_BUTTON:OnClick() as set in Create_Frames
- Which calls the local OnClick to handle left click (or any click / mod-click other than right click)
- Then calls TitanPanelButton_OnClick to handle right click (plugin menu) – see ‘Right Click’ below

== Right click:
TitanPanelButton_OnClick is called to handle right click generically because it will
- Close any open control frame
- Close any open tooltip
- Position the menu relative to the plugin on whatever Titan bar it is on
- Call the plugin routine to create the actual menu content
- (menuTextFunction = PrepareBagMenu)

The plugin can inform Titan of the routine in one of two ways:
1) Specify in .registry.menuTextFunction - preferred
2) Named routine in the global namespace with the expected name of - TitanPanelRightClickMenu_Prepare<id>Menu
- For this plugin the name would be TitanPanelRightClickMenu_PluginMenu
Titan will use the registry over the created routine. It will not use both.

==== OnEnter script :
OnEnter is handled by the Titan template to show the tooltip next to the plugin wherever it may be.
It calls the routine specified (tooltipTextFunction = GetTooltipText).
This routine is expected to return a formatted string to be shown in the tooltip.

==== OnLeave script :
OnLeave is handled by the Titan template to hide the tooltip.

==== OnHide script :
This is triggered when this plugin (frame) has been hidden by the user :
- via the Titan menu
- via Titan config
- On exit or logout or reload
Technically :
- WoW calls the now registered plugin frame - TITAN_BUTTON:OnHide() as set in Create_Frames
- Which calls the local OnHide

==== OnEvent script :
This is triggered when any event this plugin (frame) has registered for is fired.
Technically :
- WoW calls the now registered plugin frame - TITAN_BUTTON:OnEvent() as set in Create_Frames
- Which calls the local OnEvent to handle all registered events

BAG_UPDATE just updates the text (count) whenever this event is fired.
--]]

--[[ .registry attributes
This is the GUTS of a Titan plugin.
The .registry table on the frame contains all the information to register the plugin for display.

Every plugin registry with an id should appear in Titan > Configuration > Attempts.
Information about the plugin is shown there along with pass / fail information.

Attributes:
.id : Required : must be unique across Titan plugins. If there are duplicates, the first one 'wins'.
.category : The general grouping this plugin is in.
	The complete category list is in TITAN_PANEL_BUTTONS_PLUGIN_CATEGORY (TitanGlobal.lua)
	"Built-ins" is reserved for plugins that Titan releases.
.version : plugin version shown in menus and config.
.menuText : Used as the title for the right click menu.
.menuTextFunction : See .registry Routines below.
.menuContextFunction : See .registry Routines below. NEW Jan 2026
.buttonTextFunction : See .registry Routines below.
.tooltipTitle : Used as the title for the tool tip
.tooltipTextFunction : See .registry Routines below.
.icon : Path to the icon to be used.
	It is recommended to store the icon in the plugin folder, even if exists within WoW.
.iconWidth : Best left at 16...
.notes : This is shown in Titan > Config > Plugins when this plugin is selected.
.controlVariables : This list is controls whether the variable is shown. See below.
.savedVariables : These are the variables stored in Titan saved variables.
	The initial values are used only if that particular entry is 'new' to Titan
	(new Titan install, new character, character new to Titan).
	If a value is removed then it is removed from the saved variables as Titan is run for each character.

== .controlVariables
These are used to show or hide 'controls' in the Titan config or Titan right click menu.
- ShowIcon
- ShowLabelText
- ShowColoredText
- DisplayOnRightSide
- ShowRegularText (LDB only)
If true, the control is shown to the user.
If false, the control is not shown to the user.
--]]

--[[ .registry Saved Variables

All saved variables for this plugin are listed within savedVariables
		savedVariables = {
			ShowUsedSlots = 1,
			ShowDetailedInfo = false,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			DisplayOnRightSide = false,
			OpenBags = true,
		}

Plugin variables :
- OpenBags : Whether to open bags on left click or not.
Included due to a taint issue introduced by WoW which has been fixed but left to allow user choice.

Titan uses the below to control display of the plugin :
- ShowIcon : Whether the icon,if specified is shown
- ShowLabelText : Whether the labels returned by buttonTextFunction are shown
- ShowColoredText : Whether the text is 'colored' or not
- DisplayOnRightSide : Put this plugin in the right side of the Titan bar

ShowColoredText is plugin specific. Generally used to indicate a range such as your bags are empty (green) to nearly full (red).
If the plugin does not need this then please set controlVariables > ShowColoredText to false to prevent the user from seeing
the option and potentially getting confused.

NOTE: Titan routines have used 1 as true since inception so be careful on 'true checks'.
"if ShowUsedSlots then " *should* work fine if ShowUsedSlots is true or 1

--]]

--[[ .registry Routines

Titan looks for specified routines in the .registry :
- .buttonTextFunction : Routine that updates the plugin button text.
- .tooltipTextFunction : Routine that generates the tool tip text.
- .menuContextFunction : NOTE: Creating menu below
- .menuTextFunction : NOTE: Creating menu below

.buttonTextFunction : This is called whenever the button is to be updated.
	This is called from within the plugin and from Titan via TitanPanelButton_UpdateButton(TITAN_PLUGIN) .
	Titan will usually return "<?>" if the routine dies.
	If you need to see the error, search for this attribute in the Titan folder and uncomment the print of the error message.
	This may generate a LOT of messages!
.tooltipTextFunction : This is called when the mouse enters the plugin frame - OnEnter.
	The Titan templates set the OnEnter script for the plugin frame.
	On a tooltip error, Titan will usually show part of the error in the tool tip.
	If you need to see the full error, search for this attribute in the Titan folder and uncomment the print of the error message.

NOTE: Each .registry routine is called using pcall to protect Titan.
These routines are expected to have NO parameters. Handling parameters was not implemented in any version of Titan.

NOTE: Creating menu 
Routine that creates the options for the menu (right click). Titan will use only one, if found, in order :
1) registry.menuContextFunction  : NEW Jan 2026
2) registry.menuTextFunction  : Feb 2024
3) "TitanPanelRightClickMenu_Prepare" .. id .. "Menu" : Old as Titan :)

NOTE: Each routine can be specified :
- As a string, it MUST be in the global namespace. Strings were the only method for a long time until Feb 2024.
- As a function, it may be in the global namespace but could be local. 
This example uses a local routine which is preferred.

--]]

--[[ Special Icons and Artwork

Anyone can extract the Blizzard UI code and art from WoW. This can be handy to get code examples.
And to grab icons to use for a plugin. My understanding is any icon can be used within WoW without violating the ToS.
WoW icons tend to be .blp files. These files are NOT easy to look at or manipulate!!
You will need to research third party tools to manipulate .blp files.
BLPView (Windows only) from wowinterface is light and easy to view blp files as thumbnail pics in File Explorer.

==== Extracting art and code
Add the command switch -console when starting WoW.
In BattleNet click the Settings (next to Play) then Game Settintgs. Add as an additional command line argument.

Start WoW but stay on the character screen.
Hit the ~ (tilde) key to open a text console which will appear from the top of the screen.
Type exportInterfaceFiles (can tab to auto fill) with parameter code or art
exportInterfaceFiles code
exportInterfaceFiles art

These must be run separately. Code should take a couple seconds,
Art may take some time and appear to hang the game, be patient :).

The result will be here :
.../World of Warcraft/<version>/BlizzardInterfaceCode
.../World of Warcraft/<version>/BlizzardInterfaceArt
Where <version> is _retail_ for the current game expansion
--]]

--[[ Files stored 

Addons are here : .../World of Warcraft/<version>/Interface/Addons/
Saved Vars are here : .../World of Warcraft/<version>/WTF/Account/<your account>/SavedVariables/Titan.lua

Where <version> is _retail_ for the current game expansion
--]]
