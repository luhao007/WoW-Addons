-- **************************************************************************
-- * TitanPost.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************

-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_POST_ID = "Post";
local TITAN_BUTTON = "TitanPanel" .. TITAN_POST_ID .. "Button"

-- Constants
local FolderPre = "Interface\\AddOns\\TitanPost\\artwork\\"

-- Local variables
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceTimer = LibStub("AceTimer-3.0")
local AceHook = LibStub("AceHook-3.0")

local mailbox = {} -- default on load; store display info here
--mailbox.opened = false
mailbox.open_now = false
mailbox.new = 0
mailbox.expiry_text = ""
mailbox.expiry_num = 0
mailbox.ignore_next_pending = false

local player = TitanUtils_GetPlayer()
local debug = false;
local SECONDS_PER_DAY = 24 * 60 * 60
local SECONDS_PER_HOUR = 60 * 60
local MAX_MAIL_DAYS = 30

local expiry_warn_days = 7
local expiry_err_days = 2

local DAYS_REM = "Days Remaining"
local MAIL_OPENED = "Opened"
local CHAR = "Character"

local READ_PRE = " ?? "
local NEW_PRE = " ++ "
local EXP_PRE = " !! "
local READ_TT_POST = " : About read / total "
local NEW_TT_POST = " : New Mail this session "
local EXP_TT_POST = " : Characters with expiring Mail "
local MAIL_TT_PRE = "Mail opened : "

TitanPost = {}
TitanPost.mailbox = mailbox

Titan_Debug.post = {}
Titan_Debug.post.flow = false
Titan_Debug.post.events = false
Titan_Debug.post.expiry_flow = false
Titan_Debug.post.mail_box = false
--Titan_Debug.Out('post', 'events', "===")

----------------------------------------------------------------------------------

local ThresholdTable = {
	Values = { expiry_err_days, expiry_warn_days },
	Colors = { RED_FONT_COLOR, YELLOW_FONT_COLOR, GREEN_FONT_COLOR },
}
--local ex_header = "      " .. CHAR .. " : " .. DAYS_REM .. " : " .. MAIL_OPENED .. "\n"
local ex_header = "      " .. CHAR .. " : " .. DAYS_REM .. "\n"

local date_stamp = "%Y-%m-%d"
local time_stamp = "%H:%M"

---Format time stamp
---@param time_sec number timestamp
---@param with_time boolean add time
---@return string Timestamp Formatted
local function FormatTS(time_sec, with_time)
	local f = date_stamp
	if with_time then
		f = f .. " " .. time_stamp
	else
		-- just date w/o time
	end
	local str = date(f, time_sec)

	return str
end

---Start / stop the timer to check expiry
---@param action string 'start' | 'stop'
local function ExpiryTimer(action) end -- real declaration later...

---Format an expiry text for a single toon
---@param toon_name string
---@param toon_info table toon
---@return string
local function ShowExpiry(toon_name, toon_info)
	local now = _G.time()
	local res = ""
	local use_color = true -- TitanGetVar(TITAN_POST_ID, "ShowColoredText")

	local days = math.floor((toon_info.nextExpiry - now) / SECONDS_PER_DAY)
	local last = toon_info.lastUpdate_str
	local estr = toon_name
		.. " : " .. days
		--		.. " : " .. last
		.. "\n"
	if (use_color == true)
		or (use_color == 1) then
		local color = TitanUtils_GetThresholdColor(ThresholdTable, days);
		estr = TitanUtils_GetColoredText(estr, color)
	else
		-- leave alone
	end

	res = res .. estr

	local str = "...ShowExpiry"
		.. " " .. tostring(toon_name) .. ""
		.. " " .. tostring(days) .. ""
		--		.. " " .. tostring(last) .. ""
		--		.." "..tostring(color)..""
		.. " \n" .. tostring(res) .. ""
	Titan_Debug.Out('post', 'expiry_flow', str)

	return res
end

---Create time stamp from warning days + now
---@return integer Timestamp
local function ExpiryWarn()
	local now = _G.time()
	return (expiry_warn_days * SECONDS_PER_DAY) + now -- make timestamp
end

