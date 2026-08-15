local _, ns = ...
local Affected = ns.API.Affected

local Keybinds = {}
ns.Keybinds = Keybinds

local DEBUG_MODULE = "Keybinds"
ns.API:RegisterDebugModule(DEBUG_MODULE)

local PrintDebug = function(...)
    ns.API:LogDebug(DEBUG_MODULE, ...)
end

local isModuleEnabled = false
local areHooksInitialized = false

-- Memoized spell->keybind mapping. Building it scans every action-bar slot
-- (GetActionInfo over ~120+ buttons), which is wasteful when the mapping hasn't
-- changed. The mapping only changes when bindings or the bars themselves change,
-- so we rebuild lazily on the relevant events and otherwise reuse the cached
-- result across viewers and per-refresh RefreshLayout passes.
local keybindMappingDirty = true
local keybindMappingResult = nil
local keybindMappingGeneration = 0
local viewerMappingGeneration = {}
local cooldownIDToSpellID = {}
local KEYBIND_UPDATE_DELAY = 0.05
local keybindUpdateScheduled = false
local keybindSettingsUpdatePending = false
local MAPPING_INVALIDATION_EVENTS = {
    PLAYER_ENTERING_WORLD = true,
    UPDATE_BONUS_ACTIONBAR = true,
    UPDATE_BINDINGS = true,
    PLAYER_TALENT_UPDATE = true,
    PLAYER_SPECIALIZATION_CHANGED = true,
    TRAIT_CONFIG_UPDATED = true,
    ACTIONBAR_HIDEGRID = true,
    ACTIONBAR_PAGE_CHANGED = true,
    ACTIONBAR_SLOT_CHANGED = true,
    GAME_PAD_ACTIVE_CHANGED = true,
    PLAYER_EQUIPMENT_CHANGED = true,
}

-- Secondary actions "hidden" inside a macro body (e.g. a `/use` potion or a
-- second `/cast` after the primary spell). The primary action of a macro is
-- already captured via GetMacroSpell; this lets those extra spells/items inherit
-- the macro's keybind, but only at LOWER priority than any direct assignment.
-- Cached per macro name and keyed on the raw body so edits auto-invalidate
-- (there is no dedicated "macro changed" event); the cache is also wiped wholesale
-- on spec/talent/binding changes where name->spellID resolution can shift.
local macroSecondaryCache = {}
local EMPTY_ACTIONS = {}

local viewersSettingKey = {
    EssentialCooldownViewer = "Essential",
    UtilityCooldownViewer = "Utility",
}
-- Custom trackers use their frame name as the settings scope, backed by the
-- corresponding editMode.trackerN table. Absent frames are skipped by helpers.
for i = 1, (ns.CONSTANTS.MAX_TRACKERS or 10) do
    viewersSettingKey["CMCTracker" .. i] = "CMCTracker" .. i
end

local function GetTrackerConfig(viewerSettingName)
    local index = type(viewerSettingName) == "string" and viewerSettingName:match("^CMCTracker(%d+)$")
    local editMode = ns.db and ns.db.profile and ns.db.profile.editMode
    return index and editMode and editMode["tracker" .. index] or nil
end

local function IsKeybindEnabled(viewerSettingName)
    local trackerConfig = GetTrackerConfig(viewerSettingName)
    if trackerConfig then
        return trackerConfig.showKeybinds == true
    end
    return ns.db.profile["cooldownManager_showKeybinds_" .. viewerSettingName] == true
end

local function IsKeybindEnabledForAnyViewer()
    if not ns.db or not ns.db.profile then
        return false
    end
    for _, viewerSettingName in pairs(viewersSettingKey) do
        if IsKeybindEnabled(viewerSettingName) then
            return true
        end
    end
    return false
end

