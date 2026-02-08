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
--#endregion

--- Class for managing addon settings.
---@class (exact) DelveCompanionSettings
---@field rootCategory table
---@field optionsCategory table
local AddonSettings = {}
DelveCompanion.AddonSettings = AddonSettings

--#region Addon Compartment

--- Used in `TOC` file for [AddonCompartmentFuncOnEnter](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFuncOnEnter).
---@param addonName string
---@param menuButtonFrame table
function DelveCompanionCompartmentOnEnter(addonName, menuButtonFrame)
    local tooltip = GameTooltip

    tooltip:SetOwner(menuButtonFrame, "ANCHOR_NONE")
    tooltip:SetPoint("TOPRIGHT", menuButtonFrame, "TOPLEFT")
    GameTooltip_SetTitle(tooltip, Lockit.UI_ADDON_NAME, nil, true)
    GameTooltip_AddBlankLineToTooltip(tooltip)
    GameTooltip_AddNormalLine(tooltip, Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK, true)
    GameTooltip_AddNormalLine(tooltip, Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK, true)

    tooltip:Show()
end

--- Used in `TOC` file for [AddonCompartmentFuncOnLeave](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFuncOnLeave).
---@param addonName string
---@param menuButtonFrame table
function DelveCompanionCompartmentOnLeave(addonName, menuButtonFrame)
    GameTooltip:Hide()
end

