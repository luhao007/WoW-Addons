local _, ns = ...

local L = ns.L

local ReadyAlerts = {}
ns.ReadyAlerts = ReadyAlerts

local Affected = ns.API.Affected
local SoundPickerMenu = ns.LibEQOL.SoundPickerMenu
local DEFAULT_SOUND = ns.BuffSounds.DEFAULT_SOUND
local READY_POLL_INTERVAL = 0.1

local function GetSettings(styleKey, create)
    if styleKey == nil or not ns.db or not ns.db.profile then
        return nil
    end
    local db = ns.db.profile.cooldownStyleSettings
    if not db then
        if not create then
            return nil
        end
        db = { spellSettings = {} }
        ns.db.profile.cooldownStyleSettings = db
    end
    db.spellSettings = db.spellSettings or {}
    local settings = db.spellSettings[styleKey]
    if not settings and create then
        settings = {}
        db.spellSettings[styleKey] = settings
    end
    return settings
end

local function GetTrackerSettings(kind, id, create)
    local db = ns.TrackerDB
    if not db or not kind or not id then
        return nil
    end
    if kind == "spell" then
        return create and db.EnsureSpellItemSettings(id) or db.GetSpellItemSettings(id)
    elseif kind == "item" then
        return create and db.EnsureItemSettings(id) or db.GetItemSettings(id)
    elseif kind == "wildcardSlots" then
        return create and db.EnsureWildcardSlotSettings(id) or db.GetWildcardSlotSettings(id)
    end
    return nil
end

local function RefreshSettingsIndicators()
    if ns.CooldownStyle and ns.CooldownStyle.RefreshSettingsItemIndicators then
        ns.CooldownStyle.RefreshSettingsItemIndicators()
    end
    if ns.TrackerAssignmentPanel and ns.TrackerAssignmentPanel.RefreshTrackerPanel then
        ns.TrackerAssignmentPanel:RefreshTrackerPanel()
    end
    if ReadyAlerts.RefreshNativeMonitor then
        ReadyAlerts:RefreshNativeMonitor()
    end
end

---@param value string?
local function ResolveSoundLabel(value)
    return ns.BuffSounds:ResolveSoundLabel(value or DEFAULT_SOUND)
end

---@param value string?
local function PlayConfiguredSound(value)
    return ns.BuffSounds:PlayConfiguredSound(value)
end

local function GetReadySoundOptions()
    return ns.BuffSounds:GetSoundOptions()
end

local function SpeakText(text)
    if issecretvalue(text) then
        return
    end
    if type(text) ~= "string" or text == "" then
        return
    end

    C_VoiceChat.SpeakText(C_TTSSettings.GetVoiceOptionID(0), text, C_TTSSettings.GetSpeechRate(), 100, true)
end

local function IsSafeTTSText(text)
    return (not issecretvalue(text)) and type(text) == "string" and text ~= ""
end

local function GetSafeTTSText(text, fallback)
    if IsSafeTTSText(text) then
        return text
    end
    if IsSafeTTSText(fallback) then
        return fallback
    end
    return nil
end

local function GetSpellTTSText(spellID)
    if issecretvalue(spellID) or type(spellID) ~= "number" then
        return nil
    end
    return GetSafeTTSText(C_Spell.GetSpellName(spellID))
end

local function EnsureReadyTTSText(settings, defaultText)
    if not settings then
        return nil
    end
    settings.readyTTSText = GetSafeTTSText(settings.readyTTSText, defaultText)
    return settings.readyTTSText
end

local function TriggerSettings(settings)
    if not settings then
        return
    end
    if settings.soundWhenReady then
        PlayConfiguredSound(settings.readySound)
    end
    if settings.ttsWhenReady then
        SpeakText(GetSafeTTSText(settings.readyTTSText))
    end
end

local nativeStates = {}
local pendingTrackerAlerts = setmetatable({}, { __mode = "k" })
local readyTicker
local nativeLoading = true
local nativeSuppressedUntil = 0

local function GetNativeStyleKey(cooldownInfo)
    if not cooldownInfo then
        return nil
    end
    if cooldownInfo.spellCategoryID ~= nil or cooldownInfo.equipSlot ~= nil then
        return cooldownInfo.cooldownID and ("cd:" .. cooldownInfo.cooldownID) or nil
    end
    return cooldownInfo.spellID
