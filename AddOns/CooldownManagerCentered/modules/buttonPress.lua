local _, ns = ...
local Affected = ns.API.Affected

local LAB = LibStub("LibActionButton-1.0", true)
local ButtonPress = {}
ns.ButtonPress = ButtonPress

local function GetSpellIDFromCooldownId(cooldownID)
    if not cooldownID then
        return nil
    end
    if type(cooldownID) ~= "number" then
        return nil
    end
    local cooldownIDInfo = C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
    if cooldownIDInfo and cooldownIDInfo.spellID then
        return cooldownIDInfo.spellID, cooldownIDInfo.overrideSpellID
    end
end

local viewerTypes = { "EssentialCooldownViewer", "UtilityCooldownViewer" }

-- GetIconsBySpellId runs on every action-button press. The old version scanned
-- every viewer icon and allocated a lookup collection per viewer plus a
-- C_CooldownViewer info table per icon - a heavy allocation source under spam.
-- Instead, index every icon under all of the spell IDs it can be matched by
-- (cooldown spellID/override, base spell, current spell) once, and reuse that map
-- until the viewers/trackers change. A press then resolves with a few hash lookups
-- and no allocation. Matching is preserved: two spells matched before iff their
-- {self, override, base} sets intersected, which equals "some queried key is a
-- map key" when each icon is indexed under its whole set.
--
-- Each key maps to a LIST of icons: the same spell can live in a viewer and any
-- number of trackers at once, and one press must light every copy.
local iconMap = {}
local iconMapDirty = true

local function InvalidateIconMap()
    iconMapDirty = true
end

function ButtonPress:InvalidateIconMap()
    InvalidateIconMap()
end

