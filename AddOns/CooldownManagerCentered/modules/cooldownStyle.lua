local addonName, ns = ...

local MiscPanel = ns.MiscPanel

local CooldownStyle = ns.CooldownStyle or {}
ns.CooldownStyle = CooldownStyle
local MENU_TITLE = "|cff008945C|r|cff1e9a4eo|r|cff3faa4fol|r|cff5fb64ado|r|cff7ac243wn|r |cff8ccd00Manager Centered|r"
local GCD_SPELL_ID = 61304

local DEFAULT_ALWAYS_SHOW_COOLDOWN_EDGE = false
local DEFAULT_SHOW_AURAS = true
local DEFAULT_DISABLE_PROCS_GLOW = false
local DEFAULT_REVERSE_AURA_SWIPE = false
local DEFAULT_GLOW_WHEN_READY = false
local DEFAULT_GLOW_ON_FULL_CHARGES = false
local DEFAULT_ALWAYS_GLOW = false
local DEFAULT_NEVER_DESATURATE = false

local LCG = LibStub("LibCustomGlow-1.0")
local GLOW_STYLE_DEFAULT = "DEFAULT"
local GLOW_STYLE_PROC = "PROC"
local GLOW_STYLE_AUTOCAST = "AUTOCAST"
local GLOW_STYLE_PIXEL = "PIXEL"

local desaturationCurve = C_CurveUtil.CreateCurve()
desaturationCurve:AddPoint(0, 0)
desaturationCurve:AddPoint(0.001, 1)

local isZeroCurve = C_CurveUtil.CreateCurve()
isZeroCurve:AddPoint(0, 1)
isZeroCurve:AddPoint(0.001, 0)

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

local function StopAllCustomGlows(frame)
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

CooldownStyle.FORCE_DISABLED_INSTANT_CASTS = {
    -- Druid
    [8921] = true, -- Moonfire
    [93402] = true, -- Sunfire
    [191034] = true, -- Starfall

    -- Warlock
    [980] = true, -- Agony
    [172] = true, -- Corruption
    [348] = true, -- Immolate
    [5740] = true, -- Rain of Fire
    [1214467] = true, -- Raid of Fire
    [316099] = true, -- Unstable Affliction
    [1259790] = true, -- Unstable Affliction
    [17877] = true, -- Shadowburn

    -- Priest
    [589] = true, -- Shadow Word: Pain
    [34914] = true, -- Vampiric Touch
    [15407] = true, -- Mind Flay,
    [335467] = true, -- Shadow Word: Madness
}

-- local FIX_BLIZZARD_MISSING_DEBUFF = {
--     [204596] = true, -- Sigil of Flame
--     [207684] = true, -- Sigil of Misery
--     [202137] = true, -- Sigil of Silence
-- }
local function GetCooldownFrames()
    local frames = {}

    local essentialViewer = _G["EssentialCooldownViewer"]
    if essentialViewer then
        for _, child in ipairs({ essentialViewer:GetChildren() }) do
            if child.Cooldown then
                table.insert(frames, child)
            end
        end
    end

    local utilityViewer = _G["UtilityCooldownViewer"]
    if utilityViewer then
        for _, child in ipairs({ utilityViewer:GetChildren() }) do
            if child.Cooldown then
                table.insert(frames, child)
            end
        end
    end

    return frames
end

local function GetBuffIconFrames()
    local frames = {}

    local buffViewer = _G["BuffIconCooldownViewer"]
    if buffViewer then
        for _, child in ipairs({ buffViewer:GetChildren() }) do
            if child.Cooldown then
                table.insert(frames, child)
            end
        end
    end

    return frames
end

local function GetButtonGlowFrame(cdmFrame)
    if cdmFrame._ProcGlow then
        return cdmFrame._ProcGlow
    end
    if cdmFrame._AutoCastGlow then
        return cdmFrame._AutoCastGlow
    end
    if cdmFrame._PixelGlow then
        return cdmFrame._PixelGlow
    end
    -- action button glow is broken - please remember to ignore it
    return nil
