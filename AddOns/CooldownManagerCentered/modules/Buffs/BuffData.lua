local _, ns = ...
local L = ns.L

local BuffData = {}
ns.BuffData = BuffData

local MAX_CONTAINERS = ns.CONSTANTS and ns.CONSTANTS.MAX_TRACKERS or 10
BuffData.MAX_CONTAINERS = MAX_CONTAINERS

local function BuildStableKey(cooldownID, spellID, overrideTooltipSpellID)
    if overrideTooltipSpellID then
        return "t:" .. overrideTooltipSpellID
    end
    if spellID then
        return "s:" .. spellID
    end
    if cooldownID then
        return "c:" .. cooldownID
    end
    return nil
end

local infoByCooldownID = {}
local scanCache = nil
local blizzardAuraSpellIDs = nil
local blizzardAuraCooldownIDs = nil
local blizzardDataLoaded = false
local EMPTY_CUSTOM_AURAS = {}

local function AddCooldownInfoSpellIDs(spellIDs, info)
    if not info then
        return
    end
    if info.spellID then
        spellIDs[info.spellID] = true
    end
    if info.overrideSpellID then
        spellIDs[info.overrideSpellID] = true
    end
    if info.overrideTooltipSpellID then
        spellIDs[info.overrideTooltipSpellID] = true
    end
    for _, linkedSpellID in ipairs(info.linkedSpellIDs) do
        spellIDs[linkedSpellID] = true
    end
end

local function GetBlizzardAuraData()
    if blizzardAuraSpellIDs then
        return blizzardAuraSpellIDs, blizzardAuraCooldownIDs
    end

    blizzardAuraSpellIDs = {}
    blizzardAuraCooldownIDs = {}
    if not C_CooldownViewer or not C_CooldownViewer.GetCooldownViewerCategorySet then
        return blizzardAuraSpellIDs, blizzardAuraCooldownIDs
    end

    -- TrackedBuff (Buff Icons) + TrackedBar (Buff Bars), queried with
    -- allowUnlearned, also cover the entries Blizzard puts in Not Displayed
    -- (HiddenAura), including HideByDefault and not-yet-known/unavailable
    -- buffs. All of them are valid sources for a per-spec migration.
    local categories = {
        Enum.CooldownViewerCategory.TrackedBuff,
        Enum.CooldownViewerCategory.TrackedBar,
    }
    for _, category in ipairs(categories) do
        local cooldownIDs = C_CooldownViewer.GetCooldownViewerCategorySet(category, true)
        if type(cooldownIDs) == "table" then
            for _, cooldownID in ipairs(cooldownIDs) do
                blizzardAuraCooldownIDs[cooldownID] = true
                AddCooldownInfoSpellIDs(
                    blizzardAuraSpellIDs,
                    C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
                )
            end
        end
    end
    return blizzardAuraSpellIDs, blizzardAuraCooldownIDs
end

-- The category sets are only trustworthy after Blizzard has loaded its CDM
-- data. The explicit event is the primary signal; the API availability probe
-- covers the case where the event fired before this addon registered.
local function IsBlizzardBuffDataReady()
    if blizzardDataLoaded then
        return true
    end
    if not C_CooldownViewer or not C_CooldownViewer.GetCooldownViewerCategorySet then
        return false
    end
    if C_CooldownViewer.IsCooldownViewerAvailable and C_CooldownViewer.IsCooldownViewerAvailable() == false then
        return false
    end
    local _, cooldownIDs = GetBlizzardAuraData()
    if next(cooldownIDs) ~= nil then
        blizzardDataLoaded = true
        return true
    end
    return false
end

local function GetCurrentSpecID()
    if not C_SpecializationInfo or not C_SpecializationInfo.GetSpecialization then
        return nil
    end
    local specIndex = C_SpecializationInfo.GetSpecialization()
    if not specIndex or specIndex <= 0 then
        return nil
    end
    local specID = C_SpecializationInfo.GetSpecializationInfo(specIndex)
    if specID and specID > 0 then
        return specID
    end
end

local function IsBlizzardBuffValidForKey(key, spellIDs, cooldownIDs)
    if type(key) ~= "string" then
        return false
    end
    local prefix = key:sub(1, 2)
    local id = tonumber(key:sub(3))
    if not id then
        return false
    end
    if prefix == "c:" then
        return cooldownIDs[id] == true
    elseif prefix == "s:" or prefix == "t:" then
        return spellIDs[id] == true
    end
    return false
