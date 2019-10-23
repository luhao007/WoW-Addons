-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

local bit = _G.bit


-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...


-----------------------------------------------------------------------
-- Boss/Item/Spell Data Constants.
-----------------------------------------------------------------------
private.BLACKLISTED_ITEMS = {
    [114116] = true,
    [114119] = true,
    [114120] = true,
    [116980] = true,
    [120319] = true,
    [120320] = true,
    [139593] = true,
    [139594] = true,
    [140590] = true,
}

-- Spells that are cast by players/NPCs that are mistakenly assigned as being cast by the target; must be blacklisted
private.BLACKLISTED_SPELLS = {
    [117526] = true, -- Binding Shot (cast by Hunters)
    [121308] = true, -- Disguise (cast by Rogues)
    [132464] = true, -- Chi Wave (cast by Monks)
    [132467] = true, -- Chi Wave (cast by Monks)
    [167432] = true, -- Savagery (cast by Warsong Commander)
    [175077] = true, -- Fearsome Battle Standard (cast by Fearsome Battle Standard item)
    [176813] = true, -- Itchy Spores (cast by Marsh Creatures in Ashran)
    [183901] = true, -- Stolen Strength (cast by Felblood NPCs in Tanaan Jungle)
    [183904] = true, -- Stolen Speed (cast by Felblood NPCs in Tanaan Jungle)
    [183907] = true, -- Stolen Fervor (cast by Felblood NPCs in Tanaan Jungle)
    [195802] = true, -- Moonkin Feather (applied by Moonfeather Statue; first stage buff)
    [195805] = true, -- Moonkin Molting (applied by Moonfeather Statue; second stage buff)
    [195810] = true, -- Feeling Moonkin (applied by Moonfeather Statue; third stage buff)
    [195816] = true, -- Owlvercome wth the Fever (applied by Moonfeather Statue; final stage buff)
    [213738] = true, -- Taste of Blood (applied by Fate and Fortune, Combat Rogue artifacts)
    [213872] = true, -- Unison (applied by a Mistweaver Monk legendary)
    [213877] = true, -- Vampiric Aura (used by Nathrezim Invasion bosses and transformed players)
    [215377] = true, -- The Maw Must Feed (applied by Maw of the Damned, Blood Death Knight artifact)
    [218136] = true, -- Arcane Invigoration (cast by Duskwatch Rune Scribes in The Arcway)
    [223971] = true, -- Hunter's Rush (applied by Fangs of Ashamane, Feral Druid artifacts)
    [224762] = true, -- Leyline Rift (summoned by players with Leyline Mastery in Suramar)
    [225832] = true, -- Nightglow Wisp (cast by players using Wisp in a Bottle toy)
}

private.EPHEMERAL_CRYSTAL_OBJECT_IDS = {
    251168,
    251183,
    251185,
    251186,
    251187,
}

-- Map of Alliance Logging NPC Summon spells to all possible Timber objectIDs of the proper tree size
private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP = {
    [167902] = 234021,
    [167969] = 234022,
    [168201] = 234023,
}
-- Account for Horde spell IDs
private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[167961] = private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[167902]
private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[168043] = private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[167969]
private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[168200] = private.LOGGING_SPELL_ID_TO_OBJECT_ID_MAP[168201]

-- Map of Garrison Cache object names to Garrison Cache object IDs
private.GARRISON_CACHE_OBJECT_NAME_TO_OBJECT_ID_MAP = {
    ["Garrison Cache"] = 236916,
    ["Full Garrison Cache"] = 237722,
    ["Hefty Garrison Cache"] = 237723,
}

private.IGNORED_ISLAND_REWARDS = {
    [163611] = true,
    [163612] = true,
    [163613] = true,
}

-- Mapping of items that, when right-clicked, fire a spell (which can fail, so we have to check success).
-- They reward loot via loot toast popups upon completion of that spell.
-- SHOW_LOOT_TOAST can be used to track loot.
private.LOOT_TOAST_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP = {
    [142397] = 98134,
    [142901] = 98546,
    [143506] = 98095,
    [143507] = 94207,
    [143508] = 89125,
    [143509] = 93146,
    [143510] = 93147,
    [143511] = 93149,
    [143512] = 93148,
    [146885] = 103535,
    [147598] = 104014,
    [149222] = 105911,
    [149223] = 105912,
    [171513] = 116414,
    [175767] = 118697,
    [178508] = 120321,
    [181405] = 122535,
    [181952] = 122677,
    [187534] = 127751,
    [231015] = 142447,
    [233325] = 143753,
    [238040] = 146317,
}

