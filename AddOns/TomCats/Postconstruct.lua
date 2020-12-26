local addonName, addon = ...
local L, D, E = addon.locales, addon.data, addon.events;
local SavedVariables = addon.savedVariables
local Charms = addon.charms
local U = { }
addon.U = U
function U.IsCompatibleWith(projectID)
	return WOW_PROJECT_ID == projectID
end
function U.IsClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end
function U.IsRetail()
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end
--todo: Internationalize
addon.supportedMaps = {
	[14]   = {
		name            = "TomCats-Bundled-ArathiHighlandsRares",
		title           = "TomCat's Tours: Rares of Arathi Highlands",
		zone            = "Arathi Highlands",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00012",
		backgroundColor = { 118 / 255, 18 / 255, 20 / 255, 0.80 }
	},
	[62]   = {
		name            = "TomCats-Bundled-DarkshoreRares",
		title           = "TomCat's Tours: Rares of Darkshore",
		zone            = "Darkshore",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00006",
		backgroundColor = { 68 / 255, 34 / 255, 68 / 255, 0.80 }
	},
	[1355] = {
		name            = "TomCats-Bundled-Nazjatar",
		title           = "TomCat's Tours: Nazjatar",
		zone            = "Nazjatar",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00008",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 }
	},
	[1462] = {
		name            = "TomCats-Bundled-Mechagon",
		title           = "TomCat's Tours: Mechagon",
		zone            = "Mechagon",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00007",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
	},
	[1527] = {
		name            = "TomCats-Bundled-Nzoth",
		title           = "TomCat's Tours: Uldum",
		zone            = "Uldum",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00018",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
	},
	[1530] = {
		name            = "TomCats-Bundled-Nzoth",
		title           = "TomCat's Tours: Vale of Eternal Blossoms",
		zone            = "Vale of Eternal Blossoms",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00018",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
	},
}

local slashCommandHandlers = { }
local components = { }
local function handleSlashCommand(msg)
	if (msg) then
		if (msg == "") then
			InterfaceOptionsFrame_OpenToCategory(TomCats_Config)
			--todo: Remove the redundant call if Blizzard ever fixes this
			InterfaceOptionsFrame_OpenToCategory(TomCats_Config)
		else
			local func = slashCommandHandlers[string.upper(msg)]
			if (not func) then
				InterfaceOptionsFrame_OpenToCategory(TomCats_Config_Slash_Commands)
				--todo: Remove the redundant call if Blizzard ever fixes this
				InterfaceOptionsFrame_OpenToCategory(TomCats_Config_Slash_Commands)
			else
				func()
			end
		end
	end
end
SLASH_TOMCATS1 = "/TOMCATS"
SlashCmdList["TOMCATS"] = handleSlashCommand
local slashCommandsHtmlHead = "<html>\n<body>\n<h1>Slash Commands</h1>\n<br />\n"
local slashCommandHtmlTemplate = "<h3>%s:</h3>\n<p>/TOMCATS %s</p>\n<br />\n"
local slashCommandsHtmlFoot = "</body>\n</html>"
TomCats.version = unpack(addon.split("2.0.31","-"))
local function refreshInterfaceControlPanels()
	local slashCommandsHtml = slashCommandsHtmlHead
	slashCommandsHtml = slashCommandsHtml .. format(slashCommandHtmlTemplate, "Open the TomCat's Tours Control Panel", "")
	for i, component in ipairs(components) do
		if (component.slashCommands) then
			for _, slashCommand in ipairs(component.slashCommands) do
				slashCommandsHtml = slashCommandsHtml .. format(slashCommandHtmlTemplate, slashCommand.desc,
				                                                string.upper(slashCommand.command))
			end
		end
	end
	slashCommandsHtml = slashCommandsHtml .. slashCommandsHtmlFoot
	TomCats_Config_Slash_Commands.html:SetText(slashCommandsHtml)
end
function TomCats:Register(componentInfo)
	if (componentInfo) then
		if (componentInfo.slashCommands) then
			for _, slashCommand in ipairs(componentInfo.slashCommands) do
				slashCommandHandlers[string.upper(slashCommand.command)] = slashCommand.func
			end
		end
		if (componentInfo.raresLogHandlers) then
			for k, v in pairs(componentInfo.raresLogHandlers) do
				if addon.supportedMaps[k] then
					addon.supportedMaps[k].handlers = v
				end
			end
		end
		local preexisting = false
		for i = 1, #components do
			if (components[i].name == componentInfo.name) then
				components[i] = componentInfo
				preexisting = true
			end
		end
		if (not preexisting) then
			table.insert(components, componentInfo)
		end
		refreshInterfaceControlPanels()
	end
end
local linkText = "Visions of N'zoth Rares by TomCat's Tours"
local chatStep = 1
local function playChat()
	PlaySound(SOUNDKIT.TELL_MESSAGE)
	local message
	local link = "|cffff80ff[|cffffff00" .. "TomCat from TomCat's Tours" .. "|cffff80ff]"
	if (chatStep == 1) then
		SavedVariables.account.notifications["NZOTHLAUNCH"] = true
		addon.charm.MinimapLoopPulseAnim:Stop()
		addon.charm:Hide()
		message = "|cffff80ffHi. I hope I am not intruding...I just wanted to say thanks for using my TomCat's Tours addons!|r"
	end
	if (chatStep == 2) then
		message = "|cffff80ffI thought you might be interested in trying my new addon: " .. linkText
	end
	if (chatStep == 3) then
		message = "|cffff80ffPlease check it out, and thanks for the support!"
	end
	DEFAULT_CHAT_FRAME:AddMessage(format(_G["CHAT_WHISPER_GET"] .. message, link))
	chatStep = chatStep + 1
	if (chatStep < 4) then
		C_Timer.After(2 + chatStep, playChat)
	end
