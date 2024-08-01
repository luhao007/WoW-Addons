--[[
    Currently I'm not sure how best to determine which character completed
    the Main Character version of the Oribos intro
    When the alt experiance is enabled an achievement (14529) and quest (59880)
    are flagged as completed. When an alt gets to oribos and relogs both of these
    are marked as complete on that character too, the first 2 quests in the alt
    chain appear to be flagged as completed on main, although they appear to have
    been added later so maybe they wouldnt be under normal circumstances.
    Orignally there was a different quest (62166) at the start of the alt version
    not sure if it was changed or why its different now

    When leaving The Maw quests for the main character oribos chain are flagged
    as completed, along with quest 62537, this doesnt seem to be flagged as completed
    on the main though, so maybe it can be used to test for alts

    Maybe the solution is:
    if achievement 14529 isnt complete on any character then we are the main
    if quest 59770 is complete and quest 62537 is not complete you are the main
    if quest 59770 is not complete and achievement 14529 is complete you are an alt
    if quest 62537 is complete you are an alt (only happens after finishing the maw)

As of Build 35854:
    New alt handling, when first arriving in oribos after doing The Maw you get the
    quest [62704] The Threads of Fate, if selecting to do the campaign...
    otherwise you get a couple of intro quests as before and can select a zone
    or fly directly to the zone to auto accept the quest

    When selecting the new leveling the quest 62713 is flagged as completed, this is also checked by the player condition
    and should be useable to detect if the player is on the alt progress

    alt tracking is now if we should show quest 62704 (The Threads of Fate) at the start of the main progress
    and then checking if the player selected the main version of leveling

    achievement 14807 flags alt progress being available, its account wide
    completing The Maw flags quest 62706 as completed if the achievement is complete(?)

    To show the alt leveling we check if quest 62713 is complete
    To show the initial quest on main progress we check if achievement 14807 is complete and if either
        The Maw isnt complete or
        quest 62704 is active/completed
]]
local BtWQuests = BtWQuests
local L = BtWQuests.L
local Database = BtWQuests.Database
local EXPANSION_ID = BtWQuests.Constant.Expansions.Shadowlands
local Category = BtWQuests.Constant.Category.Shadowlands
local Chain = BtWQuests.Constant.Chain.Shadowlands
local LEVEL_RANGE = {50, 50}
local LEVEL_PREREQUISITES = {
    {
        type = "level",
        level = 50,
    },
}

