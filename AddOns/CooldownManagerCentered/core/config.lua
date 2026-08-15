local _, ns = ...
CooldownManagerCentered = LibStub("AceAddon-3.0"):NewAddon("CooldownManagerCentered", "AceConsole-3.0")
ns.Addon = CooldownManagerCentered
CooldownManagerCentered.ns = ns
local L = LibStub("AceLocale-3.0"):GetLocale("CooldownManagerCentered")
ns.L = L

ns.CONSTANTS = ns.CONSTANTS or {}
-- Upper bound on the number of custom trackers a profile may have (contiguous 1..N).
ns.CONSTANTS.MAX_TRACKERS = 10
ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR = {
    r = CooldownViewerConstants.ITEM_AURA_COLOR.r,
    g = CooldownViewerConstants.ITEM_AURA_COLOR.g,
    b = CooldownViewerConstants.ITEM_AURA_COLOR.b,
    a = CooldownViewerConstants.ITEM_AURA_COLOR.a,
}
ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR = {
    r = CooldownViewerConstants.ITEM_COOLDOWN_COLOR.r,
    g = CooldownViewerConstants.ITEM_COOLDOWN_COLOR.g,
    b = CooldownViewerConstants.ITEM_COOLDOWN_COLOR.b,
    a = CooldownViewerConstants.ITEM_COOLDOWN_COLOR.a,
}

ns.CONSTANTS.DEFAULT_FONT = { SystemFont_Outline:GetFont() }
ns.CONSTANTS.DEFAULT_NUMBER_FONT = { NumberFontNormal:GetFont() }

ns.CONSTANTS.FONT = {
    DEFAULT_STACK_POINT = "BOTTOMRIGHT",
    DEFAULT_STACK_OFFSET_X = -2,
    DEFAULT_STACK_OFFSET_Y = 2,
}

local GLOBAL_SETTINGS_JUST_DEFAULTS = {
    autoSwitchProfiles = false,
    masque_enabled = false,
    debugLogging = false,
    debugModules = {},
    -- ["autoSwitchProfile" .. playerClassId .. "Spec" .. i] = "ProfileName", -- ex. autoSwitchProfile1SPec1 = "ProfileName",
}

---@class CMCAnchorConfig
---@field to string?
---@field point string?
---@field relativePoint string?
---@field x number?
---@field y number?

-- Edit Mode entries are populated lazily by WilduUICore/AceDB. Tracker-only and
-- buff-container-only fields intentionally share one type because callers address
-- these configs through dynamic keys such as "tracker" .. index.
---@class CMCEditModeFrameConfig
---@field point string?
---@field x number?
---@field y number?
---@field scale number?
---@field alpha number?
---@field strata string?
---@field lockHorizontal boolean?
---@field anchor CMCAnchorConfig?
---@field orientation string?
---@field iconDirection string?
---@field alignment string?
---@field iconPadding number?
---@field iconSize number?
---@field flowLimitEnabled boolean?
---@field flowLimit number?
---@field flowReverse boolean?
---@field hideAbilities boolean?
---@field hideAbilitiesMode string?
---@field showGCD boolean?
---@field showStacks boolean?
---@field rangeIndicator boolean?
---@field requireResource boolean?
---@field squareIcons boolean?
---@field borderThickness number?
---@field iconZoom number?
---@field rectangularIcons boolean?
---@field rectangularIconsPercent number?
---@field stackAnchor string?
---@field stackFontName string?
---@field stackFontFlags table<string, boolean>?
---@field stackFontSize number?
---@field stackOffsetX number?
---@field stackOffsetY number?
---@field cooldownFontEnabled boolean?
---@field cooldownFontName string?
---@field cooldownFontFlags table<string, boolean>?
---@field cooldownFontSize number|string?
---@field cooldownTextOffsetX number?
---@field cooldownTextOffsetY number?
---@field showKeybinds boolean?
---@field keybindAnchor string?
---@field keybindFontName string?
---@field keybindFontFlags table<string, boolean>?
---@field keybindFontSize number?
---@field keybindOffsetX number?
---@field keybindOffsetY number?

