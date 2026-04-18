local _, addonTable = ...;
local L=addonTable.locale
--
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
local PIGEnter=Create.PIGEnter
local CombatPlusfun=addonTable.CombatPlusfun
-------------------------
local classOK={
	[4]=2,
	[6]=1,
	[7]=1,
	[11]=2,
}
local CountColors={
	[1]={147/255, 195/255, 125/255, 1},
	[2]={1, 0.9, 0.6, 1},
	[3]={1, 0.6, 0, 1},
	[4]={0.88, 0.4, 0.4, 1},
	[5]={1, 0, 0, 0.9},
}
local function GetFuStyleV(classId,newV)
	if newV then
		PIGA["CombatPlus"]["HPMPBar"]["FuStyle"][classId]=newV
	end
	if PIGA["CombatPlus"]["HPMPBar"]["FuStyle"][classId] then
		if PIGA["CombatPlus"]["HPMPBar"]["FuStyle"][classId]==1 then
			PIGA["CombatPlus"]["HPMPBar"]["FuStyle"][classId]=nil
			return 1
		end
		return PIGA["CombatPlus"]["HPMPBar"]["FuStyle"][classId]
	else
		return 1
	end	
end
local function ADD_HPMPBarUI(setV)
	if not PIGA["CombatPlus"]["HPMPBar"]["Open"] then return end
	if CombatPlusfun.HPMPBarOpen then CombatPlusfun.HPMPBarOpen=true return end
	local HPMPBar = CreateFrame("Button", nil, UIParent, "SecureUnitButtonTemplate,SecureHandlerStateTemplate")
	HPMPBar:SetHeight(1);
	HPMPBar:SetPoint("CENTER", UIParent, "CENTER", PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"], PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"]);
	HPMPBar:EnableMouse(false)
	HPMPBar:SetAttribute("_onstate-combatYN","if newstate == 'show' then self:Show(); else self:Hide(); end")
	function HPMPBar.Set_CombatShowHide()
		if PIGA["CombatPlus"]["HPMPBar"]["CombatShow"] then
			RegisterStateDriver(HPMPBar, "combatYN", "[combat] show; hide");
		else
			RegisterStateDriver(HPMPBar, "combatYN", "[] show; hide");
		end
	end
	HPMPBar.Set_CombatShowHide()
	------------------------
	local _, classId = UnitClassBase("player");
	HPMPBar.classId=classId
	local function add_HPMPBar(fuji,ly)
		local Bar=Create.add_Bar(fuji,ly)
		fuji.next=Bar
		Bar:RegisterEvent("PLAYER_ENTERING_WORLD");
		return Bar
	end
	if PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"] then
		if classOK[HPMPBar.classId] then
			HPMPBar.Fuziyuan=add_HPMPBar(HPMPBar,HPMPBar.classId)
			HPMPBar.Fuziyuan.ButList={}
			HPMPBar.FuStyle = GetFuStyleV(classId)
			if HPMPBar.classId == 6 then--死亡骑士
				local RuneTypeColor = {
					[1]={1,40/255,40/255},
					[2]={0,191/255,1},
					[3]={30/255,255/255,100/255},
					[4]={1,20/255,147/255},
				}
				local Runeindex = {1,2,5,6,3,4}
				local function UpdateRuneType(index)
					local runeType = GetRuneType(index)
					HPMPBar.Fuziyuan.Runebut[index]:SetStatusBarColor(RuneTypeColor[runeType][1],RuneTypeColor[runeType][2],RuneTypeColor[runeType][3],1);
				end	
				local function RuneButton_OnUpdate (self)
					local start, duration, runeReady = GetRuneCooldown(self:GetID())
					if start==nil or runeReady then
						self:SetValue(10);
						self:SetAlpha(1);
						self:SetScript("OnUpdate", nil);
					else
						self:SetValue(GetTime()-start);
					end
				end
				local function UpdateRuneCooldown(index,added)
					if added then
						HPMPBar.Fuziyuan.Runebut[index]:SetAlpha(1);
						HPMPBar.Fuziyuan.Runebut[index]:SetScript("OnUpdate", nil);
					else
						HPMPBar.Fuziyuan.Runebut[index]:SetAlpha(0.7);
						HPMPBar.Fuziyuan.Runebut[index]:SetScript("OnUpdate", RuneButton_OnUpdate);
					end
				end
				local function UpdateRunesAll()
					for index=1,6 do
						UpdateRuneType(index)
						UpdateRuneCooldown(index,false)
					end
				end
				HPMPBar.Fuziyuan.Runebut={}
				for index=1,6,1 do
					local RuneBut = CreateFrame("Frame", nil, HPMPBar.Fuziyuan,"BackdropTemplate")
					RuneBut:SetBackdrop({edgeFile = Create.edgeFile, edgeSize = 8,})
					if index==1 then
						RuneBut:SetPoint("LEFT",HPMPBar.Fuziyuan,"LEFT",0,0);
					else
						RuneBut:SetPoint("LEFT",HPMPBar.Fuziyuan.ButList[index-1],"RIGHT",-1,0);
					end
					HPMPBar.Fuziyuan.ButList[index]=RuneBut
					RuneBut.bar = CreateFrame("StatusBar", nil, RuneBut,nil,Runeindex[index]);
					RuneBut.bar:SetStatusBarTexture("interface/chatframe/chatframebackground.blp")
					RuneBut.bar:SetPoint("TOPLEFT",RuneBut,"TOPLEFT",0,0);
					RuneBut.bar:SetPoint("BOTTOMRIGHT",RuneBut,"BOTTOMRIGHT",0,0);
					RuneBut.bar:SetFrameLevel(RuneBut:GetFrameLevel()-1)
					RuneBut.bar:SetMinMaxValues(0, 10)
					HPMPBar.Fuziyuan.Runebut[Runeindex[index]]=RuneBut.bar
				end
				HPMPBar.Fuziyuan:PIGBackdropBorderColor(HPMPBar.Fuziyuan.ButList)
				HPMPBar.Fuziyuan:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
				HPMPBar.Fuziyuan:RegisterEvent("RUNE_TYPE_UPDATE");
				HPMPBar.Fuziyuan:RegisterEvent("RUNE_POWER_UPDATE");
				HPMPBar.Fuziyuan:RegisterEvent("PLAYER_REGEN_DISABLED")
				HPMPBar.Fuziyuan:HookScript("OnEvent", function(self, event, arg1, arg2)
					if event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event =="PLAYER_REGEN_DISABLED" then
						UpdateRunesAll();
					elseif ( event == "RUNE_TYPE_UPDATE") then
						UpdateRuneType(arg1)
					elseif ( event == "RUNE_POWER_UPDATE") then
						UpdateRuneCooldown(arg1, arg2);
					end
				end)
			else
				--盗贼/萨满/小德
				for index=1,MAX_COMBO_POINTS,1 do			
					local Points = CreateFrame("Frame", nil, HPMPBar.Fuziyuan,"BackdropTemplate")
					Points.tex  = Points:CreateTexture();
					Points.tex:SetAtlas("ClassOverlay-ComboPoint-Off")
					HPMPBar.Fuziyuan.ButList[index]=Points
				end
				if HPMPBar.classId == 7 then
					HPMPBar.Fuziyuan:RegisterEvent("UNIT_AURA");
					function HPMPBar.Fuziyuan:Update_Points(event,arg1, arg2)
						if event=="PLAYER_ENTERING_WORLD" or arg1=="player" then
							local auraData=C_UnitAuras.GetPlayerAuraBySpellID(53817)
							if auraData and auraData.applications then
								for ix=1,auraData.applications do
									self.ButList[ix]:SetBackdropColor(unpack(CountColors[auraData.applications]));
								end
							else
								self:PIGBackdropColor(self.ButList)
							end
						end
					end
				else
					HPMPBar.Fuziyuan:RegisterEvent("UNIT_POWER_UPDATE");
					function HPMPBar.Fuziyuan:Update_Points(arg1, arg2)
						local comboPoints = GetComboPoints("player", "target");
						if HPMPBar.FuStyle==1 then
							self:PIGBackdropColor(self.ButList)
							for ix=1,comboPoints do
								self.ButList[ix]:SetBackdropColor(unpack(CountColors[comboPoints]));
							end
						else
							for ix=1,MAX_COMBO_POINTS do
								self.ButList[ix].tex:SetAtlas("ClassOverlay-ComboPoint-Off")
							end
							for ix=1,comboPoints do
								self.ButList[ix].tex:SetAtlas("ClassOverlay-ComboPoint")
							end					
						end
						-- if ( comboPoints == MAX_COMBO_POINTS ) then
						-- 	--displayType = "crit";
						-- end
					end
				end
				HPMPBar.Fuziyuan:HookScript("OnEvent", function(self, event, arg1, arg2)
					self:Update_Points(event, arg1, arg2)
				end)
			end
		end
	end
	if PIGA["CombatPlus"]["HPMPBar"]["HpShow"] then
		HPMPBar.HPBar=add_HPMPBar(HPMPBar)
		if PIG_MaxTocversion() then
			HPMPBar.HPBar:RegisterUnitEvent("UNIT_HEALTH_FREQUENT","player");
		else
			HPMPBar.HPBar:RegisterUnitEvent("UNIT_HEALTH","player");
		end
		if setV then
			HPMPBar.HPBar:Update_MaxValues(UnitHealthMax("player")) 
			HPMPBar.HPBar:Update_Values(UnitHealth("player"))
		end
		hooksecurefunc(HPMPBar.HPBar, "Set_BarFont", function()	
			HPMPBar.HPBar:Update_MaxValues(UnitHealthMax("player"))
			HPMPBar.HPBar:Update_Values(UnitHealth("player"))
		end)
		HPMPBar.HPBar:PIGStatusBarColort(0, 1, 0 ,1)
		HPMPBar.HPBar:RegisterUnitEvent("UNIT_MAXHEALTH","player");
		HPMPBar.HPBar:SetScript("OnEvent", function (self,event)
			if event=="PLAYER_ENTERING_WORLD" then
				self:Update_MaxValues(UnitHealthMax("player")) 
				self:Update_Values(UnitHealth("player"))
			elseif event=="UNIT_MAXHEALTH" then
				self:Update_MaxValues(UnitHealthMax("player"))
			elseif event=="UNIT_HEALTH_FREQUENT" or event=="UNIT_HEALTH" then
				self:Update_Values(UnitHealth("player"))
			end
		end)
	end
	if PIGA["CombatPlus"]["HPMPBar"]["MpShow"] then
		HPMPBar.MPBar=add_HPMPBar(HPMPBar)
		function HPMPBar.MPBar:Update_PowerType()
			local powerType = UnitPowerType("player")
			local info = PowerBarColor[powerType]
			self:PIGStatusBarColort(info.r, info.g, info.b ,1)
		end
		if setV then
			HPMPBar.MPBar:Update_MaxValues(UnitPowerMax("player"))
			HPMPBar.MPBar:Update_Values(UnitPower("player"))
			HPMPBar.MPBar:Update_PowerType()
		end
		hooksecurefunc(HPMPBar.MPBar, "Set_BarFont", function()	
			HPMPBar.MPBar:Update_MaxValues(UnitPowerMax("player"))
			HPMPBar.MPBar:Update_Values(UnitPower("player"))
		end)
		HPMPBar.MPBar:RegisterEvent("UNIT_DISPLAYPOWER");
		HPMPBar.MPBar:RegisterUnitEvent("UNIT_POWER_FREQUENT","player");
		HPMPBar.MPBar:RegisterUnitEvent("UNIT_MAXPOWER","player");
		HPMPBar.MPBar:SetScript("OnEvent", function (self,event)
			if event=="PLAYER_ENTERING_WORLD" then
				self:Update_MaxValues(UnitPowerMax("player"))
				self:Update_Values(UnitPower("player"))
				self:Update_PowerType()
			elseif event=="UNIT_MAXPOWER" then
				self:Update_MaxValues(UnitPowerMax("player"))
			elseif event=="UNIT_POWER_FREQUENT" then
				self:Update_Values(UnitPower("player"))
			elseif event == "UNIT_DISPLAYPOWER" then
				self:Update_MaxValues(UnitPowerMax("player"))
				self:Update_PowerType()
			end
		end)
	end
	HPMPBar.Showshuzhi=PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]
	---
	function HPMPBar.Set_StatusBarTex()
		if HPMPBar.HPBar then HPMPBar.HPBar:PIGStatusBarTexture(PIGA["CombatPlus"]["HPMPBar"]["BarTex"]) end
		if HPMPBar.MPBar then HPMPBar.MPBar:PIGStatusBarTexture(PIGA["CombatPlus"]["HPMPBar"]["BarTex"]) end
		if HPMPBar.Fuziyuan then
			HPMPBar.Fuziyuan:PIGStatusBarTexture(HPMPBar.Fuziyuan.ButList,PIGA["CombatPlus"]["HPMPBar"]["BarTex"])
			if HPMPBar.classId~=6 then
				if HPMPBar.FuStyle==1 then
					HPMPBar.Fuziyuan:PIGBackdropBorderColor(HPMPBar.Fuziyuan.ButList)
					for index=1,5 do
						HPMPBar.Fuziyuan.ButList[index].tex:Hide()
					end
				else
					for index=1,5 do
						HPMPBar.Fuziyuan.ButList[index]:SetBackdropColor(1, 1, 1, 0);
						HPMPBar.Fuziyuan.ButList[index]:SetBackdropBorderColor(1, 1, 1, 0)
						HPMPBar.Fuziyuan.ButList[index].tex:Show()
						HPMPBar.Fuziyuan.ButList[index].tex:SetPoint("BOTTOM",HPMPBar.Fuziyuan.ButList[index],"BOTTOM",0,1);
					end
				end
			end
		end
	end
	function HPMPBar.Set_StatusBarWH()
		local www = PIGA["CombatPlus"]["HPMPBar"]["BarW"] or 150
		HPMPBar:SetWidth(www);
		local hhh = PIGA["CombatPlus"]["HPMPBar"]["BarH"] or 12
		local ziframe = {HPMPBar:GetChildren()}
		for k,v in pairs(ziframe) do
			v.Plus=v.Plus or 0
			v:SetHeight(hhh+v.Plus)
		end
		if HPMPBar.Fuziyuan then
			if HPMPBar.classId==6 then
				local Runewww=www/6
				for index=1,6 do
					if HPMPBar.Fuziyuan.ButList[index] then
						HPMPBar.Fuziyuan.ButList[index]:SetHeight(hhh);
						if index==1 then
							HPMPBar.Fuziyuan.ButList[index]:SetWidth(Runewww);
						else
							HPMPBar.Fuziyuan.ButList[index]:SetWidth(Runewww+1);
						end
					end
				end
			else
				local xxww = www*0.2
				for index=1,5 do
					HPMPBar.Fuziyuan.ButList[index]:SetSize(xxww,hhh);
					if index==1 then
						HPMPBar.Fuziyuan.ButList[index]:SetPoint("LEFT",HPMPBar.Fuziyuan,"LEFT",0,0);
					else
						HPMPBar.Fuziyuan.ButList[index]:SetPoint("LEFT",HPMPBar.Fuziyuan.ButList[index-1],"RIGHT",0,0);
					end
				end
				if HPMPBar.FuStyle==2 then
					for index=1,5 do
						HPMPBar.Fuziyuan.ButList[index].tex:SetSize(hhh+4,hhh+4);
					end
				end
			end
		end
	end
	function HPMPBar.Set_BarFontAll()
		local ziframe = {HPMPBar:GetChildren()}
		for k,v in pairs(ziframe) do
			v:Set_BarFont()
		end
	end
	HPMPBar.Set_StatusBarTex()
	HPMPBar.Set_StatusBarWH()
	HPMPBar.Set_BarFontAll()
	return HPMPBar
