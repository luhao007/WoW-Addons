-----------------------------------------------------------
-- Core.lua
--
-- Abin
-- 2013-10-04
-----------------------------------------------------------

local HideDropDownMenu = HideDropDownMenu
local format = format
local GetEquipmentSetInfoByName = GetEquipmentSetInfoByName
local ipairs = ipairs
local GetContainerNumSlots = GetContainerNumSlots
local UseContainerItem = UseContainerItem
local InCombatLockdown = InCombatLockdown
local GetEquipmentSetItemIDs = GetEquipmentSetItemIDs
local pairs = pairs
local SaveEquipmentSet = SaveEquipmentSet
local RecalculateGearManagerDialogPopup = RecalculateGearManagerDialogPopup
local StaticPopup_Show = StaticPopup_Show
local type = type
local wipe = wipe
local tinsert = tinsert
local EquipmentManager_EquipSet = EquipmentManager_EquipSet
local GameTooltip = GameTooltip
local GearManagerDialogPopup = GearManagerDialogPopup
local MAX_EQUIPMENT_SETS_PER_PLAYER = MAX_EQUIPMENT_SETS_PER_PLAYER

local addon = LibAddonManager:CreateAddon(...)
local L = addon.L

addon:RegisterDB("GearManagerExDB", 1)
addon:RegisterSlashCmd("/gearmanagerex", "/gmex")

local equipmentSets = {}
local actionButtons = {}

function addon:OnInitialize(db, dbIsNew, chardb, chardbIsNew)
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	self:BroadcastEvent("OnInitialize", db, dbIsNew, chardb, chardbIsNew)
	self:EQUIPMENT_SETS_CHANGED()
end

function addon:EQUIPMENT_SETS_CHANGED()
	if InCombatLockdown() then
		self.needUpdate = 1
		return
	end

	wipe(equipmentSets)
	local i
	for i = 0, MAX_EQUIPMENT_SETS_PER_PLAYER do
		local name = C_EquipmentSet.GetEquipmentSetInfo(i)
		if name then
			tinsert(equipmentSets, name)
		end
	end

	for i = 1, #equipmentSets do
		local name = equipmentSets[i]
		local button = actionButtons[i]
		button.name = name
		button:SetAttribute("macroText", "/equipset "..name)
	end

	for i = #equipmentSets + 1, self:NumSetButtons() do
		local button = self:GetSetButton(i)
		button.name = nil
		button:SetAttribute("macroText", nil)
	end

	self:BroadcastEvent("OnSetsChanged")
	self:PLAYER_EQUIPMENT_CHANGED()
end

function addon:PLAYER_EQUIPMENT_CHANGED()
	self:BroadcastEvent("OnEquipsChanged")
	local name, icon = self:GetFirstEquippedSet()
	if name == self.equippedName then
		return
	end

	HideDropDownMenu(1)
	self.equippedName = name
	if name then
		self:Print(format(L["wore set"], name))
	end
	self:BroadcastEvent("OnSetEquipped", name, icon)
end

function addon:OnLeaveCombat()
	if self.needUpdate then
		self.needUpdate = nil
		self:EQUIPMENT_SETS_CHANGED()
	end
end

function addon:GetNumEquipmentSets()
	return #equipmentSets
end

function addon:GetEquipmentSetInfo(name)
	if type(name) == "number" then
		name = equipmentSets[name]
	end

	if type(name) == "string" then
		return GetEquipmentSetInfoByName(name)
	end
end

-- There could be more than one sets are "equipped" any time, return the first one only
function addon:GetFirstEquippedSet()
	local i
	for i = 0, self:GetNumEquipmentSets() do
		local name, icon, id, equipped = self:GetEquipmentSetInfo(i)
		if equipped then
			return name, icon, id
		end
	end
end

function addon:IsSetEquipped(name)
	if type(name) == "string" then
		local name, _, _, equipped = GetEquipmentSetInfoByName(name)
		return equipped
	end
end

function addon:BANKFRAME_OPENED()
	self.bankOpened = 1
	HideDropDownMenu(1)
end

function addon:BANKFRAME_CLOSED()
	self.bankOpened = nil
	HideDropDownMenu(1)
end

-- Use a container item by id
local function UseContainerItemById(containers, itemId)
	local bag, slot
	for _, bag in ipairs(containers) do
		for slot = 1, GetContainerNumSlots(bag) do
			if itemId == GetContainerItemID(bag, slot) then
				-- No taint will occur while the bank is open
				UseContainerItem(bag, slot)
				print("UseContainerItem", bag, slot, itemId)
			end
		end
	end
end

-- Moves a set into bank, or take it out of bank
local BANKS = { -1, 5, 6, 7, 8, 9, 10, 11 } -- Bag id's for bank
local BAGS = { 0, 1, 2, 3, 4 } -- Bag id's for container
function addon:BankSet(set, deposit)
	if not self.bankOpened or InCombatLockdown() then
		return
	end

	local name = self:GetEquipmentSetInfo(set)
	if not name then
		return
	end

	local setids = GetEquipmentSetItemIDs(name)
	if not setids then
		return
	end

	local containers = deposit and BAGS or BANKS
	local id
	for _, id in pairs(setids) do
		if id and id > 1 then
			UseContainerItemById(containers, id)
		end
	end
end

-- Directly save a set
function addon:SaveSet(set)
	local name, icon = self:GetEquipmentSetInfo(set)
	if not name then
		return
	end

	SaveEquipmentSet(name, icon)
	self:Print(format(L["set saved"], name))
end

function addon:RenameSet(set)
	local name, icon, id = self:GetEquipmentSetInfo(set)
	if not name then
		return
	end

	GearManagerDialogPopup:Show()
	GearManagerDialogPopup.isEdit = true
	GearManagerDialogPopup.setID = id
	GearManagerDialogPopup.origName = name
	RecalculateGearManagerDialogPopup(name, icon)
end

function addon:DeleteSet(set)
	local name, _, id  = self:GetEquipmentSetInfo(set)
	if not name then
		return
	end

	local frame = StaticPopup_Show("CONFIRM_DELETE_EQUIPMENT_SET", name)
	frame.data = id
	return 1
end

-- Equip a set by index
function addon:EquipSetByIndex(index)
	if InCombatLockdown() then
		return
	end

	local name, _, id = self:GetEquipmentSetInfo(index)
	if name then
		EquipmentManager_EquipSet(id)
	end
end

do
	local i
	for i = 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
		local button = CreateFrame("Button", addon.name.."ActionButton_Set"..i, UIParent, "SecureActionButtonTemplate")
		button:SetAttribute("type", "macro")
		addon:RegisterBindingClick(button, "GEARMANAGEREX_WEARSET"..i, L["wear set"].." "..i)
		tinsert(actionButtons, button)
	end
end

function addon:NumSetButtons()
	return #actionButtons
end

function addon:GetSetButton(index)
	return actionButtons[index]
end

-- Prompt the player that he can right-click a set for more operations
hooksecurefunc("GearSetButton_OnEnter", function(self)
	if self.setID then
		GameTooltip:AddLine(L["tooltip prompt"], 0, 1, 0, 1)
		GameTooltip:Show()
	end
end)