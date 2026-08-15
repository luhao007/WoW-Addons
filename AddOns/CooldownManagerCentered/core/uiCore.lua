local _, ns = ...

local L = ns.L

--- WilduUI Core Module
local WilduUICore = {}
ns.WilduUICore = WilduUICore

local LEM = ns.LibEQOL.EditMode

local editModeManagerToggleRegistered = false
local function IsCustomFramesToggleOn()
    return ns.Addon.db.profile.editMode_customFramesEnabled == true
end

local function AreCustomFramesEnabled()
    return not InCombatLockdown() and IsCustomFramesToggleOn()
end

local function EnsureEditModeManagerToggle()
    if editModeManagerToggleRegistered then
        return
    end
    editModeManagerToggleRegistered = true
    LEM:AddManagerToggle({
        id = "CooldownManagerCentered.customFrames",
        label = ns.API.GradientText("CooldownManagerCentered"),
        get = IsCustomFramesToggleOn,
        set = function(_, value)
            ns.Addon.db.profile.editMode_customFramesEnabled = value == true
            LEM:RefreshFrameSelections()
        end,
    })
end

local HIDDEN_POSITION = { point = "TOP", x = 0, y = 500 }
local DEFAULT_SCALE = 1
local DEFAULT_ALPHA = 1
local DEFAULT_STRATA = "MEDIUM"

local VALID_STRATA = {
    "BACKGROUND",
    "LOW",
    "MEDIUM",
    "HIGH",
    "DIALOG",
    "FULLSCREEN",
    "FULLSCREEN_DIALOG",
    "TOOLTIP",
}

---@type CMCEditModeFrameConfig
local FRAME_DEFAULT_CONFIG = {
    point = "CENTER",
    x = 0,
    y = 0,
    scale = DEFAULT_SCALE,
    alpha = DEFAULT_ALPHA,
    strata = DEFAULT_STRATA,
}

local visibilityDriverPostCombatFrame = CreateFrame("Frame", nil, UIParent)
visibilityDriverPostCombatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
visibilityDriverPostCombatFrame.delayedApplications = {}
visibilityDriverPostCombatFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_ENABLED" and not InCombatLockdown() then
        for _, application in ipairs(visibilityDriverPostCombatFrame.delayedApplications) do
            WilduUICore.ApplyVisibilityDriverToFrame(application.frame, application.expression)
        end
        visibilityDriverPostCombatFrame.delayedApplications = {}
    end
end)

-- Frames anchored to another frame can lose their position when that target is
-- destroyed (e.g. an EQoL/Ellesmere unit frame is disabled after the anchor was
-- set). Re-apply the stored UIParent position whenever the target's existence
-- changes so the frame never silently disappears.
local anchoredFrameWatch = {}
local anchoredFrameWatchTicker = nil
local ANCHORED_FRAME_WATCH_INTERVAL = 1

local function StopWatchingAnchoredFrames()
    if anchoredFrameWatchTicker then
        anchoredFrameWatchTicker:Cancel()
        anchoredFrameWatchTicker = nil
    end
end

local function UnwatchAnchoredFrame(key)
    anchoredFrameWatch[key] = nil
    if next(anchoredFrameWatch) == nil then
        StopWatchingAnchoredFrames()
    end
end

local function GetAnchorTargetName(configKey)
    local editMode = ns.Addon.db.profile.editMode
    local anchorCfg = editMode and editMode[configKey] and editMode[configKey].anchor
    return anchorCfg and anchorCfg.to
end

