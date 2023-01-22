-- **************************************************************************
-- * TitanBag.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************

-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_BAG_ID = "Bag";
local TITAN_BUTTON = "TitanPanel"..TITAN_BAG_ID.."Button"

local TITAN_BAG_THRESHOLD_TABLE = {
	Values = { 0.5, 0.75, 0.9 },
	Colors = { HIGHLIGHT_FONT_COLOR, NORMAL_FONT_COLOR, ORANGE_FONT_COLOR, RED_FONT_COLOR },
}
local updateTable = {TITAN_BAG_ID, TITAN_PANEL_UPDATE_BUTTON};
-- ******************************** Variables *******************************
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local BagTimer

local bag_info = {
	ENCHANTING = { color = {r=0,g=0,b=1}}, -- BLUE
	ENGINEERING = { color = {r=1,g=0.49,b=0.04}}, -- ORANGE
	HERBALISM = { color = {r=0,g=1,b=0}}, -- GREEN
	INSCRIPTION = { color = {r=0.58,g=0.51,b=0.79}}, -- PURPLE
	JEWELCRAFTING = { color = {r=1,g=0,b=0}}, -- RED
	LEATHERWORKING = { color = {r=0.78,g=0.61,b=0.43}}, -- TAN
	MINING = { color = {r=1,g=1,b=1}}, -- WHITE
	FISHING = { color = {r=0.41,g=0.8,b=0.94}}, -- LIGHT_BLUE
	COOKING = { color = {r=0.96,g=0.55,b=0.73}}, -- PINK
}
-- "Khorium Toolbox" removed???
 -- names are for debug only
 -- Can use wowdb.com to look at bags by profession

local prof_bags = {
	[333]    = {style = "", name = ""},
	[21858]  = {style = "ENCHANTING", name = "Spellfire Bag"},
	[22246]  = {style = "ENCHANTING", name = "Enchanted Mageweave Pouch"},
	[22248]  = {style = "ENCHANTING", name = "Enchanted Runecloth Bag"},
	[22249]  = {style = "ENCHANTING", name = "Big Bag of Enchantment"},
	[22250]  = {style = "HERBALISM", name = "Herb Pouch"},
	[22251]  = {style = "HERBALISM", name = "Cenarion Herb Bag"},
	[22252]  = {style = "HERBALISM", name = "Satchel of Cenarius"},
	[23774]  = {style = "ENGINEERING", name = "Fel Iron Toolbox"},
	[23775]  = {style = "ENGINEERING", name = "Titanium Toolbox"},
	[24270]  = {style = "JEWELCRAFTING", name = "Bag of Jewels"},
	[29540]  = {style = "MINING", name = "Reinforced Mining Bag"},
	[30745]  = {style = "ENGINEERING", name = "Heavy Toolbox"}, -- *
	[30746]  = {style = "MINING", name = "Mining Sack"},
	[30747]  = {style = "JEWELCRAFTING", name = "Gem Pouch"},
	[30748]  = {style = "ENCHANTING", name = "Enchanter's Satchel"},
	[34482]  = {style = "LEATHERWORKING", name = "Leatherworker's Satchel"},
	[34490]  = {style = "LEATHERWORKING", name = "Bag of Many Hides"},
	[38225]  = {style = "HERBALISM", name = "Mycah's Botanical Bag"},
	[38307]  = {style = "INSCRIPTION", name = "Crafty's Bottomless Inscription Bag"}, -- *
	[38347]  = {style = "MINING", name = "Mammoth Mining Bag"},
	[38399]  = {style = "LEATHERWORKING", name = "Trapper's Traveling Pack"},
	[39489]  = {style = "INSCRIPTION", name = "Scribe's Satchel"},
	[41598]  = {style = "ENCHANTING", name = "Mysterious Bag"},
	[44446]  = {style = "INSCRIPTION", name = "Pack of Endless Pockets"},
	[45773]  = {style = "HERBALISM", name = "Emerald Bag"},
	[54445]  = {style = "ENCHANTING", name = "Otherworldly Bag"},
	[54446]  = {style = "HERBALISM", name = "Hyjal Expedition Bag"},
	[60217]  = {style = "ENGINEERING", name = "Elementium Toolbox"},
	[60218]  = {style = "FISHING", name = "Lure Master Tackle Box"},
	[67389]  = {style = "ENCHANTING", name = "\"Carriage - Exclusive\" Enchanting Evening Purse"},
	[67390]  = {style = "ENGINEERING", name = "\"Carriage - Maddy\" High Tech Bag"},
	[67392]  = {style = "JEWELCRAFTING", name = "\"Carriage - Exclusive\" Gem Studded Clutch"},
	[67393]  = {style = "HERBALISM", name = "\"Carriage - Going Green\" Herb Tote Bag"},
	[67394]  = {style = "INSCRIPTION", name = "\"Carriage - Xandera\" Student's Satchel"},
	[67395]  = {style = "LEATHERWORKING", name = "\"Carriage - Meeya\" Leather Bag"},
	[67396]  = {style = "MINING", name = "\"Carriage - Christina\" Precious Metal Bag"},
	[70136]  = {style = "INSCRIPTION", name = "Royal Scribe's Satchel"}, -- *
	[70137]  = {style = "MINING", name = "Triple-Reinforced Mining Bag"},-- *
	[92746]  = {style = "COOKING", name = "Portable Refrigerator [28]"}, -- repeat, which one is real?
	[92747]  = {style = "COOKING", name = "Advanced Refrigeration Unit"},
	[92748]  = {style = "COOKING", name = "Portable Refrigerator [32]"},
	[70138]  = {style = "JEWELCRAFTING", name = "Luxurious Silk Gem Bag"}, -- *
	[95536]  = {style = "LEATHERWORKING", name = "Magnificent Hide Pack"}, -- *
	[116259] = {style = "LEATHERWORKING", name = "Burnished Leather Bag"},
	[116260] = {style = "MINING", name = "Burnished Mining Bag"},
	[116261] = {style = "MINING", name = "Burnished Inscription Bag"},
	[116404] = {style = "ENGINEERING", name = "Pilgrim's Bounty"}, -- *
	[130943] = {style = "COOKING", name = "Reusable Tote Bag"}, -- *
	[162588] = {style = "INSCRIPTION", name = "Weathered Scrollcase"},
}

