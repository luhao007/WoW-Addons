------------------------------------------------------------
-- ToolBar.lua
--
-- Abin
-- 2011-8-23
------------------------------------------------------------

local ipairs = ipairs
local tonumber = tonumber
local GetScreenHeight = GetScreenHeight
local HIGHLIGHT_FONT_COLOR = HIGHLIGHT_FONT_COLOR
local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
local GameTooltip = GameTooltip

local _, addon = ...
local L = addon.L
local BUTTON_WIDTH = 22

local actionButtons = {}

local frame = CreateFrame("Frame", "GearManagerExToolBarFrame", UIParent, "SecureFrameTemplate")
addon.toolbar = frame
frame:SetMovable(true)
frame:SetUserPlaced(true)
frame:SetClampedToScreen(true)
frame:SetSize(BUTTON_WIDTH, BUTTON_WIDTH)
frame:SetPoint("CENTER")

local function Button_OnDragStart(self)
	if not addon.chardb.lockToolbar then
		frame:StartMoving()
	end
end

local function Button_OnDragStop(self)
	frame:StopMovingOrSizing()
end

local function Button_OnEnter(self)
	local left = self:GetLeft()
	local top = self:GetTop()
	if not left or not top then
		return
	end

	local anchor
	local leftOK = left > 250
	local topOK = (GetScreenHeight() - top) > 250

	if leftOK then
		if topOK then
			anchor = "ANCHOR_LEFT"
		else
			anchor = "ANCHOR_BOTTOMLEFT"
		end
	else
		if topOK then
			anchor = "ANCHOR_RIGHT"
		else
			anchor = "ANCHOR_BOTTOMRIGHT"
		end
	end

	GameTooltip:SetOwner(self, anchor)
	GameTooltip:ClearLines()
	self:OnTooltip(GameTooltip)
	GameTooltip:Show()
end

local function Button_OnLeave(self)
	GameTooltip:Hide()
end

local function Button_OnClick(self, arg1)
	GameTooltip:Hide()
	if arg1 == "LeftButton" then
		self:OnLeftClick()
	else
		self:OnRightClick()
	end
end

local function ModifyButton(button)
	button:SetParent(frame)
	button:SetSize(BUTTON_WIDTH, BUTTON_WIDTH)
	button:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", insets = { top = 2, left = 2, bottom = 2, right = 2 } })

	local border = button:CreateTexture(button:GetName().."NormalTexture", "BORDER")
	border:SetPoint("TOPLEFT", -8, 8)
	border:SetPoint("BOTTOMRIGHT", 9, -9)
	border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	local icon = button:CreateTexture(button:GetName().."Icon", "ARTWORK")
	button.icon = icon
	icon:SetPoint("TOPLEFT", 1, -1)
	icon:SetPoint("BOTTOMRIGHT", -1, 1)

	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetAttribute("type", nil)
	button:SetAttribute("type1", "macro")

	button:RegisterForDrag("LeftButton")
	button:SetScript("OnDragStart", Button_OnDragStart)
	button:SetScript("OnDragStop", Button_OnDragStop)
	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", Button_OnLeave)

	tinsert(actionButtons, button)
end

local function SetButton_OnTooltip(self, tooltip)
	if self.name then
		tooltip:SetEquipmentSet(self.name)
		tooltip:AddLine(L["tooltip prompt"], 0, 1, 0, 1)
	end
end

local function SetButton_PostClick(self, arg1)
	if arg1 == "RightButton" then
		addon:SetMenuSet(self.name)
		addon:ToggleMenu(UIParent, "TOPLEFT", self, "BOTTOMLEFT", 0, 0)
	end
end

local function SetButton_UpdateSet(self)
	if self.name then
		local _, icon = addon:GetEquipmentSetInfo(self.name)
		self.icon:SetTexture(icon)
		self:Show()
	else
		self:Hide()
	end
end

local function SetButton_UpdateChecked(self)
	if addon:IsSetEquipped(self.name) then
		self.checked:Show()
		self.number:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		self:LockHighlight()
	else
		self.checked:Hide()
		self.number:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		self:UnlockHighlight()
	end
