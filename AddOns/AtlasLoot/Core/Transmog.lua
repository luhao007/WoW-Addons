-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G                    = getfenv(0)
local next, pairs           = _G.next, _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local ALName, ALPrivate     = ...

local AtlasLoot             = _G.AtlasLoot
local Transmog              = {}
AtlasLoot.Transmog          = Transmog

local Proto                 = {}

-- /console missingTransmogSourceInItemTooltips 1
--C_TransmogCollection.GetSourceInfo(sourceID)

local TRANSMOG_UPDATE_EVENT = "TRANSMOG_SOURCE_COLLECTABILITY_UPDATE" -- sourceID, canCollect

--[[
	nil 	cannot collect
	false	can collect, not collected
	true	can collect, collected
]]
function Proto:IsItemUnlocked(itemStringOrID, sourceID, callbackFunc, callbackArg)
	if not itemStringOrID and not sourceID then return end
	local appearanceID, isInfoReady, canCollect

	if itemStringOrID then
		local parsedItem = AtlasLoot.ItemString.Parse(itemStringOrID)

		-- Toys
		if C_ToyBox.GetToyInfo(parsedItem.itemID) then
			local collected = PlayerHasToy(parsedItem.itemID);
			if callbackFunc then
				callbackFunc(callbackArg, collected)
				return
			else
				return collected
			end
		end

		-- Mounts
		if C_MountJournal.GetMountFromItem(parsedItem.itemID) then
			local mountID = C_MountJournal.GetMountFromItem(parsedItem.itemID);
			local collected = select(11, C_MountJournal.GetMountInfoByID(mountID));

			if callbackFunc then
				callbackFunc(callbackArg, collected)
				return
			else
				return collected
			end
		end

		-- Pets
		if C_PetJournal.GetPetInfoByItemID(parsedItem.itemID) then
			local speciesID = select(13, C_PetJournal.GetPetInfoByItemID(parsedItem.itemID));
			local collected = C_PetJournal.GetNumCollectedInfo(speciesID) > 0;

			if callbackFunc then
				callbackFunc(callbackArg, collected)
				return
			else
				return collected
			end
		end

		-- Decor
		if C_HousingCatalog.GetCatalogEntryInfoByItem(parsedItem.itemID, false) then
			local decor = C_HousingCatalog.GetCatalogEntryInfoByItem(parsedItem.itemID, false);
			local collected = decor.firstAcquisitionBonus == 0;

			if callbackFunc then
				callbackFunc(callbackArg, collected)
				return
			else
				return collected
			end
		end

		-- Ensembles
		-- TODO

		-- Appearances
		appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemStringOrID)
	end
	if itemStringOrID and not appearanceID and strfind(itemStringOrID, ":") then
		-- sometimes the link won't actually give us an appearance, but itemID will
		local parsedItem = AtlasLoot.ItemString.Parse(itemStringOrID)
		appearanceID, sourceID = C_TransmogCollection.GetItemInfo(parsedItem.itemID)
	end
	if not sourceID then return end
	isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource(sourceID)

	if isInfoReady then
		if canCollect then
			canCollect = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)
		else
			canCollect = nil
		end
		if callbackFunc then
			callbackFunc(callbackArg, canCollect)
		else
			return canCollect
		end
	else
		self:AddUnknownItem(sourceID, callbackFunc, callbackArg)
	end
end

function Proto:AddUnknownItem(sourceID, callbackFunc, callbackArg)
	if not next(self.itemList) then
		self.frame:RegisterEvent(TRANSMOG_UPDATE_EVENT)
	end
	self.itemList[sourceID] = { callbackFunc, callbackArg }
end

function Proto:Clear()
	self.itemList = {}
	self.frame:UnregisterEvent(TRANSMOG_UPDATE_EVENT)
end

local function OnEvent(self, event, sourceID, canCollect)
	if sourceID and self.obj.itemList[sourceID] then
		self.obj:IsItemUnlocked(nil, sourceID, self.obj.itemList[sourceID][1], self.obj.itemList[sourceID][2])
		self.obj.itemList[sourceID] = nil
	end
	if not next(self.obj.itemList) then
		self:UnregisterEvent(TRANSMOG_UPDATE_EVENT)
	end
end

function Transmog:New()
	local tab = {}

	-- Add protos
	for k, v in pairs(Proto) do
		tab[k] = v
	end

	tab.itemList = {}

	tab.frame = CreateFrame("FRAME")
	tab.frame.obj = tab
	tab.frame:SetScript("OnEvent", OnEvent)

	return tab
end
