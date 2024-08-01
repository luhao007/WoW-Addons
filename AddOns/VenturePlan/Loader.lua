local AN, T, EV, U = ...
EV, U, _G[AN] = T.Evie, T.Util

local mapOpened, addonLoaded
function EV:ADVENTURE_MAP_OPEN(followerID)
	if mapOpened and addonLoaded then
		return "remove"
	end
	mapOpened = followerID == 123
	if mapOpened and C_AddOns.IsAddOnLoaded("Blizzard_GarrisonUI") then
		addonLoaded = true
		EV("I_ADVENTURES_UI_LOADED")
	end
end
function EV:ADDON_LOADED(aname)
	if aname == "Blizzard_GarrisonUI" and not addonLoaded then
		addonLoaded = true
		if mapOpened then
			EV("I_ADVENTURES_UI_LOADED")
		end
		return "remove"
	end
end
function EV:I_ADVENTURES_UI_LOADED()
	hooksecurefunc(CovenantMissionFrame.FollowerTab, "ShowFollower", function(self)
		if self and self.StatsFrame then
			self.StatsFrame:Layout()
		end
	end)
end

SLASH_VENTUREPLAN1, SLASH_VENTUREPLAN2 = "/ventureplan", "/vp"
function SlashCmdList.VENTUREPLAN(msg)
	local v, at, a = msg:match("^%s*(%S+)%s*(.-)$")
	if v == "set-campaign-progress" then
		a = tonumber(at)
		if a and a >= 0 and a <= 20 or at == "nil" then
			U.SetCurrencyValueShiftTarget(1889, a)
		end
		local c = C_CurrencyInfo.GetCurrencyInfo(1889)
		c = U.GetShiftedCurrencyValue(1889, c and c.quantity) or "{0..20}"
		print("|cff20a0ff/ventureplan |r|cffffffffset-campaign-progress|r |cff20ff20" .. c .. "|r|cffa0a0a0|||r|cff20ff20nil")
		return
	end
	print("|cff20a0ffVenture Plan |r|cffffffff" .. C_AddOns.GetAddOnMetadata("VenturePlan", "Version"))
end

-- Disable an outdated and incompatible extension
pcall(C_AddOns.DisableAddOn, "VenturePlanSoDMissions", true)