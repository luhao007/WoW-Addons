local mod	= DBM:NewMod(870, "DBM-Raids-MoP", 1, 369)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic,lfr"

mod:SetRevision("20241103134004")
mod:SetCreatureID(73720, 71512)
mod:SetEncounterID(1594)
mod:DisableESCombatDetection()
mod:SetZone(1136)

--Can use IEEU to engage now, it's about 4 seconds slower but better than registering an out of combat CLEU event in entire zone.
--"<10.8 23:23:13> [CLEU] SPELL_CAST_SUCCESS#false#0xF13118D10000674F#Secured Stockpile of Pandaren Spoils#2632#0##nil#-2147483648#-2147483648#145687#Unstable Defense Systems#1", -- [169]
--"<14.2 23:23:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Mogu Spoils#0xF1311FF800006750#elite#1#1#1#Mantid Spoils#0xF131175800006752
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 145996 145288 142934 142539 145286 146222 146180 145489 142947 146815",
	"SPELL_CAST_SUCCESS 142947 145712 146253 145230 145786 145812",
	"SPELL_AURA_APPLIED 145987 145692",
	"SPELL_AURA_REMOVED 145987 145692",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"UPDATE_UI_WIDGET"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnSuperNova				= mod:NewCastAnnounce(146815, 4, nil, nil, false)--Heroic
--Massive Crate of Goods
----Mogu
local warnReturnToStone			= mod:NewSpellAnnounce(145489, 2)
----Mantid
local warnSetToBlow				= mod:NewTargetAnnounce(145987, 4)--145996 is cast ID
--Stout Crate of Goods
----Mogu
local warnForbiddenMagic		= mod:NewTargetAnnounce(145230, 2)
local warnTorment				= mod:NewSpellAnnounce(142934, 3, nil, "Healer")
----Mantid
local warnWindStorm				= mod:NewSpellAnnounce(145286, 3)
--Crate of Pandaren Relics
local warnBreathofFire			= mod:NewSpellAnnounce(146222, 3)--Do not have timer for this yet, add not alive long enough.

--Massive Crate of Goods
local specWarnSetToBlowYou		= mod:NewSpecialWarningYou(145987, nil, nil, nil, 1, 2)
local specWarnSetToBlow			= mod:NewSpecialWarningPreWarn(145996, nil, 4, nil, 3, 2)
--Stout Crate of Goods
----Mogu
local specWarnForbiddenMagic	= mod:NewSpecialWarningInterrupt(145230, "HasInterrupt", nil, nil, 1, 2)
local specWarnMatterScramble	= mod:NewSpecialWarningSoak(145288, nil, nil, nil, 2, 2)
local specWarnCrimsonRecon		= mod:NewSpecialWarningMove(142947, "Tank", nil, nil, 3, 2)
----Mantid
local specWarnMantidSwarm		= mod:NewSpecialWarningSpell(142539, "Tank", nil, nil, 1, 2)
local specWarnResidue			= mod:NewSpecialWarningSpell(145786, "MagicDispeller", nil, nil, 1, 2)
local specWarnRageoftheEmpress	= mod:NewSpecialWarningSpell(145812, "MagicDispeller", nil, nil, 1, 2)
local specWarnEnrage			= mod:NewSpecialWarningDispel(145692, "RemoveEnrage", nil, nil, 1, 2)--Question is, do we want to dispel it? might make this off by default since kiting it may be more desired than dispeling it
--Lightweight Crate of Goods
----Mantid
local specWarnGTFO				= mod:NewSpecialWarningGTFO(145716, nil, nil, nil, 1, 8)
--Crate of Pandaren Relics
local specWarnGustingCraneKick	= mod:NewSpecialWarningSpell(146180, "Melee", nil, nil, 2, 2)

