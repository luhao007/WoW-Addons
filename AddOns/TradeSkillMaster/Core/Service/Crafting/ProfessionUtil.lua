-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local ProfessionUtil = TSM.Crafting:NewPackage("ProfessionUtil")
local Spell = TSM.LibTSMWoW:Include("API.Spell")
local ClientInfo = TSM.LibTSMWoW:Include("Util.ClientInfo")
local Event = TSM.LibTSMWoW:Include("Service.Event")
local Log = TSM.LibTSMUtil:Include("Util.Log")
local DelayTimer = TSM.LibTSMWoW:IncludeClassType("DelayTimer")
local ItemString = TSM.LibTSMTypes:Include("Item.ItemString")
local CraftString = TSM.LibTSMTypes:Include("Crafting.CraftString")
local RecipeString = TSM.LibTSMTypes:Include("Crafting.RecipeString")
local TempTable = TSM.LibTSMUtil:Include("BaseType.TempTable")
local CustomString = TSM.LibTSMTypes:Include("CustomString")
local ItemInfo = TSM.LibTSMService:Include("Item.ItemInfo")
local BagTracking = TSM.LibTSMService:Include("Inventory.BagTracking")
local WarbankTracking = TSM.LibTSMService:Include("Inventory.WarbankTracking")
local TradeSkill = TSM.LibTSMWoW:Include("API.TradeSkill")
local Profession = TSM.LibTSMService:Include("Profession")
local private = {
	recipeString = nil,
	craftQuantity = nil,
	craftSpellId = nil,
	craftBaseString = nil,
	craftCallback = nil,
	craftName = nil,
	castingTimeout = nil,
	craftTimeout = nil,
	preparedSpellId = nil,
	preparedTime = 0,
	timeoutTimer = nil,
}



-- ============================================================================
-- Module Functions
-- ============================================================================

function ProfessionUtil.OnInitialize()
	private.timeoutTimer = DelayTimer.New("PROFESSION_UTIL_TIMEOUT", private.CraftTimeoutMonitor)
	Event.Register("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spellId)
		if unit ~= "player" or not private.SpellMatchesCraft(spellId) then
			return
		end

		if ClientInfo.IsRetail() then
			-- check if we need to update bank quantity manually
			for _, itemString, quantity in TSM.Crafting.MatIteratorByRecipeString(private.recipeString) do
				local bagQuantity, bankQuantity, reagentBankQuantity = BagTracking.GetQuantities(itemString)
				local warbankQuantity = WarbankTracking.GetQuantity(itemString)
				local bankUsed = quantity - bagQuantity
				if bankUsed > 0 and bankUsed <= (bankQuantity + reagentBankQuantity + warbankQuantity) then
					local warbankUsed = min(bankUsed, warbankQuantity)
					bankUsed = bankUsed - warbankUsed
					Log.Info("Used %d from bank, %d from the warbank", bankUsed, warbankUsed)
					if bankUsed > 0 then
						BagTracking.ForceBankQuantityDeduction(itemString, bankUsed)
					end
					if warbankUsed > 0 then
						WarbankTracking.ForceQuantityDeduction(itemString, warbankUsed)
					end
				end
			end
		end

		local callback = private.craftCallback
		assert(callback)
		private.craftQuantity = private.craftQuantity - 1
		private.DoCraftCallback(true, private.craftQuantity == 0)
		-- Ignore profession updates from crafting something
		Profession.IgnoreNextProfessionUpdates()
		-- Restart the timeout
	end)
	local function SpellCastFailedEventHandler(_, unit, _, spellId)
		if unit ~= "player" or not private.SpellMatchesCraft(spellId) then
			return
		end
		private.DoCraftCallback(false, true)
	end
	local function ClearCraftCast()
		private.recipeString = nil
		private.craftQuantity = nil
		private.craftSpellId = nil
		private.craftBaseString = nil
		private.craftName = nil
		private.castingTimeout = nil
		private.craftTimeout = nil
	end
	Event.Register("UNIT_SPELLCAST_INTERRUPTED", SpellCastFailedEventHandler)
	Event.Register("UNIT_SPELLCAST_FAILED", SpellCastFailedEventHandler)
	Event.Register("UNIT_SPELLCAST_FAILED_QUIET", SpellCastFailedEventHandler)
	Event.Register("TRADE_SKILL_CLOSE", ClearCraftCast)
	if not ClientInfo.IsRetail() then
		Event.Register("CRAFT_CLOSE", ClearCraftCast)
	end
end

function ProfessionUtil.GetNumCraftable(craftString)
	local num, numAll = math.huge, math.huge
	for i = 1, Profession.GetNumMats(craftString) do
		local itemString, quantity = Profession.GetMatInfo(craftString, i)
		local totalQuantity = CustomString.GetSourceValue("NumInventory", itemString) or 0
		if not itemString or not quantity or totalQuantity == 0 then
			return 0, 0
		end
		num = min(num, floor(private.GetMatQuantity(itemString) / quantity))
		numAll = min(numAll, floor(totalQuantity / quantity))
	end
	if num == math.huge or numAll == math.huge then
		return 0, 0
	end
	return num, numAll
