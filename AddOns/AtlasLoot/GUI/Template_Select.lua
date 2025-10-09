--[[ usage
	data = {
		[1] = {
			id			= "1-Display Name",		-- unique id
			name		= "Display Name",
			color		= {r, g, b},			-- Text color
			tt_title	= "Tooltip Title",		-- OnEnter can changed with "SetToolTipFunc", arg list = ShowToolTip(...)
			tt_text		= "Tooltip Text",
			arg			= "arg",				-- OnClick(arg)
			icon		= "Interface\\Icons\\INV_Misc_QuestionMark",
		},
	}
]] --
local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

-- lua
local assert, type = assert, type
local wipe = table.wipe

--//\\
local SELECT_COUNT = 0

local BUTTON_HEIGHT = 20

local COIN_TEXTURE = ALPrivate.COIN_TEXTURE


-- functions
local function SetWidth(self, width)
	self.width = width
	self:Update()
end

local function SetNumEntrys(self, num)
	self.numEntrys = num or 1
	self:Update()
end

--- Select a entry
-- @param	id				the entry ID
-- @param	dataNum			the table index of the data table
-- @param	startSelect		true/false if this is the first call
local function SetSelected(self, id, dataNum, startSelect)
	local SelectionBehavior = self.frame.SelectionBehavior
	if not id and not dataNum then
		if self.selected then
			self.selected = nil
			SelectionBehavior:DeselectSelectedElements()
		end
		return
	end
	if not id then
		if self.data[dataNum] then
			self.selected = { dataNum, self.data[dataNum].id }
			if self.ButtonOnClick then
				self:ButtonOnClick(self.data[dataNum].id, self.data[dataNum].arg)
				SelectionBehavior:SelectElementDataByPredicate(function(elementData)
					return elementData.id == self.data[dataNum].id;
				end)
			end
		else
			self.selected = nil
			--return
		end
	else
		self.selected = id
	end
	if not dataNum then
		self.selected = nil
		for i = 1, #self.data do
			if self.data[i].id == id then
				self.selected = { i, id }
				if self.ButtonOnClick then
					self:ButtonOnClick(id, self.data[i].arg, startSelect)
					SelectionBehavior:SelectElementDataByPredicate(function(elementData)
						return elementData.id == id;
					end)
				end
				break
			end
		end
	end
end

local function SetNext(self)
	if self.selected and self.data[self.selected[1] + 1] then
		self:SetSelected(nil, self.selected[1] + 1)
	end
end

local function CheckIfNext(self)
	return (self.selected and self.data[self.selected[1] + 1]) and true or nil
end

local function SetPrev(self)
	if self.selected and self.data[self.selected[1] - 1] then
		self:SetSelected(nil, self.selected[1] - 1)
	end
end

local function CheckIfPrev(self)
	return (self.selected and self.data[self.selected[1] - 1]) and true or nil
end

local function SetData(self, data, startValue)
	local DataProvider = self.frame.ScrollBox:GetDataProvider();

	if not data then
		DataProvider:Flush()
		return
	end

	assert(type(data) == "table", "'data' must be a table. See 'GUI/Template_Select.lua' for infos.")
	self.data = data
	self.selected = startValue

	DataProvider:Flush()
	for index, value in ipairs(data) do
		DataProvider:Insert(value)
	end

	if startValue then
		self:SetSelected(startValue, nil, true)
	end

	self:Update()
end

local function SetButtonOnClick(self, func)
	if func and type(func) == "function" then
		self.ButtonOnClick = func
	else
		self.ButtonOnClick = nil
	end
end

local function Clear(self)
	wipe(self.data)
	self:Update()
end

local function Update(self)
	self.frame:SetWidth(self.width)
	self.height = (self.numEntrys * (self.buttonHeight + self.space)) + 5 - self.space
	self.frame:SetHeight(self.height)
end

