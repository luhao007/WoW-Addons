---@diagnostic disable

local Preydator = _G.Preydator
if type(Preydator) ~= "table" then
    return
end

local ReportWindowModule = {}
Preydator:RegisterModule("ReportWindow", ReportWindowModule)

local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local rawget = _G.rawget
local GetServerTime = _G.GetServerTime
local UnitGUID = _G.UnitGUID

local reportFrame = nil
local reportWidgets = {
    titleLabel = nil,
    pageLabel = nil,
    backButton = nil,
    nextButton = nil,
    editBox = nil,
}
local reportState = {
    history = {},
    index = 0,
}
local REPORT_PERSIST_KEY = "reportWindowStateV1"
local REPORT_RELOAD_GRACE_SECONDS = 180
local REPORT_HISTORY_MAX = 60

local function callMethod(target, methodName, ...)
    local method = target and target[methodName]
    if type(method) == "function" then
        method(target, ...)
    end
end

local function toReportText(value)
    if type(value) == "table" then
        return table.concat(value, "\n")
    end

    return tostring(value or "")
end

local function trimHistoryIfNeeded()
    local removed = 0
    local overflow = #reportState.history - REPORT_HISTORY_MAX
    while overflow > 0 do
        table.remove(reportState.history, 1)
        overflow = overflow - 1
        removed = removed + 1
    end

    reportState.index = reportState.index - removed
    if reportState.index < 1 then
        reportState.index = #reportState.history
    end
end

local function getPersistRoot()
    _G.PreydatorDebugDB = _G.PreydatorDebugDB or {}
    return _G.PreydatorDebugDB
end

local function persistHistory()
    local root = getPersistRoot()

    local historyCopy = {}
    for index, entry in ipairs(reportState.history) do
        historyCopy[index] = {
            title = tostring(entry.title or "Preydator Report"),
            text = tostring(entry.text or ""),
        }
    end

    local now = nil
    if type(GetServerTime) == "function" then
        now = tonumber(GetServerTime())
    end

    local playerGUID = nil
    if type(UnitGUID) == "function" then
        playerGUID = UnitGUID("player")
    end

    root[REPORT_PERSIST_KEY] = {
        savedAt = now,
        playerGUID = playerGUID,
        index = tonumber(reportState.index) or #historyCopy,
        history = historyCopy,
    }
end

local function restoreHistoryFromPersistence()
    local root = getPersistRoot()

    local persisted = root[REPORT_PERSIST_KEY]
    if type(persisted) ~= "table" then
        return
    end

    local now = nil
    if type(GetServerTime) == "function" then
        now = tonumber(GetServerTime())
    end

    local samePlayer = true
    if type(UnitGUID) == "function" and type(persisted.playerGUID) == "string" then
        samePlayer = UnitGUID("player") == persisted.playerGUID
    end

    local isLikelyReload = false
    if type(now) == "number" and type(persisted.savedAt) == "number" then
        isLikelyReload = (now - persisted.savedAt) <= REPORT_RELOAD_GRACE_SECONDS
    end

    if samePlayer and isLikelyReload and type(persisted.history) == "table" and #persisted.history > 0 then
        reportState.history = {}
        for _, entry in ipairs(persisted.history) do
            reportState.history[#reportState.history + 1] = {
                title = tostring(entry.title or "Preydator Report"),
                text = tostring(entry.text or ""),
            }
        end

        local restoredIndex = tonumber(persisted.index) or #reportState.history
        if restoredIndex < 1 then
            restoredIndex = 1
        end
        if restoredIndex > #reportState.history then
            restoredIndex = #reportState.history
        end
        reportState.index = restoredIndex
        trimHistoryIfNeeded()
        persistHistory()
        return
    end

    root[REPORT_PERSIST_KEY] = nil
    reportState.history = {}
    reportState.index = 0
end

local function focusAndHighlightReport()
    local editBox = reportWidgets.editBox
    if not editBox then
        return
    end

    local text = ""
    if type(editBox.GetText) == "function" then
        local okText, value = pcall(editBox.GetText, editBox)
        if okText and type(value) == "string" then
            text = value
        end
    end
    callMethod(editBox, "EnableKeyboard", true)
    callMethod(editBox, "EnableMouse", true)
    callMethod(editBox, "SetFocus")
    -- Official API behavior: HighlightText(0, -1) selects full text.
    callMethod(editBox, "HighlightText", 0, -1)
end