end

local function CopyAssignmentsTable(source)
    local copy = {}
    for key, value in pairs(source) do
        copy[key] = value
    end
    return copy
end

-- Raw custom/wildcard-kind check used by the mixing guard and the per-spec
-- migration. Deliberately ignores the alpha-feature gate so containers stay
-- protected even when the feature is toggled off and back on with definitions
-- still saved.
function BuffData.IsCustomKey(key)
    if not key then
        return false
    end
    local db = BuffData.GetDB()
    if db.customAuras[key] then
        return true
    end
    return ns.BuffWildcards:GetDefinitions()[key] ~= nil
end

local function CacheCustomAuraDisplayData(definition)
    if type(definition) ~= "table" then
        return
    end

    local spellID = tonumber(definition.spellID)
    if not spellID then
        return
    end

    if definition.name and definition.iconID then
        return
    end

    local spellInfo = C_Spell.GetSpellInfo(spellID)
    if spellInfo then
        definition.name = definition.name or spellInfo.name
        definition.iconID = definition.iconID or spellInfo.iconID
    end
    definition.iconID = definition.iconID or C_Spell.GetSpellTexture(spellID)
end

---@return table config The profile.buffContainers table, created on first access.
function BuffData.GetDB()
    ns.db.profile.buffContainers = ns.db.profile.buffContainers or {}
    local db = ns.db.profile.buffContainers
    db.assignments = db.assignments or {}
    db.orders = db.orders or {}
    db.customAuras = db.customAuras or {}
    db.buffEntrySettings = db.buffEntrySettings or {}
    return db
end

-- Per-spec assignment storage. The root buffContainers table stays the
-- untouched default source; each spec gets its own assignments/orders/count,
-- filled once from that default and filtered by what Blizzard actually has for
-- this class/spec in its buff categories.
---@return table assignmentDB Per-spec { assignments, orders, count }.
function BuffData.GetAssignmentDB(specID)
    local root = BuffData.GetDB()
    root.bySpec = root.bySpec or {}
    specID = specID or GetCurrentSpecID()
    if not specID then
        -- No spec assigned yet (login/loading); do not persist a placeholder
        -- spec config. Startup layout keeps reading the default through the
        -- same transient copies used before the CDM data is ready.
        return {
            assignments = CopyAssignmentsTable(root.assignments),
            orders = CopyAssignmentsTable(root.orders),
            count = root.count or 1,
        }
    end
    local specDB = root.bySpec[specID]
    if specDB then
        return specDB
    end

    -- Before COOLDOWN_VIEWER_DATA_LOADED the category sets are not
    -- trustworthy. Keep reading the default config and wait for the event so
    -- the filtered migration is not persisted with an empty Blizzard set. The
    -- transient copies keep startup layout/reconcile paths from writing into
    -- the default itself.
    if not IsBlizzardBuffDataReady() then
        return {
            assignments = CopyAssignmentsTable(root.assignments),
            orders = CopyAssignmentsTable(root.orders),
            count = root.count or 1,
        }
    end

    local assignments = {}
    local orders = {}
    local spellIDs, cooldownIDs = GetBlizzardAuraData()
    local defaultAssignments = root.assignments or {}
    local defaultOrders = root.orders or {}
    for key, containerIndex in pairs(defaultAssignments) do
        -- Custom auras and live wildcard definitions are class-agnostic and
        -- carried over; stale custom/wildcard keys (definition removed) are
        -- dropped. Blizzard buffs are kept only when they exist for this spec
        -- in Blizzard's buff categories (Not Displayed / Buff Icons / Buff
        -- Bars), including unavailable/unlearned entries.
        if BuffData.IsCustomKey(key) or IsBlizzardBuffValidForKey(key, spellIDs, cooldownIDs) then
            assignments[key] = containerIndex
            if defaultOrders[key] ~= nil then
                orders[key] = defaultOrders[key]
            end
        end
    end

    specDB = {
        assignments = assignments,
        orders = orders,
        count = root.count or 1,
    }
    root.bySpec[specID] = specDB
    return specDB
end

function BuffData.OnBlizzardDataLoaded()
    blizzardDataLoaded = true
