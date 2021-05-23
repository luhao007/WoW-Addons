local mod	= DBM:NewMod(2439, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210513011606")
mod:SetCreatureID(175726)--Skyja (TODO, add other 2 and set health to highest?)
mod:SetEncounterID(2429)
mod:SetUsedIcons(8, 7, 6, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(20210512000000)--2021-05-12
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350202 350342 350339 350365 350283 350385 350467 352744 350541 350482 350687 350475 355294",
	"SPELL_CAST_SUCCESS 350286",
	"SPELL_AURA_APPLIED 350202 350158 350109 351139 350039 350542 350184",
	"SPELL_AURA_APPLIED_DOSE 350202 350542",
	"SPELL_AURA_REMOVED 350158 350109 351139 350039 350542 350184",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, tank swap stacks
--TODO, how many formless mass spawn in higher difficulties? Find out total needed icons
--TODO, marking anything else??
--TODO, total fragments/icons needed on each difficulty
--TODO, fragments spellId used (cast/timer)
--TODO, figure out fancy shit for the raid icons for player jumps, if jump has sourcename then pull icons from sourcename and move same icon to dest name in same action (unless they already have an icon)
--TODO, pretty sure journal is a mess regarding word of Recall so handling in this mod is assumed and needs vetting.
--Stage One: The Unending Voice
----Kyra, The Unending
local warnUnendingStrike						= mod:NewStackAnnounce(350202, 2, nil, "Tank|Healer")
----Signe, The Voice
--local warnBloodLantern						= mod:NewTargetNoFilterAnnounce(341684, 2)
----Skyja, The First
local warnCalloftheValkyr						= mod:NewCountAnnounce(350467, 3)
local warnAnnhyldesBrightAegis					= mod:NewTargetNoFilterAnnounce(350158, 2, nil, "Tank")
local warnDaschlasMightyAnvil					= mod:NewTargetNoFilterAnnounce(350184, 2)
local warnBrynjasMournfulDirge					= mod:NewTargetNoFilterAnnounce(350109, 2)
local warnArthurasCrushingGaze					= mod:NewTargetNoFilterAnnounce(350039, 3)
local warnFragmentsofDestiny					= mod:NewTargetNoFilterAnnounce(350542, 3)
local warnFragmentsofDestinyStack				= mod:NewCountAnnounce(350542, 2)
--Stage Two: The First of the Mawsworn
local warnPierceSoul							= mod:NewStackAnnounce(350475, 2, nil, "Tank|Healer")
local warnResentment							= mod:NewCountAnnounce(355294, 3)
local warnLinkEssence							= mod:NewTargetAnnounce(350482, 3)

--Stage One: The Unending Voice
----Kyra, The Unending
local specWarnUnendingStrike					= mod:NewSpecialWarningStack(350202, nil, 3, nil, nil, 1, 6)
local specWarnUnendingStrikeTaunt				= mod:NewSpecialWarningTaunt(350202, nil, nil, nil, 1, 2)
local specWarnFormlessMass						= mod:NewSpecialWarningSwitchCount(342077, "Dps", nil, nil, 1, 2)
local specWarnSiphonVitality					= mod:NewSpecialWarningInterruptCount(350339, "HasInterrupt", nil, nil, 1, 2)
local specWarnWingsofRage						= mod:NewSpecialWarningRun(350365, nil, nil, nil, 4, 2)
----Signe, The Voice
local specWarnSoulfulBlast						= mod:NewSpecialWarningInterrupt(350283, false, nil, nil, 1, 2)--Opt in, only some should be doing this one, plus it's spammy as hell
local specWarnSongofDissolution					= mod:NewSpecialWarningInterrupt(350286, "HasInterrupt", nil, nil, 1, 2)
local specWarnReverberatingRefrain				= mod:NewSpecialWarningMoveTo(350385, nil, nil, nil, 3, 2)
----Skyja, The First
------Call of the Val'kyr
local specWarnAgathasEternalblade				= mod:NewSpecialWarningDodge(350031, nil, nil, nil, 2, 2)
local specWarnDaschlasMightyAnvil				= mod:NewSpecialWarningMoveAway(350184, nil, nil, nil, 1, 2)
local yellDaschlasMightyAnvil					= mod:NewShortYell(350184)
local yellDaschlasMightyAnvilFades				= mod:NewShortFadesYell(350184)
local specWarnAradnesFallingStrike				= mod:NewSpecialWarningSoak(350098, nil, nil, nil, 1, 2)
local specWarnBrynjasMournfulDirge				= mod:NewSpecialWarningMoveAway(350109, nil, nil, nil, 1, 2)
local yellBrynjasMournfulDirge					= mod:NewShortYell(350109)
local yellBrynjasMournfulDirgeFades				= mod:NewShortFadesYell(350109)
local specWarnArthurasCrushingGaze				= mod:NewSpecialWarningMoveTo(350039, nil, nil, nil, 3, 2)
local yellArthurasCrushingGaze					= mod:NewYell(350039, nil, nil, nil, "YELL")
local yellArthurasCrushingGazeFades				= mod:NewShortFadesYell(350039, nil, nil, nil, "YELL")
------End Valks
local specWarnFragmentsofDestiny				= mod:NewSpecialWarningMoveAway(350542, nil, nil, nil, 1, 2)
local yellFragmentsofDestiny					= mod:NewShortYell(350542)--TODO, probably change to icon/numbered yell system based on icon/combatlog order
--Stage Two: The First of the Mawsworn
local specWarnPierceSoul						= mod:NewSpecialWarningStack(350475, nil, 4, nil, nil, 1, 6)
local specWarnPierceSoulTaunt					= mod:NewSpecialWarningTaunt(350475, nil, nil, nil, 1, 2)
local specWarnLinkEssence						= mod:NewSpecialWarningYou(350482, nil, nil, nil, 1, 2, 3)
local specWarnWordofRecall						= mod:NewSpecialWarningSpell(350687, nil, nil, nil, 2, 2, 3)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: The Unending Voice
----Kyra, The Unending
local timerUnendingStrikeCD						= mod:NewCDTimer(7.3, 350202, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerFormlessMassCD						= mod:NewCDCountTimer(47.4, 342077, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerWingsofRageCD						= mod:NewCDCountTimer(72.9, 350365, nil, nil, nil, 2)
----Signe, The Voice
local timerSongofDissolutionCD					= mod:NewCDCountTimer(19.4, 350286, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)--19.4-25.5 (unless delayed massivley by another channel)
local timerReverberatingRefrainCD				= mod:NewCDCountTimer(74.2, 350385, nil, nil, nil, 2)
----Skyja, The First
local timerCalloftheValkyrCD					= mod:NewCDCountTimer(72.9, 350467, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerFragmentsofDestinyCD					= mod:NewCDTimer(23, 350541, nil, nil, nil, 3, nil, nil, nil, 2, 3)
--Stage Two: The First of the Mawsworn
local timerPierceSoulCD							= mod:NewCDTimer(9.7, 350475, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerResentmentCD							= mod:NewCDCountTimer(7.6, 355294, nil, nil, nil, 2)--7.6-9.7
local timerLinkEssenceCD						= mod:NewAITimer(23, 350482, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)--ADD count when not AI and cd long enough
local timerWordofRecallCD						= mod:NewAITimer(23, 350687, nil, nil, nil, 2, nil, DBM_CORE_L.HEROIC_ICON)--ADD count when not AI and cd long enough

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(350365, true)
mod:AddSetIconOption("SetIconOnFragments", 350542, true, false, {1, 2, 3, 4})--Mythic says max 4, so probably the cap
mod:AddSetIconOption("SetIconOnFormlessMass", 342077, true, true, {7, 8, 6})
mod:AddNamePlateOption("NPAuraOnBrightAegis", 350158)

local castsPerGUID = {}
mod.vb.phase = 1
--mod.vb.addIcon = 8
mod.vb.valkCount = 0
mod.vb.fragmentsIcon = 1
mod.vb.resentmentCount = 0
mod.vb.massCount = 0
mod.vb.wingCount = 0
mod.vb.songCount = 0
mod.vb.refrainCount = 0
mod.vb.recallCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.phase = 1
--	self.vb.addIcon = 8
	self.vb.valkCount = 0
	self.vb.resentmentCount = 0
	self.vb.massCount = 0
	self.vb.songCount = 0
	self.vb.refrainCount = 0
	self.vb.recallCount = 0
	--Kyra
	timerUnendingStrikeCD:Start(7-delay)
	timerFormlessMassCD:Start(12-delay, 1)
	timerWingsofRageCD:Start(47.6-delay, 1)
	--Signe
	timerSongofDissolutionCD:Start(18.3-delay, 1)
	timerReverberatingRefrainCD:Start(71.7-delay, 1)--71.7-76
	--Skyja
	timerCalloftheValkyrCD:Start(14.1-delay, 1)--14.1
	if self:IsHard() then--Journal says mythic, but it's been wrong on earlier testing, leaving this here for now
		timerFragmentsofDestinyCD:Start(1-delay)
	end
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnBrightAegis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnBrightAegis then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350202 then
		timerUnendingStrikeCD:Start()
	elseif spellId == 350342 then
--		self.vb.addIcon = 8
		self.vb.massCount = self.vb.massCount + 1
		specWarnFormlessMass:Show(self.vb.massCount)
		specWarnFormlessMass:Play("killmob")
		timerFormlessMassCD:Start(nil, self.vb.massCount+1)
		if self.Options.SetIconOnFormlessMass then--Only use up to 5 icons
			self:ScanForMobs(177407, 0, 8, 2, 0.2, 12, "SetIconOnFormlessMass")
		end
	elseif spellId == 350339 then
--		if not castsPerGUID[args.sourceGUID] then
--			castsPerGUID[args.sourceGUID] = 0
--			if self.Options.SetIconOnFormlessMass and self.vb.addIcon > 3 then--Only use up to 5 icons
--				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12, "SetIconOnFormlessMass")
--			end
--			self.vb.addIcon = self.vb.addIcon - 1
--		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnSiphonVitality:Show(args.sourceName, count)
			if count == 1 then
				specWarnSiphonVitality:Play("kick1r")
			elseif count == 2 then
				specWarnSiphonVitality:Play("kick2r")
			elseif count == 3 then
				specWarnSiphonVitality:Play("kick3r")
			elseif count == 4 then
				specWarnSiphonVitality:Play("kick4r")
			elseif count == 5 then
				specWarnSiphonVitality:Play("kick5r")
			else
				specWarnSiphonVitality:Play("kickcast")
			end
		end
	elseif spellId == 350365 then
		self.vb.wingCount = self.vb.wingCount + 1
		specWarnWingsofRage:Show()
		specWarnWingsofRage:Play("justrun")
		timerWingsofRageCD:Start(nil, self.vb.wingCount+1)
	elseif spellId == 350283 and self:CheckInterruptFilter(args.sourceGUID, false, false) then
		specWarnSoulfulBlast:Show(args.sourceName)
		specWarnSoulfulBlast:Play("kickcast")
	elseif spellId == 350385 then
		self.vb.refrainCount = self.vb.refrainCount + 1
		specWarnReverberatingRefrain:Show(args.sourceName)
		specWarnReverberatingRefrain:Play("findshelter")
		timerReverberatingRefrainCD:Start(nil, self.vb.refrainCount+1)
	elseif spellId == 350467 then
		self.vb.valkCount = self.vb.valkCount + 1
		warnCalloftheValkyr:Show(self.vb.valkCount)
		timerCalloftheValkyrCD:Start(nil, self.vb.valkCount+1)
	elseif spellId == 352744 or spellId == 350541 then
		self.vb.fragmentsIcon = 1
		timerFragmentsofDestinyCD:Start()
	elseif spellId == 350482 then
		timerLinkEssenceCD:Start()
	elseif spellId == 350687 then
		self.vb.recallCount = self.vb.recallCount + 1
		specWarnWordofRecall:Show(self.vb.recallCount)
		specWarnWordofRecall:Play("specialsoon")
		timerWordofRecallCD:Start()--self.vb.recallCount+1
	elseif spellId == 350475 then
		timerPierceSoulCD:Start()
	elseif spellId == 355294 then
		self.vb.resentmentCount = self.vb.resentmentCount + 1
		warnResentment:Show(self.vb.resentmentCount)
		timerResentmentCD:Start(nil, self.vb.resentmentCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350286 then
		self.vb.songCount = self.vb.songCount + 1
		timerSongofDissolutionCD:Start(nil, self.vb.songCount+1)
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnSongofDissolution:Show(args.sourceName)
			specWarnSongofDissolution:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 350202 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnUnendingStrike:Show(amount)
				specWarnUnendingStrike:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnUnendingStrikeTaunt:Show(args.destName)
					specWarnUnendingStrikeTaunt:Play("tauntboss")
				else
					warnUnendingStrike:Show(args.destName, amount)
				end
			end
		else
			warnUnendingStrike:Show(args.destName, amount)
		end
	elseif spellId == 350475 then
		local amount = args.amount or 1
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnPierceSoul:Show(amount)
				specWarnPierceSoul:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnPierceSoulTaunt:Show(args.destName)
					specWarnPierceSoulTaunt:Play("tauntboss")
				else
					warnUnendingStrike:Show(args.destName, amount)
				end
			end
		else
			warnUnendingStrike:Show(args.destName, amount)
		end
	elseif spellId == 350158 then
		warnAnnhyldesBrightAegis:CombinedShow(0.3, args.destName)
		if self.Options.NPAuraOnBrightAegis then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350109 or spellId == 351139 then--Ones probably normal/LFR and other heroic/mythic (350109 LFR confirmed)
		warnBrynjasMournfulDirge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBrynjasMournfulDirge:Show()
			specWarnBrynjasMournfulDirge:Play("runout")
			yellBrynjasMournfulDirge:Yell()
			yellBrynjasMournfulDirgeFades:Countdown(spellId)
		end
	elseif spellId == 350039 then
		if args:IsPlayer() then
			specWarnArthurasCrushingGaze:Show(DBM_CORE_L.ALLIES)
			specWarnArthurasCrushingGaze:Play("gathershare")
			yellArthurasCrushingGaze:Yell()
			yellArthurasCrushingGazeFades:Countdown(spellId)
		else
			warnArthurasCrushingGaze:Show(args.destName)
		end
	elseif spellId == 350542 then
		local icon = self.vb.fragmentsIcon
		local amount = args.amount or 1
		if args:IsSrcTypeHostile() and amount == 1 then--Initial application from boss only
			if self.Options.SetIconOnFragments then
				self:SetIcon(args.destName, icon)
			end
			if args:IsPlayer() then
				specWarnFragmentsofDestiny:Show()
				specWarnFragmentsofDestiny:Play("targetyou")
				yellFragmentsofDestiny:Yell()--icon, icon
			end
			warnFragmentsofDestiny:CombinedShow(0.3, args.destName)
			self.vb.fragmentsIcon = self.vb.fragmentsIcon + 1
		else
			--TODO, icon movement code moving source persons icon to dest person if combat log is cooperative
			if args:IsPlayer() then
				warnFragmentsofDestinyStack:Show(amount)
			end
		end
	elseif spellId == 350482 then
		warnLinkEssence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLinkEssence:Show()
			specWarnLinkEssence:Play("targetyou")
		end
	elseif spellId == 350184 then
		warnDaschlasMightyAnvil:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDaschlasMightyAnvil:Show()
			specWarnDaschlasMightyAnvil:Play("watchstep")
			yellDaschlasMightyAnvil:Yell()
			yellDaschlasMightyAnvilFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350158 then
		if self.Options.NPAuraOnBrightAegis then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350109 or spellId == 351139 then--Ones probably normal/LFR and other heroic/mythic
		if args:IsPlayer() then
			yellBrynjasMournfulDirgeFades:Cancel()
		end
	elseif spellId == 350039 then
		if args:IsPlayer() then
			yellArthurasCrushingGazeFades:Cancel()
		end
	elseif spellId == 350542 then
		if args:IsSrcTypeHostile() then--Initial application from boss only
			if self.Options.SetIconOnFragments then
				self:SetIcon(args.destName, 0)
			end
		end
	elseif spellId == 350184 then
		if args:IsPlayer() then
			yellDaschlasMightyAnvilFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177407 then--Formless Mass
		castsPerGUID[args.destGUID] = nil
	elseif cid == 177095 then--Kyra
		timerUnendingStrikeCD:Stop()
		timerFormlessMassCD:Stop()
		timerWingsofRageCD:Stop()
	elseif cid == 177094 then--Signe
		timerSongofDissolutionCD:Stop()
		timerReverberatingRefrainCD:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	--"<22.56 20:59:16> [CHAT_MSG_MONSTER_YELL] Fall before my blade!#Agatha#####0#0##0#1227#nil#0#false#false#false#false", -- [821]
	if msg == L.AgathaBlade or msg:find(L.AgathaBlade) then
		specWarnAgathasEternalblade:Show()
		specWarnAgathasEternalblade:Play("farfromline")
	--"<240.03 21:02:54> [CHAT_MSG_MONSTER_YELL] You are all outmatched!#Aradne#####0#0##0#1273#nil#0#false#false#false#false", -- [4657]
	elseif msg == L.AradneStrike or msg:find(L.AradneStrike) then
		specWarnAradnesFallingStrike:Show()
		specWarnAradnesFallingStrike:Play("helpsoak")
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 350745 then--Maw Power (Set to 00)  [DNT]
		self.vb.phase = 2
		timerCalloftheValkyrCD:Stop()
		timerResentmentCD:Start(6.9, 1)
		timerPierceSoulCD:Start(8.9)
		timerCalloftheValkyrCD:Start()
		if self:IsHard() then
			timerFragmentsofDestinyCD:Stop()
			timerFragmentsofDestinyCD:Start()
			timerLinkEssenceCD:Start(2)
			timerWordofRecallCD:Start(2)--self.vb.recallCount
		end
	end
end

