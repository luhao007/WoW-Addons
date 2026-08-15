local addonName = ...;

LBIS.ClassSpec = {};
LBIS.ClassSpecByID = {};  -- integer Blizzard spec ID -> classSpec
LBIS.ItemBonuses = {};
LBIS.NameToSpecId = {};
LBIS.ItemsByIdAndSpec = {};
LBIS.SpellsByIdAndSpec = {};

LBIS.ItemsBySpecAndId = {};
LBIS.GemsBySpecAndId = {};
LBIS.EnchantsBySpecAndId = {};
LBIS.EmbellishmentsBySpecAndId = {};

LBIS.AllItemsCached = false;
LBIS.CurrentPhase = 1;
LBIS.Debugging = false;

LBIS.EventFrame = CreateFrame("FRAME", addonName.."Events")

SLASH_LOONBESTINSLOT1 = '/bis'
SLASH_LOONBESTINSLOT2 = '/비스'
SLASH_LOONBESTINSLOT3 = '/lbis'
SlashCmdList["LOONBESTINSLOT"] = function(command)
	command = command:lower()

	if command == "" then
		LBIS.BrowserWindow:OpenWindow()
	elseif command == "edit" then
		LBIS.BrowserWindow:OpenWindow("CustomEditList")
	elseif command == "custom" then
		LBIS.BrowserWindow:OpenWindow("CustomItemList")
	elseif command == "settings"	then		
		Settings.OpenToCategory("Loon Best In Slot")
	elseif command == "debug" then
		LBIS:PrintDebugDump()
	end
end

