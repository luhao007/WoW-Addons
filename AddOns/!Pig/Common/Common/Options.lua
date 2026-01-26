local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGDiyBut=Create.PIGDiyBut
local PIGEnter=Create.PIGEnter
local PIGSlider = Create.PIGSlider
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGModCheckbutton=Create.PIGModCheckbutton
--
local Data=addonTable.Data
local CommonInfo=addonTable.CommonInfo
CommonInfo.Commonfun={}
----常用
local fujiF,fujiTabBut =PIGOptionsList_R(CommonInfo.NR,GENERAL,70)
fujiF:Show()
fujiTabBut:Selected(true)

--系统设置---------
fujiF.xitongF=PIGFrame(fujiF,{"BOTTOMLEFT", fujiF, "BOTTOMLEFT", 0, 0})
fujiF.xitongF:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", 0, 0);
fujiF.xitongF:SetHeight(50)
fujiF.xitongF:PIGSetBackdrop(0,0.6)
--UI缩放
fujiF.xitongF.Scale =PIGCheckbutton(fujiF.xitongF,{"LEFT",fujiF.xitongF,"LEFT",20,0},{UI_SCALE,USE_UISCALE})
fujiF.xitongF.Scale:SetScript("OnClick", function (self)
	if self:GetChecked() then
		SetCVar("useUIScale","1")
	else
		SetCVar("useUIScale","0")
	end
end);
fujiF.xitongF.ScaleSlider = PIGSlider(fujiF.xitongF,{"LEFT",fujiF.xitongF.Scale.Text,"RIGHT",10,0}, {0.65, 1.15, 0.01,{["Right"]="%"}})
function fujiF.xitongF.ScaleSlider:PIGOnValueChange(arg1)
	if self.Ticker1 then self.Ticker1:Cancel() end
	self.Ticker1=C_Timer.NewTimer(1,function()
		if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
		SetCVar("uiscale",arg1)
	end)
end
--主音量
fujiF.xitongF.Volume =PIGFontString(fujiF.xitongF,{"TOPLEFT",fujiF.xitongF,"TOPLEFT",340,-20},MASTER_VOLUME)
fujiF.xitongF.Volume:SetTextColor(1, 1, 1, 1)
fujiF.xitongF.VolumeSlider = PIGSlider(fujiF.xitongF,{"LEFT",fujiF.xitongF.Volume,"RIGHT",10,0},{0, 1, 0.01,{["Right"]="%"}})
function fujiF.xitongF.VolumeSlider:PIGOnValueChange(arg1)
	SetCVar("Sound_MasterVolume",arg1)
end

---性能优化===========
fujiF.xingnengF=PIGFrame(fujiF,{"BOTTOMLEFT", fujiF.xitongF, "TOPLEFT", 0, -1})
fujiF.xingnengF:SetPoint("BOTTOMRIGHT", fujiF.xitongF, "TOPRIGHT", 0, -1);
fujiF.xingnengF:SetHeight(154)
fujiF.xingnengF:PIGSetBackdrop(0,0.6)
---关闭新版字体
fujiF.xingnengF.offnewfont =PIGCheckbutton_R(fujiF.xingnengF,{"关闭Slug字体特效","关闭10.0之后增加的Slug字体特效。一种新的字体渲染引擎，主要为了改善浮动信息以及姓名板名字效果。但是此功能会导致额外加载时间，某些情况还会导致第一次进战斗卡顿一下"},true)
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
fujiF.xingnengF.addonProfilerEnabled =PIGCheckbutton(fujiF.xingnengF.offnewfont,{"LEFT",fujiF.xingnengF.offnewfont,"RIGHT",280,0},{"关闭插件占用分析功能","关闭11.0之后增加的插件占用分析功能。此功能会导致额外性能消耗，会导致帧率下降！"})
fujiF.xingnengF.addonProfilerEnabled:HookScript("OnClick", function (self)
	if self:GetChecked() then
		C_AddOnProfiler.IsEnabled = function() return false end
		C_CVar.RegisterCVar("addonProfilerEnabled", "1"); C_CVar.SetCVar("addonProfilerEnabled", "0")
		PIGA["Common"]["addonProfilerEnabled"]=true
	else
		C_AddOnProfiler.IsEnabled = function() return false end
		C_CVar.RegisterCVar("addonProfilerEnabled", "1"); C_CVar.SetCVar("addonProfilerEnabled", "1")
		PIGA["Common"]["addonProfilerEnabled"]=false
	end
end);
-----战斗日志
local Opentiaojian = {[1]="只在"..GUILD_CHALLENGE_TYPE2.."记录",[2]="只在"..DUNGEONS.."记录",[3]="只在"..DUNGEONS.."/"..GUILD_CHALLENGE_TYPE2.."记录"}
function CommonInfo.Commonfun.CombatLog_tjian()
	if PIGA["Common"]["AutoCombatLogTJ"]==4 then PIGA["Common"]["AutoCombatLogTJ"]=1 end