---Get Post info from Titan, if known
---@param toon string
---@param reason string
---@return table? Post_info if known
local function GetPostInfo(toon, reason)
	local custom_toon, toon_info = TitanUtils_GetPlayerInfo(toon)

	local res = nil

	if custom_toon then
		-- no info available, can not log in
	elseif toon_info == nil then
		-- possible the toon has not been logged into post Titan changes
	elseif toon_info[TITAN_POST_ID] then
		res = toon_info[TITAN_POST_ID]
	else
		-- not filled in
		local info = TitanSettings.Players[toon].Info
		info[TITAN_POST_ID] = {}
		local p = info[TITAN_POST_ID]
		p.lastUpdate = 0
		p.mailCount = 0
		p.mailReadNum = 0
		p.nextExpiry = 0
		p.mailEntries = {}

		res = p
	end

	return res
end

---Check the saved vars for expiring mail, only from last time that toon opened mail
---@return integer Num of toons with expiring mail
---@return string Display text with name, num, and last time mail was opened
local function CheckExpiry()
	local expiry_check = ExpiryWarn()
	local res = ""
	local exp_str = ""

	local has_expiry = false
	local expiry_toons = 0
	local expiry_low = expiry_check + 1

	local str = ""

	local now = _G.time()

	str = "CheckExpiry"
		.. " @ " .. FormatTS(expiry_check, true)
		.. " (" .. tostring(expiry_check) .. ")"
	Titan_Debug.Out('post', 'expiry_flow', str)

	for toon_name, cdata in pairs(TitanSettings.Players) do
		str = ".CheckExpiry"
			.. " " .. tostring(toon_name) .. ""
		Titan_Debug.Out('post', 'expiry_flow', str)
		local pdata = GetPostInfo(toon_name, "CheckExpiry")
		if (pdata and pdata.mailCount > 0) then
			str = "...CheckExpiry"
				.. " [" .. tostring(pdata.nextExpiry_str) .. "]"
				.. " " .. tostring(pdata.nextExpiry) .. ""
				.. " < " .. tostring(expiry_check) .. ""
				.. " = " .. tostring((pdata.nextExpiry < expiry_check)) .. ""
			Titan_Debug.Out('post', 'expiry_flow', str)

			if (pdata.nextExpiry < expiry_check) then
				if (pdata.nextExpiry < now) then
					-- ignore, too late...
				else
					-- add to list for user
					has_expiry = true

					local estr = ShowExpiry(toon_name, pdata)

					exp_str = exp_str .. estr
					expiry_toons = expiry_toons + 1 -- count the number of toons with expiring mail
				end
			else
				-- still time
			end
		else
			-- mailbox empty last we knew
		end
	end
	if has_expiry then -- add prefix for user
		res = "Expired: " .. " " .. tostring(expiry_toons) .. "\n"
		res = res .. ex_header
		res = res .. exp_str
	else
		-- still time
	end

	ExpiryTimer('start')

	str = "=CheckExpiry"
		.. " " .. tostring(expiry_toons) .. ""
		.. " \n" .. tostring(res) .. ""
	Titan_Debug.Out('post', 'expiry_flow', str)

	return expiry_toons, res
end
local expiry_timer = nil
function ExpiryTimer(action) -- prior declaration
	if action == 'start' then
		-- stop current, just in case for sanity
		if expiry_timer == nil then
			-- no timer
		else
			AceTimer.CancelTimer(_G[TITAN_BUTTON], expiry_timer)
		end
		local time_int = TitanGetVar(TITAN_POST_ID, "ExpiryTimer")
		expiry_timer =
			AceTimer.ScheduleRepeatingTimer(_G[TITAN_BUTTON], CheckExpiry, time_int * 60) -- in seconds
		local str = "Expiry next check in"
			.. " " .. tostring(time_int) .. " minutes"
		Titan_Debug.Out('post', 'expiry_flow', str)
	elseif action == 'stop' then
		if expiry_timer == nil then
			-- no timer
		else
			AceTimer.CancelTimer(_G[TITAN_BUTTON], expiry_timer)
			expiry_timer = nil
		end
	end

	local str = "ExpiryTimer"
		.. " " .. tostring(action) .. ""
	Titan_Debug.Out('post', 'expiry_flow', str)
end

