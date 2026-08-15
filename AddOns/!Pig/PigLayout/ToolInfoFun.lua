local _, PD = ...;
----------------------------------------
local L=PD.locale
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGEnter=Create.PIGEnter
local PIGButton = Create.PIGButton
local PIGDiyBut = Create.PIGDiyBut
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
-----
local format=string.format
local Data=PD.Data
local Fun=PD.Fun
local PigLayoutFun=PD.PigLayoutFun
local CountdownList=PD.Audio.Data.Countdown
local CountdownEndList=PD.Audio.Data.EndAudio
---====
local HHH = 20
PigLayoutFun.HHH=HHH
local FormatUIname="PIG_%sUI"
local GNLsits={}
PigLayoutFun.GNLsits=GNLsits
local ButDropList={}
PigLayoutFun.ButDropList=ButDropList
local function ListEventFun(self)
	if IsInGroup() then
		self:Enable()
		if self.UpdateExt_ON then self:UpdateExt_ON() end
	else
		self:Disable();
		if self.UpdateExt_OFF then self:UpdateExt_OFF() end
	end
end
PigLayoutFun.ListEventFun=ListEventFun
function PigLayoutFun.SetEvent_MenuList(butui)
	butui:RegisterEvent("PLAYER_ENTERING_WORLD")
	butui:RegisterEvent("GROUP_ROSTER_UPDATE")
	butui:HookScript("OnEvent", ListEventFun);
end
local function SetBGHide(peizhiT)
	local pigui=_G[format(FormatUIname,peizhiT)]
	if pigui then
		if PIGA["PigLayout"][peizhiT]["BGHide"] then
			pigui:SetBackdropColor(0, 0, 0, 0);
			pigui:SetBackdropBorderColor(0, 0, 0, 0);
		else
			pigui:SetBackdropColor(0.08, 0.08, 0.08, 0.4);
			pigui:SetBackdropBorderColor(0.3,0.3,0.3,0.9);
		end
		if pigui.extShowBGFun then pigui:extShowBGFun(PIGA["PigLayout"][peizhiT]["BGHide"]) end
	end
end
local function SetLookUI(peizhiT)
	local pigui=_G[format(FormatUIname,peizhiT)]
	if pigui then
		pigui.yidong:SetShown(not PIGA["PigLayout"][peizhiT]["Lock"])
	end
end
local function SetUIXYScale(peizhiT)
	local pigui=_G[format(FormatUIname,peizhiT)]
	if pigui then
		pigui:SetScale(PIGA["PigLayout"][peizhiT]["Scale"])
	end
