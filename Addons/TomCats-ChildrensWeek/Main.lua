if (TomCats and TomCats.Register) then
    TomCats:Register(
            {
--                slashCommands = {
--                    {
--                        command = "CHILDRENS TOGGLE",
--                        desc = "Toggle Children's Week Window",
--                        func = toggleUI
--                    }
--                },
                name = "Children's Week",
                version = "1.0.7"
            }
    )
end
--if (true) then return end -- do not load until next update prior to next holiday launch

local _, addon = ...
local TCL = addon.TomCatsLibs
TCL.Charms.scope = "account"
local D = TCL.Data
-- begin books lib
local Books, book

local BookMixin = {
    pages = { },
    tabs = { }
}

local PageMixin = {
    components = { }
}

local InsetMixin = { }

local insetFramePool = { }

function BookMixin:CreatePage(pageName)
    local page = CreateFromMixins(PageMixin)
    page.frame = CreateFrame("FRAME", nil, self)
    page.book = self
    page.frame:SetAllPoints()
    page.name = pageName
    self.pages[pageName] = page
    return page
end

function PageMixin:CreateInset( points )
    local inset = CreateFromMixins(InsetMixin)
    inset.points = points
    inset.page = self
    table.insert(self.components, inset)
    return inset
end

function PageMixin:Show()
    self.frame:Show()
    for _, component in ipairs(self.components) do
        component:Show()
    end
end

local function CreateInsetTexture(frame, points, left, right, top, bottom)
    local texture = frame:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture("Interface\\AddOns\\TomCats-ChildrensWeek\\images\\box")
    texture:SetBlendMode("MOD")
    if (points) then
        for i = 1, #points do
            local point = points[i]
            texture:SetPoint(point[1], point[2], point[3], point[4], point[5])
        end
    end
    texture:SetTexCoord(left, right, top, bottom)
    return texture
end

local function CreateInsetFrame()
    local texSizeX, texSizeY = 32, 256
    local cornerX, cornerY = 13, 14
    local insetFrame = CreateFrame("Frame")
    local topLeft = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", insetFrame, "TOPLEFT", 0, 0 },
        { "BOTTOMRIGHT", insetFrame, "TOPLEFT", cornerX, -cornerY }
    }, 0, 0.40625, 0, 0.0546875)
    local topRight = CreateInsetTexture(insetFrame, {
        { "TOPRIGHT", insetFrame, "TOPRIGHT", 0, 0 },
        { "BOTTOMLEFT", insetFrame, "TOPRIGHT", -cornerX, -cornerY }
    }, 0.59375, 1, 0, 0.0546875)
    local bottomLeft = CreateInsetTexture(insetFrame, {
        { "BOTTOMLEFT", insetFrame, "BOTTOMLEFT", 0, 0 },
        { "TOPRIGHT", insetFrame, "BOTTOMLEFT", cornerX, cornerY }
    }, 0, 0.40625, 0.9453125, 1)
    local bottomRight = CreateInsetTexture(insetFrame, {
        { "BOTTOMRIGHT", insetFrame, "BOTTOMRIGHT", 0, 0 },
        { "TOPLEFT", insetFrame, "BOTTOMRIGHT", -cornerX, cornerY }
    }, 0.59375, 1, 0.9453125, 1 )
    local left = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topLeft, "BOTTOMLEFT", 0, 0 },
        { "BOTTOMRIGHT", bottomLeft, "TOPRIGHT", 0, 0 }
    }, 0, 0.40625, 0.0546875, 0.9453125 )
    local right = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topRight, "BOTTOMLEFT", 0, 0 },
        { "BOTTOMRIGHT", bottomRight, "TOPRIGHT", 0, 0 }
    }, 0.59375, 1, 0.0546875, 0.9453125 )
    local top = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topLeft, "TOPRIGHT", 0, 0 },
        { "BOTTOMRIGHT", topRight, "BOTTOMLEFT", 0, 0 }
    }, 0.40625, 0.59375, 0, 0.0546875 )
    local bottom = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", bottomLeft, "TOPRIGHT", 0, 0 },
        { "BOTTOMRIGHT", bottomRight, "BOTTOMLEFT", 0, 0 }
    }, 0.40625, 0.59375, 0.9453125, 1 )
    local center = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topLeft, "BOTTOMRIGHT", 0, 0 },
        { "BOTTOMRIGHT", bottomRight, "TOPLEFT", 0, 0 }
    }, 0.40625, 0.59375, 0.0546875, 0.9453125 )
    return insetFrame
