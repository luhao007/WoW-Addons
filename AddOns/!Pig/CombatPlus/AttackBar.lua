local _, PD = ...;
local L=PD.locale
local match = _G.string.match
local floor=floor
local Fun=PD.Fun
--
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton = Create.PIGButton
local PIGSlider = Create.PIGSlider
local PIGFontString=Create.PIGFontString
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList_R=Create.PIGOptionsList_R
----
local CombatPlusfun=PD.CombatPlusfun
---------------------------------
local IsCurrentSpell = IsCurrentSpell or C_Spell and C_Spell.IsCurrentSpell
local IsAutoRepeatSpell = IsAutoRepeatSpell or C_Spell and C_Spell.IsAutoRepeatSpell
function CombatPlusfun.AttackBar(open)
	if PIG_MaxTocversion(nil,true) then return end
	if not PIGA["CombatPlus"]["AttackBar"]["Open"] then return end
	if CombatPlusfun.AttackBarUI then return end
	local Template="CastingBarFrameTemplate"
	-- if PlayerCastingBarFrame then
	-- 	Template="CastingBarFrameTemplate, UIParentBottomManagedFrameTemplate, EditModeCastBarSystemTemplate"
	-- end
	local AttackBar = CreateFrame("StatusBar", nil, UIParent, Template)
	CombatPlusfun.AttackBarUI=AttackBar
	AttackBar:SetFrameStrata("HIGH")
	AttackBar:SetSize(195,13);
	AttackBar:SetToplevel(true);
	AttackBar.Icon:Hide();
	AttackBar.Flash:Hide();
	AttackBar:Hide()
	AttackBar.zhu=true
	AttackBar.unit = "player";
	AttackBar.Showshuzhi=PIGA["CombatPlus"]["AttackBar"]["Showshuzhi"]
	AttackBar.Showfubar=PIGA["CombatPlus"]["AttackBar"]["fubar"]
	AttackBar:SetScript("OnShow", nil)
	AttackBar.fubar = CreateFrame("StatusBar", nil, AttackBar, "CastingBarFrameTemplate")
	AttackBar.fubar:SetSize(195,13);
	AttackBar.fubar:SetPoint("BOTTOM",AttackBar,"TOP",0,14);
	AttackBar.fubar.Icon:Hide();
	AttackBar.fubar.Flash:Hide();
	AttackBar.fubar:Hide()
	AttackBar.fubar:SetScript("OnShow", nil)
	AttackBar.fubar.zhu=false
	AttackBar.fubar.SLOTname = PIGFontString(AttackBar.fubar,{"LEFT", AttackBar.fubar, "LEFT", 6, 2},SECONDARYHANDSLOT,"OUTLINE",12)
	local function GetSpeed(self)
		if IsCurrentSpell(6603) then
			return self.maxValue
		elseif IsAutoRepeatSpell(75) or IsAutoRepeatSpell(5019) then
			return self.maxValueranged
		end
		return 0
	end
	local function GetAttackSpeedTime(self,JIXU)
		self.NewmaxValue=GetSpeed(self)
		self.old_maxValue=self.NewmaxValue
		self:SetMinMaxValues(0, self.NewmaxValue or 3);
		if not JIXU then
			self:SetValue(0);
			self.value = 0
		end
	end
	local function AttackBar_OnUpdate(self, elapsed)
		if AttackBar.ceshi then return end
		if self.NewmaxValue==0 then self:Hide() return end
		if GetSpeed(self)~=self.old_maxValue then GetAttackSpeedTime(self,true) end
		self.value = self.value + elapsed;
		if ( self.value > self.NewmaxValue ) then
			self:SetValue(self.NewmaxValue);
			return;
		end
		if AttackBar.Showshuzhi then
			if self.zhu then
				self.Text:SetText((floor(self.value*10+0.5)*0.1).."/"..floor(self.NewmaxValue*10+0.5)*0.1);
			else
				self.Text:SetText((floor(self.value*10+0.5)*0.1).."/"..floor(self.NewmaxValue*10+0.5)*0.1);
			end
		else
			self.Text:SetText("");
		end
		self:SetValue(self.value);
		if ( self.Spark ) then
			local sparkPosition = (self.value / self.NewmaxValue) * self:GetWidth();
			self.Spark:SetPoint("CENTER", self, "LEFT", sparkPosition, self.Spark.offsetY or 2);
		end
	end
	function AttackBar:jiazaichushiV()
		local mainSpeed, offSpeed = UnitAttackSpeed(self.unit)
		local rangedAttackSpeed = UnitRangedDamage(self.unit);
		self.maxValue = mainSpeed
		self.maxValueranged = rangedAttackSpeed
		if offSpeed then
			self.fubar.maxValue = offSpeed
		else
			self.fubar.maxValue = 0
			self.fubar:Hide()
		end
	end
	function AttackBar:SetScaleXY(LY)
		if AttackBar then
			if not LY then
				if not AttackBar:IsShown() then
					AttackBar.ceshi=true
					AttackBar:Show()
					C_Timer.After(2,function()
						AttackBar:Hide()
						AttackBar.ceshi=nil
					end)
				end
			end
			AttackBar:SetScale(PIGA["CombatPlus"]["AttackBar"]["Scale"])
			if PlayerCastingBarFrame then
				AttackBar:SetPoint("BOTTOM", UIParent, "TOP", PIGA["CombatPlus"]["AttackBar"]["Xpianyi"], PIGA["CombatPlus"]["AttackBar"]["Ypianyi"]-666);
			else
				AttackBar:SetPoint("BOTTOM", CastingBarFrame, "TOP", PIGA["CombatPlus"]["AttackBar"]["Xpianyi"], PIGA["CombatPlus"]["AttackBar"]["Ypianyi"]);
			end
		end
	end
	AttackBar:SetScaleXY(true)
	if open then AttackBar:jiazaichushiV() end
	AttackBar:SetScript("OnUpdate", AttackBar_OnUpdate)
	AttackBar.fubar:SetScript("OnUpdate", AttackBar_OnUpdate)

	local playerGUID = UnitGUID("player")
	AttackBar:RegisterEvent("PLAYER_ENTERING_WORLD");
	AttackBar:RegisterEvent("PLAYER_REGEN_ENABLED")
	AttackBar:RegisterUnitEvent("UNIT_ATTACK_SPEED","player");--当您的攻击速度受到影响时触发
	--AttackBar:RegisterUnitEvent("PLAYER_TARGET_SET_ATTACKING","target");
	Fun.EventCOMBAT_LOG(AttackBar,true)
	AttackBar:SetScript("OnEvent", function (self,event,arg1,arg2)
		--print(event)
		if event=="PLAYER_ENTERING_WORLD" or event=="UNIT_ATTACK_SPEED" then
			self:jiazaichushiV()
			if event=="UNIT_ATTACK_SPEED" then
				GetAttackSpeedTime(self)
				GetAttackSpeedTime(self.fubar)
			end
		elseif event=="PLAYER_REGEN_ENABLED" then
			self:Hide()
		elseif event=="COMBAT_LOG_EVENT_UNFILTERED" then
			local _,subEvent,_,sourceGUID,_,_,_,_,_,_,_,spellID,spellX,_,_,_,_,_,_,_,isOffHand= CombatLogGetCurrentEventInfo()
			if sourceGUID ~= playerGUID then return end
			--print(CombatLogGetCurrentEventInfo())
			if subEvent=="SPELL_CAST_SUCCESS" then
				if spellID==75 or spellID==5019 then
					GetAttackSpeedTime(self)
					self:Show()
				end
			elseif subEvent:match("SWING") then
				local OffHand = isOffHand
				if OffHand==nil then
					OffHand=spellX
				end
				if OffHand then
					if self.Showfubar then  
						GetAttackSpeedTime(self.fubar)
						self.fubar:Show()
					end
				else
					GetAttackSpeedTime(self)
					self:Show()
				end
			end
		end
	end)
