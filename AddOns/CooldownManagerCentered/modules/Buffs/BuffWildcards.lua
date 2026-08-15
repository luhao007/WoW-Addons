local _, ns = ...

-- Wildcard buff definitions. A wildcard is a single tracked group that matches several spell IDs.
-- Preset groups (Bloodlust, Power Infusion, Threat Redirection, Class Def,
-- External, Raid Def, Trinket Uptime, Combat Potion) come from ns.BuffPresets

local BuffWildcards = {}
ns.BuffWildcards = BuffWildcards

local BuffPresets = ns.BuffPresets

local definitionsCache = nil

function BuffWildcards:GetDefinitions()
    if definitionsCache then
        return definitionsCache
    end

    local definitions = {}
    for key, definition in pairs(BuffPresets:GetDefinitions()) do
        definitions["w:" .. key] = {
            spellID = definition.primarySpellID or definition.spellIDs[1],
            spellIDs = definition.spellIDs,
            name = definition.name,
            label = definition.label or definition.name,
            iconID = definition.iconID or 134400,
            wildcard = true,
            presetKey = key,
        }
    end

    definitionsCache = definitions
    return definitionsCache
end

function BuffWildcards:InvalidateCache()
    definitionsCache = nil
end