-- Mapping of items that, when right-clicked, fire a spell (which can fail, so we have to check success).
-- They reward loot upon completion of that spell.
-- CHAT_MSG_LOOT -must- be used to track loot, which is definitely not ideal.
private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP = {
    [57844] = 36781,
    [58160] = 24476,
    [58165] = 7973,
    [58168] = 5524,
    [58172] = 5523,
    [61898] = 15874,
    [64202] = 45909,
    [73500] = 52340,
    [80615] = 58856,
    [84193] = 60838,
    [99438] = 69956,
    [99500] = 69990,
    [109946] = 78890,
    [109948] = 78892,
    [109954] = 77952,
    [146236] = 102269,
    [146237] = 102264,
    [146238] = 102263,
    [146239] = 102265,
    [146240] = 102266,
    [146241] = 102267,
    [146242] = 102268,
    [146243] = 102320,
    [146244] = 102291,
    [146246] = 102318,
    [146259] = 102276,
    [146260] = 102271,
    [146261] = 102270,
    [146263] = 102272,
    [146264] = 102273,
    [146265] = 102274,
    [146266] = 102275,
    [146267] = 102323,
    [146268] = 102283,
    [146269] = 102278,
    [146270] = 102277,
    [146271] = 102279,
    [146272] = 102280,
    [146273] = 102281,
    [146274] = 102282,
    [146275] = 102334,
    [146276] = 102290,
    [146277] = 102285,
    [146278] = 102284,
    [146279] = 102286,
    [146280] = 102287,
    [146281] = 102288,
    [146282] = 102289,
    [146283] = 102321,
    [147433] = 102266,
    [147434] = 102266,
    [147435] = 102266,
    [147597] = 104009,
    [148099] = 104010,
    [148103] = 104012,
    [148104] = 104013,
    [148740] = 104345,
    [148746] = 104347,
    [155445] = 107649,
    [161131] = 111589,
    [161225] = 111595,
    [161226] = 111601,
    [161230] = 111650,
    [161231] = 111652,
    [161232] = 111651,
    [161234] = 111656,
    [161237] = 111658,
    [161241] = 111659,
    [161261] = 111662,
    [161266] = 111663,
    [161267] = 111664,
    [161269] = 111665,
    [161270] = 111666,
    [161272] = 111667,
    [161273] = 111668,
    [161274] = 111669,
    [161275] = 111670,
    [161276] = 111671,
    [161277] = 111672,
    [161279] = 111673,
    [161281] = 111674,
    [161283] = 111675,
    [161284] = 111676,
    [166030] = 113203,
    [166153] = 113244,
    [166156] = 113245,
    [166460] = 113295,
    [166481] = 113307,
    [166487] = 113310,
    [166507] = 113313,
    [166509] = 113316,
    [166513] = 113321,
    [166520] = 113324,
    [166526] = 113328,
    [166529] = 113332,
    [166531] = 113336,
    [166550] = 113355,
    [166574] = 113358,
    [166578] = 113361,
    [166582] = 113365,
    [166586] = 113367,
    [166589] = 113371,
    [166593] = 113376,
    [166599] = 113381,
    [166600] = 113384,
    [166606] = 113387,
    [166611] = 113391,
    [166619] = 113394,
    [166739] = 113327,
    [166744] = 113329,
    [166764] = 113411,
    [166770] = 113417,
    [166788] = 113420,
    [166796] = 113423,
    [166800] = 113426,
    [166801] = 113429,
    [166900] = 113452,
    [166905] = 113465,
    [166909] = 113468,
    [166915] = 113471,
    [166980] = 113478,
    [166985] = 113483,
    [167089] = 113495,
    [167096] = 113499,
    [167981] = 114002,
    [168084] = 114039,
    [168103] = 114052,
    [168115] = 114053,
    [168178] = 114116,
    [168179] = 114119,
    [168180] = 114120,
    [168677] = 114106,
    [168678] = 114051,
    [168679] = 114049,
    [168680] = 114048,
    [168681] = 114047,
    [168682] = 114046,
    [168683] = 114045,
    [168684] = 114044,
    [168685] = 114043,
    [168686] = 114042,
    [168687] = 114041,
    [168688] = 114040,
    [168700] = 114108,
    [168701] = 114105,
    [168702] = 114104,
    [168703] = 114103,
    [168704] = 114102,
    [168705] = 114101,
    [168706] = 114100,
    [168707] = 114099,
    [168708] = 114098,
    [168709] = 114097,
    [168710] = 114096,
    [168711] = 114095,
    [168712] = 114094,
    [168713] = 114109,
    [168714] = 114068,
    [168715] = 114067,
    [168716] = 114066,
    [168717] = 114065,
    [168718] = 114064,
    [168719] = 114063,
    [168720] = 114062,
    [168721] = 114061,
    [168722] = 114060,
    [168723] = 114059,
    [168724] = 114058,
    [168725] = 114057,
    [168726] = 114110,
    [168727] = 114080,
    [168728] = 114079,
    [168729] = 114078,
    [168730] = 114077,
    [168731] = 114076,
    [168732] = 114075,
    [168733] = 114074,
    [168734] = 114073,
    [168735] = 114072,
    [168736] = 114071,
    [168737] = 114070,
    [168738] = 114069,
    [168739] = 114112,
    [168740] = 114087,
    [168741] = 119124,
    [168742] = 114086,
    [168743] = 119122,
    [168744] = 119120,
    [168745] = 114085,
    [168746] = 119118,
    [168747] = 119116,
    [168748] = 119114,
    [168749] = 114084,
    [168750] = 114083,
    [168751] = 114082,
    [168752] = 114111,
    [168753] = 114093,
    [168754] = 119125,
    [168755] = 114092,
    [168756] = 119123,
    [168757] = 119121,
    [168758] = 114091,
    [168759] = 119119,
    [168760] = 119117,
    [168761] = 119115,
    [168762] = 114090,
    [168763] = 114089,
    [168764] = 114088,
    [169508] = 115018,
    [170566] = 115591,
    [176482] = 118592,
    [176483] = 119094,
    [176484] = 119095,
    [176485] = 119096,
    [176486] = 119097,
    [176487] = 119098,
    [176488] = 119099,
    [176489] = 119100,
    [176490] = 119101,
    [176491] = 119102,
    [176791] = 119185,
    [176934] = 119095,
    [178444] = 120301,
    [178445] = 120302,
    [181719] = 122628,
    [181720] = 122623,
    [181721] = 122621,
    [181722] = 122622,
    [181723] = 122631,
    [181724] = 122624,
    [181725] = 122625,
    [181726] = 122626,
    [181729] = 122630,
    [181730] = 122629,
    [181731] = 122627,
    [181732] = 122632,
    [181733] = 122633,
    [185205] = 124550,
    [185209] = 124551,
    [185210] = 124552,
    [185212] = 124553,
    [185213] = 124554,
    [185214] = 124555,
    [185215] = 124556,
    [185216] = 124557,
    [185217] = 124558,
    [185218] = 124559,
    [185219] = 124560,
    [185220] = 124561,
    [185222] = 124562,
    [187899] = 127777,
    [187900] = 127778,
    [187901] = 127779,
    [187902] = 127780,
    [187903] = 127781,
    [187904] = 127782,
    [187905] = 127783,
    [187906] = 127784,
    [187907] = 127798,
    [187908] = 127799,
    [187909] = 127800,
    [187911] = 127790,
    [187912] = 127791,
    [187913] = 127792,
    [187914] = 127793,
    [187915] = 127794,
    [187916] = 127795,
    [187917] = 127796,
    [187918] = 127797,
    [187919] = 127803,
    [187920] = 127804,
    [187921] = 127805,
    [187922] = 127806,
    [187923] = 127807,
    [187924] = 127808,
    [187925] = 127809,
    [187926] = 127810,
    [187927] = 127816,
    [187928] = 127817,
    [187929] = 127818,
    [187930] = 127819,
    [187931] = 127820,
    [187932] = 127821,
    [187933] = 127822,
    [187934] = 127823,
    [189834] = 128348,
    [211972] = 137198,
    [212883] = 137414,
    [220971] = 139593,
    [220972] = 139594,
    [220973] = 140590,
    [225513] = 141025,
    [227022] = 141410,
    [228214] = 141860,
    [240411] = 147212,
    [240412] = 147213,
    [240413] = 147214,
    [240414] = 147216,
    [240415] = 147217,
    [240416] = 147218,
    [240417] = 147219,
    [240418] = 147220,
    [240419] = 147221,
    [240420] = 147222,
    [240421] = 147223,
    [240422] = 147215,
    [240485] = 147298,
    [240487] = 147294,
    [240508] = 147295,
    [240509] = 147296,
    [240510] = 147299,
    [240511] = 147297,
    [240512] = 147300,
    [240513] = 147301,
    [240514] = 147302,
    [240515] = 147303,
    [240516] = 147304,
    [240518] = 147305,
    [242113] = 146750,
    [242317] = 146748,
    [242318] = 146749,
    [242319] = 146747,
    [242320] = 146751,
    [242321] = 146752,
    [242322] = 146753,
    [242842] = 147786,
    [242854] = 147791,
    [242855] = 147792,
    [242856] = 147793,
    [242857] = 147794,
    [242858] = 147795,
    [242859] = 147796,
    [242860] = 147797,
    [242861] = 147798,
    [242862] = 147799,
    [242863] = 147800,
    [242864] = 147801,
    [243074] = 147837,
    [243126] = 146897,
    [243127] = 146899,
    [243128] = 146901,
    [243131] = 146898,
    [243132] = 146900,
    [243133] = 146902,
    [243134] = 147384,
    [243135] = 147361,
    [243301] = 147875,
    [244052] = 150581,
    [246755] = 151470,
    [246756] = 151471,
    [246757] = 151469,
    [246758] = 151468,
    [246759] = 151464,
    [246760] = 151466,
    [246761] = 151465,
    [246762] = 151467,
    [247515] = 151638,
    [249084] = 152102,
    [249087] = 152105,
    [249088] = 152106,
    [249090] = 152107,
    [249091] = 152108,
    [252080] = 152649,
    [252882] = 152733,
    [252883] = 152735,
    [252884] = 153144,
    [252886] = 153154,
    [252887] = 153156,
    [252889] = 153141,
    [252890] = 152742,
    [252891] = 153135,
    [252892] = 152740,
    [252893] = 152734,
    [252894] = 152736,
    [252895] = 152738,
    [253033] = 152799,
    [253747] = 152922,
    [253748] = 152923,
    [254385] = 152650,
    [254386] = 152652,
    [254617] = 153142,
    [254622] = 153150,
    [254623] = 153158,
    [254624] = 153136,
    [254625] = 153152,
    [254626] = 152743,
    [254628] = 152737,
    [254629] = 153146,
    [254630] = 153138,
    [254631] = 152744,
    [254632] = 153140,
    [254633] = 153148,
    [254634] = 152739,
    [254635] = 153149,
    [254636] = 153157,
    [254637] = 153137,
    [254638] = 153145,
    [254639] = 153153,
    [254641] = 152741,
    [254642] = 153143,
    [254645] = 153151,
    [254646] = 153139,
    [254648] = 153147,
    [254649] = 153155,
    [254773] = 153215,
    [254774] = 153209,
    [254775] = 153208,
    [254776] = 153206,
    [254777] = 153210,
    [254778] = 153205,
    [254779] = 153212,
    [254780] = 153207,
    [254781] = 153214,
    [254782] = 153216,
    [254783] = 153211,
    [254784] = 153213,
    [254785] = 153059,
    [254786] = 153060,
    [254787] = 153061,
    [254788] = 153062,
    [254789] = 153063,
    [254790] = 153064,
    [254791] = 153065,
    [254792] = 153066,
    [254793] = 153067,
    [254794] = 153068,
    [257630] = 154903,
    [257631] = 154904,
    [257632] = 154905,
    [257633] = 154906,
    [257634] = 154907,
    [257635] = 154908,
    [257636] = 154909,
    [257637] = 154910,
    [257638] = 154911,
    [257639] = 154912,
    [257992] = 153135,
    [257993] = 153151,
    [257994] = 152741,
    [257995] = 153143,
    [262946] = 157796,
    [263148] = 157822,
    [263149] = 157823,
    [263150] = 157824,
    [263151] = 157825,
    [263152] = 157826,
    [263153] = 157827,
    [263154] = 157828,
    [263155] = 157829,
    [263156] = 157830,
    [263157] = 157831,
    [277914] = 162611,
    [285433] = 165658,
    [286410] = 165839,
    [289027] = 166505,
    [289090] = 166508,
    [289092] = 166509,
    [289093] = 166513,
    [289094] = 166514,
    [289095] = 166515,
    [289097] = 166510,
    [289098] = 166511,
    [289099] = 166512,
    [289142] = 166529,
    [289143] = 166530,
    [289144] = 166531,
    [289145] = 166535,
    [289146] = 166536,
    [289147] = 166537,
    [289148] = 166532,
    [289150] = 166533,
    [289151] = 166534,
}
private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_BY_CLASS_ID_MAP = {
    [178209] = { [1] = 119318, [2] = 119305, [3] = 119318, [4] = 119315, [5] = 119305, [6] = 119315, [7] = 119318, [8] = 119315, [9] = 119305, [10] = 119318, [11] = 119315, },
    [178210] = { [1] = 119320, [2] = 119307, [3] = 119320, [4] = 119313, [5] = 119307, [6] = 119313, [7] = 119320, [8] = 119313, [9] = 119307, [10] = 119320, [11] = 119313, },
    [178211] = { [1] = 119319, [2] = 119306, [3] = 119319, [4] = 119311, [5] = 119306, [6] = 119311, [7] = 119319, [8] = 119311, [9] = 119306, [10] = 119319, [11] = 119311, },
    [178212] = { [1] = 119321, [2] = 119308, [3] = 119321, [4] = 119312, [5] = 119308, [6] = 119312, [7] = 119321, [8] = 119312, [9] = 119308, [10] = 119321, [11] = 119312, },
    [178213] = { [1] = 119322, [2] = 119309, [3] = 119322, [4] = 119314, [5] = 119309, [6] = 119314, [7] = 119322, [8] = 119314, [9] = 119309, [10] = 119322, [11] = 119314, },
    [178216] = { [1] = 120225, [2] = 120215, [3] = 120225, [4] = 120218, [5] = 120215, [6] = 120218, [7] = 120225, [8] = 120218, [9] = 120215, [10] = 120225, [11] = 120218, },
    [178217] = { [1] = 120222, [2] = 120212, [3] = 120222, [4] = 120221, [5] = 120212, [6] = 120221, [7] = 120222, [8] = 120221, [9] = 120212, [10] = 120222, [11] = 120221, },
    [178218] = { [1] = 120224, [2] = 120214, [3] = 120224, [4] = 120219, [5] = 120214, [6] = 120219, [7] = 120224, [8] = 120219, [9] = 120214, [10] = 120224, [11] = 120219, },
    [178219] = { [1] = 120223, [2] = 120213, [3] = 120223, [4] = 120217, [5] = 120213, [6] = 120217, [7] = 120223, [8] = 120217, [9] = 120213, [10] = 120223, [11] = 120217, },
    [178220] = { [1] = 120226, [2] = 120216, [3] = 120226, [4] = 120220, [5] = 120216, [6] = 120220, [7] = 120226, [8] = 120220, [9] = 120216, [10] = 120226, [11] = 120220, },
    [178221] = { [1] = 120239, [2] = 120229, [3] = 120239, [4] = 120234, [5] = 120229, [6] = 120234, [7] = 120239, [8] = 120234, [9] = 120229, [10] = 120239, [11] = 120234, },
    [178222] = { [1] = 120238, [2] = 120228, [3] = 120238, [4] = 120232, [5] = 120228, [6] = 120232, [7] = 120238, [8] = 120232, [9] = 120228, [10] = 120238, [11] = 120232, },
    [178223] = { [1] = 120241, [2] = 120231, [3] = 120241, [4] = 120235, [5] = 120231, [6] = 120235, [7] = 120241, [8] = 120235, [9] = 120231, [10] = 120241, [11] = 120235, },
    [178224] = { [1] = 120240, [2] = 120230, [3] = 120240, [4] = 120233, [5] = 120230, [6] = 120233, [7] = 120240, [8] = 120233, [9] = 120230, [10] = 120240, [11] = 120233, },
    [178225] = { [1] = 120237, [2] = 120227, [3] = 120237, [4] = 120236, [5] = 120227, [6] = 120236, [7] = 120237, [8] = 120236, [9] = 120227, [10] = 120237, [11] = 120236, },
    [178226] = { [1] = 120255, [2] = 120245, [3] = 120255, [4] = 120248, [5] = 120245, [6] = 120248, [7] = 120255, [8] = 120248, [9] = 120245, [10] = 120255, [11] = 120248, },
    [178227] = { [1] = 120252, [2] = 120242, [3] = 120252, [4] = 120251, [5] = 120242, [6] = 120251, [7] = 120252, [8] = 120251, [9] = 120242, [10] = 120252, [11] = 120251, },
    [178228] = { [1] = 120254, [2] = 120244, [3] = 120254, [4] = 120249, [5] = 120244, [6] = 120249, [7] = 120254, [8] = 120249, [9] = 120244, [10] = 120254, [11] = 120249, },
    [178229] = { [1] = 120253, [2] = 120243, [3] = 120253, [4] = 120247, [5] = 120243, [6] = 120247, [7] = 120253, [8] = 120247, [9] = 120243, [10] = 120253, [11] = 120247, },
    [178230] = { [1] = 120256, [2] = 120246, [3] = 120256, [4] = 120250, [5] = 120246, [6] = 120250, [7] = 120256, [8] = 120250, [9] = 120246, [10] = 120256, [11] = 120250, },
    [188421] = { [1] = 127963, [2] = 127953, [3] = 127963, [4] = 127962, [5] = 127953, [6] = 127962, [7] = 127963, [8] = 127962, [9] = 127953, [10] = 127963, [11] = 127962, },
    [188422] = { [1] = 127964, [2] = 127954, [3] = 127964, [4] = 127958, [5] = 127954, [6] = 127958, [7] = 127964, [8] = 127958, [9] = 127954, [10] = 127964, [11] = 127958, },
    [188423] = { [1] = 127966, [2] = 127956, [3] = 127966, [4] = 127959, [5] = 127956, [6] = 127959, [7] = 127966, [8] = 127959, [9] = 127956, [10] = 127966, [11] = 127959, },
    [188425] = { [1] = 127965, [2] = 127955, [3] = 127965, [4] = 127960, [5] = 127955, [6] = 127960, [7] = 127965, [8] = 127960, [9] = 127955, [10] = 127965, [11] = 127960, },
    [188426] = { [1] = 127967, [2] = 127957, [3] = 127967, [4] = 127961, [5] = 127957, [6] = 127961, [7] = 127967, [8] = 127961, [9] = 127957, [10] = 127967, [11] = 127961, },
    [188427] = { [1] = 127970, [2] = 127969, [3] = 127970, [4] = 127968, [5] = 127969, [6] = 127968, [7] = 127970, [8] = 127968, [9] = 127969, [10] = 127970, [11] = 127968, },
}