end

local function SetButtonGlow(cdmFrame, shouldGlow)
    if shouldGlow then
        local signature = GetGlowSignature(GLOW_STYLE_PROC)
        if cdmFrame._CMC_CustomGlowing and cdmFrame._CMC_CustomGlowSignature == signature then
            return
        end
        StopAllCustomGlows(cdmFrame)
        cdmFrame._CMC_CustomGlowing = true
        cdmFrame._CMC_CustomGlowStyle = StartConfiguredGlow(cdmFrame, GLOW_STYLE_PROC)
        cdmFrame._CMC_CustomGlowSignature = signature
    else
        if not cdmFrame._CMC_CustomGlowing then
            return
        end
        cdmFrame._CMC_CustomGlowing = false
        cdmFrame._CMC_CustomGlowStyle = nil
        cdmFrame._CMC_CustomGlowSignature = nil
        StopAllCustomGlows(cdmFrame)
    end
end

local function EnsureButtonGlowFrame(cdmFrame)
    local glowFrame = GetButtonGlowFrame(cdmFrame)
    if glowFrame then
        return glowFrame
    end
    SetButtonGlow(cdmFrame, true)
    return GetButtonGlowFrame(cdmFrame)
end

local function UpdateButtonGlowState(cdmFrame, value)
    local cooldownInfo = cdmFrame:GetCooldownInfo()
    if cooldownInfo == nil then
        SetButtonGlow(cdmFrame, false)
        return
    end

    if cooldownInfo.category == 0 or cooldownInfo.category == 1 then
        if cooldownInfo.charges and CooldownStyle.GetGlowOnFullCharges(cooldownInfo.spellID) then
            local glow = EnsureButtonGlowFrame(cdmFrame)
            if ns.db.profile.cooldownManager_hide_glow_on_active_aura and cdmFrame.wasSetFromAura then
                if glow then
                    glow:SetAlpha(0)
                end
                return
            end
            local spellID = cooldownInfo.overrideSpellID or cooldownInfo.spellID
            local cooldownDuration = C_Spell.GetSpellChargeDuration(spellID)
            local alpha = cooldownDuration:EvaluateRemainingDuration(isZeroCurve)
            glow:SetAlpha(alpha)
            return
        end
        if not CooldownStyle.GetGlowWhenReady(cooldownInfo.spellID) then
            SetButtonGlow(cdmFrame, false)
            return
        end
        local glow = EnsureButtonGlowFrame(cdmFrame)
        if issecretvalue(value) or value ~= nil then
            if glow then
                glow:SetAlphaFromBoolean(value, 0, 1)
            end
            return
        end

        if ns.db.profile.cooldownManager_hide_glow_on_active_aura and cdmFrame.wasSetFromAura then
            if glow then
                glow:SetAlpha(0)
            end
            return
        end

        local spellID = cooldownInfo.overrideSpellID or cooldownInfo.spellID
        local cooldown = C_Spell.GetSpellCooldown(spellID)
        if cooldown.isOnGCD then
            SetButtonGlow(cdmFrame, true)
            if glow then
                glow:SetAlpha(1)
            end
            return
        end
        local cooldownDuration = C_Spell.GetSpellCooldownDuration(spellID)
        local alpha = cooldownDuration:EvaluateRemainingDuration(isZeroCurve)
        if glow then
            glow:SetAlpha(alpha)
        end
        return
    end

    if cooldownInfo.category == 2 then
        SetButtonGlow(cdmFrame, CooldownStyle.GetAlwaysGlow(cooldownInfo.spellID))
        return
    end

    SetButtonGlow(cdmFrame, false)
end

