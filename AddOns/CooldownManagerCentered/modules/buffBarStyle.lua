local _, ns = ...

local BuffBarStyle = {}
ns.BuffBarStyle = BuffBarStyle

local LSM = LibStub("LibSharedMedia-3.0")
local Pixel = ns.PixelPerfect
local SQUARE_TEXTURE = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square"
local SOLID_TEXTURE = "Interface\\Buttons\\WHITE8x8"
local DEFAULT_BAR_ATLAS = "UI-HUD-CoolDownManager-Bar"
local DEFAULT_BAR_HEIGHT = 19
local hooked

local function SetIconPosition(item, swapped)
    local iconFrame = item.Icon
    local bar = item.Bar
    local itemSurface = Pixel.SyncContainer(item)
    local iconShown = BuffBarCooldownViewer.barContent ~= Enum.CooldownViewerBarContent.NameOnly
    local iconGap = Pixel.SizeFromPixels(bar, 2)
    iconFrame:ClearAllPoints()
    bar:ClearAllPoints()

    if swapped then
        Pixel.SetPoint(iconFrame, "RIGHT", itemSurface, "RIGHT", 0, 0)
        Pixel.SetPoint(bar, "LEFT", itemSurface, "LEFT", 0, 0)
        if iconShown then
            Pixel.SetPoint(bar, "RIGHT", iconFrame, "LEFT", -iconGap, 0)
        else
            Pixel.SetPoint(bar, "RIGHT", itemSurface, "RIGHT", 0, 0)
        end
        item._cmcBuffBarIconPositionSwapped = true
    else
        Pixel.SetPoint(iconFrame, "LEFT", itemSurface, "LEFT", 0, 0)
        if iconShown then
            Pixel.SetPoint(bar, "LEFT", iconFrame, "RIGHT", iconGap, 0)
        else
            Pixel.SetPoint(bar, "LEFT", itemSurface, "LEFT", 0, 0)
        end
        Pixel.SetPoint(bar, "RIGHT", itemSurface, "RIGHT", 0, 0)
        item._cmcBuffBarIconPositionSwapped = nil
    end
end

local function PrepareSurfaces(item)
    local itemWidth, itemHeight = ns.API:GetSafeSize(item)
    if itemWidth and itemHeight then
        Pixel.SetSize(item, itemWidth, itemHeight, 1, 1)
        Pixel.SyncContainer(item)
    end
    local iconWidth, iconHeight = item.Icon:GetSize()
    if iconWidth and iconHeight and iconWidth > 0 and iconHeight > 0 then
        Pixel.SetSize(item.Icon, iconWidth, iconHeight, 1, 1)
        local iconSurface = Pixel.SyncContainer(item.Icon)
        if item.Icon.Icon then
            item.Icon.Icon:ClearAllPoints()
            item.Icon.Icon:SetAllPoints(iconSurface)
            Pixel.ApplyTexturePixelSnapping(item.Icon.Icon)
        end
    end
    Pixel.SyncContainer(item.Bar)
end

local function SetBorder(frame, anchor, thickness)
    local surface = Pixel.SyncContainer(anchor)
    frame:SetFrameLevel(anchor:GetFrameLevel() + 1)
    ns.API:ApplyPixelBorder(frame, surface, thickness)
end

local function SetBarHeight(item, higher)
    if higher then
        Pixel.SetHeight(item.Bar, item.Icon:GetHeight(), 1)
        item._cmcBuffBarHigher = true
    elseif item._cmcBuffBarHigher then
        Pixel.SetHeight(item.Bar, DEFAULT_BAR_HEIGHT, 1)
        item._cmcBuffBarHigher = nil
    else
        Pixel.SetHeight(item.Bar, item.Bar:GetHeight(), 1)
    end
end

