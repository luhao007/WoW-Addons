--[===[ File
Contains various utility routines used by
- Titan
- Plugin developers for strings; create menus; and more
- Addon developers that want to know which Titan full bars is on the UI
- Dropdown menu
--]===]

--[===[
This large file contains various utility routines used by
- Titan
- Plugin developers for strings; create menus; and more
- Addon developers that want to know which Titan full bars is on the UI

The Drop Down Menu routines for the Right Click menu are in this file.

The Titan routines abstract the menu creation built into WoW.

Whenever there is a change to the menu routines, the abstractions :
: Insulate 3rd party Titan plugin authors from Blizz or lib changes.
: Allow better maintainance by updating Utils rather than updating Titan using search & replace.

Late 2023 during DragonFlight, WoW expanded the retail version of drop down menu to more Classic versions.
Currently (May 2025) Classic Era is the only one using an explicit timer, and a distinct file version, to close menus.
So, Titan uses a routine only in CE (UIDropDownMenu_StartCounting) to determine which version to use.

Code notes:
The expected frame name for the Right Click menu of the plugin is:
"TitanPanelRightClickMenu_Prepare"..<registry.id>.."Menu"

local drop_down_1 = "" -- changes drop down menu version. Blizzard hard-codes the value...

The L_* routines wrap the drop down menu API for Titan Classic plugins.

--]===]

local _G = getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
local AceHook = LibStub("AceHook-3.0")

--[[
This set of routines controls the menu timer.
It keeps the menu open as long as the mouse is over an open menu or sub menu.

The timer is only on the top (drop_down_1) NOT on any sub menu.

We cannot reliably use OnEnter / OnLeave only because the user may leave the mouse over a menu at any level.
The OnUpdate must do the 'over menu' check.
--]]
local function IsMouseOverMenu()
	for idx = 1, UIDROPDOWNMENU_MAXLEVELS do --
		if _G["DropDownList" .. idx]:IsMouseOver() then
			return true --
		else
			-- not over, keep checking
		end
	end

	return false
end

local tstr = ""
---Implement timer to close drop down menu (right click menu)
---@param self Frame
---@param elapsed number
local function OnUpdateTimer(self, elapsed)
	local str = "Counting" .. " " .. tostring(self:GetName()) .. " "
	if (not self.showTimer or not self.isCounting) then -- no timer running
		str = str .. "no timer"
		--		return;
	elseif (self.showTimer < 0) then -- timer expired
		str = str .. "expired"
		self:Hide();
		self.showTimer = nil;
		self.isCounting = nil;
	elseif IsMouseOverMenu() then           -- mouse is over some (sub)menu
		str = str .. "mouse over"
		self.showTimer = UIDROPDOWNMENU_SHOW_TIME -- reset timer
	else                                    -- mouse is elsewhere, decrease timer
		str = str .. "count down"
		self.showTimer = self.showTimer - elapsed;
	end
	str = str
		.. " " .. tostring(self.showTimer) .. ""
		.. " " .. tostring(self.isCounting) .. ""
end

---Start a timer to close menu
---@param self Frame
local function StartCounting(self)
	local str = ""
	if (self.parent) then
		StartCounting(self.parent) -- walk to top menu
		str = str .. "parent"
		--	elseif IsMouseOverMenu() then
		-- Mouse is in the menu
		--		str = str .. "over"
	else
		str = str .. "start"
		-- allow time out
		self.showTimer = UIDROPDOWNMENU_SHOW_TIME;
		self.isCounting = 1;
	end
end

---Start a timer to close menu
---@param frame Frame
local function StopCounting(frame)
	local str = ""
	if (frame.parent) then
		str = str .. "parent"
		StopCounting(frame.parent) -- walk to top menu
		--	elseif IsMouseOverMenu() then
		--		str = str .. "stop"
		--		frame.isCounting = nil;
		-- Mouse is in the menu
	else
		str = str .. "nop"
		-- Nothing to do; if timing, allow to run out
	end
end

---Add scripts and start timer to menu being shown
---@param level number
---@param index number
function TitanUtils_AddHide(level, index)
	local frame = _G["DropDownList" .. level]
	-- Add these to start and stop the hide timer
	frame:SetScript("OnEnter", function(self) StopCounting(self) end)
	frame:SetScript("OnLeave", function(self) StartCounting(self) end)

	-- The user may not mouse into the menu
	StartCounting(frame)
end

local function StartTimer(frame)
	-- The user may not mouse into the menu
	StartCounting(frame)
end

---@diagnostic disable-next-line: undefined-global
if UIDropDownMenu_StartCounting then
	-- This version of WoW is using an older timeout for menu hiding
	-- Seems to work for now
	-- Post Hook the OnShow of DropDownList
	AceHook:SecureHookScript(DropDownList1, "OnShow", StartTimer)
else
	-- In case any code creates more than 3.
	---@diagnostic disable-next-line: param-type-mismatch
	if not AceHook:IsHooked("UIDropDownMenu_CreateFrames", TitanUtils_AddHide) then
		AceHook:SecureHook("UIDropDownMenu_CreateFrames", TitanUtils_AddHide)
	end

	-- This handles any level so hook it here
	---@diagnostic disable-next-line: param-type-mismatch
	if not AceHook:IsHooked("UIDropDownMenu_OnUpdate", OnUpdateTimer) then
		AceHook:SecureHook("UIDropDownMenu_OnUpdate", OnUpdateTimer)
	end
end

--[[
function L_OpenColorPicker(info)
	OpenColorPicker(info)
end

function L_ColorPicker_GetPreviousValues()
	return ColorPicker_GetPreviousValues()
end
--]]
-- These are only retail (may change as Blizz expands API to Classic versions)
---API Return the current setting of the Titan MinimapAdjust option.
---@return boolean boolean Adjust
function TitanUtils_GetMinimapAdjust()
	-- Used by addons
	return not TitanPanelGetVar("MinimapAdjust")
end

---API Allows an addon to turn on or off whether Titan adjusts mini map (MinimapAdjust).
---@param bool boolean Adjust
function TitanUtils_SetMinimapAdjust(bool)
	-- Used by addons
	TitanPanelSetVar("MinimapAdjust", not bool)
end

---API Tell Titan to adjust (or not) a frame. Allows an addon to tell Titan it will control adjustment of that frame.
---@param frame string Frame Titan adjusts
---@param bool boolean Adjust
---- Titan will NOT store the adjust value across a log out / exit.
---- This is a generic way for an addon to tell Titan to not adjust a frame.
---The addon will take responsibility for adjusting that frame.
---This is useful for UI style addons so the user can run Titan and a modifed UI.
---- The list of frames Titan adjusts is specified in TitanMovableData within TitanMovable.lua.
---- If the frame name is not in TitanMovableData then Titan does not adjust that frame.
---- The frame list is different across the WoW versions.
--- TitanMovable_AddonAdjust("MicroButtonAndBagsBar", true)
function TitanUtils_AddonAdjust(frame, bool)
	-- Used by addons
	TitanMovable_AddonAdjust(frame, bool)
end

--====== The routines labeled API are useable by addon developers

---API Get the anchors of the bottom most top bar and the top most bottom bar.
---@return table Top
---@return table Bottom
---Intended for addons that modify the UI so they can adjust for Titan full bars.
---The two anchors are implemented as 2 frames that are moved by Titan depending on which full bars are shown.
function TitanUtils_GetBarAnchors()
	-- Used by addons
	return TitanPanelTopAnchor, TitanPanelBottomAnchor
end

--------------------------------------------------------------
--
-- Plugin button search & manipulation routines
--


---API Create the button name from plugin id.
---@param id string Unique ID of the plugin
---@return string? FrameName
function TitanUtils_ButtonName(id)
	if (id) then
		return Titan_Global.plugin.PRE .. id .. Titan_Global.plugin.POST
	else
		return nil
	end
end

---API Return the actual button frame and the plugin id.
---@param id string Unique ID of the plugin
---@return table? frame Frame of the plugin
---@return string? id Unique ID of the plugin
function TitanUtils_GetButton(id)
	-- API : Used by plugins
	if (id) then
		return _G[Titan_Global.plugin.PRE .. id .. Titan_Global.plugin.POST], id;
	else
		return nil, nil;
	end
end

