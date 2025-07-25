local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub
local gmatch = _G.string.gmatch
local match = _G.string.match
local upper = _G.string.upper
local lower= _G.string.lower
local L=addonTable.locale
local Fun=addonTable.Fun
local Data=addonTable.Data
local Key_fenge=Fun.Key_fenge
local del_link=Fun.del_link
local gsub_NOlink=Fun.gsub_NOlink
local Is_IndexContain=Fun.Is_IndexContain
local del_biaoqing=Fun.del_biaoqing
local del_biaodian=Fun.del_biaodian
local TihuanBiaoqing=Fun.TihuanBiaoqing
local GetRaceClassTXT=Fun.GetRaceClassTXT
------------
local Create=addonTable.Create
local PIGEnter=Create.PIGEnter
local PIGFrame=Create.PIGFrame
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
local AudioData=addonTable.AudioList.Data
local BlackList = {["BlackName"]=true,["FilterRepeat"]=true,["IGNORE_DND"]=true,["Precise"]=false,["name"]={},["word"]={},["chongfu"]={},["count"]=0,["OKcount"]=0,["name_count"]=0,["chongfu_count"]=0,["word_count"]=0}
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
	--table.insert(chongfuData,{time,newText,chatbox})
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
		local p_blnum = #BlackList["name"]
		if p_blnum>0 then
			for x=1,p_blnum do
				if BlackList["Precise"] then
					if name==BlackList["name"][x] then
						return true
					end
				else
					if name:match(BlackList["name"][x]) then
						return true
					end
				end
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
local QuickChatfun=addonTable.QuickChatfun
function QuickChatfun.QuickBut_miyijiluGL(arg2,arg5,arg1)
	if arg2~=PIG_OptionsUI.AllName then
		if FilterBlack_IsFriend(arg2,arg5) then
			return false
		end
		if BlackList["BlackName"] and FilterBlack_Name(arg2) then
			return true
		end
		if BlackList["IGNORE_DND"] and arg6=="DND" then
			return true 
		end
		local newText = del_link(arg1)
		local newText = del_biaoqing(newText)
		local newText = del_biaodian(newText)
		if FilterBlack_Key(newText) then
			return true 
		end
		return false
	end
	return false
