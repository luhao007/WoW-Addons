local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@class Lockit
local Lockit = setmetatable(
    {},
    {
        __index = function(_, ...)
            Logger:Log("Key is not found in the Lockit: `%s`!", ...)
        end
    }
)
DelveCompanion.Lockit = Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- #region Lockit rules
--[[
- The default locale: enUS. It contains all the keys used by the addon.
- Other languages override existing keys with a corresponding translation.
- The main intent: all locales should follow in-game terms, tiltes, names, etc. Conditions when this rule can be broken:
--- To fit the text into UI. However, each case is considered separately to find the best solution.
--- There is another "word" widely used in a community to name something. E.g. `iLvl` is a common substitution for `Item Level` regardless of the language.
- Keys should have a prefixe to indicate a kind of a key:
--- UI
--- DATA
--- CONFIG
--- etc
- Keys may have a description to provide context where they are used if it matters.
]]
-- #endregion

-- #region DEFAULT LOCKIT (enUS)

-- Common

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "Bountiful Delve"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "Required AddOn is missing: %s" -- `%s`: name of the missing AddOn, e.g. DelveCompanion

-- Delves List

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<Shift click to set waypoint to the delve>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "Waypoint set."
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<Shift click to clear the waypoint>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "Please use MapPinEnhanced Tracker to remove the waypoint."

-- !!! Formatting note: Symbol "~" in the following text is used to split the string into 2 separate parts in the code. It's not shown in the actual locale. No spaces around.
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S1 = "Nemesis: |cnHIGHLIGHT_FONT_COLOR:Zekvir|r~The War Within Season 1"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S2 = "Nemesis: |cnHIGHLIGHT_FONT_COLOR:The Underpin|r~The War Within Season 2"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S3 = "Nemesis: |cnHIGHLIGHT_FONT_COLOR:Ky'Veza|r~The War Within Season 3"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_MIDNIGHT_S1 = "Nemesis: |cnHIGHLIGHT_FONT_COLOR:Nullaeus|r~Midnight Season 1"

-- Delves UI

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_TWW = "Visit Khaz Algar zones to see the progress"
Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_MIDNIGHT = "Visit Quel'Thalas zones to see the progress"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "Appears only in |cnNORMAL_FONT_COLOR:Tier 11|r Bountiful Delves|A:delves-bountiful:16:16|a."
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "No active delves"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<Click to display Delves' Loot info>"

-- Loot Info

Lockit.UI_LOOT_INFO_DESCRIPTION = "Complete a delve to get:"

-- Delves Gossip
Lockit.UI_DELVE_AUTO_ENTER_CANCEL_TOOLTIP_INSTRUCTION = "<Click to cancel auto entering>"

-- Tooltips Extension

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "Keys from Caches"

-- Compartment (these are shown hovering over the addon in the corresponding dropdown menu)

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "|cnGREEN_FONT_COLOR:Left Click|r to open the Delves' current season window."
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "|cnGREEN_FONT_COLOR:Right Click|r to access Addon Options."

