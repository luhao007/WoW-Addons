local _, ns = ...
local L = ns.L

local DB = ns.TrackerDB
local ItemsData = ns.TrackerItemsData or {}
ns.TrackerItemsData = ItemsData

local ITEM_EQUIP_FIRST = INVSLOT_FIRST_EQUIPPED or 1
local ITEM_EQUIP_LAST = INVSLOT_LAST_EQUIPPED or 19

local ITEM_STATE_HIDDEN = "hidden"

local ITEM_STATE_TRACKER1 = "tracker1"

local ENTRY_KIND_WILDCARD_SLOTS = "wildcardSlots"
local WILDCARD_SLOT_TRINKET1 = "trinket1"
local WILDCARD_SLOT_TRINKET2 = "trinket2"
local WILDCARD_SLOT_HEALTH_POTION = "healthPotion"
local WILDCARD_SLOT_COMBAT_POTION = "combatPotion"

-- Blizzard's generic item cooldown categories. These are category wildcards,
-- not item IDs: every potion in the category feeds the same tracker entry.
local SPELL_CATEGORY_HEALTH_POTION = 30
local SPELL_CATEGORY_COMBAT_POTION = 4

local IGNORED_WILDCARD_TRINKETS = {
    [248583] = true, -- Drum of Renewed Bonds
    [249806] = true, -- Radiant Plume
    [260235] = true, -- Umbral Plume
}
local AUTO_ATTACK_SPELL_ID = 6603

local IGNORED_FLYOUT_IDS = {
    [1] = true, -- Teleport
    [8] = true, -- Teleport
    [9] = true, -- Call Pet
    [10] = true, -- Summon Demon
    [11] = true, -- Portal
    [12] = true, -- Portal
    [66] = true, -- Poisons
    [67] = true, -- Grimoire of Service
    [84] = true, -- Hero's Path: Mists of Pandaria
    [92] = true, -- Polymorph Variants
    [93] = true, -- Exotic Munitions
    [96] = true, -- Hero's Path: Warlords of Draenor
    [103] = true, -- Pet Utility
    [106] = true, -- Hex Variants
    [217] = true, -- Kyrian Instruments
    [219] = true, -- Adaptation
    [220] = true, -- Hero's Path: Shadowlands
    [222] = true, -- Hero's Path: Shadowlands Raids
    [223] = true, -- Hero's Path: Battle for Azeroth
    [224] = true, -- Hero's Path: Legion
    [225] = true, -- Hunter Tracking
    [226] = true, -- Track Gathering Profession Reagents
    [227] = true, -- Hero's Path: Dragonflight
    [229] = false, -- Skyriding
    [230] = true, -- Hero's Path: Cataclysm
    [231] = true, -- Hero's Path: Dragonflight Raids
    [232] = true, -- Hero's Path: The War Within
    [235] = true, -- Warbands
    [236] = true, -- Number Sequences
    [237] = true, -- Perennius's Sky Arsenal
    [238] = true, -- Sharpen Your Knife
    [239] = false, -- Overload Herbs
    [240] = false, -- Overload Ore
    [241] = true, -- Green Thumb
    [242] = true, -- Hero's Path: War Within Raids
    [243] = true, -- Skyriding Flight Style
    [244] = true, -- Hero's Path: Midnight Season 1
    [245] = true, -- Carve Meat
    [246] = true, -- Hero's Path: Midnight
}

local WILDCARD_SLOT_DISPLAY_NAMES = {
    [WILDCARD_SLOT_TRINKET1] = L["Trinket in first slot"],
    [WILDCARD_SLOT_TRINKET2] = L["Trinket in second slot"],
    [WILDCARD_SLOT_HEALTH_POTION] = L["Health Potion"],
    [WILDCARD_SLOT_COMBAT_POTION] = L["Combat Potion"],
}

local WILDCARD_SLOT_LABELS = {
    [WILDCARD_SLOT_HEALTH_POTION] = "HP",
    [WILDCARD_SLOT_COMBAT_POTION] = "Combat",
}

local WILDCARD_SLOT_SPELL_CATEGORIES = {
    [WILDCARD_SLOT_HEALTH_POTION] = SPELL_CATEGORY_HEALTH_POTION,
    [WILDCARD_SLOT_COMBAT_POTION] = SPELL_CATEGORY_COMBAT_POTION,
}

