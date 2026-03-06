local ADDON_NAME, ns = ...

ns.AreaPOIHooked = ns.AreaPOIHooked or setmetatable({}, { __mode = "k" })

local function MN_Post(fn)
  if type(fn) ~= "function" then return end
  C_Timer.After(0, function() pcall(fn) end)
end

function ns.QueueRemovePOIs()
  if not (WorldMapFrame and WorldMapFrame:IsShown()) then return end

  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg or cfg.HideMapNote then return end

  if InCombatLockdown and InCombatLockdown() then
    ns._RemovePOIsAfterCombat = true

    if not ns._RemovePOIsCombatFrame then
      ns._RemovePOIsCombatFrame = CreateFrame("Frame")
      ns._RemovePOIsCombatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
      ns._RemovePOIsCombatFrame:SetScript("OnEvent", function(self)
        self:UnregisterAllEvents()
        ns._RemovePOIsCombatFrame = nil

        if ns._RemovePOIsAfterCombat then
          ns._RemovePOIsAfterCombat = nil
          ns.QueueRemovePOIs()
        end
      end)
    end

    return
  end

  if ns._RemovePOIsQueued then return end
  ns._RemovePOIsQueued = true

  MN_Post(function()
    ns._RemovePOIsQueued = nil
    if ns.RemovePOIs then ns.RemovePOIs() end
  end)
end

local function MN_SafeSetShown(pin, shown)
  if not pin then return end
  if InCombatLockdown and InCombatLockdown() then return end
  if pin.IsForbidden and pin:IsForbidden() then return end
  if pin.IsProtected and pin:IsProtected() then return end

  local want = shown and true or false

  if want then
    if pin.SetAlpha then pin:SetAlpha(1) end
    if pin.EnableMouse then pin:EnableMouse(true) end
    if pin.SetHitRectInsets then pin:SetHitRectInsets(0, 0, 0, 0) end
  else
    if pin.SetAlpha then pin:SetAlpha(0) end
    if pin.EnableMouse then pin:EnableMouse(false) end
    if pin.SetHitRectInsets then
      local w = (pin.GetWidth and pin:GetWidth()) or 0
      local h = (pin.GetHeight and pin:GetHeight()) or 0
      pin:SetHitRectInsets(w, 0, h, 0)
    end
  end
end

local function MN_GetVignetteIDFromPin(pin)
  if not pin then return nil end
  if pin.vignetteGUID and C_VignetteInfo and C_VignetteInfo.GetVignetteInfo then
    local ok, info = pcall(C_VignetteInfo.GetVignetteInfo, pin.vignetteGUID)
    if ok and info and info.vignetteID then
      return info.vignetteID
    end
  end
  return pin.vignetteID
end

local function MN_IsVignettePin(pin)
  return pin and (pin.vignetteGUID or pin.vignetteID)
end

local function MN_ApplyVignetteVisibility(pin)
  if not MN_IsVignettePin(pin) then return end
  ns.QueueRemovePOIs()
end

if VignettePinMixin then
  if VignettePinMixin.SetVignette then
    hooksecurefunc(VignettePinMixin, "SetVignette", MN_ApplyVignetteVisibility)
  end
  if VignettePinMixin.OnAcquired then
    hooksecurefunc(VignettePinMixin, "OnAcquired", MN_ApplyVignetteVisibility)
  end
  if VignettePinMixin.OnRefresh then
    hooksecurefunc(VignettePinMixin, "OnRefresh", MN_ApplyVignetteVisibility)
  end
end

