if GetLocale() ~= "zhTW" then return end  -- Traditional Chinese

local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- Common

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "豐碩探究"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "缺少必需的插件：%s" -- `%s`: name of the missing AddOn, e.g. DelveCompanion

-- Delves List

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<Shift + 左鍵：設置地下堡的路徑點>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "路徑點設置"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<Shift + 左鍵：清空路徑點>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "請使用 MapPinEnhanced 追蹤器來移除此路徑點。"

-- !!! Formatting note: Symbol "~" in the following text is used to split the string into 2 separate parts in the code. It's not shown in the actual locale. No spaces around.
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S1 = "應得的懲罰: |cnHIGHLIGHT_FONT_COLOR:Zekvir|r~地心之戰 賽季1"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S2 = "應得的懲罰: |cnHIGHLIGHT_FONT_COLOR:The Underpin|r~地心之戰 賽季2"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S3 = "應得的懲罰: |cnHIGHLIGHT_FONT_COLOR:Ky'Veza|r~地心之戰 賽季3"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_MIDNIGHT_S1 = "應得的懲罰: |cnHIGHLIGHT_FONT_COLOR:Nullaeus|r~至暗之夜 賽季1"

-- Delves UI

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_TWW = "在卡茲阿爾加地區時可獲取鍍金儲物箱進度"
Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA_MIDNIGHT = "造訪奎爾薩拉斯區域來觀看進度"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "僅出現在 |cnNORMAL_FONT_COLOR:難度 11|r 豐碩探究|A:delves-bountiful:16:16|a。"
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "任意難度11豐碩探究可啟動進度"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<點擊來顯示探究的拾取資訊>"

-- Loot Info

Lockit.UI_LOOT_INFO_DESCRIPTION = "完成探究可獲得戰利品："

-- Delves Gossip
Lockit.UI_DELVE_AUTO_ENTER_SELECTED_TIER = "Auto Enter (Tier %d)" -- %d is a Tier number (1-11).
Lockit.UI_DELVE_AUTO_ENTER_INFO = "The selected Tier can be changed in Addon Options."
Lockit.UI_DELVE_AUTO_ENTER_CANCEL_TOOLTIP_INSTRUCTION = "<點擊來取消自動進入>"

-- Tooltips Extension

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "寶箱裡獲取的鑰匙數量"

-- Compartment (these are shown hovering over the addon in the corresponding dropdown menu)

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "|cnGREEN_FONT_COLOR:左鍵點擊|r 來開啟當前賽季探究資訊。"
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "右鍵點擊變更選項。"

