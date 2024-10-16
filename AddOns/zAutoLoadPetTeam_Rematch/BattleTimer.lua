local utils = ALPTRematch.utils

local g = {
  timeLastStart = 0,
  timeLastEnd = 0,
  teamTimer = {},
  npcTimer = {},
  firstBattle = false,
  resetPrint = true,
  isForfeit = false,
  isLost = false,
  lastXp = nil,
  thisXp = 0
}

local frame = CreateFrame("FRAME", nil, UIParent)
frame:RegisterEvent("PLAYER_XP_UPDATE")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PET_BATTLE_OPENING_START")
frame:RegisterEvent("PET_BATTLE_CLOSE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript(
  "OnEvent",
  function(self, event, ...)
    if event == "PET_BATTLE_OPENING_START" then
      ALPTRematch:BattleTimerBegin()
    elseif event == "PLAYER_ENTERING_WORLD" then
      g.lastXp = UnitXP("player")
    elseif event == "PET_BATTLE_CLOSE" then
      if not C_PetBattles.IsInBattle() then
        if utils.alptconfig.enableXpLog and utils:CanLevelUP() and not g.isForfeit and not g.isLost then
          --推迟到经验获取再输出
        else
          C_Timer.After(
            0.005,
            function()
              ALPTRematch:BattleTimerEnd()
            end
          )
        end
      else
        g.isForfeit = false
        g.isLost = false
        local selfAlive = false
        local enemyAlive = false
        for petEnemy = 1, C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
          local health = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, petEnemy)
          if health and health > 0 then
            enemyAlive = true
            break
          end
        end
        for petSelf = 1, C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
          local health = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, petSelf)
          if health and health > 0 then
            selfAlive = true
            break
          end
        end
        if not enemyAlive then
          if not selfAlive then --同归于尽
            g.isLost = true
          end
        else
          if selfAlive then --投降
            g.isForfeit = true
          else
            g.isLost = true --阵亡
          end
        end
      end
    elseif event == "PLAYER_XP_UPDATE" then
      C_Timer.After(
        0.005,
        function()
          ALPTRematch:BattleTimerEnd()
        end
      )
    end
  end
)



function ALPTRematch:BattleTimerBegin()
  if utils.alptconfig.enableBattleTimer then
    g.timeLastStart = time()
    g.resetPrint = false
    g.loadingKey = ALPTRematch:GetCurrentKey()
    g.npcId = ALPTRematch:GetCurrentNpcId()
  end
end

function ALPTRematch:BattleTimerEnd()
  if not g.loadingKey then
    return
  end
  if g.resetPrint then
    return
  end
  local msg = ""

  local nw = time()
  local usedTime = nw - g.timeLastStart

  local timeFromLastEnd = usedTime
  if g.timeLastEnd > 0 then
    timeFromLastEnd = nw - g.timeLastEnd
  end
  g.timeLastEnd = nw

  if usedTime < 1 then
    return
  end
  if not g.teamTimer[g.loadingKey] then
    g.teamTimer[g.loadingKey] = {0, 0, 0, 0, 0, 0, 0, 0}
  end
  if not g.npcTimer[g.npcId] then
    g.npcTimer[g.npcId] = {0, 0}
  end

  local teamTimer = g.teamTimer[g.loadingKey]
  local npcTimer = g.npcTimer[g.npcId]
  if not g.isForfeit and not g.isLost then
    teamTimer[1] = teamTimer[1] + usedTime
    teamTimer[2] = teamTimer[2] + 1

    if teamTimer[7] == 0 or teamTimer[7] > usedTime then
      teamTimer[7] = usedTime
    end

    if teamTimer[8] < usedTime then
      teamTimer[8] = usedTime
    end

    if timeFromLastEnd - usedTime < 5 then
      --间隔太长的不算在统计里
      teamTimer[3] = teamTimer[3] + timeFromLastEnd
      teamTimer[4] = teamTimer[4] + 1
    else
      teamTimer[3] = teamTimer[3] + usedTime + 3
      teamTimer[4] = teamTimer[4] + 1
    end

    teamTimer[5] = teamTimer[5] + 1

    npcTimer[1] = npcTimer[1] + usedTime
    npcTimer[2] = npcTimer[2] + 1
  end
  if g.isLost then
    teamTimer[6] = teamTimer[6] + 1
  end
  if utils.alptconfig.enableBattleTimer then
    msg = "本次用时 " .. usedTime
    if timeFromLastEnd >= usedTime then
      msg = msg .. "/" .. timeFromLastEnd
    end
    msg = msg .. " 秒"

    if g.teamTimer[g.loadingKey][2] > 0 then
      local avg1 = math.ceil(teamTimer[1] / teamTimer[2])
      local avg2 = math.ceil(teamTimer[3] / teamTimer[4])
      ALPTRematch:LogTeamTime(avg1, avg2)
      msg = msg .. "，本队平均用时 " .. avg1 .. "/" .. avg2 .. " 秒(" .. teamTimer[7] .. "-" .. teamTimer[8] .. ")"
    end

    if teamTimer[6] > 0 then
      msg = msg .. "，失败 " .. teamTimer[6] .. " 次"
    end
  end

  local levelUpStr
  if utils.alptconfig.enableXpLog then
    self:CalcXP()
    if g.leftTime and g.leftTime > 0 then
      levelUpStr = "预计 " .. string.format("%.1f", g.leftTime / 60) .. " 分钟升级"
    else
      if g.leftTime == 0 then
        levelUpStr = "正在估算升级时间"
      end
    end

    if levelUpStr then
      if msg and msg ~= "" then
        msg = msg .. "，" .. levelUpStr
      else
        msg = levelUpStr
      end
    end
  end

  if msg and msg ~= "" then
    ALPTRematch:PrintTimer(msg)
  end
  g.resetPrint = true
end

function ALPTRematch:CalcXP()
  if not utils.alptconfig.enableXpLog then
    g.leftTime = -1
    return
  end

  if not utils:CanLevelUP() then
    g.leftTime = -1
    return
  end

  local currentXP = UnitXP("player")
  local totalXP = UnitXPMax("player")

  if not g.lastXp then
    g.lastXp = currentXP
    g.thisXp = 0
  else
    if currentXP > g.lastXp then
      g.thisXp = currentXP - g.lastXp
    end
    g.lastXp = currentXP
  end

  if g.thisXp == 0 then
    g.leftTime = 0
    return
  end

  local toLevelXP = totalXP - currentXP
  local counts = math.ceil(toLevelXP / g.thisXp)

  if g.npcTimer[g.npcId][2] > 0 then
    local timePerOne = math.ceil(g.npcTimer[g.npcId][1] / g.npcTimer[g.npcId][2]) + 3
    g.leftTime = timePerOne * counts
  end
end
