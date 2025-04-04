-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Auctioning = TSM.MainUI.Settings:NewPackage("Auctioning") ---@type AddonPackage
local ClientInfo = TSM.LibTSMWoW:Include("Util.ClientInfo")
local L = TSM.Locale.GetTable()
local String = TSM.LibTSMUtil:Include("Lua.String")
local ChatMessage = TSM.LibTSMService:Include("UI.ChatMessage")
local UIElements = TSM.LibTSMUI:Include("Util.UIElements")
local UIUtils = TSM.LibTSMUI:Include("Util.UIUtils")
local private = {
	settingsDB = nil,
	settings = nil,
}
local SETTING_TOOLTIPS = {
	cancelWithBid = L["If enabled, TSM will cancel undercut auctions even if they have been bid on."],
	disableInvalidMsg = L["When starting a post or cancel scan, TSM will display error messages in chat for items which have invalid settings. This setting will disable those messages."],
	scanCompleteSound = L["The sound to play when a post or cancel scan has completed and items are ready to be posted or cancelled respectively."],
	confirmCompleteSound = L["The sound to play when all posts or cancels have been confirmed by the game."],
	auctionSaleSound = L["The sound to play when one of your auctions sells."],
}



-- ============================================================================
-- Module Functions
-- ============================================================================

function Auctioning.OnInitialize(settingsDB)
	private.settingsDB = settingsDB
	private.settings = settingsDB:NewView()
		:AddKey("global", "auctioningOptions", "cancelWithBid")
		:AddKey("global", "auctioningOptions", "disableInvalidMsg")
		:AddKey("global", "auctioningOptions", "scanCompleteSound")
		:AddKey("global", "auctioningOptions", "confirmCompleteSound")
		:AddKey("global", "auctioningOptions", "matchWhitelist")
		:AddKey("global", "coreOptions", "auctionSaleSound")
		:AddKey("global", "coreOptions", "regionWide")
	if ClientInfo.IsVanillaClassic() then
		private.settings:AddKey("factionrealm", "auctioningOptions", "whitelist")
	end
	TSM.MainUI.Settings.RegisterSettingPage(L["Auctioning"], "middle", private.GetAuctioningSettingsFrame)
end



-- ============================================================================
-- Auctioning Settings UI
-- ============================================================================

function private.GetAuctioningSettingsFrame()
	UIUtils.AnalyticsRecordPathChange("main", "settings", "auctioning")
	return UIElements.New("ScrollFrame", "auctioningSettings")
		:SetPadding(8, 8, 8, 0)
		:AddChild(TSM.MainUI.Settings.CreateExpandableSection("Auctioning", "auctioning", L["General Options"], L["Some general Auctioning options are below."])
			:AddChild(UIElements.New("Frame", "check1")
				:SetLayout("HORIZONTAL")
				:SetHeight(20)
				:SetMargin(0, 0, 0, 12)
				:AddChild(UIElements.New("Checkbox", "cancelBids")
					:SetWidth("AUTO")
					:SetFont("BODY_BODY2_MEDIUM")
					:SetText(L["Cancel auctions with bids"])
					:SetSettingInfo(private.settings, "cancelWithBid")
					:SetTooltip(SETTING_TOOLTIPS.cancelWithBid)
				)
				:AddChild(UIElements.New("Spacer", "spacer"))
			)
			:AddChild(UIElements.New("Frame", "check2")
				:SetLayout("HORIZONTAL")
				:SetHeight(20)
				:AddChild(UIElements.New("Checkbox", "invalidPrice")
					:SetWidth("AUTO")
					:SetFont("BODY_BODY2_MEDIUM")
					:SetText(L["Disable invalid price warnings"])
					:SetSettingInfo(private.settings, "disableInvalidMsg")
					:SetTooltip(SETTING_TOOLTIPS.disableInvalidMsg)
				)
				:AddChild(UIElements.New("Spacer", "spacer"))
			)
		)
		:AddChild(TSM.MainUI.Settings.CreateExpandableSection("Auctioning", "sounds", L["Auction House Sounds"], L["Setup various sounds that play when doing Auctioning scans."])
			:AddChild(UIElements.New("Frame", "labelLine1")
				:SetLayout("HORIZONTAL")
				:SetHeight(20)
				:SetMargin(0, 0, 0, 4)
				:AddChild(UIElements.New("Text", "scan")
					:SetMargin(0, 12, 0, 0)
					:SetFont("BODY_BODY2_MEDIUM")
					:SetText(L["Scan complete sound"])
				)
				:AddChild(UIElements.New("Text", "confirm")
					:SetFont("BODY_BODY2_MEDIUM")
					:SetText(L["Confirm complete sound"])
				)
			)
			:AddChild(UIElements.New("Frame", "dropdownLine1")
				:SetLayout("HORIZONTAL")
				:SetHeight(24)
				:SetMargin(0, 0, 0, 12)
				:AddChild(UIElements.New("SoundDropdown", "scanComplete")
					:SetMargin(0, 12, 0, 0)
					:SetSettingInfo(private.settings, "scanCompleteSound")
					:SetTooltip(SETTING_TOOLTIPS.scanCompleteSound)
				)
				:AddChild(UIElements.New("SoundDropdown", "confirmComplete")
					:SetSettingInfo(private.settings, "confirmCompleteSound")
					:SetTooltip(SETTING_TOOLTIPS.confirmCompleteSound)
				)
			)
			:AddChild(UIElements.New("Text", "saleLabel")
				:SetHeight(20)
				:SetMargin(0, 0, 0, 4)
				:SetFont("BODY_BODY2_MEDIUM")
				:SetText(L["Auction sale sound"])
			)
			:AddChild(UIElements.New("SoundDropdown", "saleSoundDropdown")
				:SetHeight(24)
				:SetSettingInfo(private.settings, "auctionSaleSound")
				:SetTooltip(SETTING_TOOLTIPS.auctionSaleSound)
			)
		)
		:AddChildrenWithFunction(private.AddWhitelistSettings)