local function ApplyIconSettings(cdmFrame)
    local cooldownInfo = cdmFrame:GetCooldownInfo()
    if cooldownInfo == nil then
        return
    end

    local spellID = cooldownInfo.overrideSpellID or cooldownInfo.spellID
    if not spellID then
        return
    end

    local baseSpellId = cooldownInfo.spellID

    local shouldShowAuras = true
    if not CooldownStyle.GetShowAuras(baseSpellId) then
        shouldShowAuras = false
    end

    local spellCharges = C_Spell.GetSpellCharges(spellID)
    local hasCharges = spellCharges and spellCharges.maxCharges > 1
    if shouldShowAuras and cdmFrame.wasSetFromAura then
        cdmFrame.Cooldown:SetDrawSwipe(cdmFrame.cooldownShowSwipe == true)
        if ns.db.profile.cooldownManager_desaturate_under_aura then
            if hasCharges then
                -- WATCH OUT FOR INFINITE LOOP, SetDesaturated != SetDesaturation
                cdmFrame.__self_desaturated = true
                cdmFrame.Icon:SetDesaturated(cdmFrame.isOnActualCooldown)
            else
                cdmFrame.Icon:SetDesaturation(1)
            end
        else
            cdmFrame.Icon:SetDesaturation(0)
        end
        return
    end

    local shouldNeverDesaturate = CooldownStyle.GetNeverDesaturate(baseSpellId)
    if shouldNeverDesaturate then
        cdmFrame.Icon:SetDesaturation(0)
    elseif cdmFrame._CMCTracker_Desaturation ~= nil then
        cdmFrame.Icon:SetDesaturation(cdmFrame._CMCTracker_Desaturation)
    end

    local guesstimateThatSpellWithChargesIsOnChargeCooldown = cdmFrame.CooldownFlash
        and cdmFrame.CooldownFlash:IsShown()
    if cdmFrame.wasSetFromAura then
        if hasCharges then
            --[[
            TODO  check new blizzard changes:
            Action/Spell cooldown APIs now return isEnabled and maxCharges as non-secrets.
            Action/Spell cooldown APIs now return a new non-secret isActive boolean
            ]]

            local flashIsShown = guesstimateThatSpellWithChargesIsOnChargeCooldown
            cdmFrame.Cooldown:SetDrawSwipe(flashIsShown)
            cdmFrame.Cooldown:SetDrawEdge(not flashIsShown or CooldownStyle.GetAlwaysShowCooldownEdge(baseSpellId))
        else
            cdmFrame.Cooldown:SetDrawSwipe(true)
        end
    end
end

local function GetCustomActiveSwipe()
    local r = ns.db.profile.cooldownManager_customActiveColor_r or 1
    local g = ns.db.profile.cooldownManager_customActiveColor_g or 0.95
    local b = ns.db.profile.cooldownManager_customActiveColor_b or 0.57
    local a = ns.db.profile.cooldownManager_customActiveColor_a or 0.69
    return r, g, b, a
end

local function GetCustomGCDSwipe()
    local r = ns.db.profile.cooldownManager_customCDSwipeColor_r or 0
    local g = ns.db.profile.cooldownManager_customCDSwipeColor_g or 0
    local b = ns.db.profile.cooldownManager_customCDSwipeColor_b or 0
    local a = ns.db.profile.cooldownManager_customCDSwipeColor_a or 0.69
    return r, g, b, a
end

