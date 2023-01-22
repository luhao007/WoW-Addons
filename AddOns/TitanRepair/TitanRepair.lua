--[[
-- **************************************************************************
-- * TitanRepair.lua
-- *
-- * By: The Titan Panel Development Team
-- **************************************************************************
--]]

-- ******************************** Constants *******************************
local TITAN_REPAIR_ID = "Repair";
local TITAN_BUTTON = "TitanPanel"..TITAN_REPAIR_ID.."Button"
local TITAN_TOOLTIP = "Titan"..TITAN_REPAIR_ID.."Tooltip"
local NYL = "nyl"

local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local TitanRepair = LibStub("AceAddon-3.0"):NewAddon(TITAN_REPAIR_ID, "AceHook-3.0", "AceTimer-3.0")
local _G = getfenv(0);
local TR = TitanRepair
TR.ITEM_STATUS = {};
TR.ITEM_BAG = {};

-- locals
TR.repair_total = 0
TR.dur_total = 0

TR.repair_bags = {}
TR.repair_equip = {}

TR.money_total = 0
TR.bag_list = {}
TR.equip_list = {}
TR.equip_most = nil
TR.last_scan = GetTime() -- seconds with milliseconds - sec.milli
TR.scan_time = 0
TR.scan_running = false

--debug
TR.show_debug = false -- will tell you a lot about what's happening
TR.show_debug_scan = false -- shows items processed during scan

-- ******************************** Functions *******************************

--[[ local
-- **************************************************************************
-- NAME : debug_msg(Message)
-- DESC : Debug function to print message to chat frame
-- VARS : Message = message to print to chat frame
-- **************************************************************************
--]]
local function debug_msg(Message)
	if (TR.show_debug) then
		local msg = ""
		local stamp = date("%H:%M:%S") -- date("%m/%d/%y %H:%M:%S")
		local milli = GetTime() -- seconds with millisecond precision (float)
		milli = string.format("%0.2F", milli - math.modf(milli))
		msg = msg..TitanUtils_GetGoldText(stamp..milli.." "..TITAN_REPAIR_ID..": ")
		msg = msg..TitanUtils_GetGreenText(Message)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
--		DEFAULT_CHAT_FRAME:AddMessage(TITAN_REPAIR_ID..": " .. Message, 1.00, 0.49, 0.04)
	end
end

--[[ local
-- **************************************************************************
-- NAME : RepairInit()
-- DESC : Reset the tables and variables to default values
-- VARS : None
-- **************************************************************************
--]]
local function RepairInit()
	TR.repair_total = 0
	TR.repair_bags = { cur = 0, max = 0, dur = 0, total = 0 }
	TR.repair_equip = { cur = 0, max = 0, dur = 0, total = 0 }

	TR.dur_total = 0

	TR.grays = { total = 0 }

	TR.money_total = 0
	TR.bag_list = {}
	TR.equip_list = {}
	TR.equip_most = nil
end

