---@diagnostic disable: duplicate-set-field
--[[
-- **************************************************************************
-- * TitanGold.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************
--]]

-- WoW method to get addon name
local addonName = ...;
TitanGold = {} -- for API routines

-- ******************************** Constants *******************************
local TITAN_GOLD_ID = "Gold"
local TITAN_BUTTON = "TitanPanel"..TITAN_GOLD_ID.."Button"
local TITAN_GOLD_VERSION = TITAN_VERSION;
--local TITAN_GOLD_SPACERBAR = "-----------------------"
local updateTable = {TITAN_GOLD_ID, TITAN_PANEL_UPDATE_TOOLTIP}

-- ******************************** Variables *******************************
local GOLD_INITIALIZED = false;
local GOLD_STARTINGGOLD, GOLD_SESSIONSTART;
local AceTimer = LibStub("AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
local GoldTimer, GoldTimerRunning = {}, false;
local _G = getfenv(0)
local realmName, realmNames, merged_realms = "", {}, {}					-- fill on PEW
-- English faction for indexing and sorting and coloring
local TITAN_ALLIANCE, TITAN_HORDE = "Alliance", "Horde"
local player_faction, player_faction_locale = UnitFactionGroup("Player")
local player_name = GetUnitName("Player")

--[[  debug
local FACTION_ALLIANCE = "Alliance_debug"
local FACTION_HORDE = "Horde_debug"
--]]

-- Topic debug tool / scheme
Titan_Debug.gold = {events = false, flow = false, tool_tip = false, total_gold = false, eval = false}

---@class GoldData
---@field gold number
---@field show boolean
local GoldData = nil ---@class GoldInfo
local GoldInfo = nil ---@class CharInfo

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
	local sep, dec = "", ""
	if(TitanGetVar(TITAN_GOLD_ID, "UseSeperatorComma"))then sep = "," dec = "."
	elseif(TitanGetVar(TITAN_GOLD_ID, "UseSeperatorPeriod"))then sep = "." dec = ","
	elseif(TitanGetVar(TITAN_GOLD_ID, "UseSeperatorSpace"))then sep = " " dec = "." end
	local outstr, gold, silver, copper = TitanUtils_CashToString(value, sep, dec, TitanGetVar(TITAN_GOLD_ID, "ShowGoldOnly"), TitanGetVar(TITAN_GOLD_ID, "ShowCoinLabels"), TitanGetVar(TITAN_GOLD_ID, "ShowCoinIcons"),
		TitanGetVar(TITAN_GOLD_ID, "ShowColoredText"))
	return outstr, gold, silver, copper;
end

-- A bit overkill but make a class for the Warbank bank functions
local Warband = {bank_sum = 0, active = false, label = ""}
---local Warband Bank debug
function Gold_debug(reason)
	local str = "$"..tostring(NiceCash(GetMoney(), false, false)).." WB "..reason.." "..tostring(Warband.active).." "..tostring(Warband.label).." "..tostring(NiceCash(Warband.bank_sum, false, false))
	return str;
end

---local Check if Warband Bank is in this version and user requested
---@return boolean
function Warband.Use()
	local res = false
	if Warband.active then
		if TitanGetVar(TITAN_GOLD_ID, "ShowWarband")then res = true;
		else
			-- Not requested by user
		end
	else
		-- Likely Classic version
	end
	return res;
end

---local Update Warband Bank info - sum
function Warband.SetSum()
	if Warband.Use()then
		-- Really just prevents errors if not implemented in the WoW version
		-- There *may* have been instances of failure reported as Titan errors
		local sum = 0;
		local call_ok, ret_val = pcall(C_Bank.FetchDepositedMoney, Enum.BankType.Account)
		if call_ok then
			-- Assume a valid Warband cash amount (WOWMONEY)
			sum = ret_val;
		else
			-- Set to zero as a default and not an error.
			sum = 0;
		end
		Warband.bank_sum = sum;
	else
		-- Likely Classic version
	end
end

---local Set Warband Bank info
function Warband.Init()
	-- check for func in case either Classic implements  (Added 11.0.0)
	Warband.active = (C_Bank and C_Bank.CanUseBank)and true or false;
	if Warband.active then Warband.label = L["TITAN_WARBAND_BANK"]
	else
		-- Likely Classic version
	end
end

---local Return Warband Bank info
---@return number
function Warband.GetSum()return Warband.bank_sum;end

---local Return Warband Bank info
---@return string
function Warband.GetName()return Warband.label;end

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
		money = 0;
	end
	Warband.SetSum() -- update warbank as well
	return money;
end

local function GetConnectedRealms()
	local realms = TitanUtils_GetMergedRealms()
	if #realms == 0 then realms[1] = GetRealmName()end
	return realms;
end

---local Take Gold index and return parts plus various flags
---@param index string
---@return IndexInfo
local function EvalIndexInfo(index)
	local str = tostring(index)
	local res = {valid = false}
	-- The return table will be built as needed.
	local character, charserver, is_custom = TitanUtils_ParseName(index)
	local result = ""
	local toon_info ---@class CharInfo
	result, toon_info = TitanUtils_GetProfileInfo(index, "Info", false)
	if result == "is_custom" then
		-- do not fill in
		res.valid = false;
		str = str.." ignored: is_custom"
		Titan_Debug.Out('gold', 'eval', str)
	elseif result == "not_found" then
		-- do not fill in
		res.valid = false;
		str = str.." ignored: no data yet"
	elseif result == "found" then
		if toon_info == nil then
		else
			local toon_gold ---@class GoldData
			result, toon_gold = TitanUtils_GetProfileInfo(index, "Gold", false)
			if toon_gold == nil then
				res.valid = false;
				str = str.." ignored: info but no gold data yet"
			else
				res.valid = true;
				res.char_name = character; -- set in Info 9.1
				res.server = charserver; -- set in Info 9.1
				res.faction = toon_info.faction;
				res.ignore_faction = TitanGetVar(TITAN_GOLD_ID, "IgnoreFaction")
				if(res.faction == GoldInfo.faction)then res.same_faction = true;else res.same_faction = false;end
				if(res.server == GoldInfo.server)then res.same_realm = true;else res.same_realm = false;end
				local saved_server = string.gsub(res.server, "%s", "")
				if merged_realms[saved_server]then res.merge_realm = true;else res.merge_realm = false;end
				-- Assume server option is satisfied; check other options
				if(res.ignore_faction or res.same_faction)and toon_gold.show then res.show_toon = true;else res.show_toon = false;end
				res.gold = toon_gold.gold;
				res.show = toon_gold.show; -- user option
				str = str.." n:"..tostring(res.char_name).." s:"..tostring(res.server).." ss:"..tostring(res.same_realm).." ms:"..tostring(res.merge_realm).." f:"..tostring(res.faction).." if:"..tostring(res.ignore_faction)
					.." sf:"..tostring(res.same_faction).." show:"..tostring(res.show_toon).." gold:"..tostring(res.gold)..""
			end
		end
	else str = str.." ignored: no data yet" end
	Titan_Debug.Out('gold', 'eval', str)
	return res;
end

---local Helper for TotalGold
--- If toon is to be shown add amount to total; otherwise pass back running total
local function ToonAdd(show, amount, total)
	local new_total = 0;
	if show then new_total = total + amount;
	else new_total = total;end
	return new_total;
end

---local Calculates total gold for display per user selections
---@return integer
local function TotalGold()
	-- EvalIndexInfo checks the toon info against the user options then returns a table of 'flags'.
	-- The if within each loop checks the appropriate flags per user server display option.
	local ttlgold = 0;
	if TitanGetVar(TITAN_GOLD_ID, "SeparateServers") then
		Titan_Debug.Out('gold', 'total_gold', "=== SeparateServers")
		-- Parse the database and display all characters on this server
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.same_realm and char.show_toon then
					ttlgold = ToonAdd(true, char.gold, ttlgold)
					Titan_Debug.Out('gold', 'total_gold',
						index.." > "..NiceCash(char.gold, false, false)
						.." "..NiceCash(ttlgold, false, false)
					)
				end
			else
				-- Do not show per flags
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers") then
		Titan_Debug.Out('gold', 'total_gold', "=== MergeServers")
		-- Parse the database and display characters on merged / connected servers
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.merge_realm and char.show_toon then
					ttlgold = ToonAdd(true, char.gold, ttlgold)
					Titan_Debug.Out('gold', 'total_gold',
						index.." "..NiceCash(char.gold, false, false)
						.." > "..NiceCash(ttlgold, false, false)
					)
				end
			else
				-- Do not show per flags
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers") then
		Titan_Debug.Out('gold', 'total_gold', "=== AllServers")
		-- Parse the database and display characters on all servers
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.show_toon then
					ttlgold = ToonAdd(true, char.gold, ttlgold)
					Titan_Debug.Out('gold', 'total_gold',
						index.." "..NiceCash(char.gold, false, false)
						.." > "..NiceCash(ttlgold, false, false)
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

	Titan_Debug.Out('gold', 'total_gold', "Total = "..NiceCash(ttlgold, false, false))
	return ttlgold
end

-- ====== Tool tip routines

--- functions to check the work after manipulate an singulary array or an array with subarrays
local function printArray(t)for k, v in pairs(t)do print(k..": ", v)end end
local function printTable(t)for k, v in pairs(t)do if type(v) == "table" then print(k..": ")printArray(v)else print(k..": ", v)end end end

--- function to hard copy an array
local function deepcopy(orig)
	local orig_type = type(orig)
	local copy;
	if orig_type == 'table' then copy = {}
		for orig_key, orig_value in next, orig, nil do copy[deepcopy(orig_key)] = deepcopy(orig_value)end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else copy = orig;end
	return copy;
end

local function MySort(copy, sort_by)			--- changing some Variables for more global using
	if sort_by == "NameAsc" then table.sort(copy, function(key1, key2)return key1.char_name < key2.char_name;end)
	elseif sort_by == "GoldAsc" then table.sort(copy, function(key1, key2)return key1.gold < key2.gold;end)
	elseif sort_by == "GoldDec" then table.sort(copy, function(key1, key2)return key1.gold > key2.gold;end)
	else end
end

-- ====== Tool tip routines
---Take a table of toons to sort per user settings: @param gold_table table; @return table sorted May not be need but it is explicit
local function SortByIndex(gold_table)
	-- special thanks to Leifweng (Andr\E9) for the code to show all server properly!
	-- save array for safety
	local origin = deepcopy(gold_table)
	-- original sourcecode
	local sort_by, by_realm = TitanGetVar(TITAN_GOLD_ID, "SortByName"), TitanGetVar(TITAN_GOLD_ID, "GroupByRealm")
	--- Yeah, after a feeling from 1000 of hours the function is ready for use (I hope so, because I don't have many Chars in retail).
	if by_realm then
		if TitanGetVar(TITAN_GOLD_ID, "AllServers")then
			local copy, sorting, test = {}, {}, {} --(arrays and container for internal use)
			for _, subTable in pairs(gold_table)do
				local value = subTable["server"]
				if value ~= nil then
					if not sorting[value]then
						sorting[value] = true;
					end
				end
			end
			for value, _ in pairs(sorting)do table.insert(test, value)end
			table.sort(test, function(key1, key2)return key1 < key2;end)
			for i = 1, #test do copy[i] = deepcopy(gold_table)
				MySort(copy[i], sort_by)
				for k = #copy[i], 1, -1 do
					if copy[i][k].server ~= test[i]then table.remove(copy[i], k)end
				end
			end
			gold_table = {}
			for i = 1, #test do
				for _, value in pairs(copy[i])do table.insert(gold_table, value)end
			end
		elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers")then
			local copy, p = {}, ""
			for i = 1, #realmNames do copy[i] = deepcopy(gold_table)
				MySort(copy[i], sort_by)
				for k = #copy[i], 1, -1 do
					p = copy[i][k].server
					if p ~= realmNames[i]then table.remove(copy[i], k)end
				end
			end
			gold_table = {}
			for i = 1, #realmNames do
				for _, value in ipairs(copy[i])do table.insert(gold_table, value)end
			end
		end
	else
		if TitanGetVar(TITAN_GOLD_ID, "AllServers")or TitanGetVar(TITAN_GOLD_ID, "MergeServers")then
			local copy = {}
			copy = deepcopy(gold_table)
			MySort(copy, sort_by)
			gold_table = {}
			for _, value in ipairs(copy)do table.insert(gold_table, value)end
		elseif TitanGetVar(TITAN_GOLD_ID, "SeparateServers")then
			MySort(gold_table, sort_by)
		else end
	end
	return gold_table;
end

---local Generate formatted tooltip text: @return string
local function GetTooltipText()
	local GoldSorted = {}
	local currentMoneyRichText = ""
	local countelements = 0;			--(unused outside the next "for"-loop)
	local faction = GoldInfo.factionName;
	local ignore_faction = TitanGetVar(TITAN_GOLD_ID, "IgnoreFaction")
	for _ in pairs(realmNames)do countelements = countelements + 1;end
	-- insert all keys from hash into the GoldSorted array
	if TitanGetVar(TITAN_GOLD_ID, "SeparateServers")then
		-- Parse the database and display characters from this server
		Titan_Debug.Out('gold', 'tool_tip', "=== SeparateServers")
		for index, money in TitanUtils_PlayerIter()do local char = EvalIndexInfo(index)
			if char.valid then
				if char.same_realm and char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, char)
				end
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers")then
		-- Parse the database and display characters from merged / connected servers
		Titan_Debug.Out('gold', 'tool_tip', "=== MergeServers")
		for index, money in TitanUtils_PlayerIter()do local char = EvalIndexInfo(index)
			if char.valid then
				if char.merge_realm and char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, char)
				end
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers")then
		-- Parse the database and display characters from all servers
		Titan_Debug.Out('gold', 'tool_tip', "=== AllServers")
		for index, money in TitanUtils_PlayerIter()do local char = EvalIndexInfo(index)
			if char.valid then
				if char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, char)
				end
			end
		end
	end
	local by_realm = TitanGetVar(TITAN_GOLD_ID, "GroupByRealm")
	if #GoldSorted > 1 then GoldSorted = SortByIndex(GoldSorted)end					-- sorting only neccessary, when more than one toon exists for the choosed option.
	-- Array holds all characters to display, nicely sorted.
	currentMoneyRichText = ""
	local coin_str = ""
	local faction_text = ""
	local curr_realm = ""
	local show_dash = false;
	local show_realm = true;
	local character, charserver, char_faction;
	for i = 1, #GoldSorted do
		local toon = GoldSorted[i]
		character = toon.char_name;
		charserver = toon.server;
		char_faction = toon.faction;
		local t_gold = toon.gold;
		coin_str = NiceCash(t_gold, false, false)
		show_dash = false;
		show_realm = true;
		if(TitanGetVar(TITAN_GOLD_ID, "SeparateServers"))then show_realm = false;
		elseif(TitanGetVar(TITAN_GOLD_ID, "MergeServers"))or(TitanGetVar(TITAN_GOLD_ID, "AllServers"))then show_dash = true;end
		if by_realm then
			-- Set a realm header
			if charserver ~= curr_realm then
				currentMoneyRichText = currentMoneyRichText.."\n-- "..charserver;
				curr_realm = charserver;
			end
			show_dash = false;
			show_realm = false;
		end
		if ignore_faction then
			if char_faction == TITAN_ALLIANCE then faction_text = " |TInterface/AddOns/TitanGold/Artwork/UI_AllianceIcon-round:"..TitanPanelGetVar("FontSize")..":"..TitanPanelGetVar("FontSize")..":2:0|t"
			elseif char_faction == TITAN_HORDE then faction_text = " |TInterface/AddOns/TitanGold/Artwork/UI_HordeIcon-round:"..TitanPanelGetVar("FontSize")..":"..TitanPanelGetVar("FontSize")..":2:0|t" end
		end
		currentMoneyRichText = currentMoneyRichText.."\n"..character..(show_dash and "-" or "")..(show_realm and charserver or "")..faction_text.."\t"..coin_str;
	end
	--- I think, it's neccessary to warning the player for choosing an option, who doesn't existing or the choice is not logical
	if #TitanUtils_GetMergedRealms() == 0 and TitanGetVar(TITAN_GOLD_ID, "MergeServers")then currentMoneyRichText = currentMoneyRichText.."\nSorry, but you don't playing on a merged realm.\nPlease choose another option." end
	-- === Add Warband Bank
	if Warband.Use()then
		local cash = NiceCash(Warband.GetSum(), false, false)
		local war_name = Warband.GetName() -- localized
		currentMoneyRichText = currentMoneyRichText.."\n------\t+\n"..war_name.."\t"..cash;
		local msg = war_name.." "..cash;
		Titan_Debug.Out('gold', 'tool_tip', msg)
	end
	-- === Add Total per user options
	-- Display total gold
	coin_str = NiceCash(TotalGold(), false, false)
	currentMoneyRichText = currentMoneyRichText.."\n-------------------------\t----------------------\n"..L["TITAN_GOLD_TTL_GOLD"]..":\t"..coin_str;
	-- find session earnings and earning per hour
	local sesstotal = Get_Money() - GOLD_STARTINGGOLD;
	local negative = false;
	if(sesstotal < 0)then
		sesstotal = math.abs(sesstotal)
		negative = true;
	end
	local sesslength = GetTime() - GOLD_SESSIONSTART;
	local perhour = math.floor(sesstotal / sesslength * 3600)
	coin_str = NiceCash(GOLD_STARTINGGOLD, false, false)
	local session_status;
	local per_hour_status;
	local sessionMoneyRichText = ""
	if TitanGetVar(TITAN_GOLD_ID, "ShowSessionInfo")then
		sessionMoneyRichText = "\n\n"..TitanUtils_GetHighlightText(L["TITAN_GOLD_STATS_TITLE"]).."\n"..L["TITAN_GOLD_START_GOLD"].."\t"..coin_str.."\n"
		if(negative)then
			session_status = TitanUtils_GetRedText(L["TITAN_GOLD_SESS_LOST"])
			per_hour_status = TitanUtils_GetRedText(L["TITAN_GOLD_PERHOUR_LOST"])
		else
			session_status = TitanUtils_GetGreenText(L["TITAN_GOLD_SESS_EARNED"])
			per_hour_status = TitanUtils_GetGreenText(L["TITAN_GOLD_PERHOUR_EARNED"])
		end
		coin_str = NiceCash(sesstotal, true, true)
		sessionMoneyRichText = sessionMoneyRichText..session_status.."\t"..coin_str.."\n"
		if TitanGetVar(TITAN_GOLD_ID, "DisplayGoldPerHour")then
			coin_str = NiceCash(perhour, true, true)
			sessionMoneyRichText = sessionMoneyRichText..per_hour_status.."\t"..coin_str.."\n"
		end
	else
		-- Do not display session info
	end
	-- === Add Gold notes and info
	local final_tooltip = TitanUtils_GetGoldText(L["TITAN_GOLD_TOOLTIPTEXT"]..": ")
	local final_server = ""
	if realmNames == nil or TitanGetVar(TITAN_GOLD_ID, "SeparateServers")then final_server = realmName;
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers")then final_server = L["TITAN_GOLD_MERGED"]
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers")then final_server = ALL;end
	final_server = TitanUtils_GetGoldText(final_server.." ")
	local final_faction = ""
	if ignore_faction then final_faction = TitanUtils_GetGoldText(ALL)
	elseif faction == TITAN_ALLIANCE then final_faction = final_server.."("..TitanUtils_GetHexText(FACTION_ALLIANCE, Titan_Global.colors.alliance)..")"
	elseif faction == TITAN_HORDE then final_faction = final_server.."("..TitanUtils_GetHexText(FACTION_HORDE, Titan_Global.colors.horde)..")" end
	return "\n"..final_tooltip.."\t"..final_faction.."\n-------------------------\t----------------------"..currentMoneyRichText.."\n"..sessionMoneyRichText;--- this is the output what I prefer
