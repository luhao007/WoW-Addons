local addonName, PD = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub
local gmatch = _G.string.gmatch
local match = _G.string.match
local upper = _G.string.upper
local L=PD.locale
local Fun=PD.Fun
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
local Key_fenge=Fun.Key_fenge
local Key_hebing=Fun.Key_hebing
local del_LinkEmojiPun=Fun.del_LinkEmojiPun
local ReplaceEmoji=Fun.ReplaceEmoji
local GetRaceClassTXT=Fun.GetRaceClassTXT
local PIGGetColorKey=Fun.PIGGetColorKey
------------
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton = Create.PIGButton
local PIGDiyBut = Create.PIGDiyBut
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
local PIGSetFont=Create.PIGSetFont
--===============================
local AudioData=PD.Audio.Data.FollowMsg
local BlackList = {["BlackName"]=true,["FilterRepeat"]=true,["IGNORE_DND"]=true,["Precise"]=false,
	["Ignore_P"]={},["word"]={},["chongfu"]={},["count"]=0,["OKcount"]=0,
	["name_count"]=0,["chongfu_count"]=0,["word_count"]=0
}
local function FilterBlack_Chongfu(chongfuData,newText,chatbox)
	local time = GetServerTime()
	for i=#chongfuData,1,-1 do
		if (time-chongfuData[i][1])>60 then
			table.remove(chongfuData,i)
		end
	end
	for i=1,#chongfuData do
		if newText==chongfuData[i][2] and chatbox==chongfuData[i][3] then
			return true
		end
	end
	chongfuData[#chongfuData+1]={time,newText,chatbox}
	return false
end
local function FilterBlack_IsFriend(name,name1)
	if name or name1 then
		local numWoWOnline = C_FriendList.GetNumOnlineFriends();
		for id=1,numWoWOnline do
			local info = C_FriendList.GetFriendInfoByIndex(id);
			if info.name==name or info.name==name1 then return true end
		end
		local _, numBNetOnline = BNGetNumFriends();
		for id=1,numBNetOnline do
			local numGameAccounts = C_BattleNet.GetFriendNumGameAccounts(id);
			for Accid=1,numGameAccounts do
				local _, characterName, client = C_BattleNet.GetFriendGameAccountInfo(id, Accid);
				if client==BNET_CLIENT_WOW then
					if characterName==name or characterName==name1 then return true end
				end
			end
		end
	end
	return false
end
Fun.IsFriend=FilterBlack_IsFriend
local function FilterBlack_Name(name)
	if name then
		for i=1,#BlackList.Ignore_P do
			if BlackList.Ignore_P[i]==name then
				return true
			end
		end
	end
	return false
end
local function FilterBlack_Key_1(zuheBL,newText)
	for xx=1,#zuheBL do
		if not newText:match(zuheBL[xx]) then
			return false
		end
	end
	return true
end
local function FilterBlack_Key(newText)
	local blnum = #BlackList["word"]
	if blnum>0 then
		for x=1,blnum do
			if type(BlackList["word"][x])=="string" then
				if newText:match(BlackList["word"][x]) then
					return true 
				end
			elseif type(BlackList["word"][x])=="table" then
				if FilterBlack_Key_1(BlackList["word"][x],newText) then
					return true 
				end
			end
		end
	end
	return false
end
--------------------
local QuickChatfun=PD.QuickChatfun
function QuickChatfun.QuickBut_miyijiluGL(arg2,arg5,arg1,arg6)
	if PIGisSecret(arg1) then return false end
	if arg2~=PlayerInfo.AllName then
		if FilterBlack_IsFriend(arg2,arg5) then
			return false
		end
		if BlackList["BlackName"] and FilterBlack_Name(arg2) then
			return true
		end
		if BlackList["IGNORE_DND"] and arg6=="DND" then
			return true 
		end
		if FilterBlack_Key(del_LinkEmojiPun(arg1)) then
			return true 
		end
		return false
	end
	return false
end
function QuickChatfun.QuickBut_Keyword()
	PIGA["Chat"]["Tiqu"]["Audio"]=PD.Audio.IsAudioNumMaxV(PIGA["Chat"]["Tiqu"]["Audio"],AudioData)
	local QuickUI=QuickChatfun.TabButUI
	QuickUI.Keyword=QuickUI:ADD_chatbutExt("interface/common/voicechat-on.blp",2,-4,-7.5, 0,
		"|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..SETTINGS..CHAT..INFO..L["CHAT_FILTERS"]..
		"|r\n|cff00FFff"..KEY_BUTTON2.."-|r|cffFFFF00"..ENABLE.."/"..CLOSE..L["CHAT_KEYWORD_NAME1"]..
		"|r\n|cff00FFffShift+"..KEY_BUTTON1.."-|r|cffFFFF00"..ENABLE.."/"..CLOSE..L["CHAT_FILTERS"].."|r")
	
	QuickUI.Keyword:SetScript("OnClick", function(self,button)
		self.ClickShowTab(button)	
	end);
	function QuickUI.Keyword.ClickShowTab(button,name_server)
		QuickUI.Keyword.add_uifun()
		local SetUI = _G["PIG_ChatKeyWordSet"]
		if button=="AddIgnore" then
			SetUI:Show()
		 	SetUI.SetIgnoreTab(name_server)
		elseif button=="LeftButton" then
			if SetUI:IsShown() then
				SetUI:Hide()
			else
				SetUI:Show()
			end
		else
			if IsShiftKeyDown() then
				PIGA["Chat"]["Filter"]["Open"] = not PIGA["Chat"]["Filter"]["Open"]
				QuickUI.Keyword:FilterKeysFun()
			else
				PIGA["Chat"]["Tiqu"]["Open"] = not PIGA["Chat"]["Tiqu"]["Open"]
				QuickUI.Keyword:TiquKeysFun()
			end
			if SetUI:IsShown() then
				SetUI:Hide()
				SetUI:Show()
			end
		end
	end
	----
	local TiquCanshu = {
		["KeywordF_x"]={0,56,0,56},
		["ToBotBut"]={"minimal-scrollbar-arrow-returntobottom","minimal-scrollbar-arrow-returntobottom-down","minimal-scrollbar-arrow-returntobottom","minimal-scrollbar-arrow-returntobottom-over"},
	}
	if PIG_MaxTocversion() then 
		TiquCanshu["KeywordF_x"]={0,56,-14,56} 
		TiquCanshu["ToBotBut"]={"interface/chatframe/ui-chaticon-scrollend-up.blp","interface/chatframe/ui-chaticon-scrollend-down.blp","interface/chatframe/ui-chaticon-scrollend-disabled.blp","interface/chatframe/ui-chaticon-blinkhilight.blp"}
	end
	TiquCanshu["jichengBlack"]=PIGA["Chat"]["Tiqu"]["jichengBlack"]
	TiquCanshu["AudioOpen"]=PIGA["Chat"]["Tiqu"]["AudioOpen"]
	TiquCanshu["Audio"]=PIGA["Chat"]["Tiqu"]["Audio"]
	TiquCanshu["ChatWox"]=PIGA["Chat"]["Tiqu"]["ChatWox"]
	TiquCanshu["shuchumode"]=PIGA["Chat"]["Tiqu"]["shuchumode"]
	TiquCanshu["tiquOKFlash"]=PIGA["Chat"]["Tiqu"]["tiquOKFlash"]
	local TiqumorenColor={0,0,0,0.4}
	--单独提取框
	local ChatF99 = CreateFrame("ScrollingMessageFrame", "PIG_ChatFrameKeyWord", UIParent, "ChatFrameTemplate")
	ChatF99:SetHeight(PIGA["Chat"]["Tiqu"]["KeywordFHeight"] or 180);
	ChatF99:SetFrameStrata("LOW")
	ChatF99:EnableMouse(false)
	ChatF99:UnregisterAllEvents()
	ChatF99:SetHyperlinksEnabled(true)--可点击
	--ChatF99:Clear() -- 清除框架中的消息 
	--ChatF99:SetFadeDuration(seconds)--设置淡入淡出持续时间 
	--ChatF99:SetTimeVisible(seconds)--设置消息显示时间
	--ChatF99:SetFading(false)--淡入淡出
	--ChatF99:SetMaxLines(999) --设置可显示最大行数
	--ChatF99:SetInsertMode(TOP or BOTTOM) --设置新消息的插入位置
	--ChatF99:SetToplevel(true)--单击子项时框架是否应自行升起
	--ChatF99:EnableMouseWheel(false)-- 禁用鼠标滚动
	local function SetFontSize()
		if PIGA["Chat"]["FontSize"] then
			FCF_SetChatWindowFontSize(nil, ChatF99, PIGA["Chat"]["FontSize_value"])
		else
			local _,fontSize = GetChatWindowInfo(1);
			if fontSize>0 then
				FCF_SetChatWindowFontSize(nil, ChatF99, fontSize)
			end
		end
	end
	C_Timer.After(3,SetFontSize)

	ChatF99:SetPoint("BOTTOMLEFT",ChatFrame1,"TOPLEFT",TiquCanshu["KeywordF_x"][1],TiquCanshu["KeywordF_x"][2]);
	ChatF99:SetPoint("BOTTOMRIGHT",ChatFrame1,"TOPRIGHT",TiquCanshu["KeywordF_x"][3],TiquCanshu["KeywordF_x"][4]);
	ChatF99.Background = ChatF99:CreateTexture(nil, "BACKGROUND");
	ChatF99.Background:SetTexture("Interface/ChatFrame/ChatFrameBackground");
	ChatF99.Background:SetPoint("TOPLEFT",ChatF99,"TOPLEFT",-2,2);
	ChatF99.Background:SetPoint("BOTTOMRIGHT",ChatF99,"BOTTOMRIGHT",15,-2);
	ChatF99.Background:SetVertexColor(unpack(PIGA["Chat"]["Tiqu"]["BgColor"] or TiqumorenColor))

	ChatF99.ScrollToBottomButton = CreateFrame("Button",nil,ChatF99, "TruncatedButtonTemplate");
	ChatF99.ScrollToBottomButton:SetNormalTexture(TiquCanshu["ToBotBut"][1])
	ChatF99.ScrollToBottomButton:SetPushedTexture(TiquCanshu["ToBotBut"][2])
	ChatF99.ScrollToBottomButton:SetDisabledTexture(TiquCanshu["ToBotBut"][3])
	ChatF99.ScrollToBottomButton:SetHighlightTexture(TiquCanshu["ToBotBut"][4]);
	if PIG_MaxTocversion() then
		ChatF99.ScrollToBottomButton:SetSize(24,24);
		ChatF99.ScrollToBottomButton.Flash = ChatF99.ScrollToBottomButton:CreateTexture(nil,"OVERLAY");
		ChatF99.ScrollToBottomButton.Flash:SetTexture("interface/chatframe/ui-chaticon-blinkhilight.blp");
		ChatF99.ScrollToBottomButton.Flash:SetSize(24,24);
		ChatF99.ScrollToBottomButton.Flash:SetPoint("CENTER", 0, 0);
		ChatF99.ScrollToBottomButton.Flash:Hide();
	else
		ChatF99.ScrollToBottomButton:SetSize(17,15);
		ChatF99.ScrollBar:ClearAllPoints();
		ChatF99.ScrollBar:SetPoint("TOPRIGHT",ChatF99.Background,"TOPRIGHT",-6,-4);
		ChatF99.ScrollBar:SetPoint("BOTTOMRIGHT",ChatF99.Background,"BOTTOMRIGHT",-6,24);
	end
	ChatF99.ScrollToBottomButton:SetPoint("BOTTOMRIGHT",ChatF99.Background,"BOTTOMRIGHT",-1,6);
	ChatF99.ScrollToBottomButton:Hide()
	ChatF99.ScrollToBottomButton:SetScript("OnClick", function (self)
		PlaySound(SOUNDKIT.IG_CHAT_BOTTOM);
		local ggff = self:GetParent()
		ggff:ScrollToBottom();
		if PIG_MaxTocversion() then
			self:Hide();
			self.Flash:Hide();
		else
			FCF_FadeOutScrollbar(ggff)
		end
	end);
	ChatF99:SetScript("OnMouseWheel", function(self, delta)
		local numMessages  = self:GetNumMessages();
		if numMessages==0 then return end
		ChatF99.ScrollToBottomButton:Show()
		FCF_FadeInScrollbar(self)
		if delta == 1 then
			if PIG_MaxTocversion() then
				self.ScrollToBottomButton:Show();
				self.ScrollToBottomButton.Flash:Show();
			else
				self.ScrollToBottomButton:SetNormalTexture(TiquCanshu["ToBotBut"][4])
			end
			self:ScrollUp()
		elseif delta == -1 then
			self:ScrollDown()
			if self:GetScrollOffset()==0 then
				if PIG_MaxTocversion() then
					self.ScrollToBottomButton:Hide();
					self.ScrollToBottomButton.Flash:Hide();
				else
					FCF_FadeOutScrollbar(self)
					self.ScrollToBottomButton:SetNormalTexture(TiquCanshu["ToBotBut"][1])
				end
			end
		end
	end)
	ChatF99:SetScript("OnUpdate", function(self, elapsedSec)
		local flash = self.ScrollToBottomButton.Flash;
		if ( not flash ) then return;end
		if PIG_MaxTocversion() then
			if ( self:AtBottom() ) then
				if ( flash:IsShown() ) then
					flash:Hide();
				end
				return;
			end
			local flashTimer = self.flashTimer + elapsedSec;
			if ( flashTimer < CHAT_BUTTON_FLASH_TIME ) then
				self.flashTimer = flashTimer;
				return;
			end
			while ( flashTimer >= CHAT_BUTTON_FLASH_TIME ) do
				flashTimer = flashTimer - CHAT_BUTTON_FLASH_TIME;
			end
			self.flashTimer = flashTimer;

			if ( flash:IsShown() ) then
				flash:Hide();
			else
				flash:Show();
			end
		else
			local shouldFlash = not self:AtBottom();
			if shouldFlash ~= UIFrameIsFlashing(flash) then
				if shouldFlash then
					UIFrameFlash(flash, .1, .1, -1, false, CHAT_BUTTON_FLASH_TIME, CHAT_BUTTON_FLASH_TIME);
					FCF_FadeInScrollbar(self);
				else
					UIFrameFlashStop(flash);
				end
			end
		end
	end)
	----=======
	local White_keywords={}
	local White_keywords_2={}
	local function zairuKeyFun()
		wipe(White_keywords)
		wipe(White_keywords_2)
		for k,v in pairs(PIGA["Chat"]["Tiqu"]["KeysList"]) do
			White_keywords[k]=v
			if k:match("#") or k:match("&") then
				local dict = {}
				for prefix, char in string.gmatch(k, "([#&])([^#&]+)") do
				    dict[char] = (prefix == "#")
				end
				White_keywords_2[k]=dict
			end
		end
	end
	zairuKeyFun()
	local TardisGetMsg=Data.Tardis.GetMsg
	local Show_MSG_TIMECD = 0
	local CHANNELinfo = ChatTypeInfo["CHANNEL"];
	local _ReplaceIconAndGroupExpressions=C_ChatInfo and C_ChatInfo.ReplaceIconAndGroupExpressions or ChatFrame_ReplaceIconAndGroupExpressions
	local MsgFastCopyShowZb=QuickChatfun.MsgFastCopyShowZb
	local RepeatMsgData={}
	local function replaceWithColor_1(text, searchKey)
	    return text:gsub(searchKey:gsub("%a", function(c)
	        return "[" .. c:upper() .. c:lower() .. "]"
	    end), "|cff00FF00%0|r")
	end
	local linkPattern = "(|c[^|]-|H[^:]-:.-|h%[.-%]|h|r)"
	local function replaceWithColor(text, searchKey)
	    local linkCache = {}
	    local cleanText = text:gsub(linkPattern, function(link)
	        table.insert(linkCache, link)
	        return "\001" .. #linkCache .. "\001"
	    end)
	    local i = 0
	    local finalText = replaceWithColor_1(cleanText, searchKey):gsub("\001(%d+)\001", function()
	        i = i + 1
	        return linkCache[i]
	    end)
	    return finalText
	end
	local function ColoringKeywords(txtmsg,key,isbiao)
		if not txtmsg then return "" end
		if isbiao then
			for k,v in pairs(key) do
				if v then
					txtmsg=replaceWithColor(txtmsg, k)
				end
			end
		else
			txtmsg=replaceWithColor(txtmsg, key)
		end
		return txtmsg
	end
	local function _GetColoredName(...)
		if ChatFrameUtil and ChatFrameUtil.GetDecoratedSenderName then
			return ChatFrameUtil.GetDecoratedSenderName(...)
		else
			return GetColoredName(...)
		end
	end
	local function Export_KeywordMSG(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
		local timetxt=GetServerTime()
		local outMsg = _ReplaceIconAndGroupExpressions(arg1, arg17, not ChatFrame_CanChatGroupPerformExpressionExpansion("CHANNEL"));
		local outMsg = ReplaceEmoji(outMsg)
		local coloredName = _GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		local PlayerLink = MsgFastCopyShowZb(arg12,GetPlayerLink(arg2, ("[%s]"):format(coloredName)),true)
		if TiquCanshu["shuchumode"]==1 then
			local shuchatf = _G["ChatFrame"..TiquCanshu["ChatWox"]]
			if TiquCanshu["tiquOKFlash"] then
				if GeneralDockManager.selected~=shuchatf then
					FCF_StartAlertFlash(shuchatf);
				end
			end
			local outMsg = "|cff828282"..date("%H:%M",timetxt).."|r [|cff00FF00关注|r] "..PlayerLink..":  "..outMsg
			shuchatf:AddMessage(outMsg, CHANNELinfo.r, CHANNELinfo.g, CHANNELinfo.b, CHANNELinfo.id);
		elseif TiquCanshu["shuchumode"]==2 then
			local outMsg = "|cff828282"..date("%H:%M",timetxt).."|r "..PlayerLink..":  "..outMsg
			ChatF99:AddMessage(outMsg, CHANNELinfo.r, CHANNELinfo.g, CHANNELinfo.b, CHANNELinfo.id);
		end
		if not InCombatLockdown() and timetxt-Show_MSG_TIMECD>30 then
			Show_MSG_TIMECD=timetxt
			if TiquCanshu["AudioOpen"] then
				PIG_PlaySoundFile(AudioData[TiquCanshu["Audio"]]);
			end
		end
	end
	QuickUI.Keyword:HookScript("OnEvent", function (self,event,...)
		if event == "PLAYER_REGEN_DISABLED" then
			ChatF99:Hide()
		elseif event == "PLAYER_REGEN_ENABLED" then
			ChatF99:Show()
		else
			if TiquCanshu["shuchumode"]==2 or TiquCanshu["shuchumode"]==1 and TiquCanshu["ChatWox"]>0 then
				local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17=...
				if PIGisSecret(arg1) then return false end
				if not arg12 then return end
				if arg9=="MeetingHorn" then return end
				if arg9=="PIG" then return end		
				for i=1,#TardisGetMsg do
					if arg1==TardisGetMsg[i] then return end
				end
				if arg2==PlayerInfo.AllName then return end--自身不过滤
				if TiquCanshu["jichengBlack"] then
					if FilterBlack_Name(arg2) or arg6=="DND" then
						return
					end
				end
				local newText = del_LinkEmojiPun(arg1)
				if TiquCanshu["jichengBlack"] then
					if FilterBlack_Key(newText) or FilterBlack_Chongfu(RepeatMsgData,newText,"tiqu") then
						return
					end
				end
				for key,open in pairs(White_keywords) do
					if open then
						if White_keywords_2[key] then
							local allOK=true
							for key1,open1 in pairs(White_keywords_2[key]) do
								local okfou = not not newText:match(key1)
								if okfou~=open1 then
									allOK=false
									break
								end
							end
							if allOK then
								return Export_KeywordMSG(event, ColoringKeywords(arg1,White_keywords_2[key],true), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
							end
						else
							if newText:match(key) then
								return Export_KeywordMSG(event, ColoringKeywords(arg1,key), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
							end
						end
					end
				end
			end
		end
	end)
	function QuickUI.Keyword:TiquKeysFun()
		self:UnregisterEvent("CHAT_MSG_CHANNEL");
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		ChatF99:Hide()
		if PIGA["Chat"]["Tiqu"]["Open"] then
			QuickUI.Keyword.X:Hide()
			self:RegisterEvent("CHAT_MSG_CHANNEL");
			if TiquCanshu["shuchumode"]==2 then
				if PIGA["Chat"]["Tiqu"]["CombatHide"] then
					self:RegisterEvent("PLAYER_REGEN_DISABLED")
					self:RegisterEvent("PLAYER_REGEN_ENABLED");
					if not InCombatLockdown() then ChatF99:Show() end
				else
					ChatF99:Show() 
				end
			end
		else
			QuickUI.Keyword.X:Show()
		end
	end
	QuickUI.Keyword:TiquKeysFun()

	-----========
	BlackList["BlackName"]=PIGA["Chat"]["Filter"]["BlackName"]
	BlackList["IGNORE_DND"]=PIGA["Chat"]["Filter"]["IGNORE_DND"]
	BlackList["FilterRepeat"]=PIGA["Chat"]["Filter"]["FilterRepeat"]
	BlackList["Precise"]=PIGA["Chat"]["Filter"]["Precise"]
	BlackList["word"]=PIGA["Chat"]["Filter"]["BlacksList"]

	local function FilterBlack(self,event,arg1,arg2,arg3,arg4,arg5,arg6)
		if PIGisSecret(arg1) then return false end	
		if self==ChatFrame2 or self==ChatFrame3 then return false end
		if arg2~=PlayerInfo.AllName then--自身不过滤
			BlackList["count"]=BlackList["count"]+1
			if event=="CHAT_MSG_WHISPER" then
				if FilterBlack_IsFriend(arg2,arg5) then
					return false
				end
			end
			if BlackList["BlackName"] and FilterBlack_Name(arg5) then
				BlackList["name_count"]=BlackList["name_count"]+1
				return true
			end
			if BlackList["IGNORE_DND"] and arg6=="DND" then
				BlackList["name_count"]=BlackList["name_count"]+1
				return true 
			end
			local newText = del_LinkEmojiPun(arg1)
			if FilterBlack_Key(newText) then
				BlackList["word_count"]=BlackList["word_count"]+1
				return true 
			end
			if BlackList["FilterRepeat"] and FilterBlack_Chongfu(BlackList["chongfu"],newText,self) then
				BlackList["chongfu_count"]=BlackList["chongfu_count"]+1
				return true
			end
			BlackList["OKcount"]=BlackList["OKcount"]+1
		end
		return false
	end
	--
	BlackList.Ignore_P=PIGA["Chat"]["Filter"]["Ignore_P"]
	local function IsNameExis(namely)
		for i=#PIGA["Chat"]["Filter"]["Ignore_P"],1,-1 do
			if PIGA["Chat"]["Filter"]["Ignore_P"][i]==namely then
				return true
			end
		end
		return false
	end
	local addtipT = FormatLocalStr(ERR_IGNORE_ADDED_S)
	local FrameUIxxx = CreateFrame("Frame")
	FrameUIxxx.players=nil
	FrameUIxxx.tipslist={}
	FrameUIxxx.Pending=false
	FrameUIxxx.UpdateShowList=function() end
	FrameUIxxx:HookScript("OnEvent", function (self,event,arg1)
		if arg1 and PIGisSecret(arg1) then return end
		if event=="PLAYER_ENTERING_WORLD" then
			local IgnoresNum = C_FriendList.GetNumIgnores()
			for i=1,IgnoresNum do
				local name = C_FriendList.GetIgnoreName(i);
				if name and not IsNameExis(name) then
					table.insert(PIGA["Chat"]["Filter"]["Ignore_P"],name)
				end
			end
			BlackList.Ignore_P=PIGA["Chat"]["Filter"]["Ignore_P"]
			FrameUIxxx.UpdateShowList()
		elseif event=="CHAT_MSG_SYSTEM" then
			local playerx
			if arg1==ERR_IGNORE_FULL then
				playerx=FrameUIxxx.players or PD.Temp.Ignoresplayer
			elseif arg1:match(addtipT) then
				playerx=arg1:gsub(addtipT, "")
			end
			if playerx then
				if IsNameExis(playerx) then
					DEFAULT_CHAT_FRAME:AddMessage("<"..playerx..">已在"..addonName..IGNORE_LIST, 1, 0, 0);
					FrameUIxxx.players=nil
					PD.Temp.Ignoresplayer=nil
					return 
				end
				table.insert(PIGA["Chat"]["Filter"]["Ignore_P"],playerx)
				DEFAULT_CHAT_FRAME:AddMessage("<|cffffffff"..playerx.."|r>"..LFG_LIST_APP_INVITE_ACCEPTED..addonName..IGNORE_LIST.."|Hgarrmission:-997:"..playerx.."|h[|cffFF0000备注原因|r]", 1, 1, 0);
				FrameUIxxx.players=nil
				PD.Temp.Ignoresplayer=nil
				BlackList.Ignore_P=PIGA["Chat"]["Filter"]["Ignore_P"]
				FrameUIxxx.UpdateShowList()
			end
		elseif event=="GROUP_ROSTER_UPDATE" then
			if IsInGroup() then
				if self.Pending then return end
			    self.Pending = true
			    C_Timer.After(1, function()
			        self.Pending = false
					for k,v in pairs(FrameUIxxx.tipslist) do
						v[1]=false
					end
					for p=1,MAX_RAID_MEMBERS do
						local name = GetRaidRosterInfo(p);
						if name then
							if FrameUIxxx.tipslist[name] then
								FrameUIxxx.tipslist[name][1]=true
							else
								FrameUIxxx.tipslist[name]={true,false}
							end
						end
					end
					for k,v in pairs(FrameUIxxx.tipslist) do
						if not v[1] then FrameUIxxx.tipslist[k]=nil end
					end
					for name,data in pairs(FrameUIxxx.tipslist) do
						if PIGA["Chat"]["Filter"]["Ignore_N"][name] and not data[2] then
							data[2]=true
							local msg="|cffFF0000发现"..L["CHAT_BLACK_NAME"]..PLAYER.."|r<|cffFFFFFF"..name.."|r>("..PIGA["Chat"]["Filter"]["Ignore_N"][name]..")"
							PIGErrorMsg(msg, "R")
							PIGprint(msg)
						end
					end
				end)
			else
				wipe(FrameUIxxx.tipslist)
			end
		end
	end)
	hooksecurefunc("SetItemRef", function(text, link, button)
		if button=="RightButton" then
			local _, namex = strsplit(":", text)
			if namex then FrameUIxxx.players=namex end
		end
	end)
	function QuickUI.Keyword:FilterKeysFun(setck)
		ChatFrameUtil.RemoveMessageEventFilter("CHAT_MSG_CHANNEL", FilterBlack)
		ChatFrameUtil.RemoveMessageEventFilter("CHAT_MSG_YELL", FilterBlack)
		ChatFrameUtil.RemoveMessageEventFilter("CHAT_MSG_SAY",FilterBlack)
		ChatFrameUtil.RemoveMessageEventFilter("CHAT_MSG_WHISPER",FilterBlack)
		if PIGA["Chat"]["Filter"]["Open"] then
			FrameUIxxx:RegisterEvent("PLAYER_ENTERING_WORLD");
			FrameUIxxx:RegisterEvent("CHAT_MSG_SYSTEM")
			FrameUIxxx:RegisterEvent("GROUP_ROSTER_UPDATE")
			if PIGA["Chat"]["Filter"]["FBneiNO"] and IsInInstance() then
				if setck then PIGErrorMsg("|cffFF0000"..CLOSE.."|r"..INFO..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"]) end
				return 
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"] then
				ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_CHANNEL", FilterBlack)
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"] then
				ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_YELL", FilterBlack)
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"] then
				ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_SAY", FilterBlack)
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"] then
				ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_WHISPER", FilterBlack)
			end
			if setck then PIGErrorMsg("|cff00FF00"..ENABLE.."|r"..INFO..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"]) end
		else
			FrameUIxxx:UnregisterEvent("PLAYER_ENTERING_WORLD");
			FrameUIxxx:UnregisterEvent("CHAT_MSG_SYSTEM")
			FrameUIxxx:UnregisterEvent("GROUP_ROSTER_UPDATE")
			if setck then PIGErrorMsg("|cffFF0000"..CLOSE.."|r"..INFO..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"]) end
		end
	end
	QuickUI.Keyword:FilterKeysFun()
	----
	function QuickUI.Keyword.add_uifun()
		if _G["PIG_ChatKeyWordSet"] then return end
		local UIname,Width,Height,biaotiH  = "PIG_ChatKeyWordSet",500, 510, 21
		local KeywordF=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,60},{Width,Height},UIname,true)
		KeywordF:PIGSetBackdrop()
		KeywordF:PIGClose()
		KeywordF:PIGSetMovableNoSave()
		KeywordF:SetFrameLevel(10)
		KeywordF.title = PIGFontString(KeywordF,{"TOP", KeywordF, "TOP", 0, -3},CHAT..INFO..L["CHAT_FILTERS"])
		KeywordF.F=PIGOptionsList_RF(KeywordF,21,"Left",{0,0,0})
		---提取
		local TiquF,TiquTabBut=PIGOptionsList_R(KeywordF.F,L["CHAT_KEYWORD_NAMETAB"],60,"Left")
		TiquF:Show()
		TiquTabBut:Selected(true)

		TiquF.KeyOpen = PIGCheckbutton(TiquF,{"TOPLEFT",TiquF,"TOPLEFT",20,-20},{"|cff00FF00"..ENABLE.."|r"..L["CHAT_KEYWORD_NAME1"]..L["CHAT_KEYWORD_NAME"]..INFO})
		TiquF.KeyOpen:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Tiqu"]["Open"]=true
			else
				PIGA["Chat"]["Tiqu"]["Open"]=false
			end
			QuickUI.Keyword:TiquKeysFun()
			TiquF:Options_SetFun()
		end);
		---
		TiquF.NR=PIGFrame(TiquF,{"TOPLEFT",TiquF,"TOPLEFT",0,-50});
		TiquF.NR:SetPoint("BOTTOMRIGHT",TiquF,"BOTTOMRIGHT",0,0);
		TiquF.NR.keyListCheck={}
		function TiquF.NR:ADDkeyListCheck()
			for _,but in pairs(TiquF.NR.keyListCheck) do
				but:Hide()
				but.Text:SetText("")
			end
			local index=0
			for k,v in pairs(PIGA["Chat"]["Tiqu"]["KeysList"]) do
				index=index+1
				if not TiquF.NR.keyListCheck[index] then
					local keyListCheck = PIGCheckbutton(TiquF.NR,nil,nil,{15})
					TiquF.NR.keyListCheck[index]=keyListCheck
					if index==1 then
						keyListCheck:SetPoint("TOPLEFT",TiquF.NR,"TOPLEFT",30,0);
					else
						local tmp1,tmp2 = math.modf((index-1)/2)
						if tmp2~=0 then
							keyListCheck:SetPoint("LEFT",TiquF.NR.keyListCheck[index-1],"RIGHT",200,0);
						else
							keyListCheck:SetPoint("TOPLEFT",TiquF.NR.keyListCheck[index-2],"BOTTOMLEFT",0,-6);
						end
					end
					keyListCheck:SetScript("OnClick", function (self)
						if self:GetChecked() then
							PIGA["Chat"]["Tiqu"]["KeysList"][self.keys]=true
						else
							PIGA["Chat"]["Tiqu"]["KeysList"][self.keys]=false
						end
						zairuKeyFun()
						TiquF.NR:ADDkeyListCheck()
					end);
					keyListCheck.Del =PIGDiyBut(keyListCheck,{"LEFT",keyListCheck.Text,"RIGHT",0,0},{16});
					keyListCheck.Del:SetScript("OnClick", function(self)
						PIGA["Chat"]["Tiqu"]["KeysList"][self:GetParent().keys]=nil
						zairuKeyFun()
						TiquF.NR:ADDkeyListCheck()
						TiquF.NR.EditF.error:SetText("")
					end)
				end
				TiquF.NR.keyListCheck[index].keys=k
				TiquF.NR.keyListCheck[index]:Show()
				TiquF.NR.keyListCheck[index].Text:SetText(k)
				TiquF.NR.keyListCheck[index]:SetChecked(PIGA["Chat"]["Tiqu"]["KeysList"][k])
			end
		end
		TiquF.NR:ADDkeyListCheck()
		---
		TiquF.NR.EditF = PIGFrame(TiquF.NR);
		TiquF.NR.EditF:PIGSetBackdrop(0)
		TiquF.NR.EditF:SetPoint("TOPLEFT",TiquF.NR,"TOPLEFT",100,-170);
		TiquF.NR.EditF:SetSize(200,20)
		TiquF.NR.EditF.Title = PIGFontString(TiquF.NR.EditF,{"RIGHT",TiquF.NR.EditF,"LEFT",0,0},"添加关键字:")
		TiquF.NR.EditF.E = CreateFrame("EditBox", nil, TiquF.NR.EditF)
		TiquF.NR.EditF.E:SetPoint("TOPLEFT",TiquF.NR.EditF,"TOPLEFT",6,-2);
		TiquF.NR.EditF.E:SetPoint("BOTTOMRIGHT",TiquF.NR.EditF,"BOTTOMRIGHT",-4,0);
		TiquF.NR.EditF.E:SetWidth(TiquF.NR.EditF:GetWidth()-24)
		PIGSetFont(TiquF.NR.EditF.E,14,"OUTLINE")
		TiquF.NR.EditF.E:SetTextColor(0.6, 0.6, 0.6, 1)
		TiquF.NR.EditF.E:SetAutoFocus(false)
		TiquF.NR.EditF.E:SetMaxLetters(14)
		TiquF.NR.EditF.E:EnableMouse(true)
		TiquF.NR.EditF.E.tishi = PIGFontString(TiquF.NR.EditF.E,{"TOPLEFT",TiquF.NR.EditF.E,"TOPLEFT",2,-0},L["CHAT_KEYWORD_1"]);
		TiquF.NR.EditF.E.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
		TiquF.NR.EditF.E:SetScript("OnTextChanged", function(self)
			TiquF.NR.EditF:EditBoxError()
		end);
		TiquF.NR.EditF.E:SetScript("OnEscapePressed", function(self)
			self:ClearFocus()
			self:SetTextColor(0.6, 0.6, 0.6, 1)
			self:SetText("")
			TiquF.NR.EditF.error:SetText("")
			TiquF.NR.EditF.SaveBut:Hide()
		end);
		TiquF.NR.EditF.E:HookScript("OnEditFocusGained", function(self)
			self:SetTextColor(1, 1, 1, 1);
			TiquF.NR.EditF:EditBoxError()
		end);
		TiquF.NR.EditF.E:SetScript("OnEnterPressed", function(self)
			TiquF.NR.EditF:IsKeyExist()
		end);
		TiquF.NR.EditF.SaveBut = PIGButton(TiquF.NR.EditF,{"LEFT",TiquF.NR.EditF,"RIGHT",2,0},{60,22},ADD)
		TiquF.NR.EditF.SaveBut:Hide()
		TiquF.NR.EditF.SaveBut:SetScript("OnClick", function(self)
			TiquF.NR.EditF:IsKeyExist()
		end)
		TiquF.NR.EditF.error=PIGFontString(TiquF.NR.EditF,{"BOTTOMLEFT",TiquF.NR.EditF,"TOPLEFT",4,2})
		TiquF.NR.EditF.error:SetTextColor(1, 0, 0, 1)
		TiquF.NR.EditF.tishi=PIGFontString(TiquF.NR.EditF,{"TOPLEFT",TiquF.NR.EditF,"BOTTOMLEFT",4,-2},L["CHAT_KEYWORD_NAME2"])
		TiquF.NR.EditF.tishi:SetJustifyH("LEFT");
		TiquF.NR.EditF.tishi:SetTextColor(0, 1, 0, 1)
		function TiquF.NR.EditF:EditBoxError()
			self.SaveBut:Hide()
			self.error:SetText("")
			local txtv = self.E:GetText():gsub(" ", ""):upper()
			if txtv=="" then
				self.E.tishi:Show()
				self.E:SetTextColor(0.6, 0.6, 0.6, 1)
			else
				self.E.tishi:Hide()
				self.E:SetTextColor(1, 1, 1, 1)
				local allnum=0
				for k,v in pairs(PIGA["Chat"]["Tiqu"]["KeysList"]) do
					if k==txtv then
						self.error:SetText(L["LIB_COLLERR1"])
						return
					end
					allnum=allnum+1
				end
				if allnum>=14 then
					self.error:SetText("关注关键字已满，请先删除一些")
					return
				end
				self.SaveBut:Show()	
			end
		end
		function TiquF.NR.EditF:IsKeyExist()
			local value = self.E:GetText():gsub(" ", ""):upper()
			local allnum=0
			for k,v in pairs(PIGA["Chat"]["Tiqu"]["KeysList"]) do
				allnum=allnum+1
			end
			if allnum>14 then
				self.error:SetText("关注关键字已满，请先删除一些")
				return
			end
			PIGA["Chat"]["Tiqu"]["KeysList"][value]=true
		 	zairuKeyFun()
			TiquF.NR:ADDkeyListCheck()
			self.E:SetText("")
			self.E:ClearFocus()
		end
		--------
		TiquF.NR.tiquOKAudioOpen = PIGCheckbutton(TiquF.NR,{"TOPLEFT",TiquF.NR,"TOPLEFT",20,-260},{L["CHAT_KEYWORD_SET1"]})
		TiquF.NR.tiquOKAudioOpen:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Tiqu"]["AudioOpen"]=true
				TiquCanshu["AudioOpen"]=true
			else
				PIGA["Chat"]["Tiqu"]["AudioOpen"]=false
				TiquCanshu["AudioOpen"]=false
			end
		end);
		TiquF.NR.tiquOKAudioOpen.List=PIGDownMenu(TiquF.NR.tiquOKAudioOpen,{"LEFT",TiquF.NR.tiquOKAudioOpen.Text,"RIGHT",2,0},{180,nil})
		function TiquF.NR.tiquOKAudioOpen.List:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#AudioData,1 do
			    info.text, info.arg1 = AudioData[i][1], i
			    info.checked = i==TiquCanshu["Audio"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function TiquF.NR.tiquOKAudioOpen.List:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Chat"]["Tiqu"]["Audio"]=arg1
			TiquCanshu["Audio"]=arg1
			PIGCloseDropDownMenus()
		end
		TiquF.NR.tiquOKAudioOpen.PlayBut =PIGDiyBut(TiquF.NR.tiquOKAudioOpen,{"LEFT",TiquF.NR.tiquOKAudioOpen.List,"RIGHT",4,0},{28,28,nil,nil,"chatframe-button-icon-speaker-on",130757});
		TiquF.NR.tiquOKAudioOpen.PlayBut:SetScript("OnClick", function()
			PIG_PlaySoundFile(AudioData[TiquCanshu["Audio"]])
		end)
		--继承黑名单
		TiquF.NR.jichengBlack = PIGCheckbutton(TiquF.NR,{"TOPLEFT",TiquF.NR.tiquOKAudioOpen,"BOTTOMLEFT",0,-20},{L["CHAT_FILTERS"].."后再"..L["CHAT_KEYWORD_NAME1"],"过滤重复/勿扰/黑名单/黑名单关键字后再提取"})
		TiquF.NR.jichengBlack:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Tiqu"]["jichengBlack"]=true
				TiquCanshu["jichengBlack"]=true
			else
				PIGA["Chat"]["Tiqu"]["jichengBlack"]=false
				TiquCanshu["jichengBlack"]=false
			end
		end);
		--输出方式
		TiquF.NR.OutputModeF=PIGFrame(TiquF.NR,{"BOTTOMLEFT",TiquF.NR,"BOTTOMLEFT",4,4})
		TiquF.NR.OutputModeF:SetPoint("BOTTOMRIGHT",TiquF.NR,"BOTTOMRIGHT",-4,4);
		TiquF.NR.OutputModeF:SetHeight(80)
		TiquF.NR.OutputModeF:PIGSetBackdrop(0)
		TiquF.NR.OutputModeF.biaoti = PIGFontString(TiquF.NR.OutputModeF,{"BOTTOMLEFT",TiquF.NR.OutputModeF,"TOPLEFT",14,6},"输出方式: ")
		TiquF.NR.OutputMode_1 = PIGCheckbutton(TiquF.NR.OutputModeF,{"LEFT",TiquF.NR.OutputModeF.biaoti,"RIGHT",10,0},{"系统聊天窗口"})
		TiquF.NR.OutputMode_1:SetScript("OnClick", function (self)
			PIGA["Chat"]["Tiqu"]["shuchumode"]=1
			TiquCanshu["shuchumode"]=1
			TiquF:Options_SetFun()
			QuickUI.Keyword:TiquKeysFun()
		end);
		TiquF.NR.OutputMode_2 = PIGCheckbutton(TiquF.NR.OutputModeF,{"LEFT",TiquF.NR.OutputMode_1.Text,"RIGHT",20,0},{"独立聊天窗口"})
		TiquF.NR.OutputMode_2:SetScript("OnClick", function (self)
			PIGA["Chat"]["Tiqu"]["shuchumode"]=2
			TiquCanshu["shuchumode"]=2
			TiquF:Options_SetFun()
			QuickUI.Keyword:TiquKeysFun()
		end);
		
		TiquF.NR.OutputModeF.shuvhudaoBOX=PIGDownMenu(TiquF.NR.OutputModeF,{"TOPLEFT",TiquF.NR.OutputModeF,"TOPLEFT",140,-10},{120,nil})
		TiquF.NR.OutputModeF.shuvhudaoBOX.t = PIGFontString(TiquF.NR.OutputModeF.shuvhudaoBOX,{"RIGHT",TiquF.NR.OutputModeF.shuvhudaoBOX, "LEFT", -2,0},L["CHAT_KEYWORD_SET2"])
		local chuangkoulist = {[0]=NONE}
		local function GetpindaoList()
			local chuangkoulist = {[0]=NONE}
			for ix=1,NUM_CHAT_WINDOWS do
				local name= GetChatWindowInfo(ix);
				if name and name~="" then
					chuangkoulist[ix]=name
				end
			end
			return chuangkoulist
		end
		local function yanchizhixing()
			chuangkoulist=GetpindaoList()
			if chuangkoulist[PIGA["Chat"]["Tiqu"]["ChatWox"]] then
				TiquCanshu["ChatWox"]=PIGA["Chat"]["Tiqu"]["ChatWox"]
			end
		end
		C_Timer.After(1, yanchizhixing)
		C_Timer.After(3, yanchizhixing)
		function TiquF.NR.OutputModeF.shuvhudaoBOX:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			local chuangkoulist=GetpindaoList()
			for k,v in pairs(chuangkoulist) do
			 	info.text, info.arg1 = v, k
			 	info.checked = k ==TiquCanshu["ChatWox"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function TiquF.NR.OutputModeF.shuvhudaoBOX:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Chat"]["Tiqu"]["ChatWox"]=arg1
			TiquCanshu["ChatWox"]=arg1
			PIGCloseDropDownMenus()
		end
		TiquF.NR.OutputModeF.tiquOKFlash = PIGCheckbutton(TiquF.NR.OutputModeF,{"TOPLEFT",TiquF.NR.OutputModeF.shuvhudaoBOX.t,"BOTTOMLEFT",0,-20},{"提取成功窗口标签闪动"})
		TiquF.NR.OutputModeF.tiquOKFlash:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Tiqu"]["tiquOKFlash"]=true
				TiquCanshu["tiquOKFlash"]=true
			else
				PIGA["Chat"]["Tiqu"]["tiquOKFlash"]=false
				TiquCanshu["tiquOKFlash"]=false
			end
		end);
		---2
		TiquF.NR.OutputModeF.Color = Create.ColorBut(TiquF.NR.OutputModeF,{"TOPLEFT",TiquF.NR.OutputModeF,"TOPLEFT",30,-10},"背景颜色")
		function TiquF.NR.OutputModeF.Color:PIGinitialize()
			self.pezhiV=PIGA["Chat"]["Tiqu"]["BgColor"] or TiqumorenColor
		end
		function TiquF.NR.OutputModeF.Color:PIGSetValue(newR, newG, newB, newA)
			PIGA["Chat"]["Tiqu"]["BgColor"]={newR, newG, newB, newA}
			ChatF99.Background:SetVertexColor(newR, newG, newB, newA)
		end
		
		TiquF.NR.OutputModeF.CombatHide = PIGCheckbutton(TiquF.NR.OutputModeF,{"LEFT",TiquF.NR.OutputModeF.Color,"RIGHT",104,0},{"战斗中隐藏"})
		TiquF.NR.OutputModeF.CombatHide:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Tiqu"]["CombatHide"]=true
			else
				PIGA["Chat"]["Tiqu"]["CombatHide"]=false
			end
			QuickUI.Keyword:TiquKeysFun()
		end);
		--高度
		TiquF.NR.OutputModeF.GaoduHSlider =PIGSlider(TiquF.NR.OutputModeF,{"TOPLEFT",TiquF.NR.OutputModeF.Color,"BOTTOMLEFT",40,-10},{100,500,1})
		TiquF.NR.OutputModeF.GaoduHSlider.T = PIGFontString(TiquF.NR.OutputModeF.GaoduHSlider,{"RIGHT",TiquF.NR.OutputModeF.GaoduHSlider,"LEFT",-4,0},"高度：");
		function TiquF.NR.OutputModeF.GaoduHSlider:PIGOnValueChange(arg1)
			ChatF99:SetHeight(arg1)
			PIGA["Chat"]["Tiqu"]["KeywordFHeight"]=arg1
		end
		function TiquF:Options_SetFun()
			self.KeyOpen:SetChecked(PIGA["Chat"]["Tiqu"]["Open"])
			if PIGA["Chat"]["Tiqu"]["Open"] then
				self.NR:Show()
				self.NR.tiquOKAudioOpen:SetChecked(PIGA["Chat"]["Tiqu"]["AudioOpen"])
				self.NR.tiquOKAudioOpen.List:PIGDownMenu_SetText(AudioData[TiquCanshu["Audio"]][1])
				self.NR.jichengBlack:SetChecked(PIGA["Chat"]["Tiqu"]["jichengBlack"])
				self.NR.OutputMode_2:SetChecked(TiquCanshu["shuchumode"]==2)
				self.NR.OutputMode_1:SetChecked(TiquCanshu["shuchumode"]==1)
				self.NR.OutputModeF.shuvhudaoBOX:SetShown(TiquCanshu["shuchumode"]==1)
				self.NR.OutputModeF.tiquOKFlash:SetShown(TiquCanshu["shuchumode"]==1)
				self.NR.OutputModeF.Color:SetShown(TiquCanshu["shuchumode"]==2)
				self.NR.OutputModeF.CombatHide:SetShown(TiquCanshu["shuchumode"]==2)
				self.NR.OutputModeF.GaoduHSlider:SetShown(TiquCanshu["shuchumode"]==2)
				self.NR.OutputModeF.shuvhudaoBOX:PIGDownMenu_SetText(chuangkoulist[TiquCanshu["ChatWox"]])	
				self.NR.OutputModeF.tiquOKFlash:SetChecked(TiquCanshu["tiquOKFlash"])
				self.NR.OutputModeF.GaoduHSlider:PIGSetValue(PIGA["Chat"]["Tiqu"]["KeywordFHeight"]);
				self.NR.OutputModeF.CombatHide:SetChecked(PIGA["Chat"]["Tiqu"]["CombatHide"])
				self.NR.OutputModeF.Color:ShowButColor(unpack(PIGA["Chat"]["Tiqu"]["BgColor"] or TiqumorenColor))
			else
				self.NR:Hide()
			end
		end
		TiquF:HookScript("OnShow", function(self)
			self:Options_SetFun()
		end);

		--过滤====================
		local BlackF,BlackTab=PIGOptionsList_R(KeywordF.F,L["CHAT_FILTERSTAB"],60,"Left")
		BlackF.F=PIGOptionsList_RF(BlackF)
		--设置
		BlackF.F.SetF,BlackF.F.SetTabBut=PIGOptionsList_R(BlackF.F,SETTINGS,70)
		BlackF.F.SetF:Show()
		BlackF.F.SetTabBut:Selected(true)
		----
		local function Filter_Open()
			BlackF.F.SetF.Open:SetChecked(PIGA["Chat"]["Filter"]["Open"])
			BlackF.F.SetF.Filter_CHANNEL:SetChecked(PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"])
			BlackF.F.SetF.Filter_YELL:SetChecked(PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"])
			BlackF.F.SetF.Filter_SAY:SetChecked(PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"])
			BlackF.F.SetF.Filter_WHISPER:SetChecked(PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"])
			BlackF.F.SetF.BlackName:SetChecked(PIGA["Chat"]["Filter"]["BlackName"])
			BlackF.F.SetF.FilterRepeat:SetChecked(PIGA["Chat"]["Filter"]["FilterRepeat"])
			BlackF.F.SetF.IGNORE_DND:SetChecked(PIGA["Chat"]["Filter"]["IGNORE_DND"])
			BlackF.F.SetF.FBneiNO:SetChecked(PIGA["Chat"]["Filter"]["FBneiNO"])
			BlackF.F.SetF.BlackName:Disable();
			BlackF.F.SetF.FilterRepeat:Disable();
			BlackF.F.SetF.IGNORE_DND:Disable();
			BlackF.F.SetF.FBneiNO:Disable();
			BlackF.F.SetF.Filter_CHANNEL:Disable();
			BlackF.F.SetF.Filter_YELL:Disable();
			BlackF.F.SetF.Filter_SAY:Disable();
			BlackF.F.SetF.Filter_WHISPER:Disable();
			if PIGA["Chat"]["Filter"]["Open"] then
				BlackF.F.SetF.Filter_CHANNEL:Enable();
				BlackF.F.SetF.Filter_YELL:Enable();
				BlackF.F.SetF.Filter_SAY:Enable();
				BlackF.F.SetF.Filter_WHISPER:Enable();
				if PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"] or PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"] or PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"] or PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"] then	
					BlackF.F.SetF.BlackName:Enable();
					BlackF.F.SetF.FilterRepeat:Enable();
					BlackF.F.SetF.IGNORE_DND:Enable();
					BlackF.F.SetF.FBneiNO:Enable();
				end
			end
		end
		BlackF.F.SetF.Open = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",20,-20},{"|cff00FF00"..ENABLE.."|r"..L["CHAT_FILTERS"]..IGNORE})
		BlackF.F.SetF.Open:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["Open"]=true
			else
				PIGA["Chat"]["Filter"]["Open"]=false
			end
			Filter_Open()
			QuickUI.Keyword:FilterKeysFun(true)
		end)

		BlackF.F.SetF.IGNOREinfot = PIGFontString(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",40,-60},CHOOSE..IGNORE..INFO)
		BlackF.F.SetF.BlackName = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.IGNOREinfot,"BOTTOMLEFT",10,-10},{L["CHAT_BLACK_NAME"]..PLAYER})
		BlackF.F.SetF.BlackName:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["BlackName"]=true
				BlackList["BlackName"]=true
			else
				PIGA["Chat"]["Filter"]["BlackName"]=false
				BlackList["BlackName"]=false
			end
		end);
		BlackF.F.SetF.IGNORE_DND = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.BlackName,"BOTTOMLEFT",0,-10},{"|cffFFC0C0勿扰"..PLAYER.."|r"})
		BlackF.F.SetF.IGNORE_DND:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["IGNORE_DND"]=true
				BlackList["IGNORE_DND"]=true
			else
				PIGA["Chat"]["Filter"]["IGNORE_DND"]=false
				BlackList["IGNORE_DND"]=true
			end
		end);
		BlackF.F.SetF.FilterRepeat = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.IGNORE_DND,"BOTTOMLEFT",0,-10},{L["CHAT_BLACK_SET1"][1],string.format(L["CHAT_BLACK_SET1"][2],1)})
		BlackF.F.SetF.FilterRepeat:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["FilterRepeat"]=true
				BlackList["FilterRepeat"]=true
			else
				PIGA["Chat"]["Filter"]["FilterRepeat"]=false
				BlackList["FilterRepeat"]=false
			end
		end);

		BlackF.F.SetF.Filter_pindao = PIGFontString(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",40,-190},CHOOSE..L["CHAT_BLACK_NAME"]..L["CHAT_KEYWORD"]..L["CHAT_FILTERS"]..CHANNEL)
		BlackF.F.SetF.Filter_CHANNEL = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_pindao,"BOTTOMLEFT",10,-10},{"|cffFFC0C0数字"..CHANNEL.."|r"})
		BlackF.F.SetF.Filter_CHANNEL:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"]=true
			else
				PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"]=false
			end
			Filter_Open()
			QuickUI.Keyword:FilterKeysFun(true)
		end);
		BlackF.F.SetF.Filter_YELL = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_CHANNEL,"BOTTOMLEFT",0,-10},{"|cffFF4040"..YELL.."|r"})
		BlackF.F.SetF.Filter_YELL:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"]=true
			else
				PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"]=false
			end
			Filter_Open()
			QuickUI.Keyword:FilterKeysFun(true)
		end);
		BlackF.F.SetF.Filter_SAY = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_YELL,"BOTTOMLEFT",0,-10},{"|cffFFFFFF"..SAY.."|r"})
		BlackF.F.SetF.Filter_SAY:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"]=true
			else
				PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"]=false
			end
			Filter_Open()
			QuickUI.Keyword:FilterKeysFun(true)
		end);
		BlackF.F.SetF.Filter_WHISPER = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_SAY,"BOTTOMLEFT",0,-10},{"|cffFF80FF非"..FRIEND..WHISPER.."|r"})
		BlackF.F.SetF.Filter_WHISPER:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"]=true
			else
				PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"]=false
			end
			Filter_Open()
			QuickUI.Keyword:FilterKeysFun(true)
		end);

		BlackF.F.SetF.FBneiNO = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",40,-350},{"副本内停止过滤","过滤需要占用少量性能，当电脑性能较差情况下可以开启此项"})
		BlackF.F.SetF.FBneiNO:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Chat"]["Filter"]["FBneiNO"]=true
			else
				PIGA["Chat"]["Filter"]["FBneiNO"]=false
			end
			QuickUI.Keyword:FilterKeysFun(true)
		end);
		BlackF.F.SetF.CZ = PIGButton(BlackF.F.SetF,{"BOTTOMLEFT",BlackF.F.SetF,"BOTTOMLEFT",20,20},{100,22},"重置过滤器")
		BlackF.F.SetF.CZ:SetScript("OnClick", function (self)
			StaticPopup_Show ("CZCHATGUOLVQIDATA");
		end);
		StaticPopupDialogs["CZCHATGUOLVQIDATA"] = {
			text = RESET..BAG_FILTER_JUNK..INFO..L["CHAT_FILTERS"]..SETTINGS.."\n需重载界面。确定重置?",
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function()
				PIGA["Chat"]["Filter"]=CopyTable(PD.Default["Chat"]["Filter"])
				ReloadUI()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		BlackF.F.SetF:HookScript("OnShow", function(self)
			Filter_Open()
		end);

		---过滤报告
		BlackF.F.ReportF=PIGOptionsList_R(BlackF.F,L["CHAT_FILTERS"]..LANDING_PAGE_REPORT,80)
		BlackF.F.ReportF.biaoti_1 = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF, "TOPLEFT", 60, -60},"自启动以来:")

		BlackF.F.ReportF.allnum = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.biaoti_1, "BOTTOMLEFT", 50, -20},INFO.."总数:")
		BlackF.F.ReportF.allnumV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.allnum, "RIGHT", 4, 0},"0")
		BlackF.F.ReportF.allnumV:SetTextColor(1, 1, 1, 1)
		BlackF.F.ReportF.okmsg = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.allnum, "BOTTOMLEFT", 0, -10},"已放行:")
		BlackF.F.ReportF.okmsg:SetTextColor(0, 1, 0, 1)
		BlackF.F.ReportF.okmsgV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.okmsg, "RIGHT", 4, 0},"0")
		BlackF.F.ReportF.okmsgV:SetTextColor(1, 1, 1, 1)
		BlackF.F.ReportF.black = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.okmsg, "BOTTOMLEFT", 0, -10},"已"..L["CHAT_FILTERS"]..":")
		BlackF.F.ReportF.black:SetTextColor(1, 0, 0, 1)
		BlackF.F.ReportF.blackV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.black, "RIGHT", 4, 0},"0")
		BlackF.F.ReportF.blackV:SetTextColor(1, 1, 1, 1)
		BlackF.F.ReportF.nameblack = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.black, "BOTTOMLEFT", 20, -10},L["CHAT_BLACK_NAME"]..PLAYER..":")
		BlackF.F.ReportF.nameblack:SetTextColor(0.6, 0.6, 0.6, 1)
		BlackF.F.ReportF.nameblackV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.nameblack, "RIGHT", 4, 0},"0")
		BlackF.F.ReportF.nameblackV:SetTextColor(1, 1, 1, 1)
		BlackF.F.ReportF.wordblack = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.nameblack, "BOTTOMLEFT", 0, -10},L["CHAT_BLACK_NAME"]..L["CHAT_KEYWORD"]..":")
		BlackF.F.ReportF.wordblack:SetTextColor(0.6, 0.6, 0.6, 1)
		BlackF.F.ReportF.wordblackV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.wordblack, "RIGHT", 4, 0},"0")
		BlackF.F.ReportF.wordblackV:SetTextColor(1, 1, 1, 1)
		BlackF.F.ReportF.chongfu = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.wordblack, "BOTTOMLEFT", 0, -10},L["CHAT_BLACK_SET1"][1]..":")
		BlackF.F.ReportF.chongfu:SetTextColor(0.6, 0.6, 0.6, 1)
		BlackF.F.ReportF.chongfuV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.chongfu, "RIGHT", 4, 0},"0")
		BlackF.F.ReportF.chongfuV:SetTextColor(1, 1, 1, 1)

		local ceil=math.ceil
		BlackF.F.ReportF.jishiqi=0
		BlackF.F.ReportF:SetScript("OnUpdate", function(self,sss)
			if self.jishiqi>1 then
				self.jishiqi=0
				self.allnumV:SetText(ceil(BlackList["count"]*0.1))
				self.okmsgV:SetText(ceil(BlackList["OKcount"]*0.1))
				local name_count = math.ceil(BlackList["name_count"]*0.1)
				local chongfu_count = ceil(BlackList["chongfu_count"]*0.1)
				local word_count = ceil(BlackList["word_count"]*0.1)
				local guolhe = name_count+chongfu_count+word_count
				self.blackV:SetText(guolhe)
				self.nameblackV:SetText(name_count)
				self.chongfuV:SetText(chongfu_count)
				self.wordblackV:SetText(word_count)
			else
				self.jishiqi = self.jishiqi + sss;
			end
		end)

		--黑名单
		BlackF.F.BlackF=PIGOptionsList_R(BlackF.F,L["CHAT_BLACK_NAME"]..L["CHAT_KEYWORD"],110)
		local tishineiB = "|cffFF0000"..L["CHAT_KEYWORD"]..L["CHAT_BLACK_NAME"].."(|cffFF0000账号共享)|r\n|cffFFFF00"..L["CHAT_BLACK_EITB"].."|r"
		BlackF.F.BlackF.tishi1 = PIGFontString(BlackF.F.BlackF,{"TOPLEFT",BlackF.F.BlackF,"TOPLEFT",10,-8},tishineiB);
		BlackF.F.BlackF.tishi1:SetJustifyH("LEFT");

		local DFKeywords = "WOW，收G，出G，收米，出米，出大米，收大米，纯手工，急速升级，价格实惠，加V，+V，效率#升级，极速，+V，WLK499，躺赢，"
		if PIG_MaxTocversion(20000) then
			Keywords=DFKeywords..
			"0.01，0.02，0.03，0.04，0.05，0.06，0.07，0.08，0.09，0.1，0.11，0.12，"..
			"1-10，1-20，1-30，1-40，1-50，1-60，8-20，15-31，15-25，20-40，25-30，15-30，25-40，30-40，40-48，"..
			"1到10，1到20，1到30，1到40，1到50，1到60，8到20，15到31，15到25，20到40，25到30，15到30，25到40，30到40，40到48，"..
			"美女客服，美女接待，无需点卡，全天在线，单法，双法，不翻车，手动，光速车，螃蟹#站桩，可打折，包完成"..
			"可跟可托，可自上可托，可跟打可托，极速团，一级#老板，代肝，金牌，TB支付，先打后，先打再付，24小时，折扣，一波流，"..
			"R/次，R/一次，R/级，R一级，白菜，=1R，=1.5R，=2R，=2.5R，=3R，=4R，=5R"..
			"血月#优惠，血月#特价，血月#1R，血月#一R，血月#一波，血月#刷刷，血月#嘎嘎，血月#特惠，帮做#血月，帮做#鲜血之月，急速#帮写，坑杀#血月，"..
			"航空，全图，中转，全球中转，"..
			"附魔#平价，附魔#真人，附魔#专业#披风，附魔#单手#双手，武#盾#胸，附魔#代工，附魔#拆卸"
		elseif PIG_MaxTocversion(30000) then
			Keywords=DFKeywords
		elseif PIG_MaxTocversion(40000) then
			Keywords=DFKeywords
		elseif PIG_MaxTocversion(50000) then
			Keywords=DFKeywords
		else
			Keywords=DFKeywords
		end
		---------
		local function Ischongfu(data,key)
			for i=1,#data do
				if data[i]==key then
					return true
				end
			end
			return false
		end
		local function txtTOtbale(lytxt)
			lytxt = lytxt:gsub("，", ",")
			local datax={}
			local fengelist = Key_fenge(lytxt, ",", true)
			for i=1,#fengelist do
				if not Ischongfu(datax, fengelist[i]) then
					table.insert(datax, fengelist[i])
				end
			end
			return datax
		end
		local function Save_BlackValue(textArea)
			local value = textArea:GetText():gsub(" ", "")
			local datax = txtTOtbale(value)
			PIGA["Chat"]["Filter"]["BlacksList"]=datax
		 	BlackList["word"]=datax
		 	textArea:SetText(Key_hebing(datax))
			textArea:ClearFocus()
			textArea:SetTextColor(0.6, 0.6, 0.6, 1)
			BlackF.F.BlackF.NR.SaveBut:Hide()
		end
		---
		BlackF.F.BlackF.NR = PIGFrame(BlackF.F.BlackF);
		BlackF.F.BlackF.NR:PIGSetBackdrop()
		BlackF.F.BlackF.NR:SetPoint("TOPLEFT",BlackF.F.BlackF,"TOPLEFT",0,-70);
		BlackF.F.BlackF.NR:SetPoint("BOTTOMRIGHT",BlackF.F.BlackF,"BOTTOMRIGHT",0,0);
		BlackF.F.BlackF.NR.scroll = CreateFrame("ScrollFrame", nil, BlackF.F.BlackF.NR, "UIPanelScrollFrameTemplate")
		BlackF.F.BlackF.NR.scroll:SetPoint("TOPLEFT", BlackF.F.BlackF.NR, "TOPLEFT", 6, -2)
		BlackF.F.BlackF.NR.scroll:SetPoint("BOTTOMRIGHT", BlackF.F.BlackF.NR, "BOTTOMRIGHT", -20, 2)
		BlackF.F.BlackF.NR.scroll.ScrollBar:SetScale(0.8);
		BlackF.F.BlackF.NR.textArea = CreateFrame("EditBox", nil, BlackF.F.BlackF.NR,"BackdropTemplate")
		BlackF.F.BlackF.NR.textArea:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
		BlackF.F.BlackF.NR.textArea:SetBackdropColor(0.2, 0.2, 0.2, 0.8);
		BlackF.F.BlackF.NR.textArea:SetWidth(BlackF.F.BlackF.NR:GetWidth()-24)
		PIGSetFont(BlackF.F.BlackF.NR.textArea,14,"OUTLINE")
		BlackF.F.BlackF.NR.textArea:SetTextColor(0.6, 0.6, 0.6, 1)
		BlackF.F.BlackF.NR.textArea:SetAutoFocus(false)
		BlackF.F.BlackF.NR.textArea:SetMultiLine(true)
		BlackF.F.BlackF.NR.textArea:SetMaxLetters(9999)
		BlackF.F.BlackF.NR.textArea:EnableMouse(true)
		BlackF.F.BlackF.NR.scroll:SetScrollChild(BlackF.F.BlackF.NR.textArea)
		BlackF.F.BlackF.NR.textArea.tishi = PIGFontString(BlackF.F.BlackF.NR.textArea,{"TOPLEFT",BlackF.F.BlackF.NR.textArea,"TOPLEFT",2,-0},L["CHAT_KEYWORD_TI"]);
		BlackF.F.BlackF.NR.textArea.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
		BlackF.F.BlackF.NR.textArea:SetScript("OnShow", function(self)
			self:SetText(Key_hebing(PIGA["Chat"]["Filter"]["BlacksList"]))
		end);
		BlackF.F.BlackF.NR.textArea:SetScript("OnEscapePressed", function(self)
			self:SetTextColor(0.6, 0.6, 0.6, 1)
			BlackF.F.BlackF.NR.SaveBut:Hide()
			self:ClearFocus()
		end);
		BlackF.F.BlackF.NR.textArea:SetScript("OnEditFocusGained", function(self)
			self:SetTextColor(1, 1, 1, 1)
			BlackF.F.BlackF.NR.SaveBut:Show()
		end);
		BlackF.F.BlackF.NR.textArea:SetScript("OnTextChanged", function(self)
			local txtv = self:GetText():gsub(" ", "")
			self.tishi:SetShown(txtv=="")
		end);
		BlackF.F.BlackF.NR.textArea:SetScript("OnEnterPressed", function(self)
			Save_BlackValue(self)
		end);
		BlackF.F.BlackF.NR.SaveBut = PIGButton(BlackF.F.BlackF.NR,{"BOTTOMRIGHT",BlackF.F.BlackF.NR,"TOPRIGHT",-10,2},{60,20},SAVE)
		BlackF.F.BlackF.NR.SaveBut:Hide()
		BlackF.F.BlackF.NR.SaveBut:SetScript("OnClick", function(self)
			local fujif = self:GetParent();
			Save_BlackValue(fujif.textArea)
		end)
		BlackF.F.BlackF.NR.morenkey = PIGButton(BlackF.F.BlackF.NR,{"BOTTOMRIGHT",BlackF.F.BlackF.NR,"TOPRIGHT",-10,40},{114,20},"载入预置黑名单")
		BlackF.F.BlackF.NR.morenkey:SetScript("OnClick", function(self)
			BlackF.F.BlackF.NR.textArea:SetText(Keywords)
			local fujif = self:GetParent();
			Save_BlackValue(fujif.textArea)
			PIGErrorMsg("已载入预置黑名单");
		end)

		---黑名单玩家
		BlackF.F.BlackF_P,BlackF.F.BlackF_PTab=PIGOptionsList_R(BlackF.F,L["CHAT_BLACK_NAME"]..PLAYER,90)
		local scrlwww=BlackF.F.BlackF_P:GetWidth()
		local hangmaxnum,hangeH,topvv=21,20,-34
		--L账号黑名单
		BlackF.F.BlackF_P.NR = PIGFrame(BlackF.F.BlackF_P);
		BlackF.F.BlackF_P.NR:PIGSetBackdrop()
		BlackF.F.BlackF_P.NR:SetPoint("TOPLEFT",BlackF.F.BlackF_P,"TOPLEFT",0,topvv);
		BlackF.F.BlackF_P.NR:SetPoint("BOTTOMLEFT",BlackF.F.BlackF_P,"BOTTOMLEFT",0,0);
		BlackF.F.BlackF_P.NR:SetWidth(scrlwww*0.4)
		BlackF.F.BlackF_P.NR.tishi1 = PIGFontString(BlackF.F.BlackF_P.NR,{"BOTTOMLEFT",BlackF.F.BlackF_P.NR,"TOPLEFT",8,4});
		BlackF.F.BlackF_P.NR.tishi1:SetJustifyH("LEFT");
		BlackF.F.BlackF_P.NR.tishi1:SetTextColor(0, 1, 0, 1)
		BlackF.F.BlackF_P.NR.scroll = Create.PIGScrollFrame_old(BlackF.F.BlackF_P.NR)
		BlackF.F.BlackF_P.NR.ButList={}
		--R有备注黑名单
		BlackF.F.BlackF_P.NR_R = PIGFrame(BlackF.F.BlackF_P);
		BlackF.F.BlackF_P.NR_R:PIGSetBackdrop()
		BlackF.F.BlackF_P.NR_R:SetPoint("TOPRIGHT",BlackF.F.BlackF_P,"TOPRIGHT",0,topvv);
		BlackF.F.BlackF_P.NR_R:SetPoint("BOTTOMRIGHT",BlackF.F.BlackF_P,"BOTTOMRIGHT",0,0);
		BlackF.F.BlackF_P.NR_R:SetWidth(scrlwww*0.6)
		BlackF.F.BlackF_P.NR_R.tishi1 = PIGFontString(BlackF.F.BlackF_P.NR_R,{"BOTTOMLEFT",BlackF.F.BlackF_P.NR_R,"TOPLEFT",8,4});
		BlackF.F.BlackF_P.NR_R.tishi1:SetJustifyH("LEFT");
		BlackF.F.BlackF_P.NR_R.tishi1:SetTextColor(0, 1, 0, 1)
		BlackF.F.BlackF_P.NR_R.scroll = Create.PIGScrollFrame_old(BlackF.F.BlackF_P.NR_R)
		BlackF.F.BlackF_P.NR_R.ButList={}
		function BlackF.F.BlackF_P.NR.scroll:UpdateShowList()
		    for _,v in pairs(BlackF.F.BlackF_P.NR.ButList) do
		    	v:Hide()
		    end
			local TotalNum = #PIGA["Chat"]["Filter"]["Ignore_P"]
			BlackF.F.BlackF_P.NR.tishi1:SetText("聊天屏蔽名单(账号共享)"..TotalNum)
			if TotalNum>0 then
				local offset = self:GetScrollFrameOffset(TotalNum, hangmaxnum, hangeH)
			    for i = 1, hangmaxnum do
					local AHdangqianH = TotalNum - (i - 1) - offset
					local name = PIGA["Chat"]["Filter"]["Ignore_P"][AHdangqianH]
					if name then
						if not BlackF.F.BlackF_P.NR.ButList[i] then
							BlackF.F.BlackF_P.NR.ButList[i] = CreateFrame("Button", nil, BlackF.F.BlackF_P.NR)
							BlackF.F.BlackF_P.NR.ButList[i]:SetSize(scrlwww*0.4-16,hangeH);
							if i==1 then
								BlackF.F.BlackF_P.NR.ButList[i]:SetPoint("TOPLEFT",BlackF.F.BlackF_P.NR,"TOPLEFT",0,0);
							else
								BlackF.F.BlackF_P.NR.ButList[i]:SetPoint("TOP",BlackF.F.BlackF_P.NR.ButList[i-1],"BOTTOM",0,0);
							end
							BlackF.F.BlackF_P.NR.ButList[i].hightex = BlackF.F.BlackF_P.NR.ButList[i]:CreateTexture(nil,"HIGHLIGHT");
							BlackF.F.BlackF_P.NR.ButList[i].hightex:SetTexture("interface/buttons/ui-listbox-highlight2.bhangeHlp");
							BlackF.F.BlackF_P.NR.ButList[i].hightex:SetAllPoints(BlackF.F.BlackF_P.NR.ButList[i])
							BlackF.F.BlackF_P.NR.ButList[i].hightex:SetBlendMode("ADD")
							BlackF.F.BlackF_P.NR.ButList[i].hightex:SetAlpha(0.4);
							BlackF.F.BlackF_P.NR.ButList[i].delbut=PIGDiyBut(BlackF.F.BlackF_P.NR.ButList[i],{"LEFT",BlackF.F.BlackF_P.NR.ButList[i],"LEFT",4,0},{hangeH-4,hangeH-4});
							BlackF.F.BlackF_P.NR.ButList[i].delbut:SetScript("OnClick", function(self)
								local fujibut = self:GetParent()
								local pname=fujibut.name:GetText()
								BlackF.F.BlackF_P:DelblackName(pname)
							end)
							BlackF.F.BlackF_P.NR.ButList[i].name = PIGFontString(BlackF.F.BlackF_P.NR.ButList[i],{"LEFT",BlackF.F.BlackF_P.NR.ButList[i].delbut,"LEFT",hangeH-4,0})
							BlackF.F.BlackF_P.NR.ButList[i].name:SetTextColor(1, 1, 1, 1)
						end
						BlackF.F.BlackF_P.NR.ButList[i]:Show()
						BlackF.F.BlackF_P.NR.ButList[i].name:SetText(name)
					end
				end
			end
		end
		function BlackF.F.BlackF_P.NR_R.scroll:UpdateShowList()
		    for _,v in pairs(BlackF.F.BlackF_P.NR_R.ButList) do
		    	v:Hide()
		    end
			local NewData = {}
			for i=1,#PIGA["Chat"]["Filter"]["Ignore_P"] do
				if PIGA["Chat"]["Filter"]["Ignore_N"][PIGA["Chat"]["Filter"]["Ignore_P"][i]] then
					table.insert(NewData,PIGA["Chat"]["Filter"]["Ignore_P"][i])
				end
			end
			local TotalNum = #NewData
			BlackF.F.BlackF_P.NR_R.tishi1:SetText("有备注玩家(组队将会提醒)"..TotalNum)
			if TotalNum>0 then
				local offset = self:GetScrollFrameOffset(TotalNum, hangmaxnum, hangeH)
			    for i = 1, hangmaxnum do
					local AHdangqianH = TotalNum - (i - 1) - offset
					if NewData[AHdangqianH] then
						if not BlackF.F.BlackF_P.NR_R.ButList[i] then
							BlackF.F.BlackF_P.NR_R.ButList[i] = CreateFrame("Button", nil, BlackF.F.BlackF_P.NR_R)
							BlackF.F.BlackF_P.NR_R.ButList[i]:SetSize(scrlwww*0.6-16,hangeH);
							if i==1 then
								BlackF.F.BlackF_P.NR_R.ButList[i]:SetPoint("TOPLEFT",BlackF.F.BlackF_P.NR_R,"TOPLEFT",0,0);
							else
								BlackF.F.BlackF_P.NR_R.ButList[i]:SetPoint("TOP",BlackF.F.BlackF_P.NR_R.ButList[i-1],"BOTTOM",0,0);
							end
							BlackF.F.BlackF_P.NR_R.ButList[i].hightex = BlackF.F.BlackF_P.NR_R.ButList[i]:CreateTexture(nil,"HIGHLIGHT");
							BlackF.F.BlackF_P.NR_R.ButList[i].hightex:SetTexture("interface/buttons/ui-listbox-highlight2.bhangeHlp");
							BlackF.F.BlackF_P.NR_R.ButList[i].hightex:SetAllPoints(BlackF.F.BlackF_P.NR_R.ButList[i])
							BlackF.F.BlackF_P.NR_R.ButList[i].hightex:SetBlendMode("ADD")
							BlackF.F.BlackF_P.NR_R.ButList[i].hightex:SetAlpha(0.4);
							BlackF.F.BlackF_P.NR_R.ButList[i].delbut=PIGDiyBut(BlackF.F.BlackF_P.NR_R.ButList[i],{"LEFT",BlackF.F.BlackF_P.NR_R.ButList[i],"LEFT",4,0},{hangeH-4,hangeH-4});
							BlackF.F.BlackF_P.NR_R.ButList[i].delbut:SetScript("OnClick", function(self)
								local fujibut = self:GetParent()
								local pname=fujibut.name:GetText()
								BlackF.F.BlackF_P:DelblackName(pname)
							end)
							BlackF.F.BlackF_P.NR_R.ButList[i].name = PIGFontString(BlackF.F.BlackF_P.NR_R.ButList[i],{"LEFT",BlackF.F.BlackF_P.NR_R.ButList[i].delbut,"LEFT",hangeH-4,0})
							BlackF.F.BlackF_P.NR_R.ButList[i].name:SetTextColor(1, 1, 1, 1)
							BlackF.F.BlackF_P.NR_R.ButList[i].note = PIGFontString(BlackF.F.BlackF_P.NR_R.ButList[i],{"LEFT",BlackF.F.BlackF_P.NR_R.ButList[i].name,"RIGHT",2,0})
							BlackF.F.BlackF_P.NR_R.ButList[i].note:SetTextColor(1, 0, 0, 1)
						end
						BlackF.F.BlackF_P.NR_R.ButList[i]:Show()
						BlackF.F.BlackF_P.NR_R.ButList[i].name:SetText(NewData[AHdangqianH])
						BlackF.F.BlackF_P.NR_R.ButList[i].note:SetText("("..PIGA["Chat"]["Filter"]["Ignore_N"][NewData[AHdangqianH]]..")")
					end
				end
			end
		end
		function BlackF.F.BlackF_P:DelblackName(pname)
			local TotalNum=C_FriendList.GetNumIgnores()
			for i=1,TotalNum do
				local name = C_FriendList.GetIgnoreName(i);
				if name and pname==name then
					C_FriendList.DelIgnore(pname)
					break
				end	
			end
			for ix=#PIGA["Chat"]["Filter"]["Ignore_P"],1,-1 do
				if PIGA["Chat"]["Filter"]["Ignore_P"][ix]==pname then
					table.remove(PIGA["Chat"]["Filter"]["Ignore_P"],ix)
					break
				end
			end
			PIGA["Chat"]["Filter"]["Ignore_N"][pname]=nil
			FrameUIxxx.UpdateShowList()
		end
		FrameUIxxx.UpdateShowList=function()
			if not BlackF.F.BlackF_P:IsShown() then return end
			BlackF.F.BlackF_P.NR.scroll:UpdateShowList()
			BlackF.F.BlackF_P.NR_R.scroll:UpdateShowList()
		end
		BlackF.F.BlackF_P:HookScript("OnShow", function(self)
			FrameUIxxx.UpdateShowList()
		end);
		--添加备注
		BlackF.F.BlackF_P.addf=PIGFrame(BlackF.F.BlackF_P,{"TOP",BlackF.F.BlackF_P,"TOP",0,-58},{240,180})
		BlackF.F.BlackF_P.addf:PIGSetBackdrop(1)
		BlackF.F.BlackF_P.addf:SetFrameLevel(BlackF.F.BlackF_P.addf:GetFrameLevel()+6)
		BlackF.F.BlackF_P.addf:Hide()
		BlackF.F.BlackF_P.addf:PIGClose()
		BlackF.F.BlackF_P.addf.title = PIGFontString(BlackF.F.BlackF_P.addf,{"TOP", BlackF.F.BlackF_P.addf, "TOP", 0, -6},"屏蔽原因")
		BlackF.F.BlackF_P.addf.topline = PIGLine(BlackF.F.BlackF_P.addf,"TOP",-26,nil,nil,{0.3,0.3,0.3,0.5})
		BlackF.F.BlackF_P.addf.title1 = PIGFontString(BlackF.F.BlackF_P.addf,{"TOP", BlackF.F.BlackF_P.addf, "TOP", 0, -46})
		BlackF.F.BlackF_P.addf.E = CreateFrame("EditBox", nil, BlackF.F.BlackF_P.addf, "InputBoxInstructionsTemplate");
		BlackF.F.BlackF_P.addf.E:SetSize(180,30);
		BlackF.F.BlackF_P.addf.E:SetPoint("TOP",BlackF.F.BlackF_P.addf,"TOP",0,-70);
		BlackF.F.BlackF_P.addf.E:SetFontObject(ChatFontNormal);
		BlackF.F.BlackF_P.addf.E:SetMaxLetters(10)
		BlackF.F.BlackF_P.addf.E:SetScript("OnEscapePressed", function(self) BlackF.F.BlackF_P.addf:Hide() end)
		BlackF.F.BlackF_P.addf.E:SetScript("OnTextChanged", function(self)
			local newtxt=self:GetText()
			if newtxt=="" or newtxt==" " then
				BlackF.F.BlackF_P.addf.SaveBut:Disable();
				BlackF.F.BlackF_P.addf.err:SetText("原因不能为空")
			else
				BlackF.F.BlackF_P.addf.err:SetText("")
				BlackF.F.BlackF_P.addf.SaveBut:Enable();
			end
		end)
		BlackF.F.BlackF_P.addf:HookScript("OnShow", function (self)
			BlackF.F.BlackF_P.addf.E:SetText("")
		end);
		BlackF.F.BlackF_P.addf.err = PIGFontString(BlackF.F.BlackF_P.addf,{"TOP", BlackF.F.BlackF_P.addf.E, "BOTTOM", 0, 0},"")
		BlackF.F.BlackF_P.addf.err:SetTextColor(1, 0, 0, 1);
		--
		BlackF.F.BlackF_P.addf.SaveBut = PIGButton(BlackF.F.BlackF_P.addf,{"BOTTOM", BlackF.F.BlackF_P.addf, "BOTTOM", -50, 20},{80,24},SAVE);
		BlackF.F.BlackF_P.addf.SaveBut:Disable();
		BlackF.F.BlackF_P.addf.SaveBut:HookScript("OnClick", function (self)
			local name_server=BlackF.F.BlackF_P.addf.title1:GetText()
			for i=#PIGA["Chat"]["Filter"]["Ignore_P"],1,-1 do
				if PIGA["Chat"]["Filter"]["Ignore_P"][i]==name_server then
					PIGA["Chat"]["Filter"]["Ignore_N"][name_server]=BlackF.F.BlackF_P.addf.E:GetText()
					FrameUIxxx.UpdateShowList()
					BlackF.F.BlackF_P.addf:Hide()
					break
				end
			end
		end);
		BlackF.F.BlackF_P.addf.Cancel = PIGButton(BlackF.F.BlackF_P.addf,{"LEFT", BlackF.F.BlackF_P.addf.SaveBut, "RIGHT", 10, 0},{80,24},CANCEL);
		BlackF.F.BlackF_P.addf.Cancel:HookScript("OnClick", function (self)
			BlackF.F.BlackF_P.addf:Hide()
		end);
		function KeywordF.SetIgnoreTab(name_server)
			BlackTab:Click()
			BlackF.F.BlackF_PTab:Click()
			BlackF.F.BlackF_P.addf:Show()
			BlackF.F.BlackF_P.addf.title1:SetText(name_server)
		end
	end
end