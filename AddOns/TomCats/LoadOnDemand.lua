local addonName, addon = ...
local CreateFrame = CreateFrame
local DisableAddOn= DisableAddOn
local GetAddOnInfo = GetAddOnInfo
local GetBestMapForUnit = C_Map.GetBestMapForUnit
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn
local NewTimer = C_Timer.NewTimer

do
	local eventFrame = CreateFrame("Frame")
	local expiredAddOns = {
		"TomCats-ArathiHighlandsRares",
		"TomCats-DarkshoreRares",
		"TomCats-Mechagon",
		"TomCats-Nazjatar",
		"TomCats-Nzoth",
		"TomCats-WarfrontsCommandCenter",
		"TomCats-Complete",
		"TomCats-ChildrensWeek",
		"TomCats-HallowsEnd",
		"TomCats-LoveIsInTheAir",
		"TomCats-LunarFestival",
		"TomCats-Noblegarden"
	}

	local function LoadAddOnDeferrable(_addonName, _defer)
		if (not IsAddOnLoaded("addonName")) then
			if (_defer) then
				NewTimer(0, function()
					LoadAddOn(_addonName)
				end)
			else
				LoadAddOn(_addonName)
			end
		end
	end

	local function LoadZoneTriggered(_defer)
		local mapID = GetBestMapForUnit("player")
		if (mapID) then
			local supportedMap = addon.supportedMaps[mapID]
			if (supportedMap) then
				LoadAddOnDeferrable(supportedMap.name, _defer)
			end
		end
	end

	local function OnEvent(_, event, arg1)
		if (event == "ADDON_LOADED") then
			if (addonName == arg1) then
				eventFrame:UnregisterEvent("ADDON_LOADED")
				for i = 1, #expiredAddOns do
					local expiredAddOn = expiredAddOns[i]
					local _, _, _, loadable = GetAddOnInfo(expiredAddOn)
					if (loadable) then
						DisableAddOn(expiredAddOn)
					end
				end
				LoadZoneTriggered(true)
			end
		elseif (event == "ZONE_CHANGED_NEW_AREA") then
			LoadZoneTriggered()
		end
	end

	eventFrame:SetScript("OnEvent", OnEvent)
	eventFrame:RegisterEvent("ADDON_LOADED")
	eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	local function LoadMapTriggered(_, _mapID)
		local supportedMap = addon.supportedMaps[_mapID]
		if (supportedMap) then
			LoadAddOnDeferrable(supportedMap.name)
		end
	end

	hooksecurefunc(WorldMapFrame, "SetMapID", LoadMapTriggered)

end