local AtlasLoot = _G.AtlasLoot
local ItemString = {}
AtlasLoot.ItemString = ItemString

local BonusIDInfo = AtlasLoot.BonusIDInfo

local GetDetailedItemLevelInfo = C_Item.GetDetailedItemLevelInfo

-- lua
local format = string.format
local tbl_concat = table.concat

local ITEM_FORMAT_ALL_STRING = "item:%d:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s"
local ITEM_FORMAT_BONUS_STRING = "item:%d:::::::::%s::%s:%d:%s"

local ITEM_LVL_BONUS = BonusIDInfo.GetBonusListLevelDelta()

local TITANFORGED_ADD = { 3442 }
local LEGION_MAX_UPGRADELVL = 255
local BFA_MAX_UPGRADELVL = 450
local function GetPresetForTitanforged(baseLvl, maxLvl, extraBonus)
	baseLvl = baseLvl or maxLvl
	baseLvl = maxLvl - baseLvl
	local tab = {
		ITEM_LVL_BONUS[baseLvl] or nil
	}
	if extraBonus then
		for i = 1, #extraBonus do
			tab[#tab + 1] = extraBonus[i]
		end
	end
	return tab
end

local GetScaledItem_Cache = {}
local function GetScaledItem(itemID, difficultyID, newLvl)
	local effectiveILvl, isPreview, baseILvl = GetDetailedItemLevelInfo(itemID)
	if not baseILvl then return end
	local cacheString = baseILvl..difficultyID..newLvl
	if not GetScaledItem_Cache[cacheString] then
		local specID
		if (GetSpecialization()) then
			specID = GetSpecializationInfo(GetSpecialization())
		end

		local difficultyBonusID, difficulty = BonusIDInfo.GetItemBonusIDByDiff(difficultyID)
		-- New effectiveILvl
		effectiveILvl, isPreview, baseILvl = GetDetailedItemLevelInfo(format(ITEM_FORMAT_BONUS_STRING, itemID, specID or "", difficulty, #difficultyBonusID, difficultyBonusID[1] or ""))

		if effectiveILvl >= newLvl then
			GetScaledItem_Cache[cacheString] = difficultyBonusID
		else
			difficultyBonusID, difficulty = BonusIDInfo.GetItemBonusIDByDiff_Raw(difficultyID)

			GetScaledItem_Cache[cacheString] = difficulty == 0 and {} or difficultyBonusID

			if newLvl - effectiveILvl >= 15 then
				-- Titanforged
				GetScaledItem_Cache[cacheString][#GetScaledItem_Cache[cacheString] + 1] = 3442
			elseif newLvl - effectiveILvl > 0 then
				-- Warforged
				GetScaledItem_Cache[cacheString][#GetScaledItem_Cache[cacheString] + 1] = 3441
			end

			effectiveILvl = newLvl - baseILvl
			GetScaledItem_Cache[cacheString][#GetScaledItem_Cache[cacheString] + 1] = ITEM_LVL_BONUS[effectiveILvl] or 0
		end
	end

	return GetScaledItem_Cache[cacheString]
end

local function needsBonus(itemID)
	local _, _, _, _, _, typeID = C_Item.GetItemInfoInstant(itemID)
	if (typeID ~= 2 and typeID ~= 3 and typeID ~= 4 and not AtlasLoot.Data.Token.Token[itemID]) then
		return false
	else
		return true
	end
end

local C_ITEM_BONUS_PRESET = {
	["nil"] = {}
}
local ITEM_BONUS_PRESET = {
	["Scaling"]                           = { 3524 }, -- ...
	-- Dungeons
	["BSM"]                               = { 3524, 518 },
	["ID"]                                = { 3524, 519 },
	["Auch"]                              = { 3524, 520 },
	["Skyreach"]                          = { 3524, 521 },
	["Dungeon"]                           = { 3524, 522 },
	["HCDungeon"]                         = { 524 },
	["HCDungeonWarforged"]                = { 524, 448 },
	["MDungeon"]                          = { 642 },
	["MDungeonWarforged"]                 = { 642, 644 },
	-- ## Legion
	["LegionDungeon"]                     = { 3524, 1826 },
	["LegionDungeonTitanforged"]          = GetPresetForTitanforged(162, LEGION_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 1826, 1522 },
	["LegionHCDungeon"]                   = { 1726 },
	["LegionHCDungeonTitanforged"]        = GetPresetForTitanforged(162, LEGION_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 1726, 1522 },
	["LegionMDungeon"]                    = { 1727 },
	["LegionMDungeonTitanforged"]         = GetPresetForTitanforged(162, LEGION_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 1727, 1522 },
	["LegionMDungeon2"]                   = { 3452 },
	["LegionMDungeon2Titanforged"]        = GetPresetForTitanforged(162, LEGION_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 3452, 1522 },
	["LegionMaxItemLvl"]                  = function(itemID, difficultyID, baseLvl)
		return GetScaledItem(itemID, difficultyID, LEGION_MAX_UPGRADELVL)
	end,
	-- ## BFA
	["BfAMaxItemLvl"]                     = function(itemID, difficultyID, baseLvl)
		return GetScaledItem(itemID, difficultyID, BFA_MAX_UPGRADELVL)
	end,
	--["BfADungeon"]			= { 3524, 1826 },
	["BfADungeonTitanforged"]             = GetPresetForTitanforged(300, BFA_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 1826, 1522 },
	--["BfAHCDungeon"]			= { 1726 },
	["BfAHCDungeonTitanforged"]           = GetPresetForTitanforged(300, BFA_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 1726, 1522 },
	--["BfAMDungeon"] 			= { 1727 },
	["BfAMDungeonTitanforged"]            = GetPresetForTitanforged(300, BFA_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 1727, 1522 },
	--["BfAMDungeon2"]			= { 3452 },
	["BfAMDungeon2Titanforged"]           = GetPresetForTitanforged(300, BFA_MAX_UPGRADELVL, TITANFORGED_ADD), --{ 3452, 1522 },
	-- Raids
	["LFR"]                               = { 451 },
	["SoOWarforged"]                      = { 448 },
	["HeroicSoO"]                         = { 449 },
	["HeroicSoOWarforged"]                = { 449, 448 },
	["MythicSoO"]                         = { 450 },
	["MythicSoOWarforged"]                = { 450, 448 },
	["RaidWarforged"]                     = { 560 },
	["HeroicRaid"]                        = { 566 },
	["HeroicRaidWarforged"]               = { 566, 561 },
	["MythicRaid"]                        = { 567 },
	["MythicRaidWarforged"]               = { 567, 562 },
	["LegionLFR"]                         = { 3379 },
	["LegionLFRTitanforged"]              = { 1522, 3442 },
	["LegionRaid"]                        = { 1807 },
	["LegionRaidTitanforged"]             = { 1522, 3442 },
	["LegionHeroicRaid"]                  = { 1805 },
	["LegionHeroicRaidTitanforged"]       = { 1522, 3442 },
	["LegionMythicRaid"]                  = { 1806 },
	["LegionMythicRaidTitanforged"]       = { 1522, 3442 },

	["LegionEmeraldNightmareTitanforged"] = { 1547, 3442 },
	["LegionNightholdTitanforged"]        = { 1522, 3442 },

	["LegionMaxTitanforgedByBaseLvl"]     = function(itemID, difficultyID, baseLvl) -- set the baseLvl with "ItemBaseLvl = 000," in the Instance Table.
		if not baseLvl then return C_ITEM_BONUS_PRESET["nil"] end
		if not C_ITEM_BONUS_PRESET["LegionMaxTitanforgedByBaseLvl"..baseLvl] then
			C_ITEM_BONUS_PRESET["LegionMaxTitanforgedByBaseLvl"..baseLvl] = GetPresetForTitanforged(baseLvl, LEGION_MAX_UPGRADELVL, TITANFORGED_ADD) -- 3442 adds "Titanforged"
		end
		return C_ITEM_BONUS_PRESET["LegionMaxTitanforgedByBaseLvl"..baseLvl]
	end,

	-- Crafting
	["Stage1"]                            = { 525 },
	["Stage2"]                            = { 526 },
	["Stage3"]                            = { 527 },
	["Stage4"]                            = { 593 },
	["Stage5"]                            = { 617 },
	["Stage6"]                            = { 618 },
	["Stage2W"]                           = { 558 },
	["Stage3W"]                           = { 559 },
	["Stage4W"]                           = { 594 },
	["Stage5W"]                           = { 619 },
	["Stage6W"]                           = { 620 },
	-- Heirloom
	["Stage2H"]                           = { 582 },
	["Stage3H"]                           = { 583 }
}

function ItemString.Create(item)
	return format(ITEM_FORMAT_ALL_STRING,
		item.itemID,
		item.enchantID or "",
		item.gems and item.gems[1] or "",
		item.gems and item.gems[2] or "",
		item.gems and item.gems[3] or "",
		item.gems and item.gems[4] or "",
		item.suffixID or "",
		item.uniqueID or "",
		item.linkLevel or "",
		item.specializationID or "",
		item.modifiersMask or "",
		item.itemContext or "",
		item.bonusIDs and #item.bonusIDs or "",
		item.bonusIDs and tbl_concat(item.bonusIDs, ":") or ""
	)
end

function ItemString.Parse(link)
	local simpleTypes = {
		itemID = 1,
		enchantID = 2,
		suffixID = 7,
		uniqueID = 8,
		linkLevel = 9,
		specializationID = 10,
		modifiersMask = 11,
		itemContext = 12,
	}

	-- Only using this for item strings, not links, right now, so just remove "item:"
	--local _, linkOptions = LinkUtil.ExtractLink(link)
	local linkOptions = gsub(link, "item:", "")

	local item = { strsplit(":", linkOptions) }
	local t = {}

	for k, v in pairs(simpleTypes) do
		t[k] = tonumber(item[v])
	end

	for i = 1, 4 do
		local gem = tonumber(item[i + 2])
		if gem then
			t.gems = t.gems or {}
			t.gems[i] = gem
		end
	end

	local idx = 13
	local numBonusIDs = tonumber(item[idx])
	if numBonusIDs then
		t.bonusIDs = {}
		for i = 1, numBonusIDs do
			t.bonusIDs[i] = tonumber(item[idx + i])
		end
	end
	idx = idx + (numBonusIDs or 0) + 1

	local numModifiers = tonumber(item[idx])
	if numModifiers then
		t.modifiers = {}
		for i = 1, numModifiers do
			local offset = i * 2
			t.modifiers[i] = {
				tonumber(item[idx + offset - 1]),
				tonumber(item[idx + offset])
			}
		end
		idx = idx + numModifiers * 2 + 1
	else
		idx = idx + 1
	end

	for i = 1, 3 do
		local relicNumBonusIDs = tonumber(item[idx])
		if relicNumBonusIDs then
			t.relicBonusIDs = t.relicBonusIDs or {}
			t.relicBonusIDs[i] = {}
			for j = 1, relicNumBonusIDs do
				t.relicBonusIDs[i][j] = tonumber(item[idx + j])
			end
		end
		idx = idx + (relicNumBonusIDs or 0) + 1
	end

	local crafterGUID = item[idx]
	if crafterGUID and #crafterGUID > 0 then
		t.crafterGUID = crafterGUID
	end
	idx = idx + 1

	t.extraEnchantID = tonumber(item[idx])

	return t
end

--|cff0070dd|Hitem:151433::::::::110:581::1:1:3524:::|h[Thick Shellplate Shoulders]|h|r
function ItemString.AddBonus(itemID, bonus, difficultyID, baseLvl)
	-- Only add bonuses for weapons, gems, armor and tier tokens
	if not needsBonus(itemID) then return end

	bonus = bonus and (ITEM_BONUS_PRESET[bonus] or ITEM_BONUS_PRESET[bonus[1]]) or bonus
	if bonus and type(bonus) == "string" then print(bonus) elseif bonus and type(bonus) == "function" then bonus = bonus(itemID, difficultyID, baseLvl) end
	local difficulty
	if difficultyID then
		difficultyID, difficulty = BonusIDInfo.GetItemBonusIDByDiff(difficultyID)
		if bonus then
			--for i = 1,#bonus do
			--	difficultyID[#difficultyID+1] = bonus[i]
			--end
			difficultyID = bonus
		end
		bonus = difficultyID
	end

	local specID
	if (GetSpecialization()) then
		specID = GetSpecializationInfo(GetSpecialization())
	end

	return format(ITEM_FORMAT_BONUS_STRING,
		itemID,
		specID or "",
		difficulty or "",
		bonus and #bonus or 0,
		bonus and tbl_concat(bonus, ":") or ""
	)
end

-- difficultyID = http://wow.gamepedia.com/DifficultyID
function ItemString.AddBonusByDifficultyID(itemID, difficultyID, includeSpecID)
	-- Only add bonuses for weapons, gems, armor and tier tokens
	if not needsBonus(itemID) then return end

	local difficultyBonusID, difficulty = BonusIDInfo.GetItemBonusIDByDiff(difficultyID)

	local specID
	if (includeSpecID and GetSpecialization()) then
		specID = GetSpecializationInfo(GetSpecialization())
	end

	return format(ITEM_FORMAT_BONUS_STRING,
		itemID,
		specID or "",
		difficulty,
		1,
		difficultyBonusID[1]
	)
end
