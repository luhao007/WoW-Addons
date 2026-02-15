---@diagnostic disable: duplicate-set-field
-- **************************************************************************
-- * TitanPerformance.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************

-- ******************************** Constants *******************************
local TITAN_PERFORMANCE_ID = "Performance";
local TITAN_BUTTON = "TitanPanel" .. TITAN_PERFORMANCE_ID .. "Button"

local TITAN_PERF_FRAME_SHOW_TIME = 0.5;
local updateTable = { TITAN_PERFORMANCE_ID, TITAN_PANEL_UPDATE_ALL };

local APP_MIN = 1
local APP_MAX = 40

---@diagnostic disable-next-line: deprecated, undefined-global
local NumAddons = C_AddOns.GetNumAddOns or GetNumAddOns
---@diagnostic disable-next-line: deprecated, undefined-global
local AddOnInfo = C_AddOns.GetAddOnInfo or GetAddOnInfo
---@diagnostic disable-next-line: deprecated, undefined-global
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded or IsAddOnLoaded

local TITAN_FPS_THRESHOLD_TABLE = {
	Values = { 20, 30 },
	Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
}

-- #1369 - PERFORMANCEBAR_LOW_LATENCY, PERFORMANCEBAR_MEDIUM_LATENCY no longer defined by WoW
local TITAN_LATENCY_THRESHOLD_TABLE = {
	Values = { 300, 600 },
	Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}

local TITAN_MEMORY_RATE_THRESHOLD_TABLE = {
	Values = { 1, 2 },
	Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}

