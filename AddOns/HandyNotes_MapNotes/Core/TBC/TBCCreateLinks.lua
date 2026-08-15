local ADDON_NAME, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local CaCLFrame
local linkPatterns
local filtersRegistered = false
local addMessageHooked = false

do
    local OriginalSetItemRef = SetItemRef

    SetItemRef = function(link, text, button, chatFrame)
        if type(link) == "string" then
            local linkType, payload = link:match("^([^:]+):(.+)$")

            if linkType == "url" and payload and payload ~= "" then
                if ns
                    and ns.Addon and ns.Addon.db and ns.Addon.db.profile.CreateAndCopyLinks and CaCLFrame
                then
                    CaCLFrame:Show()
                    CaCLFrame.editBox:SetText(payload)
                    CaCLFrame.editBox:SetFocus()
                    CaCLFrame.editBox:HighlightText()
                end

                return
            end
        end

        return OriginalSetItemRef(link, text, button, chatFrame)
    end
end

local CHAT_TYPES = {
    "SYSTEM", "SAY", "PARTY", "RAID", "RAID_LEADER", "GUILD", "OFFICER", "YELL", "WHISPER",
    "WHISPER_INFORM", "BN_WHISPER", "REPLY", "EMOTE", "TEXT_EMOTE", "CHANNEL", "AFK", "DND",
    "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "CHANNEL1", "CHANNEL2", "CHANNEL3",
    "CHANNEL4", "CHANNEL5", "CHANNEL6", "CHANNEL7", "CHANNEL8", "CHANNEL9", "CHANNEL10"
}

local function hasPotentialLink(text)
    return type(text) == "string" and (text:find("http") or text:find("www%.") or text:find("@") or text:find("%."))
end

local function formatURL(url)
    return "|cff00ccff|Hurl:" .. url .. "|h" .. url .. "|h|r"
end

local function FindLinksInText(text)
    local links = {}
    if not hasPotentialLink(text) then return links end

    for _, entry in ipairs(linkPatterns) do
        for link in text:gmatch(entry.pattern) do
            table.insert(links, link)
        end
    end

    return links
end

local function makeClickable(self, event, msg, sender, languageName, channelName, ...)
    if channelName and channelName:lower():find("dienste") then
        return false, msg, sender, languageName, channelName, ...
    end

    if ns.Addon.db.profile.CreateAndCopyLinks and hasPotentialLink(msg) then
        for _, link in ipairs(FindLinksInText(msg)) do
            if not msg:find("|Hurl:" .. link, 1, true) then
                msg = msg:gsub(link, formatURL(link), 1)
            end
        end
    end

    return false, msg, sender, languageName, channelName, ...
end

local function AddMessage(self, text, ...)
    if not self._OriginalAddMessage then
        return
    end

    if ns.Addon.db.profile.CreateAndCopyLinks then
        if ns.questID then
            local url = "https://www.wowhead.com/quest=" .. ns.questID
            text = text:gsub(url, formatURL(url))
        end
        
        if ns.achievementID then
            local url = "https://www.wowhead.com/achievement=" .. ns.achievementID
            text = text:gsub(url, formatURL(url))
        end
    end

    return self._OriginalAddMessage(self, text, ...)
end

local function URLClicker_OnHyperlinkShow(self, link)
    if ns.Addon and ns.Addon.db and ns.Addon.db.profile.CreateAndCopyLinks and type(link) == "string" and link:sub(1, 3) == "url" then
        if CaCLFrame then
            CaCLFrame:Show()
            CaCLFrame.editBox:SetText(link:sub(5))
            CaCLFrame.editBox:SetFocus()
            CaCLFrame.editBox:HighlightText()
        end
    end
end

local function HookChatHyperlinks()
    if type(ChatFrame_OnHyperlinkShow) == "function" then
        hooksecurefunc("ChatFrame_OnHyperlinkShow", URLClicker_OnHyperlinkShow)
        return
    end

    if NUM_CHAT_WINDOWS then
        for i = 1, NUM_CHAT_WINDOWS do
            local chatFrame = _G["ChatFrame" .. i]

            if chatFrame and not chatFrame._MapNotesURLClickHooked then
                if chatFrame.SetHyperlinksEnabled then
                    chatFrame:SetHyperlinksEnabled(true)
                end

                local oldOnHyperlinkClick = chatFrame:GetScript("OnHyperlinkClick")

                chatFrame:SetScript("OnHyperlinkClick", function(self, link, text, button, ...)
                    if type(link) == "string" and link:sub(1, 4) == "url:" then
                        URLClicker_OnHyperlinkShow(self, link)
                        return
                    end

                    if oldOnHyperlinkClick then
                        return oldOnHyperlinkClick(self, link, text, button, ...)
                    end
                end)

                chatFrame._MapNotesURLClickHooked = true
            end
        end
    end
