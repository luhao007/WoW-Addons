
-- Gear status is requested/transmitted when opening the list.

local addonName, scope = ...
local oRA = scope.addon
local inTable = oRA.util.inTable
local module = oRA:NewModule("Gear")
local L = scope.locale

local gearTbl = {}
local syncList = {} -- list of people we have syncs from

function module:OnRegister()
	oRA:RegisterList(
		L.gear,
		gearTbl,
		L.name,
		L.itemLevel,
		L.missingGems,
		L.missingEnchants
	)
	oRA.RegisterCallback(self, "OnShutdown")
	oRA.RegisterCallback(self, "OnListSelected")
	oRA.RegisterCallback(self, "OnCommReceived")
	oRA.RegisterCallback(self, "OnGroupChanged")
	oRA.RegisterCallback(self, "OnPlayerInspect")

	SLASH_ORAGEAR1 = "/ragear"
	SlashCmdList.ORAGEAR = function()
		oRA:OpenToList(L.gear)
	end
end

function module:OnGroupChanged(_, _, members)
	for index = #gearTbl, 1, -1 do
		local player = gearTbl[index][1]
		if not inTable(members, player) then
			tremove(gearTbl, index)
			syncList[player] = nil
		end
	end
	oRA:UpdateList(L.gear)
end

function module:OnShutdown()
	wipe(gearTbl)
	wipe(syncList)
end

do
	local prev = 0
	function module:OnListSelected(_, list)
		if list == L.gear then
			-- Fill the list with all players
			for unit in self:IterateGroup() do
				local player = self:UnitName(unit)
				if player then
					local k = inTable(gearTbl, player, 1)
					if not k then
						k = #gearTbl + 1
						gearTbl[k] = { player }
					end
				end
			end

			local t = GetTime()
			if t-prev > 15 then
				prev = t
				self:SendComm("QueryGear")
				oRA:InspectGroup()
			end
		end
	end
end

function module:OnPlayerInspect(_, _, unit)
	local player = self:UnitName(unit)
	if not player or syncList[player] then return end

	local enchants, gems, ilvl = self:ScanGear(unit)
	if ilvl then
		local k = inTable(gearTbl, player, 1)
		if not k then
			k = #gearTbl + 1
			gearTbl[k] = { player }
		end
		gearTbl[k][2] = tonumber(ilvl)
		gearTbl[k][3] = tonumber(gems)
		gearTbl[k][4] = tonumber(enchants)

		oRA:UpdateList(L.gear)
	end
end

function module:OnCommReceived(_, sender, prefix, ilvl, gems, enchants)
	if prefix == "QueryGear" then
		local missingEnchants, emptySockets, equipped = self:ScanGear("player")
		self:SendComm("Gear", equipped, emptySockets, missingEnchants)
	elseif prefix == "Gear" then
		local k = inTable(gearTbl, sender, 1)
		if not k then
			k = #gearTbl + 1
			gearTbl[k] = { sender }
		end
		gearTbl[k][2] = tonumber(ilvl)
		gearTbl[k][3] = tonumber(gems)
		gearTbl[k][4] = tonumber(enchants)

		oRA:UpdateList(L.gear)
		syncList[sender] = true
	end
end

do
	local statsTable = {}
	local enchantableItems = {
		false, -- INVSLOT_HEAD -- 1
		false, -- INVSLOT_NECK -- 2
		false, -- INVSLOT_SHOULDER -- 3
		false, -- INVSLOT_BODY -- 4
		false, -- INVSLOT_CHEST -- 5
		false, -- INVSLOT_WAIST -- 6
		false, -- INVSLOT_LEGS -- 7
		false, -- INVSLOT_FEET -- 8
		false, -- INVSLOT_WRIST -- 9
		false, -- INVSLOT_HAND -- 10
		true, -- INVSLOT_FINGER1 -- 11
		true, -- INVSLOT_FINGER2 -- 12
		false, -- INVSLOT_TRINKET1 -- 13
		false, -- INVSLOT_TRINKET2 -- 14
		false, -- INVSLOT_BACK -- 15
		true, -- INVSLOT_MAINHAND -- 16
		false, -- INVSLOT_OFFHAND -- 17
	}

	function module:ScanGear(unit)
		local missingEnchants, emptySockets, averageItemLevel = 0, 0, 0

		for i = 1, 17 do
			local itemLink = GetInventoryItemLink(unit, i)
			if itemLink and i ~= 4 then -- skip the shirt
				-- http://www.wowpedia.org/ItemString
				-- item:itemID:enchantID:gemID1:gemID2:gemID3:gemID4:suffixID:uniqueID:linkLevel:specializationID:upgradeTypeID:instanceDifficultyID:numBonusIDs:bonusID1:bonusID2:...[:upgradeValue]:unknown1:unknown2:unknown3
				-- |cffff8000|Hitem:102247::::::::100:105:4:::493|h[Jina-Kang, Kindness of Chi-Ji]|h|r
				local enchant, gem1, gem2, gem3, gem4 = itemLink:match("item:%d+:(%d*):(%d*):(%d*):(%d*):(%d*):")

				-- Handle missing enchants
				if enchantableItems[i] and enchant == "" then
					missingEnchants = missingEnchants + 1
				end

				-- Handle missing gems
				local totalItemSockets = 0

				wipe(statsTable)
				GetItemStats(itemLink, statsTable)
				for k, v in next, statsTable do
					if k:find("EMPTY_SOCKET_", nil, true) then
						totalItemSockets = totalItemSockets + v
					end
				end

				local filledSockets = (gem1 == "" and 0 or 1) + (gem2 == "" and 0 or 1) + (gem3 == "" and 0 or 1) + (gem4 == "" and 0 or 1)
				local finalCount = totalItemSockets - filledSockets
				if finalCount > 0 then
					emptySockets = emptySockets + finalCount
				end
			end
		end

		if UnitIsUnit(unit, "player") then
			local _, equipped = GetAverageItemLevel()
			averageItemLevel = floor(equipped)
		else
			averageItemLevel = C_PaperDollInfo.GetInspectItemLevel(unit)
		end

		return missingEnchants, emptySockets, averageItemLevel
	end
end
