local addonName, addonTable = ...;
local Create = addonTable.Create
local PIGFontString=Create.PIGFontString
local Mapfun=addonTable.Mapfun

----------
local WorldMapScrollChild = WorldMapFrame.ScrollContainer.Child
local function MouseXY()
	local left, top = WorldMapScrollChild:GetLeft(), WorldMapScrollChild:GetTop()
	local width, height = WorldMapScrollChild:GetWidth(), WorldMapScrollChild:GetHeight()
	local scale = WorldMapScrollChild:GetEffectiveScale()
	local x, y = GetCursorPosition()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height
	if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
		return
	end
	return cx, cy
end
local function czWeizhi()
	if WorldMapFrame.xyf then WorldMapFrame.xyf:SetPoint("BOTTOM",WorldMapFrame,"BOTTOM",0,4.4);end
end
function Mapfun.WorldMap_XY()
	if not PIGA["Map"]["WorldMapXY"] then return end
	WorldMapFrame.xyf = CreateFrame("Frame", nil, WorldMapFrame);
	WorldMapFrame.xyf:SetSize(340,26);
	czWeizhi()
	local mapxydata = {["x"]={4, 0, 14}}
	if PIG_MaxTocversion(30000) then

	elseif PIG_MaxTocversion(40000) then
		mapxydata.x[1]=10
		mapxydata.x[2]=-1
		mapxydata.x[3]=13
	else

	end
	WorldMapFrame.xyf.zuobiaoX = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf, "LEFT", mapxydata.x[1], mapxydata.x[2]},"玩家 X:","OUTLINE",mapxydata.x[3])
	WorldMapFrame.xyf.zuobiaoX:SetTextColor(0, 1, 0, 1);
	WorldMapFrame.xyf.zuobiaoXV = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.zuobiaoX, "RIGHT", 0, 0},"","OUTLINE",mapxydata.x[3]+1)
	WorldMapFrame.xyf.zuobiaoXV:SetTextColor(1, 1, 0, 1);

	WorldMapFrame.xyf.zuobiaoY = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.zuobiaoX, "RIGHT", 44, 0},"Y:","OUTLINE",mapxydata.x[3])
	WorldMapFrame.xyf.zuobiaoY:SetTextColor(0, 1, 0, 1);
	WorldMapFrame.xyf.zuobiaoYV = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.zuobiaoY, "RIGHT", 0, 0},"","OUTLINE",mapxydata.x[3]+1)
	WorldMapFrame.xyf.zuobiaoYV:SetTextColor(1, 1, 0, 1);

	WorldMapFrame.xyf.shubiaoX = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.zuobiaoY, "RIGHT", 56, 0},"鼠标 X:","OUTLINE",mapxydata.x[3])
	WorldMapFrame.xyf.shubiaoX:SetTextColor(0, 1, 0, 1);
	WorldMapFrame.xyf.shubiaoXV = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.shubiaoX, "RIGHT", 0, 0},"","OUTLINE",mapxydata.x[3]+1)
	WorldMapFrame.xyf.shubiaoXV:SetTextColor(1, 1, 0, 1);

	WorldMapFrame.xyf.shubiaoY = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.shubiaoX, "RIGHT", 44, 0},"Y:","OUTLINE",mapxydata.x[3])
	WorldMapFrame.xyf.shubiaoY:SetTextColor(0, 1, 0, 1);
	WorldMapFrame.xyf.shubiaoYV = PIGFontString(WorldMapFrame.xyf,{"LEFT", WorldMapFrame.xyf.shubiaoY, "RIGHT", 0, 0},"","OUTLINE",mapxydata.x[3]+1)
	WorldMapFrame.xyf.shubiaoYV:SetTextColor(1, 1, 0, 1);

	WorldMapFrame:HookScript("OnUpdate", function(self)
		local mapinfo = C_Map.GetBestMapForUnit("player"); 
		if not mapinfo then return end
		local pos = C_Map.GetPlayerMapPosition(mapinfo,"player");
		if not pos then return end
		--local zuobiaoBB = C_Map.GetMapInfo(mapinfo).name, 
		WorldMapFrame.xyf.zuobiaoXV:SetFormattedText("%.1f", pos.x*100);
		WorldMapFrame.xyf.zuobiaoYV:SetFormattedText("%.1f", pos.y*100);
		local xxx, yyy = MouseXY()
		if xxx and yyy then
			WorldMapFrame.xyf.shubiaoXV:SetFormattedText("%.1f", xxx*100);
			WorldMapFrame.xyf.shubiaoYV:SetFormattedText("%.1f", yyy*100);
		end
	end);