local WILDCARD_SLOT_ICON_IDS = {
    [WILDCARD_SLOT_HEALTH_POTION] = 134834, -- Blizzard's health potion fallback icon.
    [WILDCARD_SLOT_COMBAT_POTION] = 134737, -- Blizzard's combat potion fallback icon.
}

local WILDCARD_SLOT_INVENTORY_SLOTS = {
    [WILDCARD_SLOT_TRINKET1] = INVSLOT_TRINKET1,
    [WILDCARD_SLOT_TRINKET2] = INVSLOT_TRINKET2,
}

local spellBookCache = nil
local spellBookBaseBySpellID = nil
local normalizedSpellSettings = nil
local normalizedSpellBookCache = nil
local spellCategoryCooldownSources = {}
local wildcardSlotAuraSpellIDs = {}
local SPELLBOOK_EVENTS = {
    ACTIVE_TALENT_GROUP_CHANGED = true,
    PET_BAR_UPDATE = true,
    PLAYER_SPECIALIZATION_CHANGED = true,
    PLAYER_TALENT_UPDATE = true,
    SPELLS_CHANGED = true,
    SPELL_UPDATE_ICON = true,
    TRAIT_CONFIG_UPDATED = true,
    UNIT_PET = true,
}

-- Whether an itemID is trackable (has an on-use spell or proc data) is static for
-- a given item, so memoize it instead of calling C_Item.GetItemSpell on every scan.
local trackableItemCache = {}

-- ScanOwnedItems walks every bag + equipment slot and is called once per tracker
-- per refresh. Ownership only changes on bag/equipment/spellbook changes, so cache
-- the scan result and invalidate it from those events (see the event frame below).
local ownedItemsCache = nil

local function MakeEntry(kind, id)
    return {
        kind = kind,
        id = id,
    }
end

local function IsSpellEntry(entry)
    return entry and entry.kind == "spell"
end

local function IsWildcardSlotEntry(entry)
    return entry and entry.kind == ENTRY_KIND_WILDCARD_SLOTS
end

local function IsWildcardSlotID(slotID)
    return slotID == WILDCARD_SLOT_TRINKET1
        or slotID == WILDCARD_SLOT_TRINKET2
        or slotID == WILDCARD_SLOT_HEALTH_POTION
        or slotID == WILDCARD_SLOT_COMBAT_POTION
end

local function IsSpellCategoryWildcard(slotID)
    return WILDCARD_SLOT_SPELL_CATEGORIES[slotID] ~= nil
end

local function IsTrinketWildcardSlot(slotID)
    return slotID == WILDCARD_SLOT_TRINKET1 or slotID == WILDCARD_SLOT_TRINKET2
end

local function GetWildcardSlotItemID(slotID)
    local inventorySlot = WILDCARD_SLOT_INVENTORY_SLOTS[slotID]
    if not inventorySlot then
        return nil
    end
    local location = ItemLocation:CreateFromEquipmentSlot(inventorySlot)
    if location:IsValid() then
        return C_Item.GetItemID(location)
    end
    return nil
end

local function EntriesEqual(a, b)
    return a and b and a.kind == b.kind and a.id == b.id
end

local function AddSpellIDFromSpellBook(ids, baseBySpellID, actionSpellID, overrideSpellID)
    if not actionSpellID or actionSpellID == AUTO_ATTACK_SPELL_ID then
        return
    end
    if not C_Spell.IsSpellPassive(overrideSpellID or actionSpellID) then
        -- SpellBookItemInfo.actionID is the stable base spell while spellID is the
        -- current override. GetBaseSpell is not reversible for every override
        -- chain, so remember the spellbook relationship explicitly.
        local baseSpellID = C_Spell.GetBaseSpell(actionSpellID) or actionSpellID
        ids[baseSpellID] = true
        baseBySpellID[actionSpellID] = baseSpellID
        baseBySpellID[baseSpellID] = baseSpellID
        if overrideSpellID then
            baseBySpellID[overrideSpellID] = baseSpellID
        end

        local currentOverrideSpellID = C_Spell.GetOverrideSpell(baseSpellID)
        if currentOverrideSpellID then
            baseBySpellID[currentOverrideSpellID] = baseSpellID
        end
    end
end

