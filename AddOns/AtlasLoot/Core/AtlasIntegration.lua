-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, select = _G.pairs, _G.select
-- WoW
local GetAddOnInfo, UnitName = C_AddOns and C_AddOns.GetAddOnInfo or _G.GetAddOnInfo,  _G.UnitName
if not GetAddOnEnableState then
	-- Args are flipped in The War Within
	GetAddOnEnableState = function(character, name)
		return C_AddOns.GetAddOnEnableState(name, character);
	end
end


-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local AtlasIntegration = {}
AtlasLoot.AtlasIntegration = AtlasIntegration

local ATLAS_SMALLFRAME_SELECTED_ORIG

function AtlasIntegration.IsEnabled()
	local loadable = select(4, GetAddOnInfo("Atlas"))
	local enabled = GetAddOnEnableState(UnitName("player"), "Atlas")

	if (enabled > 0 and loadable) then
		return true
	else
		return false
	end
end

function AtlasIntegration.GetAtlasZoneData(mapID, setMap)
	if (not AtlasLoot.AtlasIntegration.IsEnabled()) then return end
	local options = Atlas.db.profile.options
	local foundMatch = false
	for k, v in pairs(ATLAS_DROPDOWNS) do
		for k2, v2 in pairs(v) do
			if (v2 == mapID) then
				if setMap then
					options.dropdowns.module = k
					options.dropdowns.zone = k2
				end
				foundMatch = true
				break
			end
		end
		if foundMatch then break end
	end

	return foundMatch
end

function AtlasIntegration.ShowMap(mapID)
	if (not AtlasLoot.AtlasIntegration.IsEnabled()) then return end

	ATLAS_SMALLFRAME_SELECTED_ORIG = ATLAS_SMALLFRAME_SELECTED
	ATLAS_SMALLFRAME_SELECTED = true

	AtlasIntegration.GetAtlasZoneData(mapID, true)

	if ( AtlasFrameLarge:IsVisible() ) then
		HideUIPanel(AtlasFrameLarge)
	end
	if ( AtlasFrame:IsVisible() ) then
		HideUIPanel(AtlasFrame)
	end
	if (not AtlasFrameSmall:IsVisible() ) then
		ShowUIPanel(AtlasFrameSmall)
	end
	AtlasFrameDropDownType_OnShow()
	AtlasFrameDropDown_OnShow()
	Atlas_Refresh()

	ATLAS_SMALLFRAME_SELECTED = ATLAS_SMALLFRAME_SELECTED_ORIG
end