---@class CMCEditModeConfig
---@field [string] CMCEditModeFrameConfig Dynamic custom trackers and buff containers.
---@field tracker1 CMCEditModeFrameConfig
---@field tracker2 CMCEditModeFrameConfig
---@field buffContainer1 CMCEditModeFrameConfig
---@field buffContainer2 CMCEditModeFrameConfig
---@field nativeEssential CMCEditModeFrameConfig
---@field nativeUtility CMCEditModeFrameConfig
---@field nativeBuffIcons CMCEditModeFrameConfig
---@field nativeBuffBar CMCEditModeFrameConfig

---@class CMCTrackerEntryConfig
---@field state string?
---@field order number?
---@field alwaysShow boolean?
---@field hiddenForSpecs table<number, boolean>?
---@field procGlow boolean? False disables the Blizzard proc glow; nil/true enables it.
---@field glowWhenReady boolean?
---@field glowOnFullCharges boolean?
---@field glowColor number[]?
---@field stackColor number[]?
---@field auraSpellID number?
---@field customActiveDuration number?
---@field useRealAura boolean?
---@field soundWhenReady boolean?
---@field readySound string?
---@field ttsWhenReady boolean?
---@field readyTTSText string?

---@class CMCTrackerConfig
---@field itemSettings table<number, CMCTrackerEntryConfig>?
---@field spellItemSettings table<number, CMCTrackerEntryConfig>?
---@field wildcardSlotSettings table<string, CMCTrackerEntryConfig>?
---@field itemViewerLayouts table?
---@field showUnusable boolean?
---@field showPassiveTrinkets boolean?

