local mod	= DBM:NewMod(725, "DBM-Pandaria", nil, 322, 1) -- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240412041201")
mod:SetCreatureID(62346)
mod:SetEncounterID(1563)
mod:SetReCombatTime(20, 10)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"RAID_BOSS_EMOTE"
)

local warnCannonBarrage		= mod:NewSpellAnnounce(121600, 3)

local specWarnStomp			= mod:NewSpecialWarningSpell(121787, nil, nil, nil, 2, 2)
local specWarnWarmonger		= mod:NewSpecialWarningSwitch(-6200, "-Healer", nil, nil, 1, 2)

local timerCannonBarrageCD	= mod:NewNextTimer(60, 121600, nil, "Tank", 2, 5)
local timerStompCD			= mod:NewNextTimer(60, 121787, nil, nil, nil, 2)
local timerStomp			= mod:NewCastTimer(3, 121787, nil, nil, nil, 5)
local timerWarmongerCD		= mod:NewNextTimer(10, -6200, nil, nil, nil, 1, 121747)--Comes after Stomp. (Also every 60 sec.)

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddReadyCheckOption(32098, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerCannonBarrageCD:Start(24-delay)
		timerStompCD:Start(50-delay)
		berserkTimer:Start(-delay)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:121600") then
		warnCannonBarrage:Show()
		timerCannonBarrageCD:Start()
	elseif msg:find("spell:121787") then
		specWarnStomp:Show()
		specWarnStomp:Play("stunsoon")
		specWarnWarmonger:Schedule(10)
		specWarnWarmonger:ScheduleVoice(10, "killmob")
		timerStomp:Start()
		timerWarmongerCD:Start()
		timerStompCD:Start()
	end
end