end
--]===]

--[===[
---Take a table of toons to sort per user settings
---@param gold_table table
---@return table sorted May not be need but it is explicit
local function SortByIndex(gold_table)
--	local by_realm = TitanGetVar(TITAN_GOLD_ID, "GroupByRealm")
	local sort_by = TitanGetVar(TITAN_GOLD_ID, "SortByName")
	-- This section will sort the array based on user preference
	-- * by name or by gold amount descending
	-- * grouping by realm if selected
	if sort_by == "NameAsc" then
		table.sort(gold_table, function(key1, key2)
			return key1.char_name < key2.char_name
		end)
--[[ 
	-- 2026 Feb : Removed as a sort
	--  it does not make sense with by_name and by_gold being on a T/F option
	elseif by_realm then
		table.sort(gold_table, function(key1, key2)
			if gold_table[key1].realm ~= gold_table[key2].realm then
				return gold_table[key1].realm < gold_table[key2].realm
			end
			return false
		end)
--]]
	elseif sort_by == "GoldAsc" then -- by gold ascending
		table.sort(gold_table, function(key1, key2)
			return key1.gold < key2.gold
		end)
	elseif sort_by == "GoldDec" then -- by gold descending
		table.sort(gold_table, function(key1, key2)
			return key1.gold > key2.gold
		end)
	else
		-- should not get here
	end

	return gold_table
end

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
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.same_realm and char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, char);
				end
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers") then
		-- Parse the database and display characters from merged / connected servers
		Titan_Debug.Out('gold', 'tool_tip', "=== MergeServers")
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.merge_realm and char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, char);
				end
			end
		end
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers") then
		-- Parse the database and display characters from all servers
		Titan_Debug.Out('gold', 'tool_tip', "=== AllServers")
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				if char.show_toon then
					Titan_Debug.Out('gold', 'tool_tip', index.." "..NiceCash(char.gold, false, false))
					table.insert(GoldSorted, char);
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
		character = toon.char_name
		charserver = toon.server
		char_faction = toon.faction

		local t_gold = toon.gold
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
				currentMoneyRichText = currentMoneyRichText.."\n"
					.."-- "..charserver
				curr_realm = charserver
			end
			show_dash = false
			show_realm = false
		end

		if ignore_faction then
			local font_size = TitanPanelGetVar("FontSize")
			local icon_pre = "|TInterface/AddOns/TitanGold/Artwork/"
			local icon_post = ":"..font_size..":"..font_size..":2:0|t"
			local a_icon = icon_pre.."UI_AllianceIcon-round"..icon_post
			local h_icon = icon_pre.."UI_HordeIcon-round"..icon_post
			if char_faction == TITAN_ALLIANCE then
				faction_text = " "..a_icon
			elseif char_faction == TITAN_HORDE then
				faction_text = " "..h_icon
			end
		end

		currentMoneyRichText = currentMoneyRichText.."\n"
			..character
			..(show_dash and "-" or "")
			..(show_realm and charserver or "")
			..faction_text
			.."\t"..coin_str
	end

	--
	-- === Add Warband Bank
	--
	if Warband.Use() then
		local cash = NiceCash(Warband.GetSum(), false, false)
		local war_name = ""..Warband.GetName() -- localized
		currentMoneyRichText = currentMoneyRichText.."\n"
			.."------ \t +".."\n"
			..war_name
			.."\t"..cash
		local msg = ""..war_name.." "..cash
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
	currentMoneyRichText = currentMoneyRichText.."\n"
		..TITAN_GOLD_SPACERBAR.."\n"
		..L["TITAN_GOLD_TTL_GOLD"].."\t"..coin_str

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
		sessionMoneyRichText = "\n\n"..TitanUtils_GetHighlightText(L["TITAN_GOLD_STATS_TITLE"])
			.."\n"..L["TITAN_GOLD_START_GOLD"].."\t"..coin_str.."\n"

		if (negative) then
			session_status = TitanUtils_GetRedText(L["TITAN_GOLD_SESS_LOST"])
			per_hour_status = TitanUtils_GetRedText(L["TITAN_GOLD_PERHOUR_LOST"])
		else
			session_status = TitanUtils_GetGreenText(L["TITAN_GOLD_SESS_EARNED"])
			per_hour_status = TitanUtils_GetGreenText(L["TITAN_GOLD_PERHOUR_EARNED"])
		end

		coin_str = NiceCash(sesstotal, true, true)
		sessionMoneyRichText = sessionMoneyRichText
			..session_status
			.."\t"..coin_str.."\n";

		if TitanGetVar(TITAN_GOLD_ID, "DisplayGoldPerHour") then
			coin_str = NiceCash(perhour, true, true)
			sessionMoneyRichText = sessionMoneyRichText
				..per_hour_status
				.."\t"..coin_str.."\n";
		end
	else
		-- Do not display session info
	end

	--
	-- === Add Gold notes and info
	--
	local final_tooltip = TitanUtils_GetGoldText(L["TITAN_GOLD_TOOLTIPTEXT"].." : ")

	local final_server = ""
	if realmNames == nil or TitanGetVar(TITAN_GOLD_ID, "SeparateServers") then
		final_server = realmName
	elseif TitanGetVar(TITAN_GOLD_ID, "MergeServers") then
		final_server = L["TITAN_GOLD_MERGED"]
	elseif TitanGetVar(TITAN_GOLD_ID, "AllServers") then
		final_server = ALL
	end
	final_server = TitanUtils_GetGoldText(final_server.." : ")

	local final_faction = ""
	if ignore_faction then
		final_faction = TitanUtils_GetGoldText(ALL)
	elseif faction == TITAN_ALLIANCE then
		final_faction = TitanUtils_GetHexText(FACTION_ALLIANCE, Titan_Global.colors.alliance)
	elseif faction == TITAN_HORDE then
		final_faction = TitanUtils_GetHexText(FACTION_HORDE, Titan_Global.colors.horde)
	end

	return ""
		..currentMoneyRichText.."\n"
		..TITAN_GOLD_SPACERBAR.."\n"
		..final_tooltip..final_server..final_faction.."\n"
		..sessionMoneyRichText