end

function BuffData.GetAssignments()
    return BuffData.GetAssignmentDB().assignments
end

function BuffData.GetOrders()
    return BuffData.GetAssignmentDB().orders
end

function BuffData.IsEnabled()
    return BuffData.GetDB().enabled == true
end

function BuffData.AreCustomAurasEnabled()
    return ns.AuraContainerRuntime:IsAvailable()
end

function BuffData.SetEnabled(value)
    local db = BuffData.GetDB()
    local enabled = value and true or false
    if enabled and not db.enabled then
        ns.BuffWildcards:InvalidateCache()
    end
    db.enabled = enabled
end

function BuffData.GetContainerCount()
    local db = BuffData.GetAssignmentDB()
    local count = db.count or 1
    if count < 1 then
        return 1
    elseif count > MAX_CONTAINERS then
        return MAX_CONTAINERS
    end
    return count
end

local function ResolveCooldownInfo(cooldownID)
    if not cooldownID then
        return nil
    end
    local cached = infoByCooldownID[cooldownID]
    if cached ~= nil then
        return cached
    end
    local info = C_CooldownViewer and C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
    if not info then
        infoByCooldownID[cooldownID] = false
        return nil
    end
    local spellID = info.overrideTooltipSpellID or info.overrideSpellID or info.spellID
    local stableKey = BuildStableKey(cooldownID, spellID, info.overrideTooltipSpellID)
    local resolved = {
        source = "cooldownViewer",
        cooldownID = cooldownID,
        spellID = spellID,
        stableKey = stableKey,
        name = spellID and C_Spell.GetSpellName(spellID) or nil,
        iconID = spellID and C_Spell.GetSpellTexture(spellID) or nil,
    }

    infoByCooldownID[cooldownID] = resolved
    return resolved
end

local function BuildCustomAuraEntry(stableKey, definition)
    local spellID = definition and definition.spellID
    CacheCustomAuraDisplayData(definition)
    return {
        source = definition and definition.wildcard == true and "wildcard" or "customAura",
        stableKey = stableKey,
        spellID = spellID,
        auraType = definition and definition.auraType == "harmful" and "harmful" or "helpful",
        name = definition.name,
        label = definition.label,
        iconID = definition.iconID,
        custom = true,
        wildcard = definition and definition.wildcard == true,
    }
end

-- Custom auras plus registry-owned wildcards; the AuraContainer provider treats
-- both as secure slots with candidate spell filters.
local function CopyDefinitionWithSettings(stableKey, definition)
    local merged = {}
    for key, value in pairs(definition) do
        merged[key] = value
    end
    local settings = BuffData.GetDB().buffEntrySettings[stableKey]
    if settings then
        if settings.soundOnApplied ~= nil then
            merged.soundOnApplied = settings.soundOnApplied == true
        end
        if settings.soundOnAppliedFile ~= nil then
            merged.soundOnAppliedFile = settings.soundOnAppliedFile
        end
    end
    return merged
end

function BuffData.GetCustomAuraDefinitions()
    if not BuffData.AreCustomAurasEnabled() then
        return EMPTY_CUSTOM_AURAS
    end
    local definitions = {}
    for stableKey, definition in pairs(BuffData.GetDB().customAuras) do
        definitions[stableKey] = CopyDefinitionWithSettings(stableKey, definition)
    end
    for stableKey, definition in pairs(ns.BuffWildcards:GetDefinitions()) do
        definitions[stableKey] = CopyDefinitionWithSettings(stableKey, definition)
    end
    return definitions
end

-- Only definitions currently assigned to a container. The AuraContainer provider
-- must not create live slots for untracked wildcards/custom auras, otherwise they
-- could render at the container's origin while sitting in the untracked section.
function BuffData.GetAssignedAuraDefinitions()
    local definitions = BuffData.GetCustomAuraDefinitions()
    local result = {}
    local count = BuffData.GetContainerCount()
    local assignments = BuffData.GetAssignments()
    for stableKey, definition in pairs(definitions) do
        local index = assignments[stableKey]
        if index and index >= 1 and index <= count then
            result[stableKey] = definition
        end
    end
    return result
end

function BuffData.GetBuffEntrySetting(stableKey, key, default)
    local settings = BuffData.GetDB().buffEntrySettings[stableKey]
    local value = settings and settings[key]
    return value ~= nil and value or default
