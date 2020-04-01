local L = BtWQuests.L;
local MAP_ID = 862
local ACHIEVEMENT_ID = 11861
local CONTINENT_ID = 875

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(ACHIEVEMENT_ID, 1),
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_INTRODUCTION,
    },
    active = {
        {
            type = "quest",
            id = 47514,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 49663,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2114600, 2158200, 2201800, 2245400, 2289000, 2332600, 2376200, 2419800, 2463400, 2507000, 2550600, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                154650, 156000, 157250, 158550, 159800, 161200, 162650, 164000, 165000, 166350, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 150,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 1035,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 47514,
            x = 3,
            y = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 49615,
            x = 3,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 49488,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49489,
            x = 1,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49490,
            x = 3,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49491,
            x = 5,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49492,
            x = 3,
            y = 4,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49493,
            x = 1,
            y = 5,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49494,
            x = 3,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51663,
            x = 5,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49495,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49905,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49663,
            x = 3,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 2)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 47514,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50881,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1571400, 1603800, 1636200, 1668600, 1701000, 1733400, 1765800, 1798200, 1830600, 1863000, 1895400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                108550, 109550, 110450, 111300, 112200, 113200, 114150, 115150, 115850, 116850, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 960,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        -- {
        --     type = "quest",
        --     id = 48176,
        --     x = 0,
        --     y = 0,
        --     connections = {
        --         2, 
        --     },
        -- },
        {
            type = "quest",
            id = 50835,
            x = 3,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 46846,
            x = 0,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 46926,
            x = 3,
            y = 1,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 46927,
            x = 0,
            y = 2,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 46928,
            x = 2,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 46929,
            x = 4,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN13,
            relationship = {
                breadcrumb = 48456,
                blocker = 48452,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 6,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50881,
            x = 2,
            y = 3,
        },
    },
})
-- @TODO does this actually require BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL?
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 3)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
    },
    completed = {
        type = "quest",
        id = 49310,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1784800, 1821600, 1858400, 1895200, 1932000, 1968800, 2005600, 2042400, 2079200, 2116000, 2152800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                126650, 127800, 128850, 129850, 130900, 132050, 133200, 134350, 135150, 136300, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 825,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
            x = 1,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
            x = 3,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
            x = 5,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49122,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49144,
            x = 1,
            y = 2,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 49145,
            x = 3,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49146,
            x = 5,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49147,
            x = 1,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49148,
            x = 3,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49149,
            x = 5,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49309,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49310,
            x = 3,
            y = 5,
            connections = {
            },
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WEB_OF_LIES, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 4)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
    },
    completed = {
        type = "quest",
        id = 47528,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2366800, 2415600, 2464400, 2513200, 2562000, 2610800, 2659600, 2708400, 2757200, 2806000, 2854800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                163650, 165150, 166500, 167800, 169150, 170650, 172100, 173600, 174650, 176150, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 800,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47509,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47897,
            x = 2,
            y = 2,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 47915,
            x = 4,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47518,
            x = 2,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47520,
            x = 4,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47521,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47522,
            x = 2,
            y = 5,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47963,
            x = 4,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47527,
            x = 6,
            y = 5,
        },
        {
            type = "quest",
            id = 47528,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_MARCH_OF_THE_LOA,
            aside = true,
            x = 3,
            y = 7,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_AMONG_THE_PEOPLE, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 5)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
    },
    completed = {
        type = "quest",
        id = 47741,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3453200, 3524400, 3595600, 3666800, 3738000, 3809200, 3880400, 3951600, 4022800, 4094000, 4165200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                255800, 258100, 260250, 262200, 264350, 266700, 269000, 271300, 272950, 275250, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 100,
        },
        {
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 985,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51101,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51680,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 47733,
            x = 0,
            y = 3,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 47739,
            x = 2,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47735,
            x = 4,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50235,
            x = 6,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51677,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47738,
            x = 3,
            y = 5,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 51678,
            x = 1,
            y = 6,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 51679,
            x = 3,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47742,
            x = 5,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47737,
            x = 3,
            y = 7,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47736,
            x = 2,
            y = 8,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47740,
            x = 4,
            y = 8,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47797,
            aside = true,
            x = 6,
            y = 8,
        },
        {
            type = "quest",
            id = 47734,
            x = 3,
            y = 9,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47741,
            x = 3,
            y = 10,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_MARCH_OF_THE_LOA,
            aside = true,
            x = 3,
            y = 11,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 6)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 47514,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        ids = {47439, 47440},
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2541400, 2593800, 2646200, 2698600, 2751000, 2803400, 2855800, 2908200, 2960600, 3013000, 3065400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                166100, 167650, 169000, 170350, 171700, 173250, 174650, 176200, 177300, 178850, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 825,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 47445,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47423,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47433,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47434,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47435,
            x = 4,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47437,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47422,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        { -- 47443 for Gonk, 47436 for Pa'ku
            type = "quest",
            id = 47438,
            x = 3,
            y = 6,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 47439,
            visible = {
                {
                    type = "quest",
                    id = 47443,
                    completed = false,
                },
                {
                    type = "quest",
                    id = 47436,
                    completed = false,
                },
            },
            x = 2,
            y = 7,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47440,
            visible = {
                {
                    type = "quest",
                    id = 47443,
                    completed = false,
                },
                {
                    type = "quest",
                    id = 47436,
                    completed = false,
                },
            },
            x = 4,
            y = 7,
            connections = {
                2, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    ids = {47439, 47440},
                    restrictions = {
                        type = "quest",
                        id = 47443,
                    },
                },
                {
                    type = "quest",
                    ids = {47440, 47439},
                    restrictions = {
                        type = "quest",
                        id = 47436,
                    },
                },
                {
                    name = L["PICK_A_LOA"],
                    visible = false,
                },
            },
            x = 3,
            y = 7,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            ids = {47432, 48897},
            aside = true,
            x = 3,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_MARCH_OF_THE_LOA, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 7)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WEB_OF_LIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_AMONG_THE_PEOPLE,
        },
    },
    completed = {
        type = "quest",
        id = 49426,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2172800, 2217600, 2262400, 2307200, 2352000, 2396800, 2441600, 2486400, 2531200, 2576000, 2620800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                192500, 194200, 195750, 197350, 198900, 200650, 202450, 204000, 205500, 207050, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 675,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 1235,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WEB_OF_LIES,
            x = 2,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_AMONG_THE_PEOPLE,
            x = 4,
            y = 0,
            connections = {
                1, 
            },
        },


        {
            variations = {
                {
                    type = "quest",
                    id = 51111,
                    breadcrumb = true,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "quest",
                    id = 50433,
                    breadcrumb = true,
                },
            },
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },


        {
            type = "quest",
            id = 49421,
            breadcrumb = true,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49965,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49422,
            x = 2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49424,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49425,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49426,
            x = 3,
            y = 6,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49901,
            aside = true,
            x = 2,
            y = 7,
        },
        {
            type = "quest",
            id = 50963,
            aside = true,
            x = 4,
            y = 7,
        },
    },
})
-- Completed, horde only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN10, {
    name = { -- Curse of Jani
        type = "quest",
        id = 47442,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 47441,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 47442,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                388000, 396000, 404000, 412000, 420000, 428000, 436000, 444000, 452000, 460000, 468000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                32900, 33200, 33500, 33700, 34000, 34300, 34600, 34900, 35100, 35400, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 75,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 300,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 127665,
            -- name = "Go to Nokano",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1165, 0.402648, 0.190583, "Nokano")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47441,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47442,
            x = 3,
            y = 2,
        },
    },
})
-- Completed, both factions, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN11, {
    name = { -- Hunting the Hunter
        type = "quest",
        id = 47586,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 49768,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47583,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47584,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50466,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47585,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 47587,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2735400, 2791800, 2848200, 2904600, 2961000, 3017400, 3073800, 3130200, 3186600, 3243000, 3299400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                182550, 184250, 185750, 187200, 188700, 190400, 191950, 193650, 194850, 196550, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 115,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
        {
            type = "reputation",
            id = 2159,
            amount = 500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 123022,
            -- name = "Go to Tracker Burke",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.675628, 0.177215, "Tracker Burke")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49768,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 0,
            y = 0,
            connections = {
                5,
            },
        },
        {
            type = "npc",
            id = 123026,
            -- name = "Go to Erak the Aloof",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.674482, 0.177204, "Erak the Aloof")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49768,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 2,
            y = 0,
            connections = {
                5,
            },
        },
        {
            type = "npc",
            id = 123005,
            -- name = "Go to Hemet Nesingwary",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.675029, 0.177058, "Hemet Nesingwary")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49768,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 4,
            y = 0,
            connections = {
                5,
            },
        },
        {
            type = "npc",
            id = 123118,
            -- name = "Go to Trapper Custer",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.688548, 0.194381, "Trapper Custer")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49768,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 6,
            y = 0,
            connections = {
                5,
            },
        },

        {
            type = "quest",
            id = 49768,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 3,
            y = 0,
            connections = {
                2, 3, 4,
            },
        },



        {
            type = "quest",
            id = 47583,
            x = 0,
            y = 1,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 47584,
            x = 2,
            y = 1,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 50466,
            x = 4,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47585,
            x = 6,
            y = 1,
            connections = {
                2,
            },
        },


        {
            type = "object",
            id = 271706,
            -- name = "Go to the Hunters' Board",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.674402, 0.179215, "Hunters' Board")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 1,
            y = 2,
            connections = {
                3, 4,
            },
        },


        {
            type = "quest",
            id = 47586,
            x = 3,
            y = 2,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50178,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 5,
            y = 2,
        },


        {
            type = "quest",
            id = 47706,
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 51091,
            aside = true,
            x = 2,
            y = 3,
        },
        {
            type = "quest",
            id = 47587,
            x = 4,
            y = 3,
        },
    },
})
-- Completed, horde only, has requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN9, {
    name = { -- Hope's Blue Light
        type = "quest",
        id = 49884,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
    },
    active = {
        {
            type = "quest",
            id = 52210,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49758,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 49884,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1571400, 1603800, 1636200, 1668600, 1701000, 1733400, 1765800, 1798200, 1830600, 1863000, 1895400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                96200, 97100, 97850, 98700, 99450, 100350, 101150, 102050, 102700, 103600, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 100,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 925,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 52210,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 140590,
                    -- name = "Go to Captain Grez'ko",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(1165, 0.461302, 0.945733, "Captain Grez'ko")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49758,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49775,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49754,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49871,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49785,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49884,
            x = 3,
            y = 7,
        },
    },
})
-- Completed, Both factions, no requirements, 1 breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN15, {
    name = { -- Word from the Deep
        type = "quest",
        id = 51538,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 50331,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48014,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51538,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1202800, 1227600, 1252400, 1277200, 1302000, 1326800, 1351600, 1376400, 1401200, 1426000, 1450800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                89650, 90450, 91200, 91900, 92650, 93450, 94300, 95100, 95650, 96450, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2163,
            amount = 460,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 50331,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 125047,
                    -- name = "Go to Rokor",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(1165, 0.577624, 0.923117, "Rokor")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48014,
            x = 2,
            y = 1,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 48015,
            x = 4,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48025,
            aside = true,
            x = 2,
            y = 2,
        },
        {
            type = "quest",
            id = 49969,
            x = 4,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48026,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51538,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51539,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, alliance only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN5_ALLIANCE, {
    name = { -- Gorilla Warfare
        type = "quest",
        id = 53452,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 53449,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 53453,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 53450,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 53452,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 53453,
        },
        {
            type = "quest",
            id = 53450,
        },
        {
            type = "quest",
            id = 53452,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                776000, 792000, 808000, 824000, 840000, 856000, 872000, 888000, 904000, 920000, 936000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                53450, 53950, 54400, 54800, 55250, 55750, 56200, 56700, 57050, 57550, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2159,
            amount = 300,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 53449,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 143787,
                    -- name = "Go to Flap-Flap",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.515185, 0.529641, "Flap-Flap")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 2,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "npc",
            id = 143792,
            -- name = "Go to Tsunga",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.501715, 0.545688, "Tsunga")
            -- end,
            -- breadcrumb = true,
            x = 5,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 53453,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 53450,
            x = 3,
            y = 1,
        },
        {
            type = "quest",
            id = 53452,
            x = 5,
            y = 1,
        },
    },
})
-- Seems like it requires same as BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_MARCH_OF_THE_LOA but
-- that doesnt make sense with the context of the quests
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN8, {
    name = BtWQuests_GetAreaName(9716), -- The Forward Guard
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WEB_OF_LIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_AMONG_THE_PEOPLE,
        },
    },
    active = {
        {
            type = "quest",
            id = 51555,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51286,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                989400, 1009800, 1030200, 1050600, 1071000, 1091400, 1111800, 1132200, 1152600, 1173000, 1193400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                83900, 84650, 85400, 85950, 86700, 87450, 88250, 89000, 89500, 90250, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2157,
            amount = 375,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WEB_OF_LIES,
            x = 2,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_AMONG_THE_PEOPLE,
            x = 4,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "npc",
            id = 141555,
            -- name = "Go to Baine Bloodhoof",
            -- breadcrumb = true,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51555,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 51248,
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 51246,
            x = 2,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 51247,
            x = 4,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51249,
            aside = true,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 51286,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, horde only, No requirements, no breadcrumbs, maybe connect to Who Seeks the Seekers?
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN12, {
    name = BtWQuests_GetAreaName(9355), -- Little Tortolla
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 52472,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48404,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 52472,
        },
        {
            type = "quest",
            id = 48405,
        }
    },
    rewards = {
        {
            type = "money",
            amounts = {
                582000, 594000, 606000, 618000, 630000, 642000, 654000, 666000, 678000, 690000, 702000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                37000, 37350, 37650, 37950, 38250, 38600, 38900, 39250, 39500, 39850, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 125,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
        {
            type = "reputation",
            id = 2163,
            amount = 300,
        },
    },
    items = {
        {
            type = "npc",
            id = 134346,
            -- name = "Go to Toki",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1165, 0.561589, 0.915987, "Toki")
            -- end,
            -- breadcrumb = true,
            x = 2,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 125312,
            -- name = "Go to Scrollsage Rooka",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1165, 0.559519, 0.888351, "Scrollsage Rooka")
            -- end,
            -- breadcrumb = true,
            x = 4,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 52472,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 48404,
            x = 4,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48405,
            x = 4,
            y = 2,
        },
    },
})
-- Completed, horde only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN13, {
    name = { -- Witch Doctor Jala
        type = "quest",
        id = 48456,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 48456,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48452,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48454,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                213400, 217800, 222200, 226600, 231000, 235400, 239800, 244200, 248600, 253000, 257400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                18100, 18250, 18400, 18550, 18700, 18850, 19050, 19200, 19300, 19450, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 100,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 100,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 48456,
                    restrictions = BtWQuestsItem_ActiveOrCompleted
                },
                {
                    type = "npc",
                    id = 126148,
                    -- name = "Go to Witch Doctor Jala",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(1165, 0.442453, 0.821521, "Witch Doctor Jala")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48452,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48454,
            x = 3,
            y = 2,
        },
    },
})
-- Alliance only, Unknown requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN6_ALLIANCE, {
    name = { -- The Thrill of Exploration
        type = "quest",
        id = 49276,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 49059,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49276,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51085,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 49428,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1940000, 1980000, 2020000, 2060000, 2100000, 2140000, 2180000, 2220000, 2260000, 2300000, 2340000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                127500, 128650, 129650, 130750, 131750, 133000, 134000, 135150, 136100, 137250, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 115,
        },
        {
            type = "reputation",
            id = 2159,
            amount = 875,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 49059,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 131777,
                    -- name = "Go to Acadia Chistlestone",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.413323, 0.714221, "Acadia Chistlestone")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 3,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "object",
            id = 287228,
            -- name = "Go to Wanted Sign",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.407947, 0.711349, "Wanted Sign")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 5,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49276,
            x = 3,
            y = 1,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 51085,
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 49274,
            x = 1,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50044,
            x = 3,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49060,
            x = 5,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49282,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49428,
            x = 2,
            y = 4,
        },
        {
            type = "quest",
            id = 49427,
            aside = true,
            x = 4,
            y = 4,
        },
    },
})
-- Completed, both factions, Has no requirements, 1 breadcrumb, breadcrumb requires BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI though
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN3, {
    name = { -- Who seeks the seekers
        type = "quest",
        id = 49283,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 49284,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49285,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49315,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51407,
    },
    rewards = {
        {
            type = "toy",
            id = 156871,
        },
        {
            type = "money",
            amounts = {
                1930800, 1970600, 2010400, 2050200, 2090000, 2129800, 2169600, 2209400, 2249200, 2289000, 2328800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                143100, 144400, 145600, 146700, 147900, 149200, 150500, 151800, 152700, 154000, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2163,
            amount = 610,
        },
    },
    items = {
        {
            type = "npc",
            id = 129586,
            -- name = "Go to Batu",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.7070, 0.6530, "Batu")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49283,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 2,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "npc",
            id = 128888,
            -- name = "Go to Koba",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.702984, 0.650605, "Koba")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49283,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 4,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49283,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49284,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49285,
            x = 4,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49315,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 49286,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49287,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49288,
            x = 4,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49289,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51407,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN15,
            aside = true,
            relationship = {
                breadcrumb = 50331,
                blockers = {48014, 48015},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 3,
            y = 6,
        },
    },
})
-- Completed, horde only, requries BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN6_HORDE, {
    name = { -- The Bloodwatcher Legacy
        type = "quest",
        id = 47329,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
    },
    active = {
        {
            type = "quest",
            id = 47257,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47329,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51087,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 48399,
        },
        {
            type = "quest",
            id = 48400,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1843000, 1881000, 1919000, 1957000, 1995000, 2033000, 2071000, 2109000, 2147000, 2185000, 2223000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                131600, 132800, 133900, 134900, 136000, 137250, 138350, 139550, 140450, 141650, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 115,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 820,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 47257,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 131582,
                    -- name = "Go to Examiner Tae'shara Bloodwatcher",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.439119, 0.721078, "Examiner Tae'shara Bloodwatcher")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "object",
            id = 287229,
            -- name = "Go to the Wanted Sign",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.443004, 0.721670, "Wanted Sign")
            -- end,
            -- breadcrumb = true,
            x = 6,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47329,
            x = 3,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 51087,
            x = 6,
            y = 2,
        },
        {
            type = "quest",
            id = 47235,
            x = 1,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50043,
            x = 3,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47228,
            x = 5,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48317,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48399,
            x = 2,
            y = 5,
        },
        {
            type = "quest",
            id = 48400,
            x = 4,
            y = 5,
        },
    },
})
-- Completed, horde only, no requirements, no breadcrumbs?
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN14, {
    name =  { -- Aggressive Mating Strategy
        type = "quest",
        id = 49801,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 49810,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50297,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1619900, 1653300, 1686700, 1720100, 1753500, 1786900, 1820300, 1853700, 1887100, 1920500, 1953900, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                125050, 126150, 127200, 128150, 129200, 130400, 131450, 132550, 133450, 134550, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 1250,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 130929,
            -- name = "Go to Witch Doctor Jangalar",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.641294, 0.353786, "Witch Doctor Jangalar")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49810,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49814,
            x = 1,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50154,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49801,
            x = 5,
            y = 2,
            connections = {
                2, 
            },
        },

        {
            type = "quest",
            id = 50150,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50074,
            x = 4,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50252,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50268,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49870,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50297,
            x = 3,
            y = 7,
        },
    },
})
-- Completed, horde only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN5_HORDE, {
    name =  { -- Gorilla Warfare
        type = "quest",
        id = 49920,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 49920,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49919,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49922,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49918,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 49920,
        },
        {
            type = "quest",
            id = 49919,
        },
        {
            type = "quest",
            id = 49922,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1164000, 1188000, 1212000, 1236000, 1260000, 1284000, 1308000, 1332000, 1356000, 1380000, 1404000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                86350, 87150, 87900, 88500, 89250, 90050, 90800, 91600, 92150, 92950, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 75,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 375,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 130947,
            -- name = "Go to Tsunga",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.501715, 0.545688, "Tsunga")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 0,
            connections = {
                2,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 49917,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 132617,
                    -- name = "Go to Bently Greaseflare",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.516049, 0.505771, "Bently Greaseflare")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 3,
            y = 0,
            connections = {
                2, 3,
            },
        },
        
        {
            type = "quest",
            id = 49920,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 49919,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 49922,
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            id = 49918,
            aside = true,
            x = 6,
            y = 1,
        },
    },
})
-- Completed, horde only, no requirements, 1 breadcrumb
BtWQuestsCharacters:AddFriendshipReputation(2370)
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN4, {
    name = { -- How to Train Your Direhorn
        type = "achievement",
        id = 13542,
    },
    -- name = { -- The Orphaned Hatchling
    --     type = "quest",
    --     id = 47226,
    -- },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 50538,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47226,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 55798,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                5963400, 6024600, 6085800, 6147000, 6208200, 6269400, 6330600, 6391800, 6453000, 6514200, 6575400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                190000, 191700, 193250, 194800, 196350, 198100, 199800, 201500, 202750, 204450, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 115,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 1150,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 50538,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 122939,
                    -- name = "Go to Direhorn Hatchling",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.643344, 0.447053, "Direhorn Hatchling")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47226,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47259,
            x = 2,
            y = 2,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 48527,
            x = 4,
            y = 2,
            connections = {
                2, 3,
            },
        },

        
        {
            type = "quest",
            id = 47312,
            x = 0,
            y = 3,
            connections = {
                4, 5,
            },
        },
        {
            type = "quest",
            id = 47311,
            x = 2,
            y = 3,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 47272,
            x = 4,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 51980,
            aside = true,
            x = 6,
            y = 3,
        },


        {
            type = "quest",
            id = 51998,
            x = 2,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51990,
            x = 4,
            y = 4,
            connections = {
                1,
            },
        },

        {
            type = "quest",
            id = 47418,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47261,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48581,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47310,
            x = 3,
            y = 8,
            connections = {
                2,
            },
        },

        --@TODO put in daily? cooldown marker
        {
            type = "level",
            level = 120,
            x = 5,
            y = 8.5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47260,
            x = 3,
            y = 9,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52855,
            x = 3,
            connections = {
                1,
            },
        },
        { -- Also completed 55257, which may be a daily quest preventing the next part from being available
            type = "quest",
            id = 52857,
            x = 3,
            connections = {
                1, 
            },
        },

        --@TODO put in daily? cooldown marker

        {
            type = "quest",
            id = 55254,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55252,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55253,
            x = 3,
            connections = {
                1, 
            },
        },
        { -- Also completes 55259, probably daily quest for next part of the chain
            type = "quest",
            id = 55258,
            x = 3,
            connections = {
                1,
            },
        },

        -- { -- Daily quest, also marked 55494 as completed
        --     type = "quest",
        --     id = 55250,
        --     x = 2,
        -- },
        -- { -- Daily quest, also marked 55494 as completed, got as the 5th daily quest
        --     type = "quest",
        --     id = 55249,
        -- },
        -- { -- Daily quest
        --     type = "quest",
        --     id = 55251,
        -- },

        -- GetFriendshipReputation(2370)
        -- Rank 1: Hatchling
        -- Rank 2: Juvenile
        -- Rank 3: Maturity
        {
            name = L["RAISE_YOUR_DIREHORN_TO_A_JUVENILE"],
            type = "friendship",
            id = 2370,
            amount = 4000,
            active = {
                type = "quest",
                id = 55258,
            },
            x = 3,
            connections = {
                2, 
            },
        },
        {
            name = L["BTWQUESTS_WAIT_FOR_DAILY_RESET"],
            visible = {
                {
                    type = "friendship",
                    id = 2370,
                    amount = 4000,
                },
                {
                    type = "quest",
                    id = 55462,
                    status = {'notcompleted'},
                }
            },
            active = {
                type = "quest",
                id = 55494,
            },
            completed = {
                type = "quest",
                id = 55494,
                status = {'notcompleted'},
            },
            x = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55462,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55504,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55503,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55506,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55505,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55507,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            name = L["RAISE_YOUR_DIREHORN_TO_MATURITY"],
            type = "friendship",
            id = 2370,
            amount = 8000,
            active = {
                type = "quest",
                id = 55507,
            },
            x = 3,
            connections = {
                1, 
            },
        },
        -- {
        --     name = L["BTWQUESTS_WAIT_FOR_DAILY_RESET"],
        --     visible = {
        --         {
        --             type = "friendship",
        --             id = 2370,
        --             amount = 8000,
        --         },
        --         {
        --             type = "quest",
        --             id = 55247,
        --             status = {'notcompleted'},
        --         }
        --     },
        --     active = {
        --         type = "quest",
        --         id = 55494,
        --     },
        --     completed = {
        --         type = "quest",
        --         id = 55494,
        --         status = {'nocompleted'},
        --     },
        --     x = 1,
        --     connections = {
        --         1, 
        --     },
        -- },
        {
            type = "quest",
            id = 55247,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55795,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55796,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55797,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55798,
            x = 3,
        },
    },
})
-- Completed, Horde only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN7, {
    name = { -- Sandscar Breach
        type = "quest",
        id = 49940,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 49940,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49678,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49680,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49679,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49681,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 49678,
        },
        {
            type = "quest",
            id = 49680,
        },
        {
            type = "quest",
            id = 49679,
        },
        {
            type = "quest",
            id = 49681,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                989400, 1009800, 1030200, 1050600, 1071000, 1091400, 1111800, 1132200, 1152600, 1173000, 1193400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                71550, 72200, 72800, 73350, 73950, 74600, 75250, 75900, 76350, 77000, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 710,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 130450,
            -- name = "Go to Bladeguard Sonji",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.472488, 0.249500, "Bladeguard Sonji")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49940,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 0,
            y = 0,
            connections = {
                4, 5,
            },
        },
        {
            type = "npc",
            id = 131354,
            -- name = "Go to Beastmother Jabati",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.473304, 0.251454, "Beastmother Jabati")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49940,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 3,
            y = 0,
            connections = {
                5,
            },
        },
        {
            type = "npc",
            id = 130468,
            -- name = "Go to Lil' Tika",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.462368, 0.233301, "Lil' Tika")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 49940,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 6,
            y = 0,
            connections = {
                5,
            },
        },
        {
            type = "quest",
            id = 49940,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 3,
            y = 0,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49678,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 49680,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 49679,
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            id = 49681,
            x = 6,
            y = 1,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_OTHER_ALLIANCE, {
    name = "Other Alliance",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_OTHER_HORDE, {
    name = "Other Horde",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        {
            type = "quest",
            id = 50796,
        },
        {
            type = "quest",
            id = 52305,
        },
        {
            type = "quest",
            id = 50801,
        },
        {
            type = "quest",
            id = 49766,
        },
        {
            type = "quest",
            id = 49767,
        },
        {
            type = "quest",
            id = 50393,
        },
        {
            type = "quest",
            id = 50394,
        },
        {
            type = "quest",
            id = 50395,
        },
        {
            type = "quest",
            id = 50396,
        },
        {
            type = "quest",
            id = 50397,
        },
        {
            type = "quest",
            id = 50401,
        },
        {
            type = "quest",
            id = 50412,
        },
        { -- Emissary
            type = "quest",
            id = 50606,
        },
        {
            type = "quest",
            id = 50791,
        },
        {
            type = "quest",
            id = 50798,
        },
        {
            type = "quest",
            id = 50838,
        },
        {
            type = "quest",
            id = 50839,
        },
        {
            type = "quest",
            id = 50841,
        },
        {
            type = "quest",
            id = 50842,
        },
        {
            type = "quest",
            id = 50860,
        },
        {
            type = "quest",
            id = 50886,
        },
        {
            type = "quest",
            id = 50900,
        },
        {
            type = "quest",
            id = 50930,
        },
        {
            type = "quest",
            id = 50940,
        },
        {
            type = "quest",
            id = 50942,
        },
        {
            type = "quest",
            id = 50943,
        },
        {
            type = "quest",
            id = 50944,
        },
        {
            type = "quest",
            id = 51146,
        },
        {
            type = "quest",
            id = 51147,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_OTHER_BOTH, {
    name = "Other Both",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        {
            type = "quest",
            id = 50332,
        },
        {
            type = "quest",
            id = 51069,
        },
        {
            type = "quest",
            id = 50240,
        },
        {
            type = "quest",
            id = 51071,
        },
        {
            type = "quest",
            id = 52748,
        },
        {
            type = "quest",
            id = 52317,
        },
        {
            type = "quest",
            id = 50402,
        },
        {
            type = "quest",
            id = 52447,
        },
        {
            type = "quest",
            id = 53336,
        },
        {
            type = "quest",
            id = 53337,
        },
        {
            type = "quest",
            id = 50598,
        },
        {
            type = "quest",
            id = 50381,
        },
        {
            type = "quest",
            id = 50887,
        },
        {
            type = "quest",
            id = 51072,
        },
        {
            type = "quest",
            id = 49769,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    buttonImage = 1778892,
    listImage = {
        texture = "Interface\\Addons\\BtWQuestsBattleForAzeroth\\UI-CategoryButton",
        texCoords = {0, 0.7353515625, 0.46875, 0.5859375},
    },
    items = {
        {
            type = "header",
            name = L["BTWQUESTS_THE_WAR_CAMPAIGN"],
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_ALLIANCE
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_ZULDAZAR_FOOTHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_A_GOLDEN_OPPORTUNITY,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_THE_STRIKE_ON_ZULDAZAR,
        },


        {
            type = "header",
            name = {
                type = "achievement",
                id = ACHIEVEMENT_ID,
            },
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORTENTS_AND_PROPHECIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_PORT_OF_ZANDALAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WARPORT_RASTARI,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_WEB_OF_LIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_AMONG_THE_PEOPLE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_THE_ZANCHULI_COUNCIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_MARCH_OF_THE_LOA,
        },


        {
            type = "header",
            name = L["BTWQUESTS_SIDE_QUESTS"],
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN4,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN5_HORDE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN5_ALLIANCE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN6_HORDE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN6_ALLIANCE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN7,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN9,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN11,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN13,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN14,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN15,
        },


        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN3,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN31,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_OTHER_ALLIANCE,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_OTHER_HORDE,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_OTHER_BOTH,
        -- },
    },
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
}, true)

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN3,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN4,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN5_HORDE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN5_ALLIANCE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN6_HORDE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN6_ALLIANCE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN7,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN8,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN9,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN10,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN11,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN12,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN13,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN14,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ZULDAZAR_CHAIN15,
    },
})