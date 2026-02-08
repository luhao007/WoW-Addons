local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

---@type string
local INFO_WIDGET_SAVE_KEY = "delvesListInfoWidgetsEnabled"
--#endregion

--- A list with all Delves displayed in the EncounterJournal.
---@class (exact) DelvesListFrame : DelvesListXml
DelveCompanion_DelvesListFrameMixin = {}

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:UpdateKeysWidget()
    local keyCurrInfo = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE)
    if not keyCurrInfo then
        self.KeysWidget:Hide()
        return
    end

    self.KeysWidget:SetLabelText(keyCurrInfo.quantity)
    self.KeysWidget:Show()

    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:Refresh()
    ---@type EJTierData
    local tierData = GetEJTierData(EJ_GetCurrentTier())

    do
        local bgAtlasId = tierData.backgroundAtlas
        self.Background:SetAtlas(bgAtlasId, true)
    end

    DelveCompanion:UpdateDelvesData(tierData.expansionLevel)
    self:ListDelves(tierData.expansionLevel)

    self:UpdateKeysWidget()
    self.DelveOBotWidget:SetShown(tierData.expansionLevel == LE_EXPANSION_WAR_WITHIN) -- Delve-O-Bot 7001 works for TWW Delves only.

    do
        -- TODO: What will happen after TWW S3? Modifiers are active in the latest expansion Delves.

        self.ModifiersContainer.Nemesis:SetFrameInfo(
            DelveCompanion.Definitions.CodeType.Spell,
            Config.AFFIXES.Nemesis[tierData.expansionLevel])
        self.ModifiersContainer:SetShown(true)
        -- self.ModifiersContainer:SetShown(tierData.expansionLevel == LE_EXPANSION_LEVEL_CURRENT)
    end
end

---@param self DelvesListFrame
---@param expansionLevel number LE_EXPANSION number.
function DelveCompanion_DelvesListFrameMixin:ListDelves(expansionLevel)
    local dataProvider = CreateDataProvider()

    for _, mapID in pairs(Config.DELVE_MAPS[expansionLevel]) do
        local areaName = C_Map.GetMapInfo(mapID).name
        dataProvider:Insert({ areaName = areaName })

        for _, delveData in pairs(DelveCompanion.Variables.delvesData[expansionLevel]) do
            local delveConfig = delveData.config
            local parentMapID = C_Map.GetMapInfo(delveConfig.uiMapID).parentMapID

            if parentMapID == mapID then
                dataProvider:Insert(delveData)
            end
        end
    end

    self.DelvesList:Show() -- Scrollbox children will not have resolvable rects unless the scrollbox is shown first
    self.DelvesList:SetDataProvider(dataProvider)
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnLoad()
    -- Logger.Log("[DelvesListFrame] OnLoad start")

    self.Title:SetText(_G["DELVES_LABEL"])

    self.KeysWidget:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, Config.BOUNTIFUL_KEY_CURRENCY_CODE)

    do
        self.ModifiersContainer.ModifiersLabel:SetText(_G["MODIFIERS_COLON"])
        self.ModifiersContainer.Nemesis.Icon:SetPoint("CENTER", -1, 1)
        self.ModifiersContainer:Layout()
    end

    do
        local topPadding = 5
        local bottomPadding = 8
        local leftPadding = 0
        local rightPadding = 0
        local horizSpacing = 15
        local vertSpacing = 10
        local view = CreateScrollBoxListSequenceView(
            topPadding, bottomPadding,
            leftPadding, rightPadding,
            horizSpacing, vertSpacing)

        --- By default, ScrollBox uses the size from templates for extents. However, Delve InstanceButton size may vary depending on the selected options.
        --- So a calculator is required to tell ScrollBox of what size its elements are rebuilding the layout.
        view:SetElementSizeCalculator(function(index, elementData)
            if elementData.areaName then
                return view:GetTemplateSizeFromElementData(elementData)
            else
                local templateWidth, _ = view:GetTemplateSizeFromElementData(elementData)
                local totalHeight = C_XMLUtil.GetTemplateInfo("DelveCompanionDelveInstanceButtonTemplate").height
                    + (DelveCompanionAccountData[INFO_WIDGET_SAVE_KEY]
                        and C_XMLUtil.GetTemplateInfo("DelveCompanionDLDelveInfoWidgetTemplate").height
                        or 0)
                return templateWidth, totalHeight
            end
        end)

        do
            --- Setup Map header.
            ---@param frame DelvesMapHeader
            local function DelveMapHeaderInitializer(frame, elementData)
                frame:Init(elementData.areaName)
            end

            --- Setup Delve InstanceButton.
            ---@param frame DelveListElement
            ---@param delveData DelveData
            local function DelveListElementInitializer(frame, delveData)
                frame:Init(delveData)
            end

            ---Select initializer depending on elementData content.
            ---@param factory table
            ---@param elementData table Can be either a header or a Delve.
            local function DelvesListFactory(factory, elementData)
                if elementData.areaName then
                    factory("DelveCompanionDelveMapHeaderTemplate", DelveMapHeaderInitializer)
                else
                    factory("DelveCompanionDelveListElementTemplate", DelveListElementInitializer)
                end
            end
            view:SetElementFactory(DelvesListFactory)
        end
        ScrollUtil.InitScrollBoxListWithScrollBar(self.DelvesList, self.ScrollBar, view)
    end
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnEvent(event, ...)
    -- Logger.Log("[DelvesListFrame] OnEvent start")

    self:UpdateKeysWidget()
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnShow()
    -- Logger.Log("[DelvesListFrame] OnShow start")

    self:Refresh()
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnHide()
    --Logger.Log("[DelvesListFrame] OnHide start")

    self:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
end

--#region Xml annotations

---@class ModifiersContainerXml : HorizontalLayoutFrame
---@field ModifiersLabel FontString
---@field Nemesis CustomActionWidget

--- `DelveCompanionDelvesListFrameTemplate`
---@class DelvesListXml : Frame
---@field Background Texture
---@field Title FontString
---@field KeysWidget CustomActionWidget
---@field DelveOBotWidget DelveOBotWidget
---@field ModifiersContainer ModifiersContainerXml
---@field DelvesList Frame
---@field ScrollBar EventFrame
--#endregion
