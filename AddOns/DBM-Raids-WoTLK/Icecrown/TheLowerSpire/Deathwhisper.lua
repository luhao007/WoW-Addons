local mod	= DBM:NewMod("Deathwhisper", "DBM-Raids-WoTLK", 2)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(36855)
mod:SetEncounterID(not mod:IsPostCata() and 846 or 1100)
mod:SetModelID(30893)
mod:SetUsedIcons(1, 2, 3, 7, 8)
mod:SetZone(631)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 71289 71001 71237 70674 71204",
	"SPELL_AURA_APPLIED_DOSE 71204",
	"SPELL_AURA_REMOVED 70842",
	"SPELL_CAST_START 71420 70900 70901 71236",
	"SPELL_SUMMON 71426",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO: Fix absorb infoframe if boss unit Ids don't exist or if not available on combat start
local warnAddsSoon					= mod:NewAnnounce("WarnAddsSoon", 2, 61131, nil, nil, nil, 61131, DBM_COMMON_L.ADDS)
local warnDominateMind				= mod:NewTargetNoFilterAnnounce(71289, 3)
local warnSummonSpirit				= mod:NewSpellAnnounce(71426, 2)
local warnReanimating				= mod:NewAnnounce("WarnReanimating", 3, 34018, nil, nil, nil, 34018, L.ReanimatedAdd)
local warnDarkTransformation		= mod:NewSpellAnnounce(70900, 4)
local warnDarkEmpowerment			= mod:NewSpellAnnounce(70901, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnTouchInsignificance		= mod:NewStackAnnounce(71204, 2, nil, "Tank|Healer")

local specWarnCurseTorpor			= mod:NewSpecialWarningYou(71237, nil, nil, nil, 1, 2)
local specWarnDeathDecay			= mod:NewSpecialWarningGTFO(71001, nil, nil, nil, 1, 8)
local specWarnTouchInsignificance	= mod:NewSpecialWarningStack(71204, nil, 3, nil, nil, 1, 6)
local specWarnVampricMight			= mod:NewSpecialWarningDispel(70674, "MagicDispeller", nil, nil, 1, 2)
local specWarnDarkMartyrdom			= mod:NewSpecialWarningRun(71236, "Melee", nil, nil, 4, 2)
local specWarnFrostbolt				= mod:NewSpecialWarningInterrupt(71420, "HasInterrupt", nil, 2, 1, 2)

local timerAdds						= mod:NewTimer(60, "TimerAdds", 61131, nil, nil, 1, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.DAMAGE_ICON, nil, nil, nil, nil, nil, nil, 61131, nil, DBM_COMMON_L.ADDS)
local timerDominateMind				= mod:NewBuffActiveTimer(12, 71289, nil, nil, nil, 5)
local timerDominateMindCD			= mod:NewCDTimer(40, 71289, nil, nil, nil, 3)
local timerSummonSpiritCD			= mod:NewCDTimer(10, 71426, nil, false, nil, 3)
local timerTouchInsignificance		= mod:NewTargetTimer(30, 71204, nil, "Tank|Healer", nil, 5)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnDominateMind", 71289, true, 0, {1, 2, 3})
mod:AddSetIconOption("SetIconOnDeformedFanatic", 70900, true, 5, {8})
mod:AddSetIconOption("SetIconOnEmpoweredAdherent", 70901, true, 5, {7})
if mod:IsRetail() then
	mod:AddInfoFrameOption(70842, true)
end

local dominateMindTargets = {}
mod.vb.dominateMindIcon = 1
local shieldName = DBM:GetSpellName(70842)

local function showDominateMindWarning(self)
	warnDominateMind:Show(table.concat(dominateMindTargets, "<, >"))
	timerDominateMind:Start()
	timerDominateMindCD:Start()
	table.wipe(dominateMindTargets)
	self.vb.dominateMindIcon = 1
end

local function addsTimer(self)
	timerAdds:Cancel()
	warnAddsSoon:Cancel()
	if self:IsDifficulty("heroic10", "heroic25") then
		warnAddsSoon:Schedule(40)	-- 5 secs prewarning
		self:Schedule(45, addsTimer, self)
		timerAdds:Start(45)
	else
		warnAddsSoon:Schedule(55)	-- 5 secs prewarning
		self:Schedule(60, addsTimer, self)
		timerAdds:Start()
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerAdds:Start(7)
	warnAddsSoon:Schedule(4)			-- 3sec pre-warning on start
	self:Schedule(7, addsTimer, self)
	if not self:IsDifficulty("normal10") then
		timerDominateMindCD:Start(30)		-- Sometimes 1 fails at the start, then the next will be applied 70 secs after start ?? :S
	end
	table.wipe(dominateMindTargets)
	self.vb.dominateMindIcon = 6
	if self.Options.InfoFrame and self:IsRetail() then
		DBM.InfoFrame:SetHeader(shieldName)
		DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs("boss1"))
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame and self:IsRetail() then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71289 then
		dominateMindTargets[#dominateMindTargets + 1] = args.destName
		if self.Options.SetIconOnDominateMind then
			self:SetIcon(args.destName, self.vb.dominateMindIcon, 12)
		end
		self.vb.dominateMindIcon = self.vb.dominateMindIcon + 1
		self:Unschedule(showDominateMindWarning)
		if self:IsDifficulty("heroic10", "normal25") or (self:IsDifficulty("heroic25") and #dominateMindTargets >= 3) then
			showDominateMindWarning(self)
		else
			self:Schedule(0.9, showDominateMindWarning, self)
		end
	elseif args.spellId == 71001 and not self:IsTrivial() then
		if args:IsPlayer() then
			specWarnDeathDecay:Show(args.spellName)
			specWarnDeathDecay:Play("watchfeet")
		end
	elseif args.spellId == 71237 and args:IsPlayer() and not self:IsTrivial() then
		specWarnCurseTorpor:Show()
		specWarnCurseTorpor:Play("targetyou")
	elseif args.spellId == 70674 and not args:IsDestTypePlayer() and UnitGUID("target") == args.destGUID then
		specWarnVampricMight:Show(args.destName)
		specWarnVampricMight:Play("helpdispel")
	elseif args.spellId == 71204 then
		timerTouchInsignificance:Start(args.destName)
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 3 then
			specWarnTouchInsignificance:Show(amount)
			specWarnTouchInsignificance:Play("stackhigh")
		else
			warnTouchInsignificance:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 70842 then
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		if self:IsDifficulty("normal10", "normal25") then
			timerAdds:Cancel()
			warnAddsSoon:Cancel()
			self:Unschedule(addsTimer)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 71420 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFrostbolt:Show(args.sourceName)
		specWarnFrostbolt:Play("kickcast")
	elseif args.spellId == 70900 then
		warnDarkTransformation:Show()
		if self.Options.SetIconOnDeformedFanatic then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnDeformedFanatic")
		end
	elseif args.spellId == 70901 then
		warnDarkEmpowerment:Show()
		if self.Options.SetIconOnEmpoweredAdherent then
			self:ScanForMobs(args.sourceGUID, 2, 7, 1, nil, 12, "SetIconOnEmpoweredAdherent")
		end
	elseif args.spellId == 71236 and not self:IsTrivial() then
		specWarnDarkMartyrdom:Show()
		specWarnDarkMartyrdom:Play("justrun")
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 71426 and self:AntiSpam(5, 1) then -- Summon Vengeful Shade
		warnSummonSpirit:Show()
		timerSummonSpiritCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellReanimatedFanatic or msg:find(L.YellReanimatedFanatic) then
		warnReanimating:Show()
	end
end
