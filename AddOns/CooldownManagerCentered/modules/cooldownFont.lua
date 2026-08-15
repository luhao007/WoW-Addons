local _, ns = ...

local CooldownFont = {}
ns.CooldownFont = CooldownFont

local Stacks = {}
ns.Stacks = Stacks

local viewersSettingKey = {
    EssentialCooldownViewer = "Essential",
    UtilityCooldownViewer = "Utility",
    BuffIconCooldownViewer = "BuffIcons",
}

local function RefreshCustomAuraStyles(viewerName)
    if
        (viewerName == nil or viewerName == "BuffIconCooldownViewer")
        and ns.CustomAuraProvider
        and ns.CustomAuraProvider.RefreshStyles
    then
        ns.CustomAuraProvider:RefreshStyles()
    end
end

ns.Stacks.defaultEssentialStackFont = ns.CONSTANTS.DEFAULT_NUMBER_FONT -- Essential Stacks
ns.Stacks.defaultUtilityAndBuffStackFont = { NumberFontNormalSmall:GetFont() } -- Utility Stacks and BuffIcon Stacks

-- Cooldown number font

local function GetViewerCooldownSettings(viewerName)
    local map = {
        EssentialCooldownViewer = {
            size = ns.db.profile.cooldownManager_cooldownFontSizeEssential,
            enabled = ns.db.profile.cooldownManager_cooldownFontSizeEssential_enabled,
        },
        UtilityCooldownViewer = {
            size = ns.db.profile.cooldownManager_cooldownFontSizeUtility,
            enabled = ns.db.profile.cooldownManager_cooldownFontSizeUtility_enabled,
        },
        BuffIconCooldownViewer = {
            size = ns.db.profile.cooldownManager_cooldownFontSizeBuffIcons,
            enabled = ns.db.profile.cooldownManager_cooldownFontSizeBuffIcons_enabled,
        },
    }
    local cfg = map[viewerName]
    if not cfg then
        return nil, false
    end
    return cfg.size, cfg.enabled
end

local function SetIconCooldownFont(icon, viewerName)
    if not icon.Cooldown.GetCountdownFontString then
        return
    end
    local fontString = icon.Cooldown:GetCountdownFontString()
    if not fontString then
        return
    end

    local size, enabled = GetViewerCooldownSettings(viewerName)

    if not enabled then
        if ns.API:GetIsAffected(icon, "cooldownfont") then
            if fontString.defaults then
                fontString:SetFont(unpack(fontString.defaults, 1, 3))
            end
            ns.API:UnsetAffected(icon, "cooldownfont")
        end
        return
    end

    if not fontString.defaults then
        local fp, fsz, ffl = fontString:GetFont()
        fontString.defaults = { fp, fsz, ffl or "" }
    end

    ns.API:SetAffected(icon, "cooldownfont")

    if size == 0 then
        fontString:SetFontHeight(0)
        return
    end

    if not size or size == "NIL" then
        size = fontString.defaults[2] or select(2, fontString:GetFont()) or 14 -- // its actually GameFontHighlightHugeOutline for essential (20) GameFontHighlightOutline (12) for utility, and default for anything else (14?)
    end

    local fontName = ns.db.profile.cooldownManager_cooldownFontName
    local fontPath = ns.API:GetFontPath(fontName) or fontString.defaults[1] or ns.CONSTANTS.DEFAULT_FONT[1]
    local fontFlags = ns.db.profile.cooldownManager_cooldownFontFlags
    fontString:SetFont(fontPath, size, ns.API:GetFontFlags(fontFlags))
end

