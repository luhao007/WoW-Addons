local _, ns = ...
local L = ns.L
local Affected = ns.API.Affected

local CooldownStyle = ns.CooldownStyle or {}
ns.CooldownStyle = CooldownStyle
local MENU_TITLE = "|cff008945C|r|cff1e9a4eo|r|cff3faa4fol|r|cff5fb64ado|r|cff7ac243wn|r |cff8ccd00Manager Centered|r"
local GCD_SPELL_ID = 61304

local FIX_BLIZZARD_CLEARED_COOLDOWNS = {
    [325153] = true, -- Exploding Keg
    [207684] = true, -- Sigil of Misery
    [204596] = true, -- Sigil of Flame
    [202137] = true, -- Sigil of Silence
    [49028] = true, -- Dancing Rune Weapon
}

local DEFAULT_ALWAYS_SHOW_COOLDOWN_EDGE = false
local DEFAULT_SHOW_AURAS = true
local DEFAULT_DISABLE_PROCS_GLOW = false
local DEFAULT_REVERSE_AURA_SWIPE = false
local DEFAULT_GLOW_WHEN_READY = false
local DEFAULT_GLOW_ON_FULL_CHARGES = false
local DEFAULT_GLOW_WHEN_AURA_ACTIVE = false
local DEFAULT_GLOW_WHEN_SUGGESTED = false
local DEFAULT_ALWAYS_GLOW = false
local DEFAULT_NEVER_DESATURATE = false
local DEFAULT_BAR_COLOR = { 1, 0.5, 0.25 }
local DEFAULT_ENTRY_GLOW_COLOR = { 1, 210 / 255, 0, 1 }
local SQUARE_SWIPE_TEXTURE = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square"
local NATIVE_SWIPE_TEXTURE = "Interface\\HUD\\UI-HUD-CoolDownManager-Icon-Swipe"

local LCG = LibStub("WilduCustomGlow-1.0")
local GLOW_STYLE_DEFAULT = "DEFAULT"
local GLOW_STYLE_PROC = "PROC"
local GLOW_STYLE_AUTOCAST = "AUTOCAST"
local GLOW_STYLE_PIXEL = "PIXEL"
local GLOW_STYLE_ANTS = "ANTS"
local GLOW_STYLE_SLOT = "SLOT"

local function IsGlowOnlyInCombat()
    return ns.db and ns.db.profile and ns.db.profile.cooldownManager_glow_only_in_combat == true
end

local function IsGlowSuppressedByCombatSetting()
    return IsGlowOnlyInCombat() and not InCombatLockdown() and not (ns.Runtime and ns.Runtime.hasSettingsOpened)
end

function CooldownStyle:CanShowGlows()
    return not IsGlowSuppressedByCombatSetting()
end

local function GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
    if not cooldownInfo then
        return nil
    end
    if cooldownInfo.overrideTooltipSpellID then
        return cooldownInfo.overrideTooltipSpellID
    end
    if cooldownInfo.overrideSpellID then
        return cooldownInfo.overrideSpellID
    end

    if cooldownInfo.spellID then
        return cooldownInfo.spellID
    end
    return nil
end

local function GetBaseSpellIDFromCooldownInfo(cooldownInfo)
    if not cooldownInfo then
        return nil
    end
    if cooldownInfo.spellID then
        return cooldownInfo.spellID
    end
    return nil
end

-- 12.1.0 dynamic icons: equip-slot items (cooldownInfo.equipSlot) and
-- spell-category cooldowns like potions/healthstones (cooldownInfo.spellCategoryID).
-- Their spellID changes with whatever item/spell is currently underneath them.
local function IsDynamicCooldownInfo(cooldownInfo)
    return cooldownInfo ~= nil and (cooldownInfo.spellCategoryID ~= nil or cooldownInfo.equipSlot ~= nil)
end

-- Stable key for per-icon style settings (glow when ready, never desaturate, ...).
-- Normal cooldowns key by spellID (backwards compatible with saved settings).
-- Dynamic icons have no fixed spellID, so they key off the icon slot's stable
-- cooldownID; the "cd:" prefix namespaces it so it can never collide with a
-- numeric spellID key. useOverride mirrors the base-vs-override spellID choice
-- for normal spells and is irrelevant for dynamic icons (one slot identity).
local function GetStyleKeyFromCooldownInfo(cooldownInfo, useOverride)
    if cooldownInfo == nil then
        return nil
    end
    if IsDynamicCooldownInfo(cooldownInfo) then
        local cooldownID = cooldownInfo.cooldownID
        return cooldownID and ("cd:" .. cooldownID) or nil
    end
    if useOverride then
        return GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
    end
    return GetBaseSpellIDFromCooldownInfo(cooldownInfo)
end

-- 12.1.0 added spec-agnostic (5/6) and equip-slot (7/8) category variants that
-- style like the base Essential/Utility (cooldown) and TrackedBuff (aura)
-- categories. Negative keys are CMC's legacy hidden-variant pseudo-categories.
local COOLDOWN_LIKE_CATEGORY = { [-1] = true, [0] = true, [1] = true, [5] = true, [7] = true }
local TRACKED_LIKE_CATEGORY = { [-2] = true, [2] = true, [6] = true, [8] = true }
local BAR_LIKE_CATEGORY = { [3] = true }
local ALWAYS_SATURATED_CATEGORY_SETTING = {
    [0] = { key = "cooldownManager_alwaysSaturated_Essential", label = L["Essential"] },
    [1] = { key = "cooldownManager_alwaysSaturated_Utility", label = L["Utility"] },
}

local function GetAlwaysSaturatedCategorySetting(category)
    local setting = ALWAYS_SATURATED_CATEGORY_SETTING[category]
    if not setting then
        return false
    end
    return ns.db.profile[setting.key] == true
end

local function ResolveGlowStyle(defaultStyle)
    local style = ns.db.profile.cooldownManager_experimental_glow_style or GLOW_STYLE_DEFAULT

    if
        style ~= GLOW_STYLE_DEFAULT
        and style ~= GLOW_STYLE_PROC
        and style ~= GLOW_STYLE_AUTOCAST
        and style ~= GLOW_STYLE_PIXEL
        and style ~= GLOW_STYLE_ANTS
        and style ~= GLOW_STYLE_SLOT
    then
        style = GLOW_STYLE_DEFAULT
    end
    if style == GLOW_STYLE_DEFAULT then
        return defaultStyle
    end
    return style
end

local function GetConfiguredGlowColor()
    if not ns.db.profile.cooldownManager_experimental_glow_custom_color then
        return nil
    end
    return {
        ns.db.profile.cooldownManager_experimental_glow_color_r or 1,
        ns.db.profile.cooldownManager_experimental_glow_color_g or 210 / 255,
        ns.db.profile.cooldownManager_experimental_glow_color_b or 0,
        ns.db.profile.cooldownManager_experimental_glow_color_a or 1,
    }
end

local function GetStoredStyleSettings(styleKey)
    local db = ns.db and ns.db.profile and ns.db.profile.cooldownStyleSettings
    return styleKey and db and db.spellSettings and db.spellSettings[styleKey] or nil
end

local function GetStoredRGB(settings, field)
    local color = settings and settings[field]
    if type(color) == "table" and color[1] ~= nil and color[2] ~= nil and color[3] ~= nil then
        return color
    end
    return nil
end

local function GetNativeEntryColor(cdmFrame, cooldownField, trackedField)
    local cooldownInfo = cdmFrame and cdmFrame.GetCooldownInfo and cdmFrame:GetCooldownInfo()
    if not cooldownInfo then
        return nil
    end
    if COOLDOWN_LIKE_CATEGORY[cooldownInfo.category] then
        local settings = GetStoredStyleSettings(GetStyleKeyFromCooldownInfo(cooldownInfo, false))
        return GetStoredRGB(settings, cooldownField)
    elseif TRACKED_LIKE_CATEGORY[cooldownInfo.category] then
        local settings = GetStoredStyleSettings(GetStyleKeyFromCooldownInfo(cooldownInfo, true))
        return GetStoredRGB(settings, trackedField)
    end
    return nil
end

local function GetPerEntryGlowColor(cdmFrame)
    local affected = cdmFrame and Affected(cdmFrame)
    local kind = affected and (affected.resolvedTrackerEntryKind or affected.trackerEntryKind)
    local id = affected and (affected.resolvedTrackerEntryId or affected.trackerEntryId)
    if kind and id and ns.TrackerDB and ns.TrackerDB.GetEntryColor then
        return ns.TrackerDB.GetEntryColor(kind, id, "glowColor")
    end
    return GetNativeEntryColor(cdmFrame, "cooldownGlowColor", "trackedGlowColor")
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

local function GetAntsGlowLayers()
    local layers = math.floor(GetConfiguredGlowDensity())
    if layers < 1 then
        layers = 1
    elseif layers > 4 then
        layers = 4
    end
    return layers
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

local function StopAllCustomGlows(frame)
    LCG.ProcGlow_Stop(frame)
    LCG.AutoCastGlow_Stop(frame)
    LCG.PixelGlow_Stop(frame)
    LCG.AntsGlow_Stop(frame)
    LCG.SlotGlow_Stop(frame)
    LCG.ShapeGlow_Stop(frame)
end

local function GetGlowSpeedFactor()
    return 2 ^ -GetConfiguredGlowFrequency()
end

local function CollectGlowParams(cdmFrame, defaultStyle)
    local masque = ns.MasqueModule
    local styleSource = cdmFrame
    return {
        style = ResolveGlowStyle(defaultStyle),
        color = GetPerEntryGlowColor(styleSource) or GetConfiguredGlowColor(),
        frequency = GetConfiguredGlowFrequency(),
        speedFactor = GetGlowSpeedFactor(),
        density = GetConfiguredGlowDensity(),
        antsLayers = GetAntsGlowLayers(),
        autoCastScale = GetAutoCastGlowScale(),
        pixelSize = GetPixelGlowSize(),
        shape = (styleSource and masque and masque:GetShape(styleSource)),
        vertices = masque and masque:GetShapeVertices(styleSource),
        acStyle = masque and masque:GetAssistedCombatStyle(styleSource),
        shapedTexture = masque and masque:GetSpellAlertTextures(styleSource),
    }
end

local function StartConfiguredGlow(frame, params)
    local style = params.style
    local color = params.color

    if style == GLOW_STYLE_SLOT then
        LCG.SlotGlow_Start(frame, { color = color })
    elseif style == GLOW_STYLE_AUTOCAST then
        LCG.AutoCastGlow_Start(frame, color, params.density, params.frequency, params.autoCastScale, nil, nil, nil, nil, params.vertices)
    elseif style == GLOW_STYLE_PIXEL then
        LCG.PixelGlow_Start(frame, color, params.density, params.frequency, nil, params.pixelSize, nil, nil, nil, nil, nil, params.vertices)
    elseif style == GLOW_STYLE_ANTS then
        local opts = {
            color = color,
            duration = LCG.AntsGlowDefaults.duration * params.speedFactor,
            count = params.antsLayers,
        }
        local acStyle = params.acStyle
        if acStyle and acStyle.Texture then
            opts.texture = acStyle.Texture
            opts.texCoords = acStyle.TexCoords
            opts.frameWidth = acStyle.FrameWidth
            opts.frameHeight = acStyle.FrameHeight
        end
        LCG.AntsGlow_Start(frame, opts)
    else
        if params.shapedTexture then
            LCG.ShapeGlow_Start(frame, {
                texture = params.shapedTexture,
                color = color,
                speedFactor = params.speedFactor,
            })
        else
            LCG.ProcGlow_Start(frame, { startAnim = false, color = color, duration = params.speedFactor })
        end
    end
    return style