end
local function ChangeMap(self)
	WorldMapFrame:SetMapID(self.mapID)
	if WorldMapFrame:IsMaximized() then
		WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:Minimize()
	end
	if not TomCatsRareMapFrame:IsShown() then
		TomCatsRarePanelToggle:OnClick()
	elseif not TomCatsRareMapFrame.RaresFrame:IsShown() then
		TomCatsRareMapFrame.DetailsFrame:Hide()
		TomCatsRareMapFrame.RaresFrame:Show()
	end
end

local function fixIconSize(self, vignetteGUID, vignetteInfo)
	if vignetteInfo and vignetteInfo.atlasName and (vignetteInfo.atlasName == "VignetteKill" or vignetteInfo.atlasName == "Capacitance-General-WorkOrderCheckmark" or vignetteInfo.atlasName == "VignetteEventElite") then
		self.Texture:SetAtlas(vignetteInfo.atlasName, false)
		self.HighlightTexture:SetAtlas(vignetteInfo.atlasName, false)
		local x, y = self.Texture:GetSize()
		self.Texture:SetSize(x * 0.8, y * 0.8)
		self.HighlightTexture:SetSize(x * 0.8, y * 0.8)
	end
end

hooksecurefunc(VignettePinMixin,"OnAcquired", fixIconSize)

local function ADDON_LOADED(_, _, arg1)
	if (arg1 == addonName) then
		addon.events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
		SavedVariables.account.preferences = SavedVariables.account.preferences or { }
		SavedVariables.account.preferences.TomCatsMinimapButton = { position = 3 }
		SavedVariables.account.notifications = SavedVariables.account.notifications or { }
		SavedVariables.account.tutorials = SavedVariables.account.tutorials or { }
		SavedVariables.character.cvars = SavedVariables.character.cvars or { }
		TomCats_Config.name = "TomCat's Tours"
		InterfaceOptions_AddCategory(TomCats_Config)
		TomCats_Config_Slash_Commands.name = "Slash Commands"
		TomCats_Config_Slash_Commands.parent = "TomCat's Tours"
		InterfaceOptions_AddCategory(TomCats_Config_Slash_Commands)
		refreshInterfaceControlPanels()
	end
