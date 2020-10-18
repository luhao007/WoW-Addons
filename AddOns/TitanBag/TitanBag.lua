-- **************************************************************************
-- * TitanBag.lua
-- *
-- * By: TitanMod, Dark Imakuni, Adsertor and the Titan Panel Development Team
-- **************************************************************************

-- ******************************** Constants *******************************
local _G = getfenv(0);
local TITAN_BAG_ID = "Bag";
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
local bags = {
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
	[92746]  = {style = "COOKING", name = "Portable Refrigerator"}, -- repeat, which one is real?
	[92747]  = {style = "COOKING", name = "Advanced Refrigeration Unit"},
	[92748]  = {style = "COOKING", name = "Portable Refrigerator"}, -- repeat, which one is real?
	[70138]  = {style = "JEWELCRAFTING", name = "Luxurious Silk Gem Bag"}, -- *
	[95536]  = {style = "LEATHERWORKING", name = "Magnificent Hide Pack"}, -- *
	[116259] = {style = "LEATHERWORKING", name = "Burnished Leather Bag"},
	[116260] = {style = "MINING", name = "Burnished Mining Bag"},
	[116261] = {style = "MINING", name = "Burnished Inscription Bag"},
	[116404] = {style = "ENGINEERING", name = "Pilgrim's Bounty"}, -- *
	[130943] = {style = "COOKING", name = "Reusable Tote Bag"}, -- *
	[162588] = {style = "INSCRIPTION", name = "Weathered Scrollcase"},
--[[
print("--")
print(ZZbags[21858].style)
--]]
}
ZZbags = bags

-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelBagButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
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
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = false
		},
		savedVariables = {
			ShowUsedSlots = 1,
			ShowDetailedInfo = false,
			CountProfBagSlots = false,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
		}
	};

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_OnEvent()
-- DESC : Parse events registered to plugin and act on them
-- **************************************************************************
function TitanPanelBagButton_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") and (not self:IsEventRegistered("BAG_UPDATE")) then
		self:RegisterEvent("BAG_UPDATE");
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

-- **************************************************************************
-- NAME : TitanPanelBagButton_OnClick(button)
-- DESC : Opens all bags on a LeftClick
-- VARS : button = value of action
-- **************************************************************************
function TitanPanelBagButton_OnClick(self, button)
	if (button == "LeftButton") then
		ToggleAllBags();
	end
end

-- **************************************************************************
-- NAME : isProfBag(id)
-- DESC : Determine if this is a profession bag by getting its id and checking 
-- against the table of known ids.
-- If it is a profession bag then grab its 'color' in case the user requested it.
-- VARS : name = text (localized) of the bag to check
-- **************************************************************************
--[==[
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, 
		itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, 
		bindType, expacID, itemSetID, isCraftingReagent = 
		GetItemInfo(bag_name)
	local bag_type = false
	local color = {r=0,g=0,b=0} -- black (should never be used...)
	
	if itemName == nil or itemName == false then
		-- For some inexplicable reason the Backpack does not return as an item...
		--TitanDebug("Bag name not found: '"..tostring(name).."'")
	else
		local _, _, icolor, ltype, id, enchant, gem1, gem2, gem3, gem4,
			suffix, unique, linkLvl, specID,
			upgradeID, instance_diff_id, num_bonus_ids, bonus1, bonus2, name = string.find(itemLink,
		  "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*):?(%d*):?(%d*):?(%d*):?(%d*):|h%[(.-)%]|h?|?r?")

		local string_id = tonumber(id)
		if bags[string_id] then
			bag_type = bags[string_id].style
			color = bag_info[bag_type].color
		else
			-- not a profession bag
		end
--[[
TitanDebug("Bag id: "..tostring(string_id).." '"..tostring(bag_type).."'"
.." ["..tostring(icolor).."]:"
.." '"..tostring(string.format("%1.2f",color.r)).."' '"..tostring(string.format("%1.2f",color.g)).."' '"..tostring(string.format("%1.2f",color.b)).."'")
--]]
	end
--]==]
local function isProfBag(bag_name)
	-- using straight GetItemInfo caused a 'script ran too long' error on Shadowlands ptr although it worked in retail
	-- GetItemInfoInstant returns the needed id and uses client files - no server call.
	local itemID, itemType, itemSubType, itemEquipLoc, icon, itemClassID, itemSubClassID = GetItemInfoInstant(bag_name) 
	local bag_type = false
	local color = {r=0,g=0,b=0} -- black (should never be used...)
	
	if itemID == nil or itemId == false then
		-- For some inexplicable reason the Backpack does not return as an item...
		--TitanDebug("Bag name not found: '"..tostring(name).."'")
	else
		if bags[itemID] then
			bag_type = bags[itemID].style
			color = bag_info[bag_type].color
		else
			-- not a profession bag
		end
	end
	