end

local function GetActiveNativeStyleKeys()
    local active = {}
    local categoryEnum = Enum and Enum.CooldownViewerCategory
    if not categoryEnum or not C_CooldownViewer or not C_CooldownViewer.GetCooldownViewerCategorySet then
        return active
    end
    local categories = {}
    local function AddCategory(category)
        if category ~= nil then
            categories[#categories + 1] = category
        end
    end
    AddCategory(categoryEnum.Essential)
    AddCategory(categoryEnum.Utility)
    AddCategory(categoryEnum.EquipSlotEssential)
    AddCategory(categoryEnum.SpecAgnosticEssential)
    for _, category in ipairs(categories) do
        for _, cooldownID in ipairs(C_CooldownViewer.GetCooldownViewerCategorySet(category, false)) do
            local cooldownInfo = C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID)
            local styleKey = GetNativeStyleKey(cooldownInfo)
            if styleKey ~= nil and cooldownInfo and cooldownInfo.isKnown ~= false then
                active[styleKey] = true
            end
        end
    end
    return active
end

local function ResolveNativeSpellID(styleKey)
    if type(styleKey) ~= "number" then
        return nil
    end
    if C_SpellBook and C_SpellBook.FindSpellOverrideByID then
        return C_SpellBook.FindSpellOverrideByID(styleKey) or styleKey
    end
    return C_Spell.GetOverrideSpell(styleKey) or styleKey
end

-- startTime/duration and Duration-object predicates can be secret in restricted
-- combat. isActive and isOnGCD are explicitly NeverSecret in Blizzard's API.
local function IsNativeSpellOnActualCooldown(styleKey)
    local spellID = ResolveNativeSpellID(styleKey)
    if not spellID then
        return nil, nil
    end
    local chargeInfo = C_Spell.GetSpellCharges(spellID)
    if chargeInfo and chargeInfo.maxCharges > 1 then
        -- A recharge running behind an available charge is not a real cooldown.
        -- Only 0 charges arms the alert, so it can fire once on the 0 -> 1 transition.
        if canaccessvalue and not canaccessvalue(chargeInfo.currentCharges) then
            return false, spellID
        end
        return chargeInfo.currentCharges == 0, spellID
    end
    local cooldown = C_Spell.GetSpellCooldown(spellID)
    if not cooldown then
        return false, spellID
    end
    return cooldown.isActive == true and cooldown.isOnGCD ~= true, spellID
end

---@param spellID number|string?
local function IsSpellReady(spellID)
    if not spellID then
        return false
    end
    local overrideSpellID = C_Spell.GetOverrideSpell(spellID) or spellID
    return C_Spell.IsSpellUsable(overrideSpellID) == true
end

local function IsTrackerEntryReady(kind, id)
    if kind == "spell" then
        return IsSpellReady(id)
    elseif kind == "item" then
        return C_Item.GetItemCount(id, false, true) > 0 and C_Item.IsUsableItem(id) == true
    end
    return true
end

local function EvaluatePendingTrackerAlerts()
    local needsPolling = false
    for frame, pending in pairs(pendingTrackerAlerts) do
        local state = Affected(frame)
        local settings = GetTrackerSettings(pending.kind, pending.id, false)
        if
            not state.readyAlertTrackerActive
            or state.readyAlertTrackerIdentity ~= pending.identity
            or not frame:IsShown()
            or not ReadyAlerts:IsEnabled(settings)
        then
            pendingTrackerAlerts[frame] = nil
        elseif IsTrackerEntryReady(pending.kind, pending.id) then
            pendingTrackerAlerts[frame] = nil
            TriggerSettings(settings)
        else
            needsPolling = true
        end
    end
    return needsPolling
end

local function StopReadyTicker()
    if readyTicker then
        readyTicker:Cancel()
        readyTicker = nil
    end
end

local EvaluateNativeStates

local function SetReadyTickerActive(active)
    if active and not readyTicker then
        readyTicker = C_Timer.NewTicker(READY_POLL_INTERVAL, function()
            EvaluateNativeStates(false)
        end)
    elseif not active then
        StopReadyTicker()
    end
