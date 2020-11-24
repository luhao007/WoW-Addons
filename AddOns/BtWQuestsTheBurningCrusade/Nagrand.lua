-- AUTO GENERATED - NEEDS UPDATING

local BtWQuests = BtWQuests;
local Database = BtWQuests.Database;
local EXPANSION_ID = BtWQuests.Constant.Expansions.TheBurningCrusade;
local CATEGORY_ID = BtWQuests.Constant.Category.TheBurningCrusade.Nagrand;
local Chain = BtWQuests.Constant.Chain.TheBurningCrusade.Nagrand;
local ALLIANCE_RESTRICTIONS, HORDE_RESTRICTIONS = BtWQuests.Constant.Restrictions.Alliance, BtWQuests.Constant.Restrictions.Horde;
local MAP_ID = 107
local ACHIEVEMENT_ID_1 = 1192
local ACHIEVEMENT_ID_2 = 1273
local CONTINENT_ID = 101
local LEVEL_RANGE = {15, 30}
local LEVEL_PREREQUISITES = {
    {
        type = "level",
        level = 15,
    },
}

Chain.TheAdventuresOfCorki = 20401
Chain.BirthOfAWarchief = 20402

Chain.TheRingOfBlood = 20403
Chain.ThroneOfTheElements = 20404

Chain.LantresorOfTheBladeAlliance = 20405
Chain.LantresorOfTheBladeHorde = 20406

Chain.TheMurkbloodAlliance = 20407
Chain.TheMurkbloodHorde = 20408

Chain.ThreatsToNagrandAlliance = 20409
Chain.ThreatsToNagrandHorde = 20410

Chain.TheUltimateBloodsport = 20411
Chain.EncounteringTheEthereals = 20412

Chain.EmbedChain01 = 20421
Chain.EmbedChain02 = 20422
Chain.EmbedChain03 = 20423

Chain.EmbedChain04 = 20424
Chain.EmbedChain05 = 20425

Chain.EmbedChain06 = 20426
Chain.EmbedChain07 = 20427

Chain.EmbedChain08 = 20428
Chain.EmbedChain09 = 20429
Chain.EmbedChain10 = 20430

Chain.EmbedChain11 = 20431
Chain.EmbedChain12 = 20432
Chain.EmbedChain13 = 20433

Database:AddChain(Chain.TheAdventuresOfCorki, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.BirthOfAWarchief
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = {
        {
            type = "level",
            level = 15,
        },
        {
            type = "reputation",
            id = 978,
            standing = 4,
        },
    },
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 9955,
    },
    items = {
        {
            type = "npc",
            id = 18369,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9923,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9924,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9954,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9955,
            x = 0,
        },
    },
})
Database:AddChain(Chain.BirthOfAWarchief, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_2, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheAdventuresOfCorki
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = {
        {
            type = "level",
            level = 15,
        },
        {
            type = "quest",
            id = 9934,
        },
        {
            type = "quest",
            id = 10011,
        },
        {
            type = "quest",
            id = 9868,
        },
    },
    active = {
        type = "quest",
        id = 10044,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10172,
    },
    items = {
        {
            type = "npc",
            id = 18063,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10044,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10045,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10081,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10082,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10085,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10101,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10102,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10167,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10168,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10170,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10171,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10172,
            x = 0,
        },
    },
})

Database:AddChain(Chain.TheRingOfBlood, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 2),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9962,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 9977,
    },
    items = {
        {
            type = "npc",
            id = 18471,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9962,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9967,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9970,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9972,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9973,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9977,
            x = 0,
        },
    },
})
Database:AddChain(Chain.ThroneOfTheElements, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 3),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {9815, 9800, 9818, 9861},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9862, 9810, 9853},
        count = 3,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain01,
            embed = true,
            x = -2,
        },
        {
            type = "chain",
            id = Chain.EmbedChain02,
            embed = true,
            x = 1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain03,
            embed = true,
            x = 3,
        },
    },
})

Database:AddChain(Chain.LantresorOfTheBladeAlliance, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.LantresorOfTheBladeHorde
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9917,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 9933,
    },
    items = {
        {
            type = "npc",
            id = 18353,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9917,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9918,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9920,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9921,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9922,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10108,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9928,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 9927,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9931,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 9932,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9933,
            x = 0,
        },
    },
})
Database:AddChain(Chain.LantresorOfTheBladeHorde, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_2, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.LantresorOfTheBladeAlliance
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9888,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 9934,
    },
    items = {
        {
            type = "npc",
            id = 18106,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9888,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9889,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9890,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9891,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9906,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9907,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10107,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9928,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 9927,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9931,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 9932,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9934,
            x = 0,
        },
    },
})

