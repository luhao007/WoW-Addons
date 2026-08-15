local _, ns = ...

local CooldownManager = {}
ns.CooldownManager = CooldownManager
local Pixel = ns.PixelPerfect

local UpdateCDViewer
local pendingSizeRefreshParts = {}
local protectedSizeRefreshFrame = CreateFrame("Frame")

local function QueueProtectedSizeRefresh(part)
    if not part then
        return
    end
    pendingSizeRefreshParts[part] = true
    protectedSizeRefreshFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
end

protectedSizeRefreshFrame:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")

    local parts = pendingSizeRefreshParts
    pendingSizeRefreshParts = {}
    CooldownManager.ForceRefresh(parts)
end)

local function CanSetNativeFrameSize(frame, refreshPart)
    if C_RestrictedActions.CheckAllowProtectedFunctions(frame, true) then
        return true
    end

    QueueProtectedSizeRefresh(refreshPart)
    return false
end

local function GetViewerSizeRefreshPart(viewer)
    if viewer == EssentialCooldownViewer then
        return "essential"
    elseif viewer == UtilityCooldownViewer then
        return "utility"
    elseif viewer == BuffIconCooldownViewer then
        return "icons"
    end
end

local weirdSpellsWithoutGCD = {
    [198793] = true, -- Vengeful Retreat
    [195072] = true, -- Fel Rush
    [232893] = true, -- Felblade
    [102401] = true, -- Wild Charge
    [106839] = true, -- Skull Bash
    [358267] = true, -- Hover
}

local function RestoreAlpha(viewer)
    for _, child in ipairs(viewer:GetItemFrames()) do
        if child.Icon then
            child:SetAlpha(1)
            local affected = ns.API.Affected(child)
            affected.utilityAppliedAlpha = nil
            affected.utilityCooldownActive = nil
        end
    end
end

local function WatchUtilityCooldownDone(child, affected)
    local cooldownFrame = child.Cooldown
    if not cooldownFrame or affected.utilityCooldownDoneFrame == cooldownFrame then
        return
    end

    affected.utilityCooldownDoneFrame = cooldownFrame
    cooldownFrame:HookScript("OnCooldownDone", function()
        C_Timer.After(0.1, function()
            CooldownManager.UpdateUtilityDimming()
        end)
    end)
end

local function ApplyUtilityAlphaState(child, affected, active, opacity)
    local stateChanged = affected.utilityCooldownActive ~= active
    affected.utilityCooldownActive = active
    local alpha = active and 1 or opacity
    if affected.utilityAppliedAlpha ~= alpha then
        affected.utilityAppliedAlpha = alpha
        child:SetAlpha(alpha)
    end
    return stateChanged
end

local function SetUtilityAlpha(child, opacity)
    if not child.cooldownID then
        return
    end

    local info = C_CooldownViewer.GetCooldownViewerCooldownInfo(child.cooldownID)
    if not info then
        return
    end

    local affected = ns.API.Affected(child)
    local spellID = info.overrideSpellID or info.spellID
    affected.utilityMoveToEnd = weirdSpellsWithoutGCD[info.spellID] == true

    if CooldownManager.IsUtilityActive(spellID) then
        WatchUtilityCooldownDone(child, affected)
        return ApplyUtilityAlphaState(child, affected, true, opacity)
    end
    return ApplyUtilityAlphaState(child, affected, false, opacity)
end

-- Shared "is this Utility icon treated as on cooldown" predicate. Mirrors the
-- native Utility dim logic (charging counts as active, GCD does not), so custom
-- tracker "Hide when ready" can behave 1:1 with Utility at 0% dim.
function CooldownManager.IsUtilityActive(spellID)
    if not spellID then
        return false
    end

    local charges = C_Spell.GetSpellCharges(spellID)
    if charges and charges.maxCharges > 1 and charges.isActive then
        return true
    end

    local cooldown = C_Spell.GetSpellCooldown(spellID)
    if not cooldown or cooldown.isOnGCD then
        return false
    end
    if not cooldown.isActive then
        return false
    end
    if cooldown.isOnGCD == nil and weirdSpellsWithoutGCD[spellID] then
        return false
    end
    return true
