-- Assistant Module - Rotation Highlight
--
-- Highlights cooldown icons that match the assisted combat rotation suggestion.
-- Shows a blue border on icons suggested by C_AssistedCombat.GetNextCastSpell()

local _, ns = ...
local Affected = ns.API.Affected

local Assistant = {}
ns.Assistant = Assistant

local DEBUG_MODULE = "Assistant"
ns.API:RegisterDebugModule(DEBUG_MODULE)

local PrintDebug = function(...)
    ns.API:LogDebug(DEBUG_MODULE, ...)
end
local isModuleAssistantEnabled = false
local areHooksInitialized = false

local viewersSettingKey = {
    EssentialCooldownViewer = "Essential",
    UtilityCooldownViewer = "Utility",
}

local function IsAssistantEnabledForAnyViewer()
    if not ns.db or not ns.db.profile then
        return false
    end

    if
        ns.db.profile.cooldownManager_showHighlight_Essential
        or ns.db.profile.cooldownManager_showHighlight_Utility
            and not (ns.db.profile.cooldownManager_showHighlight_Essential and ns.db.profile.cooldownManager_showHighlight_Utility)
    then
        ns.db.profile.cooldownManager_showHighlight_Essential = true
        ns.db.profile.cooldownManager_showHighlight_Utility = true
    end
    if ns.db.profile.cooldownManager_showHighlight_Essential or ns.db.profile.cooldownManager_showHighlight_Utility then
        return true
    end
    return false
end

local flipbookConfig = {
    atlas = "RotationHelper_Ants_Flipbook_2x",
    rows = 6,
    columns = 5,
    frames = 30,
    duration = 1.0,
    scale = 1.5,
}

local rotationSpellsCache = {}
local rotationSpellsCacheValid = false
local currentSuggestedSpellID = nil
local suggestionPollFrame = CreateFrame("Frame")
local suggestionPollElapsed = 0

local iconSpellCache = {}

local function IsPerEntrySuggestedGlowEnabled()
    local styleDB = ns.db
        and ns.db.profile
        and ns.db.profile.cooldownStyleSettings
        and ns.db.profile.cooldownStyleSettings.spellSettings
    if styleDB then
        for _, settings in pairs(styleDB) do
            if type(settings) == "table" and settings.glowWhenSuggested == true then
                return true
            end
        end
    end

    local trackerDB = ns.db and ns.db.profile and ns.db.profile.tracker
    local spellSettings = trackerDB and trackerDB.spellItemSettings
    if spellSettings then
        for _, settings in pairs(spellSettings) do
            if type(settings) == "table" and settings.glowWhenSuggested == true then
                return true
            end
        end
    end
    return false
end

local function GetSuggestedSpellID()
    if not C_AssistedCombat or not C_AssistedCombat.GetNextCastSpell then
        return nil
    end
    -- false deliberately decouples CMC from visible action buttons and from
    -- Blizzard's assistedCombatHighlight CVar.
    return C_AssistedCombat.GetNextCastSpell(false)
end

function Assistant:IsSpellSuggested(spellID)
    if not spellID or not currentSuggestedSpellID then
        return false
    end
    if spellID == currentSuggestedSpellID then
        return true
    end

    local spellBase = C_Spell.GetBaseSpell(spellID) or spellID
    local suggestedBase = C_Spell.GetBaseSpell(currentSuggestedSpellID) or currentSuggestedSpellID
    return spellBase == suggestedBase
end

local function ExtractSpellIDFromIcon(icon)
    if icon.cooldownID then
        local info = C_CooldownViewer.GetCooldownViewerCooldownInfo(icon.cooldownID)
        return info.spellID, info.overrideSpellID
    end
    -- CMC's injected Essential icons own a normal addon spellID; Blizzard viewer
    -- spell IDs remain secret and continue to resolve only through cooldownID.
    if Affected(icon).essentialCustom and icon.spellID and not issecretvalue(icon.spellID) then
        return icon.spellID, C_Spell.GetOverrideSpell(icon.spellID)
    end
    return nil
