-- Talent Set Manager
-- by Jadya
-- EU-Well of Eternity

local format = string.format

local addonName, addonTable = ...
local L = addonTable.L
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")

local btn_cache, btn_list, btn_counter = {}, {}, 0
local ldbbutton, mf, parentButton
local tt

function addonTable.UpdateLDBButton()
 if not ldbbutton or not addonTable.spec then return end

 local t = TalentSetManager_CharacterSaves[addonTable.charname][TalentSetManager_Options.ldb_last_selected][addonTable.spec]
 
 if not t then return end

 for _,v in pairs(t) do
  if addonTable.IsEquipped(v) then
   ldbbutton.text = v.name
   ldbbutton.icon = v.texture
   return
  end
 end
 ldbbutton.text = "Talent Set Manager"
 ldbbutton.icon = "Interface\\Icons\\achievement_guildperk_ladyluck_rank2"
end

local last_t = 0
local function onUpdate(f, elapsed)
 last_t = last_t + elapsed
 if last_t < 0.4 then return end
 last_t = 0
 
 if not MouseIsOver(mf) and parentButton and not parentButton:IsMouseOver() then
  mf:Hide()
 end
end

local function get()
 if #btn_cache > 0 then
  btn_list[#btn_list + 1] = btn_cache[1]
  return tremove(btn_cache, 1)
 else
  local f = CreateFrame("Button", "TSMLDBListButton"..btn_counter, mf, "TSMLDBListButton")
  btn_list[#btn_list + 1] = f
  btn_counter = btn_counter + 1
  return f
 end
end

local function dispose(f)
 btn_cache[#btn_cache + 1] = f
 f:Hide()
end

local function updateList()
 for _,v in pairs(btn_list) do
  dispose(v)
 end
 wipe(btn_list)

 local check

 local h = 81
 local sets = addonTable.spec and TalentSetManager_CharacterSaves[addonTable.charname][tt][addonTable.spec]
 
 if not sets then
  local f = get()
  
  h = h + 20
  f.data = nil
  f:SetText(format(L["no_talent_sets"], "|cff00ff00"..(tt == "talents_pvp" and COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP or COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE).."|r"))
  f:SetPoint("TOPLEFT", mf, "TOPLEFT", 5, -70)
  f.equipmentTexture:Hide()
  f.Check:Hide()
  f.Stripe:Hide()
  f.Icon:SetTexture(nil)
  f:Show()
  mf:SetHeight(h)
  return
 end

 if #sets > 0 then
  for k,v in pairs(sets) do
   local f = get()
   
   if v.equipment then
    f.equipmentTexture:Show()
   else
    f.equipmentTexture:Hide()
   end
   
   h = h + 20
   f:SetPoint("TOPLEFT", mf, "TOPLEFT", 5, -50 + k * -20)
   f:SetText(v.name)

   if addonTable.IsEquipped(v) then
    f.Check:Show()
   else
    f.Check:Hide()
   end
   
   if k % 2 == 0 then
    f.Stripe:SetColorTexture(0.9, 0.9, 1)
    f.Stripe:SetAlpha(0.1)
    f.Stripe:Show()
   else
    f.Stripe:Hide()
   end
   
   f.Icon:SetTexture(v.texture)
   
   f.data = v
   f:Show()
  end
 else
  local f = get()
  
  h = h + 20
  f.data = nil
  f:SetText(format(L["no_talent_sets"], "|cff00ff00"..(tt == "talents_pvp" and COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP or COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE).."|r"))
  f:SetPoint("TOPLEFT", mf, "TOPLEFT", 5, -70)
  f.equipmentTexture:Hide()
  f.Check:Hide()
  f.Stripe:Hide()
  f.Icon:SetTexture(nil)
  f:Show()
 end

 mf:SetHeight(h)
end

function TSMLDBListButton_OnClick(f)
 --PlaySound("igMainMenuOptionCheckBoxOn")
 PlaySound(856)

 if not f.data then return end

 addonTable.LearnTalents(f.data)
 C_Timer.After(0.5, updateList)
end

local function changeSet(f)
 if f == mf.pvp then
  tt = "talents_pvp"
  mf.pve.model:SetAlpha(0.2)
 else
  tt = "talents"
  mf.pvp.model:SetAlpha(0.2)
 end
 
 TalentSetManager_Options.ldb_last_selected = tt
 f.model:SetAlpha(1)
 updateList()
 addonTable.UpdateLDBButton()
end

local function showFrame(p)

 parentButton = p
 
 if not mf then
  mf = CreateFrame("Frame", "TalentSetManagerLDBFrame", UIParent)
  mf:EnableMouse(true)
  mf:SetFrameStrata("DIALOG")
  mf:SetClampedToScreen(true)
  mf:SetBackdrop({bgFile = "Interface\\Buttons\\white8x8", 
                                            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }})
  mf:SetBackdropColor(0,0,0,1)
  mf:SetWidth(180)
  
  local function btn_onenter(self)
   local isSelected = (tt == "talents_pvp" and self == mf.pvp) or (tt == "talents" and self == mf.pve)
   if not isSelected then
    self.model:SetAlpha(0.5)
   end
  end
  
  local function btn_onleave(self)
   local isSelected = (tt == "talents_pvp" and self == mf.pvp) or (tt == "talents" and self == mf.pve)
   if not isSelected then
    self.model:SetAlpha(0.2)
   end
  end

  mf.pve = CreateFrame("Button", nil, mf)
  mf.pve:SetPoint("TOPLEFT", 35, -17)
  mf.pve:SetScript("OnClick", changeSet)
  mf.pve:SetSize(50, 50)
  mf.pve.model = CreateFrame("DressupModel", nil, mf.pve)
  mf.pve.model:SetSize(120, 120)
  mf.pve.model:SetAlpha(TalentSetManager_Options.ldb_last_selected == "talents" and 1 or 0.2)
  mf.pve.model:SetPoint("CENTER")
  mf.pve:SetScript("OnEnter", btn_onenter)
  mf.pve:SetScript("OnLeave", btn_onleave)
  
  mf.pvp = CreateFrame("Button", nil, mf)
  mf.pvp:SetPoint("TOPRIGHT", -20, -12)
  mf.pvp:SetScript("OnClick", changeSet)
  mf.pvp:SetSize(40, 40)
  mf.pvp.model = CreateFrame("DressupModel", nil, mf.pvp)
  mf.pvp.model:SetSize(120, 120)
  mf.pvp.model:SetAlpha(TalentSetManager_Options.ldb_last_selected == "talents_pvp" and 1 or 0.2)
  mf.pvp.model:SetPoint("CENTER")
  mf.pvp:SetScript("OnEnter", btn_onenter)
  mf.pvp:SetScript("OnLeave", btn_onleave)
  
  mf:SetScript("OnUpdate", onUpdate)
 end
  
 local _, center = p:GetCenter()
 if center < UIParent:GetHeight() / 2 then
  mf:ClearAllPoints()
  mf:SetPoint("BOTTOMLEFT", p, "TOPLEFT", -10, 0)
 else
  mf:ClearAllPoints()
  mf:SetPoint("TOPLEFT", p, "BOTTOMLEFT", -10, 0)
 end

 updateList()
 mf.pvp.model:SetModel(UnitFactionGroup("player") == "Horde" and "spells\\pvp_trinket_hord_impact_billboarded.m2" or "spells\\pvp_trinket_alliance_impact_billboarded.m2")
 mf.pvp.model:SetAnimation(6)
 mf.pve.model:SetModel("creature\\boneguard\\boneguard.m2")
 mf.pve.model:SetAnimation(3)
 mf:Show()
end

local function onClick(f, button)
 if button == "LeftButton" then
  ToggleTalentFrame()
  --[[ having trouble with the first list update, to be fixed
  local tab = tt == "talents_pvp" and PlayerTalentFrameTab3 or PlayerTalentFrameTab2
  if tab then
   tab:Click()
  end
  ]]
 end
end

local function onEnter(f)
 showFrame(f)
end

function addonTable:InitializeLDB()
 if ldb then
  tt = TalentSetManager_Options.ldb_last_selected
 
 
  ldbbutton = ldb:NewDataObject("Talent Set Manager", {
                      type = "data source",
                      icon = "Interface\\Icons\\achievement_guildperk_ladyluck_rank2",
                      text = "Talent Set Manager",
                      --label = "TSM",
                      OnClick = onClick,
                      OnEnter = onEnter,})

  addonTable.UpdateLDBButton()
 end
end