-- List of items that, when right-clicked, reward loot (includes items from DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP).
-- This means they -must- be tracked via CHAT_MSG_LOOT.
-- It also means there is a high margin for bad data since multiple bags can be clicked within a small time frame.
-- True = instant cast; false = cast time
private.CONTAINER_ITEM_ID_LIST = {
    [21740] = true,
    [21741] = true,
    [21742] = true,
    [21743] = true,
    [32624] = true,
    [32625] = true,
    [32626] = true,
    [32627] = true,
    [32628] = true,
    [32629] = true,
    [32630] = true,
    [32631] = true,
    [33844] = true,
    [33857] = true,
    [35348] = true,
    [39418] = true,
    [44113] = true,
    [46007] = true,
    [49909] = true,
    [50160] = true,
    [50161] = true,
    [67414] = true,
    [69856] = true,
    [87701] = true,
    [87702] = true,
    [87703] = true,
    [87704] = true,
    [87705] = true,
    [87706] = true,
    [87707] = true,
    [87708] = true,
    [87709] = true,
    [87710] = true,
    [87712] = true,
    [87713] = true,
    [87714] = true,
    [87715] = true,
    [87716] = true,
    [87721] = true,
    [87722] = true,
    [87723] = true,
    [87724] = true,
    [87725] = true,
    [87726] = true,
    [87727] = true,
    [87728] = true,
    [87729] = true,
    [87730] = true,
    [89607] = true,
    [89608] = true,
    [89609] = true,
    [93198] = true,
    [93199] = true,
    [93200] = true,
    [95569] = true,
    [95570] = true,
    [95571] = true,
    [95572] = true,
    [95573] = true,
    [95574] = true,
    [95575] = true,
    [95576] = true,
    [95577] = true,
    [95578] = true,
    [95579] = true,
    [95580] = true,
    [95581] = true,
    [95582] = true,
    [95583] = true,
    [95822] = true,
    [95823] = true,
    [95824] = true,
    [95855] = true,
    [95856] = true,
    [95857] = true,
    [95879] = true,
    [95880] = true,
    [95881] = true,
    [95887] = true,
    [95888] = true,
    [95889] = true,
    [95955] = true,
    [95956] = true,
    [95957] = true,
    [96566] = true,
    [96567] = true,
    [96568] = true,
    [96599] = true,
    [96600] = true,
    [96601] = true,
    [96623] = true,
    [96624] = true,
    [96625] = true,
    [96631] = true,
    [96632] = true,
    [96633] = true,
    [96699] = true,
    [96700] = true,
    [96701] = true,
    [104260] = true,
    [110592] = true,
    [111598] = true,
    [111599] = true,
    [111600] = true,
    [114028] = true,
    [114634] = true,
    [114641] = true,
    [114648] = true,
    [114655] = true,
    [114662] = true,
    [114669] = true,
    [114970] = true,
    [116111] = true,
    [116376] = true,
    [116764] = true,
    [116980] = true,
    [118065] = true,
    [118066] = true,
    [118093] = true,
    [118094] = true,
    [118529] = true,
    [118530] = true,
    [118531] = true,
    [119000] = true,
    [119036] = true,
    [119037] = true,
    [119040] = true,
    [119041] = true,
    [119042] = true,
    [119043] = true,
    [119330] = true,
    [120142] = true,
    [120151] = true,
    [120184] = true,
    [120319] = true,
    [120320] = true,
    [120353] = true,
    [120354] = true,
    [120355] = true,
    [120356] = true,
    [122163] = true,
    [122241] = true,
    [122242] = true,
    [122478] = true,
    [122479] = true,
    [122480] = true,
    [122481] = true,
    [122482] = true,
    [122483] = true,
    [122484] = true,
    [122485] = true,
    [122486] = true,
    [122579] = true,
    [122608] = true,
    [122718] = true,
    [123857] = true,
    [123858] = true,
    [123975] = true,
    [124054] = true,
    [126901] = true,
    [126902] = true,
    [126903] = true,
    [126904] = true,
    [126905] = true,
    [126906] = true,
    [126907] = true,
    [126908] = true,
    [126909] = true,
    [126910] = true,
    [126911] = true,
    [126912] = true,
    [126913] = true,
    [126914] = true,
    [126915] = true,
    [126916] = true,
    [126917] = true,
    [126918] = true,
    [126919] = true,
    [126920] = true,
    [126921] = true,
    [126922] = true,
    [126923] = true,
    [126924] = true,
    [127831] = true,
    [127853] = true,
    [127854] = true,
    [127855] = true,
    [127995] = true,
    [128213] = true,
    [128214] = true,
    [128215] = true,
    [128216] = true,
    [128327] = true,
    [128391] = true,
    [128472] = true,
    [128473] = true,
    [128670] = true,
    [132892] = true,
    [133549] = true,
    [135539] = true,
    [135540] = true,
    [135541] = true,
    [135542] = true,
    [135543] = true,
    [135544] = true,
    [135545] = true,
    [135546] = true,
    [137560] = true,
    [137561] = true,
    [137562] = true,
    [137563] = true,
    [137564] = true,
    [137565] = true,
    [138098] = true,
    [138469] = true,
    [138470] = true,
    [138471] = true,
    [138472] = true,
    [138473] = true,
    [138474] = true,
    [138475] = true,
    [138476] = true,
    [139048] = true,
    [139049] = true,
    [139467] = true,
    [139484] = true,
    [139486] = true,
    [139487] = true,
    [139488] = true,
    [139771] = true,
    [139879] = true,
    [140148] = true,
    [140150] = true,
    [140152] = true,
    [140154] = true,
    [140200] = true,
    [140997] = true,
    [140998] = true,
    [141069] = true,
    [141155] = true,
    [141156] = true,
    [141157] = true,
    [141158] = true,
    [141159] = true,
    [141160] = true,
    [141161] = true,
    [141162] = true,
    [141163] = true,
    [141164] = true,
    [141165] = true,
    [141166] = true,
    [141167] = true,
    [141168] = true,
    [141169] = true,
    [141170] = true,
    [141171] = true,
    [141172] = true,
    [141173] = true,
    [141174] = true,
    [141175] = true,
    [141176] = true,
    [141177] = true,
    [141178] = true,
    [141179] = true,
    [141180] = true,
    [141181] = true,
    [141182] = true,
    [141183] = true,
    [141184] = true,
    [141344] = true,
    [141350] = true,
    [141995] = true,
    [142023] = true,
    [142342] = true,
    [143606] = true,
    [143607] = true,
    [143617] = true,
    [143948] = true,
    [146948] = true,
    [147432] = true,
    [147446] = true,
    [147518] = true,
    [147519] = true,
    [147520] = true,
    [147521] = true,
    [147905] = true,
    [150924] = true,
    [151557] = true,
    [151558] = true,
    [153132] = true,
    [153501] = true,
    [153502] = true,
    [153503] = true,
    [153504] = true,
    [153574] = true,
    [154991] = true,
    [154992] = true,
    [156682] = true,
    [156683] = true,
    [156688] = true,
    [156689] = true,
    [156698] = true,
    [159783] = true,
    [160439] = true,
    [161083] = true,
    [161084] = true,
    [163059] = true,
    [163139] = true,
    [163141] = true,
    [163142] = true,
    [163144] = true,
    [163146] = true,
    [163148] = true,
    [163734] = true,
    [164251] = true,
    [164252] = true,
    [164257] = true,
    [164258] = true,
    [164259] = true,
    [164260] = true,
    [164261] = true,
    [164262] = true,
    [164263] = true,
    [164264] = true,
    [165729] = true,
    [165730] = true,
    [165731] = true,
    [165732] = true,
    [166245] = true,
    [166282] = true,
    [166290] = true,
    [166292] = true,
    [166294] = true,
    [166295] = true,
    [166297] = true,
    [166298] = true,
    [166299] = true,
    [166300] = true,
}
for key, value in next, private.DELAYED_CONTAINER_SPELL_ID_TO_ITEM_ID_MAP do
    private.CONTAINER_ITEM_ID_LIST[value] = false
