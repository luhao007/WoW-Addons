-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select, type = select, type
local string = _G.string
local format = string.format

-- WoW
local UnitFactionGroup = UnitFactionGroup
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...
local AtlasLoot = _G.AtlasLoot
local data = private.data

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales


-- change sortorder for factions
local ALLIANCE_DIFF, HORDE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", nil, 14)

local PVP_CONTENT = data:AddContentType(AL["PvP"], ATLASLOOT_PVP_COLOR)

--[[ template
data["LEGION7SET"] = {
	name = format(EXPANSION_NAME6.." "..AL["Season %d"], 7).." "..AL["Class Sets"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{ -- DEATHKNIGHT
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DEMONHUNTER
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- DRUID
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- HUNTER
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- MAGE
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- MONK
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- PALADIN
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- PRIEST
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- ROGUE
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- SHAMAN
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- WARLOCK
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{ -- WARRIOR
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
	},
}

data["LEGION7GEAR"] = {
	name = format(EXPANSION_NAME6.." "..AL["Season %d"], 7).." "..AL["Non-Set Gear"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{
			name = format(AL["Legion Season %d Elite"], 7),
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{
			name = format(AL["Legion Season %d"], 7),
			[ALLIANCE_DIFF] = {
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
	},
}
--]]
data["SHADOWLANDSPVP4"] = {
	name = format(AL["Season %d"], 4),
	ContentType = PVP_CONTENT,
	items = {
		{
			name = AL["Non-Set Gear"],
			[NORMAL_DIFF] = {
				{ 1, 199202 }, -- Attendant's Token of Merit
				{ 2, 201355 }, -- Eternal Equipment Chest
				{ 3, 201362 }, -- Fated Equipment Chest

				{ 5, 201875 }, -- Arsenal: Cosmic Aspirant's Weapons
				{ 6, 201873 }, -- Arsenal: Cosmic Gladiator's Weapons

				{ 8, 201841 }, -- Ensemble: Cosmic Aspirant's Plate Armor
				{ 9, 201842 }, -- Ensemble: Cosmic Aspirant's Mail Armor
				{ 10, 201843 }, -- Ensemble: Cosmic Aspirant's Leather Armor
				{ 11, 201844 }, -- Ensemble: Cosmic Aspirant's Cloth Armor
				
				{ 16, 201845 }, -- Ensemble: Cosmic Gladiator's Warrior Armor
				{ 17, 201846 }, -- Ensemble: Cosmic Gladiator's Warlock Armor
				{ 18, 201847 }, -- Ensemble: Cosmic Gladiator's Shaman Armor
				{ 19, 201848 }, -- Ensemble: Cosmic Gladiator's Rogue Armor
				{ 20, 201849 }, -- Ensemble: Cosmic Gladiator's Priest Armor
				{ 21, 201850 }, -- Ensemble: Cosmic Gladiator's Paladin Armor
				{ 22, 201851 }, -- Ensemble: Cosmic Gladiator's Monk Armor
				{ 23, 201852 }, -- Ensemble: Cosmic Gladiator's Mage Armor
				{ 24, 201853 }, -- Ensemble: Cosmic Gladiator's Hunter Armor
				{ 25, 201854 }, -- Ensemble: Cosmic Gladiator's Druid Armor
				{ 26, 201855 }, -- Ensemble: Cosmic Gladiator's Demon Hunter Armor
				{ 27, 201856 }, -- Ensemble: Cosmic Gladiator's Death Knight Armor
			},
		},
	},
}
data["SHADOWLANDSPVP3"] = {
	name = format(AL["Season %d"], 3),
	ContentType = PVP_CONTENT,
	items = {
		{
			name = AL["Non-Set Gear"],
			[NORMAL_DIFF] = {
				{ 1, 187219 }, -- Attendant's Token of Merit
				{ 2, 194118 }, -- Cosmic Equipment Chest
				{ 3, 194334 }, -- Encrypted Equipment Chest

				{ 5, 201875 }, -- Arsenal: Cosmic Aspirant's Weapons
				{ 6, 201873 }, -- Arsenal: Cosmic Gladiator's Weapons
				
				{ 8, 201841 }, -- Ensemble: Cosmic Aspirant's Plate Armor
				{ 9, 201842 }, -- Ensemble: Cosmic Aspirant's Mail Armor
				{ 10, 201843 }, -- Ensemble: Cosmic Aspirant's Leather Armor
				{ 11, 201844 }, -- Ensemble: Cosmic Aspirant's Cloth Armor
				
				{ 16, 201845 }, -- Ensemble: Cosmic Gladiator's Warrior Armor
				{ 17, 201846 }, -- Ensemble: Cosmic Gladiator's Warlock Armor
				{ 18, 201847 }, -- Ensemble: Cosmic Gladiator's Shaman Armor
				{ 19, 201848 }, -- Ensemble: Cosmic Gladiator's Rogue Armor
				{ 20, 201849 }, -- Ensemble: Cosmic Gladiator's Priest Armor
				{ 21, 201850 }, -- Ensemble: Cosmic Gladiator's Paladin Armor
				{ 22, 201851 }, -- Ensemble: Cosmic Gladiator's Monk Armor
				{ 23, 201852 }, -- Ensemble: Cosmic Gladiator's Mage Armor
				{ 24, 201853 }, -- Ensemble: Cosmic Gladiator's Hunter Armor
				{ 25, 201854 }, -- Ensemble: Cosmic Gladiator's Druid Armor
				{ 26, 201855 }, -- Ensemble: Cosmic Gladiator's Demon Hunter Armor
				{ 27, 201856 }, -- Ensemble: Cosmic Gladiator's Death Knight Armor
			},
		},
	},
}
data["SHADOWLANDSPVP2"] = {
	name = format(AL["Season %d"], 2),
	ContentType = PVP_CONTENT,
	items = {
		{
			name = AL["Non-Set Gear"],
			[NORMAL_DIFF] = {
				{ 1 , 188173 }, -- Valorous Equipment Chest
				{ 2 , 188174 }, -- Unchained Equipment Chest

				{ 16, 201877 }, -- Arsenal: Unchained Aspirant's Weapons
				{ 17, 201876 }, -- Arsenal: Unchained Gladiator's Weapons

				{ 4, 201857 }, -- Ensemble: Unchained Aspirant's Plate Armor
				{ 5, 201858 }, -- Ensemble: Unchained Aspirant's Mail Armor
				{ 6, 201859 }, -- Ensemble: Unchained Aspirant's Leather Armor
				{ 7, 201860 }, -- Ensemble: Unchained Aspirant's Cloth Armor
				
				{ 19, 201861 }, -- Ensemble: Unchained Gladiator's Plate Armor
				{ 20, 201862 }, -- Ensemble: Unchained Gladiator's Mail Armor
				{ 21, 201863 }, -- Ensemble: Unchained Gladiator's Leather Armor
				{ 22, 201864 }, -- Ensemble: Unchained Gladiator's Cloth Armor
			},
		},
	},
}
data["SHADOWLANDSPVP1"] = {
	name = format(AL["Season %d"], 1),
	ContentType = PVP_CONTENT,
	items = {
		{
			name = AL["Non-Set Gear"],
			[NORMAL_DIFF] = {
				{ 1, 201865 }, -- Ensemble: Sinful Aspirant's Plate Armor
				{ 2, 201866 }, -- Ensemble: Sinful Aspirant's Mail Armor
				{ 3, 201867 }, -- Ensemble: Sinful Aspirant's Leather Armor
				{ 4, 201868 }, -- Ensemble: Sinful Aspirant's Cloth Armor
				
				{ 16, 201869 }, -- Ensemble: Sinful Gladiator's Plate Armor
				{ 17, 201870 }, -- Ensemble: Sinful Gladiator's Mail Armor
				{ 18, 201871 }, -- Ensemble: Sinful Gladiator's Leather Armor
				{ 19, 201872 }, -- Ensemble: Sinful Gladiator's Cloth Armor
				
				{ 6, 201878 }, -- Arsenal: Sinful Aspirant's Weapons
				{ 21, 201879 }, -- Arsenal: Sinful Gladiator's Revendreth Weapons
				{ 22, 201880 }, -- Arsenal: Sinful Gladiator's Maldraxxus Weapons
				{ 23, 201881 }, -- Arsenal: Sinful Gladiator's Bastion Weapons
				{ 24, 201882 }, -- Arsenal: Sinful Gladiator's Ardenweald Weapons
			},
		},
	},
}