---@class CMCProfile
---@field [string] any Imported profiles and legacy migrations may contain additional keys.
---@field cooldownManager_alignBuffIcons_growFromDirection string
---@field cooldownManager_alignBuffBars_growFromDirection string
---@field cooldownManager_centerEssential_growFromDirection string
---@field cooldownManager_centerUtility_growFromDirection string
---@field cooldownManager_utility_dimWhenNotOnCD boolean
---@field cooldownManager_utility_dimOpacity number
---@field cooldownManager_cooldownFontName string
---@field cooldownManager_cooldownFontFlags table<string, boolean>
---@field cooldownManager_cooldownFontSizeEssential_enabled boolean
---@field cooldownManager_cooldownFontSizeEssential number|string
---@field cooldownManager_cooldownFontSizeUtility_enabled boolean
---@field cooldownManager_cooldownFontSizeUtility number|string
---@field cooldownManager_cooldownFontSizeBuffIcons_enabled boolean
---@field cooldownManager_cooldownFontSizeBuffIcons number|string
---@field cooldownManager_cooldownFontSizeTracker_enabled boolean
---@field cooldownManager_cooldownFontSizeTracker number|string
---@field cooldownManager_cooldownTextEssential_offsetX number
---@field cooldownManager_cooldownTextEssential_offsetY number
---@field cooldownManager_cooldownTextUtility_offsetX number
---@field cooldownManager_cooldownTextUtility_offsetY number
---@field cooldownManager_cooldownTextBuffIcons_offsetX number
---@field cooldownManager_cooldownTextBuffIcons_offsetY number
---@field cooldownManager_cooldownTextTracker_offsetX number
---@field cooldownManager_cooldownTextTracker_offsetY number
---@field cooldownManager_stackFontName string
---@field cooldownManager_stackFontFlags table<string, boolean>
---@field cooldownManager_stackFontSizeEssential number?
---@field cooldownManager_stackFontSizeUtility number?
---@field cooldownManager_stackFontSizeBuffIcons number?
---@field cooldownManager_stackAnchorEssential_enabled boolean
---@field cooldownManager_stackAnchorEssential_point string
---@field cooldownManager_stackAnchorEssential_offsetX number
---@field cooldownManager_stackAnchorEssential_offsetY number
---@field cooldownManager_stackAnchorUtility_enabled boolean
---@field cooldownManager_stackAnchorUtility_point string
---@field cooldownManager_stackAnchorUtility_offsetX number
---@field cooldownManager_stackAnchorUtility_offsetY number
---@field cooldownManager_stackAnchorBuffIcons_enabled boolean
---@field cooldownManager_stackAnchorBuffIcons_point string
---@field cooldownManager_stackAnchorBuffIcons_offsetX number
---@field cooldownManager_stackAnchorBuffIcons_offsetY number
---@field cooldownManager_squareIcons_Essential boolean
---@field cooldownManager_squareIconsBorder_Essential number
---@field cooldownManager_squareIconsBorder_Essential_Overlap boolean
---@field cooldownManager_squareIconsZoom_Essential number
---@field cooldownManager_squareIcons_Utility boolean
---@field cooldownManager_squareIconsBorder_Utility number
---@field cooldownManager_squareIconsBorder_Utility_Overlap boolean
---@field cooldownManager_squareIconsZoom_Utility number
---@field cooldownManager_squareIcons_BuffIcons boolean
---@field cooldownManager_squareIconsBorder_BuffIcons number
---@field cooldownManager_squareIconsBorder_BuffIcons_Overlap boolean
---@field cooldownManager_squareIconsZoom_BuffIcons number
---@field cooldownManager_squareIcons_BuffBar boolean
---@field cooldownManager_squareIconsBorder_BuffBar number
---@field cooldownManager_squareIconsZoom_BuffBar number
---@field cooldownManager_buffBarBorder number
---@field cooldownManager_buffBarTexture string
---@field cooldownManager_buffBarSwapIconPosition boolean
---@field cooldownManager_buffBarHigherBars boolean
---@field cooldownManager_buffBarFontEnabled boolean
---@field cooldownManager_buffBarFontName string
---@field cooldownManager_buffBarFontFlags table<string, boolean>
---@field cooldownManager_buffBarFontSize number
---@field cooldownManager_keybindFontName string
---@field cooldownManager_keybindFontFlags table<string, boolean>
---@field cooldownManager_showKeybinds_Essential boolean
---@field cooldownManager_keybindAnchor_Essential string
---@field cooldownManager_keybindFontSize_Essential number
---@field cooldownManager_keybindOffsetX_Essential number
---@field cooldownManager_keybindOffsetY_Essential number
---@field cooldownManager_showKeybinds_Utility boolean
---@field cooldownManager_keybindAnchor_Utility string
---@field cooldownManager_keybindFontSize_Utility number
---@field cooldownManager_keybindOffsetX_Utility number
---@field cooldownManager_keybindOffsetY_Utility number
---@field cooldownManager_showKeybinds_CMCTracker boolean
---@field cooldownManager_keybindAnchor_CMCTracker string
---@field cooldownManager_keybindFontSize_CMCTracker number
---@field cooldownManager_keybindOffsetX_CMCTracker number
---@field cooldownManager_keybindOffsetY_CMCTracker number
---@field cooldownManager_limitUtilitySizeToEssential boolean
---@field cooldownManager_showHighlight_Essential boolean
---@field cooldownManager_showHighlight_Utility boolean
---@field cooldownManager_windwalkerComboHelper_enabled boolean
---@field cooldownManager_buttonPress boolean
---@field cooldownManager_buttonPress_texture string
---@field cooldownManager_hideRangeCheck boolean
---@field cooldownManager_alwaysSaturated_Essential boolean
---@field cooldownManager_alwaysSaturated_Utility boolean
---@field cooldownManager_normalizeUtilitySize boolean
---@field cooldownManager_visibility_perViewer table?
---@field cooldownManager_hideCooldownFlash boolean
---@field cooldownManager_customSwipeColor_enabled boolean
---@field cooldownManager_customActiveColor_r number
---@field cooldownManager_customActiveColor_g number
---@field cooldownManager_customActiveColor_b number
---@field cooldownManager_customActiveColor_a number
---@field cooldownManager_customCDSwipeColor_r number
---@field cooldownManager_customCDSwipeColor_g number
---@field cooldownManager_customCDSwipeColor_b number
---@field cooldownManager_customCDSwipeColor_a number
---@field cooldownManager_desaturate_under_aura boolean
---@field cooldownManager_hide_gcd boolean
---@field cooldownManager_experimental_glow_style string
---@field cooldownManager_experimental_glow_custom_color boolean
---@field cooldownManager_experimental_glow_color_r number
---@field cooldownManager_experimental_glow_color_g number
---@field cooldownManager_experimental_glow_color_b number
---@field cooldownManager_experimental_glow_color_a number
---@field cooldownManager_hide_glow_on_active_aura boolean
---@field cooldownManager_glow_only_in_combat boolean
---@field cooldownManager_experimental_enableRectangularIcons_essential boolean
---@field cooldownManager_experimental_enableRectangularIcons_essential_percent number
---@field cooldownManager_experimental_enableRectangularIcons_utility boolean
---@field cooldownManager_experimental_enableRectangularIcons_utility_percent number
---@field cooldownManager_experimental_enableRectangularIcons_buffIcons boolean
---@field cooldownManager_experimental_enableRectangularIcons_buffIcons_percent number
---@field trinketRacialTracker_squareIcons boolean
---@field trinketRacialTracker_borderThickness number
---@field trinketRacialTracker_iconZoom number
---@field trinketRacialTracker_rectangularIcons boolean
---@field trinketRacialTracker_rectangularIcons_percent number
---@field trinketRacialTracker_stackAnchor string
---@field trinketRacialTracker_stackFontSize number
---@field trinketRacialTracker_stackOffsetX number
---@field trinketRacialTracker_stackOffsetY number
---@field tracker_enabled boolean
---@field tracker CMCTrackerConfig
---@field tracker_count number
---@field editMode_helper_enabled boolean
---@field cooldownStyleSettings table
---@field editMode CMCEditModeConfig

