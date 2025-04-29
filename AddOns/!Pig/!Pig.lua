----<本插件初始为猪猪加油定制插件,现已公开分享>---562314----
local addonName, addonTable = ...;
local L=addonTable.locale
SLASH_RELOAD1 = '/rl'
SlashCmdList["RELOAD"] = ReloadUI
SLASH_PIG1 = "/pig"
SLASH_PIG2 = "/pig"
SLASH_PIG3 = "/PIG"
SlashCmdList["PIG"] = function()
	Pig_OptionsUI:Show();
end
addonTable.ShareDB={}
_G.PIG = {addonTable.Create,addonTable.Data,addonTable.Fun,L,addonTable.Default,addonTable.Default_Per,addonTable.ShareDB}
--===============================
local PIGUI = CreateFrame("Frame")        
PIGUI:RegisterEvent("ADDON_LOADED")
PIGUI:RegisterEvent("PLAYER_LOGIN");
PIGUI:SetScript("OnEvent",function(self, event, arg1)
	if event=="ADDON_LOADED" and arg1 == addonName then
		self:UnregisterEvent("ADDON_LOADED")
		addonTable.Load_Config()
		Pig_OptionsUI:SetVer()
	end
	if event=="PLAYER_LOGIN" then
		addonTable.ShareConfig()
		addonTable.Get_PlayerRealmData()
		PigMinimapBut_UI:ButPoint()
		PigMinimapBut_UI.MinimapBut()
		addonTable.CVars()
		---
		addonTable.Map()
		addonTable.CombatPlus()
		addonTable.Common()
		addonTable.ActionBar()
		addonTable.TooltipPlus()
		addonTable.FramePlus()
		addonTable.UnitFrame()
		addonTable.Business()
		addonTable.BagBank()
		addonTable.Chat()
		addonTable.PigLayout()
		--
		QuickButUI:Add()
		addonTable.Create.PigUISetPoint()
		PigMinimapBut_UI.SN_MiniMapBut()
		------------------------------
		if not PIGA["Other"]["PigLoad"] then
			PIG_print(L["ABOUT_LOAD"]..L["ABOUT_REMINDER"])
		end
    end  
end)