end

local function ShouldFilterUtilityLayout()
    if not ns.db.profile.cooldownManager_utility_dimWhenNotOnCD then
        return false
    end
    if (ns.db.profile.cooldownManager_utility_dimOpacity or 0) > 0 then
        return false
    end
    return not (ns.Runtime.isInEditMode or ns.Runtime.hasSettingsOpened)
end

local function GetUtilityRuntimeLayoutIndex(child)
    local affected = ns.API.Affected(child)
    return affected.utilitySortIndex or (child.layoutIndex or 0), affected.utilitySortMoved == true
end

local function SortUtilityRuntimeLayout(a, b)
    local aIndex, aMoved = GetUtilityRuntimeLayoutIndex(a)
    local bIndex, bMoved = GetUtilityRuntimeLayoutIndex(b)
    if aIndex ~= bIndex then
        return aIndex < bIndex
    end
    if aMoved ~= bMoved then
        return not aMoved
    end
    return (a.layoutIndex or 0) < (b.layoutIndex or 0)
end

local function UpdateUtilityDimming(forceLayout)
    local viewer = UtilityCooldownViewer
    if not viewer then
        return
    end
    if not ns.db.profile.cooldownManager_utility_dimWhenNotOnCD then
        if ns.API:GetIsAffected(viewer, "dimmed") then
            ns.API:UnsetAffected(viewer, "dimmed")
            RestoreAlpha(viewer)
        end
        return
    end

    local wasDimmed = ns.API:GetIsAffected(viewer, "dimmed")
    local forceVisible = ns.Runtime and (ns.Runtime.isInEditMode or ns.Runtime.hasSettingsOpened)
    local opacity = ns.db.profile.cooldownManager_utility_dimOpacity or 0
    local layoutChanged = false
    for _, child in ipairs(viewer:GetItemFrames()) do
        if child:IsShown() and child.Icon then
            if forceVisible then
                local affected = ns.API.Affected(child)
                if affected.utilityAppliedAlpha ~= 1 then
                    affected.utilityAppliedAlpha = 1
                    child:SetAlpha(1)
                end
            else
                layoutChanged = SetUtilityAlpha(child, opacity) or layoutChanged
            end
        end
    end
    ns.API:SetAffected(viewer, "dimmed")
    if ShouldFilterUtilityLayout() and (forceLayout or layoutChanged or not wasDimmed) then
        UpdateCDViewer(viewer, ns.db.profile.cooldownManager_centerUtility_growFromDirection)
    end
end

local utilityDimmingPending = false
local function RunUtilityDimming()
    utilityDimmingPending = false
    UpdateUtilityDimming()
end
local function RequestUtilityDimming()
    if utilityDimmingPending then
        return
    end
    utilityDimmingPending = true
    C_Timer.After(0.05, RunUtilityDimming)
end

