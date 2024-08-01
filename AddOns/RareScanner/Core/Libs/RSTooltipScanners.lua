-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSTooltipScanners = private.NewLib("RareScannerTooltipScanners")

-- RareScanner general libraries
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- NPCs tooltip scanner
---============================================================================
	
function RSTooltipScanners.ScanNpcName(npcID, callback, secondTry)
	local tooltipData = C_TooltipInfo.GetHyperlink('unit:Creature-0-0-0-0-' .. npcID .. '-0')
	if (tooltipData) then
		if (tooltipData.lines and tooltipData.lines[1] and tooltipData.lines[1].leftText) then
			local name = tooltipData.lines[1].leftText
			private.dbglobal.rare_names[GetLocale()][tonumber(npcID)] = name
			if (callback) then
				callback(name)
			end
		end
	elseif (not secondTry) then
		C_Timer.After(1, function()
			RSTooltipScanners.ScanNpcName(npcID, callback, true)
		end)
	elseif (callback) then
		callback()
	end
end

---============================================================================
-- Loot tooltip scanner
---============================================================================

local function ScanItem(tooltipData, value)
	local foundText = false
	
	if (tooltipData and tooltipData.lines) then
		for i=1, #tooltipData.lines do
			if (tooltipData.lines[i]) then	
				local toolTipText = tooltipData.lines[i].leftText
				if (toolTipText and RSUtils.Contains(toolTipText, value)) then
					foundText = true
					break
				end
			end
		end
	end
	
	return foundText
end

function RSTooltipScanners.ScanLootByItemID(itemID, value)
	return ScanItem(C_TooltipInfo.GetItemByID(itemID), value)
end

function RSTooltipScanners.ScanLoot(itemLink, value)
	return ScanItem(C_TooltipInfo.GetHyperlink(itemLink), value)
end