end

local function UpdateRotationSpellsCache()
    wipe(rotationSpellsCache)

    local rotationSpells = C_AssistedCombat.GetRotationSpells()
    if rotationSpells then
        for _, spellID in ipairs(rotationSpells) do
            rotationSpellsCache[spellID] = true
        end
    end

    rotationSpellsCacheValid = true
    PrintDebug("Cached rotation spell IDs")
end

local function IsSpellIDInRotation(spellID)
    if not spellID then
        return false
    end
    if not rotationSpellsCacheValid then
        UpdateRotationSpellsCache()
    end
    return rotationSpellsCache[spellID] == true
end

local function BuildIconSpellCacheForViewer(viewerName)
    local viewerFrame = _G[viewerName]
    if not viewerFrame then
        return
    end
    PrintDebug(
        "|cffff0000 BuildIconSpellCacheForViewer called for",
        viewerName,
        "inLockdown:",
        tostring(ns.API:IsSomeAddOnRestrictionActive())
    )

    local settingName = viewersSettingKey[viewerName]
    if not settingName then
        return
    end

    iconSpellCache[viewerName] = iconSpellCache[viewerName] or {}
    wipe(iconSpellCache[viewerName])

    if not rotationSpellsCacheValid then
        UpdateRotationSpellsCache()
    end

    local children = ns.API:GetViewerItemFrames(viewerFrame)
    for _, child in ipairs(children) do
        if child.Icon then
            ns.Sizes.TagViewerChild(child, settingName)
            local layoutIndex = child.layoutIndex or child:GetName() or tostring(child)

            local rawSpellID, overrideSpellID = ExtractSpellIDFromIcon(child)
            local spellId = rawSpellID
            if rawSpellID then
                local inRotation = IsSpellIDInRotation(rawSpellID)
                if not inRotation and overrideSpellID then
                    inRotation = IsSpellIDInRotation(overrideSpellID)
                    spellId = overrideSpellID
                end

                iconSpellCache[viewerName][layoutIndex] = {
                    spellID = spellId,
                    inRotation = inRotation,
                }

                ns.API:SetAffected(child, "inRotation", inRotation)
            end
        end
    end
end

local function BuildAllIconSpellCaches()
    for viewerName, _ in pairs(viewersSettingKey) do
        BuildIconSpellCacheForViewer(viewerName)
    end

    return true
end

local function ApplyFlipbookShape(flipbookFrame, icon, width, height)
    local tex = flipbookFrame.Texture
    if not tex then
        return
    end

    local w, h = width, height
    if not w or not h or issecretvalue(w) or issecretvalue(h) then
        ns.API:LogWarn(ns.API.Error.AssistantFlipbookShape, "ApplyFlipbookShape called with no width/height for icon")
        w, h = icon:GetSize()
    end
    tex:SetSize(w * flipbookConfig.scale, h * flipbookConfig.scale)

    local acStyle = ns.MasqueModule and ns.MasqueModule:GetAssistedCombatStyle(icon)
    local shapeKey = (acStyle and acStyle.Texture) or "default"
    if Affected(flipbookFrame).shapeKey == shapeKey then
        return
    end
    Affected(flipbookFrame).shapeKey = shapeKey

    local flipAnim = flipbookFrame.FlipAnim
    if acStyle and acStyle.Texture then
        tex:SetTexture(acStyle.Texture)
        if acStyle.TexCoords then
            tex:SetTexCoord(unpack(acStyle.TexCoords))
        end
        if flipAnim then
            flipAnim:SetFlipBookFrameWidth(acStyle.FrameWidth or 0)
            flipAnim:SetFlipBookFrameHeight(acStyle.FrameHeight or 0)
        end
    else
        tex:SetAtlas(flipbookConfig.atlas)
        if flipAnim then
            flipAnim:SetFlipBookFrameWidth(0)
            flipAnim:SetFlipBookFrameHeight(0)
        end
    end

    -- Re-sync the loop so the new frame geometry takes effect immediately.
    local anim = flipbookFrame.Anim
    if anim and anim:IsPlaying() then
        anim:Stop()
        anim:Play()
    end
