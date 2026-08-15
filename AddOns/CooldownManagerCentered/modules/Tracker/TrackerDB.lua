local _, ns = ...

local TrackerDB = {}
ns.TrackerDB = TrackerDB

local function IsSupportedCustomActiveKind(kind)
    return kind == "spell" or kind == "item"
end

local function NormalizeCustomActiveDuration(value)
    local numeric = tonumber(value)
    if not numeric then
        return nil
    end
    if numeric < 0 then
        return nil
    end
    return numeric
end

local function NormalizeAuraSpellID(value)
    local numeric = tonumber(value)
    if not numeric or numeric < 0 or numeric ~= math.floor(numeric) then
        return nil
    end
    return numeric
end

local function InvalidateItemCastCache(kind)
    if kind == "item" and ns.TrackerItemVisuals and ns.TrackerItemVisuals.InvalidateItemCastCache then
        ns.TrackerItemVisuals:InvalidateItemCastCache()
    end
end

TrackerDB.DefaultItems = {
    5512, -- Healthstone
    224464, -- Demonic Healthstone
}

TrackerDB.DefaultSpells = {
    7744, -- Will of the Forsaken
    20549, -- War Stomp
    20572, -- Blood Fury
    33697, -- Blood Fury
    33702, -- Blood Fury
    20589, -- Escape Artist
    20594, -- Stoneform
    26297, -- Berserking
    28880, -- Gift of the Naaru
    28880, -- Gift of the Naaru
    59542, -- Gift of the Naaru
    59543, -- Gift of the Naaru
    59544, -- Gift of the Naaru
    59545, -- Gift of the Naaru
    59547, -- Gift of the Naaru
    59548, -- Gift of the Naaru
    121093, -- Gift of the Naaru
    370626, -- Gift of the Naaru
    416250, -- Gift of the Naaru
    58984, -- Shadowmeld
    59752, -- Will to Survive
    68992, -- Darkflight
    69041, -- Rocket Barrage
    69070, -- Rocket Jump
    107079, -- Quaking Palm
    25046, -- Arcane Torrent
    28730, -- Arcane Torrent
    50613, -- Arcane Torrent
    69179, -- Arcane Torrent
    80483, -- Arcane Torrent
    202719, -- Arcane Torrent
    129597, -- Arcane Torrent
    155145, -- Arcane Torrent
    232633, -- Arcane Torrent
    255647, -- Light's Judgment
    255654, -- Bull Rush
    256948, -- Spatial Rift
    260364, -- Arcane Pulse
    265221, -- Fireblood
    274738, -- Ancestral Call
    287712, -- Haymaker
    291944, -- Regeneratin'
    312411, -- Bag of Tricks
    312924, -- Hyper Organic Light Originator
    357214, -- Wing Buffet
    368970, -- Tail Swipe
    436344, -- Azerite Surge
    1237885, -- Thorn Bloom
}

function TrackerDB.GetDB()
    return ns.db.profile.tracker
end

function TrackerDB.InitializeDB()
    if not ns.db.profile.tracker_enabled then
        return
    end
    local db = TrackerDB.GetDB()
    db.itemViewerLayouts = db.itemViewerLayouts or {}
    db.itemSettings = db.itemSettings or {}
    db.spellItemSettings = db.spellItemSettings or {}
    db.wildcardSlotSettings = db.wildcardSlotSettings or {}
    if db.showUnusable == nil then
        db.showUnusable = false
    end
    if db.showPassiveTrinkets == nil then
        db.showPassiveTrinkets = true
    end
    if not ns.db.profile._tracker_filled_with_defaults then
        for spellID in pairs(TrackerDB.DefaultSpells) do
            if not db.spellItemSettings[spellID] then
                db.spellItemSettings[spellID] = {
                    state = "tracker1",
                    order = 1,
                }
            end
        end
        for itemID in pairs(TrackerDB.DefaultItems) do
            if not db.itemSettings[itemID] then
                db.itemSettings[itemID] = {
                    state = "tracker1",
                    order = 1,
                }
            end
        end
        if not db.wildcardSlotSettings.trinket1 then
            db.wildcardSlotSettings.trinket1 = {
                state = "hidden",
                order = 1,
            }
        end
        if not db.wildcardSlotSettings.trinket2 then
            db.wildcardSlotSettings.trinket2 = {
                state = "hidden",
                order = 2,
            }
        end
        ns.db.profile._tracker_filled_with_defaults = true
    end

    db.wildcardSlotSettings = db.wildcardSlotSettings or {}
    if not db.wildcardSlotSettings.trinket1 then
        db.wildcardSlotSettings.trinket1 = {
            state = "hidden",
        }
    end
    if not db.wildcardSlotSettings.trinket2 then
        db.wildcardSlotSettings.trinket2 = {
            state = "hidden",
        }
    end
    if not db.wildcardSlotSettings.healthPotion then
        db.wildcardSlotSettings.healthPotion = {
            state = "hidden",
        }
    end
    if not db.wildcardSlotSettings.combatPotion then
        db.wildcardSlotSettings.combatPotion = {
            state = "hidden",
        }
    end
