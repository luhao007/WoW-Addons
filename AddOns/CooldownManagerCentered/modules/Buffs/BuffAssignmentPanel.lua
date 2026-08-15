local _, ns = ...

local L = ns.L

local BuffAssignmentPanel = {}
ns.BuffAssignmentPanel = BuffAssignmentPanel
local CMCCooldownViewerSettingsBuffPanel = nil
local CMCCooldownViewerSettingsBuffTab = nil

local BuffData = ns.BuffData
local CustomAuraProvider = ns.CustomAuraProvider
local SoundPickerMenu = ns.LibEQOL and ns.LibEQOL.SoundPickerMenu

local ITEM_SIZE = 38
local ITEM_SPACING = 8
local STRIDE = 7
local PORTRAIT = "Interface\\Addons\\CooldownManagerCentered\\Media\\CooldownManagerCenteredIcon"
local CUSTOM_AURA_BADGE_ATLAS = "Warfronts-BaseMapIcons-Horde-Barracks"

local contextMenuExtended = false

local function BeginBuffDrag(button, eatNextGlobalMouseUp)
    if ns.DragDrop:IsDragging() then
        return
    end
    local entry = button.buffEntry
    if not entry then
        return
    end
    ns.DragDrop:Begin(CMCCooldownViewerSettingsBuffPanel, button, {
        eatNextGlobalMouseUp = eatNextGlobalMouseUp,
        cursorSize = 32,
        markerSize = ITEM_SPACING,
        markerHeight = ITEM_SIZE,
        cursorTexture = function()
            return entry.iconID or 134400
        end,
        getBestTarget = function(target, cursorX, cursorY)
            return target.GetBestCooldownItemTarget and target:GetBestCooldownItemTarget(cursorX, cursorY) or nil
        end,
        validateTarget = function(targetButton)
            local containerIndex = targetButton.buffContainerIndex
            if entry.custom and not containerIndex then
                return false
            end
            return containerIndex == nil or BuffData.CanAssignToContainer(entry.stableKey, containerIndex)
        end,
        updateMarkerPosition = function(targetButton, markerFrame, cursorX, cursorY)
            return targetButton:UpdateReorderMarkerPosition(markerFrame, cursorX, cursorY)
        end,
        onCancel = function()
            if entry.custom then
                button.Icon:SetDesaturated(false)
            end
        end,
        onDrop = function(_, _, targetButton, offset)
            if targetButton == button then
                return
            end
            local targetContainerIndex = targetButton.buffContainerIndex
            if entry.custom and not targetContainerIndex then
                return
            end
            local targetEntry = targetButton.buffEmpty and nil or targetButton.buffEntry
            local ok = BuffData.InsertEntryAt(targetContainerIndex, entry, targetEntry, offset == 0)
            if not ok then
                StaticPopup_Show("CMC_BUFF_MIX_BLOCKED")
                return
            end
            ns.BuffContainerViewer:ReconcileContainerCount()
            ns.BuffContainerViewer:RefreshCustomAuras()
            BuffAssignmentPanel:RefreshPanel()
        end,
    })
end

local function AddBuffSoundMenu(rootDescription, stableKey)
    local defaultSound = ns.BuffSounds:GetDefaultSound()
    local function RefreshSoundOptions()
        ns.BuffContainerViewer:RefreshCustomAuras()
        BuffAssignmentPanel:RefreshPanel()
    end
    local soundMenu = rootDescription:CreateButton(L["Sound"])
    soundMenu:CreateCheckbox(L["Sound on applied"], function()
        return BuffData.GetBuffEntrySetting(stableKey, "soundOnApplied", false)
    end, function()
        local enabled = not BuffData.GetBuffEntrySetting(stableKey, "soundOnApplied", false)
        BuffData.SetBuffEntrySetting(stableKey, "soundOnApplied", enabled)
        if enabled and defaultSound and not BuffData.GetBuffEntrySetting(stableKey, "soundOnAppliedFile", nil) then
            BuffData.SetBuffEntrySetting(stableKey, "soundOnAppliedFile", defaultSound)
        end
        RefreshSoundOptions()
    end)
    SoundPickerMenu:CreateSoundPickerMenu(soundMenu, {
        labelPrefix = L["Sound: "],
        options = function()
            return ns.BuffSounds:GetSoundOptions()
        end,
        getValue = function()
            return BuffData.GetBuffEntrySetting(stableKey, "soundOnAppliedFile", defaultSound)
        end,
        getLabel = function(value)
            return ns.BuffSounds:ResolveSoundLabel(value)
        end,
        setValue = function(value)
            BuffData.SetBuffEntrySetting(stableKey, "soundOnAppliedFile", value)
            BuffData.SetBuffEntrySetting(stableKey, "soundOnApplied", true)
            RefreshSoundOptions()
        end,
        preview = function(value)
            return ns.BuffSounds:PlayConfiguredSound(value)
        end,
        onValueChanged = function(_, _, activeMenu)
            RefreshSoundOptions()
            activeMenu:ReinitializeAll()
        end,
    })
    soundMenu:CreateButton(L["Preview sound"], function()
        local value = BuffData.GetBuffEntrySetting(stableKey, "soundOnAppliedFile", defaultSound)
        ns.BuffSounds:PlayConfiguredSound(value)
    end)
end

