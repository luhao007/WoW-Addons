local _, PD = ...;
local L=PD.locale
local sub = _G.string.sub
--
local Data=PD.Data
local Fun=PD.Fun
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton = Create.PIGButton
local PIGDiyBut=Create.PIGDiyBut
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
local PIGUseKeyDown=Fun.PIGUseKeyDown
--
local CombatPlusfun=PD.CombatPlusfun
--------
local function IsMarkerOK()
	if PlaceRaidMarker and GetClassicExpansionLevel() >= LE_EXPANSION_CATACLYSM then
		return true
	end
	return false
end
local OpGongnum=0
local addGongnum=-26
local biaojiW,OptionsTop,GNNmame = 22, 180, "PIG_"
local GNLsitsName={"markerW","markerR"}
local GNLsits={
	["markerW"]={["yes"]=IsMarkerOK(),["name"]="地面标记",["barHH"]=biaojiW-8,["iconNum"]=9},
	["markerR"]={["yes"]=true,["name"]="目标标记",["barHH"]=biaojiW,["iconNum"]=9},
}
local biaoji_icon = "interface/targetingframe/ui-raidtargetingicons"
local RiconList = {
	{biaoji_icon,{0.75,1,0.25,0.5}},
	{biaoji_icon,{0.5,0.75,0.25,0.5}},
	{biaoji_icon,{0.25,0.5,0.25,0.5}},
	{biaoji_icon,{0,0.25,0.25,0.5}},
	{biaoji_icon,{0.75,1,0,0.25}},
	{biaoji_icon,{0.5,0.75,0,0.25}},
	{biaoji_icon,{0.25,0.5,0,0.25}},
	{biaoji_icon,{0,0.25,0,0.25}},
	{"Interface/Buttons/UI-GroupLoot-Pass-Up"},
}
---
local WmarkerIndex={
	[1]={8,1,1,1},
	[2]={4,1,60/255,60/255},
	[3]={1,0,191/255,1},
	[4]={7,135/255,180/255,200/255},
	[5]={2,30/255,255/255,100/255},
	[6]={3,240/255,60/255,1},
	[7]={6,1,155/255,0},
	[8]={5,1,1,50/255},
}
-----
local function SetAutoShowFun(peizhiT)
	local pigui=_G[GNNmame..peizhiT]
	if peizhiT=="markerW" and InCombatLockdown() then
		pigui.nextfun=function()
			SetAutoShowFun(peizhiT)
		end
		return
	end
	pigui.ShowHide=true
	if pigui.NoGroup and not IsInGroup() then
		pigui.ShowHide=false
	else
		if peizhiT=="markerR" then
			if pigui.NoTarget and not UnitExists("target") then
				pigui.ShowHide=false
			elseif pigui.AutoShow and IsInGroup() and not CanBeRaidTarget("player") then--
				pigui.ShowHide=false
			end
		elseif peizhiT=="markerW" then
			if pigui.AutoShow and not IsInGroup() or pigui.AutoShow and UnitIsGroupAssistant("player")==false and UnitIsGroupLeader("player")==false then
				pigui.ShowHide=false
			end
		end
	end
	if PIG_MaxTocversion() then
		pigui:SetShown(pigui.ShowHide)
	else
		for i=1,#pigui.ButList do
			if peizhiT=="markerR" then
				pigui.ButList[i].icon:SetDesaturated(not pigui.ShowHide)
			elseif peizhiT=="markerW" then
				if i<9 then
					if pigui.ShowHide then
						pigui.ButList[i].bgX:SetBackdropColor(WmarkerIndex[i][2], WmarkerIndex[i][3], WmarkerIndex[i][4], 1);
					else
						pigui.ButList[i].bgX:SetBackdropColor(0.5, 0.5, 0.5, 1);
					end
				else
					pigui.ButList[i].bgX.x:SetDesaturated(not pigui.ShowHide)
				end
			end
		end
	end