end

local function BuildGlowSignature(params)
    local style = params.style
    local color = params.color
    local base
    if style == GLOW_STYLE_ANTS then
        if color then
            base = string.format(
                "%s:%.3f:%.3f:%.3f:%.3f:%.3f:%d",
                style,
                color[1] or 0,
                color[2] or 0,
                color[3] or 0,
                color[4] or 1,
                params.frequency,
                params.antsLayers
            )
        else
            base = string.format("%s:%.3f:%d", style, params.frequency, params.antsLayers)
        end
    elseif style == GLOW_STYLE_AUTOCAST or style == GLOW_STYLE_PIXEL then
        if color then
            base = string.format(
                "%s:%.3f:%.3f:%.3f:%.3f:%.3f:%d:%.1f:%d",
                style,
                color[1] or 0,
                color[2] or 0,
                color[3] or 0,
                color[4] or 1,
                params.frequency,
                params.density,
                params.autoCastScale,
                params.pixelSize
            )
        else
            base = string.format("%s:%.3f:%d:%.1f:%d", style, params.frequency, params.density, params.autoCastScale, params.pixelSize)
        end
    else
        if color then
            base = string.format("%s:%.3f:%.3f:%.3f:%.3f:%.3f", style, color[1] or 0, color[2] or 0, color[3] or 0, color[4] or 1, params.frequency)
        else
            base = string.format("%s:%.3f", style, params.frequency)
        end
    end
    return base .. "|" .. (params.shape or "")
end

local HealGlowOnResize

local function GetGlowHostSize(cdmFrame)
    local sizeSource = cdmFrame
    -- Trackers stamp their icon size; viewers resolve through Sizes.
    local stamped = Affected(sizeSource).glowIconSizeW
    if stamped then
        return stamped, Affected(sizeSource).glowIconSizeH or stamped
    end
    local width, height = ns.Sizes.GetIconSize(sizeSource)
    if not width then
        width, height = sizeSource:GetSize()
    end
    return width, height
end

local function GetGlowHost(cdmFrame)
    local host = Affected(cdmFrame).glowHost
    if not host then
        host = CreateFrame("Frame", nil, cdmFrame)
        host:SetAllPoints(cdmFrame.Icon or cdmFrame)
        Affected(cdmFrame).glowHost = host

        host:HookScript("OnSizeChanged", function(self)
            C_Timer.After(0.1, function()
                self._width, self._height = GetGlowHostSize(cdmFrame)
                HealGlowOnResize(self)
            end)
        end)
    end
    host._width, host._height = GetGlowHostSize(cdmFrame)
    return host
end

local function GetButtonGlowFrame(host)
    if host._SlotGlow then
        return host._SlotGlow
    end
    if host._ShapeGlow then
        return host._ShapeGlow
    end

    if host._ProcGlow then
        return host._ProcGlow
    end
    if host._AutoCastGlow then
        return host._AutoCastGlow
    end
    if host._PixelGlow then
        return host._PixelGlow
    end
    if host._AntsGlow then
        return host._AntsGlow
    end

    return nil
end

local function EnsureButtonGlow(cdmFrame)
    local host = GetGlowHost(cdmFrame)
    local params = CollectGlowParams(cdmFrame, GLOW_STYLE_PROC)
    local signature = BuildGlowSignature(params)

    local glow = GetButtonGlowFrame(host)
    if not (Affected(host).glowSignature == signature and glow) then
        StopAllCustomGlows(host)
        StartConfiguredGlow(host, params)
        Affected(host).glowSignature = signature
        Affected(host).glowParams = params
        glow = GetButtonGlowFrame(host)
    end

    return glow
end

HealGlowOnResize = function(host)
    if not Affected(host).glowParams then
        return
    end
    local glow = GetButtonGlowFrame(host)
    local alpha = (glow and glow:GetAlpha()) or 0
    StopAllCustomGlows(host)
    StartConfiguredGlow(host, Affected(host).glowParams)
    glow = GetButtonGlowFrame(host)
    if glow then
        glow:SetAlpha(alpha)
    end
end

local function SetButtonGlowVisible(cdmFrame, alpha)
    if IsGlowSuppressedByCombatSetting() then
        return nil
    end
    if alpha == nil then
        alpha = 1
    end
    local glow = EnsureButtonGlow(cdmFrame)
    if glow then
        glow:SetAlpha(alpha)
    end
    return glow
end

local function ClearButtonGlow(cdmFrame)
    local host = Affected(cdmFrame).glowHost
    if not host then
        return
    end
    if not Affected(host).glowSignature and not GetButtonGlowFrame(host) then
        return
    end
    Affected(host).glowSignature = nil
    StopAllCustomGlows(host)
end

-- Public glow controls for frames outside the cooldown viewers (trackers).
local function HideNativeFrameProcGlow(frame)
    if not frame or not Affected(frame).nativeProcGlow then
        return
    end
    if ActionButtonSpellAlertManager then
        ActionButtonSpellAlertManager:HideAlert(frame)
    end
    Affected(frame).nativeProcGlow = nil
end

function CooldownStyle:ShowFrameGlow(frame, alpha)
    HideNativeFrameProcGlow(frame)
    return SetButtonGlowVisible(frame, alpha)
end

function CooldownStyle:HideFrameGlow(frame)
    HideNativeFrameProcGlow(frame)
    ClearButtonGlow(frame)
end

function CooldownStyle:ShowFrameProcGlow(frame)
    if not frame then
        return
    end
    if IsGlowSuppressedByCombatSetting() then
        return
    end

    local glowStyle = ns.db.profile.cooldownManager_experimental_glow_style
    local usesCustomGlow = (glowStyle and glowStyle ~= GLOW_STYLE_DEFAULT) or GetPerEntryGlowColor(frame) ~= nil
    if usesCustomGlow or not ActionButtonSpellAlertManager then
        HideNativeFrameProcGlow(frame)
        return SetButtonGlowVisible(frame)
    end

    ClearButtonGlow(frame)
    ActionButtonSpellAlertManager:ShowAlert(frame)
    Affected(frame).nativeProcGlow = true
    if frame.SpellActivationAlert then
        frame.SpellActivationAlert:SetSize(frame:GetWidth() * 1.4, frame:GetHeight() * 1.4)
    end
    return frame.SpellActivationAlert
end

local function ComputeConfiguredGlowAlpha(cdmFrame, cooldownInfo, styleKey)
    if cooldownInfo == nil then
        return false
    end

    if COOLDOWN_LIKE_CATEGORY[cooldownInfo.category] then
        local hideForAura = ns.db.profile.cooldownManager_hide_glow_on_active_aura and cdmFrame.wasSetFromAura
        local spellID = GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
        styleKey = styleKey or GetStyleKeyFromCooldownInfo(cooldownInfo, false)
        local glowWhenAuraActive = CooldownStyle.GetGlowWhenAuraActive(styleKey)
        local glowWhenSuggested = CooldownStyle.GetGlowWhenSuggested(styleKey)
        local glowOnFullCharges = CooldownStyle.GetGlowOnFullCharges(styleKey)
        local glowWhenReady = CooldownStyle.GetGlowWhenReady(styleKey)

        if not hideForAura and not glowWhenAuraActive and not glowWhenSuggested and not glowOnFullCharges and not glowWhenReady then
            return false
        end

        -- Item/spell-category icons (12.1.0: potions, healthstones, equip-slot
        -- trinkets) carry no live spellID until triggered, so their cooldown/
        -- charge readiness can't be queried; nothing to glow off yet.
        if not spellID then
            return false
        end

        if glowWhenAuraActive and cdmFrame.wasSetFromAura then
            return true, 1
        end
        if glowWhenSuggested and ns.Assistant and ns.Assistant:IsSpellSuggested(spellID) then
            return true, 1
        end
        if hideForAura then
            return true, 0
        end
        local chargeInfo = glowOnFullCharges and C_Spell.GetSpellCharges(spellID) or nil
        local hasCharges = chargeInfo and chargeInfo.maxCharges > 1
        if hasCharges and glowOnFullCharges then
            return true, chargeInfo.isActive and 0 or 1
        end

        if glowWhenReady or glowOnFullCharges then
            local isUsable, notEnoughPower = C_Spell.IsSpellUsable(spellID)
            if notEnoughPower then
                return true, 0
            end
            if not isUsable then
                return true, 0
            end
            local cooldown = C_Spell.GetSpellCooldown(spellID)
            if cooldown.isOnGCD or not cooldown.isActive then
                return true, 1
            end
        end
    end

    if TRACKED_LIKE_CATEGORY[cooldownInfo.category] then
        local trackedStyleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, true)
        if CooldownStyle.GetAlwaysGlow(trackedStyleKey) then
            return true, 1
        end
    end

    return false
end

local function UpdateButtonGlowState(cdmFrame, cooldownInfo, styleKey)
    if IsGlowSuppressedByCombatSetting() then
        return
    end
    cooldownInfo = cooldownInfo or cdmFrame:GetCooldownInfo()
    styleKey = styleKey or GetStyleKeyFromCooldownInfo(cooldownInfo, false)
    local wantsGlow, configuredAlpha = ComputeConfiguredGlowAlpha(cdmFrame, cooldownInfo, styleKey)
    local affected = Affected(cdmFrame)
    local disableProcs = styleKey and CooldownStyle.GetDisableProcsGlow(styleKey)
    local glowStyle = ns.db.profile.cooldownManager_experimental_glow_style
    local usesCustomProc = affected.procShown
        and not disableProcs
        and ((glowStyle and glowStyle ~= GLOW_STYLE_DEFAULT) or GetPerEntryGlowColor(cdmFrame) ~= nil)
    affected.procActive = usesCustomProc or nil
    if cdmFrame.SpellActivationAlert then
        cdmFrame.SpellActivationAlert:SetAlpha((affected.procShown and (disableProcs or usesCustomProc)) and 0 or 1)
    end

    if usesCustomProc then
        SetButtonGlowVisible(cdmFrame)
    elseif wantsGlow then
        SetButtonGlowVisible(cdmFrame, configuredAlpha)
    else
        ClearButtonGlow(cdmFrame)
    end
end

local QueueGlowUpdate

local function GetNativeStackFontString(cdmFrame)
    return cdmFrame and cdmFrame.Applications and cdmFrame.Applications.Applications or cdmFrame and cdmFrame.ChargeCount and cdmFrame.ChargeCount.Current
end