end

function BuffData.SetBuffEntrySetting(stableKey, key, value)
    local db = BuffData.GetDB()
    db.buffEntrySettings[stableKey] = db.buffEntrySettings[stableKey] or {}
    if value == nil or value == false or value == "" then
        db.buffEntrySettings[stableKey][key] = nil
        if not next(db.buffEntrySettings[stableKey]) then
            db.buffEntrySettings[stableKey] = nil
        end
    else
        db.buffEntrySettings[stableKey][key] = value
    end
end

local function ContainerHasCustomAuraRaw(containerIndex)
    local db = BuffData.GetAssignmentDB()
    for stableKey, assignedIndex in pairs(db.assignments) do
        if assignedIndex == containerIndex and BuffData.IsCustomKey(stableKey) then
            return true
        end
    end
    return false
end

local function ContainerHasBlizzardAuraRaw(containerIndex)
    local db = BuffData.GetAssignmentDB()
    for stableKey, assignedIndex in pairs(db.assignments) do
        if assignedIndex == containerIndex and not BuffData.IsCustomKey(stableKey) then
            return true
        end
    end
    return false
end

function BuffData.ContainerHasCustomAura(containerIndex)
    if not BuffData.AreCustomAurasEnabled() then
        return false
    end
    return ContainerHasCustomAuraRaw(containerIndex)
end

-- One container can hold custom auras or Blizzard-tracked buffs, never both.
function BuffData.CanAssignToContainer(key, containerIndex)
    if containerIndex < 1 or containerIndex > MAX_CONTAINERS then
        return false
    end
    if BuffData.IsCustomKey(key) then
        return not ContainerHasBlizzardAuraRaw(containerIndex)
    end
    return not ContainerHasCustomAuraRaw(containerIndex)
end

-- First existing container that can accept another aura of the requested kind.
-- Custom auras land in a custom-only/empty container; Blizzard buffs land in a
-- Blizzard/empty container. Nil means every current container is taken by the
-- opposite kind (the caller may then grow the count).
function BuffData.FindCompatibleContainer(isCustom)
    local count = BuffData.GetContainerCount()
    for i = 1, count do
        if isCustom and not ContainerHasBlizzardAuraRaw(i) then
            return i
        elseif not isCustom and not ContainerHasCustomAuraRaw(i) then
            return i
        end
    end
    return nil
end

function BuffData.HasCustomAura(spellID)
    if not BuffData.AreCustomAurasEnabled() then
        return false
    end
    return BuffData.GetDB().customAuras["a:" .. tostring(spellID)] ~= nil
end

function BuffData.HasBlizzardAura(spellID)
    spellID = tonumber(spellID)
    if not spellID then
        return false
    end
    local spellIDs = GetBlizzardAuraData()
    return spellIDs[spellID] == true
end

function BuffData.AddCustomAura(spellID, auraType)
    if not BuffData.AreCustomAurasEnabled() then
        return nil, L["Alpha features are disabled"]
    end

    spellID = tonumber(spellID)
    if not spellID or spellID <= 0 or spellID ~= math.floor(spellID) then
        return nil, L["Unknown spell ID"]
    end

    local spellInfo = C_Spell.GetSpellInfo(spellID)
    if not spellInfo or not spellInfo.name then
        return nil, L["Unknown spell ID"]
    end

    local stableKey = "a:" .. spellID
    local db = BuffData.GetDB()
    if db.customAuras[stableKey] then
        return nil, L["Aura already added"]
    end

    local definition = {
        spellID = spellID,
        name = spellInfo.name,
        iconID = spellInfo.iconID or C_Spell.GetSpellTexture(spellID),
        auraType = auraType == "harmful" and "harmful" or "helpful",
    }
    db.customAuras[stableKey] = definition

    local containerIndex = BuffData.FindCompatibleContainer(true)
    if not containerIndex then
        local count = BuffData.GetContainerCount()
        if count >= MAX_CONTAINERS then
            db.customAuras[stableKey] = nil
            return nil, L["No free buff container"]
        end
        containerIndex = count + 1
        local assignmentDB = BuffData.GetAssignmentDB()
        if assignmentDB then
            assignmentDB.count = containerIndex
        end
    end
    if not BuffData.InsertEntryAt(containerIndex, BuildCustomAuraEntry(stableKey, definition), nil, false) then
        db.customAuras[stableKey] = nil
        return nil, L["Could not assign the custom aura"]
    end
    return stableKey
