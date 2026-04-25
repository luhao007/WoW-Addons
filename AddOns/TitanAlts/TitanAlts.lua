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

local QTip = LibStub("LibQTip-1.0")
local iconProvider, cellPrototype, baseCellPrototype = QTip:CreateCellProvider(QTip.LabelProvider)
-- Required for Create - just call the base init
function cellPrototype:InitializeCell()
	baseCellPrototype.InitializeCell(self);
end

-- Required for Create - override the base Setup to use an icon
function cellPrototype:SetupCell(tooltip, value, justification, font)
	local _, height = baseCellPrototype.SetupCell(self, tooltip, format("|T%s:0|t", tostring(value)), "CENTER");
	return baseCellPrototype.SetupCell(self, tooltip,
		format("|T%s:%2$d:%2$d:0:0:64:64:4:60:4:60|t", tostring(value), height), "CENTER");
end

local UNK = TitanUtils_GetGrayText("-")
--]]

local artwork_path = "Interface\\AddOns\\TitanAlts\\Artwork\\"
local TITAN_PLUGIN = "Alts"
local TITLE = "Alts"
local TITAN_BUTTON = "TitanPanel" .. TITAN_PLUGIN .. "Button"
local TITAN_TOOLTIP = "TitanPanel" .. TITAN_PLUGIN .. "Tooltip"
local VERSION = C_AddOns.GetAddOnMetadata(add_on, "Version")
local MAX_COLS = 10
local TT_DELAY = 0.5 -- seconds : default, use Titan setting

local Alts = {} -- namespace for Alts routines as needed

-- ******************************** IDE *******************************
---@class AltInfo -- To store desired info for display
---@field name_titan string
---@field server string
---@field class string
---@field className string
---@field classId number
---@field faction string
---@field factionName string
---@field level number
---@field levelText string
---@field race string
---@field raceName string
---@field raceId number
---@field gold_toon string
---@field itemLevelAve number
---@field itemLevelEquipped number
---@field itemLevelPvp number
---@field zoneText string
---@field subZoneText string
---@field logout string
---@field xp_now number -- UnitXP("player") and UnitXPMax("player"); GetXPExhaustion()
---@field xp_max number
---@field xp_per string
---@field xp_rest number -- ?? GetRestState() for XP multiplier
---@field prof_1 string -- GetProfessions() then GetProfessionInfo(index)
---@field prof_2 string
---@field played_total number -- RequestTimePlayed() >> TIME_PLAYED_MSG
---@field sync_titan string -- may implement
---@field sync_global boolean -- may implement

-- ******************************** Variables *******************************
local trace = false -- true / false    Make true when debug output is needed.
local alts_tt = {}  -- Holds alt data for tooltip display; gen once except for logged in toon
local alts_tt_sort_col = "" -- one sort to rule them all...
local alts_tt_sort_ascend = true -- default on click; click again to flip
local tt_frame = {} -- tooltip on the QTip :)

Titan_Debug.alts = {}
Titan_Debug.alts.tool_tips = false

-- ******************************** Routines *******************************

--Helper routines

local function CloseQTooltip(self, force)
	if self.qtip:Acquire("TitanAlts_Tooltip", MAX_COLS) then --(not self.qtooltip) then
		if (force) then
			self.qtooltip.locked = false;
		end
		if (self.qtooltip.locked) then
			-- leave tooltip alone
		else
			self.qtooltip:SetScale(1);
			self.qtip:Release(self.qtooltip);
			--        table.wipe(alts_tooltip);
		end
	else
		return;
	end
end

local function GetTimeParts(seconds_value)
	local s = seconds_value
	local years = 0
	local days = 0
	local hours = 0
	local minutes = 0
	local seconds = 0
	if not s or (s < 0) then
		seconds = -1
	else
		years = floor(s / 365 / 24 / 60 / 60); s = mod(s,  365 * 24 * 60 * 60);
		days = floor(s / 24 / 60 / 60); s = mod(s, 24 * 60 * 60);
		hours = floor(s / 60 / 60); s = mod(s, 60 * 60);
		minutes = floor(s / 60); s = mod(s, 60);
		seconds = s;
	end

	return years, days, hours, minutes, seconds
end

