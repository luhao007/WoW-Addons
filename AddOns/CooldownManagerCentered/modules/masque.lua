local _, ns = ...
local L = ns.L
local Affected = ns.API.Affected

-- Masque integration: registers the CDM item buttons and custom trackers with
-- Masque. While active, CMC's own icon styling modules early-return (see
-- IsActive); fonts/stacks keep running because Count is deliberately left unmapped.

local Masque = LibStub("Masque", true)

local MasqueModule = {}
ns.MasqueModule = MasqueModule

-- Addon name shown in the Masque options UI.
local MASQUE_ADDON = "Cooldown Manager Centered"

local ICON_OVERLAY_ATLAS = "UI-HUD-CoolDownManager-IconOverlay"

-- Viewers we skin and their Masque group id. Tracked Bars are excluded.
local VIEWERS = {
    { name = "EssentialCooldownViewer", title = L["Essential Cooldowns"], id = "CMC_Essential", btype = "Action" },
    { name = "UtilityCooldownViewer", title = L["Utility Cooldowns"], id = "CMC_Utility", btype = "Action" },
    { name = "BuffIconCooldownViewer", title = L["Tracked Buffs"], id = "CMC_BuffIcons", btype = "Aura" },
}

-- Shared group for all custom trackers.
local TRACKER_GROUP = { title = L["Custom Trackers"], id = "CMC_Tracker", btype = "Action" }

-- "Masque Blizzard Bars" skins these same frames under its own groups; when ours
-- is active we force-disable its equivalent so the two skins don't fight. Maps our
-- group id -> the Blizzard Bars group id for Masque:GetGroupByID.
local BLIZZBARS_CONFLICTS = {
    CMC_Essential = "Blizzard Action Bars_EssentialCooldownViewer",
    CMC_Utility = "Blizzard Action Bars_UtilityCooldownViewer",
    CMC_BuffIcons = "Blizzard Action Bars_BuffIconCooldownViewer",
}

-- Lazily-created Masque groups keyed by static id.
local groups = {}
local hooksInstalled = false

-- True when Masque is installed and the integration is enabled. Styling/font
-- modules consult this to decide whether to bail out.
function MasqueModule:IsActive()
    return Masque ~= nil and ns.db ~= nil and ns.db.profile ~= nil and ns.db.global.masque_enabled == true
end

function MasqueModule:IsAvailable()
    return Masque ~= nil
end

-- The live MaskTexture shaping the icon, so overlays (button-press, glow) can be
-- clipped to the same shape. Prefer Masque's own region mask: for shaped skins it
-- creates _MSQ_Mask on the icon and detaches the IconMask we exposed. Returns nil
-- for unmasked (square) icons.
function MasqueModule:GetIconMask(frame)
    if not frame then
        return nil
    end
    local icon = frame.Icon
    if icon then
        if icon._MSQ_Mask then
            return icon._MSQ_Mask
        end
        if icon._MSQ_ButtonMask then
            return icon._MSQ_ButtonMask
        end
    end
    if frame.IconMask then
        return frame.IconMask
    end
    if icon and icon.GetMaskTexture then
        return icon:GetMaskTexture(1)
    end
    return nil
end

-- Shape-keyed proc/glow art. Masque shapes procs and the rotation-helper
-- highlight by swapping pre-drawn art per skin Shape (not by masking). The helpers
-- below expose that art so our own glow/assistant overlays match the proc shape.

-- The Masque skin shape: "Square", "Circle", "Hexagon", "Hexagon-Rotated", ...
-- Nil when the button isn't skinned.
function MasqueModule:GetShape(frame)
    local cfg = frame and frame._MSQ_CFG
    return cfg and cfg.Shape or nil
end

-- Regular polygon as normalised perimeter vertices (0..1, top-left origin).
local function MakePolygon(sides, startAngleDeg)
    local verts = {}
    for i = 0, sides - 1 do
        local a = math.rad(startAngleDeg + (360 / sides) * i)
        verts[i + 1] = {
            x = 0.5 + 0.5 * math.cos(a),
            y = 0.5 - 0.5 * math.sin(a),
        }
    end
    return verts
