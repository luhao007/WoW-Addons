local _, PD = ...;
local L=PD.locale
local Data=PD.Data
local TalentData=Data.TalentData
--
local Create=PD.Create
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
local CombatPlusfun=PD.CombatPlusfun
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
local PIG_HPMPBarUI
local function ADD_HPMPBarUI(setV)
	if not PIGA["CombatPlus"]["HPMPBar"]["Open"] then return end
	if PIG_HPMPBarUI then return end
	local HPMPBar = CreateFrame("Button", nil, UIParent, "SecureUnitButtonTemplate,SecureHandlerStateTemplate")
	PIG_HPMPBarUI=HPMPBar
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
			function HPMPBar.Fuziyuan:Update_Points() end
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
					local function Update_Fun()
						local auraData=C_UnitAuras.GetPlayerAuraBySpellID(53817)
						if auraData and auraData.applications then
							for ix=1,auraData.applications do
								HPMPBar.Fuziyuan.ButList[ix]:SetBackdropColor(unpack(CountColors[auraData.applications]));
							end
						else
							HPMPBar.Fuziyuan:PIGBackdropColor(HPMPBar.Fuziyuan.ButList)
						end
					end
					HPMPBar.Fuziyuan:RegisterEvent("CHARACTER_POINTS_CHANGED");--分配天赋点触发
					HPMPBar.Fuziyuan:RegisterEvent("PLAYER_TALENT_UPDATE");--天赋改变
					function HPMPBar.Fuziyuan:Update_Points(event,arg1, arg2)
						if event=="PLAYER_ENTERING_WORLD" or event=="CHARACTER_POINTS_CHANGED" or event=="PLAYER_TALENT_UPDATE" then
							local datax=TalentData.GetTianfuIcon(nil,HPMPBar.classId,"player")
							if datax[4]==2 then
								HPMPBar.Fuziyuan:Show()
								HPMPBar.Fuziyuan:RegisterEvent("UNIT_AURA");
								Update_Fun()
							else
								HPMPBar.Fuziyuan:Hide()
								HPMPBar.Fuziyuan:UnregisterEvent("UNIT_AURA");
							end
						elseif event=="UNIT_AURA" and arg1=="player" then
							Update_Fun()
						end
					end
				else
					HPMPBar.Fuziyuan:RegisterEvent("UNIT_POWER_UPDATE");
					function HPMPBar.Fuziyuan:Update_Points(event, arg1, arg2)
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
		ADD_HPMPBarUI()
	end
