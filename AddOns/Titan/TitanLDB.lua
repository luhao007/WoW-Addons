--[===[ File
A "bridge" module to ensure proper registration and communication of LDB plugins with Titan Panel
--]===]

--[===[ Var Titan LDB overview
Titan implements the LDB spec: https://github.com/tekkub/libdatabroker-1-1
LDB (libdatabroker) is a small library that enables an addon to hook into a 'display' addon such as Titan.

--- Creation
The addon dev creates an LDB object which the lib places in storage accessible by lib:DataObjectIterator().
It also fires a "LibDataBroker_DataObjectCreated" callback.

The LDB addon may declare scripts (tooltip, mouse clicks, etc.) per the spec for the display addon to use.

--- Starting from Titan view
On PLAYER_ENTERING_WORLD, Titan will use the iterator to transform each LDB type addon into a Titan plugin.
Titan registers for callbacks on text and icon updates - depending on the LDB type.

Once done, Titan registers for the callback to handle LDB objects created later or on demand.

--- Running from Titan view
The LDB addon is responsible for setting and changing its text and icon.
When an LDB addon changes one of its values, the lib fires a callback for the display addon.
Titan is responsible for updating the Titan plugin in response.

The Titan plugin will use the LDB addon scripts IF declared.

--- Supported
Only LDB types listed in the LDB 1.1 spec are supported by Titan.

- "launcher" become "icon" plugins - TitanPanelIconTemplate
	type* - "launcher"
	icon* - always shown
	OnClick* -
	label^ -
	right side^ - default
	tocname
- "data source" become "combo" plugins - TitanPanelComboTemplate
	type* - "data source"
	icon^ -
	OnClick -
	text*^ - or value & suffix
	value -
	suffix -
	label^ -
	OnEnter -
	OnLeave -
	tooltip - Frame should NOT be type GameTooltip!!!!
	OnTooltipShow -

* required by LDB spec
^ Titan user controlled show / hide

--]===]

local xcategories = {
	-- Titan categories mapping to match addon metadata information
	["Combat"] = "Combat",
	["General"] = "General",
	["Information"] = "Information",
	["Interface"] = "Interface",
	["Profession"] = "Profession",
	-- Ace2 table mapping to Titan categories in order to match
	-- addon metadata information
	["Action Bars"] = "Interface",
	["Auction"] = "Information",
	["Audio"] = "Interface",
	["Battlegrounds/PvP"] = "Information",
	["Buffs"] = "Information",
	["Chat/Communication"] = "Interface",
	["Druid"] = "Information",
	["Hunter"] = "Information",
	["Mage"] = "Information",
	["Paladin"] = "Information",
	["Priest"] = "Information",
	["Rogue"] = "Information",
	["Shaman"] = "Information",
	["Warlock"] = "Information",
	["Warrior"] = "Information",
	["Healer"] = "Information",
	["Tank"] = "Information",
	["Caster"] = "Information",
	--	["Combat"] = "Combat",
	["Compilations"] = "General",
	["Data Export"] = "General",
	["Development Tools "] = "General",
	["Guild"] = "Information",
	["Frame Modification"] = "Interface",
	["Interface Enhancements"] = "Interface",
	["Inventory"] = "Information",
	["Library"] = "General",
	["Map"] = "Interface",
	["Mail"] = "Information",
	["Miscellaneous"] = "General",
	["Misc"] = "General",
	["Quest"] = "Information",
	["Raid"] = "Information",
	["Tradeskill"] = "Profession",
	["UnitFrame"] = "Interface",
}
local LAUNCHER = "launcher"
local DATA_SOURCE = "data source"
local SupportedDOTypes = { DATA_SOURCE, LAUNCHER } -- in the 1.1 spec
-- "macro" : this was attempted but Blizzard locked most macro to 'user click only'.
-- By adding a Titan template to any secure button, WoW thinks it could be a bot and errors.

-- constants & variables
local CALLBACK_PREFIX = "LibDataBroker_AttributeChanged_"
local _G = getfenv(0);

