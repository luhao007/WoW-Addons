local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create=addonTable.Create
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
---
local CommonInfo={}
addonTable.CommonInfo=CommonInfo
---
local Llist,LlistTabBut = PIGOptionsList(GENERAL,"TOP")
Llist:Show()
LlistTabBut:Selected(true)
local NR =Create.PIGOptionsList_RF(Llist)
CommonInfo.Llist=Llist
CommonInfo.LlistTabBut=LlistTabBut
CommonInfo.NR=NR
--==================================
addonTable.Common=function()
	CommonInfo.Common_ErrorsHide()
	CommonInfo.Common_Pig_AFK()
	CommonInfo.Common_Updata_addonProfilerEnabled()
	CommonInfo.Interaction_AutoDialogue()
	CommonInfo.Interaction_AutoDown()
	CommonInfo.Interaction_YaoqingFuhuo()
	CommonInfo.Interaction_RightPlus()
end