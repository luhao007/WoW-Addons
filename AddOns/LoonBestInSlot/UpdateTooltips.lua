local iconpath = "Interface\\GLUES\\CHARACTERCREATE\\UI-CharacterCreate-Classes"
local iconCutoff = 6

local function iconOffset(col, row)
	local offsetString = (col * 64 + iconCutoff) .. ":" .. ((col + 1) * 64 - iconCutoff)
	return offsetString .. ":" .. (row * 64 + iconCutoff) .. ":" .. ((row + 1) * 64 - iconCutoff)
end

local function isInEnabledPhase(phaseText)
	if phaseText == "" then return true end
	if LBISSettings.PhaseTooltip[LBIS.L["PreRaid"]] and LBIS.CurrentPhase >= 0 then
		if LBIS:FindInPhase(phaseText, "0") then return true end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 1"]] and LBIS.CurrentPhase >= 1 then
		if LBIS:FindInPhase(phaseText, "1") then return true end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 2"]] and LBIS.CurrentPhase >= 2 then
		if LBIS:FindInPhase(phaseText, "2") then return true end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 3"]] and LBIS.CurrentPhase >= 3 then
		if LBIS:FindInPhase(phaseText, "3") then return true end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 4"]] and LBIS.CurrentPhase >= 4 then
		if LBIS:FindInPhase(phaseText, "4") then return true end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 5"]] and LBIS.CurrentPhase >= 5 then
		if LBIS:FindInPhase(phaseText, "5") then return true end
	end
	if LBIS.CurrentPhase >= 99 then
		if LBIS:FindInPhase(phaseText, "99") then return true end
	end
	return false
end

local function buildCombinedTooltip(entry, combinedTooltip, foundCustom)
	local classCount = {}
	local combinedSpecs = {}

	for k, v in pairs(entry) do
		if LBISSettings.Tooltip[k] and isInEnabledPhase(v.Phase) and foundCustom[k] == nil then
			local classSpec = LBIS.ClassSpec[k]
			classCount[classSpec.Class..v.Bis..v.Phase] = (classCount[classSpec.Class..v.Bis..v.Phase] or 0) + 1
			if combinedSpecs[classSpec.Class..v.Bis..v.Phase] == nil then
				combinedSpecs[classSpec.Class..v.Bis..v.Phase] = { Class = classSpec.Class, Spec = classSpec.Spec, Bis = v.Bis, Phase = v.Phase }
			else
				combinedSpecs[classSpec.Class..v.Bis..v.Phase].Spec = combinedSpecs[classSpec.Class..v.Bis..v.Phase].Spec..", "..classSpec.Spec
			end
		end
	end

	for _, v in pairs(combinedSpecs) do
		-- compare against the localized class name (hardcoded "Druid" broke non-English clients)
		local DRUID_NAME = LBIS.L["Druid"]
		if v.Class ~= DRUID_NAME and classCount[v.Class..v.Bis..v.Phase] == 3 then
			v.Spec = ""
		elseif v.Class == DRUID_NAME and classCount[v.Class..v.Bis..v.Phase] == 4 then
			v.Spec = ""
		end
		table.insert(combinedTooltip, { Class = v.Class, Spec = v.Spec, Bis = v.Bis, Phase = v.Phase })
	end
end

local function buildCustomTooltip(priorityEntry, combinedTooltip)
	local foundCustom = {}
	if LBISSettings.ShowCustom and priorityEntry ~= nil then
		for k, v in pairs(priorityEntry) do
			local classSpec = LBIS.ClassSpec[k]
			foundCustom[k] = true
			table.insert(combinedTooltip, { Class = classSpec.Class, Spec = classSpec.Spec, Bis = v.TooltipText, Phase = "" })
		end
	end
	return foundCustom
end

local function buildTooltip(tooltip, combinedTooltip)
	if #combinedTooltip > 0 then
		local r,g,b = .9,.8,.5
		tooltip:AddLine(" ",r,g,b,true)
		tooltip:AddLine(LBIS.L["# Best for:"],r,g,b,true)
	end

	for k, v in pairs(combinedTooltip) do
		local class = LBIS.ENGLISH_CLASS[v.Class]
		if class then
			class = class:upper()
		else
			return
		end
		local color = RAID_CLASS_COLORS[class]
		local coords = CLASS_ICON_TCOORDS[class]
		if not color or not coords then return end

		local classfontstring = "|T" .. iconpath .. ":14:14:::256:256:" .. iconOffset(coords[1] * 4, coords[3] * 4) .. "|t"
		if v.Phase == "0" or v.Phase == "99" then
			tooltip:AddDoubleLine(classfontstring .. " " .. v.Class .. " " .. v.Spec, v.Bis, color.r, color.g, color.b, color.r, color.g, color.b, true)
		else
			tooltip:AddDoubleLine(classfontstring .. " " .. v.Class .. " " .. v.Spec, v.Bis.." "..string.gsub(v.Phase, "0", "P"), color.r, color.g, color.b, color.r, color.g, color.b, true)
		end
	end
