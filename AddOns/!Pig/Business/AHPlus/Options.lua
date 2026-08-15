local addonName, PD = ...;
local BusinessInfo=PD.BusinessInfo
------------
function BusinessInfo.AHPlusOptions()
	local L=PD.locale
	local Create=PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGSlider=Create.PIGSlider
	local PIGEnter=Create.PIGEnter
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList=Create.PIGOptionsList
	local PIGFontString=Create.PIGFontString
	local PIGQuickBut=Create.PIGQuickBut
	local PIGOptionsList_R=Create.PIGOptionsList_R
	------
	BusinessInfo.AHPlusData={}
	local fuFrame,fuFrameBut = BusinessInfo.fuFrame,BusinessInfo.fuFrameBut

	local GnName= L["TRADEAH_TABNAME"]
	local Tab2_F,Tab2_But =PIGOptionsList_R(BusinessInfo.RTabFrame,GnName,90)
	Tab2_F:Show()
	Tab2_But:Selected(true)

	Tab2_F.AHPlus =PIGCheckbutton(Tab2_F,{"TOPLEFT", Tab2_F, "TOPLEFT", 20, -20},{GnName, L["TRADEAH_TISP"]})
	Tab2_F.AHPlus:SetChecked(PIGA["AHPlus"]["Open"])
	Tab2_F.AHPlus:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["Open"]=true;
			BusinessInfo.AHPlus_ADDUI()
		else
			PIGA["AHPlus"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		Tab2_F.SetF:UpdateChecked()
	end);

	Tab2_F.SetF = PIGFrame(Tab2_F,{"TOPLEFT", Tab2_F, "TOPLEFT", 0, -50})
	Tab2_F.SetF:SetPoint("BOTTOMRIGHT", Tab2_F, "BOTTOMRIGHT", 0, 0);
	Tab2_F.SetF:PIGSetBackdrop(0)

	Tab2_F.SetF.CZ = PIGButton(Tab2_F.SetF,{"BOTTOMRIGHT",Tab2_F.SetF,"TOPRIGHT",-20,10},{60,22},RESET);  
	PIGEnter(Tab2_F.SetF.CZ,string.format(L["RELOADUI2"],GnName))
	Tab2_F.SetF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("PIG_AH_CZQIANGKONGINFO");
	end);
	StaticPopupDialogs["PIG_AH_CZQIANGKONGINFO"] = {
		text = string.format(L["RELOADUI2"],GnName),
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["AHPlus"]=CopyTable(PD.Default["AHPlus"])
			PIGA["AHPlus"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--扫描间隔
	Tab2_F.SetF.ScanSlider = PIGSlider(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF,"TOPLEFT",20,-10},{1,10,1,{["Right"]=L["TRADEAH_SCANCD"]}})
	function Tab2_F.SetF.ScanSlider:PIGOnValueChange(arg1)
		PIGA["AHPlus"]["ScanTimeCD"]=arg1
	end
	----
	Tab2_F.SetF.AHtooltip =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.ScanSlider,"BOTTOMLEFT",0,-20},{L["TRADEAH_MOUSETISPG"]})
	Tab2_F.SetF.AHtooltip:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["AHtooltip"]=true;
		else
			PIGA["AHPlus"]["AHtooltip"]=false;
		end
	end);
	if PIG_MaxTocversion(50000) then
		Tab2_F.SetF.QuicAuc =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.AHtooltip,"BOTTOMLEFT",0,-20},{L["TRADEAH_MOUSERIGHT"]})
		Tab2_F.SetF.QuicAuc:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["QuicAuc"]=true;
				BusinessInfo.QuicAuc()
			else
				PIGA["AHPlus"]["QuicAuc"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		Tab2_F.SetF.AHUIoff =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.QuicAuc,"BOTTOMLEFT",0,-20},{L["TRADEAH_SKILLNOOFF"]})
		Tab2_F.SetF.AHUIoff:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["AHUIoff"]=true;
			else
				PIGA["AHPlus"]["AHUIoff"]=false;
			end
		end);
	end
	--------
	function Tab2_F.SetF:UpdateChecked()
		self:SetShown(PIGA["AHPlus"]["Open"])
		self.AHtooltip:SetChecked(PIGA["AHPlus"]["AHtooltip"])
		self.ScanSlider:PIGSetValue(PIGA["AHPlus"]["ScanTimeCD"])
		if self.AHUIoff then self.AHUIoff:SetChecked(PIGA["AHPlus"]["AHUIoff"]) end
		if self.QuicAuc then self.QuicAuc:SetChecked(PIGA["AHPlus"]["QuicAuc"]) end
	end
	Tab2_F.SetF:UpdateChecked()
end