-- Settings

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "帳號設置"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "探究的進度資訊"
Lockit.UI_SETTING_DELVES_LIST_INFO_WIDGETS_TOOLTIP = "冒險指南-探究：顯示探究成就進度（劇情和探索）。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "路徑點追蹤類型"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "選擇哪種類型的路徑點用於導航。\n\n可能的選項:"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- Blizzard的地圖標記 (遊戲內建的導航)"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- TomTom路徑點"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- MapPinEnhanced 路徑點。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s (%s)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "使用Blizzard的地圖標記。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "使用TomTom路徑點。"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "使用 MapPinEnhanced 路徑點。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_CONTROL_NAME = "探究中部件"
Lockit.UI_SETTING_IN_DELVE_WIDGET_CONTROL_TOOLTIP = "啟用探究內顯示的小部件。它用作獎勵地圖、當季首領誘餌等的剩餘和快速施法選單。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_NAME = "顯示位置"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_TOOLTIP = "小部件要顯示在哪。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_NAME = "左側"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_DESCRIPTION = "小部件顯示在目標追踪器的左側。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_NAME = "右側"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_DESCRIPTION = "小部件顯示在目標追踪器的右側。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_CUSTOM_NAME = "自訂"
Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_CUSTOM_DESCRIPTION = "小部件可以在螢幕上自由移動。|cnGREEN_FONT_COLOR:右鍵點擊|r 並拖曳小部件以移動它。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_NAME = "按鈕布局"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_TOOLTIP = "小部件按鈕的排列方式。"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_VERTICAL_NAME = "垂直布局"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_VERTICAL_DESCRIPTION = "The buttons are arranged vertically."
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_HORIZONTAL_NAME = "水平布局"
Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_HORIZONTAL_DESCRIPTION = "The buttons are arranged horizontally."
Lockit.UI_SETTING_STORY_STATUS_IN_GOSSIP_NAME = "故事變體狀態"
Lockit.UI_SETTING_STORY_STATUS_IN_GOSSIP_TOOLTIP = "在進入探究時在視窗突出顯示啟用的故事變體是否已完成 (需要探究博學大師成就)。"
Lockit.UI_SETTING_MINIMAP_ICON_NAME = "顯示小地圖按鈕"
Lockit.UI_SETTING_MINIMAP_ICON_TOOLTIP = "顯示小地圖圖示。點擊它可以快速訪問本賽季探究資訊。"
Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_NAME = "自動進入探究"
Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_TOOLTIP = "Enter a Delve automatically reaching its entrance.\n\nThe Delve won't be entered if:\n- The Tier has not been unlocked yet.\n- It's a Nemesis Delve.\n- It's a Bountiful Delve but you don't have a |cnIQ4:Restored Coffer Key|r nor enough |cnIQ3:Coffer Key Shards|r to assemble the key."
Lockit.UI_SETTING_DELVE_AUTO_ENTER_TIER_TOOLTIP = "要進入的探究層級。"
Lockit.UI_SETTING_DELVE_AUTO_ENTER_DELAY_NAME = "進入延遲"
Lockit.UI_SETTING_DELVE_AUTO_ENTER_DELAY_TOOLTIP = "將延遲進入探究 (以秒計)。\n\n顯示的視窗中有一個進入探究的按鈕。在延遲時間倒數結束前，可以點選取消自動進入。"

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "角色設置"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "提示的額外資訊"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "在提示中顯示額外資訊 (例如 本週收到的 |cnIQ4:復原的寶庫鑰匙|r 的數量)。"
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "夥伴設置組件"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "探究介面: 啟用一個組件來顯示當前夥伴的專精與技能。\n它可用於直接從探究介面修改配置。"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "水平佈局"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "一個緊湊的佈局，其按鈕水平排列。夥伴模型保持完整。"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "垂直佈局"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "一個詳細的佈局，垂直排列的按鈕。夥伴模型為隱藏。"
Lockit.UI_SETTING_GV_DETAILS_NAME = "自訂寶庫"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "探究介面: 直接在探究介面顯示寶庫獎勵與進度 (與探究相關的)。 "
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "探究總覽部分"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "探究介面: 顯示一個額外的總覽部分。它包含有關鍍金儲物箱，可用的豐碩探究及與探究相關的貨幣和物品的訊息。"

Lockit.UI_SETTING_LOGS_NAME = "啟用偵錯紀錄"
Lockit.UI_SETTING_LOGS_TOOLTIP = "允許在聊天中列印偵錯日誌。用於開發和測試目的。"

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "特別鳴謝翻譯者："

Lockit.UI_SETTINGS_LINKS_TITLE = "連結"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "點擊複製 |cnNORMAL_FONT_COLOR:CurseForge|r 插件頁面網址。"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "點擊複製 |cnNORMAL_FONT_COLOR:Wago.io|r 插件頁面網址。"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "點擊複製 |cnNORMAL_FONT_COLOR:WoW Interface|r 插件頁面網址。"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "點擊複製 |cnNORMAL_FONT_COLOR:GitHub|r 插件頁面網址。\n\n提交反饋 | 申請新功能 | 報告漏洞（您的建議將驅動插件進化）"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r 複製 |cnNORMAL_FONT_COLOR:%s|r 網址。" -- `%s`: website name, e.g. CurseForge.