local function GetAbbrTimeText(seconds_value)
	local timeText = "";
	local years, days, hours, minutes, seconds = GetTimeParts(seconds_value)
	if seconds == nil 
	or seconds == 0
	then
		timeText = UNK
	else
		if (years > 0) then
			timeText = timeText .. format("%d" .. "y" .. " ", years);
		end
		if (days > 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_DAYS_ABBR"] .. " ", days);
		end
		if (hours > 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_HOURS_ABBR"] .. " ", hours);
		elseif (hours == 0 and minutes > 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_HOURS_ABBR"] .. " ", hours);
		end
--[[
		if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
			timeText = timeText .. format("%d" .. L["TITAN_PANEL_MINUTES_ABBR"] .. " ", minutes);
		end
--		timeText = timeText .. format("%d" .. L["TITAN_PANEL_SECONDS_ABBR"], seconds)
--]]
	end
	return timeText;
end

---local Helper to set both the parent and the position of Tooltip for the plugin tooltip.
---@param parent table Reference to the frame to attach the tooltip to
---@param anchorPoint string Tooltip anchor location (side or corner) to use
---@param relativeToFrame string name name of the frame, usually the plugin), to attach the tooltip to
---@param relativePoint string Parent anchor location (side or corner) to use
---@param xOffset number X offset
---@param yOffset number Y offset
---@param frame table Tooltip frame
---@param custom boolean If custom / not tooltip frame
local function SetOwnerPosition(parent, anchorPoint, relativeToFrame, relativePoint, xOffset, yOffset, frame, custom)
	-- Changes for 9.1.5 Removed the background template from the Tooltip
	-- Making changes to it difficult and possibly changing the tooltip globally.

	if custom then
		-- do NOT set owner - it clears the contents!
	else
		frame:SetOwner(parent, "ANCHOR_NONE")
	end

	frame:SetPoint(anchorPoint, relativeToFrame, relativePoint, xOffset, yOffset);

	-- set font size for the Game Tooltip
	if TitanPanelGetVar("DisableTooltipFont") then
		-- use UI scale
	else
		if TitanTooltipScaleSet < 1 then
			TitanTooltipOrigScale = frame:GetScale();
			TitanTooltipScaleSet = TitanTooltipScaleSet + 1;
		end
		frame:SetScale(TitanPanelGetVar("TooltipFont"));
	end

	local dbg_msg = "_SetOwner _pos"
		.. " '" .. tostring(frame:GetName()) .. "'"
		.. " " .. tostring(frame:IsShown()) .. ""
		.. " @ '" .. tostring(relativeToFrame) .. "'"
		.. " " .. tostring(_G[relativeToFrame]:IsShown()) .. ""
	Titan_Debug.Out('alts', 'tool_tips', dbg_msg)
	dbg_msg = ">>_pos"
		.. " " .. tostring(anchorPoint) .. ""
		.. " " .. tostring(relativePoint) .. ""
		.. " w" .. tostring(format("%0.1f", frame:GetWidth())) .. ""
		.. " h" .. tostring(format("%0.1f", frame:GetHeight())) .. ""
	Titan_Debug.Out('alts', 'tool_tips', dbg_msg)
end

---local Helper to set the screen position of the tooltip frame
---@param self table Plugin frame
---@param id string Plugin id name
---@param frame table Tooltip frame to use
---@param custom? boolean If custom / not tooltip frame
local function SetPanelTooltip(self, id, frame, custom)
	local is_custom = custom or false
	local button = _G[id]

	if button then
		-- Adjust the Y offset as needed
		local top = self:GetTop()
		local hgt = frame:GetHeight()
		local lft = self:GetLeft()

		local rel_y = top - hgt
		local pt = ""
		local rel_pt = ""
		if rel_y > 0 then
			pt = "TOP";
			rel_pt = "BOTTOM";
		else
			-- too close to bottom of screen
			pt = "BOTTOM";
			rel_pt = "TOP";
		end
		local rel_x = lft + hgt
		if (rel_x < GetScreenWidth()) then
			-- menu will fit
			pt = pt .. "LEFT";
			rel_pt = rel_pt .. "LEFT";
		else
			pt = pt .. "RIGHT";
			rel_pt = rel_pt .. "RIGHT";
		end

		SetOwnerPosition(button, pt, button:GetName(), rel_pt, 0, 0, frame, is_custom)
	end
end

local function ClassColors(class, str)
	local res = str
	local use = TitanGetVar(TITAN_PLUGIN, "use_class_colors")
	if use then
		--	local colors = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		local colors = RAID_CLASS_COLORS[class]
		if colors then
			local r = string.format("%02x", colors.r * 255)
			local g = string.format("%02x", colors.g * 255)
			local b = string.format("%02x", colors.b * 255)
			local coloredText = "|cff" .. r .. g .. b .. str .. "|r"
			res = coloredText
		end
	else
		-- untouched
	end
	return res
end

---Based on 'lock' set timeout to hide
---@param plugin table Plugin
local function SetTooltipHide(plugin)
	if (plugin.qtooltip.locked) then
		plugin.qtooltip:SetAutoHideDelay(nil)
	else
		local delay = TT_DELAY
		if delay < 0.1 then
			delay = 0.1 -- QTip does NOT like a delay of 0 :)
		else
			-- use as is
		end
		plugin.qtooltip:SetAutoHideDelay(delay, plugin)
	end
end

---Flip 'lock' to keep tooltip visible or not
---@param self any
---@param plugin table Plugin
local function OnPinClick(self, plugin)
	-- self out of QTip is nil
	-- plugin is param passed into QTip SetScript
	plugin.qtooltip.locked = not plugin.qtooltip.locked
	SetTooltipHide(plugin)
	Alts.GenTooltip(plugin)
end

local function Get_lvl(level)
	local res = ""
	if level == nil
		or level == 0 then
		res = UNK
	else
		res = string.format("%.0f", level)
	end

	return res
end

local function GetSync(toon)
	local profile = TitanVariables_GetProfile(toon)
	local res = ""
	local global = false

	-- Create string after Profile name in header
	if profile.ptype == Titan_Global.profile.GLOBAL then
		res = profile.cname
		global = true
	elseif profile.ptype == Titan_Global.profile.SYNC then
		res = profile.cname
	elseif profile.ptype == Titan_Global.profile.TOON then
		res = Titan_Global.profile.NONE
	else
		res = UNK
	end

	return res, global
end

local function Cell_tt_show(self, text)
	--    HideDetail();
	local tt = tt_frame
	tt:SetClampedToScreen(true)
	tt:SetOwner(self, "ANCHOR_RIGHT", 10, -10)
	SetPanelTooltip(self, self, tt, false)
	tt:SetFrameLevel(self:GetFrameLevel() + 1)
	tt:SetText(text)

	-- for keeping tooltip up if cursor never goes over tooltip
	-- via OnUpdate script
	tt.parent_frame = self
	tt:Show()
end

local function Cell_tt_hide(self, text, parent)
	local tt = tt_frame
	tt:Hide()
end

---Local Sort the alts list per col and sort order set.
local function Sort_DB()

	local tt_key = alts_tt_sort_col
	local sorter = nil
	if alts_tt_sort_ascend then
		sorter = function(a, b)
			return a[tt_key] < b[tt_key]
		end;
	else
		sorter = function (a, b)
			return a[tt_key] > b[tt_key]
		end;
	end

	for idx = 1, #alts_tt do
		table.sort(alts_tt, sorter)
	end
end

---Local Called when user clicks a sortable col header. Ensure sort col and order are set then redraw.
---@param self any
---@param tt_key string
local function Sort_Click(self, tt_key)

	if alts_tt_sort_col == tt_key then
		alts_tt_sort_ascend = not alts_tt_sort_ascend -- flip the sort
	else
		alts_tt_sort_ascend = true
	end
	alts_tt_sort_col = tt_key

	-- Redraw tooltip
	Alts.GenTooltip(_G[TITAN_BUTTON])
end

---Local Called on display of tooltip; Ensure col and sort order set if first time otherwise use as is
local function Sort_Display()

	if alts_tt_sort_col == "" then
		alts_tt_sort_col = 'name_titan'
		alts_tt_sort_ascend = true
	else
		-- use it
	end

	Sort_DB()
end

-- Grab the button text to display
local function GetButtonText(id)
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	local strA, strB = TITLE, ""
	local ave = format("%.2f", avgItemLevel)
	local eq = format("%.0f", avgItemLevelEquipped)
	local pvp = format("%.2f", avgItemLevelPvp)
	return strA, strB, "ilvl : ", eq
end

-- Routine per column...
local headerFont = {}
local header_justify = "CENTER"

local function GenFaction(self, row, col, action, tt_info, toon_info)
	local next = nil
	if action == 'header' then -- show the 'lock' pin
		row, next = self.qtooltip:SetCell(row,
			col,
			artwork_path .. "TitanPanelPushpin" .. (self.qtooltip.locked and "In" or "Out"), -- value
			iconProvider                                                               --,
		)
		self.qtooltip:SetCellScript(row, col, "OnEnter", Cell_tt_show, (self.qtooltip.locked and UNLOCK or LOCK) );
		self.qtooltip:SetCellScript(row, col, "OnLeave", Cell_tt_hide);
		self.qtooltip:SetCellScript(row, col, "OnMouseDown", OnPinClick, self)
	elseif action == 'row' then -- show faction icon
		local cell = toon_info[tt_info.tt_key] -- faction or not known or possibly Classic / OLD toon
		if cell == "Alliance" then
			row, next = self.qtooltip:SetCell(row, col, artwork_path .. "Alliance",	iconProvider)
		elseif cell == "Horde" then
			row, next = self.qtooltip:SetCell(row, col, artwork_path .. "Horde", iconProvider)
		else
			-- just in case. Technically a faction must be chosen now but there could be OLD toons out there.
			row, next = self.qtooltip:SetCell(row, col, "")
		end
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

local total_toons = 0
local total_shown = 0
local function GenToonName(self, row, col, action, tt_info, toon_info)
	local next = nil
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify)
		self.qtooltip:SetCellScript(row, col, "OnMouseDown", Sort_Click, tt_info.tt_key)
		total_shown = 0
	elseif action == 'row' then
		local cell = (toon_info[tt_info.tt_key] or UNK)
		row, next = self.qtooltip:SetCell(row, col, ClassColors(toon_info.className, cell))
		total_shown = total_shown + 1
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, tostring(total_shown).." / "..tostring(total_toons))
	else
		-- !?
	end

	return row, next
