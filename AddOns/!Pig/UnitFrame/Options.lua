local addonName, PD = ...;
local L=PD.locale
local Fun=PD.Fun
local IsNDui = Fun.IsNDui
local IsElvUI = Fun.IsElvUI
---
local Create=PD.Create
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
---
local UnitFramefun={}
PD.UnitFramefun=UnitFramefun
PD.UnitFrame = function()
	UnitFramefun.Zishen()
	UnitFramefun.Duiyou()
	UnitFramefun.Mubiao()
end
function PD.addOptions_UnitFrame()
	local fuFrame = PIGOptionsList(L["UNIT_TABNAME"],"TOP")
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	--
	local zishenF,zishentabbut =PIGOptionsList_R(RTabFrame,L["UNIT_TABNAME1"],90)
	zishenF:Show()
	zishentabbut:Selected(true)
	zishenF:SetScript("OnShow", function (self)
		if zishenF.HPFF then return end
		--------
		zishenF.HPFF=PIGCheckbutton_R(zishenF,{"额外血量框架","在自身头像右侧显示额外血量框架.\n额外血量框架可能会和目标头像框架重叠，开启此选项后可能会右移目标头像"})
		zishenF.HPFF:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["PlayerFrame"]["HPFF"]=true;
				UnitFramefun.Zishen()
			else
				PIGA["UnitFrame"]["PlayerFrame"]["HPFF"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		zishenF.HPFF:SetChecked(PIGA["UnitFrame"]["PlayerFrame"]["HPFF"])
	end);
	----------------------
	local duiyouF =PIGOptionsList_R(RTabFrame,L["UNIT_TABNAME2"],90)
	duiyouF:SetScript("OnShow", function (self)
		if duiyouF.Plus then return end
		duiyouF.Plus=PIGCheckbutton_R(duiyouF,{"职业图标/等级","在队友头像上显示职业图标/等级\r|cff00FFFF小提示：|r\r队友职业图标可以点击，"..KEY_BUTTON1.."观察/"..KEY_BUTTON2.."交易。"})
		duiyouF.Plus:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["PartyMemberFrame"]["Plus"]=true;
				UnitFramefun.Duiyou()
			else
				PIGA["UnitFrame"]["PartyMemberFrame"]["Plus"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		duiyouF.HPFF=PIGCheckbutton_R(duiyouF,{"额外血量框架","在队友头像上显示额外血量框架"})
		duiyouF.HPFF:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["PartyMemberFrame"]["HPFF"]=true;
				UnitFramefun.Duiyou()
			else
				PIGA["UnitFrame"]["PartyMemberFrame"]["HPFF"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		duiyouF.Buff=PIGCheckbutton_R(duiyouF,{"常驻显示BUFF","在队友头像上常驻显示队友BUFF"})
		duiyouF.Buff:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["PartyMemberFrame"]["Buff"]=true;
				UnitFramefun.Duiyou()
			else
				PIGA["UnitFrame"]["PartyMemberFrame"]["Buff"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		duiyouF.ToToT=PIGCheckbutton_R(duiyouF,{"显示队友目标","在队友头像上显示队友目标"})
		duiyouF.ToToT:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["PartyMemberFrame"]["ToToT"]=true;
				UnitFramefun.Duiyou()
			else
				PIGA["UnitFrame"]["PartyMemberFrame"]["ToToT"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		-- duiyouF.petbar=PIGCheckbutton_R(zishenF,{"显示队友宠物","显示队友宠物"})
		-- duiyouF.petbar:SetScript("OnClick", function (self)
		-- 	if self:GetChecked() then
		-- 		PIGA["UnitFrame"]["PartyMemberFrame"]["petbar"]=true;
		-- 		UnitFramefun.Zishen()
		-- 	else
		-- 		PIGA["UnitFrame"]["PartyMemberFrame"]["petbar"]=false;
		-- 		PIG_OptionsUI.RLUI:Show()
		-- 	end
		-- end);
		duiyouF.Plus:SetChecked(PIGA["UnitFrame"]["PartyMemberFrame"]["Plus"])
		duiyouF.HPFF:SetChecked(PIGA["UnitFrame"]["PartyMemberFrame"]["HPFF"])
		duiyouF.Buff:SetChecked(PIGA["UnitFrame"]["PartyMemberFrame"]["Buff"])
		duiyouF.ToToT:SetChecked(PIGA["UnitFrame"]["PartyMemberFrame"]["ToToT"])
	end);
	-------------------
	local mubiaoF =PIGOptionsList_R(RTabFrame,L["UNIT_TABNAME3"],90)
	mubiaoF:SetScript("OnShow", function (self)
		if mubiaoF.Plus then return end
		local mubiaoText = {"职业/种族"}
		if PIG_MaxTocversion() then
			mubiaoText[1]="血量百分比/"..mubiaoText[1]
			if PIG_MaxTocversion(30000) then
				mubiaoText[1]="血量值/"..mubiaoText[1]
			end
		end
		mubiaoText[2]="显示"..mubiaoText[1].."\r|cff00FFFF小提示：|r\r目标职业图标可以点击，"..KEY_BUTTON1.."观察/"..KEY_BUTTON2.."交易"
		mubiaoF.Plus=PIGCheckbutton_R(mubiaoF,mubiaoText)
		mubiaoF.Plus:SetChecked(PIGA["UnitFrame"]["TargetFrame"]["Plus"])
		mubiaoF.Plus:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["TargetFrame"]["Plus"]=true;
				UnitFramefun.Mubiao()
			else
				PIGA["UnitFrame"]["TargetFrame"]["Plus"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		mubiaoF.Chouhen=PIGCheckbutton_R(mubiaoF,{"仇恨高亮/仇恨目录","目标仇恨高亮/仇恨目录，微调仇恨百分比位置"})
		mubiaoF.Chouhen:SetChecked(PIGA["UnitFrame"]["TargetFrame"]["Chouhen"])
		mubiaoF.Chouhen:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["TargetFrame"]["Chouhen"]=true;
				UnitFramefun.Mubiao()
			else
				PIGA["UnitFrame"]["TargetFrame"]["Chouhen"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		mubiaoF.ToToToT=PIGCheckbutton_R(mubiaoF,{"显示目标的目标的目标","显示目标的目标的目标（注意：请先打开系统的目标的目标）"})
		mubiaoF.ToToToT:SetChecked(PIGA["UnitFrame"]["TargetFrame"]["ToToToT"])
		mubiaoF.ToToToT:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["TargetFrame"]["ToToToT"]=true;
				UnitFramefun.Mubiao()
			else
				PIGA["UnitFrame"]["TargetFrame"]["ToToToT"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		mubiaoF.Yisu=PIGCheckbutton_R(mubiaoF,{"显示移动速度","显示目标移动速度"})
		mubiaoF.Yisu:SetChecked(PIGA["UnitFrame"]["TargetFrame"]["Yisu"])
		mubiaoF.Yisu:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["UnitFrame"]["TargetFrame"]["Yisu"]=true;
				UnitFramefun.Mubiao()
			else
				PIGA["UnitFrame"]["TargetFrame"]["Yisu"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
	end);
end