end
function CombatPlusfun.addOptions_HPMPBar()
	if PIG_MaxTocversion() then
		local Tab2_F =PIGOptionsList_R(CombatPlusfun.RTabFrame,L["COMBAT_TABNAME3"],100)
		Tab2_F.Open = PIGCheckbutton_R(Tab2_F,{"启用个人资源条","在屏幕上显示个人资源条"})
		Tab2_F.Open:SetChecked(PIGA["CombatPlus"]["HPMPBar"]["Open"]);
		Tab2_F.Open:SetScript("OnClick", function (self)
			if self:GetChecked() then			
				PIGA["CombatPlus"]["HPMPBar"]["Open"]=true;
				ADD_HPMPBarUI(true)
			else
				PIGA["CombatPlus"]["HPMPBar"]["Open"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			Tab2_F.SetF:SetShown(PIGA["CombatPlus"]["HPMPBar"]["Open"])
		end)
		Tab2_F:HookScript("OnShow", function (self)
			Tab2_F.Update_SetUI()
		end)
		function Tab2_F.Update_SetUI()
			if not Tab2_F.SetF then
				Tab2_F.SetF = PIGFrame(Tab2_F,{"TOPLEFT", Tab2_F, "TOPLEFT", 0, -50})
				Tab2_F.SetF:SetPoint("BOTTOMRIGHT",Tab2_F,"BOTTOMRIGHT",0,0);
				Tab2_F.SetF:PIGSetBackdrop(0)
				local _, classId = UnitClassBase("player");
				---
				Tab2_F.SetF.BarTex=PIGDownMenu(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF,"TOPLEFT",60,-20},{150,24})
				Tab2_F.SetF.BarTex.T = PIGFontString(Tab2_F.SetF.BarTex,{"RIGHT",Tab2_F.SetF.BarTex,"LEFT",-4,0},TEXTURES_SUBHEADER)
				function Tab2_F.SetF.BarTex:PIGDownMenu_Update_But()
					local info = {}
					info.func = self.PIGDownMenu_SetValue
					for i=1,Create.BarTexNum,1 do
					    info.text, info.arg1 = TEXTURES_SUBHEADER..i, i
					    info.checked = i==PIGA["CombatPlus"]["HPMPBar"]["BarTex"]
						self:PIGDownMenu_AddButton(info)
					end 
				end
				function Tab2_F.SetF.BarTex:PIGDownMenu_SetValue(value,arg1,arg2)
					self:PIGDownMenu_SetText(value)
					PIGA["CombatPlus"]["HPMPBar"]["BarTex"]=arg1
					PIG_HPMPBarUI.Set_StatusBarTex()
					PIGCloseDropDownMenus()
				end
				Tab2_F.SetF.CombatShow =PIGCheckbutton(Tab2_F.SetF,{"LEFT",Tab2_F.SetF.BarTex,"LEFT",200,0},{"脱战后隐藏","脱战后隐藏血量资源条"})
				Tab2_F.SetF.CombatShow:SetScript("OnClick", function (self)
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["CombatShow"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["CombatShow"]=false;
					end
					PIG_HPMPBarUI.Set_CombatShowHide()
				end);
				--
				local function Set_WHXY()
					PIG_HPMPBarUI:SetPoint("CENTER", UIParent, "CENTER", PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"], PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"]);
				end
				local WowWidth=floor(GetScreenWidth()*0.5);
				Tab2_F.SetF.SliderX = PIGSlider(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF,"TOPLEFT",20,-60},{-WowWidth,WowWidth,1,{["Right"]="X偏移%d"}},220)
				function Tab2_F.SetF.SliderX:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["Xpianyi"]=arg1;
					Set_WHXY()
				end
				local WowHeight=floor(GetScreenHeight()*0.5);
				Tab2_F.SetF.SliderY = PIGSlider(Tab2_F.SetF,{"LEFT",Tab2_F.SetF.SliderX,"RIGHT",80,0},{-WowHeight,WowHeight,1,{["Right"]="Y偏移%d"}},220)
				function Tab2_F.SetF.SliderY:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["Ypianyi"]=arg1;
					Set_WHXY()
				end

				Tab2_F.SetF.BarW = PIGSlider(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.SliderX,"BOTTOMLEFT",0,-10},{100,400,1,{["Right"]="宽度%d"}},220)
				function Tab2_F.SetF.BarW:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["BarW"]=arg1;
					PIG_HPMPBarUI.Set_StatusBarWH()
				end
				Tab2_F.SetF.BarH = PIGSlider(Tab2_F.SetF,{"LEFT",Tab2_F.SetF.BarW,"RIGHT",80,0},{10,60,1,{["Right"]="高度%d"}},220)
				function Tab2_F.SetF.BarH:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["BarH"]=arg1;
					PIG_HPMPBarUI.Set_StatusBarWH()
				end
	
				Tab2_F.SetF.Showshuzhi =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.BarW,"BOTTOMLEFT",0,-20},{"显示数值","显示血量/资源数值"})
				Tab2_F.SetF.Showshuzhi:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]=false;
					end
					PIG_HPMPBarUI.Showshuzhi=PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]
					PIG_HPMPBarUI.Set_BarFontAll()
				end);
				Tab2_F.SetF.FontSize = PIGSlider(Tab2_F.SetF,{"LEFT",Tab2_F.SetF.Showshuzhi,"LEFT",210,0},{10,26,1})
				Tab2_F.SetF.FontSize.T = PIGFontString(Tab2_F.SetF.FontSize,{"RIGHT",Tab2_F.SetF.FontSize,"LEFT",-10,0},"字体大小")
				function Tab2_F.SetF.FontSize:PIGOnValueChange(arg1)
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]["FontSize"]=arg1;
					PIG_HPMPBarUI.Set_BarFontAll()
				end

				Tab2_F.SetF.HpShow =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.Showshuzhi,"TOPLEFT",0,-40},{"显示血量条","个人资源条显示血量"})
				Tab2_F.SetF.HpShow:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["HpShow"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["HpShow"]=false;
					end
					PIG_OptionsUI.RLUI:Show()
				end);
				Tab2_F.SetF.MpShow =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.HpShow,"TOPLEFT",0,-40},{"显示资源条","个人资源条显示资源"})
				Tab2_F.SetF.MpShow:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["HPMPBar"]["MpShow"]=true;
					else
						PIGA["CombatPlus"]["HPMPBar"]["MpShow"]=false;
					end
					PIG_OptionsUI.RLUI:Show()
				end);
				if classOK[classId] then
					Tab2_F.SetF.Fuziyuan =PIGCheckbutton(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.MpShow,"TOPLEFT",0,-40},{"显示特殊资源条","个人资源条显示特殊资源(连击点/符文/其他)"})
					Tab2_F.SetF.Fuziyuan:SetScript("OnClick", function (self)
						if self:GetChecked() then
							PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]=true;
						else
							PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]=false;
						end
						PIG_OptionsUI.RLUI:Show()
					end);
					if PIGA["CombatPlus"]["HPMPBar"]["Fuziyuan"]  then
						Tab2_F.SetF.Fuziyuan.style=PIGDownMenu(Tab2_F.SetF.Fuziyuan,{"LEFT",Tab2_F.SetF.Fuziyuan.Text,"RIGHT",2,0},{80,24})
						function Tab2_F.SetF.Fuziyuan.style:PIGDownMenu_Update_But()
							local info = {}
							info.func = self.PIGDownMenu_SetValue
							for i=1,classOK[classId],1 do
							    info.text, info.arg1 = TEXTURES_SUBHEADER..i, i
							   	info.checked = i==GetFuStyleV(classId)
								self:PIGDownMenu_AddButton(info)
							end
						end
						function Tab2_F.SetF.Fuziyuan.style:PIGDownMenu_SetValue(value,arg1,arg2)
							if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
							self:PIGDownMenu_SetText(value)
							PIG_HPMPBarUI.FuStyle = GetFuStyleV(classId,arg1)
							PIG_HPMPBarUI.Set_StatusBarTex()
							PIG_HPMPBarUI.Set_StatusBarWH()
							PIGCloseDropDownMenus()
						end
					end
				end
				Tab2_F.SetF.CZBUT = PIGButton(Tab2_F.SetF,{"BOTTOMRIGHT",Tab2_F.SetF,"TOPRIGHT",-20,10},{60,22},RESET)
				Tab2_F.SetF.CZBUT:SetScript("OnClick", function ()
					if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
					PIGA["CombatPlus"]["HPMPBar"]=CopyTable(PD.Default["CombatPlus"]["HPMPBar"])
					PIGA["CombatPlus"]["HPMPBar"]["Open"]=true;
					Set_WHXY()
					PIG_HPMPBarUI.Set_StatusBarWH()
					PIG_HPMPBarUI.Showshuzhi=PIGA["CombatPlus"]["HPMPBar"]["Showshuzhi"]
					PIG_HPMPBarUI.Set_BarFontAll()
					Tab2_F.SetF:UpdateSetF()
				end)
				function Tab2_F.SetF:UpdateSetF()
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
			end
			Tab2_F.SetF:UpdateSetF()
			Tab2_F.SetF:SetShown(PIGA["CombatPlus"]["HPMPBar"]["Open"])
		end
	end
end