---API Return whether the plugin is on top (1) or bottom (2) full bar - NOT which bar.
---@param id string Plugin name
---@return number? PluginId
function TitanUtils_GetRealPosition(id)
	-- This will return top / bottom but it is a compromise.
	-- With the introduction of independent bars there is
	-- more than just top / bottom.
	-- This should work in the sense that the plugins using this
	-- would overlap the double bar.
	local bar = TitanUtils_GetWhichBar(id)
	local bar_pos = nil
	for idx, v in pairs(TitanBarData) do
		if bar == TitanBarData[idx].name then
			bar_pos = TitanBarData[idx].vert
		end
	end
	return (bar_pos == TITAN_BOTTOM and TITAN_PANEL_PLACE_BOTTOM or TITAN_PANEL_PLACE_TOP)
end

---API Return the plugin id from the frame name
---@param name string Plugin frame name
---@return string? PluginId
function TitanUtils_GetButtonID(name)
	if name then
		local s, e, id = string.find(name, Titan_Global.plugin.PRE .. "(.*)" .. Titan_Global.plugin.POST);
		return id;
	else
		return nil;
	end
end

---Titan Return the plugin itself (table and all).
---@param id string Unique ID of the plugin
---@return table? table plugin data
function TitanUtils_GetPlugin(id)
	if (id) then
		return TitanPlugins[id];
	else
		return nil;
	end
end

---Titan Return the bar the plugin is shown on.
---@param id string
---@return string? ShortName
---@return string? LocaleName
---@return string? FrameName
function TitanUtils_GetWhichBar(id)
	local i = TitanPanel_GetButtonNumber(id);
	if TitanPanelSettings.Location[i] == nil then
		return nil, nil, nil
	else
		local internal = TitanPanelSettings.Location[i]
		local locale = ""
		local frame_str = ""
		for _, v in pairs(TitanBarData) do
			if v.name == internal then
				locale = v.locale_name
				frame_str = v.frame_name
			else
				-- not the Bar wanted
			end
		end
		return internal, locale, frame_str
	end
end

---Titan Return the first bar that is shown.
---@return string? Bar
function TitanUtils_PickBar()
	-- Pick the 'first' bar shown per the Titan defined order.
	-- This is used for defaulting where plugins are put
	-- if using the Titan options screen.
	local bar_list = {}
	for _, v in pairs(TitanBarData) do
		bar_list[v.order] = v
	end
	table.sort(bar_list, function(a, b)
		return a.order < b.order
	end)

	for idx = 1, #bar_list do
		local bar_name = bar_list[idx].name
		if TitanBarDataVars[bar_list[idx].frame_name].show then --if TitanPanelGetVar(bar_name.."_Show") then
			return bar_name
		end
	end
	-- fail safe - return something
	return nil
end

---Titan See if the plugin is to be on the right.
---@param id string?
---@return boolean Found
function TitanUtils_ToRight(id)
	--[[
These are the methods to place a plugin on the right:
   1) DisplayOnRightSide saved variable logic (preferred)
   2) Place a plugin in TITAN_PANEL_NONMOVABLE_PLUGINS (NOT preferred)
Using the Titan template TitanPanelIconTemplate used to enforce right side only
but was removed during DragonFlight to give users more flexibility.
--]]
	local found = false
	for index, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
		if id == TITAN_PANEL_NONMOVABLE_PLUGINS[index] then
			found = true;
		end
	end

	-- tostring is for IDE - id nil then check would return false
	if TitanGetVar(tostring(id), "DisplayOnRightSide") then
		found = true
	end

	return found
end

---Titan Return the number of bars user has active, includes auto hide.
---@return integer Num Active bars
function TitanUtils_NumActiveBars()
	local num_bars = 0

	for idx, bar in pairs(TitanBarDataVars) do
		if TitanBarDataVars[idx].show then --if TitanPanelGetVar(bar_name.."_Show") then
			num_bars = num_bars + 1
		end
	end

	return num_bars
end

--====== General util routines

---API Return b (a = true) or c (a = false)
---@param a any
---@param b any
---@param c any
---@return any Tern
--- Typically used for saved variables check. Takes 'any' so relies on Lua T/F determination.
function TitanUtils_Ternary(a, b, c)
	if (a) then
		return b;
	else
		return c;
	end
end

---API Toggle value : (true or 1) return nil else return 1
---@param value boolean | number
---@return number? 1 or nil
--- Making this true / false would probably break Titan and a bunch of addons...
function TitanUtils_Toggle(value)
	if (value == 1 or value == true) then
		return nil;
	else
		return 1;
	end
end

---API Return min of a or b
---@param a any
---@param b any
---@return any Min
function TitanUtils_Min(a, b)
	if (a and b) then
		--		return ( a < b ) and a or b
		return TitanUtils_Ternary((a < b), a, b);
	end
end

---API Return max of a or b
---@param a any
---@param b any
---@return any Max
function TitanUtils_Max(a, b)
	if (a and b) then
		return TitanUtils_Ternary((a > b), a, b);
		---		return ( a > b ) and a or b
	end
end

---API Return the rounded up number
---@param v number
---@return number Rounded_value
function TitanUtils_Round(v)
	local f = math.floor(v)
	if v == f then
		return f
	else
		return math.floor(v + 0.5)
	end
end

---local return elapsed time from seconds given - spaces and leaving off the rest
---@param seconds_value number
---@return number days
---@return number hours
---@return number minutes
---@return number seconds
local function GetTimeParts(seconds_value)
	local s = seconds_value
	local days = 0
	local hours = 0
	local minutes = 0
	local seconds = 0
	if not s or (s < 0) then
		seconds = -1
	else
		days = floor(s / 24 / 60 / 60); s = mod(s, 24 * 60 * 60);
		hours = floor(s / 60 / 60); s = mod(s, 60 * 60);
		minutes = floor(s / 60); s = mod(s, 60);
		seconds = s;
	end

	return days, hours, minutes, seconds
end

local date_stamp = "%Y-%m-%d"
local time_stamp = "%H:%M"

---API Format time stamp with optional time
---@param time_sec number timestamp
---@param with_time boolean add time
---@return string Timestamp Formatted
function TitanUtils_GetDateText(time_sec, with_time)
	local f = date_stamp
	if with_time then
		f = f .. " " .. time_stamp
	else
		-- just date w/o time
	end
	local str = date(f, time_sec)

	return str
end

