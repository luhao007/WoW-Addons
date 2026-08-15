local _, ns = ...
local Affected = ns.API.Affected
local Pixel = ns.PixelPerfect

local StyledIcons = {}
ns.StyledIcons = StyledIcons

local isModuleStyledEnabled = false

local BASE_SQUARE_MASK = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square"

local viewersSettingKey = {
    EssentialCooldownViewer = "Essential",
    UtilityCooldownViewer = "Utility",
    BuffIconCooldownViewer = "BuffIcons",
}

-- Icon sizes (and their normalize / rectangular variants) live in ns.Sizes so glows
-- and highlights size off the same known numbers; see core/sizes.lua.
local GetViewerIconSize = ns.Sizes.GetViewerIconSize
local IsNormalizedSizeEnabled = ns.Sizes.IsNormalizedSizeEnabled

-- Returns TOPLEFT and BOTTOMRIGHT offsets for UI-HUD-CoolDownManager-IconOverlay
-- Blizzard_CooldownViewer/CooldownViewer.xml (per-template, keyed to the native frame
-- size): Essential 50x50 -> (-9, 8); Utility 30x30 -> (-6, 5); BuffIcons 40x40 ->
-- (-8, 7). Normalized Utility is resized to 50x50, so it reuses the Essential insets.
-- Y offsets are scaled by height/width so the overlay stays proportional on squashed icons.
local function GetOverlayAnchors(viewerSettingName, width, height)
    local ratio = (width and height and width > 0) and (height / width) or 1.0
    local tlx, tly, brx, bry
    if viewerSettingName == "Essential" then
        tlx, tly, brx, bry = -9, 8, 9, -8
    elseif viewerSettingName == "Utility" then
        if IsNormalizedSizeEnabled() then
            tlx, tly, brx, bry = -9, 8, 9, -8
        else
            tlx, tly, brx, bry = -6, 5, 6, -5
        end
    elseif viewerSettingName == "BuffIcons" then
        tlx, tly, brx, bry = -8, 7, 8, -7
    else
        tlx, tly, brx, bry = -9, 8, 9, -8
    end
    tly = tly * ratio
    bry = bry * ratio
    return tlx, tly, brx, bry
end

local function IsAnyStyledFeatureEnabled()
    if not ns.db or not ns.db.profile then
        return false
    end
    for _, viewerSettingName in pairs(viewersSettingKey) do
        local squareKey = "cooldownManager_squareIcons_" .. viewerSettingName
        if ns.db.profile[squareKey] then
            return true
        end
    end
    if ns.db.profile.cooldownManager_normalizeUtilitySize then
        return true
    end

    if
        ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential
        or ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility
        or ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons
    then
        return true
    end

    return false
end
function StyledIcons:IsAnyStyledFeatureEnabled()
    return IsAnyStyledFeatureEnabled()
end

