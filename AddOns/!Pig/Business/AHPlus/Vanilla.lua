local addonName, addonTable = ...;
local gsub = _G.string.gsub
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGButton=Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGBrowseBiaoti=Create.PIGBrowseBiaoti
local PIGFontString=Create.PIGFontString
local PIGSetFont=Create.PIGSetFont
---
local Data=addonTable.Data
local BusinessInfo=addonTable.BusinessInfo
---------------------------------
local function Update_GGG(self,GGG)
	self:Hide();
	self.T:Hide();
	self.Y:Hide();
	self.G:Hide();
	self.TV:SetText();
	self.YV:SetText();
	self.GV:SetText();
	if GGG>0 then
		self:Show();
		local copper = floor(GGG % 100+0.5)
		self.TV:SetText(copper);
		self.T:Show();
		local silver = floor(GGG / 100) % 100
		local gold = floor(GGG / 10000)	
		if silver>0 or gold>0 then
			self.YV:SetText(silver);
			self.Y:Show();
		end
		if gold>0 then
			self.GV:SetText(gold);
			self.G:Show();
		end
	end
end
local function Add_GGGF(fujiF,Point,width,hang_Height,Color)
	local frame = CreateFrame("Frame", nil, fujiF);
	frame:SetSize(width, hang_Height);
	frame:SetPoint("LEFT", Point, "RIGHT", 0,0);
	frame.T = frame:CreateTexture(nil, "BORDER");
	frame.T:SetTexture("interface/moneyframe/ui-coppericon.blp");
	frame.T:SetPoint("RIGHT",frame,"RIGHT",-6,0);
	frame.T:SetSize(12,14);
	frame.TV = PIGFontString(frame,{"RIGHT", frame.T, "LEFT", 2,0},nil,"OUTLINE",13)
	frame.TV:SetJustifyH("RIGHT");
	frame.Y = frame:CreateTexture(nil, "BORDER");
	frame.Y:SetTexture("interface/moneyframe/ui-silvericon.blp");
	frame.Y:SetPoint("RIGHT",frame.T,"LEFT",-15,0);
	frame.Y:SetSize(12,14);
	frame.YV = PIGFontString(frame,{"RIGHT", frame.Y, "LEFT", 2,0},nil,"OUTLINE",13)
	frame.YV:SetJustifyH("RIGHT");
	frame.G = frame:CreateTexture(nil, "BORDER");
	frame.G:SetTexture("interface/moneyframe/ui-goldicon.blp");
	frame.G:SetPoint("RIGHT",frame.Y,"LEFT",-15,0);
	frame.G:SetSize(12,14);
	frame.GV = PIGFontString(frame,{"RIGHT", frame.G, "LEFT", 2,0},nil,"OUTLINE",13)
	frame.GV:SetJustifyH("RIGHT");
	if Color then
		frame.TV:SetTextColor(Color[1], Color[2], Color[3], Color[4]);
		frame.YV:SetTextColor(Color[1], Color[2], Color[3], Color[4]);
		frame.GV:SetTextColor(Color[1], Color[2], Color[3], Color[4]);
	end
	return frame
