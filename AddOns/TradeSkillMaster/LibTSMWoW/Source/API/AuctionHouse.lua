-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local LibTSMWoW = select(2, ...).LibTSMWoW
local AuctionHouse = LibTSMWoW:Init("API.AuctionHouse")
local Event = LibTSMWoW:Include("Service.Event")
local ClientInfo = LibTSMWoW:Include("Util.ClientInfo")
local EnumType = LibTSMWoW:From("LibTSMUtil"):Include("BaseType.EnumType")
local private = {
	itemLocation = ItemLocation:CreateEmpty(),
	auctionIdToLink = {},
	auctionIdToItemBuyout = {},
	postHookFuncs = {},
	itemPostedCallbacks = {},
	purchaseHookFuncs = {},
	lastPurchase = {
		link = nil,
		name = nil,
		quantity = nil,
		buyout = nil,
	},
	notificationCallbacks = {},
	pendingPost = {
		itemLink = nil,
		quantity = nil,
		unitPrice = nil,
		timestamp = nil,
	},
}
AuctionHouse.DURATIONS = {
	not LibTSMWoW.IsVanillaClassic() and AUCTION_DURATION_ONE or gsub(AUCTION_DURATION_ONE, "12", "2"),
	not LibTSMWoW.IsVanillaClassic() and AUCTION_DURATION_TWO or gsub(AUCTION_DURATION_TWO, "24", "8"),
	not LibTSMWoW.IsVanillaClassic() and AUCTION_DURATION_THREE or gsub(AUCTION_DURATION_THREE, "48", "24"),
}
local NOTIFICATION = EnumType.New("AUCTION_NOTIFICATION", {
	BUY = EnumType.NewValue(),
	BID = EnumType.NewValue(),
	OUTBID = EnumType.NewValue(),
	EXPIRED = EnumType.NewValue(),
	SOLD = EnumType.NewValue(),
	CANCELLED = EnumType.NewValue(),
})
AuctionHouse.NOTIFICATION = NOTIFICATION
local AUCTIONABLE_WOW_TOKEN_ITEM_ID = 122270

---@class ExtendedItemSearchResultInfo: ItemSearchResultInfo
---@field isHighBidder boolean



-- ============================================================================
-- Module Loading
-- ============================================================================

AuctionHouse:OnModuleLoad(function()
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
		-- Maintain our auctionId maps
		Event.Register("ITEM_SEARCH_RESULTS_UPDATED", private.HandleItemSearchResultsUpdated)
		-- Handle auctions being created
		Event.Register("AUCTION_HOUSE_AUCTION_CREATED", private.AuctionCreatedHandler)
	end
	-- Setup Hooks
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
		hooksecurefunc(C_AuctionHouse, "PostCommodity", private.PostCommodityHook)
		hooksecurefunc(C_AuctionHouse, "PostItem", private.PostItemHook)
		hooksecurefunc(C_AuctionHouse, "PlaceBid", private.PlaceBidHook)
		hooksecurefunc(C_AuctionHouse, "ConfirmCommoditiesPurchase", private.ConfirmCommoditiesPurchaseHook)
	else
		hooksecurefunc("PostAuction", private.PostAuctionHook)
		hooksecurefunc("PlaceAuctionBid", private.PlaceAuctionBidHook)
	end
end)



-- ============================================================================
-- Module Functions
-- ============================================================================

---Returns whether or not an item in the player's bags can be sold on the AH (requires C_AuctionHouse).
---@param bag any
---@param slot any
---@return boolean
function AuctionHouse.IsSellable(bag, slot)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	private.itemLocation:SetBagAndSlot(bag, slot)
	return private.itemLocation:IsValid() and C_AuctionHouse.IsSellItemValid(private.itemLocation, false)
end

---Returns whether or not the owned auctions are fully loaded.
---@return boolean
function AuctionHouse.OwnedFullyLoaded()
	return not ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) or C_AuctionHouse.HasFullOwnedAuctionResults()
end

