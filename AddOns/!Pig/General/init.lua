local _, PD = ...;
---
local GeneralFun={}
PD.GeneralFun=GeneralFun
PD.General=function()
	GeneralFun.Common_AFK()
	GeneralFun.Common_ErrorsHide()
	GeneralFun.Common_Updata_addonProfilerEnabled()
	GeneralFun.advancedCombatLog()
	GeneralFun.Interaction_AutoDialogue()
	GeneralFun.Interaction_AutoDown()
	GeneralFun.Interaction_YaoqingFuhuo()
	GeneralFun.Interaction_RightPlus()
	GeneralFun.BabySitter()
	if GeneralFun.Hardcore then GeneralFun.Hardcore() end
end