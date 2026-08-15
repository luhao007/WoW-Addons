local _, ns = ...

-- Event-driven proc durations for custom trackers.
--
-- Trinket proc auras can't be reliably found with GetPlayerAuraBySpellID, so we
-- don't poll auras at all. Instead we watch UNIT_SPELLCAST_SUCCEEDED for the
-- trinket's *trigger* spell ids and run our own synthetic countdowns, using the
-- metadata in ns.TrackerAuraData (populated by TrackerAuraProcData.lua and
-- TrackerAuraAutoDurationData.lua):
--   procByItemID / procBySpellID - trigger ids + durations + mode per item
--   autoDurationByItemID         - curated on-use buff durations (non-proc)
--
-- Modes:
--   simple            - any trigger starts one `duration` countdown.
--   stacked           - each `stack` trigger adds an independent `stackDuration`
--                       countdown (non-refreshing); count = unexpired stacks.
--   stackedAfterStart - a `start` trigger arms a window; `stack` triggers only
--                       count while armed.

local AuraDurations = ns.TrackerAuraDurations or {}
ns.TrackerAuraDurations = AuraDurations

-- Synthetic timer store, keyed by itemID:
--   { mode, startTime, duration, endTime }                 -- simple
--   { mode, stackDuration, stackExpirations = { ... }, armedUntil }  -- stacked*
local activeByItemID = {}

-- 11.2 secret-value guard: secret values (polled aura/spell data) can't be used
-- as table keys or in arithmetic. issecretvalue is a global on modern clients.
local issecretvalue = _G.issecretvalue

local function GetProcInfo(kind, id)
    local data = ns.TrackerAuraData
    if not data then
        return nil
    end
    if kind == "item" then
        return data.procByItemID and data.procByItemID[id]
    elseif kind == "spell" then
        local bySpell = data.procBySpellID and data.procBySpellID[id]
        if bySpell then
            local _, info = next(bySpell)
            return info
        end
    end
    return nil
end

-- Which kind of trigger a given spellID is for this proc row.
local function TriggerKindFor(info, spellID)
    if tonumber(info.triggerSpellID) == spellID then
        return "trigger"
    end
    if type(info.triggerSpellIDs) == "table" then
        for _, s in ipairs(info.triggerSpellIDs) do
            if tonumber(s) == spellID then
                return "trigger"
            end
        end
    end
    if tonumber(info.startTriggerSpellID) == spellID then
        return "start"
    end
    if tonumber(info.stackTriggerSpellID) == spellID then
        return "stack"
    end
    return nil
end

local function StackDurationOf(info)
    return tonumber(info.stackDuration) or tonumber(info.duration)
end

local function CleanupStacks(record, now)
    local exps = record.stackExpirations
    if type(exps) ~= "table" then
        return 0
    end
    local write = 1
    for i = 1, #exps do
        if exps[i] and exps[i] > now then
            exps[write] = exps[i]
            write = write + 1
        end
    end
    for i = write, #exps do
        exps[i] = nil
    end
    return write - 1
end

function AuraDurations:RequestRefresh()
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
        ns.TrackerItemViewer:RefreshItemViewerFrames()
    end
end

-- Refresh once a timer/stack is due to expire, so the overlay clears itself.
local function ScheduleExpiryRefresh(delay)
    if C_Timer and C_Timer.After then
        C_Timer.After(math.max(delay or 0, 0.05) + 0.05, function()
            AuraDurations:RequestRefresh()
        end)
    end
end

