local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) OverviewBountifulFrame : OverviewBountifulFrameXml
---@field bountifulButtonsPool any
DelveCompanion_OverviewBountifulFrameMixin = {}

---@param self OverviewBountifulFrame
function DelveCompanion_OverviewBountifulFrameMixin:OnLoad()
    -- Logger.Log("OverviewBountifulFrame OnLoad start")
    self.Title:SetText(Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE)

    self.ActiveDelves.NoBountifulLabel:SetText(Lockit.UI_NO_ACTIVE_BOUNTIFUL)
    self.bountifulButtonsPool = CreateFramePool("BUTTON", self.ActiveDelves.Container,
        "DelveCompanionOverviewBountifulButtonTemplate")

    self.DelveOBotWidget.Cooldown:SetCountdownFont("GameFontHighlightSmall")
end

---@param self OverviewBountifulFrame
function DelveCompanion_OverviewBountifulFrameMixin:OnEvent(event, ...)
    -- Logger.Log("OverviewBountifulFrame OnEvent start")
end

---@param self OverviewBountifulFrame
function DelveCompanion_OverviewBountifulFrameMixin:OnShow()
    -- Logger.Log("OverviewBountifulFrame OnShow start")
    DelveCompanion:UpdateDelvesData()

    for index, delveData in ipairs(DelveCompanion.Variables.delvesData) do
        if delveData.isBountiful then
            ---@type OverviewBountifulButton
            local button = self.bountifulButtonsPool:Acquire()
            button:Init(delveData, index)
            button:Show()
        end
    end

    local spaceAvailable = self.Title:GetBottom() - self.Divider:GetTop()
    self.ActiveDelves:SetHeight(spaceAvailable)
    self.ActiveDelves.Container.fixedHeight = spaceAvailable
    self.ActiveDelves.Container:Layout()

    self.ActiveDelves.NoBountifulLabel:SetShown(#self.ActiveDelves.Container:GetLayoutChildren() == 0)
end

---@param self OverviewBountifulFrame
function DelveCompanion_OverviewBountifulFrameMixin:OnHide()
    -- Logger.Log("OverviewBountifulFrame OnHide start")

    self.bountifulButtonsPool:ReleaseAll()
end

--#region XML Annotations

--- `DelveCompanionOverviewBountifulFrameTemplate.ActiveDelves`
---@class (exact) OverviewBountifulFrameActiveDelvesXml : Frame
---@field NoBountifulLabel FontString
---@field Container HorizontalLayoutFrame

--- `DelveCompanionOverviewBountifulFrameTemplate`
---@class (exact) OverviewBountifulFrameXml : Frame
---@field Divider Texture
---@field Title FontString
---@field DelveOBotWidget DelveOBotWidget
---@field ActiveDelves OverviewBountifulFrameActiveDelvesXml

--#endregion
