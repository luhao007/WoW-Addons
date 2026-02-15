---@diagnostic disable: duplicate-set-field
--[[
-- **************************************************************************
-- * TitanGold.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************
--]]

-- WoW method to get addon name
local addonName = ...

TitanGold = {} -- for API routines

-- ******************************** Constants *******************************
local TITAN_GOLD_ID = "Gold";
local TITAN_BUTTON = "TitanPanel" .. TITAN_GOLD_ID .. "Button"
local TITAN_GOLD_VERSION = TITAN_VERSION;
local TITAN_GOLD_SPACERBAR = "-----------------------";
local updateTable = { TITAN_GOLD_ID, TITAN_PANEL_UPDATE_TOOLTIP };

-- ******************************** Variables *******************************
local GOLD_INITIALIZED = false;
local GOLD_STARTINGGOLD;
local GOLD_SESSIONSTART;
local AceTimer = LibStub("AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
local GoldTimer = {};
local GoldTimerRunning = false
local _G = getfenv(0);
local realmName = ""     -- fill on PEW
local realmNames = {}    -- fill on PEW
local merged_realms = {} -- fill on PEW

-- English faction for indexing and sorting and coloring
local TITAN_ALLIANCE = "Alliance"
local TITAN_HORDE = "Horde"

local player_faction, player_faction_locale = UnitFactionGroup("Player")
local player_name = GetUnitName("Player")

--[[  debug
local FACTION_ALLIANCE = "Alliance_debug"
local FACTION_HORDE = "Horde_debug"
--]]

-- Topic debug tool / scheme
Titan_Debug.gold = {}
Titan_Debug.gold.events = false
Titan_Debug.gold.flow = false
Titan_Debug.gold.tool_tip = false
Titan_Debug.gold.total_gold = false
Titan_Debug.gold.eval = false

---@class GoldData
---@field gold number
---@field show boolean
local GoldData = nil -- pointer to this player plugin data
local GoldInfo = nil ---@class CharInfo
--TitanSettings.Players[toon].Info ---@type CharInfo

---@class IndexInfo Index flags
---@field valid boolean Saved toon is valid
---@field char_name string Saved toon name
---@field server string Saved toon server
---@field faction string Saved toon faction
---@field same_faction boolean Saved toon faction is same as player
---@field ignore_faction boolean User selection to ignore faction or not
---@field same_realm boolean Saved realm is same as this server
---@field merge_realm boolean Saved realm is in mergerd server list (connected servers)
---@field show_toon boolean Show server - simple test
---@field show boolean Show this toon
---@field gold number GHold on this toon

-- ******************************** Functions *******************************

---local Take the total cash and make it into a nice, colorful string of g s c (gold silver copper)
---@param value number
---@param show_zero boolean
---@param show_neg boolean
---@return string outstr Formatted cash for output
---@return integer gold part of value
---@return integer silver part of value
---@return integer copper part of value
local function NiceCash(value, show_zero, show_neg)
	local sep = ""
	local dec = ""
	if (TitanGetVar(TITAN_GOLD_ID, "UseSeperatorComma")) then
		sep = ","
		dec = "."
	elseif (TitanGetVar(TITAN_GOLD_ID, "UseSeperatorPeriod")) then
		sep = "."
		dec = ","
	elseif (TitanGetVar(TITAN_GOLD_ID, "UseSeperatorSpace")) then
		sep = " "
		dec = "."
	end

	local outstr, gold, silver, copper =
		TitanUtils_CashToString(value, sep, dec,
			TitanGetVar(TITAN_GOLD_ID, "ShowGoldOnly"),
			TitanGetVar(TITAN_GOLD_ID, "ShowCoinLabels"),
			TitanGetVar(TITAN_GOLD_ID, "ShowCoinIcons"),
			TitanGetVar(TITAN_GOLD_ID, "ShowColoredText"))
	return outstr, gold, silver, copper
end

-- A bit overkill but make a class for the Warbank bank functions

local Warband = {
	bank_sum = 0,
	active = false,
	label = "",
}
---local Warband Bank debug
function Gold_debug(reason)
	local str = ""
		.. "$" .. tostring(NiceCash(GetMoney(), false, false))
		.. " WB " .. reason
		.. " " .. tostring(Warband.active)
		.. " " .. tostring(Warband.label)
		.. " " .. tostring(NiceCash(Warband.bank_sum, false, false))
	return str
end

---local Check if Warband Bank is in this version and user requested
---@return boolean
function Warband.Use()
	local res = false
	if Warband.active then
		if TitanGetVar(TITAN_GOLD_ID, "ShowWarband") then
			res = true
		else
			-- Not requested by user
		end
	else
		-- Likely Classic version
	end
	return res
end

---local Update Warband Bank info - sum
function Warband.SetSum()
	if Warband.Use() then
		-- Really just prevents errors if not implemented in the WoW version

		-- There *may* have been instances of failure reported as Titan errors
		-- Wrap in pcall for safety
		--Warband.bank_sum = C_Bank.FetchDepositedMoney(Enum.BankType.Account)
		local sum = 0
		local call_success = false
		local ret_val = nil

		call_success, -- needed for pcall
		ret_val = -- actual return values
			pcall(C_Bank.FetchDepositedMoney, Enum.BankType.Account)

		if call_success then
			-- Assume a valid Warband cash amount (WOWMONEY)
			sum = ret_val
		else
			-- Set to zero as a default and not an error.
			sum = 0
		end
		Warband.bank_sum = sum
	else
		-- Likely Classic version
	end
end

---local Set Warband Bank info
function Warband.Init()
	-- check for func in case either Classic implements  (Added 11.0.0)
	Warband.active = (C_Bank and C_Bank.CanUseBank) and true or false
	if Warband.active then
		Warband.label = L["TITAN_WARBAND_BANK"]
	else
		-- Likely Classic version
	end
end

---local Return Warband Bank info
---@return number
function Warband.GetSum()
	return Warband.bank_sum
end

---local Return Warband Bank info
---@return string
function Warband.GetName()
	return Warband.label
end

--===

---Helper to safely encapsulate WoW API (returns number in form ggsscc)
---@return number
local function Get_Money()
	local money = GetMoney()
	-- Do safety check to prevent errors
	if type(money) == "number" then
		-- assume it is good
	else
		-- Not accurate but safe
		money = 0
	end
	Warband.SetSum() -- update warbank as well
	return money
end

local function GetConnectedRealms()
	local realms = GetAutoCompleteRealms()
	if #realms == 0 then
		realms[1] = GetRealmName()
	end
	return realms
end

---Take a table of indexes to sort gold
---@param gold_table table
---@return table sorted May not be need but it is explicit
local function SortByIndex(gold_table)
	local by_realm = TitanGetVar(TITAN_GOLD_ID, "GroupByRealm")
	local by_name = TitanGetVar(TITAN_GOLD_ID, "SortByName")
	-- This section will sort the array based on user preference
	-- * by name or by gold amount descending
	-- * grouping by realm if selected
	if by_name then
		table.sort(gold_table, function(key1, key2)
			return key1 < key2
		end)
	elseif by_realm then
		table.sort(gold_table, function(key1, key2)
			if gold_table[key1].realm ~= gold_table[key2].realm then
				return gold_table[key1].realm < gold_table[key2].realm
			end
			return false
		end)
	else
		-- just return the table untouched
	end

	return gold_table
end

---local Use index to get toon info from Titan
---@param info string
---@return string Character name - no server
---@return string Server name
---@return string Faction internal, not localized
local function GetIndexInfo(info)
	local t_info = TitanSettings.Players[info].Info ---@type CharInfo
	local character = t_info.name
	local charserver = t_info.server
	local char_faction = t_info.factionName
	return character, charserver, char_faction
end

---local Take Gold index and return parts plus various flags
---@param index string
---@return IndexInfo
local function EvalIndexInfo(index)
	local str = ""
	str = str .. tostring(index)

	local res = { valid = false } -- The return table will be built as needed.
	local character, charserver, is_custom = TitanUtils_ParseName(index)
	local toon_info = TitanSettings.Players[index].Info ---@class CharInfo
	if is_custom then
		-- do not fill in
		res.valid = false

		str = str .. " ignored : is_custom"
		Titan_Debug.Out('gold', 'eval', str)
	elseif toon_info == nil then
		-- do not fill in
		res.valid = false

		str = str .. " ignored : no data yet"
	else
		local toon_gold = toon_info[TITAN_GOLD_ID] ---@class GoldData
		if toon_gold == nil then
			res.valid = false

			str = str .. " ignored : info but no gold data yet"
		else
			res.valid = true

			res.char_name = character -- set in Info 9.1
			res.server = charserver -- set in Info 9.1
			res.faction = toon_info.faction

			res.ignore_faction = TitanGetVar(TITAN_GOLD_ID, "IgnoreFaction")

			if (res.faction == GoldInfo.faction) then
				res.same_faction = true
			else
				res.same_faction = false
			end

			if (res.server == GoldInfo.server) then
				res.same_realm = true
			else
				res.same_realm = false
			end

			local saved_server = string.gsub(res.server, "%s", "") -- GetAutoCompleteRealms removes spaces, idk why...
			if merged_realms[saved_server] then
				res.merge_realm = true
			else
				res.merge_realm = false
			end

			-- Assume server option is satisfied; check other options
			if (res.ignore_faction or res.same_faction) then
				res.show_toon = true
			else
				res.show_toon = false
			end

			res.gold = toon_gold.gold

			str = str
				.. " n:" .. tostring(res.char_name) .. ""
				.. " s:" .. tostring(res.server) .. ""
				.. " ss:" .. tostring(res.same_realm) .. ""
				.. " ms:" .. tostring(res.merge_realm) .. ""
				.. " f:" .. tostring(res.faction) .. ""
				.. " if:" .. tostring(res.ignore_faction) .. ""
				.. " sf:" .. tostring(res.same_faction) .. ""
				.. " show:" .. tostring(res.show_toon) .. ""
				.. " gold:" .. tostring(res.gold) .. ""
		end
	end

	Titan_Debug.Out('gold', 'eval', str)

	return res
end
---local Helper for TotalGold
--- If toon is to be shown add amount to total; otherwise pass back running total
local function ToonAdd(show, amount, total)
	local new_total = 0

	if show then
		new_total = total + amount
	else
		new_total = total
	end

	return new_total
end

---local Calculates total gold for display per user selections
---@return integer
local function TotalGold()
	-- EvalIndexInfo checks the toon info against the user options
	-- then returns a table of 'flags'.
	-- The if within each loop checks the appropriate flags per user server display option.
	local ttlgold = 0

	if TitanGetVar(TITAN_GOLD_ID, "SeparateServers") then
		Titan_Debug.Out('gold', 'total_gold', "=== SeparateServers")
		-- Parse the database and display all characters on this server
		for index, money in pairs(TitanSettings.Players) do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.same_realm and char.show_toon then
					ttlgold = ToonAdd(true, char.gold, ttlgold)
					Titan_Debug.Out('gold', 'total_gold',
						index .. " > " .. NiceCash(char.gold, false, false)
						.. " " .. NiceCash(ttlgold, false, false)
					)
				end
			else
				-- Do not show per flags
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers") then
		Titan_Debug.Out('gold', 'total_gold', "=== MergeServers")
		-- Parse the database and display characters on merged / connected servers
		for index, money in pairs(TitanSettings.Players) do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.merge_realm and char.show_toon then
					ttlgold = ToonAdd(true, char.gold, ttlgold)
					Titan_Debug.Out('gold', 'total_gold',
						index .. " " .. NiceCash(char.gold, false, false)
						.. " > " .. NiceCash(ttlgold, false, false)
					)
				end
			else
				-- Do not show per flags
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers") then
		Titan_Debug.Out('gold', 'total_gold', "=== AllServers")
		-- Parse the database and display characters on all servers
		for index, money in pairs(TitanSettings.Players) do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.show_toon then
					ttlgold = ToonAdd(true, char.gold, ttlgold)
					Titan_Debug.Out('gold', 'total_gold',
						index .. " " .. NiceCash(char.gold, false, false)
						.. " > " .. NiceCash(ttlgold, false, false)
					)
				end
			else
				-- Do not show per flags
			end
		end
	end

	--
	-- === Add Warband Bank, if enabled and requested
	if Warband.Use() then
		ttlgold = ttlgold + Warband.GetSum()
	end

	Titan_Debug.Out('gold', 'total_gold', "Total = " .. NiceCash(ttlgold, false, false))
	return ttlgold
end

-- ====== Tool tip routines

---local Generate formatted tooltip text
---@return string
local function GetTooltipText()
	local GoldSorted = {};
	local currentMoneyRichText = "";
	local countelements = 0;
	local faction = GoldInfo.factionName
	local ignore_faction = TitanGetVar(TITAN_GOLD_ID, "IgnoreFaction")

	for _ in pairs(realmNames) do
		countelements = countelements + 1
	end

	-- insert all keys from hash into the GoldSorted array

	if TitanGetVar(TITAN_GOLD_ID, "SeparateServers") then
		-- Parse the database and display characters from this server
		Titan_Debug.Out('gold', 'tool_tip', "=== SeparateServers")
		for index, money in pairs(TitanSettings.Players) do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.same_realm and char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, index);
				end
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers") then
		-- Parse the database and display characters from merged / connected servers
		Titan_Debug.Out('gold', 'tool_tip', "=== MergeServers")
		for index, money in pairs(TitanSettings.Players) do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.merge_realm and char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, index);
				end
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers") then
		-- Parse the database and display characters from all servers
		Titan_Debug.Out('gold', 'tool_tip', "=== AllServers")
		for index, money in pairs(TitanSettings.Players) do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, index);
				end
			end
		end
	end

	local by_realm = TitanGetVar(TITAN_GOLD_ID, "GroupByRealm")
	GoldSorted = SortByIndex(GoldSorted)

	-- Array holds all characters to display, nicely sorted.
	currentMoneyRichText = ""
	local coin_str = ""
	local faction_text = ""
	local curr_realm = ""
	local show_dash = false
	local show_realm = true
	local character, charserver, char_faction
	for i = 1, #GoldSorted do
		local toon = GoldSorted[i]
		character, charserver, char_faction = GetIndexInfo(toon)
		local t_gold = TitanSettings.Players[toon].Info[TITAN_GOLD_ID].gold
		coin_str = NiceCash(t_gold, false, false)
		show_dash = false
		show_realm = true

		if (TitanGetVar(TITAN_GOLD_ID, "SeparateServers")) then
			show_realm = false
		elseif (TitanGetVar(TITAN_GOLD_ID, "MergeServers")) then
			show_dash = true
		elseif (TitanGetVar(TITAN_GOLD_ID, "AllServers")) then
			show_dash = true
		end

		if by_realm then
			-- Set a realm header
			if charserver ~= curr_realm then
				currentMoneyRichText = currentMoneyRichText .. "\n"
					.. "-- " .. charserver
				curr_realm = charserver
			end
			show_dash = false
			show_realm = false
		end

		if ignore_faction then
			local font_size = TitanPanelGetVar("FontSize")
			local icon_pre = "|TInterface/AddOns/TitanGold/Artwork/"
			local icon_post = ":" .. font_size .. ":" .. font_size .. ":2:0|t"
			local a_icon = icon_pre .. "UI_AllianceIcon-round" .. icon_post
			local h_icon = icon_pre .. "UI_HordeIcon-round" .. icon_post
			if char_faction == TITAN_ALLIANCE then
				faction_text = " " .. a_icon
			elseif char_faction == TITAN_HORDE then
				faction_text = " " .. h_icon
			end
		end

		currentMoneyRichText = currentMoneyRichText .. "\n"
			.. character
			.. (show_dash and "-" or "")
			.. (show_realm and charserver or "")
			.. faction_text
			.. "\t" .. coin_str
	end

	--
	-- === Add Warband Bank
	--
	if Warband.Use() then
		local cash = NiceCash(Warband.GetSum(), false, false)
		local war_name = "" .. Warband.GetName() -- localized
		currentMoneyRichText = currentMoneyRichText .. "\n"
			.. "------ \t +" .. "\n"
			.. war_name
			.. "\t" .. cash
		local msg = "" .. war_name .. " " .. cash
		Titan_Debug.Out('gold', 'tool_tip', msg)
	end


	--[[
print("TG"
.." "..tostring(counter)
.." "..tostring(x0)
.." "..tostring(x1)
.." "..tostring(getn(GoldSorted))
.." "..tostring(TitanGetVar(TITAN_GOLD_ID, "SeparateServers"))
.." "..tostring(TitanGetVar(TITAN_GOLD_ID, "MergeServers"))
.." "..tostring(TitanGetVar(TITAN_GOLD_ID, "AllServers"))
.." "..tostring(TITANPANEL_TOOLTIP)
--.." "..tostring(TITANPANEL_TOOLTIP_X)
)
--]]

	--
	-- === Add Total per user options
	--
	coin_str = ""
	-- Display total gold
	coin_str = NiceCash(TotalGold(), false, false)
	currentMoneyRichText = currentMoneyRichText .. "\n"
		.. TITAN_GOLD_SPACERBAR .. "\n"
		.. L["TITAN_GOLD_TTL_GOLD"] .. "\t" .. coin_str

	-- find session earnings and earning per hour
	local sesstotal = Get_Money() - GOLD_STARTINGGOLD;
	local negative = false;
	if (sesstotal < 0) then
		sesstotal = math.abs(sesstotal);
		negative = true;
	end

	local sesslength = GetTime() - GOLD_SESSIONSTART;
	local perhour = math.floor(sesstotal / sesslength * 3600);

	coin_str = NiceCash(GOLD_STARTINGGOLD, false, false)

	local session_status;
	local per_hour_status;
	local sessionMoneyRichText = ""
	if TitanGetVar(TITAN_GOLD_ID, "ShowSessionInfo") then
		sessionMoneyRichText = "\n\n" .. TitanUtils_GetHighlightText(L["TITAN_GOLD_STATS_TITLE"])
			.. "\n" .. L["TITAN_GOLD_START_GOLD"] .. "\t" .. coin_str .. "\n"

		if (negative) then
			session_status = TitanUtils_GetRedText(L["TITAN_GOLD_SESS_LOST"])
			per_hour_status = TitanUtils_GetRedText(L["TITAN_GOLD_PERHOUR_LOST"])
		else
			session_status = TitanUtils_GetGreenText(L["TITAN_GOLD_SESS_EARNED"])
			per_hour_status = TitanUtils_GetGreenText(L["TITAN_GOLD_PERHOUR_EARNED"])
		end

		coin_str = NiceCash(sesstotal, true, true)
		sessionMoneyRichText = sessionMoneyRichText
			.. session_status
			.. "\t" .. coin_str .. "\n";

		if TitanGetVar(TITAN_GOLD_ID, "DisplayGoldPerHour") then
			coin_str = NiceCash(perhour, true, true)
			sessionMoneyRichText = sessionMoneyRichText
				.. per_hour_status
				.. "\t" .. coin_str .. "\n";
		end
	else
		-- Do not display session info
	end

	--
	-- === Add Gold notes and info
	--
	local final_tooltip = TitanUtils_GetGoldText(L["TITAN_GOLD_TOOLTIPTEXT"] .. " : ")

	local final_server = ""
	if realmNames == nil or TitanGetVar(TITAN_GOLD_ID, "SeparateServers") then
		final_server = realmName
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers") then
		final_server = L["TITAN_GOLD_MERGED"]
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers") then
		final_server = ALL
	end
	final_server = TitanUtils_GetGoldText(final_server .. " : ")

	local final_faction = ""
	if ignore_faction then
		final_faction = TitanUtils_GetGoldText(ALL)
	elseif faction == TITAN_ALLIANCE then
		final_faction = TitanUtils_GetHexText(FACTION_ALLIANCE, Titan_Global.colors.alliance)
	elseif faction == TITAN_HORDE then
		final_faction = TitanUtils_GetHexText(FACTION_HORDE, Titan_Global.colors.horde)
	end

	return ""
		.. currentMoneyRichText .. "\n"
		.. TITAN_GOLD_SPACERBAR .. "\n"
		.. final_tooltip .. final_server .. final_faction .. "\n"
		.. sessionMoneyRichText
