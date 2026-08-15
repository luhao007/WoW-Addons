local _, ns = ...

local CustomAuraProvider = {}
ns.CustomAuraProvider = CustomAuraProvider

local API = ns.API
local Runtime = ns.AuraContainerRuntime
local Pixel = ns.PixelPerfect

-- Frame -> visual state for every custom aura button styled by this provider.
local visuals = setmetatable({}, { __mode = "k" })
-- stableKey -> definition, rebuilt from all active containers (styles + sounds).
local definitions = {}
-- Buff containers that currently own a live AuraContainer (widget -> true).
local activeContainers = {}
-- Includes inactive widgets that still own disabled native controllers.
local containersWithControllers = setmetatable({}, { __mode = "k" })
local controllerFailureLogged = false

local NATIVE_MASK_ATLAS = "UI-HUD-CoolDownManager-Mask"
local NATIVE_OVERLAY_ATLAS = "UI-HUD-CoolDownManager-IconOverlay"
local NATIVE_SWIPE_TEXTURE = "Interface\\HUD\\UI-HUD-CoolDownManager-Icon-Swipe"
local SQUARE_MASK_TEXTURE = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square"

local function IsCustomAuraFeatureAvailable()
    return Runtime:IsAvailable()
end

local function SetNativeOverlayAnchors(overlay, icon, width, height)
    local ratio = width > 0 and height / width or 1
    overlay:ClearAllPoints()
    Pixel.SetPoint(overlay, "TOPLEFT", icon, "TOPLEFT", -8, 7 * ratio)
    Pixel.SetPoint(overlay, "BOTTOMRIGHT", icon, "BOTTOMRIGHT", 8, -7 * ratio)
    Pixel.ApplyTexturePixelSnapping(overlay)
end

local function ApplyIconSurfaceStyle(frame, visual, width, height, square, padding)
    padding = padding or 0
    local profile = ns.db.profile
    Pixel.SetSize(frame, width + padding, height + padding, 1, 1)
    local surface = visual.surface or Pixel.SyncContainer(frame)
    visual.icon:ClearAllPoints()
    Pixel.SetSize(visual.icon, width, height, 1, 1)
    visual.icon:SetPoint("CENTER", surface, "CENTER")
    Pixel.ApplyTexturePixelSnapping(visual.icon)
    visual.mask:ClearAllPoints()
    visual.mask:SetAllPoints(visual.icon)
    Pixel.ApplyTexturePixelSnapping(visual.mask)

    local borderThickness = 0
    if square then
        local zoom = profile.cooldownManager_squareIconsZoom_BuffIcons or 0
        local crop = math.max(0, math.min(0.49, zoom * 0.5))
        local ratio = width / height
        if ratio > 1 then
            local horizontalSpan = 1 - 2 * crop
            local verticalSpan = math.max(0, math.min(1, horizontalSpan / ratio))
            local verticalCrop = (1 - verticalSpan) * 0.5
            visual.icon:SetTexCoord(crop, 1 - crop, verticalCrop, 1 - verticalCrop)
        else
            visual.icon:SetTexCoord(crop, 1 - crop, crop, 1 - crop)
        end
        visual.mask:SetTexture(SQUARE_MASK_TEXTURE)
        visual.overlay:SetAlpha(0)
        local borderPixels = profile.cooldownManager_squareIconsBorder_BuffIcons or 0
        if borderPixels > 0 then
            borderThickness = API:ApplyPixelBorder(visual.border, surface, borderPixels)
        else
            API:HidePixelBorder(visual.border)
        end
    else
        visual.icon:SetTexCoord(0, 1, 0, 1)
        visual.mask:SetAtlas(NATIVE_MASK_ATLAS)
        visual.overlay:SetAlpha(1)
        SetNativeOverlayAnchors(visual.overlay, visual.icon, width, height)
        API:HidePixelBorder(visual.border)
    end
    if visual.cooldown then
        visual.cooldown:ClearAllPoints()
        if square then
            visual.cooldown:SetPoint("TOPLEFT", surface, "TOPLEFT", borderThickness, -borderThickness)
            visual.cooldown:SetPoint("BOTTOMRIGHT", surface, "BOTTOMRIGHT", -borderThickness, borderThickness)
        else
            visual.cooldown:SetAllPoints(surface)
        end
    end
    if visual.applicationsFrame then
        visual.applicationsFrame:SetAllPoints(visual.icon)
    end
    return borderThickness
end