end

function TrackerDB.GetItemSettings(itemID)
    local db = TrackerDB.GetDB()
    db.itemSettings = db.itemSettings or {}
    return db.itemSettings[itemID]
end

function TrackerDB.GetSpellItemSettings(spellID)
    local db = TrackerDB.GetDB()
    db.spellItemSettings = db.spellItemSettings or {}
    return db.spellItemSettings[spellID]
end

function TrackerDB.GetWildcardSlotSettings(slotID)
    local db = TrackerDB.GetDB()
    db.wildcardSlotSettings = db.wildcardSlotSettings or {}
    return db.wildcardSlotSettings[slotID]
end

function TrackerDB.EnsureItemSettings(itemID)
    local db = TrackerDB.GetDB()
    db.itemSettings = db.itemSettings or {}
    if db.itemSettings[itemID] == nil then
        db.itemSettings[itemID] = {}
    end
    return db.itemSettings[itemID]
end

function TrackerDB.EnsureSpellItemSettings(spellID)
    local db = TrackerDB.GetDB()
    db.spellItemSettings = db.spellItemSettings or {}
    if db.spellItemSettings[spellID] == nil then
        db.spellItemSettings[spellID] = {}
    end
    return db.spellItemSettings[spellID]
end

function TrackerDB.EnsureWildcardSlotSettings(slotID)
    local db = TrackerDB.GetDB()
    db.wildcardSlotSettings = db.wildcardSlotSettings or {}
    if db.wildcardSlotSettings[slotID] == nil then
        db.wildcardSlotSettings[slotID] = {}
    end
    return db.wildcardSlotSettings[slotID]
end

function TrackerDB.GetItemState(itemID)
    local settings = TrackerDB.GetItemSettings(itemID)
    return settings and settings.state or nil
end

function TrackerDB.GetSpellItemState(spellID)
    local settings = TrackerDB.GetSpellItemSettings(spellID)
    return settings and settings.state or nil
end

function TrackerDB.GetWildcardSlotState(slotID)
    local settings = TrackerDB.GetWildcardSlotSettings(slotID)
    return settings and settings.state or nil
end

function TrackerDB.SetItemState(itemID, state)
    local db = TrackerDB.GetDB()
    db.itemSettings = db.itemSettings or {}
    if state == nil then
        db.itemSettings[itemID] = nil
        InvalidateItemCastCache("item")
        return
    end

    local settings = TrackerDB.EnsureItemSettings(itemID)
    settings.state = state
    InvalidateItemCastCache("item")
end

function TrackerDB.SetSpellItemState(spellID, state)
    local db = TrackerDB.GetDB()
    db.spellItemSettings = db.spellItemSettings or {}
    -- owned.spells (in TrackerItemsData) is derived from the spellItemSettings keys,
    -- so changing membership here must drop its cached ownership scan.
    if ns.TrackerItemsData and ns.TrackerItemsData.InvalidateOwnedItemsCache then
        ns.TrackerItemsData:InvalidateOwnedItemsCache()
    end
    if state == nil then
        db.spellItemSettings[spellID] = nil
        return
    end

    local settings = TrackerDB.EnsureSpellItemSettings(spellID)
    settings.state = state
end

function TrackerDB.SetWildcardSlotState(slotID, state)
    local db = TrackerDB.GetDB()
    db.wildcardSlotSettings = db.wildcardSlotSettings or {}
    if state == nil then
        db.wildcardSlotSettings[slotID] = nil
        InvalidateItemCastCache("item")
        return
    end

    local settings = TrackerDB.EnsureWildcardSlotSettings(slotID)
    settings.state = state
    InvalidateItemCastCache("item")
end

function TrackerDB.GetShowingUnusable()
    local db = TrackerDB.GetDB()
    return db.showUnusable == true
end