end
-- ======

-- ====== Right click menu routines

local function ResetSession()
	GOLD_STARTINGGOLD = Get_Money();
	GOLD_SESSIONSTART = GetTime();
	DEFAULT_CHAT_FRAME:AddMessage(TitanUtils_GetGreenText(L["TITAN_GOLD_SESSION_RESET"]));
end

---local See if this toon is in saved vars AFTER PEW event.
--- Get current total and session start time. Toon gold is available via API AFTER PEW event.
local function Initialize_Array()
	Titan_Debug.Out('gold', 'flow', "Init inititated")

	local info = ""
	if (GOLD_INITIALIZED) then
		-- already done
	else
		-- See if this is a new toon to Gold saved vars or reset
		local gindex, _, _ = TitanUtils_GetPlayer()
		-- TitanSettings.Players[toon].Info.[TITAN_GOLD_ID]

		GoldInfo = TitanSettings.Players[gindex].Info

		if GoldInfo[TITAN_GOLD_ID] then
			-- use existing data
		else
			GoldInfo[TITAN_GOLD_ID] = {}
			GoldData = GoldInfo[TITAN_GOLD_ID]
			GoldData.gold = 0
		end

		Warband.Init()

		GOLD_STARTINGGOLD = Get_Money();
		GOLD_SESSIONSTART = GetTime();
		GOLD_INITIALIZED = true;

		GoldData = GoldInfo[TITAN_GOLD_ID]
		GoldData.gold = Get_Money()

		info = ""
			.. " " .. tostring(GOLD_SESSIONSTART) .. ""
			.. " " .. tostring(GOLD_STARTINGGOLD) .. ""
			.. " " .. tostring(Warband.GetSum()) .. ""
	end

	local msg = ">Init done : "
		.. " " .. tostring(GOLD_INITIALIZED) .. ""
		.. " " .. info .. ""
	Titan_Debug.Out('gold', 'flow', msg)
