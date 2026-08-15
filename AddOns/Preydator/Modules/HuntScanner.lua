---@diagnostic disable

local _, addonTable = ...
local Preydator = _G.Preydator or addonTable
local L = _G.PreydatorL or setmetatable({}, { __index = function(_, k) return k end })

local HuntScannerModule = {}
Preydator:RegisterModule("HuntScanner", HuntScannerModule)

local C_GossipInfo = _G.C_GossipInfo
local C_PlayerInteractionManager = _G.C_PlayerInteractionManager
local C_QuestLog = _G.C_QuestLog
local CreateFrame = _G.CreateFrame
local C_Timer = _G.C_Timer
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local UnitName = _G.UnitName
local UnitLevel = _G.UnitLevel
local GetRealmName = _G.GetRealmName
local IsInInstance = _G.IsInInstance
local UIParent = _G.UIParent
local GetQuestID = _G.GetQuestID
local GetTitleText = _G.GetTitleText
local GetObjectiveText = _G.GetObjectiveText
local GetNumQuestChoices = _G.GetNumQuestChoices
local HookSecureFunc = _G.hooksecurefunc
local HideUIPanel = _G.HideUIPanel
local geterrorhandler = _G.geterrorhandler
local strsplit = _G.strsplit
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type
local table = _G.table
local wipe = _G.wipe
local ipairs = _G.ipairs
local pairs = _G.pairs
local pcall = _G.pcall
local print = _G.print
local string = _G.string
local math = _G.math
local date = _G.date

local HUNT_TABLE_NPC_IDS = {
    [245824] = true,
    [246231] = true,
}
local HUNT_TABLE_CONTROLLER_SPELL_ID = 1271464
local ADVENTURE_PIN_POOL_TEMPLATE = "AdventureMap_QuestOfferPinTemplate"
local REWARD_STABLE_POLLS = 3
local REWARD_POLL_INTERVAL = 0.10
local REWARD_TIMEOUT_SECONDS = 4.0
local REWARD_MAX_EMPTY_RETRIES = 2
local REWARD_MIN_STABLE_SECONDS = 0.50

local panelFrame
local panelRows = {}
local lastSnapshot
local recentEvents = {}
local isHandlingSnapshot = false
local lastRichSnapshot
local snapshotSequence = 0
local lastInteractionType = nil
local missionHooksApplied = false
local liveHunts = {}
local huntByQuestID = {}
local rewardCache = {}
local difficultyRewardCache = {}
local rewardRetryCount = {}
local rewardWarmCancel = nil
local lastDebugPayload = nil
local lastOpenQuestID = nil
local lastOpenAt = 0
local lastObservedPreyQuestID = nil
local lastObservedPreyStage = nil
local lastAvailabilityNotifyKey = nil
local panelRowHeight = 52
local panelScrollViewport
local panelScrollContent
local panelScrollBar
local DIFFICULTY_NORMAL = "normal"
local DIFFICULTY_HARD = "hard"
local DIFFICULTY_NIGHTMARE = "nightmare"
local availabilityCache = {
    normal = 0,
    hard = 0,
    nightmare = 0,
    capturedAt = 0,
}
local availabilityTouched = false
local huntInteractionActive = false
local questZoneCache = {}
local questCoords = {}
local cachedAdventureMapID = nil
local queueDebounceUntil = 0
local SNAPSHOT_QUEUE_DEBOUNCE_SECONDS = 0.15

local HandleInteractionSnapshot
local QueueInteractionSnapshotPasses
local HidePanel
local GetSettings
local IsInRestrictedInstance
local huntEventFrame
local noisyEventsRegistered = false
local IsMissionFrameVisible
local IsOptionsPreviewVisible
local HasActivePreyQuest
local IsHuntRuntimeEnabled

local function SetNoisyEventSubscriptions(enabled)
    if not huntEventFrame then
        return
    end

    local shouldEnable = enabled == true
    if shouldEnable == noisyEventsRegistered then
        return
    end

    noisyEventsRegistered = shouldEnable
    if shouldEnable then
        huntEventFrame:RegisterEvent("QUEST_LOG_UPDATE")
        huntEventFrame:RegisterEvent("UPDATE_UI_WIDGET")
        huntEventFrame:RegisterEvent("UPDATE_ALL_UI_WIDGETS")
    else
        huntEventFrame:UnregisterEvent("QUEST_LOG_UPDATE")
        huntEventFrame:UnregisterEvent("UPDATE_UI_WIDGET")
        huntEventFrame:UnregisterEvent("UPDATE_ALL_UI_WIDGETS")
    end
end

local function SyncNoisyEventSubscriptions()
    if not IsHuntRuntimeEnabled() then
        SetNoisyEventSubscriptions(false)
        return
    end

    if IsInRestrictedInstance() and not IsOptionsPreviewVisible() then
        SetNoisyEventSubscriptions(false)
        return
    end

    local enabled = IsMissionFrameVisible()
        or huntInteractionActive
        or IsOptionsPreviewVisible()
        or HasActivePreyQuest()
    SetNoisyEventSubscriptions(enabled)
end

local function SafeToString(value)
    local ok, result = pcall(tostring, value)
    if ok and type(result) == "string" then
        return result
    end

    if type(value) == "string" then
        return "<protected string>"
    end

    return "<unprintable>"
end

local function SafeToNumber(value)
    local ok, result = pcall(tonumber, value)
    if ok and type(result) == "number" then
        return result
    end

    return nil
end

local function SafeFindLiteral(text, needle)
    if type(text) ~= "string" or text == "" or type(needle) ~= "string" or needle == "" then
        return false
    end

    local ok, startPos = pcall(string.find, text, needle, 1, true)
    return ok and startPos ~= nil
end

local function GetGossipOptionsSafe()
    if not (C_GossipInfo and type(C_GossipInfo.GetOptions) == "function") then
        return {}
    end

    local ok, options = pcall(C_GossipInfo.GetOptions)
    if ok and type(options) == "table" then
        return options
    end

    return {}
end

IsInRestrictedInstance = function()
    if type(IsInInstance) ~= "function" then
        return false
    end
    local ok, inInstance, instanceType = pcall(IsInInstance)
    if not ok then
        return false
    end
    if not inInstance then
        return false
    end
    return instanceType == "pvp"
        or instanceType == "arena"
        or instanceType == "party"
        or instanceType == "raid"
        or instanceType == "scenario"
        or instanceType == "delve"
end

IsOptionsPreviewVisible = function()
    local settings = GetSettings()
    if not settings then
        return false
    end
    if settings.huntScannerPreviewInOptions ~= true and settings.themeEditorPreviewInOptions ~= true then
        return false
    end

    local settingsModule = Preydator and Preydator.GetModule and Preydator:GetModule("Settings")
    local panel = settingsModule and settingsModule.optionsPanel
    return panel and panel.IsVisible and panel:IsVisible() == true
end

local function BuildPreviewRows()
    return {
        {
            questID = nil,
            title = L["Preview: Normal Hunt"],
            reward = "1,250 " .. L["Experience"] .. " | " .. L["50 Anguish | Preview Cache Reward"],
            canAccept = false,
        },
        {
            questID = nil,
            title = L["Preview: Hard Hunt"],
            reward = L["62 Anguish | 1 Voidlight Marl | Preview Trinket"],
            canAccept = false,
        },
        {
            questID = nil,
            title = L["Preview: Nightmare Hunt"],
            reward = L["78 Anguish | 1 Champ. Crest | Preview Weapon"],
            canAccept = false,
        },
    }
end

local THEME_PRESETS = {
    light = {
        section = { 0.87, 0.84, 0.79, 0.94 },
        row = { 0.95, 0.93, 0.90, 0.95 },
        rowAlt = { 0.90, 0.87, 0.83, 0.95 },
        border = { 0.27, 0.24, 0.19, 1.00 },
        header = { 0.78, 0.72, 0.64, 0.96 },
        title = { 0.12, 0.10, 0.08, 1.00 },
        text = { 0.10, 0.09, 0.07, 1.00 },
        muted = { 0.28, 0.25, 0.21, 1.00 },
        season = { 0.13, 0.34, 0.67, 1.00 },
        fontKey = "frizqt",
    },
    brown = {
        section = { 0.08, 0.06, 0.03, 0.92 },
        row = { 0.14, 0.11, 0.06, 0.92 },
        rowAlt = { 0.10, 0.08, 0.05, 0.92 },
        border = { 0.78, 0.62, 0.20, 0.95 },
        header = { 0.21, 0.15, 0.06, 1.00 },
        title = { 1.00, 0.82, 0.00, 1.00 },
        text = { 1.00, 1.00, 1.00, 1.00 },
        muted = { 0.74, 0.70, 0.60, 1.00 },
        season = { 0.60, 0.80, 1.00, 1.00 },
        fontKey = "frizqt",
    },
    dark = {
        section = { 0.07, 0.07, 0.09, 0.92 },
        row = { 0.14, 0.14, 0.16, 0.92 },
        rowAlt = { 0.11, 0.11, 0.13, 0.92 },
        border = { 0.30, 0.30, 0.35, 0.90 },
        header = { 0.18, 0.18, 0.22, 1.00 },
        title = { 1.00, 0.82, 0.00, 1.00 },
        text = { 1.00, 1.00, 1.00, 1.00 },
        muted = { 0.65, 0.65, 0.70, 1.00 },
        season = { 0.60, 0.80, 1.00, 1.00 },
        fontKey = "frizqt",
    },
    deuteranopia = {
        section = { 0.06, 0.07, 0.14, 0.92 },
        row = { 0.10, 0.12, 0.22, 0.92 },
        rowAlt = { 0.08, 0.09, 0.17, 0.92 },
        border = { 0.90, 0.60, 0.10, 0.95 },
        header = { 0.14, 0.16, 0.30, 1.00 },
        title = { 1.00, 0.74, 0.00, 1.00 },
        text = { 1.00, 1.00, 1.00, 1.00 },
        muted = { 0.65, 0.68, 0.84, 1.00 },
        season = { 0.35, 0.65, 1.00, 1.00 },
        fontKey = "frizqt",
    },
    protanopia = {
        section = { 0.03, 0.10, 0.13, 0.92 },
        row = { 0.06, 0.16, 0.20, 0.92 },
        rowAlt = { 0.04, 0.12, 0.16, 0.92 },
        border = { 0.00, 0.72, 0.82, 0.95 },
        header = { 0.08, 0.20, 0.26, 1.00 },
        title = { 0.00, 0.88, 1.00, 1.00 },
        text = { 1.00, 1.00, 1.00, 1.00 },
        muted = { 0.50, 0.74, 0.80, 1.00 },
        season = { 1.00, 0.86, 0.00, 1.00 },
        fontKey = "frizqt",
    },
}

local THEME_COLOR_KEYS = { "section", "row", "rowAlt", "border", "header", "title", "text", "muted", "season" }
local FONT_PATHS = {
    frizqt = "Fonts\\FRIZQT__.TTF",
    arialn = "Fonts\\ARIALN.TTF",
    skurri = "Fonts\\skurri.ttf",
    morpheus = "Fonts\\MORPHEUS.TTF",
}

local function CopyThemeColors(source, fallback)
    local out = {}
    for _, key in ipairs(THEME_COLOR_KEYS) do
        local color = source and source[key]
        if type(color) ~= "table" then
            color = fallback and fallback[key]
        end
        if type(color) == "table" then
            out[key] = {
                tonumber(color[1]) or 1,
                tonumber(color[2]) or 1,
                tonumber(color[3]) or 1,
                tonumber(color[4]) or 1,
            }
        else
            out[key] = { 1, 1, 1, 1 }
        end
    end
    out.fontKey = type(source and source.fontKey) == "string" and source.fontKey
        or type(fallback and fallback.fontKey) == "string" and fallback.fontKey
        or "frizqt"
    return out
end

local function ResolveThemeValue(key, settings)
    local preset = THEME_PRESETS[key]
    if preset then
        return CopyThemeColors(preset, THEME_PRESETS.brown)
    end

    local custom = settings and settings.customThemes and settings.customThemes[key]
    if type(custom) == "table" then
        return CopyThemeColors(custom, THEME_PRESETS.brown)
    end

    return CopyThemeColors(THEME_PRESETS.brown, THEME_PRESETS.brown)
end

local function GetThemeFontPath(theme)
    local fontKey = theme and theme.fontKey
    return FONT_PATHS[fontKey] or FONT_PATHS.frizqt
end

GetSettings = function()
    local api = Preydator and Preydator.API
    if not api or type(api.GetSettings) ~= "function" then
        return nil
    end
    return api.GetSettings()
end

local function IsHuntModuleEnabled()
    local customizationV2 = Preydator and Preydator.GetModule and Preydator:GetModule("CustomizationStateV2")
    if customizationV2 and type(customizationV2.IsModuleEnabled) == "function" then
        return customizationV2:IsModuleEnabled("hunt") == true
    end
    return true
end

IsHuntRuntimeEnabled = function()
    if not IsHuntModuleEnabled() then
        return false
    end

    local settings = GetSettings()
    if not settings then
        return false
    end

    return settings.huntScannerEnabled ~= false
end