end
-- ======
--]===]

-- ====== Right click menu routines

local function ResetSession()
	GOLD_STARTINGGOLD = Get_Money();
	GOLD_SESSIONSTART = GetTime();
	DEFAULT_CHAT_FRAME:AddMessage(TitanUtils_GetGreenText(L["TITAN_GOLD_SESSION_RESET"]));
end

---local See if this toon is in saved vars AFTER PEW event.
--- Get current total and session start time. Toon gold is available via API AFTER PEW event.
local function Initialize_Array(action)
	Titan_Debug.Out('gold', 'flow', "Init inititated")

	local info = ""
	if (GOLD_INITIALIZED) then
		-- already done
	else
		-- 2026 Jan : Saved vars are now in Titan

		-- See if this is a new toon to Gold saved vars or reset
		local gindex, _, _ = TitanUtils_GetPlayer()
		local result = ""
		result, GoldInfo = TitanUtils_GetProfileInfo(gindex, "Info", false)

		-- Ensure the saved vars are what we need for valid toons
		for index, money in TitanUtils_PlayerIter() do
			local char = EvalIndexInfo(index)
			if char.valid then
				local toon_gold ---@class GoldData
				result, toon_gold = TitanUtils_GetProfileInfo(index, "Gold", false)
				if result == "found" then
					if toon_gold == nil then
						-- not sure !?
					else
						-- Added 2026 Feb
						if toon_gold.show == nil then
							toon_gold.show = true -- default
						else
							-- exists, use as is
						end

						if action == "reset" then
							toon_gold.gold = 0
						else
							-- use as is
						end
					end
				else
					-- ignore
				end
			else
				-- ignore custom profiles or toons not logged into yet
			end
		end

		result, GoldData = TitanUtils_GetProfileInfo(gindex, "Gold", true)
		GoldData.gold = Get_Money()

		Warband.Init()

		GOLD_STARTINGGOLD = Get_Money();
		GOLD_SESSIONSTART = GetTime();
		GOLD_INITIALIZED = true;

		info = ""
			.." "..tostring(GOLD_SESSIONSTART)..""
			.." "..tostring(GOLD_STARTINGGOLD)..""
			.." "..tostring(Warband.GetSum())..""
	end

	-- 2026 Mar : Repurposed to add sort gold decsending
	-- Translate the user setting as user logs into toons or profile changes
	local sort_by = TitanGetVar(TITAN_GOLD_ID, "SortByName")
	if sort_by == true then
		TitanSetVar(TITAN_GOLD_ID, "SortByName", "NameAsc")
	elseif sort_by == false or sort_by == nil then
		TitanSetVar(TITAN_GOLD_ID, "SortByName", "GoldAsc")
	else
		-- already set
	end

	local msg = ">Init done : "
		.." "..tostring(GOLD_INITIALIZED)..""
		.." "..info..""
	Titan_Debug.Out('gold', 'flow', msg)
