-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Destroying = TSM:NewPackage("Destroying") ---@type AddonPackage
local ClientInfo = TSM.LibTSMWoW:Include("Util.ClientInfo")
local Container = TSM.LibTSMWoW:Include("API.Container")
local Spell = TSM.LibTSMWoW:Include("API.Spell")
local TradeSkill = TSM.LibTSMWoW:Include("API.TradeSkill")
local Database = TSM.LibTSMUtil:Include("Database")
local Event = TSM.LibTSMWoW:Include("Service.Event")
local SlotId = TSM.LibTSMWoW:Include("Type.SlotId")
local Table = TSM.LibTSMUtil:Include("Lua.Table")
local TempTable = TSM.LibTSMUtil:Include("BaseType.TempTable")
local ItemString = TSM.LibTSMTypes:Include("Item.ItemString")
local Conversion = TSM.LibTSMTypes:Include("Item.Conversion")
local Reactive = TSM.LibTSMUtil:Include("Reactive")
local Future = TSM.LibTSMUtil:IncludeClassType("Future")
local Log = TSM.LibTSMUtil:Include("Util.Log")
local BinarySearch = TSM.LibTSMUtil:Include("Util.BinarySearch")
local Threading = TSM.LibTSMTypes:Include("Threading")
local ItemInfo = TSM.LibTSMService:Include("Item.ItemInfo")
local CustomString = TSM.LibTSMTypes:Include("CustomString")
local Conversions = TSM.LibTSMApp:Include("Service.Conversions")
local BagTracking = TSM.LibTSMService:Include("Inventory.BagTracking")
local private = {
	combineThread = nil,
	destroyThread = nil,
	destroyThreadRunning = false,
	settings = nil,
	canDestroyCache = {},
	destroyQuantityCache = {},
	pendingCombines = {},
	newBagUpdate = false,
	pendingSpellId = nil,
	ignoreDB = nil,
	destroyInfoDB = nil,
	destroySpellId = nil,
	itemSpellId = nil,
	destroyResultCache = {},
	disenchantSkillLevel = nil,
	jewelcraftSkillLevel = nil,
	inscriptionSkillLevel = nil,
	combineFuture = Future.New("DESTROYING_COMBINE_FUTURE"),
	destroyFuture = Future.New("DESTROYING_DESTROY_FUTURE"),
	state = nil,
}
local SPELL_IDS = {
	milling = 51005,
	prospect = 31252,
	disenchant = 13262,
}
local ITEM_SUB_CLASS_METAL_AND_STONE = 7
local ITEM_SUB_CLASS_HERB = 9
local TARGET_SLOT_ID_MULTIPLIER = 1000000
local CLEANUP_TIME_THRESHOLD = 60 * 24 * 60 * 60
local CLEANUP_MAX_ENTRIES = 100
local GEM_CHIPS = {
	["i:129099"] = "i:129100",
	["i:130200"] = "i:129100",
	["i:130201"] = "i:129100",
	["i:130202"] = "i:129100",
	["i:130203"] = "i:129100",
	["i:130204"] = "i:129100",
}
local START_MESSAGE = newproxy()
local STATE_SCHEMA = Reactive.CreateStateSchema("DESTROYING_STATE")
	:AddBooleanField("canCombine", false)
	:Commit()



-- ============================================================================
-- Module Functions
-- ============================================================================

