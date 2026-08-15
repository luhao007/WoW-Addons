local _, ns = ...
local L = ns.L

local ProfileAPI = {}
ns.ProfileAPI = ProfileAPI

local LibDeflate = LibStub("LibDeflate")
local LibSerialize = LibStub("LibSerialize")

local EXPORT_PREFIX = "CMC1:"

function ProfileAPI:GetProfiles()
    if not ns.db then
        return {}
    end
    local profiles = {}
    ns.db:GetProfiles(profiles)
    return profiles
end

function ProfileAPI:GetCurrentProfile()
    if not ns.db then
        return ""
    end
    return ns.db:GetCurrentProfile()
end

function ProfileAPI:SetProfile(profileName)
    if not ns.db then
        return
    end
    if profileName and profileName ~= "" then
        ns.db:SetProfile(profileName)
    end
end

function ProfileAPI:CreateProfile(profileName)
    if not ns.db then
        return false
    end
    if not profileName or profileName == "" then
        return false
    end
    ns.db:SetProfile(profileName)
    return true
end

local COPY_SECTION_KEYS = {
    cooldownStyleSettings = "spellStyles",
    editMode = "editMode",
    tracker = "trackers",
    tracker_count = "trackers",
    tracker_enabled = "trackers",
    _tracker_filled_with_defaults = "trackers",
    buffContainers = "buffs",
}

local function IsDynamicEditModeKey(key, prefix)
    return type(key) == "string" and key:match("^" .. prefix .. "%d+$") ~= nil
end

local function CopyValue(value)
    return type(value) == "table" and CopyTable(value) or value
end

local function ApplyMissingDefaults(profile, defaults)
    defaults = defaults or (ns.DEFAULT_SETTINGS and ns.DEFAULT_SETTINGS.profile)
    if type(profile) ~= "table" or type(defaults) ~= "table" then
        return
    end

    for key, defaultValue in pairs(defaults) do
        if rawget(profile, key) == nil then
            profile[key] = CopyValue(defaultValue)
        elseif type(defaultValue) == "table" and type(profile[key]) == "table" then
            ApplyMissingDefaults(profile[key], defaultValue)
        end
    end
end

local function ReplaceSectionKey(profile, source, key)
    profile[key] = CopyValue(source[key])
end

local function CopyEditModeSection(profile, source, sections)
    local currentEditMode = profile.editMode or {}
    local copiedEditMode = type(source.editMode) == "table" and CopyTable(source.editMode) or {}

    for key in pairs(copiedEditMode) do
        if
            (not sections.trackers and IsDynamicEditModeKey(key, "tracker"))
            or (not sections.buffs and IsDynamicEditModeKey(key, "buffContainer"))
        then
            copiedEditMode[key] = nil
        end
    end

    for key, value in pairs(currentEditMode) do
        if
            (not sections.trackers and IsDynamicEditModeKey(key, "tracker"))
            or (not sections.buffs and IsDynamicEditModeKey(key, "buffContainer"))
        then
            copiedEditMode[key] = CopyValue(value)
        end
    end

    profile.editMode = copiedEditMode
end

---@param targetProfileName string
---@param sections? table<string, boolean> Nil copies the complete profile through AceDB.
function ProfileAPI:CopyProfile(targetProfileName, sections)
    if not ns.db then
        return false
    end
    if not targetProfileName or targetProfileName == "" then
        return false
    end

    if targetProfileName == ProfileAPI:GetCurrentProfile() then
        return false
    end

    local source = ns.db.sv and ns.db.sv.profiles and ns.db.sv.profiles[targetProfileName]
    if not source then
        return false
    end

    if not sections then
        ns.db:CopyProfile(targetProfileName)
        return true
    end

    local hasSelection = false
    for _, selected in pairs(sections) do
        if selected then
            hasSelection = true
            break
        end
    end
    if not hasSelection then
        return false
    end

    local profile = ns.db.profile

    if sections.general then
        for key in pairs(profile) do
            if not COPY_SECTION_KEYS[key] then
                profile[key] = nil
            end
        end
        for key, value in pairs(source) do
            if not COPY_SECTION_KEYS[key] then
                profile[key] = CopyValue(value)
            end
        end
    end

    if sections.spellStyles then
        ReplaceSectionKey(profile, source, "cooldownStyleSettings")
    end
    if sections.trackers then
        ReplaceSectionKey(profile, source, "tracker")
        ReplaceSectionKey(profile, source, "tracker_count")
        ReplaceSectionKey(profile, source, "tracker_enabled")
        ReplaceSectionKey(profile, source, "_tracker_filled_with_defaults")
    end
    if sections.buffs then
        ReplaceSectionKey(profile, source, "buffContainers")
    end
    if sections.editMode then
        CopyEditModeSection(profile, source, sections)
    end

    ApplyMissingDefaults(profile)

    if ns.Addon and ns.Addon.RefreshConfig then
        ns.Addon:RefreshConfig()
    end
    return true