local function SetSquareStyle(item, enabled)
    local iconFrame = item.Icon
    local bar = item.Bar
    local iconWidth, iconHeight = iconFrame:GetSize()
    Pixel.SetSize(iconFrame, iconWidth, iconHeight, 1, 1)
    local iconSurface = Pixel.SyncContainer(iconFrame)
    Pixel.SyncContainer(bar)
    if iconFrame.Icon then
        iconFrame.Icon:ClearAllPoints()
        iconFrame.Icon:SetAllPoints(iconSurface)
        Pixel.ApplyTexturePixelSnapping(iconFrame.Icon)
    end

    for _, region in ipairs({ iconFrame:GetRegions() }) do
        if region:IsObjectType("MaskTexture") then
            if enabled then
                region:SetTexture(SQUARE_TEXTURE)
            else
                region:SetAtlas("UI-HUD-CoolDownManager-Mask")
            end
        elseif region:IsObjectType("Texture") and region:GetAtlas() == "UI-HUD-CoolDownManager-IconOverlay" then
            region:SetShown(not enabled)
        end
    end

    local zoom = enabled and ns.db.profile.cooldownManager_squareIconsZoom_BuffBar or 0
    local crop = zoom * 0.5
    iconFrame.Icon:SetTexCoord(crop, 1 - crop, crop, 1 - crop)
    item.DebuffBorder:SetAlpha(enabled and 0 or 1)

    if enabled then
        bar.BarBG:ClearAllPoints()
        bar.BarBG:SetAllPoints(Pixel.SyncContainer(bar))
        bar.BarBG:SetColorTexture(0, 0, 0, 0.5)
        Pixel.ApplyTexturePixelSnapping(bar.BarBG)
        bar.Pip:Hide()

        item._cmcBuffBarIconBorder = item._cmcBuffBarIconBorder
            or CreateFrame("Frame", nil, item)
        item._cmcBuffBarBorder = item._cmcBuffBarBorder or CreateFrame("Frame", nil, item)
        SetBorder(item._cmcBuffBarIconBorder, iconFrame, ns.db.profile.cooldownManager_squareIconsBorder_BuffBar)
        SetBorder(item._cmcBuffBarBorder, bar, ns.db.profile.cooldownManager_buffBarBorder)
    else
        bar.BarBG:ClearAllPoints()
        Pixel.SetPoint(bar.BarBG, "TOPLEFT", bar, "TOPLEFT", -2, 2)
        Pixel.SetPoint(bar.BarBG, "BOTTOMRIGHT", bar, "BOTTOMRIGHT", 4, -7)
        bar.BarBG:SetAtlas("UI-HUD-CoolDownManager-Bar-BG")
        Pixel.ApplyTexturePixelSnapping(bar.BarBG)
        bar.Pip:Show()
        if item._cmcBuffBarIconBorder then
            item._cmcBuffBarIconBorder:Hide()
            item._cmcBuffBarBorder:Hide()
        end
    end
end

local function SetTexture(item, square)
    local textureName = ns.db.profile.cooldownManager_buffBarTexture
    local texture = textureName ~= "NIL" and LSM:Fetch(LSM.MediaType.STATUSBAR, textureName) or nil
    local statusBarTexture = item.Bar:GetStatusBarTexture()
    if texture then
        statusBarTexture:SetTexture(texture)
        item._cmcBuffBarTextureStyled = true
    elseif square then
        statusBarTexture:SetTexture(SOLID_TEXTURE)
        item._cmcBuffBarTextureStyled = true
    elseif item._cmcBuffBarTextureStyled then
        statusBarTexture:SetAtlas(DEFAULT_BAR_ATLAS)
        item._cmcBuffBarTextureStyled = nil
    end
    Pixel.ApplyStatusBarTexturePixelSnapping(item.Bar)
end

local function SetFont(item)
    local bar = item.Bar
    if ns.db.profile.cooldownManager_buffBarFontEnabled then
        local font = ns.API:GetFontPath(ns.db.profile.cooldownManager_buffBarFontName) or NumberFontNormal:GetFont()
        local size = ns.db.profile.cooldownManager_buffBarFontSize
        local flags = ns.API:GetFontFlags(ns.db.profile.cooldownManager_buffBarFontFlags)
        bar.Name:SetFont(font, size, flags)
        bar.Duration:SetFont(font, size, flags)
        item._cmcBuffBarFontStyled = true
    elseif item._cmcBuffBarFontStyled then
        bar.Name:SetFontObject(NumberFontNormal)
        bar.Duration:SetFontObject(NumberFontNormal)
        item._cmcBuffBarFontStyled = nil
    end
end

function BuffBarStyle:Apply(item)
    local square = ns.db.profile.cooldownManager_squareIcons_BuffBar
    PrepareSurfaces(item)
    SetIconPosition(item, ns.db.profile.cooldownManager_buffBarSwapIconPosition)
    SetBarHeight(item, ns.db.profile.cooldownManager_buffBarHigherBars)
    if square then
        SetSquareStyle(item, true)
        item._cmcBuffBarSquareStyled = true
    elseif item._cmcBuffBarSquareStyled then
        SetSquareStyle(item, false)
        item._cmcBuffBarSquareStyled = nil
    end
    SetTexture(item, square)
    SetFont(item)
end

function BuffBarStyle:RefreshAll()
    for _, item in ipairs(ns.API:GetViewerItemFrames(BuffBarCooldownViewer)) do
        self:Apply(item)
    end
end

function BuffBarStyle:Initialize()
    if not hooked then
        hooked = true
        hooksecurefunc(BuffBarCooldownViewer, "Layout", function()
            BuffBarStyle:RefreshAll()
        end)
        hooksecurefunc(CooldownViewerBuffBarItemMixin, "SetBarContent", function(item)
            BuffBarStyle:Apply(item)
        end)
    end
    self:RefreshAll()
end
