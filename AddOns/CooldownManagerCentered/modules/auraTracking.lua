local _, ns = ...

-- Native 12.1 aura overlays. AuraContainer owns aura matching, secret visibility,
-- and duration; CMC only anchors and styles the resulting AuraSlot.
local AuraTracking = {}
ns.AuraTracking = AuraTracking

local AURA_CONTAINER_TEMPLATE = "CustomAuraContainerTemplate"
local AURA_SLOT_KEY = "cmcTrackedAura"
local PLAYER_AURA_FILTER = "HELPFUL"

local Runtime = ns.AuraContainerRuntime

local states = setmetatable({}, { __mode = "k" })
local pendingRequests = setmetatable({}, { __mode = "k" })
local supportChecked = false
local supported = false
local supportFailureLogged = false
local FlushPendingRequests

local function QueueRequest(host, auraSpellID, options)
    if not host then
        return
    end
    pendingRequests[host] = {
        auraSpellID = auraSpellID or false,
        options = options,
    }
    if not Runtime:DeferInCombat(FlushPendingRequests) then
        FlushPendingRequests()
    end
end

local function NormalizeAuraSpellIDs(auraSpellID)
    local source = type(auraSpellID) == "table" and auraSpellID or { auraSpellID }
    local spellIDs = {}
    local seen = {}
    for _, spellID in ipairs(source) do
        spellID = tonumber(spellID)
        if spellID and spellID > 0 and not seen[spellID] then
            seen[spellID] = true
            spellIDs[#spellIDs + 1] = spellID
        end
    end
    return spellIDs
end

local function AreSpellIDListsEqual(left, right)
    if left == right then
        return true
    end
    if not left or not right or #left ~= #right then
        return false
    end
    for index, spellID in ipairs(left) do
        if spellID ~= right[index] then
            return false
        end
    end
    return true
end

local function BuildIncludeSpellIDs(spellIDs)
    local includeSpellIDs = {}
    for _, spellID in ipairs(spellIDs) do
        includeSpellIDs[spellID] = true
        local base = ns.API:ResolveAuraSpellID(spellID)
        if base and base ~= spellID then
            includeSpellIDs[base] = true
        end
    end
    return includeSpellIDs
end

local function InitializeBaseIconCover(state)
    local source = state and state.host and state.host.Icon
    local cover = state and state.iconCover
    if not source or not cover then
        return
    end

    cover:SetTexture(source:GetTexture())
    cover:SetTexCoord(source:GetTexCoord())
    cover:SetVertexColor(source:GetVertexColor())
    if source.GetDesaturation and cover.SetDesaturation then
        cover:SetDesaturation(source:GetDesaturation())
    end

    local mask
    if ns.MasqueModule and ns.MasqueModule.GetIconMask then
        mask = ns.MasqueModule:GetIconMask(state.host)
    elseif source.GetMaskTexture then
        mask = source:GetMaskTexture(1)
    end
    if state.iconCoverMask ~= mask then
        if state.iconCoverMask then
            cover:RemoveMaskTexture(state.iconCoverMask)
        end
        if mask then
            cover:AddMaskTexture(mask)
        end
        state.iconCoverMask = mask
    end
end

local function ApplyApplicationCountStyle(state, stackColor)
    local count = state and state.applicationCount
    local host = state and state.host
    local profile = ns.db and ns.db.profile
    if not count or not host or not profile then
        return
    end

    local fontPath
    local fontSize
    local fontFlags
    local point = "BOTTOMRIGHT"
    local offsetX = -2
    local offsetY = 2

    local parent = host:GetParent()
    local viewerName = parent and parent:GetName()
    local viewerScope = viewerName == "EssentialCooldownViewer" and "Essential"
        or viewerName == "UtilityCooldownViewer" and "Utility"
        or viewerName == "BuffIconCooldownViewer" and "BuffIcons"

    if viewerScope then
        local nativeCount = host.Applications and host.Applications.Applications or host.ChargeCount and host.ChargeCount.Current
        if nativeCount and nativeCount.GetFont then
            fontPath, fontSize, fontFlags = nativeCount:GetFont()
        end

        if profile["cooldownManager_stackAnchor" .. viewerScope .. "_enabled"] then
            local configuredSize = profile["cooldownManager_stackFontSize" .. viewerScope]
            if configuredSize ~= nil and configuredSize ~= "NIL" then
                fontSize = configuredSize
            end
            point = profile["cooldownManager_stackAnchor" .. viewerScope .. "_point"] or point
            offsetX = profile["cooldownManager_stackAnchor" .. viewerScope .. "_offsetX"] or offsetX
            offsetY = profile["cooldownManager_stackAnchor" .. viewerScope .. "_offsetY"] or offsetY
            fontPath = ns.API:GetFontPath(profile.cooldownManager_stackFontName) or fontPath
            fontFlags = ns.API:GetFontFlags(profile.cooldownManager_stackFontFlags)
        end
    else
        local trackerConfig = host.trackerConfigKey and profile.editMode and profile.editMode[host.trackerConfigKey]
        if trackerConfig then
            fontPath = ns.API:GetFontPath(trackerConfig.stackFontName)
            fontSize = trackerConfig.stackFontSize or 14
            fontFlags = ns.API:GetFontFlags(trackerConfig.stackFontFlags or {})
            point = trackerConfig.stackAnchor or point
            offsetX = trackerConfig.stackOffsetX or -1
            offsetY = trackerConfig.stackOffsetY or 1
        elseif host.count then
            -- Essential custom entries reuse the already-applied Essential count style.
            fontPath, fontSize, fontFlags = host.count:GetFont()
            local countPoint, _, _, countOffsetX, countOffsetY = host.count:GetPoint()
            point = countPoint or point
            offsetX = countOffsetX or offsetX
            offsetY = countOffsetY or offsetY
        end
    end

    fontPath = fontPath or ns.CONSTANTS.DEFAULT_NUMBER_FONT[1]
    fontSize = tonumber(fontSize) or 14
    count:SetFont(fontPath, fontSize, fontFlags or "")
    count:ClearAllPoints()
    count:SetPoint(point, state.countOverlay, point, offsetX, offsetY)
    if stackColor then
        if not state.applicationCountOriginalColor then
            state.applicationCountOriginalColor = { count:GetTextColor() }
        end
        count:SetTextColor(stackColor[1], stackColor[2], stackColor[3], 1)
    elseif state.applicationCountOriginalColor then
        count:SetTextColor(unpack(state.applicationCountOriginalColor))
        state.applicationCountOriginalColor = nil
    end
end

local function UpdateContainerVisibility(state)
    if not state then
        return
    end
    if InCombatLockdown() then
        Runtime:DeferInCombat(function()
            UpdateContainerVisibility(state)
        end)
        return
    end
    if not state.container then
        return
    end
    local shouldShow = not Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER)
        and state.enabled
        and state.host
        and state.host:IsShown()
    if shouldShow then
        if not state.containerVisible then
            state.container:SetAuraSlotFilterString(AURA_SLOT_KEY, PLAYER_AURA_FILTER)
            state.container:SetEnabled(true)
            state.container:Show()
            state.container:SetAlpha(1)
            state.container:UpdateAllAuras()
            state.containerVisible = true
        end
    elseif state.containerVisible ~= false then
        state.container:SetAuraSlotFilterString(AURA_SLOT_KEY, "")
        state.container:SetEnabled(false)
        state.container:SetAlpha(0)
        state.container:Hide()
        state.containerVisible = false
    end
