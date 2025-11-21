
local utils = ALPTRematch.utils
local conf
local teamKey
local tdBattlePetScriptAddon = tdBattlePetScript and tdBattlePetScript:GetPlugin("Rematch")
local PetBattleScriptsAddon = PetBattleScripts and PetBattleScripts:GetPlugin("Rematch")
local rematch = Rematch

function ALPTRematch:deleteConfig()
  utils.alpt[teamKey] = nil
  rematch.dialog:HideDialog()
  rematch.teamsPanel:Update()
end

local function ALPT_InitInputValue(key, value)
  conf[key]:SetText(value)
  conf[key].var = value
end

local function InitConfiDialog()
  rematch.dialog:Register("ALPTCConfigs",
  {
    title = "换队参数设置", -- Saved As, Edit Team, Receiving Team
    accept = SAVE,
    cancel = CANCEL,
    other = DELETE,
    width = 590,
    minHeight = 500,
    stayOnOther = true,
    layouts = { },
    refreshFunc = nil,
    changeFunc = nil,
    otherFunc =  ALPTRematch.deleteConfig,
    acceptFunc = ALPTRematch.ConfigSave,
})
  conf = rematch.dialog.Canvas.ALPTCConfigs
  
  conf.Disable.text:SetText("停用队伍")
  for i = 1, 3 do
    conf["HP" .. i].Label:SetText("有效血线")
    conf["HP" .. i].LabelR:SetText("%")
    conf["Breed" .. i].text:SetText("忽略属性")
    conf["MinLvl" .. i].Label:SetText("（最低")
    conf["MinLvl" .. i].LabelR:SetText("级）")

    conf["NoAlt" .. i].text:SetText("禁用替补")
    conf["Highest" .. i].text:SetText("最高血量")
    conf["Lowest" .. i].text:SetText("最低血量")

    conf["UseGroup" .. i].text:SetText("使用宠物组")

    conf["FilterHP" .. i .. "_1"].Label:SetText("血量")
    conf["FilterHP" .. i .. "_2"].Label:SetText("-")

    conf["FilterAttack" .. i .. "_1"].Label:SetText("攻击")
    conf["FilterAttack" .. i .. "_2"].Label:SetText("-")

    conf["FilterSpeed" .. i .. "_1"].Label:SetText("速度")
    conf["FilterSpeed" .. i .. "_2"].Label:SetText("-")
  end
end

function ALPTRematch:OpenSetting(key)
  teamKey = key
  rematch.dialog:HideDialog()
   
  local dialog =
    rematch.dialog:ShowDialog(
    "ALPTCConfigs"
  )
  rematch.dialog:Resize()

  local titlename = utils:getTeamNameByKey(key)
  local alpt = ALPTRematch:FixTeamConfig(teamKey)
  if alpt.avg1 and alpt.avg2 then
    titlename = titlename .."( "..alpt.avg1.." - "..alpt.avg2.." 秒)"
  end

  conf.TeamName:SetText(titlename)

  
  conf.Disable:SetChecked(alpt.disabled)
  for i = 1, 3 do
    ALPT_InitInputValue("HP" .. i, alpt.healthCheck[i])

    conf["Breed" .. i]:SetChecked(alpt.ignoreBreed[i])
    conf["MinLvl" .. i]:SetText(alpt.minLvl[i])
    conf["NoAlt" .. i]:SetChecked(alpt.noAlt[i])
    conf["Highest" .. i]:SetChecked(alpt.highest[i])
    conf["Lowest" .. i]:SetChecked(alpt.lowest[i])
    conf["UseGroup" .. i]:SetChecked(alpt.useGroup[i])

    local groupi = alpt.groups[i]
    if groupi and groupi.name then
      groupi = groupi.name
      alpt.groups[i] = groupi
    end
    UIDropDownMenu_SetText(conf["Groups" .. i], alpt.groups[i] or "无")

    ALPT_InitInputValue("FilterHP" .. i .. "_1", alpt.hp[i][1])
    ALPT_InitInputValue("FilterHP" .. i .. "_2", alpt.hp[i][2])

    ALPT_InitInputValue("FilterAttack" .. i .. "_1", alpt.attack[i][1])
    ALPT_InitInputValue("FilterAttack" .. i .. "_2", alpt.attack[i][2])

    ALPT_InitInputValue("FilterSpeed" .. i .. "_1", alpt.speed[i][1])
    ALPT_InitInputValue("FilterSpeed" .. i .. "_2", alpt.speed[i][2])
  end

  conf:SetPoint("TOP", 0, -36)
  conf:Show()