end

---local Clear the gold array and rebuild
---@param self Button
local function ClearData(self)
	GOLD_INITIALIZED = false;

	Initialize_Array();

	TitanPanelButton_UpdateButton(TITAN_GOLD_ID)

	DEFAULT_CHAT_FRAME:AddMessage(TitanUtils_GetGreenText(L["TITAN_GOLD_DB_CLEARED"]));
end

---local Pops an 'are you sure' when user clicks to reset the gold array
local function TitanGold_ClearDB()
	StaticPopupDialogs["TITANGOLD_CLEAR_DATABASE"] = {
		text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"] .. " "
			.. L["TITAN_GOLD_MENU_TEXT"]) .. "\n\n" .. L["TITAN_GOLD_CLEAR_DATA_WARNING"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function(self)
			local frame = _G["TitanPanelGoldButton"]
			ClearData(frame)
		end,
		showAlert = 1,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	};
	StaticPopup_Show("TITANGOLD_CLEAR_DATABASE");
end

local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_GOLD_ID
	local root = rootDescription -- menu widget to start with

	local opts_gold = Titan_Menu.AddButton(root, L["TITAN_GOLD_TOOLTIP_DISPLAY_OPTIONS"])
	do           -- next level options
		local list = { -- a mututally exclusive triple
			{ L["TITAN_GOLD_SEPARATE"], "SeparateServers" },
			{ L["TITAN_GOLD_MERGE"],    "MergeServers" },
			{ L["TITAN_GOLD_ALL"],      "AllServers" },
		}
		Titan_Menu.AddSelectorExclusiveList(opts_gold, id, L["TITAN_GOLD_SORT_BY"], list)
		Titan_Menu.AddSelector(opts_gold, id, L["TITAN_GOLD_IGNORE_FACTION"], "IgnoreFaction")

		local coins = { -- a mututally exclusive triple
			{ L["TITAN_GOLD_COIN_NONE"],   "ShowCoinNone" },
			{ L["TITAN_GOLD_COIN_LABELS"], "ShowCoinLabels" },
			{ L["TITAN_GOLD_COIN_ICONS"],  "ShowCoinIcons" },
		}
		Titan_Menu.AddSelectorExclusiveList(opts_gold, id, "Coin Labels", coins)

		local seps = { -- a mututally exclusive triple
			{ L["TITAN_PANEL_USE_COMMA"],  "UseSeperatorComma" },
			{ L["TITAN_PANEL_USE_PERIOD"], "UseSeperatorPeriod" },
			{ "Use Space",                 "UseSeperatorSpace" },
		}
		Titan_Menu.AddSelectorExclusiveList(opts_gold, id, "Seperator", seps)

		Titan_Menu.AddDivider(opts_gold)

		Titan_Menu.AddSelector(opts_gold, id, L["TITAN_GOLD_SHOW_STATS_TITLE"], "ShowSessionInfo")

		Titan_Menu.AddDivider(opts_gold)

		Titan_Menu.AddSelector(opts_gold, id, L["TITAN_GOLD_TOGGLE_GPH_SHOW"], "DisplayGoldPerHour")
	end

	local disp = { -- selectors using the same option
		{ L["TITAN_GOLD_TOGGLE_ALL_TEXT"],    true },
		{ L["TITAN_GOLD_TOGGLE_PLAYER_TEXT"], false },
	}
	Titan_Menu.AddSelectorList(root, id, nil, "ViewAll", disp)

	if Warband.active then
		Titan_Menu.AddSelector(root, id, L["TITAN_GOLD_INCLUDE_WARBANK"], "ShowWarband")
	else
		-- Warbank not in this expansion
	end
	Titan_Menu.AddDivider(root)

