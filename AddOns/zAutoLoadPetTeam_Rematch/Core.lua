local AutoTeam = ALPTRematch
local AutoTeamData = {}
local enableTeamLoad = true
local utils = ALPTRematch.utils

local g = {
  npcName = "",
  npcId = 0,
  npcWithTeam = "",
  npcIdWithTeam = 0,
  loadTimes = 0,
  isSkip = false,
  isAuto = false,
  delayCount = 0,
  isLoading = false,
  isDefault = false,
  isCaching = false,
  waiting = false,
  waitingTime = 0,
  isPetsReplaced = {false, false, false}
}

local printer = {
  isPrinted = true,
  isDelay = false,
  isIgnored = false,
  count = 0,
  countall = 0,
  countTeam = {}
}

local current = {
  key = "",
  name = "",
  data = nil,
  pets = {{}, {}, {}},
  health = {0, 0, 0},
  healthCheck = nil,
  levelUp = false
}

local PetListCache = {}
local PetGroup = {}
local Alternates = nil --无升级宠物时，升级位的替补
local isInited = false
local hasValidTeam = false
local resurPrinted = false
local isResurable = false
local lastTeamLoad = time()
local  CFG = utils.alptconfig

local function PrintMessage(msg)
  if CFG.debug or CFG.showTeamMessage or CFG.enableBattleTimer or CFG.enableXpLog then
    print(msg)
  end
end

local function WriteLogToFile(logText)
  if CFG.logToFile and BattleLog then
    tinsert(BattleLog.logs, date("[%H:%M:%S]") .. logText)
    BattleLog.endtime = date("%Y-%m-%d %H:%M:%S")
  end
end
local function _clInfo(msg)
  return BATTLENET_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clError(msg)
  return RED_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clWarn(msg)
  return ORANGE_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clSign(msg)
  return GREEN_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clLight(msg)
  return NORMAL_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end

local function isALPTEnable()
  return CFG.enable and enableTeamLoad
end


local function isResurCooldown()
  local cd = C_Spell.GetSpellCooldown(125439)
  return cd.duration == 0
end

local defaultHealthCheck = {100, 100, 100}

local function tcopy(to, from)
  for k, v in pairs(from) do
    if type(v) == "table" then
      if to[k] and type(to[k]) == "table" then
      else
        to[k] = {}
      end
      tcopy(to[k], v)
    else
      to[k] = v
    end
  end
end

local function getTeamConfig(teamKey)

  return ALPTRematch:FixTeamConfig(teamKey)
  
end

local function getTeam(teamKey)
  return utils:getTeamByKey(teamKey)
end

local function isTeamDisabled(teamKey)
  if utils.alpt and utils.alpt[teamKey] then
    return utils.alpt[teamKey].disabled
  end
  return false
end

function AutoTeam:findTeamsFromRematch(npcId, npcName)
  local teamName
  local teams = {}
  local index = 1
  local targetTeam = utils:GetTargetTeams(npcId)
  local useNameRule = false
  if  targetTeam and #targetTeam==1 then
    local team = getTeam(targetTeam[1])
    if team then
      teamName = team.name or npcName
    end
  else
    teamName = npcName
  end
  local matchName = teamName and teamName:match("([^%d%p%c]+)")
 
  if not targetTeam or #targetTeam<=1 then
 
    targetTeam = {}
    for teamID,team in utils:AllTeams() do
      if team.name:match(matchName) then
        targetTeam[index] = teamID
        index = index + 1
      end
    end
    useNameRule = true
  end
  index = 1
  local isfind = false
  local teamList = {}
  local name
  for i=1,#targetTeam do
    local team = getTeam(targetTeam[i])
    if team then
      local isMatch = true
      local hasUpSlot = false
      for i = 1, 3 do
        local petID = team.pets[i]
        if petID == 0 then
          hasUpSlot = true
           break
         end
      end
      if CFG.mode == 2 and hasUpSlot == false then
        isMatch = false
      elseif CFG.mode == 3 and hasUpSlot == true then
         isMatch = false
      end
      if isMatch then
        teamList[index] = {["key"] = team.teamID, ["name"] = team.name}
        index = index + 1
        if CFG.debug then
          if useNameRule then
            print("解析到队伍(名称匹配)：" .. (team.name))
          else
            print("解析到队伍(Rematch管理)：" .. (team.name))
          end
        end
      end
    end
  end
  if useNameRule then
    table.sort(
      teamList,
      function(a, b)
        return a.name==teamName or (a.name < b.name)
      end
    )
  end

  for i = 1, #teamList do
    teams[i] = teamList[i].key
  end

  if #teams<1 then
    return nil
  end

  return teams