-- ******************************** Variables *******************************
local _G = getfenv(0);
local topAddOns;
local memUsageSinceGC = {};
local counter = 1; --counter for active addons
local AceTimer = LibStub("AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
local PerfTimer = {}
local PerfTimerRunning = false

local perf_stats = {}
-- ******************************** Functions *******************************

---Add another line to the passed in string; handle two columns if right is given
---@param line string
---@param left string
---@param right? string
---@return string
local function Add_line(line, left, right)
	local new_line = ""
	if right then
		new_line = left.."\t"..right.."\n"
	else
		new_line = left.."\n"
	end

	return line..new_line
end

local function Update_Addons(self, watchingCPU, tip_str)
	if (watchingCPU) then
		UpdateAddOnCPUUsage()
	else
		UpdateAddOnMemoryUsage()
	end

	local total = 0
	local showAddonRate = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowAddonIncRate");
	for i = 1, NumAddons() do
		local value = (watchingCPU and GetAddOnCPUUsage(i)) or GetAddOnMemoryUsage(i)
		total = total + value

		for j, addon in ipairs(topAddOns) do
			if (value > addon.value) then
				for k = counter, 1, -1 do
					if (k == j) then
						topAddOns[k].value = value
						topAddOns[k].name = AddOnInfo(i)
						break
					elseif (k ~= 1) then
						topAddOns[k].value = topAddOns[k - 1].value
						topAddOns[k].name = topAddOns[k - 1].name
					end
				end
				break
			end
		end
	end

	tip_str = Add_line(tip_str, "")

	if (total > 0) then
		if (watchingCPU) then
			tip_str = Add_line(tip_str, TitanUtils_GetHexText(L["TITAN_PERFORMANCE_ADDON_CPU_USAGE_LABEL"],
				Titan_Global.colors.white))
		else
			tip_str = Add_line(tip_str,  TitanUtils_GetHexText(L["TITAN_PERFORMANCE_ADDON_MEM_USAGE_LABEL"],
				Titan_Global.colors.white))
		end

		if not watchingCPU then
			if (showAddonRate == 1) then
				tip_str = Add_line(tip_str, LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_NAME_LABEL"],
					LIGHTYELLOW_FONT_COLOR_CODE ..
					L["TITAN_PERFORMANCE_ADDON_USAGE_LABEL"] ..
					"/" .. L["TITAN_PERFORMANCE_ADDON_RATE_LABEL"] .. ":")
			else
				tip_str = Add_line(tip_str, LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_NAME_LABEL"],
					LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_USAGE_LABEL"] .. ":")
			end
		end

		if watchingCPU then
			tip_str = Add_line(tip_str, LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_NAME_LABEL"],
				LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_USAGE_LABEL"] .. ":")
		end

		for _, addon in ipairs(topAddOns) do
			local wow_addon = TitanUtils_GetHexText(addon.name, Titan_Global.colors.yellow)
			if (watchingCPU) then
				local diff = addon.value / total * 100;
				local incrate = "";
				incrate = format("(%.2f%%)", diff);
				if (showAddonRate == 1) then
					local str = TitanUtils_GetHexText(format("%.3f", addon.value)
							.. L["TITAN_PANEL_MILLISECOND"], Titan_Global.colors.white)
						.. " "
						.. TitanUtils_GetHexText(incrate, Titan_Global.colors.green)
					tip_str = Add_line(tip_str, wow_addon,str)
				else
					local str = TitanUtils_GetHexText(format("%.3f", addon.value)
						.. L["TITAN_PANEL_MILLISECOND"], Titan_Global.colors.white)
					tip_str = Add_line(tip_str, wow_addon,str)
				end
			else
				local diff = addon.value - (memUsageSinceGC[addon.name])
				if diff < 0 or memUsageSinceGC[addon.name] == 0 then
					memUsageSinceGC[addon.name] = addon.value;
				end
				local incrate = "";
				if diff > 0 then
					incrate = format("(+%.2f) " .. L["TITAN_PANEL_PERFORMANCE_KILOBYTES_PER_SECOND"], diff);
				end
				local fmt = ""
				local div = 1
				local rate = ""
				if (showAddonRate == 1) then
					if TitanGetVar(TITAN_PERFORMANCE_ID, "AddonMemoryType") == 1 then
						fmt = L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"]
						div = 1000
						rate = TitanUtils_GetHexText(incrate, Titan_Global.colors.green)
					else
						if addon.value > 1000 then
							fmt = L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"]
							div = 1000
							rate = TitanUtils_GetHexText(incrate, Titan_Global.colors.green)
						else
							fmt = L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT_KB"]
							rate = TitanUtils_GetHexText(incrate, Titan_Global.colors.green)
						end
					end
				else
					if TitanGetVar(TITAN_PERFORMANCE_ID, "AddonMemoryType") == 1 then
						fmt = L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"]
						div = 1000
					else
						if addon.value > 1000 then
							fmt = L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"]
							div = 1000
						else
							fmt = L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT_KB"]
						end
					end
				end
				tip_str = Add_line(tip_str, wow_addon,
					TitanUtils_GetHexText(format(fmt, addon.value / div), Titan_Global.colors.white) .. rate )
			end
		end

		tip_str = tip_str .. "\n"

		if (watchingCPU) then
			tip_str = Add_line(tip_str, LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_TOTAL_CPU_USAGE_LABEL"],
				format("%.3f", total) .. L["TITAN_PANEL_MILLISECOND"] )
		else
			if TitanGetVar(TITAN_PERFORMANCE_ID, "AddonMemoryType") == 1 then
				tip_str = Add_line(tip_str, 
					LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL"],
					format(L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"], total / 1000))
			else
				if total > 1000 then
					tip_str = Add_line(tip_str, 
						LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL"],
						format(L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"], total / 1000))
				else
					tip_str = Add_line(tip_str, 
						LIGHTYELLOW_FONT_COLOR_CODE .. L["TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL"],
						format(L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT_KB"], total) )
				end
			end
		end
	end

	return tip_str
end

local function GetTooltipText()
	local showFPS = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowFPS");
	local showLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowLatency");
	local showWorldLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowWorldLatency")
	local showMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowMemory");
	local showAddonMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowAddonMemory");

	local tool_tip = ""
	-- FPS tooltip
	if (showFPS) then
		local fpsText = format(L["TITAN_PANEL_PERFORMANCE_FPS_FORMAT"], perf_stats.fps);
		local avgFPSText = format(L["TITAN_PANEL_PERFORMANCE_FPS_FORMAT"], perf_stats.avgFPS);
		local minFPSText = format(L["TITAN_PANEL_PERFORMANCE_FPS_FORMAT"], perf_stats.minFPS);
		local maxFPSText = format(L["TITAN_PANEL_PERFORMANCE_FPS_FORMAT"], perf_stats.maxFPS);

		tool_tip = Add_line(tool_tip, "")
		tool_tip = Add_line(tool_tip, TitanUtils_GetHighlightText(L["TITAN_PANEL_PERFORMANCE_FPS_TOOLTIP"]))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_FPS_TOOLTIP_CURRENT_FPS"],
			TitanUtils_GetHighlightText(fpsText))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_FPS_TOOLTIP_AVG_FPS"],
			TitanUtils_GetHighlightText(avgFPSText))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_FPS_TOOLTIP_MIN_FPS"],
			TitanUtils_GetHighlightText(minFPSText))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_FPS_TOOLTIP_MAX_FPS"],
			TitanUtils_GetHighlightText(maxFPSText))
	end

	-- Latency tooltip
	if (showLatency or showWorldLatency) then
		local latencyText = format(L["TITAN_PANEL_PERFORMANCE_LATENCY_FORMAT"], perf_stats.latencyHome);
		local latencyWorldText = format(L["TITAN_PANEL_PERFORMANCE_LATENCY_FORMAT"], perf_stats.latencyWorld);
		local bandwidthInText = format(L["TITAN_PANEL_PERFORMANCE_LATENCY_BANDWIDTH_FORMAT"], perf_stats.bandwidthIn);
		local bandwidthOutText = format(L["TITAN_PANEL_PERFORMANCE_LATENCY_BANDWIDTH_FORMAT"], perf_stats.bandwidthOut);

		tool_tip = Add_line(tool_tip, "")
		tool_tip = Add_line(tool_tip, TitanUtils_GetHighlightText(L["TITAN_PANEL_PERFORMANCE_LATENCY_TOOLTIP"]))
		if showLatency then
			tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_LATENCY_TOOLTIP_LATENCY_HOME"],
				TitanUtils_GetHighlightText(latencyText))
		end
		if showWorldLatency then
			tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_LATENCY_TOOLTIP_LATENCY_WORLD"],
				TitanUtils_GetHighlightText(latencyWorldText))
		end
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_LATENCY_TOOLTIP_BANDWIDTH_IN"],
			TitanUtils_GetHighlightText(bandwidthInText))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_LATENCY_TOOLTIP_BANDWIDTH_OUT"],
			TitanUtils_GetHighlightText(bandwidthOutText))
	end

	-- Memory tooltip
	if (showMemory) then
		local memoryText = format(L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"], perf_stats.memory / 1024);
		local initialMemoryText = format(L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"], perf_stats.initialMemory / 1024);
		local sessionTime = time() - perf_stats.startSessionTime;
		local rateRichText, rate, color
		if (sessionTime == 0) then
			rateRichText = TitanUtils_GetHighlightText("N/A");
		else
			rate = (perf_stats.memory - perf_stats.initialMemory) / sessionTime;
			color = TitanUtils_GetThresholdColor(TITAN_MEMORY_RATE_THRESHOLD_TABLE, rate)
			rateRichText = TitanUtils_GetColoredText(format(L["TITAN_PANEL_PERFORMANCE_MEMORY_RATE_FORMAT"], rate), color)
		end
		--if (perf_stats.memory == perf_stats.initialMemory) then
		--	timeToGCRichText = TitanUtils_GetHighlightText("N/A");
		--end

		tool_tip = Add_line(tool_tip, "")
		tool_tip = Add_line(tool_tip, TitanUtils_GetHighlightText(L["TITAN_PANEL_PERFORMANCE_MEMORY_TOOLTIP"]))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_MEMORY_TOOLTIP_CURRENT_MEMORY"],
			TitanUtils_GetHighlightText(memoryText))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_MEMORY_TOOLTIP_INITIAL_MEMORY"],
			TitanUtils_GetHighlightText(initialMemoryText))
		tool_tip = Add_line(tool_tip, L["TITAN_PANEL_PERFORMANCE_MEMORY_TOOLTIP_INCREASING_RATE"],
			rateRichText)
	end

	if (showAddonMemory == true or showAddonMemory == 1) then
		for _, i in pairs(topAddOns) do
			i.name = '';
			i.value = 0;
		end
		tool_tip = Update_Addons(_G[TITAN_BUTTON],
			GetCVar('scriptProfile') == '1' and not IsModifierKeyDown(),
			tool_tip)
	end

	tool_tip = Add_line(tool_tip, "")
	tool_tip = Add_line(tool_tip, TitanUtils_GetGreenText(L["TITAN_PERFORMANCE_TOOLTIP_HINT"]))

	return tool_tip
end

---local Update real-time data, placing it on the plugin frame
local function UpdateData()
	--	local button = _G["TitanPanelPerformanceButton"];
	local showFPS = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowFPS");
	local showLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowLatency");
	local showWorldLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowWorldLatency")
	local showMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowMemory");
	local showAddonMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowAddonMemory");

	-- FPS Data
	if (showFPS) then
		perf_stats.fps = GetFramerate();
		perf_stats.fpsSampleCount = perf_stats.fpsSampleCount + 1;
		if (perf_stats.fpsSampleCount == 1) then
			perf_stats.minFPS = perf_stats.fps;
			perf_stats.maxFPS = perf_stats.fps;
			perf_stats.avgFPS = perf_stats.fps;
		else
			if (perf_stats.fps < perf_stats.minFPS) then
				perf_stats.minFPS = perf_stats.fps;
			elseif (perf_stats.fps > perf_stats.maxFPS) then
				perf_stats.maxFPS = perf_stats.fps;
			end
			perf_stats.avgFPS = (perf_stats.avgFPS * (perf_stats.fpsSampleCount - 1) + perf_stats.fps) /
				perf_stats.fpsSampleCount;
		end
	end

	-- Latency Data
	if (showLatency or showWorldLatency) then
		-- bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
		perf_stats.bandwidthIn, perf_stats.bandwidthOut, perf_stats.latencyHome, perf_stats.latencyWorld = GetNetStats();
	end

	-- Memory data
	if (showMemory) or (showAddonMemory == 1) then
		local previousMemory = perf_stats.memory;
		perf_stats.memory, perf_stats.gcThreshold = gcinfo();
		if (not perf_stats.startSessionTime) then
			-- Initial data
			local i;
			perf_stats.startSessionTime = time();
			perf_stats.initialMemory = perf_stats.memory;

			for i = 1, NumAddons() do
				memUsageSinceGC[AddOnInfo(i)] = GetAddOnMemoryUsage(i)
			end
		elseif (previousMemory and perf_stats.memory and previousMemory > perf_stats.memory) then
			-- Reset data after garbage collection
			local k, i;
			perf_stats.startSessionTime = time();
			perf_stats.initialMemory = perf_stats.memory;

			for k in pairs(memUsageSinceGC) do
				memUsageSinceGC[k] = nil
			end

			for i = 1, NumAddons() do
				memUsageSinceGC[AddOnInfo(i)] = GetAddOnMemoryUsage(i)
			end
		end
	end
end

---local Generate button text using data on the plugin frame
---@param id string
---@return string label
---@return string plugin_text
---@return string | nil label2
---@return string | nil plugin_text2
---@return string | nil label3
---@return string | nil plugin_text3
local function GetButtonText(id)
	--	local button = _G["TitanPanelPerformanceButton"];
	local color, fpsRichText, latencyRichText, memoryRichText;
	local showFPS = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowFPS");
	local showLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowLatency");
	local showWorldLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowWorldLatency")
	local showMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowMemory");

	-- Update real time data
	UpdateData()

	-- FPS text
	if (showFPS) then
		local fpsText = format(L["TITAN_PANEL_PERFORMANCE_FPS_FORMAT"], perf_stats.fps);
		if (TitanGetVar(TITAN_PERFORMANCE_ID, "ShowColoredText")) then
			color = TitanUtils_GetThresholdColor(TITAN_FPS_THRESHOLD_TABLE, perf_stats.fps);
			fpsRichText = TitanUtils_GetColoredText(fpsText, color);
		else
			fpsRichText = TitanUtils_GetHighlightText(fpsText);
		end
	end

	-- Latency text
	latencyRichText = ""
	if (showLatency) then
		local latencyText = format(L["TITAN_PANEL_PERFORMANCE_LATENCY_FORMAT"], perf_stats.latencyHome);
		if (TitanGetVar(TITAN_PERFORMANCE_ID, "ShowColoredText")) then
			color = TitanUtils_GetThresholdColor(TITAN_LATENCY_THRESHOLD_TABLE, perf_stats.latencyHome);
			latencyRichText = TitanUtils_GetColoredText(latencyText, color);
		else
			latencyRichText = TitanUtils_GetHighlightText(latencyText)
		end
	end

	if (showWorldLatency) then
		local latencyWorldText = format(L["TITAN_PANEL_PERFORMANCE_LATENCY_FORMAT"], perf_stats.latencyWorld);
		if (showLatency) then
			latencyRichText = latencyRichText .. "/"
		end
		if (TitanGetVar(TITAN_PERFORMANCE_ID, "ShowColoredText")) then
			color = TitanUtils_GetThresholdColor(TITAN_LATENCY_THRESHOLD_TABLE, perf_stats.latencyWorld);
			latencyRichText = latencyRichText .. TitanUtils_GetColoredText(latencyWorldText, color);
		else
			latencyRichText = latencyRichText .. TitanUtils_GetHighlightText(latencyWorldText);
		end
	end

	-- Memory text
	if (showMemory) then
		local memoryText = format(L["TITAN_PANEL_PERFORMANCE_MEMORY_FORMAT"], perf_stats.memory / 1024);
		memoryRichText = TitanUtils_GetHighlightText(memoryText);
	end

	if (showFPS) then
		if (showLatency or showWorldLatency) then
			if (showMemory) then
				return L["TITAN_PANEL_PERFORMANCE_FPS_BUTTON_LABEL"], fpsRichText,
					L["TITAN_PANEL_PERFORMANCE_LATENCY_BUTTON_LABEL"], latencyRichText,
					L["TITAN_PANEL_PERFORMANCE_MEMORY_BUTTON_LABEL"], memoryRichText;
			else
				return L["TITAN_PANEL_PERFORMANCE_FPS_BUTTON_LABEL"], fpsRichText,
					L["TITAN_PANEL_PERFORMANCE_LATENCY_BUTTON_LABEL"], latencyRichText;
			end
		else
			if (showMemory) then
				return L["TITAN_PANEL_PERFORMANCE_FPS_BUTTON_LABEL"], fpsRichText,
					L["TITAN_PANEL_PERFORMANCE_MEMORY_BUTTON_LABEL"], memoryRichText;
			else
				return L["TITAN_PANEL_PERFORMANCE_FPS_BUTTON_LABEL"], fpsRichText;
			end
		end
	else
		if (showLatency or showWorldLatency) then
			if (showMemory) then
				return L["TITAN_PANEL_PERFORMANCE_LATENCY_BUTTON_LABEL"], latencyRichText,
					L["TITAN_PANEL_PERFORMANCE_MEMORY_BUTTON_LABEL"], memoryRichText;
			else
				return L["TITAN_PANEL_PERFORMANCE_LATENCY_BUTTON_LABEL"], latencyRichText;
			end
		else
			if (showMemory) then
				return L["TITAN_PANEL_PERFORMANCE_MEMORY_BUTTON_LABEL"], memoryRichText;
			else
				return "", ""
			end
		end
	end
end

local function Init()
	topAddOns = {}
	-- scan how many addons are active
	local count = NumAddons();
	local ActiveAddons = 0;
	local NumOfAddons = TitanGetVar(TITAN_PERFORMANCE_ID, "NumOfAddons");
	if NumOfAddons == nil then
		NumOfAddons = 5;
		TitanSetVar(TITAN_PERFORMANCE_ID, "NumOfAddons", 5);
	end
	for i = 1, count do
		if IsAddOnLoaded(i) then
			ActiveAddons = ActiveAddons + 1;
		end
	end

	if ActiveAddons < NumOfAddons then
		counter = ActiveAddons;
	else
		counter = NumOfAddons;
	end
	--set the counter to the proper number of active addons that are being monitored
	for i = 1, counter do
		topAddOns[i] = { name = '', value = 0 }
	end
end

local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_PERFORMANCE_ID
	local root = rootDescription -- menu widget to start with

	local opts_perf = Titan_Menu.AddButton(root, L["TITAN_PANEL_OPTIONS"])
	do -- next level options
		Titan_Menu.AddSelector(opts_perf, id, L["TITAN_PERFORMANCE_MENU_SHOW_FPS"], "ShowFPS")
		Titan_Menu.AddSelector(opts_perf, id, L["TITAN_PERFORMANCE_MENU_SHOW_LATENCY"], "ShowLatency")
		Titan_Menu.AddSelector(opts_perf, id, L["TITAN_PERFORMANCE_MENU_SHOW_LATENCY_WORLD"], "ShowWorldLatency")
		Titan_Menu.AddSelector(opts_perf, id, L["TITAN_PERFORMANCE_MENU_SHOW_MEMORY"], "ShowMemory")
		Titan_Menu.AddSelector(opts_perf, id, L["TITAN_PERFORMANCE_MENU_SHOW_ADDONS"], "ShowAddonMemory")
		Titan_Menu.AddSelector(opts_perf, id, L["TITAN_PERFORMANCE_MENU_SHOW_ADDON_RATE"], "ShowAddonIncRate")
	end

	---[[
	--	local opts_adds = Titan_Menu.AddButton(root, L["TITAN_PERFORMANCE_ADDONS"])
	local tt_label = L["TITAN_PERFORMANCE_CONTROL_TOOLTIP"]
		.. LIGHTYELLOW_FONT_COLOR_CODE .. tostring(TitanGetVar(TITAN_PERFORMANCE_ID, "NumOfAddons"))
	local opts_num_adds = Titan_Menu.AddButton(root, tt_label)
	do                 -- next level options
		local num_addons = { -- selectors using the same option
			{ "1",  1 },
			{ "5",  5 },
			{ "10", 10 },
			{ "15", 15 },
			{ "20", 20 },
			{ "25", 25 },
			{ "30", 30 },
			{ "35", 35 },
			{ "40", 40 },
		}
		Titan_Menu.AddSelectorList(opts_num_adds, id, nil, "NumOfAddons", num_addons, Init)
		--[[ The slider frame does appear but the menu goes away...
		-- Using alt method to get this out :)
		--]]
	end
	--]]
	Titan_Menu.AddDivider(root)

	--	local opts_cpu = Titan_Menu.AddButton(root, L["TITAN_PERFORMANCE_MENU_CPUPROF_LABEL"])
	do -- next level options
		local s_title = ""
		if (GetCVar("scriptProfile") == "1") then
			s_title = L["TITAN_PERFORMANCE_MENU_CPUPROF_LABEL"] .. ": "
				.. TitanUtils_GetGreenText(L["TITAN_PANEL_MENU_ENABLED"])
				.. " " .. L["TITAN_PANEL_MENU_RELOADUI"]
			Titan_Menu.AddCommand(root, id, s_title,
				function()
					SetCVar("scriptProfile", "0")
					ReloadUI()
				end
			)
		else
			s_title = L["TITAN_PERFORMANCE_MENU_CPUPROF_LABEL"] .. ": "
				.. TitanUtils_GetRedText(L["TITAN_PANEL_MENU_DISABLED"])
				.. " " .. L["TITAN_PANEL_MENU_RELOADUI"]
			Titan_Menu.AddCommand(root, id, s_title,
				function()
					SetCVar("scriptProfile", "1")
					ReloadUI()
				end
			)
		end
	end
