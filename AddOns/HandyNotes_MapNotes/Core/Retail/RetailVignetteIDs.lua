-- RetailBlizzVignettePOIFilter.lua
-- Behandelt Blizzard-VignettePins wie POIs (gesteuert über RemoveBlizzPOIs)

local ADDON_NAME, ns = ...

if not C_VignetteInfo then return end

-- Blizzard-VignetteIDs, die mit dem POI-Toggle versteckt werden sollen
ns.HiddenBlizzVignetteIDs = ns.HiddenBlizzVignetteIDs or {
  [7522] = true, -- Rüstmeisterin für Eroberungspunkte
}

-- Hilfsfunktion: vignetteID aus Pin ermitteln
function ns.GetVignetteIDFromPin(pin)
  if not pin then return nil end

  if pin.vignetteGUID then
    local info = C_VignetteInfo.GetVignetteInfo(pin.vignetteGUID)
    return info and info.vignetteID
  end

  return pin.vignetteID
end

-- Prüffunktion: soll dieser Pin wie ein Blizzard-POI behandelt werden?
function ns.IsHiddenBlizzVignettePin(pin)
  if not pin then return false end

  local cfg = ns.Addon and ns.Addon.db and ns.Addon.db.profile and ns.Addon.db.profile.activate
  if not cfg or not cfg.RemoveBlizzPOIs then return false end

  local vignetteID = ns.GetVignetteIDFromPin(pin)
  return vignetteID and ns.HiddenBlizzVignetteIDs[vignetteID]
end