end
function PigLayoutFun.add_barUI(peizhiT,set)
	if not PIGA["PigLayout"][peizhiT]["Open"] then return end
	local UIname=format(FormatUIname,peizhiT)
	if _G[UIname] then return end
	local barTitle=GNLsits[peizhiT].barname
	local barname,MenuData,PointXY=barTitle..(GNLsits[peizhiT].barname1 or ""),GNLsits[peizhiT].MenuData,GNLsits[peizhiT].PointXY
	local ListIndex,ListTips,ListIcon,ListFun,ListEvent,ListIconON=MenuData.Index,MenuData.Tips,MenuData.Icon,MenuData.Click,MenuData.Event,MenuData.IconON
	local listNum=#ListIndex
	Data.UILayout[UIname]={PointXY[1], PointXY[1], PointXY[2], PointXY[3]}
	local barUIxx = PIGFrame(UIParent,nil,{(HHH+3)*listNum+5,HHH},UIname)
	barUIxx:PIGSetBackdrop(0.4,0.9,nil,{0.3,0.3,0.3})
	Create.PIG_SetPoint(UIname)
	barUIxx.yidong = PIGFrame(barUIxx,{"RIGHT",barUIxx,"LEFT",1,0},{12, HHH})
	barUIxx.yidong:PIGSetBackdrop(0.4,0.9,nil,{0.3,0.3,0.3})
	barUIxx.yidong:PIGSetMovable(barUIxx)
	barUIxx.yidong:SetScript("OnEnter", function (self)
		self:SetBackdropBorderColor(0,0.8,1,0.9);
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",12,0);
		GameTooltip:AddLine(barname)	
		GameTooltip:AddLine(KEY_BUTTON2.."-|cff00FFff"..SETTINGS.."|r")	
		GameTooltip:Show();
	end);
	barUIxx.yidong:SetScript("OnLeave", function (self)
		self:SetBackdropBorderColor(0.3,0.3,0.3,0.9);
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end)
	barUIxx.yidong:SetScript("OnMouseUp", function (self,Button)
		if Button=="RightButton" then
			PD.UpdateOptionsUI()
			Create.Show_TabBut(PigLayoutFun.fuFrame,PigLayoutFun.fuFrameBut)
			Create.Show_TabBut_R(PigLayoutFun.RTabFrame,PigLayoutFun["Tab2"..barTitle],PigLayoutFun["Tab2F"..barTitle])
		end
	end);
	barUIxx.yidong:SetShown(not PIGA["PigLayout"][peizhiT]["Lock"])
	SetUIXYScale(peizhiT)
	SetBGHide(peizhiT)
	if peizhiT=="topMenu" then
		PIGA["PigLayout"][peizhiT]["CountdownAudio"]=PD.Audio.IsAudioNumMaxV(PIGA["PigLayout"][peizhiT]["CountdownAudio"],CountdownList)
		PIGA["PigLayout"][peizhiT]["CountdownEndAudio"]=PD.Audio.IsAudioNumMaxV(PIGA["PigLayout"][peizhiT]["CountdownEndAudio"],CountdownEndList)
		function barUIxx.GetAudioData()
			return PIGA["PigLayout"][peizhiT]["Countdown"],CountdownList[PIGA["PigLayout"][peizhiT]["CountdownAudio"]],PIGA["PigLayout"][peizhiT]["CountdownEnd"],CountdownEndList[PIGA["PigLayout"][peizhiT]["CountdownEndAudio"]]
		end
	end
	barUIxx.butnum=1
	barUIxx.butjiangeW=0
	for i=1,listNum do
		if not PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]] then
			local frameType=ButDropList[ListIndex[i]] or "Button"
			local iconData = ListIcon[ListIndex[i]]
			local listbut
			if iconData[1]=="txt" or iconData[1]=="icontxt" then
				listbut = PIGDiyBut(barUIxx,{"LEFT", barUIxx, "LEFT",barUIxx.butnum*(HHH+3)-HHH+barUIxx.butjiangeW,0},{HHH+iconData[2],HHH,iconData[1],iconData[3]},nil,nil,frameType)
				barUIxx.butjiangeW=barUIxx.butjiangeW+iconData[2]
			else
				listbut = PIGDiyBut(barUIxx,{"LEFT", barUIxx, "LEFT",barUIxx.butnum*(HHH+3)-HHH+barUIxx.butjiangeW,0},{HHH,HHH,nil,nil,iconData[1]},nil,nil,frameType)
				listbut.OFF=iconData
				if iconData[2] then
					iconData[2][1](listbut,iconData[2][2],iconData[2][3],iconData[2][4],iconData[2][5],iconData[2][6],iconData[2][7])
				end
			end
			if ListIconON and ListIconON[ListIndex[i]] then
				listbut.ON_1=ListIconON[ListIndex[i]]
			end
			barUIxx.butnum=barUIxx.butnum+1
			--提示
			listbut.Tooltip=ListTips[ListIndex[i]]
			listbut.old_Tooltip=ListTips[ListIndex[i]]
			listbut:HookScript("OnLeave", function (self)
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end)
			listbut:HookScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT",0,0);
				if frameType=="DropdownButton" then
					if self.disabledTooltipText then
						local tooltipText = RED_FONT_COLOR:WrapTextInColorCode(self.disabledTooltipText);
						GameTooltip_SetTitle(GameTooltip, tooltipText);
					else
						GameTooltip_SetTitle(GameTooltip, self.Tooltip);
					end
				else
					GameTooltip:AddLine(self.Tooltip)
					if self.TimerModeTooltip then
						self:TimerModeTooltip()
					end
				end
				GameTooltip:Show();
			end);
			listbut:HookScript("OnClick", function(self)
				GameTooltip:Hide() 
			end)
			if ListEvent[ListIndex[i]] then
				ListEvent[ListIndex[i]](listbut,barUIxx,set)
			end
			if ListFun[ListIndex[i]] then
				listbut:HookScript("OnClick", function(self,button)
					ListFun[ListIndex[i]](self,button)
				end)
			end
		end
	end
	barUIxx:SetWidth((HHH+3)*(barUIxx.butnum-1)+2+barUIxx.butjiangeW)