---API return a elapsed time from seconds given - spaces and leaving off the rest
---@param seconds_value number
---@return string Time that is readable
function TitanUtils_GetEstTimeText(seconds_value)
	local timeText = "";
	local days, hours, minutes, seconds = GetTimeParts(seconds_value)
	local fracdays = days + (hours / 24);
	local frachours = hours + (minutes / 60);
	if seconds == -1 then
		timeText = L["TITAN_PANEL_NA"];
	else
		if (days ~= 0) then
			timeText = timeText .. format("%4.1f" .. L["TITAN_PANEL_DAYS_ABBR"] .. " ", fracdays);
		elseif (days ~= 0 or hours ~= 0) then
			timeText = timeText .. format("%4.1f" .. L["TITAN_PANEL_HOURS_ABBR"] .. " ", frachours);
		elseif (days ~= 0 or hours ~= 0 or minutes ~= 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_MINUTES_ABBR"] .. " ", minutes);
		else
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_SECONDS_ABBR"], seconds);
		end
	end
	return timeText;
end

---API return a localized time from seconds given - days, hours, minutes, and seconds using commas and including zeroe
---@param seconds_value number
---@return string Time that is readable
function TitanUtils_GetFullTimeText(seconds_value)
	local days, hours, minutes, seconds = GetTimeParts(seconds_value)
	if seconds == L["TITAN_PANEL_NA"] then
		return L["TITAN_PANEL_NA"];
	else
		return format("%d" .. L["TITAN_PANEL_DAYS_ABBR"]
			.. ", %2d" .. L["TITAN_PANEL_HOURS_ABBR"]
			.. ", %2d" .. L["TITAN_PANEL_MINUTES_ABBR"]
			.. ", %2d" .. L["TITAN_PANEL_SECONDS_ABBR"],
			days, hours, minutes, seconds);
	end
end

---API return a terse localized time from seconds given.
---@param seconds_value number
---@return string Time that is readable
function TitanUtils_GetAbbrTimeText(seconds_value)
	local timeText = "";
	local days, hours, minutes, seconds = GetTimeParts(seconds_value)
	if seconds == L["TITAN_PANEL_NA"] then
		timeText = L["TITAN_PANEL_NA"];
	else
		if (days ~= 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_DAYS_ABBR"] .. " ", days);
		end
		if (days ~= 0 or hours ~= 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_HOURS_ABBR"] .. " ", hours);
		end
		if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_MINUTES_ABBR"] .. " ", minutes);
		end
		timeText = timeText .. format("%d" .. L["TITAN_PANEL_SECONDS_ABBR"], seconds);
	end
	return timeText;
end

---API Get the control frame of the plugin given.
---@param id string Unique ID of the plugin
---@return table? frame Frame of the menu (right click)
function TitanUtils_GetControlFrame(id)
	if (id) then
		return _G["TitanPanel" .. id .. "ControlFrame"];
	else
		return nil;
	end
end

---Titan Original : lua-users.org/wiki/CopyTable
---@param orig any
---@return any
function TitanUtils_DeepCopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[TitanUtils_DeepCopy(orig_key)] = TitanUtils_DeepCopy(orig_value)
		end
		setmetatable(copy, TitanUtils_DeepCopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

---API Routine that index of the value given.
---@param table table Array to check
---@param value any Value to look for
---@return any index if value found; nil if not
function TitanUtils_TableContainsValue(table, value)
	local res = nil
	if (table and value) then
		for i, v in pairs(table) do
			if (v == value) then
				return i;
			end
		end
	end

	return res -- not found
end

---API Routine that index if found.
---@param table table Array to check
---@param index any Index to look for
---@return any index if found; nil if not
function TitanUtils_TableContainsIndex(table, index)
	local res = nil
	if (table and index and table[index] ~= nil) then
		return index
	end

	return res -- not found
end

---API Routine that index of the value given.
---@param table table Array to check
---@param value any Value to look for
---@return any index if value found; nil if not
function TitanUtils_GetCurrentIndex(table, value)
	return TitanUtils_TableContainsValue(table, value);
end

---API Debug tool that will attempt to output to Chat the top level index and value of the array.
---@param array table Simple array
function TitanUtils_PrintArray(array)
	if (not array) then
		TitanDebug("array is nil");
	else
		TitanDebug("{");
		for i, v in array do
			TitanDebug("array[" .. tostring(i) .. "] = " .. tostring(v));
		end
		TitanDebug("}");
	end
end

---local Routine that returns the given string with proper start and end font encoding.
---@param color string Hex color code
---@param text string Text to wrap
---@return string text Color encoded string
local function Encode(color, text)
	-- This does the sanity checks for the Get<color> routines below
	local res = ""
	local c = tostring(color)
	local t = tostring(text)
	if (c and t) then
		res = "|cff" .. c .. t .. "|r"
	else
		if (t) then
			res = tostring(t)
		else
			-- return blank string
		end
	end

	return res
end

---API Routine that returns red string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Red color encoded string
function TitanUtils_GetRedText(text)
	local res = Encode(Titan_Global.colors.red, text)

	return res
end

---API Routine that returns gold string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Gold color encoded string
function TitanUtils_GetGoldText(text)
	local res = Encode(Titan_Global.colors.gold, text)

	return res
end

---API Routine that returns green string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Green color encoded string
function TitanUtils_GetGreenText(text)
	local res = Encode(Titan_Global.colors.green, text)

	return res
end

---API Routine that returns blue string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Blue color encoded string
function TitanUtils_GetBlueText(text)
	local res = Encode(Titan_Global.colors.blue, text)

	return res
end

---API Routine that returns gray string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Gray color encoded string
function TitanUtils_GetGrayText(text)
	local res = Encode(Titan_Global.colors.gray, text)

	return res
end

---API Routine that returns normal color string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Normal color encoded string
function TitanUtils_GetNormalText(text)
	local res = Encode(Titan_Global.colors.yellow_gold, text)

	return res
end

---API Routine that returns highlight color (brighter white) string with proper start and end font encoding.
---@param text string Text to wrap
---@return string text Highlight color encoded string
function TitanUtils_GetHighlightText(text)
	local res = Encode(Titan_Global.colors.white, text)

	return res
end

---API Routine that returns custom color (rbg) string with proper start and end font encoding.
---@param text string Text to wrap
---@param color any See color:GetRGB() / color:GetRGBA()
---@return string text Custom color encoded string
function TitanUtils_GetColoredText(text, color)
	local res = ""
	if (color and text) then
		local redColorCode = format("%02x", color.r * 255);
		local greenColorCode = format("%02x", color.g * 255);
		local blueColorCode = format("%02x", color.b * 255);
		local colorCode = redColorCode .. greenColorCode .. blueColorCode;
		res = Encode(colorCode, text)
	else
		if (text) then
			res = tostring(text)
		else
			-- return blank string
		end
	end

	return res
end

---API Routine that returns custom color (hex) string with proper start and end font encoding.
---@param text string Text to wrap
---@param hex string
---@return string text Custom color encoded string
---TitanUtils_GetHexText(player.faction, "d42447") -- Horde
function TitanUtils_GetHexText(text, hex)
	local res = Encode(hex, text)

	return res
end

---@param ThresholdTable table holding the list of colors and values
---@param value number to check against table ranges (assumes assending values)
---@return any color in table or "GRAY_FONT_COLOR"
function TitanUtils_GetThresholdColor(ThresholdTable, value)
	--[[ example
	local TITAN_FPS_THRESHOLD_TABLE = {
		Values = { 20, 30 },
		Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
	}

	TitanUtils_GetThresholdColor(TITAN_FPS_THRESHOLD_TABLE, button.fps)
	--]]
	if (not tonumber(value) or type(ThresholdTable) ~= "table"
			or ThresholdTable.Values == nil or ThresholdTable.Colors == nil
			or (#ThresholdTable.Values >= #ThresholdTable.Colors)
		) then
		return GRAY_FONT_COLOR
	end

	local n = #ThresholdTable.Values + 1;
	for i = 1, n do
		local low = TitanUtils_Ternary(i == 1, nil, ThresholdTable.Values[i - 1]); -- lowest
		local high = TitanUtils_Ternary(i == n, nil, ThresholdTable.Values[i]); -- highest

		if (not low and not high) then
			-- No threshold values
			return ThresholdTable.Colors[i];
		elseif (not low and high) then
			-- Value is smaller than the first threshold
			if (value < high) then return ThresholdTable.Colors[i] end
		elseif (low and not high) then
			-- Value is larger than the last threshold
			if (low <= value) then return ThresholdTable.Colors[i] end
		else
			-- Value is in between 2 adjacent thresholds
			if (low <= value and value < high) then
				return ThresholdTable.Colors[i]
			end
		end
	end

	-- Should never reach here
	return GRAY_FONT_COLOR
end

---API Routine that returns the text or an empty string.
---@param text string Text to check
---@return string text or ""
function TitanUtils_ToString(text)
	return TitanUtils_Ternary(text, text, "");
end

---API Add separators into the value given.  This does not break coin into its parts.
--- This routines handles negative and fractional numbers.
--- Assumes amount decimal separator is a period per tostring().
---@param amount number
---@param thousands_separator string
---@param decimal_separator string
---@return string formatted
function TitanUtils_NumToString(amount, thousands_separator, decimal_separator)
	-- Jul 2024 Moved to Utils for use by plugins
	--[=[ Jul 2024
	Handle the general cases of converting any number to a string with separators for plugins.
	Titan usage is , / . or . / , although this will handle other schemes.
	NOTE: Currently only positive, whole numbers are passed in from Titan (no fractional or negative).
	NOTE: If amount is 100 trillion or more then return the string as is to avoid very messy strings.
		This is the behavior of Lua tostring.
	NOTE: Do not use separator directly in gsub - it could be a pattern special char, resulting in unexpected behavior!
	--]=]

	local formatted = ""

	if type(amount) == "number" then
		-- Break number into segments - minus, integer, and fractional
		local i, j
		local minus, int, fraction = "", "", ""
		if amount > 99999999999999 then -- 1 trillion - 1
			int = tostring(amount)
			-- leave as is and, if gold, congratulate the player!!!
			-- Result will be have an exponent (1.23+e16)
		else
			i, j, minus, int, fraction = tostring(amount):find('([-]?)(%d+)([.]?%d*)')

			-- Reverse the int-string and append a separator to all blocks of 3 digits
			int = int:reverse():gsub("(%d%d%d)", "%1|")

			-- Reverse the int-string back and remove an extraneous separator
			int = int:reverse():gsub("^|", "")

			-- Now use the given decimal separator.
			-- tostring outputs a period as the separator so it needs to be escaped.
			int = int:gsub("%.", decimal_separator)

			-- Now use the given thousands separator
			int = int:gsub("|", thousands_separator)

			-- Add optional minus part back
			formatted = minus .. int .. fraction
		end
	else
		formatted = "0" -- 'silent' error
	end
	return formatted
end

---API Take the total cash and make it into a nice, colorful string of g s c (gold silver copper)
---@param value number
---@param thousands_separator string
---@param decimal_separator string
---@param only_gold boolean
---@param show_labels boolean
---@param show_icons boolean
---@param add_color boolean
---@return string outstr Formatted cash for output
---@return integer gold part of value
---@return integer silver part of value
---@return integer copper part of value
function TitanUtils_CashToString(value, thousands_separator, decimal_separator, only_gold, show_labels, show_icons,
								 add_color)
	local show_zero = true
	local show_neg = true

	local neg1 = ""
	local neg2 = ""
	local agold = 10000;
	local asilver = 100;
	local outstr = "";
	local gold = 0;
	local gold_str = ""
	local gc = ""
	local silver = 0;
	local silver_str = ""
	local sc = ""
	local copper = 0;
	local copper_str = ""
	local cc = ""
	local amount = (value or 0)
	local font_size = TitanPanelGetVar("FontSize")
	local icon_pre = "|TInterface\\MoneyFrame\\"
	local icon_post = ":" .. font_size .. ":" .. font_size .. ":2:0|t"
	local g_icon = icon_pre .. "UI-GoldIcon" .. icon_post
	local s_icon = icon_pre .. "UI-SilverIcon" .. icon_post
	local c_icon = icon_pre .. "UI-CopperIcon" .. icon_post
	-- build the coin label strings based on the user selections
	local c_lab = (show_labels and L["TITAN_GOLD_COPPER"]) or (show_icons and c_icon) or ""
	local s_lab = (show_labels and L["TITAN_GOLD_SILVER"]) or (show_icons and s_icon) or ""
	local g_lab = (show_labels and L["TITAN_GOLD_GOLD"]) or (show_icons and g_icon) or ""

	-- show the money in highlight or coin color based on user selection
	if add_color then
		gc = Titan_Global.colors.coin_gold
		sc = Titan_Global.colors.coin_silver
		cc = Titan_Global.colors.coin_copper
	else
		gc = Titan_Global.colors.white
		sc = Titan_Global.colors.white
		cc = Titan_Global.colors.white
	end

	if show_neg then
		if amount < 0 then
			neg1 = TitanUtils_GetHexText("(", Titan_Global.colors.orange) -- "|cFFFF6600" .. "(" .. FONT_COLOR_CODE_CLOSE
			neg2 = TitanUtils_GetHexText(")", Titan_Global.colors.orange) --"|cFFFF6600" .. ")" .. FONT_COLOR_CODE_CLOSE
		else
			-- no padding
		end
	end
	if amount < 0 then
		amount = amount * -1
	end

	-- amount INCLUDES silver and copper (last 4 digits)
	if amount == 0 then
		if show_zero then
			copper_str = TitanUtils_GetHexText("0" .. c_lab, cc) --cc .. (amount or "?") .. c_lab .. "" .. FONT_COLOR_CODE_CLOSE
		end
	elseif amount > 999999999999999999 then             -- 999,999,999,999,999,999 (1 quadrillion - 1)
		-- we are really in trouble :)
		-- gold should be accurate but in exponent format
		gold = (math.floor(amount / agold) or 0)
		gold_str = TitanUtils_GetHexText(tostring(gold) .. g_lab .. " ", gc)
		-- silver and copper will be off
		silver_str = ""
		copper_str = ""
	elseif amount > 99999999999999999 then -- 99,999,999,999,999,999 (100 trillion - 1)
		-- we are in some trouble :)
		-- gold should be accurate so format
		gold = (math.floor(amount / agold) or 0)
		local gnum = TitanUtils_NumToString(gold, thousands_separator, decimal_separator)
		gold_str = TitanUtils_GetHexText(gnum .. g_lab .. " ", gc)
		-- silver and copper will be off
		silver_str = ""
		copper_str = ""
	elseif amount > 0 then
		-- figure out the gold - silver - copper components for return and string
		gold = (math.floor(amount / agold) or 0)
		amount = amount - (gold * agold) -- now only silver + copper
		silver = (math.floor(amount / asilver) or 0)
		copper = amount - (silver * asilver)

		-- now make the coin strings
		if gold > 0 then
			local gnum = TitanUtils_NumToString(gold, thousands_separator, decimal_separator)
			gold_str = TitanUtils_GetHexText(gnum .. g_lab .. " ", gc)
		else
			gold_str = ""
		end
		if (silver > 0) then
			local snum = (string.format("%02d", silver) or "?")
			silver_str = TitanUtils_GetHexText(snum .. s_lab .. " ", sc)
		elseif (string.len(gold_str) > 0) then -- space if gold present
			local snum = (string.format("%02d", 0) or "?")
			silver_str = TitanUtils_GetHexText(snum .. s_lab .. " ", sc)
		else
			silver_str = ""
		end
		if (copper > 0) then
			local cnum = (string.format("%02d", copper) or "?")
			copper_str = TitanUtils_GetHexText(cnum .. c_lab, cc)
		elseif (string.len(silver_str) > 0) then -- space if silver present
			local cnum = (string.format("%02d", 0) or "?")
			copper_str = TitanUtils_GetHexText(cnum .. c_lab, cc)
		else
			copper_str = ""
		end
	end

	if only_gold then
		silver_str = ""
		copper_str = ""
		-- special case for those who want only gold when amount is less than 1 gold
		if gold == 0 then
			if show_zero then
				gold_str = TitanUtils_GetHexText("0" .. g_lab, gc) --gc .. "0" .. g_lab .. " " .. FONT_COLOR_CODE_CLOSE
			end
		end
	end

	-- build the return string
	outstr = outstr
		.. neg1
		.. gold_str
		.. silver_str
		.. copper_str
		.. neg2
	return outstr, gold, silver, copper
end

--------------------------------------------------------------
--
-- Plugin manipulation routines
--


---local This will swap two buttons on the Titan bars. Once swapped then 'reinit' the buttons to show properly.
--- This is currently used as part of the shift left / right on same bar.
---@param from_id integer Plugin id
---@param to_id integer Plugin id
local function TitanUtils_SwapButtonOnBar(from_id, to_id)
	-- Used as part of the shift L / R to swap the buttons
	local button = TitanPanelSettings.Buttons[from_id]
	local locale = TitanPanelSettings.Location[from_id]

	TitanPanelSettings.Buttons[from_id] = TitanPanelSettings.Buttons[to_id]
	TitanPanelSettings.Location[from_id] = TitanPanelSettings.Location[to_id]
	TitanPanelSettings.Buttons[to_id] = button
	TitanPanelSettings.Location[to_id] = locale
	TitanPanel_InitPanelButtons();
end

---local Find the next button index that is on the same bar and is on the same side.
---@param bar string Short bar name to look through
---@param id string Plugin id to look for
---@param side string TITAN_RIGHT("Right") or TITAN_Left("Left")
---@return integer? NextIndex nil means id is last
-- Buttons on Left are placed L to R; buttons on Right are placed R to L. Next and prev depend on which side we need to check.
local function TitanUtils_GetNextButtonOnBar(bar, id, side)
	-- find the next button that is on the same bar and is on the same side
	-- return nil if not found
	local index = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id);

	for i, id in pairs(TitanPanelSettings.Buttons) do
		if TitanUtils_GetWhichBar(id) == bar
			and i > index
			and TitanPanel_GetPluginSide(id) == side
			and TitanUtils_IsPluginRegistered(id) then
			return i;
		end
	end
end

---local Find the previous button index that is on the same bar and is on the same side.
---@param bar string Short bar name to look through
---@param id string Plugin id to look for
---@param side string TITAN_RIGHT("Right") or TITAN_Left("Left")
---@return integer? PrevIndex nil means id is first
-- Buttons on Left are placed L to R; buttons on Right are placed R to L. Next and prev depend on which side we need to check.
local function TitanUtils_GetPrevButtonOnBar(bar, id, side)
	-- find the prev button that is on the same bar and is on the same side
	-- return nil if not found
	local index = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id);
	local prev_idx = nil

	for i, id in pairs(TitanPanelSettings.Buttons) do
		if TitanUtils_GetWhichBar(id) == bar
			and i < index
			and TitanPanel_GetPluginSide(id) == side
			and TitanUtils_IsPluginRegistered(id) then
			prev_idx = i; -- this might be the previous button
		end
		if i == index then
			return prev_idx;
		end
	end
end

---Titan Add the given plugin to the given bar. Then reinit the plugins to show it properly.
---@param bar string? Bar name to use
---@param id string? Plugin to add
function TitanUtils_AddButtonOnBar(bar, id)
	local frame_str = TitanVariables_GetFrameName(bar)
	-- Add the button to the requested bar, if shown
	if (not bar)
		or (not id)
		or (not TitanPanelSettings)
		or (not TitanBarDataVars[frame_str].show)
	then
		return;
	end

	local i = TitanPanel_GetButtonNumber(id)
	-- The _GetButtonNumber returns +1 if not found so it is 'safe' to
	-- update / add to the Location
	TitanPanelSettings.Buttons[i] = (id or "?")
	TitanPanelSettings.Location[i] = (bar or "Bar")
	TitanPanel_InitPanelButtons();
end

---Titan Find the first button that is on the given bar and is on the given side.
--- buttons on Left are placed L to R; buttons on Right are placed R to L. Next and prev depend on which side we need to check.
--- buttons on Right are placed R to L
---@param bar string Bar name to search
---@param side string TITAN_RIGHT("Right") or TITAN_Left("Left")
function TitanUtils_GetFirstButtonOnBar(bar, side)
	-- find the first button that is on the same bar and is on the same side
	-- return nil if not found
	local index = 0

	for i, id in pairs(TitanPanelSettings.Buttons) do
		if TitanUtils_GetWhichBar(id) == bar
			and i > index
			and TitanPanel_GetPluginSide(id) == side
			and TitanUtils_IsPluginRegistered(id) then
			return i;
		end
	end
end

---Titan Find the button that is on the bar and is on the side and left of the given button
---@param name string Plugin id name
function TitanUtils_ShiftButtonOnBarLeft(name)
	-- Find the button to the left. If there is one, swap it in the array
	local from_idx = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, name)
	local side = TitanPanel_GetPluginSide(name)
	local bar = TitanUtils_GetWhichBar(name)
	local to_idx = nil

	if bar == nil then
		-- not on a bar, do nothing
	else
		-- buttons on Left are placed L to R;
		-- buttons on Right are placed R to L
		if side and side == TITAN_LEFT then
			to_idx = TitanUtils_GetPrevButtonOnBar(bar, name, side)
		elseif side and side == TITAN_RIGHT then
			to_idx = TitanUtils_GetNextButtonOnBar(bar, name, side)
		end

		if to_idx then
			TitanUtils_SwapButtonOnBar(from_idx, to_idx);
		else
			-- at 'end' of buttons
		end
	end
