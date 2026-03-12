WQL_AreaPOIPinMixin = CreateFromMixins(AreaPOIPinMixin)

local GameTooltip = CreateFrame("GameTooltip", "WQLAreaPOITooltip", UIParent, "GameTooltipTemplate")
GameTooltip:Hide()
GameTooltip:SetFrameStrata("TOOLTIP")
GameTooltip.ItemTooltip = CreateFrame("Frame", nil, GameTooltip, "InternalEmbeddedItemTooltipTemplate")
GameTooltip.ItemTooltip:Hide()
GameTooltip.ItemTooltip:SetSize(100,100)
GameTooltip.ItemTooltip:SetPoint("BOTTOMLEFT",10,13)
GameTooltip.ItemTooltip.yspacing = 13
C_Timer.After(1,function()GameTooltip.ItemTooltip.Tooltip.shoppingTooltips = { WQLTooltipItemRef1, WQLTooltipItemRef2 };end)
GameTooltip.supportsItemComparison = false

function WQL_AreaPOIPinMixin:TryShowTooltip()
	local description = self.description;

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip_SetTitle(GameTooltip, self.name, HIGHLIGHT_FONT_COLOR);

	if description then
		GameTooltip_AddNormalLine(GameTooltip, description);
	end

	if type(self.itemID)=='number' then
		EmbeddedItemTooltip_SetItemByID(GameTooltip.ItemTooltip, self.itemID)
	elseif type(self.itemID)=='table' then
		EmbeddedItemTooltip_SetItemByID(GameTooltip.ItemTooltip, self.itemID[1])
	end

	GameTooltip:Show();
	return true;
end

function WQL_AreaPOIPinMixin:OnMouseEnter()
	if not self.name or #self.name == 0 then
		return;
	end

	self.UpdateTooltip = function() self:OnMouseEnter(); end;

	if not self:TryShowTooltip() then
		self:GetMap():TriggerEvent("SetAreaLabel", MAP_AREA_LABEL_TYPE.POI, self.name, self.description);
	end
end

function WQL_AreaPOIPinMixin:OnMouseLeave()
	self:GetMap():TriggerEvent("ClearAreaLabel", MAP_AREA_LABEL_TYPE.POI);

	GameTooltip:Hide();
end

function WQL_AreaPOIPinMixin:OnAcquired(poiInfo) -- override
	BaseMapPoiPinMixin.OnAcquired(self, poiInfo);

	self.areaPoiID = poiInfo.areaPoiID;
	
	self.clickData = poiInfo.clickData;
	
	self.itemID = poiInfo.itemID
end

function WQL_AreaPOIPinMixin:OnClick(button)
	WorldQuestList.hookClickFunc(self,button)
end


WQL_AreaPOIPinMixin.CheckMouseButtonPassthrough=nop
WQL_AreaPOIPinMixin.SetPassThroughButtons=nop
WQL_AreaPOIPinMixin.SetPropagateMouseClicks=nop


function WQL_AreaPOIPinMixin:GetQuestClassification()
	local questID = self:GetQuestID();
	if questID then
		return  C_QuestInfoSystem.GetQuestClassification(questID);
	end

	return nil;
end



WQL_WayPinMixin = CreateFromMixins(AreaPOIPinMixin)

function WQL_WayPinMixin:TryShowTooltip()
	return
end

function WQL_WayPinMixin:OnMouseEnter()
	if self.waypoint and self.waypoint.comment then
		self:GetMap():TriggerEvent("SetAreaLabel", MAP_AREA_LABEL_TYPE.POI, " ", self.waypoint.comment);
	end
end

function WQL_WayPinMixin:OnMouseLeave()
	self:GetMap():TriggerEvent("ClearAreaLabel", MAP_AREA_LABEL_TYPE.POI);
end

function WQL_WayPinMixin:OnAcquired(poiInfo) -- override
	BaseMapPoiPinMixin.OnAcquired(self, poiInfo);

	self.areaPoiID = poiInfo.areaPoiID;
	
	self.clickData = poiInfo.clickData;

	self.waypoint = poiInfo.data;
	
	self:SetSize(20*poiInfo.size,20*poiInfo.size)
	self.Texture:SetSize(20*poiInfo.size,20*poiInfo.size)
end

function WQL_WayPinMixin:OnClick(button)
	WorldQuestList:WaypointRemove(self.waypoint)
end



WQL_HolidayPinMixin = CreateFromMixins(WQL_WayPinMixin)

function WQL_HolidayPinMixin:OnMouseEnter()
	self:GetMap():TriggerEvent("SetAreaLabel", MAP_AREA_LABEL_TYPE.POI, self.name, self.description);
end

function WQL_HolidayPinMixin:OnMouseLeave()
	self:GetMap():TriggerEvent("ClearAreaLabel", MAP_AREA_LABEL_TYPE.POI);