end
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
		self:ExecuteOpen()
	end)
end)
function CombatLogF:IsAutoOpen(set)
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
	if self.OpenX then
		fujiF.xingnengF.CombatLog.Opentj.on:SetText("正在记录")
		fujiF.xingnengF.CombatLog.Opentj.on:SetTextColor(0, 1, 0, 1)
	else
		fujiF.xingnengF.CombatLog.Opentj.on:SetText("未记录")
		fujiF.xingnengF.CombatLog.Opentj.on:SetTextColor(1, 0, 0, 1)
	end
	if Data.topMenuUIWCLBut then
		if not Data.topMenuUIWCLBut.RClick then
			Data.topMenuUIWCLBut.RClick=function()
				if PIG_OptionsUI:IsShown() then
					PIG_OptionsUI:Hide()
				else
					PIG_OptionsUI:Show()
					Create.Show_TabBut(CommonInfo.Llist,CommonInfo.LlistTabBut)
					Create.Show_TabBut_R(CommonInfo.NR,fujiF,fujiTabBut)
				end
			end
		end
		Data.topMenuUIWCLBut:WCLFun(self.OpenX)
	end
end
function CombatLogF:ExecuteOpen(set)
	if set then
		self:UpdateWCL_Checkbut()
		if GetServerTime()-self.CD<10 then
			self.Count=self.Count+1
			if self.Count>4 then
				PIG_OptionsUI:ErrorMsg(ADVANCED_COMBAT_LOGGING.."更改过于频繁","R")
			end
		else
			self.Count=0
			self.CD=GetServerTime()
		end
	end 
	self:IsAutoOpen()
	if self.OpenX then
		CombatLog_Open()
	else
		CombatLog_Stop()
	end
	self:topMenuUIWCLButIcon()
end
function CombatLogF:UpdateWCL_Checkbut()
	if GetCVar("advancedCombatLogging")=="1" then
		fujiF.xingnengF.Advanced_CombatLog:SetChecked(true);
		fujiF.xingnengF.CombatLog:Enable()
	else
		fujiF.xingnengF.Advanced_CombatLog:SetChecked(false);
		fujiF.xingnengF.CombatLog:Disable()
	end
	fujiF.xingnengF.CombatLog:SetChecked(PIGA["Common"]["AutoCombatLog"]);
	fujiF.xingnengF.CombatLog.Opentj:PIGDownMenu_SetText(Opentiaojian[PIGA["Common"]["AutoCombatLogTJ"]])