local MIN_BAGS = 0
local MAX_BAGS = Constants.InventoryConstants.NumBagSlots
local bag_data = {} -- to hold the user bag data

-- ******************************** Functions *******************************
local function ToggleBags()

	if TitanGetVar(TITAN_BAG_ID, "OpenBags") then
		ToggleAllBags()
	else
	end

end

local function GetBagData(id)
	--[[
	The old code grabbed the bag name but since 10.00.02 it seems name is not always available by player entering world event
	Grabbing the total slots is available though to determine if a bag exists. 
	The user may see bag name as <unknown> until an event triggers a bag check AND the name is available.
	--]]
	
	local total_slots = 0
	local total_free = 0
	local total_used = 0

	for bag_slot = MIN_BAGS, MAX_BAGS do -- assuming 0 (Backpack) will not be a profession bag
		local slots = C_Container.GetContainerNumSlots(bag_slot) 

		-- Ensure a blank structure exists
--		if bag_data[bag_slot] then
			-- This has been processed at least once
--		else
			bag_data[bag_slot] = {
				has_bag = false,
				name = "",
				maxi_slots = 0,
				free_slots = 0,
				used_slots = 0,
				style = "",
				color = "",
				}
--		end

		if slots > 0 then
			bag_data[bag_slot].has_bag = true
			
			local bag_name = (C_Container.GetBagName(bag_slot) or UNKNOWN)
			bag_data[bag_slot].name = bag_name
			bag_data[bag_slot].maxi_slots = slots
			
			local free = C_Container.GetContainerNumFreeSlots(bag_slot)
			local used = slots - free
			bag_data[bag_slot].free_slots = free
			bag_data[bag_slot].used_slots = used
			
			-- some info is not known until the name is available...
			-- The API requires name to get the bag ID.
			local bag_type = "none"
			local color = {r=0,g=0,b=0} -- black (should never be used...)

			if bag_name == UNKNOWN then
				-- name not available yet
			else
				local itemID, itemType, itemSubType, itemEquipLoc, icon, itemClassID, itemSubClassID = GetItemInfoInstant(bag_name)
				-- For some inexplicable reason the Backpack does not return as an item...
				-- so create a default so routine is successful
				itemID = itemID or 0

				if prof_bags[itemID] then
					bag_type = prof_bags[itemID].style
					color = bag_info[bag_type].color
					bag_type = "profession"
				else
					bag_type = "normal"
				end
			end
			bag_data[bag_slot].style = bag_type
			bag_data[bag_slot].color = color
			
			-- add to total
			if bag_data[bag_slot].style == "profession" then
				if TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots") then
					total_slots = total_slots + slots
					total_free = total_free + free
					total_used = total_used + used
				else
					-- ignore in totals