end

-- Outline vertices per shape for perimeter glows. Square/Modern are absent (a
-- rectangle is already correct). If a hexagon renders rotated, swap the angles.
local SHAPE_VERTICES = {
    Hexagon = MakePolygon(6, 90), -- flat top/bottom
    ["Hexagon-Rotated"] = MakePolygon(6, 60), -- pointy top/bottom
    Circle = MakePolygon(32, 90), -- smooth approximation
}

-- Outline vertices tracing this button's skin shape, or nil for square.
function MasqueModule:GetShapeVertices(frame)
    if not self:IsActive() then
        return nil
    end
    local shape = self:GetShape(frame)
    return shape and SHAPE_VERTICES[shape] or nil
end

-- Shaped proc-glow Glow/Ants textures for this button's skin shape, or nil for
-- square (the default glow already fits).
function MasqueModule:GetSpellAlertTextures(frame)
    if not self:IsActive() or not Masque or not Masque.GetSpellAlert then
        return nil
    end
    local shape = self:GetShape(frame)
    if not shape or shape == "Square" then
        return nil
    end
    return Masque:GetSpellAlert(shape) -- Glow, Ants
end

-- Masque's shaped rotation-helper ants-flipbook style table for this button's
-- skin shape ({ Texture, TexCoords, FrameWidth, FrameHeight, ... }), or nil for
-- square. Lets the assistant highlight match the skin shape.
function MasqueModule:GetAssistedCombatStyle(frame)
    if not self:IsActive() or not Masque or not Masque.GetAssistedCombatHighlightStyle then
        return nil
    end
    local shape = self:GetShape(frame)
    if not shape or shape == "Square" then
        return nil
    end
    return Masque:GetAssistedCombatHighlightStyle(shape)
end

-- Masque fires its group callback after re-skinning, once per changed option. We
-- debounce to the next frame and re-apply CMC's own overlays/masks/fonts (which
-- Masque doesn't know about) so they follow the new shape without a /reload.
local refreshPending = false
local function OnMasqueSkinChanged()
    if refreshPending then
        return
    end
    refreshPending = true
    C_Timer.After(0, function()
        refreshPending = false
        MasqueModule:Refresh()
    end)
end

local function GetGroup(def)
    if not Masque then
        return nil
    end
    local group = groups[def.id]
    if not group then
            group = Masque:Group(MASQUE_ADDON, def.title, def.id)
        groups[def.id] = group
        -- Signature: func(group, option, value); we only need "something changed".
        if group.RegisterCallback then
            group:RegisterCallback(function()
                OnMasqueSkinChanged()
            end)
        end
    end
    return group
end

-- Re-apply CMC's own per-button extras after Masque re-skins, rebuilding the
-- overlays that bake in the skin's shape/mask so they follow a skin change.
function MasqueModule:Refresh()
    if not self:IsActive() then
        return
    end
    self:SkinAllViewers()
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshStyling then
        ns.TrackerItemViewer:RefreshStyling()
    end
    self:EnforceBlizzBarsDisabled()
    if ns.ButtonPress and ns.ButtonPress.RefreshTextures then
        ns.ButtonPress:RefreshTextures()
    end
    if ns.Assistant and ns.Assistant.UpdateAllHighlights then
        ns.Assistant:UpdateAllHighlights()
    end
    if ns.CooldownStyle and ns.CooldownStyle.RefreshAllGlows then
        ns.CooldownStyle:RefreshAllGlows()
    end
    if ns.CooldownFont and ns.CooldownFont.RefreshAll then
        ns.CooldownFont:RefreshAll()
    end
    if ns.Stacks and ns.Stacks.RefreshAll then
        ns.Stacks:RefreshAll()
    end
end