-- Create control frame so we can get events
-- RegisterCallback assumes the method called is ON the frame (self) passed
-- The IDE assumes RegisterCallback method is a string <sigh>
local LDBToTitan = CreateFrame("Frame", "LDBTitan")

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local LibQTip = nil
-- generic icon in case the DO does not provide one
local iconTitanDefault = "Interface\\PVPFrame\\PVP-ArenaPoints-Icon"

-- Events we want 
LDBToTitan:RegisterEvent("PLAYER_LOGIN")

---local Add scripts and info to plugin frame for tooltip processsing.
---@param frame table Titan frame created for LDB object
local function GenTooltipScripts(frame)
	local dbg_msg = "LDB-TT "
	dbg_msg = dbg_msg .. tostring(frame.registry.id)

	--[[ Note on Tooltips: 
	The LDB spec is unclear on priority of method to choose!
	The methods include
	-- .tooltip : Implies LDB will handle update and hide of tooltip frame; dislay addon will handle placement and show only
	-- OnTooltipShow : Display addon sends a blank GameTooltip type frame to be filled; 
	dislay addon will handle placement and show / hide
	-- OnEnter / OnLeave : Implies LDB is taking full control of tooltip; 
	dislay addon will call when cursor enters / leaves LDB 'button'


	2026 Mar :
	The 'secret' value changes made in Midnight (12.0.0) caused errors in Titan and 3rd part Titan plugins.
	Titan needed to use its own tooltip based on the same template as GameTooltip.
	We realized this was the same as the LDB OnTooltipShow method so
	this routine was rewritten to share tooltip processing with Titan.
	
	New registry attributes were added to make implicit agreements with plugins and LDB objects.
	.tooltip ==> .registry.tooltipDisplayFrame
	.OnTooltipShow ==> .registry.tooltipTemplateFunction

	Another change was always create the OnEnter and OnLeave scripts on the Titan LDB plugin. 
	If the LDB OnEnter or OnLeave script does not exist, Titan calls its own OnEnter / OnLeave.
	This is how Titan implements using only one tooltip method with priority being 
	1) OnEnter / Leave
	2) .tooltip
	3) .OnTooltipShow
	We believe this meets the intent of the LDB spec and gives developers the flexability they need.

	Example: The data object example in the LDB spec sets OnEnter and OnLeave. OnEnter uses OnTooltipShow.
	Titan will only call the LDB OnEnter and ignore the OnTooltipShow.


	Also always created are OnClick and OnDoubleClick although Titan does not call its respective routines.

	Always creating these scripts may use a few more cycles but removes the need for callbacks and still
	allows the LDB to update its scripts as needed.
	Titan will use the updated script for the next On* call.
	--]]

	-- Technically the spec states only a data source can have .tooltip and .OnTooltipShow
	-- but the original development allowed them to exist if the LDB dev added them.
	if frame.ldb_obj.tooltip then
		dbg_msg = dbg_msg .. " | tooltip"
		frame.registry.tooltipDisplayFrame = frame.ldb_obj.tooltip
	else
		-- not on LDB
	end
	if frame.ldb_obj.OnTooltipShow then
		dbg_msg = dbg_msg .. " | OnTooltipShow"
		frame.registry.tooltipTemplateFunction = frame.ldb_obj.OnTooltipShow
	else
		-- not on LDB
	end

	-- OnEnter
	-- Technically a launcher does not have OnEnter / Onleave but the original developer
	-- allowed them to exist if the LDB dev added them.
	-- If they do not exist, Titan takes no action.
	frame:SetScript("OnEnter", function(self)
		-- Per the spec, tooltip preferred order is:
		-- tooltip > OnEnter/OnLeave > OnTooltipShow.
		if self.registry.tooltipDisplayFrame then
			TitanPanelButton_OnEnter(self) -- Use the .tooltip as is
		elseif self.ldb_obj.OnEnter then
			self.ldb_obj.OnEnter(self) -- Plugin will control all aspects
		elseif self.registry.tooltipTemplateFunction then
			TitanPanelButton_OnEnter(self) -- Pass a Titan tooltip to be filled by plugin
		else
			-- No recognized tooltip method, move on...
		end

		-- Dropped Ace Tablet-2.0 lib as of 2025 Sep; last updated 2008 Sep

		-- LibQTip-1.0 support code
		LibQTip = LibStub("LibQTip-1.0", true)
		if LibQTip then
			local tt = nil
			--local key, tip
			for key, tip in LibQTip:IterateTooltips() do
				if tip then
					local _, relativeTo = tip:GetPoint()
					if relativeTo
						and relativeTo:GetName() == self:GetName() then
						tt = tip
						break
					end
				end
			end
			if tt then
				-- set transparency
				local red, green, blue, _ = tt:GetBackdropColor()
				local red2, green2, blue2, _ = tt:GetBackdropBorderColor()
				tt:SetBackdropColor(red, green, blue,
					TitanPanelGetVar("TooltipTrans"))
				tt:SetBackdropBorderColor(red2, green2, blue2,
					TitanPanelGetVar("TooltipTrans"))
			end
		end
		-- /LibQTip-1.0 support code
	end
	)

	-- OnLeave
	frame:SetScript("OnLeave", function(self)
		if self.ldb_obj.OnLeave then
			self.ldb_obj.OnLeave(self)
		else
			TitanPanelButton_OnLeave(self)
		end
	end
	)

	-- Use the OnClick given, if exists
	frame:SetScript("OnClick", function(self, button)
		if TITAN_PANEL_MOVING == 0 then -- no move in progress
			if self.ldb_obj.OnClick then
				self.ldb_obj.OnClick(self, button)
			end
		end

		--[[ 2026 Mar
			Discovered when LDB uses Blizzard_Menu system
			is set up and shown before we get here.
			So... make assumption that menus will be closed on a mouse click.

			It is conceivable that two menus could be open at the same time hopefully never ...
			--]]
	end
	)

	--
	-- OnDoubleClick is UNDOCUMENTED in the 1.1 spec
	-- but was implemented by the original developer
	--
	-- Use the OnDoubleClick, if exists
	frame:SetScript("OnDoubleClick", function(self, button)
		if TITAN_PANEL_MOVING == 0 then
			if self.ldb_obj.OnDoubleClick then
				self.ldb_obj.OnDoubleClick(self, button)
			end
		end
	end
	)

	Titan_Debug.Out('titan', 'ldb_setup', dbg_msg);