--[[
TitanDebug("T Bag: ignore"
.." "..tostring(bag_slot)..""
.." "..tostring(bag_data[bag_slot].name)..""
.." "..tostring(bag_data[bag_slot].style)..""
)
--]]
				end
			else
				total_slots = total_slots + slots
				total_free = total_free + free
				total_used = total_used + used
			end
		else
			bag_data[bag_slot].has_bag = false
		end
--[[
TitanDebug("T Bag: info"
.." "..tostring(bag_slot)..""
.." "..tostring(bag_data[bag_slot].has_bag)..""
.." "..tostring(bag_data[bag_slot].name)..""
.." "..tostring(bag_data[bag_slot].maxi_slots)..""
.." "..tostring(bag_data[bag_slot].used_slots)..""
.." "..tostring(bag_data[bag_slot].free_slots)..""
.." "..tostring(bag_data[bag_slot].style)..""
)
--]]
	end

	bag_data.total_slots = total_slots
	bag_data.total_free = total_free
	bag_data.total_used = total_used

	local bagText = ""
	if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
		bagText = format(L["TITAN_BAG_FORMAT"], total_used, total_slots);
	else
		bagText = format(L["TITAN_BAG_FORMAT"], total_free, total_slots);
	end

	local bagRichText = ""
	if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
		local color = ""
		color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, total_used / total_slots);
		bagRichText = TitanUtils_GetColoredText(bagText, color);
	else
		bagRichText = TitanUtils_GetHighlightText(bagText);
	end

	bagRichText = bagRichText --..bagRichTextProf[1]..bagRichTextProf[2]..bagRichTextProf[3]..bagRichTextProf[4]..bagRichTextProf[5];

	return L["TITAN_BAG_BUTTON_LABEL"], bagRichText
end

--[[ plugin
-- **************************************************************************
-- NAME : TitanPanelBagButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
--]]
function TitanPanelBagButton_OnLoad(self)
	self.registry = {
		id = TITAN_BAG_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_BAG_MENU_TEXT"],
		buttonTextFunction = "TitanPanelBagButton_GetButtonText",
		tooltipTitle = L["TITAN_BAG_TOOLTIP"],
		tooltipTextFunction = "TitanPanelBagButton_GetTooltipText",
		icon = "Interface\\AddOns\\TitanBag\\TitanBag",
		iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			ShowUsedSlots = 1,
			ShowDetailedInfo = false,
			CountProfBagSlots = false,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			DisplayOnRightSide = false,
			OpenBags = false,
		}
	};

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	
end

--[[ plugin
-- **************************************************************************
-- NAME : TitanPanelBagButton_OnEvent()
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
--]]
function TitanPanelBagButton_OnEvent(self, event, a1, a2, ...)
	if event == "PLAYER_ENTERING_WORLD" then

		-- Register for bag updates and update the plugin text
		self:RegisterEvent("BAG_UPDATE")
		TitanPanelButton_UpdateButton(TITAN_BAG_ID);

		if a1 == true then 
			-- initial login

			TitanPrint(""
			.." "..tostring("Feature :")..""
			.." "..tostring(OPENING or "Opening of")..""
			.." "..tostring(INVTYPE_BAG or "Bags")..""
			.." "..tostring(ADDON_DISABLED or "Disabled")..""
			.." "..tostring("Until taint is fixed or work around found.")..""
			, "warning")
		else
		end
	end

	if event == "BAG_UPDATE" then
		-- Create only when the event is active
		self:SetScript("OnUpdate", TitanPanelBagButton_OnUpdate)
	end