Database:AddChain(Chain.IntoTheMaw, {
    name = BtWQuests_GetAchievementName(14334),
    questline = 1108,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = LEVEL_PREREQUISITES,
    active = {
        type = "quest",
        ids = {60545, 61874},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 59770,
    },
    rewards = {
        {
            type = "experience",
            amounts = {
                137675, 110075, 82975, 55390, 27715, 13870, 
            },
            minLevel = 51,
            maxLevel = 56,
        },
        {
            type = "money",
            amount = 4352400,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 60545,
                    restrictions = {
                        type = "faction",
                        id = BtWQuests.Constant.Faction.Alliance,
                    },
                },
                {
                    type = "quest",
                    id = 61874,
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59751,
            x = 0,
            connections = {
                1, 2, 3,
            },
        },
        {
            type = "quest",
            id = 59752,
            x = -2,
            connections = {
                3,
            },
        },
        {
            type = "quest",
            id = 59907,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59753,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59914,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59754,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59755,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59756,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59757,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59758,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59915,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59759,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 59760,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59761,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59776,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59762,
            x = 0,
            connections = {
                1, 2,
            },
        },
        {
            type = "quest",
            id = 59765,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 59766,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60644,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59767,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 59770,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = 90002,
            aside = true,
            x = 0,
        },
    },
})
Database:AddChain(Chain.ArrivalInTheShadowlandsMain, {
    name = L["ARRIVAL_IN_THE_SHADOWLANDS"],
    questline = 1135,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ArrivalInTheShadowlandsAlt
    },
    restrictions = {
        type = "quest",
        id = 62713,
        status = {'pending'}
    },
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.IntoTheMaw,
        },
    },
    active = {
        type = "quest",
        ids = {62704, 60129},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60156,
    },
    rewards = {
        {
            type = "experience",
            amounts = {
                31775, 32575, 33000, 33800, 34250, 35050, 35500, 36300, 36700, 37550, 
            },
            minLevel = 50,
            maxLevel = 59,
        },
        {
            type = "money",
            amounts = {
                959400, 968995, 978590, 988180, 997775, 1007370, 1016965, 1026560, 1036150, 1045745, 1055340, 
            },
            minLevel = 50,
            maxLevel = 60,
        },
    },
    items = {
        {
            type = "npc",
            id = 174871,
            restrictions = {
                {
                    type = "achievement",
                    id = 14807,
                },
                {
                    type = "quest",
                    id = 62704,
                    restrictions = {
                        type = "quest",
                        id = 60129,
                        status = {'active', 'completed'}
                    }
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62704,
            restrictions = {
                {
                    type = "achievement",
                    id = 14807,
                },
                {
                    type = "quest",
                    id = 62704,
                    restrictions = {
                        type = "quest",
                        id = 60129,
                        status = {'active', 'completed'}
                    }
                },
            },
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60129,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60148,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60149,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60150,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60151,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60152,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60154,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60156,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "chain",
            id = 90101,
            x = 0,
        },
    },
})
Database:AddChain(Chain.ArrivalInTheShadowlandsAlt, {
    name = L["ARRIVAL_IN_THE_SHADOWLANDS"],
    questline = 1175,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    alternatives = {
        Chain.ArrivalInTheShadowlandsMain
    },
    restrictions = {
        type = "quest",
        id = 62713,
    },
    prerequisites = {
        {
            type = "level",
            level = 50,
        },
        {
            type = "chain",
            id = Chain.IntoTheMaw,
        },
    },
    active = {
        type = "quest",
        id = 62704,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 62159,
    },
    rewards = {
        {
            type = "experience",
            amounts = {
                13550, 13750, 14000, 14200, 14600, 14800, 15200, 15400, 15500, 16000, 
            },
            minLevel = 50,
            maxLevel = 59,
        },
        {
            type = "money",
            amounts = {
                374400, 378150, 381900, 385620, 389370, 393120, 396870, 400620, 404340, 408090, 411840, 
            },
            minLevel = 50,
            maxLevel = 60,
        },
    },
    items = {
        {
            type = "npc",
            id = 174871,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62704,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62716,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62000,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62159,
            x = 0,
            connections = {
                1, 2, 3, 4,
            },
        },
        {
            type = "quest",
            id = 62275,
            aside = true,
            x = -3,
            -- connections = {
            --     4,
            -- },
        },
        {
            type = "quest",
            id = 62278,
            aside = true,
            -- connections = {
            --     4,
            -- },
        },
        {
            type = "quest",
            id = 62277,
            aside = true,
            -- connections = {
            --     4,
            -- },
        },
        {
            type = "quest",
            id = 62279,
            aside = true,
            -- connections = {
            --     4,
            -- },
        },
        -- {
        --     type = "chain",
        --     id = 90141,
        --     aside = true,
        --     x = -3,
        -- },
        -- {
        --     type = "chain",
        --     id = 90241,
        --     aside = true,
        -- },
        -- {
        --     type = "chain",
        --     id = 90341,
        --     aside = true,
        -- },
        -- {
        --     type = "chain",
        --     id = 90441,
        --     aside = true,
        -- },
    },
})
Database:AddChain(Chain.TheMawEmbed, {
    name = L["RETURN_TO_THE_MAW"],
    questline = 1123,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    active = {
        type = "quest",
        id = 62882,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60134,
    },
    rewards = {
        {
            type = "experience",
            variations = {
                {
                    amounts = {
                        28575, 28600, 28600, 28650, 28650, 29150, 29700, 30150, 30700, 
                    },
                    minLevel = 51,
                    maxLevel = 59,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        27600, 28050, 28600, 29050, 29550, 
                    },
                    minLevel = 55,
                    maxLevel = 59,
                },
            },
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1006200, 1006435, 1006670, 1006900, 1007135, 1007370, 1016965, 1026560, 1036150, 1045745, 1055340, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amounts = {
                        1008540, 1017900, 1027260, 1036620, 1045980, 1055340, 
                    },
                    minLevel = 55,
                    maxLevel = 60,
                },
            },
        },
        {
            type = "reputation",
            id = 2432,
            amount = 20,
        },
    },
    items = {
        {
            type = "quest",
            id = 62882,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60287,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 61355,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60289,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62837,
            x = 0,
        },
    },
})
Database:AddChain(Chain.Torghast, {
    name = BtWQuests_GetMapName(1762),
    questline = {1136, 1210, 1242, 1243, 1244, 1245},
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    buttonImage = "Interface\\AddOns\\BtWQuestsShadowlands\\UI-Chain-Torghast",
    prerequisites = {
        {
            type = "level",
            level = 60,
        },
        {
            type = "chain",
            id = Chain.Kyrian.AmongTheKyrian or 90601,
            restrictions = {
                type = "covenant",
                id = 1,
            },
        },
        {
            type = "chain",
            id = Chain.Venthyr.Sinfall or 90901,
            restrictions = {
                type = "covenant",
                id = 2,
            },
        },
        {
            type = "chain",
            id = Chain.NightFae.ForQueenAndGrove or 90801,
            restrictions = {
                type = "covenant",
                id = 3,
            },
        },
        {
            type = "chain",
            id = Chain.Necrolord.LoyalToThePrimus or 90701,
            restrictions = {
                type = "covenant",
                id = 4,
            },
        },
    },
    active = {
        type = "quest",
        ids = {63029, 63033, 63030, 63032},
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        ids = {62719, 61730},
        count = 2,
    },
    rewards = {
        {
            name = L["ACCESS_TO_TORGHAST"],
            type = "spell",
            id = 334746,
        },
        {
            name = L["ACCESS_TO_TORGHAST_TWISTING_CORRIDORS"],
            type = "spell",
            id = 346217,
        },
        {
            type = "experience",
            amounts = {
                150600, 153550, 156450, 159450, 162350, 165300, 168200, 171150, 174500, 177450, 
            },
            minLevel = 50,
            maxLevel = 59,
            restrictions = 86994,
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        8915400, 9001980, 9088560, 9175140, 9261720, 9348300, 9434880, 9521460, 9608040, 9694620, 9781200, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 9781200,
                },
            },
        },
        {
            type = "currency",
            id = 1828,
            amount = 1150,
        },
    },
    items = {
        {
            variations = {
                {
                    type = "quest",
                    id = 63029,
                    restrictions = {
                        type = "covenant",
                        id = 1,
                    },
                },
                {
                    type = "quest",
                    id = 63033,
                    restrictions = {
                        type = "covenant",
                        id = 2,
                    },
                },
                {
                    type = "quest",
                    id = 63030,
                    restrictions = {
                        type = "covenant",
                        id = 3,
                    },
                },
                {
                    type = "quest",
                    id = 63032,
                    restrictions = {
                        type = "covenant",
                        id = 4,
                    },
                },
            },
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60136,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 61099,
            x = -1,
            connections = {
                2, 3
            },
        },
        {
            type = "kill",
            id = 175123,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 62932,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            ids = {60267, 62967},
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 62935,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60268,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 62938,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60269,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60139,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60270,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 62966,
            x = -1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 60271,
            connections = {
                3, 
            },
        },
        {
            visible = false,
            x = -3,
        },
        {
            type = "quest",
            id = 62969,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60272,
            connections = {
                2, 3
            },
        },
        {
            type = "quest",
            id = 60146,
            x = -1,
            connections = {
                3, 
            },
        },
        {
            type = "quest",
            id = 62700,
        },
        {
            type = "quest",
            id = 62719,
        },
        {
            type = "quest",
            id = 62836,
            x = -1,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61730,
            x = -1,
        },
    },
})
Database:AddChain(Chain.NewRules, {
    name = L["NEW_RULES"],
    questline = 1200,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 60,
        },
        {
            type = "chain",
            id = Chain.Kyrian.AmongTheKyrian or 90601,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 1,
            },
        },
        {
            type = "chain",
            id = Chain.Venthyr.Sinfall or 90901,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 2,
            },
        },
        {
            type = "chain",
            id = Chain.NightFae.ForQueenAndGrove or 90801,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 3,
            },
        },
        {
            type = "chain",
            id = Chain.Necrolord.LoyalToThePrimus or 90701,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 4,
            },
        },
        {
            type = "chain",
            id = Chain.Torghast,
            upto = 61099
        },
    },
    active = {
        type = "quest",
        id = 63051,
        status = {'active', 'completed'},
    },
    completed = {
        type = "quest",
        id = 60158,
    },
    rewards = {
        {
            name = L["ACCESS_TO_PERDITION_HOLD"],
            type = "spell",
            id = 340350,
        },
        {
            name = L["ACCESS_TO_THE_BEASTWARRENS"],
            type = "spell",
            id = 340351,
        },
        {
            type = "experience",
            amounts = {
                54050, 55150, 56250, 57150, 58250, 59350, 60450, 61600, 62650, 63600, 
            },
            minLevel = 50,
            maxLevel = 59,
            restrictions = 86994,
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        2948400, 2975310, 3002220, 3029130, 3056040, 3082950, 3109860, 3136770, 3163680, 3190590, 3217500, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 3217500,
                },
            },
        },
        {
            type = "currency",
            id = 1767,
            amount = 223,
        },
        {
            type = "reputation",
            id = 2432,
            amount = 380,
        },
    },
    items = {
        {
            type = "npc",
            id = 168432,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 63051,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60281,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 60284,
            x = 0,
            connections = {
                1, 2
            },
        },
        {
            type = "quest",
            id = 60285,
            x = -1,
            connections = {
                2,
            },
        },
        {
            type = "quest",
            id = 63022,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 62461,
            x = 0,
            connections = {
                1,
            },
        },
        {
            type = "quest",
            id = 60158,
            x = 0,
        },
    },
})
Database:AddChain(Chain.PeeringIntoDarkness, {
    name = L["PEERING_INTO_DARKNESS"],
    questline = 1138,
    expansion = EXPANSION_ID,
    range = LEVEL_RANGE,
    major = true,
    prerequisites = {
        {
            type = "level",
            level = 60,
        },
        {
            type = "chain",
            id = Chain.Kyrian.AmongTheKyrian or 90601,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 1,
            },
        },
        {
            type = "chain",
            id = Chain.Venthyr.Sinfall or 90901,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 2,
            },
        },
        {
            type = "chain",
            id = Chain.NightFae.ForQueenAndGrove or 90801,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 3,
            },
        },
        {
            type = "chain",
            id = Chain.Necrolord.LoyalToThePrimus or 90701,
            lowPriority = true,
            restrictions = {
                type = "covenant",
                id = 4,
            },
        },
        {
            type = "chain",
            id = Chain.Torghast,
            upto = 62836,
        },
    },
    active = {
        type = "quest",
        ids = {60501, 61730},
        status = {'active', 'completed'},
        count = 2,
    },
    completed = {
        type = "quest",
        id = 62569,
    },
    rewards = {
        {
            type = "experience",
            amounts = {
                23150, 23600, 24050, 24550, 25000, 25450, 25900, 26350, 26850, 27300, 
            },
            minLevel = 50,
            maxLevel = 59,
            restrictions = 86994,
        },
        {
            type = "money",
            variations = {
                {
                    amounts = {
                        1298700, 1310400, 1322100, 1333800, 1345500, 1357200, 1368900, 1380600, 1392300, 1404000, 1415700, 
                    },
                    minLevel = 50,
                    maxLevel = 60,
                    restrictions = 86994,
                },
                {
                    amount = 1415700,
                },
            },
        },
        {
            type = "currency",
            id = 1828,
            amount = 250,
        },
    },
    items = {
        {
            type = "kill",
            id = 167406,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "chain",
            id = Chain.Torghast,
            upto = 62836,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 60501,
            x = -1,
            connections = {
                2, 
            },
        },
        {
            type = "quest",
            id = 61730,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61557,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61558,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 61559,
            x = 0,
            connections = {
                1, 
            },
        },
        {
            type = "quest",
            id = 62569,
            x = 0,
        },
    },
})