end
function PigLayoutFun.add_Options_1(peizhiT,fujiF)
	fujiF:HookScript("OnShow", function ()
		if fujiF[peizhiT.."setui"] then return end
		fujiF[peizhiT.."setui"]=true
		local UIname=format(FormatUIname,peizhiT)
		local barTitle=GNLsits[peizhiT].barname
		local barname,MenuData=barTitle..(GNLsits[peizhiT].barname1 or ""),GNLsits[peizhiT].MenuData
		local ListIndex,ListTips,ListIcon,ListFun,ListEvent,ListIconON=MenuData.Index,MenuData.Tips,MenuData.Icon,MenuData.Click,MenuData.Event,MenuData.IconON
		local listNum=#ListIndex
		local UpdateIcon=PigLayoutFun.UpdateIcon
		---
		local checkbutOpen = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,GNLsits[peizhiT].OptionsTop[1]-20},{barname,"在屏幕上显示"..barname})
		checkbutOpen:SetChecked(PIGA["PigLayout"][peizhiT]["Open"]);
		checkbutOpen:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["PigLayout"][peizhiT]["Open"]=true;
				PigLayoutFun.add_barUI(peizhiT,true)
			else
				PIGA["PigLayout"][peizhiT]["Open"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			self.F:SetShown(PIGA["PigLayout"][peizhiT]["Open"])
		end)
		function checkbutOpen.add_SetUI(Fui)
			if Fui.F then return end
			Fui.F = PIGFrame(Fui,{"TOPLEFT",Fui,"BOTTOMLEFT",20,-20},{1,1})
			Fui.F:SetShown(PIGA["PigLayout"][peizhiT]["Open"])

			Fui.F.CZBUT = PIGButton(Fui.F,{"TOPLEFT",checkbutOpen,"TOPRIGHT",480,0},{60,22},RESET)
			Fui.F.CZBUT:SetScript("OnClick", function ()
				local oldOpen = PIGA["PigLayout"][peizhiT]["Open"]
				PIGA["PigLayout"][peizhiT]=CopyTable(PD.Default["PigLayout"][peizhiT])
				PIGA["PigLayout"][peizhiT]["Open"]=oldOpen
				SetUIXYScale(peizhiT)
				SetLookUI(peizhiT)
				SetBGHide(peizhiT)
				Create.PIG_ResPoint(UIname)
				Fui.F.UpdateSetUI()
			end)

			Fui.F.topMenuListBut={}
			for i=1,listNum do
				local pindaol = PIGCheckbutton(Fui.F,nil,{ListTips[ListIndex[i]]},nil,nil,i)
				if peizhiT=="topMenu" then
					pindaol.Text:SetText("")
					pindaol:SetHitRectInsets(0,-20,0,0);
					pindaol.icon = pindaol:CreateTexture();
					pindaol.icon:SetSize(20,20);
					pindaol.icon:SetPoint("LEFT",pindaol,"RIGHT",0,0);
					UpdateIcon(pindaol,ListIcon[ListIndex[i]])
					if ListIndex[i]=="TIME" then
						pindaol.tooltip=format(ListTips[ListIndex[i]], "计时", "计时")
					end
				end
				Fui.F.topMenuListBut[i]=pindaol
				if i==1 then
					pindaol:SetPoint("TOPLEFT",Fui.F,"TOPLEFT",0,-0);
				else
					if peizhiT=="topMenu" then
						pindaol:SetPoint("LEFT", Fui.F.topMenuListBut[i-1], "RIGHT", GNLsits[peizhiT].OptionsTop[2], 0);
					else
						pindaol:SetPoint("LEFT", Fui.F.topMenuListBut[i-1].Text, "RIGHT", 6, 0);
					end
				end
				pindaol:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]]=nil;
					else
						PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]]=true;
					end
					PIG_OptionsUI.RLUI:Show()
				end);
				Fui.F.topMenuListBut[i]:SetChecked(not PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]])
			end

			Fui.F.Lock =PIGCheckbutton(Fui.F,{"TOPLEFT",Fui.F,"TOPLEFT",0,-40},{LOCK_FRAME,LOCK_FOCUS_FRAME})
			Fui.F.Lock:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["PigLayout"][peizhiT]["Lock"]=true;
				else
					PIGA["PigLayout"][peizhiT]["Lock"]=false;
				end
				SetLookUI(peizhiT)
			end);
			Fui.F.BGHide= PIGCheckbutton(Fui.F,{"LEFT",Fui.F.Lock.Text,"RIGHT",30,0},{"隐藏背景","隐藏标记按钮背景"})
			Fui.F.BGHide:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["PigLayout"][peizhiT]["BGHide"]=true;
				else
					PIGA["PigLayout"][peizhiT]["BGHide"]=false;
				end
				SetBGHide(peizhiT)
			end);
			Fui.F.Scale = PIGSlider(Fui.F,{"TOPLEFT",Fui.F.Lock,"BOTTOMLEFT",0,-10},{0.6,2,0.01,{["Right"]="缩放%d%%"}},160)
			function Fui.F.Scale:PIGOnValueChange(arg1)
				PIGA["PigLayout"][peizhiT]["Scale"]=arg1;
				SetUIXYScale(peizhiT)
			end

			local TimeModeList={"战斗计时","当前时间","动态(战斗:战斗计时, 脱战:当前时间)",}
			if peizhiT=="topMenu" then
				Fui.F.daojishiTime = PIGSlider(Fui.F,{"TOPLEFT",Fui.F,"TOPLEFT",0,-160},{3,180,1,{["Right"]="默认倒数%d秒"}},400)
				function Fui.F.daojishiTime:PIGOnValueChange(arg1)
					PigLayoutFun.morenCD=arg1
					PIGA["PigLayout"][peizhiT]["daojishiTime"]=arg1;
				end

				Fui.F.Time_t = PIGFontString(Fui.F,{"TOPLEFT",Fui.F.daojishiTime,"BOTTOMLEFT",0,-20},"时间模式");
				Fui.F.Time=PIGDownMenu(Fui.F,{"LEFT",Fui.F.Time_t,"RIGHT",0,0},{300})
				function Fui.F.Time:PIGDownMenu_Update_But()
					local info = {}
					info.func = self.PIGDownMenu_SetValue
					for i=1,#TimeModeList,1 do
					    info.text, info.arg1 = TimeModeList[i], i
					    info.checked = i==PIGA["PigLayout"][peizhiT]["TimerMode"]
						self:PIGDownMenu_AddButton(info)
					end 
				end
				function Fui.F.Time:PIGDownMenu_SetValue(value,arg1,arg2)
					self:PIGDownMenu_SetText(value)
					PIGA["PigLayout"][peizhiT]["TimerMode"]=arg1
					PigLayoutFun.UpdateTimerMode()
					PIGCloseDropDownMenus()
				end
				Fui.F.Time24 = PIGCheckbutton(Fui.F,{"LEFT",Fui.F.Time,"RIGHT",10,0},{"24H模式"})
				Fui.F.Time24:SetScript("OnClick", function (self)
					if GetCVarBool("timeMgrUseMilitaryTime") then
						SetCVar("timeMgrUseMilitaryTime","0")
					else
						SetCVar("timeMgrUseMilitaryTime","1")
					end
				end);
				Fui.F.Time24:SetChecked(GetCVarBool("timeMgrUseMilitaryTime"))
				Fui.F.TimeBGHide = PIGCheckbutton(Fui.F,{"LEFT",Fui.F.Time24.Text,"RIGHT",10,0},{"隐藏计时背景"})
				Fui.F.TimeBGHide:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["PigLayout"][peizhiT]["TimeBGHide"]=true
					else
						PIGA["PigLayout"][peizhiT]["TimeBGHide"]=false
					end
					if _G[UIname] then _G[UIname]:TimeShowBGFun() end
				end);
				Fui.F.Countdown = PIGCheckbutton(Fui.F,{"TOPLEFT",Fui.F.Time_t,"BOTTOMLEFT",0,-20},{"启用读秒音效"})
				Fui.F.Countdown:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["PigLayout"][peizhiT]["Countdown"]=true
					else
						PIGA["PigLayout"][peizhiT]["Countdown"]=false
					end
				end);
				Fui.F.CountdownAudio=PIGDownMenu(Fui.F,{"LEFT",Fui.F.Countdown.Text,"RIGHT",0,0},{180})
				function Fui.F.CountdownAudio:PIGDownMenu_Update_But()
					local info = {}
					info.func = self.PIGDownMenu_SetValue
					for i=1,#CountdownList,1 do
					    info.text, info.arg1 = CountdownList[i][1], i
					    info.checked = i==PIGA["PigLayout"][peizhiT]["CountdownAudio"]
						self:PIGDownMenu_AddButton(info)
					end 
				end
				function Fui.F.CountdownAudio:PIGDownMenu_SetValue(value,arg1,arg2)
					self:PIGDownMenu_SetText(value)
					PIGA["PigLayout"][peizhiT]["CountdownAudio"]=arg1
					PIGCloseDropDownMenus()
				end
				Fui.F.CountdownAudio.PlayBut =PIGDiyBut(Fui.F.CountdownAudio,{"LEFT",Fui.F.CountdownAudio,"RIGHT",8,0},{24,24,nil,nil,"chatframe-button-icon-speaker-on",130757});
				Fui.F.CountdownAudio.PlayBut:SetScript("OnClick", function()
					PIG_PlaySoundFile(CountdownList[PIGA["PigLayout"][peizhiT]["CountdownAudio"]],1)
				end)
				Fui.F.CountdownEnd = PIGCheckbutton(Fui.F,{"TOPLEFT",Fui.F.Countdown,"BOTTOMLEFT",0,-20},{"启用结束音效"})
				Fui.F.CountdownEnd:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["PigLayout"][peizhiT]["CountdownEnd"]=true
					else
						PIGA["PigLayout"][peizhiT]["CountdownEnd"]=false
					end
				end);
				Fui.F.CountdownEnd:Disable()
				Fui.F.CountdownEndAudio=PIGDownMenu(Fui.F,{"LEFT",Fui.F.CountdownEnd.Text,"RIGHT",0,0},{180})
				function Fui.F.CountdownEndAudio:PIGDownMenu_Update_But()
					local info = {}
					info.func = self.PIGDownMenu_SetValue
					for i=1,#CountdownEndList,1 do
					    info.text, info.arg1 = CountdownEndList[i][1], i
					    info.checked = i==PIGA["PigLayout"][peizhiT]["CountdownEndAudio"]
						self:PIGDownMenu_AddButton(info)
					end 
				end
				function Fui.F.CountdownEndAudio:PIGDownMenu_SetValue(value,arg1,arg2)
					self:PIGDownMenu_SetText(value)
					PIGA["PigLayout"][peizhiT]["CountdownEndAudio"]=arg1
					PIGCloseDropDownMenus()
				end
				Fui.F.CountdownEndAudio.PlayBut =PIGDiyBut(Fui.F.CountdownEndAudio,{"LEFT",Fui.F.CountdownEndAudio,"RIGHT",8,0},{24,24,nil,nil,"chatframe-button-icon-speaker-on",130757});
				Fui.F.CountdownEndAudio.PlayBut:SetScript("OnClick", function()
					PIG_PlaySoundFile(CountdownEndList[PIGA["PigLayout"][peizhiT]["CountdownEndAudio"]])
				end)
			end
			function Fui.F.UpdateSetUI()
				Fui.F.Scale:PIGSetValue(PIGA["PigLayout"][peizhiT]["Scale"])
				Fui.F.Lock:SetChecked(PIGA["PigLayout"][peizhiT]["Lock"]);
				Fui.F.BGHide:SetChecked(PIGA["PigLayout"][peizhiT]["BGHide"]);
				if peizhiT=="topMenu" then
					Fui.F.daojishiTime:PIGSetValue(PIGA["PigLayout"][peizhiT]["daojishiTime"])
					Fui.F.TimeBGHide:SetChecked(PIGA["PigLayout"][peizhiT]["TimeBGHide"])
					Fui.F.Time:PIGDownMenu_SetText(TimeModeList[PIGA["PigLayout"][peizhiT]["TimerMode"]])
					Fui.F.Countdown:SetChecked(PIGA["PigLayout"][peizhiT]["Countdown"]);
					Fui.F.CountdownAudio:PIGDownMenu_SetText(CountdownList[PIGA["PigLayout"][peizhiT]["CountdownAudio"]][1])
					Fui.F.CountdownEnd:SetChecked(PIGA["PigLayout"][peizhiT]["CountdownEnd"]);
					Fui.F.CountdownEndAudio:PIGDownMenu_SetText(CountdownEndList[PIGA["PigLayout"][peizhiT]["CountdownEndAudio"]][1])
				end
			end
			Fui.F.UpdateSetUI()
		end
		checkbutOpen.add_SetUI(checkbutOpen)
	end);
end
function PigLayoutFun.add_Options(peizhiT,barTitle)
	local fujiF,fujiBut =PIGOptionsList_R(PigLayoutFun.RTabFrame,barTitle,80)
	PigLayoutFun["Tab2"..barTitle]=fujiF
	PigLayoutFun["Tab2F"..barTitle]=fujiBut
	if type(peizhiT)=="table" then
		for i=1,#peizhiT do
			PigLayoutFun.add_Options_1(peizhiT[i],fujiF)
		end
	else
		PigLayoutFun.add_Options_1(peizhiT,fujiF)
	end
end