-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--             https://www.curseforge.com/wow/addons/tradeskill-master            --
--                                                                                --
--             A TradeSkillMaster Addon (https://tradeskillmaster.com)            --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local AuctionHouseWrapper = TSM.Init("Service.AuctionHouseWrapper")
local LibTSMClass = TSM.Include("LibTSMClass")
local Log = TSM.Include("Util.Log")
local Delay = TSM.Include("Util.Delay")
local Event = TSM.Include("Util.Event")
local Table = TSM.Include("Util.Table")
local Future = TSM.Include("Util.Future")
local Vararg = TSM.Include("Util.Vararg")
local APIWrapper = LibTSMClass.DefineClass("APIWrapper")
local private = {
	wrappers = {},
	events = {},
	argsTemp = {},
	sortsPartsTemp = {},
	itemKeyPartsTemp = {},
	searchQueryAPITimes = {},
	isAHOpen = false,
	lastResponseReceived = 0,
	totalHookedTime = 0,
}
local API_TIMEOUT = 5
local SEARCH_QUERY_THROTTLE_INTERVAL = 60
local SEARCH_QUERY_THROTTLE_MAX = 100
local EMPTY_SORTS_TABLE = {}
local GENERIC_EVENTS = {
	CHAT_MSG_SYSTEM = 1,
	UI_ERROR_MESSAGE = 2,
}
local INFO_APIS = {
	GetExtraBrowseInfo = true,
	GetItemKeyInfo = true,
}
local GENERIC_EVENT_SEP = "/"
local API_EVENT_INFO = {
	SendBrowseQuery = {
		AUCTION_HOUSE_BROWSE_RESULTS_UPDATED = { result = true },
	},
	SearchForFavorites = {
		AUCTION_HOUSE_BROWSE_RESULTS_UPDATED = { result = true },
	},
	SearchForItemKeys = {
		AUCTION_HOUSE_BROWSE_RESULTS_UPDATED = { result = true },
	},
	ReplicateItems = {
		REPLICATE_ITEM_LIST_UPDATE = { result = true },
	},
	RequestMoreBrowseResults = {
		AUCTION_HOUSE_BROWSE_RESULTS_ADDED = { result = true },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { timeoutChange = 1 },
	},
	SendSearchQuery = {
		COMMODITY_SEARCH_RESULTS_UPDATED = { result = true, eventArgIndex = 1, apiArgIndex = 1, apiArgKey = "itemID" },
		ITEM_SEARCH_RESULTS_UPDATED = { result = true, eventArgIndex = 1, apiArgIndex = 1 },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { timeoutChange = 1 },
	},
	SendSellSearchQuery = {
		COMMODITY_SEARCH_RESULTS_UPDATED = { result = true, eventArgIndex = 1, apiArgIndex = 1, apiArgKey = "itemID" },
		ITEM_SEARCH_RESULTS_UPDATED = { result = true, eventArgIndex = 1, apiArgIndex = 1 },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { timeoutChange = 1 },
	},
	RequestMoreCommoditySearchResults = {
		COMMODITY_SEARCH_RESULTS_ADDED = { result = true },
	},
	RequestMoreItemSearchResults = {
		ITEM_SEARCH_RESULTS_ADDED = { result = true },
	},
	RefreshCommoditySearchResults = {
		COMMODITY_SEARCH_RESULTS_UPDATED = { result = true },
	},
	RefreshItemSearchResults = {
		ITEM_SEARCH_RESULTS_UPDATED = { result = true },
	},
	QueryOwnedAuctions = {
		OWNED_AUCTIONS_UPDATED = { result = true },
	},
	QueryBids = {
		BIDS_UPDATED = { result = true },
	},
	GetExtraBrowseInfo = {
		EXTRA_BROWSE_INFO_RECEIVED = { result = true, eventArgIndex = 1, apiArgIndex = 1, apiArgKey = "itemID" },
	},
	GetItemKeyInfo = {
		ITEM_KEY_ITEM_INFO_RECEIVED = { result = true, eventArgIndex = 1, apiArgIndex = 1, apiArgKey = "itemID" },
	},
	CancelAuction = {
		AUCTION_CANCELED = { result = true, eventArgIndex = 1, apiArgIndex = 1, compareFunc = function(eventArg, apiArg) return eventArg == 0 or apiArg == eventArg end },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_ITEM_NOT_FOUND] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_NOT_ENOUGH_MONEY] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { result = false },
	},
	StartCommoditiesPurchase = {
		COMMODITY_PRICE_UPDATED = { returnCompare = true, eventArgIndex = 1, apiArgIndex = 3 },
		COMMODITY_PRICE_UNAVAILABLE = { result = false },
	},
	ConfirmCommoditiesPurchase = {
		COMMODITY_PURCHASE_SUCCEEDED = { result = true },
		COMMODITY_PURCHASE_FAILED = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_HIGHER_BID] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_ITEM_NOT_FOUND] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_BID_OWN] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_NOT_ENOUGH_MONEY] = { result = false },
	},
	PlaceBid = {
		AUCTION_CANCELED = { result = true, eventArgIndex = 1, apiArgIndex = 1 },
		["CHAT_MSG_SYSTEM"..GENERIC_EVENT_SEP..ERR_AUCTION_BID_PLACED] = { result = true },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_HIGHER_BID] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_ITEM_NOT_FOUND] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_BID_OWN] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_NOT_ENOUGH_MONEY] = { result = false },
	},
	PostItem = {
		AUCTION_HOUSE_AUCTION_CREATED = { result = true, rawFilterFunc = function(apiArgs) return apiArgs[3] <= 1 end },
		AUCTION_MULTISELL_UPDATE = { result = true, rawFilterFunc = function(apiArgs, createdCount, totalToCreate) return createdCount == totalToCreate end },
		AUCTION_MULTISELL_FAILURE = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_ITEM_NOT_FOUND] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_REPAIR_ITEM] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_LIMITED_DURATION_ITEM] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_USED_CHARGES] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_WRAPPED_ITEM] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_BAG] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_NOT_ENOUGH_MONEY] = { result = nil },
	},
	PostCommodity = {
		AUCTION_HOUSE_AUCTION_CREATED = { result = true },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_ITEM_NOT_FOUND] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_DATABASE_ERROR] = { result = false },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_REPAIR_ITEM] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_LIMITED_DURATION_ITEM] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_USED_CHARGES] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_WRAPPED_ITEM] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_AUCTION_BAG] = { result = nil },
		["UI_ERROR_MESSAGE"..GENERIC_EVENT_SEP..ERR_NOT_ENOUGH_MONEY] = { result = nil },
	},
}