BtWQuestsDatabase:AddExpansionItems(EXPANSION_ID, {
    {
        type = "chain",
        id = Chain.IntoTheMaw,
    },
    {
        type = "chain",
        id = Chain.ArrivalInTheShadowlandsMain,
    },
    {
        type = "chain",
        id = Chain.ArrivalInTheShadowlandsAlt,
    },
    {
        type = "category",
        variations = {
            {
                id = Category.Kyrian,
                restrictions = {
                    type = "covenant",
                    id = 1,
                },
            },
            {
                id = Category.Necrolord,
                restrictions = {
                    type = "covenant",
                    id = 4,
                },
            },
            {
                id = Category.NightFae,
                restrictions = {
                    type = "covenant",
                    id = 3,
                },
            },
            {
                id = Category.Venthyr,
                restrictions = {
                    type = "covenant",
                    id = 2,
                },
            },
        },
    },
    {
        type = "chain",
        id = Chain.Torghast,
    },
    {
        type = "chain",
        id = Chain.NewRules,
    },
    {
        type = "chain",
        id = Chain.PeeringIntoDarkness,
    },
})

Database:AddMapRecursive(1648, {
    type = "chain",
    id = Chain.IntoTheMaw,
})
Database:AddMapRecursive(1911, {
    type = "chain",
    id = Chain.Torghast,
})
Database:AddMapRecursive(1912, {
    type = "chain",
    id = Chain.Torghast,
})
Database:AddMap(1543, {
    type = "chain",
    id = Chain.NewRules,
})