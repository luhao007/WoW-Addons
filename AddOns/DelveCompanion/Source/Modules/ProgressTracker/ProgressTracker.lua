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

local EVENT_FRAME_NAME = "DelveCompanionProgressTrackingFrame"

local RESPAWN_SPELL = 433110
--#endregion

---@class (exact) ProgressTracker
---@field eventFrame Frame
---@field isDelveInProgress boolean
local ProgressTracker = {}
DelveCompanion.ProgressTracker = ProgressTracker

local baseEvents = {
    "SCENARIO_CRITERIA_UPDATE",
    "ZONE_CHANGED_NEW_AREA",
    "DISPLAY_EVENT_TOAST_LINK"
}

---@param self ProgressTracker
function ProgressTracker:UpdateDelveStatus()
    -- Logger:Log("[ProgressTracker] DelveStatus: InP: %s ||| IsC: %s",
    --     tostring(C_PartyInfo.IsDelveInProgress()),
    --     tostring(C_PartyInfo.IsDelveComplete()))
    self.isDelveInProgress = C_PartyInfo.IsDelveInProgress() and not C_PartyInfo.IsDelveComplete()
end

---@param self ProgressTracker
function ProgressTracker:ProcessEvent(eventName, arg1, ...)
    self:UpdateDelveStatus()
    -- local widgetInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6183)

    if eventName == "SCENARIO_UPDATE" then
        if self.isDelveInProgress then
            FrameUtil.RegisterFrameForEvents(self.eventFrame, baseEvents)

            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_IN_PROGRESS)
        end
    elseif eventName == "SCENARIO_CRITERIA_UPDATE" then
        if C_PartyInfo.IsDelveComplete() then
            self.eventFrame:UnregisterEvent("SCENARIO_CRITERIA_UPDATE")

            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_COMPLETE)
        end
    elseif eventName == "DISPLAY_EVENT_TOAST_LINK" then
        if string.match(arg1, RESPAWN_SPELL) ~= nil then
            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_RESPAWN_ACTIVATED)

            self.eventFrame:UnregisterEvent("DISPLAY_EVENT_TOAST_LINK")
        end
    elseif eventName == "ZONE_CHANGED_NEW_AREA" then
        if not self.isDelveInProgress then
            FrameUtil.UnregisterFrameForEvents(self.eventFrame, baseEvents)

            EventRegistry:TriggerEvent(DelveCompanion.Definitions.Events.PROGRESS_TRACKER.DELVE_IN_PROGRESS)
        end
    end
end

---@param self ProgressTracker
function ProgressTracker:Init()
    -- Logger:Log("[ProgressTracker] Init started...")

    self:UpdateDelveStatus()

    local frame = CreateFrame("Frame", EVENT_FRAME_NAME, UIParent)
    frame:RegisterEvent("SCENARIO_UPDATE")
    frame:SetScript("OnEvent", function(owner, eventName, arg1, ...)
        C_Timer.After(0.5, function(...)
            self:ProcessEvent(eventName, arg1, ...)
        end)
    end)
    self.eventFrame = frame

    if self.isDelveInProgress then
        -- If UI Reload or Login happens in the midst of the Delve, force register required events.
        FrameUtil.RegisterFrameForEvents(self.eventFrame, baseEvents)
    end
end
