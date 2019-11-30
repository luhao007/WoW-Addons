local L = BtWQuests.L;
local MAP_ID = 634
local CONTINENT_ID = 619

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_ALLIANCE, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 1),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    completed = {
        type = "quest",
        id = 39800,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "quest",
            id = 39735,
            visible = {
                {
                    type = "quest",
                    id = 39864,
                    active = false,
                }
            },
            x = 3,
            y = 0,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 44700,
            visible = {
                {
                    type = "quest",
                    id = 44700,
                    active = true,
                }
            },
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38035,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38206,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39800,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_ALLIANCE,
            aside = true,
            x = 3,
            y = 4,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_ALLIANCE, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 2),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_ALLIANCE,
        },
    },
    completed = {
        type = "quest",
        id = 38060,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_ALLIANCE,
            x = 3,
            y = 0,
            connections = {
                1, 2, 3, 4
            }
        },
        {
            type = "quest",
            id = 38036,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 38052,
            x = 2,
            y = 1,
            connections = {
                3, 4
            },
        },
        {
            type = "quest",
            id = 38053,
            x = 4,
            y = 1,
            connections = {
                2, 3
            },
        },
        {
            type = "quest",
            id = 38558,
            x = 6,
            y = 1,
            connections = {
                1, 2
            },
        },

        
        {
            type = "quest",
            id = 38057,
            aside = true,
            x = 2,
            y = 2,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 38058,
            x = 4,
            y = 2,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 38059,
            aside = true,
            x = 2,
            y = 3,
        },
        {
            type = "quest",
            id = 38060,
            x = 4,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_MIGHT,
            x = 3,
            y = 4,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_HORDE, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 1),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_HORDE,
        },
    },
    completed = {
        type = "quest",
        id = 39801,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "quest",
            id = 39864,
            visible = {
                {
                    type = "quest",
                    id = 44701,
                    active = false,
                }
            },
            x = 3,
            y = 0,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 44701,
            visible = {
                {
                    type = "quest",
                    id = 44701,
                    active = true,
                }
            },
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38307,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39698,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39801,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_HORDE,
            x = 3,
            y = 4,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_HORDE, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 2),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    restrictions = {
        {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_HORDE,
        },
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_HORDE,
        },
    },
    completed = {
        type = "quest",
        id = 38362,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_HORDE,
            x = 3,
            y = 0,
            connections = {
                1, 2, 3
            },
        },
        {
            type = "quest",
            id = 38357,
            aside = true,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 38332,
            x = 3,
            y = 1,
            connections = {
                2, 3
            },
        },
        {
            type = "quest",
            id = 38358,
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 38360,
            x = 2,
            y = 2,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 38361,
            x = 4,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38362,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_MIGHT,
            x = 3,
            y = 4,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_MIGHT, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 3),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_ALLIANCE,
            restrictions = {
                {
                    type = "faction",
                    id = BTWQUESTS_FACTION_ID_ALLIANCE,
                },
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_HORDE,
            restrictions = {
                {
                    type = "faction",
                    id = BTWQUESTS_FACTION_ID_HORDE,
                },
            },
        },
    },
    completed = {
        type = "quest",
        id = 39597,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_ALLIANCE,
            x = 3,
            y = 0,
            connections = {
                2
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_HORDE,
            x = 3,
            y = 0,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 38210,
            restrictions = {
                {
                    type = "faction",
                    id = BTWQUESTS_FACTION_ID_ALLIANCE,
                },
            },
            x = 3,
            y = 1,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 38459,
            restrictions = {
                {
                    type = "faction",
                    id = BTWQUESTS_FACTION_ID_HORDE,
                },
            },
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38331,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39590,
            x = 3,
            y = 3,
            connections = {
                3, 4, 5
            },
        },
        {
            name = L["BTWQUESTS_KILL_CHAMPIONS"],
            breadcrumb = true,
            aside = true,
            x = 1,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39595,
            aside = true,
            x = 1,
            y = 3,
        },


        {
            type = "quest",
            id = 39591,
            x = 1,
            y = 4,
            connections = {
                3
            },
        },
        {
            type = "quest",
            id = 39592,
            x = 3,
            y = 4,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 39593,
            x = 5,
            y = 4,
            connections = {
                1
            },
        },
        
        {
            type = "quest",
            id = 39594,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39597,
            x = 3,
            y = 6,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_WILL,
            x = 3,
            y = 7,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_WILL, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 4),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_MIGHT,
        },
    },
    completed = {
        type = "quest",
        id = 38624,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_MIGHT,
            x = 3,
            y = 0,
            connections = {
                1, 2
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38473,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38611,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38312,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38612,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 2,
            connections = {
                2, 3, 
            },
        },
        {
            name = L["BTWQUESTS_KILL_DRAGONS"],
            breadcrumb = true,
            aside = true,
            x = 1,
            y = 3,
            connections = {
                3
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38405,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38614,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38318,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38613,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            aside = true,
            x = 5,
            y = 3,
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38337,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38616,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            aside = true,
            x = 1,
            y = 4,
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38410,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38615,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38342,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38617,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 38412,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38618,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 6,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 38413,
            x = 1,
            y = 7,
            connections = {
                3
            },
        },
        {
            type = "quest",
            id = 38414,
            x = 3,
            y = 7,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 40568,
            x = 5,
            y = 7,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39652,
            x = 3,
            y = 8,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38624,
            x = 3,
            y = 9,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_VALOR,
            x = 3,
            y = 10,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_VALOR, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 5),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_WILL,
        },
    },
    completed = {
        type = "quest",
        id = 38818,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_WILL,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39803,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39804,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39796,
            x = 3,
            y = 3,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 38778,
            x = 2,
            y = 4,
            connections = {
                2, 3
            },
        },
        {
            type = "quest",
            id = 39788,
            x = 4,
            y = 4,
            connections = {
                1, 2
            },
        },

        
        {
            type = "quest",
            id = 38808,
            x = 2,
            y = 5,
            connections = {
                2, 3
            },
        },
        {
            type = "quest",
            id = 38810,
            x = 4,
            y = 5,
            connections = {
                1, 2
            },
        },

        
        {
            type = "quest",
            id = 38811,
            x = 2,
            y = 6,
            connections = {
                2, 3, 4
            },
        },
        {
            type = "quest",
            id = 39791,
            x = 4,
            y = 6,
            connections = {
                1, 2, 3
            },
        },


        {
            type = "quest",
            id = 38823,
            x = 1,
            y = 7,
            connections = {
                3
            },
        },
        {
            type = "quest",
            id = 38817,
            x = 3,
            y = 7,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 38816,
            x = 5,
            y = 7,
            connections = {
                1
            },
        },
        
        {
            type = "quest",
            id = 38815,
            x = 3,
            y = 8,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38818,
            x = 3,
            y = 9,
            connections = {
                1
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK,
            x = 3,
            y = 10,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 6),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_VALOR,
        },
    },
    completed = {
        type = "quest",
        id = 39855,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_VALOR,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39837,
            x = 3,
            y = 1,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 38339,
            x = 2,
            y = 2,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 38324,
            x = 4,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 38347,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39848,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39857,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39849,
            x = 3,
            y = 6,
            connections = {
                1, 2
            },
        },


        {
            type = "quest",
            id = 39850,
            x = 2,
            y = 7,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 39851,
            x = 4,
            y = 7,
            connections = {
                1
            },
        },

        
        {
            type = "quest",
            id = 39853,
            x = 3,
            y = 8,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39855,
            x = 3,
            y = 9,
            connections = {
                1, 2
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_SECRETS_OF_THE_SHIELDMAIDENS,
            aside = true,
            x = 2,
            y = 10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_CHAMPION_OF_STORMHEIM,
            aside = true,
            x = 4,
            y = 10,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_SECRETS_OF_THE_SHIELDMAIDENS, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 7),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK,
        },
    },
    completed = {
        {
            type = "quest",
            id = 39122,
            restrictions = {
                {
                    type = "faction",
                    id = BTWQUESTS_FACTION_ID_ALLIANCE,
                },
            },
        },
        {
            type = "quest",
            id = 38882,
            restrictions = {
                {
                    type = "faction",
                    id = BTWQUESTS_FACTION_ID_HORDE,
                },
            },
        },
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 39059,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38872,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 1,
            connections = {
                1, 2, 
            },
        },

        
        {
            variations = {
                {
                    type = "quest",
                    id = 39060,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38873,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 2,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 39061,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 39153,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 4,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 39472,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 39385,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 6,
            y = 2,
        },

        
        {
            variations = {
                {
                    type = "quest",
                    id = 39062,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 39154,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 3,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 39405,
            aside = true,
            x = 2,
            y = 4,
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 39063,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38878,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },

        
        {
            variations = {
                {
                    type = "quest",
                    id = 39092,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 39155,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 39122,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 38882,
                    restrictions = {
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_HORDE,
                        },
                    },
                },
            },
            x = 3,
            y = 6,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_CHAMPION_OF_STORMHEIM, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(10790, 8),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK,
        },
    },
    completed = {
        type = "quest",
        id = 40005,
    },
    major = true,
    range = {98, 110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40078,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40001,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40002,
            x = 3,
            y = 3,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 40003,
            x = 2,
            y = 4,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 40004,
            x = 4,
            y = 4,
            connections = {
                1
            },
        },


        {
            type = "quest",
            id = 40005,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40072,
            aside = true,
            x = 3,
            y = 6,
        },  
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_A_MURKY_FATE, {
    name = { -- A Murky Fate
		type = "quest",
		id = 40120,
	},
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    completed = {
        type = "quest",
        id = 40120,
    },
    range = {98, 110},
    items = {
        {
            type = "npc",
            id = 98587,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40120,
            x = 3,
            y = 1,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_DREYRGROT, {
    name = { -- The Mystery of Dreyrgrot
		type = "quest",
		id = 42635,
	},
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    completed = {
        type = "quest",
        id = 42640,
    },
    range = {98, 110},
    items = {
        {
            type = "npc",
            id = 108072,
            x = 2,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "object",
            id = 250990,
            x = 5,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 42635,
            x = 1,
            y = 1,
            connections = {
                3,
                4,
            },
        },
        {
            type = "quest",
            id = 42639,
            x = 3,
            y = 1,
            connections = {
                2,
                3,
            },
        },
        {
            type = "quest",
            id = 42640,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 42641,
            x = 1,
            y = 2,
        },
        {
            type = "quest",
            id = 42645,
            x = 3,
            y = 2,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_RAVENBEAR, {
    name = { -- Plight of the Blackfeather
		type = "quest",
		id = 42444,
	},
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    completed = {
        type = "quest",
        id = 42447,
    },
    range = {98, 110},
    items = {
        {
            type = "npc",
            id = 107499,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 42444,
            x = 3,
            y = 1,
            connections = {
                1,
                2,
            },
        },
        {
            type = "quest",
            id = 42445,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 42446,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 42447,
            x = 3,
            y = 3,
        },
    }
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_GOBLINS, {
    name = BtWQuests_GetAchievementNameDelayed(11232),
    category = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    completed = {
        type = "quest",
        id = 43331,
    },
    range = {98, 110},
    items = {
        {
            type = "npc",
            id = 97258,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 39789,
            x = 3,
            y = 1,
            connections = {
                1,
                2,
            },
        },
        {
            type = "quest",
            id = 39793,
            x = 2,
            y = 2,
            connections = {
                2,
                3,
            },
        },
        {
            type = "quest",
            id = 39787,
            x = 4,
            y = 2,
            connections = {
                1,
                2,
            },
        },
        {
            type = "quest",
            id = 39792,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 39786,
            x = 4,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 42483,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "npc",
            id = 110018,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 43331,
            x = 3,
            y = 6,
        },
    }
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_LEGION_STORMHEIM, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_LEGION,
    buttonImage = 1537284,
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_ALLIANCE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_ALLIANCE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GREYMANES_GAMBIT_HORDE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_AFTERMATH_HORDE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_MIGHT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_WILL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_TRIAL_OF_VALOR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_TO_HELHEIM_AND_BACK,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_SECRETS_OF_THE_SHIELDMAIDENS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_THE_CHAMPION_OF_STORMHEIM,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_A_MURKY_FATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_DREYRGROT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_RAVENBEAR,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GOBLINS,
        },
    }
})

BtWQuestsDatabase:AddExpansionItem(BTWQUESTS_EXPANSION_LEGION, {
    type = "category",
    id = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_LEGION_STORMHEIM,
})

BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_SECRETS_OF_THE_SHIELDMAIDENS)
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_A_MURKY_FATE)
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_DREYRGROT)
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_RAVENBEAR)
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_LEGION_STORMHEIM_GOBLINS)

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_A_MURKY_FATE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_DREYRGROT,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_RAVENBEAR,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_LEGION_STORMHEIM_GOBLINS,
    },
})