end
---local Clear the gold array and rebuild
---@param self Button
local function ClearData(self)
	GOLD_INITIALIZED = false;

	Initialize_Array("reset");

	TitanPanelButton_UpdateButton(TITAN_GOLD_ID)

	DEFAULT_CHAT_FRAME:AddMessage(TitanUtils_GetGreenText(L["TITAN_GOLD_DB_CLEARED"]));
end

---local Pops an 'are you sure' when user clicks to reset the gold array
local function TitanGold_ClearDB()
	StaticPopupDialogs["TITANGOLD_CLEAR_DATABASE"] = {
		text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"].." "
			..L["TITAN_GOLD_MENU_TEXT"]).."\n\n"..L["TITAN_GOLD_CLEAR_DATA_WARNING"],
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

---local Create Show menu - list of characters in same faction
---@param faction string
---@param level table Menu description to attach to
local function ShowMenuButtons(faction, level)
	-- create the list and sort by alpha with server
	local list_alpha = {}
	for index, money in TitanUtils_PlayerIter() do
		local char = EvalIndexInfo(index)
		if char.valid and char.faction == faction then
			table.insert(list_alpha, index);
		else
			-- ignore custom profiles or toons not logged into yet
		end
	end
	table.sort(list_alpha, function(key1, key2)
--		return key1.char_name < key2.char_name
		return key1 < key2
	end)

	for i = 1, #list_alpha do
		local toon = list_alpha[i]
		--character = toon.char_name
		--charserver = toon.server
		--char_faction = toon.faction

		Titan_Menu.AddSelectorGeneric(level, toon,
			function(data)
				local res = false
				local result = ""
				local toon_gold ---@class GoldData
				result, toon_gold = TitanUtils_GetProfileInfo(data.c_name, "Gold", false)
				if result == "found" and toon_gold ~= nil then
					res = toon_gold.show
				else
					-- !? something bad happened...
				end
				return res
			end,
			function(data)
				local result = ""
				local toon_gold ---@class GoldData
				result, toon_gold = TitanUtils_GetProfileInfo(data.c_name, "Gold", false)
				if result == "found" and toon_gold ~= nil then
					toon_gold.show = not toon_gold.show
				else
					-- !? do nothing
				end
				TitanPanelButton_UpdateButton(TITAN_GOLD_ID);
			end,
			{c_name = toon}
		)
	end
