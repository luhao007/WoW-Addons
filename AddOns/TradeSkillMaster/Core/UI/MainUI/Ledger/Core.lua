-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Ledger = TSM.MainUI:NewPackage("Ledger") ---@type AddonPackage
local L = TSM.Locale.GetTable()
local TempTable = TSM.LibTSMUtil:Include("BaseType.TempTable")
local Table = TSM.LibTSMUtil:Include("Lua.Table")
local Money = TSM.LibTSMUtil:Include("UI.Money")
local Theme = TSM.LibTSMService:Include("UI.Theme")
local TextureAtlas = TSM.LibTSMService:Include("UI.TextureAtlas")
local ItemInfo = TSM.LibTSMService:Include("Item.ItemInfo")
local UIElements = TSM.LibTSMUI:Include("Util.UIElements")
local UIUtils = TSM.LibTSMUI:Include("Util.UIUtils")
local SECONDS_PER_DAY = 24 * 60 * 60
local private = {
	settings = nil,
	pages = {},
	childPages = {},
	callback = {},
	contextPath = nil,
	contextItemString = nil,
	itemDetailType = "sale",
}
local NUM_TOP_PLAYERS = 3
local PAGE_PATH_SEP = "`"



-- ============================================================================
-- Module Functions
-- ============================================================================

function Ledger.OnInitialize(settingsDB)
	private.settings = settingsDB:NewView()
		:AddKey("global", "mainUIContext", "ledgerDetailScrollingTable")
	TSM.MainUI.RegisterTopLevelPage(L["Ledger"], private.GetLedgerFrame)
end

function Ledger.RegisterPage(name, callback)
	tinsert(private.pages, name)
	private.callback[name] = callback
end

function Ledger.RegisterChildPage(parentName, childName, callback)
	local path = parentName..PAGE_PATH_SEP..childName
	private.childPages[parentName] = private.childPages[parentName] or {}
	tinsert(private.childPages[parentName], childName)
	private.callback[path] = callback
end

function Ledger.ShowItemDetail(frame, itemString, detailType)
	assert(detailType == "sale" or detailType == "buy")
	private.contextItemString = itemString
	private.itemDetailType = detailType
	frame:SetPath("itemDetail", true)
end



-- ============================================================================
-- Ledger UI
-- ============================================================================

function private.GetLedgerFrame()
	UIUtils.AnalyticsRecordPathChange("main", "ledger")
	local defaultPage = private.pages[1]
	local frame = UIElements.New("Frame", "ledger")
		:SetLayout("HORIZONTAL")
		:SetBackgroundColor("PRIMARY_BG_ALT")
		:AddChild(UIElements.New("Frame", "navigation")
			:SetLayout("VERTICAL")
			:SetWidth(160)
			:SetPadding(12, 12, 1, 9)
		)
		:AddChild(UIElements.New("VerticalLine", "divider"))
		:AddChild(UIElements.New("Frame", "contentFrame")
			:SetLayout("VERTICAL")
			:AddChild(UIElements.New("ViewContainer", "content")
				:SetNavCallback(private.ContentNavCallback)
				:AddPath("itemDetail")
			)
		)
		:SetScript("OnHide", private.NavButtonOnHide)

	local content = frame:GetElement("contentFrame.content")
	local navFrame = frame:GetElement("navigation")
	for _, pageName in ipairs(private.pages) do
		navFrame:AddChild(UIElements.New("Button", pageName)
			:SetHeight(20)
			:SetMargin(0, 0, 8, 0)
			:SetFont("BODY_BODY2_BOLD")
			:SetJustifyH("LEFT")
			:SetContext(pageName)
			:SetText(pageName)
			:SetScript("OnClick", private.NavButtonOnClick)
		)
		content:AddPath(pageName, pageName == defaultPage)
		if private.childPages[pageName] then
			for _, childPageName in ipairs(private.childPages[pageName]) do
				local path = pageName..PAGE_PATH_SEP..childPageName
				navFrame:AddChild(UIElements.New("Button", path)
					:SetHeight(20)
					:SetMargin(9, 0, 8, 0)
					:SetFont("BODY_BODY3_MEDIUM")
					:SetJustifyH("LEFT")
					:SetContext(path)
					:SetText(childPageName)
					:SetScript("OnClick", private.NavButtonOnClick)
				)
				content:AddPath(path, path == defaultPage)
			end
		end
	end
	-- make all the navigation align to the top
	navFrame:AddChild(UIElements.New("Spacer", "spacer"))

	private.UpdateNavFrame(navFrame, defaultPage)
	private.contextPath = L["Inventory"]
	return frame
