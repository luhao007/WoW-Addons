local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Table containing external parameters used by the addon, such as game entity IDs, Delves parameters, limits, etc.
---@class Config
local Config = {}
DelveCompanion.Config = Config

---@type number Delves have been introduced in TWW. It's used in different frames to display relevant content depending on the selected expansion.
Config.DELVES_MIN_EXPANSION = LE_EXPANSION_WAR_WITHIN

--#region Save Data

--- Account Save Data scheme
---@class (exact) DelveCompanionAccountData
---@field logsEnabled boolean Whether logs are enabled.
---@field delvesListInfoWidgetsEnabled boolean Delves tab: achievement widgets under buttons.
---@field trackingType WaypointTrackingType Type of tracking used to set waypoints to the Delves.
---@field inDelveWidgetEnabled boolean Whether [InDelveWidget](lua://InDelveWidget) is displayed.
---@field inDelveWidgetDisplayRule InDelveWidgetDisplayRule Where [InDelveWidget](lua://InDelveWidget) is displayed.
---@field inDelveWidgetLayout InDelveWidgetLayout How [InDelveWidget](lua://InDelveWidget) buttons are arranged.
---@field minimapIconEnabled boolean Whether a minimap icon is enabled.
---@field displayStoryStatusInGossip boolean Whether to display Story Variant status in Delves' Gossip.
---@field delveAutoEnterEnabled boolean Whether to enter Delves automatically once Gossip is shown.
---@field delveAutoEnterTier number Delve Tier to enter.
---@field delveAutoEnterDelaySec number A delay in seconds before entering the Delve.
Config.DEFAULT_ACCOUNT_DATA = {
    logsEnabled = false,
    delvesListInfoWidgetsEnabled = true,
    trackingType = DelveCompanion.Definitions.WaypointTrackingType.superTrack,
    inDelveWidgetEnabled = true,
    inDelveWidgetDisplayRule = DelveCompanion.Definitions.InDelveWidgetDisplayRule.left,
    inDelveWidgetLayout = DelveCompanion.Definitions.InDelveWidgetLayout.vertical,
    minimapIconEnabled = false,
    displayStoryStatusInGossip = true,
    delveAutoEnterEnabled = false,
    delveAutoEnterTier = 1,
    delveAutoEnterDelaySec = 3
}

--- Character Save Data
---@class (exact) DelveCompanionCharacterData
---@field keysCapTooltipEnabled boolean Whether to display extra info in tooltips. Bad naming, affects all tooltips, not only Restored Coffer Key.
---@field ldbIconData {hide : boolean} Used by LDBIcon to keep parameters of the minimap icon.
Config.DEFAULT_CHARACTER_DATA = {
    keysCapTooltipEnabled = true,
    ldbIconData = {
        hide = true
    }
}
--#endregion

--#region TWW legacy
---@type number Item ID of [Delve-O-Bot 7001](https://www.wowhead.com/item=230850/delve-o-bot-7001).
Config.DELVE_O_BOT_ITEM_CODE = 230850

---@type number Item ID of [Radiant Echo](https://www.wowhead.com/item=246771/radiant-echo).
Config.ECHO_ITEM_CODE = 246771
--#endregion

--#region Restored Coffer Key

---@type number Currency ID of [Restored Coffer Key](https://www.wowhead.com/currency=3028/restored-coffer-key).
Config.BOUNTIFUL_KEY_CURRENCY_CODE = 3028
---@type number Currency ID of [Coffer Key Shards](https://www.wowhead.com/currency=3310/coffer-key-shards).
Config.KEY_SHARDS_CURRENCY_CODE = 3310

---@type number Amount of [Coffer Key Shards](https://www.wowhead.com/item=236096/coffer-key-shard) required to assemble [Restored Coffer Key](https://www.wowhead.com/currency=3028/restored-coffer-key).
Config.SHARDS_FOR_KEY = 100

---@type number Item ID of [Bountiful Coffer](https://www.wowhead.com/item=254250/bountiful-coffer).
Config.BOUNTIFUL_COFFER_ITEM_CODE = 254250
--#endregion

---@type number Currency ID of [Untainted Mana-Crystals](https://www.wowhead.com/currency=3356/untainted-mana-crystals).
Config.MANA_CRYSTALS_CURRENCY_CODE = 3356

---@type number Item ID of [L00T RAID-R Mini](https://www.wowhead.com/item=244193/l00t-raid-r-mini).
Config.LOOT_RADAR_ITEM_CODE = 244193
-- Config.LOOT_RADAR_ACTIVATED_SPELL = 1236623 -- USELESS at the moment. There is no buff or aura when the radar is active.

---@type table<number, number> Item ID of a Nemesis lure.
Config.NEMESIS_LURE = {
    [LE_EXPANSION_MIDNIGHT] = 253342 -- Beacon of Hope
}

--#region Bounty Map.

---@type table<number, number> Item ID of Bounty Map.
Config.BOUNTY_MAPS = {
    [LE_EXPANSION_MIDNIGHT] = 252415 -- Trovehunter's Bounty
}
---@type table<number, number> Spell ID of the active Bounty Map.
Config.BOUNTY_ACTIVATED_SPELL = {
    [LE_EXPANSION_MIDNIGHT] = 1254631 -- Trovehunter's Bounty
}

---@type number Weekly cap of maps (per character).
Config.BOUNTY_MAP_MAX_PER_WEEK = 1
---@type number Quest ID used to track whether player has looted Bounty Map during the week.
Config.BOUNTY_MAP_QUEST = 86371
--#endregion

--#region Gilded Stash

---@type number Spell ID of [Gilded Stash](https://www.wowhead.com/spell=1216211/gilded-stash).
Config.GILDED_STASH_SPELL_CODE = 1216211
--#endregion

--#region Seasonal modifiers

---@class (exact) DelveConfigAffixes : table
---@field Nemesis table<number, number>

---@type DelveConfigAffixes Spell ID of Delve affixes.
Config.AFFIXES = {
    -- [Nemesis Strongbox](https://www.wowhead.com/spell=1239535/nemesis-strongbox).
    Nemesis = {
        [LE_EXPANSION_MIDNIGHT] = 1270179
    }
}
--#endregion

---@type table<number, number> Quest ID required to unlock a Companion.
Config.COMPANION_UNLOCK_QUEST = {
    [LE_EXPANSION_WAR_WITHIN] = 78464,
    [LE_EXPANSION_MIDNIGHT] = 86636
}

---@type table<number, number> [Faction IDs](https://wago.tools/db2/Faction) of the Delves seasons. Used on the Journeys tab.
Config.DELVE_FACTION_ID = {
    [LE_EXPANSION_WAR_WITHIN] = 2722, -- TWW Season 3
    [LE_EXPANSION_MIDNIGHT] = 2742    -- Midnight Season 1
}

--#region Delves data

---@type table<number, number> [uiMapID](https://warcraft.wiki.gg/wiki/UiMapID) of continents with delves by expansion.
Config.DELVE_CONTINENTS = {
    [LE_EXPANSION_WAR_WITHIN] = 2274,
    [LE_EXPANSION_MIDNIGHT] = 2537
}

---@type table<number, number[]> List of [uiMapIDs](https://warcraft.wiki.gg/wiki/UiMapID) which contain Delves.
--- Grouped by LE_EXPANSION enum. Controls display order of zones in the list.
Config.DELVE_MAPS = {
    [LE_EXPANSION_WAR_WITHIN] = {
        2371, -- K`aresh
        2346, -- Undermine
        2248, -- Isle of Dorn
        2214, -- The Ringing Deeps
        2215, -- Hallowfall
        2255, -- Azj-Kahet
    },
    [LE_EXPANSION_MIDNIGHT] = {
        2405, -- Voidstorm
        2413, -- Harandar
        2437, -- Zul'Aman
        2395, -- Eversong Woods
        2393, -- Silvermoon City
        2424, -- Isle of Quel'Danas
    }
}

---@class (exact) DelveConfigAchievements
---@field story number?
---@field chest number?
---@field nemesisSolo number?

---@class (exact) DelveConfigNemesisInfo
---@field isCurrentSeason boolean
---@field delveTooltipLine string

--- Table with Delve parameters.
---@class (exact) DelveConfig
---@field uiMapID number Delve [uiMapID](https://warcraft.wiki.gg/wiki/UiMapID).
---@field poiIDs {regular: number, bountiful: number?} Delve [areaPoiIDs](https://wago.tools/db2/areapoi).
---@field gildedStashUiWidgetID number? [UiWidgetID](https://wago.tools/db2/UiWidget) used to retrieve information about [Gilded Stash](https://www.wowhead.com/spell=1216211/gilded-stash) weekly progress.
---@field atlasBgID string [AtlasID](https://warcraft.wiki.gg/wiki/AtlasID) used to get Delve's background texture. These are grouped into separate atlases for major patches.
---@field achievements DelveConfigAchievements Achievement IDs related to the Delve.
---@field coordinates MapCoord? Delve entrance coordinates. Used primarly for Boss Delves and non-Blizzard waypoints (e.g. TomTom).
---@field nemesisInfo DelveConfigNemesisInfo?

---@type table<number, DelveConfig[]> Table of all Delves in the game and their parameters. Grouped by LE_EXPANSION enum.
Config.DELVES_CONFIG = {
    [LE_EXPANSION_WAR_WITHIN] = {
        -- Earthcrawl Mines
        {
            uiMapID = 2269,
            poiIDs = {
                regular = 7863,
                bountiful = 7787
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-earthcrawl-mines",
            achievements = {
                chest = 40806,
                story = 40527
            }
        },
        -- Fungal Folly
        {
            uiMapID = 2249,
            poiIDs = {
                regular = 7864,
                bountiful = 7779
            },
            gildedStashUiWidgetID = 6728,
            atlasBgID = "delve-entrance-background-fungal-folly",
            achievements = {
                chest = 40803,
                story = 40525
            }
        },
        -- Kriegval's Rest
        {
            uiMapID = 2250,
            poiIDs = {
                regular = 7865,
                bountiful = 7781
            },
            gildedStashUiWidgetID = 6719,
            atlasBgID = "delve-entrance-background-kriegvals-rest",
            achievements = {
                chest = 40807,
                story = 40526
            }
        },
        -- The Waterworks
        {
            uiMapID = 2251,
            poiIDs = {
                regular = 7866,
                bountiful = 7782
            },
            gildedStashUiWidgetID = 6720,
            atlasBgID = "delve-entrance-background-the-waterworks",
            achievements = {
                chest = 40816,
                story = 40528
            }
        },
        -- The Dread Pit
        {
            uiMapID = 2302,
            poiIDs = {
                regular = 7867,
                bountiful = 7788
            },
            gildedStashUiWidgetID = 6724,
            atlasBgID = "delve-entrance-background-the-dread-pit",
            achievements = {
                chest = 40812,
                story = 40529
            }
        },
        -- Excavation Site 9
        {
            uiMapID = 2396,
            poiIDs = {
                regular = 8143,
                bountiful = 8181
            },
            gildedStashUiWidgetID = 6659,
            atlasBgID = "delve-entrance-background-the-undermine",
            achievements = {
                chest = 41100,
                story = 41098
            }
        },
        -- The Sinkhole
        {
            uiMapID = 2300,
            poiIDs = {
                regular = 7870,
                bountiful = 7783
            },
            gildedStashUiWidgetID = 6721,
            atlasBgID = "delve-entrance-background-the-sinkhole",
            achievements = {
                chest = 40813,
                story = 40532
            }
        },
        -- Nightfall Sanctum
        {
            uiMapID = 2277,
            poiIDs = {
                regular = 7868,
                bountiful = 7785
            },
            gildedStashUiWidgetID = 6727,
            atlasBgID = "delve-entrance-background-nightfall-sanctum",
            achievements = {
                chest = 40809,
                story = 40530
            }
        },
        -- Mycomancer Cavern
        {
            uiMapID = 2312,
            poiIDs = {
                regular = 7869,
                bountiful = 7780
            },
            gildedStashUiWidgetID = 6729,
            atlasBgID = "delve-entrance-background-mycomancer-cavern",
            achievements = {
                chest = 40808,
                story = 40531
            }
        },
        -- Skittering Breach
        {
            uiMapID = 2310,
            poiIDs = {
                regular = 7871,
                bountiful = 7789
            },
            gildedStashUiWidgetID = 6725,
            atlasBgID = "delve-entrance-background-skittering-breach",
            achievements = {
                chest = 40810,
                story = 40533
            }
        },
        -- The Spiral Weave
        {
            uiMapID = 2313,
            poiIDs = {
                regular = 7874,
                bountiful = 7790
            },
            gildedStashUiWidgetID = 6726,
            atlasBgID = "delve-entrance-background-the-spiral-weave",
            achievements = {
                chest = 40814,
                story = 40536
            }
        },
        -- The Underkeep
        {
            uiMapID = 2299,
            poiIDs = {
                regular = 7872,
                bountiful = 7786
            },
            gildedStashUiWidgetID = 6794,
            atlasBgID = "delve-entrance-background-the-underkeep",
            achievements = {
                chest = 40815,
                story = 40534
            }
        },
        -- Tak-Rethan Abyss
        {
            uiMapID = 2259,
            poiIDs = {
                regular = 7873,
                bountiful = 7784
            },
            gildedStashUiWidgetID = 6722,
            atlasBgID = "delve-entrance-background-tak-rethan-abyss",
            achievements = {
                chest = 40811,
                story = 40535
            }
        },
        -- Sidestreet Sluice
        {
            uiMapID = 2420,
            poiIDs = {
                regular = 8140,
                bountiful = 8246
            },
            gildedStashUiWidgetID = 6718,
            atlasBgID = "delves-entrance-background-sewers",
            achievements = {
                chest = 41101,
                story = 41099
            }
        },
        -- Archival Assault
        {
            uiMapID = 2452,
            poiIDs = {
                regular = 8274,
                bountiful = 8273
            },
            gildedStashUiWidgetID = 7193,
            atlasBgID = "delve-entrance-background-Archival-Assault",
            achievements = {
                chest = 42679,
                story = 42771
            }
        },
        -- Zekvir's Lair
        {
            uiMapID = 2348,
            poiIDs = {
                regular = 7875
            },
            coordinates = {
                x = 32.74,
                y = 76.87
            },
            atlasBgID = "delve-entrance-background-zekvirs-lair",
            achievements = {
                nemesisSolo = 40433
            },
            nemesisInfo = {
                isCurrentSeason = false,
                delveTooltipLine = DelveCompanion.Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S1
            }
        },
        -- Demolition Dome
        {
            uiMapID = 2425,
            poiIDs = {
                regular = 8142
            },
            coordinates = {
                x = 50.43,
                y = 11.82
            },
            atlasBgID = "delve-entrance-background-goblin-boss",
            achievements = {
                nemesisSolo = 41210
            },
            nemesisInfo = {
                isCurrentSeason = false,
                delveTooltipLine = DelveCompanion.Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S2
            }
        },
        -- Voidrazor Sanctuary
        {
            uiMapID = 2484,
            poiIDs = {
                regular = 8323
            },
            coordinates = {
                x = 64.34,
                y = 78.62
            },
            atlasBgID = "delve-entrance-background-Voidrazor-Sanctuary",
            achievements = {
                nemesisSolo = 42190
            },
            nemesisInfo = {
                isCurrentSeason = false,
                delveTooltipLine = DelveCompanion.Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_TWW_S3
            }
        }
    },
    [LE_EXPANSION_MIDNIGHT] = {
        -- Gulf of Memory
        {
            uiMapID = 2505,
            poiIDs = {
                regular = 8435,
                bountiful = 8436
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-gulf-of-memory",
            achievements = {
                chest = 61898,
                story = 61731
            }
        },
        -- Parhelion Plaza
        {
            uiMapID = 2545,
            poiIDs = {
                regular = 8427,
                bountiful = 8428
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-parhelion-plaza",
            achievements = {
                chest = 61893,
                story = 61725
            }
        },
        -- Atal'Aman
        {
            uiMapID = 2535,
            poiIDs = {
                regular = 8443,
                bountiful = 8444
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-atal-aman",
            achievements = {
                chest = 61863,
                story = 61729
            }
        },
        -- Collegiate Calamity
        {
            uiMapID = 2577,
            poiIDs = {
                regular = 8425,
                bountiful = 8426
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-collegiate-calamity",
            achievements = {
                chest = 61894,
                story = 61726
            }
        },
        -- Shadowguard Point
        {
            uiMapID = 2506,
            poiIDs = {
                regular = 8431,
                bountiful = 8432
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-shadowguard-point",
            achievements = {
                chest = 61900,
                story = 61733
            }
        },
        -- The Grudge Pit
        {
            uiMapID = 2510,
            poiIDs = {
                regular = 8433,
                bountiful = 8434
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-the-grudge-pit",
            achievements = {
                chest = 61897,
                story = 61724
            }
        },
        -- Twilight Crypts
        {
            uiMapID = 2503,
            poiIDs = {
                regular = 8441,
                bountiful = 8442
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-twilight-crypts",
            achievements = {
                chest = 61896,
                story = 61730
            }
        },
        -- Shadow Enclave
        {
            uiMapID = 2502,
            poiIDs = {
                regular = 8437,
                bountiful = 8438
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-the-shadow-enclave",
            achievements = {
                chest = 61892,
                story = 61727
            }
        },
        -- The Darkway
        {
            uiMapID = 2525,
            poiIDs = {
                regular = 8439,
                bountiful = 8440
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-the-darkway",
            achievements = {
                chest = 61895,
                story = 61728
            }
        },
        -- Sunkiller Sanctum
        {
            uiMapID = 2528,
            poiIDs = {
                regular = 8429,
                bountiful = 8430
            },
            gildedStashUiWidgetID = 7591,
            atlasBgID = "delve-entrance-background-sunkiller-sanctum",
            achievements = {
                chest = 61899,
                story = 61732
            }
        },
        -- Torment's Rise
        {
            uiMapID = 2507,
            poiIDs = {
                regular = 8445
            },
            coordinates = {
                x = 61.17,
                y = 71.6
            },
            atlasBgID = "delve-entrance-background-torments-rise",
            achievements = {
                nemesisSolo = 61799
            },
            nemesisInfo = {
                isCurrentSeason = true,
                delveTooltipLine = DelveCompanion.Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_NEMESIS_MIDNIGHT_S1
            }
        },
    }
}

--- Table to assign a color depending on ilvl.
---@class (exact) LootRarity
---@field from number Left value of the range, inclusive.
---@field to number Right value of the range, inclusive.
---@field color colorRGBA Color for such an ilvl.

---@type table<number, LootRarity[]>
Config.LOOT_RARITY = {
    [1] = {
        from = 220,
        to = 230,
        color = _G["ITEM_SUPERIOR_COLOR"]
    },
    [2] = {
        from = 231,
        to = 243,
        color = _G["ITEM_EPIC_COLOR"]
    },
    [3] = {
        from = 244,
        to = 256,
        color = _G["ITEM_LEGENDARY_COLOR"]
    },
    [4] = {
        from = 257,
        to = 269,
        color = _G["ITEM_ARTIFACT_COLOR"]
    }
}

--- Table with Delve Loot information
---@class (exact) DelveLootInfo
---@field bountifulLvl number Item Level player gets opening [Bountiful Coffer](https://www.wowhead.com/item=228942/bountiful-coffer).
---@field vaultLvl number Item Level player gets from the Great Vault completing the corresponding Delve Tier.
---@field mapLvl number? Item Level player gets from the Bounty Map chest completing the corresponding Delve Tier. Can be nil because Bounty Map reward is unavailable for some tiers.

--- Indexed table of Delves Loot information (index = Tier).
---@type table<number, DelveLootInfo[]>
Config.DELVES_LOOT_INFO_DATA = {
    [1] = {
        bountifulLvl = 220,
        vaultLvl = 233
    },
    [2] = {
        bountifulLvl = 224,
        vaultLvl = 237
    },
    [3] = {
        bountifulLvl = 227,
        vaultLvl = 240
    },
    [4] = {
        bountifulLvl = 230,
        vaultLvl = 243,
        mapLvl = 237
    },
    [5] = {
        bountifulLvl = 233,
        vaultLvl = 246,
        mapLvl = 243
    },
    [6] = {
        bountifulLvl = 237,
        vaultLvl = 253,
        mapLvl = 246
    },
    [7] = {
        bountifulLvl = 246,
        vaultLvl = 256,
        mapLvl = 250
    },
    [8] = {
        bountifulLvl = 250,
        vaultLvl = 259,
        mapLvl = 259
    },
    [9] = {
        bountifulLvl = 250,
        vaultLvl = 259,
        mapLvl = 259
    },
    [10] = {
        bountifulLvl = 250,
        vaultLvl = 259,
        mapLvl = 259
    },
    [11] = {
        bountifulLvl = 250,
        vaultLvl = 259,
        mapLvl = 259
    }
}
--#endregion