end

local function GenLevel(self, row, col, action, tt_info, toon_info)
	local next = nil
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify);
		self.qtooltip:SetCellScript(row, col, "OnMouseDown", Sort_Click, tt_info.tt_key)
	elseif action == 'row' then
		local cell = (toon_info[tt_info.tt_key] or UNK) -- whole number or not known
		row, next = self.qtooltip:SetCell(row, col, cell, "RIGHT")
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

local function GenILevel(self, row, col, action, tt_info, toon_info)
	local next = nil
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify)
		self.qtooltip:SetCellScript(row, col, "OnMouseDown", Sort_Click, tt_info.tt_key)
	elseif action == 'row' then
		local cell = toon_info[tt_info.tt_key] -- need as number to format
		local str = ""
		local tt_str = ""
		if cell == nil or cell == 0 then
			str = UNK
		else
			str = string.format("%.0f", cell)
			tt_str = PVP.." "..string.format("%.0f", toon_info.itemLevelPvp)
		end
		row, next = self.qtooltip:SetCell(row, col, str, "RIGHT")
		if tt_str == "" then
			-- nothing to show
		else
			self.qtooltip:SetCellScript(row, col, "OnEnter", Cell_tt_show, tt_str)
			self.qtooltip:SetCellScript(row, col, "OnLeave", Cell_tt_hide);
		end
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

