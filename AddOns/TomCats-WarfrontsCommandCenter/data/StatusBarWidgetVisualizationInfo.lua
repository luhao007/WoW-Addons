local D = select(2, ...).TomCatsLibs.Data
D.loadData(
    "StatusBarWidgetVisualizationInfo",
    { "widgetID", "barValueTextType", "fillTextureKitID", "hasTimer", "contributionID" },
    {
        { 1309, 1, 5112, false, 11 },
        { 1311, 1, 5169, false, 116 },
        { 1313, 3, 5112, true, 11 },
        { 1317, 1, 5169, false, 116 },
        { 1315, 3, 5169, true, 116 },
        { 1319, 1, 5112, false, 11 },
        { 1430, 3, 5169, true, 117 },
        { 1432, 1, 5169, false, 117 },
        { 1434, 1, 5112, false, 118 },
        { 1436, 3, 5112, true, 118 },
        { 1438, 1, 5112, false, 118 },
        { 1440, 1, 5169, false, 117 },
    }
)
D.StatusBarWidgetVisualizationInfoFactory = { }
D.StatusBarWidgetVisualizationInfoFactory.CreateWithDefaults = function(widgetID)
    local widgetVisualizationInfo = D.StatusBarWidgetVisualizationInfo[widgetID]
    if (widgetVisualizationInfo) then
        return {
            barMin = 0,
            barMax = 100,
            barValue = 0,
            barValueTextType = widgetVisualizationInfo.barValueTextType,
            barWidth = 200,
            fillTextureKitID = widgetVisualizationInfo.fillTextureKitID,
            frameTextureKitID = 5110,
            hasTimer = widgetVisualizationInfo.hasTimer,
            orderIndex = 1,
            shownState = 1,
            text = "",
            tooltip = "",
            widgetTag = ""
        }, widgetVisualizationInfo.contributionID
    else
        return nil
    end
end