end
function WQL_HolidayPinMixin:SetTexture(poiInfo)
	self.Texture:SetTexture(poiInfo.texture);

	local sizeX, sizeY = self.Texture:GetSize();
	self:SetSize(sizeX, sizeY);

	self.Texture:SetTexCoord(0, 1, 0, 1);
end
function WQL_HolidayPinMixin:OnAcquired(poiInfo) -- override
	BaseMapPoiPinMixin.OnAcquired(self, poiInfo);

	self.areaPoiID = poiInfo.areaPoiID;
	
	self.clickData = poiInfo.clickData;

	self.data = poiInfo.data;
	
	self:SetSize(20*poiInfo.size,20*poiInfo.size)
	self.Texture:SetSize(20*poiInfo.size,20*poiInfo.size)
end

function WQL_HolidayPinMixin:OnClick(button)
	local data = self.clickData
	local continentID, worldPos = C_Map.GetWorldPosFromMapPos(data.mapID, CreateVector2D(data.x, data.y))
	if worldPos then
		local wy,wx = worldPos:GetXY()
		if wx and wy then
			WorldQuestList.AddArrow(wx,wy,nil,self.data[8],nil,data.arrowFunc)
		end
	end
	WorldQuestList.AddArrowNWC(data.x,data.y,data.mapID,0,self.data[8])

	local uiMapPoint = UiMapPoint.CreateFromCoordinates(data.mapID, data.x, data.y)
	C_Map.SetUserWaypoint(uiMapPoint)
	C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end


WQL_WorldQuestPinMixin = CreateFromMixins(WorldMap_WorldQuestPinMixin)

WQL_WorldQuestPinMixin.CheckMouseButtonPassthrough=nop
WQL_WorldQuestPinMixin.SetPassThroughButtons=nop
WQL_WorldQuestPinMixin.SetPropagateMouseClicks=nop

WQL_WorldQuestPinMixin.IsSuppressed = function () return true end



function WQL_WorldQuestPinMixin:GetQuestClassification()
	local questID = self:GetQuestID();
	if questID then
		return  C_QuestInfoSystem.GetQuestClassification(questID);
	end

	return nil;
end

local function GameTooltip_AddQuest(self)
	local questID = self.questID;
	if ( not HaveQuestData(questID) ) then
		GameTooltip_SetTitle(GameTooltip, RETRIEVING_DATA, RED_FONT_COLOR);
		GameTooltip_SetTooltipWaitingForData(GameTooltip, true);
		GameTooltip:Show();
		return;
	end

	local widgetSetAdded = false;
	local widgetSetID = C_TaskQuest.GetQuestUIWidgetSetByType(questID, Enum.MapIconUIWidgetSetType.Tooltip);
	local isThreat = C_QuestLog.IsThreatQuest(questID);

	local title, factionID, capped = C_TaskQuest.GetQuestInfoByQuestID(questID);
	title = title or self.questName;
	if self.worldQuest or C_QuestLog.IsWorldQuest(questID) then
		self.worldQuest = true;
		local tagInfo = C_QuestLog.GetQuestTagInfo(self.questID);
		local quality = tagInfo and tagInfo.quality or Enum.WorldQuestQuality.Common;

		local colorData = ColorManager.GetColorDataForWorldQuestQuality(quality)
		if colorData then
			GameTooltip_SetTitle(GameTooltip, title, colorData.color);
		else
			GameTooltip_SetTitle(GameTooltip, title);
		end

		if C_QuestLog.IsAccountQuest(questID) then
			GameTooltip_AddColoredLine(GameTooltip, ACCOUNT_QUEST_LABEL, ACCOUNT_WIDE_FONT_COLOR);
		end

		QuestUtils_AddQuestTypeToTooltip(GameTooltip, questID, NORMAL_FONT_COLOR);

		local factionData = factionID and C_Reputation.GetFactionDataByID(factionID);
		if factionData then
			local questAwardsReputationWithFaction = C_QuestLog.DoesQuestAwardReputationWithFaction(questID, factionID);
			local reputationYieldsRewards = (not capped) or C_Reputation.IsFactionParagonForCurrentPlayer(factionID);
			if questAwardsReputationWithFaction and reputationYieldsRewards then
				GameTooltip:AddLine(factionData.name);
			else
				GameTooltip:AddLine(factionData.name, GRAY_FONT_COLOR:GetRGB());
			end
		end

		GameTooltip_AddQuestTimeToTooltip(GameTooltip, questID);
	elseif isThreat then
		GameTooltip_SetTitle(GameTooltip, title);
		GameTooltip_AddQuestTimeToTooltip(GameTooltip, questID);
	else
		GameTooltip_SetTitle(GameTooltip, title, NORMAL_FONT_COLOR);
	end

	if self.isCombatAllyQuest or (C_QuestLog.GetQuestType(questID) == Enum.QuestTag.CombatAlly) then
		GameTooltip_AddColoredLine(GameTooltip, AVAILABLE_FOLLOWER_QUEST, HIGHLIGHT_FONT_COLOR, true);
		GameTooltip_AddColoredLine(GameTooltip, GRANTS_FOLLOWER_XP, GREEN_FONT_COLOR, true);
	elseif self.isQuestStart then
		GameTooltip_AddColoredLine(GameTooltip, AVAILABLE_QUEST, HIGHLIGHT_FONT_COLOR, true);
		AddFloorLocationLine(GameTooltip, self.floorLocation, QUESTLINE_LOCATED_ABOVE, QUESTLINE_LOCATED_BELOW);
	else
		local questDescription = "";
		local questCompleted = C_QuestLog.IsComplete(questID);

		if questCompleted and self.shouldShowObjectivesAsStatusBar then
			questDescription = QUEST_WATCH_QUEST_READY;
			GameTooltip_AddColoredLine(GameTooltip, QUEST_DASH .. questDescription, HIGHLIGHT_FONT_COLOR);
		elseif not questCompleted and self.shouldShowObjectivesAsStatusBar then
			local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID);
			if questLogIndex then
				questDescription = select(2, GetQuestLogQuestText(questLogIndex));
				GameTooltip_AddColoredLine(GameTooltip, QUEST_DASH .. questDescription, HIGHLIGHT_FONT_COLOR);
			end
		end
		local numObjectives = self.numbObjectives or C_QuestLog.GetNumQuestObjectives(questID);
		for objectiveIndex = 1, numObjectives do
			local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, objectiveIndex, false);
			local showObjective = not (finished and isThreat);
			if showObjective then
				if self.shouldShowObjectivesAsStatusBar then
					local percent = math.floor((numFulfilled/numRequired) * 100);
					GameTooltip_ShowProgressBar(GameTooltip, 0, numRequired, numFulfilled, PERCENTAGE_STRING:format(percent));
				elseif objectiveText and (#objectiveText > 0) then
					local color = finished and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR;
					GameTooltip:AddLine(QUEST_DASH .. objectiveText, color.r, color.g, color.b, true);
				end
			end
		end
		local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false);
		if objectiveType == "progressbar" then
			local percent = C_TaskQuest.GetQuestProgressBarInfo(questID);
			local showObjective = not (finished and isThreat);
			if percent  and showObjective then
				GameTooltip_ShowProgressBar(GameTooltip, 0, 100, percent, PERCENTAGE_STRING:format(percent));
			end
		end

		if widgetSetID then
			widgetSetAdded = true;
			GameTooltip_AddWidgetSet(GameTooltip, widgetSetID);
		end

		GameTooltip_AddQuestRewardsToTooltip(GameTooltip, questID, self.questRewardTooltipStyle or TOOLTIP_QUEST_REWARDS_STYLE_DEFAULT);

		if self.worldQuest and C_TooltipInfo.GM then
			local tooltipData = C_TooltipInfo.GM.GetDebugWorldQuestInfo(questID);
			if tooltipData then
				local tooltipInfo = { tooltipData = tooltipData, append = true };
				GameTooltip:ProcessInfo(tooltipInfo);
				GameTooltip:Show();
			end
		end
	end


	if not widgetSetAdded and widgetSetID then
		GameTooltip_AddWidgetSet(GameTooltip, widgetSetID);
	end

	GameTooltip:Show();
end

local function TaskPOI_OnEnter(self, skipSetOwner)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

	if ( not HaveQuestData(self.questID) ) then
		GameTooltip_SetTitle(GameTooltip, RETRIEVING_DATA, RED_FONT_COLOR);
		GameTooltip_SetTooltipWaitingForData(GameTooltip, true);
		GameTooltip:Show();
		return;
	end

	if C_QuestLog.IsQuestCalling(self.questID) then
		CallingPOI_OnEnter(self);
		return;
	end

	GameTooltip_AddQuest(self);
	EventRegistry:TriggerEvent("TaskPOI.TooltipShown", self, self.questID, self);
end

local function TaskPOI_OnLeave(self)
	GameTooltip:Hide();
end 

function WQL_WorldQuestPinMixin:OnMouseEnter()
	TaskPOI_OnEnter(self);
	POIButtonMixin.OnEnter(self);
	self:OnLegendPinMouseEnter();
end

function WQL_WorldQuestPinMixin:OnMouseLeave()
	TaskPOI_OnLeave(self);
	POIButtonMixin.OnLeave(self);
	self:OnLegendPinMouseLeave();
end
