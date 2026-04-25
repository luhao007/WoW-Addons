local addonName, addonTable = ...;
local L=addonTable.locale
local Create=addonTable.Create
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
------
local BusinessInfo = {}
addonTable.BusinessInfo=BusinessInfo
------------
local fuFrame,fuFrameBut = PIGOptionsList(L["TRADE_TABNAME"],"TOP")
BusinessInfo.fuFrame,BusinessInfo.fuFrameBut=fuFrame,fuFrameBut
BusinessInfo.RTabFrame =Create.PIGOptionsList_RF(fuFrame)

--==========================
addonTable.Business=function()
	BusinessInfo.AHPlusOptions()
	BusinessInfo.MailPlusOptions()
	BusinessInfo.AutoSellBuyOptions() 
	BusinessInfo.StatsInfoOptions()
end