-- Hide the Blizzard gloss/border overlay so the Masque skin border is visible.
local function HideIconOverlay(frame)
    if ns.API:GetIsAffected(frame, "masqueOverlayHidden") then
        return
    end
    for i = 1, select("#", frame:GetRegions()) do
        local region = select(i, frame:GetRegions())
        if region and region.GetAtlas and region:GetAtlas() == ICON_OVERLAY_ATLAS then
            region:SetAlpha(0)
            ns.API:SetAffected(frame, "masqueOverlayHidden")
            break
        end
    end
end

-- Expose the icon's existing circular mask to Masque so it re-textures that mask
-- to the skin shape instead of adding a second one.
local function ExposeIconMask(frame)
    if frame.IconMask or not frame.Icon or not frame.Icon.GetMaskTexture then
        return
    end
    local mask = frame.Icon:GetMaskTexture(1)
    if mask then
        frame.IconMask = mask
    end
end

-- Clip the square red OutOfRange overlay to the icon's mask so it doesn't overflow
-- a shaped skin. Re-applies on recolor; drops the mask when the skin is off/changed.
local function MaskOutOfRange(frame)
    local oor = frame.OutOfRange
    if not oor or not oor.GetMaskTexture or not frame.Icon or not frame.Icon.GetMaskTexture then
        return
    end
    local iconMask = frame.Icon:GetMaskTexture(1)

    -- Remove a previously-applied mask if the skin is now off or its mask changed.
    if Affected(frame).oorMask then
        local applied = oor:GetMaskTexture(Affected(frame).oorMask)
        if not MasqueModule:IsActive() or iconMask ~= applied then
            if applied then
                oor:RemoveMaskTexture(applied)
            end
            Affected(frame).oorMask = nil
        end
    end

    if MasqueModule:IsActive() and not Affected(frame).oorMask and iconMask then
        oor:AddMaskTexture(iconMask)
        Affected(frame).oorMask = oor:GetNumMaskTextures()
    end
end

-- Add (or re-skin) a single Cooldown Manager item frame to the given group.
local function SkinButton(group, frame, btype)
    if not frame or not frame.Icon or not frame.Cooldown then
        return
    end
    ExposeIconMask(frame)
    HideIconOverlay(frame)

    -- Keep the out-of-range overlay clipped to the skin shape.
    if frame.OutOfRange and not Affected(frame).oorHooked then
        Affected(frame).oorHooked = true
        frame.OutOfRange:SetDrawLayer("ARTWORK", -1)
        if frame.RefreshIconColor then
            hooksecurefunc(frame, "RefreshIconColor", MaskOutOfRange)
        end
    end
    MaskOutOfRange(frame)

    -- Count is left unmapped on purpose so Masque's Skin_Text doesn't move it;
    -- CMC manages the stack count (cooldownFont.lua).
    local regions = {
        Icon = frame.Icon,
        Cooldown = frame.Cooldown,
    }

    -- DebuffBorder isn't Masque-skinnable and doesn't scale to the skin; hide it
    -- (styled.lua restores its alpha when Masque is off).
    if frame.DebuffBorder then
        frame.DebuffBorder:SetAlpha(0)
    end

    -- Mark the swipe pre-hooked (before registration) so Masque leaves it to CMC.
    frame._Swipe_Hook = true
    frame.Icon._Swipe_Hook = true
    frame.Cooldown._Swipe_Hook = true

    if ns.API:GetIsAffected(frame, "masqueSkinned") then
        group:ReSkin(frame)
    else
        group:AddButton(frame, regions, btype)
        ns.API:SetAffected(frame, "masqueSkinned")
    end
end

-- Skin every current item button of a Cooldown Manager viewer.
function MasqueModule:SkinViewer(viewerName)
    if not self:IsActive() then
        return
    end
    local def
    for _, v in ipairs(VIEWERS) do
        if v.name == viewerName then
            def = v
            break
        end
    end
    if not def then
        return
    end
    local viewer = _G[viewerName]
    if not viewer then
        return
    end
    local group = GetGroup(def)
    if not group then
        return
    end
    for _, child in ipairs(ns.API:GetViewerItemFrames(viewer)) do
        if child.Icon and child.Cooldown then
            SkinButton(group, child, def.btype)
        end
    end
