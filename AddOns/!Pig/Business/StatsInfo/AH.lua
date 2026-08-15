local addonName, PD = ...;
local BusinessInfo=PD.BusinessInfo
function BusinessInfo.AH(StatsUI)
	local L=PD.locale
	local match = _G.string.match
	local Fun=PD.Fun
	--
	local Create=PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGFontString=Create.PIGFontString
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGButton=Create.PIGButton
	local PIGDiyBut=Create.PIGDiyBut
	------
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsUI.F,AUCTIONS,StatsUI.butW,"LeftH")
	local hang_Height,hang_NUM  = 23, 17;

	fujiF.L=PIGFrame(fujiF)
	fujiF.L:PIGSetBackdrop(0)
	fujiF.L:SetWidth(540)
	fujiF.L:SetPoint("TOPLEFT",fujiF,"TOPLEFT",0,0);
	fujiF.L:SetPoint("BOTTOMLEFT",fujiF,"BOTTOMLEFT",0,0);
	fujiF.L.Focus = PIGDiyBut(fujiF.L,{"TOPLEFT",fujiF.L,"TOPLEFT",16,-2},{hang_Height,hang_Height,hang_Height+8,hang_Height+8,604882,nil,0,-3})
	fujiF.L.Focus:HookScript("OnClick", function(self)
		fujiF.SearchName=nil
		SearchBoxTemplate_ClearText(fujiF.L.Search);
		fujiF.Update_List();
	end)
	fujiF.L.Search = CreateFrame("EditBox", nil, fujiF.L, "SearchBoxTemplate");
	fujiF.L.Search:SetSize(260,24);
	fujiF.L.Search:SetPoint("LEFT",fujiF.L.Focus,"RIGHT",18,-1);
	fujiF.L.Search:SetScript("OnTextChanged", function(self)
		SearchBoxTemplate_OnTextChanged(self);
		fujiF.SearchName=self:GetText()
		fujiF.Update_List();
	end)
	fujiF.L.Search:SetScript("OnEnterPressed", function(self) 
		SearchBoxTemplate_OnTextChanged(self);
		fujiF.SearchName=self:GetText()
		fujiF.Update_List();
	end)
	--
	fujiF.L.NR=PIGFrame(fujiF.L)
	fujiF.L.NR:SetPoint("TOPLEFT",fujiF.L,"TOPLEFT",0,-30);
	fujiF.L.NR:SetPoint("BOTTOMRIGHT",fujiF.L,"BOTTOMRIGHT",0,0);
	fujiF.L.NR:PIGSetBackdrop(0)
	fujiF.L.NR.BotF=PIGFrame(fujiF.L.NR)
	fujiF.L.NR.BotF:SetPoint("TOPLEFT",fujiF.L.NR,"TOPLEFT",0,-24);
	fujiF.L.NR.BotF:SetPoint("BOTTOMRIGHT",fujiF.L.NR,"BOTTOMRIGHT",0,0);
	fujiF.L.NR.BotF:PIGSetBackdrop(0)
	local biaotiList = {{L["TRADEAH_FOCUS"],2},{ITEM_NAMES,50},{AUCTION_BROWSE_UNIT_PRICE_SORT,-160},{L["TIME"],-26}}
	for i=1,#biaotiList do
		local biaotiname = PIGFontString(fujiF.L.NR.BotF,nil,biaotiList[i][1],"OUTLINE")
		if i>(#biaotiList-2) then
			biaotiname:SetPoint("BOTTOMRIGHT",fujiF.L.NR.BotF,"TOPRIGHT",biaotiList[i][2],2);
		else
			biaotiname:SetPoint("BOTTOMLEFT", fujiF.L.NR.BotF, "TOPLEFT",biaotiList[i][2], 2);
		end
		biaotiname:SetTextColor(1, 1, 0.8, 0.9); 
	end
	fujiF.L.NR.BotF.Scroll = CreateFrame("ScrollFrame",nil,fujiF.L.NR.BotF, "FauxScrollFrameTemplate");  
	fujiF.L.NR.BotF.Scroll:SetPoint("TOPLEFT",fujiF.L.NR.BotF,"TOPLEFT",0,-2);
	fujiF.L.NR.BotF.Scroll:SetPoint("BOTTOMRIGHT",fujiF.L.NR.BotF,"BOTTOMRIGHT",-17,1);
	fujiF.L.NR.BotF.Scroll.ScrollBar:SetScale(0.7)
	fujiF.L.NR.BotF.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fujiF.Update_List)
	end)
	fujiF.L.NR.BotF.ButLsit={}
	-----
	function fujiF.Update_List()
		if not fujiF:IsVisible() then return end
		for _,but in pairs(fujiF.L.NR.BotF.ButLsit) do
			but:Hide();
		end
		fujiF.DQShowData = {{},{},{}}
		fujiF.DQShowData[1]= BusinessInfo.GetCacheDataG()
		if next(fujiF.DQShowData[1]) == nil then return end
		for k,v in pairs(PIGA["AHPlus"]["Coll"]) do
			fujiF.DQShowData[2][v[1]]=v[2]
		end
		for k,v in pairs(fujiF.DQShowData[1]) do
			local Isadddata=false
			if fujiF.SearchName and fujiF.SearchName~="" and fujiF.SearchName~=" " and #fujiF.SearchName>1 then
				if k:match(fujiF.SearchName) then
					Isadddata=true
				end
			else
				if fujiF.DQShowData[2][k] then
					Isadddata=true
				end
			end
			if Isadddata then
				local MaxNum = #v[2]
				table.insert(fujiF.DQShowData[3],{k,v[3],v[1],v[2][MaxNum][1],v[2][MaxNum][2]})
			end
		end
		local ItemsNum = #fujiF.DQShowData[3];
		local ScrollUI=fujiF.L.NR.BotF.Scroll
	    FauxScrollFrame_Update(ScrollUI, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(ScrollUI);
	    for id = 1, hang_NUM do
			local dangqian = id+offset;
			if fujiF.DQShowData[3][dangqian] then
				if not fujiF.L.NR.BotF.ButLsit[id] then
					local hang = CreateFrame("Button", nil, fujiF.L.NR.BotF);
					fujiF.L.NR.BotF.ButLsit[id]=hang
					hang:SetSize(fujiF.L.NR.BotF:GetWidth()-4,hang_Height+2);
					if id==1 then
						hang:SetPoint("TOPLEFT", fujiF.L.NR.BotF, "TOPLEFT", 0, -1);
					else
						hang:SetPoint("TOPLEFT",fujiF.L.NR.BotF.ButLsit[id-1], "BOTTOMLEFT", 0, -1.6);
					end
					hang.highlight = hang:CreateTexture(nil,"HIGHLIGHT");
					hang.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
					hang.highlight:SetBlendMode("ADD")
					hang.highlight:SetPoint("TOPLEFT", hang, "TOPLEFT", 1,-1);
					hang.highlight:SetPoint("BOTTOMRIGHT", hang, "BOTTOMRIGHT", -10,1);
					hang.highlight:SetAlpha(0.3);
					hang.highlight1 = hang:CreateTexture();
					hang.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
					hang.highlight1:SetDrawLayer("BORDER", -1)
					hang.highlight1:SetPoint("TOPLEFT", hang, "TOPLEFT", 1,-1);
					hang.highlight1:SetPoint("BOTTOMRIGHT", hang, "BOTTOMRIGHT", -10,1);
					hang.highlight1:SetAlpha(0.7);
					hang.highlight1:Hide();
					hang.attention = PIGDiyBut(hang,{"LEFT", hang, "LEFT", 0,0},{hang_Height,hang_Height,hang_Height+3,hang_Height+3,604882,nil,0,-2})
					hang.attention:SetScript("OnClick", function (self)
						local collname = self:GetParent().collname
						if collname then
							for ixx=1,#PIGA["AHPlus"]["Coll"] do
								if PIGA["AHPlus"]["Coll"][ixx][1]==collname then
									table.remove(PIGA["AHPlus"]["Coll"],ixx)
									fujiF.Update_List()
									return
								end
							end
							local itemID=self:GetParent().itemID
							local itemIcon=C_Item.GetItemIconByID(itemID)
							local itemquality=C_Item.GetItemQualityByID(itemID)
							table.insert(PIGA["AHPlus"]["Coll"],{collname,itemIcon,itemquality,itemID})
						end
						fujiF.Update_List()
					end)
					hang.icon = PIGDiyBut(hang,{"LEFT", hang.attention, "RIGHT", 2, 0},{hang_Height-2,hang_Height-2,hang_Height-2,hang_Height-2})
					hang.icon:SetScript("OnEnter", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
						GameTooltip:SetHyperlink(self.itemLink);
						GameTooltip:Show();
					end);
					hang.icon:SetScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
					hang.name = PIGFontString(hang,{"LEFT", hang.icon, "RIGHT", 2, 0},nil,"OUTLINE")
					hang.itemG = PIGFontString(hang,{"RIGHT", hang, "RIGHT", biaotiList[3][2], 0},nil,"OUTLINE")
					hang.itemG:SetTextColor(0, 1, 1, 1); 
					hang.time = PIGFontString(hang,{"RIGHT", hang, "RIGHT", biaotiList[4][2], 0},nil,"OUTLINE")
					hang.time:SetTextColor(0.8, 0.8, 0.8, 0.9); 
					hang:SetScript("OnClick", function (self)
						PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
						fujiF.R.SelectItem=self.collname
						fujiF.R.itemicon:SetTexture(self.icon.icon:GetTexture())
						fujiF.R.itemName:SetText(self.icon.itemLink)
						fujiF.Update_List()
					end)
					function hang:ShowInfoFun(itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture)
						self.icon.itemLink=itemLink
						self.icon.icon:SetTexture(itemTexture)
						self.name:SetText(itemLink)
					end
				end
				local hang = fujiF.L.NR.BotF.ButLsit[id]
				hang:Show();
				hang.collname=fujiF.DQShowData[3][dangqian][1]
				hang.highlight1:SetShown(fujiF.R.SelectItem==hang.collname)
				hang.itemG:SetText(GetMoneyString(fujiF.DQShowData[3][dangqian][4]))
				local jiluTime = date("%m-%d %H:%M",fujiF.DQShowData[3][dangqian][5])
				hang.time:SetText(jiluTime)
				if fujiF.DQShowData[2][fujiF.DQShowData[3][dangqian][1]] then
					hang.attention.icon:SetDesaturated(false)
				else
					hang.attention.icon:SetDesaturated(true)
				end
				hang.itemID=fujiF.DQShowData[3][dangqian][2]
				Fun.HY_ShowItemLink(hang,fujiF.DQShowData[3][dangqian][2],fujiF.DQShowData[3][dangqian][3])
				fujiF.Update_Trend()
			end
		end
	end
	--
	local hang_NUMLS=8
	fujiF.R=PIGFrame(fujiF)
	fujiF.R:PIGSetBackdrop(0)
	fujiF.R:SetPoint("TOPLEFT",fujiF.L,"TOPRIGHT",-1,0);
	fujiF.R:SetPoint("BOTTOMRIGHT",fujiF,"BOTTOMRIGHT",0,0);
	fujiF.R.itemicon = fujiF.R:CreateTexture();
	fujiF.R.itemicon:SetPoint("TOPLEFT",fujiF.R,"TOPLEFT",6,-2);
	fujiF.R.itemicon:SetSize(hang_Height-4,hang_Height-4);
	fujiF.R.itemName = PIGFontString(fujiF.R,{"LEFT",fujiF.R.itemicon,"RIGHT",0,0})
	fujiF.R.itemNamels = PIGFontString(fujiF.R,{"LEFT",fujiF.R.itemName,"RIGHT",10,0},L["TRADECHARDATA_AHHISTPRICE"])
	fujiF.R.TOP=PIGFrame(fujiF.R)
	fujiF.R.TOP:PIGSetBackdrop(0)
	fujiF.R.TOP:SetPoint("TOPLEFT",fujiF.R,"TOPLEFT",0,-40);
	fujiF.R.TOP:SetPoint("TOPRIGHT",fujiF.R,"TOPRIGHT",0,0);
	fujiF.R.TOP:SetHeight((hang_Height+2)*hang_NUMLS)
	local biaotiListLS = {{AUCTION_BROWSE_UNIT_PRICE_SORT,-170},{L["TIME"],-36}}
	for i=1,#biaotiListLS do
		local biaotiname = PIGFontString(fujiF.R.TOP,nil,biaotiListLS[i][1],"OUTLINE")
		biaotiname:SetPoint("BOTTOMRIGHT", fujiF.R.TOP, "TOPRIGHT",biaotiListLS[i][2]-4, 1);
		biaotiname:SetTextColor(1, 1, 0.8, 0.9); 
	end
	fujiF.R.TOP.Scroll = CreateFrame("ScrollFrame",nil,fujiF.R.TOP, "FauxScrollFrameTemplate");  
	fujiF.R.TOP.Scroll:SetPoint("TOPLEFT",fujiF.R.TOP,"TOPLEFT",2,-2);
	fujiF.R.TOP.Scroll:SetPoint("BOTTOMRIGHT",fujiF.R.TOP,"BOTTOMRIGHT",-19,2);
	fujiF.R.TOP.Scroll.ScrollBar:SetScale(0.8)
	fujiF.R.TOP.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fujiF.Update_Trend)
	end)
	fujiF.R.TOP.ButList={}
	function fujiF.Update_Trend()
		for _,but in pairs(fujiF.R.TOP.ButList) do
			but:Hide()
		end
		local itemData=BusinessInfo.GetCacheDataG(fujiF.R.SelectItem)
		local ItemsNum = #itemData;
		local ScrollUI=fujiF.R.TOP.Scroll
	    FauxScrollFrame_Update(ScrollUI, ItemsNum, hang_NUMLS, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(ScrollUI);
	    for id = 1, hang_NUMLS do
	    	local dangqian = (ItemsNum+1)-id-offset;
			if itemData[dangqian] then
				if not fujiF.R.TOP.ButList[id] then
					local hang = CreateFrame("Button", nil, fujiF.R.TOP);
					fujiF.R.TOP.ButList[id]=hang
					hang:SetSize(fujiF.R.TOP:GetWidth()-4,hang_Height);
					if id==1 then
						hang:SetPoint("TOPLEFT", fujiF.R.TOP, "TOPLEFT", 0, 0);
					else
						hang:SetPoint("TOPLEFT", fujiF.R.TOP.ButList[id-1], "BOTTOMLEFT", 0, -2);
					end
					hang.highlight = hang:CreateTexture(nil,"HIGHLIGHT");
					hang.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
					hang.highlight:SetBlendMode("ADD")
					hang.highlight:SetPoint("TOPLEFT", hang, "TOPLEFT", 0,0);
					hang.highlight:SetPoint("BOTTOMRIGHT", hang, "BOTTOMRIGHT", 0,0);
					hang.highlight:SetAlpha(0.3);
					hang.itemG = PIGFontString(hang,{"RIGHT", hang, "RIGHT", biaotiListLS[1][2], 0},nil,"OUTLINE")
					hang.itemG:SetTextColor(0, 1, 1, 1); 
					hang.time = PIGFontString(hang,{"RIGHT", hang, "RIGHT", biaotiListLS[2][2], 0},nil,"OUTLINE")
					hang.time:SetTextColor(0.8, 0.8, 0.8, 0.9);
				end
				local fujix = fujiF.R.TOP.ButList[id]
				fujix:Show();
				fujix.itemG:SetText(GetMoneyString(itemData[dangqian][1]))
				local jiluTime = date("%m-%d %H:%M",itemData[dangqian][2])
				fujix.time:SetText(jiluTime)
			end
		end
		fujiF.R.BOTTOM.qushiF.UpdateList(itemData)
	end
	--趋势
	fujiF.R.BOTTOM=PIGFrame(fujiF.R)
	fujiF.R.BOTTOM:SetPoint("TOPLEFT",fujiF.R.TOP,"BOTTOMLEFT",0,0);
	fujiF.R.BOTTOM:SetPoint("BOTTOMRIGHT",fujiF.R,"BOTTOMRIGHT",0,0);
	fujiF.R.BOTTOM.qushiF=BusinessInfo.ADD_qushi(fujiF.R.BOTTOM)
	---
	fujiF:HookScript("OnShow", function(self)
		self.Update_List()
	end)
end
