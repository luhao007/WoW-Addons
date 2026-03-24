-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner service libraries
local RSUtils = private.ImportLib("RareScannerUtils")
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSTooltip = private.ImportLib("RareScannerTooltip")

RSGuideMixin = CreateFromMixins(RSPinMixin);

function RSGuideMixin:OnLoad()
	RSPinMixin.OnLoad(self)
	self:SetFrameLevel(15)
	self:SetScalingLimits(1, 0.75, 1.0);
end

function RSGuideMixin:OnAcquired(POI, pin)
	RSPinMixin.OnAcquired(self, POI)
	self:SetFrameLevel(10)

	-- Set attributes
	self.pin = pin
	self.Texture:SetTexture(POI.texture)
	self.Texture:SetScale(RSConfigDB.GetIconsWorldMapScale())
end

function RSGuideMixin:OnMouseEnter()
	if (self.ShowPingAnim:IsPlaying()) then
		self.ShowPingAnim:Stop()
	end
	if (self.pin and self.pin.ShowPingAnim and not self.pin.ShowPingAnim:IsPlaying()) then
		if (RSConfigDB.IsHighlightingReputation()) then
			local _, bountyFactionID, bountyFrameType = self.pin.dataProvider:GetBountyInfo();
			if (bountyFrameType ~= BountyFrameType.ActivityTracker or not self.pin.POI.factionID or not RSUtils.Contains(self.pin.POI.factionID, bountyFactionID)) then
				-- Avoid animating if the bounty animation is active, it meshes it up
				self.pin.ShowPingAnim:Play();
			end
		else
			self.pin.ShowPingAnim:Play();
		end
	end
	
	if (self.POI.tooltip) then
		RSTooltip.Tooltip:SetOwner(self, "ANCHOR_CURSOR")

		if (self.POI.tooltip.title) then
			GameTooltip_SetTitle(RSTooltip.Tooltip, self.POI.tooltip.title);
		end

		if (self.POI.tooltip.comment) then
			GameTooltip_AddNormalLine(RSTooltip.Tooltip, self.POI.tooltip.comment);
		end

		RSTooltip.Tooltip:Show()
	end
end

function RSGuideMixin:OnMouseLeave()
	if (self.POI.tooltip) then
		RSTooltip.Tooltip:Hide()
	end
	if (self.pin and self.pin.ShowPingAnim and self.pin.ShowPingAnim:IsPlaying()) then
		self.pin.ShowPingAnim:Stop();
	end
end

function RSGuideMixin:OnMouseDown(button)
	if (button == "RightButton") then
		self:GetMap():RemoveAllPinsByTemplate("RSGuideTemplate");
		RSGeneralDB.RemoveGuideActive()

		-- Refresh minimap
		RSMinimap.RefreshAllData(true)
	end
end
