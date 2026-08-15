local _, ns = ...
local MINOR = 24000003
local C_Timer = _G.C_Timer

local lib = ns.LibEQOL.EditMode or {}
ns.LibEQOL.EditMode = lib
lib.MINOR = MINOR

local managerBroker = _G.LIBEQOLSHAREDWILDU_EDIT_MODE_MANAGER_BROKER
if not managerBroker then
    managerBroker = { provider = lib }
    _G.LIBEQOLSHAREDWILDU_EDIT_MODE_MANAGER_BROKER = managerBroker
elseif not managerBroker.provider then
    managerBroker.provider = lib
end

-- Namespaces/state ----------------------------------------------------------------
lib.internal = lib.internal or {}
local Internal = lib.internal

local State = {
    selectionRegistry = lib.selectionRegistry or {},
    frameHandlers = lib.frameHandlers or {},
    defaultPositions = lib.defaultPositions or {},
    settingSheets = lib.settingSheets or {},
    buttonSpecs = lib.buttonSpecs or {},
    resetToggles = lib.resetToggles or {},
    settingsResetToggles = lib.settingsResetToggles or {},
    collapseFlags = lib.collapseFlags or {},
    collapseExclusiveFlags = lib.collapseExclusiveFlags or {},
    settingsSpacingOverrides = lib.settingsSpacingOverrides or {},
    settingsMaxHeightOverrides = lib.settingsMaxHeightOverrides or {},
    sliderHeightOverrides = lib.sliderHeightOverrides or {},
    rowHeightOverrides = lib.rowHeightOverrides or {},
    widgetPools = lib.widgetPools or {},
    overlayToggleFlags = lib.overlayToggleFlags or {},
    dragPredicates = lib.dragPredicates or {},
    selectionPredicates = lib.selectionPredicates or {},
    managerToggleSpecs = lib.managerToggleSpecs or {},
    managerToggleState = lib.managerToggleState or {},
    managerToggleOrder = lib.managerToggleOrder or {},
    layoutSnapshot = Internal.layoutNameSnapshot,
    pendingDeletedLayouts = lib.pendingDeletedLayouts or {},
}

lib.selectionRegistry = State.selectionRegistry
lib.frameHandlers = State.frameHandlers
lib.defaultPositions = State.defaultPositions
lib.settingSheets = State.settingSheets
lib.buttonSpecs = State.buttonSpecs
lib.resetToggles = State.resetToggles
lib.settingsResetToggles = State.settingsResetToggles
lib.collapseFlags = State.collapseFlags
lib.collapseExclusiveFlags = State.collapseExclusiveFlags
lib.settingsSpacingOverrides = State.settingsSpacingOverrides
lib.settingsMaxHeightOverrides = State.settingsMaxHeightOverrides
lib.sliderHeightOverrides = State.sliderHeightOverrides
lib.rowHeightOverrides = State.rowHeightOverrides
lib.widgetPools = State.widgetPools
lib.overlayToggleFlags = State.overlayToggleFlags
lib.dragPredicates = State.dragPredicates
lib.selectionPredicates = State.selectionPredicates
lib.managerToggleSpecs = State.managerToggleSpecs
lib.managerToggleState = State.managerToggleState
lib.managerToggleOrder = State.managerToggleOrder
lib.pendingDeletedLayouts = State.pendingDeletedLayouts

local DEFAULT_SETTINGS_SPACING = 2
local DEFAULT_SLIDER_HEIGHT = 32
local COLOR_BUTTON_WIDTH = 22
local DEFAULT_INPUT_MAX_WIDTH = 193
local DEFAULT_INPUT_MIN_WIDTH = 80
local DROPDOWN_COLOR_MAX_WIDTH = 200
local function normalizeSpacing(value, fallback)
    local numberValue = tonumber(value)
    if numberValue == nil or numberValue < 0 then
        return fallback
    end
    return numberValue
end

local function normalizePositive(value, fallback)
    local numberValue = tonumber(value)
    if numberValue == nil or numberValue <= 0 then
        return fallback
    end
    return numberValue
end

local function setRowHeightOverride(frame, kind, value)
    if not frame then
        return
    end
    local normalized = normalizePositive(value, nil)
    local overrides = State.rowHeightOverrides[frame]
    if normalized == nil then
        if overrides then
            overrides[kind] = nil
            if next(overrides) == nil then
                State.rowHeightOverrides[frame] = nil
            end
        end
        return
    end
    if not overrides then
        overrides = {}
        State.rowHeightOverrides[frame] = overrides
    end
    overrides[kind] = normalized
end

local function getRowHeightOverride(frame, kind)
    local overrides = frame and State.rowHeightOverrides[frame]
    if overrides then
        return overrides[kind]
    end
end

local function applyRowHeightOverride(frame, selectionParent, kind)
    if not frame then
        return
    end
    local height = getRowHeightOverride(selectionParent, kind)
    if height then
        frame.fixedHeight = height
        frame:SetHeight(height)
    end
    return height
end

local function getFrameSettingsSpacing(frame)
    if not frame then
        return DEFAULT_SETTINGS_SPACING
    end
    local override = State.settingsSpacingOverrides[frame]
    return normalizeSpacing(override, DEFAULT_SETTINGS_SPACING)
end

local function getFrameSliderHeight(frame)
    if not frame then
        return DEFAULT_SLIDER_HEIGHT
    end
    local override = getRowHeightOverride(frame, "slider")
    if override then
        return normalizePositive(override, DEFAULT_SLIDER_HEIGHT)
    end
    local legacy = State.sliderHeightOverrides[frame]
    return normalizePositive(legacy, DEFAULT_SLIDER_HEIGHT)
end

local function getFrameSettingsMaxHeight(frame)
    if not frame then
        return nil
    end
    return normalizePositive(State.settingsMaxHeightOverrides[frame], nil)
end

local function FixScrollBarInside(scroll)
    local sb = scroll and scroll.ScrollBar
    if not sb or scroll._eqolScrollBarFixed then
        return
    end
    scroll._eqolScrollBarFixed = true

    local keepW = sb:GetWidth()

    sb:ClearAllPoints()
    sb:SetPoint("TOPRIGHT", scroll, "TOPRIGHT", -2, -16)
    sb:SetPoint("BOTTOMRIGHT", scroll, "BOTTOMRIGHT", -2, 16)

    if (sb:GetWidth() or 0) < 1 then
        sb:SetWidth((keepW and keepW > 0) and keepW or 16)
    end
end

local function UpdateScrollChildWidthFor(scroll, child)
    if not (scroll and child) then
        return
    end

    local sb = scroll.ScrollBar
    local sbW = 0
    if sb and sb:IsShown() then
        sbW = sb:GetWidth() or 0
        if sbW < 1 then
            sbW = 16
        end
    end

    local paddingRight = 6
    local w = (scroll:GetWidth() or 0) - sbW - paddingRight
    if w < 1 then
        return
    end

    if child._eqolLastWidth ~= w then
        child._eqolLastWidth = w
        child:SetWidth(w)
        for _, row in ipairs({ child:GetChildren() }) do
            if row and row.SetWidth then
                row:SetWidth(w)
                if row.ApplyLayout then
                    row:ApplyLayout()
                end
            end
        end
    end
end

local function UpdateScrollChildWidth(dialog)
    local scroll = dialog and dialog.SettingsScroll
    local child = dialog and dialog.Settings
    if not (scroll and child) then
        return
    end
    UpdateScrollChildWidthFor(scroll, child)
end

local function ApplySettingsRowWidth(row, settings)
    if not (row and row.SetWidth and settings) then
        return
    end
    local width = settings._eqolLastWidth or settings:GetWidth() or 0
    if width > 0 then
        row:SetWidth(width)
    end
end

-- frequently used globals ----------------------------------------------------------
local CreateFrame = _G.CreateFrame
local CopyTable = _G.CopyTable
local Mixin = _G.Mixin
local InCombatLockdown = _G.InCombatLockdown
local IsShiftKeyDown = _G.IsShiftKeyDown
local CreateUnsecuredObjectPool = _G.CreateUnsecuredObjectPool
local hooksecurefunc = _G.hooksecurefunc
local securecallfunction = _G.securecallfunction
local UIParent = _G.UIParent
local GameTooltip = _G.GameTooltip
local GameTooltip_Hide = _G.GameTooltip_Hide
local ColorPickerFrame = _G.ColorPickerFrame
local SOUNDKIT = _G.SOUNDKIT
local GetCursorPosition = _G.GetCursorPosition
local GetMouseFoci = _G.GetMouseFoci or _G.GetMouseFocus
local Enum = _G.Enum
local EditModeManagerFrame = _G.EditModeManagerFrame
local GenerateClosure = _G.GenerateClosure
local MinimalSliderWithSteppersMixin = _G.MinimalSliderWithSteppersMixin
local CreateMinimalSliderFormatter = _G.CreateMinimalSliderFormatter
local GetBuildInfo = _G.GetBuildInfo
local PlaySound = _G.PlaySound
local math = _G.math
local tostring = _G.tostring
local type = _G.type
local pairs = _G.pairs
local ipairs = _G.ipairs
local select = _G.select
local next = _G.next
local table = _G.table
local UIErrorsFrame = _G.UIErrorsFrame
local HUD_EDIT_MODE_COLLAPSE_OPTIONS = _G.HUD_EDIT_MODE_COLLAPSE_OPTIONS
local HUD_EDIT_MODE_EXPAND_OPTIONS = _G.HUD_EDIT_MODE_EXPAND_OPTIONS

local C_EditMode = _G.C_EditMode
local C_EditMode_GetLayouts = C_EditMode and C_EditMode.GetLayouts
local C_EditMode_ConvertLayoutInfoToString = C_EditMode and C_EditMode.ConvertLayoutInfoToString
local C_SpecializationInfo = _G.C_SpecializationInfo
local GetSpecialization = C_SpecializationInfo and C_SpecializationInfo.GetSpecialization

-- layout names are lazily resolved and cached to avoid repeated C_EditMode.GetLayouts calls.
local layoutNames = lib.layoutNames
    or setmetatable({ _G.LAYOUT_STYLE_MODERN or "Modern", _G.LAYOUT_STYLE_CLASSIC or "Classic" }, {
        __index = function(t, key)
            if type(key) ~= "number" or key <= 2 then
                return rawget(t, key)
            end
            local idx = key - 2
            local snapshot = State.layoutSnapshot or Internal.layoutNameSnapshot
            local cached = snapshot and snapshot[idx]
            if cached and cached ~= "" then
                rawset(t, key, cached)
                return cached
            end
            local layouts = C_EditMode_GetLayouts and C_EditMode_GetLayouts()
            layouts = layouts and layouts.layouts
            if not layouts then
                return nil
            end
            local name = layouts[idx] and layouts[idx].layoutName
            if name and name ~= "" then
                rawset(t, key, name)
            end
            return name
        end,
    })
lib.layoutNames = layoutNames

local function syncLayoutNameCache(snapshot)
    snapshot = snapshot or {}
    for key in pairs(layoutNames) do
        if type(key) == "number" and key > 2 then
            local idx = key - 2
            local name = snapshot[idx]
            if name and name ~= "" then
                rawset(layoutNames, key, name)
            else
                rawset(layoutNames, key, nil)
            end
        end
    end
    for idx, name in ipairs(snapshot) do
        local uiIndex = idx + 2
        if name and name ~= "" then
            rawset(layoutNames, uiIndex, name)
        else
            rawset(layoutNames, uiIndex, nil)
        end
    end
end

-- Setting types: we keep Blizzard enums but extend for custom widgets
lib.SettingType = lib.SettingType or CopyTable(Enum.EditModeSettingDisplayType)
lib.SettingType.Color = "Color"
lib.SettingType.CheckboxColor = "CheckboxColor"
lib.SettingType.DropdownColor = "DropdownColor"
lib.SettingType.MultiDropdown = "MultiDropdown"
lib.SettingType.Divider = "Divider"
lib.SettingType.Collapsible = "Collapsible"
lib.SettingType.Input = "Input"
lib.SettingType.Button = "SettingButton"
lib.SettingType.SoundPicker = "SoundPicker"
lib.SettingType.FontPicker = "FontPicker"
lib.SettingType.CompactFont = "CompactFont"
lib.SettingType.CompactSlider = "CompactSlider"
lib.SettingType.Header = "Header"

-- Debug toggle lives on internal; defaults to false
Internal.debugEnabled = Internal.debugEnabled or false

-- Utilities -----------------------------------------------------------------------
local Util = {}

function Util:DebugTraceDialogChildren(label)
    if not Internal.debugEnabled then
        return
    end
    local dlg = Internal.dialog
    if not dlg or not dlg.Settings then
        print("[EnhanceQoLEditMode] Debug", label or "", "dialog/settings missing")
        return
    end
    local shown, total = 0, 0
    for _, child in ipairs({ dlg.Settings:GetChildren() }) do
        total = total + 1
        if child:IsShown() then
            shown = shown + 1
        end
    end
    print(string.format("[EnhanceQoLEditMode] Debug %s: %d shown / %d total children", label or "", shown, total))
end
Internal.DebugTraceDialogChildren = Util.DebugTraceDialogChildren

function Util:SortMixedKeys(keys)
    table.sort(keys, function(a, b)
        local ta, tb = type(a), type(b)
        if ta == tb then
            if ta == "number" or ta == "string" then
                return a < b
            end
            return tostring(a) < tostring(b)
        end
        if ta == "number" then
            return true
        end
        if tb == "number" then
            return false
        end
        return tostring(a) < tostring(b)
    end)
    return keys
end

local function cloneOption(option, fallback)
    local cloned = {}
    if type(option) == "table" then
        for k, v in pairs(option) do
            cloned[k] = v
        end
    else
        cloned.value = option
    end
    if cloned.value == nil and fallback ~= nil then
        cloned.value = fallback
    end
    local defaultLabel = cloned.text or cloned.label or tostring(cloned.value or "")
    cloned.label = cloned.label or defaultLabel
    cloned.text = cloned.text or defaultLabel
    if cloned.value == nil then
        cloned.value = cloned.text
    end
    return cloned
end

function Util:NormalizeOptions(list)
    if type(list) ~= "table" then
        return {}
    end
    local normalized = {}
    if #list > 0 then
        for _, option in ipairs(list) do
            table.insert(normalized, cloneOption(option))
        end
    else
        local keys = {}
        for key in pairs(list) do
            table.insert(keys, key)
        end
        self:SortMixedKeys(keys)
        for _, key in ipairs(keys) do
            table.insert(normalized, cloneOption(list[key], key))
        end
    end
    return normalized
end

function Util:NormalizeSelection(value)
    local map = {}
    if type(value) == "table" then
        if #value > 0 then
            for _, entry in ipairs(value) do
                map[entry] = true
            end
        else
            for key, state in pairs(value) do
                if state then
                    map[key] = true
                end
            end
        end
    elseif value ~= nil then
        map[value] = true
    end
    return map
end

function Util:CopySelectionMap(map)
    local copy = {}
    if type(map) ~= "table" then
        return copy
    end
    for key, state in pairs(map) do
        if state then
            copy[key] = true
        end
    end
    return copy
end

