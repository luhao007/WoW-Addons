---@diagnostic disable

local ADDON_NAME = ...

local CreateFrame = _G.CreateFrame
local PlaySoundFile = _G.PlaySoundFile
local C_Timer = _G.C_Timer
local ColorPickerFrame = _G.ColorPickerFrame
local OpacitySliderFrame = _G.OpacitySliderFrame
local Enum = _G.Enum
local C_QuestLog = _G["C_QuestLog"]
local C_UIWidgetManager = _G["C_UIWidgetManager"]
local C_TaskQuest = _G["C_TaskQuest"]
local C_Map = _G["C_Map"]
local C_SuperTrack = _G["C_SuperTrack"]
local GetQuestProgressBarPercent = _G.GetQuestProgressBarPercent
local UIParent = _G.UIParent
local UiMapPoint = _G.UiMapPoint
local GetTime = _G.GetTime
local GetCursorPosition = _G.GetCursorPosition
local GetZoneText = _G.GetZoneText
local IsInInstance = _G.IsInInstance
local SlashCmdList = _G["SlashCmdList"]
local Settings = _G["Settings"]
local geterrorhandler = _G.geterrorhandler
local EnumerateFrames = _G.EnumerateFrames
local OpenQuestMap = _G.OpenQuestMap
local ToggleWorldMap = _G.ToggleWorldMap
local QuestMapFrame_OpenToQuestDetails = _G.QuestMapFrame_OpenToQuestDetails
local collectgarbage = _G.collectgarbage
local UIDropDownMenu_Initialize = _G.UIDropDownMenu_Initialize
local UIDropDownMenu_CreateInfo = _G.UIDropDownMenu_CreateInfo
local UIDropDownMenu_SetWidth = _G.UIDropDownMenu_SetWidth
local UIDropDownMenu_SetText = _G.UIDropDownMenu_SetText
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton

_G.SLASH_PREYDATOR1 = "/preydator"
_G.SLASH_PREYDATOR2 = "/pd"

local PREY_WIDGET_TYPE = 31
local PREY_PROGRESS_FINAL = 3
local MAX_STAGE = 4
local MAX_TICK_MARKS = 3
local WIDGET_SHOWN = 1
-- local IDLE_SOUND_PATH = "Interface\\AddOns\\Preydator\\sounds\\predator-idle.ogg"
local ALERT_SOUND_PATH = "Interface\\AddOns\\Preydator\\sounds\\predator-alert.ogg"
local AMBUSH_SOUND_PATH = "Interface\\AddOns\\Preydator\\sounds\\predator-ambush.ogg"
local TORMENT_SOUND_PATH = "Interface\\AddOns\\Preydator\\sounds\\predator-torment.ogg"
local KILL_SOUND_PATH = "Interface\\AddOns\\Preydator\\sounds\\predator-kill.ogg"
local DEBUG_LOG_LIMIT = 200
local DEFAULT_OUT_OF_ZONE_LABEL = _G.PreydatorL["No Sign in These Fields"]
local DEFAULT_AMBUSH_LABEL = _G.PreydatorL["AMBUSH"]
local PROGRESS_SEGMENTS_QUARTERS = "quarters"
local PROGRESS_SEGMENTS_THIRDS = "thirds"
local BAR_TICK_PCTS_BY_SEGMENT = {
    [PROGRESS_SEGMENTS_QUARTERS] = { 25, 50, 75 },
    [PROGRESS_SEGMENTS_THIRDS] = { 33, 66 },
}
local PERCENT_DISPLAY_INSIDE = "inside"
local PERCENT_DISPLAY_INSIDE_BELOW = "inside_below"
local PERCENT_DISPLAY_BELOW_BAR = "below_bar"
PERCENT_DISPLAY_ABOVE_BAR = "above_bar"
PERCENT_DISPLAY_ABOVE_TICKS = "above_ticks"
local PERCENT_DISPLAY_UNDER_TICKS = "under_ticks"
local PERCENT_DISPLAY_OFF = "off"
local PERCENT_FALLBACK_STAGE = "stage"
local LAYER_MODE_ABOVE = "above"
local LAYER_MODE_BELOW = "below"
local LABEL_MODE_CENTER = "center"
local LABEL_MODE_LEFT = "left"
LABEL_MODE_LEFT_COMBINED = "left_combined"
local LABEL_MODE_LEFT_SUFFIX = "left_suffix"
local LABEL_MODE_RIGHT = "right"
LABEL_MODE_RIGHT_COMBINED = "right_combined"
local LABEL_MODE_RIGHT_PREFIX = "right_prefix"
local LABEL_MODE_SEPARATE = "separate"
local LABEL_MODE_NONE = "none"
LABEL_ROW_ABOVE = "above"
LABEL_ROW_BELOW = "below"
ORIENTATION_HORIZONTAL = "horizontal"
ORIENTATION_VERTICAL = "vertical"
FILL_DIRECTION_UP = "up"
FILL_DIRECTION_DOWN = "down"
local FILL_INSET = 3
local AMBUSH_ALERT_DURATION_SECONDS = 6
local AMBUSH_SOUND_COOLDOWN_SECONDS = 45
local QUEST_LISTEN_BURST_SECONDS = 6
local ACTIVE_PREY_QUEST_CACHE_SECONDS = 0.75
local AMBUSH_SOUND_ALERT = "alert"
local AMBUSH_SOUND_AMBUSH = "ambush"
local AMBUSH_SOUND_TORMENT = "torment"
local AMBUSH_SOUND_KILL = "kill"
local SOUND_FOLDER_PREFIX = "Interface\\AddOns\\Preydator\\sounds\\"
local DEFAULT_SOUND_FILENAMES = {
    "predator-alert.ogg",
    "predator-ambush.ogg",
    "predator-torment.ogg",
    "predator-kill.ogg",
}
local PROTECTED_SOUND_FILENAMES = {
    ["predator-alert.ogg"] = true,
    ["predator-ambush.ogg"] = true,
    ["predator-torment.ogg"] = true,
    ["predator-kill.ogg"] = true,
}
local DEFAULT_STAGE_LABELS = {
    [1] = _G.PreydatorL["Scent in the Wind"],
    [2] = _G.PreydatorL["Blood in the Shadows"],
    [3] = _G.PreydatorL["Echoes of the Kill"],
    [4] = _G.PreydatorL["Feast of the Fang"],
}
local STAGE_PCT_BY_SEGMENT = {
    [PROGRESS_SEGMENTS_QUARTERS] = {
        [1] = 25,
        [2] = 50,
        [3] = 75,
        [4] = 100,
    },
    [PROGRESS_SEGMENTS_THIRDS] = {
        [1] = 0,
        [2] = 33,
        [3] = 66,
        [4] = 100,
    },
}

local TEXTURE_PRESETS = {
    default = "Interface\\TARGETINGFRAME\\UI-StatusBar",
    flat = "Interface\\Buttons\\WHITE8x8",
    raid = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
    classic = "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
}

local FONT_PRESETS = {
    frizqt = "Fonts\\FRIZQT__.TTF",
    arialn = "Fonts\\ARIALN.TTF",
    skurri = "Fonts\\SKURRI.TTF",
    morpheus = "Fonts\\MORPHEUS.TTF",
}

-- Forward declaration for helpers used before their implementation block.
local NormalizeSoundSettings
local GetSoundPathForKey
local IsValidQuestID
local ShouldSuppressDefaultPreyEncounter

local DEFAULTS = {
    point = { anchor = "CENTER", relativePoint = "CENTER", x = 0, y = 472 },
    width = 160,
    height = 30,
    horizontalWidth = 160,
    horizontalHeight = 30,
    verticalWidth = 40,
    verticalHeight = 160,
    scale = 0.9,
    verticalScale = 0.9,
    fontSize = 12,
    locked = true,
    forceShowBar = false,
    onlyShowInPreyZone = false,
    disableDefaultPreyIcon = false,
    showInEditMode = true,
    fillColor = { 0.85, 0.2, 0.2, 0.95 },
    bgColor = { 0, 0, 0, 0.6 },
    titleColor = { 1, 0.82, 0, 1 },
    percentColor = { 1, 1, 1, 1 },
    tickColor = { 1, 1, 1, 0.35 },
    sparkColor = { 1, 0.95, 0.75, 0.9 },
    textureKey = "default",
    titleFontKey = "frizqt",
    percentFontKey = "frizqt",
    outOfZoneLabel = DEFAULT_OUT_OF_ZONE_LABEL,
    outOfZonePrefix = "",
    ambushLabel = DEFAULT_AMBUSH_LABEL,
    ambushPrefix = "",
    ambushCustomText = "",
    stageLabels = {
        [1] = DEFAULT_STAGE_LABELS[1],
        [2] = DEFAULT_STAGE_LABELS[2],
        [3] = DEFAULT_STAGE_LABELS[3],
        [4] = DEFAULT_STAGE_LABELS[4],
    },
    stageSounds = {
        [1] = ALERT_SOUND_PATH,
        [2] = AMBUSH_SOUND_PATH,
        [3] = TORMENT_SOUND_PATH,
        [4] = KILL_SOUND_PATH,
    },
    soundsEnabled = true,
    soundChannel = "SFX",
    soundEnhance = 0,
    soundFileNames = {
        "predator-alert.ogg",
        "predator-ambush.ogg",
        "predator-torment.ogg",
        "predator-kill.ogg",
    },
    debugSounds = false,
    currencyDebugEvents = false,
    currencyWindowEnabled = false,
    currencyMinimapButton = true,
    currencyMinimapAngle = 225,
    currencyMinimap = {
        hide = false,
        minimapPos = 225,
    },
    currencyWindowPoint = { anchor = "CENTER", relativePoint = "CENTER", x = 340, y = -80 },
    currencyWindowWidth = 276,
    currencyWindowHeight = 236,
    currencyWindowFontSize = 14,
    currencyWindowScale = 1,
    currencyWindowHideInInstance = false,
    currencyWarbandWindowEnabled = false,
    currencyWarbandWindowPoint = { anchor = "CENTER", relativePoint = "CENTER", x = 660, y = -80 },
    currencyWarbandWidth = 420,
    currencyWarbandHeight = 250,
    currencyWarbandFontSize = 12,
    currencyWarbandScale = 1,
    currencyWarbandWindowHideInInstance = false,
    currencyWarbandCollapsedRealms = {},
    currencyWarbandShowPreyTrack = true,
    currencyWarbandPreyMode = "available",
    currencyWarbandTrackedIDs = {
        [3392] = true,
        [3316] = true,
        [3383] = true,
        [3341] = true,
        [3343] = true,
    },
    currencyWarbandUseCurrencyTheme = true,
    currencyWarbandTheme = "brown",
    currencyShowAffordableHunts = false,
    currencyShowRealmInWarband = false,
    currencyTheme = "brown",
    currencyDeltaGainColor = { 0.00, 0.56, 0.32, 1 },
    currencyDeltaLossColor = { 0.72, 0.24, 0.15, 1 },
    currencyTrackedIDs = {
        [3392] = true,
        [3316] = true,
        [3383] = true,
        [3341] = true,
        [3343] = true,
    },
    randomHuntCosts = {
        normal = 50,
        hard = 50,
        nightmare = 0,
    },
    huntScannerEnabled = true,
    huntScannerSide = "right",
    huntScannerMatchCurrencyTheme = true,
    huntScannerUseCurrencyTheme = true,
    huntScannerTheme = "brown",
    huntScannerGroupBy = "difficulty",
    huntScannerSortBy = "zone",
    huntScannerSortDir = "asc",
    huntScannerWidth = 336,
    huntScannerHeight = 460,
    huntScannerFontSize = 12,
    huntScannerScale = 1.00,
    huntScannerAnchorAlign = "top",
    huntScannerCollapsedGroups = {},
    huntScannerPreviewInOptions = false,
    ambushSoundEnabled = true,
    ambushVisualEnabled = true,
    ambushSoundPath = KILL_SOUND_PATH,
    showTicks = true,
    showSparkLine = false,
    tickLayerMode = LAYER_MODE_ABOVE,
    labelRowPosition = "above",
    orientation = "horizontal",
    verticalFillDirection = "up",
    verticalTextSide = "right",
    verticalPercentSide = "center",
    showVerticalTickPercent = false,
    verticalPercentDisplay = PERCENT_DISPLAY_INSIDE,
    verticalTextOffset = 10,
    verticalPercentOffset = 10,
    verticalTextAlign = "separate",
    showAlignmentDot = false,
    verticalSideOffset = 10,
    progressSegments = PROGRESS_SEGMENTS_THIRDS,
    stageLabelMode = LABEL_MODE_CENTER,
    stageSuffixLabels = {
        [1] = "",
        [2] = "",
        [3] = "",
        [4] = "",
    },
    borderColorLinked = true,
    borderColor = { 0.8, 0.2, 0.2, 0.85 },
    percentDisplay = PERCENT_DISPLAY_INSIDE,
    percentFallbackMode = PERCENT_FALLBACK_STAGE,
    customizationV2 = {
        moduleEnabled = {
            bar = true,
            sounds = true,
            currency = true,
            hunt = true,
            warband = true,
            achievement = false,  -- Not yet implemented
        },
    },
}

local settings
local debugDB
local Preydator = _G.Preydator or {}
_G.Preydator = Preydator
Preydator.modules = Preydator.modules or {}

function Preydator:RegisterModule(name, module)
    if type(name) ~= "string" or name == "" or type(module) ~= "table" then
        return
    end

    module.name = name
    self.modules[name] = module
end

function Preydator:GetModule(name)
    if type(name) ~= "string" or name == "" then
        return nil
    end

    return self.modules and self.modules[name] or nil
end

-- CustomizationStateV2: Manages module enable/disable state
local CustomizationStateV2 = {
    name = "CustomizationStateV2",
}

function CustomizationStateV2:IsModuleEnabled(moduleKey)
    if type(moduleKey) ~= "string" or moduleKey == "" then
        return true
    end

    local db = settings or _G.PreydatorDB or {}
    local custV2 = db.customizationV2 or {}
    local moduleState = custV2.moduleEnabled or {}

    -- Default to true if not explicitly set to false
    if moduleState[moduleKey] == nil then
        return true
    end
    return moduleState[moduleKey] == true
end

