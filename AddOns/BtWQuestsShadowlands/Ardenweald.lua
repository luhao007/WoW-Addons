--[[
    [Supplies Needed: More Husks!] requires ATLEAST [Unsafe Workplace] to be active, NOT available with JUST [Supplies Needed: Amber Grease] completed
]]

local BtWQuests = BtWQuests
local Database = BtWQuests.Database
local L = BtWQuests.L
local EXPANSION_ID = BtWQuests.Constant.Expansions.Shadowlands
local CATEGORY_ID = BtWQuests.Constant.Category.Shadowlands.Ardenweald
local Chain = BtWQuests.Constant.Chain.Shadowlands.Ardenweald
local ALLIANCE_RESTRICTIONS, HORDE_RESTRICTIONS = BtWQuests.Constant.Restrictions.Alliance, BtWQuests.Constant.Restrictions.Horde
local MAP_ID = 1565
local CONTINENT_ID = 1550
local ACHIEVEMENT_ID = 14164
local SIDE_ACHIEVEMENT_ID = 14800
local LEVEL_RANGE = {55, 57}
local LEVEL_PREREQUISITE = {
    type = "level",
    level = 55,
}

Database:AddChain(Chain.WelcomeToArdenweald, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    questline = 1002,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = 90207,
        }
    },
    active = {
        type = "quest",
        id = 60338,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57787,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        40500, 41300, 42100, 42900, 43750, 44550, 45400, 46200, 46950, 47750, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        44550, 45400, 46200, 26700, 17840, 
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
                        1567800, 1583480, 1599160, 1614830, 1630510, 1646190, 1661870, 1677550, 1693220, 1708900, 1724580, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1646190,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 173383,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60338,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60763,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60341,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60778,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60857,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60859,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57787,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TranquilPools, { -- [Aiding Tirna Vaal]
    name = L["AIDING_TIRNA_VAAL_TRANQUIL_POOLS"],
    questline = 1008,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
        },
    },
    active = {
        type = "quest",
        id = 57816,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60594,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        35625, 36325, 37000, 37900, 38600, 39300, 40000, 40700, 41350, 42100, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        40000, 40700, 41350, 24050, 
                    },
                    minLevel = 56,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1076400, 1087165, 1097930, 1108690, 1119455, 1130220, 1140985, 1151750, 1162510, 1173275, 1184040, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1140985,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 158487,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57816,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60567,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 60563,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60575,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60577,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60594,
            x = 0,
        },
    },
})
Database:AddChain(Chain.SpiritGlen, { -- [Aiding Tirna Vaal]
    name = L["AIDING_TIRNA_VAAL_SPIRIT_GLEN"],
    questline = {1008,1011},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
        },
    },
    active = {
        type = "quest",
        id = 57947,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 57951,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        25050, 25500, 26000, 26600, 27150, 27600, 28150, 28600, 29050, 29600, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        27600, 28150, 28600, 16550, 11040, 
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
                        748800, 756290, 763780, 771260, 778750, 786240, 793730, 801220, 808700, 816190, 823680, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 786240,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 158487,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57947,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 57948,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 57949,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57950,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57951,
            x = 0,
        },
    },
})
Database:AddChain(Chain.WaningGrove, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    questline = 1125,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
        },
    },
    active = {
        type = "quest",
        id = 60600,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60519,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        64525, 65875, 67050, 68600, 69800, 71150, 72350, 73700, 74850, 76200, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        72350, 73700, 74850, 43500, 
                    },
                    minLevel = 56,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2129400, 2150695, 2171990, 2193280, 2214575, 2235870, 2257165, 2278460, 2299750, 2321045, 2342340, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2257165,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 169031,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60600,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60624,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 60637,
            x = -2,
            connections = {
                3, 4, 
            },
        },
        {
            type = "quest",
            id = 60638,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 60639,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60647,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60648,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60671,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60709,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60724,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60519,
            x = 0,
        },
    },
})
Database:AddChain(Chain.GlitterfallHeights, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    questline = 1126,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
        },
    },
    active = {
        type = "quest",
        id = 60521,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60520,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        52975, 54025, 55050, 56300, 57350, 58400, 59450, 60500, 61500, 62550, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        59450, 60500, 61500, 35700, 
                    },
                    minLevel = 56,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1778400, 1796185, 1813970, 1831750, 1849535, 1867320, 1885105, 1902890, 1920670, 1938455, 1956240, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1885105,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 169031,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60521,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60628,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 60629,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60631,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60630,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60632,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60522,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60520,
            x = 0,
        },
    },
})
Database:AddChain(Chain.ThisIsTheWay, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 5),
    questline = 1127,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.GlitterfallHeights,
        },
    },
    active = {
        type = "quest",
        id = 60738,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60905,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        51025, 52075, 53000, 54300, 55250, 56300, 57250, 58300, 59200, 60300, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        58300, 59200, 60300, 
                    },
                    minLevel = 57,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1544400, 1559845, 1575290, 1590730, 1606175, 1621620, 1637065, 1652510, 1667950, 1683395, 1698840, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1652510,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 169142,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60738,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60764,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60839,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60840,
            aside = true,
        },
        {
            type = "quest",
            id = 60856,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60881,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60901,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60905,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheFallenTree, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 6),
    questline = 1025,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.GlitterfallHeights,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ThisIsTheWay,
        },
    },
    active = {
        type = "quest",
        id = 58473,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 58524,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        43325, 44175, 45000, 46100, 46950, 47800, 48650, 49500, 50300, 51200, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        49500, 50300, 51200, 
                    },
                    minLevel = 57,
                    maxLevel = 59,
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
                    amount = 1402130,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 160963,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58473,
            x = 0,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 58480,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 58484,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58483,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58486,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58488,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58524,
            x = 0,
        },
    },
})
Database:AddChain(Chain.VisionsOfTheDreamer, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 7),
    questline = 1027,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.GlitterfallHeights,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ThisIsTheWay,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheFallenTree,
        },
    },
    active = {
        type = "quest",
        ids = {
            60572, 58591, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 58723,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        51075, 52075, 53100, 54200, 55250, 56250, 57300, 58300, 59300, 60250, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        59300, 60100, 
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
                        1895400, 1914355, 1933310, 1952260, 1971215, 1990170, 2009125, 2028080, 2047030, 2065985, 2084940, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2047030,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 160894,
            x = 0,
            connections = {
                1, 4, 
            },
        },
        {
            type = "quest",
            id = 60572,
            x = -1,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 58589,
            x = -2,
            connections = {
                3, 4, 
            },
        },
        {
            type = "quest",
            id = 58592,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 58591,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60578,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58590,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58593,
            x = 0,
        },
    },
})
Database:AddChain(Chain.AwakenTheDreamer, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 8),
    questline = 1033,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.GlitterfallHeights,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.ThisIsTheWay,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.TheFallenTree,
            lowPriority = true,
        },
        {
            type = "chain",
            id = Chain.VisionsOfTheDreamer,
        },
    },
    active = {
        type = "quest",
        ids = {
            58714, 58719, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 58723,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        46300, 47250, 48100, 49050, 49950, 50900, 51800, 52800, 53550, 54600, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        53550, 54600, 
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
                        1918800, 1937990, 1957180, 1976360, 1995550, 2014740, 2033930, 2053120, 2072300, 2091490, 2110680, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2072300,
                },
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 161847,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 160894,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 58714,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58719,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58720,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60621,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58869,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60661,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58721,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58723,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58724,
            aside = true,
            x = 0,
        },
    },
})

