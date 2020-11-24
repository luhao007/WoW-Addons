-- AUTO GENERATED - NEEDS UPDATING

local BtWQuests = BtWQuests;
local Database = BtWQuests.Database;
local L = BtWQuests.L;
local EXPANSION_ID = BtWQuests.Constant.Expansions.TheBurningCrusade;
local CATEGORY_ID = BtWQuests.Constant.Category.TheBurningCrusade.ShadowmoonValley;
local Chain = BtWQuests.Constant.Chain.TheBurningCrusade.ShadowmoonValley;
local ALLIANCE_RESTRICTIONS, HORDE_RESTRICTIONS = BtWQuests.Constant.Restrictions.Alliance, BtWQuests.Constant.Restrictions.Horde;
local MAP_ID = 104
local ACHIEVEMENT_ID = 1195
local CONTINENT_ID = 101
local LEVEL_RANGE = {25, 30}
local LEVEL_PREREQUISITES = {
    {
        type = "level",
        level = 25,
    },
}

Chain.WildhammerStronghold = 20701
Chain.ShadowmoonVillage = 20702
Chain.NetherwingLedge = 20703
Chain.TheFirstDeathKnightAlliance = 20704
Chain.TheFirstDeathKnightHorde = 20705
Chain.BorrowedPower = 20706
Chain.BorrowedPowerAldor = 20707
Chain.BorrowedPowerScryers = 20708
Chain.AkamasPromise = 20709
Chain.AkamasPromiseAldor = 20710
Chain.AkamasPromiseScryers = 20711
Chain.TheCipherOfDamnation = 20712
Chain.AntiDemonWeapons = 20713
Chain.TheDarkConclave = 20714

Chain.EmbedChain01 = 20715
Chain.EmbedChain02 = 20716
Chain.EmbedChain03 = 20717
Chain.EmbedChain04 = 20718
Chain.EmbedChain05 = 20719
Chain.EmbedChain06 = 20720
Chain.EmbedChain07 = 20721
Chain.EmbedChain08 = 20722
Chain.EmbedChain09 = 20723