function Destroying.OnInitialize(settingsDB)
	private.state = STATE_SCHEMA:CreateState()
	private.combineThread = Threading.New("COMBINE_STACKS", private.CombineThread)
	Threading.SetCallback(private.combineThread, private.CombineThreadDone)
	private.destroyThread = Threading.New("DESTROY", private.DestroyThread)
	Threading.SetCallback(private.destroyThread, private.DestroyThreadDone)
	BagTracking.RegisterCallback(private.UpdateBagDB)

	private.settings = settingsDB:NewView()
		:AddKey("global", "internalData", "destroyingHistory")
		:AddKey("global", "destroyingOptions", "deAbovePrice")
		:AddKey("global", "destroyingOptions", "deMaxQuality")
		:AddKey("global", "destroyingOptions", "includeSoulbound")
		:AddKey("global", "userData", "destroyingIgnore")
		:RegisterCallback("deAbovePrice", private.UpdateBagDB)
		:RegisterCallback("deMaxQuality", private.UpdateBagDB)
		:RegisterCallback("includeSoulbound", private.UpdateBagDB)

	local cleanupTime = time() - CLEANUP_TIME_THRESHOLD
	for spellId, entries in pairs(private.settings.destroyingHistory) do
		-- Rely on the entries being sorted in ascending time
		local index, insertIndex = BinarySearch.Table(entries, cleanupTime, private.GetHistoryEntryTime)
		local removeThroughIndex = max((index or insertIndex) - 1, #entries - CLEANUP_MAX_ENTRIES)
		if removeThroughIndex > 0 then
			Log.Info("Removing %d old entries for %s", removeThroughIndex, tostring(spellId))
			Table.RemoveRange(entries, 1, removeThroughIndex)
		end
	end

	private.ignoreDB = Database.NewSchema("DESTROYING_IGNORE")
		:AddUniqueStringField("itemString")
		:AddBooleanField("ignoreSession")
		:AddBooleanField("ignorePermanent")
		:Commit()
	private.ignoreDB:BulkInsertStart()
	local used = TempTable.Acquire()
	for itemString in pairs(private.settings.destroyingIgnore) do
		itemString = ItemString.Get(itemString)
		if not used[itemString] then
			used[itemString] = true
			private.ignoreDB:BulkInsertNewRow(itemString, false, true)
		end
	end
	TempTable.Release(used)
	private.ignoreDB:BulkInsertEnd()

	private.destroyInfoDB = Database.NewSchema("DESTROYING_INFO")
		:AddUniqueStringField("itemString")
		:AddNumberField("minQuantity")
		:AddNumberField("spellId")
		:Commit()

	Event.Register("LOOT_READY", private.SendEventToThread)
	Event.Register("LOOT_CLOSED", private.SendEventToThread)
	BagTracking.RegisterCallback(function()
		private.SendEventToThread("BAG_UPDATE_DELAYED")
	end)
	Event.Register("UNIT_SPELLCAST_START", private.SpellCastEventHandler)
	Event.Register("UNIT_SPELLCAST_FAILED", private.SpellCastEventHandler)
	Event.Register("UNIT_SPELLCAST_FAILED_QUIET", private.SpellCastEventHandler)
	Event.Register("UNIT_SPELLCAST_INTERRUPTED", private.SpellCastEventHandler)
	Event.Register("UNIT_SPELLCAST_SUCCEEDED", private.SpellCastEventHandler)

	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_TRADE_SKILL_UI) then
		TradeSkill.SecureHookCraftSalvage(function(spellId, _, itemLocation)
			private.destroySpellId = spellId
			private.itemSpellId = Container.GetItemId(itemLocation.bagID, itemLocation.slotIndex)
		end)
		Event.Register("TRADE_SKILL_ITEM_CRAFTED_RESULT", private.TradeSkillCraftResultHandler)
		Event.Register("TRADE_SKILL_LIST_UPDATE", private.TradeSkillListUpdateHandler)
	end

	private.destroyFuture:SetScript("OnCleanup", function()
		private.destroyThreadRunning = false
		Threading.Kill(private.destroyThread)
	end)
	private.combineFuture:SetScript("OnCleanup", function()
		Threading.Kill(private.combineThread)
	end)
end

function Destroying.CreateBagQuery()
	return BagTracking.CreateQueryBags()
		:LeftJoin(private.ignoreDB, "itemString")
		:InnerJoin(private.destroyInfoDB, "itemString")
		:VirtualField("name", "string", ItemInfo.GetName, "itemString", "?")
		:NotEqual("ignoreSession", true)
		:NotEqual("ignorePermanent", true)
		:GreaterThanOrEqual("quantity", Database.OtherFieldQueryParam("minQuantity"))
		:OrderBy("name", true)
		:OrderBy("slotId", true)
end

function Destroying.CanCombinePublisher()
	return private.state:PublisherForKeyChange("canCombine")
end

function Destroying.StartCombine()
	private.combineFuture:Start()
	Threading.Start(private.combineThread)
	return private.combineFuture
end

function Destroying.StartDestroy(button, itemString, slotId)
	private.destroyFuture:Start()
	private.destroyThreadRunning = true
	Threading.Start(private.destroyThread, button, itemString, slotId)
	-- we need the thread to run now so send it a sync message
	Threading.SendSyncMessage(private.destroyThread, START_MESSAGE)
	return private.destroyFuture
end

function Destroying.IgnoreItemSession(itemString)
	local row = private.ignoreDB:GetUniqueRow("itemString", itemString)
	if row then
		assert(not row:GetField("ignoreSession"))
		row:SetField("ignoreSession", true)
		row:Update()
		row:Release()
	else
		private.ignoreDB:NewRow()
			:SetField("itemString", itemString)
			:SetField("ignoreSession", true)
			:SetField("ignorePermanent", false)
			:Create()
	end