end

function private.ContentNavCallback(self, path)
	if path == "itemDetail" then
		return private.GetItemDetail()
	else
		return private.callback[path]()
	end
end



-- ============================================================================
-- Local Script Handlers
-- ============================================================================

function private.NavButtonOnClick(button)
	local path = button:GetContext()
	if private.contextPath == path then
		return
	end
	if private.childPages[path] then
		-- select the first child
		path = path..PAGE_PATH_SEP..private.childPages[path][1]
	end

	local ledgerFrame = button:GetParentElement():GetParentElement()
	local contentFrame = ledgerFrame:GetElement("contentFrame")
	local navFrame = ledgerFrame:GetElement("navigation")
	private.UpdateNavFrame(navFrame, path)
	navFrame:Draw()
	contentFrame:GetElement("content"):SetPath(path, private.contextPath ~= path)
	private.contextPath = path
end

function private.NavButtonOnHide(button)
	private.contextPath = nil
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.UpdateNavFrame(navFrame, selectedPath)
	local selectedPage = strsplit(PAGE_PATH_SEP, selectedPath)
	for _, pageName in ipairs(private.pages) do
		navFrame:GetElement(pageName):SetTextColor(pageName == selectedPage and "TEXT" or "ACTIVE_BG_ALT")
		if private.childPages[pageName] then
			for _, childPageName in ipairs(private.childPages[pageName]) do
				local path = pageName..PAGE_PATH_SEP..childPageName
				if pageName == selectedPage then
					navFrame:GetElement(path)
						:SetTextColor(path == selectedPath and "INDICATOR" or "TEXT")
						:Show()
				else
					navFrame:GetElement(path):Hide()
				end
			end
		end
	end
end

