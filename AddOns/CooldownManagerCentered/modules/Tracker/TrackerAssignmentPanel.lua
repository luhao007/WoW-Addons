local _, ns = ...
local L = ns.L
local Affected = ns.API.Affected

local TrackerAssignmentPanel = {}
ns.TrackerAssignmentPanel = TrackerAssignmentPanel
CMCCooldownViewerSettingsTrackerPanel = nil
CMCCooldownViewerSettingsTrackerTab = nil

local DB = ns.TrackerDB
local ItemsData = ns.TrackerItemsData
local ItemVisuals = ns.TrackerItemVisuals
local ItemViewer = ns.TrackerItemViewer

local ITEM_STATE_HIDDEN = ItemsData.ITEM_STATE_HIDDEN
local ENTRY_KIND_WILDCARD_SLOTS = ItemsData.ENTRY_KIND_WILDCARD_SLOTS or "wildcardSlots"

local function RefreshTrackers()
    TrackerAssignmentPanel:RefreshTrackerPanel()
    ItemViewer:RefreshItemViewerFrames()
    if ns.EssentialCustomTracker then
        ns.EssentialCustomTracker:Refresh()
    end
end

-- Asked before enabling the custom tracker from the Cooldown Settings tab. Enables
-- live (no reload); the `data` argument is a continuation run on confirm so the
-- tracker tab only opens once the user actually says yes.
StaticPopupDialogs["CMC_ENABLE_TRACKER"] = {
    text = L["Custom Trackers are disabled. Enable them now?"],
    button1 = _G.YES,
    button2 = _G.NO,
    OnAccept = function(_, data)
        if not ns.db or not ns.db.profile then
            return
        end
        ns.db.profile.tracker_enabled = true
        if ns.TrackerItemViewer then
            ns.TrackerItemViewer:Initialize()
            ns.TrackerItemViewer:ShowAll()
        end
        if type(data) == "function" then
            data()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function IsCustomActiveConfigKind(kind)
    return kind == "spell" or kind == "item"
end

local function IsCustomActiveMenuSupportedKind(kind, id)
    return IsCustomActiveConfigKind(kind) or (kind == ENTRY_KIND_WILDCARD_SLOTS and not ItemsData:IsSpellCategoryWildcard(id))
end

local function ResolveCustomActiveTarget(kind, id)
    if kind == ENTRY_KIND_WILDCARD_SLOTS then
        local wildcardItemID = ItemsData.GetWildcardSlotItemID and ItemsData:GetWildcardSlotItemID(id) or nil
        if wildcardItemID then
            return "item", wildcardItemID
        end
        return nil, nil
    end

    if IsCustomActiveConfigKind(kind) and id then
        return kind, id
    end

    return nil, nil
end

local function IsConsumableEntry(kind, id)
    if kind ~= "item" then
        return false
    end
    return select(6, C_Item.GetItemInfoInstant(id)) == Enum.ItemClass.Consumable
end

-- Proc/passive trinkets (no on-use spell) have no ready state.
local function EntryHasReadyState(kind, id)
    local AuraDurations = ns.TrackerAuraDurations
    if AuraDurations and AuraDurations.HasProc and AuraDurations:HasProc(kind, id) then
        return false
    end
    if kind == "spell" then
        return true
    end
    if kind == ENTRY_KIND_WILDCARD_SLOTS and ItemsData:IsSpellCategoryWildcard(id) then
        return true
    end
    return select(2, C_Item.GetItemSpell(id)) ~= nil
end

local function EntryHasCharges(kind, id)
    local spellID
    if kind == "spell" then
        spellID = id
    else
        local resolvedKind, resolvedID = ResolveCustomActiveTarget(kind, id)
        if resolvedKind == "item" and resolvedID then
            spellID = select(2, C_Item.GetItemSpell(resolvedID))
        end
    end
    if not spellID then
        return false
    end
    local charges = C_Spell.GetSpellCharges(spellID)
    return charges and charges.maxCharges > 1 or false
end

local function FormatCustomActiveValue(value)
    local numeric = tonumber(value) or 0
    if math.abs(numeric - math.floor(numeric)) < 0.000001 then
        return tostring(math.floor(numeric))
    end
    return string.format("%g", numeric)
end

local function ParseCustomActiveInput(text)
    local trimmed = strtrim(text or "")
    if trimmed == "" then
        return nil
    end

    local value = tonumber(trimmed)
    if not value then
        return nil
    end
    if value < 0 then
        return nil
    end

    return value
end

local function SetCustomActiveAcceptEnabled(dialog, enabled)
    if not dialog or not dialog.GetName then
        return
    end
    local acceptButton = _G[dialog:GetName() .. "Button1"]
    if acceptButton and acceptButton.SetEnabled then
        acceptButton:SetEnabled(enabled == true)
    end
end

local function ValidateCustomActivePopup(dialog)
    if not dialog then
        return nil
    end
    local editBox = dialog.editBox or (dialog.GetEditBox and dialog:GetEditBox())
    if not editBox then
        return nil
    end
    local value = ParseCustomActiveInput(editBox:GetText())
    SetCustomActiveAcceptEnabled(dialog, value ~= nil)
    return value
end

-- Manual custom-active-time popup. Only surfaced for entries we have no auto
-- duration data for (see the context menu gate below).
StaticPopupDialogs["CMC_SET_CUSTOM_ACTIVE"] = {
    text = string.format(L["Set custom active time (seconds).\nCurrent value: %s"], "0"),
    button1 = _G.ACCEPT,
    button2 = _G.CANCEL,
    hasEditBox = true,
    maxLetters = 32,
    autoCompleteParams = nil,
    OnShow = function(self)
        local data = self.data
        if not data or not IsCustomActiveConfigKind(data.kind) or not data.id then
            self:Hide()
            return
        end

        local currentValue = DB.GetCustomActiveDuration(data.kind, data.id) or 0
        local textWidget = self.text or _G[self:GetName() .. "Text"]
        if textWidget then
            textWidget:SetText(string.format(L["Set custom active time (seconds).\nCurrent value: %s"], FormatCustomActiveValue(currentValue)))
        end

        local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
        if editBox then
            editBox:SetText(FormatCustomActiveValue(currentValue))
            editBox:HighlightText()
            editBox:SetFocus()
        end

        ValidateCustomActivePopup(self)
    end,
    OnAccept = function(self)
        local data = self.data
        if not data or not IsCustomActiveConfigKind(data.kind) or not data.id then
            return
        end

        local value = ValidateCustomActivePopup(self)
        if value == nil then
            ns.Addon:Print(L["Custom active value must be a non-negative number."])
            return
        end

        DB.SetCustomActiveDuration(data.kind, data.id, value)
        TrackerAssignmentPanel:RefreshTrackerPanel()
        ItemViewer:RefreshItemViewerFrames()
    end,
    EditBoxOnTextChanged = function(self)
        ValidateCustomActivePopup(self:GetParent())
    end,
    EditBoxOnEnterPressed = function(self)
        local popup = self:GetParent()
        if ValidateCustomActivePopup(popup) ~= nil then
            StaticPopup_OnClick(popup, 1)
        else
            ns.Addon:Print(L["Custom active value must be a non-negative number."])
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

local function ParseAuraSpellIDInput(text)
    local value = tonumber(strtrim(text or ""))
    if not value or value < 0 or value ~= math.floor(value) then
        return nil
    end
    return value
end

local function ValidateAuraSpellIDPopup(dialog)
    if not dialog then
        return nil
    end
    local editBox = dialog.editBox or (dialog.GetEditBox and dialog:GetEditBox())
    if not editBox then
        return nil
    end
    local value = ParseAuraSpellIDInput(editBox:GetText())
    SetCustomActiveAcceptEnabled(dialog, value ~= nil)
    return value
end

StaticPopupDialogs["CMC_SET_TRACKER_AURA"] = {
    text = string.format(L["Set Aura Spell ID. Enter 0 to clear.\n%s"], L["Current value: 0"]),
    button1 = _G.ACCEPT,
    button2 = _G.CANCEL,
    hasEditBox = true,
    maxLetters = 10,
    autoCompleteParams = nil,
    OnShow = function(self)
        local data = self.data
        if not data or not IsCustomActiveConfigKind(data.kind) or not data.id then
            self:Hide()
            return
        end

        local configuredValue = DB.GetAuraSpellID(data.kind, data.id)
        local suggestedValue = data.kind == "spell" and tonumber(data.id) or nil
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
        ValidateAuraSpellIDPopup(self)
    end,
    OnAccept = function(self)
        local data = self.data
        local value = ValidateAuraSpellIDPopup(self)
        if not data or value == nil then
            ns.Addon:Print(L["Aura Spell ID must be a non-negative whole number."])
            return
        end
        DB.SetAuraSpellID(data.kind, data.id, value)
        TrackerAssignmentPanel:RefreshTrackerPanel()
        ItemViewer:RefreshItemViewerFrames()
    end,
    EditBoxOnTextChanged = function(self)
        ValidateAuraSpellIDPopup(self:GetParent())
    end,
    EditBoxOnEnterPressed = function(self)
        local popup = self:GetParent()
        if ValidateAuraSpellIDPopup(popup) ~= nil then
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

function TrackerAssignmentPanel:OnTrackerDisabled()
    if CMCCooldownViewerSettingsTrackerPanel and CMCCooldownViewerSettingsTrackerPanel:IsShown() then
        CMCCooldownViewerSettingsTrackerPanel:Hide()
    end
end

local function GetEntryKindAndID(button)
    if not button then
        return nil, nil
    end
    return Affected(button).trackerEntryKind, Affected(button).trackerEntryId
end

local function SetButtonEntry(button, kind, id)
    if not button then
        return
    end
    Affected(button).trackerEntryKind = kind
    Affected(button).trackerEntryId = id
    if kind == "item" then
        button.itemID = id
        button.spellID = nil
    elseif kind == "spell" then
        button.itemID = nil
        button.spellID = ItemsData:GetDisplaySpellID(id) or id
    else
        button.itemID = nil
        button.spellID = nil
    end
end

local function GetStoredEntrySettings(kind, id)
    if kind == "spell" then
        return DB.GetSpellItemSettings(id)
    elseif kind == "item" then
        return DB.GetItemSettings(id)
    elseif kind == ENTRY_KIND_WILDCARD_SLOTS then
        return DB.GetWildcardSlotSettings(id)
    end
    return nil
end

local function SettingsHaveTrackerOverrides(settings, kind, id)
    if type(settings) ~= "table" then
        return false
    end
    return (IsConsumableEntry(kind, id) and settings.alwaysShow == true)
        or (type(settings.hiddenForSpecs) == "table" and next(settings.hiddenForSpecs) ~= nil)
        or (kind == "spell" and settings.procGlow == false)
        or (EntryHasReadyState(kind, id) and settings.glowWhenReady == true)
        or (EntryHasCharges(kind, id) and settings.glowOnFullCharges == true)
        or settings.glowWhenAuraActive == true
        or (kind == "spell" and settings.glowWhenSuggested == true)
        or DB.GetEntryColor(kind, id, "glowColor") ~= nil
        or DB.GetEntryColor(kind, id, "stackColor") ~= nil
        or (IsCustomActiveMenuSupportedKind(kind, id) and settings.hideAura == true)
        or (IsCustomActiveMenuSupportedKind(kind, id) and (tonumber(settings.auraSpellID) or 0) > 0)
        or (IsCustomActiveMenuSupportedKind(kind, id) and (tonumber(settings.customActiveDuration) or 0) > 0)
end

local function EntryHasReadyAlertEnabled(kind, id)
    if not ns.ReadyAlerts or not kind or not id then
        return false
    end
    if ns.ReadyAlerts:IsEnabled(GetStoredEntrySettings(kind, id)) then
        return true
    end
    local targetKind, targetID = ResolveCustomActiveTarget(kind, id)
    if targetKind ~= kind or targetID ~= id then
        return ns.ReadyAlerts:IsEnabled(GetStoredEntrySettings(targetKind, targetID))
    end
    return false
end

local function EntryHasTrackerOverrides(kind, id)
    if not kind or not id then
        return false
    end
    if SettingsHaveTrackerOverrides(GetStoredEntrySettings(kind, id), kind, id) then
        return true
    end

    -- Wildcard trinket slots store aura, duration, and glow overrides on the
    -- currently equipped item, while state/order remain attached to the slot.
    local targetKind, targetID = ResolveCustomActiveTarget(kind, id)
    if targetKind ~= kind or targetID ~= id then
        return SettingsHaveTrackerOverrides(GetStoredEntrySettings(targetKind, targetID), targetKind, targetID)
    end
    return false
end

local function GetOrCreateTrackerOverrideIndicator(button)
    local indicator = Affected(button).trackerOverrideIndicator
    if indicator then
        return indicator
    end

    indicator = CreateFrame("Frame", nil, button)
    indicator:SetHeight(14)
    indicator:SetFrameLevel(button:GetFrameLevel() + 20)
    indicator:EnableMouse(false)

    local background = indicator:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(indicator)
    background:SetColorTexture(0, 0, 0, 0.7)

    local eye = indicator:CreateTexture(nil, "ARTWORK")
    eye:SetSize(16, 16)
    eye:SetAtlas("common-icon-visual")
    eye:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))

    local specHidden = indicator:CreateTexture(nil, "ARTWORK")
    specHidden:SetSize(16, 16)
    specHidden:SetAtlas("talents-heroclass-ring-minimize-hide")
    specHidden:SetDesaturated(true)
    specHidden:SetVertexColor(1, 0.1, 0.1, 1)

    local voice = indicator:CreateTexture(nil, "ARTWORK")
    voice:SetSize(16, 16)
    voice:SetAtlas("chatframe-button-icon-voicechat")
    voice:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))

    indicator.Background = background
    indicator.Eye = eye
    indicator.SpecHidden = specHidden
    indicator.Voice = voice
    Affected(button).trackerOverrideIndicator = indicator
    return indicator
