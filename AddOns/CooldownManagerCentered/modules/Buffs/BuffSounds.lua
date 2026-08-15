local _, ns = ...
local L = ns.L

-- "Sound when an aura is applied" for buffs, in one module.
--
-- Custom/wildcard slots register natively through C_UnitAuras.AddAuraSound
-- (the 12.1 successor of AddPrivateAuraAppliedSound), which accepts a sound
-- file path or a SoundFileID. Current built-in choices use SoundFileIDs for
-- both paths; legacy SoundKit values (kit:) remain supported for saved data.
-- A custom sound wins over a Blizzard one for the same spell.
local BuffSounds = {}
ns.BuffSounds = BuffSounds

local LSM = LibStub("LibSharedMedia-3.0", true)
local BuffData = ns.BuffData

BuffSounds.DEFAULT_SOUND = 567399

local BUILTIN_SOUNDS = {
    { value = 567397, label = L["Raid Warning"] },
    { value = 567436, label = L["Alarm Clock 1"] },
    { value = 567399, label = L["Alarm Clock 2"] },
    { value = 567458, label = L["Alarm Clock 3"] },
}
BuffSounds.BUILTIN_SOUNDS = BUILTIN_SOUNDS

-- kind: "kit" | "id" | "file"; nil when the value is empty.
local function ResolveSound(value)
    if type(value) == "number" and value > 0 then
        return "id", value
    end
    if type(value) ~= "string" or value == "" or value == "None" then
        return nil
    end
    local numeric = tonumber(value)
    if numeric and numeric > 0 then
        return "id", numeric
    end
    local kitName = value:match("^kit:(.+)$")
    if kitName then
        return "kit", kitName
    end
    local fileName = value:match("^file:(.+)$")
    if fileName then
        return "file", fileName
    end
    local mediaName = value:match("^lsm:(.+)$") or value
    local resolved = LSM and LSM.Fetch and LSM:Fetch("sound", mediaName, true)
    if type(resolved) == "number" and resolved > 0 and resolved ~= 1 then
        return "id", resolved
    end
    if type(resolved) == "string" and resolved ~= "" then
        return "file", resolved
    end
    return "file", value
end