end

EvaluateNativeStates = function(primeOnly)
    local needsPolling = false
    local suppressed = nativeLoading or GetTime() < nativeSuppressedUntil
    for styleKey, state in pairs(nativeStates) do
        local settings = GetSettings(styleKey, false)
        if not ReadyAlerts:IsEnabled(settings) then
            nativeStates[styleKey] = nil
        else
            local isOnActualCooldown, spellID = IsNativeSpellOnActualCooldown(styleKey)
            if isOnActualCooldown ~= nil then
                if primeOnly then
                    state.armed = isOnActualCooldown or nil
                    state.readySamples = 0
                elseif isOnActualCooldown then
                    state.armed = true
                    state.readySamples = 0
                elseif state.armed then
                    if IsSpellReady(spellID) then
                        state.readySamples = (state.readySamples or 0) + 1
                    else
                        state.readySamples = 0
                    end
                    if state.readySamples >= 2 then
                        -- Re-check the live CDM layout at the trigger boundary. This
                        -- closes the event-order race where an icon is removed just
                        -- as its cooldown finishes, before OnDataChanged is handled.
                        if not suppressed and GetActiveNativeStyleKeys()[styleKey] then
                            TriggerSettings(settings)
                        end
                        state.armed = nil
                        state.readySamples = 0
                    end
                end
                needsPolling = needsPolling or isOnActualCooldown or state.armed == true
            end
        end
    end
    needsPolling = EvaluatePendingTrackerAlerts() or needsPolling
    SetReadyTickerActive(needsPolling and not nativeLoading)
end

local function GetPopupEditBox(dialog)
    if dialog and dialog.GetEditBox then
        local editBox = dialog:GetEditBox()
        if editBox then
            return editBox
        end
    end
    return dialog and (dialog.editBox or dialog.EditBox) or nil
end

local function CreatePreviewButton(dialog)
    if dialog.ReadyAlertPreviewButton then
        return dialog.ReadyAlertPreviewButton
    end
    local button = CreateFrame("Button", nil, dialog)
    button:SetSize(20, 20)
    button:SetNormalAtlas("chatframe-button-icon-voicechat")
    button:SetHighlightAtlas("chatframe-button-icon-voicechat")
    button:GetHighlightTexture():SetAlpha(0.35)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(L["Preview TTS"])
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", GameTooltip_Hide)
    button:SetScript("OnClick", function()
        local editBox = GetPopupEditBox(dialog)
        local text = editBox and editBox:GetText() or ""
        local data = dialog.data
        SpeakText(GetSafeTTSText(text ~= "" and text or (data and data.defaultText)))
    end)
    dialog.ReadyAlertPreviewButton = button
    return button
end

