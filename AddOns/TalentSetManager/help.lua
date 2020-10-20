-- Talent Set Manager
-- by Jadya
-- EU-Well of Eternity

local format = string.format

local addonName, addonTable = ...
local L = addonTable.L

local hf

local function helpButton_OnClick(f)
 if not hf then
  hf = CreateFrame("Frame", "TalentSetManagerHelpFrame", UIParent, "InsetFrameTemplate")
  hf:EnableMouse(true)
  hf:SetMovable(true)
  hf:RegisterForDrag("LeftButton")
  hf:SetClampedToScreen(true)
  hf:SetScript("OnMouseUp", function(self, button) if button == "RightButton" then hf:Hide() end end)
  hf:SetScript("OnDragStart", function(self) self:StartMoving() end)
  hf:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  hf:SetSize(400, 180)
  hf:SetPoint("CENTER")
  hf:SetFrameStrata("DIALOG")
  
  hf.title = hf:CreateFontString(nil, "BACKGROUND", "SystemFont_Shadow_Med3")
  hf.title:SetPoint("TOP", 0, -10)
  hf.title:SetText("Talent Set Manager - "..GUILDINFOTAB_INFO)

  hf.text = hf:CreateFontString(nil, "BACKGROUND", "Game11Font")
  hf.text:SetPoint("TOPLEFT", 10, -40)
  hf.text:SetPoint("BOTTOMRIGHT", -10, 40)
  hf.text:SetJustifyH("LEFT")
  hf.text:SetJustifyV("TOP")
 
  local g = "|cffaafca3"
  local w = "|cffd3d3d3"
  
  hf.text:SetText(g..L["help_title1"].."\n"..
                  w..L["help_string1"].."\n\n")
                  
  local function closefunc()
   hf:Hide()
  end
  
  local f = CreateFrame("Button", nil, hf, "UIPanelButtonTemplate")
  f:SetPoint("BOTTOM", 0, 10)
  f:SetText(OKAY)
  f:SetWidth(80)
  f:SetScript("OnClick", closefunc)
 
  f = CreateFrame("Button", nil, hf, "UIPanelButtonTemplate")
  f:SetPoint("TOPRIGHT", -1, -1)
  f:SetText("X")
  f:SetWidth(22)
  f:SetScript("OnClick", closefunc)
  
  hf:Show()
 elseif hf:IsVisible() then
  hf:Hide()
 else
  hf:Show()
 end
end



function addonTable:CreateHelpButton(mf)
 local f = CreateFrame("Button", "TalentSetManagerHelpButton", mf)
 f:SetSize(64, 64)
 f:SetHitRectInsets(20, 20, 20, 20)
 f:SetPoint("CENTER", mf, "TOP", 0, 10)
 
 f.bg = f:CreateTexture(nil, "BACKGROUND")
 f.bg:SetTexture("interface\\common\\help-i")
 f.bg:SetSize(46, 46)
 f.bg:SetPoint("CENTER")
 
 f.border = f:CreateTexture(nil, "BORDER")
 f.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
 f.border:SetSize(64, 64)
 f.border:SetPoint("CENTER", 12, -13)
 
 local tx = f:CreateTexture(nil, "HIGHLIGHT")
 tx:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
 tx:SetBlendMode("ADD")
 tx:SetSize(46, 46)
 tx:SetPoint("CENTER", -1, 1)
 f:SetHighlightTexture(tx)

 f:SetScript("OnClick", helpButton_OnClick)
 f:SetScript("OnEnter", function(self)
   GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
   GameTooltip:AddLine(GUILDINFOTAB_INFO)
   GameTooltip:Show()
  end)
 f:SetScript("OnLeave", function() GameTooltip:Hide() end)
 f:SetScript("OnMouseDown", function(self) self.bg:SetPoint("CENTER", 1, -1) end)
 f:SetScript("OnMouseUp", function(self) self.bg:SetPoint("CENTER", 0, 0) end)
 
 return f
end

--[[
function addonTable:CreateNewsFrame()

 local mf = CreateFrame("Frame", "TalentSetsDialogPopup", TalentSetsMainframe, "InsetFrameTemplate")
 mf:SetPoint("TOPLEFT", TalentSetsMainframe, "BOTTOMLEFT")
 mf:SetPoint("TOPRIGHT", TalentSetsMainframe, "BOTTOMRIGHT")
 mf:SetHeight(80)

 mf.title = mf:CreateFontString(nil, "BACKGROUND", "SystemFont_Shadow_Med3")
 mf.title:SetPoint("TOP", 0, -5)
 mf.title:SetText(SPLASH_BASE_HEADER)
 
 local function closedialog()
  mf:Hide()
 end

 mf:SetScript("OnMouseUp", function(self, button) if button == "RightButton" then closedialog() end end)
end
]]