---Create an x/y string for Mail
---@param playerName string
---@param addOpen boolean
---@return string
local function GetCountsStr(playerName, addOpen)
	local toon = GetPostInfo(playerName, "Get Counts")
	local res = ""

	if toon == nil then
		-- nothing to count
	else
		if addOpen then
			if toon.opened then
				res = res .. " " -- counts should be accurate for this session
			else
				res = res .. READ_PRE -- counts may not be accurate
			end
		end

		if (toon.lastUpdate == 0) then
			res = res .. L["TITAN_PANEL_NA"] --NOT_OPENED yet
		else
			if toon.mailCount > 0 then
				res = res .. toon.mailReadNum .. "/" .. toon.mailCount
			else
				-- leave 0 as blank
			end
		end
	end

	return res
end

---Create plugin text
---@param id string
---@return string Label
---@return string Display text
local function GetButtonText(id)
	local res = ""

	res = res .. GetCountsStr(player, true)

	local new = ""
	if (mailbox.new > 0) then
		new = NEW_PRE -- .. tostring(mailbox.new)
	else
		new = ""
	end

	local expiry = ""
	if (mailbox.expiry_num > 0) then
		expiry = EXP_PRE .. tostring(mailbox.expiry_num)
	else
		expiry = ""
	end

	res = res .. new .. expiry

	return "Mail : ", res
end

---Create a tool tip
---@return string
function GetTooltipText()
	local str = ""
	local res = ""

	local toon = GetPostInfo(player, "Tool Tip")
	if toon then
		str = toon.lastUpdate_str
	else
		str = ""
	end

	res = MAIL_TT_PRE .. tostring(str) .. "\n"
	res = res .. " "
		.. GetCountsStr(player, true)
		.. READ_TT_POST .. "\n"


	local new = ""
	if (mailbox.new > 0) then
		--		new = NEW_PRE .. tostring(mailbox.new) .. NEW_TT_POST .. "\n"
		new = NEW_PRE .. NEW_TT_POST .. "\n"
	else
		new = ""
	end

	local expiry = ""
	if (mailbox.expiry_num > 0) then
		expiry = EXP_PRE .. tostring(mailbox.expiry_num) .. EXP_TT_POST .. "\n"
	else
		expiry = ""
	end

	res = res .. new .. expiry
	res = res .. "\n"
	res = res .. mailbox.expiry_text .. "\n"

	return res
end

---Look at any mail, setting data for action
local function UpdateInboxData()
	if not _G.MailFrame:IsVisible() then
		return
	end

	local inboxCount, totalCount = _G.GetInboxNumItems()
	local playerData = GetPostInfo(player, "Update Inbox")

	if playerData == nil then
		-- paranoid, this should never happen for a logged in toon
	else
		local remainingDays = MAX_MAIL_DAYS
		local mailReadNum = 0

		table.wipe(playerData.mailEntries)
		local now = _G.time()

		local str = "UpdateInboxData"
			.. " " .. tostring(playerData) .. ""
			.. " #" .. tostring(inboxCount) .. ""
			.. " #" .. tostring(totalCount) .. ""
		Titan_Debug.Out('post', 'mail_box', str)

		for index = 1, inboxCount do
			-- https://warcraft.wiki.gg/wiki/API_GetInboxHeaderInfo
			-- packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead,
			--    wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(index)
			-- as of 2025 Dec
			local _, _, senderName, subject, _, CODAmount, daysLeft, _, wasRead,
			_, _, _, _ = _G.GetInboxHeaderInfo(index)

			if _G.type(daysLeft) == nil then -- sanity check
				daysLeft = MAX_MAIL_DAYS
			end

			if daysLeft < remainingDays then -- get shortest expiry
				remainingDays = daysLeft
			end

			if wasRead then --
				mailReadNum = mailReadNum + 1
			end

			str = "UpdateInboxData"
				.. " #" .. tostring(index) .. ""
				.. " '" .. tostring(senderName) .. "'"
				.. " '" .. tostring(subject) .. "'"
				.. " '" .. tostring(daysLeft) .. "'"
				.. " '" .. tostring(remainingDays) .. "'"
			Titan_Debug.Out('post', 'mail_box', str)

			table.insert(playerData.mailEntries, {
				daysLeft = daysLeft, -- fractional number
				--			packageIcon = packageIcon,
				senderName = senderName,
				--			stationaryIcon = stationaryIcon,
				subject = subject,
				wasRead = wasRead,
			})
		end

		playerData.lastUpdate = now
		playerData.lastUpdate_str = FormatTS(playerData.lastUpdate, true)
		playerData.mailCount = inboxCount
		playerData.mailReadNum = mailReadNum
		local ex_ts = math.floor(remainingDays * SECONDS_PER_DAY) + now -- make timestamp
		playerData.nextExpiry = ex_ts
		playerData.nextExpiry_str = FormatTS(ex_ts, true)
	end