local function GenZone(self, row, col, action, tt_info, toon_info)
	local next = nil
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify);
	elseif action == 'row' then
		local cell = (toon_info[tt_info.tt_key] or UNK) -- string or not known
		row, next = self.qtooltip:SetCell(row, col, cell)
		local tt = ""
			..L["TITAN_LOCATION_TOOLTIP_SUBZONE"]..(toon_info.subZoneText or "").."\n"
			..L["TITAN_LOCATION_TOOLTIP_INN"]..(toon_info.hearth_binding or UNK)
		self.qtooltip:SetCellScript(row, col, "OnEnter", Cell_tt_show, tt )
		self.qtooltip:SetCellScript(row, col, "OnLeave", Cell_tt_hide)
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

local function GenLogout(self, row, col, action, tt_info, toon_info)
	local next = nil
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify);
	elseif action == 'row' then
		local cell = (toon_info[tt_info.tt_key] or UNK) -- formatted date or not known
		row, next = self.qtooltip:SetCell(row, col, cell)
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

local total_gold = 0
local function GenMoney(self, row, col, action, tt_info, toon_info)
	local next = nil
	local str = ""
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify)
		self.qtooltip:SetCellScript(row, col, "OnMouseDown", Sort_Click, tt_info.tt_key)
		total_gold = 0
	elseif action == 'row' then
		local cell = toon_info[tt_info.tt_key] -- need number to format
		str = ""
		if cell == nil or cell == 0 then
			str = UNK
		else
			str = TitanUtils_CashToString(cell, ",", ".", true, false, true, true)
			total_gold = total_gold + cell
		end
		row, next = self.qtooltip:SetCell(row, col, str, "RIGHT")
	elseif action == 'total' then
		str = TitanUtils_CashToString(total_gold, ",", ".", true, false, true, true)
		row, next = self.qtooltip:SetCell(row, col, str)
	else
		-- !?
	end

	return row, next
end

local total_played = 0
local function GenPlayed(self, row, col, action, tt_info, toon_info)
	local next = nil
	local str = ""
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify)
		self.qtooltip:SetCellScript(row, col, "OnMouseDown", Sort_Click, tt_info.tt_key)
		total_played = 0
	elseif action == 'row' then
		local cell = toon_info[tt_info.tt_key] -- need number to format
		-- total time played
		str = ""
		if cell == nil or cell == 0 then
			str = UNK
		else
			str = GetAbbrTimeText(cell)
			total_played = total_played + (cell or 0)
		end
		row, next = self.qtooltip:SetCell(row, col, str, "RIGHT")
	elseif action == 'total' then
		str = GetAbbrTimeText(total_played)
		row, next = self.qtooltip:SetCell(row, col, str)
	else
		-- !?
	end

	return row, next