-- Diagnostic dump for troubleshooting localization / cache issues.
-- Prints state to chat. Safe to run at any time.
function LBIS:PrintDebugDump()
	local function p(s) print("|cff00ff00[LBIS]|r "..s) end
	p("=== Debug Dump (v1.0.4) ===")
	p("Locale: "..tostring(GetLocale and GetLocale() or "?"))
	p("L[All]='"..tostring(LBIS.L["All"]).."' L[Drop]='"..tostring(LBIS.L["Drop"]).."' L[Raid]='"..tostring(LBIS.L["Raid"]).."'")
	p("L[Paladin]='"..tostring(LBIS.L["Paladin"]).."' L[Retribution]='"..tostring(LBIS.L["Retribution"]).."'")

	if LBISSettings then
		p("Settings.SelectedSpec='"..tostring(LBISSettings.SelectedSpec).."'")
		p("Settings.SelectedSpecID="..tostring(LBISSettings.SelectedSpecID))
		p("Settings.SelectedSlot='"..tostring(LBISSettings.SelectedSlot).."'")
		p("Settings.SelectedSourceType='"..tostring(LBISSettings.SelectedSourceType).."'")
		p("Settings.SelectedZone='"..tostring(LBISSettings.SelectedZone).."'")
	end

	-- Resolve current selection
	local cacheKey, specID = LBIS:ResolveSelectedSpec()
	p("Resolved cacheKey='"..tostring(cacheKey).."' specID="..tostring(specID))

	-- Spec count + sample entry
	local specCount = 0
	local sampleId, sampleSpec
	for k, v in pairs(LBIS.ClassSpec) do
		specCount = specCount + 1
		if not sampleId then sampleId = k; sampleSpec = v end
	end
	p("ClassSpec entries: "..specCount..", sample id='"..tostring(sampleId).."' (Class='"..tostring(sampleSpec and sampleSpec.Class).."', Spec='"..tostring(sampleSpec and sampleSpec.Spec).."', SpecID="..tostring(sampleSpec and sampleSpec.SpecID)..")")

	local idCount = 0
	for _ in pairs(LBIS.ClassSpecByID) do idCount = idCount + 1 end
	p("ClassSpecByID entries: "..idCount.." (should equal ClassSpec)")

	-- NameToSpecId entries
	local nameMapCount = 0
	for _ in pairs(LBIS.NameToSpecId or {}) do nameMapCount = nameMapCount + 1 end
	p("NameToSpecId entries: "..nameMapCount)

	-- Items count for current spec + filter trace
	if cacheKey and LBIS.ItemsBySpecAndId[cacheKey] then
		local total = 0
		local missingSrc, fFaction, fSlot, fSource, fZone, fLegacy, fObsolete, passed = 0,0,0,0,0,0,0,0
		local sampleReject = nil  -- record one rejection for forensic detail

		for itemId, specItem in pairs(LBIS.ItemsBySpecAndId[cacheKey]) do
			total = total + 1
			local src = LBIS.ItemSources and LBIS.ItemSources[specItem.Id]
			if not src then
				missingSrc = missingSrc + 1
			else
				-- IsInFaction
				local faction = UnitFactionGroup and UnitFactionGroup("PLAYER") or "Alliance"
				local okFaction = (src.SourceFaction == "B") or (faction == "Alliance" and src.SourceFaction == "A") or (faction == "Horde" and src.SourceFaction == "H")
				-- IsInSlot
				local okSlot = (LBISSettings.SelectedSlot == LBIS.L["All"]) or (specItem.Slot and strfind(specItem.Slot, LBISSettings.SelectedSlot) ~= nil)
				-- IsInSource
				local okSource = (LBISSettings.SelectedSourceType == LBIS.L["All"]) or (src.SourceType and strfind(src.SourceType, LBISSettings.SelectedSourceType) ~= nil)
				-- IsInZone
				local okZone
				if LBISSettings.SelectedZone == LBIS.L["All"] then
					okZone = true
				else
					local zone = gsub(gsub(src.SourceLocation or "", "%(25H%)", "(25)"), "%(10H%)", "(10)")
					local pat = gsub(gsub(LBISSettings.SelectedZone, "%(", "%%%("), "%)", "%%%)")
					okZone = strfind(zone, pat) ~= nil
				end
				-- IsNotInClassic
				local okLegacy = (src.SourceType ~= LBIS.L["Legacy"])
				-- IsNotObsolete (only matters if HideObsolete is on, defaults pass)
				local okObsolete = true  -- skip detailed sim, almost never the cause

				if not okFaction then
					fFaction = fFaction + 1
				elseif not okSlot then
					fSlot = fSlot + 1
					if not sampleReject then sampleReject = "SLOT: item.Slot='"..tostring(specItem.Slot).."' vs SelectedSlot='"..tostring(LBISSettings.SelectedSlot).."'" end
				elseif not okSource then
					fSource = fSource + 1
					if not sampleReject then sampleReject = "SOURCE: src.SourceType='"..tostring(src.SourceType).."' vs SelectedSourceType='"..tostring(LBISSettings.SelectedSourceType).."'" end
				elseif not okZone then
					fZone = fZone + 1
					if not sampleReject then sampleReject = "ZONE: src.SourceLocation='"..tostring(src.SourceLocation).."' vs SelectedZone='"..tostring(LBISSettings.SelectedZone).."'" end
				elseif not okLegacy then
					fLegacy = fLegacy + 1
				else
					passed = passed + 1
				end
			end
		end

		p(string.format("Items: total=%d  pass=%d  rejByFaction=%d  rejBySlot=%d  rejBySource=%d  rejByZone=%d  rejByLegacy=%d  missingSrc=%d", total, passed, fFaction, fSlot, fSource, fZone, fLegacy, missingSrc))
		if sampleReject then p("Sample rejection: "..sampleReject) end
	else
		p("ItemsBySpecAndId['"..tostring(cacheKey).."']: NIL or missing!")
	end

	p("=== End Dump ===")
end

function LBIS:Startup()

	LBIS:CreateSettings();
	LBIS:RegisterMiniMap();
    LBIS:PreCacheItems();
	LBIS:InitializeUI();
    -- build the localized name map for dungeon/raid/boss sources
    if LBIS.LocalizedNames and LBIS.LocalizedNames.BuildMap then
        LBIS.LocalizedNames:BuildMap()
    end
end

function LBIS:RegisterEvent(...)
	if not LBIS.EventFrame.RegisteredEvents then
		LBIS.EventFrame.RegisteredEvents = { };
		LBIS.EventFrame:SetScript("OnEvent", function(self, event, ...)
			local handlers = self.RegisteredEvents[event];
			if handlers then
				for _, handler in ipairs(handlers) do
					handler(...);
				end
			end
		end);
	end

	local params = select("#", ...);

	local handler = select(params, ...);
	if type(handler) ~= "function" then
		error("LoonMasterLoot:RegisterEvent: The last passed parameter must be the handler function");
		return;
	end

	for i = 1, params - 1 do
		local event = select(i, ...);
		if type(event) == "string" then
			LBIS.EventFrame:RegisterEvent(event);
			LBIS.EventFrame.RegisteredEvents[event] = LBIS.EventFrame.RegisteredEvents[event] or { };
			table.insert(LBIS.EventFrame.RegisteredEvents[event], handler);
		else
			error("LBIS:RegisterEvent: All but the last passed parameters must be event names");
		end
	end
