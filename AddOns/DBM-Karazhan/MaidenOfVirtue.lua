local mod	= DBM:NewMod("Maiden", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200918015608")
mod:SetCreatureID(16457)
mod:SetEncounterID(654)
mod:SetModelID(16198)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 29511",
	"SPELL_AURA_APPLIED 29522",
	"SPELL_AURA_REMOVED 29522"
)

local warningRepentance		= mod:NewSpellAnnounce(29511, 4)
local warningHolyFire		= mod:NewTargetNoFilterAnnounce(29522, 2)

--local specWarnHolyFire		= mod:NewSpecialWarningMoveAway(29522, nil, nil, nil, 1, 2)

local timerRepentance		= mod:NewBuffActiveTimer(12.6, 29511, nil, nil, nil, 2)
local timerRepentanceCD		= mod:NewCDTimer(30.3, 29511, nil, nil, nil, 6)--30.3-49
local timerHolyFire			= mod:NewTargetTimer(12, 29522, nil, nil, nil, 5, nil, DBM_CORE_L.MAGIC_ICON)

mod:AddRangeFrameOption(10, 29522)

function mod:OnCombatStart(delay)
	timerRepentanceCD:Start(28-delay)--28-35
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 29511 then
		warningRepentance:Show()
		timerRepentance:Start()
		timerRepentanceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29522 then
		warningHolyFire:Show(args.destName)
		timerHolyFire:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29522 then
		timerHolyFire:Stop(args.destName)
	end
end