local function ApplyCustomAuraFontStyle(frame, visual)
    local profile = ns.db.profile
    local cooldownFontString = visual.cooldown:GetCountdownFontString()
    if cooldownFontString then
        if not visual.cooldownFontDefaults then
            local path, size, flags = cooldownFontString:GetFont()
            visual.cooldownFontDefaults = { path, size, flags or "" }
        end

        if profile.cooldownManager_cooldownFontSizeBuffIcons_enabled then
            local size = profile.cooldownManager_cooldownFontSizeBuffIcons
            if size == 0 then
                cooldownFontString:SetFontHeight(0)
            else
                if not size or size == "NIL" then
                    size = visual.cooldownFontDefaults[2] or 14
                end
                local fontPath = ns.API:GetFontPath(profile.cooldownManager_cooldownFontName) or visual.cooldownFontDefaults[1]
                cooldownFontString:SetFont(fontPath, size, ns.API:GetFontFlags(profile.cooldownManager_cooldownFontFlags))
            end
            local x = profile.cooldownManager_cooldownTextBuffIcons_offsetX or 0
            local y = profile.cooldownManager_cooldownTextBuffIcons_offsetY or 0
            cooldownFontString:ClearAllPoints()
            cooldownFontString:SetPoint("CENTER", visual.cooldown, "CENTER", x, y)
        else
            cooldownFontString:SetFont(unpack(visual.cooldownFontDefaults))
            cooldownFontString:ClearAllPoints()
            cooldownFontString:SetPoint("CENTER", visual.cooldown, "CENTER", 0, 0)
        end
    end

    local applications = visual.applications
    if not visual.applicationFontDefaults then
        local path, size, flags = applications:GetFont()
        visual.applicationFontDefaults = { path, size, flags or "" }
    end

    applications:ClearAllPoints()
    if profile.cooldownManager_stackAnchorBuffIcons_enabled then
        local size = profile.cooldownManager_stackFontSizeBuffIcons
        if size == 0 then
            applications:SetFontHeight(0)
        else
            if not size or size == "NIL" then
                size = visual.applicationFontDefaults[2] or 14
            end
            local fontPath = ns.API:GetFontPath(profile.cooldownManager_stackFontName) or visual.applicationFontDefaults[1]
            applications:SetFont(fontPath, size, ns.API:GetFontFlags(profile.cooldownManager_stackFontFlags))
        end
        local point = profile.cooldownManager_stackAnchorBuffIcons_point or "BOTTOMRIGHT"
        applications:SetPoint(
            point,
            visual.icon,
            point,
            profile.cooldownManager_stackAnchorBuffIcons_offsetX or 0,
            profile.cooldownManager_stackAnchorBuffIcons_offsetY or 0
        )
    else
        applications:SetFont(unpack(visual.applicationFontDefaults))
        applications:SetPoint("BOTTOMRIGHT", visual.icon, "BOTTOMRIGHT", -2, 2)
    end
end

local function GetBlizzardTooltipsShown()
    local viewer = _G["BuffIconCooldownViewer"]
    return not viewer or viewer.tooltipsShown ~= false
end

-- Called only from initializeFrame, before AuraContainer applies
-- DenyTaintedAccessWhenAurasAreSecret to the new AuraButton.
local function ApplyCustomAuraStyle(frame)
    if InCombatLockdown() then
        return
    end

    local visual = visuals[frame]

    local profile = ns.db.profile
    local width, height = ns.Sizes.GetViewerIconSize("BuffIcons")
    local masqueActive = ns.MasqueModule and ns.MasqueModule:IsActive()
    local square = profile.cooldownManager_squareIcons_BuffIcons and not masqueActive
    local borderThickness = ApplyIconSurfaceStyle(frame, visual, width, height, square, 0)
    local surface = visual.surface or frame
    visual.cooldown:SetReverse(true)
    visual.cooldown:SetDrawEdge(false)
    visual.cooldown:SetSwipeColor(0, 0, 0, 0.49)
    if square then
        visual.cooldown:SetSwipeTexture(SQUARE_MASK_TEXTURE, 0, 0, 0, 0.49)
        visual.cooldown:ClearAllPoints()
        visual.cooldown:SetPoint("TOPLEFT", surface, "TOPLEFT", borderThickness, -borderThickness)
        visual.cooldown:SetPoint("BOTTOMRIGHT", surface, "BOTTOMRIGHT", -borderThickness, borderThickness)
    else
        visual.cooldown:SetSwipeTexture(NATIVE_SWIPE_TEXTURE, 0, 0, 0, 0.49)
        visual.cooldown:ClearAllPoints()
        visual.cooldown:SetAllPoints(surface)
    end
    visual.applicationsFrame:SetFrameLevel(frame:GetFrameLevel() + 10)
    visual.border:SetFrameLevel(frame:GetFrameLevel() + 1)
    ApplyCustomAuraFontStyle(frame, visual)
end

