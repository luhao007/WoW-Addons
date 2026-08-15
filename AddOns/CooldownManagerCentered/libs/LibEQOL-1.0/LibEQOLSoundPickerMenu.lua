local _, ns = ...

local lib = ns.LibEQOL.SoundPickerMenu or {}
ns.LibEQOL.SoundPickerMenu = lib

local DEFAULT_WIDTH = 300
local DEFAULT_HEIGHT = 320
local ROW_HEIGHT = 22
local VISIBLE_ROWS = 16
local pickerFrame

local function NormalizeSearch(text)
    return strlower(strtrim(text or ""))
end

local function HandlesGlobalMouseEvent()
    return true
end

local function GetOptions(data)
    local source = type(data.options) == "function" and data.options() or data.options
    local entries = {}
    for _, option in ipairs(source or {}) do
        local value = type(option) == "table" and option.value or option
        local label = type(option) == "table" and (option.label or option.text) or tostring(option)
        if value ~= nil and label and label ~= "" then
            entries[#entries + 1] = {
                value = value,
                label = label,
                searchLabel = NormalizeSearch(type(option) == "table" and option.searchText or label),
                data = option,
            }
        end
    end
    return entries
end

local function GetCurrentValue(picker)
    local data = picker.data
    return data and data.getValue and data.getValue() or nil
end

local function PreviewEntry(picker, entry)
    local data = picker.data
    if data and data.preview and entry then
        data.preview(entry.value, entry.data)
    end
end

local function ScheduleClose(picker)
    picker.closeToken = (picker.closeToken or 0) + 1
    local token = picker.closeToken
    C_Timer.After(0.12, function()
        if picker.closeToken ~= token or not picker:IsShown() then
            return
        end
        local owner = picker.owner
        if not picker:IsMouseOver() and not (owner and owner:IsShown() and owner:IsMouseOver()) then
            picker:Hide()
        end
    end)
end

local function CreateRow(picker)
    local row = CreateFrame("Button", nil, picker.content)
    row:SetHeight(ROW_HEIGHT)
    row:RegisterForClicks("LeftButtonUp")
    row.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent

    local highlight = row:CreateTexture(nil, "BACKGROUND")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    highlight:SetBlendMode("ADD")
    highlight:Hide()
    row.highlight = highlight

    local radio = row:CreateTexture(nil, "ARTWORK")
    radio:SetPoint("LEFT", row, "LEFT", 4, 0)
    radio:SetAtlas("common-dropdown-tickradial", true)

    local selected = row:CreateTexture(nil, "OVERLAY")
    selected:SetPoint("TOPLEFT", radio, "TOPLEFT")
    selected:SetAtlas("common-dropdown-icon-radialtick-yellow", true)
    row.selected = selected

    local label = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    label:SetPoint("LEFT", radio, "RIGHT", 3, 0)
    label:SetJustifyH("LEFT")
    label:SetMaxLines(1)
    row.label = label

    local preview = CreateFrame("Button", nil, row)
    preview:SetSize(22, ROW_HEIGHT)
    preview:SetPoint("RIGHT", row, "RIGHT", -3, 0)
    preview:SetFrameLevel(row:GetFrameLevel() + 5)
    preview:RegisterForClicks("LeftButtonUp")
    preview:EnableMouse(true)
    preview:SetPropagateMouseMotion(true)
    preview.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent
    preview:Hide()
    row.preview = preview
    label:SetPoint("RIGHT", preview, "LEFT", -4, 0)

    preview:SetNormalTexture("common-icon-sound")
    preview:SetPushedTexture("common-icon-sound-pressed")
    preview:SetHighlightTexture("common-icon-sound", "ADD")
    preview:GetHighlightTexture():SetAlpha(0.4)

    preview:SetScript("OnClick", function()
        PreviewEntry(picker, row.entry)
    end)
    preview:SetScript("OnEnter", function(control)
        picker.closeToken = (picker.closeToken or 0) + 1
        highlight:Show()
        GameTooltip:SetOwner(control, "ANCHOR_RIGHT")
        GameTooltip:SetText((picker.data and picker.data.previewTooltip) or "Preview sound")
        GameTooltip:Show()
    end)
    preview:SetScript("OnLeave", function()
        GameTooltip:Hide()
        ScheduleClose(picker)
    end)

    row:SetScript("OnEnter", function()
        picker.closeToken = (picker.closeToken or 0) + 1
        highlight:Show()
        preview:Show()
    end)
    row:SetScript("OnLeave", function()
        highlight:Hide()
        preview:Hide()
        ScheduleClose(picker)
    end)
    row:SetScript("OnClick", function()
        local entry = row.entry
        local data = picker.data
        if not entry or not data then
            return
        end
        if data.setValue then
            data.setValue(entry.value, entry.data)
        end
        if data.previewOnSelect ~= false then
            PreviewEntry(picker, entry)
        end
        if data.onValueChanged then
            data.onValueChanged(entry.value, entry.data, picker.menu)
        end
        if picker.owner and picker.owner.fontString then
            picker.owner.fontString:SetTextToFit((data.labelPrefix or "") .. entry.label)
        end
        picker:Hide()
    end)
    return row