end

local namecount = 0
function InsetMixin:Show()
    if (not self.frame) then
        local insetFrame
        if (#insetFramePool == 0) then
            namecount = namecount + 1
            insetFrame = CreateInsetFrame()
        else
            insetFrame = insetFramePool[#insetFramePool]
            insetFramePool[#insetFramePool] = nil
        end
        insetFrame:SetParent(self.page.frame)
        self.frame = insetFrame
        for i = 1, #self.points do
            local point = self.points[i]
            insetFrame:SetPoint(point[1], point[2].frame or point[2], point[3], point[4], point[5])
        end
    end
end

Books = {
    CreateBook = function()
        local book = _G["TomCats-ChildrensWeekTourGuideFrame"]
        book.pageOffsetX = 77
        book.pageOffsetY = -54
        book.pageWidth = 430
        book.pageHeight = 420 -- todo: measure and set
        Mixin(book, BookMixin)
        return book
    end
}
-- end books lib

local progress = {
    completed = 0,
    pets = 0,
    pets1 = 0,
    pets2 = 0,
    pets3 = 0,
    pets4 = 0,
    mounts = 0,
    toys = 0,
    titles = 0,
    achievements = 0,
    quests = {
        0, 0, 0, 0
    },
    petButtons = { }
}

local questChains = { }

local function initializeOverviewPage()

    local page = book:CreatePage("overview")
    local inset1 = page:CreateInset({
        { "TOPLEFT", book, "TOPLEFT", book.pageOffsetX, book.pageOffsetY },
        { "BOTTOMRIGHT", book, "TOPLEFT", book.pageOffsetX + book.pageWidth, book.pageOffsetY - 100 }
    })
    page:Show()

    local holidayTitle = inset1.frame:CreateFontString(nil, nil, "GameFontNormalLarge")
    holidayTitle:SetPoint("TOPLEFT", inset1.frame, "TOPLEFT", 8 + 84 + 8, -8)
    holidayTitle:SetPoint("BOTTOMRIGHT", inset1.frame, "TOPRIGHT", -8, -28)
    holidayTitle:SetNonSpaceWrap(true)
    holidayTitle:SetJustifyV("TOP")
    holidayTitle:SetText("Children's Week")

    local holidayDescription = inset1.frame:CreateFontString(nil, nil, "GameFontHighlightLeft")
    holidayDescription:SetPoint("TOPLEFT", holidayTitle, "BOTTOMLEFT", 0, 0)
    holidayDescription:SetPoint("BOTTOMRIGHT", inset1.frame, "BOTTOMRIGHT", -8, 8)
    holidayDescription:SetNonSpaceWrap(true)
    holidayDescription:SetJustifyV("TOP")
    holidayDescription:SetText("Show an orphan what the hero's life is like! Visit Orphan Matron Nightingale in Stormwind, Orphan Matron Battlewail in Orgrimmar, Orphan Matron Mercy in Shattrath, or Orphan Matron Aria in Dalaran and make a child's dream come true.")

    local imageFrame = CreateFrame("FRAME", nil, inset1.frame)
    imageFrame:SetPoint("TOPLEFT", inset1.frame, "TOPLEFT", 8, -8)
    imageFrame:SetWidth(84)
    imageFrame:SetHeight(84)
    local imageFrameTexture = imageFrame:CreateTexture("ARTWORK")
    imageFrameTexture:SetTexture("Interface\\Calendar\\Holidays\\Calendar_ChildrensWeekStart")
    imageFrameTexture:SetTexCoord(0, 90/128, 0, 90/128)
    imageFrameTexture:SetBlendMode("DISABLE")
    imageFrameTexture:SetAllPoints()

    local progressOverview = CreateFrame("FRAME", nil, page.frame)
    progressOverview:SetPoint("TOPLEFT", page.frame, "TOPLEFT", book.pageOffsetX, book.pageOffsetY - 195)
    progressOverview:SetPoint("BOTTOMRIGHT", page.frame, "TOPLEFT", book.pageOffsetX + book.pageWidth, book.pageOffsetY - (195 + 20))

    local progressOverviewBG = progressOverview:CreateTexture("BACKGROUND")
    progressOverviewBG:SetTexture("Interface\\AchievementFrame\\UI-Achievement-RecentHeader")
    progressOverviewBG:SetTexCoord(0, 1, 0, 0.71875)
    progressOverviewBG:SetPoint("TOPLEFT", progressOverview, "TOPLEFT", -20, 0)
    progressOverviewBG:SetPoint("BOTTOMRIGHT", progressOverview, "BOTTOMRIGHT", 20, 0)

    local progressOverviewLabel = progressOverview:CreateFontString(nil, nil, "GameFontNormal")
    progressOverviewLabel:SetText(ACHIEVEMENT_CATEGORY_PROGRESS)
    progressOverviewLabel:SetHeight(20)
    progressOverviewLabel:SetPoint("CENTER", progressOverview, "CENTER", 0, 0)

    local statusBarWidth1 = book.pageWidth - 12
    local statusBarWidth2 = (statusBarWidth1 / 2) - 12
    local statusBarWidth3 = statusBarWidth2 - 20
    local statusBarVSpace = -12

    local progressOverviewStatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarTotal", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    progressOverviewStatusBar:SetPoint("TOPLEFT", progressOverview, "BOTTOMLEFT", 6, statusBarVSpace)
    progressOverviewStatusBar:SetWidth(statusBarWidth1)
    progressOverviewStatusBar.text:SetText(string.format("%d", progress.completed) .. "%")
    progressOverviewStatusBar.label:SetText(TRACKER_HEADER_OBJECTIVE .. " " .. GOAL_COMPLETED)
    progressOverviewStatusBar:SetMinMaxValues(0, 100)
    progressOverviewStatusBar:SetValue(progress.completed)
    progress.bars = { }
    progress.bars.completed = progressOverviewStatusBar

    local petTotalStatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarPets", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    petTotalStatusBar:SetPoint("TOPLEFT", progressOverviewStatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    petTotalStatusBar:SetWidth(statusBarWidth2)
    petTotalStatusBar.text:SetText(string.format("%d/%d", progress.pets, 14))
    petTotalStatusBar.label:SetText(PETS)
    petTotalStatusBar:SetMinMaxValues(0, 14)
    petTotalStatusBar:SetValue(progress.pets)
    progress.bars.pets = petTotalStatusBar

    local locationName1 = C_Map.GetMapInfo(questChains[1]["Quest Giver"]["Location Name 1"])
    local petTotal1StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarPets1", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    petTotal1StatusBar:SetPoint("TOPLEFT", petTotalStatusBar, "BOTTOMLEFT", 20, statusBarVSpace)
    petTotal1StatusBar:SetWidth(statusBarWidth3)
    petTotal1StatusBar.text:SetText(string.format("%d/%d", progress.pets1, 4))
    petTotal1StatusBar.label:SetText(locationName1.name)
    petTotal1StatusBar:SetMinMaxValues(0, 4)
    petTotal1StatusBar:SetValue(progress.pets1)
    progress.bars.pets1 = petTotal1StatusBar

    local locationName2 = C_Map.GetMapInfo(questChains[2]["Quest Giver"]["Location Name 1"])
    local petTotal2StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarPets2", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    petTotal2StatusBar:SetPoint("TOPLEFT", petTotal1StatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    petTotal2StatusBar:SetWidth(statusBarWidth3)
    petTotal2StatusBar.text:SetText(string.format("%d/%d", progress.pets2, 4))
    petTotal2StatusBar.label:SetText(locationName2.name)
    petTotal2StatusBar:SetMinMaxValues(0, 4)
    petTotal2StatusBar:SetValue(progress.pets2)
    progress.bars.pets2 = petTotal2StatusBar

    local locationName3 = C_Map.GetMapInfo(questChains[3]["Quest Giver"]["Location Name 1"])
    local petTotal3StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarPets3", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    petTotal3StatusBar:SetPoint("TOPLEFT", petTotal2StatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    petTotal3StatusBar:SetWidth(statusBarWidth3)
    petTotal3StatusBar.text:SetText(string.format("%d/%d", progress.pets3, 2))
    petTotal3StatusBar.label:SetText(locationName3.name)
    petTotal3StatusBar:SetMinMaxValues(0, 2)
    petTotal3StatusBar:SetValue(progress.pets3)
    progress.bars.pets3 = petTotal3StatusBar

    local locationName4 = C_Map.GetMapInfo(questChains[5]["Quest Giver"]["Location Name 1"])
    local petTotal4StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarPets4", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    petTotal4StatusBar:SetPoint("TOPLEFT", petTotal3StatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    petTotal4StatusBar:SetWidth(statusBarWidth3)
    petTotal4StatusBar.text:SetText(string.format("%d/%d", progress.pets4, 4))
    petTotal4StatusBar.label:SetText(locationName4.name)
    petTotal4StatusBar:SetMinMaxValues(0, 4)
    petTotal4StatusBar:SetValue(progress.pets4)
    progress.bars.pets4 = petTotal4StatusBar

    local mountTotalStatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarMounts", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    mountTotalStatusBar:SetPoint("TOPLEFT", progressOverviewStatusBar, "BOTTOMLEFT", statusBarWidth2 + 24, statusBarVSpace)
    mountTotalStatusBar:SetWidth(statusBarWidth2)
    mountTotalStatusBar.text:SetText(string.format("%d/%d", progress.mounts, 1))
    mountTotalStatusBar.label:SetText("Mounts")
    mountTotalStatusBar:SetMinMaxValues(0, 1)
    mountTotalStatusBar:SetValue(progress.mounts)
    progress.bars.mounts = mountTotalStatusBar

    local toyTotalStatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarToys", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    toyTotalStatusBar:SetPoint("TOPLEFT", mountTotalStatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    toyTotalStatusBar:SetWidth(statusBarWidth2)
    toyTotalStatusBar.text:SetText(string.format("%d/%d", progress.toys, 2))
    toyTotalStatusBar.label:SetText("Toys")
    toyTotalStatusBar:SetMinMaxValues(0, 2)
    toyTotalStatusBar:SetValue(progress.toys)
    progress.bars.toys = toyTotalStatusBar

    local titleTotalStatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarTitles", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    titleTotalStatusBar:SetPoint("TOPLEFT", toyTotalStatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    titleTotalStatusBar:SetWidth(statusBarWidth2)
    titleTotalStatusBar.text:SetText(string.format("%d/%d", progress.titles, 1))
    titleTotalStatusBar.label:SetText("Titles")
    titleTotalStatusBar:SetMinMaxValues(0, 1)
    titleTotalStatusBar:SetValue(progress.titles)
    progress.bars.titles = titleTotalStatusBar

    local achievementTotalStatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekStatusBarAchievements", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    achievementTotalStatusBar:SetPoint("TOPLEFT", titleTotalStatusBar, "BOTTOMLEFT", 0, statusBarVSpace)
    achievementTotalStatusBar:SetWidth(statusBarWidth2)
    achievementTotalStatusBar.text:SetText(string.format("%d/%d", progress.achievements, 9))
    achievementTotalStatusBar.label:SetText("Achievements")
    achievementTotalStatusBar:SetMinMaxValues(0, 9)
    achievementTotalStatusBar:SetValue(progress.achievements)
    progress.bars.achievements = achievementTotalStatusBar
    return page
end

local function refreshQuestProgress()
    local questLog = GetQuestsCompleted()
    local questCounts = { }
    for i, v in ipairs(questChains) do
        --progress.quests[i] = 0
        questCounts[i] = 0
        for _, questID in ipairs(questChains[i]["Quest IDs"]) do
            if (questLog[questID]) then
                questCounts[i] = questCounts[i] + 1
            end
        end
        if (questCounts[i] > questChains[i]["Max Quests"]) then questCounts[i] = questChains[i]["Max Quests"] end
        if (i == 4) then
            if (questCounts[4] < questCounts[3]) then questCounts[4] = questCounts[3] end
        end
        progress.quests[i] = questCounts[i]
    end
    progress.quests[3] = progress.quests[4]
    progress.quests[4] = progress.quests[5]
    progress.quests[5] = nil
    for i = 1, 4 do
        local j = i
        if (i == 4) then j = 5 end
        if (progress.bars) then
            progress.bars["quests".. i].text:SetText(string.format("%d/%d", progress.quests[i], questChains[j]["Max Quests"]))
            progress.bars["quests".. i]:SetValue(progress.quests[i])
        end
    end
end

local function createPetQuestSection(inset, questChain1, questChain2)
    local quests1Label1 = inset:CreateFontString(nil, nil, "GameFontNormal")
    local questGiver1 = questChain1["Quest Giver"]
    quests1Label1:SetText(START .. ": " .. questGiver1["Name"])
    quests1Label1:SetPoint("TOPRIGHT", inset, "TOPRIGHT", -12, -4)

    local quests1Label2 = inset:CreateFontString(nil, nil, "GameFontHighlight")
    local locationName1a = C_Map.GetMapInfo(questGiver1["Location Name 1"])
    if (questGiver1["Location Name 2"]) then
        local locationName1b = C_Map.GetMapInfo(questGiver1["Location Name 2"])
        quests1Label2:SetText(locationName1a.name .. " (" .. locationName1b.name .. ")")
    else
        quests1Label2:SetText(locationName1a.name)
    end
    quests1Label2:SetPoint("TOPLEFT", inset, "TOPLEFT", 12, -4)

    local questsLabel3 = inset:CreateFontString(nil, nil, "GameFontNormalSmall")
    questsLabel3:SetText(REWARDS .. ":")
    questsLabel3:SetPoint("TOPLEFT", inset, "TOPLEFT", 12, -18)

    local spacing = 50
    local offset = 6
    local icons

    local orphan = inset:CreateFontString(nil, nil, "GameFontNormalSmall")
    if (questChain2) then
        icons = { questChain1["Rewards"][1], questChain2["Rewards"][1] }
        orphan:SetText(questChain1["Orphan"]["Name"] .. " / " .. questChain2["Orphan"]["Name"])
        orphan:SetPoint("TOPRIGHT", inset, "TOPRIGHT", -12, -32)
    else
       icons = questChain1["Rewards"]
       orphan:SetText(questChain1["Orphan"]["Name"])
    end
    orphan:SetPoint("TOPRIGHT", inset, "TOPRIGHT", -12, -18)

    for i = 1, #icons do
        local button = CreateFrame("Button", "TomCats-ChildrensWeekCompanionButton" .. icons[i][3], inset, "TomCats-ChildrensWeekCompanionButtonTemplate")
        button.itemID = icons[i][1]
        button.icon:SetTexture(icons[i][2])
        button:SetPoint("TOPLEFT", questsLabel3, "TOPRIGHT", offset, -2)
        offset = offset + spacing
        progress.petButtons[icons[i][3]] = button
    end
end

local function initializePetsPage()
    local page = book:CreatePage("pets")
    local insetSpace = 8
    local insetHeight = (book.pageHeight - (insetSpace * 3)) / 4
    local inset1 = page:CreateInset({
        { "TOPLEFT", book, "TOPLEFT", book.pageOffsetX, book.pageOffsetY },
        { "BOTTOMRIGHT", book, "TOPLEFT", book.pageOffsetX + book.pageWidth, book.pageOffsetY - insetHeight }
    })
    local inset2 = page:CreateInset({
        { "TOPLEFT", inset1, "BOTTOMLEFT", 0, - insetSpace},
        { "BOTTOMRIGHT", inset1, "BOTTOMRIGHT", 0, - (insetSpace + insetHeight) }
    })
    local inset3 = page:CreateInset({
        { "TOPLEFT", inset2, "BOTTOMLEFT", 0, - insetSpace},
        { "BOTTOMRIGHT", inset2, "BOTTOMRIGHT", 0, - (insetSpace + insetHeight) }
    })
    local inset4 = page:CreateInset({
        { "TOPLEFT", inset3, "BOTTOMLEFT", 0, - insetSpace},
        { "BOTTOMRIGHT", inset3, "BOTTOMRIGHT", 0, - (insetSpace + insetHeight) }
    })

    page:Show()

    local statusBarPadBottom = 8
    local statusBarPadSide = 12
    local statusBarWidth = book.pageWidth - (statusBarPadSide * 2)

    createPetQuestSection(inset1.frame, questChains[1])

    local quests1StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekQuests1StatusBar", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    quests1StatusBar:SetPoint("BOTTOMLEFT", inset1.frame, "BOTTOMLEFT", statusBarPadSide, statusBarPadBottom)
    quests1StatusBar:SetWidth(statusBarWidth)
    quests1StatusBar.label:SetText(TRACKER_HEADER_QUESTS .. " " .. GOAL_COMPLETED)
    quests1StatusBar:SetMinMaxValues(0, questChains[1]["Max Quests"])
    progress.bars.quests1 = quests1StatusBar

    createPetQuestSection(inset2.frame, questChains[2])

    local quests2StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekQuests2StatusBar", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    quests2StatusBar:SetPoint("BOTTOMLEFT", inset2.frame, "BOTTOMLEFT", statusBarPadSide, statusBarPadBottom)
    quests2StatusBar:SetWidth(statusBarWidth)
    quests2StatusBar.label:SetText(TRACKER_HEADER_QUESTS .. " " .. GOAL_COMPLETED)
    quests2StatusBar:SetMinMaxValues(0, questChains[2]["Max Quests"])
    progress.bars.quests2 = quests2StatusBar

    createPetQuestSection(inset3.frame, questChains[3], questChains[4])

    local quests3StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekQuests3StatusBar", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    quests3StatusBar:SetPoint("BOTTOMLEFT", inset3.frame, "BOTTOMLEFT", statusBarPadSide, statusBarPadBottom)
    quests3StatusBar:SetWidth(statusBarWidth)
    quests3StatusBar.label:SetText(TRACKER_HEADER_QUESTS .. " " .. GOAL_COMPLETED)
    quests3StatusBar:SetMinMaxValues(0, questChains[3]["Max Quests"])
    progress.bars.quests3 = quests3StatusBar

    createPetQuestSection(inset4.frame, questChains[5])

    local quests4StatusBar = CreateFrame("StatusBar", "TomCats-ChildrensWeekQuests4StatusBar", page.frame, "TomCats-ChildrensWeekStatusBarTemplate")
    quests4StatusBar:SetPoint("BOTTOMLEFT", inset4.frame, "BOTTOMLEFT", statusBarPadSide, statusBarPadBottom)
    quests4StatusBar:SetWidth(statusBarWidth)
    quests4StatusBar.label:SetText(TRACKER_HEADER_QUESTS .. " " .. GOAL_COMPLETED)
    quests4StatusBar:SetMinMaxValues(0, questChains[5]["Max Quests"])
    progress.bars.quests4 = quests4StatusBar

    refreshQuestProgress()
    addon:refreshPets()
    return page
end

local function tabClicked(self)
    for k, tab in ipairs(book.tabs) do
        if (tab ~= self) then
            if (tab.page) then
                tab.page.frame:Hide()
            end
        end
        tab:SetChecked(false)
    end
    if (not self.page) then
        self.page = self.initializer()
    end
    self:SetChecked(true)
    self.page:Show()
end

function addon:initializeBook()
    local PlayerFaction = UnitFactionGroup("player")
    for k, v in ipairs(D["Faction Quest Chains"].records) do
        if (v["Faction"] == PlayerFaction) then
            table.insert(questChains,v["Quest Chain"])
        end
    end

    book = Books.CreateBook()
    local tab1 = book.chapterButtons["button1"]
    tab1.tooltip = "Overview"
    tab1:SetNormalTexture("Interface\\ICONS\\INV_Misc_Book_09")
    tab1:SetScript("OnClick", tabClicked)
    tab1:Show()
    tab1:SetChecked(true)
    tab1.page = initializeOverviewPage()
    table.insert(book.tabs, tab1)

    local tab2 = book.chapterButtons["button2"]
    tab2.tooltip = "Pets"
    tab2:SetNormalTexture("Interface\\ICONS\\INV_Misc_Rabbit")
    tab2:SetScript("OnClick", tabClicked)
    tab2:Show()
    tab2.initializer = initializePetsPage
    table.insert(book.tabs, tab2)

    local tab3 = book.chapterButtons["button3"]
    tab3.tooltip = "Mounts (Coming Soon)"
    tab3:SetNormalTexture("Interface\\ICONS\\MountJournalPortrait")
    tab3:GetNormalTexture():SetDesaturated(true)
    tab3:SetScript("OnClick", function(self) self:SetChecked(false) end)
    tab3:Show()

    local tab4 = book.chapterButtons["button4"]
    tab4.tooltip = "Toys (Coming Soon)"
    tab4:SetNormalTexture("Interface\\ICONS\\INV_Misc_Toy_10")
    tab4:GetNormalTexture():SetDesaturated(true)
    tab4:SetScript("OnClick", function(self) self:SetChecked(false) end)
    tab4:Show()

    local tab5 = book.chapterButtons["button5"]
    tab5.tooltip = "Titles (Coming Soon)"
    tab5:SetNormalTexture("Interface\\ICONS\\INV_MISC_NOTE_02")
    tab5:GetNormalTexture():SetDesaturated(true)
    tab5:SetScript("OnClick", function(self) self:SetChecked(false) end)
    tab5:Show()

    local tab6 = book.chapterButtons["button6"]
    tab6.tooltip = "Achievements (Coming Soon)"
    tab6:SetNormalTexture("Interface\\AddOns\\TomCats-ChildrensWeek\\images\\achievement_icon")
    tab6:GetNormalTexture():SetDesaturated(true)
    tab6:SetScript("OnClick", function(self) self:SetChecked(false) end)
    tab6:Show()

    local tab7 = book.chapterButtons["button7"]
    tab7.tooltip = "Other (Coming Soon)"
    tab7:SetNormalTexture("Interface\\ICONS\\INV_Misc_Bag_10")
    tab7:GetNormalTexture():SetDesaturated(true)
    tab7:SetScript("OnClick", function(self) self:SetChecked(false) end)
    tab7:Show()

    book:toggle()
end

local function toggleUI()
    if (not book) then
        addon:initializeBook()
    else
        book:toggle()
    end
end

local function refreshCompleted()
    progress.completed = math.floor(100 * (progress.pets + progress.mounts + progress.toys + progress.titles + progress.achievements) / 27)
    if (progress.bars) then
        progress.bars.completed.text:SetText(string.format("%d", progress.completed) .. "%")
        progress.bars.completed:SetValue(progress.completed)
    end
end

local function setBarValue(bar)
    if (progress["bars"]) then
        local _, maxValue = progress.bars[bar]:GetMinMaxValues()
        progress.bars[bar].text:SetText(string.format("%d/%d", progress[bar], maxValue))
        progress.bars[bar]:SetValue(progress[bar])
    end
end

local petIDs = {
    { 127, 125, 289, 126 },
    { 158, 159, 157, 308 },
    { 225, 226 },
    { 2575, 2576, 2577, 2578 }
}

function addon:refreshPets()
    for i, arr in ipairs(petIDs) do
        progress["pets" .. i] = 0
        for j, speciesID in ipairs(arr) do
            local collected = C_PetJournal.GetNumCollectedInfo(speciesID)
            local button = progress.petButtons[speciesID]
            if (collected > 0) then
                progress["pets" .. i] = progress["pets" .. i] + 1
                if (button) then
                    button.icon:SetDesaturated(false)
                    button.obtained:Show()
                end
            else
                if (button) then
                    button.icon:SetDesaturated(true)
                    button.obtained:Hide()
                end
            end
            setBarValue("pets" .. i)
        end
    end
    progress.pets = progress.pets1 + progress.pets2 + progress.pets3 + progress.pets4
    setBarValue("pets")
    refreshCompleted()
end

local function refreshMounts()
    local collected = select(11, C_MountJournal.GetMountInfoByID(267))
    if (collected) then
        progress.mounts = 1
    end
    setBarValue("mounts")
    refreshCompleted()
end

local function refreshToys()
    progress.toys = 0
    if (PlayerHasToy(69895)) then
        progress.toys = progress.toys + 1
    end
    if (PlayerHasToy(69896)) then
        progress.toys = progress.toys + 1
    end
    setBarValue("toys")
    refreshCompleted()
end

local function refreshTitles()
    if (IsTitleKnown(137) or IsTitleKnown(138)) then
        progress.titles = 1
    end
    setBarValue("titles")
    refreshCompleted()
end

local achievementIDs = { 2144, 1793, 1791, 1788, 1789, 1792, 1786, 1790, 275}

local function refreshAchievements()
    progress.achievements = 0
    for i, achievementID in ipairs(achievementIDs) do
        local completed = select(4, GetAchievementInfo(achievementID))
        if (completed) then
            progress.achievements = progress.achievements + 1
        end
    end
    setBarValue("achievements")
    refreshCompleted()
end

local function refreshProgress()
    addon:refreshPets()
    refreshMounts()
    refreshToys()
    refreshTitles()
    refreshAchievements()
end

local function ADDON_LOADED(_, _, arg1)
    if (arg1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        AP = addon.savedVariables.account.preferences
        addon.charm = TCL.Charms.Create({
            name = "TomCats-ChildrensWeekMinimapButton",
            iconTexture = "Interface\\AddOns\\TomCats-ChildrensWeek\\images\\cw-icon",
            backgroundColor = { 0.0,0.0,0.0,1.0 },
            handler_onclick = toggleUI
        })
        addon.charm.tooltip = {
            Show = function(this)
                GameTooltip:ClearLines()
                GameTooltip:SetOwner(this, "ANCHOR_LEFT")
                GameTooltip:SetText("TomCat's Tours:", 1, 1, 1)
                GameTooltip:AddLine("Children's Week", nil, nil, nil, true)
                GameTooltip:AddLine(" ", nil, nil, nil, true)
                GameTooltip:AddLine("Keep your addons updated for more features as they are added", nil, nil, nil, true)
                GameTooltip:Show()
            end,
            Hide = function()
                GameTooltip:Hide()
            end
        }
        if ("1.0.6" ~= AP["lastVersionSeen"]) then
            --addon.charm.MinimapLoopPulseAnim:Play()
        end
        refreshProgress()
        TCL.Events.RegisterEvent("TOYS_UPDATED", refreshProgress)
        TCL.Events.RegisterEvent("PET_JOURNAL_LIST_UPDATE", refreshProgress)
        TCL.Events.RegisterEvent("NEW_TOY_ADDED", refreshProgress)
        TCL.Events.RegisterEvent("NEW_MOUNT_ADDED", refreshProgress)
        TCL.Events.RegisterEvent("COMPANION_LEARNED", refreshProgress)
        TCL.Events.RegisterEvent("COMPANION_UNLEARNED", refreshProgress)
        TCL.Events.RegisterEvent("COMPANION_UPDATE", refreshProgress)
        TCL.Events.RegisterEvent("NEW_PET_ADDED", refreshProgress)
        TCL.Events.RegisterEvent("PET_JOURNAL_PET_DELETED", refreshProgress)
        TCL.Events.RegisterEvent("PET_JOURNAL_PET_RESTORED", refreshProgress)
        TCL.Events.RegisterEvent("PET_JOURNAL_PET_REVOKED", refreshProgress)
        TCL.Events.RegisterEvent("ACHIEVEMENT_EARNED", refreshProgress)
        TCL.Events.RegisterEvent("QUEST_LOG_UPDATE", refreshQuestProgress)
    end
end

TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)

if (TomCats and TomCats.Register) then
    TomCats:Register(
            {
                                slashCommands = {
                                    {
                                        command = "CHILDRENS TOGGLE",
                                        desc = "Toggle Children's Week Window",
                                        func = toggleUI
                                    }
                                },
                name = "Children's Week",
                version = "1.0.6"
            }
    )
end
