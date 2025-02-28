-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local ADDON_NAME, private = ...


RSFyrakkFlightVignettePinMixin = CreateFromMixins(FyrakkFlightVignettePinMixin);

RSFyrakkFlightVignettePinMixin.SetPassThroughButtons = function() end

function RSFyrakkFlightVignettePinMixin:OnAcquired(vignetteGUID, vignetteInfo, frameIndex)
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
end

function RSFyrakkFlightVignettePinMixin:OnLegendPinMouseEnter()
	EventRegistry:TriggerEvent("MapLegendPinOnEnter", self);
end

function RSFyrakkFlightVignettePinMixin:OnLegendPinMouseLeave()
	EventRegistry:TriggerEvent("MapLegendPinOnLeave", nil);
end