end

local function SetContainerActive(state, active)
    if not state then
        return
    end
    state.enabled = active == true
    UpdateContainerVisibility(state)
end

function AuraTracking:IsSupported()
    if supportChecked then
        return supported
    end
    -- Loading Blizzard_AuraContainer creates secure/private template state.
    -- Never initiate that load from tainted addon execution during lockdown.
    if InCombatLockdown() then
        return false
    end
    supportChecked = true

    if not Runtime:Load() then
        if not supportFailureLogged then
            supportFailureLogged = true
            ns.API:LogWarn(ns.API.Error.AuraTrackingLoadContainer, "AuraTracking: failed to load Blizzard_AuraContainer")
        end
        supportChecked = false
        return false
    end

    supported = type(CreateFrame) == "function"
    return supported
end

-- Blizzard applies DenyTaintedAccessWhenAurasAreSecret immediately after the
-- initializeFrame callback returns. Everything owned by the AuraButton must
-- therefore be created and styled in that callback; securecallfunction does
-- not make later addon execution trusted.
local function ApplyAuraButtonStyle(button, state, options)
    local cooldown = state.cooldown
    InitializeBaseIconCover(state)
    ApplyApplicationCountStyle(state, options.stackColor)
    cooldown:SetDrawEdge(options.drawEdge == true)
    cooldown:SetDrawBling(false)
    cooldown:SetDrawSwipe(true)
    cooldown:SetReverse(options.reverse == true)
    cooldown:SetHideCountdownNumbers(options.hideCountdownNumbers == true)
    if cooldown.SetUseAuraDisplayTime then
        cooldown:SetUseAuraDisplayTime(true)
    end
    if options.swipeTexture then
        cooldown:SetSwipeTexture(options.swipeTexture)
    end
    if options.r then
        cooldown:SetSwipeColor(options.r, options.g or 1, options.b or 1, options.a or 1)
    end

    local anchor = options.anchor or state.host.Cooldown or state.host
    button:ClearAllPoints()
    button:SetAllPoints(anchor)

    local host = state.host
    local baseCooldownLevel = host.Cooldown and host.Cooldown:GetFrameLevel() or host:GetFrameLevel()
    local coverLevel = baseCooldownLevel + 1
    local auraCooldownLevel = coverLevel + 1
    local textLevel = auraCooldownLevel + 1
    button:SetFrameLevel(coverLevel)
    cooldown:SetFrameLevel(auraCooldownLevel)
    if state.countOverlay then
        state.countOverlay:SetFrameLevel(textLevel)
    end