local function GetKeybindSettings(viewerSettingName)
    local defaults = {
        anchor = "CENTER",
        fontSize = 14,
        offsetX = 0,
        offsetY = 0,
    }
    if not ns.db or not ns.db.profile then
        return defaults
    end
    local trackerConfig = GetTrackerConfig(viewerSettingName)
    if trackerConfig then
        return {
            anchor = trackerConfig.keybindAnchor or "TOPRIGHT",
            fontSize = trackerConfig.keybindFontSize or 10,
            offsetX = trackerConfig.keybindOffsetX or -3,
            offsetY = trackerConfig.keybindOffsetY or -3,
        }
    end
    return {
        anchor = ns.db.profile["cooldownManager_keybindAnchor_" .. viewerSettingName] or defaults.anchor,
        fontSize = ns.db.profile["cooldownManager_keybindFontSize_" .. viewerSettingName] or defaults.fontSize,
        offsetX = ns.db.profile["cooldownManager_keybindOffsetX_" .. viewerSettingName] or defaults.offsetX,
        offsetY = ns.db.profile["cooldownManager_keybindOffsetY_" .. viewerSettingName] or defaults.offsetY,
    }
end

local formattedKeybindCache = {}

local function GetFormattedKeybind(key)
    if not key or key == "" then
        return ""
    end

    local cached = formattedKeybindCache[key]
    if cached ~= nil then
        return cached
    end

    local bindingText = GetBindingText and GetBindingText(key, "KEY_", true)
    local displayKey = (bindingText and bindingText ~= "") and bindingText or key
    if displayKey:find("|", 1, true) then
        formattedKeybindCache[key] = displayKey
        return displayKey
    end

    local upperKey = key:upper()

    upperKey = upperKey:gsub("PADLTRIGGER", "LT")
    upperKey = upperKey:gsub("PADRTRIGGER", "RT")
    upperKey = upperKey:gsub("PADLSHOULDER", "LB")
    upperKey = upperKey:gsub("PADRSHOULDER", "RB")
    upperKey = upperKey:gsub("PADLSTICK", "LS")
    upperKey = upperKey:gsub("PADRSTICK", "RS")
    upperKey = upperKey:gsub("PADDPADUP", "D↑")
    upperKey = upperKey:gsub("PADDPADDOWN", "D↓")
    upperKey = upperKey:gsub("PADDPADLEFT", "D←")
    upperKey = upperKey:gsub("PADDPADRIGHT", "D→")
    upperKey = upperKey:gsub("^PAD", "")

    upperKey = upperKey:gsub("SHIFT%-", "S")
    upperKey = upperKey:gsub("META%-", "M")
    upperKey = upperKey:gsub("CTRL%-", "C")
    upperKey = upperKey:gsub("ALT%-", "A")
    upperKey = upperKey:gsub("STRG%-", "ST") -- German Ctrl

    upperKey = upperKey:gsub("MOUSE%s?WHEEL%s?UP", "MWU")
    upperKey = upperKey:gsub("MOUSE%s?WHEEL%s?DOWN", "MWD")
    upperKey = upperKey:gsub("MIDDLE%s?MOUSE", "MM")
    upperKey = upperKey:gsub("MOUSE%s?BUTTON%s?", "M")
    upperKey = upperKey:gsub("BUTTON", "M")

    upperKey = upperKey:gsub("NUMPAD%s?PLUS", "N+")
    upperKey = upperKey:gsub("NUMPAD%s?MINUS", "N-")
    upperKey = upperKey:gsub("NUMPAD%s?MULTIPLY", "N*")
    upperKey = upperKey:gsub("NUMPAD%s?DIVIDE", "N/")
    upperKey = upperKey:gsub("NUMPAD%s?DECIMAL", "N.")
    upperKey = upperKey:gsub("NUMPAD%s?ENTER", "NEnt")
    upperKey = upperKey:gsub("NUMPAD%s?", "N")
    upperKey = upperKey:gsub("NUM%s?", "N")
    upperKey = upperKey:gsub("NPAD%s?", "N")

    upperKey = upperKey:gsub("PAGE%s?UP", "PGU")
    upperKey = upperKey:gsub("PAGE%s?DOWN", "PGD")
    upperKey = upperKey:gsub("INSERT", "INS")
    upperKey = upperKey:gsub("DELETE", "DEL")
    upperKey = upperKey:gsub("SPACEBAR", "Spc")
    upperKey = upperKey:gsub("ENTER", "Ent")
    upperKey = upperKey:gsub("ESCAPE", "Esc")
    upperKey = upperKey:gsub("TAB", "Tab")
    upperKey = upperKey:gsub("CAPS%s?LOCK", "Caps")
    upperKey = upperKey:gsub("HOME", "Hom")
    upperKey = upperKey:gsub("END", "End")

    formattedKeybindCache[key] = upperKey
    return upperKey