local function updateButtons()
    local frame = reportFrame
    if not frame then
        return
    end

    local backButton = reportWidgets.backButton
    local nextButton = reportWidgets.nextButton
    if backButton then
        callMethod(backButton, "SetEnabled", reportState.index > 1)
    end

    if nextButton then
        callMethod(nextButton, "SetEnabled", reportState.index < #reportState.history)
    end
end

local function renderCurrentReport()
    local frame = reportFrame
    if not frame then
        return
    end

    local entry = reportState.history[reportState.index]
    if not entry then
        entry = {
            title = "Preydator Report",
            text = "",
        }
    end

    if reportWidgets.titleLabel then
        callMethod(reportWidgets.titleLabel, "SetText", entry.title or "Preydator Report")
    end
    if reportWidgets.pageLabel then
        callMethod(reportWidgets.pageLabel, "SetText", tostring(reportState.index) .. "/" .. tostring(#reportState.history))
    end
    if reportWidgets.editBox then
        callMethod(reportWidgets.editBox, "SetText", entry.text or "")
        focusAndHighlightReport()
    end

    updateButtons()
    frame:Show()
end

local function buildFrame()
    local frame = CreateFrame("Frame", "PreydatorReportWindow", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(620, 440)
    frame:SetPoint("center", UIParent, "center", 0, 0)
    frame:SetMovable(true)
    callMethod(frame, "SetResizable", true)
    callMethod(frame, "SetMinResize", 520, 320)
    callMethod(frame, "SetMaxResize", 1200, 900)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetScript("OnHide", function(self)
        callMethod(self, "StopMovingOrSizing")
        if self.EditBox and type(self.EditBox.ClearFocus) == "function" then
            self.EditBox:ClearFocus()
        end
    end)
    frame:Hide()

    local specialFrames = rawget(_G, "UISpecialFrames")
    if type(specialFrames) == "table" then
        local alreadyRegistered = false
        for _, frameName in ipairs(specialFrames) do
            if frameName == "PreydatorReportWindow" then
                alreadyRegistered = true
                break
            end
        end
        if not alreadyRegistered then
            table.insert(specialFrames, "PreydatorReportWindow")
        end
    end

    local titleLabel = frame:CreateFontString(nil, "overlay", "GameFontHighlight")
    titleLabel:SetPoint("topleft", frame, "topleft", 10, -8)

    local pageLabel = frame:CreateFontString(nil, "overlay", "GameFontNormalSmall")
    pageLabel:SetPoint("topright", frame, "topright", -92, -10)
    callMethod(pageLabel, "SetText", "0/0")

    local backButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    backButton:SetSize(46, 20)
    backButton:SetPoint("topright", frame, "topright", -88, -28)
    callMethod(backButton, "SetText", "Back")

    local nextButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    nextButton:SetSize(46, 20)
    nextButton:SetPoint("topright", frame, "topright", -36, -28)
    callMethod(nextButton, "SetText", "Next")

    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("topleft", frame, "topleft", 8, -58)
    scrollFrame:SetPoint("bottomright", frame, "bottomright", -28, 8)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    callMethod(editBox, "SetMultiLine", true)
    callMethod(editBox, "SetAutoFocus", false)
    callMethod(editBox, "EnableKeyboard", true)
    callMethod(editBox, "SetFontObject", rawget(_G, "ChatFontNormal"))
    callMethod(editBox, "SetTextInsets", 6, 6, 6, 6)
    callMethod(editBox, "SetMaxLetters", 0)
    editBox:SetWidth(scrollFrame:GetWidth())
    editBox:SetHeight(scrollFrame:GetHeight())
    editBox:SetScript("OnEscapePressed", function()
        frame:Hide()
    end)
    scrollFrame:SetScript("OnSizeChanged", function(self)
        editBox:SetWidth(self:GetWidth())
        editBox:SetHeight(self:GetHeight())
    end)
    scrollFrame:SetScrollChild(editBox)

    local resizeHandle = CreateFrame("Button", nil, frame)
    resizeHandle:SetPoint("bottomright", frame, "bottomright", 0, 0)
    resizeHandle:SetSize(16, 16)
    callMethod(resizeHandle, "SetNormalTexture", "Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    callMethod(resizeHandle, "SetHighlightTexture", "Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeHandle:SetScript("OnMouseDown", function()
        callMethod(frame, "StartSizing", "bottomright")
    end)
    resizeHandle:SetScript("OnMouseUp", function()
        callMethod(frame, "StopMovingOrSizing")
    end)

    reportWidgets.titleLabel = titleLabel
    reportWidgets.pageLabel = pageLabel
    reportWidgets.backButton = backButton
    reportWidgets.nextButton = nextButton
    reportWidgets.editBox = editBox

    backButton:SetScript("OnClick", function()
        if reportState.index > 1 then
            reportState.index = reportState.index - 1
            renderCurrentReport()
        end
    end)

    nextButton:SetScript("OnClick", function()
        if reportState.index < #reportState.history then
            reportState.index = reportState.index + 1
            renderCurrentReport()
        end
    end)

    return frame
end

local function ensureFrame()
    if not reportFrame then
        reportFrame = buildFrame()
    end

    return reportFrame
end

function ReportWindowModule:ShowReport(title, text)
    ensureFrame()
    reportState.history[#reportState.history + 1] = {
        title = tostring(title or "Preydator Report"),
        text = toReportText(text),
    }
    trimHistoryIfNeeded()
    reportState.index = #reportState.history
    persistHistory()
    renderCurrentReport()
    return true
end

function ReportWindowModule:ShowReportLines(title, lines)
    if type(lines) == "table" then
        return self:ShowReport(title, table.concat(lines, "\n"))
    end

    return self:ShowReport(title, lines)
end

function ReportWindowModule:OpenWindow()
    ensureFrame()
    renderCurrentReport()
    return true
end

function ReportWindowModule:GetCurrentReport()
    local entry = reportState.history[reportState.index]
    if not entry then
        return nil, nil
    end

    return entry.title, entry.text
end

function ReportWindowModule:OnEvent(event)
    if event == "PLAYER_LOGIN" then
        restoreHistoryFromPersistence()
        return
    end

    if event == "PLAYER_LOGOUT" then
        persistHistory()
    end
end