local function InitializeAuraFrame(frame)
    frame:SetIgnoringChildrenForBounds(true)
    frame:SetCollapsesLayout(true)
    frame:SetAlpha(1)
    Pixel.SetSize(frame, 40, 40, 1, 1)
    if frame.SetMouseMotionEnabled then
        frame:SetMouseMotionEnabled(GetBlizzardTooltipsShown())
    end

    -- AuraButton becomes access-constrained after initializeFrame returns. Build
    -- its complete pixel surface now; only the unprotected chain host is tracked
    -- later, so the shared ticker never reads or mutates a restricted AuraButton.
    local surface = CreateFrame("Frame", nil, frame)
    surface:SetAllPoints(frame)
    surface:SetFrameLevel(frame:GetFrameLevel())
    surface:EnableMouse(false)

    local icon = frame:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints(frame)
    Pixel.ApplyTexturePixelSnapping(icon)

    local mask = frame:CreateMaskTexture(nil, "ARTWORK")
    mask:SetAllPoints(frame)
    mask:SetAtlas(NATIVE_MASK_ATLAS)
    icon:AddMaskTexture(mask)
    frame:SetIcon(icon)

    local overlay = frame:CreateTexture(nil, "OVERLAY")
    overlay:SetAtlas(NATIVE_OVERLAY_ATLAS)
    SetNativeOverlayAnchors(overlay, icon, 40, 40)

    local cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
    cooldown:SetAllPoints(frame)
    cooldown:SetReverse(true)
    cooldown:SetDrawEdge(false)
    cooldown:SetSwipeTexture(NATIVE_SWIPE_TEXTURE, 0, 0, 0, 0.49)
    cooldown:SetSwipeColor(0, 0, 0, 0.49)
    cooldown:SetUseAuraDisplayTime(true)
    frame:SetDurationCooldown(cooldown)

    local applicationsFrame = CreateFrame("Frame", nil, frame)
    applicationsFrame:SetAllPoints(frame)
    applicationsFrame:SetFrameLevel(frame:GetFrameLevel() + 10)
    local applications = applicationsFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    frame:SetApplicationCount(applications)

    local border = CreateFrame("Frame", nil, frame)
    border:SetAllPoints(frame)
    border:SetFrameLevel(frame:GetFrameLevel() + 1)
    border:Hide()

    visuals[frame] = {
        surface = surface,
        icon = icon,
        mask = mask,
        overlay = overlay,
        cooldown = cooldown,
        applications = applications,
        applicationsFrame = applicationsFrame,
        border = border,
    }
    ApplyCustomAuraStyle(frame)
end

local function GetAuraType(definition)
    return definition and definition.auraType == "harmful" and "harmful" or "helpful"
end

local function GetFilterString(auraType)
    -- Harmful custom auras always track our own debuffs: combine HARMFUL with
    -- PLAYER so debuffs applied by other players/pets never match.
    return auraType == "harmful" and "HARMFUL|PLAYER" or "HELPFUL"
end

local function BuildCandidateFilters(definition)
    local includeSpellIDs = {}
    local function addSpellID(value)
        value = tonumber(value)
        if value and value > 0 then
            includeSpellIDs[value] = true
            local base = API:ResolveAuraSpellID(value)
            if base and base ~= value then
                includeSpellIDs[base] = true
            end
        end
    end
    if type(definition.spellIDs) == "table" and #definition.spellIDs > 0 then
        for _, spellID in ipairs(definition.spellIDs) do
            addSpellID(spellID)
        end
    elseif definition.spellID then
        addSpellID(definition.spellID)
    end
    return { includeSpellIDs = includeSpellIDs }
end

local function GetSortEnums()
    local sortMethods = _G["AuraContainerSortMethod"]
    local sortDirections = _G["AuraContainerSortDirection"]
    if not sortMethods or not sortDirections then
        if not controllerFailureLogged then
            controllerFailureLogged = true
            ns.API:LogWarn(ns.API.Error.CustomAuraSortEnums, "CustomAuraProvider: AuraContainer sort enums are missing")
        end
        return nil
    end
    return sortMethods.Default, sortDirections.Normal
end

local function GetUnitToken(auraType)
    return auraType == "harmful" and "target" or "player"
end

local function IsAuraTypeBlocked(auraType)
    return Runtime.IsAuraContainerBlocked(GetUnitToken(auraType), GetFilterString(auraType))
end

local function ReplaceDefinitions(container, newDefinitions)
    container.definitions = container.definitions or {}
    for stableKey in pairs(container.definitions) do
        if not newDefinitions[stableKey] then
            container.definitions[stableKey] = nil
        end
    end
    for stableKey, definition in pairs(newDefinitions) do
        container.definitions[stableKey] = definition
    end
end

local function SuspendContainerControllers(container)
    if container.vehicleAuraControllersSuspended then
        return
    end
    for stableKey, controller in pairs(container.entryControllers or {}) do
        if container.groupKeys and container.groupKeys[stableKey] then
            controller:SetAuraGroupFilterString(stableKey, "")
            controller:SetAuraGroupMaxFrameCount(stableKey, 0)
            controller:SetAuraGroupCandidateFilters(stableKey, { includeSpellIDs = {} })
        end
        Runtime:Deactivate(controller)
    end
    container.layoutSignature = nil
    container.vehicleAuraControllersSuspended = true
end