local function InstallContextMenuExtension()
    if contextMenuExtended then
        return
    end
    Menu.ModifyMenu("MENU_COOLDOWN_SETTINGS_ITEM", function(owner, rootDescription)
        if InCombatLockdown() then
            return
        end
        local entry = owner["buffEntry"]
        if not entry then
            return
        end

        if entry.custom then
            local function UntrackEntry()
                BuffData.AssignKey(entry.stableKey, nil)
                BuffData.GetOrders()[entry.stableKey] = nil
                ns.BuffContainerViewer:ReconcileContainerCount()
                ns.BuffContainerViewer:RefreshCustomAuras()
                BuffAssignmentPanel:RefreshPanel()
            end
            AddBuffSoundMenu(rootDescription, entry.stableKey)
            rootDescription:CreateButton(L["Reset to Defaults"], function()
                BuffData.SetBuffEntrySetting(entry.stableKey, "soundOnApplied", false)
                BuffData.SetBuffEntrySetting(entry.stableKey, "soundOnAppliedFile", false)
                ns.BuffContainerViewer:RefreshCustomAuras()
                BuffAssignmentPanel:RefreshPanel()
            end)
            if BuffData.IsEntryAssigned(entry.stableKey) then
                rootDescription:CreateButton(L["Untrack"], UntrackEntry)
            end
            if entry.wildcard then
                -- Wildcards are registry-owned; they have no per-entry removal or
                -- style overrides yet.
                return
            end
            if not BuffData.IsEntryAssigned(entry.stableKey) then
                rootDescription:CreateButton(L["Remove custom aura"], function()
                    if BuffData.RemoveCustomAura(entry.stableKey) then
                        ns.BuffContainerViewer:ReconcileContainerCount()
                        ns.BuffContainerViewer:RefreshCustomAuras()
                        BuffAssignmentPanel:RefreshPanel()
                    end
                end)
            end
            return
        end

        if not ns.CooldownStyle then
            return
        end
        -- Sound registration works even when CooldownStyle cannot resolve a style
        -- key for this buff, so it stays available before that check.
        AddBuffSoundMenu(rootDescription, entry.stableKey)
        local styleKey = ns.CooldownStyle.GetTrackedStyleKey(entry.cooldownID)
        if not styleKey then
            return
        end

        local function RefreshBuffStyle()
            ns.CooldownStyle.RefreshCooldownFrames()
        end

        local cooldownMenu = rootDescription:CreateButton(L["Cooldown"])
        local glowColorMenu = rootDescription:CreateButton(L["Glow & Color"])

        cooldownMenu:CreateCheckbox(L["Forced Cooldown Edge"], function()
            return ns.CooldownStyle.GetTrackedAlwaysShowCooldownEdge(styleKey)
        end, function()
            ns.CooldownStyle.ToggleTrackedAlwaysShowCooldownEdge(styleKey)
            RefreshBuffStyle()
        end)
        glowColorMenu:CreateCheckbox(L["Always Glow"], function()
            return ns.CooldownStyle.GetAlwaysGlow(styleKey)
        end, function()
            ns.CooldownStyle.ToggleAlwaysGlow(styleKey)
            RefreshBuffStyle()
        end)

        ns.CooldownStyle.AddEntryColorMenu(glowColorMenu, styleKey, "trackedGlowColor", "trackedStackColor", RefreshBuffStyle)
        ns.CooldownStyle.AddGlobalGlowOnlyInCombatMenu(glowColorMenu)
        rootDescription:CreateButton(L["Reset to Defaults"], function()
            ns.CooldownStyle.SetTrackedAlwaysShowCooldownEdge(styleKey, false)
            ns.CooldownStyle.SetAlwaysGlow(styleKey, false)
            ns.CooldownStyle.SetStyleEntryColor(styleKey, "trackedGlowColor")
            ns.CooldownStyle.SetStyleEntryColor(styleKey, "trackedStackColor")
            RefreshBuffStyle()
        end)
    end)
    contextMenuExtended = true
end

local function EnsureCustomAuraBadge(button)
    local badge = button.buffCustomAuraBadge
    if badge then
        return badge
    end

    badge = CreateFrame("Frame", nil, button)
    badge:SetSize(14, 14)
    badge:SetPoint("BOTTOMRIGHT", button.Icon, "BOTTOMRIGHT", 1, -1)
    badge:SetFrameLevel(button:GetFrameLevel() + 20)
    badge:EnableMouse(false)

    local icon = badge:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints(badge)
    icon:SetAtlas(CUSTOM_AURA_BADGE_ATLAS)
    badge:Hide()
    button.buffCustomAuraBadge = badge
    return badge
end

local function EnsureWildcardBorder(button)
    local border = button.buffWildcardBorder
    if border then
        return border
    end

    border = CreateFrame("Frame", nil, button)
    border:SetAllPoints(button.Icon or button)
    border:SetFrameStrata("HIGH")
    border:SetFrameLevel(button:GetFrameLevel() + 15)
    local glow = border:CreateTexture(nil, "ARTWORK")
    glow:SetAtlas("UI-CooldownManager-ActiveGlow", false)
    glow:SetPoint("CENTER", button.Icon or button, "CENTER")
    glow:SetSize(58, 58)
    local label = border:CreateFontString(nil, "OVERLAY", "GameFontNormalOutline")
    label:SetFontHeight(11)
    label:SetPoint("BOTTOM", button.Icon or button, "BOTTOM", 0, -4)
    label:SetText(L["Wildcard"])
    label:SetTextColor(1, 0.8, 0.2, 1)
    border.label = label
    border:Hide()
    button.buffWildcardBorder = border
    return border