--[[ local
-- **************************************************************************
-- NAME : Scan(reason, force)
-- DESC : Scan all bags and equipment and set the 'scan in progress'
-- VARS : 
-- reason : string : for debug only - why was the scan requested?
-- force : boolean : whether to force a scan such as on player entering world or user request
-- Note: On a successful scan, the plugin button is updated.
-- **************************************************************************
--]]
local function Scan(reason, force)
	local must_do = force or false
	local milli = GetTime() -- seconds with millisecond precision (float)
	local dmsg = ""
	local msg = "Scan "

	if (TR.show_debug) then
		msg = msg
		.." '"..tostring(reason).."'"
		.." "..string.format("%0.2F",(milli - TR.last_scan)).." sec"
	end

	if must_do or (milli > TR.last_scan + 1) then -- no more than a scan per sec
		local calc_inv = TitanGetVar(TITAN_REPAIR_ID,"ShowInventory")
		local show_gray = TitanGetVar(TITAN_REPAIR_ID,"ShowGray")
		local sell_gray = TitanGetVar(TITAN_REPAIR_ID,"SellAllGray")
		local calc_gray = (show_gray or sell_gray) -- either needs a scan to calc
		
		if (TR.show_debug) then
			msg = msg.." : running "
				.." force:"..tostring(force)..""
				.." inv:"..tostring(calc_inv)..""
				.." show grey:"..tostring(show_gray)..""
				.." sell grey:"..tostring(calc_gray)..""
			debug_msg(msg)
		end
		
		-- Init the repair tables - equip / bags / grays
		RepairInit()
		

		-- ++++++++++++++++++++++++++++++++++++++++++++++++++
		-- scan equipped items - only those with durability
		--
		if (TR.show_debug) then
			dmsg = "Start equip scan"
				.." - "..(TitanGetVar(TITAN_REPAIR_ID,"ShowUndamaged") and "Include Undamaged" or "Only Damaged")
			debug_msg(dmsg)
		end

		local itemName, _, itemQuality
		for slotName, slotID in pairs(Enum.InventoryType) do
			local hasItem = {}
			local repairCost = 0
			local dbg_str_01 = ""
			
			local minimum, maximum = GetInventoryItemDurability(slotID)
			
			if minimum and maximum then
				-- 	Only when item has durability

				--Blizz changed SetInventoryItem for DragonFlight - use C_TooltipInfo namespace for everything 
				hasItem = C_TooltipInfo.GetInventoryItem("player", slotID)
				if hasItem then
					TooltipUtil.SurfaceArgs(hasItem) -- readable format
					repairCost = (hasItem.repairCost or 0) -- possibly not 'damaged' or no durability
				end
				if hasItem then
					local itemLink = GetInventoryItemLink("player", slotID)
				
					if itemLink then
						itemName, _, itemQuality = GetItemInfo(itemLink)
						local r, g, b, hex = GetItemQualityColor(itemQuality or 1)
						-- save item for tooltip and debug
						if ((repairCost and repairCost > 0) or TitanGetVar(TITAN_REPAIR_ID,"ShowUndamaged")) then
							TR.equip_list[slotName] = {
												name = (itemName or UNKNOWN),
												quality = (itemQuality or UNKNOWN),
												color = (hex or UNKNOWN),
												dur_max = (maximum or UNKNOWN),
												dur_cur = (minimum or UNKNOWN),
												dur_per = ((maximum > 0 and floor(minimum / maximum * 100)) or 100),
												cost = (repairCost or 0),
												}
							-- debug
							if TR.show_debug_scan then
								dbg_str_01 = tostring(slotName)..":"..tostring(slotId)
												.." '"..tostring(TR.equip_list[slotName].name).."'"
												.." "..tostring(TR.equip_list[slotName].quality)
												.." "..tostring(TR.equip_list[slotName].cost)
												.." "..tostring(TR.equip_list[slotName].dur_per).."%"
												.." "..tostring(TR.equip_list[slotName].dur_cur)
												.."/"..tostring(TR.equip_list[slotName].dur_max)
								debug_msg(dbg_str_01)
							else
								-- not requested
							end
						end
					else
						-- nothing
					end

					TR.repair_total = TR.repair_total + repairCost
					TR.repair_equip.total = TR.repair_equip.total + repairCost
				end

				TR.repair_equip.cur = TR.repair_equip.cur + minimum
				TR.repair_equip.max = TR.repair_equip.max + maximum
				
			else
				-- some equipped items do not have durability
			end
		end -- InventoryType
		TR.repair_equip.dur = (TR.repair_equip.max > 0 and floor(TR.repair_equip.cur / TR.repair_equip.max * 100)) or 100
		
		if (TR.show_debug) then
			dmsg = "End equip scan "
				.." $"..tostring(TR.repair_equip.total)
				.." "..tostring(TR.repair_equip.dur).."%"
				.." = "..tostring(TR.repair_equip.cur)
				.." / "..tostring(TR.repair_equip.max)
			debug_msg(dmsg)
		end
		
		-- ++++++++++++++++++++++++++++++++++++++++++++++++++
		-- Check inventory for repair costs AND grays
		--
		for bag = 0, 4 do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				if calc_inv then -- scan bags for 'damaged' items
					-- Inventory repair costs
					local repairCost = 0

					local minimum, maximum = C_Container.GetContainerItemDurability(bag, slot)
					if minimum and maximum then
						local data = C_TooltipInfo.GetBagItem(bag, slot)
						if data then
							TooltipUtil.SurfaceArgs(data) -- readable format
							repairCost = (data.repairCost or 0)
						end
						if (repairCost and (repairCost > 0)) then
							TR.repair_total = TR.repair_total + repairCost
							TR.repair_bags.total = TR.repair_bags.total + repairCost
						end
						TR.repair_bags.cur = TR.repair_bags.cur + minimum
						TR.repair_bags.max = TR.repair_bags.max + maximum
					end
				else
					-- save a few cycles
				end
				if calc_gray then -- scan bags for 'gray' items
					local info = C_Container.GetContainerItemInfo(bag, slot)
					if info and info.quality == 0 then 
						-- gray / Poor quality
						TR.grays.total = TR.grays.total + (info.stackCount * select(11, GetItemInfo(info.itemID)))
					else
						-- ignore - not gray
					end
				else
					-- save a few cycles
				end
			end
		end
		if calc_inv then -- calc total damage - if requested by user.
			TR.repair_bags.dur = (TR.repair_bags.max > 0 and floor(TR.repair_bags.cur / TR.repair_bags.max * 100)) or 100
			if (TR.show_debug) then
				dmsg = "Bags repair totals"
					.." "..tostring(TR.repair_bags.dur)
					.." $ "..tostring(TR.repair_bags.total)
				debug_msg(dmsg)
			end
		else
			debug_msg("Bags repair totals None - User did not request")
		end
		if (TR.show_debug) then
			if calc_gray then -- calc total grays - if requested by user.
				dmsg = "Bags gray scan End "
					.." $ "..tostring(TR.grays.total)
				debug_msg(dmsg)
			else
				debug_msg("Bags gray totals None - User did not request")
			end
		end

		-- ++++++++++++++++++++++++++++++++++++++++++++++++++
		-- Calc total durability %
		-- repair_equip - gear currently worn
		-- repair_bags - any dmaaged gear in bags
		TR.dur_total = ((TR.repair_bags.max + TR.repair_equip.max) > 0 
			and floor( (TR.repair_bags.cur + TR.repair_equip.cur) / (TR.repair_bags.max + TR.repair_equip.max) * 100)) 
			or 100
		
		-- cleanup
		TR.scan_time = GetTime() - milli
		TR.last_scan = GetTime()
		TR.scan_running = false
		
		-- update button text
		TitanPanelButton_UpdateButton(TITAN_REPAIR_ID)
		
		if (TR.show_debug) then
			dmsg = "Calc total durability"
				.." '"..tostring(TR.dur_total).."'"
				.." "..tostring(TR.repair_equip.max)
				.." "..tostring(TR.repair_equip.cur)
				.." "..tostring(TR.repair_bags.max)
				.." "..tostring(TR.repair_bags.cur)
			debug_msg(dmsg)
			dmsg = "...Scan complete"
			debug_msg(dmsg)
		end
	else
		if (TR.show_debug) then
			msg = msg.." : NOT running - too soon "
			debug_msg(msg)
		end
	end
