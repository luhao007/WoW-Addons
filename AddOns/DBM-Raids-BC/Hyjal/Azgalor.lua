local mod	= DBM:NewMod("Azgalor", "DBM-Raids-BC", 3)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal25"

mod:SetRevision("20241103131702")
mod:SetCreatureID(17842)
mod:SetEncounterID(621, 2471)
mod:SetModelID(18526)
mod:SetUsedIcons(8)
mod:SetZone(534)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 31340 31347",
	"SPELL_AURA_REMOVED 31347",
	"SPELL_CAST_SUCCESS 31344"
)

local warnSilence		= mod:NewSpellAnnounce(31344, 3)
local warnDoom			= mod:NewTargetNoFilterAnnounce(31347, 4)

local specWarnFire		= mod:NewSpecialWarningMove(31340)
local specWarnDoom		= mod:NewSpecialWarningYou(31347)
local yellDoom			= mod:NewShortFadesYell(31347)

local timerDoom			= mod:NewTargetTimer(20, 31347, nil, nil, nil, 3)
local timerSilence		= mod:NewBuffFadesTimer(5, 31344, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerSilenceCD	= mod:NewCDTimer(16.7, 31344, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("DoomIcon", 31347, true, 0, {8})

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31340 and args:IsPlayer() and self:AntiSpam() then
		specWarnFire:Show()
		specWarnFire:Play("runaway")
	elseif args.spellId == 31347 then
		timerDoom:Start(args.destName)
		if args:IsPlayer() then
			specWarnDoom:Show()
			specWarnDoom:Play("targetyou")
			yellDoom:Countdown(args.spellId)
		else
			warnDoom:Show(args.destName)
		end
		if self.Options.DoomIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31347 then
		if args:IsPlayer() then
			yellDoom:Cancel()
		end
		if self.Options.DoomIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31344 then
		warnSilence:Show()
		timerSilence:Start()
		timerSilenceCD:Start()
	end
end
