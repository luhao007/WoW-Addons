--[[
    Known issues:
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN2 is rather messy atm, not sure exactly
        how it should be done.
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN13 Not sure what the requirements are.
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN14 Not sure what the requirements are.
]]

local L = BtWQuests.L;
local MAP_ID = 864
local ACHIEVEMENT_ID = 12478
local CONTINENT_ID = 875

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 2)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
    },
    completed = {
        type = "quest",
        ids = {48549, 48550},
        count = 2,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2134000, 2178000, 2222000, 2266000, 2310000, 2354000, 2398000, 2442000, 2486000, 2530000, 2574000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                185100, 186750, 188350, 189650, 191250, 193000, 194600, 196250, 197500, 199150, 
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
            id = 2158,
            amount = 1035,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
            x = 3,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "npc",
            id = 135012,
            -- name = "Go to Vivi",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.551955, 0.483843, "Vivi")
            -- end,
            -- breadcrumb = true,
            x = 6,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47319,
            x = 2,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 51574,
            x = 4,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50739,
            aside = true,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 47320,
            x = 3,
            y = 2,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 47322,
            aside = true,
            x = 0,
            y = 2.5,
        },
        {
            type = "quest",
            id = 50755,
            aside = true,
            x = 0,
            y = 3.5,
        },
        {
            type = "quest",
            id = 47317,
            x = 2,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47316,
            x = 4,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47321,
            x = 6,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47959,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48549,
            x = 2,
            y = 5,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48550,
            x = 4,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN1,
            relationship = {
                breadcrumb = 51829,
                blockers = {48551, 48553, 48555},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 6,
            y = 5,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
            aside = true,
            x = 3,
            y = 6,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 3)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
    },
    completed = {
        type = "quest",
        id = 47874,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2968200, 3029400, 3090600, 3151800, 3213000, 3274200, 3335400, 3396600, 3457800, 3519000, 3580200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                206600, 208300, 209950, 211700, 213350, 215350, 217150, 218850, 220400, 222100, 
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
            id = 2158,
            amount = 1065,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48684,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48895,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49040, -- 49731
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 48993,
            x = 2,
            y = 3,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 48992,
            x = 4,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 48991,
            x = 6,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48887,
            x = 2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48888,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48894,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48715,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48987,
            x = 3,
            y = 7,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48988,
            x = 2,
            y = 8,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49005,
            x = 4,
            y = 8,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48889,
            x = 3,
            y = 9,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48996,
            x = 3,
            y = 10,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50913,
            x = 3,
            y = 11,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47874,
            x = 3,
            y = 12,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
            aside = true,
            x = 3,
            y = 13,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 4)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
    },
    completed = {
        type = "quest",
        id = 50561,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1358000, 1386000, 1414000, 1442000, 1470000, 1498000, 1526000, 1554000, 1582000, 1610000, 1638000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                115200, 116200, 117200, 118000, 119000, 120100, 121100, 122100, 122900, 123900, 
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
            id = 2158,
            amount = 760,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48896,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47716,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48314,
            x = 2,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48313,
            x = 4,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50770,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50539,
            x = 3,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN12,
            aside = true,
            x = 5,
            y = 5,
        },
        {
            type = "quest",
            id = 48315,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50561,
            x = 3,
            y = 7,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS,
            aside = true,
            x = 2,
            y = 8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN2,
            relationship = {
                breadcrumb = 50794,
                blocker = 51573,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 4,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 5)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
        },
    },
    completed = {
        type = "quest",
        id = 49340,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1455000, 1485000, 1515000, 1545000, 1575000, 1605000, 1635000, 1665000, 1695000, 1725000, 1755000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                98750, 99600, 100450, 101150, 102000, 102950, 103800, 104650, 105350, 106200, 
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
            id = 2158,
            amount = 860,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
        {
            type = "reputation",
            id = 2159,
            amount = 250,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47324,
            x = 3,
            y = 1,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN6,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 51165,
            aside = true,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 49334,
            x = 1,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50641,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49327,
            x = 5,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49340,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_STORMING_THE_SPIRE,
            x = 3,
            y = 4,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_STORMING_THE_SPIRE, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 6)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS,
        },
    },
    completed = {
        type = "quest",
        id = 50550,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3918800, 3999600, 4080400, 4161200, 4242000, 4322800, 4403600, 4484400, 4565200, 4646000, 4726800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                258300, 260600, 262700, 264800, 266900, 269350, 271550, 273850, 275650, 277950, 
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
            id = 2158,
            amount = 1795,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS,
            x = 3,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN7,
            aside = true,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 49662,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50745,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49667,
            aside = true,
            x = 2,
            y = 3,
        },
        {
            type = "quest",
            id = 49664,
            x = 4,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49665,
            x = 3,
            y = 4,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 49666,
            x = 5,
            y = 4,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 49437,
            aside = true,
            x = 1,
            y = 5,
        },
        {
            type = "quest",
            id = 50746,
            x = 3,
            y = 5,
            connections = {
                2, 3,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN8,
            aside = true,
            x = 5,
            y = 5,
        },
        {
            type = "quest",
            id = 49141,
            x = 2,
            y = 6,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50748,
            x = 4,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49002,
            aside = true,
            x = 1,
            y = 7,
        },
        {
            type = "quest",
            id = 49003,
            x = 3,
            y = 7,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50750,
            x = 2,
            y = 8,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50752,
            x = 4,
            y = 8,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50550,
            x = 3,
            y = 9,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50805,
            aside = true,
            x = 2,
            y = 10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_ATULAMAN,
            aside = true,
            x = 4,
            y = 10,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_ATULAMAN, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 7)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS,
        },
    },
    completed = {
        type = "quest",
        id = 50702,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1261000, 1287000, 1313000, 1339000, 1365000, 1391000, 1417000, 1443000, 1469000, 1495000, 1521000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                134950, 136100, 137100, 138400, 139400, 140650, 141900, 142900, 144100, 145100, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 600,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 1035,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_STORMING_THE_SPIRE,
            breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50751,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50617,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50904,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50702,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50551,
            aside = true,
            x = 2,
            y = 5,
        },
        {
            type = "quest",
            ids = {50703, 52023, 52024},
            aside = true,
            x = 4,
            y = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 1)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 47513,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51364,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1493800, 1524600, 1555400, 1586200, 1617000, 1647800, 1678600, 1709400, 1740200, 1771000, 1801800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                114350, 115350, 116300, 117200, 118150, 119200, 120250, 121250, 122000, 123000, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 960,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 47513,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47313,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47314,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47315,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51357,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49676,
            x = 2,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47327,
            x = 4,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49677,
            x = 2,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51364,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
            x = 3,
            y = 8,
        }
    },
})
-- Completed, Horde Only, No requirements, 1 Breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN1, {
    name = BtWQuests_GetAreaName(9202), -- Withering Gulch
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 51829,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48551,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48553,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48555,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48554,
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
                69900, 70550, 71150, 71650, 72250, 72900, 73500, 74150, 74600, 75250, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 525,
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
                    id = 51829,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 126814,
                    -- name = "Go to Ranah",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(864, 0.538743, 0.693901, "Ranah")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 48551,
            x = 1,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48553,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48555,
            x = 5,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48554,
            x = 3,
            y = 2,
        },
    },
})
-- Horde Only, no requirements, 1 breadcrumb, rather messy
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN2, {
    name = BtWQuests_GetAreaName(9226), -- Scorched Sands Outpost
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 50794,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51573,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51668,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3938200, 4019400, 4100600, 4181800, 4263000, 4344200, 4425400, 4506600, 4587800, 4669000, 4750200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                272250, 274700, 277000, 279050, 281350, 283850, 286300, 288750, 290500, 292950, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 290,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 1350,
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
                    id = 50794,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 126576,
                    -- name = "Go to Razgaji",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(864, 0.433944, 0.753714, "Razgaji")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 1,
            connections = {
                1,
            }
        },
        {
            type = "quest",
            id = 51573,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            }
        },
        {
            type = "quest",
            id = 48529,
            x = 2,
            y = 3,
            connections = {
                2, 3,
            }
        },
        {
            type = "quest",
            id = 48530,
            x = 4,
            y = 3,
            connections = {
                3,
            }
        },
        
        {
            type = "quest",
            id = 48533,
            x = 0,
            y = 4,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 48531,
            aside = true,
            x = 2,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48532,
            aside = true,
            x = 4,
            y = 4,
        },
        {
            type = "quest",
            id = 48585,
            aside = true,
            x = 6,
            y = 4,
        },

        
        {
            type = "quest",
            id = 48655,
            x = 3,
            y = 5,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48656,
            x = 2,
            y = 6,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48657,
            x = 4,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48534,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48846,
            x = 3,
            y = 8,
            connections = {
                1, 2, 3,
            },
        },
        
        {
            type = "quest",
            id = 48850,
            x = 1,
            y = 9,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48790,
            x = 3,
            y = 9,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51602,
            x = 5,
            y = 9,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48847,
            x = 3,
            y = 10,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51668,
            x = 3,
            y = 11,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 51161,
            aside = true,
            x = 0,
            y = 12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN3,
            relationship = {
                breadcrumb = 51773,
                blockers = {47870, 47871},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 2,
            y = 12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN4,
            relationship = {
                breadcrumb = 51775,
                blocker = 48324,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 4,
            y = 12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN5,
            relationship = {
                breadcrumb = 51772,
                blockers = {47577, 47570, 47943},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 6,
            y = 12,
        },
    },
})
-- Completed, Both Factions, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN3, {
    name = { -- The Ashvane Threat
        type = "quest",
        id = 51773,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 51773,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47870,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47871,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 47873,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1552000, 1584000, 1616000, 1648000, 1680000, 1712000, 1744000, 1776000, 1808000, 1840000, 1872000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                98700, 99600, 100400, 101200, 102000, 102950, 103750, 104650, 105350, 106250, 
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
            id = 2158,
            amount = 150,
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
                    id = 51773,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 124468,
                }
            },
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 128422,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 5,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN15,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 47870,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47871,
            x = 4,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47939,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 6,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51810,
            x = 3,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49227,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 6,
            y = 2,
        },
        {
            type = "quest",
            id = 47873,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, Horde Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN4, {
    name = { -- The Golden Isle
        type = "quest",
        id = 51059,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 51775,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48324,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51062,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3705400, 3781800, 3858200, 3934600, 4011000, 4087400, 4163800, 4240200, 4316600, 4393000, 4469400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                240300, 242350, 244300, 246250, 248200, 250550, 252550, 254600, 256400, 258450, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 190,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 1290,
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
                    id = 51775,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 125904,
                    -- name = "Go to Norah",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(864, 0.388803, 0.773128, "Norah")
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
            id = 287440,
            -- name = "Go to the Wanted Poster",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.388563, 0.769764, "Wanted Poster")
            -- end,
            -- breadcrumb = true,
            x = 5,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48324,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51162,
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 51053,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51054,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 51056,
            x = 2,
            y = 4,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 51055,
            x = 4,
            y = 4,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 47647,
            aside = true,
            x = 6,
            y = 4,
        },
        
        {
            type = "quest",
            id = 49138,
            aside = true,
            x = 0,
            y = 5,
        },
        {
            type = "quest",
            id = 47499,
            x = 2,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51057,
            x = 4,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51059,
            x = 3,
            y = 6,
            connections = {
                1, 2,
            },
        },

        {
            type = "quest",
            id = 51060,
            x = 2,
            y = 7,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51061,
            x = 4,
            y = 7,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48326,
            x = 3,
            y = 8,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51062,
            x = 3,
            y = 9,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN9,
            relationship = {
                breadcrumb = 48327,
                blockers = {47497},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 3,
            y = 10,
        },
    },
})
-- Completed, Horde Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN5, {
    name = { -- The Tortaka Tribe
        type = "quest",
        id = 51772,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 51772,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47577,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47570,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47943,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 47578,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2192200, 2237400, 2282600, 2327800, 2373000, 2418200, 2463400, 2508600, 2553800, 2599000, 2644200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                161250, 162650, 163950, 165300, 166600, 168100, 169550, 170950, 172050, 173450, 
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
            id = 2163,
            amount = 770,
        },
    },
    items = {
        {
            type = "quest",
            id = 51772,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 3,
            y = 0,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "npc",
            id = 134098,
            -- name = "Go to Torka",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.620276, 0.223275, "Torka")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 51772,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 2,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "npc",
            id = 134128,
            -- name = "Go to Churka",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.619755, 0.221516, "Churka")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 51772,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 5,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47577,
            x = 1,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47570,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47943,
            x = 5,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47571,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47965,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 47581,
            x = 1,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47573,
            x = 3,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47574,
            x = 5,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47928,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47580,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47576,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47578,
            x = 3,
            y = 8,
        },
    },
})
-- Completed, Horde Only, no requirements, no breadcrumbs (starts in an odd place)
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN6, {
    name = {
        type = "npc",
        id = 135400,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 50818,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50817,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                795400, 811800, 828200, 844600, 861000, 877400, 893800, 910200, 926600, 943000, 959400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                55100, 55600, 56050, 56500, 56950, 57450, 57950, 58450, 58800, 59300, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 375,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 282498,
            -- name = "Go to the Desert Flute",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.289776, 0.546546, "Desert Flute")
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
            id = 50818,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50817,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50979,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50980,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN11,
            relationship = {
                breadcrumb = 50834,
                blockers = {50771, 52129, 50775},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, Horde Only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN7, {
    name = BtWQuests_GetAreaName(9776), -- Forward Camp
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 50656,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49333,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49335,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 50656,
        },
        {
            type = "quest",
            id = 49333,
        },
        {
            type = "quest",
            id = 49335,
        },
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
                49350, 49800, 50250, 50550, 51000, 51450, 51900, 52350, 52650, 53100, 
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
            id = 2158,
            amount = 225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 134611,
            -- name = "Go to Seriah",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.326805, 0.484359, "Seriah")
            -- end,
            -- breadcrumb = true,
            x = 1,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 128691,
            -- name = "Go to Izarn",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.323130, 0.483848, "Izarn")
            -- end,
            -- breadcrumb = true,
            x = 4,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 50656,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 49333,
            x = 3,
            y = 1,
        },
        {
            type = "quest",
            id = 49335,
            x = 5,
            y = 1,
        },
    },
})
-- Completed, Horde Only, requirement is part way through Storming the Spires, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN8, {
    name = { -- Free Ride
        type = "quest",
        id = 50749,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS,
        },
        {
            type = "quest",
            id = 49665,
        },
        {
            type = "quest",
            id = 49666,
        },
    },
    active = {
        {
            type = "quest",
            id = 49668,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50749,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                873000, 891000, 909000, 927000, 945000, 963000, 981000, 999000, 1017000, 1035000, 1053000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                61700, 62250, 62750, 63250, 63750, 64350, 64850, 65400, 65850, 66400, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 310,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_STORMING_THE_SPIRE,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49668,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49669,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50757,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50749,
            x = 3,
            y = 3,
        },
    },
})
--  Completed, Horde Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN9, {
    name = { -- Meet the Goldtusk Gang
        type = "quest",
        id = 47497,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 48327,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 47497,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48322,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2851800, 2910600, 2969400, 3028200, 3087000, 3145800, 3204600, 3263400, 3322200, 3381000, 3439800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                192550, 194200, 195750, 197350, 198900, 200750, 202400, 204050, 205450, 207100, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 215,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 1255,
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
                    id = 48327,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 122723,
                    -- name = "Go to Rhan'ka",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(864, 0.435079, 0.602125, "Rhan'ka")
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
            id = 287442,
            -- name = "Go to the Wanted Poster",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.436483, 0.599516, "Wanted Poster")
            -- end,
            -- breadcrumb = true,
            x = 5,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47497,
            x = 3,
            y = 1,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 51164,
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 47498,
            x = 2,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 47501,
            x = 4,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 47502,
            x = 1,
            y = 3,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 51717,
            x = 3,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47503,
            x = 5,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 51718,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50328,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47638,
            x = 3,
            y = 6,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 48321,
            x = 1,
            y = 7,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47564,
            x = 3,
            y = 7,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48320,
            x = 5,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48322,
            x = 3,
            y = 8,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN10,
            relationship = {
                breadcrumb = 48840,
                blockers = {48332, 49001, 48334},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 3,
            y = 9,
        },
    },
})
-- Completed, Horde Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN10, {
    name = { -- Zandalari Treasure Trove
        type = "quest",
        id = 48330,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 48840,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48332,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49001,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48334,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48330,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2134000, 2178000, 2222000, 2266000, 2310000, 2354000, 2398000, 2442000, 2486000, 2530000, 2574000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                119250, 120350, 121400, 122200, 123250, 124350, 125400, 126500, 127250, 128350, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 600,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 129451,
            -- name = "Go to Omi",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.453642, 0.461572, "Omi")
            -- end,
            -- breadcrumb = true,
            x = 1,
            y = 0,
            connections = {
                3,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 48840,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 129453,
                    -- name = "Go to Kenzou",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(864, 0.453918, 0.461864, "Kenzou")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 3,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "npc",
            id = 129450,
            -- name = "Go to Tacha",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.453890, 0.461530, "Tacha")
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
            id = 48332,
            x = 1,
            y = 1,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 49001,
            x = 3,
            y = 1,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48334,
            x = 5,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },


        {
            type = "quest",
            id = 49139,
            x = 1,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48335,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48331,
            x = 5,
            y = 2,
            connections = {
                1,
            },
        },


        {
            type = "quest",
            id = 48330,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, Horde Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN11, {
    name = { -- Awakened Elements
        type = "quest",
        id = 50812,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 50834,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50771,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 52129,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50775,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50812,
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
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 50834,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 135179,
                    -- name = "Go to Merd Archfeld",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(864, 0.262000, 0.736451, "Merd Archfeld")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 3,
            y = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50771,
            x = 1,
            y = 1,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 52129,
            x = 3,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50775,
            x = 5,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51991,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50812,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, only horde, requires part way through BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN12, {
    name = { -- Power of the Overseer
        type = "quest",
        id = 50535,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
        {
            type = "quest",
            id = 50770,
        },
    },
    active = {
        {
            type = "quest",
            id = 50536,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50535,
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
            id = 2158,
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
            id = 134148,
            -- name = "Go to Maaz",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.473185, 0.727297, "Maaz")
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
            id = 50536,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50596,
            aside = true,
            x = 0,
            y = 2,
        },
        {
            type = "quest",
            id = 48871,
            x = 2,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48872,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50535,
            x = 3,
            y = 3,
        },
    },
})
-- Horde Only, Unknown requirements (probably [Crater Conquered] in storming the spire), no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN13, {
    name = { -- Beaten But Not Broken
        type = "quest",
        id = 48329,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 48329,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48329,
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
                16450, 16600, 16750, 16850, 17000, 17150, 17300, 17450, 17550, 17700, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2158,
            amount = 75,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 130603,
            -- name = "Kill Beastbreaker Hakid",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.480841, 0.394916, "Beastbreaker Hakid")
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
            id = 48329,
            x = 3,
            y = 1,
        },
    },
})
-- Alliance Only, not sure the requirements exactly, merged with BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_BLOOD_ON_THE_SAND
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN14, {
    name = { -- Curse of Jani
        type = "quest",
        id = 51145,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 51142,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51145,
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
            type = "npc",
            id = 136562,
            -- name = "Go to Quartermaster Alfin",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.365715, 0.323048, "Quartermaster Alfin")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51142,
            x = 0,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51145,
            x = 0,
            y = 2,
        },
    },
})
-- Completed, available for both factions, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN15, {
    name = BtWQuests_GetAreaName(8964), -- Redrock Harbor
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 49261,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49262,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 49261,
        },
        {
            type = "quest",
            id = 49262,
        },
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
    },
    items = {
        {
            name = L["COLLECT_AN_ASHVANE_DISGUISE"],
            visible = {
                type = "quest",
                ids = {49261, 49262},
                status = {'notcompleted'}
            },
            -- visible = function ()
            --     if BtWQuests_IsQuestActive(49262) then
            --         return true
            --     end

            --     if not BtWQuests_IsQuestCompleted(49261) or not BtWQuests_IsQuestCompleted(49262) then
            --         return true
            --     end

            --     return false
            -- end,
            active = {
                type = "item",
                id = 160735,
            },
            -- active = function ()
            --     return GetItemCount(160735) > 0
            -- end,
            completed = {
                type = "aura",
                id = 266248,
            },
            -- completed = function ()
            --     local index = 1
            --     local spellID = select(10, UnitAura("player", index, "PLAYER|HELPFUL"))
            --     while spellID do
            --         if spellID == 266248 then
            --             return true
            --         end

            --         index = index + 1
            --         spellID = select(10, UnitAura("player", index, "PLAYER|HELPFUL"))
            --     end

            --     return false
            -- end,
            x = 3,
            y = 0,
        },
        {
            type = "npc",
            id = 128618,
            -- name = "Go to Dockmaster Herrington",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(864, 0.445974, 0.882277, "Dockmaster Herrington")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49261,
            x = 2,
            y = 2,
        },
        {
            type = "quest",
            id = 49262,
            x = 4,
            y = 2,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_OTHER_ALLIANCE, {
    name = "Other Alliance",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
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
            id = 50603,
        }, 
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_OTHER_HORDE, {
    name = "Other Horde",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- Emmissary World Quests
            type = "quest",
            id = 50603,
        },
        {
            type = "quest",
            id = 49731,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_OTHER_BOTH, {
    name = "Other Both",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- Part of get get Hek'd, requries the first part with Jani and the butt biting to unlock
            type = "quest",
            id = 50901,
        },
        { -- Kill horde players, gives conquest points, so pvp quest, maybe war mode world quest?
            type = "quest",
            id = 52953,
        },
        { -- Kill horde players, gives conquest points, so pvp quest, maybe war mode world quest?
            type = "quest",
            id = 52950,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    buttonImage = 2178273,
    listImage = {
        texture = "Interface\\Addons\\BtWQuestsBattleForAzeroth\\UI-CategoryButton",
        texCoords = {0, 0.7353515625, 0.703125, 0.8203125},
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_VOLDUN_FOOTHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_BLOOD_ON_THE_SAND,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_UNLIKELY_ALLIES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_DANGERS_IN_THE_DESERT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_WARGUARDS_FATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_A_CITY_OF_SECRETS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_THE_THREE_KEEPERS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_STORMING_THE_SPIRE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_ATULAMAN,
        },


        {
            type = "header",
            name = L["BTWQUESTS_SIDE_QUESTS"],
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN2,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN4,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN5,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN6,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN7,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN9,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN11,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN13,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN15,
        },


        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_OTHER_HORDE,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_OTHER_BOTH,
        -- },
    },
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
})

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN1,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN2,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN3,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN4,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN5,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN6,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN7,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN8,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN9,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN10,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN11,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN12,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN13,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_VOLDUN_CHAIN15,
    },
})