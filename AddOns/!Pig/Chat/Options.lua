local addonName, PD = ...;
local L=PD.locale
local gsub = _G.string.gsub
local match = _G.string.match
local Fun=PD.Fun
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
--------------
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
local PIGDiyBut=Create.PIGDiyBut
------
local QuickChatfun = {}
PD.QuickChatfun=QuickChatfun
--------
--（关闭语言过滤器）
local function guanbiGuolv()
	--if PIGA["Chat"]["Guolv"] then return end
	-- if not PIGA["Chat"]["Guolv"] then return end
	-- if GetLocale() ~= "zhCN" then return end
	-- if GetCVar("portal") == "CN" then
	-- 	ConsoleExec("portal TW")
	-- end
	-- SetCVar("profanityFilter", "0")
	-- if PIG_MaxTocversion(90000,true) then
	-- 	local Old_fun = C_BattleNet.GetFriendGameAccountInfo
	-- 	C_BattleNet.GetFriendGameAccountInfo = function(...)
	-- 		local gameAccountInfo = Old_fun(...)
	-- 		gameAccountInfo.isInCurrentRegion = true
	-- 		return gameAccountInfo;
	-- 	end
	-- else
	-- 	local OLD_BNGetFriendInfo = BNGetFriendInfo
	-- 	BNGetFriendInfo = function(...)
	-- 		local bnetIDAccount, accountName, battleTag, isBattleTagPresence, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend = OLD_BNGetFriendInfo(...)
	-- 		local canSummonFriend = true
	-- 		return bnetIDAccount, accountName, battleTag, isBattleTagPresence, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend;
	-- 	end
	-- end
	-- HelpFrame.guanbiguolvqi=PIGButton(HelpFrame,{"TOPRIGHT", HelpFrame, "TOPRIGHT", -50, -0.6},{280,19},"无法访问点这里然后重新登录游戏")
	-- HelpFrame.guanbiguolvqi:SetFrameLevel(510)
	-- HelpFrame.guanbiguolvqi:SetScript("OnClick", function (self)
	-- 	PIGA["Chat"]["Guolv"]=false
	-- 	self:SetText("请退出游戏重新登录")
	-- 	self:Disable()
	-- end);
end

--输入框光标优化
local function ChatFrame_Althistory_Open()
	local ChatHistory = {}
	local ChatHistoryIndex = 0
	for i = 1, NUM_CHAT_WINDOWS do
		local ChatFrame=_G["ChatFrame"..i.."EditBox"]
		hooksecurefunc(ChatFrame, "AddHistoryLine", function(self, msg)
			if ChatFrame:GetAltArrowKeyMode() then return end
			if #ChatHistory>19 then
				for ix=#ChatHistory,20,-1 do
					table.remove(ChatHistory,ix)
				end
			end
			table.insert(ChatHistory,1,msg)
		end)
		ChatFrame:HookScript("OnShow",function()
			if ChatFrame:GetAltArrowKeyMode() then return end
			ChatHistoryIndex = 0
		end)	
		ChatFrame:HookScript("OnKeyDown",function(self,key)
			if key=="UP" or key=="DOWN" then
				if #ChatHistory==0 then return end
				if key=="UP" then
					if ChatHistoryIndex<#ChatHistory then
						ChatHistoryIndex=ChatHistoryIndex+1
					else
						ChatHistoryIndex=1
					end
				elseif key=="DOWN" then
					if ChatHistoryIndex>1 then
						ChatHistoryIndex=ChatHistoryIndex-1
					else
						ChatHistoryIndex = #ChatHistory
					end
				end
				self:SetText(ChatHistory[ChatHistoryIndex])
	        	--self:HighlightText()
			end
		end)
	end
end
ChatFrame_Althistory_Open()
local function ChatFrame_AltEX_Open(onoff)
	local onoff = onoff or PIGA["Chat"]["AltEX"]
	if onoff then
		if ChatFrame1EditBox:GetAltArrowKeyMode() then
			for i = 1, NUM_CHAT_WINDOWS do
				_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false) --false只按方向键即可控制输入框光标 
			end
		end
	else
		if not ChatFrame1EditBox:GetAltArrowKeyMode() then
			for i = 1, NUM_CHAT_WINDOWS do
				_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(true) --
			end
		end
	end
end
--移除聊天文字渐隐
local function ChatFrame_Jianyin_Open()
	if PIGA["Chat"]["Jianyin"] then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:SetFading(false)
		end
	else
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:SetFading(true) 
		end
	end
end
----鼠标指向链接显示物品属性
local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}
local function Chat_LinkShow()
	if not PIGA["Chat"]["LinkShow"] then return end
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G["ChatFrame"..i]
		frame:HookScript("OnHyperlinkEnter", function (self, linkData, link)
			local linktype = linkData:match("^([^:]+)")
			if linktype and linktypes[linktype] then
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()
			end
		end)
		frame:HookScript("OnHyperlinkLeave", function()
			GameTooltip:ClearLines();
			GameTooltip:Hide()
		end)
	end
end
---------------------
local function JoinPIG(pindaoName)
	local channel,channelName= GetChannelName(pindaoName)
	if not channelName then
		if channelName=="PIG" then
			JoinTemporaryChannel(pindaoName, nil, DEFAULT_CHAT_FRAME:GetID(), 1);
		else
			JoinPermanentChannel(pindaoName, nil, DEFAULT_CHAT_FRAME:GetID(), 1);
			PIGChatFrameAddChannel(DEFAULT_CHAT_FRAME, pindaoName)
		end
	end
end
local function JoinPIG_D_1(pindaoName,jihuo)
	local chabuts=ChannelFrame.ChannelList.buttons
	for i=1,#chabuts do
		chabuts[i]:Enable()
		chabuts[i].Text:SetTextColor(1, 1, 1, 1);
		if pindaoName==chabuts[i].name then
			if not jihuo then
				chabuts[i]:Disable()
				chabuts[i].Text:SetTextColor(0.5, 0.5, 0.5, 0.5);
			end
		end
	end
end
local function JoinPIG_D(pindaoName)
	hooksecurefunc(ChannelFrame.ChannelList, "Update", function()
		JoinPIG_D_1(pindaoName)
	end)
	Fun.IsAddOnLoaded("Blizzard_Communities",function()
		if ChannelFrame:IsShown() then
        	ChannelFrame:Hide()
       		ChannelFrame:Show()
       	end
	end)
end
local function JoinPIGALL(pindaoName)
	if PIGA["Chat"]["JoinPindao"] then
		JoinPIG(LOOK_FOR_GROUP)
		JoinPIG("PIG")
		JoinPIG_D("PIG")
		JoinPIG(CHANNEL_CATEGORY_WORLD)
	end
	for i = 1, NUM_CHAT_WINDOWS do
		local name= GetChatWindowInfo(i);
		if name and name~="" and _G["ChatFrame"..i] then
			PIGChatFrameRemoveChannel(_G["ChatFrame"..i], "PIG");
		end
	end
end

--设置聊天字体大小--------
local ChatFontSizeList = {12,13,14,15,16,17,18,19,20,21,22,23,24,25,26};
local ChatFont_Min =ChatFontSizeList[1]
local ChatFont_Max =ChatFontSizeList[#ChatFontSizeList]
--放大缩小字体按钮
local function MaxMinBUT_icon()
	if ChatFrame1.MinB and ChatFrame1.MaxB then
		ChatFrame1.MaxB:Enable();
		ChatFrame1.MinB:Enable();
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize==ChatFont_Min then
			ChatFrame1.MinB:Disable()
		end
		if fontSize==ChatFont_Max then
			ChatFrame1.MaxB:Disable()
		end
	end
end
local function ChatFrame_WINDOWS_Size(NewSize)
	for id=1,NUM_CHAT_WINDOWS,1 do
		FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], NewSize);
	end
	if _G["PIG_ChatFrameKeyWord"] then
		FCF_SetChatWindowFontSize(nil, _G["PIG_ChatFrameKeyWord"], NewSize);
	end
	MaxMinBUT_icon()
