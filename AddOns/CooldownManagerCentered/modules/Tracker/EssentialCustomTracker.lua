local _, ns = ...

local Affected = ns.API.Affected
local DB = ns.TrackerDB
local ItemsData = ns.TrackerItemsData
local ItemViewer = ns.TrackerItemViewer
local Pixel = ns.PixelPerfect

local EssentialCustomTracker = {}
ns.EssentialCustomTracker = EssentialCustomTracker

local STATE = "essential"
local host
local pixelRoot
local icons = {}
local initialized = false
local refreshing = false
local combinedBoundsGettersInstalled = false
local REFRESH_DELAY = 0.05
local refreshScheduled = false
local fullRefreshPending = false

local function QueueRefresh(fullRefresh)
    fullRefreshPending = fullRefreshPending or fullRefresh == true
    if refreshScheduled then
        return
    end
    refreshScheduled = true
    C_Timer.After(REFRESH_DELAY, function()
        refreshScheduled = false
        local runFullRefresh = fullRefreshPending
        fullRefreshPending = false
        if not initialized or not ns.db.profile.tracker_enabled then
            return
        end
        if runFullRefresh then
            EssentialCustomTracker:Refresh()
        else
            EssentialCustomTracker:RefreshCooldowns()
        end
    end)
end

local EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "PLAYER_EQUIPMENT_CHANGED",
    "BAG_UPDATE_DELAYED",
    "BAG_UPDATE_COOLDOWN",
    "SPELL_UPDATE_COOLDOWN",
    "SPELL_UPDATE_CHARGES",
    "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW",
    "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE",
    "SPELL_UPDATE_ICON",
    "SPELLS_CHANGED",
    "PET_BAR_UPDATE",
    "UNIT_PET",
    "TRAIT_CONFIG_UPDATED",
    "PLAYER_SPECIALIZATION_CHANGED",
}

local function GetEntrySettings(kind, id, ensure, wildcardSlotID)
    if wildcardSlotID then
        return ensure and DB.EnsureWildcardSlotSettings(wildcardSlotID) or DB.GetWildcardSlotSettings(wildcardSlotID)
    end
    if kind == "spell" then
        return ensure and DB.EnsureSpellItemSettings(id) or DB.GetSpellItemSettings(id)
    elseif kind == "item" then
        return ensure and DB.EnsureItemSettings(id) or DB.GetItemSettings(id)
    end
    return ensure and DB.EnsureWildcardSlotSettings(id) or DB.GetWildcardSlotSettings(id)
end

local function GetNativeEntries()
    local result = {}
    local viewer = _G.EssentialCooldownViewer
    if not viewer or not viewer.GetItemFrames then
        return result
    end

    for _, frame in ipairs(viewer:GetItemFrames()) do
        if frame.layoutIndex and frame.cooldownID then
            local info = C_CooldownViewer.GetCooldownViewerCooldownInfo(frame.cooldownID)
            result[#result + 1] = {
                kind = "native",
                id = frame.cooldownID,
                spellID = info and (info.overrideSpellID or info.spellID),
                order = frame.layoutIndex,
                native = true,
            }
        end
    end
    table.sort(result, function(a, b)
        return a.order < b.order
    end)
    return result
end