end

local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_GOLD_ID
	local root = rootDescription -- menu widget to start with

	local opts_sort = Titan_Menu.AddButton(root, L["TITAN_GOLD_SORT_BY"])
	do           -- next level options
		-- NameAsc | GoldAsc | GoldDec [Ascend, Descend]
		local disp = {-- selectors using the same option - label, value
			{"Sort by Name", "NameAsc"},
			{"Sort by Gold Ascending", "GoldAsc"},
			{"Sort by Gold Descending", "GoldDec"},
		}
		Titan_Menu.AddSelectorList(opts_sort, id, nil, "SortByName", disp)

		Titan_Menu.AddDivider(opts_sort)

		Titan_Menu.AddSelector(opts_sort, id, L["TITAN_GOLD_GROUP_BY_REALM"], "GroupByRealm")
	end

	local opts_gold = Titan_Menu.AddButton(root, L["TITAN_GOLD_TOOLTIP_DISPLAY_OPTIONS"])
	do           -- next level options
		local list = {-- a mututally exclusive triple
			{L["TITAN_GOLD_SEPARATE"], "SeparateServers"},
			{L["TITAN_GOLD_MERGE"],    "MergeServers"},
			{L["TITAN_GOLD_ALL"],      "AllServers"},
		}
		Titan_Menu.AddSelectorExclusiveList(opts_gold, id, L["TITAN_GOLD_SORT_BY"], list)
		Titan_Menu.AddSelector(opts_gold, id, L["TITAN_GOLD_IGNORE_FACTION"], "IgnoreFaction")

		local coins = {-- a mututally exclusive triple
			{L["TITAN_GOLD_COIN_NONE"],   "ShowCoinNone"},
			{L["TITAN_GOLD_COIN_LABELS"], "ShowCoinLabels"},
			{L["TITAN_GOLD_COIN_ICONS"],  "ShowCoinIcons"},
		}
		Titan_Menu.AddSelectorExclusiveList(opts_gold, id, "Coin Labels", coins)

		local seps = {-- a mututally exclusive triple
			{L["TITAN_PANEL_USE_COMMA"],  "UseSeperatorComma"},
			{L["TITAN_PANEL_USE_PERIOD"], "UseSeperatorPeriod"},
			{"Use Space",                 "UseSeperatorSpace"},
		}
		Titan_Menu.AddSelectorExclusiveList(opts_gold, id, "Seperator", seps)

		Titan_Menu.AddDivider(opts_gold)

		Titan_Menu.AddSelector(opts_gold, id, L["TITAN_GOLD_SHOW_STATS_TITLE"], "ShowSessionInfo")

		Titan_Menu.AddDivider(opts_gold)

		Titan_Menu.AddSelector(opts_gold, id, L["TITAN_GOLD_TOGGLE_GPH_SHOW"], "DisplayGoldPerHour")
	end

	Titan_Menu.AddSelector(root, id, L["TITAN_GOLD_ONLY"], "ShowGoldOnly")

	local disp = {-- selectors using the same option
		{L["TITAN_GOLD_TOGGLE_ALL_TEXT"],    true},
		{L["TITAN_GOLD_TOGGLE_PLAYER_TEXT"], false},
	}
	Titan_Menu.AddSelectorList(root, id, nil, "ViewAll", disp)

	if Warband.active then
		Titan_Menu.AddSelector(root, id, L["TITAN_GOLD_INCLUDE_WARBANK"], "ShowWarband")
	else
		-- Warbank not in this expansion
	end
	Titan_Menu.AddDivider(root)

	local opts_show = Titan_Menu.AddButton(root, L["TITAN_GOLD_SHOW_PLAYER"])
	do
	local opts_alliance = Titan_Menu.AddButton(opts_show, L["TITAN_GOLD_FACTION_PLAYER_ALLY"])
		ShowMenuButtons(TITAN_ALLIANCE, opts_alliance)
	end
	do
	local opts_horde = Titan_Menu.AddButton(opts_show, L["TITAN_GOLD_FACTION_PLAYER_HORDE"])
		ShowMenuButtons(TITAN_HORDE, opts_horde)
	end

	Titan_Menu.AddCommand(root, id, L["TITAN_GOLD_CLEAR_DATA_TEXT"], TitanGold_ClearDB)
	Titan_Menu.AddCommand(root, id, L["TITAN_GOLD_RESET_SESS_TEXT"], ResetSession)
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

	return L["TITAN_GOLD_MENU_TEXT"]..": "..FONT_COLOR_CODE_CLOSE, ret_str
