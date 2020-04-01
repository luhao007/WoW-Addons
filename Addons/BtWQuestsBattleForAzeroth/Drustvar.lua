local BtWQuests = BtWQuests;
local L = BtWQuests.L;
local Database = BtWQuests.Database;
local EXPANSION_ID = BtWQuests.Constant.Expansions.BattleForAzeroth;
local CATEGORY_ID = BtWQuests.Constant.Category.BattleForAzeroth.Drustvar;
local Chain = BtWQuests.Constant.Chain.BattleForAzeroth.Drustvar;
local ALLIANCE_ID, HORDE_ID = BtWQuests.Constant.Faction.Alliance, BtWQuests.Constant.Faction.Horde;
local MAP_ID = 896
local ACHIEVEMENT_ID = 12497
local CONTINENT_ID = 876

BtWQuestsDatabase:AddChain(Chain.TheFinalEffigy, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40168,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = BtWQuests.Constant.Chain.BattleForAzeroth.AllianceIntroduction,
        },
    },
    active = {
        type = "quest",
        id = 47961,
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        id = 47982,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1396800, 1425600, 1454400, 1483200, 1512000, 1540800, 1569600, 1598400, 1627200, 1656000, 1684800,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                92100, 92950, 93700, 94450, 95200, 96050, 96850, 97700, 98300, 99150,
            },
            minLevel = 110,
            maxLevel = 119,
        },
    },
    items = {
        {
            type = "quest",
            id = 47961,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            ids = {48622, 53434},
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        -- { -- Removed?
        --     type = "quest",
        --     id = 47969,
        --     aside = true,
        --     x = 1,
        --     y = 2,
        -- },
        {
            type = "quest",
            id = 47968,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47978,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 47979,
            x = 1,
            y = 4,
        },
        {
            type = "quest",
            id = 47981,
            x = 3,
            y = 4,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 47980,
            x = 5,
            y = 4,
        },
        {
            type = "quest",
            id = 47982,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
            aside = true,
            x = 3,
            y = 6,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.TheBurdenOfProof, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40169,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
    },
    active = {
        type = "chain",
        id = Chain.TheFinalEffigy,
    },
    completed = {
        type = "quest",
        id = 48198,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1707200, 1742400, 1777600, 1812800, 1848000, 1883200, 1918400, 1953600, 1988800, 2024000, 2059200,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                132450, 133600, 134700, 135750, 136850, 138050, 139300, 140450, 141300, 142450,
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
            id = 2161,
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
            id = Chain.TheFinalEffigy,
            x = 3,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51547,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 48108,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "chain",
            id = Chain.Chain07,
            x = 4,
            y = 1,
        },
        {
            type = "chain",
            id = Chain.Chain06,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 48283,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48109,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48110,
            x = 4,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48111,
            x = 3,
            y = 4,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48113,
            x = 0,
            y = 5,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 48170,
            x = 2,
            y = 5,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48165,
            x = 4,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49242,
            aside = true,
            x = 6,
            y = 5,
        },
        {
            type = "quest",
            id = 48198,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
            aside = true,
            x = 3,
            y = 7,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.AnAirtightAlibi, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40170,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
    },
    active = {
        type = "chain",
        id = Chain.TheBurdenOfProof,
    },
    completed = {
        type = "quest",
        id = 48538,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2386200, 2435400, 2484600, 2533800, 2583000, 2632200, 2681400, 2730600, 2779800, 2829000, 2878200,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                165300, 166800, 168150, 169500, 170850, 172350, 173850, 175350, 176400, 177900,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 100,
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48171,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48518,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49295,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48519,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 48521,
            x = 0,
            y = 4,
            connections = {
                4, 5,
            },
        },
        {
            type = "quest",
            id = 48520,
            x = 2,
            y = 4,
            connections = {
                3, 4,
            },
        },
        {
            type = "quest",
            id = 48522,
            x = 4,
            y = 4,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 48525,
            aside = true,
            x = 6,
            y = 4,
        },
        {
            type = "quest",
            id = 48523,
            x = 2,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48524,
            x = 4,
            y = 5,
        },
        {
            type = "quest",
            id = 48538,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
            aside = true,
            x = 3,
            y = 7,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.TheOrderOfEmbers, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40171,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
    },
    active = {
        type = "chain",
        id = Chain.AnAirtightAlibi,
    },
    completed = {
        type = "quest",
        id = 48946,
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
                145600, 146900, 148150, 149200, 150450, 151800, 153100, 154400, 155350, 156650,
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
            id = 2161,
            amount = 3500,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49259,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48941,
            x = 3,
            y = 2,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "chain",
            id = Chain.Chain09,
            relationship = {
                breadcrumb = 48947,
                blocker = 52074,
            },
            visible = BtWQuestsItem_RelationshipSourceVisible,
            active = BtWQuestsItem_RelationshipSourceActive,
            aside = true,
            x = 5,
            y = 2,
        },
        {
            type = "quest",
            id = 48942,
            x = 2,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48943,
            x = 4,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51134,
            aside = true,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 48963,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48944,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48945,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48946,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
            aside = true,
            x = 3,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.ANewOrder, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40172,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
    },
    active = {
        type = "chain",
        id = Chain.TheOrderOfEmbers,
    },
    completed = {
        type = "quest",
        id = 49807,
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
                98750, 99600, 100350, 101250, 102000, 103000, 103750, 104600, 105400, 106250,
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
            id = 2161,
            amount = 3775,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48986,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        { -- Didnt really fit anywhere
            type = "quest",
            id = 52033,
            aside = true,
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 49443,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 49805,
            aside = true,
            x = 0,
            y = 3,
        },
        {
            type = "quest",
            id = 49804,
            x = 2,
            y = 3,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 49803,
            x = 4,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 49806,
            aside = true,
            x = 6,
            y = 3,
        },
        {
            type = "quest",
            id = 49807,
            x = 3,
            y = 4,
            connections = {
                1, 2,
            },
        },
        {
            type = "chain",
            id = Chain.BreakOnThrough,
            aside = true,
            x = 2,
            y = 5,
        },
        {
            type = "chain",
            id = Chain.Chain01,
            aside = true,
            x = 4,
            y = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.BreakOnThrough, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40173,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
    },
    active = {
        type = "chain",
        id = Chain.ANewOrder,
    },
    completed = {
        type = "quest",
        id = 50457,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                4209800, 4296600, 4383400, 4470200, 4557000, 4643800, 4730600, 4817400, 4904200, 4991000, 5077800,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                295300, 297950, 300450, 302650, 305150, 307900, 310500, 313150, 315100, 317750,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 240,
        },
        {
            type = "currency",
            id = 1560,
            amount = 50,
        },
        {
            type = "reputation",
            id = 2161,
            amount = 1505,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.ANewOrder,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49926,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50003,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50149,
            x = 3,
            y = 3,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 50152,
            x = 0,
            y = 4,
        },
        {
            type = "quest",
            id = 50151,
            x = 2,
            y = 4,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50173,
            x = 4,
            y = 4,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50175,
            x = 6,
            y = 3.5,
        },
        {
            type = "quest",
            id = 50174,
            x = 6,
            y = 4.5,
        },


        {
            type = "quest",
            id = 50253,
            x = 3,
            y = 5,
            connections = {
                1, 2, 3, 4, 5, 6,
            },
        },


        {
            type = "quest",
            id = 51356,
            x = 0,
            y = 5.5,
        },
        {
            type = "chain",
            id = Chain.Chain02,
            x = 0,
            y = 6.5,
        },
        {
            type = "quest",
            id = 50446,
            x = 2,
            y = 6,
            connections = {
                4, 5,
            },
        },
        {
            type = "chain",
            id = Chain.Chain03,
            aside = true,
            x = 4,
            y = 6,
        },
        {
            type = "quest",
            id = 50448,
            x = 6,
            y = 5.5,
        },
        {
            type = "quest",
            id = 50447,
            x = 6,
            y = 6.5,
        },


        {
            type = "quest",
            id = 50453,
            x = 2,
            y = 7,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50454,
            x = 4,
            y = 7,
        },

        {
            type = "quest",
            id = 50456,
            x = 0,
            y = 7.5,
        },
        {
            type = "quest",
            id = 50455,
            x = 6,
            y = 7.5,
        },

        {
            type = "quest",
            id = 50457,
            x = 2,
            y = 8,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.StormingTheManor,
            aside = true,
            x = 2,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.StormingTheManor, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40174,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
        {
            type = "chain",
            id = Chain.BreakOnThrough,
        },
    },
    active = {
        type = "chain",
        id = Chain.BreakOnThrough,
    },
    completed = {
        type = "quest",
        id = 50588,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1668400, 1702800, 1737200, 1771600, 1806000, 1840400, 1874800, 1909200, 1943600, 1978000, 2012400,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                174400, 175950, 177350, 178800, 180200, 181800, 183400, 184800, 186200, 187600,
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
            id = 2161,
            amount = 1275,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.BreakOnThrough,
            x = 3,
            y = 0,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 50583,
            x = 0,
            y = 1,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50585,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50584,
            x = 4,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50586,
            x = 6,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            ids = {50588, 51851, 51852},
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50639,
            aside = true,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52149,
            aside = true,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 53109,
            aside = true,
            x = 3,
            y = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.Drustfall, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40175,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 49898,
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        id = 49898,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                194000, 198000, 202000, 206000, 210000, 214000, 218000, 222000, 226000, 230000, 234000,
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
            id = 2161,
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
            id = 135085,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49898,
            x = 3,
            y = 1,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.FightingWithFire, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40176,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
        {
            type = "chain",
            id = Chain.Chain01,
        },
    },
    active = {
        type = "chain",
        id = Chain.Chain01,
    },
    completed = {
        type = "quest",
        id = 50063,
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
                226200, 228250, 230250, 231750, 233750, 235850, 237850, 239900, 241350, 243400,
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
            id = 2161,
            amount = 1225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.Chain01,
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50001,
            x = 2,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50251,
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            id = 50177,
            x = 3,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50091,
            aside = true,
            x = 1,
            y = 3,
        },
        {
            type = "quest",
            id = 49939,
            x = 3,
            y = 3,
            connections = {
                1, 2, 3,
            },
        },

        {
            type = "quest",
            id = 51390,
            x = 1,
            y = 4,
        },
        {
            type = "quest",
            id = 50903,
            x = 3,
            y = 4,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 50238,
            x = 5,
            y = 4,
        },

        {
            type = "quest",
            id = 50090,
            x = 2,
            y = 5,
        },
        {
            type = "quest",
            id = 50092,
            x = 4,
            y = 5,
            connections = {
                1,
            },
        },


        {
            type = "quest",
            id = 50036,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50063,
            x = 3,
            y = 7,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.StickItToEm,
            aside = true,
            x = 3,
            y = 8,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.StickItToEm, {
    name = {
        type = "achievement",
        id = ACHIEVEMENT_ID,
        criteriaId = 40177,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    major = true,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
        {
            type = "chain",
            id = Chain.Chain01,
        },
        {
            type = "chain",
            id = Chain.FightingWithFire,
        },
    },
    active = {
        type = "chain",
        id = Chain.FightingWithFire,
    },
    completed = {
        type = "quest",
        id = 50533,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                2386200, 2435400, 2484600, 2533800, 2583000, 2632200, 2681400, 2730600, 2779800, 2829000, 2878200,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                180100, 181750, 183250, 184650, 186150, 187800, 189400, 191050, 192200, 193850,
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
            id = 2161,
            amount = 1085,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.FightingWithFire,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50172,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 50265,
            x = 1,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50306,
            x = 3,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50266,
            x = 5,
            y = 2,
        },
        {
            type = "quest",
            id = 50327,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50370,
            x = 3,
            y = 4,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 50329,
            x = 0,
            y = 5,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50325,
            x = 2,
            y = 5,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50445,
            x = 4,
            y = 5,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50530,
            x = 6,
            y = 5,
            connections = {
                1,
            },
        },

        {
            type = "quest",
            id = 50481,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50533,
            x = 3,
            y = 7,
        },
    },
})
-- Completed, Alliance only, requires A new order, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain01, {
    name = { -- Drustfall
        type = "quest",
        id = 49890,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
    },
    active = {
        type = "chain",
        id = Chain.ANewOrder,
    },
    completed = {
        type = "quest",
        id = 49896,
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
                71550, 72200, 72800, 73350, 73950, 74600, 75250, 75900, 76350, 77000,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2161,
            amount = 320,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.ANewOrder,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48504,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48184,
            x = 2,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48517,
            x = 4,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "chain",
            id = Chain.Drustfall,
            x = 6,
            y = 2,
        },
        {
            type = "quest",
            id = 49890,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 49896,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = Chain.FightingWithFire,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, Alliance Only, requires part way through Break on Through, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain02, {
    name = { -- Potent Protection
        type = "quest",
        id = 50452,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
        {
            type = "quest",
            id = 50253,
        },
    },
    active = {
        type = "quest",
        id = 50449,
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        id = 50452,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                426800, 435600, 444400, 453200, 462000, 470800, 479600, 488400, 497200, 506000, 514800,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                36200, 36500, 36800, 37100, 37400, 37700, 38100, 38400, 38600, 38900,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2161,
            amount = 235,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.BreakOnThrough,
            completed = {
                type = "quest",
                id = 50253,
            },
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "npc",
            id = 131639,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50449,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 50451,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 50450,
            x = 4,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50452,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, Alliance Only, requires part way through Break on Through, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain03, {
    name = { -- To Have Loved and Lost
        type = "quest",
        id = 50754,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
        {
            type = "quest",
            id = 50253,
        },
    },
    active = {
        type = "chain",
        id = Chain.BreakOnThrough,
    },
    completed = {
        type = "quest",
        id = 50763,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1105800, 1128600, 1151400, 1174200, 1197000, 1219800, 1242600, 1265400, 1288200, 1311000, 1333800,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                79800, 80500, 81150, 81800, 82450, 83200, 83900, 84600, 85150, 85850,
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
            id = 2161,
            amount = 470,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "chain",
            id = Chain.BreakOnThrough,
            completed = {
                type = "quest",
                id = 50253,
            },
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50754,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50758,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50759,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50760,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50761,
            x = 3,
            y = 5,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50762,
            x = 3,
            y = 6,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50763,
            x = 3,
            y = 7,
        },
    },
})
-- Completed, Alliance only, No requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain04, {
    name = { -- A Farmer's Fate
        type = "quest",
        id = 50970,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        ids = {50970, 50967, 50965},
        status = {"active", "completed"},
    },
    completed = {
        {
            type = "quest",
            id = 50970,
        },
        {
            type = "quest",
            id = 50967,
        },
        {
            type = "quest",
            id = 50965,
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
            type = "currency",
            id = 1553,
            amount = 75,
        },
        {
            type = "reputation",
            id = 2161,
            amount = 225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 135976,
            x = 2,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "kill",
            id = 135901,
            x = 5,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 50970,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 50967,
            x = 3,
            y = 1,
        },
        {
            type = "quest",
            id = 50965,
            x = 5,
            y = 1,
        },
    },
})
-- Completed, Alliance only, No requirements, No breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain05, {
    name = { -- Wicker Worship
        type = "quest",
        id = 48677,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 48677,
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        id = 48683,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1280400, 1306800, 1333200, 1359600, 1386000, 1412400, 1438800, 1465200, 1491600, 1518000, 1544400,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                94600, 95450, 96250, 96950, 97750, 98650, 99450, 100300, 100950, 101800,
            },
            minLevel = 110,
            maxLevel = 119,
        },
    },
    items = {
        {
            type = "npc",
            id = 127296,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48677,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48678,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48679,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48680,
            x = 4,
            y = 3,
        },
        {
            type = "quest",
            id = 48682,
            x = 3,
            y = 4,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48683,
            x = 3,
            y = 5,
        },
    },
})
-- Completed, alliance only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(Chain.Chain06, {
    name = { -- To Market, To Market
        type = "quest",
        id = 47945,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        ids = {47945, 47946, 47947, 47948, 47949},
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        ids = {47946, 47947, 47948, 47950},
        count = 4,
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
            type = "object",
            id = 277459,
            x = 0,
            connections = {
                2,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 47945,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 124786,
                }
            },
            x = 4,
            y = 0,
            connections = {
                2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 47949,
            x = 0,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 47946,
        },
        {
            type = "quest",
            id = 47947,
        },
        {
            type = "quest",
            id = 47948,
        },
        {
            type = "quest",
            id = 47950,
            x = 0,
        },
    },
})
-- Completed, Alliance only, no requirements, 1 breadcrumb
BtWQuestsDatabase:AddChain(Chain.Chain07, {
    name = { -- The Adventurer's Society
        type = "quest",
        id = 48793,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 48792,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 48793,
            status = {"active", "completed"},
        },
    },
    completed = {
        type = "quest",
        id = 48853,
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
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 48948,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 127015,
                }
            },
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48792,
            aside = true,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 48793,
            x = 4,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 48804,
            x = 3,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48805,
            aside = true,
            x = 5,
            y = 2,
        },
        {
            type = "quest",
            id = 48853,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, Alliance only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain08, {
    name = { -- Seeing Spirits
        type = "quest",
        id = 48475,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 48475,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 48474,
            status = {"active", "completed"},
        },
    },
    completed = {
        type = "quest",
        id = 48477,
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
                90450, 91300, 92050, 92750, 93500, 94350, 95100, 95950, 96550, 97400,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 75,
        },
    },
    items = {
        {
            type = "npc",
            id = 126210,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48475,
            x = 3,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48474,
            restrictions = {
                type = "level",
                level = 119,
                atmost = true,
            },
            x = 5,
            y = 1,
        },
        {
            type = "quest",
            id = 48476,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 48477,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, Alliance only, no requirements, 1 breadcrumb (48947), need to do this chain again
BtWQuestsDatabase:AddChain(Chain.Chain09, {
    name = { -- Gol Koval
        type = "quest",
        id = 48947,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 48947,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 52074,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 48181,
            status = {"active", "completed"},
        },
    },
    completed = {
        type = "quest",
        id = 53110,
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
                152150, 153550, 154900, 155900, 157250, 158650, 160000, 161400, 162350, 163750,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "currency",
            id = 1553,
            amount = 75,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 48947,
                    restrictions = BtWQuestsItem_ActiveOrCompleted,
                },
                {
                    type = "npc",
                    id = 125457,
                }
            },
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 52074,
            x = 3,
            y = 1,
            connections = {
                2, 3, 4, 5, 6,
            },
        },
        {
            type = "quest",
            id = 48181,
            restrictions = {
                type = "level",
                level = 119,
                atmost = true,
            },
            x = 5,
            y = 1,
        },

        {
            type = "quest",
            id = 48179,
            x = 0,
            y = 2,
            connections = {
                5,
            },
        },
        {
            type = "quest",
            id = 52075,
            x = 2,
            y = 2,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 48182,
            x = 4,
            y = 2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48183,
            x = 6,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48180,
            x = 3,
            y = 3,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 53110,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, Alliance only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain10, {
    name = { -- An Economic Opportunity
        type = "quest",
        id = 50988,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 50988,
        status = {"active", "completed"},
    },
    completed = {
        {
            type = "quest",
            id = 51001,
        },
        {
            type = "quest",
            id = 51018,
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
                92100, 92950, 93700, 94450, 95200, 96050, 96850, 97700, 98300, 99150,
            },
            minLevel = 110,
            maxLevel = 119,
        },
    },
    items = {
        {
            type = "npc",
            id = 136458,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50988,
            x = 3,
            y = 1,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 51020,
            x = 2,
            y = 2,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 51019,
            x = 4,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50978,
            x = 3,
            y = 3,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 51001,
            x = 2,
            y = 4,
        },
        {
            type = "quest",
            id = 51018,
            x = 4,
            y = 4,
        },
    },
})
-- Completed, Both factions, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain12, {
    name = {
        type = "npc",
        id = 127558,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 48880,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 48904,
            status = {"active", "completed"},
        },
    },
    completed = {
        type = "quest",
        id = 48883,
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
    },
    items = {
        {
            type = "object",
            id = 276515,
            x = 0,
            y = 0,
            connections = {
                3,
            },
        },
        {
            type = "npc",
            id = 127558,
            x = 3,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "object",
            id = 276513,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 48881,
            aside = true,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 48880,
            x = 2,
            y = 1,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 48904,
            x = 4,
            y = 1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 48882,
            aside = true,
            x = 6,
            y = 1,
        },
        {
            type = "quest",
            id = 48883,
            x = 3,
            y = 2,
        },
    },
})
-- Completed, Alliance only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain13, {
    name = BtWQuests_GetAreaName(9614), -- Chandlery Wharf
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 50960,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 50959,
            status = {"active", "completed"},
        },
    },
    completed = {
        type = "quest",
        id = 50960,
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
            type = "object",
            id = 286016,
            x = 3,
            y = 0,
            connections = {
                1, 2,
            },
        },
        {
            variations = {
                {
                    type = "quest",
                    id = 50960,
                    x = 2,
                    restrictions = {
                        type = "level",
                        level = 119,
                        atmost = true,
                    },
                },
                {
                    type = "quest",
                    id = 50960,
                    x = 3,
                },
            },
            y = 1,
        },
        {
            type = "quest",
            id = 50959,
            aside = true,
            restrictions = {
                type = "level",
                level = 119,
                atmost = true,
            },
            x = 4,
            y = 1,
        },
    },
})
-- Completed, both factions, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain15, {
    name = { -- Tea Party
        type = "quest",
        id = 44785,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 47289,
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        id = 44785,
    },
    rewards = {
        {
            type = "money",
            amounts = {
                1183400, 1207800, 1232200, 1256600, 1281000, 1305400, 1329800, 1354200, 1378600, 1403000, 1427400,
            },
            minLevel = 110,
            maxLevel = 120,
        },
        {
            type = "experience",
            amounts = {
                88000, 88800, 89550, 90200, 90950, 91750, 92550, 93350, 93900, 94700,
            },
            minLevel = 110,
            maxLevel = 119,
        },
    },
    items = {
        {
            type = "npc",
            id = 121603,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47289,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 47428,
            x = 3,
            y = 2,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 45079,
            x = 2,
            y = 3,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 45972,
            aside = true,
            x = 4,
            y = 3,
        },
        {
            type = "quest",
            id = 44785,
            x = 3,
            y = 4,
        },
    },
})
-- Completed, Alliance only, no requirements, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain16, {
    name = { -- Saplings in the Snow
        type = "quest",
        id = 51543,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        type = "quest",
        id = 51543,
        status = {"active", "completed"},
    },
    completed = {
        type = "quest",
        id = 51472,
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
                57550, 58100, 58550, 59050, 59500, 60050, 60500, 61050, 61450, 62000,
            },
            minLevel = 110,
            maxLevel = 119,
        },
        {
            type = "reputation",
            id = 2161,
            amount = 225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 135861,
            x = 3,
            y = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51543,
            x = 3,
            y = 1,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 50953,
            x = 3,
            y = 2,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 51472,
            x = 3,
            y = 3,
        },
    },
})
-- Completed, Horde only, requries BtWQuests.Constant.Chain.BattleForAzeroth.HordeDrustvarFoothold, no breadcrumbs
BtWQuestsDatabase:AddChain(Chain.Chain17, {
    name = { -- Precious Metals
        type = "quest",
        id = 53461,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    prerequisites = {
        {
            type = "chain",
            id = BtWQuests.Constant.Chain.BattleForAzeroth.HordeDrustvarFoothold,
        },
    },
    restrictions = {
        type = "faction",
        id = HORDE_ID,
    },
    active = {
        {
            type = "quest",
            id = 53461,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 53463,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 53462,
            status = {"active", "completed"},
        },
    },
    completed = {
        {
            type = "quest",
            id = 53461,
        },
        {
            type = "quest",
            id = 53463,
        },
        {
            type = "quest",
            id = 53462,
        },
    },
    rewards = {
        {
            type = "money",
            amounts = {
                702000,
            },
            minLevel = 120,
            maxLevel = 120,
        },
        {
            type = "reputation",
            id = 2161,
            amount = 225,
            restrictions = {
                type = "faction",
                id = BtWQuests.Constant.Faction.Alliance,
            },
        },
    },
    items = {
        {
            type = "npc",
            id = 143878,
            x = 1,
            y = 0,
            connections = {
                2,
            },
        },
        {
            type = "npc",
            id = 143871,
            x = 4,
            y = 0,
            connections = {
                2, 3,
            },
        },
        {
            type = "quest",
            id = 53461,
            x = 1,
            y = 1,
        },
        {
            type = "quest",
            id = 53463,
            x = 3,
            y = 1,
        },
        {
            type = "quest",
            id = 53462,
            x = 5,
            y = 1,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.Chain18, {
    name = { -- One Man Against the Horde
        type = "quest",
        id = 50911,
    },
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    restrictions = {
        type = "faction",
        id = ALLIANCE_ID,
    },
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = {
        {
            type = "quest",
            id = 50911,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 50929,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 50912,
            status = {"active", "completed"},
        },
        {
            type = "quest",
            id = 50897,
            status = {"active", "completed"},
        },
    },
    completed = {
        {
            type = "quest",
            id = 50911,
        },
        {
            type = "quest",
            id = 50929,
        },
        {
            type = "quest",
            id = 50912,
        },
        {
            type = "quest",
            id = 50897,
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
            amount = 75,
        },
        {
            type = "reputation",
            id = 2161,
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
            id = 135673,
            x = 1,
            y = 0,
            connections = {
                3, 4,
            },
        },
        {
            type = "object",
            id = 284426,
            x = 4,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "kill",
            id = 135541,
            x = 6,
            y = 0,
            connections = {
                4,
            },
        },
        {
            type = "quest",
            id = 50911,
            x = 0,
            y = 1,
        },
        {
            type = "quest",
            id = 50929,
            x = 2,
            y = 1,
        },
        {
            type = "quest",
            id = 50912,
            x = 4,
            y = 1,
        },
        {
            type = "quest",
            id = 50897,
            x = 6,
            y = 1,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.OtherAlliance, {
    name = "Other Alliance",
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
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
            id = 50600,
        },
        {
            type = "quest",
            id = 47969,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.OtherHorde, {
    name = "Other Horde",
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
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
            id = 53455,
        },
        {
            type = "quest",
            id = 53465,
        },
    },
})
BtWQuestsDatabase:AddChain(Chain.OtherBoth, {
    name = "Other Both",
    category = CATEGORY_ID,
    expansion = EXPANSION_ID,
    range = {110,120},
    prerequisites = {
        type = "level",
        level = 110,
        visible = false,
    },
    active = false,
    items = {
        { -- @todo missing tooltip, part of achievement http://bfa.wowhead.com/achievement=13082
            type = "quest",
            id = 53432,
        },
        {
            type = "quest",
            id = 53464,
        },
        { -- @todo missing tooltip, part of achievement http://bfa.wowhead.com/achievement=13082
            type = "quest",
            id = 53433,
        },
        { -- @todo What?
            type = "quest",
            id = 50990,
        },
        {
            type = "quest",
            id = 48515,
        },
        { -- @todo Kill rare, Get Pet
            type = "quest",
            id = 52061,
        },
        {
            type = "quest",
            id = 50195,
        },
        { -- @todo PvP?
            type = "quest",
            id = 52958,
        },
        { -- @todo PvP?
            type = "quest",
            id = 50206,
        },
        { -- @todo Not sure the requirements for this
            type = "quest",
            id = 51240,
        },
        { -- @todo missing tooltip, part of achievement http://bfa.wowhead.com/achievement=13082
            type = "quest",
            id = 53431,
        },
        { -- @todo missing tooltip, part of achievement http://bfa.wowhead.com/achievement=13082
            type = "quest",
            id = 53430,
        },
        { -- @todo PvP?
            type = "quest",
            id = 52944,
        },
    },
})

BtWQuestsDatabase:AddCategory(CATEGORY_ID, {
    name = BtWQuests_GetMapName(MAP_ID),
    expansion = EXPANSION_ID,
    buttonImage = 2178278,
    listImage = {
        texture = "Interface\\Addons\\BtWQuestsBattleForAzeroth\\UI-CategoryButton",
        texCoords = {0, 0.7353515625, 0.234375, 0.3515625},
    },
    items = {
        {
            type = "header",
            name = L["BTWQUESTS_THE_WAR_CAMPAIGN"],
            restrictions = {
                type = "faction",
                id = HORDE_ID
            },
        },
        {
            type = "chain",
            id = BtWQuests.Constant.Chain.BattleForAzeroth.HordeDrustvarFoothold,
        },
        {
            type = "chain",
            id = BtWQuests.Constant.Chain.BattleForAzeroth.HordeTheMarshalsGrave,
        },


        {
            type = "header",
            name = {
                type = "achievement",
                id = ACHIEVEMENT_ID,
            },
            restrictions = {
                type = "faction",
                id = ALLIANCE_ID
            },
        },
        {
            type = "chain",
            id = Chain.TheFinalEffigy,
        },
        {
            type = "chain",
            id = Chain.TheBurdenOfProof,
        },
        {
            type = "chain",
            id = Chain.AnAirtightAlibi,
        },
        {
            type = "chain",
            id = Chain.TheOrderOfEmbers,
        },
        {
            type = "chain",
            id = Chain.ANewOrder,
        },
        {
            type = "chain",
            id = Chain.BreakOnThrough,
        },
        {
            type = "chain",
            id = Chain.StormingTheManor,
        },
        {
            type = "chain",
            id = Chain.Drustfall,
        },
        {
            type = "chain",
            id = Chain.Chain01,
        },
        {
            type = "chain",
            id = Chain.FightingWithFire,
        },
        {
            type = "chain",
            id = Chain.StickItToEm,
        },


        {
            type = "header",
            name = L["BTWQUESTS_SIDE_QUESTS"],
        },
        {
            type = "chain",
            id = Chain.Chain02,
        },
        {
            type = "chain",
            id = Chain.Chain03,
        },
        {
            type = "chain",
            id = Chain.Chain04,
        },
        {
            type = "chain",
            id = Chain.Chain05,
        },
        {
            type = "chain",
            id = Chain.Chain06,
        },
        {
            type = "chain",
            id = Chain.Chain07,
        },
        {
            type = "chain",
            id = Chain.Chain08,
        },
        {
            type = "chain",
            id = Chain.Chain09,
        },
        {
            type = "chain",
            id = Chain.Chain10,
        },
        {
            type = "chain",
            id = Chain.Chain12,
        },
        {
            type = "chain",
            id = Chain.Chain13,
        },
        {
            type = "chain",
            id = Chain.Chain15,
        },
        {
            type = "chain",
            id = Chain.Chain16,
        },
        {
            type = "chain",
            id = Chain.Chain17,
        },
        {
            type = "chain",
            id = Chain.Chain18,
        },
    },
})

BtWQuestsDatabase:AddMapRecursive(MAP_ID, {
    type = "category",
    id = CATEGORY_ID,
})

BtWQuestsDatabase:AddContinentItems(CONTINENT_ID, {
    {
        type = "chain",
        id = Chain.Chain03,
    },
    {
        type = "chain",
        id = Chain.Chain04,
    },
    {
        type = "chain",
        id = Chain.Chain05,
    },
    {
        type = "chain",
        id = Chain.Chain06,
    },
    {
        type = "chain",
        id = Chain.Chain07,
    },
    {
        type = "chain",
        id = Chain.Chain08,
    },
    {
        type = "chain",
        id = Chain.Chain09,
    },
    {
        type = "chain",
        id = Chain.Chain10,
    },
    {
        type = "chain",
        id = Chain.Chain12,
    },
    {
        type = "chain",
        id = Chain.Chain13,
    },
    {
        type = "chain",
        id = Chain.Chain15,
    },
    {
        type = "chain",
        id = Chain.Chain16,
    },
    {
        type = "chain",
        id = Chain.Chain17,
    },
    {
        type = "chain",
        id = Chain.Chain18,
    },
})