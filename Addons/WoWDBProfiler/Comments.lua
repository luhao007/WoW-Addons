-- LUA API ------------------------------------------------------------

local _G = getfenv(0)

local table = _G.table

local next = _G.next
local pairs = _G.pairs

-- ADDON NAMESPACE ----------------------------------------------------

local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local WDP = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Dialog = LibStub("LibDialog-1.0")
local LQT = LibStub("LibQTip-1.0")

local ParseGUID = private.ParseGUID
local ItemLinkToID = private.ItemLinkToID
local DBEntry = private.DBEntry

-- CONSTANTS ----------------------------------------------------------

local EDIT_MAXCHARS = 3000
local EDIT_DESCRIPTION_FORMAT = "Enter your comment below, being as descriptive as possible. Comments are limited to %s characters, including newlines and spaces."
local LINK_COMMENT_TOOLTIP = "Click here to create a link to the comment page on WoWDB."
local LINK_EDITBOX_DESC_FORMAT = "Copy the highlighted text and paste it into your browser to visit the comments for |cffffd200%s|r."

local URL_BASE = "http://www.wowdb.com/"

local URL_TYPE_MAP = {
    ACHIEVEMENT = "achievements",
    ITEM = "items",
    OBJECT = "objects",
    NPC = "npcs",
    QUEST = "quests",
    SPELL = "spells",
    VEHICLE = "npcs",
}

Dialog:Register("WDP_CommentLink", {
    text = "",
    editboxes = {
        {
            text = _G.UNKNOWN,
            on_escape_pressed = function(self)
                self:ClearFocus()
            end,
            on_enter_pressed = function(self)
                self:GetParent().buttons[1]:Click()
            end,
        },
    },
    buttons = {
        {
            text = _G.OKAY,
        }
    },
    show_while_dead = true,
    hide_on_escape = true,
    is_exclusive = true,
    on_show = function(self, data)
        local editbox = self.editboxes[1]
        editbox:SetWidth(self:GetWidth() - 20)
        editbox:SetText(("%s%s/%d#related:comments"):format(URL_BASE, URL_TYPE_MAP[data.type_name], data.id))
        editbox:HighlightText()
        editbox:SetFocus()

        self.text:SetJustifyH("LEFT")
        self.text:SetFormattedText(LINK_EDITBOX_DESC_FORMAT:format(data.label))
    end,
})

-- VARIABLES ----------------------------------------------------------

local comment_subject = {}
local comment_frame
local comment_units = {}

-- HELPERS ------------------------------------------------------------

local function NewComment(type_name, label, id)
    comment_subject.id = id
    comment_subject.label = label
    comment_subject.type_name = type_name

    comment_frame.subject_name:SetText(label)
    comment_frame.subject_data:SetFormattedText("(%s #%d)", type_name, id)
    comment_frame.scroll_frame.edit_box:SetText("")
    _G.ShowUIPanel(comment_frame)
end

local function CreateUnitComment(unit_id, is_command)
    local unit_type, unit_idnum

    if is_command then
        if not _G.UnitExists(unit_id) then
            WDP:Printf("Unit '%s' does not exist.", unit_id)
            return
        end
        unit_type, unit_idnum = ParseGUID(_G.UnitGUID(unit_id))
    else
        local unit_data = comment_units[unit_id]

        if not unit_data then
            WDP:Printf("Unit '%s' does not exist.", unit_id)
            return
        end
        unit_type = unit_data.type
        unit_idnum = unit_data.idnum
    end

    if not unit_idnum then
        WDP:Printf("Unable to determine unit from '%s'", unit_id)
        return
    end
    local type_name = private.UNIT_TYPE_NAMES[unit_type]
    local unit_name = is_command and _G.UnitName(unit_id) or comment_units[unit_id].name

    table.wipe(comment_units)
    NewComment(type_name, unit_name, unit_idnum)
end

local DATA_TYPE_MAPPING = {
    merchant = "ITEM",
}

local function CreateItemComment(is_command)
    local item_name, item_id

    if is_command then
        local item_link
        item_name, item_link = _G.GameTooltip:GetItem()

        if not item_name and not item_link then
            WDP:Print("Your mouse is not over an item.")
            return
        end
        item_id = ItemLinkToID(item_link)
    else
        item_id = ItemLinkToID(comment_units.item.link)
        item_name = comment_units.item.name
    end
    table.wipe(comment_units)
    NewComment("ITEM", item_name, item_id)
end

