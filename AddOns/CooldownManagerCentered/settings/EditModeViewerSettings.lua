local _, ns = ...

local L = ns.L

-- EditModeViewerSettings -----------------------------------------------------------
-- Builds viewer-scoped settings lists for the in-edit-mode anchored panel
-- (see modules/editModeViewerSettings.lua). These are separate, hand-authored
-- LibEQOLEditMode setting tables that reuse the SAME db keys and refresh calls as
-- settings/AddonSettings.lua, so changing a value here behaves exactly like the
-- matching control in the full /cmc panel.
local EMVS = {}
ns.EditModeViewerSettings = EMVS

local LEM = ns.LibEQOL.EditMode
local LSM = LibStub("LibSharedMedia-3.0", true)
local ST = LEM.SettingType

local db = function()
    return ns.db.profile
end

-- Refresh helpers (mirror AddonSettings.lua) ---------------------------------------
local function refreshIcons()
    if ns.StyledIcons then
        ns.StyledIcons:OnSettingChanged()
    end
end
local function refreshBuffBars()
    ns.BuffBarStyle:RefreshAll()
end
local function refreshCDM()
    if ns.API then
        ns.API:RefreshCooldownManager()
    end
end
local function refreshFont()
    if ns.CooldownFont then
        ns.CooldownFont:RefreshAll()
    end
    if ns.TrackerItemViewer then
        ns.TrackerItemViewer:RefreshStyling()
    end
end
local function refreshStyle()
    if ns.CooldownStyle and ns.CooldownStyle.RefreshHooks then
        ns.CooldownStyle:RefreshHooks()
    end
end
local function refreshStacks(viewerFrame)
    if ns.Stacks then
        ns.Stacks:ApplyStackFonts(viewerFrame)
    end
end
-- Widget constructors --------------------------------------------------------------
-- Each returns a LibEQOLEditMode setting table; callers attach parentId/isShown.

