local addonName, addonTable = ...;
local BusinessInfo=addonTable.BusinessInfo
------------
function BusinessInfo.AHPlusOptions()
	local L=addonTable.locale
	local Create=addonTable.Create
	local PIGSlider=Create.PIGSlider
	local PIGEnter=Create.PIGEnter
	local PIGButton = Create.PIGButton
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGOptionsList=Create.PIGOptionsList
	local PIGFontString=Create.PIGFontString
	local PIGQuickBut=Create.PIGQuickBut
	local PIGOptionsList_R=Create.PIGOptionsList_R
	------
	BusinessInfo.AHPlusData={}
	local fuFrame,fuFrameBut = BusinessInfo.fuFrame,BusinessInfo.fuFrameBut
	local GetItemInfoInstant=GetItemInfoInstant or C_Item and C_Item.GetItemInfoInstant

	local GnName= L["TRADEAH_TABNAME"]
	local AHPlusF,AHPlustabbut =PIGOptionsList_R(BusinessInfo.RTabFrame,GnName,90)
	AHPlusF:Show()
	AHPlustabbut:Selected(true)
	AHPlusF.AHPlus =PIGCheckbutton_R(AHPlusF,{GnName, L["TRADEAH_TISP"]})
	AHPlusF.AHPlus:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["Open"]=true;
			BusinessInfo.AHPlus_ADDUI()
		else
			PIGA["AHPlus"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		AHPlusF:ShowChecked()
	end);
	AHPlusF.CZ = PIGButton(AHPlusF,{"TOPRIGHT",AHPlusF,"TOPRIGHT",-20,-20},{60,22},RESET);  
	AHPlusF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("PIG_AH_CZQIANGKONGINFO");
	end);
	PIGEnter(AHPlusF.CZ,string.format(L["OPTUI_RESETDEFAULTRL"],GnName))
	StaticPopupDialogs["PIG_AH_CZQIANGKONGINFO"] = {
		text = string.format(L["OPTUI_RESETDEFAULTRL"],GnName),
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["AHPlus"]=addonTable.Default["AHPlus"];
			PIGA["AHPlus"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--扫描间隔
	AHPlusF.ScanSlider = PIGSlider(AHPlusF,{"TOPLEFT",AHPlusF,"TOPLEFT",20,-40},{1,10,1,{["Right"]=L["TRADEAH_SCANCD"]}})
	function AHPlusF.ScanSlider:PIGOnValueChange(arg1)
		PIGA["AHPlus"]["ScanTimeCD"]=arg1
	end
	AHPlusF.ScanSlider.CZ = PIGButton(AHPlusF.ScanSlider,{"LEFT",AHPlusF.ScanSlider.RightText,"RIGHT",10,0},{60,22},RESET)
	AHPlusF.ScanSlider.CZ:HookScript("OnClick", function (self)
		PIGA["AHPlus"]["ScanTimeCD"]=addonTable.Default["AHPlus"]["ScanTimeCD"]
		AHPlusF.ScanSlider:PIGSetValue(PIGA["AHPlus"]["ScanTimeCD"])
	end);
	----
	AHPlusF.BagOpen =PIGCheckbutton_R(AHPlusF,{L["TRADEAH_OPENBAG"]},true)
	AHPlusF.BagOpen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["BagOpen"]=true;
		else
			PIGA["AHPlus"]["BagOpen"]=false;
		end
	end);
	AHPlusF.AHtooltip =PIGCheckbutton_R(AHPlusF,{L["TRADEAH_MOUSETISPG"]},true)
	AHPlusF.AHtooltip:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["AHtooltip"]=true;
		else
			PIGA["AHPlus"]["AHtooltip"]=false;
		end
	end);
	if PIG_MaxTocversion(60000) then
		AHPlusF.QuicAuc =PIGCheckbutton_R(AHPlusF,{L["TRADEAH_MOUSERIGHT"]},true)
		AHPlusF.QuicAuc:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["QuicAuc"]=true;
				BusinessInfo.QuicAuc()
			else
				PIGA["AHPlus"]["QuicAuc"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		AHPlusF.AHUIoff =PIGCheckbutton_R(AHPlusF,{L["TRADEAH_SKILLNOOFF"]},true)
		AHPlusF.AHUIoff:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["AHUIoff"]=true;
				BusinessInfo.AHUIoff()
			else
				PIGA["AHPlus"]["AHUIoff"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
	end
	--------
	function AHPlusF:ShowChecked()
		self.ScanSlider:SetEnabled(PIGA["AHPlus"]["Open"])
		self.AHtooltip:SetEnabled(PIGA["AHPlus"]["Open"])
		self.BagOpen:SetEnabled(PIGA["AHPlus"]["Open"])
		if self.AHUIoff then self.AHUIoff:SetEnabled(PIGA["AHPlus"]["Open"]) end
		if self.QuicAuc then self.QuicAuc:SetEnabled(PIGA["AHPlus"]["Open"]) end
	end
	AHPlusF:HookScript("OnShow", function (self)
		self.AHPlus:SetChecked(PIGA["AHPlus"]["Open"])
		self.BagOpen:SetChecked(PIGA["AHPlus"]["BagOpen"])
		self.AHtooltip:SetChecked(PIGA["AHPlus"]["AHtooltip"])
		self.ScanSlider:PIGSetValue(PIGA["AHPlus"]["ScanTimeCD"])
		if self.AHUIoff then self.AHUIoff:SetChecked(PIGA["AHPlus"]["AHUIoff"]) end
		if self.QuicAuc then self.QuicAuc:SetChecked(PIGA["AHPlus"]["QuicAuc"]) end
		AHPlusF:ShowChecked()
	end);
	BusinessInfo.AHPlus_ADDUI()
end
