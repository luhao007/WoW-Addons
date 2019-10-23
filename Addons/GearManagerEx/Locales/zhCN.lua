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
	["put into bank"] = "放入银行",
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
	["toolbar title"] = "套装快捷条",
	["lock"] = "锁定快捷条",
	["hide tooltip"] = "隐藏提示标签",
	["numeric"] = "数字模式",
	["button columns"] = "按钮列数",
	["scale"] = "框体缩放",
	["spacing"] = "按钮间距",
	["please type value"] = "请输入\"%s\"数值 (%d-%d):",
	["hide toolbar"] = "隐藏快捷条",
	["show toolbar"] = "显示快捷条",
	["reset toolbar"] = "重置快捷条",
}