Database:AddChain(Chain.Chain01, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 2), -- When a Gorm Eats a God
    questline = {1194,1161},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
            lowPriority = true,
            visible = 87203,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
            lowPriority = true,
            visible = 87203,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
            lowPriority = true,
            visible = 87203,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {
            57952, 58024, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 58026,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        59850, 60825, 62075, 63350, 64725, 65700, 67075, 68200, 69325, 70625, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        67075, 68200, 69325, 40225, 
                    },
                    minLevel = 56,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2047500, 2067981, 2088460, 2108916, 2129395, 2149876, 2170355, 2190836, 2211290, 2231771, 2252250, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 2170355,
                },
            },
        },
        {
            type = "reputation",
            id = 2465,
            amount = 640,
        },
    },
    items = {
        {
            type = "npc",
            id = 158921,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57952,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57818,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57824,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57825,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61051,
            x = 0,
            connections = {
                1.2, 2, 3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain01,
            embed = true,
        },
        {
            type = "quest",
            id = 58022,
            x = -2,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58023,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58025,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58026,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57660,
            aside = true,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain02, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 5), -- When a Gorm Eats a God
    questline = 1164,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.WaningGrove,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {
            58161, 62186, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 58166,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        70325, 71650, 73050, 74700, 76175, 77500, 78975, 80300, 81625, 83050, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        78775, 78975, 80300, 81625, 52300, 
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
                        2293200, 2316135, 2339070, 2361990, 2384925, 2407860, 2430795, 2453730, 2476650, 2499585, 2522520, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        2426115, 2430795, 2435475, 2440155, 
                    },
                    minLevel = 55,
                    maxLevel = 58,
                },
            },
        },
        {
            type = "reputation",
            id = 2465,
            amount = 1050,
        },
    },
    items = {
        {
            type = "npc",
            id = 160440,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58161,
            x = 0,
            connections = {
                2, 3, 4
            },
        },
        {
            type = "object",
            id = 349515,
            x = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 58164,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 58162,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58163,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59802,
            x = 0,
            connections = {
                2, 3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain02,
            embed = true,
        },
        {
            type = "quest",
            id = 58165,
            x = -2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 59801,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58166,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain03, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 3), -- Trouble at the Gormling Corral
    questline = {1162, 1167},
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.GlitterfallHeights,
            upto = 60632,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {
            57651, 57652, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 59656,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        94350, 96150, 98000, 100400, 102300, 104100, 106000, 107800, 109600, 111500, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        106000, 107800, 109600, 63700, 
                    },
                    minLevel = 56,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2854800, 2883350, 2911900, 2940440, 2968990, 2997540, 3026090, 3054640, 3083180, 3111730, 3140280, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3026090,
                },
            },
        },
        {
            type = "reputation",
            id = 2465,
            amount = 1280,
        },
    },
    items = {
        {
            type = "npc",
            id = 158345,
            x = -1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57651,
            x = -1,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 59621,
            x = -2,
            y = 2,
            connections = {
                2, 3, 4, 
            },
        },
        {
            type = "quest",
            id = 59622,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 57656,
            x = -3,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 57653,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 57655,
            aside = true,
            connections = {
                1.3, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain03,
            embed = true,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 57657,
            x = -2,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59656,
            x = -1,
            y = 5,
        },
    },
})
Database:AddChain(Chain.Chain04, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 1), -- Thread of Hope
    questline = 1166,
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
        id = 57661,
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 60066,
    },
    rewards = {
        {
            type = "money",
            amount = 1338480,
        },
    },
    items = {
        {
            type = "npc",
            id = 158556,
            x = -2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57661,
            x = -2,
            connections = {
                2, 3, 
            },
        },
        {
            type = "object",
            id = 350804,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60061,
            x = -2,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 60062,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 60064,
            x = 0,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60063,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60065,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60066,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain05, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 4), -- Tricky Spriggans
    questline = 1163,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        LEVEL_PREREQUISITE,
        {
            type = "chain",
            id = Chain.Chain03,
        },
    },
    active = {
        type = "quest",
        ids = {
            57866, 57865, 57867, 57868, 57870, 57869, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 57871,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        83775, 85425, 87075, 89100, 90750, 92400, 94050, 95700, 97350, 98925, 
                    },
                    minLevel = 50,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        94050, 95700, 97350, 56475, 
                    },
                    minLevel = 56,
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
                    amount = 2976480,
                },
            },
        },
        {
            type = "reputation",
            id = 2465,
            amount = 1120,
        },
    },
    items = {
        {
            type = "npc",
            id = 158345,
            x = -1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "npc",
            id = 160045,
            x = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 57866,
            x = -2,
        },
        {
            type = "quest",
            id = 57865,
        },
        {
            type = "quest",
            id = 57867,
        },
        {
            type = "npc",
            id = 159427,
            x = -2,
            connections = {
                3, 
            },
        },
        {
            type = "npc",
            id = 159465,
            connections = {
                3, 
            },
        },
        {
            type = "npc",
            id = 159428,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 57868,
            x = -2,
        },
        {
            type = "quest",
            id = 57870,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 57869,
        },
        {
            type = "quest",
            id = 57871,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Chain06, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(SIDE_ACHIEVEMENT_ID, 6), -- Wicked Plan
    questline = 1165,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    prerequisites = {
        LEVEL_PREREQUISITE,
        { -- Most likely
            type = "chain",
            id = Chain.TheFallenTree,
            visible = 87203,
        },
    },
    active = {
        type = "quest",
        ids = {
            58265, 58266, 58264, 
        },
        status = { "active", "completed", },
    },
    completed = {
        type = "quest",
        id = 58267,
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
                    amounts = {
                        52800, 53700, 54600, 
                    },
                    minLevel = 57,
                    maxLevel = 59,
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
                    amount = 1502280,
                },
            },
        },
        {
            type = "reputation",
            id = 2465,
            amount = 640,
        },
    },
    items = {
        {
            type = "npc",
            id = 160929,
            x = -2,
            connections = {
                2, 
            },
        },
        {
            type = "npc",
            id = 160749,
            x = 1,
            connections = {
                2, 3, 
            },
        },
        {
            type = "quest",
            id = 58265,
            aside = true,
            x = -2,
        },
        {
            type = "quest",
            id = 58266,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 58264,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58267,
            x = 0,
        },
    },
})