local function GetSpellIDsFromSpellBook()
    if spellBookCache then
        return spellBookCache
    end

    local ids = {}
    local baseBySpellID = {}
    local spellBank = Enum.SpellBookSpellBank.Player
    local spellItemType = Enum.SpellBookItemType
    local currentSpecID = GetSpecializationInfo(GetSpecialization())

    for skillLineIndex = 1, C_SpellBook.GetNumSpellBookSkillLines() do
        local skillLineInfo = C_SpellBook.GetSpellBookSkillLineInfo(skillLineIndex)
        if skillLineInfo then
            local offset = skillLineInfo.itemIndexOffset or 0
            local numSlots = skillLineInfo.numSpellBookItems or 0
            for spellBookIndex = offset + 1, offset + numSlots do
                local itemInfo = C_SpellBook.GetSpellBookItemInfo(spellBookIndex, spellBank)
                if itemInfo then
                    local itemType = itemInfo.itemType
                    local isOffSpec = C_SpellBook.IsSpellBookItemOffSpec(spellBookIndex, spellBank)

                    if itemType == spellItemType.Spell and not isOffSpec then
                        AddSpellIDFromSpellBook(ids, baseBySpellID, itemInfo.actionID, itemInfo.spellID)
                    elseif
                        itemType == spellItemType.Flyout
                        and not isOffSpec
                        and itemInfo.actionID
                        and not IGNORED_FLYOUT_IDS[itemInfo.actionID]
                    then
                        local _, _, flyoutNumSlots = GetFlyoutInfo(itemInfo.actionID)
                        for flyoutSlot = 1, flyoutNumSlots or 0 do
                            local flyoutSpellID, overrideSpellID, isKnown, _, slotSpecID =
                                GetFlyoutSlotInfo(itemInfo.actionID, flyoutSlot)
                            local isCurrentSpec = not slotSpecID or slotSpecID == 0 or slotSpecID == currentSpecID
                            if isKnown and isCurrentSpec then
                                AddSpellIDFromSpellBook(ids, baseBySpellID, flyoutSpellID, overrideSpellID)
                            end
                        end
                    end
                end
            end
        end
    end

    local petSpellBank = Enum.SpellBookSpellBank.Pet
    local numPetSpells = C_SpellBook.HasPetSpells() or 0
    for spellBookIndex = 1, numPetSpells do
        local itemInfo = C_SpellBook.GetSpellBookItemInfo(spellBookIndex, petSpellBank)
        if itemInfo and itemInfo.spellID then
            -- PetAction.actionID is a pet-action index, not a spell ID. Pet spells
            -- use a stable base spell in actionID just like player spell entries.
            local actionSpellID = itemInfo.itemType == spellItemType.Spell and itemInfo.actionID or itemInfo.spellID
            AddSpellIDFromSpellBook(ids, baseBySpellID, actionSpellID, itemInfo.spellID)
        end
    end

    spellBookCache = ids
    spellBookBaseBySpellID = baseBySpellID
    return ids
end

function ItemsData:InvalidateSpellBookCache()
    spellBookCache = nil
    spellBookBaseBySpellID = nil
end

function ItemsData:GetCanonicalSpellID(spellID)
    local numericSpellID = tonumber(spellID)
    if not numericSpellID then
        return nil
    end

    GetSpellIDsFromSpellBook()
    local mappedBaseSpellID = spellBookBaseBySpellID and spellBookBaseBySpellID[numericSpellID]
    if mappedBaseSpellID then
        return mappedBaseSpellID
    end

    -- The live override can advance beyond the pair returned by GetBaseSpell
    -- (Consume -> Devour is one example). Match it forward from stable spellbook
    -- action IDs before falling back to GetBaseSpell on the input.
    for baseSpellID in pairs(spellBookCache or {}) do
        if C_Spell.GetOverrideSpell(baseSpellID) == numericSpellID then
            spellBookBaseBySpellID[numericSpellID] = baseSpellID
            return baseSpellID
        end
    end

    return C_Spell.GetBaseSpell(numericSpellID) or numericSpellID
end

function ItemsData:GetDisplaySpellID(spellID)
    local baseSpellID = self:GetCanonicalSpellID(spellID)
    if not baseSpellID then
        return nil
    end
    return C_Spell.GetOverrideSpell(baseSpellID) or baseSpellID
end

function ItemsData:GetItemNameByID(itemID)
    if C_Item and C_Item.GetItemNameByID then
        return C_Item.GetItemNameByID(itemID)
    end
    local name = C_Item.GetItemInfo(itemID)
    return name