end
----
function Mapfun.WorldMap_Wind()
	if not PIGA["Map"]["WorldMapWind"] then return end
	if PIG_MaxTocversion() then
		---SetCVar("miniWorldMap", 0)
		UIPanelWindows["WorldMapFrame"] = nil
		WorldMapFrame:SetIgnoreParentScale(false)
		WorldMapFrame.ScrollContainer.GetCursorPosition = function(f)
		    local x,y = MapCanvasScrollControllerMixin.GetCursorPosition(f);
		    local s = WorldMapFrame:GetScale() * UIParent:GetScale()
		    return x/s, y/s;
		end
		hooksecurefunc(WorldMapFrame.BlackoutFrame, "Show", function()
			WorldMapFrame.BlackoutFrame:Hide()
		end)
		local PIG_SetPoint=Create.PIG_SetPoint
		hooksecurefunc(WorldMapFrame, "OnFrameSizeChanged", function(self)
			if PIGA["Blizzard_UI"]["WorldMapFrame"] and PIGA["Blizzard_UI"]["WorldMapFrame"]["Point"] then
				PIG_SetPoint("WorldMapFrame",true)
			end
		end)
	end
end
---
function Mapfun.WorldMap_LVSkill()
	if not PIGA["Map"]["WorldMapLV"] and not PIGA["Map"]["WorldMapSkill"] then return end
	local floor = math.floor
	local format = string.format
	local zoneData=addonTable.Mapfun.zoneData
	local AreaLabel_OnUpdate = function(self)
		self:SetScale(0.6)
		self:ClearLabel(MAP_AREA_LABEL_TYPE.AREA_NAME)
		local map = self.dataProvider:GetMap()
		if (map:IsCanvasMouseFocus()) then
			local name, description
			local mapID = map:GetMapID()
			local normalizedCursorX, normalizedCursorY = MouseXY()
			if mapID and normalizedCursorX and normalizedCursorY then
				local positionMapInfo = C_Map.GetMapInfoAtPosition(mapID, normalizedCursorX, normalizedCursorY)	
				if (positionMapInfo and (positionMapInfo.mapID ~= mapID)) then
					name = positionMapInfo.name
					local playerMinLevel, playerMaxLevel, playerminFish, playerFaction
					--local playerMinLevel, playerMaxLevel, petMinLevel, petMaxLevel = C_Map.GetMapLevels(positionMapInfo.mapID)
					if (zoneData[positionMapInfo.mapID]) then
						playerMinLevel = zoneData[positionMapInfo.mapID].min
						playerMaxLevel = zoneData[positionMapInfo.mapID].max
						playerminFish = zoneData[positionMapInfo.mapID].minFish
						playerFaction = zoneData[positionMapInfo.mapID].faction
					end
					if (playerFaction) then 
						local englishFaction, localizedFaction = UnitFactionGroup("player")
						if (playerFaction == "Alliance") then 
							description = format(FACTION_CONTROLLED_TERRITORY, FACTION_ALLIANCE) 
						elseif (playerFaction == "Horde") then 
							description = format(FACTION_CONTROLLED_TERRITORY, FACTION_HORDE) 
						end 
						if (englishFaction == playerFaction) then 
							description = "|cff00FF00" .. description .. "|r"
						else
							description = "|cffFF0000" .. description .. "|r"
						end 
					end
					if (name and playerMinLevel and playerMaxLevel and (playerMinLevel > 0) and (playerMaxLevel > 0)) then
						local playerLevel = UnitLevel("player")
						local colorbb="|cffFFFF00"
						if (playerLevel < playerMinLevel) then
							colorbb="|cffFF0000"
						elseif (playerLevel > playerMaxLevel+2) then
							colorbb="|cff808080"
						elseif (playerLevel > playerMaxLevel) then
							colorbb="|cff00FF00"
						end
						if PIGA["Map"]["WorldMapLV"] then
							name = name..colorbb.." ("..playerMinLevel.."-"..playerMaxLevel..")|r"
						end
						if PIGA["Map"]["WorldMapSkill"] then
							if playerminFish then
								name = name.."\n渔点|cff00FFFF("..playerminFish..")|r"
							end
						end
					end
				else
					name = MapUtil.FindBestAreaNameAtMouse(mapID, normalizedCursorX, normalizedCursorY)
				end
				if name then
					self:SetLabel(MAP_AREA_LABEL_TYPE.AREA_NAME, name, description)
				end
			end
		end
		self:EvaluateLabels()
	end
	for provider in next, WorldMapFrame.dataProviders do
		if provider.setAreaLabelCallback then
			provider.Label:HookScript("OnUpdate", AreaLabel_OnUpdate)
		end
	end
