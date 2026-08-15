local addonName, PD = ...;
------
local BusinessInfo = {}
PD.BusinessInfo=BusinessInfo
function PD.Business()
	BusinessInfo.AHPlus_ADDUI()
	BusinessInfo.MailPlus_ADDUI()
	BusinessInfo.add_AutoSellBuyUI()
	BusinessInfo.StatsInfo_Fun()
end
function PD.addOptions_Business()
	local L=PD.locale
	local Create=PD.Create
	local PIGOptionsList=Create.PIGOptionsList
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	------------
	local fuFrame,fuFrameBut = PIGOptionsList(L["TRADE_TABNAME"],"TOP")
	BusinessInfo.fuFrame,BusinessInfo.fuFrameBut=fuFrame,fuFrameBut

	BusinessInfo.RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	BusinessInfo.AHPlusOptions()
	BusinessInfo.MailPlusOptions()
	BusinessInfo.AutoSellBuyOptions()
	BusinessInfo.StatsInfoOptions()
end