local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit
---@type Config
local Config = DelveCompanion.Config
---@type Definitions
local Definitions = DelveCompanion.Definitions

--#region Constants

---@type string
local SETTING_PREFIX = tostring(addonName) .. "_"

---@type string
local BOUNTIFUL_ICON_SEQUENCE = "|A:delves-bountiful:16:16|a"
--#endregion

--- Class for managing addon settings.
---@class (exact) DelveCompanionSettings
---@field rootCategory table
---@field optionsCategory table
local AddonSettings = {}
DelveCompanion.AddonSettings = AddonSettings

--#region Addon Compartment

---@param tooltip GameTooltip
function DelveCompanion_CompartmentSetTooltipContent(tooltip)
    GameTooltip_SetTitle(tooltip, Lockit.UI_ADDON_NAME, nil, true)
    GameTooltip_AddBlankLineToTooltip(tooltip)

    if InCombatLockdown() then
        GameTooltip_AddErrorLine(tooltip, _G["ERR_AFFECTING_COMBAT"], true)
    else
        GameTooltip_AddNormalLine(tooltip, Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK, true)
        GameTooltip_AddNormalLine(tooltip, Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK, true)
    end
end

---@param expansion number LE_EXPANSION enum number of the expansion
function DelveCompanion_CompartmentOpenDelvesInfo(expansion)
    local name = DelveCompanion.Definitions.DependencyAddonName.encounterJournal
    if not C_AddOns.IsAddOnLoaded(name) then
        C_AddOns.LoadAddOn(name)
    end

    EncounterJournal_OpenToJourney(Config.DELVE_FACTION_ID[expansion])
end

--- Used in `TOC` file for [AddonCompartmentFuncOnEnter](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFuncOnEnter).
---@param addonName string
---@param menuButtonFrame table
function DelveCompanion_CompartmentOnEnter(addonName, menuButtonFrame)
    local tooltip = GameTooltip

    tooltip:SetOwner(menuButtonFrame, "ANCHOR_NONE")
    tooltip:SetPoint("TOPRIGHT", menuButtonFrame, "TOPLEFT")
    DelveCompanion_CompartmentSetTooltipContent(tooltip)

    tooltip:Show()
end

--- Used in `TOC` file for [AddonCompartmentFuncOnLeave](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFuncOnLeave).
---@param addonName string
---@param menuButtonFrame table
function DelveCompanion_CompartmentOnLeave(addonName, menuButtonFrame)
    GameTooltip:Hide()
end

--- Used in `TOC` file for [AddonCompartmentFunc](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFunc).
---@param addonName string
---@param buttonName string
function DelveCompanion_CompartmentOnClick(addonName, buttonName)
    if InCombatLockdown() then
        return
    end

    if buttonName == Definitions.ButtonAlias.leftClick then
        DelveCompanion_CompartmentOpenDelvesInfo(LE_EXPANSION_MIDNIGHT)
    elseif buttonName == Definitions.ButtonAlias.rightClick then
        if not (Settings and Settings.OpenToCategory) then
            return
        end

        Settings.OpenToCategory(AddonSettings.optionsCategory:GetID())
    end
end

--#endregion

--#region SavedVariables

--- Add new keys to the existing save.
---@param self DelveCompanionSettings
---@param saveTbl table
---@param sourceTbl DelveCompanionAccountData|DelveCompanionCharacterData
function AddonSettings:AddNewKeysToSave(saveTbl, sourceTbl)
    for key, value in pairs(sourceTbl) do
        if saveTbl[key] == nil then
            saveTbl[key] = value
        end
    end
end

--- Clear retired or renamed keys from the save.
---@param self DelveCompanionSettings
---@param saveTbl table
---@param sourceTbl DelveCompanionAccountData|DelveCompanionCharacterData
function AddonSettings:RemoveRetiredKeys(saveTbl, sourceTbl)
    for key, value in pairs(saveTbl) do
        if sourceTbl[key] == nil then
            saveTbl[key] = nil
        end
    end
end