local function ApplySquareStyle(button, viewerSettingName)
    local width, height = GetViewerIconSize(viewerSettingName)

    local borderKey = "cooldownManager_squareIconsBorder_" .. viewerSettingName
    local borderPixels = ns.db.profile[borderKey] or 0

    Pixel.SetSize(button, width, height, 1, 1)
    local surface = Pixel.SyncContainer(button)
    local borderThickness = borderPixels > 0 and Pixel.SizeFromPixels(surface, borderPixels, 1) or 0

    local widthToHeightRatio = width / height
    if button.Icon then
        button.Icon:ClearAllPoints()
        button.Icon:SetAllPoints(surface)
        Pixel.ApplyTexturePixelSnapping(button.Icon)

        local zoom = 0
        if ns.db and ns.db.profile then
            local zoomKey = "cooldownManager_squareIconsZoom_" .. viewerSettingName
            zoom = ns.db.profile[zoomKey] or 0
        end
        local crop = zoom * 0.5
        if button.Icon.SetTexCoord then
            if widthToHeightRatio > 1 then
                local horizontalSpan = 1 - (2 * crop)
                local verticalSpan = horizontalSpan / widthToHeightRatio
                -- Keep UV span within valid [0, 1] range before centering the crop.
                local clampedVerticalSpan = math.max(0, math.min(1, verticalSpan))
                local verticalCrop = (1 - clampedVerticalSpan) * 0.5
                button.Icon:SetTexCoord(crop, 1 - crop, verticalCrop, 1 - verticalCrop)
            else
                -- todo, someday do "letterboxing" for portrait icons instead of just cropping them as squares
                button.Icon:SetTexCoord(crop, 1 - crop, crop, 1 - crop)
            end
        end
    end
    if button.Cooldown then
        button.Cooldown:SetSwipeTexture(BASE_SQUARE_MASK)
        button.Cooldown:ClearAllPoints()
        button.Cooldown:SetPoint("TOPLEFT", surface, "TOPLEFT", borderThickness, -borderThickness)
        button.Cooldown:SetPoint("BOTTOMRIGHT", surface, "BOTTOMRIGHT", -borderThickness, borderThickness)
    end
    for _, region in next, { button:GetRegions() } do
        if region:IsObjectType("Texture") then
            local texture = region:GetTexture()
            local atlas = region:GetAtlas()

            if (issecretvalue and not issecretvalue(texture) or not issecretvalue) and texture == 6707800 then
                region:SetTexture(BASE_SQUARE_MASK)
                region.__wt_set6707800 = true
            elseif atlas == "UI-HUD-CoolDownManager-IconOverlay" then
                region:SetAlpha(0) -- 6704514
            end
        end
    end
    -- There should be one region left that isn't mapped

    if not Affected(button).border then
        Affected(button).border = CreateFrame("Frame", nil, button)
        Affected(button).border:SetFrameLevel(button:GetFrameLevel() + 1)
    end
    if borderPixels <= 0 then
        ns.API:HidePixelBorder(Affected(button).border)
        ns.API:SetAffected(button, "squareStyled")
        return
    end
    ns.API:ApplyPixelBorder(Affected(button).border, surface, borderPixels)

    ns.API:SetAffected(button, "squareStyled")
end

local function RestoreOriginalStyle(button, viewerSettingName)
    local width, height = GetViewerIconSize(viewerSettingName)
    Pixel.SetSize(button, width, height, 1, 1)
    local surface = Pixel.SyncContainer(button)

    if button.Icon then
        button.Icon:ClearAllPoints()
        button.Icon:SetAllPoints(surface)
        button.Icon:SetTexCoord(0, 1, 0, 1)
        Pixel.ApplyTexturePixelSnapping(button.Icon)
    end

    for _, region in next, { button:GetRegions() } do
        if region:IsObjectType("Texture") then
            local atlas = region:GetAtlas()

            if region.__wt_set6707800 then
                region:SetAtlas("UI-HUD-CoolDownManager-Mask")
                region.__wt_set6707800 = nil
            elseif atlas == "UI-HUD-CoolDownManager-IconOverlay" then
                region:SetAlpha(1) -- 6704514
                local tlx, tly, brx, bry = GetOverlayAnchors(viewerSettingName, width, height)
                region:ClearAllPoints()
                region:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", tlx, tly)
                region:SetPoint("BOTTOMRIGHT", button.Icon, "BOTTOMRIGHT", brx, bry)
            end
        end
    end

    if button.Cooldown then
        button.Cooldown:SetSwipeTexture("Interface\\HUD\\UI-HUD-CoolDownManager-Icon-Swipe")
        button.Cooldown:ClearAllPoints()
        button.Cooldown:SetAllPoints(surface)
    end

    if Affected(button).border then
        Affected(button).border:Hide()
    end

    ns.API:UnsetAffected(button, "squareStyled")