Database:AddChain(Chain.TheMurkbloodAlliance, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheMurkbloodHorde
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {9871, 9879},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9879, 9873},
        count = 2,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain04,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain05,
            embed = true,
            x = 1,
            y = 1,
        },
    },
})
Database:AddChain(Chain.TheMurkbloodHorde, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_2, 5),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheMurkbloodAlliance
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = {
        {
            type = "level",
            level = 15,
        },
        {
            type = "reputation",
            id = 941,
            x = 0,
            connections = {
                1, 2, 
            },
            standing = 4,
        },
    },
    active = {
        type = "quest",
        ids = {9864, 9868},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9866, 9868},
        count = 2,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain06,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain07,
            embed = true,
        },
    },
})

Database:AddChain(Chain.ThreatsToNagrandAlliance, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 6),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ThreatsToNagrandHorde
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {9936, 9940, 9982, 9983, 9991},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9938, 10011},
        count = 2,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain08,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain09,
            embed = true,
            x = 2,
        },
    },
})
Database:AddChain(Chain.ThreatsToNagrandHorde, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_2, 6),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ThreatsToNagrandAlliance
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {9935, 9939, 9982, 9983, 9991},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9937, 10011},
        count = 2,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain10,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain09,
            embed = true,
            x = 2,
        },
    },
})

Database:AddChain(Chain.TheUltimateBloodsport, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 7),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {9854, 9789, 9857},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 9852,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain11,
            embed = true,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain12,
            embed = true,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain13,
            embed = true,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9852,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EncounteringTheEthereals, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID_1, 8),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {9900, 9925},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {9900, 9925},
    },
    items = {
        {
            type = "npc",
            id = 18276,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9900,
            x = -1,
        },
        {
            type = "quest",
            id = 9925,
        },
    },
})

Database:AddChain(Chain.EmbedChain01, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9810,
    },
    items = {
        {
            type = "npc",
            id = 18073,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9815,
            x = -1,
        },
        {
            type = "quest",
            id = 9800,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9804,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9805,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9810,
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
        id = 9853,
    },
    items = {
        {
            type = "npc",
            id = 18071,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9818,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9819,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9821,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9849,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9853,
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
        id = 9862,
    },
    items = {
        {
            type = "kill",
            id = 17158,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9861,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9862,
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
        id = 9873,
    },
    items = {
        {
            type = "kill",
            id = 18238,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9871,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9873,
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
        id = 9879,
    },
    items = {
        {
            type = "npc",
            id = 18209,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9879,
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
        id = 9866,
    },
    items = {
        {
            type = "npc",
            id = 18067,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9864,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9865,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9866,
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
        id = 9868,
    },
    items = {
        {
            type = "npc",
            id = 18210,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9868,
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
        id = 9938,
    },
    items = {
        {
            type = "object",
            id = 182393,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9936,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 9940,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9938,
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
        id = 10011,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 9982,
                    restrictions = {
                        type = "quest",
                        id = 9982,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "quest",
                    id = 9983,
                    restrictions = {
                        type = "quest",
                        id = 9983,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 18417,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9991,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9999,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10001,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10004,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10009,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10010,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10011,
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
        id = 9937,
    },
    items = {
        {
            type = "object",
            id = 182392,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 9935,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 9939,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9937,
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
        id = 9856,
    },
    items = {
        {
            type = "npc",
            id = 18200,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9854,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9855,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9856,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain12, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9851,
    },
    items = {
        {
            type = "npc",
            id = 18180,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9789,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9850,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9851,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain13, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 9859,
    },
    items = {
        {
            type = "npc",
            id = 18218,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9857,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9858,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 9859,
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
            id = Chain.TheAdventuresOfCorki,
        },
        {
            type = "chain",
            id = Chain.BirthOfAWarchief,
        },

        {
            type = "chain",
            id = Chain.TheRingOfBlood,
        },
        {
            type = "chain",
            id = Chain.ThroneOfTheElements,
        },

        {
            type = "chain",
            id = Chain.LantresorOfTheBladeAlliance,
        },
        {
            type = "chain",
            id = Chain.LantresorOfTheBladeHorde,
        },

        {
            type = "chain",
            id = Chain.TheMurkbloodAlliance,
        },
        {
            type = "chain",
            id = Chain.TheMurkbloodHorde,
        },

        {
            type = "chain",
            id = Chain.ThreatsToNagrandAlliance,
        },
        {
            type = "chain",
            id = Chain.ThreatsToNagrandHorde,
        },

        {
            type = "chain",
            id = Chain.TheUltimateBloodsport,
        },
        {
            type = "chain",
            id = Chain.EncounteringTheEthereals,
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