local function ApplyCooldownSettings(cdmFrame)
    local cooldownInfo = cdmFrame:GetCooldownInfo()
    if cooldownInfo == nil then
        return
    end

    local spellID = cooldownInfo.overrideSpellID or cooldownInfo.spellID

    if not spellID then
        return
    end
    local baseSpellId = cooldownInfo.spellID
    local shouldShowAuras = true
    if not CooldownStyle.GetShowAuras(baseSpellId) then
        shouldShowAuras = false
    end

    if CooldownStyle.GetAlwaysShowCooldownEdge(baseSpellId) then
        cdmFrame.Cooldown:SetDrawEdge(true)
    end

    if shouldShowAuras and cdmFrame.wasSetFromAura then
        cdmFrame.Cooldown:SetReverse(CooldownStyle.GetReverseAuraSwipe(baseSpellId))
        if ns.db.profile.cooldownManager_customSwipeColor_enabled then
            local _r, _g, _b, _a = GetCustomActiveSwipe()
            cdmFrame.Cooldown:SetSwipeColor(_r, _g, _b, _a)
        end
        if ns.db.profile.cooldownManager_desaturate_under_aura then
            local spellCharges = C_Spell.GetSpellCharges(spellID)

            local hasCharges = spellCharges and spellCharges.maxCharges > 1
            if hasCharges then
                -- DevTool:AddData(cdmFrame)
                -- WATCH OUT FOR INFINITE LOOP, SetDesaturated != SetDesaturation
                cdmFrame.__self_desaturated = true
                cdmFrame.Icon:SetDesaturated(cdmFrame.isOnActualCooldown)
            else
                cdmFrame.Icon:SetDesaturation(1)
            end
        end
        return
    end
    local shouldHideAuras = not shouldShowAuras and cdmFrame.wasSetFromAura
    cdmFrame.Cooldown:SetReverse(false)

    if ns.db.profile.cooldownManager_customSwipeColor_enabled then
        local _r, _g, _b, _a = GetCustomGCDSwipe()
        cdmFrame.Cooldown:SetSwipeColor(_r, _g, _b, _a)
    else
        -- from CooldownViewerConstants.ITEM_COOLDOWN_COLOR
        cdmFrame.Cooldown:SetSwipeColor(0, 0, 0, 0.7)
    end

    local cooldown = C_Spell.GetSpellCooldown(spellID)

    cdmFrame._CMCTracker_Desaturation = nil

    local guesstimateThatSpellWithChargesIsOnChargeCooldown = cdmFrame.CooldownFlash
        and cdmFrame.CooldownFlash:IsShown()

    if shouldHideAuras and CooldownStyle.FORCE_DISABLED_INSTANT_CASTS[baseSpellId] then
        if cooldown.isOnGCD and not ns.db.profile.cooldownManager_hide_gcd then
            local cooldownDuration = C_Spell.GetSpellCooldownDuration(GCD_SPELL_ID)
            cdmFrame.Cooldown:SetCooldownFromDurationObject(cooldownDuration)
        else
            cdmFrame.Cooldown:SetCooldownFromDurationObject(C_DurationUtil.CreateDuration())
        end
    elseif shouldHideAuras then
        if cooldown.isOnGCD then
            if ns.db.profile.cooldownManager_hide_gcd then
                if guesstimateThatSpellWithChargesIsOnChargeCooldown then
                -- This case is a bit weird, if the spell potentially has charges and is on GCD,
                -- but we are not sure if charge duration isn't bigger than gcd
                -- but we guesstimate based on CooldownFlash that spell is on cooldown, so we show cooldown as normal
                else
                    cdmFrame.Cooldown:SetCooldownFromDurationObject(C_DurationUtil.CreateDuration())
                end
            else
                cdmFrame.Cooldown:SetCooldownFromDurationObject(C_Spell.GetSpellCooldownDuration(GCD_SPELL_ID))
            end
        else
            if C_Spell.GetSpellCharges(spellID) then
                cdmFrame._CMCTracker_Desaturation = 1
                cdmFrame.Cooldown:SetCooldownFromDurationObject(C_Spell.GetSpellChargeDuration(spellID))
            else
                local cooldownDuration = C_Spell.GetSpellCooldownDuration(spellID)
                cdmFrame.Cooldown:SetCooldownFromDurationObject(cooldownDuration)
                cdmFrame._CMCTracker_Desaturation = cooldownDuration:EvaluateRemainingDuration(desaturationCurve)
            end
        end
    elseif cooldown.isOnGCD and ns.db.profile.cooldownManager_hide_gcd then
        if guesstimateThatSpellWithChargesIsOnChargeCooldown then
            -- This case is a bit weird, if the spell potentially has charges and is on GCD,
            -- but we are not sure if charge duration isn't bigger than gcd
            -- but we guesstimate based on CooldownFlash that spell is on cooldown, so we show cooldown as normal
        else
            cdmFrame.Cooldown:SetCooldownFromDurationObject(C_DurationUtil.CreateDuration())
        end
    end

    ApplyIconSettings(cdmFrame)
