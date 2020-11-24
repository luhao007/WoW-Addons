-- AUTO GENERATED - NEEDS UPDATING

local BtWQuests = BtWQuests;
local Database = BtWQuests.Database;
local EXPANSION_ID = BtWQuests.Constant.Expansions.TheBurningCrusade;
local CATEGORY_ID = BtWQuests.Constant.Category.TheBurningCrusade.BladesEdgeMountains;
local Chain = BtWQuests.Constant.Chain.TheBurningCrusade.BladesEdgeMountains;
local ALLIANCE_RESTRICTIONS, HORDE_RESTRICTIONS = BtWQuests.Constant.Restrictions.Alliance, BtWQuests.Constant.Restrictions.Horde;
local MAP_ID = 105
local ACHIEVEMENT_ID = 1193
local CONTINENT_ID = 101
local LEVEL_RANGE = {20, 30}
local LEVEL_PREREQUISITES = {
    {
        type = "level",
        level = 20,
    },
}

Chain.Sylvanaar = 20501
Chain.ThunderlordStronghold = 20502
Chain.ToshleysStation = 20503
Chain.Reunion = 20504
Chain.TheGronnThreat = 20505
Chain.TheMoknathal = 20506
Chain.RuuanWeald = 20507

Chain.EmbedChain01 = 20511
Chain.EmbedChain02 = 20512
Chain.EmbedChain03 = 20513
Chain.EmbedChain04 = 20514
Chain.EmbedChain05 = 20515
Chain.EmbedChain06 = 20516
Chain.EmbedChain07 = 20517
Chain.EmbedChain08 = 20518
Chain.EmbedChain09 = 20519
Chain.EmbedChain10 = 20520
Chain.EmbedChain11 = 20521
Chain.EmbedChain12 = 20522
Chain.EmbedChain13 = 20523
Chain.EmbedChain14 = 20524
Chain.EmbedChain15 = 20525

Database:AddChain(Chain.Sylvanaar, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ThunderlordStronghold
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10457, 10518, 10504},
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
Database:AddChain(Chain.ThunderlordStronghold, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.Sylvanaar
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10488, 10544, 10545, 10505},
        count = 4,
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

Database:AddChain(Chain.ToshleysStation, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 2),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ToshleysStation
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10675, 10712, 10594, 10671},
        count = 4,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain07,
            embed = true,
            x = -3,
        },
        {
            type = "chain",
            id = Chain.EmbedChain08,
            embed = true,
            x = 0,
            connections = {
                [4] = {
                    0.6, 1.4, 
                }, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain09,
            embed = true,
            x = 3,
        },
    },
})
Database:AddChain(Chain.Reunion, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 2),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ToshleysStation
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10526, 10742},
        count = 2,
    },
    items = {
        {
            name = "Kill Bladespire Orgres",
            breadcrumb = true,
            x = 0,
            connections = {
                1, 
            },
            comment = "May need another quest to drop",
        },
        {
            type = "quest",
            id = 10524,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10525,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10526,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10718,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10614,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10709,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10714,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10783,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10715,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10749,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10720,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10721,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10785,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10723,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10724,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10742,
            x = 0,
        },
    },
})

Database:AddChain(Chain.TheGronnThreat, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheMoknathal
    },
    restrictions = ALLIANCE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 10806,
    },
    items = {
        {
            type = "kill",
            id = 20753,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10797,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10798,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10799,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10800,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10801,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10802,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10818,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10805,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10806,
            x = 0,
        },
    },
})
Database:AddChain(Chain.TheMoknathal, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 3),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.TheGronnThreat
    },
    restrictions = HORDE_RESTRICTIONS,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10615, 10867},
        count = 2,
    },
    items = {
        {
            type = "npc",
            id = 21496,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10565,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "chain",
            id = Chain.EmbedChain10,
            embed = true,
            x = -1,
        },
        {
            type = "chain",
            id = Chain.EmbedChain11,
            embed = true,
        },
    },
})