end

local function GenSync(self, row, col, action, tt_info, toon_info)
	local next = nil
	local str = ""
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify)
	elseif action == 'row' then
		local cell = (toon_info[tt_info.tt_key] or UNK) -- sync profile or not known
		row, next = self.qtooltip:SetCell(row, col, cell)
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

local max_level = 0
local function GenXP(self, row, col, action, tt_info, toon_info)
	local next = nil
	local str = ""
	if action == 'header' then
		row, next = self.qtooltip:SetCell(row, col, tt_info.title, headerFont, header_justify)
	elseif action == 'row' then
		str = ""
		local tt_str = ""
		if toon_info.xp_now == nil
			or toon_info.xp_max == nil
			or toon_info.xp_now == 0
			or toon_info.xp_max == 0 then
			str = UNK
			tt_str = "Log in"
		elseif toon_info.level_toon == max_level then
			str = UNK
			tt_str = "Max level"
		else
			local per = (toon_info.xp_now / toon_info.xp_max) * 100
			str = string.format("%d%%", per)
			tt_str = toon_info.xp_now.. " / ".. toon_info.xp_max
		end
		row, next = self.qtooltip:SetCell(row, col, str)
		self.qtooltip:SetCellScript(row, col, "OnEnter", Cell_tt_show, tt_str);
		self.qtooltip:SetCellScript(row, col, "OnLeave", Cell_tt_hide);
	elseif action == 'total' then
		row, next = self.qtooltip:SetCell(row, col, "")
	else
		-- !?
	end

	return row, next
end

--[[
This scheme may be overkill but is a data driven approach when columns are
across header, rows, and total of the tooltip.

tt_cols : holds the col name in the order they will be displayed
tt_data : index are names in tt_col; holds info to fill a cell
- config : if true place in config for Show / Hide
- title : column title
- tt_key : column field; used in sort if enabled; also saved var name for show / hide if config is true
Used to allow loops and min 'hard coding' - only need to change in two places tt_data and OnLoad
- cell_func expects (plugin(Alts), row, col, action, toon name, toon table/info) for SetCell
returning row, next_col/nil
A routine is needed for each col because each col has unique processing needs.

In the GenTooltip there will be 3 loops : header, row, and total
- cell_func must handle each action to ensure data aligns
- Qtip will handle the size and spacing

--]]

local tt_cols = { -- set order of the cols, user can show / hide most
	"faction",
	"toon_name",
	"level",
	"item_level",
	"zone",
	"logout",
	"money",
	"played",
	"profile",
	"unit_xp",
}
local tt_data = { -- index MUST include all tt_cols values !!!
	["faction"] = {
		config = false,
		tt_key = "faction",
		sortable = false,
		title = "",
		cell_func = GenFaction,
	},
	["toon_name"] = {
		config = false,
		tt_key = "name_titan",
		title = NAME,
		cell_func = GenToonName,
	},
	["level"] = {
		config = true,
		tt_key = "level_toon",
		title = LEVEL_ABBR,
		cell_func = GenLevel,
	},
	["item_level"] = {
		config = true,
		tt_key = "itemLevelEquipped",
		title = ITEM_LEVEL_ABBR,
		cell_func = GenILevel,
	},
	["zone"] = {
		config = true,
		tt_key = "zone",
		title = ZONE,
		cell_func = GenZone,
	},
	["logout"] = {
		config = true,
		tt_key = "logout",
		title = L["TITAN_PANEL_MENU_PROFILE_LOGOUT"],
		cell_func = GenLogout,
	},
	["money"] = {
		config = true,
		tt_key = "gold_toon",
		title = L["TITAN_GOLD_MENU_TEXT"],
		cell_func = GenMoney,
	},
	["played"] = {
		config = true,
		tt_key = "played_total",
		title = PLAYED,
		cell_func = GenPlayed,
	},
	["profile"] = {
		config = true,
		tt_key = "sync_titan",
		title = L["TITAN_PANEL_MENU_PROFILE_SYNC"],
		cell_func = GenSync,
	},
	["unit_xp"] = {
		config = true,
		tt_key = "xp_now",
		title = L["TITAN_XP_MENU_TEXT"],
		cell_func = GenXP,
	},
}