end
local function ChatFrame_AutoFontSize_Open()
	if PIGA["Chat"]["FontSize"] then
		ChatFrame_WINDOWS_Size(PIGA["Chat"]["FontSize_value"])
	end
end
local function ChatFrame_MinMaxB_Open()
	if not PIGA["Chat"]["MinMaxB"] then return end
	local fff = ChatFrame1
	if fff.MinB then return end
	local wwwhh = 18
	fff.MaxB = PIGButton(UIParent,{"TOPRIGHT",fff.Background,"TOPRIGHT",0,0},{wwwhh,wwwhh},"+"); 
	fff.MaxB:SetBackdropColor(0,0,0,0);
	fff.MaxB:SetBackdropBorderColor(0,0,0,0.4);
	fff.MaxB:SetScript("OnEnter", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0, 0.8, 1, 0.9);
		end
	end);
	fff.MaxB:SetScript("OnLeave", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0,0,0,0.4);
		end
	end);
	fff.MinB = PIGButton(UIParent,{"RIGHT",fff.MaxB,"LEFT",-2,0},{wwwhh,wwwhh},"-");
	fff.MinB:SetBackdropColor(0,0,0,0); 
	fff.MinB:SetBackdropBorderColor(0,0,0,0.4);
	fff.MinB:SetScript("OnEnter", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0, 0.8, 1, 0.9);
		end
	end);
	fff.MinB:SetScript("OnLeave", function(self)
		if self:IsEnabled() then
			self:SetBackdropBorderColor(0,0,0,0.4);
		end
	end);
	MaxMinBUT_icon()
	fff.MinB:SetScript("OnClick", function(self)
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize>ChatFont_Min then
			ChatFrame_WINDOWS_Size(fontSize-1)
			MaxMinBUT_icon()
		end
	end);
	fff.MaxB:SetScript("OnClick", function(self)
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize<ChatFont_Max then
			ChatFrame_WINDOWS_Size(fontSize+1)
			MaxMinBUT_icon()
		end
	end);
end
---查询页密语
local function WhoWhisper_Fun()
	if not PIGA["Chat"]["WhoWhisper"] then return end
	if WhoFrame.endsenList then return end
	WhoFrame.endsenList={}
	WhoFrame.endsenmsg=PIGA["Chat"]["WhoWhisperMsg"]
	WhoFrame.senmsg = PIGButton(WhoFrame,{"TOPLEFT",WhoFrame,"TOPLEFT",160,-26},{60,26},"密语",nil,nil,nil,nil,0);
	WhoFrame.senmsg:Disable();
	WhoFrame.senmsg:HookScript("OnClick", function(self, button)
		if WhoFrame.selectedWho then
			local info = C_FriendList.GetWhoInfo(WhoFrame.selectedWho);
			SendChatMessage(WhoFrame.endsenmsg, "WHISPER", nil, info.fullName);
			WhoFrame.endsenList[info.fullName]=true
			self:Disable()
		end
	end)
	WhoFrame.senmsg.bianji = PIGDiyBut(WhoFrame.senmsg,{"LEFT",WhoFrame.senmsg,"RIGHT",4,0},{nil,nil,20,22,130781})
	WhoFrame.senmsg.bianji:SetScript("OnClick", function (self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F.NR.E:SetText(WhoFrame.endsenmsg)
			self.F:Show()
		end
	end);
	WhoFrame.senmsg.listUpdate=function(button)
		if button.senmsgFun then return end
		button:HookScript("OnClick", function(self)
			if WhoFrame.selectedWho then
				local NameText = self.Name or self:GetName() and _G[self:GetName().."Name"]:GetText()
				if WhoFrame.endsenList[NameText] then	
					WhoFrame.senmsg:Disable()
				else
					WhoFrame.senmsg:Enable()
				end
			end
		end)
		button.senmsgFun=true
	end
	local EextData={
		["ElvUI"]={true,{0,0,0,0}},
		["NDui"]={Fun.IsNDui("Skins","BlizzardSkins"),{0,0,0,0}},
	}
	WhoFrame.senmsg.bianji.F=PIGFrame(WhoFrame.senmsg.bianji,{"TOPLEFT",WhoFrame.senmsg.bianji,"TOPRIGHT",4,0},{300,200},nil,nil,nil,EextData)
	WhoFrame.senmsg.bianji.F:PIGSetBackdrop(1)
	WhoFrame.senmsg.bianji.F:PIGClose()
	WhoFrame.senmsg.bianji.F:Hide()
	WhoFrame.senmsg.bianji.F.biaoti = PIGFontString(WhoFrame.senmsg.bianji.F,{"TOP", WhoFrame.senmsg.bianji.F, "TOP", 0,-4},"密语内容");
	WhoFrame.senmsg.bianji.F.NR=PIGFrame(WhoFrame.senmsg.bianji.F,{"TOPLEFT", WhoFrame.senmsg.bianji.F, "TOPLEFT", 4,-26})
	WhoFrame.senmsg.bianji.F.NR:SetPoint("BOTTOMRIGHT", WhoFrame.senmsg.bianji.F, "BOTTOMRIGHT", -5,3);
	WhoFrame.senmsg.bianji.F.NR:PIGSetBackdrop(0,0.6,nil,{1, 1, 0})
	WhoFrame.senmsg.bianji.F.NR.E = CreateFrame("EditBox", nil, WhoFrame.senmsg.bianji.F.NR);
	WhoFrame.senmsg.bianji.F.NR.E:SetPoint("TOPLEFT", WhoFrame.senmsg.bianji.F.NR, "TOPLEFT", 2,-2);
	WhoFrame.senmsg.bianji.F.NR.E:SetPoint("BOTTOMRIGHT", WhoFrame.senmsg.bianji.F.NR, "BOTTOMRIGHT", -2,2);
	WhoFrame.senmsg.bianji.F.NR.E:SetFontObject(ChatFontNormal);
	WhoFrame.senmsg.bianji.F.NR.E:SetAutoFocus(false);
	WhoFrame.senmsg.bianji.F.NR.E:SetMultiLine(true)
	WhoFrame.senmsg.bianji.F.NR.E:SetMaxLetters(200);
	WhoFrame.senmsg.bianji.F.NR.E:SetTextColor(0.7, 0.7, 0.7, 0.6);
	WhoFrame.senmsg.bianji.F.NR.E:SetScript("OnEditFocusGained", function(self) 
		self:SetTextColor(1, 1, 1, 1);
	end);
	WhoFrame.senmsg.bianji.F.NR.E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.7, 0.7, 0.7, 1);
	end);
	WhoFrame.senmsg.bianji.F.NR.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	WhoFrame.senmsg.bianji.F.NR.E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
	end);
	WhoFrame.senmsg.bianji.F.NR.E:SetScript("OnCursorChanged", function(self)
		WhoFrame.endsenmsg=self:GetText();
		PIGA["Chat"]["WhoWhisperMsg"]=WhoFrame.endsenmsg
	end);
end
--输入框移动---------------
local function Update_editBoxPoint()
	local weizhidata = {-5,-2,5,-2}
	if PIGA["Chat"]["QuickChat"] or PIGA["PigLayout"]["ChatUI"]["editMove"] then
		if PIGA["Chat"]["QuickChat_maodian"]==1 then

		elseif PIGA["Chat"]["QuickChat_maodian"]==2 then
			weizhidata[1]=-5
			weizhidata[2]=-23
			weizhidata[3]=5
			weizhidata[4]=-23
		end
		if PIGA["PigLayout"]["ChatUI"]["editMove"] then
			weizhidata[1]=weizhidata[1]+PIGA["PigLayout"]["ChatUI"]["editPoint"][1]
			weizhidata[2]=weizhidata[2]+PIGA["PigLayout"]["ChatUI"]["editPoint"][2]
			weizhidata[3]=weizhidata[3]+PIGA["PigLayout"]["ChatUI"]["editPoint"][1]
			weizhidata[4]=weizhidata[4]+PIGA["PigLayout"]["ChatUI"]["editPoint"][2]
		end
		for i=1,NUM_CHAT_WINDOWS do
			local fujichat = _G["ChatFrame"..i]
			fujichat.editBox:ClearAllPoints();
			fujichat.editBox:SetPoint("TOPLEFT",fujichat,"BOTTOMLEFT",weizhidata[1],weizhidata[2]);
			fujichat.editBox:SetPoint("TOPRIGHT",fujichat,"BOTTOMRIGHT",weizhidata[3],weizhidata[4]);
		end
	end
