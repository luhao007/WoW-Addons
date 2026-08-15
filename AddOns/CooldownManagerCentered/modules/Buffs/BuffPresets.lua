local _, ns = ...
local L = ns.L

-- Aura preset definitions consumed by BuffWildcards.
local BuffPresets = {}
ns.BuffPresets = BuffPresets

local DATA = ns.BuffPresetData

local CATALOG = {
    quick = {
        { key = "POWER_INFUSION", spellIDs = { 10060 }, iconSpellID = 10060 },
        {
            key = "BLOODLUST",
            spellIDs = {
                2825, -- Bloodlust
                32182, -- Heroism
                80353, -- Time Warp
                90355, -- Ancient Hysteria
                146555, -- Drums of Rage
                160452, -- Netherwinds
                178207, -- Drums of Fury
                230935, -- Drums of the Mountain
                256740, -- Drums of the Maelstrom
                264667, -- Primal Rage
                309658, -- Drums of Deathly Ferocity
                381301, -- Feral Hide Drums
                390386, -- Fury of the Aspects
                441076, -- Timeless Drums
                444257, -- Thunderous Drums
                466904, -- Harrier's Cry
                1243972, -- Void-touched Drums
            },
            iconSpellID = 2825,
        },
        { key = "THREAT_REDIRECTION", spellIDs = { 34477, 57934 }, iconSpellID = 34477 },
    },
    defensives = {
        externals = {
            102342,
            -- 17, Power Word: Shield
            1022,
            1309794,
            6940,
            33206,
            47788,
            116849,
            147833,
            204018,
            357170,
            387792,
            387804,
        },
        raidArea = {
            31821,
            81782,
            97463,
            145629,
            207498,
            209426,
            325174,
            374227,
            414661,
            414662,
            414663,
        },
        racial = {
            65116,
        },
        classes = {
            {
                classTag = "DEMONHUNTER",
                spellIDs = { 391171, 203819, 187827, 212800, 442715, 1266616, 394933, 427912, 258920, 207811, 207810, 263648, 196555, 188499, 207771 },
            },
            {
                classTag = "DEATHKNIGHT",
                spellIDs = { 391527, 194679, 49039, 48792, 219809, 55233, 48707, 444741, 81256, 193320, 207319, 194844, 101568 }, -- too irrelevant: 391459
            },
            {
                classTag = "DRUID",
                spellIDs = {
                    22812, -- Barkskin
                    124974, -- Nature's Vigil
                    200851, -- Rage of the Sleeper
                    61336, -- Survival Instincts
                    393903, -- Ursine Vigor
                    210655, -- Protection of Ashamane
                    50334, -- Berserk
                    1261872, -- Heart of the Wild
                    --[[too irrelevant:
                    192081, -- Ironfur
                    22842, -- Frenzied Regeneration
                    234081, -- Celestial Guardian
                    202043, -- Protector of the Pack
                    201940, -- Roar of the Protector
                    201939, -- Roar of the Protector
                    --]]
                },
            },
            { classTag = "EVOKER", spellIDs = { 363916, 374349, 374348, 404381, 378464 } },
            { classTag = "HUNTER", spellIDs = { 186265, 264735, 472708, 53480, 202748 } },
            { classTag = "MAGE", spellIDs = { 11426, 235450, 235313, 342246, 414658, 382290, 110960, 66, 45438, 198111, 198065, 110909, 449336, 1309793 } },
            {
                classTag = "MONK",
                spellIDs = { 120954, 322507, 122278, 122783, 115203, 122470, 125174, 201318, 202248, 202162, 215479, 353319, 353362, 132578, 1241059 }, -- too irrelevant: 414143
            },
            { classTag = "PALADIN", spellIDs = { 403876, 498, 31850, 642, 184662, 86659, 205191, 199507, 216857, 228049, 209388, 212641, 132403 } },
            { classTag = "PRIEST", spellIDs = { 193065, 19236, 47585, 586, 114216, 114214, 45242, 426401, 27827, 197268 } },
            { classTag = "ROGUE", spellIDs = { 45182, 31224, 5277, 1966, 185311, 199754, 199027 } },
            { classTag = "SHAMAN", spellIDs = { 108271, 381755, 260881, 114893, 462844, 974, 207654 } },
            { classTag = "WARLOCK", spellIDs = { 104773, 108416, 221715, 212295, 132413, 387636, 389614 } },
            {
                classTag = "WARRIOR",
                spellIDs = {
                    871,
                    12975,
                    392966,
                    386208,
                    118038,
                    184364,
                    23920,
                    190456,
                    1277297,
                    385391,
                    209484,
                    213915,
                    199038,
                    223658,
                    198760,
                    203524,
                    132404,
                },
            },
        },
    },
}

