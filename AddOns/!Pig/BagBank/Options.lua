local addonName, PD = ...;
local L=PD.locale
---
local Fun = PD.Fun
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGLine=Create.PIGLine
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGFontString=Create.PIGFontString
---
local BagBankfun={}
BagBankfun.BagUIName="PIG_CombinedBag"
BagBankfun.BAGmeihangshu=0
PD.BagBankfun=BagBankfun

local GetInsertItemsLeftToRight=GetInsertItemsLeftToRight or C_Container and C_Container.GetInsertItemsLeftToRight
local SetInsertItemsLeftToRight=SetInsertItemsLeftToRight or C_Container and C_Container.SetInsertItemsLeftToRight

--背包剩余-------------
local function gengxinbeibaoshengyugeshu()
	if MainMenuBarBackpackButton.freeSlots<10 then
		MainMenuBarBackpackButton.Count:SetTextColor(1, 0, 0, 1);
	else
		MainMenuBarBackpackButton.Count:SetTextColor(0, 1, 0, 1);
	end
end
local function BagKongyuFun()
	if PIGA["BagBank"]["BagKongyu"] then
		MainMenuBarBackpackButton.pigbagkongyu=true
		SetCVar("displayFreeBagSlots", "1")
		MainMenuBarBackpackButton.Count:Show()
		if not MainMenuBarBackpackButton.PigLayoutOpen then
			MainMenuBarBackpackButton.Count:SetFont(ChatFontNormal:GetFont(), 18,"OUTLINE")
		end
		gengxinbeibaoshengyugeshu()
	else
		SetCVar("displayFreeBagSlots", "0")
		MainMenuBarBackpackButton.Count:Hide()
	end
end
MainMenuBarBackpackButton:HookScript("OnEvent", function(self,event,arg1)
	if event == "BAG_UPDATE" then
		if self.pigbagkongyu then
			gengxinbeibaoshengyugeshu()
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		BagKongyuFun()
	end
end)
local GetSortBagsRightToLeft=GetSortBagsRightToLeft or C_Container and C_Container.GetSortBagsRightToLeft
function BagBankfun.GetSortBagsRightToLeft()
	if GetSortBagsRightToLeft then
		return GetSortBagsRightToLeft()
	else
		return PIGA["BagBank"]["SortBag_Config"]
	end
end
local function PIGGetSortBagsRightToLeft()
	return not BagBankfun.GetSortBagsRightToLeft()
end
local SetSortBagsRightToLeft=SetSortBagsRightToLeft or C_Container and C_Container.SetSortBagsRightToLeft
local function PIGSetSortBagsRightToLeft(enabled)
	if SetSortBagsRightToLeft then
		SetSortBagsRightToLeft(not enabled)
	else
		PIGA["BagBank"]["SortBag_Config"] = not enabled
	end
end
--
local BagaddList = {"Bagnon","Combuctor","Baganator"};
local function Other_bag()
	for i = 1, #BagaddList do
		local loadedOrLoading, loaded = PIGIsAddOnLoaded(BagaddList[i])
		if loaded then return true,BagaddList[i],"插件"..BagaddList[i] end
	end
	if Fun.IsNDui("Bags","Enable") then
		return true,"NDui","NDui背包功能"
	elseif Fun.IsElvUI() and Fun.IsElvUI("bags","enable") then 
		return true,"ElvUI","ElvUI背包功能"
	end
	return false
end
PD.BagBank = function()
	if not Other_bag() then
		if PIG_MaxTocversion(40000) then
			BagBankfun.BAGmeihangshu=BagBankfun.BAGmeihangshu+2
		else
			BagBankfun.BAGmeihangshu=BagBankfun.BAGmeihangshu+4
		end
		BagBankfun.Zhenghe()
	end