end

function TitanPanelBagButton_OnUpdate(self)
	-- update the button
	TitanPanelPluginHandle_OnUpdate(updateTable)
	-- remove until the next bag event
	self:SetScript("OnUpdate", nil)
end

--[[ plugin
-- **************************************************************************
-- NAME : TitanPanelBagButton_OnClick(button)
-- DESC : Opens all bags on a LeftClick
-- VARS : button = value of action
-- **************************************************************************
--]]
function TitanPanelBagButton_OnClick(self, button)
	if (button == "LeftButton") then
		ToggleBags();
	end
end

-- plugin
function TitanPanelBagButton_GetButtonText(id)
	local strA, strB = GetBagData(id)
	return strA, strB
end

--[[ plugin
-- **************************************************************************
-- NAME : TitanPanelBagButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
--]]
function TitanPanelBagButton_GetTooltipText()
	local totalSlots, usedSlots, availableSlots;
	local returnstring = "";

	if TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo") then
		returnstring = "\n";
		if TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots") then
			returnstring = returnstring..TitanUtils_GetNormalText(L["TITAN_BAG_MENU_TEXT"])
				..":\t"..TitanUtils_GetNormalText(L["TITAN_BAG_USED_SLOTS"])..":\n";
		else
			returnstring = returnstring..TitanUtils_GetNormalText(L["TITAN_BAG_MENU_TEXT"])
				..":\t"..TitanUtils_GetNormalText(L["TITAN_BAG_FREE_SLOTS"])..":\n";
		end

		for bag = MIN_BAGS, MAX_BAGS do
			local bagText, bagRichText, color;
--[[
TitanDebug("T Bag: TT"
.." "..tostring(bag)..""
.." "..tostring(bag_data[bag].has_bag)..""
.." "..tostring(bag_data[bag].name)..""
.." "..tostring(bag_data[bag].maxi_slots)..""
.." "..tostring(bag_data[bag].used_slots)..""
.." "..tostring(bag_data[bag].free_slots)..""
)
--]]
			if bag_data[bag] and bag_data[bag].has_bag then
				if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
					bagText = format(L["TITAN_BAG_FORMAT"], bag_data[bag].used_slots, bag_data[bag].maxi_slots);
				else
					bagText = format(L["TITAN_BAG_FORMAT"], bag_data[bag].free_slots, bag_data[bag].maxi_slots);
				end

				if bag_data[bag].style == "profession" 
				and not TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots")
				then
					bagRichText = "|cffa0a0a0"..bagText.."|r" -- show as gray
				elseif ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
					if bag_data[bag].maxi_slots == 0 then
						color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, 1 );
					else
						color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, bag_data[bag].used_slots / bag_data[bag].maxi_slots);
					end
					bagRichText = TitanUtils_GetColoredText(bagText, color);
				else
					-- use without color
					bagRichText = TitanUtils_GetHighlightText(bagText);
				end

				local name_text = bag_data[bag].name
				if bag_data[bag].style == "profession" 
				then
					name_text = TitanUtils_GetColoredText(name_text, bag_data[bag].color)
				else
					-- use without color
				end
				returnstring = returnstring..name_text.."\t"..bagRichText.."\n";
			else
				returnstring = returnstring..NONE.."\n";
			end
		end
		returnstring = returnstring.."\n";
	end

	if TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots") then
		local xofy = ""..tostring(bag_data.total_used)
			.."/"..tostring(bag_data.total_slots).."\n"
		returnstring = returnstring..TitanUtils_GetNormalText(L["TITAN_BAG_USED_SLOTS"])
			..":\t"..xofy
	else
		local xofy = ""..tostring(bag_data.total_free)
			.."/"..tostring(bag_data.total_slots).."\n"
		returnstring = returnstring..TitanUtils_GetNormalText(L["TITAN_BAG_USED_SLOTS"])
			..":\t"..xofy
	end
	
	-- Add Hint
	if TitanGetVar(TITAN_BAG_ID, "OpenBags") then
		returnstring = returnstring..TitanUtils_GetGreenText(L["TITAN_BAG_TOOLTIP_HINTS"])
	else
		-- nop
	end
	return returnstring