end

---Look for expiry notifications, the routine will include the current too
local function UpdateInfo()
	local next_exp = 0
	mailbox.expiry_num, mailbox.expiry_text = CheckExpiry()

	local str = "UpdateInfo"
		.. " " .. tostring(player) .. ""
	Titan_Debug.Out('post', 'flow', str)
end

---Ensure there is something in the saved vars
local function InitVars()
	local str = "InitVars"
		.. " " .. tostring(player) .. ""
	Titan_Debug.Out('post', 'flow', str)

	local info = GetPostInfo(player, "Init")
	-- should create a blank, not there
end

---Process the MAIL_INBOX_UPDATE event while mailbox is open
local function MailInboxUpdate(reason)
	local str = "MailInboxUpdate"
		.. " o: " .. tostring(mailbox.opened) .. ""
		.. " on: " .. tostring(mailbox.open_now) .. ""
		.. " " .. tostring(reason) .. ""
	Titan_Debug.Out('post', 'mail_box', str)

	local pdata = GetPostInfo(player, "Mail Inbox Update")
	if pdata == nil then
		-- paranoid...
	else
		pdata.opened = true
	end

	UpdateInboxData()

	UpdateInfo()

	local numItems, totalItems = GetInboxNumItems()
	Titan_Debug.Out('post', 'mail_box',
		"Inbox: "
		.. " #" .. numItems .. ""
		.. " #" .. totalItems .. ""
	)
	TitanPanelButton_UpdateButton(TITAN_POST_ID)
end

local function OpenMailbox()
	mailbox.opened = true -- this session only
	mailbox.open_now = true

	MailInboxUpdate("Mailbox opened")
end

local function CloseMailbox()
	mailbox.open_now = false -- this session only

	if HasNewMail() then
		-- has unread mail, expect a nag event :)
		mailbox.ignore_next_pending = true
	else
		-- no unread mail
	end

	local reason = "Mailbox closed " .. tostring(mailbox.ignore_next_pending)
	MailInboxUpdate(reason)
end

---Event handler for registered events
---@param self Button
---@param event string
---@param ... unknown
local function OnEvent(self, event, arg1, arg2, ...)
	Titan_Debug.Out('post', 'events', "New >  "
		.. " " .. tostring(event) .. ""
		.. " " .. tostring(arg1) .. ""
		.. " " .. tostring(arg2) .. ""
	);
	if (event == "PLAYER_ENTERING_WORLD") then
		-- ignore 1st UPDATE_PENDING_MAIL event on entering world (first or instance or reload)
		mailbox.ignore_next_pending = true

		if arg1 == true then
			local pdata = GetPostInfo(player, "PEW")
			if pdata == nil then
				-- paranoid...
			else
				pdata.opened = false
			end
		else
			-- reload / new instance / ...
		end
	end
	---[===[
	if (event == "MAIL_INBOX_UPDATE") then
		--[[ Dec 2025  https://warcraft.wiki.gg/wiki/MAIL_INBOX_UPDATE
Fires when the inbox list is loaded while the frame is open
Fires when mail item changes from new to read
Fires when mail item is opened for the first time in a session
		--]]
		MailInboxUpdate()
	end
	--]===]
end

local function GeneratorFunction(owner, rootDescription)
	local id = TITAN_POST_ID
	local root = rootDescription -- menu widget to start with

	Titan_Menu.AddCommand(root, id, L["TITAN_PANEL_MENU_PROFILES"] .. " " .. L["TITAN_PANEL_MENU_CONFIGURATION"],
		function()
			TitanUpdateConfig("init")
			-- Open the profile config as distinct frame
			AceConfigDialog:Open("Titan Panel Addon Chars")
		end
	)

	local minutes = { -- selectors using the same option
		{ "1",  1 },
		{ "10", 10 },
		{ "30", 30 },
		{ "60", 60 },
	}
	Titan_Menu.AddSelectorList(root, id, "Expiry Check Interval - minutes", "ExpiryTimer", minutes)
