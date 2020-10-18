local _, addon = ...
if (true) then return end
local TCL = addon.TomCatsLibs
local D = TCL.Data
local ContributionCollectorStates = TCL.Data.ContributionCollectorStates
local PlayerFaction = UnitFactionGroup("player")
local GetQuestChoiceInfo = C_QuestChoice.GetQuestChoiceInfo
local GetQuestChoiceOptionInfo = C_QuestChoice.GetQuestChoiceOptionInfo
local GetAllWidgetsBySetID = C_UIWidgetManager.GetAllWidgetsBySetID
local GetTextWithStateWidgetVisualizationInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo
local GetStatusBarWidgetVisualizationInfo = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo
local function GetQuestChoiceInfo_Hook()
    return D.QuestChoiceInfoMap[PlayerFaction]
end
local function GetQuestChoiceOptionInfo_Hook(idx)
    local key = PlayerFaction .. idx
    for i = idx, idx + 2, 2 do
        local state = C_ContributionCollector.GetState(D.ContributionCollectorStates[i])
        if (state == 3) then state = 4 end
        key = key .. state
    end
    return D.QuestChoiceOptionInfoMap[key]
end
local function GetAllWidgetsBySetID_Hook(widgetSetID)
    local setWidgets = GetAllWidgetsBySetID(widgetSetID)
    if (#setWidgets == 0) then
        local widgetsBySetID = D.WidgetsBySetID[widgetSetID]
        if (widgetsBySetID) then
            setWidgets = widgetsBySetID.widgets
        end
    end
    return setWidgets
end
C_UIWidgetManager.GetAllWidgetsBySetID = GetAllWidgetsBySetID_Hook
local function GetTextWithStateWidgetVisualizationInfo_Hook(widgetID)
    local widgetInfo = GetTextWithStateWidgetVisualizationInfo(widgetID)
    if (widgetInfo) then
        return widgetInfo
    end
    return D.TextWithStateWidgetVisualizationInfo[widgetID]
end
C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo = GetTextWithStateWidgetVisualizationInfo_Hook
local function GetStatusBarWidgetVisualizationInfo_Hook(widgetID)
    local widgetInfo = GetStatusBarWidgetVisualizationInfo(widgetID)
    if (widgetInfo) then
        return widgetInfo
    end
    local contributionID
    widgetInfo, contributionID = D.StatusBarWidgetVisualizationInfoFactory.CreateWithDefaults(widgetID)
    if (widgetInfo) then
        local contributionState, contributionPercentageComplete, timeOfNextStateChange, startTime = C_ContributionCollector.GetState(contributionID)
        if (widgetInfo.hasTimer) then
            if (timeOfNextStateChange) then
                widgetInfo.barMax = timeOfNextStateChange - startTime
                widgetInfo.barValue = timeOfNextStateChange - time()
            end
        elseif (contributionState ~= 3) then
            widgetInfo.barValue = math.floor(contributionPercentageComplete * 100)
        end
    end
    return widgetInfo
end
C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo = GetStatusBarWidgetVisualizationInfo_Hook
local function ToggleWarboard()
    GameTooltip:Hide()
    if (not WarboardQuestChoiceFrame) then
        WarboardQuestChoice_LoadUI();
    end
    if (WarboardQuestChoiceFrame and WarboardQuestChoiceFrame:IsShown()) then
        HideUIPanel(WarboardQuestChoiceFrame)
    else
        C_QuestChoice.GetQuestChoiceInfo = GetQuestChoiceInfo_Hook
        C_QuestChoice.GetQuestChoiceOptionInfo = GetQuestChoiceOptionInfo_Hook
        WarboardQuestChoiceFrame:TryShow()
        WarboardQuestChoiceFrame.hasPendingUpdate = false
        C_QuestChoice.GetQuestChoiceInfo = GetQuestChoiceInfo
        C_QuestChoice.GetQuestChoiceOptionInfo = GetQuestChoiceOptionInfo
    end
end
local function ShowTooltip(self)
    if (not (WarboardQuestChoiceFrame and WarboardQuestChoiceFrame:IsShown())) then
        GameTooltip:ClearLines()
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("TomCat's Tours:", 1, 1, 1)
        GameTooltip:AddLine("Warfronts Command Center", nil, nil, nil, true)
        GameTooltip:AddLine(" ");
        ContributionCollectorPinMixin.AddContributionsToTooltip(
            self,
            GameTooltip,
            C_ContributionCollector.GetManagedContributionsForCreatureID(D.ContributionCollectorCreatureIDs[PlayerFaction])
        )
        GameTooltip:Show()
    end
end
local function ADDON_LOADED(_, event, ...)
    local var1 = select(1, ...)
    if (var1 == addon.name) then
        TCL.Charms.Create({
            name = addon.name .. "MinimapButton",
            iconTexture = "Interface\\AddOns\\" .. addon.name .. "\\images\\commandcenter-icon",
            backgroundColor = {48/255,48/255,48/255,0.80 },
            handler_onclick = ToggleWarboard,
            title = "TomCat's Tours: Warfronts Command Center"
        }).tooltip = {
            Show = ShowTooltip,
            Hide = function()
                GameTooltip:Hide()
            end
        }
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
    end
end
TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
if (TomCats and TomCats.Register) then
    TomCats:Register(
        {
            slashCommands = {
                {
                    command = "WCC TOGGLE",
                    desc = "Toggle Warfronts Command Center Window",
                    func = ToggleWarboard
                }
            },
            name = "Warfronts Command Center",
            version = "@{version}"
        }
    )
end