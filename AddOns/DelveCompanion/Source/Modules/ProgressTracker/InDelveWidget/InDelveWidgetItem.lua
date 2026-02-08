local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--#region Constants

--#endregion

---@class (exact) InDelveWidgetItem : InDelveWidgetItemXml
---@field itemCode number Item Code of the displayed item.
---@field hasItem boolean Whether player has the item in their bags.
DelveCompanion_InDelveWidgetItemMixin = {}

---@param self InDelveWidgetItem
---@param isAvailable boolean
function DelveCompanion_InDelveWidgetItemMixin:RefreshInteraction(isAvailable)
    if isAvailable then
        local macroText = string.format("/use item:%s", self.itemCode)
        self:SetInsecureAction({ type1 = "macro", macrotext = macroText })

        self.InteractionBlockedOverlay:Hide()
    else
        self.InteractionBlockedOverlay:Show()
        self:DisableInteraction()
    end
end

---@param self InDelveWidgetItem
---@param isAvailable boolean
function DelveCompanion_InDelveWidgetItemMixin:RefreshAnim(isAvailable)
    local hasCd = select(1, C_Item.GetItemCooldown(self.itemCode)) ~= 0
    if not (hasCd) and isAvailable then
        self:PlayAnimation()
    end
end

---@param self InDelveWidgetItem
function DelveCompanion_InDelveWidgetItemMixin:PlayAnimation()
    local frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime =
        self.Border, 0.7, 0.7, -1, false, 0, 0
    UIFrameFlash(frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime)
end

---@param self InDelveWidgetItem
function DelveCompanion_InDelveWidgetItemMixin:StopAnimation()
    UIFrameFlashStop(self.Border)
end

---@param self InDelveWidgetItem
---@param code number
function DelveCompanion_InDelveWidgetItemMixin:Set(code)
    self:SetFrameInfo(DelveCompanion.Definitions.CodeType.Item, code)
    self.itemCode = code
    self.hasItem = false
end

---@param self InDelveWidgetItem
function DelveCompanion_InDelveWidgetItemMixin:OnLoad()
    -- Logger.Log("[InDelveWidgetItem] OnLoad start")

    DelveCompanion_CustomActionWidgetMixin.OnLoad(self)
end

---@param self InDelveWidgetItem
function DelveCompanion_InDelveWidgetItemMixin:OnShow()
    -- Logger.Log("[InDelveWidgetItem] OnShow start")

    DelveCompanion_CustomActionWidgetMixin.OnShow(self)
end

---@param self InDelveWidgetItem
function DelveCompanion_InDelveWidgetItemMixin:OnEnter()
    -- Logger.Log("[InDelveWidgetItem] OnEnter start")

    self:StopAnimation()
    DelveCompanion_CustomActionWidgetMixin.OnEnter(self)
end

---@param self InDelveWidgetItem
function DelveCompanion_InDelveWidgetItemMixin:OnHide()
    -- Logger.Log("[InDelveWidgetItem] OnHide start")

    DelveCompanion_CustomActionWidgetMixin.OnHide(self)
end

--#region Xml annotations

--- `DelvelCompanionInDelveWidgetItemTemplate`
---@class InDelveWidgetItemXml : CustomActionWidget
---@field Border Texture
--#endregion