end

local function ApplySafeHostStyle(state)
    local host = state and state.host
    local container = state and state.container
    if not host or not container then
        return
    end
    if C_Secrets and C_Secrets.ShouldAurasBeSecret and C_Secrets.ShouldAurasBeSecret() == true then
        -- Challenge/encounter/PvP restriction: leave all visual refresh work
        -- parked until the next unrestricted refresh. The AuraContainer still
        -- owns aura assignment and duration updates in this state.
        return
    end

    local baseCooldownLevel = host.Cooldown and host.Cooldown:GetFrameLevel() or host:GetFrameLevel()
    local textLevel = baseCooldownLevel + 3
    container:SetFrameStrata(host:GetFrameStrata())
    container:SetFrameLevel(math.max(0, baseCooldownLevel - 1))

    -- These are CMC-owned host counters, not AuraButton descendants.
    if host.ChargeCount and host.ChargeCount.SetFrameLevel then
        host.ChargeCount:SetFrameLevel(textLevel)
    end
    local customCountParent = host.count and host.count.GetParent and host.count:GetParent()
    if customCountParent and customCountParent ~= host and customCountParent.SetFrameLevel then
        customCountParent:SetFrameLevel(textLevel)
    end
end

local function CreateContainerForState(state)
    if not state
        or state.container
        or InCombatLockdown()
        or Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER)
    then
        return false
    end

    local options = state.options or {}
    local container = Runtime:Create(AURA_CONTAINER_TEMPLATE)
    if not container then
        if not supportFailureLogged then
            supportFailureLogged = true
            ns.API:LogWarn(ns.API.Error.AuraTrackingMissingMethods, "AuraTracking: AuraContainer is missing required methods")
        end
        supported = false
        return false
    end
    state.container = container
    state.containerVisible = nil
    container:SetAllPoints(UIParent)
    container:SetUnit("player")

    local slot = container:AddAuraSlot(AURA_SLOT_KEY, PLAYER_AURA_FILTER, {
        candidateFilters = { includeSpellIDs = BuildIncludeSpellIDs(state.auraSpellIDs or {}) },
        initializeFrame = function(button)
            button:EnableMouse(false)
            button:SetAlpha(1)
            state.auraButton = button
            -- A child region inherits the AuraButton's secret-controlled
            -- visibility without observing it in Lua. It reproduces the host
            -- icon above the host cooldown, hiding that swipe while the child
            -- aura cooldown remains visible above the cover.
            local iconCover = button:CreateTexture(nil, "ARTWORK")
            iconCover:SetAllPoints(button)
            state.iconCover = iconCover

            local cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
            cooldown:SetAllPoints(button)
            button:SetDurationCooldown(cooldown)
            state.cooldown = cooldown

            -- Blizzard writes the possibly-secret application count directly
            -- to this FontString. CMC only styles the region outside combat.
            if type(button.SetApplicationCount) == "function" then
                local countOverlay = CreateFrame("Frame", nil, button)
                countOverlay:SetAllPoints(button)
                local applicationCount = countOverlay:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
                applicationCount:SetPoint("BOTTOMRIGHT", countOverlay, "BOTTOMRIGHT", -2, 2)
                button:SetApplicationCount(applicationCount)
                state.countOverlay = countOverlay
                state.applicationCount = applicationCount
            end

            ApplyAuraButtonStyle(button, state, options)
        end,
    })
    if not slot or not state.cooldown then
        Runtime:Deactivate(container)
        state.container = nil
        state.containerVisible = false
        state.auraButton = nil
        state.iconCover = nil
        state.iconCoverMask = nil
        state.cooldown = nil
        state.countOverlay = nil
        state.applicationCount = nil
        state.applicationCountOriginalColor = nil
        return false
    end

    return true