-- Settings

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "Account-Wide"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "Delve's Progress Info"
Lockit.UI_SETTING_DELVES_LIST_INFO_WIDGETS_TOOLTIP = "Delves list: Display achievements progress for each Delve (Stories and Chests)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "Waypoint Tracking Type"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "Select which type of Waypoints is used for navigation.\n\nPossible options:"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- Blizzard's Map Pin (the default in-game navigation)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- TomTom Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- MapPinEnhanced Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s %s."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "Use Blizzard's Map Pin."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "Use TomTom Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "Use MapPinEnhanced Waypoints."
Lockit.UI_SETTING_IN_DELVE_WIDGET_CONTROL_NAME = "Widget In Delves"
Lockit.UI_SETTING_IN_DELVE_WIDGET_CONTROL_TOOLTIP = "Enable a widget that is displayed inside a Delve. It serves as a remainder and a quick-cast menu for the Bounty Map, Nemesis Lure, and more."
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_NAME = "Display Location"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_TOOLTIP = "Where the widget is displayed."
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_NAME = "Left Side"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_DESCRIPTION = "Widget is displayed on the left side of Objective Tracker."
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_NAME = "Right Side"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_DESCRIPTION = "Widget is displayed on the right side of Objective Tracker."
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_CUSTOM_NAME = "Custom"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_CUSTOM_DESCRIPTION = "Widget can be freely moved around the screen. |cnGREEN_FONT_COLOR:Right Click|r and drag the widget to move it."
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_NAME = "Buttons Layout"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_TOOLTIP = "How the widget buttons are arranged."
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_VERTICAL_NAME = "Vertical Layout"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_VERTICAL_DESCRIPTION = "The buttons are arranged vertically."
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_HORIZONTAL_NAME = "Horizontal Layout"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_HORIZONTAL_DESCRIPTION = "The buttons are arranged horizontally."
Lockit.UI_SETTING_STORY_STATUS_IN_GOSSIP_NAME = "Story Variant Status"
Lockit.UI_SETTING_STORY_STATUS_IN_GOSSIP_TOOLTIP = "Highlight whether the active Story Variant has been completed or not (required for Delve Loremaster achievements) in the window displayed entering a Delve."
Lockit.UI_SETTING_MINIMAP_ICON_NAME = "Show Minimap Icon"
Lockit.UI_SETTING_MINIMAP_ICON_TOOLTIP = "Display a minimap icon. It can be clicked to open the Delves' current season window."
Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_NAME = "Auto Enter Delves"
Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_TOOLTIP = "Enter a Delve automatically reaching its entrance.\n\nThe Delve won't be entered if:\n- The Tier has not been unlocked yet.\n- It's a Nemesis Delve.\n- It's a Bountiful Delve but you don't have a |cnITEM_EPIC_COLOR:Restored Coffer Key|r nor enough |cnITEM_SUPERIOR_COLOR:Coffer Key Shards|r to assemble the key."
Lockit.UI_SETTING_DELVE_AUTO_ENTER_TIER_TOOLTIP = "Delve Tier to enter."
Lockit.UI_SETTING_DELVE_AUTO_ENTER_DELAY_NAME = "Enter Delay"
Lockit.UI_SETTING_DELVE_AUTO_ENTER_DELAY_TOOLTIP = "A Delve will be entered with a delay (in seconds).\n\nThere is a button in the window displayed entering a Delve. It can be clicked to cancel the auto entering before the delay countdown elapsed."

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "Character-Wide"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "Extra Info in Tooltips"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "Display additional information in tooltips (e.g., whether |cnITEM_EPIC_COLOR:Bounty Map|r has been looted this week)."
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "Companion Configuration Widget"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "Delves UI: Enable a widget that displays the Companion's current specialization and abilities.\nIt can be used to modify the configuration directly from the Delves UI.\nNote: layout type doesn't affect the functionality, only visual arrangement."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "Horizontal Layout"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "A compact layout with the buttons arranged horizontally. The Companion model is shown."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "Vertical Layout"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "A more detailed layout with the buttons arranged vertically. The Companion model is hidden."
Lockit.UI_SETTING_GV_DETAILS_NAME = "Custom Great Vault"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "Delves UI: Display Great Vault rewards and progress (relevant for Delves) directly in the Delves UI."
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "Delves Overview Section"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "Delves UI: Display an additional Overview section. It contains information about Gilded Stash, available Bountiful Delves, and Delve-related consumables."

Lockit.UI_SETTING_LOGS_NAME = "Enable Debug Logs"
Lockit.UI_SETTING_LOGS_TOOLTIP = "Allows to print debug logs in the chat. Used for development and testing purposes."

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "Special thanks for the translation contribution:"

Lockit.UI_SETTINGS_LINKS_TITLE = "Links"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:CurseForge|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:Wago.io|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:WoW Interface|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:GitHub|r.\n\nShare feedback, request new features, or report a bug. It helps making the addon even better!"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r to copy the |cnNORMAL_FONT_COLOR:%s|r URL." -- `%s`: website name, e.g. CurseForge.
-- #endregion

-- #region Internal keys. These ARE NOT intended to be translated.

-- Shared

Lockit.UI_ADDON_NAME = "Delve Companion"
Lockit.UI_DELVE_STORY_VARIANT_COMPLETED_SEQUENCE = format("%s %s", "|A:common-icon-checkmark:15:15|a", _G["CRITERIA_COMPLETED"])
Lockit.UI_DELVE_STORY_VARIANT_NOT_COMPLETED_SEQUENCE = format("%s %s", "|A:QuestLegendary:15:15|a", _G["CRITERIA_NOT_COMPLETED"])

-- Debug

Lockit.DEBUG_UNEXPECTED_ENUM_ELEMENT = "Enum `%s` doesn't contain element: %s."
Lockit.DEBUG_SAVED_VARIABLE_CONFLICT = "Save table `%s` doesn't contain a key: %s!"
-- #endregion