end

function ProfessionUtil.GetNumCraftableRecipeString(recipeString)
	local num, numAll = math.huge, math.huge
	local craftString = CraftString.FromRecipeString(recipeString)
	for i = 1, Profession.GetNumMats(craftString) do
		local itemString, quantity, _, isQuality = Profession.GetMatInfo(craftString, i)
		if not isQuality then
			local totalQuantity = CustomString.GetSourceValue("NumInventory", itemString) or 0
			if not itemString or not quantity or totalQuantity == 0 then
				return 0, 0
			end
			local bagQuantity = private.GetMatQuantity(itemString)
			num = min(num, floor(bagQuantity / quantity))
			numAll = min(numAll, floor(totalQuantity / quantity))
		end
	end
	for _, _, itemId in RecipeString.OptionalMatIterator(recipeString) do
		local itemString = ItemString.Get(itemId)
		local totalQuantity = CustomString.GetSourceValue("NumInventory", itemString) or 0
		if totalQuantity == 0 then
			return 0, 0
		end
		local quantity = TSM.Crafting.GetOptionalMatQuantity(craftString, itemId)
		local bagQuantity = private.GetMatQuantity(itemString)
		num = min(num, floor(bagQuantity / quantity))
		numAll = min(numAll, floor(totalQuantity / quantity))
	end
	if num == math.huge or numAll == math.huge then
		return 0, 0
	end
	return num, numAll
end

function ProfessionUtil.HasVellum(recipeString)
	local craftString = CraftString.FromRecipeString(recipeString)
	if Profession.IsEnchant(craftString) and not ClientInfo.IsVanillaClassic() then
		return BagTracking.GetBagQuantity(Profession.GetVellumItemString(craftString)) > 0
	else
		return false
	end
end

function ProfessionUtil.IsCraftable(craftString)
	for i = 1, Profession.GetNumMats(craftString) do
		local itemString, quantity = Profession.GetMatInfo(craftString, i)
		if not itemString or not quantity then
			return false
		end
		if floor(private.GetMatQuantity(itemString) / quantity) == 0 then
			return false
		end
	end
	return true
end

function ProfessionUtil.GetNumCraftableFromDB(craftString, optionalMats)
	local num = math.huge
	for _, itemString, quantity in TSM.Crafting.MatIterator(craftString) do
		num = min(num, floor(private.GetMatQuantity(itemString) / quantity))
	end
	if optionalMats then
		for _, itemId in pairs(optionalMats) do
			num = min(num, private.GetMatQuantity(ItemString.Get(itemId)))
		end
	end
	if num == math.huge then
		return 0
	end
	return num
end

function ProfessionUtil.GetNumCraftableFromDBRecipeString(recipeString)
	local num = math.huge
	for _, itemString, quantity in TSM.Crafting.MatIteratorByRecipeString(recipeString) do
		num = min(num, floor(private.GetMatQuantity(itemString) / quantity))
	end
	if num == math.huge then
		return 0
	end
	return num
end

function ProfessionUtil.PrepareToCraft(recipeString, quantity, level, salvageSlotId)
	if not salvageSlotId then
		quantity = min(quantity, ProfessionUtil.GetNumCraftableRecipeString(recipeString))
	end
	if quantity == 0 then
		return
	end
	private.preparedSpellId = RecipeString.GetSpellId(recipeString)
	private.preparedTime = GetTime()
end