-- Apply one trigger event to an item's synthetic timer. Returns true if changed.
function AuraDurations:ApplyTrigger(itemID, info, triggerKind, now)
    if ns.TrackerDB and ns.TrackerDB.GetHideAura and ns.TrackerDB.GetHideAura("item", itemID) then
        return false
    end

    local mode = info.mode or "simple"

    if mode == "simple" then
        local duration = tonumber(info.duration)
        if not (duration and duration > 0) then
            return false
        end
        activeByItemID[itemID] = { mode = mode, startTime = now, duration = duration, endTime = now + duration }
        ScheduleExpiryRefresh(duration)
        return true
    end

    if mode == "stacked" or mode == "stackedAfterStart" then
        local record = type(activeByItemID[itemID]) == "table" and activeByItemID[itemID] or { mode = mode }
        record.mode = mode
        record.stackExpirations = record.stackExpirations or {}
        record.stackDuration = StackDurationOf(info)
        activeByItemID[itemID] = record

        if triggerKind == "start" then
            local armDuration = tonumber(info.duration) or record.stackDuration or 0
            record.armedUntil = now + armDuration
            return true
        end

        if triggerKind ~= "stack" then
            return false
        end

        if mode == "stackedAfterStart" and not (record.armedUntil and record.armedUntil > now) then
            return false
        end

        local duration = record.stackDuration
        if not (duration and duration > 0) then
            return false
        end
        record.stackExpirations[#record.stackExpirations + 1] = now + duration
        CleanupStacks(record, now)
        ScheduleExpiryRefresh(duration)
        return true
    end

    return false
end

-- Called from the UNIT_SPELLCAST_SUCCEEDED watcher with a cast spellID.
function AuraDurations:OnTriggerSpell(spellID)
    -- Never index a table with a secret value (11.2): bail if it is one.
    if issecretvalue and issecretvalue(spellID) then
        return false
    end
    spellID = tonumber(spellID)
    if not spellID then
        return false
    end
    local data = ns.TrackerAuraData
    local triggered = data and data.procBySpellID and data.procBySpellID[spellID]
    if not triggered then
        return false
    end
    local now = GetTime()
    local changed = false
    for itemID, info in pairs(triggered) do
        local triggerKind = TriggerKindFor(info, spellID)
        if triggerKind and self:ApplyTrigger(itemID, info, triggerKind, now) then
            changed = true
        end
    end
    return changed
end

-- Remaining time for an item's synthetic timer.
-- Returns startTime, duration, stacks, mode -- or nil when nothing is active.
function AuraDurations:GetLiveActive(kind, id)
    if kind ~= "item" then
        return nil
    end
    if ns.TrackerDB and ns.TrackerDB.GetHideAura and ns.TrackerDB.GetHideAura(kind, id) then
        return nil
    end
    local record = activeByItemID[id]
    if not record then
        return nil
    end
    local now = GetTime()

    if record.stackExpirations then
        local count = CleanupStacks(record, now)
        if count <= 0 then
            return nil
        end
        local maxExp = 0
        for _, exp in ipairs(record.stackExpirations) do
            if exp > maxExp then
                maxExp = exp
            end
        end
        local duration = record.stackDuration or 0
        return maxExp - duration, duration, count, record.mode
    end

    if record.endTime and record.endTime > now then
        return record.startTime, record.duration, 0, record.mode
    end

    activeByItemID[id] = nil
    return nil
end

-- Curated on-use buff duration for an entry (proc effect duration first, then the
-- auto-duration table). Returns seconds, or nil. Used as the non-aura fallback.
function AuraDurations:GetKnownDuration(kind, id)
    local proc = GetProcInfo(kind, id)
    if proc and proc.duration and proc.duration > 0 then
        return proc.duration
    end

    local data = ns.TrackerAuraData
    if kind == "item" and data and data.autoDurationByItemID then
        local entry = data.autoDurationByItemID[id]
        if entry and entry.duration and entry.duration > 0 then
            return entry.duration
        end
    end
    return nil
end

-- Whether the entry has proc data (trigger + stacking metadata).
function AuraDurations:HasProc(kind, id)
    return GetProcInfo(kind, id) ~= nil
end

-- Sanitize an event spellID into a plain number (or nil): secret values can't be
-- used as table keys or compared, so they're dropped.
local function PlainSpellID(value)
    if value == nil or (issecretvalue and issecretvalue(value)) then
        return nil
    end
    return tonumber(value)
end

local triggerFrame = CreateFrame("Frame")
triggerFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
triggerFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
triggerFrame:SetScript("OnEvent", function(_, event, a, b, c)
    local spellID, baseSpellID
    if event == "SPELL_UPDATE_COOLDOWN" then
        spellID, baseSpellID = PlainSpellID(a), PlainSpellID(b)
    else -- UNIT_SPELLCAST_SUCCEEDED: unit, castGUID, spellID
        spellID = PlainSpellID(c)
    end

    local changed = false
    if spellID then
        changed = AuraDurations:OnTriggerSpell(spellID)
    end
    if baseSpellID and baseSpellID ~= spellID then
        changed = AuraDurations:OnTriggerSpell(baseSpellID) or changed
    end
    if changed then
        AuraDurations:RequestRefresh()
    end
end)
