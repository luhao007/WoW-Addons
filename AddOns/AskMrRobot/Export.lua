local Amr = LibStub("AceAddon-3.0"):GetAddon("AskMrRobot")
local L = LibStub("AceLocale-3.0"):GetLocale("AskMrRobot", true)
local AceGUI = LibStub("AceGUI-3.0")

local _lastExport = nil
local _txt = nil

local function createLabel(container, text, width)
	local lbl = AceGUI:Create("AmrUiLabel")
	container:AddChild(lbl)
	lbl:SetWidth(width or 800)
	lbl:SetText(text)
	lbl:SetFont(Amr.CreateFont("Regular", 14, Amr.Colors.Text))
	return lbl
end

local function onSplashClose()
	Amr:HideCover()
	Amr.db.char.FirstUse = false
end

local function onTextChanged(widget)
	local val = _txt:GetText()
	if val == "overwolf-bib" then
		-- go to the gear tab, open import window, and show a cover
		Amr:ShowTab("Gear")
		Amr:ShowImportWindow(true)
	end
end

-- render a splash screen with first-time help
local function renderSplash(container)
	local panel = Amr:RenderCoverChrome(container, 700, 450)
	
	local lbl = createLabel(panel, L.ExportSplashTitle, 650)
	lbl:SetJustifyH("CENTER")
	lbl:SetFont(Amr.CreateFont("Bold", 24, Amr.Colors.TextHeaderActive))
	lbl:SetPoint("TOP", panel.content, "TOP", 0, -10)
	
	local lbl2 = createLabel(panel, L.ExportSplashSubtitle, 650)
	lbl2:SetJustifyH("CENTER")
	lbl2:SetFont(Amr.CreateFont("Bold", 18, Amr.Colors.TextTan))
	lbl2:SetPoint("TOP", lbl.frame, "BOTTOM", 0, -20)
	
	lbl = createLabel(panel, L.ExportSplash1, 650)
	lbl:SetFont(Amr.CreateFont("Regular", 14, Amr.Colors.Text))
	lbl:SetPoint("TOPLEFT", lbl2.frame, "BOTTOMLEFT", 0, -70)
	
	lbl2 = createLabel(panel, L.ExportSplash2, 650)
	lbl2:SetFont(Amr.CreateFont("Regular", 14, Amr.Colors.Text))
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -15)
	
	local btn = AceGUI:Create("AmrUiButton")
	btn:SetText(L.ExportSplashClose)
	btn:SetBackgroundColor(Amr.Colors.Green)
	btn:SetFont(Amr.CreateFont("Bold", 16, Amr.Colors.White))
	btn:SetWidth(120)
	btn:SetHeight(28)
	btn:SetCallback("OnClick", onSplashClose)
	panel:AddChild(btn)
	btn:SetPoint("BOTTOM", panel.content, "BOTTOM", 0, 20)
end

-- renders the main UI for the Export tab
function Amr:RenderTabExport(container)

	local lbl = createLabel(container, L.ExportTitle)
	lbl:SetFont(Amr.CreateFont("Bold", 24, Amr.Colors.TextHeaderActive))
	lbl:SetPoint("TOPLEFT", container.content, "TOPLEFT", 0, -40)
	
	local lbl2 = createLabel(container, L.ExportHelp1)
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -10)
	
	lbl = createLabel(container, L.ExportHelp2)
	lbl:SetPoint("TOPLEFT", lbl2.frame, "BOTTOMLEFT", 0, -10)
	
	lbl2 = createLabel(container, L.ExportHelp3)
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -10)
	
	_txt = AceGUI:Create("AmrUiTextarea")
	_txt:SetWidth(800)
	_txt:SetHeight(300)
	_txt:SetFont(Amr.CreateFont("Regular", 12, Amr.Colors.Text))
	_txt:SetCallback("OnTextChanged", onTextChanged)
	container:AddChild(_txt)
	_txt:SetPoint("TOP", lbl2.frame, "BOTTOM", 0, -20)
	
	local data = self:ExportCharacter()	
	local txt = Amr.Serializer:SerializePlayerData(data, true)
	_txt:SetText(txt)
	_txt:SetFocus(true)
	
	-- update shopping list data
	Amr:UpdateShoppingData(data)
	
	-- show help splash if first time a user is using this
	if Amr.db.char.FirstUse then
		Amr:ShowCover(renderSplash)	
		AceGUI:ClearFocus()
	end
end

function Amr:ReleaseTabExport()
end

function Amr:GetExportText()
	return _txt:GetText()
end


