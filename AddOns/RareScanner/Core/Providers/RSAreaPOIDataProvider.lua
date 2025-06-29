-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")

-- RareScanner general libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner services libraries
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")

RSAreaPOIDataProviderMixin = CreateFromMixins(AreaPOIDataProviderMixin);

function RSAreaPOIDataProviderMixin:GetPinTemplate()
	return "RSAreaPOIPinTemplate";
end

function RSAreaPOIDataProviderMixin:OnShow()
	AreaPOIDataProviderMixin.OnShow(self)
	self:ShowAnimations()
end

local function pingAnimation(pin, animation, entityID, mapID, x, y)
	if (not animation or not entityID) then
		return
	end
	
	animation:Stop()
	animation:SetScript("OnLoop", function(self, loopState)
		if (self.loops) then
			self.loops = self.loops + 1
			
			if (self.loops == 3) then
				RSRecentlySeenTracker.DeletePendingAnimation(entityID, mapID, x, y)
				self:Stop()
				self:SetLooping("NONE")
			end
		end
	end)
		
	if (RSRecentlySeenTracker.ShouldPlayAnimation(entityID, mapID, x, y)) then
		animation.loops = 0
		animation:SetLooping("BOUNCE")
		animation:Play()
	end
end

function RSAreaPOIDataProviderMixin:ShowAnimations()
	-- Show recently seen animations in world map vignettes
	if (RSConfigDB.IsShowingAnimationForVignettes()) then
		for pin in self:GetMap():EnumeratePinsByTemplate(self:GetPinTemplate()) do
			local entityID = pin.poiInfo.areaPoiID

			-- If it's a pre-event
			local finalEntityID = tonumber(RSGeneralDB.GetFinalEntityID(entityID))
			
			if (RSConfigDB.IsShowingAnimationForNpcs()) then
				-- If it's a pre-spawn event
				if (RSNpcDB.GetInternalNpcInfo(finalEntityID)) then
					pingAnimation(pin, pin.ShowPingAnim, finalEntityID)
				elseif ((entityID == RSConstants.FORBIDDEN_REACH_ANCESTRAL_SPIRIT or entityID == RSConstants.ZARALEK_CAVERN_LOAM_SCOUT) and RSNpcDB.GetNpcId(pin.poiInfo.name, self:GetMap():GetMapID())) then
					pingAnimation(pin, pin.ShowPingAnim, RSNpcDB.GetNpcId(pin.poiInfo.name, self:GetMap():GetMapID()))
				elseif (entityID == RSConstants.GOBLIN_PORTAL) then
					pingAnimation(pin, pin.ShowPingAnim, RSNpcDB.GetNpcId(pin.poiInfo.name, self:GetMap():GetMapID()))
				end
			end	
			if ((RSConfigDB.IsShowingAnimationForContainers() and RSContainerDB.GetInternalContainerInfo(finalEntityID)) or (RSConfigDB.IsShowingAnimationForEvents() and RSEventDB.GetInternalEventInfo(finalEntityID))) then
				pingAnimation(pin, pin.ShowPingAnim, pin.poiInfo.areaPoiID)
			end
		end
	end
end

function RSAreaPOIDataProviderMixin:RefreshAllData(fromOnShow)
	self:RemoveAllData();

	local mapID = self:GetMap():GetMapID();
	local areaPOIs = GetAreaPOIsForPlayerByMapIDCached(mapID);
	local alreadyAdded = {}
	for i, areaPoiID in ipairs(areaPOIs) do
		local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, areaPoiID);
		if (poiInfo and self:ShouldShowAreaPOI(areaPoiID) and not RSUtils.Contains(alreadyAdded, areaPoiID)) then
			tinsert(alreadyAdded, areaPoiID)
			poiInfo.dataProvider = self;
			self:GetMap():AcquirePin(self:GetPinTemplate(), poiInfo);
		end
	end
end

function RSAreaPOIDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate());
end

function RSAreaPOIDataProviderMixin:ShouldShowAreaPOI(entityID)
	local finalEntityID = tonumber(RSGeneralDB.GetFinalEntityID(entityID))
	
	if (RSNpcDB.GetInternalNpcInfo(finalEntityID)) then
		if (RSConfigDB.IsNpcFiltered(finalEntityID) or RSConfigDB.IsNpcFilteredOnlyWorldmap(finalEntityID)) then
			return false
		end
	elseif (RSContainerDB.GetInternalContainerInfo(finalEntityID)) then
		if (RSConfigDB.IsContainerFiltered(finalEntityID) or RSConfigDB.IsContainerFilteredOnlyWorldmap(finalEntityID)) then
			return false
		end
	elseif (RSEventDB.GetInternalEventInfo(finalEntityID)) then
		if (RSConfigDB.IsEventFiltered(finalEntityID) or RSConfigDB.IsEventFilteredOnlyWorldmap(finalEntityID)) then
			return false
		end
	end
	
	return true
end