local function ApplyFontStringEntryColor(fontString, color)
    if not fontString then
        return
    end
    local affected = Affected(fontString)
    if color then
        if not affected.entryColorOriginal then
            affected.entryColorOriginal = { fontString:GetTextColor() }
        end
        fontString:SetTextColor(color[1], color[2], color[3], 1)
    elseif affected.entryColorOriginal then
        fontString:SetTextColor(unpack(affected.entryColorOriginal))
        affected.entryColorOriginal = nil
    end
end

local function ApplyNativeStackColor(cdmFrame)
    ApplyFontStringEntryColor(GetNativeStackFontString(cdmFrame), GetNativeEntryColor(cdmFrame, "cooldownStackColor", "trackedStackColor"))
end

-- Reused scratch table for the style context. Both callers (ApplyCooldownSettings,
-- ApplyIconSettings) consume the context synchronously and never retain it past
-- the next BuildStyleContext call, so a single shared table avoids allocating one
-- per frame on every styling pass (a major source of GC churn during refreshes).
local styleContext = {}

local function BuildStyleContext(cdmFrame)
    local cooldownInfo = cdmFrame:GetCooldownInfo()
    if cooldownInfo == nil then
        return nil
    end

    local spellID = GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
    local styleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, false)
    -- Dynamic icons (12.1.0 items/potions) have a stable styleKey but no live
    -- spellID until triggered. Keep styling them (never desaturate, cooldown
    -- edge) off the styleKey; their spell-state queries below simply no-op.
    if not styleKey then
        return nil
    end

    local cooldown = spellID and C_Spell.GetSpellCooldown(spellID)
    local spellCharges = spellID and C_Spell.GetSpellCharges(spellID)
    local fromAura = cdmFrame.wasSetFromAura
    local showAuras = CooldownStyle.GetShowAuras(styleKey)

    local ctx = styleContext
    ctx.spellID = spellID
    ctx.styleKey = styleKey
    ctx.category = cooldownInfo.category
    ctx.cooldown = cooldown
    ctx.hasCharges = spellCharges and spellCharges.maxCharges > 1
    ctx.isActualCooldown = cooldown and cooldown.isActive and not cooldown.isOnGCD and true or false
    -- Display modes (mutually exclusive):
    ctx.auraShown = (fromAura and showAuras) and true or false
    ctx.auraHidden = (fromAura and not showAuras) and true or false
    return ctx
end

local function ApplyCooldownDisplay(cdmFrame, ctx)
    local cd = cdmFrame.Cooldown

    if CooldownStyle.GetAlwaysShowCooldownEdge(ctx.styleKey) then
        cd:SetDrawEdge(true)
    end

    if ctx.auraShown then
        if ns.db.profile.cooldownManager_customSwipeColor_enabled then
            cd:SetSwipeColor(
                ns.db.profile.cooldownManager_customActiveColor_r or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.r,
                ns.db.profile.cooldownManager_customActiveColor_g or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.g,
                ns.db.profile.cooldownManager_customActiveColor_b or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.b,
                ns.db.profile.cooldownManager_customActiveColor_a or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.a
            )
            -- Setting active swipe color to default may be unnecessary since the cooldown viewer's swipe color should already be at the default
            -- else
            --     cd:SetSwipeColor(
            --         ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.r,
            --         ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.g,
            --         ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.b,
            --         ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.a
            --     )
        end
        cd:SetDrawSwipe(true)
        if CooldownStyle.GetReverseAuraSwipe(ctx.styleKey) then
            cd:SetReverse(true)
        else
            cd:SetReverse(false)
        end
        return
    else
        cd:SetReverse(false)
    end

    if ns.db.profile.cooldownManager_customSwipeColor_enabled then
        cd:SetSwipeColor(
            ns.db.profile.cooldownManager_customCDSwipeColor_r or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.r,
            ns.db.profile.cooldownManager_customCDSwipeColor_g or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.g,
            ns.db.profile.cooldownManager_customCDSwipeColor_b or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.b,
            ns.db.profile.cooldownManager_customCDSwipeColor_a or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.a
        )
    else
        -- Don't remove it.. if the option is disabled we should still set it to the default in case it was changed by the active swipe color and therefore should be overridden
        cd:SetSwipeColor(
            ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.r,
            ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.g,
            ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.b,
            ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.a
        )
    end

    local hideGCD = ns.db.profile.cooldownManager_hide_gcd

    if ctx.auraHidden and ctx.spellID then
        if ctx.hasCharges then
            cd:SetCooldownFromDurationObject(C_Spell.GetSpellChargeDuration(ctx.spellID))
        elseif ctx.cooldown and ctx.cooldown.isOnGCD then
            if hideGCD then
                cd:SetCooldownFromDurationObject(C_DurationUtil.CreateDuration())
            else
                cd:SetCooldownFromDurationObject(C_Spell.GetSpellCooldownDuration(GCD_SPELL_ID))
            end
        else
            local cooldownDuration = C_Spell.GetSpellCooldownDuration(ctx.spellID)
            cd:SetCooldownFromDurationObject(cooldownDuration)
        end
    elseif ctx.cooldown and ctx.cooldown.isOnGCD and hideGCD then
        if ctx.hasCharges then
            cd:SetCooldownFromDurationObject(C_Spell.GetSpellChargeDuration(ctx.spellID))
        else
            cd:SetCooldownFromDurationObject(C_DurationUtil.CreateDuration())
        end
    end

    if ctx.auraHidden then
        if ctx.hasCharges then
            cd:SetDrawSwipe(ctx.isActualCooldown)
            cd:SetDrawEdge(not ctx.isActualCooldown or CooldownStyle.GetAlwaysShowCooldownEdge(ctx.styleKey))
        else
            cd:SetDrawSwipe(true)
        end
    end
end

local function ApplyIconDisplay(cdmFrame, ctx)
    local icon = cdmFrame.Icon
    local alwaysSaturated = CooldownStyle.GetNeverDesaturate(ctx.styleKey, ctx.category)

    -- Aura is shown.
    if ctx.auraShown then
        if ns.db.profile.cooldownManager_desaturate_under_aura then
            -- Single-charge spells always desaturate under their aura; charge
            -- spells only while actually on cooldown.
            if not ctx.hasCharges or ctx.isActualCooldown then
                icon:SetDesaturation(1)
            end
        end
        return
    end

    if alwaysSaturated and ctx.isActualCooldown then
        -- -- note: test for partial decaturation - needs to take usable state into account to not desaturate charging abilities
        -- local usable, notEnoughResources = C_Spell.IsSpellUsable(ctx.spellID)
        -- local notusable, enoughResources = not usable, not notEnoughResources
        -- if notusable and enoughResources then
        --     C_Timer.After(0.5, function()
        --         local ctx = BuildStyleContext(cdmFrame)
        --         if not ctx then
        --             return
        --         end
        --         ApplyIconDisplay(cdmFrame, ctx)
        --     end)
        -- else
        -- icon:SetDesaturation(0.7)
        -- end
        icon:SetDesaturation(0)
    elseif CooldownStyle.GetAlwaysDesaturate(ctx.styleKey) or (ctx.auraHidden and ctx.isActualCooldown) then
        icon:SetDesaturation(1)
    end
end

local function ApplyCooldownSettings(cdmFrame)
    local ctx = BuildStyleContext(cdmFrame)
    if not ctx then
        return
    end
    ApplyCooldownDisplay(cdmFrame, ctx)
    ApplyIconDisplay(cdmFrame, ctx)
end

-- Blizzard sometimes clears these cooldown widgets while the spell is still on CD - Restore only that premature Clear;
local function RestoreBlizzardClearedCooldown(cdmFrame)
    local cooldownInfo = cdmFrame.GetCooldownInfo and cdmFrame:GetCooldownInfo() or nil
    if IsDynamicCooldownInfo(cooldownInfo) then
        -- Category/equip-slot cooldowns can expose a secret spellID. They do
        -- not belong to the fixed-spell restoration table below.
        return
    end
    local baseSpellID = GetBaseSpellIDFromCooldownInfo(cooldownInfo)
    local spellID = GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
    if not spellID or not (FIX_BLIZZARD_CLEARED_COOLDOWNS[baseSpellID] or FIX_BLIZZARD_CLEARED_COOLDOWNS[spellID]) then
        return
    end

    local cooldownFrame = cdmFrame.Cooldown
    local affected = Affected(cooldownFrame)
    if affected.restoringBlizzardCooldown then
        return
    end

    local duration
    local cooldown = C_Spell.GetSpellCooldown(spellID)
    if cooldown and cooldown.isActive and not cooldown.isOnGCD then
        duration = C_Spell.GetSpellCooldownDuration(spellID, true)
    else
        local charges = C_Spell.GetSpellCharges(spellID)
        if charges and charges.maxCharges > 1 and charges.isActive and not charges.isOnGCD then
            duration = C_Spell.GetSpellChargeDuration(spellID)
        end
    end
    if not duration then
        return
    end

    affected.restoringBlizzardCooldown = true
    cooldownFrame:SetCooldownFromDurationObject(duration)
    affected.restoringBlizzardCooldown = nil
    ApplyCooldownSettings(cdmFrame)
    C_Timer.After(0, function()
        local styleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, false)
        if not CooldownStyle.GetNeverDesaturate(styleKey, cooldownInfo.category) then
            cdmFrame.Icon:SetDesaturation(1)
        end
    end)
end

-- Icon-only pass for when Blizzard re-desaturates the icon.
local function ApplyIconSettings(cdmFrame)
    local ctx = BuildStyleContext(cdmFrame)
    if not ctx then
        return
    end
    ApplyIconDisplay(cdmFrame, ctx)
end

local function ApplyCooldownFlashHidden(cdmFrame)
    local flash = cdmFrame.CooldownFlash
    if not flash then
        return
    end
    if ns.db.profile.cooldownManager_hideCooldownFlash then
        flash:Hide()
        flash:SetAlpha(0)
        if cdmFrame.Cooldown then
            cdmFrame.Cooldown:SetDrawBling(false)
        end
    else
        -- Undo our suppression; Blizzard controls Show/Hide from here.
        flash:SetAlpha(1)
    end
    if not ns.API:GetIsAffected(cdmFrame, "cooldownFlashHooked") then
        ns.API:SetAffected(cdmFrame, "cooldownFlashHooked")
        hooksecurefunc(flash, "Show", function(self)
            if ns.db.profile.cooldownManager_hideCooldownFlash then
                self:Hide()
                self:SetAlpha(0)
                if self.FlashAnim then
                    self.FlashAnim:Stop()
                end
            end
        end)
        if flash.FlashAnim and flash.FlashAnim.Play then
            hooksecurefunc(flash.FlashAnim, "Play", function(self)
                if ns.db.profile.cooldownManager_hideCooldownFlash then
                    self:Stop()
                    flash:Hide()
                    flash:SetAlpha(0)
                end
            end)
        end
    end
end