local FALLBACK_NAMES = {
    POWER_INFUSION = "Power Infusion",
    BLOODLUST = "Bloodlust",
    THREAT_REDIRECTION = L["Threat Redirection"],
    CLASS_DEFENSIVES = "Class\nDef",
    EXTERNAL_DEFENSIVES = "External",
    RAID_DEFENSIVES = "Raid\nDef",
    TRINKET_UPTIME = L["Trinket Uptime"],
    COMBAT_POTION = L["Combat Potion"],
}

-- Short labels shown under wildcard buttons. They describe what the group does
-- instead of the generic "Wildcard" tag.
local SHORT_LABELS = {
    POWER_INFUSION = "PI",
    BLOODLUST = "Blood\nLust",
    THREAT_REDIRECTION = L["Threat"],
    CLASS_DEFENSIVES = "Class\nDef",
    EXTERNAL_DEFENSIVES = "External",
    RAID_DEFENSIVES = "Raid\nDef",
    TRINKET_UPTIME = L["Trinket"],
    COMBAT_POTION = L["Potion"],
}

local definitions = nil
local definitionsClassTag = nil

local function NormalizeSpellIDs(spellIDs)
    local seen = {}
    local result = {}
    for _, spellID in ipairs(type(spellIDs) == "table" and spellIDs or {}) do
        spellID = tonumber(spellID)
        if spellID and spellID > 0 and not seen[spellID] then
            seen[spellID] = true
            result[#result + 1] = spellID
        end
    end
    return result
end

local function AddDefinition(target, key, spellIDs, iconSpellID)
    spellIDs = NormalizeSpellIDs(spellIDs)
    if #spellIDs == 0 or not key then
        return
    end
    iconSpellID = tonumber(iconSpellID) or spellIDs[1]
    target[key] = {
        key = key,
        name = FALLBACK_NAMES[key] or key,
        label = SHORT_LABELS[key] or FALLBACK_NAMES[key] or key,
        spellID = spellIDs[1],
        spellIDs = spellIDs,
        primarySpellID = spellIDs[1],
        iconID = C_Spell.GetSpellTexture and C_Spell.GetSpellTexture(iconSpellID) or 134400,
    }
end

function BuffPresets:GetDefinitions()
    local classTag = UnitClassBase and UnitClassBase("player") or select(2, UnitClass("player"))
    if definitions and definitionsClassTag == classTag then
        return definitions
    end

    definitions = {}
    definitionsClassTag = classTag
    for _, entry in ipairs(CATALOG.quick) do
        AddDefinition(definitions, entry.key, entry.spellIDs, entry.iconSpellID)
    end

    local classDefensiveSpellIDs = {}
    local seen = {}
    local function addSpellIDs(spellIDs)
        for _, spellID in ipairs(spellIDs) do
            spellID = tonumber(spellID)
            if spellID and spellID > 0 and not seen[spellID] then
                seen[spellID] = true
                classDefensiveSpellIDs[#classDefensiveSpellIDs + 1] = spellID
            end
        end
    end
    for _, classGroup in ipairs(CATALOG.defensives.classes) do
        if classGroup.classTag == classTag then
            addSpellIDs(classGroup.spellIDs)
            addSpellIDs(CATALOG.defensives.racial)
            break
        end
    end
    AddDefinition(definitions, "CLASS_DEFENSIVES", classDefensiveSpellIDs, classDefensiveSpellIDs[1])
    AddDefinition(definitions, "EXTERNAL_DEFENSIVES", CATALOG.defensives.externals, CATALOG.defensives.externals[1])
    AddDefinition(definitions, "RAID_DEFENSIVES", CATALOG.defensives.raidArea, CATALOG.defensives.raidArea[1])

    if DATA then
        for _, group in ipairs(DATA.trinkets or {}) do
            AddDefinition(definitions, group.key, group.spellIDs, group.iconSpellID)
        end
        for _, group in ipairs(DATA.potions or {}) do
            AddDefinition(definitions, group.key, group.spellIDs, group.iconSpellID)
        end
    end

    return definitions
end