end

function ALPTRematch:ConfigSave()
  cfg = utils.alpt[teamKey]
  cfg.disabled = conf["Disable"]:GetChecked()
  for i = 1, 3 do
    cfg.noAlt[i] = conf["NoAlt" .. i]:GetChecked()
    cfg.healthCheck[i] = tonumber(conf["HP" .. i]:GetText()) or 100
    if cfg.healthCheck[i]>100 then
      cfg.healthCheck[i] = 100
    end
    cfg.ignoreBreed[i] = conf["Breed" .. i]:GetChecked()
    cfg.highest[i] = conf["Highest" .. i]:GetChecked()
    cfg.lowest[i] = conf["Lowest" .. i]:GetChecked()
    cfg.minLvl[i] = tonumber(conf["MinLvl" .. i]:GetText()) or 25
    if cfg.minLvl[i]>25 then
      cfg.minLvl[i] = 25
    end
    cfg.useGroup[i] = conf["UseGroup" .. i]:GetChecked()
    cfg.groups[i] = UIDropDownMenu_GetText(conf["Groups" .. i])
    cfg.hp[i] = {
      tonumber(conf["FilterHP" .. i .. "_1"]:GetText()) or 0,
      tonumber(conf["FilterHP" .. i .. "_2"]:GetText()) or 9999
    }

    cfg.speed[i] = {
      tonumber(conf["FilterSpeed" .. i .. "_1"]:GetText()) or 0,
      tonumber(conf["FilterSpeed" .. i .. "_2"]:GetText()) or 999
    }

    cfg.attack[i] = {
      tonumber(conf["FilterAttack" .. i .. "_1"]:GetText()) or 0,
      tonumber(conf["FilterAttack" .. i .. "_2"]:GetText()) or 999
    }
  end
  utils.alpt[teamKey] = cfg

  ALPTRematch:CheckCFG(teamKey)
  rematch.dialog:HideDialog()
  rematch.teamsPanel:Update()
 
end

function ALPTRematch_DropDown(func)
  local info = UIDropDownMenu_CreateInfo()
  info.text = "无"
  info.value = 0
  info.func = func
  UIDropDownMenu_AddButton(info)

  local petGroups, groupIndexs,groupPetIndexs = ALPTRematch:GetPetGroups()

  if petGroups then
    for m = 1, #groupIndexs do
      local groupName = groupIndexs[m]
      local info = UIDropDownMenu_CreateInfo()
      info.text = groupName
      info.value = groupName
      info.func = func
      UIDropDownMenu_AddButton(info)
    end
  end
end

function ALPTRematch_HighestCheck(i)
  conf["Lowest" .. i]:SetChecked(false)
end
function ALPTRematch_LowestCheck(i)
  conf["Highest" .. i]:SetChecked(false)
end
function ALPTRematch_DropDown1()
  ALPTRematch_DropDown(ALPTRematch_OnSelect1)
end

function ALPTRematch_OnSelect1(self)
  UIDropDownMenu_SetSelectedValue(conf.Groups1, self.value)
end

function ALPTRematch_DropDown2()
  ALPTRematch_DropDown(ALPTRematch_OnSelect2)
end

function ALPTRematch_OnSelect2(self)
  UIDropDownMenu_SetSelectedValue(conf.Groups2, self.value)
end

function ALPTRematch_DropDown3()
  ALPTRematch_DropDown(ALPTRematch_OnSelect3)
end

function ALPTRematch_OnSelect3(self)
  UIDropDownMenu_SetSelectedValue(conf.Groups3, self.value)
end

local Org_PetListButtonOnClick = RematchCommonPetListButtonMixin.OnClick
local Org_FillTeam1 = RematchNormalTeamListButtonMixin.FillTeam
local Org_FillTeam2 = RematchCompactTeamListButtonMixin.FillTeam

