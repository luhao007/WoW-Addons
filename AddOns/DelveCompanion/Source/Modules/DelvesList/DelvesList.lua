local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants
local DEVLES_TAB_PARENT_KEY = "DelvesTab"

---@type integer
local EJ_DELVES_TAB_BUTTON_ID = 6
---@type integer
local EJ_TABS_COUNT = 6
--#endregion

---@class DelvesList
---@field Frame DelvesListFrame
---@field TabButton Button
---@field InfoFrame DelvesInfoFrame
local DelvesList = {}
DelveCompanion.DelvesList = DelvesList

--- Callback to handle tabs switch in EncounterJournal and show/hide Delves list.
---@param _ any
---@param EncounterJournal Frame
---@param tabID integer
local function OnTabSet(_, EncounterJournal, tabID)
    if tabID == EJ_DELVES_TAB_BUTTON_ID then
        EJ_HideNonInstancePanels()
        DelveCompanion.DelvesList.Frame:Show()
    else
        DelveCompanion.DelvesList.Frame:Hide()
    end
end

--- Callback to handle a click on a delve in the list.
---@param _ any
---@param delveData DelveData
local function OnDelveButtonClicked(_, delveData)
    if delveData == nil then
        return
    end

    DelvesList.InfoFrame.data = delveData

    DelvesList.InfoFrame:Setup()
    DelvesList.InfoFrame:Show()
end

--- Create a tab button in EncounterJournal to open Delves list.
---@return Button
local function CreateDelvesTabButton()
    ---@type Button
    local button = CreateFrame("Button", "$parent." .. DEVLES_TAB_PARENT_KEY, EncounterJournal,
        "BottomEncounterTierTabTemplate")
    button:SetParentKey(DEVLES_TAB_PARENT_KEY)
    button:SetText(_G["DELVES_LABEL"])
    button:SetID(EJ_DELVES_TAB_BUTTON_ID)

    return button
end

--- Initialize Delves list.
local function InitDelvesList()
    if not EncounterJournal then
        Logger.Log("EncounterJournal is nil. Delves tab cannot be created.")
        return
    end

    do
        ---@type DelvesListFrame
        local delvesListFrame = CreateFrame("Frame", "$parent.DelvesListFrame", EncounterJournal,
            "DelveCompanionDelvesListFrameTemplate")
        DelvesList.Frame = delvesListFrame

        ---@type DelvesInfoFrame
        local infoFrame = CreateFrame("Frame", "$parent.DelveInfoFrame", delvesListFrame,
            "DelveCompanionDelveInfoFrameTemplate")
        DelvesList.InfoFrame = infoFrame

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.DELVE_INSTANCE_BUTTON_CLICK,
            OnDelveButtonClicked, DelveCompanion.DelvesList)
    end

    do
        ---@type Button
        local tabButton = CreateDelvesTabButton()
        DelvesList.TabButton = tabButton

        PanelTemplates_SetNumTabs(EncounterJournal, EJ_TABS_COUNT)
        EventRegistry:RegisterCallback("EncounterJournal.TabSet", OnTabSet, DelveCompanion.DelvesList)
    end
end

EventUtil.ContinueOnAddOnLoaded(DelveCompanion.Definitions.DependencyAddonName.encounterJournal, InitDelvesList)