--- Init [SavedVariables](https://warcraft.wiki.gg/wiki/TOC_format#SavedVariables). The [default config](lua://DelveCompanionAccountData) is used to either init them (e.g. the 1st addon load) or populate with missing fields (e.g. after addon update).
---@param self DelveCompanionSettings
function AddonSettings:ProcessAccountSave()
    -- DelveCompanion.Logger:Log("[DelveCompanionSettings] Init AccountSave...")

    if not DelveCompanionAccountData then
        -- No Account save. Create a fresh one.
        ---@type DelveCompanionAccountData
        DelveCompanionAccountData = CopyTable(Config.DEFAULT_ACCOUNT_DATA)
    else
        self:AddNewKeysToSave(DelveCompanionAccountData, Config.DEFAULT_ACCOUNT_DATA)
        self:RemoveRetiredKeys(DelveCompanionAccountData, Config.DEFAULT_ACCOUNT_DATA)

        -- Reset Tracking Type to the default if the addon selected in the save is not available.
        if (DelveCompanionAccountData.trackingType == Definitions.WaypointTrackingType.tomtom and not DelveCompanion.Variables.tomTomAvailable)
            or (DelveCompanionAccountData.trackingType == Definitions.WaypointTrackingType.mpe and not DelveCompanion.Variables.mpeAvailable)
        then
            DelveCompanionAccountData.trackingType = Definitions.WaypointTrackingType.superTrack
        end
    end
end

--- Init [SavedVariablesPerCharacter](https://warcraft.wiki.gg/wiki/TOC_format#SavedVariablesPerCharacter). The [default config](lua://DelveCompanionCharacterData) is used to either init them (e.g. the 1st addon load) or populate with missing fields (e.g. after addon update).
---@param self DelveCompanionSettings
function AddonSettings:ProcessCharacterSave()
    -- DelveCompanion.Logger:Log("[DelveCompanionSettings] Init CharacterSave...")

    if not DelveCompanionCharacterData then
        -- No Character save. Create a fresh one.
        ---@type DelveCompanionCharacterData
        DelveCompanionCharacterData = CopyTable(Config.DEFAULT_CHARACTER_DATA)
    else
        self:AddNewKeysToSave(DelveCompanionCharacterData, Config.DEFAULT_CHARACTER_DATA)
        self:RemoveRetiredKeys(DelveCompanionCharacterData, Config.DEFAULT_CHARACTER_DATA)
    end
end

--#endregion

--- This callback will be invoked whenever any setting is modified.
local function OnSettingChanged(setting, value)
    -- Logger:Log("[DelveCompanionSettings] OnChanged detected...")

    local variableName = gsub(setting:GetVariable(), SETTING_PREFIX, "")

    -- Logger:Log("[DelveCompanionSettings] Changed var `%s` with value: %s", variableName, tostring(value))
    EventRegistry:TriggerEvent(Definitions.Events.SETTING_CHANGE, variableName, value)
end

--- Create and register an addon Setting.
---@param self DelveCompanionSettings
---@param category table
---@param varKey string
---@param varTbl DelveCompanionAccountData|DelveCompanionCharacterData
---@param defaultValue any
---@param displayText string
---@param onChangedCallback function
---@return table|nil
function AddonSettings:RegisterSetting(category, varKey, varTbl, defaultValue, displayText, onChangedCallback)
    if varTbl[varKey] == nil then
        Logger:Log(Lockit.DEBUG_SAVED_VARIABLE_CONFLICT, varTbl, varKey)
        return nil
    end

    local setting = Settings.RegisterAddOnSetting(
        category, SETTING_PREFIX .. varKey,
        varKey, varTbl,
        type(defaultValue), displayText, defaultValue)
    setting:SetValueChangedCallback(onChangedCallback)

    return setting
end

--- Accound-wide settings.
---@param self DelveCompanionSettings
---@param category table
---@param layout table
function AddonSettings:RegisterAccountSettings(category, layout)
    ---@type DelveCompanionAccountData
    local savedVarTbl = DelveCompanionAccountData

    --- Section header
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT))

    -- Minimap Icon
    do
        local savedVarKey = "minimapIconEnabled"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.minimapIconEnabled,
            Lockit.UI_SETTING_MINIMAP_ICON_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_MINIMAP_ICON_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    -- Info Widgets on Delves tab
    do
        local savedVarKey = "delvesListInfoWidgetsEnabled"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.delvesListInfoWidgetsEnabled,
            Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_DELVES_LIST_INFO_WIDGETS_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    -- Waypoint Tracking
    do
        local savedVarKey = "trackingType"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.trackingType,
            Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME, OnSettingChanged)

        local function GetDropdownOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(Definitions.WaypointTrackingType.superTrack,
                Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME,
                Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION)
            if DelveCompanion.Variables.tomTomAvailable then
                container:Add(Definitions.WaypointTrackingType.tomtom,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION)
            end
            if DelveCompanion.Variables.mpeAvailable then
                container:Add(Definitions.WaypointTrackingType.mpe,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME,
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION)
            end
            return container:GetData()
        end

        local function tooltip()
            local tooltipLineStart = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(
                Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START)
            local tooltipLineBlizzard = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(
                Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD)
            local tooltipLineTomTom = Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM
            local tooltipLineMPE = Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE

            if DelveCompanion.Variables.tomTomAvailable then
                tooltipLineTomTom = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(tooltipLineTomTom)
            else
                local unavailableLine = format(Lockit.UI_COMMON_MISSING_ADDON_TITLE,
                    Definitions.DependencyAddonName.tomtom)
                tooltipLineTomTom = format(
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT,
                    _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(tooltipLineTomTom),
                    _G["WARNING_FONT_COLOR"]:WrapTextInColorCode(unavailableLine))
            end

            if DelveCompanion.Variables.mpeAvailable then
                tooltipLineMPE = _G["NORMAL_FONT_COLOR"]:WrapTextInColorCode(tooltipLineMPE)
            else
                local unavailableLine = format(Lockit.UI_COMMON_MISSING_ADDON_TITLE,
                    Definitions.DependencyAddonName.mpe)
                tooltipLineMPE = format(
                    Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT,
                    _G["DISABLED_FONT_COLOR"]:WrapTextInColorCode(tooltipLineMPE),
                    _G["WARNING_FONT_COLOR"]:WrapTextInColorCode(unavailableLine))
            end

            return string.join("\n",
                tooltipLineStart,
                tooltipLineBlizzard,
                tooltipLineTomTom,
                tooltipLineMPE)
        end

        Settings.CreateDropdown(category, setting, GetDropdownOptions, tooltip)
    end

    -- InDelveWidget
    do
        local controlSavedVarKey = "inDelveWidgetEnabled"

        local controlSetting = self:RegisterSetting(category, controlSavedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.inDelveWidgetEnabled,
            Lockit.UI_SETTING_IN_DELVE_WIDGET_CONTROL_NAME, OnSettingChanged)

        local controlTooltip = Lockit.UI_SETTING_IN_DELVE_WIDGET_CONTROL_TOOLTIP
        local controlInitializer = Settings.CreateCheckbox(category, controlSetting, controlTooltip)

        local function ModifyPredicate()
            return DelveCompanionAccountData.inDelveWidgetEnabled
        end

        do
            local displayRuleSavedVarKey = "inDelveWidgetDisplayRule"
            local dropdownSetting = self:RegisterSetting(category, displayRuleSavedVarKey, savedVarTbl,
                Config.DEFAULT_ACCOUNT_DATA.inDelveWidgetDisplayRule,
                Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_NAME, OnSettingChanged)

            local function GetDropdownOptions()
                local container = Settings.CreateControlTextContainer()
                container:Add(Definitions.InDelveWidgetDisplayRule.left,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_NAME,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_DESCRIPTION)
                container:Add(Definitions.InDelveWidgetDisplayRule.right,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_NAME,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_DESCRIPTION)
                container:Add(Definitions.InDelveWidgetDisplayRule.custom,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_CUSTOM_NAME,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_CUSTOM_DESCRIPTION)

                return container:GetData()
            end
            local dropdownTooltip = Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_TOOLTIP

            local displayRuleInitializer = Settings.CreateDropdown(category, dropdownSetting, GetDropdownOptions,
                dropdownTooltip)
            displayRuleInitializer:Indent()
            displayRuleInitializer:SetParentInitializer(controlInitializer, ModifyPredicate)
        end

        do
            local layoutSavedVarKey = "inDelveWidgetLayout"
            local layoutSetting = self:RegisterSetting(category, layoutSavedVarKey, savedVarTbl,
                Config.DEFAULT_ACCOUNT_DATA.inDelveWidgetLayout,
                Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_NAME, OnSettingChanged)

            local function GetDropdownOptions()
                local container = Settings.CreateControlTextContainer()
                container:Add(Definitions.InDelveWidgetLayout.vertical,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_VERTICAL_NAME,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_VERTICAL_DESCRIPTION)
                container:Add(Definitions.InDelveWidgetLayout.horizontal,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_HORIZONTAL_NAME,
                    Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_OPTION_HORIZONTAL_DESCRIPTION)

                return container:GetData()
            end
            local layoutTooltip = Lockit.UI_SETTING_IN_DELVE_WIDGET_LAYOUT_TOOLTIP

            local layoutInitializer = Settings.CreateDropdown(category, layoutSetting, GetDropdownOptions,
                layoutTooltip)
            layoutInitializer:Indent()
            layoutInitializer:SetParentInitializer(controlInitializer, ModifyPredicate)
        end
    end

    -- Story Variant status in Delves' Gossip
    do
        local savedVarKey = "displayStoryStatusInGossip"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.displayStoryStatusInGossip,
            Lockit.UI_SETTING_STORY_STATUS_IN_GOSSIP_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_STORY_STATUS_IN_GOSSIP_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    -- Delve Auto Enter
    do
        local controlSavedVarKey = "delveAutoEnterEnabled"

        local controlSetting = self:RegisterSetting(category, controlSavedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.delveAutoEnterEnabled,
            Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_NAME, OnSettingChanged)

        local controlTooltip = Lockit.UI_SETTING_DELVE_AUTO_ENTER_CONTROL_TOOLTIP
        local controlInitializer = Settings.CreateCheckbox(category, controlSetting, controlTooltip)

        local function IsModifiable()
            return DelveCompanionAccountData.delveAutoEnterEnabled
        end

        do
            local tierSavedVarKey = "delveAutoEnterTier"

            local tierSetting = self:RegisterSetting(category, tierSavedVarKey, savedVarTbl,
                Config.DEFAULT_ACCOUNT_DATA.delveAutoEnterTier,
                _G["GARRISON_TIER"], OnSettingChanged)

            local minTier, maxTier, step = 1, DelveCompanion:GetDelvesMaxTier(), 1
            local tierOptions = Settings.CreateSliderOptions(minTier, maxTier, step)
            tierOptions:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

            local tierTooltip = Lockit.UI_SETTING_DELVE_AUTO_ENTER_TIER_TOOLTIP

            local tierInitializer = Settings.CreateSlider(category, tierSetting, tierOptions, tierTooltip)
            tierInitializer:Indent()
            tierInitializer:SetParentInitializer(controlInitializer, IsModifiable)
        end

        do
            local delaySavedVarKey = "delveAutoEnterDelaySec"

            local delaySetting = self:RegisterSetting(category, delaySavedVarKey, savedVarTbl,
                Config.DEFAULT_ACCOUNT_DATA.delveAutoEnterDelaySec,
                Lockit.UI_SETTING_DELVE_AUTO_ENTER_DELAY_NAME, OnSettingChanged)

            -- The actual range is based on common sense. 0 for players who don't want to wait at all. 7 - presumably enough for players who may want to cancel it.
            local minDelaySec, maxDelaySec, step = 0, 7, 1
            local delayOptions = Settings.CreateSliderOptions(minDelaySec, maxDelaySec, step)

            local function Formatter(value)
                return string.format(_G["D_SECONDS"], value)
            end
            delayOptions:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, Formatter)

            local delayTooltip = Lockit.UI_SETTING_DELVE_AUTO_ENTER_DELAY_TOOLTIP


            local delayInitializer = Settings.CreateSlider(category, delaySetting, delayOptions, delayTooltip)
            delayInitializer:Indent()
            delayInitializer:SetParentInitializer(controlInitializer, IsModifiable)
        end
    end
