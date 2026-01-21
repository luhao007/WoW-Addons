local addonName, addonTable = ...;
local gsub = _G.string.gsub
local L ={}
addonTable.locale=L
local function removeColons(s)
	local s=s:gsub("：", "")
	local s=s:gsub(":", "")
    return s
end
L["RECORD"] = removeColons(PVP_RECORD)