end

--是否预设的npc
function AutoTeam:GetNpcData()
  local npcData = AutoTeamData[g.npcId]
  if npcData == nil then
    if utils:GetTargetTeams(g.npcId) then
      npcData = {}
    end
  end
  current.data = npcData
  return npcData ~= nil
end

function AutoTeam:PrintTeams(teamArray)
  PrintMessage("可用队伍")
  for i = 1, #teamArray do
    local tm = getTeam(teamArray[i])
    if tm and tm.name then
      local status = isTeamDisabled(teamArray[i])
      if not status then
        PrintMessage("队伍" .. i .. ":" .. tm.name)
      else
        PrintMessage(_clError("队伍" .. i .. ":" .. tm.name .. "(停用)"))
      end
    end
  end
end

function AutoTeam:getPetStatus(pt)
  local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(pt.petID)
  pt.health = health
  pt.attack = attack
  pt.speed = speed
  pt.percent = math.floor((health * 100) / maxHealth)
end

local speciesIDCur, customNameCur, levelCur, healthCur, maxHealthCur, attackCur, speedCur
local percentCur, percentMinCur
local loadin, pickIndex, petInTeam

function AutoTeam:FillTeamData(team)
  loadin = {{}, {}, {}}
  pickIndex = 1
  petInTeam = {}
  local hasLevelUp = false

  for i = 1, 3 do
    local petID = team.pets[i]
    if petID == 0 then
      if CFG.debug then
        print("更新下Rematch队列参数：" .. team.name)
      end
      utils:updateQueue(team.teamID)
      hasLevelUp = true 
      break
    end
  end

  for i = 1, 3 do
    local petID = team.pets[i]

    if petID and petID ~= 0 then
      loadin[i][0] = false
      loadin[i][1] = petID
      petInTeam[petID] = true
      local abilitys = {}

      local petInfo = utils:getPetInfo(petID)
      local speciesID = petInfo.speciesID

      local speciesAbilities = petInfo.abilityList
      abilitys[1],abilitys[2],abilitys[3] = utils:GetAbilities(team,i)
      for j = 1, 3 do
        local abilityID = abilitys[j]
        if abilityID and abilityID ~= 0 then
          if not speciesAbilities[j] or speciesAbilities[j] == abilityID or speciesAbilities[j + 3] == abilityID then
            loadin[i][j + 1] = abilityID
          end
        end
      end
    elseif petID == 0 then
      loadin[i][0] = true

      local levelUpPet = utils:getQueuePet(pickIndex)
      pickIndex = pickIndex + 1
      if not levelUpPet or not utils:getQueuePetCanLevel(levelUpPet) then
        loadin[i][1] = Alternates or 0
        if loadin[i][1] ~= 0 then
          petInTeam[loadin[i][1]] = true
        end
      else
        loadin[i][1] = levelUpPet
        petInTeam[levelUpPet] = true
      end
    end
  end
  return hasLevelUp
end

function AutoTeam:LoadFromGroup(tcfg, m)
  local success = false
  local replaced = false
  local groupName = tcfg.groups[m]

  local hpcheck = tcfg.hp[m] or {0, 9999}
  local attackcheck = tcfg.attack[m] or {0, 999}
  local speedcheck = tcfg.speed[m] or {0, 999}

  if groupName and PetGroup[groupName] then
    if CFG.debug then
      print(m .. "号宠尝试同组替补")
    end
    --从自定义组取同类型
    local samepets = PetGroup[groupName]

    for n = 1, #samepets do
      local pt = samepets[n]
      self:getPetStatus(pt)
      if
        pt.percent >= percentMinCur and not petInTeam[pt.petID] and pt.health >= (hpcheck[1] or 0) and
          pt.health <= (hpcheck[2] or 99999) and
          pt.attack >= (attackcheck[1] or 0) and
          pt.attack <= (attackcheck[2] or 9999) and
          pt.speed >= (speedcheck[1] or 0) and
          pt.speed <= (speedcheck[2] or 9999)
       then
        loadin[m][1] = pt.petID
        petInTeam[pt.petID] = true
        success = true
        replaced = true
        for tt = 1, 3 do
          loadin[m][tt + 1] = pt.abilityID[groupName][tt]
        end
        break
      end
    end
  end

  return success, replaced
end

