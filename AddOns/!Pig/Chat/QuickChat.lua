local addonName, addonTable = ...;
local L=addonTable.locale
local Locale=GetLocale()
------------
local Fun=addonTable.Fun
local GetPIGID=Fun.GetPIGID
local EmojiData=Fun.EmojiData
--
local Create=addonTable.Create
local PIGEnter=Create.PIGEnter
local PIGFontString=Create.PIGFontString
---
local QuickChatfun=addonTable.QuickChatfun
local jiangejuli,hangshu = 0,10;
local ChatpindaoMAX = addonTable.Fun.ChatpindaoMAX
local listDataLoc={"Emoji","SAY","YELL","PARTY","GUILD","RAID","RAID_WARNING","INSTANCE_CHAT","GENERAL","TRADE","LOOK_FOR_GROUP"}
local ChannelData={
	["SAY"]={"s",{1, 1, 1},L["CHAT_QUKBUTNAME"][1]},
	["YELL"]={"y",{1, 0.25, 0.25},L["CHAT_QUKBUTNAME"][2]},
	["PARTY"]={"p",{0.6667, 0.6667, 1},L["CHAT_QUKBUTNAME"][3],{"PARTY","PARTY_LEADER"}},
	["GUILD"]={"g",{0.25, 1, 0.25},L["CHAT_QUKBUTNAME"][4],{"GUILD","OFFICER"}},
	["RAID"]={"ra",{1, 0.498, 0},L["CHAT_QUKBUTNAME"][5],{"RAID","RAID_LEADER"}},
	["RAID_WARNING"]={"rw",{1, 0.282, 0},L["CHAT_QUKBUTNAME"][6]},
	["INSTANCE_CHAT"]={"i",{1, 0.498, 0},L["CHAT_QUKBUTNAME"][7],{"INSTANCE_CHAT","INSTANCE_CHAT_LEADER"}},
	["GENERAL"]={nil,{0.888, 0.668, 0.668},L["CHAT_QUKBUTNAME"][8]},
	["TRADE"]={nil,{0.888, 0.668, 0.668},L["CHAT_QUKBUTNAME"][9]},
	["LOOK_FOR_GROUP"]={nil,{0.888, 0.668, 0.668},L["CHAT_QUKBUTNAME"][10]},
	["CHANNEL_CATEGORY_WORLD"]={nil,{0.888, 0.668, 0.668},L["CHAT_QUKBUTNAME"][11]},
}
if PIG_MaxTocversion(30000) then
	ChannelData["INSTANCE_CHAT"][1]="bg"
end
--判断频道信息显示与否
local function GetBanChatFrame(pindaoid)
	local SetChatFrame = _G["ChatFrame"..pindaoid]
	if SetChatFrame then
		return SetChatFrame
	end
	return ChatFrame1
end
local function PIG_IsShow_Message(messageType)
	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["Chat"]["QuickChat_Ban"],true)
	local pindaomulu = {GetChatWindowMessages(pindaoid)}
	for i=1,#pindaomulu do
		if ( pindaomulu[i] == messageType ) then
			return true;
		end
	end
	return false;
end
local function PIG_IsShow_CHANNEL(pdname)
	local pindid=GetPIGID(pdname)
	if pindid==0 then
		if pdname==CHANNEL_CATEGORY_WORLD or pdname==BIGFOOTWORLD then
			for x=1,ChatpindaoMAX do
				if GetPIGID(pdname..x)>0 then
					pindid=GetPIGID(pdname..x)
					break
				end
			end
		end
		if pindid==0 then return false end
	end
	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["Chat"]["QuickChat_Ban"],true)
	local Dchannels = {GetChatWindowChannels(pindaoid)}
	for x=1,#Dchannels,2 do
		if pdname==Dchannels[x] then
			return true
		end
	end
	return false
end
-------------
local function Add_Backdrop(chatbut,Template)
	if Template=="BackdropTemplate" then
		chatbut:SetBackdrop({
			bgFile = "interface/characterframe/ui-party-background.blp", tile = true, tileSize = 0,
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8, 
			insets = { left = 2, right = 2, top = 2, bottom = 2 }});
		chatbut:SetBackdropColor(0, 0, 0, 0.5);
		chatbut:SetBackdropBorderColor(0, 0, 0, 0.8);
	end