end
function QuickChatfun.QuickBut_Keyword()
	PIGA["Chat"]["Tiqu"]["Audio"]=Fun.IsAudioNumMaxV(PIGA["Chat"]["Tiqu"]["Audio"],AudioData.FollowMsg)
	local fuFrame=QuickChatfun.TabButUI
	local fuWidth = fuFrame.Width
	local Width,Height = fuWidth,fuWidth
	local ziframe = {fuFrame:GetChildren()}
	if PIGA["Chat"]["QuickChat_style"]==1 then
		fuFrame.Keyword = CreateFrame("Button",nil,fuFrame); 
	elseif PIGA["Chat"]["QuickChat_style"]==2 then
		fuFrame.Keyword = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate"); 
	end
	fuFrame.Keyword:SetSize(Width,Height);
	fuFrame.Keyword:SetPoint("LEFT",fuFrame,"LEFT",#ziframe*Width,0);
	fuFrame.Keyword.Tex = fuFrame.Keyword:CreateTexture();
	fuFrame.Keyword.Tex:SetTexture("interface/common/voicechat-on.blp");
	fuFrame.Keyword.Tex:SetSize(Width+2,Height-4);
	fuFrame.Keyword.Tex:SetPoint("CENTER", -7.5, 0);
	fuFrame.Keyword.Tex:SetDrawLayer("BORDER", -1)
	fuFrame.Keyword.TexNO = fuFrame.Keyword:CreateTexture();
	fuFrame.Keyword.TexNO:SetTexture("interface/common/voicechat-muted.blp");
	fuFrame.Keyword.TexNO:SetSize(Width-9,Height-9);
	fuFrame.Keyword.TexNO:SetAlpha(0.7);
	fuFrame.Keyword.TexNO:SetPoint("CENTER", 0, 0);
	if PIGA["Chat"]["Filter"]["Open"] then
		fuFrame.Keyword.TexNO:Hide()
	else
		fuFrame.Keyword.TexNO:Show()
	end
	fuFrame.Keyword:SetScript("OnMouseDown",  function(self)
		self.Tex:SetPoint("CENTER", -6, -1.5);
	end)
	fuFrame.Keyword:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", -7.5, 0);
	end)
	PIGEnter(fuFrame.Keyword,"|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..CHAT..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"].."|r\n|cff00FFff"..KEY_BUTTON2.."-|r|cffFFFF00"..ENABLE.."/"..CLOSE..CHAT..L["CHAT_FILTERS"].."|r")
	fuFrame.Keyword:HookScript("OnEnter", function (self)	
		fuFrame:PIGEnterAlpha()
	end);
	fuFrame.Keyword:HookScript("OnLeave", function (self)
		fuFrame:PIGLeaveAlpha()
	end);
	fuFrame.Keyword:RegisterForClicks("LeftButtonUp","RightButtonUp")
	fuFrame.Keyword:SetScript("OnClick", function(self,button)
		self.ClickShowTab(button)	
	end);
	-----
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
	TiquTabBut:Selected()

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

	local ChatF99 = CreateFrame("ScrollingMessageFrame", "PIG_ChatFrameKeyWord", UIParent, "ChatFrameTemplate")
	local KeywordFHeight = PIGA["Chat"]["Tiqu"]["KeywordFHeight"] or 180
	ChatF99:SetHeight(KeywordFHeight);
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

	ChatF99.ScrollToBottomButton = CreateFrame("Button",nil,ChatF99, "TruncatedButtonTemplate");
	ChatF99.ScrollToBottomButton:SetNormalTexture(TiquCanshu["ToBotBut"][1])
	ChatF99.ScrollToBottomButton:SetPushedTexture(TiquCanshu["ToBotBut"][2])
	ChatF99.ScrollToBottomButton:SetDisabledTexture(TiquCanshu["ToBotBut"][3])
	ChatF99.ScrollToBottomButton:SetHighlightTexture(TiquCanshu["ToBotBut"][4]);
	if PIG_MaxTocversion() then
		ChatF99.ScrollToBottomButton:SetSize(24,24);
		ChatF99.ScrollToBottomButton.hilight = ChatF99.ScrollToBottomButton:CreateTexture(nil,"OVERLAY");
		ChatF99.ScrollToBottomButton.hilight:SetTexture("interface/chatframe/ui-chaticon-blinkhilight.blp");
		ChatF99.ScrollToBottomButton.hilight:SetSize(24,24);
		ChatF99.ScrollToBottomButton.hilight:SetPoint("CENTER", 0, 0);
		ChatF99.ScrollToBottomButton.hilight:Hide();
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
			self.hilight:Hide();
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
				self.ScrollToBottomButton.hilight:Show();
			else
				self.ScrollToBottomButton:SetNormalTexture(TiquCanshu["ToBotBut"][4])
			end
			self:ScrollUp()
		elseif delta == -1 then
			self:ScrollDown()
			if self:GetScrollOffset()==0 then
				if PIG_MaxTocversion() then
					self.ScrollToBottomButton:Hide();
					self.ScrollToBottomButton.hilight:Hide();
				else
					FCF_FadeOutScrollbar(self)
					self.ScrollToBottomButton:SetNormalTexture(TiquCanshu["ToBotBut"][1])
				end
			end
		end
	end)
	ChatF99:SetScript("OnUpdate", function(self, elapsed)
		ChatFrame_OnUpdate(self, elapsed)
	end)
	function KeywordF.Tiqu_SetFun()
		TiquF:UnregisterEvent("CHAT_MSG_CHANNEL");
		TiquF:UnregisterEvent("PLAYER_REGEN_DISABLED")
		TiquF:UnregisterEvent("PLAYER_REGEN_ENABLED");
		ChatF99:Hide()
		if PIGA["Chat"]["Tiqu"]["Open"] then
			TiquF:RegisterEvent("CHAT_MSG_CHANNEL");
			if TiquCanshu["shuchumode"]==2 then
				if PIGA["Chat"]["Tiqu"]["CombatHide"] then
					TiquF:RegisterEvent("PLAYER_REGEN_DISABLED")
					TiquF:RegisterEvent("PLAYER_REGEN_ENABLED");
					if not InCombatLockdown() then ChatF99:Show() end
				else
					ChatF99:Show() 
				end
			end
		end
	end
	KeywordF.Tiqu_SetFun()
	TiquF.KeyOpen = PIGCheckbutton(TiquF,{"TOPLEFT",TiquF,"TOPLEFT",20,-20},{"|cff00FF00"..ENABLE.."|r"..L["CHAT_KEYWORD_NAME1"]..L["CHAT_KEYWORD_NAME"]..INFO})
	TiquF.KeyOpen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Tiqu"]["Open"]=true
		else
			PIGA["Chat"]["Tiqu"]["Open"]=false
		end
		KeywordF.Tiqu_SetFun()
		KeywordF.Options_SetFun()
	end);
	---
	local White_keywords={}
	local function zairuKeyFun()
		White_keywords={}
		local keyslist = PIGA["Chat"]["Tiqu"]["Keys"]
		local keyslist = keyslist:gsub("，", ",")
		local fengelist = Key_fenge(keyslist, ",", true)
		for i=1,#fengelist do
			local newTxT=fengelist[i]
			if newTxT:match("&") or newTxT:match("#") then
				local newTxT_1 = Key_fenge(newTxT, {"&","#"},true)
				table.insert(White_keywords, newTxT_1);
			else
				table.insert(White_keywords, newTxT);
			end
		end
	end
	zairuKeyFun()
	local function Save_KeyValue(fuji)
		local value = fuji:GetText();
		local value = value:gsub(" ", "")
		local newTxT=value:upper()
		PIGA["Chat"]["Tiqu"]["Keys"]=newTxT
	 	zairuKeyFun()
	end
	TiquF.EditF = PIGFrame(TiquF);
	TiquF.EditF:PIGSetBackdrop(0)
	TiquF.EditF:SetPoint("TOPLEFT",TiquF,"TOPLEFT",14,-80);
	TiquF.EditF:SetPoint("TOPRIGHT",TiquF,"TOPRIGHT",-14,-80);
	TiquF.EditF:SetHeight(20)
	TiquF.EditF.tet = CreateFrame("EditBox", nil, TiquF.EditF)
	TiquF.EditF.tet:SetPoint("TOPLEFT",TiquF.EditF,"TOPLEFT",6,-2);
	TiquF.EditF.tet:SetPoint("BOTTOMRIGHT",TiquF.EditF,"BOTTOMRIGHT",-4,0);
	TiquF.EditF.tet:SetWidth(TiquF.EditF:GetWidth()-24)
	PIGSetFont(TiquF.EditF.tet,14,"OUTLINE")
	TiquF.EditF.tet:SetTextColor(0.6, 0.6, 0.6, 1)
	TiquF.EditF.tet:SetAutoFocus(false)
	TiquF.EditF.tet:SetMultiLine(true)
	TiquF.EditF.tet:SetMaxLetters(999)
	TiquF.EditF.tet:EnableMouse(true)
	TiquF.EditF.tet.tishi = PIGFontString(TiquF.EditF.tet,{"TOPLEFT",TiquF.EditF.tet,"TOPLEFT",2,-0},L["CHAT_KEYWORD_TI"]);
	TiquF.EditF.tet.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
	TiquF.EditF.tet:SetScript("OnTextChanged", function(self)
		local txtv = self:GetText()
		if txtv=="" or txtv==" " then
			self.tishi:Show()
		else
			self.tishi:Hide()
		end
	end);
	TiquF.EditF.tet:SetScript("OnShow", function(self)
		self:SetText(PIGA["Chat"]["Tiqu"]["Keys"])
	end);
	TiquF.EditF.tet:SetScript("OnEscapePressed", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1)
		TiquF.EditF.SAVEBUT:Hide()
		self:ClearFocus()
	end);
	TiquF.EditF.tet:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1)
		TiquF.EditF.SAVEBUT:Show()
	end);
	TiquF.EditF.tet:SetScript("OnEnterPressed", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1)
		Save_KeyValue(self)
		self:ClearFocus()
		TiquF.EditF.SAVEBUT:Hide()
	end);

	TiquF.EditF.SAVEBUT = PIGButton(TiquF.EditF,{"BOTTOMLEFT",TiquF.EditF,"TOPLEFT",10,4},{60,22},SAVE)
	TiquF.EditF.SAVEBUT.T = PIGFontString(TiquF.EditF.SAVEBUT,{"LEFT",TiquF.EditF.SAVEBUT, "RIGHT", 4,0},"输入完记得保存！")
	TiquF.EditF.SAVEBUT.T:SetTextColor(1, 0, 0, 1)
	TiquF.EditF.SAVEBUT:Hide()
	TiquF.EditF.SAVEBUT:SetScript("OnClick", function(self)
		local fujif = self:GetParent();
		Save_KeyValue(fujif.tet)
		fujif.tet:ClearFocus()
		fujif.tet:SetTextColor(0.6, 0.6, 0.6, 1)
		self:Hide()
	end)
	TiquF.EditF.tishi=PIGFontString(TiquF.EditF,{"TOPLEFT",TiquF.EditF,"BOTTOMLEFT",10,-2},L["CHAT_KEYWORD_NAME"]..L["CHAT_KEYWORD_NAME2"])
	TiquF.EditF.tishi:SetJustifyH("LEFT");
	TiquF.EditF.tishi:SetTextColor(0, 1, 0, 1)
	--------
	TiquF.tiquOKAudioOpen = PIGCheckbutton(TiquF,{"TOPLEFT",TiquF,"TOPLEFT",20,-200},{L["CHAT_KEYWORD_SET1"]})
	TiquF.tiquOKAudioOpen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Tiqu"]["AudioOpen"]=true
			TiquCanshu["AudioOpen"]=true
		else
			PIGA["Chat"]["Tiqu"]["AudioOpen"]=false
			TiquCanshu["AudioOpen"]=false
		end
	end);
	TiquF.tiquOKAudioOpen.List=PIGDownMenu(TiquF.tiquOKAudioOpen,{"LEFT",TiquF.tiquOKAudioOpen.Text,"RIGHT",2,0},{180,nil})
	function TiquF.tiquOKAudioOpen.List:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#AudioData.FollowMsg,1 do
		    info.text, info.arg1 = AudioData.FollowMsg[i][1], i
		    info.checked = i==TiquCanshu["Audio"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function TiquF.tiquOKAudioOpen.List:PIGDownMenu_SetValue(value,arg1)
		self:PIGDownMenu_SetText(value)
		PIGA["Chat"]["Tiqu"]["Audio"]=arg1
		TiquCanshu["Audio"]=arg1
		PIGCloseDropDownMenus()
	end
	TiquF.tiquOKAudioOpen.PlayBut =PIGDiyBut(TiquF.tiquOKAudioOpen,{"LEFT",TiquF.tiquOKAudioOpen.List,"RIGHT",4,0},{28,28,nil,nil,"chatframe-button-icon-speaker-on",130757});
	TiquF.tiquOKAudioOpen.PlayBut:SetScript("OnClick", function()
		PIG_PlaySoundFile(AudioData.FollowMsg[TiquCanshu["Audio"]])
	end)
	--继承黑名单
	TiquF.jichengBlack = PIGCheckbutton(TiquF,{"TOPLEFT",TiquF.tiquOKAudioOpen,"BOTTOMLEFT",0,-20},{"继承"..L["CHAT_FILTERS"]..SETTINGS.."再"..L["CHAT_KEYWORD_NAME1"],"继承过滤设置，过滤黑名单内容后再提取关注消息"})
	TiquF.jichengBlack:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Tiqu"]["jichengBlack"]=true
			TiquCanshu["jichengBlack"]=true
		else
			PIGA["Chat"]["Tiqu"]["jichengBlack"]=false
			TiquCanshu["jichengBlack"]=false
		end
	end);
	--输出方式
	function KeywordF.Options_SetFun()
		if PIGA["Chat"]["Tiqu"]["Open"] then
			TiquF.EditF:Show()
			TiquF.tiquOKAudioOpen:Show()
			TiquF.jichengBlack:Show()
			TiquF.OutputModeF:Show()
			if TiquCanshu["shuchumode"]==1 then
				TiquF.OutputMode_2:SetChecked(false)
				TiquF.OutputMode_1:SetChecked(true)
				TiquF.OutputModeF.Color:Hide()
				TiquF.OutputModeF.CombatHide:Hide()
				TiquF.OutputModeF.GaoduHSlider:Hide()
				TiquF.OutputModeF.shuvhudaoBOX:Show()
				TiquF.OutputModeF.tiquOKFlash:Show()
			elseif TiquCanshu["shuchumode"]==2 then
				TiquF.OutputMode_1:SetChecked(false)
				TiquF.OutputMode_2:SetChecked(true)
				TiquF.OutputModeF.shuvhudaoBOX:Hide()
				TiquF.OutputModeF.tiquOKFlash:Hide()
				TiquF.OutputModeF.Color:Show()
				TiquF.OutputModeF.CombatHide:Show()
				TiquF.OutputModeF.GaoduHSlider:Show()
			end
		else
			TiquF.EditF:Hide()
			TiquF.tiquOKAudioOpen:Hide()
			TiquF.jichengBlack:Hide()
			TiquF.OutputModeF:Hide()
		end
	end
	TiquF.OutputModeF=PIGFrame(TiquF,{"BOTTOMLEFT",TiquF,"BOTTOMLEFT",6,6})
	TiquF.OutputModeF:SetPoint("BOTTOMRIGHT",TiquF,"BOTTOMRIGHT",-6,6);
	TiquF.OutputModeF:SetHeight(120)
	TiquF.OutputModeF:PIGSetBackdrop(0)
	TiquF.OutputModeF.biaoti = PIGFontString(TiquF.OutputModeF,{"BOTTOMLEFT",TiquF.OutputModeF,"TOPLEFT",14,6},"输出方式: ")
	TiquF.OutputMode_1 = PIGCheckbutton(TiquF.OutputModeF,{"LEFT",TiquF.OutputModeF.biaoti,"RIGHT",10,0},{"系统聊天窗口"})
	TiquF.OutputMode_1:SetScript("OnClick", function (self)
		PIGA["Chat"]["Tiqu"]["shuchumode"]=1
		TiquCanshu["shuchumode"]=1
		KeywordF.Options_SetFun()
		KeywordF.Tiqu_SetFun()
	end);
	TiquF.OutputMode_2 = PIGCheckbutton(TiquF.OutputModeF,{"LEFT",TiquF.OutputMode_1.Text,"RIGHT",20,0},{"独立聊天窗口"})
	TiquF.OutputMode_2:SetScript("OnClick", function (self)
		PIGA["Chat"]["Tiqu"]["shuchumode"]=2
		TiquCanshu["shuchumode"]=2
		KeywordF.Options_SetFun()
		KeywordF.Tiqu_SetFun()
	end);
	
	TiquF.OutputModeF.shuvhudaoBOX=PIGDownMenu(TiquF.OutputModeF,{"TOPLEFT",TiquF.OutputModeF,"TOPLEFT",140,-20},{120,nil})
	TiquF.OutputModeF.shuvhudaoBOX.t = PIGFontString(TiquF.OutputModeF.shuvhudaoBOX,{"RIGHT",TiquF.OutputModeF.shuvhudaoBOX, "LEFT", -2,0},L["CHAT_KEYWORD_SET2"])
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
	function TiquF.OutputModeF.shuvhudaoBOX:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		local chuangkoulist=GetpindaoList()
		for k,v in pairs(chuangkoulist) do
		 	info.text, info.arg1 = v, k
		 	info.checked = k ==TiquCanshu["ChatWox"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function TiquF.OutputModeF.shuvhudaoBOX:PIGDownMenu_SetValue(value,arg1)
		self:PIGDownMenu_SetText(value)
		PIGA["Chat"]["Tiqu"]["ChatWox"]=arg1
		TiquCanshu["ChatWox"]=arg1
		PIGCloseDropDownMenus()
	end
	TiquF.OutputModeF.tiquOKFlash = PIGCheckbutton(TiquF.OutputModeF,{"TOPLEFT",TiquF.OutputModeF.shuvhudaoBOX.t,"BOTTOMLEFT",0,-24},{"提取成功窗口标签闪动"})
	TiquF.OutputModeF.tiquOKFlash:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Tiqu"]["tiquOKFlash"]=true
			TiquCanshu["tiquOKFlash"]=true
		else
			PIGA["Chat"]["Tiqu"]["tiquOKFlash"]=false
			TiquCanshu["tiquOKFlash"]=false
		end
	end);
	---2
	TiquF.OutputModeF.Color = Create.ColorBut(TiquF.OutputModeF,{"TOPLEFT",TiquF.OutputModeF,"TOPLEFT",40,-20},{18,18})
	TiquF.OutputModeF.Color.morenColor={0,0,0,0.4}
	function TiquF.OutputModeF.Color:PIGinitialize()
		self.pezhiV=PIGA["Chat"]["Tiqu"]["BgColor"]
	end
	function TiquF.OutputModeF.Color:PIGSetValue(newR, newG, newB, newA)
		PIGA["Chat"]["Tiqu"]["BgColor"]={newR, newG, newB, newA}
		ChatF99.Background:SetVertexColor(newR, newG, newB, newA)
	end
	TiquF.OutputModeF.Color.t = PIGFontString(TiquF.OutputModeF.Color,{"LEFT",TiquF.OutputModeF.Color,"RIGHT",4,0},"背景颜色")
	local miyumorenColor=PIGA["Chat"]["Tiqu"]["BgColor"] or TiquF.OutputModeF.Color.morenColor
	ChatF99.Background:SetVertexColor(unpack(miyumorenColor))

	TiquF.OutputModeF.CombatHide = PIGCheckbutton(TiquF.OutputModeF,{"TOPLEFT",TiquF.OutputModeF,"TOPLEFT",220,-20},{"战斗中隐藏"})
	TiquF.OutputModeF.CombatHide:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Tiqu"]["CombatHide"]=true
		else
			PIGA["Chat"]["Tiqu"]["CombatHide"]=false
		end
		KeywordF.Tiqu_SetFun()
	end);
	--高度
	TiquF.OutputModeF.GaoduHSlider =PIGSlider(TiquF.OutputModeF,{"TOPLEFT",TiquF.OutputModeF.Color.t,"BOTTOMLEFT",14,-20},{100,500,1})
	TiquF.OutputModeF.GaoduHSlider.T = PIGFontString(TiquF.OutputModeF.GaoduHSlider,{"RIGHT",TiquF.OutputModeF.GaoduHSlider,"LEFT",-4,0},"高度：");
	TiquF.OutputModeF.GaoduHSlider.Slider:HookScript("OnValueChanged", function(self, arg1)
		ChatF99:SetHeight(arg1)
		PIGA["Chat"]["Tiqu"]["KeywordFHeight"]=arg1
	end)

	TiquF.OutputModeF:HookScript("OnShow", function(self)
		self.shuvhudaoBOX:PIGDownMenu_SetText(chuangkoulist[TiquCanshu["ChatWox"]])	
		self.tiquOKFlash:SetChecked(TiquCanshu["tiquOKFlash"])
		self.GaoduHSlider:PIGSetValue(PIGA["Chat"]["Tiqu"]["KeywordFHeight"]);
		self.CombatHide:SetChecked(PIGA["Chat"]["Tiqu"]["CombatHide"])
		local miyumorenColor=PIGA["Chat"]["Tiqu"]["BgColor"] or TiquF.OutputModeF.Color.morenColor
		self.Color:ShowButColor(unpack(miyumorenColor))
	end);
	TiquF:HookScript("OnShow", function(self)
		self.KeyOpen:SetChecked(PIGA["Chat"]["Tiqu"]["Open"])
		self.tiquOKAudioOpen:SetChecked(PIGA["Chat"]["Tiqu"]["AudioOpen"])
		self.tiquOKAudioOpen.List:PIGDownMenu_SetText(AudioData.FollowMsg[TiquCanshu["Audio"]][1])
		self.jichengBlack:SetChecked(PIGA["Chat"]["Tiqu"]["jichengBlack"])
		KeywordF.Options_SetFun()
	end);
	------------------
	local TardisGetMsg=Data.Tardis.GetMsg
	local Show_MSG_TIMECD = 0
	local CHANNELinfo = ChatTypeInfo["CHANNEL"];
	local ChatFrame_ReplaceIconAndGroupExpressions=C_ChatInfo and C_ChatInfo.ReplaceIconAndGroupExpressions or ChatFrame_ReplaceIconAndGroupExpressions
	local function Show_Keyword_MSG(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
		local timetxt=GetServerTime()
		local outMsg = ChatFrame_ReplaceIconAndGroupExpressions(arg1, arg17, not ChatFrame_CanChatGroupPerformExpressionExpansion("CHANNEL"));
		local outMsg = TihuanBiaoqing(outMsg)
		local coloredName = GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		local PlayerLink = GetPlayerLink(arg2, ("[%s]"):format(coloredName))
		if PIGA["Chat"]["ShowZb"] then
			local _, _, _, englishRace, sex = GetPlayerInfoByGUID(arg12)
			local raceX = GetRaceClassTXT(0,500,englishRace,sex)
			PlayerLink = "|Hgarrmission:"..arg2.."|h"..raceX.."|h "..PlayerLink
		end
		if not InCombatLockdown() and timetxt-Show_MSG_TIMECD>30 then
			Show_MSG_TIMECD=timetxt
			if TiquCanshu["AudioOpen"] then
				PIG_PlaySoundFile(AudioData.FollowMsg[TiquCanshu["Audio"]]);
			end
		end
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
	end
	local tiquchongfuData={}
	local function IsKeywordMatch(zuheBL,newText)
		for xx=1,#zuheBL do
			local nobh = zuheBL[xx]:sub(1,1)
			if nobh=="&" then
				local nobht = zuheBL[xx]:sub(2,-1)
				if newText:match(nobht) then
					return false
				end
			else
				if not newText:match(zuheBL[xx]) then
					return false
				end
			end
		end
		return true
	end
	local function replaceChar(str, start, over)
		return str:sub(1, start-1) .. "|cff00FF00"..str:sub(start, over) .."|r".. str:sub(over+1)
	end
	local function TXTgsub(txtmsg,key)
		local paichuinfo = gsub_NOlink(txtmsg)
		local oldover = 0
		for _ in txtmsg:gmatch(key) do
			local olds, olde = txtmsg:find(key,oldover+1)
			if olds and olde then
				if Is_IndexContain(paichuinfo,olds,olde) then

				else
					local txtmsg1=replaceChar(txtmsg, olds, olde)
					return txtmsg1 or ""
				end
				oldover = olde
			end
		end
		return txtmsg or ""
	end
	local function tiquKeysFun(event, ...)
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17=...
		if not arg12 then return end
		if arg9=="MeetingHorn" then return end
		if arg9=="PIG" then return end
		for i=1,#TardisGetMsg do
			if arg1==TardisGetMsg[i] then return end
		end
		if arg2==PIG_OptionsUI.AllName then return end--自身不过滤
		local blnum = #White_keywords
		if blnum==0 then return end
		if TiquCanshu["jichengBlack"] then
			if BlackList["BlackName"] and FilterBlack_Name(arg2) then
				return
			end
			if BlackList["IGNORE_DND"] and arg6=="DND" then
				return
			end
		end
		local newText = del_link(arg1)
		local newText = del_biaoqing(newText)
		local newText = del_biaodian(newText)
		if TiquCanshu["jichengBlack"] then
			if FilterBlack_Key(newText) then
				return
			end
		end
		if BlackList["FilterRepeat"] and FilterBlack_Chongfu(tiquchongfuData,newText,"tiqu") then
			return
		end				
		for x=1,blnum do
			if type(White_keywords[x])=="string" then
				if newText:match(White_keywords[x]) then
					local newarg1=TXTgsub(arg1,White_keywords[x])
					return Show_Keyword_MSG(event, newarg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
				end
			elseif type(White_keywords[x])=="table" then
				if IsKeywordMatch(White_keywords[x],newText) then
					local newarg1=arg1
					for xx=1,#White_keywords[x] do
						newarg1=TXTgsub(newarg1,White_keywords[x][xx])
					end	
					return Show_Keyword_MSG(event, newarg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
				end
			end
		end
	end
	TiquF:HookScript("OnEvent", function (self,event,...)
		if event == "PLAYER_REGEN_DISABLED" then
			ChatF99:Hide()
		elseif event == "PLAYER_REGEN_ENABLED" then
			ChatF99:Show()
		else
			if TiquCanshu["shuchumode"]==2 or TiquCanshu["shuchumode"]==1 and TiquCanshu["ChatWox"]>0 then
				tiquKeysFun(event,...)
			end
		end
	end)

	--过滤
	local BlackF=PIGOptionsList_R(KeywordF.F,L["CHAT_FILTERSTAB"],60,"Left")
	BlackF.F=PIGOptionsList_RF(BlackF)
	--设置
	BlackF.F.SetF,BlackF.F.SetTabBut=PIGOptionsList_R(BlackF.F,SETTINGS,70)
	BlackF.F.SetF:Show()
	BlackF.F.SetTabBut:Selected()
	----
	BlackList["BlackName"]=PIGA["Chat"]["Filter"]["BlackName"]
	BlackList["IGNORE_DND"]=PIGA["Chat"]["Filter"]["IGNORE_DND"]
	BlackList["FilterRepeat"]=PIGA["Chat"]["Filter"]["FilterRepeat"]
	BlackList["Precise"]=PIGA["Chat"]["Filter"]["Precise"]

	local function FilterBlack(self,event,arg1,arg2,arg3,arg4,arg5,arg6)
		if self==ChatFrame2 or self==ChatFrame3 then return end
		--print(self:GetName(),self:IsShown())
		--local name = GetChatWindowInfo(i);
		if arg2~=PIG_OptionsUI.AllName then--自身不过滤
			BlackList["count"]=BlackList["count"]+1
			if event=="CHAT_MSG_WHISPER" then
				if FilterBlack_IsFriend(arg2,arg5) then
					return false
				end
			end
			if BlackList["BlackName"] and FilterBlack_Name(arg2) then
				BlackList["name_count"]=BlackList["name_count"]+1
				return true
			end
			if BlackList["IGNORE_DND"] and arg6=="DND" then
				BlackList["name_count"]=BlackList["name_count"]+1
				return true 
			end
			local newText = del_link(arg1)
			local newText = del_biaoqing(newText)
			local newText = del_biaodian(newText)
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
	function KeywordF.Filter_SetFun(setck)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", FilterBlack)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", FilterBlack)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY",FilterBlack)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER",FilterBlack)
		if PIGA["Chat"]["Filter"]["Open"] then
			fuFrame.Keyword.TexNO:Hide()
			local inInstance=IsInInstance()
			if PIGA["Chat"]["Filter"]["FBneiNO"] and inInstance then
				if setck then PIG_OptionsUI:ErrorMsg("|cffFF0000"..CLOSE.."|r"..INFO..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"]) end
				return 
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"] then
				ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", FilterBlack)
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"] then
				ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", FilterBlack)
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"] then
				ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", FilterBlack)
			end
			if PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"] then
				ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", FilterBlack)
			end
			if setck then PIG_OptionsUI:ErrorMsg("|cff00FF00"..ENABLE.."|r"..INFO..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"]) end
		else
			fuFrame.Keyword.TexNO:Show()
			if setck then PIG_OptionsUI:ErrorMsg("|cffFF0000"..CLOSE.."|r"..INFO..L["CHAT_KEYWORD_NAME1"]..L["CHAT_FILTERS"]) end
		end
	end
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
		fuFrame.Keyword.TexNO:Show()
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
			fuFrame.Keyword.TexNO:Hide()
		end
	end
	BlackF.F.SetF.Open = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",20,-20},{"|cff00FF00"..ENABLE.."|r"..L["CHAT_FILTERS"],ENABLE..L["CHAT_FILTERS"]})
	BlackF.F.SetF.Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["Open"]=true
		else
			PIGA["Chat"]["Filter"]["Open"]=false
		end
		Filter_Open()
		KeywordF.Filter_SetFun(true)
	end)
	BlackF.F.SetF.Filter_pindao = PIGFontString(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",40,-60},CHOOSE..L["CHAT_FILTERS"]..CHANNEL)
	BlackF.F.SetF.Filter_CHANNEL = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_pindao,"BOTTOMLEFT",10,-10},{"|cffFF0000"..L["CHAT_FILTERS"].."|r |cffFFC0C0[数字"..CHANNEL.."]|r",L["CHAT_FILTERS"].."数字"..CHANNEL})
	BlackF.F.SetF.Filter_CHANNEL:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"]=true
		else
			PIGA["Chat"]["Filter"]["FilterChannel"]["CHANNEL"]=false
		end
		Filter_Open()
		KeywordF.Filter_SetFun(true)
	end);
	BlackF.F.SetF.Filter_YELL = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_CHANNEL,"BOTTOMLEFT",0,-10},{"|cffFF0000"..L["CHAT_FILTERS"].."|r |cffFF4040["..YELL.."]|r",L["CHAT_FILTERS"]..YELL})
	BlackF.F.SetF.Filter_YELL:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"]=true
		else
			PIGA["Chat"]["Filter"]["FilterChannel"]["YELL"]=false
		end
		Filter_Open()
		KeywordF.Filter_SetFun(true)
	end);
	BlackF.F.SetF.Filter_SAY = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_YELL,"BOTTOMLEFT",0,-10},{"|cffFF0000"..L["CHAT_FILTERS"].."|r |cffFFFFFF["..SAY.."]|r",L["CHAT_FILTERS"]..SAY})
	BlackF.F.SetF.Filter_SAY:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"]=true
		else
			PIGA["Chat"]["Filter"]["FilterChannel"]["SAY"]=false
		end
		Filter_Open()
		KeywordF.Filter_SetFun(true)
	end);
	BlackF.F.SetF.Filter_WHISPER = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.Filter_SAY,"BOTTOMLEFT",0,-10},{"|cffFF0000"..L["CHAT_FILTERS"].."|r |cffFF80FF["..WHISPER.."]|r非"..FRIEND,L["CHAT_FILTERS"].."非"..FRIEND..WHISPER})
	BlackF.F.SetF.Filter_WHISPER:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"]=true
		else
			PIGA["Chat"]["Filter"]["FilterChannel"]["WHISPER"]=false
		end
		Filter_Open()
		KeywordF.Filter_SetFun(true)
	end);

	BlackF.F.SetF.IGNOREinfot = PIGFontString(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",40,-210},CHOOSE..IGNORE..INFO)
	BlackF.F.SetF.BlackName = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.IGNOREinfot,"BOTTOMLEFT",10,-10},{"|cffFF0000"..IGNORE.."|r ["..L["CHAT_BLACK_NAME"]..PLAYER.."]",L["CHAT_BLACK_NAME"]..PLAYER})
	BlackF.F.SetF.BlackName:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["BlackName"]=true
			BlackList["BlackName"]=true
		else
			PIGA["Chat"]["Filter"]["BlackName"]=false
			BlackList["BlackName"]=false
		end
	end);
	BlackF.F.SetF.IGNORE_DND = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.BlackName,"BOTTOMLEFT",0,-10},{"|cffFF0000"..IGNORE.."|r |cffFFC0C0[勿扰"..PLAYER.."]|r",IGNORE.."勿扰"..PLAYER})
	BlackF.F.SetF.IGNORE_DND:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["IGNORE_DND"]=true
			BlackList["IGNORE_DND"]=true
		else
			PIGA["Chat"]["Filter"]["IGNORE_DND"]=false
			BlackList["IGNORE_DND"]=true
		end
	end);
	BlackF.F.SetF.FilterRepeat = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF.IGNORE_DND,"BOTTOMLEFT",0,-10},{"|cffFF0000"..IGNORE.."|r ["..L["CHAT_BLACK_SET1"][1].."]",string.format(L["CHAT_BLACK_SET1"][2],1)})
	BlackF.F.SetF.FilterRepeat:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["FilterRepeat"]=true
			BlackList["FilterRepeat"]=true
		else
			PIGA["Chat"]["Filter"]["FilterRepeat"]=false
			BlackList["FilterRepeat"]=false
		end
	end);
	BlackF.F.SetF.FBneiNO = PIGCheckbutton(BlackF.F.SetF,{"TOPLEFT",BlackF.F.SetF,"TOPLEFT",40,-350},{"副本内停止过滤","过滤需要占用少量性能，当电脑性能较差情况下可以开启此项"})
	BlackF.F.SetF.FBneiNO:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["FBneiNO"]=true
		else
			PIGA["Chat"]["Filter"]["FBneiNO"]=false
		end
		KeywordF.Filter_SetFun(true)
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
			PIGA["Chat"]["Filter"]=addonTable.Default["Chat"]["Filter"]
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	BlackF.F.SetF:HookScript("OnShow", function(self)
		Filter_Open()
	end);
	BlackF.F.SetF:RegisterEvent("PLAYER_ENTERING_WORLD");
	BlackF.F.SetF:HookScript("OnEvent", function(self,event,arg1,arg2)
		if event=="PLAYER_ENTERING_WORLD" then
			KeywordF.Filter_SetFun()
		end
	end)
	
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
	BlackF.F.ReportF.nameblack = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.black, "BOTTOMLEFT", 20, -10},IGNORE_PLAYER..":")
	BlackF.F.ReportF.nameblack:SetTextColor(0.6, 0.6, 0.6, 1)
	BlackF.F.ReportF.nameblackV = PIGFontString(BlackF.F.ReportF,{"LEFT", BlackF.F.ReportF.nameblack, "RIGHT", 4, 0},"0")
	BlackF.F.ReportF.nameblackV:SetTextColor(1, 1, 1, 1)
	BlackF.F.ReportF.wordblack = PIGFontString(BlackF.F.ReportF,{"TOPLEFT", BlackF.F.ReportF.nameblack, "BOTTOMLEFT", 0, -10},BAG_FILTER_JUNK..INFO..":")
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
	BlackF.F.BlackF=PIGOptionsList_R(BlackF.F,L["CHAT_KEYWORD"]..L["CHAT_BLACK_NAME"],110)
	local tishineiB = "|cffFF0000"..L["CHAT_KEYWORD"]..L["CHAT_BLACK_NAME"].."("..L["CHAT_BLACK_NAME"].."账号共享)|r\n|cffFFFF00"..L["CHAT_BLACK_EITB"].."|r"
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
	local PlayerBlackList = "血月，雪月，升级，声望"
	---------
	local function Delchongfu(TxT)
		local TxT = TxT:gsub("，", ",")
		local data = Key_fenge(TxT, ",")
	    local seen = {}  
	    for i=#data,1,-1 do
	    	if seen[data[i]] then 
	    		table.remove(data,i) 
	        else
	           	seen[data[i]] = true
	        end
	    end
	    local Newtxt = ""
	    for i=1,#data do
	    	if i==#data then
	    		Newtxt=Newtxt..data[i]
	    	else
	     		Newtxt=Newtxt..data[i].."，"
	     	end
	    end 
	    return Newtxt
	end
	local function zairuBlackFun()
		local BlackListX={["word"]={},["name"]={}}
		local keyslist = PIGA["Chat"]["Filter"]["Blacks"]
		local keyslist = keyslist:gsub("，", ",")
		local fengelist = Key_fenge(keyslist, ",", true)
		for i=1,#fengelist do
			local newTxT=fengelist[i]
			if newTxT:match("#") then
				local newTxT_1 = Key_fenge(newTxT, "#",true)
				table.insert(BlackListX["word"], newTxT_1);
			else
				table.insert(BlackListX["word"], newTxT);
			end
		end
		local P_keyslist = PIGA["Chat"]["Filter"]["Blacks_P"]
		local P_keyslist = P_keyslist:gsub("，", ",")
		local P_fengelist = Key_fenge(P_keyslist, ",", true)
		for i=1,#P_fengelist do
			local newTxT=P_fengelist[i]
			if newTxT:match("#") then
				local newTxT_1 = Key_fenge(newTxT, "#",true)
				table.insert(BlackListX["name"], newTxT_1);
			else
				table.insert(BlackListX["name"], newTxT);
			end
		end
		return BlackListX["word"],BlackListX["name"]
	end
	BlackList["word"],BlackList["name"]=zairuBlackFun()
	local function Save_BlackValue(fuji,peizhiV)
		local value = fuji:GetText();
		local value = value:gsub(" ", "")
		if peizhiV~="Blacks_P" then
			value=value:upper()
		end
		local value=Delchongfu(value)
		PIGA["Chat"]["Filter"][peizhiV]=value
	 	BlackList["word"],BlackList["name"]=zairuBlackFun()
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
		self:SetText(PIGA["Chat"]["Filter"]["Blacks"])
	end);
	BlackF.F.BlackF.NR.textArea:SetScript("OnEscapePressed", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1)
		BlackF.F.BlackF.NR.SAVEBUT:Hide()
		self:ClearFocus()
	end);
	BlackF.F.BlackF.NR.textArea:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1)
		BlackF.F.BlackF.NR.SAVEBUT:Show()
	end);
	BlackF.F.BlackF.NR.textArea:SetScript("OnEnterPressed", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1)
		Save_BlackValue(self,"Blacks")
		BlackF.F.BlackF.NR.textArea:SetText(PIGA["Chat"]["Filter"]["Blacks"])
		self:ClearFocus()
		BlackF.F.BlackF.NR.SAVEBUT:Hide()
	end);
	BlackF.F.BlackF.NR.textArea:SetScript("OnTextChanged", function(self)
		local txtv = self:GetText()
		if txtv=="" or txtv==" " then
			self.tishi:Show()
		else
			self.tishi:Hide()
		end
	end);
	BlackF.F.BlackF.NR.SAVEBUT = PIGButton(BlackF.F.BlackF.NR,{"BOTTOMRIGHT",BlackF.F.BlackF.NR,"TOPRIGHT",-10,2},{60,20},SAVE)
	BlackF.F.BlackF.NR.SAVEBUT:Hide()
	BlackF.F.BlackF.NR.SAVEBUT:SetScript("OnClick", function(self)
		local fujif = self:GetParent();
		Save_BlackValue(fujif.textArea,"Blacks")
		BlackF.F.BlackF.NR.textArea:SetText(PIGA["Chat"]["Filter"]["Blacks"])
		fujif.textArea:ClearFocus()
		fujif.textArea:SetTextColor(0.6, 0.6, 0.6, 1)
		self:Hide()
	end)
	BlackF.F.BlackF.NR.morenkey = PIGButton(BlackF.F.BlackF.NR,{"BOTTOMRIGHT",BlackF.F.BlackF.NR,"TOPRIGHT",-10,40},{114,20},"载入预置黑名单")
	BlackF.F.BlackF.NR.morenkey:SetScript("OnClick", function(self)
		BlackF.F.BlackF.NR.textArea:SetText(Keywords)
		local fujif = self:GetParent();
		Save_BlackValue(fujif.textArea,"Blacks")
		BlackF.F.BlackF.NR.textArea:SetText(PIGA["Chat"]["Filter"]["Blacks"])
		PIG_OptionsUI:ErrorMsg("已载入预置黑名单");
	end)

	---玩家名黑名单
	BlackF.F.BlackF_P=PIGOptionsList_R(BlackF.F,PLAYER..L["CHAT_BLACK_NAME"],90)
	local P_tishineiB = "|cffFF0000"..PLAYER..L["CHAT_BLACK_NAME"].."(玩家信息将被"..IGNORE..","..L["CHAT_BLACK_NAME"].."账号共享)|r\n|cffFFFF00"..CALENDAR_PLAYER_NAME..L["CHAT_KEYWORD_TI_1"].."|r"
	BlackF.F.BlackF_P.tishi1 = PIGFontString(BlackF.F.BlackF_P,{"TOPLEFT",BlackF.F.BlackF_P,"TOPLEFT",10,-8},P_tishineiB);
	BlackF.F.BlackF_P.tishi1:SetJustifyH("LEFT");

	BlackF.F.BlackF_P.NR = PIGFrame(BlackF.F.BlackF_P);
	BlackF.F.BlackF_P.NR:PIGSetBackdrop()
	BlackF.F.BlackF_P.NR:SetPoint("TOPLEFT",BlackF.F.BlackF_P,"TOPLEFT",0,-70);
	BlackF.F.BlackF_P.NR:SetPoint("BOTTOMRIGHT",BlackF.F.BlackF_P,"BOTTOMRIGHT",0,0);
	BlackF.F.BlackF_P.NR.scroll = CreateFrame("ScrollFrame", nil, BlackF.F.BlackF_P.NR, "UIPanelScrollFrameTemplate")
	BlackF.F.BlackF_P.NR.scroll:SetPoint("TOPLEFT", BlackF.F.BlackF_P.NR, "TOPLEFT", 6, -2)
	BlackF.F.BlackF_P.NR.scroll:SetPoint("BOTTOMRIGHT", BlackF.F.BlackF_P.NR, "BOTTOMRIGHT", -20, 2)
	BlackF.F.BlackF_P.NR.scroll.ScrollBar:SetScale(0.8);
	BlackF.F.BlackF_P.NR.textArea = CreateFrame("EditBox", nil, BlackF.F.BlackF_P.NR,"BackdropTemplate")
	BlackF.F.BlackF_P.NR.textArea:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
	BlackF.F.BlackF_P.NR.textArea:SetBackdropColor(0.2, 0.2, 0.2, 0.8);
	BlackF.F.BlackF_P.NR.textArea:SetWidth(BlackF.F.BlackF_P.NR:GetWidth()-24)
	PIGSetFont(BlackF.F.BlackF_P.NR.textArea,14,"OUTLINE")
	BlackF.F.BlackF_P.NR.textArea:SetTextColor(0.6, 0.6, 0.6, 1)
	BlackF.F.BlackF_P.NR.textArea:SetAutoFocus(false)
	BlackF.F.BlackF_P.NR.textArea:SetMultiLine(true)
	BlackF.F.BlackF_P.NR.textArea:SetMaxLetters(9999)
	BlackF.F.BlackF_P.NR.textArea:EnableMouse(true)
	BlackF.F.BlackF_P.NR.scroll:SetScrollChild(BlackF.F.BlackF_P.NR.textArea)
	BlackF.F.BlackF_P.NR.textArea.tishi = PIGFontString(BlackF.F.BlackF_P.NR.textArea,{"TOPLEFT",BlackF.F.BlackF_P.NR.textArea,"TOPLEFT",2,-0},L["CHAT_KEYWORD_TI"]);
	BlackF.F.BlackF_P.NR.textArea.tishi:SetTextColor(0.8, 0.8, 0.8, 0.8);
	BlackF.F.BlackF_P.NR.textArea:SetScript("OnShow", function(self)
		self:SetText(PIGA["Chat"]["Filter"]["Blacks_P"])
	end);
	BlackF.F.BlackF_P.NR.textArea:SetScript("OnEscapePressed", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1)
		BlackF.F.BlackF_P.NR.SAVEBUT:Hide()
		self:ClearFocus()
	end);
	BlackF.F.BlackF_P.NR.textArea:SetScript("OnEditFocusGained", function(self)
		self:SetTextColor(1, 1, 1, 1)
		BlackF.F.BlackF_P.NR.SAVEBUT:Show()
	end);
	BlackF.F.BlackF_P.NR.textArea:SetScript("OnEnterPressed", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1)
		Save_BlackValue(self,"Blacks_P")
		self:ClearFocus()
		BlackF.F.BlackF_P.NR.SAVEBUT:Hide()
	end);
	BlackF.F.BlackF_P.NR.textArea:SetScript("OnTextChanged", function(self)
		local txtv = self:GetText()
		if txtv=="" or txtv==" " then
			self.tishi:Show()
		else
			self.tishi:Hide()
		end
	end);
	BlackF.F.BlackF_P.NR.SAVEBUT = PIGButton(BlackF.F.BlackF_P.NR,{"BOTTOMRIGHT",BlackF.F.BlackF_P.NR,"TOPRIGHT",-10,2},{60,20},SAVE)
	BlackF.F.BlackF_P.NR.SAVEBUT:Hide()
	BlackF.F.BlackF_P.NR.SAVEBUT:SetScript("OnClick", function(self)
		local fujif = self:GetParent();
		Save_BlackValue(fujif.textArea,"Blacks_P")
		fujif.textArea:ClearFocus()
		fujif.textArea:SetTextColor(0.6, 0.6, 0.6, 1)
		self:Hide()
	end)
	BlackF.F.BlackF_P.NR.morenkey = PIGButton(BlackF.F.BlackF_P.NR,{"BOTTOMRIGHT",BlackF.F.BlackF_P.NR,"TOPRIGHT",-10,40},{114,20},"载入预置黑名单")
	BlackF.F.BlackF_P.NR.morenkey:SetScript("OnClick", function(self)
		BlackF.F.BlackF_P.NR.textArea:SetText(PlayerBlackList)
		local fujif = self:GetParent();
		Save_BlackValue(fujif.textArea,"Blacks_P")
		PIG_OptionsUI:ErrorMsg("已载入预置黑名单");
	end)
	BlackF.F.BlackF_P.NR.Precise = PIGCheckbutton(BlackF.F.BlackF_P.NR,{"BOTTOMLEFT",BlackF.F.BlackF_P.NR,"TOPLEFT",10,8},{AH_EXACT_MATCH..CALENDAR_PLAYER_NAME,"默认玩家姓名包含设置关键字则屏蔽玩家消息，开启本选项后玩家姓名和下方关键字完全相同才会屏蔽"})
	BlackF.F.BlackF_P.NR.Precise:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Chat"]["Filter"]["Precise"]=true
			BlackList["Precise"]=true
		else
			PIGA["Chat"]["Filter"]["Precise"]=false
			BlackList["Precise"]=false
		end
	end)
	BlackF.F.BlackF_P.NR.Precise:HookScript("OnShow", function(self)
		self:SetChecked(PIGA["Chat"]["Filter"]["Precise"])
	end);
	function fuFrame.Keyword.ClickShowTab(button)
		if button=="LeftButton" then
			if KeywordF:IsShown() then
				KeywordF:Hide()
			else
				KeywordF:Show()
			end
		else
			if PIGA["Chat"]["Filter"]["Open"] then
				PIGA["Chat"]["Filter"]["Open"]=false
				--PIGA["Chat"]["Tiqu"]["Open"]=false
			else
				PIGA["Chat"]["Filter"]["Open"]=true
				--PIGA["Chat"]["Tiqu"]["Open"]=true
			end
			--KeywordF.Tiqu_SetFun()
			KeywordF.Filter_SetFun()
			if KeywordF:IsShown() then
				KeywordF:Hide()
				KeywordF:Show()
			end
		end
	end
end