end

---Titan Update Titan button
---@param name string Plugin id name for LDB
---@return string label
---@return string value
local function UpdateButton(name)
	-- Set 'label1' and 'value1' for the Titan button display
--	local nametrim = string.gsub(name, "LDBT_", "");
--	local fontstring = _G[TitanUtils_ButtonName(nametrim) .. TITAN_PANEL_TEXT];
	local separator = ": "
	local lab1, val1 = "", ""
	local plugin = TitanUtils_GetPlugin(name)
	local ldb = plugin and plugin.LDBVariables

	if ldb then -- sanity check
		-- Check for display label
		if TitanGetVar(name, "ShowLabelText") then
			lab1 = (ldb.label or "")
		else
			lab1 = ""
		end

		if lab1 == "" then
			-- leave alone
		else
			lab1 = lab1 .. separator
		end

		-- Check for display text
		-- .text is required to show
		-- .value is the text of the value - 100.0 in 100.0 FPS
		-- .suffix is the text after the value - FPS in 100.0 FPS
		-- This has been 'broken' for ages... 
		-- not sure value / suffix were ever used...
		if TitanGetVar(name, "ShowRegularText") then
			val1 = (ldb.text or "")
		else
			val1 = ""
		end
	else
		-- return values will be empty strings
	end

	if lab1 == "" then
		-- just empty
	else
		lab1 = TitanUtils_GetNormalText(lab1)
	end
	if val1 == "" then
		-- just empty
	else
		val1 = TitanGetVar(name, "ShowColoredText")
			and TitanUtils_GetGreenText(val1) or TitanUtils_GetHighlightText(val1)
	end
	return lab1, val1