end

-- Mapping of Spell IDs for bonus roll confirmation prompts to raid bosses
-- In some cases this records only bonus loot, and in other cases this is needed for all loot.
private.RAID_BOSS_BONUS_SPELL_ID_TO_NPC_ID_MAP = {
    -----------------------------------------------------------------------
    -- World Bosses
    -----------------------------------------------------------------------
    [132205] = 60491, -- Sha of Anger Bonus (Sha of Anger)
    [132206] = 62346, -- Galleon Bonus (Galleon)
    [136381] = 69099, -- Nalak Bonus (Nalak)
    [137554] = 69161, -- Oondasta Bonus (Oondasta)
    [148317] = 71952, -- Celestials Bonus (Chi-Ji)
    [148316] = 72057, -- Ordos Bonus (Ordos)
    [178847] = 81252, -- Drov Bonus (Drov the Ruiner)
    [178849] = 81535, -- Tarlna Bonus (Tarlna the Ageless)
    [178851] = 83746, -- Rukhmar Bonus (Rukhmar)
    [188985] = 94015, -- 6.2 Raid Bonus Roll Prompt - World Boss 01 (Supreme Lord Kazzak)
    [227128] = 109943, -- 7.0 Raid World Boss - Bonus Roll Prompt (Ana-Mouz)
    [227129] = 109331, -- 7.0 Raid World Boss - Bonus Roll Prompt (Calamir)
    [227130] = 110378, -- 7.0 Raid World Boss - Bonus Roll Prompt (Drugon the Frostblood)
    [227131] = 99929, -- 7.0 Raid World Boss - Bonus Roll Prompt (Flotsam)
    [227132] = 108879, -- 7.0 Raid World Boss - Bonus Roll Prompt (Humongris)
    [227133] = 108829, -- 7.0 Raid World Boss - Bonus Roll Prompt (Levantus)
    [227134] = 110321, -- 7.0 Raid World Boss - Bonus Roll Prompt (Na'zak the Fiend)
    [227135] = 107023, -- 7.0 Raid World Boss - Bonus Roll Prompt (Nithogg)
    [227136] = 108678, -- 7.0 Raid World Boss - Bonus Roll Prompt (Shar'thos)
    [227137] = 106981, -- 7.0 Raid World Boss - Bonus Roll Prompt (Captain Hring) (Soultakers)
    [227138] = 102075, -- 7.0 Raid World Boss - Bonus Roll Prompt (Withered J'im)
    [242969] = 121124, -- 7.2 Raid World Boss - Bonus Roll Prompt (Apocron)
    [242970] = 117239, -- 7.2 Raid World Boss - Bonus Roll Prompt (Brutallus)
    [242971] = 117303, -- 7.2 Raid World Boss - Bonus Roll Prompt (Malificus)
    [242972] = 117470, -- 7.2 Raid World Boss - Bonus Roll Prompt (Si'vash)
    [244164] = 121818, -- 7.2.5 Raid World Boss - Bonus Roll Prompt (Lord Kazzak)
    [244165] = 121820, -- 7.2.5 Raid World Boss - Bonus Roll Prompt (Azuregos)
    [244166] = 121911, -- 7.2.5 Raid World Boss - Bonus Roll Prompt (Taerar)
    [244182] = 121913, -- 7.2.5 Raid World Boss - Bonus Roll Prompt (Emeriss)
    [244183] = 121912, -- 7.2.5 Raid World Boss - Bonus Roll Prompt (Ysondre)
    [244184] = 121821, -- 7.2.5 Raid World Boss - Bonus Roll Prompt (Lethon)
    [254435] = 124592, -- 7.3 Raid World Boss - Bonus Roll Prompt (Inquisitor Meto)
    [254437] = 124625, -- 7.3 Raid World Boss - Bonus Roll Prompt (Mistress Alluradel)
    [254439] = 124719, -- 7.3 Raid World Boss - Bonus Roll Prompt (Pit Lord Vilemus)
    [254441] = 124514, -- 7.3 Raid World Boss - Bonus Roll Prompt (Matron Folnuna)
    [254443] = 124492, -- 7.3 Raid World Boss - Bonus Roll Prompt (Occularus)
    [254446] = 124555, -- 7.3 Raid World Boss - Bonus Roll Prompt (Sotanathor)
    [275407] = 132701, -- 8.0 Raid World Boss - Bonus Roll Prompt (T'zane)
    [275408] = 140163, -- 8.0 Raid World Boss - Bonus Roll Prompt (Warbringer Yenajz)
    [275409] = 132253, -- 8.0 Raid World Boss - Bonus Roll Prompt (Ji'arak)
    [275411] = 136385, -- 8.0 Raid World Boss - Bonus Roll Prompt (Azurethos)
    [275413] = 138794, -- 8.0 Raid World Boss - Bonus Roll Prompt (Dunegorger Kraulok)
    [275414] = 140252, -- 8.0 Raid World Boss - Bonus Roll Prompt (Hailstone Construct)
    [275415] = 138122, -- 8.0 Raid World Boss - Bonus Roll Prompt (Doom's Howl)
    [275416] = 137374, -- 8.0 Raid World Boss - Bonus Roll Prompt (Lion's Roar)
    [289528] = 144946, -- 8.1 Raid World Boss - Bonus Roll Prompt (Ivus the Forest Lord)
    [289530] = 148295, -- 8.1 Raid World Boss - Bonus Roll Prompt (Ivus the Decayed)

    -----------------------------------------------------------------------
    -- Uldir
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- Antorus, the Burning Throne
    -----------------------------------------------------------------------
    [250588] = 122450, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 01 (Garothi Worldbreaker)
    [250598] = 122135, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 02 (Shatug)
    [250600] = 122104, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 03 (Portal Keeper Hasabel)
    [250601] = 122367, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 04 (Admiral Svirax)
    [250602] = 122500, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 05 (Essence of Eonar)
    [250603] = 124158, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 06 (Imonar the Soulhunter)
    [250604] = 122578, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 07 (Kin'garoth)
    [250605] = 122366, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 08 (Varimathras)
    [250606] = 122467, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 09 (Asara, Mother of Night)
    [250607] = 121975, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 10 (Aggramar)
    [250608] = 124828, -- 7.3 Raid Antorus - Bonus Roll Prompt - Boss 11 (Argus)

    -----------------------------------------------------------------------
    -- Hellfire Citadel
    -----------------------------------------------------------------------
    [188972] = 93023, -- 6.2 Raid Bonus Roll Prompt - Boss 1 (Siegemaster Mar'tak)
    [188973] = 90284, -- 6.2 Raid Bonus Roll Prompt - Boss 2 (Iron Reaver)
    [188974] = 90435, -- 6.2 Raid Bonus Roll Prompt - Boss 3 (Kormrok)
    [188975] = 92142, -- 6.2 Raid Bonus Roll Prompt - Boss 4 (Blademaster Jubei'thos)
    [188976] = 90378, -- 6.2 Raid Bonus Roll Prompt - Boss 5 (Kilrogg Deadeye)
    [188977] = 90199, -- 6.2 Raid Bonus Roll Prompt - Boss 6 (Gorefiend)
    [188978] = 90316, -- 6.2 Raid Bonus Roll Prompt - Boss 7 (Shadow-Lord Iskar)
    [188979] = 90296, -- 6.2 Raid Bonus Roll Prompt - Boss 8 (Soulbound Construct)
    [188980] = 89890, -- 6.2 Raid Bonus Roll Prompt - Boss 9 (Fel Lord Zakuun)
    [188981] = 93068, -- 6.2 Raid Bonus Roll Prompt - Boss 10 (Xhul'horac)
    [188982] = 90269, -- 6.2 Raid Bonus Roll Prompt - Boss 11 (Tyrant Velhari)
    [188983] = 91349, -- 6.2 Raid Bonus Roll Prompt - Boss 12 (Mannoroth)
    [188984] = 91331, -- 6.2 Raid Bonus Roll Prompt - Boss 13 (Archimonde)

    -----------------------------------------------------------------------
    -- Blackrock Foundry
    -----------------------------------------------------------------------
    [177530] = 77182, -- Oregorger Bonus (Oregorger)
    [177529] = 76877, -- Gruul Bonus (Gruul)
    [177533] = 76973, -- Hans'gar & Franzok Bonus (Hans'gar)
    [177536] = 76865, -- Beastlord Darmac Bonus (Beastlord Darmac)
    [177534] = 76814, -- Flamebender Ka'graz Bonus (Flamebender Ka'graz)
    [177537] = 76906, -- Operator Thogar Bonus (Operator Thogar)
    [177531] = 76809, -- Blast Furnace (Foreman Feldspar)
    [177535] = 77692, -- Kromog Bonus (Kromog)
    [177538] = 77557, -- The Iron Maidens Bonus (Admiral Gar'an)
    [177539] = 77325, -- Blackhand Bonus (Blackhand)

    -----------------------------------------------------------------------
    -- Highmaul
    -----------------------------------------------------------------------
    [177521] = 78714, -- Kargath Bladefist Bonus (Kargath Bladefist)
    [177522] = 77404, -- Butcher Bonus (The Butcher)
    [177524] = 78491, -- Brackenspore Bonus (Brackenspore)
    [177523] = 78948, -- Tectus Bonus (Tectus)
    [177525] = 78237, -- Twin Ogron Bonus (Phemos)
    [177526] = 79015, -- Ko'ragh Bonus (Ko'ragh)
    [177528] = 77428, -- Imperator Mar'gok Bonus (Imperator Mar'gok)

    -----------------------------------------------------------------------
    -- Mists of Pandaria
    -----------------------------------------------------------------------
    [125144] = 59915, -- Stone Guard Bonus (Jasper Guardian)
    [132189] = 60009, -- Feng the Accursed Bonus (Feng the Accursed)
    [132190] = 60143, -- Gara'jal the Spiritbinder Bonus (Gara'jal the Spiritbinder)
    [132191] = 60709, -- Spirit Kings Bonus (Qiang the Merciless)
    [132192] = 60410, -- Elegon Bonus (Elegon)
    [132193] = 60399, -- Will of the Emperor Bonus (Qin-xi)
    [132200] = 60583, -- Protectors of the Endless Bonus (Protector Kaolan)
    [132204] = 60583, -- Protectors of the Endless (Elite) Bonus (Protector Kaolan)
    [132201] = 62442, -- Tsulong Bonus (Tsulong)
    [132202] = 62983, -- Lei Shi Bonus (Lei Shi)
    [132203] = 60999, -- Sha of Fear Bonus (Sha of Fear)
    [132194] = 62980, -- Imperial Vizier Zor'lok Bonus (Imperial Vizier Zor'lok)
    [132195] = 62543, -- Blade Lord Tay'ak Bonus (Blade Lord Ta'yak)
    [132196] = 62164, -- Garalon Bonus (Garalon)
    [132197] = 62397, -- Wind Lord Mel'jarak Bonus (Wind Lord Mel'jarak)
    [132198] = 62511, -- Amber-Shaper Un'sok Bonus (Amber-Shaper Un'sok)
    [132199] = 62837, -- Grand Empress Shek'zeer Bonus (Grand Empress Shek'zeer)
    [139674] = 69465, -- Jin'rokh the Breaker Bonus (Jin'rokh the Breaker)
    [139677] = 68476, -- Horridon Bonus (Horridon)
    [139679] = 69078, -- Zandalari Troll Council Bonus (Sul the Sandcrawler)
    [139680] = 67977, -- Tortos Bonus (Tortos)
    [139682] = 68065, -- Magaera Bonus (Megaera)
    [139684] = 69712, -- Ji'kun, the Ancient Mother Bonus (Ji-Kun)
    [139686] = 68036, -- Durumu the Forgotten Bonus (Durumu the Forgotten)
    [139687] = 69017, -- Primordious Bonus (Primordius)
    [139688] = 69427, -- Dark Animus Bonus (Dark Animus)
    [139689] = 68078, -- Iron Qon Bonus (Iron Qon)
    [139690] = 68904, -- The Empyreal Queens Bonus (Suen)
    [139691] = 68397, -- Lei Shen, The Thunder King Bonus (Lei Shen)
    [139692] = 69473, -- Ra-den Bonus (Ra-den)
    [145909] = 71543, -- Immerseus Bonus (Immerseus)
    [145910] = 71475, -- Fallen Protectors Bonus (Rook Stonetoe)
    [145911] = 72276, -- Norushen Bonus (Amalgam of Corruption)
    [145912] = 71734, -- Sha of Pride Bonus (Sha of Pride)
    [145913] = 72249, -- Galakras Bonus (Galakras)
    [145914] = 71466, -- Iron Juggernaut Bonus (Iron Juggernaut)
    [145915] = 71859, -- Dark Shaman Bonus (Earthbreaker Haromm)
    [145916] = 71515, -- General Nazgrim Bonus (General Nazgrim)
    [145917] = 71454, -- Malkorok Bonus (Malkorok)
    [145919] = 71889, -- Spoils of Pandaria Bonus (Secured Stockpile of Pandaren Spoils)
    [145920] = 71529, -- Thok the Bloodthirsty Bonus (Thok the Bloodthirsty)
    [145918] = 71504, -- Siegecrafter Blackfuse Bonus (Siegecrafter Blackfuse)
    [145921] = 71161, -- Klaxxi Paragons Bonus (Kil'ruk the Wind-Reaver)
    [145922] = 71865, -- Garrosh Hellscream Bonus (Garrosh Hellscream)
}


-----------------------------------------------------------------------
-- Fundamental Constants.
-----------------------------------------------------------------------
private.wow_version, private.build_num, _, private.interface_num = _G.GetBuildInfo()

private.GENDER_NAMES = {
    "UNKNOWN",
    "MALE",
    "FEMALE",
}

private.REACTION_NAMES = {
    "HATED",
    "HOSTILE",
    "UNFRIENDLY",
    "NEUTRAL",
    "FRIENDLY",
    "HONORED",
    "REVERED",
    "EXALTED",
}

private.STANDING_DISCOUNTS = {
    HATED = 0,
    HOSTILE = 0,
    UNFRIENDLY = 0,
    NEUTRAL = 0,
    FRIENDLY = 0.05,
    HONORED = 0.1,
    REVERED = 0.15,
    EXALTED = 0.2,
}
    
-- We should just use IDs here someday; WoWDB site knows all about different power types
private.POWER_TYPE_NAMES = {
    ["0"] = "MANA",
    ["1"] = "RAGE",
    ["2"] = "FOCUS",
    ["3"] = "ENERGY",
    ["6"] = "RUNIC_POWER",
}

private.UNIT_TYPES = {
    PLAYER = "Player",
    OBJECT = "GameObject",
    UNKNOWN = "Unknown",
    NPC = "Creature",
    PET = "Pet",
    VEHICLE = "Vehicle",
    ITEM = "Item",
}

private.UNIT_TYPE_NAMES = {
    ["Player"] = "PLAYER",
    ["GameObject"] = "OBJECT",
    ["Unknown"] = "UNKNOWN",
    ["Creature"] = "NPC",
    ["Pet"] = "PET",
    ["Vehicle"] = "VEHICLE",
    ["Item"] = "ITEM",
}

private.ACTION_TYPE_FLAGS = {
    ITEM = 0x00000001,
    NPC = 0x00000002,
    OBJECT = 0x00000004,
    ZONE = 0x00000008,
}

private.ACTION_TYPE_NAMES = {}

for name, bit in _G.pairs(private.ACTION_TYPE_FLAGS) do
    private.ACTION_TYPE_NAMES[bit] = name
end

private.SPELL_LABELS_BY_NAME = {
    [_G.GetSpellInfo(13262)] = "DISENCHANT",
    [_G.GetSpellInfo(4036)] = "ENGINEERING",
    [_G.GetSpellInfo(30427)] = "EXTRACT_GAS",
    [_G.GetSpellInfo(131476)] = "FISHING",
    [_G.GetSpellInfo(2366)] = "HERB_GATHERING",
    [_G.GetSpellInfo(51005)] = "MILLING",
    [_G.GetSpellInfo(605)] = "MIND_CONTROL",
    [_G.GetSpellInfo(2575)] = "MINING",
    [_G.GetSpellInfo(3365)] = "OPENING",
    [_G.GetSpellInfo(921)] = "PICK_POCKET",
    [_G.GetSpellInfo(31252)] = "PROSPECTING",
    [_G.GetSpellInfo(73979)] = "SEARCHING_FOR_ARTIFACTS",
    [_G.GetSpellInfo(8613)] = "SKINNING",
}

private.NON_LOOT_SPELL_LABELS = {
    MIND_CONTROL = true,
}

local AF = private.ACTION_TYPE_FLAGS

private.SPELL_FLAGS_BY_LABEL = {
    DISENCHANT = AF.ITEM,
    ENGINEERING = AF.NPC,
    EXTRACT_GAS = AF.ZONE,
    FISHING = AF.ZONE,
    HERB_GATHERING = bit.bor(AF.NPC, AF.OBJECT),
    MILLING = AF.ITEM,
    MIND_CONTROL = AF.NPC,
    MINING = bit.bor(AF.NPC, AF.OBJECT),
    OPENING = AF.OBJECT,
    PICK_POCKET = AF.NPC,
    PROSPECTING = AF.ITEM,
    SEARCHING_FOR_ARTIFACTS = AF.OBJECT,
    SKINNING = AF.NPC,
}


-----------------------------------------------------------------------
-- Faction/Reputation Data Constants.
-----------------------------------------------------------------------

-- Table has: factionID, isBlacklisted, and then the returns from GetFactionInfoByID
private.FACTION_DATA = {
    -- Used only for private.REP_BUFFS
    ARGENT_CRUSADE = { 1106, false, _G.GetFactionInfoByID(1106) },
    BILGEWATER_CARTEL = { 1133, false, _G.GetFactionInfoByID(1133) },
    CENARION_CIRCLE = { 609, false, _G.GetFactionInfoByID(609) },
    DARKSPEAR = { 530, false, _G.GetFactionInfoByID(530) },
    DARNASSUS = { 69, false, _G.GetFactionInfoByID(69) },
    DRAGONMAW_CLAN = { 1172, false, _G.GetFactionInfoByID(1172) },
    EARTHEN_RING = { 1135, false, _G.GetFactionInfoByID(1135) },
    EBON_BLADE = { 1098, false, _G.GetFactionInfoByID(1098) },
    EXODAR = { 930, false, _G.GetFactionInfoByID(930) },
    GILNEAS = { 1134, false, _G.GetFactionInfoByID(1134) },
    GNOMEREGAN = { 54, false, _G.GetFactionInfoByID(54) },
    GUARDIANS_OF_HYJAL = { 1158, false, _G.GetFactionInfoByID(1158) },
    GUILD = { 1168, false, _G.GetFactionInfoByID(1168) },
    HONOR_HOLD = { 946, false, _G.GetFactionInfoByID(946) },
    HUOJIN = { 1352, false, _G.GetFactionInfoByID(1352) },
    IRONFORGE = { 47, false, _G.GetFactionInfoByID(47) },
    KIRIN_TOR = { 1090, false, _G.GetFactionInfoByID(1090) },
    ORGRIMMAR = { 76, false, _G.GetFactionInfoByID(76) },
    RAMKAHEN = { 1173, false, _G.GetFactionInfoByID(1173) },
    SHATAR = { 935, false, _G.GetFactionInfoByID(935) },
    SILVERMOON = { 911, false, _G.GetFactionInfoByID(911) },
    STORMWIND = { 72, false, _G.GetFactionInfoByID(72) },
    THERAZANE = { 1171, false, _G.GetFactionInfoByID(1171) },
    THRALLMAR = { 947, false, _G.GetFactionInfoByID(947) },
    THUNDER_BLUFF = { 81, false, _G.GetFactionInfoByID(81) },
    TUSHUI = { 1353, false, _G.GetFactionInfoByID(1353) },
    UNDERCITY = { 68, false, _G.GetFactionInfoByID(68) },
    WILDHAMMER_CLAN = { 1174, false, _G.GetFactionInfoByID(1174) },
    WYRMREST_ACCORD = { 1091, false, _G.GetFactionInfoByID(1091) },
    -- Commendation Factions
    ANGLERS = { 1302, false, _G.GetFactionInfoByID(1302) },
    AUGUST_CELESTIALS = { 1341, false, _G.GetFactionInfoByID(1341) },
    DOMINANCE_OFFENSIVE = { 1375, false, _G.GetFactionInfoByID(1375) },
    GOLDEN_LOTUS = { 1269, false, _G.GetFactionInfoByID(1269) },
    KIRIN_TOR_OFFENSIVE = { 1387, false, _G.GetFactionInfoByID(1387) },
    KLAXXI = { 1337, false, _G.GetFactionInfoByID(1337) },
    LOREWALKERS = { 1345, false, _G.GetFactionInfoByID(1345) },
    OPERATION_SHIELDWALL = { 1376, false, _G.GetFactionInfoByID(1376) },
    ORDER_OF_THE_CLOUD_SERPENTS = { 1271, false, _G.GetFactionInfoByID(1271) },
    SHADO_PAN = { 1270, false, _G.GetFactionInfoByID(1270) },
    SHADO_PAN_ASSAULT = { 1435, false, _G.GetFactionInfoByID(1435) },
    SUNREAVER_ONSLAUGHT = { 1388, false, _G.GetFactionInfoByID(1388) },
    TILLERS = { 1272, false, _G.GetFactionInfoByID(1272) },
    -- Bodyguards (blacklisted)
    DELVAR_IRONFIST = { 1733, true, _G.GetFactionInfoByID(1733) },
    TORMMOK = { 1736, true, _G.GetFactionInfoByID(1736) },
    TALONPRIEST_ISHAAL = { 1737, true, _G.GetFactionInfoByID(1737) },
    DEFENDER_ILLONA = { 1738, true, _G.GetFactionInfoByID(1738) },
    VIVIANNE = { 1739, true, _G.GetFactionInfoByID(1739) },
    AEDA_BRIGHTDAWN = { 1740, true, _G.GetFactionInfoByID(1740) },
    LEORAJH = { 1741, true, _G.GetFactionInfoByID(1741) },
    -- Legion reps (blacklisted because of world quests)
    COURT_OF_FARONDIS = { 1900, true, _G.GetFactionInfoByID(1900) },
    DREAMWEAVERS = { 1883, true, _G.GetFactionInfoByID(1883) },
    HIGHMOUNTAIN_TRIBE = { 1828, true, _G.GetFactionInfoByID(1828) },
    NIGHTFALLEN = { 1859, true, _G.GetFactionInfoByID(1859) },
    VALARJAR = { 1948, true, _G.GetFactionInfoByID(1948) },
    WARDENS = { 1894, true, _G.GetFactionInfoByID(1894) },
    ARMIES_OF_LEGIONFALL = { 2045, true, _G.GetFactionInfoByID(2045) },
    ARMY_OF_THE_LIGHT = { 2165, true, _G.GetFactionInfoByID(2165) },
    ARGUSSIAN_REACH = { 2170, true, _G.GetFactionInfoByID(2170) },
    -- BFA reps (blacklisted because of world quests)
    ZANDALARI_EMPIRE = { 2103, true, _G.GetFactionInfoByID(2103) },
    PROUDMOORE_ADMIRALITY = { 2160, true, _G.GetFactionInfoByID(2160) },
    TALNAJIS_EXPEDITION = { 2156, true, _G.GetFactionInfoByID(2156) },
    ORDER_OF_EMBERS = { 2161, true, _G.GetFactionInfoByID(2161) },
    VOLDUNAI = { 2158, true, _G.GetFactionInfoByID(2158) },
    STORMS_WAKE = { 2162, true, _G.GetFactionInfoByID(2162) },
    THE_HONORBOUND = { 2157, true, _G.GetFactionInfoByID(2157) },
    SEVENTH_LEGION = { 2159, true, _G.GetFactionInfoByID(2159) },
    CHAMPIONS_OF_AZEROTH = { 2164, true, _G.GetFactionInfoByID(2164) },
    TORTOLLAN_SEEKERS = { 2163, true, _G.GetFactionInfoByID(2163) },
}

private.REP_BUFFS = {
    -- Tabard Buffs (they screw up everything, so blacklist)
    [_G.GetSpellInfo(93830)] = { -- BILGEWATER CARTEL TABARD
        faction = private.FACTION_DATA.BILGEWATER_CARTEL[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93827)] = { -- DARKSPEAR TABARD
        faction = private.FACTION_DATA.DARKSPEAR[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93806)] = { -- DARNASSUS TABARD
        faction = private.FACTION_DATA.DARNASSUS[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93811)] = { -- EXODAR TABARD
        faction = private.FACTION_DATA.EXODAR[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93816)] = { -- GILNEAS TABARD
        faction = private.FACTION_DATA.GILNEAS[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93821)] = { -- GNOMEREGAN TABARD
        faction = private.FACTION_DATA.GNOMEREGAN[3],
        ignore = true,
    },
    [_G.GetSpellInfo(126436)] = { -- HUOJIN TABARD
        faction = private.FACTION_DATA.HUOJIN[3],
        ignore = true,
    },
    [_G.GetSpellInfo(97340)] = { -- ILLUSTRIOUS GUILD TABARD
        faction = private.FACTION_DATA.GUILD[3],
        modifier = 1,
    },
    [_G.GetSpellInfo(93805)] = { -- IRONFORGE TABARD
        faction = private.FACTION_DATA.IRONFORGE[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93825)] = { -- ORGRIMMAR TABARD
        faction = private.FACTION_DATA.ORGRIMMAR[3],
        ignore = true,
    },
    [_G.GetSpellInfo(97341)] = { -- RENOWNED GUILD TABARD
        faction = private.FACTION_DATA.GUILD[3],
        modifier = 0.5,
    },
    [_G.GetSpellInfo(93828)] = { -- SILVERMOON CITY TABARD
        faction = private.FACTION_DATA.SILVERMOON[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93795)] = { -- STORMWIND TABARD
        faction = private.FACTION_DATA.STORMWIND[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93337)] = { -- TABARD OF RAMKAHEN
        faction = private.FACTION_DATA.RAMKAHEN[3],
        ignore = true,
    },
    [_G.GetSpellInfo(57819)] = { -- TABARD OF THE ARGENT CRUSADE
        faction = private.FACTION_DATA.ARGENT_CRUSADE[3],
        ignore = true,
    },
    [_G.GetSpellInfo(94158)] = { -- TABARD OF THE DRAGONMAW CLAN
        faction = private.FACTION_DATA.DRAGONMAW_CLAN[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93339)] = { -- TABARD OF THE EARTHEN RING
        faction = private.FACTION_DATA.EARTHEN_RING[3],
        ignore = true,
    },
    [_G.GetSpellInfo(57820)] = { -- TABARD OF THE EBON BLADE
        faction = private.FACTION_DATA.EBON_BLADE[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93341)] = { -- TABARD OF THE GUARDIANS OF HYJAL
        faction = private.FACTION_DATA.GUARDIANS_OF_HYJAL[3],
        ignore = true,
    },
    [_G.GetSpellInfo(57821)] = { -- TABARD OF THE KIRIN TOR
        faction = private.FACTION_DATA.KIRIN_TOR[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93368)] = { -- TABARD OF THE WILDHAMMER CLAN
        faction = private.FACTION_DATA.WILDHAMMER_CLAN[3],
        ignore = true,
    },
    [_G.GetSpellInfo(57822)] = { -- TABARD OF THE WYRMREST ACCORD
        faction = private.FACTION_DATA.WYRMREST_ACCORD[3],
        ignore = true,
    },
    [_G.GetSpellInfo(93347)] = { -- TABARD OF THERAZANE
        faction = private.FACTION_DATA.THERAZANE[3],
        ignore = true,
    },
    [_G.GetSpellInfo(94463)] = { -- THUNDERBLUFF TABARD
        faction = private.FACTION_DATA.THUNDER_BLUFF[3],
        ignore = true,
    },
    [_G.GetSpellInfo(126434)] = { -- TUSHUI TABARD
        faction = private.FACTION_DATA.TUSHUI[3],
        ignore = true,
    },
    [_G.GetSpellInfo(94462)] = { -- UNDERCITY TABARD
        faction = private.FACTION_DATA.UNDERCITY[3],
        ignore = true,
    },

    -- Banner Buffs (can't tell the different levels of them apart via ingame API, so blacklist)
    [_G.GetSpellInfo(90216)] = { -- ALLIANCE GUILD STANDARD
        ignore = true,
    },
    [_G.GetSpellInfo(90708)] = { -- HORDE GUILD STANDARD
        ignore = true,
    },

    -- Holiday Buffs
    [_G.GetSpellInfo(136583)] = { -- DARKMOON TOP HAT
        modifier = 0.1,
    },
    [_G.GetSpellInfo(24705)] = { -- GRIM VISAGE
        modifier = 0.1,
    },
    [_G.GetSpellInfo(61849)] = { -- SPIRIT OF SHARING
        modifier = 0.1,
    },
    [_G.GetSpellInfo(95987)] = { -- UNBURDENED
        modifier = 0.1,
    },
    [_G.GetSpellInfo(46668)] = { -- WHEE!
        modifier = 0.1,
    },
    [_G.GetSpellInfo(100951)] = { -- WOW 8TH ANNIVERSARY
        modifier = 0.08,
    },
    [_G.GetSpellInfo(132700)] = { -- WOW 9TH ANNIVERSARY
        modifier = 0.09,
    },
    [_G.GetSpellInfo(150986)] = { -- WOW 10TH ANNIVERSARY
        modifier = 0.1,
    },
    [_G.GetSpellInfo(188454)] = { -- WOW 11TH ANNIVERSARY
        modifier = 0.11,
    },
    [_G.GetSpellInfo(219159)] = { -- WOW 12TH ANNIVERSARY
        modifier = 0.12,
    },

    -- Situational Buffs
    [_G.GetSpellInfo(39953)] = { -- ADALS SONG OF BATTLE
        faction = private.FACTION_DATA.SHATAR[3],
        modifier = 0.1,
    },
    [_G.GetSpellInfo(30754)] = { -- CENARION FAVOR
        faction = private.FACTION_DATA.CENARION_CIRCLE[3],
        modifier = 0.25,
    },
    [_G.GetSpellInfo(32098)] = { -- HONOR HOLD FAVOR
        faction = private.FACTION_DATA.HONOR_HOLD[3],
        modifier = 0.25,
    },
    [_G.GetSpellInfo(39913)] = { -- NAZGRELS FERVOR
        faction = private.FACTION_DATA.THRALLMAR[3],
        modifier = 0.1,
    },
    [_G.GetSpellInfo(32096)] = { -- THRALLMARS FAVOR
        faction = private.FACTION_DATA.THRALLMAR[3],
        modifier = 0.25,
    },
    [_G.GetSpellInfo(39911)] = { -- TROLLBANES COMMAND
        faction = private.FACTION_DATA.HONOR_HOLD[3],
        modifier = 0.1,
    },
}
