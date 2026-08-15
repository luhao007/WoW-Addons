local addonName, PD = ...;
local L=PD.locale
local Fun = PD.Fun
-------
local Create = PD.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGLine=Create.PIGLine
local PIGFontString=Create.PIGFontString
local PIGSetFont=Create.PIGSetFont

--正式服系统地图部分插件下拉列表
function PIGCompartmentClick(addonName, buttonName, menuButtonFrame)
    PD.Mapfun.MiniMapBut.Update_Click(buttonName)
end
function PIGCompartmentEnter(addonName, menuButtonFrame)
	PD.Mapfun.MiniMapBut.Update_Enter(menuButtonFrame,true)	
end
function PIGCompartmentLeave(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end

--系统插件菜单
local PIG_SetF = CreateFrame("Frame");
PIG_SetF:Hide()
PIG_SetF.Openshezhi = PIGButton(PIG_SetF,{"TOPLEFT",PIG_SetF,"TOPLEFT",20,-20},{80,24},SETTINGS,nil,nil,nil,nil,0)
PIG_SetF.Openshezhi:SetScript("OnClick", function ()
	HideUIPanel(InterfaceOptionsFrame);
	HideUIPanel(SettingsPanel);
	HideUIPanel(GameMenuFrame);
	PD.UpdateOptionsUI()
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
SLASH_RELOAD1 = '/rl'
SlashCmdList["RELOAD"] = ReloadUI
SLASH_PIG1 = "/pig"
SLASH_PIG2 = "/pig"
SLASH_PIG3 = "/PIG"
SlashCmdList["PIG"] = function()
	PD.UpdateOptionsUI()
end
local function add_Options()
	if PD.OptionsUI then
		return PD.OptionsUI
	end
	local OptionsW,OptionsH,OptionsJG,BottomHHH = 800,600,14,40
	OptionsUI=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{OptionsW,OptionsH},"PIG_OptionsUI",true)
	PD.OptionsUI=OptionsUI
	OptionsUI:PIGSetBackdrop()
	OptionsUI:SetFrameStrata("HIGH")
	--左侧内容
	local OptionsLFW =160
	OptionsUI.L = CreateFrame("Frame", nil, OptionsUI)
	OptionsUI.L:SetWidth(OptionsLFW);
	OptionsUI.L:SetPoint("TOPLEFT", OptionsUI, "TOPLEFT", 0, 0)
	OptionsUI.L:SetPoint("BOTTOMLEFT", OptionsUI, "BOTTOMLEFT", 0, 0)
	OptionsUI.L.top = PIGFrame(OptionsUI.L)
	OptionsUI.L.top:SetHeight(50)
	OptionsUI.L.top:SetPoint("TOPLEFT", OptionsUI.L, "TOPLEFT", 2, -2)
	OptionsUI.L.top:SetPoint("TOPRIGHT", OptionsUI.L, "TOPRIGHT", 0, 0)
	OptionsUI.L.top:PIGSetMovableNoSave(OptionsUI)
	OptionsUI.L.top.title = PIGFontString(OptionsUI.L.top,{"LEFT", OptionsUI.L.top, "LEFT", 13, 6},addonName,nil, 36)
	OptionsUI.L.top.title:SetTextColor(1, 69/255, 0, 1)
	OptionsUI.L.top.title1 =PIGFontString(OptionsUI.L.top,{"BOTTOMLEFT", OptionsUI.L.top.title, "BOTTOMRIGHT", 10, 0},L["ADDON_NAME"],nil, 16)
	OptionsUI.L.top.title1:SetTextColor(0, 1, 1, 1)
	local _, _, _, tocversion = GetBuildInfo()
	OptionsUI.L.top.title2 =PIGFontString(OptionsUI.L.top,{"TOPRIGHT", OptionsUI.L.top, "TOPRIGHT", -4, -2},tocversion,nil, 11)
	OptionsUI.L.top.title2:SetTextColor(0.5, 0.5, 0.5, 1)
	--菜单
	OptionsUI.L.F = PIGFrame(OptionsUI.L)
	OptionsUI.L.F:PIGSetBackdrop()
	OptionsUI.L.F:SetPoint("TOPLEFT", OptionsUI.L.top, "BOTTOMLEFT", 0, 0)
	OptionsUI.L.F:SetPoint("BOTTOMRIGHT", OptionsUI.L, "BOTTOMRIGHT", 0, BottomHHH)
	OptionsUI.L.F.ListTOP = CreateFrame("Frame", nil, OptionsUI.L.F)
	OptionsUI.L.F.ListTOP:SetPoint("TOPLEFT", OptionsUI.L.F, "TOPLEFT", 0, 0)
	OptionsUI.L.F.ListTOP:SetPoint("BOTTOMRIGHT", OptionsUI.L.F, "BOTTOMRIGHT", 0, 140)
	OptionsUI.L.F.ListEXT = CreateFrame("Frame", nil, OptionsUI.L.F)
	OptionsUI.L.F.ListEXT:SetPoint("TOPLEFT", OptionsUI.L.F.ListTOP, "BOTTOMLEFT", 0, 0)
	OptionsUI.L.F.ListEXT:SetPoint("BOTTOMRIGHT", OptionsUI.L.F, "BOTTOMRIGHT", 0, 0)
	PIGLine(OptionsUI.L.F.ListEXT,"TOP",0,2.1,{1,-1},{1, 0.65, 0, 0.8})
	OptionsUI.L.F.ListBOT = CreateFrame("Frame", nil, OptionsUI.L.F)
	OptionsUI.L.F.ListBOT:SetPoint("TOPLEFT", OptionsUI.L.F, "BOTTOMLEFT", 0, 0)
	OptionsUI.L.F.ListBOT:SetPoint("BOTTOMRIGHT", OptionsUI.L, "BOTTOMRIGHT", 0, 0)
	--右侧
	OptionsUI.R = CreateFrame("Frame", nil, OptionsUI)
	OptionsUI.R:SetPoint("TOPLEFT", OptionsUI, "TOPLEFT", OptionsLFW+OptionsJG, 0)
	OptionsUI.R:SetPoint("BOTTOMRIGHT", OptionsUI, "BOTTOMRIGHT", 0, BottomHHH)
	--右侧内容
	OptionsUI.R.F = PIGFrame(OptionsUI.R)
	OptionsUI.R.F:PIGSetBackdrop()
	OptionsUI.R.F:SetPoint("TOPLEFT", OptionsUI.R, "TOPLEFT", 0, -34)
	OptionsUI.R.F:SetPoint("BOTTOMRIGHT", OptionsUI.R, "BOTTOMRIGHT", -2, 0)
	OptionsUI.R.F.NR = CreateFrame("Frame", nil, OptionsUI.R.F)
	OptionsUI.R.F.NR:SetAllPoints(OptionsUI.R.F)

	--RLUI
	OptionsUI.RLUI = CreateFrame("Frame", nil, OptionsUI)
	OptionsUI.RLUI:SetSize(520, 28)
	OptionsUI.RLUI:SetPoint("BOTTOM", OptionsUI, "BOTTOM", 80, 8)
	OptionsUI.RLUI:Hide()
	OptionsUI.RLUI.txt = PIGFontString(OptionsUI.RLUI,{"CENTER", OptionsUI.RLUI, "CENTER", -20, -2},L["OPTUI_RLUITIPS"],"OUTLINE")
	OptionsUI.RLUI.txt:SetTextColor(1, 0, 0, 1);
	OptionsUI.RLUI.Tex = OptionsUI.RLUI:CreateTexture(nil, "BORDER");
	OptionsUI.RLUI.Tex:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
	OptionsUI.RLUI.Tex:SetSize(32,32);
	OptionsUI.RLUI.Tex:SetPoint("RIGHT",OptionsUI.RLUI.txt,"LEFT", 0, 0);
	OptionsUI.RLUI.Button = PIGButton(OptionsUI.RLUI,{"LEFT",OptionsUI.RLUI.txt,"RIGHT",4,0},{80,25},RELOADUI)
	OptionsUI.RLUI.Button:SetScript("OnClick", function ()
		ReloadUI();
	end);
	OptionsUI.UpdateTXT=ADDONS..LFG_LIST_APP_TIMED_OUT..", "..string.format(LOCKED_WITH_ITEM,UPDATE).."!!!"
	OptionsUI.UpdateVer=PIGFontString(OptionsUI,{"BOTTOM", OptionsUI, "BOTTOM", 80, 12},addonName..OptionsUI.UpdateTXT,"OUTLINE",16);
	OptionsUI.UpdateVer:SetTextColor(1, 0, 0, 1);
	OptionsUI.UpdateVer:Hide()
	OptionsUI.RLUI:HookScript("OnShow", function ()
		OptionsUI.UpdateVer:Hide()
	end);
	--PIG_OptionsUI.RLUI:Show()
	--右侧顶部版本
	OptionsUI.R.top = PIGFrame(OptionsUI.R)
	OptionsUI.R.top:SetHeight(24)
	OptionsUI.R.top:SetPoint("TOPLEFT", OptionsUI.R, "TOPLEFT", 0, -2)
	OptionsUI.R.top:SetPoint("TOPRIGHT", OptionsUI.R, "TOPRIGHT", -2, 0)
	OptionsUI.R.top:PIGSetBackdrop()
	OptionsUI.R.top:PIGSetMovableNoSave(OptionsUI)
	OptionsUI.R.top:PIGClose(25,25,OptionsUI)
	OptionsUI.R.top.Ver = CreateFrame("Frame", nil, OptionsUI.R.top)
	OptionsUI.R.top.Ver:SetPoint("TOPLEFT", OptionsUI.R.top, "TOPLEFT", 0, 0)
	OptionsUI.R.top.Ver:SetPoint("BOTTOMRIGHT", OptionsUI.R.top, "BOTTOMRIGHT", -30, 0)
	OptionsUI.VersionID=0
	---
	local VerTXTformat = "|cffFFD700%s:|r|cff00FF00%s|r"
	local GetAddonsVerV=PD.VerData.GetAddonsVerV
	local IsUpdateOK=PD.VerData.IsUpdateOK
	OptionsUI:HookScript("OnShow", function (self)
		for i=1,#L.addnames do
			local EXTname=L.addnames[i]
			local EXTverV=GetAddonsVerV(EXTname)
			if tonumber(EXTverV)>0 then
				if not PD.VerData.TopVerF[EXTname] then
					local ziframe = {OptionsUI.R.top.Ver:GetChildren()}
					local extverF = PIGFrame(OptionsUI.R.top.Ver,nil,{0.0001,20})
					PD.VerData.TopVerF[EXTname]=extverF
					if #ziframe==0 then
						extverF:SetPoint("LEFT", OptionsUI.R.top.Ver, "LEFT", 4, -2)
					else
						extverF:SetPoint("LEFT", ziframe[#ziframe].txt, "RIGHT", 0, 0)
					end
					extverF.txt = PIGFontString(extverF,{"LEFT", extverF, "LEFT", 0, 0})
					extverF.New = extverF:CreateTexture();
					extverF.New:SetAtlas("loottoast-arrow-purple");
					extverF.New:SetSize(14,15);
					extverF.New:SetPoint("BOTTOMLEFT", extverF.txt, "TOPRIGHT", -6, -11);
					extverF.New:Hide()
				end
				local extverF = PD.VerData.TopVerF[EXTname]
				if i==1 then
					extverF.txt:SetText(string.format(VerTXTformat,GAME_VERSION_LABEL,EXTverV))
				else
					extverF.txt:SetText("|cff00FFFF + |r"..string.format(VerTXTformat,EXTname,EXTverV))
				end
				if PIGA["VerC"][EXTname] then
					if IsUpdateOK(EXTname,EXTverV) then
						extverF.New:Show()
						if i==1 then
							self.UpdateVer:Show()
						else
							local adddata=L.ExtList[EXTname]
							local fuFrame=unpack(adddata.SetUIData)
							if not fuFrame.UpdateVer then
								fuFrame.UpdateVer=PIGFontString(fuFrame,{"CENTER", fuFrame, "CENTER", 0, 0},EXTname..OptionsUI.UpdateTXT,"OUTLINE",16);
								fuFrame.UpdateVer:SetTextColor(1, 0, 0, 1);
							end
							fuFrame.UpdateVer:Show()
						end
					end
				end
			end
		end
	end);
	--右侧栏
	PD.addOptions_RightBar(OptionsUI)
	---子选项
	PD.addOptions_Ext()
	PD.addOptions_About()
	PD.addOptions_Debug()
	PD.addOptions_General()
	PD.addOptions_Business()
	PD.addOptions_Chat()
	PD.addOptions_ActionBar()
	PD.addOptions_CombatPlus()
	PD.addOptions_Tooltip()
	PD.addOptions_FramePlus()
	PD.addOptions_UnitFrame()
	PD.addOptions_BagBank()
	PD.addOptions_Map()
	PD.addOptions_CVars()
	PD.addOptions_PigLayout()
	PD.addOptions_Config()
	return OptionsUI
end
function PD.UpdateOptionsUI(showhide,funx)
	if showhide==false then
		if PD.OptionsUI then
			PD.OptionsUI:Hide()
		end
		return
	end
	local OptionsUI=add_Options()
	if showhide then
		OptionsUI:Show()
		return
	end
	if OptionsUI:IsShown() then
		OptionsUI:Hide()
	else
		OptionsUI:Show()
	end
	if funx then funx(OptionsUI) end
end
--PIG屏幕提示信息栏
local infotip = CreateFrame("MessageFrame", nil, UIParent);
infotip:SetSize(512,60);
infotip:SetPoint("TOP",UIParent,"TOP",0,-182);
infotip:SetFrameStrata("DIALOG")
infotip:SetTimeVisible(2)
infotip:SetFadeDuration(0.5)
PIGSetFont(infotip,16,"OUTLINE")
function PIGErrorMsg(message, Color)
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