--[[
TitanDebug("isProfBag: "..tostring(itemID).." '"..tostring(bag_type)
.." '"..tostring(string.format("%1.2f",color.r)).."' '"..tostring(string.format("%1.2f",color.g)).."' '"..tostring(string.format("%1.2f",color.b)).."'")
--]]
	return bag_type, color
end

local function TextTest(id)
	local button, id = TitanUtils_GetButton(id, true);
	local totalBagSlots, usedBagSlots, availableBagSlots, bag, bagText, bagRichText, bagType, color;
	local totalProfBagSlots = {0,0,0,0,0};
	local usedProfBagSlots = {0,0,0,0,0};
	local availableProfBagSlots = {0,0,0,0,0};
	local bagRichTextProf = {"","","","",""};

	totalBagSlots = 0;
	usedBagSlots = 0;
	for bag = 0, 4 do -- assuming 0 (Backpack) will not be a profession bag
		local bagType, color = isProfBag(GetBagName(bag))

		if bagType then -- found a profession bag
			-- when user wants profession bags counted, they are listed separately in the plugin
			if TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots") then
				local size = GetContainerNumSlots(bag);
				if (size and size > 0) then
					totalProfBagSlots[bag] = size;
					for slot = 1, size do
						if (GetContainerItemInfo(bag, slot)) then
							usedProfBagSlots[bag] = usedProfBagSlots[bag] + 1;
						end
					end
					availableProfBagSlots[bag] = totalProfBagSlots[bag] - usedProfBagSlots[bag];
				end

				if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
					bagText = "  [" .. format(L["TITAN_BAG_FORMAT"], usedProfBagSlots[bag], totalProfBagSlots[bag]) .. "]";
				else
					bagText = "  [" .. format(L["TITAN_BAG_FORMAT"], availableProfBagSlots[bag], totalProfBagSlots[bag]) .. "]";
				end
				if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
					bagRichTextProf[bag] = TitanUtils_GetColoredText(bagText, color);
				else
					bagRichTextProf[bag] = TitanUtils_GetHighlightText(bagText);
				end
			end
		else -- not a profession bag so get used & available counts
			local size = GetContainerNumSlots(bag);
			if (size and size > 0) then
				totalBagSlots = totalBagSlots + size;
				for slot = 1, size do
					if (GetContainerItemInfo(bag, slot)) then
						usedBagSlots = usedBagSlots + 1;
					end
				end
			end
		end
	end
	availableBagSlots = totalBagSlots - usedBagSlots;

	if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
		bagText = format(L["TITAN_BAG_FORMAT"], usedBagSlots, totalBagSlots);
	else
		bagText = format(L["TITAN_BAG_FORMAT"], availableBagSlots, totalBagSlots);
	end

	if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
		color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, usedBagSlots / totalBagSlots);
		bagRichText = TitanUtils_GetColoredText(bagText, color);
	else
		bagRichText = TitanUtils_GetHighlightText(bagText);
	end

	bagRichText = bagRichText..bagRichTextProf[1]..bagRichTextProf[2]..bagRichTextProf[3]..bagRichTextProf[4]..bagRichTextProf[5];

	return L["TITAN_BAG_BUTTON_LABEL"], bagRichText;
end

