local addonName, PD = ...;
local GeneralFun=PD.GeneralFun
function GeneralFun.Hardcore()
	if not PIGIsHardcore() then return end
	---
	local gsub = _G.string.gsub
	local find = _G.string.find
	local sub = _G.string.sub
	local match = _G.string.match

	local Create = PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGEnter=Create.PIGEnter
	local PIGSlider=Create.PIGSlider
	local PIGFontString=Create.PIGFontString
	local PIGButton=Create.PIGButton
	local PIGDiyBut=Create.PIGDiyBut
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGSetFont=Create.PIGSetFont
	local PIGDownMenu=Create.PIGDownMenu
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	--
	local L=PD.locale
	local Data=PD.Data
	local Fun=PD.Fun
	local PIGGetRaceAtlas=Fun.PIGGetRaceAtlas
	local FasongYCqingqiu=Fun.FasongYCqingqiu
	----
	local AudioData=PD.Audio.Data.HardcoreDeaths
	----
	local UIname,Tooltip = "PIG_HardcoreUI",KEY_BUTTON1.."-|cff00FFFF"..HARDCORE_DEATHS.."|r\r|r"..KEY_BUTTON2.."-|cff00FFFF"..SETTINGS.."|r"
	function GeneralFun.Hardcore_Deaths()
		--卟告
		if not PIGA["Hardcore"]["Deaths"]["Open"] then return end
		if _G[UIname] then return end
		table.insert(AudioData,{NONE,""})
		JoinTemporaryChannel("hardcoredeaths", nil, DEFAULT_CHAT_FRAME:GetID(), 1);
		ChatFrameMixin.RemoveChannel(DEFAULT_CHAT_FRAME, "hardcoredeaths");
		JoinTemporaryChannel(L["HARDCORE_SET1"], nil, DEFAULT_CHAT_FRAME:GetID(), 1);
		ChatFrameMixin.RemoveChannel(DEFAULT_CHAT_FRAME, L["HARDCORE_SET1"]);
		SetCVar("hardcoreDeathAlertType","2")
		RaidWarningFrame:UnregisterEvent("HARDCORE_DEATHS");
		----
		local Quality = PD.Data.Quality
		local minmaxlist = {{1,9},{10,19},{20,29},{30,39},{40,49},{50,59}}
		local function getColor(value)
			local value=tonumber(value)
		    if value >= minmaxlist[1][1] and value <= minmaxlist[1][2] then
		        return Quality[0]["HEX"]
		    elseif value >= minmaxlist[2][1] and value <= minmaxlist[2][2] then
		        return Quality[1]["HEX"]
		    elseif value >= minmaxlist[3][1] and value <= minmaxlist[3][2] then
		        return Quality[2]["HEX"]
		    elseif value >= minmaxlist[4][1] and value <= minmaxlist[4][2] then
		        return Quality[3]["HEX"]
		    elseif value >= minmaxlist[5][1] and value <= minmaxlist[5][2] then
		        return Quality[4]["HEX"]
		    elseif value >= minmaxlist[6][1] and value <= minmaxlist[6][2] then
		        return Quality[5]["HEX"]
		    else
		       	return "ffFF0000"
		    end
		end
		local function IslevelOK(value)	
			if not value then return false end
			if value=="" then return false end
			local value=tonumber(value)
			if value == 60 then
				return true
			end
			for i=1,#minmaxlist do
				if not PIGA["Hardcore"]["Deaths"]["level"][i] then
					if value >= minmaxlist[i][1] and value <= minmaxlist[i][2] then
		        		return true
		        	end
				end
			end
			return false
		end
		local maxtime = PIGA["Hardcore"]["Deaths"]["savedays"]*1000
		local datax = PIGA["Hardcore"]["Deaths"]["List"]
		while #datax > maxtime do
		    local oldData = table.remove(datax, 1)
		    if oldData then
		        PIGA["Hardcore"]["Deaths"]["Player"][oldData[2]] = nil
		    end
		end
		local newdata = PIGA["Hardcore"]["Deaths"]["ListWinp"]
		while #newdata > maxtime do
		    local oldData = table.remove(newdata, 1)
		    if oldData then
		        PIGA["Hardcore"]["Deaths"]["Player"][oldData[2]] = nil
		    end
		end
		----------
		Data.UILayout[UIname]={"TOPRIGHT","TOPRIGHT",-350,-174}
		local ButUI=PIGDiyBut(UIParent,nil,{30,31,nil,nil,"BossBanner-SkullCircle"},UIname)
		Create.PIG_SetPoint(UIname)
		Create.PIGSetMovable(ButUI)
		ButUI:SetFrameStrata("LOW")
		ButUI:SetHighlightAtlas("ChallengeMode-Runes-CircleGlow")
		ButUI:RegisterForClicks("AnyUp")
		PIGEnter(ButUI,Tooltip)
		function ButUI:Update_Config()
			self.AudioID=PIGA["Hardcore"]["Deaths"]["VoiceID"]
			self.Tgminlevel=PIGA["Hardcore"]["Deaths"]["Tgminlevel"]
			self.tipsmap=PIGA["Hardcore"]["Deaths"]["tipsmap"]
			self.BigTgminlevel=PIGA["Hardcore"]["Deaths"]["BigTgminlevel"]
			self:SetScale(PIGA["Hardcore"]["Deaths"]["UIScale"]);
		end
		ButUI:Update_Config()	
		ButUI.icon:SetDrawLayer("BORDER", 7)
		ButUI.msghangH =17
		ButUI.msg = CreateFrame("Frame", nil, ButUI);
		ButUI.msg:SetSize(150,ButUI.msghangH);
		ButUI.msg:SetPoint("TOP", ButUI, "BOTTOM", -0.6, 0);
		ButUI.msg.list={}
		ButUI.msg.list[1] = PIGFontString(ButUI.msg,{"TOP", 0, 0},"","OUTLINE",15)
		ButUI.msg.list[1]:SetSize(300,ButUI.msghangH);
		ButUI.msg.list[2] = PIGFontString(ButUI.msg,{"TOP", 0, -ButUI.msghangH},"","OUTLINE",15)
		ButUI.msg.list[2]:SetSize(300,ButUI.msghangH);
		ButUI.msg.list[3] = PIGFontString(ButUI.msg,{"TOP", 0, -ButUI.msghangH*2},"","OUTLINE",15)
		ButUI.msg.list[3]:SetSize(300,ButUI.msghangH);
		ButUI.msg.msglist={}
		ButUI.msg.msgcount=0
		function ButUI.msg:Update_msgList()
			for i=1,3 do
				self.list[i]:SetText("")
			end
			for ix=1,3 do
				if self.msglist[ix] then
					if GetTime()-self.msglist[ix][2]>13 then
						self.msglist[1]=self.msglist[2]
						self.msglist[2]=self.msglist[3]
						self.msglist[3]=nil
						self.msgcount=self.msgcount-1
					end
				end
			end
			for ix=1,3 do
				if self.msglist[ix] then
					self.list[ix]:SetText(self.msglist[ix][1])
				end
			end
			self:SetHeight(ButUI.msghangH*self.msgcount);
		end
		function ButUI.msg:AddMessage(msg)
			for i=1,3 do
				self.list[i]:SetText("")
			end
			local Time=GetTime()
			if self.msgcount==3 then
				self.msglist[1]=self.msglist[2]
				self.msglist[2]=self.msglist[3]
				self.msglist[3]={msg,Time}
			else
				if self.msgcount==2 then
					self.msglist[3]={msg,Time}
				elseif self.msgcount==1 then
					self.msglist[2]={msg,Time}
				else
					self.msglist[1]={msg,Time}
				end
			end
			if self.msgcount<3 then
				self.msgcount=self.msgcount+1
			end
			self:SetHeight(ButUI.msghangH*self.msgcount);
			for ix=1,3 do
				if self.msglist[ix] then
					self.list[ix]:SetText(self.msglist[ix][1])
				end
			end
		end
		ButUI.msg.oldtime=0
		ButUI.msg:HookScript("OnUpdate", function(self,sss)
			self.oldtime=self.oldtime+sss
			if self.oldtime>4 then
				self.oldtime=0
				self:Update_msgList()
			end
		end);
		ButUI:HookScript("OnDragStop",function(self)
			self.icon:SetPoint("CENTER");
		end)	
		PIGA["Hardcore"]["Deaths"]["VoiceID"]=PD.Audio.IsAudioNumMaxV(ButUI.AudioID,AudioData)
		ButUI.AudioID=PIGA["Hardcore"]["Deaths"]["VoiceID"]
		ButUI.texbg = ButUI:CreateTexture(nil, "BORDER");
		ButUI.texbg:SetPoint("TOPLEFT", ButUI.msg, "TOPLEFT", -14,6);
		ButUI.texbg:SetPoint("BOTTOMRIGHT", ButUI.msg, "BOTTOMRIGHT", 14,-3);
		ButUI.texbg:SetAtlas("BossBanner-BgBanner-Mid")
		ButUI.texToplin = ButUI:CreateTexture(nil, "BORDER");
		ButUI.texToplin:SetPoint("TOPLEFT", ButUI.texbg, "TOPLEFT", 0,28);
		ButUI.texToplin:SetPoint("TOPRIGHT", ButUI.texbg, "TOPRIGHT", 0,28);
		ButUI.texToplin:SetHeight(100);
		ButUI.texToplin:SetAtlas("BossBanner-BgBanner-Top")
		ButUI.texBotlin = ButUI:CreateTexture(nil, "BORDER");
		ButUI.texBotlin:SetPoint("BOTTOMLEFT", ButUI.texbg, "BOTTOMLEFT", 0,-24);
		ButUI.texBotlin:SetPoint("BOTTOMRIGHT", ButUI.texbg, "BOTTOMRIGHT", 0,-24);
		ButUI.texBotlin:SetHeight(100);
		ButUI.texBotlin:SetAtlas("BossBanner-BgBanner-Bottom")
		ButUI.texTop = ButUI:CreateTexture(nil, "BORDER");
		ButUI.texTop:SetSize(110,47);
		ButUI.texTop:SetPoint("BOTTOM", ButUI.texToplin, "TOP", 0,-38);
		ButUI.texTop:SetAtlas("BossBanner-TopFillagree")
		ButUI.texBot = ButUI:CreateTexture(nil, "BORDER");
		ButUI.texBot:SetPoint("TOP", ButUI.texBotlin, "BOTTOM", 0,28);
		ButUI.texBot:SetSize(44,16);
		ButUI.texBot:SetAtlas("BossBanner-BottomFillagree")

		ButUI.icon.animationGroup = ButUI.icon:CreateAnimationGroup()
		ButUI.icon.animationGroup.scale1 = ButUI.icon.animationGroup:CreateAnimation("Scale")
		ButUI.icon.animationGroup.scale1:SetOrder(1)
		ButUI.icon.animationGroup.scale1:SetScaleFrom(1,1)
		ButUI.icon.animationGroup.scale1:SetScaleTo(2,2)
		ButUI.icon.animationGroup.scale1:SetDuration(0.3)
		ButUI.icon.animationGroup.scale1:SetEndDelay(0.1)
		ButUI.icon.animationGroup.scale2 = ButUI.icon.animationGroup:CreateAnimation("Scale")
		ButUI.icon.animationGroup.scale2:SetOrder(2)
		ButUI.icon.animationGroup.scale2:SetScaleFrom(1,1)
		ButUI.icon.animationGroup.scale2:SetScaleTo(0.5,0.5)
		ButUI.icon.animationGroup.scale2:SetDuration(0.3)
		-- 
		ButUI:HookScript("OnClick", function (self,button)
			if button=="LeftButton" then
				self:addListF()
				if self.F:IsShown() then
					self.F:Hide()
				else
					self.F:Show()
				end
			else
				PD.UpdateOptionsUI()
				GeneralFun.ShowSetUI()
			end
		end);
		-----
		ButUI:RegisterEvent("HARDCORE_DEATHS");
		ButUI:RegisterEvent("CHAT_MSG_SYSTEM");
		ButUI:HookScript("OnEvent", function(self,event,arg1,arg2,arg3,arg4,arg5)
			if event == "HARDCORE_DEATHS" then
				local kaishi, jieshu, wanjiaName = arg1:find("%[(.-)%]");
				if wanjiaName and wanjiaName~="" then
					local newmsg = arg1:sub(jieshu+1);
					local level= tonumber(newmsg:match("等级为(%d+)级")) or 1
					local info = {GetServerTime(),wanjiaName,level,"","","",}
					local NPC = newmsg:match(L["HARDCORE_DEATHSMSG2"]);
					local map = newmsg:match(L["HARDCORE_DEATHSMSG3"]);
					if NPC and map then
						info[4]=NPC or NONE
						info[5]=map or NONE
					else
						local map, NPC = newmsg:match(L["HARDCORE_DEATHSMSG4"]);
						if NPC and map then
							info[4]=NPC or NONE
							info[5]=map or NONE
						else
							if newmsg:match(L["HARDCORE_DEATHSMSG5"]) then
								info[4] = L["HARDCORE_DEATHSMSG5"]
								local map = newmsg:match(L["HARDCORE_DEATHSMSG51"]);
								info[5]=map or NONE
							elseif newmsg:match(L["HARDCORE_DEATHSMSG6"]) then
								info[4] = L["HARDCORE_DEATHSMSG6"]
								local map = newmsg:match(L["HARDCORE_DEATHSMSG61"]);
								info[5]=map or NONE
							elseif newmsg:match(L["HARDCORE_DEATHSMSG7"]) then
								info[4] = L["HARDCORE_DEATHSMSG7"]
								local map = newmsg:match(L["HARDCORE_DEATHSMSG71"]);
								info[5]=map or NONE
							elseif newmsg:match(L["HARDCORE_DEATHSMSG8"]) then
								local map, NPC = newmsg:match(L["HARDCORE_DEATHSMSG81"]);
								info[4]=NPC or NONE
								info[5]=map or NONE
							else
								print(L["HARDCORE_DEATHSMSG9"],arg1)
							end
						end
					end
					table.insert(PIGA["Hardcore"]["Deaths"]["List"],info)
					ButUI.ListF_Update_List()
					if level>=ButUI.Tgminlevel then
						if _G[UIname].tipsmap then
							ButUI.msg:AddMessage("[|c"..getColor(level)..level.."|r]"..wanjiaName.."|cff00FF00+|r"..info[5])
						else
							ButUI.msg:AddMessage("[|c"..getColor(level)..level.."|r]"..wanjiaName)
						end
						if level>=_G[UIname].BigTgminlevel then--大席
							ButUI.icon.animationGroup:Stop()
							ButUI.icon.animationGroup:Play()
							PIG_PlaySoundFile(AudioData[_G[UIname].AudioID])
						end
					end
				end
			elseif event == "CHAT_MSG_SYSTEM" then
				local wanjiaName,level = string.match(arg1, L["HARDCORE_WINMSG1"])
				if wanjiaName and wanjiaName~="" then
					table.insert(PIGA["Hardcore"]["Deaths"]["ListWinp"],{GetServerTime(),wanjiaName,tonumber(level) or 1})
					ButUI.ListF2_Update_List()
				end
			end
		end);
		------
		function ButUI.ListF_Update_List() end
		function ButUI.ListF2_Update_List() end
		function ButUI:addListF()
			if self.F then return end
			local itemhangW,itemhangH,hangnum,hang_Height = 640,508,17,24
			ButUI.F = PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,60},{itemhangW,itemhangH},"PIG_HardcoreDeathsUI",true)
			ButUI.F:PIGSetBackdrop(0.8)
			ButUI.F:SetFrameLevel(10)
			ButUI.F:PIGSetMovable()
			ButUI.F:PIGClose()
			ButUI.F:Hide()
			ButUI.F.title = PIGFontString(ButUI.F,{"TOP", ButUI.F, "TOP", 0, -3})
			ButUI.FF=PIGOptionsList_RF(ButUI.F,20,"Left")
			ButUI.ListF,fujiTabBut=PIGOptionsList_R(ButUI.FF,LOSS,49,"Left")
			ButUI.ListF:Show()
			fujiTabBut:Selected(true)
			function ButUI.F.Save_playerdata(fullnameX,class,race,gender)
				PIGA["Hardcore"]["Deaths"]["Player"][fullnameX]={class,race,gender}
				ButUI.ListF_Update_List()
				ButUI.ListF2_Update_List()
			end
			ButUI.ListF.NR = PIGFrame(ButUI.ListF,{"TOPLEFT", ButUI.ListF, "TOPLEFT", 2, 0})
			ButUI.ListF.NR:SetPoint("BOTTOMRIGHT", ButUI.ListF, "BOTTOMRIGHT", -2, 0);
			ButUI.ListF.NR:PIGSetBackdrop(0)
			ButUI.ListF.NR.CheckbutList={}
			for i=1,#minmaxlist do
				local Checkbut = PIGCheckbutton(ButUI.ListF.NR,nil,{minmaxlist[i][1].."-"..minmaxlist[i][2]})
				ButUI.ListF.NR.CheckbutList[i]=Checkbut
				if i==1 then
					Checkbut:SetPoint("TOPLEFT",ButUI.ListF.NR,"TOPLEFT",20,-4);
				else
					Checkbut:SetPoint("LEFT",ButUI.ListF.NR.CheckbutList[i-1].Text,"RIGHT",15,0);
				end
				Checkbut.Text:SetTextColor(Quality[i-1]["RGB"][1],Quality[i-1]["RGB"][2],Quality[i-1]["RGB"][3],1)
				Checkbut:HookScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["Hardcore"]["Deaths"]["level"][i]=nil
					else
						PIGA["Hardcore"]["Deaths"]["level"][i]=true
					end
					ButUI.ListF_Update_List()
				end);
			end
			--
			ButUI.ListF.NR.List = PIGFrame(ButUI.ListF.NR,{"TOPLEFT", ButUI.ListF.NR, "TOPLEFT", 2, -44})
			ButUI.ListF.NR.List:SetPoint("BOTTOMRIGHT", ButUI.ListF.NR, "BOTTOMRIGHT", -2, 2);
			ButUI.ListF.NR.List:PIGSetBackdrop(0)
			local biaotiLsit = {{ID,4},{L["TIME"],40},{LEVEL.."/"..CALENDAR_PLAYER_NAME,160},{L["HARDCORE_KILLER"],320},{DEAD..FLOOR,460},}
			for i=1,#biaotiLsit do
				local biaoti = PIGFontString(ButUI.ListF.NR.List,{"BOTTOMLEFT", ButUI.ListF.NR.List, "TOPLEFT", biaotiLsit[i][2], 2},biaotiLsit[i][1])
				biaoti:SetTextColor(0, 1, 0.9, 0.8);
			end
			ButUI.ListF.NR.List.Scroll = CreateFrame("ScrollFrame",nil,ButUI.ListF.NR.List, "FauxScrollFrameTemplate");  
			ButUI.ListF.NR.List.Scroll:SetPoint("TOPLEFT",ButUI.ListF.NR.List,"TOPLEFT",0,-1);
			ButUI.ListF.NR.List.Scroll:SetPoint("BOTTOMRIGHT",ButUI.ListF.NR.List,"BOTTOMRIGHT",-23,1);
			ButUI.ListF.NR.List.Scroll:SetScale(0.8);
			ButUI.ListF.NR.List.Scroll:HookScript("OnVerticalScroll", function(self, offset)
			    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, ButUI.ListF_Update_List)
			end)
			ButUI.ListF.NR.List.butList={}
			function ButUI.ListF_Update_List()
				if not ButUI:IsShown() then return end
				for _,but in pairs(ButUI.ListF.NR.List.butList) do
					but:Hide()
				end
				local players = PIGA["Hardcore"]["Deaths"]["List"]
				local newdata = {}
				for i=1,#players do
					if IslevelOK(players[i][3]) then
						table.insert(newdata,players[i])
					end
				end
				local playersNum = #newdata
			    FauxScrollFrame_Update(ButUI.ListF.NR.List.Scroll, playersNum, hangnum, hang_Height);
			    local offset = FauxScrollFrame_GetOffset(ButUI.ListF.NR.List.Scroll);
			    for id = 1, hangnum do
					local dangqianID = (playersNum+1)-id-offset
					if newdata[dangqianID] then
						if not ButUI.ListF.NR.List.butList[id] then
							local hang = CreateFrame("Button", nil, ButUI.ListF.NR.List,"BackdropTemplate");
							ButUI.ListF.NR.List.butList[id]=hang
							hang:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
							hang:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
							hang:SetSize(itemhangW-24, hang_Height);
							hang:HookScript("OnEnter", function (self)
								self:SetBackdropColor(0.8, 0.8, 0.8, 0.2);
							end);
							hang:HookScript("OnLeave", function (self)
								self:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
							end);
							if id==1 then
								hang:SetPoint("TOPLEFT",ButUI.ListF.NR.List.Scroll,"TOPLEFT",1,0);
							else
								hang:SetPoint("TOP",ButUI.ListF.NR.List.butList[id-1],"BOTTOM",0,-2);
							end
							hang.indexID = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[1][2]-2,0})
							hang.indexID:SetTextColor(0.2, 0.8, 0.2, 1);
							hang.time = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[2][2]-2,0})
							hang.time:SetTextColor(0.8, 0.8, 0.8, 1)
							--
							hang.name = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[3][2]+30,0})
							hang.name:SetSize(100,hang_Height-2);
							hang.name:SetJustifyH("LEFT")
							hang.name:HookScript("OnMouseUp", function(self,button)
								local nameX = self:GetParent().name:GetText()
								if button=="LeftButton" then
									PIGSendTell(nameX.." ".. ChatEdit_ChooseBoxForSend():GetText(), DEFAULT_CHAT_FRAME);
								else
									SendChatMessage(L["HARDCORE_DEATHSMSG99"], "WHISPER", nil, nameX);
								end
							end)
							hang.name:HookScript("OnEnter", function (self)
								hang:SetBackdropColor(0.8, 0.8, 0.8, 0.2);
							end);
							hang.name:HookScript("OnLeave", function (self)
								hang:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
							end);
							hang.level = PIGFontString(hang,{"RIGHT", hang.name, "LEFT",0, 0},1)
							hang.Class=PIGDiyBut(hang,{"RIGHT", hang.name, "LEFT", -18,0},{hang_Height-2,hang_Height-2,nil,nil,131146})
							hang.Class:HookScript("OnClick", function(self,button)
								local nameX = self:GetParent().name:GetText()
								FasongYCqingqiu(nameX)
							end)
							hang.Race = hang:CreateTexture();
							hang.Race:SetPoint("RIGHT", hang.Class, "LEFT", -1,0);
							hang.Race:SetSize(hang_Height-2,hang_Height-2);
							hang.NPC = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[4][2],0})
							hang.map = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[5][2],0})
						end
						local hang = ButUI.ListF.NR.List.butList[id]
						hang:Show()
						hang.indexID:SetText(dangqianID)
						hang.time:SetText(date("%m-%d %H:%M:%S",newdata[dangqianID][1]))
						hang.level:SetText("|c"..getColor(newdata[dangqianID][3])..newdata[dangqianID][3].."|r")
						hang.name:SetText(newdata[dangqianID][2])
						hang.NPC:SetText(newdata[dangqianID][4])
						hang.map:SetText(newdata[dangqianID][5])
						local datatxt = PIGA["Hardcore"]["Deaths"]["Player"][newdata[dangqianID][2]]
						if datatxt then
							local class,race,gender = datatxt[1],datatxt[2],datatxt[3]
							local className, classFile, classID = PIGGetClassInfo(class)
							hang.Class.icon:SetTexture("interface/glues/charactercreate/ui-charactercreate-classes.blp")
							hang.Class.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classFile]));
							hang.Class.icon:SetSize(hang_Height-2,hang_Height-2);
							local color = PIG_CLASS_COLORS[classFile];
							hang.name:SetTextColor(color.r, color.g, color.b, 1);
							hang.NPC:SetTextColor(color.r, color.g, color.b, 1);
							hang.map:SetTextColor(color.r, color.g, color.b, 1);
							if tonumber(race)>0 then
								hang.Race:Show()
								local gender=gender or 2
								local raceInfo = C_CreatureInfo.GetRaceInfo(race)
								local race_icon = PIGGetRaceAtlas(raceInfo.clientFileString,gender)
								hang.Race:SetAtlas(race_icon);
							end
						else
							hang.name:SetTextColor(1, 0.843, 0, 0.9);
							hang.NPC:SetTextColor(1, 0.843, 0, 0.9);
							hang.map:SetTextColor(1, 0.843, 0, 0.9);
							hang.Race:Hide()
							hang.Class.icon:SetTexCoord(0,1,0,1);
							hang.Class.icon:SetAtlas("common-search-magnifyingglass")
							hang.Class.icon:SetSize(hang_Height-7,hang_Height-7);
						end
					end
				end
			end
			ButUI.ListF:HookScript("OnShow", function(self)
				ButUI.F.title:SetText(HARDCORE_DEATHS)
				for i=1,#minmaxlist do
					ButUI.ListF.NR.CheckbutList[i]:SetChecked(not PIGA["Hardcore"]["Deaths"]["level"][i])
				end
				ButUI.ListF_Update_List()
			end);
			---
			ButUI.ListF2=PIGOptionsList_R(ButUI.FF,WIN,49,"Left")
			ButUI.ListF2.NR = PIGFrame(ButUI.ListF2,{"TOPLEFT", ButUI.ListF2, "TOPLEFT", 2, 0})
			ButUI.ListF2.NR:SetPoint("BOTTOMRIGHT", ButUI.ListF2, "BOTTOMRIGHT", -2, 0);
			ButUI.ListF2.NR:PIGSetBackdrop(0)
			ButUI.ListF2.NR.List = PIGFrame(ButUI.ListF2.NR,{"TOPLEFT", ButUI.ListF2.NR, "TOPLEFT", 2, -44})
			ButUI.ListF2.NR.List:SetPoint("BOTTOMRIGHT", ButUI.ListF2.NR, "BOTTOMRIGHT", -2, 2);
			ButUI.ListF2.NR.List:PIGSetBackdrop(0)
			local biaotiLsit = {{ID,4},{L["TIME"],40},{LEVEL.."/"..CALENDAR_PLAYER_NAME,210}}
			for i=1,#biaotiLsit do
				local biaoti = PIGFontString(ButUI.ListF2.NR.List,{"BOTTOMLEFT", ButUI.ListF2.NR.List, "TOPLEFT", biaotiLsit[i][2], 2},biaotiLsit[i][1])
				biaoti:SetTextColor(0, 1, 0.9, 0.8);
			end
			ButUI.ListF2.NR.List.Scroll = CreateFrame("ScrollFrame",nil,ButUI.ListF2.NR.List, "FauxScrollFrameTemplate");  
			ButUI.ListF2.NR.List.Scroll:SetPoint("TOPLEFT",ButUI.ListF2.NR.List,"TOPLEFT",0,-1);
			ButUI.ListF2.NR.List.Scroll:SetPoint("BOTTOMRIGHT",ButUI.ListF2.NR.List,"BOTTOMRIGHT",-23,1);
			ButUI.ListF2.NR.List.Scroll:SetScale(0.8);
			ButUI.ListF2.NR.List.Scroll:HookScript("OnVerticalScroll", function(self, offset)
			    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, ButUI.ListF2_Update_List)
			end)
			ButUI.ListF2.NR.List.butList={}
			function ButUI.ListF2_Update_List()
				if not ButUI:IsShown() then return end
				for _,but in pairs(ButUI.ListF2.NR.List.butList) do
					but:Hide()
				end
				local newdata = PIGA["Hardcore"]["Deaths"]["ListWinp"]
				local playersNum = #newdata
			    FauxScrollFrame_Update(ButUI.ListF2.NR.List.Scroll, playersNum, hangnum, hang_Height);
			    local offset = FauxScrollFrame_GetOffset(ButUI.ListF2.NR.List.Scroll);
			    for id = 1, hangnum do
					local dangqianID = (playersNum+1)-id-offset
					if newdata[dangqianID] then
						if not ButUI.ListF2.NR.List.butList[id] then
							local hang = CreateFrame("Button", nil, ButUI.ListF2.NR.List,"BackdropTemplate");
							ButUI.ListF2.NR.List.butList[id]=hang
							hang:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
							hang:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
							hang:SetSize(itemhangW-24, hang_Height);
							hang:HookScript("OnEnter", function (self)
								self:SetBackdropColor(0.8, 0.8, 0.8, 0.2);
							end);
							hang:HookScript("OnLeave", function (self)
								self:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
							end);
							if id==1 then
								hang:SetPoint("TOPLEFT",ButUI.ListF2.NR.List.Scroll,"TOPLEFT",1,0);
							else
								hang:SetPoint("TOP",ButUI.ListF2.NR.List.butList[id-1],"BOTTOM",0,-2);
							end
							hang.indexID = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[1][2]-2,0})
							hang.indexID:SetTextColor(0.2, 0.8, 0.2, 1);
							hang.time = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[2][2]-2,0})
							hang.time:SetTextColor(0.8, 0.8, 0.8, 1)
							
							--
							hang.name = PIGFontString(hang,{"LEFT", hang, "LEFT", biaotiLsit[3][2]+30,0})
							hang.name:SetSize(100,hang_Height-2);
							hang.name:SetJustifyH("LEFT")
							hang.name:HookScript("OnMouseUp", function(self,button)
								local nameX = self:GetParent().name:GetText()
								if button=="LeftButton" then
									PIGSendTell(nameX.." ".. ChatEdit_ChooseBoxForSend():GetText(), DEFAULT_CHAT_FRAME);
								else
									SendChatMessage(L["HARDCORE_WINMSG99"], "WHISPER", nil, nameX);
								end
							end)
							hang.name:HookScript("OnEnter", function (self)
								hang:SetBackdropColor(0.8, 0.8, 0.8, 0.2);
							end);
							hang.name:HookScript("OnLeave", function (self)
								hang:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
							end);
							hang.level = PIGFontString(hang,{"RIGHT", hang.name, "LEFT",0, 0},1)
							hang.Class=PIGDiyBut(hang,{"RIGHT", hang.name, "LEFT", -18,0},{hang_Height-2,hang_Height-2,nil,nil,131146})
							hang.Class:HookScript("OnClick", function(self,button)
								local nameX = self:GetParent().name:GetText()
								FasongYCqingqiu(nameX)
							end)
							hang.Race = hang:CreateTexture();
							hang.Race:SetPoint("RIGHT", hang.Class, "LEFT", -1,0);
							hang.Race:SetSize(hang_Height-2,hang_Height-2);
						end
						local hang = ButUI.ListF2.NR.List.butList[id]
						hang:Show()
						hang.indexID:SetText(dangqianID)
						hang.time:SetText(date("%m-%d %H:%M:%S",newdata[dangqianID][1]))
						hang.level:SetText("|c"..getColor(newdata[dangqianID][3])..newdata[dangqianID][3].."|r")
						hang.name:SetText(newdata[dangqianID][2])
						local datatxt = PIGA["Hardcore"]["Deaths"]["Player"][newdata[dangqianID][2]]
						if datatxt then
							local class,race,gender = datatxt[1],datatxt[2],datatxt[3]
							local className, classFile, classID = PIGGetClassInfo(class)
							hang.Class.icon:SetTexture("interface/glues/charactercreate/ui-charactercreate-classes.blp")
							hang.Class.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classFile]));
							hang.Class.icon:SetSize(hang_Height-2,hang_Height-2);
							local color = PIG_CLASS_COLORS[classFile];
							hang.name:SetTextColor(color.r, color.g, color.b, 1);
							if tonumber(race)>0 then
								hang.Race:Show()
								local gender=gender or 2
								local raceInfo = C_CreatureInfo.GetRaceInfo(race)
								local race_icon = PIGGetRaceAtlas(raceInfo.clientFileString,gender)
								hang.Race:SetAtlas(race_icon);
							end
						else
							hang.name:SetTextColor(1, 0.843, 0, 0.9);
							hang.Race:Hide()
							hang.Class.icon:SetTexCoord(0,1,0,1);
							hang.Class.icon:SetAtlas("common-search-magnifyingglass")
							hang.Class.icon:SetSize(hang_Height-7,hang_Height-7);
						end
					end
				end
			end
			ButUI.ListF2:HookScript("OnShow", function(self)
				ButUI.F.title:SetText(SUCCESS..GUILD_RECRUITMENT_MAXLEVEL)
				ButUI.ListF2_Update_List()
			end);
		end
	end
	local NameSelectList={
		[1]={NPC_NAMES_DROPDOWN_TRACKED, NPC_NAMES_DROPDOWN_TRACKED_TOOLTIP},
		[2]={NPC_NAMES_DROPDOWN_HOSTILE, NPC_NAMES_DROPDOWN_HOSTILE_TOOLTIP},
		[3]={NPC_NAMES_DROPDOWN_INTERACTIVE, NPC_NAMES_DROPDOWN_INTERACTIVE_TOOLTIP},
		[4]={NPC_NAMES_DROPDOWN_ALL, NPC_NAMES_DROPDOWN_ALL_TOOLTIP},
		[5]={NPC_NAMES_DROPDOWN_NONE, NPC_NAMES_DROPDOWN_NONE_TOOLTIP},
	}
	function GeneralFun.Hardcore_CVars()
		local HardcoreCVarsF=CreateFrame("Frame")
		local function NameGetValue()
			if GetCVarBool("UnitNameNPC") then
				return 4;
			else
				local specialNPCName = GetCVarBool("UnitNameFriendlySpecialNPCName");
				local hostileNPCName = GetCVarBool("UnitNameHostleNPC");
				local specialAndHostile = specialNPCName and hostileNPCName;
				if specialAndHostile and GetCVarBool("UnitNameInteractiveNPC") then
					return 3;
				elseif specialAndHostile then
					return 2;
				elseif specialNPCName then
					return 1;
				end
			end
			return 5;
		end
		local function NameSetValue(value)
			if value == 1 then
				SetCVar("UnitNameFriendlySpecialNPCName", "1");
				SetCVar("UnitNameNPC", "0");
				SetCVar("UnitNameHostleNPC", "0");
				SetCVar("UnitNameInteractiveNPC", "0");
				SetCVar("ShowQuestUnitCircles", "0");
			elseif value == 2 then
				SetCVar("UnitNameFriendlySpecialNPCName", "1");
				SetCVar("UnitNameHostleNPC", "1");
				SetCVar("UnitNameInteractiveNPC", "0");
				SetCVar("UnitNameNPC", "0");
				SetCVar("ShowQuestUnitCircles", "1");
			elseif value == 3 then
				SetCVar("UnitNameFriendlySpecialNPCName", "1");
				SetCVar("UnitNameHostleNPC", "1");
				SetCVar("UnitNameInteractiveNPC", "1");
				SetCVar("UnitNameNPC", "0");
				SetCVar("ShowQuestUnitCircles", "1");
			elseif value == 4 then
				SetCVar("UnitNameFriendlySpecialNPCName", "0");
				SetCVar("UnitNameHostleNPC", "0");
				SetCVar("UnitNameInteractiveNPC", "0");
				SetCVar("UnitNameNPC", "1");
				SetCVar("ShowQuestUnitCircles", "1");
			else
				SetCVar("UnitNameFriendlySpecialNPCName", "0");
				SetCVar("UnitNameHostleNPC", "0");
				SetCVar("UnitNameInteractiveNPC", "0");
				SetCVar("UnitNameNPC", "0");
				SetCVar("ShowQuestUnitCircles", "1");
			end
		end
		local function event_Script(NameMinV,NameMinSelect)
		    if IsResting() then
				SetCVar("UnitNameFriendlySpecialNPCName", "1");
				SetCVar("UnitNameHostleNPC", "1");
				SetCVar("UnitNameInteractiveNPC", "0");
				SetCVar("UnitNameNPC", "0");
				SetCVar("ShowQuestUnitCircles", "1");
				SetCVar("WorldTextMinSize", NameMinV or HardcoreCVarsF.NameMinV)
				NameSetValue(NameMinSelect or HardcoreCVarsF.NameMinSelect)
		    else
		        SetCVar("UnitNameFriendlySpecialNPCName", "0");
		        SetCVar("UnitNameHostleNPC", "0");
		        SetCVar("UnitNameInteractiveNPC", "0");
		        SetCVar("UnitNameNPC", "1");
		        SetCVar("ShowQuestUnitCircles", "1");
		        SetCVar("WorldTextMinSize", NameMinV or HardcoreCVarsF.NameMaxV)
		        NameSetValue(NameMinSelect or HardcoreCVarsF.NameMaxSelect)
		    end
		end
		function GeneralFun:UpdateConfig_CVars(NameMinV,NameMinSelect)
	    	if PIGA["Hardcore"]["CVars"]["Open"] then
	    		HardcoreCVarsF.NameMinV=PIGA["Hardcore"]["CVars"]["NameMinV"]
	        	HardcoreCVarsF.NameMaxV=PIGA["Hardcore"]["CVars"]["NameMaxV"]
	        	HardcoreCVarsF.NameMinSelect=PIGA["Hardcore"]["CVars"]["NameMinSelect"]
				HardcoreCVarsF.NameMaxSelect=PIGA["Hardcore"]["CVars"]["NameMaxSelect"]
	       		HardcoreCVarsF:RegisterEvent("PLAYER_ENTERING_WORLD")
				HardcoreCVarsF:RegisterEvent("PLAYER_UPDATE_RESTING");
				C_Timer.After(0.1,event_Script)
	    	else
	    		HardcoreCVarsF:UnregisterEvent("PLAYER_ENTERING_WORLD")
				HardcoreCVarsF:UnregisterEvent("PLAYER_UPDATE_RESTING");
				event_Script(NameMinV,NameMinSelect)
			end
		end
		GeneralFun:UpdateConfig_CVars()
		HardcoreCVarsF:HookScript("OnEvent", function(self,event)
			if InCombatLockdown() then return end
			C_Timer.After(0.1,event_Script)
		end)
	end
	GeneralFun.Hardcore_CVars()
	GeneralFun.Hardcore_Deaths()
	--设置------------
	function GeneralFun.addOptions_Hardcore()
		local fujiF,fujiTabBut =PIGOptionsList_R(GeneralFun.NR,L["HARDCORE_TABNAME"],80)
		GeneralFun.HardcoreTabF=fujiF
		GeneralFun.HardcoreTabBut=fujiTabBut
		local function Update_Config()
			if _G[UIname] then _G[UIname]:Update_Config() end
		end
		fujiF.Deaths =PIGCheckbutton(fujiF,{"TOPLEFT", fujiF, "TOPLEFT", 20, -20},{HARDCORE_DEATHS})
		fujiF.Deaths:SetScript("OnClick", function (self)
		    if self:GetChecked() then
		        PIGA["Hardcore"]["Deaths"]["Open"]=true
		        GeneralFun.Hardcore_Deaths()
		    else
		        PIGA["Hardcore"]["Deaths"]["Open"]=false
		        PIG_OptionsUI.RLUI:Show()
		    end
		end);
		fujiF.Deaths.Tgminlevel = PIGSlider(fujiF.Deaths,{"TOPLEFT",fujiF.Deaths,"BOTTOMLEFT",130,-10},{1,60,1,{["Right"]=L["HARDCORE_SET2"]}})
		fujiF.Deaths.Tgminlevel.T = PIGFontString(fujiF.Deaths.Tgminlevel,{"RIGHT",fujiF.Deaths.Tgminlevel,"LEFT",0,0},L["HARDCORE_SET3"])
		function fujiF.Deaths.Tgminlevel:PIGOnValueChange(arg1)
			PIGA["Hardcore"]["Deaths"]["Tgminlevel"]=arg1;
			Update_Config()
		end
		fujiF.Deaths.tipsmap = PIGCheckbutton(fujiF.Deaths,{"LEFT",fujiF.Deaths.Tgminlevel,"RIGHT",50,0},{L["HARDCORE_SET4"][1],L["HARDCORE_SET4"][2]})
		fujiF.Deaths.tipsmap:HookScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Hardcore"]["Deaths"]["tipsmap"]=true	
			else
				PIGA["Hardcore"]["Deaths"]["tipsmap"]=false
			end
			Update_Config()
		end);

		fujiF.Deaths.BigTgminlevel = PIGSlider(fujiF.Deaths,{"TOPLEFT",fujiF.Deaths.Tgminlevel,"BOTTOMLEFT",0,-10},{30,60,1,{["Right"]=L["HARDCORE_SET2"]}})
		fujiF.Deaths.BigTgminlevel.T = PIGFontString(fujiF.Deaths.BigTgminlevel,{"RIGHT",fujiF.Deaths.BigTgminlevel,"LEFT",0,0},L["HARDCORE_SET5"])
		function fujiF.Deaths.BigTgminlevel:PIGOnValueChange(arg1)
			PIGA["Hardcore"]["Deaths"]["BigTgminlevel"]=arg1;
			Update_Config()
		end
		fujiF.Deaths.xiala=PIGDownMenu(fujiF.Deaths,{"LEFT",fujiF.Deaths.BigTgminlevel,"RIGHT",50,0},{150,24})
		function fujiF.Deaths.xiala:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#AudioData,1 do
			    info.text, info.arg1 = AudioData[i][1], i
			    info.checked = i==PIGA["Hardcore"]["Deaths"]["VoiceID"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function fujiF.Deaths.xiala:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Hardcore"]["Deaths"]["VoiceID"]=arg1
			Update_Config()
			PIGCloseDropDownMenus()
		end
		fujiF.Deaths.PlayBut =PIGDiyBut(fujiF.Deaths,{"LEFT",fujiF.Deaths.xiala,"RIGHT",8,0},{24,24,nil,nil,"chatframe-button-icon-speaker-on",130757});
		fujiF.Deaths.PlayBut:HookScript("OnClick", function()
			PIG_PlaySoundFile(AudioData[_G[UIname].AudioID])
		end)
		fujiF.Deaths.savedays = PIGSlider(fujiF.Deaths,{"TOPLEFT",fujiF.Deaths.BigTgminlevel,"BOTTOMLEFT",0,-10},{1,10,1,{["Right"]=function(v)
			return v*1000
		end}})
		fujiF.Deaths.savedays.T = PIGFontString(fujiF.Deaths.savedays,{"RIGHT",fujiF.Deaths.savedays,"LEFT",0,0},L["HARDCORE_SET8"])
		function fujiF.Deaths.savedays:PIGOnValueChange(arg1)
			PIGA["Hardcore"]["Deaths"]["savedays"]=arg1;
		end
		fujiF.Deaths.savedays.Clear = PIGButton(fujiF.Deaths.savedays,{"LEFT",fujiF.Deaths.savedays,"RIGHT",50,0},{80,22},L["LIB_CLEAR"])
		fujiF.Deaths.savedays.Clear:HookScript("OnClick", function ()
			PIGA["Hardcore"]["Deaths"]["List"]={}
			PIGA["Hardcore"]["Deaths"]["Player"]={}
			ButUI.ListF_Update_List()
		end);
		fujiF.Deaths.UIScale = PIGSlider(fujiF.Deaths,{"TOPLEFT",fujiF.Deaths.savedays,"BOTTOMLEFT",0,-10},{0.8,2,0.01,{["Right"]="%d%%"}})
		fujiF.Deaths.UIScale.T = PIGFontString(fujiF.Deaths.UIScale,{"RIGHT",fujiF.Deaths.UIScale,"LEFT",0,0},L["LIB_SCALE"])
		function fujiF.Deaths.UIScale:PIGOnValueChange(arg1)
			PIGA["Hardcore"]["Deaths"]["UIScale"]=arg1;
			Update_Config()
		end
		fujiF.Deaths.CZINFO = PIGButton(fujiF.Deaths,{"LEFT",fujiF.Deaths.UIScale,"RIGHT",50,0},{80,22},RESET_POSITION)
		fujiF.Deaths.CZINFO:HookScript("OnClick", function ()
			PIGA["Hardcore"]["Deaths"]["UIScale"]=1
			fujiF.Deaths.UIScale:PIGSetValue(PIGA["Hardcore"]["Deaths"]["UIScale"])
			Update_Config()
			Create.PIG_ResPoint(UIname)
		end);
		--
		fujiF.AutoCVars =PIGCheckbutton(fujiF,{"TOPLEFT", fujiF, "TOPLEFT", 20, -280},{L["HARDCORE_SET9"]})
		fujiF.AutoCVars:SetScript("OnClick", function (self)
		    if self:GetChecked() then
		        PIGA["Hardcore"]["CVars"]["Open"]=true
		    else
		        PIGA["Hardcore"]["CVars"]["Open"]=false
		    end
		    fujiF.AutoCVars.CZ:SetShown(not PIGA["Hardcore"]["CVars"]["Open"])
		    GeneralFun:UpdateConfig_CVars()
		end);
		fujiF.AutoCVars.CZ=PIGButton(fujiF.AutoCVars,{"LEFT", fujiF.AutoCVars.Text, "RIGHT", 20, 0},{110,20},RESET_TO_DEFAULT)
		fujiF.AutoCVars.CZ:SetShown(not PIGA["Hardcore"]["CVars"]["Open"])
		fujiF.AutoCVars.CZ:SetScript("OnClick", function (self)
		    GeneralFun:UpdateConfig_CVars(0,2)
		end);
		fujiF.AutoCVars.NameMin = PIGSlider(fujiF.AutoCVars,{"TOPLEFT",fujiF.AutoCVars,"BOTTOMLEFT",20,-30},{0,64,1})
		fujiF.AutoCVars.NameMin.T = PIGFontString(fujiF.AutoCVars.NameMin,{"BOTTOMLEFT",fujiF.AutoCVars.NameMin,"TOPLEFT",10,0},L["HARDCORE_SET10"])
		function fujiF.AutoCVars.NameMin:PIGOnValueChange(arg1)
		    PIGA["Hardcore"]["CVars"]["NameMinV"]=arg1;
		    GeneralFun:UpdateConfig_CVars()
		end
		fujiF.AutoCVars.NameMinSelect=PIGDownMenu(fujiF.AutoCVars,{"LEFT",fujiF.AutoCVars.NameMin,"RIGHT",100,0},{220,24})
		fujiF.AutoCVars.NameMinSelect.T = PIGFontString(fujiF.AutoCVars.NameMinSelect,{"BOTTOMLEFT",fujiF.AutoCVars.NameMinSelect,"TOPLEFT",10,4},L["HARDCORE_SET11"])
		function fujiF.AutoCVars.NameMinSelect:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,5,1 do
			    info.text, info.arg1 = NameSelectList[i][1], i
			    info.checked = i==PIGA["Hardcore"]["CVars"]["NameMinSelect"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function fujiF.AutoCVars.NameMinSelect:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Hardcore"]["CVars"]["NameMinSelect"]=arg1
			GeneralFun:UpdateConfig_CVars()
			PIGCloseDropDownMenus()
		end
		fujiF.AutoCVars.NameMax = PIGSlider(fujiF.AutoCVars,{"TOPLEFT",fujiF.AutoCVars,"BOTTOMLEFT",20,-100},{0,64,1})
		fujiF.AutoCVars.NameMax.T = PIGFontString(fujiF.AutoCVars.NameMax,{"BOTTOMLEFT",fujiF.AutoCVars.NameMax,"TOPLEFT",10,0},L["HARDCORE_SET12"])
		function fujiF.AutoCVars.NameMax:PIGOnValueChange(arg1)
		    PIGA["Hardcore"]["CVars"]["NameMaxV"]=arg1;
		    GeneralFun:UpdateConfig_CVars()
		end
		fujiF.AutoCVars.NameMaxSelect=PIGDownMenu(fujiF.AutoCVars,{"LEFT",fujiF.AutoCVars.NameMax,"RIGHT",100,0},{220,24})
		fujiF.AutoCVars.NameMaxSelect.T = PIGFontString(fujiF.AutoCVars.NameMaxSelect,{"BOTTOMLEFT",fujiF.AutoCVars.NameMaxSelect,"TOPLEFT",10,4},L["HARDCORE_SET13"])
		function fujiF.AutoCVars.NameMaxSelect:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,5,1 do
			    info.text, info.arg1 = NameSelectList[i][1], i
			    info.checked = i==PIGA["Hardcore"]["CVars"]["NameMaxSelect"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function fujiF.AutoCVars.NameMaxSelect:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Hardcore"]["CVars"]["NameMaxSelect"]=arg1
			GeneralFun:UpdateConfig_CVars()
			PIGCloseDropDownMenus()
		end
		fujiF.Deaths:SetChecked(PIGA["Hardcore"]["Deaths"]["Open"])
		fujiF.Deaths.tipsmap:SetChecked(PIGA["Hardcore"]["Deaths"]["tipsmap"])
		fujiF.Deaths.Tgminlevel:PIGSetValue(PIGA["Hardcore"]["Deaths"]["Tgminlevel"])
		fujiF.Deaths.UIScale:PIGSetValue(PIGA["Hardcore"]["Deaths"]["UIScale"])
		fujiF.Deaths.BigTgminlevel:PIGSetValue(PIGA["Hardcore"]["Deaths"]["BigTgminlevel"])
		fujiF.Deaths.savedays:PIGSetValue(PIGA["Hardcore"]["Deaths"]["savedays"])
		fujiF.Deaths.xiala:PIGDownMenu_SetText(AudioData[PIGA["Hardcore"]["Deaths"]["VoiceID"]][1])
		fujiF.AutoCVars:SetChecked(PIGA["Hardcore"]["CVars"]["Open"])
		fujiF.AutoCVars.NameMin:PIGSetValue(PIGA["Hardcore"]["CVars"]["NameMinV"])
		fujiF.AutoCVars.NameMax:PIGSetValue(PIGA["Hardcore"]["CVars"]["NameMaxV"])
	    fujiF.AutoCVars.NameMinSelect:PIGDownMenu_SetText(NameSelectList[PIGA["Hardcore"]["CVars"]["NameMinSelect"]][1])
	    fujiF.AutoCVars.NameMaxSelect:PIGDownMenu_SetText(NameSelectList[PIGA["Hardcore"]["CVars"]["NameMaxSelect"]][1])
	end
end