end
local function ADD_chatbut(fuF,name)
	local dataX=ChannelData[name]
	if dataX and PIGA["Chat"]["QuickChat_ButHide"][dataX[3]] then return end
	local Width=fuF.Width
	fuF.butlist=fuF.butlist or {}
	local chatbut = CreateFrame("Button",nil,fuF, fuF.PIGTemplate[1]);
	Add_Backdrop(chatbut,fuF.PIGTemplate[1])
	chatbut:SetSize(Width,Width);
	chatbut:SetFrameStrata("LOW")
	chatbut:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	chatbut:SetScript("OnEnter", function (self)	
		fuF:PIGEnterAlpha()
	end);
	chatbut:SetScript("OnLeave", function (self)
		fuF:PIGLeaveAlpha()
	end);
	if name=="Emoji" then
		chatbut:SetPoint("LEFT",fuF,"LEFT",0,0);
		chatbut.Tex = chatbut:CreateTexture(nil, "BORDER");
		chatbut.Tex:SetTexture("Interface/AddOns/"..addonName.."/Media/Emojis/happy.tga");
		chatbut.Tex:SetPoint("CENTER",0,0);
		chatbut.Tex:SetSize(Width-10,Width-10);
		chatbut:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-1);
		end);
		chatbut:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,0);
		end);
		chatbut:SetScript("OnClick", function(self)
			if self.EmojiList:IsShown() then
				self.EmojiList:Hide()
			else
				self.EmojiList:Show()
				self.EmojiList.xiaoshidaojishi = 1.5;
				self.EmojiList.zhengzaixianshi = true;
			end
		end);
		chatbut.EmojiList = CreateFrame("Frame", nil, chatbut,"BackdropTemplate");
		chatbut.EmojiList:SetBackdrop( { 
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",tile = false, tileSize = 0,
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 8, 
			insets = { left = 2, right = 2, top = 2, bottom = 2 }});
		chatbut.EmojiList:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8);
		chatbut.EmojiList:SetBackdropColor(0.5, 0.5, 0.5, 0.8);
		chatbut.EmojiList:SetSize((Width+2)*hangshu+10,Width*6+20);
		chatbut.EmojiList:SetPoint("BOTTOMLEFT",chatbut,"TOPLEFT", 0, 0);
		chatbut.EmojiList:Hide()
		chatbut.EmojiList:SetFrameStrata("HIGH")
		chatbut.EmojiList.xiaoshidaojishi = 0;
		chatbut.EmojiList.zhengzaixianshi = nil;
		chatbut.EmojiList:SetScript("OnUpdate", function(self, ssss)
			if self.zhengzaixianshi==nil then
				return;
			else
				if self.zhengzaixianshi==true then
					if self.xiaoshidaojishi<= 0 then
						self:Hide();
						self.zhengzaixianshi = nil;
					else
						self.xiaoshidaojishi = self.xiaoshidaojishi - ssss;	
					end
				end
			end
		end)
		chatbut.EmojiList:SetScript("OnEnter", function(self)
			self.zhengzaixianshi = nil;
		end)
		chatbut.EmojiList:SetScript("OnLeave", function(self)
			self.xiaoshidaojishi = 1.5;
			self.zhengzaixianshi = true;
		end)
		chatbut.EmojiList.ButList={}
		for i=1,#EmojiData do
			local biaoqinglist = CreateFrame("Button",nil,chatbut.EmojiList,nil,i);
			chatbut.EmojiList.ButList[i]=biaoqinglist
			biaoqinglist:SetSize(Width,Width);
			if i==1 then
				biaoqinglist:SetPoint("TOPLEFT",chatbut.EmojiList,"TOPLEFT", 5, -5);
			else
				if (i - 1) % 10==0 then
					biaoqinglist:SetPoint("TOPLEFT",chatbut.EmojiList.ButList[i-10],"BOTTOMLEFT", 0, -2);
				else
					biaoqinglist:SetPoint("LEFT",chatbut.EmojiList.ButList[i-1],"RIGHT", 2, 0);
				end
			end
			biaoqinglist.Tex = biaoqinglist:CreateTexture();
			biaoqinglist.Tex:SetTexture(EmojiData[i][2]);
			biaoqinglist.Tex:SetPoint("CENTER",0,0);
			biaoqinglist.Tex:SetSize(Width,Width);
			biaoqinglist:SetScript("OnEnter", function()
				chatbut.EmojiList.zhengzaixianshi=nil
			end)
			biaoqinglist:SetScript("OnLeave", function()
				chatbut.EmojiList.xiaoshidaojishi = 1.5;
				chatbut.EmojiList.zhengzaixianshi = true;
			end)
			biaoqinglist:SetScript("OnClick", function(self)
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()..EmojiData[self:GetID()][1]
				if editBox:HasFocus() then
					editBox:SetText(hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText(hasText);
				end
				chatbut.EmojiList:Hide();
			end)
		end
	else
		table.insert(fuF.butlist,chatbut)
		fuF.tabbutList[name]=chatbut
		chatbut:HookScript("OnEnter", function (self)	
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
			if dataX[1] then
				GameTooltip:SetText("|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..VOICE_TALKING.."\n|cff00FFff"..KEY_BUTTON2.."-|r|cffFFFF00"..IGNORE.."/"..IGNORE_REMOVE.."|r");
			else
				GameTooltip:SetText("|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..CHAT_JOIN.."/"..VOICE_TALKING.."\n|cff00FFff"..KEY_BUTTON2.."-|r|cffFFFF00"..IGNORE.."/"..IGNORE_REMOVE.."|r");
			end
			GameTooltip:Show();
			GameTooltip:FadeOut()
		end);
		chatbut:HookScript("OnLeave", function (self)
			GameTooltip:ClearLines();
			GameTooltip:Hide()
		end);
		chatbut.X = chatbut:CreateTexture(nil, "OVERLAY");
		chatbut.X:SetTexture("interface/common/voicechat-muted.blp");
		chatbut.X:SetSize(Width-9,Width-9);
		chatbut.X:SetAlpha(0.7);
		chatbut.X:SetPoint("CENTER",0,0);
		chatbut.X:Hide()
		chatbut.Text = PIGFontString(chatbut,{"CENTER",chatbut,"CENTER",0,0},dataX[3],fuF.PIGTemplate[2]);
		chatbut.Text:SetTextColor(unpack(dataX[2]));
		chatbut:SetScript("OnMouseDown", function (self)
			self.Text:SetPoint("CENTER",1,-1);
		end);
		chatbut:SetScript("OnMouseUp", function (self)
			self.Text:SetPoint("CENTER",0,0);
		end);
		if dataX[1] then
			chatbut.PigxIsShown=function()
				if name=="GUILD" then
					return IsInGuild()
				elseif name=="PARTY" then
					return IsInGroup()
				elseif name=="RAID" or name=="RAID_WARNING" then
					return IsInRaid()--LE_PARTY_CATEGORY_HOME
				elseif name=="INSTANCE_CHAT" then
					return IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsInRaid(LE_PARTY_CATEGORY_INSTANCE)
				else
					return true
				end
			end
		else
			chatbut.CHANNELname=_G[name] 
		end
		chatbut:SetScript("OnClick", function(self, button)
			local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["Chat"]["QuickChat_Ban"],true)
			--local chatFrame = SELECTED_DOCK_FRAME--当前选择聊天框架
			--local SetChatFrame = DEFAULT_CHAT_FRAME
			local SetChatFrame = GetBanChatFrame(pindaoid)
			if button=="LeftButton" then
				if dataX[1] then
					AddChatWindowMessages(1, name)
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/"..dataX[1].." " .. hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/"..dataX[1].." " .. hasText);
					end
				else
					self.pindaoID = GetPIGID(self.CHANNELname)
					if self.pindaoID==0 then
						local type, name = JoinTemporaryChannel(self.CHANNELname, nil, pindaoid, 1);
						C_Timer.After(1,function()
							if GetPIGID(self.CHANNELname)>0 then
								PIGChatFrameAddChannel(SetChatFrame,self.CHANNELname)
								self.X:Hide();
								PIGprint(CHAT_JOIN..self.CHANNELname..CHANNEL.."，"..KEY_BUTTON2..IGNORE..CHANNEL..INFO);
							else
								PIGprint(CHAT_JOIN..self.CHANNELname..CHANNEL..FAILED.."，请稍后再试");
							end
						end)
						return
					end
					PIGChatFrameAddChannel(SetChatFrame,self.CHANNELname)
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/"..self.pindaoID.." " ..hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/"..self.pindaoID.." " ..hasText);
					end
				end
			else
				if dataX[1] then
					if PIG_IsShow_Message(name) then
						if dataX[4] then
							for _,chanamex in pairs(dataX[4]) do
								ChatFrameMixin.RemoveMessageGroup(SetChatFrame, chanamex);
							end
						else
							ChatFrameMixin.RemoveMessageGroup(SetChatFrame, name);
						end
						PIGprint(IGNORE.._G[name]..CHANNEL..INFO);
						self.X:Show();
					else
						if dataX[4] then
							for _,chanamex in pairs(dataX[4]) do
								ChatFrameMixin.AddMessageGroup(SetChatFrame, chanamex);
							end
						else
							ChatFrameMixin.AddMessageGroup(SetChatFrame, name);
						end
						PIGprint(IGNORE_REMOVE.._G[name]..CHANNEL..INFO);
						self.X:Hide();
					end
				else
					self.pindaoID = GetPIGID(self.CHANNELname)
					if self.pindaoID>0 then
						if PIG_IsShow_CHANNEL(self.CHANNELname) then
							PIGChatFrameRemoveChannel(SetChatFrame, self.CHANNELname);
							if self.CHANNELname==GENERAL then
								PIGChatFrameRemoveChannel(SetChatFrame, L["CHAT_BENDIFUWU"]);
								PIGChatFrameRemoveChannel(SetChatFrame, L["CHAT_BENDIFANGWU"]);
								PIGChatFrameRemoveChannel(SetChatFrame, L["CHAT_WORLDFANGWU"]);
								PIGprint(IGNORE..self.CHANNELname.."/"..L["CHAT_BENDIFUWU"].."/"..L["CHAT_BENDIFANGWU"].."/"..L["CHAT_WORLDFANGWU"]..CHANNEL..INFO);
							elseif self.CHANNELname==CHANNEL_CATEGORY_WORLD then
								PIGprint(IGNORE..self.CHANNELname..CHANNEL..INFO);
							else
								PIGprint(IGNORE..self.CHANNELname..CHANNEL..INFO);
							end
							self.X:Show();
						else
							PIGChatFrameAddChannel(SetChatFrame,self.CHANNELname)
							if self.CHANNELname==GENERAL then
								PIGChatFrameAddChannel(SetChatFrame, L["CHAT_BENDIFUWU"]);
								PIGChatFrameAddChannel(SetChatFrame, L["CHAT_BENDIFANGWU"]);
								PIGChatFrameAddChannel(SetChatFrame, L["CHAT_WORLDFANGWU"]);
								PIGprint(IGNORE_REMOVE..self.CHANNELname.."/"..L["CHAT_BENDIFUWU"].."/"..L["CHAT_BENDIFANGWU"].."/"..L["CHAT_WORLDFANGWU"]..CHANNEL..INFO);
							elseif self.CHANNELname==CHANNEL_CATEGORY_WORLD then
								PIGprint(IGNORE_REMOVE..self.CHANNELname..CHANNEL..INFO);
							else
								PIGprint(IGNORE_REMOVE..self.CHANNELname..CHANNEL..INFO);
							end
							self.X:Hide();
						end
					else
						PIGprint("尚未"..CHAT_JOIN..self.CHANNELname..CHANNEL);
					end
				end
			end
		end);
	end
	return chatbut
