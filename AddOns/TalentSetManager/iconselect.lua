-- Talent Set Manager
-- by Vildiesel
-- EU-Well of Eternity

local format = string.format

local addonName, addonTable = ...
local L = addonTable.L

local function initializeButtons(self)
 
 TalentSetsDialogPopup.buttons_per_row = 13
 TalentSetsDialogPopup.numrows = 8
 
 self.buttons = {}
 
 local rows = 0

 local button = CreateFrame("CheckButton", "TalentSetsDialogPopupButton1", TalentSetsDialogPopup, "TalentSetPopupButtonTemplate")
 button:SetPoint("TOPLEFT", 20, -105)
 button.tex = ""
 tinsert(self.buttons, button)

 local lastPos
 for i = 2, TalentSetsDialogPopup.buttons_per_row * TalentSetsDialogPopup.numrows do
  button = CreateFrame("CheckButton", "TalentSetsDialogPopupButton" .. i, TalentSetsDialogPopup, "TalentSetPopupButtonTemplate")
  button.tex = ""

  lastPos = (i - 1) / TalentSetsDialogPopup.buttons_per_row
  if lastPos == math.floor(lastPos) then
   button:SetPoint("TOPLEFT", self.buttons[i - TalentSetsDialogPopup.buttons_per_row], "BOTTOMLEFT", 0, -8)
  else
   button:SetPoint("TOPLEFT", self.buttons[i - 1], "TOPRIGHT", 10, 0)
  end
  tinsert(self.buttons, button)
 end
end

function TalentSetsDialogPopup_OnShow(self)
 PlaySound(839)
 self.name = nil
 self.id = nil
 self.isEdit = false
 self.edt_search:SetText("")
 -- called manually
 --RecalculateTalentSetsDialogPopup()
end

function addonTable:CreateIconSelectionFrame()

 local mf = CreateFrame("Frame", "TalentSetsDialogPopup", UIParent, "InsetFrameTemplate")
 mf:EnableMouse(true)
 mf:SetMovable(true)
 mf:RegisterForDrag("LeftButton")
 mf:SetClampedToScreen(true)
 mf:SetScript("OnDragStart", function(self) self:StartMoving() end)
 mf:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
 mf:SetSize(640, 512)
 mf:SetPoint("CENTER")
 mf:SetFrameStrata("DIALOG")

 mf:Hide()
 
 mf.title = mf:CreateFontString(nil, "BACKGROUND", "SystemFont_Shadow_Med3")
 mf.title:SetPoint("TOP", 0, -10)
 mf.title:SetText("Talent Set Manager - "..EDIT)
 
 local g = "|cffaafca3"
 
 -- name editbox
 
 mf.lbl_name = mf:CreateFontString(nil, "BACKGROUND", "Game11Font")
 mf.lbl_name:SetPoint("TOPLEFT", 10, -40)
 mf.lbl_name:SetText(g..GEARSETS_POPUP_TEXT.."|r")

 mf.edt_name = CreateFrame("EditBox", "TalentSetsDialogPopupEditBox", mf, "InputBoxTemplate")
 mf.edt_name:SetSize(182, 20)
 mf.edt_name:SetPoint("TOPLEFT", mf, "TOPLEFT", 19, -55)
 mf.edt_name:SetMaxLetters(16)
 mf.edt_name:SetFontObject("ChatFontNormal")
 mf.edt_name:SetAutoFocus(true)
 
 mf.edt_name:SetScript("OnTextChanged", function(self)
						                 local text = self:GetText()
						                 if text ~= "" then
						                  TalentSetsDialogPopup.name = text
						                 else
						                  TalentSetsDialogPopup.name = nil
						                 end
						                 TalentSetsDialogPopupOkay_Update()
                                        end)
 mf.edt_name:SetScript("OnEscapePressed", TalentSetsDialogPopupCancel_OnClick)
 mf.edt_name:SetScript("OnEnterPressed", function()
                        				  if TalentSetsDialogPopupOkay:IsEnabled() then
	                      				   TalentSetsDialogPopupOkay:Click()
                                          end
	                      			     end)

 -- search editbox
 mf.filter = ""
 
 mf.lbl_search = mf:CreateFontString(nil, "BACKGROUND", "Game11Font")
 mf.lbl_search:SetPoint("TOPLEFT", 280, -40)
 mf.lbl_search:SetText(g..L["search_icon"].."|r")
 
 mf.edt_search = CreateFrame("EditBox", "TalentSetsDialogPopupEditBox", mf, "InputBoxTemplate")
 mf.edt_search:SetSize(182, 20)
 mf.edt_search:SetPoint("TOPLEFT", mf, "TOPLEFT", 289, -55)
 --mf.edt_search:SetMaxLetters(16)
 mf.edt_search:SetFontObject("ChatFontNormal")
 mf.edt_search:SetAutoFocus(true)
 mf.edt_search:SetScript("OnTextChanged", function(self)
                                           mf.filter = self:GetText() 
                                           TalentSetsDialogPopup_FilterList(true)
                                           FauxScrollFrame_OnVerticalScroll(TalentSetsDialogPopupScrollFrame, 0, 36, nil)
                                          end)

 -- scrollframe
 mf.scrollFrame = CreateFrame("ScrollFrame", "TalentSetsDialogPopupScrollFrame", mf, "FauxScrollFrameTemplate")
 mf.scrollFrame:SetSize(600, 350)
 mf.scrollFrame:SetPoint("TOPLEFT", mf, "TOPLEFT", 10, -100)
 mf.scrollFrame:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, 36, TalentSetsDialogPopup_Update) end)
 
 -- cancel
 mf.cancel = CreateFrame("Button", "TalentSetsDialogPopupCancel", mf, "UIPanelButtonTemplate")
 mf.cancel:SetPoint("BOTTOMRIGHT", mf, "BOTTOMRIGHT", -11, 13)
 mf.cancel:SetText(CANCEL)
 mf.cancel:SetSize(78, 22)
 mf.cancel:SetScript("OnClick", TalentSetsDialogPopupCancel_OnClick)
 
 -- okay
 mf.okay = CreateFrame("Button", "TalentSetsDialogPopupOkay", mf, "UIPanelButtonTemplate")
 mf.okay:SetPoint("BOTTOMRIGHT", mf.cancel, "BOTTOMLEFT", -2, 0)
 mf.okay:SetText(OKAY)
 mf.okay:SetSize(78, 22)
 mf.okay:SetScript("OnClick", TalentSetsDialogPopupOkay_OnClick)
 
 f = CreateFrame("Button", nil, mf, "UIPanelButtonTemplate")
 f:SetPoint("TOPRIGHT", -1, -1)
 f:SetText("X")
 f:SetWidth(22)
 f:SetScript("OnClick", TalentSetsDialogPopupCancel_OnClick)

 mf:SetScript("OnMouseUp", function(self, button) if button == "RightButton" then TalentSetsDialogPopupCancel_OnClick() end end)
 mf:SetScript("OnShow", TalentSetsDialogPopup_OnShow)
 mf:SetScript("OnHide", TalentSetsDialogPopup_OnHide)
 
 initializeButtons(mf)
end