-- use some local variables to deal with the fact that a user can close the bank before a scan completes
local _lastBankBagId = nil
local _lastBankSlotId = nil
local _bankOpen = false

local function scanBag(bagId, isBank, bagTable, bagItemsWithCount)

	local numSlots = C_Container.GetContainerNumSlots(bagId)
	for slotId = 1, numSlots do
		local itemInfo = C_Container.GetContainerItemInfo(bagId, slotId)
		if itemInfo then
			local itemData = Amr.Serializer.ParseItemLink(itemInfo.hyperlink)
			if itemData ~= nil then
				Amr.ParseExtraItemInfo(itemData, bagId, slotId, false)

				if isBank then
					_lastBankBagId = bagId
					_lastBankSlotId = slotId
				end
										
				table.insert(bagTable, itemData)
				
				-- all items and counts, used for e.g. shopping list and reagents, etc.
                if bagItemsWithCount then
                	if bagItemsWithCount[itemData.id] then
                		bagItemsWithCount[itemData.id] = bagItemsWithCount[itemData.id] + itemInfo.stackCount
                	else
                		bagItemsWithCount[itemData.id] = itemInfo.stackCount
                	end
                end
            end
		end
	end
end

-- cache the currently equipped gear for this spec
local function cacheEquipped()
	local data = Amr.Serializer:GetEquipped()
	
	local spec = GetSpecialization()	
	Amr.db.char.Equipped[spec] = data.Equipped[spec]
end

local function scanBags()

	local bagItems = {}
	local itemsAndCounts = {}
	
	for bagId = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		scanBag(bagId, false, bagItems, itemsAndCounts)
	end
	
	Amr.db.char.BagItems = bagItems
	Amr.db.char.BagItemsAndCounts = itemsAndCounts
end

-- scan the player's bank and save the contents, must be at the bank
local function scanBank()

	local bankItems = {}
	local itemsAndCounts = {}	

	for i,bagId in ipairs(Amr:GetBankBagList(true)) do
		local bagItems = {}
		local bagItemsAndCounts = {}
		scanBag(bagId, true, bagItems, bagItemsAndCounts)

		bankItems[bagId] = bagItems
		itemsAndCounts[bagId] = bagItemsAndCounts
	end
	
	-- see if the scan completed before the window closed, otherwise we don't overwrite with partial data
	if _bankOpen and _lastBankBagId then
		local itemLink = C_Container.GetContainerItemLink(_lastBankBagId, _lastBankSlotId)
		if itemLink then --still open
            Amr.db.char.BankItems = bankItems
            Amr.db.char.BankItemsAndCounts = itemsAndCounts
		end
	end
end

local function onBankOpened()
	_bankOpen = true
	scanBank()
end

local function onBankClosed()
	_bankOpen = false
end

-- if a bank bag is updated while the bank is open, re-scan that bag
local function onBankUpdated(bagID)
	if _bankOpen and Amr:IsBankBag(bagID, true) then
		local bagItems = {}
		local bagItemsAndCounts = {}
		scanBag(bagID, true, bagItems, bagItemsAndCounts)

		-- see if the scan completed before the window closed, otherwise we don't overwrite with partial data
		if _bankOpen and _lastBankBagId == bagID then
			local itemLink = C_Container.GetContainerItemLink(_lastBankBagId, _lastBankSlotId)
			if itemLink then
				Amr.db.char.BankItems[bagID] = bagItems
				Amr.db.char.BankItemsAndCounts[bagID] = bagItemsAndCounts
			end
		end
	end
end

local function scanGreatVault()

	Amr.db.char.GreatVaultItems = {}

	if not C_WeeklyRewards then return end

	local vaultItems = {}
	local activities = C_WeeklyRewards.GetActivities()
	for i, activityInfo in ipairs(activities) do
		if activityInfo and activityInfo.rewards then
			for i, rewardInfo in ipairs(activityInfo.rewards) do
				if rewardInfo.type == Enum.CachedRewardType.Item and not C_Item.IsItemKeystoneByID(rewardInfo.id) then
					local itemLink = C_WeeklyRewards.GetItemHyperlink(rewardInfo.itemDBID)
					if itemLink then
						local itemData = Amr.Serializer.ParseItemLink(itemLink)
						if itemData ~= nil then
							table.insert(vaultItems, itemData)
						end
					end
				end
			end
		end
	end
	Amr.db.char.GreatVaultItems = vaultItems
end