end

function Destroying.IgnoreItemPermanent(itemString)
	assert(not private.settings.destroyingIgnore[itemString])
	private.settings.destroyingIgnore[itemString] = true

	local row = private.ignoreDB:GetUniqueRow("itemString", itemString)
	if row then
		assert(not row:GetField("ignorePermanent"))
		row:SetField("ignorePermanent", true)
		row:Update()
		row:Release()
	else
		private.ignoreDB:NewRow()
			:SetField("itemString", itemString)
			:SetField("ignoreSession", false)
			:SetField("ignorePermanent", true)
			:Create()
	end
end

function Destroying.ForgetIgnoreItemPermanent(itemString)
	assert(private.settings.destroyingIgnore[itemString])
	private.settings.destroyingIgnore[itemString] = nil

	local row = private.ignoreDB:GetUniqueRow("itemString", itemString)
	assert(row and row:GetField("ignorePermanent"))
	if row:GetField("ignoreSession") then
		row:SetField("ignorePermanent", false)
		row:Update()
	else
		private.ignoreDB:DeleteRow(row)
	end
	row:Release()
end

function Destroying.CreateIgnoreQuery()
	return private.ignoreDB:NewQuery()
		:VirtualField("name", "string", ItemInfo.GetName, "itemString", "?")
		:VirtualField("texture", "number", ItemInfo.GetTexture, "itemString", ItemInfo.GetTexture(ItemString.GetUnknown()))
		:Equal("ignorePermanent", true)
		:OrderBy("name", true)
end



-- ============================================================================
-- Combine Stacks Thread
-- ============================================================================

function private.CombineThread()
	while private.state.canCombine do
		for _, combineSlotId in ipairs(private.pendingCombines) do
			local sourceBag, sourceSlot, targetBag, targetSlot = private.CombineSlotIdToBagSlot(combineSlotId)
			Container.PickupItem(sourceBag, sourceSlot)
			Container.PickupItem(targetBag, targetSlot)
		end
		-- wait for the bagDB to change
		private.newBagUpdate = false
		Threading.WaitForFunction(private.HasNewBagUpdate)
	end
end

function private.CombineSlotIdToBagSlot(combineSlotId)
	local sourceSlotId = combineSlotId % TARGET_SLOT_ID_MULTIPLIER
	local targetSlotId = floor(combineSlotId / TARGET_SLOT_ID_MULTIPLIER)
	local sourceBag, sourceSlot = SlotId.Split(sourceSlotId)
	local targetBag, targetSlot = SlotId.Split(targetSlotId)
	return sourceBag, sourceSlot, targetBag, targetSlot
end

function private.HasNewBagUpdate()
	return private.newBagUpdate
end

function private.CombineThreadDone(result)
	private.combineFuture:Done(result)
end



-- ============================================================================
-- Destroy Thread
-- ============================================================================

function private.DestroyThread(button, itemString, slotId)
	-- We get sent a sync message so we run right away
	assert(Threading.ReceiveMessage() == START_MESSAGE)

	local bag, slot = SlotId.Split(slotId)
	local spellId = private.destroyInfoDB:GetUniqueRowField("itemString", itemString, "spellId")
	local startQuantity = Container.GetStackCount(bag, slot)
	button:SetMacroText(format("/cast %s;\n/use %d %d", Spell.GetInfo(spellId), bag, slot))

	-- Wait for the spell cast to start or fail
	private.pendingSpellId = spellId
	local event = Threading.ReceiveMessage()
	if event ~= "UNIT_SPELLCAST_START" then
		-- The spell cast failed for some reason
		ClearCursor()
		return false
	end

	-- Discard any other messages
	Threading.Yield(true)
	while Threading.HasPendingMessage() do
		Threading.ReceiveMessage()
	end

	-- Wait for the spell cast to finish and the loot window to open and then close
	local lootResult = nil
	local hasSpellcastSucceeded, hasLootClosed, hasBagUpdateDelayed = false, false, false
	while not hasSpellcastSucceeded or not lootResult or not hasLootClosed or not hasBagUpdateDelayed do
		event = Threading.ReceiveMessage()
		Log.Info("Got event: %s", tostring(event))
		if event == "UNIT_SPELLCAST_SUCCEEDED" then
			hasSpellcastSucceeded = true
		elseif event == "LOOT_READY" then
			if not lootResult and GetNumLootItems() > 0 then
				lootResult = {}
				for i = 1, GetNumLootItems() do
					local lootItemString = ItemString.Get(GetLootSlotLink(i))
					local _, _, quantity = GetLootSlotInfo(i)
					if lootItemString and (quantity or 0) > 0 then
						lootItemString = GEM_CHIPS[lootItemString] or lootItemString
						lootResult[lootItemString] = quantity
					end
				end
			end
		elseif event == "LOOT_CLOSED" then
			if lootResult then
				hasLootClosed = true
			end
		elseif event == "BAG_UPDATE_DELAYED" then
			if lootResult then
				hasBagUpdateDelayed = true
			end
		else
			-- The spell cast was interrupted
			return false
		end
	end

	-- Add to the log
	local newEntry = {
		item = itemString,
		time = time(),
		result = lootResult,
	}
	private.settings.destroyingHistory[spellId] = private.settings.destroyingHistory[spellId] or {}
	tinsert(private.settings.destroyingHistory[spellId], newEntry)

	-- Wait up to a second for the item we destroyed to be removed from the bags
	local timeout = GetTime() + 1
	while startQuantity == Container.GetStackCount(bag, slot) do
		if GetTime() > timeout then
			return false
		end
		Threading.Sleep(0.1)
	end

	-- We're done
	return true