local function UpdateButton(id)
	local button, id = TitanUtils_GetButton(id, true);
	local totalBagSlots, usedBagSlots, availableBagSlots, bag, bagText, bagRichText, color;
	local totalProfBagSlots = {0,0,0,0,0};
	local usedProfBagSlots = {0,0,0,0,0};
	local availableProfBagSlots = {0,0,0,0,0};
	local bagRichTextProf = {"","","","",""};

	totalBagSlots = 0;
	usedBagSlots = 0;
	for bag = 0, 4 do
	
		local bagType, color = TitanBag_IsProfBag(GetBagName(bag))

		if not TitanBag_IsProfBag(GetBagName(bag)) then
			local size = GetContainerNumSlots(bag);
			if (size and size > 0) then
				totalBagSlots = totalBagSlots + size;
				for slot = 1, size do
					if (GetContainerItemInfo(bag, slot)) then
						usedBagSlots = usedBagSlots + 1;
					end
				end
			end
		end
		if TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots") and TitanBag_IsProfBag(GetBagName(bag)) then
			local size = GetContainerNumSlots(bag);
			if (size and size > 0) then
				totalProfBagSlots[bag+1] = size;
				for slot = 1, size do
					if (GetContainerItemInfo(bag, slot)) then
						usedProfBagSlots[bag+1] = usedProfBagSlots[bag+1] + 1;
					end
				end
				availableProfBagSlots[bag+1] = totalProfBagSlots[bag+1] - usedProfBagSlots[bag+1];
			end
		end
	end
	availableBagSlots = totalBagSlots - usedBagSlots;

	if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
		bagText = format(L["TITAN_BAG_FORMAT"], usedBagSlots, totalBagSlots);
	else
		bagText = format(L["TITAN_BAG_FORMAT"], availableBagSlots, totalBagSlots);
	end

	if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
		color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, usedBagSlots / totalBagSlots);
		bagRichText = TitanUtils_GetColoredText(bagText, color);
	else
		bagRichText = TitanUtils_GetHighlightText(bagText);
	end

	for bag = 1, 5 do
		if totalProfBagSlots[bag] > 0 then
			if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
				bagText = "  [" .. format(L["TITAN_BAG_FORMAT"], usedProfBagSlots[bag], totalProfBagSlots[bag]) .. "]";
			else
				bagText = "  [" .. format(L["TITAN_BAG_FORMAT"], availableProfBagSlots[bag], totalProfBagSlots[bag]) .. "]";
			end
			if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
				bagType, color = TitanBag_IsProfBag(GetBagName(bag-1));
				bagRichTextProf[bag] = TitanUtils_GetColoredText(bagText, color);
			else
				bagRichTextProf[bag] = TitanUtils_GetHighlightText(bagText);
			end
		end
	end
	bagRichText = bagRichText..bagRichTextProf[1]..bagRichTextProf[2]..bagRichTextProf[3]..bagRichTextProf[4]..bagRichTextProf[5];
	
	return L["TITAN_BAG_BUTTON_LABEL"], bagRichText;
end

function TitanPanelBagButton_GetButtonText(id)

--TitanDebug("Bags ...")
--	local str1, str2 = UpdateButton(id)
--TitanDebug("> '"..tostring(str1).."' '"..tostring(str2).."'")
--TitanDebug("Bags new ...")
	local strA, strB = TextTest(id)
--TitanDebug("> '"..tostring(strA).."' '"..tostring(strB).."'")
--[[
	local cmp = ""
	
	if str1 == strA and str2 == strB then
		-- old & new are the same
		cmp = " == "
	else
		cmp = " ~= "
	end
--]]
--	TitanDebug("BagText "..cmp.." '"..tostring(str1).."' '"..tostring(strA).."'")
--	TitanDebug(" >>>>>> ".." '"..tostring(str2).."' '"..tostring(strB).."'")

	
	return strA, strB
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_GetTooltipText()
-- DESC : Display tooltip text
-- **************************************************************************
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

		for bag = 0, 4 do
			totalSlots = GetContainerNumSlots(bag) or 0;
			availableSlots = GetContainerNumFreeSlots(bag) or 0;
			usedSlots = totalSlots - availableSlots;
			local itemlink  = bag > 0 and GetInventoryItemLink("player", ContainerIDToInventoryID(bag)) 
				or TitanUtils_GetHighlightText(L["TITAN_BAG_BACKPACK"]).. FONT_COLOR_CODE_CLOSE;

			if itemlink then
				itemlink = string.gsub( itemlink, "%[", "" );
				itemlink = string.gsub( itemlink, "%]", "" );
			end

			if bag > 0 and not GetInventoryItemLink("player", ContainerIDToInventoryID(bag)) then
				itemlink = nil;
			end

			local bagText, bagRichText, color;
			if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
				bagText = format(L["TITAN_BAG_FORMAT"], usedSlots, totalSlots);
			else
				bagText = format(L["TITAN_BAG_FORMAT"], availableSlots, totalSlots);
			end

			if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then
				if totalSlots == 0 then
					color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, 1 );
				else
					color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, usedSlots / totalSlots);
				end
				bagRichText = TitanUtils_GetColoredText(bagText, color);
			else
				bagRichText = TitanUtils_GetHighlightText(bagText);
			end

			if itemlink then
				returnstring = returnstring..itemlink.."\t"..bagRichText.."\n";
			end
		end
		returnstring = returnstring.."\n";
	end
	return returnstring..TitanUtils_GetGreenText(L["TITAN_BAG_TOOLTIP_HINTS"]);
