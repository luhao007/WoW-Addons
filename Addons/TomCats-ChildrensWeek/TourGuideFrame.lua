local _, addon = ...
local TCL = addon.TomCatsLibs
local TourGuideFrame
local P, AP

local function ADDON_LOADED(_, event, ...)
    local arg1 = select(1, ...)
    if (arg1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        P = addon.savedVariables.character.preferences
        AP = addon.savedVariables.account.preferences
        function TourGuideFrame.toggle()
            if (TourGuideFrame:IsShown()) then
                HideUIPanel(TourGuideFrame)
            else
                ShowUIPanel(TourGuideFrame)
            end
        end
        ButtonFrameTemplate_HideButtonBar(TourGuideFrame);
        ButtonFrameTemplate_HideAttic(TourGuideFrame);
    end
end

TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)

local TourGuideFrameMixin = {}
_G["TomCats-ChildrensWeekTourGuideFrameMixin"] = TourGuideFrameMixin

function TourGuideFrameMixin:OnLoad()
    _G["TomCats-ChildrensWeekTourGuideFrameMixin"] = nil
    TourGuideFrame = self
    UIPanelWindows[self:GetName()] = {
        area = "left",
        height = 545,
        pushable = 1,
        whileDead = 1,
        width = 575
    }
    self.portrait:SetTexture("Interface\\AddOns\\TomCats-ChildrensWeek\\images\\cw-icon")
    self.portrait:SetTexCoord(0, 1, 0, 1)
    self:SetTitle("TomCat's Tours: Children's Week");
end

function TourGuideFrameMixin:OnShow()
    if ("1.0.6" ~= AP["lastVersionSeen"]) then
        AP["lastVersionSeen"] = "1.0.6"
    end
end
