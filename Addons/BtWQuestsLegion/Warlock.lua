local L = BtWQuests.L;
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_AFFLICTION, {
    name = L["AFFLICTION_ULTHALESH_THE_DEADWIND_HARVESTER"],
    category = BTWQUESTS_CATEGORY_LEGION_ARTIFACT,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_BLOOD,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_HAVOC,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_BALANCE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_BEASTMASTERY,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_ARCANE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_BREWMASTER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_HOLY,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_DISCIPLINE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_ASSASSINATION,
        BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_ELEMENTAL,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_ARMS,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        },
    },
    prerequisites = BtWQuests.LegionArtifactPrerequisites("WARLOCK", 1),
    active = BtWQuests.LegionArtifactActive("WARLOCK", 1),
    completed = {
        type = "quest",
        id = 40623,
    },
    range = {98, 110},
    buttonImage = "Interface\\AddOns\\BtWQuestsLegion\\UI-Chain-Warlock-Affliction",
    items = {
        {
            type = "quest",
            id = 40495,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40588,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40604,
            x = 3,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40606,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40611,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40623,
            x = 3,
            y = 5,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_DEMONOLOGY, {
    name = L["DEMONOLOGY_SKULL_OF_THE_MANARI"],
    category = BTWQUESTS_CATEGORY_LEGION_ARTIFACT,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_FROST,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_VENGEANCE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_FERAL,
        BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_MARKSMANSHIP,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_FIRE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_WINDWALKER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_PROTECTION,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_HOLY,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_OUTLAW,
        BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_ENHANCEMENT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_FURY,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        },
    },
    prerequisites = BtWQuests.LegionArtifactPrerequisites("WARLOCK", 2),
    active = BtWQuests.LegionArtifactActive("WARLOCK", 2),
    completed = {
        type = "quest",
        id = 42125,
    },
    range = {98, 110},
    buttonImage = "Interface\\AddOns\\BtWQuestsLegion\\UI-Chain-Warlock-Demonology",
    items = {
        {
            type = "quest",
            id = 42128,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42168,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42125,
            x = 3,
            y = 2,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_DESTRUCTION, {
    name = L["DESTRUCTION_SCEPTER_OF_SARGERAS"],
    category = BTWQUESTS_CATEGORY_LEGION_ARTIFACT,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_UNHOLY,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_VENGEANCE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_GUARDIAN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_SURVIVAL,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_FROST,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_MISTWEAVER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_RETRIBUTION,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_SHADOW,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_SUBTLETY,
        BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_RESTORATION,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_PROTECTION,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        },
    },
    prerequisites = BtWQuests.LegionArtifactPrerequisites("WARLOCK", 3),
    active = BtWQuests.LegionArtifactActive("WARLOCK", 3),
    completed = {
        type = "quest",
        id = 43254,
    },
    range = {98, 110},
    buttonImage = "Interface\\AddOns\\BtWQuestsLegion\\UI-Chain-Warlock-Destruction",
    items = {
        {
            type = "quest",
            id = 43100,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 43153,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 43254,
            x = 3,
            y = 2,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_CAMPAIGN, {
    name = L["BTWQUESTS_WARLOCK_CAMPAIGN"],
    category = BTWQUESTS_CATEGORY_LEGION_CLASSES_WARLOCK,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_CAMPAIGN,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_CAMPAIGN,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        },
    },
    completed = {
        type = "quest",
        id = 41796,
    },
    range = {98, 110},
    items = {
        {
            type = "quest",
            id = 40716,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40729,
            x = 3,
            y = 1,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40684,
            x = 3,
            y = 2,
            connections = {
                1, 2, 3, 4,
            },
        },

        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_AFFLICTION,
            active = {
                type = "quest",
                id = 40684,
            },
            visible = BtWQuests.LegionArtifactNonSelected("WARLOCK"),
            x = 1,
            y = 3,
            connections = {
                4
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_DEMONOLOGY,
            active = {
                type = "quest",
                id = 40684,
            },
            visible = BtWQuests.LegionArtifactNonSelected("WARLOCK"),
            x = 3,
            y = 3,
            connections = {
                3
            },
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_DESTRUCTION,
            active = {
                type = "quest",
                id = 40684,
            },
            visible = BtWQuests.LegionArtifactNonSelected("WARLOCK"),
            x = 5,
            y = 3,
            connections = {
                2
            },
        },


        {
            variations = {
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_AFFLICTION,
                    restrictions = {
                        type = "quest",
                        id = 40686,
                    },
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_DEMONOLOGY,
                    restrictions = {
                        type = "quest",
                        id = 40687,
                    },
                },
                {
                    type = "chain",
                    id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_DESTRUCTION,
                    restrictions = {
                        type = "quest",
                        id = 40688,
                    },
                },
                {
                    visible = false,
                },
            },
            x = 3,
            y = 3,
            connections = {
                1
            },
        },


        {
            type = "quest",
            id = 40712,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40731,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        -- {
        --     type = "quest",
        --     id = 40821,
        --     x = 3,
        --     y = 6,
        --     connections = {
        --         1
        --     },
        -- },
        {
            type = "quest",
            id = 40823,
            x = 3,
            y = 7,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40824,
            x = 3,
            y = 8,
            connections = {
                2
            },
        },



        {
            type = "level",
            level = 101,
            x = 5,
            y = 8.5,
            connections = {
                1
            },
        },


        {
            type = "quest",
            id = 44099,
            breadcrumb = true,
            x = 3,
            y = 9,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42608,
            x = 3,
            y = 10,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42603,
            x = 3,
            y = 11,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41797,
            x = 3,
            y = 12,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42602,
            x = 3,
            y = 13,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42601,
            x = 3,
            y = 14,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42097,
            x = 3,
            y = 15,
            connections = {
                2
            },
        },


        {
            type = "level",
            level = 103,
            x = 5,
            y = 15.5,
            connections = {
                1
            },
        },


        {
            type = "quest",
            id = 41759,
            x = 3,
            y = 16,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39179,
            x = 3,
            y = 17,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39389,
            x = 3,
            y = 18,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 39142,
            x = 3,
            y = 19,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 40218,
            x = 3,
            y = 20,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41767,
            x = 3,
            y = 21,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 41752,
            x = 2,
            y = 22,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 41753,
            x = 4,
            y = 22,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 42100,
            x = 3,
            y = 23,
            connections = {
                3
            },
        },
        {
            type = "quest",
            id = 41798,
            aside = true,
            x = 1,
            y = 23,
        },



        {
            type = "level",
            level = 110,
            x = 5,
            y = 23.5,
            connections = {
                1
            },
        },

        {
            type = "quest",
            id = 42098,
            x = 3,
            y = 24,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41768,
            x = 3,
            y = 25,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41769,
            x = 3,
            y = 26,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41781,
            x = 3,
            y = 27,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41780,
            x = 3,
            y = 28,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41784,
            x = 3,
            y = 29,
            connections = {
                1, 2
            },
        },



        {
            type = "quest",
            id = 41754,
            x = 2,
            y = 30,
            connections = {
                2, 3, 4, 5
            },
        },
        {
            type = "quest",
            id = 41751,
            x = 4,
            y = 30,
            connections = {
                1, 2, 3, 4
            },
        },



        {
            type = "quest",
            id = 44682,
            x = 0,
            y = 31,
            connections = {
                4
            },
        },
        {
            type = "quest",
            id = 42660,
            x = 2,
            y = 31,
            connections = {
                3
            },
        },
        {
            type = "quest",
            id = 42103,
            x = 4,
            y = 31,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 42102,
            x = 6,
            y = 31,
            connections = {
                1
            },
        },


        {
            type = "quest",
            id = 41785,
            x = 3,
            y = 32,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 41788,
            x = 2,
            y = 33,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 41787,
            x = 4,
            y = 33,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41793,
            x = 3,
            y = 34,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41755,
            x = 3,
            y = 35,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 41795,
            x = 3,
            y = 36,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 41756,
            aside = true,
            x = 2,
            y = 37,
        },
        {
            type = "quest",
            id = 41796,
            x = 4,
            y = 37,
            connections = {
                1
            },
        },
        {
            name = L["BTWQUESTS_GO_TO_THE_FELBLOOD_ALTER"],
            breadcrumb = true,
            x = 3,
            y = 38,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 43414,
            x = 3,
            y = 39,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_FOLLOWER, {
    name = { -- Champion: Kanrethad Ebonlocke
		type = "quest",
		id = 46047,
	},
    category = BTWQUESTS_CATEGORY_LEGION_CLASSES_WARLOCK,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_FOLLOWER_ALLIANCE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_FOLLOWER_HORDE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_FOLLOWER,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_FOLLOWER_ALLIANCE,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_FOLLOWER_HORDE,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        },
    },
    completed = {
        type = "quest",
        id = 46047,
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
            id = 45021,
            x = 3,
            y = 1,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 45024,
            x = 2,
            y = 2,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 45025,
            x = 4,
            y = 2,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 45026,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 45794,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 45027,
            x = 3,
            y = 5,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 45028,
            x = 3,
            y = 6,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46020,
            x = 3,
            y = 7,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46047,
            x = 3,
            y = 8,
            connections = {
                1
            },
        },



        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB,
            aside = true,
            x = 3,
            y = 9,
        },
    },
})
BtWQuestsDatabase:AddChain(BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_MOUNT, {
    name = L["BTWQUESTS_WARLOCK_MOUNT"],
    category = BTWQUESTS_CATEGORY_LEGION_CLASSES_WARLOCK,
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEATHKNIGHT_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DEMONHUNTER_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_DRUID_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_HUNTER_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MAGE_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_MONK_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PALADIN_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_PRIEST_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_ROGUE_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_SHAMAN_MOUNT,
        BTWQUESTS_CHAIN_LEGION_CLASSES_WARRIOR_MOUNT,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        },
    },
    prerequisites = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB,
        },
    },
    completed = {
        type = "quest",
        id = 46243,
    },
    range = {110},
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_BROKENSHORE_BREACHING_THE_TOMB,
            x = 3,
            y = 0,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46237,
            x = 3,
            y = 1,
            connections = {
                1, 2, 3
            },
        },

        {
            type = "quest",
            id = 46238,
            x = 1,
            y = 2,
            connections = {
                3
            },
        },
        {
            type = "quest",
            id = 46239,
            x = 3,
            y = 2,
            connections = {
                2
            },
        },
        {
            type = "quest",
            id = 46240,
            x = 5,
            y = 2,
            connections = {
                1
            },
        },

        {
            type = "quest",
            id = 46241,
            x = 3,
            y = 3,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46242,
            x = 3,
            y = 4,
            connections = {
                1
            },
        },
        {
            type = "quest",
            id = 46243,
            x = 3,
            y = 5,
        },
    },
})

BtWQuestsDatabase:AddCategory(BTWQUESTS_CATEGORY_LEGION_CLASSES_WARLOCK, {
    name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
    expansion = BTWQUESTS_EXPANSION_LEGION,
    alternatives = {
        BTWQUESTS_CATEGORY_LEGION_CLASSES_DEATHKNIGHT,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_DEMONHUNTER,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_DRUID,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_HUNTER,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_MAGE,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_MONK,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_PALADIN,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_PRIEST,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_ROGUE,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_SHAMAN,
        BTWQUESTS_CATEGORY_LEGION_CLASSES_WARRIOR,
    },
    restrictions = {
        {
            type = "class",
            id = BTWQUESTS_CLASS_ID_WARLOCK,
        }
    },
    -- buttonImage = 1041999,
    items = {
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_CAMPAIGN,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_FOLLOWER,
        },
        {
            type = "chain",
            id = BTWQUESTS_CHAIN_LEGION_CLASSES_WARLOCK_MOUNT,
        },
    },
})