end

--Titan Find the button that is on the bar and is on the side and right of the given button
---@param name string Plugin id name
function TitanUtils_ShiftButtonOnBarRight(name)
	-- Find the button to the right. If there is one, swap it in the array
	local from_idx = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, name)
	local to_idx = nil
	local side = TitanPanel_GetPluginSide(name)
	local bar = TitanUtils_GetWhichBar(name)

	if bar == nil then
		-- not on a bar, do nothing
	else
		-- buttons on Left are placed L to R;
		-- buttons on Right are placed R to L
		if side and side == TITAN_LEFT then
			to_idx = TitanUtils_GetNextButtonOnBar(bar, name, side)
		elseif side and side == TITAN_RIGHT then
			to_idx = TitanUtils_GetPrevButtonOnBar(bar, name, side)
		end

		if to_idx then
			TitanUtils_SwapButtonOnBar(from_idx, to_idx);
		else
			-- at 'end' of buttons
		end
	end
end

--------------------------------------------------------------
--
-- Control Frame check & manipulation routines
--

---Titan: Check the frame - expected to be a control / menu frame. Close if timer has expired. Used in plugin OnUpdate
---@param frame table control / menu frame
---@param elapsed number portion of second since last OnUpdate
function TitanUtils_CheckFrameCounting(frame, elapsed)
	if (frame:IsVisible()) then
		if (not frame.frameTimer or not frame.isCounting) then
			return;
		elseif (frame.frameTimer < 0) then
			frame:Hide();
			frame.frameTimer = nil;
			frame.isCounting = nil;
		else
			frame.frameTimer = frame.frameTimer - elapsed;
		end
	end
