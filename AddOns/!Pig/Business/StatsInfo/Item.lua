local addonName, addonTable = ...;
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.Item(StatsUI)
	local L=addonTable.locale
	local fmod=math.fmod
	local match = _G.string.match
	--
	local Create=addonTable.Create
	local PIGLine=Create.PIGLine
	local PIGFrame=Create.PIGFrame
	local PIGFontString=Create.PIGFontString
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGTabBut=Create.PIGTabBut
	------
	local Data=addonTable.Data
	local TalentData=Data.TalentData
	local InvSlot=Data.InvSlot
	local bagData=Data.bagData
	local Fun=addonTable.Fun
	local GetEquipmTXT=Fun.GetEquipmTXT
	local GetRuneData=Fun.GetRuneData
	local GetItemLinkJJ=Fun.GetItemLinkJJ
	local HY_ItemLinkJJ=Fun.HY_ItemLinkJJ
	--------
	local GetItemInfo=GetItemInfo or C_Item and C_Item.GetItemInfo
	-----------
	local itembutW=40
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsUI.F,ITEMS,StatsUI.butW,"LeftH")
	---
	PIGA["StatsInfo"]["Items"][StatsUI.allname]=PIGA["StatsInfo"]["Items"][StatsUI.allname] or {}
	local morenitem={"BAG","BANK","MAIL","C","T","G","R","GUILD"}
	for i=1,#morenitem do
		if not PIGA["StatsInfo"]["Items"][StatsUI.allname][morenitem[i]] then
			PIGA["StatsInfo"]["Items"][StatsUI.allname][morenitem[i]]={}
		end
	end
	local lixianNum,meihang=(#bagData["bankID"])*MAX_CONTAINER_ITEMS+bagData["bankmun"],20
	local toptablist = {{"BANK",BANK},{"BAG",BAGSLOT},{"MAIL",MINIMAP_TRACKING_MAILBOX}}
	fujiF.LF=PIGFrame(fujiF)
	fujiF.LF:SetWidth(190)
	fujiF.LF:PIGSetBackdrop(0)
	fujiF.LF:SetPoint("TOPLEFT",fujiF,"TOPLEFT",0,0);
	fujiF.LF:SetPoint("BOTTOMLEFT",fujiF,"BOTTOMLEFT",0,0);
	fujiF.Scroll_L=BusinessInfo.addhangMode1("item",fujiF.LF)
	
	-------
	fujiF.RF=PIGFrame(fujiF)
	fujiF.RF:SetPoint("TOPLEFT",fujiF.LF,"TOPRIGHT",0,0);
	fujiF.RF:SetPoint("BOTTOMRIGHT",fujiF,"BOTTOMRIGHT",0,0);
	fujiF.RF.TOP=PIGFrame(fujiF.RF)
	fujiF.RF.TOP:SetPoint("TOPLEFT",fujiF.RF,"TOPLEFT",0,0);
	fujiF.RF.TOP:SetPoint("TOPRIGHT",fujiF.RF,"TOPRIGHT",0,0);
	fujiF.RF.TOP:SetHeight(24)
	fujiF.RF.tabbut={}
	for i=1,#toptablist do
		local TabBut = PIGTabBut(fujiF.RF.TOP,{"TOPLEFT",fujiF.RF.TOP,"TOPLEFT",20,-3},{60,22},toptablist[i][2])
		fujiF.RF.tabbut[i]=TabBut
		TabBut.tabname=toptablist[i][1]
		if i==1 then
			fujiF.ItemSelect=toptablist[i][1]
			TabBut:SetPoint("TOPLEFT",fujiF.RF.TOP,"TOPLEFT",20,-3);
		else
			TabBut:SetPoint("TOPLEFT",fujiF.RF.TOP,"TOPLEFT",20+(i*80-80),-3);
		end
		TabBut:HookScript("OnClick", function(self)
			fujiF.ItemSelect=self.tabname
			fujiF:Update_List_R()
		end)
	end
	fujiF.RF.BOTTOM=PIGFrame(fujiF.RF)
	fujiF.RF.BOTTOM:SetPoint("TOPLEFT",fujiF.RF.TOP,"BOTTOMLEFT",2,0);
	fujiF.RF.BOTTOM:SetPoint("BOTTOMRIGHT",fujiF.RF,"BOTTOMRIGHT",-3,3);
	fujiF.RF.BOTTOM:PIGSetBackdrop(0)
	fujiF.RF.listbut={}
	function fujiF.RF:add_hang(i)
		local itemBut
		if PIG_MaxTocversion(100000) then
			itemBut = CreateFrame("Button", nil, fujiF.RF.BOTTOM);
			itemBut:SetHighlightTexture(130718);
			itemBut.icon = itemBut:CreateTexture()
			itemBut.icon:SetAllPoints(itemBut)
		else
			itemBut = CreateFrame("ItemButton", nil, fujiF.RF.BOTTOM);
		end
		fujiF.RF.listbut[i]=itemBut
		itemBut:SetSize(itembutW,itembutW);
		itemBut:SetScale(0.806)
		itemBut:Hide()
		if i==1 then
			itemBut:SetPoint("TOPLEFT",fujiF.RF.BOTTOM,"TOPLEFT",3,-4);
		else
			local yushu=fmod(i-1,meihang)
			if yushu==0 then
				itemBut:SetPoint("TOPLEFT",fujiF.RF.listbut[i-meihang],"BOTTOMLEFT",0,-2);
			else
				itemBut:SetPoint("LEFT",fujiF.RF.listbut[i-1],"RIGHT",1,0);
			end
		end
		itemBut.count =PIGFontString(itemBut,{"BOTTOMRIGHT", itemBut, "BOTTOMRIGHT", 0,1},nil,"OUTLINE",13.4)
		itemBut.count:SetTextColor(1, 1, 1, 1);
		function itemBut:ShowInfoFun(itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture)
			self.itemLink=itemLink
			SetItemButtonTexture(self, itemTexture)
			if itemStackCount>1 then itemBut.count:Show() end
			Fun.Update_ItemButtonZLVranse("L",self,itemLink,itemQuality)
		end
		itemBut:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltip:SetHyperlink(self.itemLink)
			GameTooltip:Show();
		end);
		itemBut:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		itemBut:SetScript("OnMouseUp", function (self)
			if IsShiftKeyDown() then
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()..self.itemLink
				if editBox:HasFocus() then
					editBox:SetText(hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText(hasText);
				end
			end
		end)
	end
	function fujiF:Update_List_R()
		for _,but in pairs(self.RF.listbut) do
			but:Hide()
		end
		self.ItemSelect=self.ItemSelect or "BANK"
		for _,tab in pairs(fujiF.RF.tabbut) do
			tab:Selected(tab.tabname==self.ItemSelect)
		end
		local lixiandata=PIGA["StatsInfo"]["Items"][self.SelectName] and PIGA["StatsInfo"]["Items"][self.SelectName][self.ItemSelect] or {}
		for i=1,#lixiandata do
			if not self.RF.listbut[i] then
				fujiF.RF:add_hang(i)
			end
			local itemBut=self.RF.listbut[i]
			itemBut:Show()
			itemBut.count:SetText(lixiandata[i][2])
			itemBut.itemID=lixiandata[i][3]
			Fun.HY_ShowItemLink(itemBut,lixiandata[i][3],lixiandata[i][1])
		end
	end
	function fujiF:ClickUpdateList()
		fujiF.Scroll_L:Update_list()
		fujiF:Update_List_R()
	end

	----
	function StatsUI:BagLixian()
		if self:IsShown() then
			self:Hide()
		else
			self:Show()
			Create.Show_TabBut_R(self.F,fujiF,fujiTabBut)
			fujiF.SelectName=StatsUI.allname
			fujiF.ItemSelect="BANK"
			fujiF.Scroll_L:Update_list()
		end
	end
	--------------
	local function SAVE_C()
		if InCombatLockdown() then return end
		PIGA["StatsInfo"]["Items"][StatsUI.allname]["C"] = GetEquipmTXT()
		PIGA["StatsInfo"]["Items"][StatsUI.allname]["T"] = TalentData.GetTianfuTXT()
		PIGA["StatsInfo"]["Items"][StatsUI.allname]["G"] = TalentData.GetGlyphTXT()
		PIGA["StatsInfo"]["Items"][StatsUI.allname]["R"] = GetRuneData()
	end
	local function SAVE_item_data(bagID, slot,wupinshujuinfo)
		local XitemLink,XitemCount,XitemID
		local itemID, itemLink, icon, stackCount=PIGGetContainerItemInfo(bagID, slot)
		if itemID then
			local XitemLink = GetItemLinkJJ(itemLink)
			table.insert(wupinshujuinfo, {XitemLink,stackCount,itemID});
		end
	end
	local function SAVE_BAG()
		if InCombatLockdown() then return end
		local wupinshujuinfo = {}
		for bag=1,#bagData["bagID"] do
			for slot=1,PIGGetContainerNumSlots(bagData["bagID"][bag]) do
				SAVE_item_data(bagData["bagID"][bag], slot, wupinshujuinfo)
			end
		end
		PIGA["StatsInfo"]["Items"][StatsUI.allname]["BAG"] = wupinshujuinfo
	end
	local function SAVE_BANK()
		if InCombatLockdown() then return end
		if BankFrame:IsShown() or NDui_BackpackBank and NDui_BackpackBank:IsShown() then
			local wupinshujuinfo = {}
			local BANKgezishu=0
			for f=1,#bagData["bankID"] do
				if f==1 then
					BANKgezishu=bagData["bankmun"]
				else
					BANKgezishu=PIGGetContainerNumSlots(bagData["bankID"][f])
				end
				for slot=1,BANKgezishu do
					SAVE_item_data(bagData["bankID"][f], slot,wupinshujuinfo)
				end
			end
			PIGA["StatsInfo"]["Items"][StatsUI.allname]["BANK"] = wupinshujuinfo
		end
	end
	local function SAVE_GUILDBANK_item_data(bagID, slot,wupinshujuinfo)
		local itemLink = GetGuildBankItemLink(bagID, slot)
		if itemLink then
			local texture, itemCount= GetGuildBankItemInfo(bagID, slot)
			local itemID = PIGGetItemInfoInstant(itemLink) 
			local XitemLink = GetItemLinkJJ(itemLink)
			table.insert(wupinshujuinfo, {XitemLink,itemCount,itemID});
		end
	end
	local function SAVE_GUILDBANK()
		if InCombatLockdown() then return end
		if GuildBankFrame and GuildBankFrame:IsShown() then
			local wupinshujuinfo = {}
			for i=1,6 do
				local name, icon, isViewable = GetGuildBankTabInfo(i)
				if isViewable then
					for slot=1,98 do
						SAVE_GUILDBANK_item_data(i,slot,wupinshujuinfo)
					end
				end
			end
			PIGA["StatsInfo"]["Items"][StatsUI.allname]["GUILD"] = wupinshujuinfo
		end
	end
	local function SAVE_MAIL()
		local mailData = {}
		for i=1, GetInboxNumItems() do
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i);
			if (itemCount and CODAmount == 0) then
				for n=1,ATTACHMENTS_MAX_RECEIVE do
					local itemLink=GetInboxItemLink(i, n);
					if itemLink then
						local XitemLink = GetItemLinkJJ(itemLink)
						local name, XitemID, itemTexture, count, quality, canUse = GetInboxItem(i, n);				
						table.insert(mailData, {XitemLink,count,XitemID});
					end
				end
			end
		end
		PIGA["StatsInfo"]["Items"][StatsUI.allname]["MAIL"]=mailData
	end
	function MailFrame_OnShow(self)
		self:RegisterEvent("MAIL_INBOX_UPDATE");
		self:RegisterEvent("ITEM_PUSH");
		SAVE_MAIL()
	end
	MailFrame:HookScript("OnHide", function(self,event,arg1,arg2)
		fujiF:UnregisterEvent("MAIL_INBOX_UPDATE");
		fujiF:UnregisterEvent("ITEM_PUSH");
	end)
	----
	fujiF:RegisterEvent("PLAYER_ENTERING_WORLD")
	fujiF:SetScript("OnEvent", function(self,event,arg1,arg2)
		if event=="PLAYER_ENTERING_WORLD" then
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
			if arg1 or arg2 then
				if PIG_MaxTocversion(20000) then fujiF:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED") end
				self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
				self:RegisterEvent("PLAYER_TALENT_UPDATE")
				self:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
				self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
				self:RegisterEvent("MAIL_SHOW");
				C_Timer.After(2, function()
					SAVE_C()
					SAVE_BAG()
					self:RegisterEvent("BAG_UPDATE")
				end)
			end
		elseif event == "MAIL_SHOW" then
			MailFrame_OnShow(self)
		elseif event == "ITEM_PUSH" or event == "MAIL_INBOX_UPDATE" then
			SAVE_MAIL()
		elseif event=="PLAYER_EQUIPMENT_CHANGED" or event=="PLAYER_TALENT_UPDATE" then
			SAVE_C()
		elseif event=="BAG_UPDATE" then
			if InCombatLockdown() then return end
			if arg1~=-2 then
				if arg1>=0 and arg1<=bagData["bagIDMax"] then
					SAVE_BAG()
				else
					SAVE_BANK()
				end
			end
		elseif event=="PLAYER_INTERACTION_MANAGER_FRAME_SHOW" and arg1==8 then
			SAVE_BANK()
		elseif event=="PLAYERBANKSLOTS_CHANGED" then
			SAVE_BANK()
		elseif event=="GUILDBANKBAGSLOTS_CHANGED" then
			SAVE_GUILDBANK()
		end
	end)
end