end

local function GetOrCreateBuffOverrideIndicator(button)
    local indicator = button.buffOverrideIndicator
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

    local icon = indicator:CreateTexture(nil, "ARTWORK")
    icon:SetSize(16, 16)
    icon:SetAtlas("common-icon-sound")
    icon:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))

    indicator.Background = background
    indicator.Icon = icon
    indicator:Hide()
    button.buffOverrideIndicator = indicator
    return indicator
end

local function InitializeButton(button)
    if not button.Icon then
        button:SetSize(ITEM_SIZE, ITEM_SIZE)
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
    EnsureCustomAuraBadge(button)
    EnsureWildcardBorder(button)
    if button.buffInitialized then
        return
    end

    button:SetScript("OnMouseUp", function(self, mouseButton)
        if ns.DragDrop:IsDragging() then
            return
        elseif mouseButton == "RightButton" and not self.buffEmpty then
            if InCombatLockdown() then
                return
            end
            local entry = self.buffEntry
            if not entry then
                return
            end
            MenuUtil.CreateContextMenu(self, function(_, rootDescription)
                rootDescription:SetTag("MENU_COOLDOWN_SETTINGS_ITEM")
            end)
        elseif mouseButton == "LeftButton" and not self.buffEmpty and self.buffEntry then
            BeginBuffDrag(self, mouseButton)
        end
    end)
    button:RegisterForDrag("LeftButton")
    button:SetScript("OnDragStart", function(self)
        if not self.buffEmpty and self.buffEntry then
            BeginBuffDrag(self)
        end
    end)
    button:SetScript("OnReceiveDrag", function(self)
        ns.DragDrop:SetTarget(self)
    end)
    button:SetScript("OnEnter", function(self)
        ns.DragDrop:SetTarget(self)
        local entry = self.buffEntry
        if entry and entry.spellID then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetSpellByID(entry.spellID)
            if entry.wildcard then
                GameTooltip:AddLine(entry.label or entry.name or L["Wildcard"], 0.55, 0.8, 1)
            elseif entry.custom then
                GameTooltip:AddLine(L["Custom aura"], 0.55, 0.8, 1)
                GameTooltip:AddDoubleLine(L["Spell ID"], entry.spellID, 0.7, 0.7, 0.7, 1, 1, 1)
            end
            if entry.untracked then
                GameTooltip:AddLine(L["Not currently tracked"], 0.5, 0.5, 0.5)
            end
            GameTooltip:Show()
        elseif entry and entry.wildcard then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(entry.name or L["Wildcard"])
            GameTooltip:AddLine(string.format(L["%s (untracked)"], entry.label or entry.name or L["Wildcard"]), 0.55, 0.8, 1)
            GameTooltip:Show()
        elseif entry and entry.untracked then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(entry.name or L["Tracked buff"])
            GameTooltip:AddLine(L["Not currently tracked"], 0.5, 0.5, 0.5)
            GameTooltip:Show()
        elseif self.buffEmpty then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["Empty Slot"])
            GameTooltip:Show()
        end
    end)
    button:SetScript("OnLeave", function()
        GameTooltip_Hide()
    end)

    function button:GetBestCooldownItemTarget(_cursorX, _cursorY)
        return self
    end

    function button:UpdateReorderMarkerPosition(marker, cursorX, _cursorY)
        local centerX = self:GetCenter()
        if centerX and cursorX < centerX then
            marker:SetPoint("CENTER", self, "LEFT", -4, 0)
            return false
        end
        marker:SetPoint("CENTER", self, "RIGHT", 4, 0)
        return true
    end

    button:HookScript("OnShow", function(self)
        if self.buffEmpty then
            self.Icon:SetTexture(nil)
            self.Icon:SetAtlas("cdm-empty", true)
            self.Icon:SetDesaturated(false)
        elseif self.buffEntry and self.buffEntry.custom then
            self.Icon:SetAtlas(nil)
            self.Icon:SetTexture(self.buffEntry.iconID or 134400)
            self.Icon:SetDesaturated(self.buffEntry.untracked == true)
        end
    end)

    button.buffInitialized = true
end

local function AcquireButton(category)
    local button = category.itemPool:Acquire()
    InitializeButton(button)
    button:Show()
    return button
end

local function ClearButtonCooldownData(button)
    button.emptyCategory = nil
    button.orderIndex = nil
    ns.CooldownStyle.HideSettingsItemIndicator(button)

    if button.Icon then
        button.Icon:SetTexture(nil)
        button.Icon:SetDesaturated(false)
    end
    if button.buffWildcardBorder then
        button.buffWildcardBorder:Hide()
    end
    if button.buffOverrideIndicator then
        button.buffOverrideIndicator:Hide()
    end
end