end

function LBIS:RegisterSpec(class, spec, phase, specID)

	if not spec then spec = "" end

    local classSpec = {
		Class = class,
		Spec = spec,
		Phase = phase,
		SpecID = specID,  -- Blizzard spec ID (int), language-neutral. nil-safe for older callers.
	}

	classSpec.Id = spec..class

    LBIS.ClassSpec[classSpec.Id] = classSpec

    -- Parallel ID-keyed registry for locale-safe lookups
    if specID then
        LBIS.ClassSpecByID[specID] = classSpec
    end

    return classSpec
end

-- Resolve an integer spec ID to the string cache key (classSpec.Id) used by
-- ItemsBySpecAndId / GemsBySpecAndId / etc. Returns nil if not registered.
function LBIS:GetCacheKeyForSpecID(specID)
    if not specID then return nil end
    local classSpec = LBIS.ClassSpecByID[specID]
    return classSpec and classSpec.Id or nil
end

-- Resolve a SelectedSpec entry (display label, e.g. "Paladin: Vergeltung") to the
-- string cache key. Tries the integer ID first (locale-safe), falls back to legacy
-- NameToSpecId lookup.
function LBIS:ResolveSelectedSpec()
    -- prefer the numeric ID; the dropdown sets it on click
    if LBISSettings.SelectedSpecID then
        local key = LBIS:GetCacheKeyForSpecID(LBISSettings.SelectedSpecID)
        if key then return key, LBISSettings.SelectedSpecID end
    end
    -- Legacy fallback: look up by display label string
    local key = LBIS.NameToSpecId[LBISSettings.SelectedSpec]
    if key then
        -- Backfill the integer ID for next time
        local classSpec = LBIS.ClassSpec[key]
        if classSpec and classSpec.SpecID then
            LBISSettings.SelectedSpecID = classSpec.SpecID
        end
        return key, classSpec and classSpec.SpecID or nil
    end
    return nil, nil
end

local addOrder = 0;
function LBIS:AddItem(bisEntry, id, slot, bis)

	if strlen(id) <= 0 then
		return
	end

	local itemId = tonumber(id);

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end

	if not LBIS.ItemsByIdAndSpec[itemId] then
		LBIS.ItemsByIdAndSpec[itemId] = {}
	end

	if bisEntry.Phase == "0" then
		bis = LBIS.L["PreRaid"];
	elseif bisEntry.Phase == "99" then
		bis = LBIS.L["PrePatch"];
	elseif tonumber(bisEntry.Phase) < LBIS.CurrentPhase then
		bis = string.gsub(bis, "BIS", "Alt");
	end

	local searchedItem = LBIS.ItemsByIdAndSpec[itemId][bisEntry.Id];	

	if searchedItem == nil then

		searchedItem = { Id = itemId, Bis = bis, Phase = bisEntry.Phase, Slot = slot, SortOrder = addOrder }

		if not LBIS.ItemsBySpecAndId[bisEntry.Id] then
			LBIS.ItemsBySpecAndId[bisEntry.Id] = {}
		end
	
	else
		if bisEntry.Phase > searchedItem.Phase then
			searchedItem.Bis = bis;
		end

		searchedItem.SortOrder = addOrder;

		local firstNumber, lastNumber = LBIS:GetPhaseNumbers(searchedItem.Phase);

		if tonumber(bisEntry.Phase) > tonumber(lastNumber) then
			searchedItem.Phase = firstNumber..">"..bisEntry.Phase;
		else
			searchedItem.Phase = bisEntry.Phase;
		end
	end

	LBIS.ItemsBySpecAndId[bisEntry.Id][itemId] = searchedItem;
	LBIS.ItemsByIdAndSpec[itemId][bisEntry.Id] = searchedItem;

	local itemSource = LBIS.ItemSources and LBIS.ItemSources[itemId];

	if itemSource == nil then
		-- Silently skip if ItemSources table not loaded yet
		return;
	end

	if itemSource.SourceType == LBIS.L["Profession"] and tonumber(itemSource.SourceNumber) ~= nil and tonumber(itemSource.SourceNumber) > 0 then	
		if not LBIS.ItemsByIdAndSpec[tonumber(itemSource.SourceNumber)] then
			LBIS.ItemsByIdAndSpec[tonumber(itemSource.SourceNumber)] = {}
		end			
		LBIS.ItemsByIdAndSpec[tonumber(itemSource.SourceNumber)][bisEntry.Id] = searchedItem
	end
	addOrder = addOrder + 1;
