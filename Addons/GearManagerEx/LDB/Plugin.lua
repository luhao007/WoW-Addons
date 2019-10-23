------------------------------------------------------------
-- Plugin.lua
--
-- Abin
-- 2016/11/04
------------------------------------------------------------

local NONE_ICON = 132597

local _, addon = ...
local L = addon.L

local plugin = LibStub("LibDataBroker-1.1"):NewDataObject("LDB_GearManagerEx", {
	type = "data source",
	icon = NONE_ICON,
	text = addon.title,
})

local menu = CreateFrame("Frame", "GearManagerExLDBDropDownMenu", UIParent, "UIDropDownMenuTemplate")
menu.xOffset = 0
menu.yOffset = 0

local function OnMenuClick(self, index)
	addon:EquipSetByIndex(index)
end

UIDropDownMenu_Initialize(menu, function()
	UIDropDownMenu_AddButton({ text = addon.title, isTitle = 1, notCheckable = 1 })

	local i
	for i = 1, addon:GetNumEquipmentSets() do
		local name, icon, _, equipped = addon:GetEquipmentSetInfo(i)
		UIDropDownMenu_AddButton({ text = name, icon = icon, func = OnMenuClick, arg1 = i, checked = equipped })
	end
end, "MENU")

function plugin:OnClick(arg1)
	GameTooltip:Hide()
	if arg1 == "RightButton" then
		addon.optionFrame:Open()
	else
		local point, relativePoint
		if self:GetBottom() > 500 then
			point = "TOPLEFT"
			relativePoint = "BOTTOMLEFT"
		else
			point = "BOTTOMLEFT"
			relativePoint = "TOPLEFT"
		end

		menu.point = point
		menu.relativeTo = self
		menu.relativePoint = relativePoint
		ToggleDropDownMenu(nil, nil, menu)
	end
end

function plugin.OnTooltipShow(tooltip)
	tooltip:AddLine(addon.title)
	tooltip:AddLine(plugin.text, 0, 1, 0, 1)
	tooltip:AddLine(KEY_BUTTON1..": "..L["select set"], 1, 1, 1, 1)
	tooltip:AddLine(KEY_BUTTON2..": "..OPTIONS_MENU, 1, 1, 1, 1)
end

addon:RegisterEventCallback("OnSetEquipped", function(name, icon)
	plugin.icon = icon or NONE_ICON
	plugin.text = name or addon.title
end)