---Generate or wipe the tooltip DB
---@param action string create | wipe
local function GenDB(self, action)

	wipe(alts_tt)
	if action == 'wipe' then
		-- already cleared, get out
	else
		for idx, pdata in TitanUtils_PlayerIter() do
			local result = ""
			local str = ""
			local toon_info ---@class CharInfo
			local alt_info = {} ---@class AltInfo

			result, toon_info = TitanUtils_GetProfileInfo(idx, "Info", false)
			if result == "is_custom" then
				-- skip, can not log in
			elseif toon_info then -- found BUT could be empty...
				-- Need to copy so Titan Settings are not changed
				alt_info[tt_data["faction"].tt_key] = toon_info.faction
				alt_info[tt_data["toon_name"].tt_key] = idx
				alt_info.className = toon_info.className --ClassColors(toon_info.className, toon_info.class)
				alt_info[tt_data["level"].tt_key] = toon_info.level
				alt_info.levelText = Get_lvl(toon_info.level)
				alt_info[tt_data["zone"].tt_key] = toon_info.zoneText
				alt_info.subZoneText = toon_info.subZoneText
				alt_info[tt_data["logout"].tt_key] = TitanUtils_GetDateText(toon_info.logout, false)
				alt_info[tt_data["money"].tt_key] = toon_info.gold_toon
				alt_info[tt_data["item_level"].tt_key] = toon_info.itemLevelEquipped
				alt_info.itemLevelPvp = toon_info.itemLevelPvp

				alt_info[tt_data["played"].tt_key] = toon_info.played_total

				alt_info[tt_data["profile"].tt_key], alt_info.sync_global = GetSync(idx)

				alt_info[tt_data["unit_xp"].tt_key] = toon_info.unit_xp
				alt_info.xp_max = toon_info.unit_xp_max
				alt_info.xp_per = ""

				alt_info.hearth_binding = toon_info.hearth_binding

				-- Get Alts plugin info; 
				-- this will create .Alts table on a character profile, if it does not exist
				local res, plugin_info = TitanUtils_GetProfileInfo(idx, "Alts", true)
				if res == 'created' then
					plugin_info.show = true -- default
				else
					-- use the value
				end
				local show_me = false
				if plugin_info then -- sometimes IDE is a pain... :)
					show_me = plugin_info.show
				else
					-- should never get here
				end
				alt_info.show = show_me


				table.insert(alts_tt, alt_info)
			end
		end

		Sort_Display()
	end
end

function Alts.GenTooltip(self)
	self.qtooltip:Clear()
	self.qtooltip:SetScale(TitanPanelGetVar("Scale"));
	self.qtooltip:SmartAnchorTo(self);
	self.qtooltip.parent = self

	headerFont = self.qtooltip:GetHeaderFont()
	headerFont:SetTextColor(NORMAL_FONT_COLOR:GetRGB())

	-- This may not be ideal but it does collect the current toon...
	GenDB(self, 'create')
	local column
	local row

	-- To allow configurable cols, we need to check at each point we build a line
	-- to keep data in the right cols. 
	-- Declare here to use local vars
	local function CheckCol(col_name, action, toon_info)
		local ok = false
		if tt_data[col_name].config then
			if TitanGetVar(TITAN_PLUGIN, tt_data[col_name].tt_key) then
				ok = true
			else
				-- user does not want to show
			end
		else
			ok = true -- required
		end
		if ok then
			row, column = tt_data[col_name].cell_func(self, row, column, action, tt_data[col_name], toon_info)
		else
			-- skip this col
		end
	end

	-- NOTE: The various QTip cell functions advance 'column' on success
	-- NOTE: The various QTip row functions advance 'row' on success

	-- Create header
	row, column = self.qtooltip:AddHeader()
	for idx = 1, #tt_cols do
		CheckCol(tt_cols[idx], 'header', nil)
	end

	row, column = self.qtooltip:AddSeparator();

	total_toons = 0
	for idx = 1, #alts_tt do
		local toon_info ---@class AltInfo
		toon_info = alts_tt[idx]
		local result, this_toon = TitanUtils_GetProfileInfo(toon_info.name_titan, "Alts", false)

		if toon_info == nil then
			-- IDE sanity check, should be filled by GenDB
		elseif this_toon then
			if this_toon.show == true then
				row, column = self.qtooltip:AddLine()

				for col_idx = 1, #tt_cols do
					CheckCol(tt_cols[col_idx], 'row', toon_info)
				end
			else
				-- user deselected
			end
			total_toons = total_toons + 1 -- count toward total
		else
			-- !?
		end
	end

	row, column = self.qtooltip:AddSeparator()
	row, column = self.qtooltip:AddLine()

	local str = " "
	for idx = 1, #tt_cols do
		CheckCol(tt_cols[idx], 'total', nil)
	end

	self.qtooltip:UpdateScrolling(512)
	self.qtooltip:Show()
	SetTooltipHide(self)

end