function private.GetItemDetail()
	local query = TSM.Accounting.Transactions.CreateQuery()
		:Equal("filteredItemString", private.contextItemString)
		:VirtualField("totalPrice", "number", private.TotalPriceVirtualField)

	local topPlayersQuantity = TempTable.Acquire()
	local topPlayers = TempTable.Acquire()
	for _, row in query:Iterator() do
		local recordType, otherPlayer, quantity = row:GetFields("type", "otherPlayer", "quantity")
		if recordType == private.itemDetailType then
			if not topPlayersQuantity[otherPlayer] then
				topPlayersQuantity[otherPlayer] = 0
				tinsert(topPlayers, otherPlayer)
			end
			topPlayersQuantity[otherPlayer] = topPlayersQuantity[otherPlayer] + quantity
		end
	end

	Table.SortWithValueLookup(topPlayers, topPlayersQuantity, true)
	local numTopPlayers = min(#topPlayers, NUM_TOP_PLAYERS)
	local topPlayersText = ""
	if numTopPlayers > 0 then
		for i = 1, numTopPlayers do
			local player = topPlayers[i]
			local quantity = topPlayersQuantity[player]
			topPlayers[i] = player..Theme.GetColor("INDICATOR_ALT"):ColorText(" (" .. quantity .. ")")
		end
		topPlayersText = table.concat(topPlayers, ", ", 1, numTopPlayers)
	else
		topPlayersText = L["None"]
	end
	TempTable.Release(topPlayers)
	TempTable.Release(topPlayersQuantity)

	return UIElements.New("Frame", "content")
		:SetLayout("VERTICAL")
		:AddChild(UIElements.New("Frame", "top")
			:SetLayout("VERTICAL")
			:SetPadding(8)
			:SetBackgroundColor("PRIMARY_BG_ALT")
			:AddChild(UIElements.New("Frame", "header")
				:SetLayout("HORIZONTAL")
				:SetHeight(24)
				:AddChild(UIElements.New("ActionButton", "button")
					:SetWidth(64)
					:SetText(TextureAtlas.GetTextureLink(TextureAtlas.GetFlippedHorizontallyKey("iconPack.14x14/Chevron/Right"))..BACK)
					:SetScript("OnClick", private.ItemDetailBackButtonOnClick)
				)
				:AddChild(UIElements.New("Button", "icon")
					:SetSize(24, 24)
					:SetMargin(14, 8, 0, 0)
					:SetBackground(ItemInfo.GetTexture(private.contextItemString))
					:SetTooltip(private.contextItemString)
				)
				:AddChild(UIElements.New("Text", "itemName")
					:SetFont("ITEM_BODY1")
					:SetText(UIUtils.GetDisplayItemName(private.contextItemString))
				)
			)
			:AddChild(UIElements.New("Frame", "content")
				:SetLayout("VERTICAL")
				:SetMargin(0, 0, 8, 0)
				:SetPadding(12, 12, 8, 10)
				:SetRoundedBackgroundColor("PRIMARY_BG_ALT")
				:SetBorderColor("ACTIVE_BG")
				:AddChild(UIElements.New("Frame", "heading")
					:SetLayout("HORIZONTAL")
					:SetHeight(20)
					:AddChild(UIElements.New("Button", "saleBtn")
						:SetWidth("AUTO")
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY2_BOLD")
						:SetTextColor(private.itemDetailType == "sale" and "INDICATOR" or "ACTIVE_BG_ALT")
						:SetContext("sale")
						:SetText(L["Sale Data"])
						:SetScript("OnClick", private.ItemDetailTabOnClick)
					)
					:AddChild(UIElements.New("Button", "buyBtn")
						:SetWidth("AUTO")
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY2_BOLD")
						:SetTextColor(private.itemDetailType == "buy" and "INDICATOR" or "ACTIVE_BG_ALT")
						:SetContext("buy")
						:SetText(L["Purchase Data"])
						:SetScript("OnClick", private.ItemDetailTabOnClick)
					)
					:AddChild(UIElements.New("Spacer", "spacer"))
					:AddChild(UIElements.New("Text", "total")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY3_MEDIUM")
						:SetJustifyH("RIGHT")
						:SetText(L["Total"])
					)
					:AddChild(UIElements.New("Text", "last7")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY3_MEDIUM")
						:SetJustifyH("RIGHT")
						:SetText(L["Last 7 Days"])
					)
					:AddChild(UIElements.New("Text", "last30")
						:SetWidth(120)
						:SetFont("BODY_BODY3_MEDIUM")
						:SetJustifyH("RIGHT")
						:SetText(L["Last 30 Days"])
					)
				)
				:AddChild(UIElements.New("Frame", "quantity")
					:SetLayout("HORIZONTAL")
					:SetHeight(20)
					:SetMargin(0, 0, 8, 0)
					:AddChild(UIElements.New("Text", "label")
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY3")
						:SetTextColor("TEXT_ALT")
						:SetText(private.itemDetailType == "sale" and L["Quantity Sold:"] or L["Quantity Purchased:"])
					)
					:AddChild(UIElements.New("Text", "total")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(TSM.Accounting.Transactions.GetQuantity(private.contextItemString, nil, private.itemDetailType))
					)
					:AddChild(UIElements.New("Text", "last7")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(TSM.Accounting.Transactions.GetQuantity(private.contextItemString, SECONDS_PER_DAY * 7, private.itemDetailType))
					)
					:AddChild(UIElements.New("Text", "last30")
						:SetWidth(120)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(TSM.Accounting.Transactions.GetQuantity(private.contextItemString, SECONDS_PER_DAY * 30, private.itemDetailType))
					)
				)
				:AddChild(UIElements.New("Frame", "avgPrice")
					:SetLayout("HORIZONTAL")
					:SetHeight(20)
					:SetMargin(0, 0, 8, 0)
					:AddChild(UIElements.New("Text", "label")
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY3")
						:SetTextColor("TEXT_ALT")
						:SetText(L["Average Prices:"])
					)
					:AddChild(UIElements.New("Text", "total")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(Money.ToStringForUI(TSM.Accounting.Transactions.GetAveragePrice(private.contextItemString, nil, private.itemDetailType)))
					)
					:AddChild(UIElements.New("Text", "last7")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(Money.ToStringForUI(TSM.Accounting.Transactions.GetAveragePrice(private.contextItemString, SECONDS_PER_DAY * 7, private.itemDetailType)))
					)
					:AddChild(UIElements.New("Text", "last30")
						:SetWidth(120)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(Money.ToStringForUI(TSM.Accounting.Transactions.GetAveragePrice(private.contextItemString, SECONDS_PER_DAY * 30, private.itemDetailType)))
					)
				)
				:AddChild(UIElements.New("Frame", "totalPrice")
					:SetLayout("HORIZONTAL")
					:SetHeight(20)
					:SetMargin(0, 0, 8, 0)
					:AddChild(UIElements.New("Text", "label")
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY3")
						:SetTextColor("TEXT_ALT")
						:SetText(L["Total Prices:"])
					)
					:AddChild(UIElements.New("Text", "total")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(Money.ToStringForUI(TSM.Accounting.Transactions.GetTotalPrice(private.contextItemString, nil, private.itemDetailType)))
					)
					:AddChild(UIElements.New("Text", "last7")
						:SetWidth(120)
						:SetMargin(0, 8, 0, 0)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(Money.ToStringForUI(TSM.Accounting.Transactions.GetTotalPrice(private.contextItemString, SECONDS_PER_DAY * 7, private.itemDetailType)))
					)
					:AddChild(UIElements.New("Text", "last30")
						:SetWidth(120)
						:SetFont("TABLE_TABLE1")
						:SetJustifyH("RIGHT")
						:SetText(Money.ToStringForUI(TSM.Accounting.Transactions.GetTotalPrice(private.contextItemString, SECONDS_PER_DAY * 30, private.itemDetailType)))
					)
				)
				:AddChild(UIElements.New("Frame", "top")
					:SetLayout("HORIZONTAL")
					:SetHeight(20)
					:SetMargin(0, 0, 8, 0)
					:AddChild(UIElements.New("Text", "label")
						:SetWidth("AUTO")
						:SetMargin(0, 8, 0, 0)
						:SetFont("BODY_BODY3")
						:SetTextColor("TEXT_ALT")
						:SetText(private.itemDetailType == "sale" and L["Top Buyers"]..":" or L["Top Sellers"]..":")
					)
					:AddChild(UIElements.New("Text", "value")
						:SetFont("BODY_BODY3")
						:SetText(topPlayersText)
					)
				)
			)
		)
		:AddChild(UIElements.New("LedgerDetailScrollTable", "scrollingTable")
			:SetSettings(private.settings, "ledgerDetailScrollingTable")
			:SetQuery(query)
			:SetDeleteFunctions(TSM.Accounting.Transactions.CanDeleteByUUID, TSM.Accounting.Transactions.RemoveRowByUUID)
		)
end

function private.ItemDetailBackButtonOnClick(button)
	button:GetParentElement():GetParentElement():GetParentElement():GetParentElement():SetPath(private.contextPath, true)
end

function private.ItemDetailTabOnClick(button)
	private.itemDetailType = button:GetContext()
	button:GetParentElement():GetParentElement():GetParentElement():GetParentElement():GetParentElement():ReloadContent()
end

function private.TotalPriceVirtualField(row)
	return row:GetField("price") * row:GetField("quantity")
end
