local mod	= DBM:NewMod(574, "DBM-Party-BC", 6, 261)
local L		= mod:GetLocalizedStrings()

if mod:IsRetail() then
	mod.statTypes = "normal,heroic,duos"
end

mod:SetRevision("20250609053724")
mod:SetCreatureID(17796)
mod:SetEncounterID(1943)
mod:SetZone(261, 2849)--Steamvault, Duos

if not mod:IsRetail() then
	mod:SetModelID(18638)
	mod:SetModelOffset(-10, 0, 1)
end

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 35107",
	"SPELL_AURA_REMOVED 35107",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnNet			= mod:NewTargetAnnounce(35107, 2)

local specWarnSummon	= mod:NewSpecialWarning("warnSummon", "-Healer", nil, nil, 1, 2)--(-5999)

local timerNet			= mod:NewTargetTimer(6, 35107, nil, nil, nil, 3)

local enrageTimer		= mod:NewBerserkTimer(300)

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
        enrageTimer:Start(-delay)
    end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35107 then
		WarnNet:Show(args.destName)
		timerNet:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 35107 then
		timerNet:Stop(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Mechs then		-- Adds
		specWarnSummon:Show()
		specWarnSummon:Play("killmob")
	end
end