end
--创建按钮-------
function QuickChatfun.TabBut()
	if not PIGA["Chat"]["QuickChat"] then return end
	if QuickChatfun.TabButUI then return end
	-----------------------
	if Locale == "zhCN" then
		table.insert(listDataLoc,"CHANNEL_CATEGORY_WORLD")
		if PIGA["Chat"]["BigfootWorld"] then
			BIGFOOTWORLD="大脚世界频道"
			table.insert(listDataLoc,"BIGFOOTWORLD")
			ChannelData["BIGFOOTWORLD"]={nil,{0.888, 0.668, 0.668},L["CHAT_QUKBUTNAME"][12]}
		end
	end
	local Width = 25
	local QKchatBut = CreateFrame("Frame", nil, UIParent);
	QuickChatfun.TabButUI=QKchatBut
	QKchatBut.tabbutList={}
	QKchatBut.Width=Width
	QKchatBut:SetSize(Width,Width);
	QKchatBut:SetFrameStrata("LOW")
	QKchatBut.PIGTemplate={nil,""}
	if PIGA["Chat"]["QuickChat_style"]==1 then
		QKchatBut.PIGTemplate[2]="OUTLINE"
	elseif PIGA["Chat"]["QuickChat_style"]==2 then
		QKchatBut.PIGTemplate[1]="UIMenuButtonStretchTemplate"
	elseif PIGA["Chat"]["QuickChat_style"]==3 then
		QKchatBut.PIGTemplate[1]="BackdropTemplate"
	end
	function QKchatBut:ADD_chatbutExt(icon,ww,hh,xx,yy,tisptxt)
		local extbut = CreateFrame("Button",nil,self, self.PIGTemplate[1])
		Add_Backdrop(extbut,self.PIGTemplate[1])
		extbut:SetSize(Width,Width);
		QKchatBut.butlist=QKchatBut.butlist or {}
		table.insert(QKchatBut.butlist,extbut)
		extbut.Tex = extbut:CreateTexture();
		extbut.Tex:SetTexture(icon);
		extbut.Tex:SetSize(Width+ww,Width+hh);
		extbut.Tex:SetPoint("CENTER", xx,yy);
		extbut.Tex:SetDrawLayer("BORDER", -1)
		extbut.X = extbut:CreateTexture();
		extbut.X:SetTexture("interface/common/voicechat-muted.blp");
		extbut.X:SetSize(Width-9,Width-9);
		extbut.X:SetAlpha(0.7);
		extbut.X:SetPoint("CENTER", 0, 0);
		extbut:SetScript("OnMouseDown",  function(self)
			self.Tex:SetPoint("CENTER", xx+1.5,yy-1.5);
		end)
		extbut:SetScript("OnMouseUp",  function(self)
			self.Tex:SetPoint("CENTER", xx,yy);
		end)
		PIGEnter(extbut,tisptxt)
		extbut:HookScript("OnEnter", function ()
			self:PIGEnterAlpha()
		end);
		extbut:HookScript("OnLeave", function ()
			self:PIGLeaveAlpha()
		end);
		extbut:RegisterForClicks("LeftButtonUp","RightButtonUp")
		return extbut
	end
	local function Hidebeijing(editBox)
		if ( editBox.disableActivate or ( GetCVar("chatStyle") == "classic" and not editBox.isGM ) ) then	
		else
			if ( not editBox.isGM ) then
				editBox:SetAlpha(0.1);
			end
		end
	end
	hooksecurefunc("ChatEdit_DeactivateChat", function(editBox)
		Hidebeijing(editBox)
	end)
	hooksecurefunc("ChatEdit_SetLastActiveWindow", function(editBox)
		Hidebeijing(editBox)
	end)

	function QKchatBut:PIGEnterAlpha()
		self:SetAlpha(1)
	end
	function QKchatBut:PIGLeaveAlpha()
		if PIGA["Chat"]["QuickChat_jianyin"] then self:SetAlpha(0.06) end
	end
	QKchatBut:PIGLeaveAlpha()
	local function SetEnterLeave(fuix)
		fuix:HookScript("OnEnter", function (self)	
			QKchatBut:PIGEnterAlpha()
		end);
		fuix:HookScript("OnLeave", function (self)
			QKchatBut:PIGLeaveAlpha()
		end);
	end
	for i = 1, NUM_CHAT_WINDOWS do
		local chatF = _G["ChatFrame"..i]
		SetEnterLeave(chatF)
		local chatTab = _G["ChatFrame"..i.."Tab"]
		SetEnterLeave(chatTab)
	end

	function QKchatBut:PIGUpdate_Scale()
		QKchatBut:SetScale(PIGA["Chat"]["QuickChat_suofang"]);
	end
	QKchatBut:PIGUpdate_Scale()
	---更新按钮位置
	function QKchatBut.Update_QuickChatPoint(arg1)
		local arg1=arg1 or PIGA["Chat"]["QuickChat_maodian"]
		if QKchatBut then
			QKchatBut:ClearAllPoints();	
			if arg1==1 then	
				QKchatBut:SetPoint("BOTTOMLEFT",ChatFrame1,"TOPLEFT",0+PIGA["Chat"]["QuickChat_pianyiX"],28+PIGA["Chat"]["QuickChat_pianyiY"]);
			elseif arg1==2 then
				QKchatBut:SetPoint("TOPLEFT",ChatFrame1,"BOTTOMLEFT",-2+PIGA["Chat"]["QuickChat_pianyiX"],-4+PIGA["Chat"]["QuickChat_pianyiY"]);
			end	
			QuickChatfun.Update_editBoxPoint()
		end
	end
	---屏蔽状态
	local function Update_ChatButicon()
		for chatname,but in pairs(QKchatBut.tabbutList) do
			if but.CHANNELname then
				if PIG_IsShow_CHANNEL(but.CHANNELname) then
					but.X:Hide();
				else
					but.X:Show();
				end
			else
				if PIG_IsShow_Message(chatname) then
					but.X:Hide();
				else
					but.X:Show();
				end
			end
		end
	end
	--显隐
	local function Update_ChatButShow()
		local index=0
		for i,but in ipairs(QKchatBut.butlist) do
			local shangji
			but:ClearAllPoints();
			if but.PigxIsShown then
				if but.PigxIsShown() then
					index=index+1
				else
					shangji=true
				end
			else
				index=index+1
			end
			if not shangji then
				but:SetPoint("LEFT",QKchatBut,"LEFT",index*Width,0);
			end
		end
	end
	local function Update_ChatButShowEvent()
		QKchatBut.AutoShowHide=PIGA["Chat"]["QuickChat_AutoShowHide"]
		if QKchatBut.AutoShowHide then
			QKchatBut:UnregisterEvent("GROUP_ROSTER_UPDATE");
			QKchatBut:UnregisterEvent("PLAYER_GUILD_UPDATE");
			for i,but in ipairs(QKchatBut.butlist) do
				but:ClearAllPoints();
				but:SetPoint("LEFT",QKchatBut,"LEFT",i*Width,0);
			end
		else
			QKchatBut:RegisterEvent("GROUP_ROSTER_UPDATE");
			QKchatBut:RegisterEvent("PLAYER_GUILD_UPDATE")
			Update_ChatButShow()
		end
	end
	QKchatBut.Update_ChatButShowEvent=Update_ChatButShowEvent
	-------
	for i=1,#listDataLoc do
		ADD_chatbut(QKchatBut,listDataLoc[i])
	end
	----
	QuickChatfun.QuickBut_Keyword()
	QuickChatfun.QuickBut_Roll()
	QuickChatfun.QuickBut_Stats()
	QuickChatfun.QuickBut_Jilu()
	---
	QKchatBut:RegisterEvent("PLAYER_ENTERING_WORLD");
	QKchatBut:HookScript("OnEvent", function(self,event,arg1)
		if event=="GROUP_ROSTER_UPDATE" or event=="PLAYER_GUILD_UPDATE" then
			if self.ENTERING_WORLD then
			    if self._chatButDebounceTimer then
			        self._chatButDebounceTimer:Cancel()
			    end
			    self._chatButDebounceTimer = C_Timer.NewTimer(0.4, function()
			        Update_ChatButShow()
			    end)
			end
		else
			self.ENTERING_WORLD=true
			QKchatBut.Update_QuickChatPoint()
			Update_ChatButShowEvent()
			C_Timer.After(3,Update_ChatButicon)
			C_Timer.After(5,Update_ChatButicon)
			C_Timer.After(10,Update_ChatButicon)
		end
	end); 
end