Database:AddChain(Chain.WildhammerStronghold, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ShadowmoonVillage
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10661, 11044, 49550, 10562, 10772
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10678, 10776, 10744},
        count = 3,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain01,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain02,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain03,
            embed = true,
        },
    },
})
Database:AddChain(Chain.ShadowmoonVillage, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.WildhammerStronghold
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10660, 11048, 49532, 10595, 10750
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10673, 10769, 10745},
        count = 3,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain04,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain05,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain06,
            embed = true,
        },
    },
})
Database:AddChain(Chain.NetherwingLedge, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 2),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 10804,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10870, 11041},
        count = 2,
    },
    items = {
        {
            type = "npc",
            id = 22113,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10804,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10811,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10814,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10836,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10837,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10854,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10858,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10866,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10870,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 11012,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 11013,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 11019,
            x = -1,
        },
        {
            type = "quest",
            id = 11014,
            connections = {
                1, 
            },
        },
        {
            type = "kill",
            id = 23267,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 11041,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheFirstDeathKnightAlliance, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheFirstDeathKnightHorde
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            11045, 10642
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10645,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 11045,
                    restrictions = {
                        type = "quest",
                        id = 11045,
                        status = {'active', 'completed'}
                    },
                },
                {
                    type = "npc",
                    id = 21774,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10642,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10643,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10644,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 10634,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 10635,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10636,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10645,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheFirstDeathKnightHorde, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheFirstDeathKnightAlliance
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            11046, 10624
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10639,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 11046,
                    restrictions = {
                        type = "quest",
                        id = 11046,
                        status = {'active', 'completed'}
                    },
                },
                {
                    type = "npc",
                    id = 21772,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10624,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10625,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10633,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 10634,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 10635,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10636,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10639,
            x = 0,
        },
    },
})
Database:AddChain(Chain.BorrowedPower, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.BorrowedPower,
        Chain.BorrowedPowerAldor,
        Chain.BorrowedPowerScryers,
    },
    restrictions = {
        type = "quest",
        ids = {10551, 10552},
        equals = true,
        count = 0,
    },
    prerequisites = {
        {
            type = "level",
            level = 67,
        },
        {
            name = L["CHOOSE_THE_ALDOR_OR_THE_SCRYERS"],
        },
    },
    active = {
        type = "quest",
        id = 10587,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10651,
    },
    items = {
        {
            name = L["CHOOSE_THE_ALDOR_OR_THE_SCRYERS"],
        },
    },
})
Database:AddChain(Chain.BorrowedPowerAldor, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.BorrowedPower,
        Chain.BorrowedPowerAldor,
        Chain.BorrowedPowerScryers,
    },
    restrictions = {
        {
            type = "reputation",
            id = 932,
            standing = 4,
        },
        {
            type = "quest",
            id = 10551,
        },
    },
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 10587,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10651,
    },
    items = {
        {
            type = "npc",
            id = 21860,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10587,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10637,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10640,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 10641,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 10668,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10669,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10646,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10649,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10650,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10651,
            x = 0,
        },
    },
})
Database:AddChain(Chain.BorrowedPowerScryers, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.BorrowedPower,
        Chain.BorrowedPowerAldor,
        Chain.BorrowedPowerScryers,
    },
    restrictions = {
        {
            type = "reputation",
            id = 934,
            standing = 4,
        },
        {
            type = "quest",
            id = 10552,
        },
    },
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 10687,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10692,
    },
    items = {
        {
            type = "npc",
            id = 21954,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10687,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10688,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10689,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 10641,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 10668,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10669,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10646,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10649,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10691,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10692,
            x = 0,
        },
    },
})
Database:AddChain(Chain.AkamasPromise, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.AkamasPromise,
        Chain.AkamasPromiseAldor,
        Chain.AkamasPromiseScyers,
    },
    restrictions = {
        type = "quest",
        ids = {10551, 10552},
        equals = true,
        count = 0,
    },
    prerequisites = {
        {
            type = "level",
            level = 67,
        },
        {
            name = L["CHOOSE_THE_ALDOR_OR_THE_SCRYERS"],
        },
    },
    active = {
        type = "quest",
        id = 10587,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10651,
    },
    items = {
        {
            name = L["CHOOSE_THE_ALDOR_OR_THE_SCRYERS"],
        },
    },
})
Database:AddChain(Chain.AkamasPromiseAldor, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.AkamasPromise,
        Chain.AkamasPromiseAldor,
        Chain.AkamasPromiseScyers,
    },
    restrictions = {
        {
            type = "reputation",
            id = 932,
            standing = 4,
        },
        {
            type = "quest",
            id = 10551,
        },
    },
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 10568,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {
            11052, 10708, 
        },
    },
    items = {
        {
            type = "npc",
            id = 21402,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10568,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10571,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10574,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10575,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10622,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10628,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10705,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10706,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10707,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            ids = {
                11052, 10708, 
            },
            x = 0,
        },
    },
})
Database:AddChain(Chain.AkamasPromiseScryers, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.AkamasPromise,
        Chain.AkamasPromiseAldor,
        Chain.AkamasPromiseScyers,
    },
    restrictions = {
        {
            type = "reputation",
            id = 934,
            standing = 4,
        },
        {
            type = "quest",
            id = 10552,
        },
    },
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 10683,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {
            11052, 10708, 
        },
    },
    items = {
        {
            type = "npc",
            id = 21955,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10683,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10684,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10685,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10686,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10622,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10628,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10705,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10706,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10707,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            ids = {
                11052, 10708, 
            },
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheCipherOfDamnation, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 6),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10680, 10681, 10458
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10588,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 10680,
                    restrictions = {
                        type = "quest",
                        id = 10680,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "quest",
                    id = 10681,
                    restrictions = {
                        type = "quest",
                        id = 10681,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 21024,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10458,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10480,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10481,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10513,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10514,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10515,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10519,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain07,
            embed = true,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain08,
            embed = true,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain09,
            embed = true,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10588,
            x = 0,
        },
    },
})
Database:AddChain(Chain.AntiDemonWeapons, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 7),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10621, 10623
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10679,
    },
    items = {
        {
            type = "kill",
            id = 21499,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 10621,
                    restrictions = ALLIANCE_RESTRICTIONS,
                },
                {
                    type = "quest",
                    id = 10623,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 10626,
                    restrictions = ALLIANCE_RESTRICTIONS,
                },
                {
                    type = "quest",
                    id = 10627,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 10662,
                    restrictions = ALLIANCE_RESTRICTIONS,
                },
                {
                    type = "quest",
                    id = 10663,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10664,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10665,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 10666,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10667,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10670,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10676,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10679,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheDarkConclave, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 8),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10569, 10760
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10808,
    },
    items = {
        {
            variations = {
                {
                    type = "npc",
                    id = 22042,
                    restrictions = ALLIANCE_RESTRICTIONS,
                },
                {
                    type = "npc",
                    id = 22043,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 10569,
                    restrictions = ALLIANCE_RESTRICTIONS,
                },
                {
                    type = "quest",
                    id = 10760,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 10759,
                    restrictions = ALLIANCE_RESTRICTIONS,
                },
                {
                    type = "quest",
                    id = 10761,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10777,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10778,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10780,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10782,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10808,
            x = 0,
        },
    },
})

