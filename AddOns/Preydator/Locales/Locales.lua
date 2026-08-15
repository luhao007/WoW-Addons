---@diagnostic disable
-- Preydator Localization Bootstrap
-- Must load before all other Preydator files (listed first in .toc).
-- Creates PreydatorL global; any string not found falls back to its English key.

if not _G.PreydatorL then
    _G.PreydatorL = setmetatable({}, {
        __index = function(_, k) return k end,
    })
end

-- Default English launch strings for 3.0; these remain available even when an
-- active locale file is intentionally a translation guide instead of a live map.
_G.PreydatorL["Preydator Updates: New in 3.0"] = "Preydator 3.0 is live."
_G.PreydatorL["PREYDATOR_3_0_WHATS_NEW_BODY"] = "Preydator 3.0 is live.\n\n- Removed Currency and Warband modules from the core addon.\n- Hunt, Bar, and Sounds features remain intact.\n- Added a safe new splash flow and runtime cleanup.\n\nIf you already have windows placed, your saved layout stays intact."
_G.PreydatorL["Got It"] = "Got It"
_G.PreydatorL["Open Settings"] = "Open Settings"