end
fujiF.xingnengF.Advanced_CombatLog =PIGCheckbutton_R(fujiF.xingnengF,{ENABLE..ADVANCED_COMBAT_LOGGING,ENABLE..ADVANCED_COMBAT_LOGGING},true)
fujiF.xingnengF.Advanced_CombatLog.tt = PIGFontString(fujiF.xingnengF.Advanced_CombatLog,{"LEFT",fujiF.xingnengF.Advanced_CombatLog.Text,"RIGHT",2,0},"《"..ENABLE..ADVANCED_COMBAT_LOGGING.."才可"..ENABLE..COMBAT_LOG.."》");
fujiF.xingnengF.Advanced_CombatLog.tt:SetTextColor(1, 0, 0, 1)
fujiF.xingnengF.Advanced_CombatLog:SetScript("OnClick", function (self)
	if self:GetChecked() then
		SetCVar("advancedCombatLogging", "1")
	else
		SetCVar("advancedCombatLogging", "0")
	end
	CombatLogF:ExecuteOpen(true)
end);
fujiF.xingnengF.CombatLog =PIGCheckbutton_R(fujiF.xingnengF,{"自动"..START..COMBAT_LOG,"根据预设条件自动"..START..COMBAT_LOG},true)
fujiF.xingnengF.CombatLog:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Common"]["AutoCombatLog"]=true
	else
		PIGA["Common"]["AutoCombatLog"]=false
	end
	CombatLogF:ExecuteOpen(true)
end);
fujiF.xingnengF.CombatLog.Opentj=PIGDownMenu(fujiF.xingnengF.CombatLog,{"LEFT",fujiF.xingnengF.CombatLog.Text,"RIGHT",4,0},{210,nil})
fujiF.xingnengF.CombatLog.Opentj.tt = PIGFontString(fujiF.xingnengF.CombatLog.Opentj,{"LEFT",fujiF.xingnengF.CombatLog.Opentj,"RIGHT",10,0},"当前状态:");
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
	CombatLogF:ExecuteOpen(true)
end
fujiF.xingnengF.CombatLog.tips = PIGFontString(fujiF.xingnengF.CombatLog,{"TOPLEFT",fujiF.xingnengF.CombatLog,"BOTTOMLEFT",20,-6},COMBATLOGENABLED);

--其他
fujiF.OtherF=PIGFrame(fujiF,{"BOTTOMLEFT", fujiF.xingnengF, "TOPLEFT", 0, -1})
fujiF.OtherF:SetPoint("BOTTOMRIGHT", fujiF.xingnengF, "TOPRIGHT", 0, -1);
fujiF.OtherF:SetHeight(150)
fujiF.OtherF:PIGSetBackdrop(0,0.6)

fujiF.OtherF.ErrorsHide = PIGCheckbutton_R(fujiF.OtherF,{IGNORE..RED_GEM..ERRORS..INFO})
fujiF.OtherF.ErrorsHide:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIGA["Other"]["ErrorsHide"]=true;
    else
        PIGA["Other"]["ErrorsHide"]=false;
    end
    CommonInfo.Commonfun.ErrorsHide()
end)
fujiF.OtherF.ErrorsHide_Y = PIGCheckbutton_R(fujiF.OtherF,{IGNORE..YELLOW_GEM..ERRORS..INFO})
fujiF.OtherF.ErrorsHide_Y:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIGA["Other"]["ErrorsHide_Y"]=true;
    else
        PIGA["Other"]["ErrorsHide_Y"]=false;
    end
    CommonInfo.Commonfun.ErrorsHide()
end)
function CommonInfo.Commonfun.ErrorsHide()
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
fujiF.OtherF.PigLoad = PIGCheckbutton_R(fujiF.OtherF,{IGNORE..addonName..LOAD_ADDON..L["LIB_TIPS"],IGNORE..addonName.."插件的载入提示"})
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
local QuickButUI=_G[Data.QuickButUIname]
fujiF.TopF.AFK = PIGModCheckbutton(fujiF.TopF,{"离开屏保","启用离开屏保后,离开自动进入屏保功能"},{"TOPLEFT",fujiF.TopF,"TOPLEFT",20,-20})
fujiF.TopF.AFK:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIGA["Other"]["AFK"]["Open"]=true;
        CommonInfo.Commonfun.Pig_AFK()
        QuickButUI.ButList[19]()
    else
        PIGA["Other"]["AFK"]["Open"]=false
        PIG_OptionsUI.RLUI:Show()
    end
