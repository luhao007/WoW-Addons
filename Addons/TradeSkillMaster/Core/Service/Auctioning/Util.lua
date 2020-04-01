-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--             https://www.curseforge.com/wow/addons/tradeskill-master            --
--                                                                                --
--             A TradeSkillMaster Addon (https://tradeskillmaster.com)            --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local Util = TSM.Auctioning:NewPackage("Util")
local TempTable = TSM.Include("Util.TempTable")
local Vararg = TSM.Include("Util.Vararg")
local Money = TSM.Include("Util.Money")
local String = TSM.Include("Util.String")
local Math = TSM.Include("Util.Math")
local CustomPrice = TSM.Include("Service.CustomPrice")
local private = {
	priceCache = {},
}
local INVALID_PRICE = {}
local VALID_PRICE_KEYS = {
	minPrice = true,
	normalPrice = true,
	maxPrice = true,
	undercut = true,
	cancelRepostThreshold = true,
	priceReset = true,
	aboveMax = true,
}



-- ============================================================================
-- Module Functions
-- ============================================================================

function Util.GetPrice(key, operation, itemString)
	assert(VALID_PRICE_KEYS[key])
	local cacheKey = key..tostring(operation)..itemString
	if private.priceCache.updateTime ~= GetTime() then
		wipe(private.priceCache)
		private.priceCache.updateTime = GetTime()
	end
	if not private.priceCache[cacheKey] then
		if key == "normalPrice" then
			local normalPrice = CustomPrice.GetValue(operation.normalPrice, itemString)
			if normalPrice and TSM.db.global.auctioningOptions.roundNormalPrice then
				-- round up to the nearest gold
				normalPrice = Math.Ceil(normalPrice, COPPER_PER_GOLD)
			end
			private.priceCache[cacheKey] = normalPrice
		elseif key == "aboveMax" or key == "priceReset" then
			-- redirect to the selected price (if applicable)
			local priceKey = operation[key]
			if VALID_PRICE_KEYS[priceKey] then
				private.priceCache[cacheKey] = Util.GetPrice(priceKey, operation, itemString)
			end
		elseif not TSM.IsWowClassic() and key == "undercut" and Money.FromString(Money.ToString(operation[key]) or operation[key]) == 0 then
			private.priceCache[cacheKey] = 0
		else
			private.priceCache[cacheKey] = CustomPrice.GetValue(operation[key], itemString)
		end
		private.priceCache[cacheKey] = private.priceCache[cacheKey] or INVALID_PRICE
	end
	if private.priceCache[cacheKey] == INVALID_PRICE then
		return nil
	end
	return private.priceCache[cacheKey]
end

function Util.GetLowestAuction(query, itemString, operationSettings, resultTbl)
	if not TSM.IsWowClassic() then
		local foundLowest = false
		for _, record in query:Iterator() do
			if not foundLowest and not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) then
				local seller = record:GetField("seller")
				local firstSeller = strsplit(",", seller)
				resultTbl.buyout = record:GetField("itemBuyout")
				resultTbl.bid = record:GetField("itemDisplayedBid")
				resultTbl.seller = firstSeller
				resultTbl.auctionId = record:GetField("auctionId")
				resultTbl.isWhitelist = TSM.db.factionrealm.auctioningOptions.whitelist[strlower(firstSeller)] and true or false
				resultTbl.isPlayer = TSMAPI_FOUR.PlayerInfo.IsPlayer(firstSeller, true, true, true)
				for seller2 in String.SplitIterator(seller, ",") do
					if seller2 == "" or seller2 == "?" then
						resultTbl.hasInvalidSeller = true
					end
				end
				foundLowest = true
			end
		end
		return foundLowest
	else
		local hasInvalidSeller = nil
		local ignoreWhitelist = nil
		local lowestItemBuyout = nil
		local lowestAuction = nil
		for _, record in query:Iterator() do
			if not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) then
				local itemBuyout = record:GetField("itemBuyout")
				assert(itemBuyout and itemBuyout > 0)
				lowestItemBuyout = lowestItemBuyout or itemBuyout
				if itemBuyout == lowestItemBuyout then
					local seller = record:GetField("seller")
					local temp = TempTable.Acquire()
					temp.buyout = itemBuyout
					temp.bid = record:GetField("itemDisplayedBid")
					temp.seller = seller
					temp.auctionId = record:GetField("auctionId")
					temp.isWhitelist = TSM.db.factionrealm.auctioningOptions.whitelist[strlower(seller)] and true or false
					temp.isPlayer = TSMAPI_FOUR.PlayerInfo.IsPlayer(seller, true, true, true)
					if not temp.isWhitelist and not temp.isPlayer then
						-- there is a non-whitelisted competitor, so we don't care if a whitelisted competitor also posts at this price
						ignoreWhitelist = true
					end
					if seller == "?" and next(TSM.db.factionrealm.auctioningOptions.whitelist) then
						hasInvalidSeller = true
					end
					if operationSettings.blacklist then
						for _, player in Vararg.Iterator(strsplit(",", operationSettings.blacklist)) do
							if String.SeparatedContains(strlower(seller), ",", strlower(strtrim(player))) then
								temp.isBlacklist = true
							end
						end
					end
					if not lowestAuction then
						lowestAuction = temp
					elseif private.LowestAuctionCompare(temp, lowestAuction) then
						TempTable.Release(lowestAuction)
						lowestAuction = temp
					else
						TempTable.Release(temp)
					end
				end
			end
		end
		if not lowestAuction then
			return false
		end
		for k, v in pairs(lowestAuction) do
			resultTbl[k] = v
		end
		TempTable.Release(lowestAuction)
		if resultTbl.isWhitelist and ignoreWhitelist then
			resultTbl.isWhitelist = false
		end
		resultTbl.hasInvalidSeller = hasInvalidSeller
		return true
	end