end

local function HookCooldownFrame(cdmFrame)
    if cdmFrame.Cooldown == nil or cdmFrame.Icon == nil then
        return
    end

    UpdateButtonGlowState(cdmFrame)
    ApplyCooldownSettings(cdmFrame)

    if cdmFrame._CMCTracker_Hooked then
        return
    end

    cdmFrame._CMCTracker_Hooked = true

    -- local cooldownInfo = cdmFrame:GetCooldownInfo()

    hooksecurefunc(cdmFrame.Cooldown, "SetCooldown", function(self)
        local cdmFrame = self:GetParent()
        UpdateButtonGlowState(cdmFrame)
        ApplyCooldownSettings(cdmFrame)
    end)

    hooksecurefunc(cdmFrame.Cooldown, "Clear", function(self)
        local cdmFrame = self:GetParent()
        UpdateButtonGlowState(cdmFrame)
    end)

    hooksecurefunc(cdmFrame.Icon, "SetDesaturated", function(self, secretValue)
        local cdmFrame = self:GetParent()

        -- IMPORTANT!! do not remove
        if cdmFrame.__self_desaturated then
            cdmFrame.__self_desaturated = nil
            -- IMPORTANT avoid infinite loop when CooldownStyle forces desaturation for charges cooldown
            return
        end
        if cdmFrame.wasSetFromAura then
            UpdateButtonGlowState(cdmFrame)
        else
            -- -- Not optimal, x5-10 the events as from "Clear"
            -- UpdateButtonGlowState(cdmFrame, secretValue)
        end
        ApplyIconSettings(cdmFrame)
    end)

    -- if FIX_BLIZZARD_MISSING_DEBUFF[cooldownInfo.spellID] then
    --     hooksecurefunc(cdmFrame.Cooldown, "Clear", function(self)
    --         ApplyCooldownSettings(self:GetParent(), true)
    --     end)
    -- end
end

local function HookBuffIconFrame(cdmFrame)
    if cdmFrame.Cooldown == nil or cdmFrame.Icon == nil then
        return
    end
    if cdmFrame.GetCooldownInfo then
        local cooldownInfo = cdmFrame:GetCooldownInfo()
        if cooldownInfo and cooldownInfo.spellID then
            local baseSpellId = cooldownInfo.spellID
            if cooldownInfo.category == 2 then
                SetButtonGlow(cdmFrame, CooldownStyle.GetAlwaysGlow(baseSpellId))
            end
        end
    end

    if cdmFrame._CMCTracker_Hooked then
        return
    end

    cdmFrame._CMCTracker_Hooked = true

    hooksecurefunc(cdmFrame.Cooldown, "SetCooldown", function(self)
        local cdmFrame = self:GetParent()
        local cooldownInfo = cdmFrame:GetCooldownInfo()
        if cooldownInfo == nil then
            return
        end

        local baseSpellId = cooldownInfo.spellID
        cdmFrame.Cooldown:SetDrawEdge(CooldownStyle.GetAlwaysShowCooldownEdge(baseSpellId))
        if cooldownInfo.category == 2 then
            SetButtonGlow(cdmFrame, CooldownStyle.GetAlwaysGlow(baseSpellId))
        end
    end)
end

local function HookFrames()
    local cooldownFrames = GetCooldownFrames()

    for _, cdmFrame in ipairs(cooldownFrames) do
        if cdmFrame.Cooldown and cdmFrame.Icon then
            HookCooldownFrame(cdmFrame)
        end
    end

    local buffIconFrames = GetBuffIconFrames()

    for _, cdmFrame in ipairs(buffIconFrames) do
        if cdmFrame.Cooldown and cdmFrame.Icon then
            HookBuffIconFrame(cdmFrame)
        end
    end
