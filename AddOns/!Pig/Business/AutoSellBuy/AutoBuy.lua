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
function BusinessInfo.AutoBuy()
	local fujiF,fujiTabBut=PIGOptionsList_R(AutoSellBuy_UI.F,"购",50,"Left")
	local gongnengName = "Buy"
	BusinessInfo.ADDScroll(fujiF,"购买",gongnengName,17,{true,"AutoSellBuy",gongnengName.."_List"})
	-----------
	local function GetBagItemCount(QitemID)
		local zongjiBAGitemCount=0
		for bag = 0, bagIDMax do
			for slot = 1, GetContainerNumSlots(bag) do
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
	local function ExecuteBuyFun(qiangou,index,shijigoumai,maxnum,BuyItemMax,price,link,allcost)
		if shijigoumai>BuyItemMax then
			BuyMerchantItem(index,BuyItemMax)
			allcost=allcost+price*BuyItemMax
			shijigoumai=shijigoumai-BuyItemMax
		else
			BuyMerchantItem(index, shijigoumai)
			allcost=allcost+price*shijigoumai
			shijigoumai=0
		end
		if shijigoumai>0 then
			ExecuteBuyFun(qiangou,index,shijigoumai,maxnum,BuyItemMax,price,link,allcost)
		else
			if PIGA["AutoSellBuy"][gongnengName.."_Tishi"] then
				if qiangou then
					PIG_print("|cFF00ff00商家物品限购:|r "..BuyItemName.." |cFF00ff00抢购数量:|r"..maxnum);
				else
					PIG_print("|cFF00ff00执行自动补货:|r "..link.." |cFF00ff00补货数量:|r"..maxnum);
				end
				PIG_print("|cFF00ff00本次补货花费:|r "..GetMoneyString(allcost));
			end
		end
	end
	local function StartBuyItem()
		if not MerchantFrame:IsVisible() or MerchantFrame.selectedTab ~= 1 then return end
		local Buydata = PIGA_Per["AutoSellBuy"][gongnengName.."_List"]
		if #Buydata==0 then return end
		local numItems = GetMerchantNumItems();
		if numItems==0 then return end
		local BuyAllData={cost=0,maxnum=0,yushenum=0}
		for i=1,#Buydata do
			local BuyItemID=Buydata[i][1]--ID
			BuyAllData.yushenum=Buydata[i][4]-GetBagItemCount(BuyItemID);--需要补货数量
			if BuyAllData.yushenum==0 then return end
			local BuyItemName=Buydata[i][2]--品名
			local BuyItemMax=Buydata[i][5]--品名
			for ii=1,numItems do
				if BuyItemID==GetMerchantItemID(ii) then
					local link = GetMerchantItemLink(ii)
					local name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost= GetMerchantItemInfo(ii)
					if numAvailable==(-1) then
						BuyAllData.maxnum=BuyAllData.yushenum
					else
						if BuyAllData.yushenum>numAvailable then
							BuyAllData.maxnum=numAvailable
						else
							BuyAllData.maxnum=BuyAllData.yushenum
						end
					end
					ExecuteBuyFun(BuyAllData.yushenum>BuyAllData.maxnum,ii,BuyAllData.maxnum,BuyAllData.maxnum,BuyItemMax,price/quantity,link,BuyAllData.cost)
				end
			end	
		end
	end
	MerchantFrame:HookScript("OnShow",function (self)
		if PIGA["AutoSellBuy"][gongnengName.."_Open"] then
			StartBuyItem()
		end
	end);
	fujiF.Buy_Open = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-10},{"自动购买|cff00FFFF(角色)|r", "打开商人界面自动购买下方列表物品|cff00FFFF(设置为单个角色独享)|r"})
	fujiF.Buy_Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][gongnengName.."_Open"]=true;
		else
			PIGA["AutoSellBuy"][gongnengName.."_Open"]=false;
		end
	end);
	--
	local function Add_MerchantBut()
		if PIGA["AutoSellBuy"][gongnengName.."_But"] and not MerchantFrame.Buy then 
			MerchantFrame.Buy = PIGButton(MerchantFrame,{"TOPLEFT",MerchantFrame,"TOPLEFT",120,-30},{50,24},"购买",nil,nil,nil,nil,0)
			PIGEnter(MerchantFrame.Buy,KEY_BUTTON1.."-购买预设物资\n"..KEY_BUTTON2.."-设置购买清单")
			MerchantFrame.Buy:SetScript("OnClick", function (self,button)
				if button=="LeftButton" then
					StartBuyItem()
				else
					AutoSellBuy_UI:Show()
					Show_TabBut_R(AutoSellBuy_UI.F,fujiF,fujiTabBut)
				end
			end)
			hooksecurefunc("PanelTemplates_SetTab", function(frame, id)
				if id==1 then
					MerchantFrame.Buy:Show()
				else
					MerchantFrame.Buy:Hide()
				end
			end)
		end
		if MerchantFrame.Buy then
			MerchantFrame.Buy:SetShown(PIGA["AutoSellBuy"][gongnengName.."_But"])
		end
	end
	Add_MerchantBut()
	fujiF.Buy_But = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-44},{"购买按钮", "在商人界面增加一个购买按钮(可以点击购买下方列表内的物品)"})
	fujiF.Buy_But:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][gongnengName.."_But"]=true;	
		else
			PIGA["AutoSellBuy"][gongnengName.."_But"]=false;
		end
		Add_MerchantBut();	
	end);
	fujiF.Buy_Tishi = PIGCheckbutton(fujiF,{"LEFT",fujiF.Buy_But,"RIGHT",110,0},{"购买记录", "在聊天栏显示购买记录"})
	fujiF.Buy_Tishi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][gongnengName.."_Tishi"]=true;
		else
			PIGA["AutoSellBuy"][gongnengName.."_Tishi"]=false;
		end
	end);
	---	
	fujiF:HookScript("OnShow", function (self)
		self.Buy_Open:SetChecked(PIGA["AutoSellBuy"][gongnengName.."_Open"])
		self.Buy_But:SetChecked(PIGA["AutoSellBuy"][gongnengName.."_But"]);
		self.Buy_Tishi:SetChecked(PIGA["AutoSellBuy"][gongnengName.."_Tishi"])
	end);
end