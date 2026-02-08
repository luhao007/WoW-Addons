local addonName, addonTable = ...;
local L=addonTable.locale
local find = _G.string.find
local gsub = _G.string.gsub
local match = _G.string.match
local gmatch=_G.string.gmatch
local Data=addonTable.Data
local Fun=addonTable.Fun
local _Get_GEM_EMPTY_SOCKET=Fun._Get_GEM_EMPTY_SOCKET
local _GetTooltipLevel=Fun._GetTooltipLevel
--------------
local QuickChatfun = addonTable.QuickChatfun
local FasongYCqingqiu=addonTable.Fun.FasongYCqingqiu
local GetRaceClassTXT=addonTable.Fun.GetRaceClassTXT
local GetItemInfoInstant=GetItemInfoInstant or C_Item and C_Item.GetItemInfoInstant
local GetItemStats=GetItemStats or C_Item and C_Item.GetItemStats
--提取玩家Unit
local wanjiaxinxil = {}
local is_slist_1=Fun.is_slist_1
local function GetPlayerGUID(self,event,arg1,...)
	local arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12=...
	if arg5 and arg12 then
		local nameg, fuwqi = strsplit("-", arg5, 2);
		if is_slist_1(nameg) then return true end
		if fuwqi==PIG_OptionsUI.Realm then
			wanjiaxinxil[nameg]=arg12
		else
			wanjiaxinxil[arg5]=arg12
		end
	end
	return false
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", GetPlayerGUID)
ChatFrame_AddMessageEventFilter("CHAT_MSG_COMMUNITIES_CHANNEL", GetPlayerGUID)
--
local Get_itemF = CreateFrame("Frame")
Get_itemF.textMsgFrame={}
Get_itemF.textAllIDs={}
--远程观察图标
local ClassColor=Data.ClassColor
local Texwidth,Texheight = 500,500
local function GetGemList(linkx)
	local baoshiinfo = {}
    local statsg = GetItemStats(linkx)
    if statsg then
	    for key, num in pairs(statsg) do
	        if (key:match("EMPTY_SOCKET_")) then
	            for i = 1, num do
	           		table.insert(baoshiinfo, key)
	            end
	        end
	    end
	end
	return baoshiinfo