end

--- Character-wide settings.
---@param self DelveCompanionSettings
---@param category table
---@param layout table
function AddonSettings:RegisterCharacterSettings(category, layout)
    ---@type DelveCompanionCharacterData
    local savedVarTbl = DelveCompanionCharacterData

    --- Section header
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER))

    do
        local savedVarKey = "keysCapTooltipEnabled"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_CHARACTER_DATA.keysCapTooltipEnabled,
            Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end
end

--- Character-wide settings.
---@param self DelveCompanionSettings
---@param category table
---@param layout table
function AddonSettings:RegisterDebugSettings(category, layout)
    ---@type DelveCompanionAccountData
    local savedVarTbl = DelveCompanionAccountData

    --- Section header
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(_G["BINDING_HEADER_DEBUG"]))

    do
        local savedVarKey = "logsEnabled"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.logsEnabled,
            Lockit.UI_SETTING_LOGS_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_LOGS_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end
end

---@param self DelveCompanionSettings
function AddonSettings:Init()
    -- Logger:Log("[DelveCompanionSettings] Start init...")

    do
        local settingsFrame = CreateFrame("Frame", "$parent.DelveCompanionSettings", nil,
            "DelveCompanionSettingsFrameTemplate")
        local name = string.format("%s %s", Lockit.UI_ADDON_NAME, BOUNTIFUL_ICON_SEQUENCE)
        local root, _ = Settings.RegisterCanvasLayoutCategory(settingsFrame, name)
        Settings.RegisterAddOnCategory(root)
        self.rootCategory = root
    end

    do
        local options, layout = Settings.RegisterVerticalLayoutSubcategory(self.rootCategory, _G["OPTIONS"])
        self.optionsCategory = options

        self:RegisterAccountSettings(options, layout)
        self:RegisterCharacterSettings(options, layout)
        self:RegisterDebugSettings(options, layout)

        Settings.RegisterAddOnCategory(options)
    end
end
