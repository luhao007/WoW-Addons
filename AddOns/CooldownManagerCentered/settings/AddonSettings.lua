local _, ns = ...
local L = ns.L

--- AddonSettings - Settings Management System
local AddonSettings = {}
ns.AddonSettings = AddonSettings

ns.AddonSettings.settingPreview = {}
ns.AddonSettings.SettingsLayout = {}

local SettingsLib = ns.LibEQOL.SettingsMode

local function IsMonkClass()
    return select(3, UnitClass("player")) == 10
end

local PROJECT_PAGE_URL = "https://www.curseforge.com/wow/addons/cooldown-manager-centered"
local COPY_TEXT_DIALOG = "CMC_COPY_SUPPORT_TEXT"
local DONATION_LINKS = {
    { label = "Ko-fi", value = "https://ko-fi.com/wildu" },
    { label = "Buy Me a Coffee", value = "https://buymeacoffee.com/wildu" },
    { label = "Patreon", value = "https://www.patreon.com/join/wildu" },
}
local GOLD_RECIPIENTS = {
    alliance = {
        "Wildu-Silvermoon",
        "Wilduu-BurningLegion",
    },
    horde = {
        "Wilduu-TarrenMill",
        "Wildudh-Kazzak",
    },
}

local function ShowCopyText(value)
    if not StaticPopupDialogs[COPY_TEXT_DIALOG] then
        StaticPopupDialogs[COPY_TEXT_DIALOG] = {
            text = L["Press Ctrl+C to copy."],
            button1 = CLOSE,
            OnShow = function(dialog, data)
                local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
                editBox:SetText(data)
                editBox:HighlightText()
            end,
            hasEditBox = true,
            editBoxWidth = 320,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
    end

    StaticPopup_Show(COPY_TEXT_DIALOG, nil, nil, value)
end

local function AddonSettings_BuildCooldown(category, layout)
    -- When Masque skins the icons, its skin owns all icon styling, glow and font
    -- options, so the affected sections below are omitted from the panel.
    SettingsLib:CreateDropdown(category, {
        prefix = "CMC_",
        key = "cooldownManager_alignBuffIcons_growFromDirection",
        name = L["Tracked Buff Icons*"],
        searchtags = { "Grow", "Direction", "Alignment", "Position", "Layout", "Anchor", "Left", "Right", "Center" },
        default = "CENTER",

        optionfunc = function()
            return {
                ["START"] = L["Grow from the Start"],
                ["CENTER"] = L["Grow from Center"],
                ["END"] = L["Grow from the End"],
                ["Disable"] = L["Disable centering"],
            }
        end,
        order = { "START", "CENTER", "END", "Disable" },
        get = function()
            return ns.db.profile.cooldownManager_alignBuffIcons_growFromDirection or "CENTER"
        end,
        set = function(value)
            ns.db.profile.cooldownManager_alignBuffIcons_growFromDirection = value
            ns.API:RefreshCooldownManager()
        end,
    })

    SettingsLib:CreateDropdown(category, {
        prefix = "CMC_",
        key = "cooldownManager_alignBuffBars_growFromDirection",
        name = L["Tracked Buff Bars*"],
        searchtags = {
            "Grow",
            "Direction",
            "Alignment",
            "Position",
            "Layout",
            "Anchor",
            "Top",
            "Bottom",
            "Buff",
            "Bar",
            "Tracked",
        },
        default = "BOTTOM",
        values = {
            BOTTOM = L["Bars grow from Bottom"],
            TOP = L["Bars grow from Top"],
            ["Disable"] = L["Disable centering"],
        },
        order = { "TOP", "BOTTOM", "Disable" },
        get = function()
            return ns.db.profile.cooldownManager_alignBuffBars_growFromDirection or "BOTTOM"
        end,
        set = function(value)
            ns.db.profile.cooldownManager_alignBuffBars_growFromDirection = value
            ns.API:RefreshCooldownManager()
        end,
    })

    SettingsLib:CreateDropdown(category, {
        prefix = "CMC_",
        key = "cooldownManager_centerEssential_growFromDirection",
        name = L["Essential Icons*"],
        searchtags = { "Grow", "Direction", "Alignment", "Position", "Layout", "Anchor", "Row", "Column", "Essential" },
        default = "TOP",
        optionfunc = function()
            return {
                BOTTOM = EssentialCooldownViewer.isHorizontal and L["New Rows on Top"] or L["New Columns to the Left"],
                TOP = EssentialCooldownViewer.isHorizontal and L["New Rows Below"] or L["New Columns to the Right"],
                ["Disable"] = L["Disable centering"],
            }
        end,
        order = { "TOP", "BOTTOM", "Disable" },
        get = function()
            return ns.db.profile.cooldownManager_centerEssential_growFromDirection or "TOP"
        end,
        set = function(value)
            ns.db.profile.cooldownManager_centerEssential_growFromDirection = value
            ns.API:RefreshCooldownManager()
        end,
    })

    SettingsLib:CreateDropdown(category, {
        prefix = "CMC_",
        key = "cooldownManager_centerUtility_growFromDirection",
        name = L["Utility Icons*"],
        searchtags = { "Grow", "Direction", "Alignment", "Position", "Layout", "Anchor", "Row", "Column", "Utility" },
        default = "TOP",
        optionfunc = function()
            return {
                BOTTOM = UtilityCooldownViewer.isHorizontal and L["New Rows on Top"] or L["New Columns to the Left"],
                TOP = UtilityCooldownViewer.isHorizontal and L["New Rows Below"] or L["New Columns to the Right"],
                ["Disable"] = L["Disable centering"],
            }
        end,
        order = { "TOP", "BOTTOM", "Disable" },
        get = function()
            return ns.db.profile.cooldownManager_centerUtility_growFromDirection or "TOP"
        end,
        set = function(value)
            ns.db.profile.cooldownManager_centerUtility_growFromDirection = value
            ns.API:RefreshCooldownManager()
        end,
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "tracker_enabled",
        name = L["Enable Custom Trackers"],
        searchtags = { "Dynamic", "Alignment", "Position", "Layout", "Anchor", "Auto", "Center", "Adaptive" },
        default = true,
        get = function()
            return ns.db.profile.tracker_enabled
        end,
        set = function(value)
            ns.db.profile.tracker_enabled = value
            if value then
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:Initialize()
                    ns.TrackerItemViewer:ShowAll()
                end
            else
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:HideAll()
                end
                if ns.TrackerAssignmentPanel then
                    ns.TrackerAssignmentPanel:OnTrackerDisabled()
                end
            end
        end,
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "buff_containers_enabled",
        name = L["Enable Buff Containers"],
        searchtags = { "Buff", "Container", "Aura", "Tracked", "Anchor", "Position", "Layout", "Split" },
        default = false,
        get = function()
            return ns.BuffData and ns.BuffData.IsEnabled()
        end,
        set = function(value)
            if not ns.BuffData then
                return
            end
            ns.BuffData.SetEnabled(value)
            if value then
                if ns.BuffContainerViewer then
                    ns.BuffContainerViewer:Initialize()
                end
            else
                if ns.BuffContainerViewer then
                    ns.BuffContainerViewer:HideAll()
                end
                if ns.BuffAssignmentPanel then
                    ns.BuffAssignmentPanel:OnBuffContainersDisabled()
                end
            end
            if ns.CooldownManager then
                ns.CooldownManager.ForceRefresh({ icons = true })
            end
        end,
    })

    --[[    SettingsLib:CreateText(category, {
        name = L["Change icon size, padding, columns, or rows in Edit Mode under Icon Size, Padding & Orientation."],
    })
    SettingsLib:CreateText(category, {
        name = L["Dynamic alignment of Icons and Bars is happening within the Viewer container.\nSnap to Grid in Edit Mode for best results."],
    })]]

    local editModeBanner = Settings.CreateElementInitializer("CooldownManagerCentered_SettingsBannerTemplate", { name = "" })
    editModeBanner.hideText = true
    Settings.RegisterInitializer(category, editModeBanner)

    SettingsLib:CreateButton(category, {
        text = L["Open Edit Mode"],
        func = function()
            ns.API:ToggleEditMode()
        end,
    })
    SettingsLib:CreateButton(category, {
        text = L["Open Cooldown Settings"],
        func = function()
            if not InCombatLockdown() then
                HideUIPanel(SettingsPanel)
                C_Timer.After(0.1, function()
                    CooldownViewerSettings:ShowUIPanel(false)
                end)
            end
        end,
    })
    SettingsLib:CreateText(category, {
        name = L["Type /cds or /cdm to open Cooldown Settings."],
    })

    --[[ -- Disabled: use Edit Mode's compact icon styling.
    if not masqueStylingActive then
        local squareIconsSection = SettingsLib:CreateExpandableSection(category, {
            name = "|cff5fb64aIco|r|cff8ccd00ns|r Styling",
            expanded = false,
            colorizeTitle = true,
        })
        SettingsLib:CreateText(category, {
            name = "|cfffff100Padding|r can no longer be set within addon, please use |cff87bbcaEdit Mode|r",
            parentSection = squareIconsSection,
        })

        SettingsLib:CreateCheckbox(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIcons_BuffIcons",
            name = "Square Buff Icons",
            searchtags = { "Square", "Shape", "Style", "Rectangular", "Flat", "Modern", "Buff", "Icon", "Texture" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_squareIcons_BuffIcons
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIcons_BuffIcons = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Apply square icon styling to Buff Icons viewer.",
        })
        SettingsLib:CreateSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIconsBorder_BuffIcons",
        name = L["Border Thickness"],
            searchtags = { "Border", "Thickness", "Width", "Edge", "Frame", "Outline", "Buff", "Size" },
            default = 4,
            min = 0,
            max = 6,
            step = 1,
            formatter = function(value)
                return string.format("%.0fpx", value)
            end,
            get = function()
                return ns.db.profile.cooldownManager_squareIconsBorder_BuffIcons or 4
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIconsBorder_BuffIcons = value
                if ns.StyledIcons then
                    ns.StyledIcons:OnSettingChanged()
                end
            end,
            desc = "Border thickness for square Buff Icons (space between icon edge and texture).",
            -- isEnabled = function()
            --     return not ns.API:IsSomeAddOnRestrictionActive()
            -- end,
        })

        SettingsLib:CreateSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIconsZoom_BuffIcons",
        name = L["Zoom"],
            searchtags = { "Zoom", "Scale", "Crop", "Magnify", "Enlarge", "Texture", "Buff", "Icon" },
            default = 0,
            min = 0,
            max = 0.5,
            step = 0.01,
            formatter = function(value)
                return string.format("%.2f", value)
            end,
            get = function()
                return ns.db.profile.cooldownManager_squareIconsZoom_BuffIcons or 0
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIconsZoom_BuffIcons = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Zoom level for square Buff Icons (0 = no zoom, 0.5 = maximum zoom).",
        })

        SettingsLib:CreateCheckboxSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_experimental_enableRectangularIcons_buffIcons",
        name = L["Rectangular Ratio"],
            searchtags = { "Rectangular", "Icons", "Experimental", "Rectangle", "Wide", "Aspect Ratio" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons
            end,
            set = function(value)
                ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Enable rectangular icons for Buff Icons viewer. |cffff0000Experimental feature, may cause issues!|r",

            sliderKey = "cooldownManager_experimental_enableRectangularIcons_buffIcons_percent",
            sliderName = "Height to Width Ratio",
            sliderMin = 0.6,
            sliderMax = 0.9,
            sliderStep = 0.01,
            sliderDefault = 0.8,
            sliderGet = function()
                return ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons_percent
            end,
            sliderSet = function(value)
                local rounded = math.floor((value or 0) * 100 + 0.5) / 100
                ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons_percent = rounded
                ns.StyledIcons:OnSettingChanged()
            end,
            sliderFormatter = function(value)
                return string.format("%.0f%%", value * 100)
            end,
        })
        SettingsLib:CreateText(category, {
            name = "",
            parentSection = squareIconsSection,
        })

        SettingsLib:CreateCheckbox(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIcons_Essential",
            name = "Square Essential Cooldowns",
            searchtags = { "Square", "Shape", "Style", "Rectangular", "Flat", "Modern", "Essential", "Icon", "Texture" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_squareIcons_Essential
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIcons_Essential = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Apply square icon styling to Essential Cooldowns viewer.",
        })

        SettingsLib:CreateSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIconsBorder_Essential",
        name = L["Border Thickness"],
            searchtags = { "Border", "Thickness", "Width", "Edge", "Frame", "Outline", "Essential", "Size" },
            default = 4,
            min = 0,
            max = 6,
            step = 1,
            formatter = function(value)
                return string.format("%.0fpx", value)
            end,
            get = function()
                return ns.db.profile.cooldownManager_squareIconsBorder_Essential or 4
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIconsBorder_Essential = value

                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Border thickness for square Essential Icons (space between icon edge and texture).",
            -- isEnabled = function()
            --     return not ns.API:IsSomeAddOnRestrictionActive()
            -- end,
        })

        SettingsLib:CreateSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIconsZoom_Essential",
        name = L["Icon Zoom"],
            searchtags = { "Zoom", "Scale", "Crop", "Magnify", "Enlarge", "Texture", "Essential", "Icon" },
            default = 0,
            min = 0,
            max = 0.5,
            step = 0.01,
            formatter = function(value)
                return string.format("%.2f", value)
            end,
            get = function()
                return ns.db.profile.cooldownManager_squareIconsZoom_Essential or 0
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIconsZoom_Essential = value
                if ns.StyledIcons then
                    ns.StyledIcons:OnSettingChanged()
                end
            end,
            desc = "Zoom level for square Essential Icons (0 = no zoom, 0.5 = maximum zoom).",
        })

        SettingsLib:CreateCheckboxSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_experimental_enableRectangularIcons_essential",
        name = L["Rectangular Ratio"],
            searchtags = { "Rectangular", "Icons", "Experimental", "Rectangle", "Wide", "Aspect Ratio" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential
            end,
            set = function(value)
                ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Enable rectangular icons for Essential viewer. |cffff0000Experimental feature, may cause issues!|r",

            sliderKey = "cooldownManager_experimental_enableRectangularIcons_essential_percent",
            sliderName = "Height to Width Ratio",
            sliderMin = 0.6,
            sliderMax = 0.9,
            sliderStep = 0.01,
            sliderDefault = 0.8,
            sliderGet = function()
                return ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential_percent
            end,
            sliderSet = function(value)
                local rounded = math.floor((value or 0) * 100 + 0.5) / 100
                ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential_percent = rounded
                ns.StyledIcons:OnSettingChanged()
            end,
            sliderFormatter = function(value)
                return string.format("%.0f%%", value * 100)
            end,
        })

        SettingsLib:CreateText(category, {
            name = "",
            parentSection = squareIconsSection,
        })

        SettingsLib:CreateCheckbox(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIcons_Utility",
            name = "Square Utility Cooldowns",
            searchtags = { "Square", "Shape", "Style", "Rectangular", "Flat", "Modern", "Utility", "Icon", "Texture" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_squareIcons_Utility
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIcons_Utility = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Apply square icon styling to Utility Cooldowns viewer.",
        })

        SettingsLib:CreateSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIconsBorder_Utility",
        name = L["Border Thickness"],
            searchtags = { "Border", "Thickness", "Width", "Edge", "Frame", "Outline", "Utility", "Size" },
            default = 4,
            min = 0,
            max = 6,
            step = 1,
            formatter = function(value)
                return string.format("%.0fpx", value)
            end,
            get = function()
                return ns.db.profile.cooldownManager_squareIconsBorder_Utility or 4
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIconsBorder_Utility = value
                if ns.StyledIcons then
                    ns.StyledIcons:OnSettingChanged()
                end
            end,
            desc = "Border thickness for square Utility Icons (space between icon edge and texture).",
            -- isEnabled = function()
            --     return not ns.API:IsSomeAddOnRestrictionActive()
            -- end,
        })

        SettingsLib:CreateSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_squareIconsZoom_Utility",
        name = L["Icon Zoom"],
            searchtags = { "Zoom", "Scale", "Crop", "Magnify", "Enlarge", "Texture", "Utility", "Icon" },
            default = 0,
            min = 0,
            max = 0.5,
            step = 0.01,
            formatter = function(value)
                return string.format("%.2f", value)
            end,
            get = function()
                return ns.db.profile.cooldownManager_squareIconsZoom_Utility or 0
            end,
            set = function(value)
                ns.db.profile.cooldownManager_squareIconsZoom_Utility = value
                if ns.StyledIcons then
                    ns.StyledIcons:OnSettingChanged()
                end
            end,
            desc = "Zoom level for square Utility Icons (0 = no zoom, 0.5 = maximum zoom).",
        })
        SettingsLib:CreateCheckboxSlider(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_experimental_enableRectangularIcons_utility",
        name = L["Rectangular Ratio"],
            searchtags = { "Rectangular", "Icons", "Experimental", "Rectangle", "Wide", "Aspect Ratio" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility
            end,
            set = function(value)
                ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Enable rectangular icons for Utility viewer. |cffff0000Experimental feature, may cause issues!|r",

            sliderKey = "cooldownManager_experimental_enableRectangularIcons_utility_percent",
            sliderName = "Height to Width Ratio",
            sliderMin = 0.6,
            sliderMax = 0.9,
            sliderStep = 0.01,
            sliderDefault = 0.8,
            sliderGet = function()
                return ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility_percent
            end,
            sliderSet = function(value)
                local rounded = math.floor((value or 0) * 100 + 0.5) / 100
                ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility_percent = rounded
                ns.StyledIcons:OnSettingChanged()
            end,
            sliderFormatter = function(value)
                return string.format("%.0f%%", value * 100)
            end,
        })
        SettingsLib:CreateCheckbox(category, {
            parentSection = squareIconsSection,
            prefix = "CMC_",
            key = "cooldownManager_normalizeUtilitySize",
        name = L["Normalize Utility Icons Scaling"],
            searchtags = { "Fix", "Normalize", "Size", "Uniform", "Match", "Equal", "Same", "Utility", "Icon" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_normalizeUtilitySize
            end,
            set = function(value)
                ns.db.profile.cooldownManager_normalizeUtilitySize = value
                ns.StyledIcons:OnSettingChanged()
            end,
            desc = "Set base Utility Cooldown Icons |cffff0000base|r size as Essential Cooldowns Icons\nIt helps to have a more uniform look when both viewers are used together.",
        })
    end -- not masqueStylingActive (icon styling section only)
    ]]
    local cooldownSection = SettingsLib:CreateExpandableSection(category, {
        name = L["Cooldown Color and Effects Settings"],
        expanded = false,
        colorizeTitle = true,
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_customSwipeColor_enabled",
        name = L["Enable Custom Overlay Colors"],
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_customSwipeColor_enabled or false
        end,
        set = function(value)
            ns.db.profile.cooldownManager_customSwipeColor_enabled = value
        end,
        desc = L["Enable custom coloring for the cooldown swipe overlay."],
        parentSection = cooldownSection,
    })

    SettingsLib:CreateColorOverrides(category, {
        key = "cooldownManager_customActiveColor",
        entries = {
            { key = "active", label = L["Active Aura Color"] },
        },
        hasOpacity = true,
        getColor = function(key)
            if key == "active" then
                return ns.db.profile.cooldownManager_customActiveColor_r or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.r,
                    ns.db.profile.cooldownManager_customActiveColor_g or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.g,
                    ns.db.profile.cooldownManager_customActiveColor_b or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.b,
                    ns.db.profile.cooldownManager_customActiveColor_a or ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.a
            end
        end,
        setColor = function(key, r, g, b, a)
            if key == "active" then
                ns.db.profile.cooldownManager_customActiveColor_r = r
                ns.db.profile.cooldownManager_customActiveColor_g = g
                ns.db.profile.cooldownManager_customActiveColor_b = b
                ns.db.profile.cooldownManager_customActiveColor_a = a
            end
        end,
        getDefaultColor = function(key)
            if key == "active" then
                return ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.r,
                    ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.g,
                    ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.b,
                    ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.a
            end
        end,
        parentSection = cooldownSection,
    })

    SettingsLib:CreateColorOverrides(category, {
        key = "cooldownManager_customCDSwipeColor",
        entries = {
            { key = "active", label = L["Cooldown Swipe Color"] },
        },
        hasOpacity = true,
        getColor = function(key)
            if key == "active" then
                return ns.db.profile.cooldownManager_customCDSwipeColor_r or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.r,
                    ns.db.profile.cooldownManager_customCDSwipeColor_g or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.g,
                    ns.db.profile.cooldownManager_customCDSwipeColor_b or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.b,
                    ns.db.profile.cooldownManager_customCDSwipeColor_a or ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.a
            end
        end,
        setColor = function(key, r, g, b, a)
            if key == "active" then
                ns.db.profile.cooldownManager_customCDSwipeColor_r = r
                ns.db.profile.cooldownManager_customCDSwipeColor_g = g
                ns.db.profile.cooldownManager_customCDSwipeColor_b = b
                ns.db.profile.cooldownManager_customCDSwipeColor_a = a
            end
        end,
        getDefaultColor = function(key)
            if key == "active" then
                return ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.r,
                    ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.g,
                    ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.b,
                    ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.a
            end
        end,
        parentSection = cooldownSection,
    })

    SettingsLib:CreateButton(category, {
        text = L["Set default colors"],
        func = function()
            ns.db.profile.cooldownManager_customActiveColor_r = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.r
            ns.db.profile.cooldownManager_customActiveColor_g = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.g
            ns.db.profile.cooldownManager_customActiveColor_b = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.b
            ns.db.profile.cooldownManager_customActiveColor_a = ns.CONSTANTS.DEFAULT_ACTIVE_SWIPE_COLOR.a
            ns.db.profile.cooldownManager_customCDSwipeColor_r = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.r
            ns.db.profile.cooldownManager_customCDSwipeColor_g = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.g
            ns.db.profile.cooldownManager_customCDSwipeColor_b = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.b
            ns.db.profile.cooldownManager_customCDSwipeColor_a = ns.CONSTANTS.DEFAULT_COOLDOWN_SWIPE_COLOR.a
        end,
        parentSection = cooldownSection,
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_hideCooldownFlash",
        name = L["Hide cooldown flash"],
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_hideCooldownFlash or false
        end,
        set = function(value)
            ns.db.profile.cooldownManager_hideCooldownFlash = value
            if ns.CooldownStyle and ns.CooldownStyle.RefreshHooks then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L["Hide the bright flash shown on Essential and Utility cooldown icons when an ability comes off cooldown."],
        parentSection = cooldownSection,
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_hide_gcd",
        name = L["Hide GCD"],
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_hide_gcd or false
        end,
        set = function(value)
            ns.db.profile.cooldownManager_hide_gcd = value
            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L["Hide the GCD cooldown spiral on cooldown icons."],
        parentSection = cooldownSection,
    })

    --[[ -- Disabled: use Edit Mode's compact icon styling.
    SettingsLib:CreateHeader(category, {
        name = L["Cooldown"],
        parentSection = cooldownSection,
    })

    local cooldownFontSizeValues = {
        NIL = L["Default"],
        ["0"] = L["Hide"],
    }
    local cooldownFontSizeOrder = { "NIL", "0" }
    for size = 10, 38, 2 do
        local value = tostring(size)
        cooldownFontSizeValues[value] = value
        cooldownFontSizeOrder[#cooldownFontSizeOrder + 1] = value
    end

    local cooldownFlagOptions = {
        { value = "MONOCHROME", text = L["Monochrome"] },
        { value = "OUTLINE", text = L["Outline"] },
        { value = "THICKOUTLINE", text = L["Thick Outline"] },
        { value = "SLUG", text = L["Slug"] },
    }

    local function cooldownFontOptions()
        local options = { { value = "NIL", text = L["Default font"] } }
        if not LSM then
            return options
        end
        local fonts = LSM:HashTable(LSM.MediaType.FONT)
        local names = {}
        for fontName in pairs(fonts) do
            if fontName ~= "" then
                names[#names + 1] = fontName
            end
        end
        table.sort(names)
        for _, fontName in ipairs(names) do
            options[#options + 1] = { value = fontName, text = fontName }
        end
        return options
    end

    local function createCompactCooldownControl(scope, label)
        local localizedLabel = L[label]
        local enabledKey = "cooldownManager_cooldownFontSize" .. scope .. "_enabled"
        local sizeKey = "cooldownManager_cooldownFontSize" .. scope
        local xKey = "cooldownManager_cooldownText" .. scope .. "_offsetX"
        local yKey = "cooldownManager_cooldownText" .. scope .. "_offsetY"

        SettingsLib:CreateCompactFont(category, {
            parentSection = cooldownSection,
            prefix = "CMC_",
            key = enabledKey,
            dropdownKey = sizeKey,
            name = localizedLabel,
            desc = string.format(
                L["Override cooldown text for %s. Use the cog for font and position."],
                localizedLabel
            ),
            dropdownName = L["Font Size"],
            default = false,
            dropdownDefault = "NIL",
            dropdownValues = cooldownFontSizeValues,
            dropdownOrder = cooldownFontSizeOrder,
            get = function()
                return ns.db.profile[enabledKey] and true or false
            end,
            set = function(value)
                ns.db.profile[enabledKey] = value
                ns.CooldownFont:RefreshAll()
            end,
            dropdownGet = function()
                local value = ns.db.profile[sizeKey]
                return value ~= nil and tostring(value) or "NIL"
            end,
            dropdownSet = function(value)
                ns.db.profile[sizeKey] = value == "NIL" and "NIL" or tonumber(value)
                ns.CooldownFont:RefreshAll()
            end,
            searchtags = { "Cooldown", "Font", "Size", "X Offset", "Y Offset", localizedLabel },
            details = {
                title = L["Cooldown"],
                fontLabel = L["Font (all viewers)"],
                flagsLabel = L["Font Flags (all viewers)"],
                fontOptions = cooldownFontOptions,
                flagOptions = cooldownFlagOptions,
                getFont = function()
                    local value = ns.db.profile.cooldownManager_cooldownFontName
                    return value and value ~= "" and value or "NIL"
                end,
                setFont = function(value)
                    ns.db.profile.cooldownManager_cooldownFontName = value
                end,
                getFlags = function()
                    return ns.db.profile.cooldownManager_cooldownFontFlags or {}
                end,
                setFlags = function(value)
                    if value.OUTLINE or value.THICKOUTLINE or value.MONOCHROME or value.SLUG then
                        ns.db.profile.cooldownManager_cooldownFontFlags = value
                    else
                        ns.db.profile.cooldownManager_cooldownFontFlags = { OUTLINE = false }
                    end
                end,
                getX = function()
                    return ns.db.profile[xKey] or 0
                end,
                setX = function(value)
                    ns.db.profile[xKey] = value
                end,
                getY = function()
                    return ns.db.profile[yKey] or 0
                end,
                setY = function(value)
                    ns.db.profile[yKey] = value
                end,
                onChanged = function()
                    ns.CooldownFont:RefreshAll()
                end,
            },
        })
    end

    createCompactCooldownControl("Essential", "Essential")
    createCompactCooldownControl("Utility", "Utility")
    createCompactCooldownControl("BuffIcons", "Tracked Buffs")
    ]]
    --
    local customProcSection = SettingsLib:CreateExpandableSection(category, {
        name = L["Custom Glow Styles"],
        expanded = false,
        colorizeTitle = true,
    })

    SettingsLib:CreateDropdown(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_experimental_glow_style",
        name = L["Custom Glow Style"],
        searchtags = { "Glow", "Style", "Proc", "Auto Cast", "Pixel", "Ants", "Slot", "Default" },
        default = "DEFAULT",
        values = {
            DEFAULT = L["Default"],
            PROC = L["Proc Glow"],
            AUTOCAST = L["Auto Cast Glow"],
            PIXEL = L["Pixel Glow"],
            ANTS = L["Ants Style Glow"],
            SLOT = L["Slot Glow"],
        },
        order = { "DEFAULT", "PROC", "AUTOCAST", "PIXEL", "ANTS", "SLOT" },
        get = function()
            return ns.db.profile.cooldownManager_experimental_glow_style or "DEFAULT"
        end,
        set = function(value)
            ns.db.profile.cooldownManager_experimental_glow_style = value

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L["Set one global glow style used by cooldown style glows and glow overrides."],
    })

    SettingsLib:CreateCheckbox(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_experimental_glow_custom_color",
        name = L["Custom Glow Color"],
        searchtags = { "Glow", "Color", "Auto Cast", "Pixel" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_experimental_glow_custom_color
        end,
        set = function(value)
            ns.db.profile.cooldownManager_experimental_glow_custom_color = value

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
    })

    SettingsLib:CreateColorOverrides(category, {
        parentSection = customProcSection,
        key = "cooldownManager_experimental_glow_color",
        entries = {
            { key = "glow", label = L["Glow Color"] },
        },
        hasOpacity = true,
        getColor = function()
            return ns.db.profile.cooldownManager_experimental_glow_color_r or 1,
                ns.db.profile.cooldownManager_experimental_glow_color_g or 210 / 255,
                ns.db.profile.cooldownManager_experimental_glow_color_b or 0,
                ns.db.profile.cooldownManager_experimental_glow_color_a or 1
        end,
        setColor = function(_, r, g, b, a)
            ns.db.profile.cooldownManager_experimental_glow_color_r = r
            ns.db.profile.cooldownManager_experimental_glow_color_g = g
            ns.db.profile.cooldownManager_experimental_glow_color_b = b
            ns.db.profile.cooldownManager_experimental_glow_color_a = a

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        getDefaultColor = function()
            return 1, 210 / 255, 0, 1
        end,
    })

    SettingsLib:CreateCheckbox(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_glow_only_in_combat",
        name = L["Glows only in combat"],
        searchtags = { "Glow", "Combat", "Proc", "Ready", "Suggested" },
        default = true,
        get = function()
            return ns.db.profile.cooldownManager_glow_only_in_combat == true
        end,
        set = function(value)
            ns.db.profile.cooldownManager_glow_only_in_combat = value
            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshCombatGlowState()
            end
        end,
    })

    SettingsLib:CreateText(category, {
        parentSection = customProcSection,
        name = L["Glow style and color apply to proc glows and custom glows. Set 0 below to use the default."],
    })

    SettingsLib:CreateSlider(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_experimental_glow_animation_speed",
        name = L["Animation Speed"],
        searchtags = { "Glow", "Animation", "Speed", "Frequency", "Auto Cast", "Pixel", "Ants", "Proc" },
        default = 0,
        min = -1,
        max = 1,
        step = 0.01,
        formatter = function(value)
            return string.format("%.2f", value)
        end,
        get = function()
            return ns.db.profile.cooldownManager_experimental_glow_animation_speed or 0
        end,
        set = function(value)
            local speed = tonumber(value) or 0
            if speed > 2 then
                speed = 2
            elseif speed < -2 then
                speed = -2
            end
            ns.db.profile.cooldownManager_experimental_glow_animation_speed = speed

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L['Controls glow animation speed for Auto Cast, Pixel, Ants and Proc glows.\n0 is not "zero", it\'s Default speed.'],
    })
    SettingsLib:CreateSlider(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_experimental_glow_animation_density",
        name = L["Animation Density"],
        searchtags = { "Glow", "Animation", "Density", "Frequency", "Auto Cast", "Pixel", "Ants" },
        default = 0,
        min = 0,
        max = 16,
        step = 1,
        formatter = function(value)
            return string.format("%d", value)
        end,
        get = function()
            return ns.db.profile.cooldownManager_experimental_glow_animation_density or 0
        end,
        set = function(value)
            local density = tonumber(value) or 0
            if density > 16 then
                density = 16
            elseif density < 0 then
                density = 0
            end
            ns.db.profile.cooldownManager_experimental_glow_animation_density = density

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L['Controls glow animation density: particle count for Auto Cast and Pixel Glow, or stacked layers (1-4) for Ants Glow.\n0 is not "zero", it\'s Default density.'],
    })

    SettingsLib:CreateSlider(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_experimental_glow_autocast_scale",
        name = L["Auto Cast Glow Scale"],
        searchtags = { "Glow", "Auto Cast", "Scale", "Size" },
        default = 1,
        min = 0.5,
        max = 5,
        step = 0.1,
        formatter = function(value)
            return string.format("%.1f", value)
        end,
        get = function()
            local scale = tonumber(ns.db.profile.cooldownManager_experimental_glow_autocast_scale) or 1
            scale = math.floor((scale * 10) + 0.5) / 10
            if scale > 5 then
                scale = 5
            elseif scale < 0.5 then
                scale = 0.5
            end
            return scale
        end,
        set = function(value)
            local scale = tonumber(value) or 1
            scale = math.floor((scale * 10) + 0.5) / 10
            if scale > 5 then
                scale = 5
            elseif scale < 0.5 then
                scale = 0.5
            end
            ns.db.profile.cooldownManager_experimental_glow_autocast_scale = scale

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L["Controls Auto Cast glow ring scale. 1.0 is default."],
    })

    SettingsLib:CreateSlider(category, {
        parentSection = customProcSection,
        prefix = "CMC_",
        key = "cooldownManager_experimental_glow_pixel_size",
        name = L["Pixel Glow Size"],
        searchtags = { "Glow", "Pixel", "Size", "Thickness" },
        default = 1,
        min = 1,
        max = 6,
        step = 1,
        formatter = function(value)
            return string.format("%d", value)
        end,
        get = function()
            local size = tonumber(ns.db.profile.cooldownManager_experimental_glow_pixel_size) or 1
            size = math.floor(size + 0.5)
            if size > 6 then
                size = 6
            elseif size < 1 then
                size = 1
            end
            return size
        end,
        set = function(value)
            local size = tonumber(value) or 1
            size = math.floor(size + 0.5)
            if size > 6 then
                size = 6
            elseif size < 1 then
                size = 1
            end
            ns.db.profile.cooldownManager_experimental_glow_pixel_size = size

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L["Controls Pixel glow line thickness. 1 is default."],
    })

    SettingsLib:CreateButton(category, {
        parentSection = customProcSection,
        text = L["Restore Glows to Default"],
        searchtags = {

            "Glow",
            "Animation",
            "Speed",
            "Density",
            "Auto Cast",
            "Pixel",
            "Reset",
            "Default",
        },
        func = function()
            ns.db.profile.cooldownManager_experimental_glow_style = "DEFAULT"
            ns.db.profile.cooldownManager_experimental_glow_custom_color = false
            ns.db.profile.cooldownManager_experimental_glow_animation_speed = 0
            ns.db.profile.cooldownManager_experimental_glow_animation_density = 0
            ns.db.profile.cooldownManager_experimental_glow_autocast_scale = 1
            ns.db.profile.cooldownManager_experimental_glow_pixel_size = 1

            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
    })

    --[[ -- Disabled: charges are configured from Edit Mode/CDM.
    local stackNumberSection = SettingsLib:CreateExpandableSection(category, {
        name = L["Ability Charges Settings"],
        expanded = false,
        colorizeTitle = true,
    })

    SettingsLib:CreateText(category, {
        name = L["Enable a viewer, choose the size here, then use the cog for font, anchor and position."],
        parentSection = stackNumberSection,
    })

    local stackFontSizeValues = { NIL = L["Don't change"] }
    local stackFontSizeOrder = { "NIL" }
    for size = 10, 38, 2 do
        local value = tostring(size)
        stackFontSizeValues[value] = value
        stackFontSizeOrder[#stackFontSizeOrder + 1] = value
    end

    local stackAnchorValues = {
        TOPLEFT = L["Top Left"],
        TOP = L["Top"],
        TOPRIGHT = L["Top Right"],
        LEFT = L["Left"],
        RIGHT = L["Right"],
        BOTTOMLEFT = L["Bottom Left"],
        BOTTOM = L["Bottom"],
        BOTTOMRIGHT = L["Bottom Right"],
    }
    local stackAnchorOrder = {
        "TOPLEFT",
        "TOP",
        "TOPRIGHT",
        "LEFT",
        "RIGHT",
        "BOTTOMLEFT",
        "BOTTOM",
        "BOTTOMRIGHT",
    }
    local stackAnchorOptions = {}
    for _, value in ipairs(stackAnchorOrder) do
        stackAnchorOptions[#stackAnchorOptions + 1] = { value = value, text = stackAnchorValues[value] }
    end

    local stackFlagOptions = {
        { value = "MONOCHROME", text = L["Monochrome"] },
        { value = "OUTLINE", text = L["Outline"] },
        { value = "THICKOUTLINE", text = L["Thick Outline"] },
        { value = "SLUG", text = L["Slug"] },
    }

    local function stackFontOptions()
        local options = { { value = "NIL", text = L["Default font"] } }
        if not LSM then
            return options
        end
        local fonts = LSM:HashTable(LSM.MediaType.FONT)
        local names = {}
        for fontName in pairs(fonts) do
            if fontName ~= "" then
                names[#names + 1] = fontName
            end
        end
        table.sort(names)
        for _, fontName in ipairs(names) do
            options[#options + 1] = { value = fontName, text = fontName }
        end
        return options
    end

    local function refreshAllStackFonts()
        if ns.Stacks then
            ns.Stacks:RefreshAll()
        end
        if ns.TrackerItemViewer then
            ns.TrackerItemViewer:RefreshStyling()
        end
    end

    local function createCompactStackControl(scope, label, viewerFrame)
        local localizedLabel = L[label]
        local enabledKey = "cooldownManager_stackAnchor" .. scope .. "_enabled"
        local pointKey = "cooldownManager_stackAnchor" .. scope .. "_point"
        local sizeKey = "cooldownManager_stackFontSize" .. scope
        local xKey = "cooldownManager_stackAnchor" .. scope .. "_offsetX"
        local yKey = "cooldownManager_stackAnchor" .. scope .. "_offsetY"

        local function refreshViewer()
            if ns.Stacks then
                ns.Stacks:ApplyStackFonts(viewerFrame)
            end
        end

        SettingsLib:CreateCompactFont(category, {
            parentSection = stackNumberSection,
            prefix = "CMC_",
            key = enabledKey,
            dropdownKey = sizeKey,
            name = localizedLabel,
            desc = string.format(
                L["Override charge text for %s. Use the cog for font, anchor and position."],
                localizedLabel
            ),
            dropdownName = L["Font Size"],
            default = false,
            dropdownDefault = "NIL",
            dropdownValues = stackFontSizeValues,
            dropdownOrder = stackFontSizeOrder,
            get = function()
                return ns.db.profile[enabledKey] and true or false
            end,
            set = function(value)
                ns.db.profile[enabledKey] = value
                refreshViewer()
            end,
            dropdownGet = function()
                local value = ns.db.profile[sizeKey]
                return value ~= nil and tostring(value) or "NIL"
            end,
            dropdownSet = function(value)
                local number = tonumber(value)
                ns.db.profile[sizeKey] = value == "NIL" and nil or (number and math.floor(number + 0.5) or nil)
                refreshViewer()
            end,
            searchtags = {
                "Stack",
                "Charges",
                "Count",
                "Font",
                "Size",
                "Anchor",
                "X Offset",
                "Y Offset",
                localizedLabel,
            },
            details = {
            title = L["Charges"],
                anchorOptions = stackAnchorOptions,
                getAnchor = function()
                    return ns.db.profile[pointKey] or "BOTTOMRIGHT"
                end,
                setAnchor = function(value)
                    ns.db.profile[pointKey] = value
                end,
            fontLabel = L["Font (all viewers)"],
            flagsLabel = L["Font Flags (all viewers)"],
                fontOptions = stackFontOptions,
                flagOptions = stackFlagOptions,
                getFont = function()
                    local value = ns.db.profile.cooldownManager_stackFontName
                    return value and value ~= "" and value or "NIL"
                end,
                setFont = function(value)
                    ns.db.profile.cooldownManager_stackFontName = value
                end,
                getFlags = function()
                    return ns.db.profile.cooldownManager_stackFontFlags or {}
                end,
                setFlags = function(value)
                    if value.OUTLINE or value.THICKOUTLINE or value.MONOCHROME or value.SLUG then
                        ns.db.profile.cooldownManager_stackFontFlags = value
                    else
                        ns.db.profile.cooldownManager_stackFontFlags = { OUTLINE = false }
                    end
                end,
                getX = function()
                    return ns.db.profile[xKey] or 0
                end,
                setX = function(value)
                    ns.db.profile[xKey] = value
                end,
                getY = function()
                    return ns.db.profile[yKey] or 0
                end,
                setY = function(value)
                    ns.db.profile[yKey] = value
                end,
                onChanged = refreshAllStackFonts,
            },
        })
    end

    createCompactStackControl("Essential", "Essential", "EssentialCooldownViewer")
    createCompactStackControl("Utility", "Utility", "UtilityCooldownViewer")
    createCompactStackControl("BuffIcons", "Tracked Buffs", "BuffIconCooldownViewer")

    ]]

    --[[ -- Disabled: keybinds are configured from Edit Mode/CDM.
    local keybindsSection = SettingsLib:CreateExpandableSection(category, {
        name = L["Keybind Text Display"],
        expanded = false,
        colorizeTitle = true,
    })

    SettingsLib:CreateText(category, {
        name = L["Display keybind text on cooldown icons."],
        parentSection = keybindsSection,
    })

    SettingsLib:CreateScrollDropdown(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_keybindFontName",
        name = L["Font"],
        searchtags = { "Font", "Text", "Keybind", "Hotkey", "Binding", "Typeface", "Typography", "SharedMedia" },
        default = "NIL",
        height = 220,
        get = function()
            local v = ns.db.profile.cooldownManager_keybindFontName
            if not v or v == "NIL" then
                return "Default font"
            end
            return v
        end,
        set = function(value)
            ns.db.profile.cooldownManager_keybindFontName = value
            ns.Keybinds:OnSettingChanged()
        end,
        desc = L["Select the font for ability keybind text. Uses SharedMedia fonts if available."],
        generator = function(dropdown, rootDescription)
            dropdown.fontPool = {}
            if not Affected(dropdown).fontfaceDropdownOnMenuClosedHooked then
                hooksecurefunc(dropdown, "OnMenuClosed", function()
                    for _, fontDisplay in pairs(dropdown.fontPool) do
                        fontDisplay:Hide()
                    end
                end)
                Affected(dropdown).fontfaceDropdownOnMenuClosedHooked = true
            end
            local fonts = LSM:HashTable(LSM.MediaType.FONT)
            local sortedFonts = {}
            for fontName in pairs(fonts) do
                if fontName ~= "" then
                    table.insert(sortedFonts, fontName)
                end
            end
            table.sort(sortedFonts)

        rootDescription:CreateRadio(L["Default font"], function()
                local v = ns.db.profile.cooldownManager_keybindFontName
                return not v or v == "NIL"
            end, function()
                ns.db.profile.cooldownManager_keybindFontName = "NIL"
                ns.Keybinds:OnSettingChanged()
                dropdown:SetText(L["Default font"])
            end)

            for index, fontName in ipairs(sortedFonts) do
                local fontPath = fonts[fontName]

                local button = rootDescription:CreateRadio(fontName, function()
                    return ns.db.profile.cooldownManager_keybindFontName == fontName
                end, function()
                    ns.db.profile.cooldownManager_keybindFontName = fontName
                    ns.Keybinds:OnSettingChanged()
                    dropdown:SetText(fontName)
                end)

                button:AddInitializer(function(self)
                    local fontDisplay = dropdown.fontPool[index]
                    if not fontDisplay then
                        fontDisplay = dropdown:CreateFontString(nil, "BACKGROUND")
                        dropdown.fontPool[index] = fontDisplay
                    end

                    self.fontString:Hide()

                    fontDisplay:SetParent(self)
                    fontDisplay:SetPoint("LEFT", self.fontString, "LEFT", 0, 0)
                    fontDisplay:SetFont(fontPath, 12)
                    fontDisplay:SetText(fontName)
                    fontDisplay:Show()
                end)
            end
        end,
    })

    SettingsLib:CreateMultiDropdown(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_keybindFontFlags",
        name = L["Font Flags"],
        customText = L["No Flags"],
        searchtags = { "Font", "Flags", "Outline", "Shadow", "Thick", "Monochrome", "Keybind", "Style" },
        defaultSelection = {},
        values = {
            ["OUTLINE"] = "Outline",
            ["THICKOUTLINE"] = "Thick Outline",
            ["MONOCHROME"] = "Monochrome",
            ["SLUG"] = "Slug",
        },
        order = { "MONOCHROME", "OUTLINE", "THICKOUTLINE", "SLUG" },
        getSelection = function()
            return ns.db.profile.cooldownManager_keybindFontFlags or {}
        end,
        setSelection = function(value)
            if value["OUTLINE"] or value["THICKOUTLINE"] or value["MONOCHROME"] or value["SLUG"] then
                ns.db.profile.cooldownManager_keybindFontFlags = value
            else
                ns.db.profile.cooldownManager_keybindFontFlags = { OUTLINE = false }
            end
            ns.Keybinds:OnSettingChanged()
        end,
        desc = L["Select font flags for ability keybind text."],
    })
    SettingsLib:CreateText(category, {
        name = "",
        parentSection = keybindsSection,
    })
    -- Keybind font size options (no "Don't change" option)
    local keybindFontSizeValues = {
        ["6"] = "6",
        ["8"] = "8",
        ["10"] = "10",
        ["12"] = "12",
        ["14"] = "14",
        ["16"] = "16",
        ["18"] = "18",
        ["20"] = "20",
        ["22"] = "22",
        ["24"] = "24",
        ["26"] = "26",
        ["28"] = "28",
        ["30"] = "30",
        ["32"] = "32",
    }
    local keybindFontSizeOrder = {
        "6",
        "8",
        "10",
        "12",
        "14",
        "16",
        "18",
        "20",
        "22",
        "24",
        "26",
        "28",
        "30",
        "32",
    }

    local function CreateKeybindFontSizeDropdown(parentSection, key, name, getFn, setFn)
        SettingsLib:CreateDropdown(category, {
            parentSection = parentSection,
            prefix = "CMC_",
            key = key,
            name = name,
            default = "14",
            values = keybindFontSizeValues,
            order = keybindFontSizeOrder,
            get = getFn,
            set = setFn,
        })
    end

    -- Keybind Anchor
    SettingsLib:CreateCheckboxDropdown(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_showKeybinds_Essential",
        dropdownKey = "cooldownManager_keybindAnchor_Essential",
            name = L["Essential Enable & Anchor"],
        searchtags = { "Keybind", "Hotkey", "Binding", "Key", "Shortcut", "Essential", "Show", "Display", "Anchor" },
        default = false,
        dropdownDefault = "TOPRIGHT",
        get = function()
            return ns.db.profile.cooldownManager_showKeybinds_Essential
        end,
        set = function(value)
            ns.db.profile.cooldownManager_showKeybinds_Essential = value
            if ns.Keybinds then
                ns.Keybinds:OnSettingChanged("Essential")
            end
        end,
        dropdownGet = function()
            return ns.db.profile.cooldownManager_keybindAnchor_Essential or "TOPRIGHT"
        end,
        dropdownSet = function(value)
            ns.db.profile.cooldownManager_keybindAnchor_Essential = value
            if ns.Keybinds then
                ns.Keybinds:ApplyKeybindSettings("EssentialCooldownViewer")
            end
        end,
        dropdownValues = {
            TOPLEFT = "Top Left",
            TOP = "Top",
            TOPRIGHT = "Top Right",
            LEFT = "Left",
            CENTER = "Center",
            RIGHT = "Right",
            BOTTOMLEFT = "Bottom Left",
            BOTTOM = "Bottom",
            BOTTOMRIGHT = "Bottom Right",
        },
        dropdownOrder = {
            "TOPLEFT",
            "TOP",
            "TOPRIGHT",
            "LEFT",
            "CENTER",
            "RIGHT",
            "BOTTOMLEFT",
            "BOTTOM",
            "BOTTOMRIGHT",
        },
            desc = L["Enable keybind text on Essential Cooldowns and select anchor position."],
    })

    CreateKeybindFontSizeDropdown(keybindsSection, "cooldownManager_keybindFontSize_Essential", "Font Size", function()
        return tostring(ns.db.profile.cooldownManager_keybindFontSize_Essential or 14)
    end, function(value)
        local n = tonumber(value)
        ns.db.profile.cooldownManager_keybindFontSize_Essential = n and math.floor(n + 0.5) or 14
        if ns.Keybinds then
            ns.Keybinds:ApplyKeybindSettings("EssentialCooldownViewer")
        end
    end)

    -- Keybind X Offset
    SettingsLib:CreateSlider(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_keybindOffsetX_Essential",
        name = L["X Offset"],
        default = -3,
        min = -20,
        max = 20,
        step = 1,
        formatter = function(value)
            return string.format("%.0f", value)
        end,
        get = function()
            return ns.db.profile.cooldownManager_keybindOffsetX_Essential or -3
        end,
        set = function(value)
            local v = math.floor((value or 0) + 0.5)
            ns.db.profile.cooldownManager_keybindOffsetX_Essential = v
            if ns.Keybinds then
                ns.Keybinds:ApplyKeybindSettings("EssentialCooldownViewer")
            end
        end,
    })

    -- Keybind Y Offset
    SettingsLib:CreateSlider(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_keybindOffsetY_Essential",
        name = L["Y Offset"],
        default = -3,
        min = -20,
        max = 20,
        step = 1,
        formatter = function(value)
            return string.format("%.0f", value)
        end,
        get = function()
            return ns.db.profile.cooldownManager_keybindOffsetY_Essential or -3
        end,
        set = function(value)
            local v = math.floor((value or 0) + 0.5)
            ns.db.profile.cooldownManager_keybindOffsetY_Essential = v
            if ns.Keybinds then
                ns.Keybinds:ApplyKeybindSettings("EssentialCooldownViewer")
            end
        end,
    })
    SettingsLib:CreateText(category, {
        name = "",
        parentSection = keybindsSection,
    })

    SettingsLib:CreateCheckboxDropdown(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_showKeybinds_Utility",
        dropdownKey = "cooldownManager_keybindAnchor_Utility",
            name = L["Utility: Enable & Anchor"],
        searchtags = { "Keybind", "Hotkey", "Binding", "Key", "Shortcut", "Utility", "Show", "Display", "Anchor" },
        default = false,
        dropdownDefault = "TOPRIGHT",
        get = function()
            return ns.db.profile.cooldownManager_showKeybinds_Utility
        end,
        set = function(value)
            ns.db.profile.cooldownManager_showKeybinds_Utility = value
            if ns.Keybinds then
                ns.Keybinds:OnSettingChanged("Utility")
            end
        end,
        dropdownGet = function()
            return ns.db.profile.cooldownManager_keybindAnchor_Utility or "TOPRIGHT"
        end,
        dropdownSet = function(value)
            ns.db.profile.cooldownManager_keybindAnchor_Utility = value
            if ns.Keybinds then
                ns.Keybinds:ApplyKeybindSettings("UtilityCooldownViewer")
            end
        end,
        dropdownValues = {
            TOPLEFT = "Top Left",
            TOP = "Top",
            TOPRIGHT = "Top Right",
            LEFT = "Left",
            CENTER = "Center",
            RIGHT = "Right",
            BOTTOMLEFT = "Bottom Left",
            BOTTOM = "Bottom",
            BOTTOMRIGHT = "Bottom Right",
        },
        dropdownOrder = {
            "TOPLEFT",
            "TOP",
            "TOPRIGHT",
            "LEFT",
            "CENTER",
            "RIGHT",
            "BOTTOMLEFT",
            "BOTTOM",
            "BOTTOMRIGHT",
        },
            desc = L["Enable keybind text on Utility Cooldowns and select anchor position."],
    })

    CreateKeybindFontSizeDropdown(keybindsSection, "cooldownManager_keybindFontSize_Utility", "Font Size", function()
        return tostring(ns.db.profile.cooldownManager_keybindFontSize_Utility or 10)
    end, function(value)
        local n = tonumber(value)
        ns.db.profile.cooldownManager_keybindFontSize_Utility = n and math.floor(n + 0.5) or 14
        if ns.Keybinds then
            ns.Keybinds:ApplyKeybindSettings("UtilityCooldownViewer")
        end
    end)
    SettingsLib:CreateSlider(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_keybindOffsetX_Utility",
        name = L["X Offset"],
        default = -3,
        min = -20,
        max = 20,
        step = 1,
        formatter = function(value)
            return string.format("%.0f", value)
        end,
        get = function()
            return ns.db.profile.cooldownManager_keybindOffsetX_Utility or -3
        end,
        set = function(value)
            local v = math.floor((value or 0) + 0.5)
            ns.db.profile.cooldownManager_keybindOffsetX_Utility = v
            if ns.Keybinds then
                ns.Keybinds:ApplyKeybindSettings("UtilityCooldownViewer")
            end
        end,
    })
    SettingsLib:CreateSlider(category, {
        parentSection = keybindsSection,
        prefix = "CMC_",
        key = "cooldownManager_keybindOffsetY_Utility",
        name = L["Y Offset"],
        default = -3,
        min = -20,
        max = 20,
        step = 1,
        formatter = function(value)
            return string.format("%.0f", value)
        end,
        get = function()
            return ns.db.profile.cooldownManager_keybindOffsetY_Utility or -3
        end,
        set = function(value)
            local v = math.floor((value or 0) + 0.5)
            ns.db.profile.cooldownManager_keybindOffsetY_Utility = v
            if ns.Keybinds then
                ns.Keybinds:ApplyKeybindSettings("UtilityCooldownViewer")
            end
        end,
    })

    ]]

    --[[ -- Disabled: visibility is configured from Edit Mode/CDM.
    local visibilitySection = SettingsLib:CreateExpandableSection(category, {
        name = L["Show Hide Visibility"],
        expanded = false,
        colorizeTitle = true,
        searchtags = {
            "Visibility",
            "Rules",
            "Conditions",
            "Hide",
            "Show",
            "Utility",
            "Essential",
            "CDM",
            "Opacity",
            "Alpha",
            "Combat",
            "Flying",
            "Mounted",
            "Resting",
            "Vehicle",
            "Instance",
            "Target",
        },
    })

    local VISIBILITY_RULE_VALUES = {
        ["SHOW_IN_COMBAT"] = "Always show in Combat",
        ["SHOW_IN_INSTANCE"] = "Always show in Instances",
        ["HIDE_IN_VEHICLES"] = "Hide in Vehicles & Mini-games",
        ["ALWAYS_HIDE_WHEN_FLYING"] = "Always hide when Flying",
        ["SHOW_WITH_ENEMY_TARGET"] = "Show with Enemy Target",
        ["SHOW_WITH_TARGET"] = "Show with any Target",
        ["HIDE_WHEN_FLYING"] = "Hide when Flying",
        ["HIDE_WHEN_NOT_FLYING"] = "Hide when not Flying",
        ["HIDE_WHEN_MOUNTED"] = "Hide when Mounted & Travel Form",
        ["HIDE_WHEN_RESTING"] = "Hide when Resting",
        ["HIDE_OUT_OF_COMBAT"] = "Hide out of Combat",
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
    local VISIBILITY_RULE_SEARCHTAGS = {
        "Visibility",
        "Rules",
        "Conditions",
        "Hide",
        "Show",
        "Utility",
        "Essential",
        "CDM",
        "Opacity",
        "Alpha",
        "Combat",
        "Flying",
        "Mounted",
        "Resting",
        "Vehicle",
        "Instance",
        "Target",
    }

    local function CreateViewerVisibilityDropdown(viewerName, label)
        SettingsLib:CreateMultiDropdown(category, {
            parentSection = visibilitySection,
            prefix = "CMC_",
            key = "cooldownManager_visibility_perViewer_" .. viewerName,
            name = label,
        customText = L["No rules (always visible)"],
            searchtags = VISIBILITY_RULE_SEARCHTAGS,
            defaultSelection = {},
            height = 340,
            values = VISIBILITY_RULE_VALUES,
            order = VISIBILITY_RULE_ORDER,
            getSelection = function()
                local perViewer = ns.db.profile.cooldownManager_visibility_perViewer
                return (perViewer and perViewer[viewerName]) or {}
            end,
            setSelection = function(value)
                if not ns.db.profile.cooldownManager_visibility_perViewer then
                    ns.db.profile.cooldownManager_visibility_perViewer = {}
                end
                ns.db.profile.cooldownManager_visibility_perViewer[viewerName] = value
                ns.CMCVisibility:Initialize({ [viewerName] = true })
            end,
            summary = function(selectionMap, labels)
                local HIDE_RULES = {
                    HIDE_IN_VEHICLES = true,
                    HIDE_WHEN_FLYING = true,
                    HIDE_WHEN_NOT_FLYING = true,
                    HIDE_WHEN_MOUNTED = true,
                    HIDE_WHEN_RESTING = true,
                    HIDE_OUT_OF_COMBAT = true,
                    ALWAYS_HIDE_WHEN_FLYING = true,
                }
                local hasHide = false
                for rule in pairs(selectionMap) do
                    if HIDE_RULES[rule] then
                        hasHide = true
                        break
                    end
                end
                local count = ns.API:GetTableLength(selectionMap)
                if count == 0 or not hasHide then
                    return "no |cffff4444hide|r rules (always visible)"
                elseif count == 1 then
                    return "1 rule"
                else
                    return count .. " rules"
                end
            end,
        })
    end

    CreateViewerVisibilityDropdown("BuffIconCooldownViewer", "Buff Icons")
    CreateViewerVisibilityDropdown("BuffBarCooldownViewer", "Buff Bars")
    CreateViewerVisibilityDropdown("EssentialCooldownViewer", "Essential Cooldowns")
    CreateViewerVisibilityDropdown("UtilityCooldownViewer", "Utility Cooldowns")
    local trackerCount = (ns.TrackerItemViewer and ns.TrackerItemViewer:GetTrackerCount()) or ns.db.profile.tracker_count or 2
    for i = 1, trackerCount do
        CreateViewerVisibilityDropdown("CMCTracker" .. i, "CMC Tracker " .. i)
    end

    ]]

    SettingsLib:CreateHeader(category, {
        name = L["Tweaks for Cooldown Manager"],
        searchtags = {
            "Tweaks",
            "Cooldown",
            "Manager",
            "CMC",
            "CDM",
            "Assistant",
            "Assisted",
            "Highlight",
            "Rotation",
            "Suggested",
            "Border",
            "Glow",
            "Sync Utility width to Essential",
            "Fix",
            "Normalize",
            "Size",
            "Uniform",
            "Match",
            "Equal",
            "Same",
            "Utility",
            "Icon",
        },
    })

    if ns.MasqueModule and ns.MasqueModule:IsAvailable() then
        SettingsLib:CreateCheckbox(category, {
            prefix = "CMC_",
            key = "masque_enabled",
            name = L["Masque skinning **"],
            searchtags = { "Masque", "Skin", "Border", "Icon", "Style", "Theme" },
            default = false,
            get = function()
                return ns.db.global.masque_enabled or false
            end,
            set = function(value)
                ns.db.global.masque_enabled = value
                ns.API:ShowReloadUIConfirmation()
            end,
            desc = L["Masque is not recommended for CDM. It skins Cooldown Manager and custom Tracker icons. CMC icon styling and font options are disabled while Masque is enabled. Requires a UI reload."],
        })
    end

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_showHighlight_Essential",
        name = L["Rotation Highlight on CDM"],
        searchtags = { "Assistant", "Assisted", "Highlight", "Rotation", "Suggested", "Border", "Glow" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_showHighlight_Essential and ns.db.profile.cooldownManager_showHighlight_Utility
        end,
        set = function(value)
            ns.db.profile.cooldownManager_showHighlight_Essential = value
            ns.db.profile.cooldownManager_showHighlight_Utility = value
            if ns.Assistant then
                ns.Assistant:OnSettingChanged("Essential")
                ns.Assistant:OnSettingChanged("Utility")
            end
        end,
        desc = L["Show a blue border when an ability is suggested by the rotation helper."],
    })
    if IsMonkClass() then
        SettingsLib:CreateCheckbox(category, {
            prefix = "CMC_",
            key = "cooldownManager_windwalkerComboHelper_enabled",
            name = L["Windwalker Combo Helper"],
            searchtags = { "Windwalker", "Monk", "Combo", "Strikes", "Essential", "CDM" },
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_windwalkerComboHelper_enabled ~= false
            end,
            set = function(value)
                ns.db.profile.cooldownManager_windwalkerComboHelper_enabled = value
                if ns.WindwalkerComboHelper then
                    ns.WindwalkerComboHelper:OnSettingChanged()
                end
            end,
            desc = L["Mark the last Windwalker Combo Strikes ability on Essential CDM."],
        })
    end
    SettingsLib:CreateCheckboxDropdown(category, {
        prefix = "CMC_",
        key = "cooldownManager_buttonPress",
        name = L["Button Press Overlay"],
        searchtags = { "Button", "Press", "Overlay", "Cooldowns", "Icons" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_buttonPress
        end,
        set = function(value)
            ns.db.profile.cooldownManager_buttonPress = value
            if value then
                ns.ButtonPress:Reinitialize()
                if C_AddOns.IsAddOnLoaded("Dominos") then
                    ns.ButtonPress:HookAllDominosButtons()
                end
                if C_AddOns.IsAddOnLoaded("ElvUI") then
                    ns.ButtonPress:RegisterElvUICallbacks()
                end
            else
                ns.ButtonPress:Disable()
            end
        end,
        desc = L["Show an overlay on cooldown icons when the corresponding action button is pressed."],

        dropdownKey = "cooldownManager_buttonPress_texture",
        dropdownName = L["Button Press Texture"],
        dropdownValues = {
            Blizzard = L["Blizzard Default"],
            Flat = L["Simple Flat Overlay"],
        },
        dropdownDefault = "Blizzard",
        dropdownGet = function()
            return ns.db.profile.cooldownManager_buttonPress_texture or "Blizzard"
        end,
        dropdownSet = function(value)
            ns.db.profile.cooldownManager_buttonPress_texture = value
            if ns.ButtonPress then
                ns.ButtonPress:RefreshTextures()
            end
        end,
        dropdownDesc = L["Select the texture for the button press overlay."],
        dropdownOrder = {
            "Blizzard",
            "Flat",
        },
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_limitUtilitySizeToEssential",
        name = L["Sync Utility width to Essential"],
        searchtags = { "Sync", "Width", "Size", "Match", "Limit", "Utility", "Essential", "Constrain" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_limitUtilitySizeToEssential
        end,
        set = function(value)
            ns.db.profile.cooldownManager_limitUtilitySizeToEssential = value
            ns.CooldownManager.ForceRefreshAll()
        end,
        desc = L["Limit Utility width to Essential width, but never below 6 icons or the Edit Mode limit."],
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_hideRangeCheck",
        name = L["Hide Range Check"],
        searchtags = { "Range", "Out of Range", "OOR", "Red", "Dim", "Desaturate", "Essential", "Utility" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_hideRangeCheck or false
        end,
        set = function(value)
            ns.db.profile.cooldownManager_hideRangeCheck = value
            if ns.RangeCheck then
                ns.RangeCheck:RefreshAll()
            end
        end,
        desc = L["Stop Essential and Utility icons from dimming when the target is out of range."],
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_desaturate_under_aura",
        name = L["Desaturate Icon Under Aura"],
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_desaturate_under_aura or false
        end,
        set = function(value)
            ns.db.profile.cooldownManager_desaturate_under_aura = value
            if ns.CooldownStyle then
                ns.CooldownStyle:RefreshHooks()
            end
        end,
        desc = L["Desaturate cooldown icons when the ability has an active aura."],
    })

    SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "cooldownManager_hide_glow_on_active_aura",
        name = L["Hide Custom Glows When Aura Is Shown"],
        searchtags = { "Cooldown", "Glow", "Active Aura", "Buff", "Debuff", "Experimental", "Customization" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_hide_glow_on_active_aura or false
        end,
        set = function(value)
            ns.db.profile.cooldownManager_hide_glow_on_active_aura = value
        end,
        desc = L["Hide custom glows around cooldown icons when an aura is active. Experimental; may not work."],
    })

    SettingsLib:CreateCheckboxSlider(category, {
        prefix = "CMC_",
        key = "cooldownManager_utility_dimWhenNotOnCD",
        name = L["Hide Utility When Ready"],
        searchtags = { "Dim", "Opacity", "Faded", "Transparent", "Utility", "Cooldown", "Hide", "Icons" },
        default = false,
        get = function()
            return ns.db.profile.cooldownManager_utility_dimWhenNotOnCD
        end,
        set = function(value)
            ns.db.profile.cooldownManager_utility_dimWhenNotOnCD = value
            ns.CooldownManager.ForceRefresh({ utility = true })
            if not value then
                ns.CooldownManager.RestoreUtilityAlpha()
            end
        end,
        desc = L["Hide or dim Utility icons when ready. At 0 opacity, hidden icons do not take layout space."],
        sliderKey = "cooldownManager_utility_dimOpacity",
        sliderName = L["Hide Opacity"],
        sliderMin = 0,
        sliderMax = 0.9,
        sliderStep = 0.05,
        sliderDefault = 0.3,
        sliderGet = function()
            return ns.db.profile.cooldownManager_utility_dimOpacity
        end,
        sliderSet = function(value)
            ns.db.profile.cooldownManager_utility_dimOpacity = value
            ns.CooldownManager.ForceRefresh({ utility = true })
        end,
        sliderFormatter = function(value)
            return string.format("%.0f%%", value * 100)
        end,
    })

    --[[SettingsLib:CreateCheckbox(category, {
        prefix = "CMC_",
        key = "editMode_helper_enabled",
        name = L["Edit mode helper"],
        searchtags = { "Edit Mode", "Helper", "Anchor", "Visibility", "Layout" },
        default = true,
        get = function()
            return ns.db.profile.editMode_helper_enabled ~= false
        end,
        set = function(value)
            ns.db.profile.editMode_helper_enabled = value == true
        end,
        desc = L["Allow CMC to save its Edit Mode helper adjustments through Blizzard's Edit Mode settings override."],
    })
    --]]
end

local function AddonSettings_BuildSupport()
    local supportCategory = Settings.RegisterVerticalLayoutSubcategory(ns.AddonSettings.SettingsLayout.rootCategory, L["Support"])
    ns.AddonSettings.SettingsLayout.supportCategory = supportCategory
    local version = C_AddOns.GetAddOnMetadata("CooldownManagerCentered", "Version") or UNKNOWN

    SettingsLib:CreateButton(supportCategory, {
        label = "CurseForge",
        text = L["Copy Project Page Link"],
        func = function()
            ShowCopyText(PROJECT_PAGE_URL)
        end,
        desc = L["Copies the CooldownManagerCentered CurseForge project page link."],
    })
    SettingsLib:CreateText(supportCategory, {
        name = string.format(L["Current version: %s"], version),
    })

    SettingsLib:CreateHeader(supportCategory, { name = L["Support Development"] })
    SettingsLib:CreateText(supportCategory, {
        name = L["If you enjoy using CooldownManagerCentered, you can support its continued development."],
    })
    for _, donation in ipairs(DONATION_LINKS) do
        local label, value = donation.label, donation.value
        SettingsLib:CreateButton(supportCategory, {
            label = label,
            text = L["Copy Donation Link"],
            func = function()
                ShowCopyText(value)
            end,
        })
    end

    if GetCurrentRegionName() == "EU" then
        SettingsLib:CreateText(supportCategory, {
            name = L["You can also support development with in-game gold on these EU realms."],
        })
        SettingsLib:CreateText(supportCategory, { name = L["Alliance"] })
        for _, characterName in ipairs(GOLD_RECIPIENTS.alliance) do
            local recipient = characterName
            SettingsLib:CreateButton(supportCategory, {
                label = recipient,
                text = L["Copy Character Name"],
                func = function()
                    ShowCopyText(recipient)
                end,
            })
        end
        SettingsLib:CreateText(supportCategory, { name = L["Horde"] })
        for _, characterName in ipairs(GOLD_RECIPIENTS.horde) do
            local recipient = characterName
            SettingsLib:CreateButton(supportCategory, {
                label = recipient,
                text = L["Copy Character Name"],
                func = function()
                    ShowCopyText(recipient)
                end,
            })
        end
    end
end

-- Initialize the settings UI (called from main addon after DB is ready)
function AddonSettings:RegisterSettings()
    local category, layout =
        Settings.RegisterVerticalLayoutCategory("Co|cffbcc71fo|r|cff52a855ld|r|cff3faa4fownM|r|cff5fb64aan|r|cff7ac243ag|r|cff8ccd00erCentered|r")
    Settings.RegisterAddOnCategory(category)
    ns.AddonSettings.SettingsLayout.rootCategory = category
    ns.AddonSettings.SettingsLayout.rootLayout = layout
end

local isInitialized = false
function AddonSettings:InitializeSettings()
    if isInitialized then
        return
    end
    isInitialized = true

    AddonSettings_BuildCooldown(ns.AddonSettings.SettingsLayout.rootCategory, ns.AddonSettings.SettingsLayout.rootLayout)

    ns.ProfileSettings:BuildSettings(ns.AddonSettings.SettingsLayout.rootCategory)
    AddonSettings_BuildSupport()
end

local function HideDefaultsButton()
    if
        SettingsPanel
        and SettingsPanel.Container
        and SettingsPanel.Container.SettingsList
        and SettingsPanel.Container.SettingsList.Header
        and SettingsPanel.Container.SettingsList.Header.DefaultsButton
    then
        SettingsPanel.Container.SettingsList.Header.DefaultsButton.__hidden_by = "CMC"
        SettingsPanel.Container.SettingsList.Header.DefaultsButton:Hide()
    end
end
local function ShowDefaultsButton()
    if
        SettingsPanel
        and SettingsPanel.Container
        and SettingsPanel.Container.SettingsList
        and SettingsPanel.Container.SettingsList.Header
        and SettingsPanel.Container.SettingsList.Header.DefaultsButton
        and SettingsPanel.Container.SettingsList.Header.DefaultsButton.__hidden_by == "CMC"
    then
        SettingsPanel.Container.SettingsList.Header.DefaultsButton:Show()
        SettingsPanel.Container.SettingsList.Header.DefaultsButton.__hidden_by = nil
    end
end
EventRegistry:RegisterCallback("Settings.CategoryChanged", function(_, category)
    if
        category == ns.AddonSettings.SettingsLayout.rootCategory
        or category == ns.AddonSettings.SettingsLayout.profileCategory
        or category == ns.AddonSettings.SettingsLayout.supportCategory
    then
        HideDefaultsButton()
    else
        ShowDefaultsButton()
    end
end)

SettingsPanel.SearchBox:HookScript("OnTextChanged", function()
    if
        SettingsPanel:GetCurrentCategory() == ns.AddonSettings.SettingsLayout.rootCategory
        or SettingsPanel:GetCurrentCategory() == ns.AddonSettings.SettingsLayout.profileCategory
        or SettingsPanel:GetCurrentCategory() == ns.AddonSettings.SettingsLayout.supportCategory
    then
        HideDefaultsButton()
    else
        ShowDefaultsButton()
    end
end)
