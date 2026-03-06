local ADDON_NAME, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

ns.BountifulDelves = (ns.LOCALE_BOUNTIFUL_DELVES and (ns.LOCALE_BOUNTIFUL_DELVES[ns.locale] or ns.LOCALE_BOUNTIFUL_DELVES.enUS)) or "Bountiful Delves"
ns.AfterCombatDelvesInfo = (ns.LOCALE_AFTER_COMBAT_DELVES_INFO and (ns.LOCALE_AFTER_COMBAT_DELVES_INFO[ns.locale] or ns.LOCALE_AFTER_COMBAT_DELVES_INFO.enUS)) or "Delve icons will automatically reappear on the continent map after combat"
ns.AfterCombatDelves = (ns.LOCALE_AFTER_COMBAT_DELVES and (ns.LOCALE_AFTER_COMBAT_DELVES[ns.locale] or ns.LOCALE_AFTER_COMBAT_DELVES.enUS)) or "Delve icons will automatically reappear on the continent map after combat"

ns.DelveContinent = CreateFromMixins(CVarMapCanvasDataProviderMixin, MapCanvasDataProviderMixin)
ns.DelveContinent:Init("showContinentDelvesOnMapNotes")

ns.MN_DelvePinInfo = setmetatable({}, { __mode = "k" })
ns.MN_DelvePins = ns.MN_DelvePins or setmetatable({}, { __mode = "k" })

function ns.DelveContinent:GetBountyInfo()
    return nil
end

ns.continentDelveToggles = {
    [2274] = "showContinentKhazAlgar",
    [13] = "showContinentEasternKingdom",
    [2537] = "showContinentQuelThalas",
}

ns.zoneDelveToggles = {
    -- Khaz Algar zones
    [2248] = "showZoneKhazAlgar",
    [2214] = "showZoneKhazAlgar",
    [2215] = "showZoneKhazAlgar",
    [2255] = "showZoneKhazAlgar",
    [2256] = "showZoneKhazAlgar",
    [2213] = "showZoneKhazAlgar",
    [2216] = "showZoneKhazAlgar",
    [2369] = "showZoneKhazAlgar",
    [2322] = "showZoneKhazAlgar",
    [2346] = "showZoneKhazAlgar",
    [2371] = "showZoneKhazAlgar",
    [2472] = "showZoneKhazAlgar",

    -- Quel'Thalas zones
    [2395] = "showZoneQuelThalas",
    [2437] = "showZoneQuelThalas",
    [2424] = "showZoneQuelThalas",
    [2405] = "showZoneQuelThalas",
    [2444] = "showZoneQuelThalas",
    [2413] = "showZoneQuelThalas",
    [2536] = "showZoneQuelThalas",
    [2576] = "showZoneQuelThalas",
}

ns.capitalDelveToggles = {
    [2393] = "showCapitals",
}

local function MN_ApplyDelveScaleAlpha(pin, pinInfo)
    local db = ns.Addon and ns.Addon.db and ns.Addon.db.profile
    if not db or not pinInfo or not pin then return end

    local kind = pinInfo.mnMapNotesKind
    if kind ~= "zone" and kind ~= "continent" and kind ~= "capital" then
        return
    end

    local scale, alpha

    if kind == "continent" then
        scale = db.continentScale or 1
        alpha = db.continentAlpha or 1
    elseif kind == "capital" then
        scale = db.CapitalsInstanceScale or 1
        alpha = db.CapitalsInstanceAlpha or 1
    else
        local atlas = pinInfo.atlasName
        local isBountiful = atlas and atlas:lower():find("bountiful")
        scale = isBountiful and (db.ZoneScaleBountyDelve or 1) or (db.ZoneScaleDelve or 1)
        alpha = isBountiful and (db.ZoneAlphaBountyDelve or 1) or (db.ZoneAlphaDelve or 1)
    end

    pin:SetAlpha(alpha)

    if pin.Icon then
        pin.Icon:SetScale(scale)
        pin.Icon:SetAlpha(alpha)
    end

    if pin.Texture then
        pin.Texture:SetScale(scale)
        pin.Texture:SetAlpha(alpha)
    end

    if pin.HighlightTexture then
        pin.HighlightTexture:SetAlpha(alpha)
    end