-- ============================================================================
-- Module Loading
-- ============================================================================

AuctionHouseWrapper:OnModuleLoad(function()
	if TSM.IsWowClassic() then
		return
	end

	Event.Register("AUCTION_HOUSE_SHOW", private.AuctionHouseShowHandler)
	Event.Register("AUCTION_HOUSE_CLOSED", private.AuctionHouseClosedHandler)

	-- setup wrappers
	for apiName in pairs(API_EVENT_INFO) do
		private.wrappers[apiName] = APIWrapper(apiName)
	end

	-- extra hooks to track search query calls since they are limited
	hooksecurefunc(C_AuctionHouse, "SendSearchQuery", function()
		tinsert(private.searchQueryAPITimes, GetTime())
	end)
	hooksecurefunc(C_AuctionHouse, "SendSellSearchQuery", function()
		tinsert(private.searchQueryAPITimes, GetTime())
	end)

	-- general events
	Event.Register("AUCTION_HOUSE_THROTTLED_MESSAGE_RESPONSE_RECEIVED", private.ResponseReceivedHandler)

	-- extra events that are interesting to log
	Event.Register("AUCTION_HOUSE_NEW_RESULTS_RECEIVED", private.UnusedEventHandler)
	Event.Register("AUCTION_HOUSE_THROTTLED_MESSAGE_DROPPED", private.UnusedEventHandler)
	Event.Register("AUCTION_HOUSE_THROTTLED_MESSAGE_QUEUED", private.UnusedEventHandler)
	Event.Register("AUCTION_HOUSE_THROTTLED_MESSAGE_SENT", private.UnusedEventHandler)
	Event.Register("AUCTION_HOUSE_THROTTLED_SPECIFIC_SEARCH_READY", private.UnusedEventHandler)
	Event.Register("AUCTION_HOUSE_THROTTLED_SYSTEM_READY", private.UnusedEventHandler)
end)



