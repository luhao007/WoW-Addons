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


RSAreaPOIPinMixin = CreateFromMixins(AreaPOIPinMixin);

RSAreaPOIPinMixin.SetPassThroughButtons = function() end

function RSAreaPOIPinMixin:OnAcquired(poiInfo)	
	-- ORIGINAL CODE
	BaseMapPoiPinMixin.OnAcquired(self, poiInfo)
	
	if (not self:IsSuperTrackingExternallyHandled()) then
		--self:UpdateMousePropagation();
		self:UpdateSuperTrackedState(C_SuperTrack[self:GetSuperTrackAccessorAPIName()]());
	end
	
	self.poiInfo = poiInfo;
	self:SetupHoverInfo(poiInfo);
	MapPinHighlight_CheckHighlightPin(self:GetHighlightType(), self, self.Texture, AREAPOI_HIGHLIGHT_PARAMS);

	self:AddIconWidgets();
	self:UpdateCustomMouseHandlers();

	if (poiInfo.isAlwaysOnFlightmap) then
		self:SetAlphaLimits(1.0, 1.0, 1.0);
	end
	
	-- ADDITIONS
	
	self.objectGUID = string.format("a-a-a-a-a-%s-%s", poiInfo.areaPoiID, time())
	self.poiInfo.type = "";
	
	-- Overrides mouse motion if overriding ingame tooltips
	local POI = RSMap.GetWorldMapPOI(self.objectGUID, self.poiInfo, self:GetMap():GetMapID())
	self.POI = POI
end

function RSAreaPOIPinMixin:GetDescription()
	if (self.poiInfo) then
		return self.poiInfo.description
	end
end

function RSAreaPOIPinMixin:OnMouseEnter()
	if (self.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then
		RSTooltip.ShowSimpleTooltip(self)
	else
		self.tooltip = nil
		AreaPOIPinMixin.OnMouseEnter(self)
	end
end

function RSAreaPOIPinMixin:OnMouseLeave()
	if (self.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then
		if (RSTooltip.HideTooltip(self.tooltip)) then
			self.tooltip = nil
		end
	else
		AreaPOIPinMixin.OnMouseLeave(self)
	end
end

function RSAreaPOIPinMixin:OnMouseDown(button)
	if (self.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then				
		if (button == "LeftButton") then
			local hide = false
			--Toggle state (if showing tooltips)
			if (IsShiftKeyDown() and IsAltKeyDown()) then
				if (self.POI.isNpc) then
					if (RSConfigDB.GetDefaultNpcFilter() == RSConstants.ENTITY_FILTER_ALERTS) then
						RSConfigDB.SetNpcFiltered(self.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
					else
						RSConfigDB.SetNpcFiltered(self.POI.entityID)
					end
					self:Hide()
				elseif (self.POI.isContainer) then
					if (RSConfigDB.GetDefaultContainerFilter() == RSConstants.ENTITY_FILTER_ALERTS) then
						RSConfigDB.SetContainerFiltered(self.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
					else
						RSConfigDB.SetContainerFiltered(self.POI.entityID)
					end
					self:Hide()
				elseif (self.POI.isEvent) then
					if (RSConfigDB.GetDefaultEventFilter() == RSConstants.ENTITY_FILTER_ALERTS) then
						RSConfigDB.SetEventFiltered(self.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
					else
						RSConfigDB.SetEventFiltered(self.POI.entityID)
					end
					self:Hide()
				end
				RSMinimap.RefreshEntityState(self.POI.entityID)
				RSProvider.RefreshAllDataProviders()
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
	
	if (not InCombatLockdown() and self:DoesMapTypeAllowSuperTrack()) then
		self:AdjustPointsOffset(1, -1);
	end
end

function RSAreaPOIPinMixin:OnMouseUp(button)
	if (not InCombatLockdown() and self:DoesMapTypeAllowSuperTrack()) then
		self:AdjustPointsOffset(-1, 1);
	end
end