local function makeArray(valuesMap, order)
    local out = {}
    for _, key in ipairs(order) do
        out[#out + 1] = { value = key, text = valuesMap[key], label = valuesMap[key] }
    end
    return out
end

local function section(list, id, name, expanded)
    list[#list + 1] = { kind = ST.Collapsible, id = id, name = name, defaultCollapsed = not expanded }
    return id
end

local function header(list, name)
    list[#list + 1] = { kind = ST.Header, name = name }
end

local function add(list, data, parentId)
    data.parentId = parentId
    list[#list + 1] = data
    return data
end

-- Checkbox bound to a single boolean profile key.
local function checkbox(o)
    return {
        kind = ST.Checkbox,
        name = o.name,
        tooltip = o.desc,
        default = o.default or false,
        isShown = o.isShown,
        get = o.get or function()
            return db()[o.key]
        end,
        set = o.set or function(_, value)
            db()[o.key] = value
            if o.apply then
                o.apply(value)
            end
        end,
    }
end

-- Radio dropdown bound to a single profile key.
local function dropdown(o)
    return {
        kind = ST.Dropdown,
        name = o.name,
        tooltip = o.desc,
        default = o.default,
        values = o.values,
        height = o.height,
        isShown = o.isShown,
        get = o.get or function()
            return db()[o.key] or o.default
        end,
        set = o.set or function(_, value)
            db()[o.key] = value
            if o.apply then
                o.apply(value)
            end
        end,
    }
end

-- Multi-select dropdown bound to a profile key holding a selection map.
local function multidropdown(o)
    return {
        kind = ST.MultiDropdown,
        name = o.name,
        tooltip = o.desc,
        customText = o.customText,
        values = o.values,
        height = o.height,
        isShown = o.isShown,
        get = o.get,
        set = o.set,
    }
end

-- Shared value tables (mirror AddonSettings.lua) -----------------------------------
local ANCHOR_VALUES = {
    TOPLEFT = L["Top Left"],
    TOP = L["Top"],
    TOPRIGHT = L["Top Right"],
    LEFT = L["Left"],
    RIGHT = L["Right"],
    BOTTOMLEFT = L["Bottom Left"],
    BOTTOM = L["Bottom"],
    BOTTOMRIGHT = L["Bottom Right"],
}
local ANCHOR_ORDER = { "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }
local ANCHOR_ARRAY = makeArray(ANCHOR_VALUES, ANCHOR_ORDER)

local KEYBIND_ANCHOR_VALUES = {
    TOPLEFT = L["Top Left"],
    TOP = L["Top"],
    TOPRIGHT = L["Top Right"],
    LEFT = L["Left"],
    CENTER = L["Center"],
    RIGHT = L["Right"],
    BOTTOMLEFT = L["Bottom Left"],
    BOTTOM = L["Bottom"],
    BOTTOMRIGHT = L["Bottom Right"],
}
local KEYBIND_ANCHOR_ORDER = { "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }
local KEYBIND_ANCHOR_ARRAY = makeArray(KEYBIND_ANCHOR_VALUES, KEYBIND_ANCHOR_ORDER)

local FONT_FLAG_VALUES = { OUTLINE = L["Outline"], THICKOUTLINE = L["Thick Outline"], MONOCHROME = L["Monochrome"], SLUG = L["Slug"] }
local FONT_FLAG_ORDER = { "MONOCHROME", "OUTLINE", "THICKOUTLINE", "SLUG" }
local FONT_FLAG_ARRAY = makeArray(FONT_FLAG_VALUES, FONT_FLAG_ORDER)

local VISIBILITY_RULE_VALUES = {
    SHOW_IN_COMBAT = L["Always show in Combat"],
    SHOW_IN_INSTANCE = L["Always show in Instances"],
    HIDE_IN_VEHICLES = L["Hide in Vehicles & Mini-games"],
    ALWAYS_HIDE_WHEN_FLYING = L["Always hide when Flying"],
    SHOW_WITH_ENEMY_TARGET = L["Show with Enemy Target"],
    SHOW_WITH_TARGET = L["Show with any Target"],
    HIDE_WHEN_FLYING = L["Hide when Flying"],
    HIDE_WHEN_NOT_FLYING = L["Hide when not Flying"],
    HIDE_WHEN_MOUNTED = L["Hide when Mounted & Travel Form"],
    HIDE_WHEN_RESTING = L["Hide when Resting"],
    HIDE_OUT_OF_COMBAT = L["Hide out of Combat"],
}
local VISIBILITY_RULE_ORDER = {
    "SHOW_IN_COMBAT",
    "SHOW_IN_INSTANCE",
    "HIDE_IN_VEHICLES",
    "ALWAYS_HIDE_WHEN_FLYING",
    "SHOW_WITH_ENEMY_TARGET",
    "SHOW_WITH_TARGET",
    "HIDE_WHEN_FLYING",
    "HIDE_WHEN_NOT_FLYING",
    "HIDE_WHEN_MOUNTED",
    "HIDE_WHEN_RESTING",
    "HIDE_OUT_OF_COMBAT",
}
local VISIBILITY_RULE_ARRAY = makeArray(VISIBILITY_RULE_VALUES, VISIBILITY_RULE_ORDER)

-- Cooldown font size options (with Default / Hide entries).
local COOLDOWN_SIZE_ARRAY = {
    { value = "NIL", text = L["Default"], label = L["Default"] },
    { value = "0", text = L["Hide"], label = L["Hide"] },
}
for size = 10, 38, 2 do
    COOLDOWN_SIZE_ARRAY[#COOLDOWN_SIZE_ARRAY + 1] = { value = tostring(size), text = tostring(size), label = tostring(size) }
end

-- Stack font size options ("Don't change" + sizes).
local STACK_SIZE_ARRAY = { { value = "NIL", text = L["Don't change"], label = L["Don't change"] } }
for size = 10, 38, 2 do
    STACK_SIZE_ARRAY[#STACK_SIZE_ARRAY + 1] = { value = tostring(size), text = tostring(size), label = tostring(size) }
end

-- Keybind font size options (no "Don't change").
local KEYBIND_SIZE_ARRAY = {}
for size = 6, 32, 2 do
    KEYBIND_SIZE_ARRAY[#KEYBIND_SIZE_ARRAY + 1] = { value = tostring(size), text = tostring(size), label = tostring(size) }
end

local BUFF_BAR_FONT_SIZE_ARRAY = {}
for size = 8, 24 do
    BUFF_BAR_FONT_SIZE_ARRAY[#BUFF_BAR_FONT_SIZE_ARRAY + 1] = { value = tostring(size), text = tostring(size), label = tostring(size) }
end

local function fontNameArray()
    local arr = { { value = "NIL", text = L["Default font"], label = L["Default font"] } }
    if not LSM then
        return arr
    end
    local fonts = LSM:HashTable(LSM.MediaType.FONT)
    local sorted = {}
    for name in pairs(fonts) do
        if name ~= "" then
            sorted[#sorted + 1] = name
        end
    end
    table.sort(sorted)
    for _, name in ipairs(sorted) do
        arr[#arr + 1] = { value = name, text = name, label = name, fontPath = fonts[name] }
    end
    return arr
end

local function statusBarNameArray()
    local arr = { { value = "NIL", text = L["Default"], label = L["Default"] } }
    local textures = LSM:HashTable(LSM.MediaType.STATUSBAR)
    local sorted = {}
    for name in pairs(textures) do
        sorted[#sorted + 1] = name
    end
    table.sort(sorted)
    for _, name in ipairs(sorted) do
        arr[#arr + 1] = { value = name, text = name, label = name }
    end
    return arr
end

local function pct(value)
    return string.format("%.0f%%", (value or 0) * 100)
end
-- Section builders -----------------------------------------------------------------

-- "Grow / Alignment" direction dropdown for the viewer (per-viewer key).
local function buildGrowDirection(list, cfg, parentId)
    if not cfg.growKey then
        return
    end
    local values
    if cfg.scope == "BuffBar" then
        values = {
            { value = "TOP", text = L["Bars grow from Top"] },
            { value = "BOTTOM", text = L["Bars grow from Bottom"] },
            { value = "Disable", text = L["Disable centering"] },
        }
    else
        local frame = _G[cfg.frame]
        local horizontal = frame and frame.isHorizontal
        if cfg.scope == "BuffIcons" then
            values = {
                { value = "START", text = L["Grow from the Start"] },
                { value = "CENTER", text = L["Grow from Center"] },
                { value = "END", text = L["Grow from the End"] },
                { value = "Disable", text = L["Disable centering"] },
            }
        else
            values = {
                {
                    value = "TOP",
                    text = horizontal and L["New Rows Below"] or L["New Columns to the Right"],
                },
                {
                    value = "BOTTOM",
                    text = horizontal and L["New Rows on Top"] or L["New Columns to the Left"],
                },
                { value = "Disable", text = L["Disable centering"] },
            }
        end
    end
    add(list, dropdown({
        name = L["Alignment"],
        key = cfg.growKey,
        default = cfg.growDefault,
        values = values,
        apply = refreshCDM,
        desc = L["Dynamic alignment direction inside the viewer container."],
    }), parentId)
end

-- Icon styling: square / border / zoom / rectangular (+ normalize for Utility).
local function buildIconStyling(list, cfg)
    if not cfg.icon then
        return
    end
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return
    end
    local id = header(list, L["Icon Styling"])
    local squareKey = "cooldownManager_squareIcons_" .. cfg.scope
    local borderKey = "cooldownManager_squareIconsBorder_" .. cfg.scope
    local zoomKey = "cooldownManager_squareIconsZoom_" .. cfg.scope
    add(list, {
        kind = ST.CompactFont,
        name = L["Square Icons"],
        detailsOnly = true,
        tooltip = L["Apply square icon styling to this viewer. Use the cog for border and zoom."],
        getEnabled = function()
            return db()[squareKey] and true or false
        end,
        setEnabled = function(_, value)
            db()[squareKey] = value
            refreshIcons()
        end,
        details = {
            title = L["Icon Styling"],
            sliders = {
                {
                    label = L["Border"],
                    min = 0,
                    max = 6,
                    step = 1,
                    get = function()
                        return db()[borderKey] or 4
                    end,
                    set = function(value)
                        db()[borderKey] = value
                    end,
                },
                {
                    label = L["Zoom"],
                    min = 0,
                    max = 0.5,
                    step = 0.01,
                    get = function()
                        return db()[zoomKey] or 0
                    end,
                    set = function(value)
                        db()[zoomKey] = value
                    end,
                },
            },
            onChanged = refreshIcons,
        },
    }, id)

    local rectKey = "cooldownManager_experimental_enableRectangularIcons_" .. cfg.lower
    add(list, {
        kind = ST.CompactFont,
        name = L["Rectangular Ratio"],
        detailsOnly = true,
        tooltip = L["Enable rectangular icons. Experimental feature; may cause issues. Use the cog to adjust the height-to-width ratio."],
        getEnabled = function()
            return db()[rectKey] and true or false
        end,
        setEnabled = function(_, value)
            db()[rectKey] = value
            refreshIcons()
        end,
        details = {
            title = L["Rectangular Ratio"],
            sliders = {
                {
                    label = L["Ratio"],
                    min = 0.6,
                    max = 0.9,
                    step = 0.01,
                    editable = false,
                    formatter = function(value)
                        return string.format("%.2f", value)
                    end,
                    get = function()
                        return db()[rectKey .. "_percent"] or 0.8
                    end,
                    set = function(value)
                        db()[rectKey .. "_percent"] = math.floor((value or 0.8) * 100 + 0.5) / 100
                    end,
                },
            },
            onChanged = refreshIcons,
        },
    }, id)

    if cfg.normalize then
        add(
            list,
            checkbox({
                name = L["Normalize Utility Icons Scaling"],
                key = "cooldownManager_normalizeUtilitySize",
                desc = L["Use Essential Cooldowns base icon size for Utility icons for a uniform look."],
                apply = refreshIcons,
            }),
            id
        )
    end
end

local function buildBuffBarStyling(list, cfg)
    if not cfg.buffBar then
        return
    end

    list[#list + 1] = dropdown({
        name = L["Bar Texture"],
        key = "cooldownManager_buffBarTexture",
        default = "NIL",
        values = statusBarNameArray(),
        height = 360,
        apply = refreshBuffBars,
        desc = L["Texture used by tracked buff bars."],
    })
    list[#list + 1] = checkbox({
        name = L["Swap Icon Position"],
        key = "cooldownManager_buffBarSwapIconPosition",
        apply = refreshBuffBars,
        desc = L["Anchor the icon on the right side of the bar."],
    })
    list[#list + 1] = checkbox({
        name = L["Higher Bars"],
        key = "cooldownManager_buffBarHigherBars",
        apply = refreshBuffBars,
        desc = L["Match the bar height to the icon height."],
    })

    add(list, {
        kind = ST.CompactFont,
        name = L["Square Style"],
        detailsOnly = true,
        tooltip = L["Square the icon and bar. Use the cog for icon zoom and separate borders."],
        getEnabled = function()
            return db().cooldownManager_squareIcons_BuffBar and true or false
        end,
        setEnabled = function(_, value)
            db().cooldownManager_squareIcons_BuffBar = value
            refreshBuffBars()
        end,
        details = {
            title = L["Square Style"],
            sliders = {
                {
                    label = L["Icon Border"],
                    min = 0,
                    max = 6,
                    step = 1,
                    get = function()
                        return db().cooldownManager_squareIconsBorder_BuffBar or 1
                    end,
                    set = function(value)
                        db().cooldownManager_squareIconsBorder_BuffBar = value
                    end,
                },
                {
                    label = L["Bar Border"],
                    min = 0,
                    max = 6,
                    step = 1,
                    get = function()
                        return db().cooldownManager_buffBarBorder or 1
                    end,
                    set = function(value)
                        db().cooldownManager_buffBarBorder = value
                    end,
                },
                {
                    label = L["Icon Zoom"],
                    min = 0,
                    max = 0.5,
                    step = 0.01,
                    get = function()
                        return db().cooldownManager_squareIconsZoom_BuffBar or 0
                    end,
                    set = function(value)
                        db().cooldownManager_squareIconsZoom_BuffBar = value
                    end,
                },
            },
            onChanged = refreshBuffBars,
        },
    })

    add(list, {
        kind = ST.CompactFont,
        name = L["Name & Duration"],
        tooltip = L["Override the tracked buff bar font."],
        values = BUFF_BAR_FONT_SIZE_ARRAY,
        getEnabled = function()
            return db().cooldownManager_buffBarFontEnabled and true or false
        end,
        setEnabled = function(_, value)
            db().cooldownManager_buffBarFontEnabled = value
            refreshBuffBars()
        end,
        getSize = function()
            return tostring(db().cooldownManager_buffBarFontSize or 12)
        end,
        setSize = function(_, value)
            db().cooldownManager_buffBarFontSize = tonumber(value)
            refreshBuffBars()
        end,
        details = {
            title = L["Name & Duration"],
            fontLabel = L["Font"],
            flagsLabel = L["Font Flags"],
            fontOptions = fontNameArray,
            flagOptions = FONT_FLAG_ARRAY,
            getFont = function()
                return db().cooldownManager_buffBarFontName or "NIL"
            end,
            setFont = function(value)
                db().cooldownManager_buffBarFontName = value
            end,
            getFlags = function()
                return db().cooldownManager_buffBarFontFlags or {}
            end,
            setFlags = function(value)
                db().cooldownManager_buffBarFontFlags = value
            end,
            onChanged = refreshBuffBars,
        },
    })
end

-- Cooldown number font (shared name/flags + per-viewer size).
local function buildCooldownFont(list, cfg)
    if not cfg.icon then
        return
    end
    local id = header(list, L["Cooldown"])
    local enabledKey = "cooldownManager_cooldownFontSize" .. cfg.scope .. "_enabled"
    local sizeKey = "cooldownManager_cooldownFontSize" .. cfg.scope
    local offXKey = "cooldownManager_cooldownText" .. cfg.scope .. "_offsetX"
    local offYKey = "cooldownManager_cooldownText" .. cfg.scope .. "_offsetY"

    add(list, {
        kind = ST.CompactFont,
        name = L["Override"],
        tooltip = L["Override cooldown text for this viewer. Use the cog for font and position."],
        values = COOLDOWN_SIZE_ARRAY,
        getEnabled = function()
            return db()[enabledKey] and true or false
        end,
        setEnabled = function(_, value)
            db()[enabledKey] = value
            refreshFont()
        end,
        getSize = function()
            local value = db()[sizeKey]
            return value ~= nil and tostring(value) or "NIL"
        end,
        setSize = function(_, value)
            db()[sizeKey] = value == "NIL" and "NIL" or tonumber(value)
            refreshFont()
        end,
        details = {
            title = L["Cooldown"],
            fontLabel = L["Font (all viewers)"],
            flagsLabel = L["Font Flags (all viewers)"],
            fontOptions = fontNameArray,
            flagOptions = FONT_FLAG_ARRAY,
            getFont = function()
                local value = db().cooldownManager_cooldownFontName
                return value and value ~= "" and value or "NIL"
            end,
            setFont = function(value)
                db().cooldownManager_cooldownFontName = value
            end,
            getFlags = function()
                return db().cooldownManager_cooldownFontFlags or {}
            end,
            setFlags = function(value)
                if value.OUTLINE or value.THICKOUTLINE or value.MONOCHROME or value.SLUG then
                    db().cooldownManager_cooldownFontFlags = value
                else
                    db().cooldownManager_cooldownFontFlags = { OUTLINE = false }
                end
            end,
            getX = function()
                return db()[offXKey] or 0
            end,
            setX = function(value)
                db()[offXKey] = value
            end,
            getY = function()
                return db()[offYKey] or 0
            end,
            setY = function(value)
                db()[offYKey] = value
            end,
            onChanged = refreshFont,
        },
    }, id)
end

-- Stack number anchor / size / offsets (per viewer).
local function buildStacks(list, cfg)
    if not cfg.stacks then
        return
    end
    local id = header(list, L["Charges"])
    local enabledKey = "cooldownManager_stackAnchor" .. cfg.scope .. "_enabled"
    local pointKey = "cooldownManager_stackAnchor" .. cfg.scope .. "_point"
    local sizeKey = "cooldownManager_stackFontSize" .. cfg.scope
    local offXKey = "cooldownManager_stackAnchor" .. cfg.scope .. "_offsetX"
    local offYKey = "cooldownManager_stackAnchor" .. cfg.scope .. "_offsetY"

    local function refreshStackFont()
        if ns.Stacks then
            ns.Stacks:RefreshAll()
        end
        if ns.TrackerItemViewer then
            ns.TrackerItemViewer:RefreshStyling()
        end
    end

    add(list, {
        kind = ST.CompactFont,
        name = L["Override"],
        tooltip = L["Override charge text for this viewer. Use the cog for font, anchor and position."],
        values = STACK_SIZE_ARRAY,
        getEnabled = function()
            return db()[enabledKey] and true or false
        end,
        setEnabled = function(_, value)
            db()[enabledKey] = value
            refreshStacks(cfg.frame)
        end,
        getSize = function()
            local value = db()[sizeKey]
            return value ~= nil and tostring(value) or "NIL"
        end,
        setSize = function(_, value)
            local number = tonumber(value)
            db()[sizeKey] = value == "NIL" and nil or (number and math.floor(number + 0.5) or nil)
            refreshStacks(cfg.frame)
        end,
        details = {
            title = L["Charges"],
            anchorOptions = ANCHOR_ARRAY,
            getAnchor = function()
                return db()[pointKey] or "BOTTOMRIGHT"
            end,
            setAnchor = function(value)
                db()[pointKey] = value
            end,
            fontLabel = L["Font (all viewers)"],
            flagsLabel = L["Font Flags (all viewers)"],
            fontOptions = fontNameArray,
            flagOptions = FONT_FLAG_ARRAY,
            getFont = function()
                local value = db().cooldownManager_stackFontName
                return value and value ~= "" and value or "NIL"
            end,
            setFont = function(value)
                db().cooldownManager_stackFontName = value
            end,
            getFlags = function()
                return db().cooldownManager_stackFontFlags or {}
            end,
            setFlags = function(value)
                if value.OUTLINE or value.THICKOUTLINE or value.MONOCHROME or value.SLUG then
                    db().cooldownManager_stackFontFlags = value
                else
                    db().cooldownManager_stackFontFlags = { OUTLINE = false }
                end
            end,
            getX = function()
                return db()[offXKey] or 0
            end,
            setX = function(value)
                db()[offXKey] = value
            end,
            getY = function()
                return db()[offYKey] or 0
            end,
            setY = function(value)
                db()[offYKey] = value
            end,
            onChanged = refreshStackFont,
        },
    }, id)
end

local function buildKeybinds(list, cfg)
    if not cfg.keybind then
        return
    end
    local id = header(list, L["Keybinds"])
    local showKey = "cooldownManager_showKeybinds_" .. cfg.scope
    local anchorKey = "cooldownManager_keybindAnchor_" .. cfg.scope
    local sizeKey = "cooldownManager_keybindFontSize_" .. cfg.scope
    local offXKey = "cooldownManager_keybindOffsetX_" .. cfg.scope
    local offYKey = "cooldownManager_keybindOffsetY_" .. cfg.scope

    local function refreshAllKeybinds()
        if ns.Keybinds then
            ns.Keybinds:OnSettingChanged()
        end
    end

    add(list, {
        kind = ST.CompactFont,
        name = L["Show Keybinds"],
        detailsOnly = true,
        tooltip = L["Show keybind text on this viewer. Use the cog for typography and position."],
        getEnabled = function()
            return db()[showKey] and true or false
        end,
        setEnabled = function(_, value)
            db()[showKey] = value
            if ns.Keybinds then
                ns.Keybinds:OnSettingChanged(cfg.scope)
            end
        end,
        details = {
            title = L["Keybinds"],
            fontOptions = fontNameArray,
            flagOptions = FONT_FLAG_ARRAY,
            getFont = function()
                local value = db().cooldownManager_keybindFontName
                return value and value ~= "" and value or "NIL"
            end,
            setFont = function(value)
                db().cooldownManager_keybindFontName = value
                -- Repaint immediately from the setter itself, so the new font
                -- always shows even if the widget's onChanged callback is not
                -- invoked for the font/flag radios.
                refreshAllKeybinds()
            end,
            getFlags = function()
                return db().cooldownManager_keybindFontFlags or {}
            end,
            setFlags = function(value)
                if value.OUTLINE or value.THICKOUTLINE or value.MONOCHROME or value.SLUG then
                    db().cooldownManager_keybindFontFlags = value
                else
                    db().cooldownManager_keybindFontFlags = { OUTLINE = false }
                end
                refreshAllKeybinds()
            end,
            anchorOptions = KEYBIND_ANCHOR_ARRAY,
            getAnchor = function()
                return db()[anchorKey] or "TOPRIGHT"
            end,
            setAnchor = function(value)
                db()[anchorKey] = value
                refreshAllKeybinds()
            end,
            sliders = {
                {
                    label = L["Size"],
                    min = 6,
                    max = 32,
                    step = 2,
                    get = function()
                        return db()[sizeKey] or 14
                    end,
                    set = function(value)
                        db()[sizeKey] = math.floor((value or 14) + 0.5)
                        refreshAllKeybinds()
                    end,
                },
            },
            getX = function()
                return db()[offXKey] or -3
            end,
            setX = function(value)
                db()[offXKey] = value
                refreshAllKeybinds()
            end,
            getY = function()
                return db()[offYKey] or -3
            end,
            setY = function(value)
                db()[offYKey] = value
                refreshAllKeybinds()
            end,
            onChanged = refreshAllKeybinds,
        },
    }, id)
end

local function buildTweaks(list, cfg, parentId)
    if not cfg.tweaks then
        return
    end
    add(
        list,
        checkbox({
            name = L["Hide GCD"],
            key = "cooldownManager_hide_gcd",
            desc = L["Hide the GCD cooldown spiral on cooldown icons."],
            apply = refreshStyle,
        }),
        parentId
    )
    add(
        list,
        checkbox({
            name = L["Hide cooldown flash"],
            key = "cooldownManager_hideCooldownFlash",
            desc = L["Hide the bright flash when an ability comes off cooldown."],
            apply = refreshStyle,
        }),
        parentId
    )
    add(
        list,
        checkbox({
            name = L["Hide Range Check"],
            key = "cooldownManager_hideRangeCheck",
            desc = L["Stop icons from dimming when the target is out of range."],
            apply = function()
                if ns.RangeCheck then
                    ns.RangeCheck:RefreshAll()
                end
            end,
        }),
        parentId
    )
    add(
        list,
        checkbox({
            name = L["Desaturate Icon Under Aura"],
            key = "cooldownManager_desaturate_under_aura",
            desc = L["Desaturate cooldown icons when there is an active Aura for that ability."],
            apply = refreshStyle,
        }),
        parentId
    )
    add(
        list,
        checkbox({
            name = L["Rotation Highlight on CDM"],
            desc = L["Show a border when an ability is suggested by the rotation helper."],
            get = function()
                return db().cooldownManager_showHighlight_Essential and db().cooldownManager_showHighlight_Utility
            end,
            set = function(_, value)
                db().cooldownManager_showHighlight_Essential = value
                db().cooldownManager_showHighlight_Utility = value
                if ns.Assistant then
                    ns.Assistant:OnSettingChanged("Essential")
                    ns.Assistant:OnSettingChanged("Utility")
                end
            end,
        }),
        parentId
    )
end

local function buildUtilityWidth(list, cfg, parentId)
    if cfg.scope ~= "Utility" then
        return
    end
    add(list, checkbox({
        name = L["Sync Utility width to Essential"],
        key = "cooldownManager_limitUtilitySizeToEssential",
        desc = L["Limit Utility width to the width of Essential."],
        apply = function()
            ns.CooldownManager.ForceRefreshAll()
        end,
    }), parentId)
end

local function buildUtilityReadyState(list, cfg, parentId)
    if cfg.scope ~= "Utility" then
        return
    end
    add(list, {
        kind = ST.CompactFont,
        name = L["Dim/Hide when not on CD"],
        detailsOnly = true,
        tooltip = L["Dim Utility icons when ready. Use the cog to set opacity. Higher CPU usage."],
        getEnabled = function()
            return db().cooldownManager_utility_dimWhenNotOnCD and true or false
        end,
        setEnabled = function(_, value)
            db().cooldownManager_utility_dimWhenNotOnCD = value
            ns.CooldownManager.ForceRefresh({ utility = true })
            if not value then
                ns.CooldownManager.RestoreUtilityAlpha()
            end
        end,
        details = {
            title = L["Opacity (Hiding on 0%)"],
            sliders = {
                {
                    label = "%",
                    min = 0,
                    max = 0.9,
                    step = 0.05,
                    editable = false,
                    formatter = pct,
                    get = function()
                        return db().cooldownManager_utility_dimOpacity or 0.3
                    end,
                    set = function(value)
                        db().cooldownManager_utility_dimOpacity = value
                        ns.CooldownManager.ForceRefresh({ utility = true })
                    end,
                },
            },
        },
    }, parentId)
end
local function openAdvancedCooldownSettings(target)
    if InCombatLockdown() then
        return
    end
    if EditModeManagerFrame and EditModeManagerFrame:IsShown() then
        ns.API:ToggleEditMode()
    end
    C_Timer.After(0, function()
        if not CooldownViewerSettings then
            return
        end
        if ns.SettingsTabs then
            ns.SettingsTabs:DeactivateAll()
        end
        CooldownViewerSettings:ShowUIPanel(false)
        C_Timer.After(0, function()
            if CooldownViewerSettings and not CooldownViewerSettings:IsShown() then
                ns.API:LogWarn(ns.API.Error.SettingsOpenViewer, "EditModeViewerSettings: CooldownViewerSettings did not open")
            end
        end)
        if target == "tracker" and ns.TrackerAssignmentPanel and ns.TrackerAssignmentPanel.ShowSettings then
            C_Timer.After(0, function()
                ns.TrackerAssignmentPanel:ShowSettings()
            end)
            return
        end
        if target == "buffs" and ns.BuffAssignmentPanel and ns.BuffAssignmentPanel.ShowSettings then
            C_Timer.After(0, function()
                ns.BuffAssignmentPanel:ShowSettings()
            end)
            return
        end
    end)
end

function EMVS:BuildAdvancedSettingsButton(target)
    return {
        kind = ST.Button,
        text = L["Advanced Cooldown Settings"],
        click = function()
            openAdvancedCooldownSettings(target)
        end,
    }
end
-- Shared cooldown-number font controls (the font name & flags are global, so
-- these edit the same keys as the viewers). Exposed so custom trackers can embed
-- identical controls. opts = { parentId, isShown }.
function EMVS:BuildCooldownFontNameSetting(opts)
    opts = opts or {}
    return {
        kind = ST.FontPicker,
        name = opts.name or L["Font"],
        parentId = opts.parentId,
        isShown = opts.isShown,
        values = fontNameArray(),
        get = function()
            if opts.get then
                return opts.get()
            end
            local v = db().cooldownManager_cooldownFontName
            if not v or v == "NIL" then
                return "NIL"
            end
            return v
        end,
        set = function(_, value)
            if opts.set then
                opts.set(value)
                return
            end
            db().cooldownManager_cooldownFontName = value
            refreshFont()
        end,
        getLabel = function(value)
            if not value or value == "NIL" then
                return L["Default font"]
            end
            return value
        end,
        desc = opts.desc or L["Font for ability cooldown numbers shared across native viewers."],
    }
end

function EMVS:BuildCompactSliderSetting(data)
    data = data or {}
    data.kind = ST.CompactSlider
    return data
end

function EMVS:BuildCooldownFontFlagsSetting(opts)
    opts = opts or {}
    return {
        kind = ST.MultiDropdown,
        name = opts.name or L["Font Flags"],
        customText = L["No Flags"],
        parentId = opts.parentId,
        isShown = opts.isShown,
        values = FONT_FLAG_ARRAY,
        get = function()
            if opts.get then
                return opts.get()
            end
            return db().cooldownManager_cooldownFontFlags or {}
        end,
        set = function(_, value)
            if opts.set then
                opts.set(value)
                return
            end
            if value.OUTLINE or value.THICKOUTLINE or value.MONOCHROME or value.SLUG then
                db().cooldownManager_cooldownFontFlags = value
            else
                db().cooldownManager_cooldownFontFlags = { OUTLINE = false }
            end
            refreshFont()
        end,
    }
end

-- Build the Show/Hide visibility-rules control for a frame. Exposed on EMVS so
-- custom trackers can embed the same control in their own Edit Mode settings.
function EMVS:BuildVisibilitySetting(frameName)
    return multidropdown({
        name = L["Visibility"],
        customText = L["No rules (always visible)"],
        height = 340,
        values = VISIBILITY_RULE_ARRAY,
        get = function()
            local perViewer = db().cooldownManager_visibility_perViewer
            return (perViewer and perViewer[frameName]) or {}
        end,
        set = function(_, value)
            if not db().cooldownManager_visibility_perViewer then
                db().cooldownManager_visibility_perViewer = {}
            end
            db().cooldownManager_visibility_perViewer[frameName] = value
            if ns.CMCVisibility then
                ns.CMCVisibility:Initialize({ [frameName] = true })
            end
        end,
    })
end

-- Visibility rules live in General for the native cooldown viewers and remain a
-- standalone row for the smaller buff panels.
local function buildVisibility(list, cfg, parentId)
    add(list, EMVS:BuildVisibilitySetting(cfg.frame), parentId)
end

local function buildGeneral(list, cfg)
    local id = section(list, "general", L["General"], true)
    buildGrowDirection(list, cfg, id)
    buildUtilityWidth(list, cfg, id)
    buildVisibility(list, cfg, id)
    buildUtilityReadyState(list, cfg, id)
    buildTweaks(list, cfg, id)
end

-- Native viewers use the same user-facing anchor controls as custom CMC frames.
-- They are written to Blizzard's Edit Mode layout only after Edit Mode closes.
local function buildNativeAnchor(list, cfg)
    if not cfg.nativeAnchorKey or not ns.Anchoring then
        return
    end
    local settings = ns.Anchoring:BuildSettings(cfg.nativeAnchorKey, {
        selfFrameName = cfg.frame,
        onChanged = refreshCDM,
    })
    for _, setting in ipairs(settings) do
        list[#list + 1] = setting
    end
end

-- Per-viewer configuration ---------------------------------------------------------
local CONFIG = {
    EssentialCooldownViewer = {
        frame = "EssentialCooldownViewer",
        scope = "Essential",
        lower = "essential",
        title = L["Essential Cooldowns"],
        growKey = "cooldownManager_centerEssential_growFromDirection",
        growDefault = "TOP",
        nativeAnchorKey = "nativeEssential",
        icon = true,
        stacks = true,
        keybind = true,
        tweaks = true,
    },
    UtilityCooldownViewer = {
        frame = "UtilityCooldownViewer",
        scope = "Utility",
        lower = "utility",
        title = L["Utility Cooldowns"],
        growKey = "cooldownManager_centerUtility_growFromDirection",
        growDefault = "TOP",
        nativeAnchorKey = "nativeUtility",
        icon = true,
        stacks = true,
        keybind = true,
        tweaks = true,
        normalize = true,
    },
    BuffIconCooldownViewer = {
        frame = "BuffIconCooldownViewer",
        scope = "BuffIcons",
        lower = "buffIcons",
        title = L["Tracked Buff Icons"],
        growKey = "cooldownManager_alignBuffIcons_growFromDirection",
        growDefault = "CENTER",
        nativeAnchorKey = "nativeBuffIcons",
        icon = true,
        stacks = true,
        keybind = false,
        tweaks = false,
    },
    BuffBarCooldownViewer = {
        frame = "BuffBarCooldownViewer",
        scope = "BuffBar",
        title = L["Tracked Buff Bars"],
        growKey = "cooldownManager_alignBuffBars_growFromDirection",
        growDefault = "BOTTOM",
        nativeAnchorKey = "nativeBuffBar",
        buffBar = true,
        icon = false,
        stacks = false,
        keybind = false,
        tweaks = false,
    },
}

function EMVS:IsViewer(frameName)
    return CONFIG[frameName] ~= nil
end

function EMVS:GetTitle(frameName)
    local cfg = CONFIG[frameName]
    return cfg and cfg.title or frameName
end

-- Build the ordered LibEQOLEditMode setting list for a viewer frame name.
function EMVS:BuildForViewer(frameName)
    local cfg = CONFIG[frameName]
    if not cfg then
        return nil
    end
    local list = {}
    if cfg.tweaks then
        buildGeneral(list, cfg)
    else
        buildGrowDirection(list, cfg)
        buildVisibility(list, cfg)
    end
    buildIconStyling(list, cfg)
    buildBuffBarStyling(list, cfg)
    buildCooldownFont(list, cfg)
    -- Overlay colors are configured from the main addon settings cogwheel.
    buildStacks(list, cfg)
    buildKeybinds(list, cfg)
    buildNativeAnchor(list, cfg)
    local advancedTarget = (frameName == "EssentialCooldownViewer" or frameName == "UtilityCooldownViewer") and "spells" or "auras"
    add(list, self:BuildAdvancedSettingsButton(advancedTarget))
    return list
end
