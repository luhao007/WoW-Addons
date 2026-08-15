local _, addonTable = ...;
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.AutoBuy()
	local L=addonTable.locale
	local Create=addonTable.Create
	local PIGButton = Create.PIGButton
	local PIGEnter=Create.PIGEnter
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local Show_TabBut_R=Create.Show_TabBut_R
	--
	local bagIDMax= addonTable.Data.bagData["bagIDMax"]
	---
	local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.uiData)
	local _GN,_GNE = L["TRADESELLBUY_BUY2"],"Buy"
	local fujiF,fujiTabBut=PIGOptionsList_R(_G[GnUI].F,L["TRADESELLBUY_BUY1"],50,"Left")
	BusinessInfo.ADDScroll(fujiF,_GN,_GNE,17,{true,"AutoSellBuy",_GNE.."_List"})
	-----------
	local function GetBagItemCount(QitemID)
		local zongjiBAGitemCount=0
		for bag = 0, bagIDMax do
			for slot = 1, PIGGetContainerNumSlots(bag) do
				local itemID, itemLink, icon, itemCount = PIGGetContainerItemInfo(bag, slot)
				if itemID then
					if QitemID==itemID then
						zongjiBAGitemCount=zongjiBAGitemCount+itemCount
					end
				end
			end
		end
		return zongjiBAGitemCount
	end
	local function ExecuteBuyFun(datax)
		if datax[8]>datax[4] then
			BuyMerchantItem(datax[2],datax[4])
			datax[8]=datax[8]-datax[4]
		else
			BuyMerchantItem(datax[2],datax[8])
			datax[8]=0
		end
		C_Timer.After(0.5,function()
			if datax[8]>0 then
				ExecuteBuyFun(datax)
			else
				if PIGA["AutoSellBuy"][_GNE.."_Tishi"] then
					PIGprint(string.format(L["TRADESELLBUY_BUY5"],datax[1] and L["TRADESELLBUY_BUY5-1"] or "",datax[7],datax[3],GetMoneyString(datax[6]*datax[3])))
				end
			end
		end)
	end
	local function StartBuyItem()
		if not MerchantFrame:IsVisible() or MerchantFrame.selectedTab ~= 1 then return end
		local Buydata = fujiF.GetConfigRef()
		if #Buydata==0 then return end
		local BuyAllData={cost=0,Data={}}
		for i=1,#Buydata do
			local BuyItemID=Buydata[i][1]--ID
			local SetMaxNum=Buydata[i][4]--设置库存数
			local duidieNum=Buydata[i][5]--堆叠数
			for ii=1,GetMerchantNumItems() do
				if BuyItemID==GetMerchantItemID(ii) then
					local oldbagNum=GetBagItemCount(BuyItemID);
					local buyNum=SetMaxNum-oldbagNum;--需要补货数量
					if buyNum>0 then
						local link = GetMerchantItemLink(ii)
						local name, texture, price, stackCount, numAvailable
						if PIG_MaxTocversion() then
							name, texture, price, stackCount, numAvailable = GetMerchantItemInfo(ii)
						else
							local infox= C_MerchantFrame.GetItemInfo(ii)
							name=infox.name
							price=infox.price
							stackCount=infox.stackCount
							numAvailable=infox.numAvailable
						end
						local itemcostG=price/stackCount
						if numAvailable==(-1) then
							table.insert(BuyAllData.Data,{false,ii,buyNum,duidieNum,BuyItemID,itemcostG,link,buyNum})
						else
							if buyNum>numAvailable then
								table.insert(BuyAllData.Data,{true,ii,numAvailable,duidieNum,BuyItemID,itemcostG,link,numAvailable})
							else
								table.insert(BuyAllData.Data,{false,ii,buyNum,duidieNum,BuyItemID,itemcostG,link,buyNum})
							end
						end
					end
				end
			end	
		end
		for i=1,#BuyAllData.Data do
			ExecuteBuyFun(BuyAllData.Data[i])
		end
	end
	local function StartBuyItem_After()
		if MerchantFrame.pigfuusell then
			C_Timer.After(0.1,StartBuyItem_After)
		else
			StartBuyItem()
		end
	end
	MerchantFrame:HookScript("OnShow",function (self)
		if PIGA["AutoSellBuy"][_GNE.."_Open"] then
			StartBuyItem_After()
		end
	end);
	fujiF.Buy_Open = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-10},{string.format(L["LIB_AUTO"],_GN), string.format(L["TRADESELLBUY_BUY3"],_GN)})
	fujiF.Buy_Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][_GNE.."_Open"]=true;
		else
			PIGA["AutoSellBuy"][_GNE.."_Open"]=false;
		end
	end);
	fujiF.Buy_Open.Class = PIGCheckbutton(fujiF,{"LEFT",fujiF.Buy_Open,"RIGHT",110,0},{L["TRADESELLBUY_BUY4"],L["TRADESELLBUY_BUY4-1"]})
	fujiF.Buy_Open.Class:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][_GNE.."_Class"]=true;
		else
			PIGA["AutoSellBuy"][_GNE.."_Class"]=false;
		end
		fujiF:Hide();fujiF:Show()
	end);
	--
	fujiF.Buy_But = BusinessInfo.Add_MerchantBut(_GN,_GNE,StartBuyItem,fujiF,fujiTabBut)
	
	fujiF.Buy_Tishi = PIGCheckbutton(fujiF,{"LEFT",fujiF.Buy_But,"RIGHT",110,0},{string.format(L["LIB_RECORD"],_GN),string.format(L["TRADESELLBUY_TISP1"],_GN)})
	fujiF.Buy_Tishi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][_GNE.."_Tishi"]=true;
		else
			PIGA["AutoSellBuy"][_GNE.."_Tishi"]=false;
		end
	end);
	---	
	fujiF:HookScript("OnShow", function (self)
		self.Buy_Open:SetChecked(PIGA["AutoSellBuy"][_GNE.."_Open"])
		self.Buy_Open.Class:SetChecked(PIGA["AutoSellBuy"][_GNE.."_Class"])
		self.Buy_But:SetChecked(PIGA["AutoSellBuy"][_GNE.."_But"]);
		self.Buy_Tishi:SetChecked(PIGA["AutoSellBuy"][_GNE.."_Tishi"])
	end);
end