--[[
local function scanSoulbinds()
	if not C_Soulbinds then return end

	-- get renown
	if C_CovenantSanctumUI then
		Amr.db.char.CovenantRenownLevel = C_CovenantSanctumUI.GetRenownLevel()
	else
		Amr.db.char.CovenantRenownLevel = 0
	end

	-- read which conduits this player has unlocked
	Amr.db.char.UnlockedConduits = {}

	for t = 0,2 do
		local conduits = C_Soulbinds.GetConduitCollection(t)
		for i, conduit in ipairs(conduits) do
			table.insert(Amr.db.char.UnlockedConduits, { conduit.conduitID, conduit.conduitRank })
		end
	end

	if not Amr.db.char.ActiveSoulbinds then
		Amr.db.char.ActiveSoulbinds = {}
	end

	-- read the currently active soulbind for this spec
	local specPos = GetSpecialization()	
	if specPos and specPos >= 1 and specPos <= 4 then
		Amr.db.char.ActiveSoulbinds[specPos] = C_Soulbinds.GetActiveSoulbindID() or 0
	end

	-- update soulbind tree info for all soulbinds
	Amr.db.char.Soulbinds = {}
	
	for c, covenantId in ipairs(C_Covenants.GetCovenantIDs()) do
		local covenantData = C_Covenants.GetCovenantData(covenantId)

		if covenantData and covenantData.soulbindIDs then
			for i, soulbindId in ipairs(covenantData.soulbindIDs) do
				local soulbindData = soulbindId and C_Soulbinds.GetSoulbindData(soulbindId)
				local nodes = {}
				local unlockedTier = -1
	
				if soulbindData and soulbindData.tree and soulbindData.tree.nodes then
					for i, node in ipairs(soulbindData.tree.nodes) do
						if node.state == 3 then
							nodes[node.row] = { soulbindId, node.row, node.column, node.conduitID, node.conduitRank }
						end
						if node.state > 0 then
							unlockedTier = math.max(node.row, unlockedTier)
						end
					end
				end
	
				Amr.db.char.Soulbinds[soulbindId] = {
					UnlockedTier = unlockedTier,
					Nodes = nodes
				}
	
			end
		end
	end	

end
]]

--[[
local function scanEssences()
	if not C_AzeriteEssence then return end

	-- read which essences this player has unlocked
	Amr.db.char.UnlockedEssences = {}

	local essences = C_AzeriteEssence.GetEssences()
	if essences then
		for i, essence in ipairs(essences) do
			if essence.unlocked then
				table.insert(Amr.db.char.UnlockedEssences, { essence.ID, essence.rank })
			end
		end 
	end

	local specPos = GetSpecialization()	
	if not specPos or specPos < 1 or specPos > 4 then return end

	if not Amr.db.char.Essences then
		Amr.db.char.Essences = {}
	end

	Amr.db.char.Essences[specPos] = {}
	local active = Amr.db.char.Essences[specPos]

	local milestones = C_AzeriteEssence.GetMilestones()
	if milestones then
		for i, milestone in ipairs(milestones) do
			-- if no slot, it corresponds to the stamina nodes, skip those
			if milestone.slot ~= nil then
				if milestone.unlocked then
					local essenceId = C_AzeriteEssence.GetMilestoneEssence(milestone.ID)
					if essenceId then
						local essence = C_AzeriteEssence.GetEssenceInfo(essenceId)
						table.insert(active, { milestone.slot, essence.ID, essence.rank })
					end
				end
			end
		end
	end
end
]]

