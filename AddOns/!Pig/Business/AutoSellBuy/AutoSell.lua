local _, addonTable = ...;
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.AutoSell()
	local L=addonTable.locale
	local Create=addonTable.Create
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	--
	local GetContainerNumSlots = C_Container.GetContainerNumSlots
	local GetContainerItemID=GetContainerItemID or C_Container and C_Container.GetContainerItemID
	local GetContainerItemLink = C_Container.GetContainerItemLink
	local PickupContainerItem =C_Container.PickupContainerItem
	local UseContainerItem =C_Container.UseContainerItem
	local bagIDMax= addonTable.Data.bagData["bagIDMax"]
	---
	local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.AutoSellBuyData)
	local _GN,_GNE = L["TRADESELLBUY_SELL2"],"Sell"
	local fujiF,fujiTabBut=PIGOptionsList_R(_G[GnUI].F,L["TRADESELLBUY_SELL1"],50,"Left")
	BusinessInfo.ADDScroll(fujiF,_GN,_GNE,17,{false,"AutoSellBuy",_GNE.."_List"})
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
		C_Timer.After(0.8,function()
			if not MerchantFrame:IsVisible() or MerchantFrame.selectedTab ~= 1 then return end
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
					PIGprint("|cFF7FFFAA".._GN.."|r: "..data[i][3])
				end
				if sellALLG>0 then
					PIGprint(string.format(L["TRADESELLBUY_SELL3"],_GN..#data).. GetCoinTextureString(sellALLG));
				end
				MerchantFrame.pigfuusell=nil
			end
		end)
	end
	local function StartSellItem()
		if not MerchantFrame:IsVisible() or MerchantFrame.selectedTab ~= 1 then return end
		local bagSellD = {}
		local Selldata = PIGA["AutoSellBuy"][_GNE.."_List"]
		local FiltradataX = PIGA["AutoSellBuy"][_GNE.."_Lsit_Filtra"]
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
	MerchantFrame:HookScript("OnShow",function (self)
		if PIGA["AutoSellBuy"][_GNE.."_Open"] then
			self.pigfuusell=true
			StartSellItem()
		end
	end);
	MerchantFrame:HookScript("OnHide",function (self)
		MerchantFrame.pigfuusell=nil
	end);
	fujiF.Sell_Open = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-10},{string.format(L["LIB_AUTO"],_GN), string.format(L["TRADESELLBUY_SELL4"],_GN)})
	fujiF.Sell_Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][_GNE.."_Open"]=true;
		else
			PIGA["AutoSellBuy"][_GNE.."_Open"]=false;
		end
	end);
	---
	fujiF.Sell_But = BusinessInfo.Add_MerchantBut(_GN,_GNE,StartSellItem,fujiF,fujiTabBut)
	fujiF.Sell_Tishi = PIGCheckbutton(fujiF,{"LEFT",fujiF.Sell_But,"RIGHT",110,0},{string.format(L["LIB_RECORD"],_GN),string.format(L["TRADESELLBUY_TISP1"],_GN)})
	fujiF.Sell_Tishi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][_GNE.."_Tishi"]=true;
		else
			PIGA["AutoSellBuy"][_GNE.."_Tishi"]=false;
		end
	end);
	--
	fujiF:HookScript("OnShow", function (self)
		self.Sell_Open:SetChecked(PIGA["AutoSellBuy"][_GNE.."_Open"])
		self.Sell_Tishi:SetChecked(PIGA["AutoSellBuy"][_GNE.."_Tishi"])
		self.Sell_But:SetChecked(PIGA["AutoSellBuy"][_GNE.."_But"]);
	end);
end