function BuffSounds:GetSoundOptions()
    local options = {}
    for _, sound in ipairs(BUILTIN_SOUNDS) do
        options[#options + 1] = { value = sound.value, label = sound.label }
    end
    local mediaNames = LSM and LSM:List("sound") or nil
    for _, mediaName in ipairs(mediaNames or {}) do
        if mediaName ~= "None" then
            options[#options + 1] = { value = "lsm:" .. mediaName, label = mediaName }
        end
    end
    return options
end

function BuffSounds:GetDefaultSound()
    return BuffSounds.DEFAULT_SOUND
end

function BuffSounds:ResolveSoundLabel(value)
    if not value or value == "" or value == "None" then
        return L["None"]
    end
    for _, sound in ipairs(BUILTIN_SOUNDS) do
        if sound.value == value then
            return sound.label
        end
    end
    if type(value) ~= "string" then
        return tostring(value)
    end
    local mediaName = value:match("^lsm:(.+)$")
    return mediaName or value
end

function BuffSounds:PlayConfiguredSound(value)
    value = value or BuffSounds.DEFAULT_SOUND
    local kind, payload = ResolveSound(value)
    if kind == "kit" then
        local soundKitID = SOUNDKIT and SOUNDKIT[payload]
        if not soundKitID then
            error("BuffSounds: unknown built-in sound kit '" .. tostring(payload) .. "'")
        end
        PlaySound(soundKitID, "Master")
    elseif kind == "id" then
        PlaySoundFile(payload, "Master")
    elseif kind == "file" then
        PlaySoundFile(payload, "Master")
    end
end

-------------------------------------------------------------------------------
-- Native registrations (custom/wildcard slots)
-------------------------------------------------------------------------------

local registrationsByStableKey = {}
local registrationRefs = {}
local pendingRemovals = {}
local pendingDefinitions = nil
local retryFrame = nil
local soundRegisterWarnings = {}

local function CanChangeRegistrations()
    if InCombatLockdown() then
        return false
    end
    if C_Secrets.ShouldAurasBeSecret() then
        return false
    end
    return true
end

local function RequestRetry()
    if not retryFrame then
        retryFrame = CreateFrame("Frame")
        retryFrame:SetScript("OnEvent", function()
            if CanChangeRegistrations() then
                BuffSounds:Flush()
            end
        end)
    end
    retryFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    retryFrame:RegisterEvent("ENCOUNTER_END")
    retryFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    retryFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end

local function GetSpellIDs(definition)
    local spellIDs = {}
    local seen = {}
    if type(definition.spellIDs) == "table" then
        for _, spellID in ipairs(definition.spellIDs) do
            spellID = tonumber(spellID)
            if spellID and spellID > 0 and not seen[spellID] then
                seen[spellID] = true
                spellIDs[#spellIDs + 1] = spellID
            end
        end
    end
    local primary = tonumber(definition.spellID)
    if primary and primary > 0 and not seen[primary] then
        table.insert(spellIDs, 1, primary)
    end
    return spellIDs
end

local function Unregister(stableKey)
    local registrations = registrationsByStableKey[stableKey]
    if not registrations then
        return
    end
    for _, key in ipairs(registrations.keys) do
        local registration = registrationRefs[key]
        if registration then
            registration.refs = registration.refs - 1
            if registration.refs <= 0 then
                if CanChangeRegistrations() then
                    C_UnitAuras.RemoveAuraSound(registration.id)
                else
                    pendingRemovals[registration.id] = true
                    RequestRetry()
                end
                registrationRefs[key] = nil
            end
        end
    end
    registrationsByStableKey[stableKey] = nil
end

local function Register(stableKey, definition)
    if not (definition and definition.soundOnApplied == true) then
        Unregister(stableKey)
        return
    end

    -- Older versions could save soundOnApplied without its string value because
    -- the entry-setting helper only persisted booleans. Recover those entries
    -- with the same native-compatible default used by the custom-buff menu.
    local soundFile = definition.soundOnAppliedFile
    if not soundFile then
        soundFile = BuffSounds:GetDefaultSound()
        if soundFile and BuffData and BuffData.SetBuffEntrySetting then
            BuffData.SetBuffEntrySetting(stableKey, "soundOnAppliedFile", soundFile)
        end
    end
    if not soundFile then
        Unregister(stableKey)
        return
    end

    local spellIDs = GetSpellIDs(definition)
    if #spellIDs == 0 then
        Unregister(stableKey)
        return
    end

    local kind, payload = ResolveSound(soundFile)
    if kind ~= "id" and kind ~= "file" then
        -- Custom pickers never offer SoundKits; a saved kit here means bad data.
        error("BuffSounds: SoundKit '" .. tostring(payload) .. "' cannot be registered natively")
    end
    local soundFileName = kind == "file" and payload or nil
    local soundFileID = kind == "id" and payload or nil
    local soundIdentity = soundFileName or ("id:" .. tostring(soundFileID))
    local signature = table.concat(spellIDs, ",") .. "|" .. soundIdentity
    local current = registrationsByStableKey[stableKey]
    if current and current.signature == signature then
        return
    end

    Unregister(stableKey)
    if not CanChangeRegistrations() then
        pendingDefinitions = pendingDefinitions or {}
        pendingDefinitions[stableKey] = definition
        RequestRetry()
        return
    end

    local keys = {}
    for _, spellID in ipairs(spellIDs) do
        local key = "Added|player|" .. tostring(spellID) .. "|" .. soundIdentity
        local registration = registrationRefs[key]
        if registration then
            registration.refs = registration.refs + 1
            keys[#keys + 1] = key
        else
            local info = {
                unitToken = "player",
                spellID = spellID,
                outputChannel = "Master",
            }
            if soundFileName then
                info.soundFileName = soundFileName
            else
                info.soundFileID = soundFileID
            end
            local registrationID = C_UnitAuras.AddAuraSound(Enum.UnitAuraSoundTrigger.Added, info)
            if registrationID then
                registrationRefs[key] = { id = registrationID, refs = 1 }
                keys[#keys + 1] = key
            elseif not soundRegisterWarnings[stableKey] then
                soundRegisterWarnings[stableKey] = true
                ns.API:LogWarn(
                    ns.API.Error.AuraSoundRegister,
                    "BuffSounds: AddAuraSound returned nil for "
                        .. tostring(stableKey)
                        .. " (spell "
                        .. tostring(spellID)
                        .. ", "
                        .. tostring(soundIdentity)
                        .. ")"
                )
            end
        end
    end

    if #keys > 0 then
        registrationsByStableKey[stableKey] = { signature = signature, keys = keys }
    end
end

function BuffSounds:Sync(definitions)
    definitions = definitions or {}

    if not CanChangeRegistrations() then
        pendingDefinitions = definitions
        RequestRetry()
        return
    end
    pendingDefinitions = nil

    for stableKey in pairs(registrationsByStableKey) do
        if not definitions[stableKey] then
            Unregister(stableKey)
        end
    end
    for stableKey, definition in pairs(definitions) do
        Register(stableKey, definition)
    end
end

function BuffSounds:Flush()
    if not CanChangeRegistrations() then
        return
    end
    for registrationID in pairs(pendingRemovals) do
        C_UnitAuras.RemoveAuraSound(registrationID)
        pendingRemovals[registrationID] = nil
    end
    if pendingDefinitions then
        local definitions = pendingDefinitions
        pendingDefinitions = nil
        self:Sync(definitions)
    end
    if retryFrame then
        retryFrame:UnregisterAllEvents()
    end
end

-------------------------------------------------------------------------------
-- Manual Blizzard-frame trigger
-------------------------------------------------------------------------------

local customSoundSpellIDs = {}
local lastPlayedBySpell = {}
local lastActiveByBlizzardFrame = {}
local hookedBlizzardFrames = setmetatable({}, { __mode = "k" })

local function IsSuppressed()
    if ns.Runtime and (ns.Runtime.hasSettingsOpened == true or ns.Runtime.isInEditMode == true) then
        return true
    end
    local editMode = _G.EditModeManagerFrame
    if editMode and editMode.IsShown and editMode:IsShown() then
        return true
    end
    return false
end

local function IsModuleEnabled()
    return BuffData and BuffData.IsEnabled and BuffData.IsEnabled()
end

local function PlaySpellSound(spellID, soundFile)
    spellID = tonumber(spellID)
    if spellID then
        local now = GetTime()
        if lastPlayedBySpell[spellID] and now - lastPlayedBySpell[spellID] < 0.5 then
            return
        end
        lastPlayedBySpell[spellID] = now
    end
    BuffSounds:PlayConfiguredSound(soundFile)
end

function BuffSounds:RebuildCustomSoundCache()
    wipe(customSoundSpellIDs)
    if not (BuffData and BuffData.GetAssignedAuraDefinitions) then
        return
    end
    for _, definition in pairs(BuffData.GetAssignedAuraDefinitions()) do
        if definition and definition.soundOnApplied == true then
            local function addSpell(value)
                value = tonumber(value)
                if value and value > 0 then
                    customSoundSpellIDs[value] = true
                end
            end
            addSpell(definition.spellID)
            if type(definition.spellIDs) == "table" then
                for _, spellID in ipairs(definition.spellIDs) do
                    addSpell(spellID)
                end
            end
        end
    end
end

local function PrimeBlizzardFrame(frame, active)
    lastActiveByBlizzardFrame[frame] = active == true
    frame._cmcSoundCooldownID = frame:GetCooldownID()
end

local function OnBlizzardActiveChanged(frame)
    if not IsModuleEnabled() then
        return
    end
    local active = frame.IsActive and frame:IsActive() == true or false
    local cooldownID = frame:GetCooldownID()
    if cooldownID ~= frame._cmcSoundCooldownID then
        PrimeBlizzardFrame(frame, active)
        return
    end
    local wasActive = lastActiveByBlizzardFrame[frame]
    lastActiveByBlizzardFrame[frame] = active
    if wasActive ~= false or not active or IsSuppressed() then
        return
    end
    local stableKey = cooldownID and BuffData.GetStableKeyForCooldownID(cooldownID)
    if not stableKey then
        return
    end
    if BuffData.GetBuffEntrySetting(stableKey, "soundOnApplied", false) ~= true then
        return
    end
    local soundFile = BuffData.GetBuffEntrySetting(stableKey, "soundOnAppliedFile", nil)
    if not soundFile then
        return
    end
    local spellID = tonumber(frame.GetSpellID and frame:GetSpellID() or nil)
    if spellID and customSoundSpellIDs[spellID] then
        return
    end
    PlaySpellSound(spellID, soundFile)
end

local function RefreshBlizzardFrames()
    local viewer = _G["BuffIconCooldownViewer"]
    if not (viewer and viewer.GetItemFrames) then
        return
    end
    BuffSounds:RebuildCustomSoundCache()
    for _, frame in ipairs(viewer:GetItemFrames()) do
        if frame and not hookedBlizzardFrames[frame] then
            hookedBlizzardFrames[frame] = true
            assert(frame.OnActiveStateChanged, "BuffSounds: buff frame is missing OnActiveStateChanged")
            hooksecurefunc(frame, "OnActiveStateChanged", OnBlizzardActiveChanged)
        end
        PrimeBlizzardFrame(frame, frame.IsActive and frame:IsActive() == true)
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COOLDOWN_VIEWER_DATA_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
eventFrame:SetScript("OnEvent", function()
    if IsModuleEnabled() then
        RefreshBlizzardFrames()
    end
end)