function AutoTeam:LoadHighest(tcfg, petId, m)
  if CFG.debug then
    print(m .. "号宠尝试加载最高血量>" .. healthCur)
    print("缓存长度"..#PetListCache)
  end
  local samepets = PetListCache[speciesIDCur]
  if samepets == nil or #samepets <= 1 then
    if CFG.debug then
      print(m .. "号宠无可替补宠")
    end
    return false
  end

  local minHealth = healthCur
  local lastPetId = petId
  for n = 1, #samepets do
    repeat
      local pt = samepets[n]
      if petInTeam[pt.petID] then
        break
      end
      self:getPetStatus(pt)
      if pt.health <= minHealth then
        break
      end

      if not tcfg.ignoreBreed[m] and not (pt.attack == attackCur and pt.speed == speedCur) then
        break
      end

      minHealth = pt.health
      lastPetId = pt.petID
    until true
  end

  if minHealth > healthCur then
    loadin[m][1] = lastPetId
    petInTeam[petId] = false
    petInTeam[lastPetId] = true
    if CFG.debug then
      print(m .. "号宠找到更高血量" .. minHealth)
    end
    return true
  end
  return false
end


function AutoTeam:LoadLowest(tcfg, petId, m)
  if CFG.debug then
    print(m .. "号宠尝试加载最低血量<" .. healthCur)
  end
  local samepets = PetListCache[speciesIDCur]
  if samepets == nil or #samepets <= 1 then
    if CFG.debug then
      print(m .. "号宠无可替补宠")
    end
    return false
  end

  local minHealth = healthCur
  local lastPetId = petId
  for n = 1, #samepets do
    repeat
      local pt = samepets[n]
      if petInTeam[pt.petID] then
        break
      end
      self:getPetStatus(pt)
      if pt.health <1 then
        break
      end
      if pt.health >= minHealth then
        break
      end

      if not tcfg.ignoreBreed[m] and not (pt.attack == attackCur and pt.speed == speedCur) then
        break
      end

      minHealth = pt.health
      lastPetId = pt.petID
    until true
  end

  if minHealth < healthCur then
    loadin[m][1] = lastPetId
    petInTeam[petId] = false
    petInTeam[lastPetId] = true
    if CFG.debug then
      print(m .. "号宠找到更低血量" .. minHealth)
    end
    return true
  end
  return false
end

function AutoTeam:LoadSame(tcfg, m)
  if CFG.debug then
    print(m .. "号宠尝试同类型替补")
  end
  local success = false
  local replaced = false
  local samepets = PetListCache[speciesIDCur]
  if samepets == nil or #samepets <= 1 then
    if CFG.debug then
      print(m .. "号宠物替补失败")
    end
    return success, replaced
  end
  for n = 1, #samepets do
    repeat
      local pt = samepets[n]
      if petInTeam[pt.petID] then
        break
      end

      self:getPetStatus(pt)

      if CFG.debug then
        print(pt.speciesName .. pt.percent .. "%")
      end

      if tcfg.ignoreBreed[m] or levelCur == 0 then
        if pt.level >= tcfg.minLvl[m] then
          local hpcheck = tcfg.hp[m] or {0, 9999}
          local attackcheck = tcfg.attack[m] or {0, 999}
          local speedcheck = tcfg.speed[m] or {0, 999}
          if
            pt.health >= (hpcheck[1] or 0) and pt.health <= (hpcheck[2] or 99999) and pt.attack >= (attackcheck[1] or 0) and
              pt.attack <= (attackcheck[2] or 9999) and
              pt.speed >= (speedcheck[1] or 0) and
              pt.speed <= (speedcheck[2] or 9999)
           then
            success = true
          end
        end
      else
        if pt.level == levelCur and pt.attack == attackCur and pt.speed == speedCur then
          success = true
        end
      end
      if not success then
        break
      end

      if pt.percent >= percentMinCur then
        loadin[m][1] = pt.petID
        petInTeam[pt.petID] = true
        success = true
        replaced = true
        return success, replaced
      end

      success = false
    until true
  end
  return success, replaced
end

function AutoTeam:CountAndPrint()
  if not printer.isIgnored then
    printer.count = printer.count + 1
    printer.countall = printer.countall + 1
    if not printer.countTeam[current.key] then
      printer.countTeam[current.key] = 0
    end
    printer.countTeam[current.key] = printer.countTeam[current.key] + 1
  end
  if not printer.isPrinted and CFG.enableBattleTimer then
    printer.isDelay = true --推迟到计时消息后输出
  else
    self:PrintCurrentTeam()
  end
end

function AutoTeam:LoadTeam()
  if self:ActiveTeam() then --if1
    g.isSkip = true
    g.isLoading = false

    if CFG.useRematchLoadingDone then
      utils:ShowRematchDone()
    end

    g.loadTimes = 0

    self:CountAndPrint()
  elseif g.loadTimes < CFG.loadRetries then -- if 2
    g.loadTimes = g.loadTimes + 1
    C_Timer.After(
      CFG.loadRetryInteval,
      function()
        AutoTeam:LoadTeam()
      end
    )
  else
    g.isLoading = false
    g.isSkip = true
    if not g.isAuto then
      local msg = "加载队伍[ " .. current.name .. " ]失败"
      PrintMessage(_clError(msg))
      WriteLogToFile(msg)
    end
  end
end

function AutoTeam:PreLoadTeam(teamKey, isForce)
  local team = getTeam(teamKey)
  if not team then
    if not g.useDefault then
      local msg = "队伍[" .. teamKey .. "]缺失"
      PrintMessage(_clError(msg))
      WriteLogToFile(msg)
    end
    return false
  end

  if utils:getCurrentTeamId() == teamKey and isForce then
    return true
  end

  if CFG.debug then
    print("尝试加载队伍"..team.name)
  end
 
  current.levelUp = self:FillTeamData(team)

  local tcfg = getTeamConfig(teamKey)

  g.isPetsReplaced = {false, false, false}
  current.healthCheck = tcfg.healthCheck

  for m = 1, 3 do
    repeat
      if not loadin[m][0] then
        --检查血量
        local pid = loadin[m][1]
        if not pid then
          return false
        end
        local petInfo = utils:getPetInfo(pid)
        speciesIDCur = petInfo.speciesID
        customNameCur = petInfo.customName
        levelCur = petInfo.level
        healthCur = petInfo.health
        maxHealthCur= petInfo.maxHealth
        attackCur= petInfo.power
        speedCur= petInfo.speed
        -- healthCur, maxHealthCur, attackCur, speedCur = C_PetJournal.GetPetStats(pid)
        if not speciesIDCur then --宠物丢失的情况
          speciesIDCur = team[m][5]
          levelCur = 0
          customNameCur = ""
          healthCur = 0
          maxHealthCur = 1
          attackCur = 0
          speedCur = 0
        end
        if not speciesIDCur then
          return false
        end
        percentCur = math.floor((healthCur * 100) / maxHealthCur)
        percentMinCur = (tcfg.healthCheck[m] or 100)

        if CFG.debug then
          print(m .. "号宠血量:" .. percentCur .. "%,检测血线:" .. percentMinCur .. "%")
        end
        local isPercentMatch = false;
        if percentCur >= percentMinCur then     
          isPercentMatch = true;     
        end

        local success = false

        if isPercentMatch then
          success = true
          if tcfg.noAlt[m] then
            break;
          end
          if not tcfg.lowest[m] and not tcfg.highest[m] then
            break;
          end

          --血量符合要求，看看是否加载最低血量
          if tcfg.lowest[m] then
            g.isPetsReplaced[m] = self:LoadLowest(tcfg, pid, m)
          else
            --血量符合要求，看看是否加载最高血量
            local checkHigest = tcfg.highest[m];
            if percentCur>99 and (not tcfg.ignoreBreed[m] or tcfg.useGroup[m]) then
              checkHigest  = false
            end
            if checkHigest then
              g.isPetsReplaced[m] = self:LoadHighest(tcfg, pid, m)
            end
          end
          break --总是认为成功的
        end  
 
        --不满血，先尝试同组替补
        if not tcfg.noAlt[m] and tcfg.useGroup[m] then
          success, g.isPetsReplaced[m] = self:LoadFromGroup(tcfg, m)
        end
        if success then
          --同组替补成功
          break
        end
        if not tcfg.noAlt[m] then
          --尝试加载替补
          success, g.isPetsReplaced[m] = self:LoadSame(tcfg, m)
        end

        if not success then
          if (isResurable and CFG.forceLoadWhenHealOk) or isForce then
            --如果复活可用或强制加载，只要等级有效就认为可用
            if levelCur > 0 then
              printer.count = 0
              break
            end
          end
          --都失败了，退出
          return false
        end
      end
    until true
  end

  current.key = teamKey
  current.name = team.name or teamKey
  current.pets = loadin
  current.tcfg = tcfg
  self:LoadTeam()

  return true
end

function AutoTeam:ActiveTeam()
  local pets = current.pets
  local loadout = {}
  wipe(loadout)
  local done = {{}, {}, {}}

  for slot = 1, 3 do
    if pets[slot][1] and pets[slot][1] ~= 0 then
      loadout[1], loadout[2], loadout[3], loadout[4] = C_PetJournal.GetPetLoadOutInfo(slot)
      if pets[slot][1] ~= loadout[1] then
        utils:SlotPet(slot, pets[slot][1])
      end
      for i = 1, 3 do
        local abilityID = pets[slot][i + 1]
        if abilityID and loadout[i + 1] ~= abilityID then
          C_PetJournal.SetAbility(slot, i, abilityID)
        end
      end
    end
  end
  for slot = 1, 3 do
    if pets[slot][1] and pets[slot][1] ~= 0 then
      loadout[1], loadout[2], loadout[3], loadout[4] = C_PetJournal.GetPetLoadOutInfo(slot)
 
      for i = 1, 4 do
        if pets[slot][i] == loadout[i] or not pets[slot][i] then
          --loadin[slot][i] = nil
          done[slot][i] = true
        end
      end
    else
      for i = 1, 4 do
        --loadin[slot][i] = nil
        done[slot][i] = true
      end
    end
  end
  for i = 1, 3 do
    for j = 1, 4 do
      if not done[i][j] then
        return false
      end
    end
  end
  utils:setCurrentTeamId(current.key)
  return true
end

function AutoTeam:AssertHealthiestPet()
  if CFG.debug then
    print("尝试按参数更新当前队伍")
  end
  self:PreLoadTeam(utils:getCurrentTeamId(), false)
end
 
function AutoTeam:SelectTeam()
  hasValidTeam = true
  lastTeamLoad = time()
  if not self:GetNpcData() then
    return
  end
  g.npcWithTeam = g.npcName
  g.npcIdWithTeam = g.npcId 
  g.isLoading = true

  g.isDefault = false
  local teamArray = self:findTeamsFromRematch(g.npcId, g.npcName)
  if (not teamArray) and CFG.defaultTeam and #CFG.defaultTeam>=1 and CFG.defaultTeam[1] ~="" then
    if CFG.debug then
      print("未找预设队伍，使用默认队伍["..CFG.defaultTeam[1].."]")
    end
    teamArray = {utils:getTeamByName(CFG.defaultTeam[1])}
    g.isDefault = true
  end

  local teamCount = 0
  if teamArray then
    for i = 1, #teamArray do
      if not isTeamDisabled(teamArray[i]) then
        teamCount = teamCount + 1
      end
    end
  end

  if teamCount == 0 then
    if not g.isDefault then
      PrintMessage(_clError("未找到队伍"))
      WriteLogToFile("未找到队伍")
      self:AssertHealthiestPet()
    end
    g.isDefault = false
    g.isLoading = false
    return
  end

  if CFG.debug then
    self:PrintTeams(teamArray)
  end

  for i = 1, #teamArray do
    if not isTeamDisabled(teamArray[i]) then
      if self:PreLoadTeam(teamArray[i], false) then
        return
      end
    end
  end

  if not C_Scenario.IsInScenario() then
    --强制加载第一队
    for i = 1, #teamArray do
      if not isTeamDisabled(teamArray[i]) then
        if self:PreLoadTeam(teamArray[i], true) then
          break
        end
      end
    end
    hasValidTeam = false
    local msg = "所有队伍已失效"
    PrintMessage(_clError(msg))
    WriteLogToFile(msg)
  end

  g.isLoading = false
end

function AutoTeam:SelectTeamWhenTarget()
  if g.waiting then
    if CFG.debug then
      print("数据未更新，暂时跳过目标加载")
    end
    return 
  end
  isResurable = isResurCooldown()
  local hasData = self:GetNpcData()
  if not resurPrinted and hasData and isResurable then
    PrintMessage(_clSign("复活可用"))
    WriteLogToFile("复活可用")
    resurPrinted = true
  end
  if not isALPTEnable() then
    if not hasData then
      return
    end
    current.key = utils:getCurrentTeamId()
    current.name = utils:getCurrentTeamName()
    current.tcfg = nil
    current.pets = nil
    self:PrintCurrentTeam()
    return
  end
  g.isAuto = false

  local currentTime = time()
  local canLoad = (currentTime - lastTeamLoad>3)
  local changed = not (utils:getCurrentTeamId() == current.key)
  if not canLoad and not changed and (g.isSkip or g.isLoading) then
    if not g.isLoading and current.pets[1][1] then
      if CFG.debug then
        print("尝试激活队伍")
      end
      AutoTeam:ActiveTeam() --再设置次保证成功
    end
    return
  end

  if C_PetJournal.IsJournalUnlocked() and CFG.selectWhenTarget then
    if CFG.debug and changed then
      print("目标变化")
    end
    AutoTeam:SelectTeam()
  end
end

function AutoTeam:SelectTeamAfterBattle()

  isResurable = isResurCooldown()
  if not resurPrinted and isResurable then
    PrintMessage(_clSign("复活可用"))
    WriteLogToFile("复活可用")
    resurPrinted = true
  end
  if not isALPTEnable() then
    return
  end
  g.isAuto = true

  if g.isSkip or g.isLoading then
    return
  end

  if C_Scenario.IsInScenario() then
    return
  end

  if not CFG.selectAfterBattle then
    return
  end

  local changed = (utils:getCurrentTeamId() ~= current.key)
  if not changed then
    local health = AutoTeam:getTeamHealth()
    for slot = 1, 3 do
      if health[slot] ~= current.health[slot] then
        changed = true
        break
      end
    end
  end
 
  if (not changed) and g.delayCount >= 50 then
    --等久了直接强制加载
    g.delayCount = 0
    C_Timer.After(
        0.01,
        function()
          AutoTeam:SelectTeam()
        end
      )
      return;
  end
  if CFG.debug and not changed then
    print("尝试战斗后选择队伍但属性无变化，等待一次"..( g.delayCount+1))
  end

  if changed then
    if CFG.debug then
      print("状态发生变化，尝试选择队伍")
    end
    AutoTeam:SelectTeam()
  else
    g.delayCount = g.delayCount + 1
    if g.delayCount >= 100 then
      print("尝试次数过多，停止")
      g.delayCount = 0
      g.waiting = false
    else
      C_Timer.After(
        0.01,
        function()
          AutoTeam:SelectTeamAfterBattle()
        end
      )
    end    
  end
end
function AutoTeam:LogTeamTime(avg1, avg2)
  if current.tcfg then
    current.tcfg.avg1 = avg1
    current.tcfg.avg2 = avg2
  end
end
function ALPTRematch:GetCurrentTeamAvg()
  if current.tcfg then
    return current.tcfg.avg1
  end
  return nil
end

 
function AutoTeam:PLAYER_TARGET_CHANGED()
  if not CFG then
    return
  end
  if UnitExists("target") then
    local name = UnitName("target")
    if g.npcName ~= name then
      --只有目标变化时才触发加载
      g.isSkip = false
    end
    if
      not UnitIsPlayer("target") and not UnitIsEnemy("player", "target") and
        not (InCombatLockdown() or C_PetBattles.IsInBattle() or C_PetBattles.GetPVPMatchmakingInfo())
     then
      local unit_type, npcid = utils:GetTargetNPC()
      if unit_type == "Creature" or unit_type == "BattlePet" then
        g.npcName = name
        g.npcId = tonumber(npcid)
        local npcStr = g.npcId .. ""
        if CFG.debug then
          print("目标[ " .. npcStr .. " ][ " .. g.npcName .. " ]")
        end
        AutoTeam:SelectTeamWhenTarget()
      end
    end
  end
end

function AutoTeam:getTeamHealth()
  local health = {0, 0, 0}
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      health[slot] = C_PetJournal.GetPetStats(petId)
    else
      health[slot] = 0
    end
  end
  return health
end

function AutoTeam:PrintCurrentTeam()
  if not CFG.showTeamMessage then
    return
  end

  local msg = ""
  local logtext = ""
  if CFG.showTeamCount[1] and isALPTEnable() then
    if printer.count == 0 then
      printer.count = 1
    end
    msg = msg .. "[" .. printer.count .. "]"
  end
  if CFG.showTeamCount[2] and isALPTEnable() then
    msg = msg .. "[" .. printer.countall .. "]"
  end
  if CFG.showTeamCount[3] and isALPTEnable() then
    msg = msg .. "[" .. (printer.countTeam[current.key] or 0) .. "]"
  end
  logtext = msg
  msg = msg .. "已加载" .. ACHIEVEMENT_COLOR_CODE .. "[ " .. current.name .. " ]:" .. FONT_COLOR_CODE_CLOSE
  logtext = logtext .. "已加载" .. "[ " .. current.name .. " ]:"
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      local speciesID, customName, level, _, _, _, _, petName = C_PetJournal.GetPetInfoByPetID(petId)
      local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petId)
      local percent = math.floor((health * 100) / maxHealth)

      local breadStr = utils:CalcBread(speciesID,rarity,level,maxHealth,attack,speed)
      if level < 25 then
        msg =
          msg ..
          C_PetJournal.GetBattlePetLink(petId) ..
            BATTLENET_FONT_COLOR_CODE .. "[" .. breadStr .. "]" .. FONT_COLOR_CODE_CLOSE .. _clSign(level)
        logtext = logtext .. "[" .. petName .. "]" .. breadStr .. level
      else
        msg = msg .. C_PetJournal.GetBattlePetLink(petId) .. breadStr
        logtext = logtext .. "[" .. petName .. "]" .. breadStr
        if g.isPetsReplaced[slot] then
          msg = msg .. _clSign("↑")
          logtext = logtext .. "↑"
        end
        if percent < 100 then
          msg = msg .. RED_FONT_COLOR_CODE .. percent .. "%" .. FONT_COLOR_CODE_CLOSE
          logtext = logtext .. percent .. "%"
        end
      end
    end
  end
  PrintMessage(msg)
  WriteLogToFile(logtext)
  printer.isDelay = false
