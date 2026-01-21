local addonName, addonTable = ...;
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGFontString=Create.PIGFontString
---
local gsub = _G.string.gsub
local match = _G.string.match
local BusinessInfo=addonTable.BusinessInfo
local IsAddOnLoaded=IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
----------------------------------
function BusinessInfo.AHPlus_Mainline()
	if not PIGA["AHPlus"]["Open"] or AuctionHouseFrame.History then return end
	local AuctionHouseTooltipType = {
		BucketPetLink = 1,
		ItemLink = 2,
		ItemKey = 3,
		SpecificPetLink = 4,
	};
	local function GetAuctionHouseTooltipType(rowData)
		if rowData.itemLink then
			local linkType = LinkUtil.ExtractLink(rowData.itemLink);
			if linkType == "battlepet" then
				return AuctionHouseTooltipType.SpecificPetLink, rowData.itemLink;
			elseif linkType == "item" then
				return AuctionHouseTooltipType.ItemLink, rowData.itemLink;
			end
		elseif rowData.itemKey then
			local restrictQualityToFilter = true;
			local itemKeyInfo = C_AuctionHouse.GetItemKeyInfo(rowData.itemKey, restrictQualityToFilter);
			if itemKeyInfo and itemKeyInfo.battlePetLink then
				return AuctionHouseTooltipType.BucketPetLink, itemKeyInfo.battlePetLink;
			end
			return AuctionHouseTooltipType.ItemKey, rowData.itemKey;
		end
		return nil;
	end
	local function Show_hangdata(hangui)
		local itemKey = hangui.rowData.itemKey
		local itemKeyInfo = C_AuctionHouse.GetItemKeyInfo(itemKey);
		if itemKeyInfo then
			local minPrice = hangui.rowData and hangui.rowData.minPrice
			if minPrice and minPrice>0 then
				local newName=nil
				local name = hangui.cells[2].Text:GetText()
				if name then
					local _xxitemLink
					if PIG_MaxTocversion(60000) then
						local rowData=hangui:GetRowData()
						local tooltipType, data = GetAuctionHouseTooltipType(rowData);
						if not tooltipType then return end
						PIG_TooltipUI:ClearLines();
						if tooltipType == AuctionHouseTooltipType.BucketPetLink or tooltipType == AuctionHouseTooltipType.SpecificPetLink then
							BattlePetToolTip_ShowLink(data);
						else
							if tooltipType == AuctionHouseTooltipType.ItemLink then
								local hideVendorPrice = true;
								PIG_TooltipUI:SetHyperlink(rowData.itemLink, nil, nil, hideVendorPrice);
							elseif tooltipType == AuctionHouseTooltipType.ItemKey then
								PIG_TooltipUI:SetItemKey(data.itemID, data.itemLevel, data.itemSuffix, C_AuctionHouse.GetItemKeyRequiredLevel(data));
							end
						end
						local _, link = PIG_TooltipUI:GetItem()
						_xxitemLink = link
					else
						local data = C_TooltipInfo.GetItemKey(itemKey.itemID, itemKey.itemLevel, itemKey.itemSuffix,itemKey.battlePetSpeciesID)
						_xxitemLink=data.hyperlink
					end
					if not _xxitemLink then return end
					if name:match("（") then
						newName = name:match("|cff%w%w%w%w%w%w(.-)（%w+）|r")
					else
						newName = name:match("|cff%w%w%w%w%w%w(.-)|r")
					end
					hangui.cells[2].updown.Text:SetTextColor(0.5, 0.5, 0.5, 0.5);
					hangui.cells[2].updown.Text:SetText("--");
					local NewData=BusinessInfo.GetCacheDataG(newName)
					if NewData then
						local NewDataNum = #NewData
						local OldGGGV_1 = NewData[NewDataNum]
						if OldGGGV_1 then
							local baifenbi = (minPrice/OldGGGV_1[1])*100+0.5
							local baifenbi = floor(baifenbi)
							hangui.cells[2].updown.Text:SetText(baifenbi.."%");
							hangui.cells[2].updown.newName=newName
							if baifenbi<100 then
								hangui.cells[2].updown.Text:SetTextColor(0, 1, 0, 1);
							elseif baifenbi>100 then
								hangui.cells[2].updown.Text:SetTextColor(1, 0, 0, 1);
							else
								hangui.cells[2].updown.Text:SetTextColor(1, 1, 1, 1);
							end
							if minPrice~=OldGGGV_1[1] and GetServerTime()-OldGGGV_1[2]>300 then
								BusinessInfo.ADD_Newdata(newName,minPrice,_xxitemLink,itemKey.itemID)
							end
						end
					else				
						BusinessInfo.ADD_Newdata(newName,minPrice,_xxitemLink,itemKey.itemID)
					end
				end
			end
		else
			C_Timer.After(0.1,function()
				Show_hangdata(hangui)
			end)
		end
	end
	hooksecurefunc(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "OnViewInitializedFrame", function(frame, elementData)
		local Mfuji = elementData
		if Mfuji.cells[2] then
			Mfuji.cells[2]:SetPoint("TOPLEFT",Mfuji.cells[1],"TOPRIGHT",48,0);
			Mfuji.cells[2]:SetPoint("BOTTOMLEFT",Mfuji.cells[1],"BOTTOMRIGHT",48,0);
			if not Mfuji.cells[2].updown then
				Mfuji.cells[2].updown = CreateFrame("Frame", nil, Mfuji.cells[2]);
				Mfuji.cells[2].updown:SetSize(44,18);
				Mfuji.cells[2].updown:SetPoint("RIGHT",Mfuji.cells[2],"LEFT",-2,0);
				Mfuji.cells[2].updown.Text = PIGFontString(Mfuji.cells[2].updown,{"RIGHT",Mfuji.cells[2].updown,"RIGHT",0,0})
				Mfuji.cells[2].updown.Text:SetPoint("LEFT",Mfuji.cells[2].updown,"LEFT",0,0);
				Mfuji.cells[2].updown.Text:SetJustifyH("RIGHT");
				Mfuji.cells[2].updown:HookScript("OnEnter", function(self)
					local fuhang = self:GetParent():GetParent()
					fuhang.HighlightTexture:Show();
					if self.newName then
						local NewData=BusinessInfo.GetCacheDataG(self.newName)
						if NewData then
							AuctionHouseFrame.BrowseResultsFrame.qushiUI:Show()
							AuctionHouseFrame.BrowseResultsFrame.qushiUI:SetPoint("TOPRIGHT",self,"TOPLEFT",18,1);
							local Name = fuhang.cells[2].Text:GetText()
							AuctionHouseFrame.BrowseResultsFrame.qushiUI.qushiF.UpdateList(NewData,Name)
						end
					end
				end);
				Mfuji.cells[2].updown:HookScript("OnLeave", function(self)
					local fuhang = self:GetParent():GetParent()
					fuhang.HighlightTexture:Hide();
					AuctionHouseFrame.BrowseResultsFrame.qushiUI:Hide()
				end);
			end
		end
		Show_hangdata(Mfuji)
	end)

	local EextData={
		["ElvUI"]={true,{0,0,0,0}},
		["NDui"]={NDuiopen,{0,0,0,0}},
	}
	AuctionHouseFrame.BrowseResultsFrame.qushiUI=PIGFrame(AuctionHouseFrame.BrowseResultsFrame,nil,nil,nil,nil,nil,EextData)
	AuctionHouseFrame.BrowseResultsFrame.qushiUI:SetSize(328,204);
	AuctionHouseFrame.BrowseResultsFrame.qushiUI:PIGSetBackdrop(1)
	AuctionHouseFrame.BrowseResultsFrame.qushiUI:SetFrameStrata("HIGH")
	AuctionHouseFrame.BrowseResultsFrame.qushiUI.qushiF=BusinessInfo.ADD_qushi(AuctionHouseFrame.BrowseResultsFrame.qushiUI,true)
	AuctionHouseFrame.BrowseResultsFrame.qushiUI.qushiF:SetPoint("TOPLEFT", AuctionHouseFrame.BrowseResultsFrame.qushiUI, "TOPLEFT",4, -24);
	AuctionHouseFrame.BrowseResultsFrame.qushiUI.qushiF:SetPoint("BOTTOMRIGHT", AuctionHouseFrame.BrowseResultsFrame.qushiUI, "BOTTOMRIGHT",-4, 4);
	AuctionHouseFrame.BrowseResultsFrame.qushitishi=BusinessInfo.ADD_qushiTips(AuctionHouseFrame.BrowseResultsFrame,{"TOPLEFT",AuctionHouseFrame.BrowseResultsFrame,"TOPLEFT",220,-3})
	AuctionHouseFrame.BrowseResultsFrame.qushitishi:SetFrameLevel(510)

	---缓存----------
	local UpdateF = CreateFrame("Frame")
	UpdateF.meiyenum = 29
	UpdateF.auctionsG = {}
	UpdateF.auctionsLin = {}
	UpdateF.RetryCount={}
	UpdateF.ItemIndexList = {}

	AuctionHouseFrame.History = PIGButton(AuctionHouseFrame,{"TOPRIGHT",AuctionHouseFrame,"TOPRIGHT",-100,-1},{110,19},"缓存价格",nil,nil,nil,nil,0);
	AuctionHouseFrame.History:SetFrameLevel(510)
	AuctionHouseFrame.History.timel=0
	AuctionHouseFrame.History:HookScript("OnUpdate", function(self,elapsed)
		self.timel=self.timel+elapsed
		if self.timel>1 then
			self.timel=0
			self:UpdateBUT()
		end
	end)
	AuctionHouseFrame.History:HookScript("OnShow", function(self,elapsed)
		self:UpdateBUT()
	end)
	function AuctionHouseFrame.History:UpdateBUT()
		local daojishitt = 900-(GetServerTime()-PIGA["AHPlus"]["DaojiTime"])
		if daojishitt<0 then
			self:Enable()
			self:SetText("缓存价格");
		else
			self:Disable()
			self:SetText("缓存价格("..daojishitt..")");
		end
	end
	AuctionHouseFrame.History:HookScript("OnClick", function(self, button)
		UpdateF:StartScan()
	end)

	AuctionHouseFrame.huancunUI = CreateFrame("Frame", nil, AuctionHouseFrame,"BackdropTemplate");
	local jinduW,jinduH,HCUI = 300,20,AuctionHouseFrame.huancunUI
	HCUI:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp",edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13,});
	HCUI:SetBackdropBorderColor(0, 1, 1, 0.9);
	HCUI:SetPoint("TOPLEFT",AuctionHouseFrame,"TOPLEFT",4,-22);
	HCUI:SetPoint("BOTTOMRIGHT",AuctionHouseFrame,"BOTTOMRIGHT",-4,28);
	HCUI:SetFrameLevel(520)
	HCUI:Hide();
	HCUI.close = PIGButton(HCUI,{"CENTER",HCUI,"CENTER",0,-40},{90,30},"关闭",nil,nil,nil,nil,0);
	HCUI.close:Hide();
	HCUI.close:HookScript("OnClick",function(self) HCUI:Hide() end)
	HCUI.jindu = CreateFrame("StatusBar", nil, HCUI);
	HCUI.jindu:SetStatusBarTexture("interface/raidframe/raid-bar-hp-fill.blp")
	HCUI.jindu:SetStatusBarColor(0, 1, 0 ,1);
	HCUI.jindu:SetSize(jinduW,jinduH);
	HCUI.jindu:SetPoint("CENTER",HCUI,"CENTER",0,40);
	HCUI.jindu:SetMinMaxValues(0, 100)
	HCUI.jindu.Background = HCUI.jindu:CreateTexture(nil, "BACKGROUND");
	HCUI.jindu.Background:SetTexture("interface/characterframe/ui-party-background.blp")
	HCUI.jindu.Background:SetAllPoints(HCUI.jindu)
	HCUI.jindu.Background:SetColorTexture(1, 1, 1, 0.4)
	HCUI.jindu.t1 = PIGFontString(HCUI.jindu,{"CENTER",HCUI.jindu,"CENTER",0,0},"/","OUTLINE",13)
	HCUI.jindu.t2 = PIGFontString(HCUI.jindu,{"RIGHT",HCUI.jindu.t1,"LEFT",0,0},0,"OUTLINE",13)
	HCUI.jindu.t3 = PIGFontString(HCUI.jindu,{"LEFT",HCUI.jindu.t1,"RIGHT",0,0},0,"OUTLINE",13)
	HCUI.jindu.tbiaoti = PIGFontString(HCUI.jindu,{"BOTTOM",HCUI.jindu,"TOP",0,2},"正在扫描物品...","OUTLINE",13)
	----
	local function Save_Data_End()
		for k,v in pairs(UpdateF.auctionsLin) do
			if UpdateF.auctionsG[v[1]] then
   				if v[2]<UpdateF.auctionsG[v[1]][1] then
   					UpdateF.auctionsG[v[1]][1]=v[2]
   				end
			else
				UpdateF.auctionsG[v[1]]={v[2],v[3],v[4]}
			end
		end
		for k,v in pairs(UpdateF.auctionsG) do
			BusinessInfo.ADD_Newdata(k,v[1],v[2],v[3])
		end
		HCUI.jindu.tbiaoti:SetText("价格缓存完毕");
		HCUI.close:Show();
	end
	local function TryProcessIndex(index)
	    local name, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, _, _, _, itemId, hasAllInfo = C_AuctionHouse.GetReplicateItemInfo(index)
	    if hasAllInfo then
		    if itemId and buyoutPrice and buyoutPrice>0 and count and count > 0 then
		        local itemLink=C_AuctionHouse.GetReplicateItemLink(index)
		        if itemLink then
					local xianjiaV =buyoutPrice/count
					UpdateF.auctionsLin[index]={name,xianjiaV,itemLink,itemId}
					return true
		        end
		    end
		end
	    UpdateF.RetryCount[index]=(UpdateF.RetryCount[index] or 0)+1
	    if UpdateF.RetryCount[index]>4 then
    		return true
		end
	    return false
	end
	local function UpdateGetItem()
		if not UpdateF.SMend then return end
		for index=(1+UpdateF.allCount),UpdateF.currentTotal do
			UpdateF.allCount=UpdateF.allCount+1
			if UpdateF.ItemIndexList[index] then
				local success = TryProcessIndex(index)
				if success then
					UpdateF.ItemIndexList[index]=nil
		            UpdateF._index = UpdateF._index + 1
					HCUI.jindu.t2:SetText(UpdateF._index);
					HCUI.jindu:SetValue(UpdateF._index);
		        end
			    UpdateF.danciCount = UpdateF.danciCount + 1
			    if UpdateF.danciCount>UpdateF.meiyenum then
		        	UpdateF.danciCount=0
		        	C_Timer.After(UpdateF.ScanCD, function()
		        		UpdateGetItem()
		        	end)
		        	return
		        end
			end
		end
		if next(UpdateF.ItemIndexList) then
			C_Timer.After(0.1, function()
        		UpdateF.allCount=0
        		UpdateGetItem()
        	end)
		else
			Save_Data_End()
			UpdateF.SMend=nil
		end
	end
	local function UpdateScan()
		if not UpdateF.SMend then return end
        local currentTotal = C_AuctionHouse.GetNumReplicateItems()
        HCUI.jindu.t3:SetText(currentTotal);
		if UpdateF.Query then
			C_Timer.After(1, UpdateScan)
		else
			UpdateF.currentTotal=currentTotal
			HCUI.jindu.t3:SetText(currentTotal);
			HCUI.jindu:SetMinMaxValues(0, currentTotal)
			HCUI.jindu.tbiaoti:SetText("正在获取价格...");
			for index=1,currentTotal do
				UpdateF.ItemIndexList[index]=true
			end
			UpdateF.allCount=0
			UpdateF.danciCount=0
			C_Timer.After(0.1, UpdateGetItem)
		end
	end
	function UpdateF:StartScan()
		AuctionHouseFrame.History:Disable()
		AuctionHouseFrame.SearchBar.FilterButton:Reset()
		BusinessInfo.Del_OldData()
		HCUI:Show();
		HCUI.close:Hide();
		HCUI.jindu.tbiaoti:SetText("正在扫描物品...");
		HCUI.jindu:SetMinMaxValues(0, 100)
		HCUI.jindu:SetValue(1);
		HCUI.jindu.t2:SetText(0);
		HCUI.jindu.t3:SetText(0);
		PIGA["AHPlus"]["DaojiTime"]=GetServerTime()
		self.ScanCD=PIGA["AHPlus"]["ScanTimeCD"]*0.0001
		self.SMend = true
		self.Query = true
		self.currentTotal=0
		self._index = 0
		C_AuctionHouse.ReplicateItems()
		C_Timer.After(1, UpdateScan)
	end
	function UpdateF.StopScan()
		HCUI:Hide();
		HCUI.close:Hide();
		UpdateF.SMend=nil
		UpdateF.Query=nil
		wipe(UpdateF.auctionsG)
		wipe(UpdateF.auctionsLin)
		wipe(UpdateF.RetryCount)
		wipe(UpdateF.ItemIndexList)
	end
	AuctionHouseFrame.BrowseResultsFrame:HookScript("OnHide",UpdateF.StopScan)
	UpdateF:RegisterEvent("REPLICATE_ITEM_LIST_UPDATE")
	UpdateF:HookScript("OnEvent",function(self,event)
		if event == "REPLICATE_ITEM_LIST_UPDATE" then
			UpdateF.Query=nil
		end
	end)
	---------------------
	AuctionHouseFrame.WoWTokenResults.qushibut = PIGButton(AuctionHouseFrame.WoWTokenResults,{"CENTER",AuctionHouseFrame.WoWTokenResults,"CENTER",3,-100},{80,24},"历史价格",nil,nil,nil,nil,0)
	AuctionHouseFrame.WoWTokenResults.qushibut:HookScript("OnClick",function(self)
		if BusinessInfo.StatsInfoUI then
			BusinessInfo.StatsInfoUI:TabShow(AuctionHouseFrame)
		else
			PIG_OptionsUI:ErrorMsg("请打开"..addonName..SETTINGS.."→"..L["BUSINESS_TABNAME"].."→"..INFO..STATISTICS)
		end
	end)
end