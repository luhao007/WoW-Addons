local BtWQuests = BtWQuests
local Database = BtWQuests.Database
local EXPANSION_ID = BtWQuests.Constant.Expansions.Shadowlands
local CATEGORY_ID = BtWQuests.Constant.Category.Shadowlands.Bastion
local Chain = BtWQuests.Constant.Chain.Shadowlands.Bastion
local MAP_ID = 1533
local CONTINENT_ID = 1550
local ACHIEVEMENT_ID = 14281
local SIDE_ACHIEVEMENT_ID = 14801
local LEVEL_RANGE = {50, 52}

Database:AddChain(Chain.EternitysCall, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    questline = 1001,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = 90002
        },
    },
    active = {
        type = "quest",
        id = 59773,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 57677,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        63625, 64925, 66075, 67525, 68725, 70025, 71300, 72600, 73700, 75025, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        64925, 66075, 67525, 38875, 25880, 12875, 6447.5, 
                    },
                    minLevel = 51,
                    maxLevel = 57,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2182050, 2203873, 2225695, 2247508, 2269330, 2291153, 2312975, 2334798, 2356610, 2378433, 2400255, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2203873,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 300,
        },
    },
    items = {
        {
            type = "npc",
            id = 175133,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59773,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59774,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57102,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57584,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60735,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57261,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 57676,
            aside = true,
            x = -1,
            y = 7,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57677,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain01,
            aside = true,
            embed = true,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheAspirantsCrucible, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 2),
    questline = {1055, 1154},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            upto = 57677,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            upto = 57676,
        },
    },
    active = {
        type = "quest",
        id = 57709,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 58174,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        105050, 107000, 109075, 111525, 113725, 115675, 117950, 119900, 121850, 123975, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        107000, 109075, 111525, 64175, 42900, 21225, 10612.5, 
                    },
                    minLevel = 51,
                    maxLevel = 57,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        3422250, 3456478, 3490705, 3524908, 3559135, 3593363, 3627590, 3661818, 3696020, 3730248, 3764475, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3456478,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 200,
        },
    },
    items = {
        {
            type = "npc",
            id = 165107,
            locations = {
                [1533] = {
                    {
                        x = 0.482014,
                        y = 0.726004,
                    },
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57709,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57710,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57711,
            x = 0,
            connections = {
                1.2, 2, 3, 4
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain02,
            aside = true,
            embed = true,
            x = 3,
        },
        {
            type = "quest",
            id = 57263,
            x = -3,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 57267,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57265,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59920,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57713,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57908,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 57909,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57288,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57714,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57291,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57266,
            x = 0,
            connections = {
                1,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 57715,
                },
                {
                    type = "quest",
                    id = 60217,
                },
                {
                    type = "quest",
                    id = 60218,
                },
                {
                    type = "quest",
                    id = 60219,
                },
                {
                    type = "quest",
                    id = 60220,
                },
                {
                    type = "quest",
                    id = 60221,
                },
                {
                    type = "quest",
                    id = 60222,
                },
                {
                    type = "quest",
                    id = 60223,
                },
                {
                    type = "quest",
                    id = 60224,
                },
                {
                    type = "quest",
                    id = 60225,
                },
                {
                    type = "quest",
                    id = 60226,
                },
                {
                    type = "quest",
                    id = 60229,
                },
            },
            x = 0,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 58174,
            x = -1,
        },
        {
            type = "quest",
            id = 60316,
            aside = true,
        },
    },
})
Database:AddChain(Chain.TheTempleOfPurity, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    questline = {1056,1186},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            upto = 57676,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAspirantsCrucible,
            x = 0,
        },
    },
    active = {
        type = "quest",
        id = 57270,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57447,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        74200, 75600, 77050, 78825, 80325, 81725, 83300, 84700, 86100, 87550, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        75600, 77050, 78825, 45325, 30305, 15000, 7500, 
                    },
                    minLevel = 51,
                    maxLevel = 57,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2416050, 2440213, 2464375, 2488528, 2512690, 2536853, 2561015, 2585178, 2609330, 2633493, 2657655, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2440213,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 157673,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57270,
            x = 0,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 57977,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57264,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57716,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57717,
            x = 0,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 57037,
            x = -3,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 59147,
            connections = {
                3,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 57719,
                },
                {
                    type = "quest",
                    id = 60292,
                },
            },
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57444,
            aside = true,
        },
        {
            type = "quest",
            id = 57446,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57269,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57447,
            x = 0,
        },
    },
})
Database:AddChain(Chain.ChasingAMemory, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    questline = 1109,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            upto = 57676,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAspirantsCrucible,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheTempleOfPurity,
        },
    },
    active = {
        type = "quest",
        id = 58976,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60013,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        79925, 81525, 83050, 85000, 86550, 88150, 89700, 91300, 92800, 94400, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        83050, 85000, 86550, 49800, 33200, 16600, 8300, 
                    },
                    minLevel = 52,
                    maxLevel = 58,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2597400, 2623375, 2649350, 2675320, 2701295, 2727270, 2753245, 2779220, 2805190, 2831165, 2857140, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2649350,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 156238,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58976,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 58771,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58799,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58800,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58977,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 58978,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59015,
            aside = true,
        },
        {
            type = "quest",
            id = 58979,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58980,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58843,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60180,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60013,
            x = 0,
        },
    },
})
Database:AddChain(Chain.ByTheArchonsWill, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    questline = 1068,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            upto = 57676,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAspirantsCrucible,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheTempleOfPurity,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ChasingAMemory,
        },
    },
    active = {
        type = "quest",
        id = 59196,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 59200,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        46300, 47300, 48150, 49000, 49900, 50900, 51800, 52800, 53600, 54550, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        48150, 49000, 49900, 28800, 19200, 9600, 4800, 
                    },
                    minLevel = 52,
                    maxLevel = 58,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1918800, 1937990, 1957180, 1976360, 1995550, 2014740, 2033930, 2053120, 2072300, 2091490, 2110680, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1957180,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 200,
        },
    },
    items = {
        {
            type = "npc",
            id = 167038,
            x = 0,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "object",
            id = 348558,
            visible = {
                type = "quest",
                id = 57549,
                status = {'pending'},
                restrictions = {
                    type = "quest",
                    id = 59554,
                    status = {'pending'}
                },
            },
            aside = true,
            x = -3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 59196,
            x = 0,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain03,
            embed = true,
            aside = true,
        },
        {
            type = "chain",
            id = Chain.Chain02,
            visible = {
                type = "quest",
                id = 57549,
                status = {'pending'},
                restrictions = {
                    type = "quest",
                    id = 59554,
                    status = {'pending'}
                },
            },
            aside = true,
            x = -3,
            y = 2,
        },
        {
            type = "quest",
            id = 59426,
            x = -1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59197,
            x = 0,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59198,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59199,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59200,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheTempleOfCourage, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 6),
    questline = {1066, 1187, 1133},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
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
            id = Chain.EternitysCall,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.EternitysCall,
            upto = 57676,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAspirantsCrucible,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheTempleOfPurity,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ChasingAMemory,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ByTheArchonsWill,
        },
    },
    active = {
        type = "quest",
        id = 60005,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60055,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        113800, 116000, 118250, 120650, 122950, 125150, 127450, 129650, 132000, 134200, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        118850, 119750, 109400, 99950, 76250, 52350, 33170, 19050, 11800, 
                    },
                    minLevel = 51,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        3322800, 3356030, 3389260, 3422480, 3455710, 3488940, 3522170, 3555400, 3588620, 3621850, 3655080, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3403760,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 250,
        },
    },
    items = {
        {
            type = "npc",
            id = 160037,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60005,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60006,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 60007,
            x = -2,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 60008,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 60009,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 60052,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 60053,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60054,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60055,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 60056,
            aside = true,
            x = -1,
        },
        {
            type = "quest",
            id = 60057,
            aside = true,
        },
    },
})