end

--[[ local
-- **************************************************************************
-- NAME : RepairShow()
-- DESC : Prepare to activate Repair - events, init, etc.
-- VARS : None
-- **************************************************************************
--]]
local function RepairShow(self)
	debug_msg("RepairShow - starting")
	RepairInit()
	
	self:RegisterEvent("MERCHANT_SHOW");
	self:RegisterEvent("MERCHANT_CLOSED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterEvent("UPDATE_INVENTORY_DURABILITY")

	-- Check everything on world enter (at init and after zoning)
	Scan("OnShow", true)

	debug_msg("...RepairShow - complete")
end

--[[ local
-- **************************************************************************
-- NAME : RepairHide()
-- DESC : Prepare to deactivate Repair - events, etc.
-- VARS : None
-- **************************************************************************
--]]
local function RepairHide(self)
	debug_msg("RepairHide - shutting down")
	RepairInit() -- cleanup footprint

	self:UnregisterEvent("MERCHANT_SHOW");
	self:UnregisterEvent("MERCHANT_CLOSED");
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	self:UnregisterEvent("UPDATE_INVENTORY_DURABILITY");

	debug_msg("...RepairHide - complete")
end

--[[ local
-- **************************************************************************
-- NAME : GetGSC(money)
-- DESC : Scan all bags and equipment and set the 'scan in progress'
-- VARS : 
-- money : int : money in copper
-- OUT : 
-- int : gold component
-- int : silver component
-- int : copper component
-- boolean : whether value is negative or not
-- **************************************************************************
--]]
local function GetGSC(money)
	local neg = false;
	if (money == nil) then money = 0; end
	if (money < 0) then
		neg = true;
		money = money * -1;
	end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g * 10000)) / 100);
	local c = math.floor(money - (g * 10000) - (s * 100));
	return g, s, c, neg;
end

--[[ local
-- **************************************************************************
-- NAME : GetGSC(money)
-- DESC : Scan all bags and equipment and set the 'scan in progress'
-- VARS : 
-- money : int : money in copper
-- OUT : 
-- gsc : string : formatted and colored of given money
-- **************************************************************************
--]]
local function GetTextGSC(money)
	local GSC_GOLD = "ffd100";
	local GSC_SILVER = "e6e6e6";
	local GSC_COPPER = "c8602c";
	local GSC_START = "|cff%s%d|r";
	local GSC_PART = ".|cff%s%02d|r";
	local GSC_NONE = "|cffa0a0a0" .. NONE .. "|r";
	local g, s, c, neg = GetGSC(money);
	local gsc = "";
	if (g > 0) then
		gsc = format(GSC_START, GSC_GOLD, g);
		gsc = gsc .. format(GSC_PART, GSC_SILVER, s);
		gsc = gsc .. format(GSC_PART, GSC_COPPER, c);
	elseif (s > 0) then
		gsc = format(GSC_START, GSC_SILVER, s);
		gsc = gsc .. format(GSC_PART, GSC_COPPER, c);
	elseif (c > 0) then
		gsc = gsc .. format(GSC_START, GSC_COPPER, c);
	else
		gsc = GSC_NONE;
	end
	if (neg) then gsc = "(" .. gsc .. ")"; end
	return gsc;
end

--[[ local
-- **************************************************************************
-- NAME : TitanRepair_RepairItems()
-- DESC : <research>
-- **************************************************************************
--]]
local function TitanRepair_RepairItems()
	debug_msg("_RepairItems")
	-- New RepairAll function
	local cost = GetRepairAllCost();
	local money = GetMoney();
	local withdrawLimit = GetGuildBankWithdrawMoney();
	local guildBankMoney = GetGuildBankMoney();

	-- Use Guild Bank funds
	if TitanGetVar(TITAN_REPAIR_ID,"UseGuildBank") then
		debug_msg("UseGuildBank"
			.." $"..tostring(cost)..""
			.." limit: "..tostring(withdrawLimit)
			.." guild $: "..tostring(guildBankMoney)
			)
---[[
--]]
		if IsInGuild() and CanGuildBankRepair() then
			if withdrawLimit >= cost then
				RepairAllItems(true)
				if TitanGetVar(TITAN_REPAIR_ID,"AutoRepairReport") then
					DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_REPAIR"]..": ".."|r"
						..L["TITAN_REPAIR_REPORT_COST_CHAT"]..GetTextGSC(cost).."|r"
						.." "..FROM.." "..GUILD..".")
				end
				-- disable repair all icon in merchant
				SetDesaturation(MerchantRepairAllIcon, 1);
				MerchantRepairAllButton:Disable();
				-- disable guild bank repair all icon in merchant
				SetDesaturation(MerchantGuildBankRepairButtonIcon, 1);
				MerchantGuildBankRepairButton:Disable();
				-- report repair cost to chat (optional)
			else
				DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_REPAIR"]..": ".."|r"..L["TITAN_REPAIR_GBANK_NOMONEY"])
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_REPAIR"]..": ".."|r"..L["TITAN_REPAIR_GBANK_NORIGHTS"])
		end
	else -- Use own funds
		debug_msg("Use own gold "
			.." $"..tostring(cost)..""
			.." gold: "..tostring(money)
			)
		if money > cost then
			RepairAllItems()
			-- report repair cost to chat (optional)
			if TitanGetVar(TITAN_REPAIR_ID,"AutoRepairReport") then
				DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_REPAIR"]..": ".."|r"
					..L["TITAN_REPAIR_REPORT_COST_CHAT"]..GetTextGSC(cost)
					.." "..FROM.." "..YOU..".")
			end
			-- disable repair all icon in merchant
			SetDesaturation(MerchantRepairAllIcon, 1);
			MerchantRepairAllButton:Disable();
			-- disable guild bank repair all icon in merchant
			SetDesaturation(MerchantGuildBankRepairButtonIcon, 1);
			MerchantGuildBankRepairButton:Disable();
		else
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_REPAIR"]..": ".."|r"..L["TITAN_REPAIR_CANNOT_AFFORD"])
		end
	end