end

function AutoTeam:PrintTimer(msg)
  PrintMessage(_clLight(msg))
  WriteLogToFile(msg)
  printer.isPrinted = true
  if printer.isDelay then
    self:PrintCurrentTeam()
  end
end

local timeStart
function AutoTeam:PET_BATTLE_OPENING_START()
  g.isSkip = false
  current.health = AutoTeam:getTeamHealth()
  timeStart = time()
  printer.isPrinted = false
  printer.isDelay = false
  resurPrinted = false
  isResurable = false
  if BattleLog and not BattleLog.starttime then
    BattleLog.starttime = date("%Y-%m-%d %H:%M:%S")
  end
end
function AutoTeam:PET_BATTLE_CLOSE()
  if not C_PetBattles.IsInBattle() then
    if CFG.debug then
      print("战斗结束")
    end
    g.waiting = true
    C_Timer.After(
        0.5,
        function()
          g.waiting = false
        end
      )
    if CFG.loadAfterBattle >= 0 then
      C_Timer.After(
        CFG.loadAfterBattle,
        function()
          g.delayCount = 0
          if time() - timeStart < 12 then
            printer.isIgnored = true
          else
            printer.isIgnored = false
          end
          AutoTeam:SelectTeamAfterBattle()
        end
      )
    end
  end