Database:AddChain(Chain.EmbedChain01, {
    questline = 1151,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
    },
    completed = {
        type = "quest",
        id = 60466,
    },
    items = {
        {
            type = "npc",
            id = 160598,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60466,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62714,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62715,
            x = 0,
        },
    }
})
Database:AddChain(Chain.EmbedChain02, {
    questline = 1195,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
    },
    completed = {
        type = "quest",
        id = 57712,
    },
    items = {
        {
            type = "npc",
            id = 166738,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57712,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain03, {
    questline = {1152, 1153},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 51, },
            },
        },
    },
    completed = {
        type = "quest",
        ids = {60315, 60366},
        count = 2,
    },
    items = {
        {
            type = "object",
            id = 352027,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 60315,
            x = -1,
        },
        {
            type = "quest",
            id = 60366,
        },
    },
})

Database:AddChain(Chain.Chain01, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 3), -- In the Garden of Respite
    questline = 1149,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
    },
    active = {
        type = "quest",
        ids = {
            57529, 57538, 57545, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 57568,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        49125, 50100, 51075, 52200, 53175, 54150, 55125, 56100, 57075, 57975, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        51075, 52200, 53175, 30600, 20400, 10200, 5100, 
                    },
                    minLevel = 52,
                    maxLevel = 58,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1755000, 1772550, 1790100, 1807650, 1825200, 1842750, 1860300, 1877850, 1895400, 1912950, 1930500, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1790100,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 400,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 57529,
                    restrictions = {
                        type = "quest",
                        id = 57529,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 158004,
                },
            },
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 57538,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 57545,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57547,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57568,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain02, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 1), -- In Agthia's Memory
    questline = 1148,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
    },
    active = {
        type = "quest",
        ids = {59554, 57549},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 57555,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        63600, 64800, 66075, 67575, 68850, 70050, 71325, 72600, 73875, 75075, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        66075, 67575, 68850, 39600, 26400, 13200, 6600, 
                    },
                    minLevel = 52,
                    maxLevel = 58,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2193750, 2215688, 2237625, 2259563, 2281500, 2303438, 2325375, 2347313, 2369250, 2391188, 2413125, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2237625,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 500,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 59554,
                    restrictions = {
                        type = "quest",
                        id = 59554,
                        status = {'active', 'completed'}
                    },
                },
                {
                    type = "npc",
                    id = 158078,
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57549,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57551,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 57552,
            x = -2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 57554,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57553,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57555,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain03, {
    name = { -- Part of the Pride
        type = "quest",
        id = 58037,
    },
    questline = 1150,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
    },
    active = {
        type = "quest",
        ids = {58184, 58037},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 58042,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        69300, 70650, 72000, 73800, 75150, 76500, 77850, 79200, 80550, 81900, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        72000, 73800, 75150, 43200, 28800, 14400, 7200, 
                    },
                    minLevel = 52,
                    maxLevel = 58,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2106000, 2127060, 2148120, 2169180, 2190240, 2211300, 2232360, 2253420, 2274480, 2295540, 2316600, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2148120,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 600,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 58184,
                    restrictions = {
                        type = "quest",
                        id = 58184,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 157696,
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58037,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 58038,
            x = -1,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 58039,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 58040,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58041,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58042,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain04, {
    name = { -- We Can Rebuild Him
        type = "quest",
        id = 57933,
    },
    questline = 1150,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
    },
    active = {
        type = "quest",
        ids = {58185, 57931, 57932},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 57937,
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
                        96000, 98400, 100200, 57600, 38400, 19200, 9600, 
                    },
                    minLevel = 52,
                    maxLevel = 58,
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
                    amount = 2864160,
                },
            },
        },
        {
            type = "reputation",
            id = 2407,
            amount = 800,
        },
    },
    items = {
        {
            type = "quest",
            id = 58185,
            x = 0,
            visible = {
                type = "quest",
                id = 58185,
                status = {'active', 'completed'}
            },
            connections = {
                3, 4
            },
        },
        {
            type = "npc",
            id = 158765,
            x = -1,
            y = 0,
            visible = {
                type = "quest",
                id = 58185,
                status = {'pending'}
            },
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 159609,
            visible = {
                type = "quest",
                id = 58185,
                status = {'pending'}
            },
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57931,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57932,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57933,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 57934,
            x = -2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 57935,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57936,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57937,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain05, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 5), -- Pride or Unit
    questline = 1150,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.Chain03,
        },
        {
            type = "chain",
            id = Chain.Chain04,
        },
    },
    active = {
        type = "chain",
        ids = {Chain.Chain03, Chain.Chain04},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        ids = {
            60296, 58103,
        },
    },
    items = {
        {
            type = "npc",
            id = 157696,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 158765,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.Chain03,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.Chain04,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            ids = {
                60296, 58103,
            },
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain06, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 4), -- The Spear of Kalliope
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 60,
        },
    },
    active = {
        type = "quest",
        ids = {57860, 59207},
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        ids = {60906, 57967},
    },
    rewards = {
        {
            type = "money",
            amount = 1737450,
        },
        {
            type = "reputation",
            id = 2407,
            amount = 400,
        },
    },
    items = {
        {
            type = "npc",
            id = 159248,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 57860,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59207,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57861,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 57875,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57914,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57966,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57989,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            ids = {60906, 57967},
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain07, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 2), -- Wings of Freedom
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            level = 60,
        },
    },
    active = {
        type = "quest",
        id = 59262,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        id = 59865,
    },
    rewards = {
        {
            type = "money",
            amount = 2220075,
        },
        {
            type = "reputation",
            id = 2407,
            amount = 700,
        },
    },
    items = {
        {
            type = "npc",
            id = 164640,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59262,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59263,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60660,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 59348,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59351,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59311,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59865,
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
        { -- A Friendly Rivalry, not sure how best to handle this
            type = "quest",
            id = 59674,
        },
        { -- Newfound Power, maybe removed?
            type = "quest",
            id = 60235,
        },
    },
})

Database:AddCategory(CATEGORY_ID, {
    name = BtWQuests.GetMapName(MAP_ID),
    expansion = EXPANSION_ID,
    buttonImage = 3759913,
    items = {
        {
            type = "chain",
            id = Chain.EternitysCall,
        },
        {
            type = "chain",
            id = Chain.TheAspirantsCrucible,
        },
        {
            type = "chain",
            id = Chain.TheTempleOfPurity,
        },
        {
            type = "chain",
            id = Chain.ChasingAMemory,
        },
        {
            type = "chain",
            id = Chain.ByTheArchonsWill,
        },
        {
            type = "chain",
            id = Chain.TheTempleOfCourage,
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
        },
        {
            type = "chain",
            id = Chain.Chain05,
        },
        {
            type = "chain",
            id = Chain.Chain06,
        },
        {
            type = "chain",
            id = Chain.Chain07,
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
    {
        type = "chain",
        id = Chain.Chain04,
    },
    {
        type = "chain",
        id = Chain.Chain05,
    },
    {
        type = "chain",
        id = Chain.Chain06,
    },
    {
        type = "chain",
        id = Chain.Chain07,
    },
})
