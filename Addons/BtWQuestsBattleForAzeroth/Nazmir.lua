local L = BtWQuests.L;
local MAP_ID = 863
local ACHIEVEMENT_ID = 11868
local CONTINENT_ID = 875

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 1)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
        type = "quest",
        id = 47512,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 47188,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                950600, 970200, 989800, 1009400, 1029000, 1048600, 1068200, 1087800, 1107400, 1127000, 1146600, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                80650, 81300, 81950, 82650, 83300, 84000, 84850, 85500, 86000, 86650, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 515,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 47512,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47103,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48535,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47105,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47130,
            x = 2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47264,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47262,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47263,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47188,
            x = 3,
            y = 7,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
            aside = true,
            x = 2,
            y = 8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN2,
            aside = true,
            x = 4,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 2)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
    },
    completed = {
        type = "quest",
        id = 47250,
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
                163700, 165150, 166550, 167750, 169150, 170650, 172150, 173600, 174650, 176100, 
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
            id = 2156,
            amount = 1150,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47868,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47880,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4, 5, 6,
            },
        },
        {
            type = "quest",
            id = 47248,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 48934,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 47247,
            x = 0,
            y = 4,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 47491,
            x = 2,
            y = 4,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49348,
            x = 4,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49432,
            x = 6,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47249,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47250,
            x = 3,
            y = 6,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 3)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
    },
    completed = {
        type = "quest",
        id = 49082,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2153400, 2197800, 2242200, 2286600, 2331000, 2375400, 2419800, 2464200, 2508600, 2553000, 2597400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                158000, 159350, 160700, 161850, 163200, 164700, 166100, 167450, 168550, 169900, 
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
            id = 2156,
            amount = 1225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49440,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48699,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48890,
            x = 2,
            y = 3,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48801,
            x = 4,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49078,
            x = 2,
            y = 4,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48800,
            x = 4,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49406,
            x = 6,
            y = 4,
        },
        {
            type = "quest",
            id = 49079,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49081,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49082,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN3,
            aside = true,
            x = 3,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 4)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
    },
    completed = {
        type = "quest",
        id = 49160,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3298000, 3366000, 3434000, 3502000, 3570000, 3638000, 3706000, 3774000, 3842000, 3910000, 3978000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                230400, 232350, 234300, 236050, 238000, 240100, 242300, 244250, 245750, 247700, 
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
            id = 2156,
            amount = 800,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
        {
            type = "reputation",
            id = 2163,
            amount = 3150,
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
            x = 2,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
            x = 4,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49185,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49064,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN6,
            aside = true,
            x = 5,
            y = 2,
        },
        {
            type = "quest",
            id = 49067,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49070,
            x = 1,
            y = 4,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49071,
            x = 3,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49080,
            x = 5,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49120,
            x = 3,
            y = 5,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49125,
            x = 3,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51689,
            aside = true,
            x = 5,
            y = 6,
        },
        {
            type = "quest",
            id = 49126,
            x = 3,
            y = 7,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49130,
            x = 1,
            y = 8,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49131,
            x = 3,
            y = 8,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49132,
            x = 5,
            y = 8,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49136,
            x = 3,
            y = 9,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49160,
            x = 3,
            y = 10,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49902,
            aside = true,
            x = 3,
            y = 11,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
            aside = true,
            x = 2,
            y = 12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
            aside = true,
            x = 4,
            y = 12,
        },
        {
            type = "quest",
            id = 52477,
            x = 6,
            y = 12,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 5)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
    },
    completed = {
        type = "quest",
        id = 47696,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1804200, 1841400, 1878600, 1915800, 1953000, 1990200, 2027400, 2064600, 2101800, 2139000, 2176200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                128350, 129450, 130450, 131600, 132600, 133800, 134950, 136050, 136950, 138050, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 720,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49902,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47525,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 47659,
            x = 2,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47660,
            x = 4,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48402,
            aside = true,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 47623,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47621,
            x = 2,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47622,
            x = 4,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47540,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47696,
            x = 3,
            y = 7,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN9,
            relationship = {
                breadcrumb = 47918,
                blockers = {48090, 48092, 48334},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 2,
            y = 8,
        },
        {
            type = "quest",
            id = 47697,
            aside = true,
            x = 4,
            y = 8,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED,
            aside = true,
            active = {
                type = "quest",
                id = 47697,
            },
            x = 3,
            y = 9,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN7,
            aside = true,
            active = {
                type = "quest",
                id = 47697,
            },
            x = 5,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 6)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
        },
    },
    completed = {
        type = "quest",
        id = 49985,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2910000, 2970000, 3030000, 3090000, 3150000, 3210000, 3270000, 3330000, 3390000, 3450000, 3510000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                197450, 199200, 200850, 202350, 204000, 205900, 207550, 209300, 210700, 212450, 
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
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 495,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
            x = 2,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
            x = 4,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49932,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49935,
            x = 1,
            y = 2,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 49937,
            x = 3,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49938,
            x = 5,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49941,
            x = 1,
            y = 3,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 49949,
            x = 3,
            y = 3,
            connections = {
                2, 3, 4
            },
        },
        {
            type = "quest",
            id = 49950,
            x = 5,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49955,
            x = 1,
            y = 4,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49956,
            x = 3,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49957,
            x = 5,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49980,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49985,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BLEEDING_THE_BLOOD_TROLLS,
            aside = true,
            x = 3,
            y = 7,
        }
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 7)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
    },
    completed = {
        type = "quest",
        id = 47601,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2095200, 2138400, 2181600, 2224800, 2268000, 2311200, 2354400, 2397600, 2440800, 2484000, 2527200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                153000, 154350, 155600, 156850, 158100, 159500, 160900, 162250, 163250, 164600, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49902,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47245,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47631,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 47597,
            x = 2,
            y = 4,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 47599,
            x = 4,
            y = 4,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 47756,
            aside = true,
            x = 6,
            y = 4,
        },
        {
            type = "quest",
            id = 47596,
            x = 1,
            y = 5,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 47711,
            x = 3,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47598,
            x = 5,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47601,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47602,
            aside = true,
            x = 3,
            y = 7,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED,
            aside = true,
            active = {
                type = "quest",
                id = 47602,
            },
            x = 3,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BLEEDING_THE_BLOOD_TROLLS, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 8)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
        },
    },
    completed = {
        type = "quest",
        id = 50087,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2871200, 2930400, 2989600, 3048800, 3108000, 3167200, 3226400, 3285600, 3344800, 3404000, 3463200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                239400, 241500, 243400, 245450, 247350, 249550, 251750, 253700, 255550, 257500, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 800,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 1525,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED,
            x = 2,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
            x = 4,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49569,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50076,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50138,
            x = 2,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 50078,
            x = 4,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50079,
            x = 2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50081,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50082,
            x = 3,
            y = 5,
            connections = {
                1,  2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN8,
            aside = true,
            x = 1,
            y = 6,
        },
        {
            type = "quest",
            id = 52073,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50087,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51244,
            aside = true,
            x = 3,
            y = 8,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 51302,
            aside = true,
            x = 2,
            y = 9,
        },
        {
            type = "quest",
            id = 50808,
            aside = true,
            x = 4,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1, {
    name = { -- The Shadow of Death
        type = "quest",
        id = 47241,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
    },
    active = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
    },
    completed = {
        type = "quest",
        id = 49278,
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
                69950, 70550, 71100, 71700, 72250, 72950, 73500, 74100, 74650, 75250, 
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
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47241,
            x = 3,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51089,
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 47244,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49278,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
            aside = true,
            x = 2,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
            aside = true,
            x = 4,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
            aside = true,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, Horde only, requires BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN2, {
    name = { -- Urok, Terror of the Wetlands
        type = "quest",
        id = 48669,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
    },
    active = {
        type = "quest",
        id = 48669,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 48591,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2347400, 2395800, 2444200, 2492600, 2541000, 2589400, 2637800, 2686200, 2734600, 2783000, 2831400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                174350, 175950, 177450, 178700, 180200, 181800, 183350, 184950, 186050, 187650, 
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
            id = 2156,
            amount = 1200,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48669,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48573,
            x = 2,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48574,
            x = 4,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },

        
        {
            type = "quest",
            id = 48576,
            x = 1,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48577,
            x = 3,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 48578,
            x = 5,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },

        
        {
            type = "quest",
            id = 48584,
            x = 2,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48590,
            x = 4,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48588,
            aside = true,
            x = 6,
            y = 4,
        },
        {
            type = "quest",
            id = 48591,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, horde only, requires BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN3, {
    name = { -- Stopping Zardrax
        type = "quest",
        id = 48852,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
    },
    active = {
        type = "quest",
        id = 49314,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 48869,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2153400, 2197800, 2242200, 2286600, 2331000, 2375400, 2419800, 2464200, 2508600, 2553000, 2597400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                147200, 148550, 149750, 150950, 152150, 153500, 154800, 156150, 157100, 158450, 
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
            id = 2156,
            amount = 675,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49314,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48854,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN4,
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 48823,
            x = 2,
            y = 3,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 48825,
            x = 4,
            y = 3,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48852,
            x = 6,
            y = 3,
        },
        
        {
            type = "quest",
            id = 48855,
            x = 1,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48856,
            x = 3,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48857,
            x = 5,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48869,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, Horde only, requires part way through BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN3, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN4, {
    name = { -- Catch Me if You Can
        type = "quest",
        id = 49781,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "quest",
            id = 48854,
        },
    },
    active = {
        type = "quest",
        id = 50933,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 49777,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1474400, 1504800, 1535200, 1565600, 1596000, 1626400, 1656800, 1687200, 1717600, 1748000, 1778400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                112700, 113700, 114650, 115500, 116450, 117500, 118500, 119500, 120250, 121250, 
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
            amount = 535,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN3,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50933,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49777,
            x = 1,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49774,
            x = 3,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49776,
            x = 5,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49778,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49779,
            x = 2,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49780,
            x = 4,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49781,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, both factions, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN5, {
    name = { -- The Fall of Kel'vax
        type = "quest",
        id = 48480,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = 48468,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48473,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48480,
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
            type = "reputation",
            id = 2156,
            amount = 700,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 130481,
            -- name = "Go to Shinga Deathwalker",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(863, 0.390648, 0.606691, "Shinga Deathwalker")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48468,
            x = 2,
            y = 1,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 48473,
            x = 4,
            y = 1,
            connections = {
                1, 2,
            },
        },

        
        {
            type = "quest",
            id = 48478,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48479,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48480,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, both factions, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN6, {
    name = { -- Shoak's on the Menu
        type = "quest",
        id = 47925,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 47924,
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 47998,
        },
        {
            type = "quest",
            id = 47919,
        },
        {
            type = "quest",
            id = 47925,
        },
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
                102800, 103750, 104650, 105350, 106250, 107200, 108100, 109050, 109700, 110650, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2163,
            amount = 375,
        },
    },
    items = {
        {
            type = "npc",
            id = 124666,
            -- name = "Go to Kajosh",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(863, 0.551530, 0.367119, "Kajosh")
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
            id = 47924,
            x = 3,
            y = 1,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 47996,
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE,
            },
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 47998,
            x = 1,
            y = 2,
        },
        {
            type = "quest",
            id = 47919,
            x = 3,
            y = 2,
        },
        {
            type = "quest",
            id = 47925,
            x = 5,
            y = 2,
        },
    },
})
-- Completed, Horde only, requries A friend of the frogs, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN7, {
    name = { -- It Seems You've Made a Friend
        type = "quest",
        id = 49382,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
        },
    },
    active = {
        type = "quest",
        id = 50934,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 49382,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1377400, 1405800, 1434200, 1462600, 1491000, 1519400, 1547800, 1576200, 1604600, 1633000, 1661400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                104500, 105400, 106250, 107100, 107950, 108950, 109850, 110750, 111500, 112400, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 650,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50934,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49366,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49380,
            x = 1,
            y = 3,
            connections = {
            },
        },
        -- {
        --     type = "quest",
        --     id = 49376,
        --     x = 3,
        --     y = 1,
        --     connections = {
        --         1, 
        --     },
        -- },
        {
            type = "quest",
            id = 49370,
            x = 3,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 49377,
            x = 5,
            y = 3,
            connections = {
            },
        },

        
        {
            type = "quest",
            id = 49378,
            x = 2,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49379,
            x = 4,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49382,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, Horde only, requires part way through BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BLEEDING_THE_BLOOD_TROLLS, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN8, {
    name =  { -- The Crawg Ma'da
        type = "quest",
        id = 50083,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
        },
        {
            type = "quest",
            id = 50082,
        },
    },
    active = {
        type = "quest",
        id = 50083,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 50085,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                970000, 990000, 1010000, 1030000, 1050000, 1070000, 1090000, 1110000, 1130000, 1150000, 1170000, 
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
            id = 2156,
            amount = 225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BLEEDING_THE_BLOOD_TROLLS,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50083,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50085,
            x = 3,
            y = 2,
        },
        {
            type = "quest",
            id = 50080,
            aside = true,
            restrictions = {
                type = "level",
                level = 119,
                atmost = true,
            },
            -- restrictions = function(item, character)
            --     return character:GetLevel() < 120
            -- end,
            x = 5,
            y = 2,
        },
    },
})
-- Completed, Horde Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN9, {
    name = { -- Vengeance of the Frogs
        type = "quest",
        id = 48092,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = 47918,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48090,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48092,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 48090,
        },
        {
            type = "quest",
            id = 48092,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                970000, 990000, 1010000, 1030000, 1050000, 1070000, 1090000, 1110000, 1130000, 1150000, 1170000, 
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
            type = "currency",
            id = 1553,
            amount = 100,
        },
        {
            type = "reputation",
            id = 2156,
            amount = 400,
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
                    id = 47918,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 125317,
                    -- name = "Go to Shadow Hunter Narez",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(863, 0.777447, 0.531751, "Shadow Hunter Narez")
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
            id = 48090,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 48092,
            x = 3,
            y = 1,
        },
        {
            type = "quest",
            id = 48093,
            aside = true,
            x = 5,
            y = 1,
        },
    },
})
-- Completed, Horde only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN10, {
    name = { -- Reuniting the Company
        type = "quest",
        id = 48496,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
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
            id = 49477,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 48492,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 48499,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                814800, 831600, 848400, 865200, 882000, 898800, 915600, 932400, 949200, 966000, 982800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                69100, 69700, 70300, 70800, 71400, 72000, 72700, 73300, 73700, 74300, 
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
            id = 2157,
            amount = 325,
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
                    id = 49477,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 126289,
                    -- name = "Go to Chadwick Paxton",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(863, 0.286269, 0.437555, "Chadwick Paxton")
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
            id = 48492,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 48497,
            x = 1,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48496,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48498,
            x = 5,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49479,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48499,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, both factions, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN11, {
    name = { -- An Ancient Curse
        type = "quest",
        id = 50976,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 50976,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 50976,
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
                20550, 20750, 20900, 21100, 21250, 21450, 21600, 21800, 21950, 22150, 
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
            id = 2156,
            amount = 250,
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
            type = "object",
            id = 287081,
            -- name = "Go to Ancient Tablet",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(863, 0.528920, 0.759925, "Ancient Tablet")
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
            id = 50976,
            x = 3,
            y = 1,
        },
    },
})
-- Alliance only, unknown requirements, part of BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_CHASING_DARKNESS
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN12, {
    name = { -- WANTED: Ayame
        type = "quest",
        id = 52480,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 52480,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 52480,
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
                24700, 24900, 25100, 25300, 25500, 25750, 25950, 26150, 26350, 26550, 
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
            amount = 250,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
        {
            type = "reputation",
            id = 2163,
            amount = 250,
        },
    },
    items = {
        {
            type = "object",
            id = 293568,

            -- name = "Go to the Wanted Poster",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(863, 0.0623950, 0.0413126, "Wanted Poster")
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
            id = 52480,
            x = 0,
            y = 1,
        },
    },
})
-- Alliance only, unknown requirements, part of BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_CHASING_DARKNESS
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN13, {
    name = { -- WANTED: Tojek
        type = "quest",
        id = 51139,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 51139,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 51139,
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
                24700, 24900, 25100, 25300, 25500, 25750, 25950, 26150, 26350, 26550, 
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
            amount = 250,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 287327,
            -- name = "Go to the Scouting Report",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(863, 0.621462, 0.410255, "Scouting Report")
            -- end,
            -- breadcrumb = true,
            -- aside = true,
            x = 0,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51139,
            x = 0,
            y = 1,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_OTHER_ALLIANCE, {
    name = "Other Alliance",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_OTHER_HORDE, {
    name = "Other Horde",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- Seems to be another version of 47660
            type = "quest",
            id = 52294,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_OTHER_BOTH, {
    name = "Other Both",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- http://bfa.wowhead.com/achievement=12482/get-hekd
            type = "quest",
            id = 50444,
        },
        { -- LARRY TEST QUEST
            type = "quest",
            id = 49375,
        },
        {
            type = "quest",
            id = 52954,
        },
        {
            type = "quest",
            id = 52949,
        },
        { -- Emissary
            type = "quest",
            id = 50602,
        },
        {
            type = "quest",
            id = 48905,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    buttonImage = 2178275,
    listImage = {
        texture = "Interface\\Addons\\BtWQuestsBattleForAzeroth\\UI-CategoryButton",
        texCoords = {0, 0.7353515625, 0.5859375, 0.703125},
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_NAZMIR_FOOTHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_CHASING_DARKNESS,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_DEEP_IN_THE_SWAMP,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_PACT_WITH_DEATH,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_UNDERCOVER_SISTA,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_TURTLE_POWER,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_A_FRIEND_OF_THE_FROGS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_EVERYTHING_CONTAINED,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BRING_THE_BOOM,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_BLEEDING_THE_BLOOD_TROLLS,
        },

        
        {
            type = "header",
            name = L["BTWQUESTS_SIDE_QUESTS"],
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN2,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN4,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN5,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN6,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN7,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN9,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN11,
        },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_OTHER_ALLIANCE,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_OTHER_BOTH,
        -- },
    },
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
})

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN2,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN3,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN4,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN5,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN6,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN7,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN8,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN9,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN10,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_NAZMIR_CHAIN11,
    },
})