end

---Titan Set the max time the control frame could be open once cursor has left frame. Used in plugin OnLeave
---@param frame table control / menu frame
---@param frameShowTime number time to wait
function TitanUtils_StartFrameCounting(frame, frameShowTime)
	frame.frameTimer = frameShowTime;
	frame.isCounting = 1;
end

---Titan Remove timer flag once cursor has entered frame. Used in plugin OnEnter
---@param frame table control / menu frame
function TitanUtils_StopFrameCounting(frame)
	frame.isCounting = nil;
end

---Titan Remove all timer flags on plugin control frames. Used for plugin Shift+Left and within Titan
--- Used for Plugins AND Titan
function TitanUtils_CloseAllControlFrames()
	for index, value in pairs(TitanPlugins) do
		local frame = _G["TitanPanel" .. index .. "ControlFrame"];
		if (frame and frame:IsVisible()) then
			frame:Hide();
		end
	end
end

---Titan Check if the control frame is on screen.
--- Used for Plugins AND Titan
---@param frame table Frame name likely tooltip
---@return number off_X -1 off left; 0 = ok; 1 off right
---@return number off_Y -1 off top; 0 = ok; 1 off bottom
function TitanUtils_GetOffscreen(frame)
	local offscreenX, offscreenY;
	local ui_scale = UIParent:GetEffectiveScale()
	if not frame then
		return 0, 0 -- ??
	end
	local fr_scale = frame:GetEffectiveScale()
	local fr_top = frame:GetTop()
	local fr_left = frame:GetLeft()
	local fr_right = frame:GetRight()
	local fr_bot = frame:GetBottom()
	local uip_top = UIParent:GetTop()
	local uip_left = UIParent:GetLeft()
	local uip_right = UIParent:GetRight()
	local uip_bot= UIParent:GetBottom()

	if (frame and fr_left
			and fr_left * fr_scale < uip_left * ui_scale) then
		offscreenX = -1;
	elseif (frame and fr_right
			and fr_right * fr_scale > uip_right * ui_scale) then
		offscreenX = 1;
	else
		offscreenX = 0;
	end

	if (frame and fr_top
			and fr_top * fr_scale > uip_top * ui_scale) then
		offscreenY = -1;
	elseif (frame and fr_bot
			and fr_bot * fr_scale < uip_bot * ui_scale) then
		offscreenY = 1;
	else
		offscreenY = 0;
	end

	return offscreenX, offscreenY;
end

--------------------------------------------------------------
--
-- Plugin registration routines
--

---Titan Wrapper to get meta data from the addon
---@param name string Addon name
---@param field string Attribute to get
function TitanUtils_GetAddOnMetadata(name, field)
	-- As of May 2023 (10.1) the routine moved and no longer dies silently so it is wrapped here...
	---@diagnostic disable-next-line: deprecated, undefined-global
	local GetMeta = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

	local call_success, ret_val

	-- Just in case, catch any errors
	call_success, -- needed for pcall
	ret_val =  -- actual return values
		pcall(GetMeta, name, field)
	if call_success then
		-- all is good
		return ret_val
	else
		-- Some error.. for our use return nil
		return nil
	end
end

---Titan Store the plugin to be registered later by Titan
--- See comments in the routine for more details.
---@param self table Plugin frame
function TitanUtils_PluginToRegister(self)
	--[[
- .registry is part of 'self' (the Titan plugin frame).
  Titan plugins create the registry as part of the frame _OnLoad.
  For LDB buttons the frame and the registry are created during the processing of the LDB object.
- Any read of the registry must assume it may not exist. Also assume the registry could be updated after this routine.
- This is called when a Titan plugin frame is created.
- These entries are held until the 'player entering world' event then the plugin list is registered.
- Sometimes plugin frames are created after this process. Right now only LDB plugins are handled.
If someone where to start creating Titan frames after the registration process were complete then it would fail to be registered...
- The fields put into Config > "Attempted" are defaulted here in preperation of being registered.
	--]]

	TitanPluginToBeRegisteredNum = TitanPluginToBeRegisteredNum + 1
	local cat = ""
	local notes = ""
	local name = ""
	if self and self.registry then
		cat = (self.registry.category or "")
		notes = (self.registry.notes or "")
		name = (self.registry.id or "")
	end
	-- The fields displayed in "Attempts" are defaulted here.
	TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum] = {
		self = self,
		button = ((self and self:GetName()
			or "Nyl" .. "_" .. TitanPluginToBeRegisteredNum)),
		-- fields below are updated when registered
		name = "?",
		issue = "",
		status = TITAN_NOT_REGISTERED,
		category = cat,
		plugin_type = "",
		notes = notes,
	}

	Titan_Debug.Out('titan', 'plugin_register', "Queue Plugin"
		--			.." '"..tostring(self:GetName()).."'"
		.. " '" .. tostring(TitanUtils_GetButtonID(self:GetName())) .. "'"
		.. " " .. tostring(TITAN_NOT_REGISTERED) .. ""
	)
