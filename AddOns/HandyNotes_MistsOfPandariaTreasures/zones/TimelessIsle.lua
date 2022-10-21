local myname, ns = ...

-- Treasure, Treasure Everywhere
-- https://www.wowhead.com/achievement=8729/treasure-treasure-everywhere#comments:id=1884527

ns.RegisterPoints(554, { -- Timeless Isle
    -- Moss-covered
    [36703410] = {quest=33170}, -- Three-Breeze Terrace
    [25502720] = {quest=33171}, -- Misty Strand
    [27403910] = {quest=33172}, -- south of Misty Strand
    [30703650] = {quest=33173}, -- on a stump, SW of 3-Breeze Terrace
    [22403540] = {quest=33174}, -- underwater, north of Horde base
    [22104930] = {quest=33175}, -- south of Horde base
    [24805300] = {quest=33176}, -- SE of chest #005
    [25704580] = {quest=33177}, -- SE of Horde base
    [22266811] = {quest=33178}, -- north of Alliance base
    [26806870] = {quest=33179}, -- NE of Alliance base
    [31007630] = {quest=33180}, -- bush between Alli base and Old Pi'jiu
    [35307640] = {quest=33181}, -- Old Pi'jiu, W building
    [38707160] = {quest=33182}, -- Old Pi'jiu, N building
    [39807950] = {quest=33183}, -- Old Pi'jiu, E building
    [34808420] = {quest=33184}, -- at the basement of Old Pi'jiu's jetty
    [43608410] = {quest=33185}, -- bush SE of Old Pi'jiu
    [47005370] = {quest=33186}, -- in the central lake
    [46704670] = {quest=33187}, -- north of central lake
    [51204570] = {quest=33188}, -- in the slump scraps under the broken bridge
    [55504430] = {quest=33189}, -- next to Tsavo'ka's cave
    [58005070] = {quest=33190}, -- next to Mysterious Cave
    [65704780] = {quest=33191}, -- behind the graveyard
    [63805920] = {quest=33192}, -- south of graveyard
    [64907560] = {quest=33193}, -- in the Croaking Hollow
    [60206600] = {quest=33194}, -- SW of chest #022
    [49706570] = {quest=33195}, -- south of central lake
    [53107080] = {quest=33196}, -- SE of chest #025
    [52706270] = {quest=33197}, -- SE of central lake
    [61708850] = {quest=33227}, -- in the shipwreck of Cpt. Zvezdan
}, {
    label="{achievement:8729.1:Moss-Covered Chests}",
    achievement=8729, -- Treasure, Treasure Everywhere
    criteria=1,
    minimap=true,
})
ns.RegisterPoints(554, { -- Timeless Isle
    -- Skull-covered
    [44703840] = {
        quest=33203,
        criteria=2,
        note="Inside the cave",
    },
    -- Blazing
    [47602760] = {
        quest=33210,
        criteria=3,
    },
    -- Sturdy
    [28203520] = {quest=33204, criteria=4, note="Use a {npc:73531:Highwind Albatross} to reach here",}, -- on the top of the cliff, north of Horde base
    [26806490] = {quest=33205, criteria=4, note="Use a {npc:73531:Highwind Albatross} to reach here",}, -- on the top of the cliff, north of Alliance base
    [64607040] = {quest=33206, criteria=4,}, -- in the Croaking Hollow
    [59204950] = {quest=33207, criteria=4, note="Use a {achievement:8723:Legend of the Past} tool to break in",}, -- inside the Mysterious Den
    -- Smoldering
    [69503290] = {quest=33208, criteria=5,}, -- at the Shrine of the Black Flame, Blazing Way area
    [54007820] = {quest=33209, criteria=5,}, -- at the central cauldron of Firewalker Ruins
}, {
    achievement=8729, -- Treasure, Treasure Everywhere
    minimap=true,
})
ns.RegisterPoints(555, { -- Cavern of Lost Spirits
    -- Skull-covered
    [62903480] = {
        quest=33203,
        achievement=8729, -- Treasure, Treasure Everywhere
        criteria=2,
        note="Inside the cave",
        minimap=true,
    },
})