-- Countdown text position offsets (separate per viewer). The countdown
-- FontString is centered on the Cooldown frame by default, so applying our
-- offset is just a re-anchor to CENTER with the configured X/Y. An offset of
-- 0/0 restores the default centered position.
local function GetViewerCooldownTextOffset(viewerName)
    local map = {
        EssentialCooldownViewer = {
            x = ns.db.profile.cooldownManager_cooldownTextEssential_offsetX,
            y = ns.db.profile.cooldownManager_cooldownTextEssential_offsetY,
        },
        UtilityCooldownViewer = {
            x = ns.db.profile.cooldownManager_cooldownTextUtility_offsetX,
            y = ns.db.profile.cooldownManager_cooldownTextUtility_offsetY,
        },
        BuffIconCooldownViewer = {
            x = ns.db.profile.cooldownManager_cooldownTextBuffIcons_offsetX,
            y = ns.db.profile.cooldownManager_cooldownTextBuffIcons_offsetY,
        },
    }
    local cfg = map[viewerName]
    if not cfg then
        return 0, 0
    end
    return cfg.x or 0, cfg.y or 0
end

local function SetIconCooldownTextOffset(icon, viewerName)
    if not icon.Cooldown or not icon.Cooldown.GetCountdownFontString then
        return
    end
    local fontString = icon.Cooldown:GetCountdownFontString()
    if not fontString then
        return
    end

    local _, enabled = GetViewerCooldownSettings(viewerName)
    local x, y = GetViewerCooldownTextOffset(viewerName)

    -- Only apply the offset when the viewer's font override is on. When it's off
    -- (or the offset is 0/0) restore the default centered position and stop
    -- overriding the position.
    if not enabled or (x == 0 and y == 0) then
        if ns.API:GetIsAffected(icon, "cooldowntextpos") then
            fontString:ClearAllPoints()
            fontString:SetPoint("CENTER", icon.Cooldown, "CENTER", 0, 0)
            ns.API:UnsetAffected(icon, "cooldowntextpos")
        end
        return
    end

    ns.API:SetAffected(icon, "cooldowntextpos")
    fontString:ClearAllPoints()
    fontString:SetPoint("CENTER", icon.Cooldown, "CENTER", x, y)
end
CooldownFont.SetIconCooldownTextOffset = SetIconCooldownTextOffset

local function ProcessCooldownFontViewer(viewerName)
    local viewer = _G[viewerName]
    if not viewer or not ns.Runtime:IsReady(viewerName) then
        return
    end
    local children = ns.API:GetViewerItemFrames(viewer)
    for _, child in ipairs(children) do
        if child.Icon and child.Cooldown then
            SetIconCooldownFont(child, viewerName)
            SetIconCooldownTextOffset(child, viewerName)
        end
    end
end

function CooldownFont:RefreshViewer(viewerName)
    ProcessCooldownFontViewer(viewerName)
    RefreshCustomAuraStyles(viewerName)
end

function CooldownFont:RefreshAll()
    for viewerName in pairs(viewersSettingKey) do
        ProcessCooldownFontViewer(viewerName)
    end
    RefreshCustomAuraStyles()
end

function CooldownFont:Initialize()
    self:RefreshAll()
end

-- Stack count font

local function GetViewerStackSettings(viewerName)
    local map = {
        EssentialCooldownViewer = {
            size = ns.db.profile.cooldownManager_stackFontSizeEssential,
            enabled = ns.db.profile.cooldownManager_stackAnchorEssential_enabled,
            point = ns.db.profile.cooldownManager_stackAnchorEssential_point,
            x = ns.db.profile.cooldownManager_stackAnchorEssential_offsetX,
            y = ns.db.profile.cooldownManager_stackAnchorEssential_offsetY,
        },
        UtilityCooldownViewer = {
            size = ns.db.profile.cooldownManager_stackFontSizeUtility,
            enabled = ns.db.profile.cooldownManager_stackAnchorUtility_enabled,
            point = ns.db.profile.cooldownManager_stackAnchorUtility_point,
            x = ns.db.profile.cooldownManager_stackAnchorUtility_offsetX,
            y = ns.db.profile.cooldownManager_stackAnchorUtility_offsetY,
        },
        BuffIconCooldownViewer = {
            size = ns.db.profile.cooldownManager_stackFontSizeBuffIcons,
            enabled = ns.db.profile.cooldownManager_stackAnchorBuffIcons_enabled,
            point = ns.db.profile.cooldownManager_stackAnchorBuffIcons_point,
            x = ns.db.profile.cooldownManager_stackAnchorBuffIcons_offsetX,
            y = ns.db.profile.cooldownManager_stackAnchorBuffIcons_offsetY,
        },
    }
    local cfg = map[viewerName]
    if not cfg then
        return nil, false, "BOTTOMRIGHT", 0, 0
    end
    return cfg.size, cfg.enabled, cfg.point, cfg.x, cfg.y