end

---local Handle a Titan plugin that could not be registered.
--- See comments in the routine for more details.
---@param plugin table Plugin frame - Titan template
function TitanUtils_PluginFail(plugin)
	--[[
--- This is called when a plugin is unsupported. Curently this is used if a LDB data object is not supported.
--- See SupportedDOTypes in LDBToTitan.lua for more detail.
--- It is intended mainly for developers. It is a place to put relevant info for debug and so users can supply troubleshooting info.
--- The key is set the status to 'fail' so there is no further attempt to register the plugin.
--- The results will show in "Attempted" so the developer has a shot at figuring out what was wrong.
--- plugin is expected to hold as much relevant info as possible...
--]]
	TitanPluginToBeRegisteredNum = TitanPluginToBeRegisteredNum + 1
	TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum] =
	{
		self = plugin.self,
		button = (plugin.button and plugin.button:GetName() or ""),
		name = (plugin.name or "?"),
		issue = (plugin.issue or "?"),
		status = (plugin.status or "?"),
		category = (plugin.category or ""),
		plugin_type = (plugin.plugin_type or ""),
	}

	--[[ 2024/06/18 : Removed per comment on Curse. Still in Config > Attempted
	local message = ""
		.. " '" .. tostring(TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum].status) .. "'"
		.. " '" .. tostring(TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum].name) .. "'"
		.. " '" .. tostring(TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum].category) .. "'"
		.. " '" .. tostring(TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum].issue) .. "'"
	TitanPrint(message, "error")
--]]
end

---local Strip the WoW color string(s) from the given string
---@param name string
---@return string NoColor
local function NoColor(name)
	local no_color = name

	-- Remove any color formatting from the name in the list
	no_color = string.gsub(no_color, "|c........", "")
	no_color = string.gsub(no_color, "|r", "")

	return no_color
end

---local This routine is a protected manner (pcall) by Titan when it attempts to register a plugin.
---@param plugin table Plugin frame - Titan template
---@return table Results of the registration - pass (TitanPlugins) or fail
--- See routine for output table values
local function TitanUtils_RegisterPluginProtected(plugin)
	--[[
OUT:
	.issue	: Show the user what prevented the plugin from registering
	.result	: Used so we know which plugins were processed
	.id		: The name used to lookup the plugin
	.cat		: The 'bucket' to use off the main Titan menu
	.ptype	: For now just Titan or LDB type
NOTE:
- We try to anticipate the various ways a plugin could fail to register or just plain fail.
  The intent is to keep Titan whole so a plugin does not prevent Titan from loading.
  And attempt to tell the user / developer what went wrong.
- If successful the plugin will be in TitanPlugins as a registered plugin and will be available for display on the Titan bars.
--]]
	local result = ""
	local issue = ""
	local id = ""
	local cat = ""
	local ptype = ""
	local notes = ""
	local str = ""

	local self = plugin.self -- plugin frame reference

	if self and self:GetName() then
		-- Check for the .registry where all the Titan plugin info is expected
		if (self.registry and self.registry.id) then
			id = self.registry.id
			if TitanUtils_IsPluginRegistered(id) then
				-- We have already registered this plugin!
				issue = "Plugin '" .. tostring(id) .. "' already loaded. "
					.. "Please see if another plugin (Titan or LDB) is also loading "
					.. "with the same name.\n"
					.. "<Titan>.registry.id or <LDB>.label"
			else
				-- A sanity check just in case it was already in the list
				if TitanUtils_TableContainsValue(TitanPluginsIndex, id) then
					str = "In List ??"
				else
					str = "Save .registry"
					-- Herein lies any special per plugin variables Titan wishes to control
					-- These will be overwritten from saved vars, if any
					--
					-- Sanity check
					if self.registry.savedVariables then
						-- Custom labels
						self.registry.savedVariables.CustomLabelTextShow = false
						self.registry.savedVariables.CustomLabelText = ""
						self.registry.savedVariables.CustomLabel2TextShow = false
						self.registry.savedVariables.CustomLabel2Text = ""
						self.registry.savedVariables.CustomLabel3TextShow = false
						self.registry.savedVariables.CustomLabel3Text = ""
						self.registry.savedVariables.CustomLabel4TextShow = false
						self.registry.savedVariables.CustomLabel4Text = ""
					end

					-- Assign and Sort the list of plugins
					TitanPlugins[id] = self.registry;
					-- Set the name used for menus
					if TitanPlugins[id].menuText == nil then
						TitanPlugins[id].menuText = TitanPlugins[id].id;
					end
					TitanPlugins[id].menuText_NC = NoColor(TitanPlugins[id].menuText)

					table.insert(TitanPluginsIndex, self.registry.id);
					table.sort(TitanPluginsIndex,
						function(a, b)
							return string.lower(TitanPlugins[a].menuText_NC)
								< string.lower(TitanPlugins[b].menuText_NC);
						end
					);
				end
			end
			if issue ~= "" then
				result = TITAN_REGISTER_FAILED
			else
				-- We are almost done-
				TitanPanelButton_AddMouseScripts(self)
				--[[
				-- Allow mouse clicks on the plugin
				local pluginID = TitanUtils_GetButtonID(self:GetName());
				local plugin_id = TitanUtils_GetPlugin(pluginID);
				if (plugin_id) then
					self:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp");
					self:RegisterForDrag("LeftButton")
-- Per an API change in 11.2.0, disable drag & drop for now...
					if (plugin_id.id) then
						TitanPanelDetectPluginMethod(plugin_id.id);
					end
				end
--]]
				result = TITAN_REGISTERED
				-- determine the plugin category
				cat = (self.registry.category or "General")
				ptype = TITAN_ID -- Assume it is created for Titan
				if self.registry.ldb then
					-- Override the type with the LDB type
					ptype = "LDB: '" .. self.registry.ldb .. "'"
				end
				-- === Right click menu
				local frame = CreateFrame("Frame",
					self:GetName() .. TITAN_PANEL_CLICK_MENU_SUFFIX,
					self or nil,
					"UIDropDownMenuTemplate")
			end
			notes = (self.registry.notes or "")
		else
			-- There could be a couple reasons the .registry was not found
			result = TITAN_REGISTER_FAILED
			if (not self.registry) then
				issue = "Can not find registry for plugin (self.registry)"
			end
			if (self.registry and not self.registry.id) then
				issue = "Can not determine plugin name (self.registry.id)"
			end
		end
		--		end
	else
		-- The button could not be determined - the plugin is hopeless
		result = TITAN_REGISTER_FAILED
		issue = "Can not determine plugin button name"
	end

	Titan_Debug.Out('titan', 'plugin_register', "Plugin RegProt"
		--			.." '"..tostring(self:GetName()).."'"
		.. " '" .. tostring(id) .. "'"
		.. " '" .. tostring(result) .. "'"
		.. " '" .. tostring(str) .. "'"
		.. " '" .. tostring(TitanPlugins[id].id) .. "'"
	)

	-- create and return the results
	local ret_val = {}
	ret_val.issue = (issue or "")
	ret_val.result = (result or TITAN_REGISTER_FAILED)
	ret_val.id = (id or "")
	ret_val.cat = (cat or "General")
	ret_val.ptype = ptype
	ret_val.notes = notes
	return ret_val
end

