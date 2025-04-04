local mod	= DBM:NewMod("LordMarrowgar", "DBM-Raids-WoTLK", 2)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(36612)
mod:SetEncounterID(not mod:IsPostCata() and 845 or 1101)
mod:SetModelID(31119)
mod:SetUsedIcons(2, 3, 4, 5, 6, 7, 8)
mod:SetZone(631)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 69076",
	"SPELL_AURA_REMOVED 69065 69076",
	"SPELL_CAST_START 69057",
	"SPELL_SUMMON 69062 72669 72670"
)

local preWarnWhirlwind   	= mod:NewSoonAnnounce(69076, 3)
local warnBoneSpike			= mod:NewCastAnnounce(69057, 2)
local warnImpale			= mod:NewTargetNoFilterAnnounce(72669, 3)

local specWarnColdflame		= mod:NewSpecialWarningGTFO(69146, nil, nil, nil, 1, 8)
local specWarnWhirlwind		= mod:NewSpecialWarningRun(69076, nil, nil, nil, 4, 2)

local timerBoneSpike		= mod:NewCDTimer(18, 69057, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerWhirlwindCD		= mod:NewCDTimer(90, 69076, nil, nil, nil, 2)
local timerWhirlwind		= mod:NewBuffActiveTimer(20, 69076, nil, nil, nil, 6)
local timerBoned			= mod:NewAchievementTimer(8, 4610)

local berserkTimer			= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnImpale", 72669, true, 0, {8})

mod.vb.impaleIcon = 8

function mod:OnCombatStart(delay)
	preWarnWhirlwind:Schedule(40-delay)
	timerWhirlwindCD:Start(45-delay)
	timerBoneSpike:Start(15-delay)
	berserkTimer:Start(-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 69146",
			"SPELL_PERIODIC_MISSED 69146"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69076 then						-- Bone Storm (Whirlwind)
		if not self:IsTrivial() then
			specWarnWhirlwind:Show()
			specWarnWhirlwind:Play("justrun")
		end
		timerWhirlwindCD:Start()
		preWarnWhirlwind:Schedule(85)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerWhirlwind:Show(25)						-- Approx 30seconds on heroic
		else
			timerWhirlwind:Show()						-- Approx 20seconds on normal.
			timerBoneSpike:Cancel()						-- He doesn't do Bone Spike Graveyard during Bone Storm on normal
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69065 then						-- Impaled
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 69076 then
		if self:IsDifficulty("normal10", "normal25") then
			timerWhirlwind:Cancel()
			timerBoneSpike:Start(15)					-- He will do Bone Spike Graveyard 15 seconds after whirlwind ends on normal
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69057 then	-- Bone Spike Graveyard
		warnBoneSpike:Show()
		timerBoneSpike:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062, 72669, 72670) then			-- Impale
		if self:AntiSpam(5, 1) then
			self.vb.impaleIcon = 8
		end
		warnImpale:CombinedShow(0.3, args.sourceName)
		timerBoned:Start()
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.sourceName, self.vb.impaleIcon)
		end
		-- Don't use the Star icon, so tanks can use it for positioning. If you have 7 impales, you are likely wiping anyway.
		if self.vb.impaleIcon < 2 then
			self.vb.impaleIcon = 8
		end
		self.vb.impaleIcon = self.vb.impaleIcon - 1
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 69146 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 2) then
		specWarnColdflame:Show(spellName)
		specWarnColdflame:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