local function HookCooldownFrame(cdmFrame)
    if cdmFrame.Cooldown == nil or cdmFrame.Icon == nil then
        return
    end

    UpdateButtonGlowState(cdmFrame)
    ApplyNativeStackColor(cdmFrame)
    ApplyCooldownSettings(cdmFrame)
    ApplyCooldownFlashHidden(cdmFrame)

    local cooldownInfo = cdmFrame.GetCooldownInfo and cdmFrame:GetCooldownInfo() or nil
    local styleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, false)
    local hasNativeAura = cooldownInfo and (cooldownInfo.hasAura or cooldownInfo.selfAura)
    local auraSpellID = styleKey and not hasNativeAura and CooldownStyle.GetAuraSpellID(styleKey) or nil
    if ns.AuraTracking then
        local activeColor = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR
        local activeR, activeG, activeB, activeA = activeColor.r, activeColor.g, activeColor.b, activeColor.a
        if ns.db.profile.cooldownManager_customSwipeColor_enabled then
            activeR = ns.db.profile.cooldownManager_customActiveColor_r or activeR
            activeG = ns.db.profile.cooldownManager_customActiveColor_g or activeG
            activeB = ns.db.profile.cooldownManager_customActiveColor_b or activeB
            activeA = ns.db.profile.cooldownManager_customActiveColor_a or activeA
        end
        ns.AuraTracking:Attach(cdmFrame, auraSpellID, {
            anchor = cdmFrame.Cooldown,
            reverse = CooldownStyle.GetReverseAuraSwipe(styleKey),
            r = activeR,
            g = activeG,
            b = activeB,
            a = activeA,
            swipeTexture = ns.API:GetIsAffected(cdmFrame, "squareStyled") and SQUARE_SWIPE_TEXTURE or NATIVE_SWIPE_TEXTURE,
            stackColor = GetNativeEntryColor(cdmFrame, "cooldownStackColor", "trackedStackColor"),
        })
    end

    if ns.API:GetIsAffected(cdmFrame, "cooldownStyleHooked") then
        return
    end

    ns.API:SetAffected(cdmFrame, "cooldownStyleHooked")

    hooksecurefunc(cdmFrame.Cooldown, "SetCooldown", function(self)
        local cdmFrame = self:GetParent()
        QueueGlowUpdate(cdmFrame)
        ApplyCooldownSettings(cdmFrame)
    end)

    hooksecurefunc(cdmFrame.Cooldown, "Clear", function(self)
        local cdmFrame = self:GetParent()
        RestoreBlizzardClearedCooldown(cdmFrame)
        QueueGlowUpdate(cdmFrame)
    end)

    hooksecurefunc(cdmFrame.Icon, "SetSize", function(self)
        local cdmFrame = self:GetParent()
        QueueGlowUpdate(cdmFrame)
    end)
    hooksecurefunc(cdmFrame.Icon, "SetDesaturated", function(self)
        local cdmFrame = self:GetParent()

        -- Only the aura case needs a glow recalc here; SetDesaturated fires far too
        -- often otherwise (and its arg is a secret value we can't branch on).
        if cdmFrame.wasSetFromAura then
            QueueGlowUpdate(cdmFrame)
        end
        ApplyIconSettings(cdmFrame)
    end)
    if cdmFrame.RefreshData then
        hooksecurefunc(cdmFrame, "RefreshData", function(self)
            QueueGlowUpdate(self)
        end)
    end
end

local function HookBuffIconFrame(cdmFrame)
    if cdmFrame.Cooldown == nil or cdmFrame.Icon == nil then
        return
    end
    if cdmFrame.GetCooldownInfo then
        local cooldownInfo = cdmFrame:GetCooldownInfo()
        if cooldownInfo then
            local styleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, true)
            if TRACKED_LIKE_CATEGORY[cooldownInfo.category] then
                if CooldownStyle.GetAlwaysGlow(styleKey) then
                    SetButtonGlowVisible(cdmFrame)
                else
                    ClearButtonGlow(cdmFrame)
                end
            end
        end
    end
    ApplyNativeStackColor(cdmFrame)

    if ns.API:GetIsAffected(cdmFrame, "cooldownStyleHooked") then
        return
    end

    ns.API:SetAffected(cdmFrame, "cooldownStyleHooked")

    hooksecurefunc(cdmFrame.Cooldown, "SetCooldown", function(self)
        local cdmFrame = self:GetParent()
        local cooldownInfo = cdmFrame:GetCooldownInfo()
        if cooldownInfo == nil then
            return
        end

        local styleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, true)
        cdmFrame.Cooldown:SetDrawEdge(CooldownStyle.GetTrackedAlwaysShowCooldownEdge(styleKey))
        if TRACKED_LIKE_CATEGORY[cooldownInfo.category] then
            if CooldownStyle.GetAlwaysGlow(styleKey) then
                SetButtonGlowVisible(cdmFrame)
            else
                ClearButtonGlow(cdmFrame)
            end
        end
    end)
end

local function ResolveBarColor(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    local value = settings and settings.barColor
    if type(value) == "table" then
        return value[1], value[2], value[3]
    end
    return nil
end

local function ResolveBarColorFromCooldownInfo(cooldownInfo)
    if not cooldownInfo then
        return nil
    end
    local tooltipSpellID = cooldownInfo.overrideTooltipSpellID
    local overrideSpellID = cooldownInfo.overrideSpellID
    local baseSpellID = cooldownInfo.spellID
    local r, g, b = ResolveBarColor(tooltipSpellID)
    if r then
        return r, g, b, tooltipSpellID
    end
    if overrideSpellID ~= tooltipSpellID then
        r, g, b = ResolveBarColor(overrideSpellID)
    end
    if r then
        return r, g, b, overrideSpellID
    end
    if baseSpellID ~= tooltipSpellID and baseSpellID ~= overrideSpellID then
        r, g, b = ResolveBarColor(baseSpellID)
    end
    if r then
        return r, g, b, baseSpellID
    end
    return nil
end

local function SetBarFillColor(bar, r, g, b)
    if bar.SetStatusBarColor then
        bar:SetStatusBarColor(r, g, b)
    elseif bar.FillTexture then
        bar.FillTexture:SetVertexColor(r, g, b)
    end
end

local function ApplyBarColorToBar(bar, spellID)
    local r, g, b = ResolveBarColor(spellID)
    if not r then
        r, g, b = DEFAULT_BAR_COLOR[1], DEFAULT_BAR_COLOR[2], DEFAULT_BAR_COLOR[3]
    end
    SetBarFillColor(bar, r, g, b)
end

local function ApplyBarColor(cdmFrame)
    local bar = cdmFrame.Bar or cdmFrame.bar
    if not bar or not cdmFrame.GetCooldownInfo then
        return
    end
    local cooldownInfo = cdmFrame:GetCooldownInfo()
    if not cooldownInfo then
        return
    end
    local selectedSpellID = GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
    if not selectedSpellID then
        return
    end
    local r, g, b = ResolveBarColorFromCooldownInfo(cooldownInfo)
    local affected = Affected(cdmFrame)
    affected.customBarColorR = r
    affected.customBarColorG = g
    affected.customBarColorB = b
    if not r then
        r, g, b = DEFAULT_BAR_COLOR[1], DEFAULT_BAR_COLOR[2], DEFAULT_BAR_COLOR[3]
    end
    SetBarFillColor(bar, r, g, b)
end

local function ReapplyCustomBarColor(cdmFrame)
    local affected = Affected(cdmFrame)
    if affected.customBarColorR then
        SetBarFillColor(cdmFrame.Bar or cdmFrame.bar, affected.customBarColorR, affected.customBarColorG, affected.customBarColorB)
    end
end

local function HookBuffBarColor(cdmFrame)
    ApplyBarColor(cdmFrame)
    if ns.API:GetIsAffected(cdmFrame, "barColorHooked") then
        return
    end
    ns.API:SetAffected(cdmFrame, "barColorHooked")
    if cdmFrame.RefreshData then
        hooksecurefunc(cdmFrame, "RefreshData", function(self)
            ApplyBarColor(self)
        end)
    end
    if cdmFrame.RefreshCooldownInfo then
        hooksecurefunc(cdmFrame, "RefreshCooldownInfo", function(self)
            ReapplyCustomBarColor(self)
        end)
    end
end

local function RefreshBuffBarColors()
    local buffBarViewer = _G["BuffBarCooldownViewer"]
    if not buffBarViewer then
        return
    end
    for _, cdmFrame in ipairs(buffBarViewer:GetItemFrames()) do
        if (cdmFrame.Bar or cdmFrame.bar) and cdmFrame.GetCooldownInfo then
            HookBuffBarColor(cdmFrame)
        end
    end
end

local buffBarLayoutHooked = false
local function InstallBuffBarLayoutHook()
    if buffBarLayoutHooked then
        return
    end
    local buffBarViewer = _G["BuffBarCooldownViewer"]
    if not buffBarViewer or not buffBarViewer.Layout then
        return
    end
    buffBarLayoutHooked = true
    hooksecurefunc(buffBarViewer, "Layout", RefreshBuffBarColors)
end

local settingsSwatchPool

local function GetBarSwatchColor(spellID)
    local r, g, b = ResolveBarColor(spellID)
    if r then
        return r, g, b
    end
    return DEFAULT_BAR_COLOR[1], DEFAULT_BAR_COLOR[2], DEFAULT_BAR_COLOR[3]
end

local function OpenBarColorPicker(spellID, swatch, bar)
    local existing = CooldownStyle.GetSpellSettings(spellID)
    local originalBarColor = existing and existing.barColor

    local function refresh()
        if swatch then
            swatch:SetColorRGB(GetBarSwatchColor(spellID))
        end
        if bar then
            ApplyBarColorToBar(bar, spellID)
        end
        RefreshBuffBarColors()
    end

    local r, g, b = GetBarSwatchColor(spellID)
    ColorPickerFrame:SetupColorPickerAndShow({
        r = r,
        g = g,
        b = b,
        hasOpacity = false,
        swatchFunc = function()
            local nr, ng, nb = ColorPickerFrame:GetColorRGB()
            CooldownStyle.SetBarColorCustom(spellID, nr, ng, nb)
            refresh()
        end,
        cancelFunc = function()
            if originalBarColor == nil then
                CooldownStyle.ClearBarColor(spellID)
            else
                CooldownStyle.SetBarColorCustom(spellID, originalBarColor[1], originalBarColor[2], originalBarColor[3])
            end
            refresh()
        end,
    })
end

local function ConfigureBarColorSwatch(item, spellID, bar)
    local affected = Affected(item)
    if item.RefreshIconState and not affected.barColorRefreshIconStateHooked then
        affected.barColorRefreshIconStateHooked = true
        hooksecurefunc(item, "RefreshIconState", function(self)
            ApplyBarColor(self)
        end)
    end

    local swatch = affected.barColorSwatch
    if not swatch then
        swatch = settingsSwatchPool:Acquire()
        swatch:SetParent(item)
        swatch:ClearAllPoints()
        swatch:SetPoint("LEFT", bar, "RIGHT", 4, 0)
        swatch:SetSize(18, 18)
        swatch:SetFrameStrata("DIALOG")
        swatch:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        affected.barColorSwatch = swatch
    end

    swatch:SetColorRGB(GetBarSwatchColor(spellID))
    swatch:SetScript("OnClick", function(_, button)
        if button == "RightButton" then
            CooldownStyle.ClearBarColor(spellID)
            ApplyBarColorToBar(bar, spellID)
            swatch:SetColorRGB(GetBarSwatchColor(spellID))
            RefreshBuffBarColors()
        else
            OpenBarColorPicker(spellID, swatch, bar)
        end
    end)
    swatch:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(L["Bar Color"])
        GameTooltip:AddLine(L["Left-click: pick a color"], 1, 1, 1)
        GameTooltip:AddLine(L["Right-click: reset to default"], 1, 1, 1)
        GameTooltip:Show()
    end)
    swatch:SetScript("OnLeave", GameTooltip_Hide)
    swatch:Show()
