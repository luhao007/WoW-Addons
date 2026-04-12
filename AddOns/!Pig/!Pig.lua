----<本插件初始为猪猪加油定制插件,现已公开分享>---562314----
local addonName, PD = ...;
local L=PD.locale
local Data=PD.Data
SLASH_RELOAD1 = '/rl'
SlashCmdList["RELOAD"] = ReloadUI
SLASH_PIG1 = "/pig"
SLASH_PIG2 = "/pig"
SLASH_PIG3 = "/PIG"
SlashCmdList["PIG"] = function()
	PIG_OptionsUI:Show();
end
PD.ShareDB={}
_G.PIG = {PD.Create,PD.Data,PD.Fun,L,PD.Default,PD.Default_Per,PD.Audio,PD.ShareDB}
--===============================
EventUtil.ContinueOnAddOnLoaded(addonName, function()
	PD.Load_Config()
	PIG_OptionsUI:SetVer_EXT(addonName)
end)
local PIGUI = CreateFrame("Frame")        
PIGUI:RegisterEvent("PLAYER_LOGIN");
PIGUI:SetScript("OnEvent",function(self, event, arg1)
	PD.ShareConfig()
	PD.Get_PlayerRealmData()
	PD.UpdateMiniButPoint()
	PD.CVars()
	--
	PD.Map()
	PD.CombatPlus()
	PD.Common()
	PD.ActionBar()
	PD.FramePlus()
	PD.UnitFrame()
	PD.Business()
	PD.TooltipPlus()
	PD.BagBank()
	PD.Chat()
	PD.PigLayout()
	--
	_G[Data.QuickButUIname]:Add()
	PD.CollectMiniMapBut()
	------------------------------
	if not PIGA["Other"]["PigLoad"] then
		PIGprint(L["ADDON_LOAD"])
	end  
end)