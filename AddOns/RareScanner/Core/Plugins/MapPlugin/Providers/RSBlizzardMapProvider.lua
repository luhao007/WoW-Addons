-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

local RSBlizzardMapProvider = private.NewLib("RareScannerBlizzardMapProvider")

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
local RSMap = private.ImportLib("RareScannerMap")
local RSTooltip = private.ImportLib("RareScannerTooltip")
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSWorldMap = private.ImportLib("RareScannerWorldMap")

-- RareScanner services libraries
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")

local activeVignettePins = setmetatable({}, { __mode = "k" })

local function PlayPinAnimation(pin, entityID, mapID, x, y, forced)
	if (not pin.RSPingAnim) then
        local ag = pin:CreateAnimationGroup()
        ag:SetLooping("NONE")

        local a1 = ag:CreateAnimation("Alpha")
        a1:SetFromAlpha(0)
        a1:SetToAlpha(1)
        a1:SetDuration(0.1)
        a1:SetOrder(1)
        
        local a2 = ag:CreateAnimation("Alpha")
        a2:SetFromAlpha(1)
        a2:SetToAlpha(0)
        a2:SetStartDelay(0.1)
        a2:SetDuration(0.5)
        a2:SetOrder(1)
        
        local s1 = ag:CreateAnimation("Scale")
        s1:SetScaleFrom(0.75, 0.75)
        s1:SetScaleTo(1.75, 1.75)
        s1:SetDuration(0.25)
        s1:SetOrder(1)
        
        local a3 = ag:CreateAnimation("Alpha")
        a3:SetFromAlpha(0)
        a3:SetToAlpha(1)
        a3:SetDuration(0.5)
        a3:SetOrder(1)
        
        local a4 = ag:CreateAnimation("Alpha")
        a4:SetFromAlpha(1)
        a4:SetToAlpha(0)
        a4:SetStartDelay(0.5)
        a4:SetDuration(0.5)
        a4:SetOrder(1)
        
        local s2 = ag:CreateAnimation("Scale")
        s2:SetScaleFrom(1, 1)
        s2:SetScaleTo(1.5, 1.5)
        s2:SetDuration(0.75)
        s2:SetOrder(1)
        
        -- Callback para controlar loops
        ag:SetScript("OnLoop", function(self)
            self.loops = (self.loops or 0) + 1
            if (self.loops >= 3) then
            	if (not forced) then
                	RSRecentlySeenTracker.DeletePendingAnimation(entityID, mapID, x, y)
                end
                self:Stop()
                self:SetLooping("NONE")
            end
        end)

        pin.RSPingAnim = ag
    end
    
    local ag = pin.RSPingAnim
    if (ag and (forced or RSRecentlySeenTracker.ShouldPlayAnimation(entityID, mapID, x, y))) then
        ag.loops = 0
        ag:SetLooping("BOUNCE")
        ag:Play()
    end
end

local function GetEntityID(pin)
	local entityID
	-- VignettePinBaseMixin
	if (pin.GetObjectGUID) then
		local guid = pin:GetObjectGUID()
	    local _, _, _, _, _, vignetteObjectID = strsplit("-", guid)
	    entityID = tonumber(vignetteObjectID)
	-- AreaPOIPinMixin
	elseif (pin.poiInfo) then
		entityID = pin.poiInfo.areaPoiID
	else
		return
	end
	
    local finalEntityID = tonumber(RSGeneralDB.GetFinalEntityID(entityID))
    return finalEntityID;
end