---@class CMCDB: db
---@field profile CMCProfile

-- Default Settings
---@type { global: table, profile: CMCProfile }
ns.DEFAULT_SETTINGS = {
    global = GLOBAL_SETTINGS_JUST_DEFAULTS,
    profile = {
        editMode_customFramesEnabled = true,
        -- editMode_helper_enabled = true,
        cooldownManager_alignBuffIcons_growFromDirection = "CENTER",
        cooldownManager_alignBuffBars_growFromDirection = "BOTTOM",
        cooldownManager_centerEssential_growFromDirection = "TOP",
        cooldownManager_centerUtility_growFromDirection = "TOP",

        cooldownManager_utility_dimWhenNotOnCD = false,
        cooldownManager_utility_dimOpacity = 0,

        cooldownManager_cooldownFontName = "NIL",
        cooldownManager_cooldownFontFlags = { OUTLINE = true },
        cooldownManager_cooldownFontSizeEssential_enabled = false,
        cooldownManager_cooldownFontSizeEssential = "NIL",
        cooldownManager_cooldownFontSizeUtility_enabled = false,
        cooldownManager_cooldownFontSizeUtility = "NIL",
        cooldownManager_cooldownFontSizeBuffIcons_enabled = false,
        cooldownManager_cooldownFontSizeBuffIcons = "NIL",
        cooldownManager_cooldownFontSizeTracker_enabled = false,
        cooldownManager_cooldownFontSizeTracker = "NIL",

        -- Cooldown text offsets for native viewers plus legacy tracker values
        -- retained only as the source for per-tracker style migration.
        cooldownManager_cooldownTextEssential_offsetX = 0,
        cooldownManager_cooldownTextEssential_offsetY = 0,
        cooldownManager_cooldownTextUtility_offsetX = 0,
        cooldownManager_cooldownTextUtility_offsetY = 0,
        cooldownManager_cooldownTextBuffIcons_offsetX = 0,
        cooldownManager_cooldownTextBuffIcons_offsetY = 0,
        cooldownManager_cooldownTextTracker_offsetX = 0,
        cooldownManager_cooldownTextTracker_offsetY = 0,

        cooldownManager_stackFontName = "NIL",
        cooldownManager_stackFontFlags = { OUTLINE = true },

        cooldownManager_stackFontSizeEssential = nil,
        cooldownManager_stackFontSizeUtility = nil,
        cooldownManager_stackFontSizeBuffIcons = nil,

        cooldownManager_stackAnchorEssential_enabled = false,
        cooldownManager_stackAnchorEssential_point = "BOTTOMRIGHT",
        cooldownManager_stackAnchorEssential_offsetX = -2,
        cooldownManager_stackAnchorEssential_offsetY = 2,

        cooldownManager_stackAnchorUtility_enabled = false,
        cooldownManager_stackAnchorUtility_point = "BOTTOMRIGHT",
        cooldownManager_stackAnchorUtility_offsetX = -2,
        cooldownManager_stackAnchorUtility_offsetY = 2,

        cooldownManager_stackAnchorBuffIcons_enabled = false,
        cooldownManager_stackAnchorBuffIcons_point = "BOTTOMRIGHT",
        cooldownManager_stackAnchorBuffIcons_offsetX = -2,
        cooldownManager_stackAnchorBuffIcons_offsetY = 2,

        -- Square Icons Styling
        cooldownManager_squareIcons_Essential = false,
        cooldownManager_squareIconsBorder_Essential = 1,
        cooldownManager_squareIconsBorder_Essential_Overlap = false,
        cooldownManager_squareIconsZoom_Essential = 0.3,

        cooldownManager_squareIcons_Utility = false,
        cooldownManager_squareIconsBorder_Utility = 1,
        cooldownManager_squareIconsBorder_Utility_Overlap = false,
        cooldownManager_squareIconsZoom_Utility = 0.3,

        cooldownManager_squareIcons_BuffIcons = false,
        cooldownManager_squareIconsBorder_BuffIcons = 1,
        cooldownManager_squareIconsBorder_BuffIcons_Overlap = false,
        cooldownManager_squareIconsZoom_BuffIcons = 0.3,

        -- Tracked Buff Bar Styling
        cooldownManager_squareIcons_BuffBar = false,
        cooldownManager_squareIconsBorder_BuffBar = 1,
        cooldownManager_squareIconsZoom_BuffBar = 0.3,
        cooldownManager_buffBarBorder = 1,
        cooldownManager_buffBarTexture = "NIL",
        cooldownManager_buffBarSwapIconPosition = false,
        cooldownManager_buffBarHigherBars = false,
        cooldownManager_buffBarFontEnabled = false,
        cooldownManager_buffBarFontName = "NIL",
        cooldownManager_buffBarFontFlags = { OUTLINE = true },
        cooldownManager_buffBarFontSize = 12,

        -- Keybinds Display
        cooldownManager_keybindFontName = "NIL",
        cooldownManager_keybindFontFlags = { OUTLINE = true },

        cooldownManager_showKeybinds_Essential = false,
        cooldownManager_keybindAnchor_Essential = "TOPRIGHT",
        cooldownManager_keybindFontSize_Essential = 14,
        cooldownManager_keybindOffsetX_Essential = -3,
        cooldownManager_keybindOffsetY_Essential = -3,

        cooldownManager_showKeybinds_Utility = false,
        cooldownManager_keybindAnchor_Utility = "TOPRIGHT",
        cooldownManager_keybindFontSize_Utility = 10,
        cooldownManager_keybindOffsetX_Utility = -3,
        cooldownManager_keybindOffsetY_Utility = -3,

        cooldownManager_showKeybinds_CMCTracker = false,
        cooldownManager_keybindAnchor_CMCTracker = "TOPRIGHT",
        cooldownManager_keybindFontSize_CMCTracker = 10,
        cooldownManager_keybindOffsetX_CMCTracker = -3,
        cooldownManager_keybindOffsetY_CMCTracker = -3,

        cooldownManager_limitUtilitySizeToEssential = false,

        -- Rotation Highlight (Assisted Combat)
        cooldownManager_showHighlight_Essential = false,
        cooldownManager_showHighlight_Utility = false,
        cooldownManager_windwalkerComboHelper_enabled = false,

        cooldownManager_buttonPress = false,
        cooldownManager_buttonPress_texture = "Blizzard",

        -- Disable Blizzard's out-of-range dimming on Essential/Utility icons.
        cooldownManager_hideRangeCheck = false,

        -- Keep every cooldown icon in the selected viewer category saturated.
        cooldownManager_alwaysSaturated_Essential = false,
        cooldownManager_alwaysSaturated_Utility = false,

        -- Icon Size Normalization
        cooldownManager_normalizeUtilitySize = false,

        -- Per-viewer visibility rules (populated by CMCVisibility:MigrateSettings on first load).
        -- Intentionally absent from defaults so migration can detect first-run and copy old settings.
        -- cooldownManager_visibility_perViewer = {},

        cooldownManager_hideCooldownFlash = false,

        cooldownManager_customSwipeColor_enabled = false,
        cooldownManager_customActiveColor_r = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.r,
        cooldownManager_customActiveColor_g = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.g,
        cooldownManager_customActiveColor_b = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.b,
        cooldownManager_customActiveColor_a = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.a,
        cooldownManager_customCDSwipeColor_r = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.r,
        cooldownManager_customCDSwipeColor_g = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.g,
        cooldownManager_customCDSwipeColor_b = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.b,
        cooldownManager_customCDSwipeColor_a = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.a,

        cooldownManager_desaturate_under_aura = false,
        cooldownManager_hide_gcd = false,

        cooldownManager_experimental_glow_style = "DEFAULT",
        cooldownManager_experimental_glow_custom_color = false,
        cooldownManager_experimental_glow_color_r = 1,
        cooldownManager_experimental_glow_color_g = 210 / 255,
        cooldownManager_experimental_glow_color_b = 0,
        cooldownManager_experimental_glow_color_a = 1,

        cooldownManager_hide_glow_on_active_aura = false,
        cooldownManager_glow_only_in_combat = true,

        cooldownManager_experimental_enableRectangularIcons_essential = false,
        cooldownManager_experimental_enableRectangularIcons_essential_percent = 0.8,
        cooldownManager_experimental_enableRectangularIcons_utility = false,
        cooldownManager_experimental_enableRectangularIcons_utility_percent = 0.8,
        cooldownManager_experimental_enableRectangularIcons_buffIcons = false,
        cooldownManager_experimental_enableRectangularIcons_buffIcons_percent = 0.8,

        -- Legacy shared tracker style retained only for one-time migration.
        trinketRacialTracker_squareIcons = false,
        trinketRacialTracker_borderThickness = 1,
        trinketRacialTracker_iconZoom = 0.3,
        trinketRacialTracker_rectangularIcons = false,
        trinketRacialTracker_rectangularIcons_percent = 0.8,
        trinketRacialTracker_stackAnchor = "BOTTOMRIGHT",
        trinketRacialTracker_stackFontSize = 14,
        trinketRacialTracker_stackOffsetX = -1,
        trinketRacialTracker_stackOffsetY = 1,

        tracker_enabled = false,
        tracker = {},
        -- Number of active custom trackers (contiguous 1..N, max MAX_TRACKERS).
        -- Auto-reconciled to keep one empty trailing tracker; defaults to 2.
        tracker_count = 2,
        cooldownStyleSettings = {
            spellSettings = {},
        },
        editMode = {
            tracker1 = {},
            tracker2 = {},
            buffContainer1 = {},
            buffContainer2 = {},
            nativeEssential = {},
            nativeUtility = {},
            nativeBuffIcons = {},
            nativeBuffBar = {},
        },
    },
}
