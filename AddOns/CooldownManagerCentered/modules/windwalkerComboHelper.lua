local _, ns = ...

local WindwalkerComboHelper = {}
ns.WindwalkerComboHelper = WindwalkerComboHelper

local WINDWALKER_SPEC_ID = 269

-- Spells which set/reset Windwalker's last Combo Strikes spell.
local COMBO_STRIKE_SPELLS = {
    [100780] = true,
    [107428] = true,
    [101545] = true,
    [115080] = true,
    [100784] = true,
    [101546] = true,
    [113656] = true,
    [117952] = true,
    [115098] = true,
    [123986] = true,
    [152175] = true,
    [1249625] = true,
    [467307] = true,
    [1272696] = true,
}

-- Zenith and Zenith Stomp represent the same Combo Strikes state.
local COMBO_STRIKE_SPELL_EQUIVALENTS = {
    [1249625] = 1272696,
    [1272696] = 1249625,
}

local VIEWER_NAMES = {
    "EssentialCooldownViewer",
}

local trackedOverlays = setmetatable({}, { __mode = "k" })
local activeComboIcons = setmetatable({}, { __mode = "k" })
local viewerHooksInstalled = setmetatable({}, { __mode = "k" })
local eventFrame = CreateFrame("Frame")

local lastComboSpellIDs
local refreshQueued = false
local moduleActive = false
local moduleStateInitialized = false

local function IsFeatureEnabled()
    return not ns.db or not ns.db.profile or ns.db.profile.cooldownManager_windwalkerComboHelper_enabled ~= false
end

local function IsSafeSpellID(spellID)
    return type(spellID) == "number" and (not issecretvalue or not issecretvalue(spellID))
end

local function AddComboStrikeEquivalent(spellIDs, spellID)
    local equivalentSpellID = COMBO_STRIKE_SPELL_EQUIVALENTS[spellID]
    if IsSafeSpellID(equivalentSpellID) then
        spellIDs[equivalentSpellID] = true
    end
end

local function AddComparableSpellIDs(spellIDs, spellID)
    if not IsSafeSpellID(spellID) then
        return
    end

    -- CDM treats spells sharing a base ID as distinct entries. Only explicit
    -- aliases below may make two spell IDs equivalent for Combo Strikes.
    spellIDs[spellID] = true
    AddComboStrikeEquivalent(spellIDs, spellID)
end

local function IsComboStrikeSpell(spellID)
    if not IsSafeSpellID(spellID) then
        return false
    end
    return COMBO_STRIKE_SPELLS[spellID] == true
end

local function IsWindwalker()
    if not C_SpecializationInfo or not C_SpecializationInfo.GetSpecialization then
        return false
    end

    local specializationIndex = C_SpecializationInfo.GetSpecialization()
    if not specializationIndex then
        return false
    end

    local specializationID = C_SpecializationInfo.GetSpecializationInfo(specializationIndex)
    return specializationID == WINDWALKER_SPEC_ID
end

local function GetCurrentCooldownSpellID(cooldownInfo)
    if not cooldownInfo then
        return nil
    end

    -- Match the same spell CDM displays/uses, rather than every associated
    -- ID. This keeps a base spell distinct from its active override.
    return cooldownInfo.linkedSpellID
        or cooldownInfo.overrideTooltipSpellID
        or cooldownInfo.overrideSpellID
        or cooldownInfo.spellID
end

local function DoesCooldownInfoMatchLastCombo(cooldownInfo)
    if not lastComboSpellIDs then
        return false
    end

    local spellID = GetCurrentCooldownSpellID(cooldownInfo)
    if not IsSafeSpellID(spellID) then
        return false
    end
    if lastComboSpellIDs[spellID] then
        return true
    end

    local equivalentSpellID = COMBO_STRIKE_SPELL_EQUIVALENTS[spellID]
    return IsSafeSpellID(equivalentSpellID) and lastComboSpellIDs[equivalentSpellID] or false
end

local function CooldownInfoHasKnownSpellID(cooldownInfo)
    local spellID = GetCurrentCooldownSpellID(cooldownInfo)
    return IsSafeSpellID(spellID) and spellID > 0
end

local function GetOrCreateOverlay(icon)
    local overlay = trackedOverlays[icon]
    if overlay then
        return overlay
    end

    -- Frame creation/parenting is deferred until out of combat. Existing
    -- overlays can still be shown/hidden from UNIT_SPELLCAST_SUCCEEDED.
    if InCombatLockdown() then
        return nil
    end

    local anchor = icon.Icon or icon
    overlay = CreateFrame("Frame", nil, icon)
    overlay:SetAllPoints(anchor)
    overlay:SetFrameLevel(icon:GetFrameLevel() + 30)
    overlay:EnableMouse(false)

    local mark = overlay:CreateTexture(nil, "OVERLAY")
    mark:SetAtlas("common-icon-redx")
    mark:SetAllPoints(overlay)

    overlay.Mark = mark
    overlay:Hide()
    trackedOverlays[icon] = overlay
    return overlay
end

local function HideTrackedOverlays()
    for _, overlay in pairs(trackedOverlays) do
        overlay:Hide()
    end
end

local function ClearActiveComboIcons()
    for icon in pairs(activeComboIcons) do
        activeComboIcons[icon] = nil
    end
end

