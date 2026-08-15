local addonName, PD = ...;
local L=PD.locale
local Create=PD.Create
local PIGLine=Create.PIGLine
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList=Create.PIGOptionsList
local PIGFontString=Create.PIGFontString
local PIGModCheckbutton=Create.PIGModCheckbutton
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGQuickBut=Create.PIGQuickBut
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
local Fun = PD.Fun
local GetRaceClassTXT=Fun.GetRaceClassTXT
----
local BusinessInfo=PD.BusinessInfo

local GnName,GnUI,GnIcon,FrameLevel = L["TRADECHARDATA_TABNAME"],"PIG_StatsInfoUI",134149,10
BusinessInfo.StatsInfoData={GnName,GnUI,GnIcon,FrameLevel}
------------
local function StatsInfo_TradeClassLV()
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
			TradeFrame.zhiye.Icon:SetTexCoord(unpack(IconCoord));
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
local wwc,hhc = 24,24
local function add_lixianBut(bagfuji,wwc,hhc)
	if not bagfuji or bagfuji.lixianBut then return end
	bagfuji.lixianBut = CreateFrame("Button",nil,bagfuji, "TruncatedButtonTemplate"); 
	bagfuji.lixianBut:SetNormalTexture(136453); 
	bagfuji.lixianBut:SetHighlightTexture(130718);
	bagfuji.lixianBut:SetSize(wwc-4,hhc-4);
	if bagfuji==ContainerFrameCombinedBags then
		bagfuji.lixianBut:SetPoint("TOPLEFT",bagfuji,"TOPLEFT",210,-38)
	elseif bagfuji==_G[PD.BagBankfun.BagUIName] then
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
	PIGEnter(bagfuji.lixianBut,L["TRADECHARDATA_OFFLINEBANKTISP1"])
	bagfuji.lixianBut:SetScript("OnClick",  function (self,button)
		PlaySoundFile(567463, "Master")
		_G[GnUI]:BagLixian()
	end)
end
function ADD_OffBut()
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
			bu.title =  L["TRADECHARDATA_OFFLINEBANKTISP1"]
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
		if _G[PD.BagBankfun.BagUIName] then add_lixianBut(_G[PD.BagBankfun.BagUIName],wwc,hhc) end
	end
end
BusinessInfo.OpenTisp=addonName.."→"..SETTINGS.."→"..L["TRADE_TABNAME"].."→"..L["TRADECHARDATA_TABNAME"]
function BusinessInfo.StatsInfo_Fun()
	function BusinessInfo.IsBusinessOpen(gnfun,lyfui)
		if gnfun then
			if BusinessInfo.StatsUI:IsShown() then
				BusinessInfo.StatsUI:Hide()
			else
				BusinessInfo.StatsUI:Show()
				gnfun(lyfui)
			end
		else
			PIGErrorMsg(BusinessInfo.OpenTisp)
		end
	end
	StatsInfo_TradeClassLV()
	BusinessInfo.StatsInfo_ADDUI()
	
	local tispData={}
	local greenTexture = "interface/common/indicator-green.blp"
	local CreateIcons = "Interface/Glues/CharacterCreate/CharacterCreateIcons"
	local Texwidth,Texheight = 500,500
	local morenitem={"BAG","BANK","MAIL","GUILD"}
	local morenitemCN={BAGSLOT,BANK,MINIMAP_TRACKING_MAILBOX,GUILD}
	function BusinessInfo.SetTooltipQita_Num(tooltip,itemlink)
		if InCombatLockdown() then return end
		if not PIGA["StatsInfo"]["Open"] or not PIGA["StatsInfo"]["Qita_Num"] then return end
		local itemID = PIGGetItemInfoInstant(itemlink)
		if not itemID then return end
		if itemID==6948 then return end
		wipe(tispData)
		local playerNum=0
		local itemjihe = PIGA["StatsInfo"]["Items"]
		for player,data in pairs(itemjihe) do
			local playerList={}
			for id=1,#morenitem do
				local leibienum=0
				for it=1,#data[morenitem[id]] do
					if itemID==data[morenitem[id]][it][3] then
						leibienum=leibienum+data[morenitem[id]][it][2]
					end
				end
				if leibienum>0 then
					playerNum=playerNum+leibienum
					table.insert(playerList,{morenitemCN[id],leibienum})
				end
			end
			if #playerList>0 then
				local pxinxiinfo = PIGA["StatsInfo"]["Players"][player]
				local _, classFile = PIGGetClassInfo(pxinxiinfo[4])
				local color = PIG_CLASS_COLORS[classFile];
				local ttgghh = "|c"..color.colorStr..player.."|r"
				local Texinfo = C_Texture.GetAtlasInfo(pxinxiinfo[3])
				if Texinfo then
					ttgghh = "|T"..CreateIcons..":14:14:0:0:"..Texwidth..":"..Texheight..":"..(Texinfo.leftTexCoord*Texwidth+0.308)..":"..(Texinfo.rightTexCoord*Texwidth+0.5)..
					":"..(Texinfo.topTexCoord*Texheight+0.2)..":"..(Texinfo.bottomTexCoord*Texheight+0.1).."|t "..ttgghh
				else
					ttgghh = "|T134400:0|t "..ttgghh
				end
				if player==PlayerInfo.AllName then
					ttgghh=ttgghh.."|T"..greenTexture..":14:14:0:0:16:16:0:14:0:14|t"
					table.insert(tispData,1,{ttgghh,playerList,playerNum})
				else
					table.insert(tispData,{ttgghh,playerList,playerNum})
				end
			end
		end
		return tispData,playerNum
	end
	
	local BAGhejiElvUINDui = CreateFrame("Frame")
	BAGhejiElvUINDui:RegisterEvent("PLAYER_ENTERING_WORLD");
	BAGhejiElvUINDui:HookScript("OnEvent", function(self,event,arg1,arg2)
		if event=="PLAYER_ENTERING_WORLD" then
			if arg1 or arg2 then
				ADD_OffBut()
			end
		end
	end)

	hooksecurefunc("TradeFrame_OnShow", function(self)
		if PIGA["StatsInfo"]["TradeBagOpen"] then
			if (UnitExists("NPC")) then OpenAllBags() end
		end
	end);
	Create.PIGaddQuickBut(9,{
		Open=function()
			return PIGA["QuickBut"]["Open"] and PIGA["StatsInfo"]["Open"] and PIGA["StatsInfo"]["AddBut"]
		end,
		Icon=GnIcon,
		ShowGnUI=GnUI,
		FrameLevel=FrameLevel,
		Tooltip=KEY_BUTTON1.."-|cff00FFFF"..GnName.."|r\n"..KEY_BUTTON2.."-|cff00FFFF"..SETTINGS.."|r",
		fun=function(QkBut)
			QkBut:HookScript("OnClick", function(self,button)
				if button=="RightButton" then
					PD.UpdateOptionsUI()
					Create.Show_TabBut(BusinessInfo.fuFrame,BusinessInfo.fuFrameBut)
					Create.Show_TabBut_R(BusinessInfo.RTabFrame,BusinessInfo.Tab2_F,BusinessInfo.Tab2_But)
				end
			end);
		end,
	})