end

---Register events when active
---@param self Button
local function OnShow(self)
	Titan_Debug.Out('post', 'flow', "OnShow ")

	InitVars()

	-- Register for events
	self:RegisterEvent("MAIL_INBOX_UPDATE")
	self:RegisterEvent("UPDATE_PENDING_MAIL")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Ace does parameter shuffling under the hood depending on the types passed
	-- hence the ignore diagnostic...
	---@diagnostic disable-next-line: param-type-mismatch
	if AceHook:IsHooked("MailFrame_Show", OpenMailbox) then
		-- Already hooked
	else
		AceHook:SecureHook("MailFrame_Show", OpenMailbox) -- MailFrame.lua
	end
	---@diagnostic disable-next-line: param-type-mismatch
	if AceHook:IsHooked("MailFrame_Hide", CloseMailbox) then
		-- Already hooked
	else
		-- Ace does parameter shuffling under the hood depending on the types passed
		AceHook:SecureHook("MailFrame_Hide", CloseMailbox) -- MailFrame.lua
	end

	UpdateInfo()
	TitanPanelButton_UpdateButton(TITAN_POST_ID)
end

---Unregister events when not active
---@param self Button
local function OnHide(self)
	Titan_Debug.Out('post', 'flow', "OnHide ")
	-- UnregisterEvent for events
	self:UnregisterEvent("MAIL_INBOX_UPDATE");
	self:UnregisterEvent("UPDATE_PENDING_MAIL");
	self:UnregisterEvent("PLAYER_ENTERING_WORLD");

	---@diagnostic disable-next-line: param-type-mismatch
	if AceHook:IsHooked("MailFrame_Show", OpenMailbox) then
		---@diagnostic disable-next-line: param-type-mismatch
		AceHook:Unhook("MailFrame_Show", OpenMailbox) -- MailFrame.lua
	else
		-- nothing to do
	end
	---@diagnostic disable-next-line: param-type-mismatch
	if AceHook:IsHooked("MailFrame_Hide", CloseMailbox) then
		---@diagnostic disable-next-line: param-type-mismatch
		AceHook:Unhook("MailFrame_Hide", CloseMailbox) -- MailFrame.lua
	else
		-- nothing to do
	end

	ExpiryTimer('stop')
end

---Handle any mouse clicks
---@param self Button
---@param button string Mouse click
local function OnClick(self, button)
	if (button == "LeftButton") then
		--		ToggleBags();
	end
end

---Registry for Titan; first events
---@param self Button
local function OnLoad(self)
	local notes = ""
		.. "Adds mail information to Titan Panel.\n"
		.. "- ?? : Have opened Mail this session; counts not known.\n"
		.. "- ?? <read>/<total> : Have not opened Mail this session; x/y from last time Mail opened with TitanPost running.\n"
		.. "- <read>/<total> : Opened Mail this session; x/y known counts.\n"
		.. "- ++ new mail this session; no number given - counts may not be accurate.\n"
		.. "- !! x : x characters with expiring Mail.\n"
		.. "- NOTE: New mail counts NOT given may not be accurate!\n"
		.. "- NOTE: New mail counts NOT added to x/y!\n"
		.. "- New built-in Jan 2026.\n"
	self.registry = {
		id = TITAN_POST_ID,
		menuText = TITAN_POST_ID,
		category = "Built-ins",
		buttonTextFunction = GetButtonText,
		menuContextFunction = GeneratorFunction, -- NEW scheme
		tooltipTitle = TITAN_POST_ID,
		tooltipTextFunction = GetTooltipText,
		icon = FolderPre .. "Mail",
		version = TITAN_VERSION,
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
			ShowLabelText = true,
			--			ShowColoredText = true,
			DisplayOnRightSide = false,
			ExpiryTimer = 10,
			ShowToonList = true,
		}
	};
end