end

function MasqueModule:SkinAllViewers()
    for _, def in ipairs(VIEWERS) do
        self:SkinViewer(def.name)
    end
end

-- Disable the "Masque Blizzard Bars" group for each viewer whose CMC group is
-- active, so the frames aren't double-skinned. No-op when Blizzard Bars isn't loaded.
function MasqueModule:EnforceBlizzBarsDisabled()
    if not self:IsActive() or not Masque or not Masque.GetGroupByID then
        return
    end
    local disabledAny = false
    for cmcId, blizzId in pairs(BLIZZBARS_CONFLICTS) do
        local cmcGroup = groups[cmcId]
        if cmcGroup and not cmcGroup.db.Disabled then
            local blizzGroup = Masque:GetGroupByID(blizzId)
            if blizzGroup and not blizzGroup.db.Disabled and blizzGroup.__Disable then
                blizzGroup:__Disable()
                disabledAny = true
            end
        end
    end
    -- Disabling Blizzard Bars strips the skin off the shared frames; re-assert ours.
    -- Only runs when we disabled something, so it won't loop.
    if disabledAny then
        for _, def in ipairs(VIEWERS) do
            self:SkinViewer(def.name)
        end
    end
end

-- Skin a single custom-tracker icon frame. Called by the Tracker module for each
-- of its icon frames; all trackers share one Masque group.
function MasqueModule:SkinTrackerIcon(frame)
    if not self:IsActive() or not frame or not frame.Icon or not frame.Cooldown then
        return
    end
    local group = GetGroup(TRACKER_GROUP)
    if not group then
        return
    end
    -- The tracker creates its own MaskTexture on the icon; reuse it as IconMask.
    if not frame.IconMask and frame.mask then
        frame.IconMask = frame.mask
    end
    if frame.IconOverlay then
        frame.IconOverlay:Hide()
    end

    -- Leave Count unmapped (CMC manages the tracker's stack text).
    local regions = {
        Icon = frame.Icon,
        Cooldown = frame.Cooldown,
    }

    -- Mark the swipe pre-hooked (before registration) so Masque leaves it to CMC.
    frame._Swipe_Hook = true
    frame.Icon._Swipe_Hook = true
    frame.Cooldown._Swipe_Hook = true

    if ns.API:GetIsAffected(frame, "masqueSkinned") then
        group:ReSkin(frame)
    else
        group:AddButton(frame, regions, TRACKER_GROUP.btype)
        ns.API:SetAffected(frame, "masqueSkinned")
    end
end

-- Install RefreshLayout hooks once so freshly-pooled item buttons get skinned.
local function InstallHooks()
    if hooksInstalled then
        return
    end
    hooksInstalled = true
    for _, def in ipairs(VIEWERS) do
        local viewer = _G[def.name]
        if viewer and viewer.RefreshLayout then
            hooksecurefunc(viewer, "RefreshLayout", function()
                if not MasqueModule:IsActive() then
                    return
                end
                if not ns.Runtime or ns.Runtime:IsReady(def.name) then
                    MasqueModule:SkinViewer(def.name)
                end
                -- Blizzard Bars re-skins on this same layout event; re-disable it.
                MasqueModule:EnforceBlizzBarsDisabled()
            end)
        end
    end
end

function MasqueModule:Initialize()
    if not Masque then
        return
    end
    InstallHooks()
    if not self:IsActive() then
        return
    end
    self:SkinAllViewers()
    -- Re-skin custom tracker icons that already exist.
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshStyling then
        ns.TrackerItemViewer:RefreshStyling()
    end
    self:EnforceBlizzBarsDisabled()
    -- Blizzard Bars may register its groups after us; retry once.
    C_Timer.After(2, function()
        self:EnforceBlizzBarsDisabled()
    end)
end