end

local ButtonRowsPrefix = {
    ["blizzard"] = {
        [1] = "ActionButton",
        [2] = "MultiBarBottomLeftButton",
        [3] = "MultiBarBottomRightButton",
        [4] = "MultiBarRightButton",
        [5] = "MultiBarLeftButton",
        [6] = "MultiBar5Button",
        [7] = "MultiBar6Button",
        [8] = "MultiBar7Button",
    },
    ["elvui"] = {
        [1] = "ElvUI_Bar1Button",
        [2] = "ElvUI_Bar2Button",
        [3] = "ElvUI_Bar3Button",
        [4] = "ElvUI_Bar4Button",
        [5] = "ElvUI_Bar5Button",
        [6] = "ElvUI_Bar6Button",
        [7] = "ElvUI_Bar7Button",
        [8] = "ElvUI_Bar8Button",
        [9] = "ElvUI_Bar9Button",
        [10] = "ElvUI_Bar10Button",
        [11] = nil,
        [12] = nil,
        [13] = "ElvUI_Bar13Button",
        [14] = "ElvUI_Bar14Button",
        [15] = "ElvUI_Bar15Button",
    },
    ["dominos"] = {
        [1] = "DominosActionButton",
        [2] = "DominosActionButton",
        [3] = "MultiBarRightActionButton",
        [4] = "MultiBarLeftActionButton",
        [5] = "MultiBarBottomRightActionButton",
        [6] = "MultiBarBottomLeftActionButton",
        [7] = "DominosActionButton",
        [8] = "DominosActionButton",
        [9] = "DominosActionButton",
        [10] = "DominosActionButton",
        [11] = "DominosActionButton",
        [12] = "MultiBar5ActionButton",
        [13] = "MultiBar6ActionButton",
        [14] = "MultiBar7ActionButton",
    },
}

local macroCommandSet = nil
local MACRO_COMMAND_GLOBALS = {
    "SLASH_CAST",
    "SLASH_USE",
    "SLASH_CASTSEQUENCE",
    "SLASH_CASTRANDOM",
    "SLASH_USERANDOM",
}

local function GetMacroCommandSet()
    if macroCommandSet then
        return macroCommandSet
    end
    macroCommandSet = {}
    for _, base in ipairs(MACRO_COMMAND_GLOBALS) do
        local i = 1
        while true do
            local verb = _G[base .. i]
            if not verb then
                break
            end
            macroCommandSet[verb:lower()] = true
            i = i + 1
        end
    end
    return macroCommandSet
end

local function ResolveTokenToSpellID(token)
    if token == "" or tonumber(token) then
        return nil
    end

    local explicitItemID = token:match("^item:(%d+)")
    if explicitItemID then
        local _, spellID = C_Item.GetItemSpell(tonumber(explicitItemID))
        return spellID
    end

    local spellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(token)
    if spellInfo and spellInfo.spellID then
        return spellInfo.spellID
    end

    local itemID = C_Item.GetItemInfoInstant(token)
    if itemID then
        local _, spellID = C_Item.GetItemSpell(itemID)
        if spellID then
            return spellID
        end
    end

    return nil