end

function private.SendEventToThread(event)
	if not private.destroyThreadRunning then
		return
	end
	Threading.SendMessage(private.destroyThread, event)
end

function private.SpellCastEventHandler(event, unit, _, spellId)
	if unit ~= "player" then
		return
	end
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_TRADE_SKILL_UI) and private.destroySpellId and private.destroySpellId == spellId and event ~= "UNIT_SPELLCAST_START" and event ~= "UNIT_SPELLCAST_SUCCEEDED" then
		private.destroySpellId = nil
		private.itemSpellId = nil
	end
	if spellId ~= private.pendingSpellId then
		return
	end
	private.SendEventToThread(event)
end

function private.DestroyThreadDone(result)
	private.destroyThreadRunning = false
	private.destroyFuture:Done(result)
end

function private.TradeSkillCraftResultHandler(event, resultTable)
	if not private.destroySpellId or not private.itemSpellId then
		return
	end
	private.destroyResultCache[ItemString.Get(resultTable.itemID)] = resultTable.quantity
end

function private.TradeSkillListUpdateHandler()
	if not private.destroySpellId or not private.itemSpellId or not next(private.destroyResultCache) then
		return
	end

	-- Add to the log
	local newEntry = {
		item = ItemString.Get(private.itemSpellId),
		time = time(),
		result = CopyTable(private.destroyResultCache),
	}
	private.settings.destroyingHistory[private.destroySpellId] = private.settings.destroyingHistory[private.destroySpellId] or {}
	tinsert(private.settings.destroyingHistory[private.destroySpellId], newEntry)

	wipe(private.destroyResultCache)
end



-- ============================================================================
-- Bag Update Functions
-- ============================================================================

function private.UpdateBagDB()
	wipe(private.pendingCombines)
	private.destroyInfoDB:TruncateAndBulkInsertStart()
	local itemPrevSlotId = TempTable.Acquire()
	local checkedItem = TempTable.Acquire()
	local query = BagTracking.CreateQueryBags()
		:OrderBy("slotId", true)
		:Select("slotId", "itemString", "quantity")
	if not private.settings.includeSoulbound then
		query:Equal("isBound", false)
	end
	if ClientInfo.IsPandaClassic() then
		local disenchantName = Spell.GetInfo(7411)
		local jewelcraftName = Spell.GetInfo(28897)
		local inscriptionName = Spell.GetInfo(45357)
		private.disenchantSkillLevel = TSM.Crafting.PlayerProfessions.GetProfessionSkill(UnitName("player"), disenchantName)
		private.jewelcraftSkillLevel = TSM.Crafting.PlayerProfessions.GetProfessionSkill(UnitName("player"), jewelcraftName)
		private.inscriptionSkillLevel = TSM.Crafting.PlayerProfessions.GetProfessionSkill(UnitName("player"), inscriptionName)
	end
	for _, slotId, itemString, quantity in query:Iterator() do
		local minQuantity = nil
		if checkedItem[itemString] then
			minQuantity = private.destroyInfoDB:GetUniqueRowField("itemString", itemString, "minQuantity")
		else
			checkedItem[itemString] = true
			local spellId = nil
			minQuantity, spellId = private.ProcessBagItem(itemString)
			if minQuantity then
				private.destroyInfoDB:BulkInsertNewRow(itemString, minQuantity, spellId)
			end
		end
		if minQuantity and quantity % minQuantity ~= 0 then
			if itemPrevSlotId[itemString] then
				-- We can combine this with the previous partial stack
				tinsert(private.pendingCombines, itemPrevSlotId[itemString] * TARGET_SLOT_ID_MULTIPLIER + slotId)
				itemPrevSlotId[itemString] = nil
			else
				itemPrevSlotId[itemString] = slotId
			end
		end
	end
	query:Release()
	TempTable.Release(checkedItem)
	TempTable.Release(itemPrevSlotId)
	private.destroyInfoDB:BulkInsertEnd()
	private.state.canCombine = #private.pendingCombines > 0
	private.newBagUpdate = true