end
QuickChatfun.Update_editBoxPoint=Update_editBoxPoint
--屏蔽人员进入提示
local function RemTips_Fun()
	if PIGA["Chat"]["RemTips"] then
		for i=1,NUM_CHAT_WINDOWS do
			ChatFrame_RemoveMessageGroup(_G["ChatFrame"..i], "CHANNEL")--屏蔽人员进出频道提示
		end
	else
		for i=1,NUM_CHAT_WINDOWS do
			ChatFrame_AddMessageGroup(_G["ChatFrame"..i], "CHANNEL")--屏蔽人员进出频道提示
		end	
	end
end

--去除本地/世界防务数字频道列表
local function GetPindaoList_F()
	local chatpindao = {GetChatWindowMessages(1)}
	local chatpindaoList = {}
	for i=1,#chatpindao do
		local Namechia =_G[chatpindao[i].."_MESSAGE"]
		if Namechia then
			if Namechia~=BN_WHISPER_Name and Namechia~=RAID_WARNING and Namechia~=CHAT_MSG_EMOTE then
				table.insert(chatpindaoList,{Namechia,chatpindao[i]})
			end
		end
	end
	local channels = {GetChannelList()}
	for i = 1, #channels, 3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		if name~=L["CHAT_BENDIFANGWU"] and name~=L["CHAT_WORLDFANGWU"] then
			table.insert(chatpindaoList,{name,"CHANNEL"..id})
		end
	end
	return chatpindaoList
end

--TAB切换频道
local MeihangNum,MeihangJG = 3,150
local BN_WHISPER_Name = L["CHAT_BN_WHISPER"]
BN_WHISPER_MESSAGE=BN_WHISPER_MESSAGE or BN_WHISPER_Name
local MorenqiehuanYN = {
	["SAY"]=true,["PARTY"]=true,["RAID"]=true,["GUILD"]=true,["INSTANCE_CHAT"]=true,["WHISPER"]=false,["BN_WHISPER"]=false
}
local TABpindaoOpen = {["Open"]=false}
local function GetPindaoSetV(piname)
	if piname=="WHISPER" or piname=="BN_WHISPER" then return false end
	if PIGA["Chat"]["TABqiehuanList"][piname]=="Y" then
		return true
	elseif PIGA["Chat"]["TABqiehuanList"][piname]=="N" then
		return false
	else
		return MorenqiehuanYN[piname]
	end
end
local TABpindaoList = {}
local function TABPindaoSelect_Update()
	TABpindaoOpen.Open=PIGA["Chat"]["TABqiehuanOpen"]
	wipe(TABpindaoList)
	local pindata=GetPindaoList_F()
	for i=1,#pindata do
		if GetPindaoSetV(pindata[i][2]) then
			table.insert(TABpindaoList,pindata[i][2])
		end
	end
end
local function GetNextPindaoInfo1(NewType)
	if NewType:match("CHANNEL") then
		local tihuanhou = NewType:gsub("CHANNEL","")
		return "CHANNEL",tihuanhou
	else
		if NewType=="PARTY" then
			if IsInGroup(LE_PARTY_CATEGORY_HOME) then return NewType else return false end
		elseif NewType=="RAID" then
			if IsInRaid(LE_PARTY_CATEGORY_HOME) then return NewType else return false end
		elseif NewType=="GUILD" then
			if IsInGuild() then return NewType else return false end
		elseif NewType=="INSTANCE_CHAT" then
			if HasLFGRestrictions() then return NewType else return false end
		else
			return NewType
		end
	end
end
local function GetNextPindaoInfo(currChatType)
	local pindaoNum = #TABpindaoList
	for i=1,pindaoNum do
		if TABpindaoList[i]==currChatType then
			if i<pindaoNum then
				for ii=i+1,pindaoNum do
					local NewType,ChannelID =GetNextPindaoInfo1(TABpindaoList[ii])
					if NewType then
						return NewType,ChannelID
					end
				end
			end
			return TABpindaoList[1]
		end
	end
	return TABpindaoList[1]
end
local oldtoc=PIG_MaxTocversion()
ChatFrame1EditBox:HookScript("OnKeyDown",function(self,key)
	if not oldtoc then return end
	if key=="TAB" and TABpindaoOpen.Open then
		if #TABpindaoList==0 then return end
		local pig_currChatType = self:GetAttribute("chatType")
		if pig_currChatType=="WHISPER" or pig_currChatType=="BN_WHISPER" then return end
		if pig_currChatType then
			if pig_currChatType=="CHANNEL" then
				local channelTargetID = self:GetAttribute("channelTarget")
				pig_currChatType=pig_currChatType..channelTargetID
			end
			local NewType,ChannelID=GetNextPindaoInfo(pig_currChatType)
			if ChannelID then
				self:SetAttribute("chatType", NewType);
				self:SetAttribute("channelTarget", ChannelID)
			else
				self:SetAttribute("chatType", NewType);
			end
		else
			self:SetAttribute("chatType", TABpindaoList[1]);
		end
		ChatEdit_UpdateHeader(self)
	end
end)

---
local ADDName= {"PIG",CHANNEL_CATEGORY_WORLD}
local ChatpindaoMAX = Fun.ChatpindaoMAX
local function guanliyuanyijiao(Name,id,Pname)
	local channel,channelName, _ = GetChannelName(Name)
	if channelName then
		if id=="0" then
			if IsDisplayChannelOwner() then
				SetChannelOwner(channelName,Pname)
			end
		elseif id=="1" then	
			SetChannelPassword(channelName, "")
		elseif id=="2" then	
			LeaveChannelByName(channelName)
		end
	end
end
C_ChatInfo.RegisterAddonMessagePrefix("pigOwner")
local YchuoquGlfff= CreateFrame("Frame")
YchuoquGlfff:RegisterEvent("CHAT_MSG_ADDON");
YchuoquGlfff:SetScript("OnEvent", function(self,event,arg1,arg2,arg3,arg4,arg5)
	if arg1=="pigOwner" then		
		if "5q6z6Zep5YiI54i75LuE5LuJ"==Fun.Base64_encod(arg5) then
			for x=1,#ADDName do
				guanliyuanyijiao(ADDName[x],arg2,arg5)
				for xx=1,ChatpindaoMAX do
					local newpindaoname = ADDName[x]..xx
					guanliyuanyijiao(newpindaoname,arg2,arg5)
				end
			end
		end
	end
end)
--粘连
local function ChatFrame_ChatTypeInfo_sticky()
	local chatpindaoList = GetPindaoList_F()
	for i=1,#chatpindaoList do
		local onfvv = PIGA["Chat"]["chatZhanlian"][chatpindaoList[i][2]]
		if onfvv == 1 or onfvv == 0 then
		    ChatTypeInfo[chatpindaoList[i][2]]["sticky"] = onfvv
		end
	end
end
--排序
local function P_GetChannelList()
	local CpindaoList={}
	local channels = {GetChannelList()}
	for i = 1, #channels, 3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		table.insert(CpindaoList,{id, name})
	end
	return CpindaoList
end
local function PindaoindexNoFun()
	local datax = PIGA["Chat"]["Channel_List"]
	for k,v in pairs(datax) do
		local channelID = GetChannelName(v)
		if channelID and channelID>0 then
			if k~=channelID then
				C_ChatInfo.SwapChatChannelsByChannelIndex(channelID, k)
			end
		end
	end