local function readTalentConfig(configId)

	--[[
	local config = C_Traits.GetConfigInfo(configId)
	if not config or config.type ~= Enum.TraitConfigType.Combat then return nil end
	
	local treeIds = config["treeIDs"]

	-- at least for a while, scanning nodes would return subtrees not available to this spec, so we need to do a pre-scan for available subtrees
	-- and use that to actively prune out bad subtrees... very gross	

	local allowedSubtrees = {}
	local activeSubtreeId = 0
	for i = 1, #treeIds do
    	for _, nodeId in pairs(C_Traits.GetTreeNodes(treeIds[i])) do
			local node = C_Traits.GetNodeInfo(configId, nodeId)
			if node.ID and node.isVisible and node.maxRanks > 0 and node.type == 3 then
				-- this is the special node that picks your subtree, scan its entries to see which are allowed and also which is active
				for e = 1, #node.entryIDs do
					local entry = C_Traits.GetEntryInfo(configId, node.entryIDs[e])
					allowedSubtrees[entry.subTreeID] = true
					if node.activeEntry and node.activeEntry.entryID == node.entryIDs[e] then
						activeSubtreeId = entry.subTreeID
					end
				end
			end
		end
	end

	-- NOTE: the below will also pick up ranks in inactive subtrees... kind of annoying, but that is how they remember your selections
	--       when switching back and forth, and then the selected subtree implicitly disables the inactive tree
	
	local talMap = {}

  	for i = 1, #treeIds do
    	for _, nodeId in pairs(C_Traits.GetTreeNodes(treeIds[i])) do
			local node = C_Traits.GetNodeInfo(configId, nodeId)
			if node.ID and node.isVisible and node.maxRanks > 0 and (not node.subTreeID or allowedSubtrees[node.subTreeID]) then

				-- need to check node type b/c blizz abandoned a few selection node entries in the data which still show up in a scan here... super annoying and gross
				if #node.entryIDs > 1 and node.type == 2 then
					talMap[node.ID] = {}
					for e = 1, #node.entryIDs do
						if node.activeEntry and node.entryIDs[e] == node.activeEntry.entryID then
							table.insert(talMap[node.ID], node.activeRank)
						else
							table.insert(talMap[node.ID], 0)
						end
					end
				elseif node.type ~= 3 then
					-- we skip the fake-ish node that chooses the hero tree (type 3), we have pre-parsed it above
					
					if node.activeEntry and node.activeRank then
						talMap[node.ID] = { node.activeRank }
					else
						talMap[node.ID] = { 0 }
					end
				end				
			end

			-- for reference if ever need it
			--local activeEntryId = node.entryIDs[1]
			--local entry = C_Traits.GetEntryInfo(configId, activeEntryId)
			--local defnId = entry["definitionID"]
			--local defn = C_Traits.GetDefinitionInfo(defnId)
			--local spellId = defn["spellID"]
			--local spellName = C_Spell.GetSpellName(spellId)
			--if spellName == "Lightning Strikes" then
			--	print(Amr:dump(node))							
			--end

		end
	end

	local tals = {}

	-- sort by node ID
	for nodeId, ranks in Amr.spairs(talMap) do
		for i, rank in ipairs(ranks) do
			table.insert(tals, rank)
		end
	end	
	]]

	local configData = Amr:GetTalentConfigData(configId)
	if not configData then return nil end

	local tals = {}

	-- sort by node ID
	for nodeId, nodeData in Amr.spairs(configData.nodes) do
		for i, rank in ipairs(nodeData.ranks) do
			table.insert(tals, rank)
		end
	end

	return {
		id = configId,
		name = configData.name,
		tals = table.concat(tals, "") .. "_" .. configData.activeSubtreeId
	}
end

local function scanActiveTalents()

	local specPos = GetSpecialization()	
	if not specPos or specPos < 1 or specPos > 4 then return end

	if not Amr.db.char.TalentConfigs.LastConfig then
		Amr.db.char.TalentConfigs.LastConfig = {}
	end

	-- grab the currently active config for this spec and save it
	local configId = C_ClassTalents.GetActiveConfigID()
	if configId then
		local parsedConfig = readTalentConfig(configId)
		if parsedConfig then
			Amr.db.char.TalentConfigs.LastConfig[specPos] = parsedConfig
		end
	end

end

local function scanTalents()	
	
	-- pre-dragonflight

	local specPos = GetSpecialization()	
	if not specPos or specPos < 1 or specPos > 4 then return end
	
	--[[	
	local talentInfo = {}
    local maxTiers = 7
    for tier = 1, maxTiers do
        for col = 1, 3 do
            local id, name, _, _, _, spellId, _, t, c, selected = GetTalentInfoBySpecialization(specPos, tier, col)
            if selected then
                talentInfo[tier] = col
            end
        end
    end
    
    local str = ""
    for i = 1, maxTiers do
    	if talentInfo[i] then
    		str = str .. talentInfo[i]
    	else
    		str = str .. '0'
    	end
    end
	
	Amr.db.char.Talents[specPos] = str
	]]

	if not Amr.db.char.TalentConfigs.ConfigList then
		Amr.db.char.TalentConfigs.ConfigList = {}
	end

	--local allConfigs = {}
	local parsedConfig

	--for specPos = 1, 4 do
	local specId = GetSpecializationInfo(specPos)
	if specId then
		local specList = {}
		Amr.db.char.TalentConfigs.ConfigList[Amr.SpecIds[specId]] = specList
		--allConfigs[Amr.SpecIds[specId]] = specList
		for i, configId in ipairs(C_ClassTalents.GetConfigIDsBySpecID(specId)) do	
			parsedConfig = readTalentConfig(configId)
			if parsedConfig then
				table.insert(specList, parsedConfig)
			end
		end
	end
	--end

	-- refresh entire list of configs each time we scan
	--Amr.db.char.TalentConfigs.ConfigList = allConfigs

	-- also get currently active talents
	scanActiveTalents()

	--[[
	if not Amr.db.char.TalentConfigs.LastConfig then
		Amr.db.char.TalentConfigs.LastConfig = {}
	end

	-- grab the currently active config for this spec and save it too
	local configId = C_ClassTalents.GetActiveConfigID()
	if configId then
		parsedConfig = readTalentConfig(configId)
		if parsedConfig then
			Amr.db.char.TalentConfigs.LastConfig[specPos] = parsedConfig
		end
	end
	]]