end

function private.AddWhitelistSettings(frame)
	if not ClientInfo.IsVanillaClassic() then
		return
	end
	frame:AddChild(TSM.MainUI.Settings.CreateExpandableSection("Auctioning", "whitelist", L["Whitelist"], L["TSM will not undercut any players you add to your whitelist."])
		:AddChild(UIElements.New("Text", "matchLabel")
			:SetHeight(20)
			:SetMargin(0, 0, 0, 4)
			:SetFont("BODY_BODY2_MEDIUM")
			:SetText(L["Match whitelisted players"])
		)
		:AddChild(UIElements.New("ToggleYesNo", "matchToggle")
			:SetHeight(24)
			:SetMargin(0, 0, 0, 12)
			:SetSettingInfo(private.settings, "matchWhitelist")
		)
		:AddChild(UIElements.New("Text", "addLabel")
			:SetHeight(20)
			:SetMargin(0, 0, 0, 4)
			:SetFont("BODY_BODY2_MEDIUM")
			:SetText(L["Whitelisted characters"])
		)
		:AddChild(UIElements.New("Input", "newPlayerInput")
			:SetHeight(24)
			:SetMargin(0, 0, 0, 4)
			:SetBackgroundColor("ACTIVE_BG")
			:SetHintText(L["Enter player name"])
			:SetScript("OnEnterPressed", private.NewPlayerOnEnterPressed)
		)
		:AddChild(UIElements.New("Frame", "whitelistFrame")
			:SetLayout("FLOW")
			:SetHeight(60)
			:AddChildrenWithFunction(private.AddWhitelistRows)
		)
	)
end

function private.AddWhitelistRows(containerFrame)
	for player in pairs(private.settings.whitelist) do
		private.AddWhitelistRow(containerFrame, player)
	end
end

function private.AddWhitelistRow(frame, player)
	frame:AddChild(UIElements.New("Frame", "whitelist_"..player)
		:SetLayout("HORIZONTAL")
		:SetSize(100, 20)
		:SetMargin(0, 12, 0, 0)
		:AddChild(UIElements.New("Text", "text")
			:SetWidth("AUTO")
			:SetMargin(0, 2, 0, 0)
			:SetFont("BODY_BODY2_MEDIUM")
			:SetText(player)
		)
		:AddChild(UIElements.New("Button", "removeBtn")
			:SetBackgroundAndSize("iconPack.14x14/Close/Circle")
			:SetContext(player)
			:SetScript("OnClick", private.RemoveWhitelistOnClick)
		)
		:AddChild(UIElements.New("Spacer", "spacer"))
	)
end



-- ============================================================================
-- Local Script Handlers
-- ============================================================================

function private.NewPlayerOnEnterPressed(input)
	local newPlayer = strlower(input:GetValue())
	input:SetValue("")
	input:Draw()
	if newPlayer == "" or strfind(newPlayer, ",") or newPlayer ~= String.Escape(newPlayer) then
		ChatMessage.PrintfUser(L["Invalid player name."])
		return
	elseif private.settings.whitelist[newPlayer] then
		ChatMessage.PrintfUser(L["The player \"%s\" is already on your whitelist."], private.settings.whitelist[newPlayer])
		return
	end

	local isAlt = false
	for _, factionrealm in private.settingsDB:AccessibleRealmIterator("factionrealm", not private.settings.regionWide) do
		for _, character in private.settingsDB:AccessibleCharacterIterator(nil, factionrealm) do
			if strlower(newPlayer) == strlower(character) then
				ChatMessage.PrintfUser(L["You do not need to add \"%s\", alts are whitelisted automatically."], newPlayer)
				isAlt = true
			end
		end
	end

	if isAlt then
		return
	end

	private.settings.whitelist[newPlayer] = newPlayer

	-- add a new row to the UI
	local frame = input:GetElement("__parent.whitelistFrame")
	private.AddWhitelistRow(frame, newPlayer)
	frame:Draw()
end

function private.RemoveWhitelistOnClick(self)
	local player = self:GetContext()
	private.settings.whitelist[player] = nil

	-- remove this row
	local row = self:GetParentElement()
	local frame = row:GetParentElement()
	frame:RemoveChild(row)
	frame:Draw()
end