end

function ProfileAPI:DeleteProfile(profileName)
    if not ns.db then
        return false
    end
    if not profileName or profileName == "" then
        return false
    end
    if profileName == ProfileAPI:GetCurrentProfile() then
        return false
    end
    local profiles = ProfileAPI:GetProfiles()
    local exists = false
    for _, name in ipairs(profiles) do
        if name == profileName then
            exists = true
            break
        end
    end
    if not exists then
        return false
    end
    ns.db:DeleteProfile(profileName)
    return true
end

function ProfileAPI:CheckAutoSwitch()
    if ns.db.global.autoSwitchProfiles then
        local _, playerClassId = UnitClassBase("player")
        local currentProfile = ProfileAPI:GetCurrentProfile()
        local currentSpecIndex = C_SpecializationInfo.GetSpecialization()
        local expectedProfile = ns.db.global["autoSwitchProfile" .. playerClassId .. "Spec" .. currentSpecIndex]
        if expectedProfile and expectedProfile ~= currentProfile then
            ProfileAPI:SetProfile(expectedProfile)
        end
    end
end

function ProfileAPI:GetExportString()
    if not ns.db then
        return ""
    end

    local data = CopyTable(ns.db.profile)
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForPrint(compressed)

    return EXPORT_PREFIX .. encoded
end

function ProfileAPI:GetExportStringByProfileName(profileName)
    if not ns.db or not ns.db.sv or not ns.db.sv.profiles or not ns.db.sv.profiles[profileName] then
        return ""
    end

    local data = CopyTable(ns.db.sv.profiles[profileName])
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForPrint(compressed)

    return EXPORT_PREFIX .. encoded
end

function ProfileAPI:DecodeExportString(text)
    if not text or text == "" then
        return nil, L["Empty input string."]
    end

    local header = string.sub(text, 1, 5)
    if header ~= EXPORT_PREFIX then
        return nil, L["Invalid format. Expected CMC1: prefix."]
    end

    local payload = string.sub(text, 6)
    if not payload or payload == "" then
        return nil, L["Empty payload."]
    end

    local decoded = LibDeflate:DecodeForPrint(payload)
    if not decoded then
        return nil, L["Failed to decode string."]
    end

    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then
        return nil, L["Failed to decompress data."]
    end

    local success, data = LibSerialize:Deserialize(decompressed)
    if not success then
        return nil, L["Failed to deserialize data."]
    end

    return data
end

function ProfileAPI:ImportFromString(importString, profileName)
    if not ns.db then
        return false, L["Database not initialized."]
    end
    if not profileName or strtrim(profileName) == "" then
        return false, L["Profile name is required."]
    end

    local data, errorMsg = ProfileAPI:DecodeExportString(importString)
    if not data then
        return false, errorMsg or L["Failed to decode import string."]
    end

    local trimmedName = strtrim(profileName)
    ns.db:SetProfile(trimmedName)

    for key, value in pairs(data) do
        if type(value) == "table" then
            ns.db.profile[key] = CopyTable(value)
        else
            ns.db.profile[key] = value
        end
    end

    if ns.Addon and ns.Addon.RefreshConfig then
        ns.Addon:RefreshConfig()
    end
    return true
end

CooldownManagerCentered.ImportProfileFromString = ProfileAPI.ImportFromString
CooldownManagerCentered.ExportCurrentProfileToString = ProfileAPI.GetExportString
CooldownManagerCentered.ExportProfileToString = ProfileAPI.GetExportStringByProfileName
