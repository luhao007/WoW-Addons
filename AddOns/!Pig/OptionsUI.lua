local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
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
PIG_SetF.Openshezhi = PIGButton(PIG_SetF,{"TOPLEFT",PIG_SetF,"TOPLEFT",20,-20},{80,24},L["OPTUI_SET"],nil,nil,nil,nil,0)
PIG_SetF.Openshezhi:SetScript("OnClick", function ()
	HideUIPanel(InterfaceOptionsFrame);
	HideUIPanel(SettingsPanel);
	HideUIPanel(GameMenuFrame);
	Pig_OptionsUI:Show();
end)
if Settings and Settings.RegisterCanvasLayoutCategory then
	local category, layout = Settings.RegisterCanvasLayoutCategory(PIG_SetF,addonName)
	layout:AddAnchorPoint("TOPLEFT", 10, -10);
	layout:AddAnchorPoint("BOTTOMRIGHT", -10, 10);
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
local Pig_Options=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{OptionsW,OptionsH},"Pig_OptionsUI",true)
Pig_Options:PIGSetBackdrop()
Pig_Options:SetFrameStrata("HIGH")
--左侧内容
local OptionsLFW =160
Pig_Options.L = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.L:SetWidth(OptionsLFW);
Pig_Options.L:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", 0, 0)
Pig_Options.L:SetPoint("BOTTOMLEFT", Pig_Options, "BOTTOMLEFT", 0, 0)
Pig_Options.L.top = PIGFrame(Pig_Options.L)
--Pig_Options.L.top:PIGSetBackdrop()
Pig_Options.L.top:SetHeight(50)
Pig_Options.L.top:SetPoint("TOPLEFT", Pig_Options.L, "TOPLEFT", 2, -2)
Pig_Options.L.top:SetPoint("TOPRIGHT", Pig_Options.L, "TOPRIGHT", 0, 0)
Pig_Options.L.top:PIGSetMovable(Pig_Options)
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
Pig_Options.R.top:PIGSetMovable(Pig_Options)
Pig_Options.R.top:PIGClose(25,25,Pig_Options)
Pig_Options.R.top.Ver = CreateFrame("Frame", nil, Pig_Options.R.top)
Pig_Options.R.top.Ver:SetPoint("TOPLEFT", Pig_Options.R.top, "TOPLEFT", 0, 0)
Pig_Options.R.top.Ver:SetPoint("BOTTOMRIGHT", Pig_Options.R.top, "BOTTOMRIGHT", -30, 0)
Pig_Options.VersionID=0
function Pig_Options:SetVer()
	local VersionTXT=PIGGetAddOnMetadata(addonName, "Version")
	local VersionID=tonumber(VersionTXT)
	Pig_Options.VersionID=VersionID
	local benjibanbenhaoTXT="|cffFFD700"..GAME_VERSION_LABEL..":|r |cff00FF00"..VersionTXT.."|r"
	PIGFontString(Pig_OptionsUI.R.top.Ver,{"LEFT", Pig_OptionsUI.R.top.Ver, "LEFT", 6, 0},benjibanbenhaoTXT)