-- ============================================================================
-- Module Functions
-- ============================================================================

function AuctionHouseWrapper.GetAndResetTotalHookedTime()
	local total = private.totalHookedTime
	private.totalHookedTime = 0
	return total
end

function AuctionHouseWrapper.SendBrowseQuery(query)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.SendBrowseQuery:Start(query)
end

function AuctionHouseWrapper.RequestMoreBrowseResults()
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.RequestMoreBrowseResults:Start()
end

function AuctionHouseWrapper.SendSearchQuery(itemKey, isSell)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	-- remove times which are beyond the throttle interval
	for i = #private.searchQueryAPITimes, 1, -1 do
		if GetTime() - private.searchQueryAPITimes[i] >= SEARCH_QUERY_THROTTLE_INTERVAL then
			tremove(private.searchQueryAPITimes, i)
		end
	end
	if #private.searchQueryAPITimes >= SEARCH_QUERY_THROTTLE_MAX then
		local delayTime = private.searchQueryAPITimes[1] + SEARCH_QUERY_THROTTLE_INTERVAL - GetTime()
		assert(delayTime > 0, "Invalid delay time: "..tostring(delayTime))
		Log.Err("Search query can't be run for another %.3f seconds", delayTime)
		return nil, delayTime
	end
	assert(type(isSell) == "boolean")
	if isSell then
		return private.wrappers.SendSellSearchQuery:Start(itemKey, EMPTY_SORTS_TABLE, true)
	else
		return private.wrappers.SendSearchQuery:Start(itemKey, EMPTY_SORTS_TABLE, true)
	end
end

function AuctionHouseWrapper.RequestMoreCommoditySearchResults(itemId)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.RequestMoreCommoditySearchResults:Start(itemId)
end

function AuctionHouseWrapper.RequestMoreItemSearchResults(itemKey)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.RequestMoreItemSearchResults:Start(itemKey)
end

function AuctionHouseWrapper.QueryOwnedAuctions(sorts)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.QueryOwnedAuctions:Start(sorts)
end

function AuctionHouseWrapper.GetItemKeyInfo(itemKey, restrictQualityToFilter)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.GetItemKeyInfo:Start(itemKey, restrictQualityToFilter)
end

function AuctionHouseWrapper.CancelAuction(auctionId)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.CancelAuction:Start(auctionId)
end

function AuctionHouseWrapper.StartCommoditiesPurchase(itemId, quantity, itemBuyout)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.StartCommoditiesPurchase:Start(itemId, quantity, itemBuyout)
end

function AuctionHouseWrapper.ConfirmCommoditiesPurchase(itemId, quantity)
	assert(not TSM.IsWowClassic())
	-- TODO: re-enable this once we don't try to start and confirm in the same frame
	-- if not private.CheckAllIdle() then
	-- 	return
	-- end
	return private.wrappers.ConfirmCommoditiesPurchase:Start(itemId, quantity)
end

function AuctionHouseWrapper.PlaceBid(auctionId, bidBuyout)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.PlaceBid:Start(auctionId, bidBuyout)
end

function AuctionHouseWrapper.PostItem(itemLocation, postTime, stackSize, bid, buyout)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.PostItem:Start(itemLocation, postTime, stackSize, bid, buyout)
end