end

local function MN_SetDelvePinsCombatState(inCombat)
    if not ns.MN_DelvePins then return end

    for pin in pairs(ns.MN_DelvePins) do
        if pin then
            if inCombat then
                if pin.EnableMouse then pin:EnableMouse(false) end
                if pin.SetAlpha then pin:SetAlpha(0) end
                if pin.Icon and pin.Icon.SetAlpha then pin.Icon:SetAlpha(0) end
                if pin.Texture and pin.Texture.SetAlpha then pin.Texture:SetAlpha(0) end
                if pin.HighlightTexture and pin.HighlightTexture.SetAlpha then pin.HighlightTexture:SetAlpha(0) end
            else
                if pin.EnableMouse then pin:EnableMouse(true) end
                local info = pin.mnMapNotesPinInfo or ns.MN_DelvePinInfo[pin]
                if info then
                    MN_ApplyDelveScaleAlpha(pin, info)
                else
                    if pin.SetAlpha then pin:SetAlpha(1) end
                end
            end
        end
    end
end

local function MN_IsOurDelvePin(pinInfo)
    return pinInfo and pinInfo.dataProvider == ns.DelveProvider
end

local function MN_HookDelvePinsOnce()
    if ns.MN_DelvePinsHooked then return end
    if not DelveEntrancePinMixin then return end
    ns.MN_DelvePinsHooked = true

    hooksecurefunc(DelveEntrancePinMixin, "OnAcquired", function(pin, pinInfo)

        if not MN_IsOurDelvePin(pinInfo) then
            return
        end

        ns.MN_DelvePinInfo[pin] = pinInfo
        ns.MN_DelvePins[pin] = true
        pin.mnMapNotesPinInfo = pinInfo

        if InCombatLockdown() then
            if pin.EnableMouse then pin:EnableMouse(false) end
            if pin.SetAlpha then pin:SetAlpha(0) end
            if pin.Icon and pin.Icon.SetAlpha then pin.Icon:SetAlpha(0) end
            if pin.Texture and pin.Texture.SetAlpha then pin.Texture:SetAlpha(0) end
            if pin.HighlightTexture and pin.HighlightTexture.SetAlpha then pin.HighlightTexture:SetAlpha(0) end
            return
        end

        MN_ApplyDelveScaleAlpha(pin, pinInfo)
    end)

    hooksecurefunc(DelveEntrancePinMixin, "OnCanvasScaleChanged", function(pin)
        if InCombatLockdown() then return end
        local pinInfo = pin.mnMapNotesPinInfo or ns.MN_DelvePinInfo[pin]
        if pinInfo and MN_IsOurDelvePin(pinInfo) then
            MN_ApplyDelveScaleAlpha(pin, pinInfo)
        end
    end)
end

EventUtil.ContinueOnAddOnLoaded("Blizzard_WorldMap", function()
    pcall(MN_HookDelvePinsOnce)
end)

function ns.BlizzardDelvesAddFunction()
    if ns.BlizzDelveClick_Hooked then return end
    ns.BlizzDelveClick_Hooked = true

    hooksecurefunc(DelveEntrancePinMixin, "OnClick", function(self, button)
        if button ~= "MiddleButton" then return end
        if not ns.Addon or not ns.Addon.db or not ns.Addon.db.profile then return end
        if ns.Addon.db.profile.activate.HideMapNote then return end
        if not (self and self.poiInfo and self.poiInfo.areaPoiID) then return end

        local id = self.poiInfo.areaPoiID
        local target = (ns.BlizzDelveAreaPoisInfoIDs and ns.BlizzDelveAreaPoisInfoIDs[id]) or (ns.BlizzBountifulDelveAreaPoisInfoIDs and ns.BlizzBountifulDelveAreaPoisInfoIDs[id])
        if target then
            ns.MapNotesOpenMap(target)
        end
    end)
end

