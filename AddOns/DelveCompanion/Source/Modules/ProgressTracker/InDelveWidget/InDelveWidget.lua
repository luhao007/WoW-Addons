local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

---@type string
local ENABLED_SAVE_KEY = "inDelveWidgetEnabled"
--#endregion

---@class (exact) InDelveWidget
---@field frame InDelveWidgetFrame
---@field setupInProgress boolean Used to prevent double call of the setup which may occur due to the timer delay.
local InDelveWidget = {}
DelveCompanion.InDelveWidget = InDelveWidget

---@param self InDelveWidget
---@param isForced boolean
function InDelveWidget:Refresh(isForced)
    -- Logger:Log("[InDelveWidget] Refresh...")

    if not DelveCompanionAccountData.inDelveWidgetEnabled or not DelveCompanion.ProgressTracker.isDelveInProgress then
        self:HideWidget()
        return
    end

    if self.frame.isSet or self.setupInProgress then
        return
    end

    self.setupInProgress = true
    -- Timer is required for a case when player switches between characters while one of them is in a Delve.
    -- For unknown reason, the continent cannot be retrieved immediately logging back to the character in a Delve. And the widget gets broken.
    C_Timer.After(2,
        function()
            if not self.setupInProgress then
                return
            end

            local delveContinent = DelveCompanion:GetContinentMapIDForMap(C_Map.GetBestMapForUnit("player"))

            self.frame.delveExpansion = FindInTableIf(
                Config.DELVE_CONTINENTS,
                function(continentMapID)
                    return continentMapID == delveContinent
                end
            )

            self.frame:PrepareWidget(isForced)
            self.frame:Show()

            self.setupInProgress = false
        end
    )
end

---@param self InDelveWidget
function InDelveWidget:HideWidget()
    -- Logger:Log("[InDelveWidget] Hide widget...")

    self.setupInProgress = false
    self.frame:Hide()
end

--- It's called before PLAYER_LOGIN so WoW saves its position and handles repositioning between sessions.
---@param self InDelveWidget
function InDelveWidget:PreloadFrame()
    -- Logger:Log("[InDelveWidget] PreloadFrame...")

    local widgetFrame = CreateFrame("Frame", "DelveCompanion.InDelveWidgetFrame",
        UIParent, "DelvelCompanionInDelveWidgetFrameTemplate")
    self.frame = widgetFrame
end

---@param self InDelveWidget
function InDelveWidget:Init()
    -- Logger:Log("[InDelveWidget] Init started...")

    self.setupInProgress = false

    do
        ---@param owner InDelveWidget
        local function OnDelveInProgressChanged(owner)
            -- Logger:Log("[InDelveWidget] OnProgressChanged. State: %s", tostring(DelveCompanion.ProgressTracker.isDelveInProgress))

            owner:Refresh(false)
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_IN_PROGRESS,
            OnDelveInProgressChanged, self)
    end

    do
        ---@param owner InDelveWidget
        local function OnSettingChanged(owner, changedVarKey, isEnabled)
            if not (changedVarKey == ENABLED_SAVE_KEY) then
                return
            end
            -- Logger:Log("[InDelveWidget] OnSettingChanged. Enabled: %s...", tostring(isEnabled))

            owner:Refresh(true)
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.SETTING_CHANGE, OnSettingChanged, self)
    end

    if DelveCompanion.ProgressTracker.isDelveInProgress then
        -- Logger:Log("[InDelveWidget] Already in Delve. Forced setup.")
        self:Refresh(true)
    end
end
