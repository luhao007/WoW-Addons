local _, PD = ...;
local L=PD.locale
local Fun=PD.Fun
--
local Data=PD.Data
local Create=PD.Create
local GeneralFun=PD.GeneralFun
---
function GeneralFun.Common_ErrorsHide()
	if PIGA["Other"]["ErrorsHide"] then
        UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	else
		UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
	end
	if PIGA["Other"]["ErrorsHide_Y"] then
        UIErrorsFrame:UnregisterEvent("UI_INFO_MESSAGE")
	else
		UIErrorsFrame:RegisterEvent("UI_INFO_MESSAGE")
	end
end
function GeneralFun.Common_Updata_addonProfilerEnabled()
	local oldfun=C_AddOnProfiler.IsEnabled
	if PIGA["Common"]["addonProfilerEnabled"] then
		C_AddOnProfiler.IsEnabled = function() return false end
		C_CVar.RegisterCVar("addonProfilerEnabled", "1"); C_CVar.SetCVar("addonProfilerEnabled", "0")
	else
		C_AddOnProfiler.IsEnabled = oldfun
	end
end
function PD.addOptions_General()
	local Llist,LlistTabBut = Create.PIGOptionsList(GENERAL,"TOP")
	Llist:Show()
	LlistTabBut:Selected(true)
	GeneralFun.Llist=Llist
	GeneralFun.LlistTabBut=LlistTabBut
	function GeneralFun.ShowSetUI()
		Create.Show_TabBut(Llist,LlistTabBut)
		Create.Show_TabBut_R(GeneralFun.NR,GeneralFun.HardcoreTabF,GeneralFun.HardcoreTabBut)
	end
	---------
	Llist:SetScript("OnShow", function (self)
		if GeneralFun.NR then return end
		local NR =Create.PIGOptionsList_RF(Llist)
		GeneralFun.NR=NR
		GeneralFun.addOptions_General()
		GeneralFun.addOptions_Interaction()
		if GeneralFun.addOptions_BabySitter then GeneralFun.addOptions_BabySitter() end
		if GeneralFun.addOptions_Hardcore then GeneralFun.addOptions_Hardcore() end
	end);
end

----战斗日志
local Opentiaojian = {
	[1]=string.format(LFG_LIST_CROSS_FACTION,GUILD_CHALLENGE_TYPE2),
	[2]=string.format(LFG_LIST_CROSS_FACTION,DUNGEONS),
	[3]=string.format(LFG_LIST_CROSS_FACTION,DUNGEONS.."/"..GUILD_CHALLENGE_TYPE2),
}
local function CombatLog_Open()
	if ( not LoggingCombat() ) then
		LoggingCombat(true)
	end
end
local function CombatLog_Stop()
	if ( LoggingCombat() ) then
		LoggingCombat(false)
	end
end
local CombatLogF = CreateFrame("Frame")
CombatLogF.CD=0
CombatLogF.Count=0
CombatLogF:RegisterEvent("PLAYER_ENTERING_WORLD");
CombatLogF:SetScript("OnEvent",function (self,event)
	C_Timer.After(1,function()
		GeneralFun.advancedCombatLog()
	end)
end)
function CombatLogF:IsAutoOpen()
	self.OpenX=false
	if GetCVar("advancedCombatLogging")=="1" and PIGA["Common"]["AutoCombatLog"] then
		local name, instanceType, difficultyID, difficultyName, maxPlayers = GetInstanceInfo()
		if PIGA["Common"]["AutoCombatLogTJ"]==3 then
			if instanceType=="party" or instanceType=="raid" then
				self.OpenX=true
			end
		elseif PIGA["Common"]["AutoCombatLogTJ"]==1 then
			if instanceType=="raid" or maxPlayers>5 then
				self.OpenX=true
			end
		elseif PIGA["Common"]["AutoCombatLogTJ"]==2 then
			if instanceType=="party" then
				self.OpenX=true
			end
		end
	end
end
function CombatLogF:topMenuUIWCLButIcon()
	if GeneralFun.Update_advancedCombatSet then
		GeneralFun.Update_advancedCombatSet(self.OpenX)
	end
	if Data.topMenuUIWCLBut then
		if not Data.topMenuUIWCLBut.RClick then
			Data.topMenuUIWCLBut.RClick=function()
				PD.UpdateOptionsUI()
				Create.Show_TabBut(GeneralFun.Llist,GeneralFun.LlistTabBut)
				Create.Show_TabBut_R(GeneralFun.NR,GeneralFun.fujiF,GeneralFun.fujiTabBut)
			end
		end
		Data.topMenuUIWCLBut:WCLFun(self.OpenX)
	end