end

function BuffData.RemoveCustomAura(stableKey)
    if not BuffData.AreCustomAurasEnabled() then
        return false
    end
    local root = BuffData.GetDB()
    if not stableKey or not root.customAuras[stableKey] then
        return false
    end
    root.customAuras[stableKey] = nil
    -- The definition is shared, so every per-spec assignment that references
    -- it is dropped too. The default config stays untouched as the migration
    -- source for other specs and classes.
    for _, specDB in pairs(root.bySpec or {}) do
        if specDB.assignments then
            specDB.assignments[stableKey] = nil
        end
        if specDB.orders then
            specDB.orders[stableKey] = nil
        end
    end
    return true
end

function BuffData.GetAllEntries()
    local entries = {}
    for _, entry in ipairs(BuffData.ScanTrackedBuffs()) do
        entries[#entries + 1] = entry
    end

    -- Keep saved definitions out of the editor unless the 12.1 provider and the
    -- global alpha-feature gate are both available.
    if BuffData.AreCustomAurasEnabled() then
        for stableKey, definition in pairs(BuffData.GetCustomAuraDefinitions()) do
            if type(definition) == "table" and tonumber(definition.spellID) then
                entries[#entries + 1] = BuildCustomAuraEntry(stableKey, definition)
            end
        end
    end
    return entries
end

---Tracked buffs with live frames in BuffIconCooldownViewer.
---@param force? boolean Rebuild instead of returning the cached scan.
---@return table entries Array of { cooldownID, spellID, stableKey, name, iconID }.
function BuffData.ScanTrackedBuffs(force)
    if scanCache and not force then
        return scanCache
    end
    wipe(infoByCooldownID)
    local entries = {}
    local viewer = _G["BuffIconCooldownViewer"]
    if viewer and viewer.GetItemFrames then
        local frames = viewer:GetItemFrames()
        local ordered = {}
        for _, frame in ipairs(frames) do
            local cooldownID = frame:GetCooldownID()
            if cooldownID and frame.layoutIndex ~= nil then
                ordered[#ordered + 1] = { cooldownID = cooldownID, layoutIndex = frame.layoutIndex }
            end
        end
        table.sort(ordered, function(a, b)
            return a.layoutIndex < b.layoutIndex
        end)
        local seen = {}
        for _, item in ipairs(ordered) do
            if not seen[item.cooldownID] then
                seen[item.cooldownID] = true
                local info = ResolveCooldownInfo(item.cooldownID)
                if info and info.stableKey then
                    info.layoutIndex = item.layoutIndex
                    entries[#entries + 1] = info
                end
            end
        end
    end
    scanCache = entries
    return entries
end

function BuffData.InvalidateScan()
    scanCache = nil
    blizzardAuraSpellIDs = nil
    blizzardAuraCooldownIDs = nil
    wipe(infoByCooldownID)
    ns.BuffWildcards:InvalidateCache()
    local root = BuffData.GetDB()
    local wildcardDefinitions = ns.BuffWildcards:GetDefinitions()
    -- Wildcards are registry-owned; per-spec assignments pointing at a removed
    -- definition are cleaned, while the default config is left alone.
    for _, specDB in pairs(root.bySpec or {}) do
        local assignments = specDB.assignments
        if assignments then
            for stableKey in pairs(assignments) do
                if
                    type(stableKey) == "string"
                    and stableKey:sub(1, 2) == "w:"
                    and not wildcardDefinitions[stableKey]
                then
                    assignments[stableKey] = nil
                    if specDB.orders then
                        specDB.orders[stableKey] = nil
                    end
                end
            end
        end
    end
end

function BuffData.GetStableKeyForCooldownID(cooldownID)
    local info = ResolveCooldownInfo(cooldownID)
    return info and info.stableKey or BuildStableKey(cooldownID, nil)
end

function BuffData.GetContainerForCooldownID(cooldownID)
    if not cooldownID then
        return nil
    end
    local key = BuffData.GetStableKeyForCooldownID(cooldownID)
    if not key then
        return nil
    end
    local index = BuffData.GetAssignments()[key]
    if index and index >= 1 and index <= BuffData.GetContainerCount() then
        return index
    end
    return nil
end

function BuffData.AssignKey(key, containerIndex)
    local db = BuffData.GetAssignmentDB()
    if BuffData.IsCustomKey(key) and not BuffData.AreCustomAurasEnabled() then
        return false
    end
    if BuffData.IsCustomKey(key) and containerIndex ~= nil and (containerIndex < 1 or containerIndex > MAX_CONTAINERS) then
        return false
    end
    if containerIndex and not BuffData.CanAssignToContainer(key, containerIndex) then
        return false, "mixed"
    end
    db.assignments[key] = containerIndex
    return true
end

local function SortEntries(entries)
    local orders = BuffData.GetOrders()
    table.sort(entries, ns.API:BuildOrderComparator(
        function(entry) return orders[entry.stableKey] end,
        function(entry) return entry.layoutIndex end,
        function(entry) return entry.stableKey or "" end
    ))
end

-- Assigned Blizzard buffs that are no longer in the current scan (untracked in
-- Blizzard, hidden, or belonging to another spec) still occupy the container
-- for the mixing guard. Build a display entry so the panel can show them grayed
-- instead of letting the container look empty.
local function BuildStaleBlizzardEntry(stableKey)
    if type(stableKey) ~= "string" then
        return nil
    end
    local prefix = stableKey:sub(1, 2)
    local id = tonumber(stableKey:sub(3))
    if not id or (prefix ~= "c:" and prefix ~= "s:" and prefix ~= "t:") then
        return nil
    end

    local cooldownID
    local spellID = id
    local name, iconID
    if prefix == "c:" then
        cooldownID = id
        local info = ResolveCooldownInfo(id)
        if info then
            spellID = info.spellID or id
            name, iconID = info.name, info.iconID
        end
    end
    if not name and prefix ~= "c:" then
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        if spellInfo then
            name = spellInfo.name
            iconID = spellInfo.iconID or C_Spell.GetSpellTexture(spellID)
        end
    end

    return {
        source = "cooldownViewer",
        cooldownID = cooldownID,
        spellID = spellID,
        stableKey = stableKey,
        name = name or L["Tracked buff"],
        iconID = iconID or 134400,
        untracked = true,
    }
end

function BuffData.GetBuffsForContainer(containerIndex)
    local result = {}
    local assignments = BuffData.GetAssignments()
    local seen = {}
    for _, entry in ipairs(BuffData.GetAllEntries()) do
        if assignments[entry.stableKey] == containerIndex then
            result[#result + 1] = entry
            seen[entry.stableKey] = true
        end
    end
    for stableKey, assignedIndex in pairs(assignments) do
        if assignedIndex == containerIndex and not seen[stableKey] and not BuffData.IsCustomKey(stableKey) then
            local entry = BuildStaleBlizzardEntry(stableKey)
            if entry then
                result[#result + 1] = entry
            end
        end
    end
    SortEntries(result)
    return result
end

function BuffData.GetUnassignedBuffs()
    local count = BuffData.GetContainerCount()
    local result = {}
    for _, entry in ipairs(BuffData.GetAllEntries()) do
        -- Custom auras and wildcards get their own Untracked section instead of
        -- the default Blizzard unassigned bucket.
        if not entry.custom then
            local index = BuffData.GetAssignments()[entry.stableKey]
            if not index or index < 1 or index > count then
                result[#result + 1] = entry
            end
        end
    end
    SortEntries(result)
    return result
end

function BuffData.GetWildcardEntries()
    local result = {}
    for stableKey, definition in pairs(BuffData.GetCustomAuraDefinitions()) do
        if definition and definition.wildcard == true then
            result[#result + 1] = BuildCustomAuraEntry(stableKey, definition)
        end
    end
    SortEntries(result)
    return result
end

function BuffData.GetUnassignedWildcards()
    local count = BuffData.GetContainerCount()
    local result = {}
    for _, entry in ipairs(BuffData.GetWildcardEntries()) do
        local index = BuffData.GetAssignments()[entry.stableKey]
        if not index or index < 1 or index > count then
            result[#result + 1] = entry
        end
    end
    SortEntries(result)
    return result
end

function BuffData.IsEntryAssigned(stableKey)
    local index = BuffData.GetAssignments()[stableKey]
    return index ~= nil and index >= 1 and index <= BuffData.GetContainerCount()
end

function BuffData.GetUntrackedEntries()
    local result = {}
    for _, entry in ipairs(BuffData.GetAllEntries()) do
        if entry.custom then
            if not BuffData.IsEntryAssigned(entry.stableKey) then
                result[#result + 1] = entry
            end
        end
    end
    SortEntries(result)
    return result
end

function BuffData.InsertEntryAt(containerIndex, entry, targetEntry, insertBefore)
    if entry.custom and not BuffData.AreCustomAurasEnabled() then
        return false
    end
    if entry.custom and (not containerIndex or containerIndex < 1 or containerIndex > MAX_CONTAINERS) then
        return false
    end
    if containerIndex and not BuffData.CanAssignToContainer(entry.stableKey, containerIndex) then
        return false, "mixed"
    end

    local entries = containerIndex and BuffData.GetBuffsForContainer(containerIndex) or BuffData.GetUnassignedBuffs()
    for index = #entries, 1, -1 do
        if entries[index].stableKey == entry.stableKey then
            table.remove(entries, index)
            break
        end
    end

    local insertIndex = #entries + 1
    if targetEntry and targetEntry.stableKey then
        for index, candidate in ipairs(entries) do
            if candidate.stableKey == targetEntry.stableKey then
                insertIndex = insertBefore and index or (index + 1)
                break
            end
        end
    end

    table.insert(entries, insertIndex, entry)
    local orders = BuffData.GetOrders()
    for index, candidate in ipairs(entries) do
        orders[candidate.stableKey] = index
    end
    local ok = BuffData.AssignKey(entry.stableKey, containerIndex)
    if not ok then
        return false, "mixed"
    end
    return true
end

function BuffData.SortCooldownFrames(frames)
    local orders = BuffData.GetOrders()
    table.sort(frames, ns.API:BuildOrderComparator(
        function(frame) return orders[BuffData.GetStableKeyForCooldownID(frame:GetCooldownID())] end,
        function(frame) return frame.layoutIndex end,
        function(frame) return frame:GetCooldownID() or 0 end
    ))
end

-- One-time-ish cleanup for containers created before the mixing guard. If a
-- container still holds both custom/wildcard and Blizzard entries, the custom
-- side is moved to Untracked so the custom layout path never touches native
-- Blizzard frames.
function BuffData.MigrateMixedContainers()
    local db = BuffData.GetAssignmentDB()
    local hasCustom = {}
    local hasBlizzard = {}
    for stableKey, index in pairs(db.assignments) do
        if type(index) == "number" and index >= 1 and index <= MAX_CONTAINERS then
            if BuffData.IsCustomKey(stableKey) then
                hasCustom[index] = true
            else
                hasBlizzard[index] = true
            end
        end
    end

    for index in pairs(hasCustom) do
        if hasBlizzard[index] then
            for stableKey, assignedIndex in pairs(db.assignments) do
                if assignedIndex == index and BuffData.IsCustomKey(stableKey) then
                    db.assignments[stableKey] = nil
                    db.orders[stableKey] = nil
                end
            end
        end
    end
end

-- Emptiness is judged from the persistent assignment table, not the current-spec
-- scan: a container "used" only by another spec's buff must keep its slot so the
-- count (and every higher container's index) stays stable across spec swaps.
-- Keeps exactly one empty trailing container (mirrors the custom-tracker
-- "always one spare" rule). Grows the count the moment the last container gains a
-- buff and trims surplus trailing empties. Returns the resolved count.
function BuffData.ReconcileContainerCount()
    BuffData.MigrateMixedContainers()
    local maxUsed = 0
    local db = BuffData.GetAssignmentDB()
    local customAurasEnabled = BuffData.AreCustomAurasEnabled()
    for stableKey, index in pairs(db.assignments) do
        if
            (customAurasEnabled or not BuffData.IsCustomKey(stableKey))
            and type(index) == "number"
            and index > maxUsed
            and index <= MAX_CONTAINERS
        then
            maxUsed = index
        end
    end
    local desired = math.min(math.max(maxUsed + 1, 1), MAX_CONTAINERS)
    db.count = desired
    return desired
end
