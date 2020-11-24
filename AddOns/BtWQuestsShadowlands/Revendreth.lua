local BtWQuests = BtWQuests
local Database = BtWQuests.Database
local L = BtWQuests.L
local EXPANSION_ID = BtWQuests.Constant.Expansions.Shadowlands
local CATEGORY_ID = BtWQuests.Constant.Category.Shadowlands.Revendreth
local Chain = BtWQuests.Constant.Chain.Shadowlands.Revendreth
local MAP_ID = 1525
local CONTINENT_ID = 1550
local ACHIEVEMENT_ID = 13878
local SIDE_ACHIEVEMENT_ID = 14798
local LEVEL_RANGE = {57, 60}
local LEVEL_PREREQUISITES = {
    {
        type = "level",
        level = 57,
    },
}

Database:AddChain(Chain.WelcomeToRevendreth, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    questline = 985,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = 90306,
        },
    },
    active = {
        type = "quest",
        id = 57025,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 56978,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        79975, 81475, 83050, 85000, 86600, 88100, 89700, 91300, 92850, 94450, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        92850, 94450, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
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
                    amounts = {
                        2805190, 2813380, 2821570, 
                    },
                    minLevel = 58,
                    maxLevel = 60,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 300,
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
            id = 57025,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57026,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain01,
            embed = true,
            aside = true,
            x = -3,
        },
        {
            type = "quest",
            id = 57007,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 56829,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57381,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 56942,
            x = 0,
            y = 5,
            connections = {
                3, 4,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain02,
            embed = true,
            aside = true,
            x = 3,
        },
        {
            type = "chain",
            id = Chain.EmbedChain03,
            embed = true,
            aside = true,
            x = -3,
            y = 6,
        },
        {
            type = "quest",
            id = 56955,
            x = -1,
            y = 6,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58433,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 56978,
            x = 0,
        },
    },
})
Database:AddChain(Chain.MeetTheMaster, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 2),
    questline = {994, 1145},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
        },
    },
    active = {
        type = "quest",
        id = 57174,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57179,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        30850, 31450, 32000, 32750, 33350, 33950, 34600, 35200, 35700, 36400, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        35700, 36400, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        924300, 933545, 942790, 952025, 961270, 970515, 979760, 989005, 998240, 1007485, 1016730, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 998240,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 500,
        },
    },
    items = {
        {
            type = "npc",
            id = 156374,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain04,
            embed = true,
            aside = true,
            x = -3,
        },
        {
            type = "quest",
            id = 57174,
            x = 0,
            y = 1,
            connections = {
                2, 3,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain05,
            embed = true,
            aside = true,
            x = 3,
        },
        {
            type = "quest",
            id = 58654,
            x = -1,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 60176,
            aside = true,
        },
        {
            visible = false,
        },
        {
            type = "quest",
            id = 57178,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57179,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheAccusersSecret, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    questline = 995,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
        },
    },
    active = {
        type = "quest",
        id = 57161,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57180,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        90550, 92300, 94050, 96300, 98050, 99800, 101550, 103400, 105150, 106950, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        105150, 106950, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2925000, 2954250, 2983500, 3012750, 3042000, 3071250, 3100500, 3129750, 3159000, 3188250, 3217500, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        3159000, 3163680, 3168360, 
                    },
                    minLevel = 58,
                    maxLevel = 60,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 156605,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57161,
            x = 0,
            connections = {
                2,
            },
        },
        { -- Padding
            visible = false,
            x = -3,
        },
        {
            type = "quest",
            id = 57173,
            x = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain06,
            embed = true,
            aside = true,
            x = 3,
        },
        {
            type = "quest",
            id = 58931,
            x = -1,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58932,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59021,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 57175,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57177,
            aside = true,
        },
        {
            type = "quest",
            id = 59023,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57176,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57180,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57182,
            aside = true,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59232,
            aside = true,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheRebellion, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    questline = {996, 1178, 1192, 1189},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAccusersSecret,
            upto = 59232,
        },
    },
    active = {
        type = "quest",
        id = 57098,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 59256,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        132950, 135575, 138150, 141250, 143875, 146500, 149125, 151800, 154325, 156950, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        155975, 156950, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        5253300, 5305835, 5358370, 5410895, 5463430, 5515965, 5568500, 5621035, 5673560, 5726095, 5778630, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        5703865, 5726095, 5748325, 
                    },
                    minLevel = 58,
                    maxLevel = 60,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 600,
        },
    },
    items = {
        {
            type = "npc",
            id = 156381,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57098,
            x = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "object",
            id = 355296,
            aside = true,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58916,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58936,
            aside = true,
        },
        {
            type = "quest",
            id = 58941,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59014,
            x = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "npc",
            id = 156384,
            aside = true,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57131,
            x = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 60514,
            aside = true,
        },
        {
            type = "quest",
            id = 57136,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57164,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60506,
            x = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "npc",
            id = 156384,
            aside = true,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57159,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58996,
            aside = true,
        },
        {
            type = "quest",
            id = 60313,
            x = 0,
            connections = {
                1, 2, 3, 4
            },
        },
        {
            type = "quest",
            id = 57189,
            x = -3,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 59209,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 57190,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59211,
        },
        {
            type = "quest",
            id = 59256,
            x = 0,
        },
    },
})
Database:AddChain(Chain.SecuringSinfall, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    questline = 998,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAccusersSecret,
            upto = 59232,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheRebellion,
        },
    },
    active = {
        type = "quest",
        id = 57240,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57724,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        90650, 92400, 94200, 96100, 97950, 99700, 101600, 103400, 105100, 106850, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        106700, 106850, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2445300, 2469755, 2494210, 2518655, 2543110, 2567565, 2592020, 2616475, 2640920, 2665375, 2689830, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2665375,
                },
            },
        },
        {
            type = "currency",
            id = 1820,
            amount = 35,
        },
        {
            type = "reputation",
            id = 2413,
            amount = 575,
        },
    },
    items = {
        {
            type = "npc",
            id = 168217,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57240,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57380,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57405,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 57426,
            x = -2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 57427,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57428,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57442,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain07,
            embed = true,
            aside = true,
            x = -2,
            y = 6,
        },
        {
            type = "quest",
            id = 57460,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57461,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain08,
            embed = true,
            aside = true,
            x = -2,
        },
        {
            type = "quest",
            id = 60566,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain09,
            embed = true,
            aside = true,
        },
        {
            type = "quest",
            id = 57724,
            x = 0,
            y = 9,
        },
    },
})
Database:AddChain(Chain.ThePrinceAndTheTower, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 6),
    questline = 1005,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAccusersSecret,
            upto = 59232,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheRebellion,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SecuringSinfall,
        },
    },
    active = {
        type = "quest",
        id = 59327,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57694,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        31825, 32525, 33100, 33700, 34300, 35000, 35600, 36300, 36850, 37500, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amount = 37500,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1310400, 1323505, 1336610, 1349710, 1362815, 1375920, 1389025, 1402130, 1415230, 1428335, 1441440, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1428335,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 158716,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59327,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57689,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57690,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57691,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57693,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57694,
            x = 0,
        },
    },
})
Database:AddChain(Chain.MenagerieOfTheMaster, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 7),
    questline = {1038, 1010, 1137},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheAccusersSecret,
            upto = 59232,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheRebellion,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SecuringSinfall,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ThePrinceAndTheTower,
        },
    },
    active = {
        type = "quest",
        id = 59644,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 58086,
    },
    rewards = {
        {
            type = "experience",
            amounts = {
                11600, 11800, 12050, 12250, 12500, 12700, 12950, 13200, 13400, 13650, 
            },
            minLevel = 50,
            maxLevel = 59,
            restrictions = 86994,
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1345500, 1352520, 1359540, 1366560, 1373580, 1380600, 1387620, 1394640, 1401660, 1408680, 1415700, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1415700,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 162688,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59644,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58086,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57876,
            aside = true,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57877,
            aside = true,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57878,
            aside = true,
            x = 0,
        },
    },
})

