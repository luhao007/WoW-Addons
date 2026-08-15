local _, ns = ...
local L = ns.L

-- Buff icon/bar layout pipeline: collect -> sort -> place for Blizzard's buff
-- viewers. CooldownManager only decides WHEN to refresh; everything buffs do
-- lives here.
local BuffLayout = {}
ns.BuffLayout = BuffLayout

local Sizes = ns.Sizes
local Pixel = ns.PixelPerfect
local UpdateIcons

local function SortBuffFrames(frames, useCustomOrder)
    if useCustomOrder then
        ns.BuffData.SortCooldownFrames(frames)
    else
        table.sort(frames, Sizes.SortByLayoutIndex)
    end
end

local function AppendGroup(groups, index, value)
    local group = groups[index]
    if not group then
        group = {}
        groups[index] = group
    end
    group[#group + 1] = value
end

local function BuildSlotPixelOffsets(frames, region, sizePixels, paddingPixels, direction, panelEntries)
    local offsets = {}
    local stepPixels = sizePixels + paddingPixels
    local panelIndexByStableKey
    if panelEntries then
        panelIndexByStableKey = {}
        for panelIndex, entry in ipairs(panelEntries) do
            panelIndexByStableKey[entry.stableKey] = panelIndex
        end
    end
    for index, frame in ipairs(frames) do
        local slot = frame.layoutIndex or index
        if panelIndexByStableKey then
            local stableKey = ns.BuffData.GetStableKeyForCooldownID(frame:GetCooldownID())
            slot = panelIndexByStableKey[stableKey] or slot
        end
        offsets[index] = Pixel.SizeFromPixels(region, (slot - 1) * stepPixels * direction)
    end
    return offsets
end

local function CollectBuffIcons()
    local baseVisible, baseTotal = {}, 0
    local nativeTotal = 0
    local containerVisible, containerTotal = {}, {}
    local containerAssigned = {}
    if not BuffIconCooldownViewer then
        return baseVisible, baseTotal, containerVisible, containerTotal, nativeTotal
    end
    local buffsEnabled = ns.BuffData.IsEnabled()
    local children = BuffIconCooldownViewer:GetItemFrames()
    for _, child in ipairs(children) do
        if (child.icon or child.Icon) and child.layoutIndex ~= nil then
            nativeTotal = nativeTotal + 1
            ns.API.Affected(child).buffContainerSlot = nil
            if not ns.API:GetIsAffected(child, "buffLayoutHooked") then
                ns.API:SetAffected(child, "buffLayoutHooked")
                hooksecurefunc(child, "OnActiveStateChanged", UpdateIcons)
            end

            local containerIndex = nil
            if buffsEnabled then
                local cooldownID = child:GetCooldownID()
                containerIndex = ns.BuffData.GetContainerForCooldownID(cooldownID)
            end

            local isShown = child:IsShown()

            if containerIndex then
                containerTotal[containerIndex] = (containerTotal[containerIndex] or 0) + 1
                AppendGroup(containerAssigned, containerIndex, child)
                if isShown then
                    AppendGroup(containerVisible, containerIndex, child)
                end
            else
                baseTotal = baseTotal + 1
                if isShown then
                    baseVisible[#baseVisible + 1] = child
                end
            end
        end
    end

    SortBuffFrames(baseVisible, buffsEnabled)
    for _, assigned in pairs(containerAssigned) do
        SortBuffFrames(assigned, buffsEnabled)
        for slot, child in ipairs(assigned) do
            ns.API.Affected(child).buffContainerSlot = slot
        end
    end
    for _, group in pairs(containerVisible) do
        SortBuffFrames(group, buffsEnabled)
    end
    return baseVisible, baseTotal, containerVisible, containerTotal, nativeTotal
end

local function LayoutBaseBuffRow(icons, total, forceLayout, nativeTotal)
    local count = #icons
    if count == 0 then
        return
    end

    local refIcon = icons[1]
    local iconWidth = refIcon:GetWidth()
    local iconHeight = refIcon:GetHeight()
    if not iconWidth or iconWidth == 0 or not iconHeight or iconHeight == 0 then
        return
    end

    local isHorizontal = BuffIconCooldownViewer.isHorizontal ~= false
    local iconDirection = BuffIconCooldownViewer.iconDirection == 1 and "NORMAL" or "REVERSED"

    local alignment = ns.db.profile.cooldownManager_alignBuffIcons_growFromDirection or "CENTER"
    local preserveSlots = alignment == "Disable"
    local panelEntries
    if forceLayout then
        local defaultEntries = ns.BuffData.GetUnassignedBuffs()
        if nativeTotal ~= #defaultEntries then
            panelEntries = defaultEntries
        end
    end
    local paddingPixels = Pixel.Round(
        (isHorizontal and BuffIconCooldownViewer.childXPadding or BuffIconCooldownViewer.childYPadding) or 0
    )

    local iconScale = BuffIconCooldownViewer.iconScale or 1
    for _, icon in ipairs(icons) do
        icon:SetScale(iconScale)
        Pixel.SetSize(icon, iconWidth, iconHeight, 1, 1)
        Pixel.SyncContainer(icon)
        if icon.Icon then
            Pixel.ApplyTexturePixelSnapping(icon.Icon)
        end
    end
    local layoutRoot = Pixel.SyncContainer(BuffIconCooldownViewer) or BuffIconCooldownViewer
    local iconWidthPixels = Pixel.ToPixels(iconWidth, refIcon, 1)
    local iconHeightPixels = Pixel.ToPixels(iconHeight, refIcon, 1)

    if isHorizontal then
        local direction = iconDirection == "NORMAL" and 1 or -1
        local anchor = iconDirection == "NORMAL" and "TOPLEFT" or "TOPRIGHT"
        local offsets
        if alignment == "START" then
            offsets = Sizes.BuildPixelOffsets(refIcon, count, iconWidthPixels, paddingPixels, direction)
        elseif alignment == "END" then
            offsets = Sizes.BuildPixelOffsets(refIcon, count, iconWidthPixels, paddingPixels, -direction)
            anchor = iconDirection == "NORMAL" and "TOPRIGHT" or "TOPLEFT"
        elseif preserveSlots then
            offsets = BuildSlotPixelOffsets(icons, refIcon, iconWidthPixels, paddingPixels, direction, panelEntries)
        else
            local limit = forceLayout and count or total
            offsets = Sizes.BuildCenteredPixelOffsets(
                refIcon,
                count,
                iconWidthPixels,
                paddingPixels,
                direction,
                limit
            )
        end

        for i, icon in ipairs(icons) do
            icon:ClearAllPoints()
            Pixel.SetPoint(icon, anchor, layoutRoot, anchor, offsets[i], 0)
        end
    else
        local direction = iconDirection == "NORMAL" and -1 or 1
        local anchor = iconDirection == "NORMAL" and "BOTTOMLEFT" or "TOPLEFT"
        local offsets
        if alignment == "START" then
            offsets = Sizes.BuildPixelOffsets(refIcon, count, iconHeightPixels, paddingPixels, -direction)
        elseif alignment == "END" then
            offsets = Sizes.BuildPixelOffsets(refIcon, count, iconHeightPixels, paddingPixels, direction)
            anchor = iconDirection == "NORMAL" and "TOPLEFT" or "BOTTOMLEFT"
        elseif preserveSlots then
            offsets = BuildSlotPixelOffsets(icons, refIcon, iconHeightPixels, paddingPixels, -direction, panelEntries)
        else
            local limit = forceLayout and count or total
            offsets = Sizes.BuildCenteredPixelOffsets(
                refIcon,
                count,
                iconHeightPixels,
                paddingPixels,
                -direction,
                limit
            )
        end

        for i, icon in ipairs(icons) do
            icon:ClearAllPoints()
            Pixel.SetPoint(icon, anchor, layoutRoot, anchor, 0, offsets[i])
        end
    end

    local targetWidth, targetHeight
    local layoutSlots = alignment == "CENTER" and (forceLayout and count or total) or total
    if isHorizontal then
        targetWidth = Pixel.SizeFromPixels(
            BuffIconCooldownViewer,
            layoutSlots * iconWidthPixels + (layoutSlots - 1) * paddingPixels,
            1
        )
        targetHeight = Pixel.SizeFromPixels(BuffIconCooldownViewer, iconHeightPixels, 1)
    else
        targetWidth = Pixel.SizeFromPixels(BuffIconCooldownViewer, iconWidthPixels, 1)
        targetHeight = Pixel.SizeFromPixels(
            BuffIconCooldownViewer,
            layoutSlots * iconHeightPixels + (layoutSlots - 1) * paddingPixels,
            1
        )
    end
    local currentWidth = BuffIconCooldownViewer:GetWidth() or 0
    local currentHeight = BuffIconCooldownViewer:GetHeight() or 0
    if
        Pixel.ToPixels(currentWidth, BuffIconCooldownViewer) ~= Pixel.ToPixels(targetWidth, BuffIconCooldownViewer)
        or Pixel.ToPixels(currentHeight, BuffIconCooldownViewer) ~= Pixel.ToPixels(targetHeight, BuffIconCooldownViewer)
    then
        if ns.CooldownManager.CanSetNativeFrameSize(BuffIconCooldownViewer, "icons") then
            Pixel.SetSize(BuffIconCooldownViewer, targetWidth, targetHeight, 1, 1)
            Pixel.SyncContainer(BuffIconCooldownViewer)
        end
    end
end

local function CollectVisibleBuffBars()
    if not BuffBarCooldownViewer then
        return {}
    end

    local active = {}
    for _, frame in ipairs(BuffBarCooldownViewer:GetItemFrames()) do
        if frame:IsShown() and frame:IsVisible() then
            active[#active + 1] = frame
        end
        if not ns.API:GetIsAffected(frame, "buffLayoutHooked") and (frame.icon or frame.Icon or frame.bar or frame.Bar) then
            ns.API:SetAffected(frame, "buffLayoutHooked")
            hooksecurefunc(frame, "OnActiveStateChanged", BuffLayout.UpdateBars)
            hooksecurefunc(frame, "OnUnitAuraAddedEvent", BuffLayout.UpdateBars)
            hooksecurefunc(frame, "OnUnitAuraRemovedEvent", BuffLayout.UpdateBars)
        end
    end
    table.sort(active, Sizes.SortByLayoutIndex)
    return active
end

function BuffLayout:UpdateBars()
    if not ns.Runtime:IsReady(BuffBarCooldownViewer) then
        return
    end

    local bars = CollectVisibleBuffBars()
    if #bars == 0 then
        return
    end

    local growSetting = ns.db.profile.cooldownManager_alignBuffBars_growFromDirection
    local useBlizzardFlow = growSetting == "Disable"
    local horizontal = useBlizzardFlow and BuffBarCooldownViewer.isHorizontal
    local spacingPixels = Pixel.Round(
        (horizontal and BuffBarCooldownViewer.childXPadding or BuffBarCooldownViewer.childYPadding) or 0
    )
    for _, bar in ipairs(bars) do
        local width, height = ns.API:GetSafeSize(bar)
        if width and height then
            Pixel.SetSize(bar, width, height, 1, 1)
            Pixel.SyncContainer(bar)
        end
    end

    local barWidth, barHeight = bars[1]:GetSize()
    if not barWidth or barWidth == 0 or not barHeight or barHeight == 0 then
        return
    end
    local barWidthPixels = Pixel.ToPixels(barWidth, bars[1], 1)
    local barHeightPixels = Pixel.ToPixels(barHeight, bars[1], 1)

    local growFromBottom = growSetting == "BOTTOM"
    local layoutRoot = Pixel.SyncContainer(BuffBarCooldownViewer) or BuffBarCooldownViewer
    local growsRight = BuffBarCooldownViewer.layoutFramesGoingRight ~= false
    local growsUp = BuffBarCooldownViewer.layoutFramesGoingUp == true
    local gridAnchor = (growsUp and "BOTTOM" or "TOP") .. (growsRight and "LEFT" or "RIGHT")
    for index, bar in ipairs(bars) do
        local offsetIndex = index - 1
        bar:ClearAllPoints()
        if useBlizzardFlow and BuffBarCooldownViewer.isHorizontal then
            local x = Pixel.SizeFromPixels(
                bar,
                offsetIndex * (barWidthPixels + spacingPixels) * (growsRight and 1 or -1)
            )
            Pixel.SetPoint(bar, gridAnchor, layoutRoot, gridAnchor, x, 0)
        elseif useBlizzardFlow then
            local y = Pixel.SizeFromPixels(
                bar,
                offsetIndex * (barHeightPixels + spacingPixels) * (growsUp and 1 or -1)
            )
            Pixel.SetPoint(bar, gridAnchor, layoutRoot, gridAnchor, 0, y)
        elseif growFromBottom then
            local y = Pixel.SizeFromPixels(bar, offsetIndex * (barHeightPixels + spacingPixels))
            Pixel.SetPoint(bar, "BOTTOM", layoutRoot, "BOTTOM", 0, y)
        else
            local y = Pixel.SizeFromPixels(bar, -offsetIndex * (barHeightPixels + spacingPixels))
            Pixel.SetPoint(bar, "TOP", layoutRoot, "TOP", 0, y)
        end
    end

    local targetWidthPixels = horizontal and (#bars * barWidthPixels + (#bars - 1) * spacingPixels)
        or barWidthPixels
    local targetHeightPixels = horizontal and barHeightPixels
        or (#bars * barHeightPixels + (#bars - 1) * spacingPixels)
    local currentWidth, currentHeight = BuffBarCooldownViewer:GetSize()
    if
        Pixel.ToPixels(currentWidth, BuffBarCooldownViewer) ~= targetWidthPixels
        or Pixel.ToPixels(currentHeight, BuffBarCooldownViewer) ~= targetHeightPixels
    then
        if ns.CooldownManager.CanSetNativeFrameSize(BuffBarCooldownViewer, "bars") then
            Pixel.SetSize(
                BuffBarCooldownViewer,
                Pixel.SizeFromPixels(BuffBarCooldownViewer, targetWidthPixels, 1),
                Pixel.SizeFromPixels(BuffBarCooldownViewer, targetHeightPixels, 1),
                1,
                1
            )
            Pixel.SyncContainer(BuffBarCooldownViewer)
        end
    end
end

function BuffLayout:UpdateIcons()
    if not ns.Runtime:IsReady(BuffIconCooldownViewer) then
        return
    end
    local buffsEnabled = ns.BuffData.IsEnabled()
    local baseVisible, baseTotal, containerVisible, containerTotal, nativeTotal = CollectBuffIcons()

    if buffsEnabled then
        for i = 1, ns.BuffData.GetContainerCount() do
            local container = ns.BuffContainerViewer.containers[i]
            if container and container.active then
                if ns.BuffData.ContainerHasCustomAura(i) then
                    container:LayoutCustomAuras()
                else
                    container:LayoutIcons(containerVisible[i] or {}, containerTotal[i] or 0)
                end
            end
        end
    end

    if #baseVisible > 0 then
        LayoutBaseBuffRow(baseVisible, baseTotal, buffsEnabled, nativeTotal)
    end
end

UpdateIcons = BuffLayout.UpdateIcons
