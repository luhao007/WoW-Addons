local ALPTRematch = LibStub("AceAddon-3.0"):NewAddon("ALPTRematch")
_G.ALPTRematch = ALPTRematch
_G.LE_BATTLE_PET_ALLY = 1
_G.LE_BATTLE_PET_ENEMY = 2
local rematch = Rematch

ALPTRematch.utils = {}

function ALPTRematch.utils:getTeamByKey(teamKey)
    return Rematch.savedTeams[teamKey]
end

function ALPTRematch.utils:getTeamNameByKey(teamKey)
    return rematch.savedTeams[teamKey].name
end
function ALPTRematch.utils:AllTeams()
    return rematch.savedTeams:AllTeams()
end



function ALPTRematch.utils:getTeamByName(teamName)
    return rematch.savedTeams:GetTeamIDByName(teamName)
  end

function ALPTRematch.utils:GetBuffIndex(spellID)
    return rematch.utils:GetBuffIndex(spellID)
end

function ALPTRematch.utils:GetItemBuff(safari)
    return rematch.utils:GetItemBuff(safari)
end

function ALPTRematch.utils:GetPetSpecInfo(petID)
    local speciesID, _, _, _, _, _, _, speciesName, _, _, _, _, _, _, canBattle =
        C_PetJournal.GetPetInfoByPetID(petID)
    return speciesID, speciesName, canBattle
end

function ALPTRematch.utils:AllOwnedPets()
    return rematch.roster:AllOwnedPets()
end

function ALPTRematch.utils:GetTargetTeams(npcId)
    return rematch.savedTargets[npcId]
end

function ALPTRematch.utils:getPetInfo(petID)
    return rematch.petInfo:Fetch(petID)
end

function ALPTRematch.utils:GetAbilities(team,i)
    return rematch.petTags:GetAbilities(team.tags[i])
end

function ALPTRematch.utils:getQueuePet(pickIndex)
    return rematch.queue:GetTopPick(pickIndex)
end
function ALPTRematch.utils:updateQueue(teamID)
    return rematch.queue:Update(teamID)
end


function ALPTRematch.utils:getQueuePetCanLevel(levelUpPet)
    return rematch.queue:PetIDCanLevel(levelUpPet)
end

function ALPTRematch.utils:ShowRematchDone()
    rematch.settings.InteractShowAfterLoad = true
    rematch.events:Fire("REMATCH_TEAM_LOADED",Rematch5Settings.currentTeamID)
    rematch.settings.InteractShowAfterLoad = false
end

function ALPTRematch.utils:SetConfig(config)
    local settings = Rematch5Settings
    settings.alptconfig = config
    ALPTRematch.utils.alptconfig = config
    return rematch.roster:AllOwnedPets()
end


function ALPTRematch.utils:SlotPet(slot,pet)
    rematch.loadouts:SetSlotPetID(slot, pet)
    rematch.loadouts:SlotPet(slot, pet)
end

function ALPTRematch.utils:GetTargetNPC()
    local GUID = UnitGUID("target")
    if not GUID then
      return nil, nil
    end
    local unit_type, npcID = GUID:match("(%a+)-%d+-%d+-%d+-%d+-(%d+)-.+")
    npcID = tonumber(npcID)
    if rematch.targetData.redirects[npcID] then  
        npcID =  rematch.targetData.redirects[npcID] 
    end
    return unit_type, npcID
  end

function ALPTRematch.utils:getCurrentTeamId()
    return rematch.settings.currentTeamID
end
function ALPTRematch.utils:setCurrentTeamId(teamId)
    rematch.settings.currentTeamID = teamId
end
function ALPTRematch.utils:getCurrentTeamName()
    return rematch.savedTeams[rematch.settings.currentTeamID].name
end

function ALPTRematch.utils:AllTargets()
    return  rematch.targetInfo:AllTargets()
end


function ALPTRematch.utils:HasQueue()
    return #rematch.settings.LevelingQueue>0
end

function ALPTRematch.utils:AssertHealthiestPet(ignoreProp)
    rematch.settings.LoadHealthiest = true
    rematch.settings.LoadHealthiestAny = ignoreProp
    rematch.loadTeam:AssertHealthiestPet()
    rematch.settings.LoadHealthiest = false
    rematch.settings.LoadHealthiestAny = false
end

function ALPTRematch.utils:CanLevelUP()
    local level = UnitLevel("player")
    if level == 80 or IsXPUserDisabled() then
      return false
    else
      return true
    end
  end

function ALPTRematch.utils:CalcBread(speciesID,rarity,level,maxHealth,attack,speed)
    local breadStr = ""
    if BPBID_Internal then
        local breedNum =
          BPBID_Internal.CalculateBreedID(
          tonumber(speciesID),
          tonumber(rarity),
          tonumber(level),
          tonumber(maxHealth),
          tonumber(attack),
          tonumber(speed),
          false,
          false
        )
        local breed = BPBID_Internal.RetrieveBreedName(breedNum)
        if breed and breed ~= "NEW" then
          breadStr = breed
        end
    end
    return breadStr
end


local tryTimes = 10000
local function doInit()
    local settings = rematch.settings
    if not settings then
        tryTimes = tryTimes - 1
        if tryTimes > 0 then
            C_Timer.After(
                0.01,
                function()
                    doInit()
                end
            )
        end
        return
    end

    if not settings.alpt then
        settings.alpt = {}
    end
    ALPTRematch.utils.alpt = settings.alpt
    ALPTRematch.utils.alptconfig = settings.alptconfig or {}
    ALPTRematch.utils.inited = true
    ALPTRematch:InitOptions()
    ALPTRematch:InitCore()
    ALPTRematch:InitMacroButton()
    ALPTRematch:InitRemacthEx()
end

local function OnEvent(self, event, ...)
    if event == "PLAYER_LOGIN" then
        doInit()
    end
end

local frame = CreateFrame("FRAME", nil, UIParent)
frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("PLAYER_LOGIN")