end
local function ApplyNormalizedSizeToButton(button, viewerSettingName)
    local width, height = GetViewerIconSize(viewerSettingName)
    Pixel.SetSize(button, width, height, 1, 1)
    local surface = Pixel.SyncContainer(button)

    for i = 1, select("#", button:GetRegions()) do
        local region = select(i, button:GetRegions())
        if region.GetAtlas and region:GetAtlas() == "UI-HUD-CoolDownManager-IconOverlay" then
            local tlx, tly, brx, bry = GetOverlayAnchors(viewerSettingName, width, height)
            region:ClearAllPoints()
            region:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", tlx, tly)
            region:SetPoint("BOTTOMRIGHT", button.Icon, "BOTTOMRIGHT", brx, bry)
        end
    end

    if button.Icon then
        button.Icon:ClearAllPoints()
        button.Icon:SetPoint("LEFT", surface, "LEFT", 0, 0)

        local padding = ns.API:GetIsAffected(button, "squareStyled") and 4 or 0
        Pixel.SetSize(button.Icon, width - padding, height - padding, 1, 1)
        Pixel.ApplyTexturePixelSnapping(button.Icon)
    end
end

local function ApplySizeWithoutStyle(button, viewerSettingName)
    local width, height = GetViewerIconSize(viewerSettingName)

    if math.abs(width - height) >= 1 then
        RestoreOriginalStyle(button, viewerSettingName)
        ns.API:SetAffected(button, "rectangularStyled")
        return
    end
    if ns.API:GetIsAffected(button, "rectangularStyled") then
        RestoreOriginalStyle(button, viewerSettingName)
        ns.API:UnsetAffected(button, "rectangularStyled")
        return
    end
end

local function ProcessViewer(viewer, viewerSettingName, applySquareStyle)
    if not viewer or not IsAnyStyledFeatureEnabled() then
        return
    end
    local normalize = (viewerSettingName == "Utility")

    local children = ns.API:GetViewerItemFrames(viewer)
    for _, child in ipairs(children) do
        if child.Icon then -- Only process icon-like children
            ns.Sizes.TagViewerChild(child, viewerSettingName)
            if normalize then
                ApplyNormalizedSizeToButton(child, viewerSettingName)
            end

            if applySquareStyle then
                ApplySquareStyle(child, viewerSettingName)
            else
                ApplySizeWithoutStyle(child, viewerSettingName)
            end
            if child.TriggerPandemicAlert and not ns.API:GetIsAffected(child, "pandemicStyleHooked") then
                ns.API:SetAffected(child, "pandemicStyleHooked")
                hooksecurefunc(child, "TriggerPandemicAlert", function()
                    if child.PandemicIcon then
                        if applySquareStyle then
                            child.PandemicIcon:SetScale(1.38) -- magic numbers - TODO fix someday (DebuffBorder/2 +X) where X =0.03
                        else
                            child.PandemicIcon:SetScale(1.0)
                        end
                    end
                    C_Timer.After(0, function()
                        if child.PandemicIcon then
                            if applySquareStyle then
                                child.PandemicIcon:SetScale(1.38) -- magic numbers - TODO fix someday (DebuffBorder/2 +X) where X =0.03
                            else
                                child.PandemicIcon:SetScale(1.0)
                            end
                        end
                    end)
                end)
            end
            if child.DebuffBorder then
                if applySquareStyle then
                    -- TODO replace with libbuttonGlows
                    child.DebuffBorder:SetAlpha(0) -- hide the default border, since it doesn't scale well
                else
                    child.DebuffBorder:SetAlpha(1)
                    child.DebuffBorder:SetScale(1.0)
                end
            end
        end
    end
    -- Track per-viewer state so Initialize can compare desired vs current
    ns.API:SetAffected(viewer, "styledEnabled", applySquareStyle)
    if normalize then
        ns.API:SetAffected(viewer, "styledNormalized", IsNormalizedSizeEnabled())
    end
    local rectKeyMap = { Essential = "essential", Utility = "utility", BuffIcons = "buffIcons" }
    local rectSuffix = rectKeyMap[viewerSettingName]
    ns.API:SetAffected(
        viewer,
        "styledRectangular",
        rectSuffix and (ns.db.profile["cooldownManager_experimental_enableRectangularIcons_" .. rectSuffix] or false)
            or false
    )