end

-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareBagMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareBagMenu()
	local info
	-- level 2
	if _G["L_UIDROPDOWNMENU_MENU_LEVEL"] == 2 then
		if _G["L_UIDROPDOWNMENU_MENU_VALUE"] == "Options" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_OPTIONS"], _G["L_UIDROPDOWNMENU_MENU_LEVEL"])
			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_USED_SLOTS"];
			info.func = TitanPanelBagButton_ShowUsedSlots;
			info.checked = TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots");
			L_UIDropDownMenu_AddButton(info, _G["L_UIDROPDOWNMENU_MENU_LEVEL"]);

			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS"];
			info.func = TitanPanelBagButton_ShowAvailableSlots;
			info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots"));
			L_UIDropDownMenu_AddButton(info, _G["L_UIDROPDOWNMENU_MENU_LEVEL"]);

			info = {};
			info.text = L["TITAN_BAG_MENU_SHOW_DETAILED"];
			info.func = TitanPanelBagButton_ShowDetailedInfo;
			info.checked = TitanGetVar(TITAN_BAG_ID, "ShowDetailedInfo");
			L_UIDropDownMenu_AddButton(info, _G["L_UIDROPDOWNMENU_MENU_LEVEL"]);
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
	L_UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = L["TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS"];
	info.func = TitanPanelBagButton_ToggleIgnoreProfBagSlots;
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots"));
	L_UIDropDownMenu_AddButton(info, _G["L_UIDROPDOWNMENU_MENU_LEVEL"]);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_BAG_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ShowUsedSlots()
-- DESC : Set option to show used slots
-- **************************************************************************
function TitanPanelBagButton_ShowUsedSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", 1);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ShowAvailableSlots()
-- DESC : Set option to show available slots
-- **************************************************************************
function TitanPanelBagButton_ShowAvailableSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", nil);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

-- **************************************************************************
-- NAME : TitanPanelBagButton_ToggleIgnoreProfBagSlots()
-- DESC : Set option to count profession bag slots
-- **************************************************************************
function TitanPanelBagButton_ToggleIgnoreProfBagSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountProfBagSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanPanelBagButton_ShowDetailedInfo()
	TitanToggleVar(TITAN_BAG_ID, "ShowDetailedInfo");
end

-- **************************************************************************
-- NAME : TitanBag_IsProfBag(name)
-- DESC : est to see if bag is a profession bag
-- VARS : name = item name
-- OUT  : bagType = type of profession matching bag name
--        color = the color associated with the profession
-- **************************************************************************
function TitanBag_IsProfBag(name)
	local bagType, color;
	if (name) then
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_ENCHANTING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "ENCHANTING";
				color = {r=0,g=0,b=1}; -- BLUE
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_ENGINEERING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "ENGINEERING";
				color = {r=1,g=0.49,b=0.04}; -- ORANGE
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_HERBALISM"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "HERBALISM";
				color = {r=0,g=1,b=0}; -- GREEN
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_INSCRIPTION"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "INSCRIPTION";
				color = {r=0.58,g=0.51,b=0.79}; -- PURPLE
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_JEWELCRAFTING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "JEWELCRAFTING";
				color = {r=1,g=0,b=0}; -- RED
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_LEATHERWORKING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "LEATHERWORKING";
				color = {r=0.78,g=0.61,b=0.43}; -- TAN
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_MINING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "MINING";
				color = {r=1,g=1,b=1}; -- WHITE
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_FISHING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "FISHING";
				color = {r=0.41,g=0.8,b=0.94}; -- LIGHT_BLUE
				return bagType, color;
			end
		end
		for index, value in pairs(L["TITAN_BAG_PROF_BAG_COOKING"]) do
			if (string.find(name, value, 1, true)) then
				bagType = "COOKING";
				color = {r=0.96,g=0.55,b=0.73}; -- PINK
				return bagType, color;
			end
		end
	end
	return false;
end