end

---local Create a Titan plugin from the LDB DO (Data Object)
--- This is the heart of the LDB to Titan. It reads the LDB DO (Data Object) and creates a Titan plugin.
--- This takes a stricter interpretation of the LDB 1.1 spec rather than guessing what LDB addon developers intended.
---@param self table LDB frame
---@param name_str string LDB id name
---@param obj table LDB data object
local function TitanLDBCreateObject(self, name_str, obj)
	local name = name_str
	Titan_Debug.Out('titan', 'ldb_setup', tostring(name) .. " : Attempting to register ");

	-- couple sanity checks
	--	if not obj or not name then
	if name and type(name) == 'string' then
		-- The name should be reasonable
	else
		local issue = "LDB request name "
			.. " '" .. tostring(name) .. "'"
			.. " unrecognizable !!!!"
		Titan_Debug.Out('titan', 'ldb_setup', issue);
		error(issue) -- get out
	end
	if obj and type(obj) == 'table' then
		-- The LDB obj should be reasonable
	else
		local object = ""
		if obj then
			object = "is not a table"
		else
			object = "does not exist"
		end
		local issue = "LDB request object for "
			.. " '" .. tostring(name) .. "'"
			.. " " .. tostring(object) .. ""
			.. "  !!!!"
		Titan_Debug.Out('titan', 'ldb_setup', issue);
		error(issue) -- get out
	end

	-- anything to pass to the developer / user
	local notes = ""

	-- sanity check for supported types
	obj.type = obj.type or "Unknown"
	local supported = false -- assume failure
	for idx in ipairs(SupportedDOTypes) do
		if obj.type and obj.type == SupportedDOTypes[idx] then
			supported = true
		end
	end
	if supported then
		-- all is good - continue plugin creation
	else
		-- Create enough of a plugin to tell the user / developer
		-- that this plugin failed miserably
		local issue = "Unsupported LDB type '" .. tostring(obj.type) .. "'"
		Titan_Debug.Out('titan', 'ldb_setup', TITAN_REGISTER_FAILED .. " " .. issue);
		error(issue)
		--		return TITAN_REGISTER_FAILED -- get out, there is nothing more that can be done
	end

	--
	-- Handle the display attributes of the DO and register the appropriate callbacks
	--
	-- Init the display elements of the plugin
	local ldb__label = obj.label or ""
	local ldb__suffix = obj.suffix or ""
	local ldb__value = obj.value or ""
	local ldb__text = obj.text or ""
	local ldb__icon = obj.icon or iconTitanDefault

	-- if .icon exists honor it and assume the addon may change it
	if obj.icon then
		ldb.RegisterCallback(self,
			CALLBACK_PREFIX .. name .. "_icon", "TitanLDBIconUpdate")
	end

	-- LAUNCHER text display elements
	if obj.type == LAUNCHER then
		if obj.label then
			ldb.RegisterCallback(self,
				CALLBACK_PREFIX .. name .. "_label", "TitanLDBTextUpdate")
		elseif obj.text then
			-- This is a 'be nice' check. It technically violates the 1.1 spec.
			-- Blank the .text so the rest of the routines work
			ldb__label = obj.text
			obj.text = ""
			ldb.RegisterCallback(self,
				CALLBACK_PREFIX .. name .. "_text", "TitanLDBTextUpdate")
			notes = notes .. "\n"
				.. "This is a LDB '" .. LAUNCHER
				.. "' without .label using .text instead!!!!"
		end
	end
	if Titan__InitializedPEW then
		notes = notes .. "\n"
			.. "Will be registered as single LDB plugin after the normal registration."
	end
	-- DATA_SOURCE text display elements
	if obj.type == DATA_SOURCE then
		-- .text so always allow it
		ldb.RegisterCallback(self,
			CALLBACK_PREFIX .. name .. "_text", "TitanLDBTextUpdate")
		if obj.label then
			ldb.RegisterCallback(self,
				CALLBACK_PREFIX .. name .. "_label", "TitanLDBTextUpdate")
		end
		if obj.suffix then
			ldb.RegisterCallback(self,
				CALLBACK_PREFIX .. name .. "_suffix", "TitanLDBTextUpdate")
		end
		if obj.value then
			ldb.RegisterCallback(self,
				CALLBACK_PREFIX .. name .. "_value", "TitanLDBTextUpdate")
		end
	end

	--
	-- These are icon extensions listed within the 1.1 spec
	--
	-- support for iconCoords, iconR, iconG, iconB attributes
	-- Due to the callbacks being fired these can easily affect
	-- performance, BEWARE when using them !
	--
	-- capture the icon coords & color for the Titan plugin
	if obj.iconCoords then
		self:TitanLDBIconUpdate(nil, name, "iconCoords", obj.iconCoords, obj)
		ldb.RegisterCallback(self,
			CALLBACK_PREFIX .. name .. "_iconCoords", "TitanLDBIconUpdate")
	end
	if obj.iconR and obj.iconG and obj.iconB then
		self:TitanLDBIconUpdate(nil, name, "iconR", obj.iconR, obj)
		ldb.RegisterCallback(self,
			CALLBACK_PREFIX .. name .. "_iconR", "TitanLDBIconUpdate")
		ldb.RegisterCallback(self,
			CALLBACK_PREFIX .. name .. "_iconG", "TitanLDBIconUpdate")
		ldb.RegisterCallback(self,
			CALLBACK_PREFIX .. name .. "_iconB", "TitanLDBIconUpdate")
	end

	--
	-- Setup the Titan plugin for this LDB addon
	--

	-- Create the appropriate Titan registry for the DO
	local registry = {
		id = name,
		ldb = tostring(obj.type),
		-- per 1.1 spec if .label exists use it else use data object's name
		menuText = obj.label or name,
		buttonTextFunction = UpdateButton,
		icon = ldb__icon,
		iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = false,
			DisplayOnRightSide = true
		},
		savedVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = true,
			ShowColoredText = false,
			DisplayOnRightSide = false
		},
		LDBVariables = {
			value = ldb__value,
			suffix = ldb__suffix,
			text = ldb__text,
			label = ldb__label,
			name = name,
			type = (obj.type or ""),
		},
		notes = notes,
		iconCoords = (obj.iconCoords or nil),
		iconR = (obj.iconR or nil),
		iconB = (obj.iconB or nil),
		iconG = (obj.iconG or nil),
	};

	Titan_Debug.Out('titan', 'ldb_setup', ""
		.. " type: '" .. tostring(registry.ldb) .. "' "
	)

	-- Set the plugin category, if it exists, else default to "General"
	-- Per the 1.1 LDB spec we check for a tocname attrib first,
	-- if found we use it, if not we assume that the DO "name"
	-- attribute is the same as the actual
	-- addon name, which might not always be the case.
	local addoncategory, addonversion;
	local tempname = obj.tocname or name;

	addoncategory = TitanUtils_GetAddOnMetadata(tempname, "X-Category");
	registry.category = (addoncategory and xcategories[addoncategory])
		or (obj.category)
		or "General"
	addonversion = TitanUtils_GetAddOnMetadata(tempname, "Version")
		or (obj.version)
		or ""
	registry["version"] = addonversion

	local notes_final = (TitanUtils_GetAddOnMetadata(tempname, "Notes") or "")
		or (obj.notes)
		or ""
	registry["notes"] = notes_final .. "\n" .. notes

	-- Depending on the LDB type set the control and saved Variables appropriately
	if obj.type == LAUNCHER then
		-- controls
		-- one interpretation of the LDB spec is launchers
		-- should always have an icon.
		registry["controlVariables"].ShowIcon = true;
		registry["controlVariables"].ShowRegularText = false; -- no text
		-- defaults
		registry["savedVariables"].ShowRegularText = false;
		registry["savedVariables"].DisplayOnRightSide = true; -- start on right side
	end

	if obj.type == DATA_SOURCE then
		-- controls
		registry["controlVariables"].ShowRegularText = true;
		-- defaults
		registry["savedVariables"].ShowRegularText = true;
	end

	--
	-- Create the Titan frame for this LDB addon
	-- Titan _OnLoad will be used to request the plugin be registered by Titan (Template)
	local newTitanFrame -- a frame
	newTitanFrame = CreateFrame("Button",
		TitanUtils_ButtonName(name),
		UIParent, "TitanPanelComboTemplate")

	newTitanFrame.TitanCreatedBy = "LDB"
	newTitanFrame.TitanName = (name or "?")
	newTitanFrame.TitanAction = (obj.commandtext or "None")

	newTitanFrame.registry = registry
	newTitanFrame.ldb_obj = obj -- attach for processing within scripts and Titan
	newTitanFrame:SetFrameStrata("FULLSCREEN");
	newTitanFrame:SetToplevel(true);
	newTitanFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	GenTooltipScripts(newTitanFrame) -- See notes in this routine for details

	local pew = "event"
	if Titan__InitializedPEW then
		pew = "post event"
		-- Plugins have already been registered and loaded
		-- Get this one loaded
		-- This works because the .registry is now set
		TitanUtils_RegisterPluginList()
		TitanVariables_SyncSinglePluginSettings(registry.id)
		TitanPanel_InitPanelButtons("LDB post create : "..registry.id) -- Show it...
	end
	Titan_Debug.Out('titan', 'ldb_setup', "LDB create"
		.. " " .. tostring(pew) .. ""
		.. " '" .. tostring(registry.id) .. "'"
		.. " '" .. tostring(registry.ldb) .. "'"
		.. "\n...'" .. tostring(newTitanFrame:GetName()) .. "'"
	)
	return "Success"