-- Extreme Treasure Hunter
ns.RegisterPoints(554, { -- Timeless Isle
    [49706940] = { -- Gleaming Treasure Chest
        quest=32969,
        criteria=24018,
    },
    [54004720] = { -- Rope-Bound Treasure Chest
        quest=32968,
        criteria=24019,
        note="Run along the ropes",
        path=60204590,
    },
    [58706010] = { -- Mist-Covered Treasure Chest
        quest=32971,
        criteria=24020,
        note="Use the statue and loot a chest while falling",
    },
}, {
    achievement=8726,
    atlas="VignetteLootElite", scale=1.1,
})

-- Where There's Pirates There's Booty
ns.RegisterPoints(554, { -- Timeless Isle
    [40009200] = { -- Sunken Treasure
        quest=32957,
        criteria=24021,
        loot={
            {134024, toy=true}, -- Cursed Swabby Helmet
        },
        note="Key drops from nearby elites",
    },
    [17205730] = { -- Blackguard's Jetsam
        quest=32956,
        criteria=24022,
        note="In an underwater cave",
        minimap=true, -- entrance is a long way from the vignette
    },
    [71308000] = { -- Gleaming Treasure Satchel
        quest=32970,
        criteria=24023,
        note="Hanging from a pole on the ship",
    },
}, {
    achievement=8727,
    atlas="VignetteLootElite", scale=1.1,
})

-- Legend of the Past
ns.RegisterPoints(554, { -- Timeless Isle
    [47308080] = {}, --- South side of the ramp that leads up to Firewalker Ruins.
    [55305030] = {}, --- Under the broken bridge, in front of the Mysterious Den.
    [63104530] = {}, --- On a ledge to the west of the pathway in the Blazing Way area.
    [55605930] = {}, --- On the top of the hill-spike that connects the upmost pair of Ordon bridges.
    [50407170] = {}, --- On the stoned area east of the Everlasting Spritewood.
    [68406040] = {}, --- Near the ruined tower on the east as you pass through the bridge from Firewalker Ruins.
    [42805540] = {}, --- Next to Emperor Shaohao's tribune.
    [48005120] = {}, --- On a rock, north side of Mossgreen Lake.
    [25007190] = {}, --- Next to the Alliance camp graveyard.
    [64507230] = {}, --- On a stump in Croaking Hollow.
    [55107290] = {}, --- On the northern slump scraps @ Firewalker Ruins.
    [33805450] = {}, --- At the entrance of Celestial Court (arena).
    [37704110] = {}, --- On a small rock halfway between the Celestial Court and 3-Breeze Terrace.
    [39607780] = {}, --- Next to the broken shrine at Pi'jiu village.
    [65405170] = {}, --- On a rock next to the daily quest giver Senior Historian Evelyna.
    [52206260] = {}, --- Southeast of Mossgreen Lake.
    [32006150] = {}, --- Southwest of Celestial Court.
    [32603280] = {}, --- On a rock at the west side of 3-Breeze Terrace.
    [22403870] = {}, --- Next to the Horde camp graveyard.
}, {
    label="{achievement:8723}",
    achievement=8723,
    criteria=true,
    atlas="mechagon-projects",
    always=true,
    minimap=true,
})

-- Rares

-- Note: most of these rares have two questids; a "first" that triggers
-- once-per-character, and a daily. Daily only triggers on your second kill.