end
local function SetAutoShow(peizhiT)
	local pigui=_G[GNNmame..peizhiT]
	if pigui then
		pigui.NoGroup=PIGA["CombatPlus"][peizhiT]["NoGroup"]
		pigui.AutoShow=PIGA["CombatPlus"][peizhiT]["AutoShow"]
		pigui.NoTarget=PIGA["CombatPlus"][peizhiT]["NoTarget"]
		if peizhiT=="markerW" and InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) end
		SetAutoShowFun(peizhiT)
	end
end
local function SetBGHide(peizhiT)
	local pigui=_G[GNNmame..peizhiT]
	if pigui then
		if PIGA["CombatPlus"][peizhiT]["BGHide"] then
			pigui:SetBackdropColor(0, 0, 0, 0);
			pigui:SetBackdropBorderColor(0, 0, 0, 0);
		else
			pigui:SetBackdropColor(0.08, 0.08, 0.08, 0.4);
			pigui:SetBackdropBorderColor(0.3,0.3,0.3,0.9);
		end
	end
end
local function SetLookUI(peizhiT)
	local pigui=_G[GNNmame..peizhiT]
	if pigui then
		pigui.yidong:SetShown(not PIGA["CombatPlus"][peizhiT]["Lock"])
	end
end
local function SetScaleUI(peizhiT)
	local pigui=_G[GNNmame..peizhiT]
	if pigui then
		pigui:SetScale(PIGA["CombatPlus"][peizhiT]["Scale"])
	end
