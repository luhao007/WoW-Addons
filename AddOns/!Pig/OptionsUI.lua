local addonName, addonTable = ...;
local L=addonTable.locale
-------
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGLine=Create.PIGLine
local PIGFontString=Create.PIGFontString
local PIGSetFont=Create.PIGSetFont
---
--系统插件菜单======================
local PIG_SetF = CreateFrame("Frame");
PIG_SetF:Hide()
PIG_SetF.Openshezhi = PIGButton(PIG_SetF,{"TOPLEFT",PIG_SetF,"TOPLEFT",20,-20},{80,24},L["OPTUI_SET"],nil,nil,nil,nil,0)
PIG_SetF.Openshezhi:SetScript("OnClick", function ()
	HideUIPanel(InterfaceOptionsFrame);
	HideUIPanel(SettingsPanel);
	HideUIPanel(GameMenuFrame);
	PIG_OptionsUI:Show();
end)
-- function PIG_SetF:OnRefresh()
-- 	--PIG_SetF.EditBoxUI:Show()
-- 	--PIG_SetF.EditBoxUI:SetText("-------------")
-- end
if Settings and Settings.RegisterCanvasLayoutCategory then
	local category, layout = Settings.RegisterCanvasLayoutCategory(PIG_SetF,addonName)
	Settings.RegisterAddOnCategory(category)
elseif InterfaceOptions_AddCategory then
	PIG_SetF.name = addonName
	InterfaceOptions_AddCategory(PIG_SetF);
	--子页
	-- PIG_SetF.childpanel = CreateFrame( "Frame", nil, PIG_SetF);
	-- PIG_SetF.childpanel.name = "About";
	-- PIG_SetF.childpanel.parent = PIG_SetF.name--指定归属父级
	-- InterfaceOptions_AddCategory(PIG_SetF.childpanel);
	-- PIG_AddOnPanel.okay = function (self) SC_ChaChingPanel_Close(); end;
	-- PIG_AddOnPanel.cancel = function (self) SC_ChaChingPanel_CancelOrLoad();  end;
end
---------------
local OptionsW,OptionsH,OptionsJG,BottomHHH = 800,600,14,40
local Pig_Options=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{OptionsW,OptionsH},"PIG_OptionsUI",true)
Pig_Options:PIGSetBackdrop()
Pig_Options:SetFrameStrata("HIGH")
--左侧内容
local OptionsLFW =160
Pig_Options.L = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.L:SetWidth(OptionsLFW);
Pig_Options.L:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", 0, 0)
Pig_Options.L:SetPoint("BOTTOMLEFT", Pig_Options, "BOTTOMLEFT", 0, 0)
Pig_Options.L.top = PIGFrame(Pig_Options.L)
Pig_Options.L.top:SetHeight(50)
Pig_Options.L.top:SetPoint("TOPLEFT", Pig_Options.L, "TOPLEFT", 2, -2)
Pig_Options.L.top:SetPoint("TOPRIGHT", Pig_Options.L, "TOPRIGHT", 0, 0)
Pig_Options.L.top:PIGSetMovableNoSave(Pig_Options)
Pig_Options.L.top.title = PIGFontString(Pig_Options.L.top,{"LEFT", Pig_Options.L.top, "LEFT", 13, 6},addonName,nil, 36)
Pig_Options.L.top.title:SetTextColor(1, 69/255, 0, 1)
Pig_Options.L.top.title1 =PIGFontString(Pig_Options.L.top,{"BOTTOMLEFT", Pig_Options.L.top.title, "BOTTOMRIGHT", 10, 0},L["ADDON_NAME"],nil, 16)
Pig_Options.L.top.title1:SetTextColor(0, 1, 1, 1)
--菜单
Pig_Options.L.F = PIGFrame(Pig_Options.L)
Pig_Options.L.F:PIGSetBackdrop()
Pig_Options.L.F:SetPoint("TOPLEFT", Pig_Options.L.top, "BOTTOMLEFT", 0, 0)
Pig_Options.L.F:SetPoint("BOTTOMRIGHT", Pig_Options.L, "BOTTOMRIGHT", 0, BottomHHH)
Pig_Options.L.F.ListTOP = CreateFrame("Frame", nil, Pig_Options.L.F)
Pig_Options.L.F.ListTOP:SetPoint("TOPLEFT", Pig_Options.L.F, "TOPLEFT", 0, 0)
Pig_Options.L.F.ListTOP:SetPoint("BOTTOMRIGHT", Pig_Options.L.F, "BOTTOMRIGHT", 0, 120)
Pig_Options.L.F.ListEXT = CreateFrame("Frame", nil, Pig_Options.L.F)
Pig_Options.L.F.ListEXT:SetPoint("TOPLEFT", Pig_Options.L.F.ListTOP, "BOTTOMLEFT", 0, 0)
Pig_Options.L.F.ListEXT:SetPoint("BOTTOMRIGHT", Pig_Options.L.F, "BOTTOMRIGHT", 0, 0)
PIGLine(Pig_Options.L.F.ListEXT,"TOP",0,2.1,{1,-1},{1, 0.65, 0, 0.8})
Pig_Options.L.F.ListBOT = CreateFrame("Frame", nil, Pig_Options.L.F)
Pig_Options.L.F.ListBOT:SetPoint("TOPLEFT", Pig_Options.L.F, "BOTTOMLEFT", 0, 0)
Pig_Options.L.F.ListBOT:SetPoint("BOTTOMRIGHT", Pig_Options.L, "BOTTOMRIGHT", 0, 0)
--右侧
Pig_Options.R = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.R:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", OptionsLFW+OptionsJG, 0)
Pig_Options.R:SetPoint("BOTTOMRIGHT", Pig_Options, "BOTTOMRIGHT", 0, BottomHHH)
--右侧顶部
Pig_Options.R.top = PIGFrame(Pig_Options.R)
Pig_Options.R.top:SetHeight(24)
Pig_Options.R.top:SetPoint("TOPLEFT", Pig_Options.R, "TOPLEFT", 0, -2)
Pig_Options.R.top:SetPoint("TOPRIGHT", Pig_Options.R, "TOPRIGHT", -2, 0)
Pig_Options.R.top:PIGSetBackdrop()
Pig_Options.R.top:PIGSetMovableNoSave(Pig_Options)
Pig_Options.R.top:PIGClose(25,25,Pig_Options)
Pig_Options.R.top.Ver = CreateFrame("Frame", nil, Pig_Options.R.top)
Pig_Options.R.top.Ver:SetPoint("TOPLEFT", Pig_Options.R.top, "TOPLEFT", 0, 0)
Pig_Options.R.top.Ver:SetPoint("BOTTOMRIGHT", Pig_Options.R.top, "BOTTOMRIGHT", -30, 0)
Pig_Options.VersionID=0
function Pig_Options:GetVer_NUM(EXTaddname,ly)
	if ly=="audio" then
		return Pig_Options.R.top.audioVer and Pig_Options.R.top.audioVer[EXTaddname].VersionID or 0
	else
		return Pig_Options.R.top.Ver and Pig_Options.R.top.Ver[EXTaddname].VersionID or 0
	end