---Titan Attempt to register a plugin that has requested to be registered
--- Lets be extremely paranoid here because registering plugins that do not play nice can cause real headaches...
---@param plugin table Plugin frame - Titan template
function TitanUtils_RegisterPlugin(plugin)
	local call_success, ret_val
	-- Ensure we have a glimmer of a plugin and that the plugin has not
	-- already been registered.
	if plugin and plugin.status == TITAN_NOT_REGISTERED then
		-- See if the request to register has a shot at success
		if plugin.self then
			-- Just in case, catch any errors
			call_success, -- needed for pcall
			ret_val = -- actual return values
				pcall(TitanUtils_RegisterPluginProtected, plugin)
			-- pcall does not allow errors to propagate out. Any error
			-- is returned as text with the success / fail.
			-- Think of it as a try - catch block
			if call_success then
				-- all is good so write the return values to the plugin
				plugin.status = ret_val.result
				plugin.issue = ret_val.issue
				plugin.name = ret_val.id
				plugin.category = ret_val.cat
				plugin.notes = ret_val.notes
				plugin.plugin_type = ret_val.ptype
			else
				-- write enough to the plugin so the user or developer
				-- can see Titan at least tried...
				plugin.status = TITAN_REGISTER_FAILED
				plugin.issue = (ret_val.issue or "Unknown error")
				plugin.name = "?"
				plugin.notes = ret_val.notes or ""
			end
		else
			-- write enough to the plugin so the user or developer can see something
			plugin.status = TITAN_REGISTER_FAILED
			plugin.issue = "Can not determine plugin button name"
			plugin.name = "?"
		end

		-- If there was an error tell the user.
		if not plugin.issue == ""
			or plugin.status ~= TITAN_REGISTERED then
			TitanPrint(TitanUtils_GetRedText("Error Registering Plugin")
				.. TitanUtils_GetGreenText(
					": "
					.. "name: '" .. (plugin.name or "?_") .. "' "
					.. "issue: '" .. (plugin.issue or "?_") .. "' "
					.. "button: '" .. plugin.button .. "' "
				)
				, "error")
		end

		Titan_Debug.Out('titan', 'plugin_register', "Registering Plugin"
			.. " " .. tostring(plugin.name) .. ""
			.. " " .. tostring(plugin.status) .. ""
		)
	end
end

---Titan Attempt to register the list of plugins that have requested to be registered
--- Tell the user when this starts and ends only on the first time.
--- This could be called if a plugin requests to be registered after the first loop through.
function TitanUtils_RegisterPluginList()
	-- Loop through the plugins that have requested to be loaded into Titan.
	local result = ""
	local issue = ""
	local id
	local cnt = 0
	if TitanPluginToBeRegisteredNum > 0 then
		if not Titan__InitializedPEW and TitanAllGetVar("Registered") then
			TitanDebug(L["TITAN_PANEL_REGISTER_START"], "normal")
		end
		for index, value in ipairs(TitanPluginToBeRegistered) do
			if TitanPluginToBeRegistered[index] then
				TitanUtils_RegisterPlugin(TitanPluginToBeRegistered[index])
			end
			cnt = cnt + 1
		end
		if not Titan__InitializedPEW and TitanAllGetVar("Registered") then
			TitanDebug((L["TITAN_PANEL_REGISTER_END"] .. " " .. cnt), "normal")
		end
	end
end

---API See if the given plugin was registered successfully.
---@param id string Plugin id
---@return boolean registered True if registered; False if not
function TitanUtils_IsPluginRegistered(id)
	if (id and TitanPlugins[id]) then
		return true;
	else
		return false;
	end
end

--====== Titan utility routines

---Titan Parse the Titan player / profile name and return the parts.
---@param name string Titan player / profile name
---@return string player_name or ""
---@return string server_name or ""
---@return boolean is_custom
function TitanUtils_ParseName(name)
	local server = ""
	local player = ""
	if name and name ~= TITAN_PROFILE_NONE then
		local s, e, ident = string.find(name, TITAN_AT);
		if s ~= nil then
			server = string.sub(name, s + 1);
			player = string.sub(name, 1, s - 1);
		end
	else
	end
	return player, server, (server == TITAN_CUSTOM_PROFILE_POSTFIX)
end

---Titan Given the player name and server and return the Titan player name; also used as profile name.
---@param player string
---@param realm string realm name or default
---@return string toon <player>@<realm>
function TitanUtils_CreateName(player, realm)
	local p1 = player or "?"
	local p2 = realm or "?"

	return p1 .. TITAN_AT .. p2
end

---Titan Create the character name / toon being played and return the parts.
---@return string toon name or "<>"
---@return string player_name or ""
---@return string server_name or ""
function TitanUtils_GetPlayer()
	local playerName = UnitName("player");
	local serverName = GetRealmName()
	local toon = "<>"

	if (playerName == nil
			or serverName == nil
			or playerName == UKNOWNBEING) then
		-- Do nothing if player name is not available
		playerName = ""
		serverName = ""
	else
		toon = playerName .. TITAN_AT .. serverName
	end

	return toon, playerName, serverName
end

---Titan Get the Info table off player Titan settings, if it exists
---@param toon string A player name to look up
---@return boolean
---@return table?
function TitanUtils_GetPlayerInfo(toon)
	local _, server, is_custom = TitanUtils_ParseName(toon)
	local p_info = nil
	if is_custom then
		-- there is no Info table... cannnot log into a custom profile
	elseif TitanSettings.Players[toon]
	and TitanSettings.Players[toon].Info
	then
		p_info = TitanSettings.Players[toon].Info
	else
		-- May not have logged into this toon in ages :) 
		-- tell caller no Info exists
	end

	return is_custom, p_info
end

---Titan Return the screen size after scaling
---@return table screenXY { x | y | scaled_x | scaled_y } all numbers
function TitanUtils_ScreenSize()
	local screen = {}

	local x = UIParent:GetRight()
	local y = UIParent:GetTop()
	local s = UIParent:GetEffectiveScale()

	screen.x = x
	screen.y = y
	screen.scaled_x = x * s
	screen.scaled_y = y * s

	--[[
	if output then
		local x = UIParent:GetRight()
		local y = UIParent:GetTop()
		local s = UIParent:GetEffectiveScale()
		local px, py = GetPhysicalScreenSize()
		print("_ScreenSize"
			.. "\n"
			.. " UI - x:" .. tostring(format("%0.1f", x)) .. ""
			.. " X y:" .. tostring(format("%0.1f", y)) .. ""
			.. "\n"
			.. " UI scaled - x:" .. tostring(format("%0.1f", screen.x * UIParent:GetEffectiveScale())) .. ""
			.. " X y:" .. tostring(format("%0.1f", screen.y * UIParent:GetEffectiveScale())) .. ""
			.. "\n"
			.. " Scale: UI" .. tostring(format("%0.6f", s)) .. ""
			.. " Titan " .. tostring(format("%0.1f", TitanPanelGetVar("Scale"))) .. ""
			.. "\n"
			.. " screen - x:" .. tostring(format("%0.1f", px)) .. ""
			.. " X y:" .. tostring(format("%0.1f", py)) .. ""
		)
	end
--]]

	return screen
end

--====== Export / Import specifc routines

local function TrimString(string)
	local from = string:match "^%s*()"
	return from > #string and "" or string:match(".*%S", from)
end

local function CopyToCompress(t1, t2)
	for key, value in pairs(t2) do
		if (key ~= "__index" and type(value) ~= "function") then
			if (type(value) == "table") then
				if (not value.GetObjectType) then
					t1[key] = t1[key] or {}
					CopyToCompress(t1[key], t2[key])
				end
			else
				t1[key] = value
			end
		end
	end
	return t1
end

---Titan Compress and serialize arbitrary data into a string
---@param data any
---@param dataType string print | comm
---@return string compressed could be ""
function TitanUtils_CompressData(data, dataType)
	local LibDeflate = LibStub:GetLibrary("LibDeflate")
	local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

	--check if there isn't funtions in the data to export
	local dataCopied = CopyToCompress({}, data)

	if (LibDeflate and LibAceSerializer) then
		local dataSerialized = LibAceSerializer:Serialize(dataCopied)
		if (dataSerialized) then
			local dataCompressed = LibDeflate:CompressDeflate(dataSerialized, { level = 9 })
			if (dataCompressed) then
				if (dataType == "print") then
					local dataEncoded = LibDeflate:EncodeForPrint(dataCompressed)
					return dataEncoded
				elseif (dataType == "comm") then
					local dataEncoded = LibDeflate:EncodeForWoWAddonChannel(dataCompressed)
					return dataEncoded
				end
			end
		end
	end

	return ""
end

---Titan Decompress and unserialize a string into the Lua data it represents
---@param data any
---@param dataType string print | comm
---@return boolean
---@return table
function TitanUtils_DecompressData(data, dataType)
	local LibDeflate = LibStub:GetLibrary("LibDeflate")
	local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

	if (LibDeflate and LibAceSerializer) then
		local dataCompressed

		if (dataType == "print") then
			data = TrimString(data)
			dataCompressed = LibDeflate:DecodeForPrint(data)
			if (not dataCompressed) then
				TitanPrint("Could not decode the data.", "warning")
				return false, {}
			end
		elseif (dataType == "comm") then
			dataCompressed = LibDeflate:DecodeForWoWAddonChannel(data)
			if (not dataCompressed) then
				TitanPrint("Could not decode the data.", "warning")
				return false, {}
			end
		end

		local dataSerialized = LibDeflate:DecompressDeflate(dataCompressed)
		if (not dataSerialized) then
			TitanPrint("Could not uncompress the data.", "warning")
			return false, {}
		end

		local okay, out_data = LibAceSerializer:Deserialize(dataSerialized)
		if (not okay) then
			TitanPrint("Could not unserialize the data.", "warning")
			return false, {}
		end

		return true, out_data
	end
	return false, {}
