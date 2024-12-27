-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- RareScanner database libraries
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner services libraries
local RSMap = private.ImportLib("RareScannerMap")
local RSTooltip = private.ImportLib("RareScannerTooltip")
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSWaypoints = private.ImportLib("RareScannerWaypoints")
local RSTomtom = private.ImportLib("RareScannerTomtom")
local RSProvider = private.ImportLib("RareScannerProvider")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");


RSVignettePinMixin = CreateFromMixins(VignettePinMixin);

RSVignettePinMixin.SetPassThroughButtons = function() end

function RSVignettePinMixin:OnAcquired(vignetteGUID, vignetteInfo, frameIndex)
	-- ORIGINAL CODE
	if (not self:IsSuperTrackingExternallyHandled()) then
		--self:UpdateMousePropagation();
		self:UpdateSuperTrackedState(C_SuperTrack[self:GetSuperTrackAccessorAPIName()]());
	end
	
	self.dataProvider = vignetteInfo.dataProvider;
	self.vignetteGUID = vignetteGUID;
	self.name = vignetteInfo.name;
	self.hasTooltip = vignetteInfo.hasTooltip or vignetteInfo.type == Enum.VignetteType.PvPBounty;
	self.isUnique = vignetteInfo.isUnique;
	self.vignetteID = vignetteInfo.vignetteID;
	self.tooltipWidgetSet = vignetteInfo.tooltipWidgetSet;
	self.iconWidgetSet = vignetteInfo.iconWidgetSet;
	self.vignetteInfo = vignetteInfo;
	self:ApplyTextures();
	self:UpdateFogOfWar(vignetteInfo);
	self:ApplyCurrentAlpha();
	self:UpdatePosition();
	self:UpdateSupertrackedHighlight();
	self:AddIconWidgets();
	self:SetFrameLevelType(frameIndex);
	
	-- ADDITIONS
	
	-- Overrides mouse motion if overriding ingame tooltips
	local POI = RSMap.GetWorldMapPOI(self:GetObjectGUID(), self.vignetteInfo, self:GetMap():GetMapID())
	self.POI = POI
	
	if (RSConfigDB.IsShowingTooltipsOnIngameIcons() and POI) then
		self:EnableMouseMotion(true);
	else
		self:EnableMouseMotion(self.hasTooltip);
	end
	
	-- Extract container's name if we don't have it
	local _, _, _, _, _, vignetteObjectID = strsplit("-", self:GetObjectGUID())
	if (self:GetVignetteType() == Enum.VignetteType.Treasure) then
		local containerID = tonumber(vignetteObjectID)
		if (not RSContainerDB.GetContainerName(containerID) and self:GetVignetteName()) then
			RSContainerDB.SetContainerName(containerID, self:GetVignetteName())
		end
	elseif (self:GetVignetteType() == Enum.VignetteType.Normal) then
		if (RSConstants.IsContainerAtlas(self.vignetteInfo.atlasName)) then
			local containerID = tonumber(vignetteObjectID)
			if (not RSContainerDB.GetContainerName(containerID) and self:GetVignetteName()) then
				RSContainerDB.SetContainerName(containerID, self:GetVignetteName())
			end
		end
	end
end

function RSVignettePinMixin:OnMouseEnter()
	if (self.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then
		RSTooltip.ShowSimpleTooltip(self)
	else
		self.tooltip = nil
		VignettePinMixin.OnMouseEnter(self)
	end
end

function RSVignettePinMixin:OnMouseLeave()
	if (self.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then
		if (RSTooltip.HideTooltip(self.tooltip)) then
			self.tooltip = nil
		end
	else
		VignettePinMixin.OnMouseLeave(self)
	end
end

function RSVignettePinMixin:OnMouseDown(button)
	if (self.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then				
		if (button == "LeftButton") then				
			--Toggle state (if showing tooltips)
			if (IsShiftKeyDown() and IsAltKeyDown()) then
				if (self.POI.isNpc) then
					if (RSConfigDB.GetDefaultNpcFilter() == RSConstants.ENTITY_FILTER_ALERTS) then
						RSConfigDB.SetNpcFiltered(self.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
					else
						RSConfigDB.SetNpcFiltered(self.POI.entityID)
					end
					self:Hide();
				elseif (self.POI.isContainer) then
					if (RSConfigDB.GetDefaultContainerFilter() == RSConstants.ENTITY_FILTER_ALERTS) then
						RSConfigDB.SetContainerFiltered(self.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
					else
						RSConfigDB.SetContainerFiltered(self.POI.entityID)
					end
					self:Hide();
				elseif (self.POI.isEvent) then
					if (RSConfigDB.GetDefaultEventFilter() == RSConstants.ENTITY_FILTER_ALERTS) then
						RSConfigDB.SetEventFiltered(self.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
					else
						RSConfigDB.SetEventFiltered(self.POI.entityID)
					end
					self:Hide();
				end
				RSProvider.RefreshAllDataProviders()
				RSMinimap.RefreshEntityState(self.POI.entityID)
			end
		elseif (button == "RightButton") then						
			-- Add waypoint
			if (IsShiftKeyDown()) then
				if (RSConfigDB.IsAddingWorldMapTomtomWaypoints()) then
					RSTomtom.AddWorldMapTomtomWaypoint(self.POI.mapID, self.POI.x, self.POI.y, self.POI.name)
				end
				if (RSConfigDB.IsAddingWorldMapIngameWaypoints()) then
					RSWaypoints.AddWorldMapWaypoint(self.POI.mapID, self.POI.x, self.POI.y)
				end
			elseif (not IsShiftKeyDown() and not IsAltKeyDown() and not IsControlKeyDown()) then
				-- If already showing a guide toggle it first
				if (self:GetMap():GetNumActivePinsByTemplate("RSGuideTemplate") > 0) then	
					self:GetMap():RemoveAllPinsByTemplate("RSGuideTemplate");
										
					local guideEntityID = RSGeneralDB.GetGuideActive()
					if (guideEntityID) then
						-- If same guide showing then disable it
						if (guideEntityID ~= self.POI.entityID) then
							RSGeneralDB.SetGuideActive(self.POI.entityID)
							RareScannerDataProviderMixin.ShowGuideLayer(self, self.POI.entityID, self:GetMap():GetMapID())
						else
							RSGeneralDB.RemoveGuideActive()
						end
					end
				-- Otherwise show it
				else
					RSGeneralDB.SetGuideActive(self.POI.entityID)
					RareScannerDataProviderMixin.ShowGuideLayer(self, self.POI.entityID, self:GetMap():GetMapID())
				end
			end

			-- Refresh minimap
			RSMinimap.RefreshAllData(true)
		end
	end
end