local function EnsureSettings()
    local settings = GetSettings()
    if not settings then
        return
    end

    if settings.huntScannerEnabled == nil then
        settings.huntScannerEnabled = true
    end

    if settings.huntScannerSide ~= "left" and settings.huntScannerSide ~= "right" then
        settings.huntScannerSide = "right"
    end

    if settings.huntScannerMatchCurrencyTheme == nil then
        settings.huntScannerMatchCurrencyTheme = true
    end

    if settings.huntScannerUseCurrencyTheme == nil then
        settings.huntScannerUseCurrencyTheme = settings.huntScannerMatchCurrencyTheme ~= false
    end

    if type(settings.huntScannerTheme) ~= "string" or settings.huntScannerTheme == "" then
        settings.huntScannerTheme = settings.currencyTheme or "brown"
    end

    if settings.huntScannerPreviewInOptions == nil then
        settings.huntScannerPreviewInOptions = false
    end

    if settings.huntScannerShowRewardIcons == nil then
        settings.huntScannerShowRewardIcons = true
    end

    if settings.themeEditorPreviewInOptions == nil then
        settings.themeEditorPreviewInOptions = false
    end

    if settings.huntScannerGroupBy ~= "none" and settings.huntScannerGroupBy ~= "difficulty" and settings.huntScannerGroupBy ~= "zone" then
        settings.huntScannerGroupBy = "difficulty"
    end

    if settings.huntScannerSortBy ~= "difficulty" and settings.huntScannerSortBy ~= "zone" and settings.huntScannerSortBy ~= "title" then
        settings.huntScannerSortBy = "zone"
    end

    if settings.huntScannerSortDir ~= "asc" and settings.huntScannerSortDir ~= "desc" then
        settings.huntScannerSortDir = "asc"
    end

    if settings.huntScannerAnchorAlign ~= "top" and settings.huntScannerAnchorAlign ~= "middle" and settings.huntScannerAnchorAlign ~= "bottom" then
        settings.huntScannerAnchorAlign = "top"
    end

    if type(settings.huntScannerCollapsedGroups) ~= "table" then
        settings.huntScannerCollapsedGroups = {}
    end

    settings.huntScannerWidth = math.max(280, math.min(620, tonumber(settings.huntScannerWidth) or 336))
    settings.huntScannerHeight = math.max(320, math.min(900, tonumber(settings.huntScannerHeight) or 460))
    settings.huntScannerFontSize = math.max(10, math.min(24, tonumber(settings.huntScannerFontSize) or 12))
    settings.huntScannerScale = math.max(0.70, math.min(1.60, tonumber(settings.huntScannerScale) or 1.00))
end

local function GetRewardScopeKey()
    local name = UnitName and UnitName("player") or "unknown"
    local realm = GetRealmName and GetRealmName() or "unknown"
    local level = UnitLevel and UnitLevel("player") or 0
    return tostring(name) .. "-" .. tostring(realm) .. "@" .. tostring(level)
end

local function GetPanelConfig()
    local settings = GetSettings()
    local width = math.max(280, math.min(620, tonumber(settings and settings.huntScannerWidth) or 336))
    local height = math.max(320, math.min(900, tonumber(settings and settings.huntScannerHeight) or 460))
    local fontSize = math.max(10, math.min(24, tonumber(settings and settings.huntScannerFontSize) or 12))
    local scale = math.max(0.70, math.min(1.60, tonumber(settings and settings.huntScannerScale) or 1.00))
    return width, height, fontSize, scale
end

local function GetTheme()
    local settings = GetSettings()

    if settings and settings.themeEditorPreviewInOptions == true and type(settings.themeEditorColors) == "table" then
        local baseKey = settings.themeEditorLoadKey or "brown"
        local baseTheme = ResolveThemeValue(baseKey, settings)
        local previewTheme = CopyThemeColors(settings.themeEditorColors, baseTheme)
        previewTheme.fontKey = settings.themeEditorFontKey or baseTheme.fontKey or "frizqt"
        return previewTheme
    end

    local useCurrencyTheme = not settings or settings.huntScannerUseCurrencyTheme ~= false
    local key = useCurrencyTheme and (settings and settings.currencyTheme or "brown") or (settings and settings.huntScannerTheme or "brown")
    return ResolveThemeValue(key, settings)
end

local function GetCoreState()
    local api = Preydator and Preydator.API
    if not api or type(api.GetState) ~= "function" then
        return nil
    end
    return api.GetState()
end

local function GetRewardStorage()
    _G.PreydatorDB = _G.PreydatorDB or {}
    _G.PreydatorDB.huntScanner = _G.PreydatorDB.huntScanner or {}

    local storage = _G.PreydatorDB.huntScanner
    storage.rewardCache = storage.rewardCache or {}
    storage.difficultyRewardCache = storage.difficultyRewardCache or {}
    storage.questDifficultyByID = storage.questDifficultyByID or {}
    storage.availabilityCacheByScope = storage.availabilityCacheByScope or {}
    storage.availabilityTouchedByScope = storage.availabilityTouchedByScope or {}

    return storage
end

local function SanitizeAvailabilityCounts(source)
    if type(source) ~= "table" then
        return {
            normal = 0,
            hard = 0,
            nightmare = 0,
            capturedAt = 0,
        }
    end

    return {
        normal = math.max(0, tonumber(source.normal) or 0),
        hard = math.max(0, tonumber(source.hard) or 0),
        nightmare = math.max(0, tonumber(source.nightmare) or 0),
        capturedAt = math.max(0, tonumber(source.capturedAt) or 0),
    }
end

local function SaveAvailabilityCache()
    local storage = GetRewardStorage()
    local scopeKey = GetRewardScopeKey()
    storage.availabilityCacheByScope[scopeKey] = SanitizeAvailabilityCounts(availabilityCache)
    storage.availabilityTouchedByScope[scopeKey] = availabilityTouched == true
end

local function LoadAvailabilityCache()
    local storage = GetRewardStorage()
    local scopeKey = GetRewardScopeKey()
    availabilityCache = SanitizeAvailabilityCounts(storage.availabilityCacheByScope[scopeKey])
    availabilityTouched = storage.availabilityTouchedByScope[scopeKey] == true
end

local function GetDifficultyDisplayName(canonicalDifficulty)
    if canonicalDifficulty == DIFFICULTY_HARD then
        return L["Hard"]
    elseif canonicalDifficulty == DIFFICULTY_NIGHTMARE then
        return L["Nightmare"]
    end

    return L["Normal"]
end

local function NormalizeDifficultyKey(value)
    if type(value) ~= "string" or value == "" then
        return DIFFICULTY_NORMAL
    end

    if value == DIFFICULTY_NORMAL or value == DIFFICULTY_HARD or value == DIFFICULTY_NIGHTMARE then
        return value
    end

    if value == L["Nightmare"] or value == "Nightmare" then
        return DIFFICULTY_NIGHTMARE
    end

    if value == L["Hard"] or value == "Hard" then
        return DIFFICULTY_HARD
    end

    return DIFFICULTY_NORMAL
end

local function MarkAvailabilityTouched()
    if availabilityTouched then
        return
    end

    availabilityTouched = true
    SaveAvailabilityCache()
end

local function UpdateAvailabilityCacheFromHunts(hunts)
    local counts = {
        normal = 0,
        hard = 0,
        nightmare = 0,
        capturedAt = GetTime and (tonumber(GetTime()) or 0) or 0,
    }

    for _, hunt in ipairs(hunts or {}) do
        local questID = tonumber(hunt and hunt.questID)
        if questID and questID > 0 then
            local isOnQuest = C_QuestLog and type(C_QuestLog.IsOnQuest) == "function" and C_QuestLog.IsOnQuest(questID) == true
            if not isOnQuest then
                local difficulty = NormalizeDifficultyKey(hunt and hunt.difficulty)
                if difficulty == DIFFICULTY_NIGHTMARE then
                    counts[DIFFICULTY_NIGHTMARE] = counts[DIFFICULTY_NIGHTMARE] + 1
                elseif difficulty == DIFFICULTY_HARD then
                    counts[DIFFICULTY_HARD] = counts[DIFFICULTY_HARD] + 1
                else
                    counts[DIFFICULTY_NORMAL] = counts[DIFFICULTY_NORMAL] + 1
                end
            end
        end
    end

    availabilityCache = SanitizeAvailabilityCounts(counts)
    SaveAvailabilityCache()
end

local function NotifyCurrencyTrackerAvailabilityChanged()
    local counts = HuntScannerModule:GetAvailabilityCounts()
    local key = tostring(counts.normal) .. "/" .. tostring(counts.hard) .. "/" .. tostring(counts.nightmare)
    if key == lastAvailabilityNotifyKey then
        return
    end

    lastAvailabilityNotifyKey = key
    local tracker = Preydator and Preydator.GetModule and Preydator:GetModule("CurrencyTracker")
    if tracker and type(tracker.QueueRefreshSweep) == "function" then
        tracker:QueueRefreshSweep("HUNT_SCANNER_AVAILABILITY")
    end
end

local function CopyStringList(list)
    local out = {}
    if type(list) ~= "table" then
        return out
    end

    for index, value in ipairs(list) do
        out[index] = tostring(value)
    end
    return out
end

local function GetRewardDayKey()
    if type(date) ~= "function" then
        return "unknown"
    end
    return tostring(date("%Y-%m-%d"))
end

local function SaveRewardCaches()
    local storage = GetRewardStorage()
    storage.lastRewardDay = GetRewardDayKey()

    local storedQuestRewards = {}
    for questID, rewards in pairs(rewardCache) do
        if type(questID) == "number" and type(rewards) == "table" then
            storedQuestRewards[tostring(questID)] = CopyStringList(rewards)
        end
    end
    storage.rewardCache = storedQuestRewards

    local storedDifficultyRewards = {}
    for difficulty, rewards in pairs(difficultyRewardCache) do
        if type(difficulty) == "string" and type(rewards) == "table" then
            storedDifficultyRewards[difficulty] = CopyStringList(rewards)
        end
    end
    storage.difficultyRewardCache = storedDifficultyRewards

    storage.questDifficultyByID = storage.questDifficultyByID or {}
    for questID, difficulty in pairs(huntByQuestID) do
        if type(questID) == "number" and type(difficulty) == "table" and type(difficulty.difficulty) == "string" then
            storage.questDifficultyByID[tostring(questID)] = difficulty.difficulty
        end
    end

    SaveAvailabilityCache()
end

local function ClearAllRewardCaches()
    if wipe then
        wipe(rewardCache)
        wipe(difficultyRewardCache)
    else
        for key in pairs(rewardCache) do
            rewardCache[key] = nil
        end
        for key in pairs(difficultyRewardCache) do
            difficultyRewardCache[key] = nil
        end
    end
    SaveRewardCaches()
end

local function ClearRewardCacheForDifficulty(difficulty)
    if type(difficulty) ~= "string" or difficulty == "" then
        return
    end

    difficultyRewardCache[difficulty] = nil
    for questID, hunt in pairs(huntByQuestID) do
        if type(hunt) == "table" and hunt.difficulty == difficulty then
            rewardCache[questID] = nil
        end
    end

    local storage = GetRewardStorage()
    if type(storage.questDifficultyByID) == "table" then
        for questIDText, storedDifficulty in pairs(storage.questDifficultyByID) do
            if storedDifficulty == difficulty then
                local questID = SafeToNumber(questIDText)
                if questID then
                    rewardCache[questID] = nil
                end
            end
        end
    end

    SaveRewardCaches()
end

local function RememberQuestDifficulty(questID, difficulty)
    local id = SafeToNumber(questID)
    if not id or id < 1 or type(difficulty) ~= "string" or difficulty == "" then
        return
    end

    local storage = GetRewardStorage()
    storage.questDifficultyByID[tostring(id)] = NormalizeDifficultyKey(difficulty)
end

local function GetRememberedQuestDifficulty(questID)
    local id = SafeToNumber(questID)
    if not id or id < 1 then
        return nil
    end

    local hunt = huntByQuestID[id]
    if type(hunt) == "table" and type(hunt.difficulty) == "string" and hunt.difficulty ~= "" then
        return NormalizeDifficultyKey(hunt.difficulty)
    end

    local storage = GetRewardStorage()
    local stored = storage.questDifficultyByID and storage.questDifficultyByID[tostring(id)]
    if type(stored) == "string" and stored ~= "" then
        return NormalizeDifficultyKey(stored)
    end

    return nil
end

