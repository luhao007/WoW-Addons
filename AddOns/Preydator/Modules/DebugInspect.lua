---@diagnostic disable

local Preydator = _G.Preydator
if type(Preydator) ~= "table" or type(Preydator.RegisterModule) ~= "function" then
    return
end

local C_QuestLog = _G.C_QuestLog
local C_Map = _G.C_Map
local C_TaskQuest = _G.C_TaskQuest
local IsInInstance = _G.IsInInstance
local geterrorhandler = _G.geterrorhandler
local GetTime = _G.GetTime
local GetZoneText = _G.GetZoneText
local GetQuestLink = _G.GetQuestLink

local function SafeToNumber(value)
    local ok, converted = pcall(tonumber, value)
    if ok then
        return converted
    end
    return nil
end

local function SafeValue(value)
    if value == nil then
        return "nil"
    end
    local ok, converted = pcall(tostring, value)
    if ok then
        return converted
    end
    return "<tostring failed>"
end

local function FormatTablePairs(tbl)
    if type(tbl) ~= "table" then
        return SafeValue(tbl)
    end

    local parts = {}
    for key, value in pairs(tbl) do
        parts[#parts + 1] = tostring(key) .. "=" .. SafeValue(value)
    end
    table.sort(parts)
    return "{" .. table.concat(parts, ", ") .. "}"
end

local function SendToErrorHandler(reportText, headerText)
    if type(reportText) ~= "string" or reportText == "" then
        return false, "empty report"
    end

    if type(geterrorhandler) ~= "function" then
        return false, "geterrorhandler unavailable"
    end

    local okHandler, handler = pcall(geterrorhandler)
    if not okHandler or type(handler) ~= "function" then
        return false, "error handler unavailable"
    end

    local header = type(headerText) == "string" and headerText ~= "" and headerText or "Preydator Inspect Report"
    local chunkSize = 1800
    local length = #reportText
    local chunks = math.max(1, math.ceil(length / chunkSize))
    for index = 1, chunks do
        local startPos = ((index - 1) * chunkSize) + 1
        local endPos = math.min(index * chunkSize, length)
        local chunk = string.sub(reportText, startPos, endPos)
        local okSend = pcall(handler, string.format("%s [%d/%d]\n%s", header, index, chunks, chunk))

        if not okSend then
            return false, "handler failed on chunk " .. tostring(index)
        end
    end

    return true, "sent"
end

local function BuildQuestInspectReport(requestedQuestID)
    local lines = {}
    local function add(line)
        lines[#lines + 1] = tostring(line or "")
    end

    local state = (type(Preydator.GetState) == "function") and Preydator.GetState() or {}
    local liveQuestID = (C_QuestLog and C_QuestLog.GetActivePreyQuest) and SafeToNumber(C_QuestLog.GetActivePreyQuest()) or nil
    local questID = SafeToNumber(requestedQuestID) or liveQuestID or SafeToNumber(state.activeQuestID)

    local now = GetTime and GetTime() or 0
    local playerMapID = (C_Map and C_Map.GetBestMapForUnit) and C_Map.GetBestMapForUnit("player") or nil
    local playerMapName = nil
    local playerMapType = nil
    if playerMapID and C_Map and C_Map.GetMapInfo then
        local mapInfo = C_Map.GetMapInfo(playerMapID)
        playerMapName = mapInfo and mapInfo.name or nil
        playerMapType = mapInfo and mapInfo.mapType or nil
    end

    local inInstance = nil
    local instanceType = nil
    if IsInInstance then
        local okInstance, rawInInstance, rawInstanceType = pcall(IsInInstance)
        if okInstance then
            inInstance = rawInInstance == true
            instanceType = rawInstanceType
        end
    end

    add("Preydator Quest Inspect (module)")
    add("- time=" .. string.format("%.3f", now) .. " | zone=" .. tostring(GetZoneText and GetZoneText() or "?") .. " | playerMapID=" .. SafeValue(playerMapID) .. " | playerMap=" .. SafeValue(playerMapName))
    add("- requestedQuestID=" .. SafeValue(requestedQuestID) .. " | livePreyQuestID=" .. SafeValue(liveQuestID) .. " | trackedQuestID=" .. SafeValue(state.activeQuestID) .. " | inspectQuestID=" .. SafeValue(questID))

    if not questID or questID <= 0 then
        add("- No valid quest ID available to inspect.")
        local reportText = table.concat(lines, "\n")
        _G.PreydatorLastQuestInspectReport = reportText
        return lines, reportText
    end

    local logIndex = nil
    if C_QuestLog and type(C_QuestLog.GetLogIndexForQuestID) == "function" then
        logIndex = C_QuestLog.GetLogIndexForQuestID(questID)
    end

    local titleForQuestID = nil
    if C_QuestLog and type(C_QuestLog.GetTitleForQuestID) == "function" then
        local titleInfo = C_QuestLog.GetTitleForQuestID(questID)
        if type(titleInfo) == "table" then
            titleForQuestID = titleInfo.title
        else
            titleForQuestID = titleInfo
        end
    end

    local questLink = nil
    if type(GetQuestLink) == "function" then
        questLink = GetQuestLink(questID)
    end

    local questZoneMapID = nil
    if C_TaskQuest and type(C_TaskQuest.GetQuestZoneID) == "function" then
        questZoneMapID = C_TaskQuest.GetQuestZoneID(questID)
    end

    local questZoneName = nil
    if questZoneMapID and C_Map and type(C_Map.GetMapInfo) == "function" then
        local zoneInfo = C_Map.GetMapInfo(questZoneMapID)
        questZoneName = zoneInfo and zoneInfo.name or nil
    end

    add("- basic | logIndex=" .. SafeValue(logIndex) .. " | title=" .. SafeValue(titleForQuestID) .. " | link=" .. SafeValue(questLink))
    add("- zoneHint | taskQuestMapID=" .. SafeValue(questZoneMapID) .. " | taskQuestZone=" .. SafeValue(questZoneName) .. " | state.preyZoneMapID=" .. SafeValue(state.preyZoneMapID) .. " | state.preyZoneName=" .. SafeValue(state.preyZoneName) .. " | state.inPreyZone=" .. SafeValue(state.inPreyZone))

    if C_QuestLog then
        if type(C_QuestLog.IsOnQuest) == "function" then
            add("- flags | isOnQuest=" .. SafeValue(C_QuestLog.IsOnQuest(questID)))
        end
        if type(C_QuestLog.IsQuestFlaggedCompleted) == "function" then
            add("- flags | isFlaggedCompleted=" .. SafeValue(C_QuestLog.IsQuestFlaggedCompleted(questID)))
        end
    end

    if logIndex and C_QuestLog and type(C_QuestLog.GetInfo) == "function" then
        local info = C_QuestLog.GetInfo(logIndex)
        add("- GetInfo(" .. tostring(logIndex) .. ")=" .. FormatTablePairs(info))
    else
        add("- GetInfo unavailable: no logIndex")
    end

    if C_QuestLog and type(C_QuestLog.GetQuestTagInfo) == "function" then
        local tagInfo = C_QuestLog.GetQuestTagInfo(questID)
        add("- GetQuestTagInfo=" .. FormatTablePairs(tagInfo))
    end

    if C_QuestLog and type(C_QuestLog.GetQuestObjectives) == "function" then
        local objectives = C_QuestLog.GetQuestObjectives(questID)
        if type(objectives) == "table" and #objectives > 0 then
            add("- objectives count=" .. tostring(#objectives))
            for idx, obj in ipairs(objectives) do
                add("  - [" .. tostring(idx) .. "] " .. FormatTablePairs(obj))
            end
        else
            add("- objectives count=0")
        end
    end

    local reportText = table.concat(lines, "\n")
    _G.PreydatorLastQuestInspectReport = reportText
    return lines, reportText
end

local function BuildInspectReport()
    local lines = {}
    local function add(line)
        lines[#lines + 1] = tostring(line or "")
    end

    local state = (type(Preydator.GetState) == "function") and Preydator.GetState() or {}
    local settings = (type(Preydator.GetSettings) == "function") and Preydator.GetSettings() or {}
    local barFrame = (type(Preydator.GetBarFrame) == "function") and Preydator.GetBarFrame() or nil
    local labelFrames = (type(Preydator.GetLabelFrames) == "function") and Preydator.GetLabelFrames() or nil

    local function FormatPoint(frameRef)
        if not frameRef or not frameRef.GetPoint then
            return "<no-frame>"
        end

        local ok, point, relativeTo, relativePoint, xOfs, yOfs = pcall(frameRef.GetPoint, frameRef, 1)
        if not ok then
            return "<point-error>"
        end

        local relName = "<nil>"
        if relativeTo and relativeTo.GetName then
            relName = relativeTo:GetName() or "<unnamed>"
        end

        return string.format("%s -> %s:%s (%s,%s)", tostring(point), tostring(relName), tostring(relativePoint), tostring(xOfs), tostring(yOfs))
    end

    local liveQuestID = (C_QuestLog and C_QuestLog.GetActivePreyQuest) and C_QuestLog.GetActivePreyQuest() or nil
    local hasActiveQuest = type(liveQuestID) == "number" and liveQuestID > 0
    local now = GetTime and GetTime() or 0

    local playerMapID = (C_Map and C_Map.GetBestMapForUnit) and C_Map.GetBestMapForUnit("player") or nil
    local playerMapName = nil
    local playerMapType = nil
    if playerMapID and C_Map and C_Map.GetMapInfo then
        local mapInfo = C_Map.GetMapInfo(playerMapID)
        playerMapName = mapInfo and mapInfo.name or nil
        playerMapType = mapInfo and mapInfo.mapType or nil
    end

    local inInstance = nil
    local instanceType = nil
    if IsInInstance then
        local okInstance, rawInInstance, rawInstanceType = pcall(IsInInstance)
        if okInstance then
            inInstance = rawInInstance == true
            instanceType = rawInstanceType
        end
    end

    add("Preydator Inspect (module)")
    add("- time=" .. string.format("%.3f", now) .. " | zone=" .. tostring(GetZoneText and GetZoneText() or "?") .. " | playerMapID=" .. tostring(playerMapID) .. " | playerMap=" .. tostring(playerMapName))
    add("- instance inInstance=" .. tostring(inInstance) .. " | instanceType=" .. tostring(instanceType) .. " | playerMapType=" .. tostring(playerMapType))
    add("- quest live=" .. tostring(liveQuestID) .. " | hasActive=" .. tostring(hasActiveQuest) .. " | tracked=" .. tostring(state.activeQuestID))
    add("- state stage=" .. tostring(state.stage) .. " | progressState=" .. tostring(state.progressState) .. " | progressPercent=" .. tostring(state.progressPercent))
    add("- preyZone mapID=" .. tostring(state.preyZoneMapID) .. " | preyZoneName=" .. tostring(state.preyZoneName) .. " | zoneCacheDirty=" .. tostring(state.zoneCacheDirty))
    add("- inPreyZone=" .. tostring(state.inPreyZone)
        .. " | onlyShowInPreyZone=" .. tostring(settings and settings.onlyShowInPreyZone == true)
        .. " | disableDefaultPreyIcon=" .. tostring(settings and settings.disableDefaultPreyIcon == true))
    add("- settings size width=" .. tostring(settings and settings.width)
        .. " | height=" .. tostring(settings and settings.height)
        .. " | scale=" .. tostring(settings and settings.scale))
    add("- settings layout"
        .. " | orientation=" .. tostring(settings and settings.orientation)
        .. " | fillDir=" .. tostring(settings and settings.verticalFillDirection)
        .. " | labelMode=" .. tostring(settings and settings.stageLabelMode)
        .. " | labelRow=" .. tostring(settings and settings.labelRowPosition)
        .. " | vTextAlign=" .. tostring(settings and settings.verticalTextAlign)
        .. " | vTextSide=" .. tostring(settings and settings.verticalTextSide)
        .. " | vTextOffset=" .. tostring(settings and settings.verticalTextOffset)
        .. " | vPctDisplay=" .. tostring(settings and settings.verticalPercentDisplay)
        .. " | vPctSide=" .. tostring(settings and settings.verticalPercentSide)
        .. " | vPctOffset=" .. tostring(settings and settings.verticalPercentOffset))

    if barFrame then
        local liveWidth = barFrame.GetWidth and barFrame:GetWidth() or "?"
        local liveHeight = barFrame.GetHeight and barFrame:GetHeight() or "?"
        local liveScale = barFrame.GetScale and barFrame:GetScale() or "?"
        local liveEffectiveScale = barFrame.GetEffectiveScale and barFrame:GetEffectiveScale() or "?"
        local savedPoint = settings and settings.point or {}
        local savedX = savedPoint and savedPoint.x
        local savedY = savedPoint and savedPoint.y
        local liveX = nil
        local liveY = nil
        if barFrame.GetCenter and UIParent and UIParent.GetCenter then
            local okCenter, frameCenterX, frameCenterY = pcall(barFrame.GetCenter, barFrame)
            local okParentCenter, parentCenterX, parentCenterY = pcall(UIParent.GetCenter, UIParent)
            if okCenter and okParentCenter and frameCenterX and frameCenterY and parentCenterX and parentCenterY then
                liveX = frameCenterX - parentCenterX
                liveY = frameCenterY - parentCenterY
            end
        end
        add("- bar shown=" .. tostring(barFrame.IsShown and barFrame:IsShown() or false)
            .. " | mouse=" .. tostring(barFrame.IsMouseEnabled and barFrame:IsMouseEnabled() or false)
            .. " | width=" .. tostring(liveWidth)
            .. " | height=" .. tostring(liveHeight)
            .. " | scale=" .. tostring(liveScale)
            .. " | effectiveScale=" .. tostring(liveEffectiveScale))
        add("- bar position savedX=" .. tostring(savedX)
            .. " | savedY=" .. tostring(savedY)
            .. " | liveX=" .. tostring(liveX and math.floor((liveX * 100) + 0.5) / 100 or nil)
            .. " | liveY=" .. tostring(liveY and math.floor((liveY * 100) + 0.5) / 100 or nil)
            .. " | point=" .. FormatPoint(barFrame))
    else
        add("- bar frame unavailable")
    end

    if type(labelFrames) == "table" then
        local prefix = labelFrames.prefix
        local suffix = labelFrames.suffix
        local percent = labelFrames.percent

        add("- prefix"
            .. " | shown=" .. tostring(prefix and prefix.IsShown and prefix:IsShown() or false)
            .. " | text='" .. tostring(prefix and prefix.GetText and prefix:GetText() or "") .. "'"
            .. " | point=" .. FormatPoint(prefix))
        add("- suffix"
            .. " | shown=" .. tostring(suffix and suffix.IsShown and suffix:IsShown() or false)
            .. " | text='" .. tostring(suffix and suffix.GetText and suffix:GetText() or "") .. "'"
            .. " | point=" .. FormatPoint(suffix))
        add("- percent"
            .. " | shown=" .. tostring(percent and percent.IsShown and percent:IsShown() or false)
            .. " | text='" .. tostring(percent and percent.GetText and percent:GetText() or "") .. "'"
            .. " | point=" .. FormatPoint(percent))
    end

    local reportText = table.concat(lines, "\n")
    _G.PreydatorLastInspectReport = reportText
    return lines, reportText
end

local DebugInspectModule = {}

function DebugInspectModule:OnSlashCommand(text, rest)
    if text ~= "inspect" and text ~= "inspectbug" and text ~= "inspectbugsack" and text ~= "inspectbs" and text ~= "inspectboth"
        and text ~= "inspectquest" and text ~= "inspectquestbug" and text ~= "inspectquestbs" and text ~= "inspectquestboth"
        and text ~= "qinspect" then
        return false
    end

    local isQuestInspect = (text == "inspectquest" or text == "inspectquestbug" or text == "inspectquestbs" or text == "inspectquestboth" or text == "qinspect")

    local mode = "chat"
    if text == "inspectbug" or text == "inspectbugsack" or text == "inspectbs" or text == "inspectquestbug" or text == "inspectquestbs" then
        mode = "bugsack"
    elseif text == "inspectboth" or text == "inspectquestboth" then
        mode = "both"
    else
        local inspectMode = string.lower((rest or ""):match("^%s*(.-)%s*$"))
        if inspectMode == "bug" or inspectMode == "bugsack" or inspectMode == "bs" then
            mode = "bugsack"
        elseif inspectMode == "both" then
            mode = "both"
        end
    end

    local lines, reportText
    if isQuestInspect then
        local questToken = tostring((rest or ""):match("^%s*(%S+)") or "")
        local requestedQuestID = tonumber(questToken)
        lines, reportText = BuildQuestInspectReport(requestedQuestID)
    else
        lines, reportText = BuildInspectReport()
    end

    if mode == "chat" or mode == "both" then
        for _, line in ipairs(lines) do
            print(line)
        end
    end

    if mode == "bugsack" or mode == "both" then
        local header = isQuestInspect and "Preydator Quest Inspect Report" or "Preydator Inspect Report"
        local sent, reason = SendToErrorHandler(reportText, header)
        if sent then
            if isQuestInspect then
                print("Preydator: Quest inspect report sent to BugSack via error handler (debug module).")
            else
                print("Preydator: Inspect report sent to BugSack via error handler (debug module).")
            end
        else
            print(L["Preydator: Could not send inspect report to BugSack: "] .. tostring(reason))
        end
    end

    if isQuestInspect then
        print("Preydator: Quest inspect report cached in PreydatorLastQuestInspectReport (debug module).")
    else
        print("Preydator: Inspect report cached in PreydatorLastInspectReport (debug module).")
    end
    return true
end

Preydator:RegisterModule("DebugInspect", DebugInspectModule)
