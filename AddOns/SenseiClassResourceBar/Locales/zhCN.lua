local _, addonTable = ...

local baseLocale = {
    -- General
    ["OKAY"] = "确定",
    ["CLOSE"] = "关闭",
    ["CANCEL"] = "取消",
    ["RELOADUI"] = "重载界面",
    ["RELOADUI_TEXT"] = "部分更改需要重载界面",

    -- Import / Export errors
    ["EXPORT"] = "导出",
    ["EXPORT_BAR"] = "导出此状态条",
    ["IMPORT"] = "导入",
    ["IMPORT_BAR"] = "导入此状态条",
    ["EXPORT_FAILED"] = "导出失败.",
    ["IMPORT_FAILED_WITH_ERROR"] = "导入失败, 错误信息: ",
    ["IMPORT_STRING_NOT_SUITABLE"] = "此导入字符串不适用于",
    ["IMPORT_STRING_OLDER_VERSION"] = "此导入字符串适用于旧版本的",
    ["IMPORT_STRING_INVALID"] = "无效的导入字符串",
    ["IMPORT_DECODE_FAILED"] = "解码失败",
    ["IMPORT_DECOMPRESSION_FAILED"] = "解压失败",
    ["IMPORT_DESERIALIZATION_FAILED"] = "反序列化失败",

    -- Settings (Esc > Options > AddOns)
    ["SETTINGS_HEADER_POWER_COLORS"] = "能量颜色",
    ["SETTINGS_HEADER_HEALTH_COLOR"] = "生命值颜色",
    ["SETTINGS_CATEGORY_IMPORT_EXPORT"] = "导入/导出",
    ["SETTINGS_IMPORT_EXPORT_TEXT_1"] = "此处生成的导出字符串包含您当前编辑模式布局中的所有状态条.\n如果您希望仅导出特定状态条, 请在编辑模式的状态条设置面板中点击\n导出按钮.",
    ["SETTINGS_IMPORT_EXPORT_TEXT_2"] = "下方的导入按钮支持全局和单个状态条的导出字符串. 而编辑模式中每个状态条设置里的\n导入按钮仅限于该特定状态条.\n例如, 如果您导出了所有状态条, 但只想导入主资源条, 请在编辑模式中使用主资源条的导入按钮.",
    ["SETTINGS_BUTTON_EXPORT_ONLY_POWER_COLORS"] = "仅导出能量颜色",
    ["SETTINGS_BUTTON_EXPORT_WITH_POWER_COLORS"] = "导出包含能量颜色",
    ["SETTINGS_BUTTON_EXPORT_WITHOUT_POWER_COLORS"] = "导出不包含能量颜色",
    ["SETTINGS_BUTTON_IMPORT"] = "导入",
    ["SETTING_OPEN_AFTER_EDIT_MODE_CLOSE"] = "设置将在离开编辑模式后打开",

    -- Power
    ["HEALTH"] = "生命值",
    ["MANA"] = "法力值",
    ["RAGE"] = "怒气",
    ["WHIRLWIND"] = "旋风斩",
    ["FOCUS"] = "集中值",
    ["TIP_OF_THE_SPEAR"] = "利矛之刃",
    ["ENERGY"] = "能量",
    ["RUNIC_POWER"] = "符文能量",
    ["LUNAR_POWER"]= "月光能量",
    ["MAELSTROM"] = "漩涡值",
    ["MAELSTROM_WEAPON"] = "漩涡武器",
    ["INSANITY"] = "狂乱值",
    ["FURY"]= "恶魔之怒",
    ["BLOOD_RUNE"] = "鲜血符文",
    ["FROST_RUNE"] = "冰霜符文",
    ["UNHOLY_RUNE"] = "邪恶符文",
    ["COMBO_POINTS"] = "连击点",
    ["OVERCHARGED_COMBO_POINTS"] = "过载连击点",
    ["SOUL_SHARDS"] = "灵魂碎片",
    ["HOLY_POWER"] = "神圣能量",
    ["CHI"] = "真气",
    ["STAGGER_LOW"] = "轻度醉拳",
    ["STAGGER_MEDIUM"] ="中度醉拳",
    ["STAGGER_HIGH"] = "重度醉拳",
    ["ARCANE_CHARGES"] = "奥术充能",
    ["ICICLES"] = "冰刺",
    ["SOUL_FRAGMENTS_VENGEANCE"] = "复仇灵魂残片",
    ["SOUL_FRAGMENTS_DDH"] = "噬灭灵魂残片",
    ["SOUL_FRAGMENTS_VOID_META"] = "噬灭灵魂残片虚空形态.",
    ["ESSENCE"]= "精华",
    ["EBON_MIGHT"] = "黑檀之力",

    -- Bar names
    ["HEALTH_BAR_EDIT_MODE_NAME"] = "生命条",
    ["PRIMARY_POWER_BAR_EDIT_MODE_NAME"] = "主资源条",
    ["SECONDARY_POWER_BAR_EDIT_MODE_NAME"] = "次资源条",
    ["TERNARY_POWER_BAR_EDIT_MODE_NAME"] = "第三资源条",

    -- Bar visibility category - Edit Mode
    ["CATEGORY_BAR_VISIBILITY"] = "状态条可见性",
    ["BAR_VISIBLE"] = "状态条可见",
    ["BAR_STRATA"] = "状态条层级",
    ["BAR_STRATA_TOOLTIP"] = "状态条渲染的图层",
    ["HIDE_WHILE_MOUNTED_OR_VEHICULE"] = "骑乘或载具时隐藏",
    ["HIDE_WHILE_MOUNTED_OR_VEHICULE_TOOLTIP"] = "包括德鲁伊旅行形态",
    ["HIDE_MANA_ON_ROLE"] = "按职责隐藏法力值",
    ["HIDE_MANA_ON_ROLE_PRIMARY_BAR_TOOLTIP"] = "对奥法无效",
    ["HIDE_CUSTOM_RESOURCES"] = "隐藏自定义资源",
    ["HIDE_HEALTH_ON_ROLE"] = "按职责隐藏",
    ["HIDE_BLIZZARD_UI"] = "隐藏暴雪默认界面",
    ["HIDE_BLIZZARD_UI_HEALTH_BAR_TOOLTIP"] = "隐藏默认的暴雪玩家框架界面",
    ["HIDE_BLIZZARD_UI_SECONDARY_POWER_BAR_TOOLTIP"] = "隐藏默认的暴雪次级资源界面(例如死亡骑士的符文框架)",
    ["ENABLE_HP_BAR_MOUSE_INTERACTION"] = "可点击生命条",
    ["ENABLE_HP_BAR_MOUSE_INTERACTION_TOOLTIP"] = "在生命条上启用玩家框架的默认点击功能.",

    -- Position & Size category - Edit Mode
    ["CATEGORY_POSITION_AND_SIZE"] = "位置与尺寸",
    ["POSITION"] = "位置",
    ["X_POSITION"] = "X坐标",
    ["Y_POSITION"] = "Y坐标",
    ["RELATIVE_FRAME"] = "相对框架",
    ["RELATIVE_FRAME_TOOLTIP"] = "由于限制, 如果锚定到非UIParent的其他框架, 您可能无法拖拽框架. 请使用X/Y滑块",
    ["RELATIVE_FRAME_CYCLIC_WARNING"] = "无法更改相对框架, 因为所选框架已相对此框架.",
    ["ANCHOR_POINT"] = "锚点",
    ["RELATIVE_POINT"] = "相对点",
    ["BAR_SIZE"] = "状态条尺寸",
    ["WIDTH_MODE"] = "宽度模式",
    ["WIDTH"] = "宽度",
    ["MINIMUM_WIDTH"] = "最小宽度",
    ["MINIMUM_WIDTH_TOOLTIP"] = "0为禁用. 仅在同步到冷却计时管理器时生效",
    ["HEIGHT"] = "高度",

    -- Bar settings category - Edit Mode
    ["CATEGORY_BAR_SETTINGS"] = "状态条设置",
    ["FILL_DIRECTION"] = "填充方向",
    ["FASTER_UPDATES"] = "更快的更新(更高的CPU使用)",
    ["SMOOTH_PROGRESS"] = "平滑进度",
    ["SHOW_TICKS_WHEN_AVAILABLE"] = "可用时显示刻度",
    ["TICK_THICKNESS"] = "刻度粗细",

    -- Bar style category - Edit Mode
    ["CATEGORY_BAR_STYLE"] = "状态条样式",
    ["USE_CLASS_COLOR"] = "使用职业颜色",
    ["USE_RESOURCE_TEXTURE_AND_COLOR"] = "使用资源材质和颜色",
    ["BAR_TEXTURE"] = "状态条材质",
    ["BAR_BACKGROUND"] = "背景",
    ["USE_BAR_COLOR_FOR_BACKGROUND_COLOR"] = "使用状态条颜色作为背景色",
    ["BAR_BORDER"] = "边框",
    
    --  (Heal) Absorb bar style category - Edit Mode
    ["CATEGORY_ABSORB_BAR_STYLE"] = "吸收条样式",
    ["CATEGORY_HEAL_ABSORB_BAR_STYLE"] = "治疗吸收条样式",
    ["ENABLE"] = "启用",
    ["ABSORB_BAR_POSITION"] = "样式",
    ["HEAL_ABSORB_BAR_POSITION"] = "样式",

    -- Text settings category - Edit Mode
    ["CATEGORY_TEXT_SETTINGS"] = "文本设置",
    ["SHOW_RESOURCE_NUMBER"] = "显示资源数值",
    ["RESOURCE_NUMBER_FORMAT"] = "格式",
    ["RESOURCE_NUMBER_FORMAT_TOOLTIP"] = "部分资源不支持百分比格式",
    ["RESOURCE_NUMBER_PRECISION"] = "精度",
    ["RESOURCE_NUMBER_ALIGNMENT"] = "对齐方式",
    ["SHOW_MANA_AS_PERCENT"] = "以百分比显示法力值",
    ["SHOW_MANA_AS_PERCENT_TOOLTIP"] = "强制对法力值使用百分比格式",
    ["SHOW_RESOURCE_CHARGE_TIMER"] = "显示资源充能计时器(例如符文)",
    ["CHARGE_TIMER_PRECISION"] = "充能计时器精度",

    -- Font category - Edit Mode
    ["CATEGORY_FONT"] = "字体",
    ["FONT"] = "字体",
    ["FONT_SIZE"] = "大小",
    ["FONT_OUTLINE"] = "描边",

    -- Other
    ["POWER_COLOR_SETTINGS"] = "能量颜色设置",
    
    -- Edit Mode Settings dropdown --

    -- Visibility Options
    ["ALWAYS_VISIBLE"] = "始终可见",
    ["IN_COMBAT"] = "战斗中",
    ["HAS_TARGET_SELECTED"] = "选中目标时",
    ["HAS_TARGET_SELECTED_OR_IN_COMBAT"] = "选中目标或战斗中",
    ["HIDDEN"] = "隐藏",

    -- Strata Options -- Maybe keep it the same in all language ?
    ["TOOLTIP"] = "提示框",
    ["DIALOG"] = "对话框",
    ["HIGH"] = "高",
    ["MEDIUM"] = "中",
    ["LOW"] = "低",
    ["BACKGROUND"] = "背景",

    -- Role Options
    ["TANK"] = "坦克",
    ["HEALER"] = "治疗",
    ["DPS"] = "伤害输出",

    -- Position Options
    ["POSITION_SELF"] = "自身位置",
    ["USE_HEALTH_BAR_POSITION_IF_HIDDEN"] = "隐藏时使用生命条位置",
    ["USE_PRIMARY_RESOURCE_BAR_POSITION_IF_HIDDEN"] = "隐藏时使用主资源条位置",
    ["USE_SECONDARY_RESOURCE_BAR_POSITION_IF_HIDDEN"] = "隐藏时使用副资源条位置",

    -- Frame Names
    ["UI_PARENT"] = "界面父框体",
    ["HEALTH_BAR"] = "生命条",
    ["PRIMARY_RESOURCE_BAR"] = "主资源条",
    ["SECONDARY_RESOURCE_BAR"] = "副资源条",
    ["PLAYER_FRAME"] = "玩家框体",
    ["TARGET_FRAME"] = "目标框体",
    ["ESSENTIAL_COOLDOWNS"] = "重要冷却技能",
    ["UTILITY_COOLDOWNS"] = "功能冷却技能",
    ["TRACKED_BUFFS"] = "追踪的增益效果",
    ["ACTION_BAR"] = "动作条",
    ["ACTION_BAR_X"] = "动作条%d",

    -- Anchor & Relative Points -- Maybe keep it the same in all language ?
    ["TOPLEFT"] = "左上",
    ["TOP"] = "上",
    ["TOPRIGHT"] = "右上",
    ["LEFT"] = "左",
    ["CENTER"] = "居中",
    ["RIGHT"] = "右",
    ["BOTTOMLEFT"] = "左下",
    ["BOTTOM"] = "下",
    ["BOTTOMRIGHT"] = "右下",

    -- Width Modes
    ["MANUAL"] = "手动",
    ["SYNC_WITH_ESSENTIAL_COOLDOWNS"] = "与重要冷却技能同步",
    ["SYNC_WITH_UTILITY_COOLDOWNS"] = "与功能冷却技能同步",
    ["SYNC_WITH_TRACKED_BUFFS"] = "与追踪的增益效果同步",

    -- Fill Directions
    ["LEFT_TO_RIGHT"] = "从左到右",
    ["RIGHT_TO_LEFT"] = "从右到左",
    ["TOP_TO_BOTTOM"] = "从上到下",
    ["BOTTOM_TO_TOP"] = "从下到上",
    
    -- (Heal) Absorb Bar Styles
    ["BAR_POSITION_FIXED"] = "固定",
    ["BAR_POSITION_REVERSED"] = "反向",
    ["BAR_POSITION_ATTACH_HEALTH"] = "附加到生命条",


    -- Outline Styles -- Maybe keep it the same in all language ?
    ["NONE"] = "无",
    ["OUTLINE"] = "细轮廓",
    ["THICKOUTLINE"] = "粗轮廓",

    -- Text Formats
    ["CURRENT"] = "当前值",
    ["CURRENT_MAXIMUM"] = "当前值/最大值",
    ["PERCENT"] = "百分比",
    ["PERCENT_SYMBOL"] = "百分比%",
    ["CURRENT_PERCENT"] = "当前值 - 百分比",
    ["CURRENT_PERCENT_SYMBOL"] = "当前值 - 百分比%",
}

addonTable:RegisterLocale("zhCN", baseLocale)
