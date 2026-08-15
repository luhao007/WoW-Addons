local _, ns = ...

local CMCVisibility = {}
ns.CMCVisibility = CMCVisibility

-- Per-viewer data: driver frames, cached attribute-driver state, and instance override flag
local inInstance = false
local miniGameSceneActive = false
local driverFrames = {} -- [viewerName] = Frame with RegisterAttributeDriver
local driverState = {} -- [viewerName] = "show" | "hide"  (last value from attribute driver)

local viewers = {
    { viewerName = "BuffIconCooldownViewer" },
    { viewerName = "BuffBarCooldownViewer" },
    { viewerName = "EssentialCooldownViewer" },
    { viewerName = "UtilityCooldownViewer" },
}
-- Append all possible custom trackers. Inactive/absent trackers resolve to nil
-- frames and are skipped harmlessly; the visibility driver only affects alpha, so
-- it never re-shows a deactivated (hidden) tracker.
for i = 1, (ns.CONSTANTS.MAX_TRACKERS or 10) do
    table.insert(viewers, { viewerName = "CMCTracker" .. i, settingsKey = "tracker" .. i })
end

local viewersByName = {}
for _, viewerData in ipairs(viewers) do
    viewersByName[viewerData.viewerName] = viewerData
end

-- Rules that map directly to macro conditionals supported by RegisterAttributeDriver.
-- SHOW_IN_INSTANCE has no macro conditional equivalent and is handled via events.
local RULE_CONDITIONALS = {
    SHOW_IN_COMBAT = "[combat] show",
    ALWAYS_HIDE_WHEN_FLYING = "[flying] hide",
    HIDE_IN_VEHICLES = "[petbattle] hide;[unithasvehicleui] hide;[overridebar] hide;[possessbar] hide",
    SHOW_WITH_TARGET = "[@target,exists] show",
    SHOW_WITH_ENEMY_TARGET = "[@target,exists,harm] show",
    HIDE_WHEN_FLYING = "[flying] hide",
    HIDE_WHEN_NOT_FLYING = "[noflying] hide",
    HIDE_WHEN_MOUNTED = "[mounted] hide",
    HIDE_WHEN_RESTING = "[resting] hide",
    HIDE_OUT_OF_COMBAT = "[nocombat] hide",
}

-- Priority order: SHOW overrides are evaluated first, HIDE rules after.
local RULE_ORDER = {
    "SHOW_IN_COMBAT",
    "ALWAYS_HIDE_WHEN_FLYING",
    "HIDE_IN_VEHICLES",
    "SHOW_WITH_TARGET",
    "SHOW_WITH_ENEMY_TARGET",
    "HIDE_WHEN_FLYING",
    "HIDE_WHEN_NOT_FLYING",
    "HIDE_WHEN_MOUNTED",
    "HIDE_WHEN_RESTING",
    "HIDE_OUT_OF_COMBAT",
}

local HIDE_RULES = {
    ALWAYS_HIDE_WHEN_FLYING = true,
    HIDE_IN_VEHICLES = true,
    HIDE_WHEN_FLYING = true,
    HIDE_WHEN_NOT_FLYING = true,
    HIDE_WHEN_MOUNTED = true,
    HIDE_WHEN_RESTING = true,
    HIDE_OUT_OF_COMBAT = true,
}

local function GetViewerRules(viewerName)
    local perViewer = ns.db and ns.db.profile.cooldownManager_visibility_perViewer
    return (perViewer and perViewer[viewerName]) or {}
end

local function ResolveViewer(viewerData)
    if not viewerData.viewer then
        viewerData.viewer = _G[viewerData.viewerName]
    end
    return viewerData.viewer
end

local function HasAnyHideRule(rules)
    for ruleName, enabled in pairs(rules) do
        if enabled and HIDE_RULES[ruleName] then
            return true
        end
    end
    return false
end

local function BuildConditionalString(rules)
    local parts = {}
    for _, ruleName in ipairs(RULE_ORDER) do
        if rules[ruleName] and RULE_CONDITIONALS[ruleName] then
            table.insert(parts, RULE_CONDITIONALS[ruleName])
        end
    end
    table.insert(parts, "show")
    return table.concat(parts, "; ")
