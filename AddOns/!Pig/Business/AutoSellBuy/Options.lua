local _, PD = ...;
local BusinessInfo=PD.BusinessInfo
function BusinessInfo.AutoSellBuyOptions()
	local Fun=PD.Fun
	local L=PD.locale
	local Create=PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGButton = Create.PIGButton
	local PIGEnter=Create.PIGEnter
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local fuFrame,fuFrameBut = BusinessInfo.fuFrame,BusinessInfo.fuFrameBut
	local GnName,GnUI,GnIcon,FrameLevel,QuickButUI_index = unpack(BusinessInfo.uiData)
	----
	local Tab2_F,Tab2_But =PIGOptionsList_R(BusinessInfo.RTabFrame,GnName,90)
	Tab2_F.AutoSellBuy = PIGCheckbutton(Tab2_F,{"TOPLEFT",Tab2_F,"TOPLEFT",20,-20},{GnName,L["TRADESELLBUY_TISP"]})
	Tab2_F.AutoSellBuy:SetChecked(PIGA["AutoSellBuy"]["Open"])
	Tab2_F.AutoSellBuy:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"]["Open"]=true;
			BusinessInfo.add_AutoSellBuyUI()
		else
			PIGA["AutoSellBuy"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		Fun.QuickBut_Update()
	end);
	Tab2_F.SetF = PIGFrame(Tab2_F,{"TOPLEFT", Tab2_F, "TOPLEFT", 0, -50})
	Tab2_F.SetF:SetPoint("BOTTOMRIGHT", Tab2_F, "BOTTOMRIGHT", 0, 0);
	Tab2_F.SetF:PIGSetBackdrop(0)
	Tab2_F.SetF.CZ = PIGButton(Tab2_F.SetF,{"BOTTOMRIGHT",Tab2_F.SetF,"TOPRIGHT",-20,10},{60,22},RESET);  
	PIGEnter(Tab2_F.SetF.CZ,string.format(L["RELOADUI2"],GnName))
	Tab2_F.SetF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("PIG_AUTOSELLBUY_CZQIANGKONGINFO");
	end);
	StaticPopupDialogs["PIG_AUTOSELLBUY_CZQIANGKONGINFO"] = {
		text = string.format(L["RELOADUI2"],GnName),
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["AutoSellBuy"]=CopyTable(PD.Default["AutoSellBuy"])
			PIGA_Per["AutoSellBuy"]=CopyTable(PD.Default_Per["AutoSellBuy"])
			PIGA["AutoSellBuy"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
end