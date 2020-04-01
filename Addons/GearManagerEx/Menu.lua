------------------------------------------------------------
-- Menu.lua
--
-- Abin
-- 2011-8-22
------------------------------------------------------------

local type = type
local HideDropDownMenu = HideDropDownMenu
local ToggleDropDownMenu = ToggleDropDownMenu
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local GetNumSpecializations = GetNumSpecializations
local GetSpecializationInfo = GetSpecializationInfo
local GameTooltip = GameTooltip
local PaperDollEquipmentManagerPane = PaperDollEquipmentManagerPane

local _, addon = ...
local L = addon.L
local curName, curIcon, curId

function addon:SetMenuSet(set)
	local name, icon, id = self:GetEquipmentSetInfo(set)
	if curName ~= name or curId ~= id then
		HideDropDownMenu(1)
	end
	curName, curIcon, curId = name, icon, id
end

function addon:GetMenuSet()
	return curName, curId
end

local function OnMenuResaveSet()
	addon:SaveSet(curName)
end

local function OnMenuDeleteSet()
	addon:DeleteSet(curName)
end

local function OnMenuRenameSet()
	addon:RenameSet(curName)
end

local function OnMenuDepositSet()
	addon:BankSet(curName, 1)
end

local function OnMenuWithdrawSet()
	addon:BankSet(curName)
end

local function OnMenuSpecBind(self, spec, assigned)
	if spec == assigned then
		C_EquipmentSet.UnassignEquipmentSetSpec(curId)
	else
		C_EquipmentSet.AssignSpecToEquipmentSet(curId, spec)
	end
end

-- The drop down frame for set buttons
local frame = CreateFrame("Button", "GearManagerExDropDownMenu", PaperDollEquipmentManagerPane, "UIDropDownMenuTemplate")
local lastOwner
function addon:ToggleMenu(parent, point, relativeTo, relativePoint, xOffset, yOffset)
	if not curName then
		HideDropDownMenu(1)
		return
	end

	frame:SetParent(parent or UIParent)
	frame.point = point
	frame.relativeTo = relativeTo
	frame.relativePoint = relativePoint
	frame.xOffset = type(xOffset) == "number" and yOffset or 0
	frame.yOffset = type(yOffset) == "number" and yOffset or 0

	if lastOwner ~= relativeTo then
		lastOwner = relativeTo
		HideDropDownMenu(1)
	end

	ToggleDropDownMenu(nil, nil, frame)
	return 1
end

function addon:BuildMenu()
	if not curId then
		return
	end

	UIDropDownMenu_AddButton({ text = curName, isTitle = 1, icon = curIcon, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["save set"], disabled = addon.equippedName and addon.equippedName ~= curName, func = OnMenuResaveSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["delete set"], func = OnMenuDeleteSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["rename set"], func = OnMenuRenameSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["put into bank"], disabled = not addon.bankOpened, func = OnMenuDepositSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["take from bank"], disabled = not addon.bankOpened, func = OnMenuWithdrawSet, notCheckable = 1 })

	local assigned = C_EquipmentSet.GetEquipmentSetAssignedSpec(curId)
	local i
	for i = 1, GetNumSpecializations() do
		local _, name, _, icon = GetSpecializationInfo(i)
		UIDropDownMenu_AddButton({ text = L["bind to"]..name, icon = icon, checked = assigned == i, func = OnMenuSpecBind, arg1 = i, arg2 = assigned })
	end

	UIDropDownMenu_AddButton({ text = CLOSE, notCheckable = 1 })
end

UIDropDownMenu_Initialize(frame, addon.BuildMenu, "MENU")

-- Hook "OnMouseDown" for every button to show the drop down menu
local function GearSetButton_OnMouseDown(self, button)
	if button == "RightButton" and type(self.setID) == "number" then
		addon:SetMenuSet(self.setID)
		addon:ToggleMenu(PaperDollEquipmentManagerPane, "TOPLEFT", self, "BOTTOMLEFT", -4, -4)
	end
	GameTooltip:Hide()
end

do
	local i
	for i = 1, 10 do
		local button = _G["PaperDollEquipmentManagerPaneButton"..i]
		if button then
			button:HookScript("OnMouseDown", GearSetButton_OnMouseDown)
			button.EditButton:EnableMouse(false)
			button.EditButton:SetAlpha(0)
			button.DeleteButton:EnableMouse(false)
			button.DeleteButton:SetAlpha(0)
		end
	end
end