local function IsPinFiltered(entityID)
    local filtered = false
    if (RSNpcDB.GetInternalNpcInfo(entityID)) then
        filtered = RSConfigDB.IsNpcFiltered(entityID)
    elseif (RSContainerDB.GetInternalContainerInfo(entityID)) then
        filtered = RSConfigDB.IsContainerFiltered(entityID)
    elseif (RSEventDB.GetInternalEventInfo(entityID)) then
        filtered = RSConfigDB.IsEventFiltered(entityID)
    end
    
    if (not filtered and RSGeneralDB.GetWorldMapTextFilter()) then
    	local name = RSNpcDB.GetNpcName(entityID) or RSContainerDB.GetContainerName(entityID) or RSEventDB.GetEventName(entityID)
		if (name and not RSUtils.Contains(name, RSGeneralDB.GetWorldMapTextFilter())) then
			filtered = true
		end
	end
    
    return filtered
end

local function HidePin(pin)
	if (pin.RSPingAnim) then
        pin.RSPingAnim:Stop()
    end
    
	pin:SetAlpha(0)
end

local function ShowPin(pin)
	pin:SetAlpha(1)
end

local function OnPinMouseEnter(pin)
	if (pin:GetAlpha() == 0) then
		GameTooltip:Hide()
	elseif (pin.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then
        GameTooltip:Hide()
       	RSTooltip.ShowSimpleBlizzardPinTooltip(pin)
    end
end

local function OnPinMouseLeave(pin)
    if (pin.POI and RSConfigDB.IsShowingTooltipsOnIngameIcons()) then
		if (RSTooltip.HideTooltip(pin.tooltip)) then
			pin.tooltip = nil
		end
    end
end

local function OnPinMouseDown(pin, button)
    if not pin.POI or not RSConfigDB.IsShowingTooltipsOnIngameIcons() then return end

    C_Timer.After(0, function()
	    if (button == "LeftButton" and IsShiftKeyDown() and IsAltKeyDown()) then
	    -- Toggle filtered state
	        if (pin.POI.isNpc) then
	            if RSConfigDB.GetDefaultNpcFilter() == RSConstants.ENTITY_FILTER_ALERTS then
	                RSConfigDB.SetNpcFiltered(pin.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
	            else
	                RSConfigDB.SetNpcFiltered(pin.POI.entityID)
	            end
	        elseif (pin.POI.isContainer) then
	            if RSConfigDB.GetDefaultContainerFilter() == RSConstants.ENTITY_FILTER_ALERTS then
	                RSConfigDB.SetContainerFiltered(pin.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
	            else
	                RSConfigDB.SetContainerFiltered(pin.POI.entityID)
	            end
	        elseif (pin.POI.isEvent) then
	            if RSConfigDB.GetDefaultEventFilter() == RSConstants.ENTITY_FILTER_ALERTS then
	                RSConfigDB.SetEventFiltered(pin.POI.entityID, RSConstants.ENTITY_FILTER_ALL)
	            else
	                RSConfigDB.SetEventFiltered(pin.POI.entityID)
	            end
	        end
	        
	        HidePin(pin)
	        OnPinMouseLeave(pin)
	        RSMinimap.RefreshEntityState(pin.POI.entityID)
	    elseif (button == "LeftButton" and not IsShiftKeyDown() and IsAltKeyDown()) then
	        -- If already showing a guide toggle it first
			if (RSWorldMap:GetNumActivePinsByTemplate("RSGuideTemplate") > 0) then	
				RSWorldMap:RemoveAllPinsByTemplate("RSGuideTemplate");
									
				local guideEntityID = RSGeneralDB.GetGuideActive()
				if (guideEntityID) then
					-- If same guide showing then disable it
					if (guideEntityID ~= pin.POI.entityID) then
						RSGeneralDB.SetGuideActive(pin.POI.entityID)
						RareScannerDataProviderMixin:ShowGuideLayer(pin.POI.entityID, pin.POI.mapID)
					else
						RSGeneralDB.RemoveGuideActive()
					end
				end
			-- Otherwise show it
			else
				RSGeneralDB.SetGuideActive(pin.POI.entityID)
				RareScannerDataProviderMixin:ShowGuideLayer(pin.POI.entityID, pin.POI.mapID)
			end
	        
	        -- Refresca minimapa de forma segura
	        RSMinimap.RefreshAllData(true)
	    end
	end)
end

local function OnPinReleased(pin)
	pin:SetAlpha(1)
    pin.POI = nil
    pin.RSHooksInstalled = nil

    if (pin.RSPingAnim) then
        pin.RSPingAnim:Stop()
        pin.RSPingAnim = nil
    end

    if (pin.tooltip) then
        RSTooltip.HideTooltip(pin.tooltip)
        pin.tooltip = nil
    end
    
    activeVignettePins[pin] = nil
end

local function AcquirePin(pin)
	if not pin then return end

    local entityID = GetEntityID(pin)
    if not entityID then return end

    if (IsPinFiltered(entityID) and not RSConfigDB.IsShowingFilteredIngameMapIcons()) then
        HidePin(pin)
    else        
		local mapID = pin.GetMap and pin:GetMap() and pin:GetMap():GetMapID() or activeVignettePins[pin]
		
		local POI
		-- VignettePinBaseMixin
		if (pin.GetObjectGUID) then
        	POI = entityID and RSMap.GetWorldMapPOI(pin:GetObjectGUID(), pin.vignetteInfo, mapID)
        -- AreaPOIPinMixin
        elseif (pin.poiInfo) then
        	local objectGUID = string.format("a-a-a-a-a-%s-%s", pin.poiInfo.areaPoiID, time())
			pin.poiInfo.type = "";
        	POI = entityID and RSMap.GetWorldMapPOI(objectGUID, pin.poiInfo, mapID)
        end
        
        if (POI) then
	        pin.POI = POI
	        	        
	        ShowPin(pin)
	        
	        local forceAnimation = pin.POI.name and RSGeneralDB.GetWorldMapTextFilter() and RSUtils.Contains(pin.POI.name, RSGeneralDB.GetWorldMapTextFilter())
	        local x, y = pin:GetPosition()
	        PlayPinAnimation(pin, entityID, mapID, x, y, forceAnimation)
	
	        if (not pin.RSHooksInstalled) then
	        	if (not pin.hasTooltip) then
	        		pin:EnableMouseMotion(true);
	        	end
	        	
	            pin:HookScript("OnEnter", OnPinMouseEnter)
	            pin:HookScript("OnLeave", OnPinMouseLeave)
	            pin:HookScript("OnMouseDown", OnPinMouseDown)
	            
	            pin.RSHooksInstalled = true
	        end
		end
    end
end

local function OnVignettePinAcquired(pin, vignetteGUID, vignetteInfo, frameIndex)
    AcquirePin(pin)
    
    activeVignettePins[pin] = pin:GetMap():GetMapID()
end

function RSBlizzardMapProvider:AddHooks()
	local mixins = { VignettePinMixin, VignettePinPOIButtonMixin, AreaPOIPinMixin }

	for _, mixin in ipairs(mixins) do
		hooksecurefunc(mixin, "OnAcquired", OnVignettePinAcquired)
		hooksecurefunc(mixin, "OnReleased", OnPinReleased)
	end
	
	hooksecurefunc(WorldMapFrame, "Show", function()
        RSBlizzardMapProvider:RefreshAllData()
    end)
end

function RSBlizzardMapProvider:RefreshAllData()
	if (not WorldMapFrame or not WorldMapFrame:IsShown()) then return end
	
	C_Timer.After(0, function()
		for pin in pairs(activeVignettePins) do
	        -- Protección extra por si el pin ya fue recolectado por GC o destruido
	        if (type(pin) ~= "table" or (not pin.poiInfo and not pin.GetObjectGUID)) then
	            activeVignettePins[pin] = nil
	        else
		        local entityID = GetEntityID(pin)
		        if (not entityID) then
		            activeVignettePins[pin] = nil
		        else
		        	AcquirePin(pin)
		        end
	        end
		end
	end)
end