end

local function GetViewerAlpha(viewerData)
    local viewer = ResolveViewer(viewerData)
    local settingsKey = viewerData.settingsKey
    if settingsKey then
        local editMode = ns.db and ns.db.profile.editMode
        return (editMode and editMode[settingsKey] and editMode[settingsKey].alpha) or 1
    elseif viewer and viewer.settingMap and viewer.settingMap[Enum.EditModeCooldownViewerSetting.Opacity] then
        return (viewer.settingMap[Enum.EditModeCooldownViewerSetting.Opacity].value + 50) / 100
    end
    return 1
end

local function ApplyViewerAlpha(viewerData, forceAlphaReset)
    local viewerName = viewerData.viewerName
    local viewer = ResolveViewer(viewerData)
    if not viewer then
        return
    end

    local rules = GetViewerRules(viewerName)
    local alpha = GetViewerAlpha(viewerData)

    if not HasAnyHideRule(rules) then
        if forceAlphaReset then
            viewer:SetAlpha(alpha)
        end
        return
    end

    if ns.Runtime and (ns.Runtime.isInEditMode or ns.Runtime.hasSettingsOpened) then
        viewer:SetAlpha(alpha)
        return
    end

    inInstance = IsInInstance()
    if rules.SHOW_IN_INSTANCE and inInstance then
        viewer:SetAlpha(alpha)
        return
    end

    local shapeshiftFormID = GetShapeshiftFormID()
    if rules.HIDE_WHEN_MOUNTED and (shapeshiftFormID == 3 or shapeshiftFormID == 29 or shapeshiftFormID == 27) then
        viewer:SetAlpha(0)
        return
    end
    if rules.HIDE_IN_VEHICLES and miniGameSceneActive then
        viewer:SetAlpha(0)
        return
    end

    local state = driverState[viewerName] or "show"
    viewer:SetAlpha(state == "show" and alpha or 0)
end

local function SetupViewerDriver(viewerData, forceAlphaReset)
    local viewerName = viewerData.viewerName

    ResolveViewer(viewerData)

    local rules = GetViewerRules(viewerName)

    if not HasAnyHideRule(rules) then
        -- Unregister any existing driver but keep the frame for reuse later
        if driverFrames[viewerName] then
            UnregisterAttributeDriver(driverFrames[viewerName], "cmc-state-vis")
        end
        driverState[viewerName] = "show"
        ApplyViewerAlpha(viewerData, forceAlphaReset)
        return
    end

    -- Reuse the frame when rules change; create it once per viewer
    local frame = driverFrames[viewerName]
    if not frame then
        frame = CreateFrame("Frame")
        driverFrames[viewerName] = frame
        -- viewerData / viewerName captured by closure — stable for the lifetime of the addon
        frame:SetScript("OnAttributeChanged", function(self, name, value)
            if name == "cmc-state-vis" then
                driverState[viewerName] = value
                ApplyViewerAlpha(viewerData)
            end
        end)
    else
        UnregisterAttributeDriver(frame, "cmc-state-vis")
    end

    local conditionalStr = BuildConditionalString(rules)
    RegisterAttributeDriver(frame, "cmc-state-vis", conditionalStr)
    driverState[viewerName] = SecureCmdOptionParse(conditionalStr) or "show"

    -- Ensure alpha is applied even if OnAttributeChanged has not yet fired
    ApplyViewerAlpha(viewerData)
end

-- Pending initialize request: set when Initialize() is called during combat lockdown.
-- SetupViewerDriver calls RegisterAttributeDriver which is combat-restricted.
local pendingInitializeRequest

local function QueuePendingInitialize(forceViewers)
    pendingInitializeRequest = pendingInitializeRequest or {}

    if not forceViewers then
        return
    end

    local pendingForceViewers = pendingInitializeRequest.forceViewers
    if not pendingForceViewers then
        pendingForceViewers = {}
        pendingInitializeRequest.forceViewers = pendingForceViewers
    end

    for viewerName, shouldForce in pairs(forceViewers) do
        if shouldForce then
            pendingForceViewers[viewerName] = true
        end
    end