Database:AddChain(Chain.TempChain14, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            name = "Check Requirements",
            aside = true,
        },
        {
            type = "npc",
            id = 174341,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62458,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TempChain15, {
    questline = 1188,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            name = "Check Requirements",
            aside = true,
        },
        {
            type = "npc",
            id = 168032,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62371,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TempChain16, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            name = "embed?",
            aside = true,
        },
        {
            type = "item",
            id = 183129,
            breadcrumb = true,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62259,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TempChain17, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            name = "embed?",
            aside = true,
        },
        {
            type = "item",
            id = 183091,
            breadcrumb = true,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62246,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain01, {
    questline = 1161,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "npc",
            id = 171195,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 58024,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain02, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "item",
            id = 182730,
            breadcrumb = true,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62186,
            x = 0,
        },
    },
})
Database:AddChain(Chain.EmbedChain03, {
    questline = 1167,
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
        {
            type = "object",
            id = 348747,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 57652,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 59623,
            x = 0,
            y = 3,
        },
    },
})
Database:AddChain(Chain.EmbedChain04, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
    },
})
Database:AddChain(Chain.EmbedChain05, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    items = {
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
        { -- Rotbriar Trouble
            type = "quest",
            id = 59600,
        },
        { -- Seed Hunting
            type = "quest",
            id = 59825,
        },
        { -- Seize the Means of Production
            type = "quest",
            id = 60476,
        },
        { -- Terrors in Tirna Scithe
            type = "quest",
            id = 60533,
        },
        { -- Shaking 'Shrooms
            type = "quest",
            id = 60574,
        },
        { -- Spriggan Riot
            type = "quest",
            id = 60585,
        },
        { -- Trouble at the Gormling Corral
            type = "quest",
            id = 60597,
        },
        { -- Who Devours the Devourers?
            type = "quest",
            id = 60609,
        },
        { -- A Thorn In Their Side
            type = "quest",
            id = 60649,
        },
        { -- Tough Crowd
            type = "quest",
            id = 60739,
        },
        { -- Gormageddon
            type = "quest",
            id = 60855,
        },
        { -- A Night in the Woods
            type = "quest",
            id = 60899,
        },
        { -- A Matter of Stealth
            type = "quest",
            id = 60950,
        },
        { -- It's Raining Sparkles
            type = "quest",
            id = 61303,
        },
        { -- Our Heart Will Go On
            type = "quest",
            id = 61411,
        },
        { -- Natural Defenders
            type = "quest",
            id = 61946,
        },
        { -- Lurking In The Shadows
            type = "quest",
            id = 61947,
        },
        { -- Airborne Defense Force
            type = "quest",
            id = 61948,
        },
        { -- Ardenweald's Tricksters
            type = "quest",
            id = 61949,
        },
    },
})