function ProfessionUtil.Craft(recipeString, quantity, useVellum, salvageSlotId, callback)
	local spellId = nil
	local level = nil
	local craftString = CraftString.FromRecipeString(recipeString)
	if salvageSlotId then
		spellId = RecipeString.GetSpellId(recipeString)
	elseif type(recipeString) == "string" then
		spellId = RecipeString.GetSpellId(recipeString)
		level = RecipeString.GetLevel(recipeString)
		quantity = min(quantity, ProfessionUtil.GetNumCraftableRecipeString(recipeString))
	else
		spellId = recipeString
		quantity = min(quantity, ProfessionUtil.GetNumCraftable(craftString))
	end
	assert(Profession.HasCraftString(craftString))
	if private.craftSpellId then
		private.craftCallback = callback
		private.DoCraftCallback(false, true)
		return 0
	end
	if quantity == 0 then
		return 0
	end
	local isEnchant = Profession.IsEnchant(craftString)
	local vellumable = isEnchant and not ClientInfo.IsVanillaClassic()
	if isEnchant or TradeSkill.IsClassicCrafting() then
		quantity = 1
	elseif spellId ~= private.preparedSpellId or private.preparedTime == GetTime() then
		-- We can only craft one of this item due to a bug on Blizzard's end
		quantity = 1
	end
	local enchantItemSlotId = nil
	if ClientInfo.IsRetail() and useVellum and isEnchant and vellumable then
		enchantItemSlotId = BagTracking.CreateQueryBagsItem(Profession.GetVellumItemString(craftString))
			:Select("slotId")
			:GetFirstResultAndRelease()
		if not enchantItemSlotId then
			return 0
		end
	end
	private.recipeString = recipeString
	private.craftQuantity = quantity
	private.craftSpellId = spellId
	private.craftBaseString = ItemString.GetBase(TSM.Crafting.GetItemString(craftString)) or ""
	private.craftCallback = callback
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_TRADE_SKILL_UI) then
		local optionalMats = TempTable.Acquire()
		if type(recipeString) == "string" then
			for _, slotId, itemId in RecipeString.OptionalMatIterator(recipeString) do
				local info = TempTable.Acquire()
				info.itemID = itemId
				info.dataSlotIndex = slotId
				info.quantity = TSM.Crafting.GetOptionalMatQuantity(craftString, itemId)
				tinsert(optionalMats, info)
			end
		end
		TradeSkill.Craft(spellId, quantity, optionalMats, level, enchantItemSlotId, salvageSlotId)
		for _, info in pairs(optionalMats) do
			TempTable.Release(info)
		end
		TempTable.Release(optionalMats)
	else
		local index = Profession.GetIndexByCraftString(craftString)
		private.craftName = TradeSkill.Craft(index, quantity)
		if useVellum and isEnchant and vellumable then
			UseItemByName(ItemInfo.GetName(Profession.GetVellumItemString(craftString)))
		end
	end
	private.castingTimeout = nil
	private.craftTimeout = nil
	private.timeoutTimer:RunForTime(0.5)
	return quantity
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.DoCraftCallback(result, isDone)
	local callback = private.craftCallback
	assert(callback)
	-- reset timeouts
	private.castingTimeout = nil
	private.craftTimeout = nil
	if isDone then
		private.recipeString = nil
		private.craftQuantity = nil
		private.craftSpellId = nil
		private.craftBaseString = nil
		private.craftCallback = nil
		private.craftName = nil
		private.timeoutTimer:Cancel()
	end
	callback(result, isDone)
end

function private.CraftTimeoutMonitor()
	private.timeoutTimer:RunForTime(0.5)
	if not private.craftSpellId then
		Log.Info("No longer crafting")
		private.castingTimeout = nil
		private.craftTimeout = nil
		private.timeoutTimer:Cancel()
		return
	end
	local _, _, _, _, castEndTimeMs, _, _, _, spellId = private.GetPlayerCastingInfo()
	if spellId then
		private.castingTimeout = nil
	else
		private.craftTimeout = nil
	end
	if not spellId then
		-- no active cast
		if GetTime() > (private.castingTimeout or math.huge) then
			Log.Err("Craft timed out (%s)", private.craftSpellId)
			private.DoCraftCallback(false, true)
			return
		end
		-- set the casting timeout to 1 second from now
		private.castingTimeout = GetTime() + 1
		return
	elseif private.craftSpellId ~= spellId then
		Log.Err("Crafting something else (%s, %s)", private.craftSpellId, spellId)
		private.castingTimeout = nil
		private.craftTimeout = nil
		private.timeoutTimer:Cancel()
		return
	end

	if GetTime() > (private.craftTimeout or math.huge) then
		Log.Err("Craft timed out (%s)", private.craftSpellId)
		private.DoCraftCallback(false, true)
		return
	end
	-- set the timeout to 1 second after the end time
	private.craftTimeout = castEndTimeMs / 1000 + 1
end

function private.GetPlayerCastingInfo()
	if ClientInfo.IsRetail() then
		return UnitCastingInfo("player")
	else
		return CastingInfo()
	end
end

function private.SpellMatchesCraft(spellId)
	if ClientInfo.IsRetail() then
		if not Profession.ScannerHasSkills() then
			return false
		end
		local resultItem = Profession.GetResultItem(CraftString.Get(spellId))
		if not resultItem then
			return false
		elseif type(resultItem) == "table" then
			for i = 1, #resultItem do
				local baseItemString = ItemString.GetBase(resultItem[i]) or ""
				if spellId == private.craftSpellId and baseItemString == private.craftBaseString then
					return true
				end
			end
			return false
		else
			local baseItemString = ItemString.GetBase(resultItem) or ""
			return spellId == private.craftSpellId and baseItemString == private.craftBaseString
		end
	else
		return Spell.GetInfo(spellId) == private.craftName
	end
end

function private.GetMatQuantity(itemString)
	return BagTracking.GetCraftingMatQuantity(itemString) + WarbankTracking.GetQuantity(itemString)
end