end

--[[ plugin
-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareBagMenu()
-- DESC : Display rightclick menu options
-- NOTE : Titan builds this name to call on right click
-- **************************************************************************
--]]
function TitanPanelRightClickMenu_PrepareBagMenu()
	local info
	-- level 2
	if TitanPanelRightClickMenu_GetDropdownLevel() == 2 then
		if TitanPanelRightClickMenu_GetDropdMenuValue() == "Options" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_OPTIONS"], TitanPanelRightClickMenu_GetDropdownLevel())
			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_USED_SLOTS"];
			info.func = TitanPanelBagButton_ShowUsedSlots;
			info.checked = TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS"];
			info.func = TitanPanelBagButton_ShowAvailableSlots;
			info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots"));
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_DETAILED"];
			info.func = TitanPanelBagButton_ShowDetailedInfo;
			info.checked = TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = (LEFT_BUTTON_STRING or "Left Click")
				.." "..(OPENING or "to Open")
				.." "..(INVTYPE_BAG or "Bags")
			info.func = function()
				TitanToggleVar(TITAN_BAG_ID, "OpenBags")
				end
			info.checked = TitanGetVar(TITAN_BAG_ID, "OpenBags");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end
		return
	end

	-- level 1
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BAG_ID].menuText);

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_PANEL_OPTIONS"];
	info.value = "Options"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = L["TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS"];
	info.func = TitanPanelBagButton_ToggleIgnoreProfBagSlots;
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots"));
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddControlVars(TITAN_BAG_ID)
end

--[[
-- **************************************************************************
-- NAME : TitanPanelBagButton_ShowUsedSlots()
-- DESC : Set option to show used slots
-- **************************************************************************
--]]
function TitanPanelBagButton_ShowUsedSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", 1);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

--[[
-- **************************************************************************
-- NAME : TitanPanelBagButton_ShowAvailableSlots()
-- DESC : Set option to show available slots
-- **************************************************************************
--]]
function TitanPanelBagButton_ShowAvailableSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", nil);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

--[[
-- **************************************************************************
-- NAME : TitanPanelBagButton_ToggleIgnoreProfBagSlots()
-- DESC : Set option to count profession bag slots
-- **************************************************************************
--]]
function TitanPanelBagButton_ToggleIgnoreProfBagSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountProfBagSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanPanelBagButton_ShowDetailedInfo()
	TitanToggleVar(TITAN_BAG_ID, "ShowDetailedInfo");
end

-- ====== Create needed frames
local function Create_Frames()
	if _G[TITAN_BUTTON] then
		return -- if already created
	end
	
	-- general container frame
	local f = CreateFrame("Frame", nil, UIParent)
--	f:Hide()

	-- Titan plugin button
	local window = CreateFrame("Button", TITAN_BUTTON, f, "TitanPanelComboTemplate")
	window:SetFrameStrata("FULLSCREEN")
	-- Using SetScript("OnLoad",   does not work
	TitanPanelBagButton_OnLoad(window);
--	TitanPanelButton_OnLoad(window); -- Titan XML template calls this...
	
	window:SetScript("OnEvent", function(self, event, ...)
		TitanPanelBagButton_OnEvent(self, event, ...) 
	end)
	window:SetScript("OnClick", function(self, button)
		TitanPanelBagButton_OnClick(self, button);
		TitanPanelButton_OnClick(self, button);
	end)
end


Create_Frames() -- do the work