end
addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
local SpawnTimerByIndex
local spawnTimer
do
	local L = addon.locales
	local U = addon.U
	if U.IsRetail() then
		local supportedMaps, RaresLogFrame_ShowRareDetails
		local DISPLAY_STATE_CLOSED = 1
		local DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG = 2
		local DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG = 3
		local DISPLAY_STATE_OPEN_MAXIMIZED = 4
		local DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG = 5
		local lastDisplayStates = { DISPLAY_STATE_CLOSED, DISPLAY_STATE_CLOSED }
		local function setLastDisplayState(displayState)
			lastDisplayStates[1] = lastDisplayStates[2]
			lastDisplayStates[2] = displayState
		end
		local CREATURE_STATUS = {
			COMPLETE              = 0,
			HIDDEN                = 1,
			UNAVAILABLE           = 2,
			LOOT_ELIGIBLE         = 3,
			BONUS_ROLL_ELIGIBLE   = 4,
			WORLD_QUEST_AVAILABLE = 5
		}
		local function SidePanelToggle_Refresh()
			if TomCatsRareMapFrame:IsShown() or not QuestMapFrame:IsShown() then
				WorldMapFrame.SidePanelToggle.OpenButton:Show()
				WorldMapFrame.SidePanelToggle.CloseButton:Hide()
			else
				WorldMapFrame.SidePanelToggle.OpenButton:Hide()
				WorldMapFrame.SidePanelToggle.CloseButton:Show()
			end
		end
		TomCatsLayoutIndexManagerMixin = {}
		function TomCatsLayoutIndexManagerMixin:AddManagedLayoutIndex(key, startingIndex)
			if (not self.managedLayoutIndexes) then
				self.managedLayoutIndexes = {};
				self.startingLayoutIndexes = {};
			end
			self.managedLayoutIndexes[key] = startingIndex;
			self.startingLayoutIndexes[key] = startingIndex;
		end
		function TomCatsLayoutIndexManagerMixin:GetManagedLayoutIndex(key)
			if (not self.managedLayoutIndexes or not self.managedLayoutIndexes[key]) then
				return 0;
			end
			local layoutIndex = self.managedLayoutIndexes[key];
			self.managedLayoutIndexes[key] = self.managedLayoutIndexes[key] + 1;
			return layoutIndex;
		end
		function TomCatsLayoutIndexManagerMixin:Reset()
			for k, _ in pairs(self.managedLayoutIndexes) do
				self.managedLayoutIndexes[k] = self.startingLayoutIndexes[k];
			end
		end
		function TomCatsCreateLayoutIndexManager()
			return CreateFromMixins(TomCatsLayoutIndexManagerMixin);
		end
		TomCatsRareLogMixin = {}
		function TomCatsRareLogMixin:InitLayoutIndexManager()
			self.layoutIndexManager = TomCatsCreateLayoutIndexManager()
			self.layoutIndexManager:AddManagedLayoutIndex("RaresLog", 3)
		end
		local raresLog
		local function CheckForUpdatedRaresLog()
			if raresLog and raresLog.updated then
				TomCatsRareMapFrame:RefreshRaresLog()
				raresLog.updated = nil
			end
		end
		C_Timer.NewTicker(0.2, CheckForUpdatedRaresLog)
		local RareTextColorLookup = {
			[CREATURE_STATUS.COMPLETE]      = { QuestDifficultyColors["standard"], QuestDifficultyHighlightColors["standard"] },
			[CREATURE_STATUS.LOOT_ELIGIBLE] = { QuestDifficultyHighlightColors["header"], QuestDifficultyHighlightColors["difficult"] },
			[CREATURE_STATUS.UNAVAILABLE]   = { QuestDifficultyColors["impossible"], QuestDifficultyHighlightColors["impossible"] },
		}
		local RareButtonLookup = {
			[CREATURE_STATUS.COMPLETE]      = "Complete",
			[CREATURE_STATUS.LOOT_ELIGIBLE] = "Incomplete",
			[CREATURE_STATUS.UNAVAILABLE]   = "Unavailable",
		}
		local LOOT_NOUN_COLOR = CreateColor(1.0, 0.82, 0.0, 1.0)
		local PIN_SHARING = string.gsub(MAP_PIN_SHARING_TOOLTIP,".*|c","|c")
		local rareCreaturesLogTimeFormatter = "%dh %02dm"
		local function ClickRareLogEntry(self)
			if (IsShiftKeyDown()) then
				local linktemplate = "|cffffff00|Hworldmap:%s:%s:%s|h[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a Map Pin Location]|h|r %s %s"
				local location = self.creature["Location"] or self.creature["Locations"][raresLog.locationIndex]
				if (location) then
					local timerText = ""
					--local timerText
					--if (raresLog and raresLog.zone == 118) then
					--	local seconds = SpawnTimerByIndex(self.creature["Spawn Index"])
					--	if (seconds > (20 * spawnTimer - spawnTimer)) then
					--		timerText = "up now"
					--	else
					--		local foundPin
					--		for pin in WorldMapFrame:EnumeratePinsByTemplate("VignettePinTemplate") do
					--			if (pin.vignetteID and pin.vignetteID == self.creature["Vignette ID"]) then
					--				if (pin:IsShown() and pin.Texture:GetAtlas() == "nazjatar-nagaevent") then
					--					foundPin = pin
					--				end
					--			end
					--		end
					--		if (foundPin) then
					--			timerText = "up now"
					--		else
					--			local hours = math.floor(seconds / 3600);
					--			local minutes = math.floor((seconds % 3600) / 60);
					--			seconds = seconds % 60
					--			timerText = " in " .. rareCreaturesLogTimeFormatter:format(hours, minutes)
					--		end
					--	end
					--else
					--	timerText = ""
					--end
					local link = string.format(linktemplate,WorldMapFrame:GetMapID(),math.floor(location[1] * 10000),math.floor(location[2] * 10000),self.creature["Name"], timerText)
					if (IsControlKeyDown()) then
						ChatEdit_InsertLink(link)
					else
						SendChatMessage(link, "CHANNEL", nil, 1)
					end
				end
			elseif (IsControlKeyDown() and TomTom) then
				local playerMapID = C_Map.GetBestMapForUnit("player")
				local pinMapID = WorldMapFrame:GetMapID()
				if (pinMapID == playerMapID) then
					if (lastWaypoint) then
						TomTom:RemoveWaypoint(lastWaypoint)
					end
					local location = self.creature["Location"] or self.creature["Locations"][raresLog.locationIndex]
					if location then
						lastWaypoint = TomTom:AddWaypoint(WorldMapFrame:GetMapID(), location[1], location[2], {
							title      = self.creature["Name"],
							persistent = false,
							minimap    = true,
							world      = true
						})
					end
				end
			elseif (IsControlKeyDown()) then
				ChatFrame1:AddMessage(("|cffff0000%s|r"):format(L["Must have TomTom"]))
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				TomCatsRareMapFrame.RaresFrame:Hide()
				RaresLogFrame_ShowRareDetails(self.creature)
			end
		end

		local function ShowRareLogEntryTooltip(self, tooltipParent)
			local creature = self.creature or self:GetParent().creature
			local creatureName
			if (creature) then
				creatureName = creature["Name"]
			end
			if (not creatureName) then return end
			tooltipParent = tooltipParent or self
			EmbeddedItemTooltip:ClearAllPoints()
			EmbeddedItemTooltip:SetOwner(tooltipParent, "ANCHOR_PRESERVE")
			EmbeddedItemTooltip:SetPoint("TOPLEFT", tooltipParent, "TOPRIGHT", -55, 0)
			local color = WORLD_QUEST_QUALITY_COLORS[1]
			EmbeddedItemTooltip:SetText(creatureName , color.r, color.g, color.b)
			local tooltipWidth = 20 + max(231, EmbeddedItemTooltipTextLeft1:GetStringWidth())
			if (tooltipWidth > UIParent:GetRight() - QuestMapFrame:GetParent():GetRight()) then
				EmbeddedItemTooltip:ClearAllPoints()
				EmbeddedItemTooltip:SetPoint("TOPRIGHT", tooltipParent, "TOPLEFT", -34, 0)
				EmbeddedItemTooltip:SetOwner(tooltipParent, "ANCHOR_PRESERVE")
				EmbeddedItemTooltip:SetText(creatureName, color.r, color.g, color.b)
			end
			local footerText
			if (TomTom) then
				footerText = ("|cff00ff00<%s>|r"):format(L["Click to view creature details"]) .. "\n\n" ..
						("|cff00ff00<%s>|r"):format(L["Control-Click TomTom"]) .. "\n\n" .. PIN_SHARING
			else
				footerText = ("|cff00ff00<%s>|r"):format(L["Click to view creature details"]) .. "\n\n" ..
						("|cff999999<%s>|r"):format(L["Control-Click TomTom"]) .. "\n\n" .. PIN_SHARING
			end
			if (creature["Loot"]) then
				local itemID
				if type(creature["Loot"]) == "table" then
					if creature["Loot"].items then
						itemID = creature["Loot"].items[1]
						if #(creature["Loot"].items) > 1 then
							footerText = ("+ %d more items\n\n" .. footerText):format(#(creature["Loot"].items) - 1)
						end
					end
				else
					itemID = creature["Loot"]
				end
				if itemID then
					GameTooltip_AddBlankLinesToTooltip(EmbeddedItemTooltip, 1)
					GameTooltip_AddColoredLine(EmbeddedItemTooltip, LOOT_NOUN, LOOT_NOUN_COLOR, true)
					EmbeddedItemTooltip_SetItemByID(EmbeddedItemTooltip.ItemTooltip, itemID)
					--if (raresLog and raresLog.zone == 118) then
					--	C_Timer.NewTimer(0, function()
					--		local ilevelText = EmbeddedItemTooltipTooltipTextLeft2:GetText()
					--		if (ilevelText) then
					--			EmbeddedItemTooltipTooltipTextLeft2:SetText(string.gsub(ilevelText, "100","110"))
					--		end
					--	end)
					--end
				end
			end
			EmbeddedItemTooltip.BottomFontString:SetText(footerText)
			EmbeddedItemTooltip.BottomFontString:SetShown(true)
			EmbeddedItemTooltip:Show()
		end

		function TomCatsRareLogTitleButton_OnClick(self)
			ClickRareLogEntry(self)
		end

		function TomCatsRareLogTitleButton_OnMouseDown(self)
			local anchor, _, _, x, y = self.Text:GetPoint()
			self.Text:SetPoint(anchor, x + 1, y - 1)
		end

		function TomCatsRareLogTitleButton_OnMouseUp(self)
			local anchor, _, _, x, y = self.Text:GetPoint()
			self.Text:SetPoint(anchor, x - 1, y + 1)
		end

		function TomCatsRareLogTitleButton_OnEnter(self)
			local creature = self.creature
			local textColor = RareTextColorLookup[creature["Status"]][2]
			self.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
			ShowRareLogEntryTooltip(self)
			local foundPin
			for pin in WorldMapFrame:EnumeratePinsByTemplate("VignettePinTemplate") do
				if (pin.vignetteID and pin.vignetteID == self.creature["Vignette ID"]) then
					if (pin:IsShown()) then
						foundPin = pin
					end
				end
			end
			if (foundPin) then
				self.pin = foundPin
				foundPin.Texture:SetBlendMode("ADD")
				local x, y = foundPin.Texture:GetSize()
				foundPin.Texture:SetSize(x * 1.5, y * 1.5)
			end
		end
		function TomCatsRareLogTitleButton_OnLeave(self)
			if (self.pin) then
				self.pin.Texture:SetBlendMode("BLEND")
				local x, y = self.pin.Texture:GetSize()
				self.pin.Texture:SetSize(x / 1.5, y / 1.5)
			end
			local textColor = RareTextColorLookup[self.creature["Status"]][1]
			self.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
			EmbeddedItemTooltip:Hide()
		end
		function TomCatsRareRewardItem_OnEnter(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetItemByID(self:GetID())
			--if (raresLog and raresLog.zone == 118) then
			--	GameTooltip:SetHyperlink("item:" .. self:GetID() .. "::::::::100:268::3:1:631")
			--else
			--	GameTooltip:SetItemByID(self:GetID())
			--end
			GameTooltip:Show()
			CursorUpdate(self);
			self.UpdateTooltip = TomCatsRareRewardItem_OnEnter;
		end
		function TomCatsRareRewardItem_OnClick(self)
			if (IsModifiedClick() and self.objectType == "item") then
				local _, itemLink = GetItemInfo(self:GetID())
				HandleModifiedItemClick(itemLink)
			end
		end

		do
			spawnTimer = 600

			local eventStarts = {
				[1] = 1605054000 + 120, -- NA
				[2] = 1605054000 + 120 - spawnTimer * 12, -- KR
				[3] = 1605097200 + 120, -- EU
				[4] = 1605054000 + 120 - spawnTimer * 12, -- TW
				[5] = 1605054000 + 120 - spawnTimer * 12, -- CN
			}

			local eventStartsTime

			local function EventStartTime()
				if (not eventStartsTime) then
					eventStartsTime = eventStarts[GetCurrentRegion()] or eventStarts[1]
				end
				return eventStartsTime
			end

			local function NextSpawnInfo()
				local servertime = GetServerTime()
				local elapsed = servertime - EventStartTime() + spawnTimer
				local quotient = elapsed % (20 * spawnTimer)
				local index = math.floor(quotient / spawnTimer)
				local remaining = spawnTimer - quotient % spawnTimer
				return index + 1, remaining
			end

			function SpawnTimerByIndex(index)
				local nextIndex, nextRemaining = NextSpawnInfo()
				if (nextIndex == index) then
					return nextRemaining
				end
				if (index > nextIndex) then
					return nextRemaining + (index - nextIndex) * spawnTimer
				end
				return nextRemaining + (20 - nextIndex + index) * spawnTimer
			end
			function TomCatsRareLogMixin:RefreshRaresLog()
				self.titleFramePool:ReleaseAll()
				self.poiFramePool:ReleaseAll()
				local lastButton
				if (raresLog) then
					if not raresLog.isSorted then
						raresLog.isSorted = true
						raresLog.creatures_sorted = { }
						local rareNames = { }
						local lookupByName = { }
						for _, v in pairs(raresLog.creatures) do
							local name = v["Name"]
							if not name then
								raresLog.isSorted = false
							else
								table.insert(rareNames, name)
								lookupByName[name] = v
							end
						end
						table.sort(rareNames)
						for _, v in ipairs(rareNames) do
							table.insert(raresLog.creatures_sorted, lookupByName[v])
						end
					end
					for _, creature in pairs(raresLog.creatures_sorted) do
						if creature["Status"] ~= CREATURE_STATUS.HIDDEN then
							local button = self.titleFramePool:Acquire()
							button.creature = creature
							button.Text:SetText(creature["Name"])
							button.Timer:Hide()
							--if (raresLog and raresLog.zone == 118) then
							--	local seconds = SpawnTimerByIndex(creature["Spawn Index"])
							--	if (seconds > (20 * spawnTimer - spawnTimer)) then
							--		button.Timer:SetText("NOW")
							--	else
							--		local hours = math.floor(seconds / 3600);
							--		local minutes = math.floor((seconds % 3600) / 60);
							--		seconds = seconds % 60
							--		button.Timer:SetText(rareCreaturesLogTimeFormatter:format(hours, minutes))
							--	end
							--	button.Timer:Show()
							--else
							--	button.Timer:Hide()
							--end
							local textColor = RareTextColorLookup[creature["Status"]][1]
							button.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
							button:ClearAllPoints()
							if (lastButton) then
								button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -4)
							else
								button:SetPoint("TOPLEFT", self.RaresFrame.Contents.StoryHeader, "BOTTOMLEFT", 29, -8)
							end
							lastButton = button
							button:Show()
							local poiButton = self.poiFramePool:Acquire()
							poiButton:ClearAllPoints()
							poiButton:SetPoint("LEFT", button, -21, 2)
							poiButton.parent = button
							poiButton:SetFrameLevel(button:GetFrameLevel() + 1)
							poiButton:Show()
							poiButton.creature = creature
							for key, value in pairs(RareButtonLookup) do
								if (key == creature["Status"]) then
									poiButton[value]:Show()
								else
									poiButton[value]:Hide()
								end
							end
						end
					end
				end
			end

		end
		function TomCatsRareLogMixin:Refresh()
			self.RaresFrame.Contents.LogHeader.Text:SetText(L["Rare Creatures Log"])
			self.RaresFrame.Contents.LogHeader:Show()
			self.RaresFrame.Contents.LogHeader.Location:SetText(C_Map.GetMapInfo(WorldMapFrame:GetMapID())["name"])
			-- todo: Remove this hardcode
			--if (WorldMapFrame:GetMapID() == 118) then
			--	self.RaresFrame.Contents.LogHeader.Location:SetText(C_Map.GetMapInfo(WorldMapFrame:GetMapID())["name"] .. " (in spawn order)")
			--else
			--	self.RaresFrame.Contents.LogHeader.Location:SetText(C_Map.GetMapInfo(WorldMapFrame:GetMapID())["name"])
			--end
			self.layoutIndexManager:Reset()
			self:RefreshRaresLog()
			self.RaresFrame.Contents:Layout()
		end
		function TomCatsRareLogMixin:SetShown()
			if not self:IsShown() then
				self:Show()
				self.DetailsFrame:Hide()
				self.RaresFrame:Show()
				local handlers = supportedMaps[WorldMapFrame:GetMapID()].handlers
				if handlers and handlers.raresLog then
					raresLog = handlers.raresLog()
					raresLog.locationIndex = raresLog.locationIndex or 1
				else
					raresLog = nil
				end
			end
		end
		local function GetSupportedMap(mapID)
			local supportedMap = supportedMaps[WorldMapFrame:GetMapID()]
			if (supportedMap) then
				if (IsAddOnLoaded(supportedMap.name)) then
					return supportedMap
				end
			end
		end

		function TomCatsRareLogMixin:UpdateDisplayState()
			local supportedMap = GetSupportedMap(WorldMapFrame:GetMapID())
			if not WorldMapFrame:IsShown() then
				setLastDisplayState(DISPLAY_STATE_CLOSED)
			elseif QuestMapFrame:IsShown() or QuestMapFrame.DetailsFrame:IsShown() then
				if QuestMapFrame.DetailsFrame:IsShown() then
					self:Hide()
					QuestScrollFrame:Hide()
				else
					if supportedMap and SavedVariables.character.preferQuestLog == nil then
						self:SetShown(true)
						QuestScrollFrame:Hide()
						self:Refresh()
						setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG)
						return
					end
					QuestScrollFrame:Show()
				end
				setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
			else
				if WorldMapFrame:IsMaximized() then
					setLastDisplayState(DISPLAY_STATE_OPEN_MAXIMIZED)
				else
					setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG)
				end
			end
			self:Hide()
		end
		function TomCatsRareMapFrame_OnLoad(self)
			self:InitLayoutIndexManager()
			self.titleFramePool = CreateFramePool("BUTTON", TomCatsRareMapFrame.RaresFrame.Contents,
			                                      "TomCatsRareLogTitleTemplate")
			self.poiFramePool = CreateFramePool("FRAME", TomCatsRareMapFrame.RaresFrame.Contents,
			                                    "TomCatsRarePOITemplate")
		end
		function TomCatsRareMapFrame_OnEvent()
		end
		do
			local ticker
			function TomCatsRareMapFrame_OnShow()
				ticker = C_Timer.NewTicker(10, function()
					TomCatsRareMapFrame:RefreshRaresLog()
				end)
			end
			function TomCatsRareMapFrame_OnHide()
				if (ticker) then
					ticker:Cancel()
				end
			end
		end
		local lastMapID = 0
		local helpPlate_override
		local function UpdateAll(_, mapID)
			if WorldMapFrame:GetMapID() ~= lastMapID then
				lastMapID = WorldMapFrame:GetMapID()
				if TomCatsRareMapFrame:IsShown() then
					local supportedMap = GetSupportedMap(WorldMapFrame:GetMapID())
					if supportedMap then
						local handlers = supportedMap.handlers
						if handlers and handlers.raresLog then
							raresLog = handlers.raresLog()
						else
							raresLog = nil
						end
						TomCatsRareMapFrame:Refresh()
					end
				end
			end
			TomCatsRareMapFrame:UpdateDisplayState()
			TomCatsRarePanelToggle:Refresh()
			SidePanelToggle_Refresh()
			if HelpPlate_IsShowing(helpPlate_override) and (WorldMapFrame:IsMaximized() or not WorldMapFrame:IsShown()) then
				HelpPlate_Hide()
			end
		end
		TomCats.UpdateAll = UpdateAll
		local function RevertToQuestFrameShown(save)
			WorldMapFrame:SetDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
			QuestScrollFrame:Show()
			TomCatsRareMapFrame:Hide()
			TomCatsRarePanelToggle:Refresh()
			SidePanelToggle_Refresh()
			setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
			if save then
				SetCVar("questLogOpen", "1")
			end
		end
		local function Hook_WorldMapFrame_SidePanelToggle()
			if GetSupportedMap(WorldMapFrame:GetMapID()) then
				SavedVariables.character.preferQuestLog = true
			end
			if (lastDisplayStates[1] == DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG and lastDisplayStates[2] == DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG) or
					(lastDisplayStates[2] == DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG and lastDisplayStates[1] == DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG) then
				RevertToQuestFrameShown(true)
			end
		end
		local function Hook_ToggleQuestLog()
			if lastDisplayStates[2] == DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG then
				RevertToQuestFrameShown()
			end
		end
		TomCatsWorldMapRareSidePanelToggleMixin = { }
		function TomCatsWorldMapRareSidePanelToggleMixin:OnClick()
			SavedVariables.character.preferQuestLog = nil
			if (self.OpenButton:IsShown()) then
				WorldMapFrame:SetDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
				QuestScrollFrame:Hide()
				TomCatsRareMapFrame:SetShown(true)
				TomCatsRareMapFrame:Refresh()
				self.OpenButton:Hide()
				self.CloseButton:Show()
				SetCVar("questLogOpen", "1")
			else
				WorldMapFrame:SetDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG)
				TomCatsRareMapFrame:Hide()
				self.OpenButton:Show()
				self.CloseButton:Hide()
				SetCVar("questLogOpen", "0")
			end
			WorldMapFrame.SidePanelToggle.OpenButton:Show()
			WorldMapFrame.SidePanelToggle.CloseButton:Hide()
		end
		function TomCatsWorldMapRareSidePanelToggleMixin:Refresh()
			if WorldMapFrame.SidePanelToggle:IsShown() and GetSupportedMap(WorldMapFrame:GetMapID()) then
				self:Show()
				if TomCatsRareMapFrame:IsShown() then
					self.OpenButton:Hide()
					self.CloseButton:Show()
				else
					self.OpenButton:Show()
					self.CloseButton:Hide()
				end
			else
				self:Hide()
			end
		end
		local function TryShowTutorial()
			if not SavedVariables.account.tutorials["Rares Log Toggle"] then
				local frame = CreateFrame("FRAME", nil, TomCatsRarePanelToggle,
				                          "TomCatsRareMapFrameTutorialBoxTemplate")
				frame:SetFrameStrata("DIALOG")
				frame:SetFrameLevel(100)
				frame.Text:SetText(L["TUTORIAL_RaresLogToggle"])
				frame.Text:SetSpacing(4)
				SetClampedTextureRotation(frame.Arrow.Arrow, 270)
				SetClampedTextureRotation(frame.Arrow.Glow, 270)
				frame.Arrow:ClearAllPoints()
				frame.Arrow:SetPoint("BOTTOMLEFT", frame, "RIGHT", -4, 4)
				frame.Arrow.Glow:ClearAllPoints()
				frame.Arrow.Glow:SetPoint("CENTER", frame.Arrow.Arrow, "CENTER", 2, 0)
				frame:ClearAllPoints()
				frame:SetPoint("RIGHT", TomCatsRarePanelToggle, "BOTTOMLEFT", -18, 0)
				local newHeight = frame.Text:GetHeight() + 48
				if 100 >= newHeight then
					newHeight = 100
				end
				frame:SetHeight(newHeight)
				frame.CloseButton:SetScript("OnClick", function()
					SavedVariables.account.tutorials["Rares Log Toggle"] = true
					frame:Hide()
				end)
				frame:Show()
			end
		end
		local function AddOverlayFrame(self, templateName, templateType, anchorPoint, relativeFrame, relativePoint,
		                               offsetX, offsetY)
			local frame = CreateFrame(templateType, nil, self, templateName)
			if anchorPoint then
				frame:SetPoint(anchorPoint, relativeFrame, relativePoint, offsetX, offsetY)
			end
			frame.relativeFrame = relativeFrame or self
			return frame
		end
		local function ADDON_LOADED(_, _, arg1)
			if (arg1 == addonName) then
				addon.events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
				CreateFrame("FRAME", "TomCatsRareMapFrame", WorldMapFrame, "TomCatsRareMapFrameTemplate")
				CreateFrame("FRAME", "TomCatsRareInfoRewardsFrame", nil, "TomCatsRareInfoRewardsFrameTemplate")
				supportedMaps = addon.supportedMaps
				TomCatsRarePanelToggle = AddOverlayFrame(WorldMapFrame, "TomCatsWorldMapRareSidePanelToggleTemplate",
				                                         "BUTTON", "BOTTOMRIGHT", WorldMapFrame:GetCanvasContainer(),
				                                         "BOTTOMRIGHT", -2, 36)
				tinsert(WorldMapFrame.overlayFrames, TomCatsRarePanelToggle)
				TryShowTutorial()
				TomCatsRareMapFrame:SetParent(WorldMapFrame)
				TomCatsRareMapFrame:SetFrameStrata("HIGH")
				TomCatsRareMapFrame:SetFrameLevel(10)
				TomCatsRareMapFrame:ClearAllPoints()
				TomCatsRareMapFrame:SetPoint("TOPRIGHT", -6, -20)
				hooksecurefunc(WorldMapFrame, "SetMapID", UpdateAll)
				hooksecurefunc(WorldMapFrame.SidePanelToggle, "OnClick", Hook_WorldMapFrame_SidePanelToggle)
				hooksecurefunc(WorldMapFrame, "SetDisplayState", UpdateAll)
				hooksecurefunc("QuestMapFrame_ShowQuestDetails", UpdateAll)
				hooksecurefunc("ToggleQuestLog", Hook_ToggleQuestLog)
				hooksecurefunc("HideUIPanel", UpdateAll)
			end
		end
		local lastWaypoint
		function TomCatsRareLogEntryIcon_OnEnter(self)
			ShowRareLogEntryTooltip(self, self:GetParent().parent)
			--GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 8, 8);
			--GameTooltip_SetTitle(GameTooltip, MAP_PIN_SHARING);
			--GameTooltip_AddNormalLine(GameTooltip, MAP_PIN_SHARING_TOOLTIP);
			--GameTooltip:Show();
			local foundPin
			for pin in WorldMapFrame:EnumeratePinsByTemplate("VignettePinTemplate") do
				if (pin.vignetteID and pin.vignetteID == self:GetParent().creature["Vignette ID"]) then
					if (pin:IsShown()) then
						foundPin = pin
					end
				end
			end
			if (foundPin) then
				self.pin = foundPin
				foundPin.Texture:SetBlendMode("ADD")
				local x, y = foundPin.Texture:GetSize()
				foundPin.Texture:SetSize(x * 1.5, y * 1.5)
			end
		end
		function TomCatsRareLogEntryIcon_OnLeave(self)
			if (self.pin) then
				self.pin.Texture:SetBlendMode("BLEND")
				local x, y = self.pin.Texture:GetSize()
				self.pin.Texture:SetSize(x / 1.5, y / 1.5)
			end
			EmbeddedItemTooltip:Hide()
			--GameTooltip:Hide()
		end
		local rareCreaturesLogTimeFormatter = "%dh %02dm"
		function TomCatsRareLogEntryIcon_OnClick(self)
			ClickRareLogEntry(self:GetParent().parent)
		end
		local REWARDS_SECTION_OFFSET = 5
		local function RareInfo_ShowRewards(creature)
			local rewardsFrame = TomCatsRareInfoRewardsFrame
			local totalRewards = 1
			local rewardButtons = rewardsFrame.RewardButtons
			for i = totalRewards, #rewardButtons do
				rewardButtons[i]:ClearAllPoints()
				rewardButtons[i]:Hide()
			end
			local rewardsCount = 0
			local lastFrame = rewardsFrame.Header
			local totalHeight = rewardsFrame.Header:GetHeight()
			local buttonHeight = rewardsFrame.RewardButtons[1]:GetHeight()
			rewardsFrame.ArtifactXPFrame:ClearAllPoints()
			rewardsFrame.ArtifactXPFrame:Hide()
			rewardsFrame.ItemChooseText:ClearAllPoints()
			rewardsFrame.ItemChooseText:Hide()
			rewardsFrame.spellRewardPool:ReleaseAll()
			rewardsFrame.followerRewardPool:ReleaseAll()
			rewardsFrame.spellHeaderPool:ReleaseAll()
			rewardsFrame.PlayerTitleText:Hide()
			rewardsFrame.TitleFrame:Hide()
			rewardsFrame.XPFrame:Hide()
			rewardsFrame.MoneyFrame:Hide()
			local loot = creature["Loot"] or {
				items = { }
			}
			if type(loot) ~= "table" then
				loot = {
					items = { loot }
				}
			end
			local numQuestRewards = 0
			if loot.items then
				numQuestRewards = #(loot.items)
			end
			local index
			local baseIndex = 0
			local buttonIndex = 0
			for i = 1, numQuestRewards, 1 do
				buttonIndex = buttonIndex + 1
				index = i + baseIndex
				local questItem = QuestInfo_GetRewardButton(rewardsFrame, i)
				questItem.type = "reward"
				questItem.objectType = "item"
				questItem:SetID(loot.items[i])
				questItem:Show()
				local itemID = loot.items[i]
				local item = Item:CreateFromItemID(itemID)
				item:ContinueOnItemLoad(function()
					questItem.Name:SetText(item:GetItemName())
					questItem.Icon:SetTexture(item:GetItemIcon())
					SetItemButtonQuality(questItem, item:GetItemQuality(), itemID, false)
				end)
				if (buttonIndex > 1) then
					if (mod(buttonIndex, 2) == 1) then
						questItem:SetPoint("TOPLEFT", rewardButtons[index - 2], "BOTTOMLEFT", 0, -2)
						lastFrame = questItem
						totalHeight = totalHeight + buttonHeight + 2
					else
						questItem:SetPoint("TOPLEFT", rewardButtons[index - 1], "TOPRIGHT", 1, 0)
					end
				else
					questItem:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -REWARDS_SECTION_OFFSET)
					lastFrame = questItem
					totalHeight = totalHeight + buttonHeight + REWARDS_SECTION_OFFSET
				end
				rewardsCount = rewardsCount + 1
				lastFrame = questItem
			end
			rewardsFrame.ItemReceiveText:Hide()
			rewardsFrame.MoneyFrame:Hide()
			rewardsFrame.XPFrame:Hide()
			rewardsFrame.SkillPointFrame:Hide()
			rewardsFrame.HonorFrame:Hide()
			rewardsFrame:Show()
			rewardsFrame:SetHeight(totalHeight)
			return rewardsFrame, lastFrame
		end
		function RaresLogFrame_ShowRareDetails(creature)
			local elements = {
				TomCatsQuestInfoTitleHeader, 5, -5,
				TomCatsQuestInfoQuestType, 0, -5,
			}
			local contentWidth = 244
			local parentFrame = TomCatsRareMapFrame.DetailsFrame.ScrollFrame.Contents
			TomCatsQuestInfoTitleHeader:SetText(creature["Name"])
			TomCatsQuestInfoTitleHeader:SetWidth(contentWidth)
			TomCatsQuestInfoQuestType:SetText("|T1121272:20:20:0:2:1024:512:728:760:409:441|t Rare Spawn")
			local description = creature["Description"]
			if description then
				table.insert(elements, TomCatsQuestInfoDescriptionHeader)
				table.insert(elements, 0)
				table.insert(elements, -10)
				table.insert(elements, TomCatsQuestInfoDescriptionText)
				table.insert(elements, 0)
				table.insert(elements, -5)
				TomCatsQuestInfoDescriptionText:SetText(description)
				TomCatsQuestInfoDescriptionText:SetWidth(244)
			else
				TomCatsQuestInfoDescriptionHeader:SetShown(false)
				TomCatsQuestInfoDescriptionText:SetShown(false)
			end
			local lastFrame
			for i = 1, #elements, 3 do
				shownFrame = elements[i]
				shownFrame:SetParent(parentFrame)
				shownFrame:ClearAllPoints()
				if lastFrame then
					shownFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", elements[i + 1], elements[i + 2])
				else
					shownFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", elements[i + 1], elements[i + 2])
				end
				lastFrame = shownFrame
				shownFrame:SetShown(true)
			end
			local rewardsFrame = RareInfo_ShowRewards(creature)
			parentFrame = TomCatsRareMapFrame.DetailsFrame.RewardsFrame
			rewardsFrame:SetParent(parentFrame)
			rewardsFrame:ClearAllPoints()
			rewardsFrame:SetWidth(244)
			rewardsFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 8, -42)
			rewardsFrame:SetShown(true)
			TomCatsRareMapFrame.DetailsFrame.ScrollFrame.ScrollBar:SetValue(0)
			local height
			if (TomCatsRareInfoRewardsFrame:IsShown()) then
				height = TomCatsRareInfoRewardsFrame:GetHeight() + 49
			else
				height = 59
			end
			height = min(height, 275)
			TomCatsRareMapFrame.DetailsFrame.RewardsFrame:SetHeight(height)
			TomCatsRareMapFrame.DetailsFrame.RewardsFrame.Background:SetTexCoord(0, 1, 0, height / 275)
			TomCatsRareMapFrame.DetailsFrame:Show()
		end
		TomCatsRaresLogFrame_ShowRareDetails = RaresLogFrame_ShowRareDetails
		function TomCatsRareMapFrame_ReturnFromRareDetails()
			TomCatsRareMapFrame.RaresFrame:Show()
			TomCatsRareMapFrame.DetailsFrame:Hide()
		end
		addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
	end
end
 -- FrameXML.toc:8
 -- FrameXML.toc:11
 -- FrameXML.toc:56
 -- SharedUIPanelTemplates.xml:3
 -- FrameXML.toc:152
