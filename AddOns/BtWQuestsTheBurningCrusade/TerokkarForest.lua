-- AUTO GENERATED - NEEDS UPDATING

local BtWQuests = BtWQuests;
local Database = BtWQuests.Database;
local EXPANSION_ID = BtWQuests.Constant.Expansions.TheBurningCrusade;
local CATEGORY_ID = BtWQuests.Constant.Category.TheBurningCrusade.TerokkarForest;
local Chain = BtWQuests.Constant.Chain.TheBurningCrusade.TerokkarForest;
local ALLIANCE_RESTRICTIONS, HORDE_RESTRICTIONS = BtWQuests.Constant.Restrictions.Alliance, BtWQuests.Constant.Restrictions.Horde;
local MAP_ID = 108
local ACHIEVEMENT_ID_ALLIANCE = 1191
local ACHIEVEMENT_ID_HORDE = 1272
local CONTINENT_ID = 101
local LEVEL_RANGE = {15, 30}
local LEVEL_PREREQUISITES = {
    {
        type = "level",
        level = 15,
    },
}

Chain.TheSkettisOffensive = 20301
Chain.RefugeeCaravan = 20302
Chain.ShatariBaseCamp = 20303
Chain.TheWardensSecret = 20304
Chain.AllerianStronghold = 20305
Chain.StonebreakerHold = 20306

Chain.EmbedChain01 = 20311
Chain.EmbedChain02 = 20312
Chain.EmbedChain03 = 20313
Chain.EmbedChain04 = 20314
Chain.EmbedChain05 = 20315
Chain.EmbedChain06 = 20316
Chain.EmbedChain07 = 20317
Chain.EmbedChain08 = 20318
Chain.EmbedChain09 = 20319
Chain.EmbedChain10 = 20320
Chain.EmbedChain11 = 20321
Chain.EmbedChain12 = 20322
Chain.EmbedChain13 = 20323
Chain.EmbedChain14 = 20324
Chain.EmbedChain15 = 20325
Chain.EmbedChain16 = 20326
Chain.EmbedChain17 = 20327
Chain.EmbedChain18 = 20328
Chain.EmbedChain19 = 20329
Chain.EmbedChain20 = 20330
Chain.EmbedChain21 = 20331
Chain.EmbedChain22 = 20332
Chain.EmbedChain23 = 20333
Chain.EmbedChain24 = 20334

Database:AddChain(Chain.TheSkettisOffensive, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_ALLIANCE, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10908, 10847
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10879,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 10908,
                    restrictions = {
                        type = "quest",
                        id = 10908,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 22292,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10847,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10849,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10839,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10848,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10861,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10874,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10889,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10879,
            x = 0,
        },
    },
})
Database:AddChain(Chain.RefugeeCaravan, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_ALLIANCE, 2),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10896, 10852, 10878, 10880
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10031, 10878, 10896, 10881},
        count = 4,
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
        {
            type = "chain",
            id = Chain.EmbedChain04,
            embed = true,
        },
    },
})
Database:AddChain(Chain.ShatariBaseCamp, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_ALLIANCE, 3),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10873, 10913, 10922, 10877, 10920
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10873, 10926, 10923, 10930, 10915},
        count = 5,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain05,
            embed = true,
            x = -3,
        },
        {
            type = "chain",
            id = Chain.EmbedChain06,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain07,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain08,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain09,
            embed = true,
            x = 0,
            y = 4,
        },
    },
})
Database:AddChain(Chain.TheWardensSecret, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_ALLIANCE, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            9968, 9951
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10005, 9951},
        count = 2,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain10,
            embed = true,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain11,
            embed = true,
            x = 2,
        },
        {
            variations = {
                {
                    type = "chain",
                    id = Chain.EmbedChain12,
                },
                {
                    type = "chain",
                    id = Chain.EmbedChain13,
                },
            },
            embed = true,
            x = 0,
            y = 6,
        },
    },
})
Database:AddChain(Chain.AllerianStronghold, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_ALLIANCE, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.StonebreakerHold
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            9992, 9986, 9998, 10016, 10033, 10038, 10869
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9992, 9986, 10869, 10007, 10012, 10022, 10035, 10042},
        count = 8,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain14,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain15,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain16,
            embed = true,
            x = 0,
        },
        {
            type = "chain",
            id = Chain.EmbedChain17,
            embed = true,
            x = -2,
        },
        {
            type = "chain",
            id = Chain.EmbedChain18,
            embed = true,
            x = 1,
        },
    },
})
Database:AddChain(Chain.StonebreakerHold, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_HORDE, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.AllerianStronghold
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {
            10039, 10868, 9987, 10034, 10018, 9993, 10000, 10008
        },
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10201, 10868, 9987, 10008, 10013, 10791, 10036, 10043},
        count = 8,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain19,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain20,
            embed = true,
            x = 2,
        },
        {
            type = "chain",
            id = Chain.EmbedChain21,
            embed = true,
            x = -2,
            y = 4,
        },
        {
            type = "chain",
            id = Chain.EmbedChain22,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain23,
            embed = true,
        },
        {
            type = "chain",
            id = Chain.EmbedChain24,
            embed = true,
            x = 0,
            y = 8,
        },
    },
})