end
---精简频道名
local JJM = L["CHAT_QUKBUTNAME"]
local JXname = L["CHAT_JXNAME"]
local function ChatPindaoName(text)
	if PIGA["Chat"]["jingjian"] then
		if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
			local text=text:gsub(" (|Hplayer:.+)", "%1")
			local text=text:gsub("|h%["..SPELL_TARGET_TYPE11_DESC.."%]|h", "|h%["..JJM[3].."%]|h")--队伍
			local text=text:gsub("|h%["..GUILD.."%]|h", "|h%["..JJM[4].."%]|h")--公會
			local text=text:gsub("|h%["..CHAT_MSG_RAID.."%]|h", "|h%["..JJM[5].."%]|h")--团队
			local text=text:gsub("%["..CHAT_MSG_RAID_WARNING.."%]", "%["..JJM[6].."%]")--團隊通告
			local text=text:gsub("|h%["..CHAT_MSG_RAID_LEADER.."%]|h", "|h%["..JXname[2].."%]|h")--团队领袖
			local text=text:gsub("|h%["..CHAT_MSG_BATTLEGROUND.."%]|h", "|h%["..JJM[7].."%]|h")--戰場
			local text=text:gsub("|h%["..INSTANCE_CHAT.."%]|h", "|h%["..JJM[7].."%]|h")--副本
			local text=text:gsub("|h%["..INSTANCE_CHAT_LEADER.."%]|h", "|h%["..JXname[3].."%]|h")--副本向导
			--xuhao
			local text=text:gsub("|h%[(%d+)%. "..GENERAL.."(.-)%]|h", "|h%[%1%."..JJM[8].."%]|h")--综合
			local text=text:gsub("|h%[(%d+)%. "..LOOK_FOR_GROUP.."%]|h", "|h%[%1%."..JJM[10].."%]|h")--寻求组队
			local text=text:gsub("|h%[(%d+)%. 大脚世界频道%]|h", "|h%[%1%."..JJM[11].."%]|h")
			local text=text:gsub("|h%[(%d+)%. PIG%]|h", "|h%[%.PIG%]|h")
			if GetLocale() == "zhCN" then
				local text=text:gsub("(|Hplayer:.-|h)说", "%[说%]%1")
				local text=text:gsub("(|Hplayer:.-|h)喊道", "%[喊%]%1")
				local text=text:gsub("|h%[队长%]|h", "|h%["..JXname[1].."%]|h")--队长
				local text=text:gsub("|h%[小队%]|h", "|h%["..JJM[3].."%]|h")--小队
				--xuhao
				local text=text:gsub("|h%[(%d+)%. "..TRADE.." %- 城市%]|h", "|h%[%1%.交%]|h")
				if PIG_MaxTocversion(100000,true) then
					local text=text:gsub("|h%[(%d+)%. "..TRADE.." %(服务%) %- 城市%]|h", "|h%[%1%.服%]|h")
					local text=text:gsub("|h%[(%d+)%. 新手聊天%]|h", "|h%[%1%.新%]|h")
					return text
				end
				return text
			elseif GetLocale() == "zhTW" then
				local text=text:gsub("(|Hplayer:.-|h)說", "%[說%]%1")
				local text=text:gsub("(|Hplayer:.-|h)喊道", "%[喊%]%1")
				local text=text:gsub("|h%[隊長%]|h", "|h%["..JXname[1].."%]|h")--队长
				local text=text:gsub("|h%[小隊%]|h", "|h%["..JJM[3].."%]|h")--小队
				--xuhao
				local text=text:gsub("|h%[(%d+)%. "..TRADE.." %- 城鎮%]|h", "|h%[%1%.交%]|h")
				if PIG_MaxTocversion(100000,true) then
					local text=text:gsub("|h%[(%d+)%. "..TRADE.." %(服務%) %- 城鎮%]|h", "|h%[%1%.服%]|h")
					local text=text:gsub("|h%[(%d+)%. 新手聊天%]|h", "|h%[%1%.新%]|h")
					return text
				end
				return text
			end
			return text
		end
		return text
	end
	return text
end
local GetColorKey=Fun.PIGGetColorKey
local function escape_dash(s)
    return s:gsub("-", "%%-")