local archiereus = { -- Archiereus of Flame +4
    quest=33312, -- first:33288
    criteria=31, -- API says 0 for its ID, maybe because of the two npc ids?
    npc=73174,
    loot={
        86574, -- Elixir of Ancient Knowledge
    },
}
local flintlord = { -- Flintlord Gairan +4
    quest=33309, -- first:33285
    criteria=23995,
    npc=73172,
    loot={
        104298, -- Ordon Death Chime
    },
}
ns.RegisterPoints(554, { -- Timeless Isle
    [48203320] = archiereus,
    [49602200] = archiereus,
    [56603570] = archiereus,
    [58202490] = archiereus,
    [35003130] = { -- Archiereus of Flame
        quest={33312, 33343}, -- first:33288
        criteria=31, -- API says 0 for its ID, maybe because of the two npc ids?
        npc=73666,
        loot={
            86574, -- Elixir of Ancient Knowledge
        },
        note="Summoned for {quest:33343}",
    },
    [63737281] = { -- Bufo
        quest=33301, -- first: 33276
        criteria=23986,
        npc=72775,
        loot={
            {104169, pet=1338,}, -- Gulp Froglet
        },
    },
    [60005100] = { -- Champion of the Black Flame
        quest=33299, -- first: 33274
        criteria=23996,
        npc=73171,
        loot={
            {104302, toy=true,}, -- Blackflame Daggers
            106130, -- Big Bag of Herbs
        },
        routes={{60005100,61404540,63704280,66804240,69404360,71104600,70205300,66405880}},
    },
    [25203540] = { -- Chelon
        quest=32966,
        criteria=23974,
        npc=72045,
        loot={
            {86584, toy=true,}, -- Hardened Shell
        },
    },
    [54005240] = { -- Cinderfall
        quest=33310, -- first:33286
        criteria=23981,
        npc=73175,
        loot={
            104299, -- Falling Flame
            104261, -- Glowing Blue Ash
        },
    },
    [43606940] = { -- Cranegnasher
        quest=33319,
        criteria=23976,
        npc=72049,
        loot={
            104268, -- Pristine Stalker Hide
        },
    },
    [25802260] = { -- Dread Ship Vazuvius
        quest=33314,
        criteria=23987,
        npc=73281,
        loot={
            {104294, toy=true,}, -- Rime of the Time-Lost Mariner
        },
        note="Requires {item:104115} from {npc:73279} to summon",
    },
    [33149115] = { -- Evermaw
        quest=33289,
        criteria=23990,
        npc=73279,
        loot={
            104115, -- Mist-Filled Spirit Lantern
        },
        routes={
            {14003500,14202960,18201840,24200820,33400280,44000360,53000540,63600680,72401480,76002080,79002820,80603420,80606060, 80206640,77607600,75408280,63409520,42409780,35409260,26208500,20407380,16806480,14405880,14004460, loop=true}
        }
    },
    [40202580] = flintlord,
    [43803320] = flintlord,
    [46203920] = flintlord,
    [48803700] = flintlord,
    [55203800] = flintlord,
    [64202860] = { -- Garnia
        quest=33300, -- first: 33275
        criteria=23982,
        npc=73282,
        loot={
            {104159, pet=1328,}, -- Ruby Droplet
        },
    },
    [61606340] = { -- Golganarr
        quest=33315, -- first: 33291
        criteria=23988,
        npc=72970,
        loot={
            {104262, toy=true,}, -- Odd Polished Stone
            104263, -- Glinting Pile of Stone
        },
    },
    [40208280] = { -- Gu'chi the Swarmbringer +5
        quest=33294, -- first: 33260
        criteria=23970,
        npc=72909,
        loot={
            {104291,pet=1345,}, -- Swarmling of Gu'chi
            104290, -- Sticky Silkworm Goo
        },
        routes={{40208280, 40607940, 42067500, 40807000, 36206960, 30607280, 33607940, 36808100, loop=true}},
        note="Patrols counterclockwise around the village",
    },
    [65505730] = { -- Huolon
        quest=33311, -- first: 33287
        criteria=23984,
        npc=73167,
        loot={
            {104269,mount=561,}, -- Reins of the Thundering Onyx Cloud Serpent
            104286, -- Quivering Firestorm Egg
        },
        routes={{65505730,71805100,74004500,64404060,60304490,58005840}},
    },
    [52408240] = { -- Jakur of Ordon
        quest=33306, -- first: 33281
        criteria=23994,
        npc=73169,
        loot={
            {104331, toy=true,}, -- Warning Sign
            104245, -- Technique: Glyph of the Weaponmaster
        },
    },
    [33608540] = { -- Karkanos
        quest=33292, -- first: 33258
        criteria=23973,
        npc=72193,
        loot={
            104035, -- Giant Purse of Timeless Coins
        },
    },
    [67404380] = { -- Leafmender
        quest=33298, -- first: 33273
        criteria=23979,
        npc=73277,
        loot={
            {104156, pet=1323,}, -- Ashleaf Spriteling
            104289, -- Faintly-Glowing Herb
        },
    },
    [60208740] = { -- Rattleskew
        quest=nil,
        criteria=23977,
        npc=72048,
        loot={
            104321, -- Captain Zvezdan's Lost Leg
            104219, -- Technique: Glyph of Skeleton
        },
    },
    [44003920] = { -- Rock Moss
        quest=33307, -- first: 33283
        criteria=23980,
        npc=73157,
        loot={
            104313, -- Golden Moss
            104312, -- Strange Glowing Mushroom
        },
        note="Inside the cave",
    },
    [58004860] = { -- Spelurk
        quest=32960,
        criteria=23975,
        npc=71864,
        loot={
            104320, -- Cursed Talisman
        },
        note="Use a {achievement:8723:Legend of the Past} tool to break in",
    },
    [44003720] = { -- Spirit of Jadefire
        quest=33293, -- first: 33259
        criteria=23978,
        npc=72769,
        loot={
            {104307,pet=1348,}, -- Jadefire Spirit
            104258, -- Glowing Green Ash
        },
        note="Inside the cave",
    },
    [71208220] = { -- Stinkbraid
        quest=33305, -- first: 33280
        criteria=24144,
        npc=73704,
        loot={6657}, -- Savory Deviate Delight
    },
    [54004220] = { -- Tsavo'ka
        quest=33304, -- first: 33279
        criteria=23983,
        npc=72808,
        loot={
            104268, -- Pristine Stalker Hide
        },
    },
    [43202660] = { -- Urdur the Cauterizer
        quest=33308, -- first: 33284
        criteria=23993,
        npc=73173,
        loot={
            104306, -- Sunset Stone
            104296, -- Ordon Ceremonial Robes
        },
    },
    [57207640] = { -- Watcher Osu
        quest=33322, -- first: 33321
        criteria=23992,
        npc=73170,
        loot={
            104305, -- Ashen Stone
            104296, -- Ordon Ceremonial Robes
        },
    },
    [47008740] = { -- Zesqua
        quest=33316, -- first: 32997
        criteria=23971,
        npc=72245,
        loot={
            104303, -- Rain Stone
            104225, -- Charred Recipe
        },
    },
    [37207700] = { -- Zhu-Gon the Sour
        quest=32959, --first: 33317
        criteria=23972,
        npc=71919,
        loot={
            {104167, pet=1336,}, -- Skunky Alemental
        },
    },
}, {
    achievement=8714, -- Timeless Champion
})
ns.RegisterPoints(554, { -- Timeless Isle
    [30805060] = { -- Emerald Gander +11
        quest=33295, -- first: 33261
        criteria=23967,
        npc=73158,
        loot={
            104287, -- Windfeather Plume
        },
        note="Rare spawn of {npc:72762:Brilliant Windfeather}",
    },
    [23604980] = { -- Great Turtle Furyshell +6
        quest=33297, -- first: 33272
        criteria=23969,
        npc=73161,
        loot={
            {86584, toy=true,}, -- Hardened Shell
        },
        note="Rare spawn of {npc:72764:Great Turtle}",
    },
    [29206320] = { -- Imperial Python +10
        quest=33303, -- first: 33278
        criteria=23989,
        npc=73163,
        loot={
            {104161, pet=1330,}, -- Death Adder Hatchling
            104292, -- Partially-Digested Meal
        },
        note="Rare spawn of {npc:72841:Death Adder}",
    },
    [31805840] = { -- Ironfur Steelhorn +9
        quest=33296, -- first: 33270
        criteria=23968,
        npc=73160,
        note="Rare spawn of {npc:72844:Ironfur Great Bull}",
    },
    [18805460] = { -- Monstrous Spineclaw +14
        quest=33302, -- first: 33277
        criteria=23985,
        npc=73166,
        loot={
            {104168, pet=1337,}, -- Spineclaw Crab
            104293, -- Scuttler's Shell
        },
        note="Rare spawn of {npc:72766:Ancient Spineclaw}",
    },
}, {
    achievement=8714, -- Timeless Champion
    note="Kill similar mobs nearby until it spawns",
})
ns.RegisterPoints(555, { -- Cavern of Lost Spirits
    [43003180] = { -- Rock Moss
        quest=33307, -- first: 33283
        criteria=23980,
        npc=73157,
        loot={
            104313, -- Golden Moss
        },
    },
    [47806180] = { -- Spirit of Jadefire +7
        quest=33293, -- first: 33259
        npc=72769,
        loot={
            {104307, pet=1348,}, -- Jadefire Spirit
            104258, -- Glowing Green Ash
        },
    },
}, {
    achievement=8714, -- Timeless Champion
})
