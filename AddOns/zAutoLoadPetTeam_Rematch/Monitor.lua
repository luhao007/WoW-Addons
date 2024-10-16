local frame
local startTime, usedTime
local npcTimer, teamTimer = {}, {}
local npcId, teamKey, lastXp
local thisXp, leftTime, leftCount, xpIncr = 0, 0, 0, 0
local isShow, isForfeit, neadCalc, skipUpdate, heirloaded = false, false, false, false, false
local lines = {}
local tooltip = CreateFrame("GameTooltip")
local utils = ALPTRematch.utils

tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

SLASH_PBLMM1 = "/pblm"
SlashCmdList["PBLMM"] = function(cmd, editbox)
  if cmd == "keep" then
    if utils.alptconfig.monitorShow == 2 then
      utils.alptconfig.monitorShow = 1
    else
      utils.alptconfig.monitorShow = 2
    end
    if utils.alptconfig.monitorShow==2 and not isShow then
      isShow = true
      frame:Show()
    end
    if not (utils.alptconfig.monitorShow==2) and isShow and not C_PetBattles.IsInBattle() then
      isShow = false
      frame:Hide()
    end
  end
end

local function CanLevelUP()
  return utils:CanLevelUP()
end

function PetBattleLevelUpMonitor_OnLoad(self)
  startTime = time()
  if not PBLMData then
    PBLMData = {}
  end

  for i = 1, 40 do
    lines[i] = tooltip:CreateFontString()
    tooltip:AddFontStrings(lines[i], tooltip:CreateFontString())
  end

  frame = PetBattleLevelUpMonitorFrame
  frame:RegisterEvent("PLAYER_XP_UPDATE")
  frame:RegisterEvent("PLAYER_LEVEL_UP")
  frame:RegisterEvent("PET_BATTLE_OPENING_START")
  frame:RegisterEvent("PET_BATTLE_CLOSE")
  frame:RegisterEvent("PLAYER_TARGET_CHANGED")
  frame:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function calcTeam()
  if not neadCalc then
    return
  end
  usedTime = time() - startTime
  if not isForfeit and teamKey then
    if not teamTimer[teamKey] then
      teamTimer[teamKey] = {0, 0}
    end
    teamTimer[teamKey][1] = teamTimer[teamKey][1] + usedTime
    teamTimer[teamKey][2] = teamTimer[teamKey][2] + 1
  end
  if not isForfeit and npcId then
    if not npcTimer[npcId] then
      npcTimer[npcId] = {0, 0}
    end
    npcTimer[npcId][1] = npcTimer[npcId][1] + usedTime
    npcTimer[npcId][2] = npcTimer[npcId][2] + 1
  end
  neadCalc = false
end

local function calcXp()
  if CanLevelUP() then
    calcTeam()
  end
  local currentXP = UnitXP("player")
  local totalXP = UnitXPMax("player")

  if not lastXp then
    lastXp = currentXP
    thisXp = 0
  else
    if currentXP > lastXp then
      thisXp = currentXP - lastXp
    end
    lastXp = currentXP
  end
  if thisXp > 0 then
    local toLevelXP = totalXP - currentXP
    leftCount = math.ceil(toLevelXP / thisXp)
    if npcTimer[npcId] and npcTimer[npcId][2] > 0 then
      local timePerOne = math.ceil(npcTimer[npcId][1] / npcTimer[npcId][2]) + 3
      leftTime = timePerOne * leftCount
    end
  end
end
 
function ALPTRematch:toggleMonitor()
  if utils.alptconfig.monitorShow==2 and not isShow then
    isShow = true
    frame:Show()
  end
  if not (utils.alptconfig.monitorShow==2) and isShow and not C_PetBattles.IsInBattle() then
    isShow = false
    frame:Hide()
  end

  if utils.alptconfig.monitorShow==0 and  isShow then
    isShow = false
    frame:Hide()
  end
end

function PetBattleLevelUpMonitor_OnEvent(self, event, ...)

  if utils.alptconfig.monitorShow == 0 then
    if isShow then
      isShow = false
      frame:Hide()
    end
    return
  end

  if event == "PLAYER_XP_UPDATE" then
    C_Timer.After(
      0.1,
      function()
        calcXp()
      end
    )
  elseif event == "PLAYER_ENTERING_WORLD" then
    lastXp = UnitXP("player")
    ALPTRematch:toggleMonitor()
  elseif event == "PLAYER_TARGET_CHANGED" then
    if
      UnitExists("target") and not UnitIsPlayer("target") and not UnitIsEnemy("player", "target") and
        not (InCombatLockdown() or C_PetBattles.IsInBattle() or C_PetBattles.GetPVPMatchmakingInfo())
     then
      local GUID = UnitGUID("target")
      local unit_type, npcid = GUID:match("(%a+)-%d+-%d+-%d+-%d+-(%d+)-.+")
      if unit_type == "Creature" or unit_type == "BattlePet" then
        npcId = tonumber(npcid)
      end
    end
  elseif event == "PET_BATTLE_OPENING_START" then
    startTime = time()
    usedTime = 0
    teamKey = utils:getCurrentTeamId()
    isForfeit = false
    neadCalc = true
    isShow = true
    frame:Show()
  elseif event == "PET_BATTLE_CLOSE" then
    if not C_PetBattles.IsInBattle() then
      if CanLevelUP() then
        --在获取经验时计算
      else
        calcTeam()
      end
      if not (utils.alptconfig.monitorShow == 2) then
        isShow = false
        frame:Hide()
      end
    else
      for pet = 1, C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
        if C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, pet) > 1 then
          isForfeit = true
          break
        end
      end
    end
  end