function AuctionHouseWrapper.PostCommodity(itemLocation, postTime, stackSize, itemBuyout)
	assert(not TSM.IsWowClassic())
	if not private.CheckAllIdle() then
		return
	end
	return private.wrappers.PostCommodity:Start(itemLocation, postTime, stackSize, itemBuyout)
end



-- ============================================================================
-- APIWrapper Class
-- ============================================================================

function APIWrapper.__init(self, name)
	self._name = name
	self._args = {}
	self._state = "IDLE"
	self._hookedTime = nil
	self._future = Future.New(self._name.."_FUTURE")
	self._future:SetScript("OnCleanup", function()
		if self._state == "PENDING_REQUESTED" then
			-- switch the current call to a hooked call
			self._state = "PENDING_HOOKED"
		elseif self._state == "DONE" then
			self._state = "IDLE"
		end
	end)
	self._timeoutWrapper = function()
		Log.Err("API timed out: %s(%s)", self._name, private.ArgsToStr(unpack(self._args)))
		return self:_Done(false)
	end

	-- hook the API
	hooksecurefunc(C_AuctionHouse, self._name, function(...)
		-- defer the log for info APIs to only show if they actually issue a request so they aren't so spammy
		if not INFO_APIS[self._name] then
			Log.Info("%s(%s)", self._name, private.ArgsToStr(...))
		end
		if self:_IsPending() and select("#", ...) == 0 then
			return
		end
		self:CancelIfPending()
		if self:_HandleAPICall(...) then
			if INFO_APIS[self._name] then
				Log.Info("%s(%s)", self._name, private.ArgsToStr(...))
			end
			for _, wrapper in pairs(private.wrappers) do
				if wrapper ~= self and GetTime() ~= private.lastResponseReceived then
					wrapper:CancelIfPending()
				end
			end
		end
	end)

	-- register related events
	for eventName in pairs(API_EVENT_INFO[self._name]) do
		private.RegisterForEvent(eventName, self)
	end
end

function APIWrapper.IsIdle(self)
	return self._state == "IDLE"
end

function APIWrapper.CancelIfPending(self)
	if not self:_IsPending() then
		return
	end
	Log.Warn("Canceling pending (%s, %s)", self._name, self._state)
	self:_Done(false)
end

function APIWrapper.Start(self, ...)
	if self._state ~= "IDLE" then
		Log.Err("API already in progress (%s)", self._name)
		return
	end
	self._state = "STARTING"
	self:_CallAPI(...)
	return self._future
end

function APIWrapper._IsPending(self)
	return self._state == "PENDING_REQUESTED" or self._state == "PENDING_HOOKED"
end

function APIWrapper._CallAPI(self, ...)
	return C_AuctionHouse[self._name](...)
end

function APIWrapper._HandleAPICall(self, ...)
	if self._state == "CHECK" then
		-- this is a recursive call to check on the info API return value
		assert(INFO_APIS[self._name])
		return false
	elseif self._state == "IDLE" then
		if INFO_APIS[self._name] then
			-- get the return value of the API to check if the info is already available
			self._state = "CHECK"
			if self:_CallAPI(...) then
				self._state = "IDLE"
				return false
			end
		end
		self._state = "PENDING_HOOKED"
		self._hookedTime = GetTime()
	elseif self._state == "STARTING" then
		self._future:Start()
		if INFO_APIS[self._name] then
			-- get the return value of the API to check if the info is already available
			self._state = "CHECK"
			local result = self:_CallAPI(...)
			self._state = "PENDING_REQUESTED"
			if result then
				self:_Done(result)
				return false
			end
		else
			self._state = "PENDING_REQUESTED"
		end
	else
		error("Unexpected state: "..self._state)
	end
	Vararg.IntoTable(self._args, ...)
	Delay.AfterTime(self._name.."_TIMEOUT", private.isAHOpen and API_TIMEOUT or 0, self._timeoutWrapper)
	return true