end

---Titan Text callback for the Titan (LDB) plugin when the LDB addon changes display text of the LDB object
---@param _ any not used
---@param name string Plugin id name for LDB
---@param attr string "value" or  "suffix" or "text" or "label"
---@param value any Should be string
---@param dataobj table LDB data object
function LDBToTitan:TitanLDBTextUpdate(_, name, attr, value, dataobj)
	-- just in case the LDB is active before Titan can register it...
	if not Titan__InitializedPEW then
		-- plugins have not been registered yet.
		return
	end
	-- This check is overkill but just in case...
	local plugin = TitanUtils_GetPlugin(name)
	local ldb = plugin and plugin.LDBVariables
	if not ldb then
		-- This plugin has not been registered
		return
	end

	-- Accept the various display elements and update the Titan plugin
	local val = tostring(value) -- be paranoid :)
	if attr == "value" then ldb.value = val end
	if attr == "suffix" then ldb.suffix = val end
	if attr == "text" then ldb.text = val end
	if attr == "label" then ldb.label = val end

	-- Now update the button with the change
	TitanPanelButton_UpdateButton(name)
end

---Titan Callback when the LDB addon changes the icon of the LDB object
---@param _ any not used
---@param name string Plugin id name for LDB
---@param attr string "icon" or  "iconCoords" or "iconR" "iconB" "iconR"
---@param value any icon : Path to icon file; iconCoords : coords
---@param dataobj table LDB data object
function LDBToTitan:TitanLDBIconUpdate(_, name, attr, value, dataobj)
	-- just in case the LDB is active before Titan can register it...
	if not Titan__InitializedPEW then
		-- no plugins are registered yet
		return
	end
	-- This check is overkill but just in case...
	local plugin = TitanUtils_GetPlugin(name)
	local ldb = plugin and plugin.LDBVariables
	if ldb then
		if attr == "icon" then
			TitanPlugins[name].icon = value;
			TitanPanelButton_SetButtonIcon(name);
		end

		-- support for iconCoords, iconR, iconG, iconB attributes
		if attr == "iconCoords" then
			TitanPanelButton_SetButtonIcon(name, value);
		end

		if attr == "iconR" or attr == "iconB" or attr == "iconG" then
			TitanPanelButton_SetButtonIcon(name, nil,
				dataobj.iconR, dataobj.iconG, dataobj.iconB);
		end
	else
		-- This plugin is not registered yet
		return
	end