end

local function SuspendContainerForState(state)
    local container = state and state.container
    if not container then
        return false
    end
    if state.auraContainerSuspended then
        return true
    end

    -- Event registrations are a forbidden AuraContainer aspect. Empty the slot
    -- and reuse this native frame after the unit relationship is valid again
    -- instead of unregistering events or creating an accumulating replacement.
    container:SetAuraSlotFilterString(AURA_SLOT_KEY, "")
    container:SetAuraSlotCandidateFilters(AURA_SLOT_KEY, { includeSpellIDs = {} })
    Runtime:Deactivate(container)
    container:SetAlpha(0)
    state.containerVisible = false
    state.auraContainerSuspended = true
    return true
end

local function CreateState(host, auraSpellID, options)
    -- Defense in depth: keep this constructor safe even if a future caller
    -- bypasses Attach's combat queue.
    if InCombatLockdown() then
        QueueRequest(host, auraSpellID, options)
        return nil
    end
    options = options or {}

    local baseIcon = host.Icon
    if not baseIcon or type(baseIcon.GetTexture) ~= "function" then
        return nil
    end
    local spellIDs = NormalizeAuraSpellIDs(auraSpellID)
    local state = {
        host = host,
        auraSpellID = spellIDs[1],
        auraSpellIDs = spellIDs,
        options = options,
        enabled = true,
    }

    states[host] = state
    host:HookScript("OnShow", function()
        local current = states[host]
        UpdateContainerVisibility(current)
    end)
    host:HookScript("OnHide", function()
        local current = states[host]
        UpdateContainerVisibility(current)
    end)

    if Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER) then
        return state
    end
    if not CreateContainerForState(state) then
        states[host] = nil
        return nil
    end

    ApplySafeHostStyle(state)
    SetContainerActive(state, true)
    return state
end

local function RefreshAuraContainers()
    local blocked = Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER)
    for _, state in pairs(states) do
        if blocked then
            SuspendContainerForState(state)
        elseif not state.container and state.enabled then
            if CreateContainerForState(state) then
                ApplySafeHostStyle(state)
                UpdateContainerVisibility(state)
            end
        elseif state.container and state.auraContainerSuspended then
            state.container:SetAuraSlotCandidateFilters(AURA_SLOT_KEY, {
                includeSpellIDs = BuildIncludeSpellIDs(state.auraSpellIDs or {}),
            })
            state.auraContainerSuspended = nil
            if state.enabled then
                ApplySafeHostStyle(state)
                UpdateContainerVisibility(state)
            end
        elseif state.container then
            UpdateContainerVisibility(state)
        end
    end
