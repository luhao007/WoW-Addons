local function GetItemName(itemID)
  local itemName = GetItemInfo(itemID)
  return itemName
end
local utils = ALPTRematch.utils
local buttonQuitGame
local buttonHeal
local macroButtons = {}
local buttonInited = false
local config
local lastCheckTime = 0
local lastBundTime = 0
local function CreateHelpButtons()
  buttonHeal = CreateFrame("Button", "ALPTButtonHeal", UIParent, "SecureActionButtonTemplate")
  buttonHeal:SetAttribute("type", "spell")
  buttonHeal:SetAttribute("spell", "125439")
  buttonHeal:Hide()

  buttonQuitGame = CreateFrame("Button", "ALPTQuitGame", UIParent, "SecureActionButtonTemplate")
  buttonQuitGame:SetAttribute("macrotext", "")
  buttonQuitGame:SetAttribute("type", "macro")
  buttonQuitGame:Hide()
  buttonQuitGame:SetScript(
    "PreClick",
    function(btn, button)
      if UnitLevel("player")==60 then
        btn:SetAttribute("macrotext", "/quit")
      else
        btn:SetAttribute("macrotext", "")
      end
    end
  )
 
end
local function DebugPrint(msg)
  if config and config.debug then
    print(msg)
  end
end

local function IsNpcIndex(npcName,key)
  local npcs = utils.alptconfig.gossipOptions[key]
  if not npcs then
    return false
  end
  return string.find(npcs..",",npcName..",")
end

local function GetNpcIndex(npcName)
  if not utils.alptconfig or not utils.alptconfig.gossipOptions then
    return 1
  end
  if IsNpcIndex(npcName,"2") then
    return 2
  end
  if IsNpcIndex(npcName,"3") then
    return 3
  end
  if IsNpcIndex(npcName,"4") then
    return 4
  end
  return 1
end

local function createMacroText(btn)
  local macro = ""
  repeat
    config = btn.config
    if not C_PetJournal.IsJournalUnlocked() then
      DebugPrint("宠物面板未解锁")
      break
    end
    if config.autointeract and not C_PetBattles.IsInBattle() then
      local org = GetCVar("autointeract")
      if org ~= "1" then
        DebugPrint("开启点击移动")
        ConsoleExec("autointeract 1")
      end
    end
    if InCombatLockdown() then
      DebugPrint("战斗锁定")
      return
    end

    if C_PetBattles.IsInBattle() then
      if config.useTdScript then
        DebugPrint("执行TD脚本")
        macro = macro .. "\n/click tdBattlePetScriptAutoButton"
      end
      break
    end

    --法夜竖琴
    local _,cd = C_Item.GetItemCooldown(184489)
    if config.userHarp and cd==0 then
      DebugPrint("使用法夜竖琴")
      macro = macro .. "\n/use item:184489"
    end
 
    --自定义buff
    if config.checkItemId and config.checkItemId ~= "" and config.customScript and config.customScript ~= "" then
      local itemName = C_Item.GetItemSpell(config.checkItemId)
      if itemName and not utils:GetItemBuff(config.checkItemId) then
        if config.customScript == "use" then
          DebugPrint("使用物品BUFF" .. buff)
          macro = macro .. "\n/use item:" .. config.checkItemId
        else
          DebugPrint("执行脚本" .. config.customScript)
          macro = macro .. config.customScript
        end
        break
      end
    end

    --复活
    local cooldown= C_Spell.GetSpellCooldown(125439)
    if config.healPet and cooldown.duration == 0 then
      DebugPrint("复活战斗宠物")
      macro = macro .. "\n/click ALPTButtonHeal"
    else
      --绷带
      if config.useBandage and not ALPTRematch:HasValidTeam() and cooldown.duration > 5 and C_Item.GetItemCount(86143) > 0 then
        if not ALPTRematch:IsTeamAvailable() then
          --防止延时误使用，等待1秒
          local timenow = time()
          if lastBundTime == 0 then
            lastBundTime = timenow
          end
          if timenow - lastBundTime >= 1 then
            print(GREEN_FONT_COLOR_CODE .. "使用绷带" .. FONT_COLOR_CODE_CLOSE)
            macro = macro .. "\n/use item:86143"
            lastBundTime = 0
            break
          end
        end
      end
    end
 
    local npcName, npcWithTeam, npcIdWithTeam = ALPTRematch:GetLastNpcData()
    local hasNpc = npcWithTeam and npcWithTeam ~= ""
    if hasNpc and config.target then
      if UnitExists("target") then
        local unit_type, npcid = utils:GetTargetNPC()
        if npcid and npcid ~= npcIdWithTeam then
          DebugPrint("目标错误，清除目标")
          macro = macro .. "\n/cleartarget "
        end
      else
        if npcWithTeam then
          DebugPrint("尝试选中" .. npcWithTeam)
          macro = macro .. "\n/targetexact " .. npcWithTeam
        end
      end
    end

    if config.autoConfirm then
      if StaticPopup1Button1 and StaticPopup1Button1:IsVisible() then
        DebugPrint("点击确定")
        macro = macro .. "\n/click StaticPopup1Button1"
      end
    end

    local isTeamOk = true
    if hasNpc and config.waitTeam then
      isTeamOk = ALPTRematch:IsTeamAvailable()
      if config.waitTimeout == nil then
        config.waitTimeout = 0
      end
      if not isTeamOk and config.waitTimeout > 0 then
        local time = time()
        if lastCheckTime == 0 then
          lastCheckTime = time
        end
        if lastCheckTime > 0 and (time - lastCheckTime) > config.waitTimeout then
          DebugPrint("队伍未生效，尝试重新激活")
          ALPTRematch:ActiveTeam()
          lastCheckTime = time
        end
      end
    end

    if config.selectGossip and isTeamOk and UnitExists("target") and GossipFrame and GossipFrame:IsVisible() then
      DebugPrint("执行对话")
      local npcIndex = GetNpcIndex(npcName)
      macro = macro .. "\n/script SelectGossipOption("..npcIndex..")"
    end
    if config.extraScript and config.extraScriptCmd and config.extraScriptCmd ~= nil then
      DebugPrint("执行额外命令" .. config.extraScriptCmd)
      macro = macro .. "\n" .. config.extraScriptCmd
    end
  until true
  if macro ~= "" then
    macro = "/stopmacro [combat] " .. macro
  end
  btn:SetAttribute("macrotext", macro)
  DebugPrint("设置后的宏文本：" .. btn:GetAttribute("macrotext"))
end

function ALPTRematch:UpdateMacroButton()
  for key, cf in pairs(utils.alptconfig.macros) do
    ClearOverrideBindings(macroButtons[key])
    if cf.keybinding then
      SetOverrideBindingClick(macroButtons[key], true, cf.keybinding, macroButtons[key]:GetName())
    end
  end
end


local function CreateMacroButtons()
  for key, cf in pairs(utils.alptconfig.macros) do
    repeat
      local macroButton = CreateFrame("Button", key, UIParent, "SecureActionButtonTemplate")
      macroButton:SetAttribute("macrotext", "")
      macroButton:SetAttribute("type", "macro")
      macroButton:Hide()
      macroButton.config = cf
      macroButton:SetScript("PreClick", createMacroText)
 
      macroButtons[key] = macroButton
      if cf.keybinding then
        SetOverrideBindingClick(macroButton, true, cf.keybinding, macroButton:GetName())
      end
    until true
  end
end

function ALPTRematch:InitMacroButton()
  if buttonInited then
    return
  end
  CreateHelpButtons()
  CreateMacroButtons()
  buttonInited = true
end