-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- RareScanner services libraries
local RSTooltip = private.ImportLib("RareScannerTooltip")

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
	--
end

function RSFyrakkFlightVignettePinMixin:OnLegendPinMouseEnter()
	EventRegistry:TriggerEvent("MapLegendPinOnEnter", self);
end

function RSFyrakkFlightVignettePinMixin:OnLegendPinMouseLeave()
	EventRegistry:TriggerEvent("MapLegendPinOnLeave", nil);
end

--ORIGINAL CODE (only replaces GameTooltip by RSTooltip.Tooltip)
	function RSFyrakkFlightVignettePinMixin:OnMouseEnter()
		if self.hasTooltip then
			local verticalPadding = nil;
	
			RSTooltip.Tooltip:SetOwner(self, "ANCHOR_RIGHT");
			self.UpdateTooltip = self.OnMouseEnter;
	
			local waitingForData, titleAdded = false, false;
	
			if self:GetVignetteType() == Enum.VignetteType.Normal or self:GetVignetteType() == Enum.VignetteType.Treasure then
				titleAdded = self:DisplayNormalTooltip();
			elseif self:GetVignetteType() == Enum.VignetteType.PvPBounty then
				titleAdded = self:DisplayPvpBountyTooltip();
				waitingForData = not titleAdded;
			elseif self:GetVignetteType() == Enum.VignetteType.Torghast then
				titleAdded = self:DisplayTorghastTooltip();
			end
	
			if not waitingForData and self.tooltipWidgetSet then
				local overflow = GameTooltip_AddWidgetSet(RSTooltip.Tooltip, self.tooltipWidgetSet, titleAdded and self.vignetteInfo.addPaddingAboveTooltipWidgets and 10);
				if overflow then
					verticalPadding = -overflow;
				end
			elseif waitingForData then
				GameTooltip_SetTitle(RSTooltip.Tooltip, RETRIEVING_DATA);
			end
	
			RSTooltip.Tooltip:Show();
			-- need to set padding after Show or else there will be a flicker
			if verticalPadding then
				RSTooltip.Tooltip:SetPadding(0, verticalPadding);
			end
		end
	    self:OnLegendPinMouseEnter();
	end

	function RSFyrakkFlightVignettePinMixin:OnMouseLeave()
		RSTooltip.Tooltip:Hide();
	    self:OnLegendPinMouseLeave();
	end

	function RSFyrakkFlightVignettePinMixin:DisplayNormalTooltip()
		local vignetteName = self:GetVignetteName();
		if vignetteName ~= "" then
			GameTooltip_SetTitle(RSTooltip.Tooltip, vignetteName);
	
			local groupSizeString = self:GetRecommendedGroupSizeString();
			if groupSizeString then
				GameTooltip_AddInstructionLine(RSTooltip.Tooltip, groupSizeString);
			end
	
			local objectiveString = self:GetObjectiveString();
			if objectiveString then
				local noWrap = false;
				GameTooltip_AddHighlightLine(RSTooltip.Tooltip, objectiveString, noWrap);
			end
	
			return true;
		end
	
		return false;
	end
	
	function RSFyrakkFlightVignettePinMixin:DisplayPvpBountyTooltip()
		local player = PlayerLocation:CreateFromGUID(self:GetObjectGUID());
		local class = select(3, C_PlayerInfo.GetClass(player));
		local race = C_PlayerInfo.GetRace(player);
		local name = C_PlayerInfo.GetName(player);
	
		if race and class and name then
			local classInfo = C_CreatureInfo.GetClassInfo(class);
			local factionInfo = C_CreatureInfo.GetFactionInfo(race);
	
			GameTooltip_SetTitle(RSTooltip.Tooltip, name, GetClassColorObj(classInfo.classFile));
			GameTooltip_AddColoredLine(RSTooltip.Tooltip, factionInfo.name, GetFactionColor(factionInfo.groupTag));
			local rewardQuestID = self:GetRewardQuestID();
			if rewardQuestID then
				GameTooltip_AddQuestRewardsToTooltip(RSTooltip.Tooltip, self:GetRewardQuestID(), TOOLTIP_QUEST_REWARDS_STYLE_PVP_BOUNTY);
			end
	
			return true;
		end
	
		return false;
	end
	
	function RSFyrakkFlightVignettePinMixin:DisplayTorghastTooltip()
		SharedTooltip_SetBackdropStyle(RSTooltip.Tooltip, GAME_TOOLTIP_BACKDROP_STYLE_RUNEFORGE_LEGENDARY);
		return self:DisplayNormalTooltip();
	end
--