end
function BusinessInfo.AHPlus_Vanilla()
	if not PIGA["AHPlus"]["Open"] or AuctionFrameBrowse.piglist then return end
	----------
	local SimpleModename="简易模式(防卡)"
	AuctionFrame.SimpleMode =PIGCheckbutton(AuctionFrame,nil,{SimpleModename,"如果拍卖行买卖CD很长，请开启此模式"},nil,nil,nil,0)
	if ElvUI then
		AuctionFrame.SimpleMode:SetPoint("BOTTOMRIGHT",AuctionFrame,"TOPRIGHT",-240,2);
	else
		AuctionFrame.SimpleMode:SetPoint("BOTTOMRIGHT",AuctionFrame,"TOPRIGHT",-240,-8);
	end
	AuctionFrame.SimpleMode.Text:SetTextColor(0, 1, 1, 0.8);
	AuctionFrame.SimpleMode:SetScript("OnClick", function (self)
		StaticPopup_Show("PIG_AUCTION_SIMPLEMODE",PIGA["AHPlus"]["SimpleMode"] and "关闭" or not PIGA["AHPlus"]["SimpleMode"] and "启用");
	end);
	StaticPopupDialogs["PIG_AUCTION_SIMPLEMODE"] = {
		text = "%s"..SimpleModename..",需要重载UI,\n确定启用?",
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			if PIGA["AHPlus"]["SimpleMode"] then
				PIGA["AHPlus"]["SimpleMode"]=nil
			else
				PIGA["AHPlus"]["SimpleMode"]=true
			end
			ReloadUI()
		end,
		OnCancel = function()
			AuctionFrame.SimpleMode:SetChecked(PIGA["AHPlus"]["SimpleMode"])
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	-----
	if not ITEM_QUALITY_COLORS["-1"] then
		local color = CreateColor(1, 1, 1, 1)
		ITEM_QUALITY_COLORS["-1"]={r = 1, g = 1, b = 1, hex = color:GenerateHexColorMarkup(), color = color}
	end
	local function exactMatchFun()
		if PIGA["AHPlus"]["SimpleMode"] then return end
		local OLD_QueryAuctionItems = QueryAuctionItems	
		QueryAuctionItems = function(...)
			if PIGA["AHPlus"]["exactMatch"] then
				local text, minLevel, maxLevel, page, usable, rarity, allxiazai, exactMatch, filterData =...
				return OLD_QueryAuctionItems(text, minLevel, maxLevel, page, usable, rarity, allxiazai, true, filterData)
			else
				return OLD_QueryAuctionItems(...)
			end
		end
	end
	exactMatchFun()
	AuctionFrameBrowse.exact =PIGCheckbutton(AuctionFrameBrowse,nil,{AH_EXACT_MATCH,AH_EXACT_MATCH_TOOLTIP},nil,nil,nil,0)
	if ElvUI and AuctionFrame.backdrop then
		AuctionFrameBrowse.exact:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",530,-4);
	else
		AuctionFrameBrowse.exact:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",530,-14);
	end
	AuctionFrameBrowse.exact.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameBrowse.exact:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["exactMatch"]=true
		else
			PIGA["AHPlus"]["exactMatch"]=false
		end
	end);
	----
	local AH_TIME = TIME_LABEL:gsub(":","")
	local AH_TIME = AH_TIME:gsub("：","")
	local biaotiLsit = {"BrowseQualitySort","Browse_biaoti_Count","BrowseLevelSort","Browse_biaoti_unitbid","BrowseCurrentBidSort","BrowseUpDown","BrowseDurationSort","BrowseHighBidderSort"}
	local biaotiLsitW = {190,46,38,170,170,54,100,100}
	local biaotiLsitArrow={true,false,true,true,true,false,true,true}
	local biaotiLsitName = {"",ACTION_SPELL_AURA_APPLIED_DOSE,"",AUCTION_SORT_HEADER_UNIT_BID_PRICE,AUCTION_SORT_HEADER_UNIT_BUYOUT_PRICE,"涨跌","",""}
	local hang_Height,hang_NUM ,anniuH,suoxiaozhi,FontSise = 25, 14, 18, 58, 13.2
	local shengyuTime = {[1]="|cffFF0000<30m|r",[2]="|cffFFFF0030m~2H|r",[3]="|cff00FF002H~12H|r",[4]="|cff00FF00>12H|r",}
	local Funlist={}
	local function SetFrameMoneyFont(uiname)
		local BuyoutFrameMoney = _G[uiname..""];
		local BuyoutFrameMoneyGold = _G[uiname.."GoldButton"];
		local BuyoutFrameMoneySilver = _G[uiname.."SilverButton"];
		local BuyoutFrameMoneyCopper = _G[uiname.."CopperButton"];
		BuyoutFrameMoney:SetHeight(hang_Height)
		BuyoutFrameMoneyGold:SetHeight(hang_Height)
		BuyoutFrameMoneySilver:SetHeight(hang_Height)
		BuyoutFrameMoneyCopper:SetHeight(hang_Height)
		local BuyoutFrameMoneyGoldText = _G[uiname.."GoldButtonText"];
		local BuyoutFrameMoneySilverText = _G[uiname.."SilverButtonText"];
		local BuyoutFrameMoneyCopperText = _G[uiname.."CopperButtonText"];
		PIGSetFont(BuyoutFrameMoneySilverText,FontSise)
		PIGSetFont(BuyoutFrameMoneyCopperText,FontSise)
		PIGSetFont(BuyoutFrameMoneyGoldText,FontSise)
	end
	--调整原版UI
	SetCVar("auctionSortByBuyoutPrice", "1");
	SetCVar("auctionSortByUnitPrice", "1");
	-- NUM_AUCTION_ITEMS_PER_PAGE = 100;
	local PIG_NUM_BROWSE_TO_DISPLAY = 12;
	BrowseNameText:ClearAllPoints();
	BrowseNameText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",598,-40);
	BrowseLevelText:ClearAllPoints();
	BrowseLevelText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",70,-40);

	local BrowseDropDown=BrowseDropDown or BrowseDropdown
	BrowseDropDown:SetPoint("TOPLEFT",BrowseLevelText,"BOTTOMRIGHT",5,4);

	local BrowseIsUsable=IsUsableCheckButton or BrowseIsUsableText
	BrowseIsUsable:ClearAllPoints();
	BrowseIsUsable:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",290,-35);

	--  ShowOnPlayerCheckButton=ShowOnPlayerCheckButton or BrowseShowOnCharacterText--预览效果
	-- 	ShowOnPlayerCheckButton:ClearAllPoints();
	-- 	ShowOnPlayerCheckButton:SetPoint("LEFT",IsUsableCheckButton,"RIGHT",70,0);
	if BrowseResetButton then--重置按钮
		BrowseResetButton:ClearAllPoints();
		BrowseResetButton:SetPoint("LEFT",BrowseNameText,"RIGHT",4,0);
	end
	BrowseSearchButton:ClearAllPoints();
	BrowseSearchButton:SetPoint("LEFT",BrowseName,"RIGHT",4,0);
	BrowseSearchCountText:ClearAllPoints();
	BrowseSearchCountText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",400,-38);
	BrowsePrevPageButton:ClearAllPoints();
	BrowsePrevPageButton:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",450,-60);
	BrowsePrevPageButton:SetScale(0.88);
	BrowseNextPageButton:ClearAllPoints();
	BrowseNextPageButton:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",620,-60);
	BrowseNextPageButton:SetScale(0.88);
	if BrowsePriceOptionsButtonFrame then--设置单价展示
		BrowsePriceOptionsButtonFrame:Hide()
		hooksecurefunc("AuctionFrameFilter_OnClick", function()
			BrowsePriceOptionsButtonFrame:Hide()
		end)
	end
	---
	AuctionFrameBrowse.bgtex = CreateFrame("Frame", nil, AuctionFrameBrowse,"BackdropTemplate")
	if ElvUI and AuctionFrameBrowse.LeftBackground then
		AuctionFrameBrowse.LeftBackground:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",-636,33.61);
	elseif NDui then
		AuctionFrameBrowse.bgtex:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
		AuctionFrameBrowse.bgtex:SetBackdropColor(0.1, 0.1, 0.1, 0.5);
	else
		AuctionFrameBrowse.bgtex:SetBackdrop({bgFile = "interface/framegeneral/ui-background-rock.blp"});
		AuctionFrameBrowse.bgtex:SetBackdropColor(0.4, 0.4, 0.4, 1);
		AuctionFrameBrowse.bgtex.fengeline = AuctionFrameBrowse.bgtex:CreateTexture(nil, "BORDER");
		AuctionFrameBrowse.bgtex.fengeline:SetTexture("interface/dialogframe/ui-dialogbox-divider.blp");
		AuctionFrameBrowse.bgtex.fengeline:SetRotation(math.rad(-90),{x=0,y=0})
		AuctionFrameBrowse.bgtex.fengeline:SetSize(408,24);
		AuctionFrameBrowse.bgtex.fengeline:SetPoint("TOPLEFT",AuctionFrameBrowse.bgtex,"TOPLEFT",-20,26);
	end
	AuctionFrameBrowse.bgtex:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",180-suoxiaozhi,-104);
	AuctionFrameBrowse.bgtex:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",70,38);
	BrowseScrollFrame:SetPoint("TOPRIGHT",AuctionFrameBrowse.bgtex,"TOPRIGHT",-28,0);
	BrowseScrollFrame:SetPoint("BOTTOMLEFT",AuctionFrameBrowse.bgtex,"BOTTOMLEFT",0,0);
	BrowseNoResultsText:SetParent(AuctionFrameBrowse.bgtex)
	--
	AuctionFrameBrowse.qushiUI=PIGFrame(AuctionFrameBrowse,nil,nil,nil,nil,nil,{["ElvUI"]={0,0,0,0},["NDui"]={0,0,0,0}})
	AuctionFrameBrowse.qushiUI:SetSize(328,204);
	AuctionFrameBrowse.qushiUI:PIGSetBackdrop(1)
	AuctionFrameBrowse.qushiUI:SetFrameStrata("HIGH")
	AuctionFrameBrowse.qushiUI.qushiF=BusinessInfo.ADD_qushi(AuctionFrameBrowse.qushiUI,true)
	AuctionFrameBrowse.qushiUI.qushiF:SetPoint("TOPLEFT", AuctionFrameBrowse.qushiUI, "TOPLEFT",4, -24);
	AuctionFrameBrowse.qushiUI.qushiF:SetPoint("BOTTOMRIGHT", AuctionFrameBrowse.qushiUI, "BOTTOMRIGHT",-4, 4);
	--标题
	local function Set_ArrowPoint(but,Sort)
		local existingSortColumn, existingSortReverse = GetAuctionSort("list", 1);
		if existingSortColumn==Sort then
			but.Arrow:Show()
			if existingSortReverse then
				but.Arrow:SetTexCoord(0, 0.5625, 1, 0);
			else
				but.Arrow:SetTexCoord(0, 0.5625, 0, 1);
			end
		else
			but.Arrow:Hide()
		end
	end
	hooksecurefunc("AuctionFrameBrowse_UpdateArrows", function()
		SortButton_UpdateArrow(BrowseCurrentBidSort, "list", "unitprice");
		Set_ArrowPoint(BrowseCurrentBidSort,"unitprice")
		Set_ArrowPoint(Browse_biaoti_unitbid,"unitbid")
	end)
	BrowseSearchButton:HookScript("OnUpdate", function(self,event,arg1)
		if ( CanSendAuctionQuery("list") ) then
			Browse_biaoti_unitbid:Enable();
		else
			Browse_biaoti_unitbid:Disable();
		end
	end);
	for i=1,#biaotiLsit do
		local biaotiBut = _G[biaotiLsit[i]]
		if not biaotiBut then
			biaotiBut = CreateFrame("Button",biaotiLsit[i],AuctionFrameBrowse,"AuctionSortButtonTemplate");
		end
		biaotiBut:SetSize(biaotiLsitW[i]+2,19);
		biaotiBut:ClearAllPoints();
		if biaotiLsitName[i]~="" then
			biaotiBut:SetText(biaotiLsitName[i]);
		end
		if i==4 then
			biaotiBut:HookScript("OnClick", function (self)
				local existingSortColumn, existingSortReverse = GetAuctionSort("list", 1);
				SortAuctionClearSort("list");
				if existingSortColumn=="unitbid" then
					if existingSortReverse then
						SortAuctionSetSort("list", "unitbid", false);
					else
						SortAuctionSetSort("list", "unitbid", true);
					end
				else
					SortAuctionSetSort("list", "unitbid", false);
				end
				AuctionFrameBrowse_Search();
			end)
		end
		if not biaotiLsitArrow[i] then
			_G[biaotiLsit[i].."Arrow"]:Hide() biaotiBut:Disable(); 
			if i==6 then
				AuctionFrameBrowse.qushitishi:SetPoint("RIGHT",biaotiBut,"RIGHT",1,-1);
			end
		end
		if i==1 then
			biaotiBut:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",122,-82);
		elseif i==7 then
			biaotiBut:SetPoint("LEFT",_G[biaotiLsit[i-1]],"RIGHT",30,0);
		else
			biaotiBut:SetPoint("LEFT",_G[biaotiLsit[i-1]],"RIGHT",0,0);
		end
		if ElvUI and AuctionFrame.backdrop or NDui then
			_G[biaotiLsit[i].."Left"]:Hide()
			_G[biaotiLsit[i].."Middle"]:Hide()
			_G[biaotiLsit[i].."Right"]:Hide()
		end
	end
	hooksecurefunc("AuctionFrameFilters_UpdateCategories", function(forceSelectionIntoView)	
		BrowseFilterScrollFrame:ClearAllPoints();
		BrowseFilterScrollFrame:SetPoint("TOPRIGHT",AuctionFrameBrowse,"TOPLEFT",158-suoxiaozhi,-105);
		local hasScrollBar = #OPEN_FILTER_LIST > NUM_FILTERS_TO_DISPLAY;
		for i = 1, NUM_FILTERS_TO_DISPLAY do
			local button = AuctionFrameBrowse.FilterButtons[i];
			if i == 1 then 
				button:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",16,-105);
			end
			button:SetWidth(hasScrollBar and 140-suoxiaozhi or 160-suoxiaozhi);
			if button.Text:GetText()==TOKEN_FILTER_LABEL then
				button.Text:SetText(ITEM_QUALITY8_DESC)
			end
		end	
	end)
	for i=1, PIG_NUM_BROWSE_TO_DISPLAY do
		local button = _G["BrowseButton"..i];
		if not button then
			button = CreateFrame("Button","BrowseButton"..i, AuctionFrameBrowse, "BrowseButtonTemplate", i);
			button:SetPoint("TOPLEFT",_G["BrowseButton"..(i-1)],"BOTTOMLEFT",0,0);
		end
		button:SetHeight(hang_Height)
		local buttonLeft = _G["BrowseButton"..i.."Left"];
		buttonLeft:ClearAllPoints();
		local buttonRight = _G["BrowseButton"..i.."Right"];
		buttonRight:ClearAllPoints();
		if i~=hang_NUM then
			button.line = button:CreateLine()
			button.line:SetColorTexture(1,1,1,0.2)
			button.line:SetThickness(1);
			button.line:SetStartPoint("BOTTOMLEFT",0,0)
			button.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		if i==1 then
			button:SetPoint("TOPLEFT", BrowseScrollFrame, "TOPLEFT", 4, -2);
		end
		local buttonItem = _G["BrowseButton"..i.."Item"];
		local buttonName = _G["BrowseButton"..i.."Name"];
		local buttonLevel = _G["BrowseButton"..i.."Level"];
		local itemCount = _G["BrowseButton"..i.."ItemCount"];
		local buttonClosingTime = _G["BrowseButton"..i.."ClosingTime"];
		local buttonHighBidder = _G["BrowseButton"..i.."HighBidder"];
		SetFrameMoneyFont("BrowseButton"..i.."MoneyFrame")
		SetFrameMoneyFont("BrowseButton"..i.."BuyoutFrameMoney")
		_G["BrowseButton"..i.."BuyoutFrameText"]:Hide()
		_G["BrowseButton"..i.."ClosingTimeText"]:SetAllPoints(buttonClosingTime)
		buttonItem:SetScale((hang_Height-4)/32)
		buttonItem:ClearAllPoints();
		buttonItem:SetPoint("LEFT", button, "LEFT", 0, 0);
		
		buttonName:SetSize(biaotiLsitW[1]-hang_Height+6,hang_Height)
		buttonName:ClearAllPoints();
		buttonName:SetPoint("LEFT", buttonItem, "RIGHT", 2, 0);
		itemCount:SetTextColor(0, 1, 1, 1);
		itemCount:SetSize(biaotiLsitW[2],hang_Height)
		buttonLevel:SetSize(biaotiLsitW[3],hang_Height)
		buttonLevel:SetPoint("TOPLEFT", button, "TOPLEFT", biaotiLsitW[1]+biaotiLsitW[2], 0);

		buttonClosingTime:SetSize(biaotiLsitW[7],hang_Height)
		buttonClosingTime:SetPoint("TOPLEFT", button, "TOPLEFT", biaotiLsitW[1]+biaotiLsitW[2]+biaotiLsitW[3]+biaotiLsitW[4]+biaotiLsitW[5]+biaotiLsitW[6]+42, 0);
		buttonHighBidder:SetSize(biaotiLsitW[8],hang_Height)
		buttonHighBidder:SetPoint("TOPLEFT", button, "TOPLEFT", biaotiLsitW[1]+biaotiLsitW[2]+biaotiLsitW[3]+biaotiLsitW[4]+biaotiLsitW[5]+biaotiLsitW[6]+biaotiLsitW[7]+42, 0);
		
		button.UpDown = CreateFrame("Frame", "BrowseButton"..i.."UpDown", button)
		button.UpDown:SetSize(biaotiLsitW[6]-4,hang_Height);
		button.UpDown:SetPoint("RIGHT", button, "RIGHT", -6,0);
		button.UpDown.Text = PIGFontString(button.UpDown,nil,nil,"OUTLINE")
		button.UpDown.Text:SetJustifyH("RIGHT");
		button.UpDown.Text:SetAllPoints(button.UpDown)
		PIGSetFont(buttonName,FontSise)
		PIGSetFont(itemCount,FontSise)
		itemCount:SetScale(32/(hang_Height-4))
		PIGSetFont(buttonLevel,FontSise)

		PIGSetFont(_G["BrowseButton"..i.."ClosingTimeText"],FontSise)
		PIGSetFont(_G["BrowseButton"..i.."HighBidderName"],FontSise)
		PIGSetFont(button.UpDown.Text,FontSise)
		button.UpDown:HookScript("OnEnter", function(self)
			self:GetParent():LockHighlight();
			local AHdangqianH = FauxScrollFrame_GetOffset(BrowseScrollFrame)+i;
			local name, texture, count, quality = GetAuctionItemInfo("list", AHdangqianH);
			if name then
				local NameData=BusinessInfo.GetCacheDataG(name)
				if NameData then
					AuctionFrameBrowse.qushiUI:Show()
					AuctionFrameBrowse.qushiUI:SetPoint("TOPRIGHT",self,"TOPLEFT",8,1);
					local r, g, b,hex = GetItemQualityColor(quality)
					AuctionFrameBrowse.qushiUI.qushiF.qushitu(NameData,"|c"..hex..name.."|r")
				end
			end
		end);
		button.UpDown:HookScript("OnLeave", function(self)
			self:GetParent():UnlockHighlight();
			AuctionFrameBrowse.qushiUI:Hide()
		end);
		button:HookScript("OnMouseUp", function (self,button)
			if button=="RightButton" then
				local AHdangqianH = FauxScrollFrame_GetOffset(BrowseScrollFrame)+i;
				local name, texture, count, quality = GetAuctionItemInfo("list", AHdangqianH);
				if name and name~="" and name~=" " then
					local r, g, b,hex = GetItemQualityColor(quality)
					local hejiinfo = PIGA["AHPlus"]["Coll"]
					for kk=1,#hejiinfo do
						if hejiinfo[kk][1]==name then
							PIG_OptionsUI:ErrorMsg("<|c"..hex..name.."|r>已存在","R")
							return
						end
					end
					table.insert(PIGA["AHPlus"]["Coll"],{name,texture,quality})
					PIG_OptionsUI:ErrorMsg("<|c"..hex..name.."|r>已加入关注")
					Funlist:Gengxinlistcoll()
				end
			end
		end);
	end
	local function IsSortingByUnitPrice()
		return GetCVarBool("auctionSortByUnitPrice");
	end
	hooksecurefunc("AuctionFrameBrowse_Update", function()
		_G[biaotiLsit[5]]:SetWidth(biaotiLsitW[5]+2);
		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
		if ( totalAuctions > NUM_AUCTION_ITEMS_PER_PAGE ) then
			FauxScrollFrame_Update(BrowseScrollFrame, numBatchAuctions, PIG_NUM_BROWSE_TO_DISPLAY, AUCTIONS_BUTTON_HEIGHT);
		end
		BrowseSearchCountText:Show();
		local itemsMin = AuctionFrameBrowse.page * NUM_AUCTION_ITEMS_PER_PAGE + 1;
		local itemsMax = itemsMin + numBatchAuctions - 1;
		BrowseSearchCountText:SetFormattedText(NUMBER_OF_RESULTS_TEMPLATE, itemsMin, itemsMax, totalAuctions);
		for i=1, PIG_NUM_BROWSE_TO_DISPLAY do
			local button = _G["BrowseButton"..i];
			local buttonHighlight = _G["BrowseButton"..i.."Highlight"];
			local buttonName = _G["BrowseButton"..i.."Name"];
			local itemCount = _G["BrowseButton"..i.."ItemCount"];
			local buttonClosingTime = _G["BrowseButton"..i.."ClosingTimeText"];
			button.UpDown.Text:SetText("--");
			button.UpDown.Text:SetTextColor(0.5, 0.5, 0.5, 0.5);
			local AHdangqianH = FauxScrollFrame_GetOffset(BrowseScrollFrame)+i;
			local timeleft = GetAuctionItemTimeLeft("list", AHdangqianH)
			buttonClosingTime:SetText(shengyuTime[timeleft]);
			local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice,bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("list", AHdangqianH);
			local itemLink = GetAuctionItemLink("list", AHdangqianH)
			if i>8 then
				if name then
					local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
					local buttonName="BrowseButton"..i
					duration = GetAuctionItemTimeLeft("list", offset + i);
					local color = ITEM_QUALITY_COLORS[quality];
					local itemName = _G[buttonName.."Name"];
					itemName:SetText(name);
					itemName:SetVertexColor(color.r, color.g, color.b);
					local itemButton = _G[buttonName.."Item"];

					if ( levelColHeader == "REQ_LEVEL_ABBR" and level > UnitLevel("player") ) then
						_G[buttonName.."Level"]:SetText(RED_FONT_COLOR_CODE..level..FONT_COLOR_CODE_CLOSE);
					else
						_G[buttonName.."Level"]:SetText(level);
					end

					_G[buttonName.."ClosingTimeText"]:SetText(AuctionFrame_GetTimeLeftText(duration));
					_G[buttonName.."ClosingTime"].tooltip = AuctionFrame_GetTimeLeftTooltipText(duration);

					iconTexture = _G[buttonName.."ItemIconTexture"];
					iconTexture:SetTexture(texture);
					if ( not canUse ) then
						iconTexture:SetVertexColor(1.0, 0.1, 0.1);
					else
						iconTexture:SetVertexColor(1.0, 1.0, 1.0);
					end
					itemCount = _G[buttonName.."ItemCount"];
					if ( count > 1 ) then
						itemCount:SetText(count);
						itemCount:Show();
					else
						itemCount:Hide();
					end
					moneyFrame = _G[buttonName.."MoneyFrame"];
					local showPricePerUnit = IsSortingByUnitPrice() and count > 1;
					-- If not bidAmount set the bid amount to the min bid
					if ( bidAmount == 0 ) then
						displayedPrice = minBid;
						requiredBid = minBid;
					else
						displayedPrice = bidAmount;
						requiredBid = bidAmount + minIncrement ;
					end
					local sortedPrice = displayedPrice;
					if ( showPricePerUnit ) then
						sortedPrice = ceil(sortedPrice / count);
					end
					MoneyFrame_Update(moneyFrame:GetName(), sortedPrice);

					yourBidText = _G[buttonName.."YourBidText"];

					-- yourBidText:SetPoint("TOP", moneyFrame, "TOP", 0, 0);
					-- yourBidText:SetPoint("BOTTOM", moneyFrame, "BOTTOM", 0, 0);
					-- yourBidText:SetPoint("RIGHT", moneyFrame, "LEFT", -2, 0);

					if ( highBidder ) then
						yourBidText.Text:SetText(YOUR_BID);
						yourBidText:Show();
					elseif ( showPricePerUnit ) then
						yourBidText.Text:SetText(string.format(AUCTION_PRICE_STACK_SIZE_LABEL, count));
						yourBidText:Show();
					else
						yourBidText:Hide();
					end
					
					if ( requiredBid >= MAXIMUM_BID_PRICE ) then
						-- Lie about our buyout price
						buyoutPrice = requiredBid;
					end
					buyoutFrame = _G[buttonName.."BuyoutFrame"];
					if ( buyoutPrice > 0 ) then
						local sortedBuyoutPrice = buyoutPrice;
						if ( showPricePerUnit ) then
							sortedBuyoutPrice = ceil(sortedBuyoutPrice / count);
						end
						moneyFrame:SetPoint("RIGHT", button, "RIGHT", 10, 10);
						buyoutMoney = _G[buyoutFrame:GetName().."Money"];
						MoneyFrame_Update(buyoutMoney, sortedBuyoutPrice);
						buyoutFrame:Show();

						local buyoutFrameText = _G[buyoutFrame:GetName().."Text"];
						if ( showPricePerUnit ) then
							buyoutFrameText.Text:SetText(UNIT_BUYOUT_COST);
						else
							buyoutFrameText.Text:SetText(BUYOUT_COST);
						end

						-- Right-align "Your bid" or "20x" label with "Buyout" label if "Buyout" is shown.
						-- (Buyout price is always >= bid price so assume its text has >= width too.)
						yourBidText:SetPoint("RIGHT", buyoutFrameText, "RIGHT", 0, 0);
					else
						moneyFrame:SetPoint("RIGHT", button, "RIGHT", 10, 3);
						buyoutFrame:Hide();
					end
					-- Set high bidder
					--if ( not highBidder ) then
					--	highBidder = RED_FONT_COLOR_CODE..NO_BIDS..FONT_COLOR_CODE_CLOSE;
					--end
					local highBidderFrame = _G[buttonName.."HighBidder"]
					highBidderFrame.fullName = ownerFullName;
					highBidderFrame.Name:SetText(owner);
					
					-- this is for comparing to the player name to see if they are the owner of this auction
					local ownerName;
					if (not ownerFullName) then
						ownerName = owner;
					else
						ownerName = ownerFullName
					end
					
					button.bidAmount = displayedPrice;
					button.buyoutPrice = buyoutPrice;
					button.itemCount = count;
					button.itemIndex = index;

					-- Set highlight
					if ( GetSelectedAuctionItem("list") and (offset + i) == GetSelectedAuctionItem("list") ) then
						button:LockHighlight();
						
						if ( buyoutPrice > 0 and buyoutPrice >= minBid ) then
							local canBuyout = 1;
							if ( GetMoney() < buyoutPrice ) then
								if ( not highBidder or GetMoney()+bidAmount < buyoutPrice ) then
									canBuyout = nil;
								end
							end
							if ( canBuyout and (ownerName ~= UnitName("player")) ) then
								BrowseBuyoutButton:Enable();
								AuctionFrame.buyoutPrice = buyoutPrice;
							end
							MoneyFrame_Update(BrowseBuyoutPrice, buyoutPrice);
							BrowseBuyoutPrice:Show();
						else
							AuctionFrame.buyoutPrice = nil;
							BrowseBuyoutPrice:Hide();
						end
						-- Set bid
						MoneyInputFrame_SetCopper(BrowseBidPrice, requiredBid);

						if ( not highBidder and ownerName ~= UnitName("player") and GetMoney() >= MoneyInputFrame_GetCopper(BrowseBidPrice) and MoneyInputFrame_GetCopper(BrowseBidPrice) <= MAXIMUM_BID_PRICE ) then
							BrowseBidButton:Enable();
						end
					else
						button:UnlockHighlight();
					end

					if ( button.PriceTooltipFrame == activeTooltipPriceTooltipFrame ) then
						AuctionPriceTooltipFrame_OnEnter(button.PriceTooltipFrame);
					elseif ( itemButton == activeTooltipAuctionFrameItem ) then
						AuctionFrameItem_OnEnter(itemButton, "list", button:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame));
					end
					button:Show()
				else
					button:Hide()
				end
			end
			button:SetWidth(625+suoxiaozhi-8);

			buttonHighlight:ClearAllPoints();
			buttonHighlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, -1);
			buttonHighlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, -1);

			itemCount:ClearAllPoints();
			itemCount:SetPoint("LEFT", buttonName, "RIGHT", -14, 0);
			if not itemCount:IsShown() then
				itemCount:Show()
				itemCount:SetText(1)
			end
			local MoneyFrame = _G["BrowseButton"..i.."MoneyFrame"];
			MoneyFrame:SetSize(biaotiLsitW[4],hang_Height)
			MoneyFrame:ClearAllPoints();
			MoneyFrame:SetPoint("TOPLEFT", button, "TOPLEFT", biaotiLsitW[1]+biaotiLsitW[2]+biaotiLsitW[3], 0);
			local BuyoutFrame = _G["BrowseButton"..i.."BuyoutFrame"];
			BuyoutFrame:SetSize(biaotiLsitW[5],hang_Height)
			BuyoutFrame:ClearAllPoints();
			BuyoutFrame:SetPoint("TOPLEFT", button, "TOPLEFT", biaotiLsitW[1]+biaotiLsitW[2]+biaotiLsitW[3]+biaotiLsitW[4], 0);
			_G["BrowseButton"..i.."YourBidText"]:Hide()
			_G["BrowseButton"..i.."MoneyFrameCopperButton"]:SetPoint("RIGHT", _G["BrowseButton"..i.."MoneyFrame"], "RIGHT", 0, -2);
			_G["BrowseButton"..i.."BuyoutFrameMoneyCopperButton"]:SetPoint("RIGHT", _G["BrowseButton"..i.."BuyoutFrameMoney"], "RIGHT", 0, -2);
			
			if buyoutPrice>0 and count>0 then
				local xianjiaV = buyoutPrice/count
				local NameData=BusinessInfo.GetCacheDataG(name)
				if NameData then
					local OldMoneyNum = #NameData
					local OldGGGV_1 = NameData[OldMoneyNum]
					if AHdangqianH==1 then
						local existingSortColumn, existingSortReverse = GetAuctionSort("list", 1);
						if existingSortColumn=="unitprice" and existingSortReverse==false then
							if xianjiaV~=OldGGGV_1[1] and GetServerTime()-OldGGGV_1[2]>300 then
								BusinessInfo.ADD_Newdata(name,xianjiaV,itemLink,itemId)
							end
						end
					end				
					if OldMoneyNum>1 then
						local baifenbi = (xianjiaV/OldGGGV_1[1])*100+0.5
						local baifenbi = floor(baifenbi)
						button.UpDown.Text:SetText(baifenbi.."%");
						if baifenbi<100 then
							button.UpDown.Text:SetTextColor(0, 1, 0, 1);
						elseif baifenbi>100 then
							button.UpDown.Text:SetTextColor(1, 0, 0, 1);
						else
							button.UpDown.Text:SetTextColor(1, 1, 1, 1);
						end
					end
				else
					BusinessInfo.ADD_Newdata(name,xianjiaV,itemLink,itemId)
				end
			end
		end
	end)
	local function ShowHide_OT(vvv)
		_G[biaotiLsit[2]]:SetShown(vvv)
		_G[biaotiLsit[4]]:SetShown(vvv)
		_G[biaotiLsit[6]]:SetShown(vvv)
		AuctionFrameBrowse.ShowHideOT:SetShown(vvv)
		AuctionFrameBrowse.qushitishi:SetShown(vvv)
		local extshowVV = false
		if vvv==true and AuctionFrameBrowse.ShowHideOT.open then
			AuctionFrameBrowse.coll.list:Hide()
			extshowVV=true
		end
		_G[biaotiLsit[7]]:SetShown(extshowVV)
		_G[biaotiLsit[8]]:SetShown(extshowVV)
		for i=1, PIG_NUM_BROWSE_TO_DISPLAY do
			_G["BrowseButton"..i.."ClosingTime"]:SetShown(extshowVV)
			_G["BrowseButton"..i.."HighBidder"]:SetShown(extshowVV)
		end
	end
	local function ShowHide_OT_1()
		_G[biaotiLsit[7]]:SetShown(AuctionFrameBrowse.ShowHideOT.open)
		_G[biaotiLsit[8]]:SetShown(AuctionFrameBrowse.ShowHideOT.open)
	end
	AuctionFrameBrowse.ShowHideOT = PIGButton(AuctionFrameBrowse,{"TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",70,-80},{24,21},"+",nil,nil,nil,nil,0);
	AuctionFrameBrowse.ShowHideOT.open=false
	AuctionFrameBrowse.ShowHideOT:SetScript("OnClick", function(self)
		if AuctionFrameBrowse.ShowHideOT.open then
			AuctionFrameBrowse.ShowHideOT.open=false	
		else
			AuctionFrameBrowse.ShowHideOT.open=true	
		end
		ShowHide_OT(true)
	end)

	---缓存==================
	AuctionFrameBrowse.History = PIGButton(AuctionFrameBrowse,{"TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",10,-12},{90,20},"缓存价格",nil,nil,nil,nil,0);
	if ElvUI and AuctionFrame.backdrop then
		AuctionFrameBrowse.History:SetPoint("TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",10,-1);
	end
	AuctionFrameBrowse.History:HookScript("OnShow",function(self)
		local canQuery,canQueryAll = CanSendAuctionQuery()
		if canQueryAll then
			self:Enable()
		else
			self:Disable()
		end
	end)
	---
	AuctionFrameBrowse.huancunUI = CreateFrame("Frame", nil, AuctionFrameBrowse,"BackdropTemplate");
	local HCUI = AuctionFrameBrowse.huancunUI
	HCUI:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp",edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13,});
	HCUI:SetBackdropBorderColor(0, 1, 1, 0.9);
	HCUI:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",14,-34);
	HCUI:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",70,12);
	HCUI:SetFrameLevel(520)
	HCUI:EnableMouse(true)
	HCUI:Hide();
	HCUI.close = PIGButton(HCUI,{"CENTER",HCUI,"CENTER",0,-40},{90,30},"关闭",nil,nil,nil,nil,0);
	HCUI.close:Hide();
	HCUI.close:HookScript("OnClick",function(self)
		HCUI:Hide()
	end)

	local jinduW,jinduH = 300,20
	HCUI.jindu = CreateFrame("StatusBar", nil, HCUI);
	HCUI.jindu:SetStatusBarTexture("interface/raidframe/raid-bar-hp-fill.blp")
	HCUI.jindu:SetStatusBarColor(0, 1, 0 ,1);
	HCUI.jindu:SetSize(jinduW,jinduH);
	HCUI.jindu:SetPoint("CENTER",HCUI,"CENTER",0,40);
	HCUI.jindu:SetMinMaxValues(0, 100)
	HCUI.jindu.BACKGROUND = HCUI.jindu:CreateTexture(nil, "BACKGROUND");
	HCUI.jindu.BACKGROUND:SetTexture("interface/characterframe/ui-party-background.blp")
	HCUI.jindu.BACKGROUND:SetAllPoints(HCUI.jindu)
	HCUI.jindu.BACKGROUND:SetColorTexture(1, 1, 1, 0.4)
	HCUI.jindu.t1 = PIGFontString(HCUI.jindu,{"CENTER",HCUI.jindu,"CENTER",0,0},"/","OUTLINE",13)
	HCUI.jindu.t2 = PIGFontString(HCUI.jindu,{"RIGHT",HCUI.jindu.t1,"LEFT",0,0},0,"OUTLINE",13)
	HCUI.jindu.t3 = PIGFontString(HCUI.jindu,{"LEFT",HCUI.jindu.t1,"RIGHT",0,0},0,"OUTLINE",13)
	HCUI.jindu.tbiaoti = PIGFontString(HCUI.jindu,{"BOTTOM",HCUI.jindu,"TOP",0,2},"正在扫描物品...","OUTLINE",13)
	HCUI.UpdateF = CreateFrame("Frame")
	HCUI.UpdateF:Hide()
	---
	local meiyenum = 50
	HCUI.auctions = {}
	HCUI.auctionsLin = {}
	HCUI.ItemLoadList = {}
	local function OpenScanFun(v)
		if v then
			AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
		else
			AuctionFrameBrowse:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
		end
	end
	local function au_SetValue()
		HCUI.jishuID=HCUI.jishuID+1
		HCUI.jindu.t2:SetText(HCUI.jishuID);
		HCUI.jindu:SetValue(HCUI.jishuID);
	end
	local function Save_Data_End()
		for k,v in pairs(HCUI.auctionsLin) do
			if HCUI.auctions[v[1]] then
   				if v[2]<HCUI.auctions[v[1]][1] then
   					HCUI.auctions[v[1]][1]=v[2]
   				end
			else
				HCUI.auctions[v[1]]={v[2],v[3],v[4]}
			end
		end
		for k,v in pairs(HCUI.auctions) do
			BusinessInfo.ADD_Newdata(k,v[1],v[2],v[3])
		end
		HCUI.jindu.tbiaoti:SetText("价格缓存完毕");
		HCUI.close:Show();
		OpenScanFun(nil)
	end
	local function SauctionsLinData(name,buyoutPrice,count,index,itemId)
		if name and name~="" and name~=" " and buyoutPrice>0 then
			local ItemLink=GetAuctionItemLink("list", index)
			local xianjiaV =buyoutPrice/count
			HCUI.auctionsLin[index]={name,xianjiaV,ItemLink,itemId}
		end
		au_SetValue()
	end
	local function AgainGetItem_G()
		if not HCUI:IsShown() then return end
		for k,v in pairs(HCUI.ItemLoadList) do
			local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice,bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo=GetAuctionItemInfo("list", k);
			if hasAllInfo then
				HCUI.zaicijishu=HCUI.zaicijishu+1
				SauctionsLinData(name,buyoutPrice,count,k,itemId)
				HCUI.ItemLoadList[k] = nil
				if HCUI.zaicijishu>=meiyenum then
					break
				end
			end
		end
		if next(HCUI.ItemLoadList) then
			HCUI.zaicijishu=0
			C_Timer.After(HCUI.ScanCD,AgainGetItem_G)
		else
			C_Timer.After(0.4,Save_Data_End)
		end
	end
	local function Update_GetItem_G(self,sss)
		if self.jishiqitime>HCUI.ScanCD then
			self.jishiqitime=0
			if HCUI.AuctionsNum==0 then
				self:Hide()
				Save_Data_End()
				return
			end
			local kaishi = HCUI.kaishi+1
			local jieshu = kaishi+meiyenum-1
			if jieshu>HCUI.AuctionsNum then
				jieshu = HCUI.AuctionsNum
			end
			HCUI.kaishi=jieshu
			for index=kaishi,jieshu do
				if HCUI.ItemLoadList[index] then
					local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice,bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo=GetAuctionItemInfo("list", index);
					if hasAllInfo then
						SauctionsLinData(name,buyoutPrice,count,index,itemId)
						HCUI.ItemLoadList[index] = nil
					end
				end
			end
			if jieshu>=HCUI.AuctionsNum then
				self:Hide()
				if next(HCUI.ItemLoadList) then
					HCUI.zaicijishu=0
					AgainGetItem_G()
				else
					Save_Data_End()
				end
			end
		else
			self.jishiqitime = self.jishiqitime + sss;
		end
	end
	local function Update_GetItems(self,sss)
		if self.jishiqitime>1 then
			self.jishiqitime=0		
			if HCUI.SMend then
				self:Hide()
				wipe(HCUI.auctions)
				wipe(HCUI.auctionsLin)
				wipe(HCUI.ItemLoadList)
				HCUI.jindu.tbiaoti:SetText("正在获取价格...");
				local AuctionsNum = GetNumAuctionItems("list");
				HCUI.jindu.t3:SetText(AuctionsNum);
				HCUI.jindu:SetMinMaxValues(0, AuctionsNum)
				for i=1,AuctionsNum do
					HCUI.ItemLoadList[i]=true
				end
				HCUI.AuctionsNum=AuctionsNum
				HCUI.ScanCD=BusinessInfo.AHPlusData.ScanCD*0.0001
				HCUI.UpdateF:HookScript("OnUpdate",Update_GetItem_G)
				self:Show()
			else
				local AuctionsNum = GetNumAuctionItems("list");
				HCUI.jindu.t2:SetText(AuctionsNum);
				HCUI.jindu.t3:SetText(AuctionsNum);
				local canQuery,canQueryAll = CanSendAuctionQuery()	
				if canQuery then
					HCUI.SMend=true
				end
			end
		else
			self.jishiqitime = self.jishiqitime + sss;
		end
	end
	AuctionFrameBrowse.History:HookScript("OnClick", function(self, button)
		self:Disable()
		BusinessInfo.DEL_OLDdata()
		AuctionFrameBrowse_Reset(BrowseResetButton)
		HCUI:Show();
		HCUI.close:Hide();
		HCUI.jindu.tbiaoti:SetText("正在扫描物品...");
		HCUI.jindu:SetMinMaxValues(0, 100)
		HCUI.jindu:SetValue(100);
		HCUI.jindu.t2:SetText(0);
		HCUI.jindu.t3:SetText(0);
		HCUI.jishuID = 0
		HCUI.AuctionsNum=0
		HCUI.kaishi=0
		HCUI.SMend=nil
		OpenScanFun(true)
		HCUI.UpdateF.jishiqitime=0
		HCUI.UpdateF:HookScript("OnUpdate",Update_GetItems)
		HCUI.UpdateF:Show()
		QueryAuctionItems("", nil, nil, 0, nil, nil, true, false, nil)--查询全部
	end)
	function HCUI.UiFameHide()
		HCUI.UpdateF:Hide()
		HCUI:Hide();
		HCUI.close:Hide();
		OpenScanFun(nil)
	end

	---时光徽章
	BrowseWowTokenResults.qushibut = PIGButton(BrowseWowTokenResults,{"CENTER",BrowseWowTokenResults,"CENTER",3,10},{80,24},"历史价格",nil,nil,nil,nil,0)
	BrowseWowTokenResults.qushibut:HookScript("OnClick",function(self)
		if BusinessInfo.StatsInfoUI then
			BusinessInfo.StatsInfoUI:TabShow(AuctionFrame)
		else
			PIG_OptionsUI:ErrorMsg("请打开"..addonName..SETTINGS.."→"..L["BUSINESS_TABNAME"].."→"..INFO..STATISTICS)
		end
	end)
	BrowseWowTokenResults:HookScript("OnShow",function(self)
		ShowHide_OT(false)
	end)
	BrowseWowTokenResults:HookScript("OnHide",function(self)
		ShowHide_OT(true)
	end)

	--关注------------------------
	local collW,collY,collFW = 22,22,200
	AuctionFrameBrowse.coll = CreateFrame("Button",nil,AuctionFrameBrowse);
	local coll=AuctionFrameBrowse.coll
	coll:SetSize(collW,collY);
	coll:SetPoint("TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",44,-36);
	coll.TexC = coll:CreateTexture(nil, "BORDER");
	coll.TexC:SetTexture("interface/common/friendship-heart.blp");
	coll.TexC:SetSize(collW*1.64,collY*1.5);
	coll.TexC:SetPoint("CENTER",coll,"CENTER",0,-2);
	coll:SetScript("OnMouseDown", function (self)
		self.TexC:SetPoint("CENTER",coll,"CENTER",1.5,-3.5);
	end);
	coll:SetScript("OnMouseUp", function (self)
		self.TexC:SetPoint("CENTER",coll,"CENTER",0,-2);
	end);
	coll:SetScript("OnClick", function (self)
		if self.list:IsShown() then
			self.list:Hide()
		else
			self.list:Show()
		end
	end);
	coll.list=PIGFrame(coll,{"TOPLEFT",AuctionFrameBrowse,"TOPRIGHT",72,-12},nil,nil,nil,nil,{["ElvUI"]={1,12,1,-9},["NDui"]={2,2,2,1}})
	coll.list:PIGSetPoint({"BOTTOMLEFT",AuctionFrameBrowse,"BOTTOMRIGHT",72,9})
	coll.list:SetWidth(collFW);
	coll.list:PIGSetBackdrop()
	coll.list:PIGClose()
	coll.list:Hide()
	coll.list:EnableMouse(true)
	coll.list:SetToplevel(true)
	coll.list.title = PIGFontString(coll.list,{"TOP", coll.list, "TOP", -2, -6},"关注列表","OUTLINE")
	coll.list.tishi = CreateFrame("Frame", nil, coll.list);
	coll.list.tishi:SetSize(20,20);
	coll.list.tishi:SetPoint("TOPLEFT",coll.list,"TOPLEFT",5,-5);
	coll.list.tishi.Texture = coll.list.tishi:CreateTexture(nil, "BORDER");
	coll.list.tishi.Texture:SetTexture("interface/common/help-i.blp");
	coll.list.tishi.Texture:SetSize(30,30);
	coll.list.tishi.Texture:SetPoint("CENTER");
	PIGEnter(coll.list.tishi,L["LIB_TIPS"]..": ","\124cff00ff001、在浏览列表"..KEY_BUTTON2.."物品名可加入关注。\n2、关注列表物品"..KEY_BUTTON1.."搜索，"..KEY_BUTTON2.."删除。\124r");
	--
	local collhang_NUM = 15
	local function gengxinlistcoll(self)
		for i = 1, collhang_NUM do
			coll.list.ButList[i]:Hide()
	    end
	    local datainfo=PIGA["AHPlus"]["Coll"]
		local zongshuNum=#datainfo
		if zongshuNum>0 then
			FauxScrollFrame_Update(self, zongshuNum, collhang_NUM, hang_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    for i = 1, collhang_NUM do
				local AHdangqianH = i+offset;
				if datainfo[AHdangqianH] then
					local listFGV = coll.list.ButList[i]
					listFGV:Show()
					listFGV.icon:SetTexture(datainfo[AHdangqianH][2])
					if PIGA["AHPlus"]["SimpleMode"] then
						listFGV.link:SetText('"'..datainfo[AHdangqianH][1]..'"')
					else
						listFGV.link:SetText(datainfo[AHdangqianH][1])
					end
					local r, g, b = GetItemQualityColor(datainfo[AHdangqianH][3])
					listFGV.link:SetTextColor(r, g, b, 1);
					listFGV:SetID(AHdangqianH);
				end
			end
		end
	end
	coll.list.Scroll = CreateFrame("ScrollFrame",nil,coll.list, "FauxScrollFrameTemplate");  
	coll.list.Scroll:SetPoint("TOPLEFT",coll.list,"TOPLEFT",0,-28);
	coll.list.Scroll:SetPoint("BOTTOMRIGHT",coll.list,"BOTTOMRIGHT",-22,4);
	coll.list.Scroll.ScrollBar:SetScale(0.8)
	coll.list.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinlistcoll)
	end)
	--创建行
	local collhang_Width =coll.list.Scroll:GetWidth()
	coll.list.ButList={}
	for i = 1, collhang_NUM do
		local colllistitem = CreateFrame("Button", nil, coll.list);
		coll.list.ButList[i]=colllistitem
		colllistitem:SetSize(collhang_Width, hang_Height);
		if i==1 then
			colllistitem:SetPoint("TOP",coll.list.Scroll,"TOP",5,0);
		else
			colllistitem:SetPoint("TOP",coll.list.ButList[i-1],"BOTTOM",0,-1.5);
		end
		colllistitem:RegisterForClicks("LeftButtonUp","RightButtonUp")
		colllistitem:Hide()
		colllistitem.xuanzhong = colllistitem:CreateTexture(nil, "BORDER");
		colllistitem.xuanzhong:SetTexture("interface/helpframe/helpframebutton-highlight.blp");
		colllistitem.xuanzhong:SetTexCoord(0.00,0.00,0.00,0.58,1.00,0.00,1.00,0.58);
		colllistitem.xuanzhong:SetAllPoints(colllistitem)
		colllistitem.xuanzhong:SetBlendMode("ADD")
		colllistitem.xuanzhong:Hide()
		if i~=collhang_NUM then
			colllistitem.line = colllistitem:CreateLine()
			colllistitem.line:SetColorTexture(1,1,1,0.2)
			colllistitem.line:SetThickness(1);
			colllistitem.line:SetStartPoint("BOTTOMLEFT",0,0)
			colllistitem.line:SetEndPoint("BOTTOMRIGHT",0,0)
		end
		colllistitem.icon = colllistitem:CreateTexture(nil, "BORDER");
		colllistitem.icon:SetSize(hang_Height-2,hang_Height-2);
		colllistitem.icon:SetPoint("LEFT", colllistitem, "LEFT", 0,0);
		if PIGA["AHPlus"]["SimpleMode"] then
			colllistitem.link =  CreateFrame("EditBox", nil, colllistitem, "InputBoxInstructionsTemplate");
			colllistitem.link:SetSize(colllistitem:GetWidth()-hang_Height-8,hang_Height);
			colllistitem.link:SetFontObject(ChatFontNormal);
			colllistitem.link:SetAutoFocus(false);
			colllistitem.link:SetPoint("LEFT", colllistitem.icon, "RIGHT", 8,0);
		else
			colllistitem.link = PIGFontString(colllistitem,{"LEFT", colllistitem.icon, "RIGHT", 0,0},nil,"OUTLINE",13)
			colllistitem.link:SetJustifyH("LEFT");
			colllistitem.link:SetWidth(colllistitem:GetWidth()-hang_Height);
		end
		-- 
		colllistitem:SetScript("OnEnter", function(self)
			self.xuanzhong:Show()
		end);
		colllistitem:SetScript("OnLeave", function(self)
			self.xuanzhong:Hide()
		end);
		colllistitem:SetScript("OnClick", function (self,button)
			local caozuoID = self:GetID()
			if button=="LeftButton" then
				if PIGA["AHPlus"]["SimpleMode"] then
					PIG_OptionsUI:ErrorMsg("当前处于"..SimpleModename..",手动输入搜索")
					return 
				end
				AuctionFrameBrowse_Reset(BrowseResetButton)
				local datakey=PIGA["AHPlus"]["Coll"][caozuoID][1]
				BrowseName:SetText('"'..datakey..'"')
				AuctionFrameBrowse_Search()
			else
				table.remove(PIGA["AHPlus"]["Coll"],caozuoID)
				gengxinlistcoll(coll.list.Scroll)
			end
		end);
	end
	coll.list:SetScript("OnShow", function (self)
		AuctionFrameBrowse.ShowHideOT.open=false
		ShowHide_OT(true)
		gengxinlistcoll(self.Scroll)
	end);
	function Funlist:Gengxinlistcoll()
		gengxinlistcoll(coll.list.Scroll)	
	end

	---拍卖页==============================
	AuctionFrameAuctions.SellList=PIGFrame(AuctionFrameAuctions,{"TOPLEFT",AuctionFrameAuctions,"TOPLEFT",216,-222},nil,nil,nil,nil,{["ElvUI"]={0,0,0,0},["NDui"]={0,0,0,0}})
	AuctionFrameAuctions.SellList:SetPoint("BOTTOMRIGHT",AuctionFrameAuctions,"BOTTOMRIGHT",66,38);
	AuctionFrameAuctions.SellList:PIGSetBackdrop(1)
	AuctionFrameAuctions.SellList:PIGClose()
	local SellListF=AuctionFrameAuctions.SellList
	SellListF:SetFrameLevel(10)
	SellListF:EnableMouse(true)
	SellListF:Hide()

	--堆叠数量
	AuctionsStackSizeEntry:ClearAllPoints();
	AuctionsStackSizeEntry:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",33,-154);
	AuctionsStackSizeMaxButton:SetWidth(40);
	AuctionsStackSizeMaxButton:SetPoint("LEFT",AuctionsStackSizeEntry,"RIGHT",-10,0);
	--堆叠组数
	AuctionsNumStacksEntry:ClearAllPoints();
	AuctionsNumStacksEntry:SetPoint("LEFT",AuctionsStackSizeEntry,"RIGHT",40,0);
	AuctionsNumStacksMaxButton:SetWidth(40);
	AuctionsNumStacksMaxButton:SetPoint("LEFT",AuctionsNumStacksEntry,"RIGHT",-10,0);
	AuctionsStackSizeEntry:HookScript("OnCursorChanged", function (self)
		SellListF:SetAHPriceFun()
	end);
	--每个/每组
	if not PriceDropDown then
		AuctionFrameAuctions.priceType=1
		local xialaDropDown = CreateFrame("Frame", "PriceDropDown", AuctionFrameAuctions,"UIDropDownMenuTemplate");
		xialaDropDown:ClearAllPoints();
		xialaDropDown:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",70,-174);
		local function xialaDropDown_OnClick(self)
			if ( AuctionFrameAuctions.priceType ~= self.value ) then
				AuctionFrameAuctions.priceType = self.value;
				UIDropDownMenu_SetSelectedValue(xialaDropDown, self.value);
				SellListF:SetAHPriceFun()
			end
		end
		local function xialaDropDown_Initialize()
			local info = UIDropDownMenu_CreateInfo();
			info.text = AUCTION_PRICE_PER_ITEM;
			info.value = 1;
			info.checked =AuctionFrameAuctions.priceType==1;
			info.func = xialaDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
			info.text = AUCTION_PRICE_PER_STACK;
			info.value = 2;
			info.checked = AuctionFrameAuctions.priceType==2;
			info.func = xialaDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_Initialize(xialaDropDown, xialaDropDown_Initialize);
		xialaDropDown:SetScript("OnShow", function (self)
			UIDropDownMenu_SetSelectedValue(self, AuctionFrameAuctions.priceType);
		end);
	end
	UIDropDownMenu_SetWidth(PriceDropDown, 100)
	PriceDropDown:ClearAllPoints();
	PriceDropDown:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",70,-174);
	--价格
	StartPrice:ClearAllPoints();
	StartPrice:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",33,-214);
	BuyoutPrice:ClearAllPoints();
	BuyoutPrice:SetPoint("TOPLEFT",StartPrice,"BOTTOMLEFT",0,-20);
	--错误提示
	AuctionsBuyoutErrorText:ClearAllPoints();
	AuctionsBuyoutErrorText:SetPoint("TOPLEFT",BuyoutPrice,"BOTTOMLEFT",-15,-4);
	--时限
	AuctionsDurationText:ClearAllPoints();
	AuctionsDurationText:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",28,-310);
	AuctionsShortAuctionButton:ClearAllPoints();
	AuctionsShortAuctionButton:SetPoint("TOPLEFT",AuctionsDurationText,"BOTTOMLEFT",-8,0);
	AuctionsShortAuctionButton:SetHitRectInsets(0,-36,0,0);
	AuctionsShortAuctionButtonText:SetPoint("LEFT",AuctionsShortAuctionButton,"RIGHT",0,0);
	AuctionsMediumAuctionButton:ClearAllPoints();
	AuctionsMediumAuctionButton:SetPoint("LEFT",AuctionsShortAuctionButtonText,"RIGHT",0,0);
	AuctionsMediumAuctionButton:SetHitRectInsets(0,-36,0,0);
	AuctionsMediumAuctionButtonText:SetPoint("LEFT",AuctionsMediumAuctionButton,"RIGHT",0,0);
	AuctionsLongAuctionButton:ClearAllPoints();
	AuctionsLongAuctionButton:SetPoint("LEFT",AuctionsMediumAuctionButtonText,"RIGHT",0,0);
	AuctionsLongAuctionButton:SetHitRectInsets(0,-36,0,0);
	AuctionsLongAuctionButtonText:SetPoint("LEFT",AuctionsLongAuctionButton,"RIGHT",0,0);
	--压价按钮
	AuctionFrameAuctions.autoya =PIGCheckbutton(AuctionFrameAuctions,{"TOPLEFT",AuctionFrameAuctions,"TOPLEFT",24,-286},{"自动压","选中后拍卖物品时将根据现售最低价自动压价"},nil,nil,nil,0)
	AuctionFrameAuctions.autoya.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameAuctions.autoya:SetChecked(PIGA["AHPlus"]["autoya"])
	AuctionFrameAuctions.autoya:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["autoya"]=true
		else
			PIGA["AHPlus"]["autoya"]=false
		end
	end);
	AuctionFrameAuctions.yajingbiao =PIGCheckbutton(AuctionFrameAuctions,{"LEFT",AuctionFrameAuctions.autoya.Text,"RIGHT",1,0},{"压竞标","选中后压一口价同时压竞标价"},nil,nil,nil,0)
	AuctionFrameAuctions.yajingbiao.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameAuctions.yajingbiao:SetChecked(PIGA["AHPlus"]["yajingbiao"])
	AuctionFrameAuctions.yajingbiao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["yajingbiao"]=true
		else
			PIGA["AHPlus"]["yajingbiao"]=false
		end
	end);
	AuctionFrameAuctions.Showcankao = PIGButton(AuctionFrameAuctions,{"LEFT",AuctionFrameAuctions.yajingbiao.Text,"RIGHT",1,0},{46,20},"在售",nil,nil,nil,nil,0)
	AuctionFrameAuctions.Showcankao:SetScript("OnClick", function (self)
		if SellListF:IsShown() then
			SellListF:Hide()
		else
			SellListF:Show()
		end
	end);
	--默认堆叠数
	local StackingLsit={0,1,5,10,15,20}
	AuctionFrameAuctions.Stacking=PIGDownMenu(AuctionFrameAuctions,{"BOTTOMLEFT",AuctionFrameAuctions,"BOTTOMLEFT",210,15},{156,20})
	function AuctionFrameAuctions.Stacking:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#StackingLsit,1 do
			if StackingLsit[i]==0 then
				info.text, info.arg1 = self.GetStackingName(StackingLsit[i]), StackingLsit[i]
		   		info.checked = not PIGA["AHPlus"]["Stacking"] and true
			else
		   		info.text, info.arg1 = self.GetStackingName(StackingLsit[i]), StackingLsit[i]
		   		info.checked = StackingLsit[i]==PIGA["AHPlus"]["Stacking"]
		   	end
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function AuctionFrameAuctions.Stacking:PIGDownMenu_SetValue(value,arg1)
		self:PIGDownMenu_SetText(self.GetStackingName(arg1))
		PIGA["AHPlus"]["Stacking"]=arg1
		PIGCloseDropDownMenus()
	end
	function AuctionFrameAuctions.Stacking.GetStackingName(id)
		local id=id or PIGA["AHPlus"]["Stacking"] or 0
		if id==0 then
			return "拍卖堆叠：默认"
		else
			return "拍卖堆叠："..id
		end
	end
	AuctionFrameAuctions.Stacking:PIGDownMenu_SetText(AuctionFrameAuctions.Stacking.GetStackingName())

	AuctionFrameAuctions.oldaucG =PIGCheckbutton(AuctionFrameAuctions,{"LEFT",AuctionFrameAuctions.Stacking,"RIGHT",8,0},{"记住本次拍卖价格","本次卖出相同物品使用前一次设置拍卖价格,而不是压已有的最低价。\n(只在本次打开拍卖界面期间生效)"},nil,nil,nil,0)
	if ElvUI and AuctionFrame.backdrop then
		AuctionFrameAuctions.oldaucG:SetPoint("BOTTOMLEFT",AuctionFrameAuctions,"BOTTOMLEFT",230,9);
	end
	AuctionFrameAuctions.oldaucG.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameAuctions.oldaucG:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["oldaucG"]=true
		else
			PIGA["AHPlus"]["oldaucG"]=false
		end
	end);
	AuctionsCreateAuctionButton:HookScript("OnUpdate", function(self)
		local canQuery,canQueryAll = CanSendAuctionQuery()
		if canQuery then
			self:Enable()
		else
			self:Disable()
		end
	end)
	AuctionFrameAuctions.DurationCheck =PIGCheckbutton(AuctionFrameAuctions,{"LEFT",AuctionFrameAuctions.oldaucG.Text,"RIGHT",4,0},{SAVE..AUCTION_DURATION,SAVE..AUCTION_DURATION..SETTINGS},nil,nil,nil,0)
	AuctionFrameAuctions.DurationCheck.Text:SetTextColor(0, 1, 0, 0.8);
	if ElvUI and AuctionFrame.backdrop then
		AuctionFrameAuctions.DurationCheck:SetPoint("BOTTOMLEFT",AuctionFrameAuctions,"BOTTOMLEFT",380,9);
	end
	AuctionFrameAuctions.DurationCheck:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["SaveDuration"]=true
			PIGA["AHPlus"]["SaveDuration_V"]=AuctionFrameAuctions.duration
		else
			PIGA["AHPlus"]["SaveDuration"]=false
		end
	end);
	if PIGA["AHPlus"]["SaveDuration"] then AuctionsRadioButton_OnClick(PIGA["AHPlus"]["SaveDuration_V"]) end
	hooksecurefunc("AuctionsRadioButton_OnClick", function(id)
		if PIGA["AHPlus"]["SaveDuration"] then PIGA["AHPlus"]["SaveDuration_V"]=AuctionFrameAuctions.duration end
	end)
	AuctionsCreateAuctionButton:HookScript("OnClick", function(self)
		if AuctionsItemButton.OldName then
			AuctionsItemButton.OldGlist[AuctionsItemButton.OldName]={LAST_ITEM_START_BID,LAST_ITEM_BUYOUT}
			AuctionsItemButton.OldName=nil
		end
	end);
	--
	SellListF.tishibut = PIGButton(SellListF,{"CENTER", SellListF, "CENTER", 0,10},{80,24},LFG_LIST_SEARCH_AGAIN,nil,nil,nil,nil,0)
	SellListF.tishibut_txt = PIGFontString(SellListF,{"BOTTOM", SellListF.tishibut, "TOP", 0,8},nil,"OUTLINE")
	--
	local spellhangnum, hang_Height1= 5,hang_Height+4
	local SellxulieID = {"",ACTION_SPELL_AURA_APPLIED_DOSE,biaotiLsitName[4],biaotiLsitName[5],AH_TIME,AUCTION_CREATOR}
	local SellxulieID_www = {40,42,170,150,80,118}
	SellListF.ButListBiaoti={}
	for i=1,#SellxulieID do
		local Buttonxx = CreateFrame("Button",nil,SellListF);
		SellListF.ButListBiaoti[i]=Buttonxx
		Buttonxx:SetSize(SellxulieID_www[i],anniuH);
		if i==1 then
			Buttonxx:SetPoint("TOPLEFT",SellListF,"TOPLEFT",3,-3);
		else
			Buttonxx:SetPoint("LEFT",SellListF.ButListBiaoti[i-1],"RIGHT",0,0);
		end
		if ElvUI and AuctionFrame.backdrop or NDui then
		else
			Buttonxx.TexC = Buttonxx:CreateTexture(nil, "BORDER");
			Buttonxx.TexC:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
			Buttonxx.TexC:SetTexCoord(0.08,0.00,0.08,0.59,0.91,0.00,0.91,0.59);
			Buttonxx.TexC:SetPoint("TOPLEFT",Buttonxx,"TOPLEFT",2,0);
			Buttonxx.TexC:SetPoint("BOTTOMRIGHT",Buttonxx,"BOTTOMRIGHT",-0.8,0);
			Buttonxx.TexL = Buttonxx:CreateTexture(nil, "BORDER");
			Buttonxx.TexL:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
			Buttonxx.TexL:SetTexCoord(0.00,0.00,0.00,0.59,0.08,0.00,0.08,0.59);
			Buttonxx.TexL:SetPoint("TOPRIGHT",Buttonxx.TexC,"TOPLEFT",0,0);
			Buttonxx.TexL:SetPoint("BOTTOMRIGHT",Buttonxx.TexC,"BOTTOMLEFT",0,0);
			Buttonxx.TexL:SetWidth(2)
			Buttonxx.TexR = Buttonxx:CreateTexture(nil, "BORDER");
			Buttonxx.TexR:SetTexture("interface/friendsframe/whoframe-columntabs.blp");
			Buttonxx.TexR:SetTexCoord(0.91,0.00,0.91,0.59,0.97,0.00,0.97,0.59);
			Buttonxx.TexR:SetPoint("TOPLEFT",Buttonxx.TexC,"TOPRIGHT",0,0);
			Buttonxx.TexR:SetPoint("BOTTOMLEFT",Buttonxx.TexC,"BOTTOMRIGHT",0,0);
			Buttonxx.TexR:SetWidth(2)
		end
		Buttonxx.title = PIGFontString(Buttonxx)
		Buttonxx.title:SetText(SellxulieID[i]);
		Buttonxx.title:SetTextColor(1, 1, 1, 1)
		if i>2 and i<6 then
			Buttonxx.title:SetPoint("RIGHT", Buttonxx, "RIGHT", -8, 0);
		else
			Buttonxx.title:SetPoint("LEFT", Buttonxx, "LEFT", 6, 0);
		end
	end
	local hang_Width1 =SellListF:GetWidth()-10
	SellListF.ButList={}
	for i = 1, spellhangnum do
		local listFitem = CreateFrame("Button", nil, SellListF);
		SellListF.ButList[i]=listFitem
		listFitem:SetSize(hang_Width1, hang_Height1);
		if i==1 then
			listFitem:SetPoint("TOP",SellListF,"TOP",0,-28);
		else
			listFitem:SetPoint("TOP",SellListF.ButList[i-1],"BOTTOM",0,-2);
		end
		listFitem:Hide()
		listFitem.line = listFitem:CreateLine()
		listFitem.line:SetColorTexture(1,1,1,0.2)
		listFitem.line:SetThickness(1);
		listFitem.line:SetStartPoint("TOPLEFT",0,0)
		listFitem.line:SetEndPoint("TOPRIGHT",0,0)
		listFitem.yajia = PIGButton(listFitem,{"LEFT", listFitem, "LEFT", 0,0},{SellxulieID_www[1],22},"压",nil,nil,nil,nil,0)
		listFitem.yajia:SetScript("OnClick", function(self, button)
			SellListF.BidV=self.hang_minBid
		   	SellListF.buyoutV=self.hang_buyoutPrice
		   	SellListF.ownerV=self.hang_owner
			SellListF:SetAHPriceFun()
		end)
		---
		listFitem.count = PIGFontString(listFitem,{"LEFT", listFitem.yajia, "RIGHT", 0,0},nil,"OUTLINE",13)
		listFitem.count:SetWidth(SellxulieID_www[2]);
		listFitem.count:SetTextColor(0, 1, 1, 1);
		--
		listFitem.biddanjia=Add_GGGF(listFitem,listFitem.count,SellxulieID_www[3],hang_Height1,{1, 1, 1, 1})
		listFitem.yikoudanjia=Add_GGGF(listFitem,listFitem.biddanjia,SellxulieID_www[4],hang_Height1,{0, 1, 1, 1})
		---
		listFitem.TimeLeft = PIGFontString(listFitem,{"LEFT", listFitem.yikoudanjia, "RIGHT", 0,0},nil,"OUTLINE",13)
		listFitem.TimeLeft:SetWidth(SellxulieID_www[5]);
		--
		listFitem.chushouzhe = PIGFontString(listFitem,{"LEFT", listFitem.TimeLeft, "RIGHT", 2,0},nil,"OUTLINE",13)
		listFitem.chushouzhe:SetWidth(SellxulieID_www[6]);
		listFitem.chushouzhe:SetJustifyH("LEFT");
	end
	function SellListF:SetAHPriceFun()
		local BiddanjiaGG
		local buyoutdanjiaGG
		local jianshaozhiV = 1
		local oldname=GetAuctionSellItemInfo()
		if PIGA["AHPlus"]["oldaucG"] and AuctionsItemButton.OldGlist[oldname] then
			BiddanjiaGG=AuctionsItemButton.OldGlist[oldname][1]
			buyoutdanjiaGG=AuctionsItemButton.OldGlist[oldname][2]
			jianshaozhiV=0
		else
			if oldname==SellListF.oldname then
				BiddanjiaGG=self.BidV
				buyoutdanjiaGG=self.buyoutV
			end
		end
		if not BiddanjiaGG or not buyoutdanjiaGG then return end
		if self.owner==PIG_OptionsUI.Name then jianshaozhiV=0 end
		local StackSize = AuctionsStackSizeEntry:GetNumber()
		local NumStacks = AuctionsNumStacksEntry:GetNumber()
		local priceType =UIDropDownMenu_GetSelectedValue(PriceDropDown)
		if ( StackSize >= 0 ) then
			if priceType == 1 then
				local BiddanjiaGG = math.floor(BiddanjiaGG+0.5)-jianshaozhiV
				local buyoutdanjiaGG = math.floor(buyoutdanjiaGG+0.5)-jianshaozhiV
				if PIGA["AHPlus"]["yajingbiao"] and BiddanjiaGG>0 then
					MoneyInputFrame_SetCopper(StartPrice, BiddanjiaGG);
				else
					MoneyInputFrame_SetCopper(StartPrice, buyoutdanjiaGG);
				end
				MoneyInputFrame_SetCopper(BuyoutPrice, buyoutdanjiaGG);
			else
				local ZBiddanjiaGG = StackSize*BiddanjiaGG
				local ZbuyoutdanjiaGG = StackSize*buyoutdanjiaGG
				local ZBiddanjiaGG = math.floor(ZBiddanjiaGG)-jianshaozhiV
				local ZbuyoutdanjiaGG = math.floor(ZbuyoutdanjiaGG)-jianshaozhiV
				if PIGA["AHPlus"]["yajingbiao"] and ZBiddanjiaGG>0 then
					MoneyInputFrame_SetCopper(StartPrice, ZBiddanjiaGG);
				else
					MoneyInputFrame_SetCopper(StartPrice, ZbuyoutdanjiaGG);
				end
				MoneyInputFrame_SetCopper(BuyoutPrice, ZbuyoutdanjiaGG);
			end
			UpdateDeposit()
		end
	end
	local function CZ_BrowseSearchButton()
		if PIGA["AHPlus"]["SimpleMode"] then
			if AuctionFrame.selectedTab==3 then
				BrowseSearchButton:SetParent(SellListF)
				BrowseSearchButton:ClearAllPoints();
			else
				BrowseSearchButton:SetParent(AuctionFrameBrowse)
				BrowseSearchButton:ClearAllPoints();
				BrowseSearchButton:SetPoint("LEFT",BrowseName,"RIGHT",4,0);
			end
		end
	end
	local function Query_Search(name)
		if not name then return end
		AuctionsItemButton.IsSearchOK=true
		SortAuctionSetSort("list","unitprice", false)
		AuctionFrameBrowse_Reset(BrowseResetButton)
		local name=name or AuctionsItemButton.OldName
		BrowseName:SetText('"'..name..'"')
		AuctionFrameBrowse_Search()
		if SellListF.ahTicker then SellListF.ahTicker:Cancel() end
		SellListF.ahTicker=C_Timer.NewTimer(5,function()
			if AuctionsItemButton.IsSearchOK then
				SellListF.tishibut_txt:SetText(LFG_LIST_SEARCH_FAILED);
				if not PIGA["AHPlus"]["SimpleMode"] then
					SellListF.tishibut:Show()
				end	
			end
		end)
	end
	local function ClearSearchList(name)
		local name=name or GetAuctionSellItemInfo()
		SellListF.tishibut:Hide()
		CZ_BrowseSearchButton()
		if name then
			if PIGA["AHPlus"]["oldaucG"] and AuctionsItemButton.OldGlist[name] then
				SellListF.tishibut_txt:SetText("<"..name..">使用上次拍卖价格，本次不搜索/压价")
				SellListF:SetAHPriceFun()
			else
				if PIGA["AHPlus"]["SimpleMode"] then
					if '"'..name..'"'==BrowseName:GetText() then
						SellListF.tishibut_txt:SetText("点击搜索并压价")
						BrowseSearchButton:SetPoint("CENTER", SellListF, "CENTER", 0,10);
					else
						ClickAuctionSellItemButton(AuctionsItemButton, "LeftButton");
						ClearCursor();
						SellListF.tishibut_txt:SetText("|cffFF0000当前处于"..SimpleModename.."\n按住Shift左键点击物品|r")
					end
				else
					SellListF.tishibut_txt:SetText(SEARCHING);
					Query_Search(name)
				end
			end
		else
			SellListF.tishibut_txt:SetText("没有放入拍卖物品！") 
		end
		for i = 1, spellhangnum do
		   	local listFGV = SellListF.ButList[i]
		   	listFGV:Hide()
		   	listFGV.yajia.hang_count=nil
			listFGV.yajia.hang_minBid=nil
			listFGV.yajia.hang_buyoutPrice=nil
		end
		SellListF:Show()
	end
	SellListF.tishibut:SetScript("OnClick", function (self)
		ClearSearchList()
	end);
	SellListF:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	SellListF:HookScript("OnEvent",function(self,event,arg1,arg2)
		AuctionsItemButton.IsSearchOK=nil
		if AuctionsItemButton:IsShown() then
			local danqianitem = GetAuctionSellItemInfo();
			local numBatchAuctions = GetNumAuctionItems("list");
			if numBatchAuctions>0 then
				CZ_BrowseSearchButton()
				for i = 1, spellhangnum do
					local listFGV = SellListF.ButList[i]
					local name, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, owner =  GetAuctionItemInfo("list", i);
					if danqianitem~=name then return end
					local BiddanjiaGG = minBid/count
					local buyoutdanjiaGG = buyoutPrice/count
					if i==1 then
						SellListF.tishibut_txt:SetText("");
			   			if PIGA["AHPlus"]["autoya"] or PIGA["AHPlus"]["SimpleMode"] then
			   				SellListF.oldname=name
							SellListF.BidV=BiddanjiaGG
				   			SellListF.buyoutV=buyoutdanjiaGG
				   			SellListF.ownerV=owner
			   				SellListF:SetAHPriceFun() 
			   			end
			   		end
					listFGV.yajia.hang_minBid=BiddanjiaGG
					listFGV.yajia.hang_buyoutPrice=buyoutdanjiaGG
					listFGV.yajia.hang_owner=owner
			   		Update_GGG(listFGV.biddanjia,BiddanjiaGG)
					Update_GGG(listFGV.yikoudanjia,buyoutdanjiaGG)
					listFGV.count:SetText(count);
					listFGV.chushouzhe:SetText(owner);
					local timeleft = GetAuctionItemTimeLeft("list", i)
					listFGV.TimeLeft:SetText(shengyuTime[timeleft]);
					listFGV:Show()
				end
			else
				if not PIGA["AHPlus"]["SimpleMode"] then SellListF.tishibut:Show() end
				SellListF.tishibut_txt:SetText(BROWSE_NO_RESULTS);
			end
		end
	end)
	-----------
	if PIGA["AHPlus"]["SimpleMode"] then
		AuctionFrame.bagitemtxt = PIGFontString(AuctionFrame,nil,"背包物品(按住Shift左键点击)","OUTLINE",nil,nil,"OVERLAY")
		AuctionFrame.bagitemtxt:SetTextColor(1, 1, 0, 1)
		local RuiD={
			meihang=5,
			topoffV=-30,
			leftoffV=0,
			jiangeV=-22,
			ActionW = 30,
			hangNum=0,
			classCount=0,
		}
		AuctionFrame.dianjilaiyuan=nil
		AuctionFrame.sellItemBut={}
		AuctionFrame.className={}
		AuctionFrame.classBiaoti={}
		AuctionFrame.classData={}
		AuctionFrame.classYes={}
		local bagitemindex=0
		local bagIDMax= addonTable.Data.bagData["bagIDMax"]
		local function RegisterClickFun(itemButton)
			itemButton:HookScript("PreClick",  function (self,button)
				if IsShiftKeyDown() then
					AuctionFrame.dianjilaiyuan=AuctionFrame.selectedTab
					local itemID=PIGGetContainerItemInfo(self:GetParent():GetID(), self:GetID())
					if itemID then
						if IsAddOnLoaded("Blizzard_AuctionUI") then AuctionFrameTab_OnClick(AuctionFrameTab1) end
					end
				end
			end);
			itemButton:HookScript("PostClick",  function (self,button)
				if IsShiftKeyDown() then
					if AuctionFrame.dianjilaiyuan and AuctionFrame.dianjilaiyuan==3 then
						AuctionFrame.dianjilaiyuan=nil
						local itemID=PIGGetContainerItemInfo(self:GetParent():GetID(), self:GetID())
						if itemID then
							if IsAddOnLoaded("Blizzard_AuctionUI") then
								AuctionFrameTab_OnClick(AuctionFrameTab3)
								C_Container.UseContainerItem(self:GetParent():GetID(), self:GetID(), nil, nil, BankFrame:IsShown() and (BankFrame.selectedTab == 2));
							end
						end
					end
				else
					ClearCursor();
				end
			end);
			itemButton:HookScript("OnMouseUp", function(self, button)
				if button== "LeftButton" and IsModifiedClick() then
					--ContainerFrameItemButton_OnModifiedClick(self, button);
				else
					PIG_OptionsUI:ErrorMsg("按住Shift左键点击")
				end
			end)
		end
		for bag=0,bagIDMax do
			local BagFf = CreateFrame("Frame",nil,AuctionFrame)
			BagFf:SetID(bag)
			BagFf:RegisterEvent("ITEM_LOCK_CHANGED");
			BagFf:SetScript("OnEvent", function(self,event,bag, slot)
				if ( bag and slot and (bag == self:GetID()) ) then
					for ixx=1,#AuctionFrame.sellItemBut do
						local ItemButID=AuctionFrame.sellItemBut[ixx]
						if ItemButID:GetID()==slot then
							local info = C_Container.GetContainerItemInfo(self:GetID(), ItemButID:GetID());
							local locked = info and info.isLocked;
							SetItemButtonDesaturated(ItemButID,locked);
						end
					end			
				end
			end)		
			for slot=1,36 do
				bagitemindex=bagitemindex+1
				local itembutx = CreateFrame("Button","PIG_AuctionFrameRitem"..bagitemindex, BagFf, "ContainerFrameItemButtonTemplate",slot);
				AuctionFrame.sellItemBut[bagitemindex]=itembutx
				RuiD.ActionW = itembutx:GetWidth()+2
				if NDui or ElvUI then
					itembutx.icon:SetTexCoord(0.1,0.9,0.1,0.9)
					if itembutx.IconBorder then itembutx.IconBorder:SetAlpha(0) end
				end
				local NormalTexture = _G[itembutx:GetName().."NormalTexture"]
				if NormalTexture then NormalTexture:SetTexture("") end
				if itembutx.BattlepayItemTexture then itembutx.BattlepayItemTexture:SetTexture("") end
				itembutx:RegisterForClicks("LeftButtonUp")
				RegisterClickFun(itembutx)
			end
		end
		local function Update_AllBag(fujik)
			if fujik==AuctionFrameBid or fujik==AuctionFrameBrowse and not PIGA["AHPlus"]["SimpleModeBrowseBag"] then
				for _,itemButton in pairs(AuctionFrame.sellItemBut) do
					itemButton:ClearAllPoints();
				end
				for _,Biaoti in pairs(AuctionFrame.classBiaoti) do
					Biaoti:ClearAllPoints();
				end
				AuctionFrame.bagitemtxt:ClearAllPoints();
				return
			end
			if fujik==AuctionFrameBrowse then
				RuiD.leftoffV=collFW
			else
				RuiD.leftoffV=0
			end
			AuctionFrame.bagitemtxt:SetPoint("BOTTOMLEFT", AuctionFrame, "TOPRIGHT", RuiD.leftoffV+8,-6);
			wipe(AuctionFrame.classData)
			wipe(AuctionFrame.classYes)
			for index,itemButton in pairs(AuctionFrame.sellItemBut) do
				itemButton:Show()
				itemButton:ClearAllPoints();
				local itemID, itemLink, texture, itemCount, quality, noValue, lootable, locked, isBound=PIGGetContainerItemInfo(itemButton:GetParent():GetID(), itemButton:GetID())
				if itemID and not isBound then
					--local sellPrice= select(11, C_Item.GetItemInfo(itemID))
					SetItemButtonTexture(itemButton, texture);
					SetItemButtonQuality(itemButton, quality, itemID);
					SetItemButtonCount(itemButton, itemCount);
					SetItemButtonDesaturated(itemButton, locked);
					local _, itemType, itemSubType, _, _, classID, subClassID=C_Item.GetItemInfoInstant(itemID)
					if not AuctionFrame.classYes[itemID] then
						AuctionFrame.classYes[itemID]=true
						if not AuctionFrame.classData[classID] then
							AuctionFrame.className[classID]=itemType
							AuctionFrame.classData[classID]={}
						end
						table.insert(AuctionFrame.classData[classID],itemButton)
					end
				end
			end
			RuiD.hangNum,RuiD.classCount=0,0
			for classID,items in pairs(AuctionFrame.classData) do
				if not AuctionFrame.classBiaoti[classID] then
					AuctionFrame.classBiaoti[classID] = PIGFontString(AuctionFrame,nil,AuctionFrame.className[classID],"OUTLINE",nil,nil,"OVERLAY")
					AuctionFrame.classBiaoti[classID]:SetTextColor(0, 1, 0, 1)
				end
				RuiD.classCount=RuiD.classCount+1
				AuctionFrame.classBiaoti[classID]:ClearAllPoints();
				AuctionFrame.classBiaoti[classID]:SetPoint("TOPLEFT", AuctionFrame, "TOPRIGHT", RuiD.leftoffV,RuiD.jiangeV*(RuiD.classCount-1)-(RuiD.hangNum*RuiD.ActionW)-14);
				RuiD.classindex=0
				for id=1,#items do
					if id==1 then
						RuiD.hangNum=RuiD.hangNum+1
						items[id]:SetPoint("TOPLEFT",AuctionFrame.classBiaoti[classID],"BOTTOMLEFT",0,-2)
					else
						local tmp1,tmp2 = math.modf((id-1)/RuiD.meihang)
						if tmp2==0 then
							RuiD.hangNum=RuiD.hangNum+1
							items[id]:SetPoint("TOPLEFT",items[id-RuiD.meihang],"BOTTOMLEFT",0,0)
						else
							items[id]:SetPoint("LEFT",items[id-1],"RIGHT",0,0)
						end
					end
				end
			end
		end
		AuctionFrameBrowse.SimpleModeBrowseBag =PIGCheckbutton(AuctionFrameBrowse,{"LEFT",AuctionFrame.SimpleMode.Text,"RIGHT",8,0},{"显示背包物品","在浏览页也显示背包物品"},nil,nil,nil,0)
		AuctionFrameBrowse.SimpleModeBrowseBag.Text:SetTextColor(0, 1, 1, 0.8);
		AuctionFrameBrowse.SimpleModeBrowseBag:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["AHPlus"]["SimpleModeBrowseBag"]=true
			else
				PIGA["AHPlus"]["SimpleModeBrowseBag"]=nil
			end
			Update_AllBag(AuctionFrameBrowse)
		end);
		AuctionFrameBrowse:HookScript("OnShow",function(self)
			AuctionFrame.SimpleMode:SetChecked(PIGA["AHPlus"]["SimpleMode"])
			self.SimpleModeBrowseBag:SetChecked(PIGA["AHPlus"]["SimpleModeBrowseBag"])
			CZ_BrowseSearchButton()
			Update_AllBag(self)
		end)
		AuctionFrameBid:HookScript("OnShow",function(self)
			Update_AllBag(self)
		end)
		AuctionFrameAuctions:HookScript("OnShow",function(self)
			Update_AllBag(self)
		end)
	end
	----
	AuctionsItemButton:HookScript("OnEvent",function(self,event,arg1,arg2)
		if event=="NEW_AUCTION_UPDATE" then
			AuctionsItemButtonCount:Hide();
			AuctionsStackSizeEntry:Hide();
			AuctionsStackSizeMaxButton:Hide();
			AuctionsNumStacksEntry:Hide();
			AuctionsNumStacksMaxButton:Hide();
			PriceDropDown:Hide();
			local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
			if (C_WowTokenPublic.IsAuctionableWowToken(itemID)) then
			else
				if ( totalCount > 1 ) then
					if PIGA["AHPlus"]["Stacking"] and PIGA["AHPlus"]["Stacking"]>0 and totalCount>=PIGA["AHPlus"]["Stacking"] then
						AuctionsStackSizeEntry:SetText(PIGA["AHPlus"]["Stacking"]);
					end
					AuctionsStackSizeEntry:Show();
					AuctionsStackSizeMaxButton:Show();
					AuctionsNumStacksEntry:Show();
					AuctionsNumStacksMaxButton:Show();
					PriceDropDown:Show();
					UpdateMaximumButtons();
				end
			end
			if name then
				AuctionsItemButton.OldName=name
			end
			ClearSearchList(name)
		end
	end)
	--浏览页
	AuctionFrameBrowse:HookScript("OnShow",function(self)
		self.exact:SetChecked(PIGA["AHPlus"]["exactMatch"])
		self.coll.list:Show()
		HCUI.UiFameHide()
	end)
	AuctionFrameBrowse:HookScript("OnHide",HCUI.UiFameHide)
	--拍卖页
	AuctionFrameAuctions:HookScript("OnShow",function(self)
		self.oldaucG:SetChecked(PIGA["AHPlus"]["oldaucG"])
		self.DurationCheck:SetChecked(PIGA["AHPlus"]["SaveDuration"])
		ClearSearchList()
	end)

	--打开拍卖隐藏姓名版相关========
	local CVarName={
		["UnitNameNPC"]="0",
		["nameplateShowOnlyNames"]="1",
		["nameplateShowFriends"]="0",
		["UnitNameFriendlyPlayerName"]="0",
		["UnitNameFriendlyPetName"]="0",
		["UnitNameFriendlyGuardianName"]="0",
		["UnitNameFriendlyTotemName"]="0",
		["UnitNameFriendlyMinionName"]="0",
	}	
	local OLD_CVarName={}
	local function TradeSkill_Show()
		if PIGA["AHPlus"]["AHUIoff"] then
			if TradeSkillFrame and TradeSkillFrame:IsShown() then
				UIPanelWindows[TradeSkillFrame].width = 20
			end
			if CraftFrame and CraftFrame:IsShown() then
				UIPanelWindows[CraftFrame].width = 20
			end
		end
	end
	local function TradeSkill_Hide()
		if PIGA["AHPlus"]["AHUIoff"] then
			if TradeSkillFrame and TradeSkillFrame:IsShown() then
				UIPanelWindows[TradeSkillFrame].width = 713
			end
			if CraftFrame and CraftFrame:IsShown() then
				UIPanelWindows[CraftFrame].width = 713
			end
		end
	end
	AuctionFrame:HookScript("OnShow",function(self)
		for k,v in pairs(CVarName) do
			local OLDcannn = GetCVar(k)
			if OLDcannn then
				OLD_CVarName[k]=OLDcannn
			end
		end
		for k,v in pairs(CVarName) do
			SetCVar(k, v)
		end
		SortAuctionSetSort("list","unitprice", false)
		SetSelectedAuctionItem("list", 0);
		AuctionsItemButton.OldGlist={}
		TradeSkill_Show()
	end)
	AuctionFrame:HookScript("OnHide", function(self)
		AuctionsItemButton.OldName=nil
		for k,v in pairs(OLD_CVarName) do
			SetCVar(k, v)
		end
		TradeSkill_Hide()
	end);
end