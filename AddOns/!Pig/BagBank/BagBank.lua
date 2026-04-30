local addonName, addonTable = ...;
local BagBankfun=addonTable.BagBankfun
--================
function BagBankfun.Zhenghe(Rneirong,tabbut)
	if not PIGA["BagBank"]["Zhenghe"] or BagBankfun.BagbankOK then return end
	BagBankfun.BagbankOK=true
	local L=addonTable.locale
	local Data=addonTable.Data
	local match = _G.string.match
	local Create=addonTable.Create
	local PIGFrame=Create.PIGFrame
	local PIGEnter=Create.PIGEnter
	local PIGFontString=Create.PIGFontString
	--====================================
	local InvSlot=Data.InvSlot
	local bagData=Data.bagData
	local wwc,hhc = 24,24
	local UpdateItemButtonZLVranse=BagBankfun.UpdateItemButtonZLVranse
	if GetCVar("combinedBags")=="0" then SetCVar("combinedBags","1") end
	hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", function()
		if not PIGA["BagBank"]["JunkShow"] then return end
		for i, itemButton in ContainerFrameCombinedBags:EnumerateValidItems() do
			local bagID = itemButton:GetBagID();
			local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(bagID, itemButton:GetID())
			itemButton.JunkIcon:Hide();
			if quality and quality==0 then
				itemButton.JunkIcon:Show();
			end
		end
	end)
	--调整系统整合背包搜索框
	hooksecurefunc(ContainerFrameCombinedBags, "SetSearchBoxPoint", function()
		BagItemSearchBox:SetWidth(160);
		BagItemSearchBox:SetPoint("TOPLEFT",ContainerFrameCombinedBags,"TOPLEFT",40,-37);
	end)
	ContainerFrameCombinedBags.EqBut =BagBankfun.addEquipmentbut(ContainerFrameCombinedBags,{"TOPRIGHT",ContainerFrameCombinedBags,"TOPRIGHT",-52,-37})
	ContainerFrameCombinedBags.Setings = BagBankfun.addSetbut(ContainerFrameCombinedBags,{"TOPRIGHT",ContainerFrameCombinedBags,"TOPRIGHT",-86,-38},Rneirong,tabbut)
	--
	ContainerFrameCombinedBags.meihang=PIGA["BagBank"]["BAGmeihangshu"]+BagBankfun.BAGmeihangshu
	ContainerFrameCombinedBags.suofang=PIGA["BagBank"]["BAGsuofangBili"]
	ContainerFrameCombinedBags:HookScript("OnEvent", function(self,event,arg1)
		if event=="BAG_UPDATE" then
			if self:IsVisible() then
				UpdateItemButtonZLVranse(nil, nil, arg1)
			end
		end
	end)
	--行数
	hooksecurefunc(ContainerFrameCombinedBags,"UpdateFrameSize", function(self)
		local columns = self.meihang;
		local templateInfo = C_XMLUtil.GetTemplateInfo(self.itemButtonPool:GetTemplate());
		local itemsWidth = (columns * templateInfo.width) + ((columns - 1) * 5);
		local width = itemsWidth + self:GetPaddingWidth();
		local rows = math.ceil(self:GetBagSize() / columns);
		local templateInfo = C_XMLUtil.GetTemplateInfo(self.itemButtonPool:GetTemplate());
		local itemsHeight = (rows * templateInfo.height) + ((rows - 1) * 5);
		local height = itemsHeight + self:GetPaddingHeight() + self:CalculateExtraHeight();
		self:SetSize(width, height);
	end)
	hooksecurefunc(ContainerFrameCombinedBags,"UpdateItemLayout", function(self)
		local AnchorD=AnchorUtil.CreateGridLayout(GridLayoutMixin.Direction.BottomRightToTopLeft, self.meihang, 5, 5);
		local itemsToLayout = {};
		for i, itemButton in self:EnumerateValidItems() do
			table.insert(itemsToLayout, itemButton);
		end
		AnchorUtil.GridLayout(itemsToLayout, self:GetInitialItemAnchor(), AnchorD);
	end)
	--缩放
	hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, size, id)
		ContainerFrameCombinedBags:SetScale(ContainerFrameCombinedBags.suofang)
		if frame==ContainerFrameCombinedBags then
			UpdateItemButtonZLVranse(nil, nil, -999)
		else
			UpdateItemButtonZLVranse(frame, size, id)
		end
	end)

	---银行=================
	BankPanel.AutoDepositFrame:ClearAllPoints();
	BankPanel.AutoDepositFrame:SetPoint("TOPLEFT",BankPanel,"TOPLEFT",60,-24);
	--重新布局TAB菜单
	BankPanel.MoneyFrame:ClearAllPoints();
	BankPanel.MoneyFrame:SetPoint("BOTTOMLEFT",BankPanel,"BOTTOMLEFT",8,4);
	BankItemSearchBox:SetPoint("TOPRIGHT",BankFrame,"TOPRIGHT",-56,-27);
	BankFrame.TabSystem:ClearAllPoints();
	BankFrame.TabSystem:SetPoint("BOTTOMRIGHT",BankFrame,"TOPRIGHT",-50,-2);
	local tabs=BankFrame.TabSystem.tabs
	local function Update_Tab1(tabID)
		for id=1,#tabs do
			tabs[id].Text:SetPoint("CENTER", tabs[id], "CENTER", 0, -4);
		end
		tabs[tabID].Text:SetPoint("CENTER", tabs[tabID], "CENTER", 0, 0);
	end
	for id=1,#tabs do
		local tab=tabs[id]
		tab.LeftActive:ClearAllPoints();
		tab.LeftActive:SetPoint("BOTTOMLEFT",tab,"BOTTOMLEFT",-6,-6);
		tab.LeftActive:SetAtlas("uiframe-activetab-right")
		tab.LeftActive:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab.MiddleActive:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab.RightActive:ClearAllPoints();
		tab.RightActive:SetPoint("BOTTOMRIGHT",tab,"BOTTOMRIGHT",0,-6);
		tab.RightActive:SetAtlas("uiframe-activetab-left")
		tab.RightActive:SetRotation(math.rad(180), {x=0.5, y=0.5})
		
		tab.Left:ClearAllPoints();
		tab.Left:SetPoint("BOTTOMLEFT",tab,"BOTTOMLEFT",-6,-3);
		tab.Left:SetAtlas("uiframe-tab-right")
		tab.Left:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab.Middle:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab.Right:ClearAllPoints();
		tab.Right:SetPoint("BOTTOMRIGHT",tab,"BOTTOMRIGHT",0,-3);
		tab.Right:SetAtlas("uiframe-tab-left")
		tab.Right:SetRotation(math.rad(180), {x=0.5, y=0.5})

		tab.LeftHighlight:SetAtlas("uiframe-tab-right")
		tab.LeftHighlight:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab.MiddleHighlight:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab.RightHighlight:SetAtlas("uiframe-tab-left")
		tab.RightHighlight:SetRotation(math.rad(180), {x=0.5, y=0.5})
		tab:HookScript("OnClick", function(self)
			Update_Tab1(id)
		end);
	end
	hooksecurefunc(BankFrame, "SelectDefaultTab", function(self)
		Update_Tab1(self.TabSystem.selectedTabID)
	end)
	--银行格子重新布局
	-- BankFrame:SetSize(BankFrame:GetWidth()+102,BankFrame:GetHeight()+170)
	-- BankPanel:SetSize(BankPanel:GetWidth()+102,BankPanel:GetHeight()+170)
	-- local leftV,xiayiV,itemsPerColumn,spacing=4,-52,14,39
	-- local tabdata={
	-- 	[1]={6,8},
	-- 	[2]={9,11},
	-- 	[3]={12,14},
	-- 	[4]={15,16},
	-- }
	-- local tabIDsold={
	-- 	[6]=1,[7]=1,[8]=1,
	-- 	[9]=2,[10]=2,[11]=2,
	-- 	[12]=3,[13]=3,[14]=3,
	-- 	[15]=4,[16]=4,
	-- }
	-- local function Update_ItemSlots(self,tabID)
	-- 	self.Header:ClearAllPoints()
	-- 	self.itemButtonPool:ReleaseAll();
	-- 	local XXXX=0
	-- 	for selectedID=tabdata[tabID][1],tabdata[tabID][2] do
	-- 		for containerSlotID=1,98 do
	-- 			local itemButton = self.itemButtonPool:Acquire();
	-- 			itemButton:Init(self.bankType, selectedID, containerSlotID);
	-- 			itemButton:ClearAllPoints();
	-- 			if containerSlotID == 1 then
	-- 				if selectedID==7 then
	-- 					XXXX=(7 * spacing)+8
	-- 				elseif selectedID==8 then
	-- 					XXXX=(14 * spacing)+16
	-- 				end
	-- 				itemButton:SetPoint("TOPLEFT",self,"TOPLEFT",leftV+XXXX,xiayiV);
	-- 			else
	-- 				local index = containerSlotID - 1
	-- 	            local colIndex = math.floor(index / itemsPerColumn)
	-- 	            local rowIndex = index % itemsPerColumn
	-- 	            itemButton:SetPoint("TOPLEFT", self, "TOPLEFT", leftV +XXXX + (colIndex * spacing), xiayiV - (rowIndex * spacing));
	-- 			end
	-- 			itemButton:Show();
	-- 		end
	-- 	end
	-- end
	-- hooksecurefunc(BankPanel, "GenerateItemSlotsForSelectedTab", function(self)
	-- 	Update_ItemSlots(self,tabIDsold[self.selectedTabID])
	-- 	UpdateItemButtonZLVranse("retailbank")
	-- end)
	-- BankPanel.bglist={}
	-- hooksecurefunc(BankPanelTabMixin, "OnEnter", function(self)
	-- 	if BankPanel.selectedTabID==-1 then return end
	-- 	if not BankPanel.bglist[self.tabData.ID] then
	-- 		BankPanel.bglist[self.tabData.ID] = PIGFrame(BankPanel)
	-- 		BankPanel.bglist[self.tabData.ID]:PIGSetBackdrop(0,1,nil,{0,1,1})
	-- 		BankPanel.bglist[self.tabData.ID]:SetWidth(276)
	-- 		BankPanel.bglist[self.tabData.ID]:SetFrameStrata("HIGH")
	-- 	end
	-- 	if self.tabData.ID>=tabdata[tabIDsold[BankPanel.selectedTabID]][1] and self.tabData.ID<=tabdata[tabIDsold[BankPanel.selectedTabID]][2] then
	-- 		local xxxxx=2+276
	-- 		if self.tabData.ID<9 then
	-- 			xxxxx=2+(self.tabData.ID-6)*280
	-- 		elseif self.tabData.ID<12 then
	-- 			xxxxx=2+(self.tabData.ID-9)*280
	-- 		elseif self.tabData.ID<15 then
	-- 			xxxxx=2+(self.tabData.ID-12)*280
	-- 		end
	-- 		BankPanel.bglist[self.tabData.ID]:SetPoint("TOPLEFT",BankPanel,"TOPLEFT",xxxxx,-50);
	-- 		BankPanel.bglist[self.tabData.ID]:SetPoint("BOTTOMLEFT",BankPanel,"BOTTOMLEFT",xxxxx,30);
	-- 		BankPanel.bglist[self.tabData.ID]:Show()
	-- 	end
	-- end);
	-- hooksecurefunc(BankPanelTabMixin, "OnLeave", function(self)
	-- 	if BankPanel.bglist[self.tabData.ID] then
	-- 		BankPanel.bglist[self.tabData.ID]:Hide()
	-- 	end
	-- end);
	-- BankPanel:HookScript("OnEvent", function (self,event,arg1)
	-- 	if event == "BAG_UPDATE" then
	-- 		--self:MarkDirty()
	-- 		UpdateItemButtonZLVranse("retailbank")
	-- 	end
	-- end)
	--处理2级tab
	-- local function Update_Tab2(self)
	-- 	self.bankTabPool:ReleaseAll();
	-- 	local lastBankTab;
	-- 	if self.purchasedBankTabData then
	-- 		for index, bankTabData in ipairs(self.purchasedBankTabData) do
	-- 			local newBankTab = self.bankTabPool:Acquire();
	-- 			newBankTab:ClearAllPoints();
	-- 			if lastBankTab == nil then
	-- 				newBankTab:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 80, -2);
	-- 			else
	-- 				newBankTab:SetPoint("LEFT", lastBankTab, "RIGHT", 0, 0);
	-- 			end
				
	-- 			newBankTab:Init(bankTabData);
	-- 			newBankTab:Show();
	-- 			newBankTab.Border:Hide()
	-- 			if BankPanel.selectedTabID==6 or BankPanel.selectedTabID==7 or BankPanel.selectedTabID==8 then
	-- 				if newBankTab.tabData.ID==6 or newBankTab.tabData.ID==7 or newBankTab.tabData.ID==8 then
	-- 					newBankTab.SelectedTexture:Show()
	-- 				end
	-- 			else
	-- 				if newBankTab.tabData.ID==9 or newBankTab.tabData.ID==10 or newBankTab.tabData.ID==11 then
	-- 					newBankTab.SelectedTexture:Show()
	-- 				end
	-- 			end
	-- 			lastBankTab = newBankTab;
	-- 		end
	-- 	end
	-- 	if self.PurchaseTab:IsShown() then
	-- 		self.PurchaseTab.Border:Hide()
	-- 		self.PurchaseTab:ClearAllPoints();
	-- 		if lastBankTab == nil then
	-- 			self.PurchaseTab:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 80, -2);
	-- 		else
	-- 			self.PurchaseTab:SetPoint("LEFT", lastBankTab, "RIGHT", 10, 0);
	-- 		end
	-- 	end
	-- end
	-- hooksecurefunc(BankPanel, "RefreshBankTabs", function(self)
	-- 	Update_Tab2(self)
	-- end)
	-- hooksecurefunc(BankPanelTabMixin, "OnClick", function(self)
	-- 	Update_Tab2(BankPanel)
	-- end);
end