local addonName, addonTable = ...;
local gsub = _G.string.gsub
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGButton=Create.PIGButton
local PIGDiyBut=Create.PIGDiyBut
local PIGTabBut=Create.PIGTabBut
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGBrowseBiaoti=Create.PIGBrowseBiaoti
local PIGFontString=Create.PIGFontString
local PIGSetFont=Create.PIGSetFont
---
local Data=addonTable.Data
local Fun = addonTable.Fun
local BusinessInfo=addonTable.BusinessInfo
---------------------------------
function BusinessInfo.AHPlus_Vanilla()
	if not PIGA["AHPlus"]["Open"] or AuctionFrame.SetTopUI then return end
	local ElvUIopen=ElvUI and true
	local NDuiopen=Fun.IsNDui("Skins","BlizzardSkins")
	local EextData={
		["ElvUI"]={ElvUIopen,{-47,16,0,16},{nil,-4}},
		["NDui"]={NDuiopen,{-56,6,1,6},{nil,-4}},
	}
	AuctionFrame.SetTopUI=PIGFrame(AuctionFrame,{"BOTTOMLEFT",AuctionFrame,"TOPLEFT",58,-15},nil,nil,nil,nil,EextData)
	AuctionFrame.SetTopUI:PIGSetHeight(30);
	AuctionFrame.SetTopUI:PIGSetBackdrop(1)
	AuctionFrame.SetTopUI:PIGSetPoint({"BOTTOMRIGHT",AuctionFrame,"TOPRIGHT",0,-15});
	----------
	if PIG_MaxTocversion(40000) and PIG_MaxTocversion(30000,true) then
		PIGA["AHPlus"]["SimpleMode"]=true
	end
	local SimpleModename="简易模式(防卡)"
	AuctionFrame.SetTopUI.SimpleMode =PIGCheckbutton(AuctionFrame.SetTopUI,{"RIGHT",AuctionFrame.SetTopUI,"RIGHT",-250,0},{SimpleModename,"如果拍卖行买卖CD很长，请开启此模式"},nil,nil,nil,0)
	AuctionFrame.SetTopUI.SimpleMode.Text:SetTextColor(0, 1, 1, 0.8);
	AuctionFrame.SetTopUI.SimpleMode:SetScript("OnClick", function (self)
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
			AuctionFrame.SetTopUI.SimpleMode:SetChecked(PIGA["AHPlus"]["SimpleMode"])
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
		if PIG_MaxTocversion(40000) and PIG_MaxTocversion(20000,true) then return end
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
	AuctionFrame.SetTopUI.exact =PIGCheckbutton(AuctionFrame.SetTopUI,{"LEFT",AuctionFrame.SetTopUI,"LEFT",280,0},{AH_EXACT_MATCH,AH_EXACT_MATCH_TOOLTIP},nil,nil,nil,0)
	AuctionFrame.SetTopUI.exact.Text:SetTextColor(0, 1, 0, 1);
	if PIGA["AHPlus"]["SimpleMode"] then AuctionFrame.SetTopUI.exact:Disable() AuctionFrame.SetTopUI.exact.tooltip=SimpleModename.."下不可用" end
	AuctionFrame.SetTopUI.exact:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["exactMatch"]=true
		else
			PIGA["AHPlus"]["exactMatch"]=false
		end
	end);
	AuctionFrame.SetTopUI.fastBuy =PIGCheckbutton(AuctionFrame.SetTopUI,{"LEFT",AuctionFrame.SetTopUI,"LEFT",380,0},{"快速购买","开启后每行会增加一个购买按钮，点击后会直接购买\n已做保护，非一口单价从低到高排序将不会显示此按钮，\n|cffFF0000注意此操作存在风险，开启此功能视为你了解此风险|r"},nil,nil,nil,0)
	AuctionFrame.SetTopUI.fastBuy.Text:SetTextColor(1, 0, 1, 1);
	AuctionFrame.SetTopUI.fastBuy:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["fastBuy"]=true
		else
			PIGA["AHPlus"]["fastBuy"]=false
		end
	end);
	--调整原版UI=================
	AuctionFrameTab1:SetText(AUCTION_HOUSE_BUY_TAB)
	AuctionFrameTab2:SetText(BID)
	AuctionFrameTab3:SetText(AUCTION_HOUSE_SELL_TAB)
	AuctionsCreateAuctionButton:SetText(START..AUCTION_HOUSE_SELL_TAB)
	AuctionsCancelAuctionButton:SetText(CANCEL..AUCTION_HOUSE_SELL_TAB)
	BrowseNameText:ClearAllPoints();
	BrowseNameText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",598,-40);
	BrowseLevelText:ClearAllPoints();
	BrowseLevelText:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",70,-40);

	local BrowseDropDown=BrowseDropDown or BrowseDropdown
	BrowseDropDown:SetPoint("TOPLEFT",BrowseLevelText,"BOTTOMRIGHT",10,4);

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
	C_Timer.After(0.1,function()
		BrowsePriceOptionsButtonFrame:SetParent(AuctionFrame.SetTopUI)
		BrowsePriceOptionsButtonFrame:ClearAllPoints();
		BrowsePriceOptionsButtonFrame:SetPoint("LEFT",AuctionFrame.SetTopUI,"LEFT",112,0);
	end);
	--切换出售者
	local ShowBidder = PIGDiyBut(AuctionFrameBrowse,{"TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",70,-84},{16,18,16,18,"groupfinder-waitdot"})
	ShowBidder.TooltipFun=function()
		if ShowBidder.mode==1 then
			GameTooltip:AddLine(DISPLAY..AUCTION_CREATOR)
		else
			GameTooltip:AddLine(DISPLAY.."价格趋势")
		end
	end
	PIGEnter(ShowBidder)
	ShowBidder.mode=1
	ShowBidder:HookScript("OnClick", function (self)
		if self.mode==1 then
			self.mode=2
			self.icon:SetAtlas("loottoast-arrow-orange")
		elseif self.mode==2 then
			self.mode=1
			self.icon:SetAtlas("groupfinder-waitdot")
		end
		self.UpdateBiaoti()
	end)

	--标题
	local PIG_NUM_BROWSE_TO_DISPLAY = NUM_BROWSE_TO_DISPLAY--12;
	local AH_TIME = TIME_LABEL:gsub(":","")
	local AH_TIME = AH_TIME:gsub("：","")
	local BUYOUT_PREFIX = AUCTION_TOOLTIP_TOTAL_BUYOUT_PREFIX:gsub(":","")
	local BUYOUT_PREFIX =  BUYOUT_PREFIX:gsub("：","")
	local biaotiLsit = {"BrowseQualitySort","Browse_biaoti_Count","BrowseDurationSort","BrowseHighBidderSort","BrowseLevelSort","Browse_biaoti_unitbid","BrowseCurrentBidSort","Browse_biaoti_buyout","Browse_biaoti_fastBuy","Browse_biaoti_UpDown"}
	local biaotiLsitName = {"",ACTION_SPELL_AURA_APPLIED_DOSE,AH_TIME,"","",AUCTION_HOUSE_BIDS_SUB_TAB..AUCTION_BROWSE_UNIT_PRICE_SORT,BUYOUT..AUCTION_BROWSE_UNIT_PRICE_SORT,BUYOUT_PREFIX,"",""}
	local biaotiLsitW = {170,32,56,100,24,108,108,108,30,42}
	local biaotiLsitArrow={nil,"no",nil,nil,nil,"unitbid","unitprice","totalbuyout","no","no"}
	local biaotiLsitSort={["Browse_biaoti_unitbid"]=true,["Browse_biaoti_buyout"]=true,["Browse_biaoti_fastBuy"]=true,["Browse_biaoti_UpDown"]=true,}
	local biaoIconData={
		["Browse_biaoti_UpDown"]={"loottoast-arrow-orange","loottoast-arrow-green"},
	}
	SetCVar("auctionSortByBuyoutPrice", "1");
	SetCVar("auctionSortByUnitPrice", "1");
	local hang_Height,hang_NUM ,anniuH,suoxiaozhi,FontSise = 25, 14, 18, 58, 13.2
	local shengyuTime = {[1]="|cffFF0000<30m|r",[2]="|cffFFFF0030m~2H|r",[3]="|cff00FF002H~12H|r",[4]="|cff00FF00>12H|r",}
	local Funlist={}
	local function Set_ArrowPoint(but,Sort,existingSortColumn,existingSortReverse)
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
	for i=1,#biaotiLsit do
		local biaotiBut = _G[biaotiLsit[i]]
		if not biaotiBut then
			biaotiBut = CreateFrame("Button",biaotiLsit[i],AuctionFrameBrowse,"AuctionSortButtonTemplate");
			if biaoIconData[biaotiLsit[i]] then
				_G[biaotiLsit[i].."Arrow"]:Hide()
				for ixc=1,#biaoIconData[biaotiLsit[i]] do
					local UpDownicon = biaotiBut:CreateTexture()
					UpDownicon:SetSize(15,16);
					UpDownicon:SetAtlas(biaoIconData[biaotiLsit[i]][ixc]);
					UpDownicon:SetPoint("LEFT",biaotiBut,"LEFT",(ixc-1)*12+8,0);
					if ixc==2 then
						UpDownicon:SetRotation(math.rad(180), {x=0.5, y=0.5})
					end
				end
				
			end
		end
		biaotiBut:SetSize(biaotiLsitW[i]+2,19);
		biaotiBut:ClearAllPoints();
		if i==1 then
			biaotiBut:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",122,-82);
		elseif biaotiLsit[i]=="BrowseHighBidderSort" then
			biaotiBut:SetPoint("LEFT",_G[biaotiLsit[i-2]],"RIGHT",0,0);
		else
			biaotiBut:SetPoint("LEFT",_G[biaotiLsit[i-1]],"RIGHT",0,0);
		end
		if biaotiLsit[i]=="Browse_biaoti_UpDown" then
			BusinessInfo.ADD_qushiTips(biaotiBut)
		end
		if ElvUIopen or NDuiopen then
			_G[biaotiLsit[i].."Left"]:Hide()
			_G[biaotiLsit[i].."Middle"]:Hide()
			_G[biaotiLsit[i].."Right"]:Hide()
		end
		if biaotiLsitName[i]~="" then
			biaotiBut:SetText(biaotiLsitName[i]);
		end
		if biaotiLsitArrow[i] then
			if biaotiLsitArrow[i]=="no" then
				biaotiBut:Disable();
				_G[biaotiLsit[i].."Arrow"]:Hide()
			else
				if PIGA["AHPlus"]["SimpleMode"] then
					if biaotiLsitSort[biaotiLsit[i]] then biaotiBut:Disable(); end
				else
					biaotiBut:HookScript("OnClick", function (self)
						local existingSortColumn, existingSortReverse = GetAuctionSort("list", 1);
						SortAuctionClearSort("list");
						if existingSortColumn==biaotiLsitArrow[i] then
							if existingSortReverse then
								SortAuctionSetSort("list", biaotiLsitArrow[i], false);
							else
								SortAuctionSetSort("list", biaotiLsitArrow[i], true);
							end
						else
							SortAuctionSetSort("list", biaotiLsitArrow[i], false);
						end
						AuctionFrameBrowse_Search();
					end)
				end
			end
		end
	end
	_G["Browse_biaoti_CountText"]:SetPoint("LEFT", _G["Browse_biaoti_Count"], "LEFT", 2, 0);
	_G["BrowseLevelSortText"]:SetPoint("LEFT", _G["BrowseLevelSort"], "LEFT", 2, 0);
	_G["BrowseLevelSortArrow"]:SetPoint("LEFT", _G["BrowseLevelSortText"], "RIGHT", -2, -2);
	hooksecurefunc("AuctionFrameBrowse_UpdateArrows", function()
		local existingSortColumn, existingSortReverse = GetAuctionSort("list", 1);
		for i=1,#biaotiLsit do
			if biaotiLsitArrow[i] then
				Set_ArrowPoint(_G[biaotiLsit[i]],biaotiLsitArrow[i],existingSortColumn,existingSortReverse)
			end
		end
	end)
	--分类
	hooksecurefunc("AuctionFrameFilters_UpdateCategories", function(forceSelectionIntoView)
		ShowBidder.UpdateBiaoti()
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
	local function leftWWW(num)
		local  hejinum = 0
		for i=1,num do
			if i==3 or i==4 then
				if ShowBidder.mode==1 and i==3 then
					hejinum=hejinum+biaotiLsitW[i]
				elseif ShowBidder.mode==2 and i==4 then
					hejinum=hejinum+biaotiLsitW[i]
				end
			else
				hejinum=hejinum+biaotiLsitW[i]
			end
		end
		return hejinum
	end
	local function Update_hangPoint(button,ClosingTime,buttonHighBidder,buttonLevel,MoneyFrame,BuyoutFrame,allBuyoutFrame)
		if ShowBidder.mode==1 then
			button.UpDown:Show()
			ClosingTime:Show()
			buttonHighBidder:Hide()
			button.fastBuy:SetPoint("RIGHT", button, "RIGHT", -biaotiLsitW[10],0);
		else
			button.UpDown:Hide()
			ClosingTime:Hide()
			buttonHighBidder:Show()
			button.fastBuy:SetPoint("RIGHT", button, "RIGHT", 0,0);
		end
		buttonHighBidder:ClearAllPoints();
		buttonHighBidder:SetPoint("LEFT", button, "LEFT", leftWWW(2), 0);
		buttonLevel:SetPoint("LEFT", button, "LEFT", leftWWW(4), 0);
		MoneyFrame:SetPoint("LEFT", button, "LEFT", leftWWW(5)+2, 0);
		BuyoutFrame:SetPoint("LEFT", button, "LEFT", leftWWW(6)+2, 0);
		allBuyoutFrame:SetPoint("LEFT", button, "LEFT", leftWWW(7)+6, 0);
	end
	function ShowBidder.UpdateBiaoti()
		_G["BrowseLevelSort"]:ClearAllPoints();
		if ShowBidder.mode==1 then
			_G["BrowseHighBidderSort"]:Hide();
			_G["Browse_biaoti_UpDown"]:Show()
			_G["BrowseDurationSort"]:Show();
			_G["BrowseLevelSort"]:SetPoint("LEFT",_G["BrowseDurationSort"],"RIGHT",0,0);
		else
			_G["BrowseHighBidderSort"]:Show();
			_G["Browse_biaoti_UpDown"]:Hide();
			_G["BrowseDurationSort"]:Hide();
			_G["BrowseLevelSort"]:SetPoint("LEFT",_G["BrowseHighBidderSort"],"RIGHT",0,0);
		end
		for i=1, PIG_NUM_BROWSE_TO_DISPLAY do
			Update_hangPoint(_G["BrowseButton"..i],_G["BrowseButton"..i.."ClosingTime"],_G["BrowseButton"..i.."HighBidder"],_G["BrowseButton"..i.."Level"],_G["BrowseButton"..i.."MoneyFrame"],_G["BrowseButton"..i.."BuyoutFrameMoney"],_G["BrowseButton"..i.."AllBuyoutFrame"])
		end
	end
	--价格趋势
	local EextData={
		["ElvUI"]={true,{0,0,0,0}},
		["NDui"]={NDuiopen,{0,0,0,0}},
	}
	AuctionFrameBrowse.qushiUI=PIGFrame(AuctionFrameBrowse,nil,nil,nil,nil,nil,EextData)
	AuctionFrameBrowse.qushiUI:SetSize(328,264);
	AuctionFrameBrowse.qushiUI:PIGSetBackdrop(1)
	AuctionFrameBrowse.qushiUI:SetFrameStrata("HIGH")
	AuctionFrameBrowse.qushiUI:SetPoint("TOPRIGHT",AuctionFrameBrowse,"TOPRIGHT",10,-120);
	AuctionFrameBrowse.qushiUI:Hide()
	AuctionFrameBrowse.qushiUI.qushiF,qushitishi=BusinessInfo.ADD_qushi(AuctionFrameBrowse.qushiUI,true)
	AuctionFrameBrowse.qushiUI.qushiF:SetPoint("TOPLEFT", AuctionFrameBrowse.qushiUI, "TOPLEFT",4, -24);
	AuctionFrameBrowse.qushiUI.qushiF:SetPoint("BOTTOMRIGHT", AuctionFrameBrowse.qushiUI, "BOTTOMRIGHT",-4, 4);

	---物品显示区域
	AuctionFrameBrowse.bgtex = CreateFrame("Frame", nil, AuctionFrameBrowse,"BackdropTemplate")
	AuctionFrameBrowse.bgtex:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",180-suoxiaozhi,-104);
	AuctionFrameBrowse.bgtex:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",70,38);
	AuctionFrameBrowse.bgtex:SetFrameLevel(2)
	if ElvUIopen then
		AuctionFrameBrowse:HookScript("OnShow", function(self)
			if self.LeftBackground then
				self.LeftBackground:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",-636,33.61);
			end
		end)
	elseif NDuiopen then
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
	----
	BrowseScrollFrame:SetPoint("TOPRIGHT",AuctionFrameBrowse.bgtex,"TOPRIGHT",-19,0);
	BrowseScrollFrame:SetPoint("BOTTOMLEFT",AuctionFrameBrowse.bgtex,"BOTTOMLEFT",0,0);
	BrowseScrollFrame.ScrollBar:SetScale(0.8)
	local regions = {BrowseScrollFrame:GetRegions()}
	for k,v in pairs(regions) do
		v:Hide()
	end
	BrowseNoResultsText:SetParent(AuctionFrameBrowse.bgtex)
	local bgWidth=AuctionFrameBrowse.bgtex:GetWidth()-19
	local function SetFrameMoneyFont(uiname)
		local BuyoutFrameMoney = _G[uiname];
		local BuyoutFrameMoneyGold = _G[uiname.."GoldButton"];
		local BuyoutFrameMoneySilver = _G[uiname.."SilverButton"];
		local BuyoutFrameMoneyCopper = _G[uiname.."CopperButton"];
		-- BuyoutFrameMoney:SetHeight(hang_Height)
		-- BuyoutFrameMoneyGold:SetHeight(hang_Height)
		-- BuyoutFrameMoneySilver:SetHeight(hang_Height)
		-- BuyoutFrameMoneyCopper:SetHeight(hang_Height)
		local BuyoutFrameMoneyGoldText = _G[uiname.."GoldButtonText"];
		local BuyoutFrameMoneySilverText = _G[uiname.."SilverButtonText"];
		local BuyoutFrameMoneyCopperText = _G[uiname.."CopperButtonText"];
		PIGSetFont(BuyoutFrameMoneySilverText,FontSise)
		PIGSetFont(BuyoutFrameMoneyCopperText,FontSise)
		PIGSetFont(BuyoutFrameMoneyGoldText,FontSise)
	end
	local function addhangMoneyFrame(fujik,FrameName,color)
		local allbutG = CreateFrame("Button",FrameName, fujik, "SmallMoneyFrameTemplate");
		_G[FrameName.."GoldButton"]:EnableMouse(false)
		_G[FrameName.."SilverButton"]:EnableMouse(false)
		_G[FrameName.."CopperButton"]:EnableMouse(false)
		allbutG:EnableMouse(false)
		MoneyFrame_SetType(allbutG, "AUCTION");
		--SetMoneyFrameColor(allbutG:GetName(), "default")
		--MoneyFrame_SetMaxDisplayWidth(allbutG, biaotiLsitW[7]);
		SetFrameMoneyFont(FrameName)
		_G[FrameName.."GoldButtonText"]:SetTextColor(unpack(color))
		_G[FrameName.."SilverButtonText"]:SetTextColor(unpack(color))
		_G[FrameName.."CopperButtonText"]:SetTextColor(unpack(color))
		allbutG:SetScript("OnEvent",nil)
		allbutG:SetScript("OnEnter",nil)
		return allbutG
	end
	for i=1, PIG_NUM_BROWSE_TO_DISPLAY do
		local button = _G["BrowseButton"..i];
		if not button then
			button = CreateFrame("Button","BrowseButton"..i, AuctionFrameBrowse, "BrowseButtonTemplate", i);
			button:SetPoint("TOPLEFT",_G["BrowseButton"..(i-1)],"BOTTOMLEFT",0,0);
		end
		if i==1 then
			button:SetPoint("TOPLEFT", BrowseScrollFrame, "TOPLEFT", 4, -6);
		end
		local buttonLeft = _G["BrowseButton"..i.."Left"];
		buttonLeft:SetPoint("LEFT", button, "LEFT", 34, 0);
		local buttonRight = _G["BrowseButton"..i.."Right"];
		buttonRight:SetPoint("RIGHT", button, "RIGHT", 0, 0);
		local buttonItem = _G["BrowseButton"..i.."Item"];
		local buttonName = _G["BrowseButton"..i.."Name"];
		local buttonLevel = _G["BrowseButton"..i.."Level"];
		local itemCount = _G["BrowseButton"..i.."ItemCount"];
		local buttonClosingTime = _G["BrowseButton"..i.."ClosingTime"];
		local buttonHighBidder = _G["BrowseButton"..i.."HighBidder"];
		_G["BrowseButton"..i.."BuyoutFrameText"]:Hide()
		_G["BrowseButton"..i.."ClosingTimeText"]:SetAllPoints(buttonClosingTime)
		buttonItem:ClearAllPoints();
		buttonItem:SetPoint("LEFT", button, "LEFT", 0, 0);
		PIGSetFont(buttonName,FontSise)
		buttonName:SetWidth(biaotiLsitW[1]-32)
		buttonName:ClearAllPoints();
		buttonName:SetPoint("LEFT", buttonItem, "RIGHT", 2, 0);
		PIGSetFont(itemCount,FontSise)
		itemCount:SetTextColor(0, 1, 1, 1)
		itemCount:SetWidth(biaotiLsitW[2])
		itemCount:ClearAllPoints();
		itemCount:SetPoint("LEFT", buttonItem, "LEFT", biaotiLsitW[1]-4, 0);
		buttonClosingTime:ClearAllPoints();
		buttonClosingTime:SetWidth(biaotiLsitW[3])
		buttonClosingTime:SetPoint("LEFT", buttonItem, "LEFT", leftWWW(2), 0);
		PIGSetFont(_G["BrowseButton"..i.."ClosingTimeText"],FontSise)

		PIGSetFont(buttonLevel,FontSise)
		buttonLevel:ClearAllPoints();
		buttonLevel:SetWidth(biaotiLsitW[5])
		buttonLevel:SetPoint("LEFT", buttonItem, "LEFT", leftWWW(3), 0);
		buttonLevel:SetJustifyH("RIGHT");
		
		buttonHighBidder:SetWidth(biaotiLsitW[4])
		buttonHighBidder:EnableMouse(false)
		PIGSetFont(_G["BrowseButton"..i.."HighBidderName"],FontSise)
		_G["BrowseButton"..i.."HighBidderName"]:SetTextColor(1,140/255,0, 1)

		SetMoneyFrameColor(_G["BrowseButton"..i.."MoneyFrame"]:GetName(), "gray")
		SetMoneyFrameColor(_G["BrowseButton"..i.."BuyoutFrameMoney"]:GetName(), "default")
		SetFrameMoneyFont("BrowseButton"..i.."MoneyFrame")
		SetFrameMoneyFont("BrowseButton"..i.."BuyoutFrameMoney")
		_G["BrowseButton"..i.."BuyoutFrameMoneyGoldButtonText"]:SetTextColor(1, 1, 0, 1)
		_G["BrowseButton"..i.."BuyoutFrameMoneySilverButtonText"]:SetTextColor(1, 1, 0, 1)
		_G["BrowseButton"..i.."BuyoutFrameMoneyCopperButtonText"]:SetTextColor(1, 1, 0, 1)
		addhangMoneyFrame(button,"BrowseButton"..i.."AllBuyoutFrame",{0, 1, 1, 1})

		button.fastBuy = PIGButton(button,nil,{28,22},"买",nil,nil,nil,nil,0,ElvUIopen);
		button.fastBuy:SetFrameLevel(8)
		button.fastBuy:Hide()
		button.fastBuy:HookScript("OnClick",function(self)
			PlaceAuctionBid(AuctionFrame.type, self.index, self.buyoutPrice);
		end)
		button.fastBuy:HookScript("OnEnter", function(self)
			self:GetParent():LockHighlight();
		end);
		button.fastBuy:HookScript("OnLeave", function(self)
			self:GetParent():UnlockHighlight();
		end);
		button.UpDown = CreateFrame("Frame", "BrowseButton"..i.."UpDown", button)
		button.UpDown:SetSize(biaotiLsitW[10],hang_Height);
		button.UpDown:SetPoint("RIGHT", button, "RIGHT", -2,0);
		button.UpDown.Text = PIGFontString(button.UpDown,nil,nil,"OUTLINE")
		button.UpDown.Text:SetJustifyH("RIGHT");
		button.UpDown.Text:SetAllPoints(button.UpDown)
		button.UpDown:HookScript("OnEnter", function(self)
			self:GetParent():LockHighlight();
			local AHdangqianH = FauxScrollFrame_GetOffset(BrowseScrollFrame)+i;
			local name, texture, count, quality = GetAuctionItemInfo("list", AHdangqianH);
			if name then
				local NameData=BusinessInfo.GetCacheDataG(name)
				if NameData then
					AuctionFrameBrowse.qushiUI:Show()
					local r, g, b,hex = GetItemQualityColor(quality)
					AuctionFrameBrowse.qushiUI.qushiF.UpdateList(NameData,"|c"..hex..name.."|r",555)
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
					AuctionFrame.collTabF:UpdateAllList()
				end
			end
		end);
	end
	ShowBidder.UpdateBiaoti()
	local function IsSortingByUnitPrice()
		return GetCVarBool("auctionSortByUnitPrice");
	end
	local function SetMoneyFrameButton(fujik)
		local nameuix=fujik:GetName()
		_G[nameuix.."CopperButton"]:Show()
		_G[nameuix.."CopperButton"]:SetPoint("RIGHT", fujik, "RIGHT", 2, -2);
		_G[nameuix.."SilverButton"]:SetPoint("RIGHT", _G[nameuix.."CopperButton"], "LEFT", 4, 0);
		_G[nameuix.."GoldButton"]:SetPoint("RIGHT", _G[nameuix.."SilverButton"], "LEFT", 4, 0);
	end
	hooksecurefunc("AuctionFrameBrowse_Update", function()
		if AuctionFrame_DoesCategoryHaveFlag("WOW_TOKEN_FLAG", AuctionFrameBrowse.selectedCategoryIndex) then return end
		_G[biaotiLsit[6]]:SetWidth(biaotiLsitW[6]);
		_G[biaotiLsit[7]]:SetWidth(biaotiLsitW[7]);
		_G[biaotiLsit[7]]:SetText(biaotiLsitName[7]);
		local MoneyG=GetMoney()
		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
		local existingSortColumn, existingSortReverse = GetAuctionSort("list", 1);
		BrowseSearchCountText:Show();
		local itemsMin = AuctionFrameBrowse.page * NUM_AUCTION_ITEMS_PER_PAGE + 1;
		local itemsMax = itemsMin + numBatchAuctions - 1;
		BrowseSearchCountText:SetFormattedText(NUMBER_OF_RESULTS_TEMPLATE, itemsMin, itemsMax, totalAuctions);
		for i=1, PIG_NUM_BROWSE_TO_DISPLAY do
			local AHdangqianH = FauxScrollFrame_GetOffset(BrowseScrollFrame)+i;
			local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice,bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("list", AHdangqianH);
			if name then
				local button = _G["BrowseButton"..i];
				button.fastBuy:Hide()
				button.UpDown.Text:SetText("--");
				button.UpDown.Text:SetTextColor(0.5, 0.5, 0.5, 0.5);
				button:SetWidth(bgWidth);
				local buttonHighlight = _G["BrowseButton"..i.."Highlight"];
				buttonHighlight:ClearAllPoints();
				buttonHighlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, -4);
				buttonHighlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 2);
				local buttonName="BrowseButton"..i
				local itemName = _G[buttonName.."Name"];
				itemName:SetText(name);
				local itemCount = _G[buttonName.."ItemCount"];
				if not itemCount:IsShown() then
					itemCount:Show()
					itemCount:SetText(count)
				end
	
				local buttonClosingTime = _G["BrowseButton"..i.."ClosingTimeText"];
				local timeleft = GetAuctionItemTimeLeft("list", AHdangqianH)
				buttonClosingTime:SetText(shengyuTime[timeleft]);

				local MoneyFrame = _G["BrowseButton"..i.."MoneyFrame"];
				MoneyFrame:SetWidth(biaotiLsitW[6])
				MoneyFrame:ClearAllPoints();
				SetMoneyFrameButton(MoneyFrame)
				local BuyoutFrame = _G["BrowseButton"..i.."BuyoutFrameMoney"];
				BuyoutFrame:SetWidth(biaotiLsitW[7])
				BuyoutFrame:ClearAllPoints();
				SetMoneyFrameButton(BuyoutFrame)
				_G["BrowseButton"..i.."YourBidText"]:Hide()
				local allBuyoutFrame = _G["BrowseButton"..i.."AllBuyoutFrame"]
				if buyoutPrice>0 then
					MoneyFrame_Update("BrowseButton"..i.."AllBuyoutFrame", buyoutPrice);
					allBuyoutFrame:Show()
					allBuyoutFrame:SetWidth(biaotiLsitW[8])					
					SetMoneyFrameButton(allBuyoutFrame)
					if count>0 and existingSortColumn=="unitprice" and existingSortReverse==false then
						if PIGA["AHPlus"]["fastBuy"] then
							button.fastBuy:Show()
							button.fastBuy:SetEnabled(MoneyG>buyoutPrice)
							button.fastBuy.index=AHdangqianH
							button.fastBuy.buyoutPrice=buyoutPrice
						end
						local itemLink = GetAuctionItemLink("list", AHdangqianH)
						local xianjiaV = floor(buyoutPrice/count+0.5)
						button.UpDown.dangqianG=xianjiaV
						local NameData=BusinessInfo.GetCacheDataG(name)
						if NameData then
							local OldMoneyNum = #NameData
							local OldGGGV_1 = NameData[OldMoneyNum]
							if AHdangqianH==1 then
								if xianjiaV~=OldGGGV_1[1] and GetServerTime()-OldGGGV_1[2]>300 then
									BusinessInfo.ADD_Newdata(name,xianjiaV,itemLink,itemId)
								end
							end				
							if OldMoneyNum>1 then
								local baifenbi = (xianjiaV/OldGGGV_1[1])*100+0.5
								local baifenbi = floor(baifenbi)
								if baifenbi>999 then
									button.UpDown.Text:SetText("999%");
								else
									button.UpDown.Text:SetText(baifenbi.."%");
								end
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
				else
					allBuyoutFrame:Hide()
				end
				Update_hangPoint(button,buttonClosingTime,_G["BrowseButton"..i.."HighBidder"],_G["BrowseButton"..i.."Level"],MoneyFrame,BuyoutFrame,allBuyoutFrame,button.UpDown)
			end
		end
	end)

	---缓存价格==================
	local UpdateF = {}
	UpdateF.meiyenum = 29
	UpdateF.auctionsG = {}
	UpdateF.auctionsLin={}
	UpdateF.RetryCount = {}
	UpdateF.ItemIndexList = {}

	AuctionFrame.SetTopUI.History = PIGButton(AuctionFrame.SetTopUI,{"LEFT",AuctionFrame.SetTopUI,"LEFT",10,0},{90,22},"缓存价格",nil,nil,nil,nil,0);
	AuctionFrame.SetTopUI.History:HookScript("OnShow",function(self)
		local canQuery,canQueryAll = CanSendAuctionQuery()
		self:SetEnabled(canQueryAll)
	end)
	AuctionFrame.SetTopUI.History:HookScript("OnClick", function(self)
		UpdateF:StartScan()
	end)
	AuctionFrameBrowse.huancunUI = CreateFrame("Frame", nil, AuctionFrameBrowse,"BackdropTemplate");
	local jinduW,jinduH,HCUI = 300,20,AuctionFrameBrowse.huancunUI
	HCUI:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp",edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 13});
	HCUI:SetBackdropBorderColor(0, 1, 1, 0.9);
	HCUI:SetPoint("TOPLEFT",AuctionFrameBrowse,"TOPLEFT",14,-34);
	HCUI:SetPoint("BOTTOMRIGHT",AuctionFrameBrowse,"BOTTOMRIGHT",70,12);
	HCUI:SetFrameLevel(520)
	HCUI:EnableMouse(true)
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
	    local name, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, _, _, _, itemId, hasAllInfo = GetAuctionItemInfo("list", index)
	    if hasAllInfo then
		    if itemId and buyoutPrice and buyoutPrice>0 and count and count > 0 then
		        local itemLink = GetAuctionItemLink("list", index)
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
        local currentTotal = GetNumAuctionItems("list")
        HCUI.jindu.t3:SetText(currentTotal);
        local canQuery,canQueryAll = CanSendAuctionQuery()
		if canQuery then
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
		else
			C_Timer.After(1, UpdateScan)
		end
	end
	function UpdateF:StartScan()
		AuctionFrame.SetTopUI.History:Disable()
		AuctionFrameBrowse_Reset(BrowseResetButton)
		BusinessInfo.Del_OldData()
		HCUI:Show();
		HCUI.close:Hide();
		HCUI.jindu.tbiaoti:SetText("正在扫描物品...");
		HCUI.jindu:SetMinMaxValues(0, 100)
		HCUI.jindu:SetValue(1);
		HCUI.jindu.t2:SetText(0);
		HCUI.jindu.t3:SetText(0);
		self.SMend=true
		self.ScanCD=PIGA["AHPlus"]["ScanTimeCD"]*0.0001
		self.currentTotal=0
		self._index = 0
		QueryAuctionItems("", nil, nil, 0, nil, nil, true, false, nil)
		C_Timer.After(1, UpdateScan)
	end
	function UpdateF.StopScan()
		HCUI:Hide();
		HCUI.close:Hide();
		UpdateF.SMend=nil
		wipe(UpdateF.auctionsG)
		wipe(UpdateF.auctionsLin)
		wipe(UpdateF.RetryCount)
		wipe(UpdateF.ItemIndexList)
	end
	AuctionFrameBrowse:HookScript("OnHide",UpdateF.StopScan)
	


	---时光徽章-------------------
	BrowseWowTokenResults.qushibut = PIGButton(BrowseWowTokenResults,{"CENTER",BrowseWowTokenResults,"CENTER",3,10},{80,24},"历史价格",nil,nil,nil,nil,0,ElvUIopen)
	BrowseWowTokenResults.qushibut:HookScript("OnClick",function(self)
		if BusinessInfo.StatsInfoUI then
			BusinessInfo.StatsInfoUI:TabShow(AuctionFrame)
		else
			PIG_OptionsUI:ErrorMsg("请打开"..addonName..SETTINGS.."→"..L["BUSINESS_TABNAME"].."→"..INFO..STATISTICS)
		end
	end)

	--关注------------------------
	AuctionFrame.SetTopUI.BrowseBag =PIGCheckbutton(AuctionFrame.SetTopUI,{"RIGHT",AuctionFrame.SetTopUI,"RIGHT",-110,0},{"关注/背包物品","打开关注/背包物品"},nil,nil,nil,0,ElvUIopen)
	AuctionFrame.SetTopUI.BrowseBag.Text:SetTextColor(0, 1, 0, 1);
	AuctionFrame.SetTopUI.BrowseBag:SetScript("OnClick", function (self)
		AuctionFrame.listR:SetShown(self:GetChecked())
	end);
	
	local collW,collY,listRW,collhang_NUM = 22,22,254,15
	local EextData={
		["ElvUI"]={true,{4,12,1,-8}},
		["NDui"]={NDuiopen,{4,2,2,2}},
	}
	AuctionFrame.listR=PIGFrame(AuctionFrame,{"TOPLEFT",AuctionFrame,"TOPRIGHT",-3,-12},nil,nil,nil,nil,EextData)
	AuctionFrame.listR:PIGSetPoint({"BOTTOMLEFT",AuctionFrame,"BOTTOMRIGHT",-3,8})
	AuctionFrame.listR:SetWidth(listRW);
	AuctionFrame.listR:PIGSetBackdrop()
	AuctionFrame.listR:PIGClose()
	AuctionFrame.listR:EnableMouse(true)
	AuctionFrame.listR:SetToplevel(true)
	AuctionFrame.listR:SetScript("OnShow", function (self)
		AuctionFrame.SetTopUI.BrowseBag:SetChecked(true)
	end);
	AuctionFrame.listR:SetScript("OnHide", function (self)
		AuctionFrame.SetTopUI.BrowseBag:SetChecked(false)
	end);
	--
	AuctionFrame.listR.tabselect=1
	AuctionFrame.tabButList={}
	AuctionFrame.listR.TabF={}
	local tabList={BAGSLOT,"关注","已购"}
	local EextData={
		["ElvUI"]={true},
		["NDui"]={Fun.IsNDui("Skins","BlizzardSkins")},
	}
	for i=1,#tabList do
		AuctionFrame.tabButList[i] = Create.PIGTabBut(AuctionFrame.listR,nil,{70,26},tabList[i],nil,EextData)
		if i==1 then
			 AuctionFrame.tabButList[i]:SetPoint("BOTTOMLEFT",AuctionFrame.listR,"TOPLEFT",4,0);
		else
			AuctionFrame.tabButList[i]:SetPoint("LEFT",AuctionFrame.tabButList[i-1],"RIGHT",4,0);
		end
		AuctionFrame.tabButList[i]:HookScript("OnClick", function (self)
			AuctionFrame.listR.tabselect=i
			AuctionFrame.listR:Update_Tablist()
		end);
		AuctionFrame.listR.TabF[i]=PIGFrame(AuctionFrame.listR,{"TOPLEFT",AuctionFrame.listR,"TOPLEFT",2,-24})
		AuctionFrame.listR.TabF[i]:PIGSetPoint({"BOTTOMRIGHT",AuctionFrame.listR,"BOTTOMRIGHT",-2,0})
	end
	function AuctionFrame.listR:Update_Tablist()
		for i=1,#tabList do
			AuctionFrame.tabButList[i]:Selected(false)
			AuctionFrame.listR.TabF[i]:Hide()
		end
		AuctionFrame.tabButList[self.tabselect]:Selected(true)
		AuctionFrame.listR.TabF[self.tabselect]:Show()
		AuctionFrame.listR.TabF[self.tabselect]:UpdateAllList()
	end
	hooksecurefunc("PanelTemplates_SetTab", function(self, tabid)
		if tabid==1 then
			AuctionFrame.tabButList[1]:Click()
		elseif tabid==3 then
			AuctionFrame.tabButList[1]:Click()
		end
	end)

	local listRhangW =AuctionFrame.listR:GetWidth()-26
	local tabBagF=AuctionFrame.listR.TabF[1]
	local collTabF=AuctionFrame.listR.TabF[2]
	local fastBuyF=AuctionFrame.listR.TabF[3]
	----
	AuctionFrame.collTabF=collTabF
	collTabF.title = PIGFontString(collTabF,{"BOTTOM", collTabF, "TOP", -2, 5},"关注列表","OUTLINE")
	collTabF.tishi = CreateFrame("Frame", nil, collTabF);
	collTabF.tishi:SetSize(14,14);
	collTabF.tishi:SetPoint("RIGHT",collTabF.title,"LEFT",-2,-1);
	collTabF.tishi.Texture = collTabF.tishi:CreateTexture(nil, "BORDER");
	collTabF.tishi.Texture:SetTexture("interface/common/help-i.blp");
	collTabF.tishi.Texture:SetSize(28,28);
	collTabF.tishi.Texture:SetPoint("CENTER");
	PIGEnter(collTabF.tishi,L["LIB_TIPS"]..": ","\124cff00ff001、在浏览列表"..KEY_BUTTON2.."物品名可加入关注。\n2、关注列表物品"..KEY_BUTTON1.."搜索，"..KEY_BUTTON2.."删除。\124r");
	-----
	collTabF.ScrollF=Create.PIGScrollFrame_old(collTabF,{0,0,0,0})
	collTabF.butList={}
	for i = 1, collhang_NUM do
		local hangcoll = CreateFrame("Button", nil, collTabF);
		collTabF.butList[i]=hangcoll
		hangcoll:SetSize(listRhangW, hang_Height);
		if i==1 then
			hangcoll:SetPoint("TOPLEFT",collTabF,"TOPLEFT",6,0);
		else
			hangcoll:SetPoint("TOP",collTabF.butList[i-1],"BOTTOM",0,-1.5);
		end
		hangcoll:RegisterForClicks("LeftButtonUp","RightButtonUp")
		hangcoll:Hide()
		hangcoll.xuanzhong = hangcoll:CreateTexture();
		hangcoll.xuanzhong:SetTexture("interface/helpframe/helpframebutton-highlight.blp");
		hangcoll.xuanzhong:SetTexCoord(0.00,0.00,0.00,0.58,1.00,0.00,1.00,0.58);
		hangcoll.xuanzhong:SetAllPoints(hangcoll)
		hangcoll.xuanzhong:SetBlendMode("ADD")
		hangcoll.xuanzhong:Hide()
		if i~=collhang_NUM then
			hangcoll.line = hangcoll:CreateLine()
			hangcoll.line:SetColorTexture(1,1,1,0.2)
			hangcoll.line:SetThickness(1);
			hangcoll.line:SetStartPoint("TOPLEFT",0,0)
			hangcoll.line:SetEndPoint("TOPRIGHT",0,0)
		end
		hangcoll.icon = hangcoll:CreateTexture(nil, "BORDER");
		hangcoll.icon:SetSize(hang_Height-2,hang_Height-2);
		hangcoll.icon:SetPoint("LEFT", hangcoll, "LEFT", 0,0);
		if PIGA["AHPlus"]["SimpleMode"] then
			hangcoll.link =  CreateFrame("EditBox", nil, hangcoll, "InputBoxInstructionsTemplate");
			hangcoll.link:SetSize(hangcoll:GetWidth()-hang_Height-8,hang_Height);
			hangcoll.link:SetFontObject(ChatFontNormal);
			hangcoll.link:SetAutoFocus(false);
			hangcoll.link:SetPoint("LEFT", hangcoll.icon, "RIGHT", 8,0);
		else
			hangcoll.link = PIGFontString(hangcoll,{"LEFT", hangcoll.icon, "RIGHT", 0,0},nil,"OUTLINE",13)
			hangcoll.link:SetJustifyH("LEFT");
			hangcoll.link:SetWidth(hangcoll:GetWidth()-hang_Height);
		end
		-- 
		hangcoll:SetScript("OnEnter", function(self)
			self.xuanzhong:Show()
		end);
		hangcoll:SetScript("OnLeave", function(self)
			self.xuanzhong:Hide()
		end);
		hangcoll:SetScript("OnClick", function (self,button)
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
				collTabF:UpdateAllList()
			end
		end);
	end
	function collTabF.ScrollF:UpdateShowList()
		for i = 1, collhang_NUM do
			collTabF.butList[i]:Hide()
	    end
	    local datainfo=PIGA["AHPlus"]["Coll"]
		local TotalNum=#datainfo
		if TotalNum>0 then
			local offset = self:GetScrollFrameOffset(TotalNum, collhang_NUM, hang_Height)
		    for i = 1, collhang_NUM do
				local AHdangqianH = i+offset;
				if datainfo[AHdangqianH] then
					local listFGV = collTabF.butList[i]
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
	function collTabF:UpdateAllList()
		collTabF.ScrollF:UpdateShowList()
	end

	---拍卖页==============================
	local AucYajiaTxt="压价"
	local EextData={
		["ElvUI"]={true,{0,0,0,0}},
		["NDui"]={NDuiopen,{0,0,0,0}},
	}
	AuctionFrameAuctions.SellListF=PIGFrame(AuctionFrameAuctions,{"TOPLEFT",AuctionFrameAuctions,"TOPLEFT",216,-140},nil,nil,nil,nil,EextData)
	local SellListF=AuctionFrameAuctions.SellListF
	SellListF:SetPoint("BOTTOMRIGHT",AuctionFrameAuctions,"BOTTOMRIGHT",66,38);
	SellListF:PIGSetBackdrop(1)
	--SellListF:PIGClose()
	SellListF:Hide()
	SellListF:SetFrameLevel(10)
	SellListF:EnableMouse(true)
	SellListF:Hide()
	SellListF.tishibut = PIGButton(SellListF,{"CENTER", SellListF, "CENTER", 0,10},{80,24},LFG_LIST_SEARCH_AGAIN,nil,nil,nil,nil,0,ElvUIopen)
	SellListF.tishibut_txt = PIGFontString(SellListF,{"BOTTOM", SellListF.tishibut, "TOP", 0,8},nil,"OUTLINE")

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
			info.text = AUCTION_PRICE_PER_ITEM..SELL_PRICE;
			info.value = 1;
			info.checked =AuctionFrameAuctions.priceType==1;
			info.func = xialaDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
			info.text = AUCTION_PRICE_PER_STACK..SELL_PRICE;
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
	UIDropDownMenu_SetWidth(PriceDropDown, 140)
	PriceDropDown:ClearAllPoints();
	PriceDropDown:SetPoint("TOPLEFT",AuctionFrameAuctions,"TOPLEFT",30,-174);
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
	AuctionFrameAuctions.autoya =PIGCheckbutton(AuctionFrameAuctions,{"TOPLEFT",AuctionFrameAuctions,"TOPLEFT",24,-286},{"自动"..AucYajiaTxt,"选中后拍卖物品时将根据现售最低价自动"..AucYajiaTxt},nil,nil,nil,0)
	AuctionFrameAuctions.autoya.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameAuctions.autoya:SetChecked(PIGA["AHPlus"]["autoya"])
	AuctionFrameAuctions.autoya:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["autoya"]=true
		else
			PIGA["AHPlus"]["autoya"]=false
		end
	end);
	AuctionFrameAuctions.yajingbiao =PIGCheckbutton(AuctionFrameAuctions,{"LEFT",AuctionFrameAuctions.autoya.Text,"RIGHT",4,0},{"压竞标价","选中后压一口价同时压竞标价"},nil,nil,nil,0)
	AuctionFrameAuctions.yajingbiao.Text:SetTextColor(0, 1, 0, 0.8);
	AuctionFrameAuctions.yajingbiao:SetChecked(PIGA["AHPlus"]["yajingbiao"])
	AuctionFrameAuctions.yajingbiao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AHPlus"]["yajingbiao"]=true
		else
			PIGA["AHPlus"]["yajingbiao"]=false
		end
	end);
	--默认堆叠数
	if type(PIGA["AHPlus"]["Stacking"])=="number" then PIGA["AHPlus"]["Stacking"]=addonTable.Default["AHPlus"]["Stacking"] end
	local StackingLsit={0,1,2,4,5,6,7,9,11,12,13,15}
	if PIG_MaxTocversion(20000,true) then
		table.insert(StackingLsit,4,3)
	end
	if PIG_MaxTocversion(30000,true) then
		table.insert(StackingLsit,16)
	end
	local function GetStackingDefault(ClassID)
		if ClassID==6 then
			return {DEFAULT,100,200,500,1000}
		else
			return {DEFAULT,1,2,5,10,20}
		end
	end
	AuctionFrameAuctions.Stacking=PIGDownMenu(AuctionFrameAuctions,{"BOTTOMLEFT",AuctionFrameAuctions,"BOTTOMLEFT",220,15},{130,20})
	function AuctionFrameAuctions.Stacking:PIGDownMenu_Update_But(level, menuList)
		local info = {}
		if (level or 1) == 1 then
			for i=1,#StackingLsit,1 do
				local ClassID=StackingLsit[i]
				info.func = nil
				info.notCheckable=true
				info.hasArrow = true
			    info.text,info.menuList = GetItemClassInfo(ClassID),{ClassID,GetStackingDefault(ClassID)}
				self:PIGDownMenu_AddButton(info)
			end
		else
			info.func = self.PIGDownMenu_SetValue
			local ClassID, StackingData = tostring(menuList[1]), menuList[2]
			for ii=1, #StackingData do
				info.text, info.arg1, info.arg2 = StackingData[ii], ClassID, StackingData[ii]
				info.checked = ii==1 and not PIGA["AHPlus"]["Stacking"][ClassID] or PIGA["AHPlus"]["Stacking"][ClassID]==StackingData[ii]
				self:PIGDownMenu_AddButton(info, level)
			end
		end
	end
	function AuctionFrameAuctions.Stacking:PIGDownMenu_SetValue(value,arg1,arg2)
		if value==DEFAULT then
			PIGA["AHPlus"]["Stacking"][arg1]=nil
		else
			PIGA["AHPlus"]["Stacking"][arg1]=arg2
		end
		PIGCloseDropDownMenus()
	end
	AuctionFrameAuctions.Stacking:PIGDownMenu_SetText("默认拍卖堆叠")

	AuctionFrameAuctions.oldaucG =PIGCheckbutton(AuctionFrameAuctions,{"LEFT",AuctionFrameAuctions.Stacking,"RIGHT",8,0},{"记住本次拍卖价格","本次卖出相同物品使用前一次设置拍卖价格,而不是压已有的最低价。\n(只在本次打开拍卖界面期间生效)"},nil,nil,nil,0)
	if ElvUIopen then
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
	if ElvUIopen then
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
	--
	local spellhangnum, hang_Height1= 9, hang_Height
	local SellxulieID = {AucYajiaTxt,ACTION_SPELL_AURA_APPLIED_DOSE,biaotiLsitName[6],biaotiLsitName[7],biaotiLsitName[8],AH_TIME}--,AUCTION_CREATOR
	local SellxulieID_www = {54,45,142,142,142,80,121}
	SellListF.ButListBiaoti={}
	for i=1,#SellxulieID do
		local Buttonxx = CreateFrame("Button","PigAuctionsSellListF"..i,SellListF,"AuctionSortButtonTemplate");
		SellListF.ButListBiaoti[i]=Buttonxx
		Buttonxx:Disable()
		_G["PigAuctionsSellListF"..i.."Arrow"]:Hide()
		Buttonxx:SetSize(SellxulieID_www[i],anniuH);
		if i==1 then
			Buttonxx:SetPoint("TOPLEFT",SellListF,"TOPLEFT",1.4,-3);
		else
			Buttonxx:SetPoint("LEFT",SellListF.ButListBiaoti[i-1],"RIGHT",0,0);
		end
		Buttonxx:SetText(SellxulieID[i]);
		if SellxulieID[i]==biaotiLsitName[5] or SellxulieID[i]==biaotiLsitName[6] then
			_G["PigAuctionsSellListF"..i.."Text"]:ClearAllPoints();
			_G["PigAuctionsSellListF"..i.."Text"]:SetPoint("RIGHT", Buttonxx, "RIGHT", -6, 0);
		end
	end
	local hang_Width1 =SellListF:GetWidth()-10
	SellListF.ButList={}
	for i = 1, spellhangnum do
		local listFGV = CreateFrame("Button", nil, SellListF);
		SellListF.ButList[i]=listFGV
		listFGV:SetSize(hang_Width1, hang_Height1);
		if i==1 then
			listFGV:SetPoint("TOP",SellListF,"TOP",0,-24);
		else
			listFGV:SetPoint("TOP",SellListF.ButList[i-1],"BOTTOM",0,-2);
		end
		if i~=spellhangnum then
			listFGV.line = listFGV:CreateLine()
			listFGV.line:SetColorTexture(1,1,1,0.2)
			listFGV.line:SetThickness(1);
			listFGV.line:SetStartPoint("TOPLEFT",0,0)
			listFGV.line:SetEndPoint("TOPRIGHT",0,0)
		end
		listFGV:Hide()		
		listFGV.yajia = PIGButton(listFGV,{"LEFT", listFGV, "LEFT", 0,0},{SellxulieID_www[1]-4,22},SellxulieID[1],nil,nil,nil,nil,0,ElvUIopen)
		listFGV.yajia:SetScript("OnClick", function(self, button)
			SellListF:SetAHPriceFun(unpack(self.Gdata))
		end)
		---
		listFGV.count = PIGFontString(listFGV,{"LEFT", listFGV, "LEFT", SellxulieID_www[1],0},nil,"OUTLINE",13)
		listFGV.count:SetWidth(SellxulieID_www[2]);
		listFGV.count:SetTextColor(0, 1, 1, 1);
		--
		listFGV.biddanjia=addhangMoneyFrame(listFGV,"PIGSellListButton"..i.."BidFrame",{1, 1, 1, 1})
		listFGV.yikoudanjia=addhangMoneyFrame(listFGV,"PIGSellListButton"..i.."BuyoutFrame",{0, 1, 1, 1})
		listFGV.yikouall=addhangMoneyFrame(listFGV,"PIGSellListButton"..i.."allBuyoutFrame",{0, 1, 1, 1})
		--
		listFGV.TimeLeft = PIGFontString(listFGV,{"LEFT", listFGV, "LEFT", SellxulieID_www[1]+SellxulieID_www[2]+SellxulieID_www[3]+SellxulieID_www[4]+SellxulieID_www[5],0},nil,"OUTLINE",13)
		listFGV.TimeLeft:SetWidth(SellxulieID_www[6]);
		--
		-- listFGV.chushouzhe = PIGFontString(listFGV,{"LEFT", listFGV, "LEFT", SellxulieID_www[1]+SellxulieID_www[2]+SellxulieID_www[3]+SellxulieID_www[4]+SellxulieID_www[5]+SellxulieID_www[6],0},nil,"OUTLINE",13)
		-- listFGV.chushouzhe:SetWidth(SellxulieID_www[7]);
		-- listFGV.chushouzhe:SetJustifyH("LEFT");
	end
	SellListF.CacheBuy={}
	function SellListF:SetAHPriceFun(count,minBid,buyoutPrice,owner)
		if not AuctionsItemButton.OldName then return end
		local yajiaGV=0
		if count and minBid and buyoutPrice then
			SellListF.CacheBuy[AuctionsItemButton.OldName]={count,minBid,buyoutPrice,owner}
		else
			count,minBid,buyoutPrice,owner=unpack(SellListF.CacheBuy[AuctionsItemButton.OldName])
		end
		if owner and owner~=PIG_OptionsUI.Name then
			yajiaGV=1
		end
		local StackSize = AuctionsStackSizeEntry:GetNumber()
		if ( StackSize > 0 ) then
			SellListF.updateG=true
			LAST_ITEM_COUNT = StackSize;
			--local NumStacks = AuctionsNumStacksEntry:GetNumber()
			local priceType =UIDropDownMenu_GetSelectedValue(PriceDropDown)
			local buyoutdanjiaGG = buyoutPrice/count
			local BiddanjiaGG = minBid/count
			if priceType == 1 then--单卖
				if PIGA["AHPlus"]["yajingbiao"] and BiddanjiaGG>1 then
					MoneyInputFrame_SetCopper(StartPrice,floor(BiddanjiaGG+0.5)-yajiaGV);
				else
					MoneyInputFrame_SetCopper(StartPrice,floor(buyoutdanjiaGG+0.5)-yajiaGV);
				end
				MoneyInputFrame_SetCopper(BuyoutPrice,floor(buyoutdanjiaGG+0.5)-yajiaGV);
			else--组卖
				local ZuallBidG = floor(StackSize*BiddanjiaGG+0.5)
				local ZuallbuyG = floor(StackSize*buyoutdanjiaGG+0.5)
				if PIGA["AHPlus"]["yajingbiao"] and ZuallBidG>1 then
					MoneyInputFrame_SetCopper(StartPrice, ZuallBidG-yajiaGV);
				else
					MoneyInputFrame_SetCopper(StartPrice, ZuallbuyG-yajiaGV);
				end
				MoneyInputFrame_SetCopper(BuyoutPrice, ZuallbuyG-yajiaGV);
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
	local function Query_Search()
		SellListF.tishibut_txt:SetText(SEARCHING);
		AuctionsItemButton.IsSearchOK=true
		SortAuctionSetSort("list","unitprice", false)
		AuctionFrameBrowse_Reset(BrowseResetButton)
		BrowseName:SetText('"'..AuctionsItemButton.OldName..'"')
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
	local function ClearSearchList()
		SellListF.tishibut:Hide()
		for i = 1, spellhangnum do
		   	local listFGV = SellListF.ButList[i]
		   	listFGV:Hide()
		end
		CZ_BrowseSearchButton()
		if PIGA["AHPlus"]["oldaucG"] and AuctionsItemButton.OldGlist[AuctionsItemButton.OldName] then
			SellListF.tishibut_txt:SetText("<"..AuctionsItemButton.OldName..">使用上次拍卖价格，本次不搜索/"..SellxulieID[1])
			local count,minBid,buyoutPrice,owner=unpack(AuctionsItemButton.OldGlist[AuctionsItemButton.OldName])
			SellListF:SetAHPriceFun(count,minBid,buyoutPrice,owner)
		else
			if PIGA["AHPlus"]["SimpleMode"] then
				if '"'..AuctionsItemButton.OldName..'"'==BrowseName:GetText() then
					SellListF.tishibut_txt:SetText("点击搜索并"..SellxulieID[1])
					BrowseSearchButton:SetPoint("CENTER", SellListF, "CENTER", 0,10);
				else
					--ClickAuctionSellItemButton(AuctionsItemButton, "LeftButton");
					--ClearCursor();
					SellListF.tishibut_txt:SetText("|cffFFFF00自动查价失败\n当前处于"..SimpleModename.."\n按住Shift左键点击右侧物品→|r\n|cffFF0000(注意不是点击背包物品)|r")
				end
			else
				Query_Search()
			end
		end
	end
	SellListF.tishibut:SetScript("OnClick", function (self)
		Query_Search()
	end);
	AuctionsStackSizeEntry:HookScript("OnTextChanged", function (self)
		if SellListF.updateG then
			SellListF:SetAHPriceFun()
		end
	end)
	AuctionsItemButton.OldGlist={}
	AuctionsCreateAuctionButton:HookScript("OnClick", function(self)
		if AuctionsItemButton.OldName then
			AuctionsItemButton.OldGlist[AuctionsItemButton.OldName]={LAST_ITEM_COUNT,LAST_ITEM_START_BID,LAST_ITEM_BUYOUT,PIG_OptionsUI.Name}
		end
	end);
	SellListF.NewbuyPriceG={}
	function SellListF:IschongfuG(GV)
		if GV>0 then
			local maxnum=#self.NewbuyPriceG
			if self.NewbuyPriceG[maxnum] and floor(self.NewbuyPriceG[maxnum][6]/self.NewbuyPriceG[maxnum][3]+0.5)==floor(GV+0.5) then
				return false
			end
			return true
		else
			return false
		end      
	end
	SellListF:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	SellListF:HookScript("OnEvent",function(self,event,arg1,arg2)
		AuctionsItemButton.IsSearchOK=nil
		if AuctionsItemButton:IsShown() then
			for i = 1, spellhangnum do
				local listFGV = SellListF.ButList[i]
				listFGV:Hide()
			end
			local numBatchAuctions = GetNumAuctionItems("list");
			if numBatchAuctions>0 then
				if AuctionFrameBrowse.page~=0 then SellListF.tishibut_txt:SetText("浏览页请翻到第一页");return end
				--提取不同价格
				wipe(self.NewbuyPriceG)
				local numBatchAuctions=numBatchAuctions>NUM_AUCTION_ITEMS_PER_PAGE and NUM_AUCTION_ITEMS_PER_PAGE or numBatchAuctions
				for i = 1, numBatchAuctions do
					local name, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, owner =  GetAuctionItemInfo("list", i);
					if name and AuctionsItemButton.OldName==name then
						if SellListF:IschongfuG(buyoutPrice/count) then
							local timeleft = GetAuctionItemTimeLeft("list", i)
							table.insert(self.NewbuyPriceG,{i,name,count,owner,minBid,buyoutPrice,timeleft})
						end
					end
				end
				if #self.NewbuyPriceG==0 then SellListF.tishibut_txt:SetText("没有"..biaotiLsitName[7].."参考"); return end
				CZ_BrowseSearchButton()
				SellListF.tishibut_txt:SetText("")
				for i = 1, spellhangnum do
					if self.NewbuyPriceG[i] then
						local listFGV = SellListF.ButList[i]
						local index,name,count,owner,minBid,buyoutPrice,timeleft=unpack(self.NewbuyPriceG[i])
						listFGV.yajia.Gdata={count,minBid,buyoutPrice,owner}
						listFGV:Show()
						if i==1 then
					   		if PIGA["AHPlus"]["autoya"] then
					   			if PIGA["AHPlus"]["oldaucG"] and AuctionsItemButton.OldGlist[name] then
    							else
					   				SellListF:SetAHPriceFun(count,minBid,buyoutPrice,owner) 
					   			end
				   			end
				   		end
						listFGV.count:SetText(count);
						--listFGV.chushouzhe:SetText(owner);
						listFGV.TimeLeft:SetText(shengyuTime[timeleft]);
						MoneyFrame_Update("PIGSellListButton"..i.."BidFrame",floor(minBid/count+0.5));
						MoneyFrame_Update("PIGSellListButton"..i.."BuyoutFrame",floor(buyoutPrice/count+0.5));
						MoneyFrame_Update("PIGSellListButton"..i.."allBuyoutFrame",floor(buyoutPrice+0.5));
						listFGV.biddanjia:SetPoint("LEFT", listFGV, "LEFT", SellxulieID_www[1]+SellxulieID_www[2],0);
						listFGV.yikoudanjia:SetPoint("LEFT", listFGV, "LEFT", SellxulieID_www[1]+SellxulieID_www[2]+SellxulieID_www[3],0);
						listFGV.yikouall:SetPoint("LEFT", listFGV, "LEFT", SellxulieID_www[1]+SellxulieID_www[2]+SellxulieID_www[3]+SellxulieID_www[4],0);
						listFGV.biddanjia:SetWidth(SellxulieID_www[3]-10);
						listFGV.yikoudanjia:SetWidth(SellxulieID_www[4]-10);
						listFGV.yikouall:SetWidth(SellxulieID_www[5]-10);
						SetMoneyFrameButton(_G["PIGSellListButton"..i.."BidFrame"])
						SetMoneyFrameButton(_G["PIGSellListButton"..i.."BuyoutFrame"])
						SetMoneyFrameButton(_G["PIGSellListButton"..i.."allBuyoutFrame"])
					end
				end
			else
				if not PIGA["AHPlus"]["SimpleMode"] then SellListF.tishibut:Show() end
				SellListF.tishibut_txt:SetText(BROWSE_NO_RESULTS);
			end
		end
	end)
	AuctionsItemButton.itemTypeDD = PIGFontString(AuctionsItemButton,{"BOTTOMLEFT",AuctionsItemButton,"TOPLEFT",64,0},nil,"OUTLINE")
	AuctionsItemButton.itemTypeDD:SetTextColor(0, 1, 1, 1)
	AuctionsItemButton:HookScript("OnEvent",function(self,event,arg1,arg2)
		if event=="NEW_AUCTION_UPDATE" then
			AuctionsItemButtonCount:Hide();
			AuctionsStackSizeEntry:Hide();
			AuctionsStackSizeMaxButton:Hide();
			AuctionsNumStacksEntry:Hide();
			AuctionsNumStacksMaxButton:Hide();
			PriceDropDown:Hide();
			SellListF.updateG=nil
			local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
			if (C_WowTokenPublic.IsAuctionableWowToken(itemID)) then
				SellListF:Hide()
			else
				AuctionsItemButton.itemTypeDD:SetText("");
				SellListF:SetShown(name)
				if name then
					AuctionsItemButton.OldName=name
					local _, itemType, itemSubType, _, _, classID=C_Item.GetItemInfoInstant(itemID)
					local XclassID=tostring(classID)
					local StackingNum=PIGA["AHPlus"]["Stacking"][XclassID]
					local classStack="("..ACTION_SPELL_AURA_APPLIED_DOSE
					if StackingNum then
						classStack=classStack..StackingNum..")"
					else
						classStack=classStack..DEFAULT..")"
					end
					AuctionsItemButton.itemTypeDD:SetText(itemType..classStack);
					if ( totalCount > 1 ) then
						if StackingNum and totalCount>=StackingNum then
							AuctionsStackSizeEntry:SetText(StackingNum);
						end
						AuctionsStackSizeEntry:Show();
						AuctionsStackSizeMaxButton:Show();
						AuctionsNumStacksEntry:Show();
						AuctionsNumStacksMaxButton:Show();
						PriceDropDown:Show();
						UpdateMaximumButtons();
					end
					ClearSearchList()
				end
			end
		end
	end)

	-----背包物品==========
	if PIGA["AHPlus"]["SimpleMode"] then
		tabBagF.tishitxt="背包物品(按住Shift左键点击)"
	else
		tabBagF.tishitxt="背包物品(右键点击查询)"
	end
	tabBagF.bagitemtxt = PIGFontString(tabBagF,{"BOTTOMLEFT", tabBagF, "TOPLEFT", 6,0},tabBagF.tishitxt,"OUTLINE",nil,nil,"OVERLAY")
	tabBagF.bagitemtxt:SetTextColor(1, 1, 0, 1)
	local RuiD={
		meihang=8,
		topoffV=-30,
		jiangeV=-22,
		ActionW = 30,
		hangNum=0,
		classCount=0,
	}
	local classHebing={
		{0,5},
		{3,7,8,9},
		{12,15},
		{2,4,6},
	}
	local function GetClassHebing(cid)
		for i=1,#classHebing do
			for ii=1,#classHebing[i] do
				if cid==classHebing[i][ii] then
					return i
				end
			end
		end
		return #classHebing+1
	end
	tabBagF.dianjilaiyuan=nil
	tabBagF.sellItemBut={}
	tabBagF.className={}
	tabBagF.classNameYes={}
	tabBagF.classBiaoti={}
	tabBagF.classData={}
	tabBagF.itemCount={}
	local bagitemindex=0
	local bagIDMax= addonTable.Data.bagData["bagIDMax"]	
	local function RegisterClickFun(itemButton)
		if PIGA["AHPlus"]["SimpleMode"] then
			itemButton:HookScript("PreClick",  function (self,button)
				if IsShiftKeyDown() then
					if AuctionFrame.selectedTab==3 then
						AuctionFrame.dianjilaiyuan=AuctionFrame.selectedTab
						local itemID=PIGGetContainerItemInfo(self:GetParent():GetID(), self:GetID())
						if itemID then
							if IsAddOnLoaded("Blizzard_AuctionUI") then AuctionFrameTab_OnClick(AuctionFrameTab1) end
						end
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
				else
					PIG_OptionsUI:ErrorMsg("按住Shift左键点击")
				end
			end)
		else
			itemButton:SetScript("OnClick", function(self, button)
				if button== "RightButton" then
					if AuctionFrame.selectedTab==1 then
						local info = C_Container.GetContainerItemInfo(self:GetParent():GetID(), self:GetID());
						BrowseName:SetText('"'..info.itemName..'"')
						AuctionFrameBrowse_Search()
					elseif AuctionFrame.selectedTab==3 then
						C_Container.UseContainerItem(self:GetParent():GetID(), self:GetID(), nil, nil, BankFrame:IsShown() and (BankFrame.selectedTab == 2));
					end
				end
			end)
		end
	end
	function tabBagF:UpdateAllList()
		if not self:IsShown() then return end
		wipe(tabBagF.className)
		wipe(tabBagF.classNameYes)
		wipe(tabBagF.classData)
		wipe(tabBagF.itemCount)
		--提取物品
		for index,itemButton in pairs(tabBagF.sellItemBut) do
			itemButton:Show()
			itemButton:ClearAllPoints();
			local itemID, itemLink, texture, itemCount, quality, noValue, lootable, locked, isBound=PIGGetContainerItemInfo(itemButton:GetParent():GetID(), itemButton:GetID())
			if itemID and not isBound then
				--local sellPrice= select(11, C_Item.GetItemInfo(itemID))
				SetItemButtonTexture(itemButton, texture);
				SetItemButtonQuality(itemButton, quality, itemID);
				SetItemButtonDesaturated(itemButton, locked);
				local _, itemType, itemSubType, _, _, classID, subClassID=C_Item.GetItemInfoInstant(itemID)
				local Nid=GetClassHebing(classID)
				if not tabBagF.itemCount[itemID] then
					tabBagF.itemCount[itemID]=itemCount
					if not tabBagF.classNameYes[classID] then
						tabBagF.classNameYes[classID]=itemType
						if tabBagF.className[Nid] then
							tabBagF.className[Nid]=tabBagF.className[Nid].."/"..itemType
						else
							tabBagF.className[Nid]=itemType
						end
					end
					if not tabBagF.classData[Nid] then
						tabBagF.classData[Nid]={}
					end
					table.insert(tabBagF.classData[Nid],{itemButton,itemID})
				else
					tabBagF.itemCount[itemID]=tabBagF.itemCount[itemID]+itemCount
				end
			end
		end
		--排序
		RuiD.hangNum,RuiD.classCount=0,0
		for Nid,itemButD in pairs(tabBagF.classData) do
			RuiD.classCount=RuiD.classCount+1
			if not tabBagF.classBiaoti[Nid] then
				tabBagF.classBiaoti[Nid] = PIGFontString(tabBagF,nil,tabBagF.className[Nid],"OUTLINE",nil,nil,"OVERLAY")
				tabBagF.classBiaoti[Nid]:SetTextColor(0, 1, 0, 1)
			end
			tabBagF.classBiaoti[Nid]:ClearAllPoints();
			tabBagF.classBiaoti[Nid]:SetPoint("TOPLEFT", tabBagF, "TOPLEFT", 4,RuiD.jiangeV*(RuiD.classCount-1)-(RuiD.hangNum*RuiD.ActionW)-6);
			for id=1,#itemButD do
				local itemButton,itemID=itemButD[id][1],itemButD[id][2]
				SetItemButtonCount(itemButton, tabBagF.itemCount[itemID]);
				if id==1 then
					RuiD.hangNum=RuiD.hangNum+1
					itemButton:SetPoint("TOPLEFT",tabBagF.classBiaoti[Nid],"BOTTOMLEFT",0,-2)
				else
					local tmp1,tmp2 = math.modf((id-1)/RuiD.meihang)
					if tmp2==0 then
						RuiD.hangNum=RuiD.hangNum+1
						itemButton:SetPoint("TOPLEFT",itemButD[id-RuiD.meihang][1],"BOTTOMLEFT",0,0)
					else
						itemButton:SetPoint("LEFT",itemButD[id-1][1],"RIGHT",0,0)
					end
				end
			end
		end
	end
	for bag=0,bagIDMax do
		local BagFf = CreateFrame("Frame",nil,tabBagF)
		BagFf:SetID(bag)
		BagFf:RegisterEvent("ITEM_LOCK_CHANGED");
		BagFf:SetScript("OnEvent", function(self,event,bag, slot)
			if ( bag and slot and (bag == self:GetID()) ) then
				for ixx=1,#tabBagF.sellItemBut do
					local ItemButID=tabBagF.sellItemBut[ixx]
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
			tabBagF.sellItemBut[bagitemindex]=itembutx
			itembutx:SetSize(RuiD.ActionW,RuiD.ActionW)
			if NDuiopen or ElvUIopen then
				itembutx.icon:SetTexCoord(0.1,0.9,0.1,0.9)
			end
			if itembutx.IconBorder then itembutx.IconBorder:SetAlpha(0) end
			local NormalTexture = _G[itembutx:GetName().."NormalTexture"]
			if NormalTexture then NormalTexture:SetTexture("") end
			if itembutx.BattlepayItemTexture then itembutx.BattlepayItemTexture:SetTexture("") end
			if PIGA["AHPlus"]["SimpleMode"] then
				itembutx:RegisterForClicks("LeftButtonUp")
			else
				itembutx:RegisterForClicks("RightButtonUp")
			end
			RegisterClickFun(itembutx)
		end
	end
	AuctionFrameBrowse:HookScript("OnShow",function(self)
		CZ_BrowseSearchButton()
	end)
	tabBagF:HookScript("OnShow",function(self)
		tabBagF:RegisterEvent("BAG_UPDATE")
	end)
	tabBagF:HookScript("OnHide", function(self)
		tabBagF:UnregisterEvent("BAG_UPDATE")
	end);
	tabBagF:SetScript("OnEvent", function(self,event,bag, slot)
		self:UpdateAllList()
	end)
	--快速购买===============
	fastBuyF.t1 = PIGFontString(fastBuyF,{"BOTTOMLEFT",fastBuyF,"TOPLEFT",4,3},"本次购买清单","OUTLINE")
	fastBuyF.hejit = PIGFontString(fastBuyF,{"BOTTOMLEFT",fastBuyF,"BOTTOMLEFT",4,8},TOTAL..COSTS_LABEL,"OUTLINE")
	fastBuyF.hejitG = PIGFontString(fastBuyF,{"LEFT",fastBuyF.hejit,"RIGHT",4,0},0,"OUTLINE")
	fastBuyF.ButList={}
	fastBuyF.buyHistory={}
	fastBuyF.buyHistoryLin={}
	local fastBuyhangH,allnumhang=38,10
	fastBuyF.ScrollF=Create.PIGScrollFrame_old(fastBuyF,{0,0,0,30})
	function fastBuyF.ScrollF:UpdateShowList()
		if not fastBuyF:IsShown() then return end
	    for _,v in pairs(fastBuyF.ButList) do
	    	v:Hide()
	    end
	    local datainfo=fastBuyF.buyHistory
		local TotalNum=#datainfo
		if TotalNum>0 then
			local offset = self:GetScrollFrameOffset(TotalNum, allnumhang, fastBuyhangH)
		    for i = 1, allnumhang do
				local AHdangqianH = i+offset;
				if datainfo[AHdangqianH] then
					if not fastBuyF.ButList[i] then
						fastBuyF.ButList[i] = CreateFrame("Button", nil, fastBuyF)
						fastBuyF.ButList[i]:SetSize(listRhangW,fastBuyhangH);
						fastBuyF.ButList[i]:SetPoint("TOPLEFT",fastBuyF,"TOPLEFT",4,-((i-1)*fastBuyhangH));
						fastBuyF.ButList[i].hightex = fastBuyF.ButList[i]:CreateTexture(nil,"HIGHLIGHT");
						fastBuyF.ButList[i].hightex:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
						fastBuyF.ButList[i].hightex:SetAllPoints(fastBuyF.ButList[i])
						fastBuyF.ButList[i].hightex:SetBlendMode("ADD")
						fastBuyF.ButList[i].hightex:SetAlpha(0.4);
						fastBuyF.ButList[i].name = PIGFontString(fastBuyF,{"TOPLEFT",fastBuyF.ButList[i],"TOPLEFT",0,0},nil,"OUTLINE")
						fastBuyF.ButList[i].name:SetTextColor(1,1,1,1)
						fastBuyF.ButList[i].MoneyG = PIGFontString(fastBuyF,{"TOPLEFT",fastBuyF.ButList[i],"TOPLEFT",0,-fastBuyhangH*0.5+2},nil,"OUTLINE")
					end
					local listFGV = fastBuyF.ButList[i]
					listFGV:Show()
					local itemname=datainfo[AHdangqianH]
					listFGV.name:SetText(itemname.." |cff00FFFFx"..fastBuyF.buyHistoryLin[itemname][1].."|r")
					listFGV.MoneyG:SetText(COSTS_LABEL..GetMoneyString(fastBuyF.buyHistoryLin[itemname][2]))
				end
			end
		end
	end
	function fastBuyF:UpdateAllList()
	    fastBuyF.hejitGV=0
	    for k,v in pairs(fastBuyF.buyHistoryLin) do
	    	fastBuyF.hejitGV=fastBuyF.hejitGV+v[2]
	    end
		fastBuyF.hejitG:SetText(GetCoinTextureString(fastBuyF.hejitGV))
		fastBuyF.ScrollF:UpdateShowList()
	end
	hooksecurefunc("PlaceAuctionBid", function(type, index, buyoutG)
		local name, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, owner =  GetAuctionItemInfo("list", index);
		if buyoutPrice==buyoutG then
			if not fastBuyF.buyHistoryLin[name] then
				table.insert(fastBuyF.buyHistory,name)
				fastBuyF.buyHistoryLin[name]={count,buyoutPrice}
			else
				fastBuyF.buyHistoryLin[name][1]=fastBuyF.buyHistoryLin[name][1]+count
				fastBuyF.buyHistoryLin[name][2]=fastBuyF.buyHistoryLin[name][2]+buyoutPrice
			end
		end
		fastBuyF:UpdateAllList()
	end)
	fastBuyF:HookScript("OnShow",function(self)
		fastBuyF:UpdateAllList()
	end)
	--浏览页
	--AuctionFrameBrowse:HookScript("OnShow",)
	--拍卖页
	AuctionFrameAuctions:HookScript("OnShow",function(self)
		self.oldaucG:SetChecked(PIGA["AHPlus"]["oldaucG"])
		self.DurationCheck:SetChecked(PIGA["AHPlus"]["SaveDuration"])
		--ClearSearchList()
	end)
	------
	AuctionFrame.SetTopUI:HookScript("OnShow",function(self)
		self.exact:SetChecked(PIGA["AHPlus"]["exactMatch"])
		self.fastBuy:SetChecked(PIGA["AHPlus"]["fastBuy"])
		self.SimpleMode:SetChecked(PIGA["AHPlus"]["SimpleMode"])
	end)
	AuctionFrame.listR:Update_Tablist()
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
	local function TradeSkill_ShowHide(bot)
		if bot then
			if PIGA["AHPlus"]["AHUIoff"] then
				if TradeSkillFrame and TradeSkillFrame:IsShown() then
					UIPanelWindows[TradeSkillFrame].width = 20
				end
				if CraftFrame and CraftFrame:IsShown() then
					UIPanelWindows[CraftFrame].width = 20
				end
			end
		else
			if PIGA["AHPlus"]["AHUIoff"] then
				if TradeSkillFrame and TradeSkillFrame:IsShown() then
					UIPanelWindows[TradeSkillFrame].width = 713
				end
				if CraftFrame and CraftFrame:IsShown() then
					UIPanelWindows[CraftFrame].width = 713
				end
			end
		end
	end
	AuctionFrame:HookScript("OnShow",function(self)
		wipe(fastBuyF.buyHistory)
		wipe(fastBuyF.buyHistoryLin)
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
		TradeSkill_ShowHide(true)
	end)
	AuctionFrame:HookScript("OnHide", function(self)
		AuctionsItemButton.OldName=nil
		AuctionsItemButton.OldGlist={}
		SellListF.CacheBuy={}
		for k,v in pairs(OLD_CVarName) do
			SetCVar(k, v)
		end
		TradeSkill_ShowHide(false)
	end);
end