local function CollectVisibleIcons(viewer)
    local visible = {}
    local filterInactiveUtility = viewer == UtilityCooldownViewer and ShouldFilterUtilityLayout()
    for _, child in ipairs(ns.API:GetViewerItemFrames(viewer)) do
        if filterInactiveUtility then
            local affected = ns.API.Affected(child)
            affected.utilitySortMoved = affected.utilityMoveToEnd == true
            affected.utilitySortIndex = (child.layoutIndex or 0) + (affected.utilitySortMoved and 50 or 0)
        end
        if
            child:IsShown()
            and child.Icon
            and child.layoutIndex
            and (not filterInactiveUtility or ns.API.Affected(child).utilityCooldownActive == true)
        then
            visible[#visible + 1] = child
        end
    end
    table.sort(visible, filterInactiveUtility and SortUtilityRuntimeLayout or ns.Sizes.SortByLayoutIndex)
    return visible
end

local function SnapIconFrame(icon)
    local width, height = ns.API:GetSafeSize(icon)
    if width and height then
        Pixel.SetSize(icon, width, height, 1, 1)
        Pixel.SyncContainer(icon)
    end
    if icon.Icon then
        Pixel.ApplyTexturePixelSnapping(icon.Icon)
    end
end

local function SetPointIfChanged(icon, layoutFrame, anchor, x, y)
    x = Pixel.Snap(x, icon)
    y = Pixel.Snap(y, icon)
    local point, relativeTo, relativePoint, oldX, oldY = icon:GetPoint()
    if
        point == anchor
        and relativeTo == layoutFrame
        and relativePoint == anchor
        and oldX
        and oldY
        and math.abs(x - oldX) < 0.001
        and math.abs(y - oldY) < 0.001
    then
        return
    end

    icon:ClearAllPoints()
    icon:SetPoint(anchor, layoutFrame, anchor, x, y)
end

local function PositionRowHorizontal(
    viewer,
    row,
    yOffset,
    widthPixels,
    paddingPixels,
    directionX,
    rowAnchor,
    iconLimit,
    centered
)
    local xOffsets = centered
            and ns.Sizes.BuildCenteredPixelOffsets(row[1], #row, widthPixels, paddingPixels, directionX, iconLimit)
        or ns.Sizes.BuildPixelOffsets(row[1], #row, widthPixels, paddingPixels, directionX)
    for i, icon in ipairs(row) do
        SetPointIfChanged(icon, viewer, rowAnchor, xOffsets[i], yOffset)
    end
end

local function PositionRowVertical(
    viewer,
    row,
    xOffset,
    heightPixels,
    paddingPixels,
    directionY,
    colAnchor,
    iconLimit,
    centered
)
    local yOffsets = centered
            and ns.Sizes.BuildCenteredPixelOffsets(row[1], #row, heightPixels, paddingPixels, directionY, iconLimit)
        or ns.Sizes.BuildPixelOffsets(row[1], #row, heightPixels, paddingPixels, directionY)
    for i, icon in ipairs(row) do
        SetPointIfChanged(icon, viewer, colAnchor, xOffset, yOffsets[i])
    end
end

local function UpdateViewerSizeIfChanged(viewer, children)
    children = children or CollectVisibleIcons(viewer)
    if #children == 0 then
        return
    end

    local top, right = -math.huge, -math.huge
    local bottom, left = math.huge, math.huge
    for _, child in ipairs(children) do
        local scale = child:GetEffectiveScale() / viewer:GetEffectiveScale()
        top = math.max(top, (child:GetTop() or 0) * scale)
        right = math.max(right, (child:GetRight() or 0) * scale)
        bottom = math.min(bottom, (child:GetBottom() or 0) * scale)
        left = math.min(left, (child:GetLeft() or 0) * scale)
    end

    local targetWidth = right - left
    local targetHeight = top - bottom
    local currentWidth = viewer:GetWidth(true)
    local currentHeight = viewer:GetHeight(true)
    if
        Pixel.ToPixels(currentWidth, viewer) ~= Pixel.ToPixels(targetWidth, viewer)
        or Pixel.ToPixels(currentHeight, viewer) ~= Pixel.ToPixels(targetHeight, viewer)
    then
        if not CanSetNativeFrameSize(viewer, GetViewerSizeRefreshPart(viewer)) then
            return
        end
        Pixel.SetSize(viewer, targetWidth, targetHeight, 1, 1)
        if viewer ~= EssentialCooldownViewer then
            Pixel.SyncContainer(viewer)
        end
        return true
    end
end

local function UpdateViewerSize(viewer, children)
    UpdateViewerSizeIfChanged(viewer, children)
end

local function UpdateEssential()
    UpdateCDViewer(EssentialCooldownViewer, ns.db.profile.cooldownManager_centerEssential_growFromDirection)
end

local function UpdateUtility()
    UpdateCDViewer(UtilityCooldownViewer, ns.db.profile.cooldownManager_centerUtility_growFromDirection)
    RequestUtilityDimming()
end

UpdateCDViewer = function(viewer, fromDirection, proxyRelayoutPass)
    if not ns.Runtime:IsReady(viewer) then
        return
    end

    local isHorizontal = viewer.isHorizontal ~= false
    local iconDirection = viewer.iconDirection == 1 and "NORMAL" or "REVERSED"
    local iconLimit = viewer.iconLimit or 0
    if iconLimit <= 0 then
        return
    end

    local children = CollectVisibleIcons(viewer)
    local useBlizzardFlow = fromDirection == "Disable"
    if #children == 0 then
        return
    end

    for _, child in ipairs(children) do
        SnapIconFrame(child)
    end

    local w, h = children[1]:GetWidth(), children[1]:GetHeight()
    if not w or w == 0 or not h or h == 0 then
        return
    end

    -- CDM stores padding as a pixel-facing Edit Mode value. Converting that value
    -- into the child's coordinate space keeps the rendered gap constant while
    -- iconScale continues to scale only the icon itself.
    local paddingPixels = Pixel.Round((isHorizontal and viewer.childXPadding or viewer.childYPadding) or 0)
    local widthPixels = Pixel.ToPixels(w, children[1], 1)
    local heightPixels = Pixel.ToPixels(h, children[1], 1)
    if
        viewer == UtilityCooldownViewer
        and not useBlizzardFlow
        and ns.db.profile.cooldownManager_limitUtilitySizeToEssential
        and isHorizontal
    then
        local essentialWidth = EssentialCooldownViewer and EssentialCooldownViewer:GetWidth()
        if essentialWidth and essentialWidth > 0 then
            local availablePixels = Pixel.ToPixels(essentialWidth, EssentialCooldownViewer)
            local stepPixels = widthPixels + paddingPixels
            if stepPixels > 0 then
                local maxIcons = math.floor((availablePixels + paddingPixels) / stepPixels)
                if maxIcons > 0 then
                    iconLimit = math.max(math.min(iconLimit, maxIcons), math.min(iconLimit, 6))
                end
            end
        end
    end

    local rows = ns.Sizes.BuildRows(children, iconLimit)
    local maxIcons = math.min(iconLimit, #children)
    local layoutFrame
    if viewer == EssentialCooldownViewer and ns.EssentialCustomTracker then
        local proxyDirection = fromDirection
        if useBlizzardFlow then
            if isHorizontal then
                proxyDirection = viewer.layoutFramesGoingUp and "BOTTOM" or "TOP"
            else
                proxyDirection = viewer.layoutFramesGoingRight == false and "BOTTOM" or "TOP"
            end
        end
        layoutFrame = ns.EssentialCustomTracker:PrepareLayoutFrame(isHorizontal, proxyDirection)
    else
        layoutFrame = Pixel.SyncContainer(viewer)
    end
    layoutFrame = layoutFrame or viewer
    if useBlizzardFlow then
        -- Mirror GridLayoutFrameMixin's native flow/anchor rules, but express the
        -- inter-cell padding in physical pixels instead of scaled UI units.
        local growsRight = viewer.layoutFramesGoingRight ~= false
        local growsUp = viewer.layoutFramesGoingUp == true
        local directionX = growsRight and 1 or -1
        local directionY = growsUp and 1 or -1
        local gridAnchor = (growsUp and "BOTTOM" or "TOP") .. (growsRight and "LEFT" or "RIGHT")
        for index, row in ipairs(rows) do
            if isHorizontal then
                local y = Pixel.SizeFromPixels(row[1], (index - 1) * (heightPixels + paddingPixels) * directionY)
                PositionRowHorizontal(
                    layoutFrame,
                    row,
                    y,
                    widthPixels,
                    paddingPixels,
                    directionX,
                    gridAnchor,
                    maxIcons,
                    false
                )
            else
                local x = Pixel.SizeFromPixels(row[1], (index - 1) * (widthPixels + paddingPixels) * directionX)
                PositionRowVertical(
                    layoutFrame,
                    row,
                    x,
                    heightPixels,
                    paddingPixels,
                    directionY,
                    gridAnchor,
                    maxIcons,
                    false
                )
            end
        end
    elseif isHorizontal then
        local growDirection = fromDirection == "BOTTOM" and 1 or -1
        local iconDirectionModifier = iconDirection == "NORMAL" and 1 or -1
        local rowAnchor = (fromDirection == "BOTTOM" and "BOTTOM" or "TOP")
            .. (iconDirection == "NORMAL" and "LEFT" or "RIGHT")
        for index, row in ipairs(rows) do
            local y = Pixel.SizeFromPixels(row[1], (index - 1) * (heightPixels + paddingPixels) * growDirection)
            PositionRowHorizontal(
                layoutFrame,
                row,
                y,
                widthPixels,
                paddingPixels,
                iconDirectionModifier,
                rowAnchor,
                maxIcons,
                true
            )
        end
    else
        local growDirection = fromDirection == "BOTTOM" and -1 or 1
        local directionY = iconDirection == "NORMAL" and 1 or -1
        local columnAnchor = (iconDirection == "NORMAL" and "BOTTOM" or "TOP")
            .. (fromDirection == "BOTTOM" and "RIGHT" or "LEFT")
        for index, row in ipairs(rows) do
            local x = Pixel.SizeFromPixels(row[1], (index - 1) * (widthPixels + paddingPixels) * growDirection)
            PositionRowVertical(
                layoutFrame,
                row,
                x,
                heightPixels,
                paddingPixels,
                directionY,
                columnAnchor,
                maxIcons,
                true
            )
        end
    end
    if viewer == EssentialCooldownViewer and ns.EssentialCustomTracker then
        local boundsFrame = ns.EssentialCustomTracker:GetLayoutHost() or layoutFrame
        local sizeChanged = UpdateViewerSizeIfChanged(boundsFrame, children)
        if sizeChanged and not proxyRelayoutPass then
            UpdateCDViewer(viewer, fromDirection, true)
        end
    elseif layoutFrame ~= viewer then
        local sizeChanged = UpdateViewerSizeIfChanged(viewer, children)
        if sizeChanged and not proxyRelayoutPass then
            Pixel.SyncContainer(viewer)
            UpdateCDViewer(viewer, fromDirection, true)
        end
    end
    UpdateViewerSize(viewer, children)
end

function CooldownManager.ForceRefresh(parts)
    parts = parts or { icons = true, bars = true, essential = true, utility = true }
    if parts.icons then
        ns.BuffLayout:UpdateIcons()
    end
    if parts.bars then
        ns.BuffLayout:UpdateBars()
    end
    if parts.essential then
        UpdateEssential()
    end
    if parts.utility then
        UpdateUtility()
    end
end

function CooldownManager.CanSetNativeFrameSize(frame, refreshPart)
    return CanSetNativeFrameSize(frame, refreshPart)
end

function CooldownManager.ForceRefreshAll()
    CooldownManager.ForceRefresh()
end

function CooldownManager.UpdateUtilityDimming(force)
    if force then
        UpdateUtilityDimming(true)
        return
    end
    RequestUtilityDimming()
end

function CooldownManager.RestoreUtilityAlpha()
    local viewer = UtilityCooldownViewer
    if viewer then
        RestoreAlpha(viewer)
    end
end

function CooldownManager.Initialize()
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.EnsureLayoutHost then
        ns.EssentialCustomTracker:EnsureLayoutHost()
    end
    for _, viewer in ipairs({ UtilityCooldownViewer, BuffIconCooldownViewer, BuffBarCooldownViewer }) do
        if viewer then
            Pixel.EnsureContainer(viewer)
        end
    end
    Pixel.RegisterRefreshCallback(CooldownManager, function()
        CooldownManager.ForceRefreshAll()
        if ns.StyledIcons then
            ns.StyledIcons:RefreshAll()
        end
        if ns.BuffBarStyle then
            ns.BuffBarStyle:RefreshAll()
        end
        if ns.TrackerItemViewer then
            ns.TrackerItemViewer:RefreshItemViewerFrames()
        end
    end)
    CooldownManager.ForceRefreshAll()
end