end

function ItemsData:GetEntryName(kind, id)
    if kind == ENTRY_KIND_WILDCARD_SLOTS then
        return WILDCARD_SLOT_DISPLAY_NAMES[id] or tostring(id)
    end
    if kind == "spell" then
        local displaySpellID = self:GetDisplaySpellID(id) or id
        if C_Spell and C_Spell.GetSpellName then
            return C_Spell.GetSpellName(displaySpellID)
        end
        if GetSpellInfo then
            local name = GetSpellInfo(displaySpellID)
            return name
        end
        return nil
    end
    return self:GetItemNameByID(id)
end

local function GetEntrySettings(entry)
    if entry.wildcardSlotID then
        return DB.GetWildcardSlotSettings(entry.wildcardSlotID)
    end
    if IsWildcardSlotEntry(entry) then
        return DB.GetWildcardSlotSettings(entry.id)
    end
    if IsSpellEntry(entry) then
        return DB.GetSpellItemSettings(entry.id)
    end
    return DB.GetItemSettings(entry.id)
end

local function SortEntries(entries)
    table.sort(entries, function(a, b)
        local aSettings = GetEntrySettings(a)
        local bSettings = GetEntrySettings(b)
        local aOrder = aSettings and aSettings.order or nil
        local bOrder = bSettings and bSettings.order or nil
        if aOrder ~= nil and bOrder ~= nil and aOrder ~= bOrder then
            return aOrder < bOrder
        elseif aOrder ~= nil and bOrder == nil then
            return true
        elseif aOrder == nil and bOrder ~= nil then
            return false
        end
        local aName = ItemsData:GetEntryName(a.kind, a.id)
        aName = (not aName or aName == "") and tostring(a.id) or aName:lower()
        local bName = ItemsData:GetEntryName(b.kind, b.id)
        bName = (not bName or bName == "") and tostring(b.id) or bName:lower()
        if aName ~= bName then
            return aName < bName
        end
        if a.kind ~= b.kind then
            return a.kind < b.kind
        end
        return a.id < b.id
    end)
end

local function GetEntryOrder(entry)
    local settings = GetEntrySettings(entry)
    return settings and settings.order or nil
end

local function SetEntryOrder(entry, order)
    local settings
    if entry.wildcardSlotID then
        settings = DB.EnsureWildcardSlotSettings(entry.wildcardSlotID)
    elseif IsWildcardSlotEntry(entry) then
        settings = DB.EnsureWildcardSlotSettings(entry.id)
    elseif IsSpellEntry(entry) then
        settings = DB.EnsureSpellItemSettings(entry.id)
    else
        settings = DB.EnsureItemSettings(entry.id)
    end
    settings.order = order
end

local function EnsureOrderForEntries(entries)
    local maxOrder = 0
    for _, entry in ipairs(entries) do
        local order = GetEntryOrder(entry)
        if order and order > maxOrder then
            maxOrder = order
        end
    end

    for _, entry in ipairs(entries) do
        if GetEntryOrder(entry) == nil then
            maxOrder = maxOrder + 1
            SetEntryOrder(entry, maxOrder)
        end
    end
end

function ItemsData:InsertItemAt(state, entry, targetEntry, insertBefore)
    if not entry then
        return
    end

    local entries = self:GetEntriesByState(state)
    local existingIndex = nil
    for index, candidate in ipairs(entries) do
        if EntriesEqual(candidate, entry) then
            existingIndex = index
            break
        end
    end

    if existingIndex then
        table.remove(entries, existingIndex)
    end

    local insertIndex = #entries + 1
    if targetEntry then
        for index, candidate in ipairs(entries) do
            if EntriesEqual(candidate, targetEntry) then
                insertIndex = insertBefore and index or (index + 1)
                break
            end
        end
    end

    table.insert(entries, insertIndex, MakeEntry(entry.kind, entry.id))
    for index, e in ipairs(entries) do
        SetEntryOrder(e, index)
    end
end

function ItemsData:GetEntryState(kind, id)
    if kind == ENTRY_KIND_WILDCARD_SLOTS then
        return DB.GetWildcardSlotState(id)
    end
    if kind == "spell" then
        return DB.GetSpellItemState(id)
    end
    return DB.GetItemState(id)
end