end
local function ShowZb_Link_Icon(text)
	newText=ChatPindaoName(text)
	if PIGA["Chat"]["FastCopy"] or PIGA["Chat"]["ShowZb"] then
		local namexShowZb=""
		if PIGA["Chat"]["ClassColor"] then
			namexShowZb = newText:match("%[|cff%w%w%w%w%w%w(.-)|r%]")
		else
			namexShowZb = newText:match("%[.-%].-%[(.-)%]")
		end
		if namexShowZb and namexShowZb~="" and wanjiaxinxil[namexShowZb] then
			if PIGA["Chat"]["FastCopy"] then
				local left=0.08*Texheight+5
				local right=0.92*Texheight-5
				local top=0*Texheight+5
				local bottom=0.95*Texheight-5
				local Copyicon ="|Tinterface/buttons/ui-guildbutton-publicnote-up.blp:0:0:0:0:"..Texheight..":"..Texheight..":"..left..":"..right..":"..top..":"..bottom.."|t"
				if Copyicon~="" then
					newText=newText:gsub("(|Hplayer:(.-)|h%[.-%]|h)", "|Hgarrmission:-999:%2|h"..Copyicon.."|h%1")
				end
			end
			if PIGA["Chat"]["ShowZb"] then
				local _, _, _, englishRace, sex = GetPlayerInfoByGUID(wanjiaxinxil[namexShowZb])
				local raceX = GetRaceClassTXT(0,Texwidth,englishRace,sex)
				if raceX~="" then
					newText=newText:gsub("(|Hplayer:(.-)|h%[.-%]|h)", "|Hgarrmission:-998:%2|h"..raceX.."|h%1")
				end
			end
		end
	end
	if PIGA["Chat"]["ShowLinkIcon"] or PIGA["Chat"]["ShowLinkLV"] or PIGA["Chat"]["ShowLinkSlots"] then
		if Get_itemF.textAllIDs[text] then
			local tihuanidlist = {}
			for word,level in pairs(Get_itemF.textAllIDs[text]) do
				tihuanidlist[word] = {}
				if PIGA["Chat"]["ShowLinkIcon"] then
					tihuanidlist[word]["icon"]=GetItemIcon(word)
				end
				if PIGA["Chat"]["ShowLinkLV"] then
					tihuanidlist[word]["LV"]=level or 1
				end
				if PIGA["Chat"]["ShowLinkSlots"] then
					local itemID, itemType, itemSubType, itemEquipLoc = GetItemInfoInstant(word)
					if _G[itemEquipLoc] then
						tihuanidlist[word]["Slots"]=itemSubType.."-".._G[itemEquipLoc]
					end
				end
				if PIGA["Chat"]["ShowLinkGem"] then
				    tihuanidlist[word]["Gem"]=GetGemList(word)
				end
			end
			for word,data in pairs(tihuanidlist) do
				if PIGA["Chat"]["ShowLinkIcon"] then
					newText=newText:gsub("(|"..GetColorKey().."|"..word.."|h)","|T"..data.icon..":0|t%1");
				end
				if PIGA["Chat"]["ShowLinkLV"] or PIGA["Chat"]["ShowLinkSlots"] then
					local newtxtmsg = ""
					if PIGA["Chat"]["ShowLinkLV"] then			
						newtxtmsg=newtxtmsg..data.LV
					end
					if PIGA["Chat"]["ShowLinkSlots"] and data.Slots then
						newtxtmsg=newtxtmsg..data.Slots
					end
					if text:match("Player") then
						newText=newText:gsub("(|"..GetColorKey().."|"..escape_dash(word).."|h%[)(.-%]|h|r)","%1("..newtxtmsg..")%2");
					else
						newText=newText:gsub("(|"..GetColorKey().."|"..word.."|h%[)(.-%]|h|r)","%1("..newtxtmsg..")%2");
					end
					if PIGA["Chat"]["ShowLinkGem"] and #data.Gem>0 then
						local GemTxt = ""
						for ixx=1,#data.Gem do
							GemTxt=GemTxt.."|T".._Get_GEM_EMPTY_SOCKET(data.Gem[ixx])..":0|t"
						end
						newText=newText:gsub("(|"..GetColorKey().."|"..word.."|h%[.-%]|h|r)","%1"..GemTxt);
					end
				end
			end
		end
	end
	return newText