end)
fujiF.TopF.AFK.QKBut:SetPoint("LEFT",fujiF.TopF.AFK.Text,"RIGHT",20,0);
fujiF.TopF.AFK.QKBut:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIGA["Other"]["AFK"]["QuickBut"]=true
        QuickButUI.ButList[19]()
    else
        PIGA["Other"]["AFK"]["QuickBut"]=false
        PIG_OptionsUI.RLUI:Show()
    end
end)
local TispTXT = "临时离开，勿动!!!"
function CommonInfo.Commonfun.GetAFKTispTXT(lytxt)
	if lytxt then
		if lytxt=="" or lytxt==" " then
	        PIGA["Other"]["AFK"]["TispTXT"]=nil
	    else
	        PIGA["Other"]["AFK"]["TispTXT"]=lytxt
	    end
	end
	if PIGA["Other"]["AFK"]["TispTXT"] and PIGA["Other"]["AFK"]["TispTXT"]==TispTXT then
		PIGA["Other"]["AFK"]["TispTXT"]=nil
	end
	return PIGA["Other"]["AFK"]["TispTXT"] or TispTXT
end
fujiF.TopF.AFK.TispTXTt = PIGFontString(fujiF.TopF.AFK,{"TOPLEFT", fujiF.TopF.AFK, "BOTTOMLEFT", 20,-10},"屏保提示:");
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
    self:SetText(CommonInfo.Commonfun.GetAFKTispTXT())
end);
fujiF.TopF.AFK.TispTXT:SetScript("OnEscapePressed", function(self) 
    self:ClearFocus()
end);
fujiF.TopF.AFK.TispTXT:SetScript("OnEnterPressed", function(self)
    CommonInfo.Commonfun.GetAFKTispTXT(self:GetText())
    self:ClearFocus()
end);
fujiF.TopF.AFK.TispTXT.CZ=PIGButton(fujiF.TopF.AFK.TispTXT,{"LEFT", fujiF.TopF.AFK.TispTXT, "RIGHT", 6, 0},{70,20},"恢复默认")
fujiF.TopF.AFK.TispTXT.CZ:SetScript("OnClick", function (self)
	PIGA["Other"]["AFK"]["TispTXT"]=nil
	fujiF.TopF.AFK.TispTXT:SetText(CommonInfo.Commonfun.GetAFKTispTXT())
end);
-------
fujiF:HookScript("OnShow", function (self)
	self.xitongF.Scale:SetChecked(GetCVarBool("useUIScale"));
	self.xitongF.ScaleSlider:PIGSetValue(GetCVar("uiscale"))
	self.xitongF.VolumeSlider:PIGSetValue(GetCVar("Sound_MasterVolume"))
	self.xingnengF.offnewfont:SetChecked(PIGA["Common"]["Offnewfont"])
	if PIGA["Common"]["Offnewfont"] then SetCVar("UseSlug","0") end
	self.xingnengF.addonProfilerEnabled:SetChecked(PIGA["Common"]["addonProfilerEnabled"])
	if PIGA["Common"]["addonProfilerEnabled"] then
		C_AddOnProfiler.IsEnabled = function() return false end
		C_CVar.RegisterCVar("addonProfilerEnabled", "1"); C_CVar.SetCVar("addonProfilerEnabled", "0")
	end
	CombatLogF:UpdateWCL_Checkbut()
	self.OtherF.ErrorsHide:SetChecked(PIGA["Other"]["ErrorsHide"]);
	self.OtherF.ErrorsHide_Y:SetChecked(PIGA["Other"]["ErrorsHide_Y"]);
    self.OtherF.PigLoad:SetChecked(PIGA["Other"]["PigLoad"]);
    self.TopF.AFK:SetChecked(PIGA["Other"]["AFK"]["Open"]);
    self.TopF.AFK.QKBut:SetChecked(PIGA["Other"]["AFK"]["QuickBut"]);
    self.TopF.AFK.TispTXT:SetText(CommonInfo.Commonfun.GetAFKTispTXT())
end);