local scroll_hgt = math.floor(GetScreenHeight() * .6) -- virtual height in pixels
local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_PLUGIN
	local root = rootDescription -- menu widget to start with

	CloseQTooltip(_G[TITAN_BUTTON], true)

	local opts_show = Titan_Menu.AddButton(root, SHOW)
	do -- next level options
		for idx = 1, #tt_cols do
			local col_name = tt_cols[idx]

			if tt_data[col_name].config then
				Titan_Menu.AddSelector(opts_show, id, tt_data[col_name].title, tt_data[col_name].tt_key)
			else
				-- not user selectable to hide
			end
		end
		Titan_Menu.AddDivider(opts_show)
		Titan_Menu.AddSelector(opts_show, id, "Use Class Colors", "use_class_colors")
	end

	--		for idx, pdata in TitanUtils_PlayerIter() do
	local opts_show_toons = Titan_Menu.AddButton(root, L["TITAN_PANEL_MENU_PROFILE_CHARS"])
	do -- next level options
		for idx, pdata in TitanUtils_PlayerIter() do
			local result, toon_info = TitanUtils_GetProfileInfo(idx, "Alts", false)
			if result == "is_custom" then
				-- skip, can not log in
			elseif toon_info then
				Titan_Menu.AddSelectorGeneric(opts_show_toons, idx,
					function(data)
						return data.toon.show
					end,
					function(data)
						data.toon.show = not data.toon.show
					end,
					{ toon = toon_info }
				)
			else
				-- not user selectable to hide
			end
		end
	end
	Titan_Menu.SetScroll(opts_show_toons, scroll_hgt) -- in case menu height is larger than screen / window

end

local function OnEnter(self)
	if self.qtip:IsAcquired("TitanAlts_Tooltip") then
		-- tooltip is active
	else
		self.qtooltip = self.qtip:Acquire("TitanAlts_Tooltip", MAX_COLS);
		Alts.GenTooltip(self)
	end
end

local function OnLeave(self, force)
	CloseQTooltip(self, force)
end

-- Create the .registry for Titan so it can register and place the plugin

local function OnLoad(self)
	local notes = ""
		.. "Relevant info on toon and alts.\n"
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
		--		tooltipTextFunction = GetTooltipText,
		icon = artwork_path .. "Alts",
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
			-- show / hide cols 
			--tt_key doubles as saved var
			level_toon = true,
			itemLevelEquipped = true,
			zone = false,
			logout = false,
			gold_toon = true,
			played_total = false,
			sync_titan = false,
			xp_now = true,
			-- end show / hide cols
			use_class_colors = true,
		}
	}

	self.qtip = QTip
	self.qtipIconProvider = iconProvider
	self.qtooltip = {}
	self.qtooltip.locked = false

end

-- Parse and react to registered events
local function OnEvent(self, event, a1, a2, ...)
	if (event == "PLAYER_EQUIPMENT_CHANGED") then
		TitanPanelButton_UpdateButton(TITAN_PLUGIN)
	end

	Titan_Debug.Out('gold', 'events', event)
end

-- Handle mouse clicks
local function OnClick(self, button)
	if trace then
		TitanPluginDebug(TITAN_PLUGIN, "Titan Alts click"
			.. " " .. tostring(button) .. ""
		)
	end
	if (button == "LeftButton") then
		--		C_UI.Reload() --ReloadUI()
	end
end

local function OnShow(self)
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
--	GenDB(self, 'create')
	TitanPanelButton_UpdateButton(TITAN_PLUGIN)

	max_level = GetMaxPlayerLevel() -- GetMaxLevelForPlayerExpansion()

	TitanPanelGetVar("TooltipTimeout")
end