end

--[[ local
-- **************************************************************************
-- NAME : TitanRepair_SellGrayItems()
-- DESC : <research>
-- **************************************************************************
--]]
local function TitanRepair_SellGrayItems()
	debug_msg("Selling gray items")

	for bag = 0, 4 do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local info = C_Container.GetContainerItemInfo(bag, slot)
			if info and info.quality == 0 then 
				if TR.show_debug then
					local name, _, value
						name,
						_, -- link
						_, -- quality
						_, -- level
						_, -- min level
						_, -- type
						_, -- sub type
						_, -- stack count
						_, -- loc
						_, -- texture
						value,
						_, -- class id
						_, -- sub class id
						_, -- bind type
						_, -- xpac id
						_, -- set id
						_ -- is crafting reagent
						= GetItemInfo(info.itemID)
					local msg = "Selling"
					.." "..tostring(info.stackCount)..""
					.." "..tostring(name)..""
					.." $ "..tostring(GetGSC(info.stackCount * value))..""
					.." "..tostring(bag)..""
					.." "..tostring(slot)..""
					debug_msg(msg)
				end
				
				-- Sell item(s)
				for i = 1, info.stackCount do
					C_Container.UseContainerItem(bag, slot)
				end
			else
				-- ignore - not gray
			end
		end
	end
end

--[[ local
-- **************************************************************************
-- NAME : AutoHighlight (item_frac, valueText)
-- DESC : Color (green / white / red) the given string (durability as % or x / y) based on the given percentage
-- VARS : 
-- item_frac : float : the percentage of durability
-- valueText : string : durability in color
-- **************************************************************************
--]]
local function AutoHighlight (item_frac, valueText)
	-- Basic threshold coloring
	-- Do not check for <= 0.90 or <= 0.20 because fractional eguality test is not acurate...
	if (TitanGetVar(TITAN_REPAIR_ID, "ShowColoredText")) then
		if (item_frac < 21) then
			valueText = TitanUtils_GetRedText(valueText);
		elseif (item_frac < 91) then
			valueText = TitanUtils_GetHighlightText(valueText);
		else
			valueText = TitanUtils_GetGreenText(valueText);
		end
	else
		valueText = TitanUtils_GetHighlightText(valueText);
	end

	return valueText;
end

--[[ Titan
-- **************************************************************************
-- NAME : TitanPanelRepairButton_OnLoad(self)
-- DESC : Registers the plugin upon loading; OnShow to start; OnHide to stop
-- **************************************************************************
--]]
function TitanPanelRepairButton_OnLoad(self)
	local notes = "Rewritten Nov 2022 - Notable changes:\n"
		.."- Uses less events; faster.\n"
		.."- OnShow / OnHide now start / stop processing. Hopefully stopping 'protected' errors for those not running Repair.\n"
		.."- Gated to once per sec except at Merchant and OnShow.\n"
		.."- Left - Click added to force a scan - just in case.\n"
		.."- Removed 'most damaged' item to save a few cycles.\n"
	self.registry = {
		id = TITAN_REPAIR_ID,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["REPAIR_LOCALE"]["menu"],
		buttonTextFunction = "TitanPanelRepairButton_GetButtonText",
		tooltipTitle = L["REPAIR_LOCALE"]["tooltip"],
		tooltipTextFunction = "TitanPanelRepairButton_GetTooltipText",
		icon = "Interface\\AddOns\\TitanRepair\\TitanRepair",
		iconWidth = 16,
		notes = notes,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowColoredText = true,
			DisplayOnRightSide = true,
		},
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowUndamaged = false,
			ShowPopup = false,
			AutoRepair = false,
			DiscountFriendly = false,
			DiscountHonored = false,
			DiscountRevered = false,
			DiscountExalted = false,
			ShowPercentage = false,
			ShowColoredText = false,
			ShowInventory = false,
			ShowRepairCost = 1,
			ShowMostDmgPer = 1,
			UseGuildBank = false,
			AutoRepairReport = false,
			ShowItems = true,
			ShowDiscounts = true,
			ShowCosts = true,
			DisplayOnRightSide = false,
			ShowGray = false,
			SellAllGray = false,
		}
	};
end

StaticPopupDialogs["REPAIR_CONFIRMATION"] = {
	text = L["REPAIR_LOCALE"]["confirmation"],
	button1 = YES,
	button2 = NO,
	OnAccept = function(self)
		TitanRepair_RepairItems();
	end,
	OnShow = function(self)
		MoneyFrame_Update(self.moneyFrame, TR.repair_total);
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};

--[[ Titan
-- **************************************************************************
-- NAME : TitanPanelRepairButton_OnEvent(self, event, a1, ...)
-- DESC : This section will grab the events registered to the add on and act on them
-- **************************************************************************
--]]
function TitanPanelRepairButton_OnEvent(self, event, a1, ...)

	local msg = "Event"
		.." "..tostring(event)
		.." "..tostring(a1)
		.."..."
	debug_msg(msg)

	if (event == "PLAYER_REGEN_ENABLED")
	or (event == "UNIT_INVENTORY_CHANGED" and a1 == "player")
	or (event == "UPDATE_INVENTORY_DURABILITY")
	then
		Scan(event, false)
	end