-- One native AuraContainer PER ENTRYPOINT, each with its own unit (player for
-- helpful, target for harmful), parented to the container's anchor. Each holds
-- exactly one group, so Blizzard FlowLayout auto-sizes it (collapses to 0 when
-- inactive) and the containers are chained through anchors in the shared order:
-- target, player, target, ...
local function EnsureController(container, stableKey, auraType)
    if Runtime.IsVehicleAuraContainerBlocked() then
        return nil
    end
    local controllers = container.entryControllers or {}
    local controller = controllers[stableKey]
    if controller then
        containersWithControllers[container] = true
        return controller
    end
    if not Runtime:Load() then
        if not controllerFailureLogged then
            controllerFailureLogged = true
            ns.API:LogWarn(ns.API.Error.CustomAuraLoadContainer, "CustomAuraProvider: failed to load Blizzard_AuraContainer")
        end
        return nil
    end
    local sortMethodDefault, sortDirectionNormal = GetSortEnums()
    if not sortMethodDefault then
        return nil
    end
    local host = container.chainHost
    if not host then
        local layoutRoot = container.GetLayoutFrame and container:GetLayoutFrame() or container.anchor
        host = CreateFrame("Frame", nil, layoutRoot)
        host:SetSize(0.001, 0.001)
        host:SetScale(container:GetIconSize() or 1)
        container.chainHost = host
    end
    controller = CreateFrame("AuraContainer", nil, host, "CustomAuraContainerTemplate")
    controller:SetUnit(GetUnitToken(auraType))
    controller:SetEnabled(false)
    controllers[stableKey] = controller
    container.entryControllers = controllers
    containersWithControllers[container] = true
    container.sortMethodDefault = sortMethodDefault
    container.sortDirectionNormal = sortDirectionNormal
    return controller
end

local function SyncGroups(container, newDefinitions)
    container.definitions = container.definitions or {}
    container.entryControllers = container.entryControllers or {}
    container.entryUnits = container.entryUnits or {}
    container.groupKeys = container.groupKeys or {}

    ReplaceDefinitions(container, newDefinitions)

    for stableKey, definition in pairs(newDefinitions) do
        local auraType = GetAuraType(definition)
        local blocked = IsAuraTypeBlocked(auraType)
        local controller = container.entryControllers[stableKey]
        container.entryUnits[stableKey] = GetUnitToken(auraType)
        if blocked then
            if controller and container.groupKeys[stableKey] then
                controller:SetAuraGroupFilterString(stableKey, "")
                controller:SetAuraGroupMaxFrameCount(stableKey, 0)
                controller:SetAuraGroupCandidateFilters(stableKey, { includeSpellIDs = {} })
                Runtime:Deactivate(controller)
            end
        else
            controller = controller or EnsureController(container, stableKey, auraType)
        end
        if controller and not blocked then
            local filterString = GetFilterString(auraType)
            -- Custom entries show one frame; wildcards may show many.
            local maxFrameCount = definition.wildcard == true and math.huge or 1
            if not container.groupKeys[stableKey] then
                local initFrame = function(frame)
                    InitializeAuraFrame(frame)
                end
                controller:AddAuraGroup(stableKey, filterString, {
                    initializeFrame = initFrame,
                    candidateFilters = BuildCandidateFilters(definition),
                    sortMethod = container.sortMethodDefault,
                    sortDirection = container.sortDirectionNormal,
                    maxFrameCount = maxFrameCount,
                })
                container.groupKeys[stableKey] = true
            else
                controller:SetAuraGroupFilterString(stableKey, filterString)
                controller:SetAuraGroupMaxFrameCount(stableKey, maxFrameCount)
                controller:SetAuraGroupCandidateFilters(stableKey, BuildCandidateFilters(definition))
            end
            controller:Show()
            controller:SetEnabled(true)
            controller:UpdateAllAuras()
        end
    end

    -- Groups cannot be removed through the public API, so removed definitions are
    -- disabled with an empty candidate set, a zero frame cap and a hidden controller.
    for stableKey, controller in pairs(container.entryControllers) do
        if not newDefinitions[stableKey] then
            controller:SetAuraGroupFilterString(stableKey, "")
            controller:SetAuraGroupMaxFrameCount(stableKey, 0)
            controller:SetAuraGroupCandidateFilters(stableKey, { includeSpellIDs = {} })
            controller:SetEnabled(false)
            controller:Hide()
        end
    end
    container.vehicleAuraControllersSuspended = nil
end

local function RebuildDefinitions()
    wipe(definitions)
    for container in pairs(activeContainers) do
        for stableKey, definition in pairs(container.definitions or {}) do
            definitions[stableKey] = definition
        end
    end
end

function CustomAuraProvider:GetDefinitionCount(container)
    local count = 0
    for _ in pairs(container.definitions or {}) do
        count = count + 1
    end
    return count
end