end

local function RefreshBarColorSwatches(category)
    if not category or not category.itemPool then
        return
    end
    if not settingsSwatchPool then
        settingsSwatchPool = CreateFramePool("Button", UIParent, "ColorSwatchTemplate")
    end
    for item in category.itemPool:EnumerateActive() do
        local bar = item.Bar
        if item.GetCooldownInfo and bar then
            local cooldownInfo = item:GetCooldownInfo()
            local _, _, _, configuredSpellID = ResolveBarColorFromCooldownInfo(cooldownInfo)
            local spellID = configuredSpellID or GetMostOverrideSpellIDFromCooldownInfo(cooldownInfo)
            if spellID then
                ApplyBarColor(item)
                ConfigureBarColorSwatch(item, spellID, bar)
            end
        end
    end
end

local barColorSettingsHooked = false
local function InstallBarColorSettingsHook()
    if barColorSettingsHooked then
        return
    end
    if type(CooldownViewerSettingsBarCategoryMixin) ~= "table" or not CooldownViewerSettingsBarCategoryMixin.RefreshLayout then
        return
    end
    barColorSettingsHooked = true
    hooksecurefunc(CooldownViewerSettingsBarCategoryMixin, "RefreshLayout", RefreshBarColorSwatches)
end

local settingsOverrideIndicators = setmetatable({}, { __mode = "k" })
local settingsOverrideIndicatorHooked = false

local function HasCooldownOverrides(settings)
    return type(settings) == "table"
            and (settings.alwaysShowCooldownEdge == true or settings.showAuras == false or settings.reverseAuraSwipe == true or settings.disableProcsGlow == true or settings.glowWhenReady == true or settings.glowOnFullCharges == true or settings.glowWhenAuraActive == true or settings.glowWhenSuggested == true or GetStoredRGB(
                settings,
                "cooldownGlowColor"
            ) ~= nil or GetStoredRGB(settings, "cooldownStackColor") ~= nil or settings.neverDesaturate == true or settings.alwaysDesaturate == true or (tonumber(
                settings.auraSpellID
            ) or 0) > 0)
        or false
end

local function HasTrackedBuffOverrides(settings)
    return type(settings) == "table"
            and (settings.trackedAlwaysShowCooldownEdge == true or settings.alwaysGlow == true or GetStoredRGB(settings, "trackedGlowColor") ~= nil or GetStoredRGB(
                settings,
                "trackedStackColor"
            ) ~= nil)
        or false
end

local function HasCooldownInfoOverrides(cooldownInfo)
    if not cooldownInfo then
        return false
    end
    local category = cooldownInfo.category
    if COOLDOWN_LIKE_CATEGORY[category] then
        return HasCooldownOverrides(GetStoredStyleSettings(GetStyleKeyFromCooldownInfo(cooldownInfo, false)))
    elseif TRACKED_LIKE_CATEGORY[category] then
        return HasTrackedBuffOverrides(GetStoredStyleSettings(GetStyleKeyFromCooldownInfo(cooldownInfo, true)))
    end
    return false
end

local function HasReadyAlertEnabled(cooldownInfo)
    if not cooldownInfo or not COOLDOWN_LIKE_CATEGORY[cooldownInfo.category] or not ns.ReadyAlerts then
        return false
    end
    local settings = GetStoredStyleSettings(GetStyleKeyFromCooldownInfo(cooldownInfo, false))
    return ns.ReadyAlerts:IsEnabled(settings)
end

local function GetOrCreateSettingsOverrideIndicator(item)
    local indicator = Affected(item).settingsOverrideIndicator
    if indicator then
        return indicator
    end

    indicator = CreateFrame("Frame", nil, item)
    indicator:SetHeight(14)
    indicator:SetFrameLevel(item:GetFrameLevel() + 20)
    indicator:EnableMouse(false)

    local background = indicator:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(indicator)
    background:SetColorTexture(0, 0, 0, 0.7)

    local eye = indicator:CreateTexture(nil, "ARTWORK")
    eye:SetSize(16, 16)
    eye:SetPoint("CENTER")
    eye:SetAtlas("common-icon-visual")
    eye:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))

    local voice = indicator:CreateTexture(nil, "ARTWORK")
    voice:SetSize(16, 16)
    voice:SetPoint("CENTER", indicator, "CENTER", 8, 0)
    voice:SetAtlas("chatframe-button-icon-voicechat")
    voice:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))
    voice:Hide()

    indicator.Background = background
    indicator.Eye = eye
    indicator.Voice = voice
    Affected(item).settingsOverrideIndicator = indicator
    settingsOverrideIndicators[item] = true
    return indicator
end

local function RefreshSettingsOverrideIndicator(item)
    if InCombatLockdown() then
        return
    end
    if not item or not item.Icon then
        return
    end

    local cooldownInfo = item.GetCooldownInfo and item:GetCooldownInfo() or nil
    local cooldownID = Affected(item).settingsOverrideCooldownID
    if not cooldownInfo and cooldownID then
        cooldownInfo = C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
    end
    local indicator = GetOrCreateSettingsOverrideIndicator(item)
    indicator:ClearAllPoints()
    indicator:SetPoint("TOPLEFT", item.Icon, "TOPLEFT", 0, -2)
    indicator:SetPoint("TOPRIGHT", item.Icon, "TOPRIGHT", 0, -2)
    indicator:SetFrameLevel(item:GetFrameLevel() + 20)
    local showEye = HasCooldownInfoOverrides(cooldownInfo)
    local showVoice = HasReadyAlertEnabled(cooldownInfo)
    indicator.Eye:ClearAllPoints()
    indicator.Voice:ClearAllPoints()
    if showEye and showVoice then
        indicator.Eye:SetPoint("CENTER", indicator, "CENTER", -8, 0)
        indicator.Voice:SetPoint("CENTER", indicator, "CENTER", 8, 0)
    elseif showEye then
        indicator.Eye:SetPoint("CENTER")
    elseif showVoice then
        indicator.Voice:SetPoint("CENTER")
    end
    indicator.Eye:SetShown(showEye)
    indicator.Voice:SetShown(showVoice)
    indicator:SetShown(showEye or showVoice)
end

local function RefreshSettingsOverrideIndicators()
    if InCombatLockdown() then
        return
    end
    for item in pairs(settingsOverrideIndicators) do
        RefreshSettingsOverrideIndicator(item)
    end
end

function CooldownStyle.RefreshSettingsItemIndicators()
    RefreshSettingsOverrideIndicators()
end

function CooldownStyle.RefreshSettingsItemIndicator(item, cooldownID)
    Affected(item).settingsOverrideCooldownID = cooldownID
    RefreshSettingsOverrideIndicator(item)
end

function CooldownStyle.HideSettingsItemIndicator(item)
    Affected(item).settingsOverrideCooldownID = nil
    local indicator = Affected(item).settingsOverrideIndicator
    if indicator then
        indicator:Hide()
    end
end

function CooldownStyle.HideSettingsItemIndicators()
    for item in pairs(settingsOverrideIndicators) do
        local indicator = Affected(item).settingsOverrideIndicator
        if indicator then
            indicator:Hide()
        end
    end
end

local function InstallSettingsOverrideIndicatorHook()
    if settingsOverrideIndicatorHooked then
        return
    end
    if type(CooldownViewerSettingsItemMixin) ~= "table" or not CooldownViewerSettingsItemMixin.RefreshData then
        return
    end
    settingsOverrideIndicatorHooked = true
    hooksecurefunc(CooldownViewerSettingsItemMixin, "RefreshData", RefreshSettingsOverrideIndicator)
end

local function RefreshChildFramesHook()
    local essentialViewer = _G["EssentialCooldownViewer"]
    if essentialViewer then
        for _, cdmFrame in ipairs(essentialViewer:GetItemFrames()) do
            if cdmFrame.Cooldown and cdmFrame.Icon then
                HookCooldownFrame(cdmFrame)
            end
        end
    end

    local utilityViewer = _G["UtilityCooldownViewer"]
    if utilityViewer then
        for _, cdmFrame in ipairs(utilityViewer:GetItemFrames()) do
            if cdmFrame.Cooldown and cdmFrame.Icon then
                HookCooldownFrame(cdmFrame)
            end
        end
    end

    local buffViewer = _G["BuffIconCooldownViewer"]
    if buffViewer then
        for _, cdmFrame in ipairs(buffViewer:GetItemFrames()) do
            if cdmFrame.Cooldown and cdmFrame.Icon then
                HookBuffIconFrame(cdmFrame)
            end
        end
    end

    RefreshBuffBarColors()
    RefreshSettingsOverrideIndicators()
end

function CooldownStyle.GetTrackedStyleKey(cooldownID)
    local cooldownInfo = cooldownID and C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
    return GetStyleKeyFromCooldownInfo(cooldownInfo, true)
end

function CooldownStyle.RefreshCooldownFrames()
    RefreshChildFramesHook()
end

local viewers = {
    ["BuffIconCooldownViewer"] = BuffIconCooldownViewer,
    ["BuffBarCooldownViewer"] = BuffBarCooldownViewer,
    ["EssentialCooldownViewer"] = EssentialCooldownViewer,
    ["UtilityCooldownViewer"] = UtilityCooldownViewer,
}

local GLOW_UPDATE_DELAY = 0.05
local pendingGlowFrames = setmetatable({}, { __mode = "k" })
local glowUpdateScheduled = false
local allGlowsPending = false
local usabilityGlowsPending = false
local assistantGlowsPending = false

local function RefreshAllGlowsNow()
    for name in pairs(viewers) do
        local viewer = _G[name]
        if viewer then
            for _, cdmFrame in ipairs(ns.API:GetViewerItemFrames(viewer)) do
                if cdmFrame.GetCooldownInfo and ns.API:GetIsAffected(cdmFrame, "cooldownStyleHooked") then
                    UpdateButtonGlowState(cdmFrame)
                end
            end
        end
    end
end

local function RefreshSelectiveGlowsNow(reason, updated)
    for name in pairs(viewers) do
        local viewer = _G[name]
        if viewer then
            for _, cdmFrame in ipairs(ns.API:GetViewerItemFrames(viewer)) do
                if not updated[cdmFrame] and cdmFrame.GetCooldownInfo and ns.API:GetIsAffected(cdmFrame, "cooldownStyleHooked") then
                    local cooldownInfo = cdmFrame:GetCooldownInfo()
                    local styleKey = GetStyleKeyFromCooldownInfo(cooldownInfo, false)
                    local matches = reason == "usability"
                            and COOLDOWN_LIKE_CATEGORY[cooldownInfo and cooldownInfo.category]
                            and (CooldownStyle.GetGlowWhenReady(styleKey) or CooldownStyle.GetGlowOnFullCharges(styleKey))
                        or reason == "assistant" and CooldownStyle.GetGlowWhenSuggested(styleKey)
                    if matches then
                        updated[cdmFrame] = true
                        UpdateButtonGlowState(cdmFrame, cooldownInfo, styleKey)
                    end
                end
            end
        end
    end
