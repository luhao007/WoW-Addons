--[[ usage
	data = {
		[1] = {		-- category
			info = {
				name = "Display Title",
				bgColor = {r, g, b, alpha},		-- Background color
				textColor = {r, g, b},			-- Text color
			},
			[1] = {		-- entry number
				id			= "1-Display Name",		-- unique id
				name		= "Display Name",
				color		= {r, g, b},			-- Text color
				tt_title	= "Tooltip Title",		-- OnEnter can changed with "SetToolTipFunc", arg list = ShowToolTip(...)
				tt_text		= "Tooltip Text",
				arg			= "arg",				-- OnClick(arg)
				icon		= "Interface\\Icons\\INV_Misc_QuestionMark",
			},
		}
	}
]]
local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

-- lua
local assert, type = assert, type
local DROPDOWN_COUNT = 0

-- DropDown functions
local function SetData(self, data, startValue)
	if not data then
		self.data = nil
		self.selectedId = nil
		return
	end
	assert(type(data) == "table", "'data' must be a table. See 'GUI/Template_DropDown.lua' for infos.")
	self.data = data
	self.selectedId = startValue

	local function IsSelected(index) return index == self.selectedId; end
	local function SetSelection(index) self:SetSelected(index, true); end

	local function GeneratorFunction(dropdown, rootDescription)
		for _, category in ipairs(data) do
			local title = rootDescription:CreateTitle(category.info.name)
			title:AddInitializer(function(frame, description, menu)
				local fontString = frame.fontString;
				fontString:SetPoint("RIGHT");
				fontString:SetPoint("LEFT")
				fontString:SetFontObject("GameFontNormal");
				fontString:SetJustifyH("CENTER");
			end);

			for _, option in ipairs(category) do
				local radio = rootDescription:CreateRadio(option.name, IsSelected, SetSelection, option.id);
				radio:SetTooltip(function(tooltip, elementDescription)
					GameTooltip_SetTitle(tooltip, option.tt_title);
					GameTooltip_AddNormalLine(tooltip, option.tt_text);
				end);
			end
		end
	end
	self.frame:SetupMenu(GeneratorFunction);

	if startValue then
		self:SetSelected(startValue)
	end
end

-- DropDown Set functions
local function SetWidth(self, width)
	self.width = width
	self.frame:SetWidth(width)
end

local function SetTitle(self, text)
	if text and type(text) == "string" then
		self.frame.title:SetText(text)
	else
		self.frame.title:SetText("")
	end
end

local function SetButtonOnClick(self, func)
	if func and type(func) == "function" then
		self.ButtonOnClick = func
	else
		self.ButtonOnClick = nil
	end
end

-- must be a unique id
local function SetSelected(self, id, userClick)
	if not id then return end
	local arg
	for i = 1, #self.data do
		local cat = self.data[i]
		for j = 1, #cat do
			local entry = cat[j]
			if id == entry.id then
				if entry.arg then
					arg = entry.arg
				end
				break
			end
		end
	end

	if self.ButtonOnClick then
		self:ButtonOnClick(id, arg, userClick)
	end
	self.selectedId = id
end

function GUI.CreateDropDown()
	DROPDOWN_COUNT = DROPDOWN_COUNT + 1
	local frameName = "AtlasLoot-DropDown-"..DROPDOWN_COUNT
	local self = {}

	-- Set functions
	self.SetData = SetData
	self.SetParPoint = GUI.Temp_SetParPoint
	self.SetWidth = SetWidth
	self.SetButtonOnClick = SetButtonOnClick
	self.SetSelected = SetSelected
	self.SetTitle = SetTitle

	self.frame = CreateFrame("DropdownButton", frameName, nil, "WowStyle1DropdownTemplate");
	local frame = self.frame

	frame.title = frame:CreateFontString(frameName.."-title", "ARTWORK", "GameFontNormalSmall")
	frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, 10)
	frame.title:SetText(frameName.."-title")

	-- data
	self.data = {}
	self.ButtonOnClick = nil
	self.selectedId = nil
	self.width = nil

	self:SetWidth(200)

	return self
end
