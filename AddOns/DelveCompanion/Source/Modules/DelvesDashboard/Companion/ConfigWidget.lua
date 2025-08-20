local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@type DashboardCompanion
local DashboardCompanion = DelveCompanion.DelvesDashboard.Companion

--#region Constants

---@type number
local SLOT_SCALE_VERTICAL = 0.65
---@type number
local SLOT_SCALE_HORIZONTAL = 0.6
--#endregion

--- A short-cut widget to display and change Companion's configuration.
---@class (exact) CompanionConfigWidget : CompanionConfigWidgetXml
---@field defaultConfigButton Button
---@field customConfigButton Button?
DelveCompanion_DashboardCompanionConfigWidgetMixin = {}

--- Create an adjustable pin.
---@param optionsList Frame Config slot optionsList.
local function CreateOptionsListPin(optionsList)
    ---@type Texture
    local optionsPin = optionsList:CreateTexture("$parent.Pin")
    optionsPin:SetParentKey("Pin")
    optionsPin:SetDrawLayer("BACKGROUND", 5)
    optionsPin:SetRotation(math.pi)
    optionsPin:SetWidth(15)
    optionsPin:SetHeight(36)
    optionsPin:SetTexture("interface/talentframe/talents")
    optionsPin:SetTexCoord(0.46782, 0.47903, 0.0830078125, 0.1181640625)
end

--- Prepare slot parameters. Only layout-independent setup.
---@param slot CompanionConfigSlotXml
local function InitSlot(slot)
    slot.Label:SetWidth(160)
    slot.Value:SetWidth(160)

    slot.OptionsList:SetFrameStrata("HIGH")

    ---@type Texture
    local optionsTop = slot.OptionsList.Top
    optionsTop:SetAtlas("talents-pvpflyout-background-top")
    optionsTop:SetRotation(0)

    CreateOptionsListPin(slot.OptionsList)
end

--- Set slot parameters for `Horizontal` layout.
---@param slot CompanionConfigSlotXml
---@param anchorPoint string
local function SetSlotHorizontal(slot, anchorPoint)
    slot:SetScale(SLOT_SCALE_HORIZONTAL)
    slot:ClearAllPoints()
    slot:SetPoint(anchorPoint)

    slot.Label:Hide()
    slot.Value:Hide()

    slot.OptionsList:ClearAllPoints()
    slot.OptionsList:SetPoint("TOPLEFT", slot, "BOTTOMLEFT", 0, -10)
    slot.OptionsList:SetScale(1.8)

    slot.OptionsList.Pin:ClearAllPoints()
    slot.OptionsList.Pin:SetPoint("TOP", -73, 37)
end

--- Display the widget as `Horizontal` layout.
---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:SetHorizontalLayout()
    DashboardCompanion.ParentFrame.CompanionModelScene:Show()
    DashboardCompanion.ParentFrame.isCompanionButtonPanelFrame = true

    self:SetSize(130, 40)
    self:ClearAllPoints()
    self:SetPoint("BOTTOMLEFT", DashboardCompanion.ParentFrame, "BOTTOMLEFT", 24, 23)

    self.defaultConfigButton:Hide()

    if self.customConfigButton then
        self.customConfigButton:Show()
    else
        local customConfigButton = CreateFrame("Button", "$parent.CustomConfigButton", DashboardCompanion.ParentFrame,
            "DelveCompanionDashboardCompanionConfigButtonTemplate")
        customConfigButton:SetPoint("LEFT", self, "RIGHT", 5, 0)
        customConfigButton:SetScript("OnEnter", function(button)
            GameTooltip:SetOwner(button, "ANCHOR_TOP")
            if button.disabled then
                GameTooltip_AddErrorLine(GameTooltip, _G["DELVES_COMPANION_NOT_ENABLED_TOOLTIP"], true)
            else
                GameTooltip_AddNormalLine(GameTooltip, _G["DELVES_CONFIGURE_BUTTON"], true)
            end
            GameTooltip:Show()
        end)

        self.customConfigButton = customConfigButton
    end


    SetSlotHorizontal(self.RoleSlot, "LEFT")
    SetSlotHorizontal(self.CombatSlot, "CENTER")
    SetSlotHorizontal(self.UtilitySlot, "RIGHT")