local function MN_MapHasRelevantActivePins()
  if not (WorldMapFrame and WorldMapFrame.pinPools) then return false end

  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg or (not cfg.RemoveBlizzPOIs and not cfg.RemoveBlizzPOIsZidormi) then
    return false
  end

  ns.BlizzAreaPoisLookup = ns.BlizzAreaPoisLookup or {}
  if next(ns.BlizzAreaPoisLookup) == nil then
    for _, poiID in pairs(ns.BlizzAreaPoisInfo or {}) do
      if poiID then ns.BlizzAreaPoisLookup[poiID] = true end
    end
  end

  ns.BlizzAreaPoisLookupZidormi = ns.BlizzAreaPoisLookupZidormi or {}
  if next(ns.BlizzAreaPoisLookupZidormi) == nil then
    for _, poiID in pairs(ns.BlizzAreaPoisInfoZidormi or {}) do
      if poiID then ns.BlizzAreaPoisLookupZidormi[poiID] = true end
    end
  end

  for _, pool in pairs(WorldMapFrame.pinPools) do
    for pin in pool:EnumerateActive() do
      if pin
        and (not pin.GetObjectType or pin:GetObjectType() == "Frame" or pin:GetObjectType() == "Button")
        and (not pin.IsForbidden or not pin:IsForbidden())
        and (not pin.IsProtected or not pin:IsProtected())
      then
        if cfg.RemoveBlizzPOIs and ns.HiddenBlizzVignetteIDs and MN_IsVignettePin(pin) then
          local vignetteID = MN_GetVignetteIDFromPin(pin)
          if vignetteID and ns.HiddenBlizzVignetteIDs[vignetteID] then
            return true
          end
        end

        local info = pin.poiInfo
        local areaPoiID = pin.areaPoiID or (info and info.areaPoiID)

        if areaPoiID then
          if cfg.RemoveBlizzPOIs and ns.BlizzAreaPoisLookup[areaPoiID] then return true end
          if cfg.RemoveBlizzPOIsZidormi and ns.BlizzAreaPoisLookupZidormi[areaPoiID] then return true end
        end

        if cfg.RemoveBlizzPOIsZidormi and pin.objectGUID then
          for _, id in ipairs(ns.BlizzAreaPoisInfoZidormi or {}) do
            if id and string.find(pin.objectGUID, tostring(id), 1, true) then
              return true
            end
          end
        end
      end
    end
  end

  return false
end

function ns.RemovePOIs()

  if InCombatLockdown() then return end

  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg then return end
  if cfg.HideMapNote then return end
  if not (WorldMapFrame and WorldMapFrame.pinPools) then return end

  ns.BlizzAreaPoisLookup = ns.BlizzAreaPoisLookup or {}
  if next(ns.BlizzAreaPoisLookup) == nil then
    for _, poiID in pairs(ns.BlizzAreaPoisInfo or {}) do
      if poiID then ns.BlizzAreaPoisLookup[poiID] = true end
    end
  end

  ns.BlizzAreaPoisLookupZidormi = ns.BlizzAreaPoisLookupZidormi or {}
  if next(ns.BlizzAreaPoisLookupZidormi) == nil then
    for _, poiID in pairs(ns.BlizzAreaPoisInfoZidormi or {}) do
      if poiID then ns.BlizzAreaPoisLookupZidormi[poiID] = true end
    end
  end

  for _, pinPool in pairs(WorldMapFrame.pinPools) do
    for pin in pinPool:EnumerateActive() do
      local ot = pin and pin.GetObjectType and pin:GetObjectType()
      if not pin or (ot and ot ~= "Frame" and ot ~= "Button") or (pin.IsForbidden and pin:IsForbidden()) or (pin.IsProtected and pin:IsProtected()) then
        -- skip
      else
        local info = pin.poiInfo
        local areaPoiID = pin.areaPoiID or (info and info.areaPoiID)
        local isBlizzPOI = areaPoiID and ns.BlizzAreaPoisLookup[areaPoiID]
        local isZidormiPOI = areaPoiID and ns.BlizzAreaPoisLookupZidormi[areaPoiID]
        local isZidormiGUID = false
        if pin.objectGUID and not isZidormiPOI then
          for _, id in ipairs(ns.BlizzAreaPoisInfoZidormi or {}) do
            if id and string.find(pin.objectGUID, tostring(id), 1, true) then
              isZidormiGUID = true
              break
            end
          end
        end

        if isBlizzPOI then
          MN_SafeSetShown(pin, not cfg.RemoveBlizzPOIs)
        elseif (isZidormiPOI or isZidormiGUID) then
          MN_SafeSetShown(pin, not cfg.RemoveBlizzPOIsZidormi)
        end

        if MN_IsVignettePin(pin) then
          local vignetteID = MN_GetVignetteIDFromPin(pin)
          if cfg.RemoveBlizzPOIs
            and ns.HiddenBlizzVignetteIDs
            and vignetteID
            and ns.HiddenBlizzVignetteIDs[vignetteID]
          then
            MN_SafeSetShown(pin, false)
          else
            MN_SafeSetShown(pin, true)
          end
        end
      end
    end
  end
end