function ItemsData:SetEntryState(kind, id, state)
    if kind == ENTRY_KIND_WILDCARD_SLOTS then
        DB.SetWildcardSlotState(id, state)
        return
    end
    if kind == "spell" then
        local baseSpellID = self:GetCanonicalSpellID(id)
        if baseSpellID then
            DB.SetSpellItemState(baseSpellID, state)
        end
    else
        DB.SetItemState(id, state)
    end
end

-- Proc trinkets often have no on-use spell (their effect is an equip proc), so
-- GetItemSpell can't see them. Treat anything with proc data as trackable too.
local function IsProcDataItem(itemID)
    local data = ns.TrackerAuraData
    return itemID ~= nil and data ~= nil and data.procByItemID ~= nil and data.procByItemID[itemID] ~= nil
end

-- returns true for items that have an on-use spell or proc data, false otherwise. Memoized true for performance.
local function IsTrackableItem(itemID)
    if not itemID then
        return false
    end
    local cached = trackableItemCache[itemID]
    if cached ~= nil then
        return cached
    end
    local result = (C_Item.GetItemSpell(itemID) ~= nil) or IsProcDataItem(itemID)
    if result then
        trackableItemCache[itemID] = result
    end
    return result
end

local function IsPassiveTrinket(itemID)
    return itemID ~= nil and C_Item.GetItemSpell(itemID) == nil
end

local function IsTrackableWildcardSlot(slotID)
    local itemID = GetWildcardSlotItemID(slotID)
    if itemID == nil or IGNORED_WILDCARD_TRINKETS[itemID] or not IsTrackableItem(itemID) then
        return false
    end
    if not DB.GetShowingPassiveTrinkets() and IsPassiveTrinket(itemID) then
        return false
    end
    return true
end

local function DoScanOwnedItems()
    local owned = {
        items = {},
        spells = {},
        wildcardSlots = {},
    }

    if C_Container and NUM_BAG_SLOTS then
        for bag = 0, NUM_BAG_SLOTS do
            local slots = C_Container.GetContainerNumSlots(bag)
            for slot = 1, slots do
                local itemID = C_Container.GetContainerItemID(bag, slot)
                if itemID then
                    local classID = select(6, C_Item.GetItemInfoInstant(itemID))
                    if classID == Enum.ItemClass.Consumable then
                        owned.items[itemID] = true
                    end
                end
            end
        end
    end

    for slot = ITEM_EQUIP_FIRST, ITEM_EQUIP_LAST do
        local location = ItemLocation:CreateFromEquipmentSlot(slot)
        if location and C_Item.DoesItemExist(location) then
            local itemID = C_Item.GetItemID(location)
            if itemID and IsTrackableItem(itemID) then
                owned.items[itemID] = true
            end
        end
    end

    for spellID in pairs(GetSpellIDsFromSpellBook()) do
        owned.spells[spellID] = true
    end

    owned.wildcardSlots[WILDCARD_SLOT_TRINKET1] = true
    owned.wildcardSlots[WILDCARD_SLOT_TRINKET2] = true
    owned.wildcardSlots[WILDCARD_SLOT_HEALTH_POTION] = true
    owned.wildcardSlots[WILDCARD_SLOT_COMBAT_POTION] = true

    return owned
end

-- Cached entry point. Consumers (EnsureTrackedItems, GetTrackerEntries,
-- CleanupHiddenEntries) treat the result as read-only, so a shared table is safe.
function ItemsData:ScanOwnedItems()
    if ownedItemsCache then
        return ownedItemsCache
    end
    ownedItemsCache = DoScanOwnedItems()
    return ownedItemsCache
end

-- Drops the cached ownership scan; rebuilt lazily on the next ScanOwnedItems call.
function ItemsData:InvalidateOwnedItemsCache()
    ownedItemsCache = nil
end

function ItemsData:ScanOwnedItemsForMiscPanel()
    local owned = DoScanOwnedItems()
    -- Runtime ownership only needs configured spells. The assignment panel must
    -- also seed every active-spec spell so new entries appear in Not Displayed.
    for spellID in pairs(GetSpellIDsFromSpellBook()) do
        owned.spells[spellID] = true
    end
    return owned
end

