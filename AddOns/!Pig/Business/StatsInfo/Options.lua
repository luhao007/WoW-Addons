local addonName, addonTable = ...;
local L=addonTable.locale
local Create=addonTable.Create
local PIGLine=Create.PIGLine
local PIGEnter=Create.PIGEnter
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList=Create.PIGOptionsList
local PIGFontString=Create.PIGFontString
local PIGModCheckbutton=Create.PIGModCheckbutton
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGQuickBut=Create.PIGQuickBut
local Data=addonTable.Data
local Fun = addonTable.Fun
------
local IsAddOnLoaded=IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
local GetItemInfoInstant=GetItemInfoInstant or C_Item and C_Item.GetItemInfoInstant
---
local BusinessInfo=addonTable.BusinessInfo
local fuFrame,fuFrameBut = BusinessInfo.fuFrame,BusinessInfo.fuFrameBut

local GnName,GnUI,GnIcon,FrameLevel = CHARACTER_INFO..STATISTICS,"PIG_StatsInfoUI",134149,10
BusinessInfo.StatsInfoData={GnName,GnUI,GnIcon,FrameLevel}
------------
function BusinessInfo.StatsInfoOptions()
	local StatsInfoF,StatsInfotabbut =PIGOptionsList_R(BusinessInfo.RTabFrame,GnName,110)

	local QuickButUI_index=9
	local QuickButUI=_G[Data.QuickButUIname]
	local Tooltip = "显示副本CD/专业CD/物品/货币信息/交易/离线拍卖等各种信息记录";
	StatsInfoF.StatsInfo = PIGModCheckbutton(StatsInfoF,{GnName,Tooltip},{"TOPLEFT",StatsInfoF,"TOPLEFT",20,-30})
	StatsInfoF.StatsInfo:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["Open"]=true;
			BusinessInfo.StatsInfo_ADDUI()
			StatsInfoF.ADD_lixianBUT()
		else
			PIGA["StatsInfo"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		StatsInfoF:CheckbutShow()
		QuickButUI.ButList[QuickButUI_index]()
	end);
	StatsInfoF.StatsInfo.QKBut:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["AddBut"]=true
			QuickButUI.ButList[QuickButUI_index]()
		else
			PIGA["StatsInfo"]["AddBut"]=false
			PIG_OptionsUI.RLUI:Show();
		end
	end);
	local GnTooltip = KEY_BUTTON1.."-|cff00FFFF打开"..GnName.."|r\n"..KEY_BUTTON2.."-|cff00FFFF"..SETTINGS.."|r"
	QuickButUI.ButList[QuickButUI_index]=function()
		if PIGA["QuickBut"]["Open"] and PIGA["StatsInfo"]["Open"] and PIGA["StatsInfo"]["AddBut"] then
			if QuickButUI.StatsInfoOpen then return end
			QuickButUI.StatsInfoOpen=true
			local QkBut=PIGQuickBut(nil,GnTooltip,GnIcon,GnUI,FrameLevel)
			QkBut:HookScript("OnClick", function(self,button)
				if button=="RightButton" then
					if PIG_OptionsUI:IsShown() then
						PIG_OptionsUI:Hide()
					else
						PIG_OptionsUI:Show()
						Create.Show_TabBut(fuFrame,fuFrameBut)
						Create.Show_TabBut_R(BusinessInfo.RTabFrame,StatsInfoF,StatsInfotabbut)
					end
				end
			end);
		end
	end
	---
	StatsInfoF.StatsInfo.CZ = PIGButton(StatsInfoF,{"LEFT",StatsInfoF.StatsInfo.QKBut,"RIGHT",260,0},{60,22},RESET);  
	StatsInfoF.StatsInfo.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("INFO_CZQIANGKONGINFO");
	end);
	PIGEnter(StatsInfoF.StatsInfo.CZ,"|cffFF0000重置|r"..GnName.."所有配置")
	StaticPopupDialogs["INFO_CZQIANGKONGINFO"] = {
		text = "此操作将\124cffff0000重置\124r"..GnName.."所有配置，需重载界面。\n确定重置?",
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["StatsInfo"]=addonTable.Default["StatsInfo"];
			PIGA["StatsInfo"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--鼠标提示其他角色数量
	local Tooltip = {"鼠标提示其他角色数量","在物品的鼠标提示显示其他角色数量\n注意:为了节省性能开销，战斗中无效"}
	StatsInfoF.Qita_Num = PIGCheckbutton(StatsInfoF,{"TOPLEFT",StatsInfoF.StatsInfo,"BOTTOMLEFT",0,-20},Tooltip)
	StatsInfoF.Qita_Num:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["Qita_Num"]=true;
		else
			PIGA["StatsInfo"]["Qita_Num"]=false;
		end
	end);
	local qitaDataNum={}
	local greenTexture = "interface/common/indicator-green.blp"
	local CreateIcons = "Interface/Glues/CharacterCreate/CharacterCreateIcons"
	local Texwidth,Texheight = 500,500
	function BusinessInfo.SetTooltipQita_Num(tooltip,itemID)
		if InCombatLockdown() then return end
		if not PIGA["StatsInfo"]["Open"] or not PIGA["StatsInfo"]["Qita_Num"] then return end
		if not itemID then return end
		if itemID==6948 then return end
		wipe(qitaDataNum)
		local itemjihe = PIGA["StatsInfo"]["Items"]
		qitaDataNum.itemziji={}
		local itemzijibag = itemjihe[PIG_OptionsUI.AllName]["BAG"]
		for it=1,#itemzijibag do
			if itemID==itemzijibag[it][3] then
				if qitaDataNum.itemziji[BAGSLOT] then
					qitaDataNum.itemziji[BAGSLOT]=qitaDataNum.itemziji[BAGSLOT]+itemzijibag[it][2]
				else
					qitaDataNum.itemziji[BAGSLOT]=itemzijibag[it][2]
				end
			end
		end
		local itemzijibank = itemjihe[PIG_OptionsUI.AllName]["BANK"]
		for it=1,#itemzijibank do
			if itemID==itemzijibank[it][3] then
				if qitaDataNum.itemziji[BANK] then
					qitaDataNum.itemziji[BANK]=qitaDataNum.itemziji[BANK]+itemzijibank[it][2]
				else
					qitaDataNum.itemziji[BANK]=itemzijibank[it][2]
				end
			end
		end
		local itemzijimail = itemjihe[PIG_OptionsUI.AllName]["MAIL"]
		for it=1,#itemzijimail do
			if itemID==itemzijimail[it][3] then
				if qitaDataNum.itemziji[MINIMAP_TRACKING_MAILBOX] then
					qitaDataNum.itemziji[MINIMAP_TRACKING_MAILBOX]=qitaDataNum.itemziji[MINIMAP_TRACKING_MAILBOX]+itemzijimail[it][2]
				else
					qitaDataNum.itemziji[MINIMAP_TRACKING_MAILBOX]=itemzijimail[it][2]
				end
			end
		end
		local hejishuliang = 0
		local tishneirzj = ""
		for k,v in pairs(qitaDataNum.itemziji) do
			if v>0 then
				hejishuliang=hejishuliang+v
				if tishneirzj=="" then
					tishneirzj=tishneirzj..k.."|cffFFFFFF"..v.."|r"
				else
					tishneirzj=tishneirzj.." "..k.."|cffFFFFFF"..v.."|r"
				end
			end	
		end
		if IsInGuild() then
			local itemzijiGuild = itemjihe[PIG_OptionsUI.AllName]["GUILD"]
			for it=1,#itemzijiGuild do
				if itemID==itemzijiGuild[it][3] then
					if qitaDataNum.itemziji[GUILD] then
						qitaDataNum.itemziji[GUILD]=qitaDataNum.itemziji[GUILD]+itemzijiGuild[it][2]
					else
						qitaDataNum.itemziji[GUILD]=itemzijiGuild[it][2]
					end
				end
			end
		else
			itemjihe[PIG_OptionsUI.AllName]["GUILD"]={}
		end
		local hejishuliang = 0
		local tishneirzj = ""
		for k,v in pairs(qitaDataNum.itemziji) do
			if v>0 then
				hejishuliang=hejishuliang+v
				if tishneirzj=="" then
					tishneirzj=tishneirzj..k.."|cffFFFFFF"..v.."|r"
				else
					tishneirzj=tishneirzj.." "..k.."|cffFFFFFF"..v.."|r"
				end
			end	
		end
		if tishneirzj~="" then
			local pxinxiinfo = PIGA["StatsInfo"]["Players"][PIG_OptionsUI.AllName]
			local _, classFile = PIGGetClassInfo(pxinxiinfo[4])
			local color = PIG_CLASS_COLORS[classFile];
			local Texinfo = C_Texture.GetAtlasInfo(pxinxiinfo[3])
			--local width,height = Texinfo.width,Texinfo.height
			local left=Texinfo.leftTexCoord*Texwidth+0.308
			local right=Texinfo.rightTexCoord*Texwidth+0.5
			local top=Texinfo.topTexCoord*Texheight+0.2
			local bottom=Texinfo.bottomTexCoord*Texheight+0.1
			local ttgghh = "|T"..CreateIcons..":14:14:0:0:"..Texwidth..":"..Texheight..":"..left..":"..right..":"..top..":"..bottom.."|t"
			local ttgghh=ttgghh.." |c"..color.colorStr..PIG_OptionsUI.Name.."|r|T"..greenTexture..":14:14:0:0:16:16:0:14:0:14|t"
			tooltip:AddLine(" ")
			tooltip:AddDoubleLine(ttgghh,tishneirzj)
		end
		---
		qitaDataNum.itemqita={}
		for k,v in pairs(itemjihe) do
			if k~=PIG_OptionsUI.AllName then
				local qitabag = itemjihe[k]["BAG"]
				for it=1,#qitabag do
					if itemID==qitabag[it][3] then
						if qitaDataNum.itemqita[k] then
							qitaDataNum.itemqita[k][2]=qitaDataNum.itemqita[k][2]+qitabag[it][2]
						else
							qitaDataNum.itemqita[k]={BAGSLOT,qitabag[it][2]}
						end
					end
				end
				local qitabank = itemjihe[k]["BANK"]
				for it=1,#qitabank do
					if itemID==qitabank[it][3] then
						if qitaDataNum.itemqita[k] then
							if qitaDataNum.itemqita[k][3] then
								qitaDataNum.itemqita[k][4]=qitaDataNum.itemqita[k][4]+qitabank[it][2]
							else
								qitaDataNum.itemqita[k][3]=BANK
								qitaDataNum.itemqita[k][4]=qitabank[it][2]
							end
						else
							qitaDataNum.itemqita[k]={BANK,qitabank[it][2]}
						end
					end
				end
				local qitamail = itemjihe[k]["MAIL"] or {}
				for it=1,#qitamail do
					if itemID==qitamail[it][3] then
						if qitaDataNum.itemqita[k] then
							if qitaDataNum.itemqita[k][3] then
								qitaDataNum.itemqita[k][4]=qitaDataNum.itemqita[k][4]+qitamail[it][2]
							else
								qitaDataNum.itemqita[k][3]=MINIMAP_TRACKING_MAILBOX
								qitaDataNum.itemqita[k][4]=qitamail[it][2]
							end
						else
							qitaDataNum.itemqita[k]={MINIMAP_TRACKING_MAILBOX,qitamail[it][2]}
						end
					end
				end
			end
		end
		for k,v in pairs(qitaDataNum.itemqita) do
			local danjueseshuliang=0
			local tishneir = ""
			if v[2]>0 then
				danjueseshuliang=danjueseshuliang+v[2]
				tishneir=v[1].."|cffFFFFFF"..v[2].."|r"
			end
			if v[4] and v[4]>0 then
				danjueseshuliang=danjueseshuliang+v[4]
				tishneir=tishneir.." "..v[3].."|cffFFFFFF"..v[4].."|r"
			end
			local pxinxiinfo = PIGA["StatsInfo"]["Players"][k]
			local _, classFile = PIGGetClassInfo(pxinxiinfo[4])
			local color = PIG_CLASS_COLORS[classFile];
			local Texinfo = C_Texture.GetAtlasInfo(pxinxiinfo[3])
			if classFile and color.colorStr and Texinfo then
				--local width,height = Texinfo.width,Texinfo.height
				local left=Texinfo.leftTexCoord*Texwidth+0.308
				local right=Texinfo.rightTexCoord*Texwidth+0.5
				local top=Texinfo.topTexCoord*Texheight+0.2
				local bottom=Texinfo.bottomTexCoord*Texheight+0.1
				local ttgghh = "|T"..CreateIcons..":14:14:0:0:"..Texwidth..":"..Texheight..":"..left..":"..right..":"..top..":"..bottom.."|t"
				local ttgghh=ttgghh.." |c"..color.colorStr..k.."|r"
				tooltip:AddDoubleLine(ttgghh,tishneir)
				hejishuliang=hejishuliang+danjueseshuliang
			end
		end
		if hejishuliang>0 then
			tooltip:AddDoubleLine("合计","|cffFFFFFF"..hejishuliang.."|r")
			tooltip:Show()
		end
	end

	local Tooltip = {"背包增加离线银行按钮","在背包增加一个离线银行按钮，也可以查看其他角色物品数量"}
	StatsInfoF.lixianBank = PIGCheckbutton(StatsInfoF,{"LEFT",StatsInfoF.Qita_Num,"RIGHT",220,0},Tooltip)
	StatsInfoF.lixianBank:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["lixianBank"]=true;
			StatsInfoF.ADD_lixianBUT()
		else
			PIGA["StatsInfo"]["lixianBank"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
	end);
	local wwc,hhc = 24,24
	local function add_lixianBut(bagfuji,wwc,hhc)
		if not bagfuji or bagfuji.lixianBut then return end
		bagfuji.lixianBut = CreateFrame("Button",nil,bagfuji, "TruncatedButtonTemplate"); 
		bagfuji.lixianBut:SetNormalTexture(136453); 
		bagfuji.lixianBut:SetHighlightTexture(130718);
		bagfuji.lixianBut:SetSize(wwc-4,hhc-4);
		if bagfuji==ContainerFrameCombinedBags then
			bagfuji.lixianBut:SetPoint("TOPLEFT",bagfuji,"TOPLEFT",210,-38)
		elseif bagfuji==_G[addonTable.BagBankfun.BagUIName] then
			if NDui or ElvUI then
				bagfuji.lixianBut:SetPoint("TOPLEFT",bagfuji,"TOPLEFT",210,-31)
			else
				bagfuji.lixianBut:SetPoint("TOPLEFT",bagfuji,"TOPLEFT",210,-39)
			end
		elseif bagfuji==ElvUI_ContainerFrame then
			bagfuji.lixianBut:SetPoint("TOPLEFT",bagfuji,"TOPLEFT",11,-6)
		else
			bagfuji.lixianBut:SetPoint("TOPLEFT",bagfuji,"TOPLEFT",160,-6)
		end
		bagfuji.lixianBut.Down = bagfuji.lixianBut:CreateTexture(nil, "OVERLAY");
		bagfuji.lixianBut.Down:SetTexture(130839);
		bagfuji.lixianBut.Down:SetAllPoints(bagfuji.lixianBut)
		bagfuji.lixianBut.Down:Hide();
		bagfuji.lixianBut:SetScript("OnMouseDown", function (self)
			self.Down:Show();
		end);
		bagfuji.lixianBut:SetScript("OnMouseUp", function (self)
			self.Down:Hide();
		end);
		PIGEnter(bagfuji.lixianBut,"查看离线银行或其他角色物品")
		bagfuji.lixianBut:SetScript("OnClick",  function (self,button)
			PlaySoundFile(567463, "Master")
			_G[GnUI]:BagLixian()
		end)
	end
	function StatsInfoF.ADD_lixianBUT()
		if not PIGA["StatsInfo"]["Open"] or not PIGA["StatsInfo"]["lixianBank"] then return end
		if Fun.IsElvUI() and ElvUI_ContainerFrame then
			add_lixianBut(ElvUI_ContainerFrame,wwc,hhc)
			return
		end
		if Fun.IsNDui("Bags","Enable") then
			local B, C = unpack(NDui)
			local anniushuS = NDui_BackpackBag.widgetButtons
			local function CreatelixianBut(self)
				local bu = B.CreateButton(self, 22, 22, true, 136453)
				bu:SetPoint("RIGHT", anniushuS[#anniushuS], "LEFT", -3, 0)
				bu:SetScript("OnClick", function()
					PlaySoundFile(567463, "Master")
					_G[GnUI]:BagLixian()
				end)
				bu.title =  "查看离线银行或其他角色物品"
				B.AddTooltip(bu, "ANCHOR_TOP")
				self.lixianBut = bu
				if C.db["Bags"]["HideWidgets"] then bu:Hide() end
				return bu
			end
			anniushuS[#anniushuS+1] = CreatelixianBut(NDui_BackpackBag)
			local function ToggleWidgetButtons(self)
				if C.db["Bags"]["HideWidgets"] then
					self:SetPoint("RIGHT", anniushuS[2], "LEFT", -1, 0)
					B.SetupArrow(self.__texture, "left")
					self.tag:Show()
				else
					self:SetPoint("RIGHT", anniushuS[#anniushuS], "LEFT", -1, 0)
					B.SetupArrow(self.__texture, "right")
					self.tag:Hide()
				end
				self:SetFrameLevel(self:GetFrameLevel()+2)
			end
			ToggleWidgetButtons(NDui_BackpackBag.widgetArrow)
		end
		if ContainerFrameCombinedBags then
			if ContainerFrameCombinedBags then add_lixianBut(ContainerFrameCombinedBags,wwc,hhc) end
		else
			if _G[addonTable.BagBankfun.BagUIName] then add_lixianBut(_G[addonTable.BagBankfun.BagUIName],wwc,hhc) end
		end
	end	
	local BAGhejiElvUINDui = CreateFrame("Frame")
	BAGhejiElvUINDui:RegisterEvent("PLAYER_ENTERING_WORLD");
	BAGhejiElvUINDui:HookScript("OnEvent", function(self,event,arg1,arg2)
		if event=="PLAYER_ENTERING_WORLD" then
			if arg1 or arg2 then
				StatsInfoF.ADD_lixianBUT()
			end
		end
	end)
	---交易
	StatsInfoF.TradeBagOpen = PIGCheckbutton(StatsInfoF,{"TOPLEFT",StatsInfoF.Qita_Num,"BOTTOMLEFT",0,-60},{"交易时打开背包"})
	StatsInfoF.TradeBagOpen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeBagOpen"]=true
			BusinessInfo.StatsInfo_TradeBagOpen()
		else
			PIGA["StatsInfo"]["TradeBagOpen"]=false
			PIG_OptionsUI.RLUI:Show();
		end
	end);
	hooksecurefunc("TradeFrame_OnShow", function(self)
		if PIGA["StatsInfo"]["TradeBagOpen"] then
			if(UnitExists("NPC"))then OpenAllBags() end
		end
	end);
	---
	StatsInfoF.TradeClassLV = PIGCheckbutton(StatsInfoF,{"LEFT",StatsInfoF.TradeBagOpen,"RIGHT",220,0},{"交易界面显示职业等级","在交易界面显示对方职业和等级"})
	StatsInfoF.TradeClassLV:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeClassLV"]=true
			BusinessInfo.StatsInfo_TradeClassLV()
		else
			PIGA["StatsInfo"]["TradeClassLV"]=false
			PIG_OptionsUI.RLUI:Show();
		end
	end);
	function BusinessInfo.StatsInfo_TradeClassLV()
		if not PIGA["StatsInfo"]["TradeClassLV"] then return end
		if TradeFrame.zhiye then return end
		local www,hhh=28,28
		TradeFrame.zhiye = CreateFrame("Button", nil, TradeFrame);
		TradeFrame.zhiye:SetSize(www,hhh);
		TradeFrame.zhiye:SetPoint("TOP", TradeFrame, "TOP", 6, 18);
		TradeFrame.zhiye.Border = TradeFrame.zhiye:CreateTexture(nil, "BORDER");
		if PIG_MaxTocversion(90000,true) then TradeFrame.zhiye:SetFrameLevel(555) end
		TradeFrame.zhiye.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		TradeFrame.zhiye.Border:SetSize(www+24,hhh+24);
		TradeFrame.zhiye.Border:ClearAllPoints();
		TradeFrame.zhiye.Border:SetPoint("CENTER", 10, -12);
		TradeFrame.zhiye.Icon = TradeFrame.zhiye:CreateTexture(nil, "ARTWORK");
		TradeFrame.zhiye.Icon:SetSize(www-9,hhh-9);
		TradeFrame.zhiye.Icon:ClearAllPoints();
		TradeFrame.zhiye.Icon:SetPoint("CENTER");
		TradeFrame.zhiye.Icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		TradeFrame.dengji = CreateFrame("Button", nil, TradeFrame);
		TradeFrame.dengji:SetSize(www+2,hhh);
		TradeFrame.dengji:SetPoint("TOP", TradeFrame, "TOP", 48, -34);
		if PIG_MaxTocversion(90000,true) then TradeFrame.dengji:SetFrameLevel(555) end
		TradeFrame.dengji.Border = TradeFrame.dengji:CreateTexture(nil, "ARTWORK");
		TradeFrame.dengji.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
		TradeFrame.dengji.Border:SetSize(www+28,hhh+24);
		TradeFrame.dengji.Border:ClearAllPoints();
		if PIG_MaxTocversion(90000) then
			TradeFrame.dengji.Border:SetPoint("CENTER", 11, -12);
		else
			TradeFrame.dengji.Border:SetPoint("CENTER", 10, -12);
		end
		TradeFrame.dengji.Text = PIGFontString(TradeFrame.dengji,{"CENTER", TradeFrame.dengji, "CENTER", 0, 0})
		hooksecurefunc("TradeFrame_OnShow", function(self)
			if(UnitExists("NPC"))then
				if Fun.IsElvUI() or Fun.IsNDui() then
					TradeFrame.zhiye.Border:Hide()
					TradeFrame.dengji.Border:Hide()
				end
				if Fun.IsElvUI() then
					TradeFrame.zhiye:SetPoint("TOP", TradeFrame, "TOP", 52, 2);
					TradeFrame.dengji:SetPoint("TOP", TradeFrame, "TOP", 52, -14);
				else
					TradeFrame.zhiye:SetPoint("TOP", TradeFrame, "TOP", 6, 18);
					TradeFrame.dengji:SetPoint("TOP", TradeFrame, "TOP", 48, -34);
				end
				local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("NPC"))];
				TradeFrame.zhiye.Icon:SetTexCoord(unpack(IconCoord));--切出子区域
				local jibie = UnitLevel("NPC")
				TradeFrame.dengji.Text:SetText(jibie)
				if jibie<10 then
					TradeFrame.dengji.Text:SetTextColor(1, 0, 0);
				else
					TradeFrame.dengji.Text:SetTextColor(1, 0.82, 0);
				end
			end 
		end);
	end
	----
	local Tooltip = {"交易通告","通告交易记录(不通告与好友的交易)"};
	StatsInfoF.TradeTongGao = PIGCheckbutton(StatsInfoF,{"TOPLEFT",StatsInfoF.TradeBagOpen,"BOTTOMLEFT",0,-20},Tooltip)
	StatsInfoF.TradeTongGao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeTongGao"]=true;
		else
			PIGA["StatsInfo"]["TradeTongGao"]=false;
		end
		StatsInfoF:CheckbutShow()
	end);
	local pindaoName = {
		["WHISPER"]="|cffFF80FF"..WHISPER.."|r",
		["PARTY_RAID_INSTANCE_CHAT"]="|cffAAAAFF"..PARTY.."|r/|cffFF7F00"..RAID.."|r/|cffFF7F00"..INSTANCE_CHAT.."|r"};
	local pindaoID = {"WHISPER","PARTY_RAID_INSTANCE_CHAT"};
	StatsInfoF.TradeTongGao.guangbo_dow=PIGDownMenu(StatsInfoF.TradeTongGao,{"LEFT",StatsInfoF.TradeTongGao.Text,"RIGHT", 2,-1},{140})
	function StatsInfoF.TradeTongGao.guangbo_dow:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#pindaoID,1 do
			info.notCheckable=true
		    info.text, info.arg1, info.arg2 = pindaoName[pindaoID[i]], pindaoID[i], pindaoID[i]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function StatsInfoF.TradeTongGao.guangbo_dow:PIGDownMenu_SetValue(value,arg1,arg2)
		self:PIGDownMenu_SetText(value)
		PIGA["StatsInfo"]["TradeTongGaoChannel"]=arg1
		PIGCloseDropDownMenus()
	end
	StatsInfoF.TradeTongGao.guangbo_dow:PIGDownMenu_SetText(pindaoName[PIGA["StatsInfo"]["TradeTongGaoChannel"]])

	StatsInfoF.TradeIsFriend = PIGCheckbutton(StatsInfoF,{"TOPLEFT",StatsInfoF.TradeTongGao,"BOTTOMLEFT",20,-10},{"好友不通报"})
	StatsInfoF.TradeIsFriend:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeIsFriend"]=true;
		else
			PIGA["StatsInfo"]["TradeIsFriend"]=false;
		end
	end);
	StatsInfoF.TradeIsError = PIGCheckbutton(StatsInfoF,{"TOPLEFT",StatsInfoF.TradeIsFriend,"BOTTOMLEFT",0,-10},{"失败不通报"})
	StatsInfoF.TradeIsError:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeIsError"]=true;
		else
			PIGA["StatsInfo"]["TradeIsError"]=false;
		end
	end);
	------
	function StatsInfoF:CheckbutShow()
		self.TradeTongGao.guangbo_dow:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.StatsInfo.QKBut:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.Qita_Num:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.lixianBank:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.TradeClassLV:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.TradeBagOpen:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.TradeTongGao:SetEnabled(PIGA["StatsInfo"]["Open"])
		self.TradeIsFriend:SetEnabled(PIGA["StatsInfo"]["Open"] and PIGA["StatsInfo"]["TradeTongGao"])
		self.TradeIsError:SetEnabled(PIGA["StatsInfo"]["Open"] and PIGA["StatsInfo"]["TradeTongGao"])
	end
	--------
	StatsInfoF:HookScript("OnShow", function (self)
		self.StatsInfo:SetChecked(PIGA["StatsInfo"]["Open"])
		self.StatsInfo.QKBut:SetChecked(PIGA["StatsInfo"]["AddBut"])
		self.Qita_Num:SetChecked(PIGA["StatsInfo"]["Qita_Num"])
		self.lixianBank:SetChecked(PIGA["StatsInfo"]["lixianBank"])
		self.TradeClassLV:SetChecked(PIGA["StatsInfo"]["TradeClassLV"])
		self.TradeBagOpen:SetChecked(PIGA["StatsInfo"]["TradeBagOpen"])
		self.TradeTongGao:SetChecked(PIGA["StatsInfo"]["TradeTongGao"])
		self.TradeIsFriend:SetEnabled(PIGA["StatsInfo"]["TradeIsFriend"])
		self.TradeIsError:SetEnabled(PIGA["StatsInfo"]["TradeIsError"])
		StatsInfoF:CheckbutShow()
	end);
	BusinessInfo.StatsInfo_ADDUI()
	BusinessInfo.StatsInfo_TradeClassLV()
end