end
function CombatPlusfun.HPMPBar()
	if PIG_MaxTocversion() then
		local HPMPBar=ADD_HPMPBarUI()
		local CombatPlusF,CombatPlustabbut =PIGOptionsList_R(CombatPlusfun.RTabFrame,L["COMBAT_TABNAME3"],100)
		CombatPlusF.Open = PIGCheckbutton_R(CombatPlusF,{"启用个人资源条","在屏幕上显示个人资源条"})
		CombatPlusF.Open:SetScript("OnClick", function (self)
			if self:GetChecked() then			
				PIGA["CombatPlus"]["HPMPBar"]["Open"]=true;
				HPMPBar=ADD_HPMPBarUI(true)
				CombatPlusF.SetF:Show()
			else
				PIGA["CombatPlus"]["HPMPBar"]["Open"]=false;
				CombatPlusF.SetF:Hide()
				PIG_OptionsUI.RLUI:Show()
			end
		end)
		CombatPlusF:HookScript("OnShow", function (self)
			self.Open:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["Open"]);
			if not CombatPlusF.SetF then
				CombatPlusF.SetF = PIGFrame(CombatPlusF,{"TOPLEFT", CombatPlusF, "TOPLEFT", 0, -60})
				CombatPlusF.SetF:SetPoint("BOTTOMRIGHT",CombatPlusF,"BOTTOMRIGHT",0,0);
				CombatPlusF.SetF:PIGSetBackdrop(0)
				local _, classId = UnitClassBase("player");
				---
				CombatPlusF.SetF.BarTex=PIGDownMenu(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF,"TOPLEFT",60,-20},{150,24})
				CombatPlusF.SetF.BarTex.T = PIGFontString(CombatPlusF.SetF.BarTex,{"RIGHT",CombatPlusF.SetF.BarTex,"LEFT",-4,0},TEXTURES_SUBHEADER)
				function CombatPlusF.SetF.BarTex:PIGDownMenu_Update_But()
					local info = {}
					info.func = self.PIGDownMenu_SetValue
					for i=1,Create.BarTexNum,1 do
					    info.text, info.arg1 = TEXTURES_SUBHEADER..i, i
					    info.checked = i==PIGA["CombatPlus"]["HPMPBar"]["BarTex"]
						self:PIGDownMenu_AddButton(info)
					end 
				end
				function CombatPlusF.SetF.BarTex:PIGDownMenu_SetValue(value,arg1,arg2)
					self:PIGDownMenu_SetText(value)
					PIGA["CombatPlus"]["HPMPBar"]["BarTex"]=arg1
					HPMPBar.Set_StatusBarTex()
					PIGCloseDropDownMenus()
				end
				CombatPlusF.SetF.CombatShow =PIGCheckbutton(CombatPlusF.SetF,{"LEFT",CombatPlusF.SetF.BarTex,"LEFT",200,0},{"脱战后隐藏","脱战后隐藏血量资源条"})
				CombatPlusF.SetF.CombatShow:SetScript("OnClick", function (self)
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["CombatShow"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["CombatShow"]=false;
					end
					HPMPBar.Set_CombatShowHide()
				end);
				--
				local function Set_WHXY()
					HPMPBar:SetPoint("CENTER", UIParent, "CENTER", PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"], PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"]);
				end
				local WowWidth=floor(GetScreenWidth()*0.5);
				local xiayiinfo = {-WowWidth,WowWidth,1}
				CombatPlusF.SetF.SliderX = PIGSlider(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF,"TOPLEFT",60,-70},xiayiinfo)
				CombatPlusF.SetF.SliderX.T = PIGFontString(CombatPlusF.SetF.SliderX,{"RIGHT",CombatPlusF.SetF.SliderX,"LEFT",0,0},"X偏移")
				function CombatPlusF.SetF.SliderX:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"]=arg1;
					Set_WHXY()
				end
				local WowHeight=floor(GetScreenHeight()*0.5);
				local xiayiinfo = {-WowHeight,WowHeight,1}
				CombatPlusF.SetF.SliderY = PIGSlider(CombatPlusF.SetF,{"LEFT",CombatPlusF.SetF.SliderX,"RIGHT",100,0},xiayiinfo)
				CombatPlusF.SetF.SliderY.T = PIGFontString(CombatPlusF.SetF.SliderY,{"RIGHT",CombatPlusF.SetF.SliderY,"LEFT",0,0},"Y偏移")
				function CombatPlusF.SetF.SliderY:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"]=arg1;
					Set_WHXY()
				end
				CombatPlusF.SetF.CZBUT = PIGButton(CombatPlusF.SetF,{"LEFT",CombatPlusF.SetF.SliderY,"RIGHT",60,0},{80,24},RESET_POSITION)
				CombatPlusF.SetF.CZBUT:SetScript("OnClick", function ()
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"]=addonTable.Default["CombatPlus"]["HPMPBar"]["Xpianyi"]
					PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"]=addonTable.Default["CombatPlus"]["HPMPBar"]["Ypianyi"]
					CombatPlusF.SetF.SliderX:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"])
					CombatPlusF.SetF.SliderY:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"])
					Set_WHXY()
				end)

				local xiayiinfo = {100,400,1}
				CombatPlusF.SetF.BarW = PIGSlider(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF,"TOPLEFT",60,-140},xiayiinfo)
				CombatPlusF.SetF.BarW.T = PIGFontString(CombatPlusF.SetF.BarW,{"RIGHT",CombatPlusF.SetF.BarW,"LEFT",0,0},"宽度")
				function CombatPlusF.SetF.BarW:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["BarW"]=arg1;
					HPMPBar.Set_StatusBarWH()
				end
				local xiayiinfo = {10,60,1}
				CombatPlusF.SetF.BarH = PIGSlider(CombatPlusF.SetF,{"LEFT",CombatPlusF.SetF.BarW,"RIGHT",100,0},xiayiinfo)
				CombatPlusF.SetF.BarH.T = PIGFontString(CombatPlusF.SetF.BarH,{"RIGHT",CombatPlusF.SetF.BarH,"LEFT",0,0},"高度")
				function CombatPlusF.SetF.BarH:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["BarH"]=arg1;
					HPMPBar.Set_StatusBarWH()
				end
				CombatPlusF.SetF.CZSize = PIGButton(CombatPlusF.SetF,{"LEFT",CombatPlusF.SetF.BarH,"RIGHT",60,0},{80,24},"默认大小")
				CombatPlusF.SetF.CZSize:SetScript("OnClick", function ()
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["BarW"]=addonTable.Default["CombatPlus"]["HPMPBar"]["BarW"]
					PIGA["CombatPlus"]["HPMPBar"]["BarH"]=addonTable.Default["CombatPlus"]["HPMPBar"]["BarH"]
					CombatPlusF.SetF.BarW:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["BarW"])
					CombatPlusF.SetF.BarH:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["BarH"])
					HPMPBar.Set_StatusBarWH()
				end)
				CombatPlusF.SetF.Showshuzhi =PIGCheckbutton(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF,"TOPLEFT",20,-240},{"显示数值","显示血量/资源数值"})
				CombatPlusF.SetF.Showshuzhi:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]=true;
						HPMPBar.Showshuzhi=true
					else
						PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]=false;
						HPMPBar.Showshuzhi=false
					end
					HPMPBar.Set_BarFontAll()
				end);
				local xiayiinfo = {10,26,1}
				CombatPlusF.SetF.FontSize = PIGSlider(CombatPlusF.SetF,{"LEFT",CombatPlusF.SetF.Showshuzhi,"LEFT",210,0},xiayiinfo)
				CombatPlusF.SetF.FontSize.T = PIGFontString(CombatPlusF.SetF.FontSize,{"RIGHT",CombatPlusF.SetF.FontSize,"LEFT",-10,0},"字体大小")
				function CombatPlusF.SetF.FontSize:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["FontSize"]=arg1;
					HPMPBar.Set_BarFontAll()
				end

				CombatPlusF.SetF.HpShow =PIGCheckbutton(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF.Showshuzhi,"TOPLEFT",0,-40},{"显示血量条","个人资源条显示血量"})
				CombatPlusF.SetF.HpShow:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["HpShow"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["HpShow"]=false;
					end
					PIG_OptionsUI.RLUI:Show()
				end);
				CombatPlusF.SetF.MpShow =PIGCheckbutton(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF.HpShow,"TOPLEFT",0,-40},{"显示资源条","个人资源条显示资源"})
				CombatPlusF.SetF.MpShow:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["MpShow"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["MpShow"]=false;
					end
					PIG_OptionsUI.RLUI:Show()
				end);
				if classOK[classId] then
					CombatPlusF.SetF.Fuziyuan =PIGCheckbutton(CombatPlusF.SetF,{"TOPLEFT",CombatPlusF.SetF.MpShow,"TOPLEFT",0,-40},{"显示特殊资源条","个人资源条显示特殊资源(连击点/符文/其他)"})
					CombatPlusF.SetF.Fuziyuan:SetScript("OnClick", function (self)
						if self:GetChecked() then
							PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]=true;
						else
							PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]=false;
						end
						PIG_OptionsUI.RLUI:Show()
					end);
					if PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]  then
						CombatPlusF.SetF.Fuziyuan.style=PIGDownMenu(CombatPlusF.SetF.Fuziyuan,{"LEFT",CombatPlusF.SetF.Fuziyuan.Text,"RIGHT",2,0},{80,24})
						function CombatPlusF.SetF.Fuziyuan.style:PIGDownMenu_Update_But()
							local info = {}
							info.func = self.PIGDownMenu_SetValue
							for i=1,classOK[classId],1 do
							    info.text, info.arg1 = TEXTURES_SUBHEADER..i, i
							   	info.checked = i==GetFuStyleV(classId)
								self:PIGDownMenu_AddButton(info)
							end
						end
						function CombatPlusF.SetF.Fuziyuan.style:PIGDownMenu_SetValue(value,arg1,arg2)
							if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
							self:PIGDownMenu_SetText(value)
							HPMPBar.FuStyle = GetFuStyleV(classId,arg1)
							HPMPBar.Set_StatusBarTex()
							HPMPBar.Set_StatusBarWH()
							PIGCloseDropDownMenus()
						end
					end
				end
				function CombatPlusF.SetF:UpdateSetF()
					self.Showshuzhi:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]);
					self.CombatShow:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["CombatShow"]);
					self.FontSize:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["FontSize"])
					self.BarW:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["BarW"])
					self.BarH:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["BarH"])
					self.SliderX:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"])
					self.SliderY:PIGSetValue(PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"])
					self.BarTex:PIGDownMenu_SetText(TEXTURES_SUBHEADER..PIGA["CombatPlus"]["HPMPBar"]["BarTex"])
					self.HpShow:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["HpShow"]);
					self.MpShow:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["MpShow"]);
					if self.Fuziyuan then
						self.Fuziyuan:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]);
						if self.Fuziyuan.style then
							self.Fuziyuan.style:PIGDownMenu_SetText(TEXTURES_SUBHEADER..GetFuStyleV(classId))
						end
					end
				end
				CombatPlusF.SetF:UpdateSetF()
				CombatPlusF.SetF:HookScript("OnShow", function (self)
					self:UpdateSetF()
				end);
			end
			self.SetF:SetShown(PIGA["CombatPlus"]["HPMPBar"]["Open"])
		end)
		
	end
end