local function CreateSpellComment(is_command)
    local spell_name, spell_rank, spell_id

    if is_command then
        spell_name, spell_rank, spell_id = _G.GameTooltip:GetSpell()

        if not spell_name and not spell_id then
            WDP:Print("Your mouse is not over a spell.")
            return
        end
    else
        local spell_rank = comment_units.spell.rank
        spell_id = comment_units.spell.id
        spell_name = ("%s%s"):format(comment_units.spell.name, (spell_rank ~= "") and (" (%s)"):format(spell_rank) or "")
    end
    table.wipe(comment_units)
    NewComment("SPELL", spell_name, spell_id)
end

local CreateCursorComment
do
    local CURSOR_DATA_FUNCS = {
        item = function(type_name, id_num, data_subtype)
            local item_name = _G.GetItemInfo(id_num)
            NewComment(type_name, item_name, id_num)
        end,
        merchant = function(type_name, item_index)
            local item_link = _G.GetMerchantItemLink(item_index)
            local item_name = _G.GetItemInfo(item_link)
            NewComment(type_name, item_name, ItemLinkToID(item_link))
        end,
        spell = function(type_name, data, data_subtype, spell_id)
            local spell_name = _G.GetSpellInfo(spell_id)
            NewComment(type_name, spell_name, spell_id)
        end,
    }

    function CreateCursorComment()
        local data_type, data, data_subtype, subdata = _G.GetCursorInfo()
        local comment_func = CURSOR_DATA_FUNCS[data_type]

        if not comment_func then
            WDP:Print("Unable to determine comment subject from cursor.")
            return
        end
        comment_func(DATA_TYPE_MAPPING[data_type] or data_type:upper(), data, data_subtype, subdata)
    end
end -- do-block

local function CreateQuestComment()
    local index = _G.GetQuestLogSelection()

    if not index or not _G.QuestMapFrame:IsVisible() then
        WDP:Print("You must select a quest from the World Map's Quest frame.")
        return
    end
    local title, _, _, is_header, _, _, _, idnum = _G.GetQuestLogTitle(index)

    if is_header then
        WDP:Print("You must select a quest from the World Map's Quest frame.")
        return
    end
    NewComment("QUEST", title, idnum)
end

local function CreateAchievementComment()
    if not _G.AchievementFrame or not _G.AchievementFrame:IsVisible() or not _G.AchievementFrameAchievements.selection then
        WDP:Print("You must select an achievement from the Achievement frame.")
        return
    end

    for _, button in next, _G.AchievementFrameAchievementsContainer.buttons do
        if button.selected then
            NewComment("ACHIEVEMENT", button.label:GetText(), button.id)
            break
        end
    end
end