local function MN_AddDelveProvider()
    if ns.DelveProviderAdded then return end
    ns.DelveProviderAdded = true

    local provider = CreateFromMixins(ns.DelveContinent)
    WorldMapFrame:AddDataProvider(provider)

    ns.DelveProvider = provider

    if InCombatLockdown() then
        MN_SetDelvePinsCombatState(true)
    end

    if WorldMapFrame:IsShown() and provider.GetMap and provider:GetMap() then
        provider:RefreshAllData()
    end

    if not ns.DelveShowHooked then
        ns.DelveShowHooked = true
    end
end

local function MN_EnsureCombatWatcher()
    if ns.MN_DelveCombatWatcher then return end
    ns.MN_DelveCombatWatcher = CreateFrame("Frame")
    ns.MN_DelveCombatWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
    ns.MN_DelveCombatWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
    ns.MN_DelveCombatWatcher:SetScript("OnEvent", function(_, event)
        if event == "PLAYER_REGEN_DISABLED" then
            MN_SetDelvePinsCombatState(true)
        else
            MN_SetDelvePinsCombatState(false)
            if ns.DelveNeedsRefreshAfterCombat and ns.DelveProvider and ns.DelveProvider.RefreshAllData then
                ns.DelveNeedsRefreshAfterCombat = nil
                ns.DelveProvider:RefreshAllData()
            end
        end
    end)
end

EventUtil.ContinueOnAddOnLoaded("Blizzard_WorldMap", function()
    MN_EnsureCombatWatcher()
end)

EventUtil.ContinueOnAddOnLoaded("Blizzard_WorldMap", function()
    pcall(function() ns.BlizzardDelvesAddFunction() end)
end)

function ns.DelveContinent:OnShow()
    if CVarMapCanvasDataProviderMixin.OnShow then
        CVarMapCanvasDataProviderMixin.OnShow(self)
    end
    if InCombatLockdown() then
        MN_SetDelvePinsCombatState(true)
        ns.DelveNeedsRefreshAfterCombat = true
        return
    end
    self:RefreshAllData()
end

function ns.DelveContinent:OnMapChanged()
    if InCombatLockdown() then
        MN_SetDelvePinsCombatState(true)
        ns.DelveNeedsRefreshAfterCombat = true
        return
    end
    self:RefreshAllData()
end

function ns.DelveContinent:OnHide()
    if CVarMapCanvasDataProviderMixin.OnHide then
        CVarMapCanvasDataProviderMixin.OnHide(self)
    end
end

function ns.DelveContinent:OnEvent(event, ...)
    if CVarMapCanvasDataProviderMixin.OnEvent then
        CVarMapCanvasDataProviderMixin.OnEvent(self, event, ...)
    end
end

local function ConvertMapCoords(fromMapID, toMapID, x, y)
    local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(fromMapID, toMapID)
    if not minX then return end
    return Lerp(minX, maxX, x), Lerp(minY, maxY, y)
end

function ns.DelveContinent:RemoveAllData()
    local map = self:GetMap()
    if not map then return end

    map:RemoveAllPinsByTemplate("MapNotesContinentDelvePinTemplate")
    map:RemoveAllPinsByTemplate("MapNotesZoneDelvePinTemplate")

    if ns.MN_DelvePins then
        for pin in pairs(ns.MN_DelvePins) do
            ns.MN_DelvePins[pin] = nil
        end
    end
end