end

--------------------------------------------------------------
-- Various debug routines
--[[
local function Debug_array(message)
local idx = TitanDebugArray.index
	TitanDebugArray.index = mod(TitanDebugArray.index + 1, TITAN_PANEL_DEBUG_ARRAY_MAX)
	TitanDebugArray.lines[TitanDebugArray.index] = (date("%m/%d/%y %H:%M:%S".." : ")..message)
end
--]]

---Titan Get the Titan version as a string.
---@return string version
function TitanPanel_GetVersion()
	return tostring(TitanUtils_GetAddOnMetadata(TITAN_ID, "Version")) or L["TITAN_PANEL_NA"];
end

---Titan: Output a message safely to the user in a consistent format.
---@param message string Message to output ot Chat
---@param msg_type string? "info" | "warning" | "error" | "plain" | nil
function TitanPrint(message, msg_type)
	local dtype = ""
	local pre = TitanUtils_GetGoldText(L["TITAN_PANEL_PRINT"] .. ": ")
	local msg = ""
	if msg_type == "error" then
		dtype = TitanUtils_GetRedText(L["TITAN_PANEL_ERROR"])
	elseif msg_type == "warning" then
		dtype = TitanUtils_GetHexText(L["TITAN_PANEL_WARNING"], Titan_Global.colors.yellow)
	elseif msg_type == "plain" then
		pre = ""
	elseif msg_type == "header" then
		local ver = TitanPanel_GetVersion()
		pre = TitanUtils_GetGoldText(L["TITAN_PANEL"])
			.. TitanUtils_GetGreenText(" " .. ver)
			.. TitanUtils_GetGoldText(L["TITAN_PANEL_VERSION_INFO"]
			)
	end

	msg = pre .. dtype .. TitanUtils_GetGreenText(tostring(message))
	DEFAULT_CHAT_FRAME:AddMessage(msg)
	--	Debug_array(msg)
end

---Titan: Output a debug message safely in a consistent format.
---@param debug_message string Message to output to Chat
---@param debug_type string? "warning" | "error" | "normal" | nil
function TitanDebug(debug_message, debug_type)
	local dtype = ""
	local time_stamp = ""
	local msg = ""
	if debug_type == "error" then
		dtype = TitanUtils_GetRedText("Error: ")
	elseif debug_type == "warning" then
		dtype = TitanUtils_GetHighlightText("Warning: ")
	end
	if debug_type == "normal" then
		time_stamp = ""
	else
		time_stamp = TitanUtils_GetGoldText(date("%H:%M:%S") .. ": ")
	end
	if debug_message == true then
		debug_message = "<true>";
	end
	if debug_message == false then
		debug_message = "<false>";
	end
	if debug_message == nil then
		debug_message = "<nil>";
	end

	msg =
		TitanUtils_GetGoldText(L["TITAN_PANEL_DEBUG"] .. " ")
		.. tostring(time_stamp)
		.. tostring(dtype)
		--		..TitanUtils_GetBlueText(debug_message)
		.. TitanUtils_GetHexText(tostring(debug_message), "1DA6C5")

	if not TitanAllGetVar("Silenced") then
		_G["DEFAULT_CHAT_FRAME"]:AddMessage(msg)
	end
	--	Debug_array(msg)
	--date("%m/%d/%y %H:%M:%S")
end

---API: Output a debug message in a consistent format.
---@param id string Plugin id
---@param debug_message string Message to output to Chat
function TitanPluginDebug(id, debug_message)
	local msg =
		TitanUtils_GetGoldText("<" .. tostring(id) .. "> " .. date("%H:%M:%S"))
		.. " " .. TitanUtils_GetHexText(tostring(debug_message), "1DA6C5")

	_G["DEFAULT_CHAT_FRAME"]:AddMessage(msg)
end

---Titan: Output the current list of registered plugins.
function TitanDumpPluginList()
	-- Just dump the current list of plugins
	for idx, value in pairs(TitanPluginsIndex) do
		local plug_in = TitanUtils_GetPlugin(TitanPluginsIndex[idx])
		if type(plug_in) == 'table' then
			TitanDebug("TitanDumpPluginList "
				.. "'" .. tostring(idx) .. "'"
				.. ": '" .. tostring(plug_in.id) .. "'"
				.. ": '" .. tostring(plug_in.version) .. "'"
			)
		end
	end
end

---Titan: Output the current list of known characters / toons.
function TitanDumpPlayerList()
	local cnt = 0
	TitanDebug("TitanDumpPlayerList ==== start")
	if TitanSettings.Players then
		for idx, value in pairs(TitanSettings.Players) do
			TitanDebug("-- "
				.. "'" .. tostring(idx) .. "'"
			)
			cnt = cnt + 1
		end
	else
		TitanDebug("No player list found!!! "
		)
	end
	TitanDebug("TitanDumpPlayerList ==== done " .. cnt)
end

---Titan: Output the frame name, if known,and its parent name.
---@param self table Any frame
function TitanDumpFrameName(self)
	local frame
	local parent
	if self then
		frame = self:GetName()
	else
		frame = "?"
	end
	if frame == "?" then
		parent = "?"
	else
		parent = self:GetParent():GetName()
	end
	--[
	TitanDebug("_GetFrameName "
		.. tostring(self and "T" or "F") .. " "
		.. tostring(frame) .. " "
		.. tostring(parent) .. " "
	)
	--]]
end

---Titan: Output the value of Titan timer saved variables.TODO : (Needs Classic update!!)
function TitanDumpTimers()
	local str = "Titan-timers: "
		.. "'" .. tostring(TitanAllGetVar("TimerLDB")) .. "' "
	TitanPrint(str, "plain")
end

---Titan: Output an event and args 1 - 6.
---@param event string
---@param a1 any Argument 1
---@param a2 any Argument 2
---@param a3 any Argument 3
---@param a4 any Argument 4
---@param a5 any Argument 5
---@param a6 any Argument 6
function TitanArgConvert(event, a1, a2, a3, a4, a5, a6)
	local t1 = type(a1)
	local t2 = type(a2)
	local t3 = type(a3)
	local t4 = type(a4)
	local t5 = type(a5)
	local t6 = type(a6)
	TitanDebug(tostring(event) .. " "
		.. "1: " .. tostring(a1) .. "(" .. tostring(t1) .. ") "
		.. "2: " .. tostring(a2) .. "(" .. tostring(t2) .. ") "
		.. "3: " .. tostring(a3) .. "(" .. tostring(t3) .. ") "
		.. "4: " .. tostring(a4) .. "(" .. tostring(t4) .. ") "
		.. "5: " .. tostring(a5) .. "(" .. tostring(t5) .. ") "
		.. "6: " .. tostring(a6) .. "(" .. tostring(t6) .. ") "
	)
end

---Titan: Output a given table; up to a depth of 8 levels. Can generate A LOT of output!
---@param tb table
---@param level integer? 1 or defaults to 1
function TitanDumpTable(tb, level)
	level = level or 1
	local spaces = string.rep(' ', level)
	for k, v in pairs(tb) do
		if type(v) == "table" then
			print("[" .. level .. "]" .. spaces .. "[" .. tostring(k) .. "]" .. " " .. type(v))
			if level <= 8 then
				TitanDumpTable(v, level + 1)
			end
		else
			print("[" .. level .. "]" .. spaces .. "[" .. tostring(k) .. "]='" .. tostring(v) .. "' " .. type(v))
		end
	end
end

---Titan: From a given table; find input in its indexes.
---@param tb table
---@param val string 1 or defaults to 1
function TitanFindIndex(tb, val)
	for k, v in pairs(tb) do
		if type(k) == 'string' and string.find(k, val) then
			print("idx [" .. tostring(k) .. "] = " .. " '" .. tostring(v) .. "'")
		else
			-- keep looking
		end
	end
end

--====== Deprecated routines
-- These routines will be commented out for a couple releases then deleted.
--
--[===[

--]===]
