local _, ns = ...
CooldownManagerCentered = LibStub("AceAddon-3.0"):NewAddon("CooldownManagerCentered", "AceConsole-3.0")
ns.Addon = CooldownManagerCentered
local L = LibStub("AceLocale-3.0"):GetLocale("CooldownManagerCentered")
ns.L = L

-- Default Settings
ns.DEFAULT_SETTINGS = {
    profile = {
        cooldownManager_alignBuffIcons_growFromDirection = "CENTER",
        cooldownManager_alignBuffBars_growFromDirection = "BOTTOM",
        cooldownManager_centerEssential_growFromDirection = "TOP",
        cooldownManager_centerUtility_growFromDirection = "TOP",

        cooldownManager_utility_dimWhenNotOnCD = false,
        cooldownManager_utility_dimOpacity = 0.3,

        cooldownManager_cooldownFontName = "Friz Quadrata TT",
        cooldownManager_cooldownFontFlags = { OUTLINE = true },
        cooldownManager_cooldownFontSizeEssential_enabled = false,
        cooldownManager_cooldownFontSizeEssential = "NIL",
        cooldownManager_cooldownFontSizeUtility_enabled = false,
        cooldownManager_cooldownFontSizeUtility = "NIL",
        cooldownManager_cooldownFontSizeBuffIcons_enabled = false,
        cooldownManager_cooldownFontSizeBuffIcons = "NIL",
        cooldownManager_cooldownFontSizeTracker_enabled = false,
        cooldownManager_cooldownFontSizeTracker = "NIL",

        cooldownManager_stackFontName = "Friz Quadrata TT",
        cooldownManager_stackFontFlags = { OUTLINE = true },

        cooldownManager_stackFontSizeEssential = nil,
        cooldownManager_stackFontSizeUtility = nil,
        cooldownManager_stackFontSizeBuffIcons = nil,

        cooldownManager_stackAnchorEssential_enabled = false,
        cooldownManager_stackAnchorEssential_point = "BOTTOMRIGHT",
        cooldownManager_stackAnchorEssential_offsetX = 0,
        cooldownManager_stackAnchorEssential_offsetY = 0,

        cooldownManager_stackAnchorUtility_enabled = false,
        cooldownManager_stackAnchorUtility_point = "BOTTOMRIGHT",
        cooldownManager_stackAnchorUtility_offsetX = 0,
        cooldownManager_stackAnchorUtility_offsetY = 0,

        cooldownManager_stackAnchorBuffIcons_enabled = false,
        cooldownManager_stackAnchorBuffIcons_point = "BOTTOMRIGHT",
        cooldownManager_stackAnchorBuffIcons_offsetX = 0,
        cooldownManager_stackAnchorBuffIcons_offsetY = 0,

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

        -- Keybinds Display
        cooldownManager_keybindFontName = "Friz Quadrata TT",
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

        cooldownManager_buttonPress = false,
        cooldownManager_buttonPress_texture = "Blizzard",

        -- Icon Size Normalization
        cooldownManager_normalizeUtilitySize = false,

        cooldownManager_visibility_enabled_rules = {},
        cooldownManager_visibility_enabled_viewers = {
            ["BuffIconCooldownViewer"] = true,
            ["BuffBarCooldownViewer"] = true,
            ["EssentialCooldownViewer"] = true,
            ["UtilityCooldownViewer"] = true,
            ["CMCTracker1"] = true,
            ["CMCTracker2"] = true,
        },

        cooldownManager_customSwipeColor_enabled = false,
        cooldownManager_customActiveColor_r = 1,
        cooldownManager_customActiveColor_g = 0.95,
        cooldownManager_customActiveColor_b = 0.57,
        cooldownManager_customActiveColor_a = 0.69,
        cooldownManager_customCDSwipeColor_r = 0,
        cooldownManager_customCDSwipeColor_g = 0,
        cooldownManager_customCDSwipeColor_b = 0,
        cooldownManager_customCDSwipeColor_a = 0.69,

        cooldownManager_desaturate_under_aura = false,
        cooldownManager_hide_gcd = false,

        cooldownManager_experimental_layoutOptimizations = false,
        cooldownManager_experimental_disablePerSpellSettings = false,

        cooldownManager_experimental_glow_style = "DEFAULT",
        cooldownManager_experimental_glow_custom_color = false,
        cooldownManager_experimental_glow_color_r = 0.95,
        cooldownManager_experimental_glow_color_g = 0.95,
        cooldownManager_experimental_glow_color_b = 0.32,
        cooldownManager_experimental_glow_color_a = 1,

        cooldownManager_hide_glow_on_active_aura = false,

        cooldownManager_experimental_enableRectangularIcons_essential = false,
        cooldownManager_experimental_enableRectangularIcons_essential_percent = 0.8,
        cooldownManager_experimental_enableRectangularIcons_utility = false,
        cooldownManager_experimental_enableRectangularIcons_utility_percent = 0.8,
        cooldownManager_experimental_enableRectangularIcons_buffIcons = false,
        cooldownManager_experimental_enableRectangularIcons_buffIcons_percent = 0.8,

        -- used for new tracker as well - legacy name
        trinketRacialTracker_squareIcons = false,
        trinketRacialTracker_borderThickness = 1,
        trinketRacialTracker_iconZoom = 0.3,
        trinketRacialTracker_stackAnchor = "BOTTOMRIGHT",
        trinketRacialTracker_stackFontSize = 14,
        trinketRacialTracker_stackOffsetX = -1,
        trinketRacialTracker_stackOffsetY = 1,

        tracker_enabled = false,
        tracker = {},
        cooldownStyleSettings = {
            spellSettings = {},
        },
        editMode = {
            tracker1 = {},
            tracker2 = {},
        },
    },
}
