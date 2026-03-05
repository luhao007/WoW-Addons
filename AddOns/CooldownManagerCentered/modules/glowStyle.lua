local _, ns = ...

local GlowStyle = {}
ns.GlowStyle = GlowStyle

local LCG = LibStub("LibCustomGlow-1.0")

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

        if ns.db.profile.cooldownManager_experimental_custom_glows then
            activeGlowTarget.SpellActivationAlert:SetAlpha(0)
            if activeGlowTarget.CMCActiveGlow then
                return
            end

            activeGlowTarget.CMCActiveGlow = true

            LCG.PixelGlow_Start(activeGlowTarget)
        end
    end)

    hooksecurefunc(ActionButtonSpellAlertManager, "HideAlert", function(_, frame)
        local activeGlowTarget = GetGlowTarget(frame)
        if not activeGlowTarget or not activeGlowTarget.CMCActiveGlow then
            return
        end

        activeGlowTarget.CMCActiveGlow = nil
        LCG.PixelGlow_Stop(activeGlowTarget)
    end)
    ActionButtonSpellAlertManager._CMC_Hooked = true
end

function GlowStyle.Initialize()
    HookActionButtonSpellAlertManager()
end