end

local function SetButton_UpdateNumeric(self)
	if addon.db.numericToolbar then
		self.icon:Hide()
		self.number:Show()
	else
		self.icon:Show()
		self.number:Hide()
	end
end

local function ModifySetButton(button, index)
	ModifyButton(button)
	button:Hide()

	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetPoint("TOPLEFT", 2, -2)
	button.icon:SetPoint("BOTTOMRIGHT", -2, 2)

	button.checked = button:CreateTexture(button:GetName().."Checked", "OVERLAY")
	button.checked:SetTexture("Interface\\Buttons\\CheckButtonHilight")
	button.checked:SetBlendMode("ADD")
	button.checked:SetAllPoints(button)
	button.checked:Hide()

	button.number = button:CreateFontString(button:GetName().."Number", "ARTWORK", "TextStatusBarText")
	button.number:SetPoint("CENTER")
	button.number:SetFormattedText("%d", index)

	button.OnTooltip = SetButton_OnTooltip
	button:SetScript("PostClick", SetButton_PostClick)

	button.UpdateSet = SetButton_UpdateSet
	button.UpdateChecked = SetButton_UpdateChecked
	button.UpdateNumeric = SetButton_UpdateNumeric
end

local mainButton = addon.quickStripButton
ModifyButton(mainButton)

mainButton:SetPoint("TOPLEFT")
mainButton.icon:SetTexture("Interface\\PaperDollInfoFrame\\PaperDollSidebarTabs")
mainButton.icon:SetTexCoord(0.015625, 0.53125, 0.46875, 0.60546875)

local func = mainButton:GetScript("PostClick")
mainButton:SetScript("PostClick", function(self, arg1)
	if arg1 == "LeftButton" then
		func(self, arg1)
	else
		addon.optionFrame:Open()
	end
end)

function mainButton:OnTooltip(tooltip)
	tooltip:AddLine(addon.title, 1, 1, 1)
	tooltip:AddLine(KEY_BUTTON1..": "..L["quick strip"])
	tooltip:AddLine(KEY_BUTTON2..": "..OPTIONS_MENU)
end

do
	local i
	for i = 1, addon:NumSetButtons() do
		local button = addon:GetSetButton(i)
		ModifySetButton(button, i)
	end
end

local function CallAllSetButtons(method, ...)
	local i
	for i = 1, addon:NumSetButtons() do
		local button = addon:GetSetButton(i)
		local func = button[method]
		if type(func) == "function" then
			func(button, ...)
		end
	end
end

local function ReAllignToolbar()
	local columns = addon.db.toolbarColumns
	local spacing = addon.db.toolbarSpacing

	local i
	for i = 2, #actionButtons do
		local button = actionButtons[i]
		button:ClearAllPoints()
		if (i - 1) % columns == 0 then
			button:SetPoint("TOP", actionButtons[i - columns], "BOTTOM", 0, -spacing)
		else
			button:SetPoint("LEFT", actionButtons[i - 1], "RIGHT", spacing, 0)
		end
	end
end

addon:RegisterOptionCallback("toolbarSpacing", ReAllignToolbar)
addon:RegisterOptionCallback("toolbarColumns", ReAllignToolbar)

addon:RegisterOptionCallback("showToolbar", function(value)
	if value then
		frame:Show()
	else
		frame:Hide()
	end
end)

addon:RegisterOptionCallback("toolbarScale", function(value)
	frame:SetScale(value / 100)
end)

addon:RegisterEventCallback("ResetToolbarPosition", function()
	frame:ClearAllPoints()
	frame:SetPoint("CENTER")
end)

addon:RegisterOptionCallback("numericToolbar", function(value)
	CallAllSetButtons("UpdateNumeric")
end)

addon:RegisterEventCallback("OnSetsChanged", function()
	CallAllSetButtons("UpdateSet")
end)

addon:RegisterEventCallback("OnEquipsChanged", function()
	CallAllSetButtons("UpdateChecked")
end)