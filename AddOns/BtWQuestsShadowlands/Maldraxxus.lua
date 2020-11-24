local BtWQuests = BtWQuests
local Database = BtWQuests.Database
local EXPANSION_ID = BtWQuests.Constant.Expansions.Shadowlands
local CATEGORY_ID = BtWQuests.Constant.Category.Shadowlands.Maldraxxus
local Chain = BtWQuests.Constant.Chain.Shadowlands.Maldraxxus
local ALLIANCE_RESTRICTIONS, HORDE_RESTRICTIONS = BtWQuests.Constant.Restrictions.Alliance, BtWQuests.Constant.Restrictions.Horde
local MAP_ID = 1536
local CONTINENT_ID = 1550
local ACHIEVEMENT_ID = 14206
local SIDE_ACHIEVEMENT_ID = 14799
local LEVEL_RANGE = {52, 54}
local LEVEL_PREREQUISITE = {
    type = "level",
    variations = {
        { level = 50, restrictions = 86994, },
        { level = 52, },
    },
}

Database:AddChain(Chain.ChampionOfPain, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    questline = {1133, 1057},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = { LEVEL_PREREQUISITE },
    active = {
        type = "quest",
        id = 61096,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 57515,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        70325, 71675, 73050, 74700, 76150, 77500, 78950, 80300, 81600, 83050, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        74700, 76150, 77500, 44700, 29730, 15025, 7485, 
                    },
                    minLevel = 53,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2293200, 2316135, 2339070, 2361990, 2384925, 2407860, 2430795, 2453730, 2476650, 2499585, 2522520, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2361990,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 159478,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61096,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61107,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57386,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57390,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60020,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60021,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57425,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 57512,
            x = -2,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 57511,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60179,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60181,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57515,
            x = 0,
        },
    },
})
Database:AddChain(Chain.HouseOfTheChosen, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 2),
    questline = 1058,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.ChampionOfPain,
        },
    },
    active = {
        type = "quest",
        id = 57514,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 60886,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        63600, 64800, 66050, 67500, 68850, 70050, 71400, 72600, 73750, 75100, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        68850, 70050, 71400, 41250, 27580, 13665, 
                    },
                    minLevel = 54,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2082600, 2103430, 2124260, 2145070, 2165900, 2186730, 2207560, 2228390, 2249200, 2270030, 2290860, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2165900,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 159065,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57514,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 58351,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58617,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60451,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57516,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58616,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 58618,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58726,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60428,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60453,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60461,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60886,
            x = 0,
        },
    },
})
Database:AddChain(Chain.MatronOfSpies, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    questline = 1059,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfTheChosen,
        },
    },
    active = {
        type = "quest",
        id = 58751,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 59009,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        55850, 56950, 58000, 59400, 60500, 61600, 62700, 63800, 64800, 66000, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        60350, 60500, 61600, 62700, 40050, 25790, 13570, 
                    },
                    minLevel = 53,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1684800, 1701650, 1718500, 1735340, 1752190, 1769040, 1785890, 1802740, 1819580, 1836430, 1853280, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        1749850, 1752190, 1754530, 
                    },
                    minLevel = 53,
                    maxLevel = 55,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 168381,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58751,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 59171,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58821,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59172,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 59210,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 59185,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 59188,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59190,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59025,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59009,
            x = 0,
        },
    },
})
Database:AddChain(Chain.HouseOfConstructs, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    questline = 1060,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 53, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfTheChosen,
        },
    },
    active = {
        type = "quest",
        id = 57912,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 60733,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        97225, 99175, 101000, 103500, 105350, 107300, 109150, 111100, 112900, 114900, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        105350, 107300, 109150, 63125, 42220, 20835, 
                    },
                    minLevel = 54,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2948400, 2977885, 3007370, 3036850, 3066335, 3095820, 3125305, 3154790, 3184270, 3213755, 3243240, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3066335,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 168381,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57912,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 57976,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 60557,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58268,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57979,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59616,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57983,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57984,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 57985,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 57986,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 57987,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57982,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57993,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57994,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60733,
            x = 0,
        },
    },
})
Database:AddChain(Chain.HouseOfPlagues, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    questline = 1061,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 53, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfTheChosen,
        },
    },
    active = {
        type = "quest",
        id = 59130,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 59231,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        84750, 86400, 88050, 90100, 91800, 93450, 95150, 96800, 98400, 100100, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        91800, 93450, 95150, 55000, 36790, 18195, 
                    },
                    minLevel = 54,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2737800, 2765180, 2792560, 2819930, 2847310, 2874690, 2902070, 2929450, 2956820, 2984200, 3011580, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2847310,
                },
            },
        },
        {
            type = "reputation",
            id = 2410,
            amount = 270,
        },
    },
    items = {
        {
            type = "npc",
            id = 168381,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59130,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 58011,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58016,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58027,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 58031,
            x = -3,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 58036,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 58045,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = Chain.Chain04,
            embed = true,
            aside = true,
            x = 3,
        },
        {
            type = "quest",
            id = 59223,
            x = 0,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60831,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59231,
            x = 0,
        },
    },
})
Database:AddChain(Chain.RitualForTheDamned, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 6),
    questline = 1062,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 55, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfTheChosen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MatronOfSpies,
        },
        {
            type = "chain",
            id = Chain.HouseOfConstructs,
        },
        {
            type = "chain",
            id = Chain.HouseOfPlagues,
        },
    },
    active = {
        type = "quest",
        id = 59202,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 59974,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        68375, 69675, 71000, 72700, 74100, 75400, 76800, 78100, 79350, 80800, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        75400, 76800, 78100, 45225, 30160, 
                    },
                    minLevel = 55,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2059200, 2079795, 2100390, 2120970, 2141565, 2162160, 2182755, 2203350, 2223930, 2244525, 2265120, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2162160,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 168381,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59202,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59874,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59897,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60972,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59960,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59959,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59962,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59966,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59973,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61190,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62654,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59974,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheEmptyThrone, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 7),
    questline = 1063,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 55, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfTheChosen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MatronOfSpies,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfConstructs,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.HouseOfPlagues,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.RitualForTheDamned,
        },
    },
    active = {
        type = "quest",
        id = 59011,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 60737,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        28950, 29500, 30100, 30600, 31250, 31800, 32450, 33000, 33550, 34100, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        30925, 31075, 31250, 31450, 31650, 31800, 32450, 33000, 23375, 19170, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1216800, 1228970, 1241140, 1253300, 1265470, 1277640, 1289810, 1301980, 1314140, 1326310, 1338480, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        1264770, 1267345, 1269920, 1272490, 1275065, 1277640, 1280215, 1282790, 1285360, 1287935, 1290510, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 162801,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59011,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60737,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59206,
            aside = true,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61715,
            aside = true,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61716,
            aside = true,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain01, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 1), -- Theater of Pain
    questline = 1156,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 52, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            upto = 57425,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {58068, 59750, 59781, 59867, 62462},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 57316,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        130075, 132575, 135175, 138100, 140800, 143300, 146000, 148500, 151000, 153525, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        119950, 120225, 122100, 124400, 83750, 53235, 29015, 
                    },
                    minLevel = 53,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        5697900, 5743300, 5788700, 5834080, 5879480, 5924880, 5970280, 6015680, 6061060, 6106460, 6151860, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        5935405, 5939150, 5942895, 
                    },
                    minLevel = 53,
                    maxLevel = 55,
                },
            },
        },
        {
            type = "reputation",
            id = 2410,
            amount = 1665,
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain02,
            embed = true,
            x = -3,
            connections = {
                [4] = {0.5, 4}, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain03,
            embed = true,
            x = 0,
            connections = {
                3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain04,
            aside = true,
            embed = true,
            x = 3,
        },
        {
            type = "chain",
            id = Chain.EmbedChain05,
            aside = true,
            embed = true,
            x = 3,
        },
        {
            type = "quest",
            id = 59879,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59203,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59837,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58900,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57316,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain02, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 4), -- Wasteland Work
    questline = 1159,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 52, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            upto = 57425,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {58785, 58750},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 58794,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        30800, 31400, 32000, 32800, 33400, 34000, 34600, 35200, 35800, 36400, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        32800, 33400, 34000, 34600, 35200, 19600, 13000, 
                    },
                    minLevel = 53,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        936000, 945360, 954720, 964080, 973440, 982800, 992160, 1001520, 1010880, 1020240, 1029600, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        964080, 973440, 982800, 
                    },
                    minLevel = 53,
                    maxLevel = 55,
                },
            },
        },
        {
            type = "reputation",
            id = 2410,
            amount = 405,
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain06,
            embed = true,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain07,
            embed = true,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58794,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain03, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 2), -- Archival Protection
    questline = 1157,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 53, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            upto = 57425,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        id = 58619,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 58623,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        92400, 94200, 96000, 98400, 100200, 102000, 103800, 105600, 107400, 109200, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        100200, 102000, 103800, 60000, 40200, 19800, 
                    },
                    minLevel = 54,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2808000, 2836080, 2864160, 2892240, 2920320, 2948400, 2976480, 3004560, 3032640, 3060720, 3088800, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2920320,
                },
            },
        },
        {
            type = "reputation",
            id = 2410,
            amount = 1080,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 62605,
                    restrictions = {
                        type = "quest",
                        id = 62605,
                        status = {'active', 'completed'}
                    },
                },
                {
                    type = "npc",
                    id = 166657,
                }
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58619,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 58621,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 59917,
            aside = true,
        },
        {
            type = "quest",
            id = 58620,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58622,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60900,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59994,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58623,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain04, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 3), -- Mixing Monstrosities
    questline = 1158,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 53, },
            },
        },
        {
            type = "chain",
            id = Chain.ChampionOfPain,
            upto = 57425,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        id = 59430,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 60067,
    },
    items = {
        {
            type = "npc",
            id = 165049,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59430,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58431,
            x = 0,
            -- connections = {
            --     1, 
            -- },
        },
        -- {
        --     name = "Unlocks weeklies",
        --     x = 0,
        -- },
        -- {
        --     type = "quest",
        --     id = 57301,
        -- },
    },
})
Database:AddChain(Chain.EmbedChain02, {
    questline = {1156, 1169},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 61878,
    },
    items = {
        {
            type = "npc",
            id = 159689,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58068,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58088,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58090,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58095,
            aside = true,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain03, {
    questline = 1156,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 60050,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 62785,
                    restrictions = {
                        type = "quest",
                        id = 62785,
                        status = {'active', 'completed'}
                    },
                },
                {
                    type = "npc",
                    id = 161559,
                }
            },
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 59750,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 59781,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 58575,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 59800,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58947,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain04, {
    questline = 1171,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 61769,
    },
    items = {
        {
            type = "object",
            id = 349612,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59867,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain05, {
    questline = 1170,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 60067,
    },
    items = {
        {
            type = "object",
            id = 358382,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62462,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain06, {
    questline = 1159,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 60067,
    },
    items = {
        {
            type = "npc",
            id = 162615,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58785,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain07, {
    questline = 1159,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 60067,
    },
    items = {
        {
            type = "npc",
            id = 162474,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58750,
            x = 0,
        },
    },
})
Database:AddChain(Chain.OtherAlliance, {
    name = "Other Alliance",
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
    },
})
Database:AddChain(Chain.OtherHorde, {
    name = "Other Horde",
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
    },
})
Database:AddChain(Chain.OtherBoth, {
    name = "Other Both",
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
    },
})

Database:AddCategory(CATEGORY_ID, {
    name = BtWQuests.GetMapName(MAP_ID),
    expansion = EXPANSION_ID,
    buttonImage = 3759911,
    items = {
        {
            type = "chain",
            id = Chain.ChampionOfPain,
        },
        {
            type = "chain",
            id = Chain.HouseOfTheChosen,
        },
        {
            type = "chain",
            id = Chain.MatronOfSpies,
        },
        {
            type = "chain",
            id = Chain.HouseOfConstructs,
        },
        {
            type = "chain",
            id = Chain.HouseOfPlagues,
        },
        {
            type = "chain",
            id = Chain.RitualForTheDamned,
        },
        {
            type = "chain",
            id = Chain.TheEmptyThrone,
        },
        {
            type = "chain",
            id = Chain.Chain01,
        },
        {
            type = "chain",
            id = Chain.Chain02,
        },
        {
            type = "chain",
            id = Chain.Chain03,
        },
        {
            type = "chain",
            id = Chain.Chain04,
            visible = 86994,
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
    {
        type = "chain",
        id = Chain.Chain01,
    },
    {
        type = "chain",
        id = Chain.Chain02,
    },
    {
        type = "chain",
        id = Chain.Chain03,
    },
})