Database:AddChain(Chain.EmbedChain01, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10896,
    },
    items = {
        {
            type = "npc",
            id = 22420,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10896,
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
        id = 10031,
    },
    items = {
        {
            type = "npc",
            id = 22365,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10852,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10840,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10842,
            aside = true,
        },
        {
            type = "quest",
            id = 10030,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10031,
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
        id = 10878,
    },
    items = {
        {
            type = "npc",
            id = 22370,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10878,
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
        id = 10881,
    },
    items = {
        {
            type = "npc",
            id = 21662,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10880,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10881,
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
        id = 10873,
    },
    items = {
        {
            type = "npc",
            id = 22364,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10873,
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
        id = 10915,
    },
    items = {
        {
            type = "npc",
            id = 22446,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10913,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10914,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10915,
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
        id = 10930,
    },
    items = {
        {
            type = "npc",
            id = 22458,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10922,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10929,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10930,
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
        id = 10923,
    },
    items = {
        {
            type = "npc",
            id = 22456,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10877,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10923,
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
        id = 10926,
    },
    items = {
        {
            type = "npc",
            id = 22462,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10920,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10921,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10926,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain10, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9968,
    },
    items = {
        {
            type = "npc",
            id = 18446,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9968,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 9971,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9978,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9979,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10112,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9990,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain11, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9951,
    },
    items = {
        {
            type = "npc",
            id = 18424,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9951,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain12, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    restrictions = HORDE_RESTRICTIONS,
    completed = {
        type = "quest",
        id = 9995,
    },
    items = {
        {
            type = "quest",
            id = 9995,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10448,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9997,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10447,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10006,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain13, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    restrictions = ALLIANCE_RESTRICTIONS,
    completed = {
        type = "quest",
        id = 9994,
    },
    items = {
        {
            type = "quest",
            id = 9994,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10444,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9996,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10446,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10005,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain14, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9992,
    },
    items = {
        {
            type = "npc",
            id = 18390,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9992,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain15, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9986,
    },
    items = {
        {
            type = "npc",
            id = 18389,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9986,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain16, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10007,
    },
    items = {
        {
            type = "npc",
            id = 18387,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9998,
            x = -1,
            connections = {
                2, 3, 4, 
            },
        },
        {
            type = "quest",
            id = 10016,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 10002,
            aside = true,
            x = -3,
        },
        {
            type = "quest",
            id = 10012,
        },
        {
            type = "quest",
            id = 10007,
        },
        {
            type = "quest",
            id = 10022,
        },
    },
})
Database:AddChain(Chain.EmbedChain17, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10035,
    },
    items = {
        {
            type = "object",
            id = 182587,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10033,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10035,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain18, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10042,
    },
    items = {
        {
            type = "npc",
            id = 18713,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10038,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10869,
        },
        {
            type = "quest",
            id = 10040,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10042,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain19, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10043,
    },
    items = {
        {
            type = "npc",
            id = 18712,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10039,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10868,
        },
        {
            type = "quest",
            id = 10041,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10043,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain20, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9987,
    },
    items = {
        {
            type = "npc",
            id = 18386,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9987,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain21, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10036,
    },
    items = {
        {
            type = "object",
            id = 182588,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10034,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10036,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain22, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10791,
    },
    items = {
        {
            type = "npc",
            id = 18384,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10018,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10023,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10791,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain23, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10201,
    },
    items = {
        {
            type = "npc",
            id = 18385,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9993,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10201,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain24, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10013,
    },
    items = {
        {
            type = "npc",
            id = 18383,
            x = -1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10000,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "npc",
            id = 18566,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 10013,
            x = -2,
        },
        {
            type = "quest",
            id = 10003,
            aside = true,
        },
        {
            type = "quest",
            id = 10008,
        },
    },
})

Database:AddCategory(CATEGORY_ID, {
    name = BtWQuests.GetMapName(MAP_ID),
    expansion = EXPANSION_ID,
    items = {
        {
            type = "chain",
            id = Chain.TheSkettisOffensive,
        },
        {
            type = "chain",
            id = Chain.RefugeeCaravan,
        },
        {
            type = "chain",
            id = Chain.ShatariBaseCamp,
        },
        {
            type = "chain",
            id = Chain.TheWardensSecret,
        },
        {
            type = "chain",
            id = Chain.AllerianStronghold,
        },
        {
            type = "chain",
            id = Chain.StonebreakerHold,
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
