local mod	= DBM:NewMod("Attumen", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190417010011")
mod:SetCreatureID(16151, 16152)--15550
mod:SetEncounterID(652)
mod:SetModelID(16416)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29711 29833",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnKnockdown	= mod:NewSpellAnnounce(29711, 4)
local warningCurse	= mod:NewSpellAnnounce(29833, 4)
local warnPhase2	= mod:NewPhaseAnnounce(2)

local timerCurseCD	= mod:NewCDTimer(27, 43127, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)

local Phase	= 1

function mod:OnCombatStart(delay)
	Phase = 1
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 29711 then
		warnKnockdown:Show()
	elseif args.spellId == 29833 then
		warningCurse:Show()
		if Phase == 2 then
			timerCurseCD:Start(41)
		else
			timerCurseCD:Start()
		end
	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_ATH_YELL_1 then
		Phase = 2
		warnPhase2:Show()
		timerCurseCD:Start(25)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16152 then
		DBM:EndCombat(self)
	end
end