--[[
	if (event == "PLAYER_MONEY" and TR.MerchantisOpen == true and CanMerchantRepair())
	then
		Scan(event, true)
	end
--]]
	if (event == "MERCHANT_SHOW") then
		TR.MerchantisOpen = true;
		local canRepair = CanMerchantRepair();
		-- handle sell ALL grays
		if (TitanGetVar(TITAN_REPAIR_ID,"SellAllGray") == 1) then
			if (TR.grays.total > 0) then
				TitanRepair_SellGrayItems()
				Scan("MERCHANT_SHOW - auto SellAllGray", true)
			end
		end
		
		if canRepair then
			-- keep going
		else
			return -- save a few cycles
		end
		self:RegisterEvent("PLAYER_MONEY") -- this prevents extra scan requests on looting...
		if TitanGetVar(TITAN_REPAIR_ID,"ShowPopup") == 1 then
			if (TR.repair_total > 0) then
				TR.MONEY = repairCost;
				StaticPopup_Show("REPAIR_CONFIRMATION");
			end
		end
		-- handle auto-repair
		if (TitanGetVar(TITAN_REPAIR_ID,"AutoRepair") == 1) then
			if (TR.repair_total > 0) then
				TitanRepair_RepairItems();
				Scan("MERCHANT_SHOW - AutoRepair", true)
			end
		end
	end

	if ( event == "MERCHANT_CLOSED" ) then
		TR.MerchantisOpen = false;

		StaticPopup_Hide("REPAIR_CONFIRMATION");
		-- When an object is repaired in a bag, the BAG_UPDATE event is not sent so we rescan all
		Scan("MERCHANT_CLOSED",  true)
		self:UnregisterEvent("PLAYER_MONEY");
	end

	local msg = "...Event"
		.." "..tostring(event)
		.." ".."complete"
	debug_msg(msg)
end

function TitanPanelRepairButton_OnClick(self, button)
	if button == "LeftButton" and IsShiftKeyDown() then
		TitanUtils_CloseAllControlFrames();
		if (TitanPanelRightClickMenu_IsVisible()) then
			TitanPanelRightClickMenu_Close();
		end
		Scan("User Sh+L click", true)
	elseif button == "LeftButton" then
		if TR.MerchantisOpen == true  then
			TitanRepair_SellGrayItems()
			Scan("MERCHANT_SHOW - user intiated SellAllGray", true)
		end
	else
		TitanPanelButton_OnClick(self, button);
	end
end

--[[ Titan
-- **************************************************************************
-- NAME : TitanPanelRepairButton_GetButtonText(id)
-- DESC : Determine the plugin button text based on last scan values and user preferences
-- VARS : id = plugin id (Repair)
-- OUT : 
-- string : plugin label
-- string : plugin text / values
-- **************************************************************************
--]]
function TitanPanelRepairButton_GetButtonText(id)
	local text, itemLabel = "", "" -- TitanRepair_GetStatusStr(TPR.INDEX, 1);
	local itemNamesToShow = "";
	local itemPercent = 0
	local itemCost = 0

	-- supports turning off labels
	if TR.scan_running then
		return L["REPAIR_LOCALE"]["button"],
			text .. " (" .. L["REPAIR_LOCALE"]["WholeScanInProgress"] .. ")";
	else
		local costStr = 0;
		local discountlabel = "";

		-- calculate the totals
		dura_total = TR.dur_total
		bags_dur = TR.repair_bags.dur
		equip_dur = TR.repair_equip.dur

		text = string.format("%d%%", dura_total);
		text = AutoHighlight (dura_total, text);
		text = text.." " -- total %

		-- show cost per the user choice
		local sum = TR.repair_total
		if (sum > 0 and TitanGetVar(TITAN_REPAIR_ID,"ShowRepairCost")) then
			-- if a discount was requested by user
			if TitanGetVar(TITAN_REPAIR_ID, "DiscountFriendly") then
				sum = sum * 0.95;
				discountlabel = FACTION_STANDING_LABEL5;
			elseif TitanGetVar(TITAN_REPAIR_ID, "DiscountHonored") then
				sum = sum * 0.90;
				discountlabel = FACTION_STANDING_LABEL6;
			elseif TitanGetVar(TITAN_REPAIR_ID, "DiscountRevered") then
				sum = sum * 0.85;
				discountlabel = FACTION_STANDING_LABEL7;
			elseif TitanGetVar(TITAN_REPAIR_ID, "DiscountExalted") then
				sum = sum * 0.80;
				discountlabel = FACTION_STANDING_LABEL8;
			end
			costStr = "(".. GetTextGSC(sum)..") ";
			discountlabel = GREEN_FONT_COLOR_CODE..discountlabel..FONT_COLOR_CODE_CLOSE.." "
		else
			-- user does not want to see cost; clear the reputation also
			costStr = ""
			discountlabel = ""
		end

		local gray_header = ""
		local gray_total = ""
		if (TitanGetVar(TITAN_REPAIR_ID,"ShowGray")) then
			gray_header = ITEM_QUALITY0_DESC..": " -- Poor / gray
			gray_total = GetTextGSC(TR.grays.total)
		else
			-- user does not want to see cost; clear the reputation also
			gray_header = ""
			gray_total = ""
		end
		-- Now that the pieces have been created, return the whole string
		return L["REPAIR_LOCALE"]["button"],
			text
			..costStr
			..discountlabel
			..itemNamesToShow,
			gray_header,
			gray_total
	end
