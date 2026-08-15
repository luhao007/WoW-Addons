local _, PD = ...;
local addonName, PD = ...;
local L=PD.locale
---
local Create=PD.Create
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
---
local PigLayoutFun={}
PD.PigLayoutFun=PigLayoutFun
PigLayoutFun.xyList = {"TOP","BOTTOM","TOPLEFT","TOPRIGHT","BOTTOMLEFT","BOTTOMRIGHT"}
PigLayoutFun.xyListName = {["TOP"]="顶部",["BOTTOM"]="底部",["TOPLEFT"]="左上角",["TOPRIGHT"]="右上角",["BOTTOMLEFT"]="左下角",["BOTTOMRIGHT"]="右下角"}
--=====================
PD.PigLayout = function()
	PigLayoutFun.TopBarFun()
	PigLayoutFun.ToolBarFun()
	PigLayoutFun.InfoBarFun()
	-- PigLayoutFun.ActionBarFun(PIG_MaxTocversion(20000))
	-- PigLayoutFun.ChatFrameFun(PIG_MaxTocversion(20000))
end
----
function PD.addOptions_PigLayout()
	local fuFrame,fuFrameBut = PIGOptionsList(BUG_CATEGORY5..L["LIB_LAYOUT"],"TOP")
	PigLayoutFun.fuFrame=fuFrame
	PigLayoutFun.fuFrameBut=fuFrameBut
	--
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	PigLayoutFun.RTabFrame=RTabFrame
	PigLayoutFun.addOptions_General()
	PigLayoutFun.addOptions_ToolBar()
	PigLayoutFun.addOptions_InfoBar()
	PigLayoutFun.addOptions_ActionBar(PIG_MaxTocversion())
	PigLayoutFun.addOptions_ChatFrame(PIG_MaxTocversion())
	PigLayoutFun.addOptions_TopBar()
end