end

---local Build the plugin .registry and init and register for events
---@param self Button
local function OnLoad(self)
	local notes = ""
		.."Keeps track of all gold held by a player's toons.\n"
		.."- Can show by server / merged servers / all servers.\n"
		.."- Can show by faction.\n"
		.."Shift + Left click will print list of connected servers to chat.\n"
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
			SortByName = "NameAsc", -- NameAsc | GoldAsc | GoldDec [Ascend, Descend]
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
			gold = {total = "112233", neg = false},
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
	Initialize_Array("set")
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
		.." "..Gold_debug("OnShow")
	Titan_Debug.Out('gold', 'flow', msg)
end

---local When hidden, unregister needed events and stop timer for gold per hour
---@param self Button
local function OnHide(self)
	self:UnregisterEvent("PLAYER_MONEY");
	AceTimer:CancelTimer(GoldTimer)
	GoldTimerRunning = false
end

---local Handle registered events for this plugin
---@param self Button
---@param event string
---@param ...any
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
			return; -- no debug, if enabled
		end
	end
	Titan_Debug.Out('gold', 'events', event)
end

---Button clicks - only shift-left for now
---@param self Button
---@param button string
local function OnClick(self, button)
	if button == "LeftButton" and IsShiftKeyDown()then
		local realms = GetConnectedRealms()
		local mark = ""
		TitanPrint(L["TITAN_LOCATION_CONNECTED_REALMS"], "plain")
		for idx = 1, #realms do
			if realms[idx] == string.gsub(realmName, "%s", "")then mark = " * " else mark = "" end
			TitanPrint("- "..tostring(realms[idx])..mark, "plain")
		end
	end