end

function APIWrapper._HandleEvent(self, eventName, ...)
	if self._state ~= "PENDING_REQUESTED" and self._state ~= "PENDING_HOOKED" then
		return
	end
	local eventIsValid, result = self:_ValidateEvent(eventName, ...)
	if not eventIsValid then
		Log.Info("Ignoring invalidated event")
		return
	end
	self:_Done(result)
end

function APIWrapper._ValidateEvent(self, eventName, ...)
	local info = nil
	if GENERIC_EVENTS[eventName] then
		local arg = ...
		info = API_EVENT_INFO[self._name][eventName..GENERIC_EVENT_SEP..arg]
	else
		info = API_EVENT_INFO[self._name][eventName]
	end
	assert(info)
	if info.timeoutChange then
		Delay.Cancel(self._name.."_TIMEOUT")
		Delay.AfterTime(self._name.."_TIMEOUT", info.timeoutChange, self._timeoutWrapper)
		return false
	end
	local eventIsValid, result = true, info.result
	if info.rawFilterFunc then
		if not info.rawFilterFunc(self._args, ...) then
			eventIsValid = false
		end
	elseif info.eventArgIndex then
		local eventValue = select(info.eventArgIndex, ...)
		local apiValue = self._args[info.apiArgIndex]
		if info.apiArgKey then
			apiValue = apiValue[info.apiArgKey]
		end
		local argMatches = nil
		assert(type(eventValue) == type(apiValue))
		if info.compareFunc then
			argMatches = info.compareFunc(eventValue, apiValue)
		elseif type(eventValue) == "table" then
			argMatches = Table.Equal(eventValue, apiValue)
		else
			argMatches = eventValue == apiValue
		end
		if info.returnCompare then
			result = argMatches
		elseif not argMatches then
			eventIsValid = false
		end
	end
	if eventIsValid and INFO_APIS[self._name] then
		-- call the API to get the result
		local prevState = self._state
		assert(prevState == "PENDING_REQUESTED" or prevState == "PENDING_HOOKED")
		self._state = "CHECK"
		result = self:_CallAPI(unpack(self._args))
		assert(result)
		-- go back to the previous state
		self._state = prevState
	end
	return eventIsValid, result
end

function APIWrapper._Done(self, result)
	wipe(self._args)
	local hookedTime = self._hookedTime
	self._hookedTime = nil
	Delay.Cancel(self._name.."_TIMEOUT")
	if self._state == "PENDING_REQUESTED" then
		self._state = "DONE"
		-- need to do this last as it might trigger another API call or OnCleanup on the future
		self._future:Done(result)
	elseif self._state == "PENDING_HOOKED" then
		self._state = "IDLE"
		if hookedTime then
			private.totalHookedTime = private.totalHookedTime + GetTime() - hookedTime
		end
	else
		error("Unexpected state: "..self._state)
	end
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.AuctionHouseShowHandler()
	private.isAHOpen = true
end

function private.AuctionHouseClosedHandler()
	private.isAHOpen = false
	for _, wrapper in pairs(private.wrappers) do
		wrapper:CancelIfPending()
	end
end