local function WatchAnchoredFrame(frame, configKey)
    if not (frame and configKey) then
        return
    end
    local key = (frame.GetName and frame:GetName()) or tostring(frame)
    key = key .. "|" .. configKey
    if anchoredFrameWatch[key] then
        return
    end

    local targetName = GetAnchorTargetName(configKey)
    anchoredFrameWatch[key] = {
        frame = frame,
        configKey = configKey,
        targetExists = targetName ~= nil and targetName ~= ns.Anchoring.NONE and _G[targetName] ~= nil,
    }

    if not anchoredFrameWatchTicker then
        anchoredFrameWatchTicker = C_Timer.NewTicker(ANCHORED_FRAME_WATCH_INTERVAL, function()
            local toRemove = {}
            for _, entry in pairs(anchoredFrameWatch) do
                local ok, tickerError = pcall(function()
                    -- A destroyed frame can no longer be positioned; a hidden one
                    -- re-registers through ApplyFramePosition when shown again, so
                    -- neither needs to stay watched.
                    if entry.frame.IsShown and not entry.frame:IsShown() then
                        toRemove[#toRemove + 1] = key
                        return
                    end

                    local currentTarget = GetAnchorTargetName(entry.configKey)
                    if not currentTarget or currentTarget == ns.Anchoring.NONE then
                        toRemove[#toRemove + 1] = key
                        return
                    end

                    local targetExists = _G[currentTarget] ~= nil
                    if targetExists ~= entry.targetExists then
                        -- Re-applying points during combat can error/taint on
                        -- restricted frames; retry on a later tick instead.
                        if InCombatLockdown() then
                            return
                        end
                        entry.targetExists = targetExists
                        local okPosition, positionError = pcall(WilduUICore.ApplyFramePosition, entry.frame, entry.configKey, false)
                        if not okPosition and not entry.applyErrorLogged then
                            entry.applyErrorLogged = true
                            ns.API:LogWarn(
                                ns.API.Error.AnchorWatchApplyPosition,
                                "AnchoredFrameWatch: ApplyFramePosition failed for " .. tostring(entry.configKey) .. ": " .. tostring(positionError)
                            )
                        end
                    end
                end)
                if not ok then
                    ns.API:LogWarn(ns.API.Error.AnchorWatchDrop, "AnchoredFrameWatch: dropping watch " .. tostring(key) .. ": " .. tostring(tickerError))
                    toRemove[#toRemove + 1] = key
                end
            end
            for _, watchKey in ipairs(toRemove) do
                UnwatchAnchoredFrame(watchKey)
            end
        end)
    end
end

---Apply or remove a visibility state driver for a frame
---@param frame Frame The WoW UI frame to manage visibility for
---@param expression? string State driver expression (nil to remove driver) - https://warcraft.wiki.gg/wiki/Macro_conditionals
---@param shouldHideInCombat? boolean If true, hides frame immediately when in combat
function WilduUICore.ApplyVisibilityDriverToFrame(frame, expression, shouldHideInCombat)
    if not frame then
        return
    end
    if InCombatLockdown() then
        if shouldHideInCombat then
            frame:Hide()
        end
        table.insert(visibilityDriverPostCombatFrame.delayedApplications, {
            frame = frame,
            expression = expression,
        })
        return
    end
    if not expression then
        if frame._wt_VisibilityDriver then
            if UnregisterStateDriver then
                local ok, driverError = pcall(UnregisterStateDriver, frame, "visibility")
                if not ok then
                    ns.API:LogWarn(ns.API.Error.VisibilityUnregister, "ApplyVisibilityDriverToFrame: UnregisterStateDriver failed: " .. tostring(driverError))
                end
            end
            frame._wt_VisibilityDriver = nil
        end
        return
    end
    if frame._wt_VisibilityDriver == expression then
        return
    end
    if RegisterStateDriver then
        local ok, driverError = pcall(RegisterStateDriver, frame, "visibility", expression)
        if ok then
            frame._wt_VisibilityDriver = expression
        else
            ns.API:LogWarn(ns.API.Error.VisibilityRegister, "ApplyVisibilityDriverToFrame: RegisterStateDriver failed: " .. tostring(driverError))
        end
    end
end

---Ensure and load frame configuration with comprehensive fallback chain
---@param configKey string The database key in editMode (e.g., "rangeCheck", "mountIcon")
---@param defaultConfig? CMCEditModeFrameConfig Default position/settings table (applied to profile first)
---@return CMCEditModeFrameConfig config The configuration table with all properties resolved
function WilduUICore.LoadFrameConfig(configKey, defaultConfig)
    defaultConfig = defaultConfig or {}
    if not ns.Addon.db.profile.editMode then
        ns.Addon.db.profile.editMode = {}
    end

    if not ns.Addon.db.profile.editMode[configKey] then
        ns.Addon.db.profile.editMode[configKey] = {}
    end

    local storedConfig = ns.Addon.db.profile.editMode[configKey]

    -- Three-tier fallback: stored → defaultConfig → DEFAULT_CONFIG
    ---@type CMCEditModeFrameConfig
    local result = {}

    local allKeys = {}
    for key in pairs(FRAME_DEFAULT_CONFIG) do
        allKeys[key] = true
    end
    for key in pairs(defaultConfig) do
        allKeys[key] = true
    end
    for key in pairs(storedConfig) do
        allKeys[key] = true
    end

    for key in pairs(allKeys) do
        result[key] = ns.Addon.db.profile.editMode[configKey][key] or defaultConfig[key] or FRAME_DEFAULT_CONFIG[key]
    end

    -- Persist any properties missing from the stored config
    for key, value in pairs(result) do
        if ns.Addon.db.profile.editMode[configKey][key] == nil then
            ns.Addon.db.profile.editMode[configKey][key] = value
        end
    end

    return result
end

---Apply position and scale to a frame from config
---@param frame Frame The frame to position
---@param configKey string The database key
---@param shouldHide boolean Whether to hide (move off-screen) the frame
function WilduUICore.ApplyFramePosition(frame, configKey, shouldHide)
    local profile = ns.Addon.db.profile
    profile.editMode = profile.editMode or {}
    profile.editMode[configKey] = profile.editMode[configKey] or {}
    local config = profile.editMode[configKey]

    if shouldHide then
        frame:SetClampedToScreen(false)
    else
        frame:SetClampedToScreen(true)
    end

    -- When the frame is anchored to another frame (see core/anchoring.lua), that anchor
    -- governs its position instead of the stored UIParent point. Falls through to the
    -- stored point if the target can't be resolved (or would form a cycle).
    local anchored = false
    if not shouldHide and ns.Anchoring then
        if config.anchor and config.anchor.to and config.anchor.to ~= ns.Anchoring.NONE then
            WatchAnchoredFrame(frame, configKey)
        end
        anchored = ns.Anchoring:ApplyAnchor(frame, configKey)
    end

    if not anchored then
        frame:ClearAllPoints()
        if shouldHide then
            frame:SetPoint(HIDDEN_POSITION.point, UIParent, HIDDEN_POSITION.point, HIDDEN_POSITION.x, HIDDEN_POSITION.y)
        else
            frame:SetPoint(config.point or "CENTER", UIParent, config.point or "CENTER", config.x or 0, config.y or 0)
        end
    end
    if config.scale ~= nil then
        frame:SetScale(config.scale)
    end
    if frame.SetAlpha and config.alpha ~= nil then
        frame:SetAlpha(config.alpha)
        ns.CMCVisibility:ReapplyViewer(frame:GetName())
    end
    if frame.SetFrameStrata then
        frame:SetFrameStrata(config.strata or DEFAULT_STRATA)
    end
end

---Create standard position-changed callback for LEM
---@param configKey string The database key
---@return function callback Callback function for LEM
function WilduUICore.CreateOnPositionChanged(configKey)
    return function(frame, layoutName, point, x, y)
        ns.Addon.db.profile.editMode[configKey].point = point
        ns.Addon.db.profile.editMode[configKey].y = y

        if ns.Addon.db.profile.editMode[configKey].lockHorizontal then
            ns.Addon.db.profile.editMode[configKey].x = 0
        else
            ns.Addon.db.profile.editMode[configKey].x = x
        end

        WilduUICore.ApplyFramePosition(frame, configKey, false)
    end
end

---Register standard EditMode callbacks (enter/layout)
---@param frame Frame The frame to register callbacks for
---@param configKey string The database key
---@param enabledCheckFn function Function that returns whether frame should be visible
---@param shouldRepositionFn function Function that returns whether frame should be repositioned
function WilduUICore.RegisterEditModeCallbacks(frame, configKey, enabledCheckFn, shouldRepositionFn)
    LEM:RegisterCallback("enter", function()
        local shouldHide = not enabledCheckFn()
        if frame._wt_VisibilityDriver and not InCombatLockdown() then
            if UnregisterStateDriver then
                local ok, driverError = pcall(UnregisterStateDriver, frame, "visibility")
                if not ok then
                    ns.API:LogWarn(ns.API.Error.EditModeUnregister, "RegisterEditModeCallbacks: UnregisterStateDriver failed: " .. tostring(driverError))
                end
            end
            frame._wt_VisibilityDriver_BACKUP = frame._wt_VisibilityDriver
            frame._wt_VisibilityDriver = nil
        elseif not frame._wt_VisibilityDriver and not frame:IsShown() then
            frame._wt_hideOnEditModeExit = true
        end
        if not frame:IsShown() then
            frame:Show()
        end
        if not shouldHide and (not shouldRepositionFn or shouldRepositionFn()) then
            WilduUICore.ApplyFramePosition(frame, configKey, false)
        elseif shouldHide then
            WilduUICore.ApplyFramePosition(frame, configKey, true)
        end
    end)

    LEM:RegisterCallback("exit", function()
        if frame._wt_VisibilityDriver_BACKUP then
            WilduUICore.ApplyVisibilityDriverToFrame(frame, frame._wt_VisibilityDriver_BACKUP)
            frame._wt_VisibilityDriver_BACKUP = nil
        end
        if frame._wt_hideOnEditModeExit then
            frame._wt_hideOnEditModeExit = nil
            frame:Hide()
        end
    end)

    LEM:RegisterCallback("layout", function(layoutName)
        WilduUICore.LoadFrameConfig(configKey)
        local shouldHide = not enabledCheckFn()
        if not shouldHide and (not shouldRepositionFn or shouldRepositionFn()) then
            WilduUICore.ApplyFramePosition(frame, configKey, false)
        elseif shouldHide then
            WilduUICore.ApplyFramePosition(frame, configKey, true)
        end
    end)
end

---Create a Scale slider setting for LEM
---@param configKey string The database key
---@param defaultValue number Default scale value
---@param frame Frame The frame to apply the scale toggle
---@param onPositionChangedCallback? function Optional custom position callback used after scaling
---@return table setting LEM setting configuration
function WilduUICore.CreateScaleSetting(configKey, defaultValue, frame, onPositionChangedCallback)
    defaultValue = defaultValue or DEFAULT_SCALE
    return {
            name = L["Scale"],
        kind = LEM.SettingType.Slider,
        default = defaultValue,
        get = function()
            return ns.Addon.db.profile.editMode[configKey].scale or defaultValue
        end,
        set = function(layoutName, value)
            local config = ns.Addon.db.profile.editMode[configKey]
            local previousScale = config.scale or defaultValue
            config.scale = value
            local scaleDiff = previousScale / value
            config.x = (config.x or 0) * scaleDiff
            config.y = (config.y or 0) * scaleDiff

            if onPositionChangedCallback then
                onPositionChangedCallback(frame, layoutName, config.point or "CENTER", config.x or 0, config.y or 0)
                return
            end
            WilduUICore.ApplyFramePosition(frame, configKey, false)
        end,
        minValue = 0.1,
        maxValue = 5,
        valueStep = 0.1,
        formatter = function(value)
            return FormatPercentage(value, true)
        end,
    }
end

---Create a Strata dropdown setting for LEM
---@param configKey string The database key
---@param defaultValue string Default strata value
---@param frame Frame The frame to apply the strata toggle
---@return table setting LEM setting configuration
function WilduUICore.CreateStrataSetting(configKey, defaultValue, frame)
    defaultValue = defaultValue or DEFAULT_STRATA
    local strataValues = {}
    for _, strata in ipairs(VALID_STRATA) do
        table.insert(strataValues, { text = strata, isRadio = true })
    end
    return {
            name = L["Strata"],
        kind = LEM.SettingType.Dropdown,
        default = defaultValue,
        get = function()
            return ns.Addon.db.profile.editMode[configKey].strata or defaultValue
        end,
        set = function(layoutName, value)
            ns.Addon.db.profile.editMode[configKey].strata = value
            if frame.SetFrameStrata then
                frame:SetFrameStrata(value)
            end
        end,
        values = strataValues,
    }
end

---Register a frame with LEM and apply settings
---@param frame Frame The frame to register
---@param configKey string The database key
---@param additionalSettings? table[] Additional LEM settings appended after Scale and Strata
---@param onPositionChangedCallback? function Custom callback for position changes (overrides default)
---@param skipGeneralSection? boolean Omit the Scale/Strata "General" section (for anchor-only frames whose scale/strata don't affect their content)
function WilduUICore.RegisterFrameWithLEM(
    frame,
    configKey,
    additionalSettings,
    onPositionChangedCallback,
    skipGeneralSection
)
    additionalSettings = additionalSettings or {}
    WilduUICore.LoadFrameConfig(configKey)

    local defaultTable = ns.DEFAULT_SETTINGS.profile.editMode[configKey] or {}
    defaultTable.enableOverlayToggle = true
    defaultTable.editModeEnabled = AreCustomFramesEnabled
    -- Custom trackers don't expose "Reset to Default" / "Reset Position" buttons.
    defaultTable.showReset = false
    defaultTable.showSettingsReset = false
    EnsureEditModeManagerToggle()
    LEM:AddFrame(frame, onPositionChangedCallback or WilduUICore.CreateOnPositionChanged(configKey), defaultTable)

    local settings = {}

    -- Frame-level Scale/Strata live in a collapsible "General" section so the panel
    -- groups the same way the cooldown viewers' Edit Mode settings do. Anchor-only
    -- frames (e.g. custom buff containers) omit it: they don't parent their content,
    -- so scale/strata on the frame don't affect the anchored icons.
    if not skipGeneralSection then
        local scaleSetting =
            WilduUICore.CreateScaleSetting(configKey, FRAME_DEFAULT_CONFIG.scale, frame, onPositionChangedCallback)
        local strataSetting = WilduUICore.CreateStrataSetting(configKey, FRAME_DEFAULT_CONFIG.strata, frame)
        scaleSetting.parentId = "general"
        strataSetting.parentId = "general"
        table.insert(
            settings,
        { kind = LEM.SettingType.Collapsible, id = "general", name = L["General"], defaultCollapsed = true }
        )
        table.insert(settings, scaleSetting)
        table.insert(settings, strataSetting)
    end

    for _, setting in ipairs(additionalSettings) do
        table.insert(settings, setting)
    end

    LEM:AddFrameSettings(frame, settings)
end

---Wrap update logic with a repeating C_Timer.NewTicker
---@param frame Frame The frame to associate the ticker with
---@param interval number Seconds between updates
---@param updateFn function Function to call for update logic
---@param checkForIsShown? boolean Check for frame visibility, if hidden won't call callback
function WilduUICore.CreateTickerUpdate(frame, interval, updateFn, checkForIsShown)
    if not frame or not interval or not updateFn then
        return
    end

    if frame._wt_ticker and frame._wt_ticker.Cancel then
        frame._wt_ticker:Cancel()
        frame._wt_ticker = nil
    end

    frame._wt_ticker = C_Timer.NewTicker(interval, function()
        if not checkForIsShown or frame:IsShown() then
            updateFn(frame)
        end
    end)
end