local ownedItemsEventFrame = CreateFrame("Frame")
for _, event in ipairs({
    "BAG_UPDATE_DELAYED",
    "PLAYER_EQUIPMENT_CHANGED",
    "ITEM_LOCKED",
    "PLAYER_ENTERING_WORLD",
    "PLAYER_SPECIALIZATION_CHANGED",
    "ACTIVE_TALENT_GROUP_CHANGED",
    "TRAIT_CONFIG_UPDATED",
    "PLAYER_TALENT_UPDATE",
    "SPELLS_CHANGED",
    "SPELL_UPDATE_ICON",
    "PET_BAR_UPDATE",
    "UNIT_PET",
}) do
    ownedItemsEventFrame:RegisterEvent(event)
end
ownedItemsEventFrame:SetScript("OnEvent", function(_, event, unit)
    if event == "UNIT_PET" and unit ~= "player" then
        return
    end
    ownedItemsCache = nil
    if SPELLBOOK_EVENTS[event] then
        spellBookCache = nil
        spellBookBaseBySpellID = nil
    end
    if event == "PLAYER_ENTERING_WORLD" then
        wipe(trackableItemCache)
    end
    if event == "SPELL_UPDATE_ICON" or event == "PET_BAR_UPDATE" or event == "UNIT_PET" then
        C_Timer.After(0.05, function()
            local panel = _G.CMCCooldownViewerSettingsTrackerPanel
            if panel and panel:IsShown() and ns.TrackerAssignmentPanel then
                ns.TrackerAssignmentPanel:RefreshTrackerPanel()
            end
        end)
    end
end)

