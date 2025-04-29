local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local L=addonTable.locale
local Create=addonTable.Create
local PIGButton = Create.PIGButton
local PIGEnter=Create.PIGEnter
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList_R=Create.PIGOptionsList_R
local Show_TabBut_R=Create.Show_TabBut_R
--
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemID=GetContainerItemID or C_Container and C_Container.GetContainerItemID
local GetContainerItemLink = C_Container.GetContainerItemLink
local PickupContainerItem =C_Container.PickupContainerItem
local UseContainerItem =C_Container.UseContainerItem
local bagIDMax= addonTable.Data.bagData["bagIDMax"]
--
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.AutoSell()
	local fujiF,fujiTabBut=PIGOptionsList_R(AutoSellBuy_UI.F,"卖",50,"Left")
	local gongnengName = "Sell"
	BusinessInfo.ADDScroll(fujiF,"出售",gongnengName,17,{false,"AutoSellBuy",gongnengName.."_List"})
	local function IsFiltraLsit(data,id)
		for i=1,#data do
			if data[i][1]==id then
				return true
			end
		end
		return false
	end
	local function ExecuteSellFun(data,numall)
		for i=1,#data do
			UseContainerItem(data[i][1], data[i][2]);
		end
		C_Timer.After(1,function()
			for i=1,#data do
				if not GetContainerItemID(data[i][1], data[i][2]) and data[i][5]==false then
					numall=numall-1
					data[i][5]=true
				end
			end
			if numall>0 then
				ExecuteSellFun(data,numall)
			else
				local sellALLG = 0
				for i=1,#data do
					sellALLG=sellALLG+data[i][4]
					PIG_print("|cFF7FFFAA出售|r: "..data[i][3])
				end
				PIG_print("|cFF7FFFAA本次售卖"..#data.."件获得:|r " .. GetCoinTextureString(sellALLG));
			end
		end)
	end
	local function StartSellItem()
		if not MerchantFrame:IsVisible() or MerchantFrame.selectedTab ~= 1 then return end
		local bagSellD = {}
		local Selldata = PIGA["AutoSellBuy"][gongnengName.."_List"]
		local FiltradataX = PIGA["AutoSellBuy"][gongnengName.."_Lsit_Filtra"]
		for bag = 0, bagIDMax do
			for slot = 1, GetContainerNumSlots(bag) do
				local itemID, itemLink, icon, itemCount, quality, noValue = PIGGetContainerItemInfo(bag, slot)
				if itemID then
					if noValue==false then
						if quality==0 then
							if not IsFiltraLsit(FiltradataX,itemID) then
								local sellPrice= select(11, GetItemInfo(itemID))
								table.insert(bagSellD,{bag, slot,itemLink,sellPrice*itemCount,false})
							end
						end
						--非灰
						for i=1,#Selldata do
							if itemID==Selldata[i][1] then
								local sellPrice= select(11, GetItemInfo(itemID))
								table.insert(bagSellD,{bag, slot,itemLink,sellPrice*itemCount,false})
							end
						end
					end
				end
			end
		end
		ExecuteSellFun(bagSellD,#bagSellD)
	end
	MerchantFrame:HookScript("OnShow",function (self,event)
		if PIGA["AutoSellBuy"][gongnengName.."_Open"] then
			StartSellItem()
		end
	end);
	fujiF.Sell_Open = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-10},{"自动出售", "打开商人界面自动售卖灰色物品和下方列表内的物品"})
	fujiF.Sell_Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][gongnengName.."_Open"]=true;
		else
			PIGA["AutoSellBuy"][gongnengName.."_Open"]=false;
		end
	end);
	---
	local function  Add_MerchantBut()
		if PIGA["AutoSellBuy"][gongnengName.."_But"] and not MerchantFrame.Sell then 
			MerchantFrame.Sell = PIGButton(MerchantFrame,{"TOPLEFT",MerchantFrame,"TOPLEFT",56,-30},{50,24},"出售",nil,nil,nil,nil,0);
			PIGEnter(MerchantFrame.Sell,KEY_BUTTON1.."-卖垃圾和预设出售物品\n"..KEY_BUTTON2.."-设置出售清单")  
			MerchantFrame.Sell:SetScript("OnClick", function (self,button)
				if button=="LeftButton" then
					StartSellItem()
				else
					AutoSellBuy_UI:Show()
					Show_TabBut_R(AutoSellBuy_UI.F,fujiF,fujiTabBut)
				end
			end)
			hooksecurefunc("PanelTemplates_SetTab", function(frame, id)
				if id==1 then
					MerchantFrame.Sell:Show()
				else
					MerchantFrame.Sell:Hide()
				end
			end)
		end
		if MerchantFrame.Sell then
			MerchantFrame.Sell:SetShown(PIGA["AutoSellBuy"][gongnengName.."_But"])
		end
	end
	Add_MerchantBut()
	fujiF.Sell_But = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-44},{"出售按钮", "在商人界面增加一个出售按钮(可以点击出售灰色物品和下方列表内的物品)"})
	fujiF.Sell_But:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][gongnengName.."_But"]=true;	
		else
			PIGA["AutoSellBuy"][gongnengName.."_But"]=false;
		end
		 Add_MerchantBut();	
	end);
	fujiF.Sell_Tishi = PIGCheckbutton(fujiF,{"LEFT",fujiF.Sell_But,"RIGHT",110,0},{"出售记录", "在聊天栏显示出售记录"})
	fujiF.Sell_Tishi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][gongnengName.."_Tishi"]=true;
		else
			PIGA["AutoSellBuy"][gongnengName.."_Tishi"]=false;
		end
	end);
	--
	fujiF:HookScript("OnShow", function (self)
		self.Sell_Open:SetChecked(PIGA["AutoSellBuy"][gongnengName.."_Open"])
		self.Sell_Tishi:SetChecked(PIGA["AutoSellBuy"][gongnengName.."_Tishi"])
		self.Sell_But:SetChecked(PIGA["AutoSellBuy"][gongnengName.."_But"]);
	end);
end