end

local function GetPicker()
    if pickerFrame then
        return pickerFrame
    end

    local picker = CreateFrame("Frame", nil, UIParent)
    picker:SetSize(DEFAULT_WIDTH, DEFAULT_HEIGHT)
    picker:SetClampedToScreen(true)
    picker:EnableMouse(true)
    picker.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent
    local background = picker:CreateTexture(nil, "BACKGROUND")
    background:SetAtlas("common-dropdown-bg")
    background:SetPoint("TOPLEFT", picker, "TOPLEFT", -10, 3)
    background:SetPoint("BOTTOMRIGHT", picker, "BOTTOMRIGHT", 10, -3)
    background:SetAlpha(0.925)
    picker:Hide()

    local search = CreateFrame("EditBox", nil, picker, "SearchBoxTemplate")
    search:SetPoint("TOPLEFT", picker, "TOPLEFT", 12, -8)
    search:SetPoint("TOPRIGHT", picker, "TOPRIGHT", -12, -8)
    search:SetHeight(22)
    search.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent
    if search.clearButton then
        search.clearButton.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent
    end
    picker.search = search

    local scroll = CreateFrame("ScrollFrame", nil, picker)
    scroll:SetPoint("TOPLEFT", search, "BOTTOMLEFT", 0, -5)
    scroll:SetPoint("BOTTOMRIGHT", picker, "BOTTOMRIGHT", -8, 8)
    scroll:EnableMouseWheel(true)
    scroll.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent
    picker.scroll = scroll

    local content = CreateFrame("Frame", nil, scroll)
    content:SetWidth(DEFAULT_WIDTH - 16)
    content:SetHeight(1)
    content.HandlesGlobalMouseEvent = HandlesGlobalMouseEvent
    scroll:SetScrollChild(content)
    picker.content = content
    picker.rows = {}
    picker.filteredEntries = {}

    function picker:UpdateVisibleRows()
        local firstIndex = math.floor(self.scroll:GetVerticalScroll() / ROW_HEIGHT) + 1
        local currentValue = GetCurrentValue(self)
        for index = 1, VISIBLE_ROWS do
            local row = self.rows[index]
            if not row then
                row = CreateRow(self)
                self.rows[index] = row
            end
            local entryIndex = firstIndex + index - 1
            local entry = self.filteredEntries[entryIndex]
            if entry then
                row.entry = entry
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", self.content, "TOPLEFT", 0, -(entryIndex - 1) * ROW_HEIGHT)
                row:SetWidth(self.content:GetWidth())
                row.label:SetText(entry.label)
                row.selected:SetShown(entry.value == currentValue)
                row.preview:SetShown(row:IsMouseOver())
                row:Show()
            else
                row.entry = nil
                row:Hide()
            end
        end
    end

    function picker:ApplyFilter()
        local query = NormalizeSearch(self.search:GetText())
        wipe(self.filteredEntries)
        for _, entry in ipairs(self.entries or {}) do
            if query == "" or strfind(entry.searchLabel, query, 1, true) then
                self.filteredEntries[#self.filteredEntries + 1] = entry
            end
        end
        self.content:SetHeight(math.max(1, #self.filteredEntries * ROW_HEIGHT))
        self.scroll:SetVerticalScroll(0)
        self:UpdateVisibleRows()
    end

    function picker:Open(owner, data, menu)
        if self:IsShown() and self.owner == owner then
            return
        end
        self.owner = owner
        self.data = data
        self.menu = menu
        self.entries = GetOptions(data)
        self.closeToken = (self.closeToken or 0) + 1
        self:SetSize(data.width or DEFAULT_WIDTH, data.height or DEFAULT_HEIGHT)
        self.content:SetWidth(self:GetWidth() - 16)
        self:SetFrameStrata(owner:GetFrameStrata())
        self:SetFrameLevel(owner:GetFrameLevel() + 50)
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", owner, "TOPRIGHT", 0, 0)
        self:Show()
        self.search:SetText("")
        self:ApplyFilter()
        C_Timer.After(0, function()
            if self:IsShown() and self.owner == owner then
                self.search:SetFocus()
            end
        end)
    end

    search:SetScript("OnTextChanged", function(editBox)
        SearchBoxTemplate_OnTextChanged(editBox)
        if picker:IsShown() then
            picker:ApplyFilter()
        end
    end)
    search:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
        picker:Hide()
    end)
    scroll:SetScript("OnVerticalScroll", function(_, offset)
        scroll:SetVerticalScroll(offset)
        picker:UpdateVisibleRows()
    end)
    scroll:SetScript("OnMouseWheel", function(_, delta)
        local current = scroll:GetVerticalScroll()
        local maximum = scroll:GetVerticalScrollRange()
        scroll:SetVerticalScroll(math.max(0, math.min(maximum, current - delta * ROW_HEIGHT * 3)))
        picker:UpdateVisibleRows()
    end)
    picker:SetScript("OnEnter", function()
        picker.closeToken = (picker.closeToken or 0) + 1
    end)
    picker:SetScript("OnLeave", function()
        ScheduleClose(picker)
    end)
    picker:SetScript("OnUpdate", function(self)
        if not self.owner or not self.owner:IsShown() then
            self:Hide()
        end
    end)
    picker:SetScript("OnHide", function(self)
        self.search:ClearFocus()
        GameTooltip:Hide()
        self.owner = nil
        self.data = nil
        self.menu = nil
    end)

    pickerFrame = picker
    return picker
end

function lib:CreateSoundPickerMenu(parentDescription, data)
    assert(parentDescription and type(data) == "table", "parentDescription and data are required")
    local state = {}
    local value = data.getValue and data.getValue() or nil
    local buttonDescription = parentDescription:CreateButton((data.labelPrefix or "") .. (data.getLabel and data.getLabel(value) or tostring(value or "")), function()
        if state.owner then
            GetPicker():Open(state.owner, data, state.menu)
        end
        return MenuResponse.Open
    end)
    buttonDescription:AddInitializer(function(button, _, menu)
        state.owner = button
        state.menu = menu
        local currentValue = data.getValue and data.getValue() or nil
        local label = data.getLabel and data.getLabel(currentValue) or tostring(currentValue or "")
        button.fontString:SetTextToFit((data.labelPrefix or "") .. label)

        local arrow = button:AttachTexture()
        arrow:SetPoint("RIGHT", button, "RIGHT", 0, 0)
        arrow:SetSize(16, 16)
        arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
        button.fontString:SetPoint("RIGHT", arrow, "LEFT", -2, 0)
    end)
    buttonDescription:SetOnEnter(function(button)
        GetPicker():Open(button, data, state.menu)
    end)
    buttonDescription:SetOnLeave(function()
        ScheduleClose(GetPicker())
    end)
    return buttonDescription
end

function lib:Open(owner, data)
    assert(owner and type(data) == "table", "owner and data are required")
    GetPicker():Open(owner, data)
end

function lib:ScheduleClose()
    ScheduleClose(GetPicker())
end