end

---local Create plugin .registry and and init some variables and register for first events
---@param self Button
local function OnLoad(self)
	local notes = ""
		.. "Adds FPS (Frames Per Second) and Garbage collection information to Titan Panel.\n"
	--		.."- xxx.\n"
	self.registry = {
		id = TITAN_PERFORMANCE_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_PERFORMANCE_MENU_TEXT"],
		menuContextFunction = GeneratorFunction, -- NEW scheme
		buttonTextFunction = GetButtonText,
		tooltipTitle = L["TITAN_PERFORMANCE_TOOLTIP"],
		tooltipTextFunction = GetTooltipText,
		icon = "Interface\\AddOns\\TitanPerformance\\TitanPerformance",
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
			ShowFPS = 1,
			ShowLatency = 1,
			ShowWorldLatency = 1,
			ShowMemory = 1,
			ShowAddonMemory = false,
			ShowAddonIncRate = false,
			NumOfAddons = 5,
			AddonMemoryType = 1,
			ShowIcon = 1,
			ShowLabelText = false,
			ShowColoredText = 1,
			DisplayOnRightSide = false,
		}
	};

	perf_stats.fpsSampleCount = 0
end

---local Hide the plugin and stop timers
local function OnHide()
	AceTimer:CancelTimer(PerfTimer)
	PerfTimerRunning = false
