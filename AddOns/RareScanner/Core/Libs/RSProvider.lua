-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSProvider = private.NewLib("RareScannerProvider")

local providers = {}

function RSProvider.DropDataProvider(provider)
	if (provider) then
		WorldMapFrame:RemoveDataProvider(provider)
		provider:OnHide() --fixes https://legacy.curseforge.com/wow/addons/rarescanner/issues/339
	end
end

function RSProvider.AddDataProvider(provider)
	if (provider) then
		providers[provider] = true
		WorldMapFrame:AddDataProvider(provider);
	end
end

function RSProvider.RefreshAllDataProviders()
	for dp, _ in pairs(providers) do
		dp:RefreshAllData()
	end
end