local function ValidateCustomAuraInput(text)
    local spellID = tonumber(strtrim(text or ""))
    if not spellID or spellID <= 0 or spellID ~= math.floor(spellID) then
        return nil, nil, nil, L["Unknown spell ID"]
    end

    local spellInfo = C_Spell.GetSpellInfo(spellID)
    if not spellInfo or not spellInfo.name then
        return nil, nil, nil, L["Unknown spell ID"]
    end
    local name = spellInfo.name
    local iconID = spellInfo.iconID or C_Spell.GetSpellTexture(spellID)
    if BuffData.HasCustomAura(spellID) then
        return nil, name, iconID, L["Aura already added as custom"]
    end
    return spellID, name, iconID, nil, BuffData.HasBlizzardAura(spellID)
end

if CustomAuraProvider then
    local selectedAuraType = "helpful"

    local customAuraPreview = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    customAuraPreview:SetSize(300, 60)
    customAuraPreview:SetFrameStrata("TOOLTIP")
    customAuraPreview:SetClampedToScreen(true)
    customAuraPreview:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    customAuraPreview:SetBackdropColor(0, 0, 0, 0.9)
    customAuraPreview:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    customAuraPreview:Hide()

    local customAuraPreviewIcon = customAuraPreview:CreateTexture(nil, "ARTWORK")
    customAuraPreviewIcon:SetSize(32, 32)
    customAuraPreviewIcon:SetPoint("TOPLEFT", customAuraPreview, "TOPLEFT", 8, -12)

    local customAuraPreviewText = customAuraPreview:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customAuraPreviewText:SetPoint("TOPLEFT", customAuraPreviewIcon, "TOPRIGHT", 8, -2)
    customAuraPreviewText:SetPoint("RIGHT", customAuraPreview, "RIGHT", -8, 0)
    customAuraPreviewText:SetJustifyH("LEFT")

    local customAuraPreviewStatus = customAuraPreview:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    customAuraPreviewStatus:SetPoint("TOPLEFT", customAuraPreviewText, "BOTTOMLEFT", 0, -3)
    customAuraPreviewStatus:SetPoint("RIGHT", customAuraPreview, "RIGHT", -8, 0)
    customAuraPreviewStatus:SetJustifyH("LEFT")

    local function SetSelectedAuraType(auraType)
        selectedAuraType = auraType == "harmful" and "harmful" or "helpful"
    end

    local function UpdateCustomAuraPreview(editBox)
        local dialog = editBox:GetParent()
        local spellID, name, iconID, errorMessage, blizzardDuplicate = ValidateCustomAuraInput(editBox:GetText())
        dialog:GetButton1():SetEnabled(spellID ~= nil)

        customAuraPreviewIcon:SetTexture(iconID)
        customAuraPreviewIcon:SetShown(iconID ~= nil)
        if name then
            customAuraPreviewText:SetText(name)
            customAuraPreviewText:SetTextColor(1, 1, 1)
            if errorMessage then
                customAuraPreviewStatus:SetText(errorMessage)
                customAuraPreviewStatus:SetTextColor(1, 0.25, 0.25)
            elseif blizzardDuplicate then
                customAuraPreviewStatus:SetText(L["Already in Blizzard Tracked Buffs - will add a custom copy"])
                customAuraPreviewStatus:SetTextColor(0.6, 0.8, 1)
            else
                customAuraPreviewStatus:SetText("")
            end
        else
            customAuraPreviewText:SetText(errorMessage or "")
            customAuraPreviewText:SetTextColor(1, 0.25, 0.25)
            customAuraPreviewStatus:SetText("")
        end
    end

    StaticPopupDialogs["CMC_ADD_CUSTOM_AURA_TYPE"] = {
        text = L["What kind of custom aura do you want to add?"],
        button1 = L["Helpful (Player Buff)"],
        button2 = L["Harmful (Target Debuff)"],
        selectCallbackByIndex = true,
        OnButton1 = function()
            StaticPopup_Show("CMC_ADD_CUSTOM_AURA", nil, nil, "helpful")
        end,
        OnButton2 = function()
            StaticPopup_Show("CMC_ADD_CUSTOM_AURA", nil, nil, "harmful")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        escapeHides = true,
        preferredIndex = 3,
    }

    StaticPopupDialogs["CMC_ADD_CUSTOM_AURA"] = {
        text = L["Add a custom aura by spell ID"],
        button1 = _G.ADD,
        button2 = _G.CANCEL,
        hasEditBox = true,
        editBoxWidth = 220,
        maxLetters = 10,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
        OnShow = function(dialog)
            if dialog.which ~= "CMC_ADD_CUSTOM_AURA" then
                return
            end
            local auraType = dialog.data == "harmful" and "harmful" or "helpful"
            SetSelectedAuraType(auraType)
            dialog
                :GetTextFontString()
                :SetText(auraType == "harmful" and L["Add a custom Target Debuff by Spell ID"] or L["Add a custom Player Buff by Spell ID"])
            customAuraPreview:ClearAllPoints()
            customAuraPreview:SetPoint("BOTTOM", dialog, "TOP", 0, 8)
            customAuraPreview:Show()

            customAuraPreviewIcon:SetTexture(nil)
            customAuraPreviewIcon:Hide()
            customAuraPreviewText:SetText("")
            customAuraPreviewStatus:SetText("")
            dialog:GetButton1():Disable()
            dialog:GetEditBox():SetText("")
            dialog:GetEditBox():SetFocus()
            UpdateCustomAuraPreview(dialog:GetEditBox())
        end,
        OnAccept = function(dialog)
            local spellID = ValidateCustomAuraInput(dialog:GetEditBox():GetText())
            if not spellID then
                return
            end
            local stableKey = BuffData.AddCustomAura(spellID, selectedAuraType)
            if not stableKey then
                return
            end
            ns.BuffContainerViewer:ReconcileContainerCount()
            ns.BuffContainerViewer:RefreshCustomAuras()
            BuffAssignmentPanel:RefreshPanel()
        end,
        OnHide = function(dialog)
            if dialog.which == "CMC_ADD_CUSTOM_AURA" then
                customAuraPreview:Hide()
                customAuraPreview:ClearAllPoints()
            end
            SetSelectedAuraType("helpful")
            dialog:GetEditBox():SetText("")
        end,
        EditBoxOnEnterPressed = function(editBox)
            local dialog = editBox:GetParent()
            if dialog:GetButton1():IsEnabled() then
                StaticPopup_OnClick(dialog, 1)
            end
        end,
        EditBoxOnTextChanged = function(editBox)
            UpdateCustomAuraPreview(editBox)
        end,
        EditBoxOnEscapePressed = StaticPopup_StandardEditBoxOnEscapePressed,
    }