end

local INVENTORY_SLOT_MIN, INVENTORY_SLOT_MAX = 1, 19

local function ParseMacroBody(body)
    local commandSet = GetMacroCommandSet()
    local seen, result = {}, {}

    for line in body:gmatch("[^\r\n]+") do
        local command, rest = line:match("^%s*(/%S+)%s*(.*)$")
        if command and commandSet[command:lower()] then
            -- Strip [conditional] blocks and castsequence reset=... clauses so
            -- only the actual spell/item/slot arguments remain.
            rest = rest:gsub("%b[]", " ")
            rest = rest:gsub("[Rr][Ee][Ss][Ee][Tt]=%S+", " ")
            for token in rest:gmatch("[^;,]+") do
                token = token:gsub("^%s+", ""):gsub("%s+$", "")
                token = token:gsub("^[!~]+", ""):gsub("^%s+", "")
                local slot = tonumber(token)
                if slot then
                    if slot >= INVENTORY_SLOT_MIN and slot <= INVENTORY_SLOT_MAX then
                        local key = "slot:" .. slot
                        if not seen[key] then
                            seen[key] = true
                            result[#result + 1] = { slot = slot }
                        end
                    end
                else
                    local spellID = ResolveTokenToSpellID(token)
                    if spellID then
                        local key = "spell:" .. spellID
                        if not seen[key] then
                            seen[key] = true
                            result[#result + 1] = { spellID = spellID }
                        end
                    end
                end
            end
        end
    end

    return result
end

local function GetMacroSecondaryActions(macroName)
    if not macroName or macroName == "" then
        return EMPTY_ACTIONS
    end

    local _, _, body = GetMacroInfo(macroName)
    if not body or body == "" then
        return EMPTY_ACTIONS
    end

    local cached = macroSecondaryCache[macroName]
    if cached and cached.body == body then
        return cached.actions
    end

    local actions = ParseMacroBody(body)
    macroSecondaryCache[macroName] = { body = body, actions = actions }
    return actions
end

function Keybinds:GetActionsTableBySpellId(slotToKeybind)
    PrintDebug("Building Actions Table By Spell ID")

    local spellIdToKeyBind = {}
    local macrosToParse = {}

    local function assignResultForSlot(slot, keyBind)
        local actionType, id, subType = GetActionInfo(slot)
        if actionType == "macro" then
            local macroName = GetActionText(slot)
            if macroName and macroName ~= "" then
                macrosToParse[#macrosToParse + 1] = { macroName = macroName, keyBind = keyBind }
            end
        end
        if not spellIdToKeyBind[id] then
            if (actionType == "macro" and subType == "spell") or (actionType == "spell") then
                spellIdToKeyBind[id] = keyBind
                if ns.SpellIDOverrides[id] and not spellIdToKeyBind[ns.SpellIDOverrides[id]] then
                    spellIdToKeyBind[ns.SpellIDOverrides[id]] = keyBind
                end
            elseif actionType == "macro" then
                local macroName = GetActionText(slot)
                local macroSpellID = GetMacroSpell(macroName)

                if macroSpellID and not spellIdToKeyBind[macroSpellID] then
                    spellIdToKeyBind[macroSpellID] = keyBind
                    if ns.SpellIDOverrides[macroSpellID] and not spellIdToKeyBind[ns.SpellIDOverrides[macroSpellID]] then
                        spellIdToKeyBind[ns.SpellIDOverrides[macroSpellID]] = keyBind
                    end
                end
            elseif actionType == "item" then
                local _, spellId = C_Item.GetItemSpell(id)
                if spellId and not spellIdToKeyBind[spellId] then
                    spellIdToKeyBind[spellId] = keyBind
                end
            end
        end
    end
    if _G.DominosActionButton1 then
        for i = 1, 14 do
            local bar = ButtonRowsPrefix["dominos"][i]

            if bar then
                for j = 1, 12 do
                    local buttonName = bar
                    if bar == "DominosActionButton" then
                        buttonName = bar .. ((i - 1) * 12 + j)
                    else
                        buttonName = bar .. j
                    end
                    local button = _G[buttonName]
                    local slot = button and button.action
                    local keyBind = button and button.HotKey and button.HotKey:GetText()
                    if button and slot and keyBind and keyBind ~= "●" then
                        assignResultForSlot(slot, keyBind)
                    end
                end
            end
        end
    end
    if _G.BT4Button1 then
        for i = 1, 180 do
            local button = _G["BT4Button" .. i]

            if button then
                local slot = button and button.action
                local keyBind = button and button.HotKey and button.HotKey:GetText()
                if button and slot and keyBind and keyBind ~= "●" then
                    assignResultForSlot(slot, keyBind)
                end
            end
        end
    end
    if _G.ElvUI_Bar1Button1 then
        for i = 1, 15 do
            local bar = ButtonRowsPrefix["elvui"][i]

            if bar then
                for j = 1, 12 do
                    local buttonName = bar .. j
                    local button = _G[buttonName]
                    local slot = button and button.action
                    if button and slot and button.config then
                        local keyBind = GetBindingKey(button.config.keyBoundTarget)
                        if keyBind then
                            assignResultForSlot(slot, keyBind)
                        end
                    end
                end
            end
        end
    end
    for i = 1, 8 do
        local bar = ButtonRowsPrefix["blizzard"][i]

        if bar then
            for j = 1, 12 do
                local buttonName = bar .. j
                local button = _G[buttonName]
                local slot = button and button.action
                local keyBoundTarget = button and button.commandName
                if button and slot and keyBoundTarget then
                    local keyBind = GetBindingKey(keyBoundTarget)
                    if keyBind then
                        assignResultForSlot(slot, keyBind)
                    end
                end
            end
        end
    end

    -- Lower-priority pass: spells/items hidden inside macro bodies only fill
    -- spellIDs that no directly-bound action (or macro primary) already claimed.
    for _, macro in ipairs(macrosToParse) do
        local actions = GetMacroSecondaryActions(macro.macroName)
        for _, action in ipairs(actions) do
            local spellID = action.spellID
            if not spellID and action.slot then
                local itemID = GetInventoryItemID("player", action.slot)
                if itemID then
                    local _, slotSpellID = C_Item.GetItemSpell(itemID)
                    spellID = slotSpellID
                end
            end
            if spellID and not spellIdToKeyBind[spellID] then
                spellIdToKeyBind[spellID] = macro.keyBind
                local override = ns.SpellIDOverrides[spellID]
                if override and not spellIdToKeyBind[override] then
                    spellIdToKeyBind[override] = macro.keyBind
                end
            end
        end
    end

    return spellIdToKeyBind
end

local function BuildSpellKeyBindMapping()
    local spellIDToKeyBind = Keybinds:GetActionsTableBySpellId()

    local spellIDToKeyBindFormatted = {}

    for spellID, rawKey in pairs(spellIDToKeyBind) do
        if rawKey and rawKey ~= "" and rawKey ~= "●" and not spellIDToKeyBindFormatted[spellID] then
            local formattedKey = GetFormattedKeybind(rawKey)
            if formattedKey ~= "" then
                spellIDToKeyBindFormatted[spellID] = formattedKey
            end
        end
    end
    -- _WTDebug.spellIdToKeyBind = spellIDToKeyBind
    -- _WTDebug.spellIDToFormattedKeyBind = spellIDToKeyBindFormatted
    return spellIDToKeyBindFormatted
end

local function AreKeybindMappingsEqual(a, b)
    for spellID, keybind in pairs(a) do
        if b[spellID] ~= keybind then
            return false
        end
    end
    for spellID, keybind in pairs(b) do
        if a[spellID] ~= keybind then
            return false
        end
    end
    return true
end

-- Returns the spell->keybind mapping, rebuilding only when marked dirty.
local function GetSpellKeyBindMapping()
    if not keybindMappingDirty and keybindMappingResult then
        return keybindMappingResult, keybindMappingGeneration
    end
    local rebuilt = BuildSpellKeyBindMapping()
    if not keybindMappingResult or not AreKeybindMappingsEqual(keybindMappingResult, rebuilt) then
        keybindMappingResult = rebuilt
        keybindMappingGeneration = keybindMappingGeneration + 1
    end
    keybindMappingDirty = false
    return keybindMappingResult, keybindMappingGeneration
end

function Keybinds:FindKeyBindForSpell(spellID, spellToKeybind)
    if not spellID or spellID == 0 then
        return ""
    end

    if spellToKeybind[spellID] then
        return spellToKeybind[spellID]
    end

    local overrideSpellID = C_Spell.GetOverrideSpell(spellID)
    if overrideSpellID and spellToKeybind[overrideSpellID] then
        return spellToKeybind[overrideSpellID]
    end

    local baseSpellID = C_Spell.GetBaseSpell(spellID)
    if baseSpellID and spellToKeybind[baseSpellID] then
        return spellToKeybind[baseSpellID]
    end

    return ""
end

local function GetOrCreateKeybindText(icon, viewerSettingName)
    if Affected(icon).keybindText and Affected(icon).keybindText.text then
        return Affected(icon).keybindText.text
    end

    local settings = GetKeybindSettings(viewerSettingName)
    Affected(icon).keybindText = CreateFrame("Frame", nil, icon, "BackdropTemplate")
    Affected(icon).keybindText:SetFrameLevel(icon:GetFrameLevel() + 4)
    local keybindText = Affected(icon).keybindText:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall")
    keybindText:SetPoint(settings.anchor, icon, settings.anchor, settings.offsetX, settings.offsetY)
    -- keybindText:SetTextColor(1, 1, 1, 1)
    keybindText:SetShadowColor(0, 0, 0, 1)
    keybindText:SetShadowOffset(1, -1)
    keybindText:SetDrawLayer("OVERLAY", 7)

    Affected(icon).keybindText.text = keybindText
    return Affected(icon).keybindText.text
end

local function GetKeybindFontName(viewerSettingName)
    local trackerConfig = GetTrackerConfig(viewerSettingName)
    if trackerConfig and trackerConfig.keybindFontName then
        return trackerConfig.keybindFontName
    end
    if ns.db and ns.db.profile and ns.db.profile.cooldownManager_keybindFontName then
        return ns.db.profile.cooldownManager_keybindFontName
    end
    return "Friz Quadrata TT"
end

local function ApplyKeybindTextSettings(icon, viewerSettingName)
    if not Affected(icon).keybindText then
        return
    end

    local settings = GetKeybindSettings(viewerSettingName)
    local keybindText = GetOrCreateKeybindText(icon, viewerSettingName)

    keybindText:ClearAllPoints()
    keybindText:SetPoint(settings.anchor, icon, settings.anchor, settings.offsetX, settings.offsetY)
    local fontName = GetKeybindFontName(viewerSettingName)
    local fontPath = ns.API:GetFontPath(fontName) or ns.CONSTANTS.DEFAULT_FONT[1]
    local trackerConfig = GetTrackerConfig(viewerSettingName)
    local fontFlags = trackerConfig and trackerConfig.keybindFontFlags or ns.db.profile.cooldownManager_keybindFontFlags
    keybindText:SetFont(fontPath, settings.fontSize, ns.API:GetFontFlags(fontFlags))
end

local function ExtractSpellIDFromChild(child)
    if child.cooldownID then
        local cachedSpellID = cooldownIDToSpellID[child.cooldownID]
        if cachedSpellID ~= nil then
            return cachedSpellID ~= false and cachedSpellID or nil
        end
        local info = C_CooldownViewer.GetCooldownViewerCooldownInfo(child.cooldownID)
        local spellID = info and info.spellID or false
        cooldownIDToSpellID[child.cooldownID] = spellID
        return spellID ~= false and spellID or nil
    end
    if child.spellID then
        return child.spellID
    end
    return nil
end

local function UpdateIconKeybind(icon, viewerSettingName, spellID, keybind)
    if not icon then
        return
    end

    local affected = Affected(icon)
    local enabled = IsKeybindEnabled(viewerSettingName)
    keybind = keybind or ""
    if not enabled then
        if affected.keybindEnabled == false then
            return
        end
        affected.keybindEnabled = false
        affected.keybindSpellID = spellID
        affected.keybindValue = keybind
        if affected.keybindText then
            affected.keybindText:Hide()
            if affected.keybindText.text then
                affected.keybindText.text:Hide()
            end
        end

        return
    end

    if affected.keybindEnabled == true and affected.keybindSpellID == spellID and affected.keybindValue == keybind then
        return
    end
    affected.keybindEnabled = true
    affected.keybindSpellID = spellID
    affected.keybindValue = keybind

    local keybindText = GetOrCreateKeybindText(icon, viewerSettingName)
    keybindText:SetText(keybind)
    if keybind == "" then
        affected.keybindText:Hide()
        keybindText:Hide()
    else
        affected.keybindText:Show()
        keybindText:Show()
    end
end

local function UpdateViewerKeybinds(viewerName, applySettings, force)
    local viewerFrame = _G[viewerName]
    if not viewerFrame then
        return
    end

    local settingName = viewersSettingKey[viewerName]
    if not settingName then
        return
    end

    PrintDebug("UpdateViewerKeybinds for", viewerName)

    local spellToKeybind, generation = GetSpellKeyBindMapping()
    if not force and not applySettings and viewerMappingGeneration[viewerName] == generation then
        return
    end

    local children
    if viewerFrame.GetItemFrames then
        children = ns.API:GetViewerItemFrames(viewerFrame)
    else
        children = { viewerFrame:GetChildren() }
    end
    for _, child in ipairs(children) do
        if child.Icon then
            local spellID = ExtractSpellIDFromChild(child)
            local keybind = ""

            if spellID then
                keybind = Keybinds:FindKeyBindForSpell(spellID, spellToKeybind)
            end

            UpdateIconKeybind(child, settingName, spellID, keybind)
        end
        if applySettings and Affected(child).keybindText then
            ApplyKeybindTextSettings(child, settingName)
        end
    end
    viewerMappingGeneration[viewerName] = generation
end

function Keybinds:UpdateViewerKeybinds(viewerName)
    UpdateViewerKeybinds(viewerName, false, true)
end

function Keybinds:UpdateAllKeybinds(applySettings)
    for viewerName, _ in pairs(viewersSettingKey) do
        UpdateViewerKeybinds(viewerName, applySettings, true)
    end
end

local function QueueUpdateAllKeybinds(applySettings)
    keybindSettingsUpdatePending = keybindSettingsUpdatePending or applySettings == true
    if keybindUpdateScheduled then
        return
    end
    keybindUpdateScheduled = true
    C_Timer.After(KEYBIND_UPDATE_DELAY, function()
        keybindUpdateScheduled = false
        local updateSettings = keybindSettingsUpdatePending
        keybindSettingsUpdatePending = false
        if isModuleEnabled then
            for viewerName in pairs(viewersSettingKey) do
                UpdateViewerKeybinds(viewerName, updateSettings, false)
            end
        end
    end)
end

function Keybinds:ApplyKeybindSettings(viewerName)
    local viewerFrame = _G[viewerName]
    if not viewerFrame then
        return
    end

    local settingName = viewersSettingKey[viewerName]
    if not settingName then
        return
    end

    local children
    if viewerFrame.GetItemFrames then
        children = ns.API:GetViewerItemFrames(viewerFrame)
    else
        children = { viewerFrame:GetChildren() }
    end
    for _, child in ipairs(children) do
        if Affected(child).keybindText then
            ApplyKeybindTextSettings(child, settingName)
        end
    end
end

local eventFrame = CreateFrame("Frame")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if not isModuleEnabled then
        return
    end

    PrintDebug("Event:", event)
    if MAPPING_INVALIDATION_EVENTS[event] then
        keybindMappingDirty = true
        wipe(cooldownIDToSpellID)
    end
    if
        event == "PLAYER_SPECIALIZATION_CHANGED"
        or event == "UPDATE_BINDINGS"
        or event == "ACTIONBAR_HIDEGRID"
        or event == "UPDATE_BONUS_ACTIONBAR"
        or event == "GAME_PAD_ACTIVE_CHANGED"
        or event == "PLAYER_EQUIPMENT_CHANGED"
    then
        wipe(macroSecondaryCache)
    end

    QueueUpdateAllKeybinds(false)
end)

function Keybinds:Shutdown()
    PrintDebug("Shutting down module")

    isModuleEnabled = false
    eventFrame:UnregisterAllEvents()

    for viewerName, _ in pairs(viewersSettingKey) do
        local viewerFrame = _G[viewerName]
        if viewerFrame then
            local children
            if viewerFrame.GetItemFrames then
                children = ns.API:GetViewerItemFrames(viewerFrame)
            else
                children = { viewerFrame:GetChildren() }
            end
            for _, child in ipairs(children) do
                if Affected(child).keybindText then
                    Affected(child).keybindText:Hide()
                end
                Affected(child).keybindEnabled = nil
                Affected(child).keybindSpellID = nil
                Affected(child).keybindValue = nil
            end
        end
    end
end

function Keybinds:Enable()
    if isModuleEnabled then
        return
    end
    PrintDebug("Enabling module")

    isModuleEnabled = true
    -- Binding events are ignored while disabled, so force a fresh mapping build.
    keybindMappingDirty = true

    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventFrame:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
    eventFrame:RegisterEvent("UPDATE_BINDINGS")
    eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
    eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    eventFrame:RegisterEvent("TRAIT_CONFIG_UPDATED")
    eventFrame:RegisterEvent("ACTIONBAR_HIDEGRID")
    eventFrame:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
    eventFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
    eventFrame:RegisterEvent("GAME_PAD_ACTIVE_CHANGED")
    eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

    if not areHooksInitialized then
        areHooksInitialized = true

        for viewerName, _ in pairs(viewersSettingKey) do
            local viewerFrame = _G[viewerName]
            if viewerFrame and viewerFrame.RefreshLayout then
                hooksecurefunc(viewerFrame, "RefreshLayout", function()
                    if not isModuleEnabled then
                        return
                    end
                    PrintDebug("RefreshLayout called for viewer:", viewerName)
                    wipe(cooldownIDToSpellID)
                    UpdateViewerKeybinds(viewerName, false, true)
                end)
            end
        end
    end

    self:UpdateAllKeybinds(true)
end

function Keybinds:Disable()
    if not isModuleEnabled then
        return
    end
    PrintDebug("Disabling module")
    self:Shutdown()
end

function Keybinds:Initialize()
    self:OnSettingChanged()
    if ns.db and ns.db.profile then
        ns.db.profile.keybindCache = nil
    end
end

function Keybinds:OnSettingChanged(viewerSettingName)
    local shouldBeEnabled = IsKeybindEnabledForAnyViewer()

    if shouldBeEnabled and not isModuleEnabled then
        self:Enable()
    elseif not shouldBeEnabled and isModuleEnabled then
        self:Disable()
    end

    -- Module remains enabled; update every viewer matching the changed setting (or all if unspecified)
    for viewerName, settingName in pairs(viewersSettingKey) do
        if not viewerSettingName or settingName == viewerSettingName then
            UpdateViewerKeybinds(viewerName, true, true)
        end
    end
end