end

function AutoTeam:UpdateAlternates()
  if not CFG.alternates or CFG.alternates == "" then
    Alternates = nil
    return
  end
  for petID in utils:AllOwnedPets() do
    local speciesID, _, _, _, _, _, _, speciesName, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByPetID(petID)
    if canBattle and speciesName == CFG.alternates then
      Alternates = petID
      return
    end
  end
  Alternates = nil
end

--缓存宠物数据
function AutoTeam:updatePetListCache()

  if CFG.debug then
    print("updatePetListCache")
  end

  if not utils.inited then
    g.isCaching = false
    g.waiting = false
    return 
  end


  if not isInited then
    --从rematch导入数据
    local npcs = utils:AllTargets()
    for npcId in npcs
    do
      if not AutoTeamData[npcId] then
        AutoTeamData[npcId] = {}
      end
    end
    BattleLog = {logs = {}, starttime = nil, endtime = date("%Y-%m-%d %H:%M:%S")}
    isInited = true
  end

  local petlist = {}
  local alternates = nil
  local idTable
  local petGroupFix = {}

  local highestHPPet = nil
  local highestHP = 0
 
  for petID in utils:AllOwnedPets() do
    local speciesID, customName, level, _, _, _, _, speciesName, _, _, _, _, _, _, canBattle =
      C_PetJournal.GetPetInfoByPetID(petID)
    if speciesID and canBattle then
      local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(petID)
      if not petlist[speciesID] then
        petlist[speciesID] = {}
      end
      local petInfo = {}
      petInfo.petID = petID
      petInfo.health = health
      petInfo.level = level
      petInfo.attack = attack
      petInfo.speed = speed
      petInfo.percent = math.floor((health * 100) / maxHealth)
      petInfo.speciesName = speciesName
      tinsert(petlist[speciesID], petInfo)

      if maxHealth>highestHP then
        highestHP = maxHealth
        highestHPPet = petID
      end

      if maxHealth > 0 and speciesName == utils.alptconfig.alternates then
        alternates = petID
      end
    end
  end

  if CFG.petGroups then
    for m = 1, #CFG.GroupIndexs do
      local groupName = CFG.GroupIndexs[m]
      local petGroup = CFG.petGroups[groupName]
      local indexs = CFG.GroupPetIndexs[groupName]
      for n = 1, #indexs do
        local speciesID = indexs[n]
        local skills = petGroup[speciesID]
        if not petGroupFix[groupName] then
          petGroupFix[groupName] = {}
        end
        idTable = C_PetJournal.GetPetAbilityList(speciesID)
        local pets = petlist[speciesID]
        if pets then
          for n = 1, #pets do
            local petInfo = pets[n]
            if not petInfo.abilityID then
              petInfo.abilityID = {}
            end
            if not petInfo.abilityID[groupName] then
              petInfo.abilityID[groupName] = {}
            end
            for yy = 1, 3 do
              local idxy
              if skills[yy] == 1 then
                idxy = yy
              else
                idxy = yy + 3
              end
              petInfo.abilityID[groupName][yy] = idTable[idxy]
            end
            tinsert(petGroupFix[groupName], petInfo)
          end
        end
      end
    end
  end
  --petGroupFix
  
  if not alternates then
    alternates = highestHPPet
  end

  PetGroup = petGroupFix
  Alternates = alternates
  PetListCache = petlist
  g.isCaching = false
  g.waiting = false