end

---local Update button data
local function TitanPanelPerformanceButtonHandle_OnUpdate()
	TitanPanelPluginHandle_OnUpdate(updateTable);
end

---local Show the plugin and start timers
local function OnShow()
	Init()

	if PerfTimerRunning then
		-- Do not create a new one
	else
		PerfTimer = AceTimer:ScheduleRepeatingTimer(TitanPanelPerformanceButtonHandle_OnUpdate, 1.5)
		PerfTimerRunning = true
	end
end

---local Handle events registered to plugin
---@param self Button
---@param event string
---@param ... any
local function OnEvent(self, event, ...)
	-- No events to process
end

---local Handle mouse click events registered to plugin; Left click is garbage collection
---@param self Button
---@param button string
local function OnClick(self, button)
	if button == "LeftButton" then
		collectgarbage('collect');
	end
end

---local Create needed frames
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
		OnShow()
		TitanPanelButton_OnShow(self)
	end)
	window:SetScript("OnHide", function(self)
		OnHide()
	end)
	window:SetScript("OnEvent", function(self, event, ...)
		OnEvent(self, event, ...)
	end)
	window:SetScript("OnClick", function(self, button)
		OnClick(self, button)
		TitanPanelButton_OnClick(self, button)
	end)
end

Create_Frames()  -- do the work