function ALPTRematch:FindMenuItem(menu, text)
  for i, v in ipairs(menu) do
    if v.text == text then
      return v
    end
  end
end

local function rename(oldkey, newkey)
  if not oldkey then
    return
  end
  if oldkey == newkey then
    return
  end
  if utils.alpt[oldkey] then
    if newkey then
      utils.alpt[newkey] = utils.alpt[oldkey]
    end
    utils.alpt[oldkey] = nil
  end
end

local teamMenu = {
  text = "换队参数设置",
  func = function(_, key, ...)
    ALPTRematch:OpenSetting(key)
  end
}
 
local teamDisableMenu = {
  text = function(self, key)
    local alpt = utils.alpt[key]
    if alpt and alpt.disabled then
      return "启用"
    else
      return "停用"
    end
  end,
  func = function(_, key, ...)
    local alpt = utils.alpt[key]
    if not alpt then
      alpt = {disabled = false}
      utils.alpt[key] = alpt
    end
    alpt.disabled = not alpt.disabled
    ALPTRematch:CheckCFG(key)
    rematch.dialog:HideDialog()
    rematch.teamsPanel:Update()
  end
}

local function PetCantBattle(petID)
  return rematch.petInfo:Fetch(petID).canBattle
end

local PetGroupMenu = {}
local addToGroupName = {
  text = "添加到宠物组",
  hidden = function(entry, petID)
    return not PetCantBattle(petID) or not ALPTRematch:HasGroup()
  end,
  subMenu = "PetGroupMenu"
}

function ALPTRematch:InitGroupMenu()
  PetGroupMenu = {}
  local petGroups, groupIndexs,groupPetIndexs = ALPTRematch:GetPetGroups()

  for m = 1, #groupIndexs do
    local groupName = groupIndexs[m]
    tinsert(
      PetGroupMenu,
      {
        text = groupName,
        func = function(entry, petID)
          local speciesID, _, _, _, _, _, _, speciesName = C_PetJournal.GetPetInfoByPetID(petID)
          ALPTRematch:AddGroupPet(groupName, speciesID, speciesName)
          ALPTRematch:NotifyChange()
        end
      }
    )
  end
  rematch.menus:Register("PetGroupMenu", PetGroupMenu)
end

function ALPTRematch:PreferencesOnChar()
  rematch.tooltip:Hide()
  if not tonumber(self:GetText()) then
    self:SetText(self.var or "0")
  end
end

function ALPTRematch:PreferencesOnTextChanged()
  local value = tonumber(self:GetText())
  self.var = value
end

local function isTeamDisabled(teamKey)
  if utils.alpt and utils.alpt[teamKey] then
    return utils.alpt[teamKey].disabled
  end
  return false
end

function createSettingButton(parent,teamID)
  
  -- if not parent.SettingButton then
  --   local button = CreateFrame("Button", nil, parent, "RematchNotesButtonTemplate")
  --   button:SetSize(18, 18)
  --   button.key = teamID
  --   button:SetNormalTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
  --   button:SetPushedTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
  --   button:SetScript(
  --     "OnClick",
  --     function(button)
  --       ALPTRematch:OpenSetting(button.key)
  --     end
  --   )
  --   button:SetScript(
  --     "OnEnter",
  --     function(button)
        
  --     end
  --   )
  --   button:SetScript("OnLeave", function(button)
        
  --   end)
  --   parent.SettingButton = button
  -- else
  --   parent.SettingButton.key = teamID
  -- end
  -- local setBtn = parent.SettingButton 

  if isTeamDisabled(teamID) then
    parent.Name:SetText(GRAY_FONT_COLOR_CODE .. utils:getTeamNameByKey(teamID) .. FONT_COLOR_CODE_CLOSE)
  else
    parent.Name:SetText(utils:getTeamNameByKey(teamID))
  end

  -- local aplt = utils.alpt[teamID] or {}
  -- local alptconfig = utils.alptconfig.rematchEx or {}
  -- local changed = aplt.changed 
  -- local noteButton = parent.NotesButton
 
  -- local isShow = alptconfig.showSetButton==1 or (changed and alptconfig.showSetButton==2) 
  -- if  isShow then
  --   setBtn:ClearAllPoints()
  --   if changed then
  --     setBtn:SetNormalTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting_ok")
  --     setBtn:SetPushedTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting_ok")
  --   else
  --     setBtn:SetNormalTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
  --     setBtn:SetPushedTexture("Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting")
  --   end

  --   -- noteButton:ClearAllPoints()
  --   -- noteButton:SetPoint("RIGHT",-40,0)
     
  --   setBtn:SetPoint("LEFT", parent, "RIGHT", 1, 0)
  --   parent:SetSize(200,44 )
  --   setBtn:Show();
  -- else
  --   setBtn:Hide();
  -- end
   