end

--[[ Titan
-- **************************************************************************
-- NAME : TitanPanelRepairButton_GetTooltipText()
-- DESC : Create the Repair tool tip based on last scan and user preferences
-- **************************************************************************
--]]
function TitanPanelRepairButton_GetTooltipText()
	local out = "";
	local cost = 0;
	local sum = TR.repair_total

	if TR.show_debug then
		local msg = "Tooltip Start "
			.." items:"..tostring(TitanGetVar(TITAN_REPAIR_ID,"ShowItems"))
			.." discounts:"..tostring(TitanGetVar(TITAN_REPAIR_ID,"ShowDiscounts"))
			.." costs:"..tostring(TitanGetVar(TITAN_REPAIR_ID,"ShowCosts"))
			.." guild:"..tostring(TitanGetVar(TITAN_REPAIR_ID,"UseGuildBank"))
			.." show gray:"..tostring(TitanGetVar(TITAN_REPAIR_ID,"ShowGray"))
			.." sell gray:"..tostring(TitanGetVar(TITAN_REPAIR_ID,"SellAllGray"))
		debug_msg(msg)
	end

	if (TitanGetVar(TITAN_REPAIR_ID,"ShowItems")) then
		out = out..TitanUtils_GetGoldText(L["REPAIR_LOCALE"]["Items"]).."\n"

		local num_items = 0
		-- walk items saved from the scan
		for slotName, slotID in pairs(Enum.InventoryType) do
			if TR.equip_list[slotName] then
				-- determine the percent or value per user request
				local valueText = ""
--[[
				msg = ""
					.." '"..tostring(slotName).."'"
					.." '"..tostring(TR.equip_list[slotName].name).."'"
					.." "..tostring(TR.equip_list[slotName].quality)
					.." "..tostring(TR.equip_list[slotName].cost)
					.." "..tostring(TR.equip_list[slotName].dur_per).."%"
					.." "..tostring(TR.equip_list[slotName].dur_cur)
					.."/"..tostring(TR.equip_list[slotName].dur_max)
				debug_msg(msg)
--]]
				if (TitanGetVar(TITAN_REPAIR_ID,"ShowPercentage")) then
					valueText = string.format("%d%%", TR.equip_list[slotName].dur_per)
				else
					valueText = string.format("%d/%d", TR.equip_list[slotName].dur_cur, TR.equip_list[slotName].dur_max)
				end
				-- % color
				out = out..AutoHighlight(TR.equip_list[slotName].dur_per, valueText).."  "
				-- name with color
				out = out.."|c"..TR.equip_list[slotName].color..TR.equip_list[slotName].name.._G["FONT_COLOR_CODE_CLOSE"]
				-- add column
				out = out.."\t"
				-- add cost
				out = out..GetTextGSC(TR.equip_list[slotName].cost)
				out = out.."\n"
				
				num_items = num_items + 1
			else
				-- slot is empty or not 'damaged'
			end
		end
		
		if num_items == 0 then
			-- All items are at 100%
			out = out..TitanUtils_GetHighlightText("No items damaged").."\n"
		end
		debug_msg(tostring("Items shown : "..num_items))
	end

	out = out.."\n" -- spacer
	if (TitanGetVar(TITAN_REPAIR_ID,"ShowDiscounts")) then
		if (sum > 0) then
			out = out..TitanUtils_GetGoldText(L["REPAIR_LOCALE"]["Discounts"])..TitanUtils_GetHighlightText("").."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["normal"]) .. "\t" .. GetTextGSC(sum).."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["friendly"]) .. "\t" .. GetTextGSC(sum * 0.95).."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["honored"]) .. "\t" .. GetTextGSC(sum * 0.90).."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["revered"]) .. "\t" .. GetTextGSC(sum * 0.85).."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["exalted"]) .. "\t" .. GetTextGSC(sum * 0.80).."\n"
		else
			out = out..TitanUtils_GetGoldText(L["REPAIR_LOCALE"]["Discounts"]).."\t".."|cffa0a0a0"..NONE.."|r".."\n"
		end
		out = out.."\n"
	end

	if (TitanGetVar(TITAN_REPAIR_ID,"ShowCosts")) then
		if (sum > 0) then
			out = out..TitanUtils_GetGoldText(L["REPAIR_LOCALE"]["Costs"]).." ".."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["CostEquip"]).." : ".. "\t" .. GetTextGSC(TR.repair_equip.total).."\n"
			out = out.. TitanUtils_GetHighlightText(L["REPAIR_LOCALE"]["CostBag"]).." : ".. "\t" .. GetTextGSC(TR.repair_bags.total).."\n"
			out = out.. "---".. "\t" .. "---".."\n"
			out = out.. TitanUtils_GetHighlightText(REPAIR_COST).. "\t" .. GetTextGSC(TR.repair_total).."\n"
		else
			out = out..TitanUtils_GetGoldText(L["REPAIR_LOCALE"]["Costs"]).."\t".."|cffa0a0a0"..NONE.."|r".."\n"
		end
		out = out .. "\n"
	end

	if (TitanGetVar(TITAN_REPAIR_ID,"ShowGray")) 
	or (TitanGetVar(TITAN_REPAIR_ID,"SellAllGray")) then
		if (TR.grays.total > 0) then
			out = out..TitanUtils_GetGoldText(ITEM_QUALITY0_DESC).." : ".. "\t" .. GetTextGSC(TR.grays.total).."\n"
		else
			out = out..TitanUtils_GetGoldText(ITEM_QUALITY0_DESC).."\t".."|cffa0a0a0"..NONE.."|r".."\n"
		end
		out = out .. "\n"
	end

	-- Show the guild - if player is in one
	--GUILDBANK_REPAIR
	if IsInGuild() then
		out = out..TitanUtils_GetGoldText(GUILD).."\n"
		local name, rank, index, realm = GetGuildInfo("player")
		out = out..TitanUtils_GetHighlightText(name).." : ".."\t"..TitanUtils_GetHighlightText(rank).."\n"

		if TitanGetVar(TITAN_REPAIR_ID, "UseGuildBank") then
			if CanGuildBankRepair() then
				if IsGuildLeader() then
					-- Can use the whole bank amount...
					out = out..TitanUtils_GetHighlightText(WITHDRAW.." "..AVAILABLE).."\t" ..UNLIMITED.."\n"
				else
					local withdrawLimit = GetGuildBankWithdrawMoney()
					out = out..TitanUtils_GetHighlightText(WITHDRAW.." "..AVAILABLE).."\t"..GetTextGSC(withdrawLimit).."\n"
					if (withdrawLimit >= sum) then
						-- funds available
					else
						out = out.. TitanUtils_GetRedText(GUILDBANK_REPAIR_INSUFFICIENT_FUNDS).."\n"
					end
				end
			else
				out = out..TitanUtils_GetHighlightText(WITHDRAW.." "..AVAILABLE).."\t".."|cffa0a0a0"..NONE.."|r".."\n"
			end
		else
			out = out..TitanUtils_GetHighlightText(L["TITAN_REPAIR_GBANK_USEFUNDS"]).." : ".."\t"..TitanUtils_GetHighlightText(tostring(false)).."\n"
		end
		out = out .. "\n"
	end

	out = out..L["REPAIR_LOCALE"]["AutoRepitemlabel"].." : ".."\t"
		..TitanUtils_GetHighlightText(tostring(TitanGetVar(TITAN_REPAIR_ID, "AutoRepair") and true or false)).."\n"
	out = out..L["REPAIR_LOCALE"]["showinventory"].." : ".."\t"
		..TitanUtils_GetHighlightText(tostring(TitanGetVar(TITAN_REPAIR_ID, "ShowInventory") and true or false)).."\n"
	out = out.."Sell ALL "..ITEM_QUALITY0_DESC.." : ".."\t"
		..TitanUtils_GetHighlightText(tostring(TitanGetVar(TITAN_REPAIR_ID, "SellAllGray") and true or false)).."\n"
	out = out.."\n"

	out = out..TitanUtils_GetGreenText("Hint: Left click to sell ALL "..ITEM_QUALITY0_DESC.." items - CAUTION\n")
	out = out.."\t"..TitanUtils_GetGreenText("Only while merchant is open ".."\n")
	out = out..TitanUtils_GetGreenText("Hint: Shift + Left click to force a scan of repair info.")

	return out, itemLabel