function ns.DelveContinent:RefreshAllData()
    local map = self:GetMap()
    local mapID = map and map.GetMapID and map:GetMapID() or nil
    local mapInfo = mapID and C_Map.GetMapInfo(mapID) or nil
    local isContinent = (mapInfo and mapInfo.mapType == Enum.UIMapType.Continent) or false
    local isZone = (mapInfo and mapInfo.mapType == Enum.UIMapType.Zone) or false
    local isCapital = ns.capitalDelveToggles and ns.capitalDelveToggles[mapID]

    if InCombatLockdown() then
        MN_SetDelvePinsCombatState(true)
        ns.DelveNeedsRefreshAfterCombat = true

        local act = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
        if act and act.InfoBlockedInCombat then

            local worldMapShown = WorldMapFrame and WorldMapFrame:IsShown()
            local isAllowedContinent = (mapID and ns.continentDelveToggles and ns.continentDelveToggles[mapID]) and true or false
            if worldMapShown and isContinent and isAllowedContinent then

                if not ns.DelveCombatMessageShown then
                    ns.DelveCombatMessageShown = true

                    if UIErrorsFrame then
                        UIErrorsFrame:AddMessage( ns.COLORED_ADDON_NAME .. "\n" .. ns.AfterCombatDelves, 1, 0.82, 0 )
                    end
                end

            end
        end

        return
    end

    MN_SetDelvePinsCombatState(false)

    if ns.Addon.db.profile.activate.HideMapNote then
        self:RemoveAllData()
        return
    end

    if not self:IsCVarSet() then
        self:RemoveAllData()
        return
    end

    if not map or not mapID then
        self:RemoveAllData()
        return
    end

    if isCapital then
        self:RemoveAllData()
        self:AddCapitalDelves(mapID)
        return
    end

    if isZone then
        self:RemoveAllData()
        self:AddZoneDelves(mapID)
        return
    end

    if not isContinent then
        self:RemoveAllData()
        return
    end

    self:RemoveAllData()
    self.parentBountiful = nil

    local parentDelves = C_AreaPoiInfo.GetDelvesForMap(mapID)
    if parentDelves and #parentDelves > 0 then
        for _, areaPoiID in ipairs(parentDelves) do
            local pInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, areaPoiID)
            local atlas = pInfo and pInfo.atlasName

            if atlas and atlas:lower():find("bountiful") then
                self.parentBountiful = self.parentBountiful or {}
                self.parentBountiful[areaPoiID] = true
            end
        end
    end

    self.parentHasBountiful = (self.parentBountiful ~= nil)

    local showNormal = ns.Addon.db.profile.showContinentDelves
    local showBountiful = ns.Addon.db.profile.showContinentBountyDelves
    if not showNormal and not showBountiful then
        self:RemoveAllData()
        return
    end

    local key = ns.continentDelveToggles[mapID]
    if key and not ns.Addon.db.profile[key] then return end

    local children = C_Map.GetMapChildrenInfo(mapID, nil, true)
    if not children then return end

    for _, child in ipairs(children) do
        if child and child.mapID then
            if mapID ~= 13 or child.mapID ~= 2537 then
                local minX = C_Map.GetMapRectOnMap(child.mapID, mapID)
                if minX then
                    self:ProjectDelves(mapID, child.mapID)
                end
            end
        end
    end
end

function ns.DelveContinent:IsCVarSet()
    if ns.Addon.db.profile.activate.HideMapNote then return false end

    local map = self.GetMap and self:GetMap()
    local mapID = map and map:GetMapID()
    local mapInfo = mapID and C_Map.GetMapInfo(mapID) or nil
    if not mapInfo then return true end

    local isContinent = mapInfo.mapType == Enum.UIMapType.Continent
    local isZone  = mapInfo.mapType == Enum.UIMapType.Zone

    local isCapital = ns.capitalDelveToggles and ns.capitalDelveToggles[mapID]
    if isCapital then
        if not ns.Addon.db.profile.showCapitalsDelve and not ns.Addon.db.profile.showCapitalsBountyDelve then
            return false
        end

        if not ns.Addon.db.profile[isCapital] then
            return false
        end
        return true
    end

    if isZone then
        if not ns.Addon.db.profile.showZoneDelve and not ns.Addon.db.profile.showZoneBountyDelve then
            return false
        end
        local key = ns.zoneDelveToggles and ns.zoneDelveToggles[mapID]
        if key and not ns.Addon.db.profile[key] then
            return false
        end
        return true
    end

    if isContinent then
        if not ns.Addon.db.profile.showContinentDelves and not ns.Addon.db.profile.showContinentBountyDelves then
            return false
        end

        local key = ns.continentDelveToggles and ns.continentDelveToggles[mapID]
        if key and not ns.Addon.db.profile[key] then
            return false
        end
        return true
    end

    return true
end