end

function AutoTeam:updatePetGroup()
  AutoTeam:updatePetListCache()
end

local function OnEvent(self, event, ...)
  if event == "PLAYER_TARGET_CHANGED" then
    AutoTeam:PLAYER_TARGET_CHANGED()
  elseif event == "PET_BATTLE_OPENING_START" then
    AutoTeam:PET_BATTLE_OPENING_START()
  elseif event == "PET_BATTLE_OPENING_DONE" then
    if C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) < 3 then
      PrintMessage(_clError("队伍不完整"))
      WriteLogToFile("队伍不完整")
    end
  elseif event == "PET_BATTLE_CLOSE" then
    AutoTeam:PET_BATTLE_CLOSE()
  elseif event == "PET_JOURNAL_LIST_UPDATE" then
    if not g.isCaching and CFG then
      g.isCaching = true
      C_Timer.After(
        0.03,
        function()
          AutoTeam:updatePetListCache()
        end
      )
    end
  elseif event == "ADDON_LOADED" then
  end
end
 


function AutoTeam:getCurrentTarget()
  return g.npcName
end

function AutoTeam:GetLastNpcData()
  return g.npcName, g.npcWithTeam, g.npcIdWithTeam
end

function AutoTeam:GetCurrentKey()
  return current.key
end

