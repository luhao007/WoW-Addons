------------------------------------------------------------
-- zhTW.lua
-- 简体中文

-- Abin
-- 2011/8/22
------------------------------------------------------------

if GetLocale() ~= "zhCN" then return end
local _, addon = ...
addon.L = {
	["wear set"] = "穿上套装",
	["save set"] = "保存套装",
	["rename set"] = "重命名套装",
	["delete set"] = "删除套装",
	["put into bank"] = "存入银行",
	["take from bank"] = "从银行取出",
	["wore set"] = "当前装备的套装为 |cff00ff00%s|r。",
	["quick strip"] = "一键脱光",
	["too fast"] = "你进行脱光/穿回动作过于快速，请稍候片刻以防出错。",
	["wore back"] = "已穿回 |cff00ff00%d|r 件装备。",
	["stripped off"] = "已脱下 |cff00ff00%d|r 件装备。",
	["tooltip prompt"] = "<点击右键进行套装高级选项>",
	["set saved"] = "套装 |cff00ff00%s|r 已保存。",
	["bind to"] = "绑定于",
	["open"] = "打开",
	["set hotkey"] = "套装快捷键",
	["name exists"] = "套装名称 |cff00ff00%s|r 已存在，请输入一个新名称。",
	["set renamed"] = "套装 |cff00ff00%s|r 已被重命名为 |cff00ff00%s|r。",
	["label text"] = "将套装 |cff00ff00%s|r 重命名为：",
	["show toolbar"] = "显示快捷条",
	["lock toolbar"] = "锁定快捷条",
	["numeric toolbar"] = "数字模式",
	["toolbar scale"] = "框体缩放",
	["toolbar spacing"] = "按钮间距",
	["toolbar columns"] = "按钮列数",
	["reset toolbar"] = "重置快捷条",
	["select set"] = "选择套装",
}