end

function ALPTRematch:InitRemacthEx()
  local settings = Rematch5Settings

  local CFG = utils.alptconfig
 
  local  alptconfig =
    (utils.alptconfig and utils.alptconfig.rematchEx) or
    {
      useTeamMenu = true,
      showSetButton = 1,
      useGroupMenu = true,
      fillSaveAsTeamName = true,
      keepRematchConfig = fasle,
      useRigthCage = true
    }


  if not alptconfig.keepRematchConfig then
    settings["InteractOnTarget"] = 0
    settings["InteractOnSoftInteract"] = 0
    settings["InteractOnMouseover"] = 0
    settings["LoadHealthiest"] = false
    settings["LoadHealthiestAny"] = false
    settings["LoadHealthiestAfterBattle"] = false  
  end
  
  InitConfiDialog()
 
  if alptconfig.useRigthCage then
    rematch.PetListButtonOnClick = function(self, button)
      if
        C_PetJournal.IsJournalUnlocked() and IsControlKeyDown() and button == "RightButton" and self and self.petID and
          C_PetJournal.PetIsTradable(self.petID) and
          self.Name
       then
        local petName = self.Name:GetText()
        C_PetJournal.CagePetByID(self.petID)
        print(YELLOW_FONT_COLOR_CODE .. petName .. "已装笼" .. FONT_COLOR_CODE_CLOSE)
      else
        Org_PetListButtonOnClick(self, button)
      end
    end
  end

  if alptconfig.useRigthCage then
    RematchCommonPetListButtonMixin.OnClick= function(self, button)
      if
        C_PetJournal.IsJournalUnlocked() and IsControlKeyDown() and button == "RightButton" and self and self.petID and
          C_PetJournal.PetIsTradable(self.petID)
       then
        local petName = rematch.petInfo:Fetch(self.petID).formattedName
        C_PetJournal.CagePetByID(self.petID)
        print(YELLOW_FONT_COLOR_CODE .. petName .. "已装笼" .. FONT_COLOR_CODE_CLOSE)
      else
        Org_PetListButtonOnClick(self, button)
      end
    end
  end

  if alptconfig.useTeamMenu then
    
    Rematch.menus:AddToMenu('TeamMenu', teamMenu)
    Rematch.menus:AddToMenu('TeamMenu', teamDisableMenu)

    if alptconfig.useGroupMenu then
      ALPTRematch:InitGroupMenu()
      Rematch.menus:AddToMenu('PetMenu', addToGroupName)
    end

    if alptconfig.useTeamMenu or alptconfig.showSetButton > 0 then
      RematchNormalTeamListButtonMixin.FillTeam = function(self,teamID)
        Org_FillTeam1(self,teamID)
        createSettingButton(self,teamID)
      end

      RematchCompactTeamListButtonMixin.FillTeam = function(self,teamID)
        Org_FillTeam2(self,teamID)
        createSettingButton(self,teamID)
      end
 
      Rematch.badges:RegisterBadge('teams', 'ALPTCConfigs1', "Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting", nil, function(parent, teamID)
        local aplt = utils.alpt[teamID]
        return not (aplt and aplt.changed) and alptconfig.showSetButton==1
      end)
      Rematch.badges:RegisterBadge('teams', 'ALPTCConfigs2', "Interface\\AddOns\\zAutoLoadPetTeam_Rematch\\Textures\\setting_ok", nil, function(parent, teamID)
        local aplt = utils.alpt[teamID]
        return aplt and aplt.changed and alptconfig.showSetButton>=1
      end)
    end
 
  end
 
end