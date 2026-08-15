local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--#region Constants

---@type number
local SLOT_SCALE = 0.6

---@type number
local OPTIONS_SCALE = 1.8
--#endregion

--- Shortcut panel with current companion role and abilities.
---@class (exact) CompanionConfigPanel : CompanionConfigPanelXml
DelveCompanion_CompanionConfigPanelMixin = {}

---@param self CompanionConfigPanel
function DelveCompanion_CompanionConfigPanelMixin:SetSlot(slot)
    slot:SetScale(SLOT_SCALE)

    slot.Label:Hide()
    slot.Value:Hide()

    slot.OptionsList:SetScale(OPTIONS_SCALE)
    slot.OptionsList:ClearAllPoints()
    slot.OptionsList:SetPoint("TOP", slot, "BOTTOM", 0, -10)
end

---@param self CompanionConfigPanel
function DelveCompanion_CompanionConfigPanelMixin:OnLoad()
    -- Logger:Log("[CompanionConfigPanel] OnLoad start")

    self:SetFrameStrata("HIGH")

    self:SetSlot(self.RoleSlot)
    self:SetSlot(self.CombatSlot)
    self:SetSlot(self.UtilitySlot)

    -- Don't forget to fix XML after 12.1 release
    if DelveCompanion.Variables.isPTR then
        self:SetSlot(self.FlavorSlot)
    end
end

---@param self CompanionConfigPanel
function DelveCompanion_CompanionConfigPanelMixin:OnShow()
    -- Logger:Log("[CompanionConfigPanel] OnShow start")

    -- Number of visible slots varies depending on the expansion and game version
    self.fixedWidth = self.RoleSlot:GetWidth() * SLOT_SCALE * #self:GetLayoutChildren()
    self:Layout()
end

--#region XML Annotations

--- `DelveCompanionCompanionConfigPanelTemplate`
---@class (exact) CompanionConfigPanelXml : HorizontalLayoutFrame
---@field RoleSlot CompanionConfigSlotXml
---@field FlavorSlot CompanionConfigSlotXml
---@field CombatSlot CompanionConfigSlotXml
---@field UtilitySlot CompanionConfigSlotXml

--#endregion