end

--[[ Titan
-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareRepairMenu()
-- DESC : Create the Repair right click menu
-- **************************************************************************
--]]
function TitanPanelRightClickMenu_PrepareRepairMenu()
	local info;

	-- level 2
	if TitanPanelRightClickMenu_GetDropdownLevel() == 2 then
		if TitanPanelRightClickMenu_GetDropdMenuValue() == "Discount" then
			TitanPanelRightClickMenu_AddTitle(L["REPAIR_LOCALE"]["discount"], TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["buttonNormal"];
			info.checked = not TitanGetVar(TITAN_REPAIR_ID,"DiscountFriendly") and not TitanGetVar(TITAN_REPAIR_ID,"DiscountHonored") and not TitanGetVar(TITAN_REPAIR_ID,"DiscountRevered") and not TitanGetVar(TITAN_REPAIR_ID,"DiscountExalted");
			info.disabled = TR.MerchantisOpen;
			info.func = function()
				TitanSetVar(TITAN_REPAIR_ID,"DiscountFriendly", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountHonored", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountRevered", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountExalted", nil)
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID)
			end
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["buttonFriendly"];
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"DiscountFriendly");
			info.disabled = TR.MerchantisOpen;
			info.func = function()
				TitanSetVar(TITAN_REPAIR_ID,"DiscountFriendly", 1)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountHonored", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountRevered", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountExalted", nil)
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID)
			end
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["buttonHonored"];
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"DiscountHonored");
			info.disabled = TR.MerchantisOpen;
			info.func = function()
				TitanSetVar(TITAN_REPAIR_ID,"DiscountFriendly", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountHonored", 1)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountRevered", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountExalted", nil)
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID)
			end
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["buttonRevered"];
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"DiscountRevered");
			info.disabled = TR.MerchantisOpen;
			info.func = function()
				TitanSetVar(TITAN_REPAIR_ID,"DiscountFriendly", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountHonored", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountRevered", 1)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountExalted", nil)
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID)
			end
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["buttonExalted"];
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"DiscountExalted");
			info.disabled = TR.MerchantisOpen;
			info.func = function()
				TitanSetVar(TITAN_REPAIR_ID,"DiscountFriendly", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountHonored", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountRevered", nil)
				TitanSetVar(TITAN_REPAIR_ID,"DiscountExalted", 1)
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID)
			end
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end

		if TitanPanelRightClickMenu_GetDropdMenuValue() == "Options" then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_OPTIONS"], TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["showinventory"];
			info.func = function() 
				TitanToggleVar(TITAN_REPAIR_ID, "ShowInventory");
				Scan("Calc inventory durability", true)
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowInventory");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["ShowRepairCost"];  --"Show Repair Cost"
			info.func = function() 
				TitanToggleVar(TITAN_REPAIR_ID, "ShowRepairCost");
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowRepairCost");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = "Show "..ITEM_QUALITY0_DESC.." Total" --L["REPAIR_LOCALE"]["ShowRepairCost"];  
			info.func = function() 
				TitanToggleVar(TITAN_REPAIR_ID, "ShowGray");
				Scan("Calc inventory gray", true)
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowGray");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = "Sell ALL "..ITEM_QUALITY0_DESC.." Items - CAUTION" -- L["REPAIR_LOCALE"]["ShowRepairCost"]; 
			info.func = function() 
				TitanToggleVar(TITAN_REPAIR_ID, "SellAllGray");
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"SellAllGray");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end

		if TitanPanelRightClickMenu_GetDropdMenuValue() == "AutoRepair" then
			TitanPanelRightClickMenu_AddTitle(L["REPAIR_LOCALE"]["AutoReplabel"], TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["popup"];
			info.func = function()
				TitanToggleVar(TITAN_REPAIR_ID, "ShowPopup");
				if TitanGetVar(TITAN_REPAIR_ID,"ShowPopup") and TitanGetVar(TITAN_REPAIR_ID,"AutoRepair") then
					TitanSetVar(TITAN_REPAIR_ID,"AutoRepair",nil);
				end
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowPopup");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["AutoRepitemlabel"];
			info.func = function()
				TitanToggleVar(TITAN_REPAIR_ID, "AutoRepair");
				if TitanGetVar(TITAN_REPAIR_ID,"AutoRepair") and TitanGetVar(TITAN_REPAIR_ID,"ShowPopup") then
					TitanSetVar(TITAN_REPAIR_ID,"ShowPopup",nil);
				end
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"AutoRepair");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["TITAN_REPAIR_REPORT_COST_MENU"]
			info.func = function() TitanToggleVar(TITAN_REPAIR_ID, "AutoRepairReport"); end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"AutoRepairReport");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {}
			info.text = L["TITAN_REPAIR_GBANK_USEFUNDS"]
			info.func = function() TitanToggleVar(TITAN_REPAIR_ID, "UseGuildBank"); end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"UseGuildBank");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end

		if TitanPanelRightClickMenu_GetDropdMenuValue() == "TooltipOptions" then
			TitanPanelRightClickMenu_AddTitle(L["REPAIR_LOCALE"]["TooltipOptions"], TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["ShowItems"];
			info.func = function() TitanToggleVar(TITAN_REPAIR_ID, "ShowItems"); end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowItems");
			info.keepShownOnClick = 1
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["undamaged"];
			info.func = function() 
				TitanToggleVar(TITAN_REPAIR_ID, "ShowUndamaged");
				end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowUndamaged");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			TitanPanelRightClickMenu_AddSeparator(TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["percentage"];
			info.func = function()
				TitanToggleVar(TITAN_REPAIR_ID, "ShowPercentage");
				TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
			end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowPercentage");
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["ShowDiscounts"];
			info.func = function() TitanToggleVar(TITAN_REPAIR_ID, "ShowDiscounts"); end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowDiscounts");
			info.keepShownOnClick = 1
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

			info = {};
			info.text = L["REPAIR_LOCALE"]["ShowCosts"];
			info.func = function() TitanToggleVar(TITAN_REPAIR_ID, "ShowCosts"); end
			info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowCosts");
			info.keepShownOnClick = 1
			TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
		end

		return
	end

	-- level 1
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_REPAIR_ID].menuText);

	info = {};
	info.notCheckable = true
	info.text = L["TITAN_PANEL_OPTIONS"];
	info.value = "Options"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.notCheckable = true
	info.text = L["REPAIR_LOCALE"]["AutoReplabel"];
	info.value = "AutoRepair"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