end

local tooltip_modified = {}
local function onTooltipSetItem(tooltip)
	if not tooltip or not tooltip.GetName then return end
	local tooltipName = tooltip:GetName()
	if tooltip_modified[tooltipName] then return end

	local _, itemLink
	if tooltip.GetItem then
		_, itemLink = tooltip:GetItem()
	end
	if not itemLink then return end
	local itemString = string.match(itemLink, "item[%-?%d:]+")
	if not itemString then return end
	local itemId = tonumber(({ strsplit(":", itemString) })[2])
	if not itemId then return end

	-- Build tooltip data synchronously from already-loaded data
	local combinedTooltip = {}
	local foundCustom = {}

	if LBIS.CustomEditList and LBIS.CustomEditList.Items and LBIS.CustomEditList.Items[itemId] then
		foundCustom = buildCustomTooltip(LBIS.CustomEditList.Items[itemId], combinedTooltip)
	end

	local itemEntries = {}
	if LBIS.ItemsByIdAndSpec[itemId] then
		for key, entry in pairs(LBIS.ItemsByIdAndSpec[itemId]) do
			itemEntries[key] = entry
		end
	end

	if LBIS.TierSources and LBIS.TierSources[itemId] then
		for k, v in pairs(LBIS.TierSources[itemId]) do
			if LBIS.CustomEditList and LBIS.CustomEditList.Items and LBIS.CustomEditList.Items[v] then
				foundCustom = buildCustomTooltip(LBIS.CustomEditList.Items[v], combinedTooltip)
			end
			if LBIS.ItemsByIdAndSpec[v] then
				for key, entry in pairs(LBIS.ItemsByIdAndSpec[v]) do
					itemEntries[key] = entry
				end
			end
		end
	end

	buildCombinedTooltip(itemEntries, combinedTooltip, foundCustom)
	if #combinedTooltip > 0 then
		tooltip_modified[tooltipName] = true
		buildTooltip(tooltip, combinedTooltip)
		tooltip:Show()
	end
end

local function onTooltipCleared(tooltip)
	if tooltip and tooltip.GetName then
		tooltip_modified[tooltip:GetName()] = nil
	end
end

local function onTooltipSetSpell(tooltip)
	if not tooltip or not tooltip.GetSpell then return end
	local _, spellId = tooltip:GetSpell()
	if not spellId then return end

	local combinedTooltip = {}
	if LBIS.SpellsByIdAndSpec and LBIS.SpellsByIdAndSpec[spellId] then
		buildCombinedTooltip(LBIS.SpellsByIdAndSpec[spellId], combinedTooltip, {})
	end
	buildTooltip(tooltip, combinedTooltip)
end

local function registerTooltipClassic(tooltip)
	if tooltip and tooltip.HookScript then
		if tooltip:HasScript("OnTooltipSetItem") then
			tooltip:HookScript("OnTooltipSetItem", onTooltipSetItem)
		end
		if tooltip:HasScript("OnTooltipSetSpell") then
			tooltip:HookScript("OnTooltipSetSpell", onTooltipSetSpell)
		end
		if tooltip:HasScript("OnTooltipCleared") then
			tooltip:HookScript("OnTooltipCleared", onTooltipCleared)
		end
	end
end

local function linkWranglerHook(frame)
	registerTooltipClassic(frame)
end

LBIS:RegisterEvent("PLAYER_ENTERING_WORLD" , function ()
	LBIS.EventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if TooltipDataProcessor then
		-- Retail/Midnight: use TooltipDataProcessor
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
			if tooltip then onTooltipSetItem(tooltip) end
		end)
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(tooltip, data)
			if tooltip then onTooltipSetSpell(tooltip) end
		end)
		-- Clear modified flag when tooltip content changes or hides
		if GameTooltip.HookScript then
			GameTooltip:HookScript("OnTooltipCleared", function(self) onTooltipCleared(self) end)
			GameTooltip:HookScript("OnHide", function(self) onTooltipCleared(self) end)
		end
	else
		-- Classic fallback
		registerTooltipClassic(GameTooltip)
		registerTooltipClassic(ShoppingTooltip1)
		registerTooltipClassic(ShoppingTooltip2)
		registerTooltipClassic(ItemRefTooltip)
		registerTooltipClassic(ItemRefShoppingTooltip1)
		registerTooltipClassic(ItemRefShoppingTooltip2)
	end

	if LinkWrangler then
		LinkWrangler.RegisterCallback("EdrikGameFixes", linkWranglerHook, "allocate", "allocatecomp")
	end

	LBIS:Startup();
end);