end

function Util.GetPlayerAuctionCount(query, itemString, operationSettings, findBid, findBuyout, findStackSize)
	local quantity = 0
	for _, record in query:Iterator() do
		if not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) then
			local itemDisplayedBid, itemBuyout, stackSize = record:GetFields("itemDisplayedBid", "itemBuyout", "stackSize")
			if itemDisplayedBid == findBid and itemBuyout == findBuyout and (not TSM.IsWowClassic() or stackSize == findStackSize) then
				quantity = quantity + private.GetPlayerAuctionCount(record)
			end
		end
	end
	return quantity
end

function Util.GetPlayerLowestBuyout(query, itemString, operationSettings)
	local lowestItemBuyout, lowestItemAuctionId = nil, nil
	for _, record in query:Iterator() do
		if not lowestItemBuyout and not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) and private.GetPlayerAuctionCount(record) > 0 then
			lowestItemBuyout, lowestItemAuctionId = record:GetFields("itemBuyout", "auctionId")
		end
	end
	return lowestItemBuyout, lowestItemAuctionId
end

function Util.GetLowestNonPlayerAuctionId(query, itemString, operationSettings, itemBuyout)
	local lowestItemAuctionId = nil
	for _, record in query:Iterator() do
		if not lowestItemAuctionId and not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) and private.GetPlayerAuctionCount(record) == 0 and record:GetField("itemBuyout") == itemBuyout then
			lowestItemAuctionId = record:GetField("auctionId")
		end
	end
	return lowestItemAuctionId
end

function Util.IsPlayerOnlySeller(query, itemString, operationSettings)
	local isOnly = true
	for _, record in query:Iterator() do
		if isOnly and not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) and private.GetPlayerAuctionCount(record) < (TSM.IsWowClassic() and 1 or record:GetField("stackSize")) then
			isOnly = false
		end
	end
	return isOnly
end

function Util.GetNextLowestItemBuyout(query, itemString, lowestAuction, operationSettings)
	local nextLowestItemBuyout = nil
	for _, record in query:Iterator() do
		local itemBuyout, auctionId = record:GetFields("itemBuyout", "auctionId")
		local isLower = itemBuyout > lowestAuction.buyout or (itemBuyout == lowestAuction.buyout and auctionId < lowestAuction.auctionId)
		if not nextLowestItemBuyout and not private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings) and isLower then
			nextLowestItemBuyout = itemBuyout
		end
	end
	return nextLowestItemBuyout
end

function Util.GetQueueStatus(query)
	local numProcessed, numConfirmed, numFailed, totalNum = 0, 0, 0, 0
	query:OrderBy("auctionId", true)
	for _, row in query:Iterator() do
		local rowNumStacks, rowNumProcessed, rowNumConfirmed, rowNumFailed = row:GetFields("numStacks", "numProcessed", "numConfirmed", "numFailed")
		totalNum = totalNum + rowNumStacks
		numProcessed = numProcessed + rowNumProcessed
		numConfirmed = numConfirmed + rowNumConfirmed
		numFailed = numFailed + rowNumFailed
	end
	query:Release()
	return numProcessed, numConfirmed, numFailed, totalNum
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.ShouldIgnoreAuctionRecord(record, itemString, operationSettings)
	if record:GetField("timeLeft") <= operationSettings.ignoreLowDuration then
		-- ignoring low duration
		return true
	elseif TSM.IsWowClassic() and operationSettings.matchStackSize and record:GetField("stackSize") ~= operationSettings.stackSize then
		-- matching stack size
		return true
	elseif operationSettings.priceReset == "ignore" and record:GetField("itemBuyout") then
		local minPrice = Util.GetPrice("minPrice", operationSettings, itemString)
		if minPrice and record:GetField("itemBuyout") <= minPrice then
			-- ignoring auctions below threshold
			return true
		end
	end
	return false
end

function private.LowestAuctionCompare(a, b)
	if a.isBlacklist ~= b.isBlacklist then
		return a.isBlacklist
	end
	if a.isWhitelist ~= b.isWhitelist then
		return a.isWhitelist
	end
	if a.auctionId ~= b.auctionId then
		return a.auctionId > b.auctionId
	end
	if a.isPlayer ~= b.isPlayer then
		return b.isPlayer
	end
	return tostring(a) < tostring(b)
end

function private.GetPlayerAuctionCount(row)
	if TSM.IsWowClassic() then
		return TSMAPI_FOUR.PlayerInfo.IsPlayer(row:GetField("seller"), true, true, true) and 1 or 0
	else
		return row:GetField("numOwnerItems")
	end
end