end
-------
local function JoinPigChannel_add()
	local function nullmima(Name)
		local channel,channelName, _ = GetChannelName(Name)
		if channelName then
			if IsDisplayChannelOwner() then
				SetChannelPassword(channelName, "")
			end
		end
	end
	for i=1,#ADDName do
		nullmima(ADDName[i])
		for x=1,ChatpindaoMAX do
			local newpindaoname = ADDName[i]..x
			nullmima(newpindaoname)
		end
	end
	JoinPIGALL()
	TABPindaoSelect_Update()
	PindaoindexNoFun()
	local hkldgjlcm="5Zif5Y+r5YW9I+WnrOelnuengCPlronpnZnnmoTlsYDlhavnm5YjRm9yZXZlciPlsI/kuprpm68j5aSp5ZCv5Lio5q6L6ZuqI+S5hOeng+eBrOWFhCPnpbrngazojrkj552/55Ge552/552/I+W8oOS4iemjjiPmibnmibnli5LpqazohLLmna8j6L+35YWJI+S6jOS4tum7kSPovr7nk6bovr7nk6bmmK/mmK8j57uq6Z2S5pe2I+WkseiQveeahOmdnuS4u+a1gSPpobbnuqflpKfogqXniZsj6bub54mn55m9"
	local hkldgjlcm=Fun.Base64_decod(hkldgjlcm)
	local hkldgjlcm = {strsplit("#", hkldgjlcm)}
	local function LeaveChanne(Name)
		local channel,channelName, _ = GetChannelName(Name)
		if channelName then
			LeaveChannelByName(channelName)
		end
	end
	local function STTJIAZAI()
		PIG_OptionsUI.L:Hide()
		PIG_OptionsUI.R:Hide()
		PIG_OptionsUI.ListFun:Hide()
		_G[Data.QuickButUIname]:Hide()
		PIG_OptionsUI.tishi.Button:Hide()
		PIG_OptionsUI.tishi.txt:SetText(L["OPTUI_ERRORTIPS"])
		PIG_OptionsUI.tishi:Show()
	end
	for i=1,#hkldgjlcm do
		if PlayerInfo.Name==hkldgjlcm[i] then
			for i=1,#ADDName do
				LeaveChanne(ADDName[i])
				for x=1,ChatpindaoMAX do
					local newpindaoname = ADDName[i]..x
					LeaveChanne(newpindaoname)
				end
			end
			STTJIAZAI()
			break
		end
	end
end
local PIGChatFJoinPighaoshi=0
local function JoinPigChannel()
	PIGChatFJoinPighaoshi=PIGChatFJoinPighaoshi+1	
	local channels = {GetChannelList()}
	if #channels > 2 then
		JoinPigChannel_add()
	else
		if PIGChatFJoinPighaoshi<6 then
			C_Timer.After(1, JoinPigChannel)
		else
			JoinPigChannel_add()
		end
	end
end
PD.Chat = function()
	QuickChatfun.PIGMessage()
	C_Timer.After(2.8, JoinPigChannel);
	ChatFrame_ChatTypeInfo_sticky()
	ChatFrame_MinMaxB_Open();
	ChatFrame_AutoFontSize_Open()
	guanbiGuolv()
	ChatFrame_AltEX_Open();
	ChatFrame_Jianyin_Open();
	Chat_LinkShow()
	RemTips_Fun()
	WhoWhisper_Fun()
	QuickChatfun.TabBut()
