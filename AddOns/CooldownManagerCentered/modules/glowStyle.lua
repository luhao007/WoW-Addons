local _, ns = ...

local GlowStyle = {}
ns.GlowStyle = GlowStyle

local LCG = LibStub("LibCustomGlow-1.0")
local GLOW_STYLE_DEFAULT = "DEFAULT"
local GLOW_STYLE_PROC = "PROC"
local GLOW_STYLE_AUTOCAST = "AUTOCAST"
local GLOW_STYLE_PIXEL = "PIXEL"

local viewers = {
    ["BuffIconCooldownViewer"] = BuffIconCooldownViewer,
    ["BuffBarCooldownViewer"] = BuffBarCooldownViewer,
    ["EssentialCooldownViewer"] = EssentialCooldownViewer,
    ["UtilityCooldownViewer"] = UtilityCooldownViewer,
}

local function GetCooldownViewerChild(frame)
    if not frame or not frame.GetParent then
        return nil
    end

    if not frame.cooldownInfo then
        return nil
    end
    local current = frame
    while current and current.GetParent do
        local parent = current:GetParent()
        if not parent then
            return nil
        end

        for viewerName, viewer in pairs(viewers) do
            if parent == viewer then
                return current
            end
        end

        current = parent
    end

    return nil
end

local function GetGlowTarget(frame)
    if not frame then
        return nil
    end

    return GetCooldownViewerChild(frame)
end

local function GetTargetSpellId(frame)
    if not frame or not frame.cooldownInfo then
        return nil
    end
    return frame.cooldownInfo.spellID
end

local function GetConfiguredGlowStyle()
    local style = ns.db.profile.cooldownManager_experimental_glow_style or GLOW_STYLE_DEFAULT
    if
        style ~= GLOW_STYLE_DEFAULT
        and style ~= GLOW_STYLE_PROC
        and style ~= GLOW_STYLE_AUTOCAST
        and style ~= GLOW_STYLE_PIXEL
    then
        return GLOW_STYLE_DEFAULT
    end
    return style
end

local function ResolveGlowStyle(defaultStyle)
    local selectedStyle = GetConfiguredGlowStyle()
    if selectedStyle == GLOW_STYLE_DEFAULT then
        return defaultStyle
    end
    return selectedStyle
end

local function GetConfiguredGlowColor()
    if not ns.db.profile.cooldownManager_experimental_glow_custom_color then
        return nil
    end
    return {
        ns.db.profile.cooldownManager_experimental_glow_color_r or 0.95,
        ns.db.profile.cooldownManager_experimental_glow_color_g or 0.95,
        ns.db.profile.cooldownManager_experimental_glow_color_b or 0.32,
        ns.db.profile.cooldownManager_experimental_glow_color_a or 1,
    }
end

local function GetConfiguredGlowFrequency()
    local speed = tonumber(ns.db.profile.cooldownManager_experimental_glow_animation_speed) or 0
    if speed > 1 then
        speed = 1
    elseif speed < -1 then
        speed = -1
    end
    return speed
end

local function GetConfiguredGlowDensity()
    local density = tonumber(ns.db.profile.cooldownManager_experimental_glow_animation_density) or 0
    if density > 16 then
        density = 16
    elseif density < 0.5 then
        density = 0
    end
    return density
end

local function GetAutoCastGlowScale()
    local scale = tonumber(ns.db.profile.cooldownManager_experimental_glow_autocast_scale) or 1
    scale = math.floor((scale * 10) + 0.5) / 10
    if scale > 5 then
        scale = 5
    elseif scale < 0.5 then
        scale = 0.5
    end
    return scale
end

local function GetPixelGlowSize()
    local size = tonumber(ns.db.profile.cooldownManager_experimental_glow_pixel_size) or 1
    size = math.floor(size + 0.5)
    if size > 6 then
        size = 6
    elseif size < 1 then
        size = 1
    end
    return size
end

local function StopCustomGlows(frame)
    LCG.ProcGlow_Stop(frame)
    LCG.AutoCastGlow_Stop(frame)
    LCG.PixelGlow_Stop(frame)
end

