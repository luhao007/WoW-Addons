local _, addonTable = ...;
local addonName, addonTable = ...;
local L=addonTable.locale
local _, _, _, tocversion = GetBuildInfo()
---
local Create=addonTable.Create
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
---
local PigLayoutFun={}
addonTable.PigLayoutFun=PigLayoutFun
local fuFrame,fuFrameBut = PIGOptionsList(BUG_CATEGORY5..L["LIB_LAYOUT"],"TOP")
PigLayoutFun.fuFrame=fuFrame
PigLayoutFun.fuFrameBut=fuFrameBut
--
local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
PigLayoutFun.RTabFrame=RTabFrame
--=====================
addonTable.PigLayout = function()
	local Vtocversion=50000
	PigLayoutFun.Options_Mode()
	PigLayoutFun.Options_TopBar()
	PigLayoutFun.Options_InfoBar()
	PigLayoutFun.Options_ActionBar(tocversion<Vtocversion)
	PigLayoutFun.Options_ChatUI(tocversion<Vtocversion)
end