end

local function RefreshTrackerOverrideIndicator(button)
    if not button or not button.Icon then
        return
    end

    local kind, id = GetEntryKindAndID(button)
    local indicator = GetOrCreateTrackerOverrideIndicator(button)
    indicator:ClearAllPoints()
    indicator:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", 0, -2)
    indicator:SetPoint("TOPRIGHT", button.Icon, "TOPRIGHT", 0, -2)
    indicator:SetFrameLevel(button:GetFrameLevel() + 20)
    local hasOverrides = EntryHasTrackerOverrides(kind, id)
    local hasReadyAlert = EntryHasReadyAlertEnabled(kind, id)
    local hiddenForCurrentSpec = kind ~= nil and id ~= nil and DB.IsHiddenForCurrentSpec(kind, id)

    local icons = {}
    if hasOverrides then
        icons[#icons + 1] = indicator.Eye
    end
    if hasReadyAlert then
        icons[#icons + 1] = indicator.Voice
    end
    if hiddenForCurrentSpec then
        icons[#icons + 1] = indicator.SpecHidden
    end
    for index, icon in ipairs(icons) do
        icon:ClearAllPoints()
        icon:SetPoint("CENTER", indicator, "CENTER", (index - (#icons + 1) / 2) * 16, 0)
    end
    indicator.Eye:SetShown(hasOverrides)
    indicator.Voice:SetShown(hasReadyAlert)
    indicator.SpecHidden:SetShown(hiddenForCurrentSpec)
    indicator:SetShown(#icons > 0)
end

local function SetWildcardGlow(button, kind, id)
    if not button then
        return
    end

    if kind == ENTRY_KIND_WILDCARD_SLOTS then
        if not Affected(button).trackerWildcardGlow then
            Affected(button).trackerWildcardGlowFrame = CreateFrame("Frame", nil, button)
            Affected(button).trackerWildcardGlowFrame:SetAllPoints(button.Icon or button)
            Affected(button).trackerWildcardGlowFrame:SetFrameStrata("HIGH")
            Affected(button).trackerWildcardGlowFrame:SetFrameLevel(20)
            local glow = Affected(button).trackerWildcardGlowFrame:CreateTexture(nil, "ARTWORK")

            glow:SetAtlas("UI-CooldownManager-ActiveGlow", false)
            glow:ClearAllPoints()
            glow:SetPoint("CENTER", button.Icon or button, "CENTER", 0, 0)
            glow:SetSize(58, 58)
            Affected(button).trackerWildcardGlow = glow
        end
        if not Affected(button).trackerWildcardName then
            local name = Affected(button).trackerWildcardGlowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalOutline")
            name:SetFontHeight(11)
            name:SetPoint("BOTTOM", button.Icon or button, "BOTTOM", 0, -4)
            name:SetTextColor(1, 0.8, 0.2, 1)
            Affected(button).trackerWildcardName = name
        end
        Affected(button).trackerWildcardName:SetText(ItemsData:GetWildcardSlotLabel(id) or L["Trinket\nSlot"])
        Affected(button).trackerWildcardGlow:Show()
        Affected(button).trackerWildcardName:Show()
    else
        if Affected(button).trackerWildcardGlow then
            Affected(button).trackerWildcardGlow:Hide()
        end
        if Affected(button).trackerWildcardName then
            Affected(button).trackerWildcardName:Hide()
        end
    end
end

local function BuildEntry(kind, id)
    if not kind or not id then
        return nil
    end
    return {
        kind = kind,
        id = id,
    }
end

local function SetIconFromEntry(target, kind, id)
    if not target or not target.Icon then
        return
    end
    if kind == "native" then
        local info = C_CooldownViewer.GetCooldownViewerCooldownInfo(id)
        local spellID = info and (info.overrideSpellID or info.spellID)
        target.Icon:SetTexture(spellID and C_Spell.GetSpellTexture(spellID) or 134400)
        return
    end
    local qualityItemID = nil
    if kind == "item" then
        qualityItemID = id
    end
    local quality = qualityItemID and C_TradeSkillUI.GetItemReagentQualityByItemInfo(qualityItemID) or nil
    local itemInfo = kind == ENTRY_KIND_WILDCARD_SLOTS and {} or { C_Item.GetItemInfo(id) }
    local expansionNumber = itemInfo and itemInfo[15] or nil
    if quality then
        if not target.Icon._quality then
            target.Icon._quality_frame = CreateFrame("Frame", nil, target)
            target.Icon._quality_frame:SetAllPoints(target.Icon)
            target.Icon._quality_frame:SetFrameStrata("HIGH")
            target.Icon._quality_frame:SetFrameLevel(20)
            target.Icon._quality = target.Icon._quality_frame:CreateTexture(nil, "ARTWORK")
            target.Icon._quality:SetSize(33, 28)
        end
        if expansionNumber and expansionNumber >= 11 then -- game version - 1 (1 is vanilla)
            target.Icon._quality:SetAtlas("Professions-Icon-Quality-12-Tier" .. quality .. "-Inv", false)
        else
            target.Icon._quality:SetAtlas("Professions-Icon-Quality-Tier" .. quality .. "-Inv", false)
        end

        target.Icon._quality:Show()
        target.Icon._quality:ClearAllPoints()
        target.Icon._quality:SetPoint("TOPLEFT", target.Icon, "TOPLEFT", -4, 4)
    else
        if target.Icon._quality then
            target.Icon._quality:Hide()
        end
    end

    if ItemVisuals.GetEntryIcon then
        target.Icon:SetTexture(ItemVisuals:GetEntryIcon(kind, id))
        return
    end
    local icon = nil
    if kind == "spell" then
        icon = C_Spell.GetSpellTexture(id)
    else
        icon = C_Item.GetItemIconByID(id)
    end
    target.Icon:SetTexture(icon or 134400)
end

---@param button Frame
---@param shown boolean
local function SetEssentialNativeLock(button, shown)
    if not button then
        return
    end
    ---@type Frame?
    local lockFrame = Affected(button).essentialNativeLockFrame
    if shown and not lockFrame then
        lockFrame = CreateFrame("Frame", nil, button)
        lockFrame:SetAllPoints(button)
        lockFrame:EnableMouse(false)

        local lock = lockFrame:CreateTexture(nil, "OVERLAY", nil, 7)
        lock:SetAtlas("Forge-Lock", true)
        lock:SetScale(0.4)
        lock:SetPoint("TOPRIGHT", button, "TOPRIGHT", 14, 14)
        lock:SetDesaturated(true)
        lock:SetVertexColor(0.3, 1, 1, 1)
        lockFrame.Lock = lock
        Affected(button).essentialNativeLockFrame = lockFrame
    end
    if lockFrame then
        lockFrame:SetFrameLevel(button:GetFrameLevel() + 30)
        lockFrame:SetShown(shown == true)
    end
end

local function IsEntryUsable(owned, kind, id)
    if not owned then
        return false
    end
    if kind == "spell" then
        return owned.spells[id] == true
    end
    if kind == ENTRY_KIND_WILDCARD_SLOTS then
        return owned.wildcardSlots and owned.wildcardSlots[id]
    end
    return owned.items[id]
end

local function HandleCursorDrop(state)
    if InCombatLockdown() then
        return false
    end
    local cursorType, cursorID, _, cursorSpellID = GetCursorInfo()
    if not cursorType then
        return false
    end

    local kind, id
    if cursorType == "spell" then
        local spellID = cursorSpellID or cursorID
        if not spellID then
            return false
        end
        id = ItemsData:GetCanonicalSpellID(spellID)
        kind = "spell"
    elseif cursorType == "item" then
        if not cursorID then
            return false
        end
        id = cursorID
        kind = "item"
    end

    if not kind or not id then
        return false
    end
    local ok, error = ns.API:AddToTracking(kind, id, state)
    if not ok then
        ns.Addon:Print(error)
    end
    if ok and state == "essential" and ns.EssentialCustomTracker then
        ns.EssentialCustomTracker:EnsureEntryOrder(kind, id)
    end

    ClearCursor()
    return true
end

local function IsCursorDroppable()
    local cursorType = GetCursorInfo()
    return cursorType == "spell" or cursorType == "item" or cursorType == "action"
end

local function UpdateDropOverlay(category, overlay)
    if not overlay then
        return
    end
    -- The highlight atlas needs a positive-height rect. Empty sections collapse
    -- below the 48px the old 24px insets assumed, so short sections use a
    -- full-height highlight instead of an inverted (invisible) texture.
    local height = category:GetHeight() or 0
    local inset = height >= 48 and 24 or 0
    overlay:ClearAllPoints()
    overlay:SetPoint("TOPLEFT", category, "TOPLEFT", 8, -inset)
    overlay:SetPoint("BOTTOMRIGHT", category, "BOTTOMRIGHT", -8, inset)
end

local function EnsureDropPlaceholder(category)
    if Affected(category).trackerDropPlaceholder then
        return Affected(category).trackerDropPlaceholder
    end

    local dropZone = CreateFrame("Frame", nil, category)
    dropZone:SetAllPoints(category)
    dropZone:EnableMouse(true)
    local baseLevel = (category.Container and category.Container:GetFrameLevel()) or category:GetFrameLevel()
    dropZone:SetFrameLevel(baseLevel + 100)
    dropZone:Hide()

    local overlay = dropZone:CreateTexture(nil, "OVERLAY")
    overlay:SetAtlas("UI-Dream-Highlight-Top", false)
    overlay:SetAlpha(0.65)
    UpdateDropOverlay(category, overlay)
    dropZone.Texture = overlay

    local function drop()
        dropZone:Hide()
        HandleCursorDrop(category.state)
    end
    dropZone:SetScript("OnReceiveDrag", drop)
    dropZone:SetScript("OnMouseUp", function(_, btn)
        if btn == "LeftButton" and IsCursorDroppable() then
            drop()
        end
    end)

    dropZone:SetScript("OnLeave", function()
        dropZone:Hide()
    end)

    Affected(category).trackerDropPlaceholder = dropZone
    return dropZone
end

local function ShowDropPlaceholder(category, show)
    local dropZone = EnsureDropPlaceholder(category)
    if not dropZone then
        return
    end
    UpdateDropOverlay(category, dropZone.Texture)
    dropZone:SetShown(show == true)
end

local function IsReordering()
    return ns.DragDrop:IsDragging()
end

local function SetReorderTarget(target)
    ns.DragDrop:SetTarget(target)
end

local function CancelOrderChange()
    ns.DragDrop:Cancel()
end

local function BeginOrderChange(itemButton, eatNextGlobalMouseUp)
    if ns.DragDrop:IsDragging() or not itemButton or Affected(itemButton).trackerEmpty or Affected(itemButton).essentialNative then
        return
    end

    if itemButton.SetReorderLocked then
        itemButton:SetReorderLocked(true)
    end

    ns.DragDrop:Begin(CMCCooldownViewerSettingsTrackerPanel, itemButton, {
        eatNextGlobalMouseUp = eatNextGlobalMouseUp,
        cursorSize = 38,
        markerSize = 8,
        markerHeight = 38,
        cursorTexture = function(source)
            return source.Icon and source.Icon:GetTexture()
        end,
        getBestTarget = function(target, cursorX, cursorY)
            return target.GetBestCooldownItemTarget and target:GetBestCooldownItemTarget(cursorX, cursorY) or nil
        end,
        updateMarkerPosition = function(targetButton, markerFrame, cursorX, cursorY)
            return targetButton.UpdateReorderMarkerPosition and targetButton:UpdateReorderMarkerPosition(markerFrame, cursorX, cursorY)
        end,
        onCancel = function(source)
            if source.SetReorderLocked then
                source:SetReorderLocked(false)
            end
        end,
        onDrop = function(sourceItem, target, targetItem, offset)
            local appendCategory = (target and target.headerDropActive) and target or nil
            if sourceItem and appendCategory then
                if appendCategory.headerHighlight then
                    appendCategory.headerHighlight:Hide()
                end
                local targetState = appendCategory.state or sourceItem.categoryState
                local sourceKind, sourceID = GetEntryKindAndID(sourceItem)
                if sourceKind and sourceID then
                    if targetState == "essential" and ns.EssentialCustomTracker then
                        if sourceItem.categoryState ~= targetState then
                            ItemsData:SetEntryState(sourceKind, sourceID, targetState)
                        end
                        ns.EssentialCustomTracker:EnsureEntryOrder(sourceKind, sourceID)
                    else
                        if sourceItem.categoryState ~= targetState then
                            ItemsData:SetEntryState(sourceKind, sourceID, targetState)
                        end
                        ItemsData:InsertItemAt(targetState, BuildEntry(sourceKind, sourceID), nil, false)
                    end
                end
            elseif sourceItem and targetItem and sourceItem ~= targetItem then
                local targetState = targetItem.categoryState or sourceItem.categoryState
                local sourceKind, sourceID = GetEntryKindAndID(sourceItem)
                if sourceKind and sourceID then
                    if targetState == "essential" and ns.EssentialCustomTracker then
                        local targetKind, targetID = GetEntryKindAndID(targetItem)
                        if sourceItem.categoryState ~= targetState then
                            ItemsData:SetEntryState(sourceKind, sourceID, targetState)
                        end
                        if Affected(targetItem).trackerEmpty then
                            ns.EssentialCustomTracker:EnsureEntryOrder(sourceKind, sourceID)
                        elseif targetKind and targetID then
                            ns.EssentialCustomTracker:MoveEntry(sourceKind, sourceID, targetKind, targetID, offset == 0)
                        end
                    elseif Affected(targetItem).trackerEmpty then
                        if sourceItem.categoryState ~= targetState then
                            ItemsData:SetEntryState(sourceKind, sourceID, targetState)
                        end
                        ItemsData:InsertItemAt(targetState, BuildEntry(sourceKind, sourceID), nil, false)
                    else
                        local targetKind, targetID = GetEntryKindAndID(targetItem)
                        if targetKind and targetID then
                            if sourceItem.categoryState ~= targetState then
                                ItemsData:SetEntryState(sourceKind, sourceID, targetState)
                            end
                            ItemsData:InsertItemAt(targetState, BuildEntry(sourceKind, sourceID), BuildEntry(targetKind, targetID), offset == 0)
                        end
                    end
                end
            end
            RefreshTrackers()
        end,
    })
end

local function ShowItemContextMenu(button)
    if not button or Affected(button).essentialNative then
        return
    end
    local kind, id = GetEntryKindAndID(button)
    if not kind or not id then
        return
    end
    local currentState = button.categoryState

    local function Generator(owner, rootDescription)
        -- Entries with curated/proc data show a disabled info button stating the
        -- source. Only entries we have NO data for get the manual "Set Custom
        -- Active" option (the manual duration logic stays on for those).
        if currentState ~= ITEM_STATE_HIDDEN and IsCustomActiveMenuSupportedKind(kind, id) then
            local targetKind, targetID = ResolveCustomActiveTarget(kind, id)
            local AuraDurations = ns.TrackerAuraDurations
            local cooldownMenu = rootDescription:CreateButton(L["Cooldown"])

            if targetKind and targetID then
                cooldownMenu:CreateCheckbox(L["Hide Aura"], function()
                    return DB.GetHideAura(targetKind, targetID)
                end, function()
                    DB.ToggleHideAura(targetKind, targetID)
                    RefreshTrackers()
                end)
            end

            if ns.AuraTracking and ns.AuraTracking:IsSupported() then
                local auraSpellID = targetKind and targetID and DB.GetAuraSpellID(targetKind, targetID) or nil
                local auraLabel = auraSpellID and string.format(L["Set Aura (id: %s)"], auraSpellID) or L["Set Aura"]
                if not targetKind or not targetID then
                    auraLabel = L["Set Aura (equip trinket first)"]
                end
                cooldownMenu:CreateButton(auraLabel, function()
                    local popupKind, popupID = ResolveCustomActiveTarget(kind, id)
                    if not popupKind or not popupID then
                        local wildcardName = ItemsData:GetEntryName(kind, id) or tostring(id)
                        ns.Addon:Print(string.format(L["%s: no equipped trinket to set an aura."], wildcardName))
                        return
                    end
                    StaticPopup_Show("CMC_SET_TRACKER_AURA", nil, nil, { kind = popupKind, id = popupID })
                end)
            end

            local isProc = false
            local knownDuration = 0
            if targetKind and targetID and AuraDurations then
                isProc = AuraDurations.HasProc and AuraDurations:HasProc(targetKind, targetID) or false
                knownDuration = (AuraDurations.GetKnownDuration and AuraDurations:GetKnownDuration(targetKind, targetID)) or 0
            end

            if isProc then
                local info = cooldownMenu:CreateButton(L["Duration from procs"], function() end)
                if info and info.SetEnabled then
                    info:SetEnabled(false)
                end
            elseif knownDuration > 0 then
                local info = cooldownMenu:CreateButton(string.format(L["Auto duration: %ss"], FormatCustomActiveValue(knownDuration)), function() end)
                if info and info.SetEnabled then
                    info:SetEnabled(false)
                end
            else
                local currentValue = 0
                if targetKind and targetID then
                    currentValue = DB.GetCustomActiveDuration(targetKind, targetID) or 0
                end

                local label = string.format(L["Set Custom Active (%ss)"], FormatCustomActiveValue(currentValue))
                if not targetKind or not targetID then
                    label = L["Set Custom Active (equip trinket first)"]
                end

                cooldownMenu:CreateButton(label, function()
                    local popupKind, popupID = ResolveCustomActiveTarget(kind, id)
                    if not popupKind or not popupID then
                        local wildcardName = ItemsData:GetEntryName(kind, id) or tostring(id)
                        ns.Addon:Print(string.format(L["%s: no equipped trinket to set custom active."], wildcardName))
                        return
                    end
                    StaticPopup_Show("CMC_SET_CUSTOM_ACTIVE", nil, nil, { kind = popupKind, id = popupID })
                end)
            end
        end
        if currentState ~= ITEM_STATE_HIDDEN then
            if IsConsumableEntry(kind, id) then
                rootDescription:CreateCheckbox(L["Always Show"], function()
                    return DB.GetAlwaysShow(kind, id)
                end, function()
                    DB.SetAlwaysShow(kind, id, not DB.GetAlwaysShow(kind, id))
                    RefreshTrackers()
                end)
            end

            local hideForMenu = rootDescription:CreateButton(L["Hide for"])
            local _, _, classID = UnitClass("player")
            local specCount = classID and C_SpecializationInfo.GetNumSpecializationsForClassID(classID) or 0
            local sex = UnitSex("player")
            for specIndex = 1, specCount do
                local specID, specName, _, specIcon = GetSpecializationInfoForClassID(classID, specIndex, sex)
                if specID and specName then
                    local label = CreateTextureMarkup(specIcon, 64, 64, 16, 16, 0, 1, 0, 1) .. " " .. specName
                    hideForMenu:CreateCheckbox(label, function()
                        return DB.IsHiddenForSpec(kind, id, specID)
                    end, function()
                        DB.SetHiddenForSpec(kind, id, specID, not DB.IsHiddenForSpec(kind, id, specID))
                        RefreshTrackers()
                    end)
                end
            end

            -- Wildcard slots resolve to the equipped item, matching the live tracker.
            local glowKind, glowID = ResolveCustomActiveTarget(kind, id)
            if glowKind and glowID then
                local glowColorMenu = rootDescription:CreateButton(L["Glow & Color"])
                if glowKind == "spell" then
                    local procGlow = glowColorMenu:CreateCheckbox(L["Proc Glow"], function()
                        return DB.GetProcGlowEnabled(glowID)
                    end, function()
                        DB.SetProcGlowEnabled(glowID, not DB.GetProcGlowEnabled(glowID))
                        ItemViewer:RefreshProcGlows()
                        TrackerAssignmentPanel:RefreshTrackerPanel()
                    end)
                    procGlow:SetTooltip(function(tooltip)
                        GameTooltip_AddNormalLine(tooltip, L["Use Blizzard's Spell Activation Overlay state for this tracked spell."])
                    end)
                end
                local function GlowCheckbox(label, field)
                    glowColorMenu:CreateCheckbox(label, function()
                        return DB.GetGlowFlag(glowKind, glowID, field)
                    end, function()
                        DB.ToggleGlowFlag(glowKind, glowID, field)
                        if field == "glowWhenSuggested" and ns.Assistant then
                            ns.Assistant:RefreshSuggestionTracking()
                        end
                        RefreshTrackers()
                    end)
                end
                if EntryHasReadyState(glowKind, glowID) then
                    GlowCheckbox(L["Glow when Ready"], "glowWhenReady")
                end
                if EntryHasCharges(glowKind, glowID) then
                    GlowCheckbox(L["Glow when full charges"], "glowOnFullCharges")
                end
                if IsCustomActiveMenuSupportedKind(glowKind, glowID) then
                    GlowCheckbox(L["Glow when Aura Active"], "glowWhenAuraActive")
                end
                if glowKind == "spell" then
                    GlowCheckbox(L["Glow when Suggested"], "glowWhenSuggested")
                end

                local function AddColorOverride(field, label, fallbackColor)
                    local function getColor()
                        return DB.GetEntryColor(glowKind, glowID, field)
                    end
                    local function setColor(r, g, b)
                        DB.SetEntryColor(glowKind, glowID, field, r, g, b)
                    end
                    ns.CooldownStyle.AddMenuColorButton(glowColorMenu, label, getColor, setColor, RefreshTrackers, fallbackColor)
                end
                AddColorOverride("glowColor", L["Set Glow Color"], ns.CooldownStyle.GetInheritedGlowColor())
                AddColorOverride("stackColor", L["Set Number Color"], { 1, 1, 1 })
                ns.CooldownStyle.AddGlobalGlowOnlyInCombatMenu(glowColorMenu)
            end
        end
        local alertKind, alertID = ResolveCustomActiveTarget(kind, id)
        if ns.ReadyAlerts and alertKind and alertID and EntryHasReadyState(alertKind, alertID) then
            ns.ReadyAlerts:AddTrackerMenu(rootDescription, alertKind, alertID)
        end
        if kind == ENTRY_KIND_WILDCARD_SLOTS and not ItemsData:IsSpellCategoryWildcard(id) then
            local passive = rootDescription:CreateCheckbox(L["Show Trackable Passive Trinkets"], DB.GetShowingPassiveTrinkets, DB.ToggleShowPassiveTrinkets)
            passive:SetTooltip(function(tooltip)
                GameTooltip_AddNormalLine(
                    tooltip,
                    L["Track passive (proc) trinkets equipped in the wildcard trinket slots. Turn off to only track trinkets with an on-use effect."]
                )
            end)
        end
        if currentState ~= ITEM_STATE_HIDDEN then
            rootDescription:CreateButton(L["Reset to Defaults"], function()
                if IsConsumableEntry(kind, id) then
                    DB.SetAlwaysShow(kind, id, false)
                end
                DB.ClearHiddenForSpecs(kind, id)
                local resetKind, resetID = ResolveCustomActiveTarget(kind, id)
                if resetKind and resetID then
                    DB.SetHideAura(resetKind, resetID, false)
                    DB.SetAuraSpellID(resetKind, resetID, 0)
                    DB.SetCustomActiveDuration(resetKind, resetID, 0)
                    if resetKind == "spell" then
                        DB.SetProcGlowEnabled(resetID, true)
                    end
                    DB.SetGlowFlag(resetKind, resetID, "glowWhenReady", false)
                    DB.SetGlowFlag(resetKind, resetID, "glowOnFullCharges", false)
                    DB.SetGlowFlag(resetKind, resetID, "glowWhenAuraActive", false)
                    DB.SetGlowFlag(resetKind, resetID, "glowWhenSuggested", false)
                    DB.SetEntryColor(resetKind, resetID, "glowColor")
                    DB.SetEntryColor(resetKind, resetID, "stackColor")
                    if ns.ReadyAlerts then
                        ns.ReadyAlerts:ResetTracker(resetKind, resetID)
                    end
                end
                RefreshTrackers()
                if ns.Assistant then
                    ns.Assistant:RefreshSuggestionTracking()
                end
            end)
        end
        rootDescription:CreateButton(L["Untrack"], function()
            ItemsData:SetEntryState(kind, id, nil)
            RefreshTrackers()
        end)
    end

    MenuUtil.CreateContextMenu(button, Generator)
end

local function InitializeItemButton(button)
    if not button.Icon then
        button:SetSize(38, 38)
        button:EnableMouse(true)

        local icon = button:CreateTexture(nil, "ARTWORK")
        icon:SetAllPoints(button)
        button.Icon = icon

        local highlight = button:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints(button)
        highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
        highlight:SetBlendMode("ADD")
        button.Highlight = highlight
    end
    if Affected(button).trackerInitialized then
        return
    end

    if button.Cooldown then
        if ItemVisuals then
            ItemVisuals:ClearCooldown(button, nil)
        else
            CooldownFrame_Clear(button.Cooldown)
            button.Cooldown:SetDrawSwipe(false)
        end
        button.Cooldown:SetDrawEdge(false)
    end

    if button.OutOfRange then
        button.OutOfRange:Hide()
    end

    button:SetScript("OnMouseUp", function(self, mouseButton)
        if Affected(self).essentialNative then
            return
        end
        if mouseButton == "RightButton" then
            ShowItemContextMenu(self)
        elseif mouseButton == "LeftButton" and not Affected(self).trackerEmpty then
            if PlaySound and SOUNDKIT and SOUNDKIT.UI_CURSOR_PICKUP_OBJECT then
                PlaySound(SOUNDKIT.UI_CURSOR_PICKUP_OBJECT)
            end
            BeginOrderChange(self, mouseButton)
        end
    end)
    button:RegisterForDrag("LeftButton")
    button:SetScript("OnDragStart", function(self)
        if Affected(self).trackerEmpty or Affected(self).essentialNative then
            return
        end
        if PlaySound and SOUNDKIT and SOUNDKIT.UI_CURSOR_PICKUP_OBJECT then
            PlaySound(SOUNDKIT.UI_CURSOR_PICKUP_OBJECT)
        end
        BeginOrderChange(self)
    end)
    button:SetScript("OnEnter", function(self)
        SetReorderTarget(self)
        if Affected(self).trackerEmpty then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if GameTooltip_SetTitle then
                GameTooltip_SetTitle(GameTooltip, L["Empty Slot"])
            else
                GameTooltip:SetText(L["Empty Slot"])
            end
            GameTooltip:Show()
        else
            local kind, id = GetEntryKindAndID(self)
            if kind and id then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                if kind == ENTRY_KIND_WILDCARD_SLOTS then
                    local wildcardName = ItemsData:GetEntryName(kind, id) or tostring(id)
                    local equippedItemID = ItemsData.GetWildcardSlotItemID and ItemsData:GetWildcardSlotItemID(id) or nil
                    if equippedItemID and GameTooltip.SetItemByID then
                        GameTooltip:SetItemByID(equippedItemID)
                        GameTooltip:AddLine(" ")
                        GameTooltip:AddLine(wildcardName, 0.85, 0.85, 0.85)
                    else
                        if GameTooltip_SetTitle then
                            GameTooltip_SetTitle(GameTooltip, wildcardName)
                        else
                            GameTooltip:SetText(wildcardName)
                        end
                    end
                elseif kind == "spell" or kind == "native" then
                    local spellID = kind == "native" and Affected(self).essentialSpellID or id
                    if GameTooltip.SetSpellByID then
                        GameTooltip:SetSpellByID(spellID)
                    else
                        local name = spellID and C_Spell.GetSpellName(spellID)
                        if name then
                            GameTooltip:SetText(name)
                        end
                    end
                else
                    GameTooltip:SetItemByID(id)
                end
                GameTooltip:Show()
            end
        end
    end)
    button:SetScript("OnLeave", function()
        GameTooltip_Hide()
    end)

    function button:SetReorderLocked(locked)
        Affected(self).trackerReorderLocked = locked and true or false
        if self.Icon then
            self.Icon:SetDesaturated(Affected(self).trackerReorderLocked)
        end
    end

    function button:IsReorderLocked()
        return Affected(self).trackerReorderLocked == true
    end

    function button:IsEmptyCategory()
        return Affected(self).trackerEmpty == true
    end

    function button:GetBestCooldownItemTarget(_cursorX, _cursorY)
        return self
    end

    function button:UpdateReorderMarkerPosition(marker, cursorX, _cursorY)
        local centerX = self:GetCenter()
        if centerX and cursorX < centerX then
            marker:SetPoint("CENTER", self, "LEFT", -4, 0)
            return false
        else
            marker:SetPoint("CENTER", self, "RIGHT", 4, 0)
            return true
        end
    end

    button:HookScript("OnShow", function(self)
        if not self.Icon then
            return
        end
        if Affected(self).trackerEmpty then
            if ItemVisuals then
                ItemVisuals:SetEmptySlot(self)
            else
                self.Icon:SetTexture(nil)
                self.Icon:SetAtlas("cdm-empty", true)
            end
        else
            local kind, id = GetEntryKindAndID(self)
            if kind and id then
                SetIconFromEntry(self, kind, id)
            end
        end
        RefreshTrackerOverrideIndicator(self)
    end)

    Affected(button).trackerInitialized = true
end

local function AcquireItemButton(category)
    local button = category.itemPool:Acquire()
    InitializeItemButton(button)
    button:Show()
    return button
end

local function ResetCategoryButtons(category)
    category.itemPool:ReleaseAll()

    if Affected(category).trackerDropPlaceholder then
        Affected(category).trackerDropPlaceholder:Hide()
    end

    local container = category.Container
    if container then
        for _, child in ipairs({ container:GetChildren() }) do
            if child.layoutIndex ~= nil then
                child.layoutIndex = nil
            end
        end
    end
end

function TrackerAssignmentPanel:LayoutCategory(category, entries, owned, searchActive)
    ResetCategoryButtons(category)

    local container = category.Container or category.Content
    local headerHeight = category.Header:GetHeight()
    local isCollapsed = category.IsCollapsed and category:IsCollapsed() or category.Collapsed
    if isCollapsed then
        if category.SetCollapsed then
            category:SetCollapsed(true)
        elseif container then
            container:Hide()
        end
        category:SetHeight(headerHeight)
        return
    end

    if category.SetCollapsed then
        category:SetCollapsed(false)
    elseif container then
        container:Show()
    end

    local size = 38
    local spacing = 8

    if #entries == 0 and not searchActive then
        local emptyButton = AcquireItemButton(category)
        SetButtonEntry(emptyButton, nil, nil)
        -- Clear overlays left over from whatever entry this pooled button held
        -- before, so an empty slot never shows a stale quality / "Trinket Slot" badge.
        SetWildcardGlow(emptyButton, nil)
        if emptyButton.Icon and emptyButton.Icon._quality then
            emptyButton.Icon._quality:Hide()
        end
        Affected(emptyButton).trackerEmpty = true
        SetEssentialNativeLock(emptyButton, false)
        RefreshTrackerOverrideIndicator(emptyButton)
        emptyButton.categoryState = category.state
        emptyButton.layoutIndex = 1
        emptyButton:ClearAllPoints()
        emptyButton:SetSize(size, size)
        if ItemVisuals then
            ItemVisuals:SetEmptySlot(emptyButton)
        else
            if emptyButton.Icon then
                emptyButton.Icon:SetTexture(nil)
                emptyButton.Icon:SetAtlas("cdm-empty", true)
                emptyButton.Icon:SetDesaturated(false)
            end
            if emptyButton.Cooldown then
                CooldownFrame_Clear(emptyButton.Cooldown)
            end
        end
    else
        for index, entry in ipairs(entries) do
            local button = AcquireItemButton(category)
            SetButtonEntry(button, entry.kind, entry.id)
            SetWildcardGlow(button, entry.kind, entry.id)
            Affected(button).trackerEmpty = false
            Affected(button).essentialNative = entry.native == true
            Affected(button).essentialSpellID = entry.spellID
            RefreshTrackerOverrideIndicator(button)
            button.categoryState = category.state
            button.layoutIndex = index
            button:ClearAllPoints()
            button:SetSize(size, size)

            SetIconFromEntry(button, entry.kind, entry.id)
            SetEssentialNativeLock(button, entry.native == true)
            if button.Icon and not entry.native then
                button.Icon:SetDesaturated(not IsEntryUsable(owned, entry.kind, entry.id))
            elseif button.Icon then
                button.Icon:SetDesaturated(false)
            end

            if button.Cooldown then
                CooldownFrame_Clear(button.Cooldown)
            end
        end
    end

    if container and container.Layout then
        container.childXPadding = spacing
        container.childYPadding = spacing
        container.isHorizontal = true
        container.stride = 7
        container.layoutFramesGoingRight = true
        container.layoutFramesGoingUp = false
        container.alwaysUpdateLayout = true
        container:Layout()
    end

    local contentHeight = container and container:GetHeight() or 0
    local totalHeight = nil
    if category.Header and container then
        local headerTop = category.Header:GetTop()
        local containerBottom = container:GetBottom()
        if headerTop and containerBottom then
            totalHeight = headerTop - containerBottom
        end
    end
    category:SetHeight(totalHeight or (headerHeight + 6 + contentHeight))
end

function TrackerAssignmentPanel:CreateItemCategory(parent, title, state, defaultCollapsed)
    local categoryDisplay = CreateFrame("Frame", nil, parent, "CooldownViewerSettingsCategoryTemplate")
    categoryDisplay.state = state
    categoryDisplay.Collapsed = defaultCollapsed == true
    categoryDisplay.Header:SetHeaderText(title)

    categoryDisplay:Layout()

    function categoryDisplay:SetCollapsed(collapsed)
        self.Collapsed = collapsed and true or false
        if self.Header and self.Header.UpdateCollapsedState then
            self.Header:UpdateCollapsedState(self.Collapsed)
        end
        if self.Container then
            self.Container:SetShown(not self.Collapsed)
            if self.Container.Layout then
                self.Container:Layout()
            end
        end
    end

    function categoryDisplay:IsCollapsed()
        return self.Collapsed == true
    end

    function categoryDisplay:ToggleCollapsed()
        self:SetCollapsed(not self:IsCollapsed())
        TrackerAssignmentPanel:RefreshTrackerPanel()
    end

    if categoryDisplay.Header then
        if categoryDisplay.Header.CollapseButton then
            categoryDisplay.Header.CollapseButton:Hide()
            categoryDisplay.Header.CollapseButton:Disable()
        end
        if categoryDisplay.Header.Toggle then
            categoryDisplay.Header.Toggle:Hide()
            categoryDisplay.Header.Toggle:Disable()
        end
    end

    if not categoryDisplay.Container then
        categoryDisplay.Container = CreateFrame("Frame", nil, categoryDisplay)
        categoryDisplay.Container:SetPoint("TOPLEFT", categoryDisplay, "TOPLEFT", 0, 0)
        categoryDisplay.Container:SetPoint("TOPRIGHT", categoryDisplay, "TOPRIGHT", 0, 0)
    end

    categoryDisplay:SetScript("OnEnter", function(self)
        self.headerDropActive = false
        SetReorderTarget(self)
        if IsCursorDroppable() and not self:IsCollapsed() then
            ShowDropPlaceholder(self, true)
        end
    end)
    categoryDisplay:SetScript("OnReceiveDrag", function(self)
        ShowDropPlaceholder(self, false)
        if HandleCursorDrop(self.state) then
            return
        end
    end)
    categoryDisplay:SetScript("OnMouseUp", function(self, btn)
        if btn == "LeftButton" and IsCursorDroppable() then
            ShowDropPlaceholder(self, false)
            HandleCursorDrop(self.state)
        end
    end)
    if categoryDisplay.Container then
        categoryDisplay.Container:SetScript("OnEnter", function()
            categoryDisplay.headerDropActive = false
            SetReorderTarget(categoryDisplay)
            if IsCursorDroppable() and not categoryDisplay:IsCollapsed() then
                ShowDropPlaceholder(categoryDisplay, true)
            end
        end)
        categoryDisplay.Container:SetScript("OnReceiveDrag", function()
            ShowDropPlaceholder(categoryDisplay, false)
            if HandleCursorDrop(categoryDisplay.state) then
                return
            end
        end)
        categoryDisplay.Container:SetScript("OnMouseUp", function(_, btn)
            if btn == "LeftButton" and IsCursorDroppable() then
                ShowDropPlaceholder(categoryDisplay, false)
                HandleCursorDrop(categoryDisplay.state)
            end
        end)
    end

    categoryDisplay.itemPool = CreateFramePool("Frame", categoryDisplay.Container, nil, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.itemID = nil
        frame.spellID = nil
        Affected(frame).trackerEntryKind = nil
        Affected(frame).trackerEntryId = nil
        Affected(frame).trackerEmpty = nil
        Affected(frame).essentialNative = nil
        Affected(frame).essentialSpellID = nil
        -- Hide every custom overlay so a recycled button never carries a stale
        -- quality badge or "Trinket Slot" glow/label onto its next entry.
        if Affected(frame).trackerWildcardGlow then
            Affected(frame).trackerWildcardGlow:Hide()
        end
        if Affected(frame).trackerWildcardName then
            Affected(frame).trackerWildcardName:Hide()
        end
        if Affected(frame).trackerOverrideIndicator then
            Affected(frame).trackerOverrideIndicator:Hide()
        end
        if Affected(frame).essentialNativeLockFrame then
            Affected(frame).essentialNativeLockFrame:Hide()
        end
        if frame.Icon and frame.Icon._quality then
            frame.Icon._quality:Hide()
        end
        if frame.Icon then
            frame.Icon:SetTexture(nil)
        end
    end)

    -- This inherits Blizzard's category event handling, but owns plain CMC
    -- buttons rather than CooldownViewerSettingsItemTemplate instances.
    function categoryDisplay:RefreshSpellIcons()
        for button in self.itemPool:EnumerateActive() do
            if button.Icon and not Affected(button).trackerEmpty then
                local kind, id = GetEntryKindAndID(button)
                if kind and id then
                    SetIconFromEntry(button, kind, id)
                end
            end
        end
    end

    function categoryDisplay:GetNearestItemToCursorWeighted(cursorX, cursorY)
        local nearestItem = nil
        local nearestVertical = math.huge
        local nearestHorizontal = math.huge

        for item in self.itemPool:EnumerateActive() do
            local left, right, bottom, top = item:GetLeft(), item:GetRight(), item:GetBottom(), item:GetTop()
            if left and right and bottom and top then
                local centerX = (left + right) / 2
                local centerY = (bottom + top) / 2
                local horizontalDistance = math.abs(centerX - cursorX)
                local verticalDistance = math.abs(centerY - cursorY)
                if cursorY > bottom and cursorY < top then
                    verticalDistance = 0
                end
                if verticalDistance < nearestVertical or (verticalDistance == nearestVertical and horizontalDistance < nearestHorizontal) then
                    nearestItem = item
                    nearestVertical = verticalDistance
                    nearestHorizontal = horizontalDistance
                end
            end
        end

        return nearestItem
    end

    function categoryDisplay:GetBestCooldownItemTarget(cursorX, cursorY)
        return self:GetNearestItemToCursorWeighted(cursorX, cursorY)
    end

    if categoryDisplay.Header then
        local header = categoryDisplay.Header
        local dropped = false

        -- Decorative green highlight on the header itself. It is a plain
        -- texture, so it never steals mouse focus from the header and the
        -- native hover highlight stays lit alongside it.
        local headerHighlight = header:CreateTexture(nil, "OVERLAY")
        headerHighlight:SetAtlas("UI-Dream-Highlight-Top", false)
        headerHighlight:SetAlpha(0.65)
        headerHighlight:SetAllPoints(header)
        headerHighlight:Hide()
        categoryDisplay.headerHighlight = headerHighlight

        local function dropFromHeader()
            headerHighlight:Hide()
            ShowDropPlaceholder(categoryDisplay, false)
            if IsCursorDroppable() then
                dropped = HandleCursorDrop(categoryDisplay.state) == true
            else
                dropped = false
            end
        end

        local function handleHeaderClick(_, button)
            if button ~= "LeftButton" then
                return
            end
            if IsReordering() then
                return
            end
            if IsCursorDroppable() then
                dropFromHeader()
            elseif not dropped then
                categoryDisplay:ToggleCollapsed()
            end
            dropped = false
        end

        if header.SetClickHandler then
            header:SetClickHandler(handleHeaderClick)
        else
            header:HookScript("OnMouseUp", handleHeaderClick)
        end

        -- The header is also a drop target: both spellbook/bag pickups and
        -- entries dragged between trackers land at the end of the section.
        -- Spellbook/bag pickups light the shared green drop zone; reorder
        -- drags light the header texture so item targeting below stays free.
        header:HookScript("OnEnter", function()
            if IsReordering() then
                SetReorderTarget(categoryDisplay)
                categoryDisplay.headerDropActive = true
                headerHighlight:Show()
                return
            end
            if IsCursorDroppable() then
                ShowDropPlaceholder(categoryDisplay, true)
            end
        end)
        header:HookScript("OnLeave", function()
            if IsReordering() then
                categoryDisplay.headerDropActive = false
            end
            headerHighlight:Hide()
            dropped = false
        end)
        header:SetScript("OnReceiveDrag", function()
            dropFromHeader()
        end)
    end

    categoryDisplay:SetCollapsed(defaultCollapsed == true)

    return categoryDisplay
end

function TrackerAssignmentPanel:RefreshTrackerPanel()
    if not ns.db.profile.tracker_enabled then
        return
    end
    local owned = ItemsData:ScanOwnedItemsForMiscPanel()
    ItemsData:EnsureTrackedItems(owned)

    -- Auto-grow/shrink so there's always exactly one empty trailing tracker.
    if ItemViewer.ReconcileTrackerCount then
        ItemViewer:ReconcileTrackerCount()
    end

    if not CMCCooldownViewerSettingsTrackerPanel then
        return
    end

    if CMCCooldownViewerSettingsTrackerPanel.SetPortraitTextureRaw then
        CMCCooldownViewerSettingsTrackerPanel:SetPortraitTextureRaw("Interface\\Addons\\CooldownManagerCentered\\Media\\CooldownManagerCenteredIcon")
    end

    local showUnusable = DB.GetShowingUnusable()
    local searchTerm = Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSearchTerm or ""
    local searchLower = searchTerm ~= "" and searchTerm:lower() or nil

    local function matchesSearch(entry)
        if not searchLower then
            return true
        end
        local name = ItemsData:GetEntryName(entry.kind, entry.id)
        return name and name:lower():find(searchLower, 1, true) ~= nil
    end

    -- Collect the displayable entries for one bucket. Tracker buckets keep
    -- alwaysShow entries even when unowned; the hidden bucket never does.
    local function collectEntries(state, isHidden)
        local result = {}
        for _, entry in ipairs(ItemsData:GetEntriesByState(state)) do
            local usable = showUnusable or IsEntryUsable(owned, entry.kind, entry.id) or (not isHidden and DB.GetAlwaysShow(entry.kind, entry.id))
            if usable and matchesSearch(entry) then
                table.insert(result, entry)
            end
        end
        return result
    end

    local trackerCategories = Affected(CMCCooldownViewerSettingsTrackerPanel).trackerCategories
    local essentialCategory = Affected(CMCCooldownViewerSettingsTrackerPanel).essentialCategory
    local hiddenCategory = Affected(CMCCooldownViewerSettingsTrackerPanel).hiddenCategory
    if not trackerCategories or not essentialCategory or not hiddenCategory then
        return
    end

    -- Lay out one category per active tracker, hide the surplus, and append the
    -- hidden bucket. `categories` holds only the visible frames for positioning.
    local count = ItemViewer:GetTrackerCount()
    local categories = {}
    local essentialEntries = ns.EssentialCustomTracker and ns.EssentialCustomTracker:GetSettingsEntries() or {}
    self:LayoutCategory(essentialCategory, essentialEntries, owned, searchLower ~= nil)
    table.insert(categories, essentialCategory)
    local revealedNewCategory = false
    for i = 1, #trackerCategories do
        local category = trackerCategories[i]
        if i <= count then
            -- A category being shown for the first time lays out at the wrong height
            -- on this pass (its content frames size up a frame later), so it overlaps
            -- the next section until a follow-up redraw corrects it.
            if not category:IsShown() then
                revealedNewCategory = true
            end
            category:Show()
            self:LayoutCategory(category, collectEntries(ItemsData:GetTrackerStateName(i), false), owned, searchLower ~= nil)
            table.insert(categories, category)
        else
            category:Hide()
        end
    end
    self:LayoutCategory(hiddenCategory, collectEntries(ITEM_STATE_HIDDEN, true), owned, searchLower ~= nil)
    table.insert(categories, hiddenCategory)

    local scrollChild = Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollChild
    if scrollChild then
        local yOffset = 0
        local previousCategory = nil
        for _, category in ipairs(categories) do
            category:ClearAllPoints()
            if previousCategory then
                category:SetPoint("TOPLEFT", previousCategory, "BOTTOMLEFT", 0, -18)
            else
                category:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, 0)
            end
            yOffset = yOffset + category:GetHeight() + (previousCategory and 18 or 0)
            previousCategory = category
        end
        local scrollFrame = Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollFrame
        if scrollFrame then
            local paddingHeight = 18
            local frameHeight = scrollFrame:GetHeight() or 0
            local needsScrollPadding = previousCategory and (frameHeight > 0 and yOffset > frameHeight)
            if needsScrollPadding then
                if not Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding then
                    Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding = CreateFrame("Frame", nil, scrollChild)
                    Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding:SetHeight(paddingHeight)
                end
                Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding:ClearAllPoints()
                Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding:SetPoint("TOPLEFT", previousCategory, "BOTTOMLEFT")
                Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding:SetPoint("TOPRIGHT", previousCategory, "BOTTOMRIGHT")
                Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding:Show()
                scrollChild:SetHeight(math.max(1, yOffset + paddingHeight))
            elseif Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding then
                Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollPadding:Hide()
                scrollChild:SetHeight(math.max(1, yOffset))
            end

            scrollFrame:UpdateScrollChildRect()
        else
            scrollChild:SetHeight(math.max(1, yOffset))
        end
    end

    -- A newly revealed category needs one corrective relayout once its content
    -- frames have sized. Guarded by revealedNewCategory so this never loops (the
    -- follow-up pass sees the category already shown).
    if revealedNewCategory then
        C_Timer.After(0.1, function()
            TrackerAssignmentPanel:RefreshTrackerPanel()
        end)
    end
end

function TrackerAssignmentPanel:EnsureTrackerPanel()
    if CMCCooldownViewerSettingsTrackerPanel then
        return
    end

    CMCCooldownViewerSettingsTrackerPanel = CreateFrame("Frame", "CMCCooldownViewerSettingsTrackerPanel", CooldownViewerSettings, "ButtonFrameTemplate")
    CMCCooldownViewerSettingsTrackerPanel:SetAllPoints(CooldownViewerSettings)
    CMCCooldownViewerSettingsTrackerPanel:SetFrameStrata("HIGH")
    CMCCooldownViewerSettingsTrackerPanel:SetFrameLevel(CooldownViewerSettings:GetFrameLevel() + 10)
    CooldownViewerSettingsCloseButton:SetFrameStrata("HIGH")
    CMCCooldownViewerSettingsTrackerPanel:Hide()
    CMCCooldownViewerSettingsTrackerPanel.Inset.Bg:SetAtlas("character-panel-background", true)
    CMCCooldownViewerSettingsTrackerPanel.Inset.Bg:SetHorizTile(false)
    CMCCooldownViewerSettingsTrackerPanel.Inset.Bg:SetVertTile(false)
    CMCCooldownViewerSettingsTrackerPanel.TitleContainer.TitleText:SetText(ns.API.GradientText("CMC") .. " " .. L["Trackers"])

    if CMCCooldownViewerSettingsTrackerPanel.CloseButton then
        -- The native level-510 close button remains above this level-100 overlay and
        -- receives the hardware click directly, including during combat.
        CMCCooldownViewerSettingsTrackerPanel.CloseButton:Hide()
    end

    local scrollFrame = CreateFrame("ScrollFrame", "$parent.CooldownScroll", CMCCooldownViewerSettingsTrackerPanel, "ScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 17, -72)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 29)

    local scrollChild = CreateFrame("Frame", "$parent.Content", scrollFrame)
    scrollChild:SetSize(300, 1)
    scrollChild:SetPoint("TOPLEFT", 0, 0)
    scrollChild:SetPoint("TOPRIGHT", 0, 0)
    scrollFrame:SetScrollChild(scrollChild)
    scrollFrame.ScrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 6, 0)
    scrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 6, 0)

    scrollFrame:SetScript("OnSizeChanged", function(self)
        scrollChild:SetWidth(self:GetWidth())
        TrackerAssignmentPanel:RefreshTrackerPanel()
    end)

    local maxTrackers = ns.CONSTANTS.MAX_TRACKERS or 10
    local essentialCategory = self:CreateItemCategory(scrollChild, L["Essential Viewer"], "essential", true)
    local trackerCategories = {}
    for i = 1, maxTrackers do
        trackerCategories[i] = self:CreateItemCategory(scrollChild, string.format(L["Tracker %d"], i), ItemsData:GetTrackerStateName(i))
        trackerCategories[i]:Hide()
    end
    local hiddenCategory = self:CreateItemCategory(scrollChild, L["Not Displayed"], ITEM_STATE_HIDDEN)

    Affected(CMCCooldownViewerSettingsTrackerPanel).trackerCategories = trackerCategories
    Affected(CMCCooldownViewerSettingsTrackerPanel).essentialCategory = essentialCategory
    Affected(CMCCooldownViewerSettingsTrackerPanel).hiddenCategory = hiddenCategory
    Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollChild = scrollChild
    Affected(CMCCooldownViewerSettingsTrackerPanel).trackerScrollFrame = scrollFrame
    local aurasTab = CooldownViewerSettings.AurasTab
    -- 12.1.0
    local groupBuffsTab = CooldownViewerSettings.GroupBuffsTab

    if not Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSearchBox then
        local searchBox = CreateFrame("EditBox", nil, CMCCooldownViewerSettingsTrackerPanel, "SearchBoxTemplate")
        searchBox:SetSize(290, 30)
        searchBox:SetPoint("TOPLEFT", CMCCooldownViewerSettingsTrackerPanel, "TOPLEFT", 72, -30)
        searchBox.Instructions:SetText(L["Enter search text"])
        searchBox:SetScript("OnTextChanged", function(self)
            self.Instructions:SetShown(self:GetText() == "")
            Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSearchTerm = self:GetText()
            TrackerAssignmentPanel:RefreshTrackerPanel()
        end)
        searchBox:Hide()
        Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSearchBox = searchBox
    end

    if not Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSettingsDropdown then
        local dropdown = CreateFrame("DropdownButton", nil, CMCCooldownViewerSettingsTrackerPanel, "UIPanelIconDropdownButtonTemplate")
        dropdown:SetPoint("LEFT", Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSearchBox, "RIGHT", 5, 0)
        dropdown:SetupMenu(function(_, rootDescription)
            rootDescription:CreateCheckbox(L["Show Unusable"], DB.GetShowingUnusable, DB.ToggleShowUnusable)

            -- local passive = rootDescription:CreateCheckbox(
            --     "Show Trackable Passive Trinkets",
            --     DB.GetShowingPassiveTrinkets,
            --     DB.ToggleShowPassiveTrinkets
            -- )
            -- passive:SetTooltip(function(tooltip)
            --     GameTooltip_AddNormalLine(
            --         tooltip,
            --         "Track passive (proc) trinkets equipped in the trinket slots. Turn off to only track trinkets with an on-use effect."
            --     )
            -- end)
        end)
        dropdown:Hide()
        Affected(CMCCooldownViewerSettingsTrackerPanel).trackerSettingsDropdown = dropdown
    end

    if not Affected(CMCCooldownViewerSettingsTrackerPanel).trackerTrackTip then
        local trackTip = CMCCooldownViewerSettingsTrackerPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        trackTip:SetPoint("BOTTOMLEFT", CMCCooldownViewerSettingsTrackerPanel, "BOTTOMLEFT", 10, 10)
        trackTip:SetText(L["Drag&Drop an item or spell"])
        Affected(CMCCooldownViewerSettingsTrackerPanel).trackerTrackTip = trackTip
    end

    CMCCooldownViewerSettingsTrackerPanel:HookScript("OnShow", function(self)
        scrollChild:SetWidth(scrollFrame:GetWidth())
        Affected(self).trackerSearchBox:Show()
        Affected(self).trackerSettingsDropdown:Show()
        TrackerAssignmentPanel:RefreshTrackerPanel()
    end)
    CMCCooldownViewerSettingsTrackerPanel:HookScript("OnHide", function(self)
        local searchBox = Affected(self).trackerSearchBox
        searchBox:Hide()
        searchBox:SetText("")
        Affected(self).trackerSettingsDropdown:Hide()
        CancelOrderChange()
    end)

    CMCCooldownViewerSettingsTrackerTab = CreateFrame("Button", nil, UIParent, "CooldownViewerSettingsTabTemplate")

    CMCCooldownViewerSettingsTrackerTab:SetFrameStrata("HIGH")
    CMCCooldownViewerSettingsTrackerTab.tooltipText = ns.API.GradientText("CMC") .. " " .. L["Trackers"]
    CMCCooldownViewerSettingsTrackerTab.activeAtlas = "unitframeicon-chromietime"
    CMCCooldownViewerSettingsTrackerTab.inactiveAtlas = "unitframeicon-chromietime"
    CMCCooldownViewerSettingsTrackerTab.Icon:SetDesaturated(true)
    CMCCooldownViewerSettingsTrackerTab.Icon:SetVertexColor(1, 1, 1, 1)
    CMCCooldownViewerSettingsTrackerTab.Icon:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))

    CMCCooldownViewerSettingsTrackerTab:SetChecked(false)

    if groupBuffsTab then
        CMCCooldownViewerSettingsTrackerTab:SetPoint("TOP", groupBuffsTab, "BOTTOM", 0, -3)
    else
        CMCCooldownViewerSettingsTrackerTab:SetPoint("TOP", aurasTab, "BOTTOM", 0, -3)
    end

    ns.SettingsTabs:RegisterPanel(CMCCooldownViewerSettingsTrackerPanel, CMCCooldownViewerSettingsTrackerTab, "Tracker")

    local function ShowTrackerTab()
        ns.SettingsTabs:Activate(CMCCooldownViewerSettingsTrackerPanel, function()
            TrackerAssignmentPanel:RefreshTrackerPanel()
        end)
    end
    TrackerAssignmentPanel.ShowSettings = ShowTrackerTab

    hooksecurefunc(CooldownViewerSettings, "Hide", function()
        CMCCooldownViewerSettingsTrackerPanel:Hide()
        CMCCooldownViewerSettingsTrackerTab:Hide()
    end)
    hooksecurefunc(CooldownViewerSettings, "Show", function()
        if InCombatLockdown() then
            ns.SettingsTabs:DeactivateAll()
            CMCCooldownViewerSettingsTrackerTab:Hide()
        else
            CMCCooldownViewerSettingsTrackerTab:Show()
            ns.SettingsTabs:Restore()
        end
    end)

    CMCCooldownViewerSettingsTrackerTab:SetScript("OnClick", function()
        if not ns.db.profile.tracker_enabled then
            StaticPopup_Show("CMC_ENABLE_TRACKER", nil, nil, ShowTrackerTab)
            return
        end
        ns.SettingsTabs:DeactivateAll()
        ShowTrackerTab()
    end)

    hooksecurefunc(CooldownViewerSettings, "SetDisplayMode", function(self, mode)
        ns.SettingsTabs:DeactivateAll()
    end)

    if not InCombatLockdown() then
        CMCCooldownViewerSettingsTrackerTab:Show()
    else
        CMCCooldownViewerSettingsTrackerTab:Hide()
    end
end