function ItemsData:NormalizeStoredSpellIDs()
    GetSpellIDsFromSpellBook()
    local db = DB.GetDB()
    local settingsBySpellID = db.spellItemSettings or {}
    if normalizedSpellSettings == settingsBySpellID and normalizedSpellBookCache == spellBookCache then
        return
    end

    local migrations = {}
    for spellID, settings in pairs(settingsBySpellID) do
        local baseSpellID = self:GetCanonicalSpellID(spellID)
        if baseSpellID and baseSpellID ~= spellID then
            migrations[#migrations + 1] = { spellID, baseSpellID, settings }
        end
    end

    for _, migration in ipairs(migrations) do
        local spellID, baseSpellID, settings = unpack(migration)
        local baseSettings = settingsBySpellID[baseSpellID]
        if not baseSettings then
            settingsBySpellID[baseSpellID] = settings
        else
            for key, value in pairs(settings) do
                if baseSettings[key] == nil or (key == "state" and baseSettings.state == ITEM_STATE_HIDDEN) then
                    baseSettings[key] = value
                end
            end
        end
        settingsBySpellID[spellID] = nil
    end

    normalizedSpellSettings = settingsBySpellID
    normalizedSpellBookCache = spellBookCache
end

function ItemsData:EnsureTrackedItems(owned)
    self:NormalizeStoredSpellIDs()
    local ownedItems = owned and owned.items or {}
    local ownedSpells = owned and owned.spells or {}
    local ownedWildcardSlots = owned and owned.wildcardSlots or {}

    for itemID in pairs(ownedItems) do
        local state = DB.GetItemState(itemID)
        if state == nil then
            DB.SetItemState(itemID, ITEM_STATE_HIDDEN)
        end
    end

    for spellID in pairs(ownedSpells) do
        local state = DB.GetSpellItemState(spellID)
        if state == nil then
            DB.SetSpellItemState(spellID, ITEM_STATE_HIDDEN)
        end
    end

    for slotID in pairs(ownedWildcardSlots) do
        if IsWildcardSlotID(slotID) then
            local state = DB.GetWildcardSlotState(slotID)
            if state == nil then
                DB.SetWildcardSlotState(slotID, ITEM_STATE_HIDDEN)
            end
        end
    end
end

function ItemsData:GetEntriesByState(state)
    local entries = {}
    local db = DB.GetDB()

    for itemID, settings in pairs(db.itemSettings or {}) do
        if settings.state == state then
            table.insert(entries, MakeEntry("item", itemID))
        end
    end

    for spellID, settings in pairs(db.spellItemSettings or {}) do
        if settings.state == state then
            table.insert(entries, MakeEntry("spell", spellID))
        end
    end

    for slotID, settings in pairs(db.wildcardSlotSettings or {}) do
        if settings.state == state and IsWildcardSlotID(slotID) then
            table.insert(entries, MakeEntry(ENTRY_KIND_WILDCARD_SLOTS, slotID))
        end
    end

    EnsureOrderForEntries(entries)
    SortEntries(entries)
    return entries
end

function ItemsData:CleanupHiddenEntries(owned)
    local ownedItems = owned and owned.items or {}
    local ownedSpells = owned and owned.spells or {}

    local db = DB.GetDB()
    for itemID, settings in pairs(db.itemSettings or {}) do
        if settings.state == ITEM_STATE_HIDDEN and not ownedItems[itemID] then
            DB.SetItemState(itemID, nil)
        end
    end

    for spellID, settings in pairs(db.spellItemSettings or {}) do
        if settings.state == ITEM_STATE_HIDDEN and not ownedSpells[spellID] then
            DB.SetSpellItemState(spellID, nil)
        end
    end
end

function ItemsData:GetItemIDsByState(state)
    local entries = self:GetEntriesByState(state)
    local ids = {}
    for _, entry in ipairs(entries) do
        if entry.kind == "item" then
            table.insert(ids, entry.id)
        end
    end
    return ids
end

-- Returns the item-state string for tracker `index` (1-based): "tracker1", "tracker2", ...
function ItemsData:GetTrackerStateName(index)
    return "tracker" .. index
end

-- Returns the numeric tracker index for a state string, or nil if it isn't a tracker state.
function ItemsData:GetTrackerIndexFromState(state)
    if type(state) ~= "string" then
        return nil
    end
    local n = state:match("^tracker(%d+)$")
    return n and tonumber(n) or nil
end

-- True when `state` names a tracker bucket (as opposed to "hidden" / nil).
function ItemsData:IsTrackerState(state)
    return self:GetTrackerIndexFromState(state) ~= nil
end

-- Returns the displayable entries assigned to tracker `index`, honouring `owned`
-- filtering (unowned entries are skipped unless alwaysShow) and resolving wildcard
-- slots to plain item entries so downstream handling is uniform.
function ItemsData:GetTrackerEntries(index, owned)
    local state = self:GetTrackerStateName(index)
    local entries = {}
    local db = DB.GetDB()
    local ownedItems = owned and owned.items or {}
    local ownedSpells = owned and owned.spells or {}
    local ownedWildcardSlots = owned and owned.wildcardSlots or {}
    local addedItemIDs = {} -- prevent duplicate entries when a wildcard item is also explicitly tracked

    for itemID, settings in pairs(db.itemSettings or {}) do
        if
            settings.state == state
            and not DB.IsHiddenForCurrentSpec("item", itemID)
            and (ownedItems[itemID] or settings.alwaysShow)
        then
            local e = MakeEntry("item", itemID)
            addedItemIDs[itemID] = true
            table.insert(entries, e)
        end
    end

    for spellID, settings in pairs(db.spellItemSettings or {}) do
        if
            settings.state == state
            and not DB.IsHiddenForCurrentSpec("spell", spellID)
            and (ownedSpells[spellID] or settings.alwaysShow)
        then
            local e = MakeEntry("spell", spellID)
            table.insert(entries, e)
        end
    end

    -- Wildcard slots are resolved to plain item entries so the tracker handles them
    -- identically to explicitly-tracked items (no special-casing needed downstream).
    for slotID, settings in pairs(db.wildcardSlotSettings or {}) do
        if
            settings.state == state
            and not DB.IsHiddenForCurrentSpec(ENTRY_KIND_WILDCARD_SLOTS, slotID)
            and (ownedWildcardSlots[slotID] or settings.alwaysShow)
            and (IsSpellCategoryWildcard(slotID) or IsTrackableWildcardSlot(slotID))
        then
            if IsSpellCategoryWildcard(slotID) then
                table.insert(entries, MakeEntry(ENTRY_KIND_WILDCARD_SLOTS, slotID))
            else
                local itemID = GetWildcardSlotItemID(slotID)
                if itemID and not addedItemIDs[itemID] then
                    local e = MakeEntry("item", itemID)
                    e.wildcardSlotID = slotID -- retains slot identity for ordering and instant-remove
                    table.insert(entries, e)
                end
            end
        end
    end

    EnsureOrderForEntries(entries)
    SortEntries(entries)
    return entries
end

-- True when no item / spell / wildcard slot is assigned to tracker `index`,
-- regardless of ownership. Used to gate removal of the trailing tracker.
function ItemsData:IsTrackerEmpty(index)
    local state = self:GetTrackerStateName(index)
    local db = DB.GetDB()
    for _, settings in pairs(db.itemSettings or {}) do
        if settings.state == state then
            return false
        end
    end
    for _, settings in pairs(db.spellItemSettings or {}) do
        if settings.state == state then
            return false
        end
    end
    for _, settings in pairs(db.wildcardSlotSettings or {}) do
        if settings.state == state then
            return false
        end
    end
    return true
end

ItemsData.ITEM_STATE_HIDDEN = ITEM_STATE_HIDDEN
ItemsData.ITEM_STATE_TRACKER1 = ITEM_STATE_TRACKER1
ItemsData.ENTRY_KIND_WILDCARD_SLOTS = ENTRY_KIND_WILDCARD_SLOTS
ItemsData.WILDCARD_SLOT_TRINKET1 = WILDCARD_SLOT_TRINKET1
ItemsData.WILDCARD_SLOT_TRINKET2 = WILDCARD_SLOT_TRINKET2
ItemsData.WILDCARD_SLOT_HEALTH_POTION = WILDCARD_SLOT_HEALTH_POTION
ItemsData.WILDCARD_SLOT_COMBAT_POTION = WILDCARD_SLOT_COMBAT_POTION
ItemsData.SPELL_CATEGORY_HEALTH_POTION = SPELL_CATEGORY_HEALTH_POTION
ItemsData.SPELL_CATEGORY_COMBAT_POTION = SPELL_CATEGORY_COMBAT_POTION

function ItemsData:GetWildcardSlotItemID(slotID)
    return GetWildcardSlotItemID(slotID)
end

function ItemsData:GetWildcardSlotSpellCategory(slotID)
    return WILDCARD_SLOT_SPELL_CATEGORIES[slotID]
end

-- The combat-potion wildcard is a forced Set Aura preset. Keep the source in
-- BuffPresetData so the generated 12.1 potion catalog remains the single list
-- of accepted buff spell IDs; this does not write anything into the profile.
function ItemsData:GetWildcardSlotAuraSpellIDs(slotID)
    if slotID ~= WILDCARD_SLOT_COMBAT_POTION then
        return nil
    end

    if wildcardSlotAuraSpellIDs[slotID] then
        return wildcardSlotAuraSpellIDs[slotID]
    end

    local data = ns.BuffPresetData
    local potionGroups = data and (data.potions or data.potion)
    if type(potionGroups) ~= "table" then
        return nil
    end

    local result = {}
    local seen = {}
    for _, group in ipairs(potionGroups) do
        if group.key == "COMBAT_POTION" then
            for _, spellID in ipairs(group.spellIDs or {}) do
                spellID = tonumber(spellID)
                if spellID and spellID > 0 and not seen[spellID] then
                    seen[spellID] = true
                    result[#result + 1] = spellID
                end
            end
            break
        end
    end

    if #result > 0 then
        wildcardSlotAuraSpellIDs[slotID] = result
        return result
    end
    return nil
end

function ItemsData:SetSpellCategoryCooldownSource(category, spellID)
    if category and spellID then
        spellCategoryCooldownSources[category] = spellID
    end
end

function ItemsData:GetSpellCategoryCooldownSource(category)
    if not category then
        return nil
    end
    if C_Spell and C_Spell.GetLastCategoryCooldownSource then
        local spellID = C_Spell.GetLastCategoryCooldownSource(category)
        if spellID then
            return spellID
        end
    end
    return spellCategoryCooldownSources[category]
end

function ItemsData:GetWildcardSlotIcon(slotID)
    return WILDCARD_SLOT_ICON_IDS[slotID]
end

function ItemsData:GetWildcardSlotLabel(slotID)
    return WILDCARD_SLOT_LABELS[slotID]
end

function ItemsData:IsSpellCategoryWildcard(slotID)
    return IsSpellCategoryWildcard(slotID)
end

function ItemsData:IsTrinketWildcardSlot(slotID)
    return IsTrinketWildcardSlot(slotID)
end

function ItemsData:GetEntryOrder(entry)
    return GetEntryOrder(entry)
end

function ItemsData:IsTrackableItem(itemID)
    return IsTrackableItem(itemID)
end

function ItemsData:IsTrackableWildcardSlot(slotID)
    return IsTrackableWildcardSlot(slotID)
end