local function GetCustomEntries(includeUnavailable, keepWildcardSlots, includeSpecHidden)
    local result = {}
    local owned = not includeUnavailable and ItemsData:ScanOwnedItems() or nil
    local wildcardEntries = {}
    local addedItemIDs = {}
    for _, entry in ipairs(ItemsData:GetEntriesByState(STATE)) do
        local settings = GetEntrySettings(entry.kind, entry.id)
        if entry.kind == ItemsData.ENTRY_KIND_WILDCARD_SLOTS and not keepWildcardSlots then
            wildcardEntries[#wildcardEntries + 1] = entry
        else
            local available = includeUnavailable or entry.kind == ItemsData.ENTRY_KIND_WILDCARD_SLOTS
            if not available and (includeSpecHidden or not DB.IsHiddenForCurrentSpec(entry.kind, entry.id)) then
                if entry.kind == "spell" then
                    available = owned and owned.spells[entry.id] or (settings and settings.alwaysShow)
                elseif entry.kind == "item" then
                    available = owned and owned.items[entry.id] or (settings and settings.alwaysShow)
                end
            end
            if available then
                result[#result + 1] = {
                    kind = entry.kind,
                    id = entry.id,
                    order = settings and settings.order,
                    native = false,
                }
                if entry.kind == "item" then
                    addedItemIDs[entry.id] = true
                end
            end
        end
    end

    -- Runtime mirrors custom trackers: keep category wildcards as categories,
    -- while resolving trinket wildcards to the currently equipped item.
    for _, entry in ipairs(wildcardEntries) do
        local settings = GetEntrySettings(entry.kind, entry.id)
        if
            not DB.IsHiddenForCurrentSpec(entry.kind, entry.id)
            and ItemsData.IsSpellCategoryWildcard
            and ItemsData:IsSpellCategoryWildcard(entry.id)
        then
            result[#result + 1] = {
                kind = entry.kind,
                id = entry.id,
                wildcardSlotID = entry.id,
                order = settings and settings.order,
                native = false,
            }
        elseif not DB.IsHiddenForCurrentSpec(entry.kind, entry.id) and ItemsData:IsTrackableWildcardSlot(entry.id) then
            local itemID = ItemsData:GetWildcardSlotItemID(entry.id)
            if itemID and not addedItemIDs[itemID] then
                result[#result + 1] = {
                    kind = "item",
                    id = itemID,
                    wildcardSlotID = entry.id,
                    order = settings and settings.order,
                    native = false,
                }
                addedItemIDs[itemID] = true
            end
        end
    end
    return result
end

local function GetCombinedEntries(includeUnavailable, keepWildcardSlots, includeSpecHidden)
    local entries = GetNativeEntries()
    local nativeCount = #entries
    local nextOrder = nativeCount + 0.1
    for _, entry in ipairs(GetCustomEntries(includeUnavailable, keepWildcardSlots, includeSpecHidden)) do
        if type(entry.order) ~= "number" then
            entry.order = nextOrder
            GetEntrySettings(entry.kind, entry.id, true, entry.wildcardSlotID).order = entry.order
            nextOrder = nextOrder + 0.1
        end
        entries[#entries + 1] = entry
    end
    table.sort(entries, function(a, b)
        if a.order ~= b.order then
            return a.order < b.order
        end
        if a.native ~= b.native then
            return a.native
        end
        if a.kind ~= b.kind then
            return a.kind < b.kind
        end
        return tostring(a.id) < tostring(b.id)
    end)
    return entries
end

local function SyncVisibility()
    local viewer = _G.EssentialCooldownViewer
    if not host or not viewer then
        return
    end
    host:SetAlpha(viewer:GetAlpha())
    host:SetShown(viewer:IsShown())
end

local function HasCombinedBounds()
    if not host or not ns.db.profile.tracker_enabled then
        return false
    end

    for _, icon in ipairs(icons) do
        if icon.frame:IsShown() then
            return true
        end
    end
    return false
end

-- Experimental compatibility shim for addons that read the Essential viewer's
-- dimensions. The native frame keeps its protected physical size, while its Lua
-- getters report the unprotected proxy's combined native + custom icon bounds.
local function InstallCombinedBoundsGetters(viewer)
    if combinedBoundsGettersInstalled then
        return
    end
    combinedBoundsGettersInstalled = true

    local function Wrap(methodName)
        local original = viewer[methodName]
        viewer[methodName] = function(self, nativeOnly)
            if self == viewer and not nativeOnly and HasCombinedBounds() then
                return host[methodName](host)
            end
            return original(self, nativeOnly)
        end
    end

    Wrap("GetWidth")
    Wrap("GetHeight")
    Wrap("GetSize")
end

local function ApplyEssentialIntegrations()
    if ns.Sizes then
        for _, icon in ipairs(icons) do
            ns.Sizes.TagViewerChild(icon.frame, "Essential")
        end
    end
    if ns.StyledIcons then
        ns.StyledIcons:RefreshViewer("EssentialCooldownViewer")
    end
    if ns.CooldownFont then
        ns.CooldownFont:RefreshViewer("EssentialCooldownViewer")
    end
    if ns.Stacks then
        ns.Stacks:ApplyStackFonts("EssentialCooldownViewer")
    end
    if ns.Keybinds then
        ns.Keybinds:UpdateViewerKeybinds("EssentialCooldownViewer")
    end
    if ns.Assistant then
        ns.Assistant:UpdateViewerHighlights("EssentialCooldownViewer")
    end
    if ns.CooldownStyle then
        ns.CooldownStyle:RefreshAllGlows()
    end
    if ns.ButtonPress and ns.ButtonPress.InvalidateIconMap then
        ns.ButtonPress:InvalidateIconMap()
    end
end

function EssentialCustomTracker:GetStateName()
    return STATE
end

function EssentialCustomTracker:GetSettingsEntries()
    return GetCombinedEntries(DB.GetShowingUnusable(), true, true)
end

function EssentialCustomTracker:GetItemFrames()
    local result = {}
    for _, icon in ipairs(icons) do
        if icon.frame:IsShown() then
            result[#result + 1] = icon.frame
        end
    end
    return result
end

-- Essential already needs an unprotected layout proxy for its injected icons.
-- Keep that single proxy alive for every Essential layout and use it as the
-- pixel-perfect root for native and custom icons alike.
function EssentialCustomTracker:EnsureLayoutHost()
    if host then
        return host
    end

    local viewer = _G.EssentialCooldownViewer
    if not viewer then
        return nil
    end

    host = CreateFrame("Frame", "CMCEssentialCustomTrackerHost", UIParent)
    Pixel.SetSize(host, 1, 1, 1, 1)
    host:SetFrameStrata(viewer:GetFrameStrata())
    host:SetFrameLevel(viewer:GetFrameLevel())
    host:EnableMouse(false)
    pixelRoot = Pixel.EnsureContainer(host)
    InstallCombinedBoundsGetters(viewer)

    viewer:HookScript("OnShow", SyncVisibility)
    viewer:HookScript("OnHide", SyncVisibility)
    hooksecurefunc(viewer, "SetAlpha", SyncVisibility)
    hooksecurefunc(viewer, "SetTooltipsShown", function(_, shown)
        EssentialCustomTracker:SetTooltipsShown(shown)
    end)
    hooksecurefunc(viewer, "RefreshLayout", function()
        QueueRefresh(true)
    end)
    SyncVisibility()
    return host
end

function EssentialCustomTracker:GetLayoutHost()
    return host
end

-- The host doubles as an invisible, unprotected layout proxy. It follows the
-- wall of the real Essential viewer that the combined grid grows from; Edit Mode
-- still moves only the Blizzard viewer, and the proxy follows through this anchor.
function EssentialCustomTracker:PrepareLayoutFrame(isHorizontal, fromDirection)
    local viewer = _G.EssentialCooldownViewer
    local layoutHost = self:EnsureLayoutHost()
    if not layoutHost or not viewer then
        return viewer
    end

    local wall
    if isHorizontal then
        wall = fromDirection == "BOTTOM" and "BOTTOM" or "TOP"
    else
        wall = fromDirection == "BOTTOM" and "RIGHT" or "LEFT"
    end
    local point, relativeTo, relativePoint, oldX, oldY = host:GetPoint()
    if
        point ~= wall
        or relativeTo ~= viewer
        or relativePoint ~= wall
        or math.abs(oldX or 0) > 0.001
        or math.abs(oldY or 0) > 0.001
    then
        host:ClearAllPoints()
        host:SetPoint(wall, viewer, wall, 0, 0)
    end
    host:SetFrameStrata(viewer:GetFrameStrata())
    host:SetFrameLevel(viewer:GetFrameLevel())
    pixelRoot = Pixel.SyncContainer(host)
    return pixelRoot or host
end

function EssentialCustomTracker:GetTrackedSpellIDs()
    local spellIDs = {}
    for _, icon in ipairs(icons) do
        local frame = icon.frame
        if frame:IsShown() and frame.spellID then
            spellIDs[frame.spellID] = true
        end
    end
    return spellIDs
end

function EssentialCustomTracker:RefreshUsabilityTints()
    for _, icon in ipairs(icons) do
        if icon.frame:IsShown() then
            ns.TrackerItemVisuals:ApplyUsabilityTint(icon.frame)
            ns.TrackerItemVisuals:RefreshEntryUsabilityGlow(icon.frame)
        end
    end
end

function EssentialCustomTracker:RefreshSuggestedGlows()
    for _, icon in ipairs(icons) do
        if icon.frame:IsShown() then
            ns.TrackerItemVisuals:RefreshEntrySuggestedGlow(icon.frame)
        end
    end
end

function EssentialCustomTracker:SetTooltipsShown(shown)
    for _, icon in ipairs(icons) do
        icon:SetTooltipsShown(shown)
    end
end

function EssentialCustomTracker:EnsureEntryOrder(kind, id)
    local settings = GetEntrySettings(kind, id, true)
    local nativeCount = #GetNativeEntries()
    local maxOrder = nativeCount
    for _, entry in ipairs(GetCustomEntries(true, true)) do
        if (entry.kind ~= kind or entry.id ~= id) and type(entry.order) == "number" then
            maxOrder = math.max(maxOrder, entry.order)
        end
    end
    settings.order = maxOrder + 0.1
    self:Refresh()
end

function EssentialCustomTracker:MoveEntry(kind, id, targetKind, targetID, insertBefore)
    local combined = GetCombinedEntries(true, true)
    local sourceIndex, targetIndex
    for index, entry in ipairs(combined) do
        if not entry.native and entry.kind == kind and entry.id == id then
            sourceIndex = index
        end
        if entry.kind == targetKind and entry.id == targetID then
            targetIndex = index
        end
    end
    if not sourceIndex or not targetIndex then
        return
    end

    local source = table.remove(combined, sourceIndex)
    if sourceIndex < targetIndex then
        targetIndex = targetIndex - 1
    end
    local insertIndex = insertBefore and targetIndex or (targetIndex + 1)
    table.insert(combined, insertIndex, source)

    local previous = combined[insertIndex - 1]
    local following = combined[insertIndex + 1]
    local order
    if previous and following then
        order = (previous.order + following.order) / 2
    elseif previous then
        order = previous.order + 0.1
    elseif following then
        order = following.order - 0.1
    else
        order = 0.1
    end
    GetEntrySettings(kind, id, true).order = order
    self:Refresh()
end

function EssentialCustomTracker:RefreshCooldowns()
    for _, icon in ipairs(icons) do
        icon:UpdateCooldown()
    end
end

function EssentialCustomTracker:RefreshSpellCooldown(spellID)
    if not spellID then
        return
    end
    local baseSpellID = C_Spell.GetBaseSpell(spellID) or spellID
    for _, icon in ipairs(icons) do
        local frameSpellID = icon.frame.spellID
        if frameSpellID then
            local frameBaseSpellID = C_Spell.GetBaseSpell(frameSpellID) or frameSpellID
            if frameSpellID == spellID or frameBaseSpellID == baseSpellID then
                icon:UpdateCooldown()
            end
        end
    end
end

function EssentialCustomTracker:RefreshItemCooldown(itemID)
    if not itemID then
        return
    end
    for _, icon in ipairs(icons) do
        if icon.frame.itemID == itemID then
            icon:UpdateCooldown()
        end
    end
end

function EssentialCustomTracker:RefreshSpellCategoryCooldown(spellCategory)
    if not spellCategory then
        return
    end
    for _, icon in ipairs(icons) do
        if icon.frame:IsShown() and icon.frame.spellCategoryID == spellCategory then
            icon:UpdateCooldown()
        end
    end
end

function EssentialCustomTracker:Hide()
    if host then
        host:UnregisterAllEvents()
        for _, icon in ipairs(icons) do
            icon.frame:Hide()
        end
        SyncVisibility()
    end
end

function EssentialCustomTracker:Refresh()
    if refreshing or not initialized or not ns.db.profile.tracker_enabled then
        if host and not ns.db.profile.tracker_enabled then
            for _, icon in ipairs(icons) do
                icon.frame:Hide()
            end
            SyncVisibility()
        end
        return
    end
    refreshing = true

    local entries = {}
    for _, entry in ipairs(GetCombinedEntries()) do
        if not entry.native then
            entries[#entries + 1] = entry
        end
    end
    local viewer = _G.EssentialCooldownViewer
    local width, height = ns.Sizes.GetViewerIconSize("Essential")
    for index, entry in ipairs(entries) do
        if not icons[index] then
            icons[index] = ItemViewer:CreateStandaloneFrame(host)
        end
        local icon = icons[index]
        icon.frame:SetScale((viewer and viewer.iconScale) or 1)
        Pixel.SetSize(icon.frame, width, height, 1, 1)
        icon.frame.showGCD = true
        icon.frame.rangeIndicator = true
        icon.frame.requireResource = true
        icon:SetTooltipsShown(not viewer or viewer.tooltipsShown ~= false)
        icon.frame.Icon:SetTexCoord(0, 1, 0, 1)
        if not icon.frame.OutOfRange then
            icon.frame.OutOfRange = icon.frame:CreateTexture(nil, "OVERLAY", nil, 2)
            icon.frame.OutOfRange:SetAllPoints(icon.frame)
            icon.frame.OutOfRange:SetAtlas("UI-CooldownManager-OORshadow")
            icon.frame.OutOfRange:SetAlpha(0.5)
            icon.frame.OutOfRange:Hide()
        end
        if icon.frame.mask and icon.frame.mask.SetAtlas then
            icon.frame.mask:SetAtlas("UI-HUD-CoolDownManager-Mask")
        end
        if icon.frame.IconOverlay then
            icon.frame.IconOverlay:ClearAllPoints()
            icon.frame.IconOverlay:SetPoint("TOPLEFT", icon.frame.Icon, "TOPLEFT", -9, 8)
            icon.frame.IconOverlay:SetPoint("BOTTOMRIGHT", icon.frame.Icon, "BOTTOMRIGHT", 9, -8)
            icon.frame.IconOverlay:Show()
        end
        icon.frame.Cooldown:SetSwipeTexture("Interface\\HUD\\UI-HUD-CoolDownManager-Icon-Swipe")
        icon.frame.Cooldown:SetCountdownFont("GameFontHighlightHugeOutline")
        icon.frame.Cooldown:SetHideCountdownNumbers(viewer and viewer.timerShown == false)
        if icon.frame.count then
            icon.frame.count:SetFontObject("NumberFontNormal")
            icon.frame.count:ClearAllPoints()
            icon.frame.count:SetPoint("BOTTOMRIGHT", icon.frame, "BOTTOMRIGHT", -2, 2)
        end
        icon.frame.layoutIndex = entry.order
        icon.frame.cmcEssentialInjected = true
        Affected(icon.frame).essentialCustom = true
        icon:UpdateEntry(entry)
    end
    for index = #entries + 1, #icons do
        icons[index]:UpdateEntry(nil)
    end

    SyncVisibility()
    ItemViewer:RebuildUsabilityWanted()
    ApplyEssentialIntegrations()
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ essential = true })
    end
    refreshing = false
end

function EssentialCustomTracker:Initialize()
    local viewer = _G.EssentialCooldownViewer
    if not viewer or not self:EnsureLayoutHost() then
        return
    end
    if not ns.db.profile.tracker_enabled then
        self:Hide()
        return
    end
    if initialized then
        for _, event in ipairs(EVENTS) do
            host:RegisterEvent(event)
        end
        self:Refresh()
        return
    end
    for _, event in ipairs(EVENTS) do
        host:RegisterEvent(event)
    end
    host:SetScript("OnEvent", function(_, event, arg1, _arg2, arg3, _arg4, arg5)
        if event == "UNIT_PET" and arg1 ~= "player" then
            return
        elseif event == "SPELL_UPDATE_COOLDOWN" then
            if arg3 and arg1 and ItemsData and ItemsData.SetSpellCategoryCooldownSource then
                ItemsData:SetSpellCategoryCooldownSource(arg3, arg1)
            end
            if arg1 then
                EssentialCustomTracker:RefreshSpellCooldown(arg1)
            end
            if arg5 then
                EssentialCustomTracker:RefreshItemCooldown(arg5)
            end
            if arg3 then
                EssentialCustomTracker:RefreshSpellCategoryCooldown(arg3)
            end
            if not arg1 and not arg3 and not arg5 then
                QueueRefresh(false)
            end
        elseif event == "SPELL_UPDATE_CHARGES" then
            QueueRefresh(false)
        elseif event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then
            EssentialCustomTracker:RefreshSpellCooldown(arg1)
        else
            if event == "PLAYER_EQUIPMENT_CHANGED" and ns.TrackerItemVisuals then
                ns.TrackerItemVisuals:InvalidateItemCastCache()
            end
            QueueRefresh(true)
        end
    end)
    initialized = true
    self:Refresh()
end
