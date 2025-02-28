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

RSVignetteDataProviderMixin = CreateFromMixins(VignetteDataProviderMixin);

function RSVignetteDataProviderMixin:GetPinTemplates()
	local templates = self.pinTemplates;
	if (not templates) then
		templates = { "RSVignettePinTemplate", "RSVignettePinPOIButtonTemplate" };
		self.pinTemplates = templates;
	end

	return templates;
end

function RSVignetteDataProviderMixin:GetPinTemplate(vignetteInfo)
	if (vignetteInfo.mapPin) then
		return "RSVignettePinPOIButtonTemplate";
	end

	return self:GetDefaultPinTemplate();
end

function RSVignetteDataProviderMixin:GetDefaultPinTemplate()
	return "RSVignettePinTemplate";
end

function RSVignetteDataProviderMixin:OnShow()
	VignetteDataProviderMixin.OnShow(self)
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

function RSVignetteDataProviderMixin:ShowAnimations()
	-- Show recently seen animations in world map vignettes
	if (RSConfigDB.IsShowingAnimationForVignettes()) then
		for _, pin in pairs (self.vignetteGuidsToPins) do
			local _, _, _, _, _, vignetteObjectID = strsplit("-", pin:GetObjectGUID())
			local entityID = tonumber(vignetteObjectID)

			-- If it's a pre-event
			local finalEntityID = tonumber(RSGeneralDB.GetFinalEntityID(entityID))
			
			if (RSConfigDB.IsShowingAnimationForNpcs()) then
				-- If it's a pre-spawn event
				if (RSNpcDB.GetInternalNpcInfo(finalEntityID)) then
					pingAnimation(pin, pin.ShowPingAnim, finalEntityID)
				elseif ((entityID == RSConstants.FORBIDDEN_REACH_ANCESTRAL_SPIRIT or entityID == RSConstants.ZARALEK_CAVERN_LOAM_SCOUT) and RSNpcDB.GetNpcId(pin:GetVignetteName(), self:GetMap():GetMapID())) then
					pingAnimation(pin, pin.ShowPingAnim, RSNpcDB.GetNpcId(pin:GetVignetteName(), self:GetMap():GetMapID()))
				elseif (entityID == RSConstants.GOBLIN_PORTAL) then
					pingAnimation(pin, pin.ShowPingAnim, RSNpcDB.GetNpcId(pin:GetVignetteName(), self:GetMap():GetMapID()))
				end
			end	
			if ((RSConfigDB.IsShowingAnimationForContainers() and RSContainerDB.GetInternalContainerInfo(finalEntityID)) or (RSConfigDB.IsShowingAnimationForEvents() and RSEventDB.GetInternalEventInfo(finalEntityID))) then
				pingAnimation(pin, pin.ShowPingAnim, vignetteObjectID)
			end
		end
	end
end

function RSVignetteDataProviderMixin:RefreshAllData(fromOnShow)
	VignetteDataProviderMixin.RefreshAllData(self, fromOnShow)
	
	if (self.vignetteGuidsToPins) then
		for _, pin in pairs (self.vignetteGuidsToPins) do
			-- Animate if matches with text filter
			if (RSGeneralDB.GetWorldMapTextFilter()) then
				if (pin.POI and RSUtils.Contains(pin.POI.name, RSGeneralDB.GetWorldMapTextFilter())) then
					if (not pin.ShowPingAnim:IsPlaying()) then
						pin.ShowSearchAnim:Play()
					end
				else
					pin.ShowSearchAnim:Stop()
				end
			end
		end
	end
end

function RSVignetteDataProviderMixin:ShouldShowVignette(vignetteInfo)
	local shouldShow = vignetteInfo and vignetteInfo.onWorldMap;
	
	-- Removes icon if filtered
	if (shouldShow) then
		local _, _, _, _, _, vignetteObjectID = strsplit("-", vignetteInfo.objectGUID)
		local entityID = tonumber(vignetteObjectID)

		-- If it's a pre-event
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
	end
	
	return shouldShow
end

-- Needed to override the template FyrakkFlightVignettePinTemplate and avoid taint issues
function RSVignetteDataProviderMixin:GetPin(vignetteGUID, vignetteInfo)
	if (vignetteInfo.type == Enum.VignetteType.FyrakkFlight) then
		if (self.fyrakkFlightPin) then
			self.fyrakkFlightPin:OnAcquired(vignetteGUID, vignetteInfo);
		else
			self.fyrakkFlightPin = self:GetMap():AcquirePin("RSFyrakkFlightVignettePinTemplate", vignetteGUID, vignetteInfo);
		end
		return self.fyrakkFlightPin;
	else
		local pinTemplate = self:GetPinTemplate(vignetteInfo);
		-- GetNumActivePinsByTemplate will return the number right now, before this pin is added, use a consistent template here for the count.
		local frameIndex = self:GetMap():GetNumActivePinsByTemplate(self:GetDefaultPinTemplate()) + 1;
		
		-- Fix Nerathor icon
		local _, _, _, _, _, id, _ = strsplit("-", vignetteInfo.objectGUID);
		local entityID = tonumber(id)
		if (entityID == 229982) then
			vignetteInfo.atlasName = RSConstants.NPC_VIGNETTE
		end
		
		return self:GetMap():AcquirePin(pinTemplate, vignetteGUID, vignetteInfo, frameIndex);
	end
end