Database:AddChain(Chain.RuuanWeald, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 4),
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        id = 9923,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {10607, 10771, 10821, 10912, 10748},
        count = 5,
    },
    items = {
        {
            type = "chain",
            id = Chain.EmbedChain12,
            embed = true,
            x = 0,
        },
        {
            type = "chain",
            id = Chain.EmbedChain13,
            embed = true,
            x = 3,
        },
        {
            type = "chain",
            id = Chain.EmbedChain14,
            embed = true,
            x = -1,
            y = 3,
        },
        {
            type = "chain",
            id = Chain.EmbedChain15,
            embed = true,
        },
    },
})

Database:AddChain(Chain.EmbedChain01, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10457,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 39199,
                    restrictions = {
                        type = "quest",
                        id = 39199,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 21066,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10455,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10456,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10457,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10506,
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
        id = 10504,
    },
    items = {
        {
            type = "npc",
            id = 21158,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10502,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10504,
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
        id = 10518,
    },
    items = {
        {
            type = "npc",
            id = 21277,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10516,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10517,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10518,
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
        id = 10488,
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 39198,
                    restrictions = {
                        type = "quest",
                        id = 39198,
                        status = {
                            "active",
                            "completed",
                        },
                    },
                },
                {
                    type = "npc",
                    id = 21117,
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10486,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10487,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10488,
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
        id = 10505,
    },
    items = {
        {
            type = "npc",
            id = 21147,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10503,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10505,
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
        id = 10544,
    },
    items = {
        {
            type = "npc",
            id = 21349,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10542,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10545,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10543,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10544,
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
        id = 10594,
    },
    items = {
        {
            type = "npc",
            id = 21755,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10608,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10594,
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
        id = 10675,
    },
    items = {
        {
            type = "npc",
            id = 21691,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10584,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10620,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10657,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 10671,
            x = -1,
        },
        {
            type = "quest",
            id = 10674,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10675,
            x = 1,
        },
    },
})
Database:AddChain(Chain.EmbedChain09, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10712,
    },
    items = {
        {
            type = "npc",
            id = 21460,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10557,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10710,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10711,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10712,
            x = 0,
            comment = "Unknown exact requirements",
        },
    },
})
Database:AddChain(Chain.EmbedChain10, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10615,
    },
    items = {
        {
            type = "quest",
            id = 10566,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 10615,
            x = 0,
            connections = {
            },
        },
    },
})
Database:AddChain(Chain.EmbedChain11, {
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    completed = {
        type = "quest",
        id = 10867,
    },
    items = {
        {
            type = "quest",
            id = 10846,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10843,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10845,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "npc",
            id = 22312,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10851,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10853,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10859,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10865,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10867,
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
        id = 10607,
    },
    items = {
        {
            type = "npc",
            id = 21782,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10567,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10607,
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
        id = 10748,
    },
    items = {
        {
            type = "npc",
            id = 22007,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10682,
            x = 0,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 10713,
            aside = true,
            x = -1,
        },
        {
            type = "quest",
            id = 10719,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10894,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10893,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10722,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10748,
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
        id = 10821,
    },
    items = {
        {
            name = "Kill Felsworn",
            breadcrumb = true,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10810,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10812,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10819,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10820,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10821,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10910,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10904,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10911,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10912,
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
        id = 10771,
    },
    items = {
        {
            type = "npc",
            id = 22053,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 10771,
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
            id = Chain.Sylvanaar,
        },
        {
            type = "chain",
            id = Chain.ThunderlordStronghold,
        },
        {
            type = "chain",
            id = Chain.ToshleysStation,
        },
        {
            type = "chain",
            id = Chain.Reunion,
        },
        {
            type = "chain",
            id = Chain.TheGronnThreat,
        },
        {
            type = "chain",
            id = Chain.TheMoknathal,
        },
        {
            type = "chain",
            id = Chain.RuuanWeald,
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
