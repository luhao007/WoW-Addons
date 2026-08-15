local _, ns = ...

--
-- Hide Range Check
--
-- Blizzard's Cooldown Manager item frames (Essential / Utility) dim / desaturate
-- icons whose spell is out of range. Each item frame carries a `needsRangeCheck`
-- flag (set from C_Spell.SpellHasRange during layout) that drives the range
-- polling in its OnUpdate. Clearing it after a viewer refresh disables the
-- out-of-range indicator for that viewer.
--
-- Kept as its own module (rather than folded into cooldownStyle.lua) because it
-- is a behavioural tweak that should keep working even when the styling modules
-- early-return under Masque. Driven from runtime.lua's RefreshLayout hooks.
--

local RangeCheck = {}
ns.RangeCheck = RangeCheck

-- Only the action viewers do range checking; buffs/bars don't.
local viewers = {
    "EssentialCooldownViewer",
    "UtilityCooldownViewer",
}

local function IsEnabled()
    return ns.db ~= nil and ns.db.profile ~= nil and ns.db.profile.cooldownManager_hideRangeCheck == true
end

local RefreshIconColor = function(child)
    local spellID = child:GetSpellID()
    if not spellID or issecretvalue(spellID) then
        return
    end

    local iconTexture = child:GetIconTexture()
    local outOfRangeTexture = child:GetOutOfRangeTexture()

    local isUsable, notEnoughMana = C_Spell.IsSpellUsable(spellID)
    if isUsable then
        iconTexture:SetVertexColor(CooldownViewerConstants.ITEM_USABLE_COLOR:GetRGBA())
    elseif notEnoughMana then
        iconTexture:SetVertexColor(CooldownViewerConstants.ITEM_NOT_ENOUGH_MANA_COLOR:GetRGBA())
    else
        iconTexture:SetVertexColor(CooldownViewerConstants.ITEM_NOT_USABLE_COLOR:GetRGBA())
    end

    outOfRangeTexture:SetShown(false)
end

function RangeCheck:RefreshViewer(viewerName)
    local viewer = _G[viewerName]
    if not viewer then
        return
    end
    local isEnabled = IsEnabled()
    for _, child in ipairs(ns.API:GetViewerItemFrames(viewer)) do
        if isEnabled and not ns.API:GetIsAffected(child, "rangeCheckHooked") and child.RefreshIconColor then
            ns.API:SetAffected(child, "rangeCheckHooked")
            hooksecurefunc(child, "RefreshIconColor", function()
                if IsEnabled() then
                    RefreshIconColor(child)
                end
            end)
            RefreshIconColor(child)
        end
    end
end

function RangeCheck:RefreshAll()
    for _, viewerName in ipairs(viewers) do
        self:RefreshViewer(viewerName)
    end
end