end
function GeneralFun.advancedCombatLog(set)
	if set then
		if GetServerTime()-CombatLogF.CD<10 then
			CombatLogF.Count=CombatLogF.Count+1
			if CombatLogF.Count>4 then
				PIGErrorMsg(ADVANCED_COMBAT_LOGGING..L["COMMON_ADVANCEDCOMBATTISP"],"R")
			end
		else
			CombatLogF.Count=0
			CombatLogF.CD=GetServerTime()
		end
	end 
	CombatLogF:IsAutoOpen()
	if CombatLogF.OpenX then
		CombatLog_Open()
	else
		CombatLog_Stop()
	end
	CombatLogF:topMenuUIWCLButIcon()
end
function GeneralFun.addOptions_General()
	local PIGFrame=Create.PIGFrame
	local PIGButton=Create.PIGButton
	local PIGSlider = Create.PIGSlider
	local PIGDownMenu=Create.PIGDownMenu
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGFontString=Create.PIGFontString
	local PIGModCheckbutton=Create.PIGModCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local fujiF,fujiTabBut =PIGOptionsList_R(GeneralFun.NR,GENERAL,70)
	fujiF:Show()
	fujiTabBut:Selected(true)
	GeneralFun.fujiF,GeneralFun.fujiTabBut=fujiF,fujiTabBut
	--系统设置---------
	fujiF.xitongF=PIGFrame(fujiF,{"BOTTOMLEFT", fujiF, "BOTTOMLEFT", 0, 0})
	fujiF.xitongF:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", 0, 0);
	fujiF.xitongF:SetHeight(80)
	fujiF.xitongF:PIGSetBackdrop(0,0.6)
	--UI缩放
	fujiF.xitongF.Scale =PIGCheckbutton(fujiF.xitongF,{"TOPLEFT",fujiF.xitongF,"TOPLEFT",20,-20},{UI_SCALE,USE_UISCALE})
	fujiF.xitongF.Scale:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar("useUIScale","1")
		else
			SetCVar("useUIScale","0")
		end
	end);
	fujiF.xitongF.ScaleSlider = PIGSlider(fujiF.xitongF,{"LEFT",fujiF.xitongF.Scale.Text,"RIGHT",10,0}, {0.4, 1.15, 0.01})
	function fujiF.xitongF.ScaleSlider:PIGOnValueChange(arg1)
		if self.Ticker1 then self.Ticker1:Cancel() end
		self.Ticker1=C_Timer.NewTimer(1,function()
			if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
			SetCVar("uiscale",arg1)
		end)
	end
	fujiF.xitongF.ScaleSlider.tuijian =PIGFontString(fujiF.xitongF.ScaleSlider,{"TOPLEFT",fujiF.xitongF.Scale,"BOTTOMLEFT",20,-10},RECOMMENDED)
	local ScreenH=GetScreenHeight()
	local biliV={1,0.8,0.6}
	for i=1,3 do
		local newsV=768/ScreenH/biliV[i]
		if newsV>1.15 then newsV=768/ScreenH/(1/biliV[i]) end
		local butxx=PIGButton(fujiF.xitongF.Scale,{"LEFT", fujiF.xitongF.ScaleSlider.tuijian, "RIGHT",64*(i-1)+4, 0},{60,20},floor((newsV*10000))/10000)
		butxx.newsV=newsV
		butxx:SetScript("OnClick", function (self)
			SetCVar("uiscale",self.newsV)
			fujiF.xitongF.ScaleSlider:PIGSetValue(GetCVar("uiscale"))
		end);
	end
	--主音量
	fujiF.xitongF.Volume =PIGFontString(fujiF.xitongF,{"TOPLEFT",fujiF.xitongF,"TOPLEFT",340,-20},MASTER_VOLUME)
	fujiF.xitongF.Volume:SetTextColor(1, 1, 1, 1)
	fujiF.xitongF.VolumeSlider = PIGSlider(fujiF.xitongF,{"LEFT",fujiF.xitongF.Volume,"RIGHT",10,0},{0, 1, 0.01,{["Right"]="%d%%"}})
	function fujiF.xitongF.VolumeSlider:PIGOnValueChange(arg1)
		SetCVar("Sound_MasterVolume",arg1)
	end

	---性能优化===========
	fujiF.xingnengF=PIGFrame(fujiF,{"BOTTOMLEFT", fujiF.xitongF, "TOPLEFT", 0, -1})
	fujiF.xingnengF:SetPoint("BOTTOMRIGHT", fujiF.xitongF, "TOPRIGHT", 0, -1);
	fujiF.xingnengF:SetHeight(154)
	fujiF.xingnengF:PIGSetBackdrop(0,0.6)
	
	---关闭新版字体
	fujiF.xingnengF.offnewfont =PIGCheckbutton_R(fujiF.xingnengF,{L["COMMON_SLUGOFF"],L["COMMON_SLUGOFFTISP"]},true)
	fujiF.xingnengF.offnewfont:HookScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar("UseSlug","0")
			PIGA["Common"]["Offnewfont"]=true
		else
			SetCVar("UseSlug","1")
			PIGA["Common"]["Offnewfont"]=false
		end
	end);
	--关闭11.0CPU监控
	fujiF.xingnengF.addonProfilerEnabled =PIGCheckbutton(fujiF.xingnengF.offnewfont,{"LEFT",fujiF.xingnengF.offnewfont,"RIGHT",280,0},{L["COMMON_ADDONPROFILER"],L["COMMON_ADDONPROFILERTISP"]})
	fujiF.xingnengF.addonProfilerEnabled:HookScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Common"]["addonProfilerEnabled"]=true
		else
			PIGA["Common"]["addonProfilerEnabled"]=false
		end
		GeneralFun.Common_Updata_addonProfilerEnabled()
	end);
	-----战斗日志
	fujiF.xingnengF.Advanced_CombatLog =PIGCheckbutton_R(fujiF.xingnengF,{ADVANCED_COMBAT_LOGGING,OPTION_TOOLTIP_ADVANCED_COMBAT_LOGGING},true)
	fujiF.xingnengF.Advanced_CombatLog:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar("advancedCombatLogging", "1")
		else
			SetCVar("advancedCombatLogging", "0")
		end
		GeneralFun.advancedCombatLog(true)
	end);
	fujiF.xingnengF.CombatLog =PIGCheckbutton_R(fujiF.xingnengF,{L["COMMON_COMBATSTART"]},true)
	fujiF.xingnengF.CombatLog:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Common"]["AutoCombatLog"]=true
		else
			PIGA["Common"]["AutoCombatLog"]=false
		end
		GeneralFun.advancedCombatLog(true)
	end);
	fujiF.xingnengF.CombatLog.Opentj=PIGDownMenu(fujiF.xingnengF.CombatLog,{"LEFT",fujiF.xingnengF.CombatLog.Text,"RIGHT",4,0},{210,nil})
	fujiF.xingnengF.CombatLog.Opentj.tt = PIGFontString(fujiF.xingnengF.CombatLog.Opentj,{"LEFT",fujiF.xingnengF.CombatLog.Opentj,"RIGHT",10,0},STATS_LABEL);
	fujiF.xingnengF.CombatLog.Opentj.on = PIGFontString(fujiF.xingnengF.CombatLog.Opentj,{"LEFT",fujiF.xingnengF.CombatLog.Opentj.tt,"RIGHT",4,0},"","OUTLINE",15);
	function fujiF.xingnengF.CombatLog.Opentj:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#Opentiaojian,1 do
		    info.text, info.arg1 = Opentiaojian[i], i
		    info.checked = i==PIGA["Common"]["AutoCombatLogTJ"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function fujiF.xingnengF.CombatLog.Opentj:PIGDownMenu_SetValue(value,arg1,arg2)
		self:PIGDownMenu_SetText(value)
		PIGA["Common"]["AutoCombatLogTJ"]=arg1
		PIGCloseDropDownMenus()
		GeneralFun.advancedCombatLog(true)
	end
	fujiF.xingnengF.CombatLog.tips = PIGFontString(fujiF.xingnengF.CombatLog,{"TOPLEFT",fujiF.xingnengF.CombatLog,"BOTTOMLEFT",20,-6},COMBATLOGENABLED);
	function fujiF.xingnengF:UpdateWCL_Checkbut()
		
	end
	function GeneralFun.Update_advancedCombatSet(OpenX)
		if not fujiF.xingnengF:IsShown() then return end
		if GetCVar("advancedCombatLogging")=="1" then
			fujiF.xingnengF.Advanced_CombatLog:SetChecked(true);
			fujiF.xingnengF.CombatLog:Enable()
		else
			fujiF.xingnengF.Advanced_CombatLog:SetChecked(false);
			fujiF.xingnengF.CombatLog:Disable()
		end
		fujiF.xingnengF.CombatLog:SetChecked(PIGA["Common"]["AutoCombatLog"]);
		fujiF.xingnengF.CombatLog.Opentj:PIGDownMenu_SetText(Opentiaojian[PIGA["Common"]["AutoCombatLogTJ"]])
		if OpenX then
			fujiF.xingnengF.CombatLog.Opentj.on:SetText(SLASH_TEXTTOSPEECH_ON)
			fujiF.xingnengF.CombatLog.Opentj.on:SetTextColor(0, 1, 0, 1)
		else
			fujiF.xingnengF.CombatLog.Opentj.on:SetText(SLASH_TEXTTOSPEECH_OFF)
			fujiF.xingnengF.CombatLog.Opentj.on:SetTextColor(1, 0, 0, 1)
		end
	end
	CombatLogF:IsAutoOpen()
	GeneralFun.Update_advancedCombatSet(OpenX)
	--其他
	fujiF.OtherF=PIGFrame(fujiF,{"BOTTOMLEFT", fujiF.xingnengF, "TOPLEFT", 0, -1})
	fujiF.OtherF:SetPoint("BOTTOMRIGHT", fujiF.xingnengF, "TOPRIGHT", 0, -1);
	fujiF.OtherF:SetHeight(150)
	fujiF.OtherF:PIGSetBackdrop(0,0.6)

	fujiF.OtherF.ErrorsHide = PIGCheckbutton_R(fujiF.OtherF,{L["COMMON_HIDEREDERROR"]})
	fujiF.OtherF.ErrorsHide:SetScript("OnClick", function (self)
	    if self:GetChecked() then
	        PIGA["Other"]["ErrorsHide"]=true;
	    else
	        PIGA["Other"]["ErrorsHide"]=false;
	    end
	    GeneralFun.Common_ErrorsHide()
	end)
	fujiF.OtherF.ErrorsHide_Y = PIGCheckbutton_R(fujiF.OtherF,{L["COMMON_HIDEYELLOWINFO"]})
	fujiF.OtherF.ErrorsHide_Y:SetScript("OnClick", function (self)
	    if self:GetChecked() then
	        PIGA["Other"]["ErrorsHide_Y"]=true;
	    else
	        PIGA["Other"]["ErrorsHide_Y"]=false;
	    end
	    GeneralFun.Common_ErrorsHide()
	end)

	fujiF.OtherF.PigLoad = PIGCheckbutton_R(fujiF.OtherF,{L["COMMON_HIDEPIGLOAD"]})
	fujiF.OtherF.PigLoad:SetScript("OnClick", function (self)
	    if self:GetChecked() then
	        PIGA["Other"]["PigLoad"]=true;
	    else
	        PIGA["Other"]["PigLoad"]=false;
	    end
	end)
	---
	fujiF.TopF=PIGFrame(fujiF,{"TOPLEFT", fujiF, "TOPLEFT", 0, 0})
	fujiF.TopF:SetPoint("BOTTOMRIGHT", fujiF.OtherF, "TOPRIGHT", 0, -1);
	fujiF.TopF:SetHeight(120)
	fujiF.TopF:PIGSetBackdrop(0,0.6)
	--AFK
	fujiF.TopF.AFK = PIGModCheckbutton(fujiF.TopF,{L["COMMON_AFK"],L["COMMON_AFKTISP"]},{"TOPLEFT",fujiF.TopF,"TOPLEFT",20,-20})
	fujiF.TopF.AFK:SetScript("OnClick", function (self)
	    if self:GetChecked() then
	        PIGA["Other"]["AFK"]["Open"]=true;
	        GeneralFun.Common_AFK()
	    else
	        PIGA["Other"]["AFK"]["Open"]=false
	        PIG_OptionsUI.RLUI:Show()
	    end
	    Fun.QuickBut_Update()
	end)
	fujiF.TopF.AFK.QKBut:SetPoint("LEFT",fujiF.TopF.AFK.Text,"RIGHT",20,0);
	fujiF.TopF.AFK.QKBut:SetScript("OnClick", function (self)
	    if self:GetChecked() then
	        PIGA["Other"]["AFK"]["QuickBut"]=true
	    else
	        PIGA["Other"]["AFK"]["QuickBut"]=false
	    end
	    Fun.QuickBut_Update()
	end)
	fujiF.TopF.AFK.TispTXTt = PIGFontString(fujiF.TopF.AFK,{"TOPLEFT", fujiF.TopF.AFK, "BOTTOMLEFT", 20,-10},L["LIB_TIPS"]..": ");
	fujiF.TopF.AFK.TispTXT = CreateFrame("EditBox", nil, fujiF.TopF.AFK,"InputBoxInstructionsTemplate");
	fujiF.TopF.AFK.TispTXT:SetSize(300,26);
	fujiF.TopF.AFK.TispTXT:SetPoint("LEFT",fujiF.TopF.AFK.TispTXTt,"RIGHT",6,0);
	fujiF.TopF.AFK.TispTXT:SetFontObject(ChatFontNormal);
	fujiF.TopF.AFK.TispTXT:SetMaxLetters(20)
	fujiF.TopF.AFK.TispTXT:SetAutoFocus(false);
	fujiF.TopF.AFK.TispTXT:SetTextColor(0.7, 0.7, 0.7, 1);
	fujiF.TopF.AFK.TispTXT:SetScript("OnEditFocusGained", function(self) 
	    self:SetTextColor(1, 1, 1, 1);
	end);
	fujiF.TopF.AFK.TispTXT:SetScript("OnEditFocusLost", function(self)
	    self:SetTextColor(0.7, 0.7, 0.7, 1);
	    self:SetText(PIGA["Other"]["AFK"]["TispTXT"])
	end);
	fujiF.TopF.AFK.TispTXT:SetScript("OnEscapePressed", function(self) 
	    self:ClearFocus()
	end);
	fujiF.TopF.AFK.TispTXT:SetScript("OnEnterPressed", function(self)
	    PIGA["Other"]["AFK"]["TispTXT"]=self:GetText()
	    self:ClearFocus()
	end);
	fujiF.TopF.AFK.TispTXT.CZ=PIGButton(fujiF.TopF.AFK.TispTXT,{"LEFT", fujiF.TopF.AFK.TispTXT, "RIGHT", 6, 0},{120,20},RESET_TO_DEFAULT)
	fujiF.TopF.AFK.TispTXT.CZ:SetScript("OnClick", function (self)
		PIGA["Other"]["AFK"]["TispTXT"]=PD.Default["Other"]["AFK"]["TispTXT"]
		fujiF.TopF.AFK.TispTXT:SetText(PIGA["Other"]["AFK"]["TispTXT"])
	end);
	-------
	fujiF.xitongF.Scale:SetChecked(GetCVarBool("useUIScale"));
	fujiF.xitongF.ScaleSlider:PIGSetValue(GetCVar("uiscale"))
	fujiF.xitongF.VolumeSlider:PIGSetValue(GetCVar("Sound_MasterVolume"))
	fujiF.xingnengF.offnewfont:SetChecked(PIGA["Common"]["Offnewfont"])
	if PIGA["Common"]["Offnewfont"] then SetCVar("UseSlug","0") end
	fujiF.xingnengF.addonProfilerEnabled:SetChecked(PIGA["Common"]["addonProfilerEnabled"])
	fujiF.OtherF.ErrorsHide:SetChecked(PIGA["Other"]["ErrorsHide"]);
	fujiF.OtherF.ErrorsHide_Y:SetChecked(PIGA["Other"]["ErrorsHide_Y"]);
	fujiF.OtherF.PigLoad:SetChecked(PIGA["Other"]["PigLoad"]);
	fujiF.TopF.AFK:SetChecked(PIGA["Other"]["AFK"]["Open"]);
	fujiF.TopF.AFK.QKBut:SetChecked(PIGA["Other"]["AFK"]["QuickBut"]);
	fujiF.TopF.AFK.TispTXT:SetText(PIGA["Other"]["AFK"]["TispTXT"])
end