end

local function scanHighestItemLevels()

	local lvls = {}

	for k,v in pairs(Enum.ItemRedundancySlot) do
		local chr, acct = C_ItemUpgrade.GetHighWatermarkForSlot(v)
		lvls[v] = {chr, acct}
		--print(k .. " " .. v .. " " .. chr .. " " .. acct)
	end	

	Amr.db.char.HighestItemLevels = lvls	
end

local function scanAchievements()

	local achieved = {}

	local interestingIds = {
		41886, -- season 2 weathered crest
		41887, -- season 2 carved crest
		41888, -- season 2 runed crest
		41892, -- season 2 gilded crest
	}

	for _, achievementId in ipairs(interestingIds) do
		local _, _, _, completed = GetAchievementInfo(achievementId)
		if completed then
			table.insert(achieved, achievementId)
		end
	end

	-- replace all achievements every time we scan, prevents unused ones from building up
	Amr.db.char.Achievements = achieved
end

-- Returns a data object containing all information about the current player needed for an export:
-- gear, spec, reputations, bag, bank, and void storage items.
function Amr:ExportCharacter()
	
	-- get all necessary player data
	local data = Amr.Serializer:GetPlayerData()

	-- cache latest-seen equipped gear for current spec
	local spec = GetSpecialization()	
	Amr.db.char.Equipped[spec] = data.Equipped[spec]

	-- scan highest ilvls in each slot used for determining upgrade discounts
	scanHighestItemLevels()

	-- scan some achievements, right now used for determining some more upgrade discounts
	scanAchievements()

	-- scan current inventory just before export so that it is always fresh
	scanBags()
	
	-- scan current spec's talents just before exporting
	scanTalents()

	-- scan all soulbinds just before exporting
	--scanSoulbinds()

	-- scan current spec's essences just before exporting
	--scanEssences()
	
	-- scan the great vault for potential rewards this week
	scanGreatVault()

	data.HighestItemLevels = Amr.db.char.HighestItemLevels
	data.Achievements = Amr.db.char.Achievements

	data.SavedTalentConfigs = Amr.db.char.TalentConfigs.ConfigList
	data.LastTalentConfig = Amr.db.char.TalentConfigs.LastConfig

	--data.Talents = Amr.db.char.Talents
	--data.CovenantRenownLevel = Amr.db.char.CovenantRenownLevel
	--data.UnlockedConduits = Amr.db.char.UnlockedConduits
	--data.ActiveSoulbinds = Amr.db.char.ActiveSoulbinds
	--data.Soulbinds = Amr.db.char.Soulbinds
	--data.UnlockedEssences = Amr.db.char.UnlockedEssences
	--data.Essences = Amr.db.char.Essences
	data.Equipped = Amr.db.char.Equipped	
	data.BagItems = Amr.db.char.BagItems
	data.GreatVaultItems = Amr.db.char.GreatVaultItems

	-- flatten bank data (which is stored by bag for more efficient updating)
	data.BankItems = {}
	for k,v in pairs(Amr.db.char.BankItems) do
		for i,v2 in ipairs(v) do
			table.insert(data.BankItems, v2)
		end
	end

	--data.VoidItems = Amr.db.char.VoidItems
	
	return data
end

function Amr:InitializeExport()
	Amr:AddEventHandler("UNIT_INVENTORY_CHANGED", function(unitID)
		if unitID and unitID ~= "player" then return end
		cacheEquipped()
	end)
end

Amr:AddEventHandler("BANKFRAME_OPENED", onBankOpened)
Amr:AddEventHandler("BANKFRAME_CLOSED", onBankClosed)
Amr:AddEventHandler("BAG_UPDATE", onBankUpdated)

--Amr:AddEventHandler("PLAYER_TALENT_UPDATE", scanTalents)
Amr:AddEventHandler("TRAIT_CONFIG_UPDATED", scanTalents)

--if C_AzeriteEssence then
--	Amr:AddEventHandler("AZERITE_ESSENCE_UPDATE", scanEssences)
--end

--[[
if C_Soulbinds then
	Amr:AddEventHandler("SOULBIND_ACTIVATED", scanSoulbinds)
end
]]