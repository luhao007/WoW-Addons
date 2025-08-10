-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local WorldMap = {}
AtlasLoot.WorldMap = WorldMap
local AL = AtlasLoot.Locales
local profile

AtlasLootWorldMapButtonMixin = {}

function AtlasLootWorldMapButtonMixin:OnLoad()
	self:SetFrameStrata("HIGH")
end

function AtlasLootWorldMapButtonMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(AL["Click to open AtlasLoot window"], nil, nil, nil, nil, 1)
end

function AtlasLootWorldMapButtonMixin:OnLeave()
	GameTooltip:Hide()
end

function AtlasLootWorldMapButtonMixin:OnClick()
	if (not AtlasLoot.GUI.frame:IsVisible()) then
		AtlasLoot.GUI.frame:Show()
	end
	ToggleFrame(WorldMapFrame)
end

function AtlasLootWorldMapButtonMixin:Refresh()

end

local function ButtonBinding()
	local KButtons = LibStub("Krowi_WorldMapButtons-1.4")
	WorldMap.button = KButtons:Add("AtlasLootWorldMapButtonTemplate", "BUTTON")
end

function WorldMap.Init()
	profile = AtlasLoot.db.WorldMap

	WorldMap.ToggleButtonOnChange()
end

AtlasLoot:AddInitFunc(WorldMap.Init)

function WorldMap.ToggleButtonOnChange()
	if (not WorldMap.button) then ButtonBinding() end

	if (profile.showbutton) then
		WorldMap.button:Show()
	else
		WorldMap.button:Hide()
	end
end