end

---Get gold for given player or why it is not
---@param player string Titan format - name with server
---@param add_label boolean
---@return string
function TitanGold.GetInfo(player, add_label)
	local res, label = "", ""
	if add_label then label = L["TITAN_GOLD_MENU_TEXT"]..": " else label = "" end
	local result = ""
	local toon_gold ---@class GoldData
	result, toon_gold = TitanUtils_GetProfileInfo(player, "Gold", false)
	local character, charserver, is_custom = TitanUtils_ParseName(player)
	if result == "is_custom" then res = L["TITAN_PANEL_NA"].." - Custom profile."
	elseif _G[TITAN_BUTTON]:IsShown()then
		if result == "found" then
			if toon_gold == nil then res = L["TITAN_PANEL_NA"].." - Data empty!?."
			else res = NiceCash(toon_gold.gold, true, false)end
		else res = L["TITAN_PANEL_NA"].." - Not logged in yet with Gold enabled." end
	else res = L["TITAN_PANEL_MENU_DISABLED"]end
	return label..res;
end

---local Create required Gold frames
local function Create_Frames()
	if _G[TITAN_BUTTON]then return; -- if already created
	end
	-- general container frame
	local f = CreateFrame("Frame", nil, UIParent)
	--	f:Hide()
	-- Titan plugin button
	local window = CreateFrame("Button", TITAN_BUTTON, f, "TitanPanelComboTemplate")
	window:SetFrameStrata("FULLSCREEN")
	-- Using SetScript("OnLoad",   does not work
	OnLoad(window)
	--	TitanPanelButton_OnLoad(window); -- Titan XML template calls this...
	window:SetScript("OnShow", function(self)OnShow(self)TitanPanelButton_OnShow(self)end)
	window:SetScript("OnHide", function(self)OnHide(self)end)
	window:SetScript("OnEvent", function(self, event, ...)OnEvent(self, event, ...)end)
	window:SetScript("OnClick", function(self, button)OnClick(self, button)TitanPanelButton_OnClick(self, button)end)
end

Create_Frames() -- do the work