Database:AddChain(Chain.Chain01, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 3), -- Dirty Jobs
    questline = 1141,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
            upto = 56942,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {60509, 57471},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57481,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        27000, 27500, 28050, 28650, 29200, 29700, 30250, 30800, 31350, 31850, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        31350, 31850, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        994500, 1004445, 1014390, 1024335, 1034280, 1044225, 1054170, 1064115, 1074060, 1084005, 1093950, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1074060,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 300,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 60509,
                    restrictions = {
                        type = "quest",
                        id = 60509,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 157846,
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57471,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57474,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57477,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57481,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain02, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 1), -- The Duelist's Debt
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    questline = 1142,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
            upto = 57174,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        id = 59710,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 59726,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        113725, 116000, 118175, 120750, 122950, 125225, 127425, 129800, 131850, 134200, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        131850, 134200, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        3006900, 3036970, 3067040, 3097105, 3127175, 3157245, 3187315, 3217385, 3247450, 3277520, 3307590, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3247450,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 1050,
        },
    },
    items = {
        {
            type = "npc",
            id = 165859,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59710,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59712,
            x = 0,
            connections = {
                2,
            },
        },
        {
            visible = false,
            x = -3,
        },
        {
            type = "quest",
            id = 59846,
            x = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain10,
            embed = true,
            aside = true,
            x = 3,
        },
        {
            type = "quest",
            id = 59713,
            x = -1,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59714,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59715,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59716,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 59724,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59868,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59726,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain03, {
    name = { -- The Night Market
        type = "quest",
        id = 58060,
    },
    questline = 1185,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
        {
            type = "chain",
            id = Chain.TheRebellion,
            upto = 60506,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        id = 58060,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 58062,
    },
    rewards = {
        {
            type = "money",
            amount = 90090,
        },
    },
    items = {
        {
            type = "npc",
            id = 160100,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58060,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58062,
            x = 0,
        },
    --[[
        {
            type = "kill",
            id = 156395,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58079,
            x = 0,
        },

        {
            type = "kill",
            id = 158420,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58077,
            x = 0,
        },
    ]]
    },
})
Database:AddChain(Chain.Chain04, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 6), -- Revelations of the Light
    questline = 1147,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 58, },
            },
        },
    },
    active = {
        type = "quest",
        id = 60467,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60470,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        46200, 47100, 48000, 49200, 50100, 51000, 51900, 52800, 53700, 54600, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amount = 54600,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1404000, 1418040, 1432080, 1446120, 1460160, 1474200, 1488240, 1502280, 1516320, 1530360, 1544400, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1530360,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 400,
        },
    },
    items = {
        {
            type = "npc",
            id = 168455,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60467,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 60469,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 60468,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60470,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain05, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 5), -- Mirror Maker of the Master
    questline = 1146,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
    },
    active = {
        type = "quest",
        ids = {
            60051, 57531, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 57536,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        95325, 97200, 99075, 101400, 103275, 105150, 107025, 108900, 110775, 112575, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amount = 112575,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        3159000, 3190590, 3222180, 3253770, 3285360, 3316950, 3348540, 3380130, 3411720, 3443310, 3474900, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3443310,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 950,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 60051,
                    restrictions = {
                        type = "quest",
                        id = 60051,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "npc",
                    id = 158038,
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57531,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57532,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57571,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 57533,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57534,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57535,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59427,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57536,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain06, {
    name = BtWQuests.GetAreaName(11002),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
    },
    active = {
        type = "quest",
        ids = {60280, 60278},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {60280, 60278},
        count = 2,
    },
    rewards = {
        {
            type = "experience",
            amounts = {
                11600, 11800, 12050, 12250, 12500, 12700, 12950, 13200, 13400, 13650, 
            },
            minLevel = 50,
            maxLevel = 59,
            restrictions = 86994,
        },
        {
            type = "reputation",
            id = 2413,
            amount = 550,
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain11,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain12,
            embed = true,
        },
    },
})
Database:AddChain(Chain.Chain07, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 4), -- The Final Atonement
    questline = 1144,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
    },
    active = {
        type = "quest",
        id = 57919,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 58092,
    },
    rewards = {
        {
            name = L["HALLS_OF_ATONEMENT_VENTHYR_RITUALS"],
            type = "spell",
            id = 312427,
        },
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        147725, 150525, 153500, 156250, 159300, 162100, 165250, 168150, 171100, 173900, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        171100, 173900, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        5569200, 5624895, 5680590, 5736270, 5791965, 5847660, 5903355, 5959050, 6014730, 6070425, 6126120, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 6014730,
                },
            },
        },
        {
            type = "reputation",
            id = 2439,
            amount = 1500,
        },
    },
    items = {
        {
            type = "npc",
            id = 160116,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57919,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 57920,
            x = -2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 57921,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57922,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57923,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57924,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57925,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 57926,
            x = -2,
            connections = {
                6,
            },
        },
        {
            type = "quest",
            id = 60127,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 57928,
            aside = true,
        },
        {
            type = "quest",
            id = 57927,
            x = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain06,
            embed = true,
            aside = true,
        },
        {
            type = "quest",
            id = 60128,
            x = 0,
            y = 8,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 57929,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58092,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain08, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 2), -- Tithes of Darkhaven
    questline = 1145,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 57, },
            },
        },
    },
    active = {
        type = "quest",
        ids = {60177, 60176},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60178,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        19250, 19650, 20000, 20500, 20850, 21250, 21600, 22000, 22350, 22750, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        22350, 22750, 
                    },
                    minLevel = 58,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        585000, 590850, 596700, 602550, 608400, 614250, 620100, 625950, 631800, 637650, 643500, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 631800,
                },
            },
        },
        {
            type = "reputation",
            id = 2413,
            amount = 200,
        },
    },
    items = {
        {
            type = "npc",
            id = 167489,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 156822,
            aside = true,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 60177,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 60176,
            aside = true,
        },
        {
            type = "quest",
            id = 60178,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain09, {
    name = { -- Bell of Remembrance
        type = "quest",
        id = 58717,
    },
    questline = 1193,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        {
            type = "level",
            variations = {
                { level = 50, restrictions = 86994, },
                { level = 60, },
            },
        },
        {
            name = "Unknown",
        }
    },
    active = {
        type = "quest",
        id = 58717,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 58725,
    },
    rewards = {
        {
            type = "money",
            amount = 386100,
        },
    },
    items = {
        {
            type = "kill",
            id = 160847,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58717,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58725,
            x = 0,
        },
    },
})

