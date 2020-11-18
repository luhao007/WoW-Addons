local eventFrame = CreateFrame("Frame")
local function ADDON_LOADED(_, _, addonName)
	if (addonName == "TomCats") then
		eventFrame:UnregisterEvent("ADDON_LOADED")
		C_Timer.NewTimer(5, function()
			ChatFrame1:AddMessage("|TInterface/AddOns/TomCats/images/00013.blp:16:32:0:2:64:64:0:64:0:32|t|cff00ff00 A Message from TomCat's Tours:|r")
			ChatFrame1:AddMessage("|TInterface/AddOns/TomCats/images/00013.blp:16:32:0:2:64:64:0:64:32:64|t|cffffff00 Curseforge will be completing their transition to Overwolf from Nov. 24th through early December. You may be unable to download updated versions of TomCat's Tours from them during the transition.  If you require support or updates, further information will be made available at TomCatsTours.com and when live at twitch.tv/TomCat|r")
		end)
	end
end
eventFrame:SetScript("OnEvent", ADDON_LOADED)
eventFrame:RegisterEvent("ADDON_LOADED")