local function MigrateDifficultyKeysFromLocalizedToCanonical()
    -- Migrate old persisted data from localized keys (L["Normal"], L["Hard"], L["Nightmare"])
    -- to canonical keys ("normal", "hard", "nightmare")
    local storage = GetRewardStorage()
    if not storage or not storage.difficultyRewardCache then
        return
    end

    local oldCache = storage.difficultyRewardCache
    local newCache = {}
    local needsMigration = false

    for key, rewards in pairs(oldCache) do
        -- Detect if this is a localized key (L[...] returns the key name itself in non-enUS locales)
        -- or English strings. Update to canonical form.
        local canonicalKey = key
        if key == L["Normal"] or key == "Normal" then
            canonicalKey = DIFFICULTY_NORMAL
            needsMigration = needsMigration or (key ~= DIFFICULTY_NORMAL)
        elseif key == L["Hard"] or key == "Hard" then
            canonicalKey = DIFFICULTY_HARD
            needsMigration = needsMigration or (key ~= DIFFICULTY_HARD)
        elseif key == L["Nightmare"] or key == "Nightmare" then
            canonicalKey = DIFFICULTY_NIGHTMARE
            needsMigration = needsMigration or (key ~= DIFFICULTY_NIGHTMARE)
        end

        if type(rewards) == "table" then
            local existingRewards = newCache[canonicalKey]
            -- Keep the version with better rewards (higher score)
            if not existingRewards then
                newCache[canonicalKey] = CopyStringList(rewards)
            else
                local newScore = 0
                local existingScore = 0
                for _, r in ipairs(rewards) do
                    if tostring(r or "") ~= "" then newScore = newScore + 1 end
                end
                for _, r in ipairs(existingRewards) do
                    if tostring(r or "") ~= "" then existingScore = existingScore + 1 end
                end
                if newScore > existingScore then
                    newCache[canonicalKey] = CopyStringList(rewards)
                end
            end
        end
    end

    if needsMigration then
        storage.difficultyRewardCache = newCache
    end

    -- Migrate questDifficultyByID: values from localized to canonical
    if storage.questDifficultyByID then
        for questIDStr, difficulty in pairs(storage.questDifficultyByID) do
            storage.questDifficultyByID[questIDStr] = NormalizeDifficultyKey(difficulty)
        end
    end
end

local function LoadRewardCaches()
    local storage = GetRewardStorage()
    local dayKey = GetRewardDayKey()
    local scopeKey = GetRewardScopeKey()

    if storage.lastRewardDay ~= dayKey or storage.lastRewardScope ~= scopeKey then
        storage.lastRewardDay = dayKey
        storage.lastRewardScope = scopeKey
        storage.rewardCache = {}
        storage.difficultyRewardCache = {}
    end

    -- Migrate old localized keys to canonical format
    MigrateDifficultyKeysFromLocalizedToCanonical()

    if wipe then
        wipe(rewardCache)
        wipe(difficultyRewardCache)
    end

    for questIDText, rewards in pairs(storage.rewardCache or {}) do
        local questID = SafeToNumber(questIDText)
        if questID and type(rewards) == "table" then
            rewardCache[questID] = CopyStringList(rewards)
        end
    end

    for difficulty, rewards in pairs(storage.difficultyRewardCache or {}) do
        if type(difficulty) == "string" and type(rewards) == "table" then
            difficultyRewardCache[difficulty] = CopyStringList(rewards)
        end
    end

    LoadAvailabilityCache()
end

local function GetActivePreyQuestID()
    local state = GetCoreState()
    local activeQuestID = SafeToNumber(state and state.activeQuestID)
    if activeQuestID and activeQuestID > 0 then
        return activeQuestID
    end

    if C_QuestLog and type(C_QuestLog.GetActivePreyQuest) == "function" then
        local rawQuestID = C_QuestLog.GetActivePreyQuest()
        local questID = SafeToNumber(rawQuestID)
        if questID and questID > 0 then
            return questID
        end
    end

    return nil
end

local function GetActivePreyStage()
    local state = GetCoreState()
    local stage = tonumber(state and state.stage)
    if stage and stage >= 1 then
        return stage
    end

    local progressState = tonumber(state and state.progressState)
    if progressState == 0 then return 1 end
    if progressState == 1 then return 2 end
    if progressState == 2 then return 3 end
    if progressState == 3 then return 4 end
    return nil
end

HasActivePreyQuest = function()
    return GetActivePreyQuestID() ~= nil
end

local function ProcessRewardCacheLifecycle()
    local storage = GetRewardStorage()
    local dayKey = GetRewardDayKey()
    local scopeKey = GetRewardScopeKey()
    if storage.lastRewardDay ~= dayKey or storage.lastRewardScope ~= scopeKey then
        ClearAllRewardCaches()
        storage.lastRewardDay = dayKey
        storage.lastRewardScope = scopeKey
    end

    local activeQuestID = GetActivePreyQuestID()
    local activeDifficulty = activeQuestID and GetRememberedQuestDifficulty(activeQuestID) or nil

    if activeQuestID and activeDifficulty then
        RememberQuestDifficulty(activeQuestID, activeDifficulty)
    end

    lastObservedPreyQuestID = activeQuestID
    lastObservedPreyStage = GetActivePreyStage()
end

local function BlockHuntTableWhileActivePrey()
    if not HasActivePreyQuest() then
        return false
    end

    local mission = _G.CovenantMissionFrame
    if mission and mission:IsShown() and type(HideUIPanel) == "function" then
        HideUIPanel(mission)
    end
    HidePanel()

    return true
end

local function SetTextColor(fontString, color)
    if fontString and color then
        fontString:SetTextColor(color[1], color[2], color[3], color[4] or 1)
    end
end

local function ParseTargetNPCID()
    if not UnitGUID then
        return nil
    end

    local guid = UnitGUID("target")
    if type(guid) ~= "string" then
        return nil
    end

    if strsplit then
        local _, _, _, _, _, npcID = strsplit("-", guid)
        return tonumber(npcID)
    end

    local npcID = guid:match("^[^-]*%-[^-]*%-[^-]*%-[^-]*%-[^-]*%-([^-]+)")
    return tonumber(npcID)
end

local function IsHuntTableContext(options)
    local npcID = ParseTargetNPCID()
    if npcID and HUNT_TABLE_NPC_IDS[npcID] then
        return true, npcID
    end

    for _, option in ipairs(options or {}) do
        if type(option) == "table" and option.spellID == HUNT_TABLE_CONTROLLER_SPELL_ID then
            return true, npcID
        end
    end

    return false, npcID
end

local function SnapshotHasUsefulData(snapshot)
    if type(snapshot) ~= "table" then
        return false
    end

    if snapshot.npcID and HUNT_TABLE_NPC_IDS[snapshot.npcID] then
        return true
    end

    local options = snapshot.options or {}
    local detail = snapshot.questDetail or {}

    return #options > 0 or ((tonumber(detail.questID) or 0) > 0)
end

local function CopySnapshot(source)
    if type(source) ~= "table" then
        return nil
    end

    local copy = {}
    for key, value in pairs(source) do
        copy[key] = value
    end
    return copy
end