local function AddToIconMap(id, icon)
    if type(id) ~= "number" then
        return
    end
    local list = iconMap[id]
    if not list then
        list = {}
        iconMap[id] = list
    end
    for _, existing in ipairs(list) do
        if existing == icon then
            return
        end
    end
    list[#list + 1] = icon
end

local function IndexIcon(icon)
    if not (icon.Icon and icon.cooldownID) then
        return
    end
    local cdSpellID, cdOverride = GetSpellIDFromCooldownId(icon.cooldownID)
    AddToIconMap(cdSpellID, icon)
    AddToIconMap(cdOverride, icon)
    if icon.GetBaseSpellID then
        local id = icon:GetBaseSpellID()
        if id and not issecretvalue(id) then
            AddToIconMap(id, icon)
        end
    end
    if icon.GetSpellID then
        local id = icon:GetSpellID()
        if id and not issecretvalue(id) then
            AddToIconMap(id, icon)
        end
    end
end

-- Tracker frames carry their resolved on-use spell in frame.spellID (set by the
-- tracker when it lays out the entry); index it under its base/override forms too.
local function IndexTrackerFrame(frame)
    local spellID = frame.spellID
    if not frame.Icon or not spellID or issecretvalue(spellID) then
        return
    end
    AddToIconMap(spellID, frame)
    AddToIconMap(C_Spell.GetBaseSpell(spellID), frame)
    AddToIconMap(C_Spell.GetOverrideSpell(spellID), frame)
end

local function RebuildIconMap()
    wipe(iconMap)
    for _, viewerName in ipairs(viewerTypes) do
        local viewerFrame = _G[viewerName]
        if viewerFrame and viewerFrame.GetItemFrames then
            for _, icon in ipairs(viewerFrame:GetItemFrames()) do
                IndexIcon(icon)
            end
        end
    end
    if ns.TrackerItemViewer and ns.TrackerItemViewer.GetActiveItemFrames then
        for _, frame in ipairs(ns.TrackerItemViewer:GetActiveItemFrames()) do
            IndexTrackerFrame(frame)
        end
    end
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.GetItemFrames then
        for _, frame in ipairs(ns.EssentialCustomTracker:GetItemFrames()) do
            IndexTrackerFrame(frame)
        end
    end
    iconMapDirty = false
end

local function GetIconsBySpellId(spellID)
    if not spellID then
        return nil
    end
    if iconMapDirty then
        RebuildIconMap()
    end

    local icons = iconMap[spellID]
    if icons then
        return icons
    end
    -- Mirror the pressed spell's {override, base} so an icon indexed under a
    -- related form of the same spell still matches.
    local override = C_Spell.GetOverrideSpell(spellID)
    if override and iconMap[override] then
        return iconMap[override]
    end
    local base = C_Spell.GetBaseSpell(spellID)
    if base and iconMap[base] then
        return iconMap[base]
    end
    return nil
end

-- Invalidate the icon map when the viewers' contents or spell overrides change.
-- RefreshLayout (hooked once the viewers exist) covers icon add/remove/reorder;
-- the events cover talent/spec/form changes that re-map override spells.
local iconMapEventFrame = CreateFrame("Frame")
local iconMapHooksInstalled = false
local trackerHookInstalled = false
local function InstallIconMapHooks()
    -- Tracker entries change (reorder, count, spec, equip) all funnel through
    -- RefreshItemViewerFrames, so one hook there keeps the map fresh for trackers.
    if not trackerHookInstalled and ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
        hooksecurefunc(ns.TrackerItemViewer, "RefreshItemViewerFrames", InvalidateIconMap)
        trackerHookInstalled = true
    end
    if iconMapHooksInstalled then
        return
    end
    local installedAny = false
    for _, viewerName in ipairs(viewerTypes) do
        local viewerFrame = _G[viewerName]
        if viewerFrame and viewerFrame.RefreshLayout then
            hooksecurefunc(viewerFrame, "RefreshLayout", InvalidateIconMap)
            installedAny = true
        end
    end
    iconMapHooksInstalled = installedAny
end
for _, event in ipairs({
    "PLAYER_ENTERING_WORLD",
    "PLAYER_SPECIALIZATION_CHANGED",
    "TRAIT_CONFIG_UPDATED",
    "ACTIVE_TALENT_GROUP_CHANGED",
    "UPDATE_SHAPESHIFT_FORM",
    "SPELLS_CHANGED",
}) do
    iconMapEventFrame:RegisterEvent(event)
end
iconMapEventFrame:SetScript("OnEvent", function()
    InvalidateIconMap()
    InstallIconMapHooks()
end)

local function GetSpellIdFromMacroName(macroName)
    if not macroName then
        return nil
    end

    local macroSpellID = GetMacroSpell(macroName)
    if macroSpellID then
        return macroSpellID
    end

    -- /use-an-item macros: resolve the item's on-use spell so it matches the icon
    -- indexed under that spell (item trackers, equipped trinkets, ...).
    local macroItem = GetMacroItem(macroName)
    if macroItem then
        return select(2, C_Item.GetItemSpell(macroItem))
    end
end

local function GetSpellIdFromButton(btn)
    if not btn or not btn.action then
        return nil
    end

    local actionType, id, subType = GetActionInfo(btn.action)

    if actionType == "macro" and subType == "spell" then
        return id, true
    elseif actionType == "spell" then
        return id
    elseif actionType == "item" then
        -- Items are indexed under their on-use spell, so resolve and match on that.
        return select(2, C_Item.GetItemSpell(id))
    elseif actionType == "macro" then
        local macroName = GetActionText(btn.action)
        return GetSpellIdFromMacroName(macroName), true
    end
    return nil
end
local viewerSettingMap = {
    ["EssentialCooldownViewer"] = "cooldownManager_squareIcons_Essential",
    ["UtilityCooldownViewer"] = "cooldownManager_squareIcons_Utility",
}

local function CreateOrGetTextureFrame(icon)
    if icon.HighlightTexture then
        return icon.HighlightTexture
    end

    local parent = icon:GetParent()

    local masqueActive = ns.MasqueModule and ns.MasqueModule:IsActive()

    local frame = CreateFrame("Frame", nil, icon, "BackdropTemplate")
    frame:SetFrameLevel(icon:GetFrameLevel() + 10)
    frame:SetAllPoints(icon)

    -- Under Masque, clip the overlay to the skin's shape (hexagon, round, ...)
    -- by reusing the mask Masque applied to the icon texture. Used by both the
    -- Flat and atlas ("Blizz") textures so each follows the skin shape.
    local masqueMask = masqueActive and ns.MasqueModule:GetIconMask(icon) or nil
    -- Tracker item frames aren't viewer icons: their parent is a CMCTrackerN anchor
    -- (not in viewerSettingMap) and they carry their own shape mask (frame.mask),
    -- so the highlight clips to the tracker's icon shape.
    local trackerMask = (not masqueActive) and icon.mask or nil

    local tex = frame:CreateTexture(nil, "OVERLAY")
    tex:SetAllPoints(frame)
    if ns.db.profile.cooldownManager_buttonPress_texture == "Flat" then
        tex:SetTexture("Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square")
        tex:SetBlendMode("ADD")
        tex:SetColorTexture(0.8, 0.8, 0.8, 0.3)
        if masqueMask then
            tex:AddMaskTexture(masqueMask)
        elseif trackerMask then
            tex:AddMaskTexture(trackerMask)
        elseif not masqueActive then
            local settingKey = viewerSettingMap[parent:GetName()]
            if not ns.db.profile[settingKey] then
                local mask = frame:CreateMaskTexture(nil, "ARTWORK")
                mask:SetAllPoints(frame)
                mask:SetAtlas("UI-HUD-CoolDownManager-Mask")
                tex:AddMaskTexture(mask)
            end
        end
    else
        -- Without Masque the atlas keeps its native size; with Masque, let it
        -- fill the (smaller) skinned icon frame and clip it to the skin shape.
        tex:SetAtlas("UI-HUD-ActionBar-IconFrame-Down", not masqueActive)
        if masqueMask then
            tex:AddMaskTexture(masqueMask)
        elseif trackerMask then
            tex:AddMaskTexture(trackerMask)
        end
    end
    frame.texture = tex
    frame:Hide()

    icon.HighlightTexture = frame
    return frame
end

local function EnableHighlight(icon)
    local iconFrame = CreateOrGetTextureFrame(icon)
    iconFrame:Show()
end

local function DisableHighlight(icon)
    if icon.HighlightTexture and icon.HighlightTexture:IsShown() and icon.HighlightTexture.Hide then
        icon.HighlightTexture:Hide()
    end
end

local toHide = {}

-- A spell can resolve to several icons (viewer + trackers); these light/clear and
-- queue every match from one press.
local function EnableHighlights(icons)
    for _, icon in ipairs(icons) do
        EnableHighlight(icon)
    end
end

local function DisableHighlights(icons)
    for _, icon in ipairs(icons) do
        DisableHighlight(icon)
    end
end

local function QueueHide(icons)
    for _, icon in ipairs(icons) do
        table.insert(toHide, icon)
    end
end

local isCleaningUp = false
local function cleanupToHide()
    if isCleaningUp then
        return
    end
    isCleaningUp = true
    for i, icon in ipairs(toHide) do
        DisableHighlight(icon)
        toHide[i] = nil
    end
    isCleaningUp = false
end

local isProcessingButtonPress = false
local function ButtonPressed(button, mouseButton)
    if isProcessingButtonPress then
        return
    end
    if not ns.db.profile.cooldownManager_buttonPress then
        return
    end
    if not button then
        return
    end
    isProcessingButtonPress = true
    local spellID = GetSpellIdFromButton(button)
    if not spellID then
        isProcessingButtonPress = false
        return
    end

    local icons = GetIconsBySpellId(spellID)
    if not icons then
        isProcessingButtonPress = false
        return
    end
    QueueHide(icons)
    EnableHighlights(icons)
    isProcessingButtonPress = false
end

local function HookButtonPressToPreClick(button)
    if not button or button.IsCMCButtonPressHooked then
        return
    end

    button.IsCMCButtonPressHooked = true
    button:HookScript("PreClick", function(self, mouseButton, down)
        if self.IsCMCButtonPressHandlingPreClick then
            return
        end
        self.IsCMCButtonPressHandlingPreClick = true

        cleanupToHide()
        if not down then
            self.IsCMCButtonPressHandlingPreClick = nil
            return
        end
        ButtonPressed(self, mouseButton)
        self.IsCMCButtonPressHandlingPreClick = nil
    end)
end

local function HookDominosButton(button)
    if not button then
        return
    end
    local function handler(_, mouseButton, down)
        if button.IsCMCButtonPressHandlingBindPreClick then
            return
        end
        button.IsCMCButtonPressHandlingBindPreClick = true
        cleanupToHide()
        if not down then
            button.IsCMCButtonPressHandlingBindPreClick = nil
            return
        end
        ButtonPressed(button, mouseButton)
        button.IsCMCButtonPressHandlingBindPreClick = nil
    end
    if button.bind and not button.IsCMCButtonPress_BindHooked then
        button.bind:HookScript("PreClick", handler)
        button.IsCMCButtonPress_BindHooked = true
    end
    if not button.IsCMCButtonPressHooked then
        HookButtonPressToPreClick(button)
    end
end

local function HookAllLABButtons()
    if not LAB or not LAB.activeButtons then
        return
    end

    for button in pairs(LAB.activeButtons) do
        if not button.IsCMCButtonPressHooked then
            HookButtonPressToPreClick(button)
        end
    end
end

local function RegisterLABCallbacks()
    if not LAB then
        return
    end
    if Affected(LAB).buttonPressOnButtonUpdateRegistered then
        return
    end
    Affected(LAB).buttonPressOnButtonUpdateRegistered = true

    LAB:RegisterCallback("OnButtonUpdate", function(_, button)
        HookButtonPressToPreClick(button)
    end)
end

local isElvUICallbackRegistered = false
function ButtonPress:RegisterElvUICallbacks()
    if isElvUICallbackRegistered then
        return
    end
    isElvUICallbackRegistered = true
    local ElvUI = _G.ElvUI and _G.ElvUI[1]
    if not ElvUI then
        return
    end
    local ElvUILAB = ElvUI.Libs and ElvUI.Libs.LAB
    if not ElvUILAB then
        return
    end
    ElvUILAB:RegisterCallback("OnButtonUpdate", function(_, button)
        HookButtonPressToPreClick(button)
    end)
end

local isDominosHooked = false
function ButtonPress:HookAllDominosButtons()
    if isDominosHooked then
        return
    end
    local Dominos = _G.Dominos
    if not Dominos or not Dominos.ActionButtons or not Dominos.ActionButtons.GetAll then
        return
    end
    Dominos.RegisterCallback(Dominos, "LAYOUT_LOADED", function()
        for button in Dominos.ActionButtons:GetAll() do
            HookDominosButton(button)
        end
    end)
    isDominosHooked = true
end

local isGlobalHooksSetUp = false
local isInitialized = false

local function SetupGlobalHooks()
    if isGlobalHooksSetUp then
        return
    end
    isGlobalHooksSetUp = true

    hooksecurefunc("ActionButtonDown", function(id)
        if not ns.db.profile.cooldownManager_buttonPress then
            return
        end
        local btn = _G["ActionButton" .. id]
        local spellID, isFromMacro = GetSpellIdFromButton(btn)
        local icons = GetIconsBySpellId(spellID)
        if icons then
            EnableHighlights(icons)
            if isFromMacro then
                QueueHide(icons)
            end
        end
    end)

    hooksecurefunc("ActionButtonUp", function(id)
        if not ns.db.profile.cooldownManager_buttonPress then
            return
        end
        local btn = _G["ActionButton" .. id]
        local spellID = GetSpellIdFromButton(btn)
        local icons = GetIconsBySpellId(spellID)
        if icons then
            DisableHighlights(icons)
        end
        cleanupToHide()
    end)

    hooksecurefunc("MultiActionButtonDown", function(bar, id)
        if not ns.db.profile.cooldownManager_buttonPress then
            return
        end
        local btn = _G[bar .. "Button" .. id]
        local spellID, isFromMacro = GetSpellIdFromButton(btn)
        local icons = GetIconsBySpellId(spellID)
        if icons then
            EnableHighlights(icons)
            if isFromMacro then
                QueueHide(icons)
            end
        end
    end)

    hooksecurefunc("MultiActionButtonUp", function(bar, id)
        if not ns.db.profile.cooldownManager_buttonPress then
            return
        end
        local btn = _G[bar .. "Button" .. id]
        local spellID = GetSpellIdFromButton(btn)
        local icons = GetIconsBySpellId(spellID)
        if icons then
            DisableHighlights(icons)
        end
        cleanupToHide()
    end)
end

function ButtonPress:Initialize()
    if not ns.db.profile.cooldownManager_buttonPress then
        -- Clean up any stale highlights when feature is disabled
        self:Disable()
        return
    end
    if isInitialized then
        return
    end
    isInitialized = true
    SetupGlobalHooks()
    RegisterLABCallbacks()
    HookAllLABButtons()
end

function ButtonPress:Reinitialize()
    isInitialized = false
    self:Initialize()
end

-- Every highlightable frame: viewer icons plus active tracker item frames.
local function ForEachHighlightTarget(callback)
    for _, viewerName in ipairs(viewerTypes) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            for _, icon in ipairs(viewerFrame:GetItemFrames()) do
                callback(icon)
            end
        end
    end
    if ns.TrackerItemViewer and ns.TrackerItemViewer.GetActiveItemFrames then
        for _, frame in ipairs(ns.TrackerItemViewer:GetActiveItemFrames()) do
            callback(frame)
        end
    end
end

function ButtonPress:Disable()
    cleanupToHide()
    ForEachHighlightTarget(DisableHighlight)
end

function ButtonPress:RefreshTextures()
    ForEachHighlightTarget(function(icon)
        if icon.HighlightTexture then
            icon.HighlightTexture:Hide()
            icon.HighlightTexture = nil
        end
    end)
end