--- Global function to open addon settings. Used in `TOC` file for [AddonCompartmentFunc](https://warcraft.wiki.gg/wiki/TOC_format#AddonCompartmentFunc).
---@param addonName string
---@param buttonName string
function DelveCompanionCompartmentOnClick(addonName, buttonName)
    if not (Settings and Settings.OpenToCategory) then
        return
    end

    local id = ""

    if buttonName == Definitions.ButtonAlias.leftClick then
        id = AddonSettings.rootCategory:GetID()
    elseif buttonName == Definitions.ButtonAlias.rightClick then
        id = AddonSettings.optionsCategory:GetID()
    end

    Settings.OpenToCategory(id)
end

--#endregion

--#region SavedVariables

--- Add new keys to the existing save.
---@param saveTbl table
---@param sourceTbl DelveCompanionAccountData|DelveCompanionCharacterData
local function AddNewKeysToSave(saveTbl, sourceTbl)
    for key, value in pairs(sourceTbl) do
        if saveTbl[key] == nil then
            saveTbl[key] = value
        end
    end
end

--- Clear retired or renamed keys from the save.
---@param saveTbl table
---@param sourceTbl DelveCompanionAccountData|DelveCompanionCharacterData
local function RemoveRetiredKeys(saveTbl, sourceTbl)
    for key, value in pairs(saveTbl) do
        if sourceTbl[key] == nil then
            saveTbl[key] = nil
        end
    end
end

--- Init [SavedVariables](https://warcraft.wiki.gg/wiki/TOC_format#SavedVariables). The [default config](lua://DelveCompanionAccountData) is used to either init them (e.g. the 1st addon load) or populate with missing fields (e.g. after addon update).
---@param self DelveCompanionSettings
function AddonSettings:ProcessAccountSave()
    -- DelveCompanion.Logger.Log("[DelveCompanionSettings] Init AccountSave...")

    if not DelveCompanionAccountData then
        -- No save. Create a fresh one.
        ---@type DelveCompanionAccountData
        DelveCompanionAccountData = CopyTable(Config.DEFAULT_ACCOUNT_DATA)
    else
        AddNewKeysToSave(DelveCompanionAccountData, Config.DEFAULT_ACCOUNT_DATA)
        RemoveRetiredKeys(DelveCompanionAccountData, Config.DEFAULT_ACCOUNT_DATA)

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
    -- DelveCompanion.Logger.Log("[DelveCompanionSettings] Init CharacterSave...")

    if not DelveCompanionCharacterData then
        -- No save. Create a fresh one.
        ---@type DelveCompanionCharacterData
        DelveCompanionCharacterData = CopyTable(Config.DEFAULT_CHARACTER_DATA)
    else
        AddNewKeysToSave(DelveCompanionCharacterData, Config.DEFAULT_CHARACTER_DATA)
        RemoveRetiredKeys(DelveCompanionCharacterData, Config.DEFAULT_CHARACTER_DATA)
    end
end

--#endregion

--- This callback will be invoked whenever a setting is modified.
local function OnSettingChanged(setting, value)
    -- Logger.Log("[DelveCompanionSettings] OnChanged detected...")

    local variableName = gsub(setting:GetVariable(), SETTING_PREFIX, "")

    -- Logger.Log("[DelveCompanionSettings] Changed var `%s` with value: %s", variableName, tostring(value))
    EventRegistry:TriggerEvent(Definitions.Events.SETTING_CHANGE, variableName, value)
end

--- Create and register an addon Setting.
---@param self DelveCompanionSettings
---@param category table
---@param varKey string
---@param varTbl DelveCompanionAccountData|DelveCompanionCharacterData
---@param defaultValue number|boolean|string
---@param displayText string
---@param onChangedCallback function
---@return table|nil
function AddonSettings:RegisterSetting(category, varKey, varTbl, defaultValue, displayText, onChangedCallback)
    if varTbl[varKey] == nil then
        Logger.Log(Lockit.DEBUG_SAVED_VARIABLE_CONFLICT, varTbl, varKey)
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

    do
        local savedVarKey = "delvesListInfoWidgetsEnabled"

        local setting = self:RegisterSetting(category, savedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.delvesListInfoWidgetsEnabled,
            Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME, OnSettingChanged)

        local tooltip = Lockit.UI_SETTING_DELVES_LIST_INFO_WIDGETS_TOOLTIP
        Settings.CreateCheckbox(category, setting, tooltip)
    end

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

    do
        local controlSavedVarKey = "inDelveWidgetEnabled"
        local dropdownSavedVarKey = "inDelveWidgetDisplayRule"

        local settingName = Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_NAME

        local controlSetting = self:RegisterSetting(category, controlSavedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.inDelveWidgetEnabled,
            settingName, OnSettingChanged)

        local dropdownSetting = self:RegisterSetting(category, dropdownSavedVarKey, savedVarTbl,
            Config.DEFAULT_ACCOUNT_DATA.inDelveWidgetDisplayRule,
            settingName, OnSettingChanged)

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(Definitions.InDelveWidgetDisplayRule.left,
                Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_NAME,
                Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_LEFT_DESCRIPTION)
            container:Add(Definitions.InDelveWidgetDisplayRule.right,
                Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_NAME,
                Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_OPTION_RIGHT_DESCRIPTION)

            return container:GetData()
        end
        local controlTooltip = Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_TOOLTIP
        local dropdownTooltip = Lockit.UI_SETTING_IN_DELVE_WIDGET_DISPLAY_RULE_TOOLTIP

        local initializer = CreateSettingsCheckboxDropdownInitializer(
            controlSetting, settingName, controlTooltip,
            dropdownSetting, GetOptions, settingName, dropdownTooltip)
        layout:AddInitializer(initializer)
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

---@param self DelveCompanionSettings
function AddonSettings:Init()
    -- Logger.Log("[DelveCompanionSettings] Start init...")

    do
        local settingsFrame = CreateFrame("Frame", "$parent.DelveCompanionSettings", nil,
            "DelveCompanionSettingsFrameTemplate")
        local root, _ = Settings.RegisterCanvasLayoutCategory(settingsFrame, Lockit.UI_ADDON_NAME)
        Settings.RegisterAddOnCategory(root)
        self.rootCategory = root
    end

    do
        local options, layout = Settings.RegisterVerticalLayoutSubcategory(self.rootCategory, _G["OPTIONS"])
        self.optionsCategory = options

        self:RegisterAccountSettings(options, layout)
        self:RegisterCharacterSettings(options, layout)

        Settings.RegisterAddOnCategory(options)
    end
end