local function FormatCounts(playerName, now)
	local toon = playerName -- GetPostInfo(playerName, "Format Counts")
	local res = ""
	local div = " : "

	local last_open = ""
	local counts = ""
	local warning = ""
	if (toon.lastUpdate == 0) then
		last_open = UNKNOWN --L["TITAN_PANEL_NA"] --NOT_OPENED yet
	else
		last_open = tostring(toon.lastUpdate_str)

		if toon.mailCount >= 0 then
			-- counts may not be accurate
			counts = div .. READ_PRE .. toon.mailReadNum .. "/" .. toon.mailCount
		else
			-- leave blank
		end

		if (toon.nextExpiry < ExpiryWarn()) then
			-- add to list for user
			local days = math.floor((toon.nextExpiry - now) / SECONDS_PER_DAY)
			local color = TitanUtils_GetThresholdColor(ThresholdTable, days)
			local days_str = DAYS_REM .. " : " .. tostring(days)
			days_str = TitanUtils_GetColoredText(days_str, color)
			warning = div .. days_str
		else
			-- no mail to warn about
			warning = ""
		end
	end

	res = last_open .. counts .. warning

	return res
end


---Titan Allow Titan to lookup mail info for a toon; return a formatted string
---@param playerName string
---@return string
function TitanPost.GetInfo(playerName, add_label)
	local res = ""
	local now = _G.time()

	local str = "GetMailInfo"
		.. " " .. tostring(playerName) .. ""
	Titan_Debug.Out('post', 'flow', str)

	if add_label then
		res = res .. MAIL_OPENED .. " : "
	else
		res = ""
	end

	if _G[TITAN_BUTTON]:IsShown() then
		local pdata = GetPostInfo(playerName, "API Get Info")
		if pdata then
			res = res .. FormatCounts(pdata, now)
		else
			res = res .. UNKNOWN
		end
	else
		res = res .. L["TITAN_PANEL_MENU_DISABLED"]
	end

	str = "..GetMailInfo"
		.. " '" .. tostring(res) .. "'"
	Titan_Debug.Out('post', 'flow', str)

	return res
end

---Create needed plugin frames
local function Create_Frames()
	if _G[TITAN_BUTTON] then
		return -- if already created
	end

	-- general container frame
	local f = CreateFrame("Frame", TITAN_BUTTON .. "Frame", UIParent)
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

--==== For debug access and testing
--[===[
print("======")
local TITAN_POST_ID = "Post";
local TITAN_BUTTON = "TitanPanel" .. TITAN_POST_ID .. "Button"

local SECONDS_PER_DAY = 24 * 60 * 60
local now = _G.time()
local player = "Syldil@Staghelm"
local pdata = GetPostInfo(player, "CheckExpiry")

local sender = "Lascar@Staghelm"
--[[
local p = GetPostInfo(player, "CheckExpiry")
p.lastUpdate = now
p.mailCount = 1
p.mailReadNum = 0
p.nextExpiry = math.floor(30 * SECONDS_PER_DAY) + now -- make timestamp

table.wipe(pdata.mailEntries)
p.mailEntries = {}
p.mailEntries[1] = {}
local m = p.mailEntries[1]
m.daysLeft = 30
m.senderName = sender
m.subject = "Debug Msg"
m.wasRead = false
--]]


--FormatTS(1768597331, true)
-- 1768597331 -- 2026-01-16 16:00
--print(FormatTS(1768597331, false)) -- 2026-01-16 16:00
--print(FormatTS(1768597331, true)) -- 2026-01-16 04:00 PM

TitanDumpTable(p) --(playerData)
--
--

TitanPanelButton_UpdateButton(TITAN_POST_ID)
--

-- Simulate an event manually DOES NOT WORK
TitanPanelPostButton:OnEvent("PLAYER_REGEN_ENABLED", "player")

--]===]



-- ==== Simulate firing the events
-- frame:OnEvent("MY_CUSTOM_EVENT", "arg1", "arg2") -- Does NOT appear to work...

function TitanPost.SimUpdateExpiry()
	UpdateInfo()

	local numItems, totalItems = GetInboxNumItems()
	local str = "Inbox Sim : "
		.. " " .. numItems .. ""
		.. " " .. totalItems .. ""
	Titan_Debug.Out('post', 'flow', str);

	TitanPanelButton_UpdateButton(TITAN_POST_ID)
end
