local addonName, PD = ...;
local L=PD.locale
---
local Create=PD.Create
local PIGFrame = Create.PIGFrame
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
--
local TooltipPlusfun={}
PD.TooltipPlusfun=TooltipPlusfun
--======
local CombatHide_Open
local function SetCombatHide()
	if PIGA["Tooltip"]["CombatHide"] then
		if CombatHide_Open then return end
		CombatHide_Open=true
		GameTooltip:HookScript("OnShow", function(self)
		    if InCombatLockdown() then
		        self:Hide()
		    end
		end)
		local combatFrame = CreateFrame("Frame")
		combatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		combatFrame:SetScript("OnEvent", function()
		    GameTooltip:Hide()
		end)
	end
end
PD.TooltipPlus = function()
	TooltipPlusfun.InfoPlus()
	TooltipPlusfun.Point()
	TooltipPlusfun.CompareItemPlus()
	SetCombatHide()
end
function PD.addOptions_Tooltip()
	local fuFrame = PIGOptionsList(L["TOOLTIP_TABNAME"],"TOP")
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	--
	local TooltipF,Tooltiptabbut =PIGOptionsList_R(RTabFrame,L["TOOLTIP_TABNAME1"],90)
	TooltipF:Show()
	Tooltiptabbut:Selected(true)
	TooltipF:SetScript("OnShow", function (self)
		if TooltipF.ItemMaxCount then return end
		TooltipF.ItemMaxCount = PIGCheckbutton_R(TooltipF,{"显示物品最大堆叠数","在鼠标提示上显示物品最大堆叠数"},true)
		TooltipF.ItemMaxCount:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tooltip"]["ItemMaxCount"]=true;			
			else
				PIGA["Tooltip"]["ItemMaxCount"]=false;
			end
		end);
		TooltipF.IDinfo = PIGCheckbutton_R(TooltipF,{"显示物品/技能ID","在鼠标提示上显示物品/技能ID,版本归属/BUFF来源"},true)
		TooltipF.IDinfo:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tooltip"]["IDinfo"]=true;			
			else
				PIGA["Tooltip"]["IDinfo"]=false;
			end
		end);
		TooltipF.ItemSell = PIGCheckbutton_R(TooltipF,{"显示物品售价","在鼠标提示上显示物品售价"},true)
		TooltipF.ItemSell:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tooltip"]["ItemSell"]=true;			
			else
				PIGA["Tooltip"]["ItemSell"]=false;
			end
		end);
		TooltipF.CompareItemPlus = PIGCheckbutton_R(TooltipF,{"优化物品鼠标提示","物品鼠标提示界面增加物品图片。增强比较物品界面，使其更清晰"},true)
		TooltipF.CompareItemPlus:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tooltip"]["CompareItemPlus"]=true;
			else
				PIGA["Tooltip"]["CompareItemPlus"]=false
			end
			PIG_OptionsUI.RLUI:Show()
		end)
		if PIG_MaxTocversion(50000) then
			local ItemLeveltishi = {"显示物品等级","在鼠标提示上显示物品的物品等级"}
			TooltipF.ItemLevel = PIGCheckbutton_R(TooltipF,ItemLeveltishi,true)
			TooltipF.ItemLevel:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["Tooltip"]["ItemLevel"]=true;			
				else
					PIGA["Tooltip"]["ItemLevel"]=false;
				end
			end);
		end
		TooltipF.ItemMaxCount:SetChecked(PIGA["Tooltip"]["ItemMaxCount"])
		TooltipF.IDinfo:SetChecked(PIGA["Tooltip"]["IDinfo"])
		TooltipF.ItemSell:SetChecked(PIGA["Tooltip"]["ItemSell"])
		if TooltipF.ItemLevel then TooltipF.ItemLevel:SetChecked(PIGA["Tooltip"]["ItemLevel"]) end
		if TooltipF.CompareItemPlus then TooltipF.CompareItemPlus:SetChecked(PIGA["Tooltip"]["CompareItemPlus"]) end
	end);
	---位置
	local PointF=PIGOptionsList_R(RTabFrame,L["LIB_POINT"],90)
	PointF:SetScript("OnShow", function (self)
		if PointF.CombatHide then return end
		PointF.CombatHide = PIGCheckbutton(PointF,{"TOPLEFT",PointF,"TOPLEFT",20,-20},{"战斗中隐藏","战斗中隐藏鼠标提示"})
		PointF.CombatHide:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tooltip"]["CombatHide"]=true;
				SetCombatHide()	
			else
				PIGA["Tooltip"]["CombatHide"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		PointF.CombatHide:SetChecked(PIGA["Tooltip"]["CombatHide"])

		PointF.PointOpen = PIGCheckbutton(PointF,{"TOPLEFT",PointF,"TOPLEFT",20,-100},{"移动位置","启用移动鼠标提示位置"})
		PointF.PointOpen:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tooltip"]["PointOpen"]=true;			
			else
				PIGA["Tooltip"]["PointOpen"]=false;
			end
			TooltipPlusfun.UpdatePointConfig()
			PointF.SetF.UpdateSetUI()			
		end);
		PointF.PointOpen:SetChecked(PIGA["Tooltip"]["PointOpen"])
		--
		PointF.SetF = PIGFrame(PointF,{"TOPLEFT", PointF, "TOPLEFT", 0, -130})
		PointF.SetF:SetPoint("BOTTOMRIGHT", PointF, "BOTTOMRIGHT", 0, 0);
		PointF.SetF:PIGSetBackdrop(0)

		PointF.SetF.CZBUT = PIGButton(PointF.SetF,{"BOTTOMRIGHT",PointF.SetF,"TOPRIGHT",-20,10},{60,24},RESET)
		PointF.SetF.CZBUT:SetScript("OnClick", function ()
			PIGA["Tooltip"]["Point"]=PD.Default["Tooltip"]["Point"]
			PIGA["Tooltip"]["PointX"]=PD.Default["Tooltip"]["PointX"]
			PIGA["Tooltip"]["PointY"]=PD.Default["Tooltip"]["PointY"]
			TooltipPlusfun.UpdatePointConfig()
			PointF.SetF.UpdateSetUI()
		end)
		--
		local miaodianList = {[1]="右下角",[2]="左下角",[3]="左上角",[4]="右上角",[5]="鼠标(偏移无效)",[6]="鼠标左",[7]="鼠标右"}
		PointF.SetF.miaodianT = PIGFontString(PointF.SetF,{"TOPLEFT", PointF.SetF, "TOPLEFT", 20, -20},"锚点");
		PointF.SetF.miaodian=PIGDownMenu(PointF.SetF,{"LEFT",PointF.SetF.miaodianT,"RIGHT",0,0},{140,nil})
		function PointF.SetF.miaodian:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,7,1 do
			    info.text, info.arg1 = miaodianList[i], i
			    info.checked = i==PIGA["Tooltip"]["Point"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function PointF.SetF.miaodian:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["Tooltip"]["Point"]=arg1
			TooltipPlusfun.UpdatePointConfig()
			PIGCloseDropDownMenus()
		end
		PointF.SetF.pianyiX = PIGSlider(PointF.SetF,{"TOPLEFT",PointF.SetF.miaodianT,"BOTTOMLEFT",0,-30},{-1000,1000,1,{["Right"]="X偏移%d"}},400)
		function PointF.SetF.pianyiX:PIGOnValueChange(arg1)
			PIGA["Tooltip"]["PointX"]=arg1;
			TooltipPlusfun.UpdatePointConfig()
		end
		PointF.SetF.pianyiY = PIGSlider(PointF.SetF,{"TOPLEFT",PointF.SetF.pianyiX,"BOTTOMLEFT",0,-10},{-1000,1000,1,{["Right"]="Y偏移%d"}},400)
		function PointF.SetF.pianyiY:PIGOnValueChange(arg1)
			PIGA["Tooltip"]["PointY"]=arg1
			TooltipPlusfun.UpdatePointConfig()
		end
		function PointF.SetF.UpdateSetUI()
			PointF.SetF:SetShown(PIGA["Tooltip"]["PointOpen"])
			PointF.SetF.miaodian:PIGDownMenu_SetText(miaodianList[PIGA["Tooltip"]["Point"]])
			PointF.SetF.pianyiX:PIGSetValue(PIGA["Tooltip"]["PointX"])
			PointF.SetF.pianyiY:PIGSetValue(PIGA["Tooltip"]["PointY"])
		end
		PointF.SetF.UpdateSetUI()
	end);
end