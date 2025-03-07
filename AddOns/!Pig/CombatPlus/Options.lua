local addonName, addonTable = ...;
local L=addonTable.locale
local _, _, _, tocversion = GetBuildInfo()
---
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
---
local CombatPlusfun={}
addonTable.CombatPlusfun=CombatPlusfun

local fuFrame,fuFrameBut = PIGOptionsList(L["COMBAT_TABNAME"],"TOP")
CombatPlusfun.fuFrame=fuFrame
CombatPlusfun.fuFrameBut=fuFrameBut
--
local DownY=30
local RTabFrame =Create.PIGOptionsList_RF(fuFrame,DownY)
CombatPlusfun.RTabFrame=RTabFrame
--
--==================================
addonTable.CombatPlus = function()
	CombatPlusfun.Marker()
	CombatPlusfun.CombatTime()
	CombatPlusfun.HPMPBar()
	CombatPlusfun.AttackBar()
	CombatPlusfun.BabySitter()
end