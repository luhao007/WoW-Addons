local _, ns = ...

-- Shared AuraContainer plumbing: load, capability probe, combat deferral.
-- Used by AuraTracking (overlays) and CustomAuraProvider (custom buffs);
-- feature code stays in those modules, only the boring parts live here.
local AuraContainerRuntime = {}
ns.AuraContainerRuntime = AuraContainerRuntime

local AURA_CONTAINER_ADDON = "Blizzard_AuraContainer"
local DEFAULT_TEMPLATE = "CustomAuraContainerTemplate"
local REQUIRED_CONTAINER_METHODS = {
    "AddAuraSlot",
    "SetAuraSlotFilterString",
    "SetAuraSlotCandidateFilters",
    "SetAuraGroupFilterString",
    "SetEnabled",
    "SetUnit",
    "UpdateAllAuras",
}

local deferredCallbacks = {}
local auraRefreshCallbacks = {}
local auraRefreshFrame
local auraRefreshPending = false

function AuraContainerRuntime.GetVehicleAuraBlockState()
    local inVehicle = _G.UnitInVehicle and _G.UnitInVehicle("player") == true
    local inControlSeat = _G.UnitInVehicleControlSeat and _G.UnitInVehicleControlSeat("player") == true
    local hasVehicleActionBarFunction = _G["HasVehicleActionBar"]
    local hasVehicleActionBar = hasVehicleActionBarFunction and hasVehicleActionBarFunction() == true
    return inVehicle, inControlSeat, hasVehicleActionBar, inVehicle or inControlSeat or hasVehicleActionBar
end

function AuraContainerRuntime.IsVehicleAuraContainerBlocked()
    local _, _, _, blocked = AuraContainerRuntime.GetVehicleAuraBlockState()
    return blocked == true
end

local function FilterContains(filterString, token)
    return type(filterString) == "string" and filterString:find(token, 1, true) ~= nil
end

function AuraContainerRuntime.IsAuraContainerBlocked(unitToken, filterString)
    if AuraContainerRuntime.IsVehicleAuraContainerBlocked() then
        return true
    end

    if unitToken == "player" and FilterContains(filterString, "HELPFUL") then
        return UnitCanAssist("player", "player") ~= true
    end
    if unitToken == "target" and FilterContains(filterString, "HARMFUL") then
        return UnitCanAssist("player", "target") == true
    end
    return false
end

local function RequestAuraRelationshipRefresh()
    if not auraRefreshFrame or auraRefreshPending then
        return
    end

    auraRefreshPending = true
    auraRefreshFrame:SetScript("OnUpdate", function(refreshFrame)
        refreshFrame:SetScript("OnUpdate", nil)
        auraRefreshPending = false

        if InCombatLockdown() then
            return
        end

        for _, callback in ipairs(auraRefreshCallbacks) do
            callback()
        end
    end)
end

local function EnsureAuraRelationshipRefreshFrame()
    if auraRefreshFrame then
        return
    end

    auraRefreshFrame = CreateFrame("Frame")
    auraRefreshFrame:RegisterUnitEvent("UNIT_FACTION", "player", "target")
    auraRefreshFrame:RegisterUnitEvent("UNIT_FLAGS", "player", "target")
    auraRefreshFrame:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "player", "target")
    auraRefreshFrame:RegisterUnitEvent("UNIT_ENTERING_VEHICLE", "player")
    auraRefreshFrame:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
    auraRefreshFrame:RegisterUnitEvent("UNIT_EXITING_VEHICLE", "player")
    auraRefreshFrame:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
    auraRefreshFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    auraRefreshFrame:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
    auraRefreshFrame:RegisterEvent("PLAYER_GAINS_VEHICLE_DATA")
    auraRefreshFrame:RegisterEvent("PLAYER_LOSES_VEHICLE_DATA")
    auraRefreshFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    auraRefreshFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    auraRefreshFrame:SetScript("OnEvent", function()
        RequestAuraRelationshipRefresh()
    end)
end

local flushFrame = CreateFrame("Frame")
flushFrame:SetScript("OnEvent", function(self, event)
    if event ~= "PLAYER_REGEN_ENABLED" or InCombatLockdown() then
        return
    end
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    local callbacks = deferredCallbacks
    wipe(deferredCallbacks)
    for _, callback in ipairs(callbacks) do
        callback()
    end
end)

function AuraContainerRuntime:Load()
    if C_AddOns.IsAddOnLoaded(AURA_CONTAINER_ADDON) then
        return true
    end
    return C_AddOns.LoadAddOn(AURA_CONTAINER_ADDON) == true
end

local available
function AuraContainerRuntime:IsAvailable()
    if available == nil then
        available = self:Load()
    end
    return available == true
end

function AuraContainerRuntime:HasRequiredMethods(container)
    if not container then
        return false
    end
    for _, methodName in ipairs(REQUIRED_CONTAINER_METHODS) do
        if type(container[methodName]) ~= "function" then
            return false
        end
    end
    return true
end

function AuraContainerRuntime:Create(template)
    local container = CreateFrame("AuraContainer", nil, UIParent, template or DEFAULT_TEMPLATE)
    if not AuraContainerRuntime:HasRequiredMethods(container) then
        self:Deactivate(container)
        return nil
    end
    return container
end

function AuraContainerRuntime:Deactivate(container)
    if not container then
        return
    end

    -- AuraContainer's forbidden EventRegistrations aspect rejects direct
    -- UnregisterEvent(s) calls. Its public SetEnabled(false) delegate safely
    -- unregisters dynamic UNIT_AURA/private callbacks; keep the frame for reuse.
    if type(container.SetEnabled) == "function" then
        container:SetEnabled(false)
    end
    container:Hide()
end

function AuraContainerRuntime:DeferInCombat(callback)
    if InCombatLockdown() then
        deferredCallbacks[#deferredCallbacks + 1] = callback
        flushFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        return true
    end
    return false
end

function AuraContainerRuntime:RegisterAuraRelationshipRefresh(callback)
    if type(callback) ~= "function" then
        return
    end

    EnsureAuraRelationshipRefreshFrame()
    auraRefreshCallbacks[#auraRefreshCallbacks + 1] = callback
    RequestAuraRelationshipRefresh()
end

AuraContainerRuntime.RegisterVehicleAuraRefresh = AuraContainerRuntime.RegisterAuraRelationshipRefresh