function Util:ApplyTooltip(widget, target, tooltip)
    target = target or widget
    if not (target and target.SetScript) then
        return
    end
    target:SetScript("OnEnter", nil)
    target:SetScript("OnLeave", nil)
    if not tooltip or tooltip == "" then
        return
    end
    target:EnableMouse(true)
    target:SetScript("OnEnter", function()
        GameTooltip:SetOwner(target, "ANCHOR_RIGHT")
        GameTooltip:SetText(tooltip, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)
    target:SetScript("OnLeave", GameTooltip_Hide)
end

local function resolveOptions(data, layoutName)
    if not data then
        return {}
    end
    if data.optionfunc then
        local ok, result = pcall(data.optionfunc, layoutName)
        if ok and type(result) == "table" then
            return Util:NormalizeOptions(result)
        end
    end
    if type(data.options) == "table" then
        return Util:NormalizeOptions(data.options)
    end
    if type(data.values) == "table" then
        return Util:NormalizeOptions(data.values)
    end
    return {}
end

local function evaluateVisibility(data, layoutName, layoutIndex)
    if not data then
        return true
    end
    if layoutName == nil then
        layoutName = lib.activeLayoutName
    end
    if layoutIndex == nil then
        layoutIndex = lib:GetActiveLayoutIndex()
    end
    if data.isShown then
        local ok, result = pcall(data.isShown, layoutName, layoutIndex)
        if ok and result == false then
            return false
        end
    elseif data.hidden then
        local ok, result = pcall(data.hidden, layoutName, layoutIndex)
        if ok and result == true then
            return false
        end
    end
    return true
end

local function evaluateVisibilityFast(data, layoutName, layoutIndex)
    return evaluateVisibility(data, layoutName, layoutIndex)
end

local function updateLabelVisibility(selection, hidden)
    if not selection then
        return
    end
    selection.labelHidden = not not hidden
    if selection.Label then
        selection.Label:SetAlpha(hidden and 0 or 1)
    end
    if selection.Text then
        selection.Text:SetAlpha(hidden and 0 or 1)
    end
end

local function updateOverlayVisibility(selection, hidden)
    if not selection then
        return
    end
    selection.overlayHidden = not not hidden
    selection.overlayAlphas = selection.overlayAlphas or {}
    local numRegions = selection.GetNumRegions and selection:GetNumRegions() or 0
    for i = 1, numRegions do
        local region = select(i, selection:GetRegions())
        if region and region.GetObjectType and region:GetObjectType() == "Texture" then
            if hidden then
                if selection.overlayAlphas[region] == nil then
                    selection.overlayAlphas[region] = region:GetAlpha() or 1
                end
                region:SetAlpha(0)
            else
                local alpha = selection.overlayAlphas[region]
                region:SetAlpha(alpha ~= nil and alpha or 1)
            end
        end
    end
end

local function updateSelectionVisuals(selection, hidden)
    if hidden == nil and selection then
        hidden = selection.overlayHidden
    end
    updateLabelVisibility(selection, hidden)
    updateOverlayVisibility(selection, hidden)
end

local function isDragAllowed(frame)
    local predicate = State.dragPredicates[frame]
    if predicate == nil then
        return true
    end
    if type(predicate) == "function" then
        local ok, result = pcall(predicate, lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if ok then
            return result ~= false
        end
        return true
    end
    return predicate ~= false
end

local function isInCombat()
    if Internal.combatLockdown ~= nil then
        return Internal.combatLockdown
    end
    return InCombatLockdown and InCombatLockdown()
end

local function isSelectionEnabled(frame)
    if isInCombat() then
        return false
    end
    local predicate = State.selectionPredicates[frame]
    if predicate == nil then
        return true
    end
    if type(predicate) == "function" then
        local ok, result = pcall(predicate, lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if ok then
            return result ~= false
        end
        return true
    end
    return predicate ~= false
end

local function roundOffset(val)
    local n = tonumber(val) or 0
    if math.abs(n) < 0.001 then
        return 0
    end
    if n >= 0 then
        return math.floor(n + 0.5)
    else
        return math.ceil(n - 0.5)
    end
end

-- Layout helpers ------------------------------------------------------------------
local Layout = {}
local LFG_EYE_TEXTURE = [[Interface\LFGFrame\LFG-Eye]]
local LFG_EYE_FRAME_OPEN = 0
local LFG_EYE_FRAME_CLOSED = 4
local LFG_EYE_FRAME_WIDTH = 64
local LFG_EYE_FRAME_HEIGHT = 64
local LFG_EYE_TEXTURE_WIDTH = 512
local LFG_EYE_TEXTURE_HEIGHT = 256

local function setEyeFrame(tex, frameIndex)
    if not tex or not frameIndex then
        return
    end
    local cols = LFG_EYE_TEXTURE_WIDTH / LFG_EYE_FRAME_WIDTH
    local col = frameIndex % cols
    local row = math.floor(frameIndex / cols)

    local left = (col * LFG_EYE_FRAME_WIDTH) / LFG_EYE_TEXTURE_WIDTH
    local right = ((col + 1) * LFG_EYE_FRAME_WIDTH) / LFG_EYE_TEXTURE_WIDTH
    local top = (row * LFG_EYE_FRAME_HEIGHT) / LFG_EYE_TEXTURE_HEIGHT
    local bottom = ((row + 1) * LFG_EYE_FRAME_HEIGHT) / LFG_EYE_TEXTURE_HEIGHT

    tex:SetTexCoord(left, right, top, bottom)
end

local function updateEyeButton(eyeButton, hidden)
    if not eyeButton then
        return
    end
    local tex = eyeButton:GetNormalTexture()
    if tex then
        tex:SetTexture(LFG_EYE_TEXTURE)
        setEyeFrame(tex, hidden and LFG_EYE_FRAME_CLOSED or LFG_EYE_FRAME_OPEN)
        tex:SetDesaturated(false)
    end
end

-- Manager toggle panel -----------------------------------------------------------

local function resolveManagerToggleFrames(data)
    if not data then
        return nil
    end
    local frames = data.frames or data.frame
    if type(frames) == "function" then
        local ok, result = pcall(frames)
        if ok then
            frames = result
        else
            frames = nil
        end
    end
    if frames == nil then
        return nil
    end
    if type(frames) == "string" or (type(frames) == "table" and (frames.GetObjectType or frames.IsObjectType)) then
        frames = { frames }
    end
    if type(frames) ~= "table" then
        return nil
    end

    local resolved = {}
    for _, entry in ipairs(frames) do
        local frame = resolveFrame(entry)
        if frame then
            resolved[#resolved + 1] = frame
        end
    end
    if #resolved == 0 then
        for _, entry in pairs(frames) do
            local frame = resolveFrame(entry)
            if frame then
                resolved[#resolved + 1] = frame
            end
        end
    end
    if #resolved == 0 then
        return nil
    end
    return resolved
end

local function getManagerToggleValue(data)
    if not data then
        return true
    end
    if data.get then
        local ok, value = pcall(data.get, lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if ok and value ~= nil then
            return not not value
        end
    end
    local stored = State.managerToggleState[data.id]
    if stored ~= nil then
        return stored
    end
    local frames = resolveManagerToggleFrames(data)
    if frames and frames[1] and frames[1].IsShown then
        return frames[1]:IsShown() and true or false
    end
    if data.default ~= nil then
        return not not data.default
    end
    return true
end

local managerToggleInCombat = InCombatLockdown() and true or false

local function isManagerToggleEnabled(data)
    if not data then
        return true
    end
    if managerToggleInCombat and not data.allowInCombat then
        return false
    end

    local layoutName = lib.activeLayoutName
    local layoutIndex = lib:GetActiveLayoutIndex()
    if data.isEnabled then
        local ok, result = pcall(data.isEnabled, layoutName, layoutIndex)
        if ok then
            return result ~= false
        end
    elseif data.disabled then
        local ok, result = pcall(data.disabled, layoutName, layoutIndex)
        if ok then
            return result ~= true
        end
    end
    return true
end

local function applyManagerToggleValue(data, value)
    if not data then
        return false
    end
    if isInCombat() and not data.allowInCombat then
        return false
    end
    local layoutName = lib.activeLayoutName
    local layoutIndex = lib:GetActiveLayoutIndex()
    if data.set then
        local ok, result = pcall(data.set, layoutName, value, layoutIndex)
        if not ok or result == false then
            return false
        end
    else
        local frames = resolveManagerToggleFrames(data)
        if frames then
            for _, frame in ipairs(frames) do
                if frame then
                    if frame.SetShown then
                        frame:SetShown(value)
                    elseif value and frame.Show then
                        frame:Show()
                    elseif (not value) and frame.Hide then
                        frame:Hide()
                    end
                end
            end
        end
    end
    State.managerToggleState[data.id] = not not value
    return true
end

local function createIsolatedManagerCheckbox(parent)
    local row = CreateFrame("Frame", nil, parent)
    row:SetHeight(32)

    local check = CreateFrame("CheckButton", nil, row)
    check:SetSize(24, 24)
    check:SetPoint("LEFT", row, "LEFT", 0, 0)
    check:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
    check:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
    check:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]], "ADD")
    check:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
    check:SetDisabledCheckedTexture([[Interface\Buttons\UI-CheckBox-Check-Disabled]])

    local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", check, "RIGHT", 4, 0)
    label:SetPoint("RIGHT", row, "RIGHT", 0, 0)
    label:SetJustifyH("LEFT")
    label:SetWordWrap(false)
    local enabledR, enabledG, enabledB, enabledA = label:GetTextColor()

    function row:SetEnabled(enabled)
        enabled = enabled ~= false
        self.Check:SetEnabled(enabled)
        self.Check:SetAlpha(enabled and 1 or 0.5)
        if enabled then
            self.Label:SetTextColor(enabledR, enabledG, enabledB, enabledA)
        else
            self.Label:SetTextColor(0.5, 0.5, 0.5, 1)
        end
    end

    check:SetScript("OnClick", function(self)
        local data = row.data
        if not data then
            return
        end
        if InCombatLockdown() then
            self:SetChecked(getManagerToggleValue(data))
            return
        end
        applyManagerToggleValue(data, self:GetChecked() == true)
        self:SetChecked(getManagerToggleValue(data))
    end)

    row.Check = check
    row.Label = label
    return row
end

local isolatedManagerPanel
local refreshManagerTogglePanel

local function ensureIsolatedManagerPanel()
    if managerBroker.provider ~= lib or not EditModeManagerFrame then
        return nil
    end
    if isolatedManagerPanel then
        return isolatedManagerPanel
    end

    -- Keep the panel addon-owned, but mirror the original Edit Mode placement
    -- and border without restoring its taint-prone ScrollFrame/widget tree.
    local panel = CreateFrame("Frame", nil, UIParent)
    panel:SetPoint("TOPLEFT", EditModeManagerFrame, "BOTTOMLEFT", 0, -6)
    panel:SetPoint("TOPRIGHT", EditModeManagerFrame, "BOTTOMRIGHT", 0, -6)
    panel:SetHeight(1)
    panel:SetFrameStrata(EditModeManagerFrame:GetFrameStrata())
    panel:SetFrameLevel(EditModeManagerFrame:GetFrameLevel())
    panel:EnableMouse(true)
    panel:Hide()

    local border = CreateFrame("Frame", nil, panel, "DialogBorderTranslucentTemplate")
    border.ignoreInLayout = true

    local closeButton = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", panel, "TOPRIGHT", 2, 2)
    closeButton:SetScript("OnClick", function()
        panel.dismissed = true
        panel:Hide()
    end)

    panel.rows = {}
    panel.Border = border
    panel.CloseButton = closeButton
    isolatedManagerPanel = panel

    local combatWatcher = CreateFrame("Frame")
    combatWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
    combatWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
    combatWatcher:SetScript("OnEvent", function(_, event)
        managerToggleInCombat = event == "PLAYER_REGEN_DISABLED"
        refreshManagerTogglePanel()
    end)
    panel.CombatWatcher = combatWatcher

    hooksecurefunc(EditModeManagerFrame, "Show", function()
        panel.dismissed = false
        refreshManagerTogglePanel()
    end)
    hooksecurefunc(EditModeManagerFrame, "Hide", function()
        panel:Hide()
    end)

    return panel
end

refreshManagerTogglePanel = function()
    if managerBroker.provider ~= lib then
        return
    end

    local panel = ensureIsolatedManagerPanel()
    if not panel then
        return
    end

    local used = {}
    local rowIndex = 0
    for _, id in ipairs(State.managerToggleOrder) do
        local data = State.managerToggleSpecs[id]
        if data then
            rowIndex = rowIndex + 1
            local row = panel.rows[id]
            if not row then
                row = createIsolatedManagerCheckbox(panel)
                panel.rows[id] = row
            end
            row.data = data
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", panel, "TOPLEFT", 12, -12 - ((rowIndex - 1) * 32))
            row:SetPoint("RIGHT", panel, "RIGHT", -36, 0)
            row.Label:SetText(data.label or data.name or id)
            row.Check:SetChecked(getManagerToggleValue(data))
            row:SetEnabled(isManagerToggleEnabled(data))
            row:Show()
            used[id] = true
        end
    end

    for id, row in pairs(panel.rows) do
        if not used[id] then
            row:Hide()
            row.data = nil
        end
    end

    panel:SetHeight(24 + (rowIndex * 32))
    panel:SetShown(rowIndex > 0 and not panel.dismissed and EditModeManagerFrame:IsShown())
end

local function snapshotLayoutNames(layoutInfo)
    if not (layoutInfo and layoutInfo.layouts) then
        return {}
    end
    local snapshot = {}
    for index, info in ipairs(layoutInfo.layouts) do
        if info and info.layoutName then
            snapshot[index] = info.layoutName
        end
    end
    return snapshot
end

-- Track deleted layout names so we can still surface them once the delete event fires.
local function recordDeletedLayouts(oldSnapshot, newSnapshot)
    if not oldSnapshot or #newSnapshot >= #oldSnapshot then
        return
    end
    local deletedIndex
    for i = 1, #oldSnapshot do
        if oldSnapshot[i] ~= newSnapshot[i] then
            deletedIndex = i
            break
        end
    end
    deletedIndex = deletedIndex or #oldSnapshot
    local deletedName = oldSnapshot[deletedIndex]
    if not deletedName then
        return
    end
    local uiIndex = deletedIndex + 2
    if not State.pendingDeletedLayouts[uiIndex] then
        State.pendingDeletedLayouts[uiIndex] = deletedName
    end
end

-- Prefer cached names so we can resolve deleted layouts before reloading from the API.
local function getCachedLayoutName(layoutIndex)
    if not layoutIndex then
        return nil
    end
    if layoutIndex > 2 then
        local pending = State.pendingDeletedLayouts
        if pending and pending[layoutIndex] then
            return pending[layoutIndex]
        end
        local snapshot = State.layoutSnapshot or Internal.layoutNameSnapshot
        local cached = snapshot and snapshot[layoutIndex - 2]
        if cached then
            return cached
        end
    end
    return layoutNames[layoutIndex]
end

local function updateActiveLayoutFromAPI()
    if not C_EditMode or not C_EditMode.GetLayouts then
        return
    end
    local layouts = C_EditMode.GetLayouts()
    if layouts and layouts.activeLayout then
        lib.activeLayoutIndex = layouts.activeLayout
        lib.activeLayoutName = layoutNames[layouts.activeLayout]
    end
    State.layoutSnapshot = snapshotLayoutNames(layouts)
    Internal.layoutNameSnapshot = State.layoutSnapshot
    syncLayoutNameCache(State.layoutSnapshot)
end

if not lib.activeLayoutName and C_EditMode and C_EditMode.GetLayouts then
    local layouts = C_EditMode.GetLayouts()
    if layouts and layouts.activeLayout then
        lib.activeLayoutIndex = layouts.activeLayout
        lib.activeLayoutName = layoutNames[layouts.activeLayout]
    end
    State.layoutSnapshot = snapshotLayoutNames(layouts)
    Internal.layoutNameSnapshot = State.layoutSnapshot
    syncLayoutNameCache(State.layoutSnapshot)
end

function Layout:HandleLayoutsChanged(_, layoutInfo)
    -- if not lib.isEditing then return end
    local layoutIndex = layoutInfo and layoutInfo.activeLayout
    if not layoutIndex then
        updateActiveLayoutFromAPI()
    end
    layoutIndex = layoutIndex or lib.activeLayoutIndex
    local layoutName = layoutIndex and layoutNames[layoutIndex] or layoutNames[lib.activeLayoutIndex]

    local newSnapshot = snapshotLayoutNames(layoutInfo)
    local oldSnapshot = State.layoutSnapshot or {}
    local didLayoutCountShrink = #newSnapshot < #oldSnapshot
    -- Blizzard shifts custom layout indices on delete, which makes unchanged names
    -- look like rename diffs across the remaining entries.
    if not didLayoutCountShrink then
        for index, newName in ipairs(newSnapshot) do
            local oldName = oldSnapshot[index]
            if oldName and newName and oldName ~= newName then
                local uiIndex = index + 2
                for _, callback in next, lib.eventHandlersLayoutRenamed do
                    securecallfunction(callback, oldName, newName, uiIndex)
                end
            end
        end
    end
    if layoutInfo and layoutInfo.layouts then
        recordDeletedLayouts(oldSnapshot, newSnapshot)
    end
    State.layoutSnapshot = newSnapshot
    Internal.layoutNameSnapshot = State.layoutSnapshot
    syncLayoutNameCache(State.layoutSnapshot)

    if layoutName and layoutIndex and (layoutName ~= lib.activeLayoutName or layoutIndex ~= lib.activeLayoutIndex) then
        lib.activeLayoutName = layoutName
        lib.activeLayoutIndex = layoutIndex
        for _, callback in next, lib.eventHandlersLayout do
            securecallfunction(callback, layoutName, layoutIndex)
        end
    end
end

function Layout:HandleSpecChanged()
    -- if not lib.isEditing then return end
    if C_EditMode and C_EditMode.GetLayouts then
        local layouts = C_EditMode.GetLayouts()
        self:HandleLayoutsChanged(nil, layouts)
    end
    for _, callback in next, lib.eventHandlersSpec do
        local specID = GetSpecialization and GetSpecialization()
        securecallfunction(callback, specID)
    end
end

function Layout:HandleLayoutDeleted(deletedLayoutIndex)
    local deletedName = getCachedLayoutName(deletedLayoutIndex)
    for _, callback in next, lib.eventHandlersLayoutDeleted do
        securecallfunction(callback, deletedLayoutIndex, deletedName)
    end
    State.pendingDeletedLayouts[deletedLayoutIndex] = nil
end

function Layout:HandleLayoutAdded(addedLayoutIndex, activateNewLayout, isLayoutImported)
    local layoutType
    local layoutName
    if C_EditMode_GetLayouts then
        local info = C_EditMode_GetLayouts()
        local entry = info and info.layouts and info.layouts[addedLayoutIndex - 2]
        if entry and entry.layoutType then
            layoutType = entry.layoutType
        end
        layoutName = entry and entry.layoutName
    end
    layoutName = layoutName or layoutNames[addedLayoutIndex]
    for _, callback in next, lib.eventHandlersLayoutAdded do
        securecallfunction(callback, addedLayoutIndex, activateNewLayout, isLayoutImported, layoutType, layoutName)
    end

    -- Detect duplicates by serializing and comparing layout info
    if C_EditMode_GetLayouts and C_EditMode_ConvertLayoutInfoToString then
        local layoutInfo = C_EditMode_GetLayouts()
        if layoutInfo and layoutInfo.layouts then
            local customIndex = addedLayoutIndex - 2
            local newLayout = layoutInfo.layouts[customIndex]
            if newLayout then
                local newString = C_EditMode_ConvertLayoutInfoToString(newLayout)
                local newName = newLayout.layoutName or layoutName
                if newString and newString ~= "" then
                    local dupes = {}
                    for idx, info in ipairs(layoutInfo.layouts) do
                        if idx ~= customIndex then
                            local str = C_EditMode_ConvertLayoutInfoToString(info)
                            if str == newString or (newName and info.layoutName == newName) then
                                table.insert(dupes, idx + 2) -- convert to UI indices
                            end
                        end
                    end
                    if #dupes > 0 then
                        for _, callback in next, lib.eventHandlersLayoutDuplicate do
                            securecallfunction(callback, addedLayoutIndex, dupes, isLayoutImported, layoutType, newName)
                        end
                    end
                end
            end
        end
    end
end

-- Pools ----------------------------------------------------------------------------
local Pools = {}

function Pools:Create(kind, creator, resetter)
    local pool = CreateUnsecuredObjectPool(creator, resetter)
    local acquire = pool.Acquire
    pool.Acquire = function(poolObj, parent)
        local obj, new = acquire(poolObj)
        if parent then
            obj:SetParent(parent)
        end
        return obj, new
    end
    State.widgetPools[kind] = pool
    return pool
end

function Pools:Get(kind)
    return State.widgetPools[kind]
end

function Pools:ReleaseAll()
    for _, pool in next, State.widgetPools do
        pool:ReleaseAll()
    end
    if Internal.dialog and Internal.dialog.Settings then
        for _, child in ipairs({ Internal.dialog.Settings:GetChildren() }) do
            if child ~= Internal.dialog.Settings.ResetButton and child ~= Internal.dialog.Settings.Divider then
                child.ignoreInLayout = true
                if child.Hide then
                    child:Hide()
                end
                if child.SetParent then
                    child:SetParent(nil)
                end
            end
        end
    end
    Util:DebugTraceDialogChildren("ReleaseAllPools")
end

-- compatibility shims for callers that expect lib.internal pool helpers
function Internal:CreatePool(kind, creator, resetter)
    return Pools:Create(kind, creator, resetter)
end
function Internal:GetPool(kind)
    return Pools:Get(kind)
end
function Internal:ReleaseAllPools()
    return Pools:ReleaseAll()
end

-- Collapse state -------------------------------------------------------------------
local Collapse = {}

function Collapse:Get(frame, groupId)
    local layout = lib.activeLayoutName or "Default"
    local byFrame = State.collapseFlags[frame]
    local byLayout = byFrame and byFrame[layout]
    return byLayout and byLayout[groupId]
end

function Collapse:Set(frame, groupId, collapsed)
    local layout = lib.activeLayoutName or "Default"
    State.collapseFlags[frame] = State.collapseFlags[frame] or {}
    State.collapseFlags[frame][layout] = State.collapseFlags[frame][layout] or {}
    State.collapseFlags[frame][layout][groupId] = not not collapsed
end

function Collapse:Register(frame, groupId)
    if not (frame and groupId) then
        return
    end
    State.collapsibleIdsByFrame = State.collapsibleIdsByFrame or {}
    local registry = State.collapsibleIdsByFrame[frame]
    if not registry then
        registry = { ids = {}, seen = {} }
        State.collapsibleIdsByFrame[frame] = registry
    end
    if registry.seen[groupId] then
        return
    end
    registry.seen[groupId] = true
    registry.ids[#registry.ids + 1] = groupId
end

function Collapse:GetRegisteredIds(frame)
    local registry = State.collapsibleIdsByFrame and State.collapsibleIdsByFrame[frame] or nil
    return registry and registry.ids or nil
end

-- compatibility helpers for legacy internal calls
function Internal:GetCollapseState(frame, groupId)
    return Collapse:Get(frame, groupId)
end
function Internal:SetCollapseState(frame, groupId, collapsed)
    return Collapse:Set(frame, groupId, collapsed)
end
function Internal:FocusSettingGroup(frame, targetGroupId)
    if not (frame and targetGroupId) then
        return false
    end
    local groupIds = Collapse:GetRegisteredIds(frame)
    if type(groupIds) ~= "table" then
        return false
    end
    local foundTarget = false
    for _, groupId in ipairs(groupIds) do
        if groupId == targetGroupId then
            foundTarget = true
        end
    end
    if not foundTarget then
        return false
    end
    for _, groupId in ipairs(groupIds) do
        Collapse:Set(frame, groupId, groupId ~= targetGroupId)
    end
    return true
end

-- Widget factory -------------------------------------------------------------------
local Widgets = {}
local SUMMARY_CHAR_LIMIT = 80

local function buildCheckbox()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.Label:SetText(data.name)
        applyRowHeightOverride(self, selection and selection.parent, "checkbox")
        local value = data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if value == nil then
            value = data.default
        end
        self.checked = value
        self.Button:SetChecked(not not value)
        Util:ApplyTooltip(self, self, data.tooltip)
    end

    function mixin:OnCheckButtonClick()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        self.checked = not self.checked
        self.setting.set(lib.activeLayoutName, not not self.checked, lib:GetActiveLayoutIndex())
        Internal:RequestRefreshSettings()
    end

    function mixin:SetEnabled(enabled)
        self.Button:SetEnabled(enabled)
        self.Label:SetFontObject(enabled and "GameFontHighlightMedium" or "GameFontDisable")
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "EditModeSettingCheckboxTemplate")
        return Mixin(frame, mixin)
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function dropdownGet(data)
    local val = data.value ~= nil and data.value or data.text
    return data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex()) == val
end

local function dropdownSet(data)
    local val = data.value ~= nil and data.value or data.text
    data.set(lib.activeLayoutName, val, lib:GetActiveLayoutIndex())
    Internal:RequestRefreshSettings()
end

local function buildDropdown()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.Label:SetText(data.name)
        self.ignoreInLayout = nil
        applyRowHeightOverride(self, selection and selection.parent, "dropdown")

        if data.useOldStyle and self.OldDropdown then
            self.Control:Hide()
            self.OldDropdown:Show()
            self.Dropdown = self.OldDropdown
        else
            if self.OldDropdown then
                self.OldDropdown:Hide()
            end
            self.Control:Show()
            self.Dropdown = self.Control.Dropdown
        end

        if data.generator then
            self.Dropdown:SetupMenu(function(owner, rootDescription)
                if data.height then
                    rootDescription:SetScrollMode(data.height)
                end
                pcall(data.generator, owner, rootDescription, data)
            end)
        elseif data.values then
            self.Dropdown:SetupMenu(function(_, rootDescription)
                if data.height then
                    rootDescription:SetScrollMode(data.height)
                end
                for _, value in next, data.values do
                    rootDescription:CreateRadio(value.text, dropdownGet, dropdownSet, {
                        get = data.get,
                        set = data.set,
                        value = value.value or value.text,
                    })
                end
            end)
        end

        Util:ApplyTooltip(self, self.Dropdown, data.tooltip)
    end

    function mixin:SetEnabled(enabled)
        self.Dropdown:SetEnabled(enabled)
        self.Label:SetFontObject(enabled and "GameFontHighlightMedium" or "GameFontDisable")
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 32
        Mixin(frame, mixin)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local control = CreateFrame("Frame", nil, frame, "SettingsDropdownWithButtonsTemplate")
        control:SetPoint("LEFT", label, "RIGHT", 5, 0)
        frame.Control = control

        if control.DecrementButton then
            control.DecrementButton:Hide()
        end
        if control.IncrementButton then
            control.IncrementButton:Hide()
        end

        local dropdown = control.Dropdown
        dropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)
        dropdown:SetSize(200, 30)
        frame.Dropdown = dropdown

        local oldDropdown = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
        oldDropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)
        oldDropdown:SetSize(200, 30)
        oldDropdown:Hide()
        frame.OldDropdown = oldDropdown

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function buildCompactFont()
    local mixin = {}

    local function getOptions(data)
        local options = data.values
        if type(options) == "function" then
            local ok, result = pcall(options)
            options = ok and result or {}
        end
        return type(options) == "table" and options or {}
    end

    function mixin:Setup(data, selection)
        if data.kind == lib.SettingType.CompactSlider then
            local source = data
            data = {}
            for key, value in pairs(source) do
                data[key] = value
            end
            data.detailsOnly = true
            data.noCheckbox = true
            data.getEnabled = function()
                return true
            end
            data.details = {
                title = source.name,
                sliders = {
                    {
                        label = source.sliderLabel or source.name,
                        min = source.minValue,
                        max = source.maxValue,
                        step = source.valueStep,
                        editable = false,
                        formatter = source.formatter,
                        get = function()
                            return source.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
                        end,
                        set = function(value)
                            source.set(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
                        end,
                    },
                },
            }
        end
        self.setting = data
        self.Label:SetText(data.name or "Font")
        self.detailsOnly = data.detailsOnly and true or false
        self.noCheckbox = data.noCheckbox and true or false
        self.Button:SetShown(not self.noCheckbox)
        self.Label:ClearAllPoints()
        if self.noCheckbox then
            self.Label:SetPoint("LEFT", self, "LEFT", 0, 0)
        else
            self.Label:SetPoint("LEFT", self.Button, "RIGHT", 2, 0)
        end
        if self.detailsOnly then
            self.Label:SetWordWrap(false)
            self.Label:SetWidth(self.Label:GetUnboundedStringWidthForText(data.name or "Font") + 5)
        else
            self.Label:SetWordWrap(true)
            self.Label:SetWidth(92)
        end
        self.ignoreInLayout = nil
        applyRowHeightOverride(self, selection and selection.parent, "dropdown")

        local enabled = data.getEnabled(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        self.checked = enabled and true or false
        self.Button:SetChecked(self.checked)

        self.Dropdown:SetShown(not self.detailsOnly)
        self.DetailsButton:ClearAllPoints()
        if self.detailsOnly then
            self.DetailsButton:SetPoint("LEFT", self.Label, "RIGHT", 8, 0)
        else
            self.DetailsButton:SetPoint("LEFT", self.Dropdown, "RIGHT", 5, 0)
            self.Dropdown:SetupMenu(function(_, rootDescription)
                for _, option in ipairs(getOptions(data)) do
                    local value = option.value ~= nil and option.value or option.text
                    local text = option.text or option.label or tostring(value)
                    rootDescription:CreateRadio(text, function()
                        return data.getSize(lib.activeLayoutName, lib:GetActiveLayoutIndex()) == value
                    end, function()
                        data.setSize(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
                        Internal:RequestRefreshSettings()
                    end)
                end
            end)
        end

        local details = {}
        for key, value in pairs(data.details or {}) do
            details[key] = value
        end
        local originalChanged = details.onChanged
        details.onChanged = function()
            if originalChanged then
                originalChanged()
            end
            Internal:RequestRefreshSettings()
        end
        self.compactFontDetails = details

        Util:ApplyTooltip(self, self, data.tooltip)
        self:SetEnabled(self._eqolEnabled ~= false)
    end

    function mixin:OnCheckButtonClick()
        self.checked = not self.checked
        PlaySound(self.checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        self.setting.setEnabled(lib.activeLayoutName, self.checked, lib:GetActiveLayoutIndex())
        self:SetEnabled(self._eqolEnabled ~= false)
        Internal:RequestRefreshSettings()
    end

    function mixin:SetEnabled(enabled)
        self._eqolEnabled = enabled ~= false
        self.Button:SetEnabled(self._eqolEnabled)
        self.Label:SetFontObject(self._eqolEnabled and "GameFontHighlightMedium" or "GameFontDisable")
        local detailsEnabled = self._eqolEnabled and (self.noCheckbox or self.checked)
        if not self.detailsOnly then
            self.Dropdown:SetEnabled(detailsEnabled)
        end
        self.DetailsButton:SetEnabled(detailsEnabled)
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "EditModeSettingCheckboxTemplate")
        frame:SetSize(330, 32)
        frame.fixedHeight = 32
        Mixin(frame, mixin)

        frame.Label:SetWidth(92)

        local dropdown = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
        dropdown:SetPoint("LEFT", frame.Label, "RIGHT", 5, 0)
        dropdown:SetSize(145, 30)
        frame.Dropdown = dropdown

        local detailsButton = ns.LibEQOL.CompactFont:CreateDetailsButton(frame)
        detailsButton:SetPoint("LEFT", dropdown, "RIGHT", 5, 0)
        detailsButton:SetScript("OnClick", function()
            ns.LibEQOL.CompactFont:OpenDetails(detailsButton, frame.compactFontDetails)
        end)
        frame.DetailsButton = detailsButton

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.setting = nil
        frame.compactFontDetails = nil
        frame.checked = nil
        frame._eqolEnabled = nil
        frame.detailsOnly = nil
        frame.noCheckbox = nil
        frame.Dropdown:Show()
    end
end

local function buildMultiDropdown()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.ignoreInLayout = nil
        self.summaryAnchored = nil
        self.summaryMeasure = nil
        self.hideSummary = true
        local selectionParent = selection and selection.parent

        local defaultText
        if data.customText ~= nil then
            defaultText = tostring(data.customText)
        elseif data.customDefaultText ~= nil then
            defaultText = tostring(data.customDefaultText)
        else
            defaultText = ""
        end

        self.Label:SetText(data.name)

        if data.useOldStyle and self.OldDropdown then
            self.Control:Hide()
            self.OldDropdown:Show()
            self.Dropdown = self.OldDropdown
        else
            if self.OldDropdown then
                self.OldDropdown:Hide()
            end
            self.Control:Show()
            self.Dropdown = self.Control.Dropdown
        end

        -- Keep both dropdown variants in sync so switching styles doesn't bring back "Custom"
        if self.Control and self.Control.Dropdown then
            self.Control.Dropdown:SetDefaultText(defaultText)
        end
        if self.OldDropdown then
            self.OldDropdown:SetDefaultText(defaultText)
        end
        self.Dropdown:SetDefaultText(defaultText)

        if self.Summary then
            self.Summary:ClearAllPoints()
            self.Summary:SetPoint("TOPLEFT", self.Dropdown, "BOTTOMLEFT", 0, -2)
            self.Summary:SetPoint("TOPRIGHT", self.Dropdown, "BOTTOMRIGHT", 0, -2)
        end

        local targetHeight = self.hideSummary and 32 or 48
        local override
        if self.hideSummary then
            override = getRowHeightOverride(selectionParent, "multiDropdown")
            if not override then
                override = getRowHeightOverride(selectionParent, "dropdown")
            end
        else
            override = getRowHeightOverride(selectionParent, "multiDropdownSummary")
            if not override then
                override = getRowHeightOverride(selectionParent, "multiDropdown")
            end
        end
        if override then
            targetHeight = override
        end

        self.fixedHeight = targetHeight
        self:SetHeight(targetHeight)
        if self.hideSummary and self.Summary then
            self.Summary:Hide()
        end

        self.Dropdown:SetupMenu(function(_, rootDescription)
            if data.height then
                rootDescription:SetScrollMode(data.height)
            end
            for _, option in ipairs(resolveOptions(data, lib.activeLayoutName)) do
                if option.value ~= nil then
                    local label = option.label or option.text or tostring(option.value)
                    rootDescription:CreateCheckbox(label, function()
                        return self:IsSelected(option.value)
                    end, function()
                        self:ToggleOption(option.value)
                    end, option)
                end
            end
        end)

        self:RefreshSummary()

        Util:ApplyTooltip(self, self.Dropdown, data.tooltip)
    end

    function mixin:GetSelectionMap()
        local selection = self.setting and self.setting.get and self.setting.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if selection == nil and self.setting then
            selection = self.setting.default
        end
        return Util:NormalizeSelection(selection)
    end

    function mixin:IsSelected(value)
        if value == nil then
            return false
        end
        if self.setting and self.setting.isSelected then
            return not not self.setting.isSelected(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
        end
        local map = self:GetSelectionMap()
        return map[value] == true
    end

    function mixin:SetSelected(value, shouldSelect)
        if not self.setting then
            return
        end
        if self.setting.setSelected then
            self.setting.setSelected(lib.activeLayoutName, value, shouldSelect, lib:GetActiveLayoutIndex())
        elseif self.setting.set then
            local map = self:GetSelectionMap()
            map[value] = shouldSelect and true or nil
            self.setting.set(lib.activeLayoutName, map, lib:GetActiveLayoutIndex())
        end
        if self.setting.refreshOnSelect ~= false then
            Internal:RequestRefreshSettings()
        end
    end

    function mixin:ToggleOption(value)
        self:SetSelected(value, not self:IsSelected(value))
        self:RefreshSummary()
    end

    function mixin:EnsureSummaryAnchors()
        if self.summaryAnchored or not (self.Summary and self.Dropdown) or self.hideSummary then
            return
        end
        self.summaryAnchored = true
        self.Summary:ClearAllPoints()
        self.Summary:SetPoint("TOPLEFT", self.Dropdown, "BOTTOMLEFT", 0, -2)
        self.Summary:SetPoint("TOPRIGHT", self.Dropdown, "BOTTOMRIGHT", 0, -2)
        self.Summary:SetWidth(self.Dropdown:GetWidth())
    end

    function mixin:GetSummaryWidthLimit()
        if self.Dropdown then
            return self.Dropdown:GetWidth()
        end
        if self.Summary then
            return self.Summary:GetWidth()
        end
    end

    function mixin:GetSummaryMeasureFontString()
        if self.summaryMeasure and self.summaryMeasure:IsObjectType("FontString") then
            return self.summaryMeasure
        end
        if not self.Summary then
            return nil
        end
        local fs = self.Summary:GetParent():CreateFontString(nil, "OVERLAY")
        if not fs then
            return nil
        end
        fs:SetFontObject(self.Summary:GetFontObject())
        fs:Hide()
        fs:SetWordWrap(false)
        fs:SetNonSpaceWrap(false)
        fs:SetSpacing(0)
        self.summaryMeasure = fs
        return fs
    end

    function mixin:WouldExceedSummaryWidth(text, widthLimit)
        if not text or text == "" then
            return false
        end
        if not widthLimit then
            return #text > SUMMARY_CHAR_LIMIT
        end
        local measure = self:GetSummaryMeasureFontString()
        if not measure then
            return #text > SUMMARY_CHAR_LIMIT
        end
        measure:SetFontObject(self.Summary:GetFontObject())
        measure:SetText(text)
        local getWidth = measure.GetUnboundedStringWidth or measure.GetStringWidth
        return getWidth(measure) > widthLimit
    end

    function mixin:FormatSummaryText(texts)
        if #texts == 0 then
            return "–"
        end
        local widthLimit = self:GetSummaryWidthLimit()
        local summary = ""
        local overflow = 0
        for index, text in ipairs(texts) do
            local candidate = (summary == "") and text or (summary .. ", " .. text)
            if widthLimit and summary ~= "" and self:WouldExceedSummaryWidth(candidate, widthLimit) then
                overflow = #texts - index + 1
                break
            elseif widthLimit and summary == "" and self:WouldExceedSummaryWidth(candidate, widthLimit) then
                summary = text
                overflow = #texts - index
                break
            else
                summary = candidate
            end
        end
        if overflow > 0 then
            local overflowText = (" … (+%d)"):format(overflow)
            local candidate = summary .. overflowText
            if widthLimit and self:WouldExceedSummaryWidth(candidate, widthLimit) then
                candidate = summary .. " …"
            end
            summary = candidate
        end
        if not widthLimit and #summary > SUMMARY_CHAR_LIMIT then
            summary = summary:sub(1, SUMMARY_CHAR_LIMIT) .. " …"
        end
        return summary
    end

    function mixin:RefreshSummary()
        if self.hideSummary or not self.Summary then
            return
        end
        self:EnsureSummaryAnchors()
        local texts = {}
        for _, opt in ipairs(resolveOptions(self.setting, lib.activeLayoutName)) do
            if opt.value ~= nil and self:IsSelected(opt.value) then
                table.insert(texts, opt.text or tostring(opt.value))
            end
        end
        local summary = self:FormatSummaryText(texts)
        self.Summary:SetText(summary)
        local enabled = not self.Dropdown or self.Dropdown:IsEnabled()
        self.Summary:SetFontObject(enabled and "GameFontHighlightSmall" or "GameFontDisableSmall")
    end

    function mixin:SetEnabled(enabled)
        self.Dropdown:SetEnabled(enabled)
        self.Label:SetFontObject(enabled and "GameFontHighlightMedium" or "GameFontDisable")
        if self.Summary then
            self.Summary:SetFontObject(enabled and "GameFontHighlightSmall" or "GameFontDisableSmall")
        end
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 48
        frame:SetHeight(48)
        Mixin(frame, mixin)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local control = CreateFrame("Frame", nil, frame, "SettingsDropdownWithButtonsTemplate")
        control:SetPoint("LEFT", label, "RIGHT", 5, 0)
        frame.Control = control

        if control.DecrementButton then
            control.DecrementButton:Hide()
        end
        if control.IncrementButton then
            control.IncrementButton:Hide()
        end

        local dropdown = control.Dropdown
        dropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)
        dropdown:SetSize(200, 30)
        frame.Dropdown = dropdown

        local oldDropdown = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
        oldDropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)
        oldDropdown:SetSize(200, 30)
        oldDropdown:Hide()
        frame.OldDropdown = oldDropdown

        local summary = frame:CreateFontString(nil, nil, "GameFontHighlightSmall")
        summary:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 0, -2)
        summary:SetPoint("TOPRIGHT", dropdown, "BOTTOMRIGHT", 0, -2)
        summary:SetJustifyH("LEFT")
        summary:SetText("–")
        frame.Summary = summary

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.summaryAnchored = nil
        frame.summaryMeasure = nil
    end
end

local function normalizeColor(value)
    if type(value) == "table" then
        return value.r or value[1] or 1, value.g or value[2] or 1, value.b or value[3] or 1, value.a or value[4]
    elseif type(value) == "number" then
        return value, value, value
    end
    return 1, 1, 1
end

local function buildColor()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.Label:SetText(data.name)
        self.ignoreInLayout = nil
        applyRowHeightOverride(self, selection and selection.parent, "color")
        local r, g, b, a = normalizeColor(data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex()) or data.default)
        self.hasOpacity = not not (data.hasOpacity or a)
        self:SetColor(r, g, b, a)
    end

    function mixin:SetColor(r, g, b, a)
        self.r, self.g, self.b, self.a = r, g, b, a
        self.Swatch:SetColorTexture(r, g, b, a or 1)
    end

    function mixin:OnClick()
        local prev = { r = self.r or 1, g = self.g or 1, b = self.b or 1, a = self.a }
        ColorPickerFrame:SetupColorPickerAndShow({
            r = prev.r,
            g = prev.g,
            b = prev.b,
            opacity = prev.a,
            hasOpacity = self.hasOpacity,
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = self.hasOpacity and (ColorPickerFrame.GetColorAlpha and ColorPickerFrame:GetColorAlpha() or prev.a)
                self:SetColor(r, g, b, a)
                self.setting.set(lib.activeLayoutName, { r = r, g = g, b = b, a = a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
            opacityFunc = function()
                if not self.hasOpacity then
                    return
                end
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame.GetColorAlpha and ColorPickerFrame:GetColorAlpha() or prev.a
                self:SetColor(r, g, b, a)
                self.setting.set(lib.activeLayoutName, { r = r, g = g, b = b, a = a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
            cancelFunc = function()
                self:SetColor(prev.r, prev.g, prev.b, prev.a)
                self.setting.set(lib.activeLayoutName, { r = prev.r, g = prev.g, b = prev.b, a = prev.a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
        })
    end

    function mixin:SetEnabled(enabled)
        if enabled then
            self.Button:Enable()
            self.Swatch:SetVertexColor(1, 1, 1, 1)
            self.Label:SetFontObject("GameFontHighlightMedium")
        else
            self.Button:Disable()
            self.Swatch:SetVertexColor(0.4, 0.4, 0.4, 1)
            self.Label:SetFontObject("GameFontDisable")
        end
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 32
        Mixin(frame, mixin)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local button = CreateFrame("Button", nil, frame)
        button:SetSize(COLOR_BUTTON_WIDTH, 22)
        button:SetPoint("LEFT", label, "RIGHT", 8, 0)

        local border = button:CreateTexture(nil, "BACKGROUND")
        border:SetColorTexture(0.7, 0.7, 0.7, 1)
        border:SetAllPoints()

        local swatch = button:CreateTexture(nil, "ARTWORK")
        swatch:SetPoint("TOPLEFT", 2, -2)
        swatch:SetPoint("BOTTOMRIGHT", -2, 2)
        swatch:SetColorTexture(1, 1, 1, 1)
        frame.Swatch = swatch

        button:SetScript("OnClick", function()
            frame:OnClick()
        end)
        frame.Button = button

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function buildCheckboxColor()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.Label:SetText(data.name)
        self.ignoreInLayout = nil
        local selectionParent = selection and selection.parent
        local override = getRowHeightOverride(selectionParent, "checkboxColor") or getRowHeightOverride(selectionParent, "color")
        if override then
            self.fixedHeight = override
            self:SetHeight(override)
        end

        local value = data.get and data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if value == nil then
            value = data.default
        end
        self.checked = not not value
        self.Check:SetChecked(self.checked)

        local colorVal
        if data.colorGet then
            colorVal = data.colorGet(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        end
        if not colorVal then
            colorVal = data.colorDefault or { 1, 1, 1, 1 }
        end
        local r, g, b, a = normalizeColor(colorVal)
        self.hasOpacity = not not (data.hasOpacity or a)
        self:SetColor(r, g, b, a)
        self:UpdateColorEnabled()

        Util:ApplyTooltip(self, self, data.tooltip)
    end

    function mixin:UpdateColorEnabled()
        local enabled = self.checked
        if enabled then
            self.Button:Enable()
            self.Swatch:SetVertexColor(1, 1, 1, 1)
        else
            self.Button:Disable()
            self.Swatch:SetVertexColor(0.4, 0.4, 0.4, 1)
        end
    end

    function mixin:SetColor(r, g, b, a)
        self.r, self.g, self.b, self.a = r, g, b, a
        self.Swatch:SetColorTexture(r, g, b, a or 1)
    end

    function mixin:OnCheckboxClick()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        self.checked = not self.checked
        if self.setting.set then
            self.setting.set(lib.activeLayoutName, self.checked, lib:GetActiveLayoutIndex())
        end
        self:UpdateColorEnabled()
        Internal:RequestRefreshSettings()
    end

    function mixin:OnColorClick()
        local prev = { r = self.r or 1, g = self.g or 1, b = self.b or 1, a = self.a }
        local apply = self.setting.colorSet or self.setting.setColor
        if not apply then
            return
        end
        ColorPickerFrame:SetupColorPickerAndShow({
            r = prev.r,
            g = prev.g,
            b = prev.b,
            opacity = prev.a,
            hasOpacity = self.hasOpacity,
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = self.hasOpacity and (ColorPickerFrame.GetColorAlpha and ColorPickerFrame:GetColorAlpha() or prev.a)
                self:SetColor(r, g, b, a)
                apply(lib.activeLayoutName, { r = r, g = g, b = b, a = a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
            opacityFunc = function()
                if not self.hasOpacity then
                    return
                end
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame.GetColorAlpha and ColorPickerFrame:GetColorAlpha() or prev.a
                self:SetColor(r, g, b, a)
                apply(lib.activeLayoutName, { r = r, g = g, b = b, a = a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
            cancelFunc = function()
                self:SetColor(prev.r, prev.g, prev.b, prev.a)
                apply(lib.activeLayoutName, { r = prev.r, g = prev.g, b = prev.b, a = prev.a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
        })
    end

    function mixin:SetEnabled(enabled)
        self.Check:SetEnabled(enabled)
        if not enabled then
            self.Button:Disable()
            self.Swatch:SetVertexColor(0.2, 0.2, 0.2, 1)
            self.Label:SetFontObject("GameFontDisable")
        else
            self:UpdateColorEnabled()
            self.Label:SetFontObject("GameFontHighlightMedium")
        end
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 32
        Mixin(frame, mixin)

        local check = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
        check:SetPoint("LEFT", -5, 0)
        check:SetScript("OnClick", function(btn)
            btn:GetParent():OnCheckboxClick()
        end)
        frame.Check = check

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT", check, "RIGHT", 2, 0)
        label:SetWidth(175)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local button = CreateFrame("Button", nil, frame)
        button:SetSize(COLOR_BUTTON_WIDTH, 22)
        button:SetPoint("LEFT", label, "RIGHT", 4, 0)

        local border = button:CreateTexture(nil, "BACKGROUND")
        border:SetColorTexture(0.7, 0.7, 0.7, 1)
        border:SetAllPoints()

        local swatch = button:CreateTexture(nil, "ARTWORK")
        swatch:SetPoint("TOPLEFT", 2, -2)
        swatch:SetPoint("BOTTOMRIGHT", -2, 2)
        swatch:SetColorTexture(1, 1, 1, 1)
        frame.Swatch = swatch

        button:SetScript("OnClick", function()
            frame:OnColorClick()
        end)
        frame.Button = button

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function buildDropdownColor()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.Label:SetText(data.name)
        self.ignoreInLayout = nil
        local selectionParent = selection and selection.parent
        local override = getRowHeightOverride(selectionParent, "dropdownColor") or getRowHeightOverride(selectionParent, "dropdown")
        if override then
            self.fixedHeight = override
            self:SetHeight(override)
        end

        if data.useOldStyle then
            if self.OldDropdown then
                self.Control:Hide()
                self.OldDropdown:Show()
                self.Dropdown = self.OldDropdown
            end
        else
            if self.OldDropdown then
                self.OldDropdown:Hide()
            end
            self.Control:Show()
            self.Dropdown = self.Control.Dropdown
        end

        local function createEntries(rootDescription)
            if data.height then
                rootDescription:SetScrollMode(data.height)
            end
            local function getCurrent()
                return data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
            end
            local function makeSetter(value)
                return function()
                    data.set(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
                    Internal:RequestRefreshSettings()
                end
            end
            if data.values then
                for _, value in next, data.values do
                    rootDescription:CreateRadio(value.text, function()
                        return getCurrent() == value.text
                    end, makeSetter(value.value or value.text))
                end
            end
        end

        if data.generator then
            self.Dropdown:SetupMenu(function(owner, rootDescription)
                if data.height then
                    rootDescription:SetScrollMode(data.height)
                end
                pcall(data.generator, owner, rootDescription, data)
            end)
        elseif data.values then
            self.Dropdown:SetupMenu(function(_, rootDescription)
                createEntries(rootDescription)
            end)
        end

        local colorVal
        if data.colorGet then
            colorVal = data.colorGet(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        end
        if not colorVal then
            colorVal = data.colorDefault or { 1, 1, 1, 1 }
        end
        local r, g, b, a = normalizeColor(colorVal)
        self.hasOpacity = not not (data.hasOpacity or a)
        self:SetColor(r, g, b, a)

        Util:ApplyTooltip(self, self, data.tooltip)
    end

    function mixin:SetColor(r, g, b, a)
        self.r, self.g, self.b, self.a = r, g, b, a
        self.Swatch:SetColorTexture(r, g, b, a or 1)
    end

    function mixin:OnColorClick()
        local prev = { r = self.r or 1, g = self.g or 1, b = self.b or 1, a = self.a }
        local apply = self.setting.colorSet or self.setting.setColor
        if not apply then
            return
        end
        ColorPickerFrame:SetupColorPickerAndShow({
            r = prev.r,
            g = prev.g,
            b = prev.b,
            opacity = prev.a,
            hasOpacity = self.hasOpacity,
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = self.hasOpacity and (ColorPickerFrame.GetColorAlpha and ColorPickerFrame:GetColorAlpha() or prev.a)
                self:SetColor(r, g, b, a)
                apply(lib.activeLayoutName, { r = r, g = g, b = b, a = a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
            opacityFunc = function()
                if not self.hasOpacity then
                    return
                end
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame.GetColorAlpha and ColorPickerFrame:GetColorAlpha() or prev.a
                self:SetColor(r, g, b, a)
                apply(lib.activeLayoutName, { r = r, g = g, b = b, a = a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
            cancelFunc = function()
                self:SetColor(prev.r, prev.g, prev.b, prev.a)
                apply(lib.activeLayoutName, { r = prev.r, g = prev.g, b = prev.b, a = prev.a }, lib:GetActiveLayoutIndex())
                Internal:RequestRefreshSettings()
            end,
        })
    end

    function mixin:SetEnabled(enabled)
        self.Dropdown:SetEnabled(enabled)
        if enabled then
            self.Button:Enable()
            self.Swatch:SetVertexColor(1, 1, 1, 1)
            self.Label:SetFontObject("GameFontHighlightMedium")
        else
            self.Button:Disable()
            self.Swatch:SetVertexColor(0.4, 0.4, 0.4, 1)
            self.Label:SetFontObject("GameFontDisable")
        end
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 32
        Mixin(frame, mixin)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        -- modern control
        local control = CreateFrame("Frame", nil, frame, "SettingsDropdownWithButtonsTemplate")
        control:SetPoint("LEFT", label, "RIGHT", 5, 0)
        frame.Control = control

        if control.DecrementButton then
            control.DecrementButton:Hide()
        end
        if control.IncrementButton then
            control.IncrementButton:Hide()
        end

        local dropdown = control.Dropdown
        dropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)
        dropdown:SetHeight(30)
        dropdown:SetWidth(175)
        frame.Dropdown = dropdown

        -- old style control (hidden by default)
        local oldDropdown = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
        oldDropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)
        oldDropdown:SetHeight(30)
        oldDropdown:SetWidth(175)
        oldDropdown:Hide()
        frame.OldDropdown = oldDropdown

        local button = CreateFrame("Button", nil, frame)
        button:SetSize(COLOR_BUTTON_WIDTH, 22)
        button:SetPoint("LEFT", frame.Dropdown, "RIGHT", 2, 0)

        local border = button:CreateTexture(nil, "BACKGROUND")
        border:SetColorTexture(0.7, 0.7, 0.7, 1)
        border:SetAllPoints()

        local swatch = button:CreateTexture(nil, "ARTWORK")
        swatch:SetPoint("TOPLEFT", 2, -2)
        swatch:SetPoint("BOTTOMRIGHT", -2, 2)
        swatch:SetColorTexture(1, 1, 1, 1)
        frame.Swatch = swatch

        button:SetScript("OnClick", function()
            frame:OnColorClick()
        end)
        frame.Button = button

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function formatInputValue(data, value)
    if data and data.formatter then
        local ok, formatted = pcall(data.formatter, value)
        if ok and formatted ~= nil then
            return tostring(formatted)
        end
    end
    if value == nil then
        return ""
    end
    return tostring(value)
end

local function buildInput()
    local mixin = {}

    function mixin:ApplyLayout()
        local data = self.setting or self.data
        local labelWidth = tonumber(data and data.labelWidth) or 100
        self.Label:SetWidth(labelWidth)
        local inputWidth = tonumber(data and data.inputWidth)
        self.Input:ClearAllPoints()
        self.Input:SetPoint("LEFT", self.Label, "RIGHT", 12, 0)
        local maxWidth = DEFAULT_INPUT_MAX_WIDTH
        local totalWidth = self:GetWidth() or 0
        if totalWidth > 0 then
            local available = totalWidth - labelWidth - 12 - 2
            if available < DEFAULT_INPUT_MIN_WIDTH then
                available = DEFAULT_INPUT_MIN_WIDTH
            end
            if available < maxWidth then
                maxWidth = available
            end
        end
        if inputWidth and inputWidth > 0 then
            if inputWidth > maxWidth then
                inputWidth = maxWidth
            end
            self.Input:SetWidth(inputWidth)
        else
            self.Input:SetWidth(maxWidth)
        end
    end

    function mixin:SetValue(value)
        self.currentValue = value
        self._suppressInput = true
        self.Input:SetText(formatInputValue(self.setting, value))
        self._suppressInput = nil
    end

    function mixin:CommitInput()
        if not self.setting or self.readOnly then
            self:SetValue(self.currentValue)
            return
        end
        local text = self.Input:GetText() or ""
        local value = text
        if self.numeric then
            local num = tonumber((text or ""):gsub(",", "."))
            if not num then
                self:SetValue(self.currentValue)
                return
            end
            value = num
        end
        if value ~= self.currentValue then
            self.setting.set(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
            self.currentValue = value
            Internal:RequestRefreshSettings()
        end
        self:SetValue(self.currentValue)
    end

    function mixin:Setup(data, selection)
        self.setting = data
        self.data = data
        self.Label:SetText(data.name or "")
        applyRowHeightOverride(self, selection and selection.parent, "input")

        self.numeric = not not data.numeric
        self.readOnly = not not data.readOnly
        self.selectAllOnFocus = data.selectAllOnFocus or self.readOnly

        if data.maxChars then
            self.Input:SetMaxLetters(data.maxChars)
        else
            self.Input:SetMaxLetters(0)
        end

        if data.justifyH then
            self.Input:SetJustifyH(data.justifyH)
        else
            self.Input:SetJustifyH("LEFT")
        end

        if data.inputHeight then
            self.Input:SetHeight(data.inputHeight)
        end

        local value = data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
        if value == nil then
            value = data.default
        end
        self:SetValue(value)
        self:ApplyLayout()
        Util:ApplyTooltip(self, self.Input, data.tooltip)
    end

    function mixin:SetEnabled(enabled)
        if enabled then
            self.Input:Enable()
            self.Label:SetFontObject("GameFontHighlightMedium")
        else
            self.Input:Disable()
            self.Label:SetFontObject("GameFontDisable")
        end
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = DEFAULT_SLIDER_HEIGHT
        frame:SetHeight(DEFAULT_SLIDER_HEIGHT)
        Mixin(frame, mixin)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local input = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
        input:SetAutoFocus(false)
        input:SetHeight(20)
        input:SetJustifyH("LEFT")
        input:SetScript("OnEnterPressed", function(box)
            box:ClearFocus()
            frame:CommitInput()
        end)
        input:SetScript("OnEscapePressed", function(box)
            frame:SetValue(frame.currentValue)
            box:ClearFocus()
        end)
        input:SetScript("OnEditFocusLost", function()
            frame:CommitInput()
        end)
        input:SetScript("OnEditFocusGained", function()
            if frame.selectAllOnFocus then
                input:HighlightText()
            end
        end)
        input:SetScript("OnTextChanged", function(box, userInput)
            if frame._suppressInput then
                return
            end
            if frame.readOnly and userInput then
                frame._suppressInput = true
                box:SetText(formatInputValue(frame.setting, frame.currentValue))
                box:HighlightText()
                frame._suppressInput = nil
            end
        end)
        frame.Input = input

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function buildSlider()
    local mixin = {}

    function mixin:Setup(data, selection)
        self.setting = data
        self.Label:SetText(data.name)
        self.ignoreInLayout = nil
        self.initInProgress = true
        self.formatters = {}
        local sliderHeight = getFrameSliderHeight(selection and selection.parent)
        if sliderHeight then
            self.fixedHeight = sliderHeight
            self:SetHeight(sliderHeight)
        end
        local formatter = data.formatter
        if not formatter then
            local stepHint = tonumber(data.valueStep)
            if stepHint and stepHint >= 1 and stepHint == math.floor(stepHint) then
                formatter = function(value)
                    local n = tonumber(value) or 0
                    if n >= 0 then
                        n = math.floor(n + 0.5)
                    else
                        n = math.ceil(n - 0.5)
                    end
                    return tostring(n)
                end
            end
        end
        self.formatters[MinimalSliderWithSteppersMixin.Label.Right] = CreateMinimalSliderFormatter(MinimalSliderWithSteppersMixin.Label.Right, formatter)

        local minV = tonumber(data.minValue) or 0
        local maxV = tonumber(data.maxValue) or 1
        if maxV < minV then
            minV, maxV = maxV, minV
        end

        local stepSize = tonumber(data.valueStep) or 1
        if stepSize <= 0 then
            local span = maxV - minV
            stepSize = span > 0 and (span / 100) or 1
        end
        local steps = (maxV - minV) / stepSize
        if steps < 1 then
            steps = 1
        end

        local current = tonumber(data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())) or tonumber(data.default) or minV
        if current < minV then
            current = minV
        end
        if current > maxV then
            current = maxV
        end
        self.currentValue = current
        self.Slider:Init(current, minV, maxV, steps, self.formatters)

        if self.Input then
            if data.allowInput then
                self.Input:Show()
                self.Input:SetNumeric(false)
                local fmt = self.formatters and self.formatters[MinimalSliderWithSteppersMixin.Label.Right]
                self.Input:SetText(fmt and fmt(current) or tostring(current or ""))
                if self.Slider.RightText then
                    self.Slider.RightText:Hide()
                end
            else
                self.Input:Hide()
                if self.Slider.RightText then
                    self.Slider.RightText:Show()
                end
            end
        end

        self.initInProgress = false
        Util:ApplyTooltip(self, self, data.tooltip)
    end

    function mixin:OnSliderValueChanged(value)
        if not self.initInProgress then
            -- Avoid redundant setter calls on identical values (helps rapid slider drags).
            if value ~= self.currentValue then
                self.setting.set(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
                self.currentValue = value
                Internal:RequestRefreshSettings()
            end
            if self.Input and self.Input:IsShown() then
                local fmt = self.formatters and self.formatters[MinimalSliderWithSteppersMixin.Label.Right]
                self.Input:SetText(fmt and fmt(value) or tostring(value))
                if self.Slider.RightText and self.Slider.RightText:IsShown() then
                    self.Slider.RightText:Hide()
                end
            end
        end
    end

    function mixin:SetEnabled(enabled)
        self.Slider:SetEnabled(enabled)
        self.Label:SetFontObject(enabled and "GameFontHighlight" or "GameFontDisable")
        if self.Input then
            if enabled then
                self.Input:Enable()
            else
                self.Input:Disable()
            end
        end
    end

    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "EditModeSettingSliderTemplate")
        Mixin(frame, mixin)

        frame:SetHeight(DEFAULT_SLIDER_HEIGHT)
        frame.Slider:SetWidth(160)
        frame.Slider.MinText:Hide()
        frame.Slider.MaxText:Hide()
        frame.Label:SetPoint("LEFT")

        local input = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
        input:SetAutoFocus(false)
        input:SetSize(34, 20)
        input:SetJustifyH("CENTER")
        input:SetPoint("LEFT", frame.Slider, "RIGHT", 5, 0)
        input:Hide()
        frame.Input = input

        local function commitInput(box)
            if not box:IsEnabled() then
                return
            end
            local owner = box:GetParent()
            local data = owner.setting
            if not data then
                return
            end
            local minV = tonumber(data.minValue) or 0
            local maxV = tonumber(data.maxValue) or 1
            if maxV < minV then
                minV, maxV = maxV, minV
            end
            local step = tonumber(data.valueStep) or 0
            if step <= 0 then
                step = 0
            end
            local inputText = (box:GetText() or ""):gsub(",", ".")
            local val = tonumber(inputText)
            if not val then
                local fmt = owner.formatters and owner.formatters[MinimalSliderWithSteppersMixin.Label.Right]
                box:SetText(fmt and owner.currentValue and fmt(owner.currentValue) or tostring(owner.currentValue or ""))
                return
            end
            if val < minV then
                val = minV
            end
            if val > maxV then
                val = maxV
            end
            if step and step > 0 then
                val = minV + math.floor((val - minV) / step + 0.5) * step
                if val < minV then
                    val = minV
                end
                if val > maxV then
                    val = maxV
                end
            end
            local fmt = owner.formatters and owner.formatters[MinimalSliderWithSteppersMixin.Label.Right]
            owner.Input:SetText(fmt and fmt(val) or tostring(val))
            owner.currentValue = val
            owner.Slider:SetValue(val)
            owner.setting.set(lib.activeLayoutName, val, lib:GetActiveLayoutIndex())
            Internal:RequestRefreshSettings()
            box:ClearFocus()
        end

        input:SetScript("OnEnterPressed", commitInput)
        input:SetScript("OnEscapePressed", function(box)
            local owner = box:GetParent()
            local currentValue = owner and owner.currentValue
            if currentValue ~= nil then
                local fmt = owner and owner.formatters and owner.formatters[MinimalSliderWithSteppersMixin.Label.Right]
                box:SetText(fmt and fmt(currentValue) or tostring(currentValue))
            end
            box:ClearFocus()
        end)
        input:SetScript("OnEditFocusLost", function(box)
            if box:HasFocus() then
                return
            end
            if box:GetText() ~= "" then
                commitInput(box)
            end
        end)

        frame:OnLoad()
        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
    end
end

local function buildDivider()
    return function()
        local frame = CreateFrame("Frame", nil, UIParent)
        frame.fixedHeight = 16
        frame:SetSize(330, 16)
        local label = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        label:SetPoint("LEFT", 4, 0)
        label:SetJustifyH("LEFT")
        label:Hide()
        frame.Label = label

        local tex = frame:CreateTexture(nil, "ARTWORK")
        tex:SetAllPoints()
        tex:SetTexture([[Interface\FriendsFrame\UI-FriendsFrame-OnlineDivider]])
        frame.Divider = tex
        function frame:Setup(data, selection)
            self.setting = data
            self.Divider:ClearAllPoints()
            if data.name and data.name ~= "" then
                self.Label:SetText(data.name)
                self.Label:Show()
                self.Divider:SetPoint("LEFT", self.Label, "RIGHT", 8, 0)
                self.Divider:SetPoint("RIGHT", self, "RIGHT", 0, 0)
                self.Divider:SetHeight(16)
            else
                self.Label:Hide()
                self.Divider:SetAllPoints()
            end
            local height = getRowHeightOverride(selection and selection.parent, "divider")
            if height then
                self.fixedHeight = height
                self:SetHeight(height)
                if self.Divider then
                    self.Divider:SetHeight(height)
                end
            end
        end
        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.Label:Hide()
    end
end

local function buildHeader()
    return function()
        local frame = CreateFrame("Frame", nil, UIParent)
        frame.fixedHeight = 20
        frame:SetSize(330, 20)

        local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("LEFT", 6, 0)
        label:SetJustifyH("LEFT")
        label:SetTextColor(1, 0.82, 0, 1)
        frame.Label = label

        local line = frame:CreateTexture(nil, "ARTWORK")
        line:SetPoint("LEFT", label, "RIGHT", 8, 0)
        line:SetPoint("RIGHT", -6, 0)
        line:SetHeight(2)
        line:SetColorTexture(1, 1, 1, 1)
        line:SetGradient("HORIZONTAL", CreateColor(1, 0.82, 0, 0.55), CreateColor(1, 0.82, 0, 0))
        frame.Line = line

        function frame:Setup(data, selection)
            self.setting = data
            self.Label:SetText(data.name or "")
            applyRowHeightOverride(self, selection and selection.parent, "header")
        end

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.setting = nil
    end
end

local function buildSoundPicker()
    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 32
        frame:SetSize(330, 32)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local button = CreateFrame("Button", nil, frame, "UIMenuButtonStretchTemplate")
        button:SetPoint("LEFT", label, "RIGHT", 5, 0)
        button:SetSize(220, 26)
        frame.Button = button

        function frame:UpdateText()
            local data = self.setting
            if not data then
                return
            end
            local value = data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
            local text = data.getLabel and data.getLabel(value) or tostring(value or "None")
            self.Button:SetText(text)
        end

        function frame:Setup(data, selection)
            self.setting = data
            self.Label:SetText(data.name or "Sound")
            self.ignoreInLayout = nil
            applyRowHeightOverride(self, selection and selection.parent, "soundPicker")
            self:UpdateText()

            local pickerData = {
                options = data.options or data.values,
                getValue = function()
                    return data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
                end,
                setValue = function(value)
                    data.set(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
                end,
                getLabel = data.getLabel,
                preview = data.preview,
                previewTooltip = data.previewTooltip,
                previewOnSelect = data.previewOnSelect,
                onValueChanged = function()
                    self:UpdateText()
                    Internal:RequestRefreshSettings()
                end,
            }

            local function openPicker()
                ns.LibEQOL.SoundPickerMenu:Open(self.Button, pickerData)
            end
            Util:ApplyTooltip(self, self.Button, data.tooltip)
            self.Button:SetScript("OnClick", openPicker)
            self.Button:SetScript("OnEnter", openPicker)
            self.Button:SetScript("OnLeave", function()
                ns.LibEQOL.SoundPickerMenu:ScheduleClose()
            end)
        end

        function frame:SetEnabled(enabled)
            self.Button:SetEnabled(enabled)
            self.Label:SetFontObject(enabled and "GameFontHighlightMedium" or "GameFontDisable")
        end

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.setting = nil
        frame.Button:SetScript("OnClick", nil)
        frame.Button:SetScript("OnEnter", nil)
        frame.Button:SetScript("OnLeave", nil)
    end
end

local function buildFontPicker()
    return function()
        local frame = CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame")
        frame.fixedHeight = 32
        frame:SetSize(330, 32)

        local label = frame:CreateFontString(nil, nil, "GameFontHighlightMedium")
        label:SetPoint("LEFT")
        label:SetWidth(100)
        label:SetJustifyH("LEFT")
        frame.Label = label

        local button = CreateFrame("Button", nil, frame, "UIMenuButtonStretchTemplate")
        button:SetPoint("LEFT", label, "RIGHT", 5, 0)
        button:SetSize(220, 26)
        frame.Button = button

        function frame:UpdateText()
            local data = self.setting
            if not data then
                return
            end
            local value = data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
            local text = data.getLabel and data.getLabel(value) or tostring(value or "None")
            self.Button:SetText(text)
        end

        function frame:Setup(data, selection)
            self.setting = data
            self.Label:SetText(data.name or "Font")
            self.ignoreInLayout = nil
            applyRowHeightOverride(self, selection and selection.parent, "fontPicker")
            self:UpdateText()

            local pickerData = {
                options = data.options or data.values,
                getValue = function()
                    return data.get(lib.activeLayoutName, lib:GetActiveLayoutIndex())
                end,
                setValue = function(value)
                    data.set(lib.activeLayoutName, value, lib:GetActiveLayoutIndex())
                end,
                getLabel = data.getLabel,
                onValueChanged = function()
                    self:UpdateText()
                    Internal:RequestRefreshSettings()
                end,
            }

            local function openPicker()
                ns.LibEQOL.FontPickerMenu:Open(self.Button, pickerData)
            end
            Util:ApplyTooltip(self, self.Button, data.tooltip)
            self.Button:SetScript("OnClick", openPicker)
            self.Button:SetScript("OnEnter", openPicker)
            self.Button:SetScript("OnLeave", function()
                ns.LibEQOL.FontPickerMenu:ScheduleClose()
            end)
        end

        function frame:SetEnabled(enabled)
            self.Button:SetEnabled(enabled)
            self.Label:SetFontObject(enabled and "GameFontHighlightMedium" or "GameFontDisable")
        end

        return frame
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.setting = nil
        frame.Button:SetScript("OnClick", nil)
        frame.Button:SetScript("OnEnter", nil)
        frame.Button:SetScript("OnLeave", nil)
    end
end

local getDialogFrame

local function buildCollapsible()
    return function()
        local button = CreateFrame("Button", nil, UIParent, "UIMenuButtonStretchTemplate")
        button.fixedHeight = 24
        button:SetSize(330, 24)
        local hl = button:GetHighlightTexture()
        if hl then
            hl:SetAlpha(0)
        end

        local label = button:CreateFontString(nil, nil, "GameFontNormal")
        label:SetPoint("LEFT", 10, 0)
        label:SetJustifyH("LEFT")
        label:SetWidth(270)
        button.Label = label

        local collapseIcon = button:CreateTexture(nil, "ARTWORK")
        collapseIcon:SetSize(16, 16)
        collapseIcon:SetPoint("RIGHT", -6, 0)
        button.CollapseIcon = collapseIcon

        local function updateIcon(collapsed)
            if collapsed then
                button.CollapseIcon:SetTexture([[Interface\Buttons\UI-PlusButton-Up]])
            else
                button.CollapseIcon:SetTexture([[Interface\Buttons\UI-MinusButton-Up]])
            end
        end

        function button:Setup(data, selection)
            self.setting = data
            self.selection = selection
            self.Label:SetText(data.name or "")

            local selectionParent = selection and selection.parent
            applyRowHeightOverride(self, selectionParent, "collapsible")
            if not selectionParent and Internal.dialog then
                selectionParent = getDialogFrame(Internal.dialog)
            end
            local groupId = data.id or data.name
            if selectionParent then
                Collapse:Register(selectionParent, groupId)
            end

            local collapsed = not not data.defaultCollapsed
            local stored
            if selectionParent then
                stored = Collapse:Get(selectionParent, groupId)
            end
            if stored ~= nil then
                collapsed = not not stored
            end
            if data.getCollapsed then
                local ok, val = pcall(data.getCollapsed, lib.activeLayoutName, lib:GetActiveLayoutIndex())
                if ok and val ~= nil then
                    collapsed = not not val
                end
            end
            if selectionParent and stored == nil and data.defaultCollapsed ~= nil then
                Collapse:Set(selectionParent, groupId, collapsed)
            end

            self.collapsed = collapsed
            updateIcon(collapsed)

            self:SetScript("OnClick", function()
                local newState = not self.collapsed
                self.collapsed = newState
                updateIcon(newState)
                local touched = { data }
                if data.setCollapsed then
                    data.setCollapsed(lib.activeLayoutName, newState, lib:GetActiveLayoutIndex())
                elseif selectionParent then
                    Collapse:Set(selectionParent, data.id or data.name, newState)
                end
                if State.collapseExclusiveFlags[selectionParent] and newState == false then
                    local settings = Internal:GetFrameSettings(selectionParent)
                    if settings then
                        for _, other in ipairs(settings) do
                            if other ~= data and other.kind == lib.SettingType.Collapsible then
                                local otherId = other.id or other.name
                                if other.setCollapsed then
                                    other.setCollapsed(lib.activeLayoutName, true, lib:GetActiveLayoutIndex())
                                elseif selectionParent then
                                    Collapse:Set(selectionParent, otherId, true)
                                end
                                touched[#touched + 1] = other
                            end
                        end
                    end
                end
                Internal:RefreshSettings()
                Internal:RefreshSettingValues(touched)
            end)
        end

        function button:SetEnabled(enabled)
            if enabled then
                self:Enable()
                self.Label:SetFontObject("GameFontNormal")
            else
                self:Disable()
                self.Label:SetFontObject("GameFontDisable")
            end
        end

        return button
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.selection = nil
        frame.setting = nil
        frame.collapsed = nil
        frame:SetScript("OnClick", nil)
    end
end

local function buildButton()
    return function()
        return CreateFrame("Button", nil, UIParent, "EditModeSystemSettingsDialogExtraButtonTemplate")
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.fixedWidth = nil
        frame.ignoreInLayout = nil
    end
end

-- A settings row containing one or more evenly sized clickable buttons.
local BUTTON_ROW_SPACING = 8

local function layoutButtonRow(row)
    local defs = row.defs
    if not defs then
        return
    end
    local count = #defs
    local width = row:GetWidth() or 0
    if count == 0 or width <= 0 then
        return
    end
    local each = (width - BUTTON_ROW_SPACING * (count - 1)) / count
    local height = row:GetHeight() or row.fixedHeight or 26
    for index = 1, count do
        local button = row.buttons[index]
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", row, "TOPLEFT", (each + BUTTON_ROW_SPACING) * (index - 1), 0)
        button:SetSize(math.max(each, 1), height)
    end
end

local function buildSettingButton()
    return function()
        local row = CreateFrame("Frame", nil, UIParent)
        row.fixedHeight = 26
        row:SetSize(330, 26)
        row.buttons = {}
        row:SetScript("OnSizeChanged", layoutButtonRow)

        function row:Setup(data, selection)
            self.setting = data
            applyRowHeightOverride(self, selection and selection.parent, "button")
            local defs = data.buttons or { data }
            self.defs = defs
            for index, definition in ipairs(defs) do
                local button = self.buttons[index]
                if not button then
                    button = CreateFrame("Button", nil, self, "EditModeSystemSettingsDialogButtonTemplate")
                    self.buttons[index] = button
                end
                button:SetText(definition.name or definition.text or "")
                local onClick = definition.func or definition.click or definition.onClick
                local function run()
                    if onClick then
                        onClick(lib.activeLayoutName, lib:GetActiveLayoutIndex())
                    end
                end
                if button.SetOnClickHandler then
                    button:SetOnClickHandler(run)
                else
                    button:SetScript("OnClick", run)
                end
                Util:ApplyTooltip(button, button, definition.tooltip)
                button:Show()
            end
            for index = #defs + 1, #self.buttons do
                self.buttons[index]:Hide()
            end
            layoutButtonRow(self)
        end

        function row:SetEnabled(enabled)
            for _, button in ipairs(self.buttons) do
                if enabled then
                    button:Enable()
                else
                    button:Disable()
                end
            end
        end

        return row
    end, function(_, frame)
        frame:Hide()
        frame.layoutIndex = nil
        frame.ignoreInLayout = nil
        frame.setting = nil
        frame.defs = nil
    end
end

-- Slider pool is used by checkbox+color / dropdown+color etc
local builders = {
    [lib.SettingType.Checkbox] = buildCheckbox,
    [lib.SettingType.Dropdown] = buildDropdown,
    [lib.SettingType.MultiDropdown] = buildMultiDropdown,
    [lib.SettingType.Slider] = buildSlider,
    [lib.SettingType.Input] = buildInput,
    [lib.SettingType.Color] = buildColor,
    [lib.SettingType.CheckboxColor] = buildCheckboxColor,
    [lib.SettingType.DropdownColor] = buildDropdownColor,
    [lib.SettingType.Divider] = buildDivider,
    [lib.SettingType.Collapsible] = buildCollapsible,
    [lib.SettingType.Button] = buildSettingButton,
    [lib.SettingType.SoundPicker] = buildSoundPicker,
    [lib.SettingType.FontPicker] = buildFontPicker,
    [lib.SettingType.CompactFont] = buildCompactFont,
    [lib.SettingType.CompactSlider] = buildCompactFont,
    [lib.SettingType.Header] = buildHeader,
    button = buildButton,
}

for kind, maker in pairs(builders) do
    local creator, resetter = maker()
    Pools:Create(kind, creator, resetter)
end

-- Dialog ---------------------------------------------------------------------------
local Dialog = {}

local function saveDialogPosition(dialog)
    if not dialog then
        return
    end
    local point, _, relativePoint, x, y = dialog:GetPoint(1)
    if not point then
        return
    end
    Internal.dialogSavedPoint = {
        point = point,
        relativePoint = relativePoint or point,
        x = x or 0,
        y = y or 0,
    }
end

local function applyDialogPosition(dialog)
    if not dialog then
        return
    end
    dialog:ClearAllPoints()
    local pos = Internal.dialogSavedPoint
    if pos then
        dialog:SetPoint(pos.point, UIParent, pos.relativePoint or pos.point, pos.x or 0, pos.y or 0)
    else
        dialog:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -250, 250)
    end
end

local function setResetVisibility(buttonsFrame, visible)
    if not buttonsFrame then
        return
    end
    if visible then
        buttonsFrame.ignoreInLayout = nil
        buttonsFrame:Show()
    else
        buttonsFrame.ignoreInLayout = true
        buttonsFrame:Hide()
    end
end

function getDialogFrame(dialog)
    if not dialog then
        return nil
    end
    local context = dialog.context
    if type(context) == "table" and context.frame then
        return context.frame
    end
    return dialog.selection and dialog.selection.parent or nil
end

local function getDialogTitle(dialog)
    if not dialog then
        return ""
    end
    local context = dialog.context
    if type(context) == "table" and type(context.title) == "string" and context.title ~= "" then
        return context.title
    end
    local frame = getDialogFrame(dialog)
    if not frame then
        return ""
    end
    return frame.editModeName or (frame.GetName and frame:GetName()) or ""
end

local function getDialogSettings(dialog)
    if not dialog then
        return nil, 0
    end
    local context = dialog.context
    local settings = type(context) == "table" and context.settings or nil
    if type(settings) == "table" then
        return settings, #settings
    end
    local frame = getDialogFrame(dialog)
    if frame then
        return Internal:GetFrameSettings(frame)
    end
    return nil, 0
end

local function getDialogButtons(dialog)
    if not dialog then
        return nil, 0
    end
    local context = dialog.context
    local buttons = type(context) == "table" and context.buttons or nil
    if type(buttons) == "table" then
        return buttons, #buttons
    end
    local frame = getDialogFrame(dialog)
    if frame then
        return Internal:GetFrameButtons(frame)
    end
    return nil, 0
end

local function normalizeDialogButtonLayout(data)
    local layout = type(data) == "table" and tostring(data.layout or ""):lower() or ""
    if layout == "compact" or layout == "grid" or layout == "half" then
        return "compact"
    end
    return "full"
end

local function setDialogButtonContainerVisible(container, visible)
    if not container then
        return
    end
    if visible then
        container.ignoreInLayout = nil
        container:Show()
    else
        container.ignoreInLayout = true
        container:Hide()
    end
end

local function getDialogButtonAreaWidth(dialog)
    local width = dialog and dialog.Settings and dialog.Settings:GetWidth() or 0
    if not width or width < 1 then
        width = dialog and dialog.SettingsScroll and dialog.SettingsScroll:GetWidth() or 0
    end
    if not width or width < 1 then
        width = 330
    end
    return width
end

local function getDialogButtonsReservedHeight(dialog)
    local buttonsRoot = dialog and dialog.Buttons
    if not (buttonsRoot and buttonsRoot.IsShown and buttonsRoot:IsShown()) then
        return 0
    end

    if buttonsRoot.Layout then
        buttonsRoot:Layout()
    end

    local height = tonumber(buttonsRoot:GetHeight()) or 0
    if height <= 0 then
        return 0
    end

    local spacingFromSettings = 12
    return height + spacingFromSettings
end

local function applyDialogButtonWidths(dialog)
    if not (dialog and dialog.Buttons) then
        return
    end

    local width = getDialogButtonAreaWidth(dialog)
    local buttonsRoot = dialog.Buttons
    buttonsRoot:SetWidth(width)

    local primary = buttonsRoot.Primary or buttonsRoot
    local compact = buttonsRoot.Compact
    local reset = buttonsRoot.Reset

    if primary then
        primary:SetWidth(width)
        for _, child in ipairs({ primary:GetChildren() }) do
            if child and child.SetWidth then
                child.fixedWidth = width
                child:SetWidth(width)
            end
        end
        if primary.Layout then
            primary:Layout()
        end
    end

    if compact then
        compact:SetWidth(width)
        local columns = compact.stride or 2
        if columns < 1 then
            columns = 1
        end
        local spacing = tonumber(compact.childXPadding) or DEFAULT_SETTINGS_SPACING
        local totalSpacing = spacing * math.max(0, columns - 1)
        local columnWidth = math.floor((width - totalSpacing) / columns)
        if columnWidth < 1 then
            columnWidth = width
        end
        for _, child in ipairs({ compact:GetChildren() }) do
            if child and child.SetWidth then
                child.fixedWidth = columnWidth
                child:SetWidth(columnWidth)
            end
        end
        if compact.Layout then
            compact:Layout()
        end
    end

    if reset then
        reset:SetWidth(width)
        for _, child in ipairs({ reset:GetChildren() }) do
            if child and child.SetWidth then
                child.fixedWidth = width
                child:SetWidth(width)
            end
        end
        if reset.Layout then
            reset:Layout()
        end
    end

    if buttonsRoot.Layout then
        buttonsRoot:Layout()
    end
end

local function getDialogSettingsSpacing(dialog)
    local context = dialog and dialog.context
    if type(context) == "table" and context.settingsSpacing ~= nil then
        return normalizeSpacing(context.settingsSpacing, DEFAULT_SETTINGS_SPACING)
    end
    return getFrameSettingsSpacing(getDialogFrame(dialog))
end

local function getDialogSettingsMaxHeight(dialog)
    local context = dialog and dialog.context
    if type(context) == "table" then
        local override = context.settingsMaxHeight
        if override == nil then
            override = context.maxSettingsHeight
        end
        if override ~= nil then
            return normalizePositive(override, nil)
        end
    end
    return getFrameSettingsMaxHeight(getDialogFrame(dialog))
end

local function getDialogShowSettingsReset(dialog)
    local context = dialog and dialog.context
    if type(context) == "table" and context.showSettingsReset ~= nil then
        return context.showSettingsReset == true
    end
    local frame = getDialogFrame(dialog)
    local showSettingsReset = frame and State.settingsResetToggles[frame]
    if showSettingsReset == nil then
        showSettingsReset = true
    end
    return showSettingsReset == true
end

local function getDialogShowReset(dialog)
    local context = dialog and dialog.context
    if type(context) == "table" and context.showReset ~= nil then
        return context.showReset == true
    end
    local frame = getDialogFrame(dialog)
    if not frame then
        return false
    end
    if frame and State.resetToggles[frame] == false then
        return false
    end
    local defaultPosition = type(context) == "table" and context.defaultPosition or nil
    return defaultPosition ~= nil or lib:GetFrameDefaultPosition(frame) ~= nil
end

local function getDialogDefaultPosition(dialog)
    local context = dialog and dialog.context
    if type(context) == "table" and context.defaultPosition ~= nil then
        return context.defaultPosition
    end
    local frame = getDialogFrame(dialog)
    if not frame then
        return nil
    end
    return lib:GetFrameDefaultPosition(frame)
end

local function applyDialogPositionOverride(dialog)
    local context = dialog and dialog.context
    if type(context) ~= "table" then
        return false
    end
    local relativeTo = context.relativeTo or context.anchorTo
    local point = context.point or context.anchorPoint
    local relativePoint = context.relativePoint or context.anchorRelativePoint or point
    if not point then
        return false
    end
    dialog:ClearAllPoints()
    dialog:SetPoint(point, relativeTo or UIParent, relativePoint or point, context.x or context.offsetX or 0, context.y or context.offsetY or 0)
    return true
end

local function normalizeDialogContext(value)
    if not value then
        return nil
    end
    if value.parent then
        return {
            mode = "edit",
            frame = value.parent,
            selection = value,
        }
    end

    local context = {}
    for key, entry in pairs(value) do
        context[key] = entry
    end
    context.mode = context.mode or "standalone"
    context.frame = context.frame or (context.selection and context.selection.parent) or context.host
    if not context.frame then
        return nil
    end
    if not context.selection then
        context.selection = {
            parent = context.frame,
            standalone = context.mode ~= "edit",
            overlayHidden = false,
            labelHidden = false,
        }
    elseif not context.selection.parent then
        context.selection.parent = context.frame
    end
    if context.mode ~= "edit" then
        context.selection.standalone = true
    end
    return context
end

local function applyDialogDefaultPosition(frame, pos)
    if not (frame and pos) then
        return
    end
    local point = pos.point or "CENTER"
    local relativeTo = pos.relativeTo
    local relativePoint = pos.relativePoint or point
    local x = pos.x or 0
    local y = pos.y or 0
    frame:ClearAllPoints()
    if relativeTo ~= nil or pos.relativePoint ~= nil then
        frame:SetPoint(point, relativeTo or UIParent, relativePoint, x, y)
    else
        frame:SetPoint(point, x, y)
    end
end

function Dialog:ApplyLayoutOverrides()
    local selectionParent = getDialogFrame(self)
    if self.Settings then
        self.Settings.spacing = getDialogSettingsSpacing(self)
        if self.Settings.Divider then
            local height = getRowHeightOverride(selectionParent, "divider")
            if height then
                self.Settings.Divider:SetHeight(height)
            end
        end
    end
end

function Dialog:Update(selection)
    local context = normalizeDialogContext(selection)
    if not context then
        return
    end
    self.context = context
    self.mode = context.mode
    self.selection = context.selection
    local frame = getDialogFrame(self)
    self.Title:SetText(getDialogTitle(self))
    self:ApplyLayoutOverrides()
    local allowOverlayToggle = self.mode == "edit" and State.overlayToggleFlags[frame] == true
    if self.HideLabelButton then
        if allowOverlayToggle then
            self.HideLabelButton:Show()
            updateSelectionVisuals(self.selection, self.selection.overlayHidden)
            updateEyeButton(self.HideLabelButton, self.selection.overlayHidden)
        else
            self.HideLabelButton:Hide()
            if self.selection then
                self.selection.overlayHidden = false
            end
        end
    end
    self:UpdateSettings()
    self:UpdateButtons()
    FixScrollBarInside(self.SettingsScroll)
    UpdateScrollChildWidth(self)
    local appliedPositionOverride = applyDialogPositionOverride(self)
    if not self:IsShown() and not appliedPositionOverride then
        applyDialogPosition(self)
    end
    self:Show()
    self:Layout()
end

function Dialog:UpdateSettings()
    Pools:ReleaseAll()
    local settings, num = getDialogSettings(self)
    local layoutName = lib.activeLayoutName
    local layoutIndex = lib:GetActiveLayoutIndex()
    local collapsedById = {}
    if num > 0 then
        for _, data in next, settings do
            if data.kind == lib.SettingType.Collapsible then
                local selectionParent = getDialogFrame(self)
                local collapsed = Collapse:Get(selectionParent, data.id or data.name)
                if collapsed == nil and data.defaultCollapsed ~= nil then
                    collapsed = not not data.defaultCollapsed
                end
                if data.getCollapsed then
                    local ok, val = pcall(data.getCollapsed, layoutName, layoutIndex)
                    if ok and val ~= nil then
                        collapsed = not not val
                    end
                end
                collapsedById[data.id or data.name] = not not collapsed
            end
        end

        for index, data in next, settings do
            local pool = Pools:Get(data.kind)
            if pool then
                local setting = pool:Acquire(self.Settings)
                setting.layoutIndex = index
                ApplySettingsRowWidth(setting, self.Settings)
                setting:Setup(data, self.selection)
                local visible = evaluateVisibility(data, layoutName, layoutIndex)
                if data.parentId and collapsedById[data.parentId] then
                    visible = false
                end
                if setting.SetEnabled then
                    local enabled = true
                    if data.isEnabled then
                        local ok, result = pcall(data.isEnabled, layoutName, layoutIndex)
                        enabled = ok and result ~= false
                    elseif data.disabled then
                        local ok, result = pcall(data.disabled, layoutName, layoutIndex)
                        enabled = not (ok and result == true)
                    end
                    setting:SetEnabled(enabled)
                    setting._eqolEnabled = enabled
                end
                if visible then
                    setting.ignoreInLayout = nil
                    setting:Show()
                else
                    setting.ignoreInLayout = true
                    setting:Hide()
                end
            end
        end
    end

    self.Settings.ResetButton.layoutIndex = num + 1
    self.Settings.Divider.layoutIndex = num + 2
    local showSettingsReset = getDialogShowSettingsReset(self)
    self.Settings.ResetButton:SetEnabled(num > 0)
    self.Settings.ResetButton:SetShown(showSettingsReset == true)
    if self.Settings and self.Settings.Layout then
        self.Settings:Layout()
    end
end

function Dialog:UpdateButtons()
    local buttonPool = Pools:Get("button")
    if buttonPool then
        buttonPool:ReleaseAll()
    end
    local buttons, num = getDialogButtons(self)
    local buttonsRoot = self.Buttons
    local primaryContainer = buttonsRoot and (buttonsRoot.Primary or buttonsRoot) or nil
    local compactContainer = buttonsRoot and buttonsRoot.Compact or nil
    local resetContainer = buttonsRoot and buttonsRoot.Reset or primaryContainer
    local primaryIndex = 0
    local compactIndex = 0
    local resetVisible = false
    local anyVisible = false
    if num > 0 then
        for index, data in next, buttons do
            local layout = normalizeDialogButtonLayout(data)
            local targetContainer = primaryContainer
            if layout == "compact" and compactContainer then
                targetContainer = compactContainer
            end
            local button = buttonPool and targetContainer and buttonPool:Acquire(targetContainer)
            if not button then
                break
            end
            if targetContainer == compactContainer then
                compactIndex = compactIndex + 1
                button.layoutIndex = compactIndex
            else
                primaryIndex = primaryIndex + 1
                button.layoutIndex = primaryIndex
            end
            button:SetText(data.text)
            if button.SetOnClickHandler then
                button:SetOnClickHandler(data.click)
            else
                button:SetScript("OnClick", data.click)
            end
            button:Show()
            anyVisible = true
        end
    end

    local showReset = getDialogShowReset(self)
    if showReset and buttonPool and resetContainer then
        local resetPosition = buttonPool:Acquire(resetContainer)
        resetPosition.layoutIndex = 1
        resetPosition:SetText(HUD_EDIT_MODE_RESET_POSITION)
        resetPosition:SetOnClickHandler(GenerateClosure(self.ResetPosition, self))
        resetPosition:Show()
        resetVisible = true
        anyVisible = true
    end

    setDialogButtonContainerVisible(primaryContainer, primaryIndex > 0)
    setDialogButtonContainerVisible(compactContainer, compactIndex > 0)
    setDialogButtonContainerVisible(resetContainer, resetVisible)

    if anyVisible then
        setResetVisibility(self.Buttons, true)
        if self.Settings and self.Settings.Divider then
            self.Settings.Divider.ignoreInLayout = nil
            self.Settings.Divider:Show()
        end
    else
        setResetVisibility(self.Buttons, false)
        if self.Settings and self.Settings.Divider then
            self.Settings.Divider.ignoreInLayout = true
            self.Settings.Divider:Hide()
        end
    end

    applyDialogButtonWidths(self)
end

function Dialog:ResetSettings()
    local settings, num = getDialogSettings(self)
    if num > 0 then
        for _, data in next, settings do
            local handledDefault = false
            if data.kind == lib.SettingType.MultiDropdown and data.default ~= nil then
                local selection = Util:CopySelectionMap(Util:NormalizeSelection(data.default))
                if data.set then
                    data.set(lib.activeLayoutName, selection, lib:GetActiveLayoutIndex())
                elseif data.setSelected then
                    for _, option in ipairs(resolveOptions(data, lib.activeLayoutName)) do
                        if option.value ~= nil then
                            data.setSelected(lib.activeLayoutName, option.value, selection[option.value] and true or false, lib:GetActiveLayoutIndex())
                        end
                    end
                end
                handledDefault = true
            end
            if not handledDefault and data.default ~= nil and data.set then
                data.set(lib.activeLayoutName, data.default, lib:GetActiveLayoutIndex())
            end
            if data.kind == lib.SettingType.CheckboxColor then
                local apply = data.colorSet or data.setColor
                if apply and data.colorDefault ~= nil then
                    apply(lib.activeLayoutName, data.colorDefault or { 1, 1, 1, 1 }, lib:GetActiveLayoutIndex())
                end
            end
        end
        self:Update(self.selection)
    end
end

function Dialog:ResetPosition()
    local parent = getDialogFrame(self)
    if not parent then
        return
    end
    local pos = getDialogDefaultPosition(self) or { point = "CENTER", x = 0, y = 0 }
    applyDialogDefaultPosition(parent, pos)
    Internal:TriggerCallback(parent, pos.point or "CENTER", roundOffset(pos.x or 0), roundOffset(pos.y or 0))
end

function Internal.CreateDialog()
    local settingsScrollExtraHeight = 5
    local dialog = Mixin(CreateFrame("Frame", nil, UIParent, "ResizeLayoutFrame"), Dialog)
    dialog:SetSize(300, 350)
    dialog:SetFrameStrata("DIALOG")
    dialog:SetFrameLevel(200)
    dialog:Hide()
    dialog.widthPadding = 40
    dialog.heightPadding = 40 - settingsScrollExtraHeight

    dialog:EnableMouse(true)
    dialog:SetMovable(true)
    dialog:SetClampedToScreen(true)
    dialog:SetDontSavePosition(true)
    dialog:RegisterForDrag("LeftButton")
    dialog:SetScript("OnDragStart", function()
        dialog:StartMoving()
    end)
    dialog:SetScript("OnDragStop", function()
        dialog:StopMovingOrSizing()
        saveDialogPosition(dialog)
    end)

    local dialogTitle = dialog:CreateFontString(nil, nil, "GameFontHighlightLarge")
    dialogTitle:SetPoint("TOP", 0, -15)
    dialog.Title = dialogTitle

    local dialogBorder = CreateFrame("Frame", nil, dialog, "DialogBorderTranslucentTemplate")
    dialogBorder.ignoreInLayout = true
    dialog.Border = dialogBorder

    local dialogClose = CreateFrame("Button", nil, dialog, "UIPanelCloseButton")
    dialogClose:SetPoint("TOPRIGHT")
    dialogClose.ignoreInLayout = true
    dialog.Close = dialogClose

    local hideLabelButton = CreateFrame("Button", nil, dialog)
    hideLabelButton:SetSize(32, 32)
    hideLabelButton:SetPoint("RIGHT", dialogClose, "LEFT", -4, 0)
    hideLabelButton:SetNormalTexture(LFG_EYE_TEXTURE)
    local dialogEyeTex = hideLabelButton:GetNormalTexture()
    if dialogEyeTex then
        setEyeFrame(dialogEyeTex, LFG_EYE_FRAME_OPEN)
    end
    hideLabelButton:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
    if hideLabelButton:GetHighlightTexture() then
        hideLabelButton:GetHighlightTexture():SetAlpha(0)
    end
    hideLabelButton:SetScript("OnClick", function()
        local selection = dialog.selection
        if not selection then
            return
        end
        if State.overlayToggleFlags[selection.parent] == false then
            return
        end
        local hidden = not selection.overlayHidden
        updateSelectionVisuals(selection, hidden)
        updateEyeButton(hideLabelButton, hidden)
        dialog:Layout()
    end)
    hideLabelButton:SetScript("OnEnter", function()
        if not GameTooltip then
            return
        end
        GameTooltip:SetOwner(hideLabelButton, "ANCHOR_RIGHT")
        local state = dialog.selection and dialog.selection.overlayHidden and _G.HUD_EDIT_MODE_SHOW or _G.HUD_EDIT_MODE_HIDE
        GameTooltip:SetText((state or "Toggle") .. " highlight")
        GameTooltip:Show()
    end)
    hideLabelButton:SetScript("OnLeave", GameTooltip_Hide)
    dialog.HideLabelButton = hideLabelButton

    -- Settings Scroll Container
    local dialogSettingsScroll = CreateFrame("ScrollFrame", nil, dialog, "UIPanelScrollFrameTemplate")
    dialogSettingsScroll:SetPoint("TOP", dialogTitle, "BOTTOM", 0, -12)
    dialogSettingsScroll:SetWidth(330)
    dialogSettingsScroll:SetHeight(1)
    dialogSettingsScroll:EnableMouseWheel(true)
    dialogSettingsScroll:SetScript("OnMouseWheel", function(self, delta)
        local step = 30
        local cur = self:GetVerticalScroll()
        local max = self:GetVerticalScrollRange()
        if delta > 0 then
            self:SetVerticalScroll(math.max(cur - step, 0))
        else
            self:SetVerticalScroll(math.min(cur + step, max))
        end
    end)
    FixScrollBarInside(dialogSettingsScroll)

    local dialogSettings = CreateFrame("Frame", nil, dialogSettingsScroll, "VerticalLayoutFrame")
    dialogSettings:SetWidth(330)
    dialogSettings.spacing = DEFAULT_SETTINGS_SPACING
    dialogSettingsScroll:SetScrollChild(dialogSettings)

    dialog.SettingsScroll = dialogSettingsScroll
    dialog.Settings = dialogSettings

    function dialog:ApplySettingsScrollLimit()
        local scroll = self.SettingsScroll
        local settings = self.Settings
        if not (scroll and settings) then
            return
        end
        FixScrollBarInside(scroll)

        local maxHeight = getDialogSettingsMaxHeight(self)

        applyDialogButtonWidths(self)
        if settings.Layout then
            settings:Layout()
        end

        local contentHeight = settings:GetHeight() or 1
        local targetHeight = contentHeight + settingsScrollExtraHeight
        local needsScroll = false
        local reservedBottomHeight = getDialogButtonsReservedHeight(self)

        if maxHeight then
            maxHeight = maxHeight - reservedBottomHeight + settingsScrollExtraHeight
            if maxHeight < 1 then
                maxHeight = 1
            end
        end

        if maxHeight and contentHeight > maxHeight then
            targetHeight = maxHeight
            needsScroll = true
        elseif maxHeight and targetHeight > maxHeight then
            targetHeight = maxHeight
        end
        if targetHeight < 1 then
            targetHeight = 1
        end

        targetHeight = targetHeight + 15 -- fix for scroll frame always scrolling
        if scroll._eqolLastHeight ~= targetHeight then
            scroll._eqolLastHeight = targetHeight
            scroll:SetHeight(targetHeight)
            scroll.fixedHeight = targetHeight
        end

        if scroll.ScrollBar and scroll.ScrollBar.SetShown then
            scroll.ScrollBar:SetShown(needsScroll)
        end

        if scroll.UpdateScrollChildRect then
            scroll:UpdateScrollChildRect()
        end

        UpdateScrollChildWidth(self)

        if not needsScroll then
            scroll:SetVerticalScroll(0)
        else
            local maxScroll = scroll:GetVerticalScrollRange()
            scroll:SetVerticalScroll(math.min(scroll:GetVerticalScroll(), maxScroll))
        end
    end

    local resetSettingsButton = CreateFrame("Button", nil, dialogSettings, "EditModeSystemSettingsDialogButtonTemplate")
    resetSettingsButton:SetText(RESET_TO_DEFAULT)
    resetSettingsButton:SetOnClickHandler(GenerateClosure(dialog.ResetSettings, dialog))
    dialogSettings.ResetButton = resetSettingsButton

    local divider = dialogSettings:CreateTexture(nil, "ARTWORK")
    divider:SetSize(330, 16)
    divider:SetTexture([[Interface\FriendsFrame\UI-FriendsFrame-OnlineDivider]])
    dialogSettings.Divider = divider

    local dialogButtons = CreateFrame("Frame", nil, dialog, "VerticalLayoutFrame")
    dialogButtons:SetPoint("TOP", dialogSettingsScroll, "BOTTOM", 0, -12)
    dialogButtons:SetWidth(330)
    dialogButtons.spacing = DEFAULT_SETTINGS_SPACING

    local primaryButtons = CreateFrame("Frame", nil, dialogButtons, "VerticalLayoutFrame")
    primaryButtons.layoutIndex = 1
    primaryButtons.spacing = DEFAULT_SETTINGS_SPACING
    primaryButtons:SetWidth(330)
    primaryButtons.ignoreInLayout = true
    primaryButtons:Hide()
    dialogButtons.Primary = primaryButtons

    local compactButtons = CreateFrame("Frame", nil, dialogButtons, "GridLayoutFrame")
    compactButtons.layoutIndex = 2
    compactButtons:SetWidth(330)
    compactButtons.childXPadding = DEFAULT_SETTINGS_SPACING
    compactButtons.childYPadding = DEFAULT_SETTINGS_SPACING
    compactButtons.isHorizontal = true
    compactButtons.stride = 2
    compactButtons.layoutFramesGoingRight = true
    compactButtons.layoutFramesGoingUp = false
    compactButtons.alwaysUpdateLayout = true
    compactButtons.ignoreInLayout = true
    compactButtons:Hide()
    dialogButtons.Compact = compactButtons

    local resetButtons = CreateFrame("Frame", nil, dialogButtons, "VerticalLayoutFrame")
    resetButtons.layoutIndex = 3
    resetButtons.spacing = DEFAULT_SETTINGS_SPACING
    resetButtons:SetWidth(330)
    resetButtons.ignoreInLayout = true
    resetButtons:Hide()
    dialogButtons.Reset = resetButtons

    dialog.Buttons = dialogButtons

    if not dialog._eqolOriginalLayout then
        dialog._eqolOriginalLayout = dialog.Layout
        dialog.Layout = function(self, ...)
            self:ApplySettingsScrollLimit()
            applyDialogButtonWidths(self)
            return self:_eqolOriginalLayout(...)
        end
    end

    dialog:HookScript("OnHide", function(self)
        if self.mode == "standalone" or self.mode == "attached" then
            local context = self.context
            self.context = nil
            self.mode = nil
            self.selection = nil
            if context and type(context.onHide) == "function" then
                securecallfunction(context.onHide, self, context.frame)
            end
        end
    end)

    return dialog
end

-- Selection and movement -----------------------------------------------------------
local Selection = {}

local function setPropagateKeyboardInputSafe(frame, propagate)
    if not frame or not frame.SetPropagateKeyboardInput or isInCombat() or not lib.isEditing then
        return
    end
    frame:SetPropagateKeyboardInput(not not propagate)
end

local function updateSelectionKeyboard(selection)
    if not selection or not selection.EnableKeyboard then
        return
    end
    local allow = lib.isEditing and not isInCombat()
    selection:EnableKeyboard(allow)
    if allow then
        setPropagateKeyboardInputSafe(selection, true)
    end
end

local function deriveAnchorAndOffset(frame)
    -- Finds the nearest anchor on each axis (left/right/center, top/bottom/center) and
    -- returns a Blizzard anchor string plus offsets relative to the parent.
    local parent = frame:GetParent()
    if not parent then
        return
    end

    local scale = frame:GetScale()
    if not scale then
        return
    end

    local left = frame:GetLeft() * scale
    local right = frame:GetRight() * scale
    local top = frame:GetTop() * scale
    local bottom = frame:GetBottom() * scale
    local parentWidth, parentHeight = parent:GetSize()

    -- Distance helpers
    local cx = (left + right) * 0.5 - parentWidth * 0.5
    local cy = (bottom + top) * 0.5 - parentHeight * 0.5
    local dx = { label = "LEFT", dist = left, offset = left }
    local cxEntry = { label = "", dist = math.abs(cx), offset = cx }
    local rx = { label = "RIGHT", dist = parentWidth - right, offset = right - parentWidth }

    local dy = { label = "BOTTOM", dist = bottom, offset = bottom }
    local cyEntry = { label = "", dist = math.abs(cy), offset = cy }
    local ty = { label = "TOP", dist = parentHeight - top, offset = top - parentHeight }

    local function pickAxis(neg, center, pos)
        local candidate = neg
        if pos.dist < candidate.dist then
            candidate = pos
        end
        if center.dist <= candidate.dist then
            candidate = center
        end
        return candidate.label, candidate.offset
    end

    local xLabel, xOffset = pickAxis(dx, cxEntry, rx)
    local yLabel, yOffset = pickAxis(dy, cyEntry, ty)

    local point = (yLabel ~= "" and yLabel or "") .. (xLabel ~= "" and xLabel or "")
    if point == "" then
        point = "CENTER"
    end

    return point, xOffset / scale, yOffset / scale
end

local function adjustPosition(frame, dx, dy)
    local scale = frame:GetScale() or 1
    local point, relativeTo, relativePoint, x, y = frame:GetPoint(1)
    if not point then
        point, relativePoint, x, y = "CENTER", "CENTER", 0, 0
    end
    x = (x or 0) + dx / scale
    y = (y or 0) + dy / scale
    frame:ClearAllPoints()
    frame:SetPoint(point, relativeTo or UIParent, relativePoint or point, x, y)
    Internal:TriggerCallback(frame, point, roundOffset(x), roundOffset(y))
end

local function resetSelectionIndicators(force)
    if not force and not lib.isEditing then
        return
    end
    if Internal.dialog then
        Internal.dialog:Hide()
    end
    for frame, selection in next, State.selectionRegistry do
        local selectionEnabled = isSelectionEnabled(frame)
        if selection.isSelected or not selectionEnabled then
            frame:SetMovable(false)
        end
        local keepHidden = selection.overlayHidden
        if not lib.isEditing then
            keepHidden = false
        end
        updateSelectionVisuals(selection, keepHidden)
        if not lib.isEditing or not selectionEnabled then
            selection:Hide()
            selection.isSelected = false
        else
            selection:ShowHighlighted()
        end
        updateSelectionKeyboard(selection)
    end
    if Internal.dialog and Internal.dialog.HideLabelButton then
        updateEyeButton(Internal.dialog.HideLabelButton, false)
    end
end

local function hideOverlapMenu()
    if Internal.overlapMenu then
        Internal.overlapMenu:Hide()
    end
end

local function beginSelectionDrag(self)
    if isInCombat() then
        return
    end
    hideOverlapMenu()
    if not isDragAllowed(self.parent) then
        return
    end
    self.parent:StartMoving()
end

local function finishSelectionDrag(self)
    local parent = self.parent
    parent:StopMovingOrSizing()
    if isInCombat() then
        return
    end
    if not isDragAllowed(parent) then
        return
    end
    local point, x, y = deriveAnchorAndOffset(parent)
    if not point then
        return
    end
    parent:ClearAllPoints()
    parent:SetPoint(point, x, y)
    Internal:TriggerCallback(parent, point, roundOffset(x), roundOffset(y))
end

-- Overlap chooser ---------------------------------------------------------------
local function getCursorPositionUI()
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale() or 1
    return x / scale, y / scale
end

local function getSelectionLabel(selection)
    if not selection then
        return "Frame"
    end
    if selection.systemBaseName and selection.systemBaseName ~= "" then
        return selection.systemBaseName
    end
    if selection.Label and selection.Label.GetText then
        local txt = selection.Label:GetText()
        if txt and txt ~= "" then
            return txt
        end
    end
    local parent = selection.parent
    if parent then
        return parent.editModeName or parent:GetName() or "Frame"
    end
    return "Frame"
end

local function selectionContainsCursor(selection, cx, cy)
    if not selection or not selection:IsVisible() then
        return false
    end
    local frame = selection.parent or selection
    if not (frame and frame:IsVisible()) then
        return false
    end
    local left, right, top, bottom = frame:GetLeft(), frame:GetRight(), frame:GetTop(), frame:GetBottom()
    if not left or not right or not top or not bottom then
        return false
    end
    return cx >= left and cx <= right and cy >= bottom and cy <= top
end

local function collectOverlappingSelections(cx, cy)
    local hits = {}
    for _, selection in pairs(State.selectionRegistry) do
        if selectionContainsCursor(selection, cx, cy) then
            table.insert(hits, selection)
        end
    end
    return hits
end

local function ensureOverlapMenu()
    if Internal.overlapMenu then
        return Internal.overlapMenu
    end
    local menu = CreateFrame("Frame", nil, UIParent, "TooltipBackdropTemplate")
    menu:SetFrameStrata("TOOLTIP")
    menu:EnableMouse(true)
    menu:SetPropagateMouseClicks(true)
    menu.buttons = {}
    menu.buttonHeight = 22
    menu.buttonSpacing = 4
    menu:SetScript("OnHide", function(self)
        for _, btn in ipairs(self.buttons) do
            btn:Hide()
            btn.selection = nil
        end
    end)
    Internal.overlapMenu = menu
    return menu
end

local function selectSelection(selection)
    if isInCombat() or not selection then
        return
    end
    resetSelectionIndicators()
    if EditModeManagerFrame and EditModeManagerFrame.ClearSelectedSystem then
        EditModeManagerFrame:ClearSelectedSystem()
    end
    if not selection.isSelected then
        selection.parent:SetMovable(true)
        selection:ShowSelected(true)
        selection.isSelected = true
        if Internal.dialog then
            Internal.dialog:Update(selection)
        end
    end
end

local function showOverlapMenu(hits, cursorX, cursorY, primary)
    if #hits <= 1 then
        hideOverlapMenu()
        return
    end
    local menu = ensureOverlapMenu()
    local buttons = menu.buttons
    local maxWidth = 0
    local yOffset = -8
    table.sort(hits, function(a, b)
        if a == primary then
            return true
        end
        if b == primary then
            return false
        end
        return getSelectionLabel(a) < getSelectionLabel(b)
    end)
    for index, selection in ipairs(hits) do
        local btn = buttons[index]
        if not btn then
            btn = CreateFrame("Button", nil, menu, "UIPanelButtonTemplate")
            buttons[index] = btn
        end
        local label = getSelectionLabel(selection)
        btn.selection = selection
        btn:SetText(label)
        btn:SetWidth(math.max(140, btn:GetTextWidth() + 24))
        btn:SetHeight(menu.buttonHeight)
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", 8, yOffset)
        yOffset = yOffset - (menu.buttonHeight + menu.buttonSpacing)
        btn:SetScript("OnClick", function()
            hideOverlapMenu()
            selectSelection(selection)
        end)
        btn:Show()
        if btn:GetWidth() > maxWidth then
            maxWidth = btn:GetWidth()
        end
    end
    for i = #hits + 1, #buttons do
        buttons[i]:Hide()
        buttons[i].selection = nil
    end
    local totalHeight = 16 + #hits * menu.buttonHeight + (#hits - 1) * menu.buttonSpacing
    menu:SetSize(maxWidth + 16, totalHeight)
    menu:ClearAllPoints()
    menu:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", cursorX, cursorY)
    menu:Show()
end

local function handleSelectionMouseDown(self)
    if isInCombat() or not isSelectionEnabled(self.parent) then
        return
    end
    hideOverlapMenu()
    local cx, cy = getCursorPositionUI()
    local hits = collectOverlappingSelections(cx, cy)
    if #hits <= 1 and self.isSelected then
        return
    end
    if #hits > 1 then
        selectSelection(self)
        showOverlapMenu(hits, cx, cy, self)
        return
    end
    selectSelection(self)
end

local function MouseIsOverCompat(region, topOffset, bottomOffset, leftOffset, rightOffset)
    if not region then
        return false
    end
    if _G.MouseIsOver then
        return _G.MouseIsOver(region, topOffset, bottomOffset, leftOffset, rightOffset)
    end
    if region.IsMouseOver then
        return region:IsMouseOver(topOffset, bottomOffset, leftOffset, rightOffset)
    end
    return false
end

-- hide overlap menu when clicking elsewhere (non-blocking)
local function overlapGlobalMouseDown()
    local menu = Internal.overlapMenu
    if not (lib.isEditing and menu and menu:IsShown()) then
        return
    end
    if MouseIsOverCompat(menu, 4, 4, 4, 4) then
        return
    end
    local focus = GetMouseFoci and GetMouseFoci() or GetMouseFocus()
    if focus and (focus == menu or (focus.IsDescendantOf and focus:IsDescendantOf(menu))) then
        return
    end
    hideOverlapMenu()
end

local overlapGlobalFrame = CreateFrame("Frame")
overlapGlobalFrame:RegisterEvent("GLOBAL_MOUSE_DOWN")
overlapGlobalFrame:SetScript("OnEvent", overlapGlobalMouseDown)

local function onEditModeEnter()
    -- GetLayouts is allocation-heavy; only refresh when cache is missing.
    if not lib.activeLayoutIndex or not State.layoutSnapshot then
        updateActiveLayoutFromAPI()
    end
    lib.isEditing = true
    resetSelectionIndicators()
    refreshManagerTogglePanel()
    for _, callback in next, lib.eventHandlersEnter do
        securecallfunction(callback)
    end
end

local function onEditModeExit()
    lib.isEditing = false
    resetSelectionIndicators(true)
    hideOverlapMenu()
    for _, callback in next, lib.eventHandlersExit do
        securecallfunction(callback)
    end
end

-- API callbacks --------------------------------------------------------------------
lib.eventHandlersEnter = lib.eventHandlersEnter or {}
lib.eventHandlersExit = lib.eventHandlersExit or {}
lib.eventHandlersLayout = lib.eventHandlersLayout or {}
lib.eventHandlersLayoutAdded = lib.eventHandlersLayoutAdded or {}
lib.eventHandlersLayoutDeleted = lib.eventHandlersLayoutDeleted or {}
lib.eventHandlersLayoutRenamed = lib.eventHandlersLayoutRenamed or {}
lib.eventHandlersSpec = lib.eventHandlersSpec or {}
lib.eventHandlersLayoutDuplicate = lib.eventHandlersLayoutDuplicate or {}

function Internal:EnsureDialog()
    if not self.dialog then
        self.dialog = self.CreateDialog()
        self.dialog:HookScript("OnHide", function()
            resetSelectionIndicators()
        end)
        applyDialogPosition(self.dialog)
    end

    if not self._dialogInfrastructureReady then
        self._dialogInfrastructureReady = true

        local combatWatcher = CreateFrame("Frame")
        combatWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
        combatWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
        combatWatcher:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
        combatWatcher:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
        combatWatcher:SetScript("OnEvent", function(_, event, ...)
            if event == "PLAYER_REGEN_DISABLED" then
                Internal.combatLockdown = true
                resetSelectionIndicators()
            elseif event == "PLAYER_REGEN_ENABLED" and lib.isEditing then
                Internal.combatLockdown = false
                resetSelectionIndicators()
            elseif event == "PLAYER_REGEN_ENABLED" then
                Internal.combatLockdown = false
            elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
                Layout:HandleSpecChanged()
            elseif event == "EDIT_MODE_LAYOUTS_UPDATED" then
                local layoutInfo = ...
                Layout:HandleLayoutsChanged(nil, layoutInfo)
            end
        end)
        self.combatWatcher = combatWatcher

        hooksecurefunc(EditModeManagerFrame, "SaveLayouts", function()
            if C_EditMode and C_EditMode.GetLayouts then
                Layout:HandleLayoutsChanged(nil, C_EditMode.GetLayouts())
            end
        end)

        if EditModeManagerFrame then
            hooksecurefunc(EditModeManagerFrame, "Show", onEditModeEnter)
            hooksecurefunc(EditModeManagerFrame, "Hide", onEditModeExit)
            hooksecurefunc(EditModeManagerFrame, "SelectSystem", function()
                resetSelectionIndicators()
            end)
        end

        if C_EditMode then
            if C_EditMode.OnLayoutDeleted then
                hooksecurefunc(C_EditMode, "OnLayoutDeleted", function(deletedLayoutIndex)
                    Layout:HandleLayoutDeleted(deletedLayoutIndex)
                end)
            end
            if C_EditMode.OnLayoutAdded then
                hooksecurefunc(C_EditMode, "OnLayoutAdded", function(addedLayoutIndex, activateNewLayout, isLayoutImported)
                    Layout:HandleLayoutAdded(addedLayoutIndex, activateNewLayout, isLayoutImported)
                end)
            end
        end
    end

    return self.dialog
end

-- API ------------------------------------------------------------------------------
function lib:AddFrame(frame, callback, default)
    local selection = CreateFrame("Frame", nil, frame, "EditModeSystemSelectionTemplate")
    selection:SetAllPoints()
    selection:SetScript("OnMouseDown", handleSelectionMouseDown)
    selection:SetScript("OnDragStart", beginSelectionDrag)
    selection:SetScript("OnDragStop", finishSelectionDrag)
    selection:SetScript("OnKeyDown", function(selectionFrame, key)
        if not selectionFrame.isSelected or isInCombat() then
            return
        end
        if not isDragAllowed(frame) then
            return
        end
        local step = IsShiftKeyDown() and 10 or 1
        if key == "UP" then
            setPropagateKeyboardInputSafe(selectionFrame, false)
            adjustPosition(frame, 0, step)
        elseif key == "DOWN" then
            setPropagateKeyboardInputSafe(selectionFrame, false)
            adjustPosition(frame, 0, -step)
        elseif key == "LEFT" then
            setPropagateKeyboardInputSafe(selectionFrame, false)
            adjustPosition(frame, -step, 0)
        elseif key == "RIGHT" then
            setPropagateKeyboardInputSafe(selectionFrame, false)
            adjustPosition(frame, step, 0)
        else
            setPropagateKeyboardInputSafe(selectionFrame, true)
        end
    end)
    selection:SetScript("OnKeyUp", function(selectionFrame)
        setPropagateKeyboardInputSafe(selectionFrame, true)
    end)
    updateSelectionKeyboard(selection)
    selection:Hide()

    selection.labelHidden = false
    selection.overlayHidden = false
    if default then
        local toggle = default.enableOverlayToggle
            or default.overlayToggleEnabled
            or (default.enableOverlayToggle == false and false)
            or (default.overlayToggleEnabled == false and false)
        if toggle ~= nil then
            State.overlayToggleFlags[frame] = not not toggle
        end
        if default.allowDrag ~= nil or default.dragEnabled ~= nil then
            State.dragPredicates[frame] = (default.allowDrag ~= nil) and default.allowDrag or default.dragEnabled
        end
        if default.editModeEnabled ~= nil or default.selectionEnabled ~= nil then
            State.selectionPredicates[frame] = (default.editModeEnabled ~= nil) and default.editModeEnabled or default.selectionEnabled
        end
    end
    if select(4, GetBuildInfo()) >= 110200 then
        selection.systemBaseName = frame.editModeName or frame:GetName()
        selection.system = {}
        selection.system.GetSystemName = function()
            if selection.labelHidden then
                return ""
            end
            return selection.systemBaseName
        end
    else
        selection.Label:SetText(frame.editModeName or frame:GetName())
    end

    State.selectionRegistry[frame] = selection
    State.frameHandlers[frame] = callback
    State.defaultPositions[frame] = default
    if default then
        local toggle = default.enableOverlayToggle
            or default.overlayToggleEnabled
            or (default.enableOverlayToggle == false and false)
            or (default.overlayToggleEnabled == false and false)
        if toggle ~= nil then
            State.overlayToggleFlags[frame] = not not toggle
        end
        if default.allowDrag ~= nil or default.dragEnabled ~= nil then
            State.dragPredicates[frame] = (default.allowDrag ~= nil) and default.allowDrag or default.dragEnabled
        end
        if default.collapseExclusive ~= nil or default.exclusiveCollapse ~= nil then
            State.collapseExclusiveFlags[frame] = (default.collapseExclusive ~= nil) and default.collapseExclusive or default.exclusiveCollapse
        end
        if default.showReset ~= nil then
            State.resetToggles[frame] = not not default.showReset
        end
        if default.showSettingsReset ~= nil then
            State.settingsResetToggles[frame] = not not default.showSettingsReset
        end
        if default.settingsSpacing ~= nil then
            State.settingsSpacingOverrides[frame] = normalizeSpacing(default.settingsSpacing, DEFAULT_SETTINGS_SPACING)
        end
        if default.settingsMaxHeight ~= nil or default.maxSettingsHeight ~= nil then
            local v = default.settingsMaxHeight ~= nil and default.settingsMaxHeight or default.maxSettingsHeight
            State.settingsMaxHeightOverrides[frame] = normalizePositive(v, nil)
        end
        if default.sliderHeight ~= nil then
            State.sliderHeightOverrides[frame] = normalizePositive(default.sliderHeight, DEFAULT_SLIDER_HEIGHT)
            setRowHeightOverride(frame, "slider", default.sliderHeight)
        end
        if default.checkboxHeight ~= nil then
            setRowHeightOverride(frame, "checkbox", default.checkboxHeight)
        end
        if default.dropdownHeight ~= nil then
            setRowHeightOverride(frame, "dropdown", default.dropdownHeight)
        end
        if default.multiDropdownHeight ~= nil then
            setRowHeightOverride(frame, "multiDropdown", default.multiDropdownHeight)
        end
        if default.multiDropdownSummaryHeight ~= nil then
            setRowHeightOverride(frame, "multiDropdownSummary", default.multiDropdownSummaryHeight)
        end
        if default.colorHeight ~= nil then
            setRowHeightOverride(frame, "color", default.colorHeight)
        end
        if default.checkboxColorHeight ~= nil then
            setRowHeightOverride(frame, "checkboxColor", default.checkboxColorHeight)
        end
        if default.dropdownColorHeight ~= nil then
            setRowHeightOverride(frame, "dropdownColor", default.dropdownColorHeight)
        end
        if default.inputHeight ~= nil then
            setRowHeightOverride(frame, "input", default.inputHeight)
        end
        if default.dividerHeight ~= nil then
            setRowHeightOverride(frame, "divider", default.dividerHeight)
        end
        if default.collapsibleHeight ~= nil then
            setRowHeightOverride(frame, "collapsible", default.collapsibleHeight)
        end
    end

    Internal:EnsureDialog()
end

function lib:AddFrameSettings(frame, settings)
    if not State.selectionRegistry[frame] then
        error("frame must be registered")
    end
    State.settingSheets[frame] = settings
end

function lib:AddFrameSettingsButton(frame, data)
    if not State.buttonSpecs[frame] then
        State.buttonSpecs[frame] = {}
    end
    table.insert(State.buttonSpecs[frame], data)
end

function lib:ShowStandaloneSettingsDialog(frame, options)
    assert(frame, "frame is required")
    assert(options == nil or type(options) == "table", "options must be a table")
    if lib.isEditing then
        return nil, "standalone settings are unavailable while edit mode is active"
    end

    options = options or {}
    local context = normalizeDialogContext({
        mode = "standalone",
        frame = frame,
        title = options.title,
        settings = options.settings,
        buttons = options.buttons,
        defaultPosition = options.defaultPosition,
        showReset = options.showReset,
        showSettingsReset = options.showSettingsReset,
        settingsSpacing = options.settingsSpacing,
        settingsMaxHeight = options.settingsMaxHeight or options.maxSettingsHeight,
        point = options.point or options.anchorPoint,
        relativePoint = options.relativePoint or options.anchorRelativePoint,
        relativeTo = options.relativeTo or options.anchorTo,
        x = options.x or options.offsetX,
        y = options.y or options.offsetY,
        onHide = options.onHide,
    })

    local hasSettings = (type(context.settings) == "table" and #context.settings > 0) or State.settingSheets[frame] ~= nil
    local hasButtons = (type(context.buttons) == "table" and #context.buttons > 0) or State.buttonSpecs[frame] ~= nil
    local hasReset = options.showReset == true
    if options.showReset ~= false and not hasReset then
        hasReset = options.defaultPosition ~= nil or lib:GetFrameDefaultPosition(frame) ~= nil
    end
    if not hasSettings and not hasButtons and not hasReset then
        return nil, "no settings, buttons, or reset position were provided for this frame"
    end

    local dialog = Internal:EnsureDialog()
    dialog:Update(context)
    return dialog
end

function lib:HideStandaloneSettingsDialog(frame)
    local dialog = Internal.dialog
    if not (dialog and dialog:IsShown() and dialog.mode == "standalone") then
        return false
    end
    if frame and getDialogFrame(dialog) ~= frame then
        return false
    end
    dialog:Hide()
    return true
end

function lib:HideSettingsDialog(frame)
    local dialog = Internal.dialog
    if not (dialog and dialog:IsShown()) then
        return false
    end
    if frame and getDialogFrame(dialog) ~= frame then
        return false
    end
    dialog:Hide()
    return true
end

function lib:IsStandaloneSettingsDialogShown(frame)
    local dialog = Internal.dialog
    if not (dialog and dialog:IsShown() and dialog.mode == "standalone") then
        return false
    end
    if frame and getDialogFrame(dialog) ~= frame then
        return false
    end
    return true
end

-- Dedicated standalone-style panel that may be displayed while Blizzard Edit
-- Mode is active without replacing the currently selected frame dialog.
function Internal:EnsureAttachedDialog(forceNew)
    self:EnsureDialog()
    if forceNew and self.attachedDialog then
        self.attachedDialog:Hide()
        self.attachedDialog = nil
    end
    if not self.attachedDialog then
        self.attachedDialog = self.CreateDialog()
    end
    return self.attachedDialog
end

function lib:ShowAttachedSettingsPanel(frame, options)
    assert(frame, "frame is required")
    assert(options == nil or type(options) == "table", "options must be a table")

    options = options or {}
    local context = normalizeDialogContext({
        mode = "attached",
        frame = frame,
        title = options.title,
        settings = options.settings,
        buttons = options.buttons,
        showReset = options.showReset,
        showSettingsReset = options.showSettingsReset,
        settingsSpacing = options.settingsSpacing,
        settingsMaxHeight = options.settingsMaxHeight or options.maxSettingsHeight,
        point = options.point or options.anchorPoint,
        relativePoint = options.relativePoint or options.anchorRelativePoint,
        relativeTo = options.relativeTo or options.anchorTo,
        x = options.x or options.offsetX,
        y = options.y or options.offsetY,
        onHide = options.onHide,
    })

    local hasSettings = type(context.settings) == "table" and #context.settings > 0
    local hasButtons = type(context.buttons) == "table" and #context.buttons > 0
    if not hasSettings and not hasButtons then
        return nil, "no settings or buttons were provided for the attached panel"
    end

    local dialog = Internal:EnsureAttachedDialog(options.recreate)
    dialog:Update(context)
    return dialog
end

function lib:HideAttachedSettingsPanel(frame)
    local dialog = Internal.attachedDialog
    if not (dialog and dialog:IsShown() and dialog.mode == "attached") then
        return false
    end
    if frame and getDialogFrame(dialog) ~= frame then
        return false
    end
    dialog:Hide()
    return true
end

function lib:IsAttachedSettingsPanelShown(frame)
    local dialog = Internal.attachedDialog
    if not (dialog and dialog:IsShown() and dialog.mode == "attached") then
        return false
    end
    if frame and getDialogFrame(dialog) ~= frame then
        return false
    end
    return true
end

function lib:AddManagerToggle(data)
    if managerBroker.provider ~= lib then
        return managerBroker.provider:AddManagerToggle(data)
    end
    assert(type(data) == "table", "data must be a table")
    local id = data.id or data.name or data.label
    assert(type(id) == "string" and id ~= "", "manager toggle requires id or label")
    data.id = id
    if not State.managerToggleSpecs[id] then
        table.insert(State.managerToggleOrder, id)
    end
    State.managerToggleSpecs[id] = data

    if State.managerToggleState[id] == nil and data.default ~= nil then
        State.managerToggleState[id] = not not data.default
        if data.applyDefault ~= false then
            applyManagerToggleValue(data, State.managerToggleState[id])
        end
    end
    refreshManagerTogglePanel()
    return data
end

function lib:AddManagerCheckbox(data)
    return lib:AddManagerToggle(data)
end

function lib:AddManagerCategory(data)
    if managerBroker.provider ~= lib then
        return managerBroker.provider:AddManagerCategory(data)
    end
    -- Categories are intentionally ignored by the isolated flat checkbox panel.
    return data
end

function lib:RemoveManagerToggle(id)
    if managerBroker.provider ~= lib then
        return managerBroker.provider:RemoveManagerToggle(id)
    end
    if not id then
        return
    end
    State.managerToggleSpecs[id] = nil
    State.managerToggleState[id] = nil
    for index, entry in ipairs(State.managerToggleOrder) do
        if entry == id then
            table.remove(State.managerToggleOrder, index)
            break
        end
    end
    refreshManagerTogglePanel()
end

function lib:RefreshManagerToggles()
    if managerBroker.provider ~= lib then
        return managerBroker.provider:RefreshManagerToggles()
    end
    refreshManagerTogglePanel()
end

function lib:SetManagerTogglePanelMaxHeight(_)
    -- The isolated panel sizes itself to its rows and does not use a ScrollFrame.
end

function lib:SetFrameResetVisible(frame, showReset)
    State.resetToggles[frame] = not not showReset
    if Internal.dialog and getDialogFrame(Internal.dialog) == frame then
        Internal.dialog:UpdateButtons()
    end
end

function lib:SetFrameSettingsResetVisible(frame, showReset)
    State.settingsResetToggles[frame] = not not showReset
    if Internal.dialog and getDialogFrame(Internal.dialog) == frame then
        Internal.dialog:UpdateSettings()
    end
end

function lib:SetFrameSettingsMaxHeight(frame, height)
    if height == nil then
        State.settingsMaxHeightOverrides[frame] = nil
    else
        State.settingsMaxHeightOverrides[frame] = normalizePositive(height, nil)
    end

    if Internal.dialog and getDialogFrame(Internal.dialog) == frame then
        Internal.dialog:Layout()
    end
end

function lib:SetFrameDragEnabled(frame, enabledOrPredicate)
    if enabledOrPredicate == nil then
        State.dragPredicates[frame] = nil
    else
        State.dragPredicates[frame] = enabledOrPredicate
    end
end

function lib:SetFrameEditModeEnabled(frame, enabledOrPredicate)
    if enabledOrPredicate == nil then
        State.selectionPredicates[frame] = nil
    else
        State.selectionPredicates[frame] = enabledOrPredicate
    end
    resetSelectionIndicators()
end

function lib:RefreshFrameSelections()
    resetSelectionIndicators()
end

function lib:SetFrameCollapseExclusive(frame, enabled)
    if enabled == nil then
        State.collapseExclusiveFlags[frame] = nil
    else
        State.collapseExclusiveFlags[frame] = not not enabled
    end
end

function lib:SetFrameOverlayToggleEnabled(frame, enabled)
    State.overlayToggleFlags[frame] = not not enabled
    if enabled == false and State.selectionRegistry[frame] then
        local selection = State.selectionRegistry[frame]
        selection.overlayHidden = false
        updateSelectionVisuals(selection, false)
    end
end

function lib:RegisterCallback(event, callback)
    assert(event and type(event) == "string", "event must be a string")
    assert(callback and type(callback) == "function", "callback must be a function")
    if event == "enter" then
        table.insert(lib.eventHandlersEnter, callback)
    elseif event == "exit" then
        table.insert(lib.eventHandlersExit, callback)
    elseif event == "layout" then
        table.insert(lib.eventHandlersLayout, callback)
    elseif event == "layoutadded" then
        table.insert(lib.eventHandlersLayoutAdded, callback)
    elseif event == "layoutdeleted" then
        table.insert(lib.eventHandlersLayoutDeleted, callback)
    elseif event == "layoutrenamed" then
        table.insert(lib.eventHandlersLayoutRenamed, callback)
    elseif event == "spec" then
        table.insert(lib.eventHandlersSpec, callback)
    elseif event == "layoutduplicate" then
        table.insert(lib.eventHandlersLayoutDuplicate, callback)
    else
        error('invalid callback event "' .. event .. '"')
    end
end

function lib:GetActiveLayoutName()
    return lib.activeLayoutName
end

function lib:GetActiveLayoutIndex()
    if not lib.activeLayoutIndex then
        updateActiveLayoutFromAPI()
    end
    return lib.activeLayoutIndex
end

function lib:IsInEditMode()
    return not not lib.isEditing
end

function lib:GetLayouts()
    if not State.layoutSnapshot then
        updateActiveLayoutFromAPI()
    end
    local layoutInfo = C_EditMode_GetLayouts and C_EditMode_GetLayouts()
    local customLayouts = layoutInfo and layoutInfo.layouts
    local modernType = Enum and Enum.EditModeLayoutType and rawget(Enum.EditModeLayoutType, "Modern")
    local classicType = Enum and Enum.EditModeLayoutType and rawget(Enum.EditModeLayoutType, "Classic")
    local activeLayout = layoutInfo and layoutInfo.activeLayout
    local results = {}
    results[1] = { index = 1, name = layoutNames[1], layoutType = modernType, isActive = activeLayout == 1 and 1 or 0 }
    results[2] = { index = 2, name = layoutNames[2], layoutType = classicType, isActive = activeLayout == 2 and 1 or 0 }
    for i, name in ipairs(State.layoutSnapshot or {}) do
        local uiIndex = i + 2
        local entry = customLayouts and customLayouts[i]
        results[#results + 1] = {
            index = uiIndex,
            name = name or layoutNames[uiIndex],
            layoutType = entry and entry.layoutType,
            isActive = activeLayout == uiIndex and 1 or 0,
        }
    end
    return results
end

function lib:GetFrameDefaultPosition(frame)
    return State.defaultPositions[frame]
end

-- internal entry points ------------------------------------------------------------
function Internal:TriggerCallback(frame, ...)
    if State.frameHandlers[frame] then
        securecallfunction(State.frameHandlers[frame], frame, lib.activeLayoutName, ...)
    end
end

function Internal:GetFrameSettings(frame)
    if State.settingSheets[frame] then
        return State.settingSheets[frame], #State.settingSheets[frame]
    else
        return nil, 0
    end
end

function Internal:GetFrameButtons(frame)
    if State.buttonSpecs[frame] then
        return State.buttonSpecs[frame], #State.buttonSpecs[frame]
    else
        return nil, 0
    end
end

local function hasOpenDropdownMenu()
    local menuSystem = _G.Menu
    local menuManager = menuSystem and menuSystem.GetManager and menuSystem.GetManager()
    if menuManager and menuManager.GetOpenMenu then
        local ok, openMenu = pcall(menuManager.GetOpenMenu, menuManager)
        if ok and openMenu then
            return true
        end
    end
    return _G.UIDROPDOWNMENU_OPEN_MENU ~= nil
end

local function mergeRefreshSettingValueTargets(existing, incoming)
    if incoming == nil then
        return nil, true
    end
    if type(incoming) ~= "table" then
        return existing, existing ~= nil
    end
    if existing == nil then
        existing = {}
    end
    for _, entry in ipairs(incoming) do
        if type(entry) == "table" then
            existing[entry] = true
        end
    end
    for key, value in pairs(incoming) do
        if type(key) == "table" and value then
            existing[key] = true
        elseif type(value) == "table" then
            existing[value] = true
        end
    end
    return existing, next(existing) ~= nil
end

function Internal:_scheduleSettingsRefresh(delay)
    if self._refreshRunnerScheduled then
        return
    end
    self._refreshRunnerScheduled = true
    local wait = tonumber(delay) or 0
    if wait < 0 then
        wait = 0
    end
    if not (C_Timer and C_Timer.After) then
        self._refreshRunnerScheduled = false
        self:_runDeferredSettingsRefresh()
        return
    end
    self._refreshRunner = self._refreshRunner
        or function()
            Internal._refreshRunnerScheduled = false
            Internal:_runDeferredSettingsRefresh()
        end
    C_Timer.After(wait, self._refreshRunner)
end

function Internal:_runDeferredSettingsRefresh()
    if hasOpenDropdownMenu() then
        self:_scheduleSettingsRefresh(0.05)
        return
    end

    local refreshLayout = self._refreshQueued == true
    local refreshValues = self._refreshValuesQueued == true
    local targets = self._refreshValueTargets

    self._refreshQueued = nil
    self._refreshValuesQueued = nil
    self._refreshValueTargets = nil

    if refreshLayout then
        self:RefreshSettings(true)
    end
    if refreshValues then
        self:RefreshSettingValues(targets, true)
    end
end

function Internal:RequestRefreshSettings()
    self._refreshQueued = true
    self:_scheduleSettingsRefresh(0)
end

function Internal:RequestRefreshSettingValues(targetSettings)
    self._refreshValuesQueued = true
    self._refreshValueTargets = mergeRefreshSettingValueTargets(self._refreshValueTargets, targetSettings)
    self:_scheduleSettingsRefresh(0)
end

local function refreshSettingsForDialog(dialog)
    if not (dialog and dialog:IsShown()) then
        return
    end
    local parent = dialog.Settings
    if not parent then
        return
    end
    local selectionParent = getDialogFrame(dialog)
    local layoutName = lib.activeLayoutName
    local layoutIndex = lib:GetActiveLayoutIndex()
    local layoutDirty = false
    for _, child in ipairs({ parent:GetChildren() }) do
        if child.setting then
            local data = child.setting
            if child.SetEnabled then
                local enabled = true
                if data.isEnabled then
                    local ok, result = pcall(data.isEnabled, layoutName, layoutIndex)
                    enabled = ok and result ~= false
                elseif data.disabled then
                    local ok, result = pcall(data.disabled, layoutName, layoutIndex)
                    enabled = not (ok and result == true)
                end
                if child._eqolEnabled ~= enabled then
                    child._eqolEnabled = enabled
                    child:SetEnabled(enabled)
                end
            end

            local collapsedParent = (data.kind ~= lib.SettingType.Collapsible) and data.parentId and Collapse:Get(selectionParent, data.parentId)
            local visible = evaluateVisibilityFast(data, layoutName, layoutIndex) and not collapsedParent
            local wantIgnore = not visible
            local haveIgnore = child.ignoreInLayout == true
            if wantIgnore ~= haveIgnore then
                child.ignoreInLayout = wantIgnore
                layoutDirty = true
            end
            if visible ~= child:IsShown() then
                if visible then
                    child:Show()
                else
                    child:Hide()
                end
                layoutDirty = true
            end
        end
    end
    if layoutDirty then
        if parent.Layout then
            parent:Layout()
        end
        FixScrollBarInside(dialog.SettingsScroll)
        UpdateScrollChildWidth(dialog)
        if dialog.Layout then
            dialog:Layout()
        end
    end
end

function Internal:RefreshSettings(fromDeferred)
    if not fromDeferred and hasOpenDropdownMenu() then
        self:RequestRefreshSettings()
        return
    end
    refreshSettingsForDialog(Internal.dialog)
    refreshSettingsForDialog(Internal.attachedDialog)
end

local function refreshSettingValuesForDialog(dialog, targets)
    if not (dialog and dialog:IsShown()) then
        return
    end
    local parent = dialog.Settings
    if not parent then
        return
    end
    local selection = dialog.selection
    if not selection then
        return
    end
    local selectionParent = getDialogFrame(dialog)
    local layoutName = lib.activeLayoutName
    local layoutIndex = lib:GetActiveLayoutIndex()
    local settings, num = getDialogSettings(dialog)
    if not settings or num == 0 then
        return
    end
    for _, child in ipairs({ parent:GetChildren() }) do
        local data
        if child.layoutIndex and settings[child.layoutIndex] then
            data = settings[child.layoutIndex]
        elseif child.setting then
            data = child.setting
        end
        if data and child.Setup and (not targets or targets[data]) then
            ApplySettingsRowWidth(child, parent)
            child:Setup(data, selection)
            child.setting = data
            if child.SetEnabled then
                local enabled = true
                if data.isEnabled then
                    local ok, result = pcall(data.isEnabled, layoutName, layoutIndex)
                    enabled = ok and result ~= false
                elseif data.disabled then
                    local ok, result = pcall(data.disabled, layoutName, layoutIndex)
                    enabled = not (ok and result == true)
                end
                child:SetEnabled(enabled)
                child._eqolEnabled = enabled
            end
            local collapsed = (data.kind ~= lib.SettingType.Collapsible) and Collapse:Get(selectionParent, data.parentId)
            local visible = evaluateVisibility(data, layoutName, layoutIndex) and not collapsed
            if visible then
                child.ignoreInLayout = nil
                child:Show()
            else
                child.ignoreInLayout = true
                child:Hide()
            end
        end
    end
    if parent.Layout then
        parent:Layout()
    end
    FixScrollBarInside(dialog.SettingsScroll)
    UpdateScrollChildWidth(dialog)
    if dialog.Layout then
        dialog:Layout()
    end
end

function Internal:RefreshSettingValues(targetSettings, fromDeferred)
    if not fromDeferred and hasOpenDropdownMenu() then
        self:RequestRefreshSettingValues(targetSettings)
        return
    end
    local targets
    if type(targetSettings) == "table" then
        targets = {}
        for _, entry in ipairs(targetSettings) do
            if type(entry) == "table" then
                targets[entry] = true
            end
        end
        for key, value in pairs(targetSettings) do
            if type(key) == "table" and value then
                targets[key] = true
            elseif type(value) == "table" then
                targets[value] = true
            end
        end
        if next(targets) == nil then
            targets = nil
        end
    end
    refreshSettingValuesForDialog(Internal.dialog, targets)
    refreshSettingValuesForDialog(Internal.attachedDialog, targets)
end