end

---Titan OnEvent handler for LDBToTitan
--- Accept the LDB object to create a cooresponding Titan plugin.
---@param sender any !! Not Used !!
---@param name string LDB id name
---@param obj table LDB data object
function LDBToTitan:TitanLDBCreateObject(sender, name, obj)
	local call_success = true
	local ret_val = ""

	call_success, -- needed for pcall
	ret_val =  -- actual return values
		pcall(TitanLDBCreateObject, self, name, obj)

	if call_success then
		-- Registration request created
	else
		-- Create enough of a plugin to tell the user / developer
		-- that this plugin failed
		local plugin =
		{
			self = nil,
			button = nil,
			name = tostring(name),
			issue = ret_val,
			notes = "",
			status = TITAN_REGISTER_FAILED,
			category = "",
			plugin_type = tostring(obj.type or "LDB"),
		}
		TitanUtils_PluginFail(plugin)
	end

	Titan_Debug.Out('titan', 'ldb_setup', "LDB Create:"
		--			.." "..tostring(sender)..""
		.. " " .. tostring(name) .. ""
		.. " " .. tostring(call_success) .. ""
		.. " " .. tostring(ret_val) .. ""
	)
end

---Titan OnEvent handler for LDBToTitan
local function InitLoad()
	LDBToTitan:SetScript("OnEvent", function(self, event, ...)
		if (event == "PLAYER_LOGIN") then
			self:UnregisterEvent("PLAYER_LOGIN")
			-- Register the LDB plugins that have been created so far
			for name, obj in ldb:DataObjectIterator() do
				local call_success = true
				local ret_val = ""

				-- Just in case, catch any errors
				call_success, ret_val = pcall(TitanLDBCreateObject, self, name, obj)

				if call_success then
					-- Registration request created
				else
					-- Create enough of a plugin to tell the user / developer
					-- that this plugin failed
					local plugin =
					{
						self = nil,
						button = nil,
						name = tostring(name),
						issue = ret_val,
						notes = "",
						status = TITAN_REGISTER_FAILED,
						category = "",
						plugin_type = tostring(obj.type or "LDB"),
					}
					TitanUtils_PluginFail(plugin)
				end

				Titan_Debug.Out('titan', 'ldb_setup', "LDB"
					.. " " .. tostring(name) .. ""
					.. " " .. tostring(call_success) .. ""
					.. " " .. tostring(ret_val) .. ""
				)
			end

			-- In case a LDB plugin is created later...
			ldb.RegisterCallback(self, "LibDataBroker_DataObjectCreated", "TitanLDBCreateObject")
		end
	end
	)
end

---Titan Refresh all text & icon for LDB addons that were successfully registered
--- Ensure all the LDB buttons are updated.
--- This is called once x seconds after PEW. This helps close the gap where LDB addons set their text on their PEW event
function TitanLDBRefreshButton()
	--	TitanDebug("LDB: RefreshButton")
	for name, obj in ldb:DataObjectIterator() do
		if obj then
			local unused = nil
			LDBToTitan:TitanLDBTextUpdate(unused, name, "text", (obj.text or ""), obj)
			LDBToTitan:TitanLDBIconUpdate(unused, name, "icon", (obj.icon or iconTitanDefault), obj)
		else
			--	TitanDebug("LDB: '"..name.."' no refresh")
		end
	end
end

InitLoad()
--