function TrackerDB.ToggleShowUnusable()
    local db = TrackerDB.GetDB()
    db.showUnusable = not TrackerDB.GetShowingUnusable()
    if ns.TrackerAssignmentPanel and ns.TrackerAssignmentPanel.RefreshTrackerPanel then
        ns.TrackerAssignmentPanel:RefreshTrackerPanel()
    end
end

-- Passive (proc-only) trinkets have no on-use spell. Defaults to true; players who
-- only want usable trinkets in the wildcard trinket slots can turn this off.
function TrackerDB.GetShowingPassiveTrinkets()
    local db = TrackerDB.GetDB()
    return db.showPassiveTrinkets ~= false
end

function TrackerDB.ToggleShowPassiveTrinkets()
    local db = TrackerDB.GetDB()
    db.showPassiveTrinkets = not TrackerDB.GetShowingPassiveTrinkets()
    if ns.TrackerItemsData and ns.TrackerItemsData.InvalidateOwnedItemsCache then
        ns.TrackerItemsData:InvalidateOwnedItemsCache()
    end
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
        ns.TrackerItemViewer:RefreshItemViewerFrames()
    end
    if ns.TrackerAssignmentPanel and ns.TrackerAssignmentPanel.RefreshTrackerPanel then
        ns.TrackerAssignmentPanel:RefreshTrackerPanel()
    end
end

function TrackerDB.GetCustomActiveDuration(kind, id)
    if not IsSupportedCustomActiveKind(kind) then
        return 0
    end

    local settings
    if kind == "spell" then
        settings = TrackerDB.GetSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.GetItemSettings(id)
    end
    local duration = settings and NormalizeCustomActiveDuration(settings.customActiveDuration)
    return duration or 0
end

function TrackerDB.SetCustomActiveDuration(kind, id, value)
    if not IsSupportedCustomActiveKind(kind) then
        return false
    end

    local normalized = NormalizeCustomActiveDuration(value)
    if normalized == nil then
        return false
    end

    local settings
    if kind == "spell" then
        settings = TrackerDB.EnsureSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.EnsureItemSettings(id)
    end
    if not settings then
        return false
    end

    if normalized == 0 then
        settings.customActiveDuration = nil
    else
        settings.customActiveDuration = normalized
    end

    InvalidateItemCastCache(kind)

    return true
end

function TrackerDB.GetAuraSpellID(kind, id)
    if not IsSupportedCustomActiveKind(kind) then
        return nil
    end

    local settings
    if kind == "spell" then
        settings = TrackerDB.GetSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.GetItemSettings(id)
    end
    local auraSpellID = settings and NormalizeAuraSpellID(settings.auraSpellID)
    return auraSpellID and auraSpellID > 0 and auraSpellID or nil
end

function TrackerDB.SetAuraSpellID(kind, id, value)
    if not IsSupportedCustomActiveKind(kind) then
        return false
    end

    local normalized = NormalizeAuraSpellID(value)
    if normalized == nil then
        return false
    end

    local settings
    if kind == "spell" then
        settings = TrackerDB.EnsureSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.EnsureItemSettings(id)
    end
    if not settings then
        return false
    end

    settings.auraSpellID = normalized > 0 and normalized or nil
    -- Removed prototype flag from pre-AuraContainer builds.
    settings.useRealAura = nil
    InvalidateItemCastCache(kind)
    return true
end

function TrackerDB.GetHideAura(kind, id)
    if not IsSupportedCustomActiveKind(kind) then
        return false
    end

    local settings
    if kind == "spell" then
        settings = TrackerDB.GetSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.GetItemSettings(id)
    end
    return settings and settings.hideAura == true or false
end

function TrackerDB.SetHideAura(kind, id, value)
    if not IsSupportedCustomActiveKind(kind) then
        return false
    end

    local settings
    if kind == "spell" then
        settings = value and TrackerDB.EnsureSpellItemSettings(id) or TrackerDB.GetSpellItemSettings(id)
    elseif kind == "item" then
        settings = value and TrackerDB.EnsureItemSettings(id) or TrackerDB.GetItemSettings(id)
    end
    if not settings then
        return true
    end

    settings.hideAura = value == true and true or nil
    InvalidateItemCastCache(kind)
    return true
end

function TrackerDB.ToggleHideAura(kind, id)
    return TrackerDB.SetHideAura(kind, id, not TrackerDB.GetHideAura(kind, id))
end

local function GetEntrySettings(kind, id)
    if kind == "spell" then
        return TrackerDB.GetSpellItemSettings(id)
    elseif kind == "item" then
        return TrackerDB.GetItemSettings(id)
    end
    return TrackerDB.GetWildcardSlotSettings(id)