local function MN_TryHookProvider(dp)
  if not dp or ns.AreaPOIHooked[dp] then return end
  if type(dp.RefreshAllData) ~= "function" then return end

  ns.AreaPOIHooked[dp] = true

  hooksecurefunc(dp, "RefreshAllData", function()
    local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
    if not cfg or (not cfg.RemoveBlizzPOIs and not cfg.RemoveBlizzPOIsZidormi) then
      return
    end

    if WorldMapFrame and WorldMapFrame:IsShown() then
      ns.QueueRemovePOIs()
    end
  end)
end

for dp in pairs((WorldMapFrame and WorldMapFrame.dataProviders) or {}) do
  MN_TryHookProvider(dp)
end

ns.AddDataProviderHooked = ns.AddDataProviderHooked or false
if WorldMapFrame and not ns.AddDataProviderHooked then
  ns.AddDataProviderHooked = true
  hooksecurefunc(WorldMapFrame, "AddDataProvider", function(_, dp)
    MN_TryHookProvider(dp)
  end)
end

local eventFrame = CreateFrame("Frame")
eventFrame._registered = false

eventFrame:SetScript("OnEvent", function(_, eventName)
  if not (WorldMapFrame and WorldMapFrame:IsShown()) then return end

  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg or (not cfg.RemoveBlizzPOIs and not cfg.RemoveBlizzPOIsZidormi) then return end
  if not MN_MapHasRelevantActivePins() then return end

  ns.QueueRemovePOIs()
end)

local function MN_ShouldListenPOIEvent()
  if not (WorldMapFrame and WorldMapFrame:IsShown()) then return false end
  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg or (not cfg.RemoveBlizzPOIs and not cfg.RemoveBlizzPOIsZidormi) then return false end

  if cfg.RemoveBlizzPOIs and ns.HiddenBlizzVignetteIDs and next(ns.HiddenBlizzVignetteIDs) then
    return true
  end
  return MN_MapHasRelevantActivePins()
end

function ns.RegisterPOIEvent()
  if eventFrame._registered then return end
  if not MN_ShouldListenPOIEvent() then return end
  eventFrame:RegisterEvent("AREA_POIS_UPDATED")
  eventFrame:RegisterEvent("VIGNETTES_UPDATED")
  eventFrame._registered = true
end

function ns.UnregisterPOIEvent()
  if not eventFrame._registered then return end
  eventFrame:UnregisterEvent("AREA_POIS_UPDATED")
  eventFrame:UnregisterEvent("VIGNETTES_UPDATED")
  eventFrame._registered = false
end

function ns.RebindPOIEvent()
  if MN_ShouldListenPOIEvent() then
    if ns.RegisterPOIEvent then ns.RegisterPOIEvent() end
  else
    if ns.UnregisterPOIEvent then ns.UnregisterPOIEvent() end
  end
end

local function MN_OnMapChanged()
  if not (WorldMapFrame and WorldMapFrame:IsShown()) then return end
  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg then return end

  if (cfg.RemoveBlizzPOIs or cfg.RemoveBlizzPOIsZidormi) then
    ns.BlizzAreaPoisLookup = nil
    ns.BlizzAreaPoisLookupZidormi = nil
  end

  ns.RebindPOIEvent()

  if (cfg.RemoveBlizzPOIs or cfg.RemoveBlizzPOIsZidormi) and MN_MapHasRelevantActivePins() then
    ns.QueueRemovePOIs()
  end
end

ns.POIShowHooked = ns.POIShowHooked or false
ns.POIHideHooked = ns.POIHideHooked or false
ns.MapChangeHooked = ns.MapChangeHooked or false

C_Timer.After(0, function()
  if not WorldMapFrame then return end

  if not ns.MapChangeHooked then
    ns.MapChangeHooked = true
    if type(WorldMapFrame.OnMapChanged) == "function" then
      hooksecurefunc(WorldMapFrame, "OnMapChanged", MN_OnMapChanged)
    else
      hooksecurefunc(WorldMapFrame, "SetMapID", MN_OnMapChanged)
    end
  end

  if not ns.POIShowHooked then
    ns.POIShowHooked = true
    hooksecurefunc(WorldMapFrame, "Show", function()
      MN_Post(function() ns.RegisterPOIEvent() end)
    end)
  end

  if not ns.POIHideHooked then
    ns.POIHideHooked = true
    hooksecurefunc(WorldMapFrame, "Hide", function()
      MN_Post(function() ns.UnregisterPOIEvent() end)
    end)
  end

  if WorldMapFrame:IsShown() then
    MN_Post(function() ns.RegisterPOIEvent() end)
  end
end)