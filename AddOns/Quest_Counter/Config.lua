local ADDON_NAME, ADDON = ...

-- CREATE THE ADDON FRAME
local QuestCounter = CreateFrame("Frame", "QuestCounterFrame")

-- MAXIMUM NUMBER OF STANDARD QUESTS
local MAX_QUESTS = 35

-- GET THE BEST AVAILABLE QUEST HEADER FONTSTRING
local function GetQuestHeaderTextObject()
    -- VARIANT 1: MODERN TARGET (THE ONLY RELIABLE ONE IN CURRENT RETAIL)
    if QuestObjectiveTracker and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.Text then
        return QuestObjectiveTracker.Header.Text
    end

    -- VARIANT 2: CAMPAIGN TRACKER BACKUP
    if CampaignQuestObjectiveTracker and CampaignQuestObjectiveTracker.Header and CampaignQuestObjectiveTracker.Header.Text then
        return CampaignQuestObjectiveTracker.Header.Text
    end

    return nil
end

-- COUNT ACTUAL STANDARD QUESTS IN THE QUEST LOG
local function CountQuests()
    -- DIRECTLY ITERATE THE QUEST LOG ENTRIES
    local questsCounted = 0
    local numEntries = C_QuestLog.GetNumQuestLogEntries()
    
    for i = 1, numEntries do
        local info = C_QuestLog.GetInfo(i)
        
        -- 1. ENSURE IT IS A VALID ENTRY AND NOT A HEADER, TASK (BONUS OBJECTIVE), OR BOUNTY
        -- 2. ENSURE IT IS NOT A HIDDEN TRACKER QUEST
        if info and not info.isHeader and not info.isTask and not info.isBounty and not info.isHidden then
            
            -- 3. EXCLUDE ACCOUNT-WIDE QUESTS (LIKE PET BATTLES) WHICH DO NOT COUNT TOWARDS THE 35 CAP
            -- ENSURE QUESTID EXISTS BEFORE CHECKING ACCOUNT STATUS
            if info.questID and not C_QuestLog.IsAccountQuest(info.questID) then
                questsCounted = questsCounted + 1
            end
            
        end
    end
    
    -- JUST IN CASE AN EDGE CASE CAUSES A NEGATIVE NUMBER, FLOOR IT TO 0
    if questsCounted < 0 then
        questsCounted = 0
    end
    
    return questsCounted
end

-- UPDATE THE QUEST COUNT DISPLAY
function QuestCounter:UpdateQuestCount()
    local headerText = GetQuestHeaderTextObject()
    
    if headerText then
        local currentCount = CountQuests()
        
        -- FORMAT AND SET THE TEXT (E.G., "QUESTS (12/35)")
        -- USE THE BLIZZARD GLOBAL "TRACKER_HEADER_QUESTS" TO ENSURE PROPER LOCALIZATION
        headerText:SetText(TRACKER_HEADER_QUESTS .. " (" .. currentCount .. "/" .. MAX_QUESTS .. ")")
    end
end

-- HOOK INTO THE MODERN OBJECTIVE TRACKER UPDATES
function QuestCounter:HookObjectiveTracker()
    -- HOOK THE QUEST TRACKER
    if QuestObjectiveTracker and type(QuestObjectiveTracker.Update) == "function" then
        hooksecurefunc(QuestObjectiveTracker, "Update", function()
            QuestCounter:UpdateQuestCount()
        end)
    end

    -- HOOK THE CAMPAIGN TRACKER
    if CampaignQuestObjectiveTracker and type(CampaignQuestObjectiveTracker.Update) == "function" then
        hooksecurefunc(CampaignQuestObjectiveTracker, "Update", function()
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
QuestCounter:SetScript("OnEvent", QuestCounter.OnEvent)