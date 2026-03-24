local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

local ldbIcon = LibStub("LibDBIcon-1.0")

--#region Constants

---@type string
local ENABLED_SAVE_KEY = "minimapIconEnabled"

---@type string
local LDB_NAME = addonName .. "_LDBIcon"
--#endregion

---@class (exact) DelveCompanionMinimapIcon
---@field iconObj table
local DelveCompanionMinimapIcon = {}
DelveCompanion.MinimapIcon = DelveCompanionMinimapIcon

--- Initialize Delves list.
---@param self DelveCompanionMinimapIcon
function DelveCompanionMinimapIcon:Init()
    -- Logger:Log("[DelveCompanionMinimapIcon] Init started...")

    ---@param _ any
    ---@param buttonName string
    local function OnClick(_, buttonName)
        DelveCompanion_CompartmentOnClick(addonName, buttonName)
    end

    ---@param tooltip GameTooltip
    local function OnTooltipShow(tooltip)
        DelveCompanion_CompartmentSetTooltipContent(tooltip)
    end

    local mapIcon = LibStub("LibDataBroker-1.1"):NewDataObject(LDB_NAME, {
        type = "launcher",
        label = C_AddOns.GetAddOnMetadata(addonName, "Title"),
        icon = C_AddOns.GetAddOnMetadata(addonName, "IconTexture"),
        OnClick = OnClick,
        OnTooltipShow = OnTooltipShow
    })
    self.iconObj = mapIcon

    local db = DelveCompanionCharacterData.ldbIconData
    db.hide = not DelveCompanionAccountData.minimapIconEnabled
    ldbIcon:Register(LDB_NAME, mapIcon, db)

    do
        ---@param owner DelveCompanionMinimapIcon
        local function OnSettingChanged(owner, changedVarKey, isEnabled)
            if not (changedVarKey == ENABLED_SAVE_KEY) then
                return
            end
            -- Logger:Log("[DelveCompanionMinimapIcon] OnSettingChanged. Enabled: %s...", tostring(isEnabled))

            if isEnabled then
                ldbIcon:Show(LDB_NAME)
            else
                ldbIcon:Hide(LDB_NAME)
            end
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.SETTING_CHANGE, OnSettingChanged, self)
    end
end
