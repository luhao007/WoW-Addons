------------------------------------------------------------
-- OptionFrame.lua
--
-- Abin
-- 2017-7-08
------------------------------------------------------------

local MAX_COLUMNS = MAX_EQUIPMENT_SETS_PER_PLAYER + 1

local _, addon = ...
local L = addon.L

BINDING_HEADER_GEARMANAGEREX_TITLE = addon.name

local frame = UICreateInterfaceOptionPage("GearManagerExOptionFrame", addon.title)
addon.optionFrame = frame

local group = frame:CreateMultiSelectionGroup()
frame:AnchorToTopLeft(group)

group:AddButton(L["show toolbar"], "showToolbar", 1)
group:AddButton(L["lock toolbar"], "lockToolbar")
group:AddButton(L["numeric toolbar"], "numericToolbar")

function group:OnCheckInit(value)
	if value == "showToolbar" or value == "lockToolbar" then
		return addon.chardb[value]
	end
	return addon.db[value]
end

function group:OnCheckChanged(value, checked)
	if value == "showToolbar" or value == "lockToolbar" then
		addon.chardb[value] = checked
	else
		addon.db[value] = checked
	end
	addon:BroadcastOptionEvent(value, checked)
end

local scaleSlider = frame:CreateSlider(L["toolbar scale"], 50, 200, 5, "%d%%", 1)
scaleSlider:SetPoint("TOPLEFT", group[-1], "BOTTOMLEFT", 4, -32)

function scaleSlider:OnSliderInit()
	return addon.db.toolbarScale
end

function scaleSlider:OnSliderChanged(value)
	addon.db.toolbarScale = value
	addon:BroadcastOptionEvent("toolbarScale", value)
end

local spacingSlider = frame:CreateSlider(L["toolbar spacing"], 0, 10, nil, 1)
spacingSlider:SetPoint("TOPLEFT", scaleSlider, "BOTTOMLEFT", 0, -36)

function spacingSlider:OnSliderInit()
	return addon.db.toolbarSpacing
end

function spacingSlider:OnSliderChanged(value)
	addon.db.toolbarSpacing = value
	addon:BroadcastOptionEvent("toolbarSpacing", value)
end

local columnsSlider = frame:CreateSlider(L["toolbar columns"], 1, MAX_COLUMNS, nil, 1)
columnsSlider:SetPoint("TOPLEFT", spacingSlider, "BOTTOMLEFT", 0, -36)

function columnsSlider:OnSliderInit()
	return addon.db.toolbarColumns
end

function columnsSlider:OnSliderChanged(value)
	addon.db.toolbarColumns = value
	addon:BroadcastOptionEvent("toolbarColumns", value)
end

local resetButton = frame:CreatePressButton(L["reset toolbar"], 1)
resetButton:SetPoint("TOP", columnsSlider, "BOTTOM", 0, -24)
resetButton:SetWidth(120)

function resetButton:OnClick()
	addon.chardb.showToolbar = 1
	group[1]:SetChecked(1)
	addon:BroadcastOptionEvent("showToolbar", 1)
	scaleSlider:SetValue(100)
	spacingSlider:SetValue(1)
	addon:BroadcastEvent("ResetToolbarPosition")
end

addon:RegisterEventCallback("OnInitialize", function(db, dbIsNew, chardb, chardbIsNew)
	if chardbIsNew then
		chardb.showToolbar = 1
	end

	if type(db.toolbarScale) ~= "number" or db.toolbarScale < 50 or db.toolbarScale > 200 then
		db.toolbarScale = 100
	end

	if type(db.toolbarSpacing) ~= "number" or db.toolbarSpacing < 0 or db.toolbarSpacing > 10 then
		db.toolbarSpacing = 3
	end

	if type(db.toolbarColumns) ~= "number" or db.toolbarColumns < 1 or db.toolbarColumns > MAX_COLUMNS then
		db.toolbarColumns = MAX_COLUMNS
	end

	addon:BroadcastOptionEvent("showToolbar", chardb.showToolbar)
	addon:BroadcastOptionEvent("numericToolbar", db.numericToolbar)
	addon:BroadcastOptionEvent("toolbarScale", db.toolbarScale)
	addon:BroadcastOptionEvent("toolbarSpacing", db.toolbarSpacing)
	addon:BroadcastOptionEvent("toolbarColumns", db.toolbarColumns)
end)