end

function private.ProcessBagItem(itemString)
	if private.ignoreDB:HasUniqueRow("itemString", itemString) then
		return
	end

	local spellId, minQuantity = private.IsDestroyable(itemString)
	if not spellId then
		return
	elseif spellId == SPELL_IDS.disenchant then
		local deAbovePrice = CustomString.GetValue(private.settings.deAbovePrice, itemString) or 0
		local deValue = CustomString.GetValue("Destroy", itemString) or math.huge
		if deValue < deAbovePrice then
			return
		end
	end
	return minQuantity, spellId
end

function private.IsDestroyable(itemString)
	if private.destroyQuantityCache[itemString] then
		return private.canDestroyCache[itemString], private.destroyQuantityCache[itemString]
	end

	-- Disenchanting
	local quality = ItemInfo.GetQuality(itemString)
	if ItemInfo.IsDisenchantable(itemString) and quality <= private.settings.deMaxQuality then
		local hasSourceItem = true
		if ClientInfo.IsPandaClassic() then
			local classId = ItemInfo.GetClassId(itemString)
			local itemLevel = ItemInfo.GetItemLevel(ItemString.GetBase(itemString))
			hasSourceItem = false
			for targetItemString in Conversion.DisenchantTargetItemIterator() do
				local _, _, _, _, skillRequired = Conversions.GetDisenchantTargetItemSourceInfo(targetItemString, classId, quality, itemLevel)
				if private.disenchantSkillLevel and skillRequired and private.disenchantSkillLevel >= skillRequired then
					hasSourceItem = true
				end
			end
		end
		if hasSourceItem then
			private.canDestroyCache[itemString] = IsSpellKnown(SPELL_IDS.disenchant) and SPELL_IDS.disenchant
			private.destroyQuantityCache[itemString] = 1
			return private.canDestroyCache[itemString], private.destroyQuantityCache[itemString]
		end
		return private.canDestroyCache[itemString], private.destroyQuantityCache[itemString]
	end

	local conversionMethod, destroySpellId = nil, nil
	local classId = ItemInfo.GetClassId(itemString)
	local subClassId = ItemInfo.GetSubClassId(itemString)
	-- Workaround for Fire Leaf (i:39970) not being treated as an herb (at least in classsic)
	if (classId == Enum.ItemClass.Tradegoods and subClassId == ITEM_SUB_CLASS_HERB) or itemString == "i:39970" then
		conversionMethod = Conversion.METHOD.MILL
		destroySpellId = SPELL_IDS.milling
	elseif classId == Enum.ItemClass.Tradegoods and subClassId == ITEM_SUB_CLASS_METAL_AND_STONE then
		conversionMethod = Conversion.METHOD.PROSPECT
		destroySpellId = SPELL_IDS.prospect
	else
		private.canDestroyCache[itemString] = false
		private.destroyQuantityCache[itemString] = nil
		return private.canDestroyCache[itemString], private.destroyQuantityCache[itemString]
	end

	local hasSourceItem = false
	for _, _, _, _, _, _, _, skillRequired in Conversion.TargetItemsByMethodIterator(itemString, conversionMethod) do
		if not skillRequired or (conversionMethod == Conversion.METHOD.PROSPECT and private.jewelcraftSkillLevel and skillRequired and private.jewelcraftSkillLevel >= skillRequired) or (conversionMethod == Conversion.METHOD.MILL and private.inscriptionSkillLevel and skillRequired and private.inscriptionSkillLevel >= skillRequired) then
			hasSourceItem = true
		end
	end
	if hasSourceItem then
		private.canDestroyCache[itemString] = IsSpellKnown(destroySpellId) and destroySpellId
		private.destroyQuantityCache[itemString] = 5
		return private.canDestroyCache[itemString], private.destroyQuantityCache[itemString]
	end

	return private.canDestroyCache[itemString], private.destroyQuantityCache[itemString]
end

function private.GetHistoryEntryTime(entry)
	return entry.time
end