--	Titan_Menu.AddCommand(root, id, L["TITAN_GOLD_CLEAR_DATA_TEXT"], TitanGold_ClearDB)
--	Titan_Menu.AddCommand(root, id, L["TITAN_GOLD_RESET_SESS_TEXT"], ResetSession)
end

---local Get the gold total the user wants (server or player).
local function FindGold()
	if (not GOLD_INITIALIZED) then
		-- in case there is no db entry for this toon, return blank.
		-- When Gold is ready it will init
		return ""
	end

	local ret_str = ""
	local ttlgold = 0;

	if TitanGetVar(TITAN_GOLD_ID, "ViewAll") then
		ttlgold = TotalGold()
	else
		ttlgold = GoldData.gold
	end

	ret_str = NiceCash(ttlgold, true, false)

	return L["TITAN_GOLD_MENU_TEXT"] .. ": " .. FONT_COLOR_CODE_CLOSE, ret_str
end

---local Build the plugin .registry and init and register for events
---@param self Button
local function OnLoad(self)
	local notes = ""
		.. "Keeps track of all gold held by a player's toons.\n"
		.. "- Can show by server / merged servers / all servers.\n"
		.. "- Can show by faction.\n"
		.. "Shift + Left click will print list of connected servers to chat.\n"
	self.registry = {
		id = TITAN_GOLD_ID,
		category = "Built-ins",
		version = TITAN_GOLD_VERSION,
		menuText = L["TITAN_GOLD_MENU_TEXT"],
		--menuTextFunction = CreateMenu, -- OLD
		menuContextFunction = GeneratorFunction, -- NEW scheme
		tooltipTitle = L["TITAN_GOLD_TOOLTIP"],
		tooltipTextFunction = GetTooltipText,
		buttonTextFunction = FindGold,
		icon = "Interface\\AddOns\\TitanGold\\Artwork\\TitanGold",
		iconWidth = 16,
		notes = notes,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			Initialized = true,
			DisplayGoldPerHour = true,
			ShowCoinNone = false,
			ShowCoinLabels = true,
			ShowCoinIcons = false,
			ShowGoldOnly = false,
			SortByName = true,
			ViewAll = true,
			ShowIcon = true,
			ShowLabelText = false,
			ShowColoredText = true,
			DisplayOnRightSide = false,
			UseSeperatorComma = true,
			UseSeperatorPeriod = false,
			UseSeperatorSpace = false,
			MergeServers = false,
			SeparateServers = true,
			AllServers = false,
			IgnoreFaction = false,
			GroupByRealm = false,
			gold = { total = "112233", neg = false },
			ShowSessionInfo = true,
			ShowWarband = true,
		}
	};

	self:RegisterEvent("ADDON_LOADED");
	--	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