function ns.DelveContinent:AddCapitalDelves(capitalMapID)
    if InCombatLockdown() then return end

    local capKey = ns.capitalDelveToggles and ns.capitalDelveToggles[capitalMapID]
    if capKey and not ns.Addon.db.profile[capKey] then return end

    local map = self:GetMap()
    if not map then return end

    local showNormal = ns.Addon.db.profile.showCapitalsDelve
    local showBounty = ns.Addon.db.profile.showCapitalsBountyDelve
    if not showNormal and not showBounty then
        return
    end

    local delves = C_AreaPoiInfo.GetDelvesForMap(capitalMapID) or {}
    for _, delveID in ipairs(delves) do
        local info = C_AreaPoiInfo.GetAreaPOIInfo(capitalMapID, delveID)
        if info and info.position then
            local atlas = info.atlasName
            local isBountiful = atlas and atlas:lower():find("bountiful")

            if not ((isBountiful and not showBounty) or ((not isBountiful) and not showNormal)) then
                local pinInfo = CopyTable(info)
                pinInfo.dataProvider = self
                pinInfo.mnMapNotesKind = "capital" -- optional
                local pin = map:AcquirePin("MapNotesZoneDelvePinTemplate", pinInfo)
                if pin then
                    pin.mnMapNotesPinInfo = pinInfo
                    ns.MN_DelvePins[pin] = true
                    if InCombatLockdown() then MN_SetDelvePinsCombatState(true) end
                end
            end
        end
    end
end

function ns.DelveContinent:AddZoneDelves(zoneMapID)
    if InCombatLockdown() then return end

    local key = ns.zoneDelveToggles and ns.zoneDelveToggles[zoneMapID]
    if key and not ns.Addon.db.profile[key] then return end

    local map = self:GetMap()
    if not map then return end

    local showZoneNormal = ns.Addon.db.profile.showZoneDelve
    local showZoneBounty = ns.Addon.db.profile.showZoneBountyDelve
    if not showZoneNormal and not showZoneBounty then
        return
    end

    local delves = C_AreaPoiInfo.GetDelvesForMap(zoneMapID) or {}
    for _, delveID in ipairs(delves) do
        local info = C_AreaPoiInfo.GetAreaPOIInfo(zoneMapID, delveID)
        if info and info.position then
            local atlas = info.atlasName
            local isBountiful = atlas and atlas:lower():find("bountiful")

            if not ((isBountiful and not showZoneBounty) or ((not isBountiful) and not showZoneNormal)) then
                local pinInfo = CopyTable(info)
                pinInfo.dataProvider = self
                pinInfo.mnMapNotesKind = "zone"
                local pin = map:AcquirePin("MapNotesZoneDelvePinTemplate", pinInfo)
                if pin then
                    pin.mnMapNotesPinInfo = pinInfo
                    ns.MN_DelvePins[pin] = true
                    if InCombatLockdown() then MN_SetDelvePinsCombatState(true) end
                end
            end
        end
    end
end

function ns.DelveContinent:ProjectDelves(parentMapID, zoneMapID)
    if InCombatLockdown() then return end

    local showNormal = ns.Addon.db.profile.showContinentDelves
    local showBountiful = ns.Addon.db.profile.showContinentBountyDelves

    local delves = C_AreaPoiInfo.GetDelvesForMap(zoneMapID) or {}
    for _, delveID in ipairs(delves) do
        local info = C_AreaPoiInfo.GetAreaPOIInfo(zoneMapID, delveID)

        if info and info.position then
            local atlas = info.atlasName
            local isBountiful = atlas and atlas:lower():find("bountiful")

            if not ((isBountiful and not showBountiful) or ((not isBountiful) and not showNormal)) then

                if not (isBountiful and self.parentHasBountiful and parentMapID == 2537) then

                    local x, y = info.position:GetXY()
                    local newX, newY = ConvertMapCoords(zoneMapID, parentMapID, x, y)

                    if newX and newY
                       and newX >= 0 and newX <= 1
                       and newY >= 0 and newY <= 1 then

                        local pinInfo = CopyTable(info)
                        pinInfo.position = CreateVector2D(newX, newY)
                        pinInfo.dataProvider = self
                        pinInfo.mnMapNotesKind = "continent"

                        local map = self:GetMap()
                        local pin = map:AcquirePin("MapNotesContinentDelvePinTemplate", pinInfo)
                        if pin then
                            pin.mnMapNotesPinInfo = pinInfo
                            ns.MN_DelvePins[pin] = true
                            if InCombatLockdown() then MN_SetDelvePinsCombatState(true) end
                        end
                    end
                end
            end
        end
    end