--[[
	local guildName, _, _ = GetGuildInfo("player")
	info = {};
	info.notCheckable = true
	info.text = _G["GUILD_BANK"];
	info.value = "GuildBank"
	if guildName then
		info.hasArrow = 1
	else
		info.disabled = true
	end
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());
--]]
	info = {};
	info.notCheckable = true
	info.text = L["REPAIR_LOCALE"]["discount"];
	info.value = "Discount"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	info = {};
	info.notCheckable = true
	info.text = L["REPAIR_LOCALE"]["TooltipOptions"];
	info.value = "TooltipOptions"
	info.hasArrow = 1;
	TitanPanelRightClickMenu_AddButton(info, TitanPanelRightClickMenu_GetDropdownLevel());

	TitanPanelRightClickMenu_AddControlVars(TITAN_REPAIR_ID)
end

--[[ local
-- **************************************************************************
-- NAME : Create_Frames()
-- DESC : Create the required Repair plugin frames
-- **************************************************************************
--]]
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
	TitanPanelRepairButton_OnLoad(window);
--	TitanPanelButton_OnLoad(window); -- Titan XML template calls this...
	
	window:SetScript("OnEvent", function(self, event, ...)
		TitanPanelRepairButton_OnEvent(self, event, ...) 
	end)
	window:SetScript("OnClick", function(self, button)
		TitanPanelRepairButton_OnClick(self, button)
		TitanPanelButton_OnClick(self, button)
	end)
	window:SetScript("OnShow", function(self, button)
		RepairShow(self)
	end)
	window:SetScript("OnHide", function(self, button)
		RepairHide(self)
	end)
	end

-- Create needed Repair plugin frames here on load rather than in XML.
Create_Frames() 
