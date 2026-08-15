-- Per-tracker Edit Mode settings (LEM) for custom trackers.
-- Built once per tracker in TrackerInstance:Create and registered with LibEQOL
-- Edit Mode. Kept out of TrackerItemViewer so the viewer stays runtime-only.
local _, ns = ...
local L = ns.L

local LEM = ns.LibEQOL.EditMode
local WilduUICore = ns.WilduUICore
local tinsert = table.insert

local TrackerItemSettings = {}
ns.TrackerItemSettings = TrackerItemSettings

local function GetConfigValue(configKey, key, default)
    if ns.db and ns.db.profile and ns.db.profile.editMode and ns.db.profile.editMode[configKey] then
        return ns.db.profile.editMode[configKey][key] or default
    end
    return default
end

local function GetTrackerStyleValue(configKey, key, default)
    local editMode = ns.db and ns.db.profile and ns.db.profile.editMode
    local config = editMode and editMode[configKey]
    if config and config[key] ~= nil then
        return config[key]
    end
    return default
end

function TrackerItemSettings:Register(instance, defaultConfig, onPositionChanged)
    local configKey = instance.configKey
    local anchor = instance.anchor

    local scaleSetting = WilduUICore.CreateScaleSetting(configKey, defaultConfig.scale, anchor, onPositionChanged)
    local strataSetting = WilduUICore.CreateStrataSetting(configKey, defaultConfig.strata, anchor)
    scaleSetting.parentId = "general"
    strataSetting.parentId = "general"

    local flowLimitSlider = {
        label = "#",
        min = 1,
        max = 20,
        step = 1,
        editable = true,
        enabled = function()
            return GetConfigValue(configKey, "flowLimitEnabled", false) == true
        end,
        get = function()
            return GetConfigValue(configKey, "flowLimit", defaultConfig.flowLimit)
        end,
        set = function(value)
            local v = math.floor((tonumber(value) or defaultConfig.flowLimit) + 0.5)
            if v < 1 then
                v = 1
            elseif v > 20 then
                v = 20
            end
            ns.db.profile.editMode[configKey].flowLimit = v
        end,
        formatter = function(value)
            return string.format("%d", value)
        end,
    }

    local additionalSettings = {
        {
            kind = LEM.SettingType.Collapsible,
            id = "general",
            name = L["General"],
            defaultCollapsed = false,
        },
        scaleSetting,
        strataSetting,
        {
            name = L["Icon Size"],
            parentId = "general",
            kind = LEM.SettingType.Slider,
            default = defaultConfig.iconSize,
            get = function()
                return ns.db.profile.editMode[configKey].iconSize or defaultConfig.iconSize
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].iconSize = value
                instance:UpdateIconLayout()
            end,
            minValue = 16,
            maxValue = 80,
            valueStep = 2,
            formatter = function(value)
                return string.format(L["%d px"], value)
            end,
        },
        {
            name = L["Icon Padding"],
            parentId = "general",
            kind = LEM.SettingType.Slider,
            default = defaultConfig.iconPadding,
            get = function()
                return ns.db.profile.editMode[configKey].iconPadding or defaultConfig.iconPadding
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].iconPadding = value
                instance:RefreshEntries()
            end,
            minValue = 0,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format(L["%d px"], value)
            end,
        },
        {
            name = L["Orientation"],
            parentId = "general",
            kind = LEM.SettingType.Dropdown,
            default = defaultConfig.orientation,
            get = function()
                return instance:GetOrientation()
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].orientation = value
                onPositionChanged(anchor, configKey)
                instance:RefreshEntries()
            end,
            values = {
                { value = "Horizontal Right", text = L["Horizontal Right"] },
                { value = "Horizontal Center", text = L["Horizontal Center"] },
                { value = "Horizontal Left", text = L["Horizontal Left"] },
                { value = "Vertical Center", text = L["Vertical Center"] },
                { value = "Vertical Down", text = L["Vertical Down"] },
                { value = "Vertical Up", text = L["Vertical Up"] },
            },
        },
        {
            name = L["Flow"],
            parentId = "general",
            kind = LEM.SettingType.CompactFont,
            detailsOnly = true,
            noCheckbox = true,
            getEnabled = function()
                return true
            end,
            details = {
                title = L["Flow"],
                onChanged = function()
                    instance:RefreshEntries()
                end,
                checkboxes = {
                    {
                        label = L["Limit row size"],
                        get = function()
                            return GetConfigValue(configKey, "flowLimitEnabled", false) == true
                        end,
                        set = function(value)
                            ns.db.profile.editMode[configKey].flowLimitEnabled = value == true
                        end,
                        onChanged = function()
                            instance:RefreshEntries()
                        end,
                        slider = flowLimitSlider,
                    },
                    {
                        label = L["Reverse flow"],
                        get = function()
                            return GetConfigValue(configKey, "flowReverse", false) == true
                        end,
                        set = function(value)
                            ns.db.profile.editMode[configKey].flowReverse = value == true
                        end,
                        afterSliders = true,
                    },
                },
                sliders = { flowLimitSlider },
            },
        },
        {
            name = L["Show GCD"],
            parentId = "general",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.editMode[configKey].showGCD or false
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].showGCD = value
                instance:RefreshEntries()
            end,
        },
        {
            name = L["Range Check"],
            parentId = "general",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.editMode[configKey].rangeIndicator or false
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].rangeIndicator = value
                instance:RefreshEntries()
            end,
        },
        {
            name = L["Usable Check"],
            parentId = "general",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.editMode[configKey].requireResource or false
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].requireResource = value
                instance:RefreshEntries()
            end,
        },
        {
            name = L["Show Tooltips"],
            parentId = "general",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return instance:GetShowTooltips()
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].showTooltips = value and true or false
                instance:RefreshTooltips()
            end,
        },
        {
            name = L["Hide abilities"],
            parentId = "general",
            kind = LEM.SettingType.CompactFont,
            detailsOnly = true,
            default = false,
            getEnabled = function()
                return GetConfigValue(configKey, "hideAbilities", false) == true
            end,
            setEnabled = function(_, value)
                ns.db.profile.editMode[configKey].hideAbilities = value == true
                instance:RefreshEntries()
            end,
            details = {
                title = L["Hide abilities"],
                onChanged = function()
                    instance:RefreshEntries()
                end,
                radios = {
                    {
                        label = L["Hide when ready"],
                        value = "whenReady",
                        get = function()
                            return GetConfigValue(configKey, "hideAbilitiesMode", defaultConfig.hideAbilitiesMode)
                        end,
                        set = function(value)
                            ns.db.profile.editMode[configKey].hideAbilitiesMode = value
                        end,
                    },
                    {
                        label = L["Hide on cooldown"],
                        value = "onCooldown",
                        get = function()
                            return GetConfigValue(configKey, "hideAbilitiesMode", defaultConfig.hideAbilitiesMode)
                        end,
                        set = function(value)
                            ns.db.profile.editMode[configKey].hideAbilitiesMode = value
                        end,
                    },
                },
            },
        },
    }

    -- Keep the most frequently used tracker controls together in General.
    if ns.EditModeViewerSettings and ns.EditModeViewerSettings.BuildVisibilitySetting then
        local visibilitySetting = ns.EditModeViewerSettings:BuildVisibilitySetting(instance.frameName)
        visibilitySetting.parentId = "general"
        tinsert(additionalSettings, 8, visibilitySetting)
    end

    -- Keep related numeric options behind one details cog, matching the native
    -- CDM "Square Icons" row instead of creating a cog for every slider.
    local function groupSlidersIntoCogwheel(settings, parentId, title, baseName, include)
        local base, sliders = nil, {}
        for _, setting in ipairs(settings) do
            if baseName and setting.parentId == parentId and setting.kind == LEM.SettingType.Checkbox and setting.name == baseName then
                base = base or setting
            elseif setting.parentId == parentId and setting.kind == LEM.SettingType.CompactSlider and (not include or include(setting)) then
                sliders[#sliders + 1] = setting
            end
        end
        if #sliders == 0 then
            return
        end

        local details = { title = title, sliders = {} }
        for _, source in ipairs(sliders) do
            details.sliders[#details.sliders + 1] = {
                label = source.name,
                min = source.minValue,
                max = source.maxValue,
                step = source.valueStep,
                editable = false,
                formatter = source.formatter,
                get = source.get,
                set = function(value)
                    source.set(nil, value)
                end,
            }
        end

        if base then
            local get = base.get
            local set = base.set
            base.kind = LEM.SettingType.CompactFont
            base.detailsOnly = true
            base.details = details
            base.getEnabled = function()
                return get() and true or false
            end
            base.setEnabled = function(_, value)
                set(nil, value)
            end
            base.get = nil
            base.set = nil
        else
            settings[#settings + 1] = {
                name = title,
                parentId = parentId,
                kind = LEM.SettingType.CompactFont,
                detailsOnly = true,
                noCheckbox = true,
                getEnabled = function()
                    return true
                end,
                details = details,
            }
        end

        for i = #settings, 1, -1 do
            local setting = settings[i]
            if setting.parentId == parentId and setting.kind == LEM.SettingType.CompactSlider and (not include or include(setting)) then
                table.remove(settings, i)
            end
        end
    end

    local function groupFontSettingsIntoCogwheel(settings, parentId, title, baseName, names)
        local base, sources = nil, {}
        for _, setting in ipairs(settings) do
            if setting.parentId == parentId then
                if setting.kind == LEM.SettingType.Checkbox and setting.name == baseName then
                    base = setting
                elseif names[setting.name] then
                    sources[setting.name] = setting
                end
            end
        end
        if not base then
            return
        end

        local function getSource(name, fallback)
            local source = sources[name]
            if source and source.get then
                return source.get()
            end
            return fallback
        end
        local function setSource(name, value)
            local source = sources[name]
            if source and source.set then
                source.set(nil, value)
            end
        end

        local details = { title = title, onChanged = function() end }
        local font = sources[L["Font"]] or sources.Font
        local flags = sources[L["Font Flags"]] or sources["Font Flags"]
        local anchorSource = sources[L["Anchor"]] or sources[L["Keybind Anchor"]] or sources.Anchor or sources["Keybind Anchor"]
        if font then
            details.fontLabel = L["Font"]
            details.fontOptions = font.values
            details.getFont = function()
                return getSource("Font", "NIL")
            end
            details.setFont = function(value)
                setSource("Font", value)
            end
        end
        if flags then
            details.flagsLabel = L["Font Flags"]
            details.flagOptions = flags.values
            details.getFlags = function()
                return getSource(L["Font Flags"], {})
            end
            details.setFlags = function(value)
                setSource(L["Font Flags"], value)
            end
        end
        if anchorSource then
            details.anchorOptions = anchorSource.values
            details.getAnchor = function()
                return getSource(anchorSource.name, "BOTTOMRIGHT")
            end
            details.setAnchor = function(value)
                setSource(anchorSource.name, value)
            end
        end

        local size = sources[L["Font Size"]]
            or sources[L["Keybind Font Size"]]
            or sources[L["Number Size"]]
            or sources["Font Size"]
            or sources["Keybind Font Size"]
            or sources["Number Size"]
        if size then
            details.sliders = {
                {
                    label = L["Size"],
                    min = 6,
                    max = 40,
                    step = 1,
                    editable = false,
                    get = function()
                        return tonumber(getSource(size.name, 14)) or 14
                    end,
                    set = function(value)
                        local number = math.floor((value or 14) + 0.5)
                        setSource(size.name, size.kind == LEM.SettingType.CompactSlider and number or tostring(number))
                    end,
                },
            }
        end
        local x = sources[L["X Offset"]]
            or sources[L["Keybind X Offset"]]
            or sources[L["Number X Offset"]]
            or sources["X Offset"]
            or sources["Keybind X Offset"]
            or sources["Number X Offset"]
        local y = sources[L["Y Offset"]]
            or sources[L["Keybind Y Offset"]]
            or sources[L["Number Y Offset"]]
            or sources["Y Offset"]
            or sources["Keybind Y Offset"]
            or sources["Number Y Offset"]
        if x then
            details.getX = function()
                return getSource(x.name, 0)
            end
            details.setX = function(value)
                setSource(x.name, value)
            end
        end
        if y then
            details.getY = function()
                return getSource(y.name, 0)
            end
            details.setY = function(value)
                setSource(y.name, value)
            end
        end

        local get = base.get
        local set = base.set
        base.kind = LEM.SettingType.CompactFont
        base.detailsOnly = true
        base.details = details
        base.getEnabled = function()
            return get() and true or false
        end
        base.setEnabled = function(_, value)
            set(nil, value)
        end
        base.get = nil
        base.set = nil

        for i = #settings, 1, -1 do
            local setting = settings[i]
            if setting.parentId == parentId and setting ~= base and names[setting.name] then
                table.remove(settings, i)
            end
        end
    end

    -- Icon styling & stack-number settings are owned by Masque when active, so
    -- they're only added to the panel when Masque skinning is off.
    if not (ns.MasqueModule and ns.MasqueModule:IsActive()) then
        local stylingSettings = {
            {
                kind = LEM.SettingType.Header,
                id = "styling",
                name = L["Styling"],
                defaultCollapsed = true,
            },
            {
                name = L["Alpha"],
                parentId = "styling",
                kind = LEM.SettingType.Slider,
                default = defaultConfig.alpha,
                get = function()
                    return ns.db.profile.editMode[configKey].alpha or defaultConfig.alpha
                end,
                set = function(layoutName, value)
                    ns.db.profile.editMode[configKey].alpha = value
                    anchor:SetAlpha(value)
                end,
                minValue = 0.1,
                maxValue = 1,
                valueStep = 0.01,
                formatter = function(value)
                    return string.format("%.2f", value)
                end,
            },
            {
                name = L["Square Icons"],
                parentId = "styling",
                kind = LEM.SettingType.Checkbox,
                default = false,
                get = function()
                    return ns.db.profile.editMode[configKey].squareIcons or false
                end,
                set = function(layoutName, value)
                    ns.db.profile.editMode[configKey].squareIcons = value and true or false
                    instance:RefreshStyling()
                end,
            },
            {
                name = L["Border Thickness"],
                parentId = "styling",
                kind = LEM.SettingType.CompactSlider,
                default = 1,
                get = function()
                    return GetTrackerStyleValue(configKey, "borderThickness", 1)
                end,
                set = function(layoutName, value)
                    ns.db.profile.editMode[configKey].borderThickness = value
                    instance:RefreshStyling()
                end,
                minValue = 0,
                maxValue = 6,
                valueStep = 1,
                formatter = function(value)
                    return string.format("%dpx", value)
                end,
            },
            {
                name = L["Icon Zoom"],
                parentId = "styling",
                kind = LEM.SettingType.CompactSlider,
                default = 0.3,
                get = function()
                    return GetTrackerStyleValue(configKey, "iconZoom", 0.3)
                end,
                set = function(layoutName, value)
                    ns.db.profile.editMode[configKey].iconZoom = value
                    instance:RefreshStyling()
                end,
                minValue = 0,
                maxValue = 0.5,
                valueStep = 0.01,
                formatter = function(value)
                    return string.format("%.2f", value)
                end,
            },
            {
                name = L["Rectangular Icons"],
                parentId = "styling",
                kind = LEM.SettingType.Checkbox,
                default = false,
                get = function()
                    return ns.db.profile.editMode[configKey].rectangularIcons or false
                end,
                set = function(layoutName, value)
                    ns.db.profile.editMode[configKey].rectangularIcons = value and true or false
                    instance:UpdateIconLayout()
                end,
            },
            {
                name = L["Ratio"],
                parentId = "styling",
                kind = LEM.SettingType.CompactSlider,
                default = 0.8,
                get = function()
                    return GetTrackerStyleValue(configKey, "rectangularIconsPercent", 0.8)
                end,
                set = function(layoutName, value)
                    ns.db.profile.editMode[configKey].rectangularIconsPercent = math.floor(value * 100 + 0.5) / 100
                    instance:UpdateIconLayout()
                end,
                minValue = 0.3,
                maxValue = 1,
                valueStep = 0.01,
                formatter = function(value)
                    return string.format("%.0f%%", value * 100)
                end,
            },
        }
        groupSlidersIntoCogwheel(stylingSettings, "styling", L["Icon Styling"], L["Square Icons"], function(setting)
            return setting.name == L["Border Thickness"] or setting.name == L["Icon Zoom"]
        end)
        groupSlidersIntoCogwheel(stylingSettings, "styling", L["Rectangular Icons"], L["Rectangular Icons"], function(setting)
            return setting.name == L["Ratio"]
        end)
        for _, s in ipairs(stylingSettings) do
            tinsert(additionalSettings, s)
        end
    end

    -- Cooldown-number controls are all gated by the override checkbox (the font,
    -- flags, size and text offset only apply while it's on — see
    -- ApplyCooldownFontToFrame, which restores defaults when off).
    local function cooldownNumberEnabled()
        return GetTrackerStyleValue(configKey, "cooldownFontEnabled", false) and true or false
    end

    -- Stack numbers are shown by default (per tracker); the remaining stack
    -- controls are hidden while the master checkbox is off.
    local function stacksEnabled()
        local cfg = ns.db.profile.editMode[configKey]
        if cfg and cfg.showStacks ~= nil then
            return cfg.showStacks and true or false
        end
        return true
    end

    local stacksCooldownAndKeybindSettings = {
        {
            kind = LEM.SettingType.Header,
            id = "stacks",
            name = L["Charges/Count"],
            defaultCollapsed = true,
        },
        {
            name = L["Show Charges/Count"],
            parentId = "stacks",
            kind = LEM.SettingType.Checkbox,
            default = true,
            get = function()
                local cfg = ns.db.profile.editMode[configKey]
                if cfg and cfg.showStacks ~= nil then
                    return cfg.showStacks and true or false
                end
                return true
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].showStacks = value and true or false
                instance:RefreshEntries()
            end,
        },
        ns.EditModeViewerSettings:BuildCooldownFontNameSetting({
            parentId = "stacks",
            isShown = stacksEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "stackFontName", "NIL")
            end,
            set = function(value)
                ns.db.profile.editMode[configKey].stackFontName = value
                instance:RefreshStyling()
            end,
            desc = L["Font for this custom tracker's charge and count numbers."],
        }),
        ns.EditModeViewerSettings:BuildCooldownFontFlagsSetting({
            parentId = "stacks",
            isShown = stacksEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "stackFontFlags", { OUTLINE = true })
            end,
            set = function(value)
                ns.db.profile.editMode[configKey].stackFontFlags = value
                instance:RefreshStyling()
            end,
        }),
        {
            name = L["Anchor"],
            parentId = "stacks",
            kind = LEM.SettingType.Dropdown,
            default = "BOTTOMRIGHT",
            isShown = stacksEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "stackAnchor", "BOTTOMRIGHT")
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].stackAnchor = value
                instance:RefreshStyling()
            end,
            values = {
                { text = L["Top Left"], value = "TOPLEFT" },
                { text = L["Top"], value = "TOP" },
                { text = L["Top Right"], value = "TOPRIGHT" },
                { text = L["Left"], value = "LEFT" },
                { text = L["Center"], value = "CENTER" },
                { text = L["Right"], value = "RIGHT" },
                { text = L["Bottom Left"], value = "BOTTOMLEFT" },
                { text = L["Bottom"], value = "BOTTOM" },
                { text = L["Bottom Right"], value = "BOTTOMRIGHT" },
            },
        },
        {
            name = L["Font Size"],
            parentId = "stacks",
            kind = LEM.SettingType.CompactSlider,
            default = 14,
            isShown = stacksEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "stackFontSize", 14)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].stackFontSize = value
                instance:RefreshStyling()
            end,
            minValue = 8,
            maxValue = 32,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = L["X Offset"],
            parentId = "stacks",
            kind = LEM.SettingType.CompactSlider,
            default = -1,
            isShown = stacksEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "stackOffsetX", -1)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].stackOffsetX = value
                instance:RefreshStyling()
            end,
            minValue = -20,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = L["Y Offset"],
            parentId = "stacks",
            kind = LEM.SettingType.CompactSlider,
            default = 1,
            isShown = stacksEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "stackOffsetY", 1)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].stackOffsetY = value
                instance:RefreshStyling()
            end,
            minValue = -20,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            kind = LEM.SettingType.Header,
            id = "cdfont",
            name = L["Cooldown Numbers"],
            defaultCollapsed = true,
        },
        {
            name = L["Override Font"],
            parentId = "cdfont",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return GetTrackerStyleValue(configKey, "cooldownFontEnabled", false)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].cooldownFontEnabled = value and true or false
                instance:RefreshStyling()
            end,
        },
        ns.EditModeViewerSettings:BuildCooldownFontNameSetting({
            parentId = "cdfont",
            isShown = cooldownNumberEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "cooldownFontName", "NIL")
            end,
            set = function(value)
                ns.db.profile.editMode[configKey].cooldownFontName = value
                instance:RefreshStyling()
            end,
            desc = L["Font for this custom tracker's cooldown numbers."],
        }),
        ns.EditModeViewerSettings:BuildCooldownFontFlagsSetting({
            parentId = "cdfont",
            isShown = cooldownNumberEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "cooldownFontFlags", { OUTLINE = true })
            end,
            set = function(value)
                ns.db.profile.editMode[configKey].cooldownFontFlags = value
                instance:RefreshStyling()
            end,
        }),
        {
            name = L["Number Size"],
            parentId = "cdfont",
            kind = LEM.SettingType.Dropdown,
            default = "NIL",
            isShown = cooldownNumberEnabled,
            get = function()
                return tostring(GetTrackerStyleValue(configKey, "cooldownFontSize", "NIL"))
            end,
            set = function(layoutName, value)
                if value == "NIL" then
                    ns.db.profile.editMode[configKey].cooldownFontSize = "NIL"
                else
                    local n = tonumber(value)
                    ns.db.profile.editMode[configKey].cooldownFontSize = n
                end
                instance:RefreshStyling()
            end,
            values = {
                { text = L["Default"], value = "NIL" },
                { text = L["Hide"], value = "0" },
                { text = "10", value = "10" },
                { text = "12", value = "12" },
                { text = "14", value = "14" },
                { text = "16", value = "16" },
                { text = "18", value = "18" },
                { text = "20", value = "20" },
                { text = "22", value = "22" },
                { text = "24", value = "24" },
                { text = "26", value = "26" },
                { text = "28", value = "28" },
                { text = "30", value = "30" },
                { text = "32", value = "32" },
                { text = "34", value = "34" },
                { text = "36", value = "36" },
                { text = "38", value = "38" },
            },
        },
        {
            name = L["Number X Offset"],
            parentId = "cdfont",
            kind = LEM.SettingType.CompactSlider,
            default = 0,
            isShown = cooldownNumberEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "cooldownTextOffsetX", 0)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].cooldownTextOffsetX = math.floor((value or 0) + 0.5)
                instance:RefreshStyling()
            end,
            minValue = -20,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = L["Number Y Offset"],
            parentId = "cdfont",
            kind = LEM.SettingType.CompactSlider,
            default = 0,
            isShown = cooldownNumberEnabled,
            get = function()
                return GetTrackerStyleValue(configKey, "cooldownTextOffsetY", 0)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].cooldownTextOffsetY = math.floor((value or 0) + 0.5)
                instance:RefreshStyling()
            end,
            minValue = -20,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            kind = LEM.SettingType.Header,
            id = "keybinds",
            name = L["Keybinds"],
            defaultCollapsed = true,
        },
        {
            name = L["Show Keybinds"],
            parentId = "keybinds",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false)
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].showKeybinds = value and true or false
                if ns.Keybinds then
                    ns.Keybinds:OnSettingChanged(instance.frameName)
                end
            end,
        },
        ns.EditModeViewerSettings:BuildCooldownFontNameSetting({
            parentId = "keybinds",
            isShown = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false) and true or false
            end,
            get = function()
                return GetTrackerStyleValue(configKey, "keybindFontName", "NIL")
            end,
            set = function(value)
                ns.db.profile.editMode[configKey].keybindFontName = value
                if ns.Keybinds then
                    -- Full repaint: also creates/updates keybind text on any
                    -- icon frame that has no keybind text yet, instead of only
                    -- restyling frames that already have one.
                    ns.Keybinds:OnSettingChanged(instance.frameName)
                end
            end,
            desc = L["Font for this custom tracker's keybind text."],
        }),
        ns.EditModeViewerSettings:BuildCooldownFontFlagsSetting({
            parentId = "keybinds",
            isShown = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false) and true or false
            end,
            get = function()
                return GetTrackerStyleValue(configKey, "keybindFontFlags", { OUTLINE = true })
            end,
            set = function(value)
                ns.db.profile.editMode[configKey].keybindFontFlags = value
                if ns.Keybinds then
                    ns.Keybinds:OnSettingChanged(instance.frameName)
                end
            end,
        }),
        {
            name = L["Keybind Anchor"],
            parentId = "keybinds",
            kind = LEM.SettingType.Dropdown,
            default = "TOPRIGHT",
            isShown = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false) and true or false
            end,
            get = function()
                return GetTrackerStyleValue(configKey, "keybindAnchor", "TOPRIGHT")
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].keybindAnchor = value
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings(instance.frameName)
                end
            end,
            values = {
                { text = L["Top Left"], value = "TOPLEFT" },
                { text = L["Top"], value = "TOP" },
                { text = L["Top Right"], value = "TOPRIGHT" },
                { text = L["Left"], value = "LEFT" },
                { text = L["Center"], value = "CENTER" },
                { text = L["Right"], value = "RIGHT" },
                { text = L["Bottom Left"], value = "BOTTOMLEFT" },
                { text = L["Bottom"], value = "BOTTOM" },
                { text = L["Bottom Right"], value = "BOTTOMRIGHT" },
            },
        },
        {
            name = L["Keybind Font Size"],
            parentId = "keybinds",
            kind = LEM.SettingType.Dropdown,
            default = "10",
            isShown = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false) and true or false
            end,
            get = function()
                return tostring(GetTrackerStyleValue(configKey, "keybindFontSize", 10))
            end,
            set = function(layoutName, value)
                local n = tonumber(value)
                ns.db.profile.editMode[configKey].keybindFontSize = n and math.floor(n + 0.5) or 14
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings(instance.frameName)
                end
            end,
            values = {
                { text = "6", value = "6" },
                { text = "8", value = "8" },
                { text = "10", value = "10" },
                { text = "12", value = "12" },
                { text = "14", value = "14" },
                { text = "16", value = "16" },
                { text = "18", value = "18" },
                { text = "20", value = "20" },
                { text = "22", value = "22" },
                { text = "24", value = "24" },
                { text = "26", value = "26" },
                { text = "28", value = "28" },
                { text = "30", value = "30" },
                { text = "32", value = "32" },
            },
        },
        {
            name = L["Keybind X Offset"],
            parentId = "keybinds",
            kind = LEM.SettingType.CompactSlider,
            default = -3,
            isShown = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false) and true or false
            end,
            get = function()
                return GetTrackerStyleValue(configKey, "keybindOffsetX", -3)
            end,
            set = function(layoutName, value)
                local v = math.floor((value or 0) + 0.5)
                ns.db.profile.editMode[configKey].keybindOffsetX = v
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings(instance.frameName)
                end
            end,
            minValue = -20,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = L["Keybind Y Offset"],
            parentId = "keybinds",
            kind = LEM.SettingType.CompactSlider,
            default = -3,
            isShown = function()
                return GetTrackerStyleValue(configKey, "showKeybinds", false) and true or false
            end,
            get = function()
                return GetTrackerStyleValue(configKey, "keybindOffsetY", -3)
            end,
            set = function(layoutName, value)
                local v = math.floor((value or 0) + 0.5)
                ns.db.profile.editMode[configKey].keybindOffsetY = v
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings(instance.frameName)
                end
            end,
            minValue = -20,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
    }
    groupFontSettingsIntoCogwheel(stacksCooldownAndKeybindSettings, "stacks", L["Charges"], L["Show Charges/Count"], {
        [L["Font"]] = true,
        [L["Font Flags"]] = true,
        [L["Anchor"]] = true,
        [L["Font Size"]] = true,
        [L["X Offset"]] = true,
        [L["Y Offset"]] = true,
    })
    groupFontSettingsIntoCogwheel(stacksCooldownAndKeybindSettings, "cdfont", L["Cooldown Numbers"], L["Override Font"], {
        [L["Font"]] = true,
        [L["Font Flags"]] = true,
        [L["Number Size"]] = true,
        [L["Number X Offset"]] = true,
        [L["Number Y Offset"]] = true,
    })
    groupFontSettingsIntoCogwheel(stacksCooldownAndKeybindSettings, "keybinds", L["Keybinds"], L["Show Keybinds"], {
        [L["Font"]] = true,
        [L["Font Flags"]] = true,
        [L["Keybind Anchor"]] = true,
        [L["Keybind Font Size"]] = true,
        [L["Keybind X Offset"]] = true,
        [L["Keybind Y Offset"]] = true,
    })
    for _, sectionId in ipairs({ "cdfont", "stacks", "keybinds" }) do
        for _, setting in ipairs(stacksCooldownAndKeybindSettings) do
            if setting.id == sectionId or setting.parentId == sectionId then
                tinsert(additionalSettings, setting)
            end
        end
    end

    -- Anchor-to-another-frame section (other custom trackers, buff containers, unit
    -- frames, native CDM viewers). Shared with the custom buff containers.
    local anchorSettings = ns.Anchoring:BuildSettings(configKey, {
        selfFrameName = instance.frameName,
        onChanged = function()
            WilduUICore.ApplyFramePosition(anchor, configKey, false)
            instance:RefreshEntries()
        end,
    })
    for _, setting in ipairs(anchorSettings) do
        tinsert(additionalSettings, setting)
    end

    if ns.EditModeViewerSettings and ns.EditModeViewerSettings.BuildAdvancedSettingsButton then
        tinsert(additionalSettings, ns.EditModeViewerSettings:BuildAdvancedSettingsButton("tracker"))
    end
    WilduUICore.RegisterFrameWithLEM(anchor, configKey, additionalSettings, onPositionChanged, true)
end