function CustomizationStateV2:Set(path, value)
    if type(path) ~= "string" or path == "" then
        return
    end

    local db = settings or _G.PreydatorDB or {}
    db.customizationV2 = db.customizationV2 or {}
    db.customizationV2.moduleEnabled = db.customizationV2.moduleEnabled or {}

    -- Parse path like "customizationV2.moduleEnabled.bar"
    local parts = {}
    for part in string.gmatch(path, "[^.]+") do
        parts[#parts + 1] = part
    end

    if #parts == 3 and parts[1] == "customizationV2" and parts[2] == "moduleEnabled" then
        local moduleKey = parts[3]
        if type(moduleKey) == "string" and moduleKey ~= "" then
            db.customizationV2.moduleEnabled[moduleKey] = value and true or false
        end
    end
end

Preydator:RegisterModule("CustomizationStateV2", CustomizationStateV2)

local frame = CreateFrame("Frame")
local warnedMissingSoundPaths = {}

-- UI frame references grouped in a table to reduce local variable count from ~30 to 1
local UI = {
    barFrame = false,
    barFillContainer = false,
    barFill = false,
    barSpark = false,
    barText = false,
    stageText = false,
    stageSuffixText = false,
    barAlignmentDot = false,
    barBorder = false,
    barTickMarks = {},
    barTickLabels = {},
    optionsPanel = false,
    optionsCategoryID = false,
    optionsScrollFrame = false,
    optionsContentFrame = false,
    candidateWidgetSetIDs = {},
    targetedWidgetGlobalFrameCache = {},
    colorPickerSessionCounter = 0,
}

local EnsureOptionsPanel
local OpenOptionsPanel
local ExtractWidgetQuestID
local AddDebugLog
local TryPlaySound
local TryPlayStageSound
local UpdateBarDisplay
local ApplyBarSettings
local ApplyDefaultPreyIconVisibility
local TryOpenPreyQuestOnMap

local function RunModuleHook(hookName, ...)
    for _, module in pairs(Preydator.modules) do
        local fn = module and module[hookName]
        if type(fn) == "function" then
            pcall(fn, module, ...)
        end
    end
end

local state = {
    activeQuestID = nil,
    progressState = nil,
    progressPercent = nil,
    stageSoundPlayed = {},
    stageSoundAttempted = {},
    forceShowBar = false,
    killStageUntil = 0,
    stage = 1,
    preyZoneName = nil,
    preyZoneMapID = nil,
    inPreyZone = nil,
    preyTooltipText = nil,
    elapsedSinceUpdate = 0,
    lastWidgetSeenAt = 0,
    lastStateDebugSnapshot = nil,
    lastDisplayPct = 0,
    lastDisplayReason = "init",
    lastPercentSource = "none",
    preyTargetName = nil,
    preyTargetDifficulty = nil,
    ambushAlertUntil = 0,
    lastAmbushSoundAt = 0,
    lastAmbushSystemMessage = nil,
    lastNotifiedPreyEndQuestID = nil,
    questListenUntil = 0,
    cachedActivePreyQuestID = nil,
    cachedActivePreyQuestAt = 0,
    playerMapID = nil,
    playerMapHierarchy = nil,
    zoneCacheDirty = true,
    pollingActive = false,
    nextPollingEligibilityCheckAt = 0,
}

local UPDATE_INTERVAL_SECONDS = 0.5
local INSPECT_VERSION = "v4"

Preydator.GetState = function()
    return state
end

Preydator.GetSettings = function()
    return settings
end

Preydator.GetBarFrame = function()
    return UI.barFrame
end

Preydator.GetLabelFrames = function()
    return {
        prefix = UI.stageText,
        suffix = UI.stageSuffixText,
        percent = UI.barText,
        centerDot = UI.barAlignmentDot,
    }
end

Preydator.RequestRefresh = function()
    if type(UpdateBarDisplay) == "function" then
        UpdateBarDisplay()
    end
end

local function ApplyDefaults(dst, src)
    for key, value in pairs(src) do
        if type(value) == "table" then
            if type(dst[key]) ~= "table" then
                dst[key] = {}
            end
            ApplyDefaults(dst[key], value)
        elseif dst[key] == nil then
            dst[key] = value
        end
    end
end

local function GetStageLabel(stage)
    if settings and settings.stageLabels then
        local customLabel = settings.stageLabels[stage]
        if type(customLabel) == "string" and customLabel ~= "" then
            return customLabel
        end
    end

    return DEFAULT_STAGE_LABELS[stage] or "Unknown"
end

local function Clamp(value, minValue, maxValue)
    return math.max(minValue, math.min(maxValue, value))
end

local function RoundToStep(value, step)
    if not step or step <= 0 then
        return value
    end

    return math.floor((value / step) + 0.5) * step
end

local function NormalizeSliderValue(value, minValue, maxValue, step)
    local numeric = tonumber(value)
    if not numeric then
        return nil
    end

    numeric = Clamp(numeric, minValue, maxValue)
    numeric = RoundToStep(numeric, step)
    return Clamp(numeric, minValue, maxValue)
end

local function CreateCheckboxControl(parent, x, y, label, getter, setter, options)
    options = type(options) == "table" and options or {}

    local check = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    check:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    check.Text:SetText(label)
    check:SetChecked(getter() and true or false)
    check:SetScript("OnClick", function(self)
        setter(self:GetChecked() and true or false)
    end)

    function check:PreydatorRefresh()
        self:SetChecked(getter() and true or false)
    end

    if options.withSetEnabled == true then
        function check:PreydatorSetEnabled(enabled)
            local isEnabled = enabled and true or false
            self:SetAlpha(isEnabled and 1 or 0.45)
            self:SetEnabled(isEnabled)
            if self.EnableMouse then
                self:EnableMouse(isEnabled)
            end
        end
    end

    return check
end

local function CreateSliderControl(parent, x, y, label, minValue, maxValue, step, getter, setter, formatValue, options)
    options = type(options) == "table" and options or {}

    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(options.containerWidth or 250, options.containerHeight or 54)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText(label)

    local slider = CreateFrame("Slider", nil, container, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", 0, -18)
    slider:SetWidth(options.sliderWidth or 165)
    slider:SetScale(options.sliderScale or 1)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    if slider.Low then slider.Low:Hide() end
    if slider.High then slider.High:Hide() end

    local valueBox = CreateFrame("EditBox", nil, container, "InputBoxTemplate")
    valueBox:SetSize(options.valueBoxWidth or 52, options.valueBoxHeight or 20)
    valueBox:SetPoint("LEFT", slider, "RIGHT", options.valueBoxOffsetX or 10, 0)
    valueBox:SetAutoFocus(false)
    valueBox:SetTextInsets(6, 6, 0, 0)
    valueBox:SetJustifyH("CENTER")

    local formatter = formatValue or function(value)
        if step and step < 1 then
            return string.format("%.2f", value)
        end
        return tostring(math.floor(value + 0.5))
    end

    local function RefreshFromValue(rawValue)
        local normalized = NormalizeSliderValue(rawValue, minValue, maxValue, step)
        if normalized == nil then
            normalized = getter()
        end
        slider:SetValue(normalized)
        valueBox:SetText(formatter(normalized))
    end

    slider:SetScript("OnValueChanged", function(_, value)
        local normalized = NormalizeSliderValue(value, minValue, maxValue, step)
        if normalized == nil then
            return
        end

        valueBox:SetText(formatter(normalized))
        setter(normalized)
    end)

    valueBox:SetScript("OnEnterPressed", function(self)
        local normalized = NormalizeSliderValue(self:GetText(), minValue, maxValue, step)
        if normalized == nil then
            self:SetText(formatter(getter()))
            self:ClearFocus()
            return
        end

        slider:SetValue(normalized)
        self:ClearFocus()
    end)

    valueBox:SetScript("OnEditFocusLost", function(self)
        self:SetText(formatter(getter()))
    end)

    function container:PreydatorRefresh()
        RefreshFromValue(getter())
    end

    if options.withSetEnabled == true then
        function container:PreydatorSetEnabled(enabled)
            local isEnabled = enabled and true or false
            self:SetAlpha(isEnabled and 1 or 0.45)
            slider:SetEnabled(isEnabled)
            valueBox:SetEnabled(isEnabled)
            if valueBox.SetTextColor then
                local channel = isEnabled and 1 or 0.65
                valueBox:SetTextColor(channel, channel, channel)
            end
        end
    end

    container:PreydatorRefresh()
    return container
end

local function Round(value)
    if value >= 0 then
        return math.floor(value + 0.5)
    end

    return math.ceil(value - 0.5)
end

local function SyncBarPointToBackup()
    if not settings or type(settings.point) ~= "table" then
        return
    end

    local x = tonumber(settings.point.x)
    local y = tonumber(settings.point.y)
    if x == nil or y == nil then
        return
    end

    settings.barPointX = Round(x)
    settings.barPointY = Round(y)
end

local function RestoreBarPointFromBackup()
    if not settings then
        return
    end

    settings.point = settings.point or {}
    local pointX = tonumber(settings.point.x)
    local pointY = tonumber(settings.point.y)

    -- Do not overwrite valid point coordinates with backup values.
    -- Backup restore is only for recovering missing/invalid point data.
    if pointX ~= nil and pointY ~= nil then
        return
    end

    local x = tonumber(settings.barPointX)
    local y = tonumber(settings.barPointY)
    if x == nil or y == nil then
        return
    end

    settings.point.anchor = "CENTER"
    settings.point.relativePoint = "CENTER"
    settings.point.x = Round(x)
    settings.point.y = Round(y)
end

local function NormalizeLabelSettings()
    if type(settings.stageLabels) ~= "table" then
        settings.stageLabels = {}
    end

    for stage = 1, MAX_STAGE do
        local label = settings.stageLabels[stage]
        if type(label) ~= "string" then
            local legacy = settings.stageLabels[tostring(stage)]
            if type(legacy) == "string" then
                label = legacy
            end
        end

        if type(label) ~= "string" then
            label = DEFAULT_STAGE_LABELS[stage] or ""
        end

        settings.stageLabels[stage] = label
    end

    if type(settings.outOfZoneLabel) ~= "string" or settings.outOfZoneLabel == "" then
        settings.outOfZoneLabel = DEFAULT_OUT_OF_ZONE_LABEL
    end

    if type(settings.outOfZonePrefix) ~= "string" then
        settings.outOfZonePrefix = ""
    end

    if type(settings.ambushLabel) ~= "string" or settings.ambushLabel == "" then
        settings.ambushLabel = DEFAULT_AMBUSH_LABEL
    end

    if type(settings.ambushPrefix) ~= "string" then
        settings.ambushPrefix = ""
    end

    if type(settings.ambushCustomText) ~= "string" then
        settings.ambushCustomText = ""
    end
end

local function NormalizeColorSettings()
    local function normalizeColor(source, fallback)
        local color = type(source) == "table" and source or {}
        local r = Clamp(tonumber(color[1] or color.r) or fallback[1], 0, 1)
        local g = Clamp(tonumber(color[2] or color.g) or fallback[2], 0, 1)
        local b = Clamp(tonumber(color[3] or color.b) or fallback[3], 0, 1)
        local a = Clamp(tonumber(color[4] or color.a) or fallback[4], 0, 1)
        return { r, g, b, a }
    end

    settings.fillColor = normalizeColor(settings.fillColor, DEFAULTS.fillColor)
    settings.bgColor = normalizeColor(settings.bgColor, DEFAULTS.bgColor)
    settings.titleColor = normalizeColor(settings.titleColor, DEFAULTS.titleColor)
    settings.percentColor = normalizeColor(settings.percentColor, DEFAULTS.percentColor)
    settings.tickColor = normalizeColor(settings.tickColor, DEFAULTS.tickColor)
    settings.sparkColor = normalizeColor(settings.sparkColor, DEFAULTS.sparkColor)
    settings.borderColor = normalizeColor(settings.borderColor, DEFAULTS.borderColor)
    if settings.borderColorLinked == nil then
        settings.borderColorLinked = true
    end
end

local function NormalizeDisplaySettings()
    settings.showTicks = settings.showTicks ~= false
    settings.showSparkLine = settings.showSparkLine == true
    settings.showInEditMode = settings.showInEditMode ~= false

    local mode = settings.percentDisplay
    if mode == "below" then
        mode = PERCENT_DISPLAY_BELOW_BAR
    end

    if mode ~= PERCENT_DISPLAY_INSIDE
        and mode ~= PERCENT_DISPLAY_BELOW_BAR
        and mode ~= "above_bar"
        and mode ~= "above_ticks"
        and mode ~= PERCENT_DISPLAY_UNDER_TICKS
        and mode ~= PERCENT_DISPLAY_OFF
    then
        settings.percentDisplay = PERCENT_DISPLAY_INSIDE
    else
        settings.percentDisplay = mode
    end

    settings.tickLayerMode = LAYER_MODE_ABOVE

    settings.percentFallbackMode = PERCENT_FALLBACK_STAGE

    local labelMode = settings.stageLabelMode
    if labelMode ~= LABEL_MODE_CENTER
        and labelMode ~= LABEL_MODE_LEFT
        and labelMode ~= "left_combined"
        and labelMode ~= LABEL_MODE_LEFT_SUFFIX
        and labelMode ~= LABEL_MODE_RIGHT
        and labelMode ~= "right_combined"
        and labelMode ~= LABEL_MODE_RIGHT_PREFIX
        and labelMode ~= LABEL_MODE_SEPARATE
        and labelMode ~= LABEL_MODE_NONE
    then
        settings.stageLabelMode = LABEL_MODE_CENTER
    end

    if settings.labelRowPosition ~= "above" and settings.labelRowPosition ~= "below" then
        settings.labelRowPosition = "above"
    end

    if settings.orientation ~= "horizontal" and settings.orientation ~= "vertical" then
        settings.orientation = "horizontal"
    end

    if settings.verticalFillDirection ~= "up" and settings.verticalFillDirection ~= "down" then
        settings.verticalFillDirection = "up"
    end

    if settings.verticalTextSide ~= "left" and settings.verticalTextSide ~= "right" then
        settings.verticalTextSide = "right"
    end

    -- migrate old "off" and "inside" values to new vocabulary
    if settings.verticalPercentSide == "off" then
        settings.verticalPercentSide = "center"
    elseif settings.verticalPercentSide == "inside" then
        settings.verticalPercentSide = "center"
    end
    if settings.verticalPercentSide ~= "left"
        and settings.verticalPercentSide ~= "center"
        and settings.verticalPercentSide ~= "right"
    then
        settings.verticalPercentSide = "center"
    end

    local verticalPercentDisplay = settings.verticalPercentDisplay
    if verticalPercentDisplay == PERCENT_DISPLAY_INSIDE_BELOW then
        verticalPercentDisplay = PERCENT_DISPLAY_INSIDE
    end
    if verticalPercentDisplay ~= PERCENT_DISPLAY_INSIDE
        and verticalPercentDisplay ~= PERCENT_DISPLAY_BELOW_BAR
        and verticalPercentDisplay ~= PERCENT_DISPLAY_ABOVE_BAR
        and verticalPercentDisplay ~= PERCENT_DISPLAY_OFF
    then
        settings.verticalPercentDisplay = PERCENT_DISPLAY_INSIDE
    else
        settings.verticalPercentDisplay = verticalPercentDisplay
    end

    if settings.percentDisplay == PERCENT_DISPLAY_INSIDE_BELOW then
        settings.percentDisplay = PERCENT_DISPLAY_INSIDE
    end

    settings.showAlignmentDot = false

    local verticalTextAlign = settings.verticalTextAlign
    if verticalTextAlign ~= "top"
        and verticalTextAlign ~= "middle"
        and verticalTextAlign ~= "bottom"
        and verticalTextAlign ~= "top_prefix_only"
        and verticalTextAlign ~= "top_suffix_only"
        and verticalTextAlign ~= "bottom_prefix_only"
        and verticalTextAlign ~= "bottom_suffix_only"
        and verticalTextAlign ~= "separate"
    then
        settings.verticalTextAlign = "separate"
    end

    local legacyWidth = tonumber(settings.width)
    local legacyHeight = tonumber(settings.height)

    local horizontalWidth = tonumber(settings.horizontalWidth)
    if not horizontalWidth then
        horizontalWidth = legacyWidth or DEFAULTS.horizontalWidth
    end
    settings.horizontalWidth = Clamp(math.floor(horizontalWidth + 0.5), 100, 350)

    local horizontalHeight = tonumber(settings.horizontalHeight)
    if not horizontalHeight then
        horizontalHeight = legacyHeight or DEFAULTS.horizontalHeight
    end
    settings.horizontalHeight = Clamp(math.floor(horizontalHeight + 0.5), 10, 60)

    local verticalWidth = tonumber(settings.verticalWidth)
    if not verticalWidth then
        if settings.orientation == ORIENTATION_VERTICAL and legacyWidth then
            verticalWidth = legacyWidth
        else
            verticalWidth = DEFAULTS.verticalWidth
        end
    end
    settings.verticalWidth = Clamp(math.floor(verticalWidth + 0.5), 10, 60)

    local verticalHeight = tonumber(settings.verticalHeight)
    if not verticalHeight then
        if settings.orientation == ORIENTATION_VERTICAL and legacyHeight then
            verticalHeight = legacyHeight
        else
            verticalHeight = DEFAULTS.verticalHeight
        end
    end
    settings.verticalHeight = Clamp(math.floor(verticalHeight + 0.5), 100, 350)

    local legacySideOffset = tonumber(settings.verticalSideOffset)
    if not legacySideOffset then
        legacySideOffset = 10
    end

    local verticalTextOffset = tonumber(settings.verticalTextOffset)
    if not verticalTextOffset then
        verticalTextOffset = legacySideOffset
    end
    settings.verticalTextOffset = Clamp(math.floor(verticalTextOffset + 0.5), 2, 60)

    local verticalPercentOffset = tonumber(settings.verticalPercentOffset)
    if not verticalPercentOffset then
        verticalPercentOffset = legacySideOffset
    end
    settings.verticalPercentOffset = Clamp(math.floor(verticalPercentOffset + 0.5), 2, 60)

    settings.verticalSideOffset = settings.verticalTextOffset

    if settings.orientation == ORIENTATION_VERTICAL then
        settings.width = settings.verticalWidth
        settings.height = settings.verticalHeight
    else
        settings.width = settings.horizontalWidth
        settings.height = settings.horizontalHeight
    end

    if type(settings.point) ~= "table" then
        settings.point = {}
    end
    settings.point.anchor = "CENTER"
    settings.point.relativePoint = "CENTER"
    if settings.point.x ~= nil then
        settings.point.x = Round(tonumber(settings.point.x) or 0)
    end
    if settings.point.y ~= nil then
        settings.point.y = Round(tonumber(settings.point.y) or 0)
    end

    if type(settings.stageSuffixLabels) ~= "table" then
        settings.stageSuffixLabels = {}
    end
    for i = 1, MAX_STAGE do
        if type(settings.stageSuffixLabels[i]) ~= "string" then
            settings.stageSuffixLabels[i] = ""
        end
    end
end

local function IsEditModePreviewActive()
    local editModeFrame = _G.EditModeManagerFrame
    return editModeFrame and editModeFrame.IsShown and editModeFrame:IsShown()
end

local function GetTickLayerSettings()
    return "OVERLAY", 4
end

local function GetPercentTextLayerSettings()
    local mode = settings and settings.percentDisplay or PERCENT_DISPLAY_INSIDE
    if settings and settings.orientation == ORIENTATION_VERTICAL and type(settings.verticalPercentDisplay) == "string" then
        mode = settings.verticalPercentDisplay
    end

    if mode == PERCENT_DISPLAY_INSIDE_BELOW then
        mode = PERCENT_DISPLAY_INSIDE
    end

    if mode == PERCENT_DISPLAY_ABOVE_TICKS then
        return "OVERLAY", 10
    end

    return "OVERLAY", 7
end

local function ApplyVerticalLabelRotation(fontString, enabled, side)
    if not fontString or not fontString.SetRotation then
        return
    end

    if enabled then
        if side == "left" then
            fontString:SetRotation(math.pi / 2)
        else
            fontString:SetRotation(-math.pi / 2)
        end
    else
        fontString:SetRotation(0)
    end
end

local function ResolveVerticalLabelJustifyH(side, anchorPoint)
    if anchorPoint == "CENTER" then
        return "CENTER"
    end

    local isTop = type(anchorPoint) == "string" and string.sub(anchorPoint, 1, 3) == "TOP"
    local isBottom = type(anchorPoint) == "string" and string.sub(anchorPoint, 1, 6) == "BOTTOM"

    if side == "left" then
        if isTop then
            return "RIGHT"
        end
        if isBottom then
            return "LEFT"
        end
        return "LEFT"
    end

    if isTop then
        return "LEFT"
    end
    if isBottom then
        return "RIGHT"
    end
    return "RIGHT"
end

Preydator.GetRenderedVerticalPercent = function(rawPct, fillDirection)
    if fillDirection == FILL_DIRECTION_DOWN then
        return 100 - rawPct
    end

    return rawPct
end

Preydator.ResolveVerticalTextAnchor = function(side, align, offset, isSuffix)
    local sidePoint = (side == "left") and "LEFT" or "RIGHT"
    local topAnchor = "TOP" .. sidePoint
    local middleAnchor = sidePoint
    local bottomAnchor = "BOTTOM" .. sidePoint

    local relSidePoint = sidePoint
    local topRelative = "TOP" .. relSidePoint
    local middleRelative = relSidePoint
    local bottomRelative = "BOTTOM" .. relSidePoint
    local xOffset = (side == "left") and -(offset + FILL_INSET) or (offset + FILL_INSET)
    local gap = 14

    if align == "top" then
        if side == "left" then
            if isSuffix then
                return "TOPRIGHT", topRelative, xOffset, -2
            end
            return "TOPRIGHT", topRelative, xOffset, -(gap + 10)
        end
        local y = -2
        return "TOPLEFT", topRelative, xOffset, y
    end

    if align == "middle" then
        if side == "left" then
            if isSuffix then
                return "TOPRIGHT", middleRelative, xOffset, math.floor(gap / 2)
            end
            return "BOTTOMLEFT", middleRelative, xOffset, -math.floor(gap / 2)
        end
        if isSuffix then
            return "BOTTOM" .. sidePoint, middleRelative, xOffset, math.floor(gap / 2)
        end
        return "TOP" .. sidePoint, middleRelative, xOffset, -math.floor(gap / 2)
    end

    if align == "bottom" then
        if side == "left" then
            if isSuffix then
                return "TOPRIGHT", bottomRelative, xOffset, -(gap + 10)
            end
            return bottomAnchor, bottomRelative, xOffset, -10
        end
        local y = -10
        return bottomAnchor, bottomRelative, xOffset, y
    end

    if align == "top_prefix_only" then
        if side == "left" then
            if isSuffix then
                return bottomAnchor, bottomRelative, xOffset, -10
            end
            return "TOPRIGHT", topRelative, xOffset, -2
        end
        if isSuffix then
            return bottomAnchor, bottomRelative, xOffset, -10
        end
        return "TOPLEFT", topRelative, xOffset, -2
    end

    if align == "top_suffix_only" then
        if side == "left" then
            if isSuffix then
                return "TOPRIGHT", topRelative, xOffset, -2
            end
            return bottomAnchor, bottomRelative, xOffset, -10
        end
        if isSuffix then
            return "TOPLEFT", topRelative, xOffset, -2
        end
        return bottomAnchor, bottomRelative, xOffset, -10
    end

    if align == "bottom_prefix_only" then
        if side == "left" then
            if isSuffix then
                return "TOPRIGHT", topRelative, xOffset, -2
            end
            return bottomAnchor, bottomRelative, xOffset, -10
        end
        if isSuffix then
            return "TOPLEFT", topRelative, xOffset, -2
        end
        return bottomAnchor, bottomRelative, xOffset, -10
    end

    if align == "bottom_suffix_only" then
        if side == "left" then
            if isSuffix then
                return bottomAnchor, bottomRelative, xOffset, -10
            end
            return "TOPRIGHT", topRelative, xOffset, -2
        end
        if isSuffix then
            return bottomAnchor, bottomRelative, xOffset, -10
        end
        return "TOPLEFT", topRelative, xOffset, -2
    end

    if side == "left" then
        if isSuffix then
            return "TOPRIGHT", topRelative, xOffset, -2
        end
        return bottomAnchor, bottomRelative, xOffset, -10
    end

    if isSuffix then
        return bottomAnchor, bottomRelative, xOffset, -10
    end

    return "TOPLEFT", topRelative, xOffset, -2
end

local function ToVerticalText(text)
    if type(text) ~= "string" or text == "" then
        return ""
    end

    local chars = {}
    for ch in text:gmatch(".") do
        chars[#chars + 1] = ch
    end

    return table.concat(chars, "\n")
end

local function NormalizeProgressSettings()
    local mode = settings.progressSegments
    if mode ~= PROGRESS_SEGMENTS_QUARTERS and mode ~= PROGRESS_SEGMENTS_THIRDS then
        settings.progressSegments = PROGRESS_SEGMENTS_QUARTERS
        return
    end

    settings.progressSegments = mode
end

local function NormalizeAmbushSettings()
    settings.ambushSoundEnabled = settings.ambushSoundEnabled ~= false
    settings.ambushVisualEnabled = settings.ambushVisualEnabled ~= false

    if type(settings.ambushSoundPath) ~= "string" or settings.ambushSoundPath == "" then
        local legacySoundKey = settings.ambushSoundKey
        settings.ambushSoundPath = GetSoundPathForKey(legacySoundKey, KILL_SOUND_PATH)
    end

    settings.ambushSoundKey = nil
    settings.ambushCustomSoundPath = nil
end

local function GetProgressTickPercents()
    local mode = (settings and settings.progressSegments) or PROGRESS_SEGMENTS_QUARTERS
    local tickPercents = BAR_TICK_PCTS_BY_SEGMENT[mode]
    if type(tickPercents) ~= "table" then
        return BAR_TICK_PCTS_BY_SEGMENT[PROGRESS_SEGMENTS_QUARTERS]
    end

    return tickPercents
end

local function GetStageFallbackPercent(stage)
    local mode = (settings and settings.progressSegments) or PROGRESS_SEGMENTS_QUARTERS
    local stagePercents = STAGE_PCT_BY_SEGMENT[mode] or STAGE_PCT_BY_SEGMENT[PROGRESS_SEGMENTS_QUARTERS]
    return stagePercents[stage] or 0
end

local function GetPreyZoneInfo(questID)
    if not questID then
        return nil, nil
    end

    if not (C_TaskQuest and C_TaskQuest.GetQuestZoneID and C_Map and C_Map.GetMapInfo) then
        return nil, nil
    end

    local mapID = C_TaskQuest.GetQuestZoneID(questID)
    if not mapID then
        return nil, nil
    end

    local mapInfo = C_Map.GetMapInfo(mapID)
    return (mapInfo and mapInfo.name or nil), mapID
end

local function IsPlayerInPreyZone(preyMapID)
    if not preyMapID then
        return nil
    end

    if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetMapInfo) then
        return nil
    end

    if state.zoneCacheDirty == true or type(state.playerMapHierarchy) ~= "table" then
        local playerMapID = C_Map.GetBestMapForUnit("player")
        state.playerMapID = playerMapID
        state.playerMapHierarchy = {}
        state.zoneCacheDirty = false

        local guard = 0
        local currentMapID = playerMapID
        while currentMapID and guard < 20 do
            state.playerMapHierarchy[currentMapID] = true

            local mapInfo = C_Map.GetMapInfo(currentMapID)
            if not mapInfo or not mapInfo.parentMapID then
                break
            end

            currentMapID = mapInfo.parentMapID
            guard = guard + 1
        end
    end

    if not state.playerMapID then
        return nil
    end

    return state.playerMapHierarchy[preyMapID] == true
end

local function IsPreyQuestOnCurrentMap(questID)
    if not (questID and C_QuestLog and C_QuestLog.GetLogIndexForQuestID and C_QuestLog.GetInfo) then
        return nil
    end

    local logIndex = C_QuestLog.GetLogIndexForQuestID(questID)
    if not logIndex then
        return nil
    end

    local info = C_QuestLog.GetInfo(logIndex)
    if type(info) ~= "table" then
        return nil
    end

    if info.isOnMap == nil then
        return nil
    end

    return info.isOnMap == true
end

local function RefreshInPreyZoneStatus(questID, force)
    if not IsValidQuestID(questID) then
        state.inPreyZone = nil
        return nil
    end

    local now = GetTime and GetTime() or 0
    local staleFalseCheck = state.inPreyZone == false
        and (now - (state.lastZoneStatusRefreshAt or 0)) >= 2.0

    if staleFalseCheck then
        -- Force a map hierarchy rebuild during retry checks so we do not stay
        -- stuck on a stale map snapshot after loading-screen transitions.
        state.zoneCacheDirty = true
    end

    local shouldRefresh = force == true or state.inPreyZone == nil or state.zoneCacheDirty == true or staleFalseCheck
    if not shouldRefresh then
        return state.inPreyZone
    end

    local inPreyZone = nil
    if state.preyZoneMapID then
        inPreyZone = IsPlayerInPreyZone(state.preyZoneMapID)
    else
        inPreyZone = IsPreyQuestOnCurrentMap(questID)
        -- For quests with no task-quest map ID, treat this as our zone snapshot.
        state.zoneCacheDirty = false
    end

    if inPreyZone == nil then
        inPreyZone = IsPreyQuestOnCurrentMap(questID)
        state.zoneCacheDirty = false
    end

    state.inPreyZone = inPreyZone
    state.lastZoneStatusRefreshAt = now
    return inPreyZone
end

local function GetDefaultStageSoundPath(stage)
    if stage == 1 then
        return ALERT_SOUND_PATH
    end
    if stage == 2 then
        return AMBUSH_SOUND_PATH
    end
    if stage == 3 then
        return TORMENT_SOUND_PATH
    end
    if stage == 4 then
        return KILL_SOUND_PATH
    end

    return nil
end

local function BuildAddonSoundPath(fileName)
    if type(fileName) ~= "string" then
        return nil
    end

    local trimmed = fileName:match("^%s*(.-)%s*$")
    if trimmed == "" then
        return nil
    end

    if string.find(trimmed, "\\", 1, true) then
        return trimmed
    end

    return SOUND_FOLDER_PREFIX .. trimmed
end

local function ExtractAddonSoundFileName(path)
    if type(path) ~= "string" or path == "" then
        return nil
    end

    local lower = string.lower(path)
    local prefixLower = string.lower(SOUND_FOLDER_PREFIX)
    if string.sub(lower, 1, #prefixLower) ~= prefixLower then
        return nil
    end

    local fileName = string.sub(path, #SOUND_FOLDER_PREFIX + 1)
    if fileName == "" then
        return nil
    end

    return fileName
end

local function NormalizeSoundFileName(fileName)
    if type(fileName) ~= "string" then
        return nil
    end

    local normalized = string.lower(fileName:match("^%s*(.-)%s*$") or "")
    if normalized == "" then
        return nil
    end

    local prefixLower = string.lower(SOUND_FOLDER_PREFIX)
    if string.sub(normalized, 1, #prefixLower) == prefixLower then
        normalized = string.sub(normalized, #prefixLower + 1)
    end

    if normalized == "" then
        return nil
    end

    if normalized:find("[/\\]") then
        return nil
    end

    if not normalized:match("%.ogg$") then
        normalized = normalized .. ".ogg"
    end

    return normalized
end

local function AddSoundFileName(fileName)
    local normalized = NormalizeSoundFileName(fileName)
    if not normalized then
        return false, "Use a valid sound filename (optionally with .ogg)"
    end

    settings.soundFileNames = settings.soundFileNames or {}
    for _, existing in ipairs(settings.soundFileNames) do
        if NormalizeSoundFileName(existing) == normalized then
            return false, "File is already in the list"
        end
    end

    table.insert(settings.soundFileNames, normalized)
    NormalizeSoundSettings()
    return true, normalized
end

local function RemoveSoundFileName(fileName)
    local normalized = NormalizeSoundFileName(fileName)
    if not normalized then
        return false, "Use a valid sound filename (optionally with .ogg)"
    end

    if PROTECTED_SOUND_FILENAMES[normalized] then
        return false, "Default sound files cannot be removed"
    end

    settings.soundFileNames = settings.soundFileNames or {}
    local removed = false
    for index = #settings.soundFileNames, 1, -1 do
        local existing = NormalizeSoundFileName(settings.soundFileNames[index])
        if existing == normalized then
            table.remove(settings.soundFileNames, index)
            removed = true
            break
        end
    end

    if not removed then
        local rawInput = string.lower((tostring(fileName or ""):match("^%s*(.-)%s*$") or ""))
        local candidates = {}

        if rawInput ~= "" then
            for index = #settings.soundFileNames, 1, -1 do
                local existing = NormalizeSoundFileName(settings.soundFileNames[index])
                if existing then
                    local existingNoExt = existing:gsub("%.ogg$", "")
                    if rawInput == existing
                        or rawInput == existingNoExt
                        or string.sub(existingNoExt, -#rawInput) == rawInput
                    then
                        table.insert(candidates, { index = index, name = existing })
                    end
                end
            end
        end

        if #candidates == 1 then
            table.remove(settings.soundFileNames, candidates[1].index)
            removed = true
            normalized = candidates[1].name
        elseif #candidates > 1 then
            return false, "Multiple matches found. Type more of the file name."
        end
    end

    if not removed then
        return false, "File is not in the custom list"
    end

    NormalizeSoundSettings()
    return true, normalized
end

GetSoundPathForKey = function(soundKey, fallbackPath)
    if soundKey == AMBUSH_SOUND_ALERT then
        return ALERT_SOUND_PATH
    end
    if soundKey == AMBUSH_SOUND_AMBUSH then
        return AMBUSH_SOUND_PATH
    end
    if soundKey == AMBUSH_SOUND_TORMENT then
        return TORMENT_SOUND_PATH
    end
    if soundKey == AMBUSH_SOUND_KILL then
        return KILL_SOUND_PATH
    end
    return fallbackPath
end

local function BuildSoundDisplayName(fileName)
    local short = tostring(fileName or "")
    short = short:gsub("%.ogg$", "")
    short = short:gsub("[_%-]+", " ")
    short = short:gsub("%s+", " ")
    short = short:gsub("^%l", string.upper)
    short = short:gsub("%s%l", function(s)
        return string.upper(s)
    end)
    return short
end

local function BuildSoundDropdownOptions()
    local options = {}
    local files = (settings and settings.soundFileNames) or DEFAULT_SOUND_FILENAMES

    options["__NONE__"] = {
        text = _G.PreydatorL["None"],
    }

    for _, fileName in ipairs(files) do
        local normalized = NormalizeSoundFileName(fileName)
        if normalized then
            local path = BuildAddonSoundPath(normalized)
            options[path] = {
                text = BuildSoundDisplayName(normalized),
            }
        end
    end

    return options
end

local function ResolveAmbushAlertSoundPath()
    local path = settings and settings.ambushSoundPath
    if path == "__NONE__" then
        return nil
    end
    if type(path) == "string" and path ~= "" then
        return path
    end

    return KILL_SOUND_PATH
end

local function GetWidgetTypePreyHuntProgress()
    if Enum and Enum.UIWidgetVisualizationType and Enum.UIWidgetVisualizationType.PreyHuntProgress then
        return Enum.UIWidgetVisualizationType.PreyHuntProgress
    end

    return PREY_WIDGET_TYPE
end

local function GetShownStateShown()
    if Enum and Enum.WidgetShownState and Enum.WidgetShownState.Shown then
        return Enum.WidgetShownState.Shown
    end

    return WIDGET_SHOWN
end

local function GetCurrentActivePreyQuest()
    if C_QuestLog and C_QuestLog.GetActivePreyQuest then
        return C_QuestLog.GetActivePreyQuest()
    end

    return nil
end

local function RefreshCurrentActivePreyQuestCache()
    local now = GetTime and GetTime() or 0
    state.cachedActivePreyQuestID = GetCurrentActivePreyQuest()
    state.cachedActivePreyQuestAt = now
    return state.cachedActivePreyQuestID
end

local function GetCurrentActivePreyQuestCached(maxAgeSeconds)
    local now = GetTime and GetTime() or 0
    local maxAge = tonumber(maxAgeSeconds)
    if not maxAge or maxAge < 0 then
        maxAge = ACTIVE_PREY_QUEST_CACHE_SECONDS
    end

    if (now - (state.cachedActivePreyQuestAt or 0)) > maxAge then
        return RefreshCurrentActivePreyQuestCache()
    end

    return state.cachedActivePreyQuestID
end

local function ArmQuestListenBurst(durationSeconds)
    local now = GetTime and GetTime() or 0
    local duration = tonumber(durationSeconds)
    if not duration or duration <= 0 then
        duration = QUEST_LISTEN_BURST_SECONDS
    end
    local untilTime = now + duration
    if untilTime > (state.questListenUntil or 0) then
        state.questListenUntil = untilTime
    end
    -- Force a fresh quest sample when a relevant interaction starts.
    RefreshCurrentActivePreyQuestCache()
end

local function GetQuestTitle(questID)
    if not (C_QuestLog and C_QuestLog.GetTitleForQuestID) then
        return nil
    end

    local titleInfo = C_QuestLog.GetTitleForQuestID(questID)
    if type(titleInfo) == "table" then
        return titleInfo.title
    end

    return titleInfo
end

local function ExtractPreyTargetFromQuestTitle(questID)
    if type(questID) ~= "number" or questID < 1 then
        return nil, nil
    end

    local title = GetQuestTitle(questID)
    if type(title) ~= "string" or title == "" then
        return nil, nil
    end

    local preyName, difficulty = title:match("^%s*[Pp]rey:%s*(.-)%s*%((.-)%)%s*$")
    if preyName and preyName ~= "" then
        return preyName, difficulty
    end

    preyName = title:match("^%s*[Pp]rey:%s*(.-)%s*$")
    if preyName and preyName ~= "" then
        return preyName, nil
    end

    return nil, nil
end

local function StringContainsInsensitiveSafe(haystack, needle)
    if type(haystack) ~= "string" or type(needle) ~= "string" or needle == "" then
        return false
    end

    local ok, found = pcall(function()
        local haystackLower = string.lower(haystack)
        local needleLower = string.lower(needle)
        return string.find(haystackLower, needleLower, 1, true) ~= nil
    end)

    return ok and found or false
end

local function IsAmbushSystemMessage(message, sender)
    if type(message) ~= "string" then
        return false
    end

    -- Detection relies solely on prey name match to avoid English-only string dependency
    -- and to eliminate the double-trigger caused by both the "Ambushed!" system message
    -- and CHAT_MSG_MONSTER_SAY firing for the same encounter.
    local preyName = state and state.preyTargetName
    if type(preyName) == "string" and preyName ~= "" then
        if StringContainsInsensitiveSafe(message, preyName) or StringContainsInsensitiveSafe(sender, preyName) then
            return true
        end
    end

    return false
end

local function IsRestrictedInstanceForPreyBar()
    local inInstance = false
    local instanceType = nil

    if IsInInstance then
        local ok, inInst, instType = pcall(IsInInstance)
        if ok then
            inInstance = inInst == true
            instanceType = instType
        end
    end

    if inInstance then
        return instanceType == "party"
            or instanceType == "raid"
            or instanceType == "scenario"
            or instanceType == "delve"
    end

    -- Fallback: some Delve transitions can report inconsistent IsInInstance states
    -- while the player map is already a dungeon-type map.
    if C_Map and C_Map.GetBestMapForUnit and C_Map.GetMapInfo then
        local playerMapID = C_Map.GetBestMapForUnit("player")
        if playerMapID then
            local mapInfo = C_Map.GetMapInfo(playerMapID)
            if mapInfo and tonumber(mapInfo.mapType) == 4 then
                return true
            end
        end
    end

    return false
end

local function ShouldScanAmbushChat()
    if not state then
        return false
    end

    local liveQuestID = GetCurrentActivePreyQuestCached(0)
    if not IsValidQuestID(liveQuestID) then
        return false
    end

    if state.activeQuestID ~= liveQuestID then
        state.zoneCacheDirty = true
        return false
    end

    -- Ambush detection is only relevant before final stage and while in prey zone.
    if tonumber(state.stage) == MAX_STAGE then
        return false
    end

    if state.zoneCacheDirty == true or state.inPreyZone == nil then
        RefreshInPreyZoneStatus(liveQuestID, true)
    end

    if state.inPreyZone ~= true then
        return false
    end

    return not IsRestrictedInstanceForPreyBar()
end

local function TriggerAmbushAlert(message, source)
    local now = GetTime and GetTime() or 0
    state.lastAmbushSystemMessage = message

    if settings.ambushVisualEnabled ~= false then
        state.ambushAlertUntil = now + AMBUSH_ALERT_DURATION_SECONDS
    end

    if settings.ambushSoundEnabled ~= false then
        local nextSoundAt = (state.lastAmbushSoundAt or 0) + AMBUSH_SOUND_COOLDOWN_SECONDS
        if now >= nextSoundAt then
            local ambushPath = ResolveAmbushAlertSoundPath()
            TryPlaySound(ambushPath)
            state.lastAmbushSoundAt = now
        end
    end

    AddDebugLog("Ambush", "Detected from " .. tostring(source) .. ": " .. tostring(message), true)
    UpdateBarDisplay()
end

local function IsQuestStillActive(questID)
    if not questID or questID < 1 then
        return false
    end

    if C_QuestLog and C_QuestLog.IsOnQuest then
        return C_QuestLog.IsOnQuest(questID) and true or false
    end

    return true
end

IsValidQuestID = function(questID)
    return type(questID) == "number" and questID > 0
end

local function EnsureDebugDB()
    _G.PreydatorDebugDB = _G.PreydatorDebugDB or {}
    debugDB = _G.PreydatorDebugDB
    if type(debugDB.entries) ~= "table" then
        debugDB.entries = {}
    end
    if debugDB.enabled == nil then
        debugDB.enabled = true
    end
end

AddDebugLog = function(kind, message, forcePrint)
    if not debugDB then
        return
    end

    if not debugDB.enabled then
        return
    end

    local now = GetTime and GetTime() or 0
    local entry = string.format("%0.3f | %s | %s", now, tostring(kind or "?"), tostring(message or ""))
    table.insert(debugDB.entries, entry)

    while #debugDB.entries > DEBUG_LOG_LIMIT do
        table.remove(debugDB.entries, 1)
    end

    if forcePrint then
        print(L["Preydator DEBUG: "] .. entry)
    end
end

TryPlaySound = function(path, ignoreSoundToggle)
    local customization = Preydator and Preydator.GetModule and Preydator:GetModule("CustomizationStateV2")
    if customization and type(customization.IsModuleEnabled) == "function" and customization:IsModuleEnabled("sounds") ~= true then
        AddDebugLog("TryPlaySound", "blocked by sounds module disabled | path=" .. tostring(path), false)
        return false
    end

    if not ignoreSoundToggle and settings and settings.soundsEnabled == false then
        AddDebugLog("TryPlaySound", "blocked by soundsEnabled=false | path=" .. tostring(path), false)
        return false
    end

    local channel = (settings and settings.soundChannel) or "SFX"
    local willPlay = PlaySoundFile(path, channel)
    AddDebugLog("TryPlaySound", "path=" .. tostring(path) .. " | channel=" .. tostring(channel) .. " | ignoreToggle=" .. tostring(ignoreSoundToggle) .. " | result=" .. tostring(willPlay), false)
    if willPlay then
        local enhance = (settings and tonumber(settings.soundEnhance)) or 0
        if enhance > 0 and C_Timer and C_Timer.After then
            local extraPlays = math.min(4, math.max(0, math.floor(enhance / 25)))
            for i = 1, extraPlays do
                local delay = i * 0.03
                C_Timer.After(delay, function()
                    PlaySoundFile(path, channel)
                end)
            end
            if extraPlays > 0 then
                AddDebugLog("TryPlaySound", "enhance=" .. tostring(enhance) .. " | extraPlays=" .. tostring(extraPlays), false)
            end
        end
        return true
    end

    local warnedKey = tostring(path or "")
    if warnedMissingSoundPaths[warnedKey] ~= true then
        warnedMissingSoundPaths[warnedKey] = true
        print("Preydator: Sound failed to play: '" .. warnedKey .. "'. Ensure the .ogg exists in Interface\\AddOns\\Preydator\\sounds\\ and is listed in Custom Sound Files.")
    end

    return false
end

local function ResolveStageSoundPath(stage)
    stage = tonumber(stage)
    if not stage then
        AddDebugLog("ResolveStageSoundPath", "invalid stage", false)
        return nil
    end

    local defaultPath = GetDefaultStageSoundPath(stage)

    if not settings then
        return defaultPath
    end

    settings.stageSounds = settings.stageSounds or {}
    local sounds = settings.stageSounds

    local savedPath = sounds[stage]
    if savedPath == "__NONE__" then
        AddDebugLog("ResolveStageSoundPath", "stage=" .. stage .. " | source=saved | path=none", false)
        return nil
    end
    if type(savedPath) == "string" and savedPath ~= "" then
        AddDebugLog("ResolveStageSoundPath", "stage=" .. stage .. " | source=saved | path=" .. savedPath, false)
        return savedPath
    end

    if defaultPath and defaultPath ~= "" then
        sounds[stage] = defaultPath
        AddDebugLog("ResolveStageSoundPath", "stage=" .. stage .. " | source=default | path=" .. defaultPath, false)
        return defaultPath
    end

    AddDebugLog("ResolveStageSoundPath", "stage=" .. stage .. " | source=none | default=nil", true)

    return nil
end

TryPlayStageSound = function(stage, ignoreSoundToggle)
    local path = ResolveStageSoundPath(stage)
    if not path then
        AddDebugLog("TryPlayStageSound", "stage=" .. tostring(stage) .. " | no resolved path", true)
        return false
    end

    if state.stageSoundPlayed[stage] then
        AddDebugLog("TryPlayStageSound", "stage=" .. tostring(stage) .. " | skipped already played", false)
        return false
    end

    if state.stageSoundAttempted[stage] then
        return false
    end

    state.stageSoundAttempted[stage] = true

    if TryPlaySound(path, ignoreSoundToggle) then
        state.stageSoundPlayed[stage] = true
        AddDebugLog("TryPlayStageSound", "stage=" .. tostring(stage) .. " | success", false)
        return true
    end

    if stage == MAX_STAGE then
        local fallbackPath = ResolveStageSoundPath(MAX_STAGE - 1)
        if fallbackPath then
            AddDebugLog("TryPlayStageSound", "stage=" .. tostring(MAX_STAGE) .. " | primary failed, trying fallback stage=" .. tostring(MAX_STAGE - 1) .. " | path=" .. tostring(fallbackPath), true)
            if TryPlaySound(fallbackPath, ignoreSoundToggle) then
                state.stageSoundPlayed[stage] = true
                AddDebugLog("TryPlayStageSound", "stage=" .. tostring(MAX_STAGE) .. " | fallback stage=" .. tostring(MAX_STAGE - 1) .. " success", true)
                return true
            end
            AddDebugLog("TryPlayStageSound", "stage=" .. tostring(MAX_STAGE) .. " | fallback stage=" .. tostring(MAX_STAGE - 1) .. " also failed", true)
        end
    end

    local channel = (settings and settings.soundChannel) or "SFX"
    AddDebugLog("TryPlayStageSound", "stage=" .. tostring(stage) .. " | path=" .. tostring(path) .. " | channel=" .. tostring(channel) .. " | PlaySoundFile returned false", true)

    return false
end

local barPositionUtil = {
    defaultX = 0,
    defaultY = 472,
}

function barPositionUtil.GetDefaultPoint(frameWidth, frameHeight)
    return barPositionUtil.defaultX, barPositionUtil.defaultY
end

function barPositionUtil.ClampToScreen(x, y, frameWidth, frameHeight)
    local parentWidth = UIParent and UIParent.GetWidth and UIParent:GetWidth() or 0
    local parentHeight = UIParent and UIParent.GetHeight and UIParent:GetHeight() or 0
    local width = math.max(1, tonumber(frameWidth) or 0)
    local height = math.max(1, tonumber(frameHeight) or 0)
    local margin = 8

    if parentWidth <= 0 or parentHeight <= 0 then
        local defaultX, defaultY = barPositionUtil.GetDefaultPoint(width, height)
        return Round(tonumber(x) or defaultX), Round(tonumber(y) or defaultY)
    end

    local maxX = math.max(0, math.floor(((parentWidth - width) / 2) - margin))
    local maxY = math.max(0, math.floor(((parentHeight - height) / 2) - margin))
    local defaultX, defaultY = barPositionUtil.GetDefaultPoint(width, height)
    local clampedX = Clamp(Round(tonumber(x) or defaultX), -maxX, maxX)
    local clampedY = Clamp(Round(tonumber(y) or defaultY), -maxY, maxY)
    return clampedX, clampedY
end

function barPositionUtil.GetCurrentDimensions()
    local orientation = settings and settings.orientation or ORIENTATION_HORIZONTAL
    local frameScale
    local baseWidth
    local baseHeight

    if orientation == ORIENTATION_VERTICAL then
        frameScale = Clamp(tonumber(settings and settings.verticalScale) or DEFAULTS.verticalScale, 0.5, 2)
        baseWidth = Clamp(math.floor((tonumber(settings and settings.verticalWidth) or DEFAULTS.verticalWidth) + 0.5), 10, 60)
        baseHeight = Clamp(math.floor((tonumber(settings and settings.verticalHeight) or DEFAULTS.verticalHeight) + 0.5), 100, 350)
    else
        frameScale = Clamp(tonumber(settings and settings.scale) or DEFAULTS.scale, 0.5, 2)
        baseWidth = Clamp(math.floor((tonumber(settings and settings.horizontalWidth) or DEFAULTS.horizontalWidth) + 0.5), 100, 350)
        baseHeight = Clamp(math.floor((tonumber(settings and settings.horizontalHeight) or DEFAULTS.horizontalHeight) + 0.5), 10, 60)
    end

    return math.max(1, Round(baseWidth * frameScale)), math.max(1, Round(baseHeight * frameScale))
end

function barPositionUtil.Reset()
    settings.point = settings.point or {}
    settings.point.anchor = "CENTER"
    settings.point.relativePoint = "CENTER"

    local width, height = barPositionUtil.GetCurrentDimensions()
    settings.point.x, settings.point.y = barPositionUtil.GetDefaultPoint(width, height)
    SyncBarPointToBackup()

    ApplyBarSettings()
    UpdateBarDisplay()
end

ApplyBarSettings = function()
    if not UI.barFrame then
        return
    end

    settings.point = settings.point or {}
    local point = settings.point
    local anchor = string.upper(tostring(point.anchor or DEFAULTS.point.anchor))
    local relativePoint = string.upper(tostring(point.relativePoint or DEFAULTS.point.relativePoint))
    local orientation = settings.orientation or ORIENTATION_HORIZONTAL
    local frameScale
    if orientation == ORIENTATION_VERTICAL then
        frameScale = Clamp(tonumber(settings.verticalScale) or DEFAULTS.verticalScale, 0.5, 2)
    else
        frameScale = Clamp(tonumber(settings.scale) or DEFAULTS.scale, 0.5, 2)
    end
    local baseWidth
    local baseHeight
    if orientation == ORIENTATION_VERTICAL then
        baseWidth = Clamp(math.floor((tonumber(settings.verticalWidth) or DEFAULTS.verticalWidth) + 0.5), 10, 60)
        baseHeight = Clamp(math.floor((tonumber(settings.verticalHeight) or DEFAULTS.verticalHeight) + 0.5), 100, 350)
        settings.verticalWidth = baseWidth
        settings.verticalHeight = baseHeight
    else
        baseWidth = Clamp(math.floor((tonumber(settings.horizontalWidth) or DEFAULTS.horizontalWidth) + 0.5), 100, 350)
        baseHeight = Clamp(math.floor((tonumber(settings.horizontalHeight) or DEFAULTS.horizontalHeight) + 0.5), 10, 60)
        settings.horizontalWidth = baseWidth
        settings.horizontalHeight = baseHeight
    end

    settings.width = baseWidth
    settings.height = baseHeight

    local scaledWidth = math.max(1, Round(baseWidth * frameScale))
    local scaledHeight = math.max(1, Round(baseHeight * frameScale))
    if anchor ~= "CENTER" then
        anchor = "CENTER"
    end

    if relativePoint ~= "CENTER" then
        relativePoint = "CENTER"
    end

    if point.x == nil or point.y == nil then
        point.x, point.y = barPositionUtil.GetDefaultPoint(scaledWidth, scaledHeight)
    end

    local clampedX, clampedY = barPositionUtil.ClampToScreen(point.x, point.y, scaledWidth, scaledHeight)
    point.anchor = anchor
    point.relativePoint = relativePoint

    if orientation == ORIENTATION_VERTICAL then
        settings.verticalScale = frameScale
    else
        settings.scale = frameScale
    end

    UI.barFrame:SetSize(scaledWidth, scaledHeight)
    UI.barFrame:SetScale(1)
    UI.barFrame:SetFrameStrata("MEDIUM")
    UI.barFrame:SetFrameLevel(5)
    UI.barFrame:ClearAllPoints()
    UI.barFrame:SetPoint("CENTER", UIParent, "CENTER", clampedX, clampedY)

    if UI.barFill then
        local fill = settings.fillColor
        UI.barFill:ClearAllPoints()
        UI.barFill:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
        UI.barFill:SetSize(0, math.max(1, scaledHeight - 2 * FILL_INSET))
        UI.barFill:SetTexture(TEXTURE_PRESETS[settings.textureKey] or TEXTURE_PRESETS.default)
        UI.barFill:SetVertexColor(fill[1], fill[2], fill[3], fill[4])
        UI.barFill:SetDrawLayer("ARTWORK", 0)

        if UI.barBorder and UI.barBorder.SetBackdropBorderColor then
            if settings.borderColorLinked == false and settings.borderColor then
                local bc = settings.borderColor
                UI.barBorder:SetBackdropBorderColor(bc[1], bc[2], bc[3], bc[4] or 0.85)
            else
                UI.barBorder:SetBackdropBorderColor(fill[1], fill[2], fill[3], math.max(0.65, fill[4] or 0.85))
            end
        end
    end

    if UI.barSpark then
        local spark = settings.sparkColor or DEFAULTS.sparkColor
        UI.barSpark:SetColorTexture(spark[1], spark[2], spark[3], spark[4] or 0.9)
        if orientation == ORIENTATION_VERTICAL then
            UI.barSpark:SetSize(math.max(1, scaledWidth - 2 * FILL_INSET), 2)
        else
            UI.barSpark:SetSize(2, math.max(1, scaledHeight - 2 * FILL_INSET))
        end
        UI.barSpark:SetDrawLayer("OVERLAY", 3)
        if not settings.showSparkLine then
            UI.barSpark:Hide()
        end
    end

    if UI.barFrame.BackgroundTexture then
        local bg = settings.bgColor
        UI.barFrame.BackgroundTexture:ClearAllPoints()
        UI.barFrame.BackgroundTexture:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
        UI.barFrame.BackgroundTexture:SetPoint("TOPRIGHT", UI.barFrame, "TOPRIGHT", -FILL_INSET, -FILL_INSET)
        UI.barFrame.BackgroundTexture:SetColorTexture(bg[1], bg[2], bg[3], bg[4])
    end

    local labelRow = settings.labelRowPosition or LABEL_ROW_ABOVE
    local verticalTextSide = settings.verticalTextSide or "right"
    local verticalPercentSide = settings.verticalPercentSide or "center"
    local percentDisplayMode = settings.percentDisplay or PERCENT_DISPLAY_INSIDE
    if orientation == ORIENTATION_VERTICAL then
        percentDisplayMode = settings.verticalPercentDisplay or settings.percentDisplay or PERCENT_DISPLAY_INSIDE
    end
    local verticalTextOffset = Clamp(math.floor((tonumber(settings.verticalTextOffset) or 10) + 0.5), 2, 60)
    local verticalPercentOffset = Clamp(math.floor((tonumber(settings.verticalPercentOffset) or 10) + 0.5), 2, 60)
    local verticalTextAlign = settings.verticalTextAlign or "separate"

    if UI.stageText then
        local _, _, flags = UI.stageText:GetFont()
        local titleFont = FONT_PRESETS[settings.titleFontKey] or FONT_PRESETS.frizqt
        UI.stageText:SetFont(titleFont, math.max(8, Round((tonumber(settings.fontSize) or DEFAULTS.fontSize) * frameScale)), flags)
        local titleColor = settings.titleColor or DEFAULTS.titleColor
        UI.stageText:SetTextColor(titleColor[1], titleColor[2], titleColor[3], titleColor[4] or 1)

        local lm = settings.stageLabelMode or LABEL_MODE_CENTER
        UI.stageText:ClearAllPoints()
        if orientation == ORIENTATION_VERTICAL then
            local anchorPoint, relativeAnchor, xOffset, yOffset
            if verticalTextAlign == "middle" then
                anchorPoint = "CENTER"
                relativeAnchor = (verticalTextSide == "left") and "LEFT" or "RIGHT"
                xOffset = (verticalTextSide == "left") and -(verticalTextOffset + FILL_INSET) or (verticalTextOffset + FILL_INSET)
                yOffset = -6
            elseif verticalTextAlign == "top" then
                local useSuffixBoundary = verticalTextSide == "left"
                anchorPoint, relativeAnchor, xOffset, yOffset = Preydator.ResolveVerticalTextAnchor(verticalTextSide, verticalTextAlign, verticalTextOffset, useSuffixBoundary)
            elseif verticalTextAlign == "bottom" then
                local useSuffixBoundary = verticalTextSide == "right"
                anchorPoint, relativeAnchor, xOffset, yOffset = Preydator.ResolveVerticalTextAnchor(verticalTextSide, verticalTextAlign, verticalTextOffset, useSuffixBoundary)
            else
                anchorPoint, relativeAnchor, xOffset, yOffset = Preydator.ResolveVerticalTextAnchor(verticalTextSide, verticalTextAlign, verticalTextOffset, false)
            end
            UI.stageText:SetPoint(anchorPoint, UI.barFrame, relativeAnchor, xOffset, yOffset)
            UI.stageText:SetJustifyH(ResolveVerticalLabelJustifyH(verticalTextSide, anchorPoint))
            UI.stageText:SetJustifyV("MIDDLE")
            ApplyVerticalLabelRotation(UI.stageText, true, verticalTextSide)
        elseif lm == LABEL_MODE_LEFT or lm == LABEL_MODE_LEFT_COMBINED or lm == LABEL_MODE_LEFT_SUFFIX or lm == LABEL_MODE_SEPARATE then
            if labelRow == LABEL_ROW_BELOW then
                UI.stageText:SetPoint("TOPLEFT", UI.barFrame, "BOTTOMLEFT", 2, -4)
            else
                UI.stageText:SetPoint("BOTTOMLEFT", UI.barFrame, "TOPLEFT", 2, 4)
            end
            UI.stageText:SetJustifyH("LEFT")
            ApplyVerticalLabelRotation(UI.stageText, false, verticalTextSide)
        elseif lm == LABEL_MODE_NONE then
            if labelRow == LABEL_ROW_BELOW then
                UI.stageText:SetPoint("TOP", UI.barFrame, "BOTTOM", 0, -4)
            else
                UI.stageText:SetPoint("BOTTOM", UI.barFrame, "TOP", 0, 4)
            end
            ApplyVerticalLabelRotation(UI.stageText, false, verticalTextSide)
        else
            if labelRow == LABEL_ROW_BELOW then
                UI.stageText:SetPoint("TOP", UI.barFrame, "BOTTOM", 0, -4)
            else
                UI.stageText:SetPoint("BOTTOM", UI.barFrame, "TOP", 0, 4)
            end
            UI.stageText:SetJustifyH("CENTER")
            ApplyVerticalLabelRotation(UI.stageText, false, verticalTextSide)
        end
    end

    if UI.stageSuffixText then
        local _, _, flags = UI.stageSuffixText:GetFont()
        local titleFont = FONT_PRESETS[settings.titleFontKey] or FONT_PRESETS.frizqt
        UI.stageSuffixText:SetFont(titleFont, math.max(8, Round((tonumber(settings.fontSize) or DEFAULTS.fontSize) * frameScale)), flags)
        local titleColor = settings.titleColor or DEFAULTS.titleColor
        UI.stageSuffixText:SetTextColor(titleColor[1], titleColor[2], titleColor[3], titleColor[4] or 1)
        UI.stageSuffixText:ClearAllPoints()
        if orientation == ORIENTATION_VERTICAL then
            local anchorPoint, relativeAnchor, xOffset, yOffset = Preydator.ResolveVerticalTextAnchor(verticalTextSide, verticalTextAlign, verticalTextOffset, true)
            UI.stageSuffixText:SetPoint(anchorPoint, UI.barFrame, relativeAnchor, xOffset, yOffset)
            UI.stageSuffixText:SetJustifyH(ResolveVerticalLabelJustifyH(verticalTextSide, anchorPoint))
            UI.stageSuffixText:SetJustifyV("MIDDLE")
            ApplyVerticalLabelRotation(UI.stageSuffixText, true, verticalTextSide)
        else
            if labelRow == LABEL_ROW_BELOW then
                UI.stageSuffixText:SetPoint("TOPRIGHT", UI.barFrame, "BOTTOMRIGHT", -2, -4)
            else
                UI.stageSuffixText:SetPoint("BOTTOMRIGHT", UI.barFrame, "TOPRIGHT", -2, 4)
            end
            UI.stageSuffixText:SetJustifyH("RIGHT")
            ApplyVerticalLabelRotation(UI.stageSuffixText, false, verticalTextSide)
        end
    end

    if UI.barText then
        local _, _, flags = UI.barText:GetFont()
        local percentFont = FONT_PRESETS[settings.percentFontKey] or FONT_PRESETS.frizqt
        UI.barText:SetFont(percentFont, math.max(8, Round(((tonumber(settings.fontSize) or DEFAULTS.fontSize) - 1) * frameScale)), flags)
        local percentColor = settings.percentColor or DEFAULTS.percentColor
        UI.barText:SetTextColor(percentColor[1], percentColor[2], percentColor[3], percentColor[4] or 1)
        local percentLayer, percentSubLevel = GetPercentTextLayerSettings()
        UI.barText:SetDrawLayer(percentLayer, percentSubLevel)
    end

    local tickPercents = GetProgressTickPercents()
    for index, tickLabel in ipairs(UI.barTickLabels) do
        local hasTick = tickPercents[index] ~= nil
        if tickLabel then
            local _, _, flags = tickLabel:GetFont()
            local percentFont = FONT_PRESETS[settings.percentFontKey] or FONT_PRESETS.frizqt
            tickLabel:SetFont(percentFont, math.max(7, Round(((tonumber(settings.fontSize) or DEFAULTS.fontSize) - 4) * frameScale)), flags)
            local percentColor = settings.percentColor or DEFAULTS.percentColor
            tickLabel:SetTextColor(percentColor[1], percentColor[2], percentColor[3], 0.9)
            if orientation ~= ORIENTATION_VERTICAL then
                tickLabel:SetShown(hasTick and settings.showTicks and (
                    percentDisplayMode == PERCENT_DISPLAY_UNDER_TICKS
                    or percentDisplayMode == PERCENT_DISPLAY_ABOVE_TICKS
                ))
            end
        end

        local tickMark = UI.barTickMarks[index]
        if tickMark then
            local tickColor = settings.tickColor or DEFAULTS.tickColor
            tickMark:SetColorTexture(tickColor[1], tickColor[2], tickColor[3], tickColor[4] or 0.35)
            local tickLayer, tickSubLevel = GetTickLayerSettings()
            tickMark:SetDrawLayer(tickLayer, tickSubLevel)
            tickMark:SetShown(hasTick and settings.showTicks)
        end
    end

    local barWidth = scaledWidth
    local barHeight = scaledHeight
    if UI.barAlignmentDot then
        UI.barAlignmentDot:ClearAllPoints()
        UI.barAlignmentDot:SetPoint("CENTER", UI.barFrame, "CENTER", 0, 0)
        UI.barAlignmentDot:Hide()
    end

    local innerTickWidth = math.max(0, barWidth - (2 * FILL_INSET))
    local innerTickHeight = math.max(1, barHeight - (2 * FILL_INSET))
    local tickWidth = 1
    for index = 1, MAX_TICK_MARKS do
        local pct = tickPercents[index]
        local x = nil
        local y = nil
        if pct then
            local renderPct = (orientation == ORIENTATION_VERTICAL) and Preydator.GetRenderedVerticalPercent(pct, settings.verticalFillDirection) or pct
            if orientation == ORIENTATION_VERTICAL then
                y = FILL_INSET + math.floor((innerTickHeight * (renderPct / 100)) + 0.5)
                y = math.floor((y / tickWidth) + 0.5) * tickWidth
            else
                x = FILL_INSET + math.floor((innerTickWidth * (pct / 100)) + 0.5)
                x = math.floor((x / tickWidth) + 0.5) * tickWidth
            end
        end
        local tickMark = UI.barTickMarks[index]
        if tickMark then
            if pct then
                tickMark:ClearAllPoints()
                if orientation == ORIENTATION_VERTICAL then
                    local renderPct = Preydator.GetRenderedVerticalPercent(pct, settings.verticalFillDirection)
                    if renderPct == 100 then
                        tickMark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, barHeight - FILL_INSET - tickWidth)
                    else
                        tickMark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, y)
                    end
                    tickMark:SetSize(innerTickWidth, tickWidth)
                else
                    if pct == 100 then
                        tickMark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", barWidth - FILL_INSET - tickWidth, FILL_INSET)
                    else
                        tickMark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", x, FILL_INSET)
                    end
                    tickMark:SetSize(tickWidth, innerTickHeight)
                end
            else
                tickMark:Hide()
            end
        end

        local tickLabel = UI.barTickLabels[index]
        if tickLabel then
            if pct then
                tickLabel:ClearAllPoints()
                if orientation == ORIENTATION_VERTICAL then
                    local renderPct = Preydator.GetRenderedVerticalPercent(pct, settings.verticalFillDirection)
                    local percentEdgeOffset = verticalPercentOffset + FILL_INSET
                    local showTickPct = settings.showVerticalTickPercent == true
                        and percentDisplayMode ~= PERCENT_DISPLAY_OFF
                    if not showTickPct then
                        tickLabel:SetText("")
                        tickLabel:Hide()
                    elseif verticalPercentSide == "center" then
                        -- inside: below tick when fill up, above tick when fill down
                        if settings.verticalFillDirection == FILL_DIRECTION_DOWN then
                            tickLabel:SetPoint("BOTTOM", UI.barFrame, "BOTTOM", 0, y + 2)
                        else
                            tickLabel:SetPoint("TOP", UI.barFrame, "BOTTOM", 0, y - 2)
                        end
                    elseif renderPct == 100 then
                        if verticalPercentSide == "left" then
                            tickLabel:SetPoint("RIGHT", UI.barFrame, "BOTTOMLEFT", -percentEdgeOffset, barHeight - FILL_INSET)
                        else
                            tickLabel:SetPoint("LEFT", UI.barFrame, "BOTTOMRIGHT", percentEdgeOffset, barHeight - FILL_INSET)
                        end
                    else
                        if verticalPercentSide == "left" then
                            tickLabel:SetPoint("RIGHT", UI.barFrame, "BOTTOMLEFT", -percentEdgeOffset, y)
                        else
                            tickLabel:SetPoint("LEFT", UI.barFrame, "BOTTOMRIGHT", percentEdgeOffset, y)
                        end
                    end
                elseif percentDisplayMode == PERCENT_DISPLAY_ABOVE_TICKS then
                    if pct == 0 then
                        tickLabel:SetPoint("BOTTOMLEFT", UI.barFrame, "TOPLEFT", 0, 1)
                    elseif pct == 100 then
                        tickLabel:SetPoint("BOTTOMRIGHT", UI.barFrame, "TOPRIGHT", 0, 1)
                    else
                        tickLabel:SetPoint("BOTTOM", UI.barFrame, "BOTTOMLEFT", x, barHeight + 1)
                    end
                elseif pct == 0 then
                    tickLabel:SetPoint("TOPLEFT", UI.barFrame, "BOTTOMLEFT", 0, -1)
                elseif pct == 100 then
                    tickLabel:SetPoint("TOPRIGHT", UI.barFrame, "BOTTOMRIGHT", 0, -1)
                else
                    tickLabel:SetPoint("TOP", UI.barFrame, "BOTTOMLEFT", x, -1)
                end
                tickLabel:SetText(tostring(pct))
                tickLabel:SetDrawLayer("OVERLAY", 7)
                if orientation == ORIENTATION_VERTICAL then
                    local showTickPct = settings.showVerticalTickPercent == true
                        and percentDisplayMode ~= PERCENT_DISPLAY_OFF
                    tickLabel:SetShown(showTickPct)
                else
                    tickLabel:SetShown(settings.showTicks and (
                        percentDisplayMode == PERCENT_DISPLAY_UNDER_TICKS
                        or percentDisplayMode == PERCENT_DISPLAY_ABOVE_TICKS
                    ))
                end
            else
                tickLabel:SetText("")
                tickLabel:Hide()
            end
        end
    end

    local verticalTicksReplacePercent = orientation == ORIENTATION_VERTICAL
        and settings.showVerticalTickPercent == true
        and percentDisplayMode ~= PERCENT_DISPLAY_OFF

    if UI.barText then
        if verticalTicksReplacePercent then
            UI.barText:Hide()
        elseif percentDisplayMode == PERCENT_DISPLAY_OFF then
            UI.barText:Hide()
        elseif percentDisplayMode == PERCENT_DISPLAY_ABOVE_BAR then
            UI.barText:Show()
            UI.barText:ClearAllPoints()
            if orientation == ORIENTATION_VERTICAL then
                UI.barText:SetPoint("BOTTOM", UI.barFrame, "TOP", 0, math.max(2, verticalPercentOffset))
            else
                UI.barText:SetPoint("BOTTOM", UI.barFrame, "TOP", 0, 4)
            end
        elseif percentDisplayMode == PERCENT_DISPLAY_ABOVE_TICKS then
            UI.barText:Hide()
        elseif percentDisplayMode == PERCENT_DISPLAY_BELOW_BAR then
            UI.barText:Show()
            UI.barText:ClearAllPoints()
            if orientation == ORIENTATION_VERTICAL then
                UI.barText:SetPoint("TOP", UI.barFrame, "BOTTOM", 0, -math.max(2, verticalPercentOffset))
            else
                UI.barText:SetPoint("TOP", UI.barFrame, "BOTTOM", 0, -14)
            end
        elseif percentDisplayMode == PERCENT_DISPLAY_UNDER_TICKS then
            UI.barText:Hide()
        else
            UI.barText:Show()
            UI.barText:ClearAllPoints()
            if orientation == ORIENTATION_VERTICAL then
                UI.barText:SetPoint("CENTER", UI.barFrame, "CENTER", 0, 0)
                UI.barText:SetDrawLayer("OVERLAY", 7)
            else
                UI.barText:SetPoint("center", UI.barFrame, "center", 0, 0)
            end
        end
    end

    UI.barFrame:SetMovable(true)
end

local function EnsureBar()
    local customizationV2 = Preydator:GetModule("CustomizationStateV2")
    local barEnabled = true
    if customizationV2 and type(customizationV2.IsModuleEnabled) == "function" then
        barEnabled = customizationV2:IsModuleEnabled("bar") == true
    end
    if not barEnabled then
        if UI.barFrame then
            UI.barFrame:Hide()
        end
        return
    end

    if UI.barFrame then
        return
    end

    local createdBar = CreateFrame("Frame", "PreydatorProgressBar", UIParent)
    if not createdBar then
        return
    end

    createdBar:SetSize(260, 18)
    createdBar:SetFrameStrata("MEDIUM")
    createdBar:SetFrameLevel(5)
    do
        local defaultX, defaultY = barPositionUtil.GetDefaultPoint(260, 18)
        createdBar:SetPoint("CENTER", UIParent, "CENTER", defaultX, defaultY)
    end
    createdBar:Hide()
    createdBar:SetClampedToScreen(true)
    createdBar:RegisterForDrag("LeftButton")
    UI.barFrame = createdBar

    local function SaveBarPosition(self)
        settings.point.anchor = "CENTER"
        settings.point.relativePoint = "CENTER"

        local frameWidth = self and self.GetWidth and self:GetWidth() or 0
        local frameHeight = self and self.GetHeight and self:GetHeight() or 0

        local frameCenterX, frameCenterY = self:GetCenter()
        local parentCenterX, parentCenterY = UIParent:GetCenter()
        if frameCenterX and frameCenterY and parentCenterX and parentCenterY then
            settings.point.x, settings.point.y = barPositionUtil.ClampToScreen(frameCenterX - parentCenterX, frameCenterY - parentCenterY, frameWidth, frameHeight)
            SyncBarPointToBackup()
            self:ClearAllPoints()
            self:SetPoint("CENTER", UIParent, "CENTER", settings.point.x, settings.point.y)
            return
        end

        local _, _, _, x, y = self:GetPoint(1)
        settings.point.x, settings.point.y = barPositionUtil.ClampToScreen(x, y, frameWidth, frameHeight)
        SyncBarPointToBackup()
        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", settings.point.x, settings.point.y)
    end

    UI.barFrame:SetScript("OnMouseDown", function(self, button)
        self.PreydatorWasDragging = false
        self.PreydatorHandledMapClick = false
        self.PreydatorClickStartX = nil
        self.PreydatorClickStartY = nil
        self.PreydatorClickStartTime = nil

        if button ~= "LeftButton" then
            return
        end

        local isEditModePreview = IsEditModePreviewActive()
        local allowStageFourMapClickFallback = settings
            and settings.disableDefaultPreyIcon == true
            and state
            and state.stage == MAX_STAGE

        if allowStageFourMapClickFallback and not isEditModePreview and button == "LeftButton" then
            self.PreydatorHandledMapClick = true
            TryOpenPreyQuestOnMap()
            return
        end

        if isEditModePreview then
            self.PreydatorClickStartX, self.PreydatorClickStartY = GetCursorPosition()
            self.PreydatorClickStartTime = GetTime and GetTime() or 0
        end
    end)

    UI.barFrame:SetScript("OnDragStart", function(self)
        if settings and not settings.locked then
            self.PreydatorWasDragging = true
            self:StartMoving()
        end
    end)

    UI.barFrame:SetScript("OnDragStop", function(self)
        if not self.PreydatorWasDragging then
            return
        end

        self:StopMovingOrSizing()
        self.PreydatorWasDragging = false
        SaveBarPosition(self)
    end)

    UI.barFrame:SetScript("OnMouseUp", function(self, button)
        if self.PreydatorHandledMapClick then
            self.PreydatorHandledMapClick = false
            return
        end

        if button ~= "LeftButton" then
            return
        end

        if IsEditModePreviewActive() then
            local startX = self.PreydatorClickStartX
            local startY = self.PreydatorClickStartY
            local startTime = self.PreydatorClickStartTime or 0
            local endX, endY = GetCursorPosition()
            local now = GetTime and GetTime() or 0

            local dx = (startX and endX) and math.abs(endX - startX) or 999
            local dy = (startY and endY) and math.abs(endY - startY) or 999
            local dt = now - startTime

            if dx <= 3 and dy <= 3 and dt <= 0.20 then
                local editModeModule = Preydator.GetModule and Preydator:GetModule("EditMode")
                if editModeModule and editModeModule.ShowWindow then
                    editModeModule:ShowWindow()
                else
                    OpenOptionsPanel()
                end
            end
            return
        end

        if button == "LeftButton"
            and settings
            and settings.disableDefaultPreyIcon == true
            and state
            and state.stage == MAX_STAGE
        then
            TryOpenPreyQuestOnMap()
        end
    end)

    local bg = UI.barFrame:CreateTexture(nil, "background")
    bg:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
    bg:SetPoint("TOPRIGHT", UI.barFrame, "TOPRIGHT", -FILL_INSET, -FILL_INSET)
    bg:SetColorTexture(0, 0, 0, 0.6)
    UI.barFrame.BackgroundTexture = bg

    UI.barFill = UI.barFrame:CreateTexture(nil, "artwork")
    UI.barFill:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
    UI.barFill:SetSize(0, 18)
    UI.barFill:SetTexCoord(0, 1, 0, 1)
    UI.barFill:SetHorizTile(false)
    UI.barFill:SetVertTile(false)
    UI.barFill:SetColorTexture(0.85, 0.2, 0.2, 0.95)

    UI.barSpark = UI.barFrame:CreateTexture(nil, "overlay")
    UI.barSpark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
    UI.barSpark:SetSize(2, 18)
    UI.barSpark:SetColorTexture(1, 0.95, 0.75, 0.9)
    UI.barSpark:SetDrawLayer("OVERLAY", 3)
    UI.barSpark:Hide()

    local border = CreateFrame("Frame", nil, UI.barFrame, "BackdropTemplate")
    border:SetAllPoints()
    border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    border:SetBackdropBorderColor(0.8, 0.2, 0.2, 0.85)
    UI.barBorder = border

    UI.stageText = UI.barFrame:CreateFontString(nil, "overlay", "GameFontNormal")
    UI.stageText:SetPoint("BOTTOM", UI.barFrame, "TOP", 0, 4)
    UI.stageText:SetJustifyH("CENTER")
    UI.stageText:SetText("Preydator")

    UI.stageSuffixText = UI.barFrame:CreateFontString(nil, "overlay", "GameFontNormal")
    UI.stageSuffixText:SetPoint("BOTTOMRIGHT", UI.barFrame, "TOPRIGHT", -2, 4)
    UI.stageSuffixText:SetJustifyH("RIGHT")
    UI.stageSuffixText:SetText("")
    UI.stageSuffixText:Hide()

    UI.barText = UI.barFrame:CreateFontString(nil, "overlay", "GameFontHighlightSmall")
    UI.barText:SetPoint("center", UI.barFrame, "center", 0, 0)
    UI.barText:SetDrawLayer("OVERLAY", 9)
    UI.barText:SetText("0%")

    UI.barAlignmentDot = UI.barFrame:CreateTexture(nil, "OVERLAY")
    UI.barAlignmentDot:SetSize(6, 6)
    UI.barAlignmentDot:SetColorTexture(0, 1, 0, 1)
    UI.barAlignmentDot:SetPoint("CENTER", UI.barFrame, "CENTER", 0, 0)
    UI.barAlignmentDot:SetDrawLayer("OVERLAY", 7)
    UI.barAlignmentDot:Hide()

    for index = 1, MAX_TICK_MARKS do
        local pct = (index * 25)
        local tickMark = UI.barFrame:CreateTexture(nil, "overlay")
        tickMark:SetColorTexture(1, 1, 1, 0.35)
        tickMark:SetDrawLayer("OVERLAY", 4)
        UI.barTickMarks[index] = tickMark

        local tickLabel = UI.barFrame:CreateFontString(nil, "overlay", "GameFontHighlightSmall")
        tickLabel:SetDrawLayer("OVERLAY", 8)
        tickLabel:SetText(tostring(pct))
        UI.barTickLabels[index] = tickLabel
    end

    ApplyBarSettings()
end

local function GetStageFromState(progressState)
    if progressState == nil then
        return 1
    end

    if progressState == 0 then
        return 1
    end

    if progressState == 1 then
        return 2
    end

    if progressState == 2 then
        return 3
    end

    if progressState == PREY_PROGRESS_FINAL then
        return 4
    end

    return 1
end

local function ClampPercent(value)
    return Clamp(value, 0, 100)
end

local function NormalizePercentCandidate(value)
    if type(value) ~= "number" then
        return nil
    end

    if value >= 0 and value <= 1 then
        return ClampPercent(value * 100)
    end

    return ClampPercent(value)
end

local function ExtractProgressPercentFromInfoScan(info)
    if type(info) ~= "table" then
        return nil
    end

    for key, value in pairs(info) do
        if type(value) == "number" then
            local keyText = string.lower(tostring(key))
            if string.find(keyText, "percent", 1, true) then
                local pct = NormalizePercentCandidate(value)
                if pct ~= nil then
                    return pct
                end
            end
        end
    end

    local currentValues = {}
    local maxValues = {}
    for key, value in pairs(info) do
        if type(value) == "number" and value >= 0 then
            local keyText = string.lower(tostring(key))
            if string.find(keyText, "current", 1, true)
                or string.find(keyText, "value", 1, true)
                or string.find(keyText, "progress", 1, true)
                or string.find(keyText, "fulfilled", 1, true)
                or string.find(keyText, "completed", 1, true)
            then
                currentValues[#currentValues + 1] = value
            end

            if string.find(keyText, "max", 1, true)
                or string.find(keyText, "total", 1, true)
                or string.find(keyText, "required", 1, true)
            then
                maxValues[#maxValues + 1] = value
            end
        end
    end

    for _, current in ipairs(currentValues) do
        for _, maxValue in ipairs(maxValues) do
            if maxValue > 0 and current <= maxValue then
                local pct = ClampPercent((current / maxValue) * 100)
                if pct >= 0 and pct <= 100 then
                    return pct
                end
            end
        end
    end

    return nil
end

local function SummarizeInfoFields(info)
    if type(info) ~= "table" then
        return ""
    end

    local parts = {}
    local count = 0
    for key, value in pairs(info) do
        if key ~= "tooltip" and (type(value) == "number" or type(value) == "string" or type(value) == "boolean") then
            count = count + 1
            if count > 10 then
                parts[#parts + 1] = "..."
                break
            end
            parts[#parts + 1] = tostring(key) .. "=" .. tostring(value)
        end
    end

    return table.concat(parts, ", ")
end

local function ExtractProgressPercent(info, tooltipText)
    if type(info) == "table" then
        local directFields = {
            "progressPercentage",
            "progressPercent",
            "fillPercentage",
            "percentage",
            "percent",
            "progress",
            "progressValue",
        }

        for _, fieldName in ipairs(directFields) do
            local pct = NormalizePercentCandidate(info[fieldName])
            if pct ~= nil then
                return pct
            end
        end

        local valueFields = { "barValue", "value", "currentValue" }
        local maxFields = { "barMax", "maxValue", "totalValue", "total", "max" }
        for _, valueField in ipairs(valueFields) do
            local current = info[valueField]
            if type(current) == "number" then
                for _, maxField in ipairs(maxFields) do
                    local maxValue = info[maxField]
                    if type(maxValue) == "number" and maxValue > 0 then
                        return ClampPercent((current / maxValue) * 100)
                    end
                end
            end
        end
    end

    local scannedPct = ExtractProgressPercentFromInfoScan(info)
    if scannedPct ~= nil then
        return scannedPct
    end

    if type(tooltipText) == "string" then
        local pctText = tooltipText:match("(%d+)%s*%%")
        local pctValue = tonumber(pctText)
        if pctValue then
            return ClampPercent(pctValue)
        end
    end

    return nil
end

local function ExtractQuestObjectivePercent(questID)
    if not IsValidQuestID(questID) then
        return nil
    end

    local questBarPct = nil
    if GetQuestProgressBarPercent then
        local okQuestBarPct, rawQuestBarPct = pcall(function()
            return tonumber(GetQuestProgressBarPercent(questID))
        end)
        if not okQuestBarPct then
            rawQuestBarPct = nil
        end
        if rawQuestBarPct ~= nil then
            questBarPct = ClampPercent(rawQuestBarPct)
        end
    end

    if not (C_QuestLog and C_QuestLog.GetQuestObjectives) then
        return nil
    end

    local objectives = C_QuestLog.GetQuestObjectives(questID)
    if type(objectives) ~= "table" or #objectives == 0 then
        return nil
    end

    local totalFulfilled = 0
    local totalRequired = 0
    local anyNumericObjective = false

    for _, objective in ipairs(objectives) do
        if type(objective) == "table" then
            local okFulfilled, fulfilled = pcall(function()
                return tonumber(objective.numFulfilled)
            end)
            local okRequired, required = pcall(function()
                return tonumber(objective.numRequired)
            end)

            if not okFulfilled then
                fulfilled = nil
            end
            if not okRequired then
                required = nil
            end

            if fulfilled == nil then
                local okLegacyFulfilled, legacyFulfilled = pcall(function()
                    return tonumber(objective.fulfilled)
                end)
                if okLegacyFulfilled then
                    fulfilled = legacyFulfilled
                end
            end
            if required == nil then
                local okLegacyRequired, legacyRequired = pcall(function()
                    return tonumber(objective.required)
                end)
                if okLegacyRequired then
                    required = legacyRequired
                end
            end

            if fulfilled ~= nil and required == nil and objective.finished ~= nil then
                required = 1
                fulfilled = objective.finished and 1 or math.max(0, fulfilled)
            end

            if fulfilled and required and required > 0 then
                anyNumericObjective = true
                totalFulfilled = totalFulfilled + math.max(0, fulfilled)
                totalRequired = totalRequired + math.max(0, required)
            else
                local text = objective.text
                if type(text) == "string" and text ~= "" then
                    local curText, maxText = text:match("(%d+)%s*/%s*(%d+)")
                    local curValue = tonumber(curText)
                    local maxValue = tonumber(maxText)
                    if curValue and maxValue and maxValue > 0 then
                        anyNumericObjective = true
                        totalFulfilled = totalFulfilled + math.max(0, curValue)
                        totalRequired = totalRequired + math.max(0, maxValue)
                    else
                        local pctText = text:match("(%d+)%s*%%")
                        local pctValue = tonumber(pctText)
                        if pctValue then
                            return ClampPercent(pctValue)
                        end
                    end
                end
            end
        end
    end

    local objectivePct = nil
    if anyNumericObjective and totalRequired > 0 then
        objectivePct = ClampPercent((totalFulfilled / totalRequired) * 100)
    end

    if objectivePct ~= nil and questBarPct ~= nil then
        return math.max(objectivePct, questBarPct)
    end

    if objectivePct ~= nil then
        return objectivePct
    end

    if questBarPct ~= nil then
        return questBarPct
    end

    return nil
end

UpdateBarDisplay = function()
    local customizationV2 = Preydator:GetModule("CustomizationStateV2")
    local barEnabled = true
    if customizationV2 and type(customizationV2.IsModuleEnabled) == "function" then
        barEnabled = customizationV2:IsModuleEnabled("bar") == true
    end
    if not barEnabled then
        if UI.barFrame then
            UI.barFrame:Hide()
        end
        RunModuleHook("OnAfterUpdateBarDisplay", {
            shouldShowBar = false,
            forceAmbushAlert = false,
            forceKillStage = false,
            hasActiveQuest = false,
            displayPercent = 0,
            stage = state.stage,
        })
        return
    end

    EnsureBar()
    ApplyDefaultPreyIconVisibility()

    local now = GetTime and GetTime() or 0
    local hasActiveQuest = state.activeQuestID ~= nil
    local forceKillStage = now < (state.killStageUntil or 0)
    local forceAmbushAlert = now < (state.ambushAlertUntil or 0)
    local isOutOfPreyZone = hasActiveQuest and state.inPreyZone == false
    local onlyShowInPreyZone = settings.onlyShowInPreyZone == true
    local editModePreview = settings.showInEditMode == true and IsEditModePreviewActive()
    local isRestrictedInstance = IsRestrictedInstanceForPreyBar()
    local shouldShow = false

    if isRestrictedInstance and not editModePreview then
        shouldShow = false
    elseif state.forceShowBar or forceKillStage or forceAmbushAlert or editModePreview then
        shouldShow = true
    elseif onlyShowInPreyZone then
        shouldShow = hasActiveQuest and not isOutOfPreyZone
    else
        shouldShow = true
    end

    if not shouldShow then
        UI.barFrame:Hide()
        RunModuleHook("OnAfterUpdateBarDisplay", {
            shouldShowBar = false,
            forceAmbushAlert = forceAmbushAlert,
            forceKillStage = forceKillStage,
            hasActiveQuest = hasActiveQuest,
            displayPercent = 0,
            stage = state.stage,
        })
        return
    end

    UI.barFrame:Show()

    local stage = forceKillStage and MAX_STAGE or GetStageFromState(state.progressState)
    local pct = 0
    local displayReason = "default"
    if forceKillStage then
        pct = 100
        displayReason = "killStage"
    elseif editModePreview and not hasActiveQuest then
        pct = 0
        displayReason = "editModePreview"
    elseif not hasActiveQuest then
        pct = 0
        displayReason = "noActiveQuest"
    elseif isOutOfPreyZone then
        pct = 0
        displayReason = "outOfPreyZone"
    else
        if stage == MAX_STAGE then
            pct = 100
            if state.lastPercentSource == "none" then
                state.lastPercentSource = "final"
            end
        else
            pct = state.progressPercent
            local shouldUseStageFallback = (pct == nil) or (stage >= 1 and pct <= 0)

            if shouldUseStageFallback then
                pct = GetStageFallbackPercent(stage)
                if state.lastPercentSource == "none" then
                    state.lastPercentSource = "stage"
                end
            end
        end
        displayReason = "activeQuest"
    end
    local label = GetStageLabel(stage)
    local barWidth = (UI.barFrame and UI.barFrame.GetWidth and UI.barFrame:GetWidth()) or settings.width
    local barHeight = (UI.barFrame and UI.barFrame.GetHeight and UI.barFrame:GetHeight()) or settings.height
    local innerFillWidth = math.max(0, barWidth - 2 * FILL_INSET)
    local innerFillHeight = math.max(0, barHeight - 2 * FILL_INSET)
    local isVertical = settings.orientation == ORIENTATION_VERTICAL

    if UI.barFill then
        local width = innerFillWidth * (pct / 100)
        local height = innerFillHeight * (pct / 100)
        local shouldHideFill = (pct <= 0) or (not hasActiveQuest and not forceKillStage and not forceAmbushAlert)
        if shouldHideFill then
            UI.barFill:SetWidth(0)
            UI.barFill:SetHeight(0)
            UI.barFill:Hide()
            if UI.barSpark then
                UI.barSpark:Hide()
            end
        else
            UI.barFill:ClearAllPoints()
            if isVertical then
                UI.barFill:SetWidth(innerFillWidth)
                UI.barFill:SetHeight(math.max(1, height))
                if settings.verticalFillDirection == FILL_DIRECTION_DOWN then
                    UI.barFill:SetPoint("TOPLEFT", UI.barFrame, "TOPLEFT", FILL_INSET, -FILL_INSET)
                else
                    UI.barFill:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
                end
            else
                UI.barFill:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, FILL_INSET)
                UI.barFill:SetWidth(math.max(1, width))
                UI.barFill:SetHeight(innerFillHeight)
            end
            UI.barFill:Show()
            if UI.barSpark and settings.showSparkLine then
                local sparkWidth = 2
                UI.barSpark:ClearAllPoints()
                if isVertical then
                    local sparkY
                    if settings.verticalFillDirection == FILL_DIRECTION_DOWN then
                        sparkY = barHeight - FILL_INSET - math.max(1, height)
                    else
                        sparkY = FILL_INSET + math.max(0, height - sparkWidth)
                    end
                    if pct >= 100 and settings.verticalFillDirection == FILL_DIRECTION_DOWN then
                        sparkY = FILL_INSET
                    elseif pct >= 100 then
                        sparkY = barHeight - FILL_INSET - sparkWidth
                    end
                    UI.barSpark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", FILL_INSET, sparkY)
                else
                    local sparkX = FILL_INSET + math.max(0, width - sparkWidth)
                    if pct >= 100 then
                        sparkX = barWidth - FILL_INSET - sparkWidth
                    end
                    UI.barSpark:SetPoint("BOTTOMLEFT", UI.barFrame, "BOTTOMLEFT", sparkX, FILL_INSET)
                end
                UI.barSpark:Show()
            elseif UI.barSpark then
                UI.barSpark:Hide()
            end
        end
    end

    state.lastDisplayPct = pct
    state.lastDisplayReason = displayReason

    state.stage = stage

    local allowBarDrag = settings and not settings.locked
    local allowEditModeClickOpen = IsEditModePreviewActive()
    local allowStageFourMapClickFallback = settings
        and settings.disableDefaultPreyIcon == true
        and stage == MAX_STAGE
    if UI.barFrame and UI.barFrame.EnableMouse then
        UI.barFrame:EnableMouse((allowBarDrag and true or false) or (allowStageFourMapClickFallback and true or false) or (allowEditModeClickOpen and true or false))
    end

    local prefixText = ""
    local suffixText = ""
    if forceAmbushAlert then
        prefixText = (settings and settings.ambushPrefix) or ""
        local customAmbushText = settings and settings.ambushCustomText
        if type(customAmbushText) == "string" and customAmbushText ~= "" then
            suffixText = customAmbushText
        else
            local ambushSuffix = (settings and settings.ambushLabel) or DEFAULT_AMBUSH_LABEL
            if type(state.preyTargetName) == "string" and state.preyTargetName ~= "" then
                suffixText = ambushSuffix .. ": " .. state.preyTargetName
            else
                suffixText = ambushSuffix
            end
        end
    elseif isOutOfPreyZone and not forceKillStage then
        prefixText = (settings and settings.outOfZonePrefix) or ""
        suffixText = settings.outOfZoneLabel or DEFAULT_OUT_OF_ZONE_LABEL
    elseif editModePreview and not hasActiveQuest and not forceKillStage then
        suffixText = "Preydator (Edit Mode Preview)"
    elseif not hasActiveQuest and not forceKillStage then
        local zoneName = GetZoneText and GetZoneText() or "Unknown Zone"
        suffixText = zoneName
    else
        prefixText = (settings.stageSuffixLabels and settings.stageSuffixLabels[stage]) or ""
        suffixText = label
    end

    local verticalAlignMode = nil
    local verticalTextSide = settings.verticalTextSide or "right"
    if isVertical then
        verticalAlignMode = settings.verticalTextAlign or "separate"
        if verticalAlignMode == "top_suffix_only" or verticalAlignMode == "bottom_suffix_only" then
            prefixText = ""
        elseif verticalAlignMode == "top_prefix_only" or verticalAlignMode == "bottom_prefix_only" then
            suffixText = ""
        end
    end

    local centeredText = suffixText
    if prefixText ~= "" and suffixText ~= "" then
        centeredText = prefixText .. " " .. suffixText
    elseif prefixText ~= "" then
        centeredText = prefixText
    end

    -- Apply label mode: stageLabels = Suffix (right), stageSuffixLabels = Prefix (left)
    local lm = settings.stageLabelMode or LABEL_MODE_CENTER
    if settings.orientation == ORIENTATION_VERTICAL then
        lm = LABEL_MODE_SEPARATE
    end
    local function LabelOut(text)
        if settings.orientation == ORIENTATION_VERTICAL and not (UI.stageText and UI.stageText.SetRotation) then
            return ToVerticalText(text)
        end
        return text
    end
    if lm == LABEL_MODE_NONE then
        UI.stageText:SetText("") UI.stageText:Hide()
        if UI.stageSuffixText then UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
    elseif lm == LABEL_MODE_SEPARATE then
        local boundaryVerticalMode = isVertical
            and (verticalTextSide == "left" or verticalTextSide == "right")
            and (verticalAlignMode == "top" or verticalAlignMode == "middle" or verticalAlignMode == "bottom")
        local boundaryVerticalText = nil
        if boundaryVerticalMode then
            if prefixText ~= "" and suffixText ~= "" then
                boundaryVerticalText = centeredText
            elseif prefixText ~= "" then
                boundaryVerticalText = prefixText
            elseif suffixText ~= "" then
                boundaryVerticalText = suffixText
            end
        end

        if boundaryVerticalMode then
            if boundaryVerticalText ~= nil and boundaryVerticalText ~= "" then
                UI.stageText:SetText(LabelOut(boundaryVerticalText))
                UI.stageText:Show()
            else
                UI.stageText:SetText("")
                UI.stageText:Hide()
            end
            if UI.stageSuffixText then
                UI.stageSuffixText:SetText("")
                UI.stageSuffixText:Hide()
            end
        else
            if prefixText ~= "" then UI.stageText:SetText(LabelOut(prefixText)) UI.stageText:Show()
            else UI.stageText:SetText("") UI.stageText:Hide() end
            if UI.stageSuffixText then
                if suffixText ~= "" then UI.stageSuffixText:SetText(LabelOut(suffixText)) UI.stageSuffixText:Show()
                else UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
            end
        end
    elseif lm == LABEL_MODE_LEFT then
        if prefixText ~= "" then UI.stageText:SetText(LabelOut(prefixText)) UI.stageText:Show()
        else UI.stageText:SetText("") UI.stageText:Hide() end
        if UI.stageSuffixText then UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
    elseif lm == LABEL_MODE_LEFT_COMBINED then
        if centeredText ~= "" then UI.stageText:SetText(LabelOut(centeredText)) UI.stageText:Show()
        else UI.stageText:SetText("") UI.stageText:Hide() end
        if UI.stageSuffixText then UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
    elseif lm == LABEL_MODE_LEFT_SUFFIX then
        if suffixText ~= "" then UI.stageText:SetText(LabelOut(suffixText)) UI.stageText:Show()
        else UI.stageText:SetText("") UI.stageText:Hide() end
        if UI.stageSuffixText then UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
    elseif lm == LABEL_MODE_RIGHT then
        UI.stageText:SetText("") UI.stageText:Hide()
        if UI.stageSuffixText then
            if suffixText ~= "" then UI.stageSuffixText:SetText(LabelOut(suffixText)) UI.stageSuffixText:Show()
            else UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
        end
    elseif lm == LABEL_MODE_RIGHT_COMBINED then
        UI.stageText:SetText("") UI.stageText:Hide()
        if UI.stageSuffixText then
            if centeredText ~= "" then UI.stageSuffixText:SetText(LabelOut(centeredText)) UI.stageSuffixText:Show()
            else UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
        end
    elseif lm == LABEL_MODE_RIGHT_PREFIX then
        UI.stageText:SetText("") UI.stageText:Hide()
        if UI.stageSuffixText then
            if prefixText ~= "" then UI.stageSuffixText:SetText(LabelOut(prefixText)) UI.stageSuffixText:Show()
            else UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
        end
    else
        if centeredText ~= "" then UI.stageText:SetText(LabelOut(centeredText)) UI.stageText:Show()
        else UI.stageText:SetText("") UI.stageText:Hide() end
        if UI.stageSuffixText then UI.stageSuffixText:SetText("") UI.stageSuffixText:Hide() end
    end

    UI.barText:SetText(string.format("%d%%", pct))

    RunModuleHook("OnAfterUpdateBarDisplay", {
        shouldShowBar = true,
        forceAmbushAlert = forceAmbushAlert,
        forceKillStage = forceKillStage,
        hasActiveQuest = hasActiveQuest,
        displayPercent = pct,
        stage = stage,
    })
end

OpenOptionsPanel = function()
    local settingsModule = Preydator.GetModule and Preydator:GetModule("Settings")
    if settingsModule and settingsModule.OpenOptionsPanel then
        settingsModule:OpenOptionsPanel()
        return
    end

    EnsureOptionsPanel()

    if Settings and Settings.OpenToCategory then
        if type(UI.optionsCategoryID) == "number" then
            Settings.OpenToCategory(UI.optionsCategoryID)
            return
        end

        if UI.optionsPanel and type(UI.optionsPanel.categoryID) == "number" then
            Settings.OpenToCategory(UI.optionsPanel.categoryID)
            return
        end
    end

    if _G.InterfaceOptionsFrame_OpenToCategory then
        _G.InterfaceOptionsFrame_OpenToCategory("Preydator")
    end
end

local function ClearPreyStateAndDisplay()
    state.activeQuestID = nil
    state.progressState = nil
    state.progressPercent = 0
    state.preyZoneName = nil
    state.preyZoneMapID = nil
    state.inPreyZone = nil
    state.preyTooltipText = nil
    state.stage = 1
    state.killStageUntil = 0
    state.lastWidgetSeenAt = 0
    state.stageSoundPlayed = {}
    state.stageSoundAttempted = {}
    state.lastStateDebugSnapshot = nil
    state.preyTargetName = nil
    state.preyTargetDifficulty = nil
    state.ambushAlertUntil = 0
    state.lastAmbushSoundAt = 0
    state.lastAmbushSystemMessage = nil

    if UI.barFill then
        UI.barFill:SetWidth(0)
    end
end

local function DebugLogPreyState(origin, questID, hasWidgetData, progressState, progressPercent, inPreyZone)
    if not (debugDB and debugDB.enabled) then
        return
    end

    local snapshot = table.concat({
        tostring(origin),
        tostring(questID),
        tostring(hasWidgetData),
        tostring(progressState),
        tostring(progressPercent),
        tostring(inPreyZone),
    }, "|")

    if snapshot == state.lastStateDebugSnapshot then
        return
    end

    state.lastStateDebugSnapshot = snapshot
    AddDebugLog("PreyState", "origin=" .. tostring(origin)
        .. " | questID=" .. tostring(questID)
        .. " | widget=" .. tostring(hasWidgetData)
        .. " | state=" .. tostring(progressState)
        .. " | pct=" .. tostring(progressPercent)
        .. " | inZone=" .. tostring(inPreyZone), false)
end

local function GetCandidateWidgetSetIDs()
    for index = #UI.candidateWidgetSetIDs, 1, -1 do
        UI.candidateWidgetSetIDs[index] = nil
    end

    if C_UIWidgetManager and C_UIWidgetManager.GetTopCenterWidgetSetID then
        UI.candidateWidgetSetIDs[#UI.candidateWidgetSetIDs + 1] = C_UIWidgetManager.GetTopCenterWidgetSetID()
    end
    if C_UIWidgetManager and C_UIWidgetManager.GetObjectiveTrackerWidgetSetID then
        UI.candidateWidgetSetIDs[#UI.candidateWidgetSetIDs + 1] = C_UIWidgetManager.GetObjectiveTrackerWidgetSetID()
    end
    if C_UIWidgetManager and C_UIWidgetManager.GetBelowMinimapWidgetSetID then
        UI.candidateWidgetSetIDs[#UI.candidateWidgetSetIDs + 1] = C_UIWidgetManager.GetBelowMinimapWidgetSetID()
    end
    if C_UIWidgetManager and C_UIWidgetManager.GetPowerBarWidgetSetID then
        UI.candidateWidgetSetIDs[#UI.candidateWidgetSetIDs + 1] = C_UIWidgetManager.GetPowerBarWidgetSetID()
    end

    return UI.candidateWidgetSetIDs
end

local function IsLikelyIconName(value)
    if type(value) ~= "string" then
        return false
    end

    return string.find(string.lower(value), "icon", 1, true) ~= nil
end

local function SetRegionShown(region, shouldShow)
    if not region then
        return false
    end

    if region.SetShown then
        region:SetShown(shouldShow)
        return true
    end

    if shouldShow and region.Show then
        region:Show()
        return true
    end

    if (not shouldShow) and region.Hide then
        region:Hide()
        return true
    end

    return false
end

local function ApplyWidgetFrameSuppression(frameRef, suppress)
    if not frameRef then
        return
    end

    local visited = {}
    local function shouldHardSuppress(target)
        if not target then
            return false
        end

        local objectType = target.GetObjectType and target:GetObjectType() or nil
        if objectType == "ModelScene" or objectType == "PlayerModel" or objectType == "Model" then
            return true
        end

        local name = target.GetName and target:GetName() or ""
        local lowered = string.lower(tostring(name or ""))
        return string.find(lowered, "modelscene", 1, true) ~= nil
            or string.find(lowered, "scriptedanimation", 1, true) ~= nil
            or string.find(lowered, "anim", 1, true) ~= nil
            or string.find(lowered, "glow", 1, true) ~= nil
    end

    local function shouldNeverSuppress(target)
        if not target then
            return true
        end

        local name = target.GetName and target:GetName() or ""
        local lowered = string.lower(tostring(name or ""))
        if lowered == "" then
            return false
        end

        return string.find(lowered, "tooltip", 1, true) ~= nil
            or string.find(lowered, "moneyframe", 1, true) ~= nil
            or string.find(lowered, "lootframe", 1, true) ~= nil
            or string.find(lowered, "merchantframe", 1, true) ~= nil
    end

    local function applyHardVisibilitySuppression(target)
        if not target or not target.Hide then
            return
        end

        if not shouldHardSuppress(target) then
            return
        end

        if suppress then
            if target.PreydatorWasShown == nil and target.IsShown then
                target.PreydatorWasShown = target:IsShown() and true or false
            end
            pcall(target.Hide, target)
            return
        end

        if target.PreydatorWasShown then
            target.PreydatorWasShown = nil
            if target.Show then
                pcall(target.Show, target)
            end
        elseif target.PreydatorWasShown ~= nil then
            target.PreydatorWasShown = nil
        end
    end

    local function applyAnimationSuppression(target)
        if not target or not target.GetAnimationGroups then
            return
        end

        local okGroups, groups = pcall(function()
            return { target:GetAnimationGroups() }
        end)
        if not okGroups or type(groups) ~= "table" then
            return
        end

        for _, group in ipairs(groups) do
            if group then
                if suppress then
                    local isPlaying = false
                    if group.IsPlaying then
                        local okPlaying, playing = pcall(group.IsPlaying, group)
                        isPlaying = okPlaying and playing and true or false
                    end
                    group.PreydatorWasPlaying = isPlaying and true or false
                    if group.Stop then
                        pcall(group.Stop, group)
                    end
                elseif group.PreydatorWasPlaying then
                    group.PreydatorWasPlaying = nil
                    if group.Play then
                        pcall(group.Play, group)
                    end
                end
            end
        end
    end

    local function applyToFrameTree(node, depth)
        if not node or visited[node] or depth > 8 then
            return
        end

        if shouldNeverSuppress(node) then
            return
        end

        visited[node] = true
        applyAnimationSuppression(node)
        applyHardVisibilitySuppression(node)

        if node.SetAlpha then
            if suppress then
                if node.PreydatorOriginalAlpha == nil and node.GetAlpha then
                    node.PreydatorOriginalAlpha = node:GetAlpha()
                end
                node:SetAlpha(0)
            elseif node.PreydatorOriginalAlpha ~= nil then
                node:SetAlpha(node.PreydatorOriginalAlpha)
            end
        end

        if node.GetRegions then
            local regions = { node:GetRegions() }
            for _, region in ipairs(regions) do
                applyAnimationSuppression(region)
                applyHardVisibilitySuppression(region)
                if region and region.SetAlpha then
                    if suppress then
                        if region.PreydatorOriginalAlpha == nil and region.GetAlpha then
                            region.PreydatorOriginalAlpha = region:GetAlpha()
                        end
                        region:SetAlpha(0)
                    elseif region.PreydatorOriginalAlpha ~= nil then
                        region:SetAlpha(region.PreydatorOriginalAlpha)
                    end
                end
            end
        end

        if node.GetChildren then
            local children = { node:GetChildren() }
            for _, child in ipairs(children) do
                applyToFrameTree(child, depth + 1)
            end
        end
    end

    applyToFrameTree(frameRef, 0)

    if frameRef.EnableMouse then
        frameRef:EnableMouse(not suppress)
    end
end

local function ApplySuppressionToImmediateWidgetParent(frameRef, containerFrame, suppress)
    if not frameRef or not frameRef.GetParent then
        return
    end

    local okParent, parent = pcall(frameRef.GetParent, frameRef)
    if not okParent or not parent or parent == UIParent then
        return
    end

    local parentName = parent.GetName and parent:GetName() or ""
    local containerName = containerFrame and containerFrame.GetName and containerFrame:GetName() or ""
    local loweredParent = string.lower(tostring(parentName))
    local loweredContainer = string.lower(tostring(containerName))

    local safeParent = parent == containerFrame
        or (loweredParent ~= "" and string.find(loweredParent, "uiwidget", 1, true) ~= nil)
        or (loweredContainer ~= "" and loweredParent ~= "" and string.find(loweredParent, loweredContainer, 1, true) ~= nil)

    if safeParent then
        ApplyWidgetFrameSuppression(parent, suppress)
    end
end

local function ShouldSuppressEncounterNow()
    return settings
        and settings.disableDefaultPreyIcon == true
        and ShouldSuppressDefaultPreyEncounter()
end

local function EnsureWidgetSuppressionHook(frameRef)
    if not frameRef or frameRef.PreydatorSuppressionHooked or not frameRef.HookScript then
        return
    end

    frameRef.PreydatorSuppressionHooked = true
    frameRef:HookScript("OnShow", function(self)
        local ok = pcall(function()
            if ShouldSuppressEncounterNow() then
                ApplyWidgetFrameSuppression(self, true)
            end
        end)

        if not ok then
            -- Keep gameplay stable even if Blizzard updates widget internals.
        end
    end)
end

ShouldSuppressDefaultPreyEncounter = function()
    local hasActiveQuest = IsValidQuestID(state and state.activeQuestID)
    if not hasActiveQuest then
        return false
    end

    -- Suppress default encounter visuals whenever an active prey quest is tracked.
    -- This avoids zone-specific regressions when Blizzard changes map/widget behavior.
    return true
end

local function TryGetPreyQuestWaypoint(questID)
    if not IsValidQuestID(questID) then
        return nil, nil, nil
    end

    if C_QuestLog and C_QuestLog.GetNextWaypoint then
        local waypoint = C_QuestLog.GetNextWaypoint(questID)
        if type(waypoint) == "table" then
            local waypointMapID = tonumber(waypoint.uiMapID or waypoint.mapID)
            local waypointX = tonumber((waypoint.position and waypoint.position.x) or waypoint.x)
            local waypointY = tonumber((waypoint.position and waypoint.position.y) or waypoint.y)
            if waypointMapID and waypointX and waypointY then
                return waypointMapID, waypointX, waypointY
            end
        end
    end

    local mapCandidates = {}
    local seenMapIDs = {}

    local function addMapCandidate(mapID)
        mapID = tonumber(mapID)
        if mapID and mapID > 0 and not seenMapIDs[mapID] then
            seenMapIDs[mapID] = true
            mapCandidates[#mapCandidates + 1] = mapID
        end
    end

    addMapCandidate(state and state.preyZoneMapID)
    if C_Map and C_Map.GetBestMapForUnit then
        addMapCandidate(C_Map.GetBestMapForUnit("player"))
    end

    if C_TaskQuest and C_TaskQuest.GetQuestLocation then
        for _, mapID in ipairs(mapCandidates) do
            local x, y = C_TaskQuest.GetQuestLocation(questID, mapID)
            if x and y then
                return mapID, x, y
            end
        end
    end

    if C_QuestLog and C_QuestLog.GetQuestsOnMap then
        for _, mapID in ipairs(mapCandidates) do
            local questsOnMap = C_QuestLog.GetQuestsOnMap(mapID)
            if type(questsOnMap) == "table" then
                for _, questInfo in ipairs(questsOnMap) do
                    if questInfo and questInfo.questID == questID and questInfo.x and questInfo.y then
                        return mapID, questInfo.x, questInfo.y
                    end
                end
            end
        end
    end

    return nil, nil, nil
end

TryOpenPreyQuestOnMap = function()
    if not IsValidQuestID(state and state.activeQuestID) then
        return false
    end

    local questID = state.activeQuestID
    local superTrackedQuest = false

    if C_SuperTrack and type(C_SuperTrack.SetSuperTrackedQuestID) == "function" then
        local ok = pcall(C_SuperTrack.SetSuperTrackedQuestID, questID)
        superTrackedQuest = ok == true
    end

    if OpenQuestMap then
        pcall(OpenQuestMap)
    elseif ToggleWorldMap then
        ToggleWorldMap()
    elseif _G.WorldMapFrame and _G.WorldMapFrame.Show then
        _G.WorldMapFrame:Show()
    end

    if QuestMapFrame_OpenToQuestDetails then
        pcall(QuestMapFrame_OpenToQuestDetails, questID)
    end

    -- Prefer quest super-tracking (same behavior as clicking the default icon).
    -- Fall back to user waypoint only when quest super-track API is unavailable.
    if not superTrackedQuest then
        local mapID, x, y = TryGetPreyQuestWaypoint(questID)
        if mapID and x and y and C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
            local waypointPoint = UiMapPoint.CreateFromCoordinates(mapID, x, y)
            if waypointPoint then
                C_Map.SetUserWaypoint(waypointPoint)
                if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
                    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
                end
            end
        end
    end

    return true
end

local function TryGetWidgetFrameByID(container, widgetID)
    if type(container) ~= "table" and type(container) ~= "userdata" then
        return nil
    end

    if container.GetWidgetFrame then
        local ok, frameRef = pcall(container.GetWidgetFrame, container, widgetID)
        if ok and frameRef then
            return frameRef
        end
    end

    local possibleFrameTables = {
        container.widgetFrames,
        container.WidgetFrames,
        container.activeWidgets,
        container.ActiveWidgets,
    }

    for _, frameTable in ipairs(possibleFrameTables) do
        if type(frameTable) == "table" and frameTable[widgetID] then
            return frameTable[widgetID]
        end
    end

    return nil
end

local function AttachStageFourMapClick(frameRef)
    if not frameRef or frameRef.PreydatorStageFourClickHooked then
        return
    end

    frameRef.PreydatorStageFourClickHooked = true
    if frameRef.RegisterForDrag then
        frameRef:RegisterForDrag()
    end
    if frameRef.EnableMouse then
        frameRef:EnableMouse(true)
    end

    if frameRef.HookScript then
        frameRef:HookScript("OnMouseUp", function(_, button)
            if button ~= "LeftButton" then
                return
            end

            if settings and settings.disableDefaultPreyIcon == true then
                return
            end

            if state and state.stage == MAX_STAGE then
                TryOpenPreyQuestOnMap()
            end
        end)
    end
end

local function SetFrameIconVisible(targetFrame, shouldShow)
    if not targetFrame then
        return false
    end

    local didUpdate = false
    local visited = {}
    local iconFieldNames = {
        "Icon",
        "icon",
        "IconTexture",
        "iconTexture",
        "LeftIcon",
        "leftIcon",
        "SpellIcon",
        "spellIcon",
    }

    local function ScanFrame(frameRef, depth)
        if not frameRef or visited[frameRef] or depth > 3 then
            return
        end

        visited[frameRef] = true

        local frameName = frameRef.GetName and frameRef:GetName() or nil
        if IsLikelyIconName(frameName) and SetRegionShown(frameRef, shouldShow) then
            didUpdate = true
        end

        if frameRef.GetRegions then
            local regions = { frameRef:GetRegions() }
            for _, region in ipairs(regions) do
                local regionType = region and region.GetObjectType and region:GetObjectType() or nil
                if regionType == "Texture" then
                    local regionName = region.GetName and region:GetName() or nil
                    if IsLikelyIconName(regionName) and SetRegionShown(region, shouldShow) then
                        didUpdate = true
                    end
                end
            end
        end

        if frameRef.GetChildren then
            local children = { frameRef:GetChildren() }
            for _, child in ipairs(children) do
                ScanFrame(child, depth + 1)
            end
        end
    end

    for _, fieldName in ipairs(iconFieldNames) do
        local region = targetFrame[fieldName]
        if SetRegionShown(region, shouldShow) then
            didUpdate = true
        end
    end

    ScanFrame(targetFrame, 0)

    return didUpdate
end

local function ApplySuppressionToParentChain(frameRef, suppress, maxDepth)
    -- Emergency safety: parent-chain suppression can cascade into major UI roots.
    -- Keep this disabled unless we can guarantee strict frame whitelisting.
    return
end

local function FindGlobalFramesForWidgetID(widgetID, forceRefresh)
    local okWidgetID, numericWidgetID = pcall(function()
        return tonumber(widgetID)
    end)
    widgetID = okWidgetID and numericWidgetID or nil
    if not widgetID then
        return {}
    end

    if not forceRefresh and type(UI.targetedWidgetGlobalFrameCache[widgetID]) == "table" then
        return UI.targetedWidgetGlobalFrameCache[widgetID]
    end

    local matches = {}
    local widgetText = tostring(widgetID)
    local maxMatches = 30
    local seen = {}

    local function pushMatch(keyText, frameRef)
        if #matches >= maxMatches or not frameRef then
            return
        end

        if seen[frameRef] then
            return
        end

        seen[frameRef] = true
        local name = nil
        if frameRef.GetName then
            local okName, resolvedName = pcall(frameRef.GetName, frameRef)
            if okName then
                name = resolvedName
            end
        end

        matches[#matches + 1] = {
            key = tostring(keyText or "?"),
            name = name,
            frame = frameRef,
        }
    end

    local knownNames = {
        "UIWidgetTopCenterContainerFrameWidget" .. widgetText,
        "UIWidgetObjectiveTrackerContainerFrameWidget" .. widgetText,
        "UIWidgetBelowMinimapContainerFrameWidget" .. widgetText,
        "UIWidgetPowerBarContainerFrameWidget" .. widgetText,
    }

    for _, keyText in ipairs(knownNames) do
        local frameRef = _G[keyText]
        if frameRef then
            pushMatch(keyText, frameRef)
        end
    end

    local containerNames = {
        "UIWidgetTopCenterContainerFrame",
        "UIWidgetObjectiveTrackerContainerFrame",
        "UIWidgetBelowMinimapContainerFrame",
        "UIWidgetPowerBarContainerFrame",
    }

    local function scanContainerForWidgetID(root, rootKey)
        if not root or not root.GetChildren then
            return
        end

        local visited = {}
        local function scan(node, depth)
            if not node or visited[node] or depth > 6 or #matches >= maxMatches then
                return
            end

            visited[node] = true
            local nodeName = nil
            if node.GetName then
                local okName, resolvedName = pcall(node.GetName, node)
                if okName then
                    nodeName = resolvedName
                end
            end

            if type(nodeName) == "string" and string.find(nodeName, widgetText, 1, true) ~= nil then
                pushMatch((rootKey or "container") .. ":" .. nodeName, node)
            end

            if node.GetChildren then
                local okChildren, children = pcall(function()
                    return { node:GetChildren() }
                end)
                if okChildren and type(children) == "table" then
                    for _, child in ipairs(children) do
                        scan(child, depth + 1)
                        if #matches >= maxMatches then
                            break
                        end
                    end
                end
            end
        end

        scan(root, 0)
    end

    for _, containerKey in ipairs(containerNames) do
        local container = _G[containerKey]
        scanContainerForWidgetID(container, containerKey)
    end

    UI.targetedWidgetGlobalFrameCache[widgetID] = matches
    return matches
end

ApplyDefaultPreyIconVisibility = function()
    if not settings then
        return
    end

    if not (C_UIWidgetManager and C_UIWidgetManager.GetAllWidgetsBySetID) then
        return
    end

    local preyWidgetType = GetWidgetTypePreyHuntProgress()
    local suppressEncounter = settings.disableDefaultPreyIcon == true and ShouldSuppressDefaultPreyEncounter()

    local containerGlobals = {
        "UIWidgetTopCenterContainerFrame",
        "UIWidgetObjectiveTrackerContainerFrame",
        "UIWidgetBelowMinimapContainerFrame",
        "UIWidgetPowerBarContainerFrame",
    }

    local function ApplySuppressionToContainerFallback(container, widgetID)
        if not container or not container.GetChildren then
            return
        end

        local visited = {}
        local function scan(node, depth)
            if not node or visited[node] or depth > 6 then
                return
            end

            visited[node] = true
            local name = node.GetName and node:GetName() or ""
            local lowered = string.lower(tostring(name))
            local isWidgetName = string.find(lowered, "uiwidget", 1, true) ~= nil
            local isRelated = isWidgetName
                and (string.find(lowered, "prey", 1, true) ~= nil or string.find(lowered, "hunt", 1, true) ~= nil)

            if isRelated then
                ApplyWidgetFrameSuppression(node, suppressEncounter)
            end

            if node.GetChildren then
                local children = { node:GetChildren() }
                for _, child in ipairs(children) do
                    scan(child, depth + 1)
                end
            end
        end

        scan(container, 0)
    end

    for _, setID in ipairs(GetCandidateWidgetSetIDs()) do
        local okWidgets, widgets = pcall(C_UIWidgetManager.GetAllWidgetsBySetID, C_UIWidgetManager, setID)
        if not okWidgets or type(widgets) ~= "table" then
            okWidgets, widgets = pcall(C_UIWidgetManager.GetAllWidgetsBySetID, setID)
        end
        if type(widgets) == "table" then
            for _, widget in ipairs(widgets) do
                local okType, widgetType = pcall(function() return widget and widget.widgetType end)
                local okID, rawWidgetID = pcall(function() return widget and widget.widgetID end)
                local numericWidgetID = okID and tonumber(rawWidgetID) or nil
                if okType and widgetType == preyWidgetType and numericWidgetID then
                    for _, globalName in ipairs(containerGlobals) do
                        local container = _G[globalName]
                        local widgetFrame = TryGetWidgetFrameByID(container, numericWidgetID)
                        AttachStageFourMapClick(widgetFrame)
                        EnsureWidgetSuppressionHook(widgetFrame)
                        ApplyWidgetFrameSuppression(widgetFrame, suppressEncounter)
                        ApplySuppressionToImmediateWidgetParent(widgetFrame, container, suppressEncounter)

                        local namedFrame = _G[globalName .. "Widget" .. tostring(numericWidgetID)]
                        AttachStageFourMapClick(namedFrame)
                        EnsureWidgetSuppressionHook(namedFrame)
                        ApplyWidgetFrameSuppression(namedFrame, suppressEncounter)
                        ApplySuppressionToImmediateWidgetParent(namedFrame, container, suppressEncounter)
                        ApplySuppressionToContainerFallback(container, numericWidgetID)
                    end
                end
            end
        end
    end
end

local function FormatMemoryKB(value)
    return string.format("%.1f", value or 0)
end

local function PrintMemoryUsage()
    if not collectgarbage then
        print("Preydator: collectgarbage API unavailable.")
        return
    end

    local before = collectgarbage("count")
    collectgarbage("collect")
    local after = collectgarbage("count")
    local delta = before - after

    print("Preydator memory (KB): before=" .. FormatMemoryKB(before) .. " afterGC=" .. FormatMemoryKB(after) .. " reclaimed=" .. FormatMemoryKB(delta))
end

local function BuildStageSoundPlayedSummary()
    local parts = {}
    for stage = 1, MAX_STAGE do
        parts[#parts + 1] = tostring(stage) .. "=" .. tostring(state.stageSoundPlayed and state.stageSoundPlayed[stage] == true)
    end
    return table.concat(parts, ", ")
end

local function TrimText(value, maxLen)
    if type(value) ~= "string" then
        return ""
    end

    maxLen = tonumber(maxLen) or 80
    if #value <= maxLen then
        return value
    end

    return string.sub(value, 1, maxLen - 3) .. "..."
end

NormalizeSoundSettings = function()
    if type(settings.soundFileNames) ~= "table" then
        settings.soundFileNames = {}
    end

    local mergedNames = {}
    local seen = {}

    local function pushFileName(fileName)
        local normalized = NormalizeSoundFileName(fileName)
        if not normalized or seen[normalized] then
            return
        end
        seen[normalized] = true
        table.insert(mergedNames, normalized)
    end

    for _, defaultName in ipairs(DEFAULT_SOUND_FILENAMES) do
        pushFileName(defaultName)
    end

    for _, configuredName in ipairs(settings.soundFileNames) do
        pushFileName(configuredName)
    end

    for stage = 1, MAX_STAGE do
        local existingPath = settings.stageSounds and settings.stageSounds[stage]
        pushFileName(ExtractAddonSoundFileName(existingPath))
    end

    pushFileName(ExtractAddonSoundFileName(settings.ambushSoundPath))
    settings.soundFileNames = mergedNames

    local allowedPathLower = {}
    for _, fileName in ipairs(settings.soundFileNames) do
        local fullPath = BuildAddonSoundPath(fileName)
        if type(fullPath) == "string" and fullPath ~= "" then
            allowedPathLower[string.lower(fullPath)] = true
        end
    end

    if type(settings.stageSounds) ~= "table" then
        settings.stageSounds = {}
    end

    for stage = 1, MAX_STAGE do
        local configuredPath = settings.stageSounds[stage]
        if type(configuredPath) ~= "string" or configuredPath == "" then
            local legacyPath = settings.stageSounds[tostring(stage)]
            if type(legacyPath) == "string" and legacyPath ~= "" then
                configuredPath = legacyPath
            end
        end

        if type(configuredPath) == "string" and string.find(string.lower(configuredPath), "predator%-idle%.ogg", 1, false) then
            configuredPath = nil
        end

        if configuredPath ~= "__NONE__" then
            if type(configuredPath) ~= "string" or configuredPath == "" then
                configuredPath = GetDefaultStageSoundPath(stage)
            end

            if type(configuredPath) ~= "string" or not allowedPathLower[string.lower(configuredPath)] then
                configuredPath = GetDefaultStageSoundPath(stage)
            end
        end

        settings.stageSounds[stage] = configuredPath
    end

    if settings.ambushSoundPath ~= "__NONE__"
        and (type(settings.ambushSoundPath) ~= "string" or not allowedPathLower[string.lower(settings.ambushSoundPath)])
    then
        settings.ambushSoundPath = KILL_SOUND_PATH
    end

    settings.stageSounds[5] = nil
end

local function ResetAllSettings()
    for key in pairs(settings) do
        settings[key] = nil
    end

    ApplyDefaults(settings, DEFAULTS)
    NormalizeLabelSettings()
    NormalizeColorSettings()
    NormalizeDisplaySettings()
    NormalizeProgressSettings()
    NormalizeAmbushSettings()
    NormalizeSoundSettings()

    state.forceShowBar = settings.forceShowBar
    state.stageSoundPlayed = {}
    state.stageSoundAttempted = {}

    ApplyBarSettings()
    UpdateBarDisplay()

    if UI.optionsPanel and UI.optionsPanel.PreydatorRefreshControls then
        UI.optionsPanel.PreydatorRefreshControls()
    end
end

local function FrameHasScriptSafe(frameRef, scriptName)
    if not frameRef or type(scriptName) ~= "string" or not frameRef.HasScript then
        return false
    end

    local ok, hasScript = pcall(frameRef.HasScript, frameRef, scriptName)
    if not ok then
        return false
    end

    return hasScript and true or false
end

local function CollectVisualHintNames(frameRef, maxHints)
    if not frameRef then
        return ""
    end

    maxHints = tonumber(maxHints) or 8
    local hints = {}
    local seenHints = {}
    local visited = {}

    local function maybeAddName(name)
        if type(name) ~= "string" or name == "" then
            return
        end

        local lowered = string.lower(name)
        if string.find(lowered, "anim", 1, true)
            or string.find(lowered, "glow", 1, true)
            or string.find(lowered, "pulse", 1, true)
            or string.find(lowered, "spark", 1, true)
            or string.find(lowered, "flare", 1, true)
            or string.find(lowered, "shine", 1, true)
        then
            if not seenHints[name] then
                seenHints[name] = true
                hints[#hints + 1] = name
            end
        end
    end

    local function scan(node, depth)
        if not node or visited[node] or depth > 4 or #hints >= maxHints then
            return
        end

        visited[node] = true
        if node.GetName then
            maybeAddName(node:GetName())
        end

        if node.GetRegions then
            local regions = { node:GetRegions() }
            for _, region in ipairs(regions) do
                if region and region.GetName then
                    maybeAddName(region:GetName())
                    if #hints >= maxHints then
                        return
                    end
                end
            end
        end

        if node.GetChildren then
            local children = { node:GetChildren() }
            for _, child in ipairs(children) do
                scan(child, depth + 1)
                if #hints >= maxHints then
                    return
                end
            end
        end
    end

    scan(frameRef, 0)
    return table.concat(hints, ", ")
end

local function CollectFramesNearPoint(pointX, pointY, radius, maxMatches)
    local entries = {}
    local scanned = 0

    if type(pointX) ~= "number" or type(pointY) ~= "number" or type(EnumerateFrames) ~= "function" then
        return entries, scanned
    end

    radius = math.max(1, tonumber(radius) or 80)
    maxMatches = math.max(1, tonumber(maxMatches) or 20)
    local limit = 4000
    local frameRef = EnumerateFrames()

    while frameRef and scanned < limit and #entries < maxMatches do
        scanned = scanned + 1

        local isShown = false
        if frameRef.IsShown then
            local okShown, shownValue = pcall(frameRef.IsShown, frameRef)
            isShown = okShown and shownValue and true or false
        end

        if isShown then
            local left, right, top, bottom = nil, nil, nil, nil
            if frameRef.GetRect then
                local okRect, l, b, w, h = pcall(frameRef.GetRect, frameRef)
                if okRect and l and b and w and h then
                    left = l
                    right = l + w
                    bottom = b
                    top = b + h
                end
            end

            local overlapsProbe = false
            if left and right and top and bottom then
                overlapsProbe = (right >= (pointX - radius))
                    and (left <= (pointX + radius))
                    and (top >= (pointY - radius))
                    and (bottom <= (pointY + radius))
            end

            if overlapsProbe then
                local name = "<unnamed>"
                if frameRef.GetName then
                    local okName, resolvedName = pcall(frameRef.GetName, frameRef)
                    if okName and type(resolvedName) == "string" and resolvedName ~= "" then
                        name = resolvedName
                    end
                end

                local centerX, centerY = nil, nil
                if frameRef.GetCenter then
                    local okCenter, cx, cy = pcall(frameRef.GetCenter, frameRef)
                    if okCenter then
                        centerX = cx
                        centerY = cy
                    end
                end

                local dx = (type(centerX) == "number") and (centerX - pointX) or nil
                local dy = (type(centerY) == "number") and (centerY - pointY) or nil

                local strata = "?"
                if frameRef.GetFrameStrata then
                    local okStrata, strataValue = pcall(frameRef.GetFrameStrata, frameRef)
                    if okStrata and strataValue ~= nil then
                        strata = tostring(strataValue)
                    end
                end

                local level = "?"
                if frameRef.GetFrameLevel then
                    local okLevel, levelValue = pcall(frameRef.GetFrameLevel, frameRef)
                    if okLevel and levelValue ~= nil then
                        level = tostring(levelValue)
                    end
                end

                local alpha = "?"
                if frameRef.GetAlpha then
                    local okAlpha, alphaValue = pcall(frameRef.GetAlpha, frameRef)
                    if okAlpha and alphaValue ~= nil then
                        alpha = tostring(alphaValue)
                    end
                end

                local mouseEnabled = false
                if frameRef.IsMouseEnabled then
                    local okMouse, mouseValue = pcall(frameRef.IsMouseEnabled, frameRef)
                    mouseEnabled = okMouse and mouseValue and true or false
                end

                local movable = false
                if frameRef.IsMovable then
                    local okMovable, movableValue = pcall(frameRef.IsMovable, frameRef)
                    movable = okMovable and movableValue and true or false
                end

                entries[#entries + 1] = {
                    name = name,
                    strata = strata,
                    level = level,
                    alpha = alpha,
                    mouse = mouseEnabled,
                    movable = movable,
                    dx = dx,
                    dy = dy,
                }
            end
        end

        frameRef = EnumerateFrames(frameRef)
    end

    table.sort(entries, function(a, b)
        local adx = type(a.dx) == "number" and math.abs(a.dx) or 999999
        local ady = type(a.dy) == "number" and math.abs(a.dy) or 999999
        local bdx = type(b.dx) == "number" and math.abs(b.dx) or 999999
        local bdy = type(b.dy) == "number" and math.abs(b.dy) or 999999
        return (adx + ady) < (bdx + bdy)
    end)

    return entries, scanned
end

local function CollectWidgetTreeSnapshot(rootFrame, maxEntries)
    local rows = {}
    if not rootFrame then
        return rows
    end

    maxEntries = math.max(1, tonumber(maxEntries) or 18)
    local visited = {}

    local function safeGetName(node)
        if node and node.GetName then
            local ok, value = pcall(node.GetName, node)
            if ok and type(value) == "string" and value ~= "" then
                return value
            end
        end
        return "<unnamed>"
    end

    local function safeGetObjectType(node)
        if node and node.GetObjectType then
            local ok, value = pcall(node.GetObjectType, node)
            if ok and value then
                return tostring(value)
            end
        end
        return "?"
    end

    local function safeGetAlpha(node)
        if node and node.GetAlpha then
            local ok, value = pcall(node.GetAlpha, node)
            if ok and value ~= nil then
                return tostring(value)
            end
        end
        return "?"
    end

    local function safeIsShown(node)
        if node and node.IsShown then
            local ok, value = pcall(node.IsShown, node)
            return ok and value and true or false
        end
        return false
    end

    local function animSummary(node)
        if not node or not node.GetAnimationGroups then
            return "none"
        end

        local ok, groups = pcall(function()
            return { node:GetAnimationGroups() }
        end)
        if not ok or type(groups) ~= "table" or #groups == 0 then
            return "none"
        end

        local playing = 0
        for _, group in ipairs(groups) do
            if group and group.IsPlaying then
                local okPlaying, isPlaying = pcall(group.IsPlaying, group)
                if okPlaying and isPlaying then
                    playing = playing + 1
                end
            end
        end

        return tostring(#groups) .. " groups, playing=" .. tostring(playing)
    end

    local function scan(node, depth)
        if not node or visited[node] or #rows >= maxEntries or depth > 5 then
            return
        end

        visited[node] = true
        local name = safeGetName(node)
        local objectType = safeGetObjectType(node)
        local lowered = string.lower(name)
        local isInteresting = depth <= 1
            or string.find(lowered, "anim", 1, true) ~= nil
            or string.find(lowered, "glow", 1, true) ~= nil
            or string.find(lowered, "model", 1, true) ~= nil
            or objectType == "ModelScene"
            or objectType == "Model"
            or objectType == "PlayerModel"

        if isInteresting then
            rows[#rows + 1] = string.format(
                "depth=%d name=%s type=%s shown=%s alpha=%s anim=%s",
                depth,
                name,
                objectType,
                tostring(safeIsShown(node)),
                safeGetAlpha(node),
                animSummary(node)
            )
        end

        if node.GetRegions and #rows < maxEntries then
            local okRegions, regions = pcall(function()
                return { node:GetRegions() }
            end)
            if okRegions and type(regions) == "table" then
                for _, region in ipairs(regions) do
                    if #rows >= maxEntries then
                        break
                    end
                    scan(region, depth + 1)
                end
            end
        end

        if node.GetChildren and #rows < maxEntries then
            local okChildren, children = pcall(function()
                return { node:GetChildren() }
            end)
            if okChildren and type(children) == "table" then
                for _, child in ipairs(children) do
                    if #rows >= maxEntries then
                        break
                    end
                    scan(child, depth + 1)
                end
            end
        end
    end

    scan(rootFrame, 0)
    return rows
end

local function SendInspectReportToErrorHandler(reportText)
    -- Legacy inspect path is intentionally disabled while we validate module-only diagnostics.
    if true then
        return false, "legacy inspect reporter disabled"
    end

    local function SafeToString(value)
        local ok, converted = pcall(tostring, value)
        if ok then
            return converted
        end

        return "<tostring failed>"
    end

    if type(reportText) ~= "string" or reportText == "" then
        return false, "empty report"
    end

    if type(geterrorhandler) ~= "function" then
        return false, "geterrorhandler unavailable"
    end

    local okGetHandler, handler = pcall(geterrorhandler)
    if not okGetHandler or handler == nil then
        return false, "error handler unavailable"
    end

    local header = "Preydator Inspect Report"
    local chunkSize = 1800
    local length = #reportText
    local chunks = math.max(1, math.ceil(length / chunkSize))
    for index = 1, chunks do
        local startPos = ((index - 1) * chunkSize) + 1
        local endPos = math.min(index * chunkSize, length)
        local chunk = string.sub(reportText, startPos, endPos)
        local payload = string.format("%s [%d/%d]\n%s", header, index, chunks, chunk)

        local okSend, sendErr = pcall(function()
            handler(payload)
        end)

        if not okSend then
            return false, "handler failed on chunk " .. SafeToString(index) .. ": " .. SafeToString(sendErr)
        end
    end

    return true, "sent"
end

local function PrintInspectState(outputMode)
    -- Keep this function in place for compatibility, but route users to module inspect.
    if true then
        print("Preydator: Legacy inspect path is disabled. Use '/pd inspect' from DebugInspect.")
        return
    end

    outputMode = string.lower(tostring(outputMode or "chat"))
    EnsureBar()
    UpdateBarDisplay()

    local lines = {}
    local function add(line)
        lines[#lines + 1] = tostring(line or "")
    end

    local now = GetTime and GetTime() or 0
    local liveQuestID = GetCurrentActivePreyQuest()
    local hasActiveQuest = IsValidQuestID(liveQuestID)
    local questOnLog = IsQuestStillActive(liveQuestID)
    local questCompleted = false
    if hasActiveQuest and C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        questCompleted = C_QuestLog.IsQuestFlaggedCompleted(liveQuestID) and true or false
    end

    local playerMapID = (C_Map and C_Map.GetBestMapForUnit) and C_Map.GetBestMapForUnit("player") or nil
    local playerMapName = nil
    if playerMapID and C_Map and C_Map.GetMapInfo then
        local mapInfo = C_Map.GetMapInfo(playerMapID)
        playerMapName = mapInfo and mapInfo.name or nil
    end

    local shownWidgets = 0
    local objectivePct = ExtractQuestObjectivePercent(liveQuestID)
    local objectives = (hasActiveQuest and C_QuestLog and C_QuestLog.GetQuestObjectives) and C_QuestLog.GetQuestObjectives(liveQuestID) or nil
    local preyWidgetType = GetWidgetTypePreyHuntProgress()
    local shownStateShown = GetShownStateShown()
    local suppressEncounter = settings and settings.disableDefaultPreyIcon == true and ShouldSuppressDefaultPreyEncounter()
    local inspectSuppressionStage = GetStageFromState(state and state.progressState)
    local allowStageFourMapClickFallback = settings
        and settings.disableDefaultPreyIcon == true
        and state
        and state.stage == MAX_STAGE
    local barMouseEnabled = UI.barFrame and UI.barFrame.IsMouseEnabled and UI.barFrame:IsMouseEnabled() or false
    local waypointMapID, waypointX, waypointY = TryGetPreyQuestWaypoint(liveQuestID)
    local canResolveWaypoint = waypointMapID and waypointX and waypointY

    add("Preydator Inspect (" .. INSPECT_VERSION .. ") | addon=" .. tostring((C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata("Preydator", "Version")) or "?"))
    add("- time=" .. string.format("%.3f", now) .. " | zone=" .. tostring(GetZoneText and GetZoneText() or "?") .. " | playerMapID=" .. tostring(playerMapID) .. " | playerMap=" .. tostring(playerMapName))
    add("- quest live=" .. tostring(liveQuestID) .. " | hasActive=" .. tostring(hasActiveQuest) .. " | isOnQuest=" .. tostring(questOnLog) .. " | completed=" .. tostring(questCompleted))
    add("- quest tracked=" .. tostring(state.activeQuestID) .. " | progressState=" .. tostring(state.progressState) .. " | progressPercent=" .. tostring(state.progressPercent) .. " | stage=" .. tostring(state.stage) .. " (" .. tostring(GetStageLabel(state.stage)) .. ")")
    add("- prey target=" .. tostring(state.preyTargetName) .. " | difficulty=" .. tostring(state.preyTargetDifficulty) .. " | ambushAlertRemaining=" .. string.format("%.2f", math.max(0, (state.ambushAlertUntil or 0) - now)))
    add("- preyZone mapID=" .. tostring(state.preyZoneMapID) .. " | preyZoneName=" .. tostring(state.preyZoneName) .. " | inPreyZone=" .. tostring(state.inPreyZone))
    add("- killStageRemaining=" .. string.format("%.2f", math.max(0, (state.killStageUntil or 0) - now)) .. " | lastWidgetAge=" .. string.format("%.2f", math.max(0, now - (state.lastWidgetSeenAt or 0))))
    add("- sounds enabled=" .. tostring(settings and settings.soundsEnabled) .. " | channel=" .. tostring(settings and settings.soundChannel) .. " | stagePlayed={" .. BuildStageSoundPlayedSummary() .. "}")
    add("- percent source=" .. tostring(state.lastPercentSource) .. " | fallbackMode=" .. tostring(settings and settings.percentFallbackMode) .. " | objectivePct=" .. tostring(objectivePct))
    add("- map waypoint found=" .. tostring(canResolveWaypoint and true or false)
        .. " | mapID=" .. tostring(waypointMapID)
        .. " | x=" .. tostring(waypointX)
        .. " | y=" .. tostring(waypointY))
    if type(objectives) == "table" and #objectives > 0 then
        local shown = 0
        for index, objective in ipairs(objectives) do
            if type(objective) == "table" then
                shown = shown + 1
                if shown > 4 then
                    add("  objective ... (" .. tostring(#objectives - 4) .. " more)")
                    break
                end

                add("  objective " .. tostring(index)
                    .. " fulfilled=" .. tostring(objective.numFulfilled or objective.fulfilled)
                    .. " required=" .. tostring(objective.numRequired or objective.required)
                    .. " finished=" .. tostring(objective.finished)
                    .. " text='" .. TrimText(objective.text, 80) .. "'")
            end
        end
    else
        add("  objective none")
    end
    add("- bar shown=" .. tostring(UI.barFrame and UI.barFrame:IsShown() or false)
        .. " | forceShow=" .. tostring(state.forceShowBar)
        .. " | onlyShowInPreyZone=" .. tostring(settings and settings.onlyShowInPreyZone))
    add("- icon hide setting=" .. tostring(settings and settings.disableDefaultPreyIcon)
        .. " | suppressEncounterNow=" .. tostring(suppressEncounter)
        .. " | suppressStage=" .. tostring(inspectSuppressionStage)
        .. " | suppressInZone=" .. tostring(state and state.inPreyZone == true)
        .. " | stage4MapFallback=" .. tostring(allowStageFourMapClickFallback)
        .. " | barMouseEnabled=" .. tostring(barMouseEnabled))
    add("- bar scripts onMouseDown=" .. tostring(FrameHasScriptSafe(UI.barFrame, "OnMouseDown"))
        .. " | onMouseUp=" .. tostring(FrameHasScriptSafe(UI.barFrame, "OnMouseUp")))
    add("- map APIs openQuestMap=" .. tostring(OpenQuestMap ~= nil)
        .. " | toggleWorldMap=" .. tostring(ToggleWorldMap ~= nil)
        .. " | openQuestDetails=" .. tostring(QuestMapFrame_OpenToQuestDetails ~= nil)
        .. " | setUserWaypoint=" .. tostring(C_Map and C_Map.SetUserWaypoint ~= nil)
        .. " | superTrack=" .. tostring(C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint ~= nil))
    local frameWidth = UI.barFrame and UI.barFrame:GetWidth() or 0
    local fillWidth = UI.barFill and UI.barFill:GetWidth() or 0
    local fillPct = 0
    if frameWidth and frameWidth > 0 then
        fillPct = (fillWidth / frameWidth) * 100
    end
    add("- display pct=" .. tostring(state.lastDisplayPct) .. " | reason=" .. tostring(state.lastDisplayReason)
        .. " | frameWidth=" .. string.format("%.2f", frameWidth)
        .. " | fillWidth=" .. string.format("%.2f", fillWidth)
        .. " | fillPct=" .. string.format("%.2f", fillPct))

    local savedPoint = settings and settings.point or {}
    add("- point saved="
        .. " anchor=" .. tostring(savedPoint.anchor)
        .. " rel=" .. tostring(savedPoint.relativePoint)
        .. " x=" .. tostring(savedPoint.x)
        .. " y=" .. tostring(savedPoint.y))

    local livePoint, liveRelativeTo, liveRelativePoint, liveX, liveY = nil, nil, nil, nil, nil
    if UI.barFrame and UI.barFrame.GetPoint then
        livePoint, liveRelativeTo, liveRelativePoint, liveX, liveY = UI.barFrame:GetPoint(1)
    end
    local liveRelativeName = "nil"
    if liveRelativeTo == UIParent then
        liveRelativeName = "UIParent"
    elseif liveRelativeTo ~= nil then
        liveRelativeName = tostring(liveRelativeTo)
    end
    add("- point live="
        .. " anchor=" .. tostring(livePoint)
        .. " relTo=" .. tostring(liveRelativeName)
        .. " rel=" .. tostring(liveRelativePoint)
        .. " x=" .. tostring(liveX)
        .. " y=" .. tostring(liveY))

    local frameScale = UI.barFrame and UI.barFrame.GetScale and UI.barFrame:GetScale() or 1
    local frameEffectiveScale = UI.barFrame and UI.barFrame.GetEffectiveScale and UI.barFrame:GetEffectiveScale() or 1
    local frameCenterX = UI.barFrame and UI.barFrame.GetCenter and select(1, UI.barFrame:GetCenter()) or nil
    local frameCenterY = UI.barFrame and UI.barFrame.GetCenter and select(2, UI.barFrame:GetCenter()) or nil
    local parentCenterX = UIParent and UIParent.GetCenter and select(1, UIParent:GetCenter()) or nil
    local parentCenterY = UIParent and UIParent.GetCenter and select(2, UIParent:GetCenter()) or nil
    local centerDX = (frameCenterX and parentCenterX) and (frameCenterX - parentCenterX) or nil
    local centerDY = (frameCenterY and parentCenterY) and (frameCenterY - parentCenterY) or nil
    add("- frame scale=" .. tostring(frameScale)
        .. " | effectiveScale=" .. tostring(frameEffectiveScale)
        .. " | centerDX=" .. tostring(centerDX)
        .. " | centerDY=" .. tostring(centerDY))

    local probePointX = frameCenterX
    local probePointY = frameCenterY
    if type(probePointX) ~= "number" and type(parentCenterX) == "number" and type(savedPoint.x) == "number" then
        probePointX = parentCenterX + savedPoint.x
    end
    if type(probePointY) ~= "number" and type(parentCenterY) == "number" and type(savedPoint.y) == "number" then
        probePointY = parentCenterY + savedPoint.y
    end

    local nearbyFrames, nearbyScanned = CollectFramesNearPoint(probePointX, probePointY, 80, 18)
    add("- nearby frame probe="
        .. " x=" .. tostring(probePointX)
        .. " y=" .. tostring(probePointY)
        .. " radius=80"
        .. " | scanned=" .. tostring(nearbyScanned)
        .. " | matched=" .. tostring(#nearbyFrames))
    for index, entry in ipairs(nearbyFrames) do
        add("  nearby " .. tostring(index)
            .. " name=" .. tostring(entry.name)
            .. " strata=" .. tostring(entry.strata)
            .. " level=" .. tostring(entry.level)
            .. " alpha=" .. tostring(entry.alpha)
            .. " mouse=" .. tostring(entry.mouse)
            .. " movable=" .. tostring(entry.movable)
            .. " dx=" .. tostring(entry.dx)
            .. " dy=" .. tostring(entry.dy))
    end

    add("- frame local=" .. tostring(UI.barFrame) .. " | frame global=" .. tostring(_G.PreydatorProgressBar)
        .. " | same=" .. tostring(UI.barFrame ~= nil and _G.PreydatorProgressBar ~= nil and UI.barFrame == _G.PreydatorProgressBar))

    if C_UIWidgetManager and C_UIWidgetManager.GetAllWidgetsBySetID and C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo then
        for _, setID in ipairs(GetCandidateWidgetSetIDs()) do
            local okWidgets, widgets = pcall(C_UIWidgetManager.GetAllWidgetsBySetID, C_UIWidgetManager, setID)
            if not okWidgets or type(widgets) ~= "table" then
                okWidgets, widgets = pcall(C_UIWidgetManager.GetAllWidgetsBySetID, setID)
            end
            if type(widgets) == "table" and #widgets > 0 then
                for _, widget in ipairs(widgets) do
                    local okType, widgetType = pcall(function() return widget and widget.widgetType end)
                    local okRawID, rawWidgetID = pcall(function() return widget and widget.widgetID end)
                    local numericWidgetID = okRawID and tonumber(rawWidgetID) or nil
                    if okType and widgetType == preyWidgetType and numericWidgetID then
                        local okInfo, info = pcall(C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo, numericWidgetID)
                        if okInfo and info and info.shownState == shownStateShown then
                            shownWidgets = shownWidgets + 1
                            local pct = ExtractProgressPercent(info, info.tooltip)
                            local widgetQuestID = ExtractWidgetQuestID(info)
                            local frameStateParts = {}
                            local resolvedContainerParts = {}
                            local framePrefixes = {
                                "UIWidgetTopCenterContainerFrameWidget",
                                "UIWidgetObjectiveTrackerContainerFrameWidget",
                                "UIWidgetBelowMinimapContainerFrameWidget",
                                "UIWidgetPowerBarContainerFrameWidget",
                            }
                            for _, prefix in ipairs(framePrefixes) do
                                local frameName = prefix .. tostring(numericWidgetID)
                                local frameRef = _G[frameName]
                                if frameRef then
                                    frameStateParts[#frameStateParts + 1] = frameName
                                        .. "(shown=" .. tostring(frameRef.IsShown and frameRef:IsShown() or false)
                                        .. ",alpha=" .. tostring(frameRef.GetAlpha and frameRef:GetAlpha() or "?")
                                        .. ",mouse=" .. tostring(frameRef.IsMouseEnabled and frameRef:IsMouseEnabled() or false)
                                        .. ",onMouseUp=" .. tostring(FrameHasScriptSafe(frameRef, "OnMouseUp"))
                                        .. ",drag=" .. tostring(frameRef.IsMovable and frameRef:IsMovable() or false)
                                        .. ")"
                                end
                            end

                            local containerNames = {
                                "UIWidgetTopCenterContainerFrame",
                                "UIWidgetObjectiveTrackerContainerFrame",
                                "UIWidgetBelowMinimapContainerFrame",
                                "UIWidgetPowerBarContainerFrame",
                            }
                            for _, containerName in ipairs(containerNames) do
                                local container = _G[containerName]
                                local resolvedFrame = TryGetWidgetFrameByID(container, numericWidgetID)
                                if resolvedFrame then
                                    local resolvedName = resolvedFrame.GetName and resolvedFrame:GetName() or "<unnamed>"
                                    local parentName = "<nil>"
                                    if resolvedFrame.GetParent then
                                        local okParent, parent = pcall(resolvedFrame.GetParent, resolvedFrame)
                                        if okParent and parent then
                                            parentName = parent.GetName and (parent:GetName() or "<unnamed>") or tostring(parent)
                                        end
                                    end
                                    resolvedContainerParts[#resolvedContainerParts + 1] = containerName
                                        .. "=>name=" .. tostring(resolvedName)
                                        .. ",shown=" .. tostring(resolvedFrame.IsShown and resolvedFrame:IsShown() or false)
                                        .. ",alpha=" .. tostring(resolvedFrame.GetAlpha and resolvedFrame:GetAlpha() or "?")
                                        .. ",parent=" .. tostring(parentName)
                                end
                            end
                            add("  widget set=" .. tostring(setID) .. " widgetID=" .. tostring(numericWidgetID)
                                .. " questID=" .. tostring(widgetQuestID)
                                .. " state=" .. tostring(info.progressState)
                                .. " pct=" .. tostring(pct)
                                .. " tooltip='" .. TrimText(info.tooltip, 90) .. "'")
                            add("    fields: " .. TrimText(SummarizeInfoFields(info), 200))
                            if #frameStateParts > 0 then
                                add("    frames: " .. table.concat(frameStateParts, " | "))
                            end
                            if #resolvedContainerParts > 0 then
                                add("    resolvedContainerFrames: " .. table.concat(resolvedContainerParts, " | "))
                            else
                                add("    resolvedContainerFrames: none")
                            end

                            local firstPrefix = "UIWidgetTopCenterContainerFrameWidget" .. tostring(numericWidgetID)
                            local firstFrameRef = _G[firstPrefix]
                            if not firstFrameRef then
                                firstPrefix = "UIWidgetObjectiveTrackerContainerFrameWidget" .. tostring(numericWidgetID)
                                firstFrameRef = _G[firstPrefix]
                            end
                            if not firstFrameRef then
                                firstPrefix = "UIWidgetBelowMinimapContainerFrameWidget" .. tostring(numericWidgetID)
                                firstFrameRef = _G[firstPrefix]
                            end
                            if not firstFrameRef then
                                firstPrefix = "UIWidgetPowerBarContainerFrameWidget" .. tostring(numericWidgetID)
                                firstFrameRef = _G[firstPrefix]
                            end

                            if firstFrameRef then
                                local visualHints = CollectVisualHintNames(firstFrameRef, 8)
                                if visualHints ~= "" then
                                    add("    visualHints: " .. visualHints)
                                end

                                local treeSnapshot = CollectWidgetTreeSnapshot(firstFrameRef, 20)
                                if #treeSnapshot > 0 then
                                    add("    treeSnapshot=" .. tostring(#treeSnapshot) .. " entries")
                                    for _, row in ipairs(treeSnapshot) do
                                        add("      " .. row)
                                    end
                                end
                            end

                            local globalMatches = FindGlobalFramesForWidgetID(numericWidgetID, true)
                            if #globalMatches > 0 then
                                local maxPrint = math.min(#globalMatches, 10)
                                add("    globalWidgetFrames=" .. tostring(#globalMatches) .. " (showing " .. tostring(maxPrint) .. ")")
                                for i = 1, maxPrint do
                                    local entry = globalMatches[i]
                                    local frameName = (entry and entry.name) or "<unnamed>"
                                    local globalKey = (entry and entry.key) or "?"
                                    add("      match " .. tostring(i) .. " key=" .. tostring(globalKey) .. " name=" .. tostring(frameName))
                                end
                            else
                                add("    globalWidgetFrames=0")
                            end
                        end
                    end
                end
            end
        end
    end

    if shownWidgets == 0 then
        add("  widget none shown")
    end

    local reportText = table.concat(lines, "\n")
    Preydator.lastInspectReport = reportText
    _G.PreydatorLastInspectReport = reportText

    if outputMode == "chat" or outputMode == "both" then
        for _, line in ipairs(lines) do
            print(line)
        end
    end

    if outputMode == "bugsack" or outputMode == "both" then
        local sent, reason = SendInspectReportToErrorHandler(reportText)
        if sent then
            print("Preydator: Inspect report sent to BugSack via error handler. This is intentional diagnostic output, not a runtime addon bug.")
        else
            print("Preydator: Could not send inspect report to BugSack: " .. tostring(reason))
        end
    end

    print("Preydator: Inspect report cached in PreydatorLastInspectReport (" .. tostring(#lines) .. " lines).")
end

ExtractWidgetQuestID = function(info)
    if type(info) ~= "table" then
        return nil
    end

    local possibleFields = {
        "questID",
        "questId",
        "associatedQuestID",
        "associatedQuestId",
    }

    for _, fieldName in ipairs(possibleFields) do
        local value = info[fieldName]
        if type(value) == "number" and value > 0 then
            return value
        end
    end

    return nil
end

local function FindPreyWidgetProgressState(activeQuestID)
    if not (C_UIWidgetManager and C_UIWidgetManager.GetAllWidgetsBySetID and C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo) then
        return nil
    end

    local preyWidgetType = GetWidgetTypePreyHuntProgress()
    local shownStateShown = GetShownStateShown()
    local fallbackState, fallbackTooltip, fallbackPct = nil, nil, nil

    for _, setID in ipairs(GetCandidateWidgetSetIDs()) do
        local okWidgets, widgets = pcall(C_UIWidgetManager.GetAllWidgetsBySetID, C_UIWidgetManager, setID)
        if not okWidgets or type(widgets) ~= "table" then
            okWidgets, widgets = pcall(C_UIWidgetManager.GetAllWidgetsBySetID, setID)
        end
        if type(widgets) == "table" then
            for _, widget in ipairs(widgets) do
                local okType, widgetType = pcall(function() return widget and widget.widgetType end)
                local okID, rawWidgetID = pcall(function() return widget and widget.widgetID end)
                local numericWidgetID = okID and tonumber(rawWidgetID) or nil
                if okType and widgetType == preyWidgetType and numericWidgetID then
                    local okInfo, info = pcall(C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo, numericWidgetID)
                    if okInfo and info and info.shownState == shownStateShown then
                        local pct = ExtractProgressPercent(info, info.tooltip)
                        if IsValidQuestID(activeQuestID) then
                            local widgetQuestID = ExtractWidgetQuestID(info)
                            if widgetQuestID == activeQuestID then
                                return info.progressState, info.tooltip, pct
                            end

                            if widgetQuestID == nil and fallbackState == nil then
                                fallbackState, fallbackTooltip, fallbackPct = info.progressState, info.tooltip, pct
                            end
                        else
                            return info.progressState, info.tooltip, pct
                        end
                    end
                end
            end
        end
    end

    if IsValidQuestID(activeQuestID) then
        return fallbackState, fallbackTooltip, fallbackPct
    end

    return nil, nil, nil
end

local function ResetStateForNewQuest(questID)
    if state.activeQuestID ~= questID then
        state.activeQuestID = questID
        state.lastNotifiedPreyEndQuestID = nil
        state.progressState = nil
        state.progressPercent = nil
        state.stageSoundPlayed = {}
        state.stageSoundAttempted = {}
        state.stage = 1
        state.preyZoneName, state.preyZoneMapID = GetPreyZoneInfo(questID)
        state.inPreyZone = nil
        RefreshInPreyZoneStatus(questID, true)
        state.preyTooltipText = nil
        state.preyTargetName, state.preyTargetDifficulty = ExtractPreyTargetFromQuestTitle(questID)
        state.ambushAlertUntil = 0
        state.lastAmbushSoundAt = 0
        state.lastAmbushSystemMessage = nil
    end
end

local function UpdatePreyState()
    local now = GetTime and GetTime() or 0
    local questID = GetCurrentActivePreyQuestCached(0)
    local hasActiveQuest = IsValidQuestID(questID)
    local forceKillStage = (state.killStageUntil or 0) > now
    local forceAmbushAlert = (state.ambushAlertUntil or 0) > now

    if not hasActiveQuest and not forceKillStage then
        local endingQuestID = state.activeQuestID or questID
        local completedTransition = tonumber(state.stage) == MAX_STAGE
        if endingQuestID and endingQuestID > 0 then
            if completedTransition ~= true or state.lastNotifiedPreyEndQuestID ~= endingQuestID then
                RunModuleHook("OnPreyQuestEnded", {
                    questID = endingQuestID,
                    completed = completedTransition == true,
                    stage = tonumber(state.stage),
                    difficulty = state.preyTargetDifficulty,
                })
                if completedTransition == true then
                    state.lastNotifiedPreyEndQuestID = endingQuestID
                end
            end
        end
        DebugLogPreyState("clear", questID, false, state.progressState, state.progressPercent, state.inPreyZone)
        ClearPreyStateAndDisplay()
        ApplyDefaultPreyIconVisibility()
        UpdateBarDisplay()
        return
    end

    if hasActiveQuest then
        ResetStateForNewQuest(questID)
        RefreshInPreyZoneStatus(questID, false)

        -- While out of prey zone, skip expensive widget/objective scans.
        if state.inPreyZone == false and not forceKillStage and not forceAmbushAlert then
            state.lastPercentSource = "none"
            state.preyTooltipText = nil
            ApplyDefaultPreyIconVisibility()
            UpdateBarDisplay()
            return
        end
    end

    local newProgressState, tooltipText, newProgressPercent = nil, nil, nil
    if hasActiveQuest then
        newProgressState, tooltipText, newProgressPercent = FindPreyWidgetProgressState(questID)
    end
    local hasWidgetData = newProgressState ~= nil

    if hasWidgetData then
        state.lastWidgetSeenAt = now
    end

    local effectiveQuestID = hasActiveQuest and questID or nil

    local questCompleted = false
    if questID and C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        questCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID) and true or false
    end

    local questStillActive = IsQuestStillActive(questID)
    if questCompleted or (hasActiveQuest and not questStillActive and not hasWidgetData) then
        local endingQuestID = effectiveQuestID or state.activeQuestID or questID
        local completedTransition = questCompleted or (((not hasActiveQuest) or (not questStillActive)) and tonumber(state.stage) == MAX_STAGE)
        if endingQuestID and endingQuestID > 0 then
            if completedTransition ~= true or state.lastNotifiedPreyEndQuestID ~= endingQuestID then
                RunModuleHook("OnPreyQuestEnded", {
                    questID = endingQuestID,
                    completed = completedTransition == true,
                    stage = tonumber(state.stage),
                    difficulty = state.preyTargetDifficulty,
                })
                if completedTransition == true then
                    state.lastNotifiedPreyEndQuestID = endingQuestID
                end
            end
        end
        DebugLogPreyState("clear", questID, hasWidgetData, state.progressState, state.progressPercent, state.inPreyZone)
        ClearPreyStateAndDisplay()
        ApplyDefaultPreyIconVisibility()
        UpdateBarDisplay()
        return
    end

    if hasWidgetData then
        state.inPreyZone = true
    end

    local oldProgressState = state.progressState
    local percentSource = "none"
    if newProgressState ~= nil then
        state.progressState = newProgressState
        state.inPreyZone = true
    end
    if newProgressPercent ~= nil then
        state.progressPercent = newProgressPercent
        percentSource = "widget"
    else
        local objectivePercent = ExtractQuestObjectivePercent(questID)
        if objectivePercent ~= nil and (objectivePercent > 0 or newProgressState == PREY_PROGRESS_FINAL) then
            state.progressPercent = objectivePercent
            percentSource = "objective"
        end
    end

    if newProgressPercent == nil and percentSource == "none" and newProgressState ~= nil then
        if newProgressState == PREY_PROGRESS_FINAL then
            state.progressPercent = 100
            percentSource = "final"
        else
            state.progressPercent = nil
        end
    elseif newProgressPercent == nil and percentSource == "none" and (now - (state.lastWidgetSeenAt or 0)) > 2 then
        state.progressPercent = nil
        state.progressState = nil
    end
    state.lastPercentSource = percentSource
    state.preyTooltipText = tooltipText
    DebugLogPreyState("update", effectiveQuestID, hasWidgetData, state.progressState, state.progressPercent, state.inPreyZone)

    local oldStage = state.stage
    local newStage = GetStageFromState(state.progressState)

    local stageChanged = newStage ~= oldStage
    if stageChanged then
        TryPlayStageSound(newStage)
    end

    if newProgressState ~= PREY_PROGRESS_FINAL or oldProgressState == PREY_PROGRESS_FINAL then
        ApplyDefaultPreyIconVisibility()
        UpdateBarDisplay()
        return
    end

    if state.stageSoundPlayed[MAX_STAGE] or state.stageSoundAttempted[MAX_STAGE] then
        ApplyDefaultPreyIconVisibility()
        UpdateBarDisplay()
        return
    end

    TryPlayStageSound(MAX_STAGE)

    ApplyDefaultPreyIconVisibility()
    UpdateBarDisplay()
end

function Preydator:ShouldUseActivePolling()
    local customizationV2 = Preydator:GetModule("CustomizationStateV2")
    local barModuleEnabled = true
    local soundsModuleEnabled = true
    if customizationV2 and type(customizationV2.IsModuleEnabled) == "function" then
        barModuleEnabled = customizationV2:IsModuleEnabled("bar") == true
        soundsModuleEnabled = customizationV2:IsModuleEnabled("sounds") == true
    end

    local soundsRuntimeEnabled = soundsModuleEnabled and settings and settings.soundsEnabled ~= false
    if not barModuleEnabled and not soundsRuntimeEnabled then
        return false
    end

    local now = GetTime and GetTime() or 0
    local trackedQuestID = state and state.activeQuestID or nil
    local hasTrackedQuest = IsValidQuestID(trackedQuestID) and IsQuestStillActive(trackedQuestID)
    local liveQuestID = GetCurrentActivePreyQuestCached(ACTIVE_PREY_QUEST_CACHE_SECONDS)
    local hasLiveQuest = IsValidQuestID(liveQuestID) and IsQuestStillActive(liveQuestID)
    local needsQuestBootstrap = hasLiveQuest and not hasTrackedQuest
    local inKillCarry = ((state and state.killStageUntil) or 0) > now
    local inAmbushAlert = ((state and state.ambushAlertUntil) or 0) > now
    local inQuestListenBurst = ((state and state.questListenUntil) or 0) > now
    local inEditPreview = settings and settings.showInEditMode == true and IsEditModePreviewActive() == true
    local forceShowBar = state and state.forceShowBar == true
    local hasHotQuestContext = hasTrackedQuest and state and state.inPreyZone == true

    return needsQuestBootstrap
        or inKillCarry
        or inAmbushAlert
        or inQuestListenBurst
        or inEditPreview
        or forceShowBar
        or hasHotQuestContext
end

function Preydator:SetPollingActive(enabled)
    if not frame then
        return
    end

    local customizationV2 = Preydator:GetModule("CustomizationStateV2")
    if customizationV2 and type(customizationV2.IsModuleEnabled) == "function" then
        local barModuleEnabled = customizationV2:IsModuleEnabled("bar") == true
        local soundsModuleEnabled = customizationV2:IsModuleEnabled("sounds") == true
        local soundsRuntimeEnabled = soundsModuleEnabled and settings and settings.soundsEnabled ~= false
        if not barModuleEnabled and not soundsRuntimeEnabled then
            enabled = false
        end
    end

    local shouldEnable = enabled == true
    if shouldEnable == (state.pollingActive == true) then
        return
    end

    state.pollingActive = shouldEnable

    if shouldEnable then
        state.nextPollingEligibilityCheckAt = 0
        frame:SetScript("OnUpdate", function(_, elapsed)
            state.elapsedSinceUpdate = (state.elapsedSinceUpdate or 0) + (elapsed or 0)
            local now = GetTime and GetTime() or 0
            local inKillCarry = ((state and state.killStageUntil) or 0) > now
            local inAmbushAlert = ((state and state.ambushAlertUntil) or 0) > now
            local inQuestListenBurst = ((state and state.questListenUntil) or 0) > now
            local inEditPreview = settings and settings.showInEditMode == true and IsEditModePreviewActive() == true
            local recentlySawWidget = (now - ((state and state.lastWidgetSeenAt) or 0)) <= 2.0
            local progressState = tonumber(state and state.progressState)
            local isIdleInZone = IsValidQuestID(state and state.activeQuestID)
                and state.inPreyZone == true
                and (progressState == nil or progressState == 0)
                and not recentlySawWidget
                and not inKillCarry
                and not inAmbushAlert
                and not inQuestListenBurst
                and not (state and state.forceShowBar == true)
                and not inEditPreview
            local interval = isIdleInZone and 2.0 or UPDATE_INTERVAL_SECONDS
            if state.elapsedSinceUpdate < interval then
                return
            end

            state.elapsedSinceUpdate = 0
            UpdatePreyState()

            if now >= (state.nextPollingEligibilityCheckAt or 0) then
                state.nextPollingEligibilityCheckAt = now + 2.0
                if not Preydator:ShouldUseActivePolling() then
                    Preydator:SetPollingActive(false)
                end
            end
        end)
    else
        state.elapsedSinceUpdate = 0
        state.nextPollingEligibilityCheckAt = 0
        frame:SetScript("OnUpdate", nil)
    end
end

function Preydator:ApplyRuntimeSettings(nextSettings, emitProfileHook, refreshUi)
    if type(nextSettings) == "table" then
        settings = nextSettings
    end

    if type(settings) ~= "table" then
        return
    end

    ApplyDefaults(settings, DEFAULTS)
    EnsureDebugDB()
    debugDB.enabled = settings.debugSounds and true or false

    NormalizeSoundSettings()
    NormalizeLabelSettings()
    NormalizeColorSettings()
    RestoreBarPointFromBackup()
    NormalizeDisplaySettings()
    NormalizeProgressSettings()
    NormalizeAmbushSettings()
    ApplyDefaultPreyIconVisibility()

    state.forceShowBar = settings.forceShowBar

    if refreshUi then
        ApplyBarSettings()
        UpdateBarDisplay()
        Preydator:SetPollingActive(Preydator:ShouldUseActivePolling())
    end

    if emitProfileHook then
        RunModuleHook("OnProfileChanged", settings)
    end
end

local function OnAddonLoaded()
    _G.PreydatorDB = _G.PreydatorDB or {}
    local profileSystem = Preydator and Preydator.ProfileSystem
    if profileSystem and type(profileSystem.EnsureProfiles) == "function" then
        profileSystem:EnsureProfiles()
        if type(profileSystem.GetActiveProfileTable) == "function" then
            settings = profileSystem:GetActiveProfileTable()
        end
    end
    if type(settings) ~= "table" then
        settings = _G.PreydatorDB
    end

    Preydator:ApplyRuntimeSettings(settings, false, false)
    AddDebugLog("OnAddonLoaded", "debug=" .. tostring(debugDB.enabled) .. " | stage" .. tostring(MAX_STAGE) .. "=" .. tostring(settings.stageSounds[MAX_STAGE]), true)

    state.pollingActive = false

    frame:RegisterEvent("PLAYER_LOGIN")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("UPDATE_UI_WIDGET")
    frame:RegisterEvent("UPDATE_ALL_UI_WIDGETS")
    frame:RegisterEvent("QUEST_TURNED_IN")
    frame:RegisterEvent("CHAT_MSG_SYSTEM")
    frame:RegisterEvent("CHAT_MSG_MONSTER_SAY")
    frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")
    frame:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
    frame:RegisterEvent("RAID_BOSS_EMOTE")
    frame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
    frame:RegisterEvent("QUEST_DETAIL")
    frame:RegisterEvent("QUEST_ACCEPTED")
    frame:RegisterEvent("ZONE_CHANGED")
    frame:RegisterEvent("ZONE_CHANGED_INDOORS")
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

    RunModuleHook("OnAddonLoaded")
end

local function AddCheckbox(parent, label, x, y, getter, setter)
    local checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkbox:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    checkbox.Text:SetText(label)
    checkbox:SetChecked(getter())
    checkbox:SetScript("OnClick", function(self)
        setter(self:GetChecked())
    end)
    return checkbox
end

local function AddSlider(parent, label, x, y, minValue, maxValue, step, getter, setter)
    local slider = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    slider:SetWidth(240)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    slider:SetValue(getter())
    slider.Text:SetText(label)
    slider.Low:SetText(tostring(minValue))
    slider.High:SetText(tostring(maxValue))
    slider:SetScript("OnValueChanged", function(self, value)
        setter(value)
    end)
    return slider
end

local function AddDropdown(parent, label, x, y, width, options, getter, setter)
    local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    title:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    title:SetText(label)

    local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -16, -4)

    local function GetOptions()
        if type(options) == "function" then
            return options() or {}
        end
        return options or {}
    end

    local function RefreshText()
        local key = getter()
        local entry = GetOptions()[key]
        UIDropDownMenu_SetText(dropdown, entry and entry.text or "Select")
    end

    UIDropDownMenu_SetWidth(dropdown, width)
    UIDropDownMenu_Initialize(dropdown, function(_, _, _)
        local optionList = {}
        for key, entry in pairs(GetOptions()) do
            table.insert(optionList, { key = key, entry = entry })
        end

        table.sort(optionList, function(a, b)
            local left = tostring(a.entry and a.entry.text or "")
            local right = tostring(b.entry and b.entry.text or "")
            return left < right
        end)

        for _, item in ipairs(optionList) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.entry.text
            info.func = function()
                setter(item.key)
                RefreshText()
            end
            info.checked = getter() == item.key
            UIDropDownMenu_AddButton(info)
        end
    end)

    dropdown.PreydatorRefreshText = RefreshText
    RefreshText()
    return dropdown
end

local function AddColorSwatch(parent, x, y, getter, setter, allowAlpha)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(28, 22)
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    button:SetText("")

    local swatch = button:CreateTexture(nil, "ARTWORK")
    swatch:SetPoint("TOPLEFT", button, "TOPLEFT", 3, -3)
    swatch:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -3, 3)

    local function Refresh()
        local c = getter()
        local a = (allowAlpha and c[4]) or 1
        swatch:SetColorTexture(c[1], c[2], c[3], a)
    end

    local function NormalizeColorInput(value, fallback)
        local fb = fallback or { 1, 1, 1, 1 }
        local r = value and (value[1] or value.r) or fb[1]
        local g = value and (value[2] or value.g) or fb[2]
        local b = value and (value[3] or value.b) or fb[3]

        local a = fb[4]
        if allowAlpha then
            if value then
                if value[4] ~= nil then
                    a = value[4]
                elseif value.a ~= nil then
                    a = value.a
                elseif value.opacity ~= nil then
                    a = 1 - value.opacity
                end
            end
        else
            a = 1
        end

        r = Clamp(tonumber(r) or fb[1] or 1, 0, 1)
        g = Clamp(tonumber(g) or fb[2] or 1, 0, 1)
        b = Clamp(tonumber(b) or fb[3] or 1, 0, 1)
        a = Clamp(tonumber(a) or fb[4] or 1, 0, 1)

        return { r, g, b, a }
    end

    local function GetPickerColor(defaultA)
        local r, g, b
        if ColorPickerFrame.GetColorRGB then
            r, g, b = ColorPickerFrame:GetColorRGB()
        elseif ColorPickerFrame.Content and ColorPickerFrame.Content.ColorPicker and ColorPickerFrame.Content.ColorPicker.GetColorRGB then
            r, g, b = ColorPickerFrame.Content.ColorPicker:GetColorRGB()
        else
            r, g, b = 1, 1, 1
        end

        local a = defaultA
        if allowAlpha then
            if ColorPickerFrame.GetColorAlpha then
                a = ColorPickerFrame:GetColorAlpha()
            elseif OpacitySliderFrame and OpacitySliderFrame.GetValue then
                a = 1 - OpacitySliderFrame:GetValue()
            end
        end

        return r, g, b, a
    end

    button:SetScript("OnClick", function()
        if not ColorPickerFrame then
            return
        end

        UI.colorPickerSessionCounter = UI.colorPickerSessionCounter + 1
        local sessionID = UI.colorPickerSessionCounter
        ColorPickerFrame.preydatorSessionID = sessionID

        local start = getter()
        local startColor = {
            start[1] or 1,
            start[2] or 1,
            start[3] or 1,
            start[4] or 1,
        }

        local function ApplyColor()
            if ColorPickerFrame.preydatorSessionID ~= sessionID then
                return
            end

            local r, g, b, a = GetPickerColor(startColor[4])

            setter(NormalizeColorInput({ r, g, b, a }, startColor))
            Refresh()
        end

        local function CancelColor(previousValues)
            if ColorPickerFrame.preydatorSessionID ~= sessionID then
                return
            end

            local pr, pg, pb, pa = nil, nil, nil, nil
            if type(previousValues) == "table" then
                pr = previousValues.r or previousValues[1]
                pg = previousValues.g or previousValues[2]
                pb = previousValues.b or previousValues[3]
                pa = previousValues.a or previousValues[4]
            elseif ColorPickerFrame.GetPreviousValues then
                pr, pg, pb, pa = ColorPickerFrame:GetPreviousValues()
            end

            if pr == nil or pg == nil or pb == nil then
                pr, pg, pb, pa = startColor[1], startColor[2], startColor[3], startColor[4]
            end

            setter(NormalizeColorInput({ pr, pg, pb, pa }, startColor))
            Refresh()
        end

        if ColorPickerFrame.SetupColorPickerAndShow then
            local info = {
                r = startColor[1],
                g = startColor[2],
                b = startColor[3],
                opacity = allowAlpha and startColor[4] or 0,
                hasOpacity = allowAlpha and true or false,
                func = ApplyColor,
                swatchFunc = ApplyColor,
                opacityFunc = ApplyColor,
                cancelFunc = CancelColor,
            }
            ColorPickerFrame:SetupColorPickerAndShow(info)
            return
        end

        ColorPickerFrame.hasOpacity = allowAlpha and true or false
        ColorPickerFrame.opacity = allowAlpha and (1 - startColor[4]) or 0
        ColorPickerFrame.previousValues = { startColor[1], startColor[2], startColor[3], startColor[4] }
        if ColorPickerFrame.SetColorRGB then
            ColorPickerFrame:SetColorRGB(startColor[1], startColor[2], startColor[3])
        elseif ColorPickerFrame.Content and ColorPickerFrame.Content.ColorPicker and ColorPickerFrame.Content.ColorPicker.SetColorRGB then
            ColorPickerFrame.Content.ColorPicker:SetColorRGB(startColor[1], startColor[2], startColor[3])
        end
        ColorPickerFrame.func = ApplyColor
        ColorPickerFrame.swatchFunc = ApplyColor
        ColorPickerFrame.opacityFunc = ApplyColor
        ColorPickerFrame.cancelFunc = CancelColor

        ColorPickerFrame:Hide()
        ColorPickerFrame:Show()
    end)

    button.PreydatorRefresh = Refresh
    Refresh()
    return button
end

EnsureOptionsPanel = function()
    local settingsModule = Preydator.GetModule and Preydator:GetModule("Settings")
    if settingsModule and settingsModule.EnsureOptionsPanel then
        local panelRef, categoryID = settingsModule:EnsureOptionsPanel()
        if panelRef then
            UI.optionsPanel = panelRef
        end
        if categoryID ~= nil then
            UI.optionsCategoryID = categoryID
        end
        return
    end

    if UI.optionsPanel then
        return
    end

    local panel = CreateFrame("Frame", "PreydatorOptionsPanel")
    panel.name = "Preydator"
    local panelRoot = panel

    local scrollFrame = CreateFrame("ScrollFrame", "PreydatorOptionsScrollFrame", panelRoot, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", panelRoot, "TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", panelRoot, "BOTTOMRIGHT", -30, 8)

    local content = CreateFrame("Frame", "PreydatorOptionsContent", scrollFrame)
    content:SetSize(760, 900)
    scrollFrame:SetScrollChild(content)

    UI.optionsScrollFrame = scrollFrame
    UI.optionsContentFrame = content
    panel = content

    NormalizeLabelSettings()

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Preydator")

    local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetText(L["Bar movement, scale, font, texture, and sound settings."])
    subtitle:SetWidth(700)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetWordWrap(true)

    local lockCheckbox = AddCheckbox(panel, "Lock Bar", 20, -55, function() return settings.locked end, function(value)
        settings.locked = value
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local onlyShowInPreyZoneCheckbox = AddCheckbox(panel, "Only show in prey zone", 20, -83, function() return settings.onlyShowInPreyZone end, function(value)
        settings.onlyShowInPreyZone = value
        UpdateBarDisplay()
    end)

    local showInEditModeCheckbox = AddCheckbox(panel, "Show in Edit Mode preview", 20, -195, function() return settings.showInEditMode ~= false end, function(value)
        settings.showInEditMode = value
        NormalizeDisplaySettings()
        UpdateBarDisplay()
    end)

    local disableDefaultPreyIconCheckbox = AddCheckbox(panel, "Disable Default Prey Icon", 20, -139, function() return settings.disableDefaultPreyIcon == true end, function(value)
        settings.disableDefaultPreyIcon = value
        ApplyDefaultPreyIconVisibility()
    end)

    local scaleSlider = AddSlider(panel, "Scale", 20, -435, 0.5, 2, 0.05, function() return settings.scale end, function(value)
        settings.scale = Clamp(value, 0.5, 2)
        ApplyBarSettings()
    end)

    local widthSlider = AddSlider(panel, "Width", 20, -470, 160, 500, 1, function() return settings.width end, function(value)
        settings.width = Clamp(math.floor(value + 0.5), 160, 500)
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local heightSlider = AddSlider(panel, "Height", 20, -505, 10, 40, 1, function() return settings.height end, function(value)
        settings.height = Clamp(math.floor(value + 0.5), 10, 40)
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local fontSizeSlider = AddSlider(panel, "Font Size", 20, -540, 8, 24, 1, function() return settings.fontSize end, function(value)
        settings.fontSize = Clamp(math.floor(value + 0.5), 8, 24)
        ApplyBarSettings()
    end)

    local stageNamesTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    stageNamesTitle:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, -407)
    stageNamesTitle:SetText(L["Stage Names"])

    local stageNameEdits = {}
    for stageIndex = 1, (MAX_STAGE - 1) do
        local rowY = -442 - ((stageIndex - 1) * 35)
        local label = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        label:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, rowY)
        label:SetText(tostring(stageIndex) .. ":")

        local edit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
        edit:SetSize(180, 20)
        edit:SetAutoFocus(false)
        edit:SetTextInsets(6, 6, 0, 0)
        edit:SetPoint("TOPLEFT", panel, "TOPLEFT", 350, -441 - ((stageIndex - 1) * 35))
        edit:SetText(GetStageLabel(stageIndex))
        edit:SetScript("OnEnterPressed", function(self)
            settings.stageLabels[stageIndex] = self:GetText()
            NormalizeLabelSettings()
            self:SetText(settings.stageLabels[stageIndex])
            self:ClearFocus()
            UpdateBarDisplay()
        end)
        edit:SetScript("OnEditFocusLost", function(self)
            settings.stageLabels[stageIndex] = self:GetText()
            NormalizeLabelSettings()
            self:SetText(settings.stageLabels[stageIndex])
            UpdateBarDisplay()
        end)
        stageNameEdits[stageIndex] = edit
    end

    local outZoneRowY = -547
    local outZoneLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    outZoneLabel:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, outZoneRowY)
    outZoneLabel:SetText(L["Zone:"])

    local outZoneEdit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    outZoneEdit:SetSize(156, 20)
    outZoneEdit:SetAutoFocus(false)
    outZoneEdit:SetTextInsets(6, 6, 0, 0)
    outZoneEdit:SetPoint("TOPLEFT", panel, "TOPLEFT", 365, -546)
    outZoneEdit:SetText(settings.outOfZoneLabel or DEFAULT_OUT_OF_ZONE_LABEL)
    outZoneEdit:SetScript("OnEnterPressed", function(self)
        settings.outOfZoneLabel = self:GetText()
        NormalizeLabelSettings()
        self:SetText(settings.outOfZoneLabel)
        self:ClearFocus()
        UpdateBarDisplay()
    end)
    outZoneEdit:SetScript("OnEditFocusLost", function(self)
        settings.outOfZoneLabel = self:GetText()
        NormalizeLabelSettings()
        self:SetText(settings.outOfZoneLabel)
        UpdateBarDisplay()
    end)

    local ambushLabelText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    ambushLabelText:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, -575)
    ambushLabelText:SetText(L["Ambush:"])

    local ambushLabelEdit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    ambushLabelEdit:SetSize(156, 20)
    ambushLabelEdit:SetAutoFocus(false)
    ambushLabelEdit:SetTextInsets(6, 6, 0, 0)
    ambushLabelEdit:SetPoint("TOPLEFT", panel, "TOPLEFT", 380, -574)
    ambushLabelEdit:SetText(settings.ambushCustomText or "")
    ambushLabelEdit:SetScript("OnEnterPressed", function(self)
        settings.ambushCustomText = self:GetText()
        NormalizeLabelSettings()
        self:SetText(settings.ambushCustomText)
        self:ClearFocus()
        UpdateBarDisplay()
    end)
    ambushLabelEdit:SetScript("OnEditFocusLost", function(self)
        settings.ambushCustomText = self:GetText()
        NormalizeLabelSettings()
        self:SetText(settings.ambushCustomText)
        UpdateBarDisplay()
    end)

    local restoreNamesButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    restoreNamesButton:SetSize(180, 24)
    restoreNamesButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, -764)
    restoreNamesButton:SetText(L["Restore Default Names"])
    restoreNamesButton:SetScript("OnClick", function()
        for stageIndex = 1, (MAX_STAGE - 1) do
            settings.stageLabels[stageIndex] = DEFAULT_STAGE_LABELS[stageIndex]
            stageNameEdits[stageIndex]:SetText(DEFAULT_STAGE_LABELS[stageIndex])
        end
        settings.outOfZoneLabel = DEFAULT_OUT_OF_ZONE_LABEL
        settings.ambushCustomText = ""
        outZoneEdit:SetText(DEFAULT_OUT_OF_ZONE_LABEL)
        ambushLabelEdit:SetText("")
        UpdateBarDisplay()
    end)

    local restoreSoundsButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    restoreSoundsButton:SetSize(180, 24)
    restoreSoundsButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, -793)
    restoreSoundsButton:SetText(L["Restore Default Sounds"])
    restoreSoundsButton:SetScript("OnClick", function()
        settings.soundsEnabled = DEFAULTS.soundsEnabled
        settings.soundChannel = DEFAULTS.soundChannel
        settings.soundEnhance = DEFAULTS.soundEnhance
        settings.ambushSoundEnabled = DEFAULTS.ambushSoundEnabled
        settings.ambushVisualEnabled = DEFAULTS.ambushVisualEnabled
        settings.ambushSoundPath = DEFAULTS.ambushSoundPath
        settings.soundFileNames = {}
        for _, fileName in ipairs(DEFAULT_SOUND_FILENAMES) do
            table.insert(settings.soundFileNames, fileName)
        end
        for stageIndex = 1, MAX_STAGE do
            settings.stageSounds[stageIndex] = DEFAULTS.stageSounds[stageIndex]
        end
        NormalizeSoundSettings()
        NormalizeAmbushSettings()
        if panel.PreydatorRefreshControls then
            panel.PreydatorRefreshControls()
        end
    end)

    local resetAllButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    resetAllButton:SetSize(180, 24)
    resetAllButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, -821)
    resetAllButton:SetText(L["Reset All Defaults"])
    resetAllButton:SetScript("OnClick", function()
        ResetAllSettings()
        if panel.PreydatorRefreshControls then
            panel.PreydatorRefreshControls()
        end
    end)

    local customSoundTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    customSoundTitle:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -659)
    customSoundTitle:SetText(L["Custom Sound Files: No Spaces"])

    local customSoundPathLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    customSoundPathLabel:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -687)
    customSoundPathLabel:SetText(L["Interface\\AddOns\\Preydator\\sounds\\"])

    local customSoundEdit = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    customSoundEdit:SetSize(210, 20)
    customSoundEdit:SetAutoFocus(false)
    customSoundEdit:SetTextInsets(6, 6, 0, 0)
    customSoundEdit:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -715)
    customSoundEdit:SetText("")

    local addCustomSoundButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    addCustomSoundButton:SetSize(100, 22)
    addCustomSoundButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -743)
    addCustomSoundButton:SetText(L["Add File"])
    addCustomSoundButton:SetScript("OnClick", function()
        local ok, message = AddSoundFileName(customSoundEdit:GetText())
        if not ok then
            print(L["Preydator: "] .. tostring(message))
            return
        end

        customSoundEdit:SetText("")
        if panel.PreydatorRefreshControls then
            panel.PreydatorRefreshControls()
        end
        print("Preydator: Added sound file '" .. tostring(message) .. "'.")
    end)

    local removeCustomSoundButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    removeCustomSoundButton:SetSize(110, 22)
    removeCustomSoundButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 130, -743)
    removeCustomSoundButton:SetText(L["Remove File"])
    removeCustomSoundButton:SetScript("OnClick", function()
        local ok, message = RemoveSoundFileName(customSoundEdit:GetText())
        if not ok then
            print(L["Preydator: "] .. tostring(message))
            return
        end

        customSoundEdit:SetText("")
        if panel.PreydatorRefreshControls then
            panel.PreydatorRefreshControls()
        end
        print("Preydator: Removed sound file '" .. tostring(message) .. "'.")
    end)

    panelRoot:SetScript("OnShow", function()
        NormalizeLabelSettings()
        if panelRoot.PreydatorRefreshControls then
            panelRoot.PreydatorRefreshControls()
        end
    end)

    local textureOptions = {
        default = { text = "Default" },
        flat = { text = "Flat" },
        raid = { text = "Raid HP Fill" },
        classic = { text = "Classic Skill Bar" },
    }

    local fontOptions = {
        frizqt = { text = "Friz Quadrata" },
        arialn = { text = "Arial Narrow" },
        skurri = { text = "Skurri" },
        morpheus = { text = "Morpheus" },
    }

    local channelOptions = {
        Master = { text = "Master" },
        SFX = { text = "SFX" },
        Dialog = { text = "Dialog" },
        Ambience = { text = "Ambience" },
    }

    local percentDisplayOptions = {
        [PERCENT_DISPLAY_INSIDE] = { text = "In Bar" },
        [PERCENT_DISPLAY_UNDER_TICKS] = { text = "Under Ticks" },
        [PERCENT_DISPLAY_BELOW_BAR] = { text = "Below Bar" },
        [PERCENT_DISPLAY_OFF] = { text = "Off" },
    }

    local layerModeOptions = {
        [LAYER_MODE_ABOVE] = { text = "Above Fill" },
        [LAYER_MODE_BELOW] = { text = "Below Fill" },
    }

    local progressSegmentOptions = {
        [PROGRESS_SEGMENTS_QUARTERS] = { text = "Quarters (25/50/75/100)" },
        [PROGRESS_SEGMENTS_THIRDS] = { text = "Thirds (33/66/100)" },
    }

    local textureDropdown = AddDropdown(panel, "Texture", 20, -271, 170, textureOptions, function()
        return settings.textureKey
    end, function(key)
        settings.textureKey = key
        ApplyBarSettings()
    end)
    local fillColorSwatch = AddColorSwatch(panel, 230, -291, function()
        return settings.fillColor
    end, function(color)
        settings.fillColor = { color[1], color[2], color[3], color[4] }
        ApplyBarSettings()
    end, true)

    local titleFontDropdown = AddDropdown(panel, "Title Font", 20, -323, 170, fontOptions, function()
        return settings.titleFontKey
    end, function(key)
        settings.titleFontKey = key
        ApplyBarSettings()
    end)
    local titleColorSwatch = AddColorSwatch(panel, 230, -343, function()
        return settings.titleColor
    end, function(color)
        settings.titleColor = { color[1], color[2], color[3], color[4] }
        ApplyBarSettings()
        UpdateBarDisplay()
    end, true)

    local percentFontDropdown = AddDropdown(panel, "Percent Font", 20, -375, 170, fontOptions, function()
        return settings.percentFontKey
    end, function(key)
        settings.percentFontKey = key
        ApplyBarSettings()
    end)
    local percentColorSwatch = AddColorSwatch(panel, 230, -395, function()
        return settings.percentColor
    end, function(color)
        settings.percentColor = { color[1], color[2], color[3], color[4] }
        ApplyBarSettings()
        UpdateBarDisplay()
    end, true)

    local soundsCheckbox = AddCheckbox(panel, "Enable sounds", 20, -111, function() return settings.soundsEnabled end, function(value)
        settings.soundsEnabled = value
    end)

    local ambushSoundCheckbox = AddCheckbox(panel, "Ambush sound alert", 320, -55, function() return settings.ambushSoundEnabled ~= false end, function(value)
        settings.ambushSoundEnabled = value
    end)

    local ambushVisualCheckbox = AddCheckbox(panel, "Ambush visual alert", 320, -83, function() return settings.ambushVisualEnabled ~= false end, function(value)
        settings.ambushVisualEnabled = value
        if not value then
            state.ambushAlertUntil = 0
            UpdateBarDisplay()
        end
    end)

    local stage1SoundDropdown = AddDropdown(panel, "Stage 1 Sound", 320, -191, 170, BuildSoundDropdownOptions, function()
        return settings.stageSounds[1]
    end, function(key)
        settings.stageSounds[1] = key
        NormalizeSoundSettings()
    end)

    local stage2SoundDropdown = AddDropdown(panel, "Stage 2 Sound", 320, -243, 170, BuildSoundDropdownOptions, function()
        return settings.stageSounds[2]
    end, function(key)
        settings.stageSounds[2] = key
        NormalizeSoundSettings()
    end)

    local stage3SoundDropdown = AddDropdown(panel, "Stage 3 Sound", 320, -295, 170, BuildSoundDropdownOptions, function()
        return settings.stageSounds[3]
    end, function(key)
        settings.stageSounds[3] = key
        NormalizeSoundSettings()
    end)

    local ambushSoundDropdown = AddDropdown(panel, "Ambush Sound", 320, -347, 170, BuildSoundDropdownOptions, function()
        return settings.ambushSoundPath
    end, function(key)
        settings.ambushSoundPath = key
        NormalizeAmbushSettings()
    end)

    local testAmbushAlertButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    testAmbushAlertButton:SetSize(170, 24)
    testAmbushAlertButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 320, -715)
    testAmbushAlertButton:SetText(L["Test Ambush"])
    testAmbushAlertButton:SetScript("OnClick", function()
        TriggerAmbushAlert(L["Manual test"], "options")
    end)

    local soundChannelDropdown = AddDropdown(panel, "Sound Channel", 320, -139, 170, channelOptions, function()
        return settings.soundChannel
    end, function(key)
        settings.soundChannel = key
    end)

    local enhanceSlider = AddSlider(panel, "Enhance Sounds", 20, -575, 0, 100, 5, function()
        return settings.soundEnhance or 0
    end, function(value)
        settings.soundEnhance = Clamp(math.floor(value + 0.5), 0, 100)
    end)

    local showTicksCheckbox = AddCheckbox(panel, "Show tick marks", 320, -111, function() return settings.showTicks end, function(value)
        settings.showTicks = value
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local tickLayerDropdown = AddDropdown(panel, "Tick Mark Layer", 320, -399, 170, layerModeOptions, function()
        return settings.tickLayerMode
    end, function(key)
        settings.tickLayerMode = key
        NormalizeDisplaySettings()
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local percentDisplayDropdown = AddDropdown(panel, "Percent Display", 20, -219, 170, percentDisplayOptions, function()
        return settings.percentDisplay
    end, function(key)
        settings.percentDisplay = key
        NormalizeDisplaySettings()
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local progressSegmentsDropdown = AddDropdown(panel, "Progress Segments", 20, -167, 170, progressSegmentOptions, function()
        return settings.progressSegments
    end, function(key)
        settings.progressSegments = key
        NormalizeProgressSettings()
        ApplyBarSettings()
        UpdateBarDisplay()
    end)

    local function RefreshOptionsControls()
        if lockCheckbox then lockCheckbox:SetChecked(settings.locked) end
        if onlyShowInPreyZoneCheckbox then onlyShowInPreyZoneCheckbox:SetChecked(settings.onlyShowInPreyZone) end
        if showInEditModeCheckbox then showInEditModeCheckbox:SetChecked(settings.showInEditMode ~= false) end
        if disableDefaultPreyIconCheckbox then disableDefaultPreyIconCheckbox:SetChecked(settings.disableDefaultPreyIcon == true) end
        if soundsCheckbox then soundsCheckbox:SetChecked(settings.soundsEnabled) end
        if ambushSoundCheckbox then ambushSoundCheckbox:SetChecked(settings.ambushSoundEnabled ~= false) end
        if ambushVisualCheckbox then ambushVisualCheckbox:SetChecked(settings.ambushVisualEnabled ~= false) end
        if showTicksCheckbox then showTicksCheckbox:SetChecked(settings.showTicks) end

        if scaleSlider then scaleSlider:SetValue(settings.scale) end
        if widthSlider then widthSlider:SetValue(settings.width) end
        if heightSlider then heightSlider:SetValue(settings.height) end
        if fontSizeSlider then fontSizeSlider:SetValue(settings.fontSize) end
        if enhanceSlider then enhanceSlider:SetValue(settings.soundEnhance or 0) end

        if textureDropdown and textureDropdown.PreydatorRefreshText then textureDropdown.PreydatorRefreshText() end
        if titleFontDropdown and titleFontDropdown.PreydatorRefreshText then titleFontDropdown.PreydatorRefreshText() end
        if percentFontDropdown and percentFontDropdown.PreydatorRefreshText then percentFontDropdown.PreydatorRefreshText() end
        if soundChannelDropdown and soundChannelDropdown.PreydatorRefreshText then soundChannelDropdown.PreydatorRefreshText() end
        if percentDisplayDropdown and percentDisplayDropdown.PreydatorRefreshText then percentDisplayDropdown.PreydatorRefreshText() end
        if tickLayerDropdown and tickLayerDropdown.PreydatorRefreshText then tickLayerDropdown.PreydatorRefreshText() end
        if progressSegmentsDropdown and progressSegmentsDropdown.PreydatorRefreshText then progressSegmentsDropdown.PreydatorRefreshText() end
        if ambushSoundDropdown and ambushSoundDropdown.PreydatorRefreshText then ambushSoundDropdown.PreydatorRefreshText() end
        if stage1SoundDropdown and stage1SoundDropdown.PreydatorRefreshText then stage1SoundDropdown.PreydatorRefreshText() end
        if stage2SoundDropdown and stage2SoundDropdown.PreydatorRefreshText then stage2SoundDropdown.PreydatorRefreshText() end
        if stage3SoundDropdown and stage3SoundDropdown.PreydatorRefreshText then stage3SoundDropdown.PreydatorRefreshText() end

        if fillColorSwatch and fillColorSwatch.PreydatorRefresh then fillColorSwatch.PreydatorRefresh() end
        if titleColorSwatch and titleColorSwatch.PreydatorRefresh then titleColorSwatch.PreydatorRefresh() end
        if percentColorSwatch and percentColorSwatch.PreydatorRefresh then percentColorSwatch.PreydatorRefresh() end

        for stageIndex = 1, (MAX_STAGE - 1) do
            stageNameEdits[stageIndex]:SetText(settings.stageLabels[stageIndex])
        end
        outZoneEdit:SetText(settings.outOfZoneLabel)
        ambushLabelEdit:SetText(settings.ambushCustomText)
    end

    panelRoot.PreydatorRefreshControls = RefreshOptionsControls

    local function AddSoundTestButton(text, x, y, stageIndex)
        local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        button:SetSize(140, 24)
        button:SetPoint("TOPLEFT", panel, "TOPLEFT", x, y)
        button:SetText(text)
        button:SetScript("OnClick", function()
            state.stageSoundPlayed[stageIndex] = nil
            state.stageSoundAttempted[stageIndex] = nil
            local path = ResolveStageSoundPath(stageIndex)
            if not path then
                print("Preydator: No stage " .. stageIndex .. " sound configured.")
                return
            end

            if not TryPlayStageSound(stageIndex, true) then
                print("Preydator: Stage " .. stageIndex .. " sound file failed to play. Ensure this file exists as .ogg: " .. tostring(path))
            end
        end)
    end

    AddSoundTestButton("Test Stage 1", 320, -631, 1)
    AddSoundTestButton("Test Stage 2", 320, -659, 2)
    AddSoundTestButton("Test Stage 3", 320, -687, 3)

    local note = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    note:SetPoint("TOPLEFT", panel, "TOPLEFT", 20, -603)
    note:SetWidth(260)
    note:SetJustifyH("LEFT")
    note:SetWordWrap(true)
    note:SetText(L["Enhance Sounds layers extra plays for perceived loudness. WoW does not expose true per-addon file volume."])

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panelRoot, "Preydator", "Preydator")
        Settings.RegisterAddOnCategory(category)
        if type(category) == "table" then
            UI.optionsCategoryID = category.ID or (category.GetID and category:GetID())
            panelRoot.categoryID = UI.optionsCategoryID
        end
    elseif _G.InterfaceOptions_AddCategory then
        _G.InterfaceOptions_AddCategory(panelRoot)
    end

    UI.optionsPanel = panelRoot
end

Preydator.Constants = {
    MAX_STAGE = MAX_STAGE,
    DEFAULT_OUT_OF_ZONE_LABEL = DEFAULT_OUT_OF_ZONE_LABEL,
    DEFAULT_AMBUSH_LABEL = DEFAULT_AMBUSH_LABEL,
    DEFAULT_STAGE_LABELS = DEFAULT_STAGE_LABELS,
    DEFAULT_SOUND_FILENAMES = DEFAULT_SOUND_FILENAMES,
    PROTECTED_SOUND_FILENAMES = PROTECTED_SOUND_FILENAMES,
    PROGRESS_SEGMENTS_QUARTERS = PROGRESS_SEGMENTS_QUARTERS,
    PROGRESS_SEGMENTS_THIRDS = PROGRESS_SEGMENTS_THIRDS,
    PERCENT_DISPLAY_INSIDE = PERCENT_DISPLAY_INSIDE,
    PERCENT_DISPLAY_INSIDE_BELOW = PERCENT_DISPLAY_INSIDE_BELOW,
    PERCENT_DISPLAY_BELOW_BAR = PERCENT_DISPLAY_BELOW_BAR,
    PERCENT_DISPLAY_ABOVE_BAR = PERCENT_DISPLAY_ABOVE_BAR,
    PERCENT_DISPLAY_ABOVE_TICKS = PERCENT_DISPLAY_ABOVE_TICKS,
    PERCENT_DISPLAY_UNDER_TICKS = PERCENT_DISPLAY_UNDER_TICKS,
    PERCENT_DISPLAY_OFF = PERCENT_DISPLAY_OFF,
    LAYER_MODE_ABOVE = LAYER_MODE_ABOVE,
    LAYER_MODE_BELOW = LAYER_MODE_BELOW,
    LABEL_MODE_CENTER = LABEL_MODE_CENTER,
    LABEL_MODE_LEFT = LABEL_MODE_LEFT,
    LABEL_MODE_LEFT_COMBINED = LABEL_MODE_LEFT_COMBINED,
    LABEL_MODE_RIGHT = LABEL_MODE_RIGHT,
    LABEL_MODE_RIGHT_COMBINED = LABEL_MODE_RIGHT_COMBINED,
    LABEL_MODE_SEPARATE = LABEL_MODE_SEPARATE,
    LABEL_MODE_LEFT_SUFFIX = LABEL_MODE_LEFT_SUFFIX,
    LABEL_MODE_RIGHT_PREFIX = LABEL_MODE_RIGHT_PREFIX,
    LABEL_MODE_NONE = LABEL_MODE_NONE,
    LABEL_ROW_ABOVE = LABEL_ROW_ABOVE,
    LABEL_ROW_BELOW = LABEL_ROW_BELOW,
    ORIENTATION_HORIZONTAL = ORIENTATION_HORIZONTAL,
    ORIENTATION_VERTICAL = ORIENTATION_VERTICAL,
    FILL_DIRECTION_UP = FILL_DIRECTION_UP,
    FILL_DIRECTION_DOWN = FILL_DIRECTION_DOWN,
    TEXTURE_PRESETS = TEXTURE_PRESETS,
    FONT_PRESETS = FONT_PRESETS,
}

Preydator.API = {
    GetSettings = function()
        return settings
    end,
    GetDefaults = function()
        return DEFAULTS
    end,
    GetState = function()
        return state
    end,
    Clamp = Clamp,
    RoundToStep = RoundToStep,
    NormalizeSliderValue = NormalizeSliderValue,
    CreateCheckboxControl = CreateCheckboxControl,
    CreateSliderControl = CreateSliderControl,
    ApplyBarSettings = ApplyBarSettings,
    UpdateBarDisplay = function()
        UpdateBarDisplay()
    end,
    RequestBarRefresh = function()
        ApplyBarSettings()
        UpdateBarDisplay()
    end,
    ApplyRuntimeSettings = function(nextSettings, emitProfileHook, refreshUi)
        Preydator:ApplyRuntimeSettings(nextSettings, emitProfileHook == true, refreshUi == true)
    end,
    ResetBarPosition = function()
        barPositionUtil.Reset()
    end,
    NormalizeSoundSettings = function()
        NormalizeSoundSettings()
    end,
    NormalizeLabelSettings = function()
        NormalizeLabelSettings()
    end,
    NormalizeColorSettings = function()
        NormalizeColorSettings()
    end,
    NormalizeDisplaySettings = function()
        NormalizeDisplaySettings()
    end,
    NormalizeProgressSettings = function()
        NormalizeProgressSettings()
    end,
    NormalizeAmbushSettings = function()
        NormalizeAmbushSettings()
    end,
    ApplyDefaultPreyIconVisibility = function()
        ApplyDefaultPreyIconVisibility()
    end,
    ResetAllSettings = function()
        ResetAllSettings()
    end,
    BuildSoundDropdownOptions = BuildSoundDropdownOptions,
    AddSoundFileName = AddSoundFileName,
    RemoveSoundFileName = RemoveSoundFileName,
    ResolveStageSoundPath = ResolveStageSoundPath,
    ResolveAmbushSoundPath = function()
        return ResolveAmbushAlertSoundPath()
    end,
    PlayTestSound = function(path)
        return TryPlaySound(path, true)
    end,
    TryPlayStageSound = function(stageIndex, force)
        return TryPlayStageSound(stageIndex, force)
    end,
    TriggerAmbushAlert = function(message, source)
        TriggerAmbushAlert(message, source)
    end,
    OpenLegacyOptionsPanel = function()
        if Settings and Settings.OpenToCategory then
            if type(UI.optionsCategoryID) == "number" then
                Settings.OpenToCategory(UI.optionsCategoryID)
                return true
            end

            if UI.optionsPanel and type(UI.optionsPanel.categoryID) == "number" then
                Settings.OpenToCategory(UI.optionsPanel.categoryID)
                return true
            end
        end

        return false
    end,
}

local function HandleSlashCommand(message)
    message = (message or ""):match("^%s*(.-)%s*$")
    local command, rest = message:match("^(%S+)%s*(.-)$")
    local text = string.lower(command or "")

    if text == "debug" then
        EnsureDebugDB()
        local mode = string.lower(rest or "")

        if mode == "on" then
            settings.debugSounds = true
            debugDB.enabled = true
            print(L["Preydator: Debug logging enabled."])
            return
        end

        if mode == "off" then
            settings.debugSounds = false
            debugDB.enabled = false
            print(L["Preydator: Debug logging disabled."])
            return
        end

        if mode == "clear" then
            debugDB.entries = {}
            print(L["Preydator: Debug log cleared."])
            return
        end

        if mode == "show" or mode == "" then
            local total = #debugDB.entries
            if total == 0 then
                print(L["Preydator: Debug log is empty."])
                return
            end

            local fromIndex = math.max(1, total - 19)
            print("Preydator: Debug log (last " .. (total - fromIndex + 1) .. " of " .. total .. ")")
            for index = fromIndex, total do
                print("  " .. debugDB.entries[index])
            end
            return
        end

        print(L["Preydator: debug commands are 'debug on', 'debug off', 'debug show', 'debug clear'."])
        return
    end

    if text == "show" then
        state.forceShowBar = true
        settings.forceShowBar = true
        UpdateBarDisplay()
        print(L["Preydator: Progress bar forced visible."])
        return
    end

    if text == "hide" then
        state.forceShowBar = false
        settings.forceShowBar = false
        UpdateBarDisplay()
        print(L["Preydator: Progress bar auto mode restored."])
        return
    end

    if text == "toggle" then
        state.forceShowBar = not state.forceShowBar
        settings.forceShowBar = state.forceShowBar
        UpdateBarDisplay()
        print("Preydator: Progress bar force show = " .. tostring(state.forceShowBar))
        return
    end

    if text == "options" or text == "open" then
        OpenOptionsPanel()
        return
    end

    if text == "mem" or text == "memory" then
        PrintMemoryUsage()
        return
    end

    local moduleHandled = false
    for _, module in pairs(Preydator.modules or {}) do
        local hook = module and module.OnSlashCommand
        if type(hook) == "function" then
            local ok, handled = pcall(hook, module, text, rest, trimmed)
            if ok and handled == true then
                moduleHandled = true
                break
            end
        end
    end

    if moduleHandled then
        return
    end

    print("Preydator commands: options | show | hide | toggle | mem | debug <on|off|show|clear> | inspect[ bug|both] | inspectquest [questID] [bug|both]")
end

frame:SetScript("OnEvent", function(_, event, arg1, arg2)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        OnAddonLoaded()
        EnsureOptionsPanel()
        SlashCmdList["PREYDATOR"] = HandleSlashCommand
        return
    end

    if event == "ADDON_LOADED" then
        return
    end

    if event == "PLAYER_LOGIN"
        or event == "PLAYER_ENTERING_WORLD"
        or event == "ZONE_CHANGED"
        or event == "ZONE_CHANGED_INDOORS"
        or event == "ZONE_CHANGED_NEW_AREA" then
        state.zoneCacheDirty = true
        if event == "PLAYER_ENTERING_WORLD" and UI.barFrame then
            ApplyBarSettings()
        end
    end

    -- Gate module fanout for noisy UI widget events when no prey context exists.
    -- Keep this lazy so non-noisy events do not pay quest/cache costs.
    local isNoisyEvent = event == "UPDATE_UI_WIDGET" or event == "UPDATE_ALL_UI_WIDGETS"
    local now
    if isNoisyEvent then
        now = GetTime and GetTime() or 0
        local hasPreyContext = state.activeQuestID or (now < (state.killStageUntil or 0))
        local outOfZoneQuestIdle = IsValidQuestID(state.activeQuestID)
            and state.inPreyZone ~= true
            and not (now < (state.killStageUntil or 0))
            and not (now < (state.ambushAlertUntil or 0))
        if hasPreyContext and not outOfZoneQuestIdle then
            RunModuleHook("OnEvent", event, arg1, arg2)
        end
    else
        RunModuleHook("OnEvent", event, arg1, arg2)
    end

    if event == "PLAYER_LOGIN" then
        local custV2 = Preydator:GetModule("CustomizationStateV2")
        local barEnabled = true
        if custV2 and type(custV2.IsModuleEnabled) == "function" then
            barEnabled = custV2:IsModuleEnabled("bar") == true
        end
        if barEnabled then
            EnsureBar()
            ApplyBarSettings()
            UpdateBarDisplay()
        end
        Preydator:SetPollingActive(Preydator:ShouldUseActivePolling())
        return
    end

    if event == "CHAT_MSG_SYSTEM" or event == "CHAT_MSG_MONSTER_SAY" or event == "CHAT_MSG_MONSTER_YELL" or event == "CHAT_MSG_MONSTER_EMOTE" or event == "RAID_BOSS_EMOTE" then
        if ShouldScanAmbushChat() and IsAmbushSystemMessage(arg1, arg2) then
            TriggerAmbushAlert(arg1, event)
        end
        return
    end

    if event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" or event == "QUEST_DETAIL" or event == "QUEST_ACCEPTED" then
        ArmQuestListenBurst()
    end

    if event == "QUEST_TURNED_IN" and state.activeQuestID and arg1 == state.activeQuestID then
        state.killStageUntil = (GetTime and GetTime() or 0) + 8
        state.progressState = PREY_PROGRESS_FINAL
        state.progressPercent = 100
        UpdateBarDisplay()
        Preydator:SetPollingActive(true)
    end

    now = now or (GetTime and GetTime() or 0)
    local livePreyQuestID = GetCurrentActivePreyQuestCached(isNoisyEvent and ACTIVE_PREY_QUEST_CACHE_SECONDS or 0)

    if not (((state.killStageUntil or 0) > now)
        or ((state.ambushAlertUntil or 0) > now)
        or ((state.questListenUntil or 0) > now)
        or IsValidQuestID(state.activeQuestID)
        or IsValidQuestID(livePreyQuestID)) then
        return
    end

    if isNoisyEvent
        and IsValidQuestID(state.activeQuestID)
        and state.inPreyZone ~= true
        and not ((state.killStageUntil or 0) > now)
        and not ((state.ambushAlertUntil or 0) > now) then
        return
    end

    UpdatePreyState()
    Preydator:SetPollingActive(Preydator:ShouldUseActivePolling())
end)

frame:RegisterEvent("ADDON_LOADED")