Database:AddChain(Chain.EmbedChain01, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10678,
    },
    items = {
        {
            type = "npc",
            id = 21777,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10661,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10677,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10678,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain02, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10744,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 11044,
                    restrictions = {
                        type = "quest",
                        id = 11044,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "quest",
                    id = 49550,
                    restrictions = {
                        type = "quest",
                        id = 49550,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "npc",
                    id = 21357,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10562,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10563,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10572,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10564,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10573,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10582,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10583,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10585,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10586,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10589,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10766,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10606,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10612,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10744,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain03, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10776,
    },
    items = {
        {
            type = "npc",
            id = 21773,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10772,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10773,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10774,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10775,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10776,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain04, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10673,
    },
    items = {
        {
            type = "npc",
            id = 21770,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10660,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10672,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10673,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain05, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10745,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 11048,
                    restrictions = {
                        type = "quest",
                        id = 11048,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "quest",
                    id = 49532,
                    restrictions = {
                        type = "quest",
                        id = 49532,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "npc",
                    id = 21359,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10595,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10596,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10597,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10598,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10599,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10600,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10601,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10602,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10603,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10604,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10767,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10611,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10613,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10745,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain06, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10769,
    },
    items = {
        {
            type = "npc",
            id = 21769,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10750,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10751,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10765,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10768,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10769,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain07, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10523,
    },
    items = {
        {
            type = "quest",
            id = 10521,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10522,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10523,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain08, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10541,
    },
    items = {
        {
            type = "quest",
            id = 10527,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10528,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10537,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10540,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10541,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain09, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10579,
    },
    items = {
        {
            type = "quest",
            id = 10546,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10547,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10550,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10570,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10576,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10577,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10578,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10579,
            x = 0,
        },
    },
})

Database:AddCategory(CATEGORY_ID, {
    name = BtWQuests.GetMapName(MAP_ID),
    expansion = EXPANSION_ID,
    items = {
        {
            type = "chain",
            id = Chain.WildhammerStronghold,
        },
        {
            type = "chain",
            id = Chain.ShadowmoonVillage,
        },
        {
            type = "chain",
            id = Chain.NetherwingLedge,
        },
        {
            type = "chain",
            id = Chain.TheFirstDeathKnightAlliance,
        },
        {
            type = "chain",
            id = Chain.TheFirstDeathKnightHorde,
        },
        {
            type = "chain",
            id = Chain.BorrowedPower,
        },
        {
            type = "chain",
            id = Chain.BorrowedPowerAldor,
        },
        {
            type = "chain",
            id = Chain.BorrowedPowerScryers,
        },
        {
            type = "chain",
            id = Chain.AkamasPromise,
        },
        {
            type = "chain",
            id = Chain.AkamasPromiseAldor,
        },
        {
            type = "chain",
            id = Chain.AkamasPromiseScryers,
        },
        {
            type = "chain",
            id = Chain.TheCipherOfDamnation,
        },
        {
            type = "chain",
            id = Chain.AntiDemonWeapons,
        },
        {
            type = "chain",
            id = Chain.TheDarkConclave,
        },
    },
})

Database:AddExpansionItem(EXPANSION_ID, {
    type = "category",
    id = CATEGORY_ID,
})

Database:AddMapRecursive(MAP_ID, {
    type = "category",
    id = CATEGORY_ID,
})

Database:AddContinentItems(CONTINENT_ID, {
})