local function StartConfiguredGlow(frame, defaultStyle)
    local resolvedStyle = ResolveGlowStyle(defaultStyle)
    local color = GetConfiguredGlowColor()
    local frequency = GetConfiguredGlowFrequency()
    local density = GetConfiguredGlowDensity()
    if resolvedStyle == GLOW_STYLE_AUTOCAST then
        local glowAutoCastGlowScale = GetAutoCastGlowScale()
        LCG.AutoCastGlow_Start(frame, color, density, frequency, glowAutoCastGlowScale)
    elseif resolvedStyle == GLOW_STYLE_PIXEL then
        local pixelGlowSize = GetPixelGlowSize()
        LCG.PixelGlow_Start(frame, color, density, frequency, nil, pixelGlowSize)
    else
        LCG.ProcGlow_Start(frame, { startAnim = false, color = color })
    end
    return resolvedStyle
end

local function GetGlowSignature(defaultStyle)
    local resolvedStyle = ResolveGlowStyle(defaultStyle)
    if resolvedStyle == GLOW_STYLE_AUTOCAST or resolvedStyle == GLOW_STYLE_PIXEL then
        local frequency = GetConfiguredGlowFrequency()
        local density = GetConfiguredGlowDensity()
        local autoCastScale = GetAutoCastGlowScale()
        local pixelSize = GetPixelGlowSize()
        local color = GetConfiguredGlowColor()
        if color then
            return string.format(
                "%s:%.3f:%.3f:%.3f:%.3f:%.3f:%d:%.1f:%d",
                resolvedStyle,
                color[1] or 0,
                color[2] or 0,
                color[3] or 0,
                color[4] or 1,
                frequency,
                density,
                autoCastScale,
                pixelSize
            )
        end
        return string.format("%s:%.3f:%d:%.1f:%d", resolvedStyle, frequency, density, autoCastScale, pixelSize)
    end
    return resolvedStyle
end

local function HookActionButtonSpellAlertManager()
    if not ActionButtonSpellAlertManager then
        return
    end
    if ActionButtonSpellAlertManager._CMC_Hooked then
        return
    end

    hooksecurefunc(ActionButtonSpellAlertManager, "ShowAlert", function(_, frame)
        local activeGlowTarget = GetGlowTarget(frame)
        if not activeGlowTarget then
            return
        end
        local spellId = GetTargetSpellId(frame)
        if not spellId then
            return
        end
        if ns.CooldownStyle.GetDisableProcsGlow(spellId) then
            if activeGlowTarget.SpellActivationAlert then
                activeGlowTarget.SpellActivationAlert:SetAlpha(0)
            end
            return
        else
            if activeGlowTarget.SpellActivationAlert then
                activeGlowTarget.SpellActivationAlert:SetAlpha(1)
            end
        end

        local glowStyle = ns.db.profile.cooldownManager_experimental_glow_style
        if glowStyle and glowStyle ~= "DEFAULT" then
            activeGlowTarget.SpellActivationAlert:SetAlpha(0)
            local signature = GetGlowSignature(GLOW_STYLE_PIXEL)
            if activeGlowTarget.CMCActiveGlow and activeGlowTarget.CMCActiveGlowSignature == signature then
                return
            end

            activeGlowTarget.CMCActiveGlow = true
            StopCustomGlows(activeGlowTarget)
            activeGlowTarget.CMCActiveGlowStyle = StartConfiguredGlow(activeGlowTarget, GLOW_STYLE_PIXEL)
            activeGlowTarget.CMCActiveGlowSignature = signature

            return
        end
    end)

    hooksecurefunc(ActionButtonSpellAlertManager, "HideAlert", function(_, frame)
        local activeGlowTarget = GetGlowTarget(frame)
        if not activeGlowTarget or not activeGlowTarget.CMCActiveGlow then
            return
        end

        activeGlowTarget.CMCActiveGlow = nil
        activeGlowTarget.CMCActiveGlowStyle = nil
        activeGlowTarget.CMCActiveGlowSignature = nil
        StopCustomGlows(activeGlowTarget)
    end)
    ActionButtonSpellAlertManager._CMC_Hooked = true
end

function GlowStyle.Initialize()
    HookActionButtonSpellAlertManager()
end