end
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
-- 		local old_ChatFrame_SendTell=PIGSendTell
-- 		ChatFrame_SendTell=function(name, chatFrame,pig)
-- 			local name1,server2 = strsplit("-",name, 2)
-- 			if PIG_OptionsUI.Realm==server2 then
-- 				name = name1
-- 			end
-- 			local editBox = ChatEdit_ChooseBoxForSend(chatFrame);	
-- 			if ( editBox ~= ChatEdit_GetActiveWindow() ) then
-- 				ChatFrame_OpenChat(SLASH_WHISPER1.." "..name.." ", chatFrame);
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
	hooksecurefunc("SetItemRef", function(text,link, button, chatFrame)
		if not PIGA["Chat"]["ShowZb"] and not PIGA["Chat"]["FastCopy"] then return end
		if ( strsub(text, 1, 11) ~= "garrmission" ) then return end
		local nametext = strsub(text, 13);
		local gnid,name_server = strsplit(":", nametext);--lineID, chatType, chatTarget
		if PIG_MaxTocversion() then
			local name,server = strsplit("-",name_server, 2)
			if PIG_OptionsUI.Realm==server then
				name_server = name
			end
		end
		if gnid=="-999" and PIGA["Chat"]["FastCopy"] then
			local editBoxXX = ChatEdit_ChooseBoxForSend()
	        local hasText = (editBoxXX:GetText() ~= "")
	        ChatEdit_ActivateChat(editBoxXX)
			if button=="LeftButton" then
				editBoxXX:Insert(name_server)
				if (not hasText) then editBoxXX:HighlightText() end
			else
				for msgid = chatFrame:GetNumMessages(), 1, -1 do
					local msgtext = chatFrame:GetMessageInfo(msgid)
					if msgtext and msgtext:find(text, nil, true) then
						local endjieshu
						local kaishi,jieshu=msgtext:find("|r%]|h:")
						local endjieshu=jieshu
						if not endjieshu then
							local kaishi,jieshu=msgtext:find("|r%]|h： ")
							endjieshu=jieshu
						end
						if endjieshu then
							local newText = strsub(msgtext, endjieshu+1);
							local newText=newText:gsub(" |T.-|t","");
							local newText=newText:gsub("|T.-|t","");
							editBoxXX:Insert(newText)
					        if (not hasText) then editBoxXX:HighlightText() end
					    end
						return
					end
				end
			end
		elseif gnid=="-998" and PIGA["Chat"]["ShowZb"] then
			if button=="LeftButton" then
				FasongYCqingqiu(name_server)
			else
				C_FriendList.SendWho('n-"'..name_server..'"')
			end
		end
	end)

	local function GetMsgItemLists(text,msninfo,frame,extd)
		Get_itemF.textMsgFrame[text]={msninfo,frame,extd}
		Get_itemF.textAllIDs[text]={}
		for word in text:gmatch("|(Hitem:.-)|h") do
			Get_itemF.textAllIDs[text][word]=0
			_GetTooltipLevel("link",{word},function(ItemLevel)
				if ItemLevel<2 then
					Get_itemF.textAllIDs[text][word]=""
				else
    				Get_itemF.textAllIDs[text][word]=ItemLevel
    			end
    		end)
		end
	end
	local function SetMsgItemLists(text)
    	for word,level in pairs(Get_itemF.textAllIDs[text]) do
    		if level==0 then
    			return
    		end
    	end
    	Get_itemF.textMsgFrame[text][1](Get_itemF.textMsgFrame[text][2],ShowZb_Link_Icon(text),unpack(Get_itemF.textMsgFrame[text][3]))
    	Get_itemF.textAllIDs[text] = nil
	    Get_itemF.textMsgFrame[text] = nil
	end
	Get_itemF:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	Get_itemF:SetScript("OnEvent", function(self, event, NItemID)
	    for text,list in pairs(self.textAllIDs) do
	   		SetMsgItemLists(text)
	    end
	end)
	---
	Get_itemF.oldAddMessage={}
	local function jiluoldmsgfun()
		for i = 1, NUM_CHAT_WINDOWS do
			if ( i ~= 2 and i~=3 ) then
				local chatFrame = _G["ChatFrame"..i]
				Get_itemF.oldAddMessage[chatFrame]=chatFrame.AddMessage
			end
		end
	end
	jiluoldmsgfun()
	local function NewAddMessage(msninfo,frame, text, ...)
		-- print(text)
		--local text=text:gsub("|cff%w%w%w%w%w%w|Hmount:.-|h%[","");				
		--if i==1 then table.insert(PIGA["xxxxxx"],text) end
		--PIG_ChatFrameKeyWord:AddMessage(...);
		-- local newTextxx = link:gsub("|", "||")
		-- print(newTextxx)
		if text and text~="" and text:match("player") then
			if text:match("Hitem:") and PIGA["Chat"]["ShowLinkLV"] then
				GetMsgItemLists(text,msninfo,frame,{...})
				return SetMsgItemLists(text)
			end
			return msninfo(frame, ShowZb_Link_Icon(text), ...)
		end
		return msninfo(frame, text, ...)
	end
	local function zhuchetihuanE(oldx)
		for i = 1, NUM_CHAT_WINDOWS do
			if ( i ~= 2 and i~=3 ) then
				local chatFrame = _G["ChatFrame"..i]
				local msninfo = Get_itemF.oldAddMessage[chatFrame]
				if oldx then
					chatFrame.AddMessage = function(frame, text, ...)
						NewAddMessage(msninfo,frame, text, ...)
					end
				else
					chatFrame.AddMessage = function(frame, text, ...)
						if issecretvalue(text) then return msninfo(frame, text, ...) end
						NewAddMessage(msninfo,frame, text, ...)
					end
				end
			end
		end
	end
	zhuchetihuanE(PIG_MaxTocversion())
end