end

local function IsAnyStyledFeatureEnabledForViewer(viewerSettingName)
    if not ns.db or not ns.db.profile then
        return false
    end
    if ns.db.profile["cooldownManager_squareIcons_" .. viewerSettingName] then
        return true
    end
    if viewerSettingName == "Utility" and ns.db.profile.cooldownManager_normalizeUtilitySize then
        return true
    end
    if
        viewerSettingName == "Essential"
        and ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential
    then
        return true
    end
    if viewerSettingName == "Utility" and ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility then
        return true
    end
    if
        viewerSettingName == "BuffIcons"
        and ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons
    then
        return true
    end
    return false
end

local function GetSettingKey(viewerSettingName)
    return "cooldownManager_squareIcons_" .. viewerSettingName
end

local function IsSquareIconsEnabled(viewerSettingName)
    if not ns.db or not ns.db.profile then
        return false
    end
    return ns.db.profile[GetSettingKey(viewerSettingName)] or false
end

function StyledIcons:RefreshViewer(viewerName)
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return
    end
    local viewerFrame = _G[viewerName]
    if not viewerFrame then
        return
    end

    local settingName = viewersSettingKey[viewerName]
    if not settingName then
        return
    end

    local enabled = IsSquareIconsEnabled(settingName)
    ProcessViewer(viewerFrame, settingName, enabled)
end

function StyledIcons:RefreshAll()
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return
    end
    for viewerName, settingName in pairs(viewersSettingKey) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            local enabled = IsSquareIconsEnabled(settingName)
            ProcessViewer(viewerFrame, settingName, enabled)
        end
    end
end

function StyledIcons:Enable()
    if isModuleStyledEnabled then
        return
    end

    isModuleStyledEnabled = true

    self:RefreshAll()
end

local function RestoreAllButtons()
    for viewerName, settingName in pairs(viewersSettingKey) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            local children = ns.API:GetViewerItemFrames(viewerFrame)
            for _, button in ipairs(children) do
                if button.Icon then
                    RestoreOriginalStyle(button, settingName)
                end
            end
            ns.API:UnsetAffected(viewerFrame, "styledEnabled")
            ns.API:UnsetAffected(viewerFrame, "styledNormalized")
            ns.API:UnsetAffected(viewerFrame, "styledRectangular")
        end
    end
end

function StyledIcons:Initialize()
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return
    end
    self:OnSettingChanged()
end

function StyledIcons:OnSettingChanged()
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return
    end
    local anyEnabled = IsAnyStyledFeatureEnabled()

    if not anyEnabled then
        if isModuleStyledEnabled then
            RestoreAllButtons()
            isModuleStyledEnabled = false
        end
        if ns.CooldownManager then
            ns.CooldownManager.ForceRefreshAll()
        end
        return
    end

    isModuleStyledEnabled = true

    -- Per-viewer: apply styling or explicitly restore viewers whose features are all now off
    for viewerName, settingName in pairs(viewersSettingKey) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            if IsAnyStyledFeatureEnabledForViewer(settingName) then
                ProcessViewer(viewerFrame, settingName, IsSquareIconsEnabled(settingName))
            elseif
                ns.API:GetIsAffected(viewerFrame, "styledEnabled")
                or ns.API:GetIsAffected(viewerFrame, "styledNormalized")
                or ns.API:GetIsAffected(viewerFrame, "styledRectangular")
            then
                -- This viewer had features active but they are all now disabled; restore it
                local children = ns.API:GetViewerItemFrames(viewerFrame)
                for _, button in ipairs(children) do
                    if button.Icon then
                        RestoreOriginalStyle(button, settingName)
                    end
                end
                ns.API:UnsetAffected(viewerFrame, "styledEnabled")
                ns.API:UnsetAffected(viewerFrame, "styledNormalized")
                ns.API:UnsetAffected(viewerFrame, "styledRectangular")
            end
        end
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefreshAll()
    end
end