function private.ItemKeyToStr(itemKey)
	assert(#private.itemKeyPartsTemp == 0)
	if itemKey.itemID ~= 0 then
		tinsert(private.itemKeyPartsTemp, "itemID="..itemKey.itemID)
	end
	if itemKey.itemLevel ~= 0 then
		tinsert(private.itemKeyPartsTemp, "itemLevel="..itemKey.itemLevel)
	end
	if itemKey.itemSuffix ~= 0 then
		tinsert(private.itemKeyPartsTemp, "itemSuffix="..itemKey.itemSuffix)
	end
	if itemKey.battlePetSpeciesID ~= 0 then
		tinsert(private.itemKeyPartsTemp, "battlePetSpeciesID="..itemKey.battlePetSpeciesID)
	end
	local result = format("{%s}", table.concat(private.itemKeyPartsTemp, ","))
	wipe(private.itemKeyPartsTemp)
	return result
end

function private.SortsToStr(sorts)
	assert(#private.sortsPartsTemp == 0)
	for _, sort in ipairs(sorts) do
		local name = Table.KeyByValue(Enum.AuctionHouseSortOrder, sort.sortOrder) or "?"
		tinsert(private.sortsPartsTemp, format("%s%s", sort.reverseSort and "-" or "", name))
	end
	local result = format("{%s}", table.concat(private.sortsPartsTemp, ","))
	wipe(private.sortsPartsTemp)
	return result
end

function private.ArgToStr(arg)
	if type(arg) == "table" then
		local count = Table.Count(arg)
		if arg.itemID and arg.itemSuffix then
			return private.ItemKeyToStr(arg)
		elseif arg.searchString then
			return format("{searchString=\"%s\", sorts=%s, minLevel=%s, maxLevel=%s, filters=%s, itemClassFilters=%s}", arg.searchString, private.SortsToStr(arg.sorts), private.ArgToStr(arg.minLevel), private.ArgToStr(arg.maxLevel), private.ArgToStr(arg.filters), private.ArgToStr(arg.itemClassFilters))
		elseif arg.IsBagAndSlot then
			return format("{<ItemLocation:(%d,%d)>}", arg:GetBagAndSlot())
		elseif count == 0 then
			return "{}"
		elseif count == #arg then
			return format("{<%d items>}", count)
		else
			return "{...}"
		end
	else
		return tostring(arg)
	end
end

function private.ArgsToStr(...)
	assert(#private.argsTemp == 0)
	for _, arg in Vararg.Iterator(...) do
		tinsert(private.argsTemp, private.ArgToStr(arg))
	end
	local result = table.concat(private.argsTemp, ",")
	wipe(private.argsTemp)
	return result
end

function private.RegisterForEvent(eventName, wrapper)
	local genericEventArg = nil
	eventName, genericEventArg = strsplit(GENERIC_EVENT_SEP, eventName)
	if not private.events[eventName] then
		private.events[eventName] = {}
		Event.Register(eventName, private.EventHandler)
	end
	if genericEventArg then
		private.events[eventName][genericEventArg] = private.events[eventName][genericEventArg] or {}
		tinsert(private.events[eventName][genericEventArg], wrapper)
	else
		tinsert(private.events[eventName], wrapper)
	end
end

function private.EventHandler(eventName, ...)
	-- reduce the log spam of generic events by combining the message with the name and discarding arguments
	local genericEventArg = nil
	if GENERIC_EVENTS[eventName] then
		genericEventArg = select(GENERIC_EVENTS[eventName], ...)
		assert(genericEventArg)
		if not private.events[eventName][genericEventArg] then
			return
		end
		private.EventHandlerHelper(private.events[eventName][genericEventArg], eventName, genericEventArg)
	else
		private.EventHandlerHelper(private.events[eventName], eventName, ...)
	end
end

function private.ResponseReceivedHandler(eventName, ...)
	Log.Info("%s (%s)", eventName, private.ArgsToStr(...))
	private.lastResponseReceived = GetTime()
end

function private.UnusedEventHandler(eventName, ...)
	Log.Info("%s (%s)", eventName, private.ArgsToStr(...))
end

function private.EventHandlerHelper(wrappers, eventName, ...)
	Log.Info("%s (%s)", eventName, private.ArgsToStr(...))
	for _, wrapper in ipairs(wrappers) do
		wrapper:_HandleEvent(eventName, ...)
	end
end

function private.CheckAllIdle()
	for apiName, wrapper in pairs(private.wrappers) do
		if not wrapper:IsIdle() then
			Log.Err("Another wrapper is pending (%s)", apiName)
			return false
		end
	end
	return true
end
