------------------------------------------------------------
-- zhTW.lua
-- 繁體中文

-- Abin
-- 2011/8/22
------------------------------------------------------------

if GetLocale() ~= "zhTW" then return end
local _, addon = ...
addon.L = {
	["wear set"] = "穿上套裝",
	["save set"] = "保存套裝",
	["rename set"] = "重命名套裝",
	["delete set"] = "刪除套裝",
	["put into bank"] = "放入銀行",
	["take from bank"] = "從銀行取出",
	["wore set"] = "當前裝備的套裝為 |cff00ff00%s|r。",
	["quick strip"] = "一鍵脫光",
	["too fast"] = "你進行脫光/穿回動作過于快速，請稍候片刻以防出錯。",
	["wore back"] = "已穿回 |cff00ff00%d|r 件裝備。",
	["stripped off"] = "已脫下 |cff00ff00%d|r 件裝備。",
	["tooltip prompt"] = "<點擊右鍵進行套裝高級選項>",
	["set saved"] = "套裝 |cff00ff00%s|r 已保存。",
	["bind to"] = "綁定於",
	["open"] = "打開",
	["set hotkey"] = "套裝快捷鍵",
	["name exists"] = "套裝名稱 |cff00ff00%s|r 已存在，請輸入一個新名稱。",
	["set renamed"] = "套裝 |cff00ff00%s|r 已被重命名為 |cff00ff00%s|r。",
	["label text"] = "將套裝 |cff00ff00%s|r 重命名為：",
	["toolbar title"] = "套裝快捷列",
	["lock"] = "鎖定快捷列",
	["hide tooltip"] = "隱藏提示標籤",
	["numeric"] = "數字模式",
	["button columns"] = "按鈕列數",
	["scale"] = "框架縮放",
	["spacing"] = "按鈕間距",
	["please type value"] = "請輸入\"%s\"數值 (%d-%d):",
	["hide toolbar"] = "隱藏快捷列",
	["show toolbar"] = "顯示快捷列",
	["reset toolbar"] = "重置快捷列",
}