local ShowPossibleSubjects
do
    local display
    local old_x, old_y, click_time

    _G.WorldFrame:HookScript("OnMouseDown", function(frame, ...)
        old_x, old_y = _G.GetCursorPosition()
        click_time = _G.GetTime()
    end)

    _G.WorldFrame:HookScript("OnMouseUp", function(frame, ...)
        if not display then
            return
        end
        local x, y = _G.GetCursorPosition()

        if not old_x or not old_y or not x or not y or not click_time then
            display = display:Release()
            return
        end

        if (_G.math.abs(x - old_x) + _G.math.abs(y - old_y)) <= 5 and _G.GetTime() - click_time < 1 then
            display = display:Release()
        end
    end)

    local function CreateComment(cell, func)
        if _G.type(func) == "table" then
            func[1](func[2])
        else
            func()
        end
        display = display:Release()
    end

    local CURSOR_NAME_FUNCS = {
        item = function(id_num)
            return _G.GetItemInfo(id_num)
        end,
        merchant = function(item_index)
            return _G.GetItemInfo(_G.GetMerchantItemLink(item_index))
        end,
        spell = function(data, data_subtype, spell_id)
            return _G.GetSpellInfo(spell_id)
        end,
    }

    local VALID_UNITS = {
        boss1 = true,
        boss2 = true,
        boss3 = true,
        boss4 = true,
        focus = true,
        mouseover = true,
        npc = true,
        target = true,
    }

    function ShowPossibleSubjects(anchor)
        if not display then
            display = LQT:Acquire(ADDON_NAME, 1, "LEFT")
            display:EnableMouse(true)
        end

        if anchor then
            display:SmartAnchorTo(anchor)
            display:SetAutoHideDelay(0.2, anchor)
        else
            display:SetPoint("CENTER", _G.UIParent, "CENTER", 0, 0)
        end
        display:Clear()
        display:AddHeader("Choose comment subject:", "CENTER")
        display:AddSeparator()
        display:AddSeparator()

        local line

        for unit_id in pairs(VALID_UNITS) do
            if _G.UnitExists(unit_id) then
                local unit_type, unit_idnum = ParseGUID(_G.UnitGUID(unit_id))
                local unit_name = _G.UnitName(unit_id)

                if unit_idnum then
                    comment_units[unit_id] = {
                        idnum = unit_idnum,
                        name = unit_name,
                        type = unit_type,
                    }
                    line = display:AddLine(("%s: %s"):format(unit_id:gsub("^%l", _G.string.upper), unit_name))
                    display:SetLineScript(line, "OnMouseUp", CreateComment, { CreateUnitComment, unit_id })
                end
            end
        end

        if _G.AchievementFrame and _G.AchievementFrame:IsVisible() and _G.AchievementFrameAchievements.selection then
            for _, button in next, _G.AchievementFrameAchievementsContainer.buttons do
                if button.selected then
                    line = display:AddLine(("Achievement: %s"):format(button.label:GetText()))
                    display:SetLineScript(line, "OnMouseUp", CreateComment, CreateAchievementComment)
                    break
                end
            end
        end
        local data_type, data, data_subtype, subdata = _G.GetCursorInfo()
        local name_func = CURSOR_NAME_FUNCS[data_type]

        if name_func then
            line = display:AddLine(("Cursor: %s"):format(name_func(data, data_subtype, subdata)))
            display:SetLineScript(line, "OnMouseUp", CreateComment, CreateCursorComment)
        end
        local spell_name, spell_rank, spell_id = _G.GameTooltip:GetSpell()

        if spell_name and spell_rank and spell_id then
            comment_units.spell = {
                id = spell_id,
                name = spell_name,
                rank = spell_rank,
            }

            line = display:AddLine(("Spell: %s%s"):format(spell_name, (spell_rank ~= "") and (" (%s)"):format(spell_rank) or ""))
            display:SetLineScript(line, "OnMouseUp", CreateComment, CreateSpellComment)
        end

        local item_name, item_link = _G.GameTooltip:GetItem()

        if item_name and item_link then
            comment_units.item = {
                link = item_link,
                name = item_name,
            }

            line = display:AddLine(("Item: %s"):format(item_name))
            display:SetLineScript(line, "OnMouseUp", CreateComment, CreateItemComment)
        end

        local quest_index = _G.GetQuestLogSelection()

        if quest_index and _G.QuestMapFrame:IsVisible() and not _G.QuestScrollFrame:IsVisible() then
            local title, _, _, is_header = _G.GetQuestLogTitle(quest_index)

            if not is_header then
                line = display:AddLine(("Quest: %s"):format(title))
                display:SetLineScript(line, "OnMouseUp", CreateComment, CreateQuestComment)
            end
        end

        if display:GetLineCount() == 3 then
            display = display:Release()
            WDP:Print("There are no possible comment subjects.")
            return
        end
        display:Show()
    end

    WDP.ShowPossibleSubjects = ShowPossibleSubjects -- For Keybinding.
end -- do-block

-- METHODS ------------------------------------------------------------

function private.ProcessCommentCommand(arg)
    if not arg or arg == "" then
        ShowPossibleSubjects(nil)
        return
    end

    if arg == "achievement" then
        CreateAchievementComment()
        return
    elseif arg == "cursor" then
        CreateCursorComment()
        return
    elseif arg == "item" then
        CreateItemComment(true)
        return
    elseif arg == "quest" then
        CreateQuestComment()
        return
    elseif arg == "spell" then
        CreateSpellComment(true)
        return
    end
    CreateUnitComment(arg, true)
end

