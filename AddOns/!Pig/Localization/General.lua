local addonName, addonTable = ...;
local gsub = _G.string.gsub
local L ={}
addonTable.locale=L
--local locale1 = GetAvailableLocales()
local function removeColons(s)
	local s=s:gsub("：", "")
	local s=s:gsub(":", "")
    return s
end
L["TIME"] = removeColons(TIME_LABEL)
L["RECORD"] = removeColons(PVP_RECORD)
L["RELOADUI1"] = "%s\n|cff00FF00%s|r?\n("..RELOADUI..")"
L["RELOADUI2"] = "%s\n|cffFF0000"..RESET_TO_DEFAULT.."?|r\n("..RELOADUI..")"