function GUI.CreateSelect(self, height)
	SELECT_COUNT = SELECT_COUNT + 1
	local frameName = "AtlasLoot-Select-"..SELECT_COUNT
	local self = {}

	-- functions
	self.SetWidth = SetWidth
	self.SetParPoint = GUI.Temp_SetParPoint
	self.SetNumEntrys = SetNumEntrys
	-- set the selected entry (id, dataNum, startSelect)
	self.SetSelected = SetSelected
	-- goto next entry ()
	self.SetNext = SetNext
	self.CheckIfNext = CheckIfNext
	self.SetPrev = SetPrev
	self.CheckIfPrev = CheckIfPrev
	-- set the table data (data, startValue)
	self.SetData = SetData
	self.SetButtonOnClick = SetButtonOnClick
	self.Clear = Clear
	self.Update = Update

	-- data
	self.data = {}                 -- data SetData(dataTable)
	self.selected = nil            -- { <NumberInDataTable>, id }
	self.width = 250               -- frame width
	self.numEntrys = 4             -- number of buttons
	self.space = 2                 -- Space between buttons
	self.buttonHeight = BUTTON_HEIGHT -- button height

	self.frame = CreateFrame("ScrollFrame", frameName, nil, "InsetFrameTemplate")
	local frame = self.frame
	frame:ClearAllPoints()
	--frame.Bg:SetAtlas("Professions-background-summarylist")
	frame.obj = self

	local ScrollBox = CreateFrame("Frame", nil, frame, "WowScrollBoxList")
	ScrollBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -5)
	ScrollBox:SetSize(290, height)
	frame.ScrollBox = ScrollBox

	local ScrollBar = CreateFrame("EventFrame", nil, frame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT", 0, -2)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT", 0, -2)

	local ScrollView = CreateScrollBoxListLinearView()
	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)

	-- Set selection behavior
	local SelectionBehavior = ScrollUtil.AddSelectionBehavior(ScrollBox)
	local function OnSelectionChanged(_, elementData, selected)
		local button = ScrollBox:FindFrameByPredicate(function(frame)
			return frame.info.id == elementData.id;
		end)
		if button then
			if selected then
				button.obj:SetSelected(button.info.id)
				button.SelectedOverlay:SetShown(true);
				button.HighlightOverlay:SetShown(false);
				button.coin:SetDesaturated(false)
			else
				button.SelectedOverlay:SetShown(false);
				button.HighlightOverlay:SetShown(true);
				button.coin:SetDesaturated(true)
			end
		end
	end
	SelectionBehavior:RegisterCallback(SelectionBehaviorMixin.Event.OnSelectionChanged, OnSelectionChanged)
	frame.SelectionBehavior = SelectionBehavior

	-- Set button initializer
	local function Initializer(button, data)
		local selected = SelectionBehavior:IsElementDataSelected(data)
		if selected then
			-- Seems like this doesn't make a difference, but leaving it here for now in case it turns out that it does
			--button.obj:SetSelected(button.info.id)
			button.SelectedOverlay:SetShown(true);
			button.HighlightOverlay:SetShown(false);
		else
			button.SelectedOverlay:SetShown(false);
			button.HighlightOverlay:SetShown(true);
		end

		button:SetScript("OnClick", function()
			SelectionBehavior:Select(button)
		end)
		button:SetScript("OnEnter", function()
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			GameTooltip:AddLine(button.info.tt_title or "", 1.0, 1.0, 1.0)
			GameTooltip:AddLine(button.info.tt_text or "", nil, nil, nil, true)
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		button.Label:SetText(data.name)
		button.obj = self
		button.info = data

		button.coin:SetTexture()
		button.coin:SetDesaturated(true)
		if data.coinTexture == "Achievement" then
			button.coin:SetTexture(COIN_TEXTURE.AC)
			button.coin:SetTexCoord(0, 0.625, 0, 0.625)
		elseif data.coinTexture == "Reputation" or data.coinTexture == "Faction" then
			button.coin:SetTexCoord(0, 1, 0, 1)
			button.coin:SetTexture(COIN_TEXTURE.REPUTATION)
		end
	end
	ScrollView:SetElementInitializer("AtlasLootSelectButtonTemplate", Initializer)

	local DataProvider = CreateDataProvider()
	ScrollView:SetDataProvider(DataProvider)

	--[[ ScrollBar:SetHideIfUnscrollable(true)

	local anchorsWithScrollBar = {
		CreateAnchor("TOPLEFT", 10, -5),
		CreateAnchor("BOTTOMRIGHT", ScrollBar, 0, -5),
	};
	local anchorsWithoutScrollBar = {
		CreateAnchor("TOPLEFT", 10, -5),
		CreateAnchor("BOTTOMRIGHT", 0, -5),
	};
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(ScrollBox, ScrollBar, anchorsWithScrollBar, anchorsWithoutScrollBar); ]]

	self:Update()

	return self
end