function private.InitializeCommentSystem()
    local panel = _G.CreateFrame("Frame", "WDP_CommentFrame", _G.UIParent, "TranslucentFrameTemplate")
    panel:SetSize(480, 350)
    panel:SetPoint("CENTER", _G.UIParent, "CENTER")
    panel:SetFrameStrata("DIALOG")
    panel.Bg:SetTexture([[Interface\FrameGeneral\UI-Background-Rock]], true, true)
    panel.Bg:SetHorizTile(true)
    panel.Bg:SetVertTile(true)
    panel:EnableMouse(true)
    panel:SetMovable(true)
    panel:Hide()
    comment_frame = panel

    table.insert(_G.UISpecialFrames, panel:GetName())

    local streaks = panel:CreateTexture("$parentTopTileStreaks", "BORDER", "_UI-Frame-TopTileStreaks", -6)
    streaks:SetPoint("TOPLEFT", 13, -13)
    streaks:SetPoint("BOTTOMRIGHT", panel, "TOPRIGHT", -13, -35)

    local header = _G.CreateFrame("Frame", "$parentHeader", panel, "TranslucentFrameTemplate")
    header:SetSize(128, 64)
    header:SetPoint("CENTER", panel, "TOP", 0, -8)
    header.Bg:SetTexture([[Interface\FrameGeneral\UI-Background-Marble]])
    header.Bg:SetHorizTile(true)
    header.Bg:SetVertTile(true)
    header:SetMovable(true)

    header:SetScript("OnMouseDown", function()
        panel:StartMoving()
    end)

    header:SetScript("OnMouseUp", function()
        panel:StopMovingOrSizing()
    end)

    panel.header = header

    local logo = header:CreateTexture(nil, "ARTWORK")
    logo:SetTexture([[Interface\AddOns\WoWDBProfiler\wowdb-logo]])
    logo:SetPoint("TOPLEFT", header, 10, -10)
    logo:SetPoint("BOTTOMRIGHT", header, -10, 10)

    local subject_name = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    subject_name:SetPoint("TOP", header, "BOTTOM", 0, -10)
    panel.subject_name = subject_name

    local subject_data = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    subject_data:SetPoint("TOP", subject_name, "BOTTOM", 0, -3)
    panel.subject_data = subject_data

    local close = _G.CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -7, -7)

    local scroll_frame = _G.CreateFrame("ScrollFrame", "$parentScrollFrame", panel)
    scroll_frame:SetSize(435, 150)
    scroll_frame:SetPoint("BOTTOM", 0, 70)

    scroll_frame:SetScript("OnScrollRangeChanged", function(self, x, y)
        _G.ScrollFrame_OnScrollRangeChanged(self, x, y)
    end)

    scroll_frame:SetScript("OnVerticalScroll", function(self, offset)
        local scrollbar = self.ScrollBar
        scrollbar:SetValue(offset)

        local min, max = scrollbar:GetMinMaxValues()

        if offset == 0 then
            scrollbar.ScrollUpButton:Disable()
        else
            scrollbar.ScrollUpButton:Enable()
        end

        if (scrollbar:GetValue() - max) == 0 then
            scrollbar.ScrollDownButton:Disable()
        else
            scrollbar.ScrollDownButton:Enable()
        end
    end)

    scroll_frame:SetScript("OnMouseWheel", function(self, delta)
        _G.ScrollFrameTemplate_OnMouseWheel(self, delta)
    end)

    -- This is needed because the EditBox starts with a height of a single line, so getting focus on click would require finding the EditBox blindly.
    scroll_frame:SetScript("OnMouseUp", function(self)
        _G.EditBox_SetFocus(self.edit_box)
    end)

    panel.scroll_frame = scroll_frame

    local edit_container = _G.CreateFrame("Frame", nil, scroll_frame)
    edit_container:SetPoint("TOPLEFT", scroll_frame, -7, 7)
    edit_container:SetPoint("BOTTOMRIGHT", scroll_frame, 7, -7)
    edit_container:SetFrameLevel(scroll_frame:GetFrameLevel() - 1)
    edit_container:SetBackdrop({
        bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = {
            left = 5,
            right = 5,
            top = 5,
            bottom = 5
        }
    })

    edit_container:SetBackdropBorderColor(_G.TOOLTIP_DEFAULT_COLOR.r, _G.TOOLTIP_DEFAULT_COLOR.g, _G.TOOLTIP_DEFAULT_COLOR.b)
    edit_container:SetBackdropColor(0, 0, 0)

    local link_button = _G.CreateFrame("Button", "$parentLinkButton", panel)
    link_button:SetSize(32, 16)
    link_button:SetPoint("TOPRIGHT", edit_container, "BOTTOMRIGHT", 5, 0)

    link_button:SetNormalTexture([[Interface\TradeSkillFrame\UI-TradeSkill-LinkButton]])
    link_button:GetNormalTexture():SetTexCoord(0, 1, 0, 0.5)

    link_button:SetHighlightTexture([[Interface\TradeSkillFrame\UI-TradeSkill-LinkButton]])
    link_button:GetHighlightTexture():SetTexCoord(0, 1, 0.5, 1)

    link_button:SetScript("OnClick", function(self)
        Dialog:Spawn("WDP_CommentLink", { type_name = comment_subject.type_name, id = comment_subject.id, label = comment_subject.label })
    end)

    link_button:SetScript("OnEnter", function(self)
        _G.GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
        _G.GameTooltip:SetText(LINK_COMMENT_TOOLTIP, nil, nil, nil, nil, 1)
        _G.GameTooltip:Show()
    end)

    link_button:SetScript("OnLeave", _G.GameTooltip_Hide)

    local edit_description = edit_container:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    edit_description:SetHeight(36)
    edit_description:SetPoint("BOTTOMLEFT", edit_container, "TOPLEFT", 5, 3)
    edit_description:SetPoint("BOTTOMRIGHT", edit_container, "TOPRIGHT", 5, 3)
    edit_description:SetFormattedText(EDIT_DESCRIPTION_FORMAT, _G.BreakUpLargeNumbers(EDIT_MAXCHARS))
    edit_description:SetWordWrap(true)
    edit_description:SetJustifyH("LEFT")

    local edit_box = _G.CreateFrame("EditBox", "$parentEditBox", scroll_frame)
    edit_box:SetMultiLine(true)
    edit_box:SetMaxLetters(EDIT_MAXCHARS)
    edit_box:EnableMouse(true)
    edit_box:SetAutoFocus(false)
    edit_box:SetFontObject("ChatFontNormal")
    edit_box:SetSize(420, 220)
    edit_box:HighlightText(0)
    edit_box:SetFrameLevel(scroll_frame:GetFrameLevel() + 1)

    edit_box:SetScript("OnCursorChanged", _G.ScrollingEdit_OnCursorChanged)
    edit_box:SetScript("OnEscapePressed", _G.EditBox_ClearFocus)
    edit_box:SetScript("OnShow", function(self)
        _G.EditBox_SetFocus(self)

        if self:GetNumLetters() > 0 then
            panel.submitButton:Enable()
        else
            panel.submitButton:Disable()
        end
    end)

    edit_box:SetScript("OnTextChanged", function(self, user_input)
        local parent = self:GetParent()
        local num_letters = self:GetNumLetters()
        _G.ScrollingEdit_OnTextChanged(self, parent)
        parent.charCount:SetFormattedText(_G.BreakUpLargeNumbers(self:GetMaxLetters() - num_letters))

        if num_letters > 0 then
            panel.submitButton:Enable();
        else
            panel.submitButton:Disable()
        end
    end)

    edit_box:SetScript("OnUpdate", function(self, elapsed)
        _G.ScrollingEdit_OnUpdate(self, elapsed, self:GetParent())
    end)

    scroll_frame.edit_box = edit_box
    scroll_frame:SetScrollChild(edit_box)

    local char_count = scroll_frame:CreateFontString(nil, "OVERLAY", "GameFontDisableLarge")
    char_count:SetPoint("BOTTOMRIGHT", -15, 0)
    scroll_frame.charCount = char_count

    local scroll_bar = _G.CreateFrame("Slider", "$parentScrollBar", scroll_frame, "UIPanelScrollBarTemplate")
    scroll_bar:SetPoint("TOPLEFT", scroll_frame, "TOPRIGHT", -13, -16)
    scroll_bar:SetPoint("BOTTOMLEFT", scroll_frame, "BOTTOMRIGHT", -13, 16)
    scroll_frame.ScrollBar = scroll_bar

    _G.ScrollFrame_OnLoad(scroll_frame)

    local submit = _G.CreateFrame("Button", "$parentSubmit", panel, "GameMenuButtonTemplate")
    submit:SetSize(160, 30)
    submit:SetPoint("BOTTOM", 0, 15)
    submit:SetText(_G.SUBMIT)
    submit:Enable(false)

    submit:SetScript("OnClick", function()
        local entry = DBEntry(URL_TYPE_MAP[comment_subject.type_name], comment_subject.id)

        if not entry then
            WDP:Print("An error has occurred; please report at http://wow.curseforge.com/addons/wowdb-profiler/create-ticket/")
            return
        end
        entry.comments = entry.comments or {}
        entry.comments[#entry.comments + 1] = edit_box:GetText()

        edit_box:SetText("")
        _G.HideUIPanel(panel)
    end)
    panel.submitButton = submit

    --    local data_obj = LibStub("LibDataBroker-1.1"):NewDataObject(ADDON_NAME, {
    --        type = "data source",
    --        label = ADDON_NAME,
    --        text = " ",
    --        icon = [[Interface\CHATFRAME\UI-ChatIcon-Chat-Up]],
    --        OnClick = function(self, button, down)
    --            ShowPossibleSubjects(self)
    --        end,
    --        OnTooltipShow = function(self)
    --            self:AddLine(_G.CLICK_TO_ENTER_COMMENT)
    --        end,
    --    })
    --
    --    private.data_obj = data_obj
    --    LibStub("LibDBIcon-1.0"):Register(ADDON_NAME, data_obj, private.db.global.config.minimap_icon)

    _G.GameTooltip:HookScript("OnTooltipSetItem", function(self)
    end)

    _G["BINDING_HEADER_WOWDB_PROFILER"] = "WoWDB Profiler"
end