end

-- Event frame: handles SHOW_IN_INSTANCE (event-based) and deferred post-combat init.
local EventFrame = CreateFrame("Frame")
EventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        inInstance = IsInInstance()
    elseif event == "CLIENT_SCENE_OPENED" then
        local sceneType = ...
        miniGameSceneActive = (sceneType == 1)
    elseif event == "CLIENT_SCENE_CLOSED" then
        miniGameSceneActive = false
    elseif event == "PLAYER_REGEN_ENABLED" then
        if pendingInitializeRequest then
            local request = pendingInitializeRequest
            pendingInitializeRequest = nil
            CMCVisibility:Initialize(request.forceViewers)
            return -- Initialize calls UpdateAll internally via SetupViewerDriver
        end
        return
    end
    CMCVisibility:UpdateAll()
end)

function CMCVisibility:UpdateAll()
    for _, viewerData in ipairs(viewers) do
        ApplyViewerAlpha(viewerData)
    end
end

function CMCVisibility:ReapplyViewer(viewerName)
    local viewerData = viewerName and viewersByName[viewerName]
    if viewerData then
        ApplyViewerAlpha(viewerData)
    end
end

function CMCVisibility:Initialize(forceViewers)
    self:MigrateSettings()
    self:DeInitialize()

    -- RegisterAttributeDriver (called by SetupViewerDriver) is combat-restricted.
    -- Defer the full driver setup until after combat; UpdateAll still runs so
    -- the current alpha stays correct based on already-registered drivers.
    if InCombatLockdown() then
        QueuePendingInitialize(forceViewers)
        EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end

    pendingInitializeRequest = nil

    for _, viewerData in ipairs(viewers) do
        SetupViewerDriver(viewerData, forceViewers and forceViewers[viewerData.viewerName])
    end

    -- Always keep PLAYER_REGEN_ENABLED registered so a queued init is never lost.
    -- Also register PLAYER_ENTERING_WORLD when at least one viewer uses SHOW_IN_INSTANCE.
    EventFrame:UnregisterAllEvents()
    EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

    inInstance = IsInInstance()
    EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    EventFrame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
    EventFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
    EventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
    EventFrame:RegisterEvent("CLIENT_SCENE_OPENED")
    EventFrame:RegisterEvent("CLIENT_SCENE_CLOSED")
    EventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    EventFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
end

function CMCVisibility:DeInitialize()
    EventFrame:UnregisterAllEvents()
    EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

    for _, viewerData in ipairs(viewers) do
        local viewerName = viewerData.viewerName
        if driverFrames[viewerName] then
            if not InCombatLockdown() then
                UnregisterAttributeDriver(driverFrames[viewerName], "cmc-state-vis")
            end
            -- Keep the frame in driverFrames so it can be reused on re-Initialize
        end
        driverState[viewerName] = "show"
        if viewerData.viewer then
            viewerData.viewer:SetAlpha(GetViewerAlpha(viewerData))
        end
    end
end

-- Migrate from the legacy "Smart Visibility" global rules + affected viewers into
-- the new per-viewer rule tables.  Runs once (skipped if perViewer already exists).
function CMCVisibility:MigrateSettings()
    local profile = ns.db.profile
    if profile.cooldownManager_visibility_perViewer then
        return
    end

    profile.cooldownManager_visibility_perViewer = {}

    local globalRules = profile.cooldownManager_visibility_enabled_rules or {}
    local affectedViewers = profile.cooldownManager_visibility_enabled_viewers or {}

    for _, viewerData in ipairs(viewers) do
        local viewerName = viewerData.viewerName
        local viewerRules = {}
        if affectedViewers[viewerName] then
            for rule, enabled in pairs(globalRules) do
                if enabled then
                    viewerRules[rule] = true
                end
            end
        end
        profile.cooldownManager_visibility_perViewer[viewerName] = viewerRules
    end
end