end

function ns.CreateAndCopyLink()
    if ns._CreateAndCopyLinkEnabled then return end

    linkPatterns = {
        { pattern = "(%a[%w+.-]+://[%w_%%%-%.~/?#=&]+)", type = "protocol" },
        { pattern = "(www%.[%w_.%-]+%.%a%a+[%w/_.%-]*)", type = "www" },
        { pattern = "(%S+@[%w_.-]+%.%a%a)", type = "email" },
        { pattern = "(%f[%a%d][%w_.%-]+%.%a%a+[%w/_.%-]*)", type = "short" },
    }

    CaCLFrame = CreateFrame("Frame", "CaCLFrame", UIParent, "DialogBoxFrame")
    CaCLFrame:SetSize(400, 130)
    CaCLFrame:SetPoint("TOP", 0, -300)
    CaCLFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    CaCLFrame:SetBackdropBorderColor(0, 0, 0, 1)
    CaCLFrame:SetMovable(true)
    CaCLFrame:EnableMouse(true)
    CaCLFrame:RegisterForDrag("LeftButton")
    CaCLFrame:SetScript("OnDragStart", CaCLFrame.StartMoving)
    CaCLFrame:SetScript("OnDragStop", CaCLFrame.StopMovingOrSizing)

    CaCLFrame.text = CaCLFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    CaCLFrame.text:SetPoint("TOP", 0, -15)
    CaCLFrame.text:SetText("|cffff0000Map|r|cff00ccffNotes|r\n" .. L["Use CTRL + C to copy the link"] .. "\n" .. L["The window closes automatically after copying"])

    CaCLFrame.editBox = CreateFrame("EditBox", nil, CaCLFrame, "InputBoxTemplate")
    CaCLFrame.editBox:SetSize(370, 30)
    CaCLFrame.editBox:SetPoint("CENTER", 0, -3)
    CaCLFrame.editBox:SetAutoFocus(true)
    CaCLFrame.editBox:SetFontObject(GameFontHighlight)
    CaCLFrame.editBox:SetScript("OnEscapePressed", function() CaCLFrame:Hide() end)
    CaCLFrame.editBox:SetScript("OnKeyUp", function(self, key)
        if IsControlKeyDown() and key == "C" then
            CaCLFrame:Hide()
        end
    end)

    for _, chatType in ipairs(CHAT_TYPES) do
        ChatFrame_AddMessageEventFilter("CHAT_MSG_" .. chatType, makeClickable)
    end
    filtersRegistered = true

    for i = 1, NUM_CHAT_WINDOWS do
        local chatframe = _G["ChatFrame" .. i]

        if chatframe and not chatframe._OriginalAddMessage then
            chatframe._OriginalAddMessage = chatframe.AddMessage
            chatframe.AddMessage = AddMessage
            addMessageHooked = true
        end
    end

    HookChatHyperlinks()

    ns._CreateAndCopyLinkEnabled = true
end

function ns.DisableCreateAndCopyLink()
    if not ns._CreateAndCopyLinkEnabled then return end

    if filtersRegistered then
        for _, chatType in ipairs(CHAT_TYPES) do
            ChatFrame_RemoveMessageEventFilter("CHAT_MSG_" .. chatType, makeClickable)
        end
        filtersRegistered = false
    end

    if addMessageHooked then
        for i = 1, NUM_CHAT_WINDOWS do
            local chatframe = _G["ChatFrame" .. i]

            if chatframe and chatframe._OriginalAddMessage then
                chatframe.AddMessage = chatframe._OriginalAddMessage
                chatframe._OriginalAddMessage = nil
            end
        end

        addMessageHooked = false
    end

    if CaCLFrame then
        CaCLFrame:Hide()
    end

    ns._CreateAndCopyLinkEnabled = false
end

function ns.ToggleCreateAndCopyLink()
    if ns.Addon.db.profile.CreateAndCopyLinks then
        ns.CreateAndCopyLink()
    else
        ns.DisableCreateAndCopyLink()
    end
end