end
--------------------------
function CombatPlusfun.addOptions_AttackBar()
	if PIG_MaxTocversion() then
				local function OpSetSetScaleXY(LY)
			if CombatPlusfun.AttackBarUI then
				CombatPlusfun.AttackBarUI:SetScaleXY(LY)
			end
		end
		local Tab2_F,CombatPlustabbut =PIGOptionsList_R(CombatPlusfun.RTabFrame,"普攻进度条",100)
		Tab2_F.Open = PIGCheckbutton_R(Tab2_F,{"启用普攻进度条","在屏幕上显示普攻进度条"})
		Tab2_F.Open:SetChecked(PIGA["CombatPlus"]["AttackBar"]["Open"]);
		Tab2_F.Open:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["CombatPlus"]["AttackBar"]["Open"]=true;
				CombatPlusfun.AttackBar(true)
			else
				PIGA["CombatPlus"]["AttackBar"]["Open"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			Tab2_F.SetF:SetShown(PIGA["CombatPlus"]["AttackBar"]["Open"])
		end)
		Tab2_F:HookScript("OnShow", function (self)
			if not Tab2_F.SetF then
				Tab2_F.SetF = PIGFrame(Tab2_F,{"TOPLEFT", Tab2_F, "TOPLEFT", 0, -50})
				Tab2_F.SetF:SetPoint("BOTTOMRIGHT",Tab2_F,"BOTTOMRIGHT",0,0);
				Tab2_F.SetF:PIGSetBackdrop(0)
				Tab2_F.SetF.Showshuzhi =PIGCheckbutton_R(Tab2_F.SetF,{"显示数值","显示进度数值"})
				Tab2_F.SetF.Showshuzhi:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["AttackBar"]["Showshuzhi"]=true;
					else
						PIGA["CombatPlus"]["AttackBar"]["Showshuzhi"]=false;
					end
					if CombatPlusfun.AttackBarUI then
						CombatPlusfun.AttackBarUI.Showshuzhi=PIGA["CombatPlus"]["AttackBar"]["Showshuzhi"]
					end
				end);
				Tab2_F.SetF.fubar = PIGCheckbutton_R(Tab2_F.SetF,{"启用副手"})
				Tab2_F.SetF.fubar:SetChecked(PIGA["CombatPlus"]["AttackBar"]["fubar"]);
				Tab2_F.SetF.fubar:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["CombatPlus"]["AttackBar"]["fubar"]=true;
					else
						PIGA["CombatPlus"]["AttackBar"]["fubar"]=false;
					end
					if CombatPlusfun.AttackBarUI then
						CombatPlusfun.AttackBarUI.fubar:Hide()
						CombatPlusfun.AttackBarUI.Showfubar=PIGA["CombatPlus"]["AttackBar"]["fubar"]
					end
				end)
				Tab2_F.SetF.CZBUT = PIGButton(Tab2_F.SetF,{"BOTTOMRIGHT",Tab2_F.SetF,"TOPRIGHT",-20,10},{60,22},RESET)
				Tab2_F.SetF.CZBUT:SetScript("OnClick", function ()
					PIGA["CombatPlus"]["AttackBar"]["Scale"]=PD.Default["CombatPlus"]["AttackBar"]["Scale"]
					PIGA["CombatPlus"]["AttackBar"]["Xpianyi"]=PD.Default["CombatPlus"]["AttackBar"]["Xpianyi"]
					PIGA["CombatPlus"]["AttackBar"]["Ypianyi"]=PD.Default["CombatPlus"]["AttackBar"]["Ypianyi"]
					OpSetSetScaleXY()
					Tab2_F.SetF:UpdateSetF()
				end)
				Tab2_F.SetF.Slider = PIGSlider(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF,"TOPLEFT",20,-60},{0.6,2,0.01,{["Right"]="缩放%d%%"}},220)
				function Tab2_F.SetF.Slider:PIGOnValueChange(arg1)
					PIGA["CombatPlus"]["AttackBar"]["Scale"]=arg1;
					OpSetSetScaleXY()
				end
				local WowWidth=floor(GetScreenWidth()*0.5);
				Tab2_F.SetF.SliderX = PIGSlider(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.Slider,"BOTTOMLEFT",0,-10},{-WowWidth,WowWidth,1,{["Right"]="X偏移%d"}},400)
				function Tab2_F.SetF.SliderX:PIGOnValueChange(arg1)
					PIGA["CombatPlus"]["AttackBar"]["Xpianyi"]=arg1;
					OpSetSetScaleXY()
				end
				Tab2_F.SetF.SliderY = PIGSlider(Tab2_F.SetF,{"TOPLEFT",Tab2_F.SetF.SliderX,"BOTTOMLEFT",0,-10},{-800,800,1,{["Right"]="Y偏移%d"}},400)
				function Tab2_F.SetF.SliderY:PIGOnValueChange(arg1)
					PIGA["CombatPlus"]["AttackBar"]["Ypianyi"]=arg1;
					OpSetSetScaleXY()
				end
				function Tab2_F.SetF:UpdateSetF()
					self.Showshuzhi:SetChecked(PIGA["CombatPlus"]["AttackBar"]["Showshuzhi"]);
					self.Slider:PIGSetValue(PIGA["CombatPlus"]["AttackBar"]["Scale"])
					self.SliderX:PIGSetValue(PIGA["CombatPlus"]["AttackBar"]["Xpianyi"])
					self.SliderY:PIGSetValue(PIGA["CombatPlus"]["AttackBar"]["Ypianyi"])
				end
				Tab2_F.SetF:HookScript("OnHide", function (self)
					if CombatPlusfun.AttackBarUI then
						if CombatPlusfun.AttackBarUI:IsShown() and CombatPlusfun.AttackBarUI.ceshi then
							CombatPlusfun.AttackBarUI:Hide()
							CombatPlusfun.AttackBarUI.ceshi=nil
						end
					end
				end);
			end
			Tab2_F.SetF:UpdateSetF()
		end);
	end
end