end
function BusinessInfo.StatsInfoOptions()
	local Tab2_F,Tab2_But =PIGOptionsList_R(BusinessInfo.RTabFrame,GnName,90)
	BusinessInfo.Tab2_F,BusinessInfo.Tab2_But=Tab2_F,Tab2_But
	Tab2_F.StatsInfo = PIGModCheckbutton(Tab2_F,{GnName,L["TRADECHARDATA_TABNAMETISP"]},{"TOPLEFT",Tab2_F,"TOPLEFT",20,-20})
	Tab2_F.StatsInfo:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["Open"]=true;
			BusinessInfo.StatsInfo_ADDUI()
			ADD_OffBut()
		else
			PIGA["StatsInfo"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		Fun.QuickBut_Update()
		Tab2_F.SetF:CheckbutShow()
	end);
	Tab2_F.StatsInfo.QKBut:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["AddBut"]=true
		else
			PIGA["StatsInfo"]["AddBut"]=false
		end
		Fun.QuickBut_Update()
	end);
	Tab2_F.StatsInfo:SetChecked(PIGA["StatsInfo"]["Open"])
	---
	Tab2_F.SetF = PIGFrame(Tab2_F,{"TOPLEFT", Tab2_F, "TOPLEFT", 0, -50})
	Tab2_F.SetF:SetPoint("BOTTOMRIGHT", Tab2_F, "BOTTOMRIGHT", 0, 0);
	Tab2_F.SetF:PIGSetBackdrop(0)
	---
	Tab2_F.SetF.CZ = PIGButton(Tab2_F.SetF,{"BOTTOMRIGHT",Tab2_F.SetF,"TOPRIGHT",-20,10},{60,22},RESET);  
	PIGEnter(Tab2_F.SetF.CZ,string.format(L["RELOADUI2"],GnName))
	Tab2_F.SetF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("PIG_STATSINFO_CZQIANGKONGINFO");
	end);
	PIGEnter(Tab2_F.SetF.CZ,string.format(L["RELOADUI2"],GnName))
	StaticPopupDialogs["PIG_STATSINFO_CZQIANGKONGINFO"] = {
		text = string.format(L["RELOADUI2"],GnName),
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["StatsInfo"]=CopyTable(PD.Default["StatsInfo"])
			PIGA["StatsInfo"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	--鼠标提示其他角色数量
	Tab2_F.SetF.Qita_Num = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF,"TOPLEFT",20,-20},{L["TRADECHARDATA_MOUSEDATA"],L["TRADECHARDATA_MOUSEDATATISP"]})
	Tab2_F.SetF.Qita_Num:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["Qita_Num"]=true;
		else
			PIGA["StatsInfo"]["Qita_Num"]=false;
		end
	end);
	Tab2_F.SetF.lixianBank = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.Qita_Num,"BOTTOMLEFT",0,-20},{L["TRADECHARDATA_OFFLINEBANK"],L["TRADECHARDATA_OFFLINEBANKTISP"]})
	Tab2_F.SetF.lixianBank:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["lixianBank"]=true;
			ADD_OffBut()
		else
			PIGA["StatsInfo"]["lixianBank"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
	end);
	---交易
	Tab2_F.SetF.TradeBagOpen = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.lixianBank,"BOTTOMLEFT",0,-20},{L["TRADECHARDATA_TRADEOPENBAG"]})
	Tab2_F.SetF.TradeBagOpen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeBagOpen"]=true
		else
			PIGA["StatsInfo"]["TradeBagOpen"]=false
		end
	end);
	---
	Tab2_F.SetF.TradeClassLV = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.TradeBagOpen,"BOTTOMLEFT",0,-20},{L["TRADECHARDATA_TRADECLASSLV"],L["TRADECHARDATA_TRADECLASSLVTISP"]})
	Tab2_F.SetF.TradeClassLV:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeClassLV"]=true
			StatsInfo_TradeClassLV()
		else
			PIGA["StatsInfo"]["TradeClassLV"]=false
			PIG_OptionsUI.RLUI:Show();
		end
	end);
	----
	Tab2_F.SetF.TradeTongGao = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.TradeClassLV,"BOTTOMLEFT",0,-20},{L["TRADECHARDATA_TRADENOTICE"]})
	Tab2_F.SetF.TradeTongGao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeTongGao"]=true;
		else
			PIGA["StatsInfo"]["TradeTongGao"]=false;
		end
		Tab2_F.SetF:CheckbutShow()
	end);
	local pindaoName = {
		["WHISPER"]="|cffFF80FF"..WHISPER.."|r",
		["PARTY_RAID_INSTANCE_CHAT"]="|cffAAAAFF"..PARTY.."|r/|cffFF7F00"..RAID.."|r/|cffFF7F00"..INSTANCE_CHAT.."|r"};
	local pindaoID = {"WHISPER","PARTY_RAID_INSTANCE_CHAT"};
	Tab2_F.SetF.TradeTongGao.guangbo_dow=PIGDownMenu(Tab2_F.SetF.TradeTongGao,{"LEFT",Tab2_F.SetF.TradeTongGao.Text,"RIGHT", 2,-1},{140})
	function Tab2_F.SetF.TradeTongGao.guangbo_dow:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#pindaoID,1 do
			info.notCheckable=true
		    info.text, info.arg1, info.arg2 = pindaoName[pindaoID[i]], pindaoID[i], pindaoID[i]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function Tab2_F.SetF.TradeTongGao.guangbo_dow:PIGDownMenu_SetValue(value,arg1,arg2)
		self:PIGDownMenu_SetText(value)
		PIGA["StatsInfo"]["TradeTongGaoChannel"]=arg1
		PIGCloseDropDownMenus()
	end

	Tab2_F.SetF.TradeIsFriend = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.TradeTongGao,"BOTTOMLEFT",20,-10},{L["TRADECHARDATA_TRADENOTICE1"]})
	Tab2_F.SetF.TradeIsFriend:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeIsFriend"]=true;
		else
			PIGA["StatsInfo"]["TradeIsFriend"]=false;
		end
	end);
	Tab2_F.SetF.TradeIsError = PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.TradeIsFriend,"BOTTOMLEFT",0,-10},{L["TRADECHARDATA_TRADENOTICE2"]})
	Tab2_F.SetF.TradeIsError:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["StatsInfo"]["TradeIsError"]=true;
		else
			PIGA["StatsInfo"]["TradeIsError"]=false;
		end
	end);
	-- ------
	function Tab2_F.SetF:CheckbutShow()
		Tab2_F.StatsInfo.QKBut:SetEnabled(PIGA["StatsInfo"]["Open"])
		Tab2_F.StatsInfo.QKBut:SetChecked(PIGA["StatsInfo"]["AddBut"])
		self:SetShown(PIGA["StatsInfo"]["Open"])
		self.Qita_Num:SetChecked(PIGA["StatsInfo"]["Qita_Num"])
		self.lixianBank:SetChecked(PIGA["StatsInfo"]["lixianBank"])
		self.TradeClassLV:SetChecked(PIGA["StatsInfo"]["TradeClassLV"])
		self.TradeBagOpen:SetChecked(PIGA["StatsInfo"]["TradeBagOpen"])
		self.TradeTongGao:SetChecked(PIGA["StatsInfo"]["TradeTongGao"])
		self.TradeTongGao.guangbo_dow:PIGDownMenu_SetText(pindaoName[PIGA["StatsInfo"]["TradeTongGaoChannel"]])
		self.TradeIsFriend:SetChecked(PIGA["StatsInfo"]["TradeIsFriend"])
		self.TradeIsError:SetChecked(PIGA["StatsInfo"]["TradeIsError"])
	end
	Tab2_F.SetF:CheckbutShow()
end