end

local function GetOrCreateFlipbookHighlight(icon, width, height)
    if Affected(icon).flipbookHighlight then
        ApplyFlipbookShape(Affected(icon).flipbookHighlight, icon, width, height)
        return Affected(icon).flipbookHighlight
    end

    local flipbookFrame = CreateFrame("Frame", nil, icon)
    flipbookFrame:SetFrameLevel(icon:GetFrameLevel() + 10)
    flipbookFrame:SetAllPoints(icon)

    local flipbookTexture = flipbookFrame:CreateTexture(nil, "OVERLAY")
    flipbookTexture:SetBlendMode("ADD")
    flipbookTexture:SetPoint("CENTER", icon, "CENTER", 0, 0)
    flipbookFrame.Texture = flipbookTexture

    local animGroup = flipbookFrame:CreateAnimationGroup()
    animGroup:SetLooping("REPEAT")
    animGroup:SetToFinalAlpha(true)
    flipbookFrame.Anim = animGroup

    -- Holds the texture at full alpha; the flipbook frames do the animating.
    local alphaAnim = animGroup:CreateAnimation("Alpha")
    alphaAnim:SetChildKey("Texture")
    alphaAnim:SetFromAlpha(1)
    alphaAnim:SetToAlpha(1)
    alphaAnim:SetDuration(0.001)
    alphaAnim:SetOrder(0)

    local flipAnim = animGroup:CreateAnimation("FlipBook")
    flipAnim:SetChildKey("Texture")
    flipAnim:SetDuration(flipbookConfig.duration)
    flipAnim:SetOrder(0)
    flipAnim:SetFlipBookRows(flipbookConfig.rows)
    flipAnim:SetFlipBookColumns(flipbookConfig.columns)
    flipAnim:SetFlipBookFrames(flipbookConfig.frames)
    flipbookFrame.FlipAnim = flipAnim

    ApplyFlipbookShape(flipbookFrame, icon, width, height)

    flipbookFrame:SetAlpha(0)
    flipbookFrame:Show()

    Affected(icon).flipbookHighlight = flipbookFrame
    return flipbookFrame
end

local function HideHighlights(child)
    if Affected(child).flipbookHighlight then
        Affected(child).flipbookHighlight:SetAlpha(0)
        if Affected(child).flipbookHighlight.Anim:IsPlaying() then
            Affected(child).flipbookHighlight.Anim:Stop()
        end
    end
end

local function UpdateIconHighlight(child, viewerSettingName)
    if not child then
        return
    end

    if not ns.db or not ns.db.profile then
        return
    end

    local enabledKey = "cooldownManager_showHighlight_" .. viewerSettingName
    if not ns.db.profile[enabledKey] then
        HideHighlights(child)
        return
    end

    local iconSpellID, overrideSpellID = ExtractSpellIDFromIcon(child)
    if not iconSpellID then
        HideHighlights(child)
        return
    end

    local inRotation = ns.API:GetIsAffected(child, "inRotation")
    if not inRotation then
        HideHighlights(child)
        return
    end

    local isSuggested = Assistant:IsSpellSuggested(iconSpellID)
        or (overrideSpellID and Assistant:IsSpellSuggested(overrideSpellID))

    local width, height = ns.Sizes.GetViewerIconSize(viewerSettingName)
    local flipbook = GetOrCreateFlipbookHighlight(child, width, height)
    if isSuggested then
        flipbook:SetAlpha(1)
        if not flipbook.Anim:IsPlaying() then
            flipbook.Anim:Play()
        end
    else
        flipbook:SetAlpha(0)
        if flipbook.Anim:IsPlaying() then
            flipbook.Anim:Stop()
        end
    end
end