local function BuildRewardSummary(questID)
    local function BuildIconTag(icon)
        if type(icon) == "number" and icon > 0 then
            return "|T" .. tostring(icon) .. ":14:14:0:0|t "
        end
        if type(icon) == "string" and icon ~= "" then
            return "|T" .. icon .. ":14:14:0:0|t "
        end
        return ""
    end

    local function RewardScore(list)
        if type(list) ~= "table" then
            return 0
        end

        local score = 0
        for _, text in ipairs(list) do
            local value = tostring(text or "")
            if value ~= "" then
                score = score + 1
                if not value:find(" XP", 1, true) then
                    score = score + 10
                end
            end
        end

        return score
    end

    local function StripIconTags(text)
        if type(text) ~= "string" then
            return ""
        end

        return (text:gsub("|T[^|]+|t%s*", ""))
    end

    local function ListHasRewardIcons(list)
        if type(list) ~= "table" then
            return false
        end

        for _, entry in ipairs(list) do
            local text = tostring(entry or "")
            if text:find("|T", 1, true) then
                return true
            end
        end

        return false
    end

    local function FormatRewardList(list, showIcons)
        if type(list) ~= "table" then
            return ""
        end

        local entries = {}
        for _, entry in ipairs(list) do
            local text = tostring(entry or "")
            if text ~= "" then
                if not showIcons then
                    text = StripIconTags(text)
                end
                entries[#entries + 1] = text
            end
        end

        return table.concat(entries, ", ")
    end

    local function BuildQuestCurrencyRewardList(id)
        local rewards = {}

        if C_QuestLog and type(C_QuestLog.GetQuestRewardCurrencies) == "function" then
            local okRewardCurrencies, rewardCurrencies = pcall(C_QuestLog.GetQuestRewardCurrencies, id)
            if not okRewardCurrencies then
                rewardCurrencies = nil
            end
            if type(rewardCurrencies) == "table" and #rewardCurrencies > 0 and type(C_QuestLog.GetQuestRewardCurrencyInfo) == "function" then
                for index = 1, #rewardCurrencies do
                    local okInfo, info = pcall(C_QuestLog.GetQuestRewardCurrencyInfo, id, index, false)
                    if not okInfo then
                        info = nil
                    end
                    if type(info) == "table" then
                        local amount = SafeToNumber(info.quantity)
                            or SafeToNumber(info.totalRewardAmount)
                            or SafeToNumber(info.numCurrency)
                            or 0
                        local currencyID = SafeToNumber(info.currencyID)
                        local name = SafeToString(info.name)
                        if name == "<protected string>" or name == "<unprintable>" or name == "" then
                            name = SafeToString(info.currencyName)
                        end
                        if (name == "<protected string>" or name == "<unprintable>" or name == "") and currencyID then
                            name = "Currency " .. tostring(currencyID)
                        end
                        if name == "<protected string>" or name == "<unprintable>" or name == "" then
                            name = nil
                        end
                        local icon = info.iconFileID or info.icon or info.textureFileID or info.iconTexture or info.texture
                        local iconTag = BuildIconTag(icon)
                        if name and amount > 0 then
                            rewards[#rewards + 1] = iconTag .. tostring(amount) .. " " .. tostring(name)
                        elseif name then
                            rewards[#rewards + 1] = iconTag .. tostring(name)
                        end
                    end
                end
            end
        end

        return rewards
    end

    local settings = GetSettings() or {}
    local showRewardIcons = settings.huntScannerShowRewardIcons ~= false

    if type(questID) ~= "number" or questID < 1 then
        return L["Rewards unknown"]
    end

    local cached = rewardCache[questID]
    if type(cached) == "table" then
        local difficulty = GetRememberedQuestDifficulty(questID)
        local sharedRewards = difficulty and difficultyRewardCache[difficulty] or nil
        if type(sharedRewards) == "table" and RewardScore(sharedRewards) > RewardScore(cached) then
            cached = CopyStringList(sharedRewards)
            rewardCache[questID] = cached
            SaveRewardCaches()
        end

        if showRewardIcons and not ListHasRewardIcons(cached) then
            local upgraded = BuildQuestCurrencyRewardList(questID)
            if #upgraded > 0 then
                cached = upgraded
                rewardCache[questID] = CopyStringList(upgraded)
                SaveRewardCaches()
            else
                rewardCache[questID] = nil
                SaveRewardCaches()
            end
        end

        if #cached > 0 then
            return FormatRewardList(cached, showRewardIcons)
        end
        return L["No tracked rewards"]
    end

    local difficulty = GetRememberedQuestDifficulty(questID)
    local sharedRewards = difficulty and difficultyRewardCache[difficulty] or nil
    if type(sharedRewards) == "table" then
        local effectiveRewards = sharedRewards
        if showRewardIcons and not ListHasRewardIcons(sharedRewards) then
            local upgraded = BuildQuestCurrencyRewardList(questID)
            if #upgraded > 0 then
                effectiveRewards = upgraded
            else
                rewardCache[questID] = nil
            end
        end

        rewardCache[questID] = CopyStringList(effectiveRewards)
        SaveRewardCaches()
        if #effectiveRewards > 0 then
            return FormatRewardList(effectiveRewards, showRewardIcons)
        end
        return L["No tracked rewards"]
    end

    local rewards = BuildQuestCurrencyRewardList(questID)

    if #rewards == 0 then
        return L["Reward data pending"]
    end

    rewardCache[questID] = CopyStringList(rewards)
    SaveRewardCaches()
    return FormatRewardList(rewards, showRewardIcons)
end

IsMissionFrameVisible = function()
    local frame = _G.CovenantMissionFrame
    return frame and frame:IsShown() == true
end

local function HasVisibleHuntAnchor()
    if IsMissionFrameVisible() then
        return true
    end

    if _G.GossipFrame and _G.GossipFrame.IsShown and _G.GossipFrame:IsShown() then
        return true
    end

    if _G.QuestFrame and _G.QuestFrame.IsShown and _G.QuestFrame:IsShown() then
        return true
    end

    return false
end

local function ParseDifficulty(description)
    if type(description) ~= "string" then
        return DIFFICULTY_NORMAL
    end

    if SafeFindLiteral(description, "Nightmare") or SafeFindLiteral(description, L["Nightmare"]) then
        return DIFFICULTY_NIGHTMARE
    end

    if SafeFindLiteral(description, "Hard") or SafeFindLiteral(description, L["Hard"]) then
        return DIFFICULTY_HARD
    end

    if SafeFindLiteral(description, "Normal") or SafeFindLiteral(description, L["Normal"]) then
        return DIFFICULTY_NORMAL
    end

    return DIFFICULTY_NORMAL
end

local function InferZoneFromCoords(x, y)
    if type(x) ~= "number" or type(y) ~= "number" then
        return nil
    end

    if x > 0.70 then
        return L["Harandar"]
    end

    if x > 0.40 and y < 0.40 then
        return L["Voidstorm"]
    end

    if y > 0.55 then
        return L["Zul'Aman"]
    end

    return "Eversong Woods"
end

local function GetAdventureMapID()
    local mission = _G.CovenantMissionFrame
    local mapTab = mission and mission.MapTab
    if not mapTab then
        return nil
    end
    local sc = mapTab.ScrollContainer
    if sc and type(sc.GetMapID) == "function" then
        return sc:GetMapID()
    end
    local mc = mapTab.MapCanvas
    if mc and type(mc.GetMapID) == "function" then
        return mc:GetMapID()
    end
    return nil
end

local function GetAdventurePinPool()
    local mission = _G.CovenantMissionFrame
    local mapTab = mission and mission.MapTab
    local pinPools = mapTab and mapTab.pinPools
    return pinPools and pinPools[ADVENTURE_PIN_POOL_TEMPLATE]
end

local function FindPinByQuestID(questID)
    local pool = GetAdventurePinPool()
    if not pool then
        return nil
    end

    for pin in pool:EnumerateActive() do
        if tonumber(pin and pin.questID) == questID then
            return pin
        end
    end

    return nil
end

local function OpenMapQuestDialog(questID)
    local id = SafeToNumber(questID)
    if not id or id < 1 then
        return false
    end

    local now = GetTime and GetTime() or 0
    if lastOpenQuestID == id and (now - (lastOpenAt or 0)) < 0.15 then
        return true
    end

    local dialog = _G.AdventureMapQuestChoiceDialog
    if dialog and dialog:IsShown() and lastOpenQuestID == id then
        dialog:Hide()
        local mission = _G.CovenantMissionFrame
        local mapTab = mission and mission.MapTab
        local sc = mapTab and mapTab.ScrollContainer
        local mapCanvas = mapTab and mapTab.MapCanvas
        if sc and type(sc.ResetZoom) == "function" then
            pcall(function() sc:ResetZoom() end)
        end
        if mapCanvas and type(mapCanvas.ResetZoom) == "function" then
            pcall(function() mapCanvas:ResetZoom() end)
        end
        lastOpenQuestID = nil
        lastOpenAt = 0
        return true
    end

    if HasActivePreyQuest() and GetActivePreyQuestID() ~= id then
        return false
    end

    local mission = _G.CovenantMissionFrame
    if not (mission and mission:IsShown()) then
        return false
    end

    local pin = FindPinByQuestID(id)
    if not pin then
        return false
    end

    local provider = type(pin.GetDataProvider) == "function" and pin:GetDataProvider() or nil
    if provider and type(provider.OnQuestOfferPinClicked) == "function" then
        local difficulty = GetRememberedQuestDifficulty(id)
        if difficulty then
            RememberQuestDifficulty(id, difficulty)
        end
        provider:OnQuestOfferPinClicked(pin)
        lastOpenQuestID = id
        lastOpenAt = now
        return true
    end

    if dialog and type(dialog.ShowWithQuest) == "function" then
        dialog:SetAlpha(1)
        dialog:ClearAllPoints()
        dialog:SetPoint("CENTER", mission, "CENTER")
        dialog:ShowWithQuest(mission, pin, id)
        local difficulty = GetRememberedQuestDifficulty(id)
        if difficulty then
            RememberQuestDifficulty(id, difficulty)
        end
        lastOpenQuestID = id
        lastOpenAt = now
        return true
    end

    return false
end

local function AcceptMapQuest(questID)
    local id = SafeToNumber(questID)
    if not id or id < 1 then
        return false
    end

    if HasActivePreyQuest() and GetActivePreyQuestID() ~= id then
        return false
    end

    local mission = _G.CovenantMissionFrame
    local dialog = _G.AdventureMapQuestChoiceDialog
    local pin = FindPinByQuestID(id)
    if not (mission and mission:IsShown() and dialog and type(dialog.ShowWithQuest) == "function" and type(dialog.AcceptQuest) == "function" and pin) then
        return false
    end

    local difficulty = GetRememberedQuestDifficulty(id)
    if difficulty then
        RememberQuestDifficulty(id, difficulty)
    end

    local prevAlpha = dialog:GetAlpha()
    local dialogPoint = { dialog:GetPoint(1) }
    dialog:SetAlpha(0)
    dialog:ClearAllPoints()
    dialog:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -4000, 4000)
    dialog:Hide()
    dialog:ShowWithQuest(mission, pin, id)

    local ok = pcall(function()
        dialog:AcceptQuest()
    end)
    dialog:Hide()
    dialog:SetAlpha(prevAlpha)
    if dialogPoint[1] then
        dialog:ClearAllPoints()
        dialog:SetPoint(dialogPoint[1], dialogPoint[2], dialogPoint[3], dialogPoint[4], dialogPoint[5])
    end

    lastOpenQuestID = nil
    lastOpenAt = 0
    return ok == true
end

local function RefreshHuntsFromPins()
    local pool = GetAdventurePinPool()
    if not pool then
        if wipe then
            wipe(liveHunts)
            wipe(huntByQuestID)
        else
            for i = #liveHunts, 1, -1 do
                liveHunts[i] = nil
            end
            for questID in pairs(huntByQuestID) do
                huntByQuestID[questID] = nil
            end
        end
        return liveHunts
    end

    local nextHunts = {}
    local seenQuestIDs = {}
    local previousCount = #liveHunts
    local adventureMapID = GetAdventureMapID()
    if adventureMapID then
        cachedAdventureMapID = adventureMapID
    end

    for pin in pool:EnumerateActive() do
        local questID = tonumber(pin and pin.questID)
        local title = pin and pin.title
        if questID and questID > 0 and type(title) == "string" and title ~= "" then
            seenQuestIDs[questID] = true
            local nx, ny = pin.normalizedX, pin.normalizedY
            -- Cache raw coords so zone can be resolved later even when map is closed.
            if type(nx) == "number" and type(ny) == "number" then
                questCoords[questID] = { nx = nx, ny = ny }
            end
            local zoneMapID = nil
            if (adventureMapID or cachedAdventureMapID) and C_Map and C_Map.GetMapInfoAtPosition then
                local mapForLookup = adventureMapID or cachedAdventureMapID
                local zoneInfo = C_Map.GetMapInfoAtPosition(mapForLookup, nx or 0, ny or 0)
                zoneMapID = zoneInfo and zoneInfo.mapID
            end
            if zoneMapID then
                questZoneCache[questID] = zoneMapID
            end
            nextHunts[#nextHunts + 1] = {
                questID = questID,
                title = title,
                difficulty = ParseDifficulty(pin.description),
                zone = InferZoneFromCoords(nx, ny),
                zoneMapID = zoneMapID,
            }
            RememberQuestDifficulty(questID, nextHunts[#nextHunts].difficulty)
        end
    end

    -- The mission frame pin pool can be available before pins hydrate.
    -- Keep the previous snapshot in this transient state so availability
    -- counts do not flash to zero and then rebound a few seconds later.
    if #nextHunts == 0 and previousCount > 0 and (IsMissionFrameVisible() or huntInteractionActive or IsOptionsPreviewVisible()) then
        return liveHunts
    end

    for questID in pairs(rewardCache) do
        if not seenQuestIDs[questID] then
            rewardCache[questID] = nil
            rewardRetryCount[questID] = nil
        end
    end

    if wipe then
        wipe(liveHunts)
        wipe(huntByQuestID)
    else
        for i = #liveHunts, 1, -1 do
            liveHunts[i] = nil
        end
        for questID in pairs(huntByQuestID) do
            huntByQuestID[questID] = nil
        end
    end
    for _, hunt in ipairs(nextHunts) do
        liveHunts[#liveHunts + 1] = hunt
        if type(hunt.questID) == "number" then
            huntByQuestID[hunt.questID] = hunt
            if rewardCache[hunt.questID] == nil and type(difficultyRewardCache[hunt.difficulty]) == "table" then
                rewardCache[hunt.questID] = CopyStringList(difficultyRewardCache[hunt.difficulty])
            end
        end
    end

    UpdateAvailabilityCacheFromHunts(liveHunts)

    SaveRewardCaches()

    return liveHunts
end

local function SnapshotDialogRewards()
    local dialog = _G.AdventureMapQuestChoiceDialog
    if not (dialog and dialog.rewardPool) then
        return {}, 0, 0
    end

    local function IsNumericRewardText(text)
        if type(text) ~= "string" then
            return false
        end

        local normalized = text:gsub("[%s,%.]", "")
        return normalized:match("^%d+$") ~= nil
    end

    local function NormalizeRewardName(name)
        if IsNumericRewardText(name) then
            return tostring(name) .. " XP"
        end
        return name
    end

    local function ExtractRewardIcon(reward)
        if type(reward) ~= "table" then
            return nil
        end

        local iconKeys = {
            "Icon", "icon", "IconTexture", "iconTexture", "ItemIcon", "itemIcon", "texture", "Texture",
        }

        for _, key in ipairs(iconKeys) do
            local value = reward[key]
            if type(value) == "string" and value ~= "" then
                return value
            end
            if type(value) == "table" and type(value.GetTexture) == "function" then
                local tex = value:GetTexture()
                if type(tex) == "string" and tex ~= "" then
                    return tex
                end
            end
        end

        local itemIDKeys = { "ItemID", "itemID", "itemId", "itemid" }
        for _, key in ipairs(itemIDKeys) do
            local itemID = tonumber(reward[key])
            if itemID and itemID > 0 then
                if C_Item and type(C_Item.GetItemIconByID) == "function" then
                    local itemIcon = C_Item.GetItemIconByID(itemID)
                    if itemIcon and itemIcon ~= 0 then
                        return itemIcon
                    end
                end

                if GetItemInfo then
                    local _, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
                    if itemIcon and itemIcon ~= 0 then
                        return itemIcon
                    end
                end
            end
        end

        local linkKeys = { "ItemLink", "itemLink", "Link", "link", "Hyperlink", "hyperlink" }
        for _, key in ipairs(linkKeys) do
            local itemLink = reward[key]
            if type(itemLink) == "string" and itemLink ~= "" and GetItemInfo then
                local _, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemLink)
                if itemIcon and itemIcon ~= 0 then
                    return itemIcon
                end
            end
        end

        return nil
    end

    local function ExtractRewardName(reward)
        if type(reward) ~= "table" then
            return nil
        end

        local nameKeys = { "Name", "name", "Label", "label", "Text", "text", "Title", "title" }
        for _, key in ipairs(nameKeys) do
            local value = reward[key]
            if type(value) == "string" and value ~= "" then
                return value
            end
            if type(value) == "table" and type(value.GetText) == "function" then
                local text = value:GetText()
                if type(text) == "string" and text ~= "" then
                    return text
                end
            end
        end

        local itemIDKeys = { "ItemID", "itemID", "itemId", "itemid" }
        for _, key in ipairs(itemIDKeys) do
            local itemID = tonumber(reward[key])
            if itemID and itemID > 0 then
                if C_Item and type(C_Item.GetItemNameByID) == "function" then
                    local itemName = C_Item.GetItemNameByID(itemID)
                    if type(itemName) == "string" and itemName ~= "" then
                        return itemName
                    end
                end

                if GetItemInfo then
                    local itemName = GetItemInfo(itemID)
                    if type(itemName) == "string" and itemName ~= "" then
                        return itemName
                    end
                end
            end
        end

        local linkKeys = { "ItemLink", "itemLink", "Link", "link", "Hyperlink", "hyperlink" }
        for _, key in ipairs(linkKeys) do
            local itemLink = reward[key]
            if type(itemLink) == "string" and itemLink ~= "" and GetItemInfo then
                local itemName = GetItemInfo(itemLink)
                if type(itemName) == "string" and itemName ~= "" then
                    return itemName
                end
            end
        end

        return nil
    end

    local function ExtractRewardCount(reward)
        if type(reward) ~= "table" then
            return nil
        end

        local countKeys = { "Count", "count", "Quantity", "quantity", "Amount", "amount", "StackSize", "stackSize", "NumItems", "numItems" }
        for _, key in ipairs(countKeys) do
            local value = reward[key]
            if type(value) == "number" then
                return tostring(value)
            end
            if type(value) == "string" and value ~= "" then
                return value
            end
            if type(value) == "table" and type(value.GetText) == "function" then
                local text = value:GetText()
                if type(text) == "string" and text ~= "" then
                    return text
                end
            end
        end

        return nil
    end

    local rewards = {}
    local activeCount = 0
    local namedCount = 0
    for reward in dialog.rewardPool:EnumerateActive() do
        activeCount = activeCount + 1
        local name = ExtractRewardName(reward)
        local count = ExtractRewardCount(reward)
        local icon = ExtractRewardIcon(reward)

        if type(name) == "string" and name ~= "" then
            namedCount = namedCount + 1
            name = NormalizeRewardName(name)
            local iconTag = ""
            if type(icon) == "string" and icon ~= "" then
                iconTag = "|T" .. icon .. ":14:14:0:0|t "
            end

            if type(count) == "string" and count ~= "" and count ~= "1" then
                rewards[#rewards + 1] = iconTag .. name .. " x" .. count
            else
                rewards[#rewards + 1] = iconTag .. name
            end
        end
    end

    return rewards, activeCount, namedCount
end

local function WarmRewardCacheFromPins()
    if rewardWarmCancel then
        return
    end

    local mission = _G.CovenantMissionFrame
    local dialog = _G.AdventureMapQuestChoiceDialog
    if not (mission and mission:IsShown() and dialog and type(dialog.ShowWithQuest) == "function") then
        return
    end

    local function RewardScore(list)
        if type(list) ~= "table" then
            return 0
        end

        local score = 0
        for _, text in ipairs(list) do
            local value = tostring(text or "")
            if value ~= "" then
                score = score + 1
                if not value:find(" XP", 1, true) then
                    score = score + 10
                end
            end
        end

        return score
    end

    local queue = {}
    local representativeByDifficulty = {}
    for _, hunt in ipairs(liveHunts) do
        if type(hunt.questID) == "number" and rewardCache[hunt.questID] == nil then
            local difficulty = hunt.difficulty or DIFFICULTY_NORMAL
            if representativeByDifficulty[difficulty] == nil then
                representativeByDifficulty[difficulty] = {
                    questID = hunt.questID,
                    difficulty = difficulty,
                    mode = "quest",
                }
            end
        end
    end

    for _, difficulty in ipairs({ DIFFICULTY_NORMAL, DIFFICULTY_HARD, DIFFICULTY_NIGHTMARE }) do
        if representativeByDifficulty[difficulty] then
            queue[#queue + 1] = representativeByDifficulty[difficulty]
            representativeByDifficulty[difficulty] = nil
        end
    end

    for _, entry in pairs(representativeByDifficulty) do
        queue[#queue + 1] = entry
    end

    if #queue == 0 then
        return
    end

    local cancelled = false
    local ticker = nil
    local currentIndex = 1
    local prevAlpha = dialog:GetAlpha()

    local elapsed = 0
    local stablePolls = 0
    local lastSignature = nil

    local function CancelTicker()
        if ticker then
            ticker:Cancel()
            ticker = nil
        end
    end

    local StartCurrentQuest

    local function FinishCurrentQuest(rewards, timedOutEmpty)
        CancelTicker()
        dialog:Hide()
        dialog:SetAlpha(prevAlpha)

        local entry = queue[currentIndex]
        local questID = entry and entry.questID
        if questID then
            if timedOutEmpty then
                rewardRetryCount[questID] = (rewardRetryCount[questID] or 0) + 1
                if rewardRetryCount[questID] >= REWARD_MAX_EMPTY_RETRIES then
                    rewardCache[questID] = {}
                else
                    rewardCache[questID] = nil
                end
            else
                rewardRetryCount[questID] = nil
                rewardCache[questID] = CopyStringList(rewards)

                if entry and entry.difficulty then
                    local existingDifficultyRewards = difficultyRewardCache[entry.difficulty]
                    if type(existingDifficultyRewards) ~= "table" or RewardScore(rewards) > RewardScore(existingDifficultyRewards) then
                        difficultyRewardCache[entry.difficulty] = CopyStringList(rewards)
                    end

                    local bestForDifficulty = difficultyRewardCache[entry.difficulty]
                    if type(bestForDifficulty) == "table" then
                        for _, hunt in ipairs(liveHunts) do
                            if hunt.difficulty == entry.difficulty and type(hunt.questID) == "number" then
                                local existingQuestRewards = rewardCache[hunt.questID]
                                if type(existingQuestRewards) ~= "table" or RewardScore(bestForDifficulty) > RewardScore(existingQuestRewards) then
                                    rewardCache[hunt.questID] = CopyStringList(bestForDifficulty)
                                end
                            end
                        end
                    end
                end
            end

            SaveRewardCaches()
        end

        currentIndex = currentIndex + 1
        if currentIndex > #queue then
            rewardWarmCancel = nil
            if HuntScannerModule and type(HuntScannerModule.RefreshNow) == "function" then
                HuntScannerModule:RefreshNow()
            end
            return
        end

        C_Timer.After(0.05, function()
            if cancelled then
                return
            end
            StartCurrentQuest()
        end)
    end

    StartCurrentQuest = function()
        if cancelled then
            return
        end

        elapsed = 0
        stablePolls = 0
        lastSignature = nil

        local entry = queue[currentIndex]
        local pin = entry and FindPinByQuestID(entry.questID)
        if not pin then
            FinishCurrentQuest({}, false)
            return
        end

        local dialogPoint = { dialog:GetPoint(1) }
        dialog:SetAlpha(0)
        dialog:ClearAllPoints()
        dialog:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -4000, 4000)
        dialog:Hide()
        dialog:ShowWithQuest(mission, pin, entry.questID)

        if dialogPoint[1] then
            dialog:ClearAllPoints()
            dialog:SetPoint(dialogPoint[1], dialogPoint[2], dialogPoint[3], dialogPoint[4], dialogPoint[5])
        end

        ticker = C_Timer.NewTicker(REWARD_POLL_INTERVAL, function()
            if cancelled then
                return
            end

            elapsed = elapsed + REWARD_POLL_INTERVAL
            local rewards, activeCount, namedCount = SnapshotDialogRewards()
            local signature = table.concat(rewards, "||") .. "|a=" .. tostring(activeCount) .. "|n=" .. tostring(namedCount)

            if activeCount > 0 and namedCount < activeCount and elapsed < REWARD_TIMEOUT_SECONDS then
                stablePolls = 0
                lastSignature = signature
            elseif #rewards > 0 and signature == lastSignature and elapsed >= REWARD_MIN_STABLE_SECONDS then
                stablePolls = stablePolls + 1
                if stablePolls >= REWARD_STABLE_POLLS then
                    FinishCurrentQuest(rewards, false)
                    return
                end
            else
                stablePolls = 0
                lastSignature = signature
            end

            if elapsed >= REWARD_TIMEOUT_SECONDS then
                FinishCurrentQuest(rewards, #rewards == 0)
            end
        end)
    end

    rewardWarmCancel = function()
        cancelled = true
        CancelTicker()
        dialog:Hide()
        dialog:SetAlpha(prevAlpha)
        rewardWarmCancel = nil
    end

    StartCurrentQuest()
end

local function CaptureSnapshot(options, npcID)
    local interactionType = (C_PlayerInteractionManager and C_PlayerInteractionManager.GetInteractionType and C_PlayerInteractionManager.GetInteractionType()) or nil
    if interactionType ~= nil then
        lastInteractionType = interactionType
    else
        interactionType = lastInteractionType
    end

    local mapHuntCount = #liveHunts
    local mapDifficultyCounts = {}
    for _, hunt in ipairs(liveHunts) do
        local difficulty = hunt and hunt.difficulty or DIFFICULTY_NORMAL
        mapDifficultyCounts[difficulty] = (mapDifficultyCounts[difficulty] or 0) + 1
    end

    local mapRewardCachedCount = 0
    local mapRewardPendingCount = 0
    for _, hunt in ipairs(liveHunts) do
        local questID = hunt and hunt.questID
        if type(questID) == "number" then
            if type(rewardCache[questID]) == "table" then
                mapRewardCachedCount = mapRewardCachedCount + 1
            else
                mapRewardPendingCount = mapRewardPendingCount + 1
            end
        end
    end

    local mapPreview = {}
    for i = 1, math.min(4, #liveHunts) do
        local hunt = liveHunts[i]
        mapPreview[#mapPreview + 1] = {
            questID = hunt.questID,
            title = hunt.title,
            difficulty = hunt.difficulty,
            zone = hunt.zone,
        }
    end

    local snapshot = {
        time = GetTime and GetTime() or 0,
        npcID = npcID,
        options = options,
        interactionType = interactionType,
        mapState = {
            missionVisible = IsMissionFrameVisible(),
            hunts = mapHuntCount,
            difficultyCounts = mapDifficultyCounts,
            cachedRewards = mapRewardCachedCount,
            pendingRewards = mapRewardPendingCount,
            warming = rewardWarmCancel ~= nil,
            preview = mapPreview,
        },
        questDetail = {
            questID = (GetQuestID and GetQuestID()) or nil,
            title = (GetTitleText and GetTitleText()) or nil,
            objective = (GetObjectiveText and GetObjectiveText()) or nil,
            choiceCount = (GetNumQuestChoices and GetNumQuestChoices()) or nil,
        },
    }

    lastSnapshot = snapshot
    if SnapshotHasUsefulData(snapshot) then
        lastRichSnapshot = CopySnapshot(snapshot)
    end
end

local function RecordEvent(event, ...)
    if event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
        local interaction = tonumber(select(1, ...))
        if interaction then
            lastInteractionType = interaction
        end
    end

    recentEvents[#recentEvents + 1] = {
        t = GetTime and GetTime() or 0,
        event = event,
        a1 = select(1, ...),
        a2 = select(2, ...),
        a3 = select(3, ...),
    }

    while #recentEvents > 30 do
        table.remove(recentEvents, 1)
    end
end

local function BuildDebugSnapshotLines(snapshot)
    local lines = {}
    lines[#lines + 1] = "Preydator HuntDebug: NPC=" .. SafeToString(snapshot.npcID) .. " time=" .. SafeToString(snapshot.time)
    lines[#lines + 1] = "Preydator HuntDebug: interactionType=" .. SafeToString(snapshot.interactionType)
    lines[#lines + 1] = "Preydator HuntDebug: previewEnabled=" .. SafeToString(IsOptionsPreviewVisible())
        .. " previewSetting=" .. SafeToString(GetSettings() and GetSettings().huntScannerPreviewInOptions)
        .. " hasAnchor=" .. SafeToString(HasVisibleHuntAnchor())
        .. " panelShown=" .. SafeToString(panelFrame and panelFrame.IsShown and panelFrame:IsShown() == true)

    local options = snapshot.options or {}
    lines[#lines + 1] = "Preydator HuntDebug: options=" .. SafeToString(#options)
    for index, option in ipairs(options) do
        local text = option and (option.name or option.text) or "?"
        local spellID = option and option.spellID
        lines[#lines + 1] = "  [O" .. SafeToString(index) .. "] spellID=" .. SafeToString(spellID) .. " text=" .. SafeToString(text)
    end

    local mapState = snapshot.mapState or {}
    lines[#lines + 1] = "Preydator HuntDebug: mapHunts=" .. SafeToString(mapState.hunts or 0)
        .. " cachedRewards=" .. SafeToString(mapState.cachedRewards or 0)
        .. " pendingRewards=" .. SafeToString(mapState.pendingRewards or 0)
        .. " warming=" .. SafeToString(mapState.warming)
        .. " mapVisible=" .. SafeToString(mapState.missionVisible)

    if type(mapState.difficultyCounts) == "table" then
        lines[#lines + 1] = "Preydator HuntDebug: mapDiffs normal=" .. SafeToString(mapState.difficultyCounts[DIFFICULTY_NORMAL] or 0)
            .. " hard=" .. SafeToString(mapState.difficultyCounts[DIFFICULTY_HARD] or 0)
            .. " nightmare=" .. SafeToString(mapState.difficultyCounts[DIFFICULTY_NIGHTMARE] or 0)
    end

    for index, hunt in ipairs(mapState.preview or {}) do
        lines[#lines + 1] = "  [M" .. SafeToString(index) .. "] questID=" .. SafeToString(hunt.questID)
            .. " title=" .. SafeToString(hunt.title)
            .. " diff=" .. SafeToString(hunt.difficulty)
            .. " zone=" .. SafeToString(hunt.zone)
    end

    local detail = snapshot.questDetail or {}
    lines[#lines + 1] = "Preydator HuntDebug: questDetail questID=" .. SafeToString(detail.questID)
        .. " title=" .. SafeToString(detail.title)
        .. " choices=" .. SafeToString(detail.choiceCount)

    if type(detail.objective) == "string" and detail.objective ~= "" then
        lines[#lines + 1] = "Preydator HuntDebug: questObjective=" .. SafeToString(detail.objective)
    end

    if #recentEvents > 0 then
        lines[#lines + 1] = "Preydator HuntDebug: recentEvents=" .. SafeToString(#recentEvents)
        local startIndex = math.max(1, #recentEvents - 9)
        for i = startIndex, #recentEvents do
            local e = recentEvents[i]
            lines[#lines + 1] = string.format("  [E] %.3f %s | %s | %s | %s", tonumber(e.t) or 0, SafeToString(e.event), SafeToString(e.a1), SafeToString(e.a2), SafeToString(e.a3))
        end
    end

    return lines
end

local function SendLinesToBugSack(lines)
    if type(lines) ~= "table" or #lines == 0 then
        return false, "empty report"
    end

    local safeLines = {}
    for index, line in ipairs(lines) do
        safeLines[index] = SafeToString(line)
    end

    local payload = table.concat(safeLines, "\n")
    lastDebugPayload = payload

    _G.PreydatorLastHuntDebugReport = payload

    if type(geterrorhandler) ~= "function" then
        return false, "geterrorhandler unavailable"
    end

    local okHandler, handler = pcall(geterrorhandler)
    if not okHandler or type(handler) ~= "function" then
        return false, "error handler unavailable"
    end

    local header = L["Preydator HuntDebug Report"]
    local chunkSize = 1800
    local length = #payload
    local chunks = math.max(1, math.ceil(length / chunkSize))

    for index = 1, chunks do
        local startPos = ((index - 1) * chunkSize) + 1
        local endPos = math.min(index * chunkSize, length)
        local chunk = string.sub(payload, startPos, endPos)
        local okSend = pcall(function()
            handler(string.format("%s [%d/%d]\n%s", header, index, chunks, chunk))
        end)
        if not okSend then
            return false, "handler failed on chunk " .. tostring(index)
        end
    end

    return true, "sent"
end

local function RefreshDebugSnapshotFromLiveAPI()
    local options = GetGossipOptionsSafe()

    local _, npcID = IsHuntTableContext(options)
    CaptureSnapshot(options, npcID)

    return (npcID ~= nil) or (#options > 0)
end

local function SelectBestSnapshotForDebug()
    if SnapshotHasUsefulData(lastSnapshot) then
        return lastSnapshot
    end

    if SnapshotHasUsefulData(lastRichSnapshot) then
        return lastRichSnapshot
    end

    return lastSnapshot
end

local function EnsurePanel()
    if panelFrame then
        return panelFrame
    end

    local frame = CreateFrame("Frame", "PreydatorHuntScannerPanel", UIParent, "BackdropTemplate")
    local panelWidth, panelHeight, _, panelScale = GetPanelConfig()
    frame:SetSize(panelWidth, panelHeight)
    frame:SetScale(panelScale)
    frame:SetFrameStrata("MEDIUM")
    frame:SetClampedToScreen(true)
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 14,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    local header = frame:CreateTexture(nil, "BORDER")
    header:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    header:SetHeight(28)
    frame.PreydatorHeader = header

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
    title:SetText(L["Preydator Hunt Tracker"])
    frame.PreydatorTitle = title

    local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
    subtitle:SetText("")
    frame.PreydatorSubtitle = subtitle

    local groupButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    groupButton:SetSize(68, 18)
    groupButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -80, -7)
    groupButton:SetText(L["Group"])
    groupButton:SetScript("OnClick", function()
        local settings = GetSettings()
        if not settings then
            return
        end
        local order = { "none", "difficulty", "zone" }
        local nextIndex = 1
        for index, key in ipairs(order) do
            if settings.huntScannerGroupBy == key then
                nextIndex = (index % #order) + 1
                break
            end
        end
        settings.huntScannerGroupBy = order[nextIndex]
        HandleInteractionSnapshot()
    end)

    local sortButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    sortButton:SetSize(56, 18)
    sortButton:SetPoint("LEFT", groupButton, "RIGHT", 4, 0)
    sortButton:SetText(L["Sort"])
    sortButton:SetScript("OnClick", function()
        local settings = GetSettings()
        if not settings then
            return
        end
        local order = { "difficulty", "zone", "title" }
        local nextIndex = 1
        for index, key in ipairs(order) do
            if settings.huntScannerSortBy == key then
                nextIndex = (index % #order) + 1
                break
            end
        end
        settings.huntScannerSortBy = order[nextIndex]
        HandleInteractionSnapshot()
    end)

    local startY = -54

    -- ScrollFrame clips row content within the panel boundary
    local scrollViewport = CreateFrame("ScrollFrame", nil, frame)
    scrollViewport:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, startY)
    scrollViewport:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 4)
    scrollViewport:EnableMouseWheel(true)

    local scrollContent = CreateFrame("Frame", nil, scrollViewport)
    scrollContent:SetSize(panelWidth - 30, 12 * panelRowHeight)
    scrollViewport:SetScrollChild(scrollContent)

    local scrollBar = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    scrollBar:SetOrientation("VERTICAL")
    scrollBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, startY - 2)
    scrollBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
    scrollBar:SetWidth(14)
    scrollBar:SetMinMaxValues(0, 0)
    scrollBar:SetValue(0)
    scrollBar:SetValueStep(1)
    scrollBar:SetObeyStepOnDrag(true)
    if scrollBar.Low then scrollBar.Low:Hide() end
    if scrollBar.High then scrollBar.High:Hide() end
    if scrollBar.Text then scrollBar.Text:Hide() end
    scrollBar:SetEnabled(false)
    scrollBar:SetAlpha(0.3)
    scrollBar:SetScript("OnValueChanged", function(self, value)
        local _, maxVal = self:GetMinMaxValues()
        local clamped = math.max(0, math.min(value or 0, maxVal or 0))
        scrollViewport:SetVerticalScroll(clamped)
    end)
    scrollViewport:SetScript("OnMouseWheel", function(_, delta)
        local _, maxVal = scrollBar:GetMinMaxValues()
        local cur = scrollBar:GetValue() or 0
        scrollBar:SetValue(math.max(0, math.min(cur - (delta * 20), maxVal or 0)))
    end)

    panelScrollViewport = scrollViewport
    panelScrollContent = scrollContent
    panelScrollBar = scrollBar
    frame.PreydatorScrollViewport = scrollViewport
    frame.PreydatorScrollContent = scrollContent
    frame.PreydatorScrollBar = scrollBar

    for index = 1, 12 do
        local row = CreateFrame("Frame", nil, scrollContent, "BackdropTemplate")
        row:SetPoint("TOPLEFT", scrollContent, "TOPLEFT", 0, -((index - 1) * panelRowHeight))
        row:SetSize(panelWidth - 30, panelRowHeight - 4)
        row:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })

        local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        name:SetPoint("TOPLEFT", row, "TOPLEFT", 8, -7)
        name:SetPoint("TOPRIGHT", row, "TOPRIGHT", -74, -7)
        name:SetJustifyH("LEFT")
        name:SetText("-")

        local zone = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        zone:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
        zone:SetPoint("TOPRIGHT", row, "TOPRIGHT", -74, 0)
        zone:SetJustifyH("LEFT")
        zone:SetText("")

        local reward = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        reward:SetPoint("TOPLEFT", zone, "BOTTOMLEFT", 0, -2)
        reward:SetPoint("TOPRIGHT", row, "TOPRIGHT", -74, 0)
        reward:SetJustifyH("LEFT")
        reward:SetWordWrap(true)
        reward:SetText("-")

        local acceptButton = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        acceptButton:SetSize(58, 18)
        acceptButton:SetPoint("RIGHT", row, "RIGHT", -8, 0)
        acceptButton:SetText(L["Accept"])
        acceptButton:SetScript("OnClick", function(self)
            local questID = self:GetParent().PreydatorQuestID
            if not questID then
                return
            end

            if not AcceptMapQuest(questID) then
                print(L["Preydator Hunt: unable to accept this quest right now."])
            end
        end)

        row.PreydatorName = name
        row.PreydatorZone = zone
        row.PreydatorReward = reward
        row.PreydatorAccept = acceptButton
        row.PreydatorQuestID = nil
        row:EnableMouse(true)
        row:SetScript("OnMouseUp", function(self, button)
            if button ~= "LeftButton" or not self.PreydatorQuestID then
                return
            end

            if not OpenMapQuestDialog(self.PreydatorQuestID) then
                print(L["Preydator Hunt: unable to open quest details from this row right now."])
            end
        end)
        panelRows[index] = row
    end

    frame:Hide()
    panelFrame = frame
    return frame
end

local function UpdatePanelTheme(frame)
    local theme = GetTheme()
    local _, _, fontSize = GetPanelConfig()
    local fontPath = GetThemeFontPath(theme)

    frame:SetBackdropColor(theme.section[1], theme.section[2], theme.section[3], theme.section[4])
    frame:SetBackdropBorderColor(theme.border[1], theme.border[2], theme.border[3], theme.border[4])

    if frame.PreydatorHeader then
        frame.PreydatorHeader:SetColorTexture(theme.header[1], theme.header[2], theme.header[3], theme.header[4])
    end

    SetTextColor(frame.PreydatorTitle, theme.title)
    SetTextColor(frame.PreydatorSubtitle, theme.muted)
    if frame.PreydatorTitle and frame.PreydatorTitle.SetFont then
        frame.PreydatorTitle:SetFont(fontPath, math.max(11, fontSize), "")
    end
    if frame.PreydatorSubtitle and frame.PreydatorSubtitle.SetFont then
        frame.PreydatorSubtitle:SetFont(fontPath, math.max(10, fontSize - 1), "")
    end

    for index, row in ipairs(panelRows) do
        local bg = (index % 2 == 0) and theme.rowAlt or theme.row
        row:SetBackdropColor(bg[1], bg[2], bg[3], bg[4])
        row:SetBackdropBorderColor(theme.border[1], theme.border[2], theme.border[3], 0.65)
        SetTextColor(row.PreydatorName, theme.title)
        if row.PreydatorZone then
            SetTextColor(row.PreydatorZone, theme.muted)
        end
        SetTextColor(row.PreydatorReward, theme.text)
        if row.PreydatorName and row.PreydatorName.SetFont then
            row.PreydatorName:SetFont(fontPath, math.max(10, fontSize), "")
        end
        if row.PreydatorZone and row.PreydatorZone.SetFont then
            row.PreydatorZone:SetFont(fontPath, math.max(9, fontSize - 1), "")
        end
        if row.PreydatorReward and row.PreydatorReward.SetFont then
            row.PreydatorReward:SetFont(fontPath, math.max(9, fontSize - 1), "")
        end

        if row.PreydatorAccept and row.PreydatorAccept.SetNormalFontObject then
            row.PreydatorAccept:SetNormalFontObject("GameFontNormalSmall")
            row.PreydatorAccept:SetHighlightFontObject("GameFontHighlightSmall")
            if row.PreydatorAccept.GetFontString then
                local fs = row.PreydatorAccept:GetFontString()
                if fs then
                    SetTextColor(fs, theme.title)
                end
            end
        end
    end
end

local function ApplyPanelAnchor(frame)
    local settings = GetSettings()
    local side = (settings and settings.huntScannerSide) or "right"
    local align = (settings and settings.huntScannerAnchorAlign) or "top"
    local settingsModule = Preydator and Preydator.GetModule and Preydator:GetModule("Settings")
    local previewAnchor = settingsModule and settingsModule.optionsPanel
    local anchor = (IsOptionsPreviewVisible() and previewAnchor)
        or (_G.CovenantMissionFrame and _G.CovenantMissionFrame:IsShown() and _G.CovenantMissionFrame)
        or (_G.GossipFrame and _G.GossipFrame.IsShown and _G.GossipFrame:IsShown() and _G.GossipFrame)
        or (_G.QuestFrame and _G.QuestFrame.IsShown and _G.QuestFrame:IsShown() and _G.QuestFrame)
        or UIParent

    frame:ClearAllPoints()
    if side == "left" then
        if align == "middle" then
            frame:SetPoint("RIGHT", anchor, "LEFT", -8, 0)
        elseif align == "bottom" then
            frame:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMLEFT", -8, 0)
        else
            frame:SetPoint("TOPRIGHT", anchor, "TOPLEFT", -8, 0)
        end
    else
        if align == "middle" then
            frame:SetPoint("LEFT", anchor, "RIGHT", 8, 0)
        elseif align == "bottom" then
            frame:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", 8, 0)
        else
            frame:SetPoint("TOPLEFT", anchor, "TOPRIGHT", 8, 0)
        end
    end
end

local function GetDifficultyBadge(difficulty)
    local canonicalDifficulty = NormalizeDifficultyKey(difficulty)

    if canonicalDifficulty == DIFFICULTY_NIGHTMARE then
        return "|cffff5a5a[Ni]|r"
    end
    if canonicalDifficulty == DIFFICULTY_HARD then
        return "|cffffaa3d[H]|r"
    end
    if canonicalDifficulty == DIFFICULTY_NORMAL then
        return "|cff6cff8f[N]|r"
    end
    return "|cff9aa3ad[?]|r"
end

local function BuildQuestRows(mapHunts)
    local rows = {}

    for _, hunt in ipairs(mapHunts or {}) do
        local title = hunt.title or ((hunt.questID and ("Quest " .. tostring(hunt.questID))) or L["Unknown"])
        local difficulty = NormalizeDifficultyKey(hunt.difficulty)
        local badge = GetDifficultyBadge(difficulty)

        rows[#rows + 1] = {
            questID = hunt.questID,
            title = badge .. " " .. title,
            reward = BuildRewardSummary(hunt.questID),
            canAccept = not (C_QuestLog and type(C_QuestLog.IsOnQuest) == "function" and C_QuestLog.IsOnQuest(hunt.questID) == true),
            difficultyKey = difficulty,
            difficulty = GetDifficultyDisplayName(difficulty),
            zone = hunt.zone or L["Unknown"],
            baseTitle = title,
        }
    end

    if #rows > 0 then
        local settings = GetSettings() or {}
        local sortBy = settings.huntScannerSortBy or "zone"
        local groupBy = settings.huntScannerGroupBy or "difficulty"
        local sortDir = settings.huntScannerSortDir or "asc"
        local descending = sortDir == "desc"

        local function GetDifficultyRank(value)
            local key = NormalizeDifficultyKey(value)
            if key == DIFFICULTY_NORMAL then
                return 1
            end
            if key == DIFFICULTY_HARD then
                return 2
            end
            if key == DIFFICULTY_NIGHTMARE then
                return 3
            end
            return 99
        end

        local function SortRows(rowList, keyOverride)
            local effectiveSortBy = keyOverride or sortBy
            table.sort(rowList, function(left, right)
                local cmp = 0
                if effectiveSortBy == "zone" then
                    local l = tostring(left.zone or "")
                    local r = tostring(right.zone or "")
                    if l == r then
                        local lt = tostring(left.baseTitle or left.title or "")
                        local rt = tostring(right.baseTitle or right.title or "")
                        if lt < rt then
                            cmp = -1
                        elseif lt > rt then
                            cmp = 1
                        end
                    else
                        cmp = (l < r) and -1 or 1
                    end
                elseif effectiveSortBy == "title" then
                    local l = tostring(left.baseTitle or left.title or "")
                    local r = tostring(right.baseTitle or right.title or "")
                    if l == r then
                        local lz = tostring(left.zone or "")
                        local rz = tostring(right.zone or "")
                        if lz < rz then
                            cmp = -1
                        elseif lz > rz then
                            cmp = 1
                        end
                    else
                        cmp = (l < r) and -1 or 1
                    end
                else
                    local lRank = GetDifficultyRank(left.difficultyKey or left.difficulty)
                    local rRank = GetDifficultyRank(right.difficultyKey or right.difficulty)
                    if lRank == rRank then
                        local lt = tostring(left.baseTitle or left.title or "")
                        local rt = tostring(right.baseTitle or right.title or "")
                        if lt < rt then
                            cmp = -1
                        elseif lt > rt then
                            cmp = 1
                        end
                    else
                        cmp = (lRank < rRank) and -1 or 1
                    end
                end

                if descending then
                    return cmp > 0
                end
                return cmp < 0
            end)
        end

        SortRows(rows)

        if groupBy ~= "difficulty" and groupBy ~= "zone" then
            return rows
        end

        local grouped = {}
        local collapsedGroups = settings.huntScannerCollapsedGroups or {}
        local buckets = {}
        local bucketOrder = {}

        for _, row in ipairs(rows) do
            local key = (groupBy == "zone") and tostring(row.zone or L["Unknown"]) or tostring(row.difficulty or L["Normal"])
            if not buckets[key] then
                buckets[key] = {}
                bucketOrder[#bucketOrder + 1] = key
            end
            buckets[key][#buckets[key] + 1] = row
        end

        table.sort(bucketOrder, function(left, right)
            if groupBy == "difficulty" then
                local lRank = GetDifficultyRank(left)
                local rRank = GetDifficultyRank(right)
                if lRank == rRank then
                    return tostring(left) < tostring(right)
                end
                return lRank > rRank
            end
            return tostring(left) < tostring(right)
        end)

        for _, key in ipairs(bucketOrder) do
            local collapseKey = tostring(groupBy) .. ":" .. key
            local collapsed = collapsedGroups[collapseKey] == true
            local bucketRows = buckets[key]
            local bucketSort = sortBy
            if bucketSort == groupBy then
                bucketSort = "title"
            end
            SortRows(bucketRows, bucketSort)

            grouped[#grouped + 1] = {
                title = (collapsed and "+ " or "- ") .. (groupBy == "zone" and (L["Zone"] .. ": ") or (L["Difficulty"] .. ": ")) .. key,
                reward = "",
                canAccept = false,
                groupKey = collapseKey,
                collapsed = collapsed,
            }

            if not collapsed then
                for _, row in ipairs(bucketRows) do
                    grouped[#grouped + 1] = row
                end
            end
        end

        return grouped
    end

    return rows
end

local function ReflowHuntRows()
    if not panelScrollViewport or not panelScrollContent or not panelScrollBar or not panelFrame then
        return
    end

    local rowWidth = panelScrollContent:GetWidth()
    if rowWidth < 10 then
        return
    end

    local yOffset = 0
    local gap = 4
    local nameLineH = 16
    local rewardLineH = 13
    local rowPadTop = 7
    local rowPadBottom = 6

    for index = 1, 12 do
        local row = panelRows[index]
        if not row then
            break
        end
        if row:IsShown() then
            local rewardH = (row.PreydatorReward and row.PreydatorReward:GetStringHeight()) or rewardLineH
            local zoneH = 0
            if row.PreydatorZone then
                local zt = row.PreydatorZone:GetText()
                if zt and zt ~= "" then
                    zoneH = math.ceil(row.PreydatorZone:GetStringHeight() or 13) + 2
                end
            end
            local rowH = math.max(panelRowHeight - 4, rowPadTop + nameLineH + zoneH + 3 + math.ceil(rewardH) + rowPadBottom)
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", panelScrollContent, "TOPLEFT", 0, -yOffset)
            row:SetSize(rowWidth, rowH)
            yOffset = yOffset + rowH + gap
        end
    end

    panelScrollContent:SetHeight(math.max(1, yOffset))
    panelScrollViewport:UpdateScrollChildRect()

    local scrollRange = panelScrollViewport:GetVerticalScrollRange() or 0
    scrollRange = math.max(0, scrollRange)
    if scrollRange > 0 then
        panelScrollBar:SetMinMaxValues(0, scrollRange)
        local cur = math.min(panelScrollBar:GetValue() or 0, scrollRange)
        panelScrollBar:SetValue(cur)
        panelScrollBar:SetEnabled(true)
        panelScrollBar:SetAlpha(1)
    else
        panelScrollBar:SetMinMaxValues(0, 0)
        panelScrollBar:SetValue(0)
        panelScrollBar:SetEnabled(false)
        panelScrollBar:SetAlpha(0.3)
    end
end

local reflowScheduled = false

local function QueueReflowRows()
    if reflowScheduled then
        return
    end
    reflowScheduled = true

    if C_Timer then
        C_Timer.After(0, function()
            reflowScheduled = false
            ReflowHuntRows()
        end)
        return
    end

    reflowScheduled = false
    ReflowHuntRows()
end

local function RenderPanel(questRows)
    if not IsOptionsPreviewVisible() and not HasVisibleHuntAnchor() then
        HidePanel()
        return
    end

    local frame = EnsurePanel()
    local panelWidth, panelHeight, _, panelScale = GetPanelConfig()
    frame:SetSize(panelWidth, panelHeight)
    frame:SetScale(panelScale)
    if panelScrollContent then
        panelScrollContent:SetWidth(panelWidth - 30)
    end
    UpdatePanelTheme(frame)
    ApplyPanelAnchor(frame)

    local settings = GetSettings() or {}
    if frame.PreydatorSubtitle then
        local groupLabel = L[settings.huntScannerGroupBy or "difficulty"] or (settings.huntScannerGroupBy or "difficulty")
        local sortLabel = L[settings.huntScannerSortBy or "zone"] or (settings.huntScannerSortBy or "zone")
        local sortDirLabel = L[settings.huntScannerSortDir or "asc"] or (settings.huntScannerSortDir or "asc")
        frame.PreydatorSubtitle:SetText(string.format(L["Group: %s | Sort: %s (%s)"], tostring(groupLabel), tostring(sortLabel), tostring(sortDirLabel)))
    end

    if not questRows or #questRows == 0 then
        questRows = {
            {
                title = L["No available hunts"],
                reward = "",
            },
        }
    end

    for index, row in ipairs(panelRows) do
        local data = questRows[index]
        if data then
            row:Show()
            row.PreydatorQuestID = SafeToNumber(data.questID)
            row.PreydatorName:SetText(data.title or "-")
            if row.PreydatorZone then
                local showZone = not data.groupKey and data.zone and data.zone ~= "" and data.zone ~= L["Unknown"]
                row.PreydatorZone:SetText(showZone and data.zone or "")
            end
            row.PreydatorReward:SetText(data.reward or "")
            if row.PreydatorAccept then
                if data.canAccept and row.PreydatorQuestID then
                    row.PreydatorAccept:Show()
                    row.PreydatorAccept:Enable()
                else
                    row.PreydatorAccept:Hide()
                    row.PreydatorAccept:Disable()
                end
            end
            if data.groupKey and row.PreydatorQuestID == nil then
                row:SetScript("OnMouseUp", function(self, button)
                    if button ~= "LeftButton" then
                        return
                    end
                    local s = GetSettings()
                    if not s then
                        return
                    end
                    s.huntScannerCollapsedGroups = s.huntScannerCollapsedGroups or {}
                    s.huntScannerCollapsedGroups[data.groupKey] = not (s.huntScannerCollapsedGroups[data.groupKey] == true)
                    HandleInteractionSnapshot()
                end)
            else
                row:SetScript("OnMouseUp", function(self, button)
                    if button ~= "LeftButton" or not self.PreydatorQuestID then
                        return
                    end

                    if not OpenMapQuestDialog(self.PreydatorQuestID) then
                        print(L["Preydator Hunt: unable to open quest details from this row right now."])
                    end
                end)
            end
        else
            row.PreydatorQuestID = nil
            if row.PreydatorAccept then
                row.PreydatorAccept:Hide()
                row.PreydatorAccept:Disable()
            end
            row:ClearAllPoints()
            row:SetScript("OnMouseUp", nil)
            row:Hide()
        end
    end

    frame:Show()
    QueueReflowRows()
end

HidePanel = function(cancelQueuedPasses)
    if panelFrame then
        panelFrame:Hide()
    end
    if panelScrollBar then
        panelScrollBar:SetValue(0)
    end
    if panelScrollViewport then
        panelScrollViewport:SetVerticalScroll(0)
    end
    huntInteractionActive = false
    if cancelQueuedPasses ~= false then
        snapshotSequence = snapshotSequence + 1
    end
    lastOpenQuestID = nil
    lastOpenAt = 0
    SyncNoisyEventSubscriptions()
end

HandleInteractionSnapshot = function()
    if isHandlingSnapshot then
        return
    end

    if IsInRestrictedInstance() then
        HidePanel()
        return
    end

    isHandlingSnapshot = true

    local ok, err = pcall(function()
        EnsureSettings()
        ProcessRewardCacheLifecycle()

        if not IsHuntRuntimeEnabled() then
            HidePanel(false)
            return
        end

        local options = GetGossipOptionsSafe()

        local isHuntContext, npcID = IsHuntTableContext(options)

        local mapHunts = RefreshHuntsFromPins()
        if #mapHunts > 0 and IsMissionFrameVisible() then
            isHuntContext = true
        end
        huntInteractionActive = isHuntContext == true
        SyncNoisyEventSubscriptions()
        if isHuntContext then
            MarkAvailabilityTouched()
        end
        CaptureSnapshot(options, npcID)
        NotifyCurrencyTrackerAvailabilityChanged()

        if not isHuntContext then
            if IsOptionsPreviewVisible() then
                RenderPanel(BuildPreviewRows())
                return
            end
            HidePanel(false)
            return
        end

        if not IsOptionsPreviewVisible() and not HasVisibleHuntAnchor() then
            HidePanel(false)
            return
        end

        if BlockHuntTableWhileActivePrey() then
            return
        end

        local rows = BuildQuestRows(mapHunts)
        RenderPanel(rows)
        if #mapHunts > 0 then
            WarmRewardCacheFromPins()
        end
    end)

    if not ok then
        print("Preydator HuntScanner: snapshot error: " .. tostring(err))
    end

    isHandlingSnapshot = false
end

local function ApplyMissionHooks()
    if missionHooksApplied or type(HookSecureFunc) ~= "function" then
        return
    end

    HookSecureFunc("ShowUIPanel", function(frame)
        if not frame or frame:GetName() ~= "CovenantMissionFrame" then
            return
        end

        if QueueInteractionSnapshotPasses then
            QueueInteractionSnapshotPasses()
        else
            HandleInteractionSnapshot()
        end
    end)

    HookSecureFunc("HideUIPanel", function(frame)
        if not frame or frame:GetName() ~= "CovenantMissionFrame" then
            return
        end

        if rewardWarmCancel then
            rewardWarmCancel()
        end
        HidePanel()
    end)

    missionHooksApplied = true
end

function HuntScannerModule:ApplySettings()
    EnsureSettings()
    ProcessRewardCacheLifecycle()
    if IsOptionsPreviewVisible() then
        RenderPanel(BuildPreviewRows())
        return
    end

    if panelFrame and panelFrame:IsShown() then
        if not HasVisibleHuntAnchor() then
            HidePanel()
            return
        end
        UpdatePanelTheme(panelFrame)
        ApplyPanelAnchor(panelFrame)
    end
end

function HuntScannerModule:SetPreviewEnabled(enabled)
    local settings = GetSettings()
    if settings then
        settings.huntScannerPreviewInOptions = enabled == true
    end

    if enabled == true and IsOptionsPreviewVisible() then
        RenderPanel(BuildPreviewRows())
        return
    end

    if not HasVisibleHuntAnchor() then
        HidePanel()
        return
    end

    self:RefreshNow()
end

function HuntScannerModule:HandleOptionsPanelVisibility(isVisible)
    if isVisible == true then
        if IsOptionsPreviewVisible() then
            RenderPanel(BuildPreviewRows())
            return
        end

        if not HasVisibleHuntAnchor() then
            HidePanel()
            return
        end

        self:RefreshNow()
        return
    end

    local settings = GetSettings()
    if settings then
        settings.themeEditorPreviewInOptions = false
    end

    if not HasVisibleHuntAnchor() then
        HidePanel()
        return
    end

    self:RefreshNow()
end

function HuntScannerModule:SetThemePreviewEnabled(enabled)
    local settings = GetSettings()
    if settings then
        settings.themeEditorPreviewInOptions = enabled == true
    end

    if IsOptionsPreviewVisible() then
        RenderPanel(BuildPreviewRows())
        return
    end

    if not HasVisibleHuntAnchor() then
        HidePanel()
        return
    end

    self:RefreshNow()
end

function HuntScannerModule:PrintDebugSnapshot()
    if (not lastSnapshot) or (not lastSnapshot.npcID and #(lastSnapshot.available or {}) == 0 and #(lastSnapshot.active or {}) == 0 and #(lastSnapshot.options or {}) == 0) then
        RefreshDebugSnapshotFromLiveAPI()
    end

    local snapshot = SelectBestSnapshotForDebug()
    if not snapshot then
        print(L["Preydator HuntDebug: no hunt snapshot captured yet."])
        return
    end

    local lines = BuildDebugSnapshotLines(snapshot)
    for _, line in ipairs(lines) do
        print(line)
    end
end

function HuntScannerModule:OnSlashCommand(text, rest)
    if text == "huntdebug" then
        if (not lastSnapshot) or (not lastSnapshot.npcID and #(lastSnapshot.available or {}) == 0 and #(lastSnapshot.active or {}) == 0 and #(lastSnapshot.options or {}) == 0) then
            RefreshDebugSnapshotFromLiveAPI()
        end

        local mode = string.lower((rest or ""):match("^%s*(.-)%s*$") or "")
        if mode == "bugsack" or mode == "bs" then
            local snapshot = SelectBestSnapshotForDebug()
            if not snapshot then
                print(L["Preydator HuntDebug: no hunt snapshot captured yet."])
                return true
            end

            local lines = BuildDebugSnapshotLines(snapshot)
            local sent, reason = SendLinesToBugSack(lines)
            if sent then
                print(L["Preydator HuntDebug: sent to BugSack via error handler."])
            else
                print(L["Preydator HuntDebug: Could not send to BugSack: "] .. tostring(reason))
                for _, line in ipairs(lines) do
                    print(line)
                end
            end
            return true
        end

        self:PrintDebugSnapshot()
        return true
    end

    if text == "huntdebugcopy" then
        if type(lastDebugPayload) == "string" and lastDebugPayload ~= "" then
            print(lastDebugPayload)
        else
            print(L["Preydator HuntDebug: no payload captured yet."])
        end
        return true
    end

    return false
end

QueueInteractionSnapshotPasses = function(force)
    if not IsHuntRuntimeEnabled() then
        HidePanel()
        return
    end

    if IsInRestrictedInstance() then
        HidePanel()
        return
    end

    if HasActivePreyQuest() and not IsOptionsPreviewVisible() then
        HidePanel()
        return
    end

    if not force and not IsOptionsPreviewVisible() and not IsMissionFrameVisible() and not huntInteractionActive then
        local options = GetGossipOptionsSafe()
        local isHuntContext = IsHuntTableContext(options)
        if not isHuntContext then
            return
        end
    end

    local now = GetTime and (tonumber(GetTime()) or 0) or 0
    if not force and now < queueDebounceUntil then
        HandleInteractionSnapshot()
        return
    end
    queueDebounceUntil = now + SNAPSHOT_QUEUE_DEBOUNCE_SECONDS

    snapshotSequence = snapshotSequence + 1
    local token = snapshotSequence

    HandleInteractionSnapshot()

    if not C_Timer or type(C_Timer.After) ~= "function" then
        return
    end

    -- Delays extend to 10s so pins that load slowly (server lag) are still caught.
    -- The snapshotSequence token cancels stale passes when the user leaves.
    for _, delay in ipairs({ 0.05, 0.20, 0.50, 1.00, 2.00, 4.00, 7.00, 10.00 }) do
        C_Timer.After(delay, function()
            if token ~= snapshotSequence then
                return
            end
            HandleInteractionSnapshot()
        end)
    end
end

function HuntScannerModule:RefreshNow()
    if not IsHuntRuntimeEnabled() then
        HidePanel()
        return
    end

    ProcessRewardCacheLifecycle()
    if IsOptionsPreviewVisible() then
        RenderPanel(BuildPreviewRows())
        return
    end
    HandleInteractionSnapshot()
end

function HuntScannerModule:RefreshRewardCache()
    if not IsHuntRuntimeEnabled() then
        HidePanel()
        return
    end

    ClearAllRewardCaches()
    if IsOptionsPreviewVisible() then
        RenderPanel(BuildPreviewRows())
        return
    end
    HandleInteractionSnapshot()
    WarmRewardCacheFromPins()
end

function HuntScannerModule:OnPreyQuestEnded(payload)
    if type(payload) ~= "table" then
        return
    end

    local questID = SafeToNumber(payload.questID)
    if not questID or questID < 1 then
        return
    end

    local completed = payload.completed == true or tonumber(payload.stage) == 4
    if completed then
        local difficulty = GetRememberedQuestDifficulty(questID)
        if type(difficulty) ~= "string" or difficulty == "" then
            difficulty = type(payload.difficulty) == "string" and payload.difficulty or nil
        end
        if difficulty then
            ClearRewardCacheForDifficulty(difficulty)
        end
    end

    rewardRetryCount[questID] = nil
    HidePanel()
end

function HuntScannerModule:GetAvailabilityCounts()
    local counts = {
        normal = 0,
        hard = 0,
        nightmare = 0,
    }

    for _, hunt in ipairs(liveHunts or {}) do
        local questID = tonumber(hunt and hunt.questID)
        if questID and questID > 0 then
            local isOnQuest = C_QuestLog and type(C_QuestLog.IsOnQuest) == "function" and C_QuestLog.IsOnQuest(questID) == true
            if not isOnQuest then
                local difficulty = NormalizeDifficultyKey(hunt and hunt.difficulty)
                if difficulty == DIFFICULTY_NIGHTMARE then
                    counts.nightmare = counts.nightmare + 1
                elseif difficulty == DIFFICULTY_HARD then
                    counts.hard = counts.hard + 1
                else
                    counts.normal = counts.normal + 1
                end
            end
        end
    end

    if #liveHunts > 0 then
        availabilityTouched = true
        availabilityCache = {
            normal = counts.normal,
            hard = counts.hard,
            nightmare = counts.nightmare,
            capturedAt = GetTime and (tonumber(GetTime()) or 0) or 0,
        }
        SaveAvailabilityCache()
        return {
            normal = counts.normal,
            hard = counts.hard,
            nightmare = counts.nightmare,
            capturedAt = availabilityCache.capturedAt,
            known = true,
        }
    end

    local cached = SanitizeAvailabilityCounts(availabilityCache)
    return {
        normal = cached.normal,
        hard = cached.hard,
        nightmare = cached.nightmare,
        capturedAt = cached.capturedAt,
        known = availabilityTouched == true,
    }
end

function HuntScannerModule:GetQuestZoneMapID(questID)
    local id = SafeToNumber(questID)
    if not id then
        return nil
    end
    local fromCache = questZoneCache[id]
    if type(fromCache) == "number" then
        return fromCache
    end
    local hunt = huntByQuestID[id]
    if hunt and type(hunt.zoneMapID) == "number" then
        return hunt.zoneMapID
    end
    -- If we have cached pin coordinates and a parent map ID, resolve zone on demand.
    local coords = questCoords[id]
    local parentMapID = cachedAdventureMapID
    if coords and parentMapID and C_Map and C_Map.GetMapInfoAtPosition then
        local zoneInfo = C_Map.GetMapInfoAtPosition(parentMapID, coords.nx, coords.ny)
        local zoneMapID = zoneInfo and zoneInfo.mapID
        if zoneMapID then
            questZoneCache[id] = zoneMapID
            return zoneMapID
        end
    end
    return nil
end

function HuntScannerModule:GetQuestMetadata(questID)
    local id = SafeToNumber(questID)
    if not id then
        return nil
    end

    local hunt = huntByQuestID[id]
    local zoneMapID = self:GetQuestZoneMapID(id)
    local zoneName = hunt and hunt.zone or nil
    local difficulty = hunt and hunt.difficulty or GetRememberedQuestDifficulty(id)
    local title = hunt and hunt.title or nil
    local sourceType = hunt and "weekly" or "random"

    return {
        questID = id,
        title = title,
        difficulty = NormalizeDifficultyKey(difficulty),
        zoneName = zoneName,
        zoneMapID = zoneMapID,
        sourceType = sourceType,
    }
end

function HuntScannerModule:OnAddonLoaded()
    EnsureSettings()
    LoadRewardCaches()
    ProcessRewardCacheLifecycle()
    ApplyMissionHooks()
    SyncNoisyEventSubscriptions()
end

huntEventFrame = CreateFrame("Frame")
huntEventFrame:RegisterEvent("PLAYER_LOGIN")
huntEventFrame:RegisterEvent("GOSSIP_SHOW")
huntEventFrame:RegisterEvent("GOSSIP_CLOSED")
huntEventFrame:RegisterEvent("QUEST_DATA_LOAD_RESULT")
huntEventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
huntEventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_HIDE")
huntEventFrame:RegisterEvent("QUEST_DETAIL")
huntEventFrame:RegisterEvent("QUEST_PROGRESS")
huntEventFrame:RegisterEvent("QUEST_COMPLETE")
huntEventFrame:RegisterEvent("QUEST_FINISHED")

huntEventFrame:SetScript("OnEvent", function(_, event, ...)
    local noisyEvent = (event == "QUEST_LOG_UPDATE" or event == "UPDATE_UI_WIDGET" or event == "UPDATE_ALL_UI_WIDGETS")
    local isRestrictedInstance = IsInRestrictedInstance()
    local runtimeEnabled = nil
    local function IsRuntimeEnabled()
        if runtimeEnabled ~= nil then
            return runtimeEnabled
        end

        runtimeEnabled = IsHuntRuntimeEnabled()
        return runtimeEnabled
    end

    local hasHuntContext = nil
    local function GetHasHuntContext()
        if hasHuntContext ~= nil then
            return hasHuntContext
        end

        hasHuntContext = IsRuntimeEnabled()
            and (not isRestrictedInstance)
            and (IsMissionFrameVisible() or huntInteractionActive or IsOptionsPreviewVisible() or HasActivePreyQuest())
        return hasHuntContext
    end

    if (not noisyEvent) or GetHasHuntContext() then
        RecordEvent(event, ...)
    end

    if event == "PLAYER_LOGIN" then
        EnsureSettings()
        LoadRewardCaches()
        ProcessRewardCacheLifecycle()
        ApplyMissionHooks()
        SyncNoisyEventSubscriptions()
        return
    end

    if not IsRuntimeEnabled() then
        if huntInteractionActive then
            huntInteractionActive = false
        end
        HidePanel()
        return
    end

    if (event == "QUEST_LOG_UPDATE" or event == "UPDATE_UI_WIDGET" or event == "UPDATE_ALL_UI_WIDGETS") and GetHasHuntContext() then
        ProcessRewardCacheLifecycle()
    end

    if isRestrictedInstance and event ~= "PLAYER_LOGIN" then
        if huntInteractionActive then
            huntInteractionActive = false
            SyncNoisyEventSubscriptions()
        end

        if event == "GOSSIP_SHOW"
            or event == "GOSSIP_CLOSED"
            or event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW"
            or event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE"
            or event == "QUEST_DETAIL"
            or event == "QUEST_PROGRESS"
            or event == "QUEST_COMPLETE"
            or event == "QUEST_FINISHED"
            or event == "QUEST_LOG_UPDATE"
            or event == "UPDATE_UI_WIDGET"
            or event == "UPDATE_ALL_UI_WIDGETS" then
            HidePanel()
            return
        end
    end

    if event == "GOSSIP_SHOW" then
        -- Pre-flag hunt context eagerly so UPDATE_UI_WIDGET events refire while pins load.
        local gossipOptions = GetGossipOptionsSafe()
        if IsHuntTableContext(gossipOptions) then
            huntInteractionActive = true
            SyncNoisyEventSubscriptions()
            QueueInteractionSnapshotPasses()
        end
        return
    end

    if event == "GOSSIP_CLOSED" then
        HidePanel()
        return
    end

    if event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
        if IsMissionFrameVisible() then
            -- Only the hunt table mission frame needs snapshot work.
            huntInteractionActive = true
            SyncNoisyEventSubscriptions()
            QueueInteractionSnapshotPasses(true)
        else
            huntInteractionActive = false
            SyncNoisyEventSubscriptions()
        end
        return
    end

    if event == "QUEST_DETAIL"
        or event == "QUEST_PROGRESS"
        or event == "QUEST_COMPLETE"
    then
        if IsMissionFrameVisible() or huntInteractionActive or IsOptionsPreviewVisible() then
            QueueInteractionSnapshotPasses()
            return
        end

        local options = GetGossipOptionsSafe()
        local isHuntContext = IsHuntTableContext(options)
        if isHuntContext then
            QueueInteractionSnapshotPasses()
        end
        return
    end

    if event == "UPDATE_UI_WIDGET"
        or event == "UPDATE_ALL_UI_WIDGETS"
        or event == "QUEST_LOG_UPDATE"
    then
        if GetHasHuntContext() then
            QueueInteractionSnapshotPasses()
        end
        return
    end

    if event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE" or event == "QUEST_FINISHED" then
        HidePanel()
        return
    end

    if event == "QUEST_DATA_LOAD_RESULT" then
        if IsMissionFrameVisible() or huntInteractionActive or IsOptionsPreviewVisible() then
            QueueInteractionSnapshotPasses()
        end
        return
    end
end)
