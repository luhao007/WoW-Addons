local ADDON_NAME, ADDON = ...

-- CREATE THE ADDON FRAME
local QuestCounter = CreateFrame("Frame", "QuestCounterFrame")

-- MAXIMUM NUMBER OF QUESTS
local MAX_QUESTS = 35

-- GET THE BEST AVAILABLE QUEST HEADER FONTSTRING
local function GetQuestHeaderTextObject()
    -- VARIANT 1: ORIGINAL TARGET
    if QuestObjectiveTracker and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.Text then
        return QuestObjectiveTracker.Header.Text
    end

    -- VARIANT 2: COMMON DEFAULT UI TARGET
    if ObjectiveTrackerFrame and ObjectiveTrackerFrame.Header and ObjectiveTrackerFrame.Header.Text then
        return ObjectiveTrackerFrame.Header.Text
    end

    -- VARIANT 3: BLOCKS FRAME QUEST HEADER
    if ObjectiveTrackerBlocksFrame and ObjectiveTrackerBlocksFrame.QuestHeader and ObjectiveTrackerBlocksFrame.QuestHeader.Text then
        return ObjectiveTrackerBlocksFrame.QuestHeader.Text
    end

    return nil
end

-- COUNT ACTUAL QUESTS IN THE QUEST LOG
local function CountQuests()
    local questsCounted = 0
    local numQuestLogEntries = C_QuestLog.GetNumQuestLogEntries()

    for index = 1, numQuestLogEntries do
        local questInfo = C_QuestLog.GetInfo(index)

        if questInfo and not questInfo.isHeader and not questInfo.isHidden then
            questsCounted = questsCounted + 1
        end
    end

    return questsCounted
end

-- UPDATE THE QUEST COUNT DISPLAY
function QuestCounter:UpdateQuestCount()
    local headerText = GetQuestHeaderTextObject()
    if not headerText then
        return
    end

    local questsCounted = CountQuests()
    local displayText = string.format("Quests (%d / %d)", questsCounted, MAX_QUESTS)
    headerText:SetText(displayText)
end

-- APPLY SAFE HOOKS SO BLIZZARD REFRESHES DON'T OVERWRITE THE HEADER TEXT
function QuestCounter:HookObjectiveTracker()
    -- HOOK ON-SHOW FOR WHATEVER HEADER OBJECT EXISTS
    local headerText = GetQuestHeaderTextObject()
    if headerText and headerText.GetParent then
        local header = headerText:GetParent()
        if header and header.HookScript then
            header:HookScript("OnShow", function()
                QuestCounter:UpdateQuestCount()
            end)
        end
    end

    -- HOOK THE GLOBAL UPDATE IF IT EXISTS
    if type(ObjectiveTracker_Update) == "function" then
        hooksecurefunc("ObjectiveTracker_Update", function()
            QuestCounter:UpdateQuestCount()
        end)
    end

    -- HOOK THE FRAME UPDATE METHOD IF IT EXISTS
    if ObjectiveTrackerFrame and type(ObjectiveTrackerFrame.Update) == "function" then
        hooksecurefunc(ObjectiveTrackerFrame, "Update", function()
            QuestCounter:UpdateQuestCount()
        end)
    end
end

-- INITIALIZE AFTER PLAYER_LOGIN SO THE TRACKER IS MORE LIKELY TO EXIST
function QuestCounter:Initialize()
    -- HOOK TRACKER REFRESH POINTS
    self:HookObjectiveTracker()

    -- FORCE AN INITIAL UPDATE
    self:UpdateQuestCount()
end

-- EVENT HANDLER
function QuestCounter:OnEvent(event, ...)
    if event == "PLAYER_LOGIN" then
        self:Initialize()
        return
    end

    -- UPDATE ON QUEST/LOG CHANGES
    if event == "QUEST_ACCEPTED"
        or event == "QUEST_AUTOCOMPLETE"
        or event == "QUEST_LOG_UPDATE"
        or event == "QUEST_REMOVED"
        or event == "QUEST_WATCH_LIST_CHANGED"
        or event == "UNIT_QUEST_LOG_CHANGED" then
        self:UpdateQuestCount()
    end
end

-- REGISTER EVENTS
QuestCounter:RegisterEvent("PLAYER_LOGIN")
QuestCounter:RegisterEvent("QUEST_ACCEPTED")
QuestCounter:RegisterEvent("QUEST_AUTOCOMPLETE")
QuestCounter:RegisterEvent("QUEST_LOG_UPDATE")
QuestCounter:RegisterEvent("QUEST_REMOVED")
QuestCounter:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
QuestCounter:RegisterUnitEvent("UNIT_QUEST_LOG_CHANGED", "player")

-- SET THE SCRIPT HANDLER
QuestCounter:SetScript("OnEvent", function(self, event, ...)
    self:OnEvent(event, ...)
end)