end

--- Set slot parameters for `Vertical` layout.
---@param slot CompanionConfigSlotXml
---@param anchorPoint string
local function SetSlotVertical(slot, anchorPoint)
    slot:SetScale(SLOT_SCALE_VERTICAL)
    slot:ClearAllPoints()
    slot:SetPoint(anchorPoint)

    slot.Label:Show()
    slot.Value:Show()

    slot.OptionsList:ClearAllPoints()
    slot.OptionsList:SetPoint("TOP", slot, "BOTTOM", 60, -8)
    slot.OptionsList:SetScale(1.5)

    slot.OptionsList.Pin:ClearAllPoints()
    slot.OptionsList.Pin:SetPoint("TOP", -60, 37)
end

--- Display the widget as `Vertical` layout.
---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:SetVerticalLayout()
    DashboardCompanion.ParentFrame.CompanionModelScene:Hide()
    DashboardCompanion.ParentFrame.isCompanionButtonPanelFrame = false

    self:SetSize(170, 145)
    self:ClearAllPoints()
    self:SetPoint("TOP", DashboardCompanion.ExpBar, "BOTTOM", 0, -5)

    self.defaultConfigButton:Show()
    if self.customConfigButton then
        self.customConfigButton:Hide()
    end

    SetSlotVertical(self.RoleSlot, "TOPLEFT")
    SetSlotVertical(self.CombatSlot, "LEFT")
    SetSlotVertical(self.UtilitySlot, "BOTTOMLEFT")
end

---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:SelectLayout()
    ---@type CompanionWidgetLayout
    local layoutType = DelveCompanionCharacterData.companionConfigLayout

    if layoutType == DelveCompanion.Definitions.CompanionWidgetLayout.vertical then
        self:SetVerticalLayout()
    elseif layoutType == DelveCompanion.Definitions.CompanionWidgetLayout.horizontal then
        self:SetHorizontalLayout()
    end
end

--- Display the `Default` layout.
---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:SetDefaultLayout()
    DashboardCompanion.ParentFrame.CompanionModelScene:Show()
    DashboardCompanion.ParentFrame.isCompanionButtonPanelFrame = true

    self.defaultConfigButton:Show()
    if self.customConfigButton then
        self.customConfigButton:Hide()
    end
end

---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:Refresh(isCustom)
    if isCustom then
        self:SelectLayout()
        self:Show()
    else
        self:SetDefaultLayout()
        self:Hide()
    end
end

---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:OnLoad()
    -- Logger.Log("CompanionConfigWidget OnLoad start")

    self.defaultConfigButton = DashboardCompanion.ParentFrame.CompanionConfigButton

    InitSlot(self.RoleSlot)
    InitSlot(self.CombatSlot)
    InitSlot(self.UtilitySlot)

    self:Refresh(DelveCompanionCharacterData.displayCompanionConfig)
end

---@param self CompanionConfigWidget
function DelveCompanion_DashboardCompanionConfigWidgetMixin:OnShow()
    -- Logger.Log("CompanionConfigWidget OnShow start")
end

--#region XML Annotations

--- `CompanionConfigListTemplate` ([Blizzard template](https://www.townlong-yak.com/framexml/live/Blizzard_DelvesCompanionConfiguration/Blizzard_DelvesCompanionConfiguration.xml#120)).
---@class (exact) CompanionConfigListXml : Frame
---@field Top Texture
---@field Pin Texture Created by the addon


--- `CompanionConfigSlotTemplate` ([Blizzard template](https://www.townlong-yak.com/framexml/live/Blizzard_DelvesCompanionConfiguration/Blizzard_DelvesCompanionConfiguration.xml#4)).
---@class (exact) CompanionConfigSlotXml : Button
---@field type string
---@field Label FontString
---@field Value FontString
---@field Texture Texture
---@field OptionsList CompanionConfigListXml

--- `DelveCompanionDashboardCompanionConfigWidgetTemplate`
---@class (exact) CompanionConfigWidgetXml : Frame
---@field RoleSlot CompanionConfigSlotXml
---@field CombatSlot CompanionConfigSlotXml
---@field UtilitySlot CompanionConfigSlotXml

--#endregion
