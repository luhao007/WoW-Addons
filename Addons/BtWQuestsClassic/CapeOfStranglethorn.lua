local MAP_ID = 210

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_ZULGURUB, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(4905, 1),
    category = BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN,
    expansion = BTWQUESTS_EXPANSION_CLASSIC,
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "level",
            level = 30,
        },
    },
    completed = {
        type = "quest",
        id = 26814,
    },
    range = {30,60},
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 28702,
                    restrictions = {
                        {
                            type = "quest",
                            id = 28702,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 28702,
                    restrictions = {
                        {
                            type = "quest",
                            id = 28702,
                            active = true,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 26805,
                    restrictions = {
                        {
                            type = "quest",
                            id = 26805,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 26805,
                    restrictions = {
                        {
                            type = "quest",
                            id = 26805,
                            active = true,
                        },
                    },
                },
                {
                    type = "npc",
                    id = 44082,                
                    -- name = "Go to Bronwyn Hewstrike",
                    -- breadcrumb = true,
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.5524, 0.4248, "Bronwyn Hewstrike")
                    -- end,
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
            id = 26825,
            x = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26823,
            x = 3,
            connections = {
                2, 3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 26822,
            x = 5,
        },
        {
            type = "quest",
            id = 26818,
            x = 0,
        },
        {
            type = "quest",
            id = 26817,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26819,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26820,
        },
        {
            type = "quest",
            id = 26815,
            x = 1,
            connections = {
                2, 3
            },
        },
        {
            type = "quest",
            id = 26808,
            x = 5,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26816,
            x = 0,
        },
        {
            type = "quest",
            id = 26824,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26809,
            x = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26821,
            x = 2,
        },
        {
            type = "quest",
            id = 26810,
            x = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26811,
            x = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26812,
            x = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26813,
            x = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26814,
            x = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_PIRATES, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(4905, 3),
    category = BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN,
    expansion = BTWQUESTS_EXPANSION_CLASSIC,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 30,
        },
        {
            type = "quest",
            id = 26612,
        },
    },
    completed = {
        type = "quest",
        id = 26665,
    },
    range = {25,60},
    items = {
        {
            name = {
                type = "quest",
                id = 26612,
            },
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BOOTY_BAY,
            userdata = {
                scrollTo = {
                    type = "quest",
                    id = 26612,
                }
            },
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26624,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26629,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26631,
            x = 3,
            y = 4,
            connections = {
                1,
                2,
                3,
            },
        },
        {
            type = "quest",
            id = 26635,
            x = 1,
            y = 5,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26633,
            x = 3,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26634,
            x = 5,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26644,
            x = 3,
            y = 6,
            connections = {
                1,
                2,
            },
        },
        {
            type = "quest",
            id = 26648,
            aside = true,
            x = 1,
            y = 7,
        },
        {
            type = "quest",
            id = 26647,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26649,
            x = 3,
            y = 8,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26650,
            x = 3,
            y = 9,
            connections = {
                1,
                2,
                3,
            },
        },
        {
            type = "quest",
            id = 26662,
            x = 1,
            y = 10,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26663,
            x = 3,
            y = 10,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26664,
            x = 5,
            y = 10,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26665,
            x = 3,
            y = 11,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BLOODSAIL,
            x = 3,
            y = 12,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BOOTY_BAY, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(4905, 2),
    category = BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN,
    expansion = BTWQUESTS_EXPANSION_CLASSIC,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 30,
        },
    },
    completed = {
        type = "quest",
        id = 26613,
    },
    range = {30,60},
    items = {
        {
            type = "object",
            id = 204406,
            -- name = "Find a Half-Buried Bottle along the coast",
            -- breadcrumb = true,
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.5024, 0.7602, "Half-Buried Bottle")
            -- end,
            x = 0,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 2501,
            -- name = "Go to \"Sea Wolf\" MacKinley",
            -- breadcrumb = true,
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.4208, 0.7338, "\"Sea Wolf\" MacKinley")
            -- end,
            x = 2,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 2500,
            -- name = "Go to Captain Hecklebury Smotts",
            -- breadcrumb = true,
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.4032, 0.6779, "Captain Hecklebury Smotts")
            -- end,
            x = 4,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 2486,
            -- name = "Go to Fin Fizracket",
            -- breadcrumb = true,
            aside = true,
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.4180, 0.7283, "Fin Fizracket")
            -- end,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 26603,
            x = 0,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 26593,
            x = 2,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 26599,
            x = 4,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 26597,
            aside = true,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 26604,
            x = 0,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26594,
            x = 2,
            y = 2,
            connections = {
                5,
            },
        },
        {
            type = "quest",
            id = 26600,
            x = 4,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26605,
            x = 0,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26602,
            x = 4,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26606,
            x = 0,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26595,
            x = 2,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26601,
            x = 4,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26609,
            x = 2,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26610,
            x = 2,
            y = 6,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26617,
            aside = true,
            x = 4,
            y = 6,
        },
        {
            type = "quest",
            id = 26611,
            x = 2,
            y = 7,
            connections = {
                1,
                2,
                3,
            },
        },
        {
            type = "quest",
            id = 26614,
            aside = true,
            x = 0,
            y = 8,
        },
        {
            type = "quest",
            id = 26612,
            aside = true,
            x = 2,
            y = 8,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26613,
            x = 4,
            y = 8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_PIRATES,
            aside = true,
            x = 2,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BLOODSAIL, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(4905, 4),
    category = BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN,
    expansion = BTWQUESTS_EXPANSION_CLASSIC,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 30,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BOOTY_BAY
        },
    },
    completed = {
        type = "quest",
        id = 26703,
    },
    range = {30,60},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_PIRATES,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26678,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26679,
            x = 3,
            y = 2,
            connections = {
                1,
                2,
            },
        },
        {
            type = "quest",
            id = 26695,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26698,
            x = 4,
            y = 3,
            connections = {
                2,
                3,
            },
        },
        {
            type = "quest",
            id = 26697,
            x = 1,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 26700,
            x = 3,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 26699,
            x = 5,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 26703,
            x = 3,
            y = 5,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_CLASSIC,
	buttonImage = {
		texture = 1851096,
		texCoords = {0,1,0,1},
	},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_ZULGURUB,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BOOTY_BAY,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_PIRATES,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_CLASSIC_CAPE_OF_STRANGLETHORN_BLOODSAIL,
        },
    },
})

BtWQuestsDatabase:AddExpansionItem(BTWQUESTS_EXPANSION_CLASSIC, {
    type = "category",
    id = BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN,
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_CLASSIC_CAPE_OF_STRANGLETHORN,
})