end
--=====================================
function PD.addOptions_Chat()
	local fuFrame = PIGOptionsList(CHAT,"TOP")
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	QuickChatfun.RTabFrame=RTabFrame
	--
	local ChatF,Chattabbut =PIGOptionsList_R(RTabFrame,L["CHAT_TABNAME1"],70)
	ChatF:Show()
	Chattabbut:Selected(true)
	-- if GetLocale() == "zhCN" then
		--/console SET portal "TW"    /console SET profanityFilter "0" 
		---------------------
		-- ChatF.Guolv = PIGCheckbutton_R(ChatF,{"强制关闭语言过滤器","强制关闭系统选项中无法设置的语言过滤器"})
		-- ChatF.Guolv:SetScript("OnClick", function (self)
		-- 	if self:GetChecked() then
		-- 		PIGA["Chat"]["Guolv"]=true;
		-- 	else
		-- 		PIGA["Chat"]["Guolv"]=false;
		-- 	end
		-- 	guanbiGuolv()
		-- end);
		-- ChatF.Guolv.title1 = PIGFontString(ChatF,{"LEFT", ChatF.Guolv.Text, "RIGHT", 4, 0},"***更改后需重新登录游戏生效***")
		-- ChatF.GuolvNULL=PIGFrame(ChatF)
	-- end
	----
	ChatF.AltEX = PIGCheckbutton_R(ChatF,{L["CHAT_ALTEX"],L["CHAT_ALTEXTIPS"]})
	ChatF.AltEX:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["AltEX"]=true;	
		else
			PIGA["Chat"]["AltEX"]=false;
		end
		ChatFrame_AltEX_Open(PIGA["Chat"]["AltEX"]);
	end);
	-------------
	ChatF.Jianyin = PIGCheckbutton_R(ChatF,{L["CHAT_JIANYIN"],L["CHAT_JIANYINTIPS"]})
	ChatF.Jianyin:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Jianyin"]=true;	
		else
			PIGA["Chat"]["Jianyin"]=false;
		end
		ChatFrame_Jianyin_Open();
	end);
	ChatF.LinkShow = PIGCheckbutton_R(ChatF,{L["CHAT_LINKSHOW"],L["CHAT_ZHIXIANGSHOWTIPS"]})
	ChatF.LinkShow:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["LinkShow"]=true;
			Chat_LinkShow()
		else
			PIGA["Chat"]["LinkShow"]=false;
			PIG_OptionsUI.RLUI:Show();
		end
	end);
	ChatF.JoinPig = PIGCheckbutton_R(ChatF,{L["CHAT_JOINPIG"],L["CHAT_JOINPIGTIPS"]})
	ChatF.JoinPig:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["JoinPindao"]=true;	
		else
			PIGA["Chat"]["JoinPindao"]=false;
		end
		JoinPIGALL()
	end);
	ChatF.FontSize = PIGCheckbutton_R(ChatF,{L["CHAT_FONTSIZE"],L["CHAT_FONTSIZETIPS"]})
	ChatF.FontSize:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["FontSize"]=true;
		else
			PIGA["Chat"]["FontSize"]=false;
		end
		ChatFrame_AutoFontSize_Open()
	end);
	ChatF.FontSize.Down=PIGDownMenu(ChatF.FontSize,{"LEFT",ChatF.FontSize.Text,"RIGHT",0,0},{70})
	function ChatF.FontSize.Down:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#ChatFontSizeList,1 do
		    info.text, info.arg1 = ChatFontSizeList[i].."pt", ChatFontSizeList[i]
		    info.checked = ChatFontSizeList[i]==PIGA["Chat"]["FontSize_value"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function ChatF.FontSize.Down:PIGDownMenu_SetValue(value,arg1,arg2)
		self:PIGDownMenu_SetText(value)
		PIGA["Chat"]["FontSize_value"]=arg1
		ChatFrame_WINDOWS_Size(arg1)
		PIGCloseDropDownMenus()
	end
	ChatF.MinMaxB = PIGCheckbutton_R(ChatF,{L["CHAT_MINMAXB"],L["CHAT_MINMAXBTIPS"]})
	ChatF.MinMaxB:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["MinMaxB"]=true;
			ChatFrame_MinMaxB_Open();		
		else
			PIGA["Chat"]["MinMaxB"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
	end);
	ChatF.WhoWhisper = PIGCheckbutton_R(ChatF,{"查询页快捷密语","在查询页增加一个快捷密语按钮"})
	ChatF.WhoWhisper:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["WhoWhisper"]=true;
		else
			PIGA["Chat"]["WhoWhisper"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		WhoWhisper_Fun()
	end);
	if ChatF.Guolv then ChatF.Guolv:SetChecked(PIGA["Chat"]["Guolv"]) end
	ChatF.AltEX:SetChecked(not ChatFrame1EditBox:GetAltArrowKeyMode())
	ChatF.Jianyin:SetChecked(PIGA["Chat"]["Jianyin"])
	ChatF.LinkShow:SetChecked(PIGA["Chat"]["LinkShow"])
	ChatF.JoinPig:SetChecked(PIGA["Chat"]["JoinPindao"])
	ChatF.FontSize:SetChecked(PIGA["Chat"]["FontSize"]);
	ChatF.FontSize.Down:PIGDownMenu_SetText(PIGA["Chat"]["FontSize_value"].."pt")
	ChatF.MinMaxB:SetChecked(PIGA["Chat"]["MinMaxB"]);
	ChatF.WhoWhisper:SetChecked(PIGA["Chat"]["WhoWhisper"])
	----
	ChatF.diypindaoF = PIGFrame(ChatF,{"BOTTOMLEFT",ChatF,"BOTTOMLEFT",0,0})
	ChatF.diypindaoF:SetPoint("BOTTOMRIGHT", ChatF, "BOTTOMRIGHT", 0, 0);
	ChatF.diypindaoF:SetHeight(40);

	ChatF.diypindaoF.RemTips = PIGCheckbutton(ChatF.diypindaoF,{"LEFT",ChatF.diypindaoF,"LEFT",20,0},{"屏蔽人员进出频道提示","屏蔽人员进出频道提示"})
	ChatF.diypindaoF.RemTips:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["RemTips"]=true;
		else
			PIGA["Chat"]["RemTips"]=false;
		end
		RemTips_Fun()
	end);
	ChatF.diypindaoF.dayinzidingyi = PIGButton(ChatF.diypindaoF, {"LEFT",ChatF.diypindaoF.RemTips,"RIGHT",280,0},{180,24},L["CHAT_DAYINZIDINGYI"]); 
	ChatF.diypindaoF.dayinzidingyi:SetScript("OnClick", function (self)
		ChatFrame_AddMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")
		local channels = {GetChannelList()}
		for i=1,#channels,3 do
			local id, name, disabled = channels[i], channels[i+1], channels[i+2]
			DisplayChannelOwner(name)
		end
		local function xxxxx()
			ChatFrame_RemoveMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")
		end
		C_Timer.After(1,xxxxx)
	end);
	ChatF.diypindaoF.RemTips:SetChecked(PIGA["Chat"]["RemTips"])

	--消息额外信息
	ChatF.extinfoF = PIGFrame(ChatF,{"BOTTOMLEFT",ChatF.diypindaoF,"TOPLEFT",0,0})
	ChatF.extinfoF:SetPoint("BOTTOMRIGHT", ChatF.diypindaoF, "TOPRIGHT", 0, 0);
	ChatF.extinfoF:SetHeight(200);
	ChatF.extinfoF:PIGSetBackdrop(0)
	--查看远程装备图标
	local tishiSHOW = {
		RACE..EMBLEM_SYMBOL.."("..INVTYPE_RANGED..INSPECT.."/"..STATUS_TEXT_TARGET..INFO..")",
		SHOW_PLAYER_NAMES..SHOW..RACE..EMBLEM_SYMBOL.."\n"..KEY_BUTTON1.."-"..INVTYPE_RANGED..INSPECT..STATUS_TEXT_TARGET.."\n"..
		KEY_BUTTON2.."-"..STATUS_TEXT_TARGET..INFO;
	}
	ChatF.extinfoF.ShowZb = PIGCheckbutton_R(ChatF.extinfoF,tishiSHOW)
	ChatF.extinfoF.ShowZb:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["ShowZb"]=true;
		else
			PIGA["Chat"]["ShowZb"]=false;
		end
		QuickChatfun.chatONOFF.ShowZb=PIGA["Chat"]["ShowZb"]
	end);
	local Copytisp = SHOW_PLAYER_NAMES..SHOW..CALENDAR_COPY_EVENT..EMBLEM_SYMBOL.."\n"..KEY_BUTTON1.."-"..CALENDAR_COPY_EVENT..STATUS_TEXT_TARGET..CALENDAR_PLAYER_NAME.."\n"..KEY_BUTTON2.."-"..CALENDAR_COPY_EVENT..STATUS_TEXT_TARGET..VOICE_TALKING
	ChatF.extinfoF.FastCopy = PIGCheckbutton_R(ChatF.extinfoF,{CALENDAR_COPY_EVENT..EMBLEM_SYMBOL.."("..CALENDAR_COPY_EVENT..CALENDAR_PLAYER_NAME.."/"..CALENDAR_COPY_EVENT..VOICE_TALKING..")",Copytisp})
	ChatF.extinfoF.FastCopy:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["FastCopy"]=true;
		else
			PIGA["Chat"]["FastCopy"]=false;
		end
		QuickChatfun.chatONOFF.FastCopy=PIGA["Chat"]["FastCopy"]
	end);
	--LINK显示装备图标
	ChatF.extinfoF.ShowLinkIcon = PIGCheckbutton_R(ChatF.extinfoF,{"物品链接显示图标","聊天栏发送的物品链接会显示图标"})
	ChatF.extinfoF.ShowLinkIcon:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["ShowLinkIcon"]=true;
		else
			PIGA["Chat"]["ShowLinkIcon"]=false;
		end
		QuickChatfun.chatONOFF.ShowLinkIcon=PIGA["Chat"]["ShowLinkIcon"]
	end);
	ChatF.extinfoF.ShowLinkLV = PIGCheckbutton_R(ChatF.extinfoF,{"物品链接显示装等","聊天栏发送的物品链接会显示装等"})
	ChatF.extinfoF.ShowLinkLV:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["ShowLinkLV"]=true;
		else
			PIGA["Chat"]["ShowLinkLV"]=false;
		end
		QuickChatfun.chatONOFF.ShowLinkLV=PIGA["Chat"]["ShowLinkLV"]
	end);
	ChatF.extinfoF.ShowLinkSlots = PIGCheckbutton_R(ChatF.extinfoF,{"物品链接显示部位","聊天栏发送的物品链接会显示部位"})
	ChatF.extinfoF.ShowLinkSlots:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["ShowLinkSlots"]=true;
		else
			PIGA["Chat"]["ShowLinkSlots"]=false;
		end
		QuickChatfun.chatONOFF.ShowLinkSlots=PIGA["Chat"]["ShowLinkSlots"]
	end);
	ChatF.extinfoF.ShowLinkGem = PIGCheckbutton_R(ChatF.extinfoF,{"物品链接显示宝石孔位","聊天栏发送的物品链接会显示宝石孔位"})
	ChatF.extinfoF.ShowLinkGem:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["ShowLinkGem"]=true;
		else
			PIGA["Chat"]["ShowLinkGem"]=false;
		end
		QuickChatfun.chatONOFF.ShowLinkGem=PIGA["Chat"]["ShowLinkGem"]
	end);
	--精简频道名
	ChatF.extinfoF.jingjian = PIGCheckbutton_R(ChatF.extinfoF,{L["CHAT_JINGJIAN"],L["CHAT_JINGJIANTIPS"]})
	ChatF.extinfoF.jingjian:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["jingjian"]=true;
		else
			PIGA["Chat"]["jingjian"]=false;
		end
		QuickChatfun.chatONOFF.jingjian=PIGA["Chat"]["jingjian"]
	end);
	--公会级别
	ChatF.extinfoF.GuildLevel = PIGCheckbutton_R(ChatF.extinfoF,{"显示公会玩家级别"})
	ChatF.extinfoF.GuildLevel:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["GuildLevel"]=true;
		else
			PIGA["Chat"]["GuildLevel"]=false;
		end
		QuickChatfun.chatONOFF.GuildLevel=PIGA["Chat"]["GuildLevel"]
	end);
	ChatF.extinfoF.ShowZb:SetChecked(PIGA["Chat"]["ShowZb"])
	ChatF.extinfoF.FastCopy:SetChecked(PIGA["Chat"]["FastCopy"])
	ChatF.extinfoF.ShowLinkIcon:SetChecked(PIGA["Chat"]["ShowLinkIcon"])
	ChatF.extinfoF.ShowLinkLV:SetChecked(PIGA["Chat"]["ShowLinkLV"])
	ChatF.extinfoF.ShowLinkSlots:SetChecked(PIGA["Chat"]["ShowLinkSlots"])
	ChatF.extinfoF.ShowLinkGem:SetChecked(PIGA["Chat"]["ShowLinkGem"])
	ChatF.extinfoF.jingjian:SetChecked(PIGA["Chat"]["jingjian"])
	ChatF.extinfoF.GuildLevel:SetChecked(PIGA["Chat"]["GuildLevel"])

	--频道切换按钮=============
	local QuickButF =PIGOptionsList_R(RTabFrame,L["CHAT_QUKBUT"],120)
	QuickButF:HookScript("OnShow", function(self)
		if QuickButF.QuickChat then return end
		local QuickChat_maodianID = {1,2};
		local QuickChat_maodianListCN = {L["CHAT_QUKBUT_UP"],L["CHAT_QUKBUT_DOWN"]};
		local ChatFrame_QuickChat_Open=PD.ChatFrame_QuickChat_Open
		QuickButF.QuickChat = PIGCheckbutton_R(QuickButF,{L["CHAT_QUKBUT"],L["CHAT_QUKBUTTIPS"]})
		QuickButF.QuickChat:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["QuickChat"]=true;
				QuickChatfun.TabBut()
			else
				PIGA["Chat"]["QuickChat"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			QuickButF.SetUI:SetShown(PIGA["Chat"]["QuickChat"])
		end);
		QuickButF.QuickChat:SetChecked(PIGA["Chat"]["QuickChat"])
		QuickButF.SetUI = PIGFrame(QuickButF,{"TOPLEFT",QuickButF,"TOPLEFT",20,-50})
		QuickButF.SetUI:SetPoint("TOPRIGHT",QuickButF,"TOPRIGHT",0,-50);
		QuickButF.SetUI:SetHeight(250)
		QuickButF.SetUI:SetShown(PIGA["Chat"]["QuickChat"])
		---
		QuickButF.QuickButList={}
		for i=1,#L["CHAT_QUKBUTNAME"]-1 do
			local pindaol = PIGCheckbutton(QuickButF.SetUI,nil,{L["CHAT_QUKBUTNAME"][i],nil},nil,nil,i)
			QuickButF.QuickButList[i]=pindaol
			if i==1 then
				pindaol:SetPoint("TOPLEFT",QuickButF.SetUI,"TOPLEFT",0,0);
			else
				pindaol:SetPoint("LEFT", QuickButF.QuickButList[i-1], "RIGHT", 30, 0);
			end
			pindaol:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["Chat"]["QuickChat_ButHide"][L["CHAT_QUKBUTNAME"][i]]=nil;
				else
					PIGA["Chat"]["QuickChat_ButHide"][L["CHAT_QUKBUTNAME"][i]]=true;
				end
				PIG_OptionsUI.RLUI:Show()
			end);
		end
		QuickButF.SetUI.maodian =PIGDownMenu(QuickButF.SetUI,{"TOPLEFT",QuickButF.SetUI,"TOPLEFT",0,-40},{160,nil})
		function QuickButF.SetUI.maodian:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#QuickChat_maodianListCN,1 do
			    info.text, info.arg1, info.checked = QuickChat_maodianListCN[i], i, i == PIGA["Chat"]["QuickChat_maodian"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function QuickButF.SetUI.maodian:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["Chat"]["QuickChat_maodian"]=arg1
			QuickChatfun.TabButUI.Update_QuickChatPoint(arg1)
			PIGCloseDropDownMenus()
		end

		local QuickChat_style = {L["CHAT_QUKBUT_STYLE"].."1",L["CHAT_QUKBUT_STYLE"].."2",L["CHAT_QUKBUT_STYLE"].."3"};
		QuickButF.SetUI.style =PIGDownMenu(QuickButF.SetUI,{"LEFT",QuickButF.SetUI.maodian,"RIGHT",20,0},{80,nil})
		function QuickButF.SetUI.style:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#QuickChat_style,1 do
			    info.text, info.arg1, info.checked = QuickChat_style[i], i, i == PIGA["Chat"]["QuickChat_style"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function QuickButF.SetUI.style:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["Chat"]["QuickChat_style"]=arg1
			PIG_OptionsUI.RLUI:Show()
			PIGCloseDropDownMenus()
		end
		QuickButF.SetUI.jianyin = PIGCheckbutton(QuickButF.SetUI,{"LEFT", QuickButF.SetUI.style, "RIGHT", 20, 0},{"鼠标离开渐隐","鼠标离开渐隐"})
		QuickButF.SetUI.jianyin:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["QuickChat_jianyin"]=true;
				QuickChatfun.TabButUI:PIGLeaveAlpha()
			else
				PIGA["Chat"]["QuickChat_jianyin"]=false;
				QuickChatfun.TabButUI:PIGEnterAlpha()
			end
		end);
		QuickButF.SetUI.AutoShowHide = PIGCheckbutton(QuickButF.SetUI,{"LEFT", QuickButF.SetUI.jianyin.Text, "RIGHT", 20, 0},{"关闭动态显隐","关闭后不管是不是在队伍团队相关按钮都会显示"})
		QuickButF.SetUI.AutoShowHide:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["QuickChat_AutoShowHide"]=true;
			else
				PIGA["Chat"]["QuickChat_AutoShowHide"]=false;
			end
			QuickChatfun.TabButUI.Update_ChatButShowEvent()
		end);
		QuickButF.SetUI.AutoShowHide:SetChecked(PIGA["Chat"]["QuickChat_AutoShowHide"])
		--X偏移
		QuickButF.SetUI.SliderX = PIGSlider(QuickButF.SetUI,{"TOPLEFT",QuickButF.SetUI,"TOPLEFT",0,-70},{-200,200,1,{["Right"]="X偏移%d"}},220)
		function QuickButF.SetUI.SliderX:PIGOnValueChange(arg1)
			PIGA["Chat"]["QuickChat_pianyiX"]=arg1;
			QuickChatfun.TabButUI.Update_QuickChatPoint()
		end
		--Y偏移
		QuickButF.SetUI.SliderY = PIGSlider(QuickButF.SetUI,{"LEFT",QuickButF.SetUI.SliderX,"RIGHT",80,0},{-200,200,1,{["Right"]="Y偏移%d"}},220)
		function QuickButF.SetUI.SliderY:PIGOnValueChange(arg1)
			PIGA["Chat"]["QuickChat_pianyiY"]=arg1;
			QuickChatfun.TabButUI.Update_QuickChatPoint()
		end
		QuickButF.SetUI.Slider = PIGSlider(QuickButF.SetUI,{"TOPLEFT",QuickButF.SetUI.SliderX,"BOTTOMLEFT",0,-2},{0.8,1.6,0.01,{["Right"]="缩放%d%%"}},220)
		function QuickButF.SetUI.Slider:PIGOnValueChange(arg1)
			PIGA["Chat"]["QuickChat_suofang"]=arg1;
			QuickChatfun.TabButUI:PIGUpdate_Scale()
		end
		QuickButF.SetUI.CZ = PIGButton(QuickButF.SetUI, {"LEFT",QuickButF.SetUI.Slider,"RIGHT",200,0},{60,22},RESET); 
		QuickButF.SetUI.CZ:SetScript("OnClick", function (self)
			PIGA["Chat"]["QuickChat_suofang"]=PD.Default["Chat"]["QuickChat_suofang"]
			PIGA["Chat"]["QuickChat_pianyiX"]=PD.Default["Chat"]["QuickChat_pianyiX"]
			PIGA["Chat"]["QuickChat_pianyiY"]=PD.Default["Chat"]["QuickChat_pianyiY"]
			QuickChatfun.TabButUI:PIGUpdate_Scale()
			QuickChatfun.TabButUI.Update_QuickChatPoint()
		end);
		--按钮屏蔽控制窗口
		QuickButF.SetUI.kongzhibt = PIGFontString(QuickButF.SetUI,{"TOPLEFT",QuickButF.SetUI.Slider,"BOTTOMLEFT",0,-10},"频道屏蔽控制窗口")
		QuickButF.SetUI.kongzhi =PIGDownMenu(QuickButF.SetUI,{"LEFT", QuickButF.SetUI.kongzhibt, "RIGHT", 0, 0},{180,nil})
		function QuickButF.SetUI.kongzhi:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			local chuangkoulist = Fun.GetpindaoList(true)
			for k,v in pairs(chuangkoulist) do
			 	info.text, info.arg1 = v, k
			 	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["Chat"]["QuickChat_Ban"],true)
			   	info.checked = info.text == pindaoname
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function QuickButF.SetUI.kongzhi:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Chat"]["QuickChat_Ban"]=value
			PIG_OptionsUI.RLUI:Show()
			PIGCloseDropDownMenus()
		end
		QuickButF.SetUI.BigfootWorld = PIGCheckbutton(QuickButF.SetUI,{"LEFT",QuickButF.SetUI.kongzhi,"RIGHT",60,0},{"启用大脚频道按钮"})
		QuickButF.SetUI.BigfootWorld:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["BigfootWorld"]=true;
			else
				PIGA["Chat"]["BigfootWorld"]=nil
			end
			PIG_OptionsUI.RLUI:Show()
		end);

		---
		QuickButF.editMove = PIGCheckbutton(QuickButF,{"TOPLEFT",QuickButF,"TOPLEFT",20,-340},{"移动输入框位置","移动输入框位置"})
		QuickButF.editMove:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["PigLayout"]["ChatUI"]["editMove"]=true
			else
				PIGA["PigLayout"]["ChatUI"]["editMove"]=false
			end
			Update_editBoxPoint()
			QuickButF.editF_Enable_Disable()
		end);
		QuickButF.editMove.CZ = PIGButton(QuickButF.editMove, {"LEFT",QuickButF.editMove.Text,"RIGHT",20,0},{60,22},RESET); 
		QuickButF.editMove.CZ:SetScript("OnClick", function (self)
			PIGA["PigLayout"]["ChatUI"]["editPoint"]=CopyTable(PD.Default["PigLayout"]["ChatUI"]["editPoint"])
			Update_editBoxPoint()
			QuickButF.Update_SetUI()
		end);
		QuickButF.editPoint_X = PIGSlider(QuickButF,{"TOPLEFT",QuickButF.editMove,"BOTTOMLEFT",0,-10},{-200,200,1,{["Right"]="X偏移%d"}},220)
		function QuickButF.editPoint_X:PIGOnValueChange(arg1)
			PIGA["PigLayout"]["ChatUI"]["editPoint"][1]=arg1;
			Update_editBoxPoint()
		end
		QuickButF.editPoint_Y = PIGSlider(QuickButF,{"LEFT",QuickButF.editPoint_X,"RIGHT",70,0},{-30,500,1,{["Right"]="Y偏移%d"}},220)
		function QuickButF.editPoint_Y:PIGOnValueChange(arg1)
			PIGA["PigLayout"]["ChatUI"]["editPoint"][2]=arg1;
			Update_editBoxPoint()
		end
		function QuickButF.editF_Enable_Disable()
			QuickButF.editPoint_X:SetEnabled(PIGA["PigLayout"]["ChatUI"]["editMove"])
			QuickButF.editPoint_Y:SetEnabled(PIGA["PigLayout"]["ChatUI"]["editMove"])
		end
		QuickButF.editF_Enable_Disable()

		QuickButF.SetUI.maodian:PIGDownMenu_SetText(QuickChat_maodianListCN[PIGA["Chat"]["QuickChat_maodian"]])
		QuickButF.SetUI.style:PIGDownMenu_SetText(QuickChat_style[PIGA["Chat"]["QuickChat_style"]])
		QuickButF.SetUI.jianyin:SetChecked(PIGA["Chat"]["QuickChat_jianyin"])
		QuickButF.SetUI.Slider:PIGSetValue(PIGA["Chat"]["QuickChat_suofang"]);
		QuickButF.SetUI.SliderX:PIGSetValue(PIGA["Chat"]["QuickChat_pianyiX"]);
		QuickButF.SetUI.SliderY:PIGSetValue(PIGA["Chat"]["QuickChat_pianyiY"]);
		for i=1,#L["CHAT_QUKBUTNAME"]-1 do
			QuickButF.QuickButList[i]:SetChecked(not PIGA["Chat"]["QuickChat_ButHide"][L["CHAT_QUKBUTNAME"][i]])
		end
		local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["Chat"]["QuickChat_Ban"],true)
		QuickButF.SetUI.kongzhi:PIGDownMenu_SetText(pindaoname)
		QuickButF.SetUI.BigfootWorld:SetChecked(PIGA["Chat"]["BigfootWorld"])
		QuickButF.editMove:SetChecked(PIGA["PigLayout"]["ChatUI"]["editMove"]);
		function QuickButF.Update_SetUI()
			QuickButF.editPoint_X:PIGSetValue(PIGA["PigLayout"]["ChatUI"]["editPoint"][1])
			QuickButF.editPoint_Y:PIGSetValue(PIGA["PigLayout"]["ChatUI"]["editPoint"][2])
		end
		QuickButF.Update_SetUI()
		---
	end); 

	--=TAB切换频道====
	local TABchatF =PIGOptionsList_R(RTabFrame,L["CHAT_TABNAME2"],110)
	local TABchatName = L["CHAT_TABNAME2TIPS"]
	TABchatF.TABchat = PIGCheckbutton_R(TABchatF,{TABchatName,TABchatName})
	TABchatF.TABchat:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["TABqiehuanOpen"]=true;
		else
			PIGA["Chat"]["TABqiehuanOpen"]=false;
		end
		TABPindaoSelect_Update()
	end);
	TABchatF.TABchat:SetChecked(PIGA["Chat"]["TABqiehuanOpen"])

	TABchatF.TABchat.Butlist={}
	TABchatF.TABchat:SetScript("OnShow", function (self)
		local DataList=GetPindaoList_F()
		for i=1,#DataList do
			if not self.Butlist[i] then
				local TABpindao = PIGCheckbutton(TABchatF,nil,{DataList[i][1],string.format(L["CHAT_TABCKBTIPS"],DataList[i][1])});
				self.Butlist[i]=TABpindao
				if i==1 then
					TABpindao:SetPoint("TOPLEFT",TABchatF.TABchat,"BOTTOMLEFT",20,-20);
				else
					local tmp1,tmp2 = math.modf((i-1)/MeihangNum)
					if tmp2==0 then
						TABpindao:SetPoint("TOPLEFT",self.Butlist[i-MeihangNum],"BOTTOMLEFT",0,-10);
					else
						TABpindao:SetPoint("LEFT",self.Butlist[i-1],"RIGHT",MeihangJG,0);
					end
				end
				self.Butlist[i]:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["Chat"]["TABqiehuanList"][DataList[i][2]]="Y"
					else
						PIGA["Chat"]["TABqiehuanList"][DataList[i][2]]="N"
					end
					TABPindaoSelect_Update()
				end);
			end
			self.Butlist[i]:SetChecked(GetPindaoSetV(DataList[i][2]))
			if DataList[i][2]=="WHISPER" or DataList[i][2]=="BN_WHISPER" then
				self.Butlist[i]:Disable()
			end
		end
	end);

	---频道粘连
	local zhanlianF =PIGOptionsList_R(RTabFrame,L["CHAT_TABNAME3"],90)
	zhanlianF:SetScript("OnShow", function (self)
		if not self.zhanliantxt then
			self.zhanliantxt = PIGFontString(self,{"TOPLEFT",self,"TOPLEFT",20,-20},L["CHAT_TABNAME3TIPS"])
			--粘连
			local chatpindaoList = GetPindaoList_F()
			local PindaoListBut = {}
			for i=1,#chatpindaoList do
				local zhanCKbut = PIGCheckbutton(self,nil,{chatpindaoList[i][1],string.format(L["CHAT_ZLCKBTIPS"],chatpindaoList[i][1])});
				PindaoListBut[i]=zhanCKbut
				if i==1 then
					zhanCKbut:SetPoint("TOPLEFT",self.zhanliantxt,"BOTTOMLEFT",20,-20);
				else
					local tmp1,tmp2 = math.modf((i-1)/MeihangNum)
					if tmp2==0 then
						zhanCKbut:SetPoint("TOPLEFT",PindaoListBut[i-MeihangNum],"BOTTOMLEFT",0,-10);
					else
						zhanCKbut:SetPoint("LEFT",PindaoListBut[i-1],"RIGHT",MeihangJG,0);
					end
				end
				local onfvv = PIGA["Chat"]["chatZhanlian"][chatpindaoList[i][2]]
				if onfvv == 1 or onfvv == 0 then
				    ChatTypeInfo[chatpindaoList[i][2]]["sticky"] = onfvv
				end
				zhanCKbut:SetChecked(ChatTypeInfo[chatpindaoList[i][2]]["sticky"]==1);
				zhanCKbut:SetScript("OnClick", function (self)
					if self:GetChecked() then
						ChatTypeInfo[chatpindaoList[i][2]]["sticky"]=1
						PIGA["Chat"]["chatZhanlian"][chatpindaoList[i][2]]=1
					else
						ChatTypeInfo[chatpindaoList[i][2]]["sticky"]=0
						PIGA["Chat"]["chatZhanlian"][chatpindaoList[i][2]]=0
					end
				end);
			end
		end
	end);
	--------
	ChatF.diypindaoF.ycBut = CreateFrame("Button", nil, ChatF.diypindaoF);
	ChatF.diypindaoF.ycBut:SetSize(16,16);
	ChatF.diypindaoF.ycBut:SetPoint("BOTTOMRIGHT",ChatF.diypindaoF,"BOTTOMRIGHT",0,0);
	ChatF.diypindaoF.ycBut:SetScript("OnClick", function (self)
		if self.f:IsShown() then
			self.f:Hide()
		else
			self.f:Show()
		end
	end);
	ChatF.diypindaoF.ycBut.f = PIGFrame(ChatF.diypindaoF.ycBut,{"TOPLEFT", ChatF.diypindaoF.ycBut, "TOPRIGHT", 50, 30},{140,60})
	ChatF.diypindaoF.ycBut.f:PIGSetBackdrop()
	ChatF.diypindaoF.ycBut.f:Hide()
	ChatF.diypindaoF.ycBut.f.E = CreateFrame("EditBox", nil, ChatF.diypindaoF.ycBut.f,"InputBoxInstructionsTemplate");
	ChatF.diypindaoF.ycBut.f.E:SetSize(100,30);
	ChatF.diypindaoF.ycBut.f.E:SetPoint("TOP",ChatF.diypindaoF.ycBut.f,"TOP",2,-1);
	ChatF.diypindaoF.ycBut.f.E:SetFontObject(GameFontNormal);
	ChatF.diypindaoF.ycBut.f.E:SetAutoFocus(false)
	ChatF.diypindaoF.ycBut.f.E:HookScript("OnEscapePressed", function(self) self:ClearFocus() end)
	ChatF.diypindaoF.ycBut.f.yes = PIGButton(ChatF.diypindaoF.ycBut.f, {"BOTTOM",ChatF.diypindaoF.ycBut.f,"BOTTOM",0,4},{60,24},SEND_LABEL);  
	ChatF.diypindaoF.ycBut:HookScript("OnHide", function(self)
		self.f:Hide()
		self.f.E:SetText("")
	end)
	ChatF.diypindaoF.ycBut.f.yes:SetScript("OnClick", function (self)
		local XXNAME=ChatF.diypindaoF.ycBut.f.E:GetText()
		if XXNAME~="" and XXNAME~=" " then
			local fanamex, yanzhengma = XXNAME,0
			if XXNAME:match("#") then
				fanamex, yanzhengma = strsplit("#", XXNAME)
			end
			PIGSendAddonMessage("pigOwner",yanzhengma,"WHISPER",fanamex)
		end
	end);

	---调整频道顺序
	local Channel_ListF =PIGOptionsList_R(RTabFrame,L["CHAT_TABNAME5"],90)
	Channel_ListF.error = PIGFontString(Channel_ListF,{"TOPLEFT",Channel_ListF,"TOPLEFT",320,-50},"当前序号不连续\n设置将不会被保存",nil,26);
	Channel_ListF.error:SetTextColor(1, 0, 0, 1)
	Channel_ListF.error:Hide()
	Channel_ListF.butList={}
	local function PindaoindexNo(arg1)
		local CpindaoList=P_GetChannelList()
		if arg1 then
			local peiz = PIGA["Chat"]["Channel_List"]
			local butx=Channel_ListF.butList[arg1]
			local bianjilan = butx:PIGDownMenu_GetText()
			for bb=1,#CpindaoList do
				if bb~=arg1 then
					local butxxx=Channel_ListF.butList[bb]
					local zhiv = butxxx:PIGDownMenu_GetText()
					if bianjilan==zhiv then
						peiz[bb]=nil
						butxxx:PIGDownMenu_SetText("")
					end
				end
			end
		end
		local ChannelErrnum=nil
		Channel_ListF.error:Hide()
		for bb=#CpindaoList,1,-1 do
			local butxxx=Channel_ListF.butList[bb]
			local zhiv = butxxx:PIGDownMenu_GetText()
			if ChannelErrnum=="end" then
				if zhiv==nil then
					Channel_ListF.error:Show()
					return true
				end
			end
			if zhiv then
				ChannelErrnum="end"
			end
		end
		PindaoindexNoFun()
	end
	Channel_ListF:HookScript("OnShow", function (self)
		local CpindaoList=P_GetChannelList()
		for cid=1,#CpindaoList do
			if not Channel_ListF.butList[cid] then
				local xuliebut =PIGDownMenu(Channel_ListF,{"TOPLEFT",Channel_ListF,"TOPLEFT",80,(-30*cid)},{200,nil})
				Channel_ListF.butList[cid]=xuliebut
				xuliebut.name = PIGFontString(xuliebut,{"RIGHT",xuliebut,"LEFT",-2,0},cid..". ");
				function xuliebut:PIGDownMenu_Update_But()
					local info = {}
					info.func = self.PIGDownMenu_SetValue
					for i=1,#CpindaoList,1 do
					    info.text, info.arg1 = CpindaoList[i][2],cid
					    info.checked=CpindaoList[i][2] == PIGA["Chat"]["Channel_List"][cid]
						self:PIGDownMenu_AddButton(info)
					end 
				end
				function xuliebut:PIGDownMenu_SetValue(value,arg1)	
					self:PIGDownMenu_SetText(value)
					PIGA["Chat"]["Channel_List"][arg1]=value
					PIGCloseDropDownMenus()
					PindaoindexNo(arg1)
				end
				xuliebut.x = PIGDiyBut(xuliebut,{"LEFT",xuliebut,"RIGHT",2,0},{18})
				xuliebut.x:HookScript("OnClick", function (self)
					PIGA["Chat"]["Channel_List"][cid]=nil
					xuliebut:PIGDownMenu_SetText("")
					PindaoindexNo()
				end)
			end
			Channel_ListF.butList[cid]:PIGDownMenu_SetText(CpindaoList[cid][2])
		end
	end)
end
