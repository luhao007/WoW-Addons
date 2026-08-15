local _, ns = ...

-- Shared event engine for the per-tracker "Range Indicator" and "Require Resource"
-- tints. Range uses Blizzard's event-driven API (EnableSpellRangeCheck +
-- SPELL_RANGE_CHECK_UPDATE); resource uses C_Spell.IsSpellUsable, re-checked on
-- SPELL_UPDATE_USABLE / the player's UNIT_POWER_UPDATE. A spell tracked by several
-- trackers is registered once.

local Usability = {}
ns.TrackerUsability = Usability

local EnableSpellRangeCheck = C_Spell.EnableSpellRangeCheck
local IsSpellUsable = C_Spell.IsSpellUsable

local POWER_REFRESH_DELAY = 0.05

local rangeActive = {}
local powerWanted = {}
local outOfRange = {}
local resourceInsufficient = {}
local notUsable = {}

local eventFrame
local rangeRegistered = false
local powerRegistered = false
local powerRefreshPending = false

local function RequestTintRefresh()
    ns.TrackerItemViewer:RefreshUsabilityTints()
end

function Usability:IsOutOfRange(spellID)
    return outOfRange[spellID] == true
end

function Usability:IsResourceInsufficient(spellID)
    return resourceInsufficient[spellID] == true
end

-- Unusable for a reason other than power (the "else" branch of Blizzard's usable
-- tint): no target, on cooldown-locked state, etc. Resolved on SPELL_UPDATE_USABLE.
function Usability:IsNotUsable(spellID)
    return notUsable[spellID] == true
end

-- Splits C_Spell.IsSpellUsable's (isUsable, notEnoughPower) into the two distinct
-- "unusable" tints: insufficient power (blue) vs. otherwise-unusable (grey).
local function EvaluatePowerStates()
    local changed = false
    for spellID in pairs(powerWanted) do
        local isUsable, notEnoughPower = IsSpellUsable(spellID)
        local insufficient = not isUsable and notEnoughPower == true
        local unusable = not isUsable and not insufficient
        if (resourceInsufficient[spellID] == true) ~= insufficient then
            resourceInsufficient[spellID] = insufficient or nil
            changed = true
        end
        if (notUsable[spellID] == true) ~= unusable then
            notUsable[spellID] = unusable or nil
            changed = true
        end
    end
    return changed
end

local function SchedulePowerRefresh()
    if powerRefreshPending then
        return
    end
    powerRefreshPending = true
    C_Timer.After(POWER_REFRESH_DELAY, function()
        powerRefreshPending = false
        if EvaluatePowerStates() then
            RequestTintRefresh()
        end
    end)
end

local function EnsureEventFrame()
    if eventFrame then
        return
    end
    eventFrame = CreateFrame("Frame")
    eventFrame:SetScript("OnEvent", function(_, event, arg1, arg2, arg3)
        if event == "SPELL_RANGE_CHECK_UPDATE" then
            local spellID, inRange, checksRange = arg1, arg2, arg3
            local bad = (checksRange and inRange == false) or false
            if (outOfRange[spellID] == true) ~= bad then
                outOfRange[spellID] = bad or nil
                RequestTintRefresh()
            end
        elseif event == "SPELL_UPDATE_USABLE" then
            if EvaluatePowerStates() then
                RequestTintRefresh()
            end
        else
            SchedulePowerRefresh()
        end
    end)
end

local function SetRangeEventsRegistered(enabled)
    if enabled == rangeRegistered then
        return
    end
    EnsureEventFrame()
    if enabled then
        eventFrame:RegisterEvent("SPELL_RANGE_CHECK_UPDATE")
    else
        eventFrame:UnregisterEvent("SPELL_RANGE_CHECK_UPDATE")
    end
    rangeRegistered = enabled
end

local function SetPowerEventsRegistered(enabled)
    if enabled == powerRegistered then
        return
    end
    EnsureEventFrame()
    if enabled then
        eventFrame:RegisterEvent("SPELL_UPDATE_USABLE")
        eventFrame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
    else
        eventFrame:UnregisterEvent("SPELL_UPDATE_USABLE")
        eventFrame:UnregisterEvent("UNIT_POWER_UPDATE")
    end
    powerRegistered = enabled
end

-- rangeSet/powerSet are spellID -> true maps. Diffs the range registrations so we
-- only flip what changed, then replaces the polled resource set.
function Usability:UpdateWanted(rangeSet, powerSet)
    rangeSet = rangeSet or {}
    powerSet = powerSet or {}

    if EnableSpellRangeCheck then
        for spellID in pairs(rangeActive) do
            if not rangeSet[spellID] then
                EnableSpellRangeCheck(spellID, false)
                rangeActive[spellID] = nil
                outOfRange[spellID] = nil
            end
        end
        for spellID in pairs(rangeSet) do
            if not rangeActive[spellID] then
                EnableSpellRangeCheck(spellID, true)
                rangeActive[spellID] = true
            end
        end
    end
    SetRangeEventsRegistered(next(rangeActive) ~= nil)

    for spellID in pairs(powerWanted) do
        if not powerSet[spellID] then
            powerWanted[spellID] = nil
            resourceInsufficient[spellID] = nil
            notUsable[spellID] = nil
        end
    end
    local hasPower = false
    for spellID in pairs(powerSet) do
        powerWanted[spellID] = true
        hasPower = true
    end
    SetPowerEventsRegistered(hasPower)
    if hasPower and EvaluatePowerStates() then
        RequestTintRefresh()
    end
end
