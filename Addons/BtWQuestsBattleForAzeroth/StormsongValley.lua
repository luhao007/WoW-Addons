--[[
    This zone is a little disjointed, there are some optional quest chains that most
    will do in the logical progression of the zone but can be skipped if you know where to go.
    There are others that would seem to be optional and have no requirements but are actually needed
    to complete the zone.

    The first 4 quest chains are the main story of the zone, and have no requirements outside of themselves.

    Cycle of Hatred requires the The Battle for Brennadam, when finishing The Battle for Brennadam you'll
    be sent to Survivors which in turn will send you to Cycle of Hatred but its possible to just skip
    Survivors and go right to Cycle of Hatred. Survivors also doesnt require The Battle for Brennadam
    Its probably worth checking what happens if you complete The Battle for Brennadam after completing Survivors
    Survivors will also lead people to Treasure in Deadwash

    The Battle for Brennadam leads people to 3 chains, Survivors as mentioned before, Burton Farmstead which
    requires The Battle for Brennadam although the breadcrumb between the 2 isnt requires and lastly
    Goldfield Farmstead which doesnt require The Battle for Brennadam. It would seem that
    The Battle for Brennadam, Burton Farmstead, and Goldfield Farmstead are all required for Briarback Kraul

    From the Depths They Come has no requirements but has breadcrumbs from Brennadam (The place not the quest line)
    which I'm not what causes it to appear and Cycle of Hatred

    Treasure in Deadwash has no requirements but does have breadcrumbs from Survivors and From the Depths They Come

    Deadliest Cache, Circle the Wagons, I like Turtles, Mayhem at Mildenhall Meadery, and Houndmaster Archibald all seem to have
    no requirements. Deadliest Cache, I like Turtles, and Mayhem at Mildenhall Meadery seem to have breadcrumb that lead to them
]]

