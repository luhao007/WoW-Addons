local L = LibStub('AceLocale-3.0'):NewLocale('PetBattleScripts', 'zhCN')
if not L then return end

L["ADDON_NAME"] = "宠物对战脚本"
L["DATABASE_UPDATE_BASE_TO_FIRSTENEMY_NOTIFICATION"] = "发现你之前使用过修改版的tdBattlePetScript，已将修改版的Base选择器的部分脚本迁移到FirstEnemy选择器。"
L["DATABASE_UPDATED_TO"] = "更新到版本："
L["DEFAULT_NEW_SCRIPT_NAME"] = "新建脚本"
L["DIRECTOR_TEST_NEXT_ACTION"] = "下一个动作"
L["EDITOR_CREATE_SCRIPT"] = "创建脚本"
L["EDITOR_EDIT_SCRIPT"] = "修改脚本"
L["IN_BATTLE_DEBUGGING_SCRIPT"] = "调试脚本"
L["IN_BATTLE_EXECUTE"] = "自动对战"
L["IN_BATTLE_NO_SCRIPT"] = "没有脚本"
L["IN_BATTLE_SELECT_SCRIPT"] = "选择脚本"
L["OPTION_AUTO_SELECT_SCRIPT_BY_ORDER"] = "自动根据脚本选择器优先级选择脚本"
L["OPTION_AUTO_SELECT_SCRIPT_ONLY_ONE"] = "只有一个脚本时自动选择"
L["OPTION_AUTOBUTTON_HOTKEY"] = "自动按钮快捷键"
L["OPTION_AUTOBUTTON_HOTKEY_SECONDARY"] = "(次)"
L["OPTION_EDITOR_FONT_FACE"] = "字体"
L["OPTION_EDITOR_FONT_SIZE"] = "字体大小"
L["OPTION_HIDE_MINIMAP"] = "隐藏小地图图标"
L["OPTION_HIDE_SELECTOR_NO_SCRIPT"] = "没有脚本时不显示脚本选择器"
L["OPTION_LOCK_SCRIPT_SELECTOR"] = "锁定脚本选择器"
L["OPTION_NO_WAIT_DELETE_SCRIPT"] = "删除脚本时不等待"
L["OPTION_NOTIFY_BUTTON_ACTIVE"] = "当“自动对战”按钮激活时播放音效"
L["OPTION_NOTIFY_BUTTON_ACTIVE_SOUND"] = "音效"
L["OPTION_RESET_FRAMES"] = "重置面板大小与位置"
L["OPTION_SCRIPTSELECTOR_NOTES"] = "在这里你可以管理脚本选择器是否开启以及脚本选择器的优先级。"
L["OPTION_SETTINGS_HIDE_MINIMAP_TOOLTIP"] = "修改这项设置需要重新载入UI，是否继续？"
L["OPTION_TEST_BREAK"] = "Debug: test 命令中断脚本"
L["REMATCH_NOTE_SCRIPT_EXPORT_ADD_TO_NOTE_MENU_ITEM"] = "添加脚本到备注"
L["REMATCH_NOTE_SCRIPT_IMPORT_FAIL"] = [=[导入Rematch队伍备注中的脚本失败：
%s]=]
L["REMATCH_NOTE_SCRIPT_IMPORT_FAIL_EXIST_DIFFERENT"] = "已存在不同的脚本。请删除备注或脚本。"
L["REMATCH_NOTE_SCRIPT_IMPORT_FAIL_LINE"] = "- 队伍 \"%s\": %s"
L["REMATCH4_DEPRECATED"] = [=[Rematch 4 已经过时，宠物对战脚本插件将于2025年中停止对其的支持。请升级到 Rematch 5。

另外，请在 Curseforge 或 GitHub 上通知我们，因为我们想要统计 Rematch 4 的用户数量是否与我们的假设相符。]=]
L["SCRIPT_EDITOR_AUTOFORMAT_SCRIPT"] = "美化脚本"
L["SCRIPT_EDITOR_DELETE_SCRIPT_CONFIRMATION"] = "你确定要|cffff0000删除|r脚本 |cffffd000[%s - %s]|r 么？"
L["SCRIPT_EDITOR_FOUND_ERROR"] = "发现错误"
L["SCRIPT_EDITOR_LABEL_TOGGLE_EXTRA"] = "切换扩展信息编辑器"
L["SCRIPT_EDITOR_NAME_TITLE"] = "脚本名称"
L["SCRIPT_EDITOR_RUN_BUTTON"] = "运行"
L["SCRIPT_EDITOR_SAVE_SUCCESS"] = "保存成功"
L["SCRIPT_EDITOR_TEXTAREA_TITLE"] = "脚本"
L["SCRIPT_EDITOR_TITLE"] = "脚本编辑器"
L["SCRIPT_MANAGER_TITLE"] = "脚本管理器"
L["SCRIPT_MANAGER_TOGGLE"] = "切换脚本管理器"
L["SCRIPT_SELECTOR_TITLE"] = "脚本选择器"
L["SCRIPT_SELECTOR_TOGGLE"] = "切换脚本选择器"
L["SELECTOR_ALLINONE_NOTES"] = "所有小宠物战斗都可以使用这个脚本。"
L["SELECTOR_ALLINONE_TITLE"] = "All in one"
L["SELECTOR_BASE_ALLY"] = "我方阵容"
L["SELECTOR_BASE_ENEMY"] = "敌方阵容"
L["SELECTOR_BASE_NOTES"] = "这个脚本选择器将脚本绑定到对阵双方的完整阵容。"
L["SELECTOR_BASE_TITLE"] = "基础"
L["SELECTOR_FIRSTENEMY_NOTES"] = "这个脚本选择器将脚本绑定到战斗的第一个敌人。"
L["SELECTOR_FIRSTENEMY_TITLE"] = "First enemy"
L["SELECTOR_REMATCH_4_TO_5_UPDATE_NOTE"] = [=[已从 Rematch 4 更新至 Rematch 5。请检查你的脚本是否仍然正确地关联到相应队伍。\n
若更新失败，请从 wow/WTF/Account//SavedVariables/tdBattlePetScript.lua 中恢复备份，或打开这个文件，搜索 Rematch 并将其移除或替换为 Rematch5，搜索 Rematch4 并将其替换为 Rematch，然后请重新安装 Rematch 4。如果可能，请在 https://github.com/axc450/pbs/issues/new 上提交一份 bug 报告，并以附件的形式上传 SavedVariables 目录下与 Rematch 和此插件相关的文件。]=]
L["SELECTOR_REMATCH_4_TO_5_UPDATE_ORPHAN"] = [=[发现名为“%s”的脚本被关联到 Rematch 中不存在的队伍（队伍ID为：%s）。\n
这可能意味着更新数据库的过程中出现了问题，或是数据在以前就已经损坏。请在脚本浏览器中删除这支孤立的队伍，然后重新与正确的队伍相关联。 如果类似的错误发生在许多队伍身上，请提交一份 bug 报告。]=]
L["SELECTOR_REMATCH_CANT_FORMAT_TOOLTIP_REMATCH_NOT_LOADED"] = "无法显示信息：Rematch插件未加载"
L["SELECTOR_REMATCH_NO_TEAM_FOR_SCRIPT"] = "没有与此脚本相关联的队伍"
L["SELECTOR_REMATCH_NOTES"] = "脚本选择器将与Rematch队伍绑定"
L["SELECTOR_REMATCH_TEAM_FORMAT"] = "队伍：%s"
--[[ L["SELECTOR_REMATCH_TITLE"] = "Rematch" --]]
L["SHARE_EXPORT_SCRIPT"] = "导出"
L["SHARE_IMPORT_CHOOSE_KEY"] = "请选择关建值..."
L["SHARE_IMPORT_CHOOSE_SELECTOR"] = "请选择脚本选择器..."
L["SHARE_IMPORT_LABEL_ALREADY_EXISTS_CHECKBOX"] = "覆盖并继续导入"
L["SHARE_IMPORT_LABEL_ALREADY_EXISTS_WARNING"] = "这个匹配模式下已存在脚本，继续导入将覆盖当前脚本。"
L["SHARE_IMPORT_LABEL_HAS_EXTRA"] = "导入的字符串中包含除脚本以外的其他数据。数据的内容取决于脚本组件，通常来说这些额外数据与相应的宠物队伍有关。"
L["SHARE_IMPORT_PLUGIN_NOT_ENABLED"] = "无法导入：未启用组件"
L["SHARE_IMPORT_REINPUT_TEXT"] = "重新编辑"
L["SHARE_IMPORT_SCRIPT"] = "导入"
L["SHARE_IMPORT_SCRIPT_EXISTS"] = "已存在脚本"
L["SHARE_IMPORT_SCRIPT_NOT_IMPORT_STRING_WARNING"] = "你输入了脚本，建议你使用分享码导入，当然你也可以继续导入。"
L["SHARE_IMPORT_SCRIPT_WELCOME"] = "复制分享字符串或脚本到输入框。"
L["SHARE_IMPORT_STRING_INCOMPLETE"] = "分享字符串数据不全。但依然可以导入。"
L["TOOLTIP_CREATE_OR_DEBUG_SCRIPT"] = "创建或调试脚本"