end
---战争迷雾
local function Updata_zoneTex(self,fullUpdate,exploredTextureInfo,TILE_SIZE_WIDTH,TILE_SIZE_HEIGHT,fog,yanse)
	local newR, newG, newB, newA=unpack(yanse)
	local numTexturesWide = ceil(exploredTextureInfo.textureWidth/TILE_SIZE_WIDTH);
	local numTexturesTall = ceil(exploredTextureInfo.textureHeight/TILE_SIZE_HEIGHT);
	local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight;
	for j = 1, numTexturesTall do
		if ( j < numTexturesTall ) then
			texturePixelHeight = TILE_SIZE_HEIGHT;
			textureFileHeight = TILE_SIZE_HEIGHT;
		else
			texturePixelHeight = mod(exploredTextureInfo.textureHeight, TILE_SIZE_HEIGHT);
			if ( texturePixelHeight == 0 ) then
				texturePixelHeight = TILE_SIZE_HEIGHT;
			end
			textureFileHeight = 16;
			while(textureFileHeight < texturePixelHeight) do
				textureFileHeight = textureFileHeight * 2;
			end
		end
		for k = 1, numTexturesWide do
			local texture = self.overlayTexturePool:Acquire();
			if ( k < numTexturesWide ) then
				texturePixelWidth = TILE_SIZE_WIDTH;
				textureFileWidth = TILE_SIZE_WIDTH;
			else
				texturePixelWidth = mod(exploredTextureInfo.textureWidth, TILE_SIZE_WIDTH);
				if ( texturePixelWidth == 0 ) then
					texturePixelWidth = TILE_SIZE_WIDTH;
				end
				textureFileWidth = 16;
				while(textureFileWidth < texturePixelWidth) do
					textureFileWidth = textureFileWidth * 2;
				end
			end
			texture:SetWidth(texturePixelWidth);
			texture:SetHeight(texturePixelHeight);
			texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight);
			texture:SetPoint("TOPLEFT", exploredTextureInfo.offsetX + (TILE_SIZE_WIDTH * (k-1)), -(exploredTextureInfo.offsetY + (TILE_SIZE_HEIGHT * (j - 1))));
			texture:SetTexture(exploredTextureInfo.fileDataIDs[((j - 1) * numTexturesWide) + k], nil, nil, "TRILINEAR");
			if fog then
				texture:SetVertexColor(newR, newG, newB, newA)
			else
				texture:SetVertexColor(1, 1, 1, 1)
			end
			if exploredTextureInfo.isShownByMouseOver then
				texture:SetDrawLayer("ARTWORK", 1);
				texture:Hide();
				local highlightRect = self.highlightRectPool:Acquire();
				highlightRect:SetSize(exploredTextureInfo.hitRect.right - exploredTextureInfo.hitRect.left, exploredTextureInfo.hitRect.bottom - exploredTextureInfo.hitRect.top);
				highlightRect:SetPoint("TOPLEFT", exploredTextureInfo.hitRect.left, -exploredTextureInfo.hitRect.top);
				highlightRect.index = i;
				highlightRect.texture = texture;
			else
				texture:SetDrawLayer("ARTWORK", 0);
				texture:Show();
				if fullUpdate then
					self.textureLoadGroup:AddTexture(texture);
				end
			end
		end
	end
end
function Mapfun.WorldMap_Miwu()
	if not PIGA["Map"]["WorldMapMiwu"] then return end
	local Reveal=addonTable.Mapfun.Reveal
	local function PIGRefreshOverlays(self,fullUpdate,yanse)
		local yanse=yanse or PIGA["Map"]["WorldMapMiwuColor"] or Mapfun.WorldMapMiwumorenColor
		self.overlayTexturePool:ReleaseAll();
		local mapID = self:GetMap():GetMapID();
		if not mapID then return end
		local uiMapArtID = C_Map.GetMapArtID(mapID)
		if not uiMapArtID or not Reveal[uiMapArtID] then return end
		local TextureInfo = Reveal[uiMapArtID]
		self.layerIndex = self:GetMap():GetCanvasContainer():GetCurrentLayerIndex();
		local layers = C_Map.GetMapArtLayers(mapID);
		local layerInfo = layers[self.layerIndex];
		local TILE_SIZE_WIDTH = layerInfo.tileWidth;
		local TILE_SIZE_HEIGHT = layerInfo.tileHeight;
		for Point,TextureID in pairs(TextureInfo) do
			local width, height, offsetX, offsetY = strsplit(":", Point)
			local fileDataIDs = { strsplit(",", TextureID) }
			local exploredTextureInfo={
				["textureWidth"]=width,
				["textureHeight"]=height,
				["offsetX"]=offsetX,
				["offsetY"]=offsetY,
				["fileDataIDs"]=fileDataIDs,
			}
			Updata_zoneTex(self,fullUpdate,exploredTextureInfo,TILE_SIZE_WIDTH,TILE_SIZE_HEIGHT,true,yanse)
		end
		local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(mapID);
		if exploredMapTextures then
			for i, exploredTextureInfo in ipairs(exploredMapTextures) do
				Updata_zoneTex(self,fullUpdate,exploredTextureInfo,TILE_SIZE_WIDTH,TILE_SIZE_HEIGHT,false,yanse)
			end
		end
	end
	for pin in WorldMapFrame:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
		hooksecurefunc(pin, "RefreshOverlays", function(self,fullUpdate)
			PIGRefreshOverlays(self,fullUpdate)
		end)
	end
	function Mapfun.SetmiwuColor(yanse)
		for pin in WorldMapFrame:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
			PIGRefreshOverlays(pin,false,yanse)
		end
	end
end