---Returns whether or not owned auctions are sorted by owner/duration (not available with C_AuctionHouse).
---@return boolean
function AuctionHouse.AreOwnedSortedByOwnerDuration()
	assert(not ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	local numColumns = #AuctionSort.owner_duration
	for i, info in ipairs(AuctionSort.owner_duration) do
		local col, reversed = GetAuctionSort("owner", numColumns - i + 1)
		-- We want to do the opposite order
		reversed = not reversed
		if col ~= info.column or info.reverse ~= reversed then
			return false
		end
	end
	return true
end

---Sorts owned auctions by owner/duration (not available with C_AuctionHouse).
function AuctionHouse.SortOwnedByOwnerDuration()
	AuctionFrame_SetSort("owner", "duration", true)
	SortAuctionApplySort("owner")
end

---Gets the number of owned auctions.
---@return number
function AuctionHouse.GetNumOwned()
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
		return C_AuctionHouse.GetNumOwnedAuctions()
	else
		return GetNumAuctionItems("owner")
	end
end

---Gets info on an owned auction (auctionId of math.huge indicates ignored WoW token).
---@param index number The owned auction index
---@return number? auctionId
---@return string|number|nil itemLinkOrId
---@return string? name
---@return number? texture
---@return number? stackSize
---@return number? quality
---@return number? currentBid
---@return number? buyout
---@return string? highBidder
---@return boolean? isSold
---@return number? duration
function AuctionHouse.GetOwnedInfo(index)
	local auctionId, link, name, texture, stackSize, quality, minBid, buyout, bid, highBidder, saleStatus, duration = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
		local info = C_AuctionHouse.GetOwnedAuctionInfo(index)
		if info.itemKey.itemID == AUCTIONABLE_WOW_TOKEN_ITEM_ID then
			-- We currently just ignore posted tokens, so just return an auctionId as math.huge to indicate this
			return math.huge
		end
		link = info and info.itemLink or info.itemKey.itemID
		bid = info.bidAmount or info.buyoutAmount
		auctionId = info.auctionID
		stackSize = info.quantity
		minBid = bid
		buyout = info.buyoutAmount or 0
		highBidder = info.bidder or ""
		saleStatus = info.status
		duration = info.timeLeftSeconds
	else
		local _
		name, texture, stackSize, quality, _, _, _, minBid, _, buyout, bid, highBidder, _, _, _, saleStatus = GetAuctionItemInfo("owner", index)
		link = name and name ~= "" and GetAuctionItemLink("owner", index)
		if not link then
			return
		end
		duration = GetAuctionItemTimeLeft("owner", index)
		auctionId = index
		highBidder = highBidder or ""
	end
	local currentBid = highBidder ~= "" and bid or minBid
	if saleStatus == 0 then
		if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
			duration = time() + duration
		end
	elseif saleStatus == 1 then
		if not currentBid and LibTSMWoW.IsRetail() then
			-- Sometimes wow doesn't tell us the current bid on sold auctions on retail
			currentBid = 0
		end
		duration = time() + duration
	else
		error("Invalid sale status: "..tostring(saleStatus))
	end
	if not link then
		return
	end
	return auctionId, link, name, texture, stackSize, quality, currentBid, buyout, highBidder, saleStatus == 1, duration
end

---Register a secure hook function for when an auction is posted.
---@param func fun(duration: number, itemLink: string?, quantity: number?, price: number?) The function to call
function AuctionHouse.SecureHookPost(func)
	tinsert(private.postHookFuncs, func)
end

---Register a callback when an item is posted.
---@param func fun(itemLink: string, quantity: number, price: number) The function to call
function AuctionHouse.RegisterItemPostedCallback(func)
	tinsert(private.itemPostedCallbacks, func)
end

---Register a secure hook function for when an auction is cancelled.
---@param func fun(auctionId: number) The function to call
function AuctionHouse.SecureHookCancel(func)
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
		hooksecurefunc(C_AuctionHouse, "CancelAuction", func)
	else
		hooksecurefunc("CancelAuction", func)
	end
end

---Register a secure hook function for when an auction is purchased.
---@param func fun(itemLink: string?, quantity: number?, price: number?) The function to call
function AuctionHouse.SecureHookPurchase(func)
	tinsert(private.purchaseHookFuncs, func)
end

---Gets info on the last purchase made.
---@return string|number|nil link
---@return string? name
---@return number? quantity
---@return number? buyout
function AuctionHouse.GetLastPurchase()
	return private.lastPurchase.link, private.lastPurchase.name, private.lastPurchase.quantity, private.lastPurchase.buyout
end

---Gets the number of black market auction house items.
---@return number?
function AuctionHouse.GetNumBlackMarketAuctions()
	return C_BlackMarket.GetNumItems()
end

---Gets info on a black market auction house item.
---@param index The auction index
---@return number quantity
---@return number minBid
---@return number minIncr
---@return number currBid
---@return number numBids
---@return number timeLeft
---@return string itemLink
---@return number bmId
function AuctionHouse.GetBlackMarketItemInfo(index)
	local _, _, quantity, _, _, _, _, _, minBid, minIncr, currBid, _, numBids, timeLeft, itemLink, bmId = C_BlackMarket.GetItemInfoByIndex(index)
	return quantity, minBid, minIncr, currBid, numBids, timeLeft, itemLink, bmId
end

---Makes an item key.
---@param itemId number The item ID
---@param battlePetSpeciesId? number The battle pet species ID
---@return ItemKey
function AuctionHouse.MakeItemKey(itemId, battlePetSpeciesId)
	local itemKey = C_AuctionHouse.MakeItemKey(itemId, 0, 0, battlePetSpeciesId)
	-- FIX for 9.0.1 bug where MakeItemKey randomly adds an itemLevel which breaks scanning
	itemKey.itemLevel = 0
	return itemKey
end

---Check if the full browse results are loaded.
---@return boolean
function AuctionHouse.HasFullBrowseResults()
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	return C_AuctionHouse.HasFullBrowseResults()
end

---Check if the full search results are loaded.
---@param item number|ItemKey Either the item ID or item key (for commodities / items respectively)
---@return boolean
function AuctionHouse.HasFullSearchResults(item)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	if type(item) == "table" then
		return C_AuctionHouse.HasFullItemSearchResults(item)
	else
		return C_AuctionHouse.HasFullCommoditySearchResults(item)
	end
end

---Gets the number of search results.
---@param item number|ItemKey Either the item ID or item key (for commodities / items respectively)
---@return number
function AuctionHouse.GetNumSearchResults(item)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	if type(item) == "table" then
		return C_AuctionHouse.GetNumItemSearchResults(item)
	else
		return C_AuctionHouse.GetNumCommoditySearchResults(item)
	end
end

---Gets the number of auctions of browse results.
---@return number
function AuctionHouse.GetNumAuctions()
	assert(not ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	local numAuctions = GetNumAuctionItems("list")
	return numAuctions
end

---Gets the number of pages of browse results.
---@return number
function AuctionHouse.GetNumPages()
	assert(not ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	local numAuctions, totalNumAuctions = GetNumAuctionItems("list")
	if numAuctions == 0 then
		-- Sometimes the AH refuses to give more results, so don't keep scanning
		totalNumAuctions = 0
	end
	return ceil(totalNumAuctions / NUM_AUCTION_ITEMS_PER_PAGE)
end

---Gets the browse results.
---@return BrowseResultInfo[]
function AuctionHouse.GetBrowseResults()
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	return C_AuctionHouse.GetBrowseResults()
end

---Gets a browse query result entry.
---@param index number The result index
---@return string? rawName
---@return string? itemLink
---@return number? stackSize
---@return number? timeLeft
---@return number? buyout
---@return string? seller
---@return number? minIncrement
---@return number? minBid
---@return number? bid,
---@return boolean? isHighBidder
function AuctionHouse.GetBrowseResult(index)
	assert(not ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	local rawName, _, stackSize, _, _, _, _, minBid, minIncrement, buyout, bid, isHighBidder, _, seller, sellerFull = GetAuctionItemInfo("list", index)
	-- This is to get around a bug in Blizzard's code where the minIncrement value will be inconsistent for auctions where the player is the highest bidder
	minIncrement = isHighBidder and 0 or minIncrement
	local itemLink = GetAuctionItemLink("list", index)
	local timeLeft = GetAuctionItemTimeLeft("list", index)
	if sellerFull and strjoin("-", seller, GetRealmName()) ~= sellerFull then
		seller = sellerFull
	end
	return rawName, itemLink, stackSize, timeLeft, buyout, seller, minIncrement, minBid, bid, isHighBidder
end

---Gets the search result info.
---@param item number|ItemKey Either the item ID or item key (for commodities / items respectively)
---@param index number The result index
---@return ExtendedItemSearchResultInfo|CommoditySearchResultInfo|nil
function AuctionHouse.GetSearchResultInfo(item, index)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	local info = nil
	if type(item) == "table" then
		info = C_AuctionHouse.GetItemSearchResultInfo(item, index)
		info.isHighBidder = info.bidder and info.bidder == UnitGUID("player") or false
	else
		info = C_AuctionHouse.GetCommoditySearchResultInfo(item, index)
	end
	for i, owner in ipairs(info.owners) do
		if owner == "player" then
			info.owners[i] = UnitName("player")
		elseif owner == "" then
			info.owners[i] = "?"
		end
	end
	return info
end

---Gets info for an item key.
---@param itemKey ItemKey The item key
---@return ItemKeyInfo?
function AuctionHouse.GetItemKeyInfo(itemKey)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	return C_AuctionHouse.GetItemKeyInfo(itemKey, true)
end

---Gets extra browse info for an item key.
---@param itemKey ItemKey The item key
---@return number?
function AuctionHouse.GetExtraBrowseInfo(itemKey)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	return C_AuctionHouse.GetExtraBrowseInfo(itemKey)
end

---Whether or not the AH is ready for a query.
---@return boolean canSendQuery
function AuctionHouse.CanSendQuery()
	if ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE) then
		return true
	else
		return CanSendAuctionQuery() and true or false
	end
end

---Gets the remaining duration on the commodity price quote.
---@return number
function AuctionHouse.GetQuoteDurationRemaining()
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	return C_AuctionHouse.GetQuoteDurationRemaining()
end

---Registers a callback for auction house notification messages.
---@param callback fun(notification: EnumValue, arg?: string|number)
function AuctionHouse.RegisterNotificationCallback(callback)
	assert(ClientInfo.HasFeature(ClientInfo.FEATURES.C_AUCTION_HOUSE))
	if #private.notificationCallbacks == 0 then
		Event.Register("AUCTION_HOUSE_SHOW_NOTIFICATION", private.HandleNotification)
		Event.Register("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION", private.HandleNotification)
		Event.Register("AUCTION_HOUSE_SHOW_COMMODITY_WON_NOTIFICATION", private.HandleCommodityNotification)
	end
	tinsert(private.notificationCallbacks, callback)
end

---Gets the formatted auction purchase message.
---@param name string The item name
---@return string
function AuctionHouse.GetPurchaseMessage(name)
	return format(ERR_AUCTION_WON_S, name)
end

---Returns whether or not the specified message is an auction purchase message.
---@param msg string The message
---@param name string The item name
---@param quantity? number The auction quantity
---@return boolean
function AuctionHouse.IsPurchaseMessage(msg, name, quantity)
	if msg == AuctionHouse.GetPurchaseMessage(name) then
		return true
	elseif quantity and ClientInfo.IsRetail() and msg == format(ERR_AUCTION_COMMODITY_WON_S, name, quantity) then
		return true
	end
	return false
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.HandleItemSearchResultsUpdated(_, itemKey)
	wipe(private.auctionIdToLink)
	wipe(private.auctionIdToItemBuyout)
	for i = 1, AuctionHouse.GetNumSearchResults(itemKey) do
		local info = AuctionHouse.GetSearchResultInfo(itemKey, i)
		if info.buyoutAmount then
			private.auctionIdToLink[info.auctionID] = info.itemLink
			private.auctionIdToItemBuyout[info.auctionID] = info.buyoutAmount
		end
	end
end

function private.PostCommodityHook(item, duration, quantity, unitPrice)
	private.HandlePostHook(duration, C_Item.GetItemLink(item), quantity, unitPrice)
end

function private.PostItemHook(item, duration, quantity, _, buyout)
	private.HandlePostHook(duration, C_Item.GetItemLink(item), quantity, buyout)
end

function private.PostAuctionHook(_, _, duration)
	private.HandlePostHook(duration)
end

function private.HandlePostHook(duration, itemLink, quantity, price)
	if itemLink then
		private.pendingPost.itemLink = itemLink
		private.pendingPost.quantity = quantity
		private.pendingPost.unitPrice = price
		private.pendingPost.timestamp = LibTSMWoW.GetTime()
	else
		wipe(private.pendingPost)
	end
	for _, func in ipairs(private.postHookFuncs) do
		func(duration, itemLink, quantity, price)
	end
end

function private.AuctionCreatedHandler()
	if LibTSMWoW.GetTime() - (private.pendingPost.timestamp or 0) > 5 then
		-- Too much time elapsed or nothing pending
		return
	end
	for _, func in ipairs(private.itemPostedCallbacks) do
		func(private.pendingPost.itemLink, private.pendingPost.quantity, private.pendingPost.unitPrice)
	end
	wipe(private.pendingPost)
end

function private.PlaceBidHook(auctionId, bidPlaced)
	local link = private.auctionIdToLink[auctionId]
	local buyout = private.auctionIdToItemBuyout[auctionId]
	if not link or buyout ~= bidPlaced then
		return
	end
	private.HandlePurchaseHook(link, nil, 1, bidPlaced)
end

function private.ConfirmCommoditiesPurchaseHook(itemId, quantity)
	local origQuantity = quantity
	local buyout = 0
	for i = 1, AuctionHouse.GetNumSearchResults(itemId) do
		local info = AuctionHouse.GetSearchResultInfo(itemId, i)
		local resultQuantity = min(quantity, info.quantity - info.numOwnerItems)
		buyout = buyout + resultQuantity * info.unitPrice
		quantity = quantity - resultQuantity
		if quantity == 0 then
			break
		end
	end
	if quantity > 0 then
		return
	end
	private.HandlePurchaseHook(itemId, nil, origQuantity, buyout)
end

function private.PlaceAuctionBidHook(_, index, amountPaid)
	local name, itemLink, stackSize, _, buyout = AuctionHouse.GetBrowseResult(index)
	if amountPaid ~= buyout then
		return
	end
	private.HandlePurchaseHook(itemLink, name, stackSize, buyout)
	for _, callback in ipairs(private.purchaseHookFuncs) do
		callback(itemLink, stackSize, buyout)
	end
end

function private.HandlePurchaseHook(link, name, quantity, price)
	private.lastPurchase.link = link
	private.lastPurchase.name = name
	private.lastPurchase.quantity = quantity
	private.lastPurchase.buyout = price
end

function private.HandleNotification(_, msg, msgArg)
	for _, callback in ipairs(private.notificationCallbacks) do
		if msg == Enum.AuctionHouseNotification.AuctionWon then
			callback(NOTIFICATION.BUY)
		elseif msg == Enum.AuctionHouseNotification.AuctionSold and msgArg then
			callback(NOTIFICATION.SOLD, msgArg)
		elseif msg == Enum.AuctionHouseNotification.AuctionOutbid and msgArg then
			callback(NOTIFICATION.OUTBID, format(ERR_AUCTION_OUTBID_S, msgArg))
		elseif msg == Enum.AuctionHouseNotification.AuctionExpired and msgArg then
			callback(NOTIFICATION.EXPIRED, format(ERR_AUCTION_EXPIRED_S, msgArg))
		elseif msg == Enum.AuctionHouseNotification.BidPlaced then
			callback(NOTIFICATION.BID, ERR_AUCTION_BID_PLACED)
		elseif msg == Enum.AuctionHouseNotification.AuctionRemoved then
			callback(NOTIFICATION.CANCELLED, ERR_AUCTION_REMOVED)
		end
	end
end

function private.HandleCommodityNotification(_, _, quantity)
	for _, callback in ipairs(private.notificationCallbacks) do
		callback(NOTIFICATION.BUY, quantity)
	end
end