local function OnHide(self)
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
	GenDB(self, 'wipe')
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
	window:SetScript("OnHide", function(self)
		OnHide(self)
	end)
	window:SetScript("OnEvent", function(self, event, ...)
		OnEvent(self, event, ...)
	end)
	window:SetScript("OnClick", function(self, button)
		-- Typically this routine handles actions on left click
		OnClick(self, button);
		-- Typically this routine handles the menu creation on right click
		TitanPanelButton_OnClick(self, button);
	end)

	window:SetScript("OnEnter", function(self)
		OnEnter(self)
	end)
	window:SetScript("OnLeave", function(self)
		--OnLeave(self)
	end)

	-- Create tooltip frame for this plugin

	-- OnUpdate starts as soon as OnShow is done...
	tt_frame = CreateFrame("GameTooltip", TITAN_TOOLTIP, UIParent, "GameTooltipTemplate")

	window.qtooltip.locked = false -- not needed but be explicit for tooltip 'pin'

	tt_frame:SetScript("OnShow", function(self)
		TT_DELAY = TitanPanelGetVar("TooltipTimeout") -- in case user changed in Titan

		-- OnShow will start the OnUpdate.
		-- If user enters plugin, the tooltip will show
		-- BUT if the user never enters the tooltip, it will keep showing because
		-- the OnLeave did not kick the timer.
		TitanUtils_StartFrameCounting(self, TT_DELAY)
	end)
	tt_frame:SetScript("OnEnter", function(self)

		TitanUtils_StopFrameCounting(self)
	end)
	tt_frame:SetScript("OnLeave", function(self)

		if TT_DELAY < 0.1 then
			tt_frame:Hide() -- hide right away
		else
			TitanUtils_StartFrameCounting(self, TT_DELAY)
		end
	end)

	tt_frame:SetScript("OnUpdate", function(self, elapsed)
		-- Compromise to keep tooltip open if the user stays over plugin
		-- and does not mouse over tooltip frame (OnEnter)
		local is_over = self.parent_frame:IsMouseOver()
		if is_over then
			TitanUtils_StopFrameCounting(self)
		else
			TitanUtils_CheckFrameCounting(self, elapsed);
		end
	end)

	--[[ TODO : not working - try later :)
	tt_frame:SetScript("OnMouseDown", function (self, button)
		local locked = self.parent_frame.qtooltip.locked
		if ( locked and button == "RightButton" ) then
			self:SetMovable(true)
			self:StartMoving()
			self.isMoving = true
		end
	end)
	tt_frame:SetScript("OnMouseUp", function (self, button)
		if ( self.isMoving ) then
			self:StopMovingOrSizing()
			self:SetMovable(false)
			self.isMoving = false
		end
	end)
--]]
end

Create_Frames() -- do the work


--[[ ==== Design

This plugin will show values stored in the Titan profile so the user can see Alts info
in a tooltip.
The data is stored in the profile because the game API allows access to the current logged in toon only.
Titan core does not rely on the logout event to capture info.
API routines called within the logout event processing return invalid results.
The tooltip is large and complex so the QTip lib (library) is used to present the info in 
a readable format with tooltips on tooltips :).
QTip essentially builds a spreadsheet like frame within the tooltip frame.
We are using a custom tooltip that inherits from GameTooltip to avoid 'secret' errors.


NOTE: The Alts plugin table tt_data uses tt_key as the field element link between:
- Data from Titan profiles of each user toon
- Alts tooltip column data of each user toon
- Alts registry to hide / show columns
It makes for funky looking code but allows the field element to be changed in two places.
And allows new column routines to be created via copy paste and min edits
without changing the tooltip generator loop or the menu generation.


==== Instructions to add a new column: ====
- Add collection of the data to Titan to place in profile. See
local function SetToonInfo(toon)    to start.
Events may need to be added to collect the data.
Also add to @class ClassInfo for IDE (in _TitanIDE.lua file)

- Add an entry to tt_cols : The order is the order the columns are displayed!
Use a descriptive, searchable name for the entry.

- Add the same, as an index, to tt_data
		config = false, -- true if user can toggle show / hide
		tt_key = "faction", -- this is the field element link !!!
		sortable = false, -- true if user can sort by clicking the col header
		title = "", -- Header title
		cell_func = GenFaction, -- function (Gen*) to be called for header / row / total

- Edit GenDB to copy the profile info into Alts.
Also add to @class AltInfo for IDE (in this file)
Use the format :
alt_info[tt_data["faction"].tt_key] = toon_info.faction
for column data that is shown and, more imnportantly, may be sorted.
Ensure to add any non column data that is needed - example subZone for Zone.
alt_info.subZoneText = toon_info.subZoneText
Note: The non column data should only be needed in GenDB and the cooresponding Gen* routine.
The result is stored for the tooltip:
table.insert(alts_tt, alt_info)

- Add the column to the registry in OnLoad.
Use the same values as tt_key !!!!

- Copy a Gen* routine that is close to what you want. 
Paste and rename it the same assigned in cell_func.
The parameters are the same for all column routines.
Then edit it to add tooltips, color, totals, etc.
Note : Each routine has 3 sections to process the column:
- header : Title of the column; add sort or tooltip as needed
- row : How each cell should look; add tooltip if needed
- total : total OR x / total OR blank

Note : Sort is auto-magic. Sort_Click allows only one column to be sorted at a time.
Sort_Click sorts the 'row' data using tt_key field; not header ot total.
Alphabetic sort only - Deep in QTip all cells are strings.
Sort_Click 'flips' between ascending and descending. Usually ascending (A-Z) first but
if the user is clicking a lot, it is possible they need to click twice to get the order they want.


There should be no need to change the tooltip generator (Alts.GenTooltip)
nor the menu generator (GeneratorFunction).

--]]