end

function PetBattleLevelUpMonitor_OnDragStart(self, button)
  frame:StartMoving()
end

function PetBattleLevelUpMonitor_OnDragStop(self)
  frame:StopMovingOrSizing()
end

local isLevelShow = true
local function Update()
  skipUpdate = false

  if not isShow then
    return
  end
  local cooldown = C_Spell.GetSpellCooldown(125439)
  frame.Heal.Cooldown:SetCooldown(cooldown.startTime, cooldown.duration)
  if cooldown.duration > 0 then
    frame.Heal.Icon:SetVertexColor(0.8, 0.8, 0.8)
  else
    frame.Heal.Icon:SetVertexColor(1, 1, 1)
  end

  local count = C_Item.GetItemCount(86143)
  frame.Bandage.Count:SetText(count)
  if count == 0 then
    frame.Bandage.Icon:SetVertexColor(0.8, 0.8, 0.8)
  else
    frame.Bandage.Icon:SetVertexColor(1, 1, 1)
  end

  if C_PetBattles.IsInBattle() then
    local t1 = time() - startTime
    frame.Timer:SetText(t1)
  end

  if not CanLevelUP() then
    if isLevelShow then
      frame.LabLevel:Hide()
      frame.Level:Hide()
      frame.LabXpLast:Hide()
      frame.XpLast:Hide()
      frame.LabLeftCount:Hide()
      frame.LeftCount:Hide()
      frame.LabTeamName:SetPoint("TOPLEFT", frame.PVP, "BOTTOMLEFT", -130, -100)
      isLevelShow = false
    end
  else
    if not isLevelShow then
      frame.LabLevel:Show()
      frame.Level:Show()
      frame.LabXpLast:Show()
      frame.XpLast:Show()
      frame.LabLeftCount:Show()
      frame.LeftCount:Show()
      frame.LabTeamName:SetPoint("TOPLEFT", frame.LabLeftCount, "BOTTOMLEFT", -0, -15)
      isLevelShow = true
    end

    local level = UnitLevel("player")
    local currentXP = UnitXP("player")
    local totalXP = UnitXPMax("player")
    local gainXPPercent = currentXP / totalXP * 100
    frame.Level:SetText(
      BATTLENET_FONT_COLOR_CODE .. string.format("%d (%.1f%%)", level, gainXPPercent) .. FONT_COLOR_CODE_CLOSE
    )

    frame.XpLast:SetText(GREEN_FONT_COLOR_CODE .. thisXp .. FONT_COLOR_CODE_CLOSE)
    if leftCount > 0 then
      frame.LeftCount:SetText(
        ORANGE_FONT_COLOR_CODE ..
          leftCount .. " 场 (" .. string.format("%.1f", leftTime / 60) .. " 分钟)" .. FONT_COLOR_CODE_CLOSE
      )
    else
      frame.LeftCount:SetText(ORANGE_FONT_COLOR_CODE .. "待统计" .. FONT_COLOR_CODE_CLOSE)
    end
 
  end
  local tk = utils:getCurrentTeamId()
  if tk then
    frame.TeamName:SetText(NORMAL_FONT_COLOR_CODE .. utils:getCurrentTeamName() .. FONT_COLOR_CODE_CLOSE)
  else
    frame.TeamName:SetText("未知")
  end
  local teamAvg = "待统计"
  if tk and teamTimer[tk] and teamTimer[tk][2] > 0 then
    local avg = math.ceil(teamTimer[tk][1] / teamTimer[tk][2])
    PBLMData[tk] = avg
    teamAvg = avg .. " 秒"
  elseif ALPTRematch and ALPTRematch.GetCurrentTeamAvg then
    local avg = ALPTRematch:GetCurrentTeamAvg()
    if avg then
      teamAvg = avg  .. " 秒"
    end  
  elseif tk and PBLMData[tk] then
    teamAvg = PBLMData[tk] .. " 秒"
  end
  frame.TeamInfo:SetText(teamAvg)
  if Rematch5Settings.LevelingQueue then
    frame.Queue:SetText(#Rematch5Settings.LevelingQueue .. "")
  else
    frame.Queue:SetText(RED_FONT_COLOR_CODE .. "0" .. FONT_COLOR_CODE_CLOSE)
  end
  --local safariBuff = GetItemSpell(92738)
  if utils:GetBuffIndex(158486) then
    frame.Hat:SetText(GREEN_FONT_COLOR_CODE .. "狩猎帽" .. FONT_COLOR_CODE_CLOSE)
  else
    frame.Hat:SetText(GRAY_FONT_COLOR_CODE .. "狩猎帽" .. FONT_COLOR_CODE_CLOSE)
  end

  --local pvpBuff = GetSpellInfo(282559)
  if utils:GetBuffIndex(269083) or utils:GetBuffIndex(282559) then
    frame.PVP:SetText(GREEN_FONT_COLOR_CODE .. "战争模式" .. FONT_COLOR_CODE_CLOSE)
  else
    frame.PVP:SetText(GRAY_FONT_COLOR_CODE .. "战争模式" .. FONT_COLOR_CODE_CLOSE)
  end

  -- local index = 0
  -- local buff
  -- repeat
  --     index = index + 1
  --     buff = C_UnitAuras.GetBuffDataByIndex("player",index)
  --     if buff  then
  --         print(buff.spellId .. buff.name)
  --     end
  -- until not buff


end
function PetBattleLevelUpMonitor_OnUpdate(self)
  if skipUpdate then
    return
  end
  skipUpdate = true
  C_Timer.After(
    0.010,
    function()
      Update()
    end
  )
end