Database:AddChain(Chain.EmbedChain01, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    questline = 1143,
    items = {
        {
            type = "npc",
            id = 168618,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60480,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain02, {
    questline = 1177,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 352490,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 58272,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain03, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "kill",
            id = 165253,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60517,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain04, {
    questline = 1180,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 351889,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60279,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain05, {
    questline = 1145,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "npc",
            id = 167489,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60177,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60178,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain06, {
    questline = 1144,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "npc",
            id = 168698,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60487,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain07, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "item",
            id = 182738,
            locations = {
                [1525] = {
                    {
                        x = 0.310485,
                        y = 0.550631,
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
            id = 62189,
            x = 0,
            connections = {
                1,
            },
        },
    },
})
Database:AddChain(Chain.EmbedChain08, {
    questline = 1182,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 351874,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60275,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain09, {
    questline = 1181,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 351888,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60276,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain10, {
    questline = 1191,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 351885,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60277,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain11, {
    questline = 1183,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 351887,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60280,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain12, {
    questline = 1184,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 351886,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60278,
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
    buttonImage = 3759912,
    items = {
        {
            type = "chain",
            id = Chain.WelcomeToRevendreth,
        },
        {
            type = "chain",
            id = Chain.MeetTheMaster,
        },
        {
            type = "chain",
            id = Chain.TheAccusersSecret,
        },
        {
            type = "chain",
            id = Chain.TheRebellion,
        },
        {
            type = "chain",
            id = Chain.SecuringSinfall,
        },
        {
            type = "chain",
            id = Chain.ThePrinceAndTheTower,
        },
        {
            type = "chain",
            id = Chain.MenagerieOfTheMaster,
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
            id = Chain.Chain08,
            visible = 86994,
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
        {
            type = "chain",
            id = Chain.Chain09,
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
})

