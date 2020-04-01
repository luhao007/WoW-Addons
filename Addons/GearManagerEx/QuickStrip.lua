------------------------------------------------------------
-- Quickstrip.lua
--
-- Abin
-- 2011-8-22
------------------------------------------------------------

local InCombatLockdown = InCombatLockdown
local GetContainerNumSlots = GetContainerNumSlots
local select = select
local GetContainerItemInfo = GetContainerItemInfo
local type = type
local GetInventoryItemLink = GetInventoryItemLink
local PickupInventoryItem = PickupInventoryItem
local CursorHasItem = CursorHasItem
local PutItemInBackpack = PutItemInBackpack
local PutItemInBag = PutItemInBag
local pairs = pairs
local EquipCursorItem = EquipCursorItem
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local HasFullControl = HasFullControl
local GetTime = GetTime
local format = format
local strmatch = strmatch
local ClearCursor = ClearCursor
local UIErrorsFrame = UIErrorsFrame

local _, addon = ...
local L = addon.L
local INV_SLOTS = { 16, 17, 18, 5, 7, 1, 3, 8, 10, 6, 9, 2, 15, 11, 12, 13, 14 } -- Priorities for strip

local artifactMap = {
	[128866] = 128867, -- Paladin pro
	[128289] = 128288, -- Warrior pro
	[128943] = 137246, -- Warlock dem
}

local lastOpt = 0 -- Last operated time

local button = CreateFrame("Button", addon.name.."ActionButton_QuickStrip", UIParent, "SecureActionButtonTemplate")
addon.quickStripButton = button
button:SetAttribute("type", "macro")
addon:RegisterBindingClick(button, "GEARMANAGEREX_QUICKSTRIP", L["quick strip"])

addon:RegisterEventCallback("OnEquipsChanged", function()
	if InCombatLockdown() then
		return
	end

	local link = GetInventoryItemLink("player", 16)
	local mh = link and strmatch(link, "%[(.+)%]")
	if not mh then
		return
	end

	local macroText = "/equip [combat] "..mh

	local link = GetInventoryItemLink("player", 17)
	local oh = link and strmatch(link, "%[(.+)%]")
	if oh then
		macroText = macroText.."\n/equip [combat] "..oh
	end

	button:SetAttribute("macroText", macroText)
end)

local function IsCombatLocked(slot)
	return (slot ~= 16 and slot ~= 17) and InCombatLockdown()
end

local function GetItemLocked()
	local bag, slot
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			if select(3, GetContainerItemInfo(bag, slot)) then
				return bag, slot
			end
		end
	end
end

-- Find available bag slots to put items into
local function GetAvailableBags()
	local bags = {}
	local i
	for i = 0, 4 do
		local slots, family = GetContainerNumFreeSlots(i)
		bags[i] = (family == 0) and slots or 0
	end
	return bags
end

local function GetFirstAvailableBag(bags)
	local i
	for i = 0, 4 do
		if bags[i] > 0 then
			return i
		end
	end
end

local function FindContainerItem(lnk, allowLocked)
	if type(lnk) ~= "string" then
		return
	end

	local itemId = tonumber(strmatch(lnk, "Hitem:(%d+)"))

	local bag, slot
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local _, _, locked, _, _, _, link = GetContainerItemInfo(bag, slot)
			if (allowLocked or not locked) then
				if link == lnk then
					return bag, slot
				end

				local id = GetContainerItemID(bag, slot)
				if artifactMap[id] == itemId then
					return bag, slot
				end
			end
		end
	end
end

local function VerifyStrippedDB()
	local hasContents
	if type(addon.chardb.stripped) == "table" then
		local inv, lnk
		for inv, lnk in pairs(addon.chardb.stripped) do
			if type(inv) == "number" and not GetInventoryItemLink("player", inv) and FindContainerItem(lnk, 1) then
				hasContents = 1
			else
				addon.chardb.stripped[inv] = nil
			end
		end
	end

	if not hasContents then
		addon.chardb.stripped = nil
	end

	return hasContents
end

-- Strip off all items those have durabilities
local function StripOff()
	local bags = GetAvailableBags()
	local count = 0
	local i
	for i = 1, #INV_SLOTS do
		local inv = INV_SLOTS[i]
		local lnk = GetInventoryItemLink("player", inv)
		if lnk and not IsCombatLocked(inv) then
			local bag = GetFirstAvailableBag(bags)
			if bag then
				bags[bag] = bags[bag] - 1
				PickupInventoryItem(inv)
				if CursorHasItem() then
					if bag == 0 then
						PutItemInBackpack()
					else
						PutItemInBag(19 + bag)
					end

					if not addon.chardb.stripped then
						addon.chardb.stripped = {}
					end

					addon.chardb.stripped[inv] = lnk
					count = count + 1
				end
			else
				addon:Print(ERR_INV_FULL, 1, 0, 0)
				return count
			end
		end
	end
	return count
end

-- Wear back whatever we stripped off through a previous call to StripOff()
local function WearBack()
	local count = 0
	local inv, lnk
	for inv, lnk in pairs(addon.chardb.stripped) do
		local bag, slot = FindContainerItem(lnk)
		if bag and slot then
			PickupContainerItem(bag, slot)
			if CursorHasItem() then
				EquipCursorItem(inv)
				count = count + 1
			end
		end
	end

	VerifyStrippedDB()
	return count
end

button:SetScript("PostClick", function(self)
	if UnitIsDeadOrGhost("player") or not HasFullControl() or GetItemLocked() then
		UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0)
		return
	end

	if GetTime() - lastOpt < 1.5 then
		addon:Print(L["too fast"], 1, 0, 0)
		return
	end

	ClearCursor()
	if VerifyStrippedDB() then
		if not InCombatLockdown() then
			addon:Print(format(L["wore back"], WearBack()))
		end
	else
		addon:Print(format(L["stripped off"], StripOff()))
	end
	lastOpt = GetTime()
end)