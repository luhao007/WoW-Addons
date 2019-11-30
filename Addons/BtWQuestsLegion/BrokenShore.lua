local L = BtWQuests.L;
local MAP_ID = 646

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB, {
    name = BtWQuests_GetAchievementNameDelayed(11546),
    category = BTWQUESTS_CATEGORY_LEGION_BROKENSHORE,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "level",
            level = 110,
        },
    },
    completed = {
        type = "quest",
        id = 46246,
    },
    major = true,
    range = {110},
    items = {
        {
            type = "quest",
            id = 46730,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46734,
            x = 3,
            y = 1,
            connections = {
                1, 4, 7
            },
        },


        {
            type = "quest",
            id = 46832,
            x = 1,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46845,
            x = 1,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_TREASURE_MASTER_IKSREEGED,
            aside = true,
            x = 1,
            y = 4,
        },


        {
            type = "quest",
            id = 46286,
            x = 5,
            y = 2,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 46245,
            x = 5,
            y = 3,
        },
        {
            type = "quest",
            id = 46247,
            x = 5,
            y = 1,
        },


        {
            type = "quest",
            id = 47137,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },


        {
            variations = {
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_FOLLOWER_ALLIANCE,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_FOLLOWER_HORDE,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_FOLLOWER,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_FOLLOWER_ALLIANCE,
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_FOLLOWER_HORDE,
                },
            },
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },


        {
            type = "quest",
            id = 46251,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 47139,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46248,
            x = 3,
            y = 6,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46252,
            x = 3,
            y = 7,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46769,
            x = 3,
            y = 8,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46250,
            x = 3,
            y = 9,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46249,
            x = 3,
            y = 10,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46246,
            x = 3,
            y = 11,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_BROKENSHORE_TREASURE_MASTER_IKSREEGED, {
    name = { -- Treasure Master Iks'reeged
		type = "quest",
		id = 45379,
	},
    category = BTWQUESTS_CATEGORY_LEGION_BROKENSHORE,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "quest",
            id = 46845,
        },
    },
    completed = {
        type = "quest",
        id = 46666,
    },
    range = {110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB,
            breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46499,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46501,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46509,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46510,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46511,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46666,
            x = 3,
            y = 6,
        },
        {
            type = "quest",
            id = 45379,
            aside = true,
            x = 3,
            y = 7,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_BROKENSHORE_A_FOUND_MEMENTO, {
    name = { -- A Found Memento
		type = "quest",
		id = 46268,
	},
    category = BTWQUESTS_CATEGORY_LEGION_BROKENSHORE,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "quest",
            id = 46734,
        },
    },
    completed = {
        type = "quest",
        id = 46282,
    },
    range = {110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB,
            breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46268,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            name = "Wait for daily reset",
            breadcrumb = true,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46272,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46274,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46275,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46282,
            x = 3,
            y = 6,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_LEGION_BROKENSHORE, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_LEGION,
    buttonImage = 1616106,
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_TREASURE_MASTER_IKSREEGED,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_A_FOUND_MEMENTO,
        },
    },
})

BtWQuestsDatabase:AddExpansionItem(BTWQUESTS_EXPANSION_LEGION, {
    type = "category",
    id = BTWQUESTS_CATEGORY_LEGION_BROKENSHORE,
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_LEGION_BROKENSHORE,
})

BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB)
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_BROKENSHORE_TREASURE_MASTER_IKSREEGED)
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_BROKENSHORE_A_FOUND_MEMENTO)