function WindwalkerComboHelper:RefreshAll()
    HideTrackedOverlays()
    ClearActiveComboIcons()

    if not moduleActive or not IsFeatureEnabled() then
        return false
    end

    if not IsWindwalker() then
        return false
    end

    local iconFound = false
    for _, viewerName in ipairs(VIEWER_NAMES) do
        local viewer = _G[viewerName]
        if viewer and viewer.GetItemFrames then
            for _, icon in ipairs(viewer:GetItemFrames()) do
                if icon.Icon and icon.cooldownID then
                    local cooldownInfo = C_CooldownViewer.GetCooldownViewerCooldownInfo(icon.cooldownID)
                    local isMatch = DoesCooldownInfoMatchLastCombo(cooldownInfo)
                    iconFound = iconFound or isMatch
                    local overlay = GetOrCreateOverlay(icon)
                    if overlay and isMatch then
                        overlay:Show()
                        activeComboIcons[icon] = true
                    end
                end
            end
        end
    end

    return iconFound
end

local function CheckTrackedComboIconAfterSpellsChanged()
    if not lastComboSpellIDs then
        return false
    end

    for icon in pairs(activeComboIcons) do
        local cooldownInfo = icon.cooldownID and C_CooldownViewer.GetCooldownViewerCooldownInfo(icon.cooldownID)
        if cooldownInfo
            and not DoesCooldownInfoMatchLastCombo(cooldownInfo)
            and CooldownInfoHasKnownSpellID(cooldownInfo)
        then
            return true
        end
    end

    return false
end

local function QueueRefresh()
    if not moduleActive or refreshQueued then
        return
    end
    refreshQueued = true
    C_Timer.After(0, function()
        refreshQueued = false
        if not moduleActive then
            return
        end
        WindwalkerComboHelper:InstallViewerHooks()
        WindwalkerComboHelper:RefreshAll()
    end)
end

function WindwalkerComboHelper:InstallViewerHooks()
    if not moduleActive then
        return
    end

    for _, viewerName in ipairs(VIEWER_NAMES) do
        local viewer = _G[viewerName]
        if viewer and viewer.RefreshLayout and not viewerHooksInstalled[viewer] then
            viewerHooksInstalled[viewer] = true
            hooksecurefunc(viewer, "RefreshLayout", QueueRefresh)
        end
    end
end

local function ClearLastComboStrike()
    lastComboSpellIDs = nil
    WindwalkerComboHelper:RefreshAll()
end

-- Keep only these sentinels while inactive so the module can wake on login/spec change.
local LIFECYCLE_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "PLAYER_SPECIALIZATION_CHANGED",
    "ACTIVE_PLAYER_SPECIALIZATION_CHANGED",
}

local ACTIVE_EVENTS = {
    "PLAYER_REGEN_ENABLED",
    "PLAYER_TALENT_UPDATE",
    "TRAIT_CONFIG_UPDATED",
    "SPELLS_CHANGED",
    "COOLDOWN_VIEWER_DATA_LOADED",
    "COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED",
    "COOLDOWN_VIEWER_TABLE_HOTFIXED",
}

local function RegisterEvents(events)
    for _, event in ipairs(events) do
        eventFrame:RegisterEvent(event)
    end
end

local function SetActive(active)
    if moduleStateInitialized and moduleActive == active then
        return
    end

    moduleStateInitialized = true
    moduleActive = active
    eventFrame:UnregisterAllEvents()
    RegisterEvents(LIFECYCLE_EVENTS)

    if EventRegistry and EventRegistry.UnregisterCallback then
        EventRegistry:UnregisterCallback("CooldownViewerSettings.OnDataChanged", QueueRefresh)
    end

    if active then
        eventFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
        RegisterEvents(ACTIVE_EVENTS)
        if EventRegistry and EventRegistry.RegisterCallback then
            EventRegistry:RegisterCallback("CooldownViewerSettings.OnDataChanged", QueueRefresh)
        end
        WindwalkerComboHelper:InstallViewerHooks()
        QueueRefresh()
    else
        lastComboSpellIDs = nil
        HideTrackedOverlays()
        ClearActiveComboIcons()
    end
end

local function UpdateModuleState()
    SetActive(ns.db and ns.db.profile and IsWindwalker() and IsFeatureEnabled() or false)
end

function WindwalkerComboHelper:OnSettingChanged()
    UpdateModuleState()
end

eventFrame:SetScript("OnEvent", function(_, event, unit, _, spellID)
    if event == "PLAYER_ENTERING_WORLD"
        or event == "PLAYER_SPECIALIZATION_CHANGED"
        or event == "ACTIVE_PLAYER_SPECIALIZATION_CHANGED"
    then
        if event == "PLAYER_SPECIALIZATION_CHANGED" and unit and unit ~= "player" then
            return
        end

        local wasActive = moduleActive
        UpdateModuleState()
        if event == "PLAYER_ENTERING_WORLD" and moduleActive then
            ClearLastComboStrike()
            QueueRefresh()
        elseif wasActive and moduleActive then
            ClearLastComboStrike()
            QueueRefresh()
        end
        return
    end

    if not moduleActive then
        return
    end

    WindwalkerComboHelper:InstallViewerHooks()

    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if unit ~= "player" or not IsComboStrikeSpell(spellID) then
            return
        end

        lastComboSpellIDs = {}
        AddComparableSpellIDs(lastComboSpellIDs, spellID)
        WindwalkerComboHelper:RefreshAll()
        return
    end

    if event == "SPELLS_CHANGED" then
        if CheckTrackedComboIconAfterSpellsChanged() then
            ClearLastComboStrike()
        end
        QueueRefresh()
        return
    end

    QueueRefresh()
end)

UpdateModuleState()