-- Edit Mode look-alikes: 1:1 icons in the final style, laid out on the marker's
-- theoretical footprint. Alpha only; never part of the real layout.
local function EnsurePreview(container, stableKey, definition)
    local previews = container.previews or {}
    if previews[stableKey] then
        return previews[stableKey]
    end

    local layoutRoot = container.GetLayoutFrame and container:GetLayoutFrame() or container.anchor
    local preview = CreateFrame("Frame", nil, layoutRoot, "BackdropTemplate")
    preview:EnableMouse(false)
    preview:SetAlpha(0)

    local icon = preview:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints(preview)
    local mask = preview:CreateMaskTexture(nil, "ARTWORK")
    mask:SetAllPoints(preview)
    mask:SetAtlas(NATIVE_MASK_ATLAS)
    icon:AddMaskTexture(mask)
    local overlay = preview:CreateTexture(nil, "OVERLAY")
    overlay:SetAtlas(NATIVE_OVERLAY_ATLAS)
    local border = CreateFrame("Frame", nil, preview)
    border:SetAllPoints(preview)
    border:SetFrameLevel(preview:GetFrameLevel() + 1)
    border:Hide()

    local width, height = ns.Sizes.GetViewerIconSize("BuffIcons")
    width = width or 40
    height = height or 40
    local masqueActive = ns.MasqueModule and ns.MasqueModule:IsActive()
    local square = ns.db.profile.cooldownManager_squareIcons_BuffIcons and not masqueActive
    local visual = {
        icon = icon,
        mask = mask,
        overlay = overlay,
        border = border,
    }
    ApplyIconSurfaceStyle(preview, visual, width, height, square, 0)
    icon:SetTexture(definition.iconID or 134400)
    preview.cmcPreviewIcon = icon
    preview.cmcPreviewVisual = visual

    previews[stableKey] = preview
    container.previews = previews
    return preview
end

local function SyncPreviews(container, newDefinitions)
    for stableKey, definition in pairs(newDefinitions) do
        EnsurePreview(container, stableKey, definition)
    end
    for stableKey, preview in pairs(container.previews or {}) do
        if not newDefinitions[stableKey] then
            preview:SetAlpha(0)
            container.previews[stableKey] = nil
        end
    end
end