end

local function FlushGlowUpdates()
    glowUpdateScheduled = false
    local refreshAll = allGlowsPending
    local refreshUsability = usabilityGlowsPending
    local refreshAssistant = assistantGlowsPending
    local pending = pendingGlowFrames
    allGlowsPending = false
    usabilityGlowsPending = false
    assistantGlowsPending = false
    pendingGlowFrames = setmetatable({}, { __mode = "k" })

    if refreshAll then
        RefreshAllGlowsNow()
        return
    end
    local updated = setmetatable({}, { __mode = "k" })
    for cdmFrame in pairs(pending) do
        if cdmFrame.GetCooldownInfo and ns.API:GetIsAffected(cdmFrame, "cooldownStyleHooked") then
            updated[cdmFrame] = true
            UpdateButtonGlowState(cdmFrame)
        end
    end
    if refreshUsability then
        RefreshSelectiveGlowsNow("usability", updated)
    end
    if refreshAssistant then
        RefreshSelectiveGlowsNow("assistant", updated)
    end
end

local function ScheduleGlowUpdateFlush()
    if glowUpdateScheduled then
        return
    end
    glowUpdateScheduled = true
    C_Timer.After(GLOW_UPDATE_DELAY, FlushGlowUpdates)
end

QueueGlowUpdate = function(cdmFrame)
    if not cdmFrame then
        return
    end
    pendingGlowFrames[cdmFrame] = true
    ScheduleGlowUpdateFlush()
end

local function QueueAllGlowUpdates()
    allGlowsPending = true
    ScheduleGlowUpdateFlush()
end

local function QueueUsabilityGlowUpdates()
    usabilityGlowsPending = true
    ScheduleGlowUpdateFlush()
end

local function QueueAssistantGlowUpdates()
    assistantGlowsPending = true
    ScheduleGlowUpdateFlush()
end

local function HideAllGlowsNow()
    local function hideFrames(frames)
        for _, cdmFrame in ipairs(frames) do
            CooldownStyle:HideFrameGlow(cdmFrame)
        end
    end

    for name in pairs(viewers) do
        local viewer = _G[name]
        if viewer then
            hideFrames(ns.API:GetViewerItemFrames(viewer))
        end
    end

    if ns.TrackerItemViewer and ns.TrackerItemViewer.GetActiveItemFrames then
        hideFrames(ns.TrackerItemViewer:GetActiveItemFrames())
    end
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.GetItemFrames then
        hideFrames(ns.EssentialCustomTracker:GetItemFrames())
    end
end

function CooldownStyle:HideAllGlows()
    HideAllGlowsNow()
end

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
        for _, viewer in pairs(viewers) do
            if parent == viewer then
                return current
            end
        end
        current = parent
    end
    return nil
end

local function HookActionButtonSpellAlertManager()
    if not ActionButtonSpellAlertManager then
        return
    end
    if ns.API:GetIsAffected(ActionButtonSpellAlertManager, "spellAlertHooked") then
        return
    end

    hooksecurefunc(ActionButtonSpellAlertManager, "ShowAlert", function(_, frame)
        local activeGlowTarget = GetCooldownViewerChild(frame)
        if not activeGlowTarget then
            return
        end
        if not CooldownStyle:CanShowGlows() then
            ActionButtonSpellAlertManager:HideAlert(frame)
            return
        end
        local styleKey = GetStyleKeyFromCooldownInfo(frame.cooldownInfo, false)
        if not styleKey then
            return
        end

        local affected = Affected(activeGlowTarget)
        if affected.procShown then
            return
        end
        affected.procShown = true
        UpdateButtonGlowState(activeGlowTarget)
    end)

    hooksecurefunc(ActionButtonSpellAlertManager, "HideAlert", function(_, frame)
        local activeGlowTarget = GetCooldownViewerChild(frame)
        if not activeGlowTarget then
            return
        end
        local affected = Affected(activeGlowTarget)
        if not affected.procShown then
            return
        end
        affected.procShown = nil
        UpdateButtonGlowState(activeGlowTarget)
    end)
    ns.API:SetAffected(ActionButtonSpellAlertManager, "spellAlertHooked")
end

function CooldownStyle:RefreshHooks()
    RefreshChildFramesHook()
    InstallBuffBarLayoutHook()
    InstallBarColorSettingsHook()
    InstallSettingsOverrideIndicatorHook()
end

function CooldownStyle:RefreshAllGlows()
    if IsGlowSuppressedByCombatSetting() then
        self:HideAllGlows()
        return
    end
    QueueAllGlowUpdates()
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshProcGlows then
        ns.TrackerItemViewer:RefreshProcGlows()
    end
end

function CooldownStyle:RefreshCombatGlowState()
    self:RefreshAllGlows()
end

function CooldownStyle:RefreshUsabilityGlows()
    QueueUsabilityGlowUpdates()
end

function CooldownStyle:RefreshSuggestedGlows()
    QueueAssistantGlowUpdates()
end

local glowUsabilityFrame
local function HookGlowUsabilityEvents()
    if glowUsabilityFrame then
        return
    end
    glowUsabilityFrame = CreateFrame("Frame")
    glowUsabilityFrame:RegisterEvent("SPELL_UPDATE_USABLE")
    glowUsabilityFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    glowUsabilityFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    glowUsabilityFrame:SetScript("OnEvent", function(_, event)
        if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
            CooldownStyle:RefreshAllGlows()
        else
            CooldownStyle:RefreshUsabilityGlows()
        end
    end)
end

local isMenuModified = false

function CooldownStyle.OpenEntryColorPicker(getColor, setColor, refresh, fallbackColor)
    local current = getColor and getColor() or nil
    local original = current and { current[1], current[2], current[3] } or nil
    local initial = current or fallbackColor or { 1, 1, 1 }
    local function applyRefresh()
        if refresh then
            refresh()
        end
    end
    ColorPickerFrame:SetupColorPickerAndShow({
        r = initial[1] or 1,
        g = initial[2] or 1,
        b = initial[3] or 1,
        hasOpacity = false,
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            setColor(r, g, b)
            applyRefresh()
        end,
        cancelFunc = function()
            if original then
                setColor(original[1], original[2], original[3])
            else
                setColor()
            end
            applyRefresh()
        end,
    })
end

local function SetStyleEntryColor(styleKey, field, r, g, b)
    if not styleKey then
        return
    end
    if r == nil then
        local settings = GetStoredStyleSettings(styleKey)
        if settings then
            settings[field] = nil
        end
        return
    end
    CooldownStyle.EnsureSpellSettings(styleKey)[field] = { r, g, b }
end

function CooldownStyle.GetStyleEntryColor(styleKey, field)
    return GetStoredRGB(GetStoredStyleSettings(styleKey), field)
end

function CooldownStyle.SetStyleEntryColor(styleKey, field, r, g, b)
    SetStyleEntryColor(styleKey, field, r, g, b)
end

function CooldownStyle.GetInheritedGlowColor()
    return GetConfiguredGlowColor() or DEFAULT_ENTRY_GLOW_COLOR
end

function CooldownStyle.AddMenuColorPreview(description, getColor, fallbackColor)
    description:AddInitializer(function(button)
        local color = getColor() or fallbackColor
        local border = button:AttachTexture()
        border:SetSize(16, 16)
        border:SetPoint("LEFT")
        border:SetColorTexture(0.05, 0.05, 0.05, 1)
        border:SetDrawLayer("ARTWORK", 1)

        local swatch = button:AttachTexture()
        swatch:SetSize(12, 12)
        swatch:SetPoint("CENTER", border, "CENTER")
        swatch:SetColorTexture(color[1] or 1, color[2] or 1, color[3] or 1, 1)
        swatch:SetDrawLayer("ARTWORK", 2)

        button.fontString:ClearAllPoints()
        button.fontString:SetPoint("LEFT", border, "RIGHT", 7, 0)
    end)
end

function CooldownStyle.AddMenuColorButton(menuDescription, label, getColor, setColor, refresh, fallbackColor)
    local button = menuDescription:CreateButton(label, function(_, menuInputData)
        if menuInputData and menuInputData.buttonName == "RightButton" then
            setColor()
            if refresh then
                refresh()
            end
            return MenuResponse.Refresh
        end
        CooldownStyle.OpenEntryColorPicker(getColor, setColor, refresh, fallbackColor)
    end)
    button:AddInitializer(function(frame)
        frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    end)
    button:AddResetter(function(frame)
        frame:RegisterForClicks("LeftButtonUp")
    end)
    CooldownStyle.AddMenuColorPreview(button, getColor, fallbackColor)
end

function CooldownStyle.AddGlobalGlowOnlyInCombatMenu(menuDescription)
    menuDescription:CreateDivider()
    menuDescription:CreateCheckbox("(Global) " .. L["Glows only in combat"], IsGlowOnlyInCombat, function()
        ns.db.profile.cooldownManager_glow_only_in_combat = not IsGlowOnlyInCombat()
        CooldownStyle:RefreshCombatGlowState()
    end)
end

function CooldownStyle.AddEntryColorMenu(rootDescription, styleKey, glowField, stackField, refresh)
    if not styleKey then
        return
    end
    local function RefreshEntryColors()
        if refresh then
            refresh()
        else
            RefreshChildFramesHook()
            RefreshSettingsOverrideIndicators()
        end
    end
    local function AddColor(field, label, fallbackColor)
        local function getColor()
            return GetStoredRGB(GetStoredStyleSettings(styleKey), field)
        end
        local function setColor(r, g, b)
            SetStyleEntryColor(styleKey, field, r, g, b)
        end
        CooldownStyle.AddMenuColorButton(rootDescription, label, getColor, setColor, RefreshEntryColors, fallbackColor)
    end

    AddColor(glowField, L["Set Glow Color"], CooldownStyle.GetInheritedGlowColor())
    AddColor(stackField, L["Set Number Color"], { 1, 1, 1 })
end

local function ParseAuraSpellIDInput(text)
    local value = tonumber(strtrim(text or ""))
    if not value or value < 0 or value ~= math.floor(value) then
        return nil
    end
    return value
end

local function SetAuraPopupAcceptEnabled(dialog, enabled)
    local acceptButton = dialog and _G[dialog:GetName() .. "Button1"]
    if acceptButton and acceptButton.SetEnabled then
        acceptButton:SetEnabled(enabled == true)
    end
end

local function ValidateAuraPopup(dialog)
    local editBox = dialog and (dialog.editBox or (dialog.GetEditBox and dialog:GetEditBox()))
    local value = editBox and ParseAuraSpellIDInput(editBox:GetText()) or nil
    SetAuraPopupAcceptEnabled(dialog, value ~= nil)
    return value
end

