-- Translates dungeon/raid/boss source names to the client locale at runtime
-- using the Encounter Journal API, so we don't keep per-locale name tables.

LBIS.LocalizedNames = {
    sources = nil,  -- english -> localized; nil until BuildMap() runs
}

-- LBIS source/location string -> EJ instance ID (ej) and/or challenge mode ID (cm).
-- The lookup APIs return the client-language name, so we don't translate ourselves.
local INSTANCE_JOURNAL_IDS = {
    -- Dungeons (use challengeModeId via C_ChallengeMode.GetMapUIInfo first, then journalInstanceId fallback)
    ["Skyreach"]                = { ej = 559,  cm = 161 },
    ["Seat of the Triumvirate"] = { ej = 768,  cm = 239 },
    ["Algeth'ar Academy"]       = { ej = 1198, cm = 402 },
    ["Pit of Saron"]            = { ej = 188,  cm = 556 },
    ["Windrunner Spire"]        = { ej = 1313, cm = 557 },
    ["Magisters' Terrace"]      = { ej = 1322, cm = 558 },
    ["Nexus-Point Xenas"]       = { ej = 1320, cm = 559 },
    ["Maisara Caverns"]         = { ej = 1319, cm = 560 },
    -- Raids
    ["The Voidspire"]           = { ej = 1307 },
    ["March on Quel'Danas"]     = { ej = 1308 },
    ["The Dreamrift"]           = { ej = 1314 },
    ["Firelands"]               = { ej = 187 },
    -- "Midnight", "Quel'Thalas", "The Blinding Vale": no journal entry, left as-is
}

-- Boss names with known encounter IDs. Add more as identified.
local BOSS_ENCOUNTER_IDS = {
    -- Pit of Saron
    ["Forgemaster Garfrost"] = 853,
    ["Ick and Krick"]        = 854,
    ["Scourgelord Tyrannus"] = 855,
    -- Skyreach
    ["Ranjit"]   = 1573,
    ["Araknath"] = 1574,
    ["Rukhran"]  = 1575,
    ["High Sage Viryx"] = 1576,
    -- missing ones fall through to English
}

-- Source-type words translated through the L[] table (see deDE.lua etc).
local SOURCE_TYPE_KEYS = {
    "Drop", "Raid", "Crafted", "Crafting",
    "Enchanting", "Jewelcrafting", "Tailoring", "Leatherworking",
    "Blacksmithing", "Inscription", "Alchemy", "Engineering",
    "Tier", "Catalyst", "Tier / Catalyst",
    "Midnight Dungeon", "Midnight World Drop", "Raid Boss",
}

-- Builds the english->localized lookup. Safe to call repeatedly. Needs the
-- Blizzard APIs available (true after PLAYER_LOGIN).
function LBIS.LocalizedNames:BuildMap()
    if self.sources then return self.sources end
    self.sources = {}

    -- Instance/zone names
    for englishName, ids in pairs(INSTANCE_JOURNAL_IDS) do
        local localizedName

        -- challenge-mode API first (M+ dungeons)
        if ids.cm and C_ChallengeMode and C_ChallengeMode.GetMapUIInfo then
            local ok, name = pcall(C_ChallengeMode.GetMapUIInfo, ids.cm)
            if ok and name and name ~= "" then localizedName = name end
        end

        -- then encounter journal
        if not localizedName and ids.ej and EJ_GetInstanceInfo then
            local ok, name = pcall(EJ_GetInstanceInfo, ids.ej)
            if ok and name and name ~= "" then localizedName = name end
        end

        if localizedName and localizedName ~= englishName then
            self.sources[englishName] = localizedName
        end
    end

    -- Boss names via EJ_GetEncounterInfo
    if EJ_GetEncounterInfo then
        for englishName, encounterId in pairs(BOSS_ENCOUNTER_IDS) do
            local ok, name = pcall(EJ_GetEncounterInfo, encounterId)
            if ok and name and name ~= "" and name ~= englishName then
                self.sources[englishName] = name
            end
        end
    end

    return self.sources
end

-- Translate a source/location string to the user's client locale.
-- Falls back to the original string if we don't have a mapping.
-- Handles compound forms like "Boss - Zone" by translating each side.
function LBIS:LocalizeSource(s)
    if not s or s == "" then return s end
    local map = LBIS.LocalizedNames.sources
    if not map then
        -- BuildMap hasn't been called yet (probably pre-PLAYER_LOGIN). Try now.
        map = LBIS.LocalizedNames:BuildMap()
    end

    -- Direct hit (most common path) via instance/boss journal map
    if map[s] then return map[s] end

    -- Locale-table fallback for source-type words like "Raid", "Crafted", etc.
    -- These have rawget-style entries in localization.deDE.lua etc.
    if LBIS.L and rawget(LBIS.L, s) and rawget(LBIS.L, s) ~= s then
        return LBIS.L[s]
    end

    -- "Boss - Zone" compound: translate each piece if either side is mapped
    local before, after = s:match("^(.-) %- (.+)$")
    if before and after then
        local lb = LBIS:LocalizeSource(before)
        local la = LBIS:LocalizeSource(after)
        if lb ~= before or la ~= after then
            return lb .. " - " .. la
        end
    end

    return s
end
