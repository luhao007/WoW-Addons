local L = BtWQuests.L;
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_PRIDE_OF_KULTIRAS, {
    name = { -- The Pride of Kul Tiras
        type = "achievement",
        id = 12997,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_A_BARGIN_OF_BLOOD,
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "achievement",
            id = 12473,
            anyone = true,
        },
        {
            type = "achievement",
            id = 12497,
            anyone = true,
        },
        {
            type = "achievement",
            id = 12496,
            anyone = true,
        },
        {
            type = "level",
            level = 120,
        },
    },
    active = {
        type = "quest",
        id = 52194,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 51445,
    },
    rewards = {
        {
            name = L["DUNGEON_SIEGE_OF_BORALUS"],
        },
        {
            type = "money",
            amounts = {
                7394400, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "currency",
            id = 1553,
            amount = 4550,
        },
    },
    items = {
        {
            name = {
                type = "achievement",
                id = 12473,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
            completed = {
                type = "achievement",
                id = 12473,
                anyone = true,
            },
            x = 1,
            y = 0,
            connections = {
                3,
            },
        },
        {
            name = {
                type = "achievement",
                id = 12497,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_DRUSTVAR,
            completed = {
                type = "achievement",
                id = 12497,
                anyone = true,
            },
            x = 3,
            y = 0,
            connections = {
                2,
            },
        },
        {
            name = {
                type = "achievement",
                id = 12496,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
            completed = {
                type = "achievement",
                id = 12496,
                anyone = true,
            },
            x = 5,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52194,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52246,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52762,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52252,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52253,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52311,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52445,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52449,
            x = 3,
            y = 8,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52453,
            x = 3,
            y = 9,
            connections = {
                1, 2,
            },
        },

        {
            type = "quest",
            id = 52509,
            x = 2,
            y = 10,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 52508,
            x = 4,
            y = 10,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52510,
            x = 3,
            y = 11,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52511,
            x = 3,
            y = 12,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52512,
            x = 3,
            y = 13,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52513,
            x = 3,
            y = 14,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52481,
            x = 3,
            y = 15,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52482,
            x = 3,
            y = 16,
            connections = {
                1, 2, 3,
            },
        },
        
        {
            type = "quest",
            id = 52483,
            x = 1,
            y = 17,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 52484,
            x = 3,
            y = 17,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 52485,
            x = 5,
            y = 17,
            connections = {
                1,
            },
        },
        
        {
            type = "quest",
            id = 52486,
            x = 3,
            y = 18,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52487,
            x = 3,
            y = 19,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52488,
            x = 3,
            y = 20,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51445,
            x = 3,
            y = 21,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_A_NATION_UNITED,
            aside = true,
            x = 3,
            y = 22,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_A_NATION_UNITED, {
    name = { -- A Nation United
        type = "achievement",
        id = 12891,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_ZANDALAR_FOREVER,
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "achievement",
            id = 12473,
            anyone = true,
        },
        {
            type = "achievement",
            id = 12497,
            anyone = true,
        },
        {
            type = "achievement",
            id = 12496,
            anyone = true,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_PRIDE_OF_KULTIRAS,
        },
    },
    completed = {
        type = "quest",
        id = 52151,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1010000, 1026000, 1042000, 1058000, 1074000, 1090000, 1106000, 1122000, 1138000, 1154000, 1170000, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                32900, 33200, 33450, 33750, 34000, 34300, 34600, 34850, 35150, 35400, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 750,
        },
        {
            type = "reputation",
            id = 2160,
            amount = 425,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
            completed = {
                type = "achievement",
                id = 12473,
                anyone = true,
            },
            x = 1,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_DRUSTVAR,
            completed = {
                type = "achievement",
                id = 12497,
                anyone = true,
            },
            x = 3,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
            completed = {
                type = "achievement",
                id = 12496,
                anyone = true,
            },
            x = 5,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_PRIDE_OF_KULTIRAS,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52153,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52151,
            x = 3,
            y = 3,
        },
        {
            type = "quest",
            id = 53128,
            aside = true,
            x = 5,
            y = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_A_BARGIN_OF_BLOOD, {
    name = {
        type = "achievement",
        id = 12480,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_PRIDE_OF_KULTIRAS,
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "achievement",
            id = 11861,
            anyone = true,
        },
        {
            type = "achievement",
            id = 11868,
            anyone = true,
        },
    },
    active = {
        type = "quest",
        id = 47199,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 47229,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1717400, 1752800, 1788200, 1823600, 1859000, 1894400, 1929800, 1965200, 2000600, 2036000, 2071400, 
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                120900, 122000, 123000, 123950, 124950, 126050, 127100, 128200, 129050, 130150, 
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 785,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            name = {
                type = "achievement",
                id = 11861,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
            completed = {
                type = "achievement",
                id = 11861,
                anyone = true,
            },
            x = 2,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            name = {
                type = "achievement",
                id = 11868,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
            completed = {
                type = "achievement",
                id = 11868,
                anyone = true,
            },
            x = 4,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47199,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47200,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47198,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47201,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 47204,
            x = 2,
            y = 4,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 47205,
            x = 4,
            y = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 47229,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47258,
            aside = true,
            x = 3,
            y = 6,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_ZANDALAR_FOREVER, {
    name = { -- Zandalar Forever!
        type = "quest",
        id = 50954,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_A_NATION_UNITED,
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "achievement",
            id = 11861,
            anyone = true,
        },
        {
            type = "achievement",
            id = 11868,
            anyone = true,
        },
        {
            type = "achievement",
            id = 12478,
            anyone = true,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_A_BARGIN_OF_BLOOD,
        },
    },
    completed = {
        type = "quest",
        id = 50954,
    },
    rewards = {
        {
            name = L["DUNGEON_KINGS_REST"],
        },
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
            type = "reputation",
            id = 2103,
            amount = 250,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            name = {
                type = "achievement",
                id = 11861,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
            completed = {
                type = "achievement",
                id = 11861,
                anyone = true,
            },
            x = 3,
            y = 0,
            connections = {
                3, 
            },
        },
        {
            name = {
                type = "achievement",
                id = 11868,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
            completed = {
                type = "achievement",
                id = 11868,
                anyone = true,
            },
            x = 5,
            y = 0,
            connections = {
                2, 
            },
        },
        {
            name = {
                type = "achievement",
                id = 12478,
            },
            type = "category",
            id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
            completed = {
                type = "achievement",
                id = 12478,
                anyone = true,
            },
            x = 2,
            y = 1,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_A_BARGIN_OF_BLOOD,
            x = 4,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "npc",
            id = 135890,
            -- name = "Go to King Rastakhan",
            -- onClick = function ()
            --     BtWQuests_ShowMapWithWaypoint(862, 0.600533, 0.222359, "King Rastakhan")
            -- end,
            -- breadcrumb = true,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50954,
            x = 3,
            y = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_IN_TELDRASSILS_SHADOW, {
    name = { -- In Teldrassil's Shadow
        type = "achievement",
        id = 13251,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {120,120},
    crest = "alliance",
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_TROUBLE_IN_DARKSHORE
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_ALLIANCE,
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
            visible = false,
        },
    },
    active = {
        {
            type = "quest",
            id = 53847,
            status = {'active', 'completed'},
        },
    },
    completed = {
        type = "quest",
        id = 54871,
    },
    rewards = {
        {
            name = L["BTWQUESTS_WARFRONT_THE_BATTLE_FOR_DARKSHORE"],
        },
        {
            name = L["BTWQUESTS_NIGHT_WARRIOR_NIGHT_ELF_CUSTOMIZATION"],
        },
        {
            type = "money",
            amounts = {
                1123200, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    items = {
        {
            type = "quest",
            id = 53847,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53849,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53988,
            x = 3,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 53989,
            x = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 54041,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53990,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54871,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_HIGH_OVERLORD, {
    name = { -- The High Overlord
        type = "quest",
        id = 54099,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
    },
    active = {
        type = "quest",
        id = 54097,
        status = {'active', 'completed'}
    },
    completed = {
        type = "quest",
        ids = {54109, 54754},
    },
    rewards = {
        {
            type = "toy",
            id = 165791,
        },
        {
            type = "money",
            amounts = {
                1638000, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    items = {
        {
            type = "quest",
            id = 54097,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54099,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54100,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54101,
            x = 3,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 54102,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54103,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54104,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54105,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54106,
            x = 3,
            y = 8,
            connections = {
                1,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 54754,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "quest",
                    id = 54107,
                },
            },
            x = 3,
            y = 9,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54108,
            visible = {
                {
                    type = "quest",
                    id = 54754,
                    status = {'notactive'},
                },
                {
                    type = "quest",
                    id = 54754,
                    status = {'notcompleted'},
                },
            },
            -- visible = function(_, character)
            --     return not (character:IsQuestActive(54754) or character:IsQuestCompleted(54754))
            -- end,
            x = 3,
            y = 10,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 54109,
            visible = {
                {
                    type = "quest",
                    id = 54754,
                    status = {'notactive'},
                },
                {
                    type = "quest",
                    id = 54754,
                    status = {'notcompleted'},
                },
            },
            -- visible = function(_, character)
            --     return not (character:IsQuestActive(54754) or character:IsQuestCompleted(54754))
            -- end,
            x = 3,
            y = 11,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_FALLEN_CHIEFTAIN, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(12719, 1), -- The Fallen Chieftain
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "achievement",
            id = 12481,
            anyone = true,
        },
        {
            type = "reputation",
            id = 2103,
            standing = 7,
        },
    },
    active = {
        type = "quest",
        id = 51513,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 51517,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2620800, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "currency",
            id = 1553,
            amount = 750,
        },
        {
            type = "reputation",
            id = 530,
            amount = 1970,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 1970,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            name = {
                type = "achievement",
                id = 12481,
            },
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_ZANDALAR_FOREVER,
            completed = {
                type = "achievement",
                id = 12481,
                anyone = true,
            },
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51513,
            x = 3,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 51514,
            x = 2,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 51533,
            x = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51515,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 52114,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 52113,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51516,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51517,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_JUSTICE_FOR_THE_FALLEN,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_JUSTICE_FOR_THE_FALLEN, {
    name = BtWQuests_GetAchievementCriteriaNameDelayed(12719, 2), -- Justice for the Fallen
    category = nil,
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
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_FALLEN_CHIEFTAIN,
        },
    },
    active = {
        type = "quest",
        id = 51518,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 51521,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1216800, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "reputation",
            id = 530,
            amount = 770,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 770,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_FALLEN_CHIEFTAIN,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51518,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51519,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51520,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 51521,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_BLOOD_ELF_HERITAGE, {
    name = { -- The Pride of the Sin'dorei
        type = "quest",
        id = 53791,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    crest = "blood-elf",
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_DWARF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_GNOME_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_TAUREN_HERITAGE,
    },
    restrictions = {
        {
            type = "race",
            id = BTWQUESTS_RACE_ID_BLOOD_ELF,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
        {
            type = "reputation",
            id = 911,
            standing = 8,
        },
    },
    active = {
        type = "quest",
        id = 53791,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 54096,
        x = 3,
    },
    rewards = {
        {
            name = L["BTWQUESTS_HERITAGE_OF_THE_SINDOREI"],
        },
        {
            type = "money",
            amounts = {
                1965600, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    range = {110},
    items = {
        {
            type = "quest",
            id = 53791,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53734,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53882,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53735,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53736,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53737,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53738,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53725,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53853,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54096,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_DWARF_HERITAGE, {
    name = { -- Legacy of the Bronzebeard
        type = "quest",
        id = 53846,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    crest = "dwarf",
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_BLOOD_ELF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_DWARF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_GNOME_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_TAUREN_HERITAGE,
    },
    restrictions = {
        {
            type = "race",
            id = BTWQUESTS_RACE_ID_DWARF,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
        {
            type = "reputation",
            id = 47,
            standing = 8,
        },
    },
    active = {
        type = "quest",
        id = 53838,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 53846,
    },
    rewards = {
        {
            name = L["BTWQUESTS_HERITAGE_OF_THE_BRONZEBEARD"],
        },
        {
            type = "money",
            amounts = {
                2176200, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    range = {120},
    items = {
        {
            type = "quest",
            id = 53838,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53835,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53836,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53837,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53841,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53840,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53844,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53842,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53845,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53846,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_TROUBLE_IN_DARKSHORE, {
    name = { -- Trouble in Darkshore
        type = "quest",
        id = 54042,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    major = true,
    crest = "horde",
    range = {110,120},
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_IN_TELDRASSILS_SHADOW
    },
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
    },
    active = {
        type = "quest",
        id = 54042,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 54416,
    },
    rewards = {
        {
            type = "toy",
            id = 166544,
        },
        {
            type = "toy",
            id = 166678,
        },
        {
            name = L["BTWQUESTS_WARFRONT_THE_BATTLE_FOR_DARKSHORE"],
        },
        {
            type = "money",
            amounts = {
                1521000, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    items = {
        {
            type = "quest",
            id = 54042,
            x = 3,
            connections = {
                1, 2, 3, 
            },
        },
        {
            type = "quest",
            id = 54043,
            x = 1,
            connections = {
                4, 
            },
        },
        {
            type = "quest",
            id = 54044,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 54045,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 54046,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54059,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54047,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54049,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54050,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54416,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_NECK_LEVEL, {
    name = { -- A One-Way Ticket to the Heart
        type = "quest",
        id = 54964,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {120},
    prerequisites = {
        {
            type = "quest",
            id = 53406,
        },
    },
    active = {
        type = "quest",
        id = 54938,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 54964,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                491400, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "reputation",
            id = 2164,
            amount = 510,
        },
    },
    items = {
        {
            type = "quest",
            id = 54938,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54939,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54940,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54964,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_SOMETHING_SOMETHING_PARROT, {
    name = { -- Some Reassembly Required
        type = "quest",
        id = 53816,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_INTRODUCTION,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_INTRODUCTION,
        },
        { -- Not sure this is intended
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_8_1_5_PART_1,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_8_1_PART_4,
        },
    },
    active = {
        type = "quest",
        ids = {53815, 53817},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {53820, 53821},
    },
    rewards = {
        {
            type = "pet",
            id = 2526,
        },
        {
            type = "money",
            amounts = {
                702000, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 53815,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 53817,
                },
            },
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53816,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53818,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53819,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 53820,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 53821,
                },
            },
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_HATI, {
    name = { -- Bonds of Thunder
        type = "quest",
        id =  54919,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_HUNTER,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
    },
    active = {
        type = "quest",
        ids = {54913},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {55195},
    },
    rewards = {
        {
            name = L["BTWQUESTS_HATI_REBORN"],
        },
        {
            type = "money",
            amounts = {
                1123200, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    items = {
        {
            type = "npc",
            id = 152002,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54913,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54915,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54916,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54917,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54918,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54919,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54920,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 55195,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_HORDE_VOLJIN, {
    name = { -- The Shadow Hunter
        type = "achievement",
        id = 13263,
    },
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {120,120},
    restrictions = {
        type = "faction",
        id = BTWQUESTS_FACTION_ID_HORDE,
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_JUSTICE_FOR_THE_FALLEN,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_CAMPAIGN_8_1,
        },
        {
            type = "reputation",
            id = 2103,
            standing = 8,
        },
    },
    active = {
        type = "quest",
        ids = {53774},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {53782},
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2457000, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "currency",
            id = 1553,
            amount = 2750,
        },
        {
            type = "reputation",
            id = 530,
            amount = 2360,
        },
        {
            type = "reputation",
            id = 2103,
            amount = 2360,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Horde,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 141555,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53774,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53775,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53776,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53778,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54120,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53777,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53779,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54145,
            x = 3,
            connections = {
                1, 2, 
            },
        },
        {
            type = "quest",
            id = 53780,
            x = 2,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 53781,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54147,
            x = 4,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53782,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_XALATATH, {
    name = L["BTWQUESTS_GIFT_OF_NZOTH"],
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {120,120},
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
    },
    active = {
        type = "quest",
        ids = {54141, 54172},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {54126, 53763},
    },
    rewards = {
        {
            type = "money",
            amounts = {
                936000, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "currency",
            id = 1553,
            amount = 550,
        },
    },
    items = {
        {
            name = L["BTWQUESTS_GIFT_OF_NZOTH_BREADCRUMB"],
            breadcrumb = true,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            ids = {
                54141, 54172, 
            },
            x = 3,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 54265,
                    restrictions = {
                        {
                            type = "class",
                            id = BTWQUESTS_CLASS_ID_PRIEST,
                        },
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 54144,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 54433,
                    restrictions = {
                        type = "class",
                        id = BTWQUESTS_CLASS_ID_PRIEST,
                    },
                },
                {
                    type = "quest",
                    id = 54174,
                },
            },
            x = 3,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 54114,
                    restrictions = {
                        {
                            type = "class",
                            id = BTWQUESTS_CLASS_ID_PRIEST,
                        },
                        {
                            type = "faction",
                            id = BTWQUESTS_FACTION_ID_ALLIANCE,
                        },
                    },
                },
                {
                    type = "quest",
                    id = 54113,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 54118,
                    restrictions = {
                        type = "class",
                        id = BTWQUESTS_CLASS_ID_PRIEST,
                    },
                },
                {
                    type = "quest",
                    id = 54117,
                },
            },
            x = 3,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 54058,
                    restrictions = {
                        type = "class",
                        id = BTWQUESTS_CLASS_ID_PRIEST,
                    },
                },
                {
                    type = "quest",
                    id = 53760,
                },
            },
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53761,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 53762,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 54126,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 53763,
                },
            },
            x = 3,
            connections = {
                1, 2, 
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 54438,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 54439,
                },
            },
            x = 2,
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 53765,
                    restrictions = {
                        type = "faction",
                        id = BTWQUESTS_FACTION_ID_ALLIANCE,
                    },
                },
                {
                    type = "quest",
                    id = 53766,
                },
            },
        },
    },
})


BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_GNOME_HERITAGE, {
    name = { -- Gnomeregan's Finest
        type = "quest",
        id = 54576,
    },
    questline = 858,
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    crest = "gnome",
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_BLOOD_ELF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_DWARF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_TAUREN_HERITAGE,
    },
    restrictions = {
        {
            type = "race",
            id = BTWQUESTS_RACE_ID_GNOME,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
        {
            type = "reputation",
            id = 54,
            standing = 8,
        },
    },
    active = {
        type = "quest",
        id = 54402,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 54642,
    },
    rewards = {
        {
            name = L["BTWQUESTS_HERITAGE_OF_GNOMEREGAN"],
        },
        {
            type = "money",
            amounts = {
                2925000, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    range = {120},
    items = {
        {
            type = "npc",
            id = 147939,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54402,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54576,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54577,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54580,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54581,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54582,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54639,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54640,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54850,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54641,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54642,
            x = 3,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_TAUREN_HERITAGE, {
    name = { -- The Spiritwalkers
        type = "quest",
        id = 54760,
    },
    questline = 860,
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    crest = "tauren",
    alternatives = {
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_BLOOD_ELF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_DWARF_HERITAGE,
        BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_GNOME_HERITAGE,
    },
    restrictions = {
        {
            type = "race",
            id = BTWQUESTS_RACE_ID_TAUREN,
        },
    },
    prerequisites = {
        {
            type = "level",
            level = 120,
        },
        {
            type = "reputation",
            id = 81,
            standing = 8,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_CAMPAIGN_8_2,
        },
    },
    active = {
        type = "quest",
        id = 54759,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 54765,
    },
    rewards = {
        {
            name = L["BTWQUESTS_HERITAGE_OF_THE_SHUHALO"],
        },
        {
            type = "money",
            amounts = {
                1474200, 
            },
            minLevel = 120,
            maxLevel = 120,
        },
    },
    range = {120},
    items = {
        {
            type = "npc",
            id = 149088,
            x = 3,
            y = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54759,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54760,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54761,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54762,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54763,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54764,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54766,
            x = 3,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 54765,
            x = 3,
        },
    },
})

BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_OTHER_ALLIANCE, {
    name = "Other Alliance",
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        {
            type = "level",
            level = 110,
            visible = false,
        },
    },
    active = false,
    items = {
        {
            type = "quest",
            id = 51052,
        },
        {
            type = "quest",
            id = 51425,
        },
        {
            type = "quest",
            id = 51483,
        },
        {
            type = "quest",
            id = 51486,
        },
        {
            type = "quest",
            id = 53063,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_OTHER_HORDE, {
    name = "Other Horde",
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        {
            type = "level",
            level = 110,
            visible = false,
        },
    },
    active = false,
    items = {
        {
            type = "quest",
            id = 51465,
        },
        {
            type = "quest",
            id = 51484,
        },
        {
            type = "quest",
            id = 51485,
        },
        {
            type = "quest",
            id = 52990,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_OTHER_BOTH, {
    name = "Other Both",
    category = nil,
    expansion = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
    range = {110,120},
    prerequisites = {
        {
            type = "level",
            level = 110,
            visible = false,
        },
    },
    active = false,
    items = {
        {
            type = "quest",
            id = 48237,
        },
        {
            type = "quest",
            id = 49411,
        },
        {
            type = "quest",
            id = 49753,
        },
        {
            type = "quest",
            id = 49759,
        },
        {
            type = "quest",
            id = 50520,
        },
        {
            type = "quest",
            id = 51342,
        },
        {
            type = "quest",
            id = 51370,
        },
        {
            type = "quest",
            id = 52212,
        },
        {
            type = "quest",
            id = 52450,
        },
        {
            type = "quest",
            id = 52965,
        },
        {
            type = "quest",
            id = 53011,
        },
        {
            type = "quest",
            id = 53096,
        },
    },
})

-- Added like this to make sure the characters factions zones are first
BtWQuestsDatabase:AddExpansionItems(BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH, {
    {
        type = "header",
        name = L["ALLIANCE_ZONES"],
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_DRUSTVAR,
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_ALLIANCE,
        },
    },

    {
        type = "header",
        name = L["HORDE_ZONES"],
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_ZULDAZAR,
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_NAZMIR,
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_VOLDUN,
    },

    {
        type = "header",
        name = L["ALLIANCE_ZONES"],
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_HORDE,
        },
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_TIRAGARDE_SOUND,
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_HORDE,
        },
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_DRUSTVAR,
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_HORDE,
        },
    },
    {
        type = "category",
        id = BTWQUESTS_CATEGORY_BATTLE_FOR_AZEROTH_STORMSONG_VALLEY,
        restrictions = {
            type = "faction",
            id = BTWQUESTS_FACTION_ID_HORDE,
        },
    },
    
    {
        type = "header",
        name = L["OTHER"],
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_PRIDE_OF_KULTIRAS,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_A_NATION_UNITED,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_A_BARGIN_OF_BLOOD,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_ZANDALAR_FOREVER,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_FALLEN_CHIEFTAIN,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_JUSTICE_FOR_THE_FALLEN,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_THE_HIGH_OVERLORD,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_ALLIANCE_IN_TELDRASSILS_SHADOW,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_HORDE_TROUBLE_IN_DARKSHORE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_BLOOD_ELF_HERITAGE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_DWARF_HERITAGE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_GNOME_HERITAGE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_2_TAUREN_HERITAGE,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_SOMETHING_SOMETHING_PARROT,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_HATI,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_HORDE_VOLJIN,
    },
    {
        type = "chain",
        id = BTWQUESTS_CHAIN_BATTLE_FOR_AZEROTH_8_1_5_XALATATH,
    },
})

BtWQuestsDatabase:AddMap(1473, {
    type = "expansion",
    id = BTWQUESTS_EXPANSION_BATTLE_FOR_AZEROTH,
})