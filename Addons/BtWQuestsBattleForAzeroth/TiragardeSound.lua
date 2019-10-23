local L = BtWQuests.L;
local MAP_ID = 895
local CONTINENT_ID = 876
local ACHIEVEMENT_ID = 12473

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 1)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_INTRODUCTION,
        },
    },
    active = {
        type = "quest",
        id = 47960,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 50531,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                980200, 1000400, 1020600, 1040800, 1061000, 1081200, 1101400, 1121600, 1141800, 1162000, 1182200, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                83100, 83800, 84500, 85150, 85850, 86550, 87400, 88100, 88650, 89350, 
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
            id = 2160,
            amount = 675,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 47960,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47181,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47485,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },

        {
            type = "quest",
            id = 47488,
            x = 0,
            y = 3,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 47486,
            x = 2,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 47487,
            x = 4,
            y = 3,
            connections = {
                2, 
            },
        },

        {
            type = "quest",
            id = 50573,
            x = 6,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50531,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
            aside = true,
            x = 3,
            y = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 2)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY,
        },
    },
    completed = {
        type = "quest",
        id = 49404,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3462900, 3534300, 3605700, 3677100, 3748500, 3819900, 3891300, 3962700, 4034100, 4105500, 4176900, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                293650, 296300, 298950, 300800, 303450, 306150, 308800, 311450, 313300, 315950, 
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
            id = 2160,
            amount = 1735,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 281551,
            -- name = "Go to the Help Wanted Poster",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.755499, 0.499419, "Help Wanted Poster")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 50544,
                blockers = {48874, 48873},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 0,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 133550,
            -- name = "Go to Junior Miner Joe",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.756956, 0.506281, "Junior Miner Joe")
            -- end,
            -- breadcrumb = true,
            x = 2,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY,
            x = 4,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 136576,
            -- name = "Go to Dockmaster Leighton",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.750697, 0.497147, "Dockmaster Leighton")
            -- end,
            -- breadcrumb = true,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },

        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN1,
            relationship = {
                breadcrumb = 50544,
                blockers = {48874, 48873},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 0,
            y = 1
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN2,
            relationship = {
                breadcrumb = 50349,
            },
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 53041,
            x = 4,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN3,
            relationship = {
                breadcrumb = 51149,
            },
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 6,
            y = 1,
        },

        {
            type = "quest",
            id = 47489,
            x = 4,
            y = 2,
            connections = {
                2, 
            },
        },

        {
            type = "npc",
            id = 126511,
            -- name = "Go to Skinner MacGuff",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.827264, 0.727482, "Skinner MacGuff")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 2,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48419,
            x = 4,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CASTAWAYS_AND_CUTOUTS,
            aside = true,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 48516,
            aside = true,
            x = 2,
            y = 4,
        },
        {
            type = "quest",
            id = 48505,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48539,
            x = 3,
            y = 5,
            connections = {
                1, 2, 3, 4, 5,
            },
        },
        
        {
            type = "quest",
            id = 48606,
            aside = true,
            x = 5,
            y = 5,
        },
        {
            type = "quest",
            id = 48774,
            aside = true,
            x = 0,
            y = 6,
        },
        {
            type = "quest",
            id = 48776,
            aside = true,
            x = 2,
            y = 6,
        },
        {
            type = "quest",
            id = 48773,
            x = 4,
            y = 6,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 48558,
            x = 6,
            y = 6,
            connections = {
                1, 2,
            },
        },
        
        {
            type = "quest",
            id = 49239,
            x = 3,
            y = 7,
            connections = {
                2, 3,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN4,
            aside = true,
            x = 5,
            y = 7,
        },

        {
            type = "quest",
            id = 49401,
            x = 2,
            y = 8,
            connections = {
                2, 3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 49398,
            x = 4,
            y = 8,
            connections = {
                1, 2, 3, 4,
            },
        },


        {
            type = "quest",
            id = 49409,
            aside = true,
            x = 0,
            y = 9,
        },
        {
            type = "quest",
            id = 49399,
            x = 2,
            y = 9,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49400,
            aside = true,
            x = 4,
            y = 9,
        },
        {
            type = "quest",
            id = 49402,
            aside = true,
            x = 6,
            y = 9,
            connections = {
                2, 
            },
        },

        
        {
            type = "quest",
            id = 49404,
            x = 3,
            y = 10,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49403,
            aside = true,
            x = 6,
            y = 10,
        },

        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_DEFENDERS_OF_DAELINS_GATE,
            aside = true,
            x = 3,
            y = 11,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_DEFENDERS_OF_DAELINS_GATE, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 3)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
        },
    },
    completed = {
        type = "quest",
        id = 49740,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2493400, 2544800, 2596200, 2647600, 2699000, 2750400, 2801800, 2853200, 2904600, 2956000, 3007400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                199050, 200850, 202600, 203950, 205700, 207500, 209300, 211100, 212400, 214200, 
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
            id = 2160,
            amount = 710,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
            x = 3,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49405,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 52431,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49869,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 52787,
            aside = true,
            x = 0,
            y = 4,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 52750,
            x = 2,
            y = 4,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49737,
            x = 4,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49757,
            aside = true,
            x = 6,
            y = 4,
        },


        
        {
            type = "quest",
            id = 49738,
            x = 3,
            y = 5,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49741,
            aside = true,
            x = 0,
            y = 6,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 49736,
            x = 2,
            y = 6,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49740,
            x = 4,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49739,
            aside = true,
            x = 6,
            y = 6,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_ENEMIES_WITHIN,
            aside = true,
            x = 2,
            y = 7,
        }
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_ENEMIES_WITHIN, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 4)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_DEFENDERS_OF_DAELINS_GATE,
        },
        {
            type = "quest",
            id = 49741,
        },
    },
    completed = {
        type = "quest",
        id = 50972,
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
                186700, 188400, 189900, 191450, 192950, 194650, 196350, 197900, 199350, 200900, 
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
            id = 2160,
            amount = 1060,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_DEFENDERS_OF_DAELINS_GATE,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50110,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50795,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50787,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50788,
            x = 2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50789,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50790,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            ids = {50972, 51825, 51826},
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52800,
            aside = true,
            x = 3,
            y = 7,
        },
    },
})
-- Completed, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_SHADOW_OVER_ANGLEPOINT, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 5)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
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
        type = "quest",
        ids = {48347, 48540},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 49302,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                5529000, 5643000, 5757000, 5871000, 5985000, 6099000, 6213000, 6327000, 6441000, 6555000, 6669000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                407150, 410850, 414400, 417200, 420750, 424550, 428100, 431800, 434450, 438150, 
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
            id = 2160,
            amount = 1420,
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
                    id = 48347,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 125922,
                    -- name = "Go to Brother Therold",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.422778, 0.293083, "Brother Therold")
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
            id = 48540,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 48348,
            x = 1,
            y = 2,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 48352,
            x = 3,
            y = 2,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 49268,
            x = 5,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48353,
            x = 2,
            y = 3,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 49292,
            x = 4,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 51384,
            aside = true,
            x = 6,
            y = 3,
        },

        {
            type = "quest",
            id = 48354,
            x = 2,
            y = 4,
            connections = {
                2, 3, 4, 5, 6,
            },
        },
        {
            type = "quest",
            id = 48355,
            x = 4,
            y = 4,
            connections = {
                1, 2, 3, 4, 5,
            },
        },

        {
            type = "quest",
            id = 48356,
            x = 1,
            y = 5,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 48365,
            x = 3,
            y = 5,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 48009,
            x = 5,
            y = 5,
            connections = {
                3, 
            },
        },

        {
            type = "quest",
            id = 48008,
            x = 2,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49299,
            x = 4,
            y = 6,
            connections = {
                1, 
            },
        },


        {
            type = "quest",
            id = 48366,
            x = 3,
            y = 7,
            connections = {
                1, 2, 3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 48367,
            x = 0,
            y = 8,
            connections = {
                6, 
            },
        },
        {
            type = "quest",
            id = 48368,
            x = 2,
            y = 8,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 49300,
            x = 4,
            y = 8,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 48370,
            x = 6,
            y = 8,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48372,
            x = 3,
            y = 9,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49300,
            x = 6,
            y = 9,
        },
        {
            type = "quest",
            id = 49302,
            x = 3,
            y = 10,
            connections = {
                1, 
            },
        },
    },
})
-- Completed, no requirements, 2 breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_NORWINGTON_ESTATE, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 6)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
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
        type = "quest",
        ids = {51199, 48070, 48077, 48080, 48616},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 48089,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                4190400, 4276800, 4363200, 4449600, 4536000, 4622400, 4708800, 4795200, 4881600, 4968000, 5054400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                299825, 302525, 305100, 307250, 309825, 312625, 315250, 317950, 319925, 322625, 
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
            id = 2160,
            amount = 1365,
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
                    id = 51199,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "quest",
                    id = 48070,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 125309,
                    -- name = "Go to Abbey Swiftbrook",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.554502, 0.246649, "Abbey Abbey")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 0,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "npc",
            id = 125398,
            -- name = "Go to Harold Beckett",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.555169, 0.245877, "Harold Beckett")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 127803,
            -- name = "Go to Caleb Batharen",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.582887, 0.254009, "Caleb Batharen")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },




        {
            type = "quest",
            id = 48077,
            x = 0,
            y = 1,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 48080,
            x = 2,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48616,
            x = 4,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 48965,
            aside = true,
            x = 6,
            y = 1,
        },

        {
            type = "quest",
            id = 48670,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48597,
            x = 0,
            y = 3,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 48195,
            x = 2,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 48196,
            x = 4,
            y = 3,
        },
        {
            type = "quest",
            id = 48778,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 48003,
            x = 3,
            y = 4,
            connections = {
                2, 
            },
        },

        
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN10,
            aside = true,
            x = 1,
            y = 5,
        },
        {
            type = "quest",
            id = 48005,
            x = 3,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51367,
            aside = true,
            x = 5,
            y = 5,
        },


        {
            type = "quest",
            id = 48004,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48939,
            x = 3,
            y = 7,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 48087,
            x = 3,
            y = 8,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48088,
            x = 2,
            y = 9,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48089,
            x = 4,
            y = 9,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49036,
            aside = true,
            x = 3,
            y = 10,
        },
    },
})
-- Need to fix the 2 breadcrumbs
-- Requries part of the main story for alliance [Lovesick and Lost]
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CASTAWAYS_AND_CUTOUTS, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 7)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
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
        type = "quest",
        ids = {49218, 53442, 48421, 53439, 49178, 53443, 49226, 53445, 49230, 53446, 49181, 53444},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {48505, 49178, 49226, 49230, 48421},
        count = 5,
    },
    items = {
        {
            variations = {
                {
                    type = "npc",
                    id = 143777,
                    -- name = "Go to Tall Hasani",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.8529, 0.8049, "Tall Hasani")
                    -- end,
                    -- breadcrumb = true,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_HORDE,
                    },
                },
                {
                    type = "npc",
                    id = 125342,
                    -- name = "Go to Captain Keelson",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.863578, 0.797432, "Captain Keelson")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 0,
            y = 0,
            connections = {
                3,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    ids = {49218, 53442},
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 128229,
                    -- name = "Go to Abbey Swiftbrook",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.854669, 0.808161, "Stabby Jane")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 128228,
            -- name = "Go to Hungry Sam",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.854679, 0.807211, "Hungry Sam")
            -- end,
            -- breadcrumb = true,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },
        -- {
        --     type = "quest",
        --     ids = {49218, 53442},
        --     x = 3,
        --     y = 1,
        --     connections = {
        --         2, 3, 4,
        --     },
        -- },
        { -- Maybe 48421 isnt part of this chain but should be part of Freehold?
            type = "quest",
            ids = {48421, 53439},
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            ids = {49178, 53443},
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            ids = {49226, 53445},
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            ids = {49230, 53446},
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            ids = {49181,53444},
            x = 0,
            y = 2,
        },
    },
})
-- Completed, Alliance only, no breadcrumbs, although one required quest that looks like a breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN2, {
    name = { -- An Overrun Mine
        type = "quest",
        id = 50349,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        id = 50349,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 50356,
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
            type = "currency",
            id = 1553,
            amount = 75,
        },
        {
            type = "reputation",
            id = 2160,
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
            id = 133550,
            -- name = "Go to Junior Miner Joe",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.756956, 0.506281, "Junior Miner Joe")
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
            id = 50349,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            }
        },
        {
            type = "quest",
            id = 50351,
            x = 2,
            y = 2,
            connections = {
                2,
            }
        },
        {
            type = "quest",
            id = 50352,
            x = 4,
            y = 2,
            connections = {
                1,
            }
        },
        {
            type = "quest",
            id = 50356,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, Alliance Only, No requirements, couple of breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN5, {
    name = BtWQuests_GetAreaName(9314), -- Thovas Base-Camp
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {50700, 51151, 52258, 49225, 49229, 49234, 49232, 49233},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 49260,
        },
        {
            type = "quest",
            id = 49232,
        },
        {
            type = "quest",
            id = 49233,
        },
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
                104450, 105400, 106300, 107050, 107950, 108900, 109850, 110800, 111450, 112400, 
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
            id = 2160,
            amount = 460,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 140752,
            -- name = "Go to Jenny Swiftbrook",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.609915, 0.308570, "Jenny Swiftbrook")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 128381,
            -- name = "Go to Drogrin Alewhisker",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.627240, 0.299512, "Drogrin Alewhisker")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 50700,
                    status = {'notactive'},
                },
                {
                    type = "quest",
                    id = 50700,
                    status = {'notcompleted'},
                },
                {
                    type = "quest",
                    id = 51151,
                    status = {'notactive'},
                },
                {
                    type = "quest",
                    id = 51151,
                    status = {'notcompleted'},
                },
            },
            x = 3,
            y = 0,
            connections = {
                4, 5,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 50700,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "quest",
                    id = 51151,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    visible = false,
                },
            },
            x = 4,
            y = 0,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "npc",
            id = 130101,
            -- name = "Go to Recruit Brutis",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.629505, 0.299154, "Recruit Brutis")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 50700,
                    status = {'notactive'},
                },
                {
                    type = "quest",
                    id = 50700,
                    status = {'notcompleted'},
                },
                {
                    type = "quest",
                    id = 51151,
                    status = {'notactive'},
                },
                {
                    type = "quest",
                    id = 51151,
                    status = {'notcompleted'},
                },
            },
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },


        {
            type = "quest",
            id = 52258,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 49225,
            x = 2,
            y = 1,
            connections = {
                5,
            },
        },
        {
            type = "quest",
            id = 49229,
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            id = 49234,
            x = 6,
            y = 1,
        },

        
        {
            type = "npc",
            id = 128353,
            -- name = "Go to Pendi Cranklefuse",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1171, 0.513119, 0.706588, "Pendi Cranklefuse")
            -- end,
            -- breadcrumb = true,
            x = 4,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "npc",
            id = 128354,
            -- name = "Go to Birch Tomlin",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1171, 0.503748, 0.703355, "Birch Tomlin")
            -- end,
            -- breadcrumb = true,
            x = 6,
            y = 2,
            connections = {
                3,
            },
        },

        {
            type = "quest",
            id = 49260,
            x = 2,
            y = 3,
        },
        {
            type = "quest",
            id = 49232,
            x = 4,
            y = 3,
        },
        {
            type = "quest",
            id = 49233,
            x = 6,
            y = 3,
        },
    },
})
-- Completed, alliance only, requires part way through freehold quest line, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN4, {
    name = { -- The Long Con
        type = "achievement",
        id = 13049,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
            upto = {
                {
                    type = "quest",
                    id = 48773,
                },
                {
                    type = "quest",
                    id = 48558,
                },
            },
        }
    },
    active = {
        type = "quest",
        id = 49290,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 49223,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1284500, 1296500, 1308500, 1320500, 1332500, 1344500, 1356500, 1368500, 1380500, 1392500, 1404500, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                49350, 49800, 50250, 50550, 51000, 51450, 51850, 52300, 52700, 53150, 
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
            id = 2160,
            amount = 150,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
        {
            type = "reputation",
            id = 2163,
            amount = 350,
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
            compeleted = {
                type = "quest",
                id = 49290,
                status = {'active', 'completed'},
            },
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49290,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49407,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49522,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49523,
            x = 3,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "level",
            level = 120,
            x = 5,
            y = 4.5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49223,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, alliance only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN6, {
    name = BtWQuests_GetAreaName(9360), -- Fizzsprings Resort
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {50542, 49531, 49897, 51426, 51430},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 49531,
        },
        {
            type = "quest",
            id = 49897,
        },
        {
            type = "quest",
            id = 51426,
        },
        {
            type = "quest",
            id = 51430,
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
                98700, 99600, 100500, 101100, 102000, 102900, 103800, 104700, 105300, 106200, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2160,
            amount = 200,
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
                    id = 50542,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 129858,
                    -- name = "Go to Wulferd Fizzbracket",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.674951, 0.558120, "Wulferd Fizzbracket")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 1,
            y = 0,
            connections = {
                2, 3, 
            },
        },
        {
            type = "npc",
            id = 137694,
            -- name = "Go to Parin Tinklocket",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.649917, 0.606135, "Parin Tinklocket")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 50544,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 5,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 49531,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 49897,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 51426,
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            id = 51430,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 49529,
            aside = true,
            x = 3,
            y = 2,
        },
    },
})
-- Completed, Alliance only, no requirements, 1 breadcrumb, Seems kinda pointless, its just an area for breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN3, {
    name = BtWQuests_GetAreaName(9381), -- Southwind Station
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
    active = false,
    completed = {
        type = "quest",
        id = 51149,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                19400, 19800, 20200, 20600, 21000, 21400, 21800, 22200, 22600, 23000, 23400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                1650, 1650, 1650, 1700, 1700, 1700, 1750, 1750, 1750, 1750, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
    },
    items = {
        {
            type = "npc",
            id = 136576,
            -- name = "Go to Dockmaster Leighton",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.750697, 0.497147, "Dockmaster Leighton")
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
            id = 51149,
            x = 3,
            y = 1,
        },

        {
            type = "npc",
            id = 129956,
            -- name = "Go to Dockmaster Tyndall",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.658408, 0.500967, "Dockmaster Tyndall")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 51151,
                blockers = {49225, 49229, 50700},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 1,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "npc",
            id = 134509,
            -- name = "Go to Lead Guide Zipwrench",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.666848, 0.500323, "Lead Guide Zipwrench")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 50542,
                blockers = {49531, 49897},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 3,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "object",
            id = 281230,
            -- name = "Go to Formal Invitation",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.671420, 0.247996, "Formal Invitation")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 48070,
                blockers = {48077, 51199},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 5,
            y = 2,
            connections = {
                3,
            },
        },


        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN5,
            relationship = {
                breadcrumb = 51151,
                blockers = {49225, 49229, 50700},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 1,
            y = 3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN6,
            relationship = {
                breadcrumb = 50542,
                blockers = {49531, 49897},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 3,
            y = 3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_NORWINGTON_ESTATE,
            relationship = {
                breadcrumb = 48070,
                blockers = {48077, 51199},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 5,
            y = 3,
        },
    },
})
-- Completed, Alliance Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN1, {
    name = { -- The Hunters of Kennings Lodge
        type = "quest",
        id = 50544,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {50544, 48873, 48879, 48874},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 48909,
        },
        {
            type = "quest",
            id = 49066,
        },
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
                147250, 148550, 149800, 150900, 152150, 153500, 154850, 156150, 157100, 158400, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2160,
            amount = 1110,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 277199,
            -- name = "Go to Weathered Job List",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.761227, 0.655189, "Weathered Job List")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 0,
            connections = {
                4, 8,
            },
        },
        {
            type = "quest",
            id = 50544,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 4,
            y = 0,
            connections = {
                4, 5, 6,
            },
        },
        {
            type = "npc",
            id = 127646,
            -- name = "Go to Lord Kennings",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.758213, 0.657893, "Lord Kennings")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 50544,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 127161,
            -- name = "Go to Alanna Holton",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.758435, 0.658611, "Alanna Holton")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 50544,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },



        {
            type = "quest",
            id = 49028,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 48873,
            x = 2,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 48879,
            x = 4,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48874,
            x = 6,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49069,
            aside = true,
            x = 0,
            y = 2,
        },
        {
            type = "quest",
            id = 49072,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49039,
            x = 4,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48909,
            x = 3,
            y = 4,
        },
        {
            type = "quest",
            id = 49066,
            x = 5,
            y = 4,
        },
    },
})
-- Completed, Alliance Only, no requirements, no breadcrumbs but something that looks like one
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN12, {
    name = { -- Save our shipment
        type = "quest",
        id = 50026,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        id = 50026,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 50005,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1213000, 1238000, 1263000, 1288000, 1313000, 1338000, 1363000, 1388000, 1413000, 1438000, 1463000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                102850, 103750, 104650, 105350, 106250, 107200, 108100, 109000, 109750, 110650, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2160,
            amount = 325,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 131627,
            -- name = "Go to Thomas Pinker",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.494604, 0.312683, "Thomas Pinker")
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
            id = 50026,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3, 4,
            }
        },
        {
            type = "quest",
            id = 50009,
            aside = true,
            x = 0,
            y = 2,
        },
        {
            type = "quest",
            id = 47755,
            aside = true,
            x = 2,
            y = 2,
        },
        {
            type = "quest",
            id = 50002,
            x = 4,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50059,
            aside = true,
            x = 6,
            y = 2,
        },
        {
            type = "quest",
            id = 50005,
            x = 4,
            y = 3,
        },
    },
})
-- Completed, Alliance only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN7, {
    name = { -- Trouble at Greystone Keep
        type = "quest",
        id = 49715,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {49715, 49733, 51226},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 50249,
        },
        {
            type = "quest",
            id = 49734,
        },
        {
            type = "quest",
            id = 49716,
        },
        {
            type = "quest",
            id = 49720,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1746000, 1782000, 1818000, 1854000, 1890000, 1926000, 1962000, 1998000, 2034000, 2070000, 2106000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                123350, 124500, 125550, 126450, 127500, 128650, 129700, 130850, 131650, 132800, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2160,
            amount = 610,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 49715,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 133035,
            -- name = "Go to Officer Jovan",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.811002, 0.424831, "Officer Jovan")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 49715,
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 49715,
                    status = {'notcompleted'}
                },
            },
            x = 2,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 125398,
            -- name = "Go to Harold Beckett",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.555169, 0.245877, "Harold Beckett")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 49715,
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 49715,
                    status = {'notcompleted'}
                },
            },
            x = 4,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49733,
            x = 2,
            y = 1,
            connections = {
                2, 3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 51226,
            x = 4,
            y = 1,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 50249,
            x = 0,
            y = 2,
        },
        {
            type = "quest",
            id = 49734,
            x = 2,
            y = 2,
        },
        {
            type = "quest",
            id = 49716,
            x = 4,
            y = 2,
        },
        {
            type = "quest",
            id = 49720,
            x = 6,
            y = 2,
        },
    },
})
-- Completed, Alliance Only, No requirements, seems no breadcrumbs either
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN10, {
    name = L["BTWQUESTS_MAJO_AND_JOMA"],
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {48898, 48902, 48899},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 48903,
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
            id = 2163,
            amount = 310,
        },
    },
    items = {
        {
            type = "npc",
            id = 127586,
            -- name = "Go to Joma",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.513127, 0.258978, "Joma")
            -- end,
            -- breadcrumb = true,
            x = 2,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "npc",
            id = 127492,
            -- name = "Go to Majo",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.512903, 0.258750, "Majo")
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
            id = 48898,
            x = 1,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48902,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48899,
            x = 5,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48903,
            x = 3,
            y = 2,
        },
    },
})
-- Completed, Alliance only, no requrements, is a breadcrumb hub
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN8, {
    name = BtWQuests_GetAreaName(9335), -- Hatherford
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
    active = false,
    completed = {
        type = "quest",
        id = 51144,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                630500, 643500, 656500, 669500, 682500, 695500, 708500, 721500, 734500, 747500, 760500, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                28800, 29050, 29300, 29500, 29750, 30050, 30250, 30500, 30750, 31000, 
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
            id = 2160,
            amount = 250,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 124289,
            -- name = "Go to Jenny Swiftbrook",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.609915, 0.308570, "Jenny Swiftbrook")
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
            id = 51144,
            x = 3,
            y = 1,
        },
        
        {
            type = "npc",
            id = 139089,
            -- name = "Go to Hatherford Guard",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.663190, 0.248081, "Hatherford Guard")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 50700,
                blockers = {49225, 49229},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 0,
            y = 2,
            connections = {
                4,
            },
        },
        {
            type = "object",
            id = 288641,
            -- name = "Go to the Wanted Poster",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.668494, 0.243570, "Wanted Poster")
            -- end,
            -- breadcrumb = true,
            x = 2,
            y = 2,
            connections = {
                4,
            },
        },
        {
            type = "object",
            id = 281230,
            -- name = "Go to Formal Invitation",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.671420, 0.247996, "Formal Invitation")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 48070,
                blockers = {48077, 51199},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 4,
            y = 2,
            connections = {
                4,
            },
        },
        {
            type = "npc",
            id = 134776,
            -- name = "Go to Davey Brindle",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.673976, 0.241373, "Davey Brindle")
            -- end,
            -- breadcrumb = true,
            relationship = {
                breadcrumb = 50699,
                blocker = 49465,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            x = 6,
            y = 2,
            connections = {
                4,
            },
        },



        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN5,
            relationship = {
                breadcrumb = 50700,
                blockers = {49225, 49229},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 51358,
            x = 2,
            y = 3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_NORWINGTON_ESTATE,
            relationship = {
                breadcrumb = 48070,
                blockers = {48077, 51199},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 4,
            y = 3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN9,
            relationship = {
                breadcrumb = 50699,
                blocker = 49465,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 6,
            y = 3,
        },
    },
})
-- Completed, Alliance Only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN9, {
    name = { -- Witch of the Woods
        type = "quest",
        id = 49467,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {50699, 49465, 49452, 49451},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 49467,
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
                157900, 159350, 160700, 161850, 163200, 164650, 166050, 167500, 168500, 169950, 
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
            id = 2160,
            amount = 825,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 129613,
            -- name = "Go to Maynard Algerson",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.689298, 0.205881, "Maynard Algerson")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 50699,
            },
            visible = BtWQuestsItem_RelationshipBlockersVisible,
            x = 3,
            y = 0,
            connections = {
                4, 5,
            },
        },
        {
            type = "npc",
            id = 129669,
            -- name = "Go to Benjamin Algerson",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.688899, 0.198464, "Benjamin Algerson")
            -- end,
            -- breadcrumb = true,
            relationship = {
                blocker = 50699,
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
            id = 50699,
            visible = BtWQuestsItem_ActiveOrCompleted,
            x = 4,
            y = 0,
            connections = {
                2, 3, 4,
            },
        },


        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN15,
            embed = true,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 49465,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49452,
            x = 4,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49451,
            x = 6,
            y = 1,
            connections = {
                1,
            },
        },
        
        
        {
            type = "quest",
            id = 48369,
            x = 4,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },

        
        {
            type = "quest",
            id = 50058,
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 49468,
            x = 2,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49454,
            x = 4,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 49450,
            x = 6,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49467,
            x = 4,
            y = 4,
        },
    },
})
-- Completed, Alliance Only, no requirements, seems like no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN11, {
    name = { -- The Roughnecks
        type = "quest",
        id = 49393,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        id = 49393,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 49719,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3530800, 3603600, 3676400, 3749200, 3822000, 3894800, 3967600, 4040400, 4113200, 4186000, 4258800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                237700, 239850, 241850, 243650, 245650, 247850, 249950, 252100, 253650, 255800, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 265,
        },
        {
            type = "reputation",
            id = 2160,
            amount = 1145,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 289313,
            -- name = "Go to Wanted Sign",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.421558, 0.229884, "Wanted Sign")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 0,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49393,
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 129392,
            -- name = "Go to\"Helpless\" Henry",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.477050, 0.176317, "\"Helpless\" Henry")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 51368,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 49394,
            x = 2,
            y = 1,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 49395,
            x = 4,
            y = 1,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 49412,
            x = 6,
            y = 1,
            connections = {
                9,
            },
        },

        {
            type = "quest",
            id = 49735,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49710,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49417,
            x = 3,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 130478,
            -- name = "Go to Griddon",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.449121, 0.154990, "Griddon")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 0,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49418,
            x = 3,
            y = 4,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 49431,
            aside = true,
            x = 0,
            y = 5,
        },
        {
            type = "quest",
            id = 49433,
            x = 2,
            y = 5,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 49435,
            x = 4,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49419,
            aside = true,
            x = 6,
            y = 5,
        },
        {
            type = "quest",
            id = 49439,
            x = 4,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49719,
            x = 3,
            y = 7,
        },
    },
})
-- Horde version of Castaways and Cutouts
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN13, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 7)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {49218, 53442, 48421, 53439, 49178, 53443, 49226, 53445, 49230, 53446, 49181,53444},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            ids = {48421, 53439},
        },
        {
            type = "quest",
            ids = {49178, 53443},
        },
        {
            type = "quest",
            ids = {49226, 53445},
        },
        {
            type = "quest",
            ids = {49230, 53446},
        },
        {
            type = "quest",
            ids = {49181,53444},
        },
    },
    items = {
        {
            variations = {
                {
                    type = "npc",
                    id = 143777,
                    -- name = "Go to Tall Hasani",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.8529, 0.8049, "Tall Hasani")
                    -- end,
                    -- breadcrumb = true,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_HORDE,
                    },
                },
                {
                    type = "npc",
                    id = 125342,
                    -- name = "Go to Captain Keelson",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.863578, 0.797432, "Captain Keelson")
                    -- end,
                    -- breadcrumb = true,
                }
            },
            x = 0,
            y = 0,
            connections = {
                3,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    ids = {49218, 53442},
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 128229,
                    -- name = "Go to Abbey Swiftbrook",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(895, 0.854669, 0.808161, "Stabby Jane")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 128228,
            -- name = "Go to Hungry Sam",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.854679, 0.807211, "Hungry Sam")
            -- end,
            -- breadcrumb = true,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },
        -- {
        --     type = "quest",
        --     ids = {49218, 53442},
        --     x = 3,
        --     y = 1,
        --     connections = {
        --         2, 3, 4,
        --     },
        -- },
        { -- Maybe 48421 isnt part of this chain but should be part of Freehold?
            type = "quest",
            ids = {48421, 53439},
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            ids = {49178, 53443},
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            ids = {49226, 53445},
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            ids = {49230, 53446},
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            ids = {49181,53444},
            x = 0,
            y = 2,
        },
    },
})
-- Horde Wanted quests from the Wolf's Den Outpost
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN14, {
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        type = "quest",
        id = 52127,
    },
    active = {
        type = "quest",
        ids = {53440, 53438},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 53440,
        },
        {
            type = "quest",
            id = 53438,
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
                49400, 49800, 50200, 50600, 51000, 51500, 51900, 52300, 52700, 53100, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 230,
        },
        {
            type = "reputation",
            id = 2157,
            amount = 500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
        {
            type = "reputation",
            id = 2160,
            amount = 500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 298778,
            -- name = "Go to the Wanted Poster",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.628, 0.14, "Wanted Poster")
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
            id = 53440,
            x = 2,
        },
        {
            type = "quest",
            id = 53438,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN15, {
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
        type = "quest",
        ids = {49453, 48557},
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 49453,
        },
        {
            type = "quest",
            id = 48557,
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
        {
            type = "reputation",
            id = 2160,
            amount = 150,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 129670,
            -- name = "Go to Lyssa Treewarden",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(895, 0.666195, 0.173166, "Lyssa Treewarden")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 49453,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 48557,
            x = 2,
            y = 1,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_OTHER_ALLIANCE, {
    name = "Other Alliance",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- Emissary
            type = "quest",
            id = 50599,
        },
        { -- Emissary
            type = "quest",
            id = 50605,
        },
        {
            type = "quest",
            id = 49661,
        },
        {
            type = "quest",
            id = 50350,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_OTHER_HORDE, {
    name = "Other Horde",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
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
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_OTHER_BOTH, {
    name = "Other Both",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        {
            type = "quest",
            id = 49408,
        },
        {
            type = "quest",
            id = 53451,
        },
        {
            type = "quest",
            id = 52956,
        },
        {
            type = "quest",
            id = 47894,
        },
        {
            type = "quest",
            id = 48104,
        },
        {
            type = "quest",
            id = 53454,
        },
        {
            type = "quest",
            id = 53440,
        },
        {
            type = "quest",
            id = 47695,
        },
        {
            type = "quest",
            id = 49464,
        },
        {
            type = "quest",
            id = 53438,
        },
        {
            type = "quest",
            id = 52948,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    buttonImage = 2178272,
    listImage = {
        texture = "Interface\\Addons\\BtWQuestsBattleForAzeroth\\UI-CategoryButton",
        texCoords = {0, 0.7353515625, 0.1171875, 0.234375},
    },
    items = {
        {
            type = "header",
            name = L["BTWQUESTS_THE_WAR_CAMPAIGN"],
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_HORDE
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_TIRAGARDE_SOUND_FOOTHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_FIRST_ASSAULT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_STRIKE_ON_BORALAS,
        },

        
        {
            type = "header",
            name = {
                type = "achievement",
                id = ACHIEVEMENT_ID,
            },
            restrictions = {
                type = "faction",
                id = BTWQUESTS_FACTION_ID_ALLIANCE
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_DEFENDERS_OF_DAELINS_GATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_ENEMIES_WITHIN,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_SHADOW_OVER_ANGLEPOINT,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_NORWINGTON_ESTATE,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CASTAWAYS_AND_CUTOUTS,
        },


        {
            type = "header",
            name = L["BTWQUESTS_SIDE_QUESTS"],
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN2,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN4,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN5,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN6,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN7,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN9,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN11,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN12,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN13,
        },
        
        


        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_OTHER_ALLIANCE,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_OTHER_BOTH,
        -- },
    },
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
}, true)

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN1,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN2,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN5,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN6,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN7,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN9,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN10,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN11,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN12,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN14,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN15,
    },
})

BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_ASHVANE_TRADING_COMPANY);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_FREEHOLD);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_DEFENDERS_OF_DAELINS_GATE);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_ENEMIES_WITHIN);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_SHADOW_OVER_ANGLEPOINT);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_THE_NORWINGTON_ESTATE);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CASTAWAYS_AND_CUTOUTS);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN1);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN2);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN3);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN4);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN5);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN6);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN7);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN8);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN9);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN10);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN11);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN12);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN13);
BtWQuestsDatabase:AddQuestItemsForChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN14);
BtWQuestsDatabase:AddQuestItemsForOtherChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN9, BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND_CHAIN15);