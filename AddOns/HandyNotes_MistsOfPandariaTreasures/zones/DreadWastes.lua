local myname, ns = ...

ns.RegisterPoints(422, { -- Dread Wastes
    [66306660] = { loot={86522}, quest=31433, }, -- Blade of the Prime
    [25905030] = { loot={86525}, quest=31436, note="in the underwater cave", }, -- Bloodsoaked Chitin Fragment
    [30209080] = { loot={86524}, quest=31435, }, -- Dissector's Staff of Mutation
    [33003010] = { loot={86521}, quest=31431, }, -- Lucid Amulet of the Agile Mind
    [48703000] = { loot={86520}, quest=31430, }, -- Malik's Stalwart Spear
    [42206360] = { loot={86529}, npc=65552, quest=31432, }, -- Manipulator's Talisman on a Glinting Rapana Whelk (65552)
    [56607780] = { loot={86523}, quest=31434, }, -- Swarming Cleaver of Ka'roz
    [54305650] = { loot={86526}, quest=31437, }, -- Swarmkeeper's Medallion
    [71803610] = { loot={86519}, quest=31429, }, -- Wind-Reaver's Dagger of Quick Strikes
    [28804190] = { loot={86527}, quest=31438, }, -- Blade of the Poisoned Mind
}, {
	achievement=7284, -- Is Another Man's Treasure
})

-- Rares

ns.RegisterPoints(422, { -- Dread Wastes
    [34802300] = { -- Ai-Li Skymirror
        quest=nil,
        criteria=21088,
        npc=50821,
        loot={
            {86589,toy=true,}, -- Ai-Li's Skymirror
        },
    },
    [25002860] = { -- Dak the Breaker
        quest=nil,
        criteria=21102,
        npc=50334,
    },
    [35603060] = { -- Gar'lok +2
        quest=nil,
        criteria=21067,
        npc=50739,
        loot={
            {86578,toy=true,}, -- Eternal Warrior's Sigil
        },
    },
    [55206380] = { -- Ik-Ik the Nimble
        quest=nil,
        criteria=21053,
        npc=50836,
        loot={
            {86593,toy=true,}, -- Hozen Beach Ball
        },
    },
    [71803740] = { -- Karr the Darkener
        quest=nil,
        criteria=21074,
        npc=50347,
        loot={
            {86564,pet=834,}, -- Imbued Jade Fragment
        },
    },
    [73002220] = { -- Krol the Blade
        quest=nil,
        criteria=21081,
        npc=50356,
        loot={
            86574, -- Elixir of Ancient Knowledge
        },
    },
    [64005860] = { -- Nalash Verdantis
        quest=nil,
        criteria=21060,
        npc=50776,
        loot={
            {86563,pet=836,}, -- Hollow Reed
        },
    },
    [36006260] = { -- Omnis Grinlok
        quest=nil,
        criteria=21095,
        npc=50805,
    },
}, {
    achievement=7439, -- Glorious!
})

ns.RegisterPoints(422, { -- Dread Wastes
    [47206140] = { -- Zandalari Warbringer
        quest=nil,
        npc=69841, -- also 69769, 69842
        loot={
            {94230,mount=534,}, -- Reins of the Amber Primordial Direhorn
            {94229,mount=535,}, -- Reins of the Slate Primordial Direhorn
            {94231,mount=536,}, -- Reins of the Jade Primordial Direhorn
        },
        atlas="VignetteKillElite", scale=1.2,
    },
    [37004820] = { -- Zandalari Warscout +4
        quest=nil,
        npc=69768,
        loot={
            94159, -- Small Bag of Zandalari Supplies
            94158, -- Big Bag of Zandalari Supplies
        },
        routes={
            {57606600, 53606660, 50006480, 48406100, 47006080, 45405600, 43005160, 37004820},
        },
    },
})
