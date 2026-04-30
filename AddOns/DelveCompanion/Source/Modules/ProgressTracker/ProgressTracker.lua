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
local EVENT_FRAME_NAME = "DelveCompanionProgressTrackingFrame"
---@type string
local SCENARIO_DELVE_NAME = _G["DELVES_LABEL"]

---@type number
local EVENT_PROCESSING_DELAY = 1

---@type number
local RESPAWN_SPELL = 433110
--#endregion

---@class (exact) ProgressTracker
---@field EventFrame Frame
---@field isSubscribed boolean
---@field isDelveInProgress boolean
---@field lastSeenScenario string
local ProgressTracker = {}
DelveCompanion.ProgressTracker = ProgressTracker

local baseEvents = {
    "SCENARIO_CRITERIA_UPDATE",
    "ZONE_CHANGED_NEW_AREA",
    "DISPLAY_EVENT_TOAST_LINK"
}

---@param self ProgressTracker
function ProgressTracker:Init()
    -- Logger:Log("[ProgressTracker] Init started...")

    local frame = CreateFrame("Frame", EVENT_FRAME_NAME, UIParent)
    frame:RegisterEvent("SCENARIO_UPDATE")

    ---@param owner Frame
    ---@param eventName string
    ---@param arg1 any
    ---@param ... any
    local function ProcessEventInternal(owner, eventName, arg1, ...)
        C_Timer.After(EVENT_PROCESSING_DELAY, function(...)
            self:ProcessEvent(eventName, arg1, ...)
        end)
    end

    frame:SetScript("OnEvent", ProcessEventInternal)
    self.EventFrame = frame

    self:UpdateSeenScenario()
    self:UpdateDelveStatus()
    if self.isDelveInProgress then
        -- If UI Reload or Login happens in the midst of the Delve, force register required events.
        FrameUtil.RegisterFrameForEvents(self.EventFrame, baseEvents)
    end
end

---@param self ProgressTracker
function ProgressTracker:UpdateSeenScenario()
    self.lastSeenScenario = select(1, C_Scenario.GetInfo())

    -- Logger:Log("[ProgressTracker] Scenario: %s", tostring(self.lastSeenScenario))
end

---@param self ProgressTracker
function ProgressTracker:UpdateDelveStatus()
    self.isDelveInProgress = select(1, C_Scenario.GetInfo()) == SCENARIO_DELVE_NAME

    -- Logger:Log("[ProgressTracker] DelveStatus: %s", tostring(self.isDelveInProgress))
end

---@param self ProgressTracker
function ProgressTracker:ProcessEvent(eventName, arg1, ...)
    -- Logger:Log("[ProgressTracker] Processing event: %s", eventName)

    self:UpdateDelveStatus()

    -- local widgetInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6183)
    if eventName == "SCENARIO_UPDATE" then
        if self.isDelveInProgress and not self.isSubscribed then
            self:UpdateSeenScenario()

            FrameUtil.RegisterFrameForEvents(self.EventFrame, baseEvents)
            self.isSubscribed = true

            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_IN_PROGRESS)
        end
    elseif eventName == "SCENARIO_CRITERIA_UPDATE" then
        if C_PartyInfo.IsDelveComplete() then
            self.EventFrame:UnregisterEvent("SCENARIO_CRITERIA_UPDATE")

            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_COMPLETED)
        end
    elseif eventName == "DISPLAY_EVENT_TOAST_LINK" then
        if string.match(arg1, RESPAWN_SPELL) ~= nil then
            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_RESPAWN_ACTIVATED)

            self.EventFrame:UnregisterEvent("DISPLAY_EVENT_TOAST_LINK")
        end
    elseif eventName == "ZONE_CHANGED_NEW_AREA" then
        if self.lastSeenScenario == SCENARIO_DELVE_NAME and not self.isDelveInProgress then
            FrameUtil.UnregisterFrameForEvents(self.EventFrame, baseEvents)
            self.isSubscribed = false

            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_EXITED)
        end
    end
end