end

StaticPopupDialogs["CMC_BUFF_MIX_BLOCKED"] = {
    text = L["Cannot combine custom and Blizzard buffs in one container.\n\nDue to a limitation, a container can hold either custom auras or Blizzard-tracked buffs, not both. Move the buff to a different container."],
    button1 = _G.OKAY or "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function LayoutCategory(category, entries, searchActive)
    category.itemPool:ReleaseAll()

    local container = category.Container
    local headerHeight = category.Header:GetHeight()

    if category:IsCollapsed() then
        category.Container:Hide()
        category:SetHeight(category.Header:GetHeight())
        return
    end

    category.Container:Show()

    if #entries == 0 and not searchActive then
        local button = AcquireButton(category)
        ClearButtonCooldownData(button)
        button.buffEmpty = true
        button.buffEntry = nil
        button.buffContainerIndex = category.containerIndex
        button.layoutIndex = 1
        button:ClearAllPoints()
        button:SetSize(ITEM_SIZE, ITEM_SIZE)
        if button.Icon then
            button.Icon:SetTexture(nil)
            button.Icon:SetAtlas("cdm-empty", true)
            button.Icon:SetDesaturated(false)
        end
        button.buffCustomAuraBadge:Hide()
        if button.buffWildcardBorder then
            button.buffWildcardBorder:Hide()
        end
        if button.buffOverrideIndicator then
            button.buffOverrideIndicator:Hide()
        end
    else
        for index, entry in ipairs(entries) do
            local button = AcquireButton(category)
            button.buffEmpty = false
            button.buffEntry = entry
            button.buffContainerIndex = category.containerIndex
            button.layoutIndex = index
            button:ClearAllPoints()
            button:SetSize(ITEM_SIZE, ITEM_SIZE)
            button.emptyCategory = nil
            button.orderIndex = index
            button.Icon:SetAtlas(nil)
            button.Icon:SetTexture(entry.iconID or 134400)
            button.Icon:SetDesaturated(entry.untracked == true)
            if entry.custom then
                ns.CooldownStyle.HideSettingsItemIndicator(button)
            else
                ns.CooldownStyle.RefreshSettingsItemIndicator(button, entry.cooldownID)
            end

            local hasSound = BuffData.GetBuffEntrySetting(entry.stableKey, "soundOnApplied", false)
            local indicator = GetOrCreateBuffOverrideIndicator(button)
            indicator:ClearAllPoints()
            indicator:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", 0, -2)
            indicator:SetPoint("TOPRIGHT", button.Icon, "TOPRIGHT", 0, -2)
            indicator:SetFrameLevel(button:GetFrameLevel() + 20)
            indicator.Icon:ClearAllPoints()
            indicator.Icon:SetPoint("CENTER", indicator, "CENTER", 0, 0)
            indicator.Icon:SetShown(hasSound)
            indicator:SetShown(hasSound)

            if entry.custom then
                button.Icon:SetAtlas(nil)
                button.Icon:SetTexture(entry.iconID or 134400)
                button.Icon:SetDesaturated(entry.untracked == true)
            end
            -- Custom/wildcard identity is already shown by the container/section;
            -- at icon level we only mark actual effects (eye), wildcard borders
            -- and the harmful marker.
            button.buffCustomAuraBadge:SetShown(entry.custom and entry.auraType == "harmful")
            button.buffWildcardBorder:SetShown(entry.wildcard == true)
            button.buffWildcardBorder.label:SetText(entry.label or entry.name or L["Wildcard"])
        end
    end

    container.childXPadding = ITEM_SPACING
    container.childYPadding = ITEM_SPACING
    container.isHorizontal = true
    container.stride = STRIDE
    container.layoutFramesGoingRight = true
    container.layoutFramesGoingUp = false
    container.alwaysUpdateLayout = true
    container:Layout()

    local contentHeight = container:GetHeight()
    local totalHeight = nil

    local headerTop = category.Header:GetTop()
    local containerBottom = container:GetBottom()
    if headerTop and containerBottom then
        totalHeight = headerTop - containerBottom
    end

    category:SetHeight(totalHeight or (headerHeight + 6 + contentHeight))
end

local function CreateCategory(parent, title, containerIndex)
    local category = CreateFrame("Frame", nil, parent, "CooldownViewerSettingsCategoryTemplate")
    category.containerIndex = containerIndex
    category.Collapsed = false
    category.Header:SetHeaderText(title)
    category:Layout()

    function category:SetCollapsed(collapsed)
        self.Collapsed = collapsed and true or false
        self.Header:UpdateCollapsedState(self.Collapsed)
        self.Container:SetShown(not self.Collapsed)
        self.Container:Layout()
    end

    function category:IsCollapsed()
        return self.Collapsed == true
    end

    function category:ToggleCollapsed()
        self:SetCollapsed(not self:IsCollapsed())
        BuffAssignmentPanel:RefreshPanel()
    end

    category:SetScript("OnEnter", function(self)
        ns.DragDrop:SetTarget(self)
    end)
    category:SetScript("OnReceiveDrag", function(self)
        ns.DragDrop:SetTarget(self)
    end)
    if category.Container then
        category.Container:SetScript("OnEnter", function()
            ns.DragDrop:SetTarget(category)
        end)
        category.Container:SetScript("OnReceiveDrag", function()
            ns.DragDrop:SetTarget(category)
        end)
    end

    category.itemPool = CreateFramePool("Frame", category.Container, nil, function(_, f)
        f:Hide()
        ClearButtonCooldownData(f)
        f.layoutIndex = nil
        f.buffEntry = nil
        f.buffEmpty = nil
        if f.buffCustomAuraBadge then
            f.buffCustomAuraBadge:Hide()
        end
        if f.Icon then
            f.Icon:SetTexture(nil)
        end
    end)

    function category:RefreshSpellIcons()
        for button in self.itemPool:EnumerateActive() do
            local entry = button.buffEntry
            if entry then
                button.Icon:SetAtlas(nil)
                button.Icon:SetTexture(entry.iconID or 134400)
                button.Icon:SetDesaturated(entry.untracked == true)
            end
        end
    end

    function category:GetBestCooldownItemTarget(cursorX, cursorY)
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

    category.Header:SetClickHandler(function(_, button)
        if button == "LeftButton" then
            category:ToggleCollapsed()
        end
    end)
    --[[ elseif category.Header then
        category.Header:SetScript("OnMouseUp", function(_, button)
            if button == "LeftButton" then
                category:ToggleCollapsed()
            end
        end)
    end]]

    category:SetCollapsed(false)

    return category
end

local function RefreshPanelInternal()
    if not BuffData.IsEnabled() then
        return
    end
    local panel = CMCCooldownViewerSettingsBuffPanel

    if not panel then -- no refresh if was never in settings yet (e.g. changing spec before first time opening the settings etc.)
        return
    end

    panel:SetPortraitTextureRaw(PORTRAIT)

    BuffData.ScanTrackedBuffs()

    local defaultCategory = panel.buffDefaultCategory
    local untrackedCategory = panel.buffUntrackedCategory
    local containerCategories = panel.buffContainerCategories
    local scrollChild = panel.buffScrollChild
    local scrollFrame = panel.buffScrollFrame

    local searchTerm = panel.buffSearchTerm
    searchTerm = searchTerm and searchTerm ~= "" and searchTerm:lower() or nil
    local function filter(entries)
        if not searchTerm then
            return entries
        end
        local result = {}
        for _, entry in ipairs(entries) do
            local name = entry.name and entry.name:lower()
            if name and name:find(searchTerm, 1, true) then
                result[#result + 1] = entry
            end
        end
        return result
    end

    local ordered = {}
    LayoutCategory(defaultCategory, filter(BuffData.GetUnassignedBuffs()), searchTerm ~= nil)
    ordered[#ordered + 1] = defaultCategory

    local count = BuffData.GetContainerCount()
    for i = 1, #containerCategories do
        local category = containerCategories[i]
        if i <= count then
            category:Show()
            local entries = BuffData.GetBuffsForContainer(i)
            local hasCustomAura = false
            for _, entry in ipairs(entries) do
                if entry.custom then
                    hasCustomAura = true
                    break
                end
            end
            local title = string.format(L["Buffs %d"], i)
            if hasCustomAura then
                title = string.format(L["Buffs %d (custom)"], i)
            end
            category.Header:SetHeaderText(title)
            LayoutCategory(category, filter(entries), searchTerm ~= nil)
            ordered[#ordered + 1] = category
        else
            category:Hide()
        end
    end

    local untrackedEntries = BuffData.GetUntrackedEntries()
    if #untrackedEntries > 0 then
        untrackedCategory:Show()
        LayoutCategory(untrackedCategory, filter(untrackedEntries), searchTerm ~= nil)
        ordered[#ordered + 1] = untrackedCategory
    else
        untrackedCategory:Hide()
    end

    local yOffset = 0
    local previous = nil
    for _, category in ipairs(ordered) do
        category:ClearAllPoints()
        if previous then
            category:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -18)
        else
            category:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, 0)
        end
        yOffset = yOffset + category:GetHeight() + (previous and 18 or 0)
        previous = category
    end

    if scrollChild then
        scrollChild:SetHeight(math.max(1, yOffset))
    end
    if scrollFrame and scrollFrame.UpdateScrollChildRect then
        scrollFrame:UpdateScrollChildRect()
    end
end

function BuffAssignmentPanel:RefreshPanel()
    if InCombatLockdown() then
        return
    end
    RefreshPanelInternal()
end

StaticPopupDialogs["CMC_ENABLE_BUFF_CONTAINERS"] = {
    text = L["Custom Buff Containers are disabled. Enable them now?"],
    button1 = _G.YES,
    button2 = _G.NO,
    OnAccept = function(_, data)
        if not ns.db or not ns.db.profile then
            return
        end
        BuffData.SetEnabled(true)
        if ns.BuffContainerViewer then
            ns.BuffContainerViewer:Initialize()
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

-- When the feature is turned off while the custom Buffs panel is open, drop our
-- overlay. The native Cooldown Viewer content beneath it was never modified.
function BuffAssignmentPanel:OnBuffContainersDisabled()
    if not CMCCooldownViewerSettingsBuffPanel or not CMCCooldownViewerSettingsBuffPanel:IsShown() then
        return
    end
    ns.SettingsTabs:DeactivateAll()
end

function BuffAssignmentPanel:EnsureSettingsTab()
    if CMCCooldownViewerSettingsBuffPanel then
        return
    end

    InstallContextMenuExtension()

    CMCCooldownViewerSettingsBuffPanel = CreateFrame("Frame", "CMCCooldownViewerSettingsBuffPanel", CooldownViewerSettings, "ButtonFrameTemplate")
    CMCCooldownViewerSettingsBuffPanel:SetAllPoints(CooldownViewerSettings)
    CMCCooldownViewerSettingsBuffPanel:SetFrameStrata("HIGH")
    CMCCooldownViewerSettingsBuffPanel:SetFrameLevel(CooldownViewerSettings:GetFrameLevel() + 10)
    CooldownViewerSettingsCloseButton:SetFrameStrata("HIGH")
    -- CMCCooldownViewerSettingsBuffPanel:EnableMouse(true)
    CMCCooldownViewerSettingsBuffPanel:Hide()
    if CMCCooldownViewerSettingsBuffPanel.Inset and CMCCooldownViewerSettingsBuffPanel.Inset.Bg then
        CMCCooldownViewerSettingsBuffPanel.Inset.Bg:SetAtlas("character-panel-background", true)
        CMCCooldownViewerSettingsBuffPanel.Inset.Bg:SetHorizTile(false)
        CMCCooldownViewerSettingsBuffPanel.Inset.Bg:SetVertTile(false)
    end
    if CMCCooldownViewerSettingsBuffPanel.TitleContainer and CMCCooldownViewerSettingsBuffPanel.TitleContainer.TitleText then
        CMCCooldownViewerSettingsBuffPanel.TitleContainer.TitleText:SetText(ns.API.GradientText("CMC") .. " " .. L["Buffs"])
    end
    if CMCCooldownViewerSettingsBuffPanel.CloseButton then
        -- Leave Blizzard's native close button visible and clickable above our panel.
        CMCCooldownViewerSettingsBuffPanel.CloseButton:Hide()
    end

    hooksecurefunc(CooldownViewerSettings, "RefreshLayout", function()
        if InCombatLockdown() or not CMCCooldownViewerSettingsBuffPanel:IsShown() then
            return
        end
        BuffData.InvalidateScan()
        BuffAssignmentPanel:RefreshPanel()
    end)

    local scrollFrame = CreateFrame("ScrollFrame", "$parent.BuffScroll", CMCCooldownViewerSettingsBuffPanel, "ScrollFrameTemplate")
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
        BuffAssignmentPanel:RefreshPanel()
    end)

    CMCCooldownViewerSettingsBuffPanel.buffScrollChild = scrollChild
    CMCCooldownViewerSettingsBuffPanel.buffScrollFrame = scrollFrame

    local searchBox = CreateFrame("EditBox", nil, CMCCooldownViewerSettingsBuffPanel, "SearchBoxTemplate")
    searchBox:SetSize(290, 30)
    searchBox:SetPoint("TOPLEFT", CMCCooldownViewerSettingsBuffPanel, "TOPLEFT", 72, -30)
    searchBox.Instructions:SetText(L["Enter search text"])
    searchBox:SetScript("OnTextChanged", function(self)
        self.Instructions:SetShown(self:GetText() == "")
        CMCCooldownViewerSettingsBuffPanel.buffSearchTerm = self:GetText()
        BuffAssignmentPanel:RefreshPanel()
    end)
    searchBox:Hide()
    CMCCooldownViewerSettingsBuffPanel.buffSearchBox = searchBox

    local trackMoreButton = CreateFrame("Button", nil, CMCCooldownViewerSettingsBuffPanel, "UIPanelButtonTemplate")
    trackMoreButton:SetPoint("BOTTOMLEFT", CMCCooldownViewerSettingsBuffPanel, "BOTTOMLEFT", 10, 4)
    trackMoreButton:SetHeight(22)
    trackMoreButton:SetText(L["Add more 'Tracked Buffs' in Buffs tab"])
    trackMoreButton:SetWidth(trackMoreButton:GetFontString():GetStringWidth() + 30)
    trackMoreButton:SetScript("OnClick", function()
        ns.SettingsTabs:DeactivateAll()
    end)
    trackMoreButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["Opens Blizzard's Buffs tab, where you can add more buffs\nto 'Tracked Buffs'\nfrom 'Not Displayed'."], nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    trackMoreButton:SetScript("OnLeave", GameTooltip_Hide)

    if BuffData.AreCustomAurasEnabled() then
        local addCustomAuraButton = CreateFrame("Button", nil, CMCCooldownViewerSettingsBuffPanel, "UIPanelButtonTemplate")
        addCustomAuraButton:SetPoint("BOTTOMRIGHT", CMCCooldownViewerSettingsBuffPanel, "BOTTOMRIGHT", -10, 4)
        addCustomAuraButton:SetHeight(22)
        addCustomAuraButton:SetText(L["Add custom aura"])
        addCustomAuraButton:SetWidth(addCustomAuraButton:GetFontString():GetStringWidth() + 30)
        addCustomAuraButton:SetScript("OnClick", function()
            StaticPopup_Show("CMC_ADD_CUSTOM_AURA_TYPE")
        end)
    end

    local defaultCategory = CreateCategory(scrollChild, L["Default Tracked Buffs Frame"], nil)
    CMCCooldownViewerSettingsBuffPanel.buffDefaultCategory = defaultCategory
    local untrackedCategory = CreateCategory(scrollChild, L["Not Displayed"], nil)
    CMCCooldownViewerSettingsBuffPanel.buffUntrackedCategory = untrackedCategory

    local containerCategories = {}
    for i = 1, BuffData.MAX_CONTAINERS do
        containerCategories[i] = CreateCategory(scrollChild, string.format(L["Buffs %d"], i), i)
        containerCategories[i]:Hide()
    end
    CMCCooldownViewerSettingsBuffPanel.buffContainerCategories = containerCategories

    CMCCooldownViewerSettingsBuffPanel:HookScript("OnShow", function()
        scrollChild:SetWidth(scrollFrame:GetWidth())
        searchBox:Show()
        BuffAssignmentPanel:RefreshPanel()
    end)
    CMCCooldownViewerSettingsBuffPanel:HookScript("OnHide", function()
        searchBox:Hide()
        searchBox:SetText("")
        ns.DragDrop:Cancel()
    end)

    local aurasTab = CooldownViewerSettings.AurasTab
    local groupBuffsTab = CooldownViewerSettings.GroupBuffsTab

    CMCCooldownViewerSettingsBuffTab = CreateFrame("Button", nil, UIParent, "CooldownViewerSettingsTabTemplate")
    CMCCooldownViewerSettingsBuffTab:SetFrameStrata("HIGH")
    CMCCooldownViewerSettingsBuffTab.tooltipText = ns.API.GradientText("CMC") .. " " .. L["Buffs"]
    CMCCooldownViewerSettingsBuffTab.activeAtlas = "icon_trackedbuffs"
    CMCCooldownViewerSettingsBuffTab.inactiveAtlas = "icon_trackedbuffs"
    CMCCooldownViewerSettingsBuffTab.Icon:SetDesaturated(true)
    CMCCooldownViewerSettingsBuffTab.Icon:SetVertexColor(1, 1, 1, 1)
    CMCCooldownViewerSettingsBuffTab.Icon:SetGradient("VERTICAL", CreateColor(0, 0.41, 0.405), CreateColor(0.825, 0.93, 0))

    CMCCooldownViewerSettingsBuffTab:SetChecked(false)
    local trackerTab = CMCCooldownViewerSettingsTrackerTab
    if trackerTab then
        CMCCooldownViewerSettingsBuffTab:SetPoint("TOP", trackerTab, "BOTTOM", 0, -3)
    elseif groupBuffsTab then
        CMCCooldownViewerSettingsBuffTab:SetPoint("TOP", groupBuffsTab, "BOTTOM", 0, -3)
    else
        CMCCooldownViewerSettingsBuffTab:SetPoint("TOP", aurasTab, "BOTTOM", 0, -3)
    end

    ns.SettingsTabs:RegisterPanel(CMCCooldownViewerSettingsBuffPanel, CMCCooldownViewerSettingsBuffTab, "Buffs")

    local function ShowBuffTab()
        ns.SettingsTabs:Activate(CMCCooldownViewerSettingsBuffPanel, function()
            BuffAssignmentPanel:RefreshPanel()
        end)
    end
    BuffAssignmentPanel.ShowSettings = ShowBuffTab

    hooksecurefunc(CooldownViewerSettings, "Hide", function()
        CMCCooldownViewerSettingsBuffPanel:Hide()
        CMCCooldownViewerSettingsBuffTab:Hide()
    end)
    hooksecurefunc(CooldownViewerSettings, "Show", function()
        if InCombatLockdown() then
            ns.SettingsTabs:DeactivateAll()
            CMCCooldownViewerSettingsBuffTab:Hide()
        else
            CMCCooldownViewerSettingsBuffTab:Show()
            ns.SettingsTabs:Restore()
        end
    end)

    CMCCooldownViewerSettingsBuffTab:SetScript("OnClick", function()
        if not BuffData.IsEnabled() then
            StaticPopup_Show("CMC_ENABLE_BUFF_CONTAINERS", nil, nil, ShowBuffTab)
            return
        end
        ns.SettingsTabs:DeactivateAll()
        ShowBuffTab()
    end)

    hooksecurefunc(CooldownViewerSettings, "SetDisplayMode", function()
        ns.SettingsTabs:DeactivateAll()
    end)

    if not InCombatLockdown() then
        CMCCooldownViewerSettingsBuffTab:Show()
    else
        CMCCooldownViewerSettingsBuffTab:Hide()
    end
end