---local When shown, register needed events and start timer for gold per hour
---@param self Button
local function OnShow(self)
	Initialize_Array()
	self:RegisterEvent("PLAYER_MONEY")

	if TitanGetVar(TITAN_GOLD_ID, "DisplayGoldPerHour") then
		if GoldTimerRunning then
			-- Do not start a new one
		else
			GoldTimer = AceTimer:ScheduleRepeatingTimer(TitanPanelPluginHandle_OnUpdate, 1, updateTable)
			GoldTimerRunning = true
		end
	else
		-- timer running or user does not want gold per hour
	end

	local msg = ""
		.. " " .. Gold_debug("OnShow")
	Titan_Debug.Out('gold', 'flow', msg)
end

---local When shown, unregister needed events and stop timer for gold per hour
---@param self Button
local function OnHide(self)
	self:UnregisterEvent("PLAYER_MONEY");
	AceTimer:CancelTimer(GoldTimer)
	GoldTimerRunning = false
end

---local Handle registered events for this plugin
---@param self Button
---@param event string
---@param ... any
local function OnEvent(self, event, a1, ...)
	if (event == "PLAYER_MONEY") then
		if (GOLD_INITIALIZED) then
			GoldData.gold = Get_Money()
			TitanPanelButton_UpdateButton(TITAN_GOLD_ID)
		end
	elseif (event == "ADDON_LOADED") then
		if a1 == addonName then
			realmName = GetRealmName() -- this realm
			realmNames = GetConnectedRealms()
			-- flip to make a simple lookup later rather than a loop
			for index, realm in pairs(realmNames) do
				merged_realms[realm] = true
			end

			self:UnregisterEvent("ADDON_LOADED");
		else
			-- Not this addon
			return -- no debug, if enabled
		end
	end

	Titan_Debug.Out('gold', 'events', event)
