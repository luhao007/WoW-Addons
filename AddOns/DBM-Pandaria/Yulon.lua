local mod	= DBM:NewMod(858, "DBM-Pandaria", nil, 322, 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240522024721")
mod:SetCreatureID(71955)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144530",
	"SPELL_DAMAGE 144538",
	"SPELL_MISSED 144538",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local specWarnJadefireBreath	= mod:NewSpecialWarningSpell(144530, nil, nil, nil, 1, 2)
local specWarnJadefireWall		= mod:NewSpecialWarningDodge(144533, nil, nil, nil, 2, 2)
local specWarnGTFO				= mod:NewSpecialWarningGTFO(144538, nil, nil, nil, 1, 8)

local timerJadefireBreathCD		= mod:NewCDTimer(17.3, 144530, nil, "Tank", nil, 5)
local timerJadefireWallCD		= mod:NewNextTimer(60, 144533, nil, nil, nil, 3)

mod:AddRangeFrameOption(11, 144532)
mod:AddReadyCheckOption(33117, false, 90)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		timerJadefireBreathCD:Start(6-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(11)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144530 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnJadefireBreath:Show()
			specWarnJadefireBreath:Play("breathsoon")
		end
		timerJadefireBreathCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 144538 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Wave1 or msg == L.Wave2 or msg == L.Wave3 then
		self:SendSync("Wave")
	end
end

--This method works without local and doesn't fail with curse of tongs but requires at least ONE person in raid targeting boss to be running dbm (which SHOULD be most of the time)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 148318 or spellId == 148317 or spellId == 149304 and self:AntiSpam(3, 2) then--use all 3 because i'm not sure which ones fire on repeat kills
		self:SendSync("Victory")
	end
end

function mod:OnSync(msg)
	if msg == "Victory" and self:IsInCombat() then
		DBM:EndCombat(self)
	elseif msg == "Wave" and self:IsInCombat() then
		specWarnJadefireWall:Show()
		specWarnJadefireWall:Play("watchstep")
		timerJadefireWallCD:Start()
	end
end