end
function Pig_Options:SetVer_EXT(EXTaddname,ext_UI)
	local VersionTXT=PIGGetAddOnMetadata(EXTaddname, "Version")
	local VersionID=tonumber(VersionTXT)
	ext_UI.VersionID=VersionID
	local name, title, notes, loadable = PIGGetAddOnInfo(EXTaddname)
	local ziframe = {Pig_OptionsUI.R.top.Ver:GetRegions()}
	local VerTXT = "|cff00FFFF + |r|cffFFD700"..L["PIGaddonList"][EXTaddname]..":|r |cff00FF00"..VersionTXT.."|r"
	Pig_OptionsUI.R.top.Ver.Vert = PIGFontString(Pig_OptionsUI.R.top.Ver,{"LEFT", ziframe[#ziframe], "RIGHT", 0, 0},VerTXT)
end
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
Pig_Options.tishi = CreateFrame("Frame", "Pig_Options_RLtishi_UI", Pig_Options)
Pig_Options.tishi:SetSize(520, 28)
Pig_Options.tishi:SetPoint("BOTTOM", Pig_Options, "BOTTOM", 80, 8)
Pig_Options.tishi:Hide()
Pig_Options.tishi.txt = PIGFontString(Pig_Options.tishi,{"CENTER", Pig_Options.tishi, "CENTER", -20, -2},L["OPTUI_RLUITIPS"],"OUTLINE")
Pig_Options.tishi.txt:SetTextColor(1, 0, 0, 1);
Pig_Options.tishi.Tex = Pig_Options.tishi:CreateTexture(nil, "BORDER");
Pig_Options.tishi.Tex:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
Pig_Options.tishi.Tex:SetSize(32,32);
Pig_Options.tishi.Tex:SetPoint("RIGHT",Pig_Options.tishi.txt,"LEFT", 0, 0);
Pig_Options.tishi.Button = PIGButton(Pig_Options.tishi,{"LEFT",Pig_Options.tishi.txt,"RIGHT",4,0},{76,25},L["OPTUI_RLUI"])
Pig_Options.tishi.Button:SetScript("OnClick", function ()
	ReloadUI();
end);
Pig_Options.UpdateTXT=ADDONS..LFG_LIST_APP_TIMED_OUT..", "..string.format(LOCKED_WITH_ITEM,UPDATE).."!!!"
Pig_Options.UpdateVer=Create.PIGFontString(Pig_Options,{"BOTTOM", Pig_Options, "BOTTOM", 80, 12},addonName..Pig_Options.UpdateTXT,"OUTLINE",16);
Pig_Options.UpdateVer:SetTextColor(1, 0, 0, 1);
Pig_Options.UpdateVer:Hide()
Pig_Options.tishi:HookScript("OnShow", function ()
	Pig_Options.UpdateVer:Hide()
end);
Pig_Options:HookScript("OnShow", function (self)
	if PIGA["Ver"][addonName]>self.VersionID then
		self.UpdateVer:Show()
	end
end);

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
---小地图按钮
local PigMinimapBut = CreateFrame("Button","PigMinimapBut_UI",UIParent);
PigMinimapBut:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0);
PigMinimapBut:SetMovable(true)
PigMinimapBut:EnableMouse(true)
PigMinimapBut:RegisterForClicks("LeftButtonUp","RightButtonUp")
PigMinimapBut:RegisterForDrag("LeftButton")
PigMinimapBut:SetFrameStrata("MEDIUM")
PigMinimapBut:SetFrameLevel(PigMinimapBut:GetFrameLevel()+1);
PigMinimapBut.Border = PigMinimapBut:CreateTexture(nil,"BORDER");
PigMinimapBut.icon = PigMinimapBut:CreateTexture(nil, "BACKGROUND");
PigMinimapBut.icon:SetTexture("interface/icons/ability_seal.blp");
PigMinimapBut.error = PigMinimapBut:CreateTexture(nil, "BORDER");
PigMinimapBut.error:SetTexture("interface/common/voicechat-muted.blp");
PigMinimapBut.error:SetSize(18,18);
PigMinimapBut.error:SetAlpha(0.7);
PigMinimapBut.error:SetPoint("CENTER", 0, 0);
PigMinimapBut.error:Hide();
local function Showaddonstishi(self,laiyuan)
	GameTooltip:ClearLines();
	if laiyuan then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT",-2,16);
	else
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT",-24,0);
	end
	GameTooltip:AddLine("|cffFF00FF"..addonName.."|r-"..PIGGetAddOnMetadata(addonName, "Version"))
	if Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") then
		GameTooltip:AddLine(L["MAP_NIMIBUT_TIPS2"])
	else
		GameTooltip:AddLine(L["MAP_NIMIBUT_TIPS1"])
	end
	GameTooltip:Show();
end	
PigMinimapBut:SetScript("OnEnter", function(self)
	Showaddonstishi(self)
end);
PigMinimapBut:SetScript("OnLeave", function()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
local function YDButtonP(xpos,ypos)
	local mode = PIGA["Map"]["MinimapPoint"]
	if mode==1 or mode==2 then
		PigMinimapBut:ClearAllPoints();
		if mode==1 then
			if Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") then
				local xpos=xpos or PIGA["Map"]["MinimapPoint_NDui"][1]
				local ypos=ypos or PIGA["Map"]["MinimapPoint_NDui"][2]
				PigMinimapBut:SetPoint("BOTTOMLEFT",Minimap,"BOTTOMLEFT",xpos,ypos)
				PIGA["Map"]["MinimapPoint_NDui"][1]=xpos
				PIGA["Map"]["MinimapPoint_NDui"][2]=ypos
			elseif Pig_OptionsUI.IsOpen_ElvUI() then
				local xpos=xpos or PIGA["Map"]["MinimapPoint_ElvUI"][1]
				local ypos=ypos or PIGA["Map"]["MinimapPoint_ElvUI"][2]
				PigMinimapBut:SetPoint("BOTTOMLEFT",Minimap,"BOTTOMLEFT",xpos,ypos)
				PIGA["Map"]["MinimapPoint_ElvUI"][1]=xpos
				PIGA["Map"]["MinimapPoint_ElvUI"][2]=ypos
			else
				local xpos=xpos or PIGA["Map"]["MinimapPos"]
				local banjing = Minimap:GetWidth()*0.5+8
				local pianyi =PigMinimapBut.pianyi
				PigMinimapBut:SetPoint("TOPLEFT",Minimap,"TOPLEFT",pianyi-2-(banjing*cos(xpos)),(banjing*sin(xpos))-pianyi)
				PIGA["Map"]["MinimapPos"]=xpos
			end
		elseif mode==2 then
			local xpos=xpos or PIGA["Map"]["MinimapPointXY"][1]
			local ypos=ypos or PIGA["Map"]["MinimapPointXY"][2]
			PigMinimapBut:SetPoint("CENTER",UIParent,"CENTER",xpos,ypos)
			PIGA["Map"]["MinimapPointXY"][1]=xpos
			PIGA["Map"]["MinimapPointXY"][2]=ypos
		end
	end
end
local function YDButtonP_OnUpdate()	
	local mode = PIGA["Map"]["MinimapPoint"]
	local UIScale = UIParent:GetEffectiveScale()
	local xpos,ypos = GetCursorPosition()
	local xpos = xpos/UIScale
	local ypos = ypos/UIScale
	local left, bottom, width, height = Minimap:GetScaledRect()
	local left = left/UIScale
    local bottom = bottom/UIScale
    local width = width/UIScale
    local height = height/UIScale
	local Pigleft, Pigbottom, Pigwidth, Pigheight  = PigMinimapBut:GetScaledRect()
	local Pigleft = Pigleft/UIScale
    local Pigbottom = Pigbottom/UIScale
    local Pigwidth = Pigwidth/UIScale
    local Pigheight = Pigheight/UIScale
	local Pigwidth2 = Pigwidth*0.5
	local Pigheight2 = Pigheight*0.5
	if mode==2 then
		local MinibutW3 = Pigwidth2-4
		local WowWidth2=GetScreenWidth()*0.5;
		local WowHeight2=GetScreenHeight()*0.5;
		local xpos = xpos-WowWidth2
		local ypos = ypos-WowHeight2
		if xpos>WowWidth2-MinibutW3 then xpos=WowWidth2-MinibutW3 end
		if xpos<-WowWidth2+MinibutW3 then xpos=-WowWidth2+MinibutW3 end
		if ypos>WowHeight2-MinibutW3 then ypos=WowHeight2-MinibutW3 end
		if ypos<-WowHeight2+MinibutW3 then ypos=-WowHeight2+MinibutW3 end
		YDButtonP(xpos,ypos)
		PigMinimapBut.Snf:ClearAllPoints();
		local Pointinfo = {"RIGHT", "LEFT", "TOP", "BOTTOM", -2, 25}
		if xpos<0 then
			Pointinfo[1]="LEFT"
			Pointinfo[2]="RIGHT"
		end
		if ypos<0 then
			Pointinfo[3]="BOTTOM"
			Pointinfo[4]="TOP"
			Pointinfo[6]=0
		end
		PigMinimapBut.Snf:SetPoint(Pointinfo[3]..Pointinfo[1], PigMinimapBut_UI, Pointinfo[4]..Pointinfo[2], Pointinfo[5], Pointinfo[6]);
	else
		if Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") or Pig_OptionsUI.IsOpen_ElvUI() then
			local xpos = xpos-left-Pigwidth2
			local ypos = ypos-bottom-Pigheight2
			if xpos<0 then xpos=0 end--X左边
			local rightbianp = width-Pigwidth
			if xpos>rightbianp then--X右边
				xpos=rightbianp
			end
			if ypos<0 then ypos=0 end--下
			local topbianp = height-Pigheight
			if ypos>topbianp then
				ypos=topbianp
			end
			YDButtonP(xpos,ypos)
		else
			local xpos = left-xpos+width*0.5
			local ypos = ypos-bottom-width*0.5
			YDButtonP(math.deg(math.atan2(ypos,xpos)))
		end
	end
end
local function addonsClick(button)
	GameTooltip:Hide()
	if button=="LeftButton" then
		if IsControlKeyDown() then
			Bugcollect_UI:Show()
			PigMinimapBut_UI.error:Hide();
		elseif IsShiftKeyDown() then
			ReloadUI()
		else
			if PIGA["Map"]["MiniButShouNa_YN"]==1 then
				if Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") and RecycleBinToggleButton then
					if Pig_OptionsUI:IsShown() then	
						Pig_OptionsUI:Hide();
					else
						PigMinimapBut.Snf:Hide();
						Pig_OptionsUI:Show();
					end
				else
					PigMinimapBut.Snf.tishi:Hide();
					if PigMinimapBut.Snf:IsShown() then	
						PigMinimapBut.Snf:Hide();
					else
						Pig_OptionsUI:Hide();
						PigMinimapBut.Snf:Show();
						PigMinimapBut.Snf.xiaoshidaojishi = 1.5;
						PigMinimapBut.Snf.zhengzaixianshi = true;
					end
				end
			else	
				PigMinimapBut.Snf.tishi:Show();
				if PigMinimapBut.Snf:IsShown() then
					PigMinimapBut.Snf:Hide();
				else
					PigMinimapBut.Snf:Show();
				end
			end
		end
	else
		if Pig_OptionsUI:IsShown() then	
			Pig_OptionsUI:Hide();
		else
			PigMinimapBut.Snf:Hide();
			Pig_OptionsUI:Show();
		end
	end
end
PigMinimapBut:SetScript("OnClick", function(event, button)
	PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
	addonsClick(button)
end)
local PigMinimapButYD = CreateFrame("Frame", nil);
PigMinimapButYD:Hide();
function PigMinimapBut.zhucetuodong(ONOFF)
	if ONOFF then
		PigMinimapButYD:SetScript("OnUpdate",YDButtonP_OnUpdate)
		PigMinimapBut:SetScript("OnDragStart", function(self)
			self:LockHighlight();PigMinimapButYD:Show();
		end)
		PigMinimapBut:SetScript("OnDragStop", function(self)
			self:UnlockHighlight();PigMinimapButYD:Hide();
		end)
	else
		PigMinimapButYD:SetScript("OnUpdate",nil)
		PigMinimapBut:SetScript("OnDragStart",nil)
		PigMinimapBut:SetScript("OnDragStop",nil)
	end
end
function PigMinimapBut:CZMinimapInfo()
	PIGA["Map"]["MinimapPos"]=addonTable.Default["Map"]["MinimapPos"]
	PIGA["Map"]["MinimapPointXY"]=addonTable.Default["Map"]["MinimapPointXY"]
	PIGA["Map"]["MinimapPoint_NDui"]=addonTable.Default["Map"]["MinimapPoint_NDui"]
	PIGA["Map"]["MinimapPoint_ElvUI"]=addonTable.Default["Map"]["MinimapPoint_ElvUI"]
	YDButtonP();
end
local www,hhh = 33,33
function PigMinimapBut:ButPoint()
	if not Pig_OptionsUI.IsOpen_ElvUI() and PIGA["Map"]["MinimapPoint"]==5 then PIGA["Map"]["MinimapPoint"]=1 end
	local mode = PIGA["Map"]["MinimapPoint"]
	local ButpingXY = {
		["W"]=www,["H"]=hhh,
		["iconW"]=www-10,["iconH"]=hhh-10,
		["iconX"]=0,["iconY"]=0,
	}
	PIGA["Map"]["MinimapPointXY"]=PIGA["Map"]["MinimapPointXY"] or addonTable.Default["Map"]["MinimapPointXY"]
	PIGA["Map"]["MinimapPoint_NDui"]=PIGA["Map"]["MinimapPoint_NDui"] or addonTable.Default["Map"]["MinimapPoint_NDui"]
	PIGA["Map"]["MinimapPoint_ElvUI"]=PIGA["Map"]["MinimapPoint_ElvUI"] or addonTable.Default["Map"]["MinimapPoint_ElvUI"]
	PigMinimapBut.Snf:ClearAllPoints();
	PigMinimapBut:ClearNormalTexture()
	PigMinimapBut:ClearPushedTexture()
	PigMinimapBut.zhucetuodong(false)
	local function Point_Minidown()
		PigMinimapBut.pianyi = 0
		PigMinimapBut.zhucetuodong(true)
		if mode == 1 then--小地图
			if Pig_OptionsUI.IsOpen_ElvUI() or Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") then
				if Pig_OptionsUI.IsOpen_ElvUI() then
					ButpingXY.W,ButpingXY.H=www-14,hhh-14
					ButpingXY.iconW,ButpingXY.iconH=www-14,hhh-14
				elseif Pig_OptionsUI.IsOpen_NDui() then
					ButpingXY.W,ButpingXY.H=www-12,hhh-12
					ButpingXY.iconW,ButpingXY.iconH=www-12,hhh-12
				end
				PigMinimapBut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
				PigMinimapBut.Border:Hide()
			else
				PigMinimapBut:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");
				PigMinimapBut.Border:SetDrawLayer("BORDER",1)
				PigMinimapBut.icon:SetDrawLayer("BACKGROUND",1)
				--PigMinimapBut.Border:SetAtlas("ui-lfg-roleicon-incentive")
				PigMinimapBut.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
				PigMinimapBut.Border:SetSize(56,56);
				PigMinimapBut.Border:ClearAllPoints();	
				PigMinimapBut.Border:SetPoint("TOPLEFT", -1, 0);
				PigMinimapBut.Border:Show()
				if tocversion<100000 then
					PigMinimapBut.pianyi = 56
				else
					PigMinimapBut.pianyi = 82
				end
			end
		elseif mode == 2 then--自由
			PigMinimapBut.Border:Hide()
			PigMinimapBut:SetHighlightAtlas("chatframe-button-highlight");
		end
		PigMinimapBut.Snf:SetPoint("TOPRIGHT", PigMinimapBut_UI, "BOTTOMLEFT", -2, 20);
		YDButtonP();
	end
	if mode == 1 or mode == 2 then
		Point_Minidown()
	elseif mode == 3 then--角色信息
		PigMinimapBut:ClearAllPoints();
		if Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") then
			ButpingXY.W,ButpingXY.H=21,21
			ButpingXY.iconW,ButpingXY.iconH=21,21
			PigMinimapBut:SetPoint("RIGHT",CharacterMicroButton,"LEFT",-2,0);
			PigMinimapBut.Snf:SetPoint("BOTTOMRIGHT", PigMinimapBut_UI, "TOPRIGHT", 0, 2);
		elseif Pig_OptionsUI.IsOpen_ElvUI() then
			ButpingXY.W,ButpingXY.H=18,25
			ButpingXY.iconW,ButpingXY.iconH=18,25
			PigMinimapBut:SetPoint("LEFT",StoreMicroButton,"RIGHT",2,0);
			PigMinimapBut.Snf:SetPoint("BOTTOMLEFT", PigMinimapBut_UI, "TOPRIGHT", 0, 2);
		else
			if tocversion<110000 then
				ButpingXY.W,ButpingXY.H=24,34
				ButpingXY.iconW,ButpingXY.iconH=18,18
				PigMinimapBut:SetPoint("BOTTOMRIGHT",CharacterMicroButton,"BOTTOMLEFT",1,1);
				PigMinimapBut.Snf:SetPoint("BOTTOMRIGHT", PigMinimapBut_UI, "TOPRIGHT", 0, 112);
				PigMinimapBut.Border:SetTexture(130818)
				PigMinimapBut.Border:SetSize(26,58);
				PigMinimapBut.Border:ClearAllPoints();
				PigMinimapBut.Border:SetPoint("TOP", 0, 23);
			else
				ButpingXY.W,ButpingXY.H=24,34
				ButpingXY.iconW,ButpingXY.iconH=21,21
				PigMinimapBut:SetPoint("RIGHT",CharacterMicroButton,"LEFT",0,-1);
				PigMinimapBut.Snf:SetPoint("BOTTOMRIGHT", PigMinimapBut_UI, "TOPRIGHT", 0, 2);
				PigMinimapBut.Border:SetAtlas("UI-HUD-MicroMenu-ButtonBG-Up")
				PigMinimapBut.Border:SetSize(32,42);
				PigMinimapBut.Border:ClearAllPoints();
				PigMinimapBut.Border:SetPoint("CENTER", 0, 1);
			end
			PigMinimapBut.icon:SetDrawLayer("ARTWORK",1)
			PigMinimapBut.Border:SetDrawLayer("BACKGROUND",1)
			PigMinimapBut.Border:Show()
		end
		PigMinimapBut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
	elseif mode == 4 then--聊天框
		PigMinimapBut.Border:Hide()
		PigMinimapBut:ClearAllPoints();	
		if Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") then
			ButpingXY.W,ButpingXY.H=21,21
			ButpingXY.iconW,ButpingXY.iconH=20,20
			PigMinimapBut:SetPoint("TOP",ChatFrameChannelButton,"BOTTOM",0,-1);
			PigMinimapBut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
		elseif Pig_OptionsUI.IsOpen_ElvUI() then
			ButpingXY.W,ButpingXY.H=21,21
			ButpingXY.iconW,ButpingXY.iconH=20,20
			PigMinimapBut:SetPoint("RIGHT",ChatFrameChannelButton,"LEFT",0,0);
			PigMinimapBut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
		else
			ButpingXY.W,ButpingXY.H=27,26
			ButpingXY.iconW,ButpingXY.iconH=17,17
			PigMinimapBut:SetPoint("BOTTOM",ChatFrameChannelButton,"TOP",0,2);
			PigMinimapBut:SetNormalAtlas("chatframe-button-up")
			PigMinimapBut:SetPushedAtlas("chatframe-button-down")
			PigMinimapBut:SetHighlightAtlas("chatframe-button-highlight");
		end
		PigMinimapBut.icon:SetDrawLayer("ARTWORK",1)
		PigMinimapBut.Snf:SetPoint("BOTTOMLEFT", PigMinimapBut_UI, "TOPRIGHT", 2, 2);
	elseif mode == 5 then--附着于ElvUI地图下方
		local function ElvUIPoint()
			if Pig_OptionsUI.IsOpen_ElvUI() and MinimapPanel:IsVisible() then
				PigMinimapBut:ClearAllPoints();	
				PigMinimapBut:SetPoint("TOPLEFT",MinimapPanel,"TOPLEFT",0.8,-0.6)
				PigMinimapBut:SetPoint("BOTTOMLEFT",MinimapPanel,"BOTTOMLEFT",0,0.6)
				local hhhh = MinimapPanel:GetHeight()	
				PigMinimapBut:SetWidth(hhhh-1.2);
				PigMinimapBut.icon:SetAllPoints(PigMinimapBut)
				local wwww = MinimapPanel:GetWidth()	
				local DataTextwww = (wwww-hhhh-2)*0.5
				if MinimapPanel_DataText1 then
					MinimapPanel_DataText1:SetWidth(DataTextwww)
					MinimapPanel_DataText1:SetPoint("LEFT",MinimapPanel,"LEFT",hhhh,0)
					MinimapPanel_DataText2:SetWidth(DataTextwww)
				end
				PigMinimapBut.Snf:SetPoint("TOPRIGHT", PigMinimapBut_UI, "BOTTOMLEFT", -2, 20);
			end
		end
		C_Timer.After(0.2,ElvUIPoint)
	end
	if Pig_OptionsUI.IsOpen_ElvUI() or Pig_OptionsUI.IsOpen_NDui() and not Pig_OptionsUI.IsOpen_NDui("Map","DisableMinimap") then PigMinimapBut.icon:SetTexCoord(0.08,0.92,0.08,0.92) end
	PigMinimapBut:SetSize(ButpingXY.W,ButpingXY.H);
	PigMinimapBut.icon:SetSize(ButpingXY.iconW,ButpingXY.iconH);
	PigMinimapBut.icon:SetPoint("CENTER", ButpingXY.iconX, ButpingXY.iconY);
end
PigMinimapBut.Snf = PIGFrame(PigMinimapBut,{"TOPRIGHT", PigMinimapBut_UI, "BOTTOMLEFT", -2, 25},{200, 100});
PigMinimapBut.Snf:PIGSetBackdrop()
PigMinimapBut.Snf:Hide();
PigMinimapBut.Snf:SetFrameLevel(1)
PigMinimapBut.Snf.tishi = PIGFontString(PigMinimapBut.Snf,nil,L["MAP_NIMIBUT_TIPS3"])
PigMinimapBut.Snf.tishi:SetPoint("TOPLEFT", PigMinimapBut.Snf, "TOPLEFT", 6, -6);
PigMinimapBut.Snf.tishi:SetPoint("BOTTOMRIGHT", PigMinimapBut.Snf, "BOTTOMRIGHT", -6, 6);
PigMinimapBut.Snf.tishi:Hide();
PigMinimapBut.Snf:SetScript("OnUpdate", function(self, ssss)
	if self.zhengzaixianshi==nil then
		return;
	else
		if self.zhengzaixianshi==true then
			if self.xiaoshidaojishi<= 0 then
				self:Hide();
				self.zhengzaixianshi = nil;
			else
				self.xiaoshidaojishi = self.xiaoshidaojishi - ssss;	
			end
		end
	end
end)
PigMinimapBut.Snf:SetScript("OnEnter", function(self)
	self.zhengzaixianshi = nil;
end)
PigMinimapBut.Snf:SetScript("OnLeave", function(self)
	self.xiaoshidaojishi = 1.5;
	self.zhengzaixianshi = true;
end)
function PIGCompartmentClick(addonName, buttonName, menuButtonFrame)
    addonsClick(buttonName)
end
function PIGCompartmentEnter(addonName, menuButtonFrame)
	Showaddonstishi(menuButtonFrame,true)	
end
function PIGCompartmentLeave(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end
--PIG屏幕提示信息栏
local infotip = CreateFrame("MessageFrame", "PIGTopMsg", UIParent);
infotip:SetSize(512,60);
infotip:SetPoint("TOP",UIParent,"TOP",0,-182);
infotip:SetFrameStrata("DIALOG")
infotip:SetTimeVisible(2)
infotip:SetFadeDuration(0.5)
PIGSetFont(infotip,16,"OUTLINE")
function infotip:add(message, Color)
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
	self:AddMessage(message, r, g, b, 1);
	PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
end
--PIGTopMsg:add(txt)
--功能动作条
Pig_Options.qiege=16
local _, _, _, tocversion = GetBuildInfo()
if tocversion<100000 then
	Pig_Options.qiege=10
end
local ActionW = ActionButton1:GetWidth()-Pig_Options.qiege
local QuickBut=PIGFrame(UIParent,nil,{ActionW+14,ActionW},"QuickButUI")
QuickBut:PIGSetMovable()
QuickBut:Hide()
QuickBut.ButList={}
function QuickBut:GengxinWidth()
	if self.nr then
		local nr = self.nr
		local butW = nr:GetHeight()
		local Children1 = {nr:GetChildren()};
		local yincangshunum=0
		for i=1,#Children1 do
			if Children1[i].yincang then
				Children1[i]:SetWidth(0.0001)
				yincangshunum=yincangshunum+1
			else
				local addW = Children1[i].addW or 0
				Children1[i]:SetWidth(butW-2+addW)
			end
		end
		local geshu1 = #Children1-yincangshunum
		if geshu1>0 then 
			self:Show()
			local NewWidth = butW*geshu1+2
			self:SetWidth(NewWidth+self.yidong:GetWidth())
		end
	end
end
function QuickBut:Add()
	QuickBut.ButList[1]()
	--[1]总开关[2]战场通报[3]饰品管理[4]符文管理[5]装备管理
	--[6]炉石/专业[7]职业辅助技能[8]角色信息统计
	--[9]售卖助手丢弃[10]售卖助手开[11]售卖助手分[12]售卖助手选矿
	-------
	-- [13]时空之门[14]时空之门喊话[15]开团助手[16]带本助手
	-- [17]带本助手-跟随,
	-- [18],
	-- [19],AFK
	for i=2,19 do
		local xfun = self.ButList[i] or function() end
		xfun()
	end
	self:GengxinWidth()
end
------------------------
--/run print(GetMouseFocus():GetName())
--/run print(GetMouseFocus():GetTexture())
-- local ButtoSDn = CreateFrame("Button",nil,UIParent, "UIPanelButtonTemplate,SecureActionButtonTemplate");
-- ButtoSDn:SetSize(76,25);
-- ButtoSDn:SetPoint("CENTER",UIParent,"CENTER",4,0);
-- ButtoSDn:SetText("ASDADA");
-- ButtoSDn:SetScript("OnClick", function ()


-- end);