end
----
function PD.addOptions_BagBank()
	local BagBankF,BagBankFTabBut = PIGOptionsList(L["BAGBANK_TABNAME"],"TOP")
	function BagBankfun.SetingClick()
		Create.Show_TabBut(BagBankF,BagBankFTabBut)
	end
	BagBankF:SetScript("OnShow", function (self)
		if BagBankF.yijiazai then return end
		BagBankF.yijiazai=true
		if PIGA["BagBank"]["Zhenghe"] then
			local ErrorON,addname,errtxt=Other_bag()
			if ErrorON then
				BagBankF.error = PIGFontString(BagBankF,{"CENTER", BagBankF, "CENTER",0, 50},"检测到"..errtxt.."开启，已禁用"..addonName.."背包功能")
				BagBankF.error:SetTextColor(1, 0, 0, 1)
				BagBankF.czrl = PIGButton(BagBankF,{"TOP",BagBankF.error,"BOTTOM",0,-10},{280,24},"禁用"..errtxt.."，启用"..addonName.."背包功能")
				BagBankF.czrl.qitaName=addname
				BagBankF.czrl:SetScript("OnClick", function(self)
					if self.qitaName=="NDui" then
						Fun.SetNDui(false,"Bags","Enable")
					elseif self.qitaName=="ElvUI" then
						Fun.SetElvUI(false,"bags","enable")
					else
						C_AddOns.DisableAddOn(self.qitaName)
					end
					ReloadUI();
				end)
				return
			end
		end
		BagBankF.Zhenghe = PIGCheckbutton(BagBankF,{"TOPLEFT",BagBankF,"TOPLEFT",20,-20},{"启用背包/银行整合","整合背包/银行包裹到一个界面"})
		BagBankF.Zhenghe:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["BagBank"]["Zhenghe"]=true
				BagBankfun.Zhenghe(BagBankF,BagBankFTabBut)		
			else
				PIGA["BagBank"]["Zhenghe"]=false
				PIG_OptionsUI.RLUI:Show()
			end
			BagBankF.SetListF:SetShown(PIGA["BagBank"]["Zhenghe"])
		end);
		BagBankF.Zhenghe:SetChecked(PIGA["BagBank"]["Zhenghe"])

		BagBankF.SetListF = PIGFrame(BagBankF,{"TOPLEFT",BagBankF,"TOPLEFT",0,-50})
		BagBankF.SetListF:SetPoint("BOTTOMRIGHT",BagBankF,"BOTTOMRIGHT",0,0);
		BagBankF.SetListF:PIGSetBackdrop(0)
		BagBankF.SetListF:SetShown(PIGA["BagBank"]["Zhenghe"])
		BagBankF.SetListF.CZpeizhi = PIGButton(BagBankF.SetListF,{"BOTTOMRIGHT",BagBankF.SetListF,"TOPRIGHT",-20,10},{60,22},RESET);
		BagBankF.SetListF.CZpeizhi:SetScript("OnClick", function(self, button)
			StaticPopup_Show ("PIG_DEFAULT_BEIBAOZHENGHE");
		end)
		StaticPopupDialogs["PIG_DEFAULT_BEIBAOZHENGHE"] = {
			text = string.format(L["RELOADUI2"],"背包/银行整合"),
			button1 = YES,
			button2 = NO,
			OnAccept = function()
				PIGA["BagBank"]=CopyTable(PD.Default["BagBank"])
				ReloadUI()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		----
		local BAG_SetList = {
			{false,"BagKongyu",BagKongyuFun,"显示背包剩余空间"},
			{true, "EquipBind",nil, "装备绑定物品提示"},
			{true, "JunkShow", nil, "自动卖出物品提示","提示售卖助手设置的自动卖出物品"},
			{false,{SetInsertItemsLeftToRight,GetInsertItemsLeftToRight},nil,"战利品放入左边包"},
			{false,{PIGSetSortBagsRightToLeft,PIGGetSortBagsRightToLeft},nil,"反向整理"},
		}
		if PIG_MaxTocversion() then
			table.insert(BAG_SetList,{false,"NewItem",nil,"新物品提示"})
		end
		for i=1,#BAG_SetList do
			local BagBankSet = PIGCheckbutton(BagBankF.SetListF,{"TOPLEFT",BagBankF.SetListF,"TOPLEFT",20,-(i-1)*40-20},{BAG_SetList[i][4],BAG_SetList[i][5]})
			if type(BAG_SetList[i][2])=="string" then
				BagBankSet:SetChecked(PIGA["BagBank"][BAG_SetList[i][2]])
			else
				BagBankSet:SetChecked(BAG_SetList[i][2][2]())
			end
			BagBankSet:SetScript("OnClick", function (self)
				if type(BAG_SetList[i][2])=="string" then
					PIGA["BagBank"][BAG_SetList[i][2]]=self:GetChecked()
				else
					BAG_SetList[i][2][1](self:GetChecked())
				end
				if BAG_SetList[i][1] then
					if self:GetChecked() then
						PIGErrorMsg("重新打开背包生效")
					else
						PIG_OptionsUI.RLUI:Show()
					end
				end
			end)
		end

		--每行格数
		BagBankF.SetListF.hangNUM = PIGSlider(BagBankF.SetListF,{"TOPLEFT",BagBankF.SetListF,"TOPLEFT",20,-260},{8,16,1,{["Right"]="背包每行格数%d"}})	
		function BagBankF.SetListF.hangNUM:PIGOnValueChange(arg1)
			PIGA["BagBank"]["BAGmeihangshu"] = arg1-BagBankfun.BAGmeihangshu
			if PIG_MaxTocversion() then
				if _G[BagBankfun.BagUIName] then _G[BagBankfun.BagUIName].meihang=arg1 end
			else
				ContainerFrameCombinedBags.meihang=arg1
			end
			PIGErrorMsg("重新打开背包生效")
		end
		--缩放
		BagBankF.SetListF.suofang = PIGSlider(BagBankF.SetListF,{"TOPLEFT",BagBankF.SetListF.hangNUM,"BOTTOMLEFT",0,-20},{0.8,1.4,0.01,{["Right"]="背包缩放比例%d%%"}})	
		function BagBankF.SetListF.suofang:PIGOnValueChange(arg1)
			PIGA["BagBank"]["BAGsuofangBili"] = arg1;
			if PIG_MaxTocversion() then
				if _G[BagBankfun.BagUIName] then _G[BagBankfun.BagUIName].suofang=arg1 end
			else
				ContainerFrameCombinedBags.suofang=arg1
			end
			PIGErrorMsg("重新打开背包生效")
		end
		BagBankF.SetListF.suofang:PIGSetValue(PIGA["BagBank"]["BAGsuofangBili"])
		BagBankF.SetListF.hangNUM:PIGSetValue(PIGA["BagBank"]["BAGmeihangshu"]+BagBankfun.BAGmeihangshu)
	end)
end