end

local function GetViewerStackDefaults(viewerName)
    return ns.CONSTANTS.FONT.DEFAULT_STACK_POINT,
        ns.CONSTANTS.FONT.DEFAULT_STACK_OFFSET_X,
        ns.CONSTANTS.FONT.DEFAULT_STACK_OFFSET_Y
end

local function ApplyStackFont(fontString, size, viewerName)
    if not fontString then
        return
    end
    if not fontString.defaults then
        local fp, fsz, ffl = fontString:GetFont()
        fontString.defaults = { fp, fsz, ffl or "" }
    end

    if size == 0 then
        fontString:SetFontHeight(0)
        return
    end
    if not size or size == "NIL" then
        size = fontString.defaults[2] or 14
    end

    local fontName = ns.db.profile.cooldownManager_stackFontName
    local fontPath = ns.API:GetFontPath(fontName) or fontString.defaults[1] or ns.CONSTANTS.DEFAULT_NUMBER_FONT[1]
    local fontFlags = ns.db.profile.cooldownManager_stackFontFlags
    fontString:SetFont(fontPath, size, ns.API:GetFontFlags(fontFlags))
end

local function GetStackFontString(frame)
    return frame and frame.Applications and frame.Applications.Applications
        or frame and frame.ChargeCount and frame.ChargeCount.Current
        or frame and frame.count
end

function Stacks:RestoreStackPositions(viewerName)
    local viewer = _G[viewerName]
    if not viewer then
        return
    end
    local children = ns.API:GetViewerItemFrames(viewer)
    local stackPoint, stackX, stackY = GetViewerStackDefaults(viewerName)
    for _, child in ipairs(children) do
        local fs = GetStackFontString(child)
        if fs and ns.API:GetIsAffected(child, "stack") then
            fs:ClearAllPoints()
            fs:SetPoint(stackPoint, child, stackPoint, stackX, stackY)
            if fs.defaults then
                fs:SetFont(unpack(fs.defaults, 1, 3))
            end
            ns.API:UnsetAffected(child, "stack")
        end
    end
end

function Stacks:ApplyStackFonts(viewerName)
    RefreshCustomAuraStyles(viewerName)
    local viewer = _G[viewerName]
    if not viewer then
        return
    end
    local fontSize, stackEnabled, stackPoint, stackX, stackY = GetViewerStackSettings(viewerName)
    if not stackEnabled then
        self:RestoreStackPositions(viewerName)
        return
    end
    local children = ns.API:GetViewerItemFrames(viewer)
    for _, child in ipairs(children) do
        local fs = GetStackFontString(child)

        if child.Applications and child.Applications.SetFrameLevel then
            child.Applications:SetFrameLevel(20)
        end
        if child.ChargeCount and child.ChargeCount.SetFrameLevel then
            child.ChargeCount:SetFrameLevel(20)
        end
        if fs then
            ns.API:SetAffected(child, "stack")
            ApplyStackFont(fs, fontSize, viewerName)
            fs:ClearAllPoints()
            fs:SetPoint(stackPoint, child, stackPoint, stackX, stackY)
        end
    end
end

function Stacks:IsAnyStacksFeatureEnabled()
    return ns.db.profile.cooldownManager_stackAnchorEssential_enabled
        or ns.db.profile.cooldownManager_stackAnchorUtility_enabled
        or ns.db.profile.cooldownManager_stackAnchorBuffIcons_enabled
end

function Stacks:RefreshAll()
    for viewerName in pairs(viewersSettingKey) do
        self:ApplyStackFonts(viewerName)
    end
end

function Stacks:Initialize()
    self:RefreshAll()
end