end

---Button clicks - only shift-left for now
---@param self Button
---@param button string
local function OnClick(self, button)
	if button == "LeftButton" and IsShiftKeyDown() then
		local realms = GetConnectedRealms()
		local this_realm = " * "
		local mark = ""
		TitanPrint("Connected Realms:", "plain")
		for idx = 1, #realms do
			if realms[idx] == realmName then
				mark = this_realm
			else
				mark = ""
			end
			TitanPrint("- " .. tostring(realms[idx]) .. mark, "plain")
		end
	end
end

---Get gold for given player or why it is not
---@param player string Titan format - name with server
---@param add_label boolean
---@return string
function TitanGold.GetInfo(player, add_label)
	local res = ""
	local label = ""
	if add_label then
		label = L["TITAN_GOLD_MENU_TEXT"] .. " : "
	else
		label = ""
	end

	local character, charserver, is_custom = TitanUtils_ParseName(player)
	if is_custom then
		res = L["TITAN_PANEL_NA"]
	elseif _G[TITAN_BUTTON]:IsShown() then
		local toon_gold = nil
		if TitanSettings.Players[player]
			and TitanSettings.Players[player].Info
			and TitanSettings.Players[player].Info[TITAN_GOLD_ID] then
			toon_gold = TitanSettings.Players[player].Info[TITAN_GOLD_ID] ---@class GoldData
			res = NiceCash(toon_gold.gold, true, false)
		else
			res = L["TITAN_PANEL_NA"].." - Not logged in yet with Gold enabled."
		end
	else
		res = L["TITAN_PANEL_MENU_DISABLED"]
	end

	return label..res
end
---local Create required Gold frames
local function Create_Frames()
	if _G[TITAN_BUTTON] then
		return -- if already created
	end

	-- general container frame
	local f = CreateFrame("Frame", nil, UIParent)
	--	f:Hide()

	-- Titan plugin button
	local window = CreateFrame("Button", TITAN_BUTTON, f, "TitanPanelComboTemplate")
	window:SetFrameStrata("FULLSCREEN")
	-- Using SetScript("OnLoad",   does not work
	OnLoad(window);
	--	TitanPanelButton_OnLoad(window); -- Titan XML template calls this...

	window:SetScript("OnShow", function(self)
		OnShow(self);
		TitanPanelButton_OnShow(self);
	end)
	window:SetScript("OnHide", function(self)
		OnHide(self);
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