function Assistant:UpdateViewerHighlights(viewerName)
    local viewerFrame = _G[viewerName]
    if not viewerFrame then
        return
    end

    local settingName = viewersSettingKey[viewerName]
    if not settingName then
        return
    end

    -- Track per-viewer enabled state so Initialize can compare desired vs current
    local enabledKey = "cooldownManager_showHighlight_" .. settingName
    local isEnabled = ns.db and ns.db.profile and ns.db.profile[enabledKey] or false
    ns.API:SetAffected(viewerFrame, "assistant", isEnabled)

    local children = ns.API:GetViewerItemFrames(viewerFrame)
    for _, child in ipairs(children) do
        if child.Icon then -- Only process icon-like children
            UpdateIconHighlight(child, settingName)
        end
    end
end

function Assistant:UpdateAllHighlights()
    currentSuggestedSpellID = GetSuggestedSpellID()

    for viewerName, _ in pairs(viewersSettingKey) do
        self:UpdateViewerHighlights(viewerName)
    end
end

local function RefreshSuggestedGlowConsumers()
    if isModuleAssistantEnabled then
        for viewerName in pairs(viewersSettingKey) do
            Assistant:UpdateViewerHighlights(viewerName)
        end
    end
    if ns.CooldownStyle then
        ns.CooldownStyle:RefreshSuggestedGlows()
    end
    if ns.TrackerItemViewer then
        ns.TrackerItemViewer:RefreshSuggestedGlows()
    end
end

local function PollSuggestedSpell()
    local nextSuggestedSpellID = GetSuggestedSpellID()
    if nextSuggestedSpellID == currentSuggestedSpellID then
        return
    end
    currentSuggestedSpellID = nextSuggestedSpellID
    RefreshSuggestedGlowConsumers()
end

suggestionPollFrame:SetScript("OnUpdate", nil)
local suggestionPollUpdateRate = 0.1

local function RefreshSuggestionPollUpdateRate()
    local updateRate = tonumber(C_CVar.GetCVar("assistedCombatIconUpdateRate")) or 0.1
    suggestionPollUpdateRate = math.max(0.05, math.min(updateRate, 1))
end

function Assistant:RefreshSuggestionTracking()
    local shouldPoll = isModuleAssistantEnabled or IsPerEntrySuggestedGlowEnabled()
    suggestionPollElapsed = 0
    if not shouldPoll then
        suggestionPollFrame:SetScript("OnUpdate", nil)
        currentSuggestedSpellID = nil
        return
    end

    RefreshSuggestionPollUpdateRate()
    PollSuggestedSpell()
    suggestionPollFrame:SetScript("OnUpdate", function(_, elapsed)
        suggestionPollElapsed = suggestionPollElapsed + elapsed
        if suggestionPollElapsed < suggestionPollUpdateRate then
            return
        end
        suggestionPollElapsed = 0
        RefreshSuggestionPollUpdateRate()
        PollSuggestedSpell()
    end)
end

-- Pre-create flipbook highlights for all in-rotation icons.
function Assistant:PrepareRotationBorders()
    UpdateRotationSpellsCache()
    BuildAllIconSpellCaches()

    for viewerName, settingName in pairs(viewersSettingKey) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            if ns.db and ns.db.profile then
                local enabledKey = "cooldownManager_showHighlight_" .. settingName
                if ns.db.profile[enabledKey] then
                    local children = ns.API:GetViewerItemFrames(viewerFrame)
                    for _, child in ipairs(children) do
                        if child.Icon and ns.API:GetIsAffected(child, "inRotation") then
                            local width, height = ns.Sizes.GetViewerIconSize(settingName)
                            GetOrCreateFlipbookHighlight(child, width, height)
                        end
                    end
                end
            end
        end
    end
end