function AutoTeam:GetCurrentNpcId()
  return g.npcId
end

function AutoTeam:HasValidTeam()
  return hasValidTeam
end

function AutoTeam:IsTeamAvailable()
  if g.isLoading then
    return false
  end
  local healthCheck = current.healthCheck or defaultHealthCheck
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      local health, maxHealth, _, _ = C_PetJournal.GetPetStats(petId)
      local percent = math.floor((health * 100) / maxHealth)
      local percentMin = healthCheck[slot] or 100
      if percent < percentMin then
        if CFG.debug then
          print(_clError("队伍还未生效"))
        end
        return false
      end
    end
  end
  return true
end

function AutoTeam:InitCore()
  CFG = utils.alptconfig
  AutoTeam:updatePetGroup()
end

function ALPTRematchEnable()
  enableTeamLoad = not enableTeamLoad
  if enableTeamLoad then
    print(_clSign("已取消临时关闭自动换队"))
  else
    print(_clError("已临时关闭自动换队"))
  end
end

function ALPTRematchDebug()
  CFG.debug = not CFG.debug
  if CFG.debug then
    print(_clSign("启用Debug输出"))
  else
    print(_clSign("禁用Debug输出"))
  end
end

function ALPTRematchSwitchMode()
  CFG.mode = CFG.mode + 1
  if CFG.mode > 3 then
    CFG.mode = 1
  end
  print("换队模式：" .. _clInfo(CFG.modeName[CFG.mode]))
  g.isSkip = false
end

SLASH_ALPTREMATCH1 = "/alpt"
SlashCmdList["ALPTREMATCH"] = function(cmd, editbox)
  if cmd == "switch" then
    ALPTRematchSwitchMode()
  elseif cmd == "enable" then
    ALPTRematchEnable()
  elseif cmd == "debug" then
    ALPTRematchDebug()
  elseif cmd == "option" then
    ALPTRematch:OpenOptions()
  end
end

local frame = CreateFrame("FRAME", nil, UIParent)
frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PET_BATTLE_OPENING_START")
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:RegisterEvent("PET_BATTLE_CLOSE")
frame:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
