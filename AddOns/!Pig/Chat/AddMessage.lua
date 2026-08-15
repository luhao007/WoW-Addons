local addonName, PD = ...;
local L=PD.locale
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo

local Fun=PD.Fun
local ReplaceEmoji=Fun.ReplaceEmoji
local _Get_GEM_EMPTY_SOCKET=Fun._Get_GEM_EMPTY_SOCKET
local PIGGetItemLevel=Fun.PIGGetItemLevel
local FasongYCqingqiu=Fun.FasongYCqingqiu
local GetRaceClassTXT=Fun.GetRaceClassTXT
--------------
local Locale=GetLocale()
local QuickChatfun = PD.QuickChatfun
local find = _G.string.find
local gsub = _G.string.gsub
local match = _G.string.match
local gmatch=_G.string.gmatch
local GetItemStats=GetItemStats or C_Item and C_Item.GetItemStats

--修复点击密语
-- PIG_OptionsUI.Plus_chat = PIGCheckbutton(PIG_OptionsUI,{"BOTTOMRIGHT", PIG_OptionsUI, "TOPRIGHT", -340, 2},{"修复聊天框点击密语","修复聊天框点击密语无效问题"})
-- PIG_OptionsUI.Plus_chat:SetScript("OnClick", function (self)
-- 	if self:GetChecked() then
-- 		PIGA["Chat"]["Plus_chat"]=true;
-- 	else
-- 		PIGA["Chat"]["Plus_chat"]=false;
-- 	end
-- 	PIG_OptionsUI.Plus_chat:Plus_chat_xifu()
-- end);
-- PIG_OptionsUI.Plus_chat:HookScript("OnShow", function(self)
-- 	self:SetChecked(PIGA["Chat"]["Plus_chat"])
-- end)
-- function PIG_OptionsUI.Plus_chat:Plus_chat_xifu()
-- 	if PIGA["Chat"]["Plus_chat"]==nil then PIGA["Chat"]["Plus_chat"] = true end
-- 	if PIGA["Chat"]["Plus_chat"] then
-- 		local old_SendTell=PIGSendTell
-- 		ChatFrameUtil.SendTell=function(name, chatFrame,pig)
-- 			local name1,server2 = strsplit("-",name, 2)
-- 			if PlayerInfo.Realm==server2 then
-- 				name = name1
-- 			end
-- 			local editBox = ChatEdit_ChooseBoxForSend(chatFrame);	
-- 			if ( editBox ~= ChatEdit_GetActiveWindow() ) then
-- 				ChatFrameUtil.OpenChat(SLASH_WHISPER1.." "..name.." ", chatFrame);
-- 			else
-- 				editBox:SetText(SLASH_WHISPER1.." "..name.." ");
-- 			end
-- 			ChatEdit_ParseText(editBox, 0);
-- 		end
-- 	end
-- end
--处理非当前本地语言乱码
-- local function PIGPlusxiufuluanma(text)
-- 	local text = text:gsub(":(.-)%-(.-):(.-)%-(.-)|h%[", ":%1:%3|h%[")
-- 	return text
-- end
---
function QuickChatfun.PIGMessage()
	local chatONOFF = {
		GuildLevel=PIGA["Chat"]["GuildLevel"],
		jingjian=PIGA["Chat"]["jingjian"],
		FastCopy=PIGA["Chat"]["FastCopy"],
		ShowZb=PIGA["Chat"]["ShowZb"],
		ShowLinkIcon=PIGA["Chat"]["ShowLinkIcon"],
		ShowLinkLV=PIGA["Chat"]["ShowLinkLV"],
		ShowLinkSlots=PIGA["Chat"]["ShowLinkSlots"],
		ShowLinkGem=PIGA["Chat"]["ShowLinkGem"],
	}
	QuickChatfun.chatONOFF=chatONOFF
	--
	local Get_itemF = CreateFrame("Frame")
	local textMsgFrame = {}
	local textAllIDs = {}
	local PlayerGUIDs = {}
	local PlayerMsgList = {}
	local MsgPlayerLevel = {}
	---
	local MAX_PENDING_MSGS = 50 
    local pendingMsgCount = 0
    local MAX_MSG_COUNT = 100  
    local msgHead = {} 
    local msgKeys = {} 
    ---
	local GUID_EXPIRE_TIME = 3
	local CLEAN_INTERVAL = 1
	local lastCleanTime = 0
	local function CleanExpiredGUIDs()
	    local now = GetTime()
	    if now - lastCleanTime < CLEAN_INTERVAL then return end
	    lastCleanTime = now
	    for guid, entry in pairs(PlayerGUIDs) do
	        if now - entry.time > GUID_EXPIRE_TIME then
	            PlayerGUIDs[guid] = nil
	        end
	    end
	end
	local function MsgReplace(...)
	    local arg2, _, _, arg5, _, _, _, _, _, arg11, arg12 = ...
	    if arg12 and arg2 then
	        CleanExpiredGUIDs()
	        PlayerGUIDs[arg2] = { GUID = arg12, time = GetTime() }
	        local nnarew = arg2:match("^(.-)-")
	        if nnarew then
	            PlayerGUIDs[nnarew] = { GUID = arg12, time = GetTime() }
	        end
	    end
	end
    ----
    local function allMsgHandle(self, event, arg1, ...)
    	if PIGisSecret(arg1) then return false, arg1, ... end
    	if event=="CHAT_MSG_WHISPER" and arg1:match("功德值") then return true end
    	MsgReplace(...)
	    return false, arg1, ...
	end
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_CHANNEL", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_SAY", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_YELL", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_WHISPER", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_BN_WHISPER", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_RAID", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_RAID_LEADER", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_RAID_WARNING", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_PARTY", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_GUILD", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_OFFICER", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_AFK", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_EMOTE", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_DND", allMsgHandle)
	ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_COMMUNITIES_CHANNEL", allMsgHandle)
	
	---
	local JJM = L["CHAT_QUKBUTNAME"]
	local JXname = L["CHAT_SIMPLIFYNAME"]
	local PATTERNS = {}
	do
	    local p = PATTERNS
	    p.SPACE_PLAYER   = " (|Hplayer:.+)"
	    p.TEAM           = "|h%[" .. SPELL_TARGET_TYPE11_DESC .. "%]|h"
	    p.GUILD          = "|h%[" .. GUILD .. "%]|h"
	    p.RAID           = "|h%[" .. CHAT_MSG_RAID .. "%]|h"
	    p.RAID_WARN      = "%[" .. CHAT_MSG_RAID_WARNING .. "%]"
	    p.BG             = "|h%[" .. CHAT_MSG_BATTLEGROUND .. "%]|h"
	    p.INSTANCE       = "|h%[" .. INSTANCE_CHAT .. "%]|h"
	    p.RAID_LEADER    = "|h%[" .. CHAT_MSG_RAID_LEADER .. "%]|h"
	    p.INST_LEADER    = "|h%[" .. INSTANCE_CHAT_LEADER .. "%]|h"
	    p.GENERAL        = "|h%[(%d+)%. " .. GENERAL .. "(.-)%]|h"
	    p.LFG            = "|h%[(%d+)%. " .. LOOK_FOR_GROUP .. "%]|h"
	    p.WORLD_CAT      = "|h%[(%d+)%. " .. CHANNEL_CATEGORY_WORLD .. "%]|h"
	    p.PIG_CHAN       = "|h%[(%d+)%. PIG%]|h"
	    -- zhCN
	    p.CN_XIAODUI     = "|h%[小队%]|h"
	    p.CN_DUIZHANG    = "|h%[队长%]|h"
	    p.CN_SAY         = "(|Hplayer:.-|h)说"
	    p.CN_YELL        = "(|Hplayer:.-|h)喊道"
	    p.CN_DAJIAO      = "|h%[(%d+)%. 大脚世界频道%]|h"
	    p.CN_TRADE_CITY  = "|h%[(%d+)%. " .. TRADE .. " %- 城市%]|h"
	    p.CN_TRADE_SRV   = "|h%[(%d+)%. " .. TRADE .. " %(服务%) %- 城市%]|h"
	    p.CN_NEWBIE      = "|h%[(%d+)%. 新手聊天%]|h"
	    -- zhTW
	    p.TW_SAY         = "(|Hplayer:.-|h)說"
	    p.TW_YELL        = "(|Hplayer:.-|h)喊道"
	    p.TW_DUIZHANG    = "|h%[隊長%]|h"
	    p.TW_XIAODUI     = "|h%[小隊%]|h"
	    p.TW_TRADE_TOWN  = "|h%[(%d+)%. " .. TRADE .. " %- 城鎮%]|h"
	    p.TW_TRADE_SRV   = "|h%[(%d+)%. " .. TRADE .. " %(服務%) %- 城鎮%]|h"
	    p.TW_NEWBIE      = "|h%[(%d+)%. 新手聊天%]|h"
	end
	local REPLACEMENTS = {}
	do
	    local r = REPLACEMENTS
	    r.TEAM        = "|h%[" .. JJM[3] .. "%]|h"
	    r.GUILD       = "|h%[" .. JJM[4] .. "%]|h"
	    r.RAID        = "|h%[" .. JJM[5] .. "%]|h"
	    r.RAID_WARN   = "%[" .. JJM[6] .. "%]"
	    r.BG          = "|h%[" .. JJM[7] .. "%]|h"
	    r.INSTANCE    = "|h%[" .. JJM[7] .. "%]|h"
	    r.RAID_LEADER = "|h%[" .. JXname[2] .. "%]|h"
	    r.INST_LEADER = "|h%[" .. JXname[3] .. "%]|h"
	    r.GENERAL     = "|h%[%1%." .. JJM[8] .. "%]|h"
	    r.LFG         = "|h%[%1%." .. JJM[10] .. "%]|h"
	    r.WORLD_CAT   = "|h%[%1%." .. JJM[11] .. "%]|h"
	    r.PIG_CHAN    = "|h%[%.PIG%]|h"
	    r.CN_XIAODUI  = "|h%[" .. JJM[3] .. "%]|h"
	    r.CN_DUIZHANG = "|h%[" .. JXname[1] .. "%]|h"
	    r.CN_SAY      = "%[说%]%1"
	    r.CN_YELL     = "%[" .. JJM[2] .. "%]%1"
	    r.CN_DAJIAO   = "|h%[%1%." .. JJM[11] .. "%]|h"
	    r.CN_TRADE    = "|h%[%1%." .. JJM[9] .. "%]|h"
	    r.CN_TRADE_SRV= "|h%[%1%." .. JXname[4] .. "%]|h"
	    r.CN_NEWBIE   = "|h%[%1%." .. JXname[5] .. "%]|h"
	    r.TW_SAY      = "%[說%]%1"
	    r.TW_YELL     = "%[喊%]%1"
	    r.TW_DUIZHANG = "|h%[" .. JXname[1] .. "%]|h"
	    r.TW_XIAODUI  = "|h%[" .. JJM[3] .. "%]|h"
	    r.TW_TRADE    = "|h%[%1%." .. JJM[9] .. "%]|h"
	    r.TW_TRADE_SRV= "|h%[%1%." .. JXname[4] .. "%]|h"
	    r.TW_NEWBIE   = "|h%[%1%." .. JXname[5] .. "%]|h"
	end
	local IS_TOC_100000_PLUS = PIG_MaxTocversion(100000, true)
	local function SimplifyName(text)
	    if not chatONOFF.jingjian then return text end
	    if Locale ~= "zhCN" and Locale ~= "zhTW" then return text end
	    local P, R = PATTERNS, REPLACEMENTS
	    text = text:gsub(P.SPACE_PLAYER, "%1")
	    text = text:gsub(P.TEAM, R.TEAM)
	    text = text:gsub(P.GUILD, R.GUILD)
	    text = text:gsub(P.RAID, R.RAID)
	    text = text:gsub(P.RAID_WARN, R.RAID_WARN)
	    text = text:gsub(P.BG, R.BG)
	    text = text:gsub(P.INSTANCE, R.INSTANCE)
	    text = text:gsub(P.RAID_LEADER, R.RAID_LEADER)
	    text = text:gsub(P.INST_LEADER, R.INST_LEADER)
	    text = text:gsub(P.GENERAL, R.GENERAL)
	    text = text:gsub(P.LFG, R.LFG)
	    text = text:gsub(P.WORLD_CAT, R.WORLD_CAT)
	    text = text:gsub(P.PIG_CHAN, R.PIG_CHAN)
	    if Locale == "zhCN" then
	        text = text:gsub(P.CN_XIAODUI, R.CN_XIAODUI)
	        text = text:gsub(P.CN_DUIZHANG, R.CN_DUIZHANG)
	        text = text:gsub(P.CN_SAY, R.CN_SAY)
	        text = text:gsub(P.CN_YELL, R.CN_YELL)
	        text = text:gsub(P.CN_DAJIAO, R.CN_DAJIAO)
	        text = text:gsub(P.CN_TRADE_CITY, R.CN_TRADE)
	        if IS_TOC_100000_PLUS then
	            text = text:gsub(P.CN_TRADE_SRV, R.CN_TRADE_SRV)
	            text = text:gsub(P.CN_NEWBIE, R.CN_NEWBIE)
	        end
	    elseif Locale == "zhTW" then
	        text = text:gsub(P.TW_SAY, R.TW_SAY)
	        text = text:gsub(P.TW_YELL, R.TW_YELL)
	        text = text:gsub(P.TW_DUIZHANG, R.TW_DUIZHANG)
	        text = text:gsub(P.TW_XIAODUI, R.TW_XIAODUI)
	        text = text:gsub(P.TW_TRADE_TOWN, R.TW_TRADE)
	        if IS_TOC_100000_PLUS then
	            text = text:gsub(P.TW_TRADE_SRV, R.TW_TRADE_SRV)
	            text = text:gsub(P.TW_NEWBIE, R.TW_NEWBIE)
	        end
	    end
	    return text
	end
	----------
	local ClassColor = Data.ClassColor
 	local colorKey = Fun.PIGGetColorKey()
 	local left, right, top, bottom = 0.08 * 500 + 5, 0.92 * 500 - 5, 0 * 500 + 5, 0.95 * 500 - 5
	local Copyicon = "|Tinterface/buttons/ui-guildbutton-publicnote-up.blp:0:0:0:0:500:500:"
	    .. left .. ":" .. right .. ":" .. top .. ":" .. bottom .. "|t"
	local Chat_List={
		["CHAT_MSG_WHISPER"]="WHISPER",
		["CHAT_MSG_WHISPER_INFORM"]="WHISPER",
		["CHAT_MSG_CHANNEL"]="CHANNEL",
		["CHAT_MSG_SAY"]="SAY",
		["CHAT_MSG_YELL"]="YELL",
		["CHAT_MSG_RAID"]="RAID",
		["CHAT_MSG_RAID_LEADER"]="RAID",
		["CHAT_MSG_RAID_WARNING"]="RAID",
		["CHAT_MSG_PARTY"]="PARTY",
		["CHAT_MSG_PARTY_LEADER"]="PARTY",
		["CHAT_MSG_GUILD"]="GUILD",
		["CHAT_MSG_OFFICER"]="OFFICER",
	}
	local function escape_dash(s)
	    return s:gsub("-", "%%-")
	end
	local function pigGetGemList(linkx)
	    local statsg = GetItemStats(linkx)
	    if not statsg then return nil end
	    local baoshiinfo
	    for key, num in pairs(statsg) do
	        if key:match("EMPTY_SOCKET_") then
	            if not baoshiinfo then baoshiinfo = {} end
	            for i = 1, num do
	                baoshiinfo[#baoshiinfo + 1] = key
	            end
	        end
	    end
	    return baoshiinfo
	end
	local function MsgFastCopyShowZb(GUID, newText, tiqu)
	    if not tiqu and chatONOFF.FastCopy then
	        newText = newText:gsub("(|Hplayer:(.-)|h%[.-%]|h)", "|Hgarrmission:-999:%2|h" .. Copyicon .. "|h%1")
	    end
	    if chatONOFF.ShowZb then
	        local _, _, _, englishRace, sex = GetPlayerInfoByGUID(GUID)
	        local raceX = GetRaceClassTXT(0, 500, englishRace, sex)
	        if raceX ~= "" then
	            newText = newText:gsub("(|Hplayer:(.-)|h%[.-%]|h)", "|Hgarrmission:-998:%2|h" .. raceX .. "|h%1")
	        end
	    end
	    return newText
	end
	QuickChatfun.MsgFastCopyShowZb = MsgFastCopyShowZb
	local RGBToHex=Fun.RGBToHex
	local function FormatGuildLevel(newText,PlayerNamex) return newText end
    if PIG_MaxTocversion(30000) then
		FormatGuildLevel=function(newText,PlayerNamex)
	        if chatONOFF.GuildLevel and newText:match("|Hchannel:GUILD|h") then
				local myLevel = UnitLevel("player") or 0
				if MsgPlayerLevel[PlayerNamex] then
				    local targetLevel = MsgPlayerLevel[PlayerNamex]
				    local colorInfo = GetRelativeDifficultyColor(myLevel, targetLevel);
				    local hexColor = RGBToHex(colorInfo)
				    newText = newText:gsub("(%[|cff%w%w%w%w%w%w)(.-)(|r%])", function(c1, name, c3)
				        return c1 .. name .. ":|cff" .. hexColor .. targetLevel .. "|r" .. c3
				    end)
				end
			end
			return newText
	    end
    end
	local function UpdateGuildMemberLevels()
		local clubId = C_Club.GetGuildClubId()
		if not clubId then return end
		local streams = C_Club.GetStreams(clubId)
		local guildStream = streams and streams[1] and streams[1].streamId
		if not guildStream then return end
		local members = C_Club.GetClubMembers(clubId, guildStream)
		if not members then return end
		for _,memberID in pairs(members) do
			local info = C_Club.GetMemberInfo(clubId,memberID)
			if info.presence ~= Enum.ClubMemberPresence.Offline and info.name and info.name~="" then
				MsgPlayerLevel[info.name]=info.level or "?"
			end
		end
	end
	local function PIGFormatMsg(text)
	    local newText = SimplifyName(text)
	    if chatONOFF.FastCopy or chatONOFF.ShowZb or chatONOFF.GuildLevel then
	        local PlayerNamex
	        if GetCVar("chatClassColorOverride") == "0" then
	            PlayerNamex = newText:match("%[|cff%w%w%w%w%w%w(.-)|r%]")
	        else
	            PlayerNamex = newText:match("%[.-%].-%[(.-)%]")
	        end
	        if PlayerNamex then
	            local entry = PlayerGUIDs[PlayerNamex]
	            if entry and entry.GUID then
	                newText = MsgFastCopyShowZb(entry.GUID, newText)
	            end
	            newText = FormatGuildLevel(newText,PlayerNamex)
	        end
	    end
	    if chatONOFF.ShowLinkIcon or chatONOFF.ShowLinkLV or chatONOFF.ShowLinkSlots or chatONOFF.ShowLinkGem then
	        local idList = textAllIDs[text]
	        if idList then
	            local isPlayerLink = newText:match("|Hplayer:") ~= nil
	            for word, level in pairs(idList) do
	                local icon = chatONOFF.ShowLinkIcon and GetItemIcon(word)
	                local lv = chatONOFF.ShowLinkLV and (level or 1)
	                local slots
	                if chatONOFF.ShowLinkSlots then
	                    local _, _, itemSubType, itemEquipLoc = PIGGetItemInfoInstant(word)
	                    slots = itemSubType
	                    if _G[itemEquipLoc] and _G[itemEquipLoc]~="" then
	                        slots = slots .. "-" .. _G[itemEquipLoc]
	                    end
	                end
	                if icon then
	                    newText = newText:gsub(
	                        "(|" .. colorKey .. "|" .. word .. "|h)",
	                        "|T" .. icon .. ":0|t%1"
	                    )
	                end
	                if lv or slots then
	                    local parts = {}
	                    if lv then parts[#parts + 1] = lv end
	                    if slots then parts[#parts + 1] = slots end
	                    local newtxtmsg = table.concat(parts)

	                    local escapedWord = isPlayerLink and escape_dash(word) or word
	                    local pattern = "(|" .. colorKey .. "|" .. escapedWord .. "|h%[)(.-%]|h|r)"
	                    newText = newText:gsub(pattern, "%1(" .. newtxtmsg .. ")%2")
	                end
	                if chatONOFF.ShowLinkGem then
	                    local gems = pigGetGemList(word)
	                    if gems then
	                        local gemParts = {}
	                        for i = 1, #gems do
	                            gemParts[i] = "|T" .. _Get_GEM_EMPTY_SOCKET(gems[i]) .. ":0|t"
	                        end
	                        newText = newText:gsub(
	                            "(|" .. colorKey .. "|" .. word .. "|h%[.-%]|h|r)",
	                            "%1" .. table.concat(gemParts)
	                        )
	                    end
	                end
	            end
	        end
	    end
	    return ReplaceEmoji(newText)
	end
    local function PIGFormatMsgItem(text, msninfo, frame, ...)
	    if pendingMsgCount >= MAX_PENDING_MSGS then
	        msninfo(frame, PIGFormatMsg(text), ...)
	        return
	    end
	    pendingMsgCount = pendingMsgCount + 1
	    textAllIDs[text] = {}
	    local itemWords = 0
	    for word in text:gmatch("|(Hitem:.-)|h") do
	        itemWords = 1
	        textAllIDs[text][word] = ""
	    end
	    if itemWords == 0 then
	        textAllIDs[text] = nil
	        pendingMsgCount = math.max(0, pendingMsgCount - 1)
	        msninfo(frame, PIGFormatMsg(text), ...)
	        return
	    end

	    local vararg = { ... }
	    local function TryResolve(count)
	        if not textAllIDs[text] then return end
	        local allReady = true
	        for word, level in pairs(textAllIDs[text]) do
	            if level == "" then
	                local ItemLevel = PIGGetItemLevel(word)
	                if ItemLevel then
	                    textAllIDs[text][word] = (ItemLevel >= 1) and ItemLevel or ""
	                else
	                    allReady = false
	                end
	            end
	        end
	        if allReady or count > 10 then
	            msninfo(frame, PIGFormatMsg(text), unpack(vararg))
	            textAllIDs[text] = nil
	            pendingMsgCount = math.max(0, pendingMsgCount - 1)
	        else
	            local delay = (count <= 3) and 0.1 or 0.3
	            C_Timer.After(delay, function()
	                TryResolve(count + 1)
	            end)
	        end
	    end
	    TryResolve(0)
	end
    --
    local oldaddfun={}
	for i = 1, NUM_CHAT_WINDOWS do
        if i ~= 2 and i ~= 3 then
            oldaddfun[i]= _G["ChatFrame" .. i].AddMessage
        end
    end
    local function FormatChatMsg(isbg)
        for i = 1, NUM_CHAT_WINDOWS do
            if i ~= 2 and i ~= 3 then
                local chatFrame = _G["ChatFrame" .. i]
                if isbg then
                	chatFrame.AddMessage=oldaddfun[i]
                else
	                local msninfo = oldaddfun[i]
	                chatFrame.AddMessage = function(frame, text, ...)
	                    if PIGisSecret(text) then
	                        return msninfo(frame, text, ...)
	                    end
	                    if text and text ~= "" and text:match("|Hplayer:") then
	                        if chatONOFF.ShowLinkLV and text:match("|Hitem:") then
	                            return PIGFormatMsgItem(text, msninfo, frame, ...)
	                        end
	                        return msninfo(frame, PIGFormatMsg(text), ...)
	                    end
	                    return msninfo(frame, text, ...)
	                end
	            end
            end
        end
    end
    if PIG_MaxTocversion() then
    	FormatChatMsg(false)
    else
	    local chatxxxUI = CreateFrame("Frame")
	    chatxxxUI:RegisterEvent("PLAYER_ENTERING_WORLD");
		chatxxxUI:HookScript("OnEvent", function(self,event,arg1,arg2)
			local _, instanceType = IsInInstance();
			FormatChatMsg(instanceType and instanceType == "pvp")
		end)
	end
	---============================
    Get_itemF:RegisterEvent("CHAT_MSG_WHISPER")
    Get_itemF:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
    Get_itemF:RegisterEvent("CHAT_MSG_CHANNEL")
    Get_itemF:RegisterEvent("CHAT_MSG_SAY")
    Get_itemF:RegisterEvent("CHAT_MSG_YELL")
    Get_itemF:RegisterEvent("CHAT_MSG_RAID")
    Get_itemF:RegisterEvent("CHAT_MSG_RAID_LEADER")
    Get_itemF:RegisterEvent("CHAT_MSG_RAID_WARNING")
    Get_itemF:RegisterEvent("CHAT_MSG_PARTY")
    Get_itemF:RegisterEvent("CHAT_MSG_PARTY_LEADER")
    Get_itemF:RegisterEvent("CHAT_MSG_GUILD")
    Get_itemF:RegisterEvent("CHAT_MSG_OFFICER")
    if PIG_MaxTocversion(30000) then
	    C_Timer.After(5, function()
	        Get_itemF:RegisterEvent("GUILD_ROSTER_UPDATE")
	        Get_itemF:RegisterEvent("CLUB_MEMBERS_UPDATED")
	        PIG_GuildRoster()
	    end)
	end
    Get_itemF:SetScript("OnEvent", function(self, event, ...)
        if event == "GUILD_ROSTER_UPDATE" or event == "CLUB_MEMBERS_UPDATED" then
        	if InCombatLockdown() then return end
            if self.GuildLevelTicker then self.GuildLevelTicker:Cancel() end
            self.GuildLevelTicker = C_Timer.NewTimer(1, UpdateGuildMemberLevels)
		elseif event=="GET_ITEM_INFO_RECEIVED" then
		    -- local itemId = ...
		else
            local arg1, _, _, _, arg5, _, _, arg8, arg9, _, arg11 = ...
            if arg5 and arg11 and arg9 then
                local layuan = event == "CHAT_MSG_CHANNEL" and (Chat_List[event] .. arg8) or Chat_List[event]
                if not PlayerMsgList[layuan] then
                    PlayerMsgList[layuan] = {}
                    msgKeys[layuan] = {}
                    msgHead[layuan] = 0
                end
                local keys = msgKeys[layuan]
                local head = msgHead[layuan]
                local idx = (head % MAX_MSG_COUNT) + 1
                local oldKey = keys[idx]
                if oldKey then
                    PlayerMsgList[layuan][oldKey] = nil
                end
                keys[idx] = arg11
                PlayerMsgList[layuan][arg11] = arg1
                msgHead[layuan] = head + 1
            end
        end
    end)

	local linkokck =PIG_MaxTocversion()
	local BusinessInfo=PD.BusinessInfo
    hooksecurefunc("SetItemRef", function(text, link, button, chatFrame)
        if not chatONOFF.ShowZb and not chatONOFF.FastCopy then return end
        if strsub(text, 1, 11) ~= "garrmission" then return end
        local _, linktype, playerName, lineID, chatType, ChannelID = strsplit(":", text)
        if linkokck then
            local name, server = strsplit("-", playerName, 2)
            if PlayerInfo.Realm == server then
                playerName = name
            end
        end
        if linktype == "-999" then
            local editBoxXX = ChatEdit_ChooseBoxForSend()
            local hasText = (editBoxXX:GetText() ~= "")
            ChatEdit_ActivateChat(editBoxXX)
            if button == "LeftButton" then
                editBoxXX:Insert(playerName)
                if not hasText then editBoxXX:HighlightText() end
            else
                local lid = tonumber(lineID)
                local leibie = chatType == "CHANNEL"
                    and ("CHANNEL" .. ChannelID)
                    or chatType
                if PlayerMsgList[leibie] and PlayerMsgList[leibie][lid] then
                    editBoxXX:Insert(PlayerMsgList[leibie][lid])
                    if not hasText then editBoxXX:HighlightText() end
                end
            end
        elseif linktype == "-998" then
            if button == "LeftButton" then
                FasongYCqingqiu(playerName)
            else
                C_FriendList.SendWho('n-"' .. playerName .. '"')
            end
        elseif linktype == "-997" then
            QuickChatfun.TabButUI.Keyword.ClickShowTab("AddIgnore", playerName)
        elseif linktype == "-996" then--邮箱记录
        	BusinessInfo.IsBusinessOpen(BusinessInfo.ClickMailRecord)
        end
    end)
end