end
local function add_barUI(peizhiT)
	if not PIGA["CombatPlus"][peizhiT]["Open"] then return end
	if _G[GNNmame..peizhiT] then return end
	local SizeHH=GNLsits[peizhiT].barHH+4
	local listNum=GNLsits[peizhiT].iconNum
	local bartopV =addGongnum
	Data.UILayout[GNNmame..peizhiT]={"TOP", "TOP", 0, bartopV}
	local biaojiUIx = PIGFrame(UIParent,nil,{(biaojiW+3)*listNum+5,SizeHH},GNNmame..peizhiT)
	Create.PIG_SetPoint(GNNmame..peizhiT)
	biaojiUIx.SizeHH=SizeHH+2
	biaojiUIx.bartopV=bartopV
	addGongnum=addGongnum-SizeHH-2
	biaojiUIx:PIGSetBackdrop(0.4,0.9,nil,{0.3,0.3,0.3})
	if PIG_MaxTocversion() then
		biaojiUIx:Hide()
	end
	biaojiUIx.yidong = PIGFrame(biaojiUIx)
	biaojiUIx.yidong:PIGSetBackdrop(0.4,0.9,nil,{0.3,0.3,0.3})
	biaojiUIx.yidong:SetSize(12, SizeHH)
	biaojiUIx.yidong:SetPoint("RIGHT",biaojiUIx,"LEFT",1,0);
	biaojiUIx.yidong:PIGSetMovable(biaojiUIx)
	biaojiUIx.yidong:SetScript("OnEnter", function (self)
		self:SetBackdropBorderColor(0,0.8,1,0.9);
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",12,0);
		GameTooltip:AddLine(KEY_BUTTON1.."-|cff00FFff"..TUTORIAL_TITLE2.."|r\n"..KEY_BUTTON2.."-|cff00FFff"..SETTINGS.."|r")	
		GameTooltip:Show();
	end);
	biaojiUIx.yidong:SetScript("OnLeave", function (self)
		self:SetBackdropBorderColor(0.3,0.3,0.3,0.9);
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end)
	biaojiUIx.yidong:SetScript("OnMouseUp", function (self,Button)
		if Button=="RightButton" then PD.UpdateOptionsUI() CombatPlusfun.Show_OptionsUI() end
	end);
	---
	biaojiUIx.ButList={}
	for i=1,listNum do
		local listbut
		if peizhiT=="markerR" then
			if PIG_MaxTocversion() then
				listbut = CreateFrame("Button", nil, biaojiUIx)
			else
				listbut = CreateFrame("Button", nil, biaojiUIx,"SecureActionButtonTemplate")
			end
			listbut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			listbut:SetSize(biaojiW,biaojiW)	
			listbut:SetPoint("LEFT", biaojiUIx, "LEFT",i*(biaojiW+3)-biaojiW,0)
			listbut.icon = listbut:CreateTexture()
			listbut.icon:SetTexture(RiconList[i][1]);
			listbut.icon:SetSize(biaojiW,biaojiW)
			listbut.icon:SetPoint("CENTER", 0, 0);
			if RiconList[i][2] then
				listbut.icon:SetTexCoord(RiconList[i][2][1],RiconList[i][2][2],RiconList[i][2][3],RiconList[i][2][4])
			end
			if PIG_MaxTocversion() then
				listbut:SetScript("OnClick", function(self) 
					--SetRaidTargetIcon("target", listNum-i) 
					SetRaidTarget("target", listNum-i)
				end)
			else
				listbut:RegisterForClicks("LeftButtonUp", "LeftButtonDown", "RightButtonUp", "RightButtonDown")
				listbut:SetAttribute("type1", "macro")
				listbut:SetAttribute("macrotext1", "/tm " .. listNum-i)
			end		
		elseif peizhiT=="markerW" then
			listbut = CreateFrame("CheckButton", nil, biaojiUIx,"SecureActionButtonTemplate")
			PIGUseKeyDown(listbut)
			listbut:SetSize(biaojiW,biaojiW-10)
			listbut:SetPoint("LEFT", biaojiUIx, "LEFT",i*(biaojiW+3)-biaojiW,0)
			listbut.bgX = CreateFrame("Frame", nil, listbut,"BackdropTemplate")
			listbut.bgX:SetBackdrop(Create.BackdropData);
			listbut.bgX:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
			listbut.bgX:SetAllPoints(listbut)
			listbut:SetScript("OnEnter", function (self)
				self.bgX:SetBackdropBorderColor(0, 1, 1, 1);
			end);
			listbut:SetScript("OnLeave", function (self)
				self.bgX:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
			end)
			if i<9 then
				listbut.bgX:SetBackdropColor(WmarkerIndex[i][2], WmarkerIndex[i][3], WmarkerIndex[i][4], 1);
				listbut:SetAttribute("type1","worldmarker")
				listbut:SetAttribute("marker1",WmarkerIndex[i][1])
				listbut:SetAttribute("type2","worldmarker")
				listbut:SetAttribute("marker2",WmarkerIndex[i][1])
				listbut:SetAttribute("action1","set")
				listbut:SetAttribute("action2","clear")
			else
				listbut.bgX:SetBackdropColor(0.5, 0.5, 0.5, 0.4);
				listbut.bgX.x = listbut.bgX:CreateTexture();
				listbut.bgX.x:SetTexture("Interface/Buttons/UI-GroupLoot-Pass-Up")
				listbut.bgX.x:SetPoint("CENTER",0,0);
				listbut.bgX.x:SetSize(biaojiW*0.5,biaojiW*0.5);
				listbut.bgX.x:SetAlpha(0.5)
				listbut:SetAttribute("action","clear")
				listbut:SetAttribute("type","worldmarker")
			end	
		end
		listbut:HookScript("OnClick", function(self) 
			if i~=listNum then
				PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
			end
		end)
		biaojiUIx.ButList[i]=listbut
	end
	biaojiUIx:SetScale(PIGA["CombatPlus"][peizhiT]["Scale"])
	biaojiUIx.yidong:SetShown(not PIGA["CombatPlus"][peizhiT]["Lock"])
	SetBGHide(peizhiT)
	SetAutoShow(peizhiT)
	biaojiUIx:RegisterEvent("GROUP_ROSTER_UPDATE")
	biaojiUIx:RegisterEvent("RAID_ROSTER_UPDATE")
	biaojiUIx:RegisterEvent("PLAYER_REGEN_ENABLED")
	biaojiUIx:RegisterEvent("PLAYER_ENTERING_WORLD")
	biaojiUIx:RegisterEvent("RAID_TARGET_UPDATE")
	biaojiUIx:RegisterEvent("PLAYER_TARGET_CHANGED")
	biaojiUIx:SetScript("OnEvent", function(self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			if self.nextfun then
				self.nextfun()
				self.nextfun=nil
			end
		else
			SetAutoShowFun(peizhiT) 
		end
	end);
end
function CombatPlusfun.Marker()
	for i=1,#GNLsitsName do
		if GNLsits[GNLsitsName[i]].yes then
			add_barUI(GNLsitsName[i])
		end
	end
end
--------------------------
function CombatPlusfun.addOptions_Marker()
	local Tab2_F,Tab2_Fbut =PIGOptionsList_R(CombatPlusfun.RTabFrame,L["COMBAT_TABNAME1"],90)
	Tab2_F:Show()
	Tab2_Fbut:Selected(true)
	function CombatPlusfun.Show_OptionsUI()
		Create.Show_TabBut(CombatPlusfun.fuFrame,CombatPlusfun.fuFrameBut)
		Create.Show_TabBut_R(CombatPlusfun.RTabFrame,Tab2_F,Tab2_Fbut)
	end
	local function add_Options(peizhiT,topHV)
		local nameGN=GNLsits[peizhiT].name
		local checkbutOpen = PIGCheckbutton(Tab2_F,{"TOPLEFT",Tab2_F,"TOPLEFT",20,topHV-20},{"启用"..nameGN.."按钮","在屏幕上显示"..nameGN.."按钮"})
		checkbutOpen:SetChecked(PIGA["CombatPlus"][peizhiT]["Open"]);
		checkbutOpen:SetScript("OnClick", function (self)
			if peizhiT=="markerW" and InCombatLockdown() then self:SetChecked(PIGA["CombatPlus"][peizhiT]["Open"]) PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
			if self:GetChecked() then
				PIGA["CombatPlus"][peizhiT]["Open"]=true;
				add_barUI(peizhiT)
			else
				PIGA["CombatPlus"][peizhiT]["Open"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			checkbutOpen.F.UpdateSetUI()
		end)
		---
		checkbutOpen.F = PIGFrame(Tab2_F,{"TOPLEFT",Tab2_F,"TOPLEFT",0,-50},{1,1})
		checkbutOpen.F:PIGSetBackdrop(0)
		checkbutOpen.F:SetPoint("BOTTOMRIGHT",Tab2_F,"BOTTOMRIGHT",0,0);

		checkbutOpen.F.CZBUT = PIGButton(checkbutOpen.F,{"BOTTOMRIGHT",checkbutOpen.F,"TOPRIGHT",-20,10},{60,22},RESET)
		checkbutOpen.F.CZBUT:SetScript("OnClick", function ()
			PIGA["CombatPlus"][peizhiT]=CopyTable(PD.Default["CombatPlus"][peizhiT])
			PIGA["CombatPlus"][peizhiT]["Open"]=true
			SetScaleUI(peizhiT)
			SetBGHide(peizhiT)
			SetAutoShow(peizhiT)
			Create.PIG_ResPoint(GNNmame..peizhiT)
			checkbutOpen.F.UpdateSetUI()
		end)

		checkbutOpen.F.BGHide= PIGCheckbutton(checkbutOpen.F,{"TOPLEFT",checkbutOpen.F,"TOPLEFT",20,-20},{"隐藏背景","隐藏标记按钮背景"})
		checkbutOpen.F.BGHide:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["CombatPlus"][peizhiT]["BGHide"]=true;
			else
				PIGA["CombatPlus"][peizhiT]["BGHide"]=false;
			end
			SetBGHide(peizhiT)
		end);
		checkbutOpen.F.Lock =PIGCheckbutton(checkbutOpen.F,{"LEFT",checkbutOpen.F.BGHide.Text,"RIGHT",30,0},{LOCK_FRAME,LOCK_FOCUS_FRAME})
		checkbutOpen.F.Lock:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["CombatPlus"][peizhiT]["Lock"]=true;
			else
				PIGA["CombatPlus"][peizhiT]["Lock"]=false;
			end
			SetLookUI(peizhiT)
		end);
		checkbutOpen.F.Slider = PIGSlider(checkbutOpen.F,{"LEFT",checkbutOpen.F.Lock.Text,"RIGHT",20,0},{0.6,2,0.01,{["Right"]="缩放%d%%"}})
		function checkbutOpen.F.Slider:PIGOnValueChange(arg1)
			PIGA["CombatPlus"][peizhiT]["Scale"]=arg1;
			SetScaleUI(peizhiT)
		end

		checkbutOpen.F.AutoShow= PIGCheckbutton(checkbutOpen.F,{"TOPLEFT",checkbutOpen.F.BGHide,"BOTTOMLEFT",0,-20},{"无权限隐藏","当你没有标记权限时隐藏标记按钮"})
		checkbutOpen.F.AutoShow:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["CombatPlus"][peizhiT]["AutoShow"]=true;
			else
				PIGA["CombatPlus"][peizhiT]["AutoShow"]=false;
			end
			SetAutoShow(peizhiT)
		end);
		if peizhiT=="markerR" then
			checkbutOpen.F.NoTarget= PIGCheckbutton(checkbutOpen.F,{"LEFT",checkbutOpen.F.AutoShow,"RIGHT",120,0},{"无目标隐藏","当你没有目标时隐藏标记按钮"})
			checkbutOpen.F.NoTarget:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["CombatPlus"][peizhiT]["NoTarget"]=true;
				else
					PIGA["CombatPlus"][peizhiT]["NoTarget"]=false;
				end
				SetAutoShow(peizhiT)
			end);
			checkbutOpen.F.NoGroup= PIGCheckbutton(checkbutOpen.F,{"LEFT",checkbutOpen.F.NoTarget,"RIGHT",120,0},{"单人时隐藏","当你单人时隐藏标记按钮"})
			checkbutOpen.F.NoGroup:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["CombatPlus"][peizhiT]["NoGroup"]=true;
				else
					PIGA["CombatPlus"][peizhiT]["NoGroup"]=false;
				end
				SetAutoShow(peizhiT)
			end);
		end
		function checkbutOpen.F.UpdateSetUI()
			checkbutOpen.F.Lock:SetChecked(PIGA["CombatPlus"][peizhiT]["Lock"]);
			checkbutOpen.F.BGHide:SetChecked(PIGA["CombatPlus"][peizhiT]["BGHide"]);
			checkbutOpen.F.Slider:PIGSetValue(PIGA["CombatPlus"][peizhiT]["Scale"])
			checkbutOpen.F.AutoShow:SetChecked(PIGA["CombatPlus"][peizhiT]["AutoShow"]);
			if checkbutOpen.F.NoGroup then checkbutOpen.F.NoGroup:SetChecked(PIGA["CombatPlus"][peizhiT]["NoGroup"]);end
			if checkbutOpen.F.NoTarget then checkbutOpen.F.NoTarget:SetChecked(PIGA["CombatPlus"][peizhiT]["NoTarget"]);end
			checkbutOpen.F:SetShown(PIGA["CombatPlus"][peizhiT]["Open"])
		end
		checkbutOpen.F.UpdateSetUI()
	end
	Tab2_F:SetScript("OnShow", function ()
		if Tab2_F.yiann then return end
		for i=1,#GNLsitsName do
			if GNLsits[GNLsitsName[i]].yes then
				local topHV=-(OpGongnum*OptionsTop)
				if OpGongnum>0 then PIGLine(Tab2_F,"TOP",topHV) end
				add_Options(GNLsitsName[i],topHV)
				OpGongnum=OpGongnum+1
			end
		end
		Tab2_F.yiann=true
	end);
end