function CustomAuraProvider:UpdateContainerPreviews(container)
    local previews = container.previews
    if not previews then
        return
    end

    local editMode = ns.Runtime.isInEditMode or ns.Runtime.hasSettingsOpened

    for _, controller in pairs(container.entryControllers or {}) do
        controller:SetAlpha(editMode and 0 or 1)
    end

    local width, height = ns.Sizes.GetViewerIconSize("BuffIcons")
    width = width or 40
    height = height or 40
    local scale = container:GetIconSize() or 1
    local horizontal = container:GetOrientation() ~= "Vertical"
    local reversed = container:GetIconDirection() == "Reversed"
    local alignment = container:GetAlignment()
    local orders = ns.BuffData.GetOrders()

    -- Same start edge as ChainContainers so previews line up with real icons.
    local anchorPoint
    if horizontal then
        anchorPoint = (alignment == "END") ~= reversed and "RIGHT" or "LEFT"
    else
        anchorPoint = (alignment == "START") ~= reversed and "BOTTOM" or "TOP"
    end

    local items = {}
    for stableKey in pairs(previews) do
        items[#items + 1] = stableKey
    end
    table.sort(
        items,
        ns.API:BuildOrderComparator(
            function(key)
                return orders[key]
            end,
            nil,
            function(key)
                return key
            end
        )
    )

    local layoutRoot = container.GetLayoutFrame and container:GetLayoutFrame() or container.anchor
    local frameLevel = container.anchor:GetFrameLevel() - 1
    local dir = (anchorPoint == "RIGHT" or anchorPoint == "TOP") and -1 or 1
    local baseX = horizontal and (dir * width / 2) or 0
    local baseY = not horizontal and (dir * height / 2) or 0
    local stepX = horizontal and (dir * width) or 0
    local stepY = not horizontal and (dir * height) or 0

    for index, stableKey in ipairs(items) do
        local preview = previews[stableKey]
        preview:SetScale(scale)
        Pixel.SetSize(preview, width, height, 1, 1)
        if preview.cmcPreviewVisual then
            local masqueActive = ns.MasqueModule and ns.MasqueModule:IsActive()
            local square = ns.db.profile.cooldownManager_squareIcons_BuffIcons and not masqueActive
            ApplyIconSurfaceStyle(preview, preview.cmcPreviewVisual, width, height, square, 0)
        end
        preview:SetFrameLevel(frameLevel)
        preview:ClearAllPoints()
        local offsetX = baseX + (index - 1) * stepX
        local offsetY = baseY + (index - 1) * stepY
        Pixel.SetPoint(preview, "CENTER", layoutRoot, anchorPoint, offsetX, offsetY)
        preview:SetAlpha(editMode and 1 or 0)
    end
end

function CustomAuraProvider:ApplyGroupLayout(container)
    local controllers = container.entryControllers or {}
    if InCombatLockdown() then
        return
    end

    local scale = container:GetIconSize() or 1
    local signature = string.format("%s|%s|%s", tostring(container:GetOrientation()), tostring(container:GetIconDirection()), tostring(scale))
    if container.layoutSignature == signature then
        return
    end
    container.layoutSignature = signature

    local width, height = ns.Sizes.GetViewerIconSize("BuffIcons")
    width = width or 40
    height = height or 40
    -- AuraContainer's element dimensions only affect its flow footprint; they do
    -- not resize the protected AuraButtons or their styled child regions. Scale
    -- the addon-owned host instead so the icon, cooldown, applications and border
    -- all follow the container's Icon Size setting without touching protected frames.
    if container.chainHost then
        container.chainHost:SetScale(scale)
    end
    local anchorUtil = _G.AnchorUtil
    local reversed = container:GetIconDirection() == "Reversed"
    for stableKey, controller in pairs(controllers) do
        if anchorUtil and anchorUtil.FlowLayoutAxis and anchorUtil.FlowDirection then
            local vertical = container:GetOrientation() == "Vertical"
            controller:SetFlowLayoutAxis(vertical and anchorUtil.FlowLayoutAxis.Vertical or anchorUtil.FlowLayoutAxis.Horizontal)
            if vertical then
                controller:SetFlowLayoutGrowthDirection(
                    anchorUtil.FlowDirection.Right,
                    reversed and anchorUtil.FlowDirection.Up or anchorUtil.FlowDirection.Down
                )
                controller:SetFlowLayoutAnchorPoint(reversed and "BOTTOMLEFT" or "TOPLEFT")
            else
                controller:SetFlowLayoutGrowthDirection(
                    reversed and anchorUtil.FlowDirection.Left or anchorUtil.FlowDirection.Right,
                    anchorUtil.FlowDirection.Down
                )
                controller:SetFlowLayoutAnchorPoint(reversed and "TOPRIGHT" or "TOPLEFT")
            end
        end
        controller:SetAuraGroupLayout(stableKey, {
            elementSpacing = 0,
            elementWidth = Pixel.Snap(width, container.chainHost, 1),
            elementHeight = Pixel.Snap(height, container.chainHost, 1),
        })
    end
end

-- Combat-safe host wrap: re-anchors the CMC-owned host to the marker and sizes
-- it around the current chain. Never touches the protected AuraContainer
-- controllers, so it can run while combat lockdown is active.
local function ResizeChainHost(container)
    local host = container.chainHost
    if not host then
        return
    end
    local layoutRoot = container.GetLayoutFrame and container:GetLayoutFrame() or container.anchor
    local hostAnchor = container:GetAlignmentAnchor()
    host:ClearAllPoints()
    host:SetPoint(hostAnchor, layoutRoot, hostAnchor, 0, 0)
    host:SetSize(0.001, 0.001)
    host:ResizeToBoundsRect()
    local width, height = host:GetSize()
    if canaccessvalue and (not canaccessvalue(width) or not canaccessvalue(height)) then
        -- AuraContainer bounds can be secret even outside combat lockdown.
        -- ResizeToBoundsRect already applied them without exposing their values.
        return
    end
    if width and height and width > 0 and height > 0 then
        Pixel.SetSize(host, width, height, 1, 1)
    end
    local left, top = host:GetLeft(), host:GetTop()
    if canaccessvalue and (not canaccessvalue(left) or not canaccessvalue(top)) then
        return
    end
    local offsetX = left and (Pixel.Snap(left, host) - left) or 0
    local offsetY = top and (Pixel.Snap(top, host) - top) or 0
    host:ClearAllPoints()
    host:SetPoint(hostAnchor, layoutRoot, hostAnchor, offsetX, offsetY)
end
CustomAuraProvider.ResizeChainHost = ResizeChainHost

-- Chains the per-entrypoint containers inside a hidden chainHost that
-- auto-sizes (like the PoC parent). The host is anchored to the marker per
-- alignment, so CENTER really grows from the marker's center: when icons appear
-- or disappear the host resizes around them and stays centered. Collapsed
-- containers are 0-sized, so the chain packs without reading sizes.
function CustomAuraProvider:ChainContainers(container)
    local controllers = container.entryControllers or {}
    if InCombatLockdown() then
        -- Protected controllers cannot be re-anchored in combat; the CMC-owned
        -- host can still re-wrap around their current (Blizzard-managed) sizes.
        ResizeChainHost(container)
        return
    end
    local host = container.chainHost
    if not host then
        return
    end

    local gap = 0
    local horizontal = container:GetOrientation() ~= "Vertical"
    local reversed = container:GetIconDirection() == "Reversed"
    local orders = ns.BuffData.GetOrders()

    local items = {}
    for stableKey in pairs(controllers) do
        items[#items + 1] = stableKey
    end
    table.sort(
        items,
        ns.API:BuildOrderComparator(
            function(key)
                return orders[key]
            end,
            nil,
            function(key)
                return key
            end
        )
    )
    local alignment = container:GetAlignment()

    -- Host anchor = alignment anchor of the marker (LEFT/CENTER/RIGHT or
    -- BOTTOM/CENTER/TOP), so CENTER keeps the host centered while it resizes.
    local hostAnchor = container:GetAlignmentAnchor()
    local layoutRoot = container.GetLayoutFrame and container:GetLayoutFrame() or container.anchor
    host:ClearAllPoints()
    host:SetPoint(hostAnchor, layoutRoot, hostAnchor, 0, 0)

    -- The edge where the chain starts inside the host: horizontal START/CENTER
    -- from LEFT, END from RIGHT; vertical START from BOTTOM, CENTER/END from TOP.
    -- Reversed flips to the opposite edge.
    local firstEdge
    if horizontal then
        firstEdge = (alignment == "END") ~= reversed and "RIGHT" or "LEFT"
    else
        firstEdge = (alignment == "START") ~= reversed and "BOTTOM" or "TOP"
    end

    local previous
    for index, stableKey in ipairs(items) do
        local controller = controllers[stableKey]
        controller:ClearAllPoints()
        if index == 1 then
            controller:SetPoint(firstEdge, host, firstEdge, 0, 0)
        elseif horizontal then
            if firstEdge == "LEFT" then
                controller:SetPoint("LEFT", previous, "RIGHT", gap)
            else
                controller:SetPoint("RIGHT", previous, "LEFT", -gap)
            end
        elseif firstEdge == "TOP" then
            controller:SetPoint("TOP", previous, "BOTTOM", 0, -gap)
        else
            controller:SetPoint("BOTTOM", previous, "TOP", 0, gap)
        end
        previous = controller
    end
    ResizeChainHost(container)
end

function CustomAuraProvider:RefreshContainer(container, newDefinitions)
    if not IsCustomAuraFeatureAvailable() then
        self:DisableContainer(container)
        return
    end
    newDefinitions = newDefinitions or {}
    if InCombatLockdown() then
        container.pendingDefinitions = newDefinitions
        Runtime:DeferInCombat(function()
            CustomAuraProvider:RefreshContainer(container, container.pendingDefinitions or {})
            if ns.CooldownManager then
                ns.CooldownManager.ForceRefresh({ icons = true })
            end
        end)
        return
    end
    container.pendingDefinitions = nil

    activeContainers[container] = true
    if Runtime.IsVehicleAuraContainerBlocked() then
        ReplaceDefinitions(container, newDefinitions)
        SuspendContainerControllers(container)
        RebuildDefinitions()
        SyncPreviews(container, newDefinitions)
        container.layoutSignature = nil
        ns.BuffSounds:Sync(definitions)
        ns.BuffSounds:RebuildCustomSoundCache()
        self:UpdateContainerPreviews(container)
        return
    end
    SyncGroups(container, newDefinitions)
    RebuildDefinitions()
    SyncPreviews(container, newDefinitions)
    container.layoutSignature = nil
    self:ApplyGroupLayout(container)
    ns.BuffSounds:Sync(definitions)
    ns.BuffSounds:RebuildCustomSoundCache()
    self:UpdateContainerPreviews(container)
end

function CustomAuraProvider:DisableContainer(container)
    container.pendingDefinitions = nil
    container.layoutSignature = nil
    if not activeContainers[container] then
        return
    end
    activeContainers[container] = nil
    for stableKey, controller in pairs(container.entryControllers or {}) do
        if container.groupKeys and container.groupKeys[stableKey] then
            controller:SetAuraGroupFilterString(stableKey, "")
        end
        controller:SetEnabled(false)
        controller:Hide()
    end
    RebuildDefinitions()
    ns.BuffSounds:RebuildCustomSoundCache()
end

function CustomAuraProvider:SetEnabled(enabled)
    if not enabled then
        for container in pairs(activeContainers) do
            self:DisableContainer(container)
        end
    end
end

function CustomAuraProvider:IsContainerActive(container)
    return activeContainers[container] == true
end

function CustomAuraProvider:RefreshStyles()
    if not IsCustomAuraFeatureAvailable() then
        return
    end
    if InCombatLockdown() then
        Runtime:DeferInCombat(function()
            CustomAuraProvider:RefreshStyles()
        end)
        return
    end
    -- Existing AuraButtons are access-constrained after initializeFrame;
    -- settings apply to newly created buttons, while container layout remains
    -- live through the public controller API.
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ icons = true })
    end
end

function CustomAuraProvider:UpdateAllPreviews()
    for container in pairs(activeContainers) do
        self:UpdateContainerPreviews(container)
    end
end

if EditModeManagerFrame then
    hooksecurefunc(EditModeManagerFrame, "Show", function()
        CustomAuraProvider:UpdateAllPreviews()
    end)
    hooksecurefunc(EditModeManagerFrame, "Hide", function()
        CustomAuraProvider:UpdateAllPreviews()
    end)
end

EventRegistry:RegisterCallback("CooldownViewerSettings.OnShow", function()
    CustomAuraProvider:UpdateAllPreviews()
end)

EventRegistry:RegisterCallback("CooldownViewerSettings.OnHide", function()
    CustomAuraProvider:UpdateAllPreviews()
end)

-- Custom containers only need the CMC-owned chain host re-wrapped when auras
-- change. Blizzard's AuraContainer updates its own frames on UNIT_AURA, and the
-- Blizzard CDM viewers are handled by their own Layout hooks, so no
-- CooldownManager.ForceRefresh is needed here. The short delay lets Blizzard's
-- flow layout finish its Show/Hide pass before the host is re-sized.
local function ResizeAllChainHosts()
    for container in pairs(activeContainers) do
        ResizeChainHost(container)
    end
end

