--[[
	Fix for the following:
	By default, the zone map (BattlefieldMapFrame) will only change the map when ZONE_CHANGED_NEW_AREA is fired.
	This causes the map to continually and incorrectly show an area that the player has already left, with no
	other way to refresh the zone map other than to close and reopen it.
]]
do
	local function OnEvent(_, _event)
		if (_event == "ZONE_CHANGED" or _event == "ZONE_CHANGED_INDOORS" or _event == "NEW_WMO_CHUNK") then
			if (BattlefieldMapFrame) then
				BattlefieldMapFrame:OnEvent("ZONE_CHANGED_NEW_AREA")
			end
			return
		end
	end

	local eventFrame = CreateFrame("Frame")
	eventFrame:SetScript("OnEvent", OnEvent)
	eventFrame:RegisterEvent("ZONE_CHANGED")
	eventFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
	eventFrame:RegisterEvent("NEW_WMO_CHUNK")
end