local timerCombatStarts			= mod:NewCombatTimer(18)
--Massive Crate of Goods
local timerReturnToStoneCD		= mod:NewNextTimer(11.7, 145489)
local timerSetToBlowCD			= mod:NewNextTimer(9.6, 145996, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSetToBlow			= mod:NewBuffFadesTimer(30, 145996, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)
--Stout Crate of Goods
local timerMatterScramble		= mod:NewCastTimer(7, 145288, nil, "-Tank")
local timerMatterScrambleCD		= mod:NewCDTimer(14.1, 145288, nil, nil, nil, 5)--Old note invalid, unknown newer variation with wod prepatch rework
local timerCrimsonReconCD		= mod:NewNextTimer(15, 142947, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerMantidSwarmCD		= mod:NewCDTimer(15.7, 142539, nil, nil, nil, 1)
local timerResidueCD			= mod:NewCDTimer(18, 145786, nil, "MagicDispeller", nil, 5)
local timerWindstormCD			= mod:NewCDTimer(15.7, 145286, nil, false)--Spammy but might be useful to some, if they aren't releasing a ton of these at once.
local timerRageoftheEmpressCD	= mod:NewCDTimer(18, 145812, nil, "MagicDispeller", nil, 5)
--Lightweight Crate of Goods
----Most of these timers are included simply because of how accurate they are. Predictable next timers. However, MANY of these adds up at once.
----They are off by default and a user elected choice to possibly pick one specific timer they are in charge of dispeling/interrupting or whatever
local timerEnrage				= mod:NewTargetTimer(10, 145692)
local timerBlazingChargeCD		= mod:NewNextTimer(12, 145712, nil, false)
--Crate of Pandaren Relics
local timerGustingCraneKickCD	= mod:NewCDTimer(18, 146180, nil, nil, nil, 2)
local timerPathOfBlossomsCD		= mod:NewCDTimer(15, 146253, nil, nil, nil, 3)

--Berserk Timer stuff
local berserkTimer				= mod:NewTimer(480, DBM_CORE_L.GENERIC_TIMER_BERSERK, 28131, nil, "timer_berserk")
local berserkWarning1			= mod:NewAnnounce(DBM_CORE_L.GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
local berserkWarning2			= mod:NewAnnounce(DBM_CORE_L.GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)

mod:AddRangeFrameOption(10, 145987)
mod:AddInfoFrameOption(-8350)--Eh, "overview" works.

--Upvales, don't need variables
local select, tonumber, UnitPosition = select, tonumber, UnitPosition
--Not important, don't need to recover
local worldTimer = 0
local maxTimer = 0

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	worldTimer = 0
	maxTimer = 0
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.name)
		DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
	end
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 145716 145748 146257",
			"SPELL_MISSED 145716 145748 146257"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 145996 then
		timerSetToBlowCD:Start(nil, args.sourceGUID)
	elseif spellId == 145288 then
		if self:AntiSpam(3, 1) then
			specWarnMatterScramble:Show()
			specWarnMatterScramble:Play("helpsoak")
		end
		timerMatterScramble:Start(nil, args.sourceGUID)
		timerMatterScrambleCD:Start(nil, args.sourceGUID)
	elseif spellId == 142934 then
		warnTorment:Show()
	elseif spellId == 142539 then
		specWarnMantidSwarm:Show()
		specWarnMantidSwarm:Play("mobsoon")
		timerMantidSwarmCD:Start(nil, args.sourceGUID)
	elseif spellId == 145286 and self:AntiSpam(5, args.sourceGUID) then
		warnWindStorm:Show()
		timerWindstormCD:Start(nil, args.sourceGUID)
	elseif spellId == 146222 and self:CheckBossDistance(args.sourceGUID, true, 1180, 33) then--Relics can be either side, must use boss Distance
		warnBreathofFire:Show()
	elseif spellId == 146180 and self:CheckBossDistance(args.sourceGUID, true, 1180, 33) then--Also a Relic
		specWarnGustingCraneKick:Show()
		specWarnGustingCraneKick:Play("whirlwind")
		timerGustingCraneKickCD:Start(nil, args.sourceGUID)
	elseif spellId == 145489 then
		warnReturnToStone:Show()
		timerReturnToStoneCD:Start(nil, args.sourceGUID)
	elseif spellId == 142947 then--Pre warn more or less
		specWarnCrimsonRecon:Show()
		specWarnCrimsonRecon:Play("moveboss")
	elseif spellId == 146815 and self:AntiSpam(2, 2)then
		warnSuperNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 142947 then
		timerCrimsonReconCD:Start(nil, args.sourceGUID)
	elseif spellId == 145712 then
		timerBlazingChargeCD:Start(nil, args.sourceGUID)
	elseif spellId == 146253 then
		timerPathOfBlossomsCD:Start(nil, args.sourceGUID)
	elseif spellId == 145230 then
		if self:AntiSpam(5, args.destName) then
			warnForbiddenMagic:CombinedShow(1, args.destName)
		end
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnForbiddenMagic:Show(args.sourceName)
			specWarnForbiddenMagic:Play("kickcast")
		end
	elseif spellId == 145786 then
		timerResidueCD:Start(nil, args.sourceGUID)
		specWarnResidue:Show()
		specWarnResidue:Play("dispelboss")
	elseif spellId == 145812 then
		specWarnRageoftheEmpress:Show()
		specWarnRageoftheEmpress:Play("dispelboss")
		timerRageoftheEmpressCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 145987 then
		warnSetToBlow:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			local _, _, _, _, _, expires = DBM:UnitDebuff("player", args.spellName)
			local buffTime = expires-GetTime()
			timerSetToBlow:Start(buffTime)
			specWarnSetToBlow:Schedule(buffTime)
			specWarnSetToBlow:ScheduleVoice(buffTime, "runout")
		end
	elseif spellId == 145692 then
		specWarnEnrage:Show(args.destName)
		specWarnEnrage:Play("enrage")
		timerEnrage:Start(nil, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 145987 and args:IsPlayer() then
		timerSetToBlow:Cancel()
		specWarnSetToBlow:Cancel()
		specWarnSetToBlow:CancelVoice()
	elseif spellId == 145692 then
		timerEnrage:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 145716 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 145748 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 146257 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71408 then--Shao-Tien Colossus
		timerReturnToStoneCD:Cancel(args.destGUID)
	elseif cid == 71409 then--Ka'thik Demolisher
		timerSetToBlowCD:Cancel(args.destGUID)
	elseif cid == 71395 then--Modified Anima Golem
		timerMatterScramble:Cancel(args.sourceGUID)
		timerMatterScrambleCD:Cancel(args.destGUID)
		timerCrimsonReconCD:Cancel(args.destGUID)
	elseif cid == 71397 then--Ka'thik Swarmleader
		timerMantidSwarmCD:Cancel(args.destGUID)
		timerResidueCD:Cancel(args.destGUID)
	elseif cid == 71405 then--Ka'thik Wind Wielder
		timerWindstormCD:Cancel(args.destGUID)
		timerRageoftheEmpressCD:Cancel(args.destGUID)
	elseif cid == 71385 then--Ka'thik Bombardier
		timerBlazingChargeCD:Cancel(args.destGUID)
	elseif cid == 72810 then--Wise Mistweaver Spirit
		timerGustingCraneKickCD:Cancel(args.destGUID)
	elseif cid == 72828 then--Nameless Windwalker Spirit
		timerPathOfBlossomsCD:Cancel(args.destGUID)
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:146364") then
		specWarnSetToBlowYou:Show()
		specWarnSetToBlowYou:Play("bombyou")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)--Range assumed, spell tooltips not informative enough
			self:Schedule(32, hideRangeFrame)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	end
end

function mod:UPDATE_UI_WIDGET(table)
	local id = table.widgetID
	if id ~= 746 then return end
	local widgetInfo = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(id)
	if widgetInfo and widgetInfo.text then
		local text = widgetInfo.text
		local time = tonumber(string.match(text or "", "%d+"))
		if not time then return end
		if time > worldTimer then
			maxTimer = time
			berserkTimer:Cancel()
			berserkTimer:Start(time+1)
		end
		if time % 10 == 0 then
			berserkTimer:Update(maxTimer-time-1, maxTimer)
			if time == 300 and self.Options["timer_berserk"] and self:AntiSpam(2, 5) then
				berserkWarning1:Show(5, DBM_CORE_L.MIN)
			elseif time == 180 and self.Options["timer_berserk"] and self:AntiSpam(2, 5) then
				berserkWarning1:Show(3, DBM_CORE_L.MIN)
			elseif time == 60 and self.Options["timer_berserk"] and self:AntiSpam(2, 5) then
				berserkWarning2:Show(1, DBM_CORE_L.MIN)
			elseif time == 30 and self.Options["timer_berserk"] and self:AntiSpam(2, 5) then
				berserkWarning2:Show(30, DBM_CORE_L.SEC)
			elseif time == 10 and self.Options["timer_berserk"] and self:AntiSpam(2, 5) then
				berserkWarning2:Show(10, DBM_CORE_L.SEC)
			end
		end
		worldTimer = time
	end
end

function mod:OnSync(msg)
	if msg == "prepull" then
		timerCombatStarts:Start()
	end
end