end

EventUtil.ContinueOnAddOnLoaded("Blizzard_WorldMap", function()
    if InCombatLockdown() then
        if not ns.waitDelvesCombat then
            ns.waitDelvesCombat = CreateFrame("Frame")
            ns.waitDelvesCombat:RegisterEvent("PLAYER_REGEN_ENABLED")
            ns.waitDelvesCombat:SetScript("OnEvent", function(self)
                self:UnregisterAllEvents()
                ns.waitDelvesCombat = nil
                pcall(MN_AddDelveProvider)
            end)
        end
        return
    end

    MN_AddDelveProvider()
end)

function ns.RefreshContinentDelvesPins(opts)

    if not ns.DelveProvider or not ns.DelveProvider.GetMap then return end
    if not ns.DelveProvider:GetMap() then return end

    if InCombatLockdown() then
        ns.DelveNeedsRefreshAfterCombat = true
        if opts and opts.remove then
            ns.DelveRemoveRequestedAfterCombat = true
            ns.DelveRemoveWhichAfterCombat = ns.DelveRemoveWhichAfterCombat or {}
            ns.DelveRemoveWhichAfterCombat.zone = true
            ns.DelveRemoveWhichAfterCombat.continent = true
        end
        return
    end

    if opts and opts.remove then
        ns.DelveProvider:RemoveAllData()
    else
        ns.DelveProvider:RefreshAllData()
    end
end

function ns.RefreshCapitalsDelvesOnly(opts)
    if not ns.DelveProvider or not ns.DelveProvider.GetMap then return end
    local map = ns.DelveProvider:GetMap()
    if not map then return end

    if InCombatLockdown() then
      ns.DelveNeedsRefreshAfterCombat = true
      if opts and opts.remove then
        ns.DelveRemoveRequestedAfterCombat = true
        ns.DelveRemoveWhichAfterCombat = ns.DelveRemoveWhichAfterCombat or {}
        ns.DelveRemoveWhichAfterCombat.zone = true
      end
      return
    end

    if opts and opts.remove then
        map:RemoveAllPinsByTemplate("MapNotesZoneDelvePinTemplate")
    else
        ns.DelveProvider:RefreshAllData()
    end
end

function ns.RefreshZoneDelvesOnly(opts)
    if not ns.DelveProvider or not ns.DelveProvider.GetMap then return end
    local map = ns.DelveProvider:GetMap()
    if not map then return end

    if InCombatLockdown() then
        ns.DelveNeedsRefreshAfterCombat = true
        if opts and opts.remove then
            ns.DelveRemoveRequestedAfterCombat = true
            ns.DelveRemoveWhichAfterCombat = ns.DelveRemoveWhichAfterCombat or {}
            ns.DelveRemoveWhichAfterCombat.zone = true
        end
        return
    end

    if opts and opts.remove then
        map:RemoveAllPinsByTemplate("MapNotesZoneDelvePinTemplate")
    else
        ns.DelveProvider:RefreshAllData()
    end
end

function ns.RefreshContinentDelvesOnly(opts)
    if not ns.DelveProvider or not ns.DelveProvider.GetMap then return end
    local map = ns.DelveProvider:GetMap()
    if not map then return end

    if InCombatLockdown() then
        ns.DelveNeedsRefreshAfterCombat = true
        if opts and opts.remove then
            ns.DelveRemoveRequestedAfterCombat = true
            ns.DelveRemoveWhichAfterCombat = ns.DelveRemoveWhichAfterCombat or {}
            ns.DelveRemoveWhichAfterCombat.continent = true
        end
        return
    end

    if opts and opts.remove then
        map:RemoveAllPinsByTemplate("MapNotesContinentDelvePinTemplate")
    else
        ns.DelveProvider:RefreshAllData()
    end
end