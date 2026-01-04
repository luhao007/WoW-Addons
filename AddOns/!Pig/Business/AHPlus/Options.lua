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

	local GnName= "拍卖助手"
	local AHPlusF,AHPlustabbut =PIGOptionsList_R(BusinessInfo.RTabFrame,GnName,90)
	AHPlusF:Show()
	AHPlustabbut:Selected(true)

	local AHPlus_tooltip="在拍卖行界面增加一个缓存单价按钮，时光徽章界面显示历史价格";
	if PIG_MaxTocversion(40000) then
		AHPlus_tooltip="在拍卖行浏览列表显示一口价，和涨跌百分比。界面增加一个缓存单价按钮，时光徽章界面显示历史价格";
	end
	AHPlusF.AHPlus =PIGCheckbutton_R(AHPlusF,{GnName, AHPlus_tooltip})
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
	AHPlusF.CZ = PIGButton(AHPlusF,{"TOPRIGHT",AHPlusF,"TOPRIGHT",-20,-20},{60,22},"重置");  
	AHPlusF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("AH_CZQIANGKONGINFO");
	end);
	PIGEnter(AHPlusF.CZ,"|cffFF0000重置|r"..GnName.."所有配置")
	StaticPopupDialogs["AH_CZQIANGKONGINFO"] = {
		text = "此操作将\124cffff0000重置\124r"..GnName.."所有配置，需重载界面。\n确定重置?",
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
	local Scaninfo = {1,10,1,{["Right"]="扫描间隔%s"}}
	BusinessInfo.AHPlusData.ScanCD=PIGA["AHPlus"]["ScanTimeCD"]
	AHPlusF.ScanSlider = PIGSlider(AHPlusF,{"TOPLEFT",AHPlusF,"TOPLEFT",20,-40},Scaninfo)
	function AHPlusF.ScanSlider:PIGOnValueChange(arg1)
		PIGA["AHPlus"]["ScanTimeCD"]=arg1
		BusinessInfo.AHPlusData.ScanCD=arg1
	end

	----
	AHPlusF.BagOpen =PIGCheckbutton_R(AHPlusF,{"拍卖时打开背包"},true)
	AHPlusF.BagOpen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["BagOpen"]=true;
		else
			PIGA["AHPlus"]["BagOpen"]=false;
		end
	end);
	AHPlusF.AHtooltip =PIGCheckbutton_R(AHPlusF,{"鼠标提示拍卖价钱","在物品的鼠标提示上显示拍卖缓存价钱"},true)
	AHPlusF.AHtooltip:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["AHtooltip"]=true;
		else
			PIGA["AHPlus"]["AHtooltip"]=false;
		end
	end);
	if PIG_MaxTocversion(40000) then
		AHPlusF.QuicAuc =PIGCheckbutton_R(AHPlusF,{"鼠标右键快速拍卖","鼠标右键背包物品快速拍卖"},true)
		AHPlusF.QuicAuc:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["QuicAuc"]=true;
				BusinessInfo.QuicAuc()
			else
				PIGA["AHPlus"]["QuicAuc"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		AHPlusF.AHUIoff =PIGCheckbutton_R(AHPlusF,{"禁止专业面板关闭","拍卖界面打开时禁止系统的专业面板自动关闭功能"},true)
		AHPlusF.AHUIoff:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["AHUIoff"]=true;
				BusinessInfo.AHUIoff()
			else
				PIGA["AHPlus"]["AHUIoff"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		GameTooltip:HookScript("OnTooltipSetItem", function(self)
			local _, itemlink = self:GetItem()
			if itemlink then
				local itemID = GetItemInfoInstant(itemlink)
				BusinessInfo.SetTooltipOfflineG(itemID,self)
			end
		end)
		-- AtlasLootTooltip:HookScript("OnTooltipSetItem", function(self)
		-- 	local _, itemlink = self:GetItem()
		-- 	if itemlink then
		-- 		local itemID = GetItemInfoInstant(itemlink)
		-- 		BusinessInfo.SetTooltipOfflineG(itemID,self)
		-- 	end
		-- end)
		hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
			if link:find("^item:") then
				local itemID = GetItemInfoInstant(link) 
				BusinessInfo.SetTooltipOfflineG(itemID,ItemRefTooltip)
			end
		end)
	else
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
			BusinessInfo.SetTooltipOfflineG(data.id,tooltip)
		end)
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