local eventFrame = CreateFrame("Frame")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if not isModuleAssistantEnabled then
        return
    end

    if event == "EDIT_MODE_LAYOUTS_UPDATED" then
        PrintDebug("EditMode layout changed - rebuilding cache")
        BuildAllIconSpellCaches()
        Assistant:UpdateAllHighlights()
    elseif event == "PLAYER_ENTERING_WORLD" then
        rotationSpellsCacheValid = false
        UpdateRotationSpellsCache()
        BuildAllIconSpellCaches()
        Assistant:UpdateAllHighlights()
    elseif
        event == "PLAYER_TALENT_UPDATE"
        or event == "SPELLS_CHANGED"
        or event == "PLAYER_SPECIALIZATION_CHANGED"
        or event == "UPDATE_SHAPESHIFT_FORM"
        or event == "TRAIT_CONFIG_UPDATED"
        or event == "ACTIVE_PLAYER_SPECIALIZATION_CHANGED"
    then
        rotationSpellsCacheValid = false
        Assistant:PrepareRotationBorders()
        Assistant:UpdateAllHighlights()
    end
end)

hooksecurefunc(AssistedCombatManager, "UpdateAllAssistedHighlightFramesForSpell", function(self, spellID)
    if ns.db and ns.db.profile then
        local shouldUpdate = false
        for _, settingName in pairs(viewersSettingKey) do
            local enabledKey = "cooldownManager_showHighlight_" .. settingName
            if ns.db.profile[enabledKey] then
                shouldUpdate = true
                break
            end
        end

        if shouldUpdate then
            Assistant:UpdateAllHighlights()
        end
    end
end)

function Assistant:Shutdown()
    PrintDebug("Shutting down module")

    isModuleAssistantEnabled = false

    eventFrame:UnregisterAllEvents()

    wipe(rotationSpellsCache)
    rotationSpellsCacheValid = false
    wipe(iconSpellCache)

    for viewerName, _ in pairs(viewersSettingKey) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            ns.API:UnsetAffected(viewerFrame, "assistant")
            local children = ns.API:GetViewerItemFrames(viewerFrame)
            for _, child in ipairs(children) do
                HideHighlights(child)
            end
        end
    end
end

function Assistant:Enable()
    if isModuleAssistantEnabled then
        return
    end
    PrintDebug("Enabling module")

    isModuleAssistantEnabled = true

    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
    eventFrame:RegisterEvent("SPELLS_CHANGED")
    eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    eventFrame:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
    eventFrame:RegisterEvent("TRAIT_CONFIG_UPDATED")
    eventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    eventFrame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")

    if not areHooksInitialized then
        areHooksInitialized = true

        for viewerName in pairs(viewersSettingKey) do
            local viewerFrame = _G[viewerName]
            if viewerFrame then
                hooksecurefunc(viewerFrame, "RefreshLayout", function()
                    if not isModuleAssistantEnabled then
                        return
                    end

                    PrintDebug("RefreshLayout called for viewer:", viewerName)
                    BuildIconSpellCacheForViewer(viewerName)
                    Assistant:PrepareRotationBorders()
                    Assistant:UpdateViewerHighlights(viewerName)
                end)
            end
        end
    end

    rotationSpellsCacheValid = false
    UpdateRotationSpellsCache()
    self:PrepareRotationBorders()
    self:UpdateAllHighlights()
    self:RefreshSuggestionTracking()
end

function Assistant:Disable()
    PrintDebug("Disabling module")

    self:Shutdown()
    self:RefreshSuggestionTracking()
end

function Assistant:Initialize()
    self:OnSettingChanged()
    self:RefreshSuggestionTracking()
    ns.db.profile.assistantCache = nil
end

function Assistant:OnSettingChanged(viewerSettingName)
    local shouldBeEnabled = IsAssistantEnabledForAnyViewer()

    if shouldBeEnabled and not isModuleAssistantEnabled then
        self:Enable()
    elseif not shouldBeEnabled and isModuleAssistantEnabled then
        self:Disable()
    end

    -- Module remains enabled; update every viewer matching the changed setting (or all if unspecified)
    if viewerSettingName then
        for viewerName, settingName in pairs(viewersSettingKey) do
            if settingName == viewerSettingName then
                BuildIconSpellCacheForViewer(viewerName)
                self:UpdateViewerHighlights(viewerName)
            end
        end
    else
        self:PrepareRotationBorders()
        self:UpdateAllHighlights()
    end
    self:RefreshSuggestionTracking()
end