end

Runtime:RegisterAuraRelationshipRefresh(RefreshAuraContainers)

function AuraTracking:Attach(host, auraSpellID, options)
    local auraSpellIDs = NormalizeAuraSpellIDs(auraSpellID)
    if not host or #auraSpellIDs == 0 then
        self:Detach(host)
        return false
    end

    options = options or {}
    -- CustomAuraContainerTemplate uses a forbidden object table and secure
    -- delegates. Creating it or calling its inbound methods during combat can
    -- leave a partially initialized container and taint later template loads.
    if InCombatLockdown() then
        QueueRequest(host, auraSpellIDs, options)
        return true
    end
    if not self:IsSupported() then
        self:Detach(host)
        return false
    end

    pendingRequests[host] = nil
    local state = states[host]
    if not state then
        state = CreateState(host, auraSpellIDs, options)
        return state ~= nil
    end

    if not AreSpellIDListsEqual(state.auraSpellIDs, auraSpellIDs) then
        state.auraSpellID = auraSpellIDs[1]
        state.auraSpellIDs = auraSpellIDs
        if state.container and not Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER) then
            state.container:SetAuraSlotCandidateFilters(AURA_SLOT_KEY, {
                includeSpellIDs = BuildIncludeSpellIDs(auraSpellIDs),
            })
        end
    end
    state.options = options
    if not state.container and not Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER) then
        if not CreateContainerForState(state) then
            return false
        end
        ApplySafeHostStyle(state)
    end
    if state.container then
        ApplySafeHostStyle(state)
    end
    SetContainerActive(state, true)
    return true
end

function AuraTracking:Detach(host)
    if not host then
        return
    end
    if InCombatLockdown() then
        QueueRequest(host, false, nil)
        return
    end

    pendingRequests[host] = nil
    local state = host and states[host]
    if state then
        SetContainerActive(state, false)
    end
end

FlushPendingRequests = function()
    -- Last request wins for each pooled host frame. Clear before applying so a
    -- request that somehow requeues itself is preserved for the next flush.
    local requests = pendingRequests
    pendingRequests = setmetatable({}, { __mode = "k" })
    for host, request in pairs(requests) do
        if request.auraSpellID then
            AuraTracking:Attach(host, request.auraSpellID, request.options)
        else
            AuraTracking:Detach(host)
        end
    end

    -- Host visibility may have changed while its container was intentionally
    -- untouched in combat. Reconcile every live container once lockdown ends.
    for _, state in pairs(states) do
        UpdateContainerVisibility(state)
    end
end

local playerAuraMonitor = CreateFrame("Frame")
playerAuraMonitor:RegisterUnitEvent("UNIT_FACTION", "player")
playerAuraMonitor:RegisterUnitEvent("UNIT_FLAGS", "player")
playerAuraMonitor:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "player")
local playerAuraRefreshPending = false
playerAuraMonitor:SetScript("OnEvent", function(self)
    if playerAuraRefreshPending then
        return
    end
    playerAuraRefreshPending = true
    self:SetScript("OnUpdate", function(refreshFrame)
        refreshFrame:SetScript("OnUpdate", nil)
        playerAuraRefreshPending = false
        if Runtime.IsAuraContainerBlocked("player", PLAYER_AURA_FILTER) then
            for _, state in pairs(states) do
                if state.container then
                    Runtime:Deactivate(state.container)
                    state.container:SetAlpha(0)
                    state.containerVisible = false
                end
            end
            return
        end
        for _, state in pairs(states) do
            local container = state.container
            if container and container:IsEnabled() and container:IsVisible() then
                container:UpdateAllAuras()
            end
        end
    end)
end)