StaticPopupDialogs.CMC_READY_ALERT_TTS = {
    text = L["TTS text"],
    button1 = SAVE,
    button2 = CANCEL,
    hasEditBox = true,
    OnShow = function(self, data)
        self.data = data
        local settings = data and data.getSettings and data.getSettings() or nil
        local editBox = GetPopupEditBox(self)
        if not editBox then
            return
        end
        editBox:SetText(GetSafeTTSText(settings and settings.readyTTSText, data and data.defaultText) or "")
        editBox:HighlightText()
        editBox:SetFocus()
        editBox:SetWidth(230)
        local preview = CreatePreviewButton(self)
        preview:ClearAllPoints()
        preview:SetPoint("LEFT", editBox, "RIGHT", 8, 0)
        preview:Show()
    end,
    OnHide = function(self)
        self.data = nil
        if self.ReadyAlertPreviewButton then
            self.ReadyAlertPreviewButton:Hide()
        end
    end,
    OnAccept = function(self, data)
        if not data then
            return
        end
        local editBox = GetPopupEditBox(self)
        if not editBox then
            return
        end
        local text = editBox:GetText() or ""
        if not data.ensureSettings then
            return
        end
        data.ensureSettings().readyTTSText = GetSafeTTSText(text)
        RefreshSettingsIndicators()
    end,
    EditBoxOnEnterPressed = function(editBox)
        StaticPopup_OnClick(editBox:GetParent(), 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function AddConfiguredMenu(rootDescription, getSettings, ensureSettings, defaultText)
    local menu = rootDescription:CreateButton(L["Sound"])
    menu:CreateCheckbox(L["Sound when ready"], function()
        local settings = getSettings()
        return settings and settings.soundWhenReady == true
    end, function()
        local settings = ensureSettings()
        settings.soundWhenReady = not settings.soundWhenReady
        RefreshSettingsIndicators()
    end)

    SoundPickerMenu:CreateSoundPickerMenu(menu, {
        labelPrefix = L["Sound: "],
        options = GetReadySoundOptions,
        getValue = function()
            local current = getSettings()
            return (current and current.readySound) or DEFAULT_SOUND
        end,
        getLabel = function(value)
            return ResolveSoundLabel(value)
        end,
        setValue = function(value)
            local settings = ensureSettings()
            settings.readySound = value
            settings.soundWhenReady = true
        end,
        preview = PlayConfiguredSound,
        onValueChanged = function(_, _, activeMenu)
            RefreshSettingsIndicators()
            if activeMenu then
                activeMenu:ReinitializeAll()
            end
        end,
    })
    menu:CreateButton(L["Preview sound"], function()
        local current = getSettings()
        PlayConfiguredSound(current and current.readySound)
    end)

    menu:CreateDivider()
    menu:CreateCheckbox(L["TTS when ready"], function()
        local current = getSettings()
        return current and current.ttsWhenReady == true
    end, function()
        local current = ensureSettings()
        current.ttsWhenReady = not current.ttsWhenReady
        if current.ttsWhenReady then
            EnsureReadyTTSText(current, defaultText)
        end
        RefreshSettingsIndicators()
    end)
    menu:CreateButton(L["TTS text"], function()
        StaticPopup_Show("CMC_READY_ALERT_TTS", nil, nil, {
            getSettings = getSettings,
            ensureSettings = ensureSettings,
            defaultText = defaultText,
        })
    end)
end

function ReadyAlerts:AddMenu(rootDescription, styleKey)
    AddConfiguredMenu(rootDescription, function()
        return GetSettings(styleKey, false)
    end, function()
        return GetSettings(styleKey, true)
    end, GetSpellTTSText(ResolveNativeSpellID(styleKey)))
end

function ReadyAlerts:AddTrackerMenu(rootDescription, kind, id)
    AddConfiguredMenu(rootDescription, function()
        return GetTrackerSettings(kind, id, false)
    end, function()
        return GetTrackerSettings(kind, id, true)
    end, kind == "spell" and GetSpellTTSText(id) or nil)
end

function ReadyAlerts:Reset(styleKey)
    local settings = GetSettings(styleKey, false)
    if not settings then
        return
    end
    settings.soundWhenReady = nil
    settings.readySound = nil
    settings.ttsWhenReady = nil
    settings.readyTTSText = nil
    self:RefreshNativeMonitor()
end

function ReadyAlerts:ResetTracker(kind, id)
    local settings = GetTrackerSettings(kind, id, false)
    if not settings then
        return
    end
    settings.soundWhenReady = nil
    settings.readySound = nil
    settings.ttsWhenReady = nil
    settings.readyTTSText = nil
end

function ReadyAlerts:HasSettings(settings)
    return settings and (settings.soundWhenReady == true or settings.readySound ~= nil or settings.ttsWhenReady == true or settings.readyTTSText ~= nil)
        or false
end

function ReadyAlerts:IsEnabled(settings)
    return settings and (settings.soundWhenReady == true or settings.ttsWhenReady == true) or false
end

function ReadyAlerts:UpdateTrackerFrame(frame, kind, id, isOnActualCooldown)
    if not frame or not kind or not id then
        return
    end
    local state = Affected(frame)
    local settings = GetTrackerSettings(kind, id, false)
    if settings and settings.ttsWhenReady then
        EnsureReadyTTSText(settings, kind == "spell" and GetSpellTTSText(id) or nil)
    end
    local itemAvailable = kind ~= "item" or C_Item.GetItemCount(id, false, true) > 0
    if not state.readyAlertTrackerActive or not itemAvailable then
        pendingTrackerAlerts[frame] = nil
        state.readyAlertTrackerIdentity = nil
        state.readyAlertTrackerWasOnActualCooldown = nil
        return
    end
    local identity = kind .. ":" .. id
    isOnActualCooldown = isOnActualCooldown == true
    if state.readyAlertTrackerIdentity ~= identity then
        pendingTrackerAlerts[frame] = nil
        state.readyAlertTrackerIdentity = identity
        state.readyAlertTrackerWasOnActualCooldown = isOnActualCooldown
        return
    end
    if state.readyAlertTrackerWasOnActualCooldown and not isOnActualCooldown then
        if not self:IsEnabled(settings) then
            pendingTrackerAlerts[frame] = nil
        elseif IsTrackerEntryReady(kind, id) then
            TriggerSettings(settings)
        else
            pendingTrackerAlerts[frame] = {
                identity = identity,
                kind = kind,
                id = id,
            }
            SetReadyTickerActive(not nativeLoading)
        end
    elseif isOnActualCooldown then
        pendingTrackerAlerts[frame] = nil
    end
    state.readyAlertTrackerWasOnActualCooldown = isOnActualCooldown
end

function ReadyAlerts:RefreshNativeMonitor()
    local spellSettings = ns.db and ns.db.profile and ns.db.profile.cooldownStyleSettings and ns.db.profile.cooldownStyleSettings.spellSettings
    local activeStyleKeys = GetActiveNativeStyleKeys()
    local refreshed = {}
    for styleKey, settings in pairs(spellSettings or {}) do
        if type(styleKey) == "number" and activeStyleKeys[styleKey] and self:IsEnabled(settings) then
            if settings.ttsWhenReady then
                local spellID = ResolveNativeSpellID(styleKey)
                local defaultText = GetSpellTTSText(spellID)
                EnsureReadyTTSText(settings, defaultText)
            end
            refreshed[styleKey] = nativeStates[styleKey] or {}
        end
    end
    nativeStates = refreshed
    EvaluateNativeStates(true)
end

function ReadyAlerts:Initialize()
    if self.initialized then
        return
    end
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    eventFrame:RegisterEvent("SPELL_UPDATE_CHARGES")
    eventFrame:RegisterEvent("SPELL_UPDATE_USABLE")
    eventFrame:RegisterEvent("SPELLS_CHANGED")
    eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    eventFrame:RegisterEvent("COOLDOWN_VIEWER_DATA_LOADED")
    eventFrame:RegisterEvent("COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED")
    eventFrame:RegisterEvent("COOLDOWN_VIEWER_TABLE_HOTFIXED")
    eventFrame:RegisterEvent("LOADING_SCREEN_ENABLED")
    eventFrame:RegisterEvent("LOADING_SCREEN_DISABLED")
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventFrame:SetScript("OnEvent", function(_, event, unit)
        if event == "LOADING_SCREEN_ENABLED" then
            nativeLoading = true
            StopReadyTicker()
        elseif event == "LOADING_SCREEN_DISABLED" or event == "PLAYER_ENTERING_WORLD" then
            nativeLoading = false
            nativeSuppressedUntil = GetTime() + 2
            self:RefreshNativeMonitor()
        elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
            if not unit or unit == "player" then
                nativeSuppressedUntil = GetTime() + 2
                self:RefreshNativeMonitor()
            end
        elseif
            event == "SPELLS_CHANGED"
            or event == "COOLDOWN_VIEWER_DATA_LOADED"
            or event == "COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED"
            or event == "COOLDOWN_VIEWER_TABLE_HOTFIXED"
        then
            nativeSuppressedUntil = GetTime() + 0.5
            self:RefreshNativeMonitor()
        else
            EvaluateNativeStates(false)
        end
    end)
    self.eventFrame = eventFrame
    EventRegistry:RegisterCallback("CooldownViewerSettings.OnDataChanged", function()
        C_Timer.After(0, function()
            self:RefreshNativeMonitor()
        end)
    end)
    self.initialized = true
    self:RefreshNativeMonitor()
end

ReadyAlerts:Initialize()