end

local function RefreshCooldownManagerFrames()
    HookFrames()
end

function CooldownStyle:RefreshHooks()
    HookFrames()
end

local isMenuModified = false
function CooldownStyle:Initialize()
    HookFrames()
    if isMenuModified then
        return
    end

    Menu.ModifyMenu("MENU_COOLDOWN_SETTINGS_ITEM", function(owner, rootDescription, contextData)
        local cdInfo = owner:GetCooldownInfo()
        local category = cdInfo.category
        local spellID = owner:GetBaseSpellID()

        rootDescription:CreateDivider()
        rootDescription:CreateTitle(MENU_TITLE)

        if category ~= 3 then
            rootDescription:CreateCheckbox("Always Show Cooldown Edge", function()
                return CooldownStyle.GetAlwaysShowCooldownEdge(spellID)
            end, function()
                CooldownStyle.ToggleAlwaysShowCooldownEdge(spellID)
                RefreshCooldownManagerFrames()
            end)
        end

        --[[category:
            HiddenAura: integer = -2,
            HiddenSpell: integer = -1,
            Essential: integer = 0,
            Utility: integer = 1,
            TrackedBuff: integer = 2,
            TrackedBar: integer = 3,
        ]]
        if cdInfo.hasAura or cdInfo.selfAura then
            if category == 0 or category == 1 or category == -1 then
                rootDescription:CreateCheckbox("Hide Aura", function()
                    return not CooldownStyle.GetShowAuras(spellID)
                end, function()
                    CooldownStyle.ToggleShowAuras(spellID)
                    RefreshCooldownManagerFrames()
                end)
            end

            if category == 0 or category == 1 or category == -1 then
                rootDescription:CreateCheckbox("Reverse Aura Swipe", function()
                    return CooldownStyle.GetReverseAuraSwipe(spellID)
                end, function()
                    CooldownStyle.ToggleReverseAuraSwipe(spellID)
                    RefreshCooldownManagerFrames()
                end)
            end
        end

        if category == 0 or category == 1 or category == -1 then
            rootDescription:CreateCheckbox("Disable Proc Glow", function()
                return CooldownStyle.GetDisableProcsGlow(spellID)
            end, function()
                CooldownStyle.ToggleDisableProcsGlow(spellID)
                -- RefreshCooldownManagerFrames()
            end)

            rootDescription:CreateCheckbox("Glow when ready", function()
                return CooldownStyle.GetGlowWhenReady(spellID)
            end, function()
                CooldownStyle.ToggleGlowWhenReady(spellID)
                RefreshCooldownManagerFrames()
            end)
            if cdInfo.charges then
                rootDescription:CreateCheckbox("Glow when full charges", function()
                    return CooldownStyle.GetGlowOnFullCharges(spellID)
                end, function()
                    CooldownStyle.ToggleGlowOnFullCharges(spellID)
                    RefreshCooldownManagerFrames()
                end)
            end

            rootDescription:CreateCheckbox("Never Desaturate", function()
                return CooldownStyle.GetNeverDesaturate(spellID)
            end, function()
                CooldownStyle.ToggleNeverDesaturate(spellID)
                RefreshCooldownManagerFrames()
            end)
        end

        if category == 2 or category == -2 then
            rootDescription:CreateCheckbox("Always glow", function()
                return CooldownStyle.GetAlwaysGlow(spellID)
            end, function()
                CooldownStyle.ToggleAlwaysGlow(spellID)
                RefreshCooldownManagerFrames()
            end)
        end

        rootDescription:CreateButton("Reset to Defaults", function()
            local db = CooldownStyle.GetDB()
            db.spellSettings[spellID] = nil
            RefreshCooldownManagerFrames()
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

function CooldownStyle.EnsureSpellSettings(spellID)
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

function CooldownStyle.GetNeverDesaturate(spellID)
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