Database:AddCategory(CATEGORY_ID, {
    name = BtWQuests.GetMapName(MAP_ID),
    expansion = EXPANSION_ID,
    buttonImage = 3759909,
    items = {
        {
            type = "chain",
            id = Chain.WelcomeToArdenweald,
        },
        {
            type = "chain",
            id = Chain.TranquilPools,
        },
        {
            type = "chain",
            id = Chain.SpiritGlen,
        },
        {
            type = "chain",
            id = Chain.WaningGrove,
        },
        {
            type = "chain",
            id = Chain.GlitterfallHeights,
        },
        {
            type = "chain",
            id = Chain.ThisIsTheWay,
        },
        {
            type = "chain",
            id = Chain.TheFallenTree,
        },
        {
            type = "chain",
            id = Chain.VisionsOfTheDreamer,
        },
        {
            type = "chain",
            id = Chain.AwakenTheDreamer,
        },
        {
            type = "chain",
            id = Chain.Chain01,
        },
        {
            type = "chain",
            id = Chain.Chain03,
        },
        {
            type = "chain",
            id = Chain.Chain05,
        },
        {
            type = "chain",
            id = Chain.Chain02,
        },
        {
            type = "chain",
            id = Chain.Chain06,
        },
        {
            type = "chain",
            id = Chain.Chain04,
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