end
function Pig_Options:GetVer_TXT(EXTaddname,ly)
	if ly=="audio" then
		return Pig_Options.R.top.audioVer and Pig_Options.R.top.audioVer[EXTaddname].VersionTXT or 0
	else
		return Pig_Options.R.top.Ver and Pig_Options.R.top.Ver[EXTaddname].VersionTXT or 0
	end
end
function Pig_Options:SetVer_EXT(EXTaddname,ly)
	local VersionTXT=PIGGetAddOnMetadata(EXTaddname, "Version")
	local VersionID=tonumber(VersionTXT)
	if ly=="audio" then
		Pig_Options.R.top.audioVer=Pig_Options.R.top.audioVer or{}
		Pig_Options.R.top.audioVer[EXTaddname]=Pig_Options.R.top.audioVer[EXTaddname] or {}
		Pig_Options.R.top.audioVer[EXTaddname].VersionID=VersionID
		Pig_Options.R.top.audioVer[EXTaddname].VersionTXT=VersionTXT
	else
		local name, title, notes, loadable = PIGGetAddOnInfo(EXTaddname)
		local ziframe = {Pig_Options.R.top.Ver:GetChildren()}
		local verF = PIGFrame(Pig_Options.R.top.Ver,nil,{0.0001,20})
		Pig_Options.R.top.Ver[EXTaddname]=verF
		if #ziframe==0 then
			verF:SetPoint("LEFT", Pig_Options.R.top.Ver, "LEFT", 4, -2)
		else
			verF:SetPoint("LEFT", ziframe[#ziframe].txt, "RIGHT", 0, 0)
		end
		verF.txt = PIGFontString(verF,{"LEFT", verF, "LEFT", 0, 0})
		verF.New = verF:CreateTexture();
		verF.New:SetAtlas("loottoast-arrow-purple");
		verF.New:SetSize(14,15);
		verF.New:SetPoint("BOTTOMLEFT", verF.txt, "TOPRIGHT", -6, -11);
		verF.New:Hide()
		verF.VersionTXT=VersionTXT
		verF.VersionID=VersionID
	end
end
Pig_Options:HookScript("OnShow", function (self)
	for EXTaddname,v in pairs(L["PIGaddonList"]) do
		if self.R.top.Ver[EXTaddname] then
			local verF = Pig_Options.R.top.Ver[EXTaddname]
			local VerTXT = "|cffFFD700%s:|r|cff00FF00%s|r"
			if EXTaddname==addonName then
				verF.txt:SetText(string.format(VerTXT,GAME_VERSION_LABEL,verF.VersionTXT))
			else
				verF.txt:SetText("|cff00FFFF + |r"..string.format(VerTXT,L["PIGaddonList"][EXTaddname],verF.VersionTXT))
			end
			if PIGA["Ver"][EXTaddname] and verF.VersionID<PIGA["Ver"][EXTaddname] then
				verF.New:Show()
				if EXTaddname==addonName then
					self.UpdateVer:Show()
				end
			end
		end
	end
end);
--右侧内容
Pig_Options.R.F = PIGFrame(Pig_Options.R)
Pig_Options.R.F:PIGSetBackdrop()
Pig_Options.R.F:SetPoint("TOPLEFT", Pig_Options.R, "TOPLEFT", 0, -34)
Pig_Options.R.F:SetPoint("BOTTOMRIGHT", Pig_Options.R, "BOTTOMRIGHT", -2, 0)
Pig_Options.R.F.NR = CreateFrame("Frame", nil, Pig_Options.R.F)
Pig_Options.R.F.NR:SetAllPoints(Pig_Options.R.F)
--侧面功能按钮区域
Pig_Options.ListFun = PIGFrame(Pig_Options)
Pig_Options.ListFun:PIGSetBackdrop()
Pig_Options.ListFun:SetPoint("TOPLEFT", Pig_Options.R.F, "TOPRIGHT", 4, 0)
Pig_Options.ListFun:SetPoint("BOTTOMRIGHT", Pig_Options, "BOTTOMRIGHT", 40, 0)

--RLUI
Pig_Options.RLUI = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.RLUI:SetSize(520, 28)
Pig_Options.RLUI:SetPoint("BOTTOM", Pig_Options, "BOTTOM", 80, 8)
Pig_Options.RLUI:Hide()
Pig_Options.RLUI.txt = PIGFontString(Pig_Options.RLUI,{"CENTER", Pig_Options.RLUI, "CENTER", -20, -2},L["OPTUI_RLUITIPS"],"OUTLINE")
Pig_Options.RLUI.txt:SetTextColor(1, 0, 0, 1);
Pig_Options.RLUI.Tex = Pig_Options.RLUI:CreateTexture(nil, "BORDER");
Pig_Options.RLUI.Tex:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
Pig_Options.RLUI.Tex:SetSize(32,32);
Pig_Options.RLUI.Tex:SetPoint("RIGHT",Pig_Options.RLUI.txt,"LEFT", 0, 0);
Pig_Options.RLUI.Button = PIGButton(Pig_Options.RLUI,{"LEFT",Pig_Options.RLUI.txt,"RIGHT",4,0},{76,25},L["OPTUI_RLUI"])
Pig_Options.RLUI.Button:SetScript("OnClick", function ()
	ReloadUI();
end);
Pig_Options.UpdateTXT=ADDONS..LFG_LIST_APP_TIMED_OUT..", "..string.format(LOCKED_WITH_ITEM,UPDATE).."!!!"
Pig_Options.UpdateVer=Create.PIGFontString(Pig_Options,{"BOTTOM", Pig_Options, "BOTTOM", 80, 12},addonName..Pig_Options.UpdateTXT,"OUTLINE",16);
Pig_Options.UpdateVer:SetTextColor(1, 0, 0, 1);
Pig_Options.UpdateVer:Hide()
Pig_Options.RLUI:HookScript("OnShow", function ()
	Pig_Options.UpdateVer:Hide()
end);
--PIG_OptionsUI.RLUI:Show()
--作者
Pig_Options.lianxizuozhe=PIGFrame(Pig_Options,{"CENTER",Pig_Options,"CENTER",80,20},{320,320})
Pig_Options.lianxizuozhe:PIGSetBackdrop(1)
Pig_Options.lianxizuozhe:PIGClose()
Pig_Options.lianxizuozhe:Hide()
Pig_Options.lianxizuozhe:SetFrameLevel(20)
PIGFontString(Pig_Options.lianxizuozhe,{"TOP", Pig_Options.lianxizuozhe, "TOP", 0, -10},L["ADDON_AUTHOR"])
Pig_Options.lianxizuozhe.wx = Pig_Options.lianxizuozhe:CreateTexture()
Pig_Options.lianxizuozhe.wx:SetTexture("Interface\\AddOns\\"..addonName.."\\Libs\\wx.blp");
Pig_Options.lianxizuozhe.wx:SetSize(240,240);
Pig_Options.lianxizuozhe.wx:SetPoint("CENTER",Pig_Options.lianxizuozhe,"CENTER", 0, 0);
Pig_Options:HookScript("OnHide", function (self)
	self.lianxizuozhe:Hide()
end)
function Pig_Options:ShowAuthor()
	local zuozheF = self.lianxizuozhe
	if zuozheF:IsShown() then
		zuozheF:Hide()
	else
		zuozheF:Show()
	end
end
--PIG屏幕提示信息栏
local infotip = CreateFrame("MessageFrame", nil, UIParent);
infotip:SetSize(512,60);
infotip:SetPoint("TOP",UIParent,"TOP",0,-182);
infotip:SetFrameStrata("DIALOG")
infotip:SetTimeVisible(2)
infotip:SetFadeDuration(0.5)
PIGSetFont(infotip,16,"OUTLINE")
function Pig_Options:ErrorMsg(message, Color)
	local r, g, b
	if Color=="G" then
		r, g, b = 0, 1, 0
	elseif Color=="W" then
		r, g, b=nil,nil,nil
	elseif Color=="R" then
		r, g, b = 1, 0, 0
	else
		r, g, b = 1, 1, 0
	end	
	infotip:AddMessage(message, r, g, b, 1);
	PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
end
--正式服系统地图部分插件下拉列表
function PIGCompartmentClick(addonName, buttonName, menuButtonFrame)
    MiniMapBut.minimapButClickFun(buttonName)
end
function PIGCompartmentEnter(addonName, menuButtonFrame)
	MiniMapBut.Showaddonstishi(menuButtonFrame,true)	
end
function PIGCompartmentLeave(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end
--
if PIG_MaxTocversion(40000) and PIG_MaxTocversion(20000,true) then
	SpellBookFrame.SpellRepair =Create.PIGCheckbutton(SpellBookFrame,{"BOTTOMLEFT",SpellBookFrame,"TOPLEFT",70,-12},{"临时修复技能书插入宏问题"})
	SpellBookFrame.SpellRepair:SetChecked(false)
	local ziframe = {SpellBookSpellIconsFrame:GetChildren()}
	SpellBookFrame.SpellRepair:SetScript("OnClick", function (self)
		for i=1,#ziframe do
			ziframe[i]:UpdateButton()
		end
	end);
	for i=1,#ziframe do
		local butx=ziframe[i]
		local namet=_G[butx:GetName().."SpellName"]
		namet:SetPoint("LEFT",butx,"LEFT",5,6);
		butx.cp = CreateFrame("Button",nil,butx, "UIPanelButtonTemplate");
		butx.cp:SetSize(60,20);
		butx.cp:SetPoint("BOTTOMLEFT",butx,"BOTTOMLEFT",50,-2);
		butx.cp:SetText("插入宏");
		butx.cp:SetScale(0.8);
		butx.cp:SetScript("OnClick", function(self, button)
			local slot, slotType = SpellBook_GetSpellBookSlot(self:GetParent());
			local spellName, _, spellID = GetSpellBookItemName(slot, SpellBookFrame.bookType);
			if ( MacroFrameText and MacroFrameText:HasFocus() ) then
				local spellName, subSpellName = GetSpellBookItemName(slot, SpellBookFrame.bookType);
				if ( spellName and not IsPassiveSpell(slot, SpellBookFrame.bookType) ) then
					if ( subSpellName and (strlen(subSpellName) > 0) ) then
						ChatEdit_InsertLink(spellName.."("..subSpellName..")");
					else
						ChatEdit_InsertLink(spellName);
					end
				end
				return;
			else
				local tradeSkillLink, tradeSkillSpellID = GetSpellTradeSkillLink(slot, SpellBookFrame.bookType);
				if ( tradeSkillSpellID ) then
					ChatEdit_InsertLink(tradeSkillLink);
				else
					ChatEdit_InsertLink(GetSpellLink(slot, SpellBookFrame.bookType));
				end
				return;
			end
		end)
		hooksecurefunc(butx, "UpdateButton", function(self)	
			if SpellBookFrame.SpellRepair:GetChecked() then
				if self:IsEnabled() then
					self.cp:Show()
					local namet=_G[butx:GetName().."SpellName"]
					local point, parent, relativePoint, xOffset, yOffset = namet:GetPoint(1);
					namet:SetPoint(point, parent, relativePoint, xOffset, yOffset + 10);
				else
					self.cp:Hide()
				end
			else
				self.cp:Hide()
			end
			
		end)
	end
end