end

local function EnsureEntrySettings(kind, id)
    if kind == "spell" then
        return TrackerDB.EnsureSpellItemSettings(id)
    elseif kind == "item" then
        return TrackerDB.EnsureItemSettings(id)
    end
    return TrackerDB.EnsureWildcardSlotSettings(id)
end

-- Per-entry glow flags: ready, full charges, aura active, and assisted suggestion.
function TrackerDB.GetGlowFlag(kind, id, field)
    local settings = GetEntrySettings(kind, id)
    return settings and settings[field] == true or false
end

function TrackerDB.SetGlowFlag(kind, id, field, value)
    if not value then
        local settings = GetEntrySettings(kind, id)
        if settings then
            settings[field] = nil
        end
        return
    end
    EnsureEntrySettings(kind, id)[field] = true
end

function TrackerDB.ToggleGlowFlag(kind, id, field)
    TrackerDB.SetGlowFlag(kind, id, field, not TrackerDB.GetGlowFlag(kind, id, field))
end

function TrackerDB.GetEntryColor(kind, id, field)
    local settings = GetEntrySettings(kind, id)
    local color = settings and settings[field]
    if type(color) == "table" and color[1] ~= nil and color[2] ~= nil and color[3] ~= nil then
        return color
    end
    return nil
end

function TrackerDB.SetEntryColor(kind, id, field, r, g, b)
    if r == nil then
        local settings = GetEntrySettings(kind, id)
        if settings then
            settings[field] = nil
        end
        return
    end
    local settings = EnsureEntrySettings(kind, id)
    if settings then
        settings[field] = { r, g, b }
    end
end

function TrackerDB.GetAlwaysShow(kind, id)
    local settings
    if kind == "spell" then
        settings = TrackerDB.GetSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.GetItemSettings(id)
    else
        settings = TrackerDB.GetWildcardSlotSettings(id)
    end
    return settings and settings.alwaysShow == true
end

function TrackerDB.SetAlwaysShow(kind, id, value)
    local settings
    if kind == "spell" then
        settings = TrackerDB.EnsureSpellItemSettings(id)
    elseif kind == "item" then
        settings = TrackerDB.EnsureItemSettings(id)
    else
        settings = TrackerDB.EnsureWildcardSlotSettings(id)
    end
    if not settings then
        return
    end
    settings.alwaysShow = value == true or nil
end

-- Blizzard proc glows are enabled by default for every tracked spell. Persist only
-- the opt-out so existing profiles gain the feature without a migration.
function TrackerDB.GetProcGlowEnabled(spellID)
    local settings = TrackerDB.GetSpellItemSettings(spellID)
    return not settings or settings.procGlow ~= false
end

function TrackerDB.SetProcGlowEnabled(spellID, value)
    local settings = TrackerDB.EnsureSpellItemSettings(spellID)
    if settings then
        if value == false then
            settings.procGlow = false
        else
            settings.procGlow = nil
        end
    end
end

function TrackerDB.IsHiddenForSpec(kind, id, specID)
    if not specID then
        return false
    end
    local settings = GetEntrySettings(kind, id)
    return settings and type(settings.hiddenForSpecs) == "table" and settings.hiddenForSpecs[specID] == true or false
end

function TrackerDB.SetHiddenForSpec(kind, id, specID, value)
    if not specID then
        return
    end
    local settings = EnsureEntrySettings(kind, id)
    if not settings then
        return
    end
    if value then
        settings.hiddenForSpecs = settings.hiddenForSpecs or {}
        settings.hiddenForSpecs[specID] = true
    elseif type(settings.hiddenForSpecs) == "table" then
        settings.hiddenForSpecs[specID] = nil
        if not next(settings.hiddenForSpecs) then
            settings.hiddenForSpecs = nil
        end
    end
end

function TrackerDB.ClearHiddenForSpecs(kind, id)
    local settings = GetEntrySettings(kind, id)
    if settings then
        settings.hiddenForSpecs = nil
    end
end

function TrackerDB.GetCurrentSpecID()
    local specIndex = C_SpecializationInfo.GetSpecialization()
    if not specIndex then
        return nil
    end
    local specID = C_SpecializationInfo.GetSpecializationInfo(specIndex)
    return specID and specID > 0 and specID or nil
end

function TrackerDB.IsHiddenForCurrentSpec(kind, id)
    return TrackerDB.IsHiddenForSpec(kind, id, TrackerDB.GetCurrentSpecID())
end