local function RefreshVisibleAuraControllers()
    for container in pairs(activeContainers) do
        for stableKey, controller in pairs(container.entryControllers or {}) do
            local definition = (container.definitions or {})[stableKey]
            local auraType = definition and GetAuraType(definition)
            if auraType and IsAuraTypeBlocked(auraType) then
                Runtime:Deactivate(controller)
            elseif controller:IsEnabled() and controller:IsVisible() then
                controller:UpdateAllAuras()
            end
        end
    end
end

local function RefreshAuraContainers()
    local blocked = Runtime.IsVehicleAuraContainerBlocked()
    if blocked then
        local owners = {}
        for container in pairs(containersWithControllers) do
            owners[#owners + 1] = container
        end
        for _, container in ipairs(owners) do
            SuspendContainerControllers(container)
        end
        return
    end

    for container in pairs(activeContainers) do
        CustomAuraProvider:RefreshContainer(container, container.definitions)
        CustomAuraProvider:ApplyGroupLayout(container)
        CustomAuraProvider:ChainContainers(container)
        ResizeChainHost(container)
    end
end

Runtime:RegisterAuraRelationshipRefresh(RefreshAuraContainers)
local playerLayoutRefreshQueued = false
local function QueuePlayerLayoutRefresh()
    if playerLayoutRefreshQueued or not next(activeContainers) then
        return
    end
    playerLayoutRefreshQueued = true
    ResizeAllChainHosts()
    C_Timer.After(0, ResizeAllChainHosts)
    C_Timer.NewTicker(0.01, ResizeAllChainHosts, 2)
    C_Timer.After(0.02, function()
        playerLayoutRefreshQueued = false
    end)
end

local playerLayoutRefresh = CreateFrame("Frame")
playerLayoutRefresh:RegisterUnitEvent("UNIT_AURA", "player")
playerLayoutRefresh:RegisterUnitEvent("UNIT_FACTION", "player")
playerLayoutRefresh:RegisterUnitEvent("UNIT_FLAGS", "player")
playerLayoutRefresh:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "player")
local playerRelationshipRefreshPending = false
playerLayoutRefresh:SetScript("OnEvent", function(self, eventName)
    if eventName ~= "UNIT_AURA" then
        if playerRelationshipRefreshPending then
            return
        end
        playerRelationshipRefreshPending = true
        self:SetScript("OnUpdate", function(refreshFrame)
            refreshFrame:SetScript("OnUpdate", nil)
            playerRelationshipRefreshPending = false
            RefreshVisibleAuraControllers()
            QueuePlayerLayoutRefresh()
        end)
        return
    end
    QueuePlayerLayoutRefresh()
end)

-- AuraContainer does not clear target aura state on its own when the target changes,
-- and a hidden 0-sized container may never process its removal dirty phase. Re-scan
-- target controllers on PLAYER_TARGET_CHANGED / UNIT_AURA(target). The re-scan
-- only marks the containers dirty; Blizzard runs the actual rebuild in its own
-- next OnUpdate pass, so the host is re-wrapped one frame later.
local targetLayoutRefreshQueued = false
local targetLayoutRefresh = CreateFrame("Frame")
targetLayoutRefresh:RegisterUnitEvent("UNIT_AURA", "target")
targetLayoutRefresh:RegisterUnitEvent("UNIT_FACTION", "target")
targetLayoutRefresh:RegisterUnitEvent("UNIT_FLAGS", "target")
targetLayoutRefresh:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "target")
targetLayoutRefresh:RegisterEvent("PLAYER_TARGET_CHANGED")
targetLayoutRefresh:SetScript("OnEvent", function(_, event)
    local function refreshTargetAuras()
        for container in pairs(activeContainers) do
            for stableKey, controller in pairs(container.entryControllers or {}) do
                if (container.entryUnits or {})[stableKey] == "target" then
                    local definition = (container.definitions or {})[stableKey]
                    local auraType = definition and GetAuraType(definition)
                    if auraType and IsAuraTypeBlocked(auraType) then
                        Runtime:Deactivate(controller)
                    elseif controller:IsEnabled() and controller:IsVisible() then
                        controller:UpdateAllAuras()
                    end
                end
            end
        end
        ResizeAllChainHosts()
    end
    -- Losing/retargeting must clear stale debuffs immediately (next frame);
    -- UNIT_AURA on the current target still waits for Blizzard's Show/Hide pass.
    if event == "PLAYER_TARGET_CHANGED" then
        refreshTargetAuras()
    end
    if targetLayoutRefreshQueued or not next(activeContainers) then
        return
    end
    targetLayoutRefreshQueued = true
    refreshTargetAuras()
    C_Timer.NewTicker(0.03, refreshTargetAuras, 2)
    C_Timer.After(0.06, function()
        targetLayoutRefreshQueued = false
    end)
end)