end

function LBIS:AddGem(bisEntry, id, quality, isMeta)

	if strlen(id) <= 0 then
		return
	end

	local gemId = tonumber(id);

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end

	if not LBIS.ItemsByIdAndSpec[gemId] then
		LBIS.ItemsByIdAndSpec[gemId] = {}
	end

	local searchedItem = LBIS.ItemsByIdAndSpec[gemId][bisEntry.Id];

	if searchedItem == nil then

		searchedItem = { Id = gemId, Phase = "", Quality = quality, IsMeta = isMeta, Bis = "" }

		if not LBIS.GemsBySpecAndId[bisEntry.Id] then
			LBIS.GemsBySpecAndId[bisEntry.Id] = {}
		end
	end

	LBIS.GemsBySpecAndId[bisEntry.Id][gemId] = searchedItem;
	LBIS.ItemsByIdAndSpec[gemId][bisEntry.Id] = searchedItem

	local gemSource = LBIS.GemSources and LBIS.GemSources[gemId];
	if not gemSource then return; end
	local designId = tonumber(gemSource.DesignId);
	if designId > 0 then		
		if not LBIS.ItemsByIdAndSpec[designId] then
			LBIS.ItemsByIdAndSpec[designId] = {}
		end

		LBIS.ItemsByIdAndSpec[designId][bisEntry.Id] = searchedItem;
	end
end

function LBIS:AddEnchant(bisEntry, id, slot)

	if strlen(id) <= 0 then
		return
	end

	local enchantId = tonumber(id);

	if LBIS.CurrentPhase < tonumber(bisEntry.Phase) then
		return;
	end

	if not LBIS.EnchantsBySpecAndId[bisEntry.Id] then
		LBIS.EnchantsBySpecAndId[bisEntry.Id] = {}
	end

	local enchantSource = LBIS.EnchantSources and LBIS.EnchantSources[enchantId];
	if not enchantSource then return; end
	local designId = tonumber(enchantSource.DesignId);

	local item = { Id = enchantId, Slot = slot, Phase = "", Bis = "" };

	if enchantSource.IsSpell == "False" then

		if not LBIS.ItemsByIdAndSpec[enchantId] then
			LBIS.ItemsByIdAndSpec[enchantId] = {}
		end

		LBIS.ItemsByIdAndSpec[enchantId][bisEntry.Id] = { Id = enchantId, Slot = slot, Phase = "", Bis = "" }		
	else
		if not LBIS.SpellsByIdAndSpec[enchantId] then
			LBIS.SpellsByIdAndSpec[enchantId] = {}
		end

		LBIS.SpellsByIdAndSpec[enchantId][bisEntry.Id] = item;
	end

	if designId > 0 then
		if not LBIS.ItemsByIdAndSpec[designId] then
			LBIS.ItemsByIdAndSpec[designId] = {}
		end

		LBIS.ItemsByIdAndSpec[designId][bisEntry.Id] = item;
	end

	LBIS.EnchantsBySpecAndId[bisEntry.Id][enchantId] = item;
end
function LBIS:AddEmbellishment(bisEntry, gearId, embId)

	if strlen(gearId) <= 0 then
		return
	end

	local gearItemId = tonumber(gearId);
	local embItemId = tonumber(embId) or 0;

	if not LBIS.EmbellishmentsBySpecAndId[bisEntry.Id] then
		LBIS.EmbellishmentsBySpecAndId[bisEntry.Id] = {}
	end

	local item = { GearId = gearItemId, EmbId = embItemId, Bis = "" };

	if not LBIS.ItemsByIdAndSpec[gearItemId] then
		LBIS.ItemsByIdAndSpec[gearItemId] = {}
	end
	LBIS.ItemsByIdAndSpec[gearItemId][bisEntry.Id] = { Id = gearItemId, Phase = "", Bis = "" }

	LBIS.EmbellishmentsBySpecAndId[bisEntry.Id][gearItemId] = item;
end