local L = BtWQuests.L;
local MAP_ID = 942
local ACHIEVEMENT_ID = 12496
local CONTINENT_ID = 876

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_TIDESAGES_OF_STORMSONG, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 1)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
        {
            type = "quest",
            id = 47962,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51401,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                756600, 772200, 787800, 803400, 819000, 834600, 850200, 865800, 881400, 897000, 912600, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                51850, 52250, 52600, 53200, 53550, 54000, 54550, 54950, 55300, 55700, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 575,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 47962,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47952,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51487,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51488,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51489,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51490,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51401,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL,
            aside = true,
            x = 3,
            y = 7,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 2)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_TIDESAGES_OF_STORMSONG,
        },
    },
    completed = {
        type = "quest",
        id = 49997,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3026400, 3088800, 3151200, 3213600, 3276000, 3338400, 3400800, 3463200, 3525600, 3588000, 3650400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                219650, 221600, 223400, 225150, 226950, 229050, 230900, 232850, 234400, 236350, 
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
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 1985,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_TIDESAGES_OF_STORMSONG,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49725,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49703,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 49704,
            x = 1,
            y = 3,
            connections = {
                3, 4, 5, 6,
            },
        },
        {
            type = "quest",
            id = 49705,
            x = 3,
            y = 3,
            connections = {
                2, 3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 49706,
            x = 5,
            y = 3,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49791,
            x = 0,
            y = 4,
            connections = {
                6, 
            },
        },
        {
            type = "quest",
            id = 49793,
            x = 2,
            y = 4,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 49794,
            x = 4,
            y = 4,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 49887,
            x = 6,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49792,
            x = 6,
            y = 5,
            connections = {
                2, 
            },
        },
        
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN6,
            aside = true,
            relationship = {
                breadcrumb = 51582,
                blocker = 50343,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 1,
            y = 6,
        },
        {
            type = "quest",
            id = 49975,
            x = 3,
            y = 6,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1,
            aside = true,
            x = 5,
            y = 6,
        },


        {
            type = "quest",
            id = 49995,
            x = 1,
            y = 7,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49996,
            x = 3,
            y = 7,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50139,
            x = 5,
            y = 7,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 49997,
            x = 3,
            y = 8,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_GROWING_TEMPEST,
            aside = true,
            x = 3,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_GROWING_TEMPEST, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 3)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_TIDESAGES_OF_STORMSONG,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL,
        },
    },
    completed = {
        type = "quest",
        id = 50611,
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
                102850, 103750, 104600, 105400, 106250, 107250, 108100, 109000, 109750, 110650, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 785,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49998,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50594,
            x = 1,
            y = 2,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 50595,
            x = 3,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            ids = {50593, 50694},
            x = 5,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50608,
            x = 1,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50609,
            x = 3,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50610,
            x = 5,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50611,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_AT_THE_EDGE_OF_MADNESS,
            aside = true,
            x = 3,
            y = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_AT_THE_EDGE_OF_MADNESS, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 4)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_TIDESAGES_OF_STORMSONG,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_GROWING_TEMPEST,
        },
    },
    completed = {
        type = "quest",
        id = 50824,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                3142800, 3207600, 3272400, 3337200, 3402000, 3466800, 3531600, 3596400, 3661200, 3726000, 3790800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                274750, 277200, 279400, 281700, 283900, 286450, 288900, 291200, 293300, 295600, 
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
            id = 2162,
            amount = 1605,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_GROWING_TEMPEST,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50612,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50777,
            x = 0,
            y = 2,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 50778,
            x = 2,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50780,
            x = 4,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50779,
            aside = true,
            x = 6,
            y = 2,
        },
        {
            type = "quest",
            id = 50783,
            x = 2,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50784,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50781,
            x = 3,
            y = 5,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 51278,
            x = 2,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51320,
            x = 4,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51319,
            x = 3,
            y = 7,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            ids = {50824, 51845, 51846},
            x = 3,
            y = 8,
            connections = {
                1,  2,
            },
        },
        {
            type = "quest",
            id = 50825,
            aside = true,
            x = 2,
            y = 9,
        },
        {
            type = "quest",
            id = 50733,
            x = 4,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CYCLE_OF_HATRED, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 5)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1,
        },
    },
    completed = {
        type = "quest",
        id = 51712,
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
                143900, 145250, 146450, 147550, 148750, 150100, 151300, 152650, 153600, 154950, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 600,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 138924,
            -- name = "Go to Holger Nash",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1182, 0.663832, 0.384946, "Holger Nash")
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
            variations = {
                {
                    type = "quest",
                    id = 52065,
                    restrictions = {
                        type = "quest",
                        id = 52065,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "npc",
                    id = 138735,
                    -- name = "Go to Felecia Gladstone",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.468851, 0.476818, "Felecia Gladstone")
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
            type = "kill",
            id = 138521,
            -- name = "Kill a Mine Technician",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(1182, 0.365926, 0.187975, "Mine Technician")
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
        --     id = 52876,
        --     x = 6,
        --     y = 0,
        -- },

        {
            type = "quest",
            id = 51726,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 51711,
            x = 2,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 51752,
            x = 4,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 51881,
            x = 6,
            y = 1,
            connections = {
                3, 
            },
        },


        {
            type = "quest",
            id = 51723,
            x = 1,
            y = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 51720,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51728,
            x = 5,
            y = 2,
            connections = {
                1, 
            },
        },


        {
            type = "quest",
            id = 51712,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_FROM_THE_DEPTHS_THEY_COME,
            aside = true,
            visible = {
                {
                    type = "quest",
                    id = 50614,
                    restrictions = {
                        type = "quest",
                        id = 52070,
                        status = {'notcompleted'}
                    },
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 50614,
                    restrictions = {
                        type = "quest",
                        id = 52070,
                        status = {'notcompleted'}
                    },
                    status = {'notcompleted'}
                }
            },
            active = {
                type = "quest",
                id = 52070,
                status = {'active', 'completed'},
            },
            x = 3,
            y = 4,
        },
    },
})
-- No prerequisites
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_FROM_THE_DEPTHS_THEY_COME, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 6)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
        {
            type = "quest",
            id = 49818,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 52070,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50621,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50616,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50614,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 49831,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2977900, 3039300, 3100700, 3162100, 3223500, 3284900, 3346300, 3407700, 3469100, 3530500, 3591900, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                240150, 242350, 244500, 246050, 248200, 250400, 252550, 254750, 256250, 258450, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 1125,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 131002,
            -- name = "Go to Lieutenant Bauer",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.301586, 0.591988, "Lieutenant Bauer")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 49818,
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 52070,
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 49818,
                    status = {'notcompleted'}
                },
                {
                    type = "quest",
                    id = 52070,
                    status = {'notcompleted'}
                },
            },
            x = 3,
            y = 0,
            connections = {
                3, 4, 5,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 49818,
                    restrictions = {
                        type = "quest",
                        id = 49818,
                        status = {'active', 'completed'}
                    }
                },
                {
                    type = "npc",
                    id = 131002,
                    -- name = "Go to Lieutenant Bauer",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.301586, 0.591988, "Lieutenant Bauer")
                    -- end,
                    -- breadcrumb = true,
                    visible = {
                        type = "quest",
                        ids = {49818, 52070},
                        status = {'active', 'completed'}
                    },
                },
            },
            visible = {
                type = "quest",
                ids = {49818, 52070},
                status = {'active', 'completed'}
            },
            x = 2,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 52070,
                    restrictions = {
                        type = "quest",
                        id = 52070,
                        status = {'active', 'completed'}
                    }
                },
                {
                    type = "npc",
                    id = 131002,
                    -- name = "Go to Lieutenant Bauer",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.301586, 0.591988, "Lieutenant Bauer")
                    -- end,
                    -- breadcrumb = true,
                    visible = {
                        type = "quest",
                        ids = {49818, 52070},
                        status = {'active', 'completed'}
                    },
                },
            },
            x = 5,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50621,
            x = 1,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50616,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50614,
            x = 5,
            y = 1,
            connections = {
                1,
            },
        },


        {
            type = "quest",
            id = 50635,
            x = 3,
            y = 2,
            connections = {
                2, 3, 4, 5,
            },
        },
        
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN8,
            aside = true,
            relationship = {
                breadcrumb = 49832,
                blockers = {51343, 50797},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 6,
            y = 2,
        },
        {
            type = "quest",
            id = 50644,
            x = 0,
            y = 3,
            connections = {
                4, 5, 6,
            },
        },
        {
            type = "quest",
            id = 50653,
            x = 2,
            y = 3,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 50645,
            aside = true,
            x = 4,
            y = 3,
            connections = {
                5,
            },
        },
        {
            type = "quest",
            id = 50649,
            aside = true,
            x = 6,
            y = 3,
            connections = {
                4,
            },
        },


        {
            type = "quest",
            id = 50672,
            x = 0,
            y = 4,
            connections = {
                4, 5,
            },
        },
        {
            type = "quest",
            id = 50679,
            x = 2,
            y = 4,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 50698,
            x = 4,
            y = 4,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 50773,
            aside = true,
            x = 6,
            y = 4,
        },


        {
            type = "quest",
            id = 50705,
            x = 2,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50706,
            x = 4,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49831,
            x = 3,
            y = 6,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN12,
            aside = true,
            visible = {
                {
                    type = "quest",
                    id = 50376,
                    restrictions = {
                        type = "quest",
                        id = 53045,
                        status = {'notcompleted'}
                    },
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 50376,
                    restrictions = {
                        type = "quest",
                        id = 53045,
                        status = {'notcompleted'}
                    },
                    status = {'notcompleted'}
                }
            },
            active = {
                type = "quest",
                id = 53045,
                status = {'active', 'completed'}
            },
            x = 1,
            y = 7,
        },
        {
            type = "quest",
            id = 49908,
            aside = true,
            x = 3,
            y = 7,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_TREASURE_IN_DEADWASH,
            aside = true,
            relationship = {
                breadcrumb = 52069,
                blocker = 50810,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 5,
            y = 7,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_BRIARBACK_KRAUL, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 7)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN2,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN3,
        },
    },
    completed = {
        type = "quest",
        id = 50640,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1959400, 1999800, 2040200, 2080600, 2121000, 2161400, 2201800, 2242200, 2282600, 2323000, 2363400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                153800, 155200, 156550, 157600, 158950, 160350, 161750, 163150, 164100, 165500, 
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
            id = 2162,
            amount = 535,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "object",
            id = 282457,
            -- name = "Go to the Brambleguard Totem",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.440473, 0.724700, "Brambleguard Totem")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50622,
            x = 3,
            y = 1,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 50111,
            x = 0,
            y = 2,
        },
        {
            type = "quest",
            id = 50353,
            x = 2,
            y = 2,
            connections = {
                3, 4, 5,
            },
        },
        {
            type = "quest",
            id = 50354,
            x = 4,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 50367, -- Actually required further down
            x = 6,
            y = 2,
        },


        {
            type = "quest",
            id = 50363,
            x = 1,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50365,
            x = 3,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50340,
            x = 5,
            y = 3,
        },


        {
            type = "quest",
            id = 50368,
            x = 3,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50640,
            x = 3,
            y = 5,
            connections = {
            },
        },
    },
})
-- Completed, Alliance Only
--  breadcrumb from BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_FROM_THE_DEPTHS_THEY_COME ([52069] More Fodder)
--  breadcrumb from BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN7 ([51554] Reloading)
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_TREASURE_IN_DEADWASH, {
    name = function ()
        return GetAchievementCriteriaInfo(ACHIEVEMENT_ID, 8)
    end,
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
        {
            type = "quest",
            id = 52069,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51554,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50802,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50674,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50810,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51140,
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
            amount = 150,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 1295,
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
                    id = 52069,
                    restrictions = {
                        type = "quest",
                        id = 52069,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "quest",
                    id = 51554,
                    restrictions = {
                        type = "quest",
                        id = 51554,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "npc",
                    id = 134720,
                    -- name = "Go to Leo Shealds",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(942, 0.429716, 0.565976, "Leo Shealds")
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
            id = 50802,
            x = 1,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50674,
            x = 3,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50810,
            x = 5,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50675,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },

        {
            type = "quest",
            id = 50691,
            x = 0,
            y = 3,
            connections = {
                5, 
            },
        },
        {
            type = "quest",
            id = 50704,
            x = 2,
            y = 3,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 50696,
            x = 4,
            y = 3,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 50697,
            x = 6,
            y = 3,
            connections = {
                2, 
            },
        },
        
        {
            type = "quest",
            id = 50814,
            aside = true,
            x = 0,
            y = 4,
        },
        {
            type = "quest",
            id = 50741,
            aside = true,
            x = 3,
            y = 4,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 51140,
            x = 6,
            y = 4,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN8,
            aside = true,
            relationship = {
                breadcrumb = 50797,
                blockers = {51343, 49832},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 1,
            y = 5,
        },
        {
            type = "quest",
            id = 50753,
            aside = true,
            x = 3,
            y = 5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50774,
            aside = true,
            x = 3,
            y = 6,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50793,
            aside = true,
            x = 3,
            y = 7,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50803,
            aside = true,
            x = 0,
            y = 8,
            connections = {
            },
        },
        {
            type = "quest",
            id = 50955,
            aside = true,
            x = 2,
            y = 8,
            connections = {
            },
        },
        {
            type = "quest",
            id = 52132,
            aside = true,
            x = 4,
            y = 8,
            connections = {
            },
        },
        {
            type = "quest",
            id = 50742,
            aside = true,
            x = 6,
            y = 8,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50956,
            aside = true,
            x = 3,
            y = 9,
        },
    },
})
-- Completed, Alliance only, optional, doesnt have any requirements and leads to nothing
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN5, {
    name = { -- Circle the Wagons
        type = "quest",
        id = 52793,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 52796,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 52793,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 52795,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 52796,
        },
        {
            type = "quest",
            id = 52793,
        },
        {
            type = "quest",
            id = 52795,
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
                45250, 45650, 46000, 46400, 46750, 47150, 47500, 47900, 48350, 48750, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 200,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 141769,
            -- name = "Go to Marilyn Hood",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.601840, 0.704933, "Marilyn Hood")
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
            id = 141603,
            -- name = "Go to Mallory Hood",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.648863, 0.767777, "Mallory Hood")
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
            id = 52796,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 52793,
            x = 3,
            y = 1,
        },
        {
            type = "quest",
            id = 52795,
            x = 5,
            y = 1,
        },
    },
})
-- Completed, Alliance Only, I think this chain and/or Burton Farmstead and/or Farmer Max lead to Briarback Kraul
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN3, {
    name = BtWQuests_GetAreaName(9422), -- Goldfield Farmstead
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 50157,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50041,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50065,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50088,
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
            type = "currency",
            id = 1553,
            amount = 100,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 235,
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
                    id = 50157,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 129808,
                    -- name = "Go to Farmer Goldfield",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(942, 0.507566, 0.731545, "Farmer Goldfield")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 2,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "object",
            id = 244983,
            -- name = "Go to the Dirty Pocketwatch",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.498505, 0.735291, "Dirty Pocketwatch")
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
            id = 50041,
            x = 2,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50065,
            x = 4,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50069,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN2,
            aside = true,
            x = 1,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50088,
            x = 3,
            y = 3,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_BRIARBACK_KRAUL,
            aside = true,
            x = 2,
            y = 4,
        },
    },
})
-- Completed, alliance only, no breadcrumbs, no requirements
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN10, {
    name = {
        type = "npc",
        id = 137094,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "level",
            level = 110,
            visible = false,
        },
        {
            name = L["BTWQUESTS_BEGIN_THE_BATTLE_FOR_BRENNADAM"],
            type = "quest",
            id = 51163,
        },
    },
    active = {
        {
            type = "quest",
            id = 51310,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51314,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 51310,
        },
        {
            type = "quest",
            id = 51314,
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
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2162,
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
            id = 137094,
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 51310,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 51314,
            x = 4,
            y = 1,
        },
    },
})
-- Completed, Alliance only, except updating the optional chains at the end
--  leads to BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN3 ([50157] There's Gold in Them There Fields)
--  leads to BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN2 ([50158] Checking Out the Collapse)
--  leads to BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN7 ([52067] Survivors)
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1, {
    name = { -- The Battle for Brennadam
        type = "quest",
        id = 51534,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 51552,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49744,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49745,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49746,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51534,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 49755,
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
                106900, 107900, 108800, 109600, 110500, 111500, 112400, 113400, 114100, 115100, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 450,
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
                    id = 51552,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 130190,
                    -- name = "Sergeant Calvin",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.576072, 0.664058, "Sergeant Calvin")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 0,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 130694,
            -- name = "Go to Mayor Roz",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.576298, 0.664928, "Mayor Roz")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 49744,
            x = 0,
            y = 1,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 49745,
            x = 2,
            y = 1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 49746,
            x = 4,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51534,
            x = 6,
            y = 1,
        },

        {
            type = "quest",
            id = 49755,
            x = 2,
            y = 2,
            connections = {
                1, 2, 3,
            },
        },

        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN3,
            aside = true,
            relationship = {
                breadcrumb = 50157,
                blocker = 50041,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 0,
            y = 3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN2,
            x = 2,
            y = 3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN7,
            aside = true,
            relationship = {
                breadcrumb = 52067,
                blockers = {50908, 50910, 50909},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 4,
            y = 3,
        },
    },
})
-- Both factions
-- level 120, no requirements
-- local forgottenCoveQuestLine = {}
-- local function IsActiveCompletedOrAvailableDelay(item)
--     return forgottenCoveQuestLine.questID == item.questID or BtWQuests_IsQuestActive(item.questID) or BtWQuests_IsQuestCompleted(item.questID)
-- end
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN4, {
    name = BtWQuests_GetAreaName(9955), -- Forgotten Cove
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {120,120},
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
    },
    active = {
        {
            type = "quest",
            id = 50417,
            status = {'active', 'completed'}
        },
    },
    completed = {
        type = "quest",
        id = 53099,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2494000, 2502000, 2510000, 2518000, 2526000, 2534000, 2542000, 2550000, 2558000, 2566000, 2574000, 257400, 
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
            amount = 300,
        },
    },
    items = {
        {
            type = "quest",
            id = 50417,
            x = 3,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50386,
            x = 3,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53097,
            x = 3,
            y = 3,
            connections = {
                2, 
            },
        },
        {
            name = L["WAIT_UNTIL_AVAILABLE"],
            visible = {
                type = "quest",
                id = 53097,
            },
            restrictions = {
                type = "quest",
                id = 50387,
                status = {'notcompleted'},
            },
            active = true,
            completed = {
                type = "questline",
                id = 577,
                mapID = MAP_ID,
                questID = 50387,
            },
            -- questID = 50387,
            -- completed = function (item)
            --     local questLines = C_QuestLine.GetAvailableQuestLines(MAP_ID)
            --     for _,questLine in ipairs(questLines) do
            --         if questLine.questLineID == 577 then
            --             forgottenCoveQuestLine = questLine
            --             break
            --         end
            --     end
            --     return IsActiveCompletedOrAvailableDelay(item)
            -- end,
            x = 5,
            y = 3.5,
            connections = {
                1, 
            },
        },
        { -- Unlocks either with 7th legion rep or doing Chasing Darness or azerite level(<= 14), or because Blizzard willed it so
            type = "quest",
            id = 50387,
            x = 3,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            name = L["WAIT_UNTIL_AVAILABLE"],
            visible = {
                type = "quest",
                id = 50387,
            },
            restrictions = {
                type = "quest",
                id = 50388,
                status = {'notcompleted'},
            },
            active = true,
            completed = {
                type = "questline",
                id = 577,
                mapID = MAP_ID,
                questID = 50388,
            },
            -- questID = 50388,
            -- completed = IsActiveCompletedOrAvailableDelay,
            x = 5,
            y = 4.5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50388,
            x = 3,
            y = 5,
            connections = {
                2, 
            },
        },
        {
            name = L["WAIT_UNTIL_AVAILABLE"],
            visible = {
                type = "quest",
                id = 50388,
            },
            restrictions = {
                type = "quest",
                id = 53105,
                status = {'notcompleted'},
            },
            active = true,
            completed = {
                type = "questline",
                id = 577,
                mapID = MAP_ID,
                questID = 53105,
            },
            -- questID = 53105,
            -- completed = IsActiveCompletedOrAvailableDelay,
            x = 5,
            y = 5.5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53105,
            x = 3,
            y = 6,
            connections = {
                2, 
            },
        },
        {
            name = L["WAIT_UNTIL_AVAILABLE"],
            visible = {
                type = "quest",
                id = 53105,
            },
            restrictions = {
                type = "quest",
                id = 50385,
                status = {'notcompleted'},
            },
            active = true,
            completed = {
                type = "questline",
                id = 577,
                mapID = MAP_ID,
                questID = 50385,
            },
            -- questID = 50385,
            -- completed = IsActiveCompletedOrAvailableDelay,
            x = 5,
            y = 6.5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50385,
            x = 3,
            y = 7,
            connections = {
                2, 
            },
        },
        {
            name = L["WAIT_UNTIL_AVAILABLE"],
            visible = {
                type = "quest",
                id = 50385,
            },
            restrictions = {
                type = "quest",
                id = 50389,
                status = {'notcompleted'},
            },
            active = true,
            completed = {
                type = "questline",
                id = 577,
                mapID = MAP_ID,
                questID = 50389,
            },
            -- questID = 50389,
            -- completed = IsActiveCompletedOrAvailableDelay,
            x = 5,
            y = 7.5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50389,
            x = 3,
            y = 8,
            connections = {
                2, 
            },
        },
        {
            name = L["WAIT_UNTIL_AVAILABLE"],
            visible = {
                type = "quest",
                id = 50389,
            },
            restrictions = {
                type = "quest",
                id = 53099,
                status = {'notcompleted'},
            },
            active = true,
            completed = {
                type = "questline",
                id = 577,
                mapID = MAP_ID,
                questID = 53099,
            },
            -- questID = 53099,
            -- completed = IsActiveCompletedOrAvailableDelay,
            x = 5,
            y = 8.5,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53099,
            x = 3,
            y = 9,
        },
    },
})
-- Completed, both factions, doesnt seem to have any requirements and doesnt seem to lead anywhere
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN8, {
    name = { -- I like Turtles
        type = "quest",
        id = 51427,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 50797,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49832,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51352,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51339,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51343,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 51386,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2638400, 2692800, 2747200, 2801600, 2856000, 2910400, 2964800, 3019200, 3073600, 3128000, 3182400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                186750, 188400, 190000, 191350, 192950, 194700, 196350, 198000, 199250, 200900, 
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
            id = 2162,
            amount = 1010,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
        {
            type = "reputation",
            id = 2163,
            amount = 1085,
        },
    },
    items = {
        {
            type = "npc",
            id = 135795,
            -- name = "Go to Toki",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.405925, 0.454583, "Toki")
            -- end,
            -- breadcrumb = true,
            x = 1,
            y = 0,
            connections = {
                2,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 50797,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "quest",
                    id = 49832,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 135794,
                    -- name = "Go to Scrollsage Nola",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(942, 0.406770, 0.456041, "Scrollsage Nola")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 4,
            y = 0,
            connections = {
                2, 3,
            },
        },
        -- {
        --     type = "quest",
        --     id = 49832,
        --     x = 4,
        --     y = 0,
        --     connections = {
        --         1, 2, 3,
        --     }
        -- },
        {
            type = "quest",
            id = 51352,
            x = 1,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 51339,
            x = 3,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 51343,
            x = 5,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 53369,
            x = 2,
            y = 2,
            connections = {
            }
        },
        {
            type = "quest",
            id = 51353,
            x = 4,
            y = 2,
            connections = {
                1, 2, 3,
            }
        },
        
        {
            type = "quest",
            id = 51540,
            x = 1,
            y = 3,
            connections = {
                3,
            }
        },
        {
            type = "quest",
            id = 51371,
            x = 3,
            y = 3,
            connections = {
                3,
            }
        },
        {
            type = "quest",
            id = 51221,
            x = 5,
            y = 3,
            connections = {
                2,
            }
        },
        {
            type = "quest",
            id = 51545,
            x = 2,
            y = 4,
        },
        {
            type = "quest",
            id = 51427,
            x = 4,
            y = 4,
            connections = {
                1, 2,
            }
        },
        {
            type = "quest",
            id = 51220,
            x = 2,
            y = 5,
        },
        {
            type = "quest",
            id = 51222,
            x = 4,
            y = 5,
            connections = {
                1,
            }
        },
        {
            type = "quest",
            id = 51386,
            x = 3,
            y = 6,
        },
    },
})
-- Completed, Alliance only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN9, {
    name = {
        type = "npc",
        id = 131656,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "level",
            level = 110,
            visible = false,
        },
        {
            name = L["BTWQUESTS_BEGIN_THE_BATTLE_FOR_BRENNADAM"],
            type = "quest",
            id = 51163,
        },
    },
    active = {
        {
            type = "quest",
            id = 50797,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49960,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 49886,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 49960,
        },
        {
            type = "quest",
            id = 49886,
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
                37000, 37350, 37650, 37950, 38250, 38600, 38900, 39250, 39500, 39850, 
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
            id = 2162,
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
            id = 131656,
            -- name = "Go to Houndmaster Archibald",
            -- onClick = function()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.510161, 0.701896, "Houndmaster Archibald")
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
            id = 49960,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 49886,
            x = 4,
            y = 1,
        },
    },
})
-- Completed, Alliance Only
-- requires [btwquests:chain:80615:ffffff00:The Battle for Brennadam]
-- Breadcrumb is optional but should most likely be completed
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN2, {
    name = BtWQuests_GetAreaName(9444), -- Burton Farmstead
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1,
    },
    active = {
        {
            type = "quest",
            id = 50158,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50133,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50134,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50135,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50136,
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
                82250, 83000, 83750, 84250, 85000, 85750, 86500, 87250, 87750, 88500, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 225,
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
                    id = 50158,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 132118,
                    -- name = "Go to Farmer Burton",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(942, 0.515843, 0.659661, "Farmer Burton")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 3,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 50133,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 50134,
            x = 2,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 50135,
            x = 4,
            y = 1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 50136,
            x = 3,
            y = 2,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN3,
            aside = true,
            x = 5,
            y = 2,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_BRIARBACK_KRAUL,
            aside = true,
            x = 4,
            y = 3,
        },
    },
})
-- Completed, Alliance only, make sure no requirements
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN12, {
    name = { -- Deadliest Cache
        type = "achievement",
        id = 13053,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110, 120},
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
            id = 53045,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50376,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 52130,
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
                82200, 83000, 83600, 84400, 85000, 85800, 86400, 87200, 87800, 88600, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 600,
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
                    id = 53045,
                    restrictions = {
                        type = "quest",
                        id = 53045,
                        status = {'active', 'completed'},
                    },
                },
                {
                    type = "npc",
                    id = 133576,
                    -- name = "Go to Coxswain Hook",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.260037, 0.552169, "Coxswain Hook")
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
            id = 50376,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50391,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50418,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52130,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, Alliance Only, no requirements, has 1 breadcrumb as an aside from BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN6, {
    name = { -- Mayhem at Mildenhall Meadery
        type = "quest",
        id = 50343,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 51582,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50343,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 50553,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2560800, 2613600, 2666400, 2719200, 2772000, 2824800, 2877600, 2930400, 2983200, 3036000, 3088800, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                192450, 194200, 195850, 197250, 198900, 200650, 202400, 204150, 205350, 207100, 
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
            id = 2162,
            amount = 750,
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
                    id = 51582,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 131793,
                    -- name = "Go to Ancel Mildenhall",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(942, 0.688853, 0.651630, "Ancel Mildenhall")
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
            id = 50343,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50070,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50359,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50064,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50161,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50168,
            x = 2,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50162,
            x = 4,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50504,
            x = 3,
            y = 6,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 50165,
            x = 0,
            y = 7,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50534,
            x = 2,
            y = 7,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50264,
            x = 4,
            y = 7,
        },
        {
            type = "quest",
            id = 50493,
            x = 6,
            y = 7,
        },
        {
            type = "quest",
            id = 50553,
            x = 3,
            y = 8,
        },
    },
})
-- Completed, Alliance Only, Optional
--  breadcrumb from BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1 ([52067] Survivors)
--  leads to BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CYCLE_OF_HATRED ([52065] Worse Than It Looks)
--  leads to BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_TREASURE_IN_DEADWASH ([51554] Reloading)
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN7, {
    name = { -- Survivors
        type = "quest",
        id = 52067,
    },
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    active = {
        {
            type = "quest",
            id = 52065,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50908,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50910,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 50909,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51159,
            status = {'active', 'completed'},
        },
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    completed = {
        {
            type = "quest",
            id = 50908,
        },
        {
            type = "quest",
            id = 50910,
        },
        {
            type = "quest",
            id = 50909,
        },
        {
            type = "quest",
            id = 51159,
        },
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
                96250, 97100, 97900, 98650, 99450, 100350, 101200, 102050, 102700, 103550, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 165,
        },
        {
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 625,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "quest",
            id = 52067,
            visible = {
                type = "quest",
                id = 52067,
                status = {'active', 'completed'}
            },
            x = 3,
            y = 0,
            connections = {
                4, 5, 6, 7,
            },
        },
        {
            type = "npc",
            id = 135682,
            -- name = "Go to Patrick Eckhart",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.578504, 0.553204, "Patrick Eckhart")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 52067,
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 52067,
                    status = {'notcompleted'}
                },
            },
            x = 1,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "npc",
            id = 135874,
            -- name = "Go to Lea Martinel",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(MAP_ID, 0.579519, 0.555802, "Lea Martinel")
            -- end,
            -- breadcrumb = true,
            visible = {
                {
                    type = "quest",
                    id = 52067,
                    status = {'notactive'}
                },
                {
                    type = "quest",
                    id = 52067,
                    status = {'notcompleted'}
                },
            },
            x = 4,
            y = 0,
            connections = {
                4, 5,
            },
        },

        

        {
            type = "quest",
            id = 51217,
            aside = true,
            x = 6,
            y = 0,
        },


        {
            type = "quest",
            id = 50908,
            x = 0,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50910,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50909,
            x = 4,
            y = 1,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 51159,
            x = 6,
            y = 1,
        },

        
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CYCLE_OF_HATRED,
            aside = true,
            relationship = {
                breadcrumb = 52065,
                blockers = {51711, 51752},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 2,
            y = 2,
        },
        
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_TREASURE_IN_DEADWASH,
            aside = true,
            relationship = {
                breadcrumb = 51554,
                blockers = {50802, 50674, 50810},
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            x = 4,
            y = 2,
        },
    },
})
-- completed, alliance only, no requirements, 1 breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN11, {
    name = BtWQuests_GetAreaName(9402), -- Millstone Hamlet
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 51218,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51214,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51251,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51492,
            status = {'active', 'completed'},
        },
        {
            type = "quest",
            id = 51205,
            status = {'active', 'completed'},
        },
    },
    completed = {
        {
            type = "quest",
            id = 51208,
        },
        {
            type = "quest",
            id = 51209,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2929400, 2989800, 3050200, 3110600, 3171000, 3231400, 3291800, 3352200, 3412600, 3473000, 3533400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                211350, 213300, 215100, 216650, 218450, 220400, 222250, 224200, 225550, 227500, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 165,
        },
        {
            type = "reputation",
            id = 2162,
            amount = 1225,
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
                    id = 51218,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 136658,
                    -- name = "Marie Davenport",
                    -- onClick = function ()
                    --     BtWQuests_ShowMapWithWaypoint(942, 0.303383, 0.668032, "Marie Davenport")
                    -- end,
                    -- breadcrumb = true,
                },
            },
            x = 0,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 136574,
            -- name = "Go to Charles Davenport",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.297903, 0.671066, "Charles Davenport")
            -- end,
            -- breadcrumb = true,
            x = 4,
            y = 0,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 51214,
            x = 0,
            y = 1,
            connections = {
                5,
            },
        },
        {
            type = "quest",
            id = 51251,
            x = 2,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 51492,
            x = 4,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 51205,
            x = 6,
            y = 1,
            connections = {
                2,
            },
        },

        {
            type = "object",
            id = 287958,
            -- name = "Go to the Bulletin Board",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.306864, 0.681406, "Bulletin Board")
            -- end,
            -- breadcrumb = true,
            x = 0,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 51215,
            x = 2,
            y = 2.5,
            connections = {
                5,
            },
        },
        {
            type = "npc",
            id = 136414,
            -- name = "Go to Shepherd Milbrooke",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.318554, 0.695202, "Shepherd Milbrooke")
            -- end,
            -- breadcrumb = true,
            aside = true,
            x = 5,
            y = 2,
            connections = {
                2, 3,
            },
        },

        {
            type = "quest",
            id = 51204,
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 51200,
            aside = true,
            x = 4,
            y = 3,
        },
        {
            type = "quest",
            id = 51203,
            aside = true,
            x = 6,
            y = 3,
        },


        {
            type = "quest",
            id = 51335,
            x = 2,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 51207,
            x = 1,
            y = 5,
        },
        {
            type = "quest",
            id = 51504,
            x = 3,
            y = 5,
            connections = {
                1, 2,
            },
        },

        
        {
            type = "quest",
            id = 51208,
            x = 2,
            y = 6,
        },
        {
            type = "quest",
            id = 51209,
            x = 4,
            y = 6,
        },
    },
})
-- completed, horde only, no requirements, 1 breadcrumbs
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN13, {
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
        id = 53330,
        status = {'active', 'completed'},
    },
    completed = {
        {
            type = "quest",
            id = 53330,
        },
        {
            type = "quest",
            id = 53348,
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
                45250, 45650, 46000, 46400, 46750, 47200, 47550, 47950, 48300, 48700, 
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
    },
    items = {
        {
            type = "object",
            id = 297492,
            -- name = "Go to the Bulletin Board",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(942, 0.51, 0.336, "Bulletin Board")
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
            id = 53330,
            x = 2,
        },
        {
            type = "quest",
            id = 53348,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_OTHER_ALLIANCE, {
    name = "Other Alliance",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {1,60},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- Not sure where to put this
            type = "quest",
            id = 49730,
        },
        { -- Probably a breadcrumb to From the Depths They Come after the Treasure in Deadwash
            type = "quest",
            id = 52068,
        },
        {
            type = "quest",
            id = 52876,
        },
        {
            type = "quest",
            id = 53347,
        },
        {
            type = "quest",
            id = 53371,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_OTHER_HORDE, {
    name = "Other Horde",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_OTHER_BOTH, {
    name = "Other Both",
    category = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
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
            id = 51557,
        },
        {
            type = "quest",
            id = 50690,
        },
        {
            type = "quest",
            id = 50779,
        },
        {
            type = "quest",
            id = 51354,
        },
        {
            type = "quest",
            id = 52782,
        },
        {
            type = "quest",
            id = 53330,
        },
        {
            type = "quest",
            id = 53348,
        },
        {
            type = "quest",
            id = 50601,
        },
        {
            type = "quest",
            id = 50743,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    buttonImage = 2178271,
    listImage = {
        texture = "Interface\\Addons\\BtWQuestsBattleForAzeroth\\UI-CategoryButton",
        texCoords = {0, 0.7353515625, 0.3515625, 0.46875},
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_STORMSONG_VALLEY_FOOTHOLD,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_DEATH_OF_A_TIDESAGE,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_TIDESAGES_OF_STORMSONG,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_A_HOUSE_IN_PERIL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_THE_GROWING_TEMPEST,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_AT_THE_EDGE_OF_MADNESS,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CYCLE_OF_HATRED,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_FROM_THE_DEPTHS_THEY_COME,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN2,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN3,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_BRIARBACK_KRAUL,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_TREASURE_IN_DEADWASH,
        },


        {
            type = "header",
            name = L["BTWQUESTS_SIDE_QUESTS"],
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN4,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN5,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN6,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN7,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN9,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN10,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN11,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN12,
        },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_OTHER_ALLIANCE,
        -- },
        -- {
        --     type = "chain",
        --     id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_OTHER_BOTH,
        -- },
    },
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
})

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN5,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN6,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN7,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN8,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN9,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN10,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN11,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY_CHAIN12,
    },
})