local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create=addonTable.Create
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
addonTable.TooltipPlusfun=TooltipPlusfun
---
local fuFrame = PIGOptionsList(L["TOOLTIP_TABNAME"],"TOP")
local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
--
local TooltipF,Tooltiptabbut =PIGOptionsList_R(RTabFrame,L["TOOLTIP_TABNAME1"],90)
TooltipF:Show()
Tooltiptabbut:Selected(true)
---
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
	TooltipPlusfun.Tooltip_ItemSell()
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
TooltipF:HookScript("OnShow", function(self)
	self.ItemMaxCount:SetChecked(PIGA["Tooltip"]["ItemMaxCount"])
	self.IDinfo:SetChecked(PIGA["Tooltip"]["IDinfo"])
	self.ItemSell:SetChecked(PIGA["Tooltip"]["ItemSell"])
	if self.ItemLevel then self.ItemLevel:SetChecked(PIGA["Tooltip"]["ItemLevel"]) end
	if self.CompareItemPlus then self.CompareItemPlus:SetChecked(PIGA["Tooltip"]["CompareItemPlus"]) end
end)
--------------
local PointF=PIGOptionsList_R(RTabFrame,L["LIB_POINT"],90)
PointF.PointOpen = PIGCheckbutton(PointF,{"TOPLEFT",PointF,"TOPLEFT",20,-20},{"移动位置","启用移动鼠标提示位置"})
PointF.PointOpen:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Tooltip"]["PointOpen"]=true;			
	else
		PIGA["Tooltip"]["PointOpen"]=false;
	end
	TooltipPlusfun.SetCheckbuttonShow()
	TooltipPlusfun.SetPointCF()
end);
local miaodianList = {[1]="右下角",[2]="左下角",[3]="左上角",[4]="右上角",[5]="鼠标(偏移无效)",[6]="鼠标左",[7]="鼠标右"}
PointF.miaodian=PIGDownMenu(PointF,{"LEFT",PointF.PointOpen.Text,"RIGHT",70,0},{140,nil})
PointF.miaodian.t = PIGFontString(PointF.miaodian,{"RIGHT",PointF.miaodian,"LEFT",-4,0},"锚点");
function PointF.miaodian:PIGDownMenu_Update_But()
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,7,1 do
	    info.text, info.arg1 = miaodianList[i], i
	    info.checked = i==PIGA["Tooltip"]["Point"]
		self:PIGDownMenu_AddButton(info)
	end 
end
function PointF.miaodian:PIGDownMenu_SetValue(value,arg1,arg2)
	self:PIGDownMenu_SetText(value)
	PIGA["Tooltip"]["Point"]=arg1
	TooltipPlusfun.SetPointCF()
	PIGCloseDropDownMenus()
end
PointF.CZBUT = PIGButton(PointF,{"LEFT",PointF.miaodian,"RIGHT",100,0},{80,24},"重置位置")
PointF.CZBUT:SetScript("OnClick", function ()
	TooltipPlusfun.SetPointCF(true)
	PointF.miaodian:PIGDownMenu_SetText(miaodianList[PIGA["Tooltip"]["Point"]])
	PointF.pianyiX:PIGSetValue(PIGA["Tooltip"]["PointX"])
	PointF.pianyiY:PIGSetValue(PIGA["Tooltip"]["PointY"])
end)
--
local xiayiinfoX = {-1000,1000,1}
PointF.pianyiXbiaoti = PIGFontString(PointF,{"TOPLEFT",PointF,"TOPLEFT",24,-80},"X偏移")
PointF.pianyiX = PIGSlider(PointF,{"LEFT",PointF.pianyiXbiaoti,"RIGHT",4,0},xiayiinfoX)
function PointF.pianyiX:PIGOnValueChange(arg1)
	PIGA["Tooltip"]["PointX"]=arg1;
	TooltipPlusfun.SetPointCF()
end
local xiayiinfoY = {-1000,1000,1}
PointF.pianyiYbiaoti = PIGFontString(PointF,{"LEFT",PointF.pianyiX,"RIGHT",100,0},"Y偏移")
PointF.pianyiY = PIGSlider(PointF,{"LEFT",PointF.pianyiYbiaoti,"RIGHT",4,0},xiayiinfoY)
function PointF.pianyiY:PIGOnValueChange(arg1)
	PIGA["Tooltip"]["PointY"]=arg1
	TooltipPlusfun.SetPointCF()
end
PointF.CombatHide = PIGCheckbutton(PointF,{"TOPLEFT",PointF,"TOPLEFT",20,-160},{"战斗中隐藏","战斗中隐藏鼠标提示"})
PointF.CombatHide:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Tooltip"]["CombatHide"]=true;
		SetCombatHide()	
	else
		PIGA["Tooltip"]["CombatHide"]=false;
		PIG_OptionsUI.RLUI:Show()
	end
end);
function SetCombatHide()
	if PIGA["Tooltip"]["CombatHide"] then
		if PointF.CombatHide.Open then return end
		PointF.CombatHide.Open=true
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
function TooltipPlusfun.SetCheckbuttonShow()
	PointF.miaodian:SetEnabled(PIGA["Tooltip"]["PointOpen"])
	PointF.pianyiX:SetEnabled(PIGA["Tooltip"]["PointOpen"]);
	PointF.pianyiY:SetEnabled(PIGA["Tooltip"]["PointOpen"]);
	PointF.CZBUT:SetEnabled(PIGA["Tooltip"]["PointOpen"]);
end
PointF:HookScript("OnShow", function(self)
	TooltipPlusfun.SetCheckbuttonShow()
	self.PointOpen:SetChecked(PIGA["Tooltip"]["PointOpen"])
	self.miaodian:PIGDownMenu_SetText(miaodianList[PIGA["Tooltip"]["Point"]])
	self.pianyiX:PIGSetValue(PIGA["Tooltip"]["PointX"])
	self.pianyiY:PIGSetValue(PIGA["Tooltip"]["PointY"])
	self.CombatHide:SetChecked(PIGA["Tooltip"]["CombatHide"])
end)
--===============================
addonTable.TooltipPlus = function()
	TooltipPlusfun.InfoPlus()
	TooltipPlusfun.Point()
	TooltipPlusfun.CompareItemPlus()
	SetCombatHide()
end