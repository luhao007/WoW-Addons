local Guide = {Waypoints = {}, Focus = nil}
BtWQuests.Guide = Guide;

function Guide:AddWayPoint(mapId, x, y, name)
    if not self.DataProvider then
        self.DataProvider = CreateFromMixins(BtWQuestsGuideDataProviderMixin)
        LibMapPinHandler[WorldMapFrame]:AddDataProvider(self.DataProvider);
    end

    local continentMapId = mapId
    local mapInfo = C_Map.GetMapInfo(continentMapId)
    while mapInfo and mapInfo.mapType > Enum.UIMapType.Continent do
        continentMapId = mapInfo.parentMapID
        mapInfo = C_Map.GetMapInfo(continentMapId)
    end

    if not continentMapId or not mapInfo then
        return
    end

    local continentId, position = C_Map.GetWorldPosFromMapPos(mapId, {
        x = x,
        y = y,
    })
    if not continentId or not position then
        return
    end
    local _, position = C_Map.GetMapPosFromWorldPos(continentId, position, continentMapId)
    if not position then
        return
    end

    local waypoints = self.Waypoints[continentMapId]
    if not waypoints then
        waypoints = {}
        self.Waypoints[continentMapId] = waypoints
    end

    position.mapId = continentMapId
    position.itemName = name
    waypoints[position] = true
    self:SetFocus(position)
end
function Guide:SetFocus(item)
    assert(item and item.mapId and self.Waypoints[item.mapId])
    self.Focus = item

    if WorldMapFrame:IsShown() then
        self.DataProvider:RefreshAllData()
    end
end

-- /run BtWQuests_QuestDataProvider = CreateFromMixins(BtWQuests_QuestDataProviderMixin);WorldMapFrame:AddDataProvider(BtWQuests_QuestDataProvider);
BtWQuestsGuideDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin);
function BtWQuestsGuideDataProviderMixin:OnAdded(mapCanvas)
	MapCanvasDataProviderMixin.OnAdded(self, mapCanvas);
	mapCanvas:SetPinTemplateType("BtWQuestsGuidePinTemplate", "BUTTON");
end

function BtWQuestsGuideDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate("BtWQuestsGuidePinTemplate");
end

function BtWQuestsGuideDataProviderMixin:RefreshAllData(fromOnShow)
	self:RemoveAllData();

    local mapId = self:GetMap():GetMapID();
    if not mapId then
        return
    end

    local continentMapId = mapId
    local mapInfo = C_Map.GetMapInfo(continentMapId)
    while mapInfo and mapInfo.mapType > Enum.UIMapType.Continent do
        continentMapId = mapInfo.parentMapID
        mapInfo = C_Map.GetMapInfo(continentMapId)
    end

    local waypoints = Guide.Waypoints[continentMapId]
    if not waypoints then
        return
    end
    for item in pairs(waypoints) do
        local continentId, position = C_Map.GetWorldPosFromMapPos(continentMapId, item)
        local _, position = C_Map.GetMapPosFromWorldPos(continentId, position, mapId)

        if position.x > 0 and position.x < 1 and position.y > 0 and position.y < 1 then
            local pin = self:GetMap():AcquirePin("BtWQuestsGuidePinTemplate", item.itemName);
            pin.waypoints = waypoints
            pin.item = item
            
            pin:SetPosition(position.x, position.y);
            pin.Focus:SetShown(false);--item == Guide.Focus)
            pin:Show();
        end
    end
end

BtWQuestsGuidePinMixin = CreateFromMixins(MapCanvasPinMixin);
function BtWQuestsGuidePinMixin:OnLoad()
	self:SetScalingLimits(1, 1.0, 1.2);
	self:UseFrameLevelType("PIN_FRAME_LEVEL_STORY_LINE");
end

function BtWQuestsGuidePinMixin:OnAcquired(itemName)
	self.itemName = itemName;
	self.mapID = self:GetMap():GetMapID();
end

function BtWQuestsGuidePinMixin:SetName(value)
    self.name = value
end

function BtWQuestsGuidePinMixin:OnMouseEnter()
	WorldMapTooltip:SetOwner(self, "ANCHOR_LEFT");
	WorldMapTooltip:SetText(self.itemName);
	WorldMapTooltip:Show();
end

function BtWQuestsGuidePinMixin:OnMouseLeave()
	WorldMapTooltip:Hide();
end

function BtWQuestsGuidePinMixin:OnClick(button)
    if button == "LeftButton" then
        Guide:SetFocus(self.item)
    elseif button == "RightButton" then
        self.waypoints[self.item] = nil
		self:GetMap():RemovePin(self);
    end
end