StaticPopupDialogs["CMC_SET_COOLDOWN_AURA"] = {
    text = string.format(L["Set Aura Spell ID. Enter 0 to clear.\n%s"], L["Current value: 0"]),
    button1 = _G.ACCEPT,
    button2 = _G.CANCEL,
    hasEditBox = true,
    maxLetters = 10,
    autoCompleteParams = nil,
    OnShow = function(self)
        local data = self.data
        local styleKey = type(data) == "table" and data.styleKey or data
        if styleKey == nil then
            self:Hide()
            return
        end
        local configuredValue = CooldownStyle.GetAuraSpellID(styleKey)
        local suggestedValue = type(data) == "table" and tonumber(data.defaultAuraSpellID) or nil
        if not suggestedValue or suggestedValue <= 0 or suggestedValue ~= math.floor(suggestedValue) then
            suggestedValue = nil
        end
        local editValue = configuredValue or suggestedValue or 0
        local textWidget = self.text or _G[self:GetName() .. "Text"]
        if textWidget then
            local valueLabel = configuredValue and string.format(L["Current value: %s"], configuredValue)
                or suggestedValue and string.format(L["Suggested value: %s"], suggestedValue)
                or L["Current value: 0"]
            textWidget:SetText(string.format(L["Set Aura Spell ID. Enter 0 to clear.\n%s"], valueLabel))
        end
        local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
        if editBox then
            editBox:SetText(tostring(editValue))
            editBox:HighlightText()
            editBox:SetFocus()
        end
        ValidateAuraPopup(self)
    end,
    OnAccept = function(self)
        local value = ValidateAuraPopup(self)
        local data = self.data
        local styleKey = type(data) == "table" and data.styleKey or data
        if styleKey == nil or value == nil then
            ns.Addon:Print(L["Aura Spell ID must be a non-negative whole number."])
            return
        end
        CooldownStyle.SetAuraSpellID(styleKey, value)
        CooldownStyle:RefreshHooks()
    end,
    EditBoxOnTextChanged = function(self)
        ValidateAuraPopup(self:GetParent())
    end,
    EditBoxOnEnterPressed = function(self)
        local popup = self:GetParent()
        if ValidateAuraPopup(popup) ~= nil then
            StaticPopup_OnClick(popup, 1)
        else
            ns.Addon:Print(L["Aura Spell ID must be a non-negative whole number."])
        end
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function CooldownStyle:Initialize()
    RefreshChildFramesHook()
    HookActionButtonSpellAlertManager()
    HookGlowUsabilityEvents()
    InstallBuffBarLayoutHook()
    InstallBarColorSettingsHook()
    InstallSettingsOverrideIndicatorHook()
    if isMenuModified then
        return
    end

    Menu.ModifyMenu("MENU_COOLDOWN_SETTINGS_ITEM", function(owner, rootDescription, _contextData)
        if InCombatLockdown() or not owner.GetCooldownInfo then
            return
        end
        local cdInfo = owner:GetCooldownInfo()
        if not cdInfo then
            return
        end
        local category = cdInfo.category
        -- Settings key: base spellID (first tab) / most-specific override spellID
        -- (second tab) for normal cooldowns; the slot's stable cooldownID for
        -- 12.1.0 dynamic item/spell-category icons. See GetStyleKeyFromCooldownInfo.
        local baseKey = GetStyleKeyFromCooldownInfo(cdInfo, false)
        local overrideKey = GetStyleKeyFromCooldownInfo(cdInfo, true)

        rootDescription:CreateDivider()
        rootDescription:CreateTitle(MENU_TITLE)

        local cooldownMenu
        local glowColorMenu
        if COOLDOWN_LIKE_CATEGORY[category] or TRACKED_LIKE_CATEGORY[category] then
            cooldownMenu = rootDescription:CreateButton(L["Cooldown"])
            glowColorMenu = rootDescription:CreateButton(L["Glow & Color"])
        end

        --[[ category:

        -1 HiddenSpell,
        0 Essential,
        1 Utility,

        -2 HiddenAura,
        2 TrackedBuff,
        3 TrackedBar.
        ]]
        local customAuraSpellID = CooldownStyle.GetAuraSpellID(baseKey)
        if cdInfo.hasAura or cdInfo.selfAura then
            if COOLDOWN_LIKE_CATEGORY[category] then
                cooldownMenu:CreateCheckbox(L["Hide Aura"], function()
                    return not CooldownStyle.GetShowAuras(baseKey)
                end, function()
                    CooldownStyle.ToggleShowAuras(baseKey)
                    RefreshChildFramesHook()
                end)
            end

            if COOLDOWN_LIKE_CATEGORY[category] then
                cooldownMenu:CreateCheckbox(L["Reversed Aura Swipe"], function()
                    return CooldownStyle.GetReverseAuraSwipe(baseKey)
                end, function()
                    CooldownStyle.ToggleReverseAuraSwipe(baseKey)
                    RefreshChildFramesHook()
                end)
            end
        elseif COOLDOWN_LIKE_CATEGORY[category] and ns.AuraTracking and ns.AuraTracking:IsSupported() then
            local label = customAuraSpellID and string.format(L["Set Aura (id: %s)"], customAuraSpellID) or L["Set Aura"]
            cooldownMenu:CreateButton(label, function()
                StaticPopup_Show("CMC_SET_COOLDOWN_AURA", nil, nil, {
                    styleKey = baseKey,
                    defaultAuraSpellID = GetBaseSpellIDFromCooldownInfo(cdInfo),
                })
            end)

            if customAuraSpellID then
                cooldownMenu:CreateCheckbox(L["Reversed Aura Swipe"], function()
                    return CooldownStyle.GetReverseAuraSwipe(baseKey)
                end, function()
                    CooldownStyle.ToggleReverseAuraSwipe(baseKey)
                    RefreshChildFramesHook()
                end)
            end
        end

        if COOLDOWN_LIKE_CATEGORY[category] then
            local categorySetting = ALWAYS_SATURATED_CATEGORY_SETTING[category]
            if not GetAlwaysSaturatedCategorySetting(category) then
                cooldownMenu:CreateCheckbox(L["Always Saturated"], function()
                    return CooldownStyle.GetNeverDesaturate(baseKey, category)
                end, function()
                    CooldownStyle.ToggleNeverDesaturate(baseKey)
                    RefreshChildFramesHook()
                end)
            end

            cooldownMenu:CreateCheckbox(L["Always Desaturated"], function()
                return CooldownStyle.GetAlwaysDesaturate(baseKey)
            end, function()
                CooldownStyle.ToggleAlwaysDesaturate(baseKey)
                RefreshChildFramesHook()
            end)

            if categorySetting then
                cooldownMenu:CreateCheckbox(string.format(L["Always Saturated (All %s)"], categorySetting.label), function()
                    return GetAlwaysSaturatedCategorySetting(category)
                end, function()
                    ns.db.profile[categorySetting.key] = not GetAlwaysSaturatedCategorySetting(category)
                    RefreshChildFramesHook()
                end)
            end

            cooldownMenu:CreateCheckbox(L["Forced Cooldown Edge"], function()
                return CooldownStyle.GetAlwaysShowCooldownEdge(baseKey)
            end, function()
                CooldownStyle.ToggleAlwaysShowCooldownEdge(baseKey)
                RefreshChildFramesHook()
            end)

            glowColorMenu:CreateCheckbox(L["Proc Glow"], function()
                return not CooldownStyle.GetDisableProcsGlow(baseKey)
            end, function()
                CooldownStyle.ToggleDisableProcsGlow(baseKey)
                RefreshSettingsOverrideIndicators()
            end)

            glowColorMenu:CreateCheckbox(L["Glow when Ready"], function()
                return CooldownStyle.GetGlowWhenReady(baseKey)
            end, function()
                CooldownStyle.ToggleGlowWhenReady(baseKey)
                RefreshChildFramesHook()
            end)
            if cdInfo.hasAura or cdInfo.selfAura or customAuraSpellID then
                glowColorMenu:CreateCheckbox(L["Glow when Aura Active"], function()
                    return CooldownStyle.GetGlowWhenAuraActive(baseKey)
                end, function()
                    CooldownStyle.ToggleGlowWhenAuraActive(baseKey)
                    RefreshChildFramesHook()
                end)
            end
            if GetMostOverrideSpellIDFromCooldownInfo(cdInfo) then
                glowColorMenu:CreateCheckbox(L["Glow when Suggested"], function()
                    return CooldownStyle.GetGlowWhenSuggested(baseKey)
                end, function()
                    CooldownStyle.ToggleGlowWhenSuggested(baseKey)
                    if ns.Assistant then
                        ns.Assistant:RefreshSuggestionTracking()
                    end
                    RefreshChildFramesHook()
                end)
            end
            if cdInfo.charges then
                glowColorMenu:CreateCheckbox(L["Glow when full charges"], function()
                    return CooldownStyle.GetGlowOnFullCharges(baseKey)
                end, function()
                    CooldownStyle.ToggleGlowOnFullCharges(baseKey)
                    RefreshChildFramesHook()
                end)
            end
            if ns.ReadyAlerts then
                ns.ReadyAlerts:AddMenu(rootDescription, baseKey)
            end
        end

        if TRACKED_LIKE_CATEGORY[category] then
            cooldownMenu:CreateCheckbox(L["Forced Cooldown Edge"], function()
                return CooldownStyle.GetTrackedAlwaysShowCooldownEdge(overrideKey)
            end, function()
                CooldownStyle.ToggleTrackedAlwaysShowCooldownEdge(overrideKey)
                RefreshChildFramesHook()
            end)

            glowColorMenu:CreateCheckbox(L["Always Glow"], function()
                return CooldownStyle.GetAlwaysGlow(overrideKey)
            end, function()
                CooldownStyle.ToggleAlwaysGlow(overrideKey)
                RefreshChildFramesHook()
                RefreshSettingsOverrideIndicators()
            end)
        end

        if COOLDOWN_LIKE_CATEGORY[category] then
            CooldownStyle.AddEntryColorMenu(glowColorMenu, baseKey, "cooldownGlowColor", "cooldownStackColor")
        elseif TRACKED_LIKE_CATEGORY[category] then
            CooldownStyle.AddEntryColorMenu(glowColorMenu, overrideKey, "trackedGlowColor", "trackedStackColor")
        end
        CooldownStyle.AddGlobalGlowOnlyInCombatMenu(glowColorMenu)

        rootDescription:CreateButton(L["Reset to Defaults"], function()
            local db = CooldownStyle.GetDB()
            local styleKey
            if COOLDOWN_LIKE_CATEGORY[category] then
                styleKey = baseKey
                local settings = db.spellSettings[styleKey]
                if settings then
                    settings.alwaysShowCooldownEdge = nil
                    settings.showAuras = nil
                    settings.reverseAuraSwipe = nil
                    settings.disableProcsGlow = nil
                    settings.glowWhenReady = nil
                    settings.glowOnFullCharges = nil
                    settings.glowWhenAuraActive = nil
                    settings.glowWhenSuggested = nil
                    settings.cooldownGlowColor = nil
                    settings.cooldownStackColor = nil
                    settings.neverDesaturate = nil
                    settings.auraSpellID = nil
                    if ns.ReadyAlerts then
                        ns.ReadyAlerts:Reset(styleKey)
                    end
                end
            elseif TRACKED_LIKE_CATEGORY[category] then
                styleKey = overrideKey
                local settings = db.spellSettings[styleKey]
                if settings then
                    settings.trackedAlwaysShowCooldownEdge = nil
                    settings.alwaysGlow = nil
                    settings.trackedGlowColor = nil
                    settings.trackedStackColor = nil
                end
            elseif BAR_LIKE_CATEGORY[category] then
                styleKey = overrideKey
                local settings = db.spellSettings[styleKey]
                if settings then
                    settings.barColor = nil
                end
            end
            if styleKey and db.spellSettings[styleKey] and next(db.spellSettings[styleKey]) == nil then
                db.spellSettings[styleKey] = nil
            end
            RefreshChildFramesHook()
            RefreshSettingsOverrideIndicators()
            if ns.Assistant then
                ns.Assistant:RefreshSuggestionTracking()
            end
        end)
    end)
    isMenuModified = true
end
function CooldownStyle.GetDB()
    return ns.db.profile.cooldownStyleSettings
end

function CooldownStyle.GetSpellSettings(spellID)
    local db = ns.db.profile.cooldownStyleSettings
    if not db or not db.spellSettings or db.spellSettings[spellID] == nil then
        return nil
    end
    return db.spellSettings[spellID]
end

function CooldownStyle.GetAuraSpellID(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    local auraSpellID = settings and tonumber(settings.auraSpellID) or nil
    if auraSpellID and auraSpellID > 0 and auraSpellID == math.floor(auraSpellID) then
        return auraSpellID
    end
    return nil
end

function CooldownStyle.SetAuraSpellID(spellID, auraSpellID)
    if spellID == nil then
        return false
    end
    auraSpellID = tonumber(auraSpellID)
    if not auraSpellID or auraSpellID < 0 or auraSpellID ~= math.floor(auraSpellID) then
        return false
    end
    if auraSpellID == 0 then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings then
            settings.auraSpellID = nil
        end
    else
        CooldownStyle.EnsureSpellSettings(spellID).auraSpellID = auraSpellID
    end
    return true
end

function CooldownStyle.EnsureSpellSettings(spellID)
    -- Backstop: every caller should pass a stable styleKey (spellID or
    -- "cd:"..cooldownID). A nil key means an unresolved icon slipped through;
    -- hand back a throwaway table so writes no-op instead of erroring.
    if spellID == nil then
        return {}
    end
    local db = ns.db.profile.cooldownStyleSettings
    if db.spellSettings[spellID] == nil then
        db.spellSettings[spellID] = {}
    end
    return db.spellSettings[spellID]
end

function CooldownStyle.GetAlwaysShowCooldownEdge(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.alwaysShowCooldownEdge ~= nil then
        return settings.alwaysShowCooldownEdge
    end
    return DEFAULT_ALWAYS_SHOW_COOLDOWN_EDGE
end

function CooldownStyle.SetAlwaysShowCooldownEdge(spellID, value)
    if value == DEFAULT_ALWAYS_SHOW_COOLDOWN_EDGE then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.alwaysShowCooldownEdge = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.alwaysShowCooldownEdge = value
end

function CooldownStyle.ToggleAlwaysShowCooldownEdge(spellID)
    local current = CooldownStyle.GetAlwaysShowCooldownEdge(spellID)
    CooldownStyle.SetAlwaysShowCooldownEdge(spellID, not current)
end

function CooldownStyle.GetTrackedAlwaysShowCooldownEdge(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    return settings and settings.trackedAlwaysShowCooldownEdge == true or false
end

function CooldownStyle.SetTrackedAlwaysShowCooldownEdge(spellID, value)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if not value then
        if settings then
            settings.trackedAlwaysShowCooldownEdge = nil
        end
        return
    end
    CooldownStyle.EnsureSpellSettings(spellID).trackedAlwaysShowCooldownEdge = true
end

function CooldownStyle.ToggleTrackedAlwaysShowCooldownEdge(spellID)
    CooldownStyle.SetTrackedAlwaysShowCooldownEdge(spellID, not CooldownStyle.GetTrackedAlwaysShowCooldownEdge(spellID))
end

function CooldownStyle.GetShowAuras(spellID)
    if spellID == nil then
        return DEFAULT_SHOW_AURAS
    end
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.showAuras ~= nil then
        return settings.showAuras
    end
    return DEFAULT_SHOW_AURAS
end

function CooldownStyle.SetShowAuras(spellID, value)
    if value == DEFAULT_SHOW_AURAS then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.showAuras = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.showAuras = value
end

function CooldownStyle.ToggleShowAuras(spellID)
    local current = CooldownStyle.GetShowAuras(spellID)
    CooldownStyle.SetShowAuras(spellID, not current)
end

function CooldownStyle.GetReverseAuraSwipe(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.reverseAuraSwipe ~= nil then
        return settings.reverseAuraSwipe
    end
    return DEFAULT_REVERSE_AURA_SWIPE
end

function CooldownStyle.SetReverseAuraSwipe(spellID, value)
    if value == DEFAULT_REVERSE_AURA_SWIPE then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.reverseAuraSwipe = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.reverseAuraSwipe = value
end

function CooldownStyle.ToggleReverseAuraSwipe(spellID)
    local current = CooldownStyle.GetReverseAuraSwipe(spellID)
    CooldownStyle.SetReverseAuraSwipe(spellID, not current)
end

function CooldownStyle.GetDisableProcsGlow(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.disableProcsGlow ~= nil then
        return settings.disableProcsGlow
    end
    return DEFAULT_DISABLE_PROCS_GLOW
end

function CooldownStyle.SetDisableProcsGlow(spellID, value)
    if value == DEFAULT_DISABLE_PROCS_GLOW then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.disableProcsGlow = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.disableProcsGlow = value
end

function CooldownStyle.ToggleDisableProcsGlow(spellID)
    local current = CooldownStyle.GetDisableProcsGlow(spellID)
    CooldownStyle.SetDisableProcsGlow(spellID, not current)
end

function CooldownStyle.GetGlowWhenReady(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.glowWhenReady ~= nil then
        return settings.glowWhenReady
    end
    return DEFAULT_GLOW_WHEN_READY
end

function CooldownStyle.SetGlowWhenReady(spellID, value)
    if value == DEFAULT_GLOW_WHEN_READY then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.glowWhenReady = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.glowWhenReady = value
end

function CooldownStyle.ToggleGlowWhenReady(spellID)
    local current = CooldownStyle.GetGlowWhenReady(spellID)
    CooldownStyle.SetGlowWhenReady(spellID, not current)
end

function CooldownStyle.GetGlowOnFullCharges(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.glowOnFullCharges ~= nil then
        return settings.glowOnFullCharges
    end
    return DEFAULT_GLOW_ON_FULL_CHARGES
end

function CooldownStyle.SetGlowOnFullCharges(spellID, value)
    if value == DEFAULT_GLOW_ON_FULL_CHARGES then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.glowOnFullCharges = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.glowOnFullCharges = value
end

function CooldownStyle.ToggleGlowOnFullCharges(spellID)
    local current = CooldownStyle.GetGlowOnFullCharges(spellID)
    CooldownStyle.SetGlowOnFullCharges(spellID, not current)
end

function CooldownStyle.GetGlowWhenAuraActive(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.glowWhenAuraActive ~= nil then
        return settings.glowWhenAuraActive
    end
    return DEFAULT_GLOW_WHEN_AURA_ACTIVE
end

function CooldownStyle.SetGlowWhenAuraActive(spellID, value)
    if value == DEFAULT_GLOW_WHEN_AURA_ACTIVE then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.glowWhenAuraActive = nil
        end
        return
    end

    CooldownStyle.EnsureSpellSettings(spellID).glowWhenAuraActive = value
end

function CooldownStyle.ToggleGlowWhenAuraActive(spellID)
    CooldownStyle.SetGlowWhenAuraActive(spellID, not CooldownStyle.GetGlowWhenAuraActive(spellID))
end

function CooldownStyle.GetGlowWhenSuggested(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.glowWhenSuggested ~= nil then
        return settings.glowWhenSuggested
    end
    return DEFAULT_GLOW_WHEN_SUGGESTED
end

function CooldownStyle.SetGlowWhenSuggested(spellID, value)
    if value == DEFAULT_GLOW_WHEN_SUGGESTED then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.glowWhenSuggested = nil
        end
        return
    end

    CooldownStyle.EnsureSpellSettings(spellID).glowWhenSuggested = value
end

function CooldownStyle.ToggleGlowWhenSuggested(spellID)
    CooldownStyle.SetGlowWhenSuggested(spellID, not CooldownStyle.GetGlowWhenSuggested(spellID))
end

function CooldownStyle.GetAlwaysGlow(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.alwaysGlow ~= nil then
        return settings.alwaysGlow
    end
    return DEFAULT_ALWAYS_GLOW
end

function CooldownStyle.SetAlwaysGlow(spellID, value)
    if value == DEFAULT_ALWAYS_GLOW then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.alwaysGlow = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.alwaysGlow = value
end

function CooldownStyle.ToggleAlwaysGlow(spellID)
    local current = CooldownStyle.GetAlwaysGlow(spellID)
    CooldownStyle.SetAlwaysGlow(spellID, not current)
end

-- Bar fill color is stored per spell in settings.barColor: nil leaves Blizzard's
-- color, { r, g, b } is a custom fill chosen with the color picker.
function CooldownStyle.SetBarColorCustom(spellID, r, g, b)
    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.barColor = { r, g, b }
end

function CooldownStyle.ClearBarColor(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings ~= nil then
        settings.barColor = nil
    end
end

function CooldownStyle.GetNeverDesaturate(spellID, category)
    if GetAlwaysSaturatedCategorySetting(category) then
        return true
    end
    local settings = CooldownStyle.GetSpellSettings(spellID)
    if settings and settings.neverDesaturate ~= nil then
        return settings.neverDesaturate
    end
    return DEFAULT_NEVER_DESATURATE
end

function CooldownStyle.SetNeverDesaturate(spellID, value)
    if value == DEFAULT_NEVER_DESATURATE then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.neverDesaturate = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.neverDesaturate = value
end

function CooldownStyle.ToggleNeverDesaturate(spellID)
    local current = CooldownStyle.GetNeverDesaturate(spellID)
    CooldownStyle.SetNeverDesaturate(spellID, not current)
end

function CooldownStyle.GetAlwaysDesaturate(spellID)
    local settings = CooldownStyle.GetSpellSettings(spellID)
    return settings and settings.alwaysDesaturate == true or false
end

function CooldownStyle.SetAlwaysDesaturate(spellID, value)
    if not value then
        local settings = CooldownStyle.GetSpellSettings(spellID)
        if settings ~= nil then
            settings.alwaysDesaturate = nil
        end
        return
    end

    local settings = CooldownStyle.EnsureSpellSettings(spellID)
    settings.alwaysDesaturate = true
end

function CooldownStyle.ToggleAlwaysDesaturate(spellID)
    